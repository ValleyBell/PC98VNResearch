#!/usr/bin/env python3
import sys
import os
import struct
import typing
import argparse
import nec_jis_conv


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

LBLFLG_UNREF = 0x01
LBLFLG_JP = 0x02
LBLFLG_CALL = 0x04
LBLFLG_MAINREF = 0x10
LBLFLG_UNUSEDREF = 0x20

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
	0x5F: ("CMD5F"  , [SCPT_REG, SCPT_REG, SCPT_REG, SCPT_REG]),
	0x60: ("CMD60"  , []),
	0x61: ("DSPI1N" , [SCPT_INTH, SCPT_REG]),
	0x62: ("DSPI2N" , [SCPT_INTH, SCPT_REG]),
	0x63: ("DSKPSET", []),
}

MODULE_PATH = os.path.dirname(__file__)
JISCHR_COMMENTS = {}
necjis = nec_jis_conv.JISConverter()
config = {}


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
				
				if config.use_emojis:
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

def load_scene_binary(fn_in: str) -> bytes:
	with open(fn_in, "rb") as f:
		return f.read()

def scene_read_array(scenedata: bytes, usage_mask: list, pos: int, array_size: int, mask: int = 0x01) -> bytes:
	try:
		for ofs in range(array_size):
			usage_mask[pos + ofs] |= mask
		return scenedata[pos : pos + array_size]
	except Exception as e:
		print(f"Error in scene_read_array(pos 0x{pos:04X}, array size 0x{array_size:04X}, file size 0x{len(scenedata):04X}): {e}")
		raise e

def scene_read_byte(scenedata: bytes, usage_mask: list, pos: int, mask: int = 0x01) -> int:
	usage_mask[pos] |= mask
	return scenedata[pos]

def scene_read_int(scenedata: bytes, usage_mask: list, pos: int, mask: int = 0x01) -> int:
	usage_mask[pos + 0x00] |= mask
	usage_mask[pos + 0x01] |= mask
	return struct.unpack_from("<H", scenedata, pos)[0]

def scene_read_str1(scenedata: bytes, usage_mask: list, startpos: int, end_chr: int, mask: int = 0x01) -> int:
	pos = startpos
	while pos < len(scenedata):
		c = scenedata[pos]
		pos += 1
		if c == end_chr:
			break
	strlen = pos - startpos
	return (scene_read_array(scenedata, usage_mask, startpos, strlen)[:-1], strlen)

def scene_read_str2(scenedata: bytes, usage_mask: list, startpos: int, end_chr: int, mask: int = 0x01) -> int:
	pos = startpos
	while pos + 1 < len(scenedata):
		c1 = scenedata[pos + 0]
		c = (c1 << 8) | (scenedata[pos + 1] << 0)
		if c == end_chr:
			pos += 2
			break
		# NOTE: The original game treats all characters as 2-byte.
		# The special range check allows single-byte characters to be used,
		# which is supported by the MIME ASCII patch.
		if (c1 >= 0x81 and c1 <= 0x9F) or (c1 >= 0xE0 and c1 <= 0xFC):
			pos += 2
		else:
			pos += 1
	strlen = pos - startpos
	return (scene_read_array(scenedata, usage_mask, startpos, strlen)[:-2], strlen)

def find_next_label(labels: dict, pos: int) -> int:
	for lblpos in sorted(labels.keys()):
		if lblpos >= pos:
			return lblpos
	return -1

def is_sjis_str(data: bytes) -> bool:
	sjis_2nd = False
	for c in data:
		if not sjis_2nd:
			if c >= 0x20 and c <= 0x7E:
				pass
			elif c >= 0xA1 and c <= 0xDF:
				pass	# used for halfwidth Katakana
			elif c == 0x00:
				break
			elif (c >= 0x81 and c <= 0x9F) or (c >= 0xE0 and c <= 0xEF):
				sjis_2nd = True
			else:
				return False
		else:
			sjis_2nd = False
			if c >= 0x40 and c <= 0x7E:
				pass
			elif c >= 0x80 and c <= 0xFE:
				pass
			else:
				return False
	return True

def guess_data_type(scenedata: bytes, startpos: int, endpos: int) -> int:
	# try to guess what type of data this is
	data = scenedata[startpos : endpos]
	
	nullpos = data.find(0)
	if nullpos > 1:	# need at least 1 character
		dstr = data[0 : nullpos]
		if sum([1 for c in dstr[0:] if not (c >= 0x20 and c <= 0x7E)]) == 0:
			return SCPT_FNAME
		if is_sjis_str(dstr):
			return SCPT_STR
	return -1

def get_string_size(scenedata: bytes, startpos: int, endpos: int, dtype: int) -> int:
	pos = startpos
	if dtype == SCPT_FNAME:
		if scenedata[pos] < 0x20:	# archive ID
			pos += 1
		while (pos < endpos) and (scenedata[pos] != 0x00):
			pos += 1
		pos += 1	# also count terminator character
	elif dtype == SCPT_STR:
		while pos < endpos:
			c = scenedata[pos]
			pos += 1
			if c == 0x00:	# end
				break
	return min([pos, endpos]) - startpos

def find_possible_code(scenedata: bytes, file_usage: list, label_list: dict, start_ofs: int) -> int:
	# --- scan all unreferenced data sections and return the position of a potential (unused) code section ---
	curpos = start_ofs
	
	# search for next unparsed section
	while (curpos < len(scenedata)) and (file_usage[curpos] != 0x00):
		curpos += 1
	if curpos >= len(scenedata):
		return -1
	
	return curpos	 # We don't have "data" sections in this decompiling tool, so treat everything as code.

def parse_scene_binary(scenedata: bytes) -> tuple:
	start_ofs = 0x0000
	
	cmd_list = []	# list[ tuple(file offset, command ID, list[params] ) ]
	file_usage = [0x00] * len(scenedata)
	label_list = {}	# dict{ file offset: (label type, flags, label name) }
	
	# --- parse code sections ---
	label_list[start_ofs] = (SCPT_JUMP, LBLFLG_MAINREF, f"start_{start_ofs:04X}")
	ref_flags = None	# keeps track of markings for used/unused code
	remaining_code_locs = [start_ofs]
	curpos = None
	cont_after_jp = 0
	while True:
		# Note: The code for deciding what to parse next is a bit complex,
		#       but I can not just parse the file once from start to end.
		#       The script can do arbitrary jumps forward and backward
		#       and I need to follow them in order to reach all code.
		if curpos is None:
			if len(remaining_code_locs) > 0:
				curpos = remaining_code_locs.pop(0)
			else:
				# This part is for finding unreferenced code sections.
				curpos = find_possible_code(scenedata, file_usage, label_list, start_ofs)
				if curpos >= 0:
					label_list[curpos] = (SCPT_JUMP, LBLFLG_UNREF | LBLFLG_UNUSEDREF, None)
				else:
					curpos = None
			ref_flags = 0x00
		if curpos is None:
			break	# exit loop when no more code sections are found
		if curpos >= len(scenedata):
			curpos = None
			continue
		if (file_usage[curpos] & 0x0F) != 0x00:
			curpos = None
			continue
		
		if curpos in label_list:
			ref_flags |= (label_list[curpos][1] & 0xF0)
			if label_list[curpos][1] & LBLFLG_UNREF:
				ref_flags |= LBLFLG_UNUSEDREF
		cmd_pos = curpos
		cmd_id = scene_read_byte(scenedata, file_usage, cmd_pos, 0x11)
		curpos += 0x01
		if cmd_id not in SCENE_CMD_LIST:
			# These commands will crash the game.
			print(f"Found invalid command ID 0x{cmd_id:02X} at offset 0x{cmd_pos:04X}!")
			cmd_list += [(cmd_pos, -2, [cmd_id])]
			continue
		
		cmd_info = SCENE_CMD_LIST[cmd_id]
		if cmd_info[0] is None:
			# The game engine will quit with an error message for these commands.
			print(f"Found reserved command ID 0x{cmd_id:02X} at offset 0x{cmd_pos:04X}!")
			cmd_list += [(cmd_pos, -2, [cmd_id])]
			continue
		
		# parse command parameters
		#print(f"Pos 0x{cmd_pos:04X}, Command 0x{cmd_id:02X}")
		params = []
		for par_type in cmd_info[1]:
			#print(f"Pos 0x{curpos:04X}, ParType 0x{par_type:02X}")
			if (par_type & SCPT_MASK) == SCPTM_VAL:
				if par_type == SCPT_LONG:
					par_data = scene_read_array(scenedata, file_usage, curpos, 0x04)
					par_val = struct.unpack("<I", par_data)[0]
					curpos += 0x04
				else:
					par_val = scene_read_int(scenedata, file_usage, curpos)
					curpos += 0x02
			elif par_type == SCPT_REG:
				par_val = scene_read_int(scenedata, file_usage, curpos)
				curpos += 0x02
			elif par_type == SCPT_JUMP:
				par_val = scene_read_int(scenedata, file_usage, curpos)
				curpos += 0x02
			elif par_type == SCPT_FNAME:
				(par_val, strlen) = scene_read_str1(scenedata, file_usage, curpos, 0x00)
				curpos += strlen
			elif par_type == SCPT_STR1:
				(par_val, strlen) = scene_read_str1(scenedata, file_usage, curpos, 0x5C)
				curpos += strlen
			elif par_type == SCPT_STR2:
				(par_val, strlen) = scene_read_str2(scenedata, file_usage, curpos, 0x5C5C)
				curpos += strlen
			elif par_type == SCPT_TXTSEL:
				par_val = []
				for s_id in range(params[-1][1]):	# the previous parameter specifies the number of items
					(par_data, strlen) = scene_read_str2(scenedata, file_usage, curpos, 0x5C5C)
					par_val.append(par_data)
					curpos += strlen
			elif (par_type & SCPT_MASK) == SCPTM_FIXED:
				strlen = par_type & 0x0F
				par_val = scene_read_array(scenedata, file_usage, curpos, strlen)
				curpos += strlen
			elif par_type in [SCPT_DATA1, SCPT_DATA2]:
				if cmd_id == 0x3D:
					dlen = 40*2
					darray = scene_read_array(scenedata, file_usage, curpos, dlen)
					iterat = struct.iter_unpack("<h", darray)
					par_val = [v[0] for v in iterat]
					curpos += dlen
				else:
					print(f"Error: Unhandled data in command 0x{cmd_id:02X}!")
					return 1
			else:
				print(f"Error: Unhandled data type 0x{par_type:02X}!")
				return 1
			
			if (par_type & SCPT_MASK) == SCPTM_PTR:
				# pointer parameters: add label for them
				if par_val >= start_ofs:
					flags = 0x00
					if cmd_id == 0x13:
						flags = LBLFLG_CALL
					elif par_type == SCPT_JUMP:
						flags = LBLFLG_JP
					if par_val not in label_list:
						label_list[par_val] = (par_type, flags | ref_flags, None)
					else:
						lbl = label_list[par_val]
						label_list[par_val] = (lbl[0], lbl[1] | flags | ref_flags, lbl[2])
			if par_type == SCPT_JUMP:
				# add jump destination to list of locations to be processed
				if par_val >= start_ofs:
					remaining_code_locs.append(par_val)
				else:
					print(f"Warning: Found invalid jump to invalid offset 0x{par_val:04X} at offset 0x{cmd_pos:04X}!")
			
			params += [(par_type, par_val)]
		cmd_list += [(cmd_pos, cmd_id, params)]
		
		if len(cmd_info) >= 3:
			# special handling
			if cmd_info[2] == SC_EXEC_END:
				if cont_after_jp == 0:
					curpos = None	# stop processing here
			elif cmd_info[2] == SC_EXEC_SPC:
				if cmd_id == 0x25:	# BTST
					cont_after_jp = 2	# This command + the next command will definitely continue execution.
		if cont_after_jp > 0:
			cont_after_jp -= 1
	
	cmd_list.sort(key=lambda cmd: cmd[0])
	return (cmd_list, file_usage, label_list)

def generate_label_names(label_list: dict) -> None:
	for lbl_pos in label_list:
		(par_type, lbl_flags, lbl_name) = label_list[lbl_pos]
		if not (lbl_name is None or lbl_name == ""):
			continue
		if par_type in [SCPT_DATA1, SCPT_DATA2]:
			lbl_prefix = "data"
		if par_type == SCPT_JUMP:
			if lbl_flags & LBLFLG_CALL:
				lbl_prefix = "sub"
			else:
				lbl_prefix = "loc"
		else:
			lbl_prefix = "unk"
		lbl_name = f"{lbl_prefix}_{lbl_pos:04X}"
		if (lbl_flags & (LBLFLG_MAINREF|LBLFLG_UNUSEDREF)) == LBLFLG_UNUSEDREF:
			lbl_name = "u" + lbl_name	# add "u" prefix (usub/uloc) for unused code
		label_list[lbl_pos] = (par_type, lbl_flags, lbl_name)
	return

def str2asm_sjis(str_data: bytes) -> typing.List[str]:
	global necjis
	
	# convert binary array to ASM string
	# This also takes care of converting Shift-JIS characters to UTF-8 where possible.
	# Unrepresentable characters are escaped with "\x##".
	res_chrs = []
	sjis_1st = None
	for c in str_data:
		if sjis_1st is not None:
			# 2nd byte of a 2-byte Shift-JIS character
			sjis_str = necjis.sjis_decode_chr((sjis_1st << 8) | (c << 0))
			if type(sjis_str) is str:
				res_chrs.append(sjis_str)
			else:
				res_chrs.append(sjis_1st)
				res_chrs.append(c)
			sjis_1st = None
		else:
			if (c >= 0x81 and c <= 0x9F) or (c >= 0xE0 and c <= 0xFC):
				sjis_1st = c
			elif c >= 0xA1 and c <= 0xDF:
				# special halfwidth Katakana codes
				sjis_str = necjis.sjis_decode_chr(0x859F + (c - 0xA1))
				if type(sjis_str) is str:
					res_chrs.append(sjis_str)
				else:
					res_chrs.append(c)
			elif c >= 0x20 and c <= 0x7E:
				res_chrs.append(chr(c))	# ASCII character - print as actual text character
			else:
				res_chrs.append(c)	# control code - print byte as number
	
	res_items = ""
	mode = 0
	for c in res_chrs:
		if type(c) is str:
			if c in ['"', '\\']:	# escape some special characters
				c_add = '\\' + c
			else:
				c_add = c
		else:
			c_add = f"\\x{c:02X}"
		res_items += c_add
	return f'"{res_items}"'

def write_asm(cmd_list, label_list, fn_out: str) -> None:
	cmd_pos_map = {}
	for (cid, cmd) in enumerate(cmd_list):
		(cmd_pos, cmd_id, params) = cmd
		cmd_pos_map[cmd_pos] = cid
	
	with open(fn_out, "wt", encoding="utf-8") as f:
		last_mode = None
		cont_after_jp = 0
		for cmd in cmd_list:
			(cmd_pos, cmd_id, params) = cmd
			
			if last_mode is not None:
				# insert empty line when changing between data and code
				new_mode = 1 if cmd_id < 0 else 0
				if last_mode != new_mode:
					f.write("\n")
					last_mode = None
			
			if cmd_pos in label_list:
				# insert labels before commands when references exist
				lbl_name = label_list[cmd_pos][2]
				f.write(f"{lbl_name}:")
				if label_list[cmd_pos][1] & LBLFLG_UNREF:
					f.write("\t; unused")
				#elif label_list[cmd_pos][1] & LBLFLG_UNUSEDREF:
				#	f.write("\t; used by unreferenced code")
				f.write("\n")
			
			# output commands
			cmd_info = SCENE_CMD_LIST[cmd_id]
			cmd_name = cmd_info[0]
			data_strs = []
			comment = None
			# make list of all parameters, with resolved register and label names
			for (par_type, par_val) in params:
				data_str = None
				if (par_type & SCPT_MASK) == SCPTM_PTR:
					if par_val in label_list:
						data_str = label_list[par_val][2]	# replace pointer value with label string
					else:
						data_str = f"0x{par_val:04X}"
				elif par_type in [SCPT_FNAME, SCPT_STR1, SCPT_STR2]:
					data_str = str2asm_sjis(par_val)
				elif par_type == SCPT_TXTSEL:
					data_str = "[" + ", ".join([str2asm_sjis(s) for s in par_val]) + "]"
				elif (par_type & SCPT_MASK) == SCPTM_FIXED:
					data_str = str2asm_sjis(par_val)
				elif (par_type & SCPT_MASK) == SCPTM_REG:
					# output register names
					if par_type == SCPT_REG:
						data_str = f"r{par_val}"
				elif (par_type & SCPT_MASK) == SCPTM_VAL:
					if ((par_type & SCPT_HEX) == 0) and ((par_type & ~SCPT_HEX) == SCPT_INT):
						c2 = (par_val >> 8) & 0xFF
						c1 = (par_val >> 0) & 0xFF
						if ((c1 >= 0x81 and c1 <= 0x9F) or (c1 >= 0xE0 and c1 <= 0xEF)) and \
							(c2 >= 0x40 and c2 <= 0xFC and c2 != 0x7F):
							par_type |= SCPT_HEX	# assume Shift-JIS character code
					if (par_type & SCPT_HEX):
						if (par_type & ~SCPT_HEX) == SCPT_BYTE:
							digits = 2
							par_val &= 0xFF	# make unsigned
						elif (par_type & ~SCPT_HEX) == SCPT_INT:
							digits = 4
							par_val &= 0xFFFF	# make unsigned
						elif (par_type & ~SCPT_HEX) == SCPT_LONG:
							digits = 8
							par_val &= 0xFFFFFFFF	# make unsigned
						else:
							digits = 0
						data_str = f"0x{par_val:0{digits}X}"
					else:
						data_str = f"{par_val}"
				if data_str is None:
					data_str = f"{par_val}"
				data_strs.append(data_str)
			data_str = ", ".join(data_strs)
			
			cols = ["", cmd_name]
			if len(data_str) > 0:
				cols += [data_str]
			if comment is not None:
				cols += ["; " + comment]
			f.write("\t".join(cols) + '\n')
			last_mode = 0
			
			if len(cmd_info) >= 3:
				if cmd_info[2] == SC_EXEC_END:
					if cont_after_jp == 0:
						f.write("\n")
						last_mode = None
				elif cmd_info[2] == SC_EXEC_SPC:
					if cmd_id == 0x25:	# BTST
						cont_after_jp = 2	# This command + the next command will definitely continue execution.
			if cont_after_jp > 0:
				cont_after_jp -= 1
	return

def decompile_scene(fn_in: str, fn_out: str) -> int:
	try:
		scn_data = load_scene_binary(fn_in)
	except IOError:
		print(f"Error loading {fn_in}")
		return 1
	(cmd_list, file_usage, label_list) = parse_scene_binary(scn_data)
	generate_label_names(label_list)
	try:
		write_asm(cmd_list, label_list, fn_out)
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
	
	print("MIME Scenario Decompiler")
	aparse = argparse.ArgumentParser()
	aparse.add_argument("-f", "--font-file", type=str, help="description file for custom font characters")
	aparse.add_argument("-e", "--use-emojis", action="store_true", help="decode custom font into emojis")
	aparse.add_argument("in_file", help="input scenario file (.BIN)")
	aparse.add_argument("out_file", help="output assembly file (.ASM)")
	
	config = aparse.parse_args(argv[1:])
	
	necjis.load_from_pickle(os.path.join(MODULE_PATH, "NEC-C-6226-lut.pkl"))
	if config.font_file:
		load_additional_font_table(config.font_file)
	return decompile_scene(config.in_file, config.out_file)

if __name__ == "__main__":
	sys.exit(main(sys.argv))
# vim: set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab:
