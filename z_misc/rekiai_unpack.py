#!/usr/bin/env python3
import sys
import os
import struct
import datetime

if len(sys.argv) < 3:
	print("Rekiai Archive Unpacker")
	print("Usage: {} rekiai.dat out_folder".format(sys.argv[0]))
	sys.exit(1)

outpath = sys.argv[2]

with open(sys.argv[1], "rb") as fArc:
	hdrdata = fArc.read(0x20)
	if hdrdata[0x00:0x02] != b'\x9E\x99':
		print("Invalid archive format!")
		sys.exit(1)
	
	some_val = struct.unpack_from("<I", hdrdata, 0x04)[0]	# unknown value
	fileCnt = struct.unpack_from("<I", hdrdata, 0x08)[0]
	tocdata = bytearray(fArc.read(fileCnt * 0x20))
	data_pos = fArc.tell()

	# decrypt TOC
	for idx in range(fileCnt):
		tocpos = idx * 0x20
		key = tocdata[tocpos + 0x00]
		for ofs in range(0x01, 0x20):
			tocdata[tocpos + ofs] ^= key
	
	os.makedirs(outpath, exist_ok=True)
	# dump the TOC data
	with open(os.path.join(outpath, "_TOC"), "wb") as fOut:
		fOut.write(tocdata)
	
	# dump all files
	fpos = data_pos
	for idx in range(fileCnt):
		tocpos = idx * 0x20
		fname_b = tocdata[tocpos+0x01:tocpos+0x0E]
		if b'\x00' in fname_b:
			fname_b = fname_b[: fname_b.find(b'\x00')]
		fname = fname_b.decode("Shift-JIS")
		tdata = struct.unpack_from("<HHHI", tocdata, tocpos+0x0E)
		(fattrs, fat_time, fat_date, flen) = tdata
		
		fdate = [
			((fat_date >>  9) & 0x7F) + 1980,	# year (relative to 1980)
			((fat_date >>  5) & 0x0F),			# month (1..12)
			((fat_date >>  0) & 0x1F),			# day (1..31)
			((fat_time >> 10) & 0x1F),			# hours
			((fat_time >>  5) & 0x3F),			# minutes
			((fat_time >>  0) & 0x1F) * 2,		# seconds (2-second steps in FAT timestamps)
		]
		
		print(f"File {fname}: ofs 0x{fpos:06X}, size 0x{flen:04X}")
		fArc.seek(fpos)
		fpath = os.path.join(outpath, fname)
		with open(fpath, "wb") as fOut:
			data = fArc.read(flen)
			fOut.write(data)
		fpos += flen
		
		# set file date
		try:
			# fields are: year, month, day, hour, minute, second
			fdate = datetime.datetime(fdate[0], fdate[1], fdate[2], fdate[3], fdate[4], fdate[5])
			os.utime(fpath, (fdate.timestamp(), fdate.timestamp()))
		except:
			pass
