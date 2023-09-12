#!/usr/bin/env python3
# Hatchake Ayayo-san 3 font data dumper
# Written by Valley Bell, 2023-09-09
import sys
import os
import struct

if len(sys.argv) < 2:
	print("Usage: {} AYA3.EXE".format(sys.argv[0]))
	print("It will dump aya3TRAM_A100.bin, aya3TRAM_A300.bin and aya3font.bin.")
	print("The dumped font data can be converted with four-nine_system98/font2img.py.")
	sys.exit(0)

with open(sys.argv[1], "rb") as f:
	exedata = f.read()

pos = 0
startPos = None
while pos+3 < len(exedata):
	if exedata[pos : pos+4] == b"\x0C\x25\x0B\x24":
		startPos = pos
		break
	pos += 1
if startPos is None:
	print("Font data not found!")
	sys.exit(1)
print(f"Font data found at offset 0x{startPos:04X}")
pos = startPos

# dump text RAM: character data (0xA1000)
tramA100 = bytearray([0] * 0x1000)
tram_ofs = 0x0040
while True:
	val = struct.unpack_from("<H", exedata, pos)[0]
	pos += 0x02
	if val == 0xFFFF:
		break
	if (val & 0x7F00) == 0x00 or (val & 0x00FF) == 0x0B:
		if (val & 0x8000) == 0:
			struct.pack_into("<H", tramA100, tram_ofs, val)
			tram_ofs += 0x02
		else:
			rep = exedata[pos]
			pos += 0x01
			for ofs in range(rep):
				struct.pack_into("<H", tramA100, tram_ofs, val)
				tram_ofs += 0x02
	else:
		if (val & 0x8000) == 0:
			struct.pack_into("<HH", tramA100, tram_ofs, val, val | 0x0080)
			tram_ofs += 0x04
		else:
			rep = exedata[pos]
			pos += 0x01
			for ofs in range(rep):
				struct.pack_into("<HH", tramA100, tram_ofs, val, val | 0x0080)
				tram_ofs += 0x04

with open("aya3TRAM_A100.bin", "wb") as f:
	f.write(tramA100)

# dump text RAM: attribute data (0xA3000)
tramA300 = bytearray([0] * 0x1000)
tram_ofs = 0x0040
while True:
	val = exedata[pos + 0]
	rep = exedata[pos + 1]
	pos += 0x02
	if val == 0xFF:
		break
	for ofs in range(rep):
		tramA300[tram_ofs + ofs * 2 + 0] = val
		#tramA300[tram_ofs + ofs * 2 + 1] = 0x00	# it doesn't write here
	tram_ofs += rep * 2

with open("aya3TRAM_A300.bin", "wb") as f:
	f.write(tramA300)

# dump font data in "ROM dump" format
fontData = bytearray([0] * (188*0x20))
while True:
	val = struct.unpack_from("<H", exedata, pos)[0]
	pos += 0x02
	if val == 0xFFFF:
		break
	jis1 = (val >> 8) & 0xFF
	jis2 = (val >> 0) & 0xFF
	chr_id = (jis1 - 0x76) * 94 + (jis2 - 0x21)
	ofs = chr_id * 0x20
	fontData[ofs : ofs+0x20] = exedata[pos : pos + 0x20]
	pos += 0x20

with open("aya3font.bin", "wb") as f:
	f.write(fontData)

print("Done.")		

sys.exit(0)
