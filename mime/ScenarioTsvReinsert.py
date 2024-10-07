#!/usr/bin/env python3
import sys
import os
import dataclasses
import struct
import typing
import argparse


@dataclasses.dataclass
class ParamToken:
	type: int	# token type
	data: typing.Union[int, str]	# token data
	posS: int	# start position on current line
	posE: int	# end position on current line

@dataclasses.dataclass
class CommandItem:
	asmFile: str	# file name of the original ASM file
	lineID: int		# line ID in original ASM file
	cmdName: str	# command name (uppercase)
	params: list = dataclasses.field(default_factory=list)	# parameters
	commentPos: int = -1	# column where the comment starts or -1

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


def unquote_column(text: str) -> str:
	if not text.startswith('"'):
		return text
	
	text = text[1:]
	pos = text.find('"')
	while pos >= 0:
		if not (pos + 1 < len(text) and text[pos+1] == '"'):
			text = text[:pos]
			break
		text = text[:pos] + '"' + text[pos+2:]
		pos = text.find('"', pos + 1)
	return text

def parse_tsv(lines: list) -> list:
	global config
	
	if len(lines) > 0:
		if lines[0].startswith("file\t"):
			lines[0] = "#" + lines[0]	# enforce header to be a comment
	
	result = []
	for (lid, line) in enumerate(lines):
		ltrim = line.lstrip()
		if len(ltrim) == 0 or ltrim.startswith('#') or ltrim.startswith(';'):
			result += [line]
			continue
		ltrim = line.rstrip('\n')
		cols = ltrim.split('\t')
		if len(cols) < 6:
			print(f"Line {lid} invalid: {ltrim}")
			return None
		if config.text_column >= len(cols):
			result += [line]
			continue	# ignore lines that don't have the respective column
		text = cols[config.text_column]
		if len(text) == 0:
			result += [line]
			continue	# ignore empty texts as well
		(filename, lineref, lblref, mode, tbox) = cols[0:5]
		lineref = lineref.split(' ', 1)[0]
		if "," in lineref:
			lineref = lineref.split(',')
			lineid = int(lineref[0])
			lineitm = int(lineref[1])
		else:
			lineid = int(lineref)
			lineitm = 0
		if "+" in lblref:
			lblref = lblref.split('+')
			lblname = lblref[0]
			lblline = int(lblref[1])
		else:
			lblname = lblref
			lblline = None
		if "@" in tbox:
			(tbox, tloc) = tbox.split('@')
			tloc = tuple([int(val) for val in tloc.split(',')])	# convert ["1,2"] to (1, 2)
		else:
			tloc = None
		result.append({
			"tsv-lid": lid,
			"file": filename,
			"line-id": lineid,
			"line-item": lineitm,
			"label": lblname,
			"label-line": lblline,
			"mode": mode,
			"tbox": tbox,
			"tloc": tloc,
			"text": unquote_column(text),
		})
	return result

def generate_file_list(tsv_data: list) -> list:
	filelist = []
	fileset = set()
	for ldata in tsv_data:
		if type(ldata) is str:
			continue
		fname = ldata["file"]
		if fname not in fileset:
			fileset.add(fname)
			filelist.append({"file": fname})
	return filelist


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
		citem = CommandItem(asmFile=asm_filename, lineID=lid, cmdName=keyword.upper(), params=[], commentPos=-1)
		while pos < len(line):
			if line[pos] == ';':	# comment
				citem.commentPos = pos
				break
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
			citem.params += [ParamToken(ttype, tdata, pos, endpos)]
			pos = find_next_token(line, endpos)	# skip spaces
			if pos >= len(line):
				break
			if line[pos] == ';':	# comment
				continue
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

def screen_pos2addr(x: int, y: int) -> int:
	if y < 0 or y >= 640:
		return 0xFFFF
	return (y * 80) + (x // 8)

def tsvdata2asmstr(text: str) -> str:
	text = text.replace('\u201C', '"').replace('\u201D', '"')
	text = text.replace("\u2018", "'").replace("\u2019", "'")
	text = text.replace("\u2026", "...")
	pos = 0
	result = ""
	while pos < len(text):	# Note: must be "<=" to process string terminator upon line end
		chrlen = 1
		token_data = None
		if text[pos] == '\\':
			chrlen += 1
			token_data = text[pos : pos+chrlen]
		elif text[pos] == '"':
			token_data = '\\' + text[pos]	# quotation marks need to be escaped
		elif ord(text[pos]) >= 0x20:
			token_data = text[pos]
		else:
			chrid = ord(text[pos])
			token_data = f"\\x{chrid:02X}"
		pos += chrlen
		
		result += token_data
	
	return f'"{result}"'

def patch_asms(tsvdata: list, asmlist: list) -> int:
	asmlut = {}
	for (asmid, asmfile) in enumerate(asmlist):
		asmlut[asmfile["file"]] = asmid
		
		asmfile["cmd-lut"] = [None] * len(asmfile["lines"])
		for (cid, citem) in enumerate(asmfile["data"][0]):
			asmfile["cmd-lut"][citem.lineID] = cid
		asmfile["lbl-lut"] = [None] * len(asmfile["lines"])
		for (lname, lbl) in asmfile["data"][1].items():
			asmfile["lbl-lut"][lbl.lineID] = lname
	
	for tsvline in tsvdata:
		if type(tsvline) is str:
			continue
		
		af = asmlist[asmlut[tsvline["file"]]]
		alines = af["lines"]
		(acmds, albls) = af["data"]
		
		# turn TSV text into ASM command sets
		asmtxt = tsvdata2asmstr(tsvline["text"])
		
		lineid = tsvline["line-id"]
		lineitm = tsvline["line-item"]
		cid = af["cmd-lut"][lineid]
		if cid is None:
			print(f"Error: Unable to reinsert text on line {lineid} - command missing!")
			continue
		citem = acmds[cid]
		
		cmdName = citem.cmdName.upper()
		field_rep = []
		if cmdName.startswith("PRINT"):
			# format: PRINT screenPos, "text"
			if tsvline["tloc"] is not None:
				tloc = tsvline["tloc"]
				loctext = "0x{:04X}".format(screen_pos2addr(tloc[0], tloc[1]))
				field_rep.append((0, loctext))
			if lineitm == 0:
				par_idx = 1
			else:
				par_idx = -1
		elif cmdName.startswith("TALK"):
			# TALKDGN "text"
			if lineitm == 0:
				par_idx = 0
			else:
				par_idx = -1
		elif cmdName == "MENUSEL":
			# MENUSEL screenPos, numberEntries, ["text1", "text2", ...]
			if tsvline["tloc"] is not None:
				tloc = tsvline["tloc"]
				loctext = "0x{:04X}".format(screen_pos2addr(tloc[0], tloc[1]))
				field_rep.append((0, loctext))
			idx_entry = None
			par_idx = -1
			for (pid, pitem) in enumerate(citem.params):
				if pitem.type == TKTP_CTRL:
					if pitem.data == "[":
						idx_entry = 0
					elif pitem.data == "]":
						idx_entry = None
				else:
					if idx_entry is not None:
						if idx_entry == lineitm:
							par_idx = pid
						idx_entry += 1
		else:
			par_idx = None
		if par_idx is None:
			print(f"Error: Unable to reinsert text on line {lineid} - bad command {citem.cmdName}!")
			continue
		elif par_idx < 0:
			print(f"Error: Unable to reinsert text on line {lineid} - out-of-range string index {lineitm}!")
			continue
		field_rep.append((par_idx, asmtxt))
		
		# replace parameters in ASM line
		for (pid, newtext) in field_rep:
			param = citem.params[pid]
			
			oldlen = param.posE - param.posS
			lendiff = len(newtext) - oldlen
			alines[lineid] = alines[lineid][:param.posS] + newtext + alines[lineid][param.posE:]
			# fix all the internal offsets
			param.posE += lendiff
			for pid in range(par_idx + 1, len(citem.params)):
				pitem = citem.params[pid]
				pitem.posS += lendiff
				pitem.posE += lendiff
			if citem.commentPos >= 0:
				citem.commentPos += lendiff
	
	return 0

def load_text_file(fn_in: str) -> typing.List[str]:
	with open(fn_in, "rt", encoding="utf-8") as f:
		return f.readlines()

def write_text_file(fn_out: str, lines: list) -> None:
	with open(fn_out, "wt", encoding="utf-8") as f:
		f.writelines(lines)
	return

def tsv_asm_patch(tsv_file: str, inpath: str, outpath: str) -> int:
	result = 0
	# read + parse TSV
	print("Reading TSV ...", flush=True)
	tsv_lines = load_text_file(tsv_file)
	tsv_data = parse_tsv(tsv_lines)
	asmlist = generate_file_list(tsv_data)

	# read all related ASM files
	print("Reading ASM files ...", flush=True)
	for asmfile in asmlist:
		print(f"    {asmfile['file']} ...", flush=True)
		try:
			fullpath = os.path.join(inpath, asmfile["file"])
			asm_lines = load_text_file(fullpath)
		except IOError:
			print(f"Error loading {asmfile['file']}")
			return 1
		ret = parse_asm(asm_lines, asmfile["file"])
		if ret is None:
			return 2
		asmfile["lines"] = asm_lines
		asmfile["data"] = ret

	print("Patching ASM files ...", flush=True)
	ret = patch_asms(tsv_data, asmlist)
	if ret != 0:
		return ret

	# write all ASM files
	print("Writing ASM files ...", flush=True)
	for asmfile in asmlist:
		try:
			fullpath = os.path.join(outpath, asmfile["file"])
			os.makedirs(os.path.dirname(fullpath), exist_ok=True)
			write_text_file(fullpath, asmfile["lines"])
		except IOError:
			print(f"Error writing {asmfile['file']}")
			return 1

	print("Done.")
	return result

def main(argv):
	global config
	
	print("MIME Scenario TSV text reinserter")
	aparse = argparse.ArgumentParser()
	aparse.add_argument("-c", "--text-column", type=int, help="column to use for text to insert (1 = first column)", default=6)
	aparse.add_argument("-t", "--tsv-file", required=True, help="tab-separated text table (.TSV)")
	aparse.add_argument("-i", "--in-path", required=True, help="base path where source ASM files are located")
	aparse.add_argument("-o", "--out-path", required=True, help="base path where patched ASM files are to be written")
	
	config = aparse.parse_args(argv[1:])
	config.text_column -= 1	# 1st colum has ID 0.
	
	return tsv_asm_patch(config.tsv_file, config.in_path, config.out_path)

if __name__ == "__main__":
	sys.exit(main(sys.argv))
# vim: set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab:
