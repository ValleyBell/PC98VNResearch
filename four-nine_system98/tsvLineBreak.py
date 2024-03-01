#!/usr/bin/env python3
import sys
import os
import typing
import argparse
import unicodedata

DEBUG_OUTPUT_PATH = None
#DEBUG_OUTPUT_PATH = "/tmp/linebrk_"

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
	#elif config.textsize_check == 2:
	#	if len(lines) == line_count:
	#		return
	#	print(f"TSV line {1+txitm['line_st']}: New text has {len(lines)} line(s) " \
	#			f"when original one had {line_count}! (text box: {tb_size_str})")
	else:
		return
	
	# show line data
	#old_txt = []
	#for tsv_lid in range(txitm["line_st"], txitm["line_end"] + 1):
	#	if type(tsv_data[tsv_lid]) is str:
	#		continue	# ignore comment lines
	#	old_txt.append(tsv_data[tsv_lid][5])
	#print("\told: " + str(old_txt))
	print("\ttext: " + str(lines))
	return

def textitems2tsv(textitem_list: list, tsv_data: list, keep_lines: bool) -> list:
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
		
		can_add_linebreaks = False
		if txitm["mode"] != "sel":	# allow "txt" and "UNREF"
			if tb_height > 1:
				can_add_linebreaks = True	# line breaks may be added to longer text paragraphs
		if keep_lines:
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
					lines[-1] += text[pos : pos+chrlen]
					pos += chrlen
					lines[-1] += "\\"
					lines.append("")	# start new line
					xpos = 0
					continue
				elif ctrl_chr == '\n':	# new TSV line
					pos += chrlen
					continue
				elif ctrl_chr == 'c':	# set colour
					xpos -= 1	# This and the following byte don't affect the cursor.
					# I can't modify chrlen here, because the following byte is a separate "token" of variable length.
				elif ctrl_chr == 'w':	# wait + clear textbox
					lines[-1] += text[pos : pos+chrlen]
					pos += chrlen
					if not keep_lines:
						do_textsize_check(line_count, tbox_size, (tb_width, tb_height), tsv_data, txitm, lines, (max_xpos, len(lines) - tbox_ybase))
					lines[-1] += "\\"
					lines.append("")	# start new line
					xpos = 0
					
					# reset all coordinate data
					tbox_ybase = len(lines)
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
		if not keep_lines:
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

def line_breaks_remove(tsv_data: list) -> list:
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
	
	# Finally, reconstruct the TSV file.
	tsv_newdata = textitems2tsv(textitem_list, tsv_data, True)
	if DEBUG_OUTPUT_PATH:
		with open(DEBUG_OUTPUT_PATH + "07_tsvdata.log", "wt") as f:
			for cols in tsv_newdata:
				f.write(str(cols).rstrip() + "\n")
	return tsv_newdata

def line_breaks_add(tsv_data: list) -> list:
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
	
	# Finally, reconstruct the TSV file.
	# This includes inserting line breaks again.
	tsv_newdata = textitems2tsv(textitem_list, tsv_data, False)
	if DEBUG_OUTPUT_PATH:
		with open(DEBUG_OUTPUT_PATH + "07_tsvdata.log", "wt") as f:
			for cols in tsv_newdata:
				f.write(str(cols).rstrip() + "\n")
	return tsv_newdata

def main(argv):
	global config
	
	print("TSV Line-Break Tool")
	aparse = argparse.ArgumentParser()
	apgrp = aparse.add_mutually_exclusive_group(required=True)
	apgrp.add_argument("-r", "--remove", action="store_true", help="remove line breaks")
	apgrp.add_argument("-a", "--add", action="store_true", help="add line breaks according to text box sizes")
	aparse.add_argument("-c", "--textsize-check", type=int, help="0 = no check, 1 = check against textbox [default]", default=1)
	aparse.add_argument("in_file", help="input file (.TSV)")
	aparse.add_argument("out_file", help="output file (.TSV)")
	
	config = aparse.parse_args(argv[1:])
	
	#return tsv_linebreaks(config.in_file, config.out_file, config)
	try:
		tsv_lines = load_tsv(config.in_file)
	except IOError:
		print(f"Error loading {config.in_file}")
		return 1
	ret = parse_tsv(tsv_lines)
	if ret is None:
		return 2
	tsv_data = ret
	
	if config.remove:
		tsv_out = line_breaks_remove(tsv_data)
	elif config.add:
		tsv_out = line_breaks_add(tsv_data)
	else:
		print("No mode selected.")
		return 1
	
	try:
		lines = []
		for line in tsv_out:
			if type(line) is str:
				lines += [line]
			else:
				lines += ["\t".join(line) + "\n"]
		write_tsv(config.out_file, lines)
		print("Done.")
	except IOError:
		print(f"Error writing {config.out_file}")
		return 1
	return 0

if __name__ == "__main__":
	sys.exit(main(sys.argv))
# vim: set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab:
