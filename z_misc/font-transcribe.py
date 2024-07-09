#!/usr/bin/env python3
# Written by Valley Bell, 2024-06-27
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

def jis2sjis(jis: int) -> list:
	jis1 = (jis >> 8) & 0xFF
	jis2 = (jis >> 0) & 0xFF
	
	if jis1 >= 0x21 and jis1 <= 0x5E:
		sjis1 = 0x70 + (jis1 + 1) // 2	# 0x21..0x5E -> 0x81..0x9F
	elif jis1 >= 0x5F and jis1 <= 0x7E:
		sjis1 = 0xB0 + (jis1 + 1) // 2	# 0x5F..0x7E -> 0xE0..0xEF
	else:
		return 0
	if jis2 < 0x21 or jis2 > 0x7E:
		return 0
	if (jis1 & 0x01) == 0:
		sjis2 = 0x7E + jis2	# 0x21..0x7E -> 0x9F..0xFC
	elif jis2 < 0x60:
		sjis2 = 0x1F + jis2	# 0x21..0x5F -> 0x40..0x7E
	else:
		sjis2 = 0x20 + jis2	# 0x60..0x7E -> 0x80..0x9E
	
	return [sjis1, sjis2]

def font_text_transcribe(config) -> int:
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
	
	chr_check_8x16 = []
	chr_check_16x16 = []
	
	# character map for 8x16 font
	for c_id in range(0x01, 0x100):	# skip code 0x00 (will detect space 0x20 instead)
		chr_check_8x16.append((c_id, font_ank[c_id]))
	
	# character map for 16x16 font
	for c_id in range(len(font_jis)):
		# 0x2120..0x217F, 0x2220..0x227F, 0x2320..0x237F, ...
		jis_chr = 0x2120 + (c_id // 0x60 * 0x100) + (c_id % 0x60)
		
		jis1 = (jis_chr >> 8) & 0xFF
		jis2 = (jis_chr >> 0) & 0xFF
		# JIS with 2nd byte 0x20 and 0x7F is unused
		if (jis2 >= 0x21) and (jis2 <= 0x7E):
			if jis1 >= 0x29 and jis1 <= 0x2B:	# half-width characters
				chr_check_8x16.append((jis_chr, font_jis[c_id]))
			else:
				chr_check_16x16.append((jis_chr, font_jis[c_id]))
	
	# load image to transcribe
	screen = PIL.Image.open(config.input)
	screen = screen.convert('1', dither=PIL.Image.Dither.NONE)
	if config.light:
		screen = PIL.ImageOps.invert(screen)
	
	# do the transcription
	if config.output is not None:
		out_file = open(config.output, "wb")
	else:
		out_file = None
	line_id = 0
	y = 0
	while y <= screen.size[1] - 16:
		if config.verbose:
			print(f"Line {1+line_id:2}: ", end='')
		
		x = 0
		while x <= screen.size[0] - 8:
			found_chr = None
			fc_data = None
			
			# At first, try all 16x16 characters.
			if (found_chr is None) and (x <= screen.size[0] - 16):
				screen_chr = screen.crop((x, y, x + 16, y + 16))
				for (c_code, font_chr) in chr_check_16x16:
					diff = PIL.ImageChops.difference(screen_chr, font_chr)
					if not diff.getbbox():
						found_chr = c_code
						fc_data = font_chr
						break
			
			# After that, try matching the smaller 8x16 characters.
			if (found_chr is None) and (x <= screen.size[0] - 8):
				screen_chr = screen.crop((x, y, x + 8, y + 16))
				for (c_code, font_chr) in chr_check_8x16:
					diff = PIL.ImageChops.difference(screen_chr, font_chr)
					if not diff.getbbox():
						found_chr = c_code
						fc_data = font_chr
						break
			
			if found_chr is None:
				if out_file:
					out_file.write(b'?')
				if config.verbose:
					print(f"? ", end='')
				x += 8
			else:
				if found_chr < 0x100:
					if out_file:
						out_file.write(bytes([found_chr]))
					if config.verbose:
						print(f"{found_chr:02X} ", end='')
				else:
					sjis = jis2sjis(found_chr)
					if out_file:
						out_file.write(bytes(sjis))
					if config.verbose:
						print(f"{sjis[0]:02X}{sjis[1]:02X} ", end='')
				x += fc_data.size[0]
		
		if out_file:
			out_file.write(b'\r\n')
			out_file.flush()
		if config.verbose:
			print("", flush=True)
		y += 16
		line_id += 1
	if out_file:
		out_file.close()
	
	return 0

def main(argv):
	global config
	
	print("PC-98-Font Text Transcriber")
	aparse = argparse.ArgumentParser()
	aparse.add_argument("-v", "--verbose", action="store_true", help="print Shift-JIS codes for each character")
	aparse.add_argument("-t", "--thin", action="store_true", help="assume thin font (i.e. don't make full-width charcaters bold)")
	aparse.add_argument("-l", "--light", action="store_true", help="assume black text on white ground (default is white text)")
	aparse.add_argument("-f", "--font", type=str, required=True, help="font image (white background, black text)")
	aparse.add_argument("-i", "--input", type=str, required=True, help="input bitmap file")
	aparse.add_argument("-o", "--output", type=str, required=False, help="output text file (Shift-JIS encoded)")
	
	config = aparse.parse_args(argv[1:])
	if (config.output is None) and (not config.verbose):
		aparse.error("Neither output nor verbose mode is set. Nothing to do.")
	return font_text_transcribe(config)

if __name__ == "__main__":
	sys.exit(main(sys.argv))
# vim: set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab:
