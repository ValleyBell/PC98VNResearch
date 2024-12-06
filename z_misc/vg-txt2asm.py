#!/usr/bin/env python3
# This is just a small helper tool that I wrote to extract all
# the texts and text references from VG.EXE.
# There are 172 (!) texts it extracts.
# Written by Valley Bell, 2024-12-03
import sys

print("VG.EXE text -> ASM extractor")
if len(sys.argv) < 3:
    print(f"Usage: {sys.argv[0]} VG.EXE output.asm")
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

SEARCH_SEG0 = bytes([0x55, 0x8B, 0xEC, 0x83])
SEARCH_1 = b"b:vg02"
SEARCH_OFS1 = 0x0316
SEARCH_2 = bytes([0x43, 0x00, 0xE8, 0x26])

MORE_STR_OFS = [
    (0x1EFC, 0x1F86),
]

with open(sys.argv[1], "rb") as f:
    exeData = f.read()

pos1 = exeData.find(SEARCH_1)
if pos1 < 0:
    print("Start string not found!")
    sys.exit(2)
pos2 = exeData.find(SEARCH_2, pos1)
if pos2 < 0:
    print("End string not found!")
    sys.exit(2)

SEG026_OFS = pos1 - SEARCH_OFS1
str_scan_regions = [
    (pos1, pos2),
]
for str_ofs in MORE_STR_OFS:
    str_scan_regions.append((SEG026_OFS + str_ofs[0], SEG026_OFS + str_ofs[1]))

#print(str_scan_regions)

SEG000_OFS = exeData.find(SEARCH_SEG0)
SEG019_OFS = SEG000_OFS + 0x19D60
print(f"seg000 offset: {SEG000_OFS:04X}h (EXE binary) / {SEG000_OFS-SEG000_OFS:04X}h (internal)")
print(f"seg019 offset: {SEG019_OFS:04X}h (EXE binary) / {SEG019_OFS-SEG000_OFS:04X}h (internal)")
print(f"seg026 offset: {SEG026_OFS:04X}h (EXE binary) / {SEG026_OFS-SEG000_OFS:04X}h (internal)")

str_list = []
for ssreg in str_scan_regions:
    pos = ssreg[0]
    endpos = ssreg[1]
    start_idx = len(str_list)
    startpos = pos
    while pos < endpos:
        if exeData[pos] == 0x00:
            str_list.append({
                "start": startpos,
                "end": pos + 1,
                "data": exeData[startpos : pos + 1],
            })
            str_list[-1]["text"] = dump_as_str(str_list[-1]["data"])
            startpos = pos + 1
        pos += 1
    str_list[start_idx]["start_ofs"] = str_list[start_idx]["start"] - SEG026_OFS
    str_list[-1]["end_ofs"] = str_list[-1]["end"] - SEG026_OFS

str_refs = []
for st in str_list:
    st["ofs"] = st["start"] - SEG026_OFS
    st["name"] = f"str_{st['ofs']:04X}"
    pattern = bytes([0xB8, (st["ofs"] >> 0) & 0xFF, (st["ofs"] >> 8) & 0xFF])   # search for "MOV AX, offset"

    pos = exeData.find(pattern)
    if pos < 0:
        st["name"] = "u" + st["name"]
    while pos >= 0:
        str_refs.append({"pos": pos, "label": st["name"]})
        pos = exeData.find(pattern, pos + 1)

with open(sys.argv[2], "wt", encoding="utf-8") as f:
    f.write("; --- code patches ---\n")
    for sr in str_refs:
        if sr["pos"] < 0x10000 + SEG000_OFS:
            ofs = sr["pos"] - SEG000_OFS
            f.write(f"\tincbin \"VG.EXE\", $, {ofs:04X}h - ($-$$-SEG000_BASE_OFS)\n")
        else:
            ofs = sr["pos"] - SEG019_OFS
            f.write(f"\tincbin \"VG.EXE\", $, {ofs:04X}h - ($-$$-SEG019_BASE_OFS)\n")
        f.write(f"\tmov\tax, {sr['label']} - ($$+SEG026_BASE_OFS)\n")
    f.write("\n")

    f.write("; --- text patches ---\n")
    for st in str_list:
        if "start_ofs" in st:
            f.write(f"\tincbin \"VG.EXE\", $, {st['start_ofs']:04X}h - ($-$$-SEG026_BASE_OFS)\n")
        f.write(f"{st['name']}:")
        if not st["data"].isascii():
            sjis_text = decode_sjis(st["data"].rstrip(b'\x00'))
            f.write(f"\t; \"{sjis_text}\"")
        f.write("\n")
        f.write(f"\tdb\t{st['text']}\n")
        if "end_ofs" in st:
            f.write(f"\ttimes {st['end_ofs']:04X}h-($-$$-SEG026_BASE_OFS) db\t0\n\n")
    f.write("\n")
