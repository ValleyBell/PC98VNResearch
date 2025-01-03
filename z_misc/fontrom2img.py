#!/usr/bin/env python3
# NEC PC-98 Font ROM -> BMP converter
# Written by Valley Bell, 2023-08-01
import sys
import PIL.Image	# requires "pillow" pip package
import numpy	# requires "numpy" pip package

"""
Font ROM format
---------------
8x8 font:
- 8 bytes per character
- each byte equals 1 "line" with 8 pixels (order: top -> bottom)
- each byte stores 8 pixels, bit 7 (mask 0x80) = leftmost pixel, bit 0 (mask 0x01) = rightmost pixel

16x8 font:
- consists of two 8x8 characters
- The upper part is stored first, followed by the lower part.

16x16 font:
- consists of four 8x8 characters
- They are stored in the order: upper left, lower left, upper right, lower right
"""

if len(sys.argv) < 3:
	print("Usage: {} pc98_font.rom pc98_font.bmp".format(sys.argv[0]))
	sys.exit(0)

with open(sys.argv[1], "rb") as f:
	fontdata = f.read()

chrs_16x16 = len(fontdata) // 0x20
CHRS_X = 32	# 32 full-width characters per line (16x16)
BLOCKS_X = CHRS_X * 2	# half-width characters (8x8)
CHRS_Y = (chrs_16x16 + CHRS_X - 1) // CHRS_X

dstWidth = CHRS_X * 16
dstHeight = CHRS_Y * 16
dstdata = numpy.zeros((dstHeight, dstWidth), numpy.uint8)

for chr_id in range(chrs_16x16 * 2):
	x_base = (chr_id % BLOCKS_X) * 8
	y_base = (chr_id // BLOCKS_X) * 16
	pos = chr_id * 0x10
	for y in range(16):
		fontpix = fontdata[pos + y]
		for x in range(8):
			dstdata[y_base + y, x_base + x] = 0x00 if (fontpix << x) & 0x80 else 0xFF

dstimg = PIL.Image.fromarray(dstdata, mode="L").convert('1')
dstimg.save(sys.argv[2])

sys.exit(0)
