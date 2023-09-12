; Input	MD5   :	E92EADDEA752AF4FEACC9F91B4C455EC
; Input	CRC32 :	E21E3C28

; File Name   :	D:\AYA3.EXE
; Format      :	MS-DOS executable (EXE)
; Base Address:	1000h Range: 10000h-17C60h Loaded length: 6C54h
; Entry	Point :	1000:5CB7

		.686p
		.mmx
		.model large

; ===========================================================================

; Segment type:	Pure code
seg000		segment	byte public 'CODE' use16
		assume cs:seg000
		assume es:nothing, ss:nothing, ds:nothing, fs:nothing, gs:nothing
byte_10000	db 10h dup(0)
		assume ds:seg002

; =============== S U B	R O U T	I N E =======================================


sub_10010	proc near		; CODE XREF: InitGame+33p
		mov	bx, 40h	; '@'
		mov	es, bx
		assume es:nothing
		mov	bx, 14Ch
		mov	al, es:[bx]
		and	al, 4
		cmp	al, 4
		jz	short loc_1003A
		mov	ax, 7

loc_10024:
		push	ax
		call	SetTextGFXAddr
		add	sp, 2
		mov	ax, offset aNeedExtGFXMem ; "‚±‚Ìƒ\\ƒtƒg‚ÍAPC-9801VF/VMˆÈ~(Šg’£ƒOƒ‰"...
		push	ds
		push	ax
		call	PrintText	; print	aNeedExtGFXMem text
		add	sp, 4
		mov	ax, 0FFFFh
		retn
; ---------------------------------------------------------------------------

loc_1003A:				; CODE XREF: sub_10010+Fj
		sub	ax, ax
		retn
sub_10010	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

LoadSoundDriver	proc near		; CODE XREF: InitGame+28p

var_2		= word ptr -2

		push	bp
		mov	bp, sp

loc_10041:
		sub	sp, 2
		mov	ax, offset aN0	; " -N0"
		push	ds
		push	ax
		mov	ax, offset aEmd_com ; "emd.com"
		push	ds
		push	ax

loc_1004E:
		call	exec
		add	sp, 8
		mov	[bp+var_2], ax
		or	ax, ax
		jz	short loc_10062

loc_1005B:				; CODE XREF: LoadSoundDriver+46j
		sub	ax, ax
		mov	sp, bp
		pop	bp
		retn
; ---------------------------------------------------------------------------
		align 2

loc_10062:				; CODE XREF: LoadSoundDriver+1Bj
		call	sub_15E00
		mov	[bp+var_2], ax
		cmp	byte ptr [bp+var_2], 0
		jnz	short loc_10076

loc_1006E:				; CODE XREF: LoadSoundDriver+3Cj
					; LoadSoundDriver+48j
		mov	ax, 0FFFFh
		mov	sp, bp
		pop	bp
		retn
; ---------------------------------------------------------------------------
		align 2

loc_10076:				; CODE XREF: LoadSoundDriver+2Ej
		cmp	[bp+var_2], 4
		jz	short loc_1006E
		mov	ax, [bp+var_2]

loc_1007F:				; DATA XREF: seg000:off_15DF4o
		sub	al, al

loc_10081:
		cmp	ax, 300h
		jnz	short loc_1005B
		jmp	short loc_1006E
LoadSoundDriver	endp

; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		sub	sp, 8
		mov	es, seg_1640A
		assume es:seg003
		mov	ax, [bp+4]
		cmp	es:word_16A8E, ax
		jbe	short loc_100C4
		mov	bx, ax
		shl	bx, 1
		shl	bx, 1
		mov	es, seg_1640C
		mov	ax, es:[bx+0Eh]
		mov	dx, es:[bx+10h]
		mov	[bp-8],	ax
		mov	[bp-6],	dx
		or	ax, dx
		jz	short loc_100C4
		push	dx
		push	word ptr [bp-8]
		call	sub_131D2
		add	sp, 4

loc_100C4:				; CODE XREF: seg000:009Aj seg000:00B8j
		mov	sp, bp
		pop	bp
		retn

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_100C8	proc near		; CODE XREF: PrintTextLine+29p

var_2		= byte ptr -2
arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	si
		mov	es, seg_1640E
		assume es:seg001
		cmp	es:word_1617C, 0FFFFh
		jz	short loc_10140
		cmp	[bp+arg_0], 0
		jz	short loc_10140
		jmp	short loc_100FB
; ---------------------------------------------------------------------------
		align 2

loc_100E4:				; CODE XREF: sub_100C8+55j
		cmp	ax, 0FEh
		jz	short loc_100F0
		cmp	ax, 0FFh
		jz	short loc_10140
		jmp	short loc_1012C
; ---------------------------------------------------------------------------

loc_100F0:				; CODE XREF: sub_100C8+1Fj
		mov	es, seg_1640E
		mov	es:word_1617C, 0

loc_100FB:				; CODE XREF: sub_100C8+19j
		mov	bx, es:word_1617C

loc_10100:
		mov	es, seg_16410

loc_10104:
		les	si, es:dword_15F20
		assume es:nothing
		mov	al, es:[bx+si]
		mov	[bp+var_2], al
		mov	es, seg_1640E
		assume es:seg001
		inc	es:word_1617C
		sub	ah, ah
		cmp	ax, 0FCh
		jnz	short loc_100E4
		mov	es:word_1617C, 0FFFFh
		pop	si
		mov	sp, bp
		pop	bp
		retn
; ---------------------------------------------------------------------------
		align 2

loc_1012C:				; CODE XREF: sub_100C8+26j
		mov	al, [bp+var_2]
		sub	ah, ah
		mov	ch, byte_163C6
		sub	cl, cl
		add	ax, cx
		push	ax
		call	sub_13580
		add	sp, 2

loc_10140:				; CODE XREF: sub_100C8+11j
					; sub_100C8+17j ...
		pop	si
		mov	sp, bp
		pop	bp
		retn
sub_100C8	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

PrintTextLine	proc near		; CODE XREF: mes01_TextNarrator+1Ep
					; mes02_TextChr1+5Dp ...

var_2		= byte ptr -2
arg_0		= dword	ptr  4

		push	bp
		mov	bp, sp
		sub	sp, 2
		sub	ax, ax
		push	ax
		call	sub_13133
		add	sp, 2
		jmp	short loc_10178
; ---------------------------------------------------------------------------
		align 2

loc_10158:				; CODE XREF: PrintTextLine+40j
		push	messageSpeed

loc_1015C:
		call	SetCharacterDelay
		add	sp, 2
		mov	al, [bp+var_2]
		sub	ah, ah
		push	ax
		call	PrintTextChar
		add	sp, 2
		push	ax
		call	sub_100C8
		add	sp, 2
		call	sub_12E5B

loc_10178:				; CODE XREF: PrintTextLine+Fj
		les	bx, [bp+arg_0]
		assume es:nothing
		inc	word ptr [bp+arg_0]

loc_1017E:
		mov	al, es:[bx]
		mov	[bp+var_2], al
		or	al, al
		jnz	short loc_10158
		mov	ax, 0Dh
		push	ax
		call	PrintTextChar
		add	sp, 2
		mov	ax, 0Ah
		push	ax
		call	PrintTextChar
		mov	sp, bp
		pop	bp
		retn
PrintTextLine	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

mes01_TextNarrator proc	near		; CODE XREF: GameMain+D4p
					; DATA XREF: seg002:mesJumpTblo

arg_0		= word ptr  4
arg_2		= word ptr  6

		push	bp
		mov	bp, sp
		mov	es, seg_1640E
		assume es:seg001
		mov	es:word_1617C, 0FFFFh
		mov	ax, 7
		push	ax
		call	SetTextGFXAddr
		add	sp, 2
		push	[bp+arg_2]
		push	[bp+arg_0]
		call	PrintTextLine	; print	narrator script	text
		add	sp, 4
		sub	ax, ax
		pop	bp
		retn
mes01_TextNarrator endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

mes02_TextChr1	proc near		; CODE XREF: GameMain+D4p
					; DATA XREF: seg002:mesJumpTblo

arg_0		= word ptr  4
arg_2		= word ptr  6

		push	bp
		mov	bp, sp
		mov	es, seg_16412
		mov	al, es:characterCols
		sub	ah, ah
		push	ax
		call	SetTextGFXAddr
		add	sp, 2
		mov	es, seg_16414
		push	word ptr es:characterNames+2
		push	word ptr es:characterNames
		call	PrintText	; print	character 1 name
		add	sp, 4
		mov	es, seg_16416
		mov	ax, word ptr es:dword_15E22
		mov	dx, word ptr es:dword_15E22+2
		mov	es, seg_16410
		mov	word ptr es:dword_15F20, ax
		mov	word ptr es:dword_15F20+2, dx
		mov	es, seg_1640E
		mov	es:word_1617C, 0
		mov	ax, 7
		push	ax
		call	SetTextGFXAddr
		add	sp, 2
		push	[bp+arg_2]
		push	[bp+arg_0]
		call	PrintTextLine	; print	character 1 script text
		add	sp, 4
		sub	ax, ax
		pop	bp
		retn
mes02_TextChr1	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

mes03_TextChr2	proc near		; CODE XREF: GameMain+D4p
					; DATA XREF: seg002:mesJumpTblo

arg_0		= word ptr  4
arg_2		= word ptr  6

		push	bp
		mov	bp, sp
		mov	es, seg_16412
		mov	al, es:characterCols+1
		sub	ah, ah
		push	ax
		call	SetTextGFXAddr
		add	sp, 2
		mov	es, seg_16414
		push	word ptr es:characterNames+6
		push	word ptr es:characterNames+4
		call	PrintText	; print	character 2 name
		add	sp, 4
		mov	es, seg_16416
		mov	ax, word ptr es:dword_15E22+4
		mov	dx, word ptr es:dword_15E22+6
		mov	es, seg_16410
		mov	word ptr es:dword_15F20, ax
		mov	word ptr es:dword_15F20+2, dx
		mov	es, seg_1640E
		mov	es:word_1617C, 0
		mov	ax, 7
		push	ax
		call	SetTextGFXAddr
		add	sp, 2
		push	[bp+arg_2]
		push	[bp+arg_0]
		call	PrintTextLine	; print	character 2 script text
		add	sp, 4
		sub	ax, ax
		pop	bp
		retn
mes03_TextChr2	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

mes04_TextChr3	proc near		; CODE XREF: GameMain+D4p
					; DATA XREF: seg002:mesJumpTblo

arg_0		= word ptr  4
arg_2		= word ptr  6

		push	bp
		mov	bp, sp
		mov	es, seg_16412
		mov	al, es:characterCols+2
		sub	ah, ah
		push	ax
		call	SetTextGFXAddr
		add	sp, 2
		mov	es, seg_16414
		push	word ptr es:characterNames+0Ah
		push	word ptr es:characterNames+8
		call	PrintText	; print	character 3 name
		add	sp, 4
		mov	es, seg_16416
		mov	ax, word ptr es:dword_15E22+8
		mov	dx, word ptr es:dword_15E22+0Ah
		mov	es, seg_16410
		mov	word ptr es:dword_15F20, ax
		mov	word ptr es:dword_15F20+2, dx
		mov	es, seg_1640E
		mov	es:word_1617C, 0
		mov	ax, 7
		push	ax
		call	SetTextGFXAddr
		add	sp, 2
		push	[bp+arg_2]
		push	[bp+arg_0]
		call	PrintTextLine	; print	character 3 script text
		add	sp, 4
		sub	ax, ax
		pop	bp
		retn
mes04_TextChr3	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

mes05_TextChr4	proc near		; CODE XREF: GameMain+D4p
					; DATA XREF: seg002:mesJumpTblo

arg_0		= word ptr  4
arg_2		= word ptr  6

		push	bp
		mov	bp, sp
		mov	es, seg_16412
		mov	al, es:characterCols+3
		sub	ah, ah
		push	ax
		call	SetTextGFXAddr
		add	sp, 2
		mov	es, seg_16414
		push	word ptr es:characterNames+0Eh
		push	word ptr es:characterNames+0Ch
		call	PrintText	; print	character 4 name
		add	sp, 4
		mov	es, seg_16416
		mov	ax, word ptr es:dword_15E22+0Ch
		mov	dx, word ptr es:dword_15E22+0Eh
		mov	es, seg_16410
		mov	word ptr es:dword_15F20, ax
		mov	word ptr es:dword_15F20+2, dx
		mov	es, seg_1640E
		mov	es:word_1617C, 0
		mov	ax, 7
		push	ax
		call	SetTextGFXAddr
		add	sp, 2
		push	[bp+arg_2]
		push	[bp+arg_0]
		call	PrintTextLine	; print	character 4 script text
		add	sp, 4
		sub	ax, ax
		pop	bp
		retn
mes05_TextChr4	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

mes06_TextChr5	proc near		; CODE XREF: GameMain+D4p
					; DATA XREF: seg002:mesJumpTblo

arg_0		= word ptr  4
arg_2		= word ptr  6

		push	bp
		mov	bp, sp
		mov	es, seg_16412
		mov	al, es:characterCols+4
		sub	ah, ah
		push	ax
		call	SetTextGFXAddr
		add	sp, 2
		mov	es, seg_16414
		push	word ptr es:characterNames+12h
		push	word ptr es:characterNames+10h
		call	PrintText	; print	character 5 name
		add	sp, 4
		mov	es, seg_16416
		mov	ax, word ptr es:dword_15E22+10h
		mov	dx, word ptr es:dword_15E22+12h
		mov	es, seg_16410
		mov	word ptr es:dword_15F20, ax
		mov	word ptr es:dword_15F20+2, dx
		mov	es, seg_1640E
		mov	es:word_1617C, 0
		mov	ax, 7
		push	ax
		call	SetTextGFXAddr
		add	sp, 2
		push	[bp+arg_2]
		push	[bp+arg_0]
		call	PrintTextLine	; print	character 5 script text
		add	sp, 4
		sub	ax, ax
		pop	bp
		retn
mes06_TextChr5	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

mes07_TextChr6	proc near		; CODE XREF: GameMain+D4p
					; DATA XREF: seg002:mesJumpTblo

arg_0		= word ptr  4
arg_2		= word ptr  6

		push	bp
		mov	bp, sp
		mov	es, seg_16412
		mov	al, es:characterCols+5
		sub	ah, ah
		push	ax
		call	SetTextGFXAddr
		add	sp, 2
		mov	es, seg_16414
		push	word ptr es:characterNames+16h
		push	word ptr es:characterNames+14h
		call	PrintText	; print	character 6 name
		add	sp, 4
		mov	es, seg_16416
		mov	ax, word ptr es:dword_15E22+14h
		mov	dx, word ptr es:dword_15E22+16h
		mov	es, seg_16410
		mov	word ptr es:dword_15F20, ax
		mov	word ptr es:dword_15F20+2, dx
		mov	es, seg_1640E
		mov	es:word_1617C, 0
		mov	ax, 7
		push	ax
		call	SetTextGFXAddr
		add	sp, 2
		push	[bp+arg_2]
		push	[bp+arg_0]
		call	PrintTextLine	; print	character 6 script text
		add	sp, 4
		sub	ax, ax
		pop	bp
		retn
mes07_TextChr6	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

mes08_TextChr7	proc near		; CODE XREF: GameMain+D4p
					; DATA XREF: seg002:mesJumpTblo

arg_0		= word ptr  4
arg_2		= word ptr  6

		push	bp
		mov	bp, sp
		mov	es, seg_16412
		mov	al, es:characterCols+6
		sub	ah, ah
		push	ax
		call	SetTextGFXAddr
		add	sp, 2
		mov	es, seg_16414

loc_1044E:
		push	word ptr es:characterNames+1Ah
		push	word ptr es:characterNames+18h
		call	PrintText	; print	character 7 name
		add	sp, 4
		mov	es, seg_16416
		mov	ax, word ptr es:dword_15E22+18h
		mov	dx, word ptr es:dword_15E22+1Ah
		mov	es, seg_16410
		mov	word ptr es:dword_15F20, ax
		mov	word ptr es:dword_15F20+2, dx
		mov	es, seg_1640E
		mov	es:word_1617C, 0
		mov	ax, 7
		push	ax
		call	SetTextGFXAddr
		add	sp, 2
		push	[bp+arg_2]
		push	[bp+arg_0]
		call	PrintTextLine	; print	character 7 script text
		add	sp, 4
		sub	ax, ax
		pop	bp
		retn
mes08_TextChr7	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

mes09_TextChr8	proc near		; CODE XREF: GameMain+D4p
					; DATA XREF: seg002:mesJumpTblo

arg_0		= word ptr  4
arg_2		= word ptr  6

		push	bp
		mov	bp, sp
		mov	es, seg_16412
		mov	al, es:characterCols+7
		sub	ah, ah
		push	ax
		call	SetTextGFXAddr
		add	sp, 2
		mov	es, seg_16414
		push	word ptr es:characterNames+1Eh
		push	word ptr es:characterNames+1Ch
		call	PrintText	; print	character 8 name
		add	sp, 4
		mov	es, seg_16416
		mov	ax, word ptr es:dword_15E22+1Ch
		mov	dx, word ptr es:dword_15E22+1Eh
		mov	es, seg_16410
		mov	word ptr es:dword_15F20, ax
		mov	word ptr es:dword_15F20+2, dx
		mov	es, seg_1640E
		mov	es:word_1617C, 0
		mov	ax, 7
		push	ax
		call	SetTextGFXAddr
		add	sp, 2
		push	[bp+arg_2]
		push	[bp+arg_0]
		call	PrintTextLine	; print	character 8 script text
		add	sp, 4
		sub	ax, ax
		pop	bp
		retn
mes09_TextChr8	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

AppendFileExt	proc near		; CODE XREF: mes0A_LoadGRP+20p

var_A		= word ptr -0Ah
var_8		= dword	ptr -8
var_4		= dword	ptr -4
destBuffer	= word ptr  4
arg_2		= word ptr  6
somePtr		= word ptr  8
arg_6		= word ptr  0Ah
baseNamePtr	= word ptr  0Ch
arg_A		= word ptr  0Eh
fileExtPtr	= word ptr  10h
arg_E		= word ptr  12h

		push	bp
		mov	bp, sp
		sub	sp, 0Ah
		push	di
		push	si
		mov	ax, [bp+destBuffer]
		mov	dx, [bp+arg_2]
		mov	word ptr [bp+var_8], ax
		mov	word ptr [bp+var_8+2], dx
		mov	ax, [bp+somePtr]
		mov	dx, [bp+arg_6]
		mov	word ptr [bp+var_4], ax
		mov	word ptr [bp+var_4+2], dx
		les	di, [bp+var_4]
		assume es:nothing
		mov	[bp+var_A], ds
		lds	si, [bp+var_8]
		assume ds:seg001
		jmp	short loc_10539
; ---------------------------------------------------------------------------
		align 2

loc_10532:				; CODE XREF: AppendFileExt+37j
		mov	al, es:[di]
		mov	[si], al
		inc	di
		inc	si

loc_10539:				; CODE XREF: AppendFileExt+29j
		cmp	byte ptr es:[di], 0
		jnz	short loc_10532
		mov	word ptr [bp+var_8], si
		mov	word ptr [bp+var_8+2], ds
		mov	ds, [bp+var_A]
		mov	word ptr [bp+var_4], di
		mov	word ptr [bp+var_4+2], es
		mov	ax, [bp+baseNamePtr]
		mov	dx, [bp+arg_A]
		mov	word ptr [bp+var_4], ax
		mov	word ptr [bp+var_4+2], dx
		les	di, [bp+var_4]
		mov	ds, word ptr [bp+var_8+2]
		jmp	short loc_1056F
; ---------------------------------------------------------------------------

loc_10562:				; CODE XREF: AppendFileExt+6Dj
		cmp	byte ptr es:[di], 0
		jz	short loc_10575
		mov	al, es:[di]
		mov	[si], al
		inc	di
		inc	si

loc_1056F:				; CODE XREF: AppendFileExt+5Aj
		cmp	byte ptr es:[di], 2Eh ;	'.'
		jnz	short loc_10562

loc_10575:				; CODE XREF: AppendFileExt+60j
		mov	word ptr [bp+var_8], si
		mov	word ptr [bp+var_8+2], ds
		mov	ds, [bp+var_A]
		mov	word ptr [bp+var_4], di
		mov	word ptr [bp+var_4+2], es
		les	bx, [bp+var_8]
		inc	word ptr [bp+var_8]
		mov	byte ptr es:[bx], 2Eh ;	'.'
		mov	ax, [bp+fileExtPtr]
		mov	dx, [bp+arg_E]
		mov	word ptr [bp+var_4], ax
		mov	word ptr [bp+var_4+2], dx
		les	di, [bp+var_4]
		lds	si, [bp+var_8]
		jmp	short loc_105A9
; ---------------------------------------------------------------------------

loc_105A2:				; CODE XREF: AppendFileExt+A7j
		mov	al, es:[di]
		mov	[si], al
		inc	di
		inc	si

loc_105A9:				; CODE XREF: AppendFileExt+9Aj
		cmp	byte ptr es:[di], 0
		jnz	short loc_105A2
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
AppendFileExt	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

mes0A_LoadGRP	proc near		; CODE XREF: GameMain+D4p
					; DATA XREF: seg002:mesJumpTblo

var_12		= word ptr -12h
var_10		= dword	ptr -10h
var_C		= word ptr -0Ch
var_A		= word ptr -0Ah
var_8		= word ptr -8
var_6		= dword	ptr -6
var_2		= word ptr -2
arg_0		= word ptr  4
arg_2		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 12h
		push	di
		push	si
		mov	ax, offset aGrp	; "GRP"
		push	ds
		push	ax
		push	[bp+arg_2]
		push	[bp+arg_0]
		mov	ax, offset unk_163E8
		push	ds
		push	ax
		mov	ax, offset grpFileName
		mov	dx, seg	seg001
		push	dx
		push	ax
		call	AppendFileExt
		add	sp, 10h
		sub	ax, ax
		push	ax
		mov	ax, offset grpFileName
		mov	dx, seg	seg001
		push	dx
		push	ax
		call	fopen
		add	sp, 6
		mov	[bp+var_C], ax
		or	ax, ax
		jge	short loc_10614
		mov	ax, 2		; error	aFileNotFound
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retn
; ---------------------------------------------------------------------------
		align 2

loc_10614:				; CODE XREF: mes0A_LoadGRP+3Cj
		push	[bp+var_C]
		mov	ax, 0F7F6h
		push	ax
		mov	es, word_16098
		assume es:nothing
		push	word ptr es:52h
		push	word ptr es:50h
		call	fread
		add	sp, 8
		mov	[bp+var_2], ax
		push	[bp+var_C]
		call	fclose
		add	sp, 2
		cmp	[bp+var_2], 0
		jnz	short loc_1064A
		mov	ax, 3		; error	aDiskReadError
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retn
; ---------------------------------------------------------------------------

loc_1064A:				; CODE XREF: mes0A_LoadGRP+73j
		mov	[bp+var_A], 0
		mov	ax, seg	seg001
		mov	es, ax
		assume es:seg001
		mov	ax, word ptr es:mesPtr
		add	[bp+var_2], ax
		mov	ax, seg	seg001
		mov	es, ax
		mov	ax, word ptr es:PaletteDataPtr
		mov	dx, word ptr es:PaletteDataPtr+2
		add	ax, 20h
		mov	word ptr [bp+var_6], ax
		mov	word ptr [bp+var_6+2], dx
		mov	ax, [bp+var_2]
		cmp	word ptr [bp+var_6], ax
		jnb	short loc_106B9
		mov	word ptr [bp+var_10], offset graphicsList
		mov	word ptr [bp+var_10+2],	seg seg001
		mov	di, [bp+var_A]
		mov	[bp+var_12], ds
		lds	si, [bp+var_10]
		assume ds:nothing

loc_1068D:				; CODE XREF: mes0A_LoadGRP+E2j
		les	bx, [bp+var_6]
		assume es:nothing
		mov	cx, es:[bx]
		add	word ptr [bp+var_6], 4
		mov	ax, word ptr [bp+var_6]
		mov	[si], ax
		mov	ax, cx
		add	ax, 8
		add	word ptr [bp+var_6], ax
		add	si, 2
		inc	di
		mov	ax, [bp+var_2]
		cmp	word ptr [bp+var_6], ax
		jb	short loc_1068D
		mov	ds, [bp+var_12]
		mov	[bp+var_A], di
		mov	[bp+var_8], cx

loc_106B9:				; CODE XREF: mes0A_LoadGRP+ACj
		mov	ax, seg	seg001
		mov	es, ax
		assume es:seg001
		mov	ax, [bp+var_A]
		mov	es:graphicsCount, ax
		mov	ax, seg	seg001
		mov	es, ax
		mov	es:word_1617C, 0FFFFh
		sub	ax, ax
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retn
mes0A_LoadGRP	endp

; ---------------------------------------------------------------------------
		align 2
		assume ds:seg002

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

mes0B_GfxThing	proc near		; CODE XREF: GameMain+D4p
					; DATA XREF: seg002:mesJumpTblo

var_12		= word ptr -12h
var_10		= word ptr -10h
var_E		= byte ptr -0Eh
var_C		= word ptr -0Ch
var_A		= word ptr -0Ah
var_8		= word ptr -8
graphicsID	= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= dword	ptr  4

		push	bp
		mov	bp, sp
		sub	sp, 12h
		push	di
		push	si
		call	sub_134EC
		sub	di, di
		sub	si, si
		mov	[bp+var_A], 10h
		mov	[bp+var_C], 10h

loc_106F3:				; CODE XREF: mes0B_GfxThing+55j
		mov	es, seg_1641A
		les	bx, es:PaletteDataPtr
		assume es:nothing
		mov	al, es:[bx+di]
		mov	[bp+var_E], al
		and	al, 0Fh
		mov	[si+1DEh], al
		inc	si
		mov	al, [bp+var_E]
		sub	ah, ah
		mov	cl, 4
		shr	ax, cl
		and	al, 0Fh
		mov	[si+1DEh], al
		inc	si
		inc	di
		mov	es, seg_1641A
		assume es:seg001
		mov	es, word ptr es:PaletteDataPtr+2
		assume es:nothing
		mov	al, es:[bx+di]
		mov	[si+1DEh], al
		inc	si
		inc	di
		dec	[bp+var_C]
		jnz	short loc_106F3
		mov	[bp+graphicsID], di
		mov	[bp+var_8], si
		les	bx, [bp+arg_0]
		mov	al, es:[bx]
		sub	ah, ah
		mov	[bp+graphicsID], ax
		mov	es, seg_1641C
		assume es:seg001
		mov	ax, es:graphicsCount
		cmp	[bp+graphicsID], ax
		jb	short loc_10758
		mov	ax, 4		; error	aBadGraphicID
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retn
; ---------------------------------------------------------------------------

loc_10758:				; CODE XREF: mes0B_GfxThing+73j
		mov	es, seg_16418
		mov	ax, word ptr es:mesPtr+2
		mov	[bp+var_2], ax
		mov	bx, [bp+graphicsID]
		shl	bx, 1
		mov	es, seg_1641E
		mov	ax, es:graphicsList[bx]
		mov	[bp+var_4], ax
		push	[bp+var_2]
		push	ax
		call	sub_158B8
		add	sp, 4
		mov	es, seg_16420
		push	word ptr es:dword_15EFA+2
		push	word ptr es:dword_15EFA
		call	sub_1324A
		add	sp, 4
		mov	es, seg_16422
		mov	ax, es:word_15E20
		mov	es, seg_16424
		sub	ax, es:word_15F6C
		cmp	ax, 0FA1h
		jnb	short loc_10816
		mov	es, seg_16426
		mov	ax, es:380h
		mov	es, seg_16424
		add	ax, es:word_15F6C
		mov	[bp+var_10], ax
		mov	[bp+var_12], 0
		push	ax
		push	[bp+var_12]
		mov	ax, offset word_163E9
		push	ds
		push	ax
		call	DoGraphicsThing
		add	sp, 8
		mov	ax, 2
		push	ax
		call	sub_12E34
		add	sp, 2
		push	[bp+var_10]
		push	[bp+var_12]
		call	sub_131D2
		add	sp, 4
		mov	ax, 2
		push	ax
		call	sub_12E34
		add	sp, 2
		push	[bp+var_10]
		push	[bp+var_12]
		mov	ax, offset word_163F2
		push	ds
		push	ax
		call	DoGraphicsThing
		add	sp, 8
		mov	ax, 2
		push	ax
		call	sub_12E34
		add	sp, 2
		push	[bp+var_10]
		push	[bp+var_12]
		call	sub_131D2
		jmp	short loc_1083D
; ---------------------------------------------------------------------------

loc_10816:				; CODE XREF: mes0B_GfxThing+CCj
		mov	ax, 2
		push	ax
		call	sub_12E34
		add	sp, 2
		push	[bp+var_2]
		push	[bp+var_4]
		call	sub_158B8
		add	sp, 4
		mov	es, seg_16420
		push	word ptr es:dword_15EFA+2
		push	word ptr es:dword_15EFA
		call	sub_1324A

loc_1083D:				; CODE XREF: mes0B_GfxThing+13Aj
		add	sp, 4
		mov	ax, 2
		push	ax
		call	sub_12E34
		add	sp, 2
		sub	ax, ax
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retn
mes0B_GfxThing	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

mes0C_GfxThing	proc near		; CODE XREF: GameMain+D4p
					; DATA XREF: seg002:mesJumpTblo

var_C		= word ptr -0Ch
graphicsID	= word ptr -0Ah
var_8		= word ptr -8
var_6		= word ptr -6
var_4		= dword	ptr -4
arg_0		= dword	ptr  4

		push	bp
		mov	bp, sp
		sub	sp, 0Ch
		call	sub_134EC
		les	bx, [bp+arg_0]
		assume es:nothing
		mov	al, es:[bx]
		sub	ah, ah
		mov	[bp+graphicsID], ax
		mov	es, seg_1641C
		assume es:seg001
		mov	ax, es:graphicsCount
		cmp	[bp+graphicsID], ax
		jb	short loc_1087A
		mov	ax, 4		; aBadGraphicID
		mov	sp, bp
		pop	bp
		retn
; ---------------------------------------------------------------------------

loc_1087A:				; CODE XREF: mes0C_GfxThing+1Fj
		mov	es, seg_16418
		mov	ax, word ptr es:mesPtr+2
		mov	[bp+var_6], ax
		mov	bx, [bp+graphicsID]
		shl	bx, 1
		mov	es, seg_1641E
		mov	ax, es:graphicsList[bx]
		mov	[bp+var_8], ax
		mov	es, seg_1640A
		assume es:seg003
		mov	ax, es:word_16A8E
		mov	[bp+graphicsID], ax
		cmp	ax, 100h
		jl	short loc_108A9
		jmp	loc_10982
; ---------------------------------------------------------------------------

loc_108A9:				; CODE XREF: mes0C_GfxThing+52j
		mov	ax, [bp+var_6]
		mov	word ptr [bp+var_4+2], ax
		mov	ax, [bp+var_8]
		mov	word ptr [bp+var_4], ax
		les	bx, [bp+var_4]
		assume es:nothing
		mov	ax, es:[bx+4]
		add	ax, 3
		shr	ax, 1
		shr	ax, 1
		mov	cx, es:[bx]
		shr	cx, 1
		shr	cx, 1
		sub	ax, cx
		inc	ax
		mov	cx, es:[bx+6]
		sub	cx, es:[bx+2]
		inc	cx
		mul	cx
		shl	ax, 1
		shl	ax, 1
		add	ax, 15h
		mov	[bp+var_C], ax
		mov	cl, 4
		shr	[bp+var_C], cl
		mov	es, seg_16422
		assume es:seg001
		mov	ax, es:word_15E20
		mov	es, seg_16424
		sub	ax, es:word_15F6C
		cmp	ax, [bp+var_C]
		jb	short loc_1097A
		mov	es, seg_16426
		mov	ax, es:380h
		mov	es, seg_16424
		add	ax, es:word_15F6C
		mov	bx, [bp+graphicsID]
		shl	bx, 1
		shl	bx, 1
		mov	es, seg_1640C
		assume es:seg003
		lea	bx, dword_1644E[bx]
		mov	es:[bx+2], ax
		mov	bx, [bp+graphicsID]
		shl	bx, 1
		shl	bx, 1
		mov	word ptr es:dword_1644E[bx], 0
		mov	ax, [bp+var_C]
		mov	bx, [bp+graphicsID]
		shl	bx, 1
		mov	es, seg_16428
		mov	es:word_1688E[bx], ax
		mov	es, seg_16424
		assume es:seg001
		add	es:word_15F6C, ax
		mov	bx, [bp+graphicsID]
		shl	bx, 1
		shl	bx, 1
		mov	es, seg_1640C
		assume es:seg003
		push	word ptr es:(dword_1644E+2)[bx]
		push	word ptr es:dword_1644E[bx]
		push	[bp+var_6]
		push	[bp+var_8]
		call	DoGraphicsThing
		add	sp, 8
		inc	[bp+graphicsID]
		mov	es, seg_1640A
		mov	ax, [bp+graphicsID]
		mov	es:word_16A8E, ax
		jmp	short loc_1098A
; ---------------------------------------------------------------------------

loc_1097A:				; CODE XREF: mes0C_GfxThing+A9j
		mov	ax, 6		; error	aNotEnoughMem
		mov	sp, bp
		pop	bp
		retn
; ---------------------------------------------------------------------------
		align 2

loc_10982:				; CODE XREF: mes0C_GfxThing+54j
		mov	ax, 7		; error	aTooManyGFX
		mov	sp, bp
		pop	bp
		retn
; ---------------------------------------------------------------------------
		align 2

loc_1098A:				; CODE XREF: mes0C_GfxThing+126j
		push	[bp+var_6]
		push	[bp+var_8]
		call	sub_158B8
		add	sp, 4
		mov	ax, 3
		push	ax
		call	sub_12E34
		add	sp, 2
		push	[bp+var_6]
		push	[bp+var_8]
		call	sub_158B8
		add	sp, 4
		mov	ax, 3
		push	ax
		call	sub_12E34
		add	sp, 2
		sub	ax, ax
		mov	sp, bp
		pop	bp
		retn
mes0C_GfxThing	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

mes0D		proc near		; CODE XREF: GameMain+D4p
					; DATA XREF: seg002:mesJumpTblo
		push	bp
		mov	bp, sp
		call	sub_134EC
		mov	es, seg_1640A
		dec	es:word_16A8E
		mov	bx, es:word_16A8E
		shl	bx, 1
		shl	bx, 1
		mov	es, seg_1640C
		push	word ptr es:(dword_1644E+2)[bx]
		push	word ptr es:dword_1644E[bx]
		call	sub_131D2
		add	sp, 4
		mov	ax, 3
		push	ax
		call	sub_12E34
		add	sp, 2
		mov	es, seg_1640A
		mov	bx, es:word_16A8E
		shl	bx, 1
		shl	bx, 1
		mov	es, seg_1640C
		push	word ptr es:(dword_1644E+2)[bx]
		push	word ptr es:dword_1644E[bx]
		call	sub_131D2
		add	sp, 4
		mov	ax, 3
		push	ax
		call	sub_12E34
		add	sp, 2
		mov	es, seg_1640A
		mov	bx, es:word_16A8E
		shl	bx, 1
		shl	bx, 1
		mov	es, seg_1640C
		sub	ax, ax
		mov	word ptr es:(dword_1644E+2)[bx], ax
		mov	word ptr es:dword_1644E[bx], ax
		mov	es, seg_1640A
		mov	bx, es:word_16A8E
		shl	bx, 1
		mov	es, seg_16428
		mov	ax, es:word_1688E[bx]
		mov	es, seg_16424
		assume es:seg001
		sub	es:word_15F6C, ax
		sub	ax, ax
		pop	bp
		retn
mes0D		endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

mes0E		proc near		; CODE XREF: GameMain+D4p
					; DATA XREF: seg002:mesJumpTblo

var_2		= byte ptr -2
arg_0		= dword	ptr  4

		push	bp
		mov	bp, sp
		sub	sp, 2
		les	bx, [bp+arg_0]
		assume es:nothing
		mov	al, es:[bx]
		mov	[bp+var_2], al
		test	[bp+var_2], 4
		jz	short loc_10A84
		sub	ah, ah
		and	ax, 1
		push	ax
		call	SetPalette
		add	sp, 2
		sub	ax, ax
		mov	sp, bp
		pop	bp
		retn
; ---------------------------------------------------------------------------
		align 2

loc_10A84:				; CODE XREF: mes0E+13j
		les	bx, [bp+arg_0]
		test	byte ptr es:[bx], 8
		jz	short loc_10A96
		mov	word_163B2, 8
		jmp	short loc_10A9C
; ---------------------------------------------------------------------------
		align 2

loc_10A96:				; CODE XREF: mes0E+2Fj
		mov	word_163B2, 10h

loc_10A9C:				; CODE XREF: mes0E+37j
		mov	es, seg_1642A
		assume es:seg001
		cmp	es:word_15F72, 0
		jz	short loc_10ABE
		push	word_163B2
		mov	es, word ptr [bp+arg_0+2]
		assume es:nothing
		mov	al, es:[bx]
		sub	ah, ah
		and	ax, 1
		push	ax
		call	sub_12F0F
		jmp	short loc_10AD1
; ---------------------------------------------------------------------------
		align 2

loc_10ABE:				; CODE XREF: mes0E+4Aj
		push	word_163B2
		les	bx, [bp+arg_0]
		mov	al, es:[bx]
		sub	ah, ah
		and	ax, 1
		push	ax
		call	sub_12E97

loc_10AD1:				; CODE XREF: mes0E+5Fj
		add	sp, 4
		sub	ax, ax
		mov	sp, bp
		pop	bp
		retn
mes0E		endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

mes0F		proc near		; CODE XREF: GameMain+D4p
					; DATA XREF: seg002:mesJumpTblo

var_2		= byte ptr -2
arg_0		= dword	ptr  4

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	si
		les	bx, [bp+arg_0]
		mov	al, es:[bx]
		mov	[bp+var_2], al
		sub	ah, ah
		mov	si, ax
		mov	es, seg_1642A
		assume es:seg001
		and	ax, 2
		mov	es:word_15F72, ax
		test	[bp+var_2], 4
		jz	short loc_10B0E
		mov	ax, si
		and	ax, 1
		push	ax
		call	sub_130E4
		add	sp, 2
		jmp	short loc_10B46
; ---------------------------------------------------------------------------
		align 2

loc_10B0E:				; CODE XREF: mes0F+23j
		mov	es, seg_1642A
		cmp	es:word_15F72, 0
		jz	short loc_10B30
		push	word_163B2
		les	bx, [bp+arg_0]
		assume es:nothing
		mov	al, es:[bx]
		sub	ah, ah
		and	ax, 1
		push	ax
		call	sub_13054
		jmp	short loc_10B43
; ---------------------------------------------------------------------------
		align 2

loc_10B30:				; CODE XREF: mes0F+3Ej
		push	word_163B2
		les	bx, [bp+arg_0]
		mov	al, es:[bx]
		sub	ah, ah
		and	ax, 1
		push	ax
		call	sub_12FDA

loc_10B43:				; CODE XREF: mes0F+53j
		add	sp, 4

loc_10B46:				; CODE XREF: mes0F+31j
		sub	ax, ax
		pop	si
		mov	sp, bp
		pop	bp
		retn
mes0F		endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

mes10_GfxThing	proc near		; CODE XREF: GameMain+D4p
					; DATA XREF: seg002:mesJumpTblo

var_8		= word ptr -8
var_2		= byte ptr -2
var_1		= byte ptr -1
arg_0		= dword	ptr  4

		push	bp
		mov	bp, sp
		sub	sp, 8
		call	sub_134EC
		les	bx, [bp+arg_0]
		mov	al, es:[bx]
		mov	[bp+var_2], al	; graphics index
		mov	[bp+var_1], 0FFh ; "stop" index
		lea	ax, [bp+var_2]
		push	ss
		push	ax		; push offset of var_2
		call	mes21_GfxThing
		add	sp, 4
		mov	[bp+var_8], ax
		or	ax, ax
		jnz	short loc_10BB7
		mov	es, seg_1640A
		assume es:seg003
		dec	es:word_16A8E
		mov	bx, es:word_16A8E
		shl	bx, 1
		shl	bx, 1
		mov	es, seg_1640C
		sub	ax, ax
		mov	word ptr es:(dword_1644E+2)[bx], ax
		mov	word ptr es:dword_1644E[bx], ax
		mov	es, seg_1640A
		mov	bx, es:word_16A8E
		shl	bx, 1
		mov	es, seg_16428
		mov	ax, es:word_1688E[bx]
		mov	es, seg_16424
		assume es:seg001
		sub	es:word_15F6C, ax
		sub	ax, ax

loc_10BB7:				; CODE XREF: mes10_GfxThing+26j
		mov	sp, bp
		pop	bp
		retn
mes10_GfxThing	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

mes11_GfxThing	proc near		; CODE XREF: GameMain+D4p
					; DATA XREF: seg002:mesJumpTblo

var_26		= byte ptr -26h
var_24		= byte ptr -24h
var_22		= byte ptr -22h
var_20		= byte ptr -20h
var_1E		= byte ptr -1Eh
var_1C		= byte ptr -1Ch
var_1A		= byte ptr -1Ah
var_18		= byte ptr -18h
var_16		= byte ptr -16h
var_14		= word ptr -14h
var_12		= word ptr -12h
var_10		= word ptr -10h
var_E		= dword	ptr -0Eh
var_A		= word ptr -0Ah
var_8		= word ptr -8
var_6		= dword	ptr -6
var_2		= byte ptr -2
var_1		= byte ptr -1
arg_0		= dword	ptr  4

		push	bp
		mov	bp, sp
		sub	sp, 26h
		push	di
		push	si
		call	sub_134EC
		les	bx, [bp+arg_0]
		assume es:nothing
		mov	al, es:[bx]
		mov	[bp+var_2], al	; graphics index
		mov	[bp+var_1], 0FFh ; "stop" index
		lea	ax, [bp+var_2]
		push	ss
		push	ax
		call	mes21_GfxThing
		add	sp, 4
		mov	[bp+var_12], ax
		or	ax, ax
		jz	short loc_10BE9
		jmp	loc_10FDA
; ---------------------------------------------------------------------------

loc_10BE9:				; CODE XREF: mes11_GfxThing+28j
		mov	es, seg_1640A
		assume es:seg003
		dec	es:word_16A8E
		mov	bx, es:word_16A8E
		shl	bx, 1
		shl	bx, 1
		mov	es, seg_1640C
		mov	ax, word ptr es:dword_1644E[bx]
		mov	dx, word ptr es:(dword_1644E+2)[bx]
		mov	word ptr [bp+var_E], ax
		mov	word ptr [bp+var_E+2], dx
		les	bx, [bp+var_E]
		assume es:nothing
		mov	ax, es:[bx]
		mov	[bp+var_8], ax
		add	word ptr [bp+var_E], 2
		mov	bx, word ptr [bp+var_E]
		mov	ax, es:[bx]
		mov	[bp+var_A], ax
		add	word ptr [bp+var_E], 2
		mov	bx, word ptr [bp+var_E]
		mov	ax, es:[bx]
		mov	[bp+var_10], ax
		add	word ptr [bp+var_E], 2
		mov	es, seg_1642C
		assume es:seg001
		mov	ax, es:word_15F6A
		mov	[bp+var_12], ax
		jmp	loc_10E3C
; ---------------------------------------------------------------------------

loc_10C44:				; CODE XREF: mes11_GfxThing+39Bj
		mov	word ptr [bp+var_6+2], 0A800h
		les	bx, [bp+var_6]
		assume es:nothing
		mov	al, [bp+var_18]
		mov	es:[bx], al
		mov	word ptr [bp+var_6+2], 0B000h
		mov	es, word ptr [bp+var_6+2]
		mov	al, [bp+var_16]
		mov	es:[bx], al
		mov	word ptr [bp+var_6+2], 0B800h
		mov	es, word ptr [bp+var_6+2]
		mov	al, [bp+var_1C]
		mov	es:[bx], al
		mov	word ptr [bp+var_6+2], 0E000h
		mov	es, word ptr [bp+var_6+2]
		mov	al, [bp+var_1A]

loc_10C79:				; CODE XREF: mes11_GfxThing+3DEj
		mov	es:[bx], al
		inc	word ptr [bp+var_6]
		dec	si
		jz	short loc_10C85
		jmp	loc_10F17
; ---------------------------------------------------------------------------

loc_10C85:				; CODE XREF: mes11_GfxThing+C4j
		mov	[bp+var_1E], cl

loc_10C88:				; CODE XREF: mes11_GfxThing+350j
		mov	ax, 3
		push	ax
		call	sub_12E34
		add	sp, 2
		mov	word ptr [bp+var_6+2], 0A800h
		mov	ax, 50h
		imul	[bp+var_12]
		add	ax, 5C30h
		mov	word ptr [bp+var_6], ax
		mov	[bp+var_14], 50h
		les	bx, [bp+var_6]
		mov	ax, 0FFFFh
		mov	cx, 28h
		mov	di, bx
		repne stosw
		add	word ptr [bp+var_6], 50h
		mov	word ptr [bp+var_6+2], 0B000h
		mov	ax, 50h
		imul	[bp+var_12]
		add	ax, 5C30h
		mov	word ptr [bp+var_6], ax
		mov	[bp+var_14], 50h
		les	bx, [bp+var_6]
		mov	ax, 0FFFFh
		mov	cx, 28h
		mov	di, bx
		repne stosw
		add	word ptr [bp+var_6], 50h
		mov	word ptr [bp+var_6+2], 0B800h
		mov	ax, 50h
		imul	[bp+var_12]
		add	ax, 5C30h
		mov	word ptr [bp+var_6], ax
		mov	[bp+var_14], 50h
		les	bx, [bp+var_6]
		mov	ax, 0FFFFh
		mov	cx, 28h
		mov	di, bx
		repne stosw
		add	word ptr [bp+var_6], 50h
		mov	word ptr [bp+var_6+2], 0E000h
		mov	ax, 50h
		imul	[bp+var_12]
		add	ax, 5C30h
		mov	word ptr [bp+var_6], ax
		mov	[bp+var_14], 50h
		les	bx, [bp+var_6]
		sub	ax, ax
		mov	cx, 28h
		mov	di, bx
		repne stosw
		add	word ptr [bp+var_6], 50h
		mov	ax, [bp+var_10]
		imul	[bp+var_A]
		shl	ax, 1
		shl	ax, 1
		add	ax, 6
		mov	word ptr [bp+var_E], ax
		mov	ax, 50h
		imul	[bp+var_10]
		add	ax, [bp+var_8]
		mov	word ptr [bp+var_6], ax
		mov	[bp+var_14], 0
		cmp	[bp+var_A], 0
		jg	short loc_10D57
		jmp	loc_10E26
; ---------------------------------------------------------------------------

loc_10D57:				; CODE XREF: mes11_GfxThing+196j
		mov	si, [bp+var_A]
		mov	ax, si
		add	[bp+var_14], ax

loc_10D5F:				; CODE XREF: mes11_GfxThing+264j
		les	bx, [bp+var_E]
		mov	al, es:[bx]
		mov	[bp+var_24], al
		inc	word ptr [bp+var_E]
		mov	bx, word ptr [bp+var_E]
		mov	al, es:[bx]
		mov	[bp+var_26], al
		inc	word ptr [bp+var_E]
		mov	bx, word ptr [bp+var_E]
		mov	al, es:[bx]
		mov	[bp+var_20], al
		inc	word ptr [bp+var_E]
		mov	bx, word ptr [bp+var_E]
		mov	al, es:[bx]
		mov	[bp+var_22], al
		inc	word ptr [bp+var_E]
		mov	cl, al
		xor	cl, 0FFh
		and	cl, [bp+var_24]
		and	cl, [bp+var_26]
		and	cl, [bp+var_20]
		jz	short loc_10DE2
		xor	cl, 0FFh
		mov	word ptr [bp+var_6+2], 0A800h
		les	bx, [bp+var_6]
		mov	al, [bp+var_24]
		and	al, cl
		mov	es:[bx], al
		mov	word ptr [bp+var_6+2], 0B000h
		mov	es, word ptr [bp+var_6+2]
		mov	al, [bp+var_26]
		and	al, cl
		mov	es:[bx], al
		mov	word ptr [bp+var_6+2], 0B800h
		mov	es, word ptr [bp+var_6+2]
		mov	al, [bp+var_20]
		and	al, cl
		mov	es:[bx], al
		mov	word ptr [bp+var_6+2], 0E000h
		mov	es, word ptr [bp+var_6+2]
		mov	al, [bp+var_22]
		and	al, cl
		jmp	short loc_10E17
; ---------------------------------------------------------------------------
		align 2

loc_10DE2:				; CODE XREF: mes11_GfxThing+1E1j
		mov	word ptr [bp+var_6+2], 0A800h
		les	bx, [bp+var_6]
		mov	al, [bp+var_24]
		mov	es:[bx], al
		mov	word ptr [bp+var_6+2], 0B000h
		mov	es, word ptr [bp+var_6+2]
		mov	al, [bp+var_26]
		mov	es:[bx], al
		mov	word ptr [bp+var_6+2], 0B800h
		mov	es, word ptr [bp+var_6+2]
		mov	al, [bp+var_20]
		mov	es:[bx], al
		mov	word ptr [bp+var_6+2], 0E000h
		mov	es, word ptr [bp+var_6+2]
		mov	al, [bp+var_22]

loc_10E17:				; CODE XREF: mes11_GfxThing+223j
		mov	es:[bx], al
		inc	word ptr [bp+var_6]
		dec	si
		jz	short loc_10E23
		jmp	loc_10D5F
; ---------------------------------------------------------------------------

loc_10E23:				; CODE XREF: mes11_GfxThing+262j
		mov	[bp+var_1E], cl

loc_10E26:				; CODE XREF: mes11_GfxThing+198j
		mov	ax, 3
		push	ax
		call	sub_12E34
		add	sp, 2
		push	[bp+var_12]
		call	sub_15BBA
		add	sp, 2
		dec	[bp+var_12]

loc_10E3C:				; CODE XREF: mes11_GfxThing+85j
		cmp	[bp+var_10], 0
		jg	short loc_10E45
		jmp	loc_10F9E
; ---------------------------------------------------------------------------

loc_10E45:				; CODE XREF: mes11_GfxThing+284j
		dec	[bp+var_10]
		mov	word ptr [bp+var_6+2], 0A800h
		mov	ax, 50h
		imul	[bp+var_12]
		add	ax, 5C30h
		mov	word ptr [bp+var_6], ax
		mov	[bp+var_14], 0

loc_10E5E:				; CODE XREF: mes11_GfxThing+2B3j
		les	bx, [bp+var_6]
		inc	word ptr [bp+var_6]
		mov	byte ptr es:[bx], 0FFh
		inc	[bp+var_14]
		cmp	[bp+var_14], 50h
		jl	short loc_10E5E
		mov	word ptr [bp+var_6+2], 0B000h
		mov	ax, 50h
		imul	[bp+var_12]
		add	ax, 5C30h
		mov	word ptr [bp+var_6], ax
		mov	[bp+var_14], 50h
		les	bx, [bp+var_6]
		mov	ax, 0FFFFh
		mov	cx, 28h
		mov	di, bx
		repne stosw
		add	word ptr [bp+var_6], 50h
		mov	word ptr [bp+var_6+2], 0B800h
		mov	ax, 50h
		imul	[bp+var_12]
		add	ax, 5C30h
		mov	word ptr [bp+var_6], ax
		mov	[bp+var_14], 50h
		les	bx, [bp+var_6]
		mov	ax, 0FFFFh
		mov	cx, 28h
		mov	di, bx
		repne stosw
		add	word ptr [bp+var_6], 50h
		mov	word ptr [bp+var_6+2], 0E000h
		mov	ax, 50h
		imul	[bp+var_12]
		add	ax, 5C30h
		mov	word ptr [bp+var_6], ax
		mov	[bp+var_14], 50h
		les	bx, [bp+var_6]
		sub	ax, ax
		mov	cx, 28h
		mov	di, bx
		repne stosw
		add	word ptr [bp+var_6], 50h
		mov	ax, [bp+var_10]
		imul	[bp+var_A]
		shl	ax, 1
		shl	ax, 1
		add	ax, 6
		mov	word ptr [bp+var_E], ax
		mov	ax, 50h
		imul	[bp+var_10]
		add	ax, [bp+var_8]
		mov	word ptr [bp+var_6], ax
		mov	[bp+var_14], 0
		cmp	[bp+var_A], 0
		jg	short loc_10F0F
		jmp	loc_10C88
; ---------------------------------------------------------------------------

loc_10F0F:				; CODE XREF: mes11_GfxThing+34Ej
		mov	si, [bp+var_A]
		mov	ax, si
		add	[bp+var_14], ax

loc_10F17:				; CODE XREF: mes11_GfxThing+C6j
		les	bx, [bp+var_E]
		mov	al, es:[bx]
		mov	[bp+var_18], al
		inc	word ptr [bp+var_E]
		mov	bx, word ptr [bp+var_E]
		mov	al, es:[bx]
		mov	[bp+var_16], al
		inc	word ptr [bp+var_E]
		mov	bx, word ptr [bp+var_E]
		mov	al, es:[bx]
		mov	[bp+var_1C], al
		inc	word ptr [bp+var_E]
		mov	bx, word ptr [bp+var_E]
		mov	al, es:[bx]
		mov	[bp+var_1A], al
		inc	word ptr [bp+var_E]
		mov	cl, al
		xor	cl, 0FFh
		and	cl, [bp+var_18]
		and	cl, [bp+var_16]
		and	cl, [bp+var_1C]
		jnz	short loc_10F5A
		jmp	loc_10C44
; ---------------------------------------------------------------------------

loc_10F5A:				; CODE XREF: mes11_GfxThing+399j
		xor	cl, 0FFh
		mov	word ptr [bp+var_6+2], 0A800h
		les	bx, [bp+var_6]
		mov	al, [bp+var_18]
		and	al, cl
		mov	es:[bx], al
		mov	word ptr [bp+var_6+2], 0B000h
		mov	es, word ptr [bp+var_6+2]
		mov	al, [bp+var_16]
		and	al, cl
		mov	es:[bx], al
		mov	word ptr [bp+var_6+2], 0B800h
		mov	es, word ptr [bp+var_6+2]
		mov	al, [bp+var_1C]
		and	al, cl
		mov	es:[bx], al
		mov	word ptr [bp+var_6+2], 0E000h
		mov	es, word ptr [bp+var_6+2]
		mov	al, [bp+var_1A]
		and	al, cl
		jmp	loc_10C79
; ---------------------------------------------------------------------------
		align 2

loc_10F9E:				; CODE XREF: mes11_GfxThing+286j
		mov	es, seg_1640A
		assume es:seg003
		mov	bx, es:word_16A8E
		shl	bx, 1
		shl	bx, 1
		mov	es, seg_1640C
		sub	ax, ax
		mov	word ptr es:(dword_1644E+2)[bx], ax
		mov	word ptr es:dword_1644E[bx], ax
		mov	es, seg_1640A
		mov	bx, es:word_16A8E
		shl	bx, 1
		mov	es, seg_16428
		mov	ax, es:word_1688E[bx]
		mov	es, seg_16424
		assume es:seg001
		sub	es:word_15F6C, ax
		sub	ax, ax

loc_10FDA:				; CODE XREF: mes11_GfxThing+2Aj
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retn
mes11_GfxThing	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

mes12_ClearVRAM	proc near		; CODE XREF: GameMain+D4p
					; DATA XREF: seg002:mesJumpTblo

var_2		= byte ptr -2
arg_0		= dword	ptr  4

		push	bp
		mov	bp, sp
		sub	sp, 2
		call	sub_134EC
		les	bx, [bp+arg_0]
		assume es:nothing
		mov	al, es:[bx]
		mov	[bp+var_2], al
		or	al, al
		jz	short loc_1101A
		test	[bp+var_2], 2
		jz	short loc_10FFF
		call	ClearTextVRAM

loc_10FFF:				; CODE XREF: mes12_ClearVRAM+1Aj
		les	bx, [bp+arg_0]
		test	byte ptr es:[bx], 1
		jz	short loc_11034
		call	ClearPixelVRAM
		mov	ax, 3
		push	ax
		call	sub_12E34
		add	sp, 2
		call	ClearPixelVRAM
		jmp	short loc_1102A
; ---------------------------------------------------------------------------

loc_1101A:				; CODE XREF: mes12_ClearVRAM+14j
		call	sub_1246E
		mov	ax, 3
		push	ax
		call	sub_12E34
		add	sp, 2
		call	sub_1246E

loc_1102A:				; CODE XREF: mes12_ClearVRAM+38j
		mov	ax, 3
		push	ax
		call	sub_12E34
		add	sp, 2

loc_11034:				; CODE XREF: mes12_ClearVRAM+26j
		sub	ax, ax
		mov	sp, bp
		pop	bp
		retn
mes12_ClearVRAM	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

mes13		proc near		; CODE XREF: GameMain+D4p
					; DATA XREF: seg002:mesJumpTblo

var_A		= word ptr -0Ah
var_8		= dword	ptr -8
var_2		= word ptr -2
arg_0		= dword	ptr  4

		push	bp
		mov	bp, sp
		sub	sp, 0Ah
		push	di
		push	si
		call	sub_134EC
		mov	ax, seg	seg003
		mov	es, ax
		assume es:seg003
		mov	es:word_16A90, 0
		les	bx, [bp+arg_0]
		assume es:nothing
		inc	word ptr [bp+arg_0]
		mov	al, es:[bx]	; read number of items
		mov	cx, seg	seg003
		mov	es, cx
		assume es:seg003
		mov	byte ptr es:word_16AD2,	al
		mov	[bp+var_2], 0
		mov	ax, cx
		mov	al, byte ptr es:word_16AD2
		sub	ah, ah
		or	ax, ax
		jz	short loc_110CE
		mov	ax, cx
		mov	al, byte ptr es:word_16AD2
		sub	ah, ah
		mov	di, ax
		mov	word ptr [bp+var_8], offset unk_1684E
		mov	word ptr [bp+var_8+2], seg seg003
		mov	cx, [bp+var_2]
		mov	[bp+var_A], ds
		lds	si, [bp+var_8]

loc_11091:				; CODE XREF: mes13+8Cj
		les	bx, [bp+arg_0]
		assume es:nothing
		mov	ax, es:[bx]	; read file data pointer
		mov	[si], ax
		mov	ax, seg	seg001
		mov	es, ax
		assume es:seg001
		mov	ax, word ptr es:mesDataPtr+2
		mov	[si+2],	ax
		add	word ptr [bp+arg_0], 2
		les	bx, [bp+arg_0]
		assume es:nothing
		mov	al, es:[bx]	; read ??
		mov	bx, cx
		mov	dx, seg	seg003
		mov	es, dx
		assume es:seg003
		mov	es:byte_16A92[bx], al
		inc	word ptr [bp+arg_0]
		add	si, 4
		inc	cx
		mov	ax, cx
		cmp	ax, di
		jb	short loc_11091
		mov	ds, [bp+var_A]
		mov	[bp+var_2], cx

loc_110CE:				; CODE XREF: mes13+38j
		mov	bx, seg	seg003
		mov	es, bx
		mov	di, es:word_16A90
		mov	si, [bp+var_2]
		jmp	short loc_110E8
; ---------------------------------------------------------------------------
		align 2

loc_110DE:				; CODE XREF: mes13+B1j
		mov	ax, 1
		mov	cx, si
		shl	ax, cl
		or	di, ax
		inc	si

loc_110E8:				; CODE XREF: mes13+A1j
		cmp	si, 10h
		jl	short loc_110DE
		mov	ax, seg	seg003
		mov	es, ax
		mov	es:word_16A90, di
		mov	[bp+var_2], si
		mov	[bp+var_2], 0
		mov	ax, seg	seg003
		mov	es, ax
		mov	al, byte ptr es:word_16AD2
		sub	ah, ah
		or	ax, ax
		jz	short loc_11155
		mov	ax, es
		mov	al, byte ptr es:word_16AD2
		sub	ah, ah
		mov	[bp+var_A], ax
		mov	word ptr [bp+var_8], ax
		mov	bx, [bp+var_2]
		mov	ax, seg	seg003
		mov	es, ax
		sub	al, al
		mov	cx, word ptr [bp+var_8]
		lea	di, [bx+662h]
		repne stosb
		mov	ax, seg	seg003
		mov	es, ax
		sub	al, al
		mov	cx, word ptr [bp+var_8]
		lea	di, [bx+672h]
		repne stosb
		mov	ax, seg	seg003
		mov	es, ax
		mov	al, 0FFh
		mov	cx, word ptr [bp+var_8]
		lea	di, [bx+682h]
		repne stosb
		mov	ax, word ptr [bp+var_8]
		add	[bp+var_2], ax

loc_11155:				; CODE XREF: mes13+D2j
		sub	ax, ax
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retn
mes13		endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

mes14_SetMsgSpd	proc near		; CODE XREF: GameMain+D4p
					; DATA XREF: seg002:mesJumpTblo

arg_0		= dword	ptr  4

		push	bp
		mov	bp, sp
		les	bx, [bp+arg_0]
		assume es:nothing
		mov	al, es:[bx]
		sub	ah, ah
		mov	messageSpeed, ax
		sub	ax, ax
		pop	bp
		retn
mes14_SetMsgSpd	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

mes15_WaitUser	proc near		; CODE XREF: GameMain+D4p
					; DATA XREF: seg002:mesJumpTblo
		push	bp
		mov	bp, sp
		sub	ax, ax
		push	ax
		call	sub_13133
		add	sp, 2
		mov	ax, 1
		push	ax
		call	sub_13133
		add	sp, 2
		sub	ax, ax
		push	ax
		call	sub_13133
		add	sp, 2
		jmp	short loc_11195
; ---------------------------------------------------------------------------
		align 2

loc_11192:				; CODE XREF: mes15_WaitUser+2Aj
		call	CallInt18Func00

loc_11195:				; CODE XREF: mes15_WaitUser+1Fj
		call	CallInt18Func01
		or	ax, ax
		jnz	short loc_11192
		sub	ax, ax
		pop	bp
		retn
mes15_WaitUser	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

mes16_ChrName	proc near		; CODE XREF: GameMain+D4p
					; DATA XREF: seg002:mesJumpTblo

var_2		= word ptr -2
arg_0		= dword	ptr  4

		push	bp
		mov	bp, sp
		sub	sp, 2
		les	bx, [bp+arg_0]
		inc	word ptr [bp+arg_0]
		mov	al, es:[bx]	; read character ID
		sub	ah, ah
		mov	[bp+var_2], ax
		mov	bx, word ptr [bp+arg_0]
		inc	word ptr [bp+arg_0]
		mov	al, es:[bx]	; read colour index
		mov	bx, [bp+var_2]
		mov	es, seg_16412
		assume es:seg001
		mov	es:characterCols[bx], al
		mov	ax, word ptr [bp+arg_0]
		mov	dx, word ptr [bp+arg_0+2]
		shl	bx, 1
		shl	bx, 1
		mov	es, seg_16414
		mov	word ptr es:characterNames[bx],	ax
		mov	word ptr es:(characterNames+2)[bx], dx
		sub	ax, ax
		mov	sp, bp
		pop	bp
		retn
mes16_ChrName	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

mes17_ChrSomething proc	near		; CODE XREF: GameMain+D4p
					; DATA XREF: seg002:mesJumpTblo

var_2		= word ptr -2
arg_0		= dword	ptr  4

		push	bp
		mov	bp, sp
		sub	sp, 2
		les	bx, [bp+arg_0]
		assume es:nothing
		inc	word ptr [bp+arg_0]
		mov	al, es:[bx]	; read character ID
		sub	ah, ah
		mov	[bp+var_2], ax
		mov	bx, word ptr [bp+arg_0]
		inc	word ptr [bp+arg_0]
		mov	al, es:[bx]
		mov	byte_163C6, al
		mov	ax, word ptr [bp+arg_0]
		mov	dx, es
		mov	bx, [bp+var_2]
		shl	bx, 1
		shl	bx, 1
		mov	es, seg_16416
		assume es:seg001
		mov	word ptr es:dword_15E22[bx], ax
		mov	word ptr es:(dword_15E22+2)[bx], dx
		sub	ax, ax
		mov	sp, bp
		pop	bp
		retn
mes17_ChrSomething endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

mes18_PlayBGM	proc near		; CODE XREF: GameMain+D4p
					; DATA XREF: seg002:mesJumpTblo

arg_0		= word ptr  4
arg_2		= word ptr  6

		push	bp
		mov	bp, sp
		push	[bp+arg_2]
		push	[bp+arg_0]
		call	PlayBGM
		add	sp, 4
		sub	ax, ax
		pop	bp
		retn
mes18_PlayBGM	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

mes19_SelText	proc near		; CODE XREF: GameMain+D4p
					; DATA XREF: seg002:mesJumpTblo

selTxtListPtr	= dword	ptr -8
var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= dword	ptr  4

		push	bp
		mov	bp, sp
		sub	sp, 8
		push	di
		push	si
		les	bx, [bp+arg_0]
		assume es:nothing
		inc	word ptr [bp+arg_0]
		mov	al, es:[bx]	; get number of	texts
		sub	ah, ah
		mov	es, seg_1642E
		assume es:seg001
		mov	es:SelectEntryCnt, ax
		mov	es, seg_16430
		mov	es:SelectTxtMaxLen, 0
		mov	[bp+var_4], 0
		mov	es, seg_1642E
		or	ax, ax
		jz	short loc_112CD	; no entries - return
		mov	word ptr [bp+selTxtListPtr], offset SelectTextPtrs
		mov	word ptr [bp+selTxtListPtr+2], seg seg001
		mov	si, [bp+var_4]

loc_1127C:				; CODE XREF: mes19_SelText+89j
		sub	cx, cx
		les	bx, [bp+selTxtListPtr]
		assume es:nothing
		mov	ax, word ptr [bp+arg_0]
		mov	dx, word ptr [bp+arg_0+2]
		mov	es:[bx], ax	; store	text start pointer
		mov	es:[bx+2], dx
		les	di, [bp+arg_0]
		jmp	short loc_11296
; ---------------------------------------------------------------------------
		align 2

loc_11294:				; CODE XREF: mes19_SelText+5Ej
		inc	cx
		inc	di

loc_11296:				; CODE XREF: mes19_SelText+55j
		cmp	byte ptr es:[di], 0
		jnz	short loc_11294	; find end of the text string
		mov	word ptr [bp+arg_0], di
		mov	word ptr [bp+arg_0+2], es
		mov	es, seg_16430
		assume es:seg001
		cmp	es:SelectTxtMaxLen, cx
		jnb	short loc_112B2
		mov	es:SelectTxtMaxLen, cx ; store maximum text length of all selection entries

loc_112B2:				; CODE XREF: mes19_SelText+6Fj
		inc	word ptr [bp+arg_0] ; skip \0 terminator byte
		add	word ptr [bp+selTxtListPtr], 4
		inc	si
		mov	ax, si
		mov	es, seg_1642E
		cmp	ax, es:SelectEntryCnt
		jb	short loc_1127C
		mov	[bp+var_4], si
		mov	[bp+var_2], cx

loc_112CD:				; CODE XREF: mes19_SelText+31j
		sub	ax, ax
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retn
mes19_SelText	endp

; ---------------------------------------------------------------------------
		align 2
		assume es:nothing

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_112D6	proc near		; CODE XREF: DoMenuSelection+2Bp
					; DoMenuSelection+BDp

var_2C		= word ptr -2Ch
var_2A		= word ptr -2Ah
var_28		= word ptr -28h
var_26		= word ptr -26h
var_24		= word ptr -24h
var_22		= word ptr -22h
var_20		= word ptr -20h
var_1E		= word ptr -1Eh
var_1C		= word ptr -1Ch
var_1A		= word ptr -1Ah
var_18		= word ptr -18h
var_16		= word ptr -16h
var_14		= word ptr -14h
var_12		= word ptr -12h
var_10		= word ptr -10h
var_E		= word ptr -0Eh
var_C		= word ptr -0Ch
var_A		= word ptr -0Ah
var_8		= word ptr -8
var_6		= word ptr -6
var_4		= dword	ptr -4
arg_0		= word ptr  4
arg_2		= word ptr  6
arg_4		= word ptr  8

		push	bp
		mov	bp, sp
		sub	sp, 2Ch
		push	di
		push	si
		mov	ax, word_163FC
		cmp	[bp+arg_0], ax
		jnz	short loc_112E9
		jmp	loc_115A1
; ---------------------------------------------------------------------------

loc_112E9:				; CODE XREF: sub_112D6+Ej
		or	ax, ax
		jnz	short loc_112F0
		jmp	loc_11435
; ---------------------------------------------------------------------------

loc_112F0:				; CODE XREF: sub_112D6+15j
		mov	ax, [bp+arg_4]
		add	ax, word_163FC
		mov	cx, 500h
		imul	cx
		add	ax, [bp+arg_2]
		sub	ax, 501h
		mov	[bp+var_6], ax
		mov	word ptr [bp+var_4], ax
		mov	[bp+var_8], 10h
		mov	es, seg_16430
		assume es:seg001
		mov	ax, 4Eh	; 'N'
		sub	ax, es:SelectTxtMaxLen
		mov	[bp+var_22], ax
		mov	ax, es:SelectTxtMaxLen
		add	ax, 2
		mov	[bp+var_24], ax
		mov	[bp+var_26], ax
		mov	[bp+var_28], ax
		mov	[bp+var_2A], ax
		mov	[bp+var_2C], 10h
		mov	di, [bp+var_1E]

loc_11337:				; CODE XREF: sub_112D6+122j
		mov	word ptr [bp+var_4+2], 0A800h
		sub	si, si
		cmp	[bp+var_2A], si
		jz	short loc_11362
		mov	ax, [bp+var_2A]
		mov	[bp+var_C], ax
		mov	[bp+var_E], ax
		les	bx, [bp+var_4]
		assume es:seg002
		mov	al, 0FFh
		mov	cx, [bp+var_E]
		push	di
		mov	di, bx
		repne stosb
		pop	di
		mov	ax, [bp+var_E]
		add	word ptr [bp+var_4], ax
		add	si, ax

loc_11362:				; CODE XREF: sub_112D6+6Bj
		mov	ax, [bp+var_28]
		mov	[bp+var_14], ax
		sub	word ptr [bp+var_4], ax
		mov	word ptr [bp+var_4+2], 0B000h
		sub	si, si
		cmp	ax, si
		jz	short loc_11392
		mov	[bp+var_10], ax
		mov	[bp+var_12], ax
		les	bx, [bp+var_4]
		assume es:nothing
		mov	al, 0FFh
		mov	cx, [bp+var_12]
		push	di
		mov	di, bx
		repne stosb
		pop	di
		mov	ax, [bp+var_12]
		add	word ptr [bp+var_4], ax
		add	si, ax

loc_11392:				; CODE XREF: sub_112D6+9Ej
		mov	ax, [bp+var_26]
		mov	[bp+var_1A], ax
		sub	word ptr [bp+var_4], ax
		mov	word ptr [bp+var_4+2], 0B800h
		sub	si, si
		cmp	ax, si
		jz	short loc_113C2
		mov	[bp+var_16], ax
		mov	[bp+var_18], ax
		les	bx, [bp+var_4]
		mov	al, 0FFh
		mov	cx, [bp+var_18]
		push	di
		mov	di, bx
		repne stosb
		pop	di
		mov	ax, [bp+var_18]
		add	word ptr [bp+var_4], ax
		add	si, ax

loc_113C2:				; CODE XREF: sub_112D6+CEj
		mov	ax, [bp+var_24]
		mov	[bp+var_20], ax
		sub	word ptr [bp+var_4], ax
		mov	word ptr [bp+var_4+2], 0E000h
		sub	si, si
		cmp	ax, si
		jz	short loc_113ED
		mov	[bp+var_1C], ax
		mov	di, ax
		les	bx, [bp+var_4]
		mov	al, 0FFh
		mov	cx, di
		push	di
		mov	di, bx
		repne stosb
		pop	di
		add	word ptr [bp+var_4], di
		add	si, di

loc_113ED:				; CODE XREF: sub_112D6+FEj
		mov	ax, [bp+var_22]
		add	word ptr [bp+var_4], ax
		dec	[bp+var_2C]
		jz	short loc_113FB
		jmp	loc_11337
; ---------------------------------------------------------------------------

loc_113FB:				; CODE XREF: sub_112D6+120j
		mov	[bp+var_A], si
		mov	ax, [bp+arg_4]
		add	ax, word_163FC
		dec	ax
		push	ax
		push	[bp+arg_2]
		call	GetTextBoxData
		add	sp, 4
		sub	ax, ax
		push	ax
		call	SetTextGFXAddr
		add	sp, 2
		mov	bx, word_163FC
		shl	bx, 1
		shl	bx, 1
		mov	es, seg_16432
		assume es:seg001
		push	es:mesFlagValue[bx]
		push	es:word_15F26[bx]
		call	PrintText	; print	?? text	(word_15F26[bx])
		add	sp, 4

loc_11435:				; CODE XREF: sub_112D6+17j
		cmp	[bp+arg_0], 0
		jnz	short loc_1143E
		jmp	loc_1159B
; ---------------------------------------------------------------------------

loc_1143E:				; CODE XREF: sub_112D6+163j
		mov	ax, [bp+arg_4]
		add	ax, [bp+arg_0]
		mov	cx, 500h
		imul	cx
		add	ax, [bp+arg_2]
		sub	ax, 501h
		mov	[bp+var_6], ax
		mov	word ptr [bp+var_4], ax
		mov	[bp+var_8], 10h
		mov	es, seg_16430
		mov	ax, 4Fh	; 'O'
		sub	ax, es:SelectTxtMaxLen
		mov	[bp+var_16], ax
		mov	ax, es:SelectTxtMaxLen
		inc	ax
		mov	[bp+var_14], ax
		mov	[bp+var_12], ax
		mov	[bp+var_10], ax
		mov	[bp+var_E], ax
		mov	[bp+var_C], 10h
		mov	di, [bp+var_1A]

loc_11482:				; CODE XREF: sub_112D6+289j
		mov	word ptr [bp+var_4+2], 0A800h
		sub	si, si
		cmp	[bp+var_E], si
		jz	short loc_114AD
		mov	ax, [bp+var_E]
		mov	[bp+var_2C], ax
		mov	[bp+var_2A], ax
		les	bx, [bp+var_4]
		assume es:nothing
		sub	al, al
		mov	cx, [bp+var_2A]
		push	di
		mov	di, bx
		repne stosb
		pop	di
		mov	ax, [bp+var_2A]
		add	word ptr [bp+var_4], ax
		add	si, ax

loc_114AD:				; CODE XREF: sub_112D6+1B6j
		les	bx, [bp+var_4]
		mov	byte ptr es:[bx], 1
		mov	ax, [bp+var_10]
		mov	[bp+var_24], ax
		sub	word ptr [bp+var_4], ax
		mov	word ptr [bp+var_4+2], 0B000h
		sub	si, si
		cmp	ax, si
		jz	short loc_114E4
		mov	[bp+var_28], ax
		mov	[bp+var_26], ax
		les	bx, [bp+var_4]
		sub	al, al
		mov	cx, [bp+var_26]
		push	di
		mov	di, bx
		repne stosb
		pop	di
		mov	ax, [bp+var_26]
		add	word ptr [bp+var_4], ax
		add	si, ax

loc_114E4:				; CODE XREF: sub_112D6+1F0j
		les	bx, [bp+var_4]
		mov	byte ptr es:[bx], 1
		mov	ax, [bp+var_12]
		mov	[bp+var_1E], ax
		sub	word ptr [bp+var_4], ax
		mov	word ptr [bp+var_4+2], 0B800h
		sub	si, si
		cmp	ax, si
		jz	short loc_1151B
		mov	[bp+var_22], ax
		mov	[bp+var_20], ax
		les	bx, [bp+var_4]
		sub	al, al
		mov	cx, [bp+var_20]
		push	di
		mov	di, bx
		repne stosb
		pop	di
		mov	ax, [bp+var_20]
		add	word ptr [bp+var_4], ax
		add	si, ax

loc_1151B:				; CODE XREF: sub_112D6+227j
		les	bx, [bp+var_4]
		mov	byte ptr es:[bx], 1
		mov	ax, [bp+var_14]
		mov	[bp+var_18], ax
		sub	word ptr [bp+var_4], ax
		mov	word ptr [bp+var_4+2], 0E000h
		sub	si, si
		cmp	ax, si
		jz	short loc_1154D
		mov	[bp+var_1C], ax
		mov	di, ax
		les	bx, [bp+var_4]
		sub	al, al
		mov	cx, di
		push	di
		mov	di, bx
		repne stosb
		pop	di
		add	word ptr [bp+var_4], di
		add	si, di

loc_1154D:				; CODE XREF: sub_112D6+25Ej
		les	bx, [bp+var_4]
		mov	byte ptr es:[bx], 1
		mov	ax, [bp+var_16]
		add	word ptr [bp+var_4], ax
		dec	[bp+var_C]
		jz	short loc_11562
		jmp	loc_11482
; ---------------------------------------------------------------------------

loc_11562:				; CODE XREF: sub_112D6+287j
		mov	[bp+var_A], si
		mov	ax, [bp+arg_4]
		add	ax, [bp+arg_0]
		dec	ax
		push	ax
		push	[bp+arg_2]
		call	GetTextBoxData
		add	sp, 4
		mov	ax, 7
		push	ax
		call	SetTextGFXAddr
		add	sp, 2
		mov	bx, [bp+arg_0]
		shl	bx, 1
		shl	bx, 1
		mov	es, seg_16432
		assume es:seg001
		push	es:mesFlagValue[bx]
		push	es:word_15F26[bx]
		call	PrintText	; print	?? text	(word_15F26[bx])
		add	sp, 4

loc_1159B:				; CODE XREF: sub_112D6+165j
		mov	ax, [bp+arg_0]
		mov	word_163FC, ax

loc_115A1:				; CODE XREF: sub_112D6+10j
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retn
sub_112D6	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

DoMenuSelection	proc near		; CODE XREF: mes1A_DoSelect+28Cp

var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  4
arg_2		= word ptr  6
arg_4		= word ptr  8

		push	bp
		mov	bp, sp
		sub	sp, 4
		push	di
		push	si
		sub	ax, ax
		push	ax
		call	sub_13133
		add	sp, 2
		jmp	short loc_115BF
; ---------------------------------------------------------------------------
		align 2

loc_115BC:				; CODE XREF: DoMenuSelection+1Cj
		call	CallInt18Func00

loc_115BF:				; CODE XREF: DoMenuSelection+11j
		call	CallInt18Func01
		or	ax, ax
		jnz	short loc_115BC
		mov	di, 1
		mov	si, [bp+var_4]

loc_115CC:				; CODE XREF: DoMenuSelection+71j
					; DoMenuSelection+9Cj ...
		push	[bp+arg_4]
		push	[bp+arg_2]
		push	di
		call	sub_112D6
		add	sp, 6
		mov	ax, 10h
		push	ax
		sub	ax, ax
		push	ax
		call	sub_12D79
		add	sp, 4

loc_115E6:				; CODE XREF: DoMenuSelection+85j
		call	CallInt18Func01
		or	ax, ax
		jnz	short loc_11634
		call	sub_12D99
		mov	si, ax
		test	al, 2
		jz	short loc_1161C
		mov	si, 'G'

loc_115F9:				; CODE XREF: DoMenuSelection+80j
					; DoMenuSelection+8Aj ...
		mov	ax, si
		cmp	ax, '4'
		jz	short loc_1165C
		cmp	ax, ':'
		jz	short loc_1164C
		cmp	ax, '='
		jz	short loc_11640
		cmp	ax, 'C'
		jz	short loc_1164C
		cmp	ax, 'G'
		jz	short loc_1165C
		cmp	ax, 'K'
		jz	short loc_11640
		jmp	short loc_115CC
; ---------------------------------------------------------------------------
		align 2

loc_1161C:				; CODE XREF: DoMenuSelection+4Cj
		call	sub_12D8F
		mov	si, ax
		or	si, si
		jnz	short loc_1162A
		mov	si, 'C'
		jmp	short loc_115F9
; ---------------------------------------------------------------------------

loc_1162A:				; CODE XREF: DoMenuSelection+7Bj
		cmp	si, ' '
		jle	short loc_115E6
		mov	si, 'K'
		jmp	short loc_115F9
; ---------------------------------------------------------------------------

loc_11634:				; CODE XREF: DoMenuSelection+43j
		call	CallInt18Func00
		mov	si, ax
		mov	cl, 8
		sar	si, cl
		jmp	short loc_115F9
; ---------------------------------------------------------------------------
		align 2

loc_11640:				; CODE XREF: DoMenuSelection+60j
					; DoMenuSelection+6Fj
		inc	di
		cmp	di, [bp+arg_0]
		jle	short loc_115CC
		mov	di, [bp+arg_0]
		jmp	short loc_115CC
; ---------------------------------------------------------------------------
		align 2

loc_1164C:				; CODE XREF: DoMenuSelection+5Bj
					; DoMenuSelection+65j
		dec	di
		cmp	di, 1
		jl	short loc_11655
		jmp	loc_115CC
; ---------------------------------------------------------------------------

loc_11655:				; CODE XREF: DoMenuSelection+A8j
		mov	di, 1
		jmp	loc_115CC
; ---------------------------------------------------------------------------
		align 2

loc_1165C:				; CODE XREF: DoMenuSelection+56j
					; DoMenuSelection+6Aj
		push	[bp+arg_4]
		push	[bp+arg_2]
		sub	ax, ax
		push	ax
		call	sub_112D6
		add	sp, 6
		mov	ax, di
		mov	[bp+var_2], di
		mov	[bp+var_4], si
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retn
DoMenuSelection	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

mes1A_DoSelect	proc near		; CODE XREF: GameMain+D4p
					; DATA XREF: seg002:mesJumpTblo

selTextPtr	= dword	ptr -1Ch
selJumpPtr	= dword	ptr -18h
var_14		= word ptr -14h
var_12		= word ptr -12h
var_10		= word ptr -10h
var_E		= word ptr -0Eh
var_C		= word ptr -0Ch
var_A		= word ptr -0Ah
var_8		= word ptr -8
var_6		= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= dword	ptr  4

		push	bp
		mov	bp, sp
		sub	sp, 1Ch
		push	di
		push	si
		mov	es, seg_16430
		mov	ax, es:SelectTxtMaxLen
		add	ax, 3
		mov	[bp+var_10], ax
		mov	ax, word_163B8
		sub	ax, [bp+var_10]
		sub	ax, word_163B4
		inc	ax
		cwd
		sub	ax, dx
		sar	ax, 1
		add	ax, word_163B4
		mov	[bp+var_C], ax
		mov	cl, 2
		shl	[bp+var_C], cl
		shl	[bp+var_10], cl
		mov	es, seg_1642E
		mov	ax, es:SelectEntryCnt
		mov	cl, 4
		shl	ax, cl
		add	ax, 9
		mov	[bp+var_14], ax
		mov	ax, word_163BA
		sub	ax, [bp+var_14]
		sub	ax, word_163B6
		inc	ax
		cwd
		sub	ax, dx
		sar	ax, 1
		add	ax, word_163B6
		mov	[bp+var_12], ax
		and	byte ptr [bp+var_12], 0F0h
		dec	[bp+var_12]
		cmp	[bp+var_C], 0
		jl	short loc_116EB
		cmp	[bp+var_12], 0
		jge	short loc_116F4

loc_116EB:				; CODE XREF: mes1A_DoSelect+69j
		mov	ax, 8
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retn
; ---------------------------------------------------------------------------

loc_116F4:				; CODE XREF: mes1A_DoSelect+6Fj
		mov	ax, [bp+var_C]
		mov	[bp+var_8], ax
		mov	ax, [bp+var_12]
		mov	[bp+var_6], ax
		mov	ax, [bp+var_C]
		add	ax, [bp+var_10]
		dec	ax
		mov	[bp+var_4], ax
		mov	ax, [bp+var_12]
		add	ax, [bp+var_14]
		dec	ax
		mov	[bp+var_2], ax
		mov	es, seg_1640A
		assume es:seg003
		mov	ax, es:word_16A8E
		mov	[bp+var_A], ax
		cmp	ax, 100h
		jl	short loc_11727
		jmp	loc_117F0
; ---------------------------------------------------------------------------

loc_11727:				; CODE XREF: mes1A_DoSelect+A8j
		mov	es, seg_16430
		assume es:seg001
		mov	ax, es:SelectTxtMaxLen
		add	ax, 3
		mul	[bp+var_14]
		shl	ax, 1
		shl	ax, 1
		add	ax, 15h
		mov	[bp+var_E], ax
		mov	cl, 4
		shr	[bp+var_E], cl
		mov	es, seg_16422
		mov	ax, es:word_15E20
		mov	es, seg_16424
		sub	ax, es:word_15F6C
		cmp	ax, [bp+var_E]
		jnb	short loc_1175D
		jmp	loc_117E6
; ---------------------------------------------------------------------------

loc_1175D:				; CODE XREF: mes1A_DoSelect+DEj
		call	sub_134EC
		mov	ax, 2
		push	ax
		call	sub_12E34
		add	sp, 2
		mov	es, seg_16426
		mov	ax, es:380h
		mov	es, seg_16424
		add	ax, es:word_15F6C
		mov	bx, [bp+var_A]
		shl	bx, 1
		shl	bx, 1
		mov	es, seg_1640C
		assume es:seg003
		lea	bx, [bx+0Eh]
		mov	es:[bx+2], ax
		mov	bx, [bp+var_A]
		shl	bx, 1
		shl	bx, 1
		mov	word ptr es:[bx+0Eh], 0
		mov	ax, [bp+var_E]
		mov	bx, [bp+var_A]
		shl	bx, 1
		mov	es, seg_16428
		mov	es:word_1688E[bx], ax
		mov	es, seg_16424
		assume es:seg001
		add	es:word_15F6C, ax
		mov	bx, [bp+var_A]
		shl	bx, 1
		shl	bx, 1
		mov	es, seg_1640C
		assume es:seg003
		push	word ptr es:[bx+10h]
		push	word ptr es:[bx+0Eh]
		lea	ax, [bp+var_8]
		push	ss
		push	ax
		call	DoGraphicsThing
		add	sp, 8
		inc	[bp+var_A]
		mov	es, seg_1640A
		mov	ax, [bp+var_A]
		mov	es:word_16A8E, ax
		jmp	short loc_117FA
; ---------------------------------------------------------------------------

loc_117E6:				; CODE XREF: mes1A_DoSelect+E0j
		mov	ax, 6		; error: aNotEnoughMem
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retn
; ---------------------------------------------------------------------------
		align 2

loc_117F0:				; CODE XREF: mes1A_DoSelect+AAj
		mov	ax, 7		; error: aTooManyGFX
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retn
; ---------------------------------------------------------------------------
		align 2

loc_117FA:				; CODE XREF: mes1A_DoSelect+16Aj
		lea	ax, [bp+var_8]
		push	ss
		push	ax
		call	sub_132F8
		add	sp, 4
		sub	ax, ax
		push	ax
		push	ax
		call	GetTextBoxData
		add	sp, 4
		mov	[bp+var_E], ax
		les	bx, [bp+arg_0]
		assume es:nothing
		inc	word ptr [bp+arg_0]
		mov	al, es:[bx]	; get number of	selection entry	pointers
		sub	ah, ah
		mov	es, seg_1642E
		assume es:seg001
		mov	es:SelectEntryCnt, ax
		mov	ax, [bp+var_C]
		cwd
		xor	ax, dx
		sub	ax, dx
		mov	cx, 2
		sar	ax, cl
		xor	ax, dx
		sub	ax, dx
		add	ax, cx
		mov	[bp+var_C], ax
		mov	ax, [bp+var_12]
		inc	ax
		cwd
		xor	ax, dx
		sub	ax, dx
		mov	cx, 4
		sar	ax, cl
		xor	ax, dx
		sub	ax, dx
		mov	[bp+var_12], ax
		mov	ax, [bp+var_C]
		mov	es, seg_16430
		add	ax, es:SelectTxtMaxLen
		mov	[bp+var_10], ax
		mov	ax, [bp+var_12]
		mov	es, seg_1642E
		add	ax, es:SelectEntryCnt
		dec	ax
		mov	[bp+var_14], ax
		sub	ax, ax
		push	ax
		call	SetTextGFXAddr
		add	sp, 2
		push	[bp+var_14]
		push	[bp+var_10]
		push	[bp+var_12]
		push	[bp+var_C]
		call	SetTextBoxData
		add	sp, 8
		mov	[bp+var_A], 0
		mov	es, seg_1642E
		cmp	es:SelectEntryCnt, 0
		jz	short loc_118FB
		mov	word ptr [bp+selJumpPtr], offset mesSelJumpPtrs
		mov	word ptr [bp+selJumpPtr+2], seg	seg001
		mov	word ptr [bp+selTextPtr], offset SelectTextPtrs
		mov	word ptr [bp+selTextPtr+2], seg	seg001
		mov	di, [bp+var_C]
		mov	si, [bp+var_A]

loc_118B5:				; CODE XREF: mes1A_DoSelect+27Cj
		les	bx, [bp+arg_0]
		assume es:nothing
		mov	ax, es:[bx]
		les	bx, [bp+selJumpPtr]
		mov	es:[bx], ax
		add	word ptr [bp+arg_0], 2
		mov	ax, [bp+var_12]
		add	ax, si
		push	ax
		push	di
		call	GetTextBoxData
		add	sp, 4
		les	bx, [bp+selTextPtr]
		push	word ptr es:[bx+2]
		push	word ptr es:[bx]
		call	PrintText	; print	selection text
		add	sp, 4
		add	word ptr [bp+selJumpPtr], 2
		add	word ptr [bp+selTextPtr], 4
		inc	si
		mov	ax, si
		mov	es, seg_1642E
		assume es:seg001
		cmp	ax, es:SelectEntryCnt
		jb	short loc_118B5
		mov	[bp+var_A], si

loc_118FB:				; CODE XREF: mes1A_DoSelect+21Fj
		push	[bp+var_12]
		push	[bp+var_C]
		push	es:SelectEntryCnt
		call	DoMenuSelection
		add	sp, 6
		dec	ax
		mov	es, seg_16434
		mov	es:SelectEntry,	ax
		mov	es, seg_1640A
		assume es:seg003
		dec	es:word_16A8E
		mov	bx, es:word_16A8E
		shl	bx, 1
		shl	bx, 1
		mov	es, seg_1640C
		push	word ptr es:[bx+10h]
		push	word ptr es:[bx+0Eh]
		call	sub_131D2
		add	sp, 4
		mov	es, seg_1640A
		mov	bx, es:word_16A8E
		shl	bx, 1
		shl	bx, 1
		mov	es, seg_1640C
		sub	ax, ax
		mov	es:[bx+10h], ax
		mov	es:[bx+0Eh], ax
		mov	es, seg_1640A
		mov	bx, es:word_16A8E
		shl	bx, 1
		mov	es, seg_16428
		mov	ax, es:word_1688E[bx]
		mov	es, seg_16424
		assume es:seg001
		sub	es:word_15F6C, ax
		mov	ax, 2
		push	ax
		call	sub_12E34
		add	sp, 2
		call	sub_134E4
		call	ClearTextVRAM
		push	tboxHeight
		push	tboxWidth
		push	tboxYPos
		push	tboxXPos
		call	SetTextBoxData
		add	sp, 8
		mov	ax, [bp+var_E]
		mov	cl, 8
		shr	ax, cl
		push	ax
		mov	al, byte ptr [bp+var_E]
		sub	ah, ah
		push	ax
		call	GetTextBoxData
		add	sp, 4
		mov	ax, 7
		push	ax
		call	SetTextGFXAddr
		add	sp, 2
		mov	es, seg_16434
		mov	bx, es:SelectEntry
		shl	bx, 1
		shl	bx, 1
		mov	es, seg_16432
		push	word ptr es:(SelectTextPtrs+2)[bx]
		push	word ptr es:SelectTextPtrs[bx]
		call	PrintText	; print	text of	selected entry
		add	sp, 4
		mov	ax, offset asc_163D4 ; "\r\n"
		push	ds
		push	ax
		call	PrintText	; print	newline
		add	sp, 4
		sub	ax, ax
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retn
mes1A_DoSelect	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


mes1B_SelJump	proc near		; CODE XREF: GameMain+D4p
					; DATA XREF: seg002:mesJumpTblo
		push	bp
		mov	es, seg_16434
		mov	bx, es:SelectEntry
		shl	bx, 1
		mov	es, seg_16436
		mov	ax, es:mesSelJumpPtrs[bx]
		mov	es, seg_16438
		mov	es:mesNextCmdPos, ax
		sub	ax, ax
		pop	bp
		retn
mes1B_SelJump	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

mes1C_Jump	proc near		; CODE XREF: GameMain+D4p
					; DATA XREF: seg002:mesJumpTblo

arg_0		= dword	ptr  4

		push	bp
		mov	bp, sp
		les	bx, [bp+arg_0]
		assume es:nothing
		mov	ax, es:[bx]
		mov	es, seg_16438
		assume es:seg001
		mov	es:mesNextCmdPos, ax
		sub	ax, ax
		pop	bp
		retn
mes1C_Jump	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

mes1D_MetaCmd	proc near		; CODE XREF: GameMain+D4p
					; DATA XREF: seg002:mesJumpTblo

arg_0		= dword	ptr  4

		push	bp
		mov	bp, sp
		les	bx, [bp+arg_0]
		assume es:nothing
		cmp	byte ptr es:[bx], 0
		jnz	short mes1D_01_SetFlag ; 1st parameter != 0 -> jump

mes1D_00_CondJump:
		mov	es, seg_1643A
		assume es:seg001
		cmp	byte ptr es:mesFlagValue, 3
		jnz	short loc_11A66
		inc	word ptr [bp+arg_0] ; mesFlagValue == 3	-> jump	to destination offset
		les	bx, [bp+arg_0]
		assume es:nothing
		mov	ax, es:[bx]
		mov	es, seg_16438
		assume es:seg001
		mov	es:mesNextCmdPos, ax
		sub	ax, ax
		pop	bp
		retn
; ---------------------------------------------------------------------------
		align 2

mes1D_01_SetFlag:			; CODE XREF: mes1D_MetaCmd+Aj
		inc	word ptr [bp+arg_0]
		les	bx, [bp+arg_0]
		assume es:nothing
		mov	al, es:[bx]
		mov	es, seg_1643A
		assume es:seg001
		or	byte ptr es:mesFlagValue, al

loc_11A66:				; CODE XREF: mes1D_MetaCmd+16j
		sub	ax, ax
		pop	bp
		retn
mes1D_MetaCmd	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

mes1E_TxtBoxThing proc near		; CODE XREF: GameMain+D4p
					; DATA XREF: seg002:mesJumpTblo

arg_0		= dword	ptr  4

		push	bp
		mov	bp, sp
		les	bx, [bp+arg_0]
		assume es:nothing
		mov	ax, es:[bx]
		mov	tboxXPos, ax
		add	word ptr [bp+arg_0], 2
		mov	bx, word ptr [bp+arg_0]
		mov	ax, es:[bx]
		mov	tboxYPos, ax
		add	word ptr [bp+arg_0], 2
		mov	bx, word ptr [bp+arg_0]
		mov	ax, es:[bx]
		mov	tboxWidth, ax
		add	word ptr [bp+arg_0], 2
		mov	bx, word ptr [bp+arg_0]
		mov	ax, es:[bx]
		mov	tboxHeight, ax
		push	ax
		push	tboxWidth
		push	tboxYPos
		push	tboxXPos
		call	SetTextBoxData
		add	sp, 8
		push	tboxYPos
		push	tboxXPos
		call	GetTextBoxData
		add	sp, 4
		sub	ax, ax
		pop	bp
		retn
mes1E_TxtBoxThing endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

mes1F_TxtBoxThing proc near		; CODE XREF: GameMain+D4p
					; DATA XREF: seg002:mesJumpTblo

arg_0		= dword	ptr  4

		push	bp
		mov	bp, sp
		les	bx, [bp+arg_0]
		mov	ax, es:[bx]
		mov	word_163B4, ax
		add	word ptr [bp+arg_0], 2
		mov	bx, word ptr [bp+arg_0]
		mov	ax, es:[bx]
		mov	word_163B6, ax
		add	word ptr [bp+arg_0], 2
		mov	bx, word ptr [bp+arg_0]
		mov	ax, es:[bx]
		mov	word_163B8, ax
		add	word ptr [bp+arg_0], 2
		mov	bx, word ptr [bp+arg_0]
		mov	ax, es:[bx]
		mov	word_163BA, ax
		push	ax
		push	word_163B8
		push	word_163B6
		push	word_163B4
		call	sub_124C9
		add	sp, 8
		sub	ax, ax
		pop	bp
		retn
mes1F_TxtBoxThing endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

mes20		proc near		; CODE XREF: GameMain+D4p
					; DATA XREF: seg002:mesJumpTblo

arg_0		= dword	ptr  4

		push	bp
		mov	bp, sp
		les	bx, [bp+arg_0]
		mov	ax, es:[bx]
		mov	es, seg_1642C
		assume es:seg001
		mov	es:word_15F6A, ax
		push	ax
		call	sub_12505
		add	sp, 2
		mov	es, seg_1642C
		push	es:word_15F6A
		call	sub_15BBA
		add	sp, 2
		sub	ax, ax
		pop	bp
		retn
mes20		endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

mes21_GfxThing	proc near		; CODE XREF: mes10_GfxThing+1Bp
					; mes11_GfxThing+1Dp ...

var_1A		= dword	ptr -1Ah
var_16		= dword	ptr -16h
var_12		= dword	ptr -12h
var_E		= word ptr -0Eh
var_C		= word ptr -0Ch
var_A		= word ptr -0Ah
var_8		= word ptr -8
var_6		= word ptr -6
var_4		= dword	ptr -4
arg_0		= dword	ptr  4

		push	bp
		mov	bp, sp
		sub	sp, 1Ah
		push	di
		push	si
		call	sub_134EC
		mov	es, seg_1640A
		assume es:seg003
		mov	ax, es:word_16A8E
		mov	[bp+var_C], ax
		les	bx, [bp+arg_0]
		assume es:nothing
		inc	word ptr [bp+arg_0]
		mov	al, es:[bx]
		sub	ah, ah
		mov	[bp+var_6], ax
		cmp	ax, 0FFh
		jnz	short loc_11B64
		jmp	loc_11CAE
; ---------------------------------------------------------------------------

loc_11B64:				; CODE XREF: mes21_GfxThing+27j
		mov	bx, [bp+var_C]
		shl	bx, 1
		shl	bx, 1
		lea	ax, [bx+0Eh]
		mov	dx, seg	seg003
		add	ax, 2
		mov	word ptr [bp+var_12], ax
		mov	word ptr [bp+var_12+2],	dx
		mov	ax, [bp+var_C]
		shl	ax, 1
		shl	ax, 1
		add	ax, 0Eh
		mov	word ptr [bp+var_16], ax
		mov	word ptr [bp+var_16+2],	dx
		mov	ax, [bp+var_C]
		shl	ax, 1
		add	ax, offset word_1688E
		mov	word ptr [bp+var_1A], ax
		mov	word ptr [bp+var_1A+2],	seg seg003
		mov	di, [bp+var_C]
		mov	si, [bp+var_E]

loc_11BA1:				; CODE XREF: mes21_GfxThing+15Cj
		cmp	di, 100h
		jl	short loc_11BAA
		jmp	loc_11CA8
; ---------------------------------------------------------------------------

loc_11BAA:				; CODE XREF: mes21_GfxThing+6Dj
		mov	es, seg_1641C
		assume es:seg001
		mov	ax, es:graphicsCount
		cmp	[bp+var_6], ax
		jb	short loc_11BBA
		jmp	loc_11C81
; ---------------------------------------------------------------------------

loc_11BBA:				; CODE XREF: mes21_GfxThing+7Dj
		mov	es, seg_16418
		mov	ax, word ptr es:mesPtr+2
		mov	[bp+var_8], ax
		mov	bx, [bp+var_6]
		shl	bx, 1
		mov	es, seg_1641E
		mov	ax, es:graphicsList[bx]
		mov	[bp+var_A], ax
		mov	ax, [bp+var_8]
		mov	word ptr [bp+var_4+2], ax
		mov	ax, [bp+var_A]
		mov	word ptr [bp+var_4], ax
		les	bx, [bp+var_4]
		assume es:nothing
		mov	ax, es:[bx+4]
		add	ax, 3
		shr	ax, 1
		shr	ax, 1
		mov	cx, es:[bx]
		shr	cx, 1
		shr	cx, 1
		sub	ax, cx
		inc	ax
		mov	cx, es:[bx+6]
		sub	cx, es:[bx+2]
		inc	cx
		mul	cx
		mov	si, ax
		mov	cl, 2
		shl	si, cl
		add	si, 15h
		mov	cl, 4
		shr	si, cl
		mov	es, seg_16422
		assume es:seg001
		mov	ax, es:word_15E20
		mov	es, seg_16424
		sub	ax, es:word_15F6C
		cmp	ax, si
		jb	short loc_11C98
		mov	es, seg_16426
		mov	ax, es:380h
		mov	es, seg_16424
		add	ax, es:word_15F6C
		les	bx, [bp+var_12]
		assume es:nothing
		mov	es:[bx], ax
		les	bx, [bp+var_16]
		mov	word ptr es:[bx], 0
		les	bx, [bp+var_1A]
		mov	es:[bx], si
		mov	es, seg_16424
		assume es:seg001
		add	es:word_15F6C, si
		les	bx, [bp+var_16]
		assume es:nothing
		push	word ptr es:[bx+2]
		push	word ptr es:[bx]
		push	[bp+var_8]
		push	[bp+var_A]
		call	sub_15A46
		add	sp, 8
		add	word ptr [bp+var_12], 4
		add	word ptr [bp+var_16], 4
		add	word ptr [bp+var_1A], 2
		inc	di
		mov	es, seg_1640A
		assume es:seg003
		mov	es:word_16A8E, di

loc_11C81:				; CODE XREF: mes21_GfxThing+7Fj
		les	bx, [bp+arg_0]
		assume es:nothing
		inc	word ptr [bp+arg_0]
		mov	al, es:[bx]
		sub	ah, ah
		mov	[bp+var_6], ax
		cmp	ax, 0FFh
		jz	short loc_11CA8
		jmp	loc_11BA1
; ---------------------------------------------------------------------------
		align 2

loc_11C98:				; CODE XREF: mes21_GfxThing+EDj
		mov	ax, 6		; error	aNotEnoughMem
		mov	[bp+var_C], di
		mov	[bp+var_E], si
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retn
; ---------------------------------------------------------------------------
		align 2

loc_11CA8:				; CODE XREF: mes21_GfxThing+6Fj
					; mes21_GfxThing+15Aj
		mov	[bp+var_C], di
		mov	[bp+var_E], si

loc_11CAE:				; CODE XREF: mes21_GfxThing+29j
		sub	ax, ax
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retn
mes21_GfxThing	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

mes22_ClearThing proc near		; CODE XREF: GameMain+D4p
					; DATA XREF: seg002:mesJumpTblo

var_6		= dword	ptr -6
var_2		= word ptr -2

		push	bp
		mov	bp, sp
		sub	sp, 8
		push	di
		call	sub_134EC
		mov	es, seg_1640A
		assume es:seg003
		mov	es:word_16A8E, 0
		mov	es, seg_1643C
		mov	byte ptr es:word_16AD2,	0
		mov	es, seg_16424
		assume es:seg001
		mov	es:word_15F6C, 0
		mov	[bp+var_2], 10h
		mov	word ptr [bp+var_6], offset unk_1684E
		mov	word ptr [bp+var_6+2], seg seg003
		les	bx, [bp+var_6]
		assume es:nothing
		sub	ax, ax
		mov	cx, 20h
		mov	di, bx
		repne stosw
		mov	[bp+var_2], 100h
		mov	word ptr [bp+var_6], offset dword_1644E
		mov	word ptr [bp+var_6+2], seg seg003
		les	bx, [bp+var_6]
		mov	cx, 200h
		mov	di, bx
		repne stosw
		pop	di
		mov	sp, bp
		pop	bp
		retn
mes22_ClearThing endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

mes23_SetEraseType proc	near		; CODE XREF: GameMain+D4p
					; DATA XREF: seg002:mesJumpTblo

var_10		= dword	ptr -10h
var_C		= word ptr -0Ch
var_A		= word ptr -0Ah
var_8		= word ptr -8
var_6		= word ptr -6
var_4		= dword	ptr -4
arg_0		= dword	ptr  4

		push	bp
		mov	bp, sp
		sub	sp, 12h
		push	di
		les	bx, [bp+arg_0]
		mov	al, es:[bx]
		sub	ah, ah
		mov	es, seg_1641C
		assume es:seg001
		cmp	ax, es:graphicsCount
		jb	short loc_11D3C
		mov	ax, 4		; error: aBadGraphicID
		pop	di
		mov	sp, bp
		pop	bp
		retn
; ---------------------------------------------------------------------------

loc_11D3C:				; CODE XREF: mes23_SetEraseType+18j
		call	sub_134EC
		mov	es, seg_16418
		mov	ax, word ptr es:mesPtr+2
		mov	[bp+var_8], ax
		les	bx, [bp+arg_0]
		assume es:nothing
		mov	bl, es:[bx]
		sub	bh, bh
		shl	bx, 1
		mov	es, seg_1641E
		assume es:seg001
		mov	ax, es:graphicsList[bx]
		mov	[bp+var_A], ax
		mov	ax, [bp+var_8]
		mov	word ptr [bp+var_4+2], ax
		mov	ax, [bp+var_A]
		mov	word ptr [bp+var_4], ax
		les	bx, [bp+var_4]
		assume es:nothing
		mov	ax, es:[bx]
		shr	ax, 1
		shr	ax, 1
		mov	es, seg_1643E
		assume es:seg000
		mov	es:word_1365F, ax
		mov	es, word ptr [bp+var_4+2]
		assume es:nothing
		mov	ax, es:[bx+2]
		mov	es, word ptr ds:2A0h
		assume es:seg000
		mov	es:word_13661, ax
		mov	es, word ptr [bp+var_4+2]
		assume es:nothing
		mov	ax, es:[bx+4]
		add	ax, 3
		shr	ax, 1
		shr	ax, 1
		mov	es, seg_1643E
		assume es:seg000
		sub	ax, es:word_1365F
		inc	ax
		mov	es, word ptr [bp+var_4+2]
		assume es:nothing
		mov	cx, es:[bx+6]
		mov	es, word ptr ds:2A0h
		assume es:seg000
		sub	cx, es:word_13661
		inc	cx
		mul	cx
		shl	ax, 1
		shl	ax, 1
		add	ax, 15h
		mov	[bp+var_C], ax
		mov	cl, 4
		shr	[bp+var_C], cl
		mov	es, seg_16422
		assume es:seg001
		mov	ax, es:word_15E20
		mov	es, seg_16424
		sub	ax, es:word_15F6C
		cmp	ax, [bp+var_C]
		jnb	short loc_11DE0
		jmp	loc_11E92
; ---------------------------------------------------------------------------

loc_11DE0:				; CODE XREF: mes23_SetEraseType+C1j
		mov	es, word ptr ds:2A2h
		push	es:word_15F26
		push	es:word_15F24
		push	[bp+var_8]
		push	[bp+var_A]
		call	sub_15A46
		add	sp, 8
		mov	es, word ptr ds:2A2h
		mov	ax, es:word_15F24
		mov	dx, es:word_15F26
		mov	es, seg_16420
		mov	word ptr es:dword_15EFA, ax
		mov	word ptr es:dword_15EFA+2, dx
		mov	ax, dx
		add	ax, [bp+var_C]
		mov	es, seg_16426
		mov	es:380h, ax
		mov	es:word_1619E, 0
		mov	es, word ptr ds:2A4h
		mov	ax, es:word_15E6E
		sub	ax, [bp+var_C]
		mov	es, seg_16422
		mov	es:word_15E20, ax
		mov	es, seg_16424
		mov	es:word_15F6C, 0
		mov	[bp+var_6], 100h
		mov	word ptr [bp+var_10], offset dword_1644E
		mov	word ptr [bp+var_10+2],	seg seg003
		les	bx, [bp+var_10]
		assume es:nothing
		sub	ax, ax
		mov	cx, 200h
		mov	di, bx
		repne stosw
		mov	es, seg_1640A
		assume es:seg003
		mov	es:word_16A8E, ax
		mov	es, seg_1643C
		mov	byte ptr es:word_16AD2,	0
		mov	[bp+var_6], 10h
		mov	word ptr [bp+var_10], offset unk_1684E
		mov	word ptr [bp+var_10+2],	seg seg003
		les	bx, [bp+var_10]
		assume es:nothing
		mov	cx, 20h	; ' '
		mov	di, bx
		repne stosw
		pop	di
		mov	sp, bp
		pop	bp
		retn
; ---------------------------------------------------------------------------
		align 2

loc_11E92:				; CODE XREF: mes23_SetEraseType+C3j
		mov	ax, 6
		pop	di
		mov	sp, bp
		pop	bp
		retn
mes23_SetEraseType endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

mes24_GfxPosOffset proc	near		; CODE XREF: GameMain+D4p
					; DATA XREF: seg002:mesJumpTblo

var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= dword	ptr  4

		push	bp
		mov	bp, sp
		sub	sp, 4
		les	bx, [bp+arg_0]
		mov	ax, es:[bx]
		mov	[bp+var_2], ax
		add	word ptr [bp+arg_0], 2
		mov	bx, word ptr [bp+arg_0]
		mov	ax, es:[bx]
		mov	[bp+var_4], ax
		add	word ptr [bp+arg_0], 2
		push	ax
		push	[bp+var_2]
		call	sub_13213
		sub	ax, ax
		mov	sp, bp
		pop	bp
		retn
mes24_GfxPosOffset endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

mes25		proc near		; CODE XREF: GameMain+D4p
					; DATA XREF: seg002:mesJumpTblo
		push	bp
		mov	bp, sp
		call	sub_13226
		sub	ax, ax
		pop	bp
		retn
mes25		endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

mes26		proc near		; CODE XREF: GameMain+D4p
					; DATA XREF: seg002:mesJumpTblo
		push	bp
		mov	bp, sp
		call	sub_1323E
		sub	ax, ax
		pop	bp
		retn
mes26		endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

mes27_SetPalFile proc near		; CODE XREF: GameMain+D4p
					; DATA XREF: seg002:mesJumpTblo

arg_0		= dword	ptr  4

		push	bp
		mov	bp, sp
		les	bx, [bp+arg_0]
		cmp	byte ptr es:[bx], 0
		jz	short loc_11EF8
		mov	ax, bx
		mov	dx, es
		mov	word ptr PalFileNamePtr, ax
		mov	word ptr PalFileNamePtr+2, dx
		sub	ax, ax
		pop	bp
		retn
; ---------------------------------------------------------------------------
		align 2

loc_11EF8:				; CODE XREF: mes27_SetPalFile+Aj
		sub	ax, ax
		mov	word ptr PalFileNamePtr+2, ax
		mov	word ptr PalFileNamePtr, ax
		sub	ax, ax
		pop	bp
		retn
mes27_SetPalFile endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

mes28_LoadPalFile proc near		; CODE XREF: GameMain+D4p
					; DATA XREF: seg002:mesJumpTblo

var_6		= word ptr -6
var_4		= word ptr -4
remPalID	= byte ptr -2
arg_0		= dword	ptr  4

		push	bp
		mov	bp, sp
		sub	sp, 6
		push	di
		push	si
		mov	ax, word ptr PalFileNamePtr
		or	ax, word ptr PalFileNamePtr+2
		jz	short loc_11F8B	; no palette file set -	skip
		les	bx, [bp+arg_0]
		mov	al, es:[bx]
		mov	[bp+remPalID], al
		or	al, al
		jz	short loc_11F8B	; palette 0 requested -	skip
		sub	ax, ax
		push	ax
		push	word ptr PalFileNamePtr+2
		push	word ptr PalFileNamePtr
		call	fopen
		add	sp, 6
		mov	[bp+var_4], ax
		or	ax, ax
		jge	short loc_11F44
		mov	ax, 2		; error	aFileNotFound
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retn
; ---------------------------------------------------------------------------
		align 2

loc_11F44:				; CODE XREF: mes28_LoadPalFile+34j
		cmp	[bp+remPalID], 0
		jz	short loc_11F82
		mov	di, [bp+var_4]

loc_11F4D:				; CODE XREF: mes28_LoadPalFile+79j
		push	di
		mov	ax, 20h
		push	ax
		mov	es, seg_1641A
		assume es:seg001
		push	word ptr es:PaletteDataPtr+2
		push	word ptr es:PaletteDataPtr
		call	fread
		add	sp, 8
		mov	si, ax
		cmp	si, 20h
		jz	short loc_11F7A
		mov	ax, 3
		mov	[bp+var_6], si
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retn
; ---------------------------------------------------------------------------
		align 2

loc_11F7A:				; CODE XREF: mes28_LoadPalFile+67j
		dec	[bp+remPalID]
		jnz	short loc_11F4D
		mov	[bp+var_6], si

loc_11F82:				; CODE XREF: mes28_LoadPalFile+44j
		push	[bp+var_4]
		call	fclose
		add	sp, 2

loc_11F8B:				; CODE XREF: mes28_LoadPalFile+Fj
					; mes28_LoadPalFile+1Cj
		sub	ax, ax
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retn
mes28_LoadPalFile endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

mes29_SetPalette proc near		; CODE XREF: GameMain+D4p
					; DATA XREF: seg002:mesJumpTblo

var_12		= word ptr -12h
var_10		= byte ptr -10h
var_E		= byte ptr -0Eh
var_A		= word ptr -0Ah
var_8		= word ptr -8
var_6		= word ptr -6
var_4		= dword	ptr -4
arg_0		= dword	ptr  4

		push	bp
		mov	bp, sp
		sub	sp, 12h
		push	di
		push	si
		mov	ax, seg	seg001
		mov	es, ax
		mov	ax, word ptr es:PaletteDataPtr
		mov	dx, word ptr es:PaletteDataPtr+2
		mov	word ptr [bp+var_4], ax
		mov	word ptr [bp+var_4+2], dx
		mov	ax, 1DEh
		mov	[bp+var_8], ax
		mov	[bp+var_6], ds
		mov	[bp+var_A], 10h
		mov	di, 10h
		mov	[bp+var_12], ds
		mov	si, ax

loc_11FC6:				; CODE XREF: mes29_SetPalette+7Bj
		les	bx, [bp+arg_0]
		assume es:nothing
		mov	al, es:[bx]
		mov	[bp+var_E], al
		and	al, 0Fh
		mov	[si], al
		inc	si
		mov	al, [bp+var_E]
		sub	ah, ah
		mov	cl, 4
		shr	ax, cl
		and	al, 0Fh
		mov	[si], al
		inc	si
		les	bx, [bp+var_4]
		mov	al, [bp+var_E]
		mov	es:[bx], al
		inc	word ptr [bp+arg_0]
		inc	word ptr [bp+var_4]
		les	bx, [bp+arg_0]
		mov	al, es:[bx]
		mov	[bp+var_10], al
		and	al, 0Fh
		mov	[si], al
		inc	si
		les	bx, [bp+var_4]
		mov	al, [bp+var_10]
		mov	es:[bx], al
		inc	word ptr [bp+arg_0]
		inc	word ptr [bp+var_4]
		dec	di
		jnz	short loc_11FC6
		mov	[bp+var_8], si
		mov	[bp+var_6], ds
		mov	ds, [bp+var_12]
		mov	ax, 1
		push	ax
		call	SetPalette
		add	sp, 2
		sub	ax, ax
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retn
mes29_SetPalette endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

mes2A_SystemText proc near		; CODE XREF: GameMain+D4p
					; DATA XREF: seg002:mesJumpTblo

arg_0		= word ptr  4
arg_2		= word ptr  6

		push	bp
		mov	bp, sp
		mov	ax, 7
		push	ax
		call	SetTextGFXAddr
		add	sp, 2
		push	[bp+arg_2]
		push	[bp+arg_0]
		call	PrintText	; print	"system	message" script	text
		add	sp, 4
		sub	ax, ax
		pop	bp
		retn
mes2A_SystemText endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

mes2B_SetAniMode proc near		; CODE XREF: GameMain+D4p
					; DATA XREF: seg002:mesJumpTblo

arg_0		= dword	ptr  4

		push	bp
		mov	bp, sp
		les	bx, [bp+arg_0]
		mov	al, es:[bx]
		sub	ah, ah
		push	ax
		call	SetAnimationMode
		add	sp, 2
		sub	ax, ax
		pop	bp
		retn
mes2B_SetAniMode endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

mes2C		proc near		; CODE XREF: GameMain+D4p
					; DATA XREF: seg002:mesJumpTblo
		push	bp
		mov	bp, sp
		call	sub_134E4
		sub	ax, ax
		pop	bp
		retn
mes2C		endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

mes2D		proc near		; CODE XREF: GameMain+D4p
					; DATA XREF: seg002:mesJumpTblo
		push	bp
		mov	bp, sp
		call	sub_134EC
		sub	ax, ax
		pop	bp
		retn
mes2D		endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

mes2E		proc near		; CODE XREF: GameMain+D4p
					; DATA XREF: seg002:mesJumpTblo
		push	bp
		mov	bp, sp
		call	sub_134E4
		call	sub_13577
		call	sub_134EC
		sub	ax, ax
		pop	bp
		retn
mes2E		endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

mes2F_SetScrollMode proc near		; CODE XREF: GameMain+D4p
					; DATA XREF: seg002:mesJumpTblo

arg_0		= dword	ptr  4

		push	bp
		mov	bp, sp
		les	bx, [bp+arg_0]
		mov	al, es:[bx]
		mov	es, word ptr ds:2A6h
		assume es:seg000
		mov	es:ScrollMode, al
		sub	ax, ax
		pop	bp
		retn
mes2F_SetScrollMode endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

InitGame	proc near		; CODE XREF: GameMain:loc_122A8p

var_10		= dword	ptr -10h
hFile		= word ptr -0Ch
var_A		= word ptr -0Ah
var_8		= word ptr -8
var_6		= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2

		push	bp
		mov	bp, sp
		sub	sp, 12h
		push	di
		call	sub_123B2
		call	sub_12394
		call	sub_1239E
		call	sub_123A8
		mov	bx, 40h	; '@'
		mov	es, bx
		assume es:nothing
		mov	bx, 100h
		or	byte ptr es:[bx], 20h
		call	sub_12399
		call	sub_123B9
		mov	[bp+var_A], ax
		call	LoadSoundDriver
		mov	es, word ptr ds:2A8h
		assume es:seg001
		mov	es:word_15EF4, ax
		call	sub_10010
		or	ax, ax
		jz	short loc_120DC

loc_120D4:				; CODE XREF: InitGame+64j InitGame+7Fj ...
		mov	ax, 0FFFFh
		pop	di
		mov	sp, bp
		pop	bp
		retn
; ---------------------------------------------------------------------------

loc_120DC:				; CODE XREF: InitGame+38j
		mov	ax, 1C00h
		push	ax
		call	malloc
		add	sp, 2
		mov	[bp+var_6], ax
		mov	[bp+var_4], dx
		or	dx, dx
		jge	short loc_12100
		push	word ptr ErrorTextTbl+16h
		push	word ptr ErrorTextTbl+14h
		call	PrintText	; print	aNotEnoughMem text
		add	sp, 4
		jmp	short loc_120D4
; ---------------------------------------------------------------------------

loc_12100:				; CODE XREF: InitGame+54j
		mov	es, word ptr ds:2AAh
		mov	ax, [bp+var_6]
		mov	word ptr es:mesDataPtr+2, ax
		call	LoadCustomFont
		push	[bp+var_A]
		call	SetupInterrupts
		add	sp, 2
		or	ax, ax
		jnz	short loc_120D4
		sub	ax, ax
		push	ax
		mov	ax, offset aAya3mes_dat	; "AYA3MES.DAT"
		push	ds
		push	ax
		call	fopen
		add	sp, 6
		mov	[bp+hFile], ax
		or	ax, ax
		jl	short loc_120D4
		push	ax		; file handle
		mov	ax, 0FFFFh	; number of bytes to read
		push	ax
		mov	es, word ptr ds:2AAh
		push	word ptr es:mesDataPtr+2
		push	word ptr es:mesDataPtr
		call	fread
		add	sp, 8
		mov	[bp+var_2], ax
		push	[bp+hFile]
		call	fclose
		add	sp, 2
		cmp	[bp+var_2], 0
		jnz	short loc_1215E
		jmp	loc_120D4
; ---------------------------------------------------------------------------

loc_1215E:				; CODE XREF: InitGame+BFj
		mov	ax, [bp+var_2]
		add	ax, 0Fh
		mov	cl, 4
		shr	ax, cl
		mov	es, word ptr ds:2AAh
		add	ax, word ptr es:mesDataPtr+2
		mov	es, seg_16418
		mov	word ptr es:mesPtr+2, ax
		mov	word ptr es:mesPtr, 80Ah
		mov	ax, word ptr es:mesPtr
		mov	dx, word ptr es:mesPtr+2
		add	ax, 6
		mov	es, seg_1641A
		mov	word ptr es:PaletteDataPtr, ax
		mov	word ptr es:PaletteDataPtr+2, dx
		mov	es, seg_16418
		mov	ax, dx
		add	ah, 10h
		mov	es, word ptr ds:2ACh
		mov	es:word_15EF8, ax
		mov	es:word_15EF6, 0
		mov	ax, 0FFFFh
		push	ax
		call	malloc
		add	sp, 2
		mov	[bp+var_6], ax
		mov	[bp+var_4], dx
		mov	es, word ptr ds:2A4h
		neg	ax
		mov	es:word_15E6E, ax
		mov	es, seg_16422
		mov	es:word_15E20, ax
		push	ax
		call	malloc
		add	sp, 2
		mov	[bp+var_6], ax
		mov	[bp+var_4], dx
		mov	es, word ptr ds:2A2h
		mov	es:word_15F26, ax
		mov	es:word_15F24, 0
		mov	ax, es:word_15F24
		mov	dx, es:word_15F26
		mov	es, seg_16426
		mov	es:word_1619E, ax
		mov	es:380h, dx
		mov	es, seg_16420
		sub	ax, ax
		mov	word ptr es:dword_15EFA+2, ax
		mov	word ptr es:dword_15EFA, ax
		mov	[bp+var_8], 100h
		mov	word ptr [bp+var_10], offset dword_1644E
		mov	word ptr [bp+var_10+2],	seg seg003
		les	bx, [bp+var_10]
		assume es:nothing
		mov	cx, 200h
		mov	di, bx
		repne stosw
		mov	ax, 18Fh
		push	ax
		mov	ax, 4Fh	; 'O'
		push	ax
		sub	ax, ax
		push	ax
		push	ax
		call	sub_124C9
		add	sp, 8
		call	sub_1246E
		mov	ax, 3
		push	ax
		call	sub_12E34
		add	sp, 2
		call	sub_1246E
		mov	ax, 2
		push	ax
		call	sub_12E34
		add	sp, 2
		call	sub_123A3
		sub	ax, ax
		pop	di
		mov	sp, bp
		pop	bp
		retn
InitGame	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: noreturn bp-based	frame

GameMain	proc near		; CODE XREF: start+9Cp

var_8		= word ptr -8
mesCurPos	= dword	ptr -6
var_2		= word ptr -2
arg_0		= word ptr  4
arg_2		= dword	ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 8
		push	di
		push	si
		cmp	[bp+arg_0], 2
		jnz	short loc_122A8
		sub	si, si
		sub	di, di
		jmp	short loc_1228B
; ---------------------------------------------------------------------------

loc_12276:				; CODE XREF: GameMain+3Aj
		cmp	ax, '9'
		ja	short loc_1229E
		mov	ax, 10
		mul	di
		mov	di, ax
		mov	ax, cx
		sub	ax, '0'
		add	di, ax
		inc	si
		inc	si

loc_1228B:				; CODE XREF: GameMain+12j
		les	bx, [bp+arg_2]
		les	bx, es:[bx+4]
		mov	al, es:[bx+si]
		sub	ah, ah
		mov	cx, ax
		cmp	ax, '0'
		jnb	short loc_12276

loc_1229E:				; CODE XREF: GameMain+17j
		mov	messageSpeed, di
		mov	[bp+var_2], si
		mov	[bp+var_8], cx

loc_122A8:				; CODE XREF: GameMain+Cj
		call	InitGame
		or	ax, ax
		jz	short loc_122B9
		mov	ax, 0FFFFh
		push	ax
		call	exit
; ---------------------------------------------------------------------------
		add	sp, 2

loc_122B9:				; CODE XREF: GameMain+4Bj
		mov	es, word ptr ds:2AAh
		assume es:seg001
		mov	ax, word ptr es:mesDataPtr
		mov	dx, word ptr es:mesDataPtr+2
		mov	word ptr [bp+mesCurPos], ax
		mov	word ptr [bp+mesCurPos+2], dx
		mov	di, [bp+var_8]
		mov	si, [bp+var_2]
		jmp	short mesMainLoop
; ---------------------------------------------------------------------------

mesError:				; CODE XREF: GameMain+C8j
		mov	si, 1		; error: aBadCommand

loc_122D7:				; CODE XREF: GameMain+DDj
		or	si, si
		jz	short loc_122F9
		mov	ax, 7
		push	ax
		call	SetTextGFXAddr
		add	sp, 2
		mov	bx, si
		shl	bx, 1
		shl	bx, 1
		push	(ErrorTextTbl-2)[bx]
		push	(ErrorTextTbl-4)[bx]
		call	PrintText	; print	Error text
		add	sp, 4

loc_122F9:				; CODE XREF: GameMain+77j
		mov	es, seg_16438
		mov	ax, es:mesNextCmdPos
		mov	word ptr [bp+mesCurPos], ax

mesMainLoop:				; CODE XREF: GameMain+70j
		les	bx, [bp+mesCurPos]
		assume es:nothing
		mov	al, es:[bx]	; read MES command
		sub	ah, ah
		mov	di, ax
		or	di, di
		jz	short mes00
		inc	word ptr [bp+mesCurPos]
		mov	bx, word ptr [bp+mesCurPos]
		mov	ax, es:[bx]	; read command end file	position
		mov	es, seg_16438
		assume es:seg001
		mov	es:mesNextCmdPos, ax
		add	word ptr [bp+mesCurPos], 2
		cmp	di, 2Fh
		jg	short mesError
		push	word ptr [bp+mesCurPos+2] ; do commands	01..2F
		push	word ptr [bp+mesCurPos]
		mov	bx, di
		shl	bx, 1
		call	(mesJumpTbl-2)[bx]
		add	sp, 4
		mov	si, ax
		jmp	short loc_122D7
; ---------------------------------------------------------------------------
		align 2

mes00:					; CODE XREF: GameMain+AEj
		mov	[bp+var_8], di
		mov	[bp+var_2], si

loc_12348:				; CODE XREF: GameMain+F3j
		mov	ax, 0FFFFh
		push	ax
		call	SetCharacterDelay
		add	sp, 2
		call	sub_12E5B
		jmp	short loc_12348
GameMain	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_12358	proc near		; CODE XREF: SetupInterrupts+Ap
		push	ds
		push	es
		push	si
		push	di
		mov	ds, cs:word_15D5A
		assume ds:nothing
		mov	ax, ds:2Ch
		or	ax, ax
		jz	short loc_1238F
		mov	ds, ax
		mov	ax, cs
		mov	es, ax
		assume es:seg000
		xor	si, si

loc_12370:				; CODE XREF: sub_12358+2Ej
		mov	di, 3690h
		mov	cx, 7
		repe cmpsb
		cmp	cx, 0
		jz	short loc_1238C

loc_1237D:				; CODE XREF: sub_12358+28j
		lodsb
		or	al, al
		jnz	short loc_1237D
		mov	al, [si]
		or	al, al
		jnz	short loc_12370
		xor	ax, ax
		jmp	short loc_1238F
; ---------------------------------------------------------------------------

loc_1238C:				; CODE XREF: sub_12358+23j
		mov	ax, 0FFFFh

loc_1238F:				; CODE XREF: sub_12358+Ej
					; sub_12358+32j
		pop	di
		pop	si
		pop	es
		assume es:nothing
		pop	ds
		retn
sub_12358	endp


; =============== S U B	R O U T	I N E =======================================


sub_12394	proc near		; CODE XREF: InitGame+Ap
		mov	al, 0Ch
		out	62h, al		; PC/XT	PPI port C. Bits:
					; 0-3: values of DIP switches
					; 5: 1=Timer 2 channel out
					; 6: 1=I/O channel check
					; 7: 1=RAM parity check	error occurred.
		retn
sub_12394	endp


; =============== S U B	R O U T	I N E =======================================


sub_12399	proc near		; CODE XREF: InitGame+1Fp
		mov	al, 0Dh
		out	62h, al		; PC/XT	PPI port C. Bits:
					; 0-3: values of DIP switches
					; 5: 1=Timer 2 channel out
					; 6: 1=I/O channel check
					; 7: 1=RAM parity check	error occurred.
		retn
sub_12399	endp


; =============== S U B	R O U T	I N E =======================================


sub_1239E	proc near		; CODE XREF: InitGame+Dp
		mov	al, 0Ch
		out	0A2h, al	; Interrupt Controller #2, 8259A
		retn
sub_1239E	endp


; =============== S U B	R O U T	I N E =======================================


sub_123A3	proc near		; CODE XREF: InitGame+1BEp
		mov	al, 0Dh
		out	0A2h, al	; Interrupt Controller #2, 8259A
		retn
sub_123A3	endp


; =============== S U B	R O U T	I N E =======================================


sub_123A8	proc near		; CODE XREF: InitGame+10p
		mov	ah, 12h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		retn
sub_123A8	endp


; =============== S U B	R O U T	I N E =======================================


sub_123AD	proc near		; CODE XREF: sub_12E5B+30p
		mov	ah, 11h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		retn
sub_123AD	endp


; =============== S U B	R O U T	I N E =======================================


sub_123B2	proc near		; CODE XREF: InitGame+7p
		mov	ah, 42h	; 'B'
		mov	ch, 0C0h ; 'À'
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		retn
sub_123B2	endp


; =============== S U B	R O U T	I N E =======================================


sub_123B9	proc near		; CODE XREF: InitGame+22p
		pushf
		cli
		mov	dx, 188h
		mov	al, 0Eh
		out	dx, al
		jmp	short $+2
		mov	dx, 188h
		mov	dx, 18Ah
		in	al, dx
		jmp	short $+2
		rol	al, 1
		rol	al, 1
		and	ax, 3
		mov	bx, ax
		add	bx, 23E0h
		xor	ax, ax
		mov	al, cs:[bx]
		popf
		retn
sub_123B9	endp

; ---------------------------------------------------------------------------
		or	dx, [di]
		adc	dl, [si]

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

PlayBGM		proc near		; CODE XREF: mes18_PlayBGM+9p

arg_0		= dword	ptr  4
arg_4		= word ptr  8

		push	bp
		mov	bp, sp
		push	ds
		lds	dx, [bp+arg_0]
		mov	ah, 1
		jmp	short loc_123FB
; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		push	ds
		lds	dx, [bp+arg_0]
		mov	cx, [bp+arg_4]
		mov	ah, 2

loc_123FB:				; CODE XREF: PlayBGM+9j
		call	CallSoundDriver
		mov	cx, 0FFFFh
		mov	ah, 3
		call	CallSoundDriver
		pop	ds
		pop	bp
		retn
PlayBGM		endp

; ---------------------------------------------------------------------------
		mov	cx, 0FFFFh
		mov	ah, 4
		call	CallSoundDriver
		retn

; =============== S U B	R O U T	I N E =======================================


CallSoundDriver	proc near		; CODE XREF: PlayBGM:loc_123FBp
					; PlayBGM+1Fp ...
		push	ax
		push	es
		mov	ax, 35D2h
		int	21h		; DOS -	2+ - GET INTERRUPT VECTOR
					; AL = interrupt number
					; Return: ES:BX	= value	of interrupt vector
		cmp	byte ptr es:103h, 0CDh
		jnz	short loc_1242E
		cmp	byte ptr es:105h, 0C3h
		jnz	short loc_1242E
		pop	es
		pop	ax
		int	0D2h		; used by BASIC	while in interpreter
		retn
; ---------------------------------------------------------------------------

loc_1242E:				; CODE XREF: CallSoundDriver+Dj
					; CallSoundDriver+15j
		pop	es
		pop	ax
		retn
CallSoundDriver	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

ClearPixelVRAM	proc near		; CODE XREF: mes12_ClearVRAM+28p
					; mes12_ClearVRAM+35p
		push	bp
		mov	bp, sp
		push	di
		push	es
		mov	dx, 3E80h
		xor	di, di
		mov	ax, 0FFFFh
		mov	cx, dx
		mov	bx, 0A800h
		mov	es, bx
		assume es:nothing
		rep stosw
		xor	di, di
		mov	cx, dx
		mov	bx, 0B000h
		mov	es, bx
		assume es:nothing
		rep stosw
		xor	di, di
		mov	cx, dx
		mov	bx, 0B800h
		mov	es, bx
		assume es:nothing
		rep stosw
		xor	ax, ax
		mov	di, ax
		mov	cx, dx
		mov	bx, 0E000h
		mov	es, bx
		assume es:nothing
		rep stosw
		pop	es
		assume es:nothing
		pop	di
		pop	bp
		retn
ClearPixelVRAM	endp


; =============== S U B	R O U T	I N E =======================================


sub_1246E	proc near		; CODE XREF: mes12_ClearVRAM:loc_1101Ap
					; mes12_ClearVRAM+47p ...
		push	es
		push	di
		push	si
		mov	si, cs:word_13673
		mov	ax, cs:word_13679
		mov	bx, 50h
		imul	bx
		add	si, ax
		mov	bx, cs:word_13677
		mov	dx, cs:word_13675

loc_1248B:				; CODE XREF: sub_1246E+55j
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		mov	cx, bx
		mov	di, si
		xor	ax, ax
		rep stosb
		mov	ax, 0B000h
		mov	es, ax
		assume es:nothing
		mov	cx, bx
		mov	di, si
		xor	ax, ax
		rep stosb
		mov	ax, 0B800h
		mov	es, ax
		assume es:nothing
		mov	cx, bx
		mov	di, si
		xor	ax, ax
		rep stosb
		mov	ax, 0E000h
		mov	es, ax
		assume es:nothing
		mov	cx, bx
		mov	di, si
		xor	ax, ax
		rep stosb
		add	si, 50h
		dec	dx
		jnz	short loc_1248B
		pop	si
		pop	di
		pop	es
		assume es:nothing
		retn
sub_1246E	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_124C9	proc near		; CODE XREF: mes1F_TxtBoxThing+40p
					; InitGame+19Ep

arg_0		= word ptr  4
arg_2		= word ptr  6
arg_4		= word ptr  8
arg_6		= word ptr  0Ah

		push	bp
		mov	bp, sp
		mov	cx, [bp+arg_0]
		mov	cs:word_1366B, cx
		mov	bx, [bp+arg_2]
		mov	cs:word_1366D, bx
		mov	ax, 50h
		mul	bx
		add	ax, cx
		mov	cs:word_13673, ax
		mov	ax, [bp+arg_4]
		mov	cs:word_1366F, ax
		sub	ax, cx
		inc	ax
		mov	cs:word_13677, ax
		mov	ax, [bp+arg_6]
		mov	cs:word_13671, ax
		sub	ax, bx
		inc	ax
		mov	cs:word_13675, ax
		pop	bp
		retn
sub_124C9	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_12505	proc near		; CODE XREF: mes20+12p

arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		mov	ax, [bp+arg_0]

loc_1250B:
		mov	cs:word_13679, ax
		pop	bp
		retn
sub_12505	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

PrintTextChar	proc near		; CODE XREF: PrintTextLine+22p
					; PrintTextLine+46p ...

arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		mov	ax, [bp+arg_0]
		cmp	al, ' '
		jnb	short loc_12555	; >= 20h -> show
		cmp	al, 0Ah
		jnz	short loc_12547
		mov	dh, cs:txt_lineID ; handle 0Ah (next line)
		inc	dh
		cmp	dh, cs:txt_lineMax
		jbe	short loc_12532
		call	DoTextWait
		jmp	short loc_12537
; ---------------------------------------------------------------------------

loc_12532:				; CODE XREF: PrintTextChar+1Aj
		inc	cs:txt_lineID

loc_12537:				; CODE XREF: PrintTextChar+1Fj
					; PrintTextChar+42j
		xor	ax, ax
		mov	cs:txt_sjis_p1,	al
		pop	bp
		retn
; ---------------------------------------------------------------------------

loc_1253F:				; CODE XREF: PrintTextChar+53j
					; PrintTextChar+57j
		mov	cs:txt_sjis_p1,	al
		xor	ax, ax
		pop	bp
		retn
; ---------------------------------------------------------------------------

loc_12547:				; CODE XREF: PrintTextChar+Cj
		cmp	al, 0Dh
		jnz	short loc_12555
		mov	al, cs:txt_chrCount ; handle 0Dh (reset	cursor X position)
		mov	cs:txt_chrID, al
		jmp	short loc_12537
; ---------------------------------------------------------------------------

loc_12555:				; CODE XREF: PrintTextChar+8j
					; PrintTextChar+38j
		mov	ah, cs:txt_sjis_p1
		or	ah, ah
		jnz	short txt_draw
		cmp	al, 7Fh
		jb	short txt_draw
		cmp	al, 0E0h
		jnb	short loc_1253F	; 0E0h..0FFh ->	store byte
		cmp	al, 0A0h
		jb	short loc_1253F	; 80h..9Fh -> store byte

txt_draw:				; CODE XREF: PrintTextChar+4Bj
					; PrintTextChar+4Fj
		mov	dx, 1
		or	ah, ah
		jnz	short loc_1258F
		cmp	al, 20h
		ja	short loc_12584
		jz	short txt_space

loc_12577:				; CODE XREF: PrintTextChar+81j
		mov	ax, 0FFFFh
		pop	bp
		retn
; ---------------------------------------------------------------------------

txt_space:				; CODE XREF: PrintTextChar+64j
		mov	ax, 8640h
		xor	dx, dx
		jmp	short loc_1258F
; ---------------------------------------------------------------------------
		align 2

loc_12584:				; CODE XREF: PrintTextChar+62j
		add	ax, 851Fh
		cmp	ax, 857Fh
		jb	short loc_1258D
		inc	ax

loc_1258D:				; CODE XREF: PrintTextChar+79j
		xor	dx, dx

loc_1258F:				; CODE XREF: PrintTextChar+5Ej
					; PrintTextChar+70j
		sub	ax, 8140h
		jb	short loc_12577
		cmp	al, 40h
		jb	short loc_1259A
		dec	al

loc_1259A:				; CODE XREF: PrintTextChar+85j
		cmp	ah, 5Fh
		jb	short loc_125A2
		sub	ah, 40h

loc_125A2:				; CODE XREF: PrintTextChar+8Cj
		shl	ah, 1
		inc	ah
		cmp	al, 5Eh
		jb	short loc_125AE
		inc	ah
		sub	al, 5Eh

loc_125AE:				; CODE XREF: PrintTextChar+97j
		add	al, 21h
		mov	cx, ax
		mov	cs:byte_13697, dl
		xor	ax, ax
		mov	al, cs:txt_lineID
		mov	dx, 50h
		mul	dx
		xor	dh, dh
		mov	dl, cs:txt_chrID
		cmp	dl, cs:txt_chrMax
		ja	short loc_125D6
		jnz	short loc_125FF
		or	cx, cx
		jz	short loc_125FF

loc_125D6:				; CODE XREF: PrintTextChar+BDj
		mov	dl, cs:txt_chrCount
		mov	cs:txt_chrID, dl
		mov	dh, cs:txt_lineID
		inc	dh
		cmp	dh, cs:txt_lineMax
		jbe	short loc_125F5
		call	DoTextWait
		xor	dh, dh
		jmp	short loc_125FF
; ---------------------------------------------------------------------------

loc_125F5:				; CODE XREF: PrintTextChar+DBj
		mov	cs:txt_lineID, dh
		xor	dh, dh
		add	dx, 50h

loc_125FF:				; CODE XREF: PrintTextChar+BFj
					; PrintTextChar+C3j ...
		add	ax, dx
		shl	ax, 1
		mov	bx, ax
		mov	dl, cs:byte_1369B
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
		cmp	cs:byte_13697, 0
		jz	short loc_12653
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
		add	cs:txt_chrID, al
		jmp	short loc_1266B
; ---------------------------------------------------------------------------

loc_12653:				; CODE XREF: PrintTextChar+113j
		mov	es:[bx], ch
		inc	bx
		mov	es:[bx], cl
		mov	ax, 0A200h
		mov	es, ax
		dec	bx
		mov	es:[bx], dl
		inc	cs:txt_chrID
		mov	ax, 1

loc_1266B:				; CODE XREF: PrintTextChar+140j
		cmp	cs:txt_sjis_p1,	81h
		jnz	short loc_12675
		xor	ax, ax

loc_12675:				; CODE XREF: PrintTextChar+160j
		mov	cs:txt_sjis_p1,	0
		pop	bp
		retn
PrintTextChar	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

SetTextBoxData	proc near		; CODE XREF: mes1A_DoSelect+20Ap
					; mes1A_DoSelect+31Bp ...

arg_0		= word ptr  4
arg_2		= word ptr  6
arg_4		= word ptr  8
arg_6		= word ptr  0Ah

		push	bp
		mov	bp, sp
		mov	cx, [bp+arg_0]
		mov	cs:txt_chrCount, cl
		mov	bx, [bp+arg_2]
		mov	cs:byte_1369D, bl
		mov	al, bl
		neg	al
		out	78h, al
		mov	ax, 50h
		mul	bx
		add	ax, cx
		add	ax, ax
		mov	cs:txt_tramOfs,	ax
		mov	ax, [bp+arg_4]
		mov	cs:txt_chrMax, al
		sub	ax, cx
		inc	ax
		mov	cs:txt_tramLineOfs, ax
		mov	ax, [bp+arg_6]
		mov	cs:txt_lineMax,	al
		sub	ax, bx
		out	7Ah, al
		inc	ax
		mov	cs:word_1367D, ax
		pop	bp
		retn
SetTextBoxData	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

GetTextBoxData	proc near		; CODE XREF: sub_112D6+134p
					; sub_112D6+29Ap ...

arg_0		= word ptr  4
arg_2		= word ptr  6

		push	bp
		mov	bp, sp
		mov	ax, [bp+arg_0]
		mov	bl, cs:txt_chrID
		mov	bh, cs:txt_lineID
		cmp	al, cs:txt_chrCount
		jnb	short loc_126E0
		mov	al, cs:txt_chrCount
		jmp	short loc_126EB
; ---------------------------------------------------------------------------

loc_126E0:				; CODE XREF: GetTextBoxData+15j
		cmp	al, cs:txt_chrMax
		jbe	short loc_126EB
		mov	al, cs:txt_chrMax

loc_126EB:				; CODE XREF: GetTextBoxData+1Bj
					; GetTextBoxData+22j
		mov	cs:txt_chrID, al
		mov	ax, [bp+arg_2]
		cmp	al, cs:byte_1369D
		jnb	short loc_126FF
		mov	al, cs:byte_1369D
		jmp	short loc_1270A
; ---------------------------------------------------------------------------

loc_126FF:				; CODE XREF: GetTextBoxData+34j
		cmp	al, cs:txt_lineMax
		jbe	short loc_1270A
		mov	al, cs:txt_lineMax

loc_1270A:				; CODE XREF: GetTextBoxData+3Aj
					; GetTextBoxData+41j
		mov	cs:txt_lineID, al
		mov	ax, bx
		pop	bp
		retn
GetTextBoxData	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

SetTextGFXAddr	proc near		; CODE XREF: sub_10010+15p
					; mes01_TextNarrator+12p ...

arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		mov	ax, [bp+arg_0]
		mov	cs:byte_1369B, al
		pop	bp
		retn
SetTextGFXAddr	endp


; =============== S U B	R O U T	I N E =======================================


ClearTextVRAM	proc near		; CODE XREF: mes12_ClearVRAM+1Cp
					; mes1A_DoSelect+308p
		push	es
		push	di
		push	si
		mov	si, cs:txt_tramOfs
		mov	bx, cs:txt_tramLineOfs
		mov	dx, cs:word_1367D

loc_12730:				; CODE XREF: ClearTextVRAM+33j
		mov	ax, 0A000h
		mov	es, ax
		assume es:nothing
		mov	cx, bx
		mov	di, si
		mov	ax, 20h
		rep stosw
		mov	ax, 0A200h
		mov	es, ax
		assume es:nothing
		mov	cx, bx
		mov	di, si
		mov	ax, 0E1h
		rep stosw
		add	si, 0A0h
		dec	dx
		jnz	short loc_12730
		pop	si
		pop	di
		pop	es
		assume es:nothing
		retn
ClearTextVRAM	endp


; =============== S U B	R O U T	I N E =======================================


DoTextWait	proc near		; CODE XREF: PrintTextChar+1Cp
					; PrintTextChar+DDp
		push	ax
		push	bx
		push	cx
		push	dx
		push	si
		push	di
		push	ds
		push	es
		cmp	cs:ScrollMode, 0
		jz	short loc_127AB
		mov	cs:byte_136A1, 0Fh

loc_1276D:				; CODE XREF: DoTextWait+1Cj
		cmp	cs:byte_136A1, 0
		jnz	short loc_1276D
		mov	cx, cs:word_13683
		mov	dx, cx
		and	cl, 7
		and	dl, 10h
		shr	dx, 1
		or	dl, 2
		mov	ax, 1
		shl	ax, cl
		mov	ah, al
		cli
		in	al, dx
		jmp	short $+2
		or	al, ah
		out	dx, al
		sti

loc_12796:				; CODE XREF: DoTextWait+43j
		in	al, 60h		; 8042 keyboard	controller data	register
		and	al, 20h
		jnz	short loc_12796

loc_1279C:				; CODE XREF: DoTextWait+49j
		in	al, 60h		; 8042 keyboard	controller data	register
		and	al, 20h
		jz	short loc_1279C
		cli
		in	al, dx
		jmp	short $+2
		not	ah
		and	al, ah
		out	dx, al

loc_127AB:				; CODE XREF: DoTextWait+Ej
		xor	ax, ax
		out	76h, al
		mov	ax, 0A000h
		mov	ds, ax
		assume ds:nothing
		mov	es, ax
		assume es:nothing
		mov	di, cs:txt_tramOfs
		mov	dx, cs:word_1367D
		dec	dx
		mov	bx, cs:txt_tramLineOfs

loc_127C6:				; CODE XREF: DoTextWait+7Ej
		mov	si, di
		add	si, 0A0h
		mov	ax, si
		mov	cx, bx
		rep movsw
		mov	di, ax
		dec	dx
		jnz	short loc_127C6
		mov	ax, 20h
		mov	cx, bx
		rep stosw
		mov	ax, 0A200h
		mov	ds, ax
		assume ds:nothing
		mov	es, ax
		assume es:nothing
		mov	di, cs:txt_tramOfs
		mov	dx, cs:word_1367D
		dec	dx
		mov	bx, cs:txt_tramLineOfs

loc_127F5:				; CODE XREF: DoTextWait+ADj
		mov	si, di
		add	si, 0A0h
		mov	ax, si
		mov	cx, bx
		rep movsw
		mov	di, ax
		dec	dx
		jnz	short loc_127F5
		mov	ax, 0E1h
		mov	cx, bx
		rep stosw
		sti
		pop	es
		assume es:nothing
		pop	ds
		assume ds:nothing
		pop	di
		pop	si
		pop	dx
		pop	cx
		pop	bx
		pop	ax
		retn
DoTextWait	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

PrintText	proc near		; CODE XREF: sub_10010+20p
					; mes02_TextChr1+22p ...

textPtr		= dword	ptr  4

		push	bp
		mov	bp, sp
		push	ds
		push	si
		mov	cs:txt_sjis_p1,	0
		lds	si, [bp+textPtr]

loc_12825:				; CODE XREF: PrintText+1Aj
		lodsb
		or	al, al
		jz	short loc_12833
		push	ax
		call	PrintTextChar
		add	sp, 2
		jmp	short loc_12825
; ---------------------------------------------------------------------------

loc_12833:				; CODE XREF: PrintText+11j
		pop	si
		pop	ds
		pop	bp
		retn
PrintText	endp

; ---------------------------------------------------------------------------

Int0A:					; DATA XREF: SetupInterrupts+18o
					; SetupInterrupts+35o ...
		push	ax
		push	bx
		mov	bx, cs:word_13685
		cmp	bx, cs:word_13687
		jz	short loc_12860
		xor	ax, ax
		test	bx, 1
		jz	short loc_1284E
		inc	ax

loc_1284E:				; CODE XREF: seg000:284Bj
		out	0A4h, al	; Interrupt Controller #2, 8259A
		xor	ax, ax
		test	bx, 2
		jz	short loc_12859
		inc	ax

loc_12859:				; CODE XREF: seg000:2856j
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	cs:word_13687, bx

loc_12860:				; CODE XREF: seg000:2843j
		mov	al, cs:byte_136A1
		or	al, al
		jz	short loc_12873
		dec	cs:byte_136A1
		neg	al
		and	al, 0Fh
		out	76h, al

loc_12873:				; CODE XREF: seg000:2866j
		mov	al, 20h
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
		cmp	cs:charDrawDelay, 0
		jz	short loc_12886
		dec	cs:charDrawDelay

loc_12886:				; CODE XREF: seg000:287Fj
		test	cs:byte_1368F, 1
		jz	short loc_1289C
		push	es
		xor	ax, ax
		mov	es, ax
		assume es:nothing
		test	byte ptr es:52Dh, 10h
		pop	es
		assume es:nothing
		jz	short loc_128A2

loc_1289C:				; CODE XREF: seg000:288Cj
		or	cs:byte_136A7, 1

loc_128A2:				; CODE XREF: seg000:289Aj
		cmp	cs:word_1368B, 0
		jz	short loc_128AF
		dec	cs:word_1368B

loc_128AF:				; CODE XREF: seg000:28A8j
		cmp	cs:byte_136A2, 0
		jnz	short loc_128BF
		cmp	cs:byte_136A3, 0
		jz	short loc_128C2

loc_128BF:				; CODE XREF: seg000:28B5j
		pop	bx
		pop	ax
		iret
; ---------------------------------------------------------------------------

loc_128C2:				; CODE XREF: seg000:28BDj
		mov	cs:byte_136A3, 1
		sti
		mov	cs:byte_136A4, 0
		push	cx
		push	dx
		push	si
		push	di
		push	ds
		push	es
		mov	ax, seg	seg003
		mov	ds, ax
		assume ds:seg003
		mov	al, cs:byte_136A8
		cmp	al, 0FFh
		jz	short loc_12929
		xor	ah, ah
		add	ax, ax
		add	ax, ax
		mov	bx, 0Eh
		add	bx, ax
		mov	ax, [bx]
		mov	dx, [bx+2]
		mov	bx, ax
		or	bx, dx
		jz	short loc_12923
		push	dx
		push	ax
		call	sub_131D2
		xor	ax, ax
		mov	bx, cs:word_13687
		test	bx, 2
		jnz	short loc_1290B
		inc	ax

loc_1290B:				; CODE XREF: seg000:2908j
		out	0A6h, al	; Interrupt Controller #2, 8259A
		call	sub_131D2
		add	sp, 4
		xor	ax, ax
		mov	bx, cs:word_13687
		test	bx, 2
		jz	short loc_12921
		inc	ax

loc_12921:				; CODE XREF: seg000:291Ej
		out	0A6h, al	; Interrupt Controller #2, 8259A

loc_12923:				; CODE XREF: seg000:28F6j
		mov	cs:byte_136A8, 0FFh

loc_12929:				; CODE XREF: seg000:28E0j
		cmp	cs:word_13689, 0
		jz	short loc_12957
		cmp	cs:word_1368B, 0
		jnz	short loc_12957
		cmp	word_16A90, 0FFFFh
		jz	short loc_12957
		mov	cs:word_1368B, 6
		cmp	cs:byte_136A7, 0
		jz	short loc_12997
		mov	cs:byte_136A6, 1
		jmp	short loc_12997
; ---------------------------------------------------------------------------

loc_12957:				; CODE XREF: seg000:292Fj seg000:2937j ...
		mov	al, cs:byte_136A4
		or	al, al
		jz	short loc_1297B
		test	al, 2
		jz	short loc_12975
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		mov	bx, 0DAh ; 'Ú'
		les	bx, [bx]
		push	es
		push	bx
		call	sub_1324A
		add	sp, 4

loc_12975:				; CODE XREF: seg000:2961j
		xor	cs:word_13685, 3

loc_1297B:				; CODE XREF: seg000:295Dj
		cli
		pop	es
		pop	ds
		assume ds:nothing
		pop	di
		pop	si
		pop	dx
		pop	cx
		mov	cs:byte_136A6, 0
		mov	cs:byte_136A3, 0
		mov	cs:byte_136A7, 0
		pop	bx
		pop	ax
		iret
; ---------------------------------------------------------------------------

loc_12997:				; CODE XREF: seg000:294Dj seg000:2955j
		xor	si, si

loc_12999:				; CODE XREF: seg000:29BFj seg000:2A18j ...
		cmp	si, ds:692h
		jnb	short loc_12957
		cmp	cs:AnimationMode, 0
		jnz	short loc_129B6
		test	byte ptr [si+652h], 1
		jz	short loc_129B6
		cmp	cs:byte_136A6, 0
		jz	short loc_12A1F

loc_129B6:				; CODE XREF: seg000:29A5j seg000:29ACj ...
		mov	al, [si+662h]
		cmp	al, 0FFh
		jnz	short loc_129C1
		inc	si
		jmp	short loc_12999
; ---------------------------------------------------------------------------

loc_129C1:				; CODE XREF: seg000:29BCj
		xor	ah, ah
		mov	di, ax
		inc	ax
		mov	[si+662h], al
		mov	bx, 40Eh
		mov	ax, si
		add	ax, ax
		add	ax, ax
		add	bx, ax
		les	bx, [bx]
		mov	al, es:[bx+di]
		cmp	al, 0FBh ; 'û'
		jnb	short loc_12A1B
		cmp	al, ds:64Eh
		jnb	short loc_12A04
		xor	ah, ah
		push	ax
		add	ax, ax
		add	ax, ax
		mov	bx, 0Eh
		add	bx, ax
		mov	ax, [bx]
		mov	dx, [bx+2]
		mov	bx, ax
		or	bx, dx
		jz	short loc_12A03
		push	dx
		push	ax
		call	sub_131D2
		add	sp, 4

loc_12A03:				; CODE XREF: seg000:29F9j
		pop	ax

loc_12A04:				; CODE XREF: seg000:29E2j
		mov	ah, [si+652h]
		and	ah, 2
		or	ah, 1
		or	cs:byte_136A4, ah
		mov	[si+682h], al
		inc	si
		jmp	loc_12999
; ---------------------------------------------------------------------------

loc_12A1B:				; CODE XREF: seg000:29DCj
		inc	al
		jnz	short loc_12A5D

loc_12A1F:				; CODE XREF: seg000:29B4j seg000:2AA0j
		mov	al, cs:[si+6AC2h]
		cmp	al, ds:64Eh
		jnb	short loc_12A48
		xor	ah, ah
		add	ax, ax
		add	ax, ax
		mov	bx, 0Eh
		add	bx, ax
		mov	ax, [bx]
		mov	dx, [bx+2]
		mov	bx, ax
		or	bx, dx
		jz	short loc_12A48
		push	dx
		push	ax
		call	sub_131D2
		add	sp, 4

loc_12A48:				; CODE XREF: seg000:2A28j seg000:2A3Ej
		mov	ah, [si+652h]
		and	ah, 2
		or	cs:byte_136A4, ah
		mov	byte ptr [si+682h], 0FFh
		inc	si
		jmp	loc_12999
; ---------------------------------------------------------------------------

loc_12A5D:				; CODE XREF: seg000:2A1Dj
		inc	al
		jnz	short loc_12A69
		mov	byte ptr [si+662h], 0
		jmp	loc_129B6
; ---------------------------------------------------------------------------

loc_12A69:				; CODE XREF: seg000:2A5Fj
		inc	al
		jnz	short loc_12A8C
		mov	al, [si+662h]
		xor	ah, ah
		mov	di, ax
		mov	bx, 40Eh
		mov	ax, si
		add	ax, ax
		add	ax, ax
		add	bx, ax
		les	bx, [bx]
		mov	al, es:[bx+di]
		mov	[si+662h], al
		jmp	loc_129B6
; ---------------------------------------------------------------------------

loc_12A8C:				; CODE XREF: seg000:2A6Bj
		inc	al
		jnz	short loc_12AA3
		mov	byte ptr [si+662h], 0FFh
		mov	cx, si
		mov	ax, 1
		shl	ax, cl
		or	ds:650h, ax
		jmp	loc_12A1F
; ---------------------------------------------------------------------------

loc_12AA3:				; CODE XREF: seg000:2A8Ej
		mov	al, [si+662h]
		xor	ah, ah
		mov	di, ax
		mov	bx, 40Eh
		mov	ax, si
		add	ax, ax
		add	ax, ax
		add	bx, ax
		les	bx, [bx]
		mov	cl, es:[bx+di]
		inc	di
		mov	al, [si+672h]
		cmp	al, es:[bx+di]
		jb	short loc_12AD4
		mov	byte ptr [si+672h], 0
		inc	di
		mov	ax, di
		mov	[si+662h], al
		jmp	loc_129B6
; ---------------------------------------------------------------------------

loc_12AD4:				; CODE XREF: seg000:2AC3j
		inc	al
		mov	[si+672h], al
		mov	[si+662h], cl
		jmp	loc_129B6

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

SetupInterrupts	proc near		; CODE XREF: InitGame+77p

arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		mov	ax, [bp+arg_0]
		mov	cs:word_13683, ax
		call	sub_12358
		mov	cs:word_1365D, ax
		push	ds
		push	es
		mov	ax, 350Ah
		int	21h		; DOS -	2+ - GET INTERRUPT VECTOR
					; AL = interrupt number
					; Return: ES:BX	= value	of interrupt vector
		cmp	bx, offset Int0A
		jnz	short loc_12B0A
		mov	dx, es
		mov	ax, cs
		cmp	ax, dx
		jnz	short loc_12B0A
		jmp	loc_12BC1
; ---------------------------------------------------------------------------

loc_12B0A:				; CODE XREF: SetupInterrupts+1Cj
					; SetupInterrupts+24j
		mov	ax, cs
		mov	ds, ax
		assume ds:seg000
		mov	word ptr BakIntVec0A, bx
		mov	word ptr BakIntVec0A+2,	es
		mov	dx, offset Int0A
		mov	ax, 250Ah
		int	21h		; DOS -	SET INTERRUPT VECTOR
					; AL = interrupt number
					; DS:DX	= new vector to	be used	for specified interrupt
		mov	ax, 3518h
		int	21h		; DOS -	2+ - GET INTERRUPT VECTOR
					; AL = interrupt number
					; Return: ES:BX	= value	of interrupt vector
		mov	word ptr BakIntVec18, bx
		mov	word ptr BakIntVec18+2,	es
		mov	dx, offset Int18
		mov	ax, 2518h
		int	21h		; DOS -	SET INTERRUPT VECTOR
					; AL = interrupt number
					; DS:DX	= new vector to	be used	for specified interrupt
		mov	ax, 3506h
		int	21h		; DOS -	2+ - GET INTERRUPT VECTOR
					; AL = interrupt number
					; Return: ES:BX	= value	of interrupt vector
		mov	word ptr BakIntVec06, bx
		mov	word ptr BakIntVec06+2,	es
		mov	dx, offset Int06
		mov	ax, 2506h
		int	21h		; DOS -	SET INTERRUPT VECTOR
					; AL = interrupt number
					; DS:DX	= new vector to	be used	for specified interrupt
		pushf
		cli
		mov	ax, word_13683
		mov	ah, 35h
		int	21h		; DOS -	2+ - GET INTERRUPT VECTOR
					; AL = interrupt number
					; Return: ES:BX	= value	of interrupt vector
		mov	word ptr BakIntVec00, bx
		mov	word ptr BakIntVec00+2,	es
		mov	ax, es
		mov	dx, cs
		cmp	ax, dx
		jb	short loc_12B70
		cmp	ax, 0A000h
		jnb	short loc_12B70
		mov	dx, offset Int00
		mov	ax, word_13683
		mov	ah, 25h
		int	21h		; DOS -	SET INTERRUPT VECTOR
					; AL = interrupt number
					; DS:DX	= new vector to	be used	for specified interrupt

loc_12B70:				; CODE XREF: SetupInterrupts+7Ej
					; SetupInterrupts+83j
		popf
		mov	ax, 3515h
		int	21h		; DOS -	2+ - GET INTERRUPT VECTOR
					; AL = interrupt number
					; Return: ES:BX	= value	of interrupt vector
		mov	word ptr BakIntVec15, bx
		mov	word ptr BakIntVec15+2,	es
		mov	dx, 7FDFh
		mov	al, 92h
		out	dx, al
		mov	dx, 7FDDh
		mov	al, 50h
		out	dx, al
		jmp	short $+2
		jmp	short $+2
		in	al, dx
		and	al, 0F0h
		cmp	al, 50h
		jnz	short loc_12BC1
		pushf
		cli
		in	al, 0Ah		; DMA controller, 8237A-5.
					; single mask bit register
					; 0-1: select channel (00=0; 01=1; 10=2; 11=3)
					; 2: 1=set mask	for channel; 0=clear mask (enable)
		jmp	short $+2
		jmp	short $+2
		or	al, 20h
		out	0Ah, al		; DMA controller, 8237A-5.
					; single mask bit register
					; 0-1: select channel (00=0; 01=1; 10=2; 11=3)
					; 2: 1=set mask	for channel; 0=clear mask (enable)
		popf
		mov	dx, offset Int15
		mov	ax, 2515h
		int	21h		; DOS -	SET INTERRUPT VECTOR
					; AL = interrupt number
					; DS:DX	= new vector to	be used	for specified interrupt
		xor	ax, ax
		mov	dx, 0BFDBh
		out	dx, al
		mov	dx, 7FDDh
		out	dx, al
		pushf
		cli
		in	al, 0Ah		; DMA controller, 8237A-5.
					; single mask bit register
					; 0-1: select channel (00=0; 01=1; 10=2; 11=3)
					; 2: 1=set mask	for channel; 0=clear mask (enable)
		jmp	short $+2
		jmp	short $+2
		and	al, 0DFh
		out	0Ah, al		; DMA controller, 8237A-5.
					; single mask bit register
					; 0-1: select channel (00=0; 01=1; 10=2; 11=3)
					; 2: 1=set mask	for channel; 0=clear mask (enable)
		popf

loc_12BC1:				; CODE XREF: SetupInterrupts+26j
					; SetupInterrupts+B2j
		pop	es
		pop	ds
		assume ds:nothing
		pushf
		cli
		in	al, 2		; DMA controller, 8237A-5.
					; channel 1 current address
		jmp	short $+2
		jmp	short $+2
		and	al, 0FBh
		out	2, al		; DMA controller, 8237A-5.
					; channel 1 base address
					; (also	sets current address)
		jmp	short $+2
		jmp	short $+2
		popf
		out	64h, al		; 8042 keyboard	controller command register.
		xor	ax, ax
		pop	bp
		retn
SetupInterrupts	endp

; ---------------------------------------------------------------------------

Int18:					; DATA XREF: SetupInterrupts+4Ao
		pushf
		call	cs:BakIntVec18
		out	64h, al		; 8042 keyboard	controller command register.
		iret
; ---------------------------------------------------------------------------

Int06:					; DATA XREF: SetupInterrupts+5Fo
		push	ax
		push	ds
		xor	ax, ax
		mov	ds, ax
		assume ds:nothing
		test	byte ptr ds:538h, 10h
		jnz	short loc_12C00
		test	byte ptr ds:538h, 8
		jz	short loc_12C28
		mov	cs:word_13669, 0
		jmp	short loc_12C07
; ---------------------------------------------------------------------------

loc_12C00:				; CODE XREF: seg000:2BEEj
		mov	cs:word_13659, 0FFFFh

loc_12C07:				; CODE XREF: seg000:2BFEj seg000:2C26j ...
		pop	ds
		assume ds:nothing
		pop	ax
		iret
; ---------------------------------------------------------------------------

loc_12C0A:				; CODE XREF: seg000:2C38j
		mov	cs:word_1365B, 0
		mov	ah, 12h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		push	dx
		mov	ah, 0Eh
		mov	dx, 0
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		pop	dx
		mov	al, 0Dh
		out	0A2h, al	; Interrupt Controller #2, 8259A
		mov	al, 1
		out	6Ah, al
		jmp	short loc_12C07
; ---------------------------------------------------------------------------

loc_12C28:				; CODE XREF: seg000:2BF5j
		in	al, 2		; DMA controller, 8237A-5.
					; channel 1 current address
		jmp	short $+2
		jmp	short $+2
		or	al, 2
		out	2, al		; DMA controller, 8237A-5.
					; channel 1 base address
					; (also	sets current address)
		cmp	cs:word_1365B, 0
		jnz	short loc_12C0A
		mov	cs:word_1365B, 1
		mov	al, 0Ch
		out	0A2h, al	; Interrupt Controller #2, 8259A
		mov	al, 0
		out	6Ah, al
		push	dx
		mov	ah, 13h
		mov	dx, 116Ah
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		mov	ah, 11h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		mov	ah, 0Eh
		mov	dx, 1040h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		pop	dx
		in	al, 2		; DMA controller, 8237A-5.
					; channel 1 current address
		jmp	short $+2
		jmp	short $+2
		and	al, 0FDh
		out	2, al		; DMA controller, 8237A-5.
					; channel 1 base address
					; (also	sets current address)
		sti

loc_12C68:				; CODE XREF: seg000:2C6Ej
		cmp	cs:word_1365B, 0
		jnz	short loc_12C68
		cli
		in	al, 2		; DMA controller, 8237A-5.
					; channel 1 current address
		jmp	short $+2
		jmp	short $+2
		and	al, 0FDh
		out	2, al		; DMA controller, 8237A-5.
					; channel 1 base address
					; (also	sets current address)
		jmp	short loc_12C07
; ---------------------------------------------------------------------------

Int00:					; DATA XREF: SetupInterrupts+85o
		mov	cs:byte_136A2, 1
		pushf
		call	cs:BakIntVec00
		mov	cs:byte_136A2, 0
		iret
; ---------------------------------------------------------------------------

Int15:					; DATA XREF: SetupInterrupts+C1o
		sti
		push	dx
		push	bx
		push	ax
		mov	bx, 7FD9h
		mov	dx, 7FDDh
		mov	al, 80h	; '€'
		out	dx, al
		jmp	short $+2
		jmp	short $+2
		xchg	bx, dx
		in	al, dx
		jmp	short $+2
		jmp	short $+2
		and	al, 0Fh
		mov	ah, al
		xchg	bx, dx
		mov	al, 0A0h ; ' '
		out	dx, al
		jmp	short $+2
		jmp	short $+2
		xchg	bx, dx
		in	al, dx
		jmp	short $+2
		jmp	short $+2
		shl	al, 1
		shl	al, 1
		shl	al, 1
		shl	al, 1
		or	al, ah
		cbw
		or	ax, ax
		js	short loc_12CDD
		add	ax, cs:word_1364D
		cmp	ax, cs:word_13655
		jle	short loc_12CED
		mov	ax, cs:word_13655
		jmp	short loc_12CED
; ---------------------------------------------------------------------------

loc_12CDD:				; CODE XREF: seg000:2CC9j
		add	ax, cs:word_1364D
		cmp	ax, cs:word_13651
		jge	short loc_12CED
		mov	ax, cs:word_13651

loc_12CED:				; CODE XREF: seg000:2CD5j seg000:2CDBj ...
		mov	cs:word_1364D, ax
		xchg	bx, dx
		mov	al, 0C0h ; 'À'
		out	dx, al
		jmp	short $+2
		jmp	short $+2
		xchg	bx, dx
		in	al, dx
		jmp	short $+2
		jmp	short $+2
		and	al, 0Fh
		mov	ah, al
		xchg	bx, dx
		mov	al, 0E0h ; 'à'
		out	dx, al
		jmp	short $+2
		jmp	short $+2
		xchg	bx, dx
		in	al, dx
		mov	dl, al
		shl	al, 1
		shl	al, 1
		shl	al, 1
		shl	al, 1
		or	al, ah
		cbw
		or	ax, ax
		js	short loc_12D34
		add	ax, cs:word_1364F
		cmp	ax, cs:word_13657
		jle	short loc_12D44
		mov	ax, cs:word_13657
		jmp	short loc_12D44
; ---------------------------------------------------------------------------

loc_12D34:				; CODE XREF: seg000:2D20j
		add	ax, cs:word_1364F
		cmp	ax, cs:word_13653
		jge	short loc_12D44
		mov	ax, cs:word_13653

loc_12D44:				; CODE XREF: seg000:2D2Cj seg000:2D32j ...
		mov	cs:word_1364F, ax
		xor	ax, ax
		xchg	bx, dx
		out	dx, al
		shl	bl, 1
		rcl	ax, 1
		shl	bl, 1
		shl	bl, 1
		rcl	ax, 1
		mov	cs:byte_1368F, al
		mov	al, 20h	; ' '
		out	8, al
		jmp	short $+2
		jmp	short $+2
		mov	al, 0Bh
		out	8, al
		jmp	short $+2
		jmp	short $+2
		in	al, 8
		or	al, al
		jnz	short loc_12D75
		mov	al, 20h	; ' '
		out	0, al

loc_12D75:				; CODE XREF: seg000:2D6Fj
		pop	ax
		pop	bx
		pop	dx
		iret

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_12D79	proc near		; CODE XREF: DoMenuSelection+38p

arg_0		= word ptr  4
arg_2		= word ptr  6

		push	bp
		mov	bp, sp
		pushf
		cli
		mov	ax, [bp+arg_0]
		mov	cs:word_1364D, ax
		mov	ax, [bp+arg_2]
		mov	cs:word_1364F, ax
		popf
		pop	bp
		retn
sub_12D79	endp


; =============== S U B	R O U T	I N E =======================================


sub_12D8F	proc near		; CODE XREF: DoMenuSelection:loc_1161Cp
		mov	dx, cs:word_1364D
		mov	ax, cs:word_1364F
		retn
sub_12D8F	endp


; =============== S U B	R O U T	I N E =======================================


sub_12D99	proc near		; CODE XREF: DoMenuSelection+45p
		xor	ax, ax
		mov	al, cs:byte_1368F
		xor	ax, 3
		retn
sub_12D99	endp

; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		pushf
		cli
		mov	ax, [bp+4]
		mov	cs:word_13655, ax
		mov	ax, [bp+6]
		mov	cs:word_13657, ax
		mov	ax, [bp+8]
		mov	cs:word_13651, ax
		mov	ax, [bp+0Ah]
		mov	cs:word_13653, ax
		mov	ax, [bp+0Ch]
		mov	cs:word_1364D, ax
		mov	ax, [bp+0Eh]
		mov	cs:word_1364F, ax
		popf
		pop	bp
		retn

; =============== S U B	R O U T	I N E =======================================


sub_12DD5	proc near		; CODE XREF: sub_12E5B:loc_12E88p
		pushf
		cli
		push	ds
		push	es
		mov	ax, 350Ah
		int	21h		; DOS -	2+ - GET INTERRUPT VECTOR
					; AL = interrupt number
					; Return: ES:BX	= value	of interrupt vector
		cmp	bx, offset Int0A
		jnz	short loc_12E2E
		mov	ax, es
		mov	dx, cs
		cmp	ax, dx
		jnz	short loc_12E2E
		lds	dx, cs:BakIntVec0A
		mov	ax, 250Ah
		int	21h		; DOS -	SET INTERRUPT VECTOR
					; AL = interrupt number
					; DS:DX	= new vector to	be used	for specified interrupt
		lds	dx, cs:BakIntVec18
		mov	ax, 2518h
		int	21h		; DOS -	SET INTERRUPT VECTOR
					; AL = interrupt number
					; DS:DX	= new vector to	be used	for specified interrupt
		lds	dx, cs:BakIntVec06
		mov	ax, 2506h
		int	21h		; DOS -	SET INTERRUPT VECTOR
					; AL = interrupt number
					; DS:DX	= new vector to	be used	for specified interrupt
		pushf
		cli
		lds	dx, cs:BakIntVec00
		mov	ax, cs:word_13683
		mov	ah, 25h
		int	21h		; DOS -	SET INTERRUPT VECTOR
					; AL = interrupt number
					; DS:DX	= new vector to	be used	for specified interrupt
		popf
		in	al, 0Ah		; DMA controller, 8237A-5.
					; single mask bit register
					; 0-1: select channel (00=0; 01=1; 10=2; 11=3)
					; 2: 1=set mask	for channel; 0=clear mask (enable)
		jmp	short $+2
		jmp	short $+2
		or	al, 20h
		out	0Ah, al		; DMA controller, 8237A-5.
					; single mask bit register
					; 0-1: select channel (00=0; 01=1; 10=2; 11=3)
					; 2: 1=set mask	for channel; 0=clear mask (enable)
		lds	dx, cs:BakIntVec15
		mov	ax, 2515h
		int	21h		; DOS -	SET INTERRUPT VECTOR
					; AL = interrupt number
					; DS:DX	= new vector to	be used	for specified interrupt

loc_12E2E:				; CODE XREF: sub_12DD5+Dj
					; sub_12DD5+15j
		pop	es
		pop	ds
		out	64h, al		; 8042 keyboard	controller command register.
		popf
		retn
sub_12DD5	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_12E34	proc near		; CODE XREF: mes0B_GfxThing+FAp
					; mes0B_GfxThing+110p ...

arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		mov	ax, [bp+arg_0]
		and	ax, 3
		xor	ax, cs:word_13685
		mov	cs:word_13685, ax

loc_12E46:				; CODE XREF: sub_12E34+17j
		cmp	ax, cs:word_13687
		jnz	short loc_12E46
		pop	bp
		retn
sub_12E34	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

SetCharacterDelay proc near		; CODE XREF: PrintTextLine:loc_1015Cp
					; GameMain+EAp

arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		mov	ax, [bp+arg_0]
		mov	cs:charDrawDelay, ax
		pop	bp
		retn
SetCharacterDelay endp


; =============== S U B	R O U T	I N E =======================================


sub_12E5B	proc near		; CODE XREF: PrintTextLine+2Fp
					; GameMain+F0p
		push	ds
		xor	ax, ax
		mov	ds, ax
		assume ds:nothing

loc_12E60:				; CODE XREF: sub_12E5B+29j
		test	byte ptr ds:530h, 10h
		jnz	short loc_12E86
		test	byte ptr ds:538h, 1
		jnz	short loc_12E86
		cmp	cs:word_13659, 0FFFFh
		jnz	short loc_12E7E
		cmp	cs:word_1365D, 0FFFFh
		jz	short loc_12E88

loc_12E7E:				; CODE XREF: sub_12E5B+19j
		cmp	cs:charDrawDelay, 0
		jnz	short loc_12E60

loc_12E86:				; CODE XREF: sub_12E5B+Aj
					; sub_12E5B+11j
		pop	ds
		assume ds:nothing
		retn
; ---------------------------------------------------------------------------

loc_12E88:				; CODE XREF: sub_12E5B+21j
		call	sub_12DD5
		call	sub_123AD
		mov	ax, 4C00h
		out	0A4h, al	; Interrupt Controller #2, 8259A
		out	0A6h, al	; Interrupt Controller #2, 8259A
		int	21h		; DOS -	2+ - QUIT WITH EXIT CODE (EXIT)
sub_12E5B	endp			; AL = exit code


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_12E97	proc near		; CODE XREF: mes0E+72p

arg_0		= byte ptr  4
arg_2		= byte ptr  6

		push	bp
		mov	bp, sp
		push	ds
		push	si
		mov	ax, 1
		out	6Ah, al
		xor	bh, bh

loc_12EA3:				; CODE XREF: sub_12E97+72j
		mov	ax, seg	seg002
		mov	ds, ax
		assume ds:seg002
		mov	si, 1DEh
		xor	bl, bl
		mov	cx, 10h
		mov	cs:charDrawDelay, 2

loc_12EB7:				; CODE XREF: sub_12E97+26j
		cmp	cs:charDrawDelay, 0
		jnz	short loc_12EB7

loc_12EBF:				; CODE XREF: sub_12E97+6Bj
		mov	al, bl
		cmp	al, 7
		jnz	short loc_12ED1
		mov	ah, [bp+arg_0]
		or	ah, ah
		jnz	short loc_12ED1
		add	si, 3
		jmp	short loc_12F00
; ---------------------------------------------------------------------------

loc_12ED1:				; CODE XREF: sub_12E97+2Cj
					; sub_12E97+33j
		out	0A8h, al	; Interrupt Controller #2, 8259A
		xor	ax, ax
		lodsb
		mul	bh
		shr	al, 1
		shr	al, 1
		shr	al, 1
		shr	al, 1
		out	0AEh, al	; Interrupt Controller #2, 8259A
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
		out	0AAh, al	; Interrupt Controller #2, 8259A

loc_12F00:				; CODE XREF: sub_12E97+38j
		inc	bl
		loop	loc_12EBF
		inc	bh
		cmp	bh, [bp+arg_2]
		jbe	short loc_12EA3
		pop	si
		pop	ds
		assume ds:nothing
		pop	bp
		retn
sub_12E97	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_12F0F	proc near		; CODE XREF: mes0E+5Cp

arg_0		= byte ptr  4
arg_2		= byte ptr  6

		push	bp
		mov	bp, sp
		push	ds
		push	si
		mov	ax, 1
		out	6Ah, al
		mov	bh, [bp+arg_2]

loc_12F1C:				; CODE XREF: sub_12F0F+8Cj
		or	bh, bh
		jz	short loc_12F9E
		dec	bh
		mov	ax, seg	seg002
		mov	ds, ax
		assume ds:seg002
		mov	si, 1DEh
		xor	bl, bl
		mov	cx, 10h
		mov	cs:charDrawDelay, 2

loc_12F36:				; CODE XREF: sub_12F0F+2Dj
		cmp	cs:charDrawDelay, 0
		jnz	short loc_12F36

loc_12F3E:				; CODE XREF: sub_12F0F+8Aj
		mov	al, bl
		cmp	al, 7
		jnz	short loc_12F50
		mov	ah, [bp+arg_0]
		or	ah, ah
		jnz	short loc_12F50
		add	si, 3
		jmp	short loc_12F97
; ---------------------------------------------------------------------------

loc_12F50:				; CODE XREF: sub_12F0F+33j
					; sub_12F0F+3Aj
		out	0A8h, al	; Interrupt Controller #2, 8259A
		xor	ax, ax
		lodsb
		mov	dl, al
		mov	al, 0Fh
		sub	al, dl
		mul	bh
		shr	al, 1
		shr	al, 1
		shr	al, 1
		shr	al, 1
		add	al, dl
		out	0AEh, al	; Interrupt Controller #2, 8259A
		xor	ax, ax
		lodsb
		mov	dl, al
		mov	al, 0Fh
		sub	al, dl
		mul	bh
		shr	al, 1
		shr	al, 1
		shr	al, 1
		shr	al, 1
		add	al, dl
		out	0ACh, al	; Interrupt Controller #2, 8259A
		xor	ax, ax
		lodsb
		mov	dl, al
		mov	al, 0Fh
		sub	al, dl
		mul	bh
		shr	al, 1
		shr	al, 1
		shr	al, 1
		shr	al, 1
		add	al, dl
		out	0AAh, al	; Interrupt Controller #2, 8259A

loc_12F97:				; CODE XREF: sub_12F0F+3Fj
		inc	bl
		loop	loc_12F3E
		jmp	loc_12F1C
; ---------------------------------------------------------------------------

loc_12F9E:				; CODE XREF: sub_12F0F+Fj
		pop	si
		pop	ds
		assume ds:nothing
		pop	bp
		retn
sub_12F0F	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

SetPalette	proc near		; CODE XREF: mes0E+1Bp
					; mes29_SetPalette+8Ap

arg_0		= byte ptr  4

		push	bp
		mov	bp, sp
		mov	ax, 1
		out	6Ah, al
		mov	ax, seg	seg002
		mov	ds, ax
		assume ds:seg002
		mov	si, 1DEh
		mov	cx, 10h
		mov	bl, 0

loc_12FB7:				; CODE XREF: SetPalette+34j
		mov	al, bl
		cmp	al, 7
		jnz	short loc_12FC9
		mov	ah, [bp+arg_0]
		or	ah, ah
		jnz	short loc_12FC9
		add	si, 3
		jmp	short loc_12FD4
; ---------------------------------------------------------------------------

loc_12FC9:				; CODE XREF: SetPalette+19j
					; SetPalette+20j
		out	0A8h, al	; GDC: set palette
		lodsb
		out	0AEh, al	; GDC: set colour Blue
		lodsb
		out	0ACh, al	; GDC: set colour Red
		lodsb
		out	0AAh, al	; GDC: set colour Green

loc_12FD4:				; CODE XREF: SetPalette+25j
		inc	bl
		loop	loc_12FB7
		pop	bp
		retn
SetPalette	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_12FDA	proc near		; CODE XREF: mes0F+66p

arg_0		= byte ptr  4
arg_2		= byte ptr  6

		push	bp
		mov	bp, sp
		push	ds
		push	si
		mov	ax, 1
		out	6Ah, al
		mov	bh, [bp+arg_2]

loc_12FE7:				; CODE XREF: sub_12FDA+74j
		or	bh, bh
		jz	short loc_13050
		dec	bh
		mov	ax, seg	seg002
		mov	ds, ax
		mov	si, 1DEh
		xor	bl, bl
		mov	cx, 10h
		mov	cs:charDrawDelay, 2

loc_13001:				; CODE XREF: sub_12FDA+2Dj
		cmp	cs:charDrawDelay, 0
		jnz	short loc_13001

loc_13009:				; CODE XREF: sub_12FDA+72j
		mov	al, bl
		cmp	al, 7
		jnz	short loc_1301B
		mov	ah, [bp+arg_0]
		or	ah, ah
		jnz	short loc_1301B
		add	si, 3
		jmp	short loc_1304A
; ---------------------------------------------------------------------------

loc_1301B:				; CODE XREF: sub_12FDA+33j
					; sub_12FDA+3Aj
		out	0A8h, al	; Interrupt Controller #2, 8259A
		xor	ax, ax
		lodsb
		mul	bh
		shr	al, 1
		shr	al, 1
		shr	al, 1
		shr	al, 1
		out	0AEh, al	; Interrupt Controller #2, 8259A
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
		out	0AAh, al	; Interrupt Controller #2, 8259A

loc_1304A:				; CODE XREF: sub_12FDA+3Fj
		inc	bl
		loop	loc_13009
		jmp	short loc_12FE7
; ---------------------------------------------------------------------------

loc_13050:				; CODE XREF: sub_12FDA+Fj
		pop	si
		pop	ds
		assume ds:nothing
		pop	bp
		retn
sub_12FDA	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_13054	proc near		; CODE XREF: mes0F+50p

arg_0		= byte ptr  4
arg_2		= byte ptr  6

		push	bp
		mov	bp, sp
		push	ds
		push	si
		mov	ax, 1
		out	6Ah, al
		xor	bh, bh

loc_13060:				; CODE XREF: sub_13054+8Aj
		mov	ax, seg	seg002
		mov	ds, ax
		assume ds:seg002
		mov	si, 1DEh
		xor	bl, bl
		mov	cx, 10h
		mov	cs:charDrawDelay, 2

loc_13074:				; CODE XREF: sub_13054+26j
		cmp	cs:charDrawDelay, 0
		jnz	short loc_13074

loc_1307C:				; CODE XREF: sub_13054+83j
		mov	al, bl
		cmp	al, 7
		jnz	short loc_1308E
		mov	ah, [bp+arg_0]
		or	ah, ah
		jnz	short loc_1308E
		add	si, 3
		jmp	short loc_130D5
; ---------------------------------------------------------------------------

loc_1308E:				; CODE XREF: sub_13054+2Cj
					; sub_13054+33j
		out	0A8h, al	; Interrupt Controller #2, 8259A
		xor	ax, ax
		lodsb
		mov	dl, al
		mov	al, 0Fh
		sub	al, dl
		mul	bh
		shr	al, 1
		shr	al, 1
		shr	al, 1
		shr	al, 1
		add	al, dl
		out	0AEh, al	; Interrupt Controller #2, 8259A
		xor	ax, ax
		lodsb
		mov	dl, al
		mov	al, 0Fh
		sub	al, dl
		mul	bh
		shr	al, 1
		shr	al, 1
		shr	al, 1
		shr	al, 1
		add	al, dl
		out	0ACh, al	; Interrupt Controller #2, 8259A
		xor	ax, ax
		lodsb
		mov	dl, al
		mov	al, 0Fh
		sub	al, dl
		mul	bh
		shr	al, 1
		shr	al, 1
		shr	al, 1
		shr	al, 1
		add	al, dl
		out	0AAh, al	; Interrupt Controller #2, 8259A

loc_130D5:				; CODE XREF: sub_13054+38j
		inc	bl
		loop	loc_1307C
		inc	bh
		cmp	bh, [bp+arg_2]
		jbe	short loc_13060
		pop	si
		pop	ds
		assume ds:nothing
		pop	bp
		retn
sub_13054	endp


; =============== S U B	R O U T	I N E =======================================


sub_130E4	proc near		; CODE XREF: mes0F+2Bp
		mov	ax, 1
		out	6Ah, al
		mov	bh, 10h

loc_130EB:				; CODE XREF: sub_130E4+3Cj
		dec	bh
		xor	bl, bl
		mov	cx, 10h
		mov	cs:charDrawDelay, 2

loc_130F9:				; CODE XREF: sub_130E4+1Bj
		cmp	cs:charDrawDelay, 0
		jnz	short loc_130F9

loc_13101:				; CODE XREF: sub_130E4+38j
		mov	al, bl
		cmp	al, 7
		jz	short loc_1311A
		mov	ah, [bp+4]
		or	ah, ah
		jz	short loc_1311A
		mov	al, bl
		out	0A8h, al	; Interrupt Controller #2, 8259A
		mov	al, bh
		out	0AEh, al	; Interrupt Controller #2, 8259A
		out	0ACh, al	; Interrupt Controller #2, 8259A
		out	0AAh, al	; Interrupt Controller #2, 8259A

loc_1311A:				; CODE XREF: sub_130E4+21j
					; sub_130E4+28j
		inc	bl
		loop	loc_13101
		or	bh, bh
		jnz	short loc_130EB
		retn
sub_130E4	endp


; =============== S U B	R O U T	I N E =======================================


CallInt18Func00	proc near		; CODE XREF: mes15_WaitUser:loc_11192p
					; DoMenuSelection:loc_115BCp ...
		xor	ah, ah
		int	18h		; Keyboard/CRT BIOS
		retn
CallInt18Func00	endp


; =============== S U B	R O U T	I N E =======================================


CallInt18Func01	proc near		; CODE XREF: mes15_WaitUser:loc_11195p
					; DoMenuSelection:loc_115BFp ...
		mov	ah, 1
		int	18h		; Keyboard/CRT BIOS
		or	bh, bh
		jnz	short locret_13132
		xor	ax, ax

locret_13132:				; CODE XREF: CallInt18Func01+6j
		retn
CallInt18Func01	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_13133	proc near		; CODE XREF: PrintTextLine+9p
					; mes15_WaitUser+6p ...

arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		push	ds
		xor	ax, ax
		mov	ds, ax
		assume ds:nothing
		cmp	[bp+arg_0], 0
		jnz	short loc_13153

loc_13141:				; CODE XREF: sub_13133+13j
					; sub_13133+1Bj
		test	byte ptr ds:530h, 10h
		jnz	short loc_13141
		test	cs:byte_1368F, 2
		jz	short loc_13141
		pop	ds
		assume ds:nothing
		pop	bp
		retn
; ---------------------------------------------------------------------------

loc_13153:				; CODE XREF: sub_13133+Cj
					; sub_13133+2Dj
		test	byte ptr ds:530h, 10h
		jnz	short loc_13162
		test	cs:byte_1368F, 2
		jnz	short loc_13153

loc_13162:				; CODE XREF: sub_13133+25j
		pop	ds
		pop	bp
		retn
sub_13133	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

DoGraphicsThing	proc near		; CODE XREF: mes0B_GfxThing+F0p
					; mes0B_GfxThing+121p ...

arg_0		= dword	ptr  4
arg_4		= dword	ptr  8

		push	bp
		mov	bp, sp
		push	si
		push	di
		push	ds
		push	es
		les	di, [bp+arg_4]
		lds	si, [bp+arg_0]
		lodsw
		shr	ax, 1
		shr	ax, 1
		mov	bx, ax
		lodsw
		mov	cx, ax
		mov	ax, 50h	; 'P'
		imul	cx
		add	ax, bx
		push	ax
		lodsw
		add	ax, 3
		shr	ax, 1
		shr	ax, 1
		sub	ax, bx
		inc	ax
		mov	bx, ax
		lodsw
		sub	ax, cx
		inc	ax
		mov	cx, ax
		pop	si
		xchg	bx, cx
		mov	dx, cx
		mov	ax, si
		stosw
		mov	ax, cx
		stosw
		mov	ax, bx
		stosw

loc_131A5:				; CODE XREF: DoGraphicsThing+5Bj
					; DoGraphicsThing+65j
		mov	ax, 0A800h
		mov	ds, ax
		assume ds:nothing
		movsb
		dec	si
		mov	ax, 0B000h
		mov	ds, ax
		assume ds:nothing
		movsb
		dec	si
		mov	ax, 0B800h
		mov	ds, ax
		assume ds:nothing
		movsb
		dec	si
		mov	ax, 0E000h
		mov	ds, ax
		assume ds:nothing
		movsb
		loop	loc_131A5
		mov	cx, dx
		add	si, 50h	; 'P'
		sub	si, cx
		dec	bx
		jnz	short loc_131A5
		pop	es
		pop	ds
		assume ds:nothing
		pop	di
		pop	si
		pop	bp
		retn
DoGraphicsThing	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_131D2	proc near		; CODE XREF: seg000:00BEp
					; mes0B_GfxThing+106p ...

arg_0		= dword	ptr  4

		push	bp
		mov	bp, sp
		push	ds
		push	es
		push	si
		push	di
		lds	si, [bp+arg_0]
		lodsw
		mov	di, ax
		lodsw
		mov	dx, ax
		lodsw
		mov	bx, ax
		mov	cx, dx
		mov	al, 80h	; '€'
		out	7Ch, al
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing

loc_131F0:				; CODE XREF: sub_131D2+2Bj
					; sub_131D2+35j
		lodsb
		out	7Eh, al
		lodsb
		out	7Eh, al
		lodsb
		out	7Eh, al
		lodsb
		out	7Eh, al
		stosb
		loop	loc_131F0
		mov	cx, dx
		add	di, 50h	; 'P'
		sub	di, cx
		dec	bx
		jnz	short loc_131F0
		xor	ax, ax
		out	7Ch, al
		pop	di
		pop	si
		pop	es
		assume es:nothing
		pop	ds
		pop	bp
		retn
sub_131D2	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_13213	proc near		; CODE XREF: mes24_GfxPosOffset+24p

arg_0		= word ptr  4
arg_2		= word ptr  6

		push	bp
		mov	bp, sp
		mov	ax, [bp+arg_0]
		mov	cs:word_13663, ax
		mov	ax, [bp+arg_2]
		mov	cs:word_13665, ax
		pop	bp
		retn
sub_13213	endp


; =============== S U B	R O U T	I N E =======================================


sub_13226	proc near		; CODE XREF: mes25+3p
		cmp	cs:word_13667, 0
		jnz	short locret_1323D
		cmp	cs:word_13669, 0
		jz	short locret_1323D
		mov	cs:word_13667, 1

locret_1323D:				; CODE XREF: sub_13226+6j sub_13226+Ej
		retn
sub_13226	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1323E	proc near		; CODE XREF: mes26+3p
		push	bp
		mov	bp, sp
		mov	cs:word_13667, 0
		pop	bp
		retn
sub_1323E	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1324A	proc near		; CODE XREF: mes0B_GfxThing+B2p
					; mes0B_GfxThing+160p ...

arg_0		= dword	ptr  4

		push	bp
		mov	bp, sp
		cmp	cs:word_13667, 0
		jz	short loc_132BA
		push	ds
		push	es
		push	si
		push	di
		lds	si, [bp+arg_0]
		add	si, 2
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		mov	bx, cs:word_1365F
		add	bx, cs:word_13663
		mov	ax, cs:word_13661
		add	ax, cs:word_13665
		mov	bp, ax
		mov	cx, 50h	; 'P'
		imul	cx
		add	ax, bx
		mov	di, ax
		xchg	bx, bp
		lodsw
		mov	cx, ax
		mov	dx, ax
		mov	al, 0C0h ; 'À'
		out	7Ch, al
		lodsw
		jmp	short loc_132BC
; ---------------------------------------------------------------------------

loc_13290:				; CODE XREF: sub_1324A+87j
					; sub_1324A+8Ej
		add	si, 4
		inc	di
		inc	bp
		loop	loc_132CC
		jmp	short loc_132A5
; ---------------------------------------------------------------------------

loc_13299:				; CODE XREF: sub_1324A+79j
					; sub_1324A+80j
		xor	ax, ax
		mov	al, dl
		add	di, ax
		add	ax, ax
		add	ax, ax
		add	si, ax

loc_132A5:				; CODE XREF: sub_1324A+4Dj
					; sub_1324A+ACj
		mov	cl, dl
		add	di, 50h	; 'P'
		sub	di, cx
		inc	bx
		pop	bp
		pop	ax
		dec	ax
		jnz	short loc_132BC
		xor	ax, ax
		out	7Ch, al
		pop	di
		pop	si
		pop	es
		assume es:nothing
		pop	ds

loc_132BA:				; CODE XREF: sub_1324A+9j
		pop	bp
		retn
; ---------------------------------------------------------------------------

loc_132BC:				; CODE XREF: sub_1324A+44j
					; sub_1324A+66j
		push	ax
		push	bp
		cmp	bx, cs:word_1366D
		jl	short loc_13299
		cmp	bx, cs:word_13671
		jg	short loc_13299

loc_132CC:				; CODE XREF: sub_1324A+4Bj
					; sub_1324A+AAj
		cmp	bp, cs:word_1366B
		jl	short loc_13290
		cmp	bp, cs:word_1366F
		jg	short loc_13290
		lodsb
		out	7Eh, al
		mov	ah, al
		lodsb
		out	7Eh, al
		and	ah, al
		lodsb
		out	7Eh, al
		and	ah, al
		lodsb
		out	7Eh, al
		not	al
		and	al, ah
		not	al
		stosb
		inc	bp
		loop	loc_132CC
		jmp	short loc_132A5
sub_1324A	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_132F8	proc near		; CODE XREF: mes1A_DoSelect+185p

arg_0		= dword	ptr  4

		push	bp
		mov	bp, sp
		push	si
		push	di
		push	ds
		push	es
		lds	si, [bp+arg_0]
		lodsw
		shr	ax, 1
		shr	ax, 1
		mov	bx, ax
		lodsw
		mov	cx, ax
		mov	ax, 50h	; 'P'
		imul	cx
		add	ax, bx
		mov	di, ax
		lodsw
		add	ax, 3
		shr	ax, 1
		shr	ax, 1
		sub	ax, bx
		inc	ax
		mov	bx, ax
		lodsw
		sub	ax, cx
		inc	ax
		mov	cx, ax
		xchg	bx, cx
		sub	bx, 10h
		jns	short loc_13332
		jmp	loc_13445
; ---------------------------------------------------------------------------

loc_13332:				; CODE XREF: sub_132F8+35j
		mov	dx, cx
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		call	sub_1344B
		mov	cx, dx
		sub	di, cx
		mov	ax, 0B000h
		mov	es, ax
		assume es:nothing
		call	sub_1344B
		mov	cx, dx
		sub	di, cx
		mov	ax, 0B800h
		mov	es, ax
		assume es:nothing
		call	sub_1344B
		mov	cx, dx
		sub	di, cx
		mov	ax, 0E000h
		mov	es, ax
		assume es:nothing
		call	sub_1344B
		mov	cx, dx
		sub	di, cx
		add	di, 50h	; 'P'
		mov	si, 7

loc_1336A:				; CODE XREF: sub_132F8+A6j
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		call	sub_1345F
		mov	cx, dx
		sub	di, cx
		mov	ax, 0B000h
		mov	es, ax
		assume es:nothing
		call	sub_1345F
		mov	cx, dx
		sub	di, cx
		mov	ax, 0B800h
		mov	es, ax
		assume es:nothing
		call	sub_1345F
		mov	cx, dx
		sub	di, cx
		mov	ax, 0E000h
		mov	es, ax
		assume es:nothing
		call	sub_1345F
		mov	cx, dx
		sub	di, cx
		add	di, 50h	; 'P'
		dec	si
		jnz	short loc_1336A

loc_133A0:				; CODE XREF: sub_132F8+DDj
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		call	sub_13475
		mov	cx, dx
		sub	di, cx
		mov	ax, 0B000h
		mov	es, ax
		assume es:nothing
		call	sub_13475
		mov	cx, dx
		sub	di, cx
		mov	ax, 0B800h
		mov	es, ax
		assume es:nothing
		call	sub_13475
		mov	cx, dx
		sub	di, cx
		mov	ax, 0E000h
		mov	es, ax
		assume es:nothing
		call	sub_13475
		mov	cx, dx
		sub	di, cx
		add	di, 50h	; 'P'
		inc	si
		dec	bx
		jnz	short loc_133A0
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		call	sub_13495
		mov	cx, dx
		sub	di, cx
		mov	ax, 0B000h
		mov	es, ax
		assume es:nothing
		call	sub_13495
		mov	cx, dx
		sub	di, cx
		mov	ax, 0B800h
		mov	es, ax
		assume es:nothing
		call	sub_13495
		mov	cx, dx
		sub	di, cx
		mov	ax, 0E000h
		mov	es, ax
		assume es:nothing
		call	sub_13495
		mov	cx, dx
		sub	di, cx
		add	di, 50h	; 'P'
		inc	si
		mov	bx, 7

loc_1340E:				; CODE XREF: sub_132F8+14Bj
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		call	sub_134B3
		mov	cx, dx
		sub	di, cx
		mov	ax, 0B000h
		mov	es, ax
		assume es:nothing
		call	sub_134B3
		mov	cx, dx
		sub	di, cx
		mov	ax, 0B800h
		mov	es, ax
		assume es:nothing
		call	sub_134B3
		mov	cx, dx
		sub	di, cx
		mov	ax, 0E000h
		mov	es, ax
		assume es:nothing
		call	sub_134B3
		mov	cx, dx
		sub	di, cx
		add	di, 50h	; 'P'
		inc	si
		dec	bx
		jnz	short loc_1340E

loc_13445:				; CODE XREF: sub_132F8+37j
		pop	es
		assume es:nothing
		pop	ds
		pop	di
		pop	si
		pop	bp
		retn
sub_132F8	endp


; =============== S U B	R O U T	I N E =======================================


sub_1344B	proc near		; CODE XREF: sub_132F8+41p
					; sub_132F8+4Dp ...
		mov	al, es:[di]
		and	al, 0FCh
		stosb
		sub	cx, 2
		xor	ax, ax
		rep stosb
		mov	al, es:[di]
		and	al, 7Fh
		stosb
		retn
sub_1344B	endp


; =============== S U B	R O U T	I N E =======================================


sub_1345F	proc near		; CODE XREF: sub_132F8+77p
					; sub_132F8+83p ...
		mov	al, es:[di]
		and	al, 0FCh
		or	al, 1
		stosb
		sub	cx, 2
		mov	al, 0FFh
		rep stosb
		mov	al, es:[di]
		and	al, 7Fh
		stosb
		retn
sub_1345F	endp


; =============== S U B	R O U T	I N E =======================================


sub_13475	proc near		; CODE XREF: sub_132F8+ADp
					; sub_132F8+B9p ...
		mov	al, es:[di]
		and	al, 0FCh
		or	al, 1
		stosb
		sub	cx, 2
		mov	al, 0FFh
		rep stosb
		mov	al, es:[di]
		mov	ah, 55h	; 'U'
		test	si, 1
		jz	short loc_13491
		mov	ah, 2Ah	; '*'

loc_13491:				; CODE XREF: sub_13475+18j
		and	al, ah
		stosb
		retn
sub_13475	endp


; =============== S U B	R O U T	I N E =======================================


sub_13495	proc near		; CODE XREF: sub_132F8+E4p
					; sub_132F8+F0p ...
		mov	al, es:[di]
		and	al, 0FCh
		stosb
		sub	cx, 2
		xor	ax, ax
		rep stosb
		mov	al, es:[di]
		mov	ah, 55h	; 'U'
		test	si, 1
		jz	short loc_134AF
		mov	ah, 2Ah	; '*'

loc_134AF:				; CODE XREF: sub_13495+16j
		and	al, ah
		stosb
		retn
sub_13495	endp


; =============== S U B	R O U T	I N E =======================================


sub_134B3	proc near		; CODE XREF: sub_132F8+11Bp
					; sub_132F8+127p ...
		inc	di
		mov	al, es:[di]
		mov	ah, 0FFh
		test	si, 1
		jz	short loc_134C1
		mov	ah, 0FEh ; 'þ'

loc_134C1:				; CODE XREF: sub_134B3+Aj
		stosb
		sub	cx, 2

loc_134C5:				; CODE XREF: sub_134B3+22j
		mov	al, es:[di]
		mov	ah, 55h	; 'U'
		test	si, 1
		jz	short loc_134D2
		mov	ah, 0AAh ; 'ª'

loc_134D2:				; CODE XREF: sub_134B3+1Bj
		and	al, ah
		stosb
		loop	loc_134C5
		retn
sub_134B3	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

SetAnimationMode proc near		; CODE XREF: mes2B_SetAniMode+Cp

arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		mov	ax, [bp+arg_0]
		mov	cs:AnimationMode, ax
		pop	bp
		retn
SetAnimationMode endp


; =============== S U B	R O U T	I N E =======================================


sub_134E4	proc near		; CODE XREF: mes1A_DoSelect+305p
					; mes2C+3p ...
		mov	cs:word_13689, 1
		retn
sub_134E4	endp


; =============== S U B	R O U T	I N E =======================================


sub_134EC	proc near		; CODE XREF: mes0B_GfxThing+8p
					; mes0C_GfxThing+6p ...
		push	si
		push	ds
		push	es
		mov	ax, seg	seg003
		mov	ds, ax
		assume ds:seg003
		cmp	cs:word_13689, 0
		jz	short loc_13573
		mov	cs:word_13689, 0
		mov	ax, cs:word_13685

loc_13507:				; CODE XREF: sub_134EC+20j
		cmp	ax, cs:word_13687
		jnz	short loc_13507
		mov	cs:byte_136A5, 0
		xor	si, si

loc_13516:				; CODE XREF: sub_134EC+6Bj
		cmp	si, word_16AD2
		jnb	short loc_13559
		mov	al, cs:[si+6AC2h]
		cmp	al, byte ptr word_16A8E
		jnb	short loc_13545
		xor	ah, ah
		add	ax, ax
		add	ax, ax
		mov	bx, 0Eh
		add	bx, ax
		mov	ax, [bx]
		mov	dx, [bx+2]
		mov	bx, ax
		or	bx, dx
		jz	short loc_13545
		push	dx
		push	ax
		call	sub_131D2
		add	sp, 4

loc_13545:				; CODE XREF: sub_134EC+39j
					; sub_134EC+4Fj
		mov	byte ptr [si+682h], 0FFh
		mov	ah, [si+652h]
		and	ah, 2
		or	cs:byte_136A5, ah
		inc	si
		jmp	short loc_13516
; ---------------------------------------------------------------------------

loc_13559:				; CODE XREF: sub_134EC+2Ej
		cmp	cs:byte_136A5, 0
		jz	short loc_13573
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		mov	bx, offset dword_15EFA
		les	bx, [bx]
		push	es
		push	bx
		call	sub_1324A
		add	sp, 4

loc_13573:				; CODE XREF: sub_134EC+Ej
					; sub_134EC+73j
		pop	es
		pop	ds
		assume ds:nothing
		pop	si
		retn
sub_134EC	endp


; =============== S U B	R O U T	I N E =======================================


sub_13577	proc near		; CODE XREF: mes2E+6p sub_13577+6j
		cmp	word ptr cs:6A90h, 0FFFFh
		jnz	short sub_13577
		retn
sub_13577	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_13580	proc near		; CODE XREF: sub_100C8+72p

arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		mov	ax, [bp+arg_0]
		pushf
		cli
		mov	cs:byte_136A8, al
		popf

loc_1358D:				; CODE XREF: sub_13580+12j
		cmp	cs:byte_136A8, al
		jz	short loc_1358D
		pop	bp
		retn
sub_13580	endp


; =============== S U B	R O U T	I N E =======================================


LoadCustomFont	proc near		; CODE XREF: InitGame+71p
		push	si
		push	di
		push	ds
		push	es
		mov	ax, cs
		mov	ds, ax
		assume ds:seg000
		mov	si, offset FontData
		; At first, fill text VRAM with	predefined data.
		mov	ax, 0A100h	; 0A0000h..0A1FFFh: text VRAM -	character data
		mov	es, ax
		assume es:nothing
		xor	cx, cx
		mov	di, 40h		; destination offset: 0A1040h

loc_135AB:				; CODE XREF: LoadCustomFont+36j
					; LoadCustomFont+3Cj ...
		lodsw
		cmp	ax, 0FFFFh
		jz	short loc_135E5	; 0FFFFh - exit
		mov	bx, ax
		and	ah, 7Fh
		jz	short loc_135D4	; 00xx/80xx - jump
		cmp	al, 0Bh
		jz	short loc_135D4	; xx0B - jump
		test	bh, 80h
		jz	short loc_135CE	; 0000..7FFF - jump (store single byte once)
		lodsb			; get number of	times to repeat
		mov	cl, al

loc_135C4:				; CODE XREF: LoadCustomFont+34j
		mov	al, bl
		stosw			; store	00h+xx
		or	al, 80h
		stosw			; store	80h+xx
		loop	loc_135C4	; do it	CL times
		jmp	short loc_135AB
; ---------------------------------------------------------------------------

loc_135CE:				; CODE XREF: LoadCustomFont+29j
		stosw			; store	00h+xx
		or	al, 80h
		stosw			; store	80h+xx
		jmp	short loc_135AB	; and do it only once
; ---------------------------------------------------------------------------

loc_135D4:				; CODE XREF: LoadCustomFont+20j
					; LoadCustomFont+24j
		test	bh, 80h
		jz	short loc_135E2	; 0000..7FFF - jump (store one word once)
		lodsb			; get number of	times to repeat
		mov	cl, al
		mov	al, bl
		rep stosw		; store	word CL	times
		jmp	short loc_135AB
; ---------------------------------------------------------------------------

loc_135E2:				; CODE XREF: LoadCustomFont+41j
		stosw
		jmp	short loc_135AB
; ---------------------------------------------------------------------------

loc_135E5:				; CODE XREF: LoadCustomFont+19j
		mov	ax, 0A300h	; 0A2000h..0A3FFFh: text VRAM -	attribute data
		mov	es, ax
		assume es:nothing
		mov	di, 40h		; destination offset: 0A3040h

loc_135ED:				; CODE XREF: LoadCustomFont+62j
		lodsw			; low byte = data, high	byte = number of repetitions
		cmp	al, 0FFh
		jz	short loc_135FA	; data == 0FFh -> stop
		mov	cl, ah

loc_135F4:				; CODE XREF: LoadCustomFont+60j
		stosb
		inc	di		; skip 1 byte
		loop	loc_135F4
		jmp	short loc_135ED
; ---------------------------------------------------------------------------
		; Then load the	actual custom font data.

loc_135FA:				; CODE XREF: LoadCustomFont+5Aj
		mov	al, 0Ch
		out	62h, al
		mov	al, 0Bh
		out	68h, al

loc_13602:				; CODE XREF: LoadCustomFont+94j
		lodsw			; read JIS character number
		cmp	ax, 0FFFFh
		jz	short loc_1362C	; 0FFFFh - stop
		sub	ax, 2000h
		out	0A1h, al	; set font glyph ID, part 1
		mov	al, ah
		out	0A3h, al	; set font glyph ID, part 1
		xor	bx, bx
		mov	cx, 10h		; copy 10h words (20h bytes)

loc_13616:				; CODE XREF: LoadCustomFont+92j
		mov	al, bl
		or	al, 20h
		out	0A5h, al	; select 1st byte of the glyph data
		lodsw
		out	0A9h, al	; write	1st byte of the	font glyph
		mov	al, bl
		out	0A5h, al	; select 2nd byte of the glyph data
		mov	al, ah
		out	0A9h, al	; write	2nd byte of the	font glyph
		inc	bx
		loop	loc_13616
		jmp	short loc_13602
; ---------------------------------------------------------------------------

loc_1362C:				; CODE XREF: LoadCustomFont+70j
		mov	al, 0Ah
		out	68h, al
		mov	al, 0Dh
		out	62h, al
		pop	es
		assume es:nothing
		pop	ds
		assume ds:nothing
		pop	di
		pop	si
		retn
LoadCustomFont	endp

; ---------------------------------------------------------------------------
BakIntVec0A	dd 0			; DATA XREF: SetupInterrupts+2Dw
					; sub_12DD5+17r ...
BakIntVec18	dd 0			; DATA XREF: SetupInterrupts+42w
					; seg000:2BDBr	...
BakIntVec06	dd 0			; DATA XREF: SetupInterrupts+57w
					; sub_12DD5+2Br ...
BakIntVec00	dd 0			; DATA XREF: SetupInterrupts+70w
					; seg000:2C84r	...
BakIntVec15	dd 0			; DATA XREF: SetupInterrupts+95w
					; sub_12DD5+4Fr ...
word_1364D	dw 13Fh			; DATA XREF: seg000:2CCBr
					; seg000:loc_12CDDr ...
word_1364F	dw 0C7h			; DATA XREF: seg000:2D22r
					; seg000:loc_12D34r ...
word_13651	dw 0			; DATA XREF: seg000:2CE2r seg000:2CE9r ...
word_13653	dw 0			; DATA XREF: seg000:2D39r seg000:2D40r ...
word_13655	dw 27Fh			; DATA XREF: seg000:2CD0r seg000:2CD7r ...
word_13657	dw 18Fh			; DATA XREF: seg000:2D27r seg000:2D2Er ...
word_13659	dw 0			; DATA XREF: seg000:loc_12C00w
					; sub_12E5B+13r
word_1365B	dw 0			; DATA XREF: seg000:loc_12C0Aw
					; seg000:2C32r	...
word_1365D	dw 0			; DATA XREF: SetupInterrupts+Dw
					; sub_12E5B+1Br
word_1365F	dw 0			; DATA XREF: mes23_SetEraseType+60w
					; mes23_SetEraseType+85r ...
word_13661	dw 0			; DATA XREF: mes23_SetEraseType+6Fw
					; mes23_SetEraseType+96r ...
word_13663	dw 0			; DATA XREF: sub_13213+6w
					; sub_1324A+1Fr
word_13665	dw 0			; DATA XREF: sub_13213+Dw
					; sub_1324A+28r
word_13667	dw 0			; DATA XREF: sub_13226r sub_13226+10w	...
word_13669	dw 1			; DATA XREF: seg000:2BF7w sub_13226+8r
word_1366B	dw 0			; DATA XREF: sub_124C9+6w
					; sub_1324A:loc_132CCr
word_1366D	dw 0			; DATA XREF: sub_124C9+Ew
					; sub_1324A+74r
word_1366F	dw 0			; DATA XREF: sub_124C9+21w
					; sub_1324A+89r
word_13671	dw 0			; DATA XREF: sub_124C9+2Fw
					; sub_1324A+7Br
word_13673	dw 0			; DATA XREF: sub_1246E+3r
					; sub_124C9+1Aw
word_13675	dw 1			; DATA XREF: sub_1246E+18r
					; sub_124C9+36w
word_13677	dw 0			; DATA XREF: sub_1246E+13r
					; sub_124C9+28w
word_13679	dw 0			; DATA XREF: sub_1246E+8r
					; sub_12505:loc_1250Bw
txt_tramOfs	dw 0			; DATA XREF: SetTextBoxData+22w
					; ClearTextVRAM+3r ...
word_1367D	dw 19h			; DATA XREF: SetTextBoxData+40w
					; ClearTextVRAM+Dr ...
txt_tramLineOfs	dw 50h			; DATA XREF: SetTextBoxData+30w
					; ClearTextVRAM+8r ...
charDrawDelay	dw 0			; DATA XREF: seg000:2879r seg000:2881w ...
word_13683	dw 14h			; DATA XREF: DoTextWait+1Er
					; SetupInterrupts+6w ...
word_13685	dw 0			; DATA XREF: seg000:2839r
					; seg000:loc_12975w ...
word_13687	dw 0FFFFh		; DATA XREF: seg000:283Er seg000:285Bw ...
word_13689	dw 0			; DATA XREF: seg000:loc_12929r
					; sub_134E4w ...
word_1368B	dw 6			; DATA XREF: seg000:loc_128A2r
					; seg000:28AAw	...
AnimationMode	dw 1			; DATA XREF: seg000:299Fr
					; SetAnimationMode+6w
byte_1368F	db 3			; DATA XREF: seg000:loc_12886r
					; seg000:2D57w	...
aComspec	db 'COMSPEC'
byte_13697	db 0			; DATA XREF: PrintTextChar+A1w
					; PrintTextChar+10Dr
txt_chrID	db 0			; DATA XREF: PrintTextChar+3Ew
					; PrintTextChar+B3r ...
txt_lineID	db 0			; DATA XREF: PrintTextChar+Er
					; PrintTextChar:loc_12532w ...
txt_sjis_p1	db 0			; DATA XREF: PrintTextChar+28w
					; PrintTextChar:loc_1253Fw ...
byte_1369B	db 0			; DATA XREF: PrintTextChar+F4r
					; SetTextGFXAddr+6w
txt_chrCount	db 0			; DATA XREF: PrintTextChar+3Ar
					; PrintTextChar:loc_125D6r ...
byte_1369D	db 0			; DATA XREF: SetTextBoxData+Ew
					; GetTextBoxData+2Fr ...
txt_chrMax	db 0			; DATA XREF: PrintTextChar+B8r
					; SetTextBoxData+29w ...
txt_lineMax	db 0			; DATA XREF: PrintTextChar+15r
					; PrintTextChar+D6r ...
ScrollMode	db 0			; DATA XREF: mes2F_SetScrollMode+Dw
					; DoTextWait+8r
byte_136A1	db 0			; DATA XREF: DoTextWait+10w
					; DoTextWait:loc_1276Dr ...
byte_136A2	db 0			; DATA XREF: seg000:loc_128AFr
					; seg000:Int00w ...
byte_136A3	db 0			; DATA XREF: seg000:28B7r
					; seg000:loc_128C2w ...
byte_136A4	db 0			; DATA XREF: seg000:28C9w
					; seg000:loc_12957r ...
byte_136A5	db 0			; DATA XREF: sub_134EC+22w
					; sub_134EC+65w ...
byte_136A6	db 0			; DATA XREF: seg000:294Fw seg000:2982w ...
byte_136A7	db 0			; DATA XREF: seg000:loc_1289Cw
					; seg000:2947r	...
byte_136A8	db 0FFh			; DATA XREF: seg000:28DAr
					; seg000:loc_12923w ...
FontData	db  0Ch, 25h, 0Bh, 24h,	0Ch, 25h, 0Bh, 24h, 0Ch, 25h, 0Bh
					; DATA XREF: LoadCustomFont+8o
		db  24h, 0Ch, 25h, 0Bh,	24h, 0Ch, 25h, 0Bh, 24h, 0Ch, 25h
		db  0Bh, 24h, 0Ch, 25h,	0Bh, 24h, 0Ch, 25h, 0Bh, 24h, 0Ch
		db  25h, 0Bh, 24h, 0Ch,	25h, 0Bh, 24h, 0Ch, 25h, 0Bh, 24h
		db  0Ch, 25h, 0Bh, 24h,	0Ch, 25h, 0Bh, 24h, 0Ch, 25h, 0Bh
		db  24h, 0Ch, 25h, 0Bh,	24h, 0Ch, 25h, 0Bh, 24h, 0Ch, 25h
		db  0Bh, 24h, 0Ch, 25h,	0Bh, 24h, 0Ch, 25h, 0Bh, 24h, 0Ch
		db  25h, 0Bh, 24h, 0Ch,	25h, 0Bh, 24h, 0Ch, 25h, 0Bh, 24h
		db  0Ch, 25h, 0Bh, 24h,	84h, 80h, 02h, 0Bh, 24h, 0Bh, 36h
		db  57h, 7Bh, 20h, 80h,	08h, 57h, 7Dh, 20h, 00h, 57h, 79h
		db  20h, 00h, 03h, 48h,	20h, 00h, 04h, 48h, 20h, 00h, 01h
		db  7Dh, 20h, 00h, 57h,	7Dh, 20h, 00h, 03h, 32h, 20h, 00h
		db  2Bh, 76h, 20h, 00h,	04h, 62h, 20h, 00h, 04h, 28h, 20h
		db  00h, 04h, 2Ch, 20h,	00h, 04h, 4Eh, 20h, 00h, 04h, 4Ah
		db  20h, 00h, 01h, 7Dh,	20h, 00h, 2Eh, 49h, 20h, 00h, 03h
		db  32h, 20h, 00h, 05h,	2Bh, 20h, 00h, 01h, 7Dh, 20h, 00h
		db  04h, 46h, 20h, 00h,	04h, 6Bh, 20h, 00h, 05h, 33h, 20h
		db  00h, 04h, 6Ah, 20h,	00h, 01h, 7Dh, 20h, 00h, 0Bh, 27h
		db  04h, 22h, 20h, 80h,	0Bh, 57h, 7Bh, 20h, 00h, 03h, 41h
		db  20h, 00h, 04h, 37h,	20h, 00h, 04h, 5Eh, 20h, 80h, 04h
		db  1Ah, 6Eh, 20h, 00h,	04h, 4Bh, 20h, 00h, 04h, 43h, 20h
		db  00h, 04h, 4Ah, 20h,	00h, 04h, 48h, 20h, 00h, 05h, 3Dh
		db  20h, 00h, 01h, 26h,	20h, 00h, 04h, 37h, 20h, 00h, 04h
		db  2Fh, 20h, 00h, 57h,	7Ch, 20h, 00h, 17h, 6Eh, 20h, 00h
		db  04h, 24h, 20h, 00h,	04h, 68h, 20h, 00h, 04h, 48h, 20h
		db  00h, 05h, 54h, 20h,	00h, 04h, 2Ch, 20h, 00h, 04h, 64h
		db  20h, 00h, 0Bh, 27h,	04h, 64h, 20h, 80h, 0Bh, 16h, 62h
		db  20h, 00h, 03h, 52h,	20h, 00h, 04h, 46h, 20h, 00h, 04h
		db  22h, 20h, 80h, 04h,	2Ch, 5Ch, 20h, 00h, 04h, 47h, 20h
		db  00h, 04h, 48h, 20h,	00h, 04h, 24h, 20h, 00h, 04h, 6Ch
		db  20h, 00h, 05h, 55h,	20h, 00h, 01h, 26h, 20h, 00h, 04h
		db  2Bh, 20h, 00h, 04h,	46h, 20h, 00h, 04h, 2Bh, 20h, 00h
		db  04h, 62h, 20h, 00h,	04h, 64h, 20h, 00h, 20h, 00h, 01h
		db  2Ch, 20h, 00h, 01h,	2Eh, 01h, 43h, 20h, 00h, 04h, 48h
		db  20h, 00h, 04h, 22h,	20h, 00h, 0Bh, 27h, 04h, 68h, 20h
		db  80h, 0Bh, 2Ah, 56h,	20h, 00h, 03h, 44h, 20h, 80h, 02h
		db  01h, 2Eh, 20h, 00h,	01h, 2Eh, 20h, 80h, 03h, 04h, 2Bh
		db  20h, 00h, 04h, 46h,	20h, 00h, 1Eh, 65h, 20h, 00h, 04h
		db  2Ch, 20h, 00h, 04h,	46h, 20h, 00h, 05h, 48h, 20h, 00h
		db  01h, 26h, 20h, 00h,	04h, 37h, 20h, 00h, 20h, 00h, 01h
		db  2Ch, 04h, 69h, 20h,	00h, 04h, 2Bh, 20h, 00h, 04h, 22h
		db  20h, 00h, 04h, 4Dh,	20h, 00h, 18h, 65h, 20h, 00h, 05h
		db  66h, 20h, 00h, 04h,	26h, 20h, 00h, 04h, 43h, 20h, 00h
		db  0Bh, 27h, 03h, 33h,	20h, 80h, 0Bh, 04h, 3Bh, 20h, 00h
		db  26h, 62h, 20h, 00h,	04h, 34h, 20h, 00h, 04h, 3Dh, 20h
		db  80h, 04h, 04h, 69h,	20h, 00h, 04h, 6Ch, 20h, 00h, 1Ch
		db  6Ah, 20h, 80h, 02h,	01h, 2Eh, 04h, 24h, 20h, 00h, 05h
		db  4Fh, 20h, 00h, 04h,	4Ah, 20h, 80h, 02h, 01h, 2Eh, 57h
		db  7Dh, 20h, 00h, 23h,	7Ah, 20h, 00h, 04h, 2Bh, 20h, 80h
		db  02h, 01h, 2Eh, 01h,	2Ah, 20h, 00h, 04h, 47h, 20h, 00h
		db  01h, 43h, 20h, 80h,	02h, 01h, 2Ch, 01h, 2Ah, 20h, 00h
		db  0Bh, 27h, 01h, 26h,	20h, 80h, 0Bh, 57h, 7Ch, 20h, 00h
		db  57h, 7Bh, 20h, 00h,	10h, 55h, 20h, 00h, 04h, 6Ch, 20h
		db  80h, 04h, 04h, 37h,	20h, 00h, 04h, 50h, 20h, 00h, 04h
		db  2Fh, 20h, 00h, 57h,	7Ah, 20h, 00h, 04h, 6Bh, 20h, 00h
		db  05h, 26h, 20h, 00h,	04h, 73h, 20h, 00h, 04h, 5Eh, 20h
		db  80h, 04h, 25h, 59h,	20h, 00h, 04h, 43h, 20h, 00h, 04h
		db  5Eh, 20h, 00h, 57h,	7Dh, 20h, 00h, 04h, 33h, 20h, 00h
		db  05h, 36h, 20h, 00h,	57h, 7Dh, 20h, 00h, 04h, 5Fh, 20h
		db  00h, 0Bh, 27h, 03h,	54h, 20h, 80h, 0Bh, 04h, 48h, 20h
		db  00h, 04h, 22h, 20h,	00h, 18h, 2Bh, 20h, 00h, 04h, 4Fh
		db  20h, 80h, 04h, 04h,	46h, 20h, 00h, 04h, 4Ah, 20h, 00h
		db  04h, 4Ah, 20h, 00h,	04h, 22h, 20h, 00h, 04h, 48h, 20h
		db  00h, 05h, 39h, 20h,	00h, 04h, 2Bh, 20h, 00h, 04h, 24h
		db  20h, 80h, 04h, 03h,	31h, 20h, 00h, 04h, 41h, 20h, 00h
		db  04h, 24h, 20h, 80h,	04h, 04h, 5Eh, 20h, 00h, 01h, 43h
		db  20h, 80h, 04h, 04h,	73h, 20h, 00h, 0Bh, 27h, 03h, 58h
		db  20h, 80h, 0Bh, 18h,	40h, 20h, 00h, 04h, 64h, 20h, 00h
		db  01h, 26h, 20h, 00h,	14h, 68h, 20h, 80h, 04h, 04h, 33h
		db  20h, 00h, 04h, 22h,	20h, 00h, 04h, 6Ah, 20h, 00h, 04h
		db  73h, 20h, 00h, 04h,	24h, 20h, 00h, 04h, 4Fh, 20h, 00h
		db  1Ah, 47h, 20h, 00h,	04h, 43h, 20h, 80h, 04h, 27h, 2Fh
		db  20h, 00h, 04h, 63h,	20h, 00h, 04h, 43h, 20h, 80h, 04h
		db  04h, 6Bh, 20h, 00h,	04h, 4Eh, 20h, 80h, 04h, 04h, 4Ah
		db  20h, 00h, 0Bh, 27h,	03h, 54h, 20h, 00h, 29h, 34h, 20h
		db  80h, 08h, 04h, 26h,	20h, 00h, 04h, 68h, 20h, 00h, 04h
		db  34h, 20h, 00h, 24h,	25h, 20h, 80h, 04h, 04h, 6Ch, 20h
		db  00h, 01h, 26h, 20h,	00h, 04h, 3Fh, 20h, 00h, 04h, 4Ah
		db  20h, 00h, 04h, 26h,	20h, 00h, 13h, 28h, 20h, 00h, 16h
		db  61h, 20h, 00h, 04h,	3Fh, 20h, 80h, 05h, 01h, 2Ch, 04h
		db  43h, 20h, 00h, 04h,	3Fh, 20h, 80h, 04h, 04h, 3Eh, 20h
		db  00h, 04h, 2Dh, 20h,	80h, 04h, 01h, 2Ah, 20h, 00h, 0Bh
		db  27h, 57h, 7Ch, 20h,	80h, 0Bh, 04h, 2Ah, 20h, 00h, 04h
		db  35h, 20h, 00h, 14h,	75h, 20h, 00h, 04h, 43h, 20h, 80h
		db  04h, 04h, 38h, 20h,	00h, 01h, 26h, 20h, 00h, 04h, 24h
		db  20h, 00h, 04h, 4Bh,	20h, 00h, 2Ch, 75h, 20h, 00h, 04h
		db  2Ch, 20h, 00h, 05h,	39h, 20h, 00h, 04h, 4Eh, 20h, 80h
		db  04h, 04h, 24h, 20h,	00h, 04h, 3Fh, 20h, 00h, 04h, 5Eh
		db  20h, 80h, 04h, 04h,	43h, 20h, 00h, 04h, 5Fh, 20h, 80h
		db  04h, 04h, 22h, 20h,	00h, 0Bh, 27h, 20h, 80h, 03h, 22h
		db  40h, 20h, 80h, 08h,	2Ah, 58h, 20h, 00h, 04h, 73h, 20h
		db  00h, 2Bh, 3Eh, 20h,	00h, 04h, 46h, 20h, 80h, 04h, 04h
		db  63h, 20h, 00h, 01h,	26h, 20h, 00h, 01h, 26h, 20h, 00h
		db  14h, 68h, 20h, 00h,	04h, 47h, 20h, 00h, 1Eh, 65h, 20h
		db  00h, 05h, 34h, 20h,	00h, 04h, 4Fh, 20h, 80h, 04h, 04h
		db  24h, 20h, 00h, 04h,	24h, 20h, 00h, 04h, 24h, 20h, 80h
		db  04h, 01h, 2Ah, 20h,	00h, 01h, 2Ah, 20h, 80h, 04h, 04h
		db  64h, 20h, 00h, 0Bh,	27h, 20h, 80h, 0Dh, 04h, 6Ah, 20h
		db  00h, 03h, 33h, 20h,	00h, 01h, 26h, 20h, 00h, 19h, 6Eh
		db  20h, 80h, 04h, 04h,	22h, 20h, 00h, 57h, 79h, 20h, 00h
		db  01h, 26h, 20h, 00h,	24h, 25h, 20h, 00h, 04h, 4Fh, 20h
		db  00h, 1Ch, 6Ah, 20h,	00h, 05h, 24h, 20h, 00h, 04h, 3Dh
		db  20h, 80h, 04h, 04h,	38h, 20h, 80h, 02h, 01h, 2Ch, 04h
		db  43h, 20h, 80h, 04h,	04h, 2Ah, 20h, 00h, 04h, 3Dh, 20h
		db  80h, 04h, 04h, 68h,	20h, 00h, 0Bh, 27h, 20h, 80h, 03h
		db  2Fh, 3Ah, 20h, 80h,	08h, 04h, 4Fh, 20h, 00h, 04h, 2Ah
		db  20h, 00h, 16h, 6Ch,	20h, 00h, 29h, 7Eh, 20h, 80h, 04h
		db  20h, 68h, 20h, 00h,	04h, 4Ah, 20h, 00h, 01h, 26h, 20h
		db  00h, 04h, 43h, 20h,	00h, 04h, 4Ah, 20h, 00h, 04h, 24h
		db  20h, 00h, 04h, 3Eh,	20h, 00h, 04h, 6Ch, 20h, 80h, 04h
		db  04h, 63h, 20h, 00h,	04h, 47h, 20h, 00h, 04h, 3Fh, 20h
		db  80h, 04h, 14h, 6Ah,	20h, 00h, 04h, 26h, 20h, 80h, 04h
		db  04h, 35h, 20h, 00h,	0Bh, 27h, 20h, 80h, 0Dh, 1Ch, 75h
		db  20h, 00h, 2Ah, 58h,	20h, 00h, 1Eh, 70h, 20h, 00h, 04h
		db  39h, 20h, 80h, 04h,	04h, 2Ch, 20h, 00h, 04h, 73h, 20h
		db  80h, 02h, 01h, 2Ch,	04h, 3Fh, 20h, 00h, 04h, 24h, 20h
		db  00h, 04h, 4Ah, 20h,	80h, 02h, 01h, 2Eh, 04h, 40h, 20h
		db  80h, 04h, 04h, 22h,	20h, 00h, 04h, 62h, 20h, 80h, 02h
		db  01h, 2Ch, 20h, 80h,	03h, 04h, 24h, 20h, 00h, 04h, 24h
		db  20h, 80h, 04h, 04h,	73h, 20h, 00h, 0Bh, 27h, 20h, 80h
		db  0Dh, 29h, 55h, 20h,	00h, 04h, 6Ah, 20h, 00h, 01h, 26h
		db  20h, 00h, 04h, 6Bh,	20h, 80h, 04h, 1Bh, 57h, 20h, 00h
		db  04h, 41h, 20h, 00h,	2Dh, 3Dh, 20h, 00h, 04h, 4Eh, 20h
		db  00h, 01h, 26h, 20h,	00h, 04h, 22h, 20h, 00h, 04h, 33h
		db  20h, 00h, 04h, 31h,	20h, 80h, 04h, 04h, 6Ah, 20h, 00h
		db  04h, 5Eh, 20h, 00h,	1Ah, 23h, 20h, 80h, 04h, 04h, 40h
		db  20h, 00h, 04h, 26h,	20h, 80h, 04h, 03h, 33h, 20h, 00h
		db  0Bh, 27h, 20h, 80h,	0Dh, 04h, 4Ah, 20h, 00h, 05h, 33h
		db  20h, 00h, 04h, 3Dh,	20h, 00h, 04h, 44h, 20h, 80h, 04h
		db  04h, 24h, 20h, 00h,	04h, 65h, 20h, 00h, 24h, 6Ah, 20h
		db  00h, 04h, 4Bh, 20h,	00h, 01h, 26h, 20h, 00h, 01h, 26h
		db  20h, 00h, 04h, 4Eh,	20h, 00h, 04h, 38h, 20h, 80h, 04h
		db  04h, 5Eh, 20h, 00h,	04h, 22h, 20h, 00h, 12h, 73h, 20h
		db  80h, 04h, 04h, 2Bh,	20h, 00h, 05h, 33h, 20h, 80h, 04h
		db  04h, 72h, 20h, 00h,	0Bh, 27h, 10h, 6Ch, 20h, 80h, 0Bh
		db  04h, 24h, 20h, 00h,	01h, 43h, 20h, 00h, 04h, 4Eh, 20h
		db  00h, 04h, 62h, 20h,	80h, 04h, 04h, 64h, 20h, 00h, 04h
		db  26h, 20h, 00h, 24h,	4Ch, 20h, 00h, 01h, 26h, 20h, 00h
		db  01h, 26h, 20h, 00h,	01h, 26h, 20h, 00h, 16h, 48h, 20h
		db  00h, 04h, 63h, 20h,	80h, 04h, 04h, 3Bh, 20h, 80h, 02h
		db  01h, 2Eh, 04h, 4Fh,	20h, 80h, 04h, 04h, 69h, 20h, 00h
		db  05h, 48h, 20h, 80h,	04h, 27h, 63h, 20h, 00h, 0Bh, 27h
		db  2Ah, 47h, 20h, 80h,	0Bh, 04h, 68h, 20h, 00h, 05h, 4Ah
		db  20h, 00h, 22h, 3Eh,	20h, 00h, 04h, 6Ah, 20h, 80h, 04h
		db  04h, 69h, 20h, 00h,	23h, 59h, 20h, 00h, 04h, 6Ah, 20h
		db  00h, 01h, 26h, 20h,	00h, 1Fh, 4Dh, 20h, 00h, 01h, 26h
		db  20h, 00h, 13h, 26h,	20h, 00h, 04h, 22h, 20h, 80h, 04h
		db  04h, 73h, 20h, 00h,	57h, 7Bh, 20h, 00h, 04h, 5Eh, 20h
		db  80h, 04h, 16h, 62h,	20h, 00h, 04h, 50h, 20h, 80h, 04h
		db  04h, 43h, 20h, 00h,	0Bh, 27h, 20h, 80h, 0Dh, 04h, 73h
		db  20h, 00h, 01h, 43h,	20h, 00h, 04h, 4Eh, 20h, 00h, 04h
		db  4Ah, 20h, 80h, 04h,	04h, 6Ch, 20h, 00h, 04h, 6Ch, 20h
		db  00h, 04h, 4Bh, 20h,	00h, 01h, 26h, 20h, 00h, 04h, 4Eh
		db  20h, 00h, 57h, 79h,	20h, 00h, 04h, 4Fh, 20h, 00h, 04h
		db  4Ah, 20h, 80h, 04h,	04h, 2Bh, 20h, 00h, 04h, 22h, 20h
		db  00h, 04h, 24h, 20h,	80h, 04h, 1Dh, 50h, 20h, 00h, 04h
		db  43h, 20h, 80h, 04h,	04h, 46h, 20h, 00h, 0Bh, 27h, 10h
		db  6Ch, 20h, 80h, 05h,	03h, 45h, 20h, 80h, 04h, 57h, 7Ah
		db  20h, 00h, 57h, 7Ch,	20h, 00h, 04h, 2Ah, 20h, 00h, 04h
		db  4Eh, 20h, 80h, 04h,	04h, 6Bh, 20h, 00h, 2Ah, 7Dh, 20h
		db  00h, 15h, 6Eh, 20h,	00h, 04h, 2Fh, 20h, 00h, 04h, 33h
		db  20h, 00h, 05h, 47h,	20h, 00h, 04h, 43h, 20h, 00h, 04h
		db  24h, 20h, 80h, 05h,	01h, 2Ch, 04h, 64h, 20h, 00h, 04h
		db  43h, 20h, 80h, 04h,	04h, 37h, 20h, 00h, 04h, 2Bh, 20h
		db  80h, 04h, 04h, 2Fh,	20h, 00h, 0Bh, 27h, 19h, 54h, 20h
		db  80h, 05h, 03h, 4Eh,	20h, 80h, 04h, 57h, 7Dh, 20h, 00h
		db  04h, 5Eh, 20h, 00h,	2Ah, 58h, 20h, 00h, 04h, 47h, 20h
		db  80h, 04h, 04h, 6Fh,	20h, 00h, 04h, 40h, 20h, 00h, 27h
		db  2Fh, 20h, 00h, 04h,	3Dh, 20h, 00h, 04h, 48h, 20h, 00h
		db  05h, 43h, 20h, 00h,	01h, 2Ah, 20h, 00h, 04h, 43h, 20h
		db  80h, 04h, 05h, 2Dh,	20h, 00h, 04h, 68h, 20h, 00h, 04h
		db  3Fh, 20h, 80h, 04h,	04h, 46h, 20h, 00h, 04h, 6Ah, 20h
		db  80h, 04h, 04h, 6Ch,	20h, 00h, 0Bh, 27h, 20h, 80h, 07h
		db  03h, 44h, 20h, 80h,	07h, 04h, 47h, 20h, 00h, 04h, 6Ah
		db  20h, 00h, 2Eh, 49h,	20h, 80h, 04h, 04h, 24h, 20h, 80h
		db  02h, 01h, 2Ch, 04h,	4Eh, 20h, 00h, 04h, 26h, 20h, 00h
		db  04h, 4Fh, 20h, 00h,	05h, 35h, 20h, 00h, 04h, 68h, 20h
		db  00h, 01h, 2Ah, 20h,	80h, 04h, 05h, 6Ah, 20h, 00h, 04h
		db  35h, 20h, 80h, 02h,	01h, 2Ch, 20h, 80h, 03h, 27h, 63h
		db  20h, 00h, 04h, 37h,	20h, 80h, 04h, 04h, 46h, 20h, 00h
		db  0Bh, 27h, 10h, 6Ch,	20h, 80h, 05h, 57h, 7Dh, 20h, 80h
		db  08h, 01h, 2Ch, 04h,	4Fh, 20h, 00h, 04h, 24h, 20h, 80h
		db  05h, 01h, 2Ch, 57h,	7Ah, 20h, 00h, 27h, 2Fh, 20h, 80h
		db  02h, 01h, 2Eh, 18h,	40h, 20h, 00h, 05h, 73h, 20h, 00h
		db  04h, 3Dh, 20h, 00h,	57h, 7Dh, 20h, 80h, 04h, 04h, 2Ch
		db  20h, 00h, 04h, 73h,	20h, 00h, 03h, 38h, 20h, 80h, 04h
		db  04h, 43h, 20h, 00h,	04h, 46h, 20h, 80h, 04h, 04h, 22h
		db  20h, 00h, 0Bh, 27h,	2Eh, 73h, 20h, 80h, 05h, 0Ch, 25h
		db  0Bh, 24h, 0Ch, 25h,	0Bh, 24h, 0Ch, 25h, 0Bh, 24h, 0Ch
		db  25h, 0Bh, 24h, 0Ch,	25h, 0Bh, 24h, 0Ch, 25h, 0Bh, 24h
		db  0Ch, 25h, 0Bh, 24h,	0Ch, 25h, 0Bh, 24h, 0Ch, 25h, 0Bh
		db  24h, 0Ch, 25h, 0Bh,	24h, 0Ch, 25h, 0Bh, 24h, 0Ch, 25h
		db  0Bh, 24h, 0Ch, 25h,	0Bh, 24h, 0Ch, 25h, 0Bh, 24h, 0Ch
		db  25h, 0Bh, 24h, 0Ch,	25h, 0Bh, 24h, 0Ch, 25h, 0Bh, 24h
		db  0Ch, 25h, 0Bh, 24h,	0Ch, 25h, 0Bh, 24h, 0Ch, 25h, 0Bh
		db  24h, 0Ch, 25h, 0Bh,	24h, 0Ch, 25h, 0Bh, 24h, 0Ch, 25h
		db  0Bh, 24h, 84h, 00h,	84h, 00h, 0Bh, 24h, 0Bh, 3Eh, 20h
		db  80h, 07h,0FFh,0FFh
		db  81h, 45h,0E5h, 02h,	81h, 02h,0E5h, 02h,0E1h, 05h,0E1h
		db  48h, 81h, 01h,0E5h,	02h,0E1h, 05h,0E1h, 48h, 81h, 01h
		db 0E5h, 02h,0E1h, 05h,0E1h, 48h, 81h, 01h,0E5h, 02h,0E1h
		db  05h,0E1h, 48h, 81h,	01h,0E5h, 02h,0E1h, 05h,0E1h, 48h
		db  81h, 01h,0E5h, 02h,0E1h, 05h,0E1h, 48h, 81h, 01h,0E5h
		db  02h,0E1h, 05h,0E1h,	48h, 81h, 01h,0E5h, 02h,0E1h, 05h
		db 0E1h, 48h, 81h, 01h,0E5h, 02h,0E1h, 01h,0A1h, 02h,0E1h
		db  02h,0E1h, 48h, 81h,	01h,0E5h, 02h,0E1h, 05h,0E1h, 48h
		db  81h, 01h,0E1h, 03h,0A1h, 02h,0E1h, 02h,0E1h, 48h, 81h
		db  01h,0E1h, 07h,0E1h,	48h, 81h, 01h,0E1h, 03h,0A1h, 02h
		db 0E1h, 02h,0E1h, 48h,	81h, 01h,0E1h, 07h,0E1h, 48h, 81h
		db  01h,0E1h, 07h,0E1h,	48h, 81h, 01h,0E1h, 07h,0E1h, 48h
		db  81h, 01h,0E1h, 07h,0E1h, 48h, 81h, 01h,0E1h, 07h,0E1h
		db  48h, 81h, 01h,0E1h,	07h,0E1h, 48h, 81h, 01h,0E1h, 07h
		db 0E1h, 48h, 81h, 01h,0E1h, 07h,0E1h, 48h, 81h, 01h,0E1h
		db  07h,0E1h, 48h, 81h,	01h,0E1h, 07h,0E1h, 48h, 81h, 01h
		db 0E1h, 07h, 81h, 45h,0E1h, 02h, 81h, 02h,0E1h, 07h,0FFh
		db 0FFh
		db  21h, 76h, 00h, 00h,	00h, 00h, 00h, 00h, 01h, 00h, 01h
		db  00h, 01h, 00h, 1Fh,0FCh, 01h, 10h, 01h, 10h, 07h,0F0h
		db  09h, 28h, 11h, 44h,	11h, 84h, 11h, 04h, 0Eh, 88h, 00h
		db  00h, 22h, 76h, 02h,	00h, 02h, 00h, 02h, 00h, 7Fh,0FEh
		db  02h, 00h, 02h, 08h,	07h,0C8h, 1Ah, 38h, 22h, 08h, 42h
		db  14h, 42h, 14h, 41h,	22h, 41h, 42h, 20h, 82h, 11h, 02h
		db  0Eh, 0Ch, 23h, 76h,	00h, 00h, 00h, 00h, 00h, 00h, 00h
		db  00h, 00h, 00h, 00h,	00h, 10h, 00h, 20h, 04h, 20h, 04h
		db  40h, 04h, 40h, 04h,	40h, 04h, 20h, 84h, 11h, 0Ch, 0Eh
		db  00h, 00h, 00h, 24h,	76h, 00h, 00h, 10h, 00h, 20h, 08h
		db  20h, 08h, 40h, 04h,	40h, 02h, 40h, 02h, 40h, 01h, 40h
		db  01h, 40h, 01h, 42h,	01h, 22h, 02h, 24h, 06h, 14h, 00h
		db  08h, 00h, 00h, 00h,	25h, 76h, 00h, 00h, 00h, 00h, 00h
		db  00h, 00h, 00h, 00h,	40h, 00h, 40h, 00h, 20h, 01h,0F0h
		db  06h, 08h, 08h, 04h,	00h, 04h, 00h, 04h, 00h, 04h, 00h
		db  08h, 00h, 30h, 00h,0C0h, 26h, 76h, 00h, 80h, 00h, 80h
		db  00h, 40h, 00h, 40h,	03h,0E0h, 0Ch, 18h, 10h, 04h, 20h
		db  02h, 00h, 01h, 00h,	01h, 00h, 01h, 00h, 02h, 00h, 04h
		db  00h, 08h, 00h, 30h,	01h,0C0h, 27h, 76h, 00h, 00h, 00h
		db  00h, 00h, 00h, 00h,	00h, 00h, 00h, 04h, 00h, 03h, 00h
		db  00h,0C0h, 00h, 00h,	0Fh,0F8h, 00h, 60h, 01h, 80h, 06h
		db  00h, 08h, 02h, 17h,	8Ch, 18h, 70h, 28h, 76h, 00h, 00h
		db  03h, 00h, 00h,0C0h,	00h, 00h, 00h, 00h, 3Fh,0F0h, 00h
		db  40h, 00h, 80h, 01h,	00h, 02h, 00h, 04h, 00h, 08h, 02h
		db  10h, 02h, 3Eh, 02h,	61h, 84h, 00h, 78h, 29h, 76h, 00h
		db  00h, 00h, 00h, 00h,	00h, 00h, 00h, 00h, 00h, 00h, 80h
		db  00h, 80h, 0Fh,0F4h,	00h, 84h, 00h, 82h, 07h,0E2h, 08h
		db  98h, 10h, 84h, 11h,	04h, 09h, 04h, 06h, 08h, 2Ah, 76h
		db  00h, 80h, 00h, 80h,	00h, 80h, 3Fh,0F8h, 00h, 80h, 00h
		db  8Ch, 00h, 86h, 00h,	83h, 07h,0E1h, 18h, 98h, 20h, 84h
		db  41h, 02h, 41h, 02h,	42h, 02h, 24h, 02h, 18h, 04h, 2Bh
		db  76h, 00h, 00h, 00h,	00h, 00h, 00h, 04h, 00h, 04h, 40h
		db  04h, 20h, 7Fh, 10h,	04h, 88h, 08h, 48h, 08h, 44h, 10h
		db  44h, 20h, 4Ch, 20h,	80h, 40h, 80h, 03h, 00h, 00h, 00h
		db  2Ch, 76h, 00h, 00h,	00h, 08h, 00h, 24h, 04h, 12h, 04h
		db  48h, 04h, 20h, 7Fh,	10h, 04h, 88h, 08h, 48h, 08h, 44h
		db  10h, 44h, 20h, 4Ch,	20h, 80h, 40h, 80h, 03h, 00h, 00h
		db  00h, 2Dh, 76h, 00h,	00h, 02h, 00h, 02h, 00h, 1Fh,0F0h
		db  01h, 00h, 00h, 80h,	00h, 80h, 1Fh,0F8h, 00h, 40h, 00h
		db  20h, 20h, 20h, 20h,	40h, 20h, 00h, 18h, 08h, 07h,0F0h
		db  00h, 00h, 2Eh, 76h,	00h, 00h, 02h, 05h, 02h, 05h, 1Fh
		db 0F5h, 01h, 00h, 00h,	80h, 00h, 80h, 1Fh,0F8h, 00h, 40h
		db  00h, 20h, 20h, 20h,	20h, 40h, 20h, 00h, 18h, 08h, 07h
		db 0F0h, 00h, 00h, 2Fh,	76h, 00h, 00h, 00h, 60h, 01h, 80h
		db  02h, 00h, 04h, 00h,	08h, 00h, 10h, 00h, 20h, 00h, 20h
		db  00h, 20h, 00h, 10h,	00h, 08h, 00h, 06h, 00h, 01h, 80h
		db  00h, 60h, 00h, 00h,	30h, 76h, 00h, 00h, 00h, 60h, 01h
		db  80h, 02h, 00h, 04h,	14h, 08h, 14h, 10h, 14h, 20h, 00h
		db  20h, 00h, 20h, 00h,	10h, 00h, 08h, 00h, 06h, 00h, 01h
		db  80h, 00h, 60h, 00h,	00h, 31h, 76h, 00h, 00h, 00h, 20h
		db  40h, 10h, 40h, 10h,	40h, 10h, 47h,0FEh, 40h, 10h, 40h
		db  10h, 40h, 10h, 40h,	10h, 20h, 10h, 30h, 10h, 20h, 20h
		db  00h, 20h, 00h, 20h,	00h, 40h, 32h, 76h, 00h, 00h, 00h
		db  25h, 40h, 15h, 40h,	10h, 40h, 10h, 47h,0FEh, 40h, 10h
		db  40h, 10h, 40h, 10h,	40h, 10h, 20h, 10h, 30h, 10h, 20h
		db  20h, 00h, 20h, 00h,	40h, 00h, 80h, 33h, 76h, 00h, 00h
		db  00h, 00h, 07h,0E0h,	08h, 10h, 00h, 08h, 00h, 10h, 00h
		db  20h, 00h, 00h, 00h,	00h, 00h, 00h, 10h, 00h, 20h, 04h
		db  20h, 04h, 18h, 08h,	07h,0F0h, 00h, 00h, 34h, 76h, 00h
		db  05h, 00h, 05h, 07h,0E5h, 08h, 10h, 00h, 08h, 00h, 10h
		db  00h, 20h, 00h, 00h,	00h, 00h, 00h, 00h, 10h, 00h, 20h
		db  04h, 20h, 04h, 18h,	08h, 07h,0F0h, 00h, 00h, 35h, 76h
		db  00h, 00h, 02h, 00h,	02h, 00h, 01h, 00h, 01h, 00h, 3Fh
		db 0F8h, 00h, 80h, 00h,	40h, 00h, 40h, 00h, 20h, 20h, 60h
		db  20h, 00h, 10h, 00h,	0Ch, 0Ch, 03h,0F0h, 00h, 00h, 36h
		db  76h, 00h, 00h, 02h,	0Ah, 02h, 0Ah, 01h, 0Ah, 01h, 00h
		db  3Fh,0F8h, 00h, 80h,	00h, 40h, 00h, 40h, 00h, 20h, 20h
		db  60h, 20h, 00h, 10h,	00h, 0Ch, 0Ch, 03h,0F0h, 00h, 00h
		db  37h, 76h, 00h, 00h,	00h, 00h, 20h, 00h, 20h, 00h, 20h
		db  00h, 20h, 00h, 20h,	00h, 20h, 00h, 20h, 00h, 20h, 02h
		db  20h, 02h, 20h, 02h,	10h, 04h, 08h, 18h, 07h,0E0h, 00h
		db  00h, 38h, 76h, 00h,	00h, 00h, 00h, 20h, 90h, 20h, 90h
		db  20h, 90h, 20h, 00h,	20h, 00h, 20h, 00h, 20h, 00h, 20h
		db  02h, 20h, 02h, 20h,	02h, 10h, 04h, 08h, 18h, 07h,0E0h
		db  00h, 00h, 39h, 76h,	00h, 00h, 00h, 10h, 00h, 10h, 00h
		db  10h, 7Fh,0FFh, 00h,	10h, 00h, 10h, 0Fh, 90h, 10h, 50h
		db  20h, 30h, 20h, 30h,	20h, 30h, 10h, 50h, 0Fh, 90h, 00h
		db  10h, 00h, 20h, 3Ah,	76h, 00h, 05h, 00h, 15h, 00h, 15h
		db  00h, 10h, 7Fh,0FFh,	00h, 10h, 00h, 10h, 0Fh, 90h, 10h
		db  50h, 20h, 30h, 20h,	30h, 20h, 30h, 10h, 50h, 0Fh, 90h
		db  00h, 10h, 00h, 20h,	3Bh, 76h, 00h, 00h, 00h, 00h, 10h
		db  10h, 10h, 10h, 10h,	10h, 10h, 10h, 7Fh,0FEh, 10h, 10h
		db  10h, 10h, 10h, 10h,	10h, 00h, 10h, 00h, 10h, 00h, 08h
		db  04h, 07h,0F8h, 00h,	00h, 3Ch, 76h, 00h, 00h, 00h, 05h
		db  10h, 15h, 10h, 15h,	10h, 10h, 10h, 10h, 7Fh,0FEh, 10h
		db  10h, 10h, 10h, 10h,	10h, 10h, 00h, 10h, 00h, 10h, 00h
		db  08h, 04h, 07h,0F8h,	00h, 00h, 3Dh, 76h, 00h, 00h, 20h
		db  18h, 20h, 20h, 1Ch,0C0h, 03h, 00h, 04h, 00h, 18h, 00h
		db  7Fh,0FCh, 00h, 60h,	01h, 80h, 02h, 00h, 04h, 00h, 08h
		db  00h, 08h, 00h, 07h,0F8h, 00h, 00h, 3Eh, 76h, 00h, 00h
		db  20h, 15h, 20h, 25h,	1Ch,0C5h, 03h, 00h, 04h, 00h, 18h
		db  00h, 7Fh,0FCh, 00h,	60h, 01h, 80h, 02h, 00h, 04h, 00h
		db  08h, 00h, 08h, 00h,	07h,0F8h, 00h, 00h, 3Fh, 76h, 00h
		db  00h, 08h, 00h, 08h,	00h, 7Fh, 00h, 08h, 00h, 10h, 00h
		db  11h,0C0h, 12h, 30h,	20h, 08h, 20h, 08h, 20h, 10h, 24h
		db  00h, 44h, 00h, 43h,	0Ch, 40h,0F0h, 00h, 00h, 40h, 76h
		db  00h, 00h, 08h, 14h,	08h, 14h, 7Fh, 14h, 08h, 00h, 10h
		db  00h, 11h,0C0h, 12h,	30h, 20h, 08h, 20h, 08h, 20h, 10h
		db  24h, 00h, 44h, 00h,	43h, 0Ch, 40h,0F0h, 00h, 00h, 41h
		db  76h, 00h, 00h, 04h,	00h, 04h, 00h, 04h, 00h, 3Fh,0F8h
		db  04h, 00h, 04h, 00h,	08h, 00h, 0Bh,0F0h, 0Ch, 0Ch, 10h
		db  02h, 00h, 02h, 00h,	02h, 18h, 0Ch, 07h,0F0h, 00h, 00h
		db  42h, 76h, 00h, 00h,	04h, 00h, 04h, 05h, 04h, 05h, 3Fh
		db 0F5h, 04h, 00h, 04h,	00h, 08h, 00h, 0Bh,0F0h, 0Ch, 0Ch
		db  10h, 02h, 00h, 02h,	00h, 02h, 18h, 0Ch, 07h,0F0h, 00h
		db  00h, 43h, 76h, 00h,	00h, 00h, 00h, 00h, 00h, 00h, 00h
		db  00h, 00h, 00h, 00h,	00h, 00h, 00h, 00h, 07h,0F8h, 00h
		db  04h, 00h, 02h, 00h,	02h, 00h, 02h, 00h, 0Ch, 00h, 70h
		db  00h, 00h, 44h, 76h,	00h, 00h, 00h, 00h, 00h, 00h, 00h
		db  00h, 00h, 00h, 0Fh,0F0h, 70h, 08h, 00h, 04h, 00h, 02h
		db  00h, 02h, 00h, 02h,	00h, 04h, 00h, 08h, 00h, 30h, 07h
		db 0C0h, 00h, 00h, 45h,	76h, 00h, 00h, 00h, 00h, 00h, 0Ah
		db  00h, 0Ah, 00h, 0Ah,	0Fh,0F0h, 70h, 08h, 00h, 04h, 00h
		db  02h, 00h, 02h, 00h,	02h, 00h, 04h, 00h, 08h, 00h, 30h
		db  07h,0C0h, 00h, 00h,	46h, 76h, 00h, 00h, 00h, 00h, 1Fh
		db 0E0h, 60h, 18h, 00h,	1Ch, 00h, 60h, 01h, 80h, 02h, 00h
		db  04h, 00h, 08h, 00h,	08h, 00h, 08h, 00h, 04h, 00h, 03h
		db  08h, 00h,0F8h, 00h,	00h, 47h, 76h, 00h, 05h, 00h, 05h
		db  1Fh,0C5h, 60h, 34h,	00h, 20h, 00h, 40h, 01h, 80h, 02h
		db  00h, 04h, 00h, 08h,	00h, 08h, 00h, 08h, 00h, 04h, 00h
		db  03h, 08h, 00h,0F8h,	00h, 00h, 48h, 76h, 00h, 00h, 20h
		db  00h, 20h, 00h, 10h,	00h, 10h, 3Ch, 09h,0C0h, 06h, 00h
		db  0Ch, 00h, 12h, 00h,	21h, 00h, 20h, 80h, 20h, 00h, 20h
		db  00h, 10h, 06h, 0Fh,0F8h, 00h, 00h, 49h, 76h, 00h, 00h
		db  20h, 05h, 20h, 05h,	10h, 05h, 10h, 30h, 09h,0C0h, 06h
		db  00h, 0Ch, 00h, 12h,	00h, 21h, 00h, 20h, 80h, 20h, 00h
		db  20h, 00h, 10h, 0Eh,	0Fh,0F0h, 00h, 00h, 4Ah, 76h, 02h
		db  00h, 04h, 00h, 08h,	00h,0FFh, 80h, 08h, 38h, 10h, 06h
		db  10h, 09h, 20h, 08h,	41h,0E8h, 42h, 18h, 04h, 0Ch, 08h
		db  0Ah, 08h, 09h, 04h,	30h, 03h,0C0h, 00h, 00h, 4Bh, 76h
		db  00h, 00h, 20h, 00h,	23h,0E0h, 44h, 18h, 40h, 04h, 40h
		db  04h, 40h, 08h, 40h,	10h, 40h, 00h, 40h, 00h, 40h, 00h
		db  44h, 00h, 44h, 00h,	23h, 02h, 20h,0FCh, 00h, 00h, 4Ch
		db  76h, 00h, 00h, 10h,	20h, 10h, 20h, 10h, 20h, 13h,0E0h
		db  1Ch, 30h, 28h, 48h,	28h, 44h, 48h, 82h, 48h, 82h, 45h
		db  1Ah, 45h, 26h, 42h,	23h, 26h, 22h, 19h, 1Ch, 00h, 00h
		db  4Dh, 76h, 10h, 00h,	10h, 00h, 7Fh, 00h, 14h, 00h, 18h
		db  00h, 37h,0E0h, 38h,	18h, 50h, 04h, 50h, 02h, 10h,0E2h
		db  11h, 1Ah, 11h, 06h,	11h, 02h, 10h, 85h, 10h, 78h, 00h
		db  00h, 4Eh, 76h, 00h,	10h, 00h, 10h, 03h,0F8h, 0Ch, 14h
		db  10h, 12h, 20h, 22h,	20h, 21h, 40h, 21h, 40h, 41h, 40h
		db  41h, 40h, 81h, 40h,	82h, 21h, 02h, 1Eh, 04h, 00h, 08h
		db  00h, 00h, 4Fh, 76h,	00h, 00h, 00h, 20h, 40h, 20h, 40h
		db  20h, 47h,0FCh, 40h,	20h, 40h, 20h, 40h, 20h, 40h, 20h
		db  43h,0A0h, 44h, 70h,	48h, 28h, 48h, 24h, 44h, 42h, 63h
		db  80h, 00h, 00h, 50h,	76h, 00h, 00h, 00h, 25h, 40h, 25h
		db  40h, 25h, 47h,0F8h,	40h, 20h, 40h, 20h, 40h, 20h, 40h
		db  20h, 43h,0A0h, 44h,	70h, 48h, 28h, 48h, 24h, 44h, 42h
		db  63h, 80h, 00h, 00h,	51h, 76h, 00h, 06h, 00h, 29h, 40h
		db  29h, 40h, 26h, 47h,0F8h, 40h, 20h, 40h, 20h, 40h, 20h
		db  40h, 20h, 43h,0A0h,	44h, 70h, 48h, 28h, 48h, 24h, 44h
		db  42h, 63h, 80h, 00h,	00h, 52h, 76h, 00h, 00h, 7Ch, 00h
		db  02h, 00h, 04h, 00h,	08h, 00h, 10h, 00h, 20h, 00h, 20h
		db  20h, 40h, 18h, 40h,	14h, 40h, 22h, 40h, 40h, 21h, 80h
		db  1Eh, 00h, 00h, 00h,	00h, 00h, 53h, 76h, 00h, 00h, 7Ch
		db  00h, 02h, 00h, 04h,	00h, 08h, 09h, 10h, 09h, 20h, 09h
		db  20h, 20h, 40h, 18h,	40h, 14h, 40h, 22h, 40h, 40h, 21h
		db  80h, 1Eh, 00h, 00h,	00h, 00h, 00h, 54h, 76h, 00h, 00h
		db  7Ch, 00h, 02h, 00h,	04h, 00h, 08h, 06h, 10h, 09h, 20h
		db  09h, 20h, 26h, 40h,	18h, 40h, 14h, 40h, 22h, 40h, 40h
		db  21h, 80h, 1Eh, 00h,	00h, 00h, 00h, 00h, 55h, 76h, 00h
		db  00h, 0Fh, 80h, 00h,	40h, 00h, 40h, 01h, 80h, 02h, 00h
		db  04h, 00h, 24h, 10h,	23h, 08h, 20h, 84h, 20h, 42h, 20h
		db  22h, 40h, 22h, 4Ch,	20h, 03h,0C0h, 00h, 00h, 56h, 76h
		db  00h, 00h, 0Fh, 8Ah,	00h, 4Ah, 00h, 4Ah, 01h, 80h, 02h
		db  00h, 04h, 00h, 24h,	10h, 23h, 08h, 20h, 84h, 20h, 42h
		db  20h, 22h, 40h, 22h,	4Ch, 20h, 03h,0C0h, 00h, 00h, 57h
		db  76h, 00h, 06h, 0Fh,	89h, 00h, 49h, 00h, 46h, 01h, 80h
		db  02h, 00h, 04h, 00h,	24h, 10h, 23h, 08h, 20h, 84h, 20h
		db  42h, 20h, 22h, 40h,	22h, 4Ch, 20h, 03h,0C0h, 00h, 00h
		db  58h, 76h, 00h, 00h,	00h, 00h, 07h, 80h, 08h, 40h, 10h
		db  20h, 20h, 10h, 20h,	08h, 40h, 08h, 40h, 04h, 40h, 04h
		db  00h, 02h, 00h, 02h,	00h, 01h, 00h, 01h, 00h, 01h, 00h
		db  00h, 59h, 76h, 00h,	00h, 00h, 14h, 07h, 94h, 08h, 54h
		db  10h, 20h, 20h, 10h,	20h, 08h, 40h, 08h, 40h, 04h, 40h
		db  04h, 00h, 02h, 00h,	02h, 00h, 01h, 00h, 01h, 00h, 01h
		db  00h, 00h, 5Ah, 76h,	00h, 0Ch, 00h, 12h, 07h, 92h, 08h
		db  4Ch, 10h, 20h, 20h,	10h, 20h, 08h, 40h, 08h, 40h, 04h
		db  40h, 04h, 00h, 02h,	00h, 02h, 00h, 01h, 00h, 01h, 00h
		db  01h, 00h, 00h, 5Bh,	76h, 00h, 00h, 40h, 00h, 47h,0FCh
		db  40h, 20h, 40h, 20h,	40h, 20h, 47h,0FCh, 40h, 20h, 40h
		db  20h, 43h,0A0h, 44h,	60h, 48h, 30h, 48h, 28h, 44h, 44h
		db  63h, 80h, 00h, 00h,	5Ch, 76h, 00h, 00h, 40h, 05h, 47h
		db 0F5h, 40h, 25h, 40h,	20h, 40h, 20h, 47h,0FCh, 40h, 20h
		db  40h, 20h, 43h,0A0h,	44h, 60h, 48h, 30h, 48h, 28h, 44h
		db  44h, 63h, 80h, 00h,	00h, 5Dh, 76h, 00h, 06h, 40h, 09h
		db  4Fh,0F9h, 40h, 26h,	40h, 20h, 40h, 20h, 4Fh,0FCh, 40h
		db  20h, 40h, 20h, 43h,0A0h, 44h, 60h, 48h, 30h, 48h, 28h
		db  44h, 44h, 63h, 80h,	00h, 00h, 5Eh, 76h, 00h, 00h, 00h
		db  40h, 00h, 40h, 3Fh,0FCh, 00h, 40h, 00h, 40h, 3Fh,0FCh
		db  00h, 40h, 00h, 40h,	1Fh, 40h, 20h,0E0h, 40h, 58h, 40h
		db  44h, 20h, 82h, 1Fh,	02h, 00h, 00h, 5Fh, 76h, 00h, 00h
		db  1Eh, 00h, 01h, 00h,	00h, 88h, 00h, 88h, 00h, 88h, 00h
		db  88h, 00h, 88h, 00h,	88h, 0Fh,0FEh, 10h, 88h, 20h, 88h
		db  20h, 88h, 21h, 08h,	1Eh, 10h, 00h, 00h, 60h, 76h, 00h
		db  00h, 01h, 00h, 01h,	00h, 3Fh,0F0h, 01h, 00h, 01h, 00h
		db  01h, 04h, 1Dh, 04h,	23h, 02h, 41h, 01h, 41h, 00h, 41h
		db  00h, 23h, 01h, 1Ch,	82h, 00h, 7Ch, 00h, 00h, 61h, 76h
		db  00h, 00h, 08h, 20h,	08h, 20h, 08h, 20h, 08h, 20h, 0Fh
		db 0E0h, 18h, 58h, 28h,	44h, 28h, 82h, 48h, 82h, 45h, 02h
		db  45h, 02h, 42h, 04h,	25h, 04h, 18h, 98h, 00h, 00h, 62h
		db  76h, 00h, 00h, 08h,	00h, 08h, 00h, 08h, 00h, 7Fh,0C0h
		db  08h, 00h, 08h, 00h,	08h, 00h, 7Fh,0E0h, 08h, 00h, 08h
		db  08h, 08h, 08h, 08h,	08h, 04h, 10h, 03h,0E0h, 00h, 00h
		db  63h, 76h, 00h, 00h,	00h, 00h, 00h, 00h, 00h, 00h, 00h
		db  00h, 00h, 00h, 00h,	00h, 00h, 00h, 02h, 40h, 02h, 40h
		db  1Fh,0F8h, 02h, 44h,	02h, 04h, 02h, 08h, 01h, 00h, 00h
		db  00h, 64h, 76h, 00h,	00h, 10h, 40h, 10h, 40h, 10h, 40h
		db  10h, 40h,0FFh,0FCh,	08h, 42h, 08h, 41h, 08h, 01h, 08h
		db  02h, 04h, 1Ch, 04h,	00h, 04h, 00h, 02h, 00h, 02h, 00h
		db  00h, 00h, 65h, 76h,	00h, 00h, 00h, 00h, 00h, 00h, 00h
		db  00h, 00h, 00h, 00h,	00h, 00h, 80h, 10h, 80h, 13h,0E0h
		db  1Ch, 90h, 10h, 90h,	10h, 90h, 12h, 90h, 02h,0A0h, 01h
		db 0C0h, 00h, 80h, 66h,	76h, 00h, 40h, 00h, 40h, 00h, 40h
		db  21h,0F0h, 26h, 48h,	28h, 44h, 30h, 42h, 30h, 42h, 20h
		db  42h, 20h, 42h, 22h,	42h, 02h, 44h, 01h, 48h, 00h,0F0h
		db  00h, 40h, 00h, 80h,	67h, 76h, 00h, 00h, 00h, 00h, 00h
		db  00h, 00h, 00h, 00h,	00h, 00h, 00h, 00h, 80h, 00h, 80h
		db  00h,0F8h, 00h, 80h,	00h, 80h, 0Fh, 80h, 10h,0C0h, 10h
		db 0B0h, 0Fh, 08h, 00h,	00h, 68h, 76h, 00h, 00h, 00h, 80h
		db  00h, 80h, 00h, 80h,	00h, 80h, 00h,0FCh, 00h, 80h, 00h
		db  80h, 00h, 80h, 00h,	80h, 1Fh, 80h, 20h, 60h, 20h, 58h
		db  10h, 84h, 0Fh, 02h,	00h, 00h, 69h, 76h, 00h, 00h, 03h
		db  00h, 00h,0C0h, 10h,	30h, 10h, 00h, 10h, 00h, 10h, 00h
		db  13h,0F0h, 1Ch, 08h,	00h, 04h, 00h, 04h, 00h, 04h, 00h
		db  08h, 00h, 70h, 0Fh,	80h, 00h, 00h, 6Ah, 76h, 00h, 00h
		db  08h, 10h, 10h, 08h,	10h, 08h, 10h, 08h, 10h, 08h, 10h
		db  08h, 0Eh, 08h, 00h,	08h, 00h, 08h, 00h, 08h, 00h, 10h
		db  00h, 10h, 00h, 60h,	1Fh, 80h, 00h, 00h, 6Bh, 76h, 00h
		db  00h, 0Fh,0E0h, 00h,	30h, 00h, 40h, 00h, 80h, 03h, 00h
		db  07h,0E0h, 00h, 18h,	00h, 04h, 00h, 02h, 07h,0C2h, 08h
		db  22h, 08h, 14h, 08h,	18h, 07h,0E0h, 00h, 00h, 6Ch, 76h
		db  08h, 00h, 08h, 00h,	08h, 00h,0FCh, 00h, 08h, 00h, 0Bh
		db 0F0h, 1Ch, 08h, 68h,	08h, 48h, 10h, 08h, 20h, 08h, 20h
		db  08h, 40h, 08h, 41h,	08h, 42h, 08h, 3Ch, 00h, 00h, 6Dh
		db  76h, 00h, 00h, 0Fh,0C0h, 00h, 20h, 00h, 40h, 00h, 80h
		db  01h, 00h, 03h,0E0h,	04h, 18h, 08h, 04h, 00h, 02h, 00h
		db  02h, 00h, 02h, 00h,	04h, 0Ch, 08h, 03h,0F0h, 00h, 00h
		db  6Eh, 76h, 00h, 00h,	00h, 00h, 00h, 00h, 00h, 00h, 04h
		db  00h, 04h, 00h, 3Ch,	00h, 04h, 00h, 07h,0E0h, 0Ch, 10h
		db  34h, 08h, 24h, 04h,	04h, 04h, 04h, 04h, 04h, 04h, 04h
		db  08h, 6Fh, 76h, 08h,	00h, 08h, 00h, 08h, 00h,0FCh, 00h
		db  08h, 00h, 0Bh,0E0h,	1Ch, 18h, 68h, 04h, 48h, 04h, 08h
		db  02h, 08h, 02h, 08h,	02h, 08h, 02h, 08h, 02h, 08h, 04h
		db  08h, 18h, 70h, 76h,	1Fh,0C0h, 00h, 40h, 00h, 40h, 00h
		db  80h, 00h, 80h, 01h,	00h, 07h,0C0h, 1Ah, 30h, 24h, 08h
		db  44h, 04h, 48h, 04h,	88h, 04h, 90h, 74h, 60h, 9Ch, 00h
		db  8Ah, 00h, 70h, 71h,	76h, 3Fh,0F0h, 00h, 10h, 00h, 20h
		db  07h,0C0h, 00h, 20h,	00h, 10h, 1Ch, 10h, 22h, 10h, 21h
		db  20h, 20h,0C0h, 1Fh,	80h, 00h, 00h, 18h,0C4h, 27h,0BCh
		db  41h, 12h, 82h, 11h,	72h, 76h, 00h, 00h, 01h, 00h, 01h
		db  00h, 01h, 00h, 3Fh,0F0h, 01h, 00h, 01h, 00h, 01h, 10h
		db  07h,0E0h, 18h, 80h,	20h, 80h, 20h, 00h, 20h, 00h, 10h
		db  18h, 0Fh,0E0h, 00h,	00h, 73h, 76h, 00h, 00h, 04h, 00h
		db  08h, 00h, 08h, 00h,	10h, 00h, 10h, 00h, 20h, 08h, 20h
		db  04h, 20h, 02h, 40h,	02h, 40h, 02h, 4Eh, 02h, 51h, 04h
		db  60h, 84h, 40h,0F8h,	00h, 00h, 74h, 76h, 00h, 00h, 00h
		db  00h, 00h, 00h, 00h,	00h, 00h, 00h, 0Fh, 00h, 10h, 81h
		db  10h, 80h, 60h, 44h,	00h, 38h, 00h, 00h, 00h, 00h, 00h
		db  00h, 00h, 00h, 00h,	00h, 00h, 00h, 75h, 76h, 00h, 00h
		db  00h, 00h, 01h,0E0h,	02h, 10h, 04h, 08h, 04h, 04h, 08h
		db  04h, 08h, 04h, 08h,	04h, 08h, 04h, 08h, 04h, 08h, 04h
		db  04h, 08h, 06h, 08h,	01h,0F0h, 00h, 00h, 76h, 76h, 00h
		db  00h, 00h, 00h, 01h,	00h, 00h, 80h, 00h, 80h, 00h, 80h
		db  00h, 80h, 00h, 80h,	00h, 80h, 00h, 80h, 00h, 80h, 00h
		db  80h, 00h, 80h, 00h,	80h, 01h,0C0h, 00h, 00h, 77h, 76h
		db  00h, 00h, 00h, 00h,	03h,0C0h, 04h, 20h, 08h, 10h, 08h
		db  10h, 00h, 10h, 00h,	10h, 00h, 20h, 00h, 40h, 00h, 80h
		db  03h, 00h, 04h, 00h,	08h, 00h, 0Fh,0F8h, 00h, 00h, 78h
		db  76h, 00h, 00h, 00h,	00h, 01h,0E0h, 02h, 10h, 04h, 08h
		db  00h, 08h, 00h, 08h,	00h, 10h, 01h, 60h, 00h, 10h, 00h
		db  08h, 08h, 08h, 08h,	08h, 04h, 10h, 03h,0E0h, 00h, 00h
		db  79h, 76h, 00h, 00h,	00h, 00h, 00h, 10h, 00h, 30h, 00h
		db  50h, 00h, 90h, 01h,	10h, 02h, 10h, 04h, 10h, 08h, 10h
		db  08h, 10h, 0Fh,0FCh,	00h, 10h, 00h, 10h, 00h, 10h, 00h
		db  00h, 7Ah, 76h, 00h,	00h, 00h, 00h, 07h,0F8h, 04h, 00h
		db  04h, 00h, 04h, 00h,	04h, 00h, 04h, 00h, 03h,0E0h, 00h
		db  10h, 00h, 08h, 00h,	08h, 08h, 08h, 04h, 10h, 03h,0E0h
		db  00h, 00h, 7Bh, 76h,	00h, 00h, 00h, 00h, 01h,0E0h, 02h
		db  10h, 04h, 08h, 04h,	00h, 08h, 00h, 08h, 00h, 0Bh,0E0h
		db  0Ch, 10h, 08h, 08h,	08h, 08h, 08h, 08h, 04h, 10h, 03h
		db 0E0h, 00h, 00h, 7Ch,	76h, 00h, 00h, 00h, 00h, 0Fh,0F8h
		db  08h, 08h, 08h, 08h,	00h, 10h, 00h, 10h, 00h, 20h, 00h
		db  20h, 00h, 40h, 00h,	40h, 00h, 40h, 00h, 80h, 00h, 80h
		db  00h, 80h, 00h, 00h,	7Dh, 76h, 00h, 00h, 00h, 00h, 03h
		db 0C0h, 04h, 20h, 08h,	10h, 08h, 10h, 08h, 10h, 04h, 20h
		db  07h,0E0h, 04h, 10h,	08h, 08h, 08h, 08h, 08h, 08h, 04h
		db  10h, 03h,0E0h, 00h,	00h, 7Eh, 76h, 00h, 00h, 00h, 00h
		db  01h,0E0h, 02h, 10h,	04h, 08h, 04h, 08h, 08h, 08h, 08h
		db  08h, 08h, 10h, 08h,	10h, 07h,0E0h, 00h, 20h, 00h, 20h
		db  00h, 20h, 00h, 20h,	00h, 00h, 21h, 77h, 00h, 00h, 00h
		db  00h, 00h, 00h, 00h,	00h, 00h, 00h, 00h, 00h, 3Fh,0E0h
		db  40h, 10h, 02h, 10h,	02h, 10h, 02h, 60h, 03h, 80h, 02h
		db  00h, 04h, 00h, 18h,	00h, 00h, 00h, 22h, 77h, 00h, 00h
		db  00h, 00h, 1Fh,0F0h,	60h, 0Ch, 00h, 02h, 01h, 02h, 01h
		db  02h, 01h, 0Ch, 01h,0F0h, 01h, 00h, 01h, 00h, 01h, 00h
		db  02h, 00h, 02h, 00h,	04h, 00h, 00h, 00h, 23h, 77h, 00h
		db  00h, 00h, 00h, 00h,	00h, 00h, 00h, 00h, 00h, 00h, 10h
		db  00h, 20h, 00h,0C0h,	01h, 80h, 06h, 80h, 18h, 80h, 00h
		db  80h, 00h, 80h, 00h,	80h, 00h, 80h, 00h, 00h, 24h, 77h
		db  00h, 00h, 00h, 00h,	00h, 04h, 00h, 18h, 00h, 60h, 01h
		db  80h, 06h, 80h, 18h,	80h, 20h, 80h, 00h, 80h, 00h, 80h
		db  00h, 80h, 00h, 80h,	00h, 80h, 00h, 80h, 00h, 00h, 25h
		db  77h, 00h, 00h, 00h,	00h, 00h, 00h, 00h, 00h, 01h, 00h
		db  01h, 00h, 01h, 00h,	0Fh,0F0h, 11h, 08h, 10h, 08h, 10h
		db  08h, 00h, 10h, 00h,	10h, 00h, 60h, 07h, 80h, 00h, 00h
		db  26h, 77h, 00h, 00h,	01h, 00h, 01h, 00h, 01h, 00h, 0Fh
		db 0F0h, 11h, 08h, 20h,	04h, 20h, 04h, 20h, 04h, 10h, 04h
		db  00h, 04h, 00h, 08h,	00h, 10h, 00h, 60h, 0Fh, 80h, 00h
		db  00h, 27h, 77h, 00h,	00h, 00h, 00h, 00h, 00h, 00h, 00h
		db  00h, 00h, 00h, 00h,	00h, 00h, 00h, 00h, 1Fh,0C0h, 02h
		db  00h, 02h, 00h, 02h,	00h, 02h, 00h, 3Fh,0F0h, 00h, 00h
		db  00h, 00h, 28h, 77h,	00h, 00h, 00h, 00h, 00h, 00h, 3Fh
		db 0F8h, 00h, 84h, 00h,	80h, 00h, 80h, 00h, 80h, 00h, 80h
		db  00h, 80h, 00h, 80h,	00h, 80h, 00h, 80h, 7Fh,0FEh, 00h
		db  00h, 00h, 00h, 29h,	77h, 00h, 00h, 00h, 00h, 00h, 00h
		db  00h, 00h, 00h, 80h,	00h, 80h, 00h, 80h, 3Fh,0F0h, 00h
		db  80h, 01h, 80h, 02h,	80h, 04h, 80h, 08h, 80h, 30h, 80h
		db  00h, 80h, 00h, 00h,	2Ah, 77h, 00h, 00h, 00h, 20h, 00h
		db  20h, 00h, 20h, 3Fh,0FEh, 00h, 20h, 00h, 20h, 00h, 60h
		db  00h,0A0h, 03h, 20h,	0Ch, 20h, 30h, 20h, 00h, 20h, 00h
		db  20h, 00h, 20h, 00h,	00h, 2Bh, 77h, 00h, 00h, 01h, 00h
		db  01h, 00h, 01h, 00h,	3Fh,0F8h, 01h, 04h, 02h, 04h, 02h
		db  04h, 02h, 04h, 04h,	04h, 04h, 08h, 04h, 08h, 08h, 08h
		db  08h, 10h, 10h, 30h,	00h, 00h, 2Ch, 77h, 00h, 00h, 01h
		db  00h, 01h, 05h, 01h,	05h, 3Fh,0F5h, 01h, 08h, 02h, 04h
		db  02h, 04h, 02h, 04h,	04h, 04h, 04h, 08h, 04h, 08h, 08h
		db  08h, 08h, 10h, 10h,	30h, 00h, 00h, 2Dh, 77h, 00h, 00h
		db  01h, 00h, 01h, 00h,	01h,0FCh, 1Fh, 80h, 00h, 80h, 00h
		db  80h, 00h,0FEh, 3Fh,0C0h, 00h, 40h, 00h, 40h, 00h, 40h
		db  00h, 20h, 00h, 20h,	00h, 20h, 00h, 00h, 2Eh, 77h, 00h
		db  05h, 01h, 05h, 01h,	05h, 01h,0FCh, 1Fh, 80h, 00h, 80h
		db  00h, 80h, 00h,0FEh,	3Fh,0C0h, 00h, 40h, 00h, 40h, 00h
		db  40h, 00h, 20h, 00h,	20h, 00h, 20h, 00h, 00h, 2Fh, 77h
		db  00h, 00h, 00h, 00h,	00h, 00h, 07h,0F0h, 04h, 08h, 08h
		db  08h, 08h, 08h, 10h,	08h, 20h, 08h, 00h, 08h, 00h, 10h
		db  00h, 10h, 00h, 20h,	00h,0C0h, 0Fh, 00h, 00h, 00h, 30h
		db  77h, 00h, 05h, 00h,	05h, 00h, 05h, 07h,0F0h, 04h, 08h
		db  08h, 08h, 08h, 08h,	10h, 08h, 20h, 08h, 00h, 08h, 00h
		db  10h, 00h, 10h, 00h,	20h, 00h,0C0h, 0Fh, 00h, 00h, 00h
		db  31h, 77h, 00h, 00h,	08h, 00h, 08h, 00h, 08h, 00h, 0Fh
		db 0FCh, 08h, 10h, 08h,	10h, 10h, 10h, 10h, 10h, 20h, 10h
		db  00h, 10h, 00h, 20h,	00h, 20h, 00h,0C0h, 0Fh, 00h, 00h
		db  00h, 32h, 77h, 00h,	00h, 08h, 05h, 08h, 05h, 08h, 05h
		db  0Fh,0FCh, 08h, 10h,	08h, 10h, 10h, 10h, 10h, 10h, 20h
		db  10h, 00h, 10h, 00h,	20h, 00h, 20h, 00h,0C0h, 0Fh, 00h
		db  00h, 00h, 33h, 77h,	00h, 00h, 00h, 00h, 00h, 00h, 1Fh
		db 0F0h, 00h, 08h, 00h,	04h, 00h, 04h, 00h, 04h, 00h, 04h
		db  00h, 04h, 00h, 04h,	00h, 04h, 00h, 04h, 1Fh,0FCh, 00h
		db  00h, 00h, 00h, 34h,	77h, 00h, 00h, 00h, 05h, 00h, 05h
		db  1Fh,0F5h, 00h, 08h,	00h, 04h, 00h, 04h, 00h, 04h, 00h
		db  04h, 00h, 04h, 00h,	04h, 00h, 04h, 00h, 04h, 1Fh,0FCh
		db  00h, 00h, 00h, 00h,	35h, 77h, 00h, 00h, 08h, 10h, 08h
		db  10h, 08h, 10h, 7Fh,0FEh, 08h, 10h, 08h, 10h, 08h, 10h
		db  04h, 10h, 00h, 10h,	00h, 10h, 00h, 20h, 00h, 20h, 10h
		db 0C0h, 0Fh, 00h, 00h,	00h, 36h, 77h, 00h, 05h, 08h, 15h
		db  08h, 15h, 08h, 10h,	7Fh,0FEh, 08h, 10h, 08h, 10h, 08h
		db  10h, 04h, 10h, 00h,	10h, 00h, 10h, 00h, 20h, 00h, 20h
		db  10h,0C0h, 0Fh, 00h,	00h, 00h, 37h, 77h, 00h, 00h, 00h
		db  00h, 00h, 00h, 18h,	00h, 06h, 00h, 01h, 00h, 00h, 00h
		db  18h, 02h, 06h, 02h,	01h, 04h, 00h, 04h, 00h, 08h, 40h
		db  10h, 30h, 60h, 0Fh,	80h, 00h, 00h, 38h, 77h, 00h, 00h
		db  00h, 00h, 00h, 00h,	18h, 14h, 06h, 14h, 01h, 14h, 00h
		db  00h, 18h, 02h, 06h,	02h, 01h, 04h, 00h, 04h, 00h, 08h
		db  40h, 10h, 30h, 60h,	0Fh, 80h, 00h, 00h, 39h, 77h, 00h
		db  00h, 00h, 00h, 1Fh,0F0h, 20h, 08h, 00h, 08h, 00h, 08h
		db  00h, 10h, 00h, 20h,	00h, 40h, 00h, 80h, 01h, 80h, 02h
		db  40h, 0Ch, 30h, 10h,	0Ch, 20h, 02h, 00h, 00h, 3Ah, 77h
		db  00h, 00h, 00h, 05h,	1Fh,0F5h, 20h, 0Dh, 00h, 08h, 00h
		db  08h, 00h, 10h, 00h,	20h, 00h, 40h, 00h, 80h, 01h, 80h
		db  02h, 40h, 0Ch, 30h,	10h, 0Ch, 20h, 02h, 00h, 00h, 3Bh
		db  77h, 00h, 00h, 04h,	00h, 04h, 00h, 04h, 00h, 04h,0FCh
		db  7Fh, 02h, 04h, 02h,	04h, 04h, 04h, 08h, 04h, 30h, 04h
		db  00h, 04h, 02h, 02h,	02h, 01h,0FCh, 00h, 00h, 00h, 00h
		db  3Ch, 77h, 00h, 05h,	04h, 05h, 04h, 05h, 04h, 00h, 04h
		db 0FCh, 7Fh, 02h, 04h,	02h, 04h, 04h, 04h, 08h, 04h, 30h
		db  04h, 00h, 04h, 02h,	02h, 02h, 01h,0FCh, 00h, 00h, 00h
		db  00h, 3Dh, 77h, 00h,	00h, 00h, 00h, 20h, 04h, 20h, 04h
		db  10h, 04h, 10h, 04h,	08h, 04h, 04h, 04h, 00h, 04h, 00h
		db  08h, 00h, 08h, 00h,	10h, 20h, 20h, 10h,0C0h, 0Fh, 00h
		db  00h, 00h, 3Eh, 77h,	00h, 05h, 00h, 05h, 20h, 05h, 20h
		db  00h, 10h, 04h, 10h,	04h, 08h, 04h, 06h, 04h, 00h, 04h
		db  00h, 08h, 00h, 08h,	00h, 10h, 20h, 20h, 10h,0C0h, 0Fh
		db  00h, 00h, 00h, 3Fh,	77h, 00h, 00h, 00h, 00h, 00h, 00h
		db  07h,0F0h, 04h, 08h,	08h, 08h, 10h, 08h, 10h, 08h, 22h
		db  08h, 02h, 10h, 01h,	10h, 00h,0E0h, 00h, 40h, 01h, 80h
		db  1Eh, 00h, 00h, 00h,	40h, 77h, 00h, 05h, 00h, 05h, 00h
		db  05h, 07h,0F0h, 04h,	08h, 08h, 08h, 10h, 08h, 10h, 08h
		db  22h, 08h, 02h, 10h,	01h, 10h, 00h,0E0h, 00h, 40h, 01h
		db  80h, 1Eh, 00h, 00h,	00h, 41h, 77h, 00h, 00h, 00h, 08h
		db  00h, 30h, 00h,0C0h,	03h, 40h, 0Ch, 40h, 00h, 40h, 00h
		db  40h, 3Fh,0FEh, 00h,	40h, 00h, 40h, 00h, 40h, 00h, 40h
		db  00h, 80h, 0Fh, 00h,	00h, 00h, 42h, 77h, 00h, 00h, 00h
		db  08h, 00h, 35h, 00h,0C5h, 03h, 45h, 0Ch, 40h, 00h, 40h
		db  00h, 40h, 3Fh,0FEh,	00h, 40h, 00h, 40h, 00h, 40h, 00h
		db  40h, 00h, 80h, 0Fh,	00h, 00h, 00h, 43h, 77h, 00h, 00h
		db  00h, 00h, 00h, 00h,	00h, 00h, 00h, 00h, 00h, 00h, 04h
		db  10h, 24h, 10h, 22h,	10h, 12h, 10h, 10h, 10h, 00h, 10h
		db  00h, 20h, 00h,0C0h,	1Fh, 00h, 00h, 00h, 44h, 77h, 00h
		db  00h, 00h, 00h, 02h,	04h, 22h, 04h, 22h, 04h, 21h, 04h
		db  11h, 04h, 11h, 04h,	10h, 04h, 00h, 04h, 00h, 08h, 00h
		db  08h, 00h, 10h, 00h,	60h, 1Fh, 80h, 00h, 00h, 45h, 77h
		db  00h, 05h, 00h, 05h,	02h, 05h, 22h, 00h, 22h, 04h, 21h
		db  04h, 11h, 04h, 11h,	04h, 10h, 04h, 00h, 04h, 00h, 08h
		db  00h, 08h, 00h, 10h,	00h, 60h, 1Fh, 80h, 00h, 00h, 46h
		db  77h, 00h, 00h, 00h,	00h, 1Fh,0FCh, 00h, 00h, 00h, 00h
		db  00h, 00h, 3Fh,0FEh,	00h, 20h, 00h, 20h, 00h, 20h, 00h
		db  20h, 00h, 40h, 00h,	40h, 01h, 80h, 1Eh, 00h, 00h, 00h
		db  47h, 77h, 00h, 05h,	00h, 05h, 1Fh,0F5h, 00h, 00h, 00h
		db  00h, 00h, 00h, 3Fh,0FEh, 00h, 20h, 00h, 20h, 00h, 20h
		db  00h, 20h, 00h, 40h,	00h, 40h, 01h, 80h, 1Eh, 00h, 00h
		db  00h, 48h, 77h, 00h,	00h, 04h, 00h, 04h, 00h, 04h, 00h
		db  04h, 00h, 04h, 00h,	04h, 00h, 06h, 00h, 05h, 80h, 04h
		db  60h, 04h, 10h, 04h,	08h, 04h, 00h, 04h, 00h, 04h, 00h
		db  00h, 00h, 49h, 77h,	00h, 00h, 04h, 28h, 04h, 28h, 04h
		db  28h, 04h, 00h, 04h,	00h, 04h, 00h, 06h, 00h, 05h, 80h
		db  04h, 60h, 04h, 10h,	04h, 08h, 04h, 00h, 04h, 00h, 04h
		db  00h, 00h, 00h, 4Ah,	77h, 00h, 00h, 00h, 40h, 00h, 40h
		db  00h, 20h, 00h, 20h,	00h, 20h, 7Fh,0FEh, 00h, 20h, 00h
		db  20h, 00h, 20h, 00h,	20h, 00h, 40h, 00h, 40h, 01h, 80h
		db  1Eh, 00h, 00h, 00h,	4Bh, 77h, 00h, 00h, 00h, 00h, 00h
		db  00h, 00h, 00h, 0Fh,0F8h, 00h, 00h, 00h, 00h, 00h, 00h
		db  00h, 00h, 00h, 00h,	00h, 00h, 00h, 00h, 7Fh,0FEh, 00h
		db  00h, 00h, 00h, 00h,	00h, 4Ch, 77h, 00h, 00h, 00h, 00h
		db  00h, 00h, 1Fh,0F0h,	00h, 08h, 00h, 08h, 00h, 10h, 08h
		db  10h, 06h, 20h, 01h,0A0h, 00h, 40h, 00h,0A0h, 01h, 18h
		db  06h, 04h, 38h, 04h,	00h, 00h, 4Dh, 77h, 00h, 00h, 00h
		db  00h, 00h, 80h, 00h,	80h, 00h, 80h, 1Fh,0F8h, 00h, 90h
		db  00h, 20h, 00h, 40h,	00h,0C0h, 01h,0B0h, 06h, 8Ch, 18h
		db  82h, 00h, 80h, 00h,	80h, 00h, 00h, 4Eh, 77h, 00h, 00h
		db  00h, 00h, 00h, 08h,	00h, 08h, 00h, 08h, 00h, 08h, 00h
		db  08h, 00h, 08h, 00h,	08h, 00h, 10h, 00h, 10h, 00h, 20h
		db  00h,0C0h, 03h, 00h,	3Ch, 00h, 00h, 00h, 4Fh, 77h, 00h
		db  00h, 00h, 00h, 00h,	20h, 04h, 10h, 08h, 10h, 08h, 10h
		db  10h, 08h, 10h, 08h,	10h, 04h, 20h, 04h, 20h, 04h, 20h
		db  02h, 20h, 02h, 20h,	02h, 00h, 00h, 00h, 00h, 50h, 77h
		db  00h, 0Ah, 00h, 0Ah,	00h, 0Ah, 04h, 20h, 08h, 10h, 08h
		db  10h, 10h, 08h, 10h,	08h, 10h, 04h, 20h, 04h, 20h, 04h
		db  20h, 02h, 20h, 02h,	20h, 02h, 00h, 00h, 00h, 00h, 51h
		db  77h, 00h, 06h, 00h,	09h, 00h, 09h, 04h, 26h, 08h, 10h
		db  08h, 10h, 10h, 08h,	10h, 08h, 10h, 04h, 20h, 04h, 20h
		db  04h, 20h, 02h, 20h,	02h, 20h, 02h, 00h, 00h, 00h, 00h
		db  52h, 77h, 00h, 00h,	10h, 00h, 10h, 00h, 10h, 00h, 10h
		db  0Ch, 10h,0F0h, 1Fh,	00h, 10h, 00h, 10h, 00h, 10h, 00h
		db  10h, 00h, 10h, 00h,	08h, 04h, 07h,0F8h, 00h, 00h, 00h
		db  00h, 53h, 77h, 00h,	00h, 10h, 05h, 10h, 05h, 10h, 05h
		db  10h, 0Ch, 10h,0F0h,	1Fh, 00h, 10h, 00h, 10h, 00h, 10h
		db  00h, 10h, 00h, 10h,	00h, 08h, 04h, 07h,0F8h, 00h, 00h
		db  00h, 00h, 54h, 77h,	00h, 06h, 10h, 09h, 10h, 09h, 10h
		db  06h, 10h, 08h, 10h,0F0h, 1Fh, 00h, 10h, 00h, 10h, 00h
		db  10h, 00h, 10h, 00h,	10h, 00h, 08h, 04h, 07h,0F8h, 00h
		db  00h, 00h, 00h, 55h,	77h, 00h, 00h, 00h, 00h, 00h, 00h
		db  3Fh,0F8h, 00h, 04h,	00h, 04h, 00h, 04h, 00h, 04h, 00h
		db  04h, 00h, 08h, 00h,	08h, 00h, 10h, 00h, 20h, 10h,0C0h
		db  0Fh, 00h, 00h, 00h,	56h, 77h, 00h, 05h, 00h, 05h, 00h
		db  05h, 3Fh,0F8h, 00h,	04h, 00h, 04h, 00h, 04h, 00h, 04h
		db  00h, 04h, 00h, 08h,	00h, 08h, 00h, 10h, 00h, 20h, 10h
		db 0C0h, 0Fh, 00h, 00h,	00h, 57h, 77h, 00h, 06h, 00h, 09h
		db  00h, 09h, 3Fh,0F9h,	00h, 06h, 00h, 04h, 00h, 04h, 00h
		db  04h, 00h, 04h, 00h,	08h, 00h, 08h, 00h, 10h, 00h, 20h
		db  10h,0C0h, 0Fh, 00h,	00h, 00h, 58h, 77h, 00h, 00h, 00h
		db  00h, 07h, 80h, 08h,	40h, 10h, 20h, 10h, 10h, 20h, 08h
		db  20h, 08h, 40h, 04h,	40h, 04h, 40h, 02h, 40h, 02h, 00h
		db  02h, 00h, 02h, 00h,	00h, 00h, 00h, 59h, 77h, 00h, 0Ah
		db  00h, 0Ah, 07h, 8Ah,	08h, 40h, 10h, 20h, 10h, 10h, 20h
		db  08h, 20h, 08h, 40h,	04h, 40h, 04h, 40h, 02h, 40h, 02h
		db  00h, 02h, 00h, 02h,	00h, 00h, 00h, 00h, 5Ah, 77h, 00h
		db  0Ch, 00h, 12h, 07h,	92h, 08h, 4Ch, 10h, 20h, 10h, 10h
		db  20h, 08h, 20h, 08h,	40h, 04h, 40h, 04h, 40h, 02h, 40h
		db  02h, 00h, 02h, 00h,	02h, 00h, 00h, 00h, 00h, 5Bh, 77h
		db  00h, 00h, 00h, 80h,	00h, 80h, 00h, 80h, 00h, 80h, 3Fh
		db 0FCh, 00h, 80h, 00h,	80h, 00h, 80h, 04h, 90h, 08h, 88h
		db  10h, 84h, 10h, 84h,	10h, 82h, 00h, 82h, 00h, 00h, 5Ch
		db  77h, 00h, 00h, 00h,	85h, 00h, 85h, 00h, 85h, 00h, 80h
		db  3Fh,0FCh, 00h, 80h,	00h, 80h, 00h, 80h, 04h, 90h, 08h
		db  88h, 10h, 84h, 10h,	84h, 10h, 82h, 00h, 82h, 00h, 00h
		db  5Dh, 77h, 00h, 06h,	00h, 89h, 00h, 89h, 00h, 86h, 00h
		db  80h, 3Fh,0FCh, 00h,	80h, 00h, 80h, 00h, 80h, 04h, 90h
		db  08h, 88h, 10h, 84h,	10h, 84h, 10h, 82h, 00h, 82h, 00h
		db  00h, 5Eh, 77h, 00h,	00h, 00h, 00h, 0Fh,0F0h, 30h, 0Ch
		db  00h, 02h, 00h, 02h,	00h, 02h, 04h, 04h, 02h, 18h, 01h
		db  60h, 00h, 80h, 00h,	40h, 00h, 20h, 00h, 10h, 00h, 00h
		db  00h, 00h, 5Fh, 77h,	00h, 00h, 0Eh, 00h, 01h,0C0h, 00h
		db  30h, 00h, 08h, 00h,	00h, 0Eh, 00h, 01h, 80h, 00h, 60h
		db  00h, 10h, 00h, 00h,	1Ch, 00h, 03h, 80h, 00h, 60h, 00h
		db  18h, 00h, 00h, 60h,	77h, 00h, 00h, 00h, 00h, 00h, 80h
		db  00h, 80h, 01h, 00h,	01h, 00h, 02h, 00h, 04h, 20h, 08h
		db  10h, 08h, 10h, 10h,	08h, 20h, 0Ch, 20h, 74h, 1Fh, 82h
		db  00h, 02h, 00h, 00h,	61h, 77h, 00h, 00h, 00h, 00h, 00h
		db  08h, 00h, 08h, 00h,	08h, 04h, 08h, 02h, 10h, 01h, 10h
		db  00h,0A0h, 00h, 60h,	00h, 50h, 00h, 88h, 01h, 00h, 1Eh
		db  00h, 00h, 00h, 00h,	00h, 62h, 77h, 00h, 00h, 00h, 00h
		db  3Fh,0F8h, 04h, 00h,	04h, 00h, 04h, 00h, 04h, 00h, 04h
		db  00h, 7Fh,0FEh, 04h,	00h, 04h, 00h, 04h, 00h, 02h, 04h
		db  01h,0F8h, 00h, 00h,	00h, 00h, 63h, 77h, 00h, 00h, 00h
		db  00h, 00h, 00h, 00h,	00h, 00h, 00h, 04h, 00h, 04h, 00h
		db  04h, 00h, 3Fh,0F0h,	04h, 20h, 04h, 40h, 04h, 80h, 04h
		db  00h, 04h, 00h, 04h,	00h, 00h, 00h, 64h, 77h, 00h, 00h
		db  04h, 00h, 04h, 00h,	04h, 00h, 04h, 00h, 7Fh,0FEh, 04h
		db  02h, 04h, 04h, 04h,	08h, 04h, 30h, 02h, 00h, 02h, 00h
		db  02h, 00h, 02h, 00h,	02h, 00h, 00h, 00h, 65h, 77h, 00h
		db  00h, 00h, 00h, 00h,	00h, 00h, 00h, 00h, 00h, 00h, 00h
		db  00h, 00h, 00h, 00h,	1Eh, 00h, 01h, 00h, 00h, 80h, 00h
		db  80h, 00h, 80h, 7Fh,0F0h, 00h, 00h, 00h, 00h, 66h, 77h
		db  00h, 00h, 00h, 00h,	00h, 00h, 1Fh,0C0h, 00h, 20h, 00h
		db  10h, 00h, 10h, 00h,	10h, 00h, 10h, 00h, 10h, 00h, 10h
		db  00h, 10h, 00h, 10h,	7Fh,0FEh, 00h, 00h, 00h, 00h, 67h
		db  77h, 00h, 00h, 00h,	00h, 00h, 00h, 00h, 00h, 00h, 00h
		db  1Fh,0C0h, 00h, 20h,	00h, 20h, 00h, 20h, 1Fh,0A0h, 00h
		db  70h, 00h, 20h, 00h,	20h, 1Fh,0E0h, 00h, 00h, 00h, 00h
		db  68h, 77h, 00h, 00h,	00h, 00h, 1Fh,0F8h, 00h, 04h, 00h
		db  04h, 00h, 04h, 00h,	04h, 0Fh,0F4h, 00h, 0Eh, 00h, 04h
		db  00h, 04h, 00h, 04h,	00h, 04h, 1Fh,0F8h, 00h, 00h, 00h
		db  00h, 69h, 77h, 00h,	00h, 00h, 00h, 0Fh,0F8h, 00h, 00h
		db  00h, 00h, 00h, 00h,	3Fh,0FEh, 00h, 02h, 00h, 02h, 00h
		db  02h, 00h, 04h, 00h,	04h, 00h, 18h, 00h, 60h, 07h, 80h
		db  00h, 00h, 6Ah, 77h,	00h, 00h, 00h, 10h, 08h, 08h, 08h
		db  08h, 08h, 08h, 08h,	08h, 08h, 08h, 08h, 08h, 08h, 08h
		db  00h, 08h, 00h, 10h,	00h, 10h, 10h, 20h, 08h,0C0h, 07h
		db  00h, 00h, 00h, 6Bh,	77h, 00h, 00h, 00h, 00h, 01h, 00h
		db  01h, 00h, 11h, 00h,	11h, 00h, 11h, 00h, 11h, 00h, 11h
		db  02h, 11h, 02h, 21h,	02h, 21h, 04h, 21h, 08h, 20h, 90h
		db  20h, 60h, 00h, 00h,	6Ch, 77h, 00h, 00h, 00h, 00h, 08h
		db  00h, 08h, 00h, 08h,	00h, 08h, 00h, 08h, 00h, 08h, 02h
		db  08h, 02h, 08h, 04h,	08h, 08h, 08h, 10h, 08h, 20h, 08h
		db 0C0h, 07h, 00h, 00h,	00h, 6Dh, 77h, 00h, 00h, 00h, 00h
		db  00h, 00h, 1Fh,0F0h,	10h, 08h, 10h, 04h, 10h, 04h, 10h
		db  04h, 10h, 04h, 10h,	04h, 10h, 04h, 10h, 04h, 10h, 04h
		db  0Fh,0F8h, 00h, 00h,	00h, 00h, 6Eh, 77h, 00h, 00h, 00h
		db  00h, 00h, 00h, 00h,	00h, 00h, 00h, 1Fh,0E0h, 10h, 10h
		db  10h, 10h, 10h, 10h,	00h, 10h, 00h, 20h, 00h, 20h, 00h
		db  40h, 01h, 80h, 06h,	00h, 00h, 00h, 6Fh, 77h, 00h, 00h
		db  00h, 00h, 3Fh,0F8h,	20h, 04h, 20h, 04h, 20h, 04h, 20h
		db  04h, 20h, 04h, 00h,	04h, 00h, 04h, 00h, 08h, 00h, 08h
		db  00h, 10h, 18h, 60h,	07h, 80h, 00h, 00h, 70h, 77h, 00h
		db  00h, 00h, 20h, 00h,	20h, 00h, 20h, 1Fh,0FCh, 04h, 20h
		db  04h, 20h, 04h, 20h,	08h, 20h, 08h, 20h, 3Fh,0FEh, 00h
		db  20h, 00h, 20h, 00h,	20h, 00h, 20h, 00h, 00h, 71h, 77h
		db  00h, 00h, 00h, 00h,	00h, 00h, 1Fh,0F8h, 00h, 04h, 00h
		db  04h, 01h, 08h, 01h,	30h, 01h, 40h, 01h, 00h, 01h, 00h
		db  01h, 00h, 01h, 00h,	3Fh,0FEh, 00h, 00h, 00h, 00h, 72h
		db  77h, 00h, 00h, 00h,	00h, 3Fh,0F8h, 00h, 04h, 00h, 04h
		db  00h, 04h, 00h, 0Ch,	1Fh,0F4h, 00h, 04h, 00h, 04h, 00h
		db  08h, 00h, 08h, 00h,	10h, 00h, 60h, 07h, 80h, 00h, 00h
		db  73h, 77h, 00h, 00h,	00h, 00h, 00h, 00h, 18h, 00h, 04h
		db  00h, 02h, 00h, 01h,	02h, 00h, 02h, 00h, 02h, 00h, 04h
		db  00h, 04h, 00h, 08h,	00h, 10h, 30h, 60h, 0Fh, 80h, 00h
		db  00h, 74h, 77h, 00h,	00h, 01h, 0Ah, 01h, 0Ah, 01h, 0Ah
		db  01h, 00h, 1Fh,0F8h,	20h, 04h, 20h, 04h, 20h, 04h, 10h
		db  04h, 00h, 04h, 00h,	08h, 00h, 10h, 00h, 60h, 0Fh, 80h
		db  00h, 00h, 75h, 77h,	00h, 00h, 00h, 00h, 00h, 00h, 00h
		db  00h, 02h, 00h, 02h,	00h, 02h, 00h, 3Fh,0C0h, 04h, 20h
		db  04h, 20h, 08h, 20h,	08h, 20h, 10h, 40h, 20h, 40h, 01h
		db  80h, 00h, 00h, 76h,	77h, 00h, 00h, 00h, 00h, 00h, 00h
		db  00h, 00h, 10h, 00h,	10h, 00h, 10h, 00h, 1Fh,0E0h, 10h
		db  80h, 20h, 80h, 20h,	80h, 00h, 80h, 01h, 00h, 01h, 00h
		db  0Eh, 00h, 00h, 00h,	77h, 77h, 00h, 00h, 00h, 00h, 07h
		db 0F0h, 08h, 08h, 08h,	08h, 0Ch, 08h, 00h, 08h, 00h, 10h
		db  00h, 60h, 00h, 80h,	00h, 80h, 00h, 00h, 00h, 00h, 00h
		db  80h, 01h, 80h, 00h,	00h, 78h, 77h, 00h, 00h, 00h, 00h
		db  00h, 40h, 00h, 40h,	00h, 80h, 00h, 80h, 00h, 80h, 01h
		db  00h, 01h, 00h, 01h,	00h, 01h, 00h, 00h, 00h, 00h, 00h
		db  03h, 00h, 03h, 00h,	00h, 00h, 79h, 77h, 00h, 00h, 00h
		db  00h, 00h, 00h, 00h,	00h, 00h, 00h, 00h, 00h, 00h, 00h
		db  00h, 00h, 00h, 00h,	07h,0E0h, 18h, 18h, 20h, 04h, 40h
		db  02h, 80h, 01h, 00h,	00h, 00h, 00h, 7Ah, 77h, 00h, 00h
		db  80h, 01h, 40h, 02h,	20h, 04h, 18h, 18h, 07h,0E0h, 00h
		db  00h, 00h, 00h, 00h,	00h, 00h, 00h, 00h, 00h, 00h, 00h
		db  00h, 00h, 00h, 00h,	00h, 00h, 00h, 00h, 7Bh, 77h, 00h
		db  00h, 00h, 00h, 00h,	00h, 00h, 00h, 00h, 00h, 00h, 00h
		db  00h, 00h, 00h, 00h,	00h, 00h, 7Fh,0FEh, 00h, 02h, 00h
		db  02h, 00h, 02h, 00h,	02h, 00h, 02h, 00h, 00h, 7Ch, 77h
		db  00h, 00h, 40h, 00h,	40h, 00h, 40h, 00h, 40h, 00h, 40h
		db  00h, 7Fh,0FEh, 00h,	00h, 00h, 00h, 00h, 00h, 00h, 00h
		db  00h, 00h, 00h, 00h,	00h, 00h, 00h, 00h, 00h, 00h, 7Dh
		db  77h, 00h, 00h, 00h,	00h, 18h, 00h, 24h, 00h, 42h, 00h
		db  81h, 00h,0E7h, 00h,	24h, 00h, 24h, 00h, 27h,0FEh, 20h
		db  02h, 20h, 02h, 3Fh,0FEh, 00h, 00h, 00h, 00h, 00h, 00h
		db 0FFh,0FFh

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_158B8	proc near		; CODE XREF: mes0B_GfxThing+9Ep
					; mes0B_GfxThing+14Cp ...

arg_0		= dword	ptr  4

		push	bp
		mov	bp, sp
		push	es
		push	di
		push	si
		push	ds
		lds	si, [bp+arg_0]
		mov	al, 0C0h ; 'À'
		out	7Ch, al
		mov	ax, ds
		mov	es, ax
		xor	ax, ax
		mov	ds:800h, ax
		mov	cx, 3EFh
		mov	di, 0
		rep stosw
		lodsw
		mov	bx, ax
		lodsw
		mov	dx, ax
		lodsw
		inc	ax
		sub	ax, bx
		ja	short loc_158E6
		jmp	loc_159F3
; ---------------------------------------------------------------------------

loc_158E6:				; CODE XREF: sub_158B8+29j
		mov	ds:802h, ax
		lodsw
		inc	ax
		sub	ax, dx
		ja	short loc_158F2
		jmp	loc_159F3
; ---------------------------------------------------------------------------

loc_158F2:				; CODE XREF: sub_158B8+35j
		mov	ds:804h, ax
		mov	ax, dx
		shl	ax, 1
		shl	ax, 1
		add	ax, dx
		shl	ax, 1
		shl	ax, 1
		shl	ax, 1
		shl	ax, 1
		shr	bx, 1
		shr	bx, 1
		add	ax, bx
		mov	ds:806h, ax

loc_1590E:				; CODE XREF: sub_158B8+92j
					; sub_158B8+97j ...
		mov	ax, ds:800h
		or	ah, ah
		jnz	short loc_15918
		lodsb
		mov	ah, 0FFh

loc_15918:				; CODE XREF: sub_158B8+5Bj
		shr	ax, 1
		mov	ds:800h, ax
		jnb	short loc_15954
		lodsb
		stosb
		and	di, 7FFh
		shr	al, 1
		rcl	dl, 1
		shr	al, 1
		rcl	dl, 1
		shr	al, 1
		rcl	dh, 1
		shr	al, 1
		rcl	dh, 1
		shr	al, 1
		rcl	bl, 1
		shr	al, 1
		rcl	bl, 1
		shr	al, 1
		rcl	bh, 1
		shr	al, 1
		rcl	bh, 1
		inc	cx
		test	cx, 3
		jnz	short loc_1590E
		call	sub_159FD
		jnz	short loc_1590E
		jmp	loc_159F3
; ---------------------------------------------------------------------------

loc_15954:				; CODE XREF: sub_158B8+65j
		lodsw
		push	si
		mov	bp, ax
		rol	ah, 1
		rol	ah, 1
		rol	ah, 1
		and	ah, 7
		mov	si, ax
		mov	ax, bp
		mov	al, ah
		and	ax, 1Fh
		add	al, 3
		mov	bp, ax

loc_1596E:				; CODE XREF: sub_158B8+134j
		lodsb
		stosb
		and	di, 7FFh
		and	si, 7FFh
		shr	al, 1
		rcl	dl, 1
		shr	al, 1
		rcl	dl, 1
		shr	al, 1
		rcl	dh, 1
		shr	al, 1
		rcl	dh, 1
		shr	al, 1
		rcl	bl, 1
		shr	al, 1
		rcl	bl, 1
		shr	al, 1
		rcl	bh, 1
		shr	al, 1
		rcl	bh, 1
		inc	cx
		test	cx, 3
		jnz	short loc_159E9
		mov	al, dl
		out	7Eh, al
		mov	ah, al
		mov	al, dh
		out	7Eh, al
		and	ah, al
		mov	al, bl
		out	7Eh, al
		and	ah, al
		mov	al, bh
		out	7Eh, al
		not	al
		and	ah, al
		not	ah
		mov	bx, 0A800h
		push	es
		mov	es, bx
		assume es:nothing
		mov	bx, ds:806h
		mov	es:[bx], ah
		pop	es
		assume es:nothing
		inc	bx
		mov	ds:806h, bx
		cmp	cx, ds:802h
		jnz	short loc_159E7
		add	bx, 50h	; 'P'
		shr	cx, 1
		shr	cx, 1
		sub	bx, cx
		mov	ds:806h, bx
		xor	cx, cx
		dec	word ptr ds:804h

loc_159E7:				; CODE XREF: sub_158B8+11Aj
		jz	short loc_159F2

loc_159E9:				; CODE XREF: sub_158B8+E5j
		dec	bp
		jz	short loc_159EE
		jmp	short loc_1596E
; ---------------------------------------------------------------------------

loc_159EE:				; CODE XREF: sub_158B8+132j
		pop	si
		jmp	loc_1590E
; ---------------------------------------------------------------------------

loc_159F2:				; CODE XREF: sub_158B8:loc_159E7j
		pop	si

loc_159F3:				; CODE XREF: sub_158B8+2Bj
					; sub_158B8+37j ...
		xor	ax, ax
		out	7Ch, al
		pop	ds
		pop	si
		pop	di
		pop	es
		pop	bp
		retn
sub_158B8	endp


; =============== S U B	R O U T	I N E =======================================


sub_159FD	proc near		; CODE XREF: sub_158B8+94p
		mov	al, dl
		out	7Eh, al
		mov	ah, al
		mov	al, dh
		out	7Eh, al
		and	ah, al
		mov	al, bl
		out	7Eh, al
		and	ah, al
		mov	al, bh
		out	7Eh, al
		not	al
		and	ah, al
		not	ah
		mov	bx, 0A800h
		push	es
		mov	es, bx
		assume es:nothing
		mov	bx, ds:806h
		mov	es:[bx], ah
		pop	es
		assume es:nothing
		inc	bx
		mov	ds:806h, bx
		cmp	cx, ds:802h
		jnz	short locret_15A45
		add	bx, 50h	; 'P'
		shr	cx, 1
		shr	cx, 1
		sub	bx, cx
		mov	ds:806h, bx
		xor	cx, cx
		dec	word ptr ds:804h

locret_15A45:				; CODE XREF: sub_159FD+33j
		retn
sub_159FD	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_15A46	proc near		; CODE XREF: mes21_GfxThing+12Dp
					; mes23_SetEraseType+DAp

arg_0		= dword	ptr  4
arg_4		= dword	ptr  8

		push	bp
		mov	bp, sp
		push	es
		push	di
		push	si
		push	ds
		lds	si, [bp+arg_0]
		les	bx, [bp+arg_4]
		mov	ds:806h, bx
		mov	word ptr ds:808h, es
		mov	ax, ds
		mov	es, ax
		xor	ax, ax
		mov	ds:800h, ax
		mov	cx, 3EFh
		mov	di, 0
		rep stosw
		lodsw
		mov	bx, ax
		lodsw
		mov	dx, ax
		lodsw
		inc	ax
		sub	ax, bx
		ja	short loc_15A7B
		jmp	loc_15BB4
; ---------------------------------------------------------------------------

loc_15A7B:				; CODE XREF: sub_15A46+30j
		mov	ds:802h, ax
		lodsw
		inc	ax
		sub	ax, dx
		ja	short loc_15A87
		jmp	loc_15BB4
; ---------------------------------------------------------------------------

loc_15A87:				; CODE XREF: sub_15A46+3Cj
		mov	ds:804h, ax
		mov	ax, dx
		shl	ax, 1
		shl	ax, 1
		add	ax, dx
		shl	ax, 1
		shl	ax, 1
		shl	ax, 1
		shl	ax, 1
		shr	bx, 1
		shr	bx, 1
		add	ax, bx
		les	bx, ds:806h
		mov	es:[bx], ax
		add	bx, 2
		mov	ax, ds:802h
		shr	ax, 1
		shr	ax, 1
		mov	es:[bx], ax
		add	bx, 2
		mov	ax, ds:804h
		mov	es:[bx], ax
		add	bx, 2
		mov	ds:806h, bx
		mov	word ptr ds:808h, es
		mov	ax, ds
		mov	es, ax

loc_15ACC:				; CODE XREF: sub_15A46+C2j
					; sub_15A46+ECj ...
		mov	ax, ds:800h
		or	ah, ah
		jnz	short loc_15AD6
		lodsb
		mov	ah, 0FFh

loc_15AD6:				; CODE XREF: sub_15A46+8Bj
		shr	ax, 1
		mov	ds:800h, ax
		jnb	short loc_15B37
		lodsb
		stosb
		and	di, 7FFh
		shr	al, 1
		rcl	dl, 1
		shr	al, 1
		rcl	dl, 1
		shr	al, 1
		rcl	dh, 1
		shr	al, 1
		rcl	dh, 1
		shr	al, 1
		rcl	bl, 1
		shr	al, 1
		rcl	bl, 1
		shr	al, 1
		rcl	bh, 1
		shr	al, 1
		rcl	bh, 1
		inc	cx
		test	cx, 3
		jnz	short loc_15ACC
		push	es
		mov	ax, bx
		les	bx, ds:806h
		mov	es:[bx], dl
		inc	bx
		mov	es:[bx], dh
		inc	bx
		mov	es:[bx], al
		inc	bx
		mov	es:[bx], ah
		inc	bx
		mov	ds:806h, bx
		cmp	cx, ds:802h
		jnz	short loc_15B31
		xor	cx, cx
		dec	word ptr ds:804h

loc_15B31:				; CODE XREF: sub_15A46+E3j
		pop	es
		jnz	short loc_15ACC
		jmp	short loc_15BB4
; ---------------------------------------------------------------------------
		db 90h
; ---------------------------------------------------------------------------

loc_15B37:				; CODE XREF: sub_15A46+95j
		lodsw
		push	si
		mov	bp, ax
		rol	ah, 1
		rol	ah, 1
		rol	ah, 1
		and	ah, 7
		mov	si, ax
		mov	ax, bp
		mov	al, ah
		and	ax, 1Fh
		add	al, 3
		mov	bp, ax

loc_15B51:				; CODE XREF: sub_15A46+167j
		lodsb
		stosb
		and	di, 7FFh
		and	si, 7FFh
		shr	al, 1
		rcl	dl, 1
		shr	al, 1
		rcl	dl, 1
		shr	al, 1
		rcl	dh, 1
		shr	al, 1
		rcl	dh, 1
		shr	al, 1
		rcl	bl, 1
		shr	al, 1
		rcl	bl, 1
		shr	al, 1
		rcl	bh, 1
		shr	al, 1
		rcl	bh, 1
		inc	cx
		test	cx, 3
		jnz	short loc_15BAC
		push	es
		mov	ax, bx
		les	bx, ds:806h
		mov	es:[bx], dl
		inc	bx
		mov	es:[bx], dh
		inc	bx
		mov	es:[bx], al
		inc	bx
		mov	es:[bx], ah
		inc	bx
		mov	ds:806h, bx
		cmp	cx, ds:802h
		jnz	short loc_15BA9
		xor	cx, cx
		dec	word ptr ds:804h

loc_15BA9:				; CODE XREF: sub_15A46+15Bj
		pop	es
		jz	short loc_15BB3

loc_15BAC:				; CODE XREF: sub_15A46+13Aj
		dec	bp
		jnz	short loc_15B51
		pop	si
		jmp	loc_15ACC
; ---------------------------------------------------------------------------

loc_15BB3:				; CODE XREF: sub_15A46+164j
		pop	si

loc_15BB4:				; CODE XREF: sub_15A46+32j
					; sub_15A46+3Ej ...
		pop	ds
		pop	si
		pop	di
		pop	es
		pop	bp
		retn
sub_15A46	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_15BBA	proc near		; CODE XREF: mes11_GfxThing+277p
					; mes20+21p

arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		mov	bx, [bp+arg_0]

loc_15BC0:				; CODE XREF: sub_15BBA+Aj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 2
		jnz	short loc_15BC0
		mov	al, 70h	; 'p'
		out	0A2h, al	; Interrupt Controller #2, 8259A

loc_15BCA:				; CODE XREF: sub_15BBA+14j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 2
		jnz	short loc_15BCA
		or	bx, bx
		js	short loc_15C42
		mov	ax, 28h	; '('
		mul	bx
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1

loc_15BDB:				; CODE XREF: sub_15BBA+25j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 2
		jnz	short loc_15BDB
		mov	al, ah
		add	al, 40h	; '@'
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1

loc_15BE7:				; CODE XREF: sub_15BBA+31j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 2
		jnz	short loc_15BE7
		mov	ax, 190h
		sub	ax, bx
		shl	ax, 1
		shl	ax, 1
		shl	ax, 1
		shl	ax, 1
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1

loc_15BFC:				; CODE XREF: sub_15BBA+46j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 2
		jnz	short loc_15BFC
		in	al, 31h
		and	al, 80h
		xor	al, 80h
		shr	al, 1
		or	al, ah
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1

loc_15C0E:				; CODE XREF: sub_15BBA+58j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 2
		jnz	short loc_15C0E
		mov	al, 0
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1

loc_15C18:				; CODE XREF: sub_15BBA+62j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 2
		jnz	short loc_15C18
		mov	al, 40h	; '@'
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1

loc_15C22:				; CODE XREF: sub_15BBA+6Cj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 2
		jnz	short loc_15C22
		mov	al, 0
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1

loc_15C2C:				; CODE XREF: sub_15BBA+76j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 2
		jnz	short loc_15C2C
		mov	ah, 19h
		in	al, 31h
		and	al, 80h
		xor	al, 80h
		shr	al, 1
		or	al, ah
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1
		jmp	short loc_15CB5
; ---------------------------------------------------------------------------

loc_15C42:				; CODE XREF: sub_15BBA+18j
		mov	ax, 190h
		add	ax, bx
		mov	cx, ax
		mov	ax, 28h	; '('
		mul	cx
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1

loc_15C50:				; CODE XREF: sub_15BBA+9Aj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 2
		jnz	short loc_15C50
		mov	al, ah
		add	al, 40h	; '@'
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1

loc_15C5C:				; CODE XREF: sub_15BBA+A6j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 2
		jnz	short loc_15C5C
		mov	ax, 190h
		sub	ax, cx
		shl	ax, 1
		shl	ax, 1
		shl	ax, 1
		shl	ax, 1
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1

loc_15C71:				; CODE XREF: sub_15BBA+BBj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 2
		jnz	short loc_15C71
		in	al, 31h
		and	al, 80h
		xor	al, 80h
		shr	al, 1
		or	al, ah
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1

loc_15C83:				; CODE XREF: sub_15BBA+CDj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 2
		jnz	short loc_15C83
		mov	al, 0
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1

loc_15C8D:				; CODE XREF: sub_15BBA+D7j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 2
		jnz	short loc_15C8D
		mov	al, 40h	; '@'
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1

loc_15C97:				; CODE XREF: sub_15BBA+E1j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 2
		jnz	short loc_15C97
		mov	al, 0
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1

loc_15CA1:				; CODE XREF: sub_15BBA+EBj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 2
		jnz	short loc_15CA1
		mov	ah, 19h
		in	al, 31h
		and	al, 80h
		xor	al, 80h
		shr	al, 1
		or	al, ah
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1

loc_15CB5:				; CODE XREF: sub_15BBA+86j
		pop	bp
		retn
sub_15BBA	endp

		assume ss:seg004, ds:nothing

; =============== S U B	R O U T	I N E =======================================

; Attributes: noreturn

		public start
start		proc near
		mov	ah, 30h
		int	21h		; DOS -	GET DOS	VERSION
					; Return: AL = major version number (00h for DOS 1.x)
		cmp	al, 2
		jnb	short loc_15CC1
		int	20h		; DOS -	PROGRAM	TERMINATION
					; returns to DOS--identical to INT 21/AH=00h
; ---------------------------------------------------------------------------

loc_15CC1:				; CODE XREF: start+6j
		cld
		mov	ax, sp
		shr	ax, 1
		shr	ax, 1
		shr	ax, 1
		shr	ax, 1
		test	sp, 0Fh
		jz	short loc_15CD3
		inc	ax

loc_15CD3:				; CODE XREF: start+19j
		mov	bx, ss
		add	bx, ax
		mov	ax, es
		sub	bx, ax
		mov	ah, 4Ah
		int	21h		; DOS -	2+ - ADJUST MEMORY BLOCK SIZE (SETBLOCK)
					; ES = segment address of block	to change
					; BX = new size	in paragraphs
		jb	short loc_15D56
		mov	ax, seg	seg003
		mov	es, ax
		assume es:seg003
		mov	bx, offset unk_16B54
		xor	ax, ax
		mov	es:[bx], ax
		mov	es:[bx+2], ax
		mov	cx, ax
		add	bx, 4
		inc	ah
		mov	cl, ds:80h
		or	cx, cx
		jz	short loc_15D34
		mov	si, 81h
		mov	di, 694h

loc_15D07:				; CODE XREF: start:loc_15D32j
		lodsb
		cmp	al, 20h
		jz	short loc_15D32
		cmp	al, 9
		jz	short loc_15D32
		mov	dx, di
		dec	si

loc_15D13:				; CODE XREF: start+66j
		lodsb
		cmp	al, 20h
		jz	short loc_15D1F
		cmp	al, 9
		jz	short loc_15D1F
		stosb
		loop	loc_15D13

loc_15D1F:				; CODE XREF: start+5Fj	start+63j
		inc	ah
		xor	al, al
		stosb
		mov	es:[bx], dx
		mov	word ptr es:[bx+2], es
		add	bx, 4
		or	cx, cx
		jz	short loc_15D34

loc_15D32:				; CODE XREF: start+53j	start+57j
		loop	loc_15D07

loc_15D34:				; CODE XREF: start+48j	start+79j
		mov	word ptr es:[bx], 0
		mov	word ptr es:[bx+2], 0
		mov	al, ah
		xor	ah, ah
		push	es
		mov	bx, offset unk_16B54
		push	bx
		push	ax
		mov	cs:word_15D5A, ds
		mov	ax, seg	seg002
		mov	ds, ax
		assume ds:seg002
		call	GameMain
; ---------------------------------------------------------------------------

loc_15D56:				; CODE XREF: start+28j
		mov	ah, 4Ch
		int	21h		; DOS -	2+ - QUIT WITH EXIT CODE (EXIT)
start		endp			; AL = exit code

; ---------------------------------------------------------------------------
word_15D5A	dw 0			; DATA XREF: sub_12358+4r start+92w ...

; =============== S U B	R O U T	I N E =======================================

; Attributes: noreturn bp-based	frame

exit		proc near		; CODE XREF: GameMain+51p

arg_0		= byte ptr  2

		mov	bp, sp
		mov	al, [bp+arg_0]
		mov	ah, 4Ch
		int	21h		; DOS -	2+ - QUIT WITH EXIT CODE (EXIT)
exit		endp			; AL = exit code


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

fopen		proc near		; CODE XREF: mes0A_LoadGRP+31p
					; mes28_LoadPalFile+29p ...

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
		jnb	short loc_15D77
		neg	ax

loc_15D77:				; CODE XREF: fopen+Ej
		pop	ds
		pop	bp
		retn
fopen		endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

fread		proc near		; CODE XREF: mes0A_LoadGRP+5Dp
					; mes28_LoadPalFile+5Cp ...

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
		jnb	short loc_15D8F
		xor	ax, ax

loc_15D8F:				; CODE XREF: fread+11j
		pop	ds
		pop	bp
		retn
fread		endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

fclose		proc near		; CODE XREF: mes0A_LoadGRP+69p
					; mes28_LoadPalFile+81p ...

arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		mov	bx, [bp+arg_0]
		mov	ah, 3Eh
		int	21h		; DOS -	2+ - CLOSE A FILE WITH HANDLE
					; BX = file handle
		jb	short loc_15DA0
		xor	ax, ax

loc_15DA0:				; CODE XREF: fclose+Aj
		neg	ax
		pop	bp
		retn
fclose		endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

exec		proc near		; CODE XREF: LoadSoundDriver:loc_1004Ep

arg_0		= dword	ptr  4
arg_4		= dword	ptr  8

		push	bp
		mov	bp, sp
		push	si
		push	di
		push	ds
		push	es
		mov	ax, cs:word_15D5A
		mov	word ptr cs:off_15DF4+2, ax
		mov	cs:word_15DFA, ax
		mov	cs:word_15DFE, ax
		mov	es, ax
		assume es:nothing
		lds	si, [bp+arg_4]
		xor	bx, bx
		mov	di, 81h	; ''

loc_15DC5:				; CODE XREF: exec+28j
		lodsb
		or	al, al
		jz	short loc_15DCE
		stosb
		inc	bx
		jmp	short loc_15DC5
; ---------------------------------------------------------------------------

loc_15DCE:				; CODE XREF: exec+24j
		mov	ax, 0Dh
		stosw
		inc	bx
		inc	bx
		mov	es:80h,	bl
		mov	ax, cs
		mov	es, ax
		assume es:seg000
		lds	dx, [bp+arg_0]
		mov	bx, 5DF2h
		mov	ax, 4B00h
		int	21h		; DOS -	2+ - LOAD OR EXECUTE (EXEC)
					; DS:DX	-> ASCIZ filename
					; ES:BX	-> parameter block
					; AL = subfunc:	load & execute program
		jb	short loc_15DEC
		xor	ax, ax

loc_15DEC:				; CODE XREF: exec+44j
		pop	es
		assume es:nothing
		pop	ds
		pop	di
		pop	si
		pop	bp
		retn
exec		endp

; ---------------------------------------------------------------------------
		align 4
off_15DF4	dd loc_1007F+1		; DATA XREF: exec+Bw
		db 50h,	0
word_15DFA	dw 0			; DATA XREF: exec+Fw
		db 60h,	0
word_15DFE	dw 0			; DATA XREF: exec+13w

; =============== S U B	R O U T	I N E =======================================


sub_15E00	proc near		; CODE XREF: LoadSoundDriver:loc_10062p
		mov	ax, 4D00h
		int	21h		; DOS -	2+ - GET EXIT CODE OF SUBPROGRAM (WAIT)
		retn
sub_15E00	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

malloc		proc near		; CODE XREF: InitGame+46p
					; InitGame+11Bp ...

arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		mov	bx, [bp+arg_0]
		mov	ah, 48h
		int	21h		; DOS -	2+ - ALLOCATE MEMORY
					; BX = number of 16-byte paragraphs desired
		jnb	short loc_15E16
		mov	ax, bx
		neg	ax

loc_15E16:				; CODE XREF: malloc+Aj
		cwd
		pop	bp
		retn
malloc		endp

; ---------------------------------------------------------------------------
		align 8
seg000		ends

; ===========================================================================

; Segment type:	Regular
seg001		segment	byte public 'UNK' use16
		assume cs:seg001
		assume es:nothing, ss:nothing, ds:nothing, fs:nothing, gs:nothing
word_15E20	dw 0			; DATA XREF: mes0B_GfxThing+BCr
					; mes0C_GfxThing+99r ...
dword_15E22	dd 0, 0, 0, 0, 0, 0, 0,	0 ; DATA XREF: mes02_TextChr1+2Cr
					; mes17_ChrSomething+30w ...
characterCols	db 0, 0, 0, 0, 0, 0, 0,	0 ; DATA XREF: mes02_TextChr1+7r
					; mes16_ChrName+24w ...
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
unk_15E63	db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
PaletteDataPtr	dd 0			; DATA XREF: mes0A_LoadGRP+94r
					; mes0B_GfxThing+1Dr ...
word_15E6E	dw 0			; DATA XREF: mes23_SetEraseType+112r
					; InitGame+12Dw
mesPtr		dd 0			; DATA XREF: mes0A_LoadGRP+88r
					; InitGame+DFw	...
grpFileName	db    0			; DATA XREF: mes0A_LoadGRP+18o
					; mes0A_LoadGRP+29o
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
unk_15EA2	db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
word_15EF4	dw 0			; DATA XREF: InitGame+2Fw
word_15EF6	dw 0			; DATA XREF: InitGame+110w
word_15EF8	dw 0			; DATA XREF: InitGame+10Cw
dword_15EFA	dd 0			; DATA XREF: mes0B_GfxThing+ADr
					; mes0B_GfxThing+15Br ...
mesSelJumpPtrs	dw 0			; DATA XREF: mes1A_DoSelect+221o
					; mes1B_SelJump+10r
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
SelectEntryCnt	dw 0			; DATA XREF: mes19_SelText+17w
					; mes19_SelText+84r ...
dword_15F20	dd 0			; DATA XREF: sub_100C8:loc_10104r
					; mes02_TextChr1+39w ...
word_15F24	dw 0			; DATA XREF: mes23_SetEraseType+CFr
					; mes23_SetEraseType+E4r ...
word_15F26	dw 0			; DATA XREF: sub_112D6+154r
					; sub_112D6+2BAr ...
mesFlagValue	dw 0			; DATA XREF: sub_112D6+14Fr
					; sub_112D6+2B5r ...
SelectTextPtrs	dd 0			; DATA XREF: mes19_SelText+33o
					; mes1A_DoSelect+22Bo ...
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
word_15F6A	dw 0			; DATA XREF: mes11_GfxThing+7Er
					; mes20+Dw ...
word_15F6C	dw 0			; DATA XREF: mes0B_GfxThing+C4r
					; mes0B_GfxThing+DAr ...
SelectTxtMaxLen	dw 0			; DATA XREF: mes19_SelText+1Fw
					; mes19_SelText+6Ar ...
SelectEntry	dw 0			; DATA XREF: mes1A_DoSelect+297w
					; mes1A_DoSelect+343r ...
word_15F72	dw 0			; DATA XREF: mes0E+44r	mes0F+1Bw ...
graphicsCount	dw 0			; DATA XREF: mes0A_LoadGRP+F5w
					; mes0B_GfxThing+6Cr ...
mesDataPtr	dd 0			; DATA XREF: InitGame+A4r GameMain+5Br ...
graphicsList	dw 0			; DATA XREF: mes0A_LoadGRP+AEo
					; mes0B_GfxThing+92r ...
unk_15F7C	db    0
		db    0
unk_15F7E	db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
unk_15F9E	db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
unk_15FBE	db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
word_16098	dw 0			; DATA XREF: mes0A_LoadGRP+4Fr
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		dw 0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		dw 0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
mesNextCmdPos	dw 0			; DATA XREF: mes1B_SelJump+19w
					; mes1C_Jump+Dw ...
word_1617C	dw 0			; DATA XREF: sub_100C8+Br
					; sub_100C8+2Cw ...
characterNames	dd 0, 0, 0, 0, 0, 0, 0,	0 ; DATA XREF: mes02_TextChr1+1Dr
					; mes16_ChrName+37w ...
word_1619E	dw 0			; DATA XREF: mes23_SetEraseType+107w
					; InitGame+162w
seg001		ends

; ===========================================================================

; Segment type:	Regular
seg002		segment	byte public 'UNK' use16
		assume cs:seg002
		assume es:nothing, ss:nothing, ds:nothing, fs:nothing, gs:nothing
word_161A0	dw 0			; DATA XREF: mes0B_GfxThing+D2r
					; mes0C_GfxThing+AFr ...
aBadCommand	db 'ƒRƒ}ƒ“ƒh‚ª‚¨‚©‚µ‚¢.',0Dh,0Ah,0 ; DATA XREF: seg002:ErrorTextTblo
					; Wrong	command.
aFileNotFound	db 'ƒtƒ@ƒCƒ‹‚ªŒ©‚Â‚©‚ç‚È‚¢.',0Dh,0Ah,0 ; DATA XREF: seg002:ErrorTextTblo
					; File not found.
aDiskReadError	db 'ƒfƒBƒXƒNƒŠ[ƒhƒGƒ‰[.',0Dh,0Ah,0 ; DATA XREF: seg002:ErrorTextTblo
					; Disk Read Error.
aBadGraphicID	db 'ƒOƒ‰ƒtƒBƒbƒNƒiƒ“ƒo[‚ª‚¨‚©‚µ‚¢.',0Dh,0Ah,0
					; DATA XREF: seg002:ErrorTextTblo
					; Invalid graphic number.
aBadAniCommand	db 'ƒAƒjƒ[ƒVƒ‡ƒ“ƒRƒ}ƒ“ƒh‚ª‚¨‚©‚µ‚¢.',0Dh,0Ah,0
					; DATA XREF: seg002:ErrorTextTblo
					; Unexpected animation command.
aNotEnoughMem	db 'ƒƒ‚ƒŠ‚ª‘«‚è‚Ë‚¥.',0Dh,0Ah,0 ; DATA XREF: seg002:ErrorTextTblo
					; Not enough memory.
aTooManyGFX	db 'ƒAƒjƒ[ƒVƒ‡ƒ“ƒGƒŠƒA‚É“WŠJ‚·‚éƒOƒ‰ƒtƒBƒbƒN‚Ì”‚ª‘½‚·‚¬‚é.',0Dh,0Ah,0
					; DATA XREF: seg002:ErrorTextTblo
					; Too many graphics to load in animation area.
aGraphicsMemErr	db 'ƒOƒ‰ƒtƒBƒbƒN‰æ–Ê‚ÌƒTƒCƒY‚ª¬‚³‚·‚¬‚é.',0Dh,0Ah,0
					; DATA XREF: seg002:ErrorTextTblo
					; Graphics screen size too small.
aNeedExtGFXMem	db '‚±‚Ìƒ\ƒtƒg‚ÍAPC-9801VF/VMˆÈ~(Šg’£ƒOƒ‰ƒtƒBƒbƒNƒƒ‚ƒŠ‚Ì‚ ‚é‹@Ží)‚'
					; DATA XREF: sub_10010+1Bo
		db 'Å‚µ‚©“®ì‚µ‚Ü‚¹‚ñB',0Dh,0Ah ; This software works only on PC-9801VF/VM or later (models with extended graphic memory).
		db 0,0
ErrorTextTbl	dd aBadCommand		; 0 ; DATA XREF: GameMain+89t
					; GameMain+8Dt	...
		dd aFileNotFound	; 1 ; "ƒRƒ}ƒ“ƒh‚ª‚¨‚©‚µ‚¢.\r\n"
		dd aDiskReadError	; 2
		dd aBadGraphicID	; 3
		dd aBadAniCommand	; 4
		dd aNotEnoughMem	; 5
		dd aTooManyGFX		; 6
		dd aGraphicsMemErr	; 7
mesJumpTbl	dw offset mes01_TextNarrator; 0	; DATA XREF: GameMain+D4t
		dw offset mes02_TextChr1; 1
		dw offset mes03_TextChr2; 2
		dw offset mes04_TextChr3; 3
		dw offset mes05_TextChr4; 4
		dw offset mes06_TextChr5; 5
		dw offset mes07_TextChr6; 6
		dw offset mes08_TextChr7; 7
		dw offset mes09_TextChr8; 8
		dw offset mes0A_LoadGRP	; 9
		dw offset mes0B_GfxThing; 0Ah
		dw offset mes0C_GfxThing; 0Bh
		dw offset mes0D		; 0Ch
		dw offset mes0E		; 0Dh
		dw offset mes0F		; 0Eh
		dw offset mes10_GfxThing; 0Fh
		dw offset mes11_GfxThing; 10h
		dw offset mes12_ClearVRAM; 11h
		dw offset mes13		; 12h
		dw offset mes14_SetMsgSpd; 13h
		dw offset mes15_WaitUser; 14h
		dw offset mes16_ChrName	; 15h
		dw offset mes17_ChrSomething; 16h
		dw offset mes18_PlayBGM	; 17h
		dw offset mes19_SelText	; 18h
		dw offset mes1A_DoSelect; 19h
		dw offset mes1B_SelJump	; 1Ah
		dw offset mes1C_Jump	; 1Bh
		dw offset mes1D_MetaCmd	; 1Ch
		dw offset mes1E_TxtBoxThing; 1Dh
		dw offset mes1F_TxtBoxThing; 1Eh
		dw offset mes20		; 1Fh
		dw offset mes21_GfxThing; 20h
		dw offset mes22_ClearThing; 21h
		dw offset mes23_SetEraseType; 22h
		dw offset mes24_GfxPosOffset; 23h
		dw offset mes25		; 24h
		dw offset mes26		; 25h
		dw offset mes27_SetPalFile; 26h
		dw offset mes28_LoadPalFile; 27h
		dw offset mes29_SetPalette; 28h
		dw offset mes2A_SystemText; 29h
		dw offset mes2B_SetAniMode; 2Ah
		dw offset mes2C		; 2Bh
		dw offset mes2D		; 2Ch
		dw offset mes2E		; 2Dh
		dw offset mes2F_SetScrollMode; 2Eh
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
PalFileNamePtr	dd 0			; DATA XREF: mes27_SetPalFile+10w
					; mes27_SetPalFile+21w	...
word_163B2	dw 10h			; DATA XREF: mes0E+31w
					; mes0E:loc_10A96w ...
word_163B4	dw 0			; DATA XREF: mes1A_DoSelect+1Cr
					; mes1A_DoSelect+26r ...
word_163B6	dw 0			; DATA XREF: mes1A_DoSelect+4Dr
					; mes1A_DoSelect+57r ...
word_163B8	dw 4Fh			; DATA XREF: mes1A_DoSelect+16r
					; mes1F_TxtBoxThing+23w ...
word_163BA	dw 18Fh			; DATA XREF: mes1A_DoSelect+47r
					; mes1F_TxtBoxThing+30w
tboxXPos	dw 0			; DATA XREF: mes1A_DoSelect+317r
					; mes1E_TxtBoxThing+9w	...
tboxYPos	dw 0			; DATA XREF: mes1A_DoSelect+313r
					; mes1E_TxtBoxThing+16w ...
tboxWidth	dw 4Fh			; DATA XREF: mes1A_DoSelect+30Fr
					; mes1E_TxtBoxThing+23w ...
tboxHeight	dw 18h			; DATA XREF: mes1A_DoSelect+30Br
					; mes1E_TxtBoxThing+30w
messageSpeed	dw 5			; DATA XREF: PrintTextLine:loc_10158r
					; mes14_SetMsgSpd+Bw ...
byte_163C6	db 0			; DATA XREF: sub_100C8+69r
					; mes17_ChrSomething+1Dw
		db    0
a2j		db 1Bh,'[2J',0
		db    0
a1h		db 1Bh,'[>1h',0
asc_163D4	db 0Dh,0Ah,0		; DATA XREF: mes1A_DoSelect+360o
aN0		db ' -N0',0             ; DATA XREF: LoadSoundDriver+6o
aEmd_com	db 'emd.com',0          ; DATA XREF: LoadSoundDriver+Bo
aGrp		db 'GRP',0              ; DATA XREF: mes0A_LoadGRP+8o
unk_163E8	db    0			; DATA XREF: mes0A_LoadGRP+13o
word_163E9	dw 0, 0, 13Fh, 0C7h	; DATA XREF: mes0B_GfxThing+EBo
		db    0
word_163F2	dw 0, 0C8h, 13Fh, 18Fh	; DATA XREF: mes0B_GfxThing+11Co
		db    0
		db    0
word_163FC	dw 0			; DATA XREF: sub_112D6+8r
					; sub_112D6+1Dr ...
aAya3mes_dat	db 'AYA3MES.DAT',0      ; DATA XREF: InitGame+84o
seg_1640A	dw seg seg003		; DATA XREF: seg000:008Er
					; mes0C_GfxThing+44r ...
seg_1640C	dw seg seg003		; DATA XREF: seg000:00A2r
					; mes0C_GfxThing+C3r ...
seg_1640E	dw seg seg001		; DATA XREF: sub_100C8+7r
					; sub_100C8:loc_100F0r	...
seg_16410	dw seg seg001		; DATA XREF: sub_100C8:loc_10100r
					; mes02_TextChr1+35r ...
seg_16412	dw seg seg001		; DATA XREF: mes02_TextChr1+3r
					; mes03_TextChr2+3r ...
seg_16414	dw seg seg001		; DATA XREF: mes02_TextChr1+14r
					; mes03_TextChr2+14r ...
seg_16416	dw seg seg001		; DATA XREF: mes02_TextChr1+28r
					; mes03_TextChr2+28r ...
seg_16418	dw seg seg001		; DATA XREF: mes0B_GfxThing:loc_10758r
					; mes0C_GfxThing:loc_1087Ar ...
seg_1641A	dw seg seg001		; DATA XREF: mes0B_GfxThing:loc_106F3r
					; mes0B_GfxThing+40r ...
seg_1641C	dw seg seg001		; DATA XREF: mes0B_GfxThing+68r
					; mes0C_GfxThing+14r ...
seg_1641E	dw seg seg001		; DATA XREF: mes0B_GfxThing+8Er
					; mes0C_GfxThing+38r ...
seg_16420	dw seg seg001		; DATA XREF: mes0B_GfxThing+A4r
					; mes0B_GfxThing+152r ...
seg_16422	dw seg seg001		; DATA XREF: mes0B_GfxThing+B8r
					; mes0C_GfxThing+95r ...
seg_16424	dw seg seg001		; DATA XREF: mes0B_GfxThing+C0r
					; mes0B_GfxThing+D6r ...
seg_16426	dw seg seg001		; DATA XREF: mes0B_GfxThing+CEr
					; mes0C_GfxThing+ABr ...
seg_16428	dw seg seg003		; DATA XREF: mes0C_GfxThing+E5r
					; mes0D+89r ...
seg_1642A	dw seg seg001		; DATA XREF: mes0E:loc_10A9Cr
					; mes0F+14r ...
seg_1642C	dw seg seg001		; DATA XREF: mes11_GfxThing+7Ar
					; mes20+9r ...
seg_1642E	dw seg seg001		; DATA XREF: mes19_SelText+13r
					; mes19_SelText+2Br ...
seg_16430	dw seg seg001		; DATA XREF: mes19_SelText+1Br
					; mes19_SelText+66r ...
seg_16432	dw seg seg001		; DATA XREF: sub_112D6+14Br
					; sub_112D6+2B1r ...
seg_16434	dw seg seg001		; DATA XREF: mes1A_DoSelect+293r
					; mes1A_DoSelect+33Fr ...
seg_16436	dw seg seg001		; DATA XREF: mes1B_SelJump+Cr
seg_16438	dw seg seg001		; DATA XREF: mes1B_SelJump+15r
					; mes1C_Jump+9r ...
seg_1643A	dw seg seg001		; DATA XREF: mes1D_MetaCmd:mes1D_00_CondJumpr
					; mes1D_MetaCmd+37r
seg_1643C	dw seg seg003		; DATA XREF: mes22_ClearThing+15r
					; mes23_SetEraseType+14Fr
seg_1643E	dw seg seg000		; DATA XREF: mes23_SetEraseType+5Cr
					; mes23_SetEraseType+81r
seg002		ends

; ===========================================================================

; Segment type:	Regular
seg003		segment	byte public 'UNK' use16
		assume cs:seg003
		assume es:nothing, ss:nothing, ds:nothing, fs:nothing, gs:nothing
seg_16440	dw seg seg000		; DATA XREF: mes23_SetEraseType+6Br
					; mes23_SetEraseType+92r
seg_16442	dw seg seg001		; DATA XREF: mes23_SetEraseType:loc_11DE0r
					; mes23_SetEraseType+E0r ...
seg_16444	dw seg seg001		; DATA XREF: mes23_SetEraseType+10Er
					; InitGame+127r
seg_16446	dw seg seg000		; DATA XREF: mes2F_SetScrollMode+9r
seg_16448	dw seg seg001		; DATA XREF: InitGame+2Br
seg_1644A	dw seg seg001		; DATA XREF: InitGame:loc_12100r
					; InitGame+9Br	...
seg_1644C	dw seg seg001		; DATA XREF: InitGame+108r
dword_1644E	dd 0			; DATA XREF: mes0C_GfxThing+C7o
					; mes0C_GfxThing+D6w ...
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
unk_16464	db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
unk_16483	db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
unk_16490	db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
unk_1649E	db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
unk_164C2	db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
unk_16506	db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
unk_16546	db    0
		db    0
unk_16548	db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
unk_1656E	db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
unk_1659C	db    0
		db    0
unk_1659E	db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
unk_165BE	db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
unk_165D6	db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
unk_165DE	db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
unk_1663E	db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		dw 0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		dw 0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		dw 0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
unk_1676C	db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
unk_1684E	db    0			; DATA XREF: mes13+44o
					; mes22_ClearThing+2Fo	...
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
unk_1687A	db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
word_1688E	dw 0			; DATA XREF: mes0C_GfxThing+E9w
					; mes0D+8Dr ...
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
unk_169F2	db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
word_16A8E	dw 0			; DATA XREF: seg000:0095r
					; mes0C_GfxThing+48r ...
word_16A90	dw 0			; DATA XREF: mes13+10w	mes13+99r ...
byte_16A92	db 0			; DATA XREF: mes13+7Cw
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
word_16AD2	dw 0			; DATA XREF: mes13+25w	mes13+30r ...
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
unk_16B54	db    0			; DATA XREF: start+2Fo	start+8Do
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
unk_16B5C	db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
unk_16BAD	db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
unk_16BFC	db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		align 10h
seg003		ends

; ===========================================================================

; Segment type:	Uninitialized
seg004		segment	byte stack 'STACK' use16
		assume cs:seg004
		assume es:nothing, ss:nothing, ds:nothing, fs:nothing, gs:nothing
byte_16C60	db 1000h dup(?)
seg004		ends


		end start
