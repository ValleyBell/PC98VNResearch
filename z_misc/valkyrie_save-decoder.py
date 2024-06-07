#!/usr/bin/env python3
# Valkyrie: The Power Beauties save game decryption tool
# Written by Valley Bell, 2024-06-07
import sys
import os
import struct
import typing
import argparse

def check_file_size(f) -> int:
    f.seek(0, 2)
    fsize = f.tell()
    f.seek(0, 0)
    if fsize < 0x840:
        print("Not a Valkyrie story save: File too small!")
        return 1
    elif fsize >= 0x860:
        print("Not a Valkyrie story save: File too large!")
        return 2
    else:
        return 0

def byte_rotate_left(val: int, bits: int) -> int:
    return ((val << bits) | (val >> (8 - bits))) & 0xFF

def byte_rotate_right(val: int, bits: int) -> int:
    return ((val >> bits) | (val << (8 - bits))) & 0xFF

def decrypt_sav_file(savData: bytearray, startPos: int, endPos: int) -> int:
    for pos in range(endPos - 2, startPos + 0x02, -2):
        # algorithm:
        #   MOV     AX, [SI]    ; val = int16 @ buffer[pos], L = low 8 bits, H = high 8 bits
        #   NOT     AH          ; invert H
        #   NEG     AL          ; negate sign of L (bitwise invert, then add 1)
        #   XOR     AX, [SI-2]  ; XOR with int16 @ buffer[pos-2] (Note: missing during last iteration)
        #   ROR     AH, 2       ; rotate H to the right by 2 bits
        #   ROL     AL, 2       ; rotate L to the left by 2 bits
        #   MOV     [SI], AX    ; store to int16 @ buffer[pos]
        valH = savData[pos + 1]
        valL = savData[pos + 0]
        valH ^= 0xFF                # NOT AH
        valL = (-valL) & 0xFF       # NEG AL
        valH ^= savData[pos - 1]    # XOR AX, [SI-2]
        valL ^= savData[pos - 2]    # XOR AX, [SI-2]
        valH = byte_rotate_right(valH, 2)   # ROR AH, 2
        valL = byte_rotate_left(valL, 2)    # ROL AL, 2
        savData[pos + 1] = valH
        savData[pos + 0] = valL
    valH = savData[startPos + 1]
    valL = savData[startPos + 0]
    valH ^= 0xFF                # NOT AH
    valL = (-valL) & 0xFF       # NEG AL
    valH = byte_rotate_right(valH, 2)   # ROR AH, 2
    valL = byte_rotate_left(valL, 2)    # ROL AL, 2
    savData[startPos + 1] = valH
    savData[startPos + 0] = valL
    
    return 0


# --- encoding ---
def encrypt_sav_file(savData: bytearray, startPos: int, endPos: int) -> int:
    lastL = 0x00
    lastH = 0x00
    for pos in range(startPos, endPos, +2):
        # algorithm:
        #   LODSW               ; val = int16 @ buffer[pos], L = low 8 bits, H = high 8 bits
        #   ROL     AH, 2       ; rotate H to the left by 2 bits
        #   ROR     AL, 2       ; rotate L to the right by 2 bits
        #   XOR     AX, BX      ; XOR with previous value
        #   NOT     AH          ; invert H
        #   NEG     AL          ; negate sign of L (bitwise invert, then add 1)
        #   MOV     [SI-2], AX  ; store to int16 @ buffer[pos]
        #   MOV     BX, AX      ; save value in BX for next iteration
        valH = savData[pos + 1]
        valL = savData[pos + 0]
        valH = byte_rotate_left(valH, 2)    # ROL AH, 2
        valL = byte_rotate_right(valL, 2)   # ROR AL, 2
        valH ^= lastH               # XOR AX, [SI-2]
        valL ^= lastL               # XOR AX, [SI-2]
        valH ^= 0xFF                # NOT AH
        valL = (-valL) & 0xFF       # NEG AL
        savData[pos + 1] = valH
        savData[pos + 0] = valL
        lastH = valH
        lastL = valL
    
    return 0

def main(argv):
    print("Valkyrie save game decryption tool")
    aparse = argparse.ArgumentParser()
    apgrp = aparse.add_mutually_exclusive_group(required=True)
    apgrp.add_argument("-d", "--decrypt", action="store_true", help="decrypt save game")
    apgrp.add_argument("-e", "--encrypt", action="store_true", help="re-encrypt save game")
    aparse.add_argument("in_file", help="input DATA#.SAV")
    aparse.add_argument("out_file", help="output DATA#.SAV")

    ap_args = aparse.parse_args(argv[1:])

    with open(ap_args.in_file, "rb") as f:
        fsck = check_file_size(f)
        if fsck != 0:
            return fsck
        savData = bytearray(f.read())
    
    nameLen = struct.unpack_from("<H", savData, 0x08)[0];
    
    basePos = 0x40 + nameLen
    if ap_args.decrypt:
        res = decrypt_sav_file(savData, basePos, basePos + 0x800)
    elif ap_args.encrypt:
        res = encrypt_sav_file(savData, basePos, basePos + 0x800)
    
    with open(ap_args.out_file, "wb") as f:
        f.write(savData)
    
    return res

if __name__ == "__main__":
    sys.exit(main(sys.argv))
