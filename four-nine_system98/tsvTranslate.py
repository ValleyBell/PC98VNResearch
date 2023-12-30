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
#DEBUG_OUTPUT_PATH = "/tmp/tsvtrans_"

LANGUAGE_SRC = "ja"	# Japanese
LANGUAGE_TGT = "en"	# English
TRANSLATE_MAX_CHARS = 500	# maximum characters that are translated per request

config = {}

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
	
	# collect "text groups" and fuse consecutive lines with the same "label"
	last_label = None
	tlid_start = None
	tlid_end = None
	tstr = None
	for (lid, cols) in enumerate(tsv_data):
		if type(cols) is str:
			continue
		#print(cols)
		(filename, lineref, lblname, mode, tbox, text) = cols
		mode = cols[3]
		text = cols[5]
		if last_label != lblname:
			if tstr is not None:
				textitem_list += [{"line_st": tlid_start, "line_end": tlid_end, "mode": tsv_data[tlid_start][3], "text": tstr}]
			last_label = lblname
			tlid_start = lid
			tstr = ""
		tstr += text
		tlid_end = lid
		if tstr.endswith('\\'):
			tstr += '\n'
		else:
			textitem_list += [{"line_st": tlid_start, "line_end": tlid_end, "mode": tsv_data[tlid_start][3], "text": tstr}]
			tstr = None
			last_label = None
	if tstr is not None:
		textitem_list += [{"line_st": tlid_start, "line_end": tlid_end, "mode": tsv_data[tlid_start][3], "text": tstr}]
	
	return textitem_list

def get_last_tbox_size(tsv_data: list, line: int) -> str:
	while line >= 0:
		if "x" in tsv_data[line][4]:
			return tsv_data[line][4]
		line -= 1
	return "999x999"

def do_textsize_check(old_linecount, tb_size_str, tb_size_int, tsv_data, txitm, lines, text_size):
	global config
	
	(tb_width, tb_height) = tb_size_int
	if config.textsize_check == 1:
		(xpos, ypos) = text_size
		if xpos <= tb_width and ypos <= tb_height:
			return
		print(f"TSV line {1+txitm['line_st']}: New text ({xpos}x{ypos}) " \
				f"exceeds text box! (text box: {tb_size_str})")
	elif config.textsize_check == 2:
		if len(lines) == line_count:
			return
		print(f"TSV line {1+txitm['line_st']}: New text has {len(lines)} line(s) " \
				f"when original one had {line_count}! (text box: {tb_size_str})")
	else:
		return
	
	# show line data
	old_txt = []
	for tsv_lid in range(txitm["line_st"], txitm["line_end"] + 1):
		if type(tsv_data[tsv_lid]) is str:
			continue	# ignore comment lines
		old_txt.append(tsv_data[tsv_lid][5])
	print("\told: " + str(old_txt))
	print("\tnew: " + str(lines))
	return

def textitems2tsv(textitem_list: list, tsv_data: list) -> list:
	# reinsert text items into the TSV column list again
	tsv_new = tsv_data.copy()
	for txitm in textitem_list:
		# count effective text lines
		line_count = 0
		for tsv_lid in range(txitm["line_st"], txitm["line_end"] + 1):
			if type(tsv_new[tsv_lid]) is str:
				continue	# don't count comment lines
			line_count += 1
		
		tbox_size = get_last_tbox_size(tsv_data, txitm["line_st"])
		(tb_width, tb_height) = [int(x) for x in tbox_size.split("x")]
		#tb_width += 2	# somehow my calculations were off by 1
		
		can_add_linebreaks = False
		if txitm["mode"] == "txt":
			if tb_height > 1:
				can_add_linebreaks = True	# line breaks may be added to longer text paragraphs
		if config.keep_lines:
			can_add_linebreaks = False	# The option enforces to keep the original line breaks.
		
		# split text data into multiple lines for the TSV
		text = txitm["text"]
		pos = 0
		xpos = 0
		max_xpos = xpos
		tbox_ybase = 0
		lines = [""]
		# We are trying to insert automatic line breaks intelligently, based on the text box width and word spacing.
		last_word_lpos = pos	# character position (in *line*) of the beginning of the last "word"
		last_word_xpos = xpos	# text X position of the beginning of the last "word"
		while pos < len(text):
			chrlen = 1
			chrwidth = 0
			no_linebreak_now = False
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
				elif ctrl_chr == '\n':	# new TSV line
					lines[-1] += "\\"
					lines.append("")	# start new line
					pos += chrlen
					continue
				elif ctrl_chr == 'c':	# set colour
					xpos -= 1	# This and the following byte don't affect the cursor.
					# I can't modify chrlen here, because the following byte is a separate "token" of variable length.
				elif ctrl_chr == 'w':	# wait + clear textbox
					lines[-1] += text[pos : pos+chrlen]
					pos += chrlen
					do_textsize_check(line_count, tbox_size, (tb_width, tb_height), tsv_data, txitm, lines, (max_xpos, len(lines) - tbox_ybase))
					
					# reset all coordinate data
					tbox_ybase = len(lines)
					xpos = 0
					max_xpos = xpos
					last_word_lpos = pos
					last_word_xpos = xpos
					continue
			elif ord(text[pos]) >= 0x20:
				chrwidth = get_cjk_char_width(text[pos])
				if text[pos].isspace():
					no_linebreak_now = True	# prevent line breaks before spaces
					last_word_lpos = len(lines[-1]) + chrlen
					last_word_xpos = xpos + chrwidth
			if can_add_linebreaks and (xpos + chrwidth > tb_width) and not no_linebreak_now:
				# add line breaks only in "txt" mode
				if (last_word_lpos <= 0) or lines[-1][:last_word_lpos].isspace() or \
					(last_word_xpos < tb_width*0.7):
					# (a) there were no spaces OR
					# (b) the only spaces were indentation OR
					# (c) the last word is very long (more than 30% of the line)
					# -> just break in the middle of the word
					#print(f"Line break after: {str(lines)}")
					lines[-1] += "\\r\\"
					lines.append("")	# start new line
					xpos = 0
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
			if not text[pos : pos+chrlen].isspace():
				max_xpos = max([xpos, max_xpos])
			xpos += chrwidth
			pos += chrlen
		do_textsize_check(line_count, tbox_size, (tb_width, tb_height), tsv_data, txitm, lines, (max_xpos, len(lines) - tbox_ybase))
		
		# make sure that we can replace the lines exactly
		while len(lines) < line_count:
			lines[-1] += "\\"
			lines.append("")
		while len(lines) > line_count:
			if lines[-2].endswith("\\"):
				lines[-2] = lines[-2][:-1]	# remove trailing backslash
			lines[-2] += lines[-1]
			lines.pop(-1)
		
		# now insert the lines into the TSV
		line_count = txitm["line_end"] + 1 - txitm["line_st"]
		txt_lid = 0
		for tsv_lid in range(txitm["line_st"], txitm["line_end"] + 1):
			if type(tsv_new[tsv_lid]) is str:
				continue	# ignore comment lines
			tsv_new[tsv_lid][5] = lines[txt_lid]
			txt_lid += 1
	return tsv_new

# Fusioning rules:
#	general:
#		- replace \X codes with {n} (for later resolving)
#	mode "txt":
#		- for "\r" followed by a space, keep both
#		- just strip \r and fuse lines without spaces
#		- after "terminator", do 2x \n
#	mode "sel": replace \r at the end with normal newline

def process_data(tsv_data: list) -> list:
	global config

	if DEBUG_OUTPUT_PATH:
		with open(DEBUG_OUTPUT_PATH + "00_tsvdata.log", "wt") as f:
			for cols in tsv_data:
				f.write(str(cols).rstrip() + "\n")
	
	# At first, collect "text groups" and fuse consecutive lines.
	textitem_list = tsv2textitems(tsv_data)
	if DEBUG_OUTPUT_PATH:
		with open(DEBUG_OUTPUT_PATH + "01_textitems_org.log", "wt") as f:
			for txitm in textitem_list:
				f.write(str(txitm) + "\n")
	
	if not config.keep_lines:
		# For each group, clean up the text by removing "\r" followed by more letters (with optional line-end between).
		SENTENCE_END_CHRS = ".?!\"»’‛”‟›‼❢。？！〉》」』"
		for txitm in textitem_list:
			text = txitm["text"]
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
				elif txitm["mode"] == "txt":
					# fuse lines
					text = text[:pos] + text[next_pos:]
					pos -= 1
				elif txitm["mode"] == "sel":
					pass	# keep
				pos = text.find("\\r", pos+1)
			txitm["text"] = text
		if DEBUG_OUTPUT_PATH:
			with open(DEBUG_OUTPUT_PATH + "02_textitems_clean.log", "wt") as f:
				for txitm in textitem_list:
					f.write(str(txitm) + "\n")
	
	# Extract "unique" lines and set references in the original list.
	trans_data = []
	unique_texts = []
	for (tid, txitm) in enumerate(textitem_list):
		for tline in txitm["text"].split('\n'):
			trdat = text2transdata(tline)
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
			trdat.pop("data")
			trdat["tidx"] = ut_idx	# and save only a text reference
			trans_data.append({"text_item": tid, **trdat})
	if DEBUG_OUTPUT_PATH:
		with open(DEBUG_OUTPUT_PATH + "03_translate_texts.log", "wt") as f:
			for trdat in trans_data:
				text = unique_texts[trdat["tidx"]] if (trdat["tidx"] >= 0) else ""
				f.write(str({**trdat, "text": text}) + "\n")
	
	# Translate the unique text strings.
	translated_texts = translate_items(unique_texts)
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
		if not config.raw and txitm["mode"] == "sel":
			text = text.title()
		txitm["text"].append(transdata2txt({**trdat, "data": text}))
	for txitm in textitem_newlist:
		txitm["text"] = '\n'.join(txitm["text"])
	if DEBUG_OUTPUT_PATH:
		with open(DEBUG_OUTPUT_PATH + "06_textitems_translated.log", "wt") as f:
			for txitm in textitem_newlist:
				f.write(str(txitm) + "\n")
	
	# Finally, reconstruct the TSV file.
	# This includes inserting line breaks again.
	tsv_newdata = textitems2tsv(textitem_newlist, tsv_data)
	if DEBUG_OUTPUT_PATH:
		with open(DEBUG_OUTPUT_PATH + "07_tsvdata.log", "wt") as f:
			for cols in tsv_newdata:
				f.write(str(cols).rstrip() + "\n")
	return tsv_newdata

def text2transdata(text: str) -> dict:
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

def transdata2txt(tdata: dict) -> str:
	tnew = tdata["data"]
	for (key, val) in tdata["keys"].items():
		tnew = tnew.replace(key, val)
	return tdata["start"] + tnew + tdata["end"]

def translate_items(texts: list) -> list:
	TEXT_SEP = '\n'
	
	text_groups = [[]]
	tgrp_size = -len(TEXT_SEP)	# un-count separator for last line
	for text in texts:
		if tgrp_size + len(text) > TRANSLATE_MAX_CHARS:
			if tgrp_size > 0:
				text_groups.append([])
				tgrp_size = -len(TEXT_SEP)
		text_groups[-1].append(text)
		tgrp_size += len(text) + len(TEXT_SEP)
	
	line_base = 0
	for (gid, grp) in enumerate(text_groups):
		if True:
			# translate the whole text group as one block
			grptxt_count = len(grp)
			grptext = TEXT_SEP.join(grp)
			
			print(f"Translating lines {1+line_base}..{line_base+grptxt_count} / {len(texts)} "
				f"({len(grptext)} characters) ...", end="", flush=True)
			t_start = time.time()
			grp_translated = translate_text(grptext)
			t_end = time.time()
			print(f"   {t_end - t_start:.2f} s", flush=True)
			
			if grp_translated is None:
				print("Failed to call web service")
			else:
				grptrans = grp_translated.split(TEXT_SEP) if grp_translated is not None else []
				if len(grptrans) == grptxt_count:
					text_groups[gid] = grptrans
				else:
					print("Warning: Translation returned {len(text_groups[gid])} lines when only {grptxt_count} were expected - ignoring results.")
			line_base += grptxt_count
		else:
			# translate each line separately
			for (tid, txt) in enumerate(grp):
				print(f"Translating line {1+line_base} / {len(texts)} ({len(txt)} characters) ...", end="", flush=True)
				t_start = time.time()
				trans_text = translate_text(txt)
				t_end = time.time()
				print(f"   {t_end - t_start:.2f} s", flush=True)
				
				if trans_text is None:
					print("Failed to call web service")
				else:
					grp[tid] = trans_text
				line_base += 1
	
	return [txt for grp in text_groups for txt in grp]

translate_req_id = 0
def translate_text(text: str) -> str:
	global config
	global translate_req_id

	if not config.raw:
		text = text.translate(str.maketrans({
			'「': '“',
			'」': '”',
			'『': '‘',
			'』': '’',
			'\uF87F': '',
		}))
	#return unicodedata.normalize("NFKC", text)
	
	if (translate_req_id % 10) == 0 and translate_req_id > 0:
		print("Waiting a bit ...")
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
	aparse.add_argument("-l", "--keep-lines", action="store_true", help="do NOT remove + reinsert line breaks")
	aparse.add_argument("-c", "--textsize-check", type=int, help="0 = no check, 1 = check against textbox [default], 2 = check against previous text", default=1)
	aparse.add_argument("in_file", help="input file (.TSV)")
	aparse.add_argument("out_file", help="output file (.TSV)")
	
	config = aparse.parse_args(argv[1:])
	
	return translate_tsv(config.in_file, config.out_file)

if __name__ == "__main__":
	sys.exit(main(sys.argv))
# vim: set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab:
