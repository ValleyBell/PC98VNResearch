#!/usr/bin/env python3
# This is a small helper tool that I wrote to extract all
# the texts and text references from DUNGEON.EXE from "Dragoon Armor For Adult".
# Written by Valley Bell, 2026-04-30
import sys
import struct

print("DUNGEON.EXE text -> ASM extractor")
if len(sys.argv) < 3:
    print(f"Usage: {sys.argv[0]} DUNGEON.EXE output.asm")
    print("IMPORTANT: The EXE file must be decrypted and decompressed!")
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

def StrFindOneOf(data: str, pattern: str, startpos: int) -> int:
    pos = startpos
    while pos < len(data):
        if data[pos] in pattern:
            return pos
        pos += 1
    return -1

def DecodeTextString(data: bytes, startPos: int, endbytes: list) -> dict:
    endPos = StrFindOneOf(data, endbytes, startPos) + 1   # include the terminating byte
    tBytes = data[startPos : endPos]
    dataText = dump_as_str(tBytes)
    sjis_text = decode_sjis(tBytes.rstrip(b'\x00'))
    return {"len": endPos - startPos, "bytes": dataText, "text": EscapeText(sjis_text)}

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

def strfind_wildcard(data: bytes, pattern: bytes, wildcard: int, startpos: int = 0) -> int:
    for pos in range(startpos, len(data) - len(pattern) + 1):
        match = True
        for patpos in range(len(pattern)):
            if pattern[patpos] != wildcard and \
                data[pos + patpos] != pattern[patpos]:
                match = False
                break
        if match:
            return pos
    return -1

def find_next_ptr(ptrs: dict, startpos: int) -> int:
    plist = [p for p in ptrs if p >= startpos]
    if len(plist) == 0:
        return -1
    else:
        return sorted(plist)[0]

def ptr2str(ptr: int) -> str:
    ptrstr = f"{ptr:04X}h"
    if not ptrstr[0].isdigit():
        ptrstr = '0' + ptrstr
    return ptrstr


with open(sys.argv[1], "rb") as f:
    exeData = f.read()

DATASEG_BASEOFS = 0x0070
CODESEG_BASEOFS = 0xD3D0


SEARCH_TEXT1PTR_1 = bytes([
    0x33, 0xC0,         # xor   ax, ax
    0xBE, 0xAA, 0xAA,   # mov   si, textPtr
    0xCD, 0xF0,         # int   0F0h    ; MESPUT - print message
])
SEARCH_TEXT1PTR_2 = bytes([
    0xBE, 0xAA, 0xAA,   # mov   si, textPtr
    0xB4, 0x04,         # mov   ah, 4
    0xCD, 0xF0,         # int   0F0h    ; MESPUT - clear box and print message
])
SEARCH_TEXT1PTR_3 = bytes([
    0xBE, 0xAA, 0xAA,   # mov   si, textPtr
    0xB4, 0x09,         # mov   ah, 9
    0xCD, 0xF0,         # int   0F0h    ; MESPUT - print message
])
SEARCH_TEXT1PTR_DOSPRINT = bytes([
    0xBA, 0xAA, 0xAA,   # mov   dx, textPtr
    0xB4, 0x09,         # mov   ah, 9
    0xCD, 0x21,         # int   21h     ; DOS - PRINT STRING
])

ptrRefs = [
    #(offset, type, ptr)
    #(0x1234, "MOV", 0x5678),
]
singlePtrs = [
    #(offset, flags, name)
    # set flag to 1 to indicate "direct pointer" that keeps addresses in comments
    # set flag to 2 to indicate "DOS print", which ends only with byte 0x24 '$'
    #(0x0324, 1, "fnD1CVC6"),
]
ptrLists = [
    #(offset, list name, pointer name pattern)
    (0x0947, "tList0947", "t0947_{0:02}"),
]
ptrPtrLists = [
    #(offset, list 1 name, list 2 name pattern, pointer name pattern)
    (0x061E, "tListEquip", "tLstEqp{0:02}", "txtEqp{0:02X}_{1}"),
]


for searchT1 in [SEARCH_TEXT1PTR_1, SEARCH_TEXT1PTR_2, SEARCH_TEXT1PTR_3]:
    searchOfs = searchT1.find(0xAA)
    pos = strfind_wildcard(exeData, searchT1, 0xAA)
    while pos >= 0:
        ptr = struct.unpack_from("<H", exeData, pos + searchOfs)[0]
        singlePtrs.append((ptr, 0, f"txt_{ptr:04X}"))
        ptrRefs.append((pos + searchOfs - 1, "MOV", ptr))
        pos += len(searchT1)
        pos = strfind_wildcard(exeData, searchT1, 0xAA, pos)
for searchT1 in [SEARCH_TEXT1PTR_DOSPRINT]:
    searchOfs = searchT1.find(0xAA)
    pos = strfind_wildcard(exeData, searchT1, 0xAA)
    while pos >= 0:
        ptr = struct.unpack_from("<H", exeData, pos + searchOfs)[0]
        singlePtrs.append((ptr, 2, f"txt_{ptr:04X}"))
        ptrRefs.append((pos + searchOfs - 1, "MOV", ptr))
        pos += len(searchT1)
        pos = strfind_wildcard(exeData, searchT1, 0xAA, pos)


PTYPE_PTRS = 1
PTYPE_STR = 2
PTYPE_REF = 3

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
    if pFlags & 0x02:
        txt = DecodeTextString(exeData[DATASEG_BASEOFS:], pos, [0x00, 0x24])
    else:
        txt = DecodeTextString(exeData[DATASEG_BASEOFS:], pos, [0x00, 0x0A, 0x24])
    proc_ptrs[pos] = {"type": PTYPE_STR, "flags": pFlags, "name": pName, "data": txt}

for (pos, rType, ptr) in ptrRefs:
    if pos in proc_ptrs:
        continue
    
    byteCode = exeData[pos]
    if byteCode == 0xBE:
        (asmCmd, asmReg) = ("mov", "si")
    elif byteCode == 0xBA:
        (asmCmd, asmReg) = ("mov", "dx")
    else:
        printf("Unknown instruction code: 0x{byteCode:02X}!")
        continue
    
    proc_ptrs[pos] = {"type": PTYPE_REF, "data": {"cmd": asmCmd, "reg": asmReg, "ptr": ptr}}



# Then generate the output file.
with open(sys.argv[2], "wt", encoding="utf-8") as f:
    f.write("\tuse16\n")
    f.write("\tcpu\t186\n")
    f.write(f"DATA_BASE_OFS EQU {ptr2str(DATASEG_BASEOFS)}\n")
    f.write(f"CODE_BASE_OFS EQU {ptr2str(CODESEG_BASEOFS)}\n")
    f.write("\n")
    f.write("\torg\t-DATA_BASE_OFS\n")
    f.write("\n")
    
    lastMode = 0
    pend = 0
    for (pos, pinfo) in sorted(proc_ptrs.items()):
        plen = 0
        if pinfo["type"] == PTYPE_PTRS:
            if lastMode != 0:
                f.write("\n")   # additional empty line before pointer lists
            if pend < pos:
                f.write(f"\tincbin \"DUNGEON.DEC2.EXE\", $, {ptr2str(pos)} - ($-$$-DATA_BASE_OFS)\n")
            plName = pinfo["name"]
            pNames = [proc_ptrs[ptr]["name"] for ptr in pinfo["data"]]
            f.write(f"{plName}:\t; {ptr2str(pos)}\n")
            f.write("\n".join(PrintPtrList(pNames, 1)) + "\n")
            plen = len(pinfo["data"]) * 0x02
            lastMode = 0
        elif pinfo["type"] == PTYPE_STR:
            if pend < pos:
                f.write(f"\tincbin \"DUNGEON.DEC2.EXE\", $, {ptr2str(pos)} - ($-$$-DATA_BASE_OFS)\n")
            comments = []
            if pinfo["flags"] & 0x01:
                comments.append(ptr2str(pos))
            if not pinfo['data']['text'].isascii():
                comments.append(pinfo['data']['text'])
            
            lbl_line = pinfo['name'] + ":"
            if len(comments) > 0:
                lbl_line += "\t; " + " ".join(comments)
            f.write(lbl_line + "\n")
            f.write(f"\tdb\t{pinfo['data']['bytes']}\n")
            plen = pinfo["data"]["len"]
            lastMode = 1
        elif pinfo["type"] == PTYPE_REF:
            if pend < pos:
                codepos = pos - CODESEG_BASEOFS
                f.write(f"\tincbin \"DUNGEON.DEC2.EXE\", $, {ptr2str(codepos)} - ($-$$-CODE_BASE_OFS)\n")
            refCmd = pinfo["data"]["cmd"]
            refReg = pinfo["data"]["reg"]
            ptr = pinfo["data"]["ptr"]
            refPtr = proc_ptrs[ptr]["name"]
            f.write(f"\t{refCmd}\t{refReg}, {refPtr}\n")
            f.write(f"\n")
            plen = 3
            lastMode = 2
        pend = pos + plen
        
        pnext = find_next_ptr(proc_ptrs, pend)
        if pend < pnext and lastMode != 2:
            if pend < CODESEG_BASEOFS:
                ofsptr = pend
                ofsbase = "DATA_BASE_OFS"
            else:
                ofsptr = pend - CODESEG_BASEOFS
                ofsbase = "CODE_BASE_OFS"
            f.write(f"\ttimes {ptr2str(ofsptr)}-($-$$-{ofsbase}) db 00h\n")
            if pend + 0x10 <= pnext:
                f.write(f"\n")
    
    f.write(f"\tincbin \"DUNGEON.DEC2.EXE\", $\n")

sys.exit(0)
