#!/usr/bin/env python3
import sys
import struct

if len(sys.argv) < 3:
	print("four-nine/Izuho Saruta System-98 Decompressor")
	print("Usage: {} input.bin output.bin".format(sys.argv[0]))
	sys.exit(1)

fIn = open(sys.argv[1], "rb")
data = fIn.read(4)
dataLen = struct.unpack("<I", data)	# 4-byte Little Endian, decompressed size
dOut = []

nameTable = [0] * 0x1000
nameTblOfs = 1
repeat_mask = 0
check_bit = 0

cmpdata = fIn.read()
remDecBytes = len(cmpdata)
inpos = 0
outpos = 0
decdata = [0] * maxsize
try:
	while True:
		# loc_10A08
		check_bit *= 2
		check_bit &= 0xFF
		if check_bit == 0:
			remDecBytes -= 1
			repeat_mask = cmpdata[inpos];	inpos += 1
			check_bit = 1
		if (repeat_mask & check_bit) != 0:
			remDecBytes -= 1
			al = cmpdata[inpos];	inpos += 1
			decdata[outpos] = al;		outpos += 1
			nameTable[nameTblOfs] = al
			nameTblOfs += 1
			nameTblOfs &= 0xFFF
		else:
			# loc_10A63
			remDecBytes -= 2
			bl = cmpdata[inpos];	inpos += 1
			bh = cmpdata[inpos];	inpos += 1
			# loc_10AAB
			bx = (bh << 8) | (bl << 0)
			if bx == 0:
				break
			cx = (bl & 0x0F) + 3
			rep_ofs = bx >> 4
			
			# loc_10AC3
			for i in range(cx):
				al = nameTable[(rep_ofs + i) & 0xFFF]
				decdata[outpos] = al;	outpos += 1
				nameTable[nameTblOfs] = al
				nameTblOfs = (nameTblOfs + 1) & 0xFFF
except Exception as e:
	print(e)
	print(remDecBytes)
	print(inpos)
	print(len(dOut))


with open(sys.argv[2], "wb") as f:
	f.write(bytes(dOut))
