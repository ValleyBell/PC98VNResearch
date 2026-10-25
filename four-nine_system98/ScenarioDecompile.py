#!/usr/bin/env python3
# TODO: determine exact version
#	- commands 01/2B/2C/45/46/47/48/49/6F/70/71 -> v1 (NOT v3)
#	- commands 79/7A/7B/89/8A/8B/8C -> v1.10/V3 (NOT v1.00)
#	- commands 69/8D/8E -> v3.00 (NOT v1)
#	- commands 8F/90/... -> v3.10
#	- no initial comment -> v4 (Windows)
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
SCPTM_REG = 0x80	# register

SCPT_BYTE = 0x01	# "byte" (2-byte parameter, high byte ignored)
SCPT_INT = 0x02		# 2-byte integer
SCPT_LONG = 0x03	# 4-byte integer
SCPT_ILVAR = 0x04	# 2-byte/4-byte integer, based on previous register ID
SCPT_HEX = 0x08		# integer, output as hexadecimal
SCPT_INTH = SCPT_INT | SCPT_HEX

SCPT_DATA1 = 0x10	# data pointer (1-byte groups)
SCPT_DATA2 = 0x11	# data pointer (2-byte groups)
SCPT_STR = 0x12		# string pointer
SCPT_FNAME = 0x13	# file path pointer
SCPT_JUMP = 0x14	# jump destination pointer
SCPT_TXTSEL = 0x15	# text/menu selection list
SCPT_FONTDAT = 0x16	# font data
SCPT_86DAT = 0x17	# data for command 86
SCPT_89DAT = 0x18	# data for command 89
SCPT_PAD = 0x1F		# padding for 2-byte alignment

SCPT_REG_INT = 0x80	# register: integer
SCPT_REG_LNG = 0x81	# register: long
SCPT_REG_IL = 0x82	# register: integer/long
SCPT_REG_STR = 0x83	# register: string

SC_EXEC_END = 0x01	# terminate script execution here
SC_EXEC_SPC = 0xFF	# special handling

LBLFLG_UNUSED = 0x01


SCNVER_ALL = (None, )
SCNVER_100 = (100, )	# v1.00 only
SCNVER_110 = (110, )	# v1.10 only (not v1.00, not v3/v4)
SCNVER_11P = (110, 300, 310, 312, 400)	# v1.01 and later
SCNVER_1XX = (100, 110)	# v1.xx
SCNVER_312 = (312, )	# v3.12 only
SCNVER_31P = (312, 400)	# v3.12 only
SCNVER_3XX = (300, 310, 312)	# v3.xx (not v1, not v4)
SCNVER_400 = (400, )	# v4 only

SCENE_CMD_LIST_PC98 = {
	0x00: ("EXIT",    SCNVER_ALL, [], SC_EXEC_END),
	0x01: ("TBIMG"  , SCNVER_1XX, [SCPT_INT, SCPT_BYTE, SCPT_FNAME, SCPT_BYTE]),
	0x02: ("IMGLOAD", SCNVER_ALL, [SCPT_INT, SCPT_INT, SCPT_BYTE, SCPT_BYTE, SCPT_FNAME, SCPT_BYTE]),
	0x03: ("TBOPEN" , SCNVER_ALL, [SCPT_INT, SCPT_INT, SCPT_INT, SCPT_INT, SCPT_INT, SCPT_INT]),
	0x04: ("TBCLOSE", SCNVER_ALL, [SCPT_INT]),
	0x05: ("TBCLEAR", SCNVER_ALL, [SCPT_INT]),
	0x06: ("PALAPL" , SCNVER_ALL, []),
	0x07: ("PALBW"  , SCNVER_ALL, [SCPT_INT, SCPT_INT]),
	0x08: ("PALFADE", SCNVER_ALL, [SCPT_INT, SCPT_INT]),
	0x09: ("PALLCKT", SCNVER_ALL, [SCPT_BYTE]),
	0x0A: ("JP"     , SCNVER_ALL, [SCPT_JUMP], SC_EXEC_END),
	0x0B: ("CMPR"   , SCNVER_ALL, [SCPT_REG_INT, SCPT_REG_INT]),
	0x0C: ("CMPI"   , SCNVER_ALL, [SCPT_REG_INT, SCPT_INT]),
	0x0D: ("JEQ"    , SCNVER_ALL, [SCPT_JUMP]),
	0x0E: ("JLT"    , SCNVER_ALL, [SCPT_JUMP]),
	0x0F: ("JGT"    , SCNVER_ALL, [SCPT_JUMP]),
	0x10: ("JGE"    , SCNVER_ALL, [SCPT_JUMP]),
	0x11: ("JLE"    , SCNVER_ALL, [SCPT_JUMP]),
	0x12: ("JNE"    , SCNVER_ALL, [SCPT_JUMP]),
	0x13: ("JTBL"   , SCNVER_ALL, [SCPT_REG_INT], SC_EXEC_SPC),
	0x14: ("PALCSET", SCNVER_ALL, [SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT]),
	0x15: ("PRINT"  , SCNVER_ALL, [SCPT_BYTE, SCPT_STR]),
	0x16: ("PRINTXY", SCNVER_ALL, [SCPT_INT, SCPT_INT, SCPT_STR]),
	0x17: (None     , SCNVER_ALL, []),
	0x18: ("MOVI"   , SCNVER_ALL, [SCPT_REG_IL, SCPT_ILVAR]),
	0x19: ("MOVR"   , SCNVER_ALL, [SCPT_REG_IL, SCPT_REG_IL]),
	0x1A: ("BGMPLAY", SCNVER_ALL, [SCPT_FNAME]),
	0x1B: ("BGMFADE", SCNVER_ALL, []),
	0x1C: ("BGMSTOP", SCNVER_ALL, []),
	0x1D: ("BGMMODE", SCNVER_ALL, [SCPT_REG_INT]),
	0x1E: ("WAITKEY", SCNVER_ALL, [SCPT_REG_INT]),
	0x1F: ("LDSCENE", SCNVER_ALL, [SCPT_FNAME], SC_EXEC_END),
	0x20: ("GV02"   , SCNVER_ALL, []),
	0x21: ("WAIT"   , SCNVER_ALL, [SCPT_REG_INT]),
	0x22: ("CHRDLY" , SCNVER_ALL, [SCPT_REG_INT]),
	0x23: (None     , SCNVER_ALL, []),
	0x24: ("ADDI"   , SCNVER_ALL, [SCPT_REG_IL, SCPT_ILVAR]),
	0x25: ("SUBI"   , SCNVER_ALL, [SCPT_REG_IL, SCPT_ILVAR]),
	0x26: ("TXCLR1" , SCNVER_ALL, [SCPT_INT, SCPT_INT, SCPT_INT, SCPT_INT, SCPT_BYTE]),
	0x27: ("ADDR"   , SCNVER_ALL, [SCPT_REG_IL, SCPT_REG_IL]),
	0x28: ("SUBR"   , SCNVER_ALL, [SCPT_REG_IL, SCPT_REG_IL]),
	0x29: ("XYREAD" , SCNVER_ALL, [SCPT_REG_INT, SCPT_INT, SCPT_INT]),	# TODO: all REG_INT
	0x2A: ("XYWRT"  , SCNVER_ALL, [SCPT_REG_INT, SCPT_INT, SCPT_INT]),	# TODO: all REG_INT
	0x2B: ("REGFSVA", SCNVER_1XX, [SCPT_FNAME]),
	0x2C: ("REGFLDA", SCNVER_1XX, [SCPT_FNAME]),
	0x2D: ("REGCLR" , SCNVER_ALL, [SCPT_REG_INT, SCPT_REG_INT]),
	0x2E: ("RNDI"   , SCNVER_312, [SCPT_INT, SCPT_REG_INT]),
	0x2F: ("BLIT1I" , SCNVER_ALL, [SCPT_BYTE, SCPT_INT, SCPT_INT, SCPT_INT, SCPT_INT, SCPT_BYTE, SCPT_INT, SCPT_INT]),
	0x30: (None     , SCNVER_ALL, []),
	0x31: (None     , SCNVER_ALL, []),
	0x32: ("PRINTR" , SCNVER_ALL, [SCPT_BYTE, SCPT_REG_INT]),
	0x33: ("GPDGET" , SCNVER_ALL, [SCPT_REG_INT]),
	0x34: ("GPDSET" , SCNVER_ALL, [SCPT_REG_INT]),
	0x35: ("TXFILL" , SCNVER_ALL, [SCPT_INT, SCPT_INT, SCPT_INT, SCPT_INT, SCPT_INT, SCPT_INTH]),
	0x36: ("GFX36"  , SCNVER_ALL, []),
	0x37: ("XYFLOAD", SCNVER_ALL, [SCPT_FNAME]),
	0x38: ("ANDR"   , SCNVER_ALL, [SCPT_REG_INT, SCPT_REG_INT]),
	0x39: ("ORR"    , SCNVER_ALL, [SCPT_REG_INT, SCPT_REG_INT]),
	0x3A: ("BLIT1R" , SCNVER_ALL, [SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT]),
	0x3B: ("BLIT1RL", SCNVER_ALL, [SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT]),
	0x3C: ("TXCLR2" , SCNVER_ALL, [SCPT_INT, SCPT_INT, SCPT_INT, SCPT_INT, SCPT_BYTE]),
	0x3D: ("MULR"   , SCNVER_ALL, [SCPT_REG_IL, SCPT_REG_IL]),
	0x3E: ("DIVR"   , SCNVER_ALL, [SCPT_REG_IL, SCPT_REG_IL]),
	0x3F: ("CMD3F"  , SCNVER_ALL, [SCPT_REG_INT, SCPT_REG_INT]),
	0x40: ("MENUSEL", SCNVER_ALL, [SCPT_REG_INT, SCPT_REG_INT, SCPT_TXTSEL, SCPT_JUMP], SC_EXEC_SPC),
	0x41: ("CMD41"  , SCNVER_ALL, [SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT, SCPT_JUMP]),
	0x42: ("CMD42"  , SCNVER_ALL, [SCPT_BYTE]),
	0x43: ("CMD43"  , SCNVER_ALL, [SCPT_REG_INT, SCPT_REG_INT]),
	0x44: ("NOP44"  , SCNVER_1XX, []),
	0x45: ("CMD45"  , SCNVER_1XX, [SCPT_INT]),
	0x46: (None     , SCNVER_ALL, []),
	0x47: (None     , SCNVER_ALL, []),
	0x48: (None     , SCNVER_ALL, []),
	0x49: (None     , SCNVER_ALL, []),
	0x4A: ("REGFSAV", SCNVER_ALL, [SCPT_BYTE, SCPT_FNAME]),
	0x4B: ("REGFLD" , SCNVER_ALL, [SCPT_BYTE, SCPT_FNAME]),
	0x4C: ("CMD4C"  , SCNVER_ALL, [SCPT_REG_INT, SCPT_REG_INT]),
	0x4D: ("BGMMEAS", SCNVER_ALL, [SCPT_REG_INT]),
	0x4E: ("SFXSSG" , SCNVER_ALL, [SCPT_BYTE]),
	0x4F: ("SFXFM"  , SCNVER_ALL, [SCPT_BYTE]),
	0x50: ("BGMSTAT", SCNVER_ALL, [SCPT_REG_INT]),
	0x51: ("ANDI"   , SCNVER_ALL, [SCPT_REG_INT, SCPT_INTH]),
	0x52: ("ORI"    , SCNVER_ALL, [SCPT_REG_INT, SCPT_INTH]),
	0x53: ("STRCAT" , SCNVER_ALL, [SCPT_REG_STR, SCPT_REG_STR]),
	0x54: ("CALL"   , SCNVER_ALL, [SCPT_JUMP]),
	0x55: ("RET"    , SCNVER_ALL, [], SC_EXEC_END),
	0x56: ("STRCMPR", SCNVER_ALL, [SCPT_REG_STR, SCPT_REG_STR]),
	0x57: ("STRNCPY", SCNVER_ALL, [SCPT_REG_STR, SCPT_REG_STR, SCPT_INT]),
	0x58: ("STRCPYC", SCNVER_ALL, [SCPT_REG_STR, SCPT_REG_STR, SCPT_INT]),
	0x59: ("STRCPYI", SCNVER_ALL, [SCPT_REG_STR, SCPT_STR]),
	0x5A: ("STRCLR" , SCNVER_ALL, [SCPT_REG_STR]),
	0x5B: ("STRCPY" , SCNVER_ALL, [SCPT_REG_STR, SCPT_REG_STR]),
	0x5C: (None     , SCNVER_ALL, []),
	0x5D: (None     , SCNVER_ALL, []),
	0x5E: ("CMD5E"  , SCNVER_ALL, [SCPT_BYTE, SCPT_INT, SCPT_INT, SCPT_INT, SCPT_INT]),
	0x5F: ("STRTIME", SCNVER_ALL, [SCPT_REG_STR]),
	0x60: ("FILETM" , SCNVER_ALL, [SCPT_REG_INT, SCPT_REG_STR, SCPT_FNAME]),
	0x61: ("XYFSAVE", SCNVER_ALL, [SCPT_FNAME]),
	0x62: ("CMD62"  , SCNVER_ALL, [SCPT_REG_INT, SCPT_REG_INT]),
	0x63: ("BLIT2I" , SCNVER_ALL, [SCPT_BYTE, SCPT_INT, SCPT_INT, SCPT_INT, SCPT_INT, SCPT_BYTE, SCPT_INT, SCPT_INT]),
	0x64: ("BLIT2R" , SCNVER_ALL, [SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT]),
	0x65: (None     , SCNVER_ALL, []),
	0x66: (None     , SCNVER_ALL, []),
	0x67: ("GFX67"  , SCNVER_ALL, [SCPT_BYTE, SCPT_BYTE, SCPT_BYTE, SCPT_BYTE]),
	0x68: ("GFX68"  , SCNVER_ALL, [SCPT_REG_INT, SCPT_REG_INT]),
	0x69: ("GFX69"  , SCNVER_3XX, [SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT]),
	0x6A: ("CMD6A"  , SCNVER_ALL, [SCPT_INT, SCPT_INT, SCPT_INT, SCPT_INT]),
	0x6B: ("CMD6B"  , SCNVER_ALL, [SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT]),
	0x6C: (None     , SCNVER_ALL, []),
	0x6D: (None     , SCNVER_ALL, []),
	0x6E: ("STRLEN" , SCNVER_ALL, [SCPT_REG_INT, SCPT_REG_STR]),
	0x6F: ("MOVRLI" , SCNVER_1XX, [SCPT_REG_INT, SCPT_REG_INT]),
	0x70: ("MOVRIL" , SCNVER_1XX, [SCPT_REG_INT, SCPT_REG_INT]),
	0x71: ("CMPRL"  , SCNVER_1XX, [SCPT_REG_INT, SCPT_REG_INT]),
	0x72: ("FRMSTI" , SCNVER_ALL, [SCPT_INT]),
	0x73: ("FRMGTR" , SCNVER_ALL, [SCPT_REG_INT]),
	0x74: ("FRMJPI" , SCNVER_ALL, [SCPT_INT, SCPT_JUMP]),
	0x75: ("FONTCHR", SCNVER_ALL, [SCPT_INTH, SCPT_FONTDAT]),
	0x76: ("IDLECHR", SCNVER_ALL, [SCPT_INTH, SCPT_INTH, SCPT_INTH, SCPT_INTH, SCPT_INTH, SCPT_INTH, SCPT_INTH, SCPT_INTH]),
	0x77: ("IDLEDLY", SCNVER_ALL, [SCPT_INT, SCPT_INT, SCPT_INT, SCPT_INT, SCPT_INT, SCPT_INT, SCPT_INT, SCPT_INT]),
	0x78: ("IDLEXY" , SCNVER_ALL, [SCPT_INT, SCPT_INT]),
	0x79: ("CMD79"  , SCNVER_11P, [SCPT_DATA2]),
	0x7A: ("FRMSTR" , SCNVER_11P, [SCPT_REG_INT]),
	0x7B: ("FRMJPR" , SCNVER_11P, [SCPT_REG_INT, SCPT_JUMP]),
	0x7C: (None     , SCNVER_ALL, []),
	0x7D: (None     , SCNVER_ALL, []),
	0x7E: (None     , SCNVER_ALL, []),
	0x7F: ("EXITR",   SCNVER_ALL, [SCPT_REG_INT], SC_EXEC_END),
	0x80: ("STRFLD" , SCNVER_ALL, [SCPT_REG_STR, SCPT_FNAME]),
	0x81: ("STRFSAV", SCNVER_ALL, [SCPT_REG_STR, SCPT_FNAME]),
	0x82: ("GFX82"  , SCNVER_ALL, []),
	0x83: ("GFX83"  , SCNVER_ALL, [SCPT_REG_INT]),
	0x84: ("GFX84"  , SCNVER_ALL, []),
	0x85: ("GFX85"  , SCNVER_ALL, []),
	0x86: ("PTDATA" , SCNVER_ALL, [SCPT_86DAT]),
	0x87: ("PTDAT1" , SCNVER_ALL, [SCPT_INT, SCPT_BYTE, SCPT_INT, SCPT_INT, SCPT_BYTE, SCPT_BYTE, SCPT_BYTE, SCPT_BYTE, SCPT_BYTE, SCPT_BYTE]),
	0x88: ("PTDSTI" , SCNVER_ALL, [SCPT_BYTE, SCPT_INT, SCPT_INT]),
	0x89: ("PTPOSA" , SCNVER_11P, [SCPT_89DAT]),
	0x8A: ("PTPOS1R", SCNVER_11P, [SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT]),
	0x8B: ("PTDSTR" , SCNVER_11P, [SCPT_REG_INT, SCPT_INT, SCPT_INT]),
	0x8C: ("GFX8C"  , SCNVER_11P, []),
	0x8D: ("GFX8D"  , SCNVER_3XX, []),
	0x8E: ("GFX8E"  , SCNVER_3XX, []),
	0x8F: ("LDSUBSC", SCNVER_31P, [SCPT_INTH, SCPT_FNAME]),
	0x90: ("POPCALL", SCNVER_31P, []),
	0x91: ("SNDMODE", SCNVER_31P, [SCPT_REG_INT, SCPT_REG_INT]),
	0x92: ("NAMECHG", SCNVER_31P, []),
	0x93: ("GETKEY" , SCNVER_31P, [SCPT_REG_INT]),
	0x94: ("NOP"    , SCNVER_31P, []),
	0x95: ("GFX95"  , SCNVER_31P, [SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT]),
	0x96: ("GFX96"  , SCNVER_31P, [SCPT_REG_INT, SCPT_REG_INT]),
	0x97: ("SHOWEND", SCNVER_31P, []),
	0x98: ("CMD98"  , SCNVER_312, [SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT]),
}
SCENE_CMD_LIST_WIN = {
	0x00: ("EXIT",    SCNVER_ALL, [], SC_EXEC_END),
	0x01: ("EXITR",   SCNVER_400, [SCPT_REG_INT], SC_EXEC_END),	# !! different from v1..v3
	0x02: ("IMGLOAD", SCNVER_400, [SCPT_INT, SCPT_INT, SCPT_BYTE, SCPT_BYTE, SCPT_FNAME, SCPT_BYTE, SCPT_BYTE]),	# !! different from v1..v3
	0x03: ("TBOPEN" , SCNVER_ALL, [SCPT_INT, SCPT_INT, SCPT_INT, SCPT_INT, SCPT_INT, SCPT_INT]),
	0x04: ("TBCLOSE", SCNVER_ALL, [SCPT_INT]),
	0x05: ("TBCLEAR", SCNVER_ALL, [SCPT_INT]),
	0x06: ("PALAPL" , SCNVER_ALL, []),
	0x07: ("PALBW"  , SCNVER_ALL, [SCPT_INT, SCPT_INT]),
	0x08: ("PALFADE", SCNVER_ALL, [SCPT_INT, SCPT_INT]),
	0x09: ("PALLCKT", SCNVER_ALL, [SCPT_BYTE]),
	0x0A: ("JP"     , SCNVER_ALL, [SCPT_JUMP], SC_EXEC_END),
	0x0B: ("CMPR"   , SCNVER_ALL, [SCPT_REG_INT, SCPT_REG_INT]),
	0x0C: ("CMPI"   , SCNVER_ALL, [SCPT_REG_INT, SCPT_INT]),
	0x0D: ("JEQ"    , SCNVER_ALL, [SCPT_JUMP]),
	0x0E: ("JLT"    , SCNVER_ALL, [SCPT_JUMP]),
	0x0F: ("JGT"    , SCNVER_ALL, [SCPT_JUMP]),
	0x10: ("JGE"    , SCNVER_ALL, [SCPT_JUMP]),
	0x11: ("JLE"    , SCNVER_ALL, [SCPT_JUMP]),
	0x12: ("JNE"    , SCNVER_ALL, [SCPT_JUMP]),
	0x13: ("JTBL"   , SCNVER_ALL, [SCPT_REG_INT], SC_EXEC_SPC),
	0x14: ("PALCSET", SCNVER_ALL, [SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT]),
	0x15: ("PRINT"  , SCNVER_ALL, [SCPT_BYTE, SCPT_STR]),
	0x16: (None     , SCNVER_400, []),
	0x17: (None     , SCNVER_ALL, []),
	0x18: ("MOVI"   , SCNVER_ALL, [SCPT_REG_IL, SCPT_ILVAR]),
	0x19: ("MOVR"   , SCNVER_ALL, [SCPT_REG_IL, SCPT_REG_IL]),
	0x1A: ("BGMPLAY", SCNVER_ALL, [SCPT_FNAME]),
	0x1B: ("BGMFADE", SCNVER_ALL, []),
	0x1C: ("BGMSTOP", SCNVER_ALL, []),
	0x1D: (None     , SCNVER_400, []),
	0x1E: ("WAITKEY", SCNVER_ALL, [SCPT_REG_INT]),
	0x1F: ("LDSCENE", SCNVER_ALL, [SCPT_FNAME], SC_EXEC_END),
	0x20: ("GV02"   , SCNVER_ALL, []),
	0x21: ("WAIT"   , SCNVER_ALL, [SCPT_REG_INT]),
	0x22: ("CHRDLY" , SCNVER_ALL, [SCPT_REG_INT]),
	0x23: (None     , SCNVER_ALL, []),
	0x24: ("ADDI"   , SCNVER_ALL, [SCPT_REG_IL, SCPT_ILVAR]),
	0x25: ("SUBI"   , SCNVER_ALL, [SCPT_REG_IL, SCPT_ILVAR]),
	0x26: (None     , SCNVER_400, []),
	0x27: ("ADDR"   , SCNVER_ALL, [SCPT_REG_IL, SCPT_REG_IL]),
	0x28: ("SUBR"   , SCNVER_ALL, [SCPT_REG_IL, SCPT_REG_IL]),
	0x29: (None     , SCNVER_400, []),
	0x2A: (None     , SCNVER_400, []),
	0x2B: (None     , SCNVER_400, []),
	0x2C: (None     , SCNVER_400, []),
	0x2D: ("REGCLR" , SCNVER_ALL, [SCPT_REG_INT, SCPT_REG_INT]),
	0x2E: (None     , SCNVER_400, []),
	0x2F: ("BLIT1I" , SCNVER_ALL, [SCPT_BYTE, SCPT_INT, SCPT_INT, SCPT_INT, SCPT_INT, SCPT_BYTE, SCPT_INT, SCPT_INT]),
	0x30: (None     , SCNVER_ALL, []),
	0x31: (None     , SCNVER_ALL, []),
	0x32: ("PRINTR" , SCNVER_ALL, [SCPT_BYTE, SCPT_REG_INT]),
	0x33: ("GPDGET" , SCNVER_ALL, [SCPT_REG_INT]),
	0x34: ("GPDSET" , SCNVER_ALL, [SCPT_REG_INT]),
	0x35: (None     , SCNVER_400, []),
	0x36: ("GFX36"  , SCNVER_ALL, []),
	0x37: (None     , SCNVER_400, []),
	0x38: ("ANDR"   , SCNVER_ALL, [SCPT_REG_INT, SCPT_REG_INT]),
	0x39: ("ORR"    , SCNVER_ALL, [SCPT_REG_INT, SCPT_REG_INT]),
	0x3A: ("BLIT1R" , SCNVER_ALL, [SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT]),
	0x3B: (None     , SCNVER_400, []),
	0x3C: (None     , SCNVER_400, []),
	0x3D: ("MULR"   , SCNVER_ALL, [SCPT_REG_IL, SCPT_REG_IL]),
	0x3E: ("DIVR"   , SCNVER_ALL, [SCPT_REG_IL, SCPT_REG_IL]),
	0x3F: ("CMD3F"  , SCNVER_ALL, [SCPT_REG_INT, SCPT_REG_INT]),
	0x40: ("MENUSEL", SCNVER_ALL, [SCPT_REG_INT, SCPT_REG_INT, SCPT_TXTSEL, SCPT_JUMP], SC_EXEC_SPC),
	0x41: ("CMD41"  , SCNVER_ALL, [SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT, SCPT_JUMP]),
	0x42: ("CMD42"  , SCNVER_ALL, [SCPT_BYTE]),
	0x43: ("CMD43"  , SCNVER_ALL, [SCPT_REG_INT, SCPT_REG_INT]),
	0x44: (None     , SCNVER_400, []),
	0x45: (None     , SCNVER_400, []),
	0x46: (None     , SCNVER_ALL, []),
	0x47: (None     , SCNVER_ALL, []),
	0x48: (None     , SCNVER_ALL, []),
	0x49: (None     , SCNVER_ALL, []),
	0x4A: ("REGFSAV", SCNVER_ALL, [SCPT_BYTE, SCPT_FNAME]),
	0x4B: ("REGFLD" , SCNVER_ALL, [SCPT_BYTE, SCPT_FNAME]),
	0x4C: ("CMD4C"  , SCNVER_ALL, [SCPT_REG_INT, SCPT_REG_INT]),
	0x4D: (None     , SCNVER_400, []),
	0x4E: ("SFXSSG" , SCNVER_ALL, [SCPT_BYTE]),
	0x4F: ("SFXWAV" , SCNVER_400, [SCPT_INT, SCPT_INT]),	# !! different from v1..v3
	0x50: (None     , SCNVER_400, []),
	0x51: ("ANDI"   , SCNVER_ALL, [SCPT_REG_INT, SCPT_INTH]),
	0x52: ("ORI"    , SCNVER_ALL, [SCPT_REG_INT, SCPT_INTH]),
	0x53: ("STRCAT" , SCNVER_ALL, [SCPT_REG_STR, SCPT_REG_STR]),
	0x54: ("CALL"   , SCNVER_ALL, [SCPT_JUMP]),
	0x55: ("RET"    , SCNVER_ALL, [], SC_EXEC_END),
	0x56: ("STRCMPR", SCNVER_ALL, [SCPT_REG_STR, SCPT_REG_STR]),
	0x57: ("STRNCPY", SCNVER_ALL, [SCPT_REG_STR, SCPT_REG_STR, SCPT_INT]),
	0x58: ("STRCPYC", SCNVER_ALL, [SCPT_REG_STR, SCPT_REG_STR, SCPT_INT]),
	0x59: ("STRCPYI", SCNVER_ALL, [SCPT_REG_STR, SCPT_STR]),
	0x5A: ("STRCLR" , SCNVER_ALL, [SCPT_REG_STR]),
	0x5B: ("STRCPY" , SCNVER_ALL, [SCPT_REG_STR, SCPT_REG_STR]),
	0x5C: (None     , SCNVER_ALL, []),
	0x5D: (None     , SCNVER_ALL, []),
	0x5E: ("CMD5E"  , SCNVER_ALL, [SCPT_BYTE, SCPT_INT, SCPT_INT, SCPT_INT, SCPT_INT]),
	0x5F: ("STRTIME", SCNVER_ALL, [SCPT_REG_STR]),
	0x60: ("FILETM" , SCNVER_ALL, [SCPT_REG_INT, SCPT_REG_STR, SCPT_FNAME]),
	0x61: (None     , SCNVER_400, []),
	0x62: ("CMD62"  , SCNVER_ALL, [SCPT_REG_INT, SCPT_REG_INT]),
	0x63: ("BLIT2I" , SCNVER_ALL, [SCPT_BYTE, SCPT_INT, SCPT_INT, SCPT_INT, SCPT_INT, SCPT_BYTE, SCPT_INT, SCPT_INT]),
	0x64: ("BLIT2R" , SCNVER_ALL, [SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT]),
	0x65: (None     , SCNVER_ALL, []),
	0x66: (None     , SCNVER_ALL, []),
	0x67: (None     , SCNVER_400, []),
	0x68: (None     , SCNVER_400, []),
	0x69: (None     , SCNVER_400, []),
	0x6A: ("CMD6A"  , SCNVER_ALL, [SCPT_INT, SCPT_INT, SCPT_INT, SCPT_INT]),
	0x6B: ("CMD6B"  , SCNVER_ALL, [SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT]),
	0x6C: (None     , SCNVER_ALL, []),
	0x6D: (None     , SCNVER_ALL, []),
	0x6E: ("STRLEN" , SCNVER_ALL, [SCPT_REG_INT, SCPT_REG_STR]),
	0x6F: (None     , SCNVER_400, []),
	0x70: (None     , SCNVER_400, []),
	0x71: (None     , SCNVER_400, []),
	0x72: ("FRMSTI" , SCNVER_ALL, [SCPT_INT]),
	0x73: ("FRMGTR" , SCNVER_ALL, [SCPT_REG_INT]),
	0x74: ("FRMJPI" , SCNVER_ALL, [SCPT_INT, SCPT_JUMP]),
	0x75: ("FONTCHR", SCNVER_ALL, [SCPT_INTH, SCPT_FONTDAT]),
	0x76: ("IDLECHR", SCNVER_ALL, [SCPT_INTH, SCPT_INTH, SCPT_INTH, SCPT_INTH, SCPT_INTH, SCPT_INTH, SCPT_INTH, SCPT_INTH]),
	0x77: ("IDLEDLY", SCNVER_ALL, [SCPT_INT, SCPT_INT, SCPT_INT, SCPT_INT, SCPT_INT, SCPT_INT, SCPT_INT, SCPT_INT]),
	0x78: ("IDLEXY" , SCNVER_ALL, [SCPT_INT, SCPT_INT]),
	0x79: (None     , SCNVER_400, []),
	0x7A: ("FRMSTR" , SCNVER_11P, [SCPT_REG_INT]),
	0x7B: ("FRMJPR" , SCNVER_11P, [SCPT_REG_INT, SCPT_JUMP]),
	0x7C: (None     , SCNVER_ALL, []),
	0x7D: (None     , SCNVER_ALL, []),
	0x7E: (None     , SCNVER_ALL, []),
	0x7F: (None     , SCNVER_400, []),
	0x80: ("STRFLD" , SCNVER_ALL, [SCPT_REG_STR, SCPT_FNAME]),
	0x81: ("STRFSAV", SCNVER_ALL, [SCPT_REG_STR, SCPT_FNAME]),
	0x82: (None     , SCNVER_400, []),
	0x83: (None     , SCNVER_400, []),
	0x84: (None     , SCNVER_400, []),
	0x85: (None     , SCNVER_400, []),
	0x86: (None     , SCNVER_400, []),
	0x87: (None     , SCNVER_400, []),
	0x88: (None     , SCNVER_400, []),
	0x89: (None     , SCNVER_400, []),
	0x8A: (None     , SCNVER_400, []),
	0x8B: (None     , SCNVER_400, []),
	0x8C: (None     , SCNVER_400, []),
	0x8D: (None     , SCNVER_400, []),
	0x8E: (None     , SCNVER_400, []),
	0x8F: ("LDSUBSC", SCNVER_31P, [SCPT_INTH, SCPT_FNAME]),
	0x90: ("POPCALL", SCNVER_31P, []),
	0x91: ("SNDMODE", SCNVER_31P, [SCPT_REG_INT, SCPT_REG_INT]),
	0x92: ("NAMECHG", SCNVER_31P, []),
	0x93: ("GETKEY" , SCNVER_31P, [SCPT_REG_INT]),
	0x94: ("NOP"    , SCNVER_31P, []),
	0x95: ("GFX95"  , SCNVER_31P, [SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT, SCPT_REG_INT]),
	0x96: ("GFX96"  , SCNVER_31P, [SCPT_REG_INT, SCPT_REG_INT]),
	0x97: ("SHOWEND", SCNVER_31P, []),
	0x98: (None     , SCNVER_400, []),
	0xF0: ("HALT"   , SCNVER_400, [SCPT_REG_INT]),
	0xFA: ("CDPLAY" , SCNVER_400, [SCPT_FNAME]),
	0xFB: ("CDFADE" , SCNVER_400, []),
	0xFC: ("CDSTOP" , SCNVER_400, []),
	0xFD: ("CMDFD"  , SCNVER_ALL, [SCPT_INT]),
	0xFE: ("CMDFE"  , SCNVER_ALL, [SCPT_BYTE]),
	0xFF: (None     , SCNVER_400, []),
}
TEXT_CMD_LIST = {
	0x00: 0,
	0x01: 0,
	0x02: 0,
	0x03: 1,
	0x04: 1,
	0x05: 2,
	0x06: 1,	# v1.10 .. 3.00
	0x07: 0,	# v1.10 .. 3.00
	0x08: 1,
	0x09: 0,
	0x0A: 0,	# v1.xx only
	0x0B: 1,	# v1.00 .. 3.00
	0x0C: 1,	# v1.10 .. 3.00
	0x0D: 0,
	0x0E: 1,	# v1.10 only
	0x0F: {		# v3.00+
		0x00: 1,	# v3.00+
		0x01: 0,	# v3.12+
		0x02: 0,	# v3.12+
		0x03: 0,	# v3.12+
	},
}

TKTP_INT = 0x01	# integer number (byte/word/dword)
TKTP_STR = 0x02	# string
TKTP_NAME = 0x80	# register or label name
TKTP_REG = 0x81	# register
TKTP_LBL = 0x82	# label name

TOKEN_ALPHABET = [chr(x) for x in \
	[x for x in range(0x30, 0x3A)] + \
	[x for x in range(0x41, 0x5B)] + \
	[x for x in range(0x61, 0x7B)]] + ["_"]

MODULE_PATH = os.path.dirname(__file__)
JISCHR_COMMENTS = {}
necjis = nec_jis_conv.JISConverter()
config = {}
MOD_DESC_LEN = 0x100	# first 0x100 bytes are reserved for the module description
SCENE_CMD_LIST = None


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

def scene_read_int(scenedata: bytes, usage_mask: list, pos: int, mask: int = 0x01) -> int:
	usage_mask[pos + 0x00] |= mask
	usage_mask[pos + 0x01] |= mask
	return struct.unpack_from("<H", scenedata, pos)[0]

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
				pass	# used by System98 v1 game scripts for halfwidth Katakana
			elif c <= 0x0F:
				pass	# allow for text control commands
			elif c == 0x00:
				break
			elif c <= 0x0F:
				pass	# allow for text control commands
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
	if (len(data) % 2) == 0:
		dlist = [v[0] for v in struct.iter_unpack("<H", data)]
		exitIdx = -1
		for i in range((len(dlist)+4) // 5):	# items: 1/6/11/16/... -> indices: 1/2/3/4
			dentry = dlist[i*5 : (i+1)*5]
			if dentry[0] == 0:
				if i == 0:
					exitIdx = i	# assume invalid for 1-element data
				break
			if dentry[0] != i+1:	# consecutive entries, starting with 1
				exitIdx = i
				break
			if len(dentry) != 5 or max(dentry) > 640:
				exitIdx = i
				break
		if exitIdx == -1:
			return SCPT_TXTSEL
	
	nullpos = data.find(0)
	if nullpos > 1:	# need at least 1 character
		dstr = data[0 : nullpos]
		if dstr[0] < 0x20:	# first character of file names = archive ID
			if sum([1 for c in dstr[1:] if not (c >= 0x20 and c <= 0x7E)]) == 0:
				return SCPT_FNAME
		if is_sjis_str(dstr):
			return SCPT_STR
	return -1

def test_for_code(scenedata: bytes, file_usage: list, startpos: int) -> bool:
	# --- parse unknown data as code and do basic syntax checking ---
	# The function is used to detect code in unreferenced data sections.
	curpos = startpos
	while curpos < len(scenedata):
		cmd_id = struct.unpack_from("<H", scenedata, curpos)[0]
		curpos += 0x02
		if cmd_id >= 0x100:
			return False
		if cmd_id not in SCENE_CMD_LIST:
			return False
		cmd_info = SCENE_CMD_LIST[cmd_id]
		if cmd_info[0] is None:
			return False
		
		# parse/skip all parameters
		first_reg_type = None
		for par_type in cmd_info[2]:
			if (par_type & ~SCPT_HEX) == SCPT_ILVAR:
				# variable-size parameter
				if first_reg_type == SCPT_REG_STR:
					par_type = SCPT_STR
				elif first_reg_type == SCPT_REG_LNG:
					par_type = SCPT_LONG | (par_type & SCPT_HEX)
				else:
					par_type = SCPT_INT | (par_type & SCPT_HEX)
			
			if par_type == SCPT_LONG:
				par_val = struct.unpack_from("<I", scenedata, curpos)[0]
				curpos += 0x04
			else:
				par_val = struct.unpack_from("<H", scenedata, curpos)[0]
				curpos += 0x02
			
			if (first_reg_type is None) and (par_type & SCPT_MASK) == SCPTM_REG:
				if par_type == SCPT_REG_IL:
					if (par_val < 0x400) or (config.engine_ver >= 310):
						first_reg_type = SCPT_REG_INT
					else:
						first_reg_type = SCPT_REG_LNG
				else:
					first_reg_type = par_type
		
		if len(cmd_info) >= 4:
			# stop parsing at certain commands - result will be success
			if cmd_info[3] == SC_EXEC_END:
				break
			elif cmd_info[3] == SC_EXEC_SPC:
				if cmd_id == 0x13:	# jump table
					break
	return True

def get_string_size(scenedata: bytes, startpos: int, endpos: int, dtype: int) -> int:
	pos = startpos
	if dtype == SCPT_FNAME:
		if (pos + 2 <= endpos):
			if (scenedata[pos+0] < 0x20) and (scenedata[pos+1] >= 0x20):	# archive ID
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
			elif c in TEXT_CMD_LIST:
				par_bytes = TEXT_CMD_LIST[c]
				while type(par_bytes) is dict:
					if pos >= endpos:
						par_bytes = 0
						break
					c = scenedata[pos]
					pos += 1
					if c in par_bytes:
						par_bytes = par_bytes[c]
					else:
						par_bytes = 0	# invalid command - assume no parameters
				pos += par_bytes
	return min([pos, endpos]) - startpos

def find_possible_code(scenedata: bytes, file_usage: list, label_list: dict, start_ofs: int) -> int:
	# --- scan all unreferenced data sections and return the position of a potential (unused) code section ---
	curpos = start_ofs
	while True:
		# search for next unparsed section
		while (curpos < len(scenedata)) and (file_usage[curpos] != 0x00):
			# TODO: potential speed-up by not scanning the same section multiple times
			# (I need to figure out what side effects this could cause.)
			#file_usage[curpos] |= 0x80	# mark as "already scanned"
			curpos += 1
		if curpos >= len(scenedata):
			break
		
		if curpos in label_list:
			dtype = label_list[curpos][0]
		else:
			dtype = guess_data_type(scenedata, curpos, len(scenedata))
		
		if dtype >= 0:
			# known (or detected) data section - just skip
			endpos = find_next_label(label_list, curpos + 1)
			if endpos < 0:
				endpos = len(scenedata)
			if dtype in [SCPT_STR, SCPT_FNAME]:
				strsize = get_string_size(scenedata, curpos, endpos, dtype)
				if strsize > 0:
					endpos = curpos + strsize
			#for pos in range(curpos, endpos):
			#	file_usage[pos] |= 0x80
			curpos = endpos
		else:
			is_code = test_for_code(scenedata, file_usage, curpos)
			if is_code:
				#print(f"Found possible code at 0x{curpos:04X}")
				return curpos
			else:
				# skip entire unused block
				while (curpos < len(scenedata)) and (file_usage[curpos] == 0x00):
					#file_usage[curpos] |= 0x80
					curpos += 1
	return -1

def check_command_version(cmd_vers: int) -> bool:
	for ver in cmd_vers:
		if ver is None:
			return True	# supported by all versions
		if ver == config.engine_ver:
			return True
	return False

def parse_scene_binary(scenedata: bytes, imported_symbols: dict) -> tuple:
	if config.base_ofs > 0:
		# Just adding padding at the beginning to do the offset is not efficient. But
		# it is the simplest way to do so, considering that many parts of the analysis
		# code make no difference between "code pointer" offset and "real file offset".
		scenedata = bytes([0] * config.base_ofs) + scenedata
	start_ofs = config.base_ofs + config.desc_len	# code starts right after the module description text
	
	cmd_list = []	# list[ tuple(file offset, command ID, list[params] ) ]
	file_usage = [0x00] * len(scenedata)
	label_list = {}	# dict{ file offset: (label type, flags, label name) }
	
	if config.engine_ver != 0:
		# put engine version
		cmd_list += [(-9, -9, config.engine_ver)]
	
	if config.base_ofs != 0:
		# put base offset
		cmd_list += [(-8, -8, config.base_ofs)]
	
	if config.desc_len > 0:
		# --- parse description ---
		mod_desc = scenedata[config.base_ofs : start_ofs]
		if b'\x00' in mod_desc:
			mod_desc = mod_desc[:mod_desc.find(b'\x00')]
		if len(mod_desc) > 0:
			cmd_list += [(-7, -7, mod_desc)]
	
	cmd_list += [(-6, -6, None)]	# placeholder for includes
	
	# --- parse code sections ---
	if start_ofs < 0x1000:
		label_list[start_ofs] = (SCPT_JUMP, 0x00, f"start_{start_ofs:04X}")
	else:
		label_list[start_ofs] = (SCPT_JUMP, 0x00, None)	# no "start" for sub-modules
	remaining_code_locs = [start_ofs]
	curpos = None
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
					label_list[curpos] = (SCPT_JUMP, LBLFLG_UNUSED, None)
				else:
					curpos = None
		if curpos is None:
			break	# exit loop when no more code sections are found
		if curpos >= len(scenedata):
			curpos = None
			continue
		if (file_usage[curpos] & 0x0F) != 0x00:
			curpos = None
			continue
		
		cmd_pos = curpos
		cmd_id = scene_read_int(scenedata, file_usage, cmd_pos, 0x11)
		curpos += 0x02
		if cmd_id == 0xFFFF:
			# This is commonly used to just quit the game.
			cmd_list += [(cmd_pos, -2, [cmd_id])]
			curpos = None	# stop processing here
			continue
		if cmd_id >= 0x100:
			# The game engine treats this as command 0x00. (return to DOS)
			print(f"Pos 0x{cmd_pos:04X}: Found invalid command ID 0x{cmd_id:02X}!")
			file_usage[cmd_pos+0] &= ~0x01	# remove 0x01, keep 0x10 to enforce skip during code test
			file_usage[cmd_pos+1] &= ~0x01
			curpos = None	# stop processing here
			continue
		if cmd_id not in SCENE_CMD_LIST:
			# These commands will crash the game.
			print(f"Pos 0x{cmd_pos:04X}: Found invalid command ID 0x{cmd_id:02X}!")
			cmd_list += [(cmd_pos, -2, [cmd_id])]
			continue
		
		cmd_info = SCENE_CMD_LIST[cmd_id]
		if cmd_info[0] is None:
			# The game engine will quit with an error message for these commands.
			print(f"Pos 0x{cmd_pos:04X}: Found reserved command ID 0x{cmd_id:02X}!")
			cmd_list += [(cmd_pos, -2, [cmd_id])]
			continue
		
		if not check_command_version(cmd_info[1]):
			print(f"Pos 0x{cmd_pos:04X}: Warning: Command {cmd_info[0]} (ID 0x{cmd_id:02X}) is not supported by engine version {get_version_str(config.engine_ver)}")
			print(f"Engine: {config.engine_ver}, Cmd Ver: {cmd_info[1]}")
		
		# parse command parameters
		params = []
		first_reg_type = None
		for par_type in cmd_info[2]:
			if (par_type & ~SCPT_HEX) == SCPT_ILVAR:
				# variable-size parameter
				# The size (2 or 4 bytes) of the parameter depends on destination register.
				if first_reg_type == SCPT_REG_STR:
					par_type = SCPT_STR
				elif first_reg_type == SCPT_REG_LNG:
					par_type = SCPT_LONG | (par_type & SCPT_HEX)
				else:
					par_type = SCPT_INT | (par_type & SCPT_HEX)
			
			if par_type == SCPT_LONG:
				par_data = scene_read_array(scenedata, file_usage, curpos, 0x04)
				par_val = struct.unpack("<I", par_data)[0]
				curpos += 0x04
			else:
				par_val = scene_read_int(scenedata, file_usage, curpos)
				curpos += 0x02
			
			if (par_type & SCPT_MASK) == SCPTM_PTR:
				# pointer parameters: add label for them
				if par_val >= start_ofs and (par_val not in imported_symbols):
					label_list[par_val] = (par_type, 0x00, None)
			if par_type == SCPT_JUMP:
				# add jump destination to list of locations to be processed
				if par_val >= start_ofs:
					remaining_code_locs.append(par_val)
				else:
					print(f"Warning: Found invalid jump to invalid offset 0x{par_val:04X} at offset 0x{cmd_pos:04X}!")
			
			if (first_reg_type is None) and (par_type & SCPT_MASK) == SCPTM_REG:
				# remember first parameter's register type
				if par_type == SCPT_REG_IL:
					if (par_val < 0x400) or (config.engine_ver >= 310):
						first_reg_type = SCPT_REG_INT
					else:
						first_reg_type = SCPT_REG_LNG
				else:
					first_reg_type = par_type
			params += [(par_type, par_val)]
		cmd_list += [(cmd_pos, cmd_id, params)]
		
		if len(cmd_info) >= 4:
			# special handling
			if cmd_info[3] == SC_EXEC_END:
				curpos = None	# stop processing here
			elif cmd_info[3] == SC_EXEC_SPC:
				if cmd_id == 0x13:	# jump table
					# check for previous instruction being "ADDI var, NNN" and set skip_vals to NNN
					skip_vals = 0
					if len(cmd_list) > 1:
						params = cmd_list[-1][2]
						reg_val = params[0][1]	# register ID = value of param[0]
						#print(f"0x{curpos:04X}: {cmd_info} / {cmd_list[-1]}, Register i{reg_val}")
						prev_cmd = cmd_list[-2]
						if prev_cmd[1] == 0x24:	# ADDI command
							params = prev_cmd[2]
							preg_val = params[0][1]	# register ID = value of param[0]
							padd_val = params[1][1]
							#print(f"Previous: {prev_cmd}, Register i{preg_val}, add {padd_val}")
							if reg_val == preg_val and padd_val == +1:
								skip_vals = padd_val

					cmd_pos = curpos
					endpos = len(scenedata)
					params = []
					while curpos < endpos:
						if curpos in label_list:
							break
						ptrval = scene_read_int(scenedata, file_usage, curpos)
						
						# Note: Some tables begin with a "dummy" value.
						# (Most files in Canaan use 0x80..0x8F, but there are also 0x70..0x7F used in a few files.
						#  In Gaogao 2, the value seems to be random offsets inside the file.)
						# This is the case, when there is an "ADDI var, 1" value right before the "JTBL var" command.
						# In this case, we have to just read the value and not dereference it.
						# In all other cases, we probably check the pointer for validity.
						# If the pointer is bad, we want to exit, so that we don't accidentally interpret code as a pointer.
						dst_cmd = 0xFFFF
						if skip_vals > 0:
							skip_vals -= 1
						else:
							# 2nd and later values
							if ptrval < start_ofs:
								ptrval = 0xFFFF	# probably code, finish reading
							elif ptrval + 0x01 < len(scenedata):
								dst_cmd = struct.unpack_from("<H", scenedata, ptrval)[0]
								if dst_cmd >= 0x100:
									ptrval = 0xFFFF	# invalid command - assume bad pointer
							if ptrval + 0x01 >= len(scenedata):
								# remove usage mask (-> assume that we didn't process this value)
								# important for unused code
								file_usage[curpos+0] &= ~0x01
								file_usage[curpos+1] &= ~0x01
								break
						params += [ptrval]
						curpos += 0x02
						
						if dst_cmd < 0x100:
							label_list[ptrval] = (SCPT_JUMP, 0x00, None)
							remaining_code_locs.append(ptrval)
							if ptrval > cmd_pos and ptrval < endpos:
								endpos = ptrval
					cmd_list += [(cmd_pos, -3, params)]
					curpos = None	# stop processing here
	
	# --- parse data sections ---
	MODE_UNKNOWN = 0x00
	MODE_DATA = 0x10
	MODE_STR = 0x11
	
	mode = MODE_UNKNOWN
	curpos = start_ofs
	while True:
		# search for next unparsed section
		while (curpos < len(scenedata)) and ((file_usage[curpos] & 0x0F) != 0x00):
			curpos += 1
		if curpos >= len(scenedata):
			break
		
		endpos = find_next_label(label_list, curpos + 1)
		if endpos < 0:
			endpos = len(scenedata)
		elif endpos > len(scenedata):
			endpos = len(scenedata)
		
		cmd_mode = -1	# default to 1-byte data
		if mode == MODE_UNKNOWN:
			if curpos not in label_list:
				# try to detect data type for unused data
				dtype = guess_data_type(scenedata, curpos, endpos)
				# Note: accept "-1" as dtype to indicate unknown data types that are also labelled
				label_list[curpos] = (dtype, LBLFLG_UNUSED, None)
				
				if scenedata[curpos] == 0x00 and dtype < 0 and (curpos % 2) == 1:
					# assume single-byte padding (improved file name detection a LOT)
					label_list[curpos] = (SCPT_PAD, 0x00, None)
					endpos = curpos + 1
					cmd_mode = -10	# decimal data
			
			if curpos in label_list:
				if label_list[curpos][0] == SCPT_JUMP:
					#mode = MODE_CMD
					print(f"Warning: found unparsed code section at 0x{curpos:04X}!")
				elif label_list[curpos][0] in [SCPT_STR, SCPT_FNAME]:
					mode = MODE_STR
				elif label_list[curpos][0] == SCPT_DATA2:
					mode = MODE_DATA
					cmd_mode = -20	# 2-byte data
				elif label_list[curpos][0] == SCPT_TXTSEL:
					mode = MODE_DATA
					cmd_mode = -21	# 2-byte data, text selection
				elif label_list[curpos][0] == SCPT_FONTDAT:
					mode = MODE_DATA
					endpos = min([curpos + 0x20, endpos])	# font data is usually 0x20 bytes
				elif label_list[curpos][0] == SCPT_86DAT:
					mode = MODE_DATA
					endpos = min([curpos + 0x30 * (9 * 0x02), endpos])	# data is 0x360 bytes
					cmd_mode = -22	# 2-byte data
				elif label_list[curpos][0] == SCPT_89DAT:
					mode = MODE_DATA
					endpos = min([curpos + 0x30 * 6, endpos])	# data is 0x120 bytes
					cmd_mode = -13
				else:
					mode = MODE_DATA
		
		if mode == MODE_STR:
			# terminate strings at '\0'
			if curpos in label_list:
				dtype = label_list[curpos][0]
			else:
				dtype = SCPT_STR
			strsize = get_string_size(scenedata, curpos, endpos, dtype)
			if strsize > 0:
				endpos = curpos + strsize
			str_arr = scene_read_array(scenedata, file_usage, curpos, endpos - curpos)
			if dtype == SCPT_STR:
				cmd_list += get_sjis_str_items(str_arr, curpos)
			else:
				cmd_list += [(curpos, -11, str_arr)]
		elif cmd_mode == -21:
			# menu selection (2-byte words, 5 per entry, terminated with single value 0)
			dend = curpos
			while dend + 2 <= endpos:
				val = struct.unpack_from("<H", scenedata, dend)[0]
				if val == 0:
					dend += 2
					break
				dend += 5 * 0x02
			#print(f"0x{curpos:X} .. 0x{dend:X} .. 0x{endpos:X}")
			if dend > curpos and dend < endpos:
				endpos = dend
			darray = scene_read_array(scenedata, file_usage, curpos, endpos - curpos)
			iterat = struct.iter_unpack("<H", darray)
			cmd_list += [(curpos, cmd_mode, [v[0] for v in iterat])]
		elif cmd_mode in [-2, -20, -22]:
			# do 2-byte word parsing
			darray = scene_read_array(scenedata, file_usage, curpos, endpos - curpos)
			iterat = struct.iter_unpack("<H", darray)
			cmd_list += [(curpos, cmd_mode, [v[0] for v in iterat])]
		else:
			# just include the data as bytes
			cmd_list += [(curpos, cmd_mode, scene_read_array(scenedata, file_usage, curpos, endpos - curpos))]
		mode = MODE_UNKNOWN
		curpos = endpos
	
	if config.engine_ver > 0:
		# set final engine version
		cmd_list[0] = (-9, -9, config.engine_ver)
	
	cmd_list.sort(key=lambda cmd: cmd[0])
	return (cmd_list, file_usage, label_list)

def generate_label_names(label_list: dict) -> None:
	for lbl_pos in label_list:
		(par_type, lbl_flags, lbl_name) = label_list[lbl_pos]
		if not (lbl_name is None or lbl_name == ""):
			continue
		if par_type in [SCPT_DATA1, SCPT_DATA2, SCPT_86DAT, SCPT_89DAT]:
			lbl_prefix = "data"
		elif par_type == SCPT_STR:
			lbl_prefix = "str"
		elif par_type == SCPT_FNAME:
			lbl_prefix = "file"
		elif par_type == SCPT_JUMP:
			lbl_prefix = "loc"
		elif par_type == SCPT_TXTSEL:
			lbl_prefix = "sel"
		elif par_type == SCPT_FONTDAT:
			lbl_prefix = "font"
		elif par_type == SCPT_PAD:
			lbl_prefix = "pad"
		else:
			lbl_prefix = "unk"
		lbl_name = f"{lbl_prefix}_{lbl_pos:04X}"
		label_list[lbl_pos] = (par_type, lbl_flags, lbl_name)
	return

def get_sjis_str_items(str_data: bytes, startpos: int) -> list:
	global necjis
	
	#if not config.inline_sjis_bytes:
	#	return [(startpos, -11, str_data)]	# this line simplifies the output by inlining Shift-JIS data.
	
	# This function splits string data in such a way, that Shift-JIS characters from
	# the "custom font" JIS planes get their own assembly command.
	last_type = None
	new_type = None
	token_data = []
	token_pos = startpos
	new_data = None
	result = []
	sjis_1st = None
	rem_param_bytes = 0
	chrpos = 0
	for (pos, c) in enumerate(str_data):
		new_type = -12
		if type(rem_param_bytes) is dict:
			# meta command
			new_data = bytes([c])
			if c in rem_param_bytes:
				rem_param_bytes = rem_param_bytes[c]
			else:
				rem_param_bytes = 0	# invalid command - assume no parameters
		elif rem_param_bytes > 0:
			# remaining parameter bytes of text commands
			new_data = bytes([c])
			rem_param_bytes -= 1
		elif sjis_1st is not None:
			sjis = (sjis_1st << 8) | (c << 0)
			jis = necjis.sjis2jis(sjis)
			if (jis is not None) and (jis not in necjis.jis_uc_lut):
				# use special "DSJ" instruction for JIS codes we can not convert
				new_type = -25
				new_data = [jis]
			if new_type == -12:
				new_data = bytes([sjis_1st, c])
			sjis_1st = None
			# do NOT set chrpos
		else:
			if c in TEXT_CMD_LIST:
				# text command
				new_data = bytes([c])
				rem_param_bytes = TEXT_CMD_LIST[c]	# text command - get number of parameter bytes
			elif (c >= 0x81 and c <= 0x9F) or (c >= 0xE0 and c <= 0xFC):
				sjis_1st = c
				new_data = None
			else:
				new_data = bytes([c])
			chrpos = pos	# save start position of current character
		
		if new_data is not None:
			if last_type != new_type:
				if len(token_data) > 0:
					result += [(token_pos, last_type, token_data)]
				token_data = new_data
				last_type = new_type
				token_pos = startpos + chrpos
			else:
				token_data += new_data
	if len(token_data) > 0:
		result += [(token_pos, last_type, token_data)]
	return result

def str2asm_ascii(str_data: bytes) -> typing.List[str]:
	# convert binary array to ASM string
	# This outputs a list of "tokens", consisting of either
	#   - a quoted string or
	#   - a raw number (for unprintable/unconvertable character sequences)
	# This does NOT do Shift-JIS conversion.
	res_items = []
	mode = 0
	for c in str_data:
		if c >= 0x20 and c <= 0x7E:
			new_mode = 1
			c = chr(c)
			if c in ['"', '\\']:	# escape some special characters
				c_add = '\\' + c
			else:
				c_add = c
		else:
			new_mode = 0
			c_add = f"0x{c:02X}" if c >= 10 else f"{c}"
		if new_mode == 0 and mode == 0:
			res_items.append(c_add)
		elif new_mode == 0 and mode == 1:
			res_items[-1] += '"'
			res_items.append(c_add)
		elif new_mode == 1 and mode == 0:
			res_items.append('"' + c_add)
		elif new_mode == 1 and mode == 1:
			res_items[-1] += c_add
		mode = new_mode
	if mode == 1:
		res_items[-1] += '"'
	return res_items

def str2asm_sjis(str_data: bytes) -> typing.List[str]:
	global necjis
	
	# convert binary array to ASM string
	# This outputs a list of "tokens", consisting of either
	#   - a quoted string or
	#   - a raw number (for unprintable/unconvertable character sequences)
	# This also takes care of converting Shift-JIS characters to UTF-8 where possible.
	res_chrs = []
	sjis_1st = None
	rem_param_bytes = 0
	for c in str_data:
		if type(rem_param_bytes) is dict:
			# meta command
			res_chrs.append(c)
			if c in rem_param_bytes:
				rem_param_bytes = rem_param_bytes[c]
			else:
				rem_param_bytes = 0	# invalid command - assume no parameters
		elif rem_param_bytes > 0:
			# remaining parameter bytes of text commands
			res_chrs.append(c)	# just print as number
			rem_param_bytes -= 1
		elif sjis_1st is not None:
			# 2nd byte of a 2-byte Shift-JIS character
			sjis_str = necjis.sjis_decode_chr((sjis_1st << 8) | (c << 0))
			if type(sjis_str) is str:
				res_chrs.append(sjis_str)
			else:
				res_chrs.append(sjis_1st)
				res_chrs.append(c)
			sjis_1st = None
		else:
			if c in TEXT_CMD_LIST:
				# handle text command
				res_chrs.append(c)
				rem_param_bytes = TEXT_CMD_LIST[c]	# text command - get number of parameter bytes
			elif (c >= 0x81 and c <= 0x9F) or (c >= 0xE0 and c <= 0xFC):
				sjis_1st = c
			elif c >= 0xA1 and c <= 0xDF:
				# special halfwidth Katakana codes (used by System-98 v1)
				sjis_str = necjis.sjis_decode_chr(0x859F + (c - 0xA1))
				if type(sjis_str) is str:
					res_chrs.append(sjis_str)
				else:
					res_chrs.append(c)
			elif c >= 0x20 and c <= 0x7E:
				res_chrs.append(chr(c))	# ASCII character - print as actual text character
			else:
				res_chrs.append(c)	# control code - print byte as number
	
	res_items = []
	mode = 0
	for c in res_chrs:
		if type(c) is str:
			new_mode = 1
			if c in ['"', '\\']:	# escape some special characters
				c_add = '\\' + c
			else:
				c_add = c
		else:
			new_mode = 0
			c_add = f"0x{c:02X}" if c >= 10 else f"{c}"
		if new_mode == 0 and mode == 0:
			res_items.append(c_add)
		elif new_mode == 0 and mode == 1:
			res_items[-1] += '"'
			res_items.append(c_add)
		elif new_mode == 1 and mode == 0:
			res_items.append('"' + c_add)
		elif new_mode == 1 and mode == 1:
			res_items[-1] += c_add
		mode = new_mode
	if mode == 1:
		res_items[-1] += '"'
	return res_items

def gen_string_groups(data_items: typing.List[str]) -> typing.List[int]:
	# generate "groups" of string items to be placed on the same line
	# splits after 0D (new line) and 01 (wait for key press)
	chr_mode = None
	new_chr_mode = None
	rem_param_bytes = 0
	result = []
	for (idx, itm) in enumerate(data_items):
		if itm.startswith('"'):
			chr_id = 0x22
		else:
			chr_id = int(itm, 0)
		# ignore first character (disk drive in file names)
		# but split at 0D/01 -> text
		if type(rem_param_bytes) is dict:
			if chr_id in rem_param_bytes:
				rem_param_bytes = rem_param_bytes[chr_id]
			else:
				rem_param_bytes = 0	# invalid command - assume no parameters
		elif rem_param_bytes > 0:
			rem_param_bytes -= 1
		elif (idx > 0) and (chr_id in [0x01, 0x0A, 0x0D]):
			new_chr_mode = 1
		elif chr_id != 0x00:	# don't split at terminator characters
			new_chr_mode = 0
			# handle special character codes
			if chr_id in TEXT_CMD_LIST:
				rem_param_bytes = TEXT_CMD_LIST[chr_id]

		if new_chr_mode == 0 and chr_mode == 1:
			result.append(idx)
		chr_mode = new_chr_mode
	result.append(len(data_items))
	return result

def get_filename(params: list) -> typing.Union[str, None]:
	if params[0] > 9:	# first byte is the disk number
		return None
	dataarr = params[1:]
	strend = dataarr.find(0x00)
	if strend >= 0:
		dataarr = dataarr[:strend]
	try:
		return dataarr.decode("shift-jis")
	except:
		return None

def get_version_str(version_int: typing.Union[int, None]) -> str:
	if version_int is None:
		return "any"
	else:
		ver_maj = version_int // 100
		ver_min = version_int % 100
		return f"{ver_maj}.{ver_min:02}"

def write_asm(cmd_list, label_list, include_list, fn_out: str) -> None:
	cmd_pos_map = {}
	for (cid, cmd) in enumerate(cmd_list):
		(cmd_pos, cmd_id, params) = cmd
		cmd_pos_map[cmd_pos] = cid
	
	with open(fn_out, "wt", encoding="utf-8") as f:
		last_mode = None
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
				if label_list[cmd_pos][1] & LBLFLG_UNUSED:
					f.write("\t; unused")
				f.write("\n")
			
			if cmd_id < 0:
				# output raw data (byte arrays, word arrays, strings, ...)
				group_size = 8
				group_list = None
				show_idx = False
				comment = None
				if cmd_pos in label_list:
					lbl_flags = label_list[cmd_pos][1]
				if cmd_id == -9:
					cmd_name = "VER"	# engine version
					data_strs = [get_version_str(params)]
				elif cmd_id == -8:
					cmd_name = "ORG"	# origin offset
					data_strs = [f"0x{params:04X}"]
				elif cmd_id == -7:
					cmd_name = "DESC"	# module description
					data_strs = str2asm_sjis(params)
					group_list = gen_string_groups(data_strs)	# intelligent line splitting
				elif cmd_id == -6:
					cmd_name = "INCLUDE"	# include file
					data_strs = str2asm_ascii(params.encode("utf-8"))
				elif cmd_id == -3:
					cmd_name = "DW"
					group_size = 1
					show_idx = True
					data_strs = []
					for ptr in params:
						if ptr in label_list:
							data_strs.append(label_list[ptr][2])
						else:
							data_strs.append(f"0x{ptr:04X}")
					last_mode = -1
				elif cmd_id == -25:
					cmd_name = "DSJ"	# Data: Shift-JIS
					data_strs = [f"0x{val:04X}" for val in params]
					chrs = [JISCHR_COMMENTS[val] for val in params if val in JISCHR_COMMENTS]
					if len(chrs) > 0:
						comment = ", ".join(chrs)
				elif cmd_id == -22:
					cmd_name = "DW"	# Data: word (hex)
					group_size = 9
					data_strs = []
					for (idx, val) in enumerate(params):
						line_idx = idx % group_size
						if line_idx == 0:
							data_str = f"{val}"
						elif line_idx <= 2:
							data_str = f"{val:3}"
						else:
							data_str = f"0x{val:01X}"
						data_strs += [data_str]
				elif cmd_id == -21:
					cmd_name = "DW"	# Data: word (decimal)
					data_strs = [f"{val}" for val in params]
					group_size = 5
				elif cmd_id == -20:
					cmd_name = "DW"	# Data: word (decimal)
					data_strs = [f"{val}" for val in params]
				elif cmd_id == -2:
					cmd_name = "DW"	# Data: word (hex)
					data_strs = [f"0x{val:04X}" for val in params]
				elif cmd_id == -12:
					cmd_name = "DS"	# Data: Shift-JIS string
					data_strs = str2asm_sjis(params)
					group_list = gen_string_groups(data_strs)	# intelligent line splitting
				elif cmd_id == -11:
					cmd_name = "DB"	# Data: ASCII string
					data_strs = str2asm_ascii(params)
					group_list = gen_string_groups(data_strs)	# intelligent line splitting
				elif cmd_id == -10:
					cmd_name = "DB"	# Data: byte (decimal)
					data_strs = [f"{val}" for val in params]
				else:
					if cmd_id == -13:
						group_size = 6
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
							if label_list[par_val][0] == SCPT_FNAME:
								# add comment with file name
								try:
									dcmd = cmd_list[cmd_pos_map[par_val]]
									comment = get_filename(dcmd[2])
								except:
									pass	# catch invalid offsets
						else:
							data_str = f"0x{par_val:04X}"
					elif (par_type & SCPT_MASK) == SCPTM_REG:
						if par_type == SCPT_REG_IL:
							# int/long register (depends on ID)
							if (par_val < 0x400) or (config.engine_ver >= 310):
								par_type = SCPT_REG_INT
							else:
								par_type = SCPT_REG_LNG
								par_val -= 0x400
						# output register names
						if par_type == SCPT_REG_INT:
							data_str = f"i{par_val}"
						elif par_type == SCPT_REG_LNG:
							data_str = f"l{par_val}"
						elif par_type == SCPT_REG_STR:
							data_str = f"s{par_val}"
					elif (par_type & SCPT_MASK) == SCPTM_VAL:
						if (par_type & SCPT_HEX):
							if (par_type & ~SCPT_HEX) == SCPT_BYTE:
								digits = 2
							elif (par_type & ~SCPT_HEX) == SCPT_INT:
								digits = 4
							elif (par_type & ~SCPT_HEX) == SCPT_LONG:
								digits = 8
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
				
				if len(cmd_info) >= 4:
					if cmd_info[3] == SC_EXEC_END:
						f.write("\n")
						last_mode = None
					elif cmd_info[3] == SC_EXEC_SPC:
						if cmd_id == 0x13:
							last_mode = 1	# expect data
	return


def write_symbols(label_list, fn_out: str, asm_name: str) -> None:
	asm_name = os.path.basename(asm_name)
	
	with open(fn_out, "wt", encoding="utf-8") as f:
		f.write(f"; Symbols for {asm_name}\n")
		
		for ptr in sorted(label_list):
			lbl = label_list[ptr]
			f.write(f"{lbl[2]} = 0x{ptr:04X}\n")
	return


def find_next_token(line: str, startpos: int) -> int:
	pos = startpos
	while pos < len(line) and line[pos].isspace():
		pos += 1
	return pos

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

def parse_include(lines: typing.List[str], asm_filename: str) -> typing.Tuple[list, list]:
	label_list = {}	# dict{ file offset: (label type, flags, label name) }
	
	for (lid, line) in enumerate(lines):
		line = line.rstrip()
		lstr = line.lstrip()
		if len(lstr) == 0 or lstr.startswith(';'):
			continue	# empty line or comment
		
		startpos = len(line) - len(lstr)
		if startpos > 0:
			continue	# ignore command lines
		else: #if startpos == 0:
			# label
			pos = line.find(':')
			if pos >= 0:
				continue	# ignore labels
		
		(_, lbl_name, pos) = get_token_name(line, startpos)
		pos = find_next_token(line, pos)
		if pos >= len(line) or line[pos] == ';':
			continue
		if line[pos] != '=':
			print(f"Parse error in {asm_filename}:{1+lid}: '=' missing. Line format has to be \"symbol = value\"")
			return None
		pos = find_next_token(line, pos + 1)
		
		res = get_token_int(line, pos)
		if res is None:
			print(f"Parse error in {asm_filename}:{1+lid}: Bad integer. Line format has to be \"symbol = value\"")
			return None
		(ttype, tdata, endpos) = res
		label_list[tdata] = (SCPTM_PTR, 0x00, lbl_name)
		pos = find_next_token(line, endpos)	# skip spaces
		if pos < len(line) and line[pos] != ';':	# comment
			print(f"Parse error in {asm_filename}:{1+lid}: Expected line end position {1+pos}")
			return None
	
	return label_list

def load_parse_inc(fn_in: str) -> tuple:
	try:
		with open(fn_in, "rt", encoding="utf-8") as f:
			asm_lines = f.readlines()
	except IOError:
		print(f"Error loading {fn_in}")
		return 1
	ret = parse_include(asm_lines, fn_in)
	if ret is None:
		return 2
	return ret


def detect_version(scenedata: bytes) -> float:
	global config
	
	has_comment_block = False
	if len(scenedata) > MOD_DESC_LEN:
		# check that the last 0x10 bytes of the (potential) comment are all 00s
		if scenedata[MOD_DESC_LEN-0x10 : MOD_DESC_LEN] == (b"\x00" * 0x10):
			has_comment_block = True	# System-98 v1..v3 comment block (unencrypted, 00 padded)
		elif scenedata[MOD_DESC_LEN-0x10 : MOD_DESC_LEN] == (b"\x00\xFE" * 0x08):
			has_comment_block = True	# v4 comment block (padded with encrypted FF bytes)
	
	start_ofs = MOD_DESC_LEN if has_comment_block else 0x00
	encryption_type = 0
	if scenedata[start_ofs + 0x01] == 0x00:
		encryption_type = 0
	elif scenedata[start_ofs + 0x01] == 0x01:
		encryption_type = 1	# System-98 PC-98 encryption (XOR 0x01)
	elif scenedata[start_ofs + 0x01] == 0xFF:
		encryption_type = 2	# four-nine Windows encryption (d[0/2/4/...] DEC 1, d[1/3/5/...] INC 1)
	else:
		print("Unable to detect encryption type!")
		return 0
	
	if config.unscrambled:
		if encryption_type != 0:
			print("Detected encryption when file should be unencrypted!")
			return 0
		if has_comment_block:
			return -3.1	# version 3.10 (unsure)
		else:
			return 4.0
	else:
		if encryption_type == 0:
			print("File seems to be unencrypted - please decode using \"--unscrambled\".")
			return 0
		if has_comment_block:
			if encryption_type != 1:
				print("Detected encryption type does not match engine version!")
				return 0
			return -3.1	# version 3.10 (unsure)
		else:
			if encryption_type != 2:
				print("Detected encryption type does not match engine version!")
				return 0
			return 4.0

def decrypt_scene_data(scenedata: bytes) -> bytes:
	# Note that System-98 skips the module description and only decrypts from offset 0x100 on.
	enc_data = scenedata[config.desc_len:]
	if config.enc_type == 1:
		# XOR all bytes with 0x01
		decdata = bytearray([x ^ 0x01 for x in enc_data])
	elif config.enc_type == 2:
		# for each set of 2 bytes
		#  - decrement byte [0] by 1
		#  - increment byte [1] by 1
		decdata = bytearray(enc_data)
		if (len(decdata) % 2) != 0:
			decdata += b'\x00'	# make size a multiple of 2 for easier processing
		for pos in range(0, len(decdata), 2):
			decdata[pos + 0] = (decdata[pos + 0] - 1) & 0xFF
			decdata[pos + 1] = (decdata[pos + 1] + 1) & 0xFF
		decdata = decdata[: len(enc_data)]
	return scenedata[:config.desc_len] + bytes(decdata)

def decompile_scene(fn_in: str, fn_out: str, fn_sym_out: str, fns_include: typing.List[str]) -> int:
	global config
	global SCENE_CMD_LIST
	
	folder_out = os.path.dirname(fn_out)
	inc_sym_list = {}
	inc_files = []
	for fn_inc in fns_include:
		ret = load_parse_inc(fn_inc)
		if type(ret) is int:
			return ret
		inc_sym_list.update(ret)
		inc_files.append(os.path.relpath(fn_inc, folder_out))
	
	try:
		scn_data = load_scene_binary(fn_in)
	except IOError:
		print(f"Error loading {fn_in}")
		return 1
	
	if config.engine_ver == 0:
		config.engine_ver = detect_version(scn_data)
		if config.engine_ver == 0:
			print("Unable to detect engine version!")
			return 1
		if config.engine_ver > 0:
			print(f"Detected engine version: {config.engine_ver:.1f}")
		elif config.engine_ver == -3.1:
			print(f"Detected engine version: 1.0 .. 3.1")
	
	engine_ver = abs(config.engine_ver)
	if engine_ver >= 1.0 and engine_ver < 4.0:
		config.desc_len = MOD_DESC_LEN
		config.enc_type = 1
		SCENE_CMD_LIST = SCENE_CMD_LIST_PC98
	else:
		# version 4 has no comment block
		if config.base_ofs == 0:
			config.desc_len = 0x00
		else:
			config.desc_len = MOD_DESC_LEN	# ... except that the sub-module does!
		config.enc_type = 2
		SCENE_CMD_LIST = SCENE_CMD_LIST_WIN
	config.engine_ver = int(config.engine_ver * 100)	# the parsing code assumes 100 = v1.0
	
	if not config.unscrambled:
		# remove the "encryption"
		scn_data = decrypt_scene_data(scn_data)
	
	(cmd_list, file_usage, label_list) = parse_scene_binary(scn_data, {})
	generate_label_names(label_list)
	
	if fn_sym_out is not None:
		try:
			write_symbols(label_list, fn_sym_out, fn_out)
		except IOError:
			print(f"Error writing {fn_sym_out}")
			return 1
	# inject include statements
	inc_cmd_id = None
	for (cmd_id, cmd) in enumerate(cmd_list):
		if cmd[1] == -6:
			inc_cmd_id = cmd_id
	if inc_cmd_id is not None:
		cmd = cmd_list[inc_cmd_id]
		inc_cmds = []
		for inc_file in inc_files:
			inc_cmds.append((cmd[0], cmd[1], inc_file))
		cmd_list = cmd_list[:inc_cmd_id] + inc_cmds + cmd_list[inc_cmd_id+1:]
	
	try:
		write_asm(cmd_list, inc_sym_list | label_list, inc_files, fn_out)
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
	
	print("four-nine/Izuho Saruta System-98 Scenario Decompiler")
	aparse = argparse.ArgumentParser()
	aparse.add_argument("-V", "--engine-ver", type=float, help="set System-98 engine version, can be [0, 1.0, 1.1, 3.0, 3.1, 4], 0 = auto, 4 = Windows version", default=0)
	aparse.add_argument("-b", "--base-ofs", type=auto_int, help="set base/load offset of the scenario file", default=0x0000)
	# for LILITH/DISK_A/li_sub.s, use "-b 0x4000"
	aparse.add_argument("-f", "--font-file", type=str, help="description file for custom font characters")
	aparse.add_argument("-e", "--use-emojis", action="store_true", help="decode custom font into emojis")
	aparse.add_argument("-u", "--unscrambled", action="store_true", help="assume descrambled input data")
	aparse.add_argument("-s", "--symbol-export", type=str, help="export label offsets to include-file")
	aparse.add_argument("-i", "--include", action="append", type=str, help="file with symbols/constants to be included", default=[])
	aparse.add_argument("in_file", help="input scenario file (.S)")
	aparse.add_argument("out_file", help="output assembly file (.ASM)")
	
	config = aparse.parse_args(argv[1:])
	
	necjis.load_from_pickle(os.path.join(MODULE_PATH, "NEC-C-6226-lut.pkl"))
	if config.font_file:
		load_additional_font_table(config.font_file)
	return decompile_scene(config.in_file, config.out_file, config.symbol_export, config.include)

if __name__ == "__main__":
	sys.exit(main(sys.argv))
# vim: set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab:
