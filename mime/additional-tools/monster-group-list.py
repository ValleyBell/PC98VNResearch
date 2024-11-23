#!/usr/bin/env python3
# MIME Monster Group List dumper
# Written by Valley Bell, 2024-11-20
import sys
import struct

if len(sys.argv) < 4:
	print(f"Usage: {sys.argv[0]} Z1020.BIN Z103#.BIN output.tsv")
	sys.exit(1)

with open(sys.argv[1], "rb") as f:
	fdata = f.read()

monster_list = []
for itemID in range(len(fdata) // 0x48):
	pos = itemID * 0x48
	iid = struct.unpack_from("<H", fdata, pos + 0x00)[0]
	
	mname_sjis = fdata[pos + 0x08 : pos + 0x1E]
	if True:	# The game requires a terminator.
		cpos = mname_sjis.find(b"\\\\")
		mname_sjis = mname_sjis[:cpos]
	vOther = struct.unpack_from("<HHHHHHHHIIIIHHHHH", fdata, pos + 0x1E)
	try:
		mname = mname_sjis.decode("cp932")
	except UnicodeDecodeError:
		mname = mname_sjis
	
	monster_list.append(mname)


dotpos = sys.argv[2].rfind('.')
floor_id = sys.argv[2][dotpos - 1].upper()
try:
	floor_id = int(floor_id, 0x10)	# try to convert hex digit into decimal
except:
	pass

with open(sys.argv[2], "rb") as f:
	fdata = f.read()

mgroups = []
for itemID in range(len(fdata) // 0x12):
	pos = itemID * 0x12
	(mcount, m1, m2, m3, m4, a1, a2, a3, a4) = struct.unpack_from("<HHHHHHHHH", fdata, pos + 0x00)
	m_ids = [m1, m2, m3, m4]
	m_addrs = [a1, a2, a3, a4]
	mgroup = []
	for mid in range(4):
		if m_ids[mid] == 0xFFFF:
			mname = "-"
		elif m_ids[mid] < len(monster_list):
			mname = monster_list[m_ids[mid]]
		else:
			mname = f"monster_{m_ids[mid]}"
		x = (m_addrs[mid] % 80) * 8
		y = m_addrs[mid] // 80
		mgroup.append((mname, x, y))
	mgroups.append((mcount, mgroup))

with open(sys.argv[3], "wt", encoding="utf-8") as f:
	f.write(f"#floor\tgroup\tmonster 1\tpos 1\tmonster 2\tpos 2\tmonster 3\tpos 3\tmonster 4\tpos 4\n")
	
	for (mg_id, mg) in enumerate(mgroups):
		if mg[0] == 0xFFFF:
			continue	# unused group - skip
		if True:
			mcount = mg[0]
		else:
			mcount = 4
		if mcount > len(mg[1]):
			mcount = len(mg[1])
		
		cols = [f"{floor_id}F", f"{mg_id}"]
		for m_id in range(mcount):
			mst = mg[1][m_id]
			cols.append(mst[0])
			cols.append(f"{mst[1]},{mst[2]}")
		f.write('\t'.join(cols) + "\n")
