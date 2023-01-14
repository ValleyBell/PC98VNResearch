#!/usr/bin/env python3
# System-98 font -> BMP converter
# Written by Valley Bell, 2023-08-01
import sys
import PIL.Image	# requires "pillow" pip package
import PIL.ImageDraw
import PIL.ImageFont
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

ANNOTATE = 2

if len(sys.argv) < 3:
	print("Usage: {} pc98_font.rom pc98_font.bmp".format(sys.argv[0]))
	sys.exit(0)

with open(sys.argv[1], "rb") as f:
	fontdata = f.read()

GRID_X = 16
GRID_Y = 16
if ANNOTATE == 1:
	GRID_X *= 2
elif ANNOTATE == 2:
	GRID_Y *= 2

chrs_16x16 = len(fontdata) // 0x20
#CHRS_X = 32	# 32 full-width characters per line (16x16)
CHRS_X = 16
CHRS_Y = (chrs_16x16 + CHRS_X - 1) // CHRS_X

dstWidth = CHRS_X * GRID_X
dstHeight = CHRS_Y * GRID_Y
dstdata = numpy.zeros((dstHeight, dstWidth), numpy.uint8)

for chr_id in range(chrs_16x16):
	x_base = (chr_id % CHRS_X) * GRID_X
	y_base = (chr_id // CHRS_X) * GRID_Y
	for y in range(GRID_Y):
		for x in range(GRID_X):
			dstdata[y_base + y, x_base + x] = 0xFF
	
	pos = chr_id * 0x20
	for y in range(16):
		fontpix = fontdata[pos + y * 2 + 0]
		for x in range(8):
			dstdata[y_base + y, x_base + x] = 0x00 if (fontpix << x) & 0x80 else 0xFF
		fontpix = fontdata[pos + y * 2 + 1]
		for x in range(8):
			dstdata[y_base + y, x_base + 8 + x] = 0x00 if (fontpix << x) & 0x80 else 0xFF
dstimg = PIL.Image.fromarray(dstdata, mode="L")
if ANNOTATE > 0:
	imgdraw = PIL.ImageDraw.Draw(dstimg)
	imgfont = PIL.ImageFont.load_default()
	#imgfont = PIL.ImageFont.truetype("cour.ttf", size=8)
	for chr_id in range(chrs_16x16):
		x = (chr_id % CHRS_X) * GRID_X
		y = (chr_id // CHRS_X) * GRID_Y
		if ANNOTATE == 1:
			x += 16
		elif ANNOTATE == 2:
			y += 16
		real_chr_id = 0x7621 + (chr_id // 94) * 0x100 + (chr_id % 94)
		chr_text = f"{real_chr_id:04X}"
		imgdraw.text((x+4, y-1), chr_text[:2], fill=0x00, font=imgfont)
		imgdraw.text((x+4, y+6), chr_text[2:], fill=0x00, font=imgfont)

#dstimg = dstimg.convert('1', dither=PIL.Image.Dither.NONE)
dstimg.save(sys.argv[2])

sys.exit(0)
