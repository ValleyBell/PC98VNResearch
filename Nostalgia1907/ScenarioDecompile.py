#!/usr/bin/env python3
# Written by Valley Bell, 2026-10-08
# based on MIME Scenario Decompiler
import sys
import os
import struct
import typing
import argparse
import nec_jis_conv


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

LBLFLG_UNREF = 0x01
LBLFLG_JP = 0x02
LBLFLG_CALL = 0x04
LBLFLG_MAINREF = 0x10
LBLFLG_UNUSEDREF = 0x20

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

def scene_read_str(scenedata: bytes, usage_mask: list, startpos: int, end_chr: int, mask: int = 0x01) -> int:
	pos = startpos
	while pos < len(scenedata):
		c = scenedata[pos]
		pos += 1
		if c == end_chr:
			break
	strlen = pos - startpos
	return (scene_read_array(scenedata, usage_mask, startpos, strlen)[:-1], strlen)

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
		cmd_id = scene_read_byte(scenedata, file_usage, curpos, 0x11)
		cmd_id = (cmd_id,)	# make a 1-element tuple
		curpos += 0x01
		if cmd_id not in SCRIPT_CMD_LIST:
			# These commands will crash the game.
			print(f"Found invalid command ID 0x{cmd_id[0]:02X} at offset 0x{cmd_pos:04X}!")
			cmd_list += [(cmd_pos, [-2], cmd_id)]
			continue
		
		cmd_info = SCRIPT_CMD_LIST[cmd_id]
		if cmd_info[0] is None:
			# The game engine will quit with an error message for these commands.
			print(f"Found reserved command ID 0x{cmd_id[0]:02X} at offset 0x{cmd_pos:04X}!")
			cmd_list += [(cmd_pos, [-2], cmd_id)]
			continue
		
		if cmd_info[0] == "METACMD":
			mcmd_id = scene_read_byte(scenedata, file_usage, curpos, 0x11)
			mcmd_id = (cmd_id[0], mcmd_id)
			if mcmd_id in SCRIPT_CMD_LIST:
				curpos += 0x01
				cmd_id = mcmd_id
				cmd_info = SCRIPT_CMD_LIST[cmd_id]
			else:
				# keep curpos, so that the fallback command reads it
				print(f"Found unknown meta command ID 0x{mcmd_id[1]:02X} at offset 0x{cmd_pos:04X}!")
		#print(cmd_info)
		
		# parse command parameters
		#print(f"Pos 0x{cmd_pos:04X}, Command 0x{cmd_id[0]:02X}")
		params = []
		for par_type in cmd_info[1]:
			#print(f"Pos 0x{curpos:04X}, ParType 0x{par_type:02X}")
			if (par_type & SCPT_MASK) == SCPTM_VAL:
				if par_type == SCPT_LONG:
					par_data = scene_read_array(scenedata, file_usage, curpos, 0x04)
					par_val = struct.unpack("<I", par_data)[0]
					curpos += 0x04
				elif par_type == SCPT_INT:
					par_val = scene_read_int(scenedata, file_usage, curpos)
					curpos += 0x02
				else:
					par_val = scene_read_byte(scenedata, file_usage, curpos)
					curpos += 0x01
			elif par_type == SCPT_REG:
				par_val = scene_read_byte(scenedata, file_usage, curpos)
				curpos += 0x01
			elif par_type == SCPT_REGVAL:
				par_val = scene_read_byte(scenedata, file_usage, curpos)
				if par_val & 0x80:
					par_type = SCPT_REG
					par_val &= 0x7F
				else:
					par_type = SCPT_BYTE
				curpos += 0x01
			elif par_type == SCPT_JUMP:
				par_val = scene_read_int(scenedata, file_usage, curpos)
				curpos += 0x02
			elif par_type == SCPT_FNAME:
				(par_val, strlen) = scene_read_str(scenedata, file_usage, curpos, 0x00)
				curpos += strlen
			elif par_type == SCPT_STR:
				(par_val, strlen) = scene_read_str(scenedata, file_usage, curpos, 0x00)
				curpos += strlen
			elif par_type in [SCPT_DATA1, SCPT_DATA2, SCPT_PTRS]:
				if cmd_id[0] == 0x0B:
					cmdlen = 0
					while curpos + cmdlen < len(scenedata):
						if (scenedata[curpos + cmdlen] & 0x80) == 0x00:
							break	# a value 00..7F terminates the array and is NOT part of the data
						cmdlen += 1
					par_val = scene_read_array(scenedata, file_usage, curpos, cmdlen)
					par_val = [val & 0x7F for val in par_val]	# The engine strips bit 7 before processing.
					curpos += cmdlen
				elif cmd_id[0] == 0x30:
					dlen = params[-1][1] * 0x02
					darray = scene_read_array(scenedata, file_usage, curpos, dlen)
					par_val = [v[0] for v in struct.iter_unpack("<H", darray)]
					curpos += dlen
					
					flags = LBLFLG_JP
					for ptr in par_val:
						if ptr not in label_list:
							label_list[ptr] = (par_type, flags | ref_flags, None)
						else:
							lbl = label_list[ptr]
							label_list[ptr] = (lbl[0], lbl[1] | flags | ref_flags, lbl[2])
						if ptr >= start_ofs:
							remaining_code_locs.append(ptr)
				else:
					print(f"Error: Unhandled data in command 0x{cmd_id[0]:02X}!")
					return 1
			else:
				print(f"Error: Unhandled data type 0x{par_type:02X}!")
				return 1
			
			if (par_type & SCPT_MASK) == SCPTM_PTR:
				# pointer parameters: add label for them
				if par_val >= start_ofs:
					flags = 0x00
					if cmd_id[0] == 0x08:
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
				if cmd_id[0] == 0x0B:	# VARCMP
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
		if lbl_flags & LBLFLG_CALL:
			lbl_prefix = "sub"
		elif (lbl_flags & LBLFLG_JP) or (par_type == SCPT_JUMP):
			lbl_prefix = "loc"
		elif par_type in [SCPT_DATA1, SCPT_DATA2]:
			lbl_prefix = "data"
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
				new_mode = 1 if cmd_id[0] < 0 else 0
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
			
			if cmd_id[0] < 0:
				# output raw data (byte arrays, word arrays, strings, ...)
				group_size = 8
				group_list = None
				show_idx = False
				comment = None
				if cmd_pos in label_list:
					lbl_flags = label_list[cmd_pos][1]
				elif cmd_id[0] == -20:
					cmd_name = "DW"	# Data: word (decimal)
					data_strs = [f"{val}" for val in params]
				elif cmd_id[0] == -2:
					cmd_name = "DW"	# Data: word (hex)
					data_strs = [f"0x{val:04X}" for val in params]
				elif cmd_id[0] == -10:
					cmd_name = "DB"	# Data: byte (decimal)
					data_strs = [f"{val}" for val in params]
				else:
					cmd_name = "DB"	# Data: byte (hex)
					data_strs = [f"0x{val:02X}" for val in params]
				
				if group_list is None:
					# output multiple lines with N items per line
					group_list = [i for i in range(group_size, len(data_strs), group_size)] + [len(data_strs)]
				start_idx = 0
				for end_idx in group_list:
					data_str = ", ".join(data_strs[start_idx : end_idx])
					f.write(f"\t{cmd_name}\t{data_str}")
					if show_idx:
						f.write(f"\t; {start_idx}")
					if comment is not None:
						f.write(f"\t; {comment}")
					f.write("\n")
					start_idx = end_idx
				last_mode = 1
			else:
				# output commands
				cmd_info = SCRIPT_CMD_LIST[cmd_id]
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
					elif par_type == SCPT_PTRS:
						dsvals = []
						for ptr in par_val:
							if ptr in label_list:
								dsvals.append(label_list[ptr][2])
							else:
								dsvals.append(f"0x{ptr:04X}")
						data_str = "[" + ", ".join(dsvals) + "]"
					elif par_type in [SCPT_FNAME, SCPT_STR]:
						data_str = str2asm_sjis(par_val)
					elif par_type == SCPT_DATA1:
						data_str = "[" + ", ".join([f"{val}" for val in par_val]) + "]"
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
						if cmd_id[0] == 0x0B:	# VARCMP
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
	
	print("Nostalgia 1907 Scenario Decompiler")
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
