#!/usr/bin/env python3
# Variable Geo 1 TXT Tool
# Written by Valley Bell, 2024-08-09
import sys
import os
import struct
import typing
import argparse

ASCII_FULLWIDTH = False
ASCII_MIRROR = False
NEWLINE_BYTE = ord('n')


# --- decoding ---
def sjis_special_decode(sjis: bytes) -> str:
    if sjis[0] == 0x85:
        # Shift-JIS ASCII mirror
        if sjis[1] == 0x7B:
            return "\u00A5"
        if sjis[1] >= 0x40 and sjis[1] <= 0x7E:
            return chr(sjis[1] - 0x1F)
        if sjis[1] >= 0x80 and sjis[1] <= 0x9D:
            return chr(sjis[1] - 0x20)
    elif sjis[0] == 0x86:
        if sjis[1] == 0x40:
            return ' '  # return "normal" space
        elif sjis[1] >= 0xA2 and sjis[1] <= 0xED:
            # NEC-specific line/border characters
            return chr(0x2500 + (sjis[1] - 0xA2))
    return None

def dump_as_str(data: bytes) -> str:
    global ASCII_FULLWIDTH
    global ASCII_MIRROR
    global NEWLINE_BYTE

    result = ""
    pos = 0
    while pos < len(data):
        ch = None
        if data[pos] == NEWLINE_BYTE:
            result += "\\n"
            pos += 1
        elif data[pos] < 0x80:
            ch = chr(data[pos])
            if ASCII_MIRROR:
                if (ch in "xuU0123456789") or (not ch.isprintable()):
                    result += f"\\x{data[pos]:02X}"
                else:
                    result += '\\' + ch
            else:
                if not ch.isprintable():
                    result += f"\\x{data[pos]:02X}"
                else:
                    result += ch
            pos += 1
        else:
            ch = sjis_special_decode(data[pos : pos+2])
            if ch is None:
                ch = data[pos : pos+2].decode("shift-jis")
            if ASCII_FULLWIDTH:
                if ch == '\u3000':
                    ch = ' '
                elif ch >= '\uFF01' and ch <= '\uFF5E':
                    ch = chr(ord(ch) - 0xFEE0)
            if not ch.isprintable():
                chr_id = ord(ch)
                if chr_id < 0x80:
                    result += f"\\x{chr_id:02X}"
                elif chr_id < 0x10000:
                    result += f"\\u{chr_id:04X}"
                else:
                    result += f"\\U{chr_id:06X}"
            else:
                result += ch
            pos += 2
    return result

def decode_txt_file(filepath_in: str, filepath_out: str) -> int:
    with open(filepath_in, "rb") as f:
        msgData = f.read()

    # split byte stream into messages
    msgCount = struct.unpack_from("<H", msgData, 0x00)[0] // 2
    msgList = []
    for msgID in range(msgCount):
        pos_st = struct.unpack_from("<H", msgData, msgID * 2)[0]
        pos_end = msgData.find(b'\x00', pos_st)
        if pos_end < 0:
            pos_end = len(msgData)
        msgList.append(msgData[pos_st : pos_end])

    # generate text file with escaped text strings
    with open(filepath_out, "wt", encoding="utf-8") as f:
        for mdata in msgList:
            dstr = dump_as_str(mdata)
            f.write(f"{dstr}\n")

    print("Decoding finished.")
    return 0


# --- encoding ---
def ascii_to_sjis_mirror(ch: str) -> bytes:
    if ch == "\u00A5":
        return bytes([0x85, 0x7B])
    if ch == ' ':
        return bytes([0x86, 0x40])
    if ch >= '!' and ch <= '}':
        sjis2 = ord(ch) + 0x1F
        if sjis2 >= 0x7F:
            sjis2 += 1
        return bytes([0x85, sjis2])
    return None

def ascii_to_sjis_fullwidth(ch: str) -> bytes:
    if ch == "\u00A5":
        return "\uFFE5".encode("shift-jis")
    if ch == ' ':
        return '\u3000'.encode("shift-jis")
    if ch >= '!' and ch <= '}':
        ch = chr(0xFEE0 + ord(ch))
        return ch.encode("shift-jis")
    return None

def sjis_special_encode(ch: str) -> bytes:
    if ch >= '\u2500' and ch <= '\u254B':
        return bytes([0x86, ord(ch) - 0x2500 + 0xA2])
    return None

def read_escaped_string(datastr: str) -> bytes:
    global ASCII_FULLWIDTH
    global ASCII_MIRROR
    global NEWLINE_BYTE

    pos = 0
    result = bytearray()
    while pos < len(datastr):
        use_jis = True
        chrdata = None
        if datastr[pos] == '\\':	# escaped character
            pos += 1
            if pos >= len(datastr):
                return None
            esc_chr = datastr[pos]
            pos += 1
            if esc_chr == 'x':    # 'x' + 2-digit hex number
                if pos + 2 > len(datastr):
                    return None
                chrdata = chr(int(datastr[pos : pos+2], 0x10))
                use_jis = False
                pos += 2
            elif esc_chr == 'u':    # 'u' + 4-digit hex number
                if pos + 4 > len(datastr):
                    return None
                chrdata = chr(int(datastr[pos : pos+4], 0x10))
                pos += 4
            elif esc_chr == 'U':    # 'U' + 8-digit hex number
                if pos + 8 > len(datastr):
                    return None
                chrdata = chr(int(datastr[pos : pos+8], 0x10))
                pos += 8
            elif esc_chr.isdigit(): # character with octal code
                pos2 = pos
                while (pos2 < len(datastr)) and (pos2 < pos + 3):
                    if not datastr[pos2].isdigit():
                        break
                if pos2 == pos:
                    return None
                chrdata = chr(int(datastr[pos : pos2], 0o10))
                pos = pos2
            elif esc_chr == 'n':	# newline
                chrdata = chr(NEWLINE_BYTE)
                use_jis = False
            else:
                # else just take as normal ASCII character (those are used for control codes)
                chrdata = esc_chr
                use_jis = False
        else:
            chrdata = datastr[pos]
            pos += 1
        if not use_jis:
            result += bytes([ord(chrdata)])
        else:
            try:
                if ASCII_FULLWIDTH:
                    sjis = ascii_to_sjis_fullwidth(chrdata)
                elif ASCII_MIRROR or ord(chrdata) == NEWLINE_BYTE:
                    sjis = ascii_to_sjis_mirror(chrdata)
                else:
                    sjis = None
                if sjis is None:
                    sjis = sjis_special_encode(chrdata)
                if sjis is None:
                    sjis = chrdata.encode("shift-jis")
            except UnicodeDecodeError:
                return (-3, "unable to encode to Shift-JIS: " + text)
            result += sjis
    result += b'\x00'
    return result

def encode_txt_file(filepath_in: str, filepath_out: str) -> int:
    msgList = []
    with open(filepath_in, "rt", encoding="utf-8") as f:
        for (lid, line) in enumerate(f):
            if lid == 0 and line.startswith('\uFEFF'):
                line = line[1:] # remove UTF-8 BOM
            line = line.rstrip()
            #if (line == "") or (line.lstrip()[0] == '#'):
            if line.lstrip()[0] == '#':
                continue

            dbytes = read_escaped_string(line)
            msgList.append(dbytes)

    msgToc = []
    msgPos = len(msgList) * 0x02
    for msg in msgList:
        msgToc.append(msgPos)
        msgPos += len(msg)

    # write file with generated binary data
    with open(filepath_out, "wb") as f:
        for pos in msgToc:
            f.write(struct.pack("<H", pos))
        for msg in msgList:
            f.write(msg)

    print("Encoding finished.")
    return 0

def main(argv):
    global ASCII_FULLWIDTH
    global ASCII_MIRROR
    global NEWLINE_BYTE

    print("Variable Geo 1 TXT Tool")
    aparse = argparse.ArgumentParser()
    ap_mode = aparse.add_subparsers(dest="mode", help="conversion mode", required=True)
    aparse.add_argument("-A", "--true-ascii", action="store_true", help="assumes actual ASCII text and \\n for newlines")
    aparse.add_argument("-M", "--no-ascii-mirror", action="store_true", help="do NOT convert text strings from/to ASCII mirror page (Shift JIS 85xx)")
    aparse.add_argument("-f", "--fullwidth-ascii", action="store_true", help="convert ASCII to full-width characters")

    pm_decode = ap_mode.add_parser("d", help="decode binary .TXT to text file")
    pm_decode.add_argument("in_file", help="input file .TXT")
    pm_decode.add_argument("out_file", help="output text file")
    pm_encode = ap_mode.add_parser("e", help="encode text file back to .TXT")
    pm_encode.add_argument("in_file", help="input text file")
    pm_encode.add_argument("out_file", help="output file .TXT")

    config = aparse.parse_args(argv[1:])

    ASCII_FULLWIDTH = config.fullwidth_ascii
    ASCII_MIRROR = not config.no_ascii_mirror
    if config.true_ascii:
        ASCII_MIRROR = False
        NEWLINE_BYTE = ord('\n')

    if config.mode == "d":
        return decode_txt_file(config.in_file, config.out_file)
    elif config.mode == "e":
        return encode_txt_file(config.in_file, config.out_file)
    else:
        print("Invalid mode!")
        return 1

if __name__ == "__main__":
    sys.exit(main(sys.argv))
