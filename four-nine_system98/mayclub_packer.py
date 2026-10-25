#!/usr/bin/env python3
# May Club (Windows 95 version) Archive (Un-)Packer
# Written by Valley Bell, 2026-03-24
import sys
import os
import argparse
import struct
import pathlib

"""
May Club Win95 LST/DAT Archive Format
--------------------------------
Each archive consists of two files:
- MAY0.LST - list file (contains archive TOC)
- MAY0.DAT - data file

DAT files contain the file data.
LST files consist of a list of file entries.

LST File
--------
Unlike the archive format from "Waku Waku Mahjong Panic! 2", which uses the same TOC format, the list file in May Club is unencrypted.

The file consists of (n+2) of TOC entries, each 10h bytes large.
1 TOC entry: header
n TOC entries: file entries
1 TOC entry: footer

header TOC entry:
0Bh bytes - "D_Lib -02- "
2 bytes - number of files (n)
        This excludes the "D_Lib" and "[[End]]" entries.
3 bytes - 20 0D 0A

file TOC entry:
0Ch bytes - file name (null-terminated, padded with spaces after 00 byte)
4 bytes - start offset

footer TOC entry:
0Ch bytes - "[[End]]     "
4 bytes - end offset of the last file (used for file size calculation of the last file)

DAT File
--------
This files contains all data referenced by the LST file.
It is just all data stored after each other.

Notes:
- All values are stored in Little Endian.
- Everything is stored uncompressed and unencrypted.
"""

def arc_extract(config):
	lstpath = config.arc_file.with_suffix(".LST")
	datpath = config.arc_file.with_suffix(".DAT")
	basepath = config.file_path

	with lstpath.open("rb") as fLst:
		# read header
		hdr = fLst.read(0x10)
		if hdr[0:0x0B] != b"D_Lib -02- ":
			print(f"Not a May Club LST file: {lstpath}", file=sys.stderr)
			return 1
		fileCount = struct.unpack_from("<H", hdr, 0x0B)[0]
		fLst.seek(0)
		
		tocData = fLst.read()
		
		# parse TOC
		fileToc = []
		tocpos = 0x10	# skip header entry
		for curFile in range(fileCount):
			fname_b = tocData[tocpos+0x00 : tocpos+0x0C]
			if b'\x00' in fname_b:
				fname_b = fname_b[: fname_b.find(b'\x00')]
			fname_s = fname_b.decode("Shift-JIS")
			fpos = struct.unpack_from("<I", tocData, tocpos+0x0C)[0]
			fileToc.append([fname_s, fpos, 0])
			tocpos += 0x10
		arcSize = struct.unpack_from("<I", tocData, tocpos+0x0C)[0]

		# estimate file lengths
		fpos_list = [tocEntry[1] for tocEntry in fileToc] + [arcSize]
		for tocEntry in fileToc:
			fpos_start = tocEntry[1]
			fpos_end = [pos for pos in fpos_list if pos > fpos_start][0]
			tocEntry[2] = fpos_end - fpos_start

	with datpath.open("rb") as fDat:
		basepath.mkdir(parents=True, exist_ok=True)
		with (config.file_path / "_fileList.txt").open("wt") as fTxt:
			fTxt.write("#filename\n")

			for (fileID, tocEntry) in enumerate(fileToc):
				(fTitle, fpos, flen) = tocEntry
				print(f"File {1 + fileID:3}: {fTitle:12} - pos 0x{fpos:06X}, len 0x{flen:04X}")
				with (basepath / fTitle).open("wb") as fOut:
					fTxt.write(f"{fTitle}\n")
					fDat.seek(fpos)
					fOut.write(fDat.read(flen))

	print("Done.")
	return 0

def arc_create(config):
	lstpath = config.arc_file.with_suffix(".LST")
	datpath = config.arc_file.with_suffix(".DAT")
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

			# [file name, flags, pos, len]
			fileToc.append([litems[0], 0x00, -1, -1])

	fileCount = len(fileToc)
	print("Packing {} {} ...".format(fileCount, "file" if fileCount == 1 else "files"), flush=True)

	tocData = bytearray((fileCount + 2) * 0x10)
	tocPos = 0x00
	with datpath.open("wb") as fDat:
		# generate list file header
		tocData[tocPos+0x00 : tocPos+0x10] = b"D_Lib -02-    \r\n"
		tocPos += 0x10

		filePos = 0x00
		for fInfo in fileToc:
			inputPath = basepath / fInfo[0]

			fname_s = os.path.basename(fInfo[0])
			fname_b = fname_s.encode("Shift-JIS")
			if len(fname_b) > 0x0C:
				fname_b = fname_b[0x00:0x0C]
			if len(fname_b) < 0x0C:
				fname_b += b'\x00'	# add null-terminator
			fname_b = fname_b.ljust(0x0C, b' ')	# and then add padding using spaces

			with inputPath.open("rb") as fIn:
				fdata = fIn.read(fInfo[2])
				fDat.write(fdata)
			fInfo[2] = filePos
			fInfo[3] = len(fdata)
			filePos += fInfo[3]

			tocData[tocPos+0x00 : tocPos+0x0C] = fname_b
			struct.pack_into("<I", tocData, tocPos+0x0C, fInfo[2])
			tocPos += 0x10

		# generate list file footer
		tocData[tocPos+0x00 : tocPos+0x0C] = b"[[End]]     "
		struct.pack_into("<I", tocData, tocPos+0x0C, filePos)

		# set file count
		struct.pack_into("<H", tocData, 0x0B, fileCount)

		# append file terminators
		fDat.write(bytes([1]))
		tocData += b'\x1A'

	with lstpath.open("wb") as fLst:
		fLst.write(tocData)

	print("Done.")
	return 0

def main(argv):
	print("May Club Win95 Archive (Un-)Packer")
	aparse = argparse.ArgumentParser()
	apgrp = aparse.add_mutually_exclusive_group(required=True)
	apgrp.add_argument("-x", "--extract", action="store_true", help="extract archive")
	apgrp.add_argument("-c", "--create", action="store_true", help="create archive (specify fileList.txt)")
	aparse.add_argument("arc_file", help="archive file (extension is ignored)")
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
