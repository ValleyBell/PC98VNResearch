#!/usr/bin/env python3
import sys

if len(sys.argv) < 3:
	print("four-nine/Izuho Saruta System-98 Scenario De-/Encoder")
	print("Usage: {} input.bin output.bin")
	sys.exit(1)

PI_HDR = bytes([0x50, 0x69, 0x1A, 0x00, 0x00, 0x01, 0x01, 0x04, 0x57, 0x49, 0x4E, 0x2A, 0x00, 0x00])

with open(sys.argv[1], "rb") as f:
	data = f.read()

with open(sys.argv[2], "wb") as f:
	f.write(PI_HDR)
	f.write(data)
