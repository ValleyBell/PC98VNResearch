#!/usr/bin/env python3
# PANDA HOUSE MAX Archive (Un-)Packer
# Written by Valley Bell, 2023-02-22 (unpacking), 2023-08-11 (repacking)
import sys
import os
import argparse
import pathlib
import struct
import datetime

ARC_TOC_FILE_COUNT = 0x1FF

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

def arc_extract(config):
	basepath = config.file_path

	with config.arc_file.open("rb") as fArc:
		tocData = bytearray(fArc.read((1+ARC_TOC_FILE_COUNT) * 0X20))

		# descramble TOC and header: rotate each 2-byte word left by 1 bit
		for pos in range(0, len(tocData), 2):
			val = (tocData[pos+0] << 0) | (tocData[pos+1] << 8)
			val = (val >> 15) | ((val & 0x7FFF) << 1)
			tocData[pos+0] = (val >> 0) & 0xFF
			tocData[pos+1] = (val >> 8) & 0xFF

		if tocData[0:0x10] != b"PCK Version 1.00":
			print("Invalid archive format!")
			return 1

		basepath.mkdir(parents=True, exist_ok=True)
		# dump the TOC data
		#with (basepath / "_TOC.BIN").open("wb") as fOut:
		#	fOut.write(tocData)

		# dump all files
		with (basepath / "_fileList.txt").open("wt") as fTxt:
			fTxt.write("#filename\tflags\n")

			# start with 1, as the first entry is the archive header
			for fileID in range(1, len(tocData) // 0x20):
				tocPos = fileID*0x20
				fTitle = tocData[tocPos+0x00:tocPos+0x0C].decode("shift-jis")
				tdata = struct.unpack_from("<III", tocData, tocPos+0x0C)
				(_, fpos, flen) = tdata
				tdate = struct.unpack_from("<BBBBBB", tocData, tocPos+0x18)

				if '\x00' in fTitle:
					fTitle = fTitle[:fTitle.find('\x00')]
				if (fTitle.strip() == "") or (fpos == 0):
					break	# end of TOC

				print(f"File {fileID:3}: {fTitle:13}- ofs 0x{fpos:06X}, size 0x{flen:04X}")
				fArc.seek(fpos)
				fPath = basepath / fTitle
				with fPath.open("wb") as fOut:
					data = fArc.read(flen)
					flags = 0x01 if data.startswith(b"MAXPACK") else 0x00
					fTxt.write(f"{fTitle}\t{flags:02X}\n")

					if (flags & 0x01) and not config.raw:
						(cmpsize, decsize) = struct.unpack_from("<II", data, 0x0A)
						decdata = Decompress(data[0x12 : 0x12+cmpsize], decsize)
						fOut.write(decdata)
					else:
						fOut.write(data)

				# set file date
				try:
					# fields are: year (relative to 1980), month (1..12), day (1..31), hour, minute, second
					fdate = datetime.datetime(1980+tdate[0], tdate[1], tdate[2], tdate[3], tdate[4], tdate[5])
					os.utime(fPath, (fdate.timestamp(), fdate.timestamp()))
				except:
					pass

	print("Done.")
	return 0

def arc_create(config):
	basepath = config.file_path.parent
	fileToc = []
	with config.file_path.open("rt") as fTxt:
		for (lid, line) in enumerate(fTxt):
			line = line.strip()
			if len(line) == 0 or line.startswith('#'):
				continue	# ignore empty lines and comments
			litems = line.split('\t')
			if len(litems) < 2:
				continue

			fileToc.append([litems[0], int(litems[1], 0x10), -1, -1, 0])
	if len(fileToc) > ARC_TOC_FILE_COUNT:
		print(f"Warning! File list contains {len(fileToc)} files, but only {ARC_TOC_FILE_COUNT} can be stored!")
		fileToc = fileToc[0:ARC_TOC_FILE_COUNT]

	print("Packing {} {} ...".format(len(fileToc), "file" if len(fileToc) == 1 else "files"), flush=True)
	# go through all files, determining file sizes and archive file data offsets
	tocData = bytearray((1+ARC_TOC_FILE_COUNT) * 0x20)

	tocData[0x00:0x10] = b"PCK Version 1.00"
	tocData[0x10:0x12] = b"\x00" * 0x02
	tocData[0x12:0x1F] = b"\x20" * 0x0D
	tocData[0x1F] = 0x0D
	tocPos = 0x20
	filePos = len(tocData)
	for fInfo in fileToc:
		inputPath = basepath / fInfo[0]
		fInfo[2] = filePos
		fInfo[3] = os.path.getsize(inputPath)
		fStat = os.stat(inputPath)
		fInfo[4] = fStat.st_mtime	# get modification time
		filePos += fInfo[3]

		fname_b = fInfo[0].encode("Shift-JIS")
		if len(fname_b) > 0x0C:
			fname_b = fname_b[0x00:0x0C]
		if len(fname_b) < 0x0C:
			fname_b += b'\x00'	# the file name needs to be null-terminated when <12 characters long
			fname_b = fname_b.ljust(0x0C, b' ')	# pad up to 0x0C bytes

		tocData[tocPos+0x00 : tocPos+0x0C] = fname_b
		tocData[tocPos+0x0C : tocPos+0x10] = b"\x00" * 0x04

		struct.pack_into("<II", tocData, tocPos+0x10, fInfo[2], fInfo[3])

		fDate = datetime.datetime.fromtimestamp(fInfo[4])
		tocData[tocPos+0x18] = (fDate.year - 1980) & 0xFF
		tocData[tocPos+0x19] = fDate.month
		tocData[tocPos+0x1A] = fDate.day
		tocData[tocPos+0x1B] = fDate.hour
		tocData[tocPos+0x1C] = fDate.minute
		tocData[tocPos+0x1D] = fDate.second
		tocData[tocPos+0x1E : tocPos+0x20] = b"\x00" * 0x02
		tocPos += 0x20
	fileEndOfs = filePos

	# fill the rest of the entries with dummy data
	while tocPos < len(tocData):
		tocData[tocPos+0x00 : tocPos+0x0C] = b"\x20" * 0x0C
		tocData[tocPos+0x0C : tocPos+0x20] = b"\x00" * 0x14
		tocPos += 0x20
	#with (basepath / "_TOC-out.BIN").open("wb") as fOut:
	#	fOut.write(tocData)

	# scramble TOC and header: rotate each 2-byte word right by 1 bit
	for pos in range(0, len(tocData), 2):
		val = (tocData[pos+0] << 0) | (tocData[pos+1] << 8)
		val = (val >> 1) | ((val & 0x0001) << 15)
		tocData[pos+0] = (val >> 0) & 0xFF
		tocData[pos+1] = (val >> 8) & 0xFF

	with config.arc_file.open("wb") as fArc:
		fArc.write(tocData)

		for fInfo in fileToc:
			inputPath = basepath / fInfo[0]
			with inputPath.open("rb") as fIn:
				fArc.seek(fInfo[2])
				fArc.write(fIn.read(fInfo[3]))

	print("Done.")
	return 0

def main(argv):
	print("PANDA HOUSE MAX Archive (Un-)Packer")
	aparse = argparse.ArgumentParser()
	apgrp = aparse.add_mutually_exclusive_group(required=True)
	apgrp.add_argument("-x", "--extract", action="store_true", help="extract archive")
	apgrp.add_argument("-c", "--create", action="store_true", help="create archive (specify _fileList.txt)")
	aparse.add_argument("-r", "--raw", action="store_true", help="raw unpacking, do not decompress MAXPACK files")
	aparse.add_argument("arc_file", help="archive file (.pck)")
	aparse.add_argument("file_path", help="destination folder (extract) OR fileList.txt (create)")

	config = aparse.parse_args(argv[1:])
	config.arc_file = pathlib.Path(config.arc_file)
	config.file_path = pathlib.Path(config.file_path)

	if config.extract:
		return arc_extract(config)
	elif config.create:
		return arc_create(config)
	else:
		print("Please specify a mode!")
		return 1

if __name__ == "__main__":
	sys.exit(main(sys.argv))
