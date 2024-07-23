#!/usr/bin/env python3
# The tool takes a "base" TSV file and merges additional TSV files into it.
# Columns 1 and 6 are used to find matching lines.
# On matching lines, columns 7+ are transferred to the base TSV.
import sys
import os
import typing
import argparse

config = {}

def merge_tsvs(src_lines: list, merge_lines: list) -> list:
	result = []
	mrg_lid = 0
	for src_lid in range(len(src_lines)):
		src_cols = src_lines[src_lid]
		if len(src_cols) < 6:
			result.append(src_cols)
			continue
		while (mrg_lid < len(merge_lines)) and (len(merge_lines[mrg_lid]) < 6):
			mrg_lid += 1
		
		if mrg_lid < len(merge_lines):
			mrg_cols = merge_lines[mrg_lid]
			# when cols[0] and cols[5] match
			if mrg_cols[0] == src_cols[0] and mrg_cols[5] == src_cols[5]:
				# transfer columns 6+ to the source
				if len(mrg_cols) >= 6:
					src_cols = src_cols[:6] + mrg_cols[6:]
				mrg_lid += 1
		result.append(src_cols)
	return result

def read_tsv(lines: list) -> list:
	global config
	
	result = []
	for (lid, line) in enumerate(lines):
		ltrim = line.rstrip('\n')
		cols = ltrim.split('\t')
		result.append(cols)
	return result

def load_text_file(fn_in: str) -> typing.List[str]:
	with open(fn_in, "rt", encoding="utf-8") as f:
		return f.readlines()

def write_text_file(fn_out: str, lines: list) -> None:
	with open(fn_out, "wt", encoding="utf-8") as f:
		f.writelines(lines)
	return

def tsv_merge(base_fn: str, merge_fns: typing.List[str], fn_out: str) -> int:
	result = 0
	
	print(f"Reading {base_fn} ...", flush=True)
	try:
		base_data = read_tsv(load_text_file(base_fn))
	except IOError:
		print(f"Error reading {base_fn}")
		return 1
	for merge_fn in merge_fns:
		print(f"Reading {merge_fn} ...", flush=True)
		try:
			merge_data = read_tsv(load_text_file(merge_fn))
		except IOError:
			print(f"Error reading {merge_fn}")
			return 1
		base_data = merge_tsvs(base_data, merge_data)
	
	print("Writing merged TSV ...", flush=True)
	try:
		lines = ['\t'.join(cols) + '\n' for cols in base_data]
		write_text_file(fn_out, lines)
	except IOError:
		print(f"Error writing {fn_out}")
		return 1

	print("Done.")
	return result

def main(argv):
	global config
	
	print("TSV Merger")
	aparse = argparse.ArgumentParser()
	aparse.add_argument("base_file", help="base TSV that others are merged into")
	aparse.add_argument("merge_files", nargs="+", help="TSVs to be merged")
	aparse.add_argument("-o", "--out-file", required=True, help="output tab-separated text table (.TSV)")
	
	config = aparse.parse_args(argv[1:])
	
	return tsv_merge(config.base_file, config.merge_files, config.out_file)

if __name__ == "__main__":
	sys.exit(main(sys.argv))
# vim: set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab:
