#!/usr/bin/env python3
import sys
import struct

if len(sys.argv) < 3:
	print("Gaogao 4 Canaan Prologue Image De/-Interlacer")
	print("Usage: {} input.bmp output.bmp".format(sys.argv[0]))
	print("Run the tool twice to revert the interlacing.")
	sys.exit(1)

with open(sys.argv[1], "rb") as f:
	hdr = f.read(2)
	if hdr != b"BM":
		print("Input file is not a Windows Bitmap!")
		sys.exit(1)
	f.seek(0)
	data = f.read()

# read BITMAPFILEHEADER 
(bfType, bfSize, bfReserved1, bfReserved2, bfOffBits) = struct.unpack_from("<HIHHI", data, 0x00)
# read BITMAPINFOHEADER
(biSize, biWidth, biHeight, biPlanes, biBitCount,
 biCompression, biSizeImage, biXPelsPerMeter, biYPelsPerMeter,
 biClrUsed, biClrImportant) = struct.unpack_from("<IIIHHIIIIII", data, 0x0E)

imgHeight = abs(biHeight)
halfHeight = imgHeight // 2
isTopDown = (biHeight < 0)	# default is down-top
scanlineSize = (biWidth * biBitCount + 7) // 8
scanlineSize = (scanlineSize + 0x03) & ~0x03	# pad up to multiples of 4 bytes

dout = data[:bfOffBits]
for dstFileY in range(imgHeight):
	dstImgY = dstFileY if isTopDown else (imgHeight - 1 - dstFileY)
	
	# For height=400, the lines are ordered:
	#  0, 201, 2, 203, 4, 205, ...
	if (dstImgY % 2) == 0:
		srcImgY = dstImgY
	else:
		srcImgY = (dstImgY + halfHeight) % imgHeight
	
	srcFileY = srcImgY if isTopDown else (imgHeight - 1 - srcImgY)
	inpos = bfOffBits + srcFileY * scanlineSize
	#outpos = bfOffBits + dstFileY * scanlineSize
	dout += data[inpos : inpos+scanlineSize]

with open(sys.argv[2], "wb") as f:
	f.write(dout)
