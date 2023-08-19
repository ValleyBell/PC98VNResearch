#!/usr/bin/env python3
# Night Slave CMF Text Tool
# Written by Valley Bell, 2023-08-19
# based on Night Slave MDR Tool
import sys
import os
import struct
import typing
import argparse

"""
Text format used by this tool:

- line consists of 3 columns, separated by TABs.
  - command file offset [4-digit hex]
  - command ID [hex code, 2 to 4 digits]
  - text start file offset [4-digit hex]
  - text end file offset [4-digit hex]
  - text data
- comment lines begin with a # and are ignored
- command data token format:
  - 2-digit hex number (represents one byte)
  - "string" (string, surrounded with double quotes)
  - Strings can use Python-style escaping using the backslash.
"""

"""
The tool searches for:
  [text command 3A/4F] [data] [text pointer] [jump command 03] [jump destination pointer]

"text pointer" is assumed to be right after the search pattern.
"jump destination pointer" is assumed to be the end of the text.

When reinserting, the tool will try to reuse the original text buffer (between jump
command and jump destination) when possible. When the space is too small, the new
text will be moved to the end of the file.
"""

ESCAPE_TBL = {  # special characters to be escaped
    '\\': '\\\\',   # backslash (5C)
    '\t': '\\t',    # tab (09)
    '\n': '\\n',    # new line (0A)
    '\r': '\\r',    # carriage return (0D)
}
UNESCAPE_TBL = {
    '\\': '\\', # backslash (5C)
    "'": "'",   # single quote (27)
    '"': '"',   # double quote (22)
    'a': '\a',  # bell (07)
    'b': '\b',  # backspace (08)
    't': '\t',  # horizontal tab (09)
    'n': '\n',  # new line/linefeed (0A)
    'v': '\v',  # vertical tab (0B)
    'f': '\f',  # formfeed (0C)
    'r': '\r',  # carriage return (0D)
}


USE_MIRROR_PAGE = False
ALL_ASCII = False


# --- decoding ---
def dump_as_hex(data: bytes) -> str:
    return " ".join([f"{b:02X}" for b in data])

def quote_str(text: str, quote_chr: str) -> str:
    result = ""
    for c in text:
        if c == quote_chr:
            result += '\\' + c
        elif c in ESCAPE_TBL:
            result += ESCAPE_TBL[c]
        elif not c.isprintable():
            chr_id = ord(c)
            if chr_id < 0x80:
                result += f"\\x{chr_id:02X}"
            elif chr_id < 0x10000:
                result += f"\\u{chr_id:04X}"
            else:
                result += f"\\U{chr_id:06X}"
        else:
            result += c
    return quote_chr + result + quote_chr

def sjis_mirror_to_ascii(sjis: bytes) -> str:
    if sjis[0] == 0x85:
        if sjis[1] == 0x7B:
            return "\u00A5"
        if sjis[1] >= 0x40 and sjis[1] <= 0x7E:
            return chr(sjis[1] - 0x1F)
        if sjis[1] >= 0x80 and sjis[1] <= 0x9D:
            return chr(sjis[1] - 0x20)
    elif sjis[0] == 0x86:
        if sjis[1] == 0x40:
            return ' '  # return "normal" space
    return None

def dump_as_str(data: bytes) -> str:
    if not USE_MIRROR_PAGE:
        text = data.decode("shift-jis")
    else:
        text = ""
        pos = 0
        while pos < len(data):
            if data[pos] < 0x80:
                text += chr(data[pos])
                pos += 1
            else:
                ch = sjis_mirror_to_ascii(data[pos : pos+2])
                if ch is not None:
                    text += ch
                else:
                    text += data[pos : pos+2].decode("shift-jis")
                pos += 2
    return quote_str(text, '"') # surround with apostrophes

def decode_cmf_file(filepath_in: str, filepath_out: str) -> int:
    with open(filepath_in, "rb") as f:
        msgData = f.read()

    # split byte stream into a list of commands
    pos = 0x00
    cmdList = [] # list of [command offset, command ID, data bytes, label text]
    cmdPosMap = {}  # list of "command start offsets" for pointer references
    while pos + 0x0A < len(msgData):
        data = struct.unpack_from("<HHHHH", msgData, pos)
        if (data[2] == pos + 0x0A) and (data[3] == 0x0003) and (data[4] > data[2]):
            if (data[0] == 0x3A) or (data[0] == 0x4F):
                cmdPosMap[pos] = len(cmdList)
                dbytes = msgData[data[2] : data[4]]
                if dbytes[-2] == 0 and dbytes[-1] == 0:
                    dbytes = dbytes[:-2]
                cmdList.append([pos, data[0], data[1], data[2], data[4], dbytes])
        pos += 0x02

    # generate text file with escaped text strings
    with open(filepath_out, "wt", encoding="utf-8") as f:
        f.write("#pos\tcmd\tparam\tst_pos\tend_pos\tdata\n")
        for cdata in cmdList:
            (pos, cmd, param, startPos, endPos, dbytes) = cdata

            try:
                dstr = dump_as_str(dbytes)
            except UnicodeDecodeError:
                dstr = dump_as_hex(dbytes)
            f.write(f"{pos:04X}\t{cmd:02X}\t{param:02X}\t{startPos:04X}\t{endPos:04X}\t{dstr}\n")
    print("Decoding finished.")
    return 0


# --- encoding ---
def find_string_end(datastr: str, startpos: int, quote_chr: str) -> int:
    pos = startpos
    escaping = False
    while pos < len(datastr):
        if datastr[pos] == '\\':
            pos += 2    # skip backslash + escaped character
        elif datastr[pos] == quote_chr:
            return pos
        else:
            pos += 1
    return -1

def read_escaped_string(datastr: str) -> str:
    pos = 0
    result = ""
    while pos < len(datastr):
        if datastr[pos] == '\\':
            pos += 1
            if pos >= len(datastr):
                return None
            esc_chr = datastr[pos]
            pos += 1
            if esc_chr in UNESCAPE_TBL:
                result += UNESCAPE_TBL[esc_chr]
            elif esc_chr == 'x':    # 'x' + 2-digit hex number
                if pos + 2 > len(datastr):
                    return None
                result += chr(int(datastr[pos : pos+2], 0x10))
                pos += 2
            elif esc_chr == 'u':    # 'u' + 4-digit hex number
                if pos + 4 > len(datastr):
                    return None
                result += chr(int(datastr[pos : pos+4], 0x10))
                pos += 4
            elif esc_chr == 'U':    # 'U' + 8-digit hex number
                if pos + 8 > len(datastr):
                    return None
                result += chr(int(datastr[pos : pos+8], 0x10))
                pos += 8
            elif esc_chr.isdigit(): # character with octal code
                pos2 = pos
                while (pos2 < len(datastr)) and (pos2 < pos + 3):
                    if not datastr[pos2].isdigit():
                        break
                if pos2 == pos:
                    return None
                result += chr(int(datastr[pos : pos2], 0o10))
                pos = pos2
            else:
                return None
        else:
            result += datastr[pos]
            pos += 1
    return result

def parse_data_line(datastr: str) -> typing.Union[typing.List[str], tuple]:
    resdata = []
    pos = 0
    hexstart = -1
    while pos < len(datastr):
        dchr = datastr[pos]
        if dchr.isspace():
            pos += 1
            continue    # ignore whitespaces

        if dchr.isalnum():
            if (hexstart >= 0) and (pos - hexstart >= 2):       # enforce reading byte after at least 2 hex digits
                resdata.append(('b', int(datastr[hexstart : pos], 0x10)))
                hexstart = -1
            if hexstart == -1:
                hexstart = pos
            pos += 1
            continue
        else:
            if hexstart >= 0:   # no hex digit now - process last number
                resdata.append(('b', int(datastr[hexstart : pos], 0x10)))
                hexstart = -1

        if dchr == '"':
            pos2 = find_string_end(datastr, pos + 1, dchr)
            if pos2 < 0:
                return (-1, "string lacking closing " + dchr)

            dstr = read_escaped_string(datastr[pos+1 : pos2])
            if dstr is None:
                return (-2, "string parse error")

            resdata.append(('s', dstr))
            pos = pos2 + 1
        elif dchr.isspace():
            pos += 1
        else:
            return (-1, "bad identifider: " + dchr)
    if hexstart >= 0:   # no hex digit now - process last number
        resdata.append(('b', int(datastr[hexstart : pos], 0x10)))
    return resdata

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

def process_str_data(ditems: list, chrSize: int) -> None:
    cmdsize = 0
    for (idx, param) in enumerate(ditems):
        if param[0] == 'b':
            cmdsize += 1
        elif param[0] == 's':
            dstr = param[1]
            if (chrSize == 2) and USE_MIRROR_PAGE:
                dbytes = bytes()
                for ch in dstr:
                    sjis = ascii_to_sjis_mirror(ch)
                    if sjis is None:
                        sjis = ch.encode("shift-jis")
                    dbytes += sjis
            else:
                try:
                    dbytes = dstr.encode("shift-jis")
                except UnicodeDecodeError:
                    return (-3, "unable to encode to Shift-JIS: " + dstr)
            cmdsize += len(dbytes)
            ditems[idx] = (param[0], dbytes)

    # Strings must be terminated 1 or 2 bytes of '\x00'
    padding = chrSize
    # assume that the final data length must be a multiple of chrSize
    padding += (-cmdsize % chrSize)
    #print(f"cmdsize: {cmdsize}, chrSize: {chrSize}, padding: {padding}")
    ditems.append(('s', b'\x00' * padding))

def calc_data_size(data_items: list) -> int:
    cmdsize = 0
    for param in data_items:
        if param[0] == 'b': # raw byte
            cmdsize += 1
        elif (param[0] == 'l') or (param[0] == 'p'):    # label or pointer
            cmdsize += 2
        else:
            cmdsize += len(param[1])
    return cmdsize

def generate_data_bytes(data_items: list) -> int:
    data = b""
    for param in data_items:
        if param[0] == 'b': # raw byte
            data += bytes([param[1]])
        elif param[0] == 'p':   # pointer
            data += struct.pack("<H", param[1])
        else:
            data += param[1]
    return data

def encode_cmf_file(filepath_intxt: str, filepath_incmf: str, filepath_outcmf: str) -> int:
    cmdList = []
    # parse the text file, splitting separate lines into commands and parsing the data
    with open(filepath_intxt, "rt", encoding="utf-8") as f:
        lblstr = ""
        for (lid, line) in enumerate(f):
            line = line.rstrip()
            if (line == "") or (line.lstrip()[0] == '#'):
                continue

            # split line into columns (separated by TABs)
            splt = line.split('\t', 5)
            if len(splt) < 5:
                splt += [""] * (6 - len(splt))  # fill up to 6 columns
            (posstr, cmdstr, paramstr, psstr, pestr, datastr) = splt

            posstr = posstr.strip()
            cmdstr = cmdstr.strip()
            paramstr = paramstr.strip()
            psstr = psstr.strip()
            pestr = pestr.strip()
            datastr = datastr.strip()
            if posstr.endswith(':'):    # label
                lblstr = posstr[:-1]
            if len(cmdstr) == 0:
                continue    # no "command" column -> read next line (+ remember label for next line)

            pos = int(posstr, 0x10)
            cmd = int(cmdstr, 0x10)
            param = int(paramstr, 0x10)
            startPos = int(psstr, 0x10)
            endPos = int(pestr, 0x10)
            ditems = parse_data_line(datastr)
            if type(ditems) is tuple:
                print(f"Line {1+lid} parser error: {ditems[1]}")
                print(line)
                return -2
            if ALL_ASCII:
                process_str_data(ditems, 1)
            else:
                process_str_data(ditems, 2)

            cmdList.append([pos, cmd, param, startPos, endPos, ditems])

    # write file with generated binary data
    with open(filepath_incmf, "rb") as f:
        msgData = bytearray(f.read())
    # reinsert text into CMF files
    for cdata in cmdList:
        (pos, cmd, param, startPos, endPos, ditems) = cdata

        txtBufSize = endPos - startPos
        txtData = generate_data_bytes(ditems)
        txtSize = len(txtData)
        if txtSize <= txtBufSize:
            # new text has enough space in the original buffer - overwrite it
            txtPos = startPos
            txtData += b'\x00' * (txtBufSize - txtSize)
            msgData[startPos : startPos+txtBufSize] = txtData
        else:
            # not enough room at the original position - append to the end of the file
            txtPos = len(msgData)
            msgData += txtData

        # rewrite text command (with possibly relocated pointer)
        struct.pack_into("<HHH", msgData, pos, cmd, param, txtPos)
    with open(filepath_outcmf, "wb") as f:
        f.write(msgData)

    print("Encoding finished.")
    return 0

def main(argv):
    global USE_MIRROR_PAGE
    global ALL_ASCII

    print("Night Slave CMF Text Tool")
    aparse = argparse.ArgumentParser()
    ap_mode = aparse.add_subparsers(dest="mode", help="conversion mode", required=True)
    aparse.add_argument("-M", "--no-ascii-mirror", action="store_true", help="do NOT convert text strings from/to ASCII mirror page (Shift JIS 85xx)")
    aparse.add_argument("-a", "--all-ascii", action="store_true", help="assume 1-byte terminator in texts (default: 2 bytes)")

    pm_decode = ap_mode.add_parser("d", help="decode binary .CMF to text file")
    pm_decode.add_argument("in_file", help="input file .CMF")
    pm_decode.add_argument("out_file", help="output text file")
    pm_encode = ap_mode.add_parser("e", help="encode text file back to .CMF")
    pm_encode.add_argument("in_text", help="input text file")
    pm_encode.add_argument("in_cmf", help="input file .CMF")
    pm_encode.add_argument("out_cmf", help="output file .CMF")

    ap_args = aparse.parse_args(argv[1:])

    USE_MIRROR_PAGE = not ap_args.no_ascii_mirror
    ALL_ASCII = ap_args.all_ascii
    if ap_args.mode == "d":
        return decode_cmf_file(ap_args.in_file, ap_args.out_file)
    elif ap_args.mode == "e":
        return encode_cmf_file(ap_args.in_text, ap_args.in_cmf, ap_args.out_cmf)
    else:
        print("Invalid mode!")
        return 1

if __name__ == "__main__":
    sys.exit(main(sys.argv))
