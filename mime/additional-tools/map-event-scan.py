#!/usr/bin/env python3
# MIME "Dungeon Map Event" script analyser
# Written by Valley Bell, 2024-11-10
import sys
import typing

if len(sys.argv) < 3:
	print(f"Usage: {sys.argv[0]} Z0001.asm out.txt")
	print("Please note that this tool requires a decompiled script file.")
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

with open(sys.argv[1], "rt", encoding="utf-8") as f:
	lines = f.readlines()

lbl_search0 = ("loc_2349", 0)	# end at uloc_463C
lbl_search1 = (None, 0)
floor_lbls = {}	# labels for "per-floor" coordinate check
item_lbls = {}
event_list = []
action_lbls = {}
cur_floor = None
cur_lbl = None
cur_evt = None
reg_x = None
reg_y = None
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
			reg_x = None
			reg_y = None
			continue
		elif lbl_name in floor_lbls:
			mode = 1
			cur_floor = floor_lbls[lbl_name]
			cur_lbl = None
			cur_evt = None
			reg_x = None
			reg_y = None
			continue
		elif lbl_name in item_lbls:
			cur_lbl = lbl_name
			(mode, cur_evt) = item_lbls[lbl_name]
			continue
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
			if reg_id == 13:
				reg_x = cmp_val
			elif reg_id == 14:
				reg_y = cmp_val
			if (reg_x is not None) and (reg_y is not None):
				item_lbls[lbl_name] = (10, len(event_list))
				event_list.append({
					"coord": (cur_floor, reg_x, reg_y),
					"check_label": lbl_name,
					"act_label": lbl_name,
					"btst": "",
				})
				if lbl_name not in action_lbls:
					action_lbls[lbl_name] = {}
				mode = -1
		elif mode == 10:
			item_lbls[lbl_name] = (10, cur_evt)
			action_lbls[cur_lbl] = {"jp": lbl_name}
			mode = -1
	elif cols[1] == "JP":
		lbl_name = cols[2].strip()
		if mode == 0:
			lbl_search0 = (lbl_name, 0)	# next "floor" check
			mode = -1
		elif mode == 1:
			lbl_search1 = (lbl_name, 1)	# take note of label with next comparision
		elif mode == 10:
			item_lbls[lbl_name] = (10, cur_evt)
			action_lbls[cur_lbl] = {"jp": lbl_name}
			mode = -1
		elif mode == 11:
			item_lbls[lbl_name] = (10, cur_evt)	# take next jump, back to mode 10
			action_lbls[cur_lbl] = {"jp": lbl_name}
			mode = -1
	elif cols[1] == "BTST":
		comma1 = cols[2].find(',')
		reg_id = int(cols[2][1 : comma1])
		bit_val = int(cols[2][comma1+1:])
		
		if mode == 10:
			event_list[cur_evt]["btst"] = f"r{reg_id} bit {bit_val}"
			mode = 11	# the next JP command should be followed
	elif cols[1] == "SCNSET":
		(text, pos) = get_token_str(cols[2], 0)
		if mode == 10:
			action_lbls[cur_lbl] = {"scenario": text}
			mode = -1

with open(sys.argv[2], "wt", encoding="utf-8") as f:
	if OUTPUT_LABELS:
		f.write("#floor\tcoord\tchk_label\tact_label\tcheck\tscenario\n")
	else:
		f.write("#floor\tcoord\tcheck\tscenario\n")
	for ev_data in event_list:
		(floor, x, y) = ev_data["coord"]
		
		act_lbl = ev_data["act_label"]
		while (act_lbl in action_lbls) and "jp" in action_lbls[act_lbl]:
			act_lbl = action_lbls[act_lbl]["jp"]
		
		scn = None
		if act_lbl in action_lbls:
			scn = action_lbls[act_lbl]["scenario"]
		if OUTPUT_LABELS:
			f.write(f"{floor}F\t{x},{y}\t{ev_data['check_label']}\t" \
				f"{act_lbl}\t{ev_data['btst']}\t{scn}\n")
		else:
			f.write(f"{floor}F\t{x},{y}\t{ev_data['btst']}\t{scn}\n")
