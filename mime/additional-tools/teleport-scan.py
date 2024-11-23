#!/usr/bin/env python3
# MIME "B1F Teleport" script analyser
# Written by Valley Bell, 2024-11-21
import sys
import typing

if len(sys.argv) < 2:
	print(f"Usage: {sys.argv[0]} SEL_EV4.asm out.tsv")
	print("Please note that this tool requires a decompiled script file.")
	sys.exit(1)

OUTPUT_LABELS = False	# for debugging

DIRECTIONS = ["north", "west", "south", "east"]


with open(sys.argv[1], "rt", encoding="utf-8") as f:
	lines = f.readlines()

lbl_search0 = ("start_0000", 0)
lbl_search1 = (None, 0)
floor_lbls = {}	# labels for "per-floor" coordinate check
item_lbls = {}
event_list = []
teleport_lbls = {}
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
				})
				if lbl_name not in teleport_lbls:
					teleport_lbls[lbl_name] = {"destination": [None, None, None]}
				mode = -1
		elif mode == 10:
			#item_lbls[lbl_name] = (10, cur_evt)
			# There are no jumps in the destination section
			mode = -1
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
			# There are no calls in the destination section
			mode = -1
	elif cols[1] == "MOVI":
		comma1 = cols[2].find(',')
		reg_id = int(cols[2][1 : comma1])
		val = int(cols[2][comma1+1:], 0)
		
		if mode == 10:
			dst_data = teleport_lbls[cur_lbl]["destination"]
			if reg_id == 390:	# destination: map X
				dst_data[0] = val
			elif reg_id == 391:	# destination: map Y
				dst_data[1] = val
			elif reg_id == 393:	# destination: facing direction
				dst_data[2] = val
	elif cols[1] == "SCNLOAD":
		mode = -1

with open(sys.argv[2], "wt", encoding="utf-8") as f:
	if OUTPUT_LABELS:
		f.write("#floor\tcoord\tchk_label\titem\n")
	else:
		f.write("#floor\tcoord\titem\n")
	for ev_data in event_list:
		(floor, x, y) = ev_data["coord"]
		
		dst_text = "?"
		tlpt_lbl = ev_data["check_label"]
		if (tlpt_lbl in teleport_lbls) and (teleport_lbls[tlpt_lbl]["destination"] != [None, None, None]):
			(dst_x, dst_y, dst_dir) = teleport_lbls[tlpt_lbl]["destination"]
			if (type(dst_dir) is int) and (dst_dir >= 0 and dst_dir < len(DIRECTIONS)):
				ddtext = f"{DIRECTIONS[dst_dir]} [{dst_dir}]"
			else:
				ddtext = f"direction {dst_dir}"
			dst_text = f"teleport -> {dst_x},{dst_y} {ddtext}"
		
		if OUTPUT_LABELS:
			f.write(f"{floor}F\t{x},{y}\t{ev_data['check_label']}\t{dst_text}\n")
		else:
			f.write(f"{floor}F\t{x},{y}\t{dst_text}\n")
