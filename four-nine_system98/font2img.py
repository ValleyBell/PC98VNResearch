#!/usr/bin/env python3
# System-98 font -> BMP converter
# Written by Valley Bell, 2023-08-01
import sys
import PIL.Image	# requires "pillow" pip package
import numpy	# requires "numpy" pip package

"""
Font ROM layout
---------------
8x8 characters:
- 8 bytes per character
- each byte equals 1 "line" with 8 pixels (order: top -> bottom)
- each byte stores 8 pixels, bit 7 (mask 0x80) = leftmost pixel, bit 0 (mask 0x00) = rightmost pixel

16x16 font:
- consists of four 8x8 characters
- They are stored in the order: upper left, upper right, lower left, lower right
  Note: This is *different* from the order in the PC-98 Font ROM.

The FNT file is usually 6016 bytes large and stores 752 8x8 characters or 188 16x16 characters.
"""

if len(sys.argv) < 3:
	print("Usage: {} pc98_font.rom pc98_font.bmp".format(sys.argv[0]))
	sys.exit(0)

with open(sys.argv[1], "rb") as f:
	fontdata = f.read()

chrs_16x16 = len(fontdata) // 0x20
CHRS_X = 32	# 32 full-width characters per line (16x16)
CHRS_Y = (chrs_16x16 + CHRS_X - 1) // CHRS_X

dstWidth = CHRS_X * 16
dstHeight = CHRS_Y * 16
dstdata = numpy.zeros((dstHeight, dstWidth), numpy.uint8)

for chr_id in range(chrs_16x16):
	x_base = (chr_id % CHRS_X) * 16
	y_base = (chr_id // CHRS_X) * 16
	pos = chr_id * 0x20
	for y in range(16):
		fontpix = fontdata[pos + y * 2 + 0]
		for x in range(8):
			dstdata[y_base + y, x_base + x] = 0x00 if (fontpix << x) & 0x80 else 0xFF
		fontpix = fontdata[pos + y * 2 + 1]
		for x in range(8):
			dstdata[y_base + y, x_base + 8 + x] = 0x00 if (fontpix << x) & 0x80 else 0xFF

dstimg = PIL.Image.fromarray(dstdata, mode="L").convert('1')
dstimg.save(sys.argv[2])

sys.exit(0)
