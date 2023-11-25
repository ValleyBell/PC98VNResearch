#!/usr/bin/env python3
# Waku Waku Mahjong Panic! 2 Scenario De-/Encoder
# Written by Valley Bell, 2023-11-15
# works with .DSD files, as well as 2JC##.DAT/FC4##.DAT
import sys
import argparse

print("Waku Waku Mahjong Panic! 2 Scenario De-/Encoder")
aparse = argparse.ArgumentParser()
apgrp = aparse.add_mutually_exclusive_group(required=True)
apgrp.add_argument("-e", "--encode", action="store_true", help="encode scenario file")
apgrp.add_argument("-d", "--decode", action="store_true", help="decode scenario file")
aparse.add_argument("input_file", help="input DSD file")
aparse.add_argument("output_file", help="output DSD file")
config = aparse.parse_args(sys.argv[1:])

with open(config.input_file, "rb") as f:
	data = bytearray(f.read())

real_size = len(data)
if (len(data) % 2) != 0:
	data += b'\x00'	# make size a multiple of 2 for easier processing

if config.decode:
	# disassembly of the decryption function:
	# loc_10166:
	#       mov     cx, 2328h
	#       mov     si, 4Ah
	#       [...]
	# loc_1017A:
	#       dec     byte ptr [si]   ; decrement 1st byte
	#       inc     byte ptr [si+1] ; increment 2nd byte
	#       add     si, 2
	#       loop    loc_1017A
	for pos in range(0, len(data), 2):
		data[pos + 0] = (data[pos + 0] - 1) & 0xFF
		data[pos + 1] = (data[pos + 1] + 1) & 0xFF
elif config.encode:
	# encoding:
	# - increment 1st byte
	# - decrement 2nd byte
	for pos in range(0, len(data), 2):
		data[pos + 0] = (data[pos + 0] + 1) & 0xFF
		data[pos + 1] = (data[pos + 1] - 1) & 0xFF

data = data[:real_size]

with open(config.output_file, "wb") as f:
	f.write(data)
