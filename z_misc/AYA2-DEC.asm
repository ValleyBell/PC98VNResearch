; Input	MD5   :	294646FAF4B19861CEE7518AC84B15B3
; Input	CRC32 :	3C38D1E3

; File Name   :	D:\AYA2.DEC.EXE
; Format      :	MS-DOS executable (EXE)
; Base Address:	1000h Range: 10000h-13311h Loaded length: 3310h
; Entry	Point :	1000:1E19

		.686p
		.mmx
		.model large

; ===========================================================================

; Segment type:	Pure code
seg000		segment	byte public 'CODE' use16
		assume cs:seg000
		assume es:nothing, ss:nothing, ds:nothing, fs:nothing, gs:nothing

; =============== S U B	R O U T	I N E =======================================


sub_10000	proc near		; CODE XREF: sub_101F6+52p
		mov	bx, 40h	; '@'

loc_10003:
		mov	es, bx
		assume es:nothing
		mov	bx, offset word_1205C
		mov	al, es:[bx]
		and	al, 4
		cmp	al, 4
		jz	short loc_10020
		mov	ax, 0Ch
		push	ds
		push	ax
		call	sub_11EA5
		add	sp, 4
		mov	ax, 0FFFFh
		retn
; ---------------------------------------------------------------------------

loc_10020:				; CODE XREF: sub_10000+Fj
		sub	ax, ax
		retn
sub_10000	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

LoadSoundDriver	proc near		; CODE XREF: sub_101F6+4Cp

var_2		= word ptr -2

		push	bp
		mov	bp, sp
		sub	sp, 2
		mov	ax, offset aM6N0 ; " -M6 -N0"
		push	ds
		push	ax
		mov	ax, offset aFmd_exe ; "FMD.EXE"
		push	ds
		push	ax
		call	sub_11EBA
		add	sp, 8
		mov	[bp+var_2], ax
		or	ax, ax
		jz	short loc_10048

loc_10041:				; CODE XREF: LoadSoundDriver+46j
		sub	ax, ax
		mov	sp, bp
		pop	bp
		retn
; ---------------------------------------------------------------------------
		align 2

loc_10048:				; CODE XREF: LoadSoundDriver+1Bj
		call	sub_11F16
		mov	[bp+var_2], ax
		cmp	byte ptr [bp+var_2], 0
		jnz	short loc_1005C

loc_10054:				; CODE XREF: LoadSoundDriver+3Cj
					; LoadSoundDriver+48j
		mov	ax, 0FFFFh
		mov	sp, bp
		pop	bp
		retn
; ---------------------------------------------------------------------------
		align 2

loc_1005C:				; CODE XREF: LoadSoundDriver+2Ej
		cmp	[bp+var_2], 4
		jz	short loc_10054
		mov	ax, [bp+var_2]
		sub	al, al
		cmp	ax, 300h
		jnz	short loc_10041
		jmp	short loc_10054
LoadSoundDriver	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1006E	proc near		; CODE XREF: LoadFile+51p
					; sub_10480+42p ...

var_A		= word ptr -0Ah
var_8		= dword	ptr -8
var_4		= dword	ptr -4
arg_0		= word ptr  4
arg_2		= word ptr  6
arg_4		= word ptr  8
arg_6		= word ptr  0Ah
arg_8		= word ptr  0Ch
arg_A		= word ptr  0Eh
arg_C		= word ptr  10h
arg_E		= word ptr  12h

		push	bp
		mov	bp, sp
		sub	sp, 0Ah
		push	di
		push	si
		mov	ax, [bp+arg_0]
		mov	dx, [bp+arg_2]
		mov	word ptr [bp+var_8], ax
		mov	word ptr [bp+var_8+2], dx
		mov	ax, [bp+arg_4]
		mov	dx, [bp+arg_6]
		mov	word ptr [bp+var_4], ax
		mov	word ptr [bp+var_4+2], dx
		les	di, [bp+var_4]
		assume es:nothing
		mov	[bp+var_A], ds
		lds	si, [bp+var_8]
		jmp	short loc_100A1
; ---------------------------------------------------------------------------
		align 2

loc_1009A:				; CODE XREF: sub_1006E+37j
		mov	al, es:[di]
		mov	[si], al
		inc	di
		inc	si

loc_100A1:				; CODE XREF: sub_1006E+29j
		cmp	byte ptr es:[di], 0
		jnz	short loc_1009A
		mov	word ptr [bp+var_8], si
		mov	word ptr [bp+var_8+2], ds
		mov	ds, [bp+var_A]
		mov	word ptr [bp+var_4], di
		mov	word ptr [bp+var_4+2], es
		mov	ax, [bp+arg_8]
		mov	dx, [bp+arg_A]
		mov	word ptr [bp+var_4], ax
		mov	word ptr [bp+var_4+2], dx
		les	di, [bp+var_4]
		mov	ds, word ptr [bp+var_8+2]
		jmp	short loc_100D7
; ---------------------------------------------------------------------------

loc_100CA:				; CODE XREF: sub_1006E+6Dj
		cmp	byte ptr es:[di], 0
		jz	short loc_100DD
		mov	al, es:[di]
		mov	[si], al
		inc	di
		inc	si

loc_100D7:				; CODE XREF: sub_1006E+5Aj
		cmp	byte ptr es:[di], '.'
		jnz	short loc_100CA

loc_100DD:				; CODE XREF: sub_1006E+60j
		mov	word ptr [bp+var_8], si
		mov	word ptr [bp+var_8+2], ds
		mov	ds, [bp+var_A]
		mov	word ptr [bp+var_4], di
		mov	word ptr [bp+var_4+2], es
		les	bx, [bp+var_8]
		inc	word ptr [bp+var_8]
		mov	byte ptr es:[bx], '.'
		mov	ax, [bp+arg_C]
		mov	dx, [bp+arg_E]
		mov	word ptr [bp+var_4], ax
		mov	word ptr [bp+var_4+2], dx
		les	di, [bp+var_4]
		lds	si, [bp+var_8]
		jmp	short loc_10111
; ---------------------------------------------------------------------------

loc_1010A:				; CODE XREF: sub_1006E+A7j
		mov	al, es:[di]
		mov	[si], al
		inc	di
		inc	si

loc_10111:				; CODE XREF: sub_1006E+9Aj
		cmp	byte ptr es:[di], 0
		jnz	short loc_1010A
		mov	word ptr [bp+var_8], si
		mov	word ptr [bp+var_8+2], ds
		mov	ds, [bp+var_A]
		mov	word ptr [bp+var_4], di
		mov	word ptr [bp+var_4+2], es
		les	bx, [bp+var_8]
		mov	byte ptr es:[bx], 0
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retn
sub_1006E	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

LoadFile	proc near		; CODE XREF: sub_101F6+A5p
					; sub_101F6+ECp ...

var_C		= word ptr -0Ch
var_A		= word ptr -0Ah
var_8		= word ptr -8
var_6		= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  4
arg_2		= word ptr  6
arg_4		= word ptr  8
arg_6		= word ptr  0Ah
arg_8		= word ptr  0Ch
arg_A		= word ptr  0Eh

		push	bp
		mov	bp, sp
		sub	sp, 0Ch
		mov	ax, [bp+arg_4]
		cmp	ax, 1
		jz	short loc_10160
		cmp	ax, 2
		jz	short loc_101A6
		cmp	ax, 3
		jz	short loc_101B4
		cmp	ax, 4
		jz	short loc_101C2
		mov	ax, offset asc_1206D ; "\\"
		mov	[bp+var_A], ax
		mov	[bp+var_8], ds
		mov	ax, offset unk_1206F
		jmp	short loc_1016C
; ---------------------------------------------------------------------------
		align 2

loc_10160:				; CODE XREF: LoadFile+Cj
		mov	ax, offset aData ; "\\data\\"
		mov	[bp+var_A], ax
		mov	[bp+var_8], ds
		mov	ax, offset aDat	; "DAT"

loc_1016C:				; CODE XREF: LoadFile+29j LoadFile+7Ej ...
		mov	[bp+var_4], ax
		mov	[bp+var_2], ds
		push	ds
		push	ax
		push	[bp+arg_2]
		push	[bp+arg_0]
		push	[bp+var_8]
		push	[bp+var_A]
		mov	ax, offset byte_121B8
		push	ds
		push	ax
		call	sub_1006E
		add	sp, 10h
		sub	ax, ax
		push	ax
		mov	ax, offset byte_121B8
		push	ds
		push	ax
		call	sub_11E55
		add	sp, 6
		mov	[bp+var_C], ax
		or	ax, ax
		jge	short loc_101D0
		sub	ax, ax
		mov	sp, bp
		pop	bp
		retn
; ---------------------------------------------------------------------------

loc_101A6:				; CODE XREF: LoadFile+11j
		mov	ax, offset aMusic ; "\\music\\"
		mov	[bp+var_A], ax
		mov	[bp+var_8], ds
		mov	ax, offset aEmi	; "EMI"
		jmp	short loc_1016C
; ---------------------------------------------------------------------------

loc_101B4:				; CODE XREF: LoadFile+16j
		mov	ax, offset aGraph ; "\\graph\\"
		mov	[bp+var_A], ax
		mov	[bp+var_8], ds
		mov	ax, offset aVdt	; "VDT"
		jmp	short loc_1016C
; ---------------------------------------------------------------------------

loc_101C2:				; CODE XREF: LoadFile+1Bj
		mov	ax, offset aGraph ; "\\graph\\"
		mov	[bp+var_A], ax
		mov	[bp+var_8], ds
		mov	ax, offset aAnm	; "ANM"
		jmp	short loc_1016C
; ---------------------------------------------------------------------------

loc_101D0:				; CODE XREF: LoadFile+6Aj
		push	[bp+var_C]
		push	[bp+arg_A]
		push	[bp+arg_8]
		push	[bp+arg_6]
		call	sub_11E7B
		add	sp, 8
		mov	[bp+var_6], ax
		push	[bp+var_C]
		call	sub_11E93
		add	sp, 2
		mov	ax, [bp+var_6]
		mov	sp, bp
		pop	bp
		retn
LoadFile	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_101F6	proc near		; CODE XREF: sub_10BB2+8p

var_12		= word ptr -12h
var_C		= word ptr -0Ch
var_A		= word ptr -0Ah
var_8		= word ptr -8
var_6		= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2

		push	bp
		mov	bp, sp
		sub	sp, 12h
		push	di
		push	si
		call	sub_10FA3
		call	sub_10F8F
		call	sub_10F99
		mov	ax, offset a5h	; "\x1B[>5h"
		push	ds
		push	ax
		call	sub_11EA5
		add	sp, 4
		mov	ax, offset a1h_0 ; "\x1B[>1h"
		push	ds
		push	ax
		call	sub_11EA5
		add	sp, 4
		mov	ax, offset a2j	; "\x1B[2J"
		push	ds
		push	ax
		call	sub_11EA5
		add	sp, 4
		mov	ax, offset aVVVVsvpVavtvcv ; "‚Í‚Á‚¿‚á‚¯ ‚ ‚â‚æ‚³‚"
		push	ds
		push	ax
		call	sub_11EA5
		add	sp, 4
		mov	bx, 40h	; '@'
		mov	es, bx
		assume es:nothing
		mov	bx, 100h
		or	byte ptr es:[bx], 20h
		call	sub_10F94
		call	LoadSoundDriver
		mov	ds:word_122CA, ax
		call	sub_10000
		inc	ax
		jnz	short loc_10258

loc_1024E:				; CODE XREF: sub_101F6+81j
					; sub_101F6+8Ej ...
		mov	ax, 0FFFFh
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retn
; ---------------------------------------------------------------------------
		align 2

loc_10258:				; CODE XREF: sub_101F6+56j
		mov	ax, 2B12h
		push	ax
		call	sub_11E6A
		add	sp, 2
		mov	[bp+var_6], ax
		mov	[bp+var_4], dx
		or	dx, dx
		jge	short loc_1027A
		mov	ax, 7Ah	; 'z'
		push	ds
		push	ax
		call	sub_11EA5
		add	sp, 4
		jmp	short loc_1024E
; ---------------------------------------------------------------------------
		align 2

loc_1027A:				; CODE XREF: sub_101F6+74j
		mov	ax, [bp+var_6]
		mov	ds:0FEh, ax
		call	sub_1157A
		inc	ax
		jz	short loc_1024E
		mov	ax, 0FFFFh
		push	ax
		push	word ptr ds:0FEh
		push	word ptr ds:0FCh
		mov	ax, 1
		push	ax
		mov	ax, offset aAya2mes ; "AYA2MES"
		push	ds
		push	ax
		call	LoadFile
		add	sp, 0Ch
		mov	[bp+var_2], ax
		or	ax, ax
		jz	short loc_1024E
		mov	cl, 4
		sar	ax, cl
		add	ax, ds:0FEh
		inc	ax
		mov	ds:102h, ax
		add	ax, 2F1h
		mov	ds:106h, ax
		add	ax, 0B41h
		mov	ds:112h, ax
		mov	[bp+var_C], 1
		mov	si, 110h
		mov	di, 116h
		mov	[bp+var_12], 112h

loc_102D0:				; CODE XREF: sub_101F6+11Dj
		mov	ax, 0FFFFh
		push	ax
		push	word ptr [si+2]
		push	word ptr [si]
		mov	ax, 3
		push	ax
		mov	ax, offset aFace0 ; "face0"
		push	ds
		push	ax
		call	LoadFile
		add	sp, 0Ch
		mov	[bp+var_2], ax
		or	ax, ax
		jnz	short loc_102F2
		jmp	loc_1024E
; ---------------------------------------------------------------------------

loc_102F2:				; CODE XREF: sub_101F6+F7j
		inc	byte ptr ds:1C6h
		mov	cl, 4
		sar	ax, cl
		mov	bx, [bp+var_12]
		add	ax, [bx]
		inc	ax
		mov	[di], ax
		add	si, 4
		add	di, 4
		add	[bp+var_12], 4
		inc	[bp+var_C]
		cmp	[bp+var_C], 0Ah
		jl	short loc_102D0
		mov	ax, 0FFFFh
		push	ax
		push	word ptr ds:136h
		push	word ptr ds:134h
		mov	ax, 3
		push	ax
		mov	ax, offset aFace0 ; "face0"
		push	ds
		push	ax
		call	LoadFile
		add	sp, 0Ch
		mov	[bp+var_2], ax
		or	ax, ax
		jnz	short loc_1033A
		jmp	loc_1024E
; ---------------------------------------------------------------------------

loc_1033A:				; CODE XREF: sub_101F6+13Fj
		mov	cl, 4
		sar	ax, cl
		add	ax, ds:136h
		inc	ax
		mov	ds:13Ah, ax
		mov	byte ptr ds:1C6h, 41h ;	'A'
		mov	ax, 0FFFFh
		push	ax
		push	word ptr ds:13Ah
		push	word ptr ds:138h
		mov	ax, 3
		push	ax
		mov	ax, offset aFace0 ; "face0"
		push	ds
		push	ax
		call	LoadFile
		add	sp, 0Ch
		mov	[bp+var_2], ax
		or	ax, ax
		jnz	short loc_10370
		jmp	loc_1024E
; ---------------------------------------------------------------------------

loc_10370:				; CODE XREF: sub_101F6+175j
		mov	cl, 4
		sar	ax, cl
		add	ax, ds:13Ah
		inc	ax
		mov	ds:13Eh, ax
		mov	byte ptr ds:1C6h, 42h ;	'B'
		mov	ax, 0FFFFh
		push	ax
		push	word ptr ds:13Eh
		push	word ptr ds:13Ch
		mov	ax, 3
		push	ax
		mov	ax, offset aFace0 ; "face0"
		push	ds
		push	ax
		call	LoadFile
		add	sp, 0Ch
		mov	[bp+var_2], ax
		or	ax, ax
		jnz	short loc_103A6
		jmp	loc_1024E
; ---------------------------------------------------------------------------

loc_103A6:				; CODE XREF: sub_101F6+1ABj
		mov	cl, 4
		sar	ax, cl
		add	ax, ds:13Eh
		inc	ax
		mov	ds:10Ah, ax
		mov	byte ptr ds:1C6h, 31h ;	'1'
		mov	ax, 0B00h
		push	ax
		push	word ptr ds:10Ah
		push	word ptr ds:108h
		mov	ax, 4
		push	ax
		mov	ax, offset aFace0 ; "face0"
		push	ds
		push	ax
		call	LoadFile
		add	sp, 0Ch
		or	ax, ax
		jnz	short loc_103D9
		jmp	loc_1024E
; ---------------------------------------------------------------------------

loc_103D9:				; CODE XREF: sub_101F6+1DEj
		mov	ax, ds:10Ah
		add	ax, 0B1h ; '±'
		mov	ds:10Eh, ax
		mov	byte ptr ds:1C6h, 32h ;	'2'
		mov	ax, 900h
		push	ax
		push	word ptr ds:10Eh
		push	word ptr ds:10Ch
		mov	ax, 4
		push	ax
		mov	ax, offset aFace0 ; "face0"
		push	ds
		push	ax
		call	LoadFile
		add	sp, 0Ch
		or	ax, ax
		jnz	short loc_10409
		jmp	loc_1024E
; ---------------------------------------------------------------------------

loc_10409:				; CODE XREF: sub_101F6+20Ej
		mov	ax, ds:word_1201E
		add	ax, 91h
		mov	ds:word_12052, ax
		mov	ax, 0FFFFh
		push	ax
		push	word ptr ds:106h
		push	word ptr ds:104h
		mov	ax, 1
		push	ax
		mov	ax, offset aCg	; "cg"
		push	ds
		push	ax
		call	LoadFile
		add	sp, 0Ch
		mov	[bp+var_2], ax
		or	ax, ax
		jnz	short loc_10437
		jmp	loc_1024E
; ---------------------------------------------------------------------------

loc_10437:				; CODE XREF: sub_101F6+23Cj
		mov	[bp+var_C], 7621h
		mov	ax, ds:104h
		mov	dx, ds:106h
		mov	[bp+var_A], ax
		mov	[bp+var_8], dx
		mov	cl, 5
		sar	[bp+var_2], cl
		cmp	[bp+var_2], 0
		jle	short loc_10477
		mov	di, [bp+var_C]
		mov	si, [bp+var_2]

loc_1045A:				; CODE XREF: sub_101F6+279j
		push	[bp+var_8]
		push	[bp+var_A]
		mov	ax, di
		inc	di
		push	ax
		call	sub_1152A
		add	sp, 6
		add	[bp+var_A], 20h	; ' '
		dec	si
		jnz	short loc_1045A
		mov	[bp+var_C], di
		mov	[bp+var_2], si

loc_10477:				; CODE XREF: sub_101F6+25Cj
		sub	ax, ax
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retn
sub_101F6	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_10480	proc near		; CODE XREF: sub_10BB2+7Bp

arg_0		= byte ptr  4

		push	bp
		mov	bp, sp
		cmp	word ptr ds:3BAh, 0FFFFh
		jnz	short loc_104FD
		mov	al, ds:1DCh
		cmp	[bp+arg_0], al
		jz	short loc_104FD
		mov	al, [bp+arg_0]
		sub	ah, ah
		cmp	ax, '1'
		jz	short loc_104AE
		cmp	ax, '2'
		jz	short loc_104D6
		cmp	ax, '3'
		jz	short loc_104E0
		cmp	ax, '4'
		jz	short loc_104EA
		jmp	short loc_104F4
; ---------------------------------------------------------------------------
		align 2

loc_104AE:				; CODE XREF: sub_10480+1Aj
		mov	ax, offset aEmi	; "EMI"
		push	ds
		push	ax
		mov	ax, offset aAya1 ; "AYA1"

loc_104B6:				; CODE XREF: sub_10480+5Ej
					; sub_10480+68j ...
		push	ds
		push	ax
		mov	ax, offset aMusic ; "\\music\\"
		push	ds
		push	ax
		mov	ax, offset byte_121B8
		push	ds
		push	ax
		call	sub_1006E
		add	sp, 10h
		mov	ax, offset byte_121B8
		push	ds
		push	ax
		call	sub_10FAA
		add	sp, 4
		jmp	short loc_104F7
; ---------------------------------------------------------------------------
		align 2

loc_104D6:				; CODE XREF: sub_10480+1Fj
		mov	ax, offset aEmi	; "EMI"
		push	ds
		push	ax
		mov	ax, offset aAya2 ; "AYA2"
		jmp	short loc_104B6
; ---------------------------------------------------------------------------

loc_104E0:				; CODE XREF: sub_10480+24j
		mov	ax, offset aEmi	; "EMI"
		push	ds
		push	ax
		mov	ax, offset aAya3 ; "AYA3"
		jmp	short loc_104B6
; ---------------------------------------------------------------------------

loc_104EA:				; CODE XREF: sub_10480+29j
		mov	ax, offset aEmi	; "EMI"
		push	ds
		push	ax
		mov	ax, offset aAya4 ; "AYA4"
		jmp	short loc_104B6
; ---------------------------------------------------------------------------

loc_104F4:				; CODE XREF: sub_10480+2Bj
		call	sub_10FCF

loc_104F7:				; CODE XREF: sub_10480+53j
		mov	al, [bp+arg_0]
		mov	ds:1DCh, al

loc_104FD:				; CODE XREF: sub_10480+8j
					; sub_10480+10j
		pop	bp
		retn
sub_10480	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_10500	proc near		; CODE XREF: sub_105DC+3Dp
					; sub_105DC+67p ...

arg_0		= word ptr  4
arg_2		= word ptr  6

		push	bp
		mov	bp, sp
		mov	ax, 0B400h
		push	ax
		push	word ptr ds:106h
		push	word ptr ds:104h
		mov	ax, 3
		push	ax
		push	[bp+arg_2]
		push	[bp+arg_0]
		call	LoadFile
		add	sp, 0Ch
		or	ax, ax
		jnz	short loc_10526
		jmp	loc_105A8
; ---------------------------------------------------------------------------

loc_10526:				; CODE XREF: sub_10500+21j
		cmp	ds:word_12062, 1
		jnz	short loc_10530
		call	sub_11823

loc_10530:				; CODE XREF: sub_10500+2Bj
		cmp	ds:word_12062, 0
		jnz	short loc_1053A
		call	sub_11823

loc_1053A:				; CODE XREF: sub_10500+35j
		cmp	ds:word_1205E, 0
		jnz	short loc_10544
		call	sub_10F8F

loc_10544:				; CODE XREF: sub_10500+3Fj
		call	sub_10F99
		push	ds:word_1205E
		call	sub_1102F
		add	sp, 2
		push	ds:word_12016
		push	ds:word_12014
		call	sub_11C1E
		add	sp, 4
		cmp	ds:word_1205C, 0FFFFh
		jnz	short loc_1057B
		cmp	ds:word_1205A, 0FFFFh
		jnz	short loc_1057B
		push	ds:word_122D0
		push	ds:word_122CE
		call	sub_10A76
		add	sp, 4

loc_1057B:				; CODE XREF: sub_10500+64j
					; sub_10500+6Bj
		cmp	word ptr ds:14Eh, 0
		jnz	short loc_10585
		call	sub_10F94

loc_10585:				; CODE XREF: sub_10500+80j
		call	sub_10F9E
		cmp	ds:word_12062, 0
		jnz	short loc_10592
		call	sub_117C0

loc_10592:				; CODE XREF: sub_10500+8Dj
		cmp	ds:word_12062, 0FFFFh
		jnz	short loc_105A2
		call	sub_117C0
		mov	ds:word_12062, 0

loc_105A2:				; CODE XREF: sub_10500+97j
		mov	ds:word_1205A, 0

loc_105A8:				; CODE XREF: sub_10500+23j
		pop	bp
		retn
sub_10500	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_105AA	proc near		; CODE XREF: sub_10BB2+BAp

arg_0		= word ptr  4
arg_2		= word ptr  6

		push	bp
		mov	bp, sp
		mov	ds:word_12056, 0
		mov	ax, 2F00h
		push	ax
		push	ds:word_12012
		push	ds:word_12010
		mov	ax, 4
		push	ax
		push	[bp+arg_2]
		push	[bp+arg_0]
		call	LoadFile
		add	sp, 0Ch
		or	ax, ax
		jz	short loc_105D9
		mov	ds:word_12056, 1

loc_105D9:				; CODE XREF: sub_105AA+27j
		pop	bp
		retn
sub_105AA	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_105DC	proc near		; CODE XREF: sub_10BB2:loc_10BCAp
		mov	ax, offset aEmi	; "EMI"
		push	ds
		push	ax
		mov	ax, offset aAyam ; "AYAM"
		push	ds
		push	ax
		mov	ax, offset aMusic ; "\\music\\"
		push	ds
		push	ax
		mov	ax, offset byte_121B8
		push	ds
		push	ax
		call	sub_1006E
		add	sp, 10h
		mov	ax, offset byte_121B8
		push	ds
		push	ax
		call	sub_10FAA
		add	sp, 4
		call	sub_11823
		call	sub_10F9E
		mov	ax, 15h
		push	ax
		sub	ax, ax
		push	ax
		call	sub_113E3
		add	sp, 4
		mov	ax, offset aTitle ; "TITLE"
		push	ds
		push	ax
		call	sub_10500
		add	sp, 4
		jmp	short loc_10625
; ---------------------------------------------------------------------------
		align 2

loc_10622:				; CODE XREF: sub_105DC+4Ej
		call	sub_11885

loc_10625:				; CODE XREF: sub_105DC+43j
		call	sub_1188A
		or	ax, ax
		jnz	short loc_10622

loc_1062C:				; CODE XREF: sub_105DC+5Aj
		call	sub_11885
		mov	cl, 8
		shr	ax, cl
		cmp	ax, 34h
		jnz	short loc_1062C
		mov	ds:word_12062, 1
		mov	ax, offset aWaku ; "WAKU"
		push	ds
		push	ax
		call	sub_10500
		add	sp, 4
		mov	ds:word_12062, 0FFFFh
		mov	ds:word_1205E, 1
		retn
sub_105DC	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_10656	proc near		; CODE XREF: sub_10BB2+23Cp

var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		sub	sp, 4
		push	di
		push	si
		jmp	short loc_10663
; ---------------------------------------------------------------------------

loc_10660:				; CODE XREF: sub_10656+12j
		call	sub_11885

loc_10663:				; CODE XREF: sub_10656+8j
		call	sub_1188A
		or	ax, ax
		jnz	short loc_10660
		mov	si, 1
		mov	di, [bp+arg_0]

loc_10670:				; CODE XREF: sub_10656+63j
		push	si
		call	sub_114B9
		add	sp, 2

loc_10677:				; CODE XREF: sub_10656+26j
		call	sub_1188A
		or	ax, ax
		jz	short loc_10677
		call	sub_11885
		mov	cl, 8
		shr	ax, cl
		mov	[bp+var_4], ax
		cmp	ax, 1Ch
		jz	short loc_106C6
		cmp	ax, 3Ah	; ':'
		jz	short loc_106BC
		cmp	ax, 3Dh	; '='
		jz	short loc_106A6
		cmp	ax, 43h	; 'C'
		jz	short loc_106BC
		cmp	ax, 47h	; 'G'
		jz	short loc_106C6
		cmp	ax, 4Bh	; 'K'
		jnz	short loc_106B0

loc_106A6:				; CODE XREF: sub_10656+3Fj
		inc	si
		mov	ax, di
		cmp	ax, si
		jnb	short loc_106B0
		mov	si, 1

loc_106B0:				; CODE XREF: sub_10656+4Ej
					; sub_10656+55j ...
		sub	ax, ax
		push	ax
		call	sub_114B9
		add	sp, 2
		jmp	short loc_10670
; ---------------------------------------------------------------------------
		align 2

loc_106BC:				; CODE XREF: sub_10656+3Aj
					; sub_10656+44j
		dec	si
		cmp	si, 1
		jnb	short loc_106B0
		mov	si, di
		jmp	short loc_106B0
; ---------------------------------------------------------------------------

loc_106C6:				; CODE XREF: sub_10656+35j
					; sub_10656+49j
		mov	ax, si
		mov	[bp+var_2], si
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retn
sub_10656	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_106D2	proc near		; CODE XREF: sub_10BB2:mes24p
		jmp	short loc_106D7
; ---------------------------------------------------------------------------

loc_106D4:				; CODE XREF: sub_106D2+Aj
		call	sub_11885

loc_106D7:				; CODE XREF: sub_106D2j
		call	sub_1188A
		or	ax, ax
		jnz	short loc_106D4

loc_106DE:				; CODE XREF: sub_106D2+16j
		call	sub_11885
		mov	cl, 8
		shr	ax, cl
		cmp	ax, 34h	; '4'
		jnz	short loc_106DE
		retn
sub_106D2	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_106EC	proc near		; CODE XREF: sub_10BB2+C6p

var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= dword	ptr  4

		push	bp
		mov	bp, sp
		sub	sp, 4
		push	si
		les	bx, [bp+arg_0]
		assume es:nothing
		inc	word ptr [bp+arg_0]
		mov	al, es:[bx]
		sub	ah, ah
		mov	[bp+var_4], ax
		mov	bx, ax
		shl	bx, 1
		mov	si, word ptr [bp+arg_0]
		mov	al, es:[si]
		mov	[bx+2A0h], ax
		mov	[bp+var_2], ax
		inc	word ptr [bp+arg_0]
		or	ax, ax
		jz	short loc_1072C
		dec	[bp+var_2]
		mov	ax, [bp+var_2]
		mov	cl, 3
		shl	ax, cl
		add	ax, offset byte_120FE
		mov	word ptr [bp+arg_0], ax
		mov	word ptr [bp+arg_0+2], ds

loc_1072C:				; CODE XREF: sub_106EC+2Bj
		mov	bx, [bp+var_4]
		shl	bx, 1
		shl	bx, 1
		mov	ax, word ptr [bp+arg_0]
		mov	dx, word ptr [bp+arg_0+2]
		mov	[bx+3A8h], ax
		mov	[bx+3AAh], dx
		pop	si
		mov	sp, bp
		pop	bp
		retn
sub_106EC	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_10746	proc near		; CODE XREF: PrintScriptText+54p

var_2		= byte ptr -2

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	si
		cmp	word ptr ds:29Eh, 0FFFFh
		jnz	short loc_10757
		jmp	loc_107D7
; ---------------------------------------------------------------------------

loc_10757:				; CODE XREF: sub_10746+Cj
		cmp	ds:word_12160, 0
		jz	short loc_1077A
		cmp	ds:word_12160, 9
		ja	short loc_10770
		push	ds:word_1201A
		push	ds:word_12018
		jmp	short loc_10789
; ---------------------------------------------------------------------------
		align 2

loc_10770:				; CODE XREF: sub_10746+1Dj
		push	ds:word_1201E
		push	ds:word_1201C
		jmp	short loc_10789
; ---------------------------------------------------------------------------

loc_1077A:				; CODE XREF: sub_10746+16j
		cmp	ds:word_12056, 0
		jz	short loc_107D7
		push	ds:word_12012
		push	ds:word_12010

loc_10789:				; CODE XREF: sub_10746+27j
					; sub_10746+32j
		call	sub_11E01
		add	sp, 4

loc_1078F:				; CODE XREF: sub_10746+70j
		mov	bx, ds:29Eh
		les	si, ds:256h
		mov	al, es:[bx+si]
		mov	[bp+var_2], al
		inc	word ptr ds:29Eh
		sub	ah, ah
		cmp	ax, 74h
		jz	short loc_107B0
		cmp	ax, 7Ah
		jz	short loc_107B8
		jmp	short loc_107C4
; ---------------------------------------------------------------------------
		align 2

loc_107B0:				; CODE XREF: sub_10746+60j
		mov	word ptr ds:29Eh, 0
		jmp	short loc_1078F
; ---------------------------------------------------------------------------

loc_107B8:				; CODE XREF: sub_10746+65j
		mov	word ptr ds:29Eh, 0FFFFh
		pop	si
		mov	sp, bp
		pop	bp
		retn
; ---------------------------------------------------------------------------
		align 2

loc_107C4:				; CODE XREF: sub_10746+67j
		cmp	[bp+var_2], 0
		jz	short loc_107D7
		mov	al, [bp+var_2]
		sub	ah, ah
		dec	ax
		push	ax
		call	sub_11DEE
		add	sp, 2

loc_107D7:				; CODE XREF: sub_10746+Ej
					; sub_10746+39j ...
		pop	si
		mov	sp, bp
		pop	bp
		retn
sub_10746	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_107DC	proc near		; CODE XREF: sub_1083E+11p
					; sub_10BB2+13Dp

arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		mov	bx, [bp+arg_0]
		shl	bx, 1
		shl	bx, 1
		push	word ptr [bx+112h]
		push	word ptr [bx+110h]
		call	sub_11BF6
		add	sp, 4
		pop	bp
		retn
sub_107DC	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

DefineCharacter	proc near		; CODE XREF: sub_10BB2+16Ap

var_2		= word ptr -2
arg_0		= dword	ptr  4

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	si
		les	bx, [bp+arg_0]
		inc	word ptr [bp+arg_0]
		mov	al, es:[bx]
		sub	ah, ah
		mov	[bp+var_2], ax
		mov	bx, ax
		mov	si, word ptr [bp+arg_0]
		inc	word ptr [bp+arg_0]
		mov	al, es:[si]
		mov	[bx+29Ah], al
		mov	si, word ptr [bp+arg_0]
		inc	word ptr [bp+arg_0]
		mov	al, es:[si]
		mov	[bx+252h], al
		shl	bx, 1
		shl	bx, 1
		mov	ax, word ptr [bp+arg_0]
		mov	dx, es
		mov	[bx+25Ah], ax
		mov	[bx+25Ch], dx
		pop	si
		mov	sp, bp
		pop	bp
		retn
DefineCharacter	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1083E	proc near		; CODE XREF: sub_10BB2+177p

arg_0		= byte ptr  4

		push	bp
		mov	bp, sp
		push	di
		push	si
		mov	al, [bp+arg_0]
		sub	ah, ah
		mov	si, ax
		mov	al, [si+252h]
		push	ax
		call	sub_107DC
		add	sp, 2
		mov	al, [si+29Ah]
		sub	ah, ah
		push	ax
		call	sub_113F6
		add	sp, 2
		mov	di, si
		mov	cl, 2
		shl	di, cl
		push	word ptr [di+25Ch]
		push	word ptr [di+25Ah]
		call	PrintCString
		add	sp, 4
		mov	ax, 7
		push	ax
		call	sub_113F6
		add	sp, 2
		mov	bx, si
		shl	bx, 1
		mov	ax, [bx+2A0h]
		mov	ds:250h, ax
		mov	ax, [di+3A8h]
		mov	dx, [di+3AAh]
		mov	ds:256h, ax
		mov	ds:258h, dx
		mov	word ptr ds:29Eh, 0
		mov	word ptr ds:148h, 0Ch
		pop	si
		pop	di
		pop	bp
		retn
sub_1083E	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

PrintScriptText	proc near		; CODE XREF: sub_10BB2+15Fp

var_6		= word ptr -6
var_4		= byte ptr -4
arg_0		= dword	ptr  4
arg_4		= word ptr  8
arg_6		= word ptr  0Ah

		push	bp
		mov	bp, sp
		sub	sp, 6
		mov	[bp+var_6], 0
		push	word ptr ds:148h
		call	Print_StartLine
		add	sp, 2
		jmp	short loc_108C5
; ---------------------------------------------------------------------------
		align 2

loc_108C2:				; CODE XREF: PrintScriptText+20j
		call	sub_11885

loc_108C5:				; CODE XREF: PrintScriptText+15j
		call	sub_1188A
		or	ax, ax
		jnz	short loc_108C2

loc_108CC:				; CODE XREF: PrintScriptText+33j
		mov	bx, 40h
		mov	es, bx
		assume es:nothing
		mov	bx, 130h
		mov	cl, es:[bx]
		mov	ax, cx
		and	al, 10h
		cmp	al, 10h
		jz	short loc_108CC
		mov	[bp+var_4], cl
		jmp	short loc_1091A
; ---------------------------------------------------------------------------

loc_108E4:				; CODE XREF: PrintScriptText+7Ej
		push	word ptr ds:144h
		call	sub_11659
		add	sp, 2
		mov	al, [bp+var_4]
		sub	ah, ah
		push	ax
		call	PrintChar
		add	sp, 2
		or	ax, ax
		jz	short loc_10901
		call	sub_10746

loc_10901:				; CODE XREF: PrintScriptText+52j
		cmp	word ptr ds:150h, 0
		jnz	short loc_10917
		push	[bp+arg_6]
		push	[bp+arg_4]
		call	sub_1094E
		add	sp, 4
		mov	ds:150h, ax

loc_10917:				; CODE XREF: PrintScriptText+5Cj
		call	sub_11665

loc_1091A:				; CODE XREF: PrintScriptText+38j
		les	bx, [bp+arg_0]
		assume es:nothing
		inc	word ptr [bp+arg_0]
		mov	al, es:[bx]
		mov	[bp+var_4], al
		or	al, al
		jnz	short loc_108E4
		mov	word ptr ds:148h, 0
		sub	ax, ax
		push	ax
		call	Print_StartLine
		add	sp, 2
		mov	ax, 0Dh
		push	ax
		call	PrintChar
		add	sp, 2
		mov	ax, 0Ah
		push	ax
		call	PrintChar
		mov	sp, bp
		pop	bp
		retn
PrintScriptText	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1094E	proc near		; CODE XREF: PrintScriptText+64p
					; sub_10A40+2Ap

var_2		= byte ptr -2
arg_0		= dword	ptr  4

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	si
		cmp	word ptr ds:146h, 0
		jz	short loc_10976
		push	word ptr ds:102h
		push	word ptr ds:100h
		call	sub_11E01
		add	sp, 4
		cmp	word ptr [bp+arg_0+2], 0
		jnz	short loc_10984
		cmp	word ptr [bp+arg_0], 0
		jnz	short loc_10984

loc_10976:				; CODE XREF: sub_1094E+Cj
					; sub_1094E+7Cj
		mov	ax, 0FFFFh
		pop	si
		mov	sp, bp
		pop	bp
		retn
; ---------------------------------------------------------------------------

loc_1097E:				; CODE XREF: sub_1094E+56j
		mov	word ptr ds:3B8h, 0

loc_10984:				; CODE XREF: sub_1094E+20j
					; sub_1094E+26j ...
		mov	si, ds:3B8h
		inc	word ptr ds:3B8h
		les	bx, [bp+arg_0]
		mov	al, es:[bx+si]
		mov	[bp+var_2], al
		sub	ah, ah
		cmp	ax, 65h	; 'e'
		jz	short loc_109CC
		cmp	ax, 6Ch	; 'l'
		jz	short loc_109DE
		cmp	ax, 74h	; 't'
		jz	short loc_1097E
		cmp	ax, 78h	; 'x'
		jz	short loc_10A23
		cmp	ax, 7Ah	; 'z'
		jz	short loc_109C4
		cmp	al, ah
		jnz	short loc_109B7
		jmp	loc_10A38
; ---------------------------------------------------------------------------

loc_109B7:				; CODE XREF: sub_1094E+64j
		dec	ax
		push	ax
		call	sub_11DEE
		add	sp, 2
		jmp	short loc_10A38
; ---------------------------------------------------------------------------
		align 4

loc_109C4:				; CODE XREF: sub_1094E+60j
		mov	word ptr ds:3B8h, 0
		jmp	short loc_10976
; ---------------------------------------------------------------------------

loc_109CC:				; CODE XREF: sub_1094E+4Cj
		les	bx, [bp+arg_0]
		mov	si, ds:3B8h
		mov	al, es:[bx+si]

loc_109D6:				; CODE XREF: sub_1094E+C5j
		sub	ah, ah
		mov	ds:3B8h, ax
		jmp	short loc_10984
; ---------------------------------------------------------------------------
		align 2

loc_109DE:				; CODE XREF: sub_1094E+51j
		les	bx, [bp+arg_0]
		mov	si, ds:3B8h
		mov	al, es:[bx+si]
		mov	[bp+var_2], al
		inc	word ptr ds:3B8h
		mov	si, ds:3B8h
		mov	al, es:[bx+si]
		sub	ah, ah
		cmp	ax, ds:24Eh
		ja	short loc_10A0C
		mov	word ptr ds:24Eh, 0
		inc	word ptr ds:3B8h
		jmp	loc_10984
; ---------------------------------------------------------------------------
		align 2

loc_10A0C:				; CODE XREF: sub_1094E+AEj
		inc	word ptr ds:24Eh
		mov	al, [bp+var_2]
		jmp	short loc_109D6
; ---------------------------------------------------------------------------
		align 2

loc_10A16:				; CODE XREF: sub_1094E+E8j
		mov	al, [bp+var_2]
		sub	ah, ah
		dec	ax
		push	ax
		call	sub_11DEE
		add	sp, 2

loc_10A23:				; CODE XREF: sub_1094E+5Bj
		mov	si, ds:3B8h
		inc	word ptr ds:3B8h
		les	bx, [bp+arg_0]
		mov	al, es:[bx+si]
		mov	[bp+var_2], al
		or	al, al
		jnz	short loc_10A16

loc_10A38:				; CODE XREF: sub_1094E+66j
					; sub_1094E+71j
		sub	ax, ax
		pop	si
		mov	sp, bp
		pop	bp
		retn
sub_1094E	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_10A40	proc near		; CODE XREF: sub_10BB2+12Ep

arg_0		= word ptr  4
arg_2		= word ptr  6

		push	bp
		mov	bp, sp
		jmp	short loc_10A64
; ---------------------------------------------------------------------------
		align 2

loc_10A46:				; CODE XREF: sub_10A40+32j
		push	word ptr ds:144h
		call	sub_11659
		add	sp, 2
		mov	bx, 40h	; '@'
		mov	es, bx
		assume es:nothing
		mov	bx, 130h
		mov	al, es:[bx]
		and	al, 10h
		cmp	al, 10h
		jz	short loc_10A74
		call	sub_11665

loc_10A64:				; CODE XREF: sub_10A40+3j
		push	[bp+arg_2]
		push	[bp+arg_0]
		call	sub_1094E
		add	sp, 4
		or	ax, ax
		jz	short loc_10A46

loc_10A74:				; CODE XREF: sub_10A40+1Fj
		pop	bp
		retn
sub_10A40	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_10A76	proc near		; CODE XREF: sub_10500+75p

var_18		= word ptr -18h
var_16		= word ptr -16h
var_14		= word ptr -14h
var_12		= word ptr -12h
var_10		= word ptr -10h
var_E		= word ptr -0Eh
var_C		= dword	ptr -0Ch
var_8		= dword	ptr -8
var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= dword	ptr  4

		push	bp
		mov	bp, sp
		sub	sp, 18h
		push	di
		push	si
		mov	word ptr [bp+var_C], 0
		mov	word ptr [bp+var_C+2], 0A000h
		les	bx, [bp+arg_0]
		assume es:nothing
		inc	word ptr [bp+arg_0]
		mov	al, es:[bx]
		sub	ah, ah
		shl	ax, 1
		add	word ptr [bp+var_C], ax
		mov	bx, word ptr [bp+arg_0]
		mov	al, 0A0h ; ' '
		mul	byte ptr es:[bx]
		add	word ptr [bp+var_C], ax
		mov	ax, word ptr [bp+var_C]
		mov	dx, word ptr [bp+var_C+2]
		mov	word ptr [bp+var_8], ax
		mov	word ptr [bp+var_8+2], dx
		add	byte ptr [bp+var_8+1], 20h ; ' '
		inc	word ptr [bp+arg_0]
		mov	bx, word ptr [bp+arg_0]
		inc	word ptr [bp+arg_0]
		mov	al, es:[bx]
		sub	ah, ah
		mov	[bp+var_2], ax
		mov	bx, word ptr [bp+arg_0]
		inc	word ptr [bp+arg_0]
		mov	al, es:[bx]
		mov	[bp+var_4], ax
		mov	bx, word ptr [bp+arg_0]
		mov	al, es:[bx]
		or	ax, ax
		jz	short loc_10AEC
		cmp	ax, 1
		jnz	short loc_10AE2
		jmp	loc_10B6A
; ---------------------------------------------------------------------------

loc_10AE2:				; CODE XREF: sub_10A76+67j
		cmp	ax, 2
		jnz	short loc_10AEA
		jmp	loc_10B78
; ---------------------------------------------------------------------------

loc_10AEA:				; CODE XREF: sub_10A76+6Fj
		jmp	short loc_10AF6
; ---------------------------------------------------------------------------

loc_10AEC:				; CODE XREF: sub_10A76+62j
		mov	[bp+var_12], 2156h
		mov	[bp+var_10], 2

loc_10AF6:				; CODE XREF: sub_10A76:loc_10AEAj
					; sub_10A76+FEj ...
		mov	ax, [bp+var_10]
		cmp	[bp+var_2], ax
		jle	short loc_10B01
		mov	[bp+var_2], ax

loc_10B01:				; CODE XREF: sub_10A76+86j
		mov	ax, [bp+var_10]
		cmp	[bp+var_4], ax
		jle	short loc_10B0C
		mov	[bp+var_4], ax

loc_10B0C:				; CODE XREF: sub_10A76+91j
		cmp	[bp+var_4], 0
		jg	short loc_10B15
		jmp	loc_10BAC
; ---------------------------------------------------------------------------

loc_10B15:				; CODE XREF: sub_10A76+9Aj
		mov	ax, [bp+var_10]
		sub	ax, [bp+var_2]
		mov	ch, al
		sub	cl, cl
		mov	[bp+var_16], cx
		mov	ax, [bp+var_2]
		shl	ax, 1
		sub	ax, 50h	; 'P'
		neg	ax
		shl	ax, 1
		mov	[bp+var_18], ax

loc_10B31:				; CODE XREF: sub_10A76+131j
		mov	cx, [bp+var_2]
		or	cx, cx
		jle	short loc_10B95
		les	di, [bp+var_8]
		mov	[bp+var_14], ds
		lds	si, [bp+var_C]

loc_10B41:				; CODE XREF: sub_10A76+F1j
		mov	ax, [bp+var_12]
		mov	[si], ax
		add	si, 2
		or	al, 80h
		mov	[si], ax
		add	si, 2
		mov	word ptr es:[di], 1
		add	di, 2
		mov	word ptr es:[di], 1
		add	di, 2
		add	byte ptr [bp+var_12+1],	1
		dec	cx
		jz	short loc_10B86
		jmp	short loc_10B41
; ---------------------------------------------------------------------------
		align 2

loc_10B6A:				; CODE XREF: sub_10A76+69j
		mov	[bp+var_12], 2556h
		mov	[bp+var_10], 3
		jmp	loc_10AF6
; ---------------------------------------------------------------------------
		align 2

loc_10B78:				; CODE XREF: sub_10A76+71j
		mov	[bp+var_12], 2E56h
		mov	[bp+var_10], 6
		jmp	loc_10AF6
; ---------------------------------------------------------------------------
		align 2

loc_10B86:				; CODE XREF: sub_10A76+EFj
		mov	word ptr [bp+var_C], si
		mov	word ptr [bp+var_C+2], ds
		mov	ds, [bp+var_14]
		mov	word ptr [bp+var_8], di
		mov	word ptr [bp+var_8+2], es

loc_10B95:				; CODE XREF: sub_10A76+C0j
		mov	ax, [bp+var_18]
		add	word ptr [bp+var_C], ax
		add	word ptr [bp+var_8], ax
		mov	ax, [bp+var_16]
		add	[bp+var_12], ax
		dec	[bp+var_4]
		jnz	short loc_10B31
		mov	[bp+var_E], cx

loc_10BAC:				; CODE XREF: sub_10A76+9Cj
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retn
sub_10A76	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_10BB2	proc near		; CODE XREF: start+2Ap

var_34		= word ptr -34h
var_2E		= word ptr -2Eh
var_28		= word ptr -28h
var_26		= word ptr -26h
mesCmdID	= word ptr -24h
var_22		= word ptr -22h
var_20		= word ptr -20h
mesFileOfs	= dword	ptr -1Eh
var_1A		= word ptr -1Ah
mesNextOfs	= word ptr -14h
var_12		= word ptr -12h

		push	bp
		mov	bp, sp
		sub	sp, 34h
		push	di
		push	si
		call	sub_101F6
		inc	ax
		jnz	short loc_10BCA
		mov	ax, 0FFFFh
		push	ax
		call	sub_11E4C
; ---------------------------------------------------------------------------
		add	sp, 2

loc_10BCA:				; CODE XREF: sub_10BB2+Cj
		call	sub_105DC
		mov	[bp+var_26], 0
		mov	ax, ds:0FCh
		mov	dx, ds:0FEh
		mov	word ptr [bp+mesFileOfs], ax
		mov	word ptr [bp+mesFileOfs+2], dx
		mov	[bp+mesNextOfs], ax
		mov	[bp+var_12], dx

loc_10BE5:				; CODE XREF: sub_10BB2+92j
		les	bx, [bp+mesFileOfs]
		mov	al, es:[bx]
		sub	ah, ah
		mov	[bp+mesCmdID], ax ; read MES.DAT command ID
		or	ax, ax
		jnz	short loc_10BF7
		jmp	mes00_EOF
; ---------------------------------------------------------------------------

loc_10BF7:				; CODE XREF: sub_10BB2+40j
		inc	word ptr [bp+mesFileOfs]
		mov	bx, word ptr [bp+mesFileOfs] ; read file offset	of next	command	(== command data end)
		mov	ax, es:[bx]
		mov	[bp+mesNextOfs], ax
		add	word ptr [bp+mesFileOfs], 2
		mov	ax, [bp+mesCmdID]
		cmp	ax, 2Dh
		jz	short mes2D
		jle	short loc_10C14
		jmp	loc_10EEE
; ---------------------------------------------------------------------------

loc_10C14:				; CODE XREF: sub_10BB2+5Dj
		sub	ax, 21h
		cmp	ax, 0Ah
		ja	short mes_next_cmd
		add	ax, ax
		xchg	ax, bx
		jmp	word ptr cs:mes2x_JumpTbl[bx]
; ---------------------------------------------------------------------------

mes2D:					; CODE XREF: sub_10BB2+5Bj
		mov	bx, word ptr [bp+mesFileOfs]
		mov	al, es:[bx]
		sub	ah, ah
		push	ax
		call	sub_10480
		add	sp, 2

mes_next_cmd:				; CODE XREF: sub_10BB2+68j
					; sub_10BB2+6Dj ...
		mov	ax, [bp+mesNextOfs]
		add	ax, ds:0FCh
		mov	dx, ds:0FEh
		mov	word ptr [bp+mesFileOfs], ax
		mov	word ptr [bp+mesFileOfs+2], dx
		jmp	short loc_10BE5
; ---------------------------------------------------------------------------

mes2A_SetBG:				; CODE XREF: sub_10BB2+6Dj
					; DATA XREF: sub_10BB2+338o
		sub	ax, ax
		mov	[bp+var_20], ax
		mov	[bp+var_22], ax
		push	word ptr [bp+mesFileOfs+2]
		push	word ptr [bp+mesFileOfs]
		call	sub_10500
		add	sp, 4
		mov	word ptr ds:3B8h, 0
		mov	word ptr ds:24Eh, 0
		push	word ptr [bp+mesFileOfs+2]
		push	word ptr [bp+mesFileOfs]
		call	sub_105AA
		jmp	loc_10E73
; ---------------------------------------------------------------------------

mes5E:					; CODE XREF: sub_10BB2+36Fj
		push	word ptr [bp+mesFileOfs+2]
		push	word ptr [bp+mesFileOfs]
		call	sub_106EC
		jmp	loc_10E73
; ---------------------------------------------------------------------------

mes23:					; CODE XREF: sub_10BB2+6Dj
					; DATA XREF: sub_10BB2+32Ao
		mov	ax, 0B400h
		push	ax
		push	word ptr ds:106h
		push	word ptr ds:104h
		mov	ax, 3
		push	ax
		push	word ptr [bp+mesFileOfs+2]
		push	word ptr [bp+mesFileOfs]
		call	LoadFile
		add	sp, 0Ch
		or	ax, ax
		jz	short mes_next_cmd
		push	word ptr ds:142h
		push	word ptr ds:140h
		push	word ptr ds:106h
		push	word ptr ds:104h
		call	sub_11C60

loc_10CB1:				; CODE XREF: sub_10BB2+162j
		add	sp, 8
		jmp	mes_next_cmd
; ---------------------------------------------------------------------------
		align 2

loc_10CB8:				; CODE XREF: sub_10BB2+363j
		mov	word ptr ds:150h, 0
		mov	ax, word ptr [bp+mesFileOfs]
		mov	dx, word ptr [bp+mesFileOfs+2]
		mov	[bp+var_22], ax
		mov	[bp+var_20], dx
		mov	word ptr ds:3B8h, 0
		mov	word ptr ds:24Eh, 0
		jmp	mes_next_cmd
; ---------------------------------------------------------------------------
		align 2

mes2B:					; CODE XREF: sub_10BB2+6Dj
					; DATA XREF: sub_10BB2+33Ao
		push	[bp+var_20]
		push	[bp+var_22]
		call	sub_10A40
		jmp	loc_10E73
; ---------------------------------------------------------------------------

mes24:					; CODE XREF: sub_10BB2+6Dj
					; DATA XREF: sub_10BB2+32Co
		call	sub_106D2
		jmp	mes_next_cmd
; ---------------------------------------------------------------------------

mes2F_NarratorText:			; CODE XREF: sub_10BB2+34Bj
		sub	ax, ax
		push	ax
		call	sub_107DC
		add	sp, 2
		mov	word ptr ds:29Eh, 0FFFFh
		mov	ax, 7
		push	ax
		call	sub_113F6

loc_10D02:				; CODE XREF: sub_10BB2+17Aj
		add	sp, 2
		push	[bp+var_20]
		push	[bp+var_22]
		push	word ptr [bp+mesFileOfs+2]
		push	word ptr [bp+mesFileOfs]
		call	PrintScriptText
		jmp	short loc_10CB1
; ---------------------------------------------------------------------------

mes5F_DefineName:			; CODE XREF: sub_10BB2+377j
		push	word ptr [bp+mesFileOfs+2]
		push	word ptr [bp+mesFileOfs]
		call	DefineCharacter
		jmp	loc_10E73
; ---------------------------------------------------------------------------

mes3x_CharacterText:			; CODE XREF: sub_10BB2+35Bj
		sub	[bp+mesCmdID], 30h
		push	[bp+mesCmdID]
		call	sub_1083E
		jmp	short loc_10D02
; ---------------------------------------------------------------------------

mes3F_SetMenuTexts:			; CODE XREF: sub_10BB2+341j
		les	bx, [bp+mesFileOfs]
		inc	word ptr [bp+mesFileOfs]
		mov	al, es:[bx]
		mov	ds:3E4h, al
		mov	[bp+var_28], 0
		sub	ah, ah
		or	ax, ax
		jnz	short loc_10D48
		jmp	mes_next_cmd
; ---------------------------------------------------------------------------

loc_10D48:				; CODE XREF: sub_10BB2+191j
		mov	di, ax
		mov	si, 3C2h
		mov	cx, [bp+var_28]

loc_10D50:				; CODE XREF: sub_10BB2+1C1j
		mov	ax, word ptr [bp+mesFileOfs]
		mov	dx, es
		mov	[si], ax
		mov	[si+2],	dx
		jmp	short loc_10D5F
; ---------------------------------------------------------------------------

loc_10D5C:				; CODE XREF: sub_10BB2+1B4j
		inc	word ptr [bp+mesFileOfs]

loc_10D5F:				; CODE XREF: sub_10BB2+1A8j
		les	bx, [bp+mesFileOfs]
		cmp	byte ptr es:[bx], 0
		jnz	short loc_10D5C
		inc	word ptr [bp+mesFileOfs]
		add	si, 4
		inc	cx
		mov	ax, cx
		cmp	ax, di
		jb	short loc_10D50
		mov	[bp+var_28], cx
		jmp	mes_next_cmd
; ---------------------------------------------------------------------------
		align 2

mes26_MenuPtrs:				; CODE XREF: sub_10BB2+6Dj
					; DATA XREF: sub_10BB2+330o
		mov	bx, word ptr [bp+mesFileOfs]
		inc	word ptr [bp+mesFileOfs]
		mov	al, es:[bx]
		mov	ds:3E4h, al
		mov	ax, 0Bh
		push	ax
		call	sub_11076
		add	sp, 2
		mov	[bp+var_28], 0
		mov	al, ds:3E4h
		sub	ah, ah
		or	ax, ax
		jz	short loc_10DE8
		mov	[bp+var_2E], ax
		mov	si, 3E6h
		mov	di, 98h	; '˜'
		mov	[bp+var_34], 3C2h

loc_10DAE:				; CODE XREF: sub_10BB2+234j
		les	bx, [bp+mesFileOfs]
		mov	ax, es:[bx]
		mov	[si], ax
		add	word ptr [bp+mesFileOfs], 2
		push	di
		mov	ax, 3Bh	; ';'
		push	ax
		call	sub_11082
		add	sp, 4
		mov	bx, [bp+var_34]
		push	word ptr [bx+2]
		push	word ptr [bx]
		call	sub_11099
		add	sp, 4
		add	si, 2
		add	di, 12h
		add	[bp+var_34], 4
		inc	[bp+var_28]
		mov	ax, [bp+var_2E]
		cmp	[bp+var_28], ax
		jb	short loc_10DAE

loc_10DE8:				; CODE XREF: sub_10BB2+1ECj
		mov	al, ds:3E4h
		sub	ah, ah
		push	ax
		call	sub_10656
		add	sp, 2
		dec	ax
		mov	[bp+var_1A], ax
		mov	bx, ax
		shl	bx, 1
		shl	bx, 1
		push	word ptr [bx+3C4h]
		push	word ptr [bx+3C2h]
		call	PrintCString
		add	sp, 4
		mov	ax, 0F8h
		push	ds
		push	ax
		call	PrintCString
		add	sp, 4
		call	sub_1146F
		jmp	mes_next_cmd
; ---------------------------------------------------------------------------
		align 2

mes21_MenuWait:				; CODE XREF: sub_10BB2+6Dj
					; DATA XREF: sub_10BB2:mes2x_JumpTblo
		mov	bx, [bp+var_1A]
		shl	bx, 1
		mov	ax, [bx+3E6h]

loc_10E27:				; CODE XREF: sub_10BB2+282j
		mov	[bp+mesNextOfs], ax
		jmp	mes_next_cmd
; ---------------------------------------------------------------------------
		align 2

mes7C_Jump:				; CODE XREF: sub_10BB2+37Fj
		les	bx, [bp+mesFileOfs]

loc_10E31:				; CODE XREF: sub_10BB2+2E8j
		mov	ax, es:[bx]
		jmp	short loc_10E27
; ---------------------------------------------------------------------------

mes25:					; CODE XREF: sub_10BB2+6Dj
					; DATA XREF: sub_10BB2+32Eo
		mov	word ptr ds:14Ah, 0FFFFh
		mov	ax, word ptr [bp+mesFileOfs]
		mov	dx, es
		mov	ds:3BEh, ax
		mov	ds:3C0h, dx
		jmp	mes_next_cmd
; ---------------------------------------------------------------------------
		align 2

mes7E_MetaCmd:				; CODE XREF: sub_10BB2+387j
		les	bx, [bp+mesFileOfs]
		mov	al, es:[bx]
		sub	ah, ah
		cmp	ax, 7
		jbe	short loc_10E5C
		jmp	mes_next_cmd
; ---------------------------------------------------------------------------

loc_10E5C:				; CODE XREF: sub_10BB2+2A5j
		add	ax, ax
		xchg	ax, bx
		jmp	word ptr cs:mes7E_JumpTbl[bx]
; ---------------------------------------------------------------------------
		jmp	mes_next_cmd
; ---------------------------------------------------------------------------
		align 2

mes7E_01:				; CODE XREF: sub_10BB2+2ADj
					; DATA XREF: sub_10BB2+314o
		push	word ptr ds:142h
		push	word ptr ds:140h
		call	sub_1169A

loc_10E73:				; CODE XREF: sub_10BB2+BDj
					; sub_10BB2+C9j ...
		add	sp, 4
		jmp	mes_next_cmd
; ---------------------------------------------------------------------------
		align 2

mes7E_02:				; CODE XREF: sub_10BB2+2ADj
					; DATA XREF: sub_10BB2+316o
		inc	word ptr [bp+mesFileOfs]
		les	bx, [bp+mesFileOfs]
		mov	al, es:[bx]
		or	ds:3BCh, al
		jmp	mes_next_cmd
; ---------------------------------------------------------------------------

mes7E_03:				; CODE XREF: sub_10BB2+2ADj
					; DATA XREF: sub_10BB2+318o
		cmp	byte ptr ds:3BCh, 7
		jz	short loc_10E94
		jmp	mes_next_cmd
; ---------------------------------------------------------------------------

loc_10E94:				; CODE XREF: sub_10BB2+2DDj
		inc	word ptr [bp+mesFileOfs]
		mov	bx, word ptr [bp+mesFileOfs]
		jmp	short loc_10E31
; ---------------------------------------------------------------------------

mes7E_04:				; CODE XREF: sub_10BB2+2ADj
					; DATA XREF: sub_10BB2+31Ao
		mov	word ptr ds:14Eh, 1
		jmp	mes_next_cmd
; ---------------------------------------------------------------------------
		align 2

mes7E_05:				; CODE XREF: sub_10BB2+2ADj
					; DATA XREF: sub_10BB2+31Co
		mov	word ptr ds:14Eh, 0
		jmp	mes_next_cmd
; ---------------------------------------------------------------------------
		align 2

mes7E_06:				; CODE XREF: sub_10BB2+2ADj
					; DATA XREF: sub_10BB2+31Eo
		mov	word ptr ds:152h, 1
		jmp	mes_next_cmd
; ---------------------------------------------------------------------------
		align 2

mes7E_07:				; CODE XREF: sub_10BB2+2ADj
					; DATA XREF: sub_10BB2+320o
		mov	word ptr ds:152h, -1
		jmp	mes_next_cmd
; ---------------------------------------------------------------------------
		align 2
mes7E_JumpTbl:				; DATA XREF: sub_10BB2+2ADr
		dw offset mes_next_cmd
		dw offset mes7E_01
		dw offset mes7E_02
		dw offset mes7E_03
		dw offset mes7E_04
		dw offset mes7E_05
		dw offset mes7E_06
		dw offset mes7E_07
; ---------------------------------------------------------------------------
		jmp	mes_next_cmd
; ---------------------------------------------------------------------------
		align 2
mes2x_JumpTbl:				; DATA XREF: sub_10BB2+6Dr
		dw offset mes21_MenuWait
		dw offset mes_next_cmd
		dw offset mes23
		dw offset mes24
		dw offset mes25
		dw offset mes26_MenuPtrs
		dw offset mes_next_cmd
		dw offset mes_next_cmd
		dw offset mes_next_cmd
		dw offset mes2A_SetBG
		dw offset mes2B
; ---------------------------------------------------------------------------

loc_10EEE:				; CODE XREF: sub_10BB2+5Fj
		cmp	ax, 3Fh
		jnz	short loc_10EF6
		jmp	mes3F_SetMenuTexts
; ---------------------------------------------------------------------------

loc_10EF6:				; CODE XREF: sub_10BB2+33Fj
		jg	short loc_10F1C
		cmp	ax, 2Fh
		jnz	short loc_10F00
		jmp	mes2F_NarratorText
; ---------------------------------------------------------------------------

loc_10F00:				; CODE XREF: sub_10BB2+349j
		cmp	ax, 30h
		jge	short loc_10F08
		jmp	mes_next_cmd
; ---------------------------------------------------------------------------

loc_10F08:				; CODE XREF: sub_10BB2+351j
		cmp	ax, 33h
		jg	short loc_10F10
		jmp	mes3x_CharacterText
; ---------------------------------------------------------------------------

loc_10F10:				; CODE XREF: sub_10BB2+359j
		cmp	ax, 3Dh
		jnz	short loc_10F18
		jmp	loc_10CB8
; ---------------------------------------------------------------------------

loc_10F18:				; CODE XREF: sub_10BB2+361j
		jmp	mes_next_cmd
; ---------------------------------------------------------------------------
		align 2

loc_10F1C:				; CODE XREF: sub_10BB2:loc_10EF6j
		cmp	ax, 5Eh
		jnz	short loc_10F24
		jmp	mes5E
; ---------------------------------------------------------------------------

loc_10F24:				; CODE XREF: sub_10BB2+36Dj
		cmp	ax, 5Fh
		jnz	short loc_10F2C
		jmp	mes5F_DefineName
; ---------------------------------------------------------------------------

loc_10F2C:				; CODE XREF: sub_10BB2+375j
		cmp	ax, 7Ch
		jnz	short loc_10F34
		jmp	mes7C_Jump
; ---------------------------------------------------------------------------

loc_10F34:				; CODE XREF: sub_10BB2+37Dj
		cmp	ax, 7Eh
		jnz	short loc_10F3C
		jmp	mes7E_MetaCmd
; ---------------------------------------------------------------------------

loc_10F3C:				; CODE XREF: sub_10BB2+385j
		jmp	mes_next_cmd
; ---------------------------------------------------------------------------
		align 2

mes00_EOF:				; CODE XREF: sub_10BB2+42j
					; sub_10BB2+39Bj
		mov	ax, 0FFFFh
		push	ax
		call	sub_11659
		add	sp, 2
		call	sub_11665
		jmp	short mes00_EOF
sub_10BB2	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_10F50	proc near		; CODE XREF: sub_1157Ap
		push	ds
		push	es
		push	si
		push	di
		mov	ds, cs:word_11E4A
		mov	ax, ds:2Ch
		mov	ds, ax
		mov	ax, cs
		mov	es, ax
		assume es:seg000
		xor	si, si

loc_10F64:				; CODE XREF: sub_10F50+2Aj
		mov	di, 0F88h
		mov	cx, 7
		repe cmpsb
		cmp	cx, 0
		jz	short loc_10F80

loc_10F71:				; CODE XREF: sub_10F50+24j
		lodsb
		or	al, al
		jnz	short loc_10F71
		mov	al, [si]
		or	al, al
		jnz	short loc_10F64
		xor	ax, ax
		jmp	short loc_10F83
; ---------------------------------------------------------------------------

loc_10F80:				; CODE XREF: sub_10F50+1Fj
		mov	ax, 0FFFFh

loc_10F83:				; CODE XREF: sub_10F50+2Ej
		pop	di
		pop	si
		pop	es
		assume es:nothing
		pop	ds
		retn
sub_10F50	endp

; ---------------------------------------------------------------------------
		inc	bx
		dec	di
		dec	bp
		push	bx
		push	ax
		inc	bp
		inc	bx

; =============== S U B	R O U T	I N E =======================================


sub_10F8F	proc near		; CODE XREF: sub_101F6+Bp
					; sub_10500+41p
		mov	al, 0Ch
		out	62h, al		; PC/XT	PPI port C. Bits:
					; 0-3: values of DIP switches
					; 5: 1=Timer 2 channel out
					; 6: 1=I/O channel check
					; 7: 1=RAM parity check	error occurred.
		retn
sub_10F8F	endp


; =============== S U B	R O U T	I N E =======================================


sub_10F94	proc near		; CODE XREF: sub_101F6+49p
					; sub_10500+82p
		mov	al, 0Dh
		out	62h, al		; PC/XT	PPI port C. Bits:
					; 0-3: values of DIP switches
					; 5: 1=Timer 2 channel out
					; 6: 1=I/O channel check
					; 7: 1=RAM parity check	error occurred.
		retn
sub_10F94	endp


; =============== S U B	R O U T	I N E =======================================


sub_10F99	proc near		; CODE XREF: sub_101F6+Ep
					; sub_10500:loc_10544p
		mov	al, 0Ch
		out	0A2h, al	; Interrupt Controller #2, 8259A
		retn
sub_10F99	endp


; =============== S U B	R O U T	I N E =======================================


sub_10F9E	proc near		; CODE XREF: sub_10500:loc_10585p
					; sub_105DC+28p
		mov	al, 0Dh
		out	0A2h, al	; Interrupt Controller #2, 8259A
		retn
sub_10F9E	endp


; =============== S U B	R O U T	I N E =======================================


sub_10FA3	proc near		; CODE XREF: sub_101F6+8p
		mov	ah, 42h	; 'B'
		mov	ch, 0C0h ; 'À'
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		retn
sub_10FA3	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_10FAA	proc near		; CODE XREF: sub_10480+4Dp
					; sub_105DC+1Fp

arg_0		= dword	ptr  4
arg_4		= word ptr  8

		push	bp
		mov	bp, sp
		push	ds
		lds	dx, [bp+arg_0]
		mov	ah, 1
		jmp	short loc_10FC1
; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		push	ds
		lds	dx, [bp+arg_0]
		mov	cx, [bp+arg_4]
		mov	ah, 2

loc_10FC1:				; CODE XREF: sub_10FAA+9j
		call	sub_10FD8
		mov	cx, 0FFFFh
		mov	ah, 3
		call	sub_10FD8
		pop	ds
		pop	bp
		retn
sub_10FAA	endp


; =============== S U B	R O U T	I N E =======================================


sub_10FCF	proc near		; CODE XREF: sub_10480:loc_104F4p
		mov	cx, 0FFFFh
		mov	ah, 4
		call	sub_10FD8
		retn
sub_10FCF	endp


; =============== S U B	R O U T	I N E =======================================


sub_10FD8	proc near		; CODE XREF: sub_10FAA:loc_10FC1p
					; sub_10FAA+1Fp ...
		push	ax
		push	es
		mov	ax, 35D2h
		int	21h		; DOS -	2+ - GET INTERRUPT VECTOR
					; AL = interrupt number
					; Return: ES:BX	= value	of interrupt vector
		cmp	byte ptr es:103h, 0CDh ; 'Í'
		jnz	short loc_10FF4
		cmp	byte ptr es:105h, 0C3h ; 'Ã'
		jnz	short loc_10FF4
		pop	es
		pop	ax
		int	0D2h		; used by BASIC	while in interpreter
		retn
; ---------------------------------------------------------------------------

loc_10FF4:				; CODE XREF: sub_10FD8+Dj
					; sub_10FD8+15j
		pop	es
		pop	ax
		retn
sub_10FD8	endp

; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		push	di
		push	es
		mov	dx, 3E80h
		xor	ax, ax
		mov	di, ax
		mov	cx, dx
		mov	bx, 0A800h
		mov	es, bx
		assume es:nothing
		rep stosw
		mov	di, ax
		mov	cx, dx
		mov	bx, 0B000h
		mov	es, bx
		assume es:nothing
		rep stosw
		mov	di, ax
		mov	cx, dx
		mov	bx, 0B800h
		mov	es, bx
		assume es:nothing
		rep stosw
		mov	di, ax
		mov	cx, dx
		mov	bx, 0E000h
		mov	es, bx
		assume es:nothing
		pop	es
		assume es:nothing
		pop	di
		pop	bp
		retn

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1102F	proc near		; CODE XREF: sub_10500+4Bp

arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		push	di
		push	es
		mov	bx, 0A000h
		mov	cx, 7D0h
		cmp	[bp+arg_0], 0
		jz	short loc_11043
		mov	cx, 690h

loc_11043:				; CODE XREF: sub_1102F+Fj
		xor	ax, ax
		mov	di, ax
		mov	es, bx
		assume es:nothing
		mov	ax, 20h	; ' '
		rep stosw
		mov	bx, 0A200h
		mov	cx, 7D0h
		cmp	[bp+arg_0], 0
		jz	short loc_1105D
		mov	cx, 690h

loc_1105D:				; CODE XREF: sub_1102F+29j
		xor	ax, ax
		mov	di, ax
		mov	es, bx
		assume es:nothing
		mov	ax, 0E1h ; 'á'
		rep stosw
		pop	es
		assume es:nothing
		pop	di
		pop	bp
		retn
sub_1102F	endp


; =============== S U B	R O U T	I N E =======================================


sub_1106C	proc near		; CODE XREF: sub_1152A+3p
		mov	al, 0Bh
		out	68h, al
		retn
sub_1106C	endp


; =============== S U B	R O U T	I N E =======================================


sub_11071	proc near		; CODE XREF: sub_1152A+32p
		mov	al, 0Ah
		out	68h, al
		retn
sub_11071	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_11076	proc near		; CODE XREF: sub_10BB2+1DAp

arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		mov	ax, [bp+arg_0]
		mov	cs:byte_110BE, al
		pop	bp
		retn
sub_11076	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_11082	proc near		; CODE XREF: sub_10BB2+20Dp

arg_0		= word ptr  4
arg_2		= word ptr  6

		push	bp
		mov	bp, sp
		mov	ax, [bp+arg_0]
		mov	cs:byte_110B9, al
		mov	cs:byte_110BC, al
		mov	ax, [bp+arg_2]
		mov	cs:word_110BA, ax
		pop	bp
		retn
sub_11082	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_11099	proc near		; CODE XREF: sub_10BB2+21Bp

arg_0		= dword	ptr  4

		push	bp
		mov	bp, sp
		push	ds
		push	si
		mov	cs:byte_110BD, 0
		lds	si, [bp+arg_0]

loc_110A7:				; CODE XREF: sub_11099+1Aj
		lodsb
		or	al, al
		jz	short loc_110B5
		push	ax
		call	PrintChar2
		add	sp, 2
		jmp	short loc_110A7
; ---------------------------------------------------------------------------

loc_110B5:				; CODE XREF: sub_11099+11j
		pop	si
		pop	ds
		pop	bp
		retn
sub_11099	endp

; ---------------------------------------------------------------------------
byte_110B9	db 0			; DATA XREF: sub_11082+6w
					; PrintChar2+24w ...
word_110BA	dw 0			; DATA XREF: sub_11082+11w
					; PrintChar2+Ew ...
byte_110BC	db 0			; DATA XREF: sub_11082+Aw
					; PrintChar2+20r ...
byte_110BD	db 0			; DATA XREF: sub_11099+5w
					; PrintChar2:loc_110F5w ...
byte_110BE	db 0			; DATA XREF: sub_11076+6w
					; PrintChar2+8Br
byte_110BF	db 20h dup(0)		; DATA XREF: PrintChar2:loc_1111Eo
					; PrintChar2+54o

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

PrintChar2	proc near		; CODE XREF: sub_11099+14p

arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		mov	ax, [bp+arg_0]
		cmp	al, 20h
		jnb	short loc_11109
		cmp	al, 0Ah
		jnz	short loc_110FB
		add	cs:word_110BA, 10h

loc_110F3:				; CODE XREF: PrintChar2+28j
					; PrintChar2+48j
		xor	al, al

loc_110F5:				; CODE XREF: PrintChar2+39j
					; PrintChar2+3Dj
		mov	cs:byte_110BD, al
		pop	bp
		retn
; ---------------------------------------------------------------------------

loc_110FB:				; CODE XREF: PrintChar2+Cj
		cmp	al, 0Dh
		jnz	short loc_11109
		mov	al, cs:byte_110BC
		mov	cs:byte_110B9, al
		jmp	short loc_110F3
; ---------------------------------------------------------------------------

loc_11109:				; CODE XREF: PrintChar2+8j
					; PrintChar2+1Ej
		mov	ah, cs:byte_110BD
		or	ah, ah
		jnz	short loc_1111E
		cmp	al, 7Fh
		jb	short loc_1111E
		cmp	al, 0E0h
		jnb	short loc_110F5
		cmp	al, 0A0h
		jb	short loc_110F5

loc_1111E:				; CODE XREF: PrintChar2+31j
					; PrintChar2+35j
		mov	bx, offset byte_110BF
		call	PrintChar2b
		cmp	ax, 0FFFFh
		jz	short loc_110F3
		mov	cx, ax
		push	si
		push	di
		push	ds
		push	es
		mov	bx, cs
		mov	ds, bx
		assume ds:seg000
		mov	si, offset byte_110BF
		mov	ax, cs:word_110BA
		mov	dx, 50h	; 'P'
		mul	dx
		xor	dh, dh
		mov	dl, cs:byte_110B9
		cmp	dl, 50h	; 'P'
		jz	short loc_11154
		cmp	dl, 4Fh	; 'O'
		jnz	short loc_11166
		or	cx, cx
		jz	short loc_11166

loc_11154:				; CODE XREF: PrintChar2+6Aj
		mov	dh, 5
		mov	dl, cs:byte_110BC
		mov	cs:byte_110B9, dl
		add	cs:word_110BA, 10h

loc_11166:				; CODE XREF: PrintChar2+6Fj
					; PrintChar2+73j
		add	ax, dx
		mov	di, ax
		mov	dl, cs:byte_110BE
		or	cx, cx
		mov	cx, 10h
		jz	short loc_111BC

loc_11176:				; CODE XREF: PrintChar2+D3j
		lodsw
		test	dl, 1
		jz	short loc_11185
		mov	bx, 0A800h
		mov	es, bx
		assume es:nothing
		stosw
		sub	di, 2

loc_11185:				; CODE XREF: PrintChar2+9Bj
		test	dl, 2
		jz	short loc_11193
		mov	bx, 0B000h
		mov	es, bx
		assume es:nothing
		stosw
		sub	di, 2

loc_11193:				; CODE XREF: PrintChar2+A9j
		test	dl, 4
		jz	short loc_111A1
		mov	bx, 0B800h
		mov	es, bx
		assume es:nothing
		stosw
		sub	di, 2

loc_111A1:				; CODE XREF: PrintChar2+B7j
		test	dl, 8
		jz	short loc_111AF
		mov	bx, 0E000h
		mov	es, bx
		assume es:nothing
		stosw
		sub	di, 2

loc_111AF:				; CODE XREF: PrintChar2+C5j
		add	di, 50h	; 'P'
		loop	loc_11176
		add	cs:byte_110B9, 2
		jmp	short loc_111F7
; ---------------------------------------------------------------------------

loc_111BC:				; CODE XREF: PrintChar2+95j
					; PrintChar2+111j
		lodsw
		test	dl, 1
		jz	short loc_111C9
		mov	bx, 0A800h
		mov	es, bx
		assume es:nothing
		stosb
		dec	di

loc_111C9:				; CODE XREF: PrintChar2+E1j
		test	dl, 2
		jz	short loc_111D5
		mov	bx, 0B000h
		mov	es, bx
		assume es:nothing
		stosb
		dec	di

loc_111D5:				; CODE XREF: PrintChar2+EDj
		test	dl, 4
		jz	short loc_111E1
		mov	bx, 0B800h
		mov	es, bx
		assume es:nothing
		stosb
		dec	di

loc_111E1:				; CODE XREF: PrintChar2+F9j
		test	dl, 8
		jz	short loc_111ED
		mov	bx, 0E000h
		mov	es, bx
		assume es:nothing
		stosb
		dec	di

loc_111ED:				; CODE XREF: PrintChar2+105j
		add	di, 50h	; 'P'
		loop	loc_111BC
		inc	cs:byte_110B9

loc_111F7:				; CODE XREF: PrintChar2+DBj
		mov	cs:byte_110BD, 0
		pop	es
		assume es:nothing
		pop	ds
		assume ds:nothing
		pop	di
		pop	si
		pop	bp
		retn
PrintChar2	endp


; =============== S U B	R O U T	I N E =======================================


PrintChar2b	proc near		; CODE XREF: PrintChar2+42p
		mov	dx, 1
		or	ah, ah
		jnz	short loc_11227
		cmp	al, 20h
		ja	short loc_1121C
		jz	short loc_11214

loc_11210:				; CODE XREF: PrintChar2b+27j
		mov	ax, 0FFFFh
		retn
; ---------------------------------------------------------------------------

loc_11214:				; CODE XREF: PrintChar2b+Bj
		mov	ax, 8640h
		xor	dx, dx
		jmp	short loc_11227
; ---------------------------------------------------------------------------
		align 2

loc_1121C:				; CODE XREF: PrintChar2b+9j
		add	ax, 851Fh
		cmp	ax, 857Fh
		jb	short loc_11225
		inc	ax

loc_11225:				; CODE XREF: PrintChar2b+1Fj
		xor	dx, dx

loc_11227:				; CODE XREF: PrintChar2b+5j
					; PrintChar2b+16j
		sub	ax, 8140h
		jb	short loc_11210
		cmp	al, 40h	; '@'
		jb	short loc_11232
		dec	al

loc_11232:				; CODE XREF: PrintChar2b+2Bj
		cmp	ah, 5Fh
		jb	short loc_1123A
		sub	ah, 40h

loc_1123A:				; CODE XREF: PrintChar2b+32j
		shl	ah, 1
		inc	ah
		cmp	al, 5Eh
		jb	short loc_11246
		inc	ah
		sub	al, 5Eh

loc_11246:				; CODE XREF: PrintChar2b+3Dj
		add	al, 21h
		push	ax
		mov	al, 0Ch
		out	62h, al		; PC/XT	PPI port C. Bits:
					; 0-3: values of DIP switches
					; 5: 1=Timer 2 channel out
					; 6: 1=I/O channel check
					; 7: 1=RAM parity check	error occurred.
		mov	al, 0Bh
		out	68h, al
		pop	ax
		out	0A1h, al	; Interrupt Controller #2, 8259A
		mov	al, ah
		out	0A3h, al	; Interrupt Controller #2, 8259A
		xor	ah, ah
		mov	cx, 10h

loc_1125D:				; CODE XREF: PrintChar2b+76j
		xor	ah, 20h
		mov	al, ah
		out	0A5h, al	; Interrupt Controller #2, 8259A
		in	al, 0A9h	; Interrupt Controller #2, 8259A
		mov	cs:[bx], al
		inc	bx
		xor	ah, 20h
		mov	al, ah
		out	0A5h, al	; Interrupt Controller #2, 8259A
		in	al, 0A9h	; Interrupt Controller #2, 8259A
		mov	cs:[bx], al
		inc	bx
		inc	ah
		loop	loc_1125D
		mov	al, 0Ah
		out	68h, al
		mov	al, 0Dh
		out	62h, al		; PC/XT	PPI port C. Bits:
					; 0-3: values of DIP switches
					; 5: 1=Timer 2 channel out
					; 6: 1=I/O channel check
					; 7: 1=RAM parity check	error occurred.
		mov	ax, dx
		retn
PrintChar2b	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

PrintChar	proc near		; CODE XREF: PrintScriptText+4Ap
					; PrintScriptText+93p ...

arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		mov	ax, [bp+arg_0]	; get character	to print
		cmp	al, 20h
		jnb	short printchr_main ; >= space - jump
		cmp	al, 0Ah
		jnz	short loc_112B4	; 0A = new line

printchr_nl:
		mov	dh, cs:print_LineNum
		inc	dh
		cmp	dh, 25
		jnz	short loc_112A5
		call	ScrollText
		jmp	short loc_112AA
; ---------------------------------------------------------------------------

loc_112A5:				; CODE XREF: PrintChar+18j
		inc	cs:print_LineNum

loc_112AA:				; CODE XREF: PrintChar+1Dj
					; PrintChar+3Aj ...
		xor	al, al

loc_112AC:				; CODE XREF: PrintChar+4Bj
					; PrintChar+4Fj
		mov	cs:print_upperByte, al
		xor	ax, ax
		pop	bp
		retn
; ---------------------------------------------------------------------------

loc_112B4:				; CODE XREF: PrintChar+Cj
		cmp	al, 0Dh		; 0D = carriage	return
		jnz	short printchr_main

printchr_cr:
		mov	al, cs:print_XStart
		mov	cs:print_XPos, al ; reset character X position
		jmp	short loc_112AA
; ---------------------------------------------------------------------------

printchr_main:				; CODE XREF: PrintChar+8j
					; PrintChar+30j
		mov	ah, cs:print_upperByte
		or	ah, ah
		jnz	short loc_112D7	; upper	byte set - continue (processing	2-byte character)
		cmp	al, 7Fh
		jb	short loc_112D7	; 20h..7Eh (ASCII character) - process
		cmp	al, 0E0h
		jnb	short loc_112AC	; 0E0h..0FFh - store upper byte
		cmp	al, 0A0h
		jb	short loc_112AC	; 080h..09Fh - store upper byte

loc_112D7:				; CODE XREF: PrintChar+43j
					; PrintChar+47j
		mov	dx, 1		; DX = 1 -> full-width
		or	ah, ah
		jnz	short print_shiftjis ; multibyte-charcter - jump
		cmp	al, 20h
		ja	short loc_112F1	; 21h and higher - jump
		jz	short loc_112E9	; 20h (space) -	jump

loc_112E4:				; CODE XREF: PrintChar+79j
		mov	ax, 0FFFFh
		jmp	short loc_112AA	; invalid character (00h..1Fh) - return
; ---------------------------------------------------------------------------

loc_112E9:				; CODE XREF: PrintChar+5Cj
		mov	ax, 8640h	; 20h =	space -> 8460h = Shift-JIS "non-breaking space"
		xor	dx, dx		; DX = 0 -> half-width
		jmp	short print_shiftjis
; ---------------------------------------------------------------------------
		nop

loc_112F1:				; CODE XREF: PrintChar+5Aj
		add	ax, 851Fh	; 21h..5Fh ASCII -> 8540h..857Eh (mirror of ASCII characters)
		cmp	ax, 857Fh
		jb	short loc_112FA
		inc	ax		; 60h..7Fh ASCII -> 8580h..859Fh

loc_112FA:				; CODE XREF: PrintChar+71j
		xor	dx, dx		; DX = 0 -> half-width

print_shiftjis:				; CODE XREF: PrintChar+56j
					; PrintChar+68j
		sub	ax, 8140h	; AX = Shift-JIS character
		jb	short loc_112E4
		cmp	al, 40h
		jb	short loc_11307
		dec	al

loc_11307:				; CODE XREF: PrintChar+7Dj
		cmp	ah, 5Fh
		jb	short loc_1130F
		sub	ah, 40h

loc_1130F:				; CODE XREF: PrintChar+84j
		shl	ah, 1
		inc	ah
		cmp	al, 5Eh
		jb	short loc_1131B
		inc	ah
		sub	al, 5Eh

loc_1131B:				; CODE XREF: PrintChar+8Fj
		add	al, 21h
		mov	cx, ax		; CX = raw JIS character
		xor	ax, ax
		mov	al, cs:print_LineNum
		mov	dx, 50h
		mul	dx
		xor	dh, dh
		mov	dl, cs:print_XPos
		cmp	dl, 50h
		jz	short loc_1133F
		cmp	dl, 4Fh
		jnz	short loc_11366
		or	cx, cx
		jz	short loc_11366

loc_1133F:				; CODE XREF: PrintChar+AEj
		mov	dl, cs:print_XStart ; break line after 80 characters
		mov	cs:print_XPos, dl
		mov	dh, cs:print_LineNum
		inc	dh
		cmp	dh, 25
		jnz	short loc_1135C
		call	ScrollText
		xor	dh, dh
		jmp	short loc_11366
; ---------------------------------------------------------------------------

loc_1135C:				; CODE XREF: PrintChar+CDj
		mov	cs:print_LineNum, dh
		xor	dh, dh
		add	dx, 50h

loc_11366:				; CODE XREF: PrintChar+B3j
					; PrintChar+B7j ...
		add	ax, dx
		shl	ax, 1
		mov	bx, ax
		mov	dl, cs:byte_113E2
		shl	dl, 1
		shl	dl, 1
		shl	dl, 1
		shl	dl, 1
		shl	dl, 1
		or	dl, 1
		or	ch, ch
		mov	ax, 0A000h
		mov	es, ax
		assume es:nothing
		jz	short loc_113B4
		mov	es:[bx], ch
		inc	bx
		mov	es:[bx], cl
		inc	bx
		or	ch, 80h
		mov	es:[bx], ch
		inc	bx
		mov	es:[bx], cl
		mov	ax, 0A200h
		mov	es, ax
		assume es:nothing
		sub	bx, 3
		mov	es:[bx], dl
		add	bx, 2
		mov	es:[bx], dl
		mov	ax, 2
		add	cs:print_XPos, al
		jmp	short loc_113CC
; ---------------------------------------------------------------------------

loc_113B4:				; CODE XREF: PrintChar+FFj
		mov	es:[bx], ch
		inc	bx
		mov	es:[bx], cl
		mov	ax, 0A200h
		mov	es, ax
		dec	bx
		mov	es:[bx], dl
		inc	cs:print_XPos
		mov	ax, 1

loc_113CC:				; CODE XREF: PrintChar+12Cj
		cmp	cs:print_upperByte, 81h
		jnz	short loc_113D6
		xor	ax, ax

loc_113D6:				; CODE XREF: PrintChar+14Cj
		mov	cs:print_upperByte, 0
		pop	bp
		retn
PrintChar	endp

; ---------------------------------------------------------------------------
print_XPos	db 0			; DATA XREF: PrintChar+36w
					; PrintChar+A6r ...
print_LineNum	db 0			; DATA XREF: PrintChar:printchr_nlr
					; PrintChar:loc_112A5w	...
print_XStart	db 0			; DATA XREF: PrintChar:printchr_crr
					; PrintChar:loc_1133Fr	...
print_upperByte	db 0			; DATA XREF: PrintChar:loc_112ACw
					; PrintChar:printchr_mainr ...
byte_113E2	db 0			; DATA XREF: PrintChar+E6r
					; sub_113F6+6w

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_113E3	proc near		; CODE XREF: sub_105DC+32p

arg_0		= word ptr  4
arg_2		= word ptr  6

		push	bp
		mov	bp, sp
		mov	ax, [bp+arg_0]
		mov	cs:print_XPos, al
		mov	ax, [bp+arg_2]
		mov	cs:print_LineNum, al
		pop	bp
		retn
sub_113E3	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_113F6	proc near		; CODE XREF: sub_1083E+1Ep
					; sub_1083E+3Cp ...

arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		mov	ax, [bp+arg_0]
		mov	cs:byte_113E2, al
		pop	bp
		retn
sub_113F6	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

Print_StartLine	proc near		; CODE XREF: PrintScriptText+Fp
					; PrintScriptText+89p

arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		mov	ax, [bp+arg_0]
		mov	cs:print_XStart, al
		pop	bp
		retn
Print_StartLine	endp


; =============== S U B	R O U T	I N E =======================================


ScrollText	proc near		; CODE XREF: PrintChar+1Ap
					; PrintChar+CFp
		push	ax
		push	cx
		push	si
		push	di
		push	ds
		push	es
		mov	ax, 0A000h
		mov	ds, ax
		assume ds:nothing
		mov	es, ax
		assume es:nothing
		mov	di, 0D20h
		mov	si, 0DC0h
		mov	cx, 0F0h
		rep movsw
		mov	ax, 20h
		mov	cx, 50h
		rep stosw
		mov	ax, 0A200h
		mov	ds, ax
		assume ds:nothing
		mov	es, ax
		assume es:nothing
		mov	di, 0D20h
		mov	si, 0DC0h
		mov	cx, 0F0h
		rep movsw
		mov	ax, 0E1h
		mov	cx, 80h
		rep stosw
		pop	es
		assume es:nothing
		pop	ds
		assume ds:nothing
		pop	di
		pop	si
		pop	cx
		pop	ax
		retn
ScrollText	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

PrintCString	proc near		; CODE XREF: sub_1083E+32p
					; sub_10BB2+254p ...

arg_0		= dword	ptr  4

		push	bp
		mov	bp, sp
		push	ds
		push	si
		mov	cs:print_upperByte, 0
		lds	si, [bp+arg_0]

loc_1145D:				; CODE XREF: PrintCString+1Aj
		lodsb
		or	al, al
		jz	short loc_1146B	; read until reaching a	00 byte	(terminates the	string)
		push	ax
		call	PrintChar
		add	sp, 2
		jmp	short loc_1145D
; ---------------------------------------------------------------------------

loc_1146B:				; CODE XREF: PrintCString+11j
		pop	si
		pop	ds
		pop	bp
		retn
PrintCString	endp


; =============== S U B	R O U T	I N E =======================================


sub_1146F	proc near		; CODE XREF: sub_10BB2+265p
		push	di
		push	es
		mov	dx, 9Ch	; 'œ'
		mov	bx, 2DDBh

loc_11477:				; CODE XREF: sub_1146F+45j
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		mov	cx, 8
		mov	di, bx
		xor	ax, ax
		rep stosw
		mov	ax, 0B000h
		mov	es, ax
		assume es:nothing
		mov	cx, 8
		mov	di, bx
		xor	ax, ax
		rep stosw
		mov	ax, 0B800h
		mov	es, ax
		assume es:nothing
		mov	cx, 8
		mov	di, bx
		mov	ax, 0FFFFh
		rep stosw
		mov	ax, 0E000h
		mov	es, ax
		assume es:nothing
		mov	cx, 8
		mov	di, bx
		xor	ax, ax
		rep stosw
		add	bx, 50h	; 'P'
		dec	dx
		jnz	short loc_11477
		pop	es
		assume es:nothing
		pop	di
		retn
sub_1146F	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_114B9	proc near		; CODE XREF: sub_10656+1Bp
					; sub_10656+5Dp

arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		push	si
		push	di
		push	ds
		push	es
		mov	ax, [bp+arg_0]
		or	ax, ax
		jnz	short loc_114CF
		mov	al, cs:byte_11529
		or	al, al
		jz	short loc_11523

loc_114CF:				; CODE XREF: sub_114B9+Cj
		mov	cs:byte_11529, al
		dec	ax
		mov	bx, 5A0h
		mul	bx
		add	ax, 2FBBh
		mov	si, ax
		mov	dx, 10h

loc_114E1:				; CODE XREF: sub_114B9+68j
		mov	ax, 0A800h
		mov	ds, ax
		assume ds:nothing
		mov	es, ax
		assume es:nothing
		mov	di, si
		mov	cx, 8

loc_114ED:				; CODE XREF: sub_114B9+38j
		lodsw
		not	ax
		stosw
		loop	loc_114ED
		mov	ax, 0B000h
		mov	ds, ax
		assume ds:nothing
		mov	es, ax
		assume es:nothing
		sub	si, 10h
		mov	di, si
		mov	cx, 8

loc_11502:				; CODE XREF: sub_114B9+4Dj
		lodsw
		not	ax
		stosw
		loop	loc_11502
		mov	ax, 0E000h
		mov	ds, ax
		assume ds:nothing
		mov	es, ax
		assume es:nothing
		sub	si, 10h
		mov	di, si
		mov	cx, 8

loc_11517:				; CODE XREF: sub_114B9+62j
		lodsw
		not	ax
		stosw
		loop	loc_11517
		add	si, 40h	; '@'
		dec	dx
		jnz	short loc_114E1

loc_11523:				; CODE XREF: sub_114B9+14j
		pop	es
		assume es:nothing
		pop	ds
		assume ds:nothing
		pop	di
		pop	si
		pop	bp
		retn
sub_114B9	endp

; ---------------------------------------------------------------------------
byte_11529	db 0			; DATA XREF: sub_114B9+Er
					; sub_114B9:loc_114CFw

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1152A	proc near		; CODE XREF: sub_101F6+26Ep

arg_0		= word ptr  4
arg_2		= dword	ptr  6

		push	bp
		mov	bp, sp
		call	sub_1106C
		push	ds
		push	si
		lds	si, [bp+arg_2]
		mov	ax, [bp+arg_0]
		sub	ax, 2000h
		out	0A1h, al	; Interrupt Controller #2, 8259A
		mov	al, ah
		out	0A3h, al	; Interrupt Controller #2, 8259A
		xor	bx, bx
		mov	cx, 10h

loc_11546:				; CODE XREF: sub_1152A+2Ej
		mov	al, bl
		or	al, 20h
		out	0A5h, al	; Interrupt Controller #2, 8259A
		lodsw
		out	0A9h, al	; Interrupt Controller #2, 8259A
		mov	al, bl
		out	0A5h, al	; Interrupt Controller #2, 8259A
		mov	al, ah
		out	0A9h, al	; Interrupt Controller #2, 8259A
		inc	bx
		loop	loc_11546
		pop	si
		pop	ds
		call	sub_11071
		pop	bp
		retn
sub_1152A	endp

; ---------------------------------------------------------------------------
		push	ax
		mov	al, 20h	; ' '
		out	0, al
		out	64h, al		; 8042 keyboard	controller command register.
					; Read command byte:
					; 7:	      (reserved)
					; 6:  XLAT    convert Set 2 scancodes to Set 1 (IBM PC compatibility mode)
					; 5:  XT      1=translate codes	like XT	keyboard, 0=like AT
					; 4:  _EN     1=disable	keyboard
					; 3:  OVR     1=override inhibit keyswitch
					; 2:  SYS     System Flag (0=cold reboot, 1=warm reboot)
					; 1:	      (reserved)
					; 0:  INT     enables IRQ 1 interrupt on keyboard IBF
					;
		sti
		cmp	cs:word_11578, 0
		jz	short loc_11576
		dec	cs:word_11578

loc_11576:				; CODE XREF: seg000:156Fj
		pop	ax
		iret
; ---------------------------------------------------------------------------
word_11578	dw 0			; DATA XREF: seg000:1569r seg000:1571w ...

; =============== S U B	R O U T	I N E =======================================


sub_1157A	proc near		; CODE XREF: sub_101F6+8Ap
		call	sub_10F50
		mov	cs:word_1161D, ax
		push	ds
		push	es
		mov	ax, 350Ah
		int	21h		; DOS -	2+ - GET INTERRUPT VECTOR
					; AL = interrupt number
					; Return: ES:BX	= value	of interrupt vector
		cmp	bx, 1561h
		jnz	short loc_11596
		mov	ax, es
		mov	dx, cs
		cmp	ax, dx
		jz	short loc_115E2

loc_11596:				; CODE XREF: sub_1157A+12j
		mov	word ptr cs:dword_11895, bx
		mov	word ptr cs:dword_11895+2, es
		mov	ax, cs
		mov	ds, ax
		assume ds:seg000
		mov	dx, 1561h
		mov	ax, 250Ah
		int	21h		; DOS -	SET INTERRUPT VECTOR
					; AL = interrupt number
					; DS:DX	= new vector to	be used	for specified interrupt
		mov	ax, 3518h
		int	21h		; DOS -	2+ - GET INTERRUPT VECTOR
					; AL = interrupt number
					; Return: ES:BX	= value	of interrupt vector
		mov	word ptr cs:dword_11899, bx
		mov	word ptr cs:dword_11899+2, es
		mov	ax, cs
		mov	ds, ax
		mov	dx, 15EFh
		mov	ax, 2518h
		int	21h		; DOS -	SET INTERRUPT VECTOR
					; AL = interrupt number
					; DS:DX	= new vector to	be used	for specified interrupt
		mov	ax, 3506h
		int	21h		; DOS -	2+ - GET INTERRUPT VECTOR
					; AL = interrupt number
					; Return: ES:BX	= value	of interrupt vector
		mov	word ptr cs:dword_1189D, bx
		mov	word ptr cs:dword_1189D+2, es
		mov	ax, cs
		mov	ds, ax
		mov	dx, 15F8h
		mov	ax, 2506h
		int	21h		; DOS -	SET INTERRUPT VECTOR
					; AL = interrupt number
					; DS:DX	= new vector to	be used	for specified interrupt

loc_115E2:				; CODE XREF: sub_1157A+1Aj
		pop	es
		pop	ds
		assume ds:nothing
		in	al, 2		; DMA controller, 8237A-5.
					; channel 1 current address
		and	al, 0FBh
		out	2, al		; DMA controller, 8237A-5.
					; channel 1 base address
					; (also	sets current address)
		out	64h, al		; 8042 keyboard	controller command register.
		xor	ax, ax
		retn
sub_1157A	endp

; ---------------------------------------------------------------------------
		pushf
		call	cs:dword_11899
		out	64h, al		; 8042 keyboard	controller command register.
		iret
; ---------------------------------------------------------------------------
		push	ax
		push	ds
		xor	ax, ax
		mov	ds, ax
		assume ds:nothing
		test	byte ptr ds:538h, 10h
		jnz	short loc_11613
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		mov	word_1205C, 0
		pop	ds
		assume ds:nothing
		pop	ax
		iret
; ---------------------------------------------------------------------------

loc_11613:				; CODE XREF: seg000:1603j
		mov	cs:word_1161F, 0FFFFh
		pop	ds
		pop	ax
		iret
; ---------------------------------------------------------------------------
word_1161D	dw 0			; DATA XREF: sub_1157A+3w
					; sub_11665+1Br
word_1161F	dw 0			; DATA XREF: seg000:loc_11613w
					; sub_11665+13r

; =============== S U B	R O U T	I N E =======================================


sub_11621	proc near		; CODE XREF: sub_11665:loc_11692p
		push	ds
		push	es
		mov	ax, 350Ah
		int	21h		; DOS -	2+ - GET INTERRUPT VECTOR
					; AL = interrupt number
					; Return: ES:BX	= value	of interrupt vector
		cmp	bx, 1561h
		jnz	short loc_11654
		mov	ax, es
		mov	dx, cs
		cmp	ax, dx
		jnz	short loc_11654
		lds	dx, cs:dword_11895
		mov	ax, 250Ah
		int	21h		; DOS -	SET INTERRUPT VECTOR
					; AL = interrupt number
					; DS:DX	= new vector to	be used	for specified interrupt
		lds	dx, cs:dword_11899
		mov	ax, 2518h
		int	21h		; DOS -	SET INTERRUPT VECTOR
					; AL = interrupt number
					; DS:DX	= new vector to	be used	for specified interrupt
		lds	dx, cs:dword_1189D
		mov	ax, 2506h
		int	21h		; DOS -	SET INTERRUPT VECTOR
					; AL = interrupt number
					; DS:DX	= new vector to	be used	for specified interrupt

loc_11654:				; CODE XREF: sub_11621+Bj
					; sub_11621+13j
		pop	es
		pop	ds
		out	64h, al		; 8042 keyboard	controller command register.
		retn
sub_11621	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_11659	proc near		; CODE XREF: PrintScriptText+3Ep
					; sub_10A40+Ap	...

arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		mov	ax, [bp+arg_0]
		mov	cs:word_11578, ax
		pop	bp
		retn
sub_11659	endp


; =============== S U B	R O U T	I N E =======================================


sub_11665	proc near		; CODE XREF: PrintScriptText:loc_10917p
					; sub_10A40+21p ...
		push	ds
		xor	ax, ax
		mov	ds, ax
		assume ds:nothing

loc_1166A:				; CODE XREF: sub_11665+29j
		test	byte ptr ds:530h, 10h
		jnz	short loc_11690
		test	byte ptr ds:538h, 1
		jnz	short loc_11690
		cmp	cs:word_1161F, 0FFFFh
		jnz	short loc_11688
		cmp	cs:word_1161D, 0FFFFh
		jz	short loc_11692

loc_11688:				; CODE XREF: sub_11665+19j
		cmp	cs:word_11578, 0
		jnz	short loc_1166A

loc_11690:				; CODE XREF: sub_11665+Aj
					; sub_11665+11j
		pop	ds
		assume ds:nothing
		retn
; ---------------------------------------------------------------------------

loc_11692:				; CODE XREF: sub_11665+21j
		call	sub_11621
		mov	ax, 4C00h
		int	21h		; DOS -	2+ - QUIT WITH EXIT CODE (EXIT)
sub_11665	endp			; AL = exit code


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1169A	proc near		; CODE XREF: sub_10BB2+2BEp

arg_0		= dword	ptr  4

		push	bp
		mov	bp, sp
		push	si
		push	di
		push	ds
		push	es
		les	ax, [bp+arg_0]
		mov	word ptr cs:dword_117BC, ax
		mov	word ptr cs:dword_117BC+2, es
		mov	cs:word_117BA, 4Ah ; 'J'
		cld

loc_116B5:				; CODE XREF: sub_1169A+117j
		mov	dx, 124h
		mov	bx, 643h
		mov	bp, 503h

loc_116BE:				; CODE XREF: sub_1169A+73j
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		mov	ds, ax
		assume ds:nothing
		mov	si, bx
		mov	di, bp
		mov	cx, 19h
		movsb
		rep movsw
		movsb
		mov	ax, 0B000h
		mov	es, ax
		assume es:nothing
		mov	ds, ax
		assume ds:nothing
		mov	si, bx
		mov	di, bp
		mov	cx, 19h
		movsb
		rep movsw
		movsb
		mov	ax, 0B800h
		mov	es, ax
		assume es:nothing
		mov	ds, ax
		assume ds:nothing
		mov	si, bx
		mov	di, bp
		mov	cx, 19h
		movsb
		rep movsw
		movsb
		mov	ax, 0E000h
		mov	es, ax
		assume es:nothing
		mov	ds, ax
		assume ds:nothing
		mov	si, bx
		mov	di, bp
		mov	cx, 19h
		movsb
		rep movsw
		movsb
		add	bx, 50h	; 'P'
		add	bp, 50h	; 'P'
		dec	dx
		jnz	short loc_116BE
		lds	si, cs:dword_117BC
		assume ds:nothing
		mov	di, bp
		mov	cx, 34h	; '4'

loc_11719:				; CODE XREF: sub_1169A+9Aj
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		movsb
		dec	di
		mov	ax, 0B000h
		mov	es, ax
		assume es:nothing
		movsb
		dec	di
		mov	ax, 0B800h
		mov	es, ax
		assume es:nothing
		movsb
		dec	di
		mov	ax, 0E000h
		mov	es, ax
		assume es:nothing
		movsb
		loop	loc_11719
		add	bp, 50h	; 'P'
		mov	di, bp
		mov	cx, 34h	; '4'

loc_1173E:				; CODE XREF: sub_1169A+BFj
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		movsb
		dec	di
		mov	ax, 0B000h
		mov	es, ax
		assume es:nothing
		movsb
		dec	di
		mov	ax, 0B800h
		mov	es, ax
		assume es:nothing
		movsb
		dec	di
		mov	ax, 0E000h
		mov	es, ax
		assume es:nothing
		movsb
		loop	loc_1173E
		add	bp, 50h	; 'P'
		mov	di, bp
		mov	cx, 34h	; '4'

loc_11763:				; CODE XREF: sub_1169A+E4j
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		movsb
		dec	di
		mov	ax, 0B000h
		mov	es, ax
		assume es:nothing
		movsb
		dec	di
		mov	ax, 0B800h
		mov	es, ax
		assume es:nothing
		movsb
		dec	di
		mov	ax, 0E000h
		mov	es, ax
		assume es:nothing
		movsb
		loop	loc_11763
		add	bp, 50h	; 'P'
		mov	di, bp
		mov	cx, 34h	; '4'

loc_11788:				; CODE XREF: sub_1169A+109j
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		movsb
		dec	di
		mov	ax, 0B000h
		mov	es, ax
		assume es:nothing
		movsb
		dec	di
		mov	ax, 0B800h
		mov	es, ax
		assume es:nothing
		movsb
		dec	di
		mov	ax, 0E000h
		mov	es, ax
		assume es:nothing
		movsb
		loop	loc_11788
		mov	word ptr cs:dword_117BC, si
		dec	cs:word_117BA
		jz	short loc_117B4
		jmp	loc_116B5
; ---------------------------------------------------------------------------

loc_117B4:				; CODE XREF: sub_1169A+115j
		pop	es
		assume es:nothing
		pop	ds
		pop	di
		pop	si
		pop	bp
		retn
sub_1169A	endp

; ---------------------------------------------------------------------------
word_117BA	dw 0			; DATA XREF: sub_1169A+13w
					; sub_1169A+110w
dword_117BC	dd 0			; DATA XREF: sub_1169A+Aw
					; sub_1169A+75r ...

; =============== S U B	R O U T	I N E =======================================


sub_117C0	proc near		; CODE XREF: sub_10500+8Fp
					; sub_10500+99p
		push	ds
		push	si
		mov	ax, cs
		mov	ds, ax
		assume ds:seg000
		mov	ax, 1
		out	6Ah, al
		xor	bh, bh

loc_117CD:				; CODE XREF: sub_117C0+5Ej
		mov	si, 1CC4h
		xor	bl, bl
		mov	cx, 10h
		mov	cs:word_11578, 2

loc_117DC:				; CODE XREF: sub_117C0+22j
		cmp	cs:word_11578, 0
		jnz	short loc_117DC

loc_117E4:				; CODE XREF: sub_117C0+57j
		mov	al, bl
		out	0A8h, al	; Interrupt Controller #2, 8259A
		xor	ax, ax
		lodsb
		mul	bh
		shr	al, 1
		shr	al, 1
		shr	al, 1
		shr	al, 1
		out	0AAh, al	; Interrupt Controller #2, 8259A
		xor	ax, ax
		lodsb
		mul	bh
		shr	al, 1
		shr	al, 1
		shr	al, 1
		shr	al, 1
		out	0ACh, al	; Interrupt Controller #2, 8259A
		xor	ax, ax
		lodsb
		mul	bh
		shr	al, 1
		shr	al, 1
		shr	al, 1
		shr	al, 1
		out	0AEh, al	; Interrupt Controller #2, 8259A
		inc	bl
		loop	loc_117E4
		inc	bh
		cmp	bh, 11h
		jb	short loc_117CD
		pop	si
		pop	ds
		assume ds:nothing
		retn
sub_117C0	endp


; =============== S U B	R O U T	I N E =======================================


sub_11823	proc near		; CODE XREF: sub_10500+2Dp
					; sub_10500+37p ...
		push	ds
		push	si
		mov	ax, cs
		mov	ds, ax
		assume ds:seg000
		mov	ax, 1
		out	6Ah, al
		mov	bh, 11h

loc_11830:				; CODE XREF: sub_11823+5Dj
		dec	bh
		jz	short loc_11882
		mov	si, 1CC4h
		xor	bl, bl
		mov	cx, 10h
		mov	cs:word_11578, 2

loc_11843:				; CODE XREF: sub_11823+26j
		cmp	cs:word_11578, 0
		jnz	short loc_11843

loc_1184B:				; CODE XREF: sub_11823+5Bj
		mov	al, bl
		out	0A8h, al	; Interrupt Controller #2, 8259A
		xor	ax, ax
		lodsb
		mul	bh
		shr	al, 1
		shr	al, 1
		shr	al, 1
		shr	al, 1
		out	0AAh, al	; Interrupt Controller #2, 8259A
		xor	ax, ax
		lodsb
		mul	bh
		shr	al, 1
		shr	al, 1
		shr	al, 1
		shr	al, 1
		out	0ACh, al	; Interrupt Controller #2, 8259A
		xor	ax, ax
		lodsb
		mul	bh
		shr	al, 1
		shr	al, 1
		shr	al, 1
		shr	al, 1
		out	0AEh, al	; Interrupt Controller #2, 8259A
		inc	bl
		loop	loc_1184B
		jmp	short loc_11830
; ---------------------------------------------------------------------------

loc_11882:				; CODE XREF: sub_11823+Fj
		pop	si
		pop	ds
		assume ds:nothing
		retn
sub_11823	endp


; =============== S U B	R O U T	I N E =======================================


sub_11885	proc near		; CODE XREF: sub_105DC:loc_10622p
					; sub_105DC:loc_1062Cp	...
		xor	ah, ah
		int	18h
		retn
sub_11885	endp


; =============== S U B	R O U T	I N E =======================================


sub_1188A	proc near		; CODE XREF: sub_105DC:loc_10625p
					; sub_10656:loc_10663p	...
		mov	ah, 1
		int	18h
		or	bh, bh
		jnz	short locret_11894
		xor	ax, ax

locret_11894:				; CODE XREF: sub_1188A+6j
		retn
sub_1188A	endp

; ---------------------------------------------------------------------------
dword_11895	dd 0			; DATA XREF: sub_1157A:loc_11596w
					; sub_11621+15r ...
dword_11899	dd 0			; DATA XREF: sub_1157A+37w
					; seg000:15F0r	...
dword_1189D	dd 0			; DATA XREF: sub_1157A+52w
					; sub_11621+29r ...

; =============== S U B	R O U T	I N E =======================================


sub_118A1	proc near		; CODE XREF: seg000:1BBBp sub_11BF6+Bp ...
		push	di
		push	es
		cld
		lodsw
		cmp	ax, 4350h
		jnz	short loc_118F1
		lodsb
		xor	ah, ah
		sub	al, 38h	; '8'
		push	ax
		jb	short loc_118F1
		jz	short loc_118F1
		inc	si
		lodsw
		mov	bx, 50h	; 'P'
		mul	bx
		mov	bx, ax
		lodsw
		add	bx, ax
		lodsw
		mov	dx, ax
		lodsw
		mov	cx, ax
		add	si, 4
		push	cx
		mov	cx, 10h
		mov	ax, cs
		mov	es, ax
		assume es:seg000
		mov	di, 1C94h

loc_118D4:				; CODE XREF: sub_118A1+49j
		lodsw
		push	ax
		and	al, 0F0h
		shr	al, 1
		shr	al, 1
		shr	al, 1
		shr	al, 1
		stosb
		pop	ax
		and	al, 0Fh
		stosb
		mov	al, ah
		and	al, 0Fh
		stosb
		loop	loc_118D4
		pop	cx
		pop	ax

loc_118EE:				; CODE XREF: sub_118A1+54j
		pop	es
		assume es:nothing
		pop	di
		retn
; ---------------------------------------------------------------------------

loc_118F1:				; CODE XREF: sub_118A1+7j sub_118A1+Fj ...
		pop	ax
		mov	ax, 0FFFFh
		jmp	short loc_118EE
sub_118A1	endp ; sp-analysis failed


; =============== S U B	R O U T	I N E =======================================


sub_118F7	proc near		; CODE XREF: seg000:1BE6p
		push	bx
		push	cx
		push	si
		push	ds
		mov	ax, cs
		mov	ds, ax
		assume ds:seg000
		mov	si, 1C94h
		mov	ax, 1
		out	6Ah, al
		mov	bx, 500h
		mov	cx, 10h
		cmp	cs:byte_11C92, 1
		jz	short loc_11917
		mov	cl, 8

loc_11917:				; CODE XREF: sub_118F7+1Cj
					; sub_118F7+2Ej
		mov	al, bl
		out	0A8h, al	; Interrupt Controller #2, 8259A
		lodsb
		out	0AAh, al	; Interrupt Controller #2, 8259A
		lodsb
		out	0ACh, al	; Interrupt Controller #2, 8259A
		lodsb
		out	0AEh, al	; Interrupt Controller #2, 8259A
		inc	bx
		loop	loc_11917
		pop	ds
		assume ds:nothing
		pop	si
		pop	cx
		pop	bx
		retn
sub_118F7	endp


; =============== S U B	R O U T	I N E =======================================


sub_1192C	proc near		; CODE XREF: seg000:1BE9p
					; sub_11BF6+1Bp ...
		push	di
		push	es
		push	bp
		mov	di, bx
		mov	dl, 8
		lodsb
		mov	dh, al
		cmp	cs:byte_11C92, 1
		jz	short loc_1199C

loc_1193E:				; CODE XREF: sub_1192C+6Ej
		pop	bp
		pop	es
		pop	di
		retn
; ---------------------------------------------------------------------------

loc_11942:				; CODE XREF: sub_1192C:loc_119A8j
		mov	bx, di
		sub	bx, 0A0h ; ' '
		xchg	si, bx
		mov	bp, 0A800h
		mov	es, bp
		assume es:nothing
		movs	byte ptr es:[di], byte ptr es:[si]
		dec	si
		dec	di
		mov	bp, 0B000h
		mov	es, bp
		assume es:nothing
		movs	byte ptr es:[di], byte ptr es:[si]
		dec	si
		dec	di
		mov	bp, 0B800h
		mov	es, bp
		assume es:nothing
		movs	byte ptr es:[di], byte ptr es:[si]
		dec	si
		dec	di
		mov	bp, 0E000h
		mov	es, bp
		assume es:nothing
		movs	byte ptr es:[di], byte ptr es:[si]
		xchg	si, bx
		jmp	short loc_1198B
; ---------------------------------------------------------------------------

loc_11970:				; CODE XREF: sub_1192C:loc_119B5j
		mov	bp, 0A800h
		mov	es, bp
		assume es:nothing
		movsb
		dec	di
		mov	bp, 0B000h
		mov	es, bp
		assume es:nothing
		movsb
		dec	di
		mov	bp, 0B800h
		mov	es, bp
		assume es:nothing
		movsb
		dec	di
		mov	bp, 0E000h
		mov	es, bp
		assume es:nothing
		movsb

loc_1198B:				; CODE XREF: sub_1192C+42j
					; sub_1192C:loc_11A87j
		mov	bx, di
		loop	loc_1199D
		pop	cx
		sub	di, cx
		add	di, 50h	; 'P'
		dec	cs:word_11C90
		jz	short loc_1193E

loc_1199C:				; CODE XREF: sub_1192C+10j
		push	cx

loc_1199D:				; CODE XREF: sub_1192C+61j
		shl	dh, 1
		dec	dl
		jnz	short loc_119A8
		lodsb
		mov	dh, al
		mov	dl, 8

loc_119A8:				; CODE XREF: sub_1192C+75j
		jb	short loc_11942
		shl	dh, 1
		dec	dl
		jnz	short loc_119B5
		lodsb
		mov	dh, al
		mov	dl, 8

loc_119B5:				; CODE XREF: sub_1192C+82j
		jb	short loc_11970
		xor	ah, ah
		shl	dh, 1
		dec	dl
		jnz	short loc_119C4
		lodsb
		mov	dh, al
		mov	dl, 8

loc_119C4:				; CODE XREF: sub_1192C+91j
		rcl	ah, 1
		shl	dh, 1
		dec	dl
		jnz	short loc_119D1
		lodsb
		mov	dh, al
		mov	dl, 8

loc_119D1:				; CODE XREF: sub_1192C+9Ej
		rcl	ah, 1
		shl	dh, 1
		dec	dl
		jnz	short loc_119DE
		lodsb
		mov	dh, al
		mov	dl, 8

loc_119DE:				; CODE XREF: sub_1192C+ABj
		rcl	ah, 1
		shl	dh, 1
		dec	dl
		jnz	short loc_119EB
		lodsb
		mov	dh, al
		mov	dl, 8

loc_119EB:				; CODE XREF: sub_1192C+B8j
		rcl	ah, 1
		or	ah, ah
		jz	short loc_11A0E
		cmp	ah, 0Fh
		jz	short loc_11A28
		shl	dh, 1
		dec	dl
		jnz	short loc_11A01
		lodsb
		mov	dh, al
		mov	dl, 8

loc_11A01:				; CODE XREF: sub_1192C+CEj
		jb	short loc_11A0B
		mov	bx, di
		sub	bx, 0A0h ; ' '
		jmp	short loc_11A40
; ---------------------------------------------------------------------------

loc_11A0B:				; CODE XREF: sub_1192C:loc_11A01j
		dec	bx
		jmp	short loc_11A40
; ---------------------------------------------------------------------------

loc_11A0E:				; CODE XREF: sub_1192C+C3j
		mov	bx, di
		sub	bx, 50h	; 'P'
		shl	dh, 1
		dec	dl
		jnz	short loc_11A1E
		lodsb
		mov	dh, al
		mov	dl, 8

loc_11A1E:				; CODE XREF: sub_1192C+EBj
		jb	short loc_11A24
		mov	ah, 0Eh
		jmp	short loc_11A40
; ---------------------------------------------------------------------------

loc_11A24:				; CODE XREF: sub_1192C:loc_11A1Ej
		mov	ah, 0Bh
		jmp	short loc_11A40
; ---------------------------------------------------------------------------

loc_11A28:				; CODE XREF: sub_1192C+C8j
		mov	bx, di
		sub	bx, 50h	; 'P'
		shl	dh, 1
		dec	dl
		jnz	short loc_11A38
		lodsb
		mov	dh, al
		mov	dl, 8

loc_11A38:				; CODE XREF: sub_1192C+105j
		jb	short loc_11A3E
		mov	ah, 0Dh
		jmp	short loc_11A40
; ---------------------------------------------------------------------------

loc_11A3E:				; CODE XREF: sub_1192C:loc_11A38j
		mov	ah, 7

loc_11A40:				; CODE XREF: sub_1192C+DDj
					; sub_1192C+E0j ...
		mov	bp, 0A800h
		mov	es, bp
		assume es:nothing
		test	ah, 8
		jnz	short loc_11A4D
		movsb
		jmp	short loc_11A51
; ---------------------------------------------------------------------------

loc_11A4D:				; CODE XREF: sub_1192C+11Cj
		mov	al, es:[bx]
		stosb

loc_11A51:				; CODE XREF: sub_1192C+11Fj
		dec	di
		mov	bp, 0B000h
		mov	es, bp
		assume es:nothing
		test	ah, 4
		jnz	short loc_11A5F
		movsb
		jmp	short loc_11A63
; ---------------------------------------------------------------------------

loc_11A5F:				; CODE XREF: sub_1192C+12Ej
		mov	al, es:[bx]
		stosb

loc_11A63:				; CODE XREF: sub_1192C+131j
		dec	di
		mov	bp, 0B800h
		mov	es, bp
		assume es:nothing
		test	ah, 2
		jnz	short loc_11A71
		movsb
		jmp	short loc_11A75
; ---------------------------------------------------------------------------

loc_11A71:				; CODE XREF: sub_1192C+140j
		mov	al, es:[bx]
		stosb

loc_11A75:				; CODE XREF: sub_1192C+143j
		dec	di
		mov	bp, 0E000h
		mov	es, bp
		assume es:nothing
		test	ah, 1
		jnz	short loc_11A83
		movsb
		jmp	short loc_11A87
; ---------------------------------------------------------------------------

loc_11A83:				; CODE XREF: sub_1192C+152j
		mov	al, es:[bx]
		stosb

loc_11A87:				; CODE XREF: sub_1192C+155j
		jmp	loc_1198B
sub_1192C	endp


; =============== S U B	R O U T	I N E =======================================


sub_11A8A	proc near		; CODE XREF: sub_11C60+1Fp
		push	bp
		mov	bx, cx
		shl	bx, 1
		shl	bx, 1
		mov	cs:word_11C8E, bx
		mov	dl, 8
		lodsb
		mov	dh, al
		cmp	cs:byte_11C92, 1
		jz	short loc_11AC6

loc_11AA3:				; CODE XREF: sub_11A8A+3Aj
		pop	bp
		retn
; ---------------------------------------------------------------------------

loc_11AA5:				; CODE XREF: sub_11A8A:loc_11AD2j
		mov	bx, cs:word_11C8E
		shl	bx, 1
		neg	bx
		add	bx, di
		xchg	si, bx
		movs	word ptr es:[di], word ptr es:[si]
		movs	word ptr es:[di], word ptr es:[si]
		xchg	si, bx
		jmp	short loc_11ABC
; ---------------------------------------------------------------------------

loc_11ABA:				; CODE XREF: sub_11A8A:loc_11ADFj
		movsw
		movsw

loc_11ABC:				; CODE XREF: sub_11A8A+2Ej
					; sub_11A8A:loc_11BAEj
		loop	loc_11AC7
		pop	cx
		dec	cs:word_11C90
		jz	short loc_11AA3

loc_11AC6:				; CODE XREF: sub_11A8A+17j
		push	cx

loc_11AC7:				; CODE XREF: sub_11A8A:loc_11ABCj
		shl	dh, 1
		dec	dl
		jnz	short loc_11AD2
		lodsb
		mov	dh, al
		mov	dl, 8

loc_11AD2:				; CODE XREF: sub_11A8A+41j
		jb	short loc_11AA5
		shl	dh, 1
		dec	dl
		jnz	short loc_11ADF
		lodsb
		mov	dh, al
		mov	dl, 8

loc_11ADF:				; CODE XREF: sub_11A8A+4Ej
		jb	short loc_11ABA
		xor	ah, ah
		shl	dh, 1
		dec	dl
		jnz	short loc_11AEE
		lodsb
		mov	dh, al
		mov	dl, 8

loc_11AEE:				; CODE XREF: sub_11A8A+5Dj
		rcl	ah, 1
		shl	dh, 1
		dec	dl
		jnz	short loc_11AFB
		lodsb
		mov	dh, al
		mov	dl, 8

loc_11AFB:				; CODE XREF: sub_11A8A+6Aj
		rcl	ah, 1
		shl	dh, 1
		dec	dl
		jnz	short loc_11B08
		lodsb
		mov	dh, al
		mov	dl, 8

loc_11B08:				; CODE XREF: sub_11A8A+77j
		rcl	ah, 1
		shl	dh, 1
		dec	dl
		jnz	short loc_11B15
		lodsb
		mov	dh, al
		mov	dl, 8

loc_11B15:				; CODE XREF: sub_11A8A+84j
		rcl	ah, 1
		or	ah, ah
		jz	short loc_11B41
		cmp	ah, 0Fh
		jz	short loc_11B5F
		shl	dh, 1
		dec	dl
		jnz	short loc_11B2B
		lodsb
		mov	dh, al
		mov	dl, 8

loc_11B2B:				; CODE XREF: sub_11A8A+9Aj
		jb	short loc_11B3A
		mov	bx, cs:word_11C8E
		shl	bx, 1
		neg	bx
		add	bx, di
		jmp	short loc_11B7B
; ---------------------------------------------------------------------------

loc_11B3A:				; CODE XREF: sub_11A8A:loc_11B2Bj
		mov	bx, di
		sub	bx, 4
		jmp	short loc_11B7B
; ---------------------------------------------------------------------------

loc_11B41:				; CODE XREF: sub_11A8A+8Fj
		mov	bx, cs:word_11C8E
		neg	bx
		add	bx, di
		shl	dh, 1
		dec	dl
		jnz	short loc_11B55
		lodsb
		mov	dh, al
		mov	dl, 8

loc_11B55:				; CODE XREF: sub_11A8A+C4j
		jb	short loc_11B5B
		mov	ah, 0Eh
		jmp	short loc_11B7B
; ---------------------------------------------------------------------------

loc_11B5B:				; CODE XREF: sub_11A8A:loc_11B55j
		mov	ah, 0Bh
		jmp	short loc_11B7B
; ---------------------------------------------------------------------------

loc_11B5F:				; CODE XREF: sub_11A8A+94j
		mov	bx, cs:word_11C8E
		neg	bx
		add	bx, di
		shl	dh, 1
		dec	dl
		jnz	short loc_11B73
		lodsb
		mov	dh, al
		mov	dl, 8

loc_11B73:				; CODE XREF: sub_11A8A+E2j
		jb	short loc_11B79
		mov	ah, 0Dh
		jmp	short loc_11B7B
; ---------------------------------------------------------------------------

loc_11B79:				; CODE XREF: sub_11A8A:loc_11B73j
		mov	ah, 7

loc_11B7B:				; CODE XREF: sub_11A8A+AEj
					; sub_11A8A+B5j ...
		test	ah, 8
		jnz	short loc_11B83
		movsb
		jmp	short loc_11B87
; ---------------------------------------------------------------------------

loc_11B83:				; CODE XREF: sub_11A8A+F4j
		mov	al, es:[bx]
		stosb

loc_11B87:				; CODE XREF: sub_11A8A+F7j
		inc	bx
		test	ah, 4
		jnz	short loc_11B90
		movsb
		jmp	short loc_11B94
; ---------------------------------------------------------------------------

loc_11B90:				; CODE XREF: sub_11A8A+101j
		mov	al, es:[bx]
		stosb

loc_11B94:				; CODE XREF: sub_11A8A+104j
		inc	bx
		test	ah, 2
		jnz	short loc_11B9D
		movsb
		jmp	short loc_11BA1
; ---------------------------------------------------------------------------

loc_11B9D:				; CODE XREF: sub_11A8A+10Ej
		mov	al, es:[bx]
		stosb

loc_11BA1:				; CODE XREF: sub_11A8A+111j
		inc	bx
		test	ah, 1
		jnz	short loc_11BAA
		movsb
		jmp	short loc_11BAE
; ---------------------------------------------------------------------------

loc_11BAA:				; CODE XREF: sub_11A8A+11Bj
		mov	al, es:[bx]
		stosb

loc_11BAE:				; CODE XREF: sub_11A8A+11Ej
		jmp	loc_11ABC
sub_11A8A	endp

; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		push	ds
		push	si
		lds	si, [bp+4]
		xor	ax, ax
		call	sub_118A1
		cmp	al, 0FFh
		jz	short loc_11BF2
		mov	cs:byte_11C92, al
		mov	cs:word_11C90, dx
		push	ds
		push	si
		push	es
		push	di
		push	cx
		mov	ax, cs
		mov	ds, ax
		assume ds:seg000
		mov	es, ax
		assume es:seg000
		mov	si, 1C94h
		mov	di, 1CC4h
		mov	cx, 18h
		rep movsw
		pop	cx
		pop	di
		pop	es
		assume es:nothing
		pop	si
		pop	ds
		assume ds:nothing
		call	sub_118F7
		call	sub_1192C
		xor	ax, ax

loc_11BEE:				; CODE XREF: seg000:1BF4j
		pop	si
		pop	ds
		pop	bp
		retn
; ---------------------------------------------------------------------------

loc_11BF2:				; CODE XREF: seg000:1BC0j
		mov	ah, 0FFh
		jmp	short loc_11BEE

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_11BF6	proc near		; CODE XREF: sub_107DC+12p

arg_0		= dword	ptr  4

		push	bp
		mov	bp, sp
		push	ds
		push	si
		lds	si, [bp+arg_0]
		mov	ax, 0FFFFh
		call	sub_118A1
		cmp	al, 0FFh
		jz	short loc_11C1A
		mov	cs:byte_11C92, al
		mov	cs:word_11C90, dx
		call	sub_1192C
		xor	ax, ax

loc_11C16:				; CODE XREF: sub_11BF6+26j
		pop	si
		pop	ds
		pop	bp
		retn
; ---------------------------------------------------------------------------

loc_11C1A:				; CODE XREF: sub_11BF6+10j
		mov	ah, 0FFh
		jmp	short loc_11C16
sub_11BF6	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_11C1E	proc near		; CODE XREF: sub_10500+59p

arg_0		= dword	ptr  4

		push	bp
		mov	bp, sp
		push	ds
		push	si
		lds	si, [bp+arg_0]
		xor	ax, ax
		call	sub_118A1
		cmp	al, 0FFh
		jz	short loc_11C5C
		mov	cs:byte_11C92, al
		mov	cs:word_11C90, dx
		push	ds
		push	si
		push	es
		push	di
		push	cx
		mov	ax, cs
		mov	ds, ax
		assume ds:seg000
		mov	es, ax
		assume es:seg000
		mov	si, 1C94h
		mov	di, 1CC4h
		mov	cx, 18h
		rep movsw
		pop	cx
		pop	di
		pop	es
		assume es:nothing
		pop	si
		pop	ds
		assume ds:nothing
		call	sub_1192C
		xor	ax, ax

loc_11C58:				; CODE XREF: sub_11C1E+40j
		pop	si
		pop	ds
		pop	bp
		retn
; ---------------------------------------------------------------------------

loc_11C5C:				; CODE XREF: sub_11C1E+Fj
		mov	ah, 0FFh
		jmp	short loc_11C58
sub_11C1E	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_11C60	proc near		; CODE XREF: sub_10BB2+FCp

arg_0		= dword	ptr  4
arg_4		= dword	ptr  8

		push	bp
		mov	bp, sp
		push	ds
		push	es
		push	si
		push	di
		lds	si, [bp+arg_0]
		les	di, [bp+arg_4]
		xor	ax, ax
		call	sub_118A1
		cmp	al, 0FFh
		jz	short loc_11C8A
		mov	cs:byte_11C92, al
		mov	cs:word_11C90, dx
		call	sub_11A8A
		xor	ax, ax

loc_11C84:				; CODE XREF: sub_11C60+2Cj
		pop	di
		pop	si
		pop	es
		pop	ds
		pop	bp
		retn
; ---------------------------------------------------------------------------

loc_11C8A:				; CODE XREF: sub_11C60+14j
		mov	ah, 0FFh
		jmp	short loc_11C84
sub_11C60	endp

; ---------------------------------------------------------------------------
word_11C8E	dw 0			; DATA XREF: sub_11A8A+7w
					; sub_11A8A:loc_11AA5r	...
word_11C90	dw 0			; DATA XREF: sub_1192C+69w
					; sub_11A8A+35w ...
byte_11C92	db 0			; DATA XREF: sub_118F7+16r
					; sub_1192C+Ar	...
		db 61h dup(0)

; =============== S U B	R O U T	I N E =======================================


sub_11CF4	proc near		; CODE XREF: sub_11DEE+Ap
		mov	ds, cs:word_11E16
		cld
		mov	bx, cs:word_11E10
		mov	ah, 6
		mul	ah
		add	bx, ax
		mov	si, [bx]
		mov	ax, [bx+2]
		xor	dh, dh
		mov	dl, ah
		mov	ah, 0A0h ; ' '
		mul	ah
		add	ax, dx
		mov	di, ax
		mov	ax, [bx+4]
		xor	cx, cx
		xchg	ah, cl
		add	ax, ax
		mov	word ptr cs:byte_11E18,	ax
		mov	bx, cs:word_11E12
		mov	bp, bx
		add	si, bx
		lodsb
		mov	dh, al
		mov	dl, 8

loc_11D31:				; CODE XREF: sub_11CF4+A7j
		push	cx

loc_11D32:				; CODE XREF: sub_11CF4+9Aj
		shl	dh, 1
		dec	dl
		jnz	short loc_11D3D
		lodsb
		mov	dh, al
		mov	dl, 8

loc_11D3D:				; CODE XREF: sub_11CF4+42j
		jb	short loc_11DA9
		shl	dh, 1
		dec	dl
		jnz	short loc_11D4A
		lodsb
		mov	dh, al
		mov	dl, 8

loc_11D4A:				; CODE XREF: sub_11CF4+4Fj
		jb	short loc_11D9E
		mov	ah, 5

loc_11D4E:				; CODE XREF: sub_11CF4+6Cj
		shl	dh, 1
		dec	dl
		jnz	short loc_11D59
		lodsb
		mov	dh, al
		mov	dl, 8

loc_11D59:				; CODE XREF: sub_11CF4+5Ej
		jb	short loc_11D6D
		add	bx, 4
		dec	ah
		jnz	short loc_11D4E
		shl	dh, 1
		dec	dl
		jnz	short loc_11D6D
		lodsb
		mov	dh, al
		mov	dl, 8

loc_11D6D:				; CODE XREF: sub_11CF4:loc_11D59j
					; sub_11CF4+72j ...
		xchg	bx, si
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		movsb
		dec	di
		mov	ax, 0B000h
		mov	es, ax
		assume es:nothing
		movsb
		dec	di
		mov	ax, 0B800h
		mov	es, ax
		assume es:nothing
		movsb
		dec	di
		mov	ax, 0E000h
		mov	es, ax
		assume es:nothing
		movsb
		mov	si, bx

loc_11D8C:				; CODE XREF: sub_11CF4+D0j
		mov	bx, bp
		loop	loc_11D32
		pop	cx
		sub	di, cx
		add	di, 50h	; 'P'
		dec	word ptr cs:byte_11E18
		jnz	short loc_11D31
		retn
; ---------------------------------------------------------------------------

loc_11D9E:				; CODE XREF: sub_11CF4:loc_11D4Aj
		lodsb
		xor	ah, ah
		add	ax, ax
		add	ax, ax
		add	bx, ax
		jmp	short loc_11D6D
; ---------------------------------------------------------------------------

loc_11DA9:				; CODE XREF: sub_11CF4:loc_11D3Dj
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		movsb
		dec	di
		mov	ax, 0B000h
		mov	es, ax
		assume es:nothing
		movsb
		dec	di
		mov	ax, 0B800h
		mov	es, ax
		assume es:nothing
		movsb
		dec	di
		mov	ax, 0E000h
		mov	es, ax
		assume es:nothing
		movsb
		jmp	short loc_11D8C
sub_11CF4	endp


; =============== S U B	R O U T	I N E =======================================


sub_11DC6	proc near		; CODE XREF: sub_11E01+8p
		mov	ax, [bx+6]
		add	ax, bx
		mov	cs:word_11E10, ax
		mov	ax, [bx+8]
		add	ax, bx
		mov	cs:word_11E12, ax
		mov	si, [bx+0Ch]
		mov	ax, [si]
		add	ax, bx
		mov	cs:word_11E14, ax
		mov	cs:word_11E16, ds
		mov	al, [bx+3]
		xor	ah, ah
		retn
sub_11DC6	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_11DEE	proc near		; CODE XREF: sub_10746+8Bp
					; sub_1094E+6Bp ...

arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		push	ds
		push	es
		push	si
		push	di
		mov	ax, [bp+arg_0]
		call	sub_11CF4
		pop	di
		pop	si
		pop	es
		assume es:nothing
		pop	ds
		pop	bp
		retn
sub_11DEE	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_11E01	proc near		; CODE XREF: sub_10746:loc_10789p
					; sub_1094E+16p

arg_0		= dword	ptr  4

		push	bp
		mov	bp, sp
		push	ds
		push	si
		lds	bx, [bp+arg_0]
		call	sub_11DC6
		pop	si
		pop	ds
		pop	bp
		retn
sub_11E01	endp

; ---------------------------------------------------------------------------
word_11E10	dw 0			; DATA XREF: sub_11CF4+6r sub_11DC6+5w
word_11E12	dw 0			; DATA XREF: sub_11CF4+2Fr
					; sub_11DC6+Ew
word_11E14	dw 0			; DATA XREF: sub_11DC6+19w
word_11E16	dw 0			; DATA XREF: sub_11CF4r sub_11DC6+1Dw
byte_11E18	db 0			; DATA XREF: sub_11CF4+2Bw
					; sub_11CF4+A2w
		assume ss:seg000, ds:nothing

; =============== S U B	R O U T	I N E =======================================

; Attributes: noreturn

		public start
start		proc near
		mov	cs:word_11E4A, ds
		mov	ah, 30h
		int	21h		; DOS -	GET DOS	VERSION
					; Return: AL = major version number (00h for DOS 1.x)
		cmp	al, 2
		jnb	short loc_11E28
		int	20h		; DOS -	PROGRAM	TERMINATION
					; returns to DOS--identical to INT 21/AH=00h
; ---------------------------------------------------------------------------

loc_11E28:				; CODE XREF: start+Bj
		cld
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		mov	ax, seg	seg002
		mov	ss, ax
		assume ss:seg002
		mov	sp, 1004h
		mov	ax, es
		mov	bx, seg	seg003
		sub	bx, ax
		mov	ah, 4Ah
		int	21h		; DOS -	2+ - ADJUST MEMORY BLOCK SIZE (SETBLOCK)
					; ES = segment address of block	to change
					; BX = new size	in paragraphs
		jb	short loc_11E46
		call	sub_10BB2

loc_11E46:				; CODE XREF: start+28j
		mov	ah, 4Ch
		int	21h		; DOS -	2+ - QUIT WITH EXIT CODE (EXIT)
start		endp			; AL = exit code

; ---------------------------------------------------------------------------
word_11E4A	dw 0			; DATA XREF: sub_10F50+4r startw ...

; =============== S U B	R O U T	I N E =======================================

; Attributes: noreturn bp-based	frame

sub_11E4C	proc near		; CODE XREF: sub_10BB2+12p

arg_0		= byte ptr  2

		mov	bp, sp
		mov	al, [bp+arg_0]
		mov	ah, 4Ch
		int	21h		; DOS -	2+ - QUIT WITH EXIT CODE (EXIT)
sub_11E4C	endp			; AL = exit code


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_11E55	proc near		; CODE XREF: LoadFile+5Fp

arg_0		= dword	ptr  4
arg_4		= byte ptr  8

		push	bp
		mov	bp, sp
		push	ds
		lds	dx, [bp+arg_0]
		assume ds:nothing
		mov	al, [bp+arg_4]
		mov	ah, 3Dh
		int	21h		; DOS -	2+ - OPEN DISK FILE WITH HANDLE
					; DS:DX	-> ASCIZ filename
					; AL = access mode
					; 0 - read, 1 -	write, 2 - read	& write
		jnb	short loc_11E67
		neg	ax

loc_11E67:				; CODE XREF: sub_11E55+Ej
		pop	ds
		pop	bp
		retn
sub_11E55	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_11E6A	proc near		; CODE XREF: sub_101F6+66p

arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		mov	bx, [bp+arg_0]
		mov	ah, 48h
		int	21h		; DOS -	2+ - ALLOCATE MEMORY
					; BX = number of 16-byte paragraphs desired
		jnb	short loc_11E78
		neg	ax

loc_11E78:				; CODE XREF: sub_11E6A+Aj
		cwd
		pop	bp
		retn
sub_11E6A	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_11E7B	proc near		; CODE XREF: LoadFile+A8p

arg_0		= dword	ptr  4
arg_4		= word ptr  8
arg_6		= word ptr  0Ah

		push	bp
		mov	bp, sp
		push	ds
		lds	dx, [bp+arg_0]
		mov	cx, [bp+arg_4]
		mov	bx, [bp+arg_6]
		mov	ah, 3Fh
		int	21h		; DOS -	2+ - READ FROM FILE WITH HANDLE
					; BX = file handle, CX = number	of bytes to read
					; DS:DX	-> buffer
		jnb	short loc_11E90
		xor	ax, ax

loc_11E90:				; CODE XREF: sub_11E7B+11j
		pop	ds
		pop	bp
		retn
sub_11E7B	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_11E93	proc near		; CODE XREF: LoadFile+B4p

arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		mov	bx, [bp+arg_0]
		mov	ah, 3Eh
		int	21h		; DOS -	2+ - CLOSE A FILE WITH HANDLE
					; BX = file handle
		jb	short loc_11EA1
		xor	ax, ax

loc_11EA1:				; CODE XREF: sub_11E93+Aj
		neg	ax
		pop	bp
		retn
sub_11E93	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_11EA5	proc near		; CODE XREF: sub_10000+16p
					; sub_101F6+16p ...

arg_0		= dword	ptr  4

		push	bp
		mov	bp, sp
		push	si
		push	ds
		lds	si, [bp+arg_0]

loc_11EAD:				; CODE XREF: sub_11EA5+Fj
		lodsb
		or	al, al
		jz	short loc_11EB6
		int	29h		; DOS 2+ internal - FAST PUTCHAR
					; AL = character to display
		jmp	short loc_11EAD
; ---------------------------------------------------------------------------

loc_11EB6:				; CODE XREF: sub_11EA5+Bj
		pop	ds
		pop	si
		pop	bp
		retn
sub_11EA5	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_11EBA	proc near		; CODE XREF: LoadSoundDriver+10p

arg_0		= dword	ptr  4
arg_4		= dword	ptr  8

		push	bp
		mov	bp, sp
		push	si
		push	di
		push	ds
		push	es
		mov	ax, cs:word_11E4A
		mov	cs:seg_11F0C, ax
		mov	cs:word_11F10, ax
		mov	cs:word_11F14, ax
		mov	es, ax
		lds	si, [bp+arg_4]
		xor	bx, bx
		mov	di, 81h	; ''

loc_11EDB:				; CODE XREF: sub_11EBA+28j
		lodsb
		or	al, al
		jz	short loc_11EE4
		stosb
		inc	bx
		jmp	short loc_11EDB
; ---------------------------------------------------------------------------

loc_11EE4:				; CODE XREF: sub_11EBA+24j
		mov	ax, 0Dh
		stosw
		inc	bx
		inc	bx
		mov	es:80h,	bl
		mov	ax, cs
		mov	es, ax
		assume es:seg000
		lds	dx, [bp+arg_0]
		mov	bx, 1F08h
		mov	ax, 4B00h
		int	21h		; DOS -	2+ - LOAD OR EXECUTE (EXEC)
					; DS:DX	-> ASCIZ filename
					; ES:BX	-> parameter block
					; AL = subfunc:	load & execute program
		jb	short loc_11F02
		xor	ax, ax

loc_11F02:				; CODE XREF: sub_11EBA+44j
		pop	es
		assume es:nothing
		pop	ds
		pop	di
		pop	si
		pop	bp
		retn
sub_11EBA	endp

; ---------------------------------------------------------------------------
		db 2 dup(0), 80h, 0
seg_11F0C	dw seg seg000		; DATA XREF: sub_11EBA+Bw
		db 50h,	0
word_11F10	dw 0			; DATA XREF: sub_11EBA+Fw
		db 60h,	0
word_11F14	dw 0			; DATA XREF: sub_11EBA+13w

; =============== S U B	R O U T	I N E =======================================


sub_11F16	proc near		; CODE XREF: LoadSoundDriver:loc_10048p
		mov	ax, 4D00h
		int	21h		; DOS -	2+ - GET EXIT CODE OF SUBPROGRAM (WAIT)
		retn
sub_11F16	endp

seg000		ends

; ===========================================================================

; Segment type:	Regular
seg001		segment	byte public 'UNK' use16
		assume cs:seg001
		;org 0Ch
		assume es:nothing, ss:nothing, ds:nothing, fs:nothing, gs:nothing
aVVGgtggvBapc98	db '‚±‚Ìƒƒtƒg‚ÍAPC-9801VF/VMˆÈ~(Šg’£ƒOƒ‰ƒtƒBƒbƒNƒƒ‚ƒŠ‚Ì‚ ‚é‹@Ží)‚Å'
		db '‚µ‚©“®ì‚µ‚Ü‚¹‚'
		db 0F1h	; ñ
		db 'B',0Dh,0Ah,0
aGtg@gcglgibGvg	db 'ƒtƒ@ƒCƒ‹ƒI[ƒvƒ“ƒGƒ‰[',0
		db    0
aGbgvgkvkslvsvV	db 'ƒƒ‚ƒŠ‚ª‘«‚è‚Ü‚¹‚'
		db 0F1h	; ñ
		db    0
		db    0
aGtg@gcglgkbGhg	db 'ƒtƒ@ƒCƒ‹ƒŠ[ƒhƒGƒ‰[',0
		db    0
aGtg@gcglgigcgg	db 'ƒtƒ@ƒCƒ‹ƒ‰ƒCƒgƒGƒ‰[',0
		db    0
aData		db '\data\',0           ; DATA XREF: LoadFile:loc_10160o
		db    0
aMusic		db '\music\',0          ; DATA XREF: LoadFile:loc_101A6o
					; sub_10480+38o ...
aGraph		db '\graph\',0          ; DATA XREF: LoadFile:loc_101B4o
					; LoadFile:loc_101C2o ...
		dw offset aGraph	; "\\graph\\"
aDat		db 'DAT',0              ; DATA XREF: LoadFile+35o
aEmi		db 'EMI',0              ; DATA XREF: LoadFile+7Bo
					; sub_10480:loc_104AEo	...
aVdt		db 'VDT',0              ; DATA XREF: LoadFile+89o
aAnm		db 'ANM',0              ; DATA XREF: LoadFile+97o
aFmd_exe	db 'FMD.EXE',0          ; DATA XREF: LoadSoundDriver+Bo
a2j		db 1Bh,'[2J',0          ; DATA XREF: sub_101F6+27o
		db    0
a1h		db 1Bh,'[>1h',0
aCRLF		db 0Dh,0Ah,0
		db    0
		db    0
		db    0
		db    0
		db    0
word_12010	dw 0			; DATA XREF: sub_105AA+11r
					; sub_10746+3Fr
word_12012	dw 0			; DATA XREF: sub_105AA+Dr
					; sub_10746+3Br
word_12014	dw 0			; DATA XREF: sub_10500+55r
word_12016	dw 0			; DATA XREF: sub_10500+51r
word_12018	dw 0			; DATA XREF: sub_10746+23r
word_1201A	dw 0			; DATA XREF: sub_10746+1Fr
word_1201C	dw 0			; DATA XREF: sub_10746+2Er
word_1201E	dw 0			; DATA XREF: sub_101F6:loc_10409r
					; sub_10746:loc_10770r
		dw 19h dup(0)
word_12052	dw 0			; DATA XREF: sub_101F6+219w
		dw 4
word_12056	dw 0			; DATA XREF: sub_105AA+3w
					; sub_105AA+29w ...
		dw 0
word_1205A	dw 0			; DATA XREF: sub_10500+66r
					; sub_10500:loc_105A2w
word_1205C	dw 0FFFFh		; DATA XREF: sub_10000+5o
					; sub_10500+5Fr ...
word_1205E	dw 0			; DATA XREF: sub_10500:loc_1053Ar
					; sub_10500+47r ...
		dw 0
word_12062	dw 0			; DATA XREF: sub_10500:loc_10526r
					; sub_10500:loc_10530r	...
aM6N0		db ' -M6 -N0',0         ; DATA XREF: LoadSoundDriver+6o
asc_1206D	db '\',0                ; DATA XREF: LoadFile+1Do
unk_1206F	db    0			; DATA XREF: LoadFile+26o
a5h		db 1Bh,'[>5h',0         ; DATA XREF: sub_101F6+11o
a1h_0		db 1Bh,'[>1h',0         ; DATA XREF: sub_101F6+1Co
aVVVVsvpVavtvcv	db '‚Í‚Á‚¿‚á‚¯ ‚ ‚â‚æ‚³‚' ; DATA XREF: sub_101F6+32o
		db 0F1h	; ñ
		db '‚Q for PC-9801/PC-286',0Dh,0Ah
		db 'Programmed by Tomes Suzuki.',0Dh,0Ah,0
aAya2mes	db 'AYA2MES',0          ; DATA XREF: sub_101F6+A0o
aCg		db 'cg',0               ; DATA XREF: sub_101F6+22Co
		db    0
aFace0		db 'face0',0            ; DATA XREF: sub_101F6+E7o
					; sub_101F6+12Fo ...
aAya1		db 'AYA1',0             ; DATA XREF: sub_10480+33o
aAya2		db 'AYA2',0             ; DATA XREF: sub_10480+5Bo
aAya3		db 'AYA3',0             ; DATA XREF: sub_10480+65o
aAya4		db 'AYA4',0             ; DATA XREF: sub_10480+6Fo
		db  4Dh	; M
aAyam		db 'AYAM',0             ; DATA XREF: sub_105DC+5o
aTitle		db 'TITLE',0            ; DATA XREF: sub_105DC+38o
aWaku		db 'WAKU',0             ; DATA XREF: sub_105DC+62o
		db    0
byte_120FE	db 03h,	01h, 02h, 03h, 02h, 01h, 04h, 74h ; DATA XREF: sub_106EC+37o
		db 07h,	05h, 06h, 07h, 06h, 05h, 08h, 74h
		db 0Bh,	09h, 0Ah, 0Bh, 0Ah, 09h, 0Ch, 74h
		db 0Fh,	0Dh, 0Eh, 0Fh, 0Eh, 0Dh, 10h, 74h
		db 13h,	11h, 12h, 13h, 12h, 11h, 14h, 74h
		db 17h,	15h, 16h, 17h, 16h, 15h, 18h, 74h
		db 1Bh,	19h, 1Ah, 1Bh, 1Ah, 19h, 1Ch, 74h
		db 1Fh,	1Dh, 1Eh, 1Fh, 1Eh, 1Dh, 20h, 74h
		db 23h,	21h, 22h, 23h, 22h, 21h, 24h, 74h
		db 03h,	01h, 02h, 03h, 02h, 01h, 04h, 74h
		db 07h,	05h, 06h, 07h, 06h, 05h, 08h, 74h
		db 0Bh,	09h, 0Ah, 0Bh, 0Ah, 09h, 0Ch, 74h
		dw 0
word_12160	dw 0			; DATA XREF: sub_10746:loc_10757r
					; sub_10746+18r
byte_12162	db 56h dup(0)
byte_121B8	db 112h	dup(0)		; DATA XREF: LoadFile+4Co LoadFile+5Ao ...
word_122CA	dw 0			; DATA XREF: sub_101F6+4Fw
		dw 0
word_122CE	dw 0			; DATA XREF: sub_10500+71r
word_122D0	dw 0			; DATA XREF: sub_10500+6Dr
		db 2Eh dup(0)
seg001		ends

; ===========================================================================

; Segment type:	Regular
seg002		segment	byte public 'UNK' use16
		assume cs:seg002
		assume es:nothing, ss:nothing, ds:nothing, fs:nothing, gs:nothing
		db 1010h dup(0)
seg002		ends

; ===========================================================================

; Segment type:	Zero-length
seg003		segment	byte public '' use16
seg003		ends


		end start
