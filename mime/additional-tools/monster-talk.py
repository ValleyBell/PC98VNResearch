#!/usr/bin/env python3
# MIME "Monster Talk" script analyser
# Written by Valley Bell, 2024-11-20
import sys
import typing

if len(sys.argv) < 3:
	print(f"Usage: {sys.argv[0]} BATTLE_2.asm MonsterGroups.tsv out.tsv/out.md")
	print("Please note that this tool requires a decompiled script file,")
	print("as well as the output of monster-group-list.py.")
	sys.exit(1)

OUTPUT_LABELS = False	# for debugging

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

def get_token_str(line: str, startpos: int) -> typing.Union[None, str, int]:
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
	return (result, pos)	# return parsed string without quotes

MONSTER_GROUPS = []
with open(sys.argv[2], "rt", encoding="utf-8") as f:
	for (lid, line) in enumerate(f):
		ltrim = line.lstrip()
		if len(ltrim) == 0 or ltrim.startswith('#') or ltrim.startswith(';'):
			continue
		ltrim = line.rstrip('\n')
		cols = ltrim.split('\t')
		if len(cols) < 2:
			print(f"Line {lid} invalid: {ltrim}")
			break
		
		floor_id = int(cols[0].rstrip("F"))
		while floor_id >= len(MONSTER_GROUPS):
			MONSTER_GROUPS.append([])
		mg_id = int(cols[1])
		while mg_id >= len(MONSTER_GROUPS[floor_id]):
			MONSTER_GROUPS[floor_id].append(None)
		
		mgrp = []
		for m_id in range(4):
			col_id = 2 + 2 * m_id
			if col_id >= len(cols):
				break
			mgrp.append(cols[col_id])
		MONSTER_GROUPS[floor_id][mg_id] = mgrp


with open(sys.argv[1], "rt", encoding="utf-8") as f:
	lines = f.readlines()

lbl_search0 = ("loc_0038", 0)
lbl_search1 = (None, 0)
floor_lbls = {}	# labels for "per-floor" coordinate check
mgrp_lbls = {}
event_list = []
talk_lbls = {}
cur_floor = None
cur_lbl = None
cur_evt = None
reg_grp = None
mode = -1
for (lid, line) in enumerate(lines):
	line = line.rstrip()
	cols = line.split('\t')
	if cols[0].endswith(":"):
		lbl_name = cols[0].rstrip(':')
		if lbl_name == lbl_search0[0]:
			mode = lbl_search0[1]
			if mode < 0:
				#print(f"Stopping at label {lbl_name}")
				break
			cur_floor = None
			cur_lbl = None
			cur_evt = None
		elif lbl_name == lbl_search1[0]:
			mode = lbl_search1[1]
			reg_grp = None
			continue
		elif lbl_name in floor_lbls:
			mode = 1
			cur_floor = floor_lbls[lbl_name]
			cur_lbl = None
			cur_evt = None
			reg_grp = None
			continue
		elif lbl_name in mgrp_lbls:
			cur_lbl = lbl_name
			(mode, cur_evt) = mgrp_lbls[lbl_name]
			continue
		elif mode == 0:
			mode = -1
	if len(cols) < 2:
		continue
	
	if cols[1] == "JEQ":
		if (len(cols) < 2) or (not cols[2].startswith("r")):
			continue
		
		comma1 = cols[2].find(',')
		comma2 = cols[2].find(',', comma1 + 1)
		reg_id = int(cols[2][1 : comma1])
		cmp_val = int(cols[2][comma1+1 : comma2])
		lbl_name = cols[2][comma2+1:].strip()
		
		if mode == 0:	# "JEQ r15, xx" -> list of checks for floors
			floor_lbls[lbl_name] = cmp_val
		elif mode == 1:
			if reg_id == 387:
				reg_grp = cmp_val
				mgrp_lbls[lbl_name] = (10, len(event_list))
				event_list.append({
					"floor": cur_floor,
					"mgroup": (cmp_val),
					"check_label": lbl_name,
					"text": "",
				})
				if lbl_name not in talk_lbls:
					talk_lbls[lbl_name] = {"text": ""}
		#elif mode == 10:
		#	mgrp_lbls[lbl_name] = (10, cur_evt)
		#	mode = -1
	elif cols[1] == "JP":
		lbl_name = cols[2].strip()
		if mode == 0:
			lbl_search0 = (lbl_name, -1)	# "end" label
			mode = -1
		elif mode == 1:
			lbl_search1 = (lbl_name, 1)	# take note of label with next comparision
		elif mode == 10:
			mode = -1
	elif cols[1] == "CALL":
		lbl_name = cols[2].strip()
		if mode == 10:
			talk_lbls[cur_lbl]["text"] += f"<{lbl_name}>"
	elif cols[1] == "PRINT2R" or cols[1] == "PRINT2":
		if mode == 10:
			comma1 = cols[2].find(',')
			disp_pos = cols[2][1 : comma1]
			param = cols[2][comma1+1:].strip()
			
			(text, pos) = get_token_str(param, 0)
			text = text.replace("“\uF87F", "“")
			text = text.replace("”\uF87F", "”")
			text = text.replace("-\n", "")
			text = text.replace(" \n", " ")
			text = text.replace("\n", " ")	# replace newlines with spaces
			talk_lbls[cur_lbl]["text"] += text
	elif cols[1] == "ADDI":
		comma1 = cols[2].find(',')
		reg_id = int(cols[2][1 : comma1])
		move_val = int(cols[2][comma1+1:])
		
		if mode == 10 and reg_id == 336:
			talk_lbls[cur_lbl]["text"] += "\n"

if sys.argv[3].lower().endswith(".tsv"):
	with open(sys.argv[3], "wt", encoding="utf-8") as f:
		if OUTPUT_LABELS:
			f.write("#floor\tmgrp\tchk_label\ttext\n")
		else:
			f.write("#floor\tmgrp\ttext\n")
		for ev_data in event_list:
			floor = ev_data["floor"]
			mgrp = ev_data["mgroup"]
			
			act_lbl = ev_data["check_label"]
			text = None
			if act_lbl in talk_lbls:
				text = talk_lbls[act_lbl]["text"]
			
			if OUTPUT_LABELS:
				f.write(f"{floor}F\t{mgrp}\t{ev_data['check_label']}\t" \
					f"{text}\n")
			else:
				f.write(f"{floor}F\t{mgrp}\t{text}\n")
else:
	with open(sys.argv[3], "wt", encoding="utf-8") as f:
		last_floor = None
		for ev_data in event_list:
			floor = ev_data["floor"]
			mgrp = ev_data["mgroup"]
			if floor != last_floor:
				last_floor = floor
				f.write(f"\n## {floor}F\n\n")
			
			if floor < len(MONSTER_GROUPS) and len(MONSTER_GROUPS[floor]):
				monster_list = ", ".join(MONSTER_GROUPS[floor][mgrp])
			else:
				monster_list = "(floor {floor}F, monster group {mgrp})"
			
			act_lbl = ev_data["check_label"]
			text = None
			if act_lbl in talk_lbls:
				text = talk_lbls[act_lbl]["text"]
			
			f.write(f"- group {mgrp}: {monster_list}\n")
			for line in text.split('\n'):
				f.write(f"  - {line}\n")
