#!/usr/bin/env python3
import sys
import os
import dataclasses
import struct
import typing
import argparse
import yaml	# requires "PyYAML" pip package


@dataclasses.dataclass
class ParamToken:
	type: int	# token type
	data: typing.Union[int, str]	# token data
	pos: int	# start position on current line
	cmdOfs: typing.Optional[int] = None	# relative command offset (for label references)

@dataclasses.dataclass
class CommandItem:
	asmFile: str	# file name of the original ASM file
	lineID: int		# line ID in original ASM file
	cmdName: str	# command name (uppercase)
	params: list = dataclasses.field(default_factory=list)	# parameters

@dataclasses.dataclass
class LabelItem:
	cmdID: int		# ID of the command (index into cmd_list) that the label points to
	asmFile: str	# file name of the original ASM file
	lineID: int		# line ID in original ASM file
	lblName: str	# original label name


TKTP_INT = 0x01	# integer number (byte/word/dword)
TKTP_STR = 0x02	# string
TKTP_NAME = 0x80	# register or label name
TKTP_REG = 0x81	# register
TKTP_LBL = 0x82	# label name

DTYPE_NONE = 0
DTYPE_STR = 1
DTYPE_FNAME = 2

UNESCAPE_TBL = {
	'\\': '\\',	# backslash (5C)
	"'": "'",	# single quote (27)
	'"': '"',	# double quote (22)
	'a': '\a',	# bell (07)
	'b': '\b',	# backspace (08)
	't': '\t',	# horizontal tab (09)
	'n': '\n',	# new line/linefeed (0A)
	'v': '\v',	# vertical tab (0B)
	'f': '\f',	# formfeed (0C)
	'r': '\r',	# carriage return (0D)
}
TOKEN_ALPHABET = [chr(x) for x in \
	[x for x in range(0x30, 0x3A)] + \
	[x for x in range(0x41, 0x5B)] + \
	[x for x in range(0x61, 0x7B)]] + ["_"]
KEYWORDS = {
	"INCLUDE",	# include other ASM file
	"DESC",	# module description: UTF-8 string to be encoded as Shift-JIS
	"DB",	# data: bytes or ASCII strings
	"DW",	# data: words
	"DS",	# data: bytes or UTF-8 strings to be encoded as Shift-JIS
	"DSJ",	# data: JIS code words, to be encoded as Shift-JIS
}

config = {}
textbox_data = {}


def find_next_token(line: str, startpos: int) -> int:
	pos = startpos
	while pos < len(line) and line[pos].isspace():
		pos += 1
	return pos

def get_token_str(line: str, startpos: int) -> typing.Tuple[int, str, int]:
	start_chr = line[startpos]
	did_close = False
	pos = startpos + 1
	result = ""
	while pos < len(line):
		if line[pos] == '\\':
			pos += 1
			if pos >= len(line):
				return None
			esc_chr = line[pos]
			pos += 1
			if esc_chr in UNESCAPE_TBL:
				result += UNESCAPE_TBL[esc_chr]
			elif esc_chr == 'x':    # 'x' + 2-digit hex number
				if pos + 2 > len(line):
					return None
				result += chr(int(line[pos : pos+2], 0x10))
				pos += 2
			elif esc_chr == 'u':    # 'u' + 4-digit hex number
				if pos + 4 > len(line):
					return None
				result += chr(int(line[pos : pos+4], 0x10))
				pos += 4
			elif esc_chr == 'U':    # 'U' + 8-digit hex number
				if pos + 8 > len(line):
					return None
				result += chr(int(line[pos : pos+8], 0x10))
				pos += 8
			elif esc_chr.isdigit(): # character with octal code
				pos2 = pos
				while (pos2 < len(line)) and (pos2 < pos + 3):
					if not line[pos2].isdigit():
						break
				if pos2 == pos:
					return None
				result += chr(int(line[pos : pos2], 0o10))
				pos = pos2
			else:
				return None	# invalid escape sequence
		elif line[pos] == start_chr:
			did_close = True
			pos += 1
			break
		else:
			result += line[pos]
			pos += 1
	if not did_close:
		return None	# string was not terminated properly
	return (TKTP_STR, result, pos)	# return parsed string without quotes

def get_token_int(line: str, startpos: int) -> typing.Tuple[int, int, int]:
	pos = startpos
	while pos < len(line):
		if not line[pos].isalnum():
			break
		pos += 1
	result = line[startpos : pos]
	try:
		return (TKTP_INT, int(result, 0), pos)	# return value as integer
	except:
		return None	# handle parse error

def get_token_name(line: str, startpos: int, space_split: bool = False) -> typing.Tuple[int, str, int]:
	pos = startpos
	while pos < len(line):
		if line[pos].isspace():
			break
		if (not space_split) and (line[pos] not in TOKEN_ALPHABET):
			break
		pos += 1
	return (TKTP_NAME, line[startpos : pos], pos)

# returns [int tokenType, int/str tokenData, int linePos]
def get_token(line: str, startpos: int, space_split: bool = False) -> typing.Tuple[int, typing.Any, int]:
	if startpos >= len(line):
		return None
	
	pos = startpos
	if line[pos] == '"':
		return get_token_str(line, startpos)
	elif line[pos].isdecimal():
		return get_token_int(line, startpos)
	elif line[pos].isalpha():
		return get_token_name(line, startpos, space_split)
	else:
		return None

def parse_asm(lines: typing.List[str], asm_filename: str) -> typing.Tuple[list, list]:
	cmd_list = []	# list[ CommandItem ]
	label_list = {}	# dict{ label name [casefold]: LabelItem }
	
	for (lid, line) in enumerate(lines):
		line = line.rstrip()
		lstr = line.lstrip()
		if len(lstr) == 0 or lstr.startswith(';'):
			continue	# empty line or comment
		
		startpos = len(line) - len(lstr)
		if startpos == 0:
			# label
			pos = line.find(':')
			if pos < 0:
				print(f"Parse error in {asm_filename}:{1+lid}: Label without colon")
				return None
			label_name = line[0:pos]
			lbl_nm_cf = label_name.casefold()
			if lbl_nm_cf in label_list:
				print(f"Parse error in {asm_filename}:{1+lid}: Label '{label_name}' is already defined")
				return None
			label_list[lbl_nm_cf] = LabelItem(cmdID=len(cmd_list), asmFile=asm_filename, lineID=lid, lblName=label_name)
			startpos = pos + 1
		startpos = find_next_token(line, startpos)
		if startpos >= len(line) or line[startpos] == ';':
			continue
		
		(_, keyword, pos) = get_token_name(line, startpos, True)
		# We accept any sort of keyword in this tool.
		#if keyword.upper() not in KEYWORDS:
		#	print(f"Error in line {1+lid}: Unknown keyword '{keyword}'")
		#	return None
		pos = find_next_token(line, pos)
		
		citem = CommandItem(asmFile=asm_filename, lineID=lid, cmdName=keyword.upper(), params=[])
		while pos < len(line):
			res = get_token(line, pos)
			if res is None:
				print(f"Parse error in {asm_filename}:{1+lid}, column {1+pos}: Parsing error!")	# TODO: print details
				return None
			(ttype, tdata, endpos) = res
			citem.params += [ParamToken(ttype, tdata, pos)]
			pos = find_next_token(line, endpos)	# skip spaces
			if pos >= len(line):
				break
			if line[pos] == ';':	# comment
				break
			if line[pos] != ',':
				print(f"Parse error in {asm_filename}:{1+lid}: Expected comma at position {1+pos}")
				return None
			pos = find_next_token(line, pos+1)	# skip spaces
		#print((lid, keyword, citem.params))
		
		cmd_list.append(citem)
	
	return (cmd_list, label_list)

def add_ref_label(refdata: dict, label_name: str, mode: int, cmd_id: int):
	lname = label_name.casefold()
	if not lname in refdata:
		refdata[lname] = [mode, cmd_id]
	else:
		if ((refdata[lname][0] & 0x01) == 0x00) and (mode & 0x01):
			# "PRINT" takes priority over other potentional references
			refdata[lname][1] = cmd_id
		refdata[lname][0] |= mode
	return

def sort_text_list(relevant_data: list, ref_labels: dict, cmd_list, label_list) -> list:
	# sort text lines by:
	#	1. order of the PRINT instructions that reference them
	#	2. for unused ones: closest to the next referenced string
	rd_sortlist = []
	rd_sl_unref = []
	for relev_itm in relevant_data:
		citem = cmd_list[relev_itm[2][0]]
		str_line_id = citem.lineID
		
		if relev_itm[1] in ref_labels:
			ref_lbl = ref_labels[relev_itm[1]]
			lbl_line_id = cmd_list[ref_lbl[1]].lineID
			rd_sortlist.append(( (lbl_line_id << 16) | (str_line_id << 0), relev_itm ))
		else:
			rd_sl_unref.append(( str_line_id, relev_itm ))
	
	rd_keys = [rd[0] for rd in rd_sortlist]
	if len(rd_keys) > 0:
		for rd in rd_sl_unref:
			dist = [abs(rd[0] - (rdk & 0xFFFF)) for rdk in rd_keys]
			mdist = min(dist)
			midx = dist.index(mdist)
			rd_sortlist.append(( (rd_keys[midx] & ~0xFFFF) | (rd[0] & 0xFFFF), rd[1]))
	else:
		for rd in rd_sl_unref:
			rd_sortlist.append(( rd[0] & 0xFFFF, rd[1]))
	
	rd_sortlist.sort(key=lambda item: item[0])
	return [rd[1] for rd in rd_sortlist]

def apply_textbox_settings(tb_state: list, tb_settings: list) -> None:
	if tb_settings is None:
		return
	for tb in tb_settings:
		tb_id = tb["box_id"]
		if ("width" in tb) and ("width" in tb):
			tb_state[tb_id] = (
				int(tb["width"]) * 2,
				int(tb["height"]),
			)
		else:
			tb_state[tb_id] = None	# close text box
	return

def generate_message_table(cmd_list: list, label_list: list) -> list:
	global textbox_data
	
	cmd_lbl_list = {}
	#label_list[lbl_nm_cf] = LabelItem(cmdID=len(cmd_list), asmFile=asm_filename, lineID=lid, lblName=label_name)
	for lname in label_list:
		lbl = label_list[lname]
		cmd_lbl_list[lbl.cmdID] = lname
	
	# at first, go through all commands and take note of the text *references*
	ref_labels = {}
	label_tboxes = {}
	last_label_item = None
	print_before_label = None
	# initialize text boxes
	textbox_info = [None] * 0x10
	if "initial" in textbox_data:
		apply_textbox_settings(textbox_info, textbox_data["initial"])
	for (cid, citem) in enumerate(cmd_list):
		if cid in cmd_lbl_list:
			print_before_label = None
		
		cmdName = citem.cmdName.upper()
		if cmdName == "PRINT":
			tb_id = citem.params[0].data & 0x0F	# The mask is required by GAO1/SNR/RS5S13.ASM.
			lname = citem.params[1].data.casefold()
			add_ref_label(ref_labels, lname, 0x01, cid)	# referenced by "print" -> good
			if textbox_info[tb_id] is not None:
				label_tboxes[lname] = textbox_info[tb_id]
				if textbox_info[tb_id][0] <= 16:	# small text box (<=16 wide) -> assume selection
					ref_labels[lname][0] |= 0x02
			print_before_label = lname
		elif cmdName == "PRINTXY":
			# params[0] = X position
			# params[1] = Y position
			lname = citem.params[2].data.casefold()
			add_ref_label(ref_labels, lname, 0x01, cid)	# referenced by "print" -> good
			print_before_label = lname
		elif cmdName == "STRCPYI":
			lname = citem.params[1].data.casefold()
			add_ref_label(ref_labels, lname, 0x01, cid)
		elif cmdName == "TBOPEN":
			tb_id = citem.params[0].data
			tb_width = citem.params[3].data
			tb_height = citem.params[4].data
			textbox_info[tb_id] = (
				(tb_width - 2) * 2,	# -2 for border, in full-width CJK, *2 for ASCII width
				tb_height - 2,	# -2 for top and bottom border
			)
		elif cmdName == "TBCLOSE":
			tb_id = citem.params[0].data
			textbox_info[tb_id] = None
		elif cmdName == "MENUSEL":
			pitem = citem.params[3]
			lname = pitem.data.casefold()
			if print_before_label is not None:
				ref_labels[print_before_label][0] |= 0x02	# mark as menu selection
		elif cmdName == "LDSCENE" or cmdName == "BGMPLAY":
			pitem = citem.params[0]
			add_ref_label(ref_labels, pitem.data, 0x10, cid)
		elif cmdName == "REGFLD" or cmdName == "REGFSAV":
			pitem = citem.params[1]
			add_ref_label(ref_labels, pitem.data, 0x10, cid)
		elif cmdName == "IMGLOAD":
			pitem = citem.params[4]
			add_ref_label(ref_labels, pitem.data, 0x10, cid)
		elif cmdName == "CALL":
			pitem = citem.params[0]
			if "calls" in textbox_data:
				callName = pitem.data.casefold()
				for (tb_key, tb) in textbox_data["calls"].items():
					if tb_key.casefold() == callName:
						apply_textbox_settings(textbox_info, tb)
		else:
			for pitem in citem.params:
				if pitem.type == TKTP_NAME:
					add_ref_label(ref_labels, pitem.data, 0x08, cid)	# referenced by unknown instruction
	
	# now go through all commands and take note of the data
	# We are already "grouping" multiple "commands" into a single data item section here.
	relevant_data = []	# list( [data type, label key, [command list]] )
	last_label_item = None
	lbl_key = None
	last_dtype = DTYPE_NONE
	for (cid, citem) in enumerate(cmd_list):
		if cid in cmd_lbl_list:
			last_label_item = len(relevant_data)
			last_dtype = DTYPE_NONE
			lbl_key = cmd_lbl_list[cid]
		
		cmdName = citem.cmdName.upper()
		if cmdName == "DS":
			has_byte = 0
			has_null = 0
			has_str = 0
			for pitem in citem.params:
				if pitem.type == TKTP_INT:
					if pitem.data == 0:
						has_null += 1
					else:
						has_byte += 1
				elif pitem.type == TKTP_STR:
					if pitem.data.isascii():
						has_str |= 0x01
					else:
						has_str |= 0x02
			if (has_byte == 1 and has_str == 0x01 and has_null == 1) and citem.params[0].type == TKTP_INT:
				# This must be a file name - ignore it.
				if last_dtype == DTYPE_NONE:
					last_dtype = DTYPE_FNAME
			elif has_str != 0:
				if last_dtype == DTYPE_NONE:
					last_dtype = DTYPE_STR
			if last_label_item == len(relevant_data):
				relevant_data += [[last_dtype, lbl_key, []]]
			elif relevant_data[-1][0] != last_dtype:
				relevant_data[-1][0] = last_dtype
			relevant_data[-1][2].append(cid)

			## enforce a new data item after a string that ends with terminator character 0
			#if (citem.params[-1].type == TKTP_INT and citem.params[-1].data == 0):
			#	# This might be useful, but also has a risk of mis-detecting the string terminator.
			#	# If that happens, data would be missing, so we will rely on a good-labelled ASM file instead.
			#	last_label_item = len(relevant_data)
			#	last_dtype = DTYPE_NONE
		elif cmdName == "DSJ":
			last_dtype = DTYPE_STR
			if last_label_item == len(relevant_data):
				relevant_data += [[last_dtype, lbl_key, []]]
			elif relevant_data[-1][0] != last_dtype:
				relevant_data[-1][0] = last_dtype
			relevant_data[-1][2].append(cid)
	
	# sort the data so that they match "in-game use" more closely
	relevant_data = sort_text_list(relevant_data, ref_labels, cmd_list, label_list)
	
	# finally generate the text message list
	lastLbl = None
	msg_table = []
	for relev_itm in relevant_data:
		lbl_key = relev_itm[1]
		
		if lbl_key in ref_labels:
			ref_data = ref_labels[lbl_key]
			ref_mask = ref_data[0]
		else:
			ref_data = None
			ref_mask = 0x00
		if (ref_mask != 0x00) and (ref_mask & 0x01) == 0x00:
			continue	# referenced by unknown command - skip
		elif ref_mask == 0x00:
			# unreferenced - check string type
			if relev_itm[0] != DTYPE_STR:
				continue
		
		lastLbl = label_list[lbl_key].lblName
		msgtype = str(ref_mask)
		if ref_mask & 0x02:
			msgtype = "sel"
		elif ref_mask & 0x01:
			msgtype = "txt"
		elif (ref_mask & 0x10) or (relev_itm[0] == DTYPE_FNAME):
			msgtype = "file"
		elif ref_mask & 0x08:
			msgtype = "???"
		else:
			msgtype = "UNREF"	# unreferenced text
		tbinfo = label_tboxes[lbl_key] if lbl_key in label_tboxes else None
		ref_line = -1 if ref_data is None else cmd_list[ref_data[1]].lineID
		
		text = ""
		line_list = []
		rem_param_bytes = 0
		for cid in relev_itm[2]:
			citem = cmd_list[cid]
			line_list.append(citem.lineID)
			cmdName = citem.cmdName.upper()
			do_flush = False
			had_end = False
			if cmdName == "DS":
				last_chr = None
				meta_ctrl_code = False
				for pitem in citem.params:
					if pitem.type == TKTP_INT or pitem.type == TKTP_STR:
						if pitem.type == TKTP_INT:
							data = [pitem.data]
						else:
							data = pitem.data
						for c in data:
							if type(c) is int:
								# special handling for bytes, so that we don't run into issues with 0x80..0xFF
								cint = c
								c = "\\x{:02X}".format(cint)
							else:
								cint = ord(c)
								if cint < 0x20:
									# force escaping for non-printable characters
									c = "\\x{:02X}".format(cint)
							if rem_param_bytes > 0:
								text += "\\x{:02X}".format(cint)
								rem_param_bytes -= 1
								continue

							last_chr = cint
							if meta_ctrl_code:
								text += "\\x{:02X}".format(cint)
								if cint == 0x00:
									rem_param_bytes = 1
							elif cint == 0x0D:	# new line
								text += "\\r"
							elif cint == 0x0A:	# scroll line
								text += "\\n"
							elif cint == 0x01:	# paragraph end
								text += "\\e"
							elif cint == 0x02:	# wait
								text += "\\w"
							elif cint == 0x03:	# set colour
								text += "\\c"
								rem_param_bytes = 1
							elif cint == 0x0B:	# set portrait
								text += "\\p"
								rem_param_bytes = 1
							elif cint in [0x04, 0x06, 0x08, 0x0C, 0x0E]:
								text += c
								rem_param_bytes = 1
							elif cint == 0x05:
								text += c
								rem_param_bytes = 2	# has 2 parameter bytes
							elif cint == 0x0F:
								text += c
								meta_ctrl_code = True
							else:
								text += c
					else:
						print(f"Error in {citem.asmFile}:{1+citem.lineID}, column {1+pitem.pos}: expected integer or string!")
						return None
				if last_chr is not None:
					if last_chr in [0x0D, 0x0A, 0x01, 0x00]:
						do_flush = True
					if last_chr == 0x00:
						text = text[:-4]
						had_end = True
			elif cmdName == "DSJ":
				rem_param_bytes = 0
				for pitem in citem.params:
					if pitem.type != TKTP_INT:
						print(f"Error in {citem.asmFile}:{1+citem.lineID}, column {1+pitem.pos}: expected integer!")
						return None
					text += f"\\j{pitem.data:04X}"
			if do_flush:
				if had_end:
					pass
				else:
					text += "\\"
				msg_table += [(line_list, lastLbl, ref_line, msgtype, tbinfo, text)]
				line_list = []
				text = ""
		if len(text) > 0:
			if not had_end:
				text += "\\"
			msg_table += [(line_list, lastLbl, ref_line, msgtype, tbinfo, text)]
	
	return msg_table

def load_asm(fn_in: str) -> typing.List[str]:
	with open(fn_in, "rt", encoding="utf-8") as f:
		return f.readlines()

def load_parse_asm(fn_in: str) -> tuple:
	try:
		asm_lines = load_asm(fn_in)
	except IOError:
		print(f"Error loading {fn_in}")
		return 1
	ret = parse_asm(asm_lines, fn_in)
	if ret is None:
		return 2
	return ret

def asm2tsv(in_fns: str, fn_out: str) -> int:
	result = 0
	try:
		with open(fn_out, "wt") as f:
			f.write("#file\tline (ref)\tlabel\ttype\ttextbox\tstring\n")

			for fn_in in in_fns:
				print(f"{fn_in} ...")
				ret = load_parse_asm(fn_in)
				if type(ret) is not tuple:
					result = max([ret, result])
					continue
				(cmd_list, label_list) = ret
				msg_list = generate_message_table(cmd_list, label_list)

				#fname = os.path.basename(fn_in)
				fname = fn_in
				for msg in msg_list:
					line_list = msg[0]
					line_str = f"{line_list[0]}"
					if len(line_list) > 1:
						lcount = line_list[-1] - line_list[0]
						line_str += f"+{lcount}"
					if msg[2] >= 0:
						line_str += f" ({msg[2]})"
					tbox = msg[4]
					if tbox is None:
						tbstr = "-"
					else:
						tbstr = f"{tbox[0]}x{tbox[1]}"
					f.write(f"{fname}\t{line_str}\t{msg[1]}\t{msg[3]}\t{tbstr}\t{msg[5]}\n")
	except IOError:
		print(f"Error writing {fn_out}")
		return 1

	print("Done.")
	return result

def main(argv):
	global config
	global textbox_data
	
	print("System-98 Scenario TSV Dumper")
	aparse = argparse.ArgumentParser()
	aparse.add_argument("-t", "--text-boxes", help="YAML file that specifies common text boxes")
	aparse.add_argument("-o", "--out-file", required=True, help="output tab-separated text table (.TSV)")
	aparse.add_argument("in_files", nargs="+", help="input assembly files (.ASM)")
	
	config = aparse.parse_args(argv[1:])
	if config.text_boxes:
		with open(config.text_boxes, "rt") as f:
			textbox_data = yaml.safe_load(f)
	
	return asm2tsv(config.in_files, config.out_file)

if __name__ == "__main__":
	sys.exit(main(sys.argv))
# vim: set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab:
