# simple script to restyle the dumped monster talk
import sys

with open(sys.argv[1], "rt", encoding="utf-8") as f:
	fin = f.read()

fout = ""
last_ch = ""
last_mode = 0
mode = 0
for (pos, ch) in enumerate(fin):
	if ch >= '\U0001D400' and ch <= '\U0001D433':
		ch = chr(ord(ch) - 0x1D400 + 0xFF21)
		mode = 1
	elif ch == '\uF87F':
		mode = 1
		if last_ch >= 'A' and last_ch <= 'z':
			# letter + U+F87F -> full-width letter
			ch = chr(ord(last_ch) - 0x41 + 0xFF21)
			fout = fout[:-1]
	elif ch >= 'A' and ch <= 'z':
		if fin[pos+1] != '\uF87F':
			mode = 0
	elif ch == '\n':
		mode = 0
	
	if False:	# make ancient language **bold**
		if mode == 1 and last_mode == 0:
			fout += "**"
		elif mode == 0 and last_mode == 1:
			fout += "**"
	
	last_mode = mode
	fout += ch
	last_ch = ch

with open(sys.argv[2], "wt", encoding="utf-8") as f:
	f.write(fout)