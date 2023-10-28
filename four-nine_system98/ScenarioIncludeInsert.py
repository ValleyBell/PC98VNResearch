#!/usr/bin/env python3
import sys
import os
import dataclasses
import typing
import argparse
import re


@dataclasses.dataclass
class ParamToken:
	type: int	# token type
	data: typing.Union[int, str]	# token data
	pos: int	# start position on current line
	cmdOfs: typing.Optional[int] = None	# relative command offset (for label references)

#cmd_list = []	# list[ tuple(line ID, command name, list[params] ) ]
@dataclasses.dataclass
class CommandItem:
	lineID: int	# line ID in original ASM file
	cmdName: str	# command name (uppercase)
	params: list = dataclasses.field(default_factory=list)	# parameters
	cmdNum: int = 0	# command number, with fused data blocks for a better comparision heuristic

#label_list = {}	# dict{ label name [casefold]: (command ID, label name [original]) }
@dataclasses.dataclass
class LabelItem:
	cmdID: int	# ID of the command (index into cmd_list) that the label points to
	lineID: int	# line ID in original ASM file
	lblName: str	# original label name


# Scene Command Parameter Types
SCPT_INT = 0x01		# 2-byte integer
SCPT_BYTE = 0x02	# "byte" (2-byte parameter, high byte ignored)
SCPT_LONG = 0x03	# 4-byte integer
SCPT_ILVAR = 0x0F	# 2-byte/4-byte integer, based on previous register ID
SCPT_DATA1 = 0x10	# data pointer (1-byte groups)
SCPT_DATA2 = 0x11	# data pointer (2-byte groups)
SCPT_STR = 0x12		# string pointer
SCPT_FNAME = 0x13	# file path pointer
SCPT_JUMP = 0x14	# jump destination pointer
SCPT_REG_INT = 0x80	# register: integer
SCPT_REG_LNG = 0x81	# register: long
SCPT_REG_IL = 0x82	# register: integer/long
SCPT_REG_STR = 0x83	# register: string

SCPT_MASK = 0xF0
SCPTM_VAL = 0x00	# immediate value
SCPTM_PTR = 0x10	# pointer
SCPTM_REG = 0x80	# register

SC_EXEC_END = 0x01	# terminate script execution here
SC_EXEC_SPC = 0xFF	# special handling

SCENE_CMD_LIST = {
	0x00: ("DOSEXIT", [], SC_EXEC_END),
	0x01: (None     , []),
	0x02: ("IMGLOAD", [SCPT_INT, SCPT_INT, SCPT_BYTE, SCPT_BYTE, SCPT_FNAME, SCPT_BYTE]),
	0x03: ("TBOPEN" , [SCPT_INT, SCPT_INT, SCPT_INT, SCPT_INT, SCPT_INT, SCPT_INT]),
	0x04: ("TBCLOSE", [SCPT_INT]),
	0x05: ("TBCLEAR", [SCPT_INT]),
	0x06: ("PALAPL" , []),
	0x07: ("PALBW"  , [SCPT_INT, SCPT_INT]),
	0x08: ("PALFADE", [SCPT_INT, SCPT_INT]),
	0x09: ("PALLCKT", [SCPT_BYTE]),
	0x0A: ("JP"     , [SCPT_JUMP], SC_EXEC_END),
	0x0B: ("CMPR"   , [SCPT_REG_INT, SCPT_REG_INT]),
	0x0C: ("CMPI"   , [SCPT_REG_INT, SCPT_INT]),
	0x0D: ("JEQ"    , [SCPT_JUMP]),
	0x0E: ("JLT"    , [SCPT_JUMP]),
	0x0F: ("JGT"    , [SCPT_JUMP]),
	0x10: ("JGE"    , [SCPT_JUMP]),
	0x11: ("JLE"    , [SCPT_JUMP]),
	0x12: ("JNE"    , [SCPT_JUMP]),
	0x13: ("JTBL"   , [SCPT_REG_INT], SC_EXEC_SPC),
	0x14: ("PCOLSET", [SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT]),
	0x15: ("PRINT"  , [SCPT_BYTE, SCPT_STR]),
	0x16: ("CMD16"  , [SCPT_INT, SCPT_INT, SCPT_DATA1]),
	0x17: (None     , []),
	0x18: ("MOVI"   , [SCPT_REG_IL, SCPT_ILVAR]),
	0x19: ("MOVR"   , [SCPT_REG_IL, SCPT_REG_IL]),
	0x1A: ("BGMPLAY", [SCPT_FNAME]),
	0x1B: ("BGMFADE", []),
	0x1C: ("BGMSTOP", []),
	0x1D: ("BGMODEG", [SCPT_REG_INT]),
	0x1E: ("CMD1E"  , [SCPT_REG_INT]),
	0x1F: ("LDSCENE", [SCPT_FNAME], SC_EXEC_END),
	0x20: ("GV02"   , []),
	0x21: ("WAIT"   , [SCPT_REG_INT]),
	0x22: ("GFX22"  , [SCPT_REG_INT]),
	0x23: (None     , []),
	0x24: ("ADDI"   , [SCPT_REG_IL, SCPT_ILVAR]),
	0x25: ("SUBI"   , [SCPT_REG_IL, SCPT_ILVAR]),
	0x26: ("TXCLR1" , [SCPT_INT, SCPT_INT, SCPT_INT, SCPT_INT, SCPT_BYTE]),
	0x27: ("ADDR"   , [SCPT_REG_IL, SCPT_REG_IL]),
	0x28: ("SUBR"   , [SCPT_REG_IL, SCPT_REG_IL]),
	0x29: ("XYREAD" , [SCPT_REG_INT, SCPT_INT, SCPT_INT]),
	0x2A: ("XYWRT"  , [SCPT_REG_INT, SCPT_INT, SCPT_INT]),
	0x2B: (None     , []),
	0x2C: (None     , []),
	0x2D: ("REGCLR" , [SCPT_REG_INT, SCPT_REG_INT]),
	0x2E: (None     , []),
	0x2F: ("CMD2F"  , [SCPT_BYTE, SCPT_INT, SCPT_INT, SCPT_INT, SCPT_INT, SCPT_BYTE, SCPT_INT, SCPT_INT]),
	0x30: (None     , []),
	0x31: (None     , []),
	0x32: ("PRINTR" , [SCPT_BYTE, SCPT_REG_INT]),
	0x33: ("PA4GET" , [SCPT_REG_INT]),
	0x34: ("PA4SET" , [SCPT_REG_INT]),
	0x35: ("TXFILL" , [SCPT_INT, SCPT_INT, SCPT_INT, SCPT_INT, SCPT_INT, SCPT_INT]),
	0x36: ("GFX36"  , []),
	0x37: ("XYFLOAD", [SCPT_FNAME]),
	0x38: ("ANDR"   , [SCPT_REG_INT, SCPT_REG_INT]),
	0x39: ("ORR"    , [SCPT_REG_INT, SCPT_REG_INT]),
	0x3A: ("GFX3A"  , [SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT]),
	0x3B: ("GFX3B"  , [SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT]),
	0x3C: ("TXCLR2" , [SCPT_INT, SCPT_INT, SCPT_INT, SCPT_INT, SCPT_BYTE]),
	0x3D: ("MULR"   , [SCPT_REG_IL, SCPT_REG_IL]),
	0x3E: ("DIVR"   , [SCPT_REG_IL, SCPT_REG_IL]),
	0x3F: ("CMD3F"  , [SCPT_REG_INT, SCPT_REG_INT]),
	0x40: ("MENUSEL", [SCPT_REG_INT, SCPT_REG_INT, SCPT_DATA2, SCPT_JUMP], SC_EXEC_SPC),
	0x41: ("CMD41"  , [SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT, SCPT_JUMP]),
	0x42: ("CMD42"  , [SCPT_BYTE]),
	0x43: ("CMD43"  , [SCPT_REG_INT, SCPT_REG_INT]),
	0x44: (None     , []),
	0x45: (None     , []),
	0x46: (None     , []),
	0x47: (None     , []),
	0x48: (None     , []),
	0x49: (None     , []),
	0x4A: ("REGFSAV", [SCPT_BYTE, SCPT_FNAME]),
	0x4B: ("REGFLD" , [SCPT_BYTE, SCPT_FNAME]),
	0x4C: ("CMD4C"  , [SCPT_REG_INT, SCPT_REG_INT]),
	0x4D: ("BGMMEAS", [SCPT_REG_INT]),
	0x4E: ("SFXSSG" , [SCPT_BYTE]),
	0x4F: ("SFXFM"  , [SCPT_BYTE]),
	0x50: ("BGMSTAT", [SCPT_REG_INT]),
	0x51: ("ANDI"   , [SCPT_REG_INT, SCPT_INT]),
	0x52: ("ORI"    , [SCPT_REG_INT, SCPT_INT]),
	0x53: ("STRCAT" , [SCPT_REG_STR, SCPT_REG_STR]),
	0x54: ("CALL"   , [SCPT_JUMP]),
	0x55: ("RET"    , [], SC_EXEC_END),
	0x56: ("STRCMPR", [SCPT_REG_STR, SCPT_REG_STR]),
	0x57: ("STRNCPY", [SCPT_REG_STR, SCPT_REG_STR, SCPT_INT]),
	0x58: ("STRCPYC", [SCPT_REG_STR, SCPT_REG_STR, SCPT_INT]),
	0x59: ("STRCPYI", [SCPT_REG_STR, SCPT_STR]),
	0x5A: ("STRCLR" , [SCPT_REG_STR]),
	0x5B: ("STRCPY" , [SCPT_REG_STR, SCPT_REG_STR]),
	0x5C: (None     , []),
	0x5D: (None     , []),
	0x5E: ("CMD5E"  , [SCPT_BYTE, SCPT_INT, SCPT_INT, SCPT_INT, SCPT_INT]),
	0x5F: ("STRTIME", [SCPT_REG_STR]),
	0x60: ("FILETM" , [SCPT_REG_INT, SCPT_REG_STR, SCPT_FNAME]),
	0x61: ("XYFSAVE", [SCPT_FNAME]),
	0x62: ("CMD62"  , [SCPT_REG_INT, SCPT_REG_INT]),
	0x63: ("GFX63"  , [SCPT_BYTE, SCPT_INT, SCPT_INT, SCPT_INT, SCPT_INT, SCPT_BYTE, SCPT_INT, SCPT_INT]),
	0x64: ("GFX64"  , [SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT]),
	0x65: (None     , []),
	0x66: (None     , []),
	0x67: ("GFX67"  , [SCPT_BYTE, SCPT_BYTE, SCPT_BYTE, SCPT_BYTE]),
	0x68: ("GFX68"  , [SCPT_REG_INT, SCPT_REG_INT]),
	0x69: ("GFX69"  , [SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT]),
	0x6A: ("CMD6A"  , [SCPT_INT, SCPT_INT, SCPT_INT, SCPT_INT]),
	0x6B: ("CMD6B"  , [SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT]),
	0x6C: (None     , []),
	0x6D: (None     , []),
	0x6E: ("STRLEN" , [SCPT_REG_INT, SCPT_REG_STR]),
	0x6F: (None     , []),
	0x70: (None     , []),
	0x71: (None     , []),
	0x72: ("LOOPSTI", [SCPT_INT]),
	0x73: ("LOOPGTR", [SCPT_REG_INT]),
	0x74: ("LOOPJPI", [SCPT_INT, SCPT_JUMP]),
	0x75: ("FONTCHR", [SCPT_INT, SCPT_DATA1]),
	0x76: ("CMD76"  , [SCPT_INT, SCPT_INT, SCPT_INT, SCPT_INT, SCPT_INT, SCPT_INT, SCPT_INT, SCPT_INT]),
	0x77: ("CMD77"  , [SCPT_INT, SCPT_INT, SCPT_INT, SCPT_INT, SCPT_INT, SCPT_INT, SCPT_INT, SCPT_INT]),
	0x78: ("CMD78"  , [SCPT_INT, SCPT_INT]),
	0x79: ("CMD79"  , [SCPT_INT]),
	0x7A: ("LOOPSTR", [SCPT_REG_INT]),
	0x7B: ("LOOPJPR", [SCPT_REG_INT, SCPT_JUMP]),
	0x7C: (None     , []),
	0x7D: (None     , []),
	0x7E: (None     , []),
	0x7F: ("DOSRETR", [SCPT_REG_INT], SC_EXEC_END),
	0x80: ("STRFLD" , [SCPT_REG_STR, SCPT_FNAME]),
	0x81: ("STRFSAV", [SCPT_REG_STR, SCPT_FNAME]),
	0x82: ("GFX82"  , []),
	0x83: ("GFX83"  , [SCPT_REG_INT]),
	0x84: ("GFX84"  , []),
	0x85: ("GFX85"  , []),
	0x86: ("GFX86"  , [SCPT_DATA1]),
	0x87: ("GFX87"  , [SCPT_INT, SCPT_BYTE, SCPT_INT, SCPT_INT, SCPT_BYTE, SCPT_BYTE, SCPT_BYTE, SCPT_BYTE, SCPT_BYTE, SCPT_BYTE]),
	0x88: ("GFX88"  , [SCPT_BYTE, SCPT_INT, SCPT_INT]),
	0x89: ("GFX89"  , [SCPT_DATA1]),
	0x8A: ("GFX8A"  , [SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT]),
	0x8B: ("GFX8B"  , [SCPT_REG_INT, SCPT_INT, SCPT_INT]),
	0x8C: ("GFX8C"  , []),
	0x8D: ("GFX8D"  , []),
	0x8E: ("GFX8E"  , []),
}

TKTP_INT = 0x01	# integer number (byte/word/dword)
TKTP_STR = 0x02	# string
TKTP_NAME = 0x80	# register or label name
TKTP_REG = 0x81	# register
TKTP_LBL = 0x82	# label name

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
	"INCLUDE",	# include other ASM file (currently just ignored)
	"DESC",	# module description: UTF-8 string to be encoded as Shift-JIS
	"DB",	# data: bytes or UTF-8 strings to be encoded as Shift-JIS
	"DW",	# data: words
	"DSJ",	# data: JIS code words, to be encoded as Shift-JIS
}
DATA_KEYWORDS = ["DB", "DW", "DSJ"]
for cdata in SCENE_CMD_LIST.values():
	if cdata[0] is not None:
		KEYWORDS.add(cdata[0])

config = {}


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

def get_nametoken_type(token: str, label_list: list) -> int:
	if len(token) < 1:
		return None
	first_chr = token[0].casefold()
	if first_chr in ['i', 'l', 's']:
		if (len(token) >= 2) and token[1].isdecimal():
			return TKTP_REG
	if token.casefold() in label_list:
		return TKTP_LBL
	else:
		return None

def parse_asm(lines: typing.List[str]):
	cmd_list = []	# list[ CommandItem ) ]
	label_list = {}	# dict{ label name [casefold]: LabelItem }
	
	cmdNum = -1	# we will do pre-increment below
	lastCmdIsData = False
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
				print(f"Error in line {1+lid}: Label without colon")
				return None
			label_name = line[0:pos]
			lbl_nm_cf = label_name.casefold()
			if lbl_nm_cf in label_list:
				print(f"Error in line {1+lid}: Label '{label_name}' is already defined")
				return None
			label_list[lbl_nm_cf] = LabelItem(cmdID=len(cmd_list), lineID=lid, lblName=label_name)	# just store command index
			startpos = pos + 1
			lastCmdIsData = False	# enforce starting a new command
		startpos = find_next_token(line, startpos)
		if startpos >= len(line) or line[startpos] == ';':
			continue
		
		(_, keyword, pos) = get_token_name(line, startpos, True)
		if keyword.upper() not in KEYWORDS:
			print(f"Error in line {1+lid}: Unknown keyword '{keyword}'")
			return None
		pos = find_next_token(line, pos)
		
		citem = CommandItem(lineID = lid, cmdName = keyword.upper())
		citem.params = []
		while pos < len(line):
			tpos = pos
			res = get_token(line, pos)
			if res is None:
				print(f"Error in line {1+lid}: Parsing error!")	# TODO: print details
				return None
			(ttype, tdata, pos) = res
			citem.params += [ParamToken(ttype, tdata, tpos)]
			pos = find_next_token(line, pos)	# skip spaces
			if pos >= len(line):
				break
			if line[pos] == ';':	# comment
				break
			if line[pos] != ',':
				print(f"Error in line {1+lid}: Expected comma at position {1+pos}")
				return None
			pos = find_next_token(line, pos+1)	# skip spaces
		#print((lid, keyword, citem.params))
		
		isDataCmd = (citem.cmdName in DATA_KEYWORDS)
		if (isDataCmd and lastCmdIsData):
			# treat consecutive data commands as a single unit
			citem.cmdNum = cmdNum
		elif citem.cmdName == "DESC":
			# ignore DESC command
			citem.cmdNum = None
		else:
			cmdNum += 1	# increment command number
			citem.cmdNum = cmdNum
		lastCmdIsData = isDataCmd
		
		cmd_list += [citem]
	
	for (cid, citem) in enumerate(cmd_list):
		for (pid, pitem) in enumerate(citem.params):
			if pitem.type == TKTP_NAME:
				# resolve to TKTP_REG / TKTP_LBL
				new_type = get_nametoken_type(pitem.data, label_list)
				if new_type is not None:
					pitem.type = new_type
					citem.params[pid] = pitem
			if pitem.type == TKTP_LBL:
				lncf = pitem.data.casefold()
				if lncf not in label_list:
					print(f"Error in line {1+citem.lineID}: Label {pitem.data} is undefined!")
					return None
				lbl_cid = label_list[lncf].cmdID
				if lbl_cid < len(cmd_list):
					lbl_cmd = cmd_list[lbl_cid]
					pitem.cmdOfs = lbl_cmd.cmdNum - citem.cmdNum
				else:
					pitem.cmdOfs = cmd_list[-1].cmdNum + 1 - citem.cmdNum
				citem.params[pid] = pitem
	
	return (cmd_list, label_list)

def load_asm(fn_in: str) -> typing.List[str]:
	with open(fn_in, "rt", encoding="utf-8") as f:
		return f.readlines()

def write_asm(asm_lines: typing.List[str], fn_out: str) -> None:
	with open(fn_out, "wt", encoding="utf-8") as f:
		f.write("".join(asm_lines))
	return

def check_for_cmd_match(src_cmds: tuple, src_cmd: int, inc_cmds: tuple) -> tuple:
	for cid in range(len(inc_cmds)):
		ic = inc_cmds[cid]
		sc = src_cmds[src_cmd + cid]
		if ic.cmdName != sc.cmdName:
			return False
		
		for (pid, ip) in enumerate(ic.params):
			sp = sc.params[pid]
			if ip.type != sp.type:
				if ip.type == TKTP_NAME or sp.type == TKTP_NAME:
					# unresolved name (-> unreferenced label)
					continue # just assume it matches
				return False	# mismatching types
			if ip.type == TKTP_LBL:
				if (ip.cmdOfs is not None) and (ip.cmdOfs != sp.cmdOfs):
					return False	# label references to different (relative) offset
				continue	# assume that labels
			if ip.data != sp.data:
				return False	# non-matching data
	return True

def search_for_match(src_data: tuple, inc_data: tuple) -> tuple:
	(src_cmds, src_labels) = src_data
	(inc_cmds, inc_labels) = inc_data
	for cid in range(len(src_cmds) - len(inc_cmds) + 1):
		res = check_for_cmd_match(src_cmds, cid, inc_cmds)
		if res:
			cd = src_cmds[cid]
			#print(f"Match found at line {cd.lineID}, cmd {cd.cmdNum}: {cd.cmdName}")
			return cid
	return None

def build_label_replacement_table(src_data: tuple, inc_data: tuple, match_start_cmd: int) -> dict:
	(src_cmds, src_labels) = src_data
	(inc_cmds, inc_labels) = inc_data
	
	res = {}
	for (ilkey, ilbl) in inc_labels.items():
		slkey = [l for l in src_labels if src_labels[l].cmdID == match_start_cmd + ilbl.cmdID][0]
		slbl = src_labels[slkey]
		#print(f"{slbl.lblName} -> {ilbl.lblName}")
		res[slkey] = ilkey
	
	return res

def get_include_range(src_data: tuple, inc_data: tuple, match_start_cmd: int) -> tuple:
	(src_cmds, src_labels) = src_data
	(inc_cmds, inc_labels) = inc_data
	
	line_start = src_cmds[match_start_cmd].lineID
	match_end_cmd = match_start_cmd + len(inc_cmds)
	# 1. Take the last command *inside* the section. (-> end_cmd-1)
	# 2. Its line must be included. (end_line = last_cmd.lineID + 1)
	line_end = src_cmds[match_end_cmd - 1].lineID + 1
	#print(f"Initial inc range: {(line_start, line_end)}")
	
	# 3. try to extend the section based on labels that are part of the include file.
	for (ilkey, ilbl) in inc_labels.items():
		# Looping based on the labels is inefficient, but I'll go with this for safety.
		# (i.e. the include file must have a label that we may replace)
		if ilbl.cmdID == 0 or ilbl.cmdID == len(inc_cmds):
			slkey = [l for l in src_labels if src_labels[l].cmdID == match_start_cmd + ilbl.cmdID][0]
			slbl = src_labels[slkey]
			if ilbl.cmdID == 0:
				line_start = min([line_start, slbl.lineID])
			elif ilbl.cmdID == len(inc_cmds):
				line_end = max([line_end, slbl.lineID + 1])
	#print(f"Adjusted inc range: {(line_start, line_end)}")
	
	return (line_start, line_end)

def debug_dump_data(value: typing.Any) -> str:
	if type(value) is str:
		return f'"{value}"'
	else:
		return str(value)
def debug_dump_param(param: ParamToken) -> str:
	if param.cmdOfs is not None:
		return debug_dump_data(param.data) + f"/{param.cmdOfs:+}"
	else:
		#f"type={param.type:02X}, data={dump_data(param.data)}"
		return debug_dump_data(param.data)
def debug_dump_parsed_asm(cmd_list: typing.List[CommandItem], label_list: typing.List[LabelItem], prefix: str, file) -> None:
	if True:
		file.write(f"{prefix}label_list:\n")
		for (lid, lblkey) in enumerate(label_list):
			ld = label_list[lblkey]
			file.write(f"\t{lid} line {ld.lineID} = ({ld.cmdID}, {ld.lblName})\n")
	
	file.write(f"{prefix}cmd_list:\n")
	for cid, cd in enumerate(cmd_list):
		pdata = [debug_dump_param(p) for p in cd.params]
		file.write(f"\t{cid} line {cd.lineID}, cmd {cd.cmdNum}: " + ", ".join([cd.cmdName] + pdata) + "\n")

def insert_code_include(fn_in: str, fn_out: str, fn_inc: str) -> int:
	try:
		inc_lines = load_asm(fn_inc)
	except IOError:
		print(f"Error loading {fn_inc}")
		return 1
	ret = parse_asm(inc_lines)
	if ret is None:
		return 1
	(inc_cmd_list, inc_label_list) = ret
	fn_inc_title = os.path.basename(fn_inc)
	
	try:
		asm_lines = load_asm(fn_in)
	except IOError:
		print(f"Error loading {fn_in}")
		return 1
	ret = parse_asm(asm_lines)
	if ret is None:
		return 1
	(cmd_list, label_list) = ret
	
	#with open("data_dump.txt", "wt", encoding="utf-8") as f:
	#	debug_dump_parsed_asm(inc_cmd_list, inc_label_list, "inc_", f)
	#	f.write("\n")
	#	debug_dump_parsed_asm(cmd_list, label_list, "", f)
	
	match_cmd = search_for_match((cmd_list, label_list), (inc_cmd_list, inc_label_list))
	if match_cmd is None:
		print("No match found.")
		return 0
	
	lbl_replace_tbl = build_label_replacement_table((cmd_list, label_list), (inc_cmd_list, inc_label_list), match_cmd)
	inc_range = get_include_range((cmd_list, label_list), (inc_cmd_list, inc_label_list), match_cmd)
	print(f"Replacing lines [{1+inc_range[0]}, {inc_range[1]}] ...")
	
	# do the actual replacement
	lbl_replace_re = {}
	for (srclbl, dstlbl) in lbl_replace_tbl.items():
		lbl_replace_re[srclbl] = re.compile(re.escape(label_list[srclbl].lblName), re.IGNORECASE)
	
	asm_new_lines = asm_lines[: inc_range[0]] + [f'\tinclude "{fn_inc_title}"\n'] + asm_lines[inc_range[1] :]
	for (lid, line) in enumerate(asm_new_lines):
		for (srclbl, dstlbl) in lbl_replace_tbl.items():
			# the keys are casefolded - here I want to use the original label names
			#line = line.replace(label_list[srclbl].lblName, inc_label_list[dstlbl].lblName)
			line = lbl_replace_re[srclbl].sub(inc_label_list[dstlbl].lblName, line)
		asm_new_lines[lid] = line
	
	try:
		write_asm(asm_new_lines, fn_out)
		print("Done.")
	except IOError:
		print(f"Error writing {fn_out}")
		return 1
	return 0

def main(argv):
	global config
	
	print("System-98 Scenario Include File Inserter")
	aparse = argparse.ArgumentParser()
	aparse.add_argument("-i", "--include", type=str, required=True, help="assembly file (.ASM) with common code that should be included")
	aparse.add_argument("in_file", help="input assembly file (.ASM)")
	aparse.add_argument("out_file", help="output assembly file (.ASM) with include data removed")
	
	config = aparse.parse_args(argv[1:])
	
	return insert_code_include(config.in_file, config.out_file, config.include)

if __name__ == "__main__":
	sys.exit(main(sys.argv))
