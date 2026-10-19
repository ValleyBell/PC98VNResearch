#!/usr/bin/env python3
# Written by Valley Bell, 2026-10-14
# based on MIME Scenario Compiler
import sys
import os
import dataclasses
import struct
import typing
import argparse
import nec_jis_conv


@dataclasses.dataclass
class ParamToken:
	type: int	# token type
	data: typing.Union[int, str]	# token data
	pos: int	# start position on current line

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


# Script Command Parameter Types
SCPT_MASK = 0xF0
SCPTM_VAL = 0x00	# immediate value
SCPTM_PTR = 0x10	# pointer
SCPTM_DATA = 0x20	# misc data
SCPTM_REG = 0x80	# register

SCPT_BYTE = 0x01	# "byte" (2-byte parameter, high byte ignored)
SCPT_INT = 0x02		# 2-byte integer
SCPT_LONG = 0x03	# 4-byte integer
SCPT_HEX = 0x08		# integer, output as hexadecimal
SCPT_BYTEH = SCPT_BYTE | SCPT_HEX
SCPT_INTH = SCPT_INT | SCPT_HEX

SCPT_JUMP = 0x10	# jump destination pointer
SCPT_DATA1 = 0x20	# data array (1-byte groups)
SCPT_DATA2 = 0x21	# data array (2-byte groups)
SCPT_FNAME = 0x22	# string, 1 byte per charater, terminated with 00h
SCPT_STR = 0x23		# string, 1 byte per charater, terminated with 00h
SCPT_PTRS = 0x24	# list of pointers (2 bytes per pointer)

SCPT_REG = 0x80		# register ID
SCPT_REGVAL = 0x81	# byte value or register ID

SC_EXEC_END = 0x01	# terminate script execution here
SC_EXEC_SPC = 0xFF	# special handling

SCRIPT_CMD_LIST = {
	# 1-byte command IDs
	(0x01,): ("PRINT01", [SCPT_STR]),
	(0x02,): ("PRINT02", [SCPT_STR]),
	(0x03,): ("CMD03",   [SCPT_BYTE, SCPT_BYTE, SCPT_BYTE]),
	(0x04,): ("SELITEM", [SCPT_STR, SCPT_JUMP]),
	(0x05,): ("SELEXEC", [], SC_EXEC_END),
	(0x06,): ("SEL06",   []),
	(0x07,): ("SELINIT", []),
	(0x08,): ("CALL",    [SCPT_JUMP]),
	(0x09,): ("JP",      [SCPT_JUMP], SC_EXEC_END),
#	(0x0A,): ("UNDEF0A", []),
	(0x0B,): ("VARCMP",  [SCPT_DATA1], SC_EXEC_SPC),
#	(0x0C,): ("UNDEF0C", []),
#	(0x0D,): ("UNDEF0D", []),
#	(0x0E,): ("UNDEF0E", []),
	(0x0F,): ("CMD0F",   [SCPT_BYTE]),
	(0x10,): ("CMD10",   [SCPT_BYTE, SCPT_STR, SCPT_STR]),
#	(0x11,): ("UNDEF11", []),
	(0x12,): ("BGMPLAY", [SCPT_FNAME]),
	(0x13,): ("CMD13",   [SCPT_FNAME, SCPT_INT, SCPT_INT]),
	(0x14,): ("CMD14",   [SCPT_FNAME]),
#	(0x15,): ("UNDEF15", []),
	(0x16,): ("CMD16",   [SCPT_BYTE, SCPT_JUMP, SCPT_JUMP]),
	(0x17,): ("CMD17",   []),
#	(0x18,): ("UNDEF18", []),
	(0x19,): ("CMD19",   [SCPT_FNAME]),
	(0x1A,): ("CMD1A",   [SCPT_FNAME, SCPT_BYTE]),
	(0x1B,): ("QUIT1B",  [], SC_EXEC_END),
	(0x1C,): ("CMD1C",   []),	# conditional return/quit?
	(0x1D,): ("CMD1D",   []),
#	(0x1E,): ("UNDEF1E", []),
	(0x1F,): ("CMD1F",   [SCPT_BYTE, SCPT_BYTE]),
	(0x20,): ("DSPLOC0", [SCPT_STR]),
	(0x21,): ("DSPLOC1", [SCPT_STR]),
#	(0x22,): ("UNDEF22", []),
#	(0x23,): ("UNDEF23", []),
#	(0x24,): ("UNDEF24", []),
#	(0x25,): ("UNDEF25", []),
	(0x26,): ("CMD26",   [SCPT_STR, SCPT_STR]),
	(0x27,): ("CMD27",   [SCPT_STR]),
	(0x28,): ("CMD28",   [SCPT_BYTE]),
	(0x29,): ("CMD29",   [SCPT_BYTE, SCPT_STR, SCPT_STR]),
	(0x2A,): ("WAIT",    [SCPT_BYTE]),
	(0x2B,): ("CMD2B",   [SCPT_BYTE]),
	(0x2C,): ("NOP2C",   []),
	(0x2D,): ("VARSET",  [SCPT_REG, SCPT_REGVAL]),
	(0x2E,): ("VARADD",  [SCPT_REG, SCPT_REGVAL]),
	(0x2F,): ("VARSUB",  [SCPT_REG, SCPT_REGVAL]),
	(0x30,): ("JPVAR",   [SCPT_REG, SCPT_BYTE, SCPT_PTRS]),
	(0x31,): ("NOP31",   []),
	(0x32,): ("RET",     [], SC_EXEC_END),
#	(0x33,): ("UNDEF33", []),
	(0x34,): ("METACMD", [SCPT_BYTEH], SC_EXEC_SPC),
	(0x35,): ("JP2",     [SCPT_JUMP], SC_EXEC_END),
#	(0x36,): ("UNDEF36", []),
	(0x37,): ("COLSET",  [SCPT_BYTE, SCPT_BYTEH, SCPT_BYTEH, SCPT_BYTEH]),
	(0x38,): ("PALFADE", [SCPT_BYTE]),
	(0x39,): ("TBX39",   [SCPT_BYTE]),
	(0x3A,): ("TBX3A",   [SCPT_BYTE]),
	(0x3B,): ("LDSCR",   [SCPT_FNAME]),
	(0x3C,): ("QUIT",    [], SC_EXEC_END),
	# 2-byte command IDs
	(0x34, 0x00): ("MCMD00",  []),
	(0x34, 0x01): ("MCMD01",  [SCPT_BYTE, SCPT_INT, SCPT_INT, SCPT_INT, SCPT_INT]),
#	(0x34, 0x02): ("NOP_M02", []),
	(0x34, 0x03): ("MCMD03",  [SCPT_BYTE, SCPT_BYTE]),
	(0x34, 0x04): ("MCMD04",  [SCPT_STR]),
	(0x34, 0x05): ("MCMD05",  [SCPT_BYTE, SCPT_BYTE]),
#	(0x34, 0x06): ("NOP_M06", []),
	(0x34, 0x07): ("MCMD07",  [SCPT_BYTE, SCPT_BYTE]),
	(0x34, 0x08): ("MCMD08",  [SCPT_BYTE]),
	(0x34, 0x09): ("MCMD09",  [SCPT_BYTE]),
	# 0x0A..0x0B - no operation
	(0x34, 0x0A): ("NOP_M0A", []),	# undefined meta command (falls back to NOP), but used by the game
	(0x34, 0x0C): ("MCMD0C",  [SCPT_BYTE, SCPT_INT]),
	(0x34, 0x0D): ("MCMD0D",  [SCPT_BYTE]),
	(0x34, 0x0E): ("MCMD0E",  [SCPT_FNAME]),
	# 0x0F..0x11 - no operation
	(0x34, 0x12): ("DSP_X",   [SCPT_BYTE, SCPT_STR]),
#	(0x34, 0x13): ("NOP_M13", []),
	(0x34, 0x14): ("DSP_XY",  [SCPT_BYTE, SCPT_BYTE, SCPT_STR]),
#	(0x34, 0x15): ("NOP_M15", []),
	(0x34, 0x16): ("MCMD16",  [SCPT_BYTE]),
	(0x34, 0x17): ("FWAIT",   [SCPT_FNAME]),
	(0x34, 0x18): ("SAVGAME", [SCPT_BYTE]),
	(0x34, 0x19): ("MCMD19",  [SCPT_BYTE, SCPT_INT]),
	# 0x1A..0x1D - no operation
	(0x34, 0x1E): ("MCMD1E",  [SCPT_FNAME, SCPT_INT, SCPT_INT]),
	(0x34, 0x1F): ("MCMD1F",  []),
	(0x34, 0x20): ("MCMD20",  []),
	(0x34, 0x21): ("MCMD21",  []),
	(0x34, 0x22): ("MCMD22",  [SCPT_BYTE, SCPT_BYTE]),
	(0x34, 0x23): ("FCHK",    [SCPT_FNAME, SCPT_REG]),
	(0x34, 0x24): ("MCMD24",  [SCPT_BYTE, SCPT_BYTE]),
	(0x34, 0x25): ("MCMD25",  [SCPT_STR, SCPT_BYTE, SCPT_INT, SCPT_INT]),
	(0x34, 0x26): ("MCMD26",  [SCPT_BYTE, SCPT_BYTE]),
	(0x34, 0x27): ("MCMD27",  [SCPT_STR]),
	(0x34, 0x28): ("MCMD28",  [SCPT_BYTE, SCPT_BYTE]),
	(0x34, 0x29): ("MCMD29",  [SCPT_BYTE, SCPT_BYTE]),
	# 0x2A..0x31 - no operation
	(0x34, 0x32): ("MCMD32",  []),
	(0x34, 0x33): ("MCMD33",  []),
	# 0x34..0x3B - no operation
	(0x34, 0x3C): ("MCMD3C",  []),
	(0x34, 0x3D): ("MCMD3D",  []),
	(0x34, 0x3E): ("MCMD3E",  []),
	(0x34, 0x3F): ("MCMD3F",  []),
	# 0x40..0x4F - no operation
	(0x34, 0x46): ("NOP_M46", []),	# undefined meta command (falls back to NOP), but used by the game
	(0x34, 0x50): ("MCMD50",  []),
	(0x34, 0x51): ("MCMD51",  []),
	# 0x52..0x59 - no operation
	(0x34, 0x5A): ("MCMD5A",  []),
	# 0x5B..0xFF - no operation
}

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
	# special codes
	'w': '\x01',	# "wait" code
	';': '\x02',	# "continue" code
}
TOKEN_ALPHABET = [chr(x) for x in \
	[x for x in range(0x30, 0x3A)] + \
	[x for x in range(0x41, 0x5B)] + \
	[x for x in range(0x61, 0x7B)]] + ["_"]
KEYWORDS = {
	"INCLUDE",	# include other ASM file
	"DB",	# data: bytes or ASCII strings
	"DW",	# data: words
}
for cdata in SCRIPT_CMD_LIST.values():
	if cdata[0] is not None:
		KEYWORDS.add(cdata[0])

MODULE_PATH = os.path.dirname(__file__)
necjis = nec_jis_conv.JISConverter()
config = {}


def load_additional_font_table(filepath: str) -> int:
	global necjis
	
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

def get_nametoken_type(token: str, label_list: list) -> int:
	if len(token) < 1:
		return None
	first_chr = token[0].casefold()
	if first_chr == 'r':
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
	if first_chr == 'r':
		try:
			return (first_chr, int(token[1:], 10))
		except:
			return None
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
		if keyword.upper() not in KEYWORDS:
			print(f"Parse error in {asm_filename}:{1+lid}: Unknown keyword '{keyword}'")
			return None
		pos = find_next_token(line, pos)
		
		arrays_open = 0
		citem = CommandItem(asmFile=asm_filename, lineID=lid, cmdName=keyword.upper(), params=[])
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
			citem.params += [ParamToken(ttype, tdata, pos)]
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

def ascii_encode_str(data: str) -> typing.Union[bytes, tuple]:
	result = bytearray()
	for (idx, c) in enumerate(data):
		c = ord(c)
		if c >= 0x80:
			return (idx, bytes(result))
		result.append(c)
	return bytes(result)

def generate_binary(cmd_list, label_list) -> bytes:
	KEYWORD2CMD = {}
	for (key, item) in SCRIPT_CMD_LIST.items():
		cmd_name = item[0]
		if cmd_name is not None:
			KEYWORD2CMD[cmd_name] = key
	
	# generate byte stream with placeholders for labels
	data = bytearray()
	start_ofs = 0x0000
	cmd_ofs_list = []
	lbl_write_list = []	# list[ tuple(file_pos, label_name, line_id, asm_filename) ]
	for citem in cmd_list:
		cmd_ofs_list += [len(data)]
		if citem.cmdName == "DB":
			for pitem in citem.params:
				if pitem.type == TKTP_INT:
					try:
						if pitem.data < 0:
							data += struct.pack("<b", pitem.data)
						else:
							data += struct.pack("<B", pitem.data)
					except:
						print(f"Error in {citem.asmFile}:{1+citem.lineID}, column {1+pitem.pos}: value doesn't fit into 8 bits!")
						return None
				elif pitem.type == TKTP_STR:
					value = ascii_encode_str(pitem.data)
					if type(value) is not bytes:
						print(f"Error in {citem.asmFile}:{1+citem.lineID}, column {1+pitem.pos+value[0]}: Only printable ASCII characters are allowed!")
						return None
					data += value
				else:
					print(f"Error in {citem.asmFile}:{1+citem.lineID}, column {1+pitem.pos}: expected integer or string!")
					return None
		elif citem.cmdName == "DW":
			for pitem in citem.params:
				if pitem.type == TKTP_NAME:
					pitem.type = get_nametoken_type(pitem.data, label_list)
				if pitem.type == TKTP_INT:
					try:
						if pitem.data < 0:
							data += struct.pack("<h", pitem.data)
						else:
							data += struct.pack("<H", pitem.data)
					except:
						print(f"Error in {citem.asmFile}:{1+citem.lineID}, column {1+pitem.pos}: value doesn't fit into 16 bits!")
						return None
				elif pitem.type == TKTP_LBL:
					lbl_write_list += [(len(data), pitem.data, citem.lineID, citem.asmFile)]
					data += struct.pack("<H", 0xAAAA)
				else:
					print(f"Error in {citem.asmFile}:{1+citem.lineID}, column {1+pitem.pos}: expected integer or label!")
					return None
		
		if citem.cmdName in KEYWORD2CMD:
			cmd_id = KEYWORD2CMD[citem.cmdName]
			cmd_item = SCRIPT_CMD_LIST[cmd_id]
			cmd_params = cmd_item[1]
			
			if len(cmd_id) == 1:
				data += struct.pack("<B", cmd_id[0])
			elif len(cmd_id) == 2:
				data += struct.pack("<BB", cmd_id[0], cmd_id[1])
			else:
				print(f"Error: Unknown command ID length of {len(cmd_id)} for keyword \"{citem.cmdName}\"!")
				return None
			rec_level = 0
			par_id_rec = [0]
			expected_par_items = 0
			for (par_id, pitem) in enumerate(citem.params):
				cptype = cmd_params[par_id_rec[0]] if par_id_rec[0] < len(cmd_params) else None
				if pitem.type == TKTP_CTRL:
					if pitem.data == "[":
						expected_par_items = -1
						if cptype is not None:
							# injecting these checks here is really hackish, but I don't have a better idea
							if cptype == SCPT_PTRS and rec_level == 0:
								expected_par_items = citem.params[par_id - 1].data	# use jump table pointer count
						rec_level += 1
						par_id_rec += [0]
					elif pitem.data == "]":
						if expected_par_items >= 0 and par_id_rec[rec_level] != expected_par_items:
							print(f"Error in {citem.asmFile}:{1+citem.lineID}: Parameter {1+par_id_rec[0]} " + \
								f"expects {expected_par_items} items, but has {par_id_rec[rec_level]}")
							return None
						par_id_rec = par_id_rec[:-1]
						rec_level -= 1
						if rec_level < 0:
							print(f"Error in {citem.asmFile}:{1+citem.lineID}: Invalid array end at position {1+pitem.pos}")
							return None
						par_id_rec[rec_level] += 1	# finish this parameter
					continue
				par_id_rec[rec_level] += 1
				if cptype is None:
					continue
				
				cptmask = cptype & SCPT_MASK
				if cptmask == SCPTM_VAL:
					cptype &= ~SCPT_HEX
					if pitem.type != TKTP_INT:
						print(f"Error in {citem.asmFile}:{1+citem.lineID}, column {1+pitem.pos}: expected integer!")
						return None
					if cptype == SCPT_BYTE:
						val_fmt = "B"
					elif cptype == SCPT_INT:
						val_fmt = "H"
					elif cptype == SCPT_LONG:
						val_fmt = "I"
					else:
						print(f"Error in {citem.asmFile}:{1+citem.lineID}, column {1+pitem.pos}: Internal parameter conversion error!")
						return None
					if pitem.data < 0:
						val_fmt = val_fmt.lower()	# write signed value
					try:
						data += struct.pack("<" + val_fmt, pitem.data)
					except Exception as e:
						print(f"Error in {citem.asmFile}:{1+citem.lineID}, column {1+pitem.pos}: value too large!")
						print(e)
						return None
				elif cptmask == SCPTM_PTR or cptype == SCPT_PTRS:
					if pitem.type == TKTP_NAME: # set to TKTP_NAME for labels
						lbl_write_list += [(len(data), pitem.data, citem.lineID, citem.asmFile)]
						data += struct.pack("<H", 0xAAAA)
					else:
						data += struct.pack("<H", pitem.data)
				elif cptype == SCPTM_REG:
					if pitem.type == TKTP_NAME:
						pitem.type = get_nametoken_type(pitem.data, label_list)
					if pitem.type != TKTP_REG:
						print(f"Error in {citem.asmFile}:{1+citem.lineID}, column {1+pitem.pos}: expected register name!")
						return None
					reg_info = read_token_reg(pitem.data)
					if reg_info is None:
						print(f"Error in {citem.asmFile}:{1+citem.lineID}, column {1+pitem.pos}: Invalid register {pitem.data}!")
						return None
					
					(reg_type, reg_id) = reg_info
					data += struct.pack("<B", reg_id)
				elif cptype == SCPT_REGVAL:
					if pitem.type == TKTP_NAME:
						pitem.type = get_nametoken_type(pitem.data, label_list)
					if pitem.type == TKTP_INT:
						val_fmt = "B"
						try:
							if pitem.data < 0x00 or pitem.data >= 0x80:
								raise struct.error
							data += struct.pack("<" + val_fmt, pitem.data)
						except Exception as e:
							print(f"Error in {citem.asmFile}:{1+citem.lineID}, column {1+pitem.pos}: value too large!")
							print(e)
							return None
					elif pitem.type == TKTP_REG:
						reg_info = read_token_reg(pitem.data)
						if reg_info is None:
							print(f"Error in {citem.asmFile}:{1+citem.lineID}, column {1+pitem.pos}: Invalid register {pitem.data}!")
							return None
						
						(reg_type, reg_id) = reg_info
						data += struct.pack("<B", 0x80 | reg_id)
					else:
						print(f"Error in {citem.asmFile}:{1+citem.lineID}, column {1+pitem.pos}: expected integer or register name!")
						return None
				elif cptype in [SCPT_FNAME, SCPT_STR]:
					text = pitem.data
					if cptype == SCPT_STR:
						text = text.replace('\u201C', '"').replace('\u201D', '"')
						text = text.replace("\u2018", "'").replace("\u2019", "'")
						text = text.replace("\u2026", "...")
					value = necjis.sjis_encode_str(text, True)
					if type(value) is not bytes:
						print(f"Error in {citem.asmFile}:{1+citem.lineID}, column {1+pitem.pos+value[0]}: Unable to convert string to Shift-JIS!")
						return None
					if cptype in [SCPT_FNAME, SCPT_STR]:
						value += b'\x00'
					data += value
				elif cptype == SCPT_DATA1:
					try:
						data += struct.pack("<B", 0x80 | pitem.data)
					except:
						print(f"Error in {citem.asmFile}:{1+citem.lineID}, column {1+pitem.pos}: value doesn't fit into 8 bits!")
						return None
				else:
					print(f"Internal error in {citem.asmFile}:{1+citem.lineID}: Unknown parameter type 0x{cptype:02X}!")
					return None
			if par_id_rec[0] != len(cmd_params):
				print(f"Error in {citem.asmFile}:{1+citem.lineID}: parameters: {par_id_rec}, requires {len(cmd_params)}")
				return None
		else:
			print(f"Compile error in {citem.asmFile}:{1+citem.lineID}: Unknown keyword '{citem.cmdName}'")
			return None
	cmd_ofs_list += [len(data)]	# for referencing EOF
	
	# Now write all pointers that reference labels. (Their exact offsets were previously unknown.)
	for (srcofs, lblname, lid, asm_filename) in lbl_write_list:
		lncf = lblname.casefold()
		if lncf not in label_list:
			print(f"Error in {asm_filename}:{1+lid}: Label {lblname} is undefined!")
			return None
		cmd_id = label_list[lncf].cmdID
		dstofs = start_ofs + cmd_ofs_list[cmd_id]
		#print(f"Cmd {cmd_id} Name {lblname} -> ptr at 0x{srcofs:04X} = 0x{dstofs:04X}")
		struct.pack_into("<H", data, srcofs, dstofs)
	
	return data

def load_asm(fn_in: str) -> typing.List[str]:
	with open(fn_in, "rt", encoding="utf-8") as f:
		return f.readlines()

def write_scene_binary(fn_out: str, data: bytes) -> None:
	with open(fn_out, "wb") as f:
		f.write(data)
	return

def load_parse_asm(fn_in: str) -> tuple:
	try:
		asm_lines = load_asm(fn_in)
	except IOError:
		print(f"Error loading {fn_in}")
		return 1
	ret = parse_asm(asm_lines, fn_in)
	if ret is None:
		return 2
	(cmd_list, label_list) = ret
	
	inc_files = []
	for (cid, citem) in enumerate(cmd_list):
		if citem.cmdName == "INCLUDE":
			if len(citem.params) != 1:
				print(f"Error in {citem.asmFile}:{1+citem.lineID}: The 'include' statement needs exactly 1 parameter!")
				return 2
			pitem = citem.params[0]
			if pitem.type != TKTP_STR:
				print(f"Error in {citem.asmFile}:{1+citem.lineID}: The 'include' statement needs a file name as parameter!")
				return 2
			inc_files += [(pitem.data, cid)]
	
	return (cmd_list, label_list, inc_files)

def resolve_includes(parsed_files: dict, root_filepath: str) -> None:
	root_dir = os.path.dirname(root_filepath)
	root_key = os.path.relpath(root_filepath, root_dir).casefold()
	(cmd_list, label_list, inc_files) = parsed_files[root_key]
	
	cid = 0
	while cid < len(cmd_list):
		citem = cmd_list[cid]
		if citem.cmdName == "INCLUDE":
			pitem = citem.params[0]
			
			ffolder = os.path.dirname(citem.asmFile)
			inc_fpath = os.path.abspath(os.path.join(ffolder, pitem.data))
			inckey = os.path.relpath(inc_fpath, root_dir).casefold()
			
			(inc_cmds, inc_labels, _) = parsed_files[inckey]
			# move command references of existing labels
			for lblkey in label_list:
				if label_list[lblkey].cmdID > cid:
					label_list[lblkey].cmdID += len(inc_cmds) - 1
			
			# insert included commands
			cmd_list = cmd_list[: cid] + inc_cmds + cmd_list[cid+1 :]
			# copy included labels with adjusted command ID
			for lblkey in inc_labels:
				if lblkey in label_list:
					ilitem = inc_labels[lblkey]
					slitem = label_list[lblkey]
					inc_ftitle = os.path.relpath(ilitem.asmFile, root_dir)
					src_ftitle = os.path.relpath(slitem.asmFile, root_dir)
					print(f'Error in {inc_ftitle}:{1+ilitem.lineID}: Label "{ilitem.lblName}" is ' \
						f'already defined in {src_ftitle}:{1+slitem.lineID}')
					# TODO: analyze and print include stack here
					return 2
				label_list[lblkey] = dataclasses.replace(inc_labels[lblkey])
				label_list[lblkey].cmdID += cid
			
			# do NOT adjust cid here
		else:
			cid += 1
	
	parsed_files[root_key] = (cmd_list, label_list, inc_files)
	return

def compile_scene(fn_in: str, fn_out: str) -> int:
	parsed_files = {}
	
	root_path = os.path.abspath(fn_in)
	root_dir = os.path.dirname(fn_in)
	root_key = os.path.relpath(root_path, root_dir).casefold()
	
	# load main ASM file + all "include" files
	files2parse = [(os.path.realpath(fn_in), set())]
	while len(files2parse) > 0:
		(fpath, inc_parents) = files2parse[0]
		files2parse = files2parse[1:]
		
		ffolder = os.path.dirname(fpath)
		filekey = os.path.relpath(fpath, root_dir).casefold()
		if filekey in parsed_files:
			continue	# we already loaded this
		
		ret = load_parse_asm(fpath)
		if type(ret) is not tuple:
			return ret
		
		# Include Constraints:
		# - including the same file twice in the same file may be okay (e.g. DB/DW statements)
		# - prevent recursive includes (A includes B includes A) by traversing the tree
		inc_new_parents = {*inc_parents, filekey}
		for (inc_fn, cid) in ret[2]:
			inc_fpath = os.path.abspath(os.path.join(ffolder, inc_fn))
			inckey = os.path.relpath(inc_fpath, root_dir).casefold()
			if inckey in inc_new_parents:	# detect recursive inclusions
				citem = ret[0][cid]
				print(f'Error in {inc_fpath}:{1+citem.lineID}: Recursive include of "{inc_fn}" detected!')
				return 2
			
			# walk through all files in the "to process" list and check whether or not the file is already in the list
			didFind = False
			for (f2p_id, f2p_data) in enumerate(files2parse):
				(f2p_fn, f2p_list) = f2p_data
				f2pkey = os.path.relpath(f2p_fn, root_dir).casefold()
				if f2pkey == inckey:
					# allow for detection of "file A: include B, include C; file B: include C"
					files2parse[f2p_id][1].update(inc_new_parents)
					didFind = True
					break
			if not didFind:
				files2parse += [(inc_fpath, inc_new_parents)]
		parsed_files[filekey] = ret
	
	# resolve "include" statements
	resolve_includes(parsed_files, root_path)
	
	# generate bytecode
	(cmd_list, label_list, _) = parsed_files[root_key]
	data = generate_binary(cmd_list, label_list)
	if data is None:
		return 2
	if len(data) > 0x10000:
		print(f"Error: Compiled data is {len(data)} bytes large, but must be <={0x10000} bytes!")
		return 3
	
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
	
	print("Nostalgia 1907 Scenario Compiler")
	aparse = argparse.ArgumentParser()
	aparse.add_argument("-f", "--font-file", type=str, help="description file for custom font characters")
	aparse.add_argument("in_file", help="input assembly file (.ASM)")
	aparse.add_argument("out_file", help="output scenario file (.BIN)")
	
	config = aparse.parse_args(argv[1:])
	
	necjis.load_from_pickle(os.path.join(MODULE_PATH, "NEC-C-6226-lut.pkl"))
	if config.font_file:
		load_additional_font_table(config.font_file)
	return compile_scene(config.in_file, config.out_file)

if __name__ == "__main__":
	sys.exit(main(sys.argv))
# vim: set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab:
