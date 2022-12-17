#!/usr/bin/env python3
# Hatchake Ayayo-san 2 MES Tool
# Written by Valley Bell, 2022-12-16/2022-12-17
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

CMD_MODES = {
    0x00: 0,    # end of file
    0x21: 0,    # menu: wait for selection
    0x23: 1,    #
    0x24: 0,    #
    0x25: 0,    #
    0x26: 0,    # menu: destination pointers
    0x2A: 1,    # place/background name
    0x2B: 0,    #
    0x2D: 1,    #
    0x2F: 1,    # text: narrator/menu
    0x30: 1,    # text: character Ayayo
    0x31: 1,    # text: character Tomoko
    0x32: 1,    # text: NPC character
    0x33: 1,    # text: NPC character
    0x3D: 0,    #
    0x3F: 1,    # menu: choice texts
    0x5E: 0,    #
    0x5F: 0,    #
    0x7C: 2,    # jump
    0x7E: 0,    # jump
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

def dump_as_str(data: bytes) -> str:
    text = data.decode("shift-jis")
    if text[-1] == '\x00':
        return quote_str(text[:-1], '"')    # remove \0 terminator and surround with quotation marks
    else:
        return quote_str(text, "'") # surround with apostrophes

def generate_label(cmdList: list, ptrMap: dict, pos: int):
    if pos in ptrMap:
        cdata = cmdList[ptrMap[pos]]
        if cdata[3] == "":
            cdata[3] = f"label_{pos:04X}"
    else:
        print("Invalid pointer to file offset 0x{pos:04X} found in command {cmd:02X}!")

def get_label_str(cmdList: list, ptrMap: dict, pos: int) -> str:
    if pos in ptrMap:
        cdest = cmdList[ptrMap[pos]]
        return f"<{cdest[3]}>"
    return f"<0x{pos:04X}>"

def decode_mes_file(filepath_in: str, filepath_out: str) -> int:
    with open(filepath_in, "rb") as f:
        msgData = f.read()
    # split byte stream into a list of commands
    cmdpos = 0x00
    cmdList = [] # list of [command offset, command ID, data bytes, label text]
    cmdPosMap = {}  # list of "command start offsets" for pointer references
    while cmdpos < len(msgData):
        (cmd, endpos) = struct.unpack_from("<BH", msgData, cmdpos)
        dbytes = msgData[cmdpos+3 : endpos]
        if cmd not in CMD_MODES:
            print(f"File offset 0x{cmdpos:04X}: unknown command {cmd:02X} found!")
        
        cmdPosMap[cmdpos] = len(cmdList)
        cmdList.append([cmdpos, cmd, dbytes, ""])
        
        cmdpos = endpos
    
    # preparse all commands to generate labels
    for cdata in cmdList:
        (cmdpos, cmd, dbytes, _) = cdata
        if cmd == 0x7C: # jump
            pos = struct.unpack_from("<H", dbytes, 0)[0];
            generate_label(cmdList, cmdPosMap, pos)
        elif cmd == 0x26:   # menu choices (code jumps)
            # 1 byte - number of menu entries
            # 2*n bytes - n pointers
            lbls = []
            curpos = 1
            for idx in range(dbytes[0]):
                pos = struct.unpack_from("<H", dbytes, 0x01 + idx * 0x02)[0];
                generate_label(cmdList, cmdPosMap, pos)
            dstr = dump_as_hex(dbytes[0:1]) + " " + " ".join(lbls)
    
    # generate text file with escaped text strings and pointers turned into labels
    with open(filepath_out, "wt", encoding="utf-8") as f:
        f.write("#pos\tcmd\tdata\n")
        for cdata in cmdList:
            (cmdpos, cmd, dbytes, lblname) = cdata
            if cmd in CMD_MODES:
                cmode = CMD_MODES[cmd] 
            else:
                cmode = 0
            
            if lblname != "":
                f.write(lblname + ":\n")
            if cmd == 0x7C: # jump
                pos = struct.unpack_from("<H", dbytes, 0)[0];
                dstr = get_label_str(cmdList, cmdPosMap, pos)
            elif cmd == 0x5F:
                # 3 bytes formatting + text
                dstr = dump_as_hex(dbytes[0:3])
                try:
                    dstr2 = dump_as_str(dbytes[3:])
                except UnicodeDecodeError:
                    dstr2 = dump_as_hex(dbytes[3:])
                dstr += " " + dstr2
            elif cmd == 0x3F:   # menu choices (text)
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
            elif cmd == 0x26:   # menu choices (code jumps)
                # 1 byte - number of menu entries
                # 2*n bytes - n pointers
                lbls = []
                curpos = 1
                for idx in range(dbytes[0]):
                    pos = struct.unpack_from("<H", dbytes, 0x01 + idx * 0x02)[0];
                    lbls.append(get_label_str(cmdList, cmdPosMap, pos))
                dstr = dump_as_hex(dbytes[0:1]) + " " + " ".join(lbls)
            elif cmode == 1:
                try:
                    dstr = dump_as_str(dbytes)
                except UnicodeDecodeError:
                    dstr = dump_as_hex(dbytes)
            else:
                dstr = dump_as_hex(dbytes)
            f.write(f"{cmdpos:04X}\t{cmd:02X}\t{dstr}\n")
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
                dbytes = dstr.encode("shift-jis")
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
            cmdpos += 0x03 + calc_data_size(ditems)
    
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
    with open(filepath_out, "wb") as f:
        for cdata in cmdList:
            (cmdpos, cmd, ditems, lblname) = cdata
            nextpos = cmdpos + 0x03 + calc_data_size(ditems)
            cmdbytes = bytes([cmd]) + struct.pack("<H", nextpos) + generate_data_bytes(ditems)
            f.write(cmdbytes)
    
    print("Encoding finished.")
    return 0

def main(argv):
    print("Hatchake Ayayo-san 2 MES Tool")
    aparse = argparse.ArgumentParser()
    ap_mode = aparse.add_subparsers(dest="mode", help="conversion mode", required=True)
    
    pm_decode = ap_mode.add_parser("d", help="decode binary MES.DAT to text file")
    pm_decode.add_argument("in_file", help="input file MES.DAT")
    pm_decode.add_argument("out_file", help="output text file")
    pm_encode = ap_mode.add_parser("e", help="encode text file back to MES.DAT")
    pm_encode.add_argument("in_file", help="input text file")
    pm_encode.add_argument("out_file", help="output file MES.DAT")
    
    ap_args = aparse.parse_args(argv[1:])
    
    if ap_args.mode == "d":
        return decode_mes_file(ap_args.in_file, ap_args.out_file)
    elif ap_args.mode == "e":
        return encode_mes_file(ap_args.in_file, ap_args.out_file)
    else:
        print("Invalid mode!")
        return 1

if __name__ == "__main__":
    sys.exit(main(sys.argv))
