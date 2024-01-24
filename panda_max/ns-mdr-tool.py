#!/usr/bin/env python3
# Night Slave MDR Tool
# Written by Valley Bell, 2023-08-12
# based on Hatchake Ayayo-san 2 MES Tool
import sys
import os
import struct
import typing
import argparse

"""
Text format used by this tool:

- line consists of 3 columns, separated by TABs.
  - command file offset in the original file (ignored when reading the file) [4-digit hex]
  - command ID [hex code, 2 to 4 digits]
  - command data
- comment lines begin with a # and are ignored
- command data token format:
  - 2-digit hex number (represents one byte)
  - "string" (string, surrounded with double quotes)
  - Strings can use Python-style escaping using the backslash.
"""

CMD_MODES = {
    0x00: 0,    # end of file (no parameters)
    0x01: -1,   # load graphics (.VDF ASCII file name)
    0x02: 2,    # graphics effect (2 bytes of parameters)
    0x03: -2,   # print + wait for input (Shift-JIS text)
    0x04: 0,    # wait for input (no parameters)
    0x05: -1,   # load music (.USO ASCII file name)
    0x06: 0,    # fade music out
    0x07: 2,    # timeout (2 bytes of parameters)
    0x08: -2,   # print + delay (Shift-JIS text)
}

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

def decode_mdr_file(filepath_in: str, filepath_out: str) -> int:
    with open(filepath_in, "rb") as f:
        msgData = f.read()

    # split byte stream into a list of commands
    pos = 0x00
    cmdList = [] # list of [command offset, command ID, data bytes, label text]
    cmdPosMap = {}  # list of "command start offsets" for pointer references
    while pos < len(msgData):
        cmdPos = pos
        cmd = struct.unpack_from("<H", msgData, pos)[0]
        pos += 0x02
        if cmd not in CMD_MODES:
            print(f"File offset 0x{cmdPos:04X}: unknown command {cmd:02X} found!")
            break
        cmdLen = CMD_MODES[cmd]
        if cmdLen >= 0:
            dbytes = msgData[pos : pos+cmdLen]
        elif (cmdLen == -1) or (cmdLen == -2 and ALL_ASCII):
            cmdLen = 0
            while pos + cmdLen < len(msgData):
                data = msgData[pos + cmdLen]
                if data == 0:
                    break
                cmdLen += 0x01
            dbytes = msgData[pos : pos+cmdLen]
            cmdLen += 0x01
        elif cmdLen == -2:
            cmdLen = 0
            while pos + cmdLen < len(msgData):
                data = struct.unpack_from("<H", msgData, pos + cmdLen)[0]
                if data == 0:
                    break
                cmdLen += 0x02
            dbytes = msgData[pos : pos+cmdLen]
            cmdLen += 0x02
        else:
            print(f"File offset 0x{cmdPos:04X}: unknown command mode {cmdLen}!")
            break
        pos += cmdLen

        cmdPosMap[cmdPos] = len(cmdList)
        cmdList.append([cmdPos, cmd, dbytes, ""])

    # generate text file with escaped text strings
    with open(filepath_out, "wt", encoding="utf-8") as f:
        f.write("#pos\tcmd\tdata\n")
        for cdata in cmdList:
            (cmdPos, cmd, dbytes, lblname) = cdata
            if cmd in CMD_MODES:
                cmode = CMD_MODES[cmd]
            else:
                cmode = 0

            if lblname != "":
                f.write(lblname + ":\n")
            elif cmode == -1 or cmode == -2:
                try:
                    dstr = dump_as_str(dbytes)
                except UnicodeDecodeError:
                    dstr = dump_as_hex(dbytes)
            else:
                dstr = dump_as_hex(dbytes)
            f.write(f"{cmdPos:04X}\t{cmd:02X}\t{dstr}\n")
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

def encode_mdr_file(filepath_in: str, filepath_out: str) -> int:
    cmdList = []
    cmdLblMap = {}
    # parse the text file, splitting separate lines into commands and parsing the data
    with open(filepath_in, "rt", encoding="utf-8") as f:
        lblstr = ""
        cmdPos = 0
        for (lid, line) in enumerate(f):
            line = line.rstrip()
            if (line == "") or (line.lstrip()[0] == '#'):
                continue

            # split line into columns (separated by TABs)
            splt = line.split('\t', 2)
            if len(splt) < 3:
                splt += [""] * (3 - len(splt))  # fill up to 3 columns
            (posstr, cmdstr, datastr) = splt

            posstr = posstr.strip()
            cmdstr = cmdstr.strip()
            datastr = datastr.strip()
            if posstr.endswith(':'):    # label
                lblstr = posstr[:-1]
            if len(cmdstr) == 0:
                continue    # no "command" column -> read next line (+ remember label for next line)

            cmd = int(cmdstr, 0x10)
            ditems = parse_data_line(datastr)
            if type(ditems) is tuple:
                print(f"Line {1+lid} parser error: {ditems[1]}")
                print(line)
                return -2
            if not cmd in CMD_MODES:
                print(f"Line {1+lid} error: unknown command {cmd:02X} found!")
                return -2
            cmdLen = CMD_MODES[cmd]
            if cmdLen >= 0:
                if len(ditems) != cmdLen:
                    print(f"Line {1+lid} error: command {cmd:02X} requires {cmdLen} data bytes, "
                        "but script has {len(ditems)}!")
                    return -2
            else:
                if (cmdLen == -1) or (cmdLen == -2):
                    if ALL_ASCII:
                        process_str_data(ditems, 1)
                    else:
                        process_str_data(ditems, -cmdLen)

            cmdList.append([cmdPos, cmd, ditems, lblstr])
            if lblstr != "":
                cmdLblMap[lblstr] = len(cmdList) - 1
                lblstr = ""
            cmdPos += 0x02 + calc_data_size(ditems)

    # write file with generated binary data
    with open(filepath_out, "wb") as f:
        for cdata in cmdList:
            (cmdPos, cmd, ditems, lblname) = cdata
            cmdbytes = struct.pack("<H", cmd) + generate_data_bytes(ditems)
            f.write(cmdbytes)

    print("Encoding finished.")
    return 0

def main(argv):
    global USE_MIRROR_PAGE
    global ALL_ASCII

    print("Night Slave MDR Tool")
    aparse = argparse.ArgumentParser()
    ap_mode = aparse.add_subparsers(dest="mode", help="conversion mode", required=True)
    aparse.add_argument("-M", "--no-ascii-mirror", action="store_true", help="do NOT convert text strings from/to ASCII mirror page (Shift JIS 85xx)")
    aparse.add_argument("-a", "--all-ascii", action="store_true", help="assume 1-byte terminator in texts (default: 2 bytes)")

    pm_decode = ap_mode.add_parser("d", help="decode binary .MDR to text file")
    pm_decode.add_argument("in_file", help="input file .MDR")
    pm_decode.add_argument("out_file", help="output text file")
    pm_encode = ap_mode.add_parser("e", help="encode text file back to .MDR")
    pm_encode.add_argument("in_file", help="input text file")
    pm_encode.add_argument("out_file", help="output file .MDR")

    ap_args = aparse.parse_args(argv[1:])

    USE_MIRROR_PAGE = not ap_args.no_ascii_mirror
    ALL_ASCII = ap_args.all_ascii
    if ap_args.mode == "d":
        return decode_mdr_file(ap_args.in_file, ap_args.out_file)
    elif ap_args.mode == "e":
        return encode_mdr_file(ap_args.in_file, ap_args.out_file)
    else:
        print("Invalid mode!")
        return 1

if __name__ == "__main__":
    sys.exit(main(sys.argv))
