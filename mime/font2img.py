#!/usr/bin/env python3
# MIME font -> BMP converter
# Written by Valley Bell, 2024-08-13
# based on System-98 font -> BMP converter
import sys
import PIL.Image	# requires "pillow" pip package
import PIL.ImageDraw
import PIL.ImageFont
import numpy	# requires "numpy" pip package

"""
Font structure
--------------
   2 bytes - character ID (font ROM I/O values, i.e. 0x0D21 equals JIS code 0x2D21)
             character ID 0x0000 marks the end of the data
0x20 bytes - font data

Font data
---------
8x8 characters:
- 8 bytes per character
- each byte equals 1 "line" with 8 pixels (order: top -> bottom)
- each byte stores 8 pixels, bit 7 (mask 0x80) = leftmost pixel, bit 0 (mask 0x00) = rightmost pixel

16x16 font:
- consists of four 8x8 characters
- They are stored in the order: upper right, upper left, lower right, lower left
"""

ANNOTATE = 2

if len(sys.argv) < 3:
	print("Usage: {} mime_font.bin mime_font.bmp".format(sys.argv[0]))
	sys.exit(0)

with open(sys.argv[1], "rb") as f:
	fontdata = f.read()

GRID_X = 16
GRID_Y = 16
if ANNOTATE == 1:
	GRID_X *= 2
elif ANNOTATE == 2:
	GRID_Y *= 2

font_chrs = []
for chr_idx in range(len(fontdata) // 0x22):
	pos = chr_idx * 0x22	# Note: using // and * to ensure that only "full" slots are processed
	chr_code = (fontdata[pos+0] << 8) | (fontdata[pos+1] << 0)
	if chr_code == 0x0000:
		break
	font_chrs.append({
		"code": 0x2000 + chr_code,
		"data": fontdata[pos+0x02 : pos+0x22],
	})

CHRS_X = 16
CHRS_Y = (len(font_chrs) + CHRS_X - 1) // CHRS_X
x = -1
y = 0
next_code = font_chrs[0]["code"]
dstWidth = 0
for (chr_idx, chrinfo) in enumerate(font_chrs):
	x += 1
	if (next_code != chrinfo["code"]) or (x >= CHRS_X):
		# start a new line when the code numbers jump around OR when exceeding line length
		y += 1
		x = 0
	chrinfo["x"] = x * GRID_X
	chrinfo["y"] = y * GRID_Y
	dstWidth = max([dstWidth, (x + 1) * GRID_X])
	next_code = chrinfo["code"] + 1
dstHeight = (y + 1) * GRID_Y

dstdata = numpy.full((dstHeight, dstWidth), 0xFF, numpy.uint8)

for chrinfo in font_chrs:
	x_base = chrinfo["x"]
	y_base = chrinfo["y"]
	for y in range(GRID_Y):
		for x in range(GRID_X):
			dstdata[y_base + y, x_base + x] = 0xFF
	
	cdata = chrinfo["data"]
	for y in range(16):
		fontpix = cdata[y * 2 + 0]
		for x in range(8):
			dstdata[y_base + y, x_base + 8 + x] = 0x00 if (fontpix << x) & 0x80 else 0xFF
		fontpix = cdata[y * 2 + 1]
		for x in range(8):
			dstdata[y_base + y, x_base + x] = 0x00 if (fontpix << x) & 0x80 else 0xFF
dstimg = PIL.Image.fromarray(dstdata, mode="L")
if ANNOTATE > 0:
	imgdraw = PIL.ImageDraw.Draw(dstimg)
	imgfont = PIL.ImageFont.load_default()
	for chrinfo in font_chrs:
		x = chrinfo["x"]
		y = chrinfo["y"]
		if ANNOTATE == 1:
			x += 16
		elif ANNOTATE == 2:
			y += 16
		real_chr_id = chrinfo["code"]
		chr_text = f"{real_chr_id:04X}"
		imgdraw.text((x+4, y-1), chr_text[:2], fill=0x00, font=imgfont)
		imgdraw.text((x+4, y+6), chr_text[2:], fill=0x00, font=imgfont)

#dstimg = dstimg.convert('1', dither=PIL.Image.Dither.NONE)
dstimg.save(sys.argv[2])

sys.exit(0)
