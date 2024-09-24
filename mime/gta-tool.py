#!/usr/bin/env python3
# GTA <-> PI conversion tool
# Written by Valley Bell, 2024-09-20
import sys
import struct
import typing
import argparse

config = {}

PI_HDR = bytes([0x50, 0x69, 0x1A, 0x00, 0x00, 0x01, 0x01, 0x04, 0x57, 0x49, 0x4E, 0x2A, 0x00, 0x00])

def decode_palette(gtaPal: bytes) -> bytes:
	palData = []
	remBytes = 24
	pos = 0
	while remBytes > 0:
		#val = (gtaPal[pos] ^ 0xFF) ^ remBytes	# this is what the ASM code does
		val = gtaPal[pos] ^ (0xFF - remBytes)	# equivalent calculation
		nib_low = (val >> 0) & 0x0F	# MIME uses 00..0F internally
		nib_high = (val >> 4) & 0x0F
		palData.append(nib_low << 4)	# output 00..F0 instead, as this is what the PI format expects
		palData.append(nib_high << 4)
		pos += 1
		remBytes -= 1
	return bytes(palData)

def encode_palette(piPal: bytes) -> bytes:
	palData = []
	remBytes = 24
	pos = 0
	while remBytes > 0:
		nib_low = piPal[pos + 0x00] >> 4
		nib_high = piPal[pos + 0x01] >> 4
		val = (nib_high << 4) | (nib_low << 0)
		#val = (val ^ remBytes) ^ 0xFF
		val ^= (0xFF - remBytes)
		palData.append(val)
		pos += 2
		remBytes -= 1
	return bytes(palData)

def gta2pi(fn_in: str, fn_out: str) -> int:
	with open(fn_in, "rb") as f:
		gtaHdr = f.read(0x10)
		if gtaHdr[0:0x0A] != b"GTA_FORMAT":
			print("Not a GTA file!")
			return 1
		(imgWidth, imgHeight, imgFlags) = struct.unpack_from("<HHH", gtaHdr, 0x0A)
		gtaPal = f.read(24)	# 48 nibbles
		piData = f.read()
	
	piPal = decode_palette(gtaPal)
	piHdr = PI_HDR + struct.pack(">HH", imgWidth, imgHeight)
	print(f"Image size: {imgWidth}x{imgHeight}")
	print(f"Image flags: 0x{imgFlags:04X}")
	
	with open(fn_out, "wb") as f:
		f.write(piHdr)
		f.write(piPal)
		f.write(piData)
	return 0

def pi2gta(fn_in: str, fn_out: str) -> int:
	global config
	
	with open(fn_in, "rb") as f:
		data = f.read()
		if data[0:0x02] != b'Pi':
			print("Not a PI image!")
			return 1
		
		hdr_ofs = data.find(b'\x1A\x00')
		if hdr_ofs < 0:
			print("Unable to find start of image header!")
			return 1
		hdr_ofs += 0x02
		
		bit_depth = data[hdr_ofs + 0x03]
		if bit_depth != 4:
			print(f"Bit depth is {bit_depth} bits! Only 4-bit PI images can be converted!")
			return 1
		compr_size = struct.unpack_from(">H", data, hdr_ofs + 0x08)[0]
		start_ofs = hdr_ofs + 0x0A + compr_size	# usually 0x0E
	
	pos = start_ofs
	(imgWidth, imgHeight) = struct.unpack_from(">HH", data, pos)
	imgFlags = config.flags
	pos += 4
	piPal = data[pos : pos+48]	# 16 colors * components
	data_pos = pos + 48
	
	gtaPal = encode_palette(piPal)
	gtaHdr = b"GTA_FORMAT" + struct.pack("<HHH", imgWidth, imgHeight, imgFlags)
	print(f"Image size: {imgWidth}x{imgHeight}")
	print(f"Image flags: 0x{imgFlags:04X}")
	
	with open(fn_out, "wb") as f:
		f.write(gtaHdr)
		f.write(gtaPal)
		f.write(data[data_pos:])
	return 0

def auto_int(x):
	return int(x, 0)

def main(argv):
	global config
	
	print("MIME GTA tool")
	aparse = argparse.ArgumentParser()
	apgrp = aparse.add_mutually_exclusive_group(required=True)
	apgrp.add_argument("-d", "--decode", action="store_true", help="decode GTA file into BMP/PNG/...")
	apgrp.add_argument("-e", "--encode", action="store_true", help="encode BMP/PNG/... into GTA")
	aparse.add_argument("-f", "--flags", type=auto_int, default=0xFFFF, help="set image flags for output GTA file")
	aparse.add_argument("-i", "--input", type=str, required=True, help="input file")
	aparse.add_argument("-o", "--output", type=str, required=True, help="output file")
	
	config = aparse.parse_args(argv[1:])
	if config.decode:
		return gta2pi(config.input, config.output)
	elif config.encode:
		return pi2gta(config.input, config.output)
	return 1

if __name__ == "__main__":
	sys.exit(main(sys.argv))
# vim: set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab:
