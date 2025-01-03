#!/usr/bin/env python3
import sys
import os
import typing
import argparse
import unicodedata
import yaml

DEBUG_OUTPUT_PATH = None
#DEBUG_OUTPUT_PATH = "/tmp/linebrk_"

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
				# stripping the \n ensures the correct termination for "open-ended" lines (ending with a backslash)
				textitem_list += [{"line_st": tlid_start, "line_end": tlid_end, "mode": tsv_data[tlid_start][3], "text": tstr.rstrip('\n')}]
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
		textitem_list += [{"line_st": tlid_start, "line_end": tlid_end, "mode": tsv_data[tlid_start][3], "text": tstr.rstrip('\n')}]
	
	return textitem_list

def get_last_tbox_info(tsv_data: list, line: int) -> str:
	while line >= 0:
		if "x" in tsv_data[line][4]:
			return tsv_data[line][4]
		line -= 1
	return "999x999"

def special_split(text: str, separators: list) -> list:
	# Example for separators ['*', '@']
	#	"ab*cd@e" -> ["ab", "cd", "e"]
	#	"ab@e*cd" -> ["ab", "cd", "e"]
	#	"ab*cd" -> ["ab", "cd", ""]
	#	"ab@e" -> ["ab", "", "e"]
	sepTxts = [text] + [""] * len(separators)
	for (sIdx, sep) in enumerate(separators):
		for (stIdx, sTxt) in enumerate(sepTxts):
			tparts = sTxt.partition(sep)
			if len(tparts[2]) > 0:
				sepTxts[stIdx] = tparts[0]
				sepTxts[1 + sIdx] = tparts[2]
	return sepTxts

def parse_tbox_info(tbinfo: str) -> tuple:
	tb_data = special_split(tbinfo, ['*', '@'])
	tb_size = [int(x) for x in tb_data[0].split("x")]
	if tb_data[1] != "":
		tb_init = [int(x) if x != "" else 0 for x in tb_data[1].split(",")]
	else:
		tb_init = [0, 0]
	if tb_data[2] != "":
		tb_ofs = [int(x) if x != "" else None for x in tb_data[2].split(",")]
	else:
		tb_ofs = [None, None]
	return (tb_size, tb_init, tb_ofs)

def do_textsize_check(old_linecount, tb_size, tsv_data, txitm, lines, text_size, xpos):
	global config
	
	(tb_width, tb_height) = tb_size
	if config.textsize_check == 1:
		(xsize, ysize) = text_size
		if len(lines) > 0 and xpos <= 0:
			ysize -= 1	# ignore last line when empty
		if xsize <= tb_width and ysize <= tb_height:
			return
		print(f"TSV line {1+txitm['line_st']}: New text ({xsize}x{ysize}) " \
				f"exceeds text box! (text box: {tb_width}x{tb_height})")
	#elif config.textsize_check == 2:
	#	if len(lines) == line_count:
	#		return
	#	print(f"TSV line {1+txitm['line_st']}: New text has {len(lines)} line(s) " \
	#			f"when original one had {line_count}! (text box: {tb_width}x{tb_height})")
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

TXTFLAG_SPACE		= 0x01	# character is a space
TXTFLAG_LINE_BREAK	= 0x02	# line break after this character
TXTFLAG_SPC_BREAK	= 0x04	# special line break character
TXTFLAG_NO_BREAK	= 0x08	# prevent line break at this character
TXTFLAG_LWORD_BEGIN	= 0x10	# "long word" can be a concatenated word with trailing punctiation ("abc-def.")
TXTFLAG_LWORD_END	= 0x20
TXTFLAG_CWORD_BEGIN	= 0x40	# "core word" is just a single word that consists only of alphabet letters
TXTFLAG_CWORD_END	= 0x80
TXTFLAG_INDENT_BEG	= 0x0100
TXTFLAG_INDENT_END	= 0x0200
TXTFLAG_CTRL_CODE	= 0x1000
TXTFLAG_CTRL_PARAM	= 0x2000
TXTFLAG_DUMMY		= 0x8000

def parse_text(text: str) -> list:
	global config
	global var_dict
	
	# split text data into "tokens", with annotated width/height/...
	indent_level = 0
	ptext = []
	state_space = 0x01
	state_alpha = 0x00
	param_bytes = 0
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
		chrlines = 0
		flags = 0x00
		state_space = (state_space << 1) & 0x33
		state_alpha = (state_alpha << 1) & 0x03
		if text_var is not None:
			if ("newlines" in text_var) and (text_var["newlines"] > 0):
				# move base Y offset to make up for lines written by the variable
				chrlines = text_var["newlines"]
				flags |= TXTFLAG_LINE_BREAK
				state_space |= 0x20	# enforce LWORD_END
			if ("length" not in text_var) and ("value" in text_var):
				text_var["length"] = get_cjk_string_width(text_var["value"])
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
				elif ccode == 0x01:
					ctrl_chr = 'e'	# paragraph end
				elif ccode == 0x02:
					ctrl_chr = 'w'	# wait
				elif ccode == 0x03:
					ctrl_chr = 'c'	# set colour
				elif ccode == 0x09:
					ctrl_chr = 't'	# tab
				elif ccode == 0x0A:
					ctrl_chr = 'n'	# new line
				elif ccode == 0x0B:
					ctrl_chr = 'c'	# set portrait
				elif ccode == 0x0D:
					ctrl_chr = 'r'	# carriage return
				chrlen += 2
			
			if param_bytes > 0:
				chrwidth = 0
				flags |= TXTFLAG_CTRL_PARAM
				param_bytes -= 1
			elif ctrl_chr == 'j':
				chrwidth = 2	# assume full-width emoji / custom PC-98 font character
				chrlen += 4
			elif ctrl_chr == 'u':
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
			elif ctrl_chr == 'x04':
				chrwidth = 8-2	# assume up to 8 chars for names
				flags |= TXTFLAG_CTRL_CODE
				param_bytes = 1
			elif ctrl_chr == 'x05':
				chrwidth = 6	# assume up to 6 chars for numbers (5 digits + sign)
				flags |= TXTFLAG_CTRL_CODE
				param_bytes = 2
			elif ctrl_chr == 't':	# tab
				chrwidth = 8
				flags |= TXTFLAG_CTRL_CODE
				state_space |= 0x01
			elif ctrl_chr == 'r':	# new line
				chrwidth = 0
				chrlines = 1
				flags |= (TXTFLAG_LINE_BREAK | TXTFLAG_CTRL_CODE)
				state_space |= 0x20	# enforce LWORD_END
			elif ctrl_chr == 'n':	# scroll 1 line up
				chrwidth = 0
				chrlines = 0	# "0 lines", because we don't take additional space in the text box due to scrolling
				flags |= (TXTFLAG_LINE_BREAK | TXTFLAG_CTRL_CODE)
				state_space |= 0x20	# enforce LWORD_END
			elif ctrl_chr == '\n':	# new TSV line
				chrwidth = 0
				flags |= TXTFLAG_DUMMY
				state_space |= 0x20	# enforce LWORD_END
			elif ctrl_chr == 'e':	# paragraph end (wait + clear textbox)
				chrwidth = 0
				chrlines = -1
				flags |= (TXTFLAG_LINE_BREAK | TXTFLAG_CTRL_CODE)
				state_space |= 0x20	# enforce LWORD_END
			elif ctrl_chr in ['c', 'p', 'x03', 'x06', 'x08', 'x0B', 'x0C', 'x0E']:
				flags |= TXTFLAG_CTRL_CODE
				param_bytes = 1
			elif ctrl_chr == 'x0F':
				# possible improvement: handle System-98 meta commands properly
				flags |= TXTFLAG_CTRL_CODE
				param_bytes = 2
		elif ord(text[pos]) >= 0x20:
			if param_bytes > 0:
				chrwidth = 0
				flags |= TXTFLAG_CTRL_PARAM
				param_bytes -= 1
			else:
				ccstr = text[pos]
				if (pos + 1 < len(text)) and (text[pos + 1] == '\uF87F'):
					ccstr += text[pos + 1]
					chrlen += 1
					chrwidth = 1
				#elif ccstr in "\u201C\u201D\u2018\u2019":
				#	if config.quote_mode == 0:
				#		chrwidth = 2	# in mode 0, they will be full-width
				#	else:
				#		chrwidth = 1	# the "reinsert" script will convert those to half-width ASCII
				#elif ccstr == "\u2026":
				#	chrwidth = 3	# the "reinsert" script will convert this to "..."
				else:
					chrwidth = get_cjk_char_width(ccstr)
				
				state_space |= 0x01 if ccstr[0].isspace() else 0x10
				if ccstr[0].isalpha():
					state_alpha |= 0x01
				if ccstr[0] in ['(', '（']:
					flags |= TXTFLAG_INDENT_BEG
					indent_level += 1
				elif ccstr[0] in [')', '）']:
					if indent_level > 0:
						indent_level -= 1
						flags |= TXTFLAG_INDENT_END
		
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
			"lines": chrlines,
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

def textitem2tsv(txitm: dict, tsv_data: list, keep_lines: bool) -> None:
	global config
	
	# count effective text lines
	lids_used = []
	for tsv_lid in range(txitm["line_st"], txitm["line_end"] + 1):
		if type(tsv_data[tsv_lid]) is str:
			continue	# don't count comment lines
		lids_used.append(tsv_lid)
	line_count = len(lids_used)
	
	tbox_infostr = get_last_tbox_info(tsv_data, txitm["line_st"])
	(tb_size, tb_init, tb_ofs) = parse_tbox_info(tbox_infostr)
	(tb_width, tb_height) = tb_size
	
	multiline_text = False
	if txitm["mode"] != "sel":	# allow "txt" and "UNREF"
		if tb_height > 1:
			multiline_text = True	# line breaks may be added to longer text paragraphs
	if keep_lines:
		multiline_text = False	# The option enforces to keep the original line breaks.
	
	ptext = parse_text(txitm["text"])
	
	# split text data into multiple lines for the TSV
	indent_xbase = [0]
	line_xbase = indent_xbase[0]
	tbox_ybase = 0
	xpos = 0
	max_xpos = xpos
	lines = [""]
	# We are trying to insert automatic line breaks intelligently, based on the text box width and word spacing.
	param_bytes = 0
	for (ptid, ptinfo) in enumerate(ptext):
		chrwidth = ptinfo["width"]
		flags = ptinfo["flags"]

		can_add_linebreaks = multiline_text and not (flags & TXTFLAG_NO_BREAK)

		if param_bytes > 0:
			param_bytes -= 1
		elif ptinfo["data"].startswith('\\'):
			reinsert_init = False
			if can_add_linebreaks and (ptinfo["data"] == "\\r") and (len(lines) - tbox_ybase >= tb_height):
				if config.extend_mode == 1:
					ptinfo["data"] = "\\e"	# change \r to \e
					reinsert_init = True
				elif config.extend_mode == 2:
					ptinfo["data"] = '\\n'	# change \r to \n
					ptinfo["lines"] = 0	# "0 lines", because we don't take additional space in the text box due to scrolling

			ctrl_chr = ptinfo["data"][1:]
			if ctrl_chr in ['c', 'p', 'x03', 'x04', 'x06', 'x08', 'x0B', 'x0C', 'x0E']:
				param_bytes = 1
			elif ctrl_chr == 'x05':
				param_bytes = 2
			elif ctrl_chr == 'x0F':
				# possible improvement: handle System-98 meta commands properly
				param_bytes = 2
			elif ctrl_chr == '\n':	# new TSV line
				ptinfo["linepos"] = (len(lines) - 1, len(lines[-1]), xpos)	# make token search below work properly
				continue
			elif ctrl_chr == 'e':	# paragraph end (wait + clear textbox)
				ptinfo["linepos"] = (len(lines) - 1, len(lines[-1]), xpos)
				lines[-1] += ptinfo["data"]
				if not keep_lines:
					do_textsize_check(line_count, tb_size, tsv_data, txitm, lines, (max_xpos, len(lines) - tbox_ybase), xpos)
				lines[-1] += "\\"
				lines.append("")	# start new line
				#lines[-1] += f"<{len(lines) - tbox_ybase}/{tb_height}>"
				
				# reset all coordinate data
				tbox_ybase = len(lines) - 1	# index of current line
				if reinsert_init and tb_init[1] > 0:
					lines[-1] += ("\\r" * tb_init[1])	# insert new-line commands to re-reach the respective initalization Y offset
				else:
					tbox_ybase += tb_init[1]	# add "initial offset", because we omit that from other calculations
				xpos = 0
				max_xpos = xpos
				continue
		#print(f"CPos {ptinfo['pos']}, XPos {xpos}, Lines {len(lines)}, NextChr: '{ptinfo['data']}' (width {chrwidth}), LastLine: {lines[-1]}")

		if (flags & TXTFLAG_LINE_BREAK):
			ptinfo["linepos"] = (len(lines) - 1, len(lines[-1]), xpos)
			lines[-1] += ptinfo["data"]
			xpos += chrwidth
			max_xpos = max([xpos, max_xpos])

			if xpos == 0 and tbox_ybase >= len(lines):
				tbox_ybase -= ptinfo["lines"]
			else:
				lines[-1] += "\\"
				lines.append("")	# start new line
				# new line: "lines" == 1 -> ybase += 0
				# scroll:   "lines" == 0 -> ybase += 1
				tbox_ybase -= (ptinfo["lines"] - 1)
			lines[-1] += (' ' * line_xbase)
			xpos = line_xbase
			continue
		
		if False and (len(lines) - tbox_ybase == tb_height):
			# on the last line of the text box, reserve 2 "characters" for the
			# icon that tells the user to press a key
			tb_line_width = tb_width - 2
		else:
			tb_line_width = tb_width
		if can_add_linebreaks and (xpos + chrwidth > tb_line_width):
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

			if break_mode is None:
				# fallback when no hyphenation was used
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

			# add line breaks only in "txt" mode
			#print(f"    split ({xpos + chrwidth} > {tb_line_width}), word chr-pos {lw_lpos}, word X-pos {lw_xpos}, maxlen {tb_width*0.75-4}")
			newline_code = "\\r"	# default: continue on next line
			if len(lines) - tbox_ybase >= tb_height:
				if config.extend_mode == 1:
					# clear text box
					newline_code = "\\e"
					if tb_init[1] > 0:
						# handle "initial offset"
						newline_code += ("\\r" * tb_init[1])	# insert new-lines to re-reach the respective initalization Y offset
					# reset all coordinate data
					tbox_ybase = len(lines) + 1
					max_xpos = 0
				elif config.extend_mode == 2:
					# scroll text box by 1 line
					newline_code = "\\n"
					# move base Y offset to make up for scrolling
					tbox_ybase += 1
			#newline_code = newline_code + f"<?{len(lines) - tbox_ybase}/{tb_height}>"
			if break_mode == 0:
				# (a) there were no spaces OR
				# (b) the only spaces were indentation OR
				# (c) the last word is very long (more than 30% of the line)
				#     (approximating "30%" with "25% + 4 characters" here for better behaviour with short text boxes)
				# -> just break in the middle of the word
				#print(f"Line break after: {str(lines)}")
				lines[-1] += newline_code + "\\"
				lines.append("")	# start new line
				#lines[-1] += f"<{len(lines) - tbox_ybase}/{tb_height}>"
				lines[-1] += (' ' * line_xbase)
				xpos = line_xbase
			elif break_mode == 1:
				# insert a line break at the beginning of the last word (and strip spaces)
				#print(f"Word-Line break after: {str(lines)}, XPos {xpos} -> {xpos - lw_xpos}")
				#print(f"Line-Beginning: Word Pos {lw_lpos}, Word XPos {lw_xpos}, \"{lines[-1][:lw_lpos]}\"")
				rem_line = lines[-1][lw_lpos:]
				#rem_line = f"<{len(lines) - tbox_ybase + 1}/{tb_height}>" + rem_line
				lines[-1] = lines[-1][:lw_lpos] + newline_code + "\\"
				lines.append((' ' * line_xbase) + rem_line)
				ptext[lwBegIdx]["flags"] |= TXTFLAG_LWORD_BEGIN
				for ptMoveId in range(lwBegIdx, ptid):
					ptlp = ptext[ptMoveId]["linepos"]
					ptext[ptMoveId]["linepos"] = (len(lines) - 1, ptlp[1] - lw_lpos, ptlp[2] - lw_xpos + line_xbase)
				xpos = xpos - lw_xpos + line_xbase
				max_xpos = max([xpos, max_xpos])
		
		ptinfo["linepos"] = (len(lines) - 1, len(lines[-1]), xpos)	# (line index/Y position, character index, screen X position)
		lines[-1] += ptinfo["data"]
		xpos += chrwidth
		if not (flags & TXTFLAG_SPACE):
			max_xpos = max([xpos, max_xpos])
		if config.indenting and multiline_text:
			if flags & TXTFLAG_INDENT_BEG:
				indent_xbase.append(xpos)	# save indent of "after left parenthesis"
				line_xbase = indent_xbase[-1]
			elif flags & TXTFLAG_INDENT_END:
				if len(indent_xbase) > 0:
					indent_xbase.pop()
					line_xbase = indent_xbase[-1]
	if not keep_lines:
		do_textsize_check(line_count, tb_size, tsv_data, txitm, lines, (max_xpos, len(lines) - tbox_ybase), xpos)
	
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
	for (txt_lid, tsv_lid) in enumerate(lids_used):
		tsv_data[tsv_lid][5] = lines[txt_lid]
	return

def remove_break_from_line(text: str, SENTENCE_END_CHRS: set, state: dict) -> str:
	is_newline = False
	indent_level = state["indent_level"] if ("indent_level" in state) else 0
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
				cur_chr = '\x00'
				chrlen += 4
			elif ctrl_chr == 'u':
				ccode = int(text[pos+chrlen : pos+chrlen+4], 0x10)
				cur_chr = chr(ccode)
				chrlen += 4
			elif ctrl_chr == 'U':
				ccode = int(text[pos+chrlen : pos+chrlen+8], 0x10)
				cur_chr = chr(ccode)
				chrlen += 8
			elif ctrl_chr in ['r', 'n']:	# new line / scroll line
				is_newline = True
			elif ctrl_chr == 'e':	# "paragraph end" control code
				keep_next_nl = True
				indent_level = 0
			elif ctrl_chr == '\n':	# new TSV line
				pass
		elif ord(text[pos]) >= 0x0020:
			keep_next_nl = False	# when the actual text starts, start removing line breaks
			if text[pos] in ['(', '（']:
				indent_level += 1
			elif text[pos] in [')', '）']:
				if indent_level > 0:
					indent_level -= 1
		
		if is_newline:
			is_newline = False
			next_pos = pos + chrlen
			if text[next_pos : next_pos+2] == '\\\n':
				next_pos += 2	# skip line end marker
			#print(f"Next: {text[next_pos : next_pos+2]}")
			keep_nl = False
			if keep_next_nl:
				keep_nl = True	# keep at the beginning of the text
			# This heavily breaks indented text.
			#elif (len(text) <= next_pos) or text[next_pos].isspace():
			#	keep_nl = True	# keep when being followed by a space
			elif (len(last_non_spc) == 1) and last_non_spc in SENTENCE_END_CHRS:
				keep_nl = True	# keep when the last character is a "sentence/paragraph end" character
			elif (len(last_non_spc) == 1) and (ord(last_non_spc) in range(0x1F000, 0x20000)):
				keep_nl = True	# keep when the last character is a symbol or emoji character
			elif last_non_spc in ["\\e", "\\w"]:
				keep_nl = True	# keep when the last character is a "wait" command

			if not keep_nl:
				# fuse lines
				text = text[:pos] + text[next_pos:]
			else:
				pos = next_pos
			chrlen = 0
			if indent_level > 0 and config.indenting:
				next_pos = pos
				# strip leading spaces, removing indentation
				while (next_pos < len(text)) and text[next_pos].isspace():
					next_pos += 1
				if next_pos > pos:
					# remove indent
					text = text[:pos] + text[next_pos:]
		last_chr = cur_chr
		if not cur_chr.isspace():
			last_non_spc = last_chr
		pos += chrlen
	
	state["indent_level"] = indent_level
	return text

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
	SENTENCE_END_CHRS = ".?!\"»’‛”‟›‼⁈❢。？！〉》」』・"
	SENTENCE_END_CHRS += "".join([chr(x) for x in range(0x2500, 0x2800)])	# add various symbols
	SENTENCE_END_CHRS += "".join([chr(x) for x in range(0x2900, 0x2C00)])	# add more arrows
	SENTENCE_END_CHRS = set(SENTENCE_END_CHRS)	# convert to set for faster lookup
	state = dict()
	for txitm in textitem_list:
		if txitm["mode"] == "txt":
			txitm["text"] = remove_break_from_line(txitm["text"], SENTENCE_END_CHRS, state)
		else:
			state.clear()
	if DEBUG_OUTPUT_PATH:
		with open(DEBUG_OUTPUT_PATH + "02_textitems_clean.log", "wt") as f:
			for txitm in textitem_list:
				f.write(str(txitm) + "\n")
	
	# Finally, reconstruct the TSV file.
	tsv_newdata = tsv_data.copy()
	for txitm in textitem_list:
		textitem2tsv(txitm, tsv_newdata, True)
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
	tsv_newdata = tsv_data.copy()
	for txitm in textitem_list:
		textitem2tsv(txitm, tsv_newdata, False)
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
	aparse.add_argument("-I", "--indenting", action="store_true", help="remove/insert indents after left parenthesis (remove is very recommended)")
	aparse.add_argument("-c", "--textsize-check", type=int, help="0 = no check, 1 = check against textbox [default]", default=1)
	aparse.add_argument("-x", "--extend-mode", type=int, help="how to extend small text boxes. 0 = none, 1 = clear, 2 = scroll", default=0)
	aparse.add_argument("-v", "--variables", type=str, help="YAML file that contains variables to be replaced with words during line length calculation")
	aparse.add_argument("in_file", help="input file (.TSV)")
	aparse.add_argument("out_file", help="output file (.TSV)")
	
	config = aparse.parse_args(argv[1:])
	
	if config.variables and config.add:
		global var_dict
		with open(config.variables, "rb") as f:
			var_dict = yaml.safe_load(f)
	
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
