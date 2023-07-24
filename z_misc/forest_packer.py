#!/usr/bin/env python3
# Forest FA1 Archive (Un-)Packer
# Written by Valley Bell, 2023-07-17
import sys
import os
import argparse
import struct
import pathlib

"""
Forest FA1 Archive Format
-------------------------
Main header:
4 bytes - signature "FA1" + 00h
4 bytes - End of Data offset
2 bytes - number of files stored in the TOC
1 byte  - disk ID (00=A, 01=B, etc)
1 byte  - flags
        bit 7 (80): encrypted TOC (0 = no, 1 = encrypted using "XOR 0FFh")

The file TOC is stored at the end of the file.
You have to go to the "end of data" offset and then round up to 0x400 bytes.
It consists of N entries (see main header).

file TOC entry:
8 bytes - file title (padded with spaces)
3 bytes - file extension (padded with spaces)
1 byte  - flags
        bit 0 (01): compressed (0 = no, 1 = yes)
4 bytes - file size, compressed (effective data length in the archive)
4 bytes - file size, decompressed size (same as compressed file size, when no compression is used)
-> 14h bytes

Notes:
- All values are stored in Little Endian.
- FAD.BIN must be the first file in the archive (start offset 0x0C) AND it must be
  uncompressed, as the starter COM executable will jump directly to offset 0x0C.
- Files are stored consecutively in the archive (starting at offset 0x0C).
  The TOC contains only file lengths: The actual file start offsets have to be
  calculated by summing all the "file size, compressed" values.
- Files are padded to 2-byte boundaries. i.e. when a file is 5 bytes long, it will
  take up 6 bytes in the archive.
- The compression appears to be some sort of LZSS with 16-bit control words and
  no pre-initialized dictionary.

Games tested:
- Kuro no Ken (Blade of Darkness)
- Hop Step Jump
- Marginal Storys
- Ningyou Tsukai 2

"""

def arc_extract(config):
	basepath = config.file_path

	with config.arc_file.open("rb") as fArc:
		fArc.seek(0, os.SEEK_END)
		arcSize = fArc.tell()
		fArc.seek(0, os.SEEK_SET)

		hdrData = fArc.read(0x0C)
		if hdrData[0:3] != b"FA1":	# The games only check the first 3 letters.
			print("Invalid archive format!")
			return 1
		(eofOfs, fileCount, diskID, hdrFlags) = struct.unpack_from("<IHBB", hdrData, 0x04)
		dataPos = fArc.tell()

		# get + decrypt TOC
		tocOfs = (eofOfs + 0x3FF) & ~0x3FF	# round up to 0x400 bytes
		fArc.seek(tocOfs)
		tocData = fArc.read(fileCount * 0x14)
		if hdrFlags & 0x80:
			tocData = bytes([x ^ 0xFF for x in tocData])

		# parse TOC
		fileToc = []
		fpos = dataPos
		tocpos = 0x00
		for curFile in range(fileCount):
			ftitle_b = tocData[tocpos+0x00 : tocpos+0x08].rstrip(b' ')
			fext_b = tocData[tocpos+0x08 : tocpos+0x0B].rstrip(b' ')
			fname_b = ftitle_b if len(fext_b) == 0 else ftitle_b + b'.' + fext_b
			fname_s = bytes(fname_b).decode("Shift-JIS")
			(flen1, flen2) = struct.unpack_from("<II", tocData, tocpos+0x0C)
			fileToc.append([fname_s, tocData[tocpos+0x0B], fpos, flen1, flen2])
			tocpos += 0x14
			fpos += flen1
			if flen1 & 0x01:
				fpos += 0x01	# There is padding of 2-byte words between files.
		endpos = fpos

		basepath.mkdir(parents=True, exist_ok=True)
		with (config.file_path / "_fileList.txt").open("wt") as fTxt:
			fTxt.write("#filename\tflags\n")
			fTxt.write(f":DISK\t{diskID}\n")
			fTxt.write(f":FLAGS\t{hdrFlags:02X}\n")

			for (fileID, tocEntry) in enumerate(fileToc):
				(fTitle, flags, fpos, flen1, flen2) = tocEntry
				print(f"File {1 + fileID:3}: {fTitle:12} - flags 0x{flags:02X}, pos 0x{fpos:06X}, len1 0x{flen1:04X}, len2 0x{flen2:04X}")
				with (basepath / fTitle).open("wb") as fOut:
					fTxt.write(f"{fTitle}\t{flags:02X}\t{flen1:04X}\t{flen2:04X}\n")
					fArc.seek(fpos)
					fOut.write(fArc.read(flen1))
		flen1_total = sum([te[3] for te in fileToc])
		compr_total = sum([1 for te in fileToc if te[1] & 0x01])

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
			if len(litems) < 2:
				continue

			if litems[0].startswith(':'):
				cmd = litems[0][1:].casefold()
				if cmd == "disk":
					diskID = int(litems[1], 10)
				elif cmd == "flags":
					hdrFlags = int(litems[1], 0x10)
			else:
				flen1 = -1 if len(litems) < 3 else int(litems[2], 0x10)
				flen2 = -1 if len(litems) < 3 else int(litems[3], 0x10)
				fileToc.append([litems[0], int(litems[1], 0x10), -1, flen1, flen2])

	print("Packing {} {} ...".format(len(fileToc), "file" if len(fileToc) == 1 else "files"), flush=True)
	# go through all files, determining archive file data offsets
	tocData = bytearray(len(fileToc) * 0x14)
	tocPos = 0x00
	filePos = 0x0C
	for fInfo in fileToc:
		inputPath = basepath / fInfo[0]
		fInfo[2] = filePos
		fInfo[3] = os.path.getsize(inputPath)
		filePos += fInfo[3]
		if fInfo[3] & 0x01:
			filePos += 0x01	# There is padding of 2-byte words between files.

		fname_s = os.path.basename(fInfo[0])
		fname_b = fname_s.encode("Shift-JIS")
		if b'.' in fname_b:
			(ftitle_b, fext_b) = fname_b.rsplit(b'.', 1)
		else:
			ftitle_b = fname_b
			fext_b = b""
		ftitle_b = ftitle_b[:8].ljust(8, b' ')	# space-pad up to 8 character
		fext_b = fext_b[:3].ljust(3, b' ')

		tocData[tocPos+0x00 : tocPos+0x08] = ftitle_b
		tocData[tocPos+0x08 : tocPos+0x0B] = fext_b
		tocData[tocPos+0x0B] = fInfo[1]
		struct.pack_into("<BII", tocData, tocPos+0x0B, fInfo[1], fInfo[3], fInfo[4])
		tocPos += 0x14
	eofOfs = filePos
	tocOfs = (eofOfs + 0x3FF) & ~0x3FF	# round up to 0x400 bytes

	hdrData = bytearray(0x0C)
	hdrData[0:4] = b"FA1\x00"
	struct.pack_into("<IHBB", hdrData, 0x04, eofOfs, len(fileToc), diskID, hdrFlags)
	if hdrFlags & 0x80:
		tocData = bytes([x ^ 0xFF for x in tocData])	# apply TOC encryption

	with config.arc_file.open("wb") as fArc:
		fArc.write(hdrData)

		for fInfo in fileToc:
			inputPath = basepath / fInfo[0]
			with inputPath.open("rb") as fIn:
				fArc.seek(fInfo[2])
				fArc.write(fIn.read(fInfo[3]))

		fArc.seek(tocOfs)
		fArc.write(tocData)

	print("Done.")
	return 0

def main(argv):
	print("Forest FA1 Archive (Un-)Packer")
	aparse = argparse.ArgumentParser()
	apgrp = aparse.add_mutually_exclusive_group(required=True)
	apgrp.add_argument("-x", "--extract", action="store_true", help="extract archive")
	apgrp.add_argument("-c", "--create", action="store_true", help="create archive (specify file_list.txt)")
	aparse.add_argument("arc_file", help="archive file")
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
