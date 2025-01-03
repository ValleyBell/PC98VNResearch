#!/usr/bin/env python3
import sys
import os
import typing
import argparse
import unicodedata
import requests
import html
import time
import yaml

DEBUG_OUTPUT_PATH = None
#DEBUG_OUTPUT_PATH = "/tmp/tsvtrans_"

LANGUAGE_SRC = "ja"	# Japanese
LANGUAGE_TGT = "en"	# English
TRANSLATE_MAX_CHARS = 500	# maximum characters that are translated per request

config = {}
var_dict = {"words": []}

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

def get_cjk_char_width(c: str) -> int:
	return 2 if unicodedata.east_asian_width(c) in ["W", "F"] else 1 

def get_cjk_string_width(text: str) -> int:
	return sum([get_cjk_char_width(c) for c in text])

def tsv2textitems(tsv_data: list) -> list:
	textitem_list = []
	
	for (lid, cols) in enumerate(tsv_data):
		if type(cols) is str:
			continue
		#print(cols)
		(filename, lineref, lblname, mode, tbox, text) = cols
		textitem_list += [{"line_id": lid, "mode": mode, "text": text}]
	
	return textitem_list

def textitems2tsv(textitem_list: list, tsv_data: list) -> list:
	# reinsert text items into the TSV column list again
	tsv_new = tsv_data.copy()
	for txitm in textitem_list:
		tsv_lid = txitm["line_id"]
		tsv_new[tsv_lid][5] = txitm["text"]
	return tsv_new

def do_title_case(text: str) -> str:
	txtitle = list(text.title())
	# keep all-caps words like "TV"
	for (pos, c) in enumerate(txtitle):
		if (not c.isupper()) and (text[pos].isupper()):
			txtitle[pos] = text[pos]
	return "".join(list(txtitle))

def process_data(tsv_data: list) -> list:
	global config
	
	if DEBUG_OUTPUT_PATH:
		with open(DEBUG_OUTPUT_PATH + "00_tsvdata.log", "wt") as f:
			for cols in tsv_data:
				f.write(str(cols).rstrip() + "\n")
	
	# At first, turn TSV into a simpler list. (strip comments and unneccessary columns)
	textitem_list = tsv2textitems(tsv_data)
	if DEBUG_OUTPUT_PATH:
		with open(DEBUG_OUTPUT_PATH + "01_textitems_org.log", "wt") as f:
			for txitm in textitem_list:
				f.write(str(txitm) + "\n")
	
	# Extract "unique" lines and set references in the original list.
	trans_data = []
	unique_texts = []
	unique_tkeys = []
	for (tid, txitm) in enumerate(textitem_list):
		trdat = text2transdata(txitm["text"])
		# Store text strings in a separate "unique texts" table.
		# This allows us to remove duplicate instances of text lines.
		try:
			if len(trdat["data"]) == 0:
				ut_idx = -1	# special value for empty strings
			else:
				ut_idx = unique_texts.index(trdat["data"])
		except ValueError:
			ut_idx = len(unique_texts)
			unique_texts.append(trdat["data"])
			unique_tkeys.append(trdat["keys"].keys())
		trdat.pop("data")
		trdat["tidx"] = ut_idx	# save only a text reference ID
		trans_data.append({"text_item": tid, **trdat})
	if DEBUG_OUTPUT_PATH:
		with open(DEBUG_OUTPUT_PATH + "03_translate_texts.log", "wt") as f:
			for trdat in trans_data:
				text = unique_texts[trdat["tidx"]] if (trdat["tidx"] >= 0) else ""
				f.write(str({**trdat, "text": text}) + "\n")
	
	# Translate the unique text strings.
	translated_texts = translate_items_grouped(unique_texts, unique_tkeys)
	if DEBUG_OUTPUT_PATH:
		with open(DEBUG_OUTPUT_PATH + "05_translated_texts.log", "wt") as f:
			for trdat in trans_data:
				text = translated_texts[trdat["tidx"]] if (trdat["tidx"] >= 0) else ""
				f.write(str({**trdat, "text": text}) + "\n")
	
	# Reconstruct "textitem_list" using translated strings.
	textitem_newlist = textitem_list.copy()
	for txitm in textitem_newlist:
		txitm["text"] = []
	for trdat in trans_data:
		txitm = textitem_newlist[trdat["text_item"]]
		text = translated_texts[trdat["tidx"]] if (trdat["tidx"] >= 0) else ""
		# for "selection" type, optionally apply Title Case
		if config.title_case and txitm["mode"] == "sel":
			text = do_title_case(text)
		txitm["text"].append(transdata2txt({**trdat, "data": text}))
	for txitm in textitem_newlist:
		txitm["text"] = '\n'.join(txitm["text"])
	if DEBUG_OUTPUT_PATH:
		with open(DEBUG_OUTPUT_PATH + "06_textitems_translated.log", "wt") as f:
			for txitm in textitem_newlist:
				f.write(str(txitm) + "\n")
	
	# Finally, reconstruct the TSV file.
	tsv_newdata = textitems2tsv(textitem_newlist, tsv_data)
	if DEBUG_OUTPUT_PATH:
		with open(DEBUG_OUTPUT_PATH + "07_tsvdata.log", "wt") as f:
			for cols in tsv_newdata:
				f.write(str(cols).rstrip() + "\n")
	return tsv_newdata

def text2transdata(text: str) -> dict:
	global var_dict
	
	MODE_CTRL = 1
	MODE_TEXT = 0
	txt_begin = ""
	txt_end = ""
	tnew = ""
	keys = {}
	
	mode = MODE_CTRL
	tkey = ""
	key_id = -1	# beginning of the line
	pos = 0
	# Process:
	#	- take note of "control characters" at the beginning/end of the line (-> txt_begin/txt_end)
	#	- replace control characters in the middle with "{1}" / "{2}" / ...)
	while pos < len(text):
		text_var = None
		for tv in var_dict["words"]:
			tvkey = tv["key"]
			tkvlen = len(tvkey)
			if text[pos : pos+tkvlen] == tvkey:
				text_var = tv
				break
		
		chrtype = None
		chrlen = 1
		if text_var is not None:
			chrlen = len(text_var["key"])
			if ("punctuation" in text_var) and (text_var["punctuation"]):
				chrtype = 2
			else:
				chrtype = 0
		elif (text[pos] == '\\') and (pos + 1 < len(text)):
			ctrl_chr = text[pos + 1]
			chrtype = 2
			chrlen += 1
			if ctrl_chr == 'x':
				chrlen += 2
			elif (ctrl_chr == 'j') or (ctrl_chr == 'u'):
				chrlen += 4
			elif ctrl_chr == 'U':
				chrlen += 8
		elif (ord(text[pos]) < 0x20) or (text[pos] in "#$%&/[\\]^_{|}"):
			chrtype = 2
		elif text[pos].isspace():
			chrtype = 1
		else:
			chrtype = 0
		
		if mode == MODE_CTRL and chrtype == 0:
			# control -> text
			mode = MODE_TEXT
			if key_id < 0:
				txt_begin = tkey
				key_id += 1
			else:
				keyname = "[" + f"{key_id}" + "]"
				while keyname in text:
					key_id += 1
					keyname = "[" + f"{key_id}" + "]"
				keys[keyname] = tkey
				tnew += keyname
				key_id += 1
				if text_var is not None:
					tnew += " "	# insert an additional space for better sentence splits
			tkey = None
		elif mode == MODE_TEXT and chrtype == 2:
			# text -> control
			mode = MODE_CTRL
			
			# move trailing spaces to "tkey"
			spcpos = len(tnew) - 1
			while spcpos >= 0 and tnew[spcpos].isspace():
				spcpos -= 1
			spcpos += 1
			tkey = tnew[spcpos:]
			tnew = tnew[:spcpos]
		if mode == MODE_CTRL:
			tkey += text[pos : pos+chrlen]
		elif mode == MODE_TEXT:
			if text_var is not None:
				# Google Translate seems to be a bit picky about the control characters.
				#  "ばかだな・・・猫舌のくせに{0}あらあら" -> The translation misses the "あらあら" part.
				#  "ばかだな・・・猫舌のくせに[0]あらあら" -> "あらあら" translates to "Oh no."
				# Thus I will use "{0}" for words and "[0]" for sentence splits.
				keyname = "{" + f"{key_id}" + "}"
				while keyname in text:
					key_id += 1
					keyname = "{" + f"{key_id}" + "}"
				keys[keyname] = text[pos : pos+chrlen]
				tnew += keyname
				key_id += 1
			else:
				tnew += text[pos : pos+chrlen]
		pos += chrlen
	if mode == MODE_CTRL:
		# control -> text
		mode = MODE_TEXT
		if key_id < 0:
			txt_begin = tkey
		else:
			txt_end = tkey
	
	return {
		"start": txt_begin,
		"end": txt_end,
		"data": tnew,
		"keys": keys,
	}

def transdata2txt(tdata: dict) -> str:
	tnew = tdata["data"]
	for (key, val) in tdata["keys"].items():
		#if key.startswith('['):
		#	# Recently, Google Translate inserts additional spaces before/after the replacement codes.
		#	# This is bad for sentence-splits. We make sure to remove them here.
		#	klen = len(key)
		#	pos = tnew.find(key)
		#	while pos >= 0:
		#		tnew = tnew[:pos].rstrip() + val + tnew[pos+klen:].lstrip()
		#		pos += klen
		#		pos = tnew.find(key, pos)
		#	# results were unfortunately less ideal than I expected them to be
		tnew = tnew.replace(key, val)
	return tdata["start"] + tnew + tdata["end"]

def check_keys_in_text(text: str, keys: set) -> bool:
	for k in keys:
		if text.find(k) < 0:
			return False
	return True

def translate_items_single(texts: list, tkeys: list, line_base: int) -> list:
	# translate each line separately
	trans_texts = []
	for (tid, txt) in enumerate(texts):
		print(f"Translating line {1+line_base+tid} / {line_base+len(texts)} ({len(txt)} characters) ...", end="", flush=True)
		t_start = time.time()
		trans_text = translate_text(txt)
		t_end = time.time()
		print(f"   {t_end - t_start:.2f} s", flush=True)
		
		if trans_text is None:
			print("Failed to call web service")
			return None
		if not check_keys_in_text(txt, tkeys[tid]):
			print("Placeholders got missing - ignoring translation.")
			trans_text = text
		trans_texts.append(trans_text)
	return trans_texts

def translate_items_grouped(texts: list, keys: list) -> list:
	# translate text in groups
	TEXT_SEP = '\n'
	
	text_groups = [[]]
	text_gks = [[]]
	tgrp_size = -len(TEXT_SEP)	# un-count separator for last line
	for (tid, text) in enumerate(texts):
		if tgrp_size + len(text) > TRANSLATE_MAX_CHARS:
			if tgrp_size > 0:
				text_groups.append([])
				text_gks.append([])
				tgrp_size = -len(TEXT_SEP)
		text_groups[-1].append(text)
		text_gks[-1].append(keys[tid])
		tgrp_size += len(text) + len(TEXT_SEP)
	
	line_base = 0
	for (gid, grp) in enumerate(text_groups):
		grptrans = translate_item_group(grp, text_gks[gid], TEXT_SEP, line_base, len(texts))
		if type(grptrans) is list:
			text_groups[gid] = grptrans
			line_base += len(grp)
			continue
		print("ignoring results.")
		line_base += len(grp)
	
	return [txt for grp in text_groups for txt in grp]

def translate_item_group(text_group: list, text_keys: list, line_sep: str, line_base: int, lines_total: int) -> typing.Optional[list]:
	RETRY_ATTEMPS = 2
	
	grptxt_count = len(text_group)
	for retry in range(RETRY_ATTEMPS):
		# translate the whole text group as one block
		try_sep = line_sep * (retry+1)
		grptext = try_sep.join(text_group)
		
		print(f"Translating lines {1+line_base}..{line_base+grptxt_count} / {lines_total} "
			f"({len(grptext)} characters) ...", end="", flush=True)
		t_start = time.time()
		grp_translated = translate_text(grptext)
		t_end = time.time()
		print(f"   {t_end - t_start:.2f} s", flush=True)
		
		if grp_translated is None:
			print("Failed to call web service")
			return None
		
		grptrans = grp_translated.split(try_sep)
		if len(grptrans) == grptxt_count:
			all_ok = True
			for (tid, txt) in enumerate(grptrans):
				if not check_keys_in_text(txt, text_keys[tid]):
					print(f"Placeholders got missing in line {1+line_base+tid} - ignoring translation.")
					all_ok = False
					break
			if all_ok:
				return grptrans
		else:
			print(f"Warning: Translation returned {len(grptrans)} lines when {grptxt_count} were expected - ", end='')
		if retry < (RETRY_ATTEMPS - 1):
			print("trying again.")
	
	if len(text_group) < 8:
		print("translating lines separately.")
		return translate_items_single(text_group, text_keys, line_base)
	else:
		print("splitting into smaller groups.")
		split_idx = len(text_group) // 2
		tg1 = translate_item_group(text_group[:split_idx], text_keys[:split_idx], line_sep, line_base + 0, lines_total)
		if tg1 is None:
			tg1 = text_group[:split_idx]
		tg2 = translate_item_group(text_group[split_idx:], text_keys[split_idx:], line_sep, line_base + split_idx, lines_total)
		if tg2 is None:
			tg2 = text_group[split_idx:]
		return tg1 + tg2

translate_req_id = 0
def translate_text(text: str) -> typing.Optional[str]:
	global config
	global translate_req_id

	if not config.raw:
		text = text.translate(str.maketrans({
			'\u3000': '  ',
			'「': '“',
			'」': '”',
			'『': '‘',
			'』': '’',
			'\uF87F': '',
		}))
	#return unicodedata.normalize("NFKC", text)
	
	if (translate_req_id % 10) == 0 and translate_req_id > 0:
		print("Waiting a bit ...", end="", flush=True)
		time.sleep(60)

	req = requests.get("https://translate.google.com/m",
		params = {
			"sl": LANGUAGE_SRC, # source language
			"tl": LANGUAGE_TGT, # target language
			"q":  text,         # query
		}
	)
	
	CONTAINER_START_STR = 'result-container">'
	CONTAINER_END_STR = '</div>'
	html_data = req.text
	if DEBUG_OUTPUT_PATH:
		fname = DEBUG_OUTPUT_PATH + f"05-{translate_req_id:03}_translate-"
		with open(fname + "request.txt", "wt") as f:
			f.write(req.request.method + " " + req.request.url + "\n")
			f.write(str(req.request.headers) + "\n\n")
			tmp = req.request.url[req.request.url.find('?')+1 :]
			tmp = requests.utils.unquote(tmp)
			f.write(tmp + "\n")
		with open(fname + "result.html", "wt") as f:
			f.write(html_data)
	translate_req_id += 1

	start_pos = html_data.find(CONTAINER_START_STR)
	if start_pos < 0:
		print("Web service returned unparseable page!")
		return None
	start_pos += len(CONTAINER_START_STR)
	end_pos = html_data.find(CONTAINER_END_STR, start_pos)
	if end_pos < 0:
		print("Web service returned unparseable page!")
		return None
	
	trans_text = html.unescape(html_data[start_pos : end_pos])
	#print(f"Source text: {text}")
	#print(f"Translated text: {trans_text}")

	# do some cleanups
	trans_text = trans_text.replace("``", "“")
	trans_text = trans_text.replace("''", "”")
	trans_text = trans_text.replace("\u200B", "")
	trans_text = trans_text.replace("\uFF5E", "~")
	trans_text = trans_text.replace("·", ".")
	return trans_text

def translate_tsv(fn_in: str, fn_out: str) -> int:
	try:
		tsv_lines = load_tsv(fn_in)
	except IOError:
		print(f"Error loading {fn_in}")
		return 1
	ret = parse_tsv(tsv_lines)
	if ret is None:
		return 2
	tsv_data = ret
	
	tsv_out = process_data(tsv_data)
	
	try:
		lines = []
		for line in tsv_out:
			if type(line) is str:
				lines += [line]
			else:
				lines += ["\t".join(line) + "\n"]
		write_tsv(fn_out, lines)
		print("Done.")
	except IOError:
		print(f"Error writing {fn_out}")
		return 1
	return 0

def main(argv):
	global config
	
	print("TSV Translator")
	aparse = argparse.ArgumentParser()
	aparse.add_argument("-r", "--raw", action="store_true", help="no remapping of Japanese quotation marks")
	aparse.add_argument("-t", "--title-case", action="store_true", help="apply Title Case to text items of 'selection' type")
	aparse.add_argument("-v", "--variables", type=str, help="YAML file that contains variables, can help with translation formatting")
	aparse.add_argument("in_file", help="input file (.TSV)")
	aparse.add_argument("out_file", help="output file (.TSV)")
	
	config = aparse.parse_args(argv[1:])
	
	if config.variables:
		global var_dict
		with open(config.variables, "rb") as f:
			var_dict = yaml.safe_load(f)
	
	return translate_tsv(config.in_file, config.out_file)

if __name__ == "__main__":
	sys.exit(main(sys.argv))
# vim: set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab:
