#!/usr/bin/env python3
import sys
import os
import struct
import datetime

if len(sys.argv) < 3:
	print("PANDA HOUSE MAX Archive Unpacker")
	print("Usage: {} archive.pck out_folder".format(sys.argv[0]))
	sys.exit(1)

def InitLZSSNameTable() -> list:
	tbl = []
	pos = 0
	for x in range(0x00, 0x100):
		tbl += [x] * 13
	tbl += [x for x in range(0x00, 0x100, 1)]
	tbl += [x for x in range(0xFF, -1, -1)]
	tbl += [0x00] * 0x80
	tbl += [0x20] * 0x6E
	tbl += [0x00] * 0x12
	return tbl

# LZSS decompression algorithm from FourNine unpacker
def Decompress(cmpdata: bytes, decsize: int) -> bytes:
	nameTable = InitLZSSNameTable()
	nameTblOfs = len(nameTable) - 0x12
	repeat_mask = 0
	check_bit = 0
	
	inpos = 0
	outpos = 0
	decdata = [0] * decsize
	try:
		while outpos < decsize:
			check_bit *= 2
			check_bit &= 0xFF
			if check_bit == 0:
				repeat_mask = cmpdata[inpos];	inpos += 1
				check_bit = 1
			if (repeat_mask & check_bit) != 0:
				al = cmpdata[inpos];	inpos += 1
				decdata[outpos] = al;	outpos += 1
				nameTable[nameTblOfs] = al
				nameTblOfs += 1
				nameTblOfs &= 0xFFF
			else:
				bl = cmpdata[inpos];	inpos += 1
				bh = cmpdata[inpos];	inpos += 1
				ofs = ((bh & 0xF0) << 4) | (bl << 0)
				cx = (bh & 0x0F) + 3
				
				for i in range(cx):
					al = nameTable[(ofs + i) & 0xFFF]
					decdata[outpos] = al;	outpos += 1
					nameTable[nameTblOfs] = al
					nameTblOfs = (nameTblOfs + 1) & 0xFFF
	except Exception as e:
		print(e)
		print(f"Inpos: 0x{inpos:04X} / 0x{len(cmpdata):04X}")
		print(f"Outpos: 0x{outpos:04X} / 0x{decsize:04X}")
	
	return bytes(decdata)

outpath = sys.argv[2]

with open(sys.argv[1], "rb") as fArc:
	tocdata = bytearray(fArc.read(0x4000))

	# descramble TOC and header: rotate each 2-byte word left by 1 bit
	for pos in range(0, len(tocdata), 2):
		val = (tocdata[pos+0] << 0) | (tocdata[pos+1] << 8)
		val = (val >> 15) | ((val & 0x7FFF) << 1)
		tocdata[pos+0] = (val >> 0) & 0xFF
		tocdata[pos+1] = (val >> 8) & 0xFF
	
	if tocdata[0:0x10] != b"PCK Version 1.00":
		print("Invalid archive format!")
		sys.exit(1)
	
	os.makedirs(outpath, exist_ok=True)
	# dump the TOC data
	with open(os.path.join(outpath, "_TOC"), "wb") as fOut:
		fOut.write(tocdata)
	
	# dump all files
	for idx in range(1, len(tocdata) // 0x20):
		tocpos = idx*0x20
		fname = tocdata[tocpos+0x00:tocpos+0x0C].decode("shift-jis")
		tdata = struct.unpack_from("<III", tocdata, tocpos+0x0C)
		(_, fpos, flen) = tdata
		tdate = struct.unpack_from("<BBBBBB", tocdata, tocpos+0x18)
		
		if '\x00' in fname:
			fname = fname[ : fname.find('\x00')]
		if (fname.strip() == "") or (fpos == 0):
			break	# end of TOC
		
		print(f"File {fname}: ofs 0x{fpos:06X}, size 0x{flen:04X}")
		fArc.seek(fpos)
		fpath = os.path.join(outpath, fname)
		with open(fpath, "wb") as fOut:
			data = fArc.read(flen)
			if data.startswith(b"MAXPACK"):
				(cmpsize, decsize) = struct.unpack_from("<II", data, 0x0A)
				decdata = Decompress(data[0x12 : 0x12+cmpsize], decsize)
				fOut.write(decdata)
			else:
				fOut.write(data)
		
		# set file date
		try:
			# fields are: year (relative to 1980), month (1..12), day (1..31), hour, minute, second
			fdate = datetime.datetime(1980+tdate[0], tdate[1], tdate[2], tdate[3], tdate[4], tdate[5])
			os.utime(fpath, (fdate.timestamp(), fdate.timestamp()))
		except:
			pass
