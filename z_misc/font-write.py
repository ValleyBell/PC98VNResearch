#!/usr/bin/env python3
# Written by Valley Bell, 2024-07-01
import sys
import typing
import argparse

import PIL.Image	# requires "pillow" pip package
import PIL.ImageOps
import PIL.ImageChops

def make_bold_font_image(img):
	imgpix = img.load()
	boldimg = img.copy()
	boldpix = boldimg.load()
	
	sx = 16
	for y in range(96, img.size[1]):
		for xbase in range(0, img.size[0], sx):
			for x in range(xbase, xbase + sx - 1):
				# This makes the font bold in the same way as it is often done on the NEC PC.
				# (The assumption is, that the background is black and the font is white.)
				boldpix[x, y] = imgpix[x, y] | imgpix[x+1, y]
	return boldimg

def extract_font_charcters(fontimg_light, fontimg_bold, bold_jis: bool) -> tuple:
	# 8x8 font
	(sx, sy) = (8, 8)
	font_8x8 = []
	for y in range(0, 32, sy * 2):
		for x in range(0, fontimg_light.size[0], sx):
			font_8x8.append(fontimg_light.crop((x, y, x+sx, y+sy)))
			font_8x8.append(fontimg_light.crop((x, y+sy, x+sx, y+sy*2)))
	#print(f"8x8 ANK characters: {len(font_8x8)}")
	
	# 8x16 font
	(sx, sy) = (8, 16)
	font_ank = []
	for y in range(32, 96, sy):
		for x in range(0, fontimg_light.size[0], sx):
			font_ank.append(fontimg_light.crop((x, y, x+sx, y+sy)))
	#print(f"8x16 ANK characters: {len(font_ank)}")
	
	# 16x16 font
	(sx, sy) = (16, 16)
	font_jis = []
	for y in range(96, fontimg_light.size[1], sy):
		for x in range(0, fontimg_light.size[0], sx):
			if y >= 480 and y < 624:
				font_jis.append(fontimg_light.crop((x, y, x + (sx//2), y+sy)))	# These are half-width characters as well.
			elif bold_jis:
				font_jis.append(fontimg_bold.crop((x, y, x+sx, y+sy)))
			else:
				font_jis.append(fontimg_light.crop((x, y, x+sx, y+sy)))
	#print(f"16x16 JIS characters: {len(font_jis)}")
	
	return (font_8x8, font_ank, font_jis)

def sjis2jis(chr_id: int) -> typing.Union[int, None]:
	if chr_id < 0x80:
		return chr_id
	if not ((chr_id >= 0x8140 and chr_id <= 0x9FFC) or (chr_id >= 0xE040 and chr_id <= 0xEFFC)):
		return None
	sjis1 = (chr_id >> 8) & 0xFF
	sjis2 = (chr_id >> 0) & 0xFF
	
	jis1 = (0x1F + sjis1 * 2) & 0x7F	# 0x81..0x9F, 0xE0..0xEF -> 0x21..0x5D, 0x5F..0x7D
	if sjis2 < 0x80:
		jis2 = sjis2 - 0x1F	# 0x40..0x7E -> 0x21..0x5F
	elif sjis2 < 0x9F:
		jis2 = sjis2 - 0x20	# 0x80..0x9E -> 0x60..0x7E
	else:
		jis2 = sjis2 - 0x7E	# 0x9F..0xFC -> 0x21..0x7E
		jis1 += 0x01
	
	return (jis1 << 8) | (jis2 << 0)

def font_text_write(config) -> int:
	# load PC-98 font graphics
	fontimg = PIL.Image.open(config.font)
	fontimg = fontimg.convert(mode='1', dither=PIL.Image.Dither.NONE)
	fontimg = PIL.ImageOps.invert(fontimg)	# white background/black font -> black BG/white font
	
	if config.thin:
		(font_8x8, font_ank, font_jis) = extract_font_charcters(fontimg, None, False)
	else:
		#print("Making bold font ...")
		fontimg_bold = make_bold_font_image(fontimg)
		(font_8x8, font_ank, font_jis) = extract_font_charcters(fontimg, fontimg_bold, True)
	
	# load text
	
	if config.utf_8:
		text_enc = "utf-8"
	if config.shift_jis:
		text_enc = "cp932"
	else:
		text_enc = None
	with open(config.input, "rt", encoding=text_enc) as f:
		tlines = f.readlines()
	
	# generate list of font characters for each line
	# and estimate the optimal image size
	(fchar_w, fchar_h) = (8, 8) if config.font_8x8 else (16, 16)
	scr_chrs = []
	img_width = 0
	img_height = 0
	for line in tlines:
		line = line.rstrip('\r\n')
		scr_chrs.append([])
		x = 0
		if config.font_8x8:
			# print using 8x8 font
			for chr_id in line.encode("cp932"):
				# using a very cheap approach here for now
				# Sometime I will do a proper conversion that works with non-ASCII letters as well.
				font_chr = font_8x8[chr_id]
				
				scr_chrs[-1].append(font_chr)
				x += font_chr.size[0] if font_chr is not None else fchar_w
		else:
			# print using 8x16 / 16x16 font
			for c in line:
				c_sjis = c.encode("cp932")
				if len(c_sjis) == 1:
					chr_id = c_sjis[0]
				else:
					chr_id = (c_sjis[0] << 8) | (c_sjis[1] << 0)
				jis_id = sjis2jis(chr_id)
				
				font_chr = None
				if jis_id is None:
					pass
				elif jis_id < 0x100:
					font_chr = font_ank[jis_id]
				else:
					# font_jis contains characters for JIS IDs 0x2120..0x217F, 0x2220..0x227F, ...
					fc_id = ((jis_id >> 8) - 0x21) * 0x60 + ((jis_id & 0xFF) - 0x20)
					if fc_id < len(font_jis):
						font_chr = font_jis[fc_id]
				
				scr_chrs[-1].append(font_chr)
				x += font_chr.size[0] if font_chr is not None else fchar_w
		img_width = max(img_width, x)
		img_height += fchar_h
	
	# create an empty image
	if config.img_width is not None:
		img_width = config.img_width
	if config.img_height is not None:
		img_height = config.img_height
	screen = PIL.Image.new('1', (img_width, img_height), 0x00)
	
	# draw the text onto the image
	y = 0
	for line in scr_chrs:
		if y >= screen.size[1]:
			break
		x = 0
		for font_chr in line:
			if x >= screen.size[0]:
				break
			if font_chr is not None:
				screen.paste(font_chr, (x, y))
			x += font_chr.size[0] if font_chr is not None else fchar_w
		y += fchar_h
	
	# (optional) swap black and white
	if config.light:
		screen = PIL.ImageOps.invert(screen)
	
	# (optional) apply palette
	if config.palette:
		pal_img = PIL.Image.open(config.palette)
		screen = screen.convert(mode='RGB').quantize(palette=pal_img, dither=PIL.Image.Dither.NONE)
	elif config.bit_4:
		pal_img = PIL.Image.new('P', (1, 1))
		pal_img.putpalette([c * 0x11 for c in range(0, 16) for _ in range(0, 3)])	# generate 16 shades of gray
		screen = screen.convert(mode='RGB').quantize(palette=pal_img, dither=PIL.Image.Dither.NONE)
	
	# finally save the image
	screen.save(config.output)
	return 0

def main(argv):
	global config
	
	print("PC-98-Font Text Writer")
	aparse = argparse.ArgumentParser()
	aparse.add_argument("-s", "--size", type=str, help="enforce image size, format \"<width>x<height>\"")
	aparse.add_argument("-t", "--thin", action="store_true", help="thin font (i.e. don't make full-width charcaters bold)")
	aparse.add_argument("-l", "--light", action="store_true", help="output black text on white ground (default is white text)")
	aparse.add_argument("-4", "--4-bit", action="store_true", dest="bit_4", help="output an image with 16-colour palette (instead of monochrome)")
	aparse.add_argument("-p", "--palette", type=str, help="image file that contains the destination palette")
	aparse.add_argument("-f", "--font", type=str, required=True, help="font image (white background, black text)")
	aparse.add_argument("-8", "--8x8-font", action="store_true", dest="font_8x8", help="print using 8x8 font (instead of 8x16/16x16)")
	aparse.add_argument("-U", "--utf-8", action="store_true", help="read text as UTF-8 encoded text file")
	aparse.add_argument("-S", "--shift-jis", action="store_true", help="read text as Shift-JIS encoded text file")
	aparse.add_argument("-i", "--input", type=str, required=True, help="input text file")
	aparse.add_argument("-o", "--output", type=str, required=True, help="output bitmap file")
	
	config = aparse.parse_args(argv[1:])
	
	config.img_width = None
	config.img_height = None
	if config.size is not None:
		size_comps = config.size.lower().split('x')
		if len(size_comps) != 2:
			print(f"Size parameter has the wrong format!")
			return 1
		try:
			config.img_width = int(size_comps[0])
			config.img_height = int(size_comps[1])
		except:
			print(f"Size parameter has the wrong format!")
			return 1
	
	return font_text_write(config)

if __name__ == "__main__":
	sys.exit(main(sys.argv))
# vim: set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab:
