#!/usr/bin/env python3
# Rekiai SCN Code Tool
# Valley Bell, 2023-09-20
# based on Hatchake Ayayo-san 2/3 MES Tool
import sys
import os
import struct
import typing
import argparse

"""
Text format for "code" output used by this tool:

- line consists of 2 columns, separated by TABs.
  - command file offset in the original file (ignored when reading the file) [4-digit hex]
  - command data
- The first column may also be a label, when it ends with a colon. (:)
  Labels are used as destination for commands that jump to arbitrary file offsets.
- comment lines begin with a # and are ignored
- command data token format:
  - 2-digit hex number (represents one byte)
  - <label> (label name surrounded with angled brackets)

Message texts are stored in a separate file and are referenced in the code using their ID from the message table.
Strings can use Python-style escaping using the backslash.
"""

CM_DEFAULT = 0x00
CM_TEXT = 0x01
CM_JUMP = 0x02
CM_COND_JUMP = 0x03
CM_CHOICES = 0x11

CMD_MODES = {
    0x00: CM_DEFAULT,   # end of file
    0x15: CM_DEFAULT,
    0x70: CM_CHOICES,
    0x71: CM_DEFAULT,
    0x72: CM_DEFAULT,
    0x73: CM_DEFAULT,
    0x80: CM_DEFAULT,
    0x81: CM_DEFAULT,
    0x82: CM_DEFAULT,
    0x83: CM_JUMP,      # jump
    0x84: CM_JUMP,      # gosub
    0x85: CM_DEFAULT,
    0x86: CM_COND_JUMP,
    0x87: CM_DEFAULT,
    0x8A: CM_JUMP,      # gosub
    0x8B: CM_DEFAULT,
    0x8C: CM_DEFAULT,
    0x90: CM_DEFAULT,
    0x91: CM_DEFAULT,
    0x92: CM_DEFAULT,
    0x93: CM_DEFAULT,
    0x94: CM_DEFAULT,
    0xA0: CM_DEFAULT,
    0xB0: CM_DEFAULT,
    0xD0: CM_DEFAULT,
    0xD2: CM_DEFAULT,
    0xE0: CM_DEFAULT,
    0xF2: CM_DEFAULT,
    0xF3: CM_DEFAULT,
    0xF9: CM_DEFAULT,
    0xFA: CM_DEFAULT,
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

DUMP_BIN = False
CODE_TEXT_DUMP = False


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
            cdata[3] = f"label_{pos:06X}"
    elif pos != 0xFFFFFFFF:
        print(f"Invalid pointer to file offset 0x{pos:06X} found in command {cmd:02X}!")

def get_label_str(cmdList: list, ptrMap: dict, pos: int) -> str:
    if pos in ptrMap:
        cdest = cmdList[ptrMap[pos]]
        return f"<{cdest[3]}>"
    return f"<0x{pos:06X}>"

def decode_scn_code(msgData: bytes, msgTbl: list, filepath_out: str) -> int:
    # split byte stream into a list of commands
    cmdpos = 0x00
    cmdList = [] # list of [command offset, command ID, data bytes, label text]
    cmdPosMap = {}  # list of "command start offsets" for pointer references
    while cmdpos < len(msgData):
        (cmdsize, cmd) = struct.unpack_from("<HB", msgData, cmdpos)
        dbytes = msgData[cmdpos+3 : cmdpos+cmdsize]

        if cmd not in CMD_MODES:
            print(f"File offset 0x{cmdpos:06X}: unknown command {cmd:02X} found!")
        else:
            cmode = CMD_MODES[cmd]

        cmdPosMap[cmdpos] = len(cmdList)
        cmdList.append([cmdpos, cmd, dbytes, ""])

        cmdpos += cmdsize

    # preparse all commands to generate labels
    for cdata in cmdList:
        (cmdpos, cmd, dbytes, _) = cdata
        cmode = CMD_MODES[cmd] if cmd in CMD_MODES else CM_DEFAULT
        if cmode == CM_JUMP: # jump
            pos = struct.unpack_from("<I", dbytes, 1)[0]
            generate_label(cmdList, cmd, cmdPosMap, pos)
        elif cmode == CM_COND_JUMP: # conditional jump
            baseofs = len(dbytes) - 4
            pos = struct.unpack_from("<I", dbytes, baseofs)[0]
            generate_label(cmdList, cmd, cmdPosMap, pos)
        elif cmode == CM_CHOICES: # menu choices (code jumps)
            # 10*3 bytes - parameters
            # 9*5 bytes - pointers
            baseofs = 30
            if dbytes[0] >= 0xF0:
                baseofs += 1
            for idx in range(9):
                pos = struct.unpack_from("<I", dbytes, baseofs + 1 + idx * 0x05)[0]
                generate_label(cmdList, cmd, cmdPosMap, pos)

    # generate text file with escaped text strings and pointers turned into labels
    with open(filepath_out, "wt", encoding="utf-8") as f:
        f.write("#pos\tdata\n")
        for cdata in cmdList:
            (cmdpos, cmd, dbytes, lblname) = cdata
            cmode = CMD_MODES[cmd] if cmd in CMD_MODES else CM_DEFAULT
            if lblname != "":
                f.write(lblname + ":\n")

            if cmode == CM_JUMP: # jump
                if len(dbytes) >= 5:
                    pos = struct.unpack_from("<I", dbytes, 1)[0]
                    dstr = dump_as_hex(dbytes[0:1]) + " " + get_label_str(cmdList, cmdPosMap, pos)
                else:
                    dstr = dump_as_hex(dbytes)
            elif cmode == CM_COND_JUMP: # conditional jump
                baseofs = len(dbytes) - 4
                generate_label(cmdList, cmd, cmdPosMap, pos)
                pos = struct.unpack_from("<I", dbytes, baseofs)[0]
                dstr = dump_as_hex(dbytes[0:baseofs]) + " " + get_label_str(cmdList, cmdPosMap, pos)
            elif cmode == CM_CHOICES: # menu choices (code jumps)
                # 10*3 bytes - parameters
                # 9*5 bytes - pointers (each pointer is [0x18] + [4-byte offset])
                baseofs = 10 * 3
                if dbytes[0] >= 0xF0:
                    baseofs += 1
                lbls = []
                for idx in range(9):
                    pos = struct.unpack_from("<I", dbytes, baseofs + 1 + idx * 0x05)[0]
                    lbls.append(dump_as_hex(dbytes[baseofs + idx * 0x05 : baseofs + 1 + idx * 0x05]))
                    lbls.append(get_label_str(cmdList, cmdPosMap, pos))
                dstr = dump_as_hex(dbytes[0:baseofs]) + " " + " ".join(lbls)
            elif cmode == CM_TEXT:
                try:
                    dstr = dump_as_str(dbytes)
                except UnicodeDecodeError:
                    dstr = dump_as_hex(dbytes)
            else:
                dstr = dump_as_hex(dbytes)

            if CODE_TEXT_DUMP and len(dbytes) >= 5:
                if dbytes[-5] == 0x11:
                    txtID = struct.unpack_from("<I", dbytes, -4)[0]
                    if txtID < len(msgTbl):
                        f.write(f"# {msgTbl[txtID][2]}\n")
            cmdstr = f"{cmd:02X}" if cmd >= 0 else ".."
            f.write(f"{cmdpos:06X}\t{cmdstr} {dstr}\n")

    return 0

def decode_text(data: bytes) -> bytes:
    data = bytearray(data)
    for pos in range(len(data)):
        r1 = (data[pos] >> 6) & 0x03
        r2 = (data[pos] << 2) & 0xFC
        data[pos] = r1 | r2
    return bytes(data)

def get_message_table(mtbl: bytes, mdata: bytes) -> list:
    offsets = [struct.unpack_from("<I", mtbl, pos)[0] for pos in range(0, len(mtbl), 4)]
    msgTbl = []
    for (txtID, pos) in enumerate(offsets):
        txt = b""
        endpos = pos
        while endpos < len(mdata) and mdata[endpos] != 0:
            endpos += 1
        data = mdata[pos:endpos+1]
        txt = dump_as_str(data)
        msgTbl.append((txtID, pos, txt))
    return msgTbl

def dump_text_table(msgTbl: list, filepath_out: str) -> int:
    with open(filepath_out, "wt", encoding="utf-8") as f:
        f.write(f"#ID\ttext\n")
        for entry in msgTbl:
            f.write(f"0x{entry[0]:04X}\t{entry[2]}\n")

def decode_scn_file(filepath_in: str, filepath_out: str) -> int:
    with open(filepath_in, "rb") as f:
        f.seek(0, os.SEEK_END)
        flen = f.tell()

        f.seek(0)

        data = f.read(0x20) # read header
        (sig, codesize, mtblsize, mdatsize, varcount, unused1, unused2, unused3) = struct.unpack("<IIIIIIII", data)
        if sig != 0x0000EBE9:
            print("Invalid input file format!")
            return 2

        print("Reading code data ...")
        codedata = f.read(codesize) # read code section
        if DUMP_BIN:
            with open(filepath_out + "_code.bin", "wb") as fOut:
                fOut.write(codedata)

        print("Reading message table ...")
        mtbl = f.read(mtblsize) # read message table
        if DUMP_BIN:
            with open(filepath_out + "_msgTbl.bin", "wb") as fOut:
                fOut.write(mtbl)

        print("Reading message data ...")
        msgdata = f.read(mdatsize) # read message data
        msgdata = decode_text(msgdata) # decrypt message data
        if DUMP_BIN:
            with open(filepath_out + "_msgData.bin", "wb") as fOut:
                fOut.write(msgdata)

        msgTbl = get_message_table(mtbl, msgdata)
        print("Dumping messages ...")
        dump_text_table(msgTbl, filepath_out + "_messages.txt")
        print("Dumping code ...")
        decode_scn_code(codedata, msgTbl, filepath_out + "_code.txt")
    print("Done.")

    return 0


def main(argv):
    global DUMP_BIN
    global CODE_TEXT_DUMP

    print("Rekiai SCN Decode Tool")
    aparse = argparse.ArgumentParser()
    aparse.add_argument("-b", "--dump-binary", action="store_true", help="dump binary data")
    aparse.add_argument("-t", "--code-text", action="store_true", help="include text strings in decoded code file")
    ap_mode = aparse.add_subparsers(dest="mode", help="conversion mode", required=True)

    pm_decode = ap_mode.add_parser("d", help="decode binary MAINCON.SCE to text files")
    pm_decode.add_argument("in_file", help="input file MAINCON.SCE")
    pm_decode.add_argument("out_file", help="output name prefix")

    ap_args = aparse.parse_args(argv[1:])

    DUMP_BIN = ap_args.dump_binary
    CODE_TEXT_DUMP = ap_args.code_text
    if ap_args.mode == "d":
        return decode_scn_file(ap_args.in_file, ap_args.out_file)
    elif ap_args.mode == "e":
        print("Not supported!")
        return 1
    else:
        print("Invalid mode!")
        return 1

if __name__ == "__main__":
    sys.exit(main(sys.argv))
