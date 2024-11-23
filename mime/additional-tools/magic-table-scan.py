#!/usr/bin/env python3
# MIME "Magic Tablet" spell/item list generator
# Written by Valley Bell, 2024-08-18
import sys

if len(sys.argv) < 4:
	print(f"Usage: {sys.argv[0]} A205A.asm Z1010.tsv out.tsv")
	print("")
	print("Please note that this tool requires decompiled files.")
	print("Those can be generated this way:")
	print("  1. decompress the game's DAT files to BIN")
	print("  2. decompile the required files:")
	print("     python list-tsv.py -d -I Z1010.BIN Z1010.tsv")
	print("     python ScenarioDecompile.py SCN/A205A.BIN A205A.asm")
	sys.exit(1)

RUNE_LIST = [
	"wind",
	"protection",
	"shadow",
	"water",
	"harmony",
	"accuracy",
	"fire",
	"holy",
	"scatter",
	"earth",
	"light",
	"destruction",
	"evil",
]

CHARACTER_LIST = ["Eagle", "Tear", "Henzou", "Eldelyca"]

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

slots = [-1]*6
item_generate = []
item_lbls = {}

mode = -1
lbl_search = ("sub_07E5", 0)
cur_item = None
for (lid, line) in enumerate(lines):
	line = line.rstrip()
	cols = line.split('\t')
	if cols[0].endswith(":"):
		lbl_name = cols[0].rstrip(':')
		if lbl_name == lbl_search[0]:
			mode = lbl_search[1]
			continue
		elif lbl_name in item_lbls:
			mode = 2
			cur_item = item_lbls[lbl_name]
			continue
	if mode == 0:
		if len(cols) < 2:
			continue
		if cols[1] == "JEQ" and cols[2].startswith("r"):
			comma1 = cols[2].find(',')
			comma2 = cols[2].find(',', comma1 + 1)
			reg_id = int(cols[2][1 : comma1])
			cmp_val = int(cols[2][comma1+1 : comma2])
			lbl_name = cols[2][comma2+1:].strip()
			if reg_id >= 337 and reg_id <= 342:
				slots[reg_id - 337] = cmp_val
				mode = -1
				if reg_id == 342:
					lbl_search = (lbl_name, 1)
				else:
					lbl_search = (lbl_name, 0)
	elif mode == 1:
		if len(cols) < 2:
			continue
		if cols[1] == "JP":
			item_lbls[cols[2]] = len(item_generate)
			item_generate.append([slots.copy(), None, None])
			mode = 0
		else:
			print(f"Warning: Unknown command {cols[1]} on line {1+lid}!")
	elif mode == 2:
		if len(cols) < 2:
			continue
		if cols[1] == "MOVI":
			comma1 = cols[2].find(',')
			reg_id = int(cols[2][1 : comma1])
			val = int(cols[2][comma1+1:])
			if reg_id == 374:
				item_generate[cur_item][1] = "spell"
				item_generate[cur_item][2] = val
			elif reg_id == 375:
				item_generate[cur_item][1] = "item"
				item_generate[cur_item][2] = val
			mode = -1

with open(sys.argv[3], "wt", encoding="utf-8") as f:
	f.write("#" + '\t'.join([f"rune{n}" for n in range(1, 7)]) + "\tspell/item\n")
	for item in item_generate:
		(slots, itm_type, itm_id) = item
		#slot_text = "\t".join([RUNE_LIST[s-1]+f" ({s})" for s in slots])
		slot_text = "\t".join([RUNE_LIST[s-1] for s in slots])
		if itm_type == "spell":
			itm_text = CHARACTER_LIST[itm_id // 10] + f" spell {1 + (itm_id % 10)}"
		elif itm_type == "item":
			itm_text = f"[item {itm_id}] {ITEM_LIST[itm_id]}"
		else:
			itm_text = f"{itm_type} {itm_id}"
		f.write(f"{slot_text}\t{itm_text}\n")
