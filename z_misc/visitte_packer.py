#!/usr/bin/env python3
# "Visitte" Archive (Un-)Packer
# Written by Valley Bell, 2023-07-24
import sys
import os
import argparse
import struct
import pathlib

"""
Visitte Archive Format (DISK#.LBX)
----------------------
2 bytes - number of files
n*15h bytes - file TOC entries
?? bytes - ddata

file TOC entry:
0Dh bytes - file title (null-terminated string)
4 bytes - file offset in LIB file
4 bytes - file size
-> 15h bytes

Notes:
- All values are stored in Little Endian.
- All files are uncompressed - even OVL files. (unlike Merry Go Round)

Visitte Disk Table Format (DISK.TBL)
-------------------------
2 bytes - number of files (Little Endian)
n*0Eh bytes - file TOC entries

file TOC entry:
0Dh bytes - file title (null-terminated string)
1 bytes - disk ID (0 = DISK1, 1 = DISK2, etc.)
-> 0Eh bytes

"""

# Note: I noticed that the DISK.TBL from the game does NOT list all files from the DISK#.LBX archives.
#       In addition, the order is slightly different.
#       So I decided to just recreate DISK.TBL from a separate text file instead of automatically
#       creating the file list from existing archives.

def arc_extract(config):
	basepath = config.file_path

	with config.arc_file.open("rb") as fArc:
		# get TOC
		fileCount = struct.unpack("<H", fArc.read(0x02))[0]
		tocData = fArc.read(fileCount * 0x15)

		# parse TOC
		fileToc = []
		tocpos = 0x00
		for curFile in range(fileCount):
			fname_b = tocData[tocpos+0x00 : tocpos+0x0D]
			if b'\x00' in fname_b:
				fname_b = fname_b[: fname_b.find(b'\x00')]
			fname_s = fname_b.decode("Shift-JIS")
			(fpos, flen) = struct.unpack_from("<II", tocData, tocpos+0x0D)
			fileToc.append([fname_s, fpos, flen])
			tocpos += 0x15

		basepath.mkdir(parents=True, exist_ok=True)
		with (config.file_path / "_fileList.txt").open("wt") as fTxt:
			fTxt.write("#filename\n")

			for (fileID, tocEntry) in enumerate(fileToc):
				(fTitle, fpos, flen) = tocEntry
				print(f"File {1 + fileID:3}: {fTitle:12}- pos 0x{fpos:06X}, len 0x{flen:04X}")
				with (basepath / fTitle).open("wb") as fOut:
					fTxt.write(f"{fTitle}\n")
					fArc.seek(fpos)
					fOut.write(fArc.read(flen))

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
			if len(litems) < 1:
				continue

			fileToc.append([litems[0], -1, -1])

	print("Packing {} {} ...".format(len(fileToc), "file" if len(fileToc) == 1 else "files"), flush=True)
	# go through all files, determining file sizes and archive file data offsets
	tocData = bytearray(0x02 + len(fileToc) * 0x15)

	struct.pack_into("<H", tocData, 0x00, len(fileToc))
	tocPos = 0x02
	filePos = len(tocData)
	for fInfo in fileToc:
		inputPath = basepath / fInfo[0]
		fInfo[1] = filePos
		fInfo[2] = os.path.getsize(inputPath)
		filePos += fInfo[2]

		fname_b = fInfo[0].encode("Shift-JIS")
		if len(fname_b) > 0x0C:
			fname_b = fname_b[0x00:0x0C]
		fname_b = fname_b.ljust(0x0D, b'\x00')	# pad up to 0x0D bytes

		tocData[tocPos+0x00 : tocPos+0x0D] = fname_b
		struct.pack_into("<II", tocData, tocPos+0x0D, fInfo[1], fInfo[2])
		tocPos += 0x15

	with config.arc_file.open("wb") as fArc:
		fArc.write(tocData)

		for fInfo in fileToc:
			inputPath = basepath / fInfo[0]
			with inputPath.open("rb") as fIn:
				fArc.seek(fInfo[1])
				fArc.write(fIn.read(fInfo[2]))

	print("Done.")
	return 0

def arc_tbldump(config):
	with config.arc_file.open("rb") as fArc:
		# get TOC
		diskCount = struct.unpack("<H", fArc.read(0x02))[0]
		tocData = fArc.read()

		# parse TOC
		fileToc = []
		tocpos = 0x00
		for curFile in range(len(tocData) // 0x0E):
			fname_b = tocData[tocpos+0x00 : tocpos+0x0D]
			if b'\x00' in fname_b:
				fname_b = fname_b[: fname_b.find(b'\x00')]
			fname_s = fname_b.decode("Shift-JIS")
			diskID = tocData[tocpos+0x0D]
			fileToc.append([fname_s, diskID])
			tocpos += 0x0E

	with config.file_path.open("wt") as fTxt:
		fTxt.write("#filename\tdiskID\n")
		fTxt.write(f":DISKCNT\t{diskCount}\n")

		for tocEntry in fileToc:
			(fTitle, diskID) = tocEntry
			fTxt.write(f"{fTitle}\t{diskID}\n")

	print("Done.")
	return 0

def arc_tblcreate(config):
	fileToc = []
	diskCount = 0
	with config.file_path.open("rt") as fTxt:
		for (lid, line) in enumerate(fTxt):
			line = line.strip()
			if len(line) == 0 or line.startswith('#'):
				continue	# ignore empty lines and comments
			litems = line.split('\t')
			if len(litems) < 2:
				continue

			if litems[0].startswith(':'):
				cmd = litems[0][1:].casefold()
				if cmd == "diskcnt":
					diskCount = int(litems[1], 10)
			else:
				fileToc.append([litems[0], int(litems[1], 10)])

	tocData = bytearray(0x02 + len(fileToc) * 0x0E)

	struct.pack_into("<H", tocData, 0x00, diskCount)
	tocPos = 0x02
	filePos = len(tocData)
	for fInfo in fileToc:
		fname_b = fInfo[0].encode("Shift-JIS")
		if len(fname_b) > 0x0C:
			fname_b = fname_b[0x00:0x0C]
		fname_b = fname_b.ljust(0x0D, b'\x00')	# pad up to 0x0D bytes

		tocData[tocPos+0x00 : tocPos+0x0D] = fname_b
		tocData[tocPos+0x0D] = fInfo[1]
		tocPos += 0x0E

	with config.arc_file.open("wb") as fArc:
		fArc.write(tocData)

	print("Done.")
	return 1

def main(argv):
	print("Visitte Archive (Un-)Packer")
	aparse = argparse.ArgumentParser()
	apgrp = aparse.add_mutually_exclusive_group(required=True)
	apgrp.add_argument("-x", "--extract", action="store_true", help="extract archive (specify destination folder)")
	apgrp.add_argument("-c", "--create", action="store_true", help="create archive (specify file_list.txt)")
	apgrp.add_argument("-d", "--tbl-dump", action="store_true", help="dump TBL file list (specify file_list.txt)")
	apgrp.add_argument("-t", "--tbl-create", action="store_true", help="create TBL file (specify file_list.txt)")
	aparse.add_argument("arc_file", help="archive file")
	aparse.add_argument("file_path", help="destination folder (extract) OR file_list.txt (create)")

	config = aparse.parse_args(argv[1:])
	config.arc_file = pathlib.Path(config.arc_file)
	config.file_path = pathlib.Path(config.file_path)

	if config.extract:
		return arc_extract(config)
	elif config.create:
		return arc_create(config)
	elif config.tbl_dump:
		return arc_tbldump(config)
	elif config.tbl_create:
		return arc_tblcreate(config)
	else:
		print("Please specify a mode!")
		return 1

if __name__ == "__main__":
	sys.exit(main(sys.argv))
