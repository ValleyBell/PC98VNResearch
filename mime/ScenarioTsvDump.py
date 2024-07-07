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


TKTP_INT = 0x01		# integer number (byte/word/dword)
TKTP_STR = 0x02		# string
TKTP_NAME = 0x80	# register or label name
TKTP_REG = 0x81		# register
TKTP_LBL = 0x82		# label name
TKTP_CTRL = 0xF0	# control character

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

config = {}
textbox_info = {
	"TALKDGN": (16*2, 5),	# dungeon talk
	"TALKFS": (37*2, 3),	# full-screen talk	
}


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
	if line[pos] in ['+', '-']:
		pos += 1
	if line[pos : pos+2].lower() == "0x":	# prefix for hexadecimal numbers
		pos += 2
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
	
	if line[startpos] in ['[', ']']:
		return (TKTP_CTRL, line[startpos : startpos+1], startpos+1)
	if line[startpos] == '"':
		return get_token_str(line, startpos)
	if line[startpos].isdecimal() or (line[startpos] in ['+', '-']):
		return get_token_int(line, startpos)
	if line[startpos].isalpha():
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
		pos = find_next_token(line, pos)
		
		arrays_open = 0
		citem = CommandItem(asmFile=asm_filename, lineID=lid, cmdName=keyword.upper(), params=[])
		while pos < len(line):
			res = get_token(line, pos)
			if res is None:
				print(f"Parse error in {asm_filename}:{1+lid}, column {1+pos}: Parsing error!")	# TODO: print details
				return None
			(ttype, tdata, endpos) = res
			if ttype == TKTP_CTRL:
				if tdata == "[":
					arrays_open += 1
				elif tdata == "]":
					arrays_open -= 1
					if arrays_open < 0:
						print(f"Parse error in {asm_filename}:{1+lid}: Invalid array end at position {1+pos}")
						return None
			citem.params += [ParamToken(ttype, tdata, pos)]
			pos = find_next_token(line, endpos)	# skip spaces
			if pos >= len(line):
				break
			if line[pos] == ';':	# comment
				break
			if ttype == TKTP_CTRL:
				if tdata == "[":
					continue	# we don't want a comma after this control character
			if line[pos] == ',':
				pos = find_next_token(line, pos+1)	# skip spaces
			elif line[pos] == ']':
				pass	# "array end" is a valid control character that can follow any token
			else:
				print(f"Parse error in {asm_filename}:{1+lid}: Expected comma at position {1+pos}")
				return None
			
		if arrays_open > 0:
			print(f"Parse error in {asm_filename}:{1+lid}: Not all arrays were closed!")
			return None
		#print((lid, keyword, citem.params))
		
		cmd_list.append(citem)
	
	return (cmd_list, label_list)

def generate_message_table(cmd_list: list, label_list: list) -> list:
	cmd_lbl_list = {}
	#label_list[lbl_nm_cf] = LabelItem(cmdID=len(cmd_list), asmFile=asm_filename, lineID=lid, lblName=label_name)
	for lname in label_list:
		lbl = label_list[lname]
		cmd_lbl_list[lbl.cmdID] = lname
	
	lastLbl = None
	msg_table = []
	for (cid, citem) in enumerate(cmd_list):
		if cid in cmd_lbl_list:
			lbl_key = cmd_lbl_list[cid]
			lastLbl = label_list[lbl_key].lblName
		
		cmdName = citem.cmdName.upper()
		if cmdName.startswith("PRINT"):
			# format: PRINT screenPos, "text"
			msg_table += [(citem.lineID, lastLbl, -1, "prt", None, citem.params[1].data)]
		elif cmdName.startswith("TALK"):
			# TALKDGN "text"
			tbinfo = textbox_info[cmdName] if (cmdName in textbox_info) else None
			#            [(line_id, lastLbl, index, msgtype, tbinfo, text)]
			msg_table += [(citem.lineID, lastLbl, -1, "txt", tbinfo, citem.params[0].data)]
		elif cmdName == "MENUSEL":
			# MENUSEL screenPos, numberEntries, ["text1", "text2", ...]
			idx_entry = None
			for pitem in citem.params:
				if pitem.type == TKTP_CTRL:
					if pitem.data == "[":
						idx_entry = 0
					elif pitem.data == "]":
						idx_entry = None
				else:
					if pitem.type == TKTP_STR:
						msg_table += [(citem.lineID, lastLbl, idx_entry, "sel", None, pitem.data)]
					if idx_entry is not None:
						idx_entry += 1
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
			f.write("#file\tline,idx\tlabel\ttype\ttextbox\tstring\n")

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
					line_str = f"{msg[0]}"
					if msg[2] >= 0:
						line_str += f",{msg[2]}"
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
	
	print("MIME Scenario TSV Dumper")
	aparse = argparse.ArgumentParser()
	aparse.add_argument("-o", "--out-file", required=True, help="output tab-separated text table (.TSV)")
	aparse.add_argument("in_files", nargs="+", help="input assembly files (.ASM)")
	
	config = aparse.parse_args(argv[1:])
	
	return asm2tsv(config.in_files, config.out_file)

if __name__ == "__main__":
	sys.exit(main(sys.argv))
# vim: set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab:
