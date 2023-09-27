#!/usr/bin/env python3
import sys
import os
import struct
import typing
import argparse
import nec_jis_conv


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

LBLFLG_UNUSED = 0x01
LBLFLG_MENU = 0x10

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
	"DESC",	# module description: UTF-8 string to be encoded as Shift-JIS
	"DB",	# data: bytes or UTF-8 strings to be encoded as Shift-JIS
	"DW",	# data: words
	"DSJ",	# data: JIS code words, to be encoded as Shift-JIS
}
for cdata in SCENE_CMD_LIST.values():
	if cdata[0] is not None:
		KEYWORDS.add(cdata[0])

JISCHR_COMMENTS = {}
necjis = nec_jis_conv.JISConverter()
config = {}
MOD_DESC_LEN = 0x100	# first 0x100 bytes are reserved for the module description


def load_additional_font_table(filepath: str) -> int:
	global necjis
	global JISCHR_COMMENTS
	
	with open(filepath, "rt", encoding="utf-8") as f:
		for line in f:
			line = line.rstrip()
			items = line.split('\t')
			for (iid, item) in enumerate(items):
				if item.lstrip().startswith('#'):
					items = items[0:iid]
					break
			if len(items) <= 1:
				continue
			
			# parse table
			jis_code = int(items[0], 0)
			ucode_str = items[1]
			if ucode_str.startswith('U'):
				ucodes_strs = ucode_str.split('+')[1:]
				ucodes = [int(uc, 0x10) for uc in ucodes_strs]
				
				ins = necjis.add_character(jis_code, ucodes)
				if not ins:
					print(f"Warning: Replacing JIS character 0x{jis_code:04X}.")
			elif (len(ucode_str) == 0) or (ucode_str.startswith('-')):
				pass	# undefined character (comment only)
			else:
				print(f"Error in line: {line}")
				continue
			if len(items) > 2:
				JISCHR_COMMENTS[jis_code] = items[2]
	necjis.recalc_decode_lut()

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

def read_token_reg(token: str) -> typing.Tuple[str, int]:	# returns tuple(reg type, reg number)
	if len(token) < 1:
		return None
	first_chr = token[0].casefold()
	if first_chr in ['i', 'l', 's']:
		try:
			return (first_chr, int(token[1:], 10))
		except:
			return None
	else:
		return None

def parse_asm(lines: typing.List[str]):
	cmd_list = []	# list[ tuple(line ID, command name, list[params] ) ]
	label_list = {}	# dict{ label name [casefold]: (command ID, label name [original]) }
	
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
			label_list[lbl_nm_cf] = (len(cmd_list), label_name)	# just store command index
			startpos = pos + 1
		startpos = find_next_token(line, startpos)
		if startpos >= len(line) or line[startpos] == ';':
			continue
		
		(_, keyword, pos) = get_token_name(line, startpos, True)
		if keyword.upper() not in KEYWORDS:
			print(f"Error in line {1+lid}: Unknown keyword '{keyword}'")
			return None
		pos = find_next_token(line, pos)
		
		params = []
		while pos < len(line):
			tpos = pos
			res = get_token(line, pos)
			if res is None:
				print(f"Error in line {1+lid}: Parsing error!")	# TODO: print details
				return None
			(ttype, tdata, pos) = res
			params += [(ttype, tdata, tpos)]
			pos = find_next_token(line, pos)	# skip spaces
			if pos >= len(line):
				break
			if line[pos] == ';':	# comment
				break
			if line[pos] != ',':
				print(f"Error in line {1+lid}: Expected comma at position {1+pos}")
				return None
			pos = find_next_token(line, pos+1)	# skip spaces
		#print((lid, keyword, params))
		
		cmd_list += [(lid, keyword.upper(), params)]
	
	return (cmd_list, label_list)

def generate_binary(cmd_list, label_list) -> bytes:
	KEYWORD2CMD = {}
	for (key, item) in SCENE_CMD_LIST.items():
		cmd_name = item[0]
		if cmd_name is not None:
			KEYWORD2CMD[cmd_name] = key
	
	# generate byte stream with placeholders for labels
	mod_desc = bytearray()
	data = bytearray()
	start_ofs = config.base_ofs + MOD_DESC_LEN
	cmd_ofs_list = []
	lbl_write_list = []	# list[ tuple(file_pos, label_name, line_id) ]
	for (lid, keyword, params) in cmd_list:
		cmd_ofs_list += [len(data)]
		if keyword == "DESC":
			for (ttype, tdata, linepos) in params:
				if ttype == TKTP_INT:
					try:
						if tdata < 0:
							mod_desc += struct.pack("<b", tdata)
						else:
							mod_desc += struct.pack("<B", tdata)
					except:
						print(f"Error in line {1+lid}, column {1+linepos}: value doesn't fit into 8 bits!")
						return None
				elif ttype == TKTP_STR:
					value = necjis.sjis_encode_str(tdata)
					if type(value) is not bytes:
						print(f"Error in line {1+lid}, column {1+linepos}: Unable to convert string to Shift-JIS!")
						return None
					mod_desc += value
				else:
					print(f"Error in line {1+lid}, column {1+linepos}: expected integer or string!")
					return None
		elif keyword == "DB":
			for (ttype, tdata, linepos) in params:
				if ttype == TKTP_INT:
					try:
						if tdata < 0:
							data += struct.pack("<b", tdata)
						else:
							data += struct.pack("<B", tdata)
					except:
						print(f"Error in line {1+lid}, column {1+linepos}: value doesn't fit into 8 bits!")
						return None
				elif ttype == TKTP_STR:
					value = necjis.sjis_encode_str(tdata)
					if type(value) is not bytes:
						print(f"Error in line {1+lid}, column {1+linepos}: Unable to convert string to Shift-JIS!")
						return None
					data += value
				else:
					print(f"Error in line {1+lid}, column {1+linepos}: expected integer or string!")
					return None
		elif keyword == "DW":
			for (ttype, tdata, linepos) in params:
				if ttype == TKTP_NAME:
					ttype = get_nametoken_type(tdata, label_list)
				if ttype == TKTP_INT:
					try:
						if tdata < 0:
							data += struct.pack("<h", tdata)
						else:
							data += struct.pack("<H", tdata)
					except:
						print(f"Error in line {1+lid}, column {1+linepos}: value doesn't fit into 16 bits!")
						return None
				elif ttype == TKTP_LBL:
					lbl_write_list += [(len(data), tdata, lid)]
					data += struct.pack("<H", 0xAAAA)
				else:
					print(f"Error in line {1+lid}, column {1+linepos}: expected integer or label!")
					return None
		elif keyword == "DSJ":
			for (ttype, tdata, linepos) in params:
				if ttype != TKTP_INT:
					print(f"Error in line {1+lid}, column {1+linepos}: expected integer!")
					return None
				try:
					value = necjis.jis2sjis(tdata)
					data += struct.pack(">H", value)	# value must be written in Big Endian order
				except:
					print(f"Error in line {1+lid}, column {1+linepos}: Unable to JIS code to Shift-JIS!")
					return None
		elif keyword in KEYWORD2CMD:
			cmd_id = KEYWORD2CMD[keyword]
			cmd_item = SCENE_CMD_LIST[cmd_id]
			cmd_params = cmd_item[1]
			if len(params) != len(cmd_params):
				print(f"Error in line {1+lid}: parameters: {len(params)}, requires {len(cmd_params)}")
				return None
			
			data += struct.pack("<H", cmd_id)
			cur_reg_type = SCPT_INT	# default to 16-bit integer
			for (par_id, (ttype, tdata, linepos)) in enumerate(params):
				cptype = cmd_params[par_id]
				cptmask = cptype & SCPT_MASK
				if cptmask == SCPTM_VAL:
					if ttype != TKTP_INT:
						print(f"Error in line {1+lid}, column {1+linepos}: expected integer!")
						return None
					if cptype == SCPT_ILVAR:
						cptype = cur_reg_type	# expected type base on previously accessed register
					if cptype == SCPT_BYTE:
						val_fmt = "B"
					elif cptype == SCPT_INT:
						val_fmt = "H"
					elif cptype == SCPT_LONG:
						val_fmt = "I"
					else:
						return None
					if tdata < 0:
						val_fmt = val_fmt.lower()	# write signed value
					try:
						if cptype == SCPT_BYTE:
							data += struct.pack("<" + val_fmt, tdata) + b'\x00'	# byte values needs 2-byte alignment
						else:
							data += struct.pack("<" + val_fmt, tdata)
					except Exception as e:
						print(f"Error in line {1+lid}, column {1+linepos}: value too large!")
						print(e)
						return None
				elif cptmask == SCPTM_PTR:
					if ttype == TKTP_NAME: # set to TKTP_NAME for labels
						lbl_write_list += [(len(data), tdata, lid)]
						data += struct.pack("<H", 0xAAAA)
					else:
						data += struct.pack("<H", tdata)
				elif cptmask == SCPTM_REG:
					if ttype == TKTP_NAME:
						ttype = get_nametoken_type(tdata, label_list)
					if ttype != TKTP_REG:
						print(f"Error in line {1+lid}, column {1+linepos}: expected register name!")
						return None
					reg_info = read_token_reg(tdata)
					if reg_info is None:
						print(f"Error in line {1+lid}, column {1+linepos}: Invalid register {tdata}!")
						return None
					
					(reg_type, reg_id) = reg_info
					if cptype == SCPT_REG_INT:
						if reg_type != 'i':
							print(f"Error in line {1+lid}, column {1+linepos}: Require integer register!")
							return None
						cur_reg_type = SCPT_INT
						if reg_id >= 0x400+20:
							print(f"Warning in line {1+lid}: using out-of-range register {tdata}")
					elif cptype == SCPT_REG_LNG:
						if reg_type != 'l':
							print(f"Error in line {1+lid}, column {1+linepos}: Require long-int register!")
							return None
						cur_reg_type = SCPT_LNG
						if reg_id >= 10:
							print(f"Warning in line {1+lid}: using out-of-range register {tdata}")
					elif cptype == SCPT_REG_IL:
						if reg_type == 'i':
							cur_reg_type = SCPT_INT
						elif reg_type == 'l':
							cur_reg_type = SCPT_REG_LNG
							reg_id += 0x400
						else:
							print(f"Error in line {1+lid}, column {1+linepos}: Require int/long register!")
							return None
						if reg_id >= 0x400+20:
							print(f"Warning in line {1+lid}: using out-of-range register {tdata}")
					elif cptype == SCPT_REG_STR:
						if reg_type != 's':
							print(f"Error in line {1+lid}, column {1+linepos}: Require string register!")
							return None
						if reg_id >= 50:
							print(f"Warning in line {1+lid}: using out-of-range register {tdata}")
					data += struct.pack("<H", reg_id)
				else:
					print(f"Internal error in line {1+lid}: Unknown parameter type 0x{cptype:02X}!")
					return None
		else:
			print(f"Error in line {1+lid}: Unknown keyword '{keyword}'")
			return None
	
	# pad module description with 00s
	mod_desc = mod_desc[:MOD_DESC_LEN].ljust(MOD_DESC_LEN, b'\x00')
	
	# Now write all pointers that reference labels. (Their exact offsets were previously unknown.)
	for (srcofs, lblname, lid) in lbl_write_list:
		lncf = lblname.casefold()
		if lncf not in label_list:
			print(f"Error in line {1+lid}: Label {lblname} is undefined!")
			return None
		cmd_id = label_list[lncf][0]
		dstofs = start_ofs + cmd_ofs_list[cmd_id]
		#print(f"Cmd {cmd_id} Name {lblname} -> ptr at 0x{srcofs:04X} = 0x{dstofs:04X}")
		struct.pack_into("<H", data, srcofs, dstofs)
	
	return mod_desc + data

def load_asm(fn_in: str) -> typing.List[str]:
	with open(fn_in, "rt", encoding="utf-8") as f:
		return f.readlines()

def write_scene_binary(fn_out: str, data: bytes) -> None:
	with open(fn_out, "wb") as f:
		f.write(data[:MOD_DESC_LEN])	# the module description is unencrypted
		if config.unscrambled:
			f.write(data[MOD_DESC_LEN:])
		else:
			# The rest is encrypted using XOR 0x01
			f.write(bytes([x ^ 0x01 for x in data[MOD_DESC_LEN:]]))
	return

def compile_scene(fn_in: str, fn_out: str) -> int:
	try:
		asm_lines = load_asm(fn_in)
	except IOError:
		print(f"Error loading {fn_in}")
		return 1
	ret = parse_asm(asm_lines)
	if ret is None:
		return 1
	(cmd_list, label_list) = ret
	data = generate_binary(cmd_list, label_list)
	if data is None:
		return 2
	
	try:
		write_scene_binary(fn_out, data)
		print("Done.")
	except IOError:
		print(f"Error writing {fn_out}")
		return 1
	return 0

def auto_int(x):
	return int(x, 0)

def main(argv):
	global config
	global necjis
	
	print("four-nine/Izuho Saruta System-98 Scenario Compiler")
	aparse = argparse.ArgumentParser()
	aparse.add_argument("-b", "--base-ofs", type=auto_int, help="set base/load offset of the scenario file", default=0x0000)
	aparse.add_argument("-f", "--font-file", type=str, help="description file for custom font characters")
	aparse.add_argument("-u", "--unscrambled", action="store_true", help="output the file unscrambled")
	aparse.add_argument("in_file", help="input assembly file (.ASM)")
	aparse.add_argument("out_file", help="output scenario file (.S)")
	
	config = aparse.parse_args(argv[1:])
	
	necjis.load_from_pickle("NEC-C-6226-lut.pkl")
	if config.font_file:
		load_additional_font_table(config.font_file)
	return compile_scene(config.in_file, config.out_file)

if __name__ == "__main__":
	sys.exit(main(sys.argv))
