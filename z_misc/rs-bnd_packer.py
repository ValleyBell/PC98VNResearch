#!/usr/bin/env python3
# PC-98 Right Stuff BND Archive (Un-)Packer
# Written by Valley Bell, 2025-08-10
import sys
import os
import argparse
import struct
import pathlib

"""
Right Stuff BND Archive Format
------------------------------
The whole file format is made of blocks of 400h bytes.
Every "section" of data begins at an offset that is a multiple of 400h.

The TOC is padded with 00s to fill the 400h byte block.
Files are padded using garbage data.

General layout:
400h bytes - TOC data
?? bytes - file 1 data
?? bytes - padding
?? bytes - file 2 data
?? bytes - padding
...

TOC data:
2 bytes - number of files (n)
2*n bytes - file sizes
        These can be 0 to indicate unused files.
        Up to 1FFh files can be stored.

Notes:
- All values are stored in Little Endian.
- [Forsight Dolly specific] Files may be LZSS-compressed and begin with a 4-byte value indicating the decompressed file size.
  The compressed data follows right after that.
  Whether or not the file is compressed depends on what the game expects for a specific BND file. There is no flag that indicates compression.
  Files that need decompression are internally loaded using a "CALL 27D0h".
  LZSS decompression with: lzss-tool -a o4 -n 0x00
  Outside of BND archives, compressed files have an SLD extension.
- [Revery: Izanai no Masuishō specific] Files may be compressed using a custom LZ-style compression that is different from LZSS.
- Internal file numbering:
  - Foresight Dolly: The internal file numbering starts with 0 for the first file.
  - Reverie: The internal file numbering starts with 1 for the first file. ID 0 is reserved for loading from non-archive files.
- Due to how the size calculation works, the maximum size of files stored inside the archive is 0FC00h bytes. (size 0FC00h will overflow to 0 during the padding calculation)

"""

ARC_TOC_FILE_COUNT = 0x1FF

def arc_extract(config):
	cfg_filepath = pathlib.Path(config.file_path)
	if len(config.file_path) > 0 and config.file_path[-1] in [os.path.sep, os.path.altsep]:
		# output pattern: "dir/"
		basepath = cfg_filepath
		OUT_BASE = ""
		OUT_EXT = "bin"
	elif cfg_filepath.stem.startswith('.'):
		# output pattern: "dir/.bin"
		basepath = cfg_filepath.parent
		OUT_BASE = ""
		OUT_EXT = cfg_filepath.stem[1:]
	else:
		# output pattern: "dir/file.bin" or "dir/file"
		basepath = cfg_filepath.parent
		OUT_BASE = cfg_filepath.stem
		OUT_EXT = cfg_filepath.suffix.lstrip('.')
	
	with config.arc_file.open("rb") as fArc:
		fileCount = struct.unpack("<H", fArc.read(0x02))[0]
		fileToc = []
		fpos = 0x400
		for curFile in range(fileCount):
			flen = struct.unpack("<H", fArc.read(0x02))[0]
			fileToc.append((fpos, flen))
			fpos = (fpos + flen + 0x3FF) & ~0x3FF
		
		basepath.mkdir(parents=True, exist_ok=True)
		fnTxt = f"{OUT_BASE}_fileList.txt"
		with (basepath / fnTxt).open("wt") as fTxt:
			fTxt.write("#filename\tflags\n");
			
			for (fileID, tocEntry) in enumerate(fileToc):
				(fpos, flen) = tocEntry
				fName = f"{OUT_BASE}{fileID:03}.{OUT_EXT}"
				fTitle = os.path.basename(fName)
				
				if flen == 0:
					# empty file - skip and mark entry as unused
					print(f"File {1 + fileID}: unused")
					fTxt.write(f"-\n")
					continue
				print(f"File {1 + fileID}: Start Offset 0x{fpos:06X}, Length 0x{flen:04X}")
				with (basepath / fName).open("wb") as hFile:
					fArc.seek(fpos)
					dec_len = struct.unpack("<I", fArc.read(0x04))[0]
					# very rough heuristic for detecting compressed files
					if dec_len >= flen / 2 and dec_len <= flen * 8:
						flags = 0x01
					else:
						flags = 0x00
					fTxt.write(f"{fTitle}\t{flags:02X}\n")
					fArc.seek(fpos)
					hFile.write(fArc.read(flen))
	
	return 0

def arc_create(config):
	config.file_path = pathlib.Path(config.file_path)
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
			
			flags = int(litems[1], 0x10) if len(litems) >= 2 else 0x00
			fileToc.append([litems[0], flags, -1, -1, -1])
	if len(fileToc) > ARC_TOC_FILE_COUNT:
		print(f"Warning! File list contains {len(fileToc)} files, but only {ARC_TOC_FILE_COUNT} can be stored!")
		fileToc = fileToc[0:ARC_TOC_FILE_COUNT]
	
	print("Packing {} {} ...".format(len(fileToc), "file" if len(fileToc) == 1 else "files"), flush=True)
	# go through all files, determining file sizes and archive file data offsets
	filePos = 0x400
	tocBuf = bytearray(filePos)
	
	struct.pack_into("<H", tocBuf, 0x00, len(fileToc))	# write file count
	tocPos = 0x02
	for fInfo in fileToc:
		fInfo[2] = filePos
		if fInfo[0] == "-":
			fInfo[3] = 0	# unused slot
		else:
			inputPath = basepath / fInfo[0]
			fInfo[3] = os.path.getsize(inputPath)
			if fInfo[3] > 0xFC00:
				fInfo[3] = 0xFC00
				print(f"Warning: File \"{fInfo[0]}\" is will be truncated to {fInfo[3]} bytes.")
		filePos = (filePos + fInfo[3] + 0x3FF) & ~0x3FF
		fInfo[4] = filePos - fInfo[3] - fInfo[2]	# calculate padding
		struct.pack_into("<H", tocBuf, tocPos, fInfo[3])
		tocPos += 0x02
	fileEndOfs = filePos
	
	with config.arc_file.open("wb") as fArc:
		fArc.write(tocBuf)
		
		for fInfo in fileToc:
			if fInfo[3] == 0:
				continue	# we can skip empty files
			inputPath = basepath / fInfo[0]
			with inputPath.open("rb") as fIn:
				fArc.seek(fInfo[2])
				fArc.write(fIn.read(fInfo[3]))	# write file data
			fArc.write(b'\x00' * fInfo[4])	# write padding
	
	return 0

def main(argv):
	print("Right Stuff BND Archive (Un-)Packer")
	aparse = argparse.ArgumentParser()
	apgrp = aparse.add_mutually_exclusive_group(required=True)
	apgrp.add_argument("-x", "--extract", action="store_true", help="extract archive")
	apgrp.add_argument("-c", "--create", action="store_true", help="create archive (specify file_list.txt)")
	aparse.add_argument("arc_file", help="archive file")
	aparse.add_argument("file_path", help="destination pattern (extract) OR file_list.txt (create)")
	
	config = aparse.parse_args(argv[1:])
	config.arc_file = pathlib.Path(config.arc_file)
	
	if config.extract:
		return arc_extract(config)
	elif config.create:
		return arc_create(config)
	else:
		print("Please specify a mode!")
		return 1

if __name__ == "__main__":
	sys.exit(main(sys.argv))
