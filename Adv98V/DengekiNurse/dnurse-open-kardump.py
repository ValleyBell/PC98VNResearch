#!/usr/bin/env python3
# This is a small helper tool for extracting the karaoke colour
# change data from Dengeki Nurse's NRSOPEN.TCM.
# Written by Valley Bell, 2026-02-28
import sys
import struct

print("NRSOPEN.TCM karaoke -> ASM extractor")
if len(sys.argv) < 3:
    print(f"Usage: {sys.argv[0]} NRSOPEN.TCM output.asm")
    sys.exit(1)

def byte2asm_num(val: int) -> str:
    if val < 0xA0:
        return f"{val:02X}h"
    else:
        return f"0{val:02X}h"

def dump_as_str(data: bytes) -> list:
    global ASCII_FULLWIDTH

    result = []
    pos = 0
    lastIsStr = False
    while pos < len(data):
        ch = None
        if data[pos] < 0x80:
            ch = chr(data[pos])
            if (ch in ['"', "'", '\\']) or (not ch.isprintable()):
                if lastIsStr:
                    result[-1] = '"' + result[-1] + '"'
                    lastIsStr = False
                if data[pos] == 0:
                    result.append(f"{data[pos]}")
                else:
                    result.append(byte2asm_num(data[pos]))
            else:
                if not lastIsStr:
                    result.append("")
                    lastIsStr = True
                result[-1] += ch
            pos += 1
        else:
            if lastIsStr:
                result[-1] = '"' + result[-1] + '"'
                lastIsStr = False
            result.append(byte2asm_num(data[pos + 0]))
            result.append(byte2asm_num(data[pos + 1]))
            pos += 2
    if lastIsStr:
        result[-1] = '"' + result[-1] + '"'
        lastIsStr = False
    return ", ".join(result)

def decode_sjis(data: bytes) -> str:
    try:
        return data.decode("cp932")
    except UnicodeDecodeError:
        return "unsupported Shift-JIS"

def ReadPtrList(data: bytes, startPos: int) -> list:
    maxPos = 0xFFFFFFFF
    pos = startPos
    result = []
    while pos < maxPos:
        ptr = struct.unpack_from("<H", data, pos)[0]
        result.append(ptr)
        maxPos = min(ptr, maxPos)
        pos += 0x02
    return result

def DecodeTextString(data: bytes, startPos: int) -> dict:
    x = data[startPos + 0]
    y = data[startPos + 1]
    endPos = data.find(b'\x00', startPos + 2) + 1   # include the terminating byte
    tBytes = data[startPos+2 : endPos]
    dataText = dump_as_str(tBytes)
    sjis_text = decode_sjis(tBytes.rstrip(b'\x00'))
    return {"x": x, "y": y, "bytes": dataText, "text": sjis_text}

def PrintPtrList(ptrs: list, prefix: str, groupSize: int) -> list:
    ptr_lines = []
    
    remGrp = groupSize
    ptr_lines.append([])
    for ptr in ptrs:
        if remGrp == 0:
            ptr_lines.append([])
            remGrp = groupSize
        ptr_lines[-1].append(f"{prefix}_{ptr:04X}")
        remGrp -= 1
    
    res_lines = []
    elementIdx = 0
    for pl in ptr_lines:
        elCount = len(pl)
        ptrs_list = ", ".join(pl)
        if groupSize <= 1:
            res_lines.append(f"\tDW\t{ptrs_list}\t; {elementIdx}")
        else:
            res_lines.append(f"\tDW\t{ptrs_list}\t; {elementIdx} .. {elementIdx+elCount-1}")
        elementIdx += elCount
    return res_lines


#SEARCH_COLCHG = bytes([
#    0x8B, 0xDE,             # mov   bx, si
#    0xBE, 0x??, 0x??,       # mov   si, offset ColorList
#    [v1] 0x33, 0xC0         # xor   ax, ax [variant 1]
#    [v2] 0xB8, 0x??, 0x00,  # mov   ax, ?? [variant 2]
#    0xE8, 0x??, 0x??,       # call  ChangeCharColor
#    0x8B, 0xF3              # mov   si, bx
#    0xC3                    # retn
#])
SEARCH_COLCHG = bytes([0x8B, 0xDE, 0xBE])       # This byte sequence seems to be sufficient to identify the blocks


with open(sys.argv[1], "rb") as f:
    exeData = f.read()

pos = exeData.find(SEARCH_COLCHG)
if pos < 0:
    print("Colour Change pointer list not found!")
    sys.exit(2)
colChgRefPos = []
colChgPosList = set()
while pos >= 0:
    pos += len(SEARCH_COLCHG)
    colChgRefPos.append(pos)
    colChgPosList.add(struct.unpack_from("<H", exeData, pos)[0])
    pos = exeData.find(SEARCH_COLCHG, pos)

ccListStr = [f"0x{pos:04X}" for pos in sorted(colChgPosList)]
print("Colour Change lists: [" + ", ".join(ccListStr) + "]")


out_data = []

proc_ptrs = set(od["pos"] for od in out_data)

for plPos in colChgPosList:
    if plPos in proc_ptrs:
        continue
    ccPtrList = ReadPtrList(exeData, plPos)
    out_data.append({"pos": plPos, "line": "\n".join([f"karPtrs_{plPos:04X}:"] + PrintPtrList(ccPtrList, "kar", 1))})
    proc_ptrs.add(plPos)
    
    for ptr in ccPtrList:
        if ptr in proc_ptrs:
            continue
        pos = ptr
        coord_list = []
        while True:
            val = struct.unpack_from("<H", exeData, pos)[0]
            if val == 0xFFFF:
                break
            y = val // 160
            x = (val % 160) // 2
            if (val % 2) != 0:
                print(f"odd TRAM address: 0x{val:04X}")
            coord_list.append((x, y))
            pos += 0x02
        
        (prevX, prevY) = (-1, -1)
        changeLenX = 0
        val_list = []
        for coord in coord_list:
            if (coord[0] == (prevX + changeLenX)) and (coord[1] == prevY):
                pass
            else:
                if changeLenX > 0:
                    val_list.append("f\tCOLCHG\t{prevX}, {prevY}, {changeLenX}")
                (prevX, prevY) = coord
                changeLenX = 0
            changeLenX += 1
        if changeLenX > 0:
            val_list.append(f"\tCOLCHG\t{prevX}, {prevY}, {changeLenX}")
        val_list.append(f"\tCOLCHG_END")
        out_data.append({"pos": ptr, "line": "\n".join([f"kar_{ptr:04X}:"] + val_list)})
        proc_ptrs.add(ptr)



out_data.sort(key=lambda od: od["pos"])
with open(sys.argv[2], "wt", encoding="utf-8") as f:
    f.write("%macro\tCOLCHG\t3\n\tDB\t%3, %1, %2\t; x, y, width\n%endmacro\n")
    f.write("%macro\tCOLCHG_END\t0\n\tDB\t0\t; width 0 -> end\n%endmacro\n")
    f.write("\n")
    for od in out_data:
            f.write(od["line"] + "\n")

sys.exit(0)
