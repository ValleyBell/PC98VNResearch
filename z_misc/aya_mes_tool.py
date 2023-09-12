#!/usr/bin/env python3
# Hatchake Ayayo-san 2/3 MES Tool
# Written by Valley Bell, 2022-12-16/2022-12-17
# Updated on 2023-09-06 with Ayayo 3 support.
import sys
import os
import struct
import typing
import argparse

"""
Text format used by this tool:

- line consists of 3 columns, separated by TABs.
  - command file offset in the original file (ignored when reading the file) [4-digit hex]
  - command ID [2-digit hex]
    NOTE: Can be ".." to indicate continuation of the previous command. (required by Ayayo 3 for pointers into command data)
  - command data
- The first column may also be a label, when it ends with a colon. (:)
  Labels are used as destination for commands that jump to arbitrary file offsets.
- comment lines begin with a # and are ignored
- command data token format:
  - 2-digit hex number (represents one byte)
  - <label> (label name surrounded with angled brackets)
  - 'string' (raw string without terminator, surrounded with single quotes)
  - "string" (null-terminated string, surrounded with double quotes)
  - Strings can use Python-style escaping using the backslash.
"""

CM_DEFAULT = 0x00
CM_TEXT = 0x01
CM_JUMP = 0x02
CM_META = 0x03
CM_CHAR_DEF2 = 0x04
CM_CHAR_DEF3 = 0x05
CM_SEL_TEXT = 0x10
CM_SEL_PTRS = 0x11
CM_DATA_ARR = 0x12

CMD_MODES_AYA2 = {
    0x00: CM_DEFAULT,   # end of file
    0x21: CM_DEFAULT,   # menu: wait for selection
    0x23: CM_TEXT,      #
    0x24: CM_DEFAULT,   #
    0x25: CM_DEFAULT,   #
    0x26: CM_SEL_PTRS,  # menu: destination pointers
    0x2A: CM_TEXT,      # load image group (text string is both, file name and place name)
    0x2B: CM_DEFAULT,   #
    0x2D: CM_TEXT,      #
    0x2F: CM_TEXT,      # text: narrator/menu
    0x30: CM_TEXT,      # text: character Ayayo
    0x31: CM_TEXT,      # text: character Tomoko
    0x32: CM_TEXT,      # text: NPC character
    0x33: CM_TEXT,      # text: NPC character
    0x3D: CM_DEFAULT,   #
    0x3F: CM_SEL_TEXT,  # menu: choice texts
    0x5E: CM_DEFAULT,   #
    0x5F: CM_CHAR_DEF2, # define character
    0x7C: CM_JUMP,      # jump
    0x7E: CM_META,      # meta-command
}

CMD_MODES_AYA3 = {
    0x00: CM_DEFAULT,   # end of file
    0x01: CM_TEXT,      # text: character 0 (Narrator)
    0x02: CM_TEXT,      # text: character 1 (Ayayo)
    0x03: CM_TEXT,      # text: character 2 (Tomoko)
    0x04: CM_TEXT,      # text: character 3
    0x05: CM_TEXT,      # text: character 4
    0x06: CM_TEXT,      # text: character 5
    0x07: CM_TEXT,      # text: character 6
    0x08: CM_TEXT,      # text: character 7
    0x09: CM_TEXT,      # text: character 8
    0x0A: CM_TEXT,      # load image group
    0x0B: CM_DEFAULT,   # ?? (graphics related)
    0x0C: CM_DEFAULT,   # ?? (graphics related)
    0x0D: CM_DEFAULT,   #
    0x0E: CM_DEFAULT,   #
    0x0F: CM_DEFAULT,   #
    0x11: CM_DEFAULT,   #
    0x12: CM_DEFAULT,   #
    0x13: CM_DATA_ARR,  # ?? (some arrays of data)
    0x14: CM_DEFAULT,   # set message speed
    0x15: CM_DEFAULT,   # wait for user input
    0x16: CM_CHAR_DEF3, # define character
    0x17: CM_DEFAULT,   #
    0x18: CM_TEXT,      # play music (text is .EMI file name)
    0x19: CM_SEL_TEXT,  # selection: set choice texts
    0x1A: CM_SEL_PTRS,  # selection: set destination pointers, wait for user selection
    0x1B: CM_DEFAULT,   # selection: jump to pointer of selected entry
    0x1C: CM_JUMP,      # jump to address = 2 bytes following command (equivalent to AYA2 command 7C, probably?)
    0x1D: CM_META,      #
    0x1E: CM_DEFAULT,   # text box related
    0x1F: CM_DEFAULT,   # text box related
    0x20: CM_DEFAULT,   #
    0x21: CM_DEFAULT,   # ?? (graphics related)
    0x22: CM_DEFAULT,   # clear graphic-related memory
    0x23: CM_DEFAULT,   # set "erase type"
    0x24: CM_DEFAULT,   # ?? (sets graphics-related position offsets)
    0x25: CM_DEFAULT,   # ?? (sets some graphics-related flag)
    0x26: CM_DEFAULT,   # ?? (clears some graphics-related flag)
    0x27: CM_TEXT,      # set LCD palette file name
    0x28: CM_DEFAULT,   # load LCD palette
    0x29: CM_DEFAULT,   # set palette (data is palette colour data)
    0x2A: CM_TEXT,      # show system text
    0x2B: CM_DEFAULT,   # set "animation mode"
    0x2D: CM_DEFAULT,   # ?? (sets some graphics-related flag)
    0x2C: CM_DEFAULT,   # ?? (graphics-related)
    0x2E: CM_DEFAULT,   # ?? (graphics-related)
    0x2F: CM_DEFAULT,   # set "smooth scroll mode"
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

AYA3_FONT_MAP = {
    #0xEB9F: 0x829F,
    # ... (filled in below)
    #0xEBF1: 0x82F1,
    0xEBF2: 0x8160,   # ~
    0xEBF3: 0x824F,   # 0
    0xEBF4: 0x8250,   # 1
    0xEBF5: 0x8251,   # 2
    0xEBF6: 0x8252,   # 3
    0xEBF7: 0x8253,   # 4
    0xEBF8: 0x8254,   # 5
    0xEBF9: 0x8255,   # 6
    0xEBFA: 0x8256,   # 7
    0xEBFB: 0x8257,   # 8
    0xEBFC: 0x8258,   # 9
    #0xEC40: 0x8340,
    # ... (filled in below)
    #0xEC96: 0x8396,
    0xEC97: 0x8148,   # ?
    0xEC98: 0x8149,   # !
    0xEC99: 0x81BF,   # also 0x879B
    0xEC9A: 0x81BE,   # also 0x879C
    0xEC9B: 0x84A2,   # ┐
    0xEC9C: 0x84A4,   # └
    0xEC9D: 0x81AA,   # arrow left up
}
for i in range(0xEB9F, 0xEBF1+1):
    AYA3_FONT_MAP[i] = i-0x6900 # 0xEB## -> 0x82##
for i in range(0xEC40, 0xEC96+1):
    AYA3_FONT_MAP[i] = i-0x6900 # 0xEC## -> 0x83##

AYA3_FONT_REVMAP = {AYA3_FONT_MAP[i]: i for i in AYA3_FONT_MAP}

USE_FONT_REMAP = False


# --- decoding ---
def dump_as_hex(data: bytes) -> str:
    return " ".join([f"{b:02X}" for b in data])

def sjis_str2int(sjis: bytes) -> int:
    return (sjis[0] << 8) | sjis[1]

def sjis_int2str(sjis: int) -> bytes:
    return bytes([sjis >> 8, sjis & 0xFF])

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

def dump_as_str(data: bytes) -> str:
    text = ""
    pos = 0
    while pos < len(data):
        if data[pos] < 0x80:
            text += chr(data[pos])
            pos += 1
        else:
            sjstr = data[pos : pos+2]
            sjis = sjis_str2int(sjstr)
            if USE_FONT_REMAP and (sjis in AYA3_FONT_MAP):
                sjis = AYA3_FONT_MAP[sjis]
                sjstr = sjis_int2str(sjis)
            text += sjstr.decode("shift-jis")
            pos += 2

    if len(text) > 0 and text[-1] == '\x00':
        return quote_str(text[:-1], '"')    # remove \0 terminator and surround with quotation marks
    else:
        return quote_str(text, "'") # surround with apostrophes

def generate_label(cmdList: list, cmd: int, ptrMap: dict, pos: int):
    if pos in ptrMap:
        cdata = cmdList[ptrMap[pos]]
        if cdata[3] == "":
            cdata[3] = f"label_{pos:04X}"
    else:
        print(f"Invalid pointer to file offset 0x{pos:04X} found in command {cmd:02X}!")

def get_label_str(cmdList: list, ptrMap: dict, pos: int) -> str:
    if pos in ptrMap:
        cdest = cmdList[ptrMap[pos]]
        return f"<{cdest[3]}>"
    return f"<0x{pos:04X}>"

def decode_mes_file(filepath_in: str, filepath_out: str) -> int:
    with open(filepath_in, "rb") as f:
        msgData = f.read()

    # format detection
    cmdpos = 0x00
    CMD_MODES = None
    while cmdpos < len(msgData) and CMD_MODES is None:
        (cmd, endpos) = struct.unpack_from("<BH", msgData, cmdpos)
        if CMD_MODES is None:
            # format detection
            if (cmd in CMD_MODES_AYA2) and (cmd not in CMD_MODES_AYA3):
                print("Detected Ayayo 2 format.")
                CMD_MODES = CMD_MODES_AYA2
            elif (cmd in CMD_MODES_AYA3) and (cmd not in CMD_MODES_AYA2):
                print("Detected Ayayo 3 format.")
                CMD_MODES = CMD_MODES_AYA3
        cmdpos = endpos

    # split byte stream into a list of commands
    cmdpos = 0x00
    cmdList = [] # list of [command offset, command ID, data bytes, label text]
    cmdPosMap = {}  # list of "command start offsets" for pointer references
    while cmdpos < len(msgData):
        (cmd, endpos) = struct.unpack_from("<BH", msgData, cmdpos)
        dbytes = msgData[cmdpos+3 : endpos]

        if cmd not in CMD_MODES:
            print(f"File offset 0x{cmdpos:04X}: unknown command {cmd:02X} found!")
        else:
            cmode = CMD_MODES[cmd]
            if cmode == CM_DATA_ARR:
                # 1 byte - number of entries
                # [loop n times] 2 bytes - pointer, 1 byte - data [loop end]
                pos_list = []
                for idx in range(dbytes[0]):
                    pos = struct.unpack_from("<H", dbytes, 0x01 + idx * 0x03)[0]
                    if pos < cmdpos:
                        continue    # yes, this actually happens in AYA3MES, at 0x91EB
                    pos_list += [pos]
                pos_list.sort() # important for AYA3MES, command at 0x38F3

                # split the command into multiple "command" items, but with command ID == -1 to indicate continuation
                pos = cmdpos
                datapos = cmdpos+3
                for pos in pos_list:
                    cmdPosMap[cmdpos] = len(cmdList)
                    cmdList.append([cmdpos, cmd, msgData[datapos : pos], ""])
                    cmdpos = pos
                    datapos = pos
                    cmd = -1
                dbytes = msgData[datapos : endpos]

        cmdPosMap[cmdpos] = len(cmdList)
        cmdList.append([cmdpos, cmd, dbytes, ""])

        cmdpos = endpos

    # preparse all commands to generate labels
    for cdata in cmdList:
        (cmdpos, cmd, dbytes, _) = cdata
        cmode = CMD_MODES[cmd] if cmd in CMD_MODES else CM_DEFAULT
        if cmode == CM_JUMP: # jump
            pos = struct.unpack_from("<H", dbytes, 0)[0]
            generate_label(cmdList, cmd, cmdPosMap, pos)
        elif cmode == CM_META: # meta-command
            subcmd = -1 if len(dbytes) < 1 else dbytes[0]
            if (cmd == 0x7E and subcmd == 0x03) or (cmd == 0x1D and subcmd == 0x00): # conditional jump
                pos = struct.unpack_from("<H", dbytes, 1)[0]
                generate_label(cmdList, cmd, cmdPosMap, pos)
        elif cmode == CM_SEL_PTRS: # menu choices (code jumps)
            # 1 byte - number of menu entries
            # 2*n bytes - n pointers
            for idx in range(dbytes[0]):
                pos = struct.unpack_from("<H", dbytes, 0x01 + idx * 0x02)[0]
                generate_label(cmdList, cmd, cmdPosMap, pos)
        elif cmode == CM_DATA_ARR:
            # 1 byte - number of entries
            # [loop n times] 2 bytes - pointer, 1 byte - data [loop end]
            for idx in range(dbytes[0]):
                pos = struct.unpack_from("<H", dbytes, 0x01 + idx * 0x03)[0]
                generate_label(cmdList, cmd, cmdPosMap, pos)

    # generate text file with escaped text strings and pointers turned into labels
    with open(filepath_out, "wt", encoding="utf-8") as f:
        f.write("#pos\tcmd\tdata\n")
        for cdata in cmdList:
            (cmdpos, cmd, dbytes, lblname) = cdata
            cmode = CMD_MODES[cmd] if cmd in CMD_MODES else CM_DEFAULT
            if lblname != "":
                f.write(lblname + ":\n")

            if cmode == CM_JUMP: # jump
                pos = struct.unpack_from("<H", dbytes, 0)[0]
                dstr = get_label_str(cmdList, cmdPosMap, pos)
            elif cmode == CM_META: # meta-command
                subcmd = -1 if len(dbytes) < 1 else dbytes[0]
                if (cmd == 0x7E and subcmd == 0x03) or (cmd == 0x1D and subcmd == 0x00): # conditional jump
                    pos = struct.unpack_from("<H", dbytes, 1)[0]
                    dstr = dump_as_hex(dbytes[0:1]) + " " + get_label_str(cmdList, cmdPosMap, pos)
                else:
                    dstr = dump_as_hex(dbytes)
            elif cmode == CM_CHAR_DEF2:
                # 3 bytes formatting + text
                dstr = dump_as_hex(dbytes[0:3])
                try:
                    dstr2 = dump_as_str(dbytes[3:])
                except UnicodeDecodeError:
                    dstr2 = dump_as_hex(dbytes[3:])
                dstr += " " + dstr2
            elif cmode == CM_CHAR_DEF3:
                # 2 bytes formatting + text
                dstr = dump_as_hex(dbytes[0:2])
                try:
                    dstr2 = dump_as_str(dbytes[2:])
                except UnicodeDecodeError:
                    dstr2 = dump_as_hex(dbytes[2:])
                dstr += " " + dstr2
            elif cmode == CM_SEL_TEXT: # menu choices (text)
                # 1 byte - number of menu entries
                # ? bytes - n texts, each null-terminated
                curpos = 1
                entries = []
                for idx in range(dbytes[0]):
                    pos = dbytes.find(b'\x00', curpos)
                    if pos < 0:
                        print("Warning: More menu entries defined then found!")
                        break
                    pos += 1
                    try:
                        dstr2 = dump_as_str(dbytes[curpos:pos])
                    except UnicodeDecodeError:
                        dstr2 = dump_as_hex(dbytes[curpos:pos])
                    entries.append(dstr2)
                    curpos = pos
                dstr = dump_as_hex(dbytes[0:1]) + " " + " ".join(entries)
            elif cmode == CM_SEL_PTRS: # menu choices (code jumps)
                # 1 byte - number of menu entries
                # 2*n bytes - n pointers
                lbls = []
                for idx in range(dbytes[0]):
                    pos = struct.unpack_from("<H", dbytes, 0x01 + idx * 0x02)[0]
                    lbls.append(get_label_str(cmdList, cmdPosMap, pos))
                dstr = dump_as_hex(dbytes[0:1]) + " " + " ".join(lbls)
            elif cmode == CM_DATA_ARR:
                # 1 byte - number of entries
                # [loop n times] 2 bytes - pointer, 1 byte - data [loop end]
                entries = []
                for idx in range(dbytes[0]):
                    (pos, val) = struct.unpack_from("<HB", dbytes, 0x01 + idx * 0x03)
                    entries.append(get_label_str(cmdList, cmdPosMap, pos) + " " + dump_as_hex([val]))
                pos = 0x01 + dbytes[0] * 0x03
                dstr = dump_as_hex(dbytes[0:1]) + " " + " ".join(entries)
                dstr += " " + dump_as_hex(dbytes[pos:])
            elif cmode == CM_TEXT:
                try:
                    dstr = dump_as_str(dbytes)
                except UnicodeDecodeError:
                    dstr = dump_as_hex(dbytes)
            else:
                dstr = dump_as_hex(dbytes)

            cmdstr = f"{cmd:02X}" if cmd >= 0 else ".."
            f.write(f"{cmdpos:04X}\t{cmdstr}\t{dstr}\n")
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

def encode_str(dstr: str) -> bytes:
    dbytes = bytearray()
    for ch in dstr:
        sjstr = ch.encode("shift-jis")
        if len(sjstr) == 2:
            sjis = sjis_str2int(sjstr)
            if USE_FONT_REMAP and (sjis in AYA3_FONT_REVMAP):
                sjis = AYA3_FONT_REVMAP[sjis]
                sjstr = sjis_int2str(sjis)
        dbytes += sjstr
    return dbytes

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

        if dchr == '<':
            pos2 = datastr.find('>', pos + 1)
            if pos2 < 0:
                return (-1, "label reference lacking closing >")
            resdata.append(('l', datastr[pos+1 : pos2]))
            pos = pos2 + 1
        elif (dchr == '"') or (dchr == "'"):
            pos2 = find_string_end(datastr, pos + 1, dchr)
            if pos2 < 0:
                return (-1, "string lacking closing " + dchr)

            dstr = read_escaped_string(datastr[pos+1 : pos2])
            if dstr is None:
                return (-2, "string parse error")
            try:
                dbytes = encode_str(dstr)
            except UnicodeDecodeError:
                return (-3, "unable to encode to Shift-JIS: " + dstr)

            if dchr == '"': # null-terminated string
                dbytes += b'\x00'   # add null-terminator
            resdata.append(('s', dbytes))
            pos = pos2 + 1
        elif dchr.isspace():
            pos += 1
        else:
            return (-1, "bad identifider: " + dchr)
    if hexstart >= 0:   # no hex digit now - process last number
        resdata.append(('b', int(datastr[hexstart : pos], 0x10)))
    return resdata

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

def encode_mes_file(filepath_in: str, filepath_out: str) -> int:
    cmdList = []
    cmdLblMap = {}
    # parse the text file, splitting separate lines into commands and parsing the data
    with open(filepath_in, "rt", encoding="utf-8") as f:
        lblstr = ""
        cmdpos = 0
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

            if cmdstr == "..":
                cmd = -1
            else:
                cmd = int(cmdstr, 0x10)
            ditems = parse_data_line(datastr)
            if type(ditems) is tuple:
                print(f"Line {1+lid} parser error: {ditems[1]}")
                print(line)
                return -2

            cmdList.append([cmdpos, cmd, ditems, lblstr])
            if lblstr != "":
                cmdLblMap[lblstr] = len(cmdList) - 1
                lblstr = ""
            if cmd >= 0:
                cmdpos += 0x03 + calc_data_size(ditems)
            else:
                cmdpos += calc_data_size(ditems)

    # convert labels into pointers
    for cdata in cmdList:
        (cmdpos, cmd, ditems, lblname) = cdata
        did_resolve = False
        for (i, itm) in enumerate(ditems):
            if itm[0] == 'l':
                lblpos = None
                if itm[1] in cmdLblMap:
                    cmd_id = cmdLblMap[itm[1]]
                    lblpos = cmdList[cmd_id][0]
                elif itm[1].startswith("0x"):
                    print(f"Warning: Pointer referencing absolute offset {itm[1]}!")
                    lblpos = int(itm[1][2:], 0x10)
                else:
                    print(f"Label {itm[1]} is referenced but not defined!")
                ditems[i] = ('p', lblpos)
        if did_resolve:
            cdata[2] = ditems

    # write file with generated binary data
    data = bytearray()
    lastcmdpos = None
    for cdata in cmdList:
        (cmdpos, cmd, ditems, lblname) = cdata
        if cmd >= 0:
            lastcmdpos = cmdpos
            nextpos = cmdpos + 0x03 + calc_data_size(ditems)
            data += struct.pack("<BH", cmd, nextpos) + generate_data_bytes(ditems)
        else:
            nextpos += calc_data_size(ditems)
            struct.pack_into("<H", data, lastcmdpos + 0x01, nextpos)
            data += generate_data_bytes(ditems)
    with open(filepath_out, "wb") as f:
        f.write(data)

    print("Encoding finished.")
    return 0

def main(argv):
    global USE_FONT_REMAP

    print("Hatchake Ayayo-san 2/3 MES Tool")
    aparse = argparse.ArgumentParser()
    aparse.add_argument("-f", "--font-map", action="store_true", help="use Ayayo 3 custom font mapping")
    ap_mode = aparse.add_subparsers(dest="mode", help="conversion mode", required=True)

    pm_decode = ap_mode.add_parser("d", help="decode binary MES.DAT to text file")
    pm_decode.add_argument("in_file", help="input file MES.DAT")
    pm_decode.add_argument("out_file", help="output text file")
    pm_encode = ap_mode.add_parser("e", help="encode text file back to MES.DAT")
    pm_encode.add_argument("in_file", help="input text file")
    pm_encode.add_argument("out_file", help="output file MES.DAT")

    ap_args = aparse.parse_args(argv[1:])

    USE_FONT_REMAP = ap_args.font_map
    if ap_args.mode == "d":
        return decode_mes_file(ap_args.in_file, ap_args.out_file)
    elif ap_args.mode == "e":
        return encode_mes_file(ap_args.in_file, ap_args.out_file)
    else:
        print("Invalid mode!")
        return 1

if __name__ == "__main__":
    sys.exit(main(sys.argv))
