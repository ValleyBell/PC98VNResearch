#!/usr/bin/env python3
# MIME "Treasure Chest" script analyser
# Written by Valley Bell, 2024-11-11
import sys
import typing

"""
start_0000:
	JEQ	r15, 0, loc_005E	; floor 0
	JEQ	r15, 1, loc_0269	; floor 1
	; ...

loc_005E:
	JEQ	r13, 0, loc_0068	; X=0 - check Y
	JP	loc_006F		; check next location
loc_0068:
	JEQ	r14, 2, loc_013E	; Y=2 - handle chest at 0,2

loc_006F:
	JEQ	r13, 0, loc_0079	; X=0 - check Y
	JP	loc_0080		; check next location
loc_0079:
	JEQ	r14, 14, loc_0155	; Y=14 - handle chest at 0,14
	; ...

loc_013E:
	MOVI	r375, 272		; item ID 272
	CALL	sub_0E44		; do "open chest?" questino
	JEQ	r55, 0, loc_16C4	; didn't open - return
	BCLR	r254, 0			; clear bit to mark as "got treasure"
	JP	loc_16C4

"""

if len(sys.argv) < 3:
	print(f"Usage: {sys.argv[0]} SEL_EV2.asm Z1010.tsv out.tsv")
	print("Please note that this tool requires a decompiled script file.")
	sys.exit(1)

OUTPUT_LABELS = False	# for debugging

ITEM_LIST = []
with open(sys.argv[2], "rt", encoding="utf-8") as f:
	result = []
	for (lid, line) in enumerate(f):
		ltrim = line.lstrip()
		if len(ltrim) == 0 or ltrim.startswith('#') or ltrim.startswith(';'):
			result += [line]
			continue
		ltrim = line.rstrip('\n')
		cols = ltrim.split('\t')
		if len(cols) < 6:
			print(f"Line {lid} invalid: {ltrim}")
			break
		if len(cols) > 6 and len(cols[6]) > 0:
			ITEM_LIST.append(cols[6])	# prefer translated name
		else:
			ITEM_LIST.append(cols[5])	# use original name


with open(sys.argv[1], "rt", encoding="utf-8") as f:
	lines = f.readlines()

lbl_search0 = ("start_0000", 0)
lbl_search1 = (None, 0)
floor_lbls = {}	# labels for "per-floor" coordinate check
item_lbls = {}
event_list = []
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
					"reg_bit": "",
					"item_id": None,
				})
				mode = -1
		elif mode == 10:
			item_lbls[lbl_name] = (10, cur_evt)
			#mode = -1
	elif cols[1] == "JP":
		lbl_name = cols[2].strip()
		if mode == 0:
			lbl_search0 = (lbl_name, -1)	# "end" label
			mode = -1
		elif mode == 1:
			lbl_search1 = (lbl_name, 1)	# take note of label with next comparision
		elif mode == 10:
			if event_list[cur_evt]["item_id"] is None:
				item_lbls[lbl_name] = (10, cur_evt)
			mode = -1
	elif cols[1] == "MOVI":
		comma1 = cols[2].find(',')
		reg_id = int(cols[2][1 : comma1])
		val = int(cols[2][comma1+1:])
		
		if mode == 10:
			if reg_id == 375:
				event_list[cur_evt]["item_id"] = val
	elif cols[1] == "BCLR":
		comma1 = cols[2].find(',')
		reg_id = int(cols[2][1 : comma1])
		val = int(cols[2][comma1+1:])
		
		if mode == 10:
			event_list[cur_evt]["reg_bit"] = f"r{reg_id} bit {val}"

with open(sys.argv[3], "wt", encoding="utf-8") as f:
	if OUTPUT_LABELS:
		f.write("#floor\tcoord\tchk_label\treg_bit\titem\n")
	else:
		f.write("#floor\tcoord\tcheck\titem\n")
	for ev_data in event_list:
		(floor, x, y) = ev_data["coord"]
		
		item_name = ""
		if ev_data["item_id"] is not None:
			itm_id = ev_data["item_id"]
			if itm_id < len(ITEM_LIST):
				item_name = f"item {itm_id:3}: {ITEM_LIST[itm_id]}"
			else:
				item_name = f"item {itm_id:3}"
		
		if OUTPUT_LABELS:
			f.write(f"{floor}F\t{x},{y}\t{ev_data['check_label']}\t" \
				f"{ev_data['reg_bit']}\t{item_name}\n")
		else:
			f.write(f"{floor}F\t{x},{y}\t{ev_data['reg_bit']}\t{item_name}\n")
