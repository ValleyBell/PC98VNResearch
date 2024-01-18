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
1 byte - disk ID (0 = disk A, ..., 3 = disk D)
1 byte - disk drive (0 = drive A, 1 = drive B)
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

class TwinkleDecompressor:
	@staticmethod
	def rot_left_8bit(value, shift):
		return ((value << shift) | (value << shift >> 8)) & 0xFF

	def __init__(self):
		self.buf_657Dh = [0] * 0x3FB	# 16-bit values
		self.buf_6D73h = [0] * 0x3FB	# 16-bit values
		self.buf_7569h = [0] * 0x1000	# 16-bit values
		self.buf_9569h = [0] * 0x100	# 16-bit values
		self.buf_9769h = [0] * 0x1FE	# 8-bit values
		self.buf_9967h = [0] * 0x60	# 8-bit values

	def GetToken(self):	# sub_10552 (Decode Control Byte)
		self.ds_657Bh -= 1
		if self.ds_657Bh < 0:
			# loc_10559
			self.ds_657Bh = self.sub_107B3(16) - 1
			self.sub_105F0(19, 5, 3)
			self.sub_10666()
			self.sub_105F0(14, 4, 0xFFFF)
		# loc_1057D
		bx = self.ds_99E7h >> 4
		bx = self.buf_7569h[bx]	# 16-bit indexing
		if bx >= 0x1FE:
			bx = self.sub_1059E(bx, 4)
		self.GetBits(self.buf_9769h[bx])
		return bx

	def sub_1059E(self, bx, cl):
		al = (self.ds_99E7h << cl) & 0xFF
		cx = 0x1FE
		return self.sub_105A6(al, bx, cx)

	def sub_105A6(self, al, bx, cx):
		while True:
			if (al & 0x80) != 0:
				bx = self.buf_6D73h[bx//2]
			else:
				bx = self.buf_657Dh[bx//2]
			al <<= 1
			if bx < cx:
				return bx

	def sub_105B4(self, al, bx, cx):
		while bx >= cx:
			if (al & 0x80) != 0:
				bx = self.buf_6D73h[bx//2]
			else:
				bx = self.buf_657Dh[bx//2]
			al <<= 1
		return bx

	def GetCopyOffset(self):	# sub_105B9
		bx = self.buf_9569h[self.ds_99E7h >> 8]	# 16-bit indexing
		if bx >= 14:
			bx = self.sub_105A6(self.ds_99E7h & 0xFF, bx, 14)
		# loc_105D4
		self.GetBits(self.buf_9967h[bx])
		if bx > 1:
			cl = bx - 1
			bx = self.sub_107B3(cl)
			bx |= (1 << cl)
		return bx

	def sub_105F0(self, si, dl, cx):
		ax = self.sub_107B3(dl)
		if ax > si:
			# This really happens ingame with TWGD2.DAT / file 0x13.
			raise Exception(f"sub_105F0: {ax} > {si}")	# the original code freezes here
		if ax == 0:
			# loc_10607
			for i in range(si):
				self.buf_9967h[i] = 0
			ax = self.sub_107B3(dl)
			for i in range(0x100):
				self.buf_9569h[i] = ax
			return
		
		# loc_10618
		di_ofs = 0
		dx_ofs = cx
		si_ofs = ax
		while True:
			# loc_10620
			ax = self.sub_107B3(3)
			if ax == 7:
				bx = self.ds_99E7h
				while (bx & 0x8000) != 0:
					bx <<= 1
					ax += 1
				# loc_10634
				self.GetBits(ax - 6)	# result is discarded
			# loc_1063B
			self.buf_9967h[di_ofs] = ax & 0xFF
			di_ofs += 1
			if di_ofs == dx_ofs:
				cx = self.sub_107B3(2)
				for i in range(cx):
					self.buf_9967h[di_ofs + i] = 0
				di_ofs += cx
			# loc_1064B
			if di_ofs >= si_ofs:
				break
		
		# loc_1064F
		cx = si - di_ofs
		for i in range(cx):
			self.buf_9967h[di_ofs + i] = 0
		di_ofs += cx
		
		self.sub_106F6(si, self.buf_9967h, 8, self.buf_9569h)
		return

	def sub_10666(self):
		ax = self.sub_107B3(9)
		if ax > 0x1FE:
			raise Exception(f"sub_10666: 0x{ax:02X} > 0x{0x1FE:02X}")	# the original code freezes here
		if ax == 0:
			# loc_1067D
			for i in range(0x1FE):
				self.buf_9769h[i] = 0
			ax = self.sub_107B3(9)
			for i in range(0x100):
				self.buf_7569h[i] = ax
			return
		
		# loc_10690
		di_ofs = 0
		dx_ofs = ax
		while True:
			# loc_10695
			bx = self.buf_9569h[self.ds_99E7h >> 8]	# 16-bit indexing
			bx = self.sub_105B4(self.ds_99E7h & 0xFF, bx, 19)
			# push BX
			self.GetBits(self.buf_9967h[bx])
			# pop AX
			if bx <= 2:
				if bx == 2:
					cx = 20 + self.sub_107B3(9)
				# loc_106C4
				elif bx == 1:
					cx = 3 + self.sub_107B3(4)
				else:
					cx = 1
				# loc_106D6
				for i in range(cx):
					self.buf_9769h[di_ofs + i] = 0
				di_ofs += cx
			elif bx > 2:
				# loc_106DC
				self.buf_9769h[di_ofs] = (bx - 2) & 0xFFF
				di_ofs += 1
			# loc_106DD
			if di_ofs >= dx_ofs:
				break
		
		# loc_106E1
		cx = 0x1FE - di_ofs
		for i in range(cx):
			self.buf_9769h[di_ofs + i] = 0
		di_ofs += cx
		
		self.sub_106F6(0x1FE, self.buf_9769h, 12, self.buf_7569h)
		return

	def sub_106F6(self, ax, bp, cx, di):
		# ax = count
		# bp = byte array
		# cx = bit count
		# di = word array
		self.ds_99EDh = ax	# source self.buffer size
		self.ds_99EBh = ax * 2	# offset into tree structure
		self.ds_99EFh = cx	# bit shift count
		self.ds_99F1h = di	# destination self.buffer
		self.ds_99F3h = 16 - cx	# inverse bit shift count
		cx = 1 << cx
		for i in range(cx):
			self.ds_99F1h[i] = 0
		
		si = 0
		bx = 0x8000
		dx = 1
		while True:
			# loc_10720
			di_ofs = 0
			cx_rep = self.ds_99EDh
			while True:
				# loc_10726
				al = dx
				# emulation of "REPNE SCASB" start
				result_eq = False
				while cx_rep > 0:
					result_eq = (bp[di_ofs] == al)
					di_ofs += 1
					cx_rep -= 1
					if result_eq == True:
						break
				# "REPNE SCASB" end
				if not result_eq:
					break	# goto loc_10797
				ax = di_ofs - 1
				
				di = self.ds_99F1h	# 16-bit indexing
				di2_ofs = si >> self.ds_99F3h
				if dx <= self.ds_99EFh:
					cx = bx >> self.ds_99F3h
					for i in range(cx):
						di[di2_ofs + i] = ax
				else:
					# loc_10750
					si2 = (si << self.ds_99EFh) & 0xFFFF
					cx = dx - self.ds_99EFh
					for i in range(cx):
						# loc_1075B
						if di[di2_ofs] == 0:
							self.buf_6D73h[self.ds_99EBh//2] = 0	# //2 for offset->index conversion
							self.buf_657Dh[self.ds_99EBh//2] = 0
							di[di2_ofs] = self.ds_99EBh
							self.ds_99EBh += 2
						# loc_10777
						di2_ofs = di[di2_ofs]//2	# //2 for offset->index conversion
						if (si2 & 0x8000) != 0:
							di = self.buf_6D73h
						else:
							di = self.buf_657Dh
						si2 <<= 1
					# loc_10789
					di[di2_ofs] = ax
				# loc_1078C
				si += bx
				if si >= 0x10000:
					return
				if cx == 0:
					break
			# loc_10797
			dx += 1
			if (bx & 0x0001) != 0:
				break
			bx >>= 1
		return

	def sub_107B3(self, bitsToRead):
		remBits = 16 - bitsToRead
		old_ds_99E7h = self.ds_99E7h
		self.GetBits(bitsToRead)	# will modify self.ds_99E7h
		return old_ds_99E7h >> remBits

	def GetBits(self, bitsToRead):	# sub_107C4
		remBits = self.ds_99EAh # register CL
		dx = self.ds_99E7h
		al = self.ds_99E9h
		if bitsToRead > remBits:
			bitsToRead -= remBits
			dx <<= remBits
			dh = (dx >> 8) & 0xFF
			dl = (dx >> 0) & 0xFF
			dl += TwinkleDecompressor.rot_left_8bit(al, remBits)
			
			remBits = 8
			while True:
				# loc_107E1
				al = self.comprBuf[self.inPos]
				self.inPos += 1
				# loc_107FA
				if bitsToRead <= remBits:
					break
				bitsToRead -= remBits
				dh = dl
				dl = al
			dx = (dh << 8) | (dl << 0)
		# loc_1080A
		self.ds_99EAh = remBits - bitsToRead
		ax = al << bitsToRead
		self.ds_99E7h = ((dx << bitsToRead) + (ax >> 8)) & 0xFFFF
		self.ds_99E9h = ax & 0xFF
		return ax

	def DecompressData(self, comprLen: int, decLen: int, comprBuffer: bytes) -> bytes:
		# The 2 additional bytes are required for a dummy read at EOF.
		# This is due to the bistream reader being up to 16 bits ahead of the data that is used.
		self.comprBuf = comprBuffer + b'\x00\x00'
		self.inPos = 0x0000	# ds:6579h
		decBuf = bytearray(decLen)	# buffer ds:2579h..6578h
		outPos = 0x0000	# register DI
		remDecBytes = decLen	# ds:2575h
		self.ds_657Bh = 0
		self.ds_99E7h = 0
		self.ds_99E9h = 0
		self.ds_99EAh = 0
		try:
			self.GetBits(16)
			while remDecBytes > 0:
				# loc_104F0
				ax = self.GetToken()
				if ax < 0x100:
					# loc_104F7
					decBuf[outPos] = ax & 0xFF
					outPos += 1
					remDecBytes -= 1
				else:
					# loc_10518
					copyLen = (ax - 0x100) + 3
					srcPos = outPos - 1 - self.GetCopyOffset()
					for i in range(copyLen):
						# loc_10526
						decBuf[outPos] = decBuf[srcPos]
						srcPos += 1
						outPos += 1
						remDecBytes -= 1
						if remDecBytes <= 0:
							break
			if outPos < len(decBuf):
				decBuf = decBuf[0 : outPos]
			return decBuf
		except Exception as e:
			return (decBuf, self.inPos, comprLen, outPos, decLen, e)

def get_file_data(fArc, fpos, flen, config):
	flags = 0x00
	fArc.seek(fpos)
	if flen < 8:
		return (fArc.read(flen), flags)
	
	(compr_len, decomp_len) = struct.unpack("<II", fArc.read(0x08))
	# heuristics detection for compressed data
	if compr_len == (flen - 0x08):
		flags = 0x01	# set 'compressed' flag
	
	fArc.seek(fpos)
	fdata = fArc.read(flen)
	if (flags & 0x01) and not config.raw:
		twdec = TwinkleDecompressor()
		res = twdec.DecompressData(compr_len, decomp_len, fdata[8:])
		if type(res) is not tuple:
			return (res, flags)
		else:
			flags &= ~0x01	# remove 'compression' flag again
			if config.verbose:
				(decBuf, srcPos, comprLen, decPos, decLen, e) = res
				print(f"Decompression Error - {e}", file=sys.stderr)
				print(f"InPos: 0x{srcPos:04X} / 0x{comprLen:04X}, " \
					f"OutPos: 0x{decPos:04X} / 0x{decLen:04X}", file=sys.stderr)
			else:
				print(f"Decompression Error", file=sys.stderr)
	
	return (fdata, flags)
	
def arc_extract(config):
	arcs = [{} for i in range(ARC_COUNT)]
	# read archive file names
	print(f"Reading {config.dir_file} ...", flush=True)
	with config.dir_file.open("rb") as fDir:
		tocData = fDir.read()
		for (arcIdx, arc) in enumerate(arcs):
			(diskID, diskDrive, fnPos) = struct.unpack_from("<BBH", tocData, arcIdx * 0x04)

			arc["diskID"] = diskID
			arc["diskDrive"] = diskDrive
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
		fTxt.write("#arcID\tdiskID\tdriveID\tarchive_file\tfileList\n")
		for (arcIdx, arc) in enumerate(arcs):
			if "files" not in arc:
				continue
			basepath = arc["fileName"].replace('.', '_')
			basepath = pathlib.Path(basepath)
			if (config.file_path / basepath).is_file():
				basepath = basepath.with_suffix(".EXT")
			arc["folder"] = basepath
			if config.short_names:
				arc["flist"] = basepath / "_fileList.txt"
			else:
				arc["flist"] = basepath / pathlib.Path(arc["fileName"]).with_suffix(".TXT")
			fTxt.write(f"{arcIdx:02X}\t{arc['diskID']:02X}\t{arc['diskDrive']:02X}" \
				f"\t{arc['fileName']}\t{arc['flist']}\n")

	# extract archives
	for (arcIdx, arc) in enumerate(arcs):
		if "files" not in arc:
			continue
		arcpath = config.arc_path / arc["fileName"]
		if config.short_names:
			basename = ""
		else:
			basename = pathlib.Path(arc["fileName"]).stem + "_"
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
					fTitle = f"{basename}{fileID:02X}.BIN"
					with (basepath / fTitle).open("wb") as fOut:
						(fData, flags) = get_file_data(fArc, fpos, flen, config)
						fTxt.write(f"{fileID:02X}\t{flags:02X}\t{fTitle}\n")
						fOut.write(fData)

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
			arc["diskDrive"] = int(litems[2], 0x10)
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
			struct.pack_into("<BBH", tocData, arcIdx * 0x04, arc["diskID"], arc["diskDrive"], filePos)
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
	aparse.add_argument("-v", "--verbose", action="store_true", help="verbose error reporting for decompression")
	aparse.add_argument("-r", "--raw", action="store_true", help="(un-)pack raw data, don't decompress")
	aparse.add_argument("-s", "--short-names", action="store_true", help="extract with only digits as file names (default: prepend archive name)")
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
		if not config.raw:
			print("This tool is currently unable to recompress the data.")
			print("Please add the --raw parameter to enforce raw packing.")
			return 1
		return arc_create(config)
	else:
		print("Please specify a mode!")
		return 1

if __name__ == "__main__":
	sys.exit(main(sys.argv))
