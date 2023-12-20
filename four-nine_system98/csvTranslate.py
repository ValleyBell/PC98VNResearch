#!/usr/bin/env python3
import sys
import os
import typing
import argparse
import unicodedata
import requests
import html
import time

DEBUG_OUTPUT_PATH = None

def load_csv(fn_in: str) -> typing.List[str]:
	with open(fn_in, "rt", encoding="utf-8") as f:
		return f.readlines()

def write_csv(fn_out: str, lines: list) -> None:
	with open(fn_out, "wt", encoding="utf-8") as f:
		f.writelines(lines)
	return

def parse_csv(lines: list) -> list:
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

def csv2textitems(csv_data: list) -> list:
	textitem_list = []
	
	# collect "text groups" and fuse consecutive lines with the same "label"
	last_label = None
	tlid_start = None
	tlid_end = None
	tstr = None
	for (lid, cols) in enumerate(csv_data):
		if type(cols) is str:
			continue
		#print(cols)
		(filename, lineref, lblname, mode, tbox, text) = cols
		mode = cols[3]
		text = cols[5]
		if last_label != lblname:
			if tstr is not None:
				textitem_list += [{"line_st": tlid_start, "line_end": tlid_end, "mode": csv_data[tlid_start][3], "text": tstr}]
			last_label = lblname
			tlid_start = lid
			tstr = ""
		tstr += text
		tlid_end = lid
		if tstr.endswith('\\'):
			tstr += '\n'
		else:
			textitem_list += [{"line_st": tlid_start, "line_end": tlid_end, "mode": csv_data[tlid_start][3], "text": tstr}]
			tstr = None
			last_label = None
	if tstr is not None:
		textitem_list += [{"line_st": tlid_start, "line_end": tlid_end, "mode": csv_data[tlid_start][3], "text": tstr}]
	
	return textitem_list

def get_last_tbox_size(csv_data: list, line: int) -> str:
	while line >= 0:
		if "x" in csv_data[line][4]:
			return csv_data[line][4]
		line -= 1
	return "999x999"

def textitems2csv(textitem_list: list, csv_data: list) -> list:
	# reinsert text items into the CSV column list again
	csv_new = csv_data.copy()
	for tdat in textitem_list:
		# count effective text lines
		line_count = 0
		for csv_lid in range(tdat["line_st"], tdat["line_end"] + 1):
			if type(csv_new[csv_lid]) is str:
				continue	# don't count comment lines
			line_count += 1
		
		tbox_size = get_last_tbox_size(csv_data, tdat["line_st"])
		(tb_width, tb_height) = [int(x) for x in tbox_size.split("x")]
		#tb_width += 2	# somehow my calculations were off by 1
		
		can_add_linebreaks = False
		if tdat["mode"] == "txt":
			if tb_height > 1:
				can_add_linebreaks = True
		
		# split text data into multiple lines for the CSV
		text = tdat["text"]
		pos = 0
		xpos = 0
		lines = [""]
		# We are trying to insert automatic line breaks intelligently, based on the text box width and word spacing.
		last_word_lpos = 0	# character position (in *line*) of the beginning of the last "word"
		last_word_xpos = 0	# text X position of the beginning of the last "word"
		had_space_since_word = False
		while pos < len(text):
			chrlen = 1
			chrwidth = 0
			if (text[pos] == '\\') and (pos + 1 < len(text)):
				ctrl_chr = text[pos + 1]
				chrlen += 1
				if ctrl_chr == 'x':
					ccode = int(text[pos+chrlen : pos+chrlen+2], 0x10)
					chrwidth = get_cjk_char_width(chr(ccode))
					chrlen += 2
				elif ctrl_chr == 'j':
					chrwidth = 2	# assume full-width emoji / custom PC-98 font character
					chrlen += 4
				elif ctrl_chr == 'u':
					ccode = int(text[pos+chrlen : pos+chrlen+4], 0x10)
					chrwidth = get_cjk_char_width(chr(ccode))
					chrlen += 4
				elif ctrl_chr == 'U':
					ccode = int(text[pos+chrlen : pos+chrlen+8], 0x10)
					chrwidth = get_cjk_char_width(chr(ccode))
					chrlen += 8
				elif ctrl_chr == 'r':	# reset X position
					xpos = 0
				elif ctrl_chr == '\n':	# new CSV line
					lines[-1] += "\\"
					lines.append("")	# start new line
					pos += chrlen
					continue
				elif ctrl_chr == 'c':	# set colour
					xpos -= 1	# This and the following byte don't affect the cursor.
					# I can't modify chrlen here, because the following byte is a separate "token" of variable length.
				elif ctrl_chr == 'w':	# wait
					pass	# This byte doesn't affect the cursor.
			elif ord(text[pos]) >= 0x20:
				chrwidth = get_cjk_char_width(text[pos])
				if text[pos].isspace():
					last_word_lpos = len(lines[-1]) + chrlen
					last_word_xpos = xpos + chrwidth
			if can_add_linebreaks and (xpos + chrwidth > tb_width):
				# add line breaks only in "txt" mode
				if (last_word_lpos <= 0) or lines[-1][:last_word_lpos].isspace() or (last_word_xpos < tb_width*0.7):
					# (a) there were no spaces OR (b) the only spaces were indentation
					# -> just break in the middle of the word
					#print(f"Line break after: {str(lines)}")
					lines[-1] += "\\r\\"
					lines.append("")	# start new line
					xpos = 0
					last_word_lpos = 0
					last_word_xpos = 0
				else:
					# insert a line break at the beginning of the last word (and strip spaces)
					#print(f"Word-Line break after: {str(lines)}, XPos {xpos} -> {xpos - last_word_xpos}")
					#print(f"Line-Beginning: Word Pos {last_word_lpos}, Word XPos {last_word_xpos}, \"{lines[-1][:last_word_lpos]}\"")
					rem_line = lines[-1][last_word_lpos:]
					lines[-1] = lines[-1][:last_word_lpos] + "\\r\\"
					lines.append(rem_line)
					xpos -= last_word_xpos
					last_word_lpos = 0
					last_word_xpos = 0
			
			lines[-1] += text[pos : pos+chrlen]
			xpos += chrwidth
			pos += chrlen
		if lines[-1] == "":
			lines.pop(-1)
		if len(lines) != line_count:
			print(f"CSV line {1+tdat['line_st']}: New text has {len(lines)} line(s) when original one had {line_count}! (text box: {tbox_size})")
			old_txt = []
			for csv_lid in range(tdat["line_st"], tdat["line_end"] + 1):
				if type(csv_data[csv_lid]) is str:
					continue	# ignore comment lines
				old_txt.append(csv_data[csv_lid][5])
			print("\told: " + str(old_txt))
			print("\tnew: " + str(lines))
		
		# make sure that we can replace the lines exactly
		while len(lines) < line_count:
			lines[-1] += "\\"
			lines.append("")
		while len(lines) > line_count:
			if lines[-2].endswith("\\"):
				lines[-2] = lines[-2][:-1]	# remove trailing backslash
			lines[-2] += lines[-1]
			lines.pop(-1)
		
		# now insert the lines into the CSV
		line_count = tdat["line_end"] + 1 - tdat["line_st"]
		txt_lid = 0
		for csv_lid in range(tdat["line_st"], tdat["line_end"] + 1):
			if type(csv_new[csv_lid]) is str:
				continue	# ignore comment lines
			csv_new[csv_lid][5] = lines[txt_lid]
			txt_lid += 1
	return csv_new

# Fusioning rules:
#	general:
#		- replace \X codes with {n} (for later resolving)
#	mode "txt":
#		- for "\r" followed by a space, keep both
#		- just strip \r and fuse lines without spaces
#		- after "terminator", do 2x \n
#	mode "sel": replace \r at the end with normal newline

def process_data(csv_data: list) -> list:
	if DEBUG_OUTPUT_PATH:
		with open(DEBUG_OUTPUT_PATH + "00_csvdata.log", "wt") as f:
			for cols in csv_data:
				f.write(str(cols).rstrip() + "\n")
	
	# At first, collect "text groups" and fuse consecutive lines.
	textitem_list = csv2textitems(csv_data)
	if DEBUG_OUTPUT_PATH:
		with open(DEBUG_OUTPUT_PATH + "01_textitems_org.log", "wt") as f:
			for tdat in textitem_list:
				f.write(str(tdat) + "\n")
	
	# For each group, clean up the text by removing "\r" followed by more letters (with optional line-end between).
	SENTENCE_END_CHRS = ".?!\"»’‛”‟›‼❢。？！〉》」』"
	for tdat in textitem_list:
		text = tdat["text"]
		pos = text.find("\\r")
		while pos >= 0:
			next_pos = pos + 2
			if text[next_pos : next_pos+2] == '\\\n':
				next_pos += 2	# skip line end marker
			#print(f"Next: {text[next_pos : next_pos+2]}")
			if pos == 0:
				pass	# keep when the string starts with it
			elif (len(text) <= next_pos) or text[next_pos].isspace():
				pass	# keep when being followed by a space
			elif (pos > 1) and (text[pos - 1] in SENTENCE_END_CHRS):
				pass	# keep when the last character is a "sentence/paragraph end" character
			elif tdat["mode"] == "txt":
				# fuse lines
				text = text[:pos] + text[next_pos:]
				pos -= 1
			elif tdat["mode"] == "sel":
				pass	# keep
			pos = text.find("\\r", pos+1)
		tdat["text"] = text
	if DEBUG_OUTPUT_PATH:
		with open(DEBUG_OUTPUT_PATH + "02_textitems_clean.log", "wt") as f:
			for tdat in textitem_list:
				f.write(str(tdat) + "\n")
	
	# Extract "unique" lines and set references in the original list.
	trans_data = []
	unique_texts = []
	for (tid, tdat) in enumerate(textitem_list):
		for tline in tdat["text"].split('\n'):
			titem = text2translitem(tline)
			# Store text strings in a separate "unique texts" table.
			# This allows us to remove duplicate instances of text lines.
			try:
				ut_idx = unique_texts.index(titem["data"])
			except ValueError:
				ut_idx = len(unique_texts)
				unique_texts.append(titem["data"])
			titem.pop("data")
			titem["tidx"] = ut_idx	# and save only a text reference
			trans_data.append({"text_item": tid, **titem})
	if DEBUG_OUTPUT_PATH:
		with open(DEBUG_OUTPUT_PATH + "03_translate_texts.log", "wt") as f:
			for tdat in trans_data:
				f.write(str({**tdat, "text": unique_texts[tdat["tidx"]]}) + "\n")
	
	# Translate the unique text strings.
	translated_texts = translate_items(unique_texts)
	if DEBUG_OUTPUT_PATH:
		with open(DEBUG_OUTPUT_PATH + "04_translated_texts.log", "wt") as f:
			for tdat in trans_data:
				f.write(str({**tdat, "text": translated_texts[tdat["tidx"]]}) + "\n")
	
	# Reconstruct "textitem_list" using translated strings.
	textitem_newlist = textitem_list.copy()
	for tdat in textitem_newlist:
		tdat["text"] = []
	for titem in trans_data:
		tdat = textitem_newlist[titem["text_item"]]
		text = translitem2txt({**titem, "data": translated_texts[titem["tidx"]]})
		tdat["text"].append(text)
	for tdat in textitem_newlist:
		tdat["text"] = '\n'.join(tdat["text"])
	if DEBUG_OUTPUT_PATH:
		with open(DEBUG_OUTPUT_PATH + "05_textitems_translated.log", "wt") as f:
			for tdat in textitem_newlist:
				f.write(str(tdat) + "\n")
	
	# Finally, reconstruct the CSV file.
	csv_newdata = textitems2csv(textitem_newlist, csv_data)
	if DEBUG_OUTPUT_PATH:
		with open(DEBUG_OUTPUT_PATH + "06_csvdata.log", "wt") as f:
			for cols in csv_newdata:
				f.write(str(cols).rstrip() + "\n")
	return csv_newdata

def text2translitem(text: str) -> dict:
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
		chrtype = None
		chrlen = 1
		if (text[pos] == '\\') and (pos + 1 < len(text)):
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
				keyname = "{" + f"{key_id}" + "}"
				while keyname in text:
					key_id += 1
					keyname = "{" + f"{key_id}" + "}"
				keys[keyname] = tkey
				tnew += keyname
				key_id += 1
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

def translitem2txt(tdata: dict) -> str:
	tnew = tdata["data"]
	for (key, val) in tdata["keys"].items():
		tnew = tnew.replace(key, val)
	return tdata["start"] + tnew + tdata["end"]

def translate_items(texts: list) -> list:
	TEXT_SEP = '\n'
	CHARACTER_LIMIT = 500
	
	text_groups = [[]]
	tgrp_size = -len(TEXT_SEP)	# un-count separator for last line
	for text in texts:
		if tgrp_size + len(text) > CHARACTER_LIMIT:
			if tgrp_size > 0:
				text_groups.append([])
				tgrp_size = -len(TEXT_SEP)
		text_groups[-1].append(text)
		tgrp_size += len(text) + len(TEXT_SEP)
	
	line_base = 0
	for (gid, grp) in enumerate(text_groups):
		if True:
			# translate the whole text group as one block
			grptext = TEXT_SEP.join(grp)
			print(f"Translating lines {1+line_base}..{line_base+len(grp)} / {len(texts)} "
				f"({len(grptext)} characters) ...", end="", flush=True)
			t_start = time.time()
			grp_translated = translate_text(grptext)
			text_groups[gid] = grp_translated.split(TEXT_SEP)
			line_base += len(grp)
			t_end = time.time()
			print(f"   {t_end - t_start:.2f} s", flush=True)
		else:
			# translate each line separately
			for (tid, txt) in enumerate(grp):
				print(f"Translating line {1+line_base} / {len(texts)} ({len(txt)} characters) ...", end="", flush=True)
				t_start = time.time()
				grp[tid] = translate_text(txt)
				line_base += 1
				t_end = time.time()
				print(f"   {t_end - t_start:.2f} s", flush=True)
	
	return [txt for grp in text_groups for txt in grp]

def translate_text(text: str) -> str:
	text = text.translate(str.maketrans({
		'「': '“',
		'」': '”'
		'『': '‘',
		'』': '’'
	}))
	#return unicodedata.normalize("NFKC", text)
	
	req = requests.get("https://translate.google.com/m",
		params = {
			"sl": "ja", # source language
			"tl": "en", # target language
			"q": text,  # query
		}
	)

	CONTAINER_START_STR = 'result-container">'
	CONTAINER_END_STR = '</div>'
	html_data = req.text
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
	return trans_text

def translate_csv(fn_in: str, fn_out: str) -> int:
	try:
		csv_lines = load_csv(fn_in)
	except IOError:
		print(f"Error loading {fn_in}")
		return 1
	ret = parse_csv(csv_lines)
	if ret is None:
		return 2
	csv_data = ret
	
	csv_out = process_data(csv_data)
	
	try:
		lines = []
		for line in csv_out:
			if type(line) is str:
				lines += [line]
			else:
				lines += ["\t".join(line) + "\n"]
		write_csv(fn_out, lines)
		print("Done.")
	except IOError:
		print(f"Error writing {fn_out}")
		return 1
	return 0

def main(argv):
	global config
	
	print("CSV Translator")
	aparse = argparse.ArgumentParser()
	aparse.add_argument("in_file", help="input file (.CSV)")
	aparse.add_argument("out_file", help="output file (.CSV)")
	
	config = aparse.parse_args(argv[1:])
	
	return translate_csv(config.in_file, config.out_file)

if __name__ == "__main__":
	sys.exit(main(sys.argv))
# vim: set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab:
