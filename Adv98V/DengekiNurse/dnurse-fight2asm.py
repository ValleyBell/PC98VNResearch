#!/usr/bin/env python3
# This is a small helper tool that I wrote to extract all
# the texts and text references from Dengeki Nurse's NRSFIGHT.CMD.
# Written by Valley Bell, 2026-03-04
import sys
import struct

print("NRSFIGHT.CMD text -> ASM extractor")
if len(sys.argv) < 3:
    print(f"Usage: {sys.argv[0]} NRSFIGHT.CMD output.asm")
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

def EscapeText(text: str) -> str:
    result = '"'
    for (pos, c) in enumerate(text):
        if ord(c) < 0x20:
            result += f'", {ord(c):02X}h, "'
            #result += f"\\x{ord(c):02X}"
        else:
            result += c
    result += '"'
    while '"", ' in result:
        result = result.replace('"", ', '')
    result = result.replace(', ""', '')
    return result

def DecodeTextString(data: bytes, startPos: int) -> dict:
    endPos = data.find(b'\x00', startPos) + 1   # include the terminating byte
    tBytes = data[startPos : endPos]
    dataText = dump_as_str(tBytes)
    sjis_text = decode_sjis(tBytes.rstrip(b'\x00'))
    return {"bytes": dataText, "text": EscapeText(sjis_text)}

def PrintPtrList(ptrNames: list, groupSize: int) -> list:
    ptr_lines = []
    
    remGrp = groupSize
    ptr_lines.append([])
    for pName in ptrNames:
        if remGrp == 0:
            ptr_lines.append([])
            remGrp = groupSize
        ptr_lines[-1].append(pName)
        remGrp -= 1
    
    res_lines = []
    elementIdx = 0
    for pl in ptr_lines:
        elCount = len(pl)
        ptrs_list = ", ".join(pl)
        res_lines.append(f"\tDW\t{ptrs_list}")
        #if groupSize <= 1:
        #    res_lines.append(f"\tDW\t{ptrs_list}\t; {elementIdx}")
        #else:
        #    res_lines.append(f"\tDW\t{ptrs_list}\t; {elementIdx} .. {elementIdx+elCount-1}")
        elementIdx += elCount
    return res_lines


with open(sys.argv[1], "rb") as f:
    exeData = f.read()

DATASEG_BASEOFS = 0x50D0

singlePtrs = [
	#(offset, flags, name)
	# set flag to 1 to indicate "direct pointer" that keeps addresses in comments
	(0x0324, 1, "fnD1CVC6"),
	(0x04E7, 1, "txtHealth"),
	(0x04EE, 1, "txtAttack"),
	(0x04F5, 1, "txtDefense"),
	(0x0504, 1, "tCoord5"),
	(0x12C1, 1, "tCoord6"),
	(0x18FF, 1, "tCoord7"),
]
ptrLists = [
	#(offset, list name, pointer name pattern)
	(0x0124, "fnListD1CVC", "fnD1CVC{0:02}"),
	(0x019C, "fnListD1Enm", "fnD1Enm{0:02X}"),
	(0x035E, "tCoordLst1", "tCoord1_{0:01}"),
	(0x0394, "tListActions", "txtAction{0:02X}"),
	(0x047E, "tCoordLst2", "tCoord2_{0:01}"),
	(0x04A1, "tCoordLst3", "tCoord3_{0:01}"),
	(0x04C4, "tCoordLst4", "tCoord4_{0:01}"),
	(0x0514, "tListMessages", "txtMsg{0:02X}"),
	(0x12D1, "tListPlayer", "txtPlr{0:02X}"),
]
ptrPtrLists = [
	#(offset, list 1 name, list 2 name pattern, pointer name pattern)
	(0x190F, "tListEnemy", "tLstEnemy{0:02}", "txtEnm{0:02X}_{1}"),
]


PTYPE_PTRS = 1
PTYPE_STR = 2

# At first, collect all data. (read pointer lists, then read text data)
proc_ptrs = dict()
for (pplPos, pplName, plNamePat, pNamePat) in ptrPtrLists:
    if pplPos in proc_ptrs:
        continue
    
    pPtrList = ReadPtrList(exeData[DATASEG_BASEOFS:], pplPos)
    proc_ptrs[pplPos] = {"type": PTYPE_PTRS, "name": pplName, "data": pPtrList}
    
    for (pId, pos) in enumerate(pPtrList):
        if pos in proc_ptrs:
            continue
        plName = plNamePat.format(pId)
        pNamePat2 = pNamePat.format(pId, "{0}")
        ptrLists.append((pos, plName, pNamePat2))

for (plPos, plName, pNamePat) in ptrLists:
    if plPos in proc_ptrs:
        continue
    
    ptrList = ReadPtrList(exeData[DATASEG_BASEOFS:], plPos)
    proc_ptrs[plPos] = {"type": PTYPE_PTRS, "name": plName, "data": ptrList}
    
    for (pId, pos) in enumerate(ptrList):
        if pos in proc_ptrs:
            continue
        pName = pNamePat.format(pId)
        singlePtrs.append((pos, 0, pName))

for (pos, pFlags, pName) in singlePtrs:
    if pos in proc_ptrs:
        continue
    txt = DecodeTextString(exeData[DATASEG_BASEOFS:], pos)
    proc_ptrs[pos] = {"type": PTYPE_STR, "flags": pFlags, "name": pName, "data": txt}


# Then generate the output file.
with open(sys.argv[2], "wt", encoding="utf-8") as f:
    f.write("\tincbin \"NRSFIGHT.CMD\", $, 0124h - ($-$$+DATA_BASE_OFS)\n\n")
    lastMode = 0
    for (pos, pinfo) in sorted(proc_ptrs.items()):
        if pinfo["type"] == PTYPE_PTRS:
            if lastMode != 0:
                f.write("\n")   # additional empty line before pointer lists
            plName = pinfo["name"]
            pNames = [proc_ptrs[ptr]["name"] for ptr in pinfo["data"]]
            f.write(f"{plName}:\t; {pos:04X}h\n")
            f.write("\n".join(PrintPtrList(pNames, 1)) + "\n")
            lastMode = 0
        elif pinfo["type"] == PTYPE_STR:
            comments = []
            if pinfo["flags"] & 0x01:
                comments.append(f"{pos:04X}h")
            if not pinfo['data']['text'].isascii():
                comments.append(pinfo['data']['text'])
            
            lbl_line = pinfo['name'] + ":"
            if len(comments) > 0:
                lbl_line += "\t; " + " ".join(comments)
            f.write(lbl_line + "\n")
            f.write(f"\tDB\t{pinfo['data']['bytes']}\n")
            lastMode = 1
    f.write("\n\ttimes 36B6h-($-$$-DATA_BASE_OFS) db 00h\n")

sys.exit(0)
