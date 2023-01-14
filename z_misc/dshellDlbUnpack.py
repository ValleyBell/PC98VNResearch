#!/usr/bin/env python3
import sys
import os
import struct

"""
D-SHELL DLB Archive Format
----------------------
4 bytes - "DLB" + 1Ah
8 bytes - unused (sometimes 00h, sometimes 0FFh)
4 bytes - file offset of first file data (absolute, Little Endian)
?? bytes - file list (10h bytes per file)
?? bytes - file data

File Entry:
0Ch bytes - file name (padded with spaces)
4 bytes - file length (Little Endian)

Except for the file signature, all contents of the archive is encrypted.
Encryption is done by XORing all bytes with 0FFh. (or just inverting all bits, see x86 NOT instruction)
XORing with 0FFh again reverses the process.

The file list seems to be terminated by an entry that consists of just 00s.
"""

if len(sys.argv) < 3:
	print("D-SHELL DLB Archive Unpacker")
	print("Usage: {} archive.dlb folder".format(sys.argv[0]))
	sys.exit(1)

def decrypt(data: bytes) -> bytes:
	return bytes([a ^ 0xFF for a in data])

OUT_FOLDER = sys.argv[2]

with open(sys.argv[1], "rb") as hArcFile:
	header = hArcFile.read(0x04)
	if header != b"DLB\x1A":
		print("Not a DLB file!")
		sys.exit(1)
	
	hArcFile.seek(0x0C)
	hdrEndPos = struct.unpack("<I", decrypt(hArcFile.read(0x04)))[0]
	
	fileTocData = decrypt(hArcFile.read(hdrEndPos - hArcFile.tell()))
	pos = 0x00
	fpos = hdrEndPos
	fileToc = []
	while pos < len(fileTocData):
		if fileTocData[pos+0x00] == 0x00:
			break
		fname_b = fileTocData[pos+0x00 : pos+0x0C]
		fname_s = fname_b.decode("Shift-JIS").rstrip(' ')
		flen = struct.unpack_from("<I", fileTocData, pos+0x0C)[0]
		fileToc.append((fname_s, fpos, flen))
		fpos += flen
		pos += 0x10
	
	for (fileID, tocEntry) in enumerate(fileToc):
		print("File {}/{}: Name: {}, Offset 0x{:06X}, Length 0x{:04X}".format(
			1 + fileID, len(fileToc), tocEntry[0], tocEntry[1], tocEntry[2]))
		fName = os.path.join(OUT_FOLDER, tocEntry[0])
		fnFolder = os.path.dirname(fName)
		if not os.path.isdir(fnFolder):
			os.makedirs(fnFolder, exist_ok=True)
		
		with open(fName, "wb") as hFile:
			hArcFile.seek(tocEntry[1])
			hFile.write(decrypt(hArcFile.read(tocEntry[2])))
