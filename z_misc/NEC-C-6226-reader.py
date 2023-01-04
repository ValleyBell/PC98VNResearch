#!/usr/bin/env python3
import sys
import pickle

WRITE_PKL = True
WRITE_PY = False

with open("NEC-C-6226-visual3.txt", "rt") as f:
	lines = f.readlines()

jis_uc_lut = {}
uc_jis_lut = {}
for line in lines:
	line = line.strip()
	pos = line.find('#')
	if pos >= 0:
		line = line[:pos].rstrip()
	if len(line) == 0:
		continue
	
	# parse table
	items = line.split('\t')
	jis_code_str = items[0]
	ucode_str = items[1]
	if ucode_str[0] != 'U':
		print(f"Error in line: {line}")
		continue
	ucodes_strs = ucode_str.split('+')[1:]
	ucodes = [int(uc, 0x10) for uc in ucodes_strs]
	
	# create local tables
	jis_code = int(jis_code_str, 0)
	jis_uc_lut[jis_code] = ucodes
	if ucodes[0] not in uc_jis_lut:
		uc_jis_lut[ucodes[0]] = []
	uc_jis_lut[ucodes[0]] += [(ucodes[1:], jis_code)]


if WRITE_PKL:
	with open("NEC-C-6226-lut.pkl", "wb") as f:
		pickle.dump(jis_uc_lut, f)

if WRITE_PY:
	with open("NEC-C-6226-lut.py", "wt") as f:
		f.write("JIS2UC = {")
		lwrap = 0
		for jis_code in sorted(jis_uc_lut.keys()):
			ucodes = jis_uc_lut[jis_code]
			jis_code_str = f"0x{jis_code:04X}"
			uc_str = ", ".join([f"0x{uc:04X}" for uc in ucodes])
			
			if lwrap == 0:
				f.write("\n\t")
			else:
				f.write(" ")
			f.write(f"{jis_code_str}: [{uc_str}],")
			lwrap = (lwrap + 1) % 1 #4
		f.write("\n}\n")
		
		f.write("\n")
		f.write("UC2JIS = {")
		lwrap = 0
		for uc_code in sorted(uc_jis_lut.keys()):
			uc_code_str = f"0x{uc_code:04X}"
			map_strs = []
			for (ucodes, jis_code) in uc_jis_lut[uc_code]:
				jis_code_str = f"0x{jis_code:04X}"
				uc_str = ", ".join([f"0x{uc:04X}" for uc in ucodes])
				map_strs += [f"([{uc_str}], {jis_code_str})"]
			map_str = ", ".join(map_strs)
			
			if lwrap == 0:
				f.write("\n\t")
			else:
				f.write(" ")
			f.write(f"{uc_code_str}: [{map_str}],")
			lwrap = (lwrap + 1) % 1 #4
		f.write("\n}\n")
