#!/usr/bin/env python3
# Written by Valley Bell, 2026-06-22
import sys

print("XOR Encryption Patch Transfer")
if len(sys.argv) < 5:
    print(f"Usage: {sys.argv[0]} decoded-original decoded-patched encrypted-original encrypted-patched")
    sys.exit(1)

fnDecOrg = sys.argv[1]
fnDecMod = sys.argv[2]
fnEncOrg = sys.argv[3]
fnEncMod = sys.argv[4]

print("Loading decoded files ...", flush=True)
with open(fnDecOrg, "rb") as f:
	dataOrg = f.read()
with open(fnDecMod, "rb") as f:
	dataMod = f.read()
if len(dataOrg) != len(dataMod):
	print("Error: The two decoded files must have the same size!")
	sys.exit(2)

# create patch XOR mask
print("Creating patch mask ...", flush=True)
modMask = bytearray(b'\x00' * len(dataOrg))
for pos in range(len(dataOrg)):
	modMask[pos] = dataOrg[pos] ^ dataMod[pos]


print("Loading encoded file ...", flush=True)
with open(fnEncOrg, "rb") as f:
	dataOrg = f.read()

print("Applying patch ...", flush=True)
patchLen = min(len(modMask), len(dataOrg))
dataMod = bytearray(dataOrg)
# apply patch to the encrypted original
for pos in range(patchLen):
	dataMod[pos] ^= modMask[pos]

print("Writing encoded file ...", flush=True)
with open(fnEncMod, "wb") as f:
	f.write(dataMod)

print("Done.", flush=True)
