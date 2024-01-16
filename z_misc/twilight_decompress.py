#!/usr/bin/env python3
# PC-98 Twilight decompressor
# Ported from x86 assembly by Valley Bell, 2024-01-10
import sys
import struct

if len(sys.argv) < 3:
	print("Twilight Decompressor")
	print("Usage: {} compressed.bin decompressed.bin".format(sys.argv[0]))
	sys.exit(1)

fIn = open(sys.argv[1], "rb")
(comprLen, decLen) = struct.unpack("<II", fIn.read(8))

def Decomp_ReadFile():
	global comprBuf
	global comprBasePos
	comprBasePos += len(comprBuf)
	comprBuf = fIn.read(0x2000)
	comprBuf += b'\x00x00'	# for dummy read at EOF (required by the bitstream reader)
	return

"""
Memory offsets:
ds:2575h - remaining bytes to decompress (4 bytes)
ds:2579h - output buffer (0x4000 bytes)

ds:6579h - input buffer offset/pointer (2 bytes) [segment from cs:12C8]
ds:657Bh - remaining tokens before reinitialization (2 bytes)

ds:657Dh - tree buffer 1 (0x3FB 2-byte words / 0x7F6 bytes)
ds:6D73h - tree buffer 2 (0x3FB 2-byte words / 0x7F6 bytes)
ds:7569h - ?? buffer (0x1000 2-byte words / 0x2000 bytes)
ds:9569h - ?? buffer (0x100 2-byte words / 0x200 bytes)
ds:9769h - ?? buffer (0x1FE bytes)
ds:9967h - ?? buffer (0x60 bytes, how many are really used?)

ds:99E7h - bit stream reader: next 2 bytes (2 bytes)
ds:99E9h - bit stream reader: current byte (1 byte)
ds:99EAh - bit stream reader: remaining bits before reading next byte (1 byte)

ds:99EBh - destination LUT offset (2 bytes) [same as ds:99EDh*2]
ds:99EDh - source LUT size (2 bytes)
ds:99EFh - bit count (2 bytes)
ds:99F1h - destination LUT address (2 bytes)
ds:99F3h - inverse bit count (1 byte)
"""

dOut = bytearray()
buf_657Dh = [0] * 0x3FB	# 16-bit values
buf_6D73h = [0] * 0x3FB	# 16-bit values
buf_7569h = [0] * 0x1000	# 16-bit values
buf_9569h = [0] * 0x100	# 16-bit values
buf_9769h = [0] * 0x1FE	# 8-bit values
buf_9967h = [0] * 0x60	# 8-bit values

def sub_10856(decBuf, decPos):	# flush decompression buffer and copy bytes to destination address
	global dOut
	if decPos == 0:
		return
	dOut += decBuf[0 : decPos]	# that's all it does (+ pointer/segment register adjustments)
	return

def sub_10552():	# Decode Control Byte
	global ds_657Bh
	global buf_7569h
	global buf_9769h
	ds_657Bh -= 1
	if ds_657Bh < 0:
		# loc_10559
		ax = sub_107B3(16)
		ds_657Bh = ax - 1
		sub_105F0(19, 5, 3)
		sub_10666()
		sub_105F0(14, 4, 0xFFFF)
	# loc_1057D
	bx = ds_99E7h >> 4
	bx = buf_7569h[bx]	# 16-bit indexing
	if bx >= 0x1FE:
		bx = sub_1059E(bx, 4)
	sub_107C4(buf_9769h[bx])
	return bx	# return in ax

def sub_1059E(bx, cl):
	global ds_99E7h

	al = (ds_99E7h << cl) & 0xFF
	cx = 0x1FE
	return sub_105A6(al, bx, cx)	# return in bx

def sub_105A6(al, bx, cx):
	global buf_657Dh
	global buf_6D73h

	while True:
		if (al & 0x80) != 0:
			bx = buf_6D73h[bx//2]
		else:
			bx = buf_657Dh[bx//2]
		al <<= 1
		if bx < cx:
			return bx	# return in bx

def sub_105B4(al, bx, cx):
	global buf_657Dh
	global buf_6D73h

	while bx >= cx:
		if (al & 0x80) != 0:
			bx = buf_6D73h[bx//2]
		else:
			bx = buf_657Dh[bx//2]
		al <<= 1
	return bx	# return in bx

def sub_105B9():	# Decode Position
	global ds_99E7h
	global buf_9569h
	global buf_9967h

	bx = buf_9569h[ds_99E7h >> 8]	# 16-bit indexing
	if bx >= 14:
		bx = sub_105A6(ds_99E7h & 0xFF, bx, 14)
	# loc_105D4
	sub_107C4(buf_9967h[bx])
	if bx > 1:
		cl = bx - 1
		bx = sub_107B3(cl)
		bx |= (1 << cl)
	return bx	# return in ax

def sub_105F0(si, dl, cx):
	ax = sub_107B3(dl)
	if ax > si:
		# This really happens ingame with TWGD2.DAT / file 0x13.
		raise Exception(f"sub_105F0: {ax} > {si}")	# the original code freezes here
	if ax == 0:
		# loc_10607
		for i in range(si):
			buf_9967h[i] = 0
		ax = sub_107B3(dl)
		for i in range(0x100):
			buf_9569h[i] = ax
		return

	# loc_10618
	di_ofs = 0
	dx_ofs = cx
	si_ofs = ax
	while True:
		# loc_10620
		ax = sub_107B3(3)
		if ax == 7:
			bx = ds_99E7h
			while (bx & 0x8000) != 0:
				bx <<= 1
				ax += 1
			# loc_10634
			sub_107C4(ax - 6)	# result is discarded
		# loc_1063B
		buf_9967h[di_ofs] = ax & 0xFF
		di_ofs += 1
		if di_ofs == dx_ofs:
			cx = sub_107B3(2)
			for i in range(cx):
				buf_9967h[di_ofs + i] = 0
			di_ofs += cx
		# loc_1064B
		if di_ofs >= si_ofs:
			break

	# loc_1064F
	cx = si - di_ofs
	for i in range(cx):
		buf_9967h[di_ofs + i] = 0
	di_ofs += cx

	loc_106F6(si, buf_9967h, 8, buf_9569h)
	return

def sub_10666():
	ax = sub_107B3(9)
	if ax > 0x1FE:
		raise Exception(f"sub_10666: 0x{ax:02X} > 0x{0x1FE:02X}")	# the original code freezes here
	if ax == 0:
		# loc_1067D
		for i in range(0x1FE):
			buf_9769h[i] = 0
		ax = sub_107B3(9)
		for i in range(0x100):
			buf_7569h[i] = ax
		return

	# loc_10690
	di_ofs = 0
	dx_ofs = ax
	while True:
		# loc_10695
		bx = buf_9569h[ds_99E7h >> 8]	# 16-bit indexing
		bx = sub_105B4(ds_99E7h & 0xFF, bx, 19)
		# push BX
		sub_107C4(buf_9967h[bx])
		# pop AX
		if bx <= 2:
			if bx == 2:
				cx = 20 + sub_107B3(9)
			# loc_106C4
			elif bx == 1:
				cx = 3 + sub_107B3(4)
			else:
				cx = 1
			# loc_106D6
			for i in range(cx):
				buf_9769h[di_ofs + i] = 0
			di_ofs += cx
		elif bx > 2:
			# loc_106DC
			buf_9769h[di_ofs] = (bx - 2) & 0xFFF
			di_ofs += 1
		# loc_106DD
		if di_ofs >= dx_ofs:
			break

	# loc_106E1
	cx = 0x1FE - di_ofs
	for i in range(cx):
		buf_9769h[di_ofs + i] = 0
	di_ofs += cx

	loc_106F6(0x1FE, buf_9769h, 12, buf_7569h)
	return

def loc_106F6(ax, bp, cx, di):
	# ax = count
	# bp = byte array
	# cx = bit count
	# di = word array
	ds_99EDh = ax	# source buffer size
	ds_99EBh = ax * 2	# offset into tree structure
	ds_99EFh = cx	# bit shift count
	ds_99F1h = di	# destination buffer
	ds_99F3h = 16 - cx	# inverse bit shift count
	cx = 1 << cx
	for i in range(cx):
		ds_99F1h[i] = 0

	si = 0
	bx = 0x8000
	dx = 1
	while True:
		# loc_10720
		di_ofs = 0
		cx_rep = ds_99EDh
		while True:
			# loc_10726
			al = dx
			# emulation of "REPNE SCASB" start
			result_eq = False
			while cx_rep > 0:
				result_eq = (bp[di_ofs] == al)
				di_ofs += 1
				cx_rep -= 1
				if result_eq == True:
					break
			# "REPNE SCASB" end
			if not result_eq:
				break	# goto loc_10797
			ax = di_ofs - 1

			di = ds_99F1h	# 16-bit indexing
			di2_ofs = si >> ds_99F3h
			if dx <= ds_99EFh:
				cx = bx >> ds_99F3h
				for i in range(cx):
					di[di2_ofs + i] = ax
			else:
				# loc_10750
				si2 = (si << ds_99EFh) & 0xFFFF
				cx = dx - ds_99EFh
				for i in range(cx):
					# loc_1075B
					if di[di2_ofs] == 0:
						buf_6D73h[ds_99EBh//2] = 0	# //2 for offset->index conversion
						buf_657Dh[ds_99EBh//2] = 0
						di[di2_ofs] = ds_99EBh
						ds_99EBh += 2
					# loc_10777
					di2_ofs = di[di2_ofs]//2	# //2 for offset->index conversion
					if (si2 & 0x8000) != 0:
						di = buf_6D73h
					else:
						di = buf_657Dh
					si2 <<= 1
				# loc_10789
				di[di2_ofs] = ax
			# loc_1078C
			si += bx
			if si >= 0x10000:
				return
			if cx == 0:
				break
		# loc_10797
		dx += 1
		if (bx & 0x0001) != 0:
			break
		bx >>= 1
	return

def sub_107B3(al):
	global ds_99E7h

	cl = 16 - al
	old_ds_99E7h = ds_99E7h
	sub_107C4(al)	# will modify ds_99E7h
	return old_ds_99E7h >> cl	# return in ax

def sub_107C4(al):	# bitstream read
	global comprBuf
	global ds_6579h
	global ds_99E7h
	global ds_99E9h
	global ds_99EAh

	ch_bitsToRead = al
	cl = ds_99EAh
	dx = ds_99E7h
	al = ds_99E9h
	if ch_bitsToRead > cl:
		ch_bitsToRead -= cl
		dx <<= cl
		dh = (dx >> 8) & 0xFF
		dl = (dx >> 0) & 0xFF
		al = ((al << cl) | (al << cl >> 8)) & 0xFF	# rotate left AL by CL
		dl += al

		cl = 8
		while True:
			# loc_107E1
			al = comprBuf[ds_6579h]	# ds_6579h == input buffer pointer
			ds_6579h += 1
			if ds_6579h == 0x2000:
				Decomp_ReadFile()
				ds_6579h = 0
			# loc_107FA
			if ch_bitsToRead <= cl:
				break
			ch_bitsToRead -= cl
			dh = dl
			dl = al
		dx = (dh << 8) | (dl << 0)
	# loc_1080A
	ds_99EAh = cl - ch_bitsToRead
	ax = al << ch_bitsToRead
	ds_99E7h = ((dx << ch_bitsToRead) & 0xFFFF) + (ax >> 8)
	ds_99E9h = ax & 0xFF
	return ax	# return in ax

try:
	comprBuf = bytes()
	comprBasePos = 0
	Decomp_ReadFile()
	ds_6579h = 0
	# loc_104AF
	decBuf = bytearray(0x4000)	# memory offset 2579h
	decPos = 0x0000	# register DI
	# mov [di+2579h], al / inc di -> decBuf[decPos] = al; decPos+=1
	ds_2575h = decLen
	ds_657Bh = 0
	ds_99E7h = 0
	ds_99E9h = 0
	ds_99EAh = 0
	sub_107C4(16)
	ds_2575h -= 1
	while ds_2575h >= 0:
		# loc_104F0
		ax = sub_10552()
		if ax < 0x100:
			# loc_104F7
			decBuf[decPos] = ax & 0xFF
			decPos += 1
			ds_2575h -= 1
			if ds_2575h < 0:
				break
			# loc_1050B
			if (decPos & 0x4000) != 0:
				sub_10856(decBuf, decPos)
				decPos = 0x0000
			# loc_10516
			#goto loc_104F0
		else:
			# loc_10518
			cx = ax - 0x100 + 3
			ax = sub_105B9()
			srcPos = decPos - 1 - ax
			while True:
				# loc_10526
				srcPos &= 0x3FFF
				decBuf[decPos] = decBuf[srcPos]
				srcPos += 1
				decPos += 1
				ds_2575h -= 1
				if ds_2575h < 0:
					break
				if (decPos & 0x4000) != 0:
					sub_10856(decBuf, decPos)
					decPos = 0x0000
				cx -= 1
				if cx <= 0:
					break
			if ds_2575h < 0:
				break
			#goto loc_104F0
	# rfa_cmp_end
	sub_10856(decBuf, decPos)
except Exception as e:
	print(f"Decompression Error - {e}", file=sys.stderr)
	sub_10856(decBuf, decPos)
	print(f"InPos: 0x{comprBasePos+ds_6579h:04X} / 0x{comprLen:04X}, " \
		f"outPos: 0x{len(dOut):04X} / 0x{decLen:04X}", file=sys.stderr)

with open(sys.argv[2], "wb") as f:
	f.write(dOut)
