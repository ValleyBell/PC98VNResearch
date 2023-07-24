#!/usr/bin/env python3
# "Merry Go Round" Archive (Un-)Packer
# Written by Valley Bell, 2023-07-24
import sys
import os
import argparse
import struct
import pathlib

"""
Merry Go Round Archive Format
-----------------------------
Each archive consists of two files:
- DISK#.NDX - index file
- DISK#.LIB - library file

LIB files contain the file data. They have no header.
NDX files consist of a list of file entries and have no header either.

file TOC entry:
0Dh bytes - file title (null-terminated string)
4 bytes - file offset in LIB file
4 bytes - file size
-> 15h bytes

Notes:
- All values are stored in Little Endian.
- OVL files are LZSS-compressed and begin with a 2-byte value indicating the decompressed file size.
  The compressed data follows right after that.
  All other files are uncompressed.

"""

def arc_extract(config):
	ndxpath = config.arc_file.with_suffix(".NDX")
	libpath = config.arc_file.with_suffix(".LIB")
	basepath = config.file_path

	with ndxpath.open("rb") as fNdx:
		# get TOC
		tocData = fNdx.read()
		fileCount = len(tocData) // 0x15

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

	with libpath.open("rb") as fLib:
		basepath.mkdir(parents=True, exist_ok=True)
		with (config.file_path / "_fileList.txt").open("wt") as fTxt:
			fTxt.write("#filename\n")

			for (fileID, tocEntry) in enumerate(fileToc):
				(fTitle, fpos, flen) = tocEntry
				print(f"File {1 + fileID:3}: {fTitle:12}- pos 0x{fpos:06X}, len 0x{flen:04X}")
				with (basepath / fTitle).open("wb") as fOut:
					fTxt.write(f"{fTitle}\n")
					fLib.seek(fpos)
					fOut.write(fLib.read(flen))

	print("Done.")
	return 0

def arc_create(config):
	ndxpath = config.arc_file.with_suffix(".NDX")
	libpath = config.arc_file.with_suffix(".LIB")
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
	tocData = bytearray(len(fileToc) * 0x15)

	tocPos = 0x00
	filePos = 0x00
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

	with ndxpath.open("wb") as fNdx:
		fNdx.write(tocData)

	with libpath.open("wb") as fLib:
		for fInfo in fileToc:
			inputPath = basepath / fInfo[0]
			with inputPath.open("rb") as fIn:
				fLib.seek(fInfo[1])
				fLib.write(fIn.read(fInfo[2]))

	print("Done.")
	return 0

def main(argv):
	print("Merry Go Round Archive (Un-)Packer")
	aparse = argparse.ArgumentParser()
	apgrp = aparse.add_mutually_exclusive_group(required=True)
	apgrp.add_argument("-x", "--extract", action="store_true", help="extract archive")
	apgrp.add_argument("-c", "--create", action="store_true", help="create archive (specify file_list.txt)")
	aparse.add_argument("arc_file", help="archive file (extension is ignored)")
	aparse.add_argument("file_path", help="destination folder (extract) OR file_list.txt (create)")

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
