#!/usr/bin/env python3
# System-98 (four-nine/Izuho Saruta) Archive (Un-)Packer
# Written by Valley Bell, 2025-06-06
import sys
import argparse
import struct
import pathlib
import lzss0	# needs "lzss0" pip package

"""
System-98 CAT/LIB Archive Format
--------------------------------
Each archive consists of two files:
- DISK_#.CAT - index file
- DISK_#.LIB - library file

LIB files contain the file data.
CAT files consist of a list of file entries.

CAT File
--------
4 bytes - signature (either "Cat0" or "Cat1")
2 bytes - file count fc
?? bytes - TOC entries
        Note:
        - For "Cat0" files, this is exactly fc*16h bytes large.
        - For "Cat1" files, this part is LZSS-compressed and decompresses to fc*16h bytes. There is no compression header.

TOC Entry:
0Ch bytes - file name (padded with spaces)
2 bytes - flags
        Bit 0 (0001h) - file data is LZSS-compressed
4 bytes - file offset in LIB file (excludes file header, so it is relative to LIB file offset 06h)
4 bytes - data size (size in LIB file, i.e. size of compressed data for compressed files)
-> 16h bytes

LIB File
--------
4 bytes - signature "Lib0"
2 bytes - file count
?? bytes - file data
        Note: For LZSS-compressed files, the first 4 bytes specify the size of the decompressed data.
              After that, the LZSS-compressed data begins.

Notes:
- All values are stored in Little Endian.
- The file headers are uncompressed. But the CAT file TOC and the actual file data *may* be LZSS-compressed.
  The LZSS nametable is initialized with all 00s.
"""

def Decompress(cmpdata: bytes, maxsize: int) -> bytes:
	nameTable = [0] * 0x1000
	nameTblOfs = 1
	repeat_mask = 0
	check_bit = 0
	
	inpos = 0
	outpos = 0
	decdata = [0] * maxsize
	try:
		while True:
			check_bit *= 2
			check_bit &= 0xFF
			if check_bit == 0:
				repeat_mask = cmpdata[inpos];	inpos += 1
				check_bit = 1
			if (repeat_mask & check_bit) != 0:
				al = cmpdata[inpos];	inpos += 1
				decdata[outpos] = al;		outpos += 1
				nameTable[nameTblOfs] = al
				nameTblOfs += 1
				nameTblOfs &= 0xFFF
			else:
				# loc_10A63
				bl_i = cmpdata[inpos];	inpos += 1
				bh_j = cmpdata[inpos];	inpos += 1
				# loc_10AAB
				bx = (bh_j << 8) | (bl_i << 0)
				if bx == 0:
					break
				cx = (bl_i & 0x0F) + 3
				rep_ofs = bx >> 4
				
				# loc_10AC3
				for i in range(cx):
					al = nameTable[(rep_ofs + i) & 0xFFF]
					decdata[outpos] = al;	outpos += 1
					nameTable[nameTblOfs] = al
					nameTblOfs = (nameTblOfs + 1) & 0xFFF
				input()
	except Exception as e:
		print(e)
		print(inpos)
		print(outpos)
	
	return bytes(decdata)

def arc_extract(config):
	catpath = config.arc_file.with_suffix(".CAT")
	libpath = config.arc_file.with_suffix(".LIB")
	basepath = config.file_path

	with catpath.open("rb") as fCat:
		# read header
		hdr = fCat.read(6)
		# TODO: support "Cat0" (Is this just uncompressed?)
		if hdr[0:4] != b"Cat1":
			print(f"Not a System-98 CAT file: {catpath}", file=sys.stderr)
			return 1
		catType = hdr[3] - ord('0')
		fileCount = struct.unpack_from("<H", hdr, 0x04)[0]
		
		print("CAT Header: {}, files: {}".format("compressed" if catType else "uncompressed", fileCount))
		if catType:
			tocData = fCat.read()
			tocData = Decompress(tocData, fileCount * 0x16)
			#tocData = lzss0.decompress(tocData, fileCount * 0x16, ini=0x00)
		else:
			# Is this right?
			tocData = fCat.read(fileCount * 0x16)
		cattoc_path = catpath.with_suffix(".TOC")
		with cattoc_path.open("wb") as f:
			f.write(tocData)
		
		# parse TOC
		fileToc = []
		tocpos = 0x00
		for curFile in range(fileCount):
			fname_b = tocData[tocpos+0x00 : tocpos+0x0C]
			if b'\x00' in fname_b:
				fname_b = fname_b[: fname_b.find(b'\x00')]
			fname_b = fname_b.rstrip(b' ')	# strip trailing spaces
			fname_s = fname_b.decode("Shift-JIS")
			(flags, flen, fpos) = struct.unpack_from("<HII", tocData, tocpos+0x0C)
			fileToc.append([fname_s, fpos, flen, flags])
			tocpos += 0x16

	with libpath.open("rb") as fLib:
		hdr = fLib.read(6)
		if hdr[0:4] != b"Lib0":
			print(f"Not a System-98 LIB file: {libpath}", file=sys.stderr)
			return 1
		libFileCount = struct.unpack_from("<H", hdr, 0x04)[0]
		if fileCount != libFileCount:
			print(f"File count mismatch! {catpath.name}: {fileCount}, {libpath.name}: {libFileCount}")
			return 2
		
		basepath.mkdir(parents=True, exist_ok=True)
		with (config.file_path / "_fileList.txt").open("wt") as fTxt:
			fTxt.write("#filename\tflags\n")
			fTxt.write(f":CATTYPE\t{catType}\n")

			for (fileID, tocEntry) in enumerate(fileToc):
				(fTitle, fpos, flen, flags) = tocEntry
				print(f"File {1 + fileID:3}: {fTitle:12} - flags 0x{flags:02X}, pos 0x{fpos:06X}, len 0x{flen:04X}")
				with (basepath / fTitle).open("wb") as fOut:
					fTxt.write(f"{fTitle}\t{flags:04X}\n")
					fLib.seek(0x06 + fpos)
					fdata = fLib.read(flen)
					if (flags & 0x0001):
						dec_size = struct.unpack_from("<I", fdata, 0)[0]	# 4-byte Little Endian, decompressed size
						fdata = Decompress(fdata[4:], dec_size)
						#fdata = lzss0.decompress(fdata[4:], dec_size, ini=0x00)
					fOut.write(fdata)

	print("Done.")
	return 0

def arc_create(config):
	catpath = config.arc_file.with_suffix(".CAT")
	libpath = config.arc_file.with_suffix(".LIB")
	basepath = config.file_path.parent

	fileToc = []
	catType = 1
	with config.file_path.open("rt") as fTxt:
		for (lid, line) in enumerate(fTxt):
			line = line.strip()
			if len(line) == 0 or line.startswith('#'):
				continue	# ignore empty lines and comments
			litems = line.split('\t')
			if len(litems) < 1:
				continue

			if litems[0].startswith(':'):
				cmd = litems[0][1:].casefold()
				if cmd == "cattype":
					catType = int(litems[1], 0)
				continue
			# [file name, flags, pos, len]
			fileToc.append([litems[0], int(litems[1], 0x10), -1, -1])

	print("Packing {} {} ...".format(len(fileToc), "file" if len(fileToc) == 1 else "files"), flush=True)

	fileCount = len(fileToc)
	hdrData = bytearray(6)
	struct.pack_into("<H", hdrData, 0x04, fileCount)

	tocData = bytearray(fileCount * 0x16)
	tocPos = 0x00
	with libpath.open("wb") as fLib:
		# Write LIB data and generate TOC while doing so.
		# (Usually I'd create the TOC first, but due to the compression I can not precalculate file offsets.)
		hdrData[0:4] = b"Lib0"
		
		fLib.write(hdrData)
		filePos = 0x00	# Note: The file offset *excludes* the 6-byte header.
		for fInfo in fileToc:
			inputPath = basepath / fInfo[0]

			fname_b = fInfo[0].encode("Shift-JIS")
			if len(fname_b) > 0x0C:
				fname_b = fname_b[0x00:0x0C]
			fname_b = fname_b.ljust(0x0C, b' ')	# pad up to 0x0C bytes

			with inputPath.open("rb") as fIn:
				fdata = fIn.read(fInfo[2])
				if (fInfo[1] & 0x0001):
					fInfo[1] &= ~0x0001	# TODO: LZSS-compress instead
					#cmpdata = fdata
					#fdata = struct.pack("<I", len(fdata)) + cmpdata
				fLib.write(fdata)
			fInfo[2] = filePos
			fInfo[3] = len(fdata)
			filePos += fInfo[3]

			tocData[tocPos+0x00 : tocPos+0x0C] = fname_b
			struct.pack_into("<HII", tocData, tocPos+0x0C, fInfo[1], fInfo[2], fInfo[3])
			tocPos += 0x16

	with catpath.open("wb") as fCat:
		if catType == 1:
			print("TODO: compression")
			catType = 0
		hdrData[0:3] = b"Cat"
		hdrData[3] = ord('0') + catType
		fCat.write(hdrData)
		fCat.write(tocData)

	print("Done.")
	return 0

def main(argv):
	print("System-98 (four-nine/Izuho Saruta) Archive (Un-)Packer")
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
