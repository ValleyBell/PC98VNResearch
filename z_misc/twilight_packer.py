#!/usr/bin/env python3
# PC-98 Twilight Archive (Un-)Packer
# Written by Valley Bell, 2024-01-06
import sys
import os
import io
import argparse
import struct
import pathlib

"""
Twilight (PC-98) Archive Formats
================================

Twilight uses two (!) files for indexing:
- one that contains archive file names (TWDIR.DIR)
- another one that contains all the offsets of the files stored in the archives (HEADER.DAT)

The order of the archive indexes is the same in both files.
Archives 00h..0Fh are for general data.
Archives 10h..1Fh are for save games.


TWDIR.DIR
=========
overall structure
-----------------
20h*4 bytes - archive info
?? bytes - file names (null-terminated strings)

archive info
------------
1 byte - disk ID
1 byte - may need disk swap (set to 1 for graphics archives, set to 0 for others)
2 bytes - offset of file name (absolute)
-> 4 bytes

Dummy entries usually point to the first file name.


HEADER.DAT
==========
overall structure
-----------------
20h*2 byes - offset of archive TOC
?? bytes - TOC data

This file has only lists of packed files. The actual archive file names are read from TWDIR.DIR.

archive TOC
-----------
This is a list of file entries.
Each TOC may contain up to 256 entries. (verified using a disassembly) However there are usually less entries used.
The only reliable way of detecting the actual TOC size is by detecting where the next TOC begins of the index file ends.

file entry
----------
4 bytes - absolute start offset in archive
4 bytes - data size
-> 8 bytes

When the file size is 0, the entry is assumed to be invalid.


TW*.DAT
-------
These are the archives listed by TWDIR.DIR. They contain all file data, concatenated without padding.
TWSAVE#.DAT contains uncompressed data.
All other archives contain only compressed files.

Layout of compressed files:
4 bytes - size of compressed data (cs)
4 bytes - size of data after decompression
cs bytes - compressed data

Notes:
- All values are stored in Little Endian.
- Unlike many other PC-98 games, this game does NOT use LZSS for compressing data.

"""

ARC_COUNT = 0x20

def arc_extract(config):
	arcs = [{} for i in range(ARC_COUNT)]
	# read archive file names
	print(f"Reading {config.dir_file} ...", flush=True)
	with config.dir_file.open("rb") as fDir:
		tocData = fDir.read()
		for (arcIdx, arc) in enumerate(arcs):
			(diskID, diskMode, fnPos) = struct.unpack_from("<BBH", tocData, arcIdx * 0x04)

			arc["diskID"] = diskID
			arc["diskMode"] = diskMode
			nullPos = tocData.find(b'\x00', fnPos)
			fname_b = tocData[fnPos : nullPos]
			arc["fileName"] = fname_b.decode("Shift-JIS")

	# read archive/file indexes
	print(f"Reading {config.idx_file} ...", flush=True)
	with config.idx_file.open("rb") as fIdx:
		fIdx.seek(0, io.SEEK_END)
		idxFileLen = fIdx.tell()

		tocOfs = []
		fIdx.seek(0)
		tocData = fIdx.read(len(arcs) * 0x02)
		tocOfs = [pos[0] for pos in struct.iter_unpack("<H", tocData)]

		for (arcIdx, arc) in enumerate(arcs):
			tocPos = tocOfs[arcIdx]
			if tocPos == 0 or tocPos >= idxFileLen:
				continue
			tocEndPos = min([pos for pos in ([idxFileLen]+tocOfs) if pos > tocPos])
			fileCount = (tocEndPos - tocPos) // 0x08
			arc["fileCount"] = fileCount

			fIdx.seek(tocPos)
			tocData = fIdx.read(tocEndPos - tocPos)
			fList = []
			for curFile in range(fileCount):
				(fpos, flen) = struct.unpack_from("<II", tocData, curFile * 0x08)
				if flen == 0:
					continue	# verified using disassembly
				fList += [(curFile, fpos, flen)]
			arc["files"] = fList


	# write list of archives
	with (config.file_path / "_arcList.txt").open("wt") as fTxt:
		fTxt.write("#arcID\tdiskID\tdskSwap\tarchive_file\tfileList\n")
		for (arcIdx, arc) in enumerate(arcs):
			if "files" not in arc:
				continue
			basepath = arc["fileName"].replace('.', '_')
			basepath = pathlib.Path(basepath)
			if (config.file_path / basepath).is_file():
				basepath = basepath.with_suffix(".EXT")
			arc["folder"] = basepath
			arc["flist"] = basepath / "_fileList.txt"
			fTxt.write(f"{arcIdx:02X}\t{arc['diskID']:02X}\t{arc['diskMode']:02X}" \
				f"\t{arc['fileName']}\t{arc['flist']}\n")

	# extract archives
	for (arcIdx, arc) in enumerate(arcs):
		if "files" not in arc:
			continue
		arcpath = config.arc_path / arc["fileName"]
		print(f"Archive: {arc['fileName']}", flush=True)

		with arcpath.open("rb") as fArc:
			basepath = arc["folder"]
			basepath.mkdir(parents=True, exist_ok=True)
			with arc["flist"].open("wt") as fTxt:
				fTxt.write("#fileID\tflags\tfilename\n")
				fTxt.write(f":FILES\t{arc['fileCount']:02X}\n")

				# extract files
				for (fileNum, tocEntry) in enumerate(arc["files"]):
					(fileID, fpos, flen) = tocEntry
					print(f"File {1 + fileNum:3}: ID 0x{fileID:02X}, pos 0x{fpos:06X}, len 0x{flen:06X}")
					fTitle = f"{fileID:02X}.BIN"
					with (basepath / fTitle).open("wb") as fOut:
						fArc.seek(fpos)
						compr_len = struct.unpack("<I", fArc.read(0x04))[0]
						# heuristics detection for compressed data
						if compr_len == (flen - 0x08):
							flags = 0x01
						else:
							flags = 0x00
						fTxt.write(f"{fileID:02X}\t{flags:02X}\t{fTitle}\n")
						fArc.seek(fpos)
						fOut.write(fArc.read(flen))

	print("Done.")
	return 0

def arc_create(config):
	# read arcList.txt
	arcs = [{} for i in range(ARC_COUNT)]
	print(f"Reading {config.file_path} ...", flush=True)
	with config.file_path.open("rt") as fTxt:
		for (lid, line) in enumerate(fTxt):
			line = line.strip()
			if len(line) == 0 or line.startswith('#'):
				continue	# ignore empty lines and comments
			litems = line.split('\t')
			if len(litems) < 1:
				continue

			arcID = int(litems[0], 0x10)
			if arcID >= len(arcs):
				print(f"Warning: Ignoring archive with out-of-range ID 0x{arcID:02X} ({litems[1]})!")
				continue
			arc = arcs[arcID]
			arc["diskID"] = int(litems[1], 0x10)
			arc["diskMode"] = int(litems[2], 0x10)
			arc["fileName"] = litems[3]
			arc["flist"] = pathlib.Path(litems[4])
			arc["folder"] = arc["flist"].parent

	# read file lists
	for (arcIdx, arc) in enumerate(arcs):
		if "flist" not in arc:
			continue
		print(f"Reading {arc['flist']} ...", flush=True)
		flist_path = config.file_path.parent / arc["flist"]
		with flist_path.open("rt") as fTxt:
			arc["files"] = []
			for (lid, line) in enumerate(fTxt):
				line = line.strip()
				if len(line) == 0 or line.startswith('#'):
					continue	# ignore empty lines and comments
				litems = line.split('\t')
				if len(litems) < 1:
					continue

				if litems[0].startswith(':'):
					cmd = litems[0][1:].casefold()
					if cmd == "files":
						arc["fileCount"] = int(litems[1], 0x10)
					continue
				# [file ID, file name, flags, pos, len]
				arc["files"].append([int(litems[0], 0x10), litems[2], int(litems[1], 0x10), -1, -1])
			if not "fileCount" in arc:
				arc["fileCount"] = max([0] + [fInfo[0] for fInfo in arc["files"]]) + 1


	print("Generating directory ...", flush=True)
	tocData = bytearray(b'\x00') * (len(arcs) * 0x04)
	nameData = bytearray()
	for (arcIdx, arc) in enumerate(arcs):
		if "fileName" in arc:
			filePos = len(tocData) + len(nameData)
			struct.pack_into("<BBH", tocData, arcIdx * 0x04, arc["diskID"], arc["diskMode"], filePos)
			fname_b = arc["fileName"].encode("Shift-JIS") + b'\x00'
			nameData += fname_b
		else:
			# dummy entry - the "file name offset" points to the first string
			struct.pack_into("<BBH", tocData, arcIdx * 0x04, 0x00, 0x00, len(tocData))

	with config.dir_file.open("wb") as fDir:
		fDir.write(tocData)
		fDir.write(nameData)

	print("Generating index ...", flush=True)
	# generate in-archive offset index
	for (arcIdx, arc) in enumerate(arcs):
		if "files" not in arc:
			continue

		basepath = config.file_path.parent / arc["folder"]
		tocData = bytearray(b'\x00') * (arc["fileCount"] * 0x08)

		filePos = 0x00
		for fInfo in arc["files"]:
			tocPos = fInfo[0] * 0x08
			inputPath = basepath / fInfo[1]
			fInfo[3] = filePos
			fInfo[4] = os.path.getsize(inputPath)
			filePos += fInfo[4]
			struct.pack_into("<II", tocData, tocPos, fInfo[3], fInfo[4])
		arc["idxData"] = tocData

	# generate index of archive offset headers
	arcIdxOfsData = bytearray(b'\x00') * (len(arcs) * 0x02)
	filePos = len(arcIdxOfsData)
	for (arcIdx, arc) in enumerate(arcs):
		if "idxData" not in arc:
			continue
		struct.pack_into("<H", arcIdxOfsData, arcIdx * 0x02, filePos)
		filePos += len(arc["idxData"])

	with config.idx_file.open("wb") as fIdx:
		fIdx.write(arcIdxOfsData)
		for arc in arcs:
			if "idxData" not in arc:
				continue
			fIdx.write(arc["idxData"])

	print("Writing archives ...", flush=True)
	for (arcIdx, arc) in enumerate(arcs):
		if "files" not in arc:
			continue

		basepath = config.file_path.parent / arc["folder"]
		arcpath = config.arc_path / arc["fileName"]
		print(f"    {arc['fileName']}", flush=True)

		with arcpath.open("wb") as fArc:
			for fInfo in arc["files"]:
				inputPath = basepath / fInfo[1]
				with inputPath.open("rb") as fIn:
					fArc.seek(fInfo[3])
					fArc.write(fIn.read(fInfo[4]))

	print("Done.")
	return 0

def main(argv):
	print("Twilight PC-98 Archive (Un-)Packer")
	aparse = argparse.ArgumentParser()
	apgrp = aparse.add_mutually_exclusive_group(required=True)
	apgrp.add_argument("-x", "--extract", action="store_true", help="extract archive")
	apgrp.add_argument("-c", "--create", action="store_true", help="create archive (specify fileList.txt)")
	aparse.add_argument("arc_path", help="archive path (folder with TWDIR.DIR and HEADER.DAT)")
	aparse.add_argument("file_path", help="destination folder (extract) OR arcList.txt (create)")

	config = aparse.parse_args(argv[1:])
	config.arc_path = pathlib.Path(config.arc_path)
	config.dir_file = config.arc_path / "TWDIR.DIR"
	config.idx_file = config.arc_path / "HEADER.DAT"
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
