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
	pos: int	# start position on current line
	cmdOfs: typing.Optional[int] = None	# relative command offset (for label references)

@dataclasses.dataclass
class CommandItem:
	asmFile: str	# file name of the original ASM file
	lineID: int		# line ID in original ASM file
	cmdName: str	# command name (uppercase)
	commentPos: int	# column where the comment starts or -1

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


def parse_tsv(lines: list) -> list:
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
		cols = ltrim.split('\t', 5)
		if len(cols) < 6:
			print(f"Line {lid} invalid: {ltrim}")
			return None
		(filename, lineref, lblname, mode, tbox, text) = cols
		lineref = lineref.split(' ', 1)[0]
		if "+" in lineref:
			lineref = lineref.split('+')
			lstart = int(lineref[0])
			lend = lstart + int(lineref[1])
		else:
			lstart = int(lineref)
			lend = lstart
		result.append({
			"tsv-lid": lid,
			"file": filename,
			"line-ref": lineref,
			"line-start": lstart,
			"line-end": lend,
			"label": lblname,
			"mode": mode,
			"tbox": tbox,
			"text": text,
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
		
		citem = CommandItem(asmFile=asm_filename, lineID=lid, cmdName=keyword.upper(), commentPos=-1)
		while pos < len(line):
			res = get_token(line, pos)
			if res is None:
				print(f"Parse error in {asm_filename}:{1+lid}, column {1+pos}: Parsing error!")	# TODO: print details
				return None
			(ttype, tdata, endpos) = res
			pos = find_next_token(line, endpos)	# skip spaces
			if pos >= len(line):
				break
			if line[pos] == ';':	# comment
				citem.commentPos = pos
				break
			if line[pos] != ',':
				print(f"Parse error in {asm_filename}:{1+lid}: Expected comma at position {1+pos}")
				return None
			pos = find_next_token(line, pos+1)	# skip spaces
		#print((lid, keyword, citem.params))
		
		cmd_list.append(citem)
	
	return (cmd_list, label_list)

def tsvdata2asmcommands(text: str) -> list:
	CMDTYPE_DB = 0
	CMDTYPE_DSJ = 1

	needs_terminator = True
	asm_cmds = []
	last_cmd_type = None
	last_data_type = None
	pos = 0
	param_bytes = 0
	while pos <= len(text):	# Note: must be "<=" to process string terminator upon line end
		chrlen = 1
		cmd_type = None
		token_data = None
		if pos >= len(text):
			cmd_type = CMDTYPE_DB
			token_data = 0	# add a string terminator to the DB instruction
		elif text[pos] == '\\':
			if (pos + 1) >= len(text):
				# When the backslash occours at the end of the line, it is a "continuation" marker.
				# We just exit the loop immediately in this case.
				break
			ctrl_chr = text[pos + 1]
			chrlen += 1
			if ctrl_chr == 'x':
				cmd_type = CMDTYPE_DB
				token_data = int(text[pos+chrlen : pos+chrlen+2], 0x10)
				chrlen += 2
			elif ctrl_chr == 'j':
				cmd_type = CMDTYPE_DSJ
				token_data = int(text[pos+chrlen : pos+chrlen+4], 0x10)
				chrlen += 4
			elif ctrl_chr == 'u':
				cmd_type = CMDTYPE_DB
				token_data = text[pos : pos+chrlen+4]
				chrlen += 4
			elif ctrl_chr == 'U':
				cmd_type = CMDTYPE_DB
				token_data = text[pos : pos+chrlen+8]
				chrlen += 8
			elif ctrl_chr == 'r':	# new line (reset X position, increment Y position by 1)
				cmd_type = CMDTYPE_DB
				token_data = 0x0D
			elif ctrl_chr == 'n':	# scroll line
				cmd_type = CMDTYPE_DB
				token_data = 0x0A
			elif ctrl_chr == 'c':	# set colour
				cmd_type = CMDTYPE_DB
				token_data = 0x03
				param_bytes = 1
			elif ctrl_chr == 'e':	# paragraph end (wait, then clear text box)
				cmd_type = CMDTYPE_DB
				token_data = 0x01
			elif ctrl_chr == 'w':	# wait
				cmd_type = CMDTYPE_DB
				token_data = 0x02
			elif ctrl_chr == 'p':	# set portrait
				cmd_type = CMDTYPE_DB
				token_data = 0x0B
				param_bytes = 1
			else:
				cmd_type = CMDTYPE_DB
				token_data = text[pos : pos+chrlen]
		elif text[pos] == '"':
			cmd_type = CMDTYPE_DB
			token_data = '\\"'	# quotation marks need to be escaped
		elif ord(text[pos]) >= 0x20:
			cmd_type = CMDTYPE_DB
			token_data = text[pos]
		elif text[pos] in ['\t']:
			cmd_type = CMDTYPE_DB
			token_data = ord(text[pos])
		else:
			print("Error - found control character 0x{ord(text[pos]):02X}")
			return None
		pos += chrlen
		
		if type(token_data) is str:
			tktp = TKTP_STR
		else:
			tktp = TKTP_INT
		if cmd_type == last_cmd_type:	# same command
			params = asm_cmds[-1]["params"]
			if (type(token_data) is str) and (type(token_data) is last_data_type):
				# string: extend last parameter
				params[-1].data += token_data
			else:
				# else just add a new parameter
				params.append(ParamToken(type=tktp, data=token_data, pos=0, cmdOfs=None))
		else:	# different command
			if cmd_type == CMDTYPE_DSJ:
				cmd = "DSJ"
			else:
				cmd = "DS"
			asm_cmds.append({"cmd": cmd, "params": [ParamToken(type=tktp, data=token_data, pos=0, cmdOfs=None)]})
		last_cmd_type = cmd_type
		last_data_type = type(token_data)
	return asm_cmds

def patch_asms(tsvdata: list, asmlist: list) -> int:
	asmlut = {}
	for (asmid, asmfile) in enumerate(asmlist):
		asmlut[asmfile["file"]] = asmid

	for tsvline in tsvdata:
		if type(tsvline) is str:
			continue

		# turn TSV text into ASM command sets
		cmds = tsvdata2asmcommands(tsvline["text"])
		if cmds is None:
			print("Error in TSV line {tsvline['tsv-lid']}")
			return 1

		# turn the ASM commands into actual text
		textlines = []
		for cmd in cmds:
			if cmd["cmd"] == "DSJ":
				digits = 4
			else:
				digits = 0
			tparams = []
			for param in cmd["params"]:
				if param.type == TKTP_STR:
					tparams.append(f'"{param.data}"')
				elif digits > 0:
					tparams.append(f"0x{param.data:0{digits}X}")
				else:
					if param.data < 10:
						tparams.append(f"{param.data}")	# decimal, no padding
					else:
						tparams.append(f"0x{param.data:02X}")	# hex with 2 digits
			cols = ["", cmd["cmd"]]
			if len(tparams) > 0:
				cols.append(", ".join(tparams))
			textlines.append("\t".join(cols) + "\n")

		# replace ASM lines
		af = asmlist[asmlut[tsvline["file"]]]
		lstart = tsvline["line-start"]
		lend = tsvline["line-end"]
		lcont = lend + 1 - lstart

		for lid in range(lstart, lend+1):
			af["lines"][lid] = ""	# just make all lines empty
		af["lines"][lstart] = "".join(textlines)

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
	try:
		# read + parse TSV
		print("Reading TSV ...", flush=True)
		tsv_lines = load_text_file(tsv_file)
		tsv_data = parse_tsv(tsv_lines)
		asmlist = generate_file_list(tsv_data)

		# read all related ASM files
		print("Reading ASM files ...", flush=True)
		for asmfile in asmlist:
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
	except IOError:
		print(f"Error writing {fn_out}")
		return 1

	print("Done.")
	return result

def main(argv):
	global config
	
	print("System-98 Scenario TSV text reinserter")
	aparse = argparse.ArgumentParser()
	aparse.add_argument("-t", "--tsv_file", required=True, help="tab-separated text table (.TSV)")
	aparse.add_argument("-i", "--in_path", required=True, help="base path where source ASM files are located")
	aparse.add_argument("-o", "--out_path", required=True, help="base path where patched ASM files are to be written")
	
	config = aparse.parse_args(argv[1:])
	
	return tsv_asm_patch(config.tsv_file, config.in_path, config.out_path)

if __name__ == "__main__":
	sys.exit(main(sys.argv))
# vim: set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab:
