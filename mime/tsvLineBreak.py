#!/usr/bin/env python3
import sys
import typing
import argparse
#import unicodedata
import hyphen	# requires pip package "PyHyphen"

DEBUG_OUTPUT_PATH = None
#DEBUG_OUTPUT_PATH = "/tmp/linebrk_"

TEXTCOL_FIE = 0
TEXTCOL_LINE = 1
TEXTCOL_LABEL = 2
TEXTCOL_TYPE = 3
TEXTCOL_TBOX = 4
TEXTCOL_TEXT = 5

config = {}
var_dict = {
	"words": [
		{"key": "##", "length": 8},
	]
}
hyp_en = None

def load_tsv(fn_in: str) -> typing.List[str]:
	with open(fn_in, "rt", encoding="utf-8") as f:
		return f.readlines()

def write_tsv(fn_out: str, lines: list) -> None:
	with open(fn_out, "wt", encoding="utf-8") as f:
		f.writelines(lines)
	return

def unquote_column(text: str) -> str:
	if not text.startswith('"'):
		return text
	
	text = text[1:]
	pos = text.find('"')
	while pos >= 0:
		if not (pos + 1 < len(text) and text[pos+1] == '"'):
			text = text[:pos]
			break
		text = text[:pos] + '"' + text[pos+2:]
		pos = text.find('"', pos + 1)
	return text

def quote_column(text: str) -> str:
	if ('"' not in text) and ('\n' not in text):
		return text
	
	return '"' + text.replace('"', '""') + '"'

def parse_tsv(lines: list) -> list:
	global config
	
	if len(lines) > 0:
		if lines[0].startswith("file\t"):
			lines[0] = "#" + lines[0]	# enforce header to be a comment
	
	result = []
	for (lid, line) in enumerate(lines):
		line = line.rstrip('\n')
		ltrim = line.lstrip()
		if len(ltrim) == 0 or ltrim.startswith('#') or ltrim.startswith(';'):
			result += [line]
			continue
		cols = line.split('\t')
		if len(cols) < 6:
			print(f"Line {lid} invalid: {line}")
			return None
		if config.text_column >= len(cols):
			result += [line]
			continue	# ignore lines that don't have the respective column
		text = cols[config.text_column]
		if len(text) == 0:
			result += [line]
			continue	# ignore empty texts as well
		result += [cols]
	return result

def get_cjk_char_width(c: str) -> int:
	if len(c) == 2 and c[1] == '\uF87F':
		return 1	# half-width ASCII mirror and Katakana
	#return 2 if unicodedata.east_asian_width(c) in ["W", "F"] else 1
	# This matches the usual PC-98 font handling better.
	ccode = ord(c)
	if (ccode < 0x80) or (ccode == 0x00A5):	# ASCII or Yen sign
		return 1
	elif ccode == 0xF87F:
		return 0	# meta-code for special character combinations
	elif (ccode >= 0xFF61) and (ccode <= 0xFF9F):	# halfwidth Katakana
		return 1
	else:
		return 2	# everything else should be considered 2 characters wide

def do_textsize_check(tb_size, tsv_cols, line_id, lines, text_size, xpos):
	global config
	
	(tb_width, tb_height) = tb_size
	if config.textsize_check == 1:
		(xsize, ysize) = text_size
		if len(lines) > 0 and xpos <= 0:
			ysize -= 1	# ignore last line when empty
		if xsize <= tb_width and ysize <= tb_height:
			return
		print(f"TSV line {1+line_id}: New text ({xsize}x{ysize}) " \
				f"exceeds text box! (text box: {tb_width}x{tb_height})")
	else:
		return
	
	# show line data
	#print("\told: " + str(old_txt))
	print("\ttext: " + str(lines))
	return

def split_keep(text: str, sep: str) -> list:
	parts = text.split(sep)
	for idx in range(len(parts) - 1):
		parts[idx] += sep
	return parts

TXTFLAG_SPACE		= 0x01	# character is a space
TXTFLAG_LINE_BREAK	= 0x02	# line break after this character
TXTFLAG_SPC_BREAK	= 0x04	# special line break character
TXTFLAG_NO_BREAK	= 0x08	# prevent line break at this character
TXTFLAG_LWORD_BEGIN	= 0x10	# "long word" can be a concatenated word with trailing punctiation ("abc-def.")
TXTFLAG_LWORD_END	= 0x20
TXTFLAG_CWORD_BEGIN	= 0x40	# "core word" is just a single word that consists only of alphabet letters
TXTFLAG_CWORD_END	= 0x80

def parse_text(text: str) -> list:
	global config
	global var_dict
	
	# split text data into "tokens", with annotated width/height/...
	ptext = []
	state_space = 0x01
	state_alpha = 0x00
	pos = 0
	while pos < len(text):
		text_var = None
		for tv in var_dict["words"]:
			tvkey = tv["key"]
			tkvlen = len(tvkey)
			if text[pos : pos+tkvlen] == tvkey:
				text_var = tv
				break
		
		chrlen = 1
		chrwidth = 0
		flags = 0x00
		state_space = (state_space << 1) & 0x33
		state_alpha = (state_alpha << 1) & 0x03
		if text_var is not None:
			chrlen = len(text_var["key"])
			chrwidth = text_var["length"]
			# afterwards, we process it as a normal "word" (including line splitting etc.)
			flags |= (TXTFLAG_CWORD_BEGIN | TXTFLAG_CWORD_END)
			state_space |= 0x10
		elif (text[pos] == '\\') and (pos + 1 < len(text)):
			ctrl_chr = text[pos + 1]
			chrlen += 1
			if ctrl_chr == 'x':
				ctrl_chr += text[pos+chrlen : pos+chrlen+2].upper()
				ccode = int(ctrl_chr[1:], 0x10)
				if ccode >= 0x20:
					chrwidth = 1	# assume half-width (full-width characters will take 2 bytes)
				elif ccode == 0x09:
					ctrl_chr = 't'	# tab
				elif ccode == 0x0A:
					ctrl_chr = 'n'	# new line
				chrlen += 2
			
			if ctrl_chr == 'u':
				ccode = int(text[pos+chrlen : pos+chrlen+4], 0x10)
				ccstr = chr(ccode)
				chrwidth = get_cjk_char_width(ccstr)
				chrlen += 4
				state_space |= 0x01 if text[pos].isspace() else 0x10
				if text[pos].isalpha():
					state_alpha |= 0x01
			elif ctrl_chr == 'U':
				ccode = int(text[pos+chrlen : pos+chrlen+8], 0x10)
				ccstr = chr(ccode)
				chrwidth = get_cjk_char_width(ccstr)
				chrlen += 8
				state_space |= 0x01 if text[pos].isspace() else 0x10
				if text[pos].isalpha():
					state_alpha |= 0x01
			elif ctrl_chr == 't':	# tab
				chrwidth = 8
				state_space |= 0x01
			elif ctrl_chr == 'n':	# new line
				chrwidth = 0
				flags |= TXTFLAG_LINE_BREAK
				state_space |= 0x20	# enforce LWORD_END
			elif ctrl_chr == '\n':	# new TSV line
				continue		# just ignore
		elif ord(text[pos]) >= 0x20:
			ccstr = text[pos]
			if (pos + 1 < len(text)) and (text[pos + 1] == '\uF87F'):
				ccstr += text[pos + 1]
				chrlen += 1
			
			if len(ccstr) == 2 and (ccstr[0] >= 'A' and ccstr[0] <= 'Z'):
				chrwidth = 2	# special glyphs used for ancient language
			elif ccstr in "\u201C\u201D\u2018\u2019":
				if config.quote_mode == 0:
					chrwidth = 2	# in mode 0, they will be full-width
				else:
					chrwidth = 1	# the "reinsert" script will convert those to half-width ASCII
			elif ccstr == "\u2026":
				chrwidth = 3	# the "reinsert" script will convert this to "..."
			else:
				chrwidth = get_cjk_char_width(ccstr)
			
			state_space |= 0x01 if ccstr.isspace() else 0x10
			if ccstr.isalpha():
				state_alpha |= 0x01
			if ccstr == '】':
				# Shift-JIS closing bracket (817A): special code for "person name END"
				flags |= (TXTFLAG_SPC_BREAK | TXTFLAG_LWORD_END)
		
		if (state_space & 0x01):
			flags |= TXTFLAG_SPACE
			flags |= TXTFLAG_NO_BREAK	# prevent line breaks before spaces
		if (state_space & 0x03) == 0x02:	# transition space -> non-space
			flags |= TXTFLAG_LWORD_BEGIN
		elif (state_space & 0x30) == 0x20:	# transition non-space -> space
			ptext[-1]["flags"] |= TXTFLAG_LWORD_END
		if state_alpha == 0x01:
			flags |= TXTFLAG_CWORD_BEGIN
		elif state_alpha == 0x02:
			ptext[-1]["flags"] |= TXTFLAG_CWORD_END

		if (flags & (TXTFLAG_LINE_BREAK | TXTFLAG_SPC_BREAK)):
			state_space = 0x01	# enforce LWORD_BEGIN at next letter/control character
		
		ptext.append({
			"data": text[pos : pos+chrlen],
			"pos": pos,
			"width": chrwidth,
			"flags": flags,
		})
		pos += chrlen
	
	state_space = (state_space << 1) & 0x33
	state_alpha = (state_alpha << 1) & 0x03
	if (state_space & 0x30) == 0x20:	# transition non-space -> space
		ptext[-1]["flags"] |= TXTFLAG_LWORD_END
	if state_alpha == 0x02:
		ptext[-1]["flags"] |= TXTFLAG_CWORD_END
	return ptext

def extract_word_tokens(tokens: list, startIdx: int, flagBegin: int, flagEnd: int) -> tuple:
	beginIdx = startIdx
	while beginIdx > 0:
		if tokens[beginIdx]["flags"] & flagBegin:
			break
		beginIdx -= 1
	
	endIdx = beginIdx
	while endIdx < len(tokens):
		if tokens[endIdx]["flags"] & flagEnd:
			endIdx += 1	# the "END" flag marks the last letter in the word, but we return the index *after* it
			break
		endIdx += 1
	
	return (beginIdx, endIdx)

def has_alpha(text: str) -> bool:
	for tchr in text:
		if tchr.isalpha():
			return True
	return False

def add_breaks_to_line(text: str, line_cols: list, line_id: int) -> list:
	global config
	global var_dict
	
	if line_cols[TEXTCOL_TYPE] == "sel":
		return text	# skip "selection" lines, as its text box size is determined by the game
	
	tbox_size = line_cols[TEXTCOL_TBOX].split('@')[0]
	if not "x" in tbox_size:
		return text	# not text box size set - skip these as well
	(tb_width, tb_height) = [int(x) for x in tbox_size.split("x")]
	
	multiline_text = False
	if line_cols[TEXTCOL_TYPE] == "txt":
		if tb_height > 1:
			multiline_text = True	# line breaks may be added to longer text paragraphs
	
	ptext = parse_text(text)
	
	# split text data into multiple lines for the TSV
	line_xbase = 0
	tbox_ybase = 0
	xpos = line_xbase
	max_xpos = xpos
	lines = [""]
	# We are trying to insert automatic line breaks intelligently, based on the text box width and word spacing.
	for (ptid, ptinfo) in enumerate(ptext):
		chrwidth = ptinfo["width"]
		flags = ptinfo["flags"]
		if (flags & TXTFLAG_LINE_BREAK):
			ptinfo["linepos"] = (len(lines) - 1, len(lines[-1]), xpos)
			lines[-1] += ptinfo["data"]
			lines.append("")	# start new line
			xpos = line_xbase
			continue
		
		can_add_linebreaks = multiline_text and not (flags & TXTFLAG_NO_BREAK)
		#print(f"CPos {ptinfo['pos']}, XPos {xpos}, Lines {len(lines)}, NextChr: '{ptinfo['data']}' (width {chrwidth}), LastLine: {lines[-1]}")
		
		if can_add_linebreaks and (xpos + chrwidth > tb_width):
			ptinfo["linepos"] = (len(lines) - 1, len(lines[-1]), xpos)	# make token search below work properly
			
			break_mode = None
			(lwBegIdx, lwEndIdx) = extract_word_tokens(ptext, ptid, TXTFLAG_LWORD_BEGIN, TXTFLAG_LWORD_END)
			(cwBegIdx, cwEndIdx) = extract_word_tokens(ptext, ptid, TXTFLAG_CWORD_BEGIN | TXTFLAG_LWORD_BEGIN, TXTFLAG_CWORD_END | TXTFLAG_LWORD_END)
			if (ptext[cwBegIdx]["linepos"][2] > ptext[lwBegIdx]["linepos"][2]) and \
				(ptext[cwBegIdx - 1]["data"][-1] == '-'):
				# When the last word ended with a hyphen, assume we can break after that as if it was a space.
				# (comparing the X position is a harder requirement than comparing the index)
				lwBegIdx = cwBegIdx
			lw_lpos = ptext[lwBegIdx]["linepos"][1]	# character position (in *line*) of the beginning of the last "word"
			lw_xpos = ptext[lwBegIdx]["linepos"][2]	# text X position of the beginning of the last "word"
			
			#print(f"    split ({xpos + chrwidth} > {tb_width}), word chr-pos {lw_lpos}, word X-pos {lw_xpos}, maxlen {tb_width*0.75-4}")
			if config.hyphenation and ((xpos - lw_xpos) > 2):
				# try doing hyphenation on the current word
				
				# The hyphenation library has issues with "concatenated-words" and can crash on them,
				# so let's just give it the "main" word.
				phrase = "".join([ptitem["data"] for ptitem in ptext[cwBegIdx : cwEndIdx]])
				if has_alpha(phrase):	# The phrase *needs* at least one actual letter.
					if ptid < cwEndIdx:
						# Line end happens in the middle of the word: just take the position as split point.
						# The library may split at earlier points to make space for the required hyphen.
						hyp_split_pos = sum([len(ptitem["data"]) for ptitem in ptext[cwBegIdx : ptid]])
					else:
						# Line end happens during punctuation after the word: split point = before last character.
						hyp_split_pos = len(phrase) - 1
					
					#cw_xpos = ptext[cwBegIdx]['linepos'][2]
					#print(f"Line-1: {lines[-1]}\nPhrase: {phrase}\nWordXPos: {cw_xpos}, XPos: {xpos}, BreakCharPos: {hyp_split_pos}")
					try:
						word_hyp = hyp_en.wrap(phrase, hyp_split_pos)
					except:
						print(f'Error hyphenating "{phrase}", wrap at <{hyp_split_pos}')
						word_hyp = []
					if len(word_hyp) > 1:
						break_mode = 2	# break using hyphenation
						hyp_w0pos = ptext[cwBegIdx]["linepos"][1]
						# determine word split point in phrase
						rem_phrase = word_hyp[1]
						for hyp_w1idx in range(cwEndIdx, cwBegIdx, -1):
							ptitem = ptext[hyp_w1idx - 1]
							if len(rem_phrase) == 0 or not rem_phrase.endswith(ptitem["data"]):
								break
							rem_phrase = rem_phrase[0 : -len(ptitem["data"])]
						hyp_w1pos = ptext[hyp_w1idx]["linepos"][1]
			
			if break_mode is None:
				# fallback when no hypenation was used
				if (lw_lpos <= 0) or lines[-1][:lw_lpos].isspace():
					# (a) there were no spaces OR
					# (b) the only spaces were indentation
					break_mode = 0	# break in the middle of the word
				elif lw_xpos < (tb_width*0.75 - 4):
					# the last word is very long (more than 30% of the line)
					#     (approximating "30%" with "25% + 4 characters" here for better behaviour with short text boxes)
					break_mode = 0	# break in the middle of the word
				else:
					break_mode = 1	# insert a line break at the beginning of the last word (and strip spaces)
			
			if break_mode == 0:
				# (a) there were no spaces OR
				# (b) the only spaces were indentation OR
				# (c) the last word is very long (more than 30% of the line)
				#     (approximating "30%" with "25% + 4 characters" here for better behaviour with short text boxes)
				# -> just break in the middle of the word
				#print(f"Line break after: {str(lines)}")
				lines.append("")	# start new line
				ptinfo["flags"] |= TXTFLAG_LWORD_BEGIN
				xpos = line_xbase
			elif break_mode == 1:
				# insert a line break at the beginning of the last word (and strip spaces)
				#print(f"Word-Line break after: {str(lines)}, XPos {xpos} -> {xpos - lw_xpos}")
				#print(f"Line-Beginning: Word Pos {lw_lpos}, Word XPos {lw_xpos}, \"{lines[-1][:lw_lpos]}\"")
				rem_line = lines[-1][lw_lpos:]
				lines[-1] = lines[-1][:lw_lpos]
				lines.append(rem_line)
				ptext[lwBegIdx]["flags"] |= TXTFLAG_LWORD_BEGIN
				for ptMoveId in range(lwBegIdx, ptid):
					ptlp = ptext[ptMoveId]["linepos"]
					ptext[ptMoveId]["linepos"] = (len(lines) - 1, ptlp[1] - lw_lpos, ptlp[2] - lw_xpos + line_xbase)
				xpos = xpos - lw_xpos + line_xbase
			elif break_mode == 2:
				rem_line = lines[-1][hyp_w1pos:]
				lines[-1] = lines[-1][:hyp_w0pos] + word_hyp[0]
				lines.append(rem_line)
				lw_lpos = ptext[hyp_w1idx]["linepos"][1]
				lw_xpos = ptext[hyp_w1idx]["linepos"][2]
				ptext[hyp_w1idx]["flags"] |= TXTFLAG_LWORD_BEGIN
				for ptMoveId in range(hyp_w1idx, ptid):
					ptlp = ptext[ptMoveId]["linepos"]
					ptext[ptMoveId]["linepos"] = (len(lines) - 1, ptlp[1] - lw_lpos, ptlp[2] - lw_xpos + line_xbase)
				xpos = xpos - lw_xpos + line_xbase
		
		ptinfo["linepos"] = (len(lines) - 1, len(lines[-1]), xpos)	# (line index/Y position, character index, screen X position)
		lines[-1] += ptinfo["data"]
		xpos += chrwidth
		if not (flags & TXTFLAG_SPACE):
			max_xpos = max([xpos, max_xpos])
		
		if flags & TXTFLAG_SPC_BREAK:
			if tb_width < 60:
				# 32-character text box
				tbox_ybase -= 1		# simulate starting a new line
				xpos = line_xbase
				# modify indent for all following lines
				if ptid + 1 < len(ptext) and ptext[ptid + 1]["data"] == '「':
					# Shift-JIS 8175: person talk begin
					line_xbase = 2	# indent by 1 full-width character
				else:
					line_xbase = 0	# no indent
			else:
				# 74-character text box
				if xpos < 14:
					xpos = 14
				line_xbase = xpos
				# stay on the same line
	do_textsize_check((tb_width, tb_height), line_cols, line_id, lines, (max_xpos, len(lines) - tbox_ybase), xpos)
	
	lines = [line.rstrip() for line in lines]
	return '\\n'.join(lines)

def remove_break_from_line(text: str, SENTENCE_END_CHRS: set) -> str:
	is_newline = False
	last_non_spc = '\x00'
	last_chr = '\x00'
	pos = 0
	keep_next_nl = True
	while pos < len(text):
		chrlen = 1
		cur_chr = text[pos]
		if (text[pos] == '\\') and (pos + 1 < len(text)):
			ctrl_chr = text[pos + 1]
			cur_chr += ctrl_chr
			chrlen += 1
			if ctrl_chr == 'x':
				ccode = int(text[pos+chrlen : pos+chrlen+2], 0x10)
				cur_chr = chr(ccode)
				chrlen += 2
			elif ctrl_chr == 'j':
				cur_chr = '\0x00'
				chrlen += 4
			elif ctrl_chr == 'u':
				ccode = int(text[pos+chrlen : pos+chrlen+4], 0x10)
				cur_chr = chr(ccode)
				chrlen += 4
			elif ctrl_chr == 'U':
				ccode = int(text[pos+chrlen : pos+chrlen+8], 0x10)
				cur_chr = chr(ccode)
				chrlen += 8
			elif ctrl_chr in ['n']:	# new line / scroll line
				is_newline = True
			elif ctrl_chr == '\n':	# new TSV line
				pass
		elif ord(text[pos]) >= 0x0020:
			keep_next_nl = False	# when the actual text starts, start removing line breaks
		
		if is_newline:
			is_newline = False
			next_pos = pos + chrlen
			if text[next_pos : next_pos+2] == '\\\n':
				next_pos += 2	# skip line end marker
			#print(f"Next: {text[next_pos : next_pos+2]}")
			if keep_next_nl:
				pass	# keep at the beginning of the text
			elif (len(last_non_spc) == 1) and last_non_spc in SENTENCE_END_CHRS:
				pass	# keep when the last character is a "sentence/paragraph end" character
			elif (len(last_non_spc) == 1) and (ord(last_non_spc) in range(0x1F000, 0x20000)):
				pass	# keep when the last character is a symbol or emoji character
			else:
				# fuse lines
				if get_cjk_char_width(text[pos - 1]) == 1:
					# ASCII text: replace newline with a space
					text = text[:pos] + " " + text[next_pos:]
				else:
					# full-width glyphs: just remove newline
					text = text[:pos] + text[next_pos:]
				chrlen = 0
		last_chr = cur_chr
		if not cur_chr.isspace():
			last_non_spc = last_chr
		pos += chrlen
	
	return text

def line_breaks_remove(tsv_data: list) -> list:
	global config

	if DEBUG_OUTPUT_PATH:
		with open(DEBUG_OUTPUT_PATH + "00_tsvdata.log", "wt") as f:
			for cols in tsv_data:
				f.write(str(cols) + "\n")
	tsv_data = tsv_data.copy()
	
	# For each group, clean up the text by removing "\r" followed by more letters (with optional line-end between).
	SENTENCE_END_CHRS = ".?!\"»’‛”‟›‼⁈❢。？！〉》」』・"
	SENTENCE_END_CHRS += "".join([chr(x) for x in range(0x2500, 0x2800)])	# add various symbols
	SENTENCE_END_CHRS += "".join([chr(x) for x in range(0x2900, 0x2C00)])	# add more arrows
	SENTENCE_END_CHRS = set(SENTENCE_END_CHRS)	# convert to set for faster lookup
	for cols in tsv_data:
		if type(cols) is not list:
			continue
		if cols[TEXTCOL_TYPE] == "txt":
			text = unquote_column(cols[config.text_column])
			text = remove_break_from_line(text, SENTENCE_END_CHRS)
			cols[config.text_column] = quote_column(text)
	if DEBUG_OUTPUT_PATH:
		with open(DEBUG_OUTPUT_PATH + "01_textitems_clean.log", "wt") as f:
			for cols in tsv_data:
				f.write(str(cols) + "\n")
	
	return tsv_data

def line_breaks_add(tsv_data: list) -> list:
	global config
	global hyp_en

	if DEBUG_OUTPUT_PATH:
		with open(DEBUG_OUTPUT_PATH + "00_tsvdata.log", "wt") as f:
			for cols in tsv_data:
				f.write(str(cols) + "\n")
	tsv_data = tsv_data.copy()
	
	if config.hyphenation:
		hyp_en = hyphen.Hyphenator('en_GB')
	for (line_id, cols) in enumerate(tsv_data):
		if type(cols) is not list:
			continue
		if cols[TEXTCOL_TYPE] == "txt":
			text = unquote_column(cols[config.text_column])
			text = add_breaks_to_line(text, cols, line_id)
			cols[config.text_column] = quote_column(text)
	if DEBUG_OUTPUT_PATH:
		with open(DEBUG_OUTPUT_PATH + "07_tsvdata.log", "wt") as f:
			for cols in tsv_data:
				f.write(str(cols) + "\n")
	return tsv_data

def main(argv):
	global config
	
	print("TSV Line-Break Tool")
	aparse = argparse.ArgumentParser()
	apgrp = aparse.add_mutually_exclusive_group(required=True)
	apgrp.add_argument("-r", "--remove", action="store_true", help="remove line breaks")
	apgrp.add_argument("-a", "--add", action="store_true", help="add line breaks according to text box sizes")
	aparse.add_argument("-c", "--textsize-check", type=int, help="0 = no check, 1 = check against textbox [default]", default=1)
	aparse.add_argument("-n", "--text-column", type=int, help="column to use for text to insert (1 = first column)", default=6)
	aparse.add_argument("-q", "--quote-mode", type=int, help="mode for slanted quotation marks,\n" \
			"0 = full-width,\n1/2 = half-width", default=1)
	aparse.add_argument("-p", "--hyphenation", action="store_true", help="apply hyphenation to words when breaking lines (saves screen space)")
	aparse.add_argument("in_file", help="input file (.TSV)")
	aparse.add_argument("out_file", help="output file (.TSV)")
	
	config = aparse.parse_args(argv[1:])
	config.text_column -= 1	# 1st colum has ID 0.
	
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
				lines += [line + "\n"]
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
