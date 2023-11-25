#!/usr/bin/env python3
# Waku Waku Mahjong Panic! uses the same LZSS compression as System-98.
# The only difference is, that WMP files have an additional "eLZ0" signature at the beginning.
import sys
import struct

if len(sys.argv) < 3:
	print("Waku Waku Mahjong Panic! Decompressor")
	print("Usage: {} input.bin output.bin".format(sys.argv[0]))
	sys.exit(1)

fIn = open(sys.argv[1], "rb")
data = fIn.read(4)
if data != b"eLZ0":
	print("Not a compressed file!")
	sys.exit(2)

data = fIn.read(4)
dataLen = struct.unpack("<I", data)	# 4-byte Little Endian, decompressed size
dOut = []

nameTable = [0]*0x1000
comprBuf = fIn.read()
dx = len(comprBuf)
di = 0
si = 0
nameTblOfs = 1
cl = 0
ch = 0

try:
	while True:
		# loc_10A08
		ch *= 2
		ch &= 0xFF
		if ch == 0:
			dx -= 1
			cl = comprBuf[si];	si += 1
			ch = 1
		if (cl & ch) != 0:
			dx -= 1
			al = comprBuf[si];	si += 1
			dOut.append(al)
			nameTable[nameTblOfs] = al
			nameTblOfs += 1
			nameTblOfs &= 0xFFF
		else:
			# loc_10A63
			dx -= 2
			bl = comprBuf[si];	si += 1
			bh = comprBuf[si];	si += 1
			# loc_10AAB
			bx = (bh << 8) | (bl << 0)
			if bx == 0:
				break
			cx = (bl & 0x0F) + 3
			bx >>= 4
			
			# loc_10AC3
			for i in range(cx):
				al = nameTable[(bx + i) & 0xFFF]
				dOut.append(al)
				nameTable[nameTblOfs] = al
				nameTblOfs = (nameTblOfs + 1) & 0xFFF
except Exception as e:
	print(e)
	print(dx)
	print(si)
	print(len(dOut))


with open(sys.argv[2], "wb") as f:
	f.write(bytes(dOut))
