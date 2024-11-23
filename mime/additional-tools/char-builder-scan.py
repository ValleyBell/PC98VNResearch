#!/usr/bin/env python3
# MIME "Character Builder" script analyser
# Written by Valley Bell, 2024-11-09
import sys
import typing

if len(sys.argv) < 3:
	print(f"Usage: {sys.argv[0]} AE00_.asm out.txt")
	print("Please note that this tool requires a decompiled script file.")
	sys.exit(1)

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

LOOK_DIRS = [
	"north",
	"west",
	"south",
	"east",
]


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

# item_lbls = {
#		label_name: [(x, y), [talk], [selections], [{actions}]]
#	}
lbl_search = ("start_0000", 0)
item_lbls = {}
lbl_select = {}
cur_item = None
cur_sel = None
reg_x = None
reg_y = None
mode = -1
for (lid, line) in enumerate(lines):
	line = line.rstrip()
	cols = line.split('\t')
	if cols[0].endswith(":"):
		lbl_name = cols[0].rstrip(':')
		if lbl_name == lbl_search[0]:
			mode = lbl_search[1]
			if mode < 0:
				#print(f"Stopping at label {lbl_name}")
				break
			continue
		elif lbl_name in item_lbls:
			mode = 10
			cur_item = lbl_name
			cur_sel = 0
			continue
		elif lbl_name in lbl_select:
			mode = 12
			cur_sel = lbl_select[lbl_name]
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
		
		if mode == 0:	# "JEQ r13, xx" -> start map square checking
			if reg_id == 13 or reg_id == 14:
				reg_x = None
				reg_y = None
				mode = 1
		if mode == 1:
			if reg_id == 13:
				reg_x = cmp_val
			elif reg_id == 14:
				reg_y = cmp_val
			if (reg_x is not None) and (reg_y is not None):
				item_lbls[lbl_name] = [(reg_x, reg_y), [], [], [{}]]
				mode = -1
		elif mode == 11:
			if reg_id == 8:
				lbl_select[lbl_name] = cmp_val
	elif cols[1] == "JP":
		lbl_name = cols[2].strip()
		if mode == 0:
			lbl_search = (lbl_name, -1)	# "end" label
		elif mode == 1:
			lbl_search = (lbl_name, 0)	# take note of label with next comparision
		elif mode >= 11 and mode <= 12:
			mode = -1
	elif cols[1] == "TALKDGN":
		if mode == 10:
			(text, pos) = get_token_str(cols[2], 0)
			text = text.replace("-\n", "")
			text = text.replace("\n", " ")	# replace newlines with spaces
			item_lbls[cur_item][1].append(text)
	elif cols[1] == "MENUSEL":
		if mode == 10:
			comma1 = cols[2].find(',')
			comma2 = cols[2].find(',', comma1 + 1)
			sel_count = int(cols[2][comma1+1 : comma2])
			params = cols[2][comma2+1:].strip()
			
			pos = 1
			lbl_select = {}
			for sel_id in range(sel_count):
				(text, pos) = get_token_str(params, pos)
				item_lbls[cur_item][2].append(text)
				item_lbls[cur_item][3].append({})
				pos += 1
				while (pos < len(params)) and params[pos].isspace():
					pos += 1
			
			mode = 11
	elif cols[1] == "MOVI":
		comma1 = cols[2].find(',')
		reg_id = int(cols[2][1 : comma1])
		move_val = int(cols[2][comma1+1:])
		
		if mode >= 10 and mode <= 12:
			if reg_id == 12:
				item_lbls[cur_item][3][cur_sel]["Dir"] = LOOK_DIRS[move_val]
			elif reg_id == 13:
				item_lbls[cur_item][3][cur_sel]["X"] = f"= {move_val}"
			elif reg_id == 14:
				item_lbls[cur_item][3][cur_sel]["Y"] = f"= {move_val}"
			elif reg_id == 4343:
				item_lbls[cur_item][3][cur_sel]["HP"] = f"= {move_val}"
			elif reg_id == 4345:
				item_lbls[cur_item][3][cur_sel]["MP"] = f"= {move_val}"
			elif reg_id == 4346:
				item_lbls[cur_item][3][cur_sel]["Attack"] = f"= {move_val}"
			elif reg_id == 4347:
				item_lbls[cur_item][3][cur_sel]["Defense"] = f"= {move_val}"
			elif reg_id == 4348:
				item_lbls[cur_item][3][cur_sel]["Intelligence"] = f"= {move_val}"
			elif reg_id == 4349:
				item_lbls[cur_item][3][cur_sel]["Agility"] = f"= {move_val}"
			elif reg_id >= 4340 and reg_id <= 4360:
				print(f"Adding to unhandled register r{reg_id}!")
	elif cols[1] in ["ADDI", "SUBI"]:
		comma1 = cols[2].find(',')
		reg_id = int(cols[2][1 : comma1])
		add_val = int(cols[2][comma1+1:])
		if cols[1] == "SUBI":
			add_val *= -1
		
		if mode >= 10 and mode <= 12:
			if reg_id == 12:
				item_lbls[cur_item][3][cur_sel]["Dir"] = f"{add_val:+}"
			elif reg_id == 13:
				item_lbls[cur_item][3][cur_sel]["X"] = f"{add_val:+}"
			elif reg_id == 14:
				item_lbls[cur_item][3][cur_sel]["Y"] = f"{add_val:+}"
			elif reg_id == 4343:
				item_lbls[cur_item][3][cur_sel]["HP"] = f"{add_val:+}"
			elif reg_id == 4345:
				item_lbls[cur_item][3][cur_sel]["MP"] = f"{add_val:+}"
			elif reg_id == 4346:
				item_lbls[cur_item][3][cur_sel]["Attack"] = f"{add_val:+}"
			elif reg_id == 4347:
				item_lbls[cur_item][3][cur_sel]["Defense"] = f"{add_val:+}"
			elif reg_id == 4348:
				item_lbls[cur_item][3][cur_sel]["Intelligence"] = f"{add_val:+}"
			elif reg_id == 4349:
				item_lbls[cur_item][3][cur_sel]["Agility"] = f"{add_val:+}"
			elif reg_id >= 4340 and reg_id <= 4360:
				print(f"Adding to unhandled register r{reg_id}!")

with open(sys.argv[2], "wt", encoding="utf-8") as f:
	for (il, data) in item_lbls.items():
		(x, y) = data[0]
		talk = data[1]
		selections = data[2]
		actions = data[3]
		
		f.write(f"{x},{y}: {il}\n")
		for t in talk:
			f.write(f"\t{t}\n")
		
		for sId in range(len(selections)):
			sel_text = selections[sId].strip()
			act_list = []
			for act in actions[0].items():	# actions for all selections
				act_list.append(f"{act[0]} {act[1]}")
			for act in actions[1+sId].items():	# actions for specific selection
				act_list.append(f"{act[0]} {act[1]}")
			act_text = ", ".join(act_list)
			f.write(f"\t{1+sId}. {sel_text} -> {act_text}\n")
