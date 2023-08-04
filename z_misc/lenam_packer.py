#!/usr/bin/env python3
# "Lenam: Sword of Legend" Archive (Un-)Packer
# Written by Valley Bell, 2023-07-16
import sys
import os
import argparse
import struct
import pathlib

"""
Lenam: Sword of Legend Archive Format
-------------------------------------
1200h bytes - file TOC (100h file entries)
?? bytes - data

File Entry:
0Eh bytes - file name (null-terminated string)
4 bytes - start offset (absolute, Little Endian)
-> 12h bytes

Notes:
- All values are stored in Little Endian.
- The files *may* be compressed. This apparently depends on the type of the stored file.
  In that case they begin with a 4-byte value containing the length of the compressed data.
  The compression algorithm is LZSS. The dictionary appears to be initialized with spaces. (TODO: verify)

Known uncompressed:
- NVFILE.BIN
- SWORDBIN
- *.DFM
- *.FNT
- *.MDI

Known compressed:
- most files without extension
- *.MSG
- *.MSK

"""

ARC_TOC_FILE_COUNT = 0x100

def arc_extract(config):
	basepath = config.file_path

	with config.arc_file.open("rb") as fArc:
		fArc.seek(0, os.SEEK_END)
		arcSize = fArc.tell()
		fArc.seek(0, os.SEEK_SET)

		fileCount = ARC_TOC_FILE_COUNT
		fileToc = []
		# read TOC
		for curFile in range(fileCount):
			entryData = fArc.read(0x12)
			if entryData[0x00] == 0x00:
				break
			fname_b = entryData[0x00 : 0x0E]
			if b'\x00' in fname_b:
				fname_b = fname_b[: fname_b.find(b'\x00')]
			fname_s = fname_b.decode("Shift-JIS")
			fpos = struct.unpack_from("<I", entryData, 0x0E)[0]
			fileToc.append([fname_s, fpos, 0])

		# estimate file lengths
		fpos_list = [tocEntry[1] for tocEntry in fileToc] + [arcSize]
		for tocEntry in fileToc:
			fpos_start = tocEntry[1]
			fpos_end = [pos for pos in fpos_list if pos > fpos_start][0]
			tocEntry[2] = fpos_end - fpos_start

		basepath.mkdir(parents=True, exist_ok=True)
		with (config.file_path / "_fileList.txt").open("wt") as fTxt:
			fTxt.write("#filename\tflags\n")

			for (fileID, tocEntry) in enumerate(fileToc):
				(fTitle, fpos, flen) = tocEntry
				print(f"File {1 + fileID:3}: {fTitle:12}- pos 0x{fpos:06X}, len 0x{flen:04X}")
				with (basepath / fTitle).open("wb") as fOut:
					fArc.seek(fpos)
					compr_len = struct.unpack("<I", fArc.read(0x04))[0]
					if compr_len == (flen - 0x04):
						flags = 0x01
					else:
						flags = 0x00
					fTxt.write(f"{fTitle}\t{flags:02X}\n")
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
			if len(litems) < 2:
				continue

			fileToc.append([litems[0], int(litems[1], 0x10), -1, -1])
	if len(fileToc) > ARC_TOC_FILE_COUNT:
		print(f"Warning! File list contains {len(fileToc)} files, but only {ARC_TOC_FILE_COUNT} can be stored!")
		fileToc = fileToc[0:ARC_TOC_FILE_COUNT]

	print("Packing {} {} ...".format(len(fileToc), "file" if len(fileToc) == 1 else "files"), flush=True)
	# go through all files, determining file sizes and archive file data offsets
	tocData = bytearray(ARC_TOC_FILE_COUNT * 0x12)

	tocPos = 0x00
	filePos = len(tocData)
	for fInfo in fileToc:
		inputPath = basepath / fInfo[0]
		fInfo[2] = filePos
		fInfo[3] = os.path.getsize(inputPath)
		filePos += fInfo[3]

		fname_b = fInfo[0].encode("Shift-JIS")
		if len(fname_b) > 0x0D:
			fname_b = fname_b[0x00:0x0D]
		fname_b = fname_b.ljust(0x0E, b'\x00')	# pad up to 0x0E bytes

		tocData[tocPos+0x00 : tocPos+0x0E] = fname_b
		struct.pack_into("<I", tocData, tocPos+0x0E, fInfo[2])
		tocPos += 0x12
	fileEndOfs = filePos

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
	print("Lenam Archive (Un-)Packer")
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
