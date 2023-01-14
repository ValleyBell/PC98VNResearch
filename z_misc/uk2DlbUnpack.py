#!/usr/bin/env python3
import sys
import os
import struct

"""
UK2 DLB Archive Format
----------------------
16h bytes - "<< dlb file Ver1.00>>" + 00h
2 bytes - number of files (n) (Little Endian)
15h*n bytes - file entry
?? bytes - data

File Entry:
0Dh bytes - file name (null-terminated string)
4 bytes - start offset (absolute, Little Endian)
4 bytes - file length (Little Endian)

"""

if len(sys.argv) < 3:
	print("UK2 DLB Archive Unpacker")
	print("Usage: {} datalib.dlb folder".format(sys.argv[0]))
	sys.exit(1)

OUT_FOLDER = sys.argv[2]

with open(sys.argv[1], "rb") as hArcFile:
	header = hArcFile.read(22)
	if header != b"<< dlb file Ver1.00>>\x00":
		print("Not a DLB file!")
		sys.exit(1)
	
	fileCount = struct.unpack("<H", hArcFile.read(0x02))[0]
	fileToc = []
	for curFile in range(fileCount):
		fname_b = hArcFile.read(0x0D)
		if b'\x00' in fname_b:
			fname_b = fname_b[: fname_b.find(b'\x00')]
		fname_s = fname_b.decode("Shift-JIS")
		fofs = struct.unpack("<II", hArcFile.read(0x08))
		fileToc.append((fname_s, fofs[0], fofs[1]))

	for (fileID, tocEntry) in enumerate(fileToc):
		print("File {}/{}: Name: {}, Offset 0x{:06X}, Length 0x{:04X}".format(
			1 + fileID, len(fileToc), tocEntry[0], tocEntry[1], tocEntry[2]))
		fName = os.path.join(OUT_FOLDER, tocEntry[0])
		fnFolder = os.path.dirname(fName)
		if not os.path.isdir(fnFolder):
			os.makedirs(fnFolder, exist_ok=True)
		
		with open(fName, "wb") as hFile:
			hArcFile.seek(tocEntry[1])
			hFile.write(hArcFile.read(tocEntry[2]))
