#!/usr/bin/env python3
# This is a small helper tool that I wrote to extract all
# the texts and text references from Dengeki Nurse's NRSOPEN.TCM.
# Written by Valley Bell, 2026-02-28
import sys
import struct

print("NRSOPEN.TCM text -> ASM extractor")
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


SEARCH_TEXT1PTR = bytes([
    #0xBB, 0x??, 0x??,	# mov   bx, offset Text1Ptrs
    0xD1, 0xE0,         # shl   ax, 1
    0x03, 0xD8,         # add   bx, ax
    0xB1, 0x07,         # mov   cl, 7
])
SEARCH_TEXT3PTR = bytes([
    #0xBB, 0x??, 0x??,  # mov   bx, offset Text3Ptrs
    0xD1, 0xE0,         # shl   ax, 1
    0x03, 0xD8,         # add   bx, ax
    0xD1, 0xE0,         # shl   ax, 1
    0x03, 0xD8,         # add   bx, ax
    0xB1, 0x07,         # mov   cl, 7
])
SEARCH_TEXT4PTR = bytes([
    #0xBB, 0x??, 0x??,  # mov   bx, offset Text4Ptrs
    0xC1, 0xE0, 0x03,   # shl   ax, 3
    0x03, 0xD8,         # add   bx, ax
    0xB1, 0x07,         # mov   cl, 7
])
SEARCH_TEXT_SINGLE = bytes([
    #0xBE, 0x??, 0x??,  # mov   si, offset Text3Ptrs
    0x8B, 0x14,         # mov   dx, [si]
    0x83, 0xC6, 0x02,   # add   si, byte 2
    0xB1, 0x07,         # mov   cl, 7
])
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

txt1RefPos = exeData.find(SEARCH_TEXT1PTR)
if txt1RefPos < 0:
    print("Text (x1) pointer list not found!")
    sys.exit(2)
txt1RefPos -= 0x02
txt1Pos = struct.unpack_from("<H", exeData, txt1RefPos)[0]
print(f"Text (x1) pointer list: 0x{txt1Pos:04X}")

txt3RefPos = exeData.find(SEARCH_TEXT3PTR)
if txt3RefPos < 0:
    print("Text (x3) pointer list not found!")
    sys.exit(2)
txt3RefPos -= 0x02
txt3Pos = struct.unpack_from("<H", exeData, txt3RefPos)[0]
print(f"Text (x3) pointer list: 0x{txt3Pos:04X}")

txt4RefPos = exeData.find(SEARCH_TEXT4PTR)
if txt4RefPos < 0:
    print("Text (x4) pointer list not found!")
    sys.exit(2)
txt4RefPos -= 0x02
txt4Pos = struct.unpack_from("<H", exeData, txt4RefPos)[0]
print(f"Text (x4) pointer list: 0x{txt4Pos:04X}")

pos = exeData.find(SEARCH_TEXT_SINGLE)
if pos >= 0:
    txtSingleRefPos = []
    txtSinglePos = set()
    while pos >= 0:
        pos -= 0x02
        txtSingleRefPos.append(pos)
        txtSinglePos.add(struct.unpack_from("<H", exeData, pos)[0])
        pos += 0x02 + len(SEARCH_TEXT_SINGLE)
        pos = exeData.find(SEARCH_TEXT_SINGLE, pos)

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

txt1Ptrs = ReadPtrList(exeData, txt1Pos)
txt3Ptrs = ReadPtrList(exeData, txt3Pos)
txt4Ptrs = ReadPtrList(exeData, txt4Pos)


out_data = []
#out_data.append({"pos": txt1RefPos, "line": f"\tDW\ttxt1PtrList"})
#out_data.append({"pos": txt3RefPos, "line": f"\tDW\ttxt3PtrList"})
#out_data.append({"pos": txt4RefPos, "line": f"\tDW\ttxt4PtrList"})

out_data.append({"pos": txt1Pos, "line": "\n".join([f"Text1Ptrs:\t; {txt1Pos:04X}h"] + PrintPtrList(txt1Ptrs, "txt", 1))})
out_data.append({"pos": txt3Pos, "line": "\n".join([f"Text3Ptrs:\t; {txt3Pos:04X}h"] + PrintPtrList(txt3Ptrs, "txt", 3))})
out_data.append({"pos": txt4Pos, "line": "\n".join([f"Text4Ptrs:\t; {txt4Pos:04X}h"] + PrintPtrList(txt4Ptrs, "txt", 4))})

proc_ptrs = set(od["pos"] for od in out_data)

for ptr in (list(txtSinglePos) + txt1Ptrs + txt3Ptrs + txt4Ptrs):
    if ptr in proc_ptrs:
        continue
    txt = DecodeTextString(exeData, ptr)
    lines = [
        f"txt_{ptr:04X}:\t; \"{txt['text']}\"",
        f"\tDB\t{txt['x']}, {txt['y']}\t; x, y",
        f"\tDB\t{txt['bytes']}",
    ]
    out_data.append({"pos": ptr, "line": "\n".join(lines)})
    proc_ptrs.add(ptr)

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
        val_list = []
        while True:
            val = struct.unpack_from("<H", exeData, pos)[0]
            if val == 0xFFFF:
                #val_list.append(f"0{val:04X}h")
                val_list.append("COLCHG_END")
                break
            y = val // 160
            x = (val % 160) // 2
            if (val % 2) != 0:
                print(f"odd TRAM address: 0x{val:04X}")
            val_list.append(f"tramAddr({x}, {y})")
            pos += 0x02
        out_data.append({"pos": ptr, "line": f"kar_{ptr:04X}:" + "\tDW\t" + ", ".join(val_list)})
        proc_ptrs.add(ptr)



out_data.sort(key=lambda od: od["pos"])
with open(sys.argv[2], "wt", encoding="utf-8") as f:
    f.write("%define\ttramAddr(x,y) (y*80 + x*1) * 2\n")
    f.write("%define\tCOLCHG_END -1\n")
    f.write("\n")
    for od in out_data:
            f.write(od["line"] + "\n")

sys.exit(0)
