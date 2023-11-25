#!/usr/bin/env python3
# Waku Waku Mahjong Panic! 2 Archive (Un-)Packer
# Written by Valley Bell, 2023-11-10
import sys
import os
import argparse
import struct
import pathlib

"""
Waku Waku Mahjong Panic! 2 Archive Format
-----------------------------------------
There is no header. There is a footer instead.

The very last 2-byte word (Little Endian) in the file indicates the size of the footer.
It is unencrypted and indicates how many bytes from the end of the file the footer begins. (i.e. it includes itself)

The footer data is encrypted by XORing every byte with 99h, except for the fields noted as "unencrypted" below.

The footer consists of a number of TOC entries, each 10h bytes large.

The first TOC entry is the header and consists of:
0Bh bytes - "D_Lib " + B4 A9 AA B4 20
2 bytes - number of files (unencrypted)
	This excludes the "D_Lib" and "[[End]]" entries.
3 bytes - 20 0D 0A

The last TOC entry consists of:
0Ch bytes - "[[End]]     "
2 bytes - lower 2 bytes of the end offset of the last file (used for file size calculation of the last file)
2 bytes - footer size (unencrypted)

file TOC entry:
0Ch bytes - file name (null-terminated, padded with spaces after 00 byte)
4 bytes - start offset

"""

def arc_extract(config):
	basepath = config.file_path

	with config.arc_file.open("rb") as fArc:
		fArc.seek(0, os.SEEK_END)
		arcSize = fArc.tell()
		fArc.seek(-2, os.SEEK_END)
		footerLen = struct.unpack("<H", fArc.read(0x02))[0]
		if footerLen < 0x10 or footerLen > arcSize:
			print("Invalid archive format!")
			return 1

		fArc.seek(-footerLen, os.SEEK_END)

		tocData = fArc.read(footerLen)
		fileCount = struct.unpack_from("<H", tocData, 0x0B)[0]	# The value is unencrypted.
		# decrypt TOC
		tocData = bytes([x ^ 0x99 for x in tocData])

		if tocData[0:6] != b"D_Lib ":
			print("Invalid archive format!")
			return 1

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

		# estimate file lengths
		fpos_list = [tocEntry[1] for tocEntry in fileToc] + [arcSize-footerLen]
		for tocEntry in fileToc:
			fpos_start = tocEntry[1]
			fpos_end = [pos for pos in fpos_list if pos > fpos_start][0]
			tocEntry[2] = fpos_end - fpos_start

		basepath.mkdir(parents=True, exist_ok=True)
		#with (config.file_path / "_TOC.bin").open("wb") as fOut:
		#	fOut.write(tocData)
		with (config.file_path / "_fileList.txt").open("wt") as fTxt:
			fTxt.write("#filename\n")

			for (fileID, tocEntry) in enumerate(fileToc):
				(fTitle, fpos, flen) = tocEntry
				print(f"File {1 + fileID:3}: {fTitle:12} - pos 0x{fpos:06X}, len 0x{flen:04X}")
				with (basepath / fTitle).open("wb") as fOut:
					fTxt.write(f"{fTitle}\n")
					fArc.seek(fpos)
					fOut.write(fArc.read(flen))

	print("Done.")
	return 0

def arc_create(config):
	basepath = config.file_path.parent
	fileToc = []
	diskID = 0
	hdrFlags = 0x00
	with config.file_path.open("rt") as fTxt:
		for (lid, line) in enumerate(fTxt):
			line = line.strip()
			if len(line) == 0 or line.startswith('#'):
				continue	# ignore empty lines and comments
			litems = line.split('\t')
			if len(litems) < 1:
				continue

			fileToc.append([litems[0], 0x00, -1, -1])

	print("Packing {} {} ...".format(len(fileToc), "file" if len(fileToc) == 1 else "files"), flush=True)
	# go through all files, determining archive file data offsets
	tocData = bytearray((len(fileToc) + 2) * 0x10)
	tocPos = 0x00
	tocData[tocPos+0x00 : tocPos+0x10] = b"D_Lib " + bytes([0xB4, 0xA9, 0xAA, 0xB4, 0x20, 0x00, 0x00]) + b" \r\n"
	tocPos += 0x10
	filePos = 0x00
	for fInfo in fileToc:
		inputPath = basepath / fInfo[0]
		fInfo[2] = filePos
		fInfo[3] = os.path.getsize(inputPath)
		filePos += fInfo[3]

		fname_s = os.path.basename(fInfo[0])
		fname_b = fname_s.encode("Shift-JIS")
		if len(fname_b) > 0x0C:
			fname_b = fname_b[0x00:0x0C]
		if len(fname_b) < 0x0C:
			fname_b += b'\x00'	# add null-terminator
		fname_b = fname_b.ljust(0x0C, b' ')	# and then add padding using spaces

		tocData[tocPos+0x00 : tocPos+0x0C] = fname_b
		struct.pack_into("<I", tocData, tocPos+0x0C, fInfo[2])
		tocPos += 0x10
	tocData[tocPos+0x00 : tocPos+0x0C] = b"[[End]]     "
	struct.pack_into("<I", tocData, tocPos+0x0C, filePos)

	# encrypt TOC
	tocData = bytearray([x ^ 0x99 for x in tocData])	# apply TOC encryption

	# write unencrypted values
	struct.pack_into("<H", tocData, 0x0B, len(fileToc))
	struct.pack_into("<H", tocData, tocPos+0x0E, len(tocData))
	tocPos += 0x10

	with config.arc_file.open("wb") as fArc:
		for fInfo in fileToc:
			inputPath = basepath / fInfo[0]
			with inputPath.open("rb") as fIn:
				fArc.seek(fInfo[2])
				fArc.write(fIn.read(fInfo[3]))

		fArc.write(tocData)

	print("Done.")
	return 0

def main(argv):
	print("Waku Waku Mahjong Panic! 2 Archive (Un-)Packer")
	aparse = argparse.ArgumentParser()
	apgrp = aparse.add_mutually_exclusive_group(required=True)
	apgrp.add_argument("-x", "--extract", action="store_true", help="extract archive")
	apgrp.add_argument("-c", "--create", action="store_true", help="create archive (specify fileList.txt)")
	aparse.add_argument("arc_file", help="archive file")
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
