#!/usr/bin/env python3
import sys
import os
import typing
import struct
import argparse

config = {}

def load_binary(fn_in: str) -> bytes:
	with open(fn_in, "rb") as f:
		return f.read()

def write_binary(fn_out: str, data: bytes) -> None:
	with open(fn_out, "wb") as f:
		f.write(data)
	return

def load_tsv(fn_in: str) -> typing.List[str]:
	with open(fn_in, "rt", encoding="utf-8") as f:
		return f.readlines()

def write_tsv(fn_out: str, lines: list) -> None:
	with open(fn_out, "wt", encoding="utf-8") as f:
		f.writelines(lines)
	return

def parse_tsv(lines: list) -> list:
	if len(lines) > 0:
		if lines[0].startswith("file\t"):
			lines[0] = "#" + lines[0]	# enforce header to be a comment
	
	result = []
	for (lid, line) in enumerate(lines):
		ltrim = line.lstrip()
		if len(ltrim) == 0 or ltrim.startswith('#') or ltrim.startswith(';'):
			result += [line]
			continue
		ltrim = line.rstrip('\n')
		cols = ltrim.split('\t', 5)
		if len(cols) < 6:
			print(f"Line {lid} invalid: {ltrim}")
			return None
		result += [cols]
	return result

def dump_item_file(fn_in: str, fn_out: str) -> int:
	try:
		data = load_binary(fn_in)
	except IOError:
		print(f"Error loading {fn_in}")
		return 1
	
	lines = []
	
	fntitle_in = os.path.basename(fn_in)
	linedata = ["#file", "offset", "label", "type", "textbox", "string"]
	lines += ["\t".join(linedata) + "\n"]
	for itemID in range(len(data) // 0x24):
		pos = itemID * 0x24
		(iid, flags) = struct.unpack_from("<HH", data, pos + 0x00)
		namepos = pos + 0x04
		namelen = 0x14
		iname_sjis = data[namepos : namepos + namelen]
		if True:	# The game requires a terminator.
			cpos = iname_sjis.find(b"\\\\")
			iname_sjis = iname_sjis[:cpos]
		iname = iname_sjis.decode("cp932")
		
		linedata = [fntitle_in, f"0x{namepos:04X}", f"item_{iid}", "sel", f"{namelen}x1", iname]
		lines += ["\t".join(linedata) + "\n"]
	try:
		write_tsv(fn_out, lines)
	except IOError:
		print(f"Error writing {fn_out}")
		return 1
	
	print("Done.")
	return 0

def dump_monster_file(fn_in: str, fn_out: str) -> int:
	try:
		data = load_binary(fn_in)
	except IOError:
		print(f"Error loading {fn_in}")
		return 1
	
	lines = []
	
	fntitle_in = os.path.basename(fn_in)
	linedata = ["#file", "offset", "label", "type", "textbox", "string"]
	lines += ["\t".join(linedata) + "\n"]
	for itemID in range(len(data) // 0x48):
		pos = itemID * 0x48
		iid = struct.unpack_from("<H", data, pos + 0x00)[0]
		namepos = pos + 0x08
		namelen = 0x16
		iname_sjis = data[namepos : namepos + namelen]
		if True:	# The game requires a terminator.
			cpos = iname_sjis.find(b"\\\\")
			iname_sjis = iname_sjis[:cpos]
		iname = iname_sjis.decode("cp932")
		
		linedata = [fntitle_in, f"0x{namepos:04X}", f"item_{iid}", "sel", f"{namelen}x1", iname]
		lines += ["\t".join(linedata) + "\n"]
	try:
		write_tsv(fn_out, lines)
	except IOError:
		print(f"Error writing {fn_out}")
		return 1
	
	print("Done.")
	return 0

def patch_file(fn_in: str, fn_out: str) -> int:
	try:
		tsv_lines = load_tsv(fn_in)
	except IOError:
		print(f"Error loading {fn_in}")
		return 1
	ret = parse_tsv(tsv_lines)
	if ret is None:
		return 2
	tsv_data = ret
	
	try:
		data = load_binary(fn_out)
	except IOError:
		print(f"Error loading {fn_out}")
		return 1
	data = bytearray(data)
	
	for (lid, line) in enumerate(tsv_data):
		if type(line) is str:
			continue
		
		pos = int(line[1], 0)
		bufSize = int(line[4].split('x')[0], 0)
		text = line[5]
		
		txt_sjis = text.encode("cp932")
		if len(txt_sjis) > (bufSize - 2):
			print(f"Line {1+lid}: Text is too long (length {len(txt_sjis)} > {bufSize - 2})")
			txt_sjis = txt_sjis[:bufSize-2]
		txt_sjis += b'\x5C' * (bufSize - len(txt_sjis))
		data[pos : pos+bufSize] = txt_sjis
	
	try:
		write_binary(fn_out, data)
	except IOError:
		print(f"Error writing {fn_out}")
		return 1
	
	print("Done.")
	return 0

def main(argv):
	global config
	
	print("MIME Item/Monster Name dumper/reinserter")
	aparse = argparse.ArgumentParser()
	apgrpm = aparse.add_mutually_exclusive_group(required=True)
	apgrpm.add_argument("-d", "--dump", action="store_true", help="mode: dump")
	apgrpm.add_argument("-i", "--insert", action="store_true", help="mode: reinsert")
	apgrpt = aparse.add_mutually_exclusive_group(required=True)
	apgrpt.add_argument("-I", "--item", action="store_true", help="type: item list (Z1010)")
	apgrpt.add_argument("-M", "--monster", action="store_true", help="type: monster list (Z1020)")
	
	aparse.add_argument("in_file", help="input file")
	aparse.add_argument("out_file", help="output file")
	
	config = aparse.parse_args(argv[1:])
	
	if config.dump:
		if config.item:
			return dump_item_file(config.in_file, config.out_file)
		elif config.monster:
			return dump_monster_file(config.in_file, config.out_file)
		else:
			return 9
	elif config.insert:
		return patch_file(config.in_file, config.out_file)
	else:
		return 9

if __name__ == "__main__":
	sys.exit(main(sys.argv))
# vim: set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab:
