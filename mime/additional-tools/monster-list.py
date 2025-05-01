#!/usr/bin/env python3
# MIME Monster List dumper
# Written by Valley Bell, 2024-03-24
import sys
import struct

if len(sys.argv) < 3:
	print(f"Usage: {sys.argv[0]} Z1020.BIN output.txt")
	sys.exit(1)

with open(sys.argv[1], "rb") as f:
	fdata = f.read()

with open(sys.argv[2], "wt", encoding="utf-8") as f:
	f.write("#ID\tGTA\tname                 ")
	f.write("\telement\tlevel\tExp.\tHP\tatk\tdef\tint\tagl\tact1\tact2\tact3\tact4\tmoney");
	for varID in range(0x40, 0x48, 2):
		if varID == 0x44:
			f.write(f"\twidth")
		else:
			f.write(f"\tv{varID:02X}")
	f.write(f"\n")
	
	for itemID in range(len(fdata) // 0x48):
		pos = itemID * 0x48
		iid = struct.unpack_from("<H", fdata, pos + 0x00)[0]
		
		gtaname_sjis = fdata[pos + 0x02 : pos + 0x08]
		if True:	# The game requires a terminator.
			cpos = gtaname_sjis.find(b"\x00")
			gtaname_sjis = gtaname_sjis[:cpos]
		gtaname = gtaname_sjis.decode("cp932")
		
		mname_sjis = fdata[pos + 0x08 : pos + 0x1E]
		if True:	# The game requires a terminator.
			cpos = mname_sjis.find(b"\\\\")
			mname_sjis = mname_sjis[:cpos]
		mname_sjis = mname_sjis.ljust(21, fillchar=' ')
		vOther = struct.unpack_from("<HHHHHHHHIIIIHHHHH", fdata, pos + 0x1E)
		try:
			mname = mname_sjis.decode("cp932")
		except UnicodeDecodeError:
			mname = mname_sjis
		
		f.write(f"{iid}\t{gtaname}\t{mname}")
		for val in vOther:
			f.write(f"\t{val}")
		f.write(f"\n")
