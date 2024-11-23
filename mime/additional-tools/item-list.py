#!/usr/bin/env python3
# MIME Item List dumper
# Written by Valley Bell, 2024-03-24
import sys
import struct

if len(sys.argv) < 3:
	print(f"Usage: {sys.argv[0]} Z1010.BIN output.txt")
	sys.exit(1)

with open(sys.argv[1], "rb") as f:
	fdata = f.read()

with open(sys.argv[2], "wt", encoding="utf-8") as f:
	f.write(f"#ID\tflags\tname\tcateg.\tprice\tv1C\tv1E\tv20\tv22\n")
	for itemID in range(len(fdata) // 0x24):
		pos = itemID * 0x24
		(iid, flags) = struct.unpack_from("<HH", fdata, pos + 0x00)
		iname_sjis = fdata[pos + 0x04 : pos + 0x18]
		if True:	# The game requires a terminator.
			cpos = iname_sjis.find(b"\\\\")
			iname_sjis = iname_sjis[:cpos]
		vOther = struct.unpack_from("<HHHhhh", fdata, pos + 0x18)
		iname = iname_sjis.decode("cp932")
		
		f.write(f"{iid}\t0x{flags:04X}\t{iname}")
		for val in vOther:
			f.write(f"\t{val}")
		f.write(f"\n")
