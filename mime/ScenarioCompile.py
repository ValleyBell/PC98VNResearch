#!/usr/bin/env python3
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


# Scene Command Parameter Types
SCPT_MASK = 0xF0
SCPTM_VAL = 0x00	# immediate value
SCPTM_PTR = 0x10	# pointer
SCPTM_DATA = 0x20	# misc data
SCPTM_FIXED = 0x30	# fixed-length data
SCPTM_REG = 0x80	# register

SCPT_BYTE = 0x01	# "byte" (2-byte parameter, high byte ignored)
SCPT_INT = 0x02		# 2-byte integer
SCPT_LONG = 0x03	# 4-byte integer
SCPT_HEX = 0x08		# integer, output as hexadecimal
SCPT_INTH = SCPT_INT | SCPT_HEX

SCPT_JUMP = 0x10	# jump destination pointer
SCPT_DATA1 = 0x20	# data pointer (1-byte groups)
SCPT_DATA2 = 0x21	# data pointer (2-byte groups)
SCPT_FNAME = 0x22	# string, 1 byte per charater, terminated with 00h
SCPT_STR1 = 0x23	# string, 1 byte per charater, terminated with 5Ch
SCPT_STR2 = 0x24	# string, 2 bytes per charater, terminated with 5C5Ch
SCPT_TXTSEL = 0x25	# text/menu selection

SCPT_REG = 0x80	# register: integer

SC_EXEC_END = 0x01	# terminate script execution here
SC_EXEC_SPC = 0xFF	# special handling

LBLFLG_UNUSED = 0x01
LBLFLG_JP = 0x02
LBLFLG_CALL = 0x04

SCENE_CMD_LIST = {
	0x00: ("TALKDGN", [SCPT_STR2]),
	0x01: ("BGMLOAD", [SCPT_FNAME]),
	0x02: ("TALKFS" , [SCPT_STR2]),
	0x03: ("SCNLOAD", [], SC_EXEC_END),
	0x04: ("TXTCOL" , [SCPT_INT, SCPT_INT]),
	0x05: ("PORTA6" , [SCPT_BYTE]),
	0x06: ("WAIT"   , [SCPT_INT]),
	0x07: ("MOVI"   , [SCPT_REG, SCPT_INT]),
	0x08: ("MOVR"   , [SCPT_REG, SCPT_REG]),
	0x09: ("ADDI"   , [SCPT_REG, SCPT_INT]),
	0x0A: ("ADDR"   , [SCPT_REG, SCPT_REG]),
	0x0B: ("SUBI"   , [SCPT_REG, SCPT_INT]),
	0x0C: ("SUBR"   , [SCPT_REG, SCPT_REG]),
	0x0D: ("BLIT1"  , [SCPT_INTH, SCPT_INT, SCPT_INT, SCPT_INTH, SCPT_INT]),
	0x0E: ("BLIT2"  , [SCPT_INTH, SCPT_INT, SCPT_INT, SCPT_INTH]),
	0x0F: ("CMD0F"  , [SCPT_INT]),
	0x10: ("BCLR"   , [SCPT_REG, SCPT_BYTE]),
	0x11: ("BSET"   , [SCPT_REG, SCPT_BYTE]),
	0x12: ("MOVM"   , [SCPT_REG, SCPT_REG, SCPT_INT]),
	0x13: ("CALL"   , [SCPT_JUMP]),
	0x14: ("RET"    , [], SC_EXEC_END),
	0x15: ("JP"     , [SCPT_JUMP], SC_EXEC_END),
	0x16: ("JEQ"    , [SCPT_REG, SCPT_INT, SCPT_JUMP]),
	0x17: ("JGT"    , [SCPT_REG, SCPT_INT, SCPT_JUMP]),
	0x18: ("JLT"    , [SCPT_REG, SCPT_INT, SCPT_JUMP]),
	0x19: ("IMGLD2" , [SCPT_INTH, SCPT_INTH, SCPTM_FIXED | 0x05]),
	0x1A: ("IMGLD"  , [SCPT_INTH, SCPT_INTH, SCPTM_FIXED | 0x05]),
	0x1B: ("IMGFX"  , [SCPT_INTH, SCPT_INT, SCPT_INT, SCPT_INTH, SCPT_INT]),
	0x1C: ("SCNSET" , [SCPT_FNAME]),
	0x1D: ("MENUSEL", [SCPT_INTH, SCPT_INT, SCPT_TXTSEL], SC_EXEC_SPC),
	0x1E: ("QUIT"   , [], SC_EXEC_END),
	0x1F: ("CMD1F"  , [SCPT_INT]),
	0x20: ("CMD20"  , [SCPT_INT]),
	0x21: ("SAVREAD", [SCPT_FNAME]),
	0x22: ("CMD22"  , []),
	0x23: ("PORTA4" , [SCPT_BYTE]),
	0x24: ("MAPREAD", [SCPT_REG, SCPT_REG]),
	0x25: ("BTST"   , [SCPT_REG, SCPT_INT], SC_EXEC_SPC),
	0x26: ("BLIT3"  , [SCPT_INTH, SCPT_INT, SCPT_INT, SCPT_INTH, SCPT_INT]),
	0x27: ("CMD27"  , []),
	0x28: ("CMD28"  , []),
	0x29: ("CMD29"  , []),
	0x2A: ("CMD2A"  , []),
	0x2B: ("BGMPLAY", []),
	0x2C: ("BGMFADE", [SCPT_BYTE]),
	0x2D: ("CMD2D"  , [SCPT_REG, SCPT_REG]),
	0x2E: ("MAPWRT" , [SCPT_REG, SCPT_REG]),
	0x2F: ("MAPDRAW", []),
	0x30: ("PRINT2" , [SCPT_INTH, SCPT_STR2]),
	0x31: ("CMD31"  , []),
	0x32: ("CMD32"  , []),
	0x33: ("PNAMADD", []),
	0x34: ("PNAMDEL", []),
	0x35: ("CMD35"  , [SCPT_INT]),
	0x36: ("CMD36"  , []),
	0x37: ("CMD37"  , []),
	0x38: ("SAVWRT" , [SCPT_FNAME]),
	0x39: ("RNDI"   , [SCPT_REG, SCPT_INT]),
	0x3A: ("PRINT1" , [SCPT_INTH, SCPT_STR1]),
	0x3B: ("DSPS"   , [SCPT_INTH, SCPT_REG]),
	0x3C: ("DSPI10" , [SCPT_INTH, SCPT_REG]),
	0x3D: ("CMD3D"  , [SCPT_INT, SCPT_DATA2, SCPT_DATA2]),
	0x3E: ("CMD3E"  , [SCPT_BYTE]),
	0x3F: ("SFXFM"  , [SCPT_BYTE]),
	0x40: ("DSKWAIT", [SCPTM_FIXED | 0x0A, SCPT_BYTE]),
	0x41: ("BLIT4"  , [SCPT_INTH, SCPT_INT, SCPT_INT, SCPT_INTH, SCPT_INT]),
	0x42: ("DSPI20" , [SCPT_INTH, SCPT_REG]),
	0x43: ("MULCI"  , [SCPT_REG, SCPT_INT]),
	0x44: ("CMD44"  , []),
	0x45: ("DIGDSP" , [SCPT_INTH, SCPT_REG]),
	0x46: ("DIGADDI", [SCPT_REG, SCPT_INT]),
	0x47: ("DIGSUBI", [SCPT_REG, SCPT_INT]),
	0x48: ("DSKMODE", []),
	0x49: ("DIGADDR", [SCPT_REG, SCPT_REG]),
	0x4A: ("DIGSUBR", [SCPT_REG, SCPT_REG]),
	0x4B: ("BGMWAIT", [SCPT_INT, SCPT_INT]),
	0x4C: ("CMD4C"  , []),
	0x4D: ("CMD4D"  , []),
	0x4E: ("CMPR"   , [SCPT_REG, SCPT_REG]),
	0x4F: ("MULI"   , [SCPT_REG, SCPT_INT]),
	0x50: ("MULR"   , [SCPT_REG, SCPT_REG]),
	0x51: ("DIVI"   , [SCPT_REG, SCPT_INT]),
	0x52: ("DIVR"   , [SCPT_REG, SCPT_REG]),
	0x53: ("GETITM" , [SCPT_REG]),
	0x54: ("GETMNST", [SCPT_REG]),
	0x55: ("BLIT1R" , [SCPT_REG, SCPT_REG, SCPT_REG, SCPT_REG, SCPT_REG]),
	0x56: ("BLIT2R" , [SCPT_REG, SCPT_REG, SCPT_REG, SCPT_REG]),
	0x57: ("IMGFXR" , [SCPT_REG, SCPT_REG, SCPT_REG, SCPT_REG, SCPT_REG]),
	0x58: ("BLIT3R" , [SCPT_REG, SCPT_REG, SCPT_REG, SCPT_REG, SCPT_REG]),
	0x59: ("IMGLDR" , [SCPT_REG, SCPT_REG, SCPT_REG]),
	0x5A: ("RNDR"   , [SCPT_REG, SCPT_REG]),
	0x5B: ("DSKGET" , [SCPTM_FIXED | 0x0A]),
	0x5C: ("CMD5C"  , [SCPT_REG]),
	0x5D: ("PRINT2R", [SCPT_REG, SCPT_STR2]),
	0x5E: ("DSPSR"  , [SCPT_REG, SCPT_REG]),
	0x5F: ("CMD5F"  , [SCPT_INT, SCPT_INT, SCPT_INT, SCPT_INT]),
	0x60: ("CMD60"  , []),
	0x61: ("DSPI1N" , [SCPT_INTH, SCPT_REG]),
	0x62: ("DSPI2N" , [SCPT_INTH, SCPT_REG]),
	0x63: ("DSKPSET", []),
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
for cdata in SCENE_CMD_LIST.values():
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
	for (key, item) in SCENE_CMD_LIST.items():
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
			cmd_item = SCENE_CMD_LIST[cmd_id]
			cmd_params = cmd_item[1]
			
			data += struct.pack("<B", cmd_id)
			rec_level = 0
			par_id_rec = [0]
			expected_par_items = 0
			for (par_id, pitem) in enumerate(citem.params):
				cptype = cmd_params[par_id_rec[0]] if par_id_rec[0] < len(cmd_params) else None
				if pitem.type == TKTP_CTRL:
					if pitem.data == "[":
						expected_par_items = 0
						if cptype is not None:
							# injecting these checks here is really hackish, but I don't have a better idea
							if cptype == SCPT_TXTSEL and rec_level == 0:
								expected_par_items = citem.params[par_id - 1].data	# use menu string count
							elif cptype == SCPT_DATA2:
								if cmd_id == 0x3D:
									expected_par_items = 40
						rec_level += 1
						par_id_rec += [0]
					elif pitem.data == "]":
						if par_id_rec[rec_level] != expected_par_items:
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
						if cptype == SCPT_BYTE:
							data += struct.pack("<" + val_fmt, pitem.data) + b'\x00'	# byte values needs 2-byte alignment
						else:
							data += struct.pack("<" + val_fmt, pitem.data)
					except Exception as e:
						print(f"Error in {citem.asmFile}:{1+citem.lineID}, column {1+pitem.pos}: value too large!")
						print(e)
						return None
				elif cptmask == SCPTM_PTR:
					if pitem.type == TKTP_NAME: # set to TKTP_NAME for labels
						lbl_write_list += [(len(data), pitem.data, citem.lineID, citem.asmFile)]
						data += struct.pack("<H", 0xAAAA)
					else:
						data += struct.pack("<H", pitem.data)
				elif cptmask == SCPTM_REG:
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
					data += struct.pack("<H", reg_id)
				elif cptype in [SCPT_FNAME, SCPT_STR1, SCPT_STR2, SCPT_TXTSEL]:
					value = necjis.sjis_encode_str(pitem.data, True)
					if type(value) is not bytes:
						print(f"Error in {citem.asmFile}:{1+citem.lineID}, column {1+pitem.pos+value[0]}: Unable to convert string to Shift-JIS!")
						return None
					if cptype == SCPT_FNAME:
						value += b'\x00'
					elif cptype == SCPT_STR1:
						value += b'\x5C'
					elif cptype in [SCPT_STR2, SCPT_TXTSEL]:
						value += b'\x5C\x5C'
					data += value
				elif cptmask == SCPTM_FIXED:
					value = necjis.sjis_encode_str(pitem.data, True)
					if type(value) is not bytes:
						print(f"Error in {citem.asmFile}:{1+citem.lineID}, column {1+pitem.pos+value[0]}: Unable to convert string to Shift-JIS!")
						return None
					strlen = cptype & 0x0F
					value = value[0:strlen].ljust(strlen, b'\x00')
					data += value
				elif cptype == SCPT_DATA1:
					try:
						if pitem.data < 0:
							data += struct.pack("<b", pitem.data)
						else:
							data += struct.pack("<B", pitem.data)
					except:
						print(f"Error in {citem.asmFile}:{1+citem.lineID}, column {1+pitem.pos}: value doesn't fit into 8 bits!")
						return None
				elif cptype == SCPT_DATA2:
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
	if len(data) > 0x7800:
		print(f"Error: Compiled data is {len(data)} bytes large, but must be <={0x7800} bytes!")
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
	
	print("MIME Scenario Compiler")
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
