; Input	MD5   :	D9F46B9C68825867F49C548D096E41C8
; Input	CRC32 :	5B309C2C

; File Name   :	R:\VG.EXE
; Format      :	MS-DOS executable (EXE)
; Base Address:	1000h Range: 10000h-2DBE0h Loaded length: 1CB40h
; Entry	Point :	2A71:13F

		.686p
		.mmx
		.model large

; ===========================================================================

; Segment type:	Pure code
seg000		segment	byte public 'CODE' use16
		assume cs:seg000
		assume es:nothing, ss:nothing, ds:nothing, fs:nothing, gs:nothing

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_10000	proc far		; CODE XREF: sub_11A04+423p
					; DoEnd5_Reimi+175p ...

var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 4
		push	si
		mov	[bp+var_2], 0
		cmp	[bp+arg_0], 0
		jle	short loc_10022
		mov	si, [bp+arg_0]
		mov	ax, si
		add	[bp+var_2], ax

loc_1001A:				; CODE XREF: sub_10000+20j
		call	MaybeWaitKey
		dec	si
		jnz	short loc_1001A

loc_10022:				; CODE XREF: sub_10000+10j
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_10000	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_10028	proc far		; CODE XREF: DoOpening+15Cp
					; DoCharIntroScr+72p

var_14		= byte ptr -14h
arg_0		= word ptr  6
arg_2		= word ptr  8

		push	bp
		mov	bp, sp
		sub	sp, 14h
		lea	ax, [bp+var_14]
		push	ax
		push	[bp+arg_0]
		call	sub_2A66C
		add	sp, 4
		push	[bp+arg_2]
		lea	ax, [bp+var_14]
		push	ax
		call	sub_2A5FC
		mov	sp, bp
		pop	bp
		retf
sub_10028	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_1004E	proc far		; CODE XREF: sub_10828+6B2p
					; sub_11A04+44Dp ...
		cmp	word ptr ds:12h, 5
		jz	short locret_10092
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, 1009h
		push	ax
		call	sub_29701
		add	sp, 6
		jmp	short loc_1006D
; ---------------------------------------------------------------------------
		align 2

loc_10068:				; CODE XREF: sub_1004E+32j
		call	MaybeWaitKey

loc_1006D:				; CODE XREF: sub_1004E+17j
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, 4
		push	ax
		call	sub_29701
		add	sp, 6
		test	ax, 100h
		jnz	short loc_10068
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, 3
		push	ax
		call	sub_29701
		add	sp, 6

locret_10092:				; CODE XREF: sub_1004E+5j
		retf
sub_1004E	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_10094	proc far		; CODE XREF: sub_124FA+119p
					; DoClearScr_A1+67p ...

var_E		= word ptr -0Eh
var_C		= word ptr -0Ch
var_A		= word ptr -0Ah
var_8		= word ptr -8
var_2		= word ptr -2

		push	bp
		mov	bp, sp
		sub	sp, 10h
		push	di
		push	si
		mov	[bp+var_2], 10h
		mov	si, 251Ah
		mov	di, 294Ch
		mov	[bp+var_8], 251Bh
		mov	[bp+var_A], 294Dh
		mov	[bp+var_C], 251Ch
		mov	[bp+var_E], 294Eh
		mov	cx, 10h

loc_100BE:				; CODE XREF: sub_10094+58j
		mov	al, [di]
		mov	[si], al
		mov	bx, [bp+var_A]
		mov	al, [bx]
		mov	bx, [bp+var_8]
		mov	[bx], al
		mov	bx, [bp+var_E]
		mov	al, [bx]
		mov	bx, [bp+var_C]
		mov	[bx], al
		add	si, 3
		add	di, 3
		add	[bp+var_8], 3
		add	[bp+var_A], 3
		add	[bp+var_C], 3
		add	[bp+var_E], 3
		loop	loc_100BE
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_10094	endp

; ---------------------------------------------------------------------------
		db 2 dup(90h)

; =============== S U B	R O U T	I N E =======================================


sub_100F6	proc far		; CODE XREF: sub_10828+695p
					; sub_11A04+42Ap ...
		jmp	short loc_10114
; ---------------------------------------------------------------------------

loc_100F8:				; CODE XREF: sub_100F6+25j
		cmp	word ptr ds:1Eh, 0
		jnz	short locret_1011D
		cmp	word ptr ds:22h, 1
		jnz	short locret_1011D
		mov	al, ds:2172h
		and	al, 1
		cmp	al, 1
		jnz	short locret_1011D
		call	MaybeWaitKey

loc_10114:				; CODE XREF: sub_100F6j
		call	sub_29798
		or	ax, ax
		jnz	short loc_100F8

locret_1011D:				; CODE XREF: sub_100F6+7j sub_100F6+Ej ...
		retf
sub_100F6	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1011E	proc far		; CODE XREF: sub_106F0+EFp

var_16		= word ptr -16h
var_14		= word ptr -14h
var_10		= word ptr -10h
var_E		= word ptr -0Eh
var_C		= word ptr -0Ch
var_A		= word ptr -0Ah
var_8		= word ptr -8
var_6		= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 16h
		push	di
		push	si
		cmp	[bp+arg_0], 1
		jz	short loc_1012F
		jmp	loc_101EA
; ---------------------------------------------------------------------------

loc_1012F:				; CODE XREF: sub_1011E+Cj
		mov	ax, ds:2170h
		cmp	ds:2A32h, ax
		jnz	short loc_10190
		mov	[bp+var_2], 0Dh
		mov	si, 253Bh
		mov	di, 296Dh
		mov	[bp+var_8], 253Ch
		mov	[bp+var_A], 296Eh
		mov	[bp+var_C], 253Dh
		mov	[bp+var_E], 296Fh
		mov	cx, 2

loc_1015A:				; CODE XREF: sub_1011E:loc_1018Ej
		mov	al, [di]
		mov	[si], al
		mov	bx, [bp+var_A]
		mov	al, [bx]
		mov	bx, [bp+var_8]
		mov	[bx], al
		mov	bx, [bp+var_E]
		mov	al, [bx]
		mov	bx, [bp+var_C]
		mov	[bx], al
		add	si, 3
		add	di, 3
		add	[bp+var_8], 3
		add	[bp+var_A], 3
		add	[bp+var_C], 3
		add	[bp+var_E], 3
		dec	cx
		jnz	short loc_1018E
		jmp	loc_10280
; ---------------------------------------------------------------------------

loc_1018E:				; CODE XREF: sub_1011E+6Bj
		jmp	short loc_1015A
; ---------------------------------------------------------------------------

loc_10190:				; CODE XREF: sub_1011E+18j
		mov	[bp+var_2], 0Dh
		mov	si, 253Bh
		mov	di, 2967h
		mov	[bp+var_C], 253Ch
		mov	[bp+var_A], 2968h
		mov	[bp+var_8], 253Dh
		mov	[bp+var_6], 2969h
		mov	cx, 2

loc_101B2:				; CODE XREF: sub_1011E+C2j
		mov	al, [di]
		mov	[si], al
		mov	bx, [bp+var_A]
		mov	al, [bx]
		mov	bx, [bp+var_C]
		mov	[bx], al
		mov	bx, [bp+var_6]
		mov	al, [bx]
		mov	bx, [bp+var_8]
		mov	[bx], al
		add	si, 3
		add	di, 3
		add	[bp+var_C], 3
		add	[bp+var_A], 3
		add	[bp+var_8], 3
		add	[bp+var_6], 3
		loop	loc_101B2
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
; ---------------------------------------------------------------------------
		db 2 dup(90h)
; ---------------------------------------------------------------------------

loc_101EA:				; CODE XREF: sub_1011E+Ej
		mov	ax, [bp+arg_0]
		shl	ax, 1
		mov	[bp+var_14], ax
		add	ax, 9
		mov	[bp+var_2], ax
		mov	ax, [bp+var_14]
		add	ax, 0Ah
		cmp	ax, [bp+var_2]
		jl	short loc_10280
		mov	ax, [bp+arg_0]
		shl	ax, 1
		add	ax, 0Ah
		mov	[bp+var_10], ax
		mov	ax, [bp+var_2]
		mov	dx, ax
		shl	ax, 1
		add	ax, dx
		mov	[bp+var_16], ax
		mov	si, ax
		add	si, 251Ah
		mov	di, ax
		add	di, 294Ch
		add	ax, 251Bh
		mov	[bp+var_A], ax
		mov	ax, [bp+var_16]
		add	ax, 294Dh
		mov	[bp+var_8], ax
		mov	ax, [bp+var_16]
		add	ax, 251Ch
		mov	[bp+var_6], ax
		mov	ax, [bp+var_16]
		add	ax, 294Eh
		mov	[bp+var_4], ax
		mov	cx, [bp+var_10]
		sub	cx, dx
		inc	cx
		add	[bp+var_2], cx

loc_10250:				; CODE XREF: sub_1011E+160j
		mov	al, [di]
		mov	[si], al
		mov	bx, [bp+var_8]
		mov	al, [bx]
		mov	bx, [bp+var_A]
		mov	[bx], al
		mov	bx, [bp+var_4]
		mov	al, [bx]
		mov	bx, [bp+var_6]
		mov	[bx], al
		add	si, 3
		add	di, 3
		add	[bp+var_A], 3
		add	[bp+var_8], 3
		add	[bp+var_6], 3
		add	[bp+var_4], 3
		loop	loc_10250

loc_10280:				; CODE XREF: sub_1011E+6Dj
					; sub_1011E+E3j
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_1011E	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_10286	proc far		; CODE XREF: sub_126E4+64p

var_6		= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 6
		cmp	word ptr ds:10h, 0
		jz	short loc_10296
		jmp	loc_103C8
; ---------------------------------------------------------------------------

loc_10296:				; CODE XREF: sub_10286+Bj
		mov	ax, ds:217Ah
		add	ax, ds:21C5h
		cwd
		sub	ax, dx
		sar	ax, 1
		sub	ax, 9Eh	; '�'
		cwd
		xor	ax, dx
		sub	ax, dx
		mov	cx, 4
		sar	ax, cl
		xor	ax, dx
		sub	ax, dx
		mov	[bp+var_6], ax
		cmp	ax, 0FFF8h
		jge	short loc_102C0
		mov	[bp+var_6], 0FFF8h

loc_102C0:				; CODE XREF: sub_10286+33j
		cmp	word ptr ds:0Eh, 0
		jnz	short loc_1033C
		mov	ax, [bp+arg_0]
		cwd
		mov	cx, 0Ah
		idiv	cx
		mov	[bp+var_4], ax
		mov	ax, [bp+arg_0]
		cwd
		idiv	cx
		mov	[bp+var_2], dx
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, 16h
		push	ax
		mov	ax, 2
		push	ax
		mov	ax, 1
		push	ax
		mov	ax, 0C0h ; '�'
		push	ax
		mov	ax, 13h
		push	ax
		call	sub_16BFC
		add	sp, 0Eh
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, [bp+var_4]
		add	ax, 7
		push	ax
		mov	ax, 2
		push	ax
		mov	ax, 1
		push	ax
		mov	ax, 0C0h ; '�'
		push	ax
		mov	ax, 13h
		push	ax
		call	sub_16BFC
		add	sp, 0Eh
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, [bp+var_2]
		add	ax, 7
		push	ax
		mov	ax, 2
		push	ax
		mov	ax, 1
		push	ax
		mov	ax, 0C0h ; '�'
		push	ax
		mov	ax, 14h
		jmp	short loc_10373
; ---------------------------------------------------------------------------
		align 2

loc_1033C:				; CODE XREF: sub_10286+3Fj
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, 16h
		push	ax
		mov	ax, 2
		push	ax
		mov	ax, 1
		push	ax
		mov	ax, 0C0h ; '�'
		push	ax
		mov	ax, 13h
		push	ax
		call	sub_16BFC
		add	sp, 0Eh
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, 11h
		push	ax
		mov	ax, 2
		push	ax
		mov	ax, 1
		push	ax
		mov	ax, 0C0h ; '�'
		push	ax
		mov	ax, 13h

loc_10373:				; CODE XREF: sub_10286+B3j
		push	ax
		call	sub_16BFC
		add	sp, 0Eh
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, ds:2646h
		add	ax, 19h
		push	ax
		mov	ax, 2
		push	ax
		mov	ax, 1
		push	ax
		mov	ax, [bp+var_6]
		add	ax, ds:29C2h
		add	ax, 10h
		push	ax
		mov	ax, ds:0Ch
		inc	ax
		push	ax
		call	sub_16BFC
		add	sp, 0Eh
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, ds:2648h
		add	ax, 19h
		push	ax
		mov	ax, 2
		push	ax
		mov	ax, 1
		push	ax
		mov	ax, [bp+var_6]
		add	ax, ds:29C2h
		add	ax, 10h
		jmp	loc_104D4
; ---------------------------------------------------------------------------
		align 2

loc_103C8:				; CODE XREF: sub_10286+Dj
		mov	ax, ds:217Ah
		add	ax, ds:21C5h
		cwd
		sub	ax, dx
		sar	ax, 1
		sub	ax, 9Eh	; '�'
		cwd
		xor	ax, dx
		sub	ax, dx
		mov	cx, 3
		sar	ax, cl
		xor	ax, dx
		sub	ax, dx
		mov	[bp+var_6], ax
		cmp	ax, 0FFD8h
		jge	short loc_103F2
		mov	[bp+var_6], 0FFD8h

loc_103F2:				; CODE XREF: sub_10286+165j
		cmp	word ptr ds:0Eh, 0
		jnz	short loc_10462
		mov	ax, [bp+arg_0]
		cwd
		mov	cx, 0Ah
		idiv	cx
		mov	[bp+var_4], ax
		mov	ax, [bp+arg_0]
		cwd
		idiv	cx
		mov	[bp+var_2], dx
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, [bp+var_4]
		add	ax, 7
		push	ax
		mov	ax, 2
		push	ax
		mov	ax, 1
		push	ax
		mov	ax, [bp+var_6]
		add	ax, ds:29C2h
		add	ax, 30h	; '0'
		push	ax
		mov	ax, ds:0Ch
		add	ax, 13h
		push	ax
		call	sub_16BFC
		add	sp, 0Eh
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, [bp+var_2]
		add	ax, 7
		push	ax
		mov	ax, 2
		push	ax
		mov	ax, 1
		push	ax
		mov	ax, [bp+var_6]
		add	ax, ds:29C2h
		add	ax, 30h	; '0'
		push	ax
		mov	ax, ds:0Ch
		add	ax, 14h
		jmp	short loc_10483
; ---------------------------------------------------------------------------
		align 2

loc_10462:				; CODE XREF: sub_10286+171j
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, 11h
		push	ax
		mov	ax, 2
		push	ax
		mov	ax, 1
		push	ax
		mov	ax, [bp+var_6]
		add	ax, ds:29C2h
		add	ax, 30h	; '0'
		push	ax
		mov	ax, ds:0Ch
		add	ax, 13h

loc_10483:				; CODE XREF: sub_10286+1D9j
		push	ax
		call	sub_16BFC
		add	sp, 0Eh
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, ds:2646h
		add	ax, 19h
		push	ax
		mov	ax, 2
		push	ax
		mov	ax, 1
		push	ax
		mov	ax, [bp+var_6]
		add	ax, ds:29C2h
		add	ax, 30h	; '0'
		push	ax
		mov	ax, ds:0Ch
		inc	ax
		push	ax
		call	sub_16BFC
		add	sp, 0Eh
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, ds:2648h
		add	ax, 19h
		push	ax
		mov	ax, 2
		push	ax
		mov	ax, 1
		push	ax
		mov	ax, [bp+var_6]
		add	ax, ds:29C2h
		add	ax, 30h	; '0'

loc_104D4:				; CODE XREF: sub_10286+13Ej
		push	ax
		mov	ax, ds:0Ch
		add	ax, 23h	; '#'
		push	ax
		call	sub_16BFC
		mov	sp, bp
		pop	bp
		retf
sub_10286	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_104E6	proc far		; CODE XREF: sub_126E4+96p
					; sub_126E4+B0p

var_C		= word ptr -0Ch
var_A		= word ptr -0Ah
var_8		= word ptr -8
var_6		= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 0Ch
		push	di
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		mov	ax, [bx+2180h]
		mov	[bp+var_2], ax
		sub	di, di
		add	ax, 154h
		mov	[bp+var_6], ax
		mov	ax, [bp+var_2]
		add	ax, 153h
		mov	[bp+var_8], ax
		mov	ax, 12Bh
		sub	ax, [bp+var_2]
		mov	[bp+var_A], ax
		mov	ax, 12Ch
		sub	ax, [bp+var_2]
		mov	[bp+var_C], ax
		mov	si, [bp+var_2]

loc_10523:				; CODE XREF: sub_104E6+E8j
		push	di
		call	sub_262E6
		add	sp, 2
		cmp	[bp+arg_0], 0
		jnz	short loc_1057A
		or	si, si
		jg	short loc_1054C
		mov	ax, 2
		push	ax
		mov	ax, 184h
		push	ax
		mov	ax, 12Ch
		push	ax

loc_10542:				; CODE XREF: sub_104E6+92j
		mov	ax, 178h
		push	ax
		mov	ax, 63h	; 'c'
		jmp	short loc_105BF
; ---------------------------------------------------------------------------
		align 2

loc_1054C:				; CODE XREF: sub_104E6+4Ej
		mov	ax, 5
		push	ax
		mov	ax, 184h
		push	ax
		mov	ax, 12Ch
		push	ax
		mov	ax, 178h
		push	ax
		push	[bp+var_C]
		call	j_ClearBox
		add	sp, 0Ah
		cmp	si, 0C9h ; '�'
		jz	short loc_105C8
		mov	ax, 2
		push	ax
		mov	ax, 184h
		push	ax
		push	[bp+var_A]
		jmp	short loc_10542
; ---------------------------------------------------------------------------

loc_1057A:				; CODE XREF: sub_104E6+4Aj
		or	si, si
		jg	short loc_1058C
		mov	ax, 2
		push	ax
		mov	ax, 184h
		push	ax
		mov	ax, 153h
		push	ax
		jmp	short loc_105B8
; ---------------------------------------------------------------------------

loc_1058C:				; CODE XREF: sub_104E6+96j
		mov	ax, 5
		push	ax
		mov	ax, 184h
		push	ax
		mov	ax, 153h
		push	ax
		mov	ax, 178h
		push	ax
		push	[bp+var_8]
		call	j_ClearBox
		add	sp, 0Ah
		cmp	si, 0C9h ; '�'
		jz	short loc_105C8
		mov	ax, 2
		push	ax
		mov	ax, 184h
		push	ax
		push	[bp+var_6]

loc_105B8:				; CODE XREF: sub_104E6+A4j
		mov	ax, 178h
		push	ax
		mov	ax, 21Ch

loc_105BF:				; CODE XREF: sub_104E6+63j
		push	ax
		call	j_ClearBox
		add	sp, 0Ah

loc_105C8:				; CODE XREF: sub_104E6+85j
					; sub_104E6+C5j
		inc	di
		cmp	di, 1
		jg	short loc_105D1
		jmp	loc_10523
; ---------------------------------------------------------------------------

loc_105D1:				; CODE XREF: sub_104E6+E6j
		mov	[bp+var_4], di
		push	word ptr ds:2210h
		call	sub_262E6
		add	sp, 2
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_104E6	endp

		assume ds:seg026

; =============== S U B	R O U T	I N E =======================================


sub_105E6	proc far		; CODE XREF: sub_124FA+1p
		mov	fName_Character, offset	aAYuka ; "a:yuka"
		mov	fName_Character+2, offset aAJun	; "a:jun"
		mov	fName_Character+4, offset aAManami ; "a:manami"
		mov	fName_Character+6, offset aAChiho ; "a:chiho"
		mov	fName_Character+8, offset aAKaori ; "a:kaori"
		mov	fName_Character+0Ah, offset aAReimi ; "a:reimi"
		mov	fName_Round, offset aARound1 ; "a:round1"
		mov	fName_Round+2, offset aARound2 ; "a:round2"
		mov	fName_Round+4, offset aARound3 ; "a:round3"
		mov	fName_Round+6, offset aARound4 ; "a:round4"
		mov	fName_Round+8, offset aARound5 ; "a:round5"
		mov	fName_Round+0Ah, offset	aARound6 ; "a:round6"
		mov	fName_Round+0Ch, offset	aARound7 ; "a:round7"
		mov	fName_CharBGM, offset aBVg03 ; "b:vg03"
		mov	fName_CharBGM+2, offset	aBVg06 ; "b:vg06"
		mov	fName_CharBGM+4, offset	aBVg05 ; "b:vg05"
		mov	fName_CharBGM+6, offset	aBVg04 ; "b:vg04"
		mov	fName_CharBGM+8, offset	aBVg07 ; "b:vg07"
		mov	fName_CharBGM+0Ah, offset aBVg08 ; "b:vg08"
		mov	fName_CharBGM+0Ch, offset aBVg09 ; "b:vg09"
		mov	word_2D01C, offset aBNy1 ; "b:ny1"
		mov	word_2D01C+4, offset aBNj1 ; "b:nj1"
		mov	word_2D01C+8, offset aBNm1 ; "b:nm1"
		mov	word_2D01C+0Ch,	offset aBNc1 ; "b:nc1"
		mov	word_2D01C+10h,	offset aBNk1 ; "b:nk1"
		mov	word_2D01C+14h,	offset aDNr1 ; "d:nr1"
		mov	word_2D01C+2, offset aBNy2 ; "b:ny2"
		mov	word_2D01C+6, offset aBNj2 ; "b:nj2"
		mov	word_2D01C+0Ah,	offset aBNm2 ; "b:nm2"
		mov	word_2D01C+0Eh,	offset aBNc2 ; "b:nc2"
		mov	word_2D01C+12h,	offset aBNk2 ; "b:nk2"
		mov	word_2D01C+16h,	offset aDNr2 ; "d:nr2"
		mov	word_2D2F0, offset aDEy1 ; "d:ey1"
		mov	word_2D2F0+4, offset aDEj1 ; "d:ej1"
		mov	word_2D2F0+8, offset aDEm1 ; "d:em1"
		mov	word_2D2F0+0Ch,	offset aDEc1 ; "d:ec1"
		mov	word_2D2F0+10h,	offset aDEk1 ; "d:ek1"
		mov	word_2D2F0+14h,	offset aDEr1 ; "d:er1"
		mov	word_2D2F0+2, offset aDEy2 ; "d:ey2"
		mov	word_2D2F0+6, offset aDEj2 ; "d:ej2"
		mov	word_2D2F0+0Ah,	offset aDEm2 ; "d:em2"
		mov	word_2D2F0+0Eh,	offset aDEc2 ; "d:ec2"
		mov	word_2D2F0+12h,	offset aDEk2 ; "d:ek2"
		mov	word_2D2F0+16h,	offset aDEr2 ; "d:er2"
		retf
sub_105E6	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_106F0	proc far		; CODE XREF: sub_12472+8p
					; sub_12472+17p

var_A		= word ptr -0Ah
var_8		= word ptr -8
var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6
arg_2		= word ptr  8

		push	bp
		mov	bp, sp
		sub	sp, 0Ah
		push	si
		cmp	[bp+arg_0], 0
		jnz	short loc_10702
		mov	ax, 5
		jmp	short loc_10705
; ---------------------------------------------------------------------------

loc_10702:				; CODE XREF: sub_106F0+Bj
		mov	ax, 8

loc_10705:				; CODE XREF: sub_106F0+10j
		mov	[bp+var_4], ax
		cmp	[bp+arg_0], 0
		jnz	short loc_10714
		mov	ax, 4
		jmp	short loc_10717
; ---------------------------------------------------------------------------
		align 2

loc_10714:				; CODE XREF: sub_106F0+1Cj
		mov	ax, 7

loc_10717:				; CODE XREF: sub_106F0+21j
		mov	[bp+var_2], ax
		cmp	[bp+arg_0], 0
		jnz	short loc_10726
		mov	ax, 10h
		jmp	short loc_10729
; ---------------------------------------------------------------------------
		align 2

loc_10726:				; CODE XREF: sub_106F0+2Ej
		mov	ax, 11h

loc_10729:				; CODE XREF: sub_106F0+33j
		mov	[bp+var_A], ax
		cmp	[bp+arg_0], 0
		jnz	short loc_10738
		mov	ax, 3
		jmp	short loc_1073B
; ---------------------------------------------------------------------------
		align 2

loc_10738:				; CODE XREF: sub_106F0+40j
		mov	ax, 6

loc_1073B:				; CODE XREF: sub_106F0+45j
		mov	[bp+var_8], ax
		cmp	[bp+arg_0], 1
		jnz	short loc_10762
		mov	ax, word_2CB40
		cmp	PlayerCharID, ax
		jnz	short loc_10762
		mov	ax, word_2D3A2
		mov	word_2D3A8, ax
		mov	ax, word_2D3B8
		mov	word_2D3BA, ax
		mov	ax, word_2D3A0
		mov	word_2D3A6, ax
		jmp	short loc_107A4
; ---------------------------------------------------------------------------
		align 2

loc_10762:				; CODE XREF: sub_106F0+52j
					; sub_106F0+5Bj
		mov	si, [bp+arg_2]
		shl	si, 1
		add	si, 293Eh
		push	word ptr [si]
		call	LoadHT2
		add	sp, 2
		mov	bx, [bp+var_4]
		shl	bx, 1
		mov	[bx+29C8h], ax
		push	word ptr [si]
		call	LoadHNY
		add	sp, 2
		mov	bx, [bp+var_A]
		shl	bx, 1
		mov	[bx+29C8h], ax
		push	word ptr [si]
		call	LoadSP2
		add	sp, 2
		mov	bx, [bp+var_2]
		shl	bx, 1
		mov	[bx+29C8h], ax

loc_107A4:				; CODE XREF: sub_106F0+6Fj
		push	[bp+arg_0]
		mov	bx, [bp+var_2]
		shl	bx, 1
		mov	bx, [bx+29C8h]
		shl	bx, 1
		shl	bx, 1
		mov	dx, [bx+244Ch]
		sub	ax, ax
		mov	es, dx
		mov	bx, ax
		push	word ptr es:[bx]
		mov	bx, [bp+arg_2]
		shl	bx, 1
		push	word ptr [bx+293Eh]
		call	LoadHEM_A1
		add	sp, 6
		mov	bx, [bp+var_8]
		shl	bx, 1
		mov	[bx+29C8h], ax
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1011E
		add	sp, 2
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_106F0	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_107EA	proc far		; CODE XREF: sub_180FE+E4P
					; sub_1A626+E4P ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		mov	al, [bx+2198h]
		and	al, 10h
		cmp	al, 10h
		jnz	short loc_10809
		mov	bx, [bp+arg_0]
		shl	bx, 1
		and	byte ptr [bx+2514h], 0EFh

loc_10809:				; CODE XREF: sub_107EA+13j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		mov	al, [bx+2198h]
		and	al, 20h
		cmp	al, 20h	; ' '
		jnz	short loc_10825
		mov	bx, [bp+arg_0]
		shl	bx, 1
		and	byte ptr [bx+2514h], 0DFh

loc_10825:				; CODE XREF: sub_107EA+2Fj
		pop	bp
		retf
sub_107EA	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_10828	proc far		; CODE XREF: sub_1455A+22p
					; sub_145EA+64p ...

var_22		= word ptr -22h
var_20		= word ptr -20h
var_1E		= word ptr -1Eh
var_1C		= word ptr -1Ch
var_1A		= word ptr -1Ah
var_18		= word ptr -18h
var_16		= word ptr -16h
var_14		= word ptr -14h
var_10		= word ptr -10h
var_E		= word ptr -0Eh
var_C		= word ptr -0Ch
var_A		= word ptr -0Ah
var_8		= word ptr -8
var_6		= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6
arg_2		= word ptr  8
arg_4		= word ptr  0Ah
arg_6		= word ptr  0Ch

		push	bp
		mov	bp, sp
		sub	sp, 22h
		push	di
		push	si
		mov	[bp+var_2], 0
		mov	[bp+var_C], 0
		mov	[bp+var_A], 0
		mov	[bp+var_18], 0
		mov	[bp+var_8], 0
		mov	[bp+var_16], 0
		mov	[bp+var_14], 0
		mov	[bp+var_1A], 0
		mov	word_2D01A, 2
		cmp	[bp+arg_2], 0
		jnz	short loc_1086A
		mov	ax, 1
		jmp	short loc_1086D
; ---------------------------------------------------------------------------
		align 2

loc_1086A:				; CODE XREF: sub_10828+3Aj
		mov	ax, 2

loc_1086D:				; CODE XREF: sub_10828+3Fj
		mov	[bp+var_4], ax
		cmp	[bp+arg_2], 0
		jnz	short loc_1087C
		mov	ax, 14h
		jmp	short loc_1087F
; ---------------------------------------------------------------------------
		align 2

loc_1087C:				; CODE XREF: sub_10828+4Cj
		mov	ax, 0Ah

loc_1087F:				; CODE XREF: sub_10828+51j
		mov	[bp+var_E], ax
		call	sub_15322
		call	sub_260C5
		mov	ax, 28h	; '('
		push	ax
		call	sub_2591C
		add	sp, 2
		sub	ax, ax
		push	ax
		call	sub_262E6
		add	sp, 2
		sub	ax, ax
		push	ax
		call	sub_262D1
		add	sp, 2
		mov	ax, PlayerCharID
		cwd
		sub	ax, dx
		sar	ax, 1
		mov	[bp+var_8], ax
		mov	ax, word_2CB40
		cwd
		sub	ax, dx
		sar	ax, 1
		mov	[bp+var_14], ax
		mov	ax, PlayerCharID
		and	ax, 1
		mov	[bp+var_16], ax
		mov	ax, word_2CB40
		and	ax, 1
		mov	[bp+var_1A], ax
		call	sub_260A7
		mov	ax, 80h	; '�'
		push	ax
		call	sub_15496
		add	sp, 2
		mov	word_2D3AC, ax
		mov	ax, offset aBVg02 ; "b:vg02"
		push	ax
		call	LoadMusic	; VG02:	Character Select
		add	sp, 2
		mov	word_2D3B0, ax
		mov	ax, offset aBVgefe ; "b:vgefe"
		push	ax
		call	LoadSFX
		add	sp, 2
		mov	word_2D3AE, ax
		mov	ax, offset aASel ; "a:sel"
		push	ax
		call	LoadHNY
		add	sp, 2
		mov	word_2D3B6, ax
		mov	ax, offset aASelchr ; "a:selchr"
		push	ax
		call	LoadSP2
		add	sp, 2
		mov	word_2D3B4, ax
		sub	ax, ax
		push	ax
		mov	bx, word_2D3B4
		shl	bx, 1
		shl	bx, 1
		mov	dx, [bx+244Ch]
		mov	es, dx
		mov	bx, ax
		push	word ptr es:[bx]
		mov	ax, offset aASelchr_0 ;	"a:selchr"
		push	ax
		call	LoadHEM_A1
		add	sp, 6
		mov	word_2D3B2, ax
		cmp	word_2A9E2, 5
		jz	short loc_10998
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, 3
		push	ax
		call	sub_29701
		add	sp, 6
		sub	ax, ax
		push	ax
		mov	bx, word_2D3AE
		shl	bx, 1
		shl	bx, 1
		push	word_2CE1C[bx]
		mov	ax, 6
		push	ax
		call	sub_29701
		add	sp, 6
		sub	ax, ax
		push	ax
		mov	bx, word_2D3B0
		shl	bx, 1
		shl	bx, 1
		push	word_2CE1C[bx]
		mov	ax, 1
		push	ax
		call	sub_29701
		add	sp, 6

loc_10998:				; CODE XREF: sub_10828+128j
		sub	ax, ax
		push	ax
		mov	ax, 19h
		push	ax
		mov	ax, 50h	; 'P'
		push	ax
		sub	ax, ax
		push	ax
		push	ax
		call	sub_2630F
		add	sp, 0Ah
		cmp	[bp+arg_2], 0
		jnz	short loc_109C2
		mov	ax, 1
		push	ax
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, offset aASelkao4 ; "a:selkao4"
		jmp	short loc_109CD
; ---------------------------------------------------------------------------

loc_109C2:				; CODE XREF: sub_10828+18Bj
		mov	ax, 1
		push	ax
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, offset aASelkao6 ; "a:selkao6"

loc_109CD:				; CODE XREF: sub_10828+198j
		push	ax
		call	LoadGEM
		add	sp, 8
		mov	ax, 1F40h
		push	ax
		call	sub_15496
		add	sp, 2
		mov	word_2D398, ax
		mov	ax, 7D0h
		push	ax
		mov	bx, word_2D398
		shl	bx, 1
		shl	bx, 1
		push	word_2CE1C[bx]
		call	sub_1655C
		add	sp, 4
		sub	ax, ax
		push	ax
		call	sub_262E6
		add	sp, 2
		call	sub_16114
		mov	ax, 1
		push	ax
		call	sub_262E6
		add	sp, 2
		call	sub_16114
		sub	ax, ax
		push	ax
		call	sub_262E6
		add	sp, 2
		sub	ax, ax
		push	ax
		call	sub_262D1
		add	sp, 2
		call	sub_26089
		cmp	[bp+arg_0], 0
		jnz	short loc_10A4A
		call	sub_25C27
		mov	[bp+var_6], ax
		jmp	short loc_10A5A
; ---------------------------------------------------------------------------
		align 2

loc_10A4A:				; CODE XREF: sub_10828+215j
		call	sub_25BD0
		mov	[bp+var_6], ax
		call	sub_25B79
		mov	[bp+var_10], ax

loc_10A5A:				; CODE XREF: sub_10828+21Fj
		call	sub_26089

loc_10A5F:				; CODE XREF: sub_10828+662j
					; sub_10828+66Cj ...
		cmp	[bp+arg_4], 0
		jz	short loc_10A75
		cmp	[bp+arg_6], 0
		jz	short loc_10A75
		cmp	word_2CBE0, 1
		jz	short loc_10A75
		jmp	loc_10EBC
; ---------------------------------------------------------------------------

loc_10A75:				; CODE XREF: sub_10828+23Bj
					; sub_10828+241j ...
		cmp	[bp+arg_0], 0
		jnz	short loc_10A8A
		call	sub_25C27
		or	[bp+var_6], ax
		mov	[bp+arg_6], 1
		jmp	short loc_10A9A
; ---------------------------------------------------------------------------

loc_10A8A:				; CODE XREF: sub_10828+251j
		call	sub_25BD0
		or	[bp+var_6], ax
		call	sub_25B79
		or	[bp+var_10], ax

loc_10A9A:				; CODE XREF: sub_10828+260j
		cmp	[bp+arg_4], 0
		jz	short loc_10AA3
		jmp	loc_10B8E
; ---------------------------------------------------------------------------

loc_10AA3:				; CODE XREF: sub_10828+276j
		cmp	[bp+var_C], 0
		jz	short loc_10AAC
		jmp	loc_10B4B
; ---------------------------------------------------------------------------

loc_10AAC:				; CODE XREF: sub_10828+27Fj
		mov	ax, [bp+var_8]
		mov	[bp+var_1C], ax
		mov	ax, [bp+var_16]
		mov	[bp+var_1E], ax
		mov	al, byte ptr [bp+var_6]
		and	al, 4
		cmp	al, 4
		jnz	short loc_10ACC
		cmp	[bp+var_8], 0
		jle	short loc_10ACC
		mov	ax, 1
		jmp	short loc_10ACE
; ---------------------------------------------------------------------------

loc_10ACC:				; CODE XREF: sub_10828+297j
					; sub_10828+29Dj
		sub	ax, ax

loc_10ACE:				; CODE XREF: sub_10828+2A2j
		mov	cl, byte ptr [bp+var_6]
		and	cl, 8
		mov	si, ax
		cmp	cl, 8
		jnz	short loc_10AE8
		mov	ax, [bp+var_4]
		cmp	[bp+var_8], ax
		jge	short loc_10AE8
		mov	ax, 1
		jmp	short loc_10AEA
; ---------------------------------------------------------------------------

loc_10AE8:				; CODE XREF: sub_10828+2B1j
					; sub_10828+2B9j
		sub	ax, ax

loc_10AEA:				; CODE XREF: sub_10828+2BEj
		sub	ax, si
		add	ax, [bp+var_8]
		mov	[bp+var_8], ax
		mov	al, byte ptr [bp+var_6]
		and	al, 1
		cmp	al, 1
		jnz	short loc_10B06
		cmp	[bp+var_16], 0
		jle	short loc_10B06
		mov	ax, 1
		jmp	short loc_10B08
; ---------------------------------------------------------------------------

loc_10B06:				; CODE XREF: sub_10828+2D1j
					; sub_10828+2D7j
		sub	ax, ax

loc_10B08:				; CODE XREF: sub_10828+2DCj
		mov	cl, byte ptr [bp+var_6]
		and	cl, 2
		mov	si, ax
		cmp	cl, 2
		jnz	short loc_10B20
		cmp	[bp+var_16], 1
		jge	short loc_10B20
		mov	ax, 1
		jmp	short loc_10B22
; ---------------------------------------------------------------------------

loc_10B20:				; CODE XREF: sub_10828+2EBj
					; sub_10828+2F1j
		sub	ax, ax

loc_10B22:				; CODE XREF: sub_10828+2F6j
		sub	ax, si
		add	ax, [bp+var_16]
		mov	[bp+var_16], ax
		mov	[bp+var_C], 1
		mov	ax, [bp+var_8]
		cmp	[bp+var_1C], ax
		jnz	short loc_10B3F
		mov	ax, [bp+var_16]
		cmp	[bp+var_1E], ax
		jz	short loc_10B4B

loc_10B3F:				; CODE XREF: sub_10828+30Dj
		mov	ax, 16h
		push	ax
		call	sub_15BEE
		add	sp, 2

loc_10B4B:				; CODE XREF: sub_10828+281j
					; sub_10828+315j
		mov	al, byte ptr [bp+var_6]
		and	al, 10h
		cmp	al, 10h
		jnz	short loc_10B80
		cmp	[bp+var_2], 0
		jnz	short loc_10B80
		mov	[bp+arg_4], 1
		mov	ax, [bp+var_8]
		shl	ax, 1
		add	ax, [bp+var_16]
		push	ax
		mov	ax, 2
		push	ax
		call	sub_15C20
		add	sp, 4
		mov	ax, 17h
		push	ax
		call	sub_15BEE
		add	sp, 2

loc_10B80:				; CODE XREF: sub_10828+32Aj
					; sub_10828+330j
		mov	ax, [bp+var_8]
		shl	ax, 1
		add	ax, [bp+var_16]
		mov	PlayerCharID, ax
		jmp	short loc_10BAE
; ---------------------------------------------------------------------------
		align 2

loc_10B8E:				; CODE XREF: sub_10828+278j
		mov	al, byte ptr [bp+var_6]
		and	al, 20h
		cmp	al, 20h	; ' '
		jnz	short loc_10BAE
		cmp	[bp+var_2], 0
		jnz	short loc_10BAE
		mov	[bp+arg_4], 0
		mov	ax, 18h
		push	ax
		call	sub_15BEE
		add	sp, 2

loc_10BAE:				; CODE XREF: sub_10828+363j
					; sub_10828+36Dj ...
		test	byte ptr [bp+var_6], 30h
		jnz	short loc_10BB9
		mov	[bp+var_2], 0

loc_10BB9:				; CODE XREF: sub_10828+38Aj
		test	byte ptr [bp+var_6], 0Fh
		jnz	short loc_10BC4
		mov	[bp+var_C], 0

loc_10BC4:				; CODE XREF: sub_10828+395j
		cmp	[bp+arg_0], 0
		jnz	short loc_10BCD
		jmp	loc_10CF8
; ---------------------------------------------------------------------------

loc_10BCD:				; CODE XREF: sub_10828+3A0j
		cmp	[bp+arg_6], 0
		jz	short loc_10BD6
		jmp	loc_10CC2
; ---------------------------------------------------------------------------

loc_10BD6:				; CODE XREF: sub_10828+3A9j
		cmp	[bp+var_18], 0
		jz	short loc_10BDF
		jmp	loc_10C7F
; ---------------------------------------------------------------------------

loc_10BDF:				; CODE XREF: sub_10828+3B2j
		mov	ax, [bp+var_14]
		mov	[bp+var_20], ax
		mov	ax, [bp+var_1A]
		mov	[bp+var_22], ax
		mov	al, byte ptr [bp+var_10]
		and	al, 4
		cmp	al, 4
		jnz	short loc_10C00
		cmp	[bp+var_14], 0
		jle	short loc_10C00
		mov	ax, 1
		jmp	short loc_10C02
; ---------------------------------------------------------------------------
		align 2

loc_10C00:				; CODE XREF: sub_10828+3CAj
					; sub_10828+3D0j
		sub	ax, ax

loc_10C02:				; CODE XREF: sub_10828+3D5j
		mov	cl, byte ptr [bp+var_10]
		and	cl, 8
		mov	si, ax
		cmp	cl, 8
		jnz	short loc_10C1C
		mov	ax, [bp+var_4]
		cmp	[bp+var_14], ax
		jge	short loc_10C1C
		mov	ax, 1
		jmp	short loc_10C1E
; ---------------------------------------------------------------------------

loc_10C1C:				; CODE XREF: sub_10828+3E5j
					; sub_10828+3EDj
		sub	ax, ax

loc_10C1E:				; CODE XREF: sub_10828+3F2j
		sub	ax, si
		add	ax, [bp+var_14]
		mov	[bp+var_14], ax
		mov	al, byte ptr [bp+var_10]
		and	al, 1
		cmp	al, 1
		jnz	short loc_10C3A
		cmp	[bp+var_1A], 0
		jle	short loc_10C3A
		mov	ax, 1
		jmp	short loc_10C3C
; ---------------------------------------------------------------------------

loc_10C3A:				; CODE XREF: sub_10828+405j
					; sub_10828+40Bj
		sub	ax, ax

loc_10C3C:				; CODE XREF: sub_10828+410j
		mov	cl, byte ptr [bp+var_10]
		and	cl, 2
		mov	si, ax
		cmp	cl, 2
		jnz	short loc_10C54
		cmp	[bp+var_1A], 1
		jge	short loc_10C54
		mov	ax, 1
		jmp	short loc_10C56
; ---------------------------------------------------------------------------

loc_10C54:				; CODE XREF: sub_10828+41Fj
					; sub_10828+425j
		sub	ax, ax

loc_10C56:				; CODE XREF: sub_10828+42Aj
		sub	ax, si
		add	ax, [bp+var_1A]
		mov	[bp+var_1A], ax
		mov	[bp+var_18], 1
		mov	ax, [bp+var_14]
		cmp	[bp+var_20], ax
		jnz	short loc_10C73
		mov	ax, [bp+var_1A]
		cmp	[bp+var_22], ax
		jz	short loc_10C7F

loc_10C73:				; CODE XREF: sub_10828+441j
		mov	ax, 16h
		push	ax
		call	sub_15BEE
		add	sp, 2

loc_10C7F:				; CODE XREF: sub_10828+3B4j
					; sub_10828+449j
		mov	al, byte ptr [bp+var_10]
		and	al, 10h
		cmp	al, 10h
		jnz	short loc_10CB4
		cmp	[bp+var_A], 0
		jnz	short loc_10CB4
		mov	[bp+arg_6], 1
		mov	ax, [bp+var_14]
		shl	ax, 1
		add	ax, [bp+var_1A]
		push	ax
		mov	ax, 2
		push	ax
		call	sub_15C20
		add	sp, 4
		mov	ax, 17h
		push	ax
		call	sub_15BEE
		add	sp, 2

loc_10CB4:				; CODE XREF: sub_10828+45Ej
					; sub_10828+464j
		mov	ax, [bp+var_14]
		shl	ax, 1
		add	ax, [bp+var_1A]
		mov	word_2CB40, ax
		jmp	short loc_10CE2
; ---------------------------------------------------------------------------
		align 2

loc_10CC2:				; CODE XREF: sub_10828+3ABj
		mov	al, byte ptr [bp+var_10]
		and	al, 20h
		cmp	al, 20h	; ' '
		jnz	short loc_10CE2
		cmp	[bp+var_A], 0
		jnz	short loc_10CE2
		mov	[bp+arg_6], 0
		mov	ax, 18h
		push	ax
		call	sub_15BEE
		add	sp, 2

loc_10CE2:				; CODE XREF: sub_10828+497j
					; sub_10828+4A1j ...
		test	byte ptr [bp+var_10], 30h
		jnz	short loc_10CED
		mov	[bp+var_A], 0

loc_10CED:				; CODE XREF: sub_10828+4BEj
		test	byte ptr [bp+var_10], 0Fh
		jnz	short loc_10CF8
		mov	[bp+var_18], 0

loc_10CF8:				; CODE XREF: sub_10828+3A2j
					; sub_10828+4C9j
		cmp	[bp+arg_0], 0
		jnz	short loc_10D01
		jmp	loc_10D95
; ---------------------------------------------------------------------------

loc_10D01:				; CODE XREF: sub_10828+4D4j
		mov	ax, [bp+var_14]
		imul	[bp+var_E]
		mov	si, ax
		add	si, 0Ah
		mov	ax, 0A8h ; '�'
		imul	[bp+var_1A]
		mov	di, ax
		add	di, 0C0h ; '�'
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, 8
		push	ax
		mov	ax, 0Eh
		push	ax
		mov	ax, 0Dh
		push	ax
		push	di
		push	si
		call	sub_16BFC
		add	sp, 0Eh
		sub	ax, ax
		push	ax
		push	ax
		push	word_2CB40
		mov	ax, 0Eh
		push	ax
		mov	ax, 0Dh
		push	ax
		mov	ax, 118h
		push	ax
		mov	ax, 22h	; '"'
		push	ax
		call	sub_16BFC
		add	sp, 0Eh
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, word_2CB40
		add	ax, 0Ch
		push	ax
		mov	ax, 0Eh
		push	ax
		mov	ax, 0Dh
		push	ax
		push	di
		push	si
		call	sub_16BFC
		add	sp, 0Eh
		cmp	[bp+arg_6], 0
		jz	short loc_10D95
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, 13h
		push	ax
		mov	ax, 0Eh
		push	ax
		mov	ax, 0Dh
		push	ax
		mov	ax, 118h
		push	ax
		mov	ax, 22h	; '"'
		push	ax
		call	sub_16BFC
		add	sp, 0Eh

loc_10D95:				; CODE XREF: sub_10828+4D6j
					; sub_10828+54Bj
		mov	ax, [bp+var_8]
		imul	[bp+var_E]
		mov	si, ax
		add	si, 0Ah
		mov	ax, 0A8h ; '�'
		imul	[bp+var_16]
		mov	di, ax
		add	di, 0C0h ; '�'
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, 6
		push	ax
		mov	ax, 0Eh
		push	ax
		mov	ax, 0Dh
		push	ax
		push	di
		push	si
		call	sub_16BFC
		add	sp, 0Eh
		sub	ax, ax
		push	ax
		push	ax
		push	PlayerCharID
		mov	ax, 0Eh
		push	ax
		mov	ax, 0Dh
		push	ax
		mov	ax, 118h
		push	ax
		sub	ax, ax
		push	ax
		call	sub_16BFC
		add	sp, 0Eh
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, PlayerCharID
		add	ax, 0Ch
		push	ax
		mov	ax, 0Eh
		push	ax
		mov	ax, 0Dh
		push	ax
		push	di
		push	si
		call	sub_16BFC
		add	sp, 0Eh
		cmp	[bp+arg_4], 0
		jz	short loc_10E27
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, 13h
		push	ax
		mov	ax, 0Eh
		push	ax
		mov	ax, 0Dh
		push	ax
		mov	ax, 118h
		push	ax
		sub	ax, ax
		push	ax
		call	sub_16BFC
		add	sp, 0Eh

loc_10E27:				; CODE XREF: sub_10828+5DEj
		cmp	word_2CBE0, 1
		sbb	ax, ax
		neg	ax
		mov	word_2CBE0, ax
		push	ax
		call	sub_262E6
		add	sp, 2
		call	sub_162AE
		call	sub_16D2E
		cmp	[bp+arg_0], 0
		jnz	short loc_10E56
		call	sub_25C27
		mov	[bp+var_6], ax
		jmp	short loc_10E66
; ---------------------------------------------------------------------------

loc_10E56:				; CODE XREF: sub_10828+622j
		call	sub_25BD0
		mov	[bp+var_6], ax
		call	sub_25B79
		mov	[bp+var_10], ax

loc_10E66:				; CODE XREF: sub_10828+62Cj
		call	sub_25C47
		mov	word_2D30C, 0
		inc	word_2D400
		push	word_2CBE0
		call	sub_262D1
		add	sp, 2
		call	sub_29798
		or	ax, ax
		jz	short loc_10E8D
		jmp	loc_10A5F
; ---------------------------------------------------------------------------

loc_10E8D:				; CODE XREF: sub_10828+660j
		cmp	word_2A9F2, 1
		jz	short loc_10E97
		jmp	loc_10A5F
; ---------------------------------------------------------------------------

loc_10E97:				; CODE XREF: sub_10828+66Aj
		mov	al, byte ptr word_2CB42
		and	al, 1
		cmp	al, 1
		jz	short loc_10EA3
		jmp	loc_10A5F
; ---------------------------------------------------------------------------

loc_10EA3:				; CODE XREF: sub_10828+676j
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, 1Ah
		push	ax
		call	sub_29701
		add	sp, 6
		mov	word_2A9F2, 0
		jmp	loc_10A5F
; ---------------------------------------------------------------------------

loc_10EBC:				; CODE XREF: sub_10828+24Aj
		push	cs
		call	near ptr sub_100F6
		mov	al, byte ptr word_2CB42
		and	al, 1
		cmp	al, 1
		jnz	short loc_10ED9
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, 1Ah
		push	ax
		call	sub_29701
		add	sp, 6

loc_10ED9:				; CODE XREF: sub_10828+69Fj
		push	cs
		call	near ptr sub_1004E
		mov	word_2A9F2, 0
		call	sub_1548C
		sub	ax, ax
		push	ax
		call	sub_262D1
		add	sp, 2
		mov	ax, 1
		push	ax
		call	sub_262E6
		add	sp, 2
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_10828	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_10F06	proc far		; CODE XREF: sub_1507C+18Dp

var_C		= word ptr -0Ch
var_8		= word ptr -8
var_6		= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2

		push	bp
		mov	bp, sp
		sub	sp, 0Ch
		push	si
		mov	[bp+var_4], 0
		mov	[bp+var_2], 0
		mov	[bp+var_8], 0
		mov	[bp+var_C], 0
		mov	word_2D01A, 2
		call	sub_15322
		call	sub_260C5
		mov	ax, 28h	; '('
		push	ax
		call	sub_2591C
		add	sp, 2
		sub	ax, ax
		push	ax
		call	sub_262E6
		add	sp, 2
		call	sub_260A7
		mov	ax, 80h	; '�'
		push	ax
		call	sub_15496
		add	sp, 2
		mov	word_2D3AC, ax
		mov	ax, offset aATitlec ; "a:titlec"
		push	ax
		call	LoadSP2
		add	sp, 2
		mov	word_2D3B4, ax
		sub	ax, ax
		push	ax
		mov	bx, word_2D3B4
		shl	bx, 1
		shl	bx, 1
		mov	dx, word_2CE1C[bx]
		mov	es, dx
		mov	bx, ax
		push	word ptr es:[bx]
		mov	ax, offset aATitlec_0 ;	"a:titlec"
		push	ax
		call	LoadHEM_A1
		add	sp, 6
		mov	word_2D3B2, ax
		sub	ax, ax
		push	ax
		mov	ax, 19h
		push	ax
		mov	ax, 50h	; 'P'
		push	ax
		sub	ax, ax
		push	ax
		push	ax
		call	sub_2630F
		add	sp, 0Ah
		mov	ax, 1
		push	ax
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, offset aATitle ; "a:title"
		push	ax
		call	LoadGEM
		add	sp, 8
		mov	ax, 8000
		push	ax
		call	sub_15496
		add	sp, 2
		mov	word_2D398, ax
		mov	ax, 2000
		push	ax
		mov	bx, word_2D398
		shl	bx, 1
		shl	bx, 1
		push	word_2CE1C[bx]
		call	sub_1655C
		add	sp, 4
		sub	ax, ax
		push	ax
		call	sub_262E6
		add	sp, 2
		call	sub_16114
		mov	ax, 1
		push	ax
		call	sub_262E6
		add	sp, 2
		call	sub_16114
		sub	ax, ax
		push	ax
		call	sub_262E6
		add	sp, 2
		sub	ax, ax
		push	ax
		call	sub_262D1
		add	sp, 2
		call	sub_26089
		call	sub_25C27
		mov	[bp+var_6], ax
		call	sub_26089
		cmp	word_2A9E0, 0
		jnz	short loc_11044
		cmp	word_2CBDE, 0
		jz	short loc_1103C
		jmp	loc_111EC
; ---------------------------------------------------------------------------

loc_1103C:				; CODE XREF: sub_10F06+131j
		sub	ax, ax
		push	ax
		push	ax
		jmp	loc_111F6
; ---------------------------------------------------------------------------
		align 2

loc_11044:				; CODE XREF: sub_10F06+12Aj
		cmp	word_2CBDE, 0
		jnz	short loc_1104E
		jmp	loc_111EC
; ---------------------------------------------------------------------------

loc_1104E:				; CODE XREF: sub_10F06+143j
					; sub_10F06+2E3j
		mov	ax, 5
		push	ax
		jmp	loc_111F3
; ---------------------------------------------------------------------------
		align 2

loc_11056:				; CODE XREF: sub_10F06+303j
		call	sub_1525A
		call	sub_25C27
		or	[bp+var_6], ax
		test	byte ptr [bp+var_6], 0Fh
		jz	short loc_110AD
		cmp	[bp+var_8], 0
		jnz	short loc_110AD
		mov	al, byte ptr [bp+var_6]
		and	al, 1
		cmp	al, 1
		jnz	short loc_11084
		cmp	[bp+var_C], 0
		jle	short loc_11084
		mov	ax, 1
		jmp	short loc_11086
; ---------------------------------------------------------------------------
		align 2

loc_11084:				; CODE XREF: sub_10F06+170j
					; sub_10F06+176j
		sub	ax, ax

loc_11086:				; CODE XREF: sub_10F06+17Bj
		mov	cl, byte ptr [bp+var_6]
		and	cl, 2
		mov	si, ax
		cmp	cl, 2
		jnz	short loc_1109E
		cmp	[bp+var_C], 3
		jge	short loc_1109E
		mov	ax, 1
		jmp	short loc_110A0
; ---------------------------------------------------------------------------

loc_1109E:				; CODE XREF: sub_10F06+18Bj
					; sub_10F06+191j
		sub	ax, ax

loc_110A0:				; CODE XREF: sub_10F06+196j
		sub	ax, si
		add	ax, [bp+var_C]
		mov	[bp+var_C], ax
		mov	[bp+var_8], 1

loc_110AD:				; CODE XREF: sub_10F06+161j
					; sub_10F06+167j
		mov	al, byte ptr [bp+var_6]
		and	al, 10h
		cmp	al, 10h
		jnz	short loc_110C1
		cmp	[bp+var_2], 0
		jnz	short loc_110C1
		mov	[bp+var_4], 1

loc_110C1:				; CODE XREF: sub_10F06+1AEj
					; sub_10F06+1B4j
		test	byte ptr [bp+var_6], 0Fh
		jnz	short loc_110CC
		mov	[bp+var_8], 0

loc_110CC:				; CODE XREF: sub_10F06+1BFj
		sub	ax, ax
		push	ax
		push	ax
		push	[bp+var_C]
		mov	ax, 0Eh
		push	ax
		mov	ax, 0Dh
		push	ax
		mov	ax, 110h
		push	ax
		mov	ax, 4
		push	ax
		call	sub_16BFC
		add	sp, 0Eh
		cmp	word_2CBE0, 1
		sbb	ax, ax
		neg	ax
		mov	word_2CBE0, ax
		push	ax
		call	sub_262E6
		add	sp, 2
		call	sub_162AE
		call	sub_16D2E
		call	sub_25C27
		mov	[bp+var_6], ax
		call	sub_25C47
		mov	word_2D30C, 0
		inc	word_2D400
		push	word_2CBE0
		call	sub_262D1
		add	sp, 2
		call	sub_25C60
		and	al, 3Ch
		cmp	al, 3Ch	; '<'
		jnz	short loc_11161
		mov	word_2A9E0, 0
		cmp	word_2CBDE, 1
		jnz	short loc_1114E
		mov	ax, 2
		push	ax
		mov	ax, 3
		jmp	short loc_11151
; ---------------------------------------------------------------------------

loc_1114E:				; CODE XREF: sub_10F06+23Dj
		sub	ax, ax
		push	ax

loc_11151:				; CODE XREF: sub_10F06+246j
		push	ax
		sub	ax, ax
		push	ax
		mov	ax, 9
		push	ax
		call	SetPalColor
		add	sp, 8

loc_11161:				; CODE XREF: sub_10F06+230j
		call	sub_25C60
		and	ax, 0E20h
		cmp	ax, 0E20h
		jnz	short loc_11199
		mov	word_2A9E0, 1
		cmp	word_2CBDE, 1
		jnz	short loc_11182
		mov	ax, 5
		push	ax
		jmp	short loc_11189
; ---------------------------------------------------------------------------
		align 2

loc_11182:				; CODE XREF: sub_10F06+273j
		mov	ax, 3
		push	ax
		mov	ax, 2

loc_11189:				; CODE XREF: sub_10F06+279j
		push	ax
		sub	ax, ax
		push	ax
		mov	ax, 9
		push	ax
		call	SetPalColor
		add	sp, 8

loc_11199:				; CODE XREF: sub_10F06+266j
		call	sub_25C60
		and	ax, 428h
		cmp	ax, 428h
		jnz	short loc_111CF
		mov	word_2CBDE, 0
		cmp	word_2A9E0, 1
		jnz	short loc_111BC
		mov	ax, 3
		push	ax
		mov	ax, 2
		jmp	short loc_111BF
; ---------------------------------------------------------------------------

loc_111BC:				; CODE XREF: sub_10F06+2ABj
		sub	ax, ax
		push	ax

loc_111BF:				; CODE XREF: sub_10F06+2B4j
		push	ax
		sub	ax, ax
		push	ax
		mov	ax, 9
		push	ax
		call	SetPalColor
		add	sp, 8

loc_111CF:				; CODE XREF: sub_10F06+29Ej
		call	sub_25C60
		and	ax, 2030h
		cmp	ax, 2030h
		jnz	short loc_11203
		mov	word_2CBDE, 1
		cmp	word_2A9E0, 1
		jnz	short loc_111EC
		jmp	loc_1104E
; ---------------------------------------------------------------------------

loc_111EC:				; CODE XREF: sub_10F06+133j
					; sub_10F06+145j ...
		mov	ax, 2
		push	ax
		mov	ax, 3

loc_111F3:				; CODE XREF: sub_10F06+14Cj
		push	ax
		sub	ax, ax

loc_111F6:				; CODE XREF: sub_10F06+13Aj
		push	ax
		mov	ax, 9
		push	ax
		call	SetPalColor
		add	sp, 8

loc_11203:				; CODE XREF: sub_10F06+2D4j
		cmp	[bp+var_4], 0
		jnz	short loc_1120C
		jmp	loc_11056
; ---------------------------------------------------------------------------

loc_1120C:				; CODE XREF: sub_10F06+301j
		call	sub_1548C
		sub	ax, ax
		push	ax
		call	sub_262D1
		add	sp, 2
		mov	ax, 1
		push	ax
		call	sub_262E6
		add	sp, 2
		mov	ax, [bp+var_C]
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_10F06	endp


; =============== S U B	R O U T	I N E =======================================


sub_11230	proc far		; CODE XREF: sub_141D0+5Ep
		call	sub_15700
		mov	ax, 50h	; 'P'
		push	ax
		call	sub_2591C
		add	sp, 2
		cmp	word_2A9E0, 0
		jnz	short loc_11250
		call	sub_2617F
		jmp	short loc_11255
; ---------------------------------------------------------------------------
		align 2

loc_11250:				; CODE XREF: sub_11230+16j
		call	sub_26228

loc_11255:				; CODE XREF: sub_11230+1Dj
		sub	ax, ax
		push	ax
		call	sub_262E6
		add	sp, 2
		call	sub_26403
		call	sub_16078
		mov	ax, 1
		push	ax
		call	sub_262E6
		add	sp, 2
		call	sub_26403
		call	sub_16078
		sub	ax, ax
		push	ax
		call	sub_262E6
		add	sp, 2
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, 6
		push	ax
		mov	ax, 2
		push	ax
		mov	ax, 1
		push	ax
		mov	ax, 0C0h ; '�'
		push	ax
		mov	ax, 6
		push	ax
		call	sub_16BFC
		add	sp, 0Eh
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, 6
		push	ax
		mov	ax, 2
		push	ax
		mov	ax, 1
		push	ax
		mov	ax, 0C0h ; '�'
		push	ax
		mov	ax, 15h
		push	ax
		call	sub_16BFC
		add	sp, 0Eh
		cmp	word_2A9E0, 0
		jnz	short loc_11312
		sub	ax, ax
		push	ax
		push	ax
		push	PlayerCharID
		mov	ax, 2
		push	ax
		mov	ax, 1
		push	ax
		mov	ax, 0C0h ; '�'
		push	ax
		mov	ax, 4
		push	ax
		call	sub_16BFC
		add	sp, 0Eh
		sub	ax, ax
		push	ax
		push	ax
		push	word_2CB40
		mov	ax, 2
		push	ax
		mov	ax, 1
		push	ax
		mov	ax, 0C0h ; '�'
		push	ax
		mov	ax, 24h	; '$'
		push	ax
		call	sub_16BFC
		add	sp, 0Eh

loc_11312:				; CODE XREF: sub_11230+A0j
		call	sub_16C56
		mov	ax, 1
		push	ax
		call	sub_262E6
		add	sp, 2
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, 6
		push	ax
		mov	ax, 2
		push	ax
		mov	ax, 1
		push	ax
		mov	ax, 0C0h ; '�'
		push	ax
		mov	ax, 6
		push	ax
		call	sub_16BFC
		add	sp, 0Eh
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, 6
		push	ax
		mov	ax, 2
		push	ax
		mov	ax, 1
		push	ax
		mov	ax, 0C0h ; '�'
		push	ax
		mov	ax, 15h
		push	ax
		call	sub_16BFC
		add	sp, 0Eh
		cmp	word_2A9E0, 0
		jnz	short loc_113AA
		sub	ax, ax
		push	ax
		push	ax
		push	PlayerCharID
		mov	ax, 2
		push	ax
		mov	ax, 1
		push	ax
		mov	ax, 0C0h ; '�'
		push	ax
		mov	ax, 4
		push	ax
		call	sub_16BFC
		add	sp, 0Eh
		sub	ax, ax
		push	ax
		push	ax
		push	word_2CB40
		mov	ax, 2
		push	ax
		mov	ax, 1
		push	ax
		mov	ax, 0C0h ; '�'
		push	ax
		mov	ax, 24h	; '$'
		push	ax
		call	sub_16BFC
		add	sp, 0Eh

loc_113AA:				; CODE XREF: sub_11230+138j
		call	sub_16C56
		mov	ax, word_2A9F0
		add	ax, 2
		mov	word_2D01A, ax
		mov	word_2CEE8, 63h	; 'c'
		mov	word_2CB44, 0Bh
		mov	word_2A9DC, 14h
		mov	word_2D37C, 0
		mov	word_2D014, 0
		sub	ax, ax
		push	ax
		mov	bx, PlayerCharID
		shl	bx, 1
		shl	bx, 1
		call	off_2ACCE[bx]
		add	sp, 2
		mov	ax, 1
		push	ax
		mov	bx, word_2CB40
		shl	bx, 1
		shl	bx, 1
		call	off_2ACCE[bx]
		add	sp, 2
		cmp	word_2A9E0, 0
		jnz	short loc_1142A
		mov	ax, 1
		push	ax
		mov	ax, 19h
		push	ax
		mov	ax, 50h	; 'P'
		push	ax
		sub	ax, ax
		push	ax
		push	ax
		call	sub_2630F
		add	sp, 0Ah
		sub	ax, ax
		push	ax
		mov	ax, 17h
		push	ax
		mov	ax, 4Ch	; 'L'
		push	ax
		mov	ax, 1
		jmp	short loc_1144F
; ---------------------------------------------------------------------------

loc_1142A:				; CODE XREF: sub_11230+1D0j
		mov	ax, 1
		push	ax
		mov	ax, 19h
		push	ax
		mov	ax, 50h	; 'P'
		push	ax
		sub	ax, ax
		push	ax
		push	ax
		call	sub_2630F
		add	sp, 0Ah
		sub	ax, ax
		push	ax
		mov	ax, 19h
		push	ax
		mov	ax, 4Ch	; 'L'
		push	ax
		sub	ax, ax

loc_1144F:				; CODE XREF: sub_11230+1F8j
		push	ax
		mov	ax, 2
		push	ax
		call	sub_2630F
		add	sp, 0Ah
		call	sub_2606B
		retf
sub_11230	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_11462	proc far		; CODE XREF: sub_1507C+1B3p

var_E		= word ptr -0Eh
var_A		= word ptr -0Ah
var_8		= word ptr -8
var_6		= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2

		push	bp
		mov	bp, sp
		sub	sp, 10h
		push	si
		mov	[bp+var_6], 0
		mov	[bp+var_4], 0
		mov	[bp+var_A], 0
		mov	[bp+var_E], 0
		mov	word_2D01A, 2
		mov	ax, word_2A9E2
		mov	[bp+var_2], ax
		call	sub_15322
		call	sub_260C5
		mov	ax, 28h	; '('
		push	ax
		call	sub_2591C
		add	sp, 2
		sub	ax, ax
		push	ax
		call	sub_262E6
		add	sp, 2
		sub	ax, ax
		push	ax
		call	sub_262D1
		add	sp, 2
		call	sub_260A7
		mov	ax, 80h	; '�'
		push	ax
		call	sub_15496
		add	sp, 2
		mov	word_2D3AC, ax
		mov	ax, offset aAConfigc ; "a:configc"
		push	ax
		call	LoadSP2
		add	sp, 2
		mov	word_2D3B4, ax
		sub	ax, ax
		push	ax
		mov	bx, word_2D3B4
		shl	bx, 1
		shl	bx, 1
		mov	dx, word_2CE1C[bx]
		mov	es, dx
		mov	bx, ax
		push	word ptr es:[bx]
		mov	ax, offset aAConfigc_0 ; "a:configc"
		push	ax
		call	LoadHEM_A1
		add	sp, 6
		mov	word_2D3B2, ax
		sub	ax, ax
		push	ax
		mov	ax, 19h
		push	ax
		mov	ax, 50h	; 'P'
		push	ax
		sub	ax, ax
		push	ax
		push	ax
		call	sub_2630F
		add	sp, 0Ah
		mov	ax, 1
		push	ax
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, offset aAConfig ; "a:config"
		push	ax
		call	LoadGEM
		add	sp, 8
		mov	ax, 8000
		push	ax
		call	sub_15496
		add	sp, 2
		mov	word_2D398, ax
		mov	ax, 2000
		push	ax
		mov	bx, word_2D398
		shl	bx, 1
		shl	bx, 1
		push	word_2CE1C[bx]
		call	sub_1655C
		add	sp, 4
		sub	ax, ax
		push	ax
		call	sub_262E6
		add	sp, 2
		call	sub_16114
		mov	ax, 1
		push	ax
		call	sub_262E6
		add	sp, 2
		call	sub_16114
		sub	ax, ax
		push	ax
		call	sub_262E6
		add	sp, 2
		sub	ax, ax
		push	ax
		call	sub_262D1
		add	sp, 2
		call	sub_26089
		call	sub_25C27
		mov	[bp+var_8], ax
		call	sub_26089

loc_11598:				; CODE XREF: sub_11462+361j
		cmp	[bp+var_6], 0
		jz	short loc_115A1
		jmp	loc_11930
; ---------------------------------------------------------------------------

loc_115A1:				; CODE XREF: sub_11462+13Aj
		call	sub_25C27
		or	[bp+var_8], ax
		test	byte ptr [bp+var_8], 0Fh
		jnz	short loc_115B2
		jmp	loc_11664
; ---------------------------------------------------------------------------

loc_115B2:				; CODE XREF: sub_11462+14Bj
		cmp	[bp+var_A], 0
		jz	short loc_115BB
		jmp	loc_11664
; ---------------------------------------------------------------------------

loc_115BB:				; CODE XREF: sub_11462+154j
		mov	al, byte ptr [bp+var_8]
		and	al, 1
		cmp	al, 1
		jnz	short loc_115D0
		cmp	[bp+var_E], 0
		jle	short loc_115D0
		mov	ax, 1
		jmp	short loc_115D2
; ---------------------------------------------------------------------------
		align 2

loc_115D0:				; CODE XREF: sub_11462+160j
					; sub_11462+166j
		sub	ax, ax

loc_115D2:				; CODE XREF: sub_11462+16Bj
		mov	cl, byte ptr [bp+var_8]
		and	cl, 2
		mov	si, ax
		cmp	cl, 2
		jnz	short loc_115EA
		cmp	[bp+var_E], 6
		jge	short loc_115EA
		mov	ax, 1
		jmp	short loc_115EC
; ---------------------------------------------------------------------------

loc_115EA:				; CODE XREF: sub_11462+17Bj
					; sub_11462+181j
		sub	ax, ax

loc_115EC:				; CODE XREF: sub_11462+186j
		sub	ax, si
		add	ax, [bp+var_E]
		mov	[bp+var_E], ax
		or	ax, ax
		jz	short loc_11622
		cmp	ax, 1
		jnz	short loc_11600
		jmp	loc_117C6
; ---------------------------------------------------------------------------

loc_11600:				; CODE XREF: sub_11462+199j
		cmp	ax, 2
		jnz	short loc_11608
		jmp	loc_11806
; ---------------------------------------------------------------------------

loc_11608:				; CODE XREF: sub_11462+1A1j
		cmp	ax, 3
		jnz	short loc_11610
		jmp	loc_11846
; ---------------------------------------------------------------------------

loc_11610:				; CODE XREF: sub_11462+1A9j
		cmp	ax, 4
		jnz	short loc_11618
		jmp	loc_11890
; ---------------------------------------------------------------------------

loc_11618:				; CODE XREF: sub_11462+1B1j
		cmp	ax, 5
		jnz	short loc_11620
		jmp	loc_118F0
; ---------------------------------------------------------------------------

loc_11620:				; CODE XREF: sub_11462+1B9j
		jmp	short loc_1165F
; ---------------------------------------------------------------------------

loc_11622:				; CODE XREF: sub_11462+194j
		mov	al, byte ptr [bp+var_8]
		and	al, 4
		cmp	al, 4
		jnz	short loc_11638
		cmp	word_2A9F4, 1
		jle	short loc_11638
		mov	ax, 1
		jmp	short loc_1163A
; ---------------------------------------------------------------------------
		align 2

loc_11638:				; CODE XREF: sub_11462+1C7j
					; sub_11462+1CEj
		sub	ax, ax

loc_1163A:				; CODE XREF: sub_11462+1D3j
		mov	cl, byte ptr [bp+var_8]
		and	cl, 8
		mov	si, ax
		cmp	cl, 8
		jnz	short loc_11654
		cmp	word_2A9F4, 8
		jge	short loc_11654
		mov	ax, 1
		jmp	short loc_11656
; ---------------------------------------------------------------------------
		align 2

loc_11654:				; CODE XREF: sub_11462+1E3j
					; sub_11462+1EAj
		sub	ax, ax

loc_11656:				; CODE XREF: sub_11462+1EFj
		sub	ax, si
		add	ax, word_2A9F4
		mov	word_2A9F4, ax

loc_1165F:				; CODE XREF: sub_11462:loc_11620j
					; sub_11462+3A1j ...
		mov	[bp+var_A], 1

loc_11664:				; CODE XREF: sub_11462+14Dj
					; sub_11462+156j
		mov	al, byte ptr [bp+var_8]
		and	al, 10h
		cmp	al, 10h
		jnz	short loc_1167E
		cmp	[bp+var_4], 0
		jnz	short loc_1167E
		cmp	[bp+var_E], 6
		jnz	short loc_1167E
		mov	[bp+var_6], 1

loc_1167E:				; CODE XREF: sub_11462+209j
					; sub_11462+20Fj ...
		test	byte ptr [bp+var_8], 0Fh
		jnz	short loc_11689
		mov	[bp+var_A], 0

loc_11689:				; CODE XREF: sub_11462+220j
		sub	ax, ax
		push	ax
		push	ax
		push	[bp+var_E]
		mov	ax, 0Eh
		push	ax
		mov	ax, 0Dh
		push	ax
		mov	ax, [bp+var_E]
		mov	cl, 5
		shl	ax, cl
		add	ax, 0D8h ; '�'
		push	ax
		mov	ax, 10h
		push	ax
		call	sub_16BFC
		add	sp, 0Eh
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, word_2A9F4
		add	ax, 6
		push	ax
		mov	ax, 0Eh
		push	ax
		mov	ax, 0Dh
		push	ax
		mov	ax, 0D8h ; '�'
		push	ax
		mov	ax, 20h	; ' '
		push	ax
		call	sub_16BFC
		add	sp, 0Eh
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, word_2A9DE
		add	ax, 0Fh
		push	ax
		mov	ax, 0Eh
		push	ax
		mov	ax, 0Dh
		push	ax
		mov	ax, 0F8h ; '�'
		push	ax
		mov	ax, 20h	; ' '
		push	ax
		call	sub_16BFC
		add	sp, 0Eh
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, word_2A9F0
		add	ax, 11h
		push	ax
		mov	ax, 0Eh
		push	ax
		mov	ax, 0Dh
		push	ax
		mov	ax, 118h
		push	ax
		mov	ax, 20h	; ' '
		push	ax
		call	sub_16BFC
		add	sp, 0Eh
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, word_2A9E2
		add	ax, 14h
		push	ax
		mov	ax, 0Eh
		push	ax
		mov	ax, 0Dh
		push	ax
		mov	ax, 138h
		push	ax
		mov	ax, 20h	; ' '
		push	ax
		call	sub_16BFC
		add	sp, 0Eh
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, word_2A9EE
		add	ax, 1Ah
		push	ax
		mov	ax, 0Eh
		push	ax
		mov	ax, 0Dh
		push	ax
		mov	ax, 158h
		push	ax
		mov	ax, 20h	; ' '
		push	ax
		call	sub_16BFC
		add	sp, 0Eh
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, word_2A9EC
		add	ax, 1Ah
		push	ax
		mov	ax, 0Eh
		push	ax
		mov	ax, 0Dh
		push	ax
		mov	ax, 178h
		push	ax
		mov	ax, 20h	; ' '
		push	ax
		call	sub_16BFC
		add	sp, 0Eh
		cmp	word_2CBE0, 1
		sbb	ax, ax
		neg	ax
		mov	word_2CBE0, ax
		push	ax
		call	sub_262E6
		add	sp, 2
		call	sub_162AE
		call	sub_16D2E
		call	sub_25C27
		mov	[bp+var_8], ax
		call	sub_25C47
		mov	word_2D30C, 0
		inc	word_2D400
		push	word_2CBE0
		call	sub_262D1
		add	sp, 2
		jmp	loc_11598
; ---------------------------------------------------------------------------

loc_117C6:				; CODE XREF: sub_11462+19Bj
		mov	al, byte ptr [bp+var_8]
		and	al, 4
		cmp	al, 4
		jnz	short loc_117DC
		cmp	word_2A9DE, 0
		jle	short loc_117DC
		mov	ax, 1
		jmp	short loc_117DE
; ---------------------------------------------------------------------------
		align 2

loc_117DC:				; CODE XREF: sub_11462+36Bj
					; sub_11462+372j
		sub	ax, ax

loc_117DE:				; CODE XREF: sub_11462+377j
		mov	cl, byte ptr [bp+var_8]
		and	cl, 8
		mov	si, ax
		cmp	cl, 8
		jnz	short loc_117F8
		cmp	word_2A9DE, 1
		jge	short loc_117F8
		mov	ax, 1
		jmp	short loc_117FA
; ---------------------------------------------------------------------------
		align 2

loc_117F8:				; CODE XREF: sub_11462+387j
					; sub_11462+38Ej
		sub	ax, ax

loc_117FA:				; CODE XREF: sub_11462+393j
		sub	ax, si
		add	ax, word_2A9DE
		mov	word_2A9DE, ax
		jmp	loc_1165F
; ---------------------------------------------------------------------------

loc_11806:				; CODE XREF: sub_11462+1A3j
		mov	al, byte ptr [bp+var_8]
		and	al, 4
		cmp	al, 4
		jnz	short loc_1181C
		cmp	word_2A9F0, 0
		jle	short loc_1181C
		mov	ax, 1
		jmp	short loc_1181E
; ---------------------------------------------------------------------------
		align 2

loc_1181C:				; CODE XREF: sub_11462+3ABj
					; sub_11462+3B2j
		sub	ax, ax

loc_1181E:				; CODE XREF: sub_11462+3B7j
		mov	cl, byte ptr [bp+var_8]
		and	cl, 8
		mov	si, ax
		cmp	cl, 8
		jnz	short loc_11838
		cmp	word_2A9F0, 2
		jge	short loc_11838
		mov	ax, 1
		jmp	short loc_1183A
; ---------------------------------------------------------------------------
		align 2

loc_11838:				; CODE XREF: sub_11462+3C7j
					; sub_11462+3CEj
		sub	ax, ax

loc_1183A:				; CODE XREF: sub_11462+3D3j
		sub	ax, si
		add	ax, word_2A9F0
		mov	word_2A9F0, ax
		jmp	loc_1165F
; ---------------------------------------------------------------------------

loc_11846:				; CODE XREF: sub_11462+1ABj
		mov	al, byte ptr [bp+var_8]
		and	al, 4
		cmp	al, 4
		jnz	short loc_11854
		mov	ax, 1
		jmp	short loc_11856
; ---------------------------------------------------------------------------

loc_11854:				; CODE XREF: sub_11462+3EBj
		sub	ax, ax

loc_11856:				; CODE XREF: sub_11462+3F0j
		mov	cl, byte ptr [bp+var_8]
		and	cl, 8
		mov	si, ax
		cmp	cl, 8
		jnz	short loc_11868
		mov	ax, 1
		jmp	short loc_1186A
; ---------------------------------------------------------------------------

loc_11868:				; CODE XREF: sub_11462+3FFj
		sub	ax, ax

loc_1186A:				; CODE XREF: sub_11462+404j
		sub	ax, si
		add	ax, word_2A9E2
		mov	word_2A9E2, ax
		or	ax, ax
		jge	short loc_1187D
		mov	word_2A9E2, 5

loc_1187D:				; CODE XREF: sub_11462+413j
		cmp	word_2A9E2, 5
		jg	short loc_11887
		jmp	loc_1165F
; ---------------------------------------------------------------------------

loc_11887:				; CODE XREF: sub_11462+420j
		mov	word_2A9E2, 0
		jmp	loc_1165F
; ---------------------------------------------------------------------------

loc_11890:				; CODE XREF: sub_11462+1B3j
		mov	al, byte ptr [bp+var_8]
		and	al, 4
		cmp	al, 4
		jnz	short loc_118A6
		cmp	word_2A9EE, 0
		jle	short loc_118A6
		mov	ax, 1
		jmp	short loc_118A8
; ---------------------------------------------------------------------------
		align 2

loc_118A6:				; CODE XREF: sub_11462+435j
					; sub_11462+43Cj
		sub	ax, ax

loc_118A8:				; CODE XREF: sub_11462+441j
		mov	cl, byte ptr [bp+var_8]
		and	cl, 8
		mov	si, ax
		cmp	cl, 8
		jnz	short loc_118C2
		cmp	word_2A9EE, 1
		jge	short loc_118C2
		mov	ax, 1
		jmp	short loc_118C4
; ---------------------------------------------------------------------------
		align 2

loc_118C2:				; CODE XREF: sub_11462+451j
					; sub_11462+458j
		sub	ax, ax

loc_118C4:				; CODE XREF: sub_11462+45Dj
		sub	ax, si
		add	ax, word_2A9EE
		mov	word_2A9EE, ax
		mov	al, byte ptr word_2CB42
		and	al, 3
		cmp	al, 2
		jnz	short loc_118DC
		mov	word_2A9EE, 1

loc_118DC:				; CODE XREF: sub_11462+472j
		test	byte ptr word_2CB42, 1
		jz	short loc_118E6
		jmp	loc_1165F
; ---------------------------------------------------------------------------

loc_118E6:				; CODE XREF: sub_11462+47Fj
		mov	word_2A9EE, 1
		jmp	loc_1165F
; ---------------------------------------------------------------------------
		align 2

loc_118F0:				; CODE XREF: sub_11462+1BBj
		mov	al, byte ptr [bp+var_8]
		and	al, 4
		cmp	al, 4
		jnz	short loc_11906
		cmp	word_2A9EC, 0
		jle	short loc_11906
		mov	ax, 1
		jmp	short loc_11908
; ---------------------------------------------------------------------------
		align 2

loc_11906:				; CODE XREF: sub_11462+495j
					; sub_11462+49Cj
		sub	ax, ax

loc_11908:				; CODE XREF: sub_11462+4A1j
		mov	cl, byte ptr [bp+var_8]
		and	cl, 8
		mov	si, ax
		cmp	cl, 8
		jnz	short loc_11922
		cmp	word_2A9EC, 1
		jge	short loc_11922
		mov	ax, 1
		jmp	short loc_11924
; ---------------------------------------------------------------------------
		align 2

loc_11922:				; CODE XREF: sub_11462+4B1j
					; sub_11462+4B8j
		sub	ax, ax

loc_11924:				; CODE XREF: sub_11462+4BDj
		sub	ax, si
		add	ax, word_2A9EC
		mov	word_2A9EC, ax
		jmp	loc_1165F
; ---------------------------------------------------------------------------

loc_11930:				; CODE XREF: sub_11462+13Cj
		mov	ax, word_2A9E2
		cmp	[bp+var_2], ax
		jnz	short loc_1193B
		jmp	loc_119DF
; ---------------------------------------------------------------------------

loc_1193B:				; CODE XREF: sub_11462+4D4j
		or	ax, ax
		jnz	short loc_1194F
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, 1000h
		push	ax
		call	sub_29701
		add	sp, 6

loc_1194F:				; CODE XREF: sub_11462+4DBj
		cmp	word_2A9E2, 1
		jnz	short loc_11966
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, 800h
		push	ax
		call	sub_29701
		add	sp, 6

loc_11966:				; CODE XREF: sub_11462+4F2j
		cmp	word_2A9E2, 2
		jnz	short loc_1197A
		sub	ax, ax
		push	ax
		push	ax
		push	ax
		call	sub_29701
		add	sp, 6

loc_1197A:				; CODE XREF: sub_11462+509j
		cmp	word_2A9E2, 1
		jz	short loc_11988
		cmp	word_2A9E2, 2
		jnz	short loc_119DF

loc_11988:				; CODE XREF: sub_11462+51Dj
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, 1Eh
		push	ax
		mov	ax, 0Eh
		push	ax
		mov	ax, 0Dh
		push	ax
		mov	ax, 0C8h ; '�'
		push	ax
		mov	ax, 0Fh
		push	ax
		call	sub_16BFC
		add	sp, 0Eh
		cmp	word_2CBE0, 1
		sbb	ax, ax
		neg	ax
		mov	word_2CBE0, ax
		push	ax
		call	sub_262E6
		add	sp, 2
		call	sub_26403
		call	sub_16D2E
		push	word_2CBE0
		call	sub_262D1
		add	sp, 2
		mov	ax, 388h
		push	ax
		call	LoadTBR
		add	sp, 2

loc_119DF:				; CODE XREF: sub_11462+4D6j
					; sub_11462+524j
		call	sub_1548C
		sub	ax, ax
		push	ax
		call	sub_262D1
		add	sp, 2
		mov	ax, 1
		push	ax
		call	sub_262E6
		add	sp, 2
		mov	ax, [bp+var_E]
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_11462	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_11A04	proc far		; CODE XREF: sub_14DDC+20Dp

var_38		= word ptr -38h
var_36		= word ptr -36h
var_34		= word ptr -34h
var_30		= word ptr -30h
var_2E		= word ptr -2Eh
var_2C		= word ptr -2Ch
var_16		= word ptr -16h
var_14		= byte ptr -14h

		push	bp
		mov	bp, sp
		sub	sp, 38h
		push	si
		mov	[bp+var_2C], 5
		mov	[bp+var_16], 28h ; '('
		mov	[bp+var_30], 0Ah
		mov	word_2D01A, 2
		call	sub_15322
		call	sub_260C5
		mov	ax, 28h	; '('
		push	ax
		call	sub_2591C
		add	sp, 2
		sub	ax, ax
		push	ax
		push	ax
		push	ax
		push	ax
		push	ax
		push	ax
		mov	ax, 1900h
		push	ax
		sub	ax, ax
		push	ax
		call	sub_258D1
		add	sp, 10h
		sub	ax, ax
		push	ax
		call	sub_262E6
		add	sp, 2
		sub	ax, ax
		push	ax
		call	sub_262D1
		add	sp, 2
		call	sub_260A7
		mov	ax, offset aBVg13 ; "b:vg13"
		push	ax
		call	LoadMusic	; VG13:	Continue
		add	sp, 2
		mov	word_2D3B0, ax
		mov	ax, 80h	; '�'
		push	ax
		call	sub_15496
		add	sp, 2
		mov	word_2D3AC, ax
		mov	ax, offset aAContic ; "a:contic"
		push	ax
		call	LoadSP2
		add	sp, 2
		mov	word_2D3B4, ax
		sub	ax, ax
		push	ax
		mov	bx, word_2D3B4
		shl	bx, 1
		shl	bx, 1
		mov	dx, word_2CE1C[bx]
		mov	es, dx
		mov	bx, ax
		push	word ptr es:[bx]
		mov	ax, offset aAContic_0 ;	"a:contic"
		push	ax
		call	LoadHEM_A1
		add	sp, 6
		mov	word_2D3B2, ax
		sub	ax, ax
		push	ax
		mov	ax, 19h
		push	ax
		mov	ax, 50h	; 'P'
		push	ax
		sub	ax, ax
		push	ax
		push	ax
		call	sub_2630F
		add	sp, 0Ah
		sub	ax, ax
		push	ax
		push	ax
		push	ax
		mov	ax, offset aAContinue ;	"a:continue"
		push	ax
		call	LoadHEM_1
		add	sp, 8
		mov	bx, PlayerCharID
		shl	bx, 1
		push	fName_Character[bx]
		mov	ax, offset aK2	; "k2"
		push	ax
		lea	ax, [bp+var_14]
		push	ax
		call	strcat
		add	sp, 6
		mov	ax, 1
		push	ax
		mov	ax, 74h
		push	ax
		mov	ax, 0Ah
		push	ax
		lea	ax, [bp+var_14]
		push	ax
		call	LoadGEM
		add	sp, 8
		mov	ax, 8000
		push	ax
		call	sub_15496
		add	sp, 2
		mov	word_2D398, ax
		mov	ax, 2000
		push	ax
		mov	bx, word_2D398
		shl	bx, 1
		shl	bx, 1
		push	word_2CE1C[bx]
		call	sub_1655C
		add	sp, 4
		mov	bx, PlayerCharID
		shl	bx, 1
		push	fName_Character[bx]
		mov	ax, offset aK1_gem ; "k1.gem"
		push	ax
		lea	ax, [bp+var_14]
		push	ax
		call	strcat
		add	sp, 6
		lea	ax, [bp+var_14]
		push	ax
		call	MaybeLoadFile
		add	sp, 2
		mov	[bp+var_34], ax
		push	ax
		call	sub_15496
		add	sp, 2
		mov	[bp+var_36], ax
		mov	bx, ax
		shl	bx, 1
		shl	bx, 1
		push	word_2CE1C[bx]
		lea	ax, [bp+var_14]
		push	ax
		call	sub_29694
		add	sp, 4
		mov	ax, offset aACnt ; "a:cnt"
		push	ax
		call	LoadHNY
		add	sp, 2
		mov	word_2D3B6, ax
		sub	ax, ax
		push	ax
		call	sub_262E6
		add	sp, 2
		call	sub_16114
		mov	ax, 1
		push	ax
		call	sub_262E6
		add	sp, 2
		call	sub_16114
		sub	ax, ax
		push	ax
		call	sub_262E6
		add	sp, 2
		sub	ax, ax
		push	ax
		call	sub_262D1
		add	sp, 2
		call	sub_25C27
		mov	[bp+var_2E], ax
		call	sub_26089
		cmp	word_2A9E2, 5
		jz	short loc_11C0B
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, 3
		push	ax
		call	sub_29701
		add	sp, 6
		sub	ax, ax
		push	ax
		mov	bx, word_2D3B0
		shl	bx, 1
		shl	bx, 1
		push	word_2CE1C[bx]
		mov	ax, 1
		push	ax
		call	sub_29701
		add	sp, 6

loc_11C0B:				; CODE XREF: sub_11A04+1DAj
		cmp	word_2A9E2, 3
		jl	short loc_11C15
		jmp	loc_11E19
; ---------------------------------------------------------------------------

loc_11C15:				; CODE XREF: sub_11A04+20Cj
					; sub_11A04+230j
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, 5
		push	ax
		call	sub_29701
		add	sp, 6
		cmp	ax, 0C0h ; '�'
		jle	short loc_11C30
		mov	ax, 1
		jmp	short loc_11C32
; ---------------------------------------------------------------------------
		align 2

loc_11C30:				; CODE XREF: sub_11A04+224j
		sub	ax, ax

loc_11C32:				; CODE XREF: sub_11A04+229j
		or	ax, ax
		jnz	short loc_11C15
		jmp	loc_11E19
; ---------------------------------------------------------------------------
		align 2

loc_11C3A:				; CODE XREF: sub_11A04+41Bj
		cmp	word_2A9E2, 5
		jnz	short loc_11C54
		dec	[bp+var_16]
		jz	short loc_11C49
		jmp	loc_11CD4
; ---------------------------------------------------------------------------

loc_11C49:				; CODE XREF: sub_11A04+240j
		mov	[bp+var_16], 28h ; '('
		dec	[bp+var_30]
		jmp	short loc_11CA4
; ---------------------------------------------------------------------------
		align 2

loc_11C54:				; CODE XREF: sub_11A04+23Bj
		mov	ax, [bp+var_30]
		mov	[bp+var_38], ax
		cmp	word_2A9E2, 3
		jge	short loc_11C76
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, 5
		push	ax
		call	sub_29701
		add	sp, 6
		sub	ax, 0A8h ; '�'
		jmp	short loc_11C89
; ---------------------------------------------------------------------------

loc_11C76:				; CODE XREF: sub_11A04+25Bj
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, 5
		push	ax
		call	sub_29701
		add	sp, 6
		sub	ax, 18h

loc_11C89:				; CODE XREF: sub_11A04+270j
		cwd
		mov	cx, 0C0h ; '�'
		idiv	cx
		sub	ax, 9
		neg	ax
		mov	[bp+var_30], ax
		mov	ax, [bp+var_38]
		cmp	[bp+var_30], ax
		jle	short loc_11CA4
		mov	[bp+var_30], 0FFFFh

loc_11CA4:				; CODE XREF: sub_11A04+24Dj
					; sub_11A04+299j
		cmp	[bp+var_30], 0
		jg	short loc_11CC4
		cmp	word_2A9F2, 0
		jnz	short loc_11CC4
		mov	ax, PlayerCharID
		add	ax, 6
		push	ax
		mov	ax, 2
		push	ax
		call	sub_15C20
		add	sp, 4

loc_11CC4:				; CODE XREF: sub_11A04+2A4j
					; sub_11A04+2ABj
		cmp	[bp+var_30], 0
		jge	short loc_11CD4
		mov	[bp+var_2C], 0
		mov	[bp+var_30], 0

loc_11CD4:				; CODE XREF: sub_11A04+242j
					; sub_11A04+2C4j
		call	sub_25C27
		or	[bp+var_2E], ax
		mov	al, byte ptr [bp+var_2E]
		and	al, 10h
		cmp	al, 10h
		jnz	short loc_11CFA
		mov	[bp+var_2C], 1
		push	PlayerCharID
		mov	ax, 2
		push	ax
		call	sub_15C20
		add	sp, 4

loc_11CFA:				; CODE XREF: sub_11A04+2DFj
		mov	al, byte ptr [bp+var_2E]
		and	al, 20h
		cmp	al, 20h	; ' '
		jnz	short loc_11D1B
		mov	[bp+var_2C], 0
		mov	ax, PlayerCharID
		add	ax, 6
		push	ax
		mov	ax, 2
		push	ax
		call	sub_15C20
		add	sp, 4

loc_11D1B:				; CODE XREF: sub_11A04+2FDj
		mov	ax, 0Ah
		sub	ax, [bp+var_30]
		mov	si, ax
		shl	si, 1
		sub	ax, ax
		push	ax
		push	ax
		push	si
		mov	ax, 0Eh
		push	ax
		mov	ax, 0Dh
		push	ax
		mov	ax, 0D0h ; '�'
		push	ax
		mov	ax, 1Ch
		push	ax
		call	sub_16BFC
		add	sp, 0Eh
		sub	ax, ax
		push	ax
		push	ax
		lea	ax, [si+1]
		push	ax
		mov	ax, 0Eh
		push	ax
		mov	ax, 0Dh
		push	ax
		mov	ax, 0D0h ; '�'
		push	ax
		mov	ax, 1Ch
		push	ax
		call	sub_16BFC
		add	sp, 0Eh
		cmp	[bp+var_30], 1
		jl	short loc_11D6E
		cmp	[bp+var_2C], 0
		jnz	short loc_11DAE

loc_11D6E:				; CODE XREF: sub_11A04+362j
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, 16h
		push	ax
		mov	ax, 0Eh
		push	ax
		mov	ax, 0Dh
		push	ax
		mov	ax, 12Ch
		push	ax
		mov	ax, 14h
		push	ax
		call	sub_16BFC
		add	sp, 0Eh
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, 17h
		push	ax
		mov	ax, 0Eh
		push	ax
		mov	ax, 0Dh
		push	ax
		mov	ax, 12Ch
		push	ax
		mov	ax, 14h
		push	ax
		call	sub_16BFC
		add	sp, 0Eh

loc_11DAE:				; CODE XREF: sub_11A04+368j
		cmp	word_2CBE0, 1
		sbb	ax, ax
		neg	ax
		mov	word_2CBE0, ax
		push	ax
		call	sub_262E6
		add	sp, 2
		call	sub_162AE
		cmp	[bp+var_2C], 1
		jnz	short loc_11DF1
		call	MaybeWaitKey
		sub	ax, ax
		push	ax
		mov	bx, [bp+var_36]
		shl	bx, 1
		shl	bx, 1
		push	word ptr [bx+244Ch]
		mov	ax, 74h	; 't'
		push	ax
		mov	ax, 0Ah
		push	ax
		call	sub_25666
		add	sp, 8

loc_11DF1:				; CODE XREF: sub_11A04+3C8j
		call	sub_16D2E
		call	sub_25C27
		mov	[bp+var_2E], ax
		call	sub_25C47
		mov	word_2D30C, 0
		inc	word_2D400
		push	word_2CBE0
		call	sub_262D1
		add	sp, 2

loc_11E19:				; CODE XREF: sub_11A04+20Ej
					; sub_11A04+232j
		cmp	[bp+var_2C], 5
		jnz	short loc_11E22
		jmp	loc_11C3A
; ---------------------------------------------------------------------------

loc_11E22:				; CODE XREF: sub_11A04+419j
		mov	ax, 3Ch	; '<'
		push	ax
		push	cs
		call	near ptr sub_10000
		add	sp, 2
		push	cs
		call	near ptr sub_100F6
		mov	al, byte ptr word_2CB42
		and	al, 1
		cmp	al, 1
		jnz	short loc_11E4A
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, 1Ah
		push	ax
		call	sub_29701
		add	sp, 6

loc_11E4A:				; CODE XREF: sub_11A04+434j
		mov	word_2A9F2, 0
		push	cs
		call	near ptr sub_1004E
		call	sub_1548C
		call	sub_260A7
		sub	ax, ax
		push	ax
		call	sub_262D1
		add	sp, 2
		sub	ax, ax
		push	ax
		call	sub_262E6
		add	sp, 2
		call	sub_26403
		mov	ax, 1
		push	ax
		call	sub_262E6
		add	sp, 2
		call	sub_26403
		call	sub_26089
		mov	ax, [bp+var_2C]
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_11A04	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_11E98	proc far		; CODE XREF: sub_1455A+75p

var_16		= word ptr -16h
var_14		= word ptr -14h
var_12		= word ptr -12h
var_E		= word ptr -0Eh
var_C		= word ptr -0Ch
var_A		= word ptr -0Ah
var_8		= word ptr -8
var_6		= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2

		push	bp
		mov	bp, sp
		sub	sp, 18h
		push	si
		mov	[bp+var_4], 0
		mov	[bp+var_2], 0
		mov	[bp+var_E], 0
		mov	[bp+var_14], 0
		mov	[bp+var_A], 0
		mov	[bp+var_8], 0
		mov	[bp+var_12], 0
		mov	[bp+var_16], 0
		mov	word_2D01A, 2
		call	sub_15322
		call	sub_260C5
		mov	ax, 28h	; '('
		push	ax
		call	sub_2591C
		add	sp, 2
		sub	ax, ax
		push	ax
		call	sub_262E6
		add	sp, 2
		sub	ax, ax
		push	ax
		call	sub_262D1
		add	sp, 2
		call	sub_260A7
		mov	ax, 80h	; '�'
		push	ax
		call	sub_15496
		add	sp, 2
		mov	word_2D3AC, ax
		mov	ax, 3C4h
		push	ax
		call	LoadSP2
		add	sp, 2
		mov	word_2D3B4, ax
		sub	ax, ax
		push	ax
		mov	bx, word_2D3B4
		shl	bx, 1
		shl	bx, 1
		mov	dx, [bx+244Ch]
		mov	es, dx
		mov	bx, ax
		push	word ptr es:[bx]
		mov	ax, 3CAh
		push	ax
		call	LoadHEM_A1
		add	sp, 6
		mov	word_2D3B2, ax
		sub	ax, ax
		push	ax
		mov	ax, 19h
		push	ax
		mov	ax, 50h	; 'P'
		push	ax
		sub	ax, ax
		push	ax
		push	ax
		call	sub_2630F
		add	sp, 0Ah
		mov	ax, 1
		push	ax
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, 3D0h
		push	ax
		call	LoadGEM
		add	sp, 8
		mov	ax, 1F40h
		push	ax
		call	sub_15496
		add	sp, 2
		mov	word_2D398, ax
		mov	ax, 7D0h
		push	ax
		mov	bx, word_2D398
		shl	bx, 1
		shl	bx, 1
		push	word_2CE1C[bx]
		call	sub_1655C
		add	sp, 4
		sub	ax, ax
		push	ax
		call	sub_262E6
		add	sp, 2
		call	sub_16114
		mov	ax, 1
		push	ax
		call	sub_262E6
		add	sp, 2
		call	sub_16114
		sub	ax, ax
		push	ax
		call	sub_262E6
		add	sp, 2
		sub	ax, ax
		push	ax
		call	sub_262D1
		add	sp, 2
		call	sub_26089
		call	sub_25BD0
		mov	[bp+var_6], ax
		call	sub_25B79
		mov	[bp+var_C], ax
		call	sub_26089

loc_11FE4:				; CODE XREF: sub_11E98+586j
		cmp	[bp+var_4], 0
		jz	short loc_11FED
		jmp	loc_12450
; ---------------------------------------------------------------------------

loc_11FED:				; CODE XREF: sub_11E98+150j
		call	sub_25BD0
		or	[bp+var_6], ax
		call	sub_25B79
		or	[bp+var_C], ax
		test	byte ptr [bp+var_6], 0Fh
		jnz	short loc_12006
		jmp	loc_1209D
; ---------------------------------------------------------------------------

loc_12006:				; CODE XREF: sub_11E98+169j
		cmp	[bp+var_E], 0
		jz	short loc_1200F
		jmp	loc_1209D
; ---------------------------------------------------------------------------

loc_1200F:				; CODE XREF: sub_11E98+172j
		mov	al, byte ptr [bp+var_6]
		and	al, 1
		cmp	al, 1
		jnz	short loc_12024
		cmp	[bp+var_14], 0
		jle	short loc_12024
		mov	ax, 1
		jmp	short loc_12026
; ---------------------------------------------------------------------------
		align 2

loc_12024:				; CODE XREF: sub_11E98+17Ej
					; sub_11E98+184j
		sub	ax, ax

loc_12026:				; CODE XREF: sub_11E98+189j
		mov	cl, byte ptr [bp+var_6]
		and	cl, 2
		mov	si, ax
		cmp	cl, 2
		jnz	short loc_1203E
		cmp	[bp+var_14], 2
		jge	short loc_1203E
		mov	ax, 1
		jmp	short loc_12040
; ---------------------------------------------------------------------------

loc_1203E:				; CODE XREF: sub_11E98+199j
					; sub_11E98+19Fj
		sub	ax, ax

loc_12040:				; CODE XREF: sub_11E98+1A4j
		sub	ax, si
		add	ax, [bp+var_14]
		mov	[bp+var_14], ax
		or	ax, ax
		jz	short loc_1205E
		cmp	ax, 1
		jnz	short loc_12054
		jmp	loc_120EA
; ---------------------------------------------------------------------------

loc_12054:				; CODE XREF: sub_11E98+1B7j
		cmp	ax, 2
		jnz	short loc_1205C
		jmp	loc_12128
; ---------------------------------------------------------------------------

loc_1205C:				; CODE XREF: sub_11E98+1BFj
		jmp	short loc_12098
; ---------------------------------------------------------------------------

loc_1205E:				; CODE XREF: sub_11E98+1B2j
		mov	al, byte ptr [bp+var_6]
		and	al, 4
		cmp	al, 4
		jnz	short loc_12074
		cmp	word_2D3FC, 0
		jle	short loc_12074
		mov	ax, 1
		jmp	short loc_12076
; ---------------------------------------------------------------------------
		align 2

loc_12074:				; CODE XREF: sub_11E98+1CDj
					; sub_11E98+1D4j
		sub	ax, ax

loc_12076:				; CODE XREF: sub_11E98+1D9j
		mov	cl, byte ptr [bp+var_6]
		and	cl, 8
		mov	si, ax
		cmp	cl, 8
		jnz	short loc_12090
		cmp	word_2D3FC, 7
		jge	short loc_12090
		mov	ax, 1
		jmp	short loc_12092
; ---------------------------------------------------------------------------
		align 2

loc_12090:				; CODE XREF: sub_11E98+1E9j
					; sub_11E98+1F0j
		sub	ax, ax

loc_12092:				; CODE XREF: sub_11E98+1F5j
		sub	ax, si
		add	word_2D3FC, ax

loc_12098:				; CODE XREF: sub_11E98:loc_1205Cj
					; sub_11E98+28Cj ...
		mov	[bp+var_E], 1

loc_1209D:				; CODE XREF: sub_11E98+16Bj
					; sub_11E98+174j
		mov	al, byte ptr [bp+var_6]
		and	al, 10h
		cmp	al, 10h
		jnz	short loc_120B1
		cmp	[bp+var_2], 0
		jnz	short loc_120B1
		mov	[bp+var_4], 1

loc_120B1:				; CODE XREF: sub_11E98+20Cj
					; sub_11E98+212j
		test	byte ptr [bp+var_6], 0Fh
		jnz	short loc_120BC
		mov	[bp+var_E], 0

loc_120BC:				; CODE XREF: sub_11E98+21Dj
		test	byte ptr [bp+var_C], 0Fh
		jnz	short loc_120C5
		jmp	loc_121D7
; ---------------------------------------------------------------------------

loc_120C5:				; CODE XREF: sub_11E98+228j
		cmp	[bp+var_12], 0
		jz	short loc_120CE
		jmp	loc_121D7
; ---------------------------------------------------------------------------

loc_120CE:				; CODE XREF: sub_11E98+231j
		mov	al, byte ptr [bp+var_C]
		and	al, 1
		cmp	al, 1
		jz	short loc_120DA
		jmp	loc_12168
; ---------------------------------------------------------------------------

loc_120DA:				; CODE XREF: sub_11E98+23Dj
		cmp	[bp+var_16], 0
		jg	short loc_120E3
		jmp	loc_12168
; ---------------------------------------------------------------------------

loc_120E3:				; CODE XREF: sub_11E98+246j
		mov	ax, 1
		jmp	loc_1216A
; ---------------------------------------------------------------------------
		align 2

loc_120EA:				; CODE XREF: sub_11E98+1B9j
		mov	al, byte ptr [bp+var_6]
		and	al, 4
		cmp	al, 4
		jnz	short loc_12100
		cmp	word_2CB56, 0
		jle	short loc_12100
		mov	ax, 1
		jmp	short loc_12102
; ---------------------------------------------------------------------------
		align 2

loc_12100:				; CODE XREF: sub_11E98+259j
					; sub_11E98+260j
		sub	ax, ax

loc_12102:				; CODE XREF: sub_11E98+265j
		mov	cl, byte ptr [bp+var_6]
		and	cl, 8
		mov	si, ax
		cmp	cl, 8
		jnz	short loc_1211C
		cmp	word_2CB56, 1
		jge	short loc_1211C
		mov	ax, 1
		jmp	short loc_1211E
; ---------------------------------------------------------------------------
		align 2

loc_1211C:				; CODE XREF: sub_11E98+275j
					; sub_11E98+27Cj
		sub	ax, ax

loc_1211E:				; CODE XREF: sub_11E98+281j
		sub	ax, si
		add	word_2CB56, ax
		jmp	loc_12098
; ---------------------------------------------------------------------------
		align 2

loc_12128:				; CODE XREF: sub_11E98+1C1j
		mov	al, byte ptr [bp+var_6]
		and	al, 4
		cmp	al, 4
		jnz	short loc_1213E
		cmp	word_2A9E8, 0
		jle	short loc_1213E
		mov	ax, 1
		jmp	short loc_12140
; ---------------------------------------------------------------------------
		align 2

loc_1213E:				; CODE XREF: sub_11E98+297j
					; sub_11E98+29Ej
		sub	ax, ax

loc_12140:				; CODE XREF: sub_11E98+2A3j
		mov	cl, byte ptr [bp+var_6]
		and	cl, 8
		mov	si, ax
		cmp	cl, 8
		jnz	short loc_1215A
		cmp	word_2A9E8, 5
		jge	short loc_1215A
		mov	ax, 1
		jmp	short loc_1215C
; ---------------------------------------------------------------------------
		align 2

loc_1215A:				; CODE XREF: sub_11E98+2B3j
					; sub_11E98+2BAj
		sub	ax, ax

loc_1215C:				; CODE XREF: sub_11E98+2BFj
		sub	ax, si
		add	ax, word_2A9E8
		mov	word_2A9E8, ax
		jmp	loc_12098
; ---------------------------------------------------------------------------

loc_12168:				; CODE XREF: sub_11E98+23Fj
					; sub_11E98+248j
		sub	ax, ax

loc_1216A:				; CODE XREF: sub_11E98+24Ej
		mov	cl, byte ptr [bp+var_C]
		and	cl, 2
		mov	si, ax
		cmp	cl, 2
		jnz	short loc_12182
		cmp	[bp+var_16], 1
		jge	short loc_12182
		mov	ax, 1
		jmp	short loc_12184
; ---------------------------------------------------------------------------

loc_12182:				; CODE XREF: sub_11E98+2DDj
					; sub_11E98+2E3j
		sub	ax, ax

loc_12184:				; CODE XREF: sub_11E98+2E8j
		sub	ax, si
		add	ax, [bp+var_16]
		mov	[bp+var_16], ax
		or	ax, ax
		jz	short loc_12198
		cmp	ax, 1
		jz	short loc_121FC
		jmp	short loc_121D2
; ---------------------------------------------------------------------------
		align 2

loc_12198:				; CODE XREF: sub_11E98+2F6j
		mov	al, byte ptr [bp+var_C]
		and	al, 4
		cmp	al, 4
		jnz	short loc_121AE
		cmp	word_2D3FE, 0
		jle	short loc_121AE
		mov	ax, 1
		jmp	short loc_121B0
; ---------------------------------------------------------------------------
		align 2

loc_121AE:				; CODE XREF: sub_11E98+307j
					; sub_11E98+30Ej
		sub	ax, ax

loc_121B0:				; CODE XREF: sub_11E98+313j
		mov	cl, byte ptr [bp+var_C]
		and	cl, 8
		mov	si, ax
		cmp	cl, 8
		jnz	short loc_121CA
		cmp	word_2D3FE, 7
		jge	short loc_121CA
		mov	ax, 1
		jmp	short loc_121CC
; ---------------------------------------------------------------------------
		align 2

loc_121CA:				; CODE XREF: sub_11E98+323j
					; sub_11E98+32Aj
		sub	ax, ax

loc_121CC:				; CODE XREF: sub_11E98+32Fj
		sub	ax, si
		add	word_2D3FE, ax

loc_121D2:				; CODE XREF: sub_11E98+2FDj
					; sub_11E98+39Ej
		mov	[bp+var_12], 1

loc_121D7:				; CODE XREF: sub_11E98+22Aj
					; sub_11E98+233j
		test	byte ptr [bp+var_C], 0Fh
		jnz	short loc_121E2
		mov	[bp+var_12], 0

loc_121E2:				; CODE XREF: sub_11E98+343j
		mov	ax, [bp+var_14]
		or	ax, ax
		jz	short loc_12238
		cmp	ax, 1
		jnz	short loc_121F1
		jmp	loc_12294
; ---------------------------------------------------------------------------

loc_121F1:				; CODE XREF: sub_11E98+354j
		cmp	ax, 2
		jnz	short loc_121F9
		jmp	loc_122C0
; ---------------------------------------------------------------------------

loc_121F9:				; CODE XREF: sub_11E98+35Cj
		jmp	loc_1227E
; ---------------------------------------------------------------------------

loc_121FC:				; CODE XREF: sub_11E98+2FBj
		mov	al, byte ptr [bp+var_C]
		and	al, 4
		cmp	al, 4
		jnz	short loc_12212
		cmp	word_2CBA1, 0
		jle	short loc_12212
		mov	ax, 1
		jmp	short loc_12214
; ---------------------------------------------------------------------------
		align 2

loc_12212:				; CODE XREF: sub_11E98+36Bj
					; sub_11E98+372j
		sub	ax, ax

loc_12214:				; CODE XREF: sub_11E98+377j
		mov	cl, byte ptr [bp+var_C]
		and	cl, 8
		mov	si, ax
		cmp	cl, 8
		jnz	short loc_1222E
		cmp	word_2CBA1, 1
		jge	short loc_1222E
		mov	ax, 1
		jmp	short loc_12230
; ---------------------------------------------------------------------------
		align 2

loc_1222E:				; CODE XREF: sub_11E98+387j
					; sub_11E98+38Ej
		sub	ax, ax

loc_12230:				; CODE XREF: sub_11E98+393j
		sub	ax, si
		add	word_2CBA1, ax
		jmp	short loc_121D2
; ---------------------------------------------------------------------------

loc_12238:				; CODE XREF: sub_11E98+34Fj
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, word_2D3FC
		add	ax, 0Ah
		push	ax
		mov	ax, 0Eh
		push	ax
		mov	ax, 0Dh
		push	ax
		mov	ax, 68h	; 'h'
		push	ax
		mov	ax, 3
		push	ax
		call	sub_16BFC
		add	sp, 0Eh
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, word_2CB56
		add	ax, 8

loc_12265:				; CODE XREF: sub_11E98+426j
		push	ax
		mov	ax, 0Eh
		push	ax
		mov	ax, 0Dh
		push	ax
		mov	ax, 98h	; '�'
		push	ax
		mov	ax, 3

loc_12275:				; CODE XREF: sub_11E98+482j
		push	ax
		call	sub_16BFC
		add	sp, 0Eh

loc_1227E:				; CODE XREF: sub_11E98:loc_121F9j
		mov	ax, [bp+var_16]
		or	ax, ax
		jnz	short loc_12288
		jmp	loc_1231E
; ---------------------------------------------------------------------------

loc_12288:				; CODE XREF: sub_11E98+3EBj
		cmp	ax, 1
		jnz	short loc_12290
		jmp	loc_12422
; ---------------------------------------------------------------------------

loc_12290:				; CODE XREF: sub_11E98+3F3j
		jmp	loc_12364
; ---------------------------------------------------------------------------
		align 2

loc_12294:				; CODE XREF: sub_11E98+356j
		sub	ax, ax
		push	ax
		push	ax
		push	word_2D3FC
		mov	ax, 0Eh
		push	ax
		mov	ax, 0Dh
		push	ax
		mov	ax, 68h	; 'h'
		push	ax
		mov	ax, 3
		push	ax
		call	sub_16BFC
		add	sp, 0Eh
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, word_2CB56
		add	ax, 12h
		jmp	short loc_12265
; ---------------------------------------------------------------------------

loc_122C0:				; CODE XREF: sub_11E98+35Ej
		sub	ax, ax
		push	ax
		push	ax
		push	word_2D3FC
		mov	ax, 0Eh
		push	ax
		mov	ax, 0Dh
		push	ax
		mov	ax, 68h	; 'h'
		push	ax
		mov	ax, 3
		push	ax
		call	sub_16BFC
		add	sp, 0Eh
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, word_2CB56
		add	ax, 8
		push	ax
		mov	ax, 0Eh
		push	ax
		mov	ax, 0Dh
		push	ax
		mov	ax, 98h	; '�'
		push	ax
		mov	ax, 3
		push	ax
		call	sub_16BFC
		add	sp, 0Eh
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, 14h
		push	ax
		mov	ax, 0Eh
		push	ax
		mov	ax, 0Dh
		push	ax
		mov	ax, 0C8h ; '�'
		push	ax
		mov	ax, 13h
		jmp	loc_12275
; ---------------------------------------------------------------------------
		align 2

loc_1231E:				; CODE XREF: sub_11E98+3EDj
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, word_2D3FE
		add	ax, 0Ah
		push	ax
		mov	ax, 0Eh
		push	ax
		mov	ax, 0Dh
		push	ax
		mov	ax, 68h	; 'h'
		push	ax
		mov	ax, 16h
		push	ax
		call	sub_16BFC
		add	sp, 0Eh
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, word_2CBA1
		add	ax, 8

loc_1234B:				; CODE XREF: sub_11E98+5B4j
		push	ax
		mov	ax, 0Eh
		push	ax
		mov	ax, 0Dh
		push	ax
		mov	ax, 98h	; '�'
		push	ax
		mov	ax, 16h
		push	ax
		call	sub_16BFC
		add	sp, 0Eh

loc_12364:				; CODE XREF: sub_11E98:loc_12290j
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, PlayerCharID
		add	ax, 16h
		push	ax
		mov	ax, 0Eh
		push	ax
		mov	ax, 0Dh
		push	ax
		mov	ax, 38h	; '8'
		push	ax
		mov	ax, 0Ah
		push	ax
		call	sub_16BFC
		add	sp, 0Eh
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, word_2CB40
		add	ax, 16h
		push	ax
		mov	ax, 0Eh
		push	ax
		mov	ax, 0Dh
		push	ax
		mov	ax, 38h	; '8'
		push	ax
		mov	ax, 1Eh
		push	ax
		call	sub_16BFC
		add	sp, 0Eh
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, 15h
		push	ax
		mov	ax, 0Eh
		push	ax
		mov	ax, 0Dh
		push	ax
		mov	ax, 0F0h ; '�'
		push	ax
		mov	ax, word_2A9E8
		mov	cx, ax
		shl	ax, 1
		add	ax, cx
		shl	ax, 1
		add	ax, cx
		push	ax
		call	sub_16BFC
		add	sp, 0Eh
		cmp	word_2CBE0, 1
		sbb	ax, ax
		neg	ax
		mov	word_2CBE0, ax
		push	ax
		call	sub_262E6
		add	sp, 2
		call	sub_162AE
		call	sub_16D2E
		call	sub_25BD0
		mov	[bp+var_6], ax
		call	sub_25B79
		mov	[bp+var_C], ax
		call	sub_25C47
		mov	word_2D30C, 0
		inc	word_2D400
		push	word_2CBE0
		call	sub_262D1
		add	sp, 2
		jmp	loc_11FE4
; ---------------------------------------------------------------------------
		align 2

loc_12422:				; CODE XREF: sub_11E98+3F5j
		sub	ax, ax
		push	ax
		push	ax
		push	word_2D3FE
		mov	ax, 0Eh
		push	ax
		mov	ax, 0Dh
		push	ax
		mov	ax, 68h	; 'h'
		push	ax
		mov	ax, 16h
		push	ax
		call	sub_16BFC
		add	sp, 0Eh
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, word_2CBA1
		add	ax, 12h
		jmp	loc_1234B
; ---------------------------------------------------------------------------
		align 2

loc_12450:				; CODE XREF: sub_11E98+152j
		call	sub_1548C
		sub	ax, ax
		push	ax
		call	sub_262D1
		add	sp, 2
		mov	ax, 1
		push	ax
		call	sub_262E6
		add	sp, 2
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_11E98	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_12472	proc far		; CODE XREF: sub_124FA+11Dp
					; sub_133B4+E7p
		push	PlayerCharID
		sub	ax, ax
		push	ax
		push	cs
		call	near ptr sub_106F0
		add	sp, 4
		push	word_2CB40
		mov	ax, 1
		push	ax
		push	cs
		call	near ptr sub_106F0
		add	sp, 4
		retf
sub_12472	endp


; =============== S U B	R O U T	I N E =======================================


sub_12490	proc far		; CODE XREF: sub_133B4+19p
		push	word_2D3A4
		call	sub_154E4
		add	sp, 2
		mov	ax, word_2CB40
		cmp	PlayerCharID, ax
		jz	short loc_124C9
		push	word_2D3A6
		call	sub_154E4
		add	sp, 2
		push	word_2D3A8
		call	sub_154E4
		add	sp, 2
		push	word_2D3BA
		call	sub_154E4
		add	sp, 2

loc_124C9:				; CODE XREF: sub_12490+13j
		push	word_2D39E
		call	sub_154E4
		add	sp, 2
		push	word_2D3A0
		call	sub_154E4
		add	sp, 2
		push	word_2D3A2
		call	sub_154E4
		add	sp, 2
		push	word_2D3B8
		call	sub_154E4
		add	sp, 2
		retf
sub_12490	endp


; =============== S U B	R O U T	I N E =======================================


sub_124FA	proc far		; CODE XREF: sub_1455A+79p
					; sub_145EA+77p ...
		push	cs
		call	near ptr sub_105E6
		call	sub_260A7
		mov	ax, offset aAVg14 ; "a:vg14"
		push	ax
		call	LoadMusic2
		add	sp, 2
		mov	word_2D3BE, ax
		mov	ax, offset aASys ; "a:sys"
		push	ax
		call	LoadHNY
		add	sp, 2
		mov	word_2D3B6, ax
		mov	bx, word_2A9E8
		shl	bx, 1
		push	fName_CharBGM[bx]
		call	LoadMusic	; character-specific BGM (VG03..VG09)
		add	sp, 2
		mov	word_2D3B0, ax
		mov	ax, offset aAVgefe ; "a:vgefe"
		push	ax
		call	LoadSFX
		add	sp, 2
		mov	word_2D3AE, ax
		cmp	word_2A9E2, 5
		jz	short loc_12592
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, 3
		push	ax
		call	sub_29701
		add	sp, 6
		sub	ax, ax
		push	ax
		mov	bx, word_2D3AE
		shl	bx, 1
		shl	bx, 1
		push	word_2CE1C[bx]
		mov	ax, 6
		push	ax
		call	sub_29701
		add	sp, 6
		sub	ax, ax
		push	ax
		mov	bx, word_2D3B0
		shl	bx, 1
		shl	bx, 1
		push	word_2CE1C[bx]
		mov	ax, 1
		push	ax
		call	sub_29701
		add	sp, 6

loc_12592:				; CODE XREF: sub_124FA+50j
		mov	ax, 80h	; '�'
		push	ax
		call	sub_15496
		add	sp, 2
		mov	word_2D3AC, ax
		mov	ax, offset aASyschr ; "a:syschr"
		push	ax
		call	LoadSP2
		add	sp, 2
		mov	word_2D39C, ax
		sub	ax, ax
		push	ax
		mov	bx, word_2D39C
		shl	bx, 1
		shl	bx, 1
		mov	dx, word_2CE1C[bx]
		mov	es, dx
		mov	bx, ax
		push	word ptr es:[bx]
		mov	ax, offset aASyschr_0 ;	"a:syschr"
		push	ax
		call	LoadHEM_A1
		add	sp, 6
		mov	word_2D39A, ax
		mov	bx, word_2A9E8
		shl	bx, 1
		push	fName_Round[bx]
		call	LoadMP2
		add	sp, 2
		mov	word_2D3AA, ax
		mov	bx, ax
		shl	bx, 1
		shl	bx, 1
		mov	dx, word_2CE1C[bx]
		sub	ax, ax
		mov	es, dx
		mov	bx, ax
		push	word ptr es:[bx]
		mov	bx, word_2A9E8
		shl	bx, 1
		push	fName_Round[bx]
		call	LoadHEM_A2
		add	sp, 4
		mov	word_2D398, ax
		push	cs
		call	near ptr sub_10094
		push	cs
		call	near ptr sub_12472
		retf
sub_124FA	endp

; ---------------------------------------------------------------------------
		align 2
		push	cs
		call	near ptr sub_1004E
		call	sub_1548C
		retf

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_12626	proc far		; CODE XREF: sub_127D6+1Cp

var_2		= word ptr -2

		push	bp
		mov	bp, sp
		sub	sp, 2
		cmp	word_2A9E0, 0
		jnz	short loc_12684
		mov	ax, word_2CB4A
		add	ax, word_2CB95
		cwd
		sub	ax, dx
		sar	ax, 1
		sub	ax, 9Eh
		cwd
		xor	ax, dx
		sub	ax, dx
		mov	cx, 4
		sar	ax, cl
		xor	ax, dx
		sub	ax, dx
		mov	[bp+var_2], ax
		cmp	ax, 0FFF8h
		jge	short loc_1265D
		mov	[bp+var_2], 0FFF8h

loc_1265D:				; CODE XREF: sub_12626+30j
		sub	ax, ax
		push	ax
		push	ax
		push	ax
		push	ax
		mov	ax, 1700h
		push	ax
		mov	ax, [bp+var_2]
		add	ax, word_2D392
		mov	cx, 50h	; 'P'
		imul	cx
		add	ax, word_2A9DC
		add	ax, 2D0h
		push	ax
		mov	ax, 300h
		push	ax
		mov	ax, 3700h
		jmp	short loc_126D9
; ---------------------------------------------------------------------------

loc_12684:				; CODE XREF: sub_12626+Bj
		mov	ax, word_2CB4A
		add	ax, word_2CB95
		cwd
		sub	ax, dx
		sar	ax, 1
		sub	ax, 9Eh	; '�'
		cwd
		xor	ax, dx
		sub	ax, dx
		mov	cx, 3
		sar	ax, cl
		xor	ax, dx
		sub	ax, dx
		mov	[bp+var_2], ax
		cmp	ax, 0FFD8h
		jge	short loc_126AE
		mov	[bp+var_2], 0FFD8h

loc_126AE:				; CODE XREF: sub_12626+81j
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, 1900h
		push	ax
		mov	ax, [bp+var_2]
		add	ax, word_2D392
		mov	cx, 50h	; 'P'
		imul	cx
		add	ax, word_2A9DC
		add	ax, 0C80h
		push	ax
		mov	ax, 60h	; '`'
		push	ax
		mov	ax, 3C50h
		push	ax
		mov	ax, 10h
		push	ax
		mov	ax, 3A70h

loc_126D9:				; CODE XREF: sub_12626+5Cj
		push	ax
		call	sub_258D1
		mov	sp, bp
		pop	bp
		retf
sub_12626	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_126E4	proc far		; CODE XREF: sub_141D0+B6p
					; sub_141D0+146p ...
		cmp	word_2D37C, 1
		sbb	ax, ax
		neg	ax
		push	ax
		call	sub_2524E
		add	sp, 2
		push	word_2D37C
		call	sub_2524E
		add	sp, 2
		cmp	word_2D37C, 1
		sbb	ax, ax
		neg	ax
		push	ax
		call	sub_25188
		add	sp, 2
		push	word_2D37C
		call	sub_25188
		add	sp, 2
		cmp	word_2D37C, 1
		sbb	ax, ax
		neg	ax
		push	ax
		call	sub_251EA
		add	sp, 2
		push	word_2D37C
		call	sub_251EA
		add	sp, 2
		call	sub_252BE
		push	word_2CEE8
		push	cs
		call	near ptr sub_10286
		add	sp, 2
		cmp	word_2CBE0, 1
		sbb	ax, ax
		neg	ax
		mov	word_2CBE0, ax
		push	ax
		call	sub_262E6
		add	sp, 2
		call	sub_16184
		call	sub_16C56
		mov	ax, word_2CB50
		cmp	word_2CB52, ax
		jz	short loc_12780
		sub	ax, ax
		push	ax
		push	cs
		call	near ptr sub_104E6
		add	sp, 2

loc_12780:				; CODE XREF: sub_126E4+90j
		mov	ax, word_2CB50
		mov	word_2CB52, ax
		mov	ax, word_2CB9B
		cmp	word_2CB9D, ax
		jz	short loc_1279A
		mov	ax, 1
		push	ax
		push	cs
		call	near ptr sub_104E6
		add	sp, 2

loc_1279A:				; CODE XREF: sub_126E4+A9j
		mov	ax, word_2CB9B
		mov	word_2CB9D, ax
		retf
sub_126E4	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_127A2	proc far		; CODE XREF: sub_141D0+1F9p
		mov	ax, word_2D014
		add	word_2D01A, ax
		call	sub_25C60
		test	al, 1
		jnz	short loc_127B7
		call	sub_25C47

loc_127B7:				; CODE XREF: sub_127A2+Ej
		mov	ax, word_2D014
		sub	word_2D01A, ax
		mov	word_2D30C, 0
		or	ax, ax
		jle	short locret_127D5
		sub	word_2D014, 2
		jns	short locret_127D5
		mov	word_2D014, 0

locret_127D5:				; CODE XREF: sub_127A2+24j
					; sub_127A2+2Bj
		retf
sub_127A2	endp


; =============== S U B	R O U T	I N E =======================================


sub_127D6	proc far		; CODE XREF: sub_141D0+BAp
					; sub_141D0+14Ap ...
		cmp	word_2D392, 0
		jle	short loc_127E1
		dec	word_2D392

loc_127E1:				; CODE XREF: sub_127D6+5j
		cmp	word_2D392, 0
		jge	short loc_127EC
		inc	word_2D392

loc_127EC:				; CODE XREF: sub_127D6+10j
		call	MaybeWaitKey
		push	cs
		call	near ptr sub_12626
		push	word_2CBE0
		call	sub_262D1
		add	sp, 2
		retf
sub_127D6	endp


; =============== S U B	R O U T	I N E =======================================


sub_12802	proc far		; CODE XREF: sub_141D0+92p
					; sub_141D0+1DDp
		cmp	word_2A9DE, 0
		jnz	short locret_12820
		dec	word_2CB44
		jnz	short locret_12820
		mov	word_2CB44, 0Bh
		cmp	word_2CEE8, 0
		jle	short locret_12820
		dec	word_2CEE8

locret_12820:				; CODE XREF: sub_12802+5j sub_12802+Bj ...
		retf
sub_12802	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_12822	proc far		; CODE XREF: sub_141D0+1D2p
		mov	ax, word_2D37C
		mov	word_2CE16, ax
		cmp	ax, 1
		sbb	ax, ax
		neg	ax
		push	ax
		call	sub_2509E
		add	sp, 2
		push	word_2CE16
		call	sub_2509E
		add	sp, 2
		cmp	word_2CE16, 0
		jnz	short loc_12868
		sub	ax, ax
		push	ax
		mov	bx, PlayerCharID
		shl	bx, 1
		shl	bx, 1
		call	off_2ACB6[bx]
		add	sp, 2
		mov	ax, 1
		push	ax
		mov	bx, word_2CB40
		jmp	short loc_12882
; ---------------------------------------------------------------------------
		align 2

loc_12868:				; CODE XREF: sub_12822+27j
		mov	ax, 1
		push	ax
		mov	bx, word_2CB40
		shl	bx, 1
		shl	bx, 1
		call	off_2ACB6[bx]
		add	sp, 2
		sub	ax, ax
		push	ax
		mov	bx, PlayerCharID

loc_12882:				; CODE XREF: sub_12822+43j
		shl	bx, 1
		shl	bx, 1
		call	off_2ACB6[bx]
		add	sp, 2
		retf
sub_12822	endp


; =============== S U B	R O U T	I N E =======================================


sub_1288E	proc far		; CODE XREF: sub_141D0+67p
					; sub_141D0+1F5p
		cmp	word_2CE14, 0
		jnz	short loc_1289E
		call	sub_25C27
		mov	word_2CEE4, ax
		retf
; ---------------------------------------------------------------------------

loc_1289E:				; CODE XREF: sub_1288E+5j
		call	sub_25BD0
		mov	word_2CEE4, ax
		call	sub_25B79
		mov	word_2CEE6, ax
		retf
sub_1288E	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_128B0	proc far		; CODE XREF: sub_141D0+1FDp
		cmp	word_2CE14, 0
		jnz	short loc_128C2
		call	sub_25C27
		or	word_2CEE4, ax
		retf
; ---------------------------------------------------------------------------
		align 2

loc_128C2:				; CODE XREF: sub_128B0+5j
		call	sub_25BD0
		or	word_2CEE4, ax
		call	sub_25B79
		or	word_2CEE6, ax
		retf
sub_128B0	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_128D6	proc far		; CODE XREF: sub_141D0+1BAp
		cmp	word_2CE14, 0
		jnz	short loc_128EA
		call	sub_25C27
		mov	word_2CE18, ax
		or	word_2CEE4, ax
		retf
; ---------------------------------------------------------------------------

loc_128EA:				; CODE XREF: sub_128D6+5j
		call	sub_25BD0
		mov	word_2CE18, ax
		or	word_2CEE4, ax
		call	sub_25B79
		mov	word_2CE1A, ax
		or	word_2CEE6, ax
		retf
sub_128D6	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_12904	proc far		; CODE XREF: sub_141D0+215p
		call	sub_25AED
		and	al, 40h
		cmp	al, 40h	; '@'
		jnz	short locret_12946
		jmp	short loc_12917
; ---------------------------------------------------------------------------
		align 2

loc_12912:				; CODE XREF: sub_12904+1Ej
		call	MaybeWaitKey

loc_12917:				; CODE XREF: sub_12904+Bj
		call	sub_25AED
		and	al, 40h
		cmp	al, 40h	; '@'
		jnz	short loc_12929
		jmp	short loc_12912
; ---------------------------------------------------------------------------

loc_12924:				; CODE XREF: sub_12904+30j
		call	MaybeWaitKey

loc_12929:				; CODE XREF: sub_12904+1Cj
		call	sub_25AED
		and	al, 40h
		cmp	al, 40h	; '@'
		jz	short loc_1293B
		jmp	short loc_12924
; ---------------------------------------------------------------------------

loc_12936:				; CODE XREF: sub_12904+40j
		call	MaybeWaitKey

loc_1293B:				; CODE XREF: sub_12904+2Ej
		call	sub_25AED
		and	al, 40h
		cmp	al, 40h	; '@'
		jz	short loc_12936

locret_12946:				; CODE XREF: sub_12904+9j
		retf
sub_12904	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_12948	proc far		; CODE XREF: DoClearScr_A1+92p
					; DoClearScr_A1+DDp ...
		jmp	short loc_1294F
; ---------------------------------------------------------------------------

loc_1294A:				; CODE XREF: sub_12948+10j
		call	MaybeWaitKey

loc_1294F:				; CODE XREF: sub_12948j
		call	sub_25C27
		test	al, 30h
		jnz	short loc_1295F
		jmp	short loc_1294A
; ---------------------------------------------------------------------------

loc_1295A:				; CODE XREF: sub_12948+1Ej
		call	MaybeWaitKey

loc_1295F:				; CODE XREF: sub_12948+Ej
		call	sub_25C27
		test	al, 30h
		jnz	short loc_1295A
		retf
sub_12948	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

DoPlayerWinScr	proc far		; CODE XREF: sub_1455A+89p
					; sub_145EA+8Ap ...

var_20		= word ptr -20h
var_1E		= word ptr -1Eh
var_1C		= word ptr -1Ch
var_1A		= word ptr -1Ah
var_18		= byte ptr -18h
var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 20h
		push	di
		push	si
		mov	[bp+var_2], 0
		call	sub_15322
		call	sub_260C5
		mov	ax, 28h	; '('
		push	ax
		call	sub_2591C
		add	sp, 2
		sub	ax, ax
		push	ax
		push	ax
		push	ax
		push	ax
		push	ax
		push	ax
		mov	ax, 1900h
		push	ax
		sub	ax, ax
		push	ax
		call	sub_258D1
		add	sp, 10h
		sub	ax, ax
		push	ax
		call	sub_262E6
		add	sp, 2
		sub	ax, ax
		push	ax
		call	sub_262D1
		add	sp, 2
		call	sub_260A7
		mov	ax, offset aAVg14_0 ; "a:vg14"
		push	ax
		call	LoadMusic2
		add	sp, 2
		mov	word_2D3BE, ax
		mov	ax, offset aAVg12 ; "a:vg12"
		push	ax
		call	LoadMusic	; VG12:	Player Win
		add	sp, 2
		mov	word_2D3B0, ax
		sub	ax, ax
		push	ax
		call	sub_262E6
		add	sp, 2
		call	sub_26403
		mov	ax, 1
		push	ax
		call	sub_262E6
		add	sp, 2
		call	sub_26403
		sub	ax, ax
		push	ax
		call	sub_262E6
		add	sp, 2
		sub	ax, ax
		push	ax
		call	sub_262D1
		add	sp, 2
		mov	ax, 25
		push	ax
		mov	ax, 72
		push	ax
		mov	ax, 18
		push	ax
		mov	ax, 8
		push	ax
		call	SetupTextBox
		add	sp, 8
		mov	ax, 8
		push	ax
		call	SetTextColor
		add	sp, 2
		sub	ax, ax
		push	ax
		push	ax
		call	SetTextPosition
		add	sp, 4
		mov	ax, word_2D018
		cmp	word_2D016, ax
		jle	short loc_12AC4
		mov	ax, PlayerCharID
		mov	[bp+var_1A], ax
		mov	ax, word_2CB40
		mov	[bp+var_20], ax
		cmp	word_2D018, 1
		jnz	short loc_12A68
		mov	[bp+var_4], 2
		jmp	short loc_12A6D
; ---------------------------------------------------------------------------
		align 2

loc_12A68:				; CODE XREF: DoPlayerWinScr+F4j
		mov	[bp+var_4], 0

loc_12A6D:				; CODE XREF: DoPlayerWinScr+FBj
		mov	bx, [bp+var_1A]
		shl	bx, 1
		push	fName_Character[bx]
		mov	ax, offset aK1	; "k1"
		push	ax
		lea	ax, [bp+var_18]
		push	ax
		call	strcat
		add	sp, 6
		mov	ax, 1
		push	ax
		mov	ax, 100
		push	ax
		mov	ax, 10
		push	ax
		lea	ax, [bp+var_18]
		push	ax
		call	LoadGEM
		add	sp, 8
		mov	bx, [bp+var_20]
		shl	bx, 1
		push	fName_Character[bx]
		mov	ax, offset aK2_0 ; "k2"
		push	ax
		lea	ax, [bp+var_18]
		push	ax
		call	strcat
		add	sp, 6
		mov	ax, 1
		push	ax
		mov	ax, 100
		push	ax
		mov	ax, 50
		jmp	short loc_12B38
; ---------------------------------------------------------------------------

loc_12AC4:				; CODE XREF: DoPlayerWinScr+E1j
		mov	ax, word_2CB40
		mov	[bp+var_1A], ax
		mov	ax, PlayerCharID
		mov	[bp+var_20], ax
		cmp	word_2D016, 1
		jnz	short loc_12ADE
		mov	[bp+var_4], 2
		jmp	short loc_12AE3
; ---------------------------------------------------------------------------

loc_12ADE:				; CODE XREF: DoPlayerWinScr+16Bj
		mov	[bp+var_4], 0

loc_12AE3:				; CODE XREF: DoPlayerWinScr+172j
		mov	bx, [bp+var_1A]
		shl	bx, 1
		push	fName_Character[bx]
		mov	ax, offset aK1_0 ; "k1"
		push	ax
		lea	ax, [bp+var_18]
		push	ax
		call	strcat
		add	sp, 6
		mov	ax, 1
		push	ax
		mov	ax, 100
		push	ax
		mov	ax, 50
		push	ax
		lea	ax, [bp+var_18]
		push	ax
		call	LoadGEM
		add	sp, 8
		mov	bx, [bp+var_20]
		shl	bx, 1
		push	fName_Character[bx]
		mov	ax, offset aK2_1 ; "k2"
		push	ax
		lea	ax, [bp+var_18]
		push	ax
		call	strcat
		add	sp, 6
		mov	ax, 1
		push	ax
		mov	ax, 100
		push	ax
		mov	ax, 10

loc_12B38:				; CODE XREF: DoPlayerWinScr+158j
		push	ax
		lea	ax, [bp+var_18]
		push	ax
		call	LoadGEM
		add	sp, 8
		call	sub_26089
		mov	bx, [bp+var_1A]
		shl	bx, 1
		push	fName_Character[bx]
		mov	ax, offset a_txt ; ".txt"
		push	ax
		lea	ax, [bp+var_18]
		push	ax
		call	strcat
		add	sp, 6
		lea	ax, [bp+var_18]
		push	ax
		call	MaybeLoadFile
		add	sp, 2
		mov	[bp+var_1C], ax
		push	ax
		call	sub_15496
		add	sp, 2
		mov	[bp+var_1E], ax
		mov	bx, ax
		shl	bx, 1
		shl	bx, 1
		push	word_2CE1C[bx]
		lea	ax, [bp+var_18]
		push	ax
		call	sub_29694
		add	sp, 4
		cmp	word_2A9E2, 5
		jz	short loc_12BC6
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, 3
		push	ax
		call	sub_29701
		add	sp, 6
		sub	ax, ax
		push	ax
		mov	bx, word_2D3B0
		shl	bx, 1
		shl	bx, 1
		push	word_2CE1C[bx]
		mov	ax, 1
		push	ax
		call	sub_29701
		add	sp, 6

loc_12BC6:				; CODE XREF: DoPlayerWinScr+22Fj
		mov	ax, [bp+var_20]
		mov	cx, ax
		shl	ax, 1
		add	ax, cx
		add	ax, [bp+var_4]
		push	ax
		mov	bx, [bp+var_1E]
		shl	bx, 1
		shl	bx, 1
		push	word_2CE1C[bx]
		call	j_LoadText_ES
		add	sp, 4
		mov	di, [bp+arg_0]
		mov	si, [bp+var_2]
		jmp	short loc_12C49
; ---------------------------------------------------------------------------

loc_12BEE:				; CODE XREF: DoPlayerWinScr+2E6j
		or	si, si
		jnz	short loc_12C52
		call	sub_25C60
		and	ax, 8000h
		cmp	ax, 8000h
		jnz	short loc_12C49
		cmp	di, 1
		jnz	short loc_12C49
		cmp	word_2A9E2, 5
		jz	short loc_12C46
		mov	al, byte ptr word_2CB42
		and	al, 1
		cmp	al, 1
		jnz	short loc_12C46
		cmp	word_2A9F2, 0
		jnz	short loc_12C46
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, 3
		push	ax
		call	sub_29701
		add	sp, 6
		sub	ax, ax
		push	ax
		mov	bx, word_2D3BE
		shl	bx, 1
		shl	bx, 1
		push	word_2CE1C[bx]
		mov	ax, 1
		push	ax
		call	sub_29701
		add	sp, 6

loc_12C46:				; CODE XREF: DoPlayerWinScr+29Fj
					; DoPlayerWinScr+2A8j ...
		mov	si, 1

loc_12C49:				; CODE XREF: DoPlayerWinScr+282j
					; DoPlayerWinScr+293j ...
		call	sub_25C27
		test	al, 30h
		jz	short loc_12BEE

loc_12C52:				; CODE XREF: DoPlayerWinScr+286j
		mov	[bp+var_2], si
		push	cs
		call	near ptr sub_1004E
		call	sub_1548C
		call	sub_260A7
		sub	ax, ax
		push	ax
		call	sub_262D1
		add	sp, 2
		sub	ax, ax
		push	ax
		call	sub_262E6
		add	sp, 2
		call	sub_26403
		mov	ax, 1
		push	ax
		call	sub_262E6
		add	sp, 2
		call	sub_26403
		call	sub_26089
		mov	ax, si
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
DoPlayerWinScr	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

DoClearScr_A1	proc far		; CODE XREF: sub_133B4+97p

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, offset aBVg10 ; "b:vg10"
		push	ax
		call	LoadMusic	; VG10:	Clear screen 1
		add	sp, 2
		mov	word_2D3BC, ax
		cmp	word_2A9E2, 5
		jz	short loc_12CE1
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, 3
		push	ax
		call	sub_29701
		add	sp, 6
		sub	ax, ax
		push	ax
		mov	bx, word_2D3BC
		shl	bx, 1
		shl	bx, 1
		push	word_2CE1C[bx]
		mov	ax, 1
		push	ax
		call	sub_29701
		add	sp, 6

loc_12CE1:				; CODE XREF: DoClearScr_A1+18j
		mov	ax, 1
		push	ax
		sub	ax, ax
		push	ax
		push	ax
		mov	si, [bp+arg_0]
		shl	si, 1
		mov	bx, word_2A9E8
		shl	bx, 1
		shl	bx, 1
		push	word_2D01A[bx+si]
		call	LoadHEM_1
		add	sp, 8
		push	cs
		call	near ptr sub_10094
		call	sub_157BA
		call	sub_26089
		call	sub_157DE
		sub	ax, ax
		push	ax
		push	ax
		call	SetTextPosition
		add	sp, 4
		mov	ax, 0Fh
		push	ax
		call	SetTextColor
		add	sp, 2
		push	cs
		call	near ptr sub_12948
		cmp	[bp+arg_0], 1
		jnz	short loc_12D54
		mov	ax, 23
		push	ax
		mov	ax, 78
		push	ax
		mov	ax, 23
		push	ax
		mov	ax, 2
		push	ax
		call	SomethingTextBox
		add	sp, 8
		mov	ax, offset aBuvibckomxvMiv ; "�u���c�o��͌��߂Ă����ǁc����ς�c�p�"...
		jmp	short loc_12D7F
; ---------------------------------------------------------------------------

loc_12D54:				; CODE XREF: DoClearScr_A1+99j
		mov	ax, 23
		push	ax
		mov	ax, 78
		push	ax
		mov	ax, 21
		push	ax
		mov	ax, 2
		push	ax
		call	SomethingTextBox
		add	sp, 8
		mov	ax, offset aBuvabcvVqbcvvv ; "�u���c�ӂ��c����c�񂭂��A�ςɁc�{�N�c�"...
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_12948
		mov	ax, offset aBuvavqvBavtvBa ; "�u�������A�₾�A�c�����Ⴄ�悧�c�������"...

loc_12D7F:				; CODE XREF: DoClearScr_A1+B6j
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_12948
		push	cs
		call	near ptr sub_1004E
		push	word_2D3BC
		call	sub_154E4
		add	sp, 2
		cmp	[bp+arg_0], 1
		jnz	short loc_12DC4
		cmp	word_2A9E2, 5
		jz	short loc_12DC4
		sub	ax, ax
		push	ax
		mov	bx, word_2D3B0
		shl	bx, 1
		shl	bx, 1
		push	word_2CE1C[bx]
		mov	ax, 1
		push	ax
		call	sub_29701
		add	sp, 6

loc_12DC4:				; CODE XREF: DoClearScr_A1+104j
					; DoClearScr_A1+10Bj
		pop	si
		pop	bp
		retf
DoClearScr_A1	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

DoClearScr_A2	proc far		; CODE XREF: sub_133B4+A5p

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, offset aBVg11 ; "b:vg11"
		push	ax
		call	LoadMusic	; VG11:	Clear screen 2
		add	sp, 2
		mov	word_2D3BC, ax
		cmp	word_2A9E2, 5
		jz	short loc_12E0D
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, 3
		push	ax
		call	sub_29701
		add	sp, 6
		sub	ax, ax
		push	ax
		mov	bx, word_2D3BC
		shl	bx, 1
		shl	bx, 1
		push	word_2CE1C[bx]
		mov	ax, 1
		push	ax
		call	sub_29701
		add	sp, 6

loc_12E0D:				; CODE XREF: DoClearScr_A2+18j
		mov	ax, 1
		push	ax
		sub	ax, ax
		push	ax
		push	ax
		mov	si, [bp+arg_0]
		shl	si, 1
		mov	bx, word_2A9E8
		shl	bx, 1
		shl	bx, 1
		push	word_2D01A[bx+si]
		call	LoadHEM_1
		add	sp, 8
		push	cs
		call	near ptr sub_10094
		call	sub_157BA
		call	sub_26089
		call	sub_157DE
		sub	ax, ax
		push	ax
		push	ax
		call	SetTextPosition
		add	sp, 4
		mov	ax, 0Fh
		push	ax
		call	SetTextColor
		add	sp, 2
		push	cs
		call	near ptr sub_12948
		cmp	[bp+arg_0], 1
		jnz	short loc_12E80
		mov	ax, 23
		push	ax
		mov	ax, 78
		push	ax
		mov	ax, 23
		push	ax
		mov	ax, 2
		push	ax
		call	SomethingTextBox
		add	sp, 8
		mov	ax, offset aBuvVcvqvBcvVVV ; "�u���炟���c����Ȃ̕����ĂȂ������c���"...
		jmp	short loc_12EAB
; ---------------------------------------------------------------------------

loc_12E80:				; CODE XREF: DoClearScr_A2+99j
		mov	ax, 23
		push	ax
		mov	ax, 78
		push	ax
		mov	ax, 21
		push	ax
		mov	ax, 2
		push	ax
		call	SomethingTextBox
		add	sp, 8
		mov	ax, offset aBuvvvtvqbcvavB ; "�u���₟�c�����A���c�M���c�M�����c�񂟁"...
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_12948
		mov	ax, offset aBubcvtvBcmivVv ; "�u�c�₾�c���Ȃ��c�Łc����c�������c���"...

loc_12EAB:				; CODE XREF: DoClearScr_A2+B6j
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_12948
		push	cs
		call	near ptr sub_1004E
		push	word_2D3BC
		call	sub_154E4
		add	sp, 2
		cmp	[bp+arg_0], 1
		jnz	short loc_12EF0
		cmp	word_2A9E2, 5
		jz	short loc_12EF0
		sub	ax, ax
		push	ax
		mov	bx, word_2D3B0
		shl	bx, 1
		shl	bx, 1
		push	word_2CE1C[bx]
		mov	ax, 1
		push	ax
		call	sub_29701
		add	sp, 6

loc_12EF0:				; CODE XREF: DoClearScr_A2+104j
					; DoClearScr_A2+10Bj
		pop	si
		pop	bp
		retf
DoClearScr_A2	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

DoClearScr_B1	proc far		; CODE XREF: sub_133B4+AFp

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, offset aBVg10_0 ; "b:vg10"
		push	ax
		call	LoadMusic	; VG10:	Clear screen 1
		add	sp, 2
		mov	word_2D3BC, ax
		cmp	word_2A9E2, 5
		jz	short loc_12F39
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, 3
		push	ax
		call	sub_29701
		add	sp, 6
		sub	ax, ax
		push	ax
		mov	bx, word_2D3BC
		shl	bx, 1
		shl	bx, 1
		push	word_2CE1C[bx]
		mov	ax, 1
		push	ax
		call	sub_29701
		add	sp, 6

loc_12F39:				; CODE XREF: DoClearScr_B1+18j
		mov	ax, 1
		push	ax
		sub	ax, ax
		push	ax
		push	ax
		mov	si, [bp+arg_0]
		shl	si, 1
		mov	bx, word_2A9E8
		shl	bx, 1
		shl	bx, 1
		push	word_2D01A[bx+si]
		call	LoadHEM_1
		add	sp, 8
		push	cs
		call	near ptr sub_10094
		call	sub_157BA
		call	sub_26089
		call	sub_157DE
		sub	ax, ax
		push	ax
		push	ax
		call	SetTextPosition
		add	sp, 4
		mov	ax, 0Fh
		push	ax
		call	SetTextColor
		add	sp, 2
		push	cs
		call	near ptr sub_12948
		cmp	[bp+arg_0], 1
		jnz	short loc_12FAC
		mov	ax, 17h
		push	ax
		mov	ax, 4Eh	; 'N'
		push	ax
		mov	ax, 17h
		push	ax
		mov	ax, 2
		push	ax
		call	SomethingTextBox
		add	sp, 8
		mov	ax, offset aBubcvivVkvvvtv ; "�u�c���˂����₩��A�����߂�Ƃ��āc�B�"...
		jmp	short loc_12FE7
; ---------------------------------------------------------------------------

loc_12FAC:				; CODE XREF: DoClearScr_B1+99j
		mov	ax, 17h
		push	ax
		mov	ax, 4Eh	; 'N'
		push	ax
		mov	ax, 13h
		push	ax
		mov	ax, 2
		push	ax
		call	SomethingTextBox
		add	sp, 8
		mov	ax, offset aBubcbcvBcvgvav ; "�u�c�c�Ӂc�������c�����c���͂��c�vnn"
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_12948
		mov	ax, offset aBubcbcvVVebcvq ; "�u�c�c���߂��c���Ӂc�܂Ȃ݂����c�ւ�"...
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_12948
		mov	ax, offset aBubcbcvVVqvBcv ; "�u�c�c��񂟂��c��c�͂����c�����c�����"...

loc_12FE7:				; CODE XREF: DoClearScr_B1+B6j
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_12948
		push	cs
		call	near ptr sub_1004E
		push	word_2D3BC
		call	sub_154E4
		add	sp, 2
		cmp	[bp+arg_0], 1
		jnz	short loc_1302C
		cmp	word_2A9E2, 5
		jz	short loc_1302C
		sub	ax, ax
		push	ax
		mov	bx, word_2D3B0
		shl	bx, 1
		shl	bx, 1
		push	word_2CE1C[bx]
		mov	ax, 1
		push	ax
		call	sub_29701
		add	sp, 6

loc_1302C:				; CODE XREF: DoClearScr_B1+114j
					; DoClearScr_B1+11Bj
		pop	si
		pop	bp
		retf
DoClearScr_B1	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

DoClearScr_B2	proc far		; CODE XREF: sub_133B4+B9p

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, offset aBVg11_0 ; "b:vg11"
		push	ax
		call	LoadMusic	; VG11:	Clear screen 2
		add	sp, 2
		mov	word_2D3BC, ax
		cmp	word_2A9E2, 5
		jz	short loc_13075
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, 3
		push	ax
		call	sub_29701
		add	sp, 6
		sub	ax, ax
		push	ax
		mov	bx, word_2D3BC
		shl	bx, 1
		shl	bx, 1
		push	word_2CE1C[bx]
		mov	ax, 1
		push	ax
		call	sub_29701
		add	sp, 6

loc_13075:				; CODE XREF: DoClearScr_B2+18j
		mov	ax, 1
		push	ax
		sub	ax, ax
		push	ax
		push	ax
		mov	si, [bp+arg_0]
		shl	si, 1
		mov	bx, word_2A9E8
		shl	bx, 1
		shl	bx, 1
		push	word_2D01A[bx+si]
		call	LoadHEM_1
		add	sp, 8
		push	cs
		call	near ptr sub_10094
		call	sub_157BA
		call	sub_26089
		call	sub_157DE
		sub	ax, ax
		push	ax
		push	ax
		call	SetTextPosition
		add	sp, 4
		mov	ax, 0Fh
		push	ax
		call	SetTextColor
		add	sp, 2
		push	cs
		call	near ptr sub_12948
		cmp	[bp+arg_0], 1
		jnz	short loc_130E8
		mov	ax, 17h
		push	ax
		mov	ax, 4Eh	; 'N'
		push	ax
		mov	ax, 17h
		push	ax
		mov	ax, 2
		push	ax
		call	SomethingTextBox
		add	sp, 8
		mov	ax, offset aBubcvVVKindvVV ; "�u�c����Ȋi�D�����āc�����l���Ă���́"...
		jmp	short loc_13113
; ---------------------------------------------------------------------------

loc_130E8:				; CODE XREF: DoClearScr_B2+99j
		mov	ax, 17h
		push	ax
		mov	ax, 4Eh	; 'N'
		push	ax
		mov	ax, 15h
		push	ax
		mov	ax, 2
		push	ax
		call	SomethingTextBox
		add	sp, 8
		mov	ax, offset aButBcvtbcvtvVB ; "�u�Ɂc��c��߂āc����ȁc�ǂ����āc��"...
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_12948
		mov	ax, offset aBubcvavavBctVV ; "�u�c�������c���߂��āc���那���c�����"...

loc_13113:				; CODE XREF: DoClearScr_B2+B6j
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_12948
		push	cs
		call	near ptr sub_1004E
		push	word_2D3BC
		call	sub_154E4
		add	sp, 2
		cmp	[bp+arg_0], 1
		jnz	short loc_13158
		cmp	word_2A9E2, 5
		jz	short loc_13158
		sub	ax, ax
		push	ax
		mov	bx, word_2D3B0
		shl	bx, 1
		shl	bx, 1
		push	word_2CE1C[bx]
		mov	ax, 1
		push	ax
		call	sub_29701
		add	sp, 6

loc_13158:				; CODE XREF: DoClearScr_B2+104j
					; DoClearScr_B2+10Bj
		pop	si
		pop	bp
		retf
DoClearScr_B2	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

DoClearScr_C1	proc far		; CODE XREF: sub_133B4+C3p

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, offset aBVg10_1 ; "b:vg10"
		push	ax
		call	LoadMusic	; VG10:	Clear screen 1
		add	sp, 2
		mov	word_2D3BC, ax
		cmp	word_2A9E2, 5
		jz	short loc_131A1
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, 3
		push	ax
		call	sub_29701
		add	sp, 6
		sub	ax, ax
		push	ax
		mov	bx, word_2D3BC
		shl	bx, 1
		shl	bx, 1
		push	word_2CE1C[bx]
		mov	ax, 1
		push	ax
		call	sub_29701
		add	sp, 6

loc_131A1:				; CODE XREF: DoClearScr_C1+18j
		mov	ax, 1
		push	ax
		sub	ax, ax
		push	ax
		push	ax
		mov	si, [bp+arg_0]
		shl	si, 1
		mov	bx, word_2A9E8
		shl	bx, 1
		shl	bx, 1
		push	word_2D01A[bx+si]
		call	LoadHEM_1
		add	sp, 8
		push	cs
		call	near ptr sub_10094
		call	sub_157BA
		call	sub_26089
		call	sub_157DE
		sub	ax, ax
		push	ax
		push	ax
		call	SetTextPosition
		add	sp, 4
		mov	ax, 0Fh
		push	ax
		call	SetTextColor
		add	sp, 2
		push	cs
		call	near ptr sub_12948
		cmp	[bp+arg_0], 1
		jnz	short loc_13214
		mov	ax, 17h
		push	ax
		mov	ax, 4Eh	; 'N'
		push	ax
		mov	ax, 17h
		push	ax
		mov	ax, 2
		push	ax
		call	SomethingTextBox
		add	sp, 8
		mov	ax, 747h
		jmp	short loc_1323F
; ---------------------------------------------------------------------------

loc_13214:				; CODE XREF: DoClearScr_C1+99j
		mov	ax, 17h
		push	ax
		mov	ax, 4Eh	; 'N'
		push	ax
		mov	ax, 15h
		push	ax
		mov	ax, 2
		push	ax
		call	SomethingTextBox
		add	sp, 8
		mov	ax, offset aBubcvlvsbcvVVV ; "�u�c����c�߂������c�ȂɁc����c�H�c�"...
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_12948
		mov	ax, offset aBubcvtvVBclcoa ; "�u�c��߂āc�C�����c���c�������c����c�"...

loc_1323F:				; CODE XREF: DoClearScr_C1+B6j
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_12948
		push	cs
		call	near ptr sub_1004E
		push	word_2D3BC
		call	sub_154E4
		add	sp, 2
		cmp	[bp+arg_0], 1
		jnz	short loc_13284
		cmp	word_2A9E2, 5
		jz	short loc_13284
		sub	ax, ax
		push	ax
		mov	bx, word_2D3B0
		shl	bx, 1
		shl	bx, 1
		push	word_2CE1C[bx]
		mov	ax, 1
		push	ax
		call	sub_29701
		add	sp, 6

loc_13284:				; CODE XREF: DoClearScr_C1+104j
					; DoClearScr_C1+10Bj
		pop	si
		pop	bp
		retf
DoClearScr_C1	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

DoClearScr_C2	proc far		; CODE XREF: sub_133B4+CDp

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, offset aDVg11x ; "d:vg11x"
		push	ax
		call	LoadMusic	; VG11X: Clear screen 2
		add	sp, 2
		mov	word_2D3BC, ax
		cmp	word_2A9E2, 5
		jz	short loc_132CD
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, 3
		push	ax
		call	sub_29701
		add	sp, 6
		sub	ax, ax
		push	ax
		mov	bx, word_2D3BC
		shl	bx, 1
		shl	bx, 1
		push	word_2CE1C[bx]
		mov	ax, 1
		push	ax
		call	sub_29701
		add	sp, 6

loc_132CD:				; CODE XREF: DoClearScr_C2+18j
		mov	ax, 1
		push	ax
		sub	ax, ax
		push	ax
		push	ax
		mov	si, [bp+arg_0]
		shl	si, 1
		mov	bx, word_2A9E8
		shl	bx, 1
		shl	bx, 1
		push	word_2D01A[bx+si]
		call	LoadGEM
		add	sp, 8
		push	cs
		call	near ptr sub_10094
		call	sub_157BA
		call	sub_26089
		call	sub_157DE
		sub	ax, ax
		push	ax
		push	ax
		call	SetTextPosition
		add	sp, 4
		mov	ax, 0Fh
		push	ax
		call	SetTextColor
		add	sp, 2
		push	cs
		call	near ptr sub_12948
		cmp	[bp+arg_0], 1
		jnz	short loc_13340
		mov	ax, 17h
		push	ax
		mov	ax, 4Eh	; 'N'
		push	ax
		mov	ax, 17h
		push	ax
		mov	ax, 2
		push	ax
		call	SomethingTextBox
		add	sp, 8
		mov	ax, 7E6h
		jmp	short loc_1336B
; ---------------------------------------------------------------------------

loc_13340:				; CODE XREF: DoClearScr_C2+99j
		mov	ax, 17h
		push	ax
		mov	ax, 4Eh	; 'N'
		push	ax
		mov	ax, 15h
		push	ax
		mov	ax, 2
		push	ax
		call	SomethingTextBox
		add	sp, 8
		mov	ax, offset aBubcvBavVVVBcv ; "�u�c���A����Ȃ��c����ȁc�i�D�c�Łc���"...
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_12948
		mov	ax, offset aBubcvtbcvBcvtv ; "�u�c��c���c��߂āc���Ȃ��ł����c�c���"...

loc_1336B:				; CODE XREF: DoClearScr_C2+B6j
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_12948
		push	cs
		call	near ptr sub_1004E
		push	word_2D3BC
		call	sub_154E4
		add	sp, 2
		cmp	[bp+arg_0], 1
		jnz	short loc_133B0
		cmp	word_2A9E2, 5
		jz	short loc_133B0
		sub	ax, ax
		push	ax
		mov	bx, word_2D3B0
		shl	bx, 1
		shl	bx, 1
		push	word_2CE1C[bx]
		mov	ax, 1
		push	ax
		call	sub_29701
		add	sp, 6

loc_133B0:				; CODE XREF: DoClearScr_C2+104j
					; DoClearScr_C2+10Bj
		pop	si
		pop	bp
		retf
DoClearScr_C2	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_133B4	proc far		; CODE XREF: sub_141D0+320p
		push	cs
		call	near ptr sub_1004E
		call	sub_15860
		call	sub_1574A
		call	sub_260A7
		call	sub_2604D
		push	cs
		call	near ptr sub_12490
		call	sub_260C5
		mov	ax, 1
		push	ax
		call	sub_262E6
		add	sp, 2
		call	sub_26403
		sub	ax, ax
		push	ax
		call	sub_262E6
		add	sp, 2
		call	sub_26403
		sub	ax, ax
		push	ax
		call	sub_262D1
		add	sp, 2
		mov	ax, 28h	; '('
		push	ax
		call	sub_2591C
		add	sp, 2
		sub	ax, ax
		push	ax
		push	ax
		push	ax
		push	ax
		push	ax
		push	ax
		mov	ax, 1900h
		push	ax
		sub	ax, ax
		push	ax
		call	sub_258D1
		add	sp, 10h
		mov	ax, word_2CB40
		or	ax, ax
		jz	short loc_13446
		cmp	ax, 1
		jz	short loc_13454
		cmp	ax, 2
		jz	short loc_1345E
		cmp	ax, 3
		jz	short loc_13468
		cmp	ax, 4
		jz	short loc_13472
		cmp	ax, 5
		jz	short loc_1347C
		jmp	short loc_13486
; ---------------------------------------------------------------------------

loc_13446:				; CODE XREF: sub_133B4+75j
		push	word_2D016
		push	cs
		call	near ptr DoClearScr_A1

loc_1344E:				; CODE XREF: sub_133B4+A8j
					; sub_133B4+B2j ...
		add	sp, 2
		jmp	short loc_13486
; ---------------------------------------------------------------------------
		align 2

loc_13454:				; CODE XREF: sub_133B4+7Aj
		push	word_2D016
		push	cs
		call	near ptr DoClearScr_A2
		jmp	short loc_1344E
; ---------------------------------------------------------------------------

loc_1345E:				; CODE XREF: sub_133B4+7Fj
		push	word_2D016
		push	cs
		call	near ptr DoClearScr_B1
		jmp	short loc_1344E
; ---------------------------------------------------------------------------

loc_13468:				; CODE XREF: sub_133B4+84j
		push	word_2D016
		push	cs
		call	near ptr DoClearScr_B2
		jmp	short loc_1344E
; ---------------------------------------------------------------------------

loc_13472:				; CODE XREF: sub_133B4+89j
		push	word_2D016
		push	cs
		call	near ptr DoClearScr_C1
		jmp	short loc_1344E
; ---------------------------------------------------------------------------

loc_1347C:				; CODE XREF: sub_133B4+8Ej
		push	word_2D016
		push	cs
		call	near ptr DoClearScr_C2
		jmp	short loc_1344E
; ---------------------------------------------------------------------------

loc_13486:				; CODE XREF: sub_133B4+90j
					; sub_133B4+9Dj
		call	sub_15860
		call	sub_2606B
		call	sub_260A7
		call	sub_15782
		push	cs
		call	near ptr sub_12472
		retf
sub_133B4	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


DoEnd0_Yuka	proc far		; CODE XREF: sub_14DDC+1CBp
		mov	ax, offset aDVgefex ; "d:vgefex"
		push	ax
		call	LoadSFX
		add	sp, 2
		mov	word_2D3AE, ax
		mov	ax, offset aDVg15 ; "d:vg15"
		push	ax
		call	LoadMusic	; VG15:	Yuka Ending
		add	sp, 2
		mov	word_2D3B0, ax
		cmp	word_2A9E2, 5
		jz	short loc_1350B
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, 3
		push	ax
		call	sub_29701
		add	sp, 6
		sub	ax, ax
		push	ax
		mov	bx, word_2D3AE
		shl	bx, 1
		shl	bx, 1
		push	word_2CE1C[bx]
		mov	ax, 6
		push	ax
		call	sub_29701
		add	sp, 6
		sub	ax, ax
		push	ax
		mov	bx, word_2D3B0
		shl	bx, 1
		shl	bx, 1
		push	word_2CE1C[bx]
		mov	ax, 1
		push	ax
		call	sub_29701
		add	sp, 6

loc_1350B:				; CODE XREF: DoEnd0_Yuka+23j
		call	sub_260A7
		call	sub_2604D
		call	sub_260C5
		mov	ax, 1
		push	ax
		call	sub_262E6
		add	sp, 2
		call	sub_26403
		sub	ax, ax
		push	ax
		call	sub_262E6
		add	sp, 2
		call	sub_26403
		sub	ax, ax
		push	ax
		call	sub_262D1
		add	sp, 2
		mov	ax, 28h	; '('
		push	ax
		call	sub_2591C
		add	sp, 2
		sub	ax, ax
		push	ax
		push	ax
		push	ax
		push	ax
		push	ax
		push	ax
		mov	ax, 1900h
		push	ax
		sub	ax, ax
		push	ax
		call	sub_258D1
		add	sp, 10h
		mov	ax, 1
		push	ax
		sub	ax, ax
		push	ax
		push	ax
		mov	bx, PlayerCharID
		shl	bx, 1
		shl	bx, 1
		push	word_2D2F0[bx]
		call	LoadGEM
		add	sp, 8
		push	cs
		call	near ptr sub_10094
		call	sub_157BA
		call	sub_26089
		call	sub_157DE
		sub	ax, ax
		push	ax
		push	ax
		call	SetTextPosition
		add	sp, 4
		mov	ax, 0Fh
		push	ax
		call	SetTextColor
		add	sp, 2
		mov	ax, 24
		push	ax
		mov	ax, 76
		push	ax
		mov	ax, 22
		push	ax
		mov	ax, 4
		push	ax
		call	SomethingTextBox
		add	sp, 8
		mov	ax, offset aBuvVVBcuCIBavi ; "�u����Łc���{��A���B�c���ւցc������"...
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_12948
		call	ClearTextBox
		call	sub_15860
		call	sub_260A7
		call	sub_26403
		call	sub_26089
		call	sub_157DE
		mov	ax, offset aBRffnmubN ;	"�|���N��|n"
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_12948
		call	sub_15860
		call	sub_260A7
		mov	ax, 1
		push	ax
		sub	ax, ax
		push	ax
		push	ax
		mov	bx, PlayerCharID
		shl	bx, 1
		shl	bx, 1
		push	(word_2D2F0+2)[bx]
		call	LoadGEM
		add	sp, 8
		push	cs
		call	near ptr sub_10094
		call	sub_157BA
		call	sub_26089
		mov	ax, 1Bh
		push	ax
		call	sub_15BEE
		add	sp, 2
		call	sub_157DE
		sub	ax, ax
		push	ax
		push	ax
		call	SetTextPosition
		add	sp, 4
		mov	ax, offset aBuvVBibhnbvIVB ; "�u�ȂɁI�H���̉��́I�H�vn"
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_12948
		mov	ax, offset aBucdnbvkbavVBw ; "�u�D�����A�܂��w�S��e�x�������񂾂��Ă"...
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_12948
		mov	ax, offset aBubcvjbVBhvVVq ; "�u�c���[���H�܂����H�vn"
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_12948
		call	ClearTextBox
		mov	ax, offset aBubcvVBcvtvVVs ; "�u�c�܂��c�����������c�vn"
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_12948
		mov	ax, offset aXrurb@cdnbbbvi ; "�����@�D���B���˂Ă���̊�]�ʂ�A�w�l�"...
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_12948
		mov	ax, offset aBcvkbabwoscpvI ; "�c���A�w�s���Ɉ������w�l�x���x�ɂ́A�"...
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_12948
		call	sub_15860
		call	sub_260A7
		push	cs
		call	near ptr sub_1004E
		push	word_2D3B0
		call	sub_154E4
		add	sp, 2
		push	word_2D3AE
		call	sub_154E4
		add	sp, 2
		retf
DoEnd0_Yuka	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


DoEnd1_Jun	proc far		; CODE XREF: sub_14DDC+1DBp
		mov	ax, offset aDVg18 ; "d:vg18"
		push	ax
		call	LoadMusic	; VG18:	Jun Ending
		add	sp, 2
		mov	word_2D3B0, ax
		call	sub_260A7
		call	sub_2604D
		call	sub_260C5
		mov	ax, 1
		push	ax
		call	sub_262E6
		add	sp, 2
		call	sub_26403
		sub	ax, ax
		push	ax
		call	sub_262E6
		add	sp, 2
		call	sub_26403
		sub	ax, ax
		push	ax
		call	sub_262D1
		add	sp, 2
		mov	ax, 28h	; '('
		push	ax
		call	sub_2591C
		add	sp, 2
		sub	ax, ax
		push	ax
		push	ax
		push	ax
		push	ax
		push	ax
		push	ax
		mov	ax, 1900h
		push	ax
		sub	ax, ax
		push	ax
		call	sub_258D1
		add	sp, 10h
		mov	ax, 1
		push	ax
		sub	ax, ax
		push	ax
		push	ax
		mov	bx, PlayerCharID
		shl	bx, 1
		shl	bx, 1
		push	word_2D2F0[bx]
		call	LoadGEM
		add	sp, 8
		push	cs
		call	near ptr sub_10094
		call	sub_157BA
		call	sub_26089
		call	sub_157DE
		sub	ax, ax
		push	ax
		push	ax
		call	SetTextPosition
		add	sp, 4
		mov	ax, 0Fh
		push	ax
		call	SetTextColor
		add	sp, 2
		mov	ax, 18h
		push	ax
		mov	ax, 4Ch	; 'L'
		push	ax
		mov	ax, 16h
		push	ax
		mov	ax, 4
		push	ax
		call	SomethingTextBox
		add	sp, 8
		mov	ax, offset aBubcvVvvVVBagi ; "�u�c�܂������ȁA�I���ɏ��Ă�͉̂F���l�"...
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_12948
		call	ClearTextBox
		call	sub_15860
		call	sub_260A7
		call	sub_26403
		call	sub_26089
		call	sub_157DE
		mov	ax, offset aBRffnmubN_0	; "�|���N��|n"
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_12948
		call	sub_15860
		call	sub_260A7
		mov	ax, 1
		push	ax
		sub	ax, ax
		push	ax
		push	ax
		mov	bx, PlayerCharID
		shl	bx, 1
		shl	bx, 1
		push	(word_2D2F0+2)[bx]
		call	LoadGEM
		add	sp, 8
		push	cs
		call	near ptr sub_10094
		call	sub_157BA
		call	sub_26089
		cmp	word_2A9E2, 5
		jz	short loc_13854
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, 3
		push	ax
		call	sub_29701
		add	sp, 6
		sub	ax, ax
		push	ax
		mov	bx, word_2D3B0
		shl	bx, 1
		shl	bx, 1
		push	word_2CE1C[bx]
		mov	ax, 1
		push	ax
		call	sub_29701
		add	sp, 6

loc_13854:				; CODE XREF: DoEnd1_Jun+143j
		call	sub_157DE
		sub	ax, ax
		push	ax
		push	ax
		call	SetTextPosition
		add	sp, 4
		mov	ax, offset aBcvinspivGxgyb ; "�c�i�����̃X�y�[�X�V���g���w�t���x�A�ł"...
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_12948
		mov	ax, offset aVpvxbcbcfnbcbc ; "�P�X�����N�������������A�V��㍑�ۋ�`�"...
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_12948
		call	ClearTextBox
		mov	ax, offset aBubcpbvRjvvvcb ; "�u�c���͐�����B�j�V�l�œ������Ȃ��@�ނ"...
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_12948
		mov	ax, 1
		push	ax
		sub	ax, ax
		push	ax
		call	SetTextPosition
		add	sp, 4
		mov	ax, offset aUppcvNUUOuvFnr ; "���悵�ē˓����ɔ����������̂ɍۂ��A�g�"...
		push	ax
		call	LoadText_DS
		add	sp, 2
		mov	ax, offset aBwlvxUcb@pbbxv ; "�w�v�ۓc�@���x�ɂ́A���̌��тɑ΂������"...
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_12948
		call	ClearTextBox
		mov	ax, offset aBubcgtgtgbbbif ; "�u�c�t�t�b�B�F���͑傫��������B���̃I�"...
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_12948
		call	sub_15860
		call	sub_260A7
		push	cs
		call	near ptr sub_1004E
		push	word_2D3B0
		call	sub_154E4
		add	sp, 2
		retf
DoEnd1_Jun	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


DoEnd2_Manami	proc far		; CODE XREF: sub_14DDC+1E1p
		mov	ax, offset aDVg17 ; "d:vg17"
		push	ax
		call	LoadMusic	; VG17:	Manami Ending
		add	sp, 2
		mov	word_2D3B0, ax
		call	sub_260A7
		call	sub_2604D
		call	sub_260C5
		mov	ax, 1
		push	ax
		call	sub_262E6
		add	sp, 2
		call	sub_26403
		sub	ax, ax
		push	ax
		call	sub_262E6
		add	sp, 2
		call	sub_26403
		sub	ax, ax
		push	ax
		call	sub_262D1
		add	sp, 2
		mov	ax, 28h	; '('
		push	ax
		call	sub_2591C
		add	sp, 2
		sub	ax, ax
		push	ax
		push	ax
		push	ax
		push	ax
		push	ax
		push	ax
		mov	ax, 1900h
		push	ax
		sub	ax, ax
		push	ax
		call	sub_258D1
		add	sp, 10h
		mov	ax, 1
		push	ax
		sub	ax, ax
		push	ax
		push	ax
		mov	bx, PlayerCharID
		shl	bx, 1
		shl	bx, 1
		push	word_2D2F0[bx]
		call	LoadGEM
		add	sp, 8
		push	cs
		call	near ptr sub_10094
		call	sub_157BA
		call	sub_26089
		call	sub_157DE
		sub	ax, ax
		push	ax
		push	ax
		call	SetTextPosition
		add	sp, 4
		mov	ax, 0Fh
		push	ax
		call	SetTextColor
		add	sp, 2
		mov	ax, 18h
		push	ax
		mov	ax, 4Ch	; 'L'
		push	ax
		mov	ax, 16h
		push	ax
		mov	ax, 4
		push	ax
		call	SomethingTextBox
		add	sp, 8
		mov	ax, offset aBuvavavvbivVVV ; "�u�킠���I�܂Ȃ݂����A�����˂����₟�"...
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_12948
		call	ClearTextBox
		call	sub_15860
		call	sub_260A7
		call	sub_26403
		call	sub_26089
		call	sub_157DE
		mov	ax, offset aBRffnmubN_2	; "�|���N��|n"
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_12948
		call	sub_15860
		call	sub_260A7
		mov	ax, 1
		push	ax
		sub	ax, ax
		push	ax
		push	ax
		mov	bx, PlayerCharID
		shl	bx, 1
		shl	bx, 1
		push	(word_2D2F0+2)[bx]
		call	LoadGEM
		add	sp, 8
		push	cs
		call	near ptr sub_10094
		call	sub_157BA
		call	sub_26089
		cmp	word_2A9E2, 5
		jz	short loc_13A66
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, 3
		push	ax
		call	sub_29701
		add	sp, 6
		sub	ax, ax
		push	ax
		mov	bx, word_2D3B0
		shl	bx, 1
		shl	bx, 1
		push	word_2CE1C[bx]
		mov	ax, 1
		push	ax
		call	sub_29701
		add	sp, 6

loc_13A66:				; CODE XREF: DoEnd2_Manami+143j
		call	sub_157DE
		sub	ax, ax
		push	ax
		push	ax
		call	SetTextPosition
		add	sp, 4
		mov	ax, offset aBuuarcrVBivVVV ; "�u��搶���I�ǂ��ɂ�����Ă�̂��I�����"...
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_12948
		mov	ax, offset aBubcvVVVjbavcv ; "�u�c���񂹂��A���ł邯�ǁc������ł��"...
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_12948
		mov	ax, offset aBuvvvVVcvivVcv ; "�u�������炨���������c�܂Ȃ݂����"...
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_12948
		call	ClearTextBox
		mov	ax, offset aBuvVVVjbcvVsvV ; "�u���񂹂��c�����Ƃ���܂�Ȃ������"...
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_12948
		call	ClearTextBox
		mov	ax, offset aUab@rUFBbbcvVV ; "��@�^�ޔ��B�c�Ȃ�̈��ʂ��c�t���̐搶�"...
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_12948
		mov	ax, offset aLIcvVVvvsvVivV ; "���炵�Ă���̂�����Ă�̂��͔���Ȃ��"...
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_12948
		call	sub_15860
		call	sub_260A7
		push	cs
		call	near ptr sub_1004E
		push	word_2D3B0
		call	sub_154E4
		add	sp, 2
		retf
DoEnd2_Manami	endp


; =============== S U B	R O U T	I N E =======================================


DoEnd3_Chiho	proc far		; CODE XREF: sub_14DDC+1E7p
		mov	ax, offset aDVg16 ; "d:vg16"
		push	ax
		call	LoadMusic	; VG16:	Chiho Ending
		add	sp, 2
		mov	word_2D3B0, ax
		call	sub_260A7
		call	sub_2604D
		call	sub_260C5
		mov	ax, 1
		push	ax
		call	sub_262E6
		add	sp, 2
		call	sub_26403
		sub	ax, ax
		push	ax
		call	sub_262E6
		add	sp, 2
		call	sub_26403
		sub	ax, ax
		push	ax
		call	sub_262D1
		add	sp, 2
		mov	ax, 28h	; '('
		push	ax
		call	sub_2591C
		add	sp, 2
		sub	ax, ax
		push	ax
		push	ax
		push	ax
		push	ax
		push	ax
		push	ax
		mov	ax, 1900h
		push	ax
		sub	ax, ax
		push	ax
		call	sub_258D1
		add	sp, 10h
		mov	ax, 1
		push	ax
		sub	ax, ax
		push	ax
		push	ax
		mov	bx, PlayerCharID
		shl	bx, 1
		shl	bx, 1
		push	word_2D2F0[bx]
		call	LoadGEM
		add	sp, 8
		push	cs
		call	near ptr sub_10094
		call	sub_157BA
		call	sub_26089
		call	sub_157DE
		sub	ax, ax
		push	ax
		push	ax
		call	SetTextPosition
		add	sp, 4
		mov	ax, 0Fh
		push	ax
		call	SetTextColor
		add	sp, 2
		mov	ax, 18h
		push	ax
		mov	ax, 4Ch	; 'L'
		push	ax
		mov	ax, 16h
		push	ax
		mov	ax, 4
		push	ax
		call	SomethingTextBox
		add	sp, 8
		mov	ax, offset aBubcvVNsvVVrvd ; "�u�c���̍��ɂ͂��������͂Ȃ��B�킽����"...
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_12948
		call	ClearTextBox
		call	sub_15860
		call	sub_260A7
		call	sub_26403
		call	sub_26089
		call	sub_157DE
		mov	ax, offset aBRffnmubN_1	; "�|���N��|n"
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_12948
		call	sub_15860
		call	sub_260A7
		mov	ax, 1
		push	ax
		sub	ax, ax
		push	ax
		push	ax
		mov	bx, PlayerCharID
		shl	bx, 1
		shl	bx, 1
		push	(word_2D2F0+2)[bx]
		call	LoadGEM
		add	sp, 8
		push	cs
		call	near ptr sub_10094
		call	sub_157BA
		call	sub_26089
		cmp	word_2A9E2, 5
		jz	short loc_13C6C
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, 3
		push	ax
		call	sub_29701
		add	sp, 6
		sub	ax, ax
		push	ax
		mov	bx, word_2D3B0
		shl	bx, 1
		shl	bx, 1
		push	word_2CE1C[bx]
		mov	ax, 1
		push	ax
		call	sub_29701
		add	sp, 6

loc_13C6C:				; CODE XREF: DoEnd3_Chiho+143j
		call	sub_157DE
		sub	ax, ax
		push	ax
		push	ax
		call	SetTextPosition
		add	sp, 4
		mov	ax, offset aBuvivrvVivivVV ; "�u�������납�����ˁA�w�r�n�C���h�E�U�E�"...
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_12948
		mov	ax, offset aBuoxiivGGzbegG ; "�u�剉�̃`�z�E�}�X�_�c�J�b�R������Ȃ��"...
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_12948
		mov	ax, offset aBubctmvVVsvivv ; "�u�c�m���Ă邩���H�ޏ��A�i���ŋ��A�{���"...
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_12948
		call	ClearTextBox
		mov	ax, offset aBubcgGzbegGxg_ ; "�u�c�`�z�E�}�X�_�A���Q�I�c�Ȃ���āA�ˁ"...
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_12948
		call	ClearTextBox
		mov	ax, offset aSaucrcxfbbbctp ; "���c���B�c�P�g�`���ɓn��A�^���ɂĉf�"...
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_12948
		mov	ax, offset aVrbegrgxgmvIzv ; "�r�E�R�X�M���z����j���W���X�^�[�Ƃ��ā"...
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_12948
		call	sub_15860
		call	sub_260A7
		push	cs
		call	near ptr sub_1004E
		push	word_2D3B0
		call	sub_154E4
		add	sp, 2
		retf
DoEnd3_Chiho	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

DoEnd4_Kaori	proc far		; CODE XREF: sub_14DDC+1EDp

var_18		= word ptr -18h
var_16		= word ptr -16h
var_14		= byte ptr -14h

		push	bp
		mov	bp, sp
		sub	sp, 18h
		push	si
		call	sub_260A7
		call	sub_2604D
		call	sub_260C5
		mov	ax, offset aDVg19 ; "d:vg19"
		push	ax
		call	LoadMusic	; VG19:	Kaori Ending
		add	sp, 2
		mov	word_2D3B0, ax
		mov	bx, PlayerCharID
		shl	bx, 1
		shl	bx, 1
		push	(word_2D2F0+2)[bx]
		mov	ax, offset a_gem_0 ; ".gem"
		push	ax
		lea	ax, [bp+var_14]
		push	ax
		call	strcat
		add	sp, 6
		lea	ax, [bp+var_14]
		push	ax
		call	MaybeLoadFile
		add	sp, 2
		mov	[bp+var_16], ax
		push	ax
		call	sub_15496
		add	sp, 2
		mov	[bp+var_18], ax
		mov	bx, ax
		shl	bx, 1
		shl	bx, 1
		push	word_2CE1C[bx]
		lea	ax, [bp+var_14]
		push	ax
		call	sub_29694
		add	sp, 4
		sub	ax, ax
		push	ax
		push	ax
		call	SetTextPosition
		add	sp, 4
		mov	ax, 0Fh
		push	ax
		call	SetTextColor
		add	sp, 2
		mov	ax, 18h
		push	ax
		mov	ax, 4Ch	; 'L'
		push	ax
		mov	ax, 16h
		push	ax
		mov	ax, 4
		push	ax
		call	SomethingTextBox
		add	sp, 8
		mov	ax, 1
		push	ax
		call	sub_262E6
		add	sp, 2
		call	sub_26403
		sub	ax, ax
		push	ax
		call	sub_262E6
		add	sp, 2
		call	sub_26403
		sub	ax, ax
		push	ax
		call	sub_262D1
		add	sp, 2
		mov	ax, 28h	; '('
		push	ax
		call	sub_2591C
		add	sp, 2
		sub	ax, ax
		push	ax
		push	ax
		push	ax
		push	ax
		push	ax
		push	ax
		mov	ax, 1900h
		push	ax
		sub	ax, ax
		push	ax
		call	sub_258D1
		add	sp, 10h
		mov	ax, 1
		push	ax
		sub	ax, ax
		push	ax
		push	ax
		mov	bx, PlayerCharID
		shl	bx, 1
		shl	bx, 1
		push	word_2D2F0[bx]
		call	LoadGEM
		add	sp, 8
		push	cs
		call	near ptr sub_10094
		call	sub_157BA
		call	sub_26089
		call	sub_157DE
		mov	ax, offset aBuvVdvtvcpicVV ; "�u�ǂ����I���ł��ˁB�c�����c�C�������"...
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_12948
		call	ClearTextBox
		call	sub_15860
		call	sub_260A7
		call	sub_26403
		call	sub_26089
		call	sub_157DE
		mov	ax, offset aBRffnmubN_3	; "�|���N��|n"
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_12948
		call	sub_15860
		call	ClearTextBox
		cmp	word_2A9E2, 5
		jz	short loc_13E9C
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, 3
		push	ax
		call	sub_29701
		add	sp, 6
		sub	ax, ax
		push	ax
		mov	bx, word_2D3B0
		shl	bx, 1
		shl	bx, 1
		push	word_2CE1C[bx]
		mov	ax, 1
		push	ax
		call	sub_29701
		add	sp, 6

loc_13E9C:				; CODE XREF: DoEnd4_Kaori+16Dj
		sub	ax, ax
		push	ax
		push	ax
		call	SetTextPosition
		add	sp, 4
		call	sub_157DE
		mov	ax, offset aBubcfnxVVVBbvp ; "�u�c���\\���܂��B�P�X�����N�x�A�~�X�E���"...
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_12948
		mov	ax, offset aBubcgggugggkbG ; "�u�c�G���g���[�i���o�[�S�P�B�c�_�ސ쌧�"...
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_12948
		call	sub_15860
		call	ClearTextBox
		call	sub_260A7
		mov	si, [bp+var_18]
		mov	cl, 2
		shl	si, cl
		add	si, offset word_2CE1C
		mov	ax, offset byte_2D31C
		push	ax
		sub	ax, ax
		push	ax
		push	word ptr [si]
		call	sub_255B5
		add	sp, 6
		mov	ax, 1
		push	ax
		push	word ptr [si]
		sub	ax, ax
		push	ax
		push	ax
		call	sub_25666
		add	sp, 8
		push	cs
		call	near ptr sub_10094
		call	sub_157BA
		call	sub_26089
		call	sub_157DE
		sub	ax, ax
		push	ax
		push	ax
		call	SetTextPosition
		add	sp, 4
		mov	ax, offset aCRgb@vivivsbbo ; "�����@������B�㊥�Q�Q�˂ō����s��w���"...
		push	ax
		call	LoadText_DS
		add	sp, 2
		mov	ax, offset aGGxbegjgjgobGx ; "�~�X�E���j�o�[�X���{��\\�ɑI�o�����Bn"...
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_12948
		call	ClearTextBox
		mov	ax, offset aBunbvVilcoavVB ; "�u���̂��C�����́H�vn"
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_12948
		mov	ax, offset aBubcvcvnvavivc ; "�u�c�悭�킩��Ȃ���ł����ǁc������Ė"...
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_12948
		mov	ax, offset aBubcvBhbvn ; "�u�c�́H�vn"
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_12948
		call	sub_15860
		call	sub_260A7
		push	cs
		call	near ptr sub_1004E
		push	[bp+var_18]
		call	sub_154E4
		add	sp, 2
		push	word_2D3B0
		call	sub_154E4
		add	sp, 2
		pop	si
		mov	sp, bp
		pop	bp
		retf
DoEnd4_Kaori	endp


; =============== S U B	R O U T	I N E =======================================


DoEnd5_Reimi	proc far		; CODE XREF: sub_14DDC+1F3p
		mov	ax, offset aDVg20 ; "d:vg20"
		push	ax
		call	LoadMusic	; VG20:	Reimi Ending
		add	sp, 2
		mov	word_2D3B0, ax
		call	sub_260A7
		call	sub_2604D
		call	sub_260C5
		mov	ax, 1
		push	ax
		call	sub_262E6
		add	sp, 2
		call	sub_26403
		sub	ax, ax
		push	ax
		call	sub_262E6
		add	sp, 2
		call	sub_26403
		sub	ax, ax
		push	ax
		call	sub_262D1
		add	sp, 2
		mov	ax, 28h	; '('
		push	ax
		call	sub_2591C
		add	sp, 2
		sub	ax, ax
		push	ax
		push	ax
		push	ax
		push	ax
		push	ax
		push	ax
		mov	ax, 1900h
		push	ax
		sub	ax, ax
		push	ax
		call	sub_258D1
		add	sp, 10h
		mov	ax, 1
		push	ax
		sub	ax, ax
		push	ax
		push	ax
		mov	bx, PlayerCharID
		shl	bx, 1
		shl	bx, 1
		push	word_2D2F0[bx]
		call	LoadGEM
		add	sp, 8
		push	cs
		call	near ptr sub_10094
		call	sub_157BA
		call	sub_26089
		call	sub_157DE
		sub	ax, ax
		push	ax
		push	ax
		call	SetTextPosition
		add	sp, 4
		mov	ax, 0Fh
		push	ax
		call	SetTextColor
		add	sp, 2
		mov	ax, 18h
		push	ax
		mov	ax, 4Ch	; 'L'
		push	ax
		mov	ax, 16h
		push	ax
		mov	ax, 4
		push	ax
		call	SomethingTextBox
		add	sp, 8
		mov	ax, offset aBugtgbbcvavIIP ; "�u�t�b�c���Ɖ��񏟂ĂΓ��킸�ɍςނ悤�"...
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_12948
		call	ClearTextBox
		call	sub_15860
		call	sub_260A7
		call	sub_26403
		call	sub_26089
		call	sub_157DE
		mov	ax, offset aBRfgjmomubN	; "�|���J����|n"
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_12948
		call	sub_15860
		call	sub_260A7
		mov	ax, 1
		push	ax
		sub	ax, ax
		push	ax
		push	ax
		mov	bx, PlayerCharID
		shl	bx, 1
		shl	bx, 1
		push	(word_2D2F0+2)[bx]
		call	LoadGEM
		add	sp, 8
		push	cs
		call	near ptr sub_10094
		call	sub_157BA
		call	sub_26089
		cmp	word_2A9E2, 5
		jz	short loc_14114
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, 3
		push	ax
		call	sub_29701
		add	sp, 6
		sub	ax, ax
		push	ax
		mov	bx, word_2D3B0
		shl	bx, 1
		shl	bx, 1
		push	word_2CE1C[bx]
		mov	ax, 1
		push	ax
		call	sub_29701
		add	sp, 6

loc_14114:				; CODE XREF: DoEnd5_Reimi+143j
		mov	ax, 0Ch
		push	ax
		push	cs
		call	near ptr sub_10000
		add	sp, 2
		call	sub_157DE
		sub	ax, ax
		push	ax
		push	ax
		call	SetTextPosition
		add	sp, 4
		mov	ax, offset aBubcvavGmgcgVk ; "�u�c���̃��C�~���A�˂��c�vn"
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_12948
		mov	ax, offset aBufVcvVvvrvVVV ; "�u����Ȃ����̂ł��ˁA���̃��C�~����ڍ"...
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_12948
		mov	ax, offset aBuvVivrskosvBw ; "�u����������́w����x����c�H�vn"
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_12948
		call	ClearTextBox
		mov	ax, offset aBuvVdvVdbbvVVV ; "�u���������B���ӂƂ͂����̂Ղ炮��܁[�"...
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_12948
		call	ClearTextBox
		mov	ax, offset aBubcvavGmgcg_0 ; "�u�c���̃��C�~�������˂��c�vn"
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_12948
		call	ClearTextBox
		mov	ax, offset aBcgmgcgBeoIBbv ; "�c���C�~�E�Ӊ؁B�u�f�I���Q�J����A�d���"...
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_12948
		call	ClearTextBox
		mov	ax, offset aBugtgtgtbcgvbe ; "�u�t�t�t�c�V�E�A�E���E�Z�B�����āA�����"...
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_12948
		call	sub_15860
		call	sub_260A7
		push	cs
		call	near ptr sub_1004E
		push	word_2D3B0
		call	sub_154E4
		add	sp, 2
		retf
DoEnd5_Reimi	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_141D0	proc far		; CODE XREF: sub_1455A+7Dp
					; sub_145EA+7Bp ...

var_C		= word ptr -0Ch
var_A		= word ptr -0Ah
var_8		= word ptr -8
var_6		= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2

		push	bp
		mov	bp, sp
		sub	sp, 0Ch
		push	si
		mov	[bp+var_A], 0
		mov	[bp+var_2], 1
		sub	ax, ax
		mov	word_2D018, ax
		mov	word_2D016, ax
		mov	word_2A9E6, 1
		mov	al, byte ptr word_2CB42
		and	al, 1
		cmp	al, 1
		jz	short loc_141FB
		jmp	loc_14503
; ---------------------------------------------------------------------------

loc_141FB:				; CODE XREF: sub_141D0+26j
		cmp	word_2A9EE, 0
		jz	short loc_14205
		jmp	loc_14503
; ---------------------------------------------------------------------------

loc_14205:				; CODE XREF: sub_141D0+30j
		call	sub_2973A
		mov	ax, 2
		push	ax
		call	sub_29781
		add	sp, 2
		jmp	loc_14503
; ---------------------------------------------------------------------------
		align 2

loc_1421A:				; CODE XREF: sub_141D0+33Aj
		cmp	word_2D018, 2
		jnz	short loc_14224
		jmp	loc_1450D
; ---------------------------------------------------------------------------

loc_14224:				; CODE XREF: sub_141D0+4Fj
		cmp	[bp+var_2], 1
		jz	short loc_1422D
		jmp	loc_1450D
; ---------------------------------------------------------------------------

loc_1422D:				; CODE XREF: sub_141D0+58j
		push	cs
		call	near ptr sub_11230
		call	sub_26089
		push	cs
		call	near ptr sub_1288E
		mov	word_2A9E4, 0
		mov	[bp+var_4], 28h	; '('
		sub	ax, ax
		push	ax
		call	sub_2398E
		add	sp, 2
		mov	ax, 1
		push	ax
		call	sub_2398E
		add	sp, 2
		call	sub_157BA
		push	cs
		call	near ptr sub_12802
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, 24h	; '$'
		push	ax
		mov	ax, 2
		push	ax
		mov	ax, 1
		push	ax
		mov	ax, 50h	; 'P'
		push	ax
		mov	ax, 28h	; '('
		push	ax
		call	sub_16BFC
		add	sp, 0Eh
		push	cs
		call	near ptr sub_126E4
		push	cs
		call	near ptr sub_127D6
		call	sub_157DE
		mov	ax, 32h	; '2'
		push	ax
		push	cs
		call	near ptr sub_10000
		add	sp, 2
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, 24h	; '$'
		push	ax
		mov	ax, 2
		push	ax
		mov	ax, 1
		push	ax
		mov	ax, 50h	; 'P'
		push	ax
		mov	ax, 28h	; '('
		push	ax
		call	sub_16BFC
		add	sp, 0Eh
		mov	ax, word_2A9E6
		cwd
		mov	cx, 0Ah
		idiv	cx
		mov	si, ax
		or	si, si
		jz	short loc_142EC
		sub	ax, ax
		push	ax
		push	ax
		lea	ax, [si+7]
		push	ax
		mov	ax, 2
		push	ax
		mov	ax, 1
		push	ax
		mov	ax, 50h	; 'P'
		push	ax
		mov	ax, 2Ah	; '*'
		push	ax
		call	sub_16BFC
		add	sp, 0Eh

loc_142EC:				; CODE XREF: sub_141D0+FAj
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, word_2A9E6
		cwd
		mov	cx, 0Ah
		idiv	cx
		add	dx, 7
		push	dx
		mov	ax, 2
		push	ax
		mov	ax, 1
		push	ax
		mov	ax, 50h	; 'P'
		push	ax
		mov	ax, 2Bh	; '+'
		push	ax
		call	sub_16BFC
		add	sp, 0Eh
		push	cs
		call	near ptr sub_126E4
		push	cs
		call	near ptr sub_127D6
		mov	ax, 1Eh
		push	ax
		push	cs
		call	near ptr sub_10000
		add	sp, 2
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, 25h	; '%'
		push	ax
		mov	ax, 2
		push	ax
		mov	ax, 1
		push	ax
		mov	ax, 50h	; 'P'
		push	ax
		mov	ax, 28h	; '('
		push	ax
		call	sub_16BFC
		add	sp, 0Eh
		push	cs
		call	near ptr sub_126E4
		push	cs
		call	near ptr sub_127D6
		sub	ax, ax
		push	ax
		mov	ax, 2
		push	ax
		call	sub_15C20
		add	sp, 4
		mov	ax, 1Eh
		push	ax
		push	cs
		call	near ptr sub_10000
		add	sp, 2
		mov	ax, word_2D016
		mov	[bp+var_C], ax
		mov	ax, word_2D3FC
		mov	[bp+var_6], ax
		mov	ax, word_2D3FE
		mov	[bp+var_8], ax
		jmp	loc_144BF
; ---------------------------------------------------------------------------
		align 2

loc_14380:				; CODE XREF: sub_141D0+2F5j
		cmp	[bp+var_2], 1
		jz	short loc_14389
		jmp	loc_144C8
; ---------------------------------------------------------------------------

loc_14389:				; CODE XREF: sub_141D0+1B4j
		push	cs
		call	near ptr sub_128D6
		cmp	[bp+var_4], 28h	; '('
		jge	short loc_143A1
		sub	ax, ax
		mov	word_2CE1A, ax
		mov	word_2CEE6, ax
		mov	word_2CE18, ax
		mov	word_2CEE4, ax

loc_143A1:				; CODE XREF: sub_141D0+1C1j
		push	cs
		call	near ptr sub_12822
		cmp	word_2A9E4, 0
		jnz	short loc_143B0
		push	cs
		call	near ptr sub_12802

loc_143B0:				; CODE XREF: sub_141D0+1DAj
		cmp	word_2CBDE, 0
		jz	short loc_143C0
		mov	al, byte ptr word_2D400
		and	al, 1
		cmp	al, 1
		jnz	short loc_143C4

loc_143C0:				; CODE XREF: sub_141D0+1E5j
		push	cs
		call	near ptr sub_126E4

loc_143C4:				; CODE XREF: sub_141D0+1EEj
		push	cs
		call	near ptr sub_1288E
		push	cs
		call	near ptr sub_127A2
		push	cs
		call	near ptr sub_128B0
		cmp	word_2CBDE, 0
		jz	short loc_143E0
		mov	al, byte ptr word_2D400
		and	al, 1
		cmp	al, 1
		jnz	short loc_143E4

loc_143E0:				; CODE XREF: sub_141D0+205j
		push	cs
		call	near ptr sub_127D6

loc_143E4:				; CODE XREF: sub_141D0+20Ej
		push	cs
		call	near ptr sub_12904
		cmp	word_2CB50, 32h	; '2'
		jge	short loc_143FC
		cmp	[bp+var_8], 1
		jle	short loc_143FC
		mov	ax, [bp+var_8]
		dec	ax
		mov	word_2D3FE, ax

loc_143FC:				; CODE XREF: sub_141D0+21Dj
					; sub_141D0+223j
		cmp	word_2CB9B, 32h	; '2'
		jge	short loc_14410
		cmp	[bp+var_6], 1
		jle	short loc_14410
		mov	ax, [bp+var_6]
		dec	ax
		mov	word_2D3FC, ax

loc_14410:				; CODE XREF: sub_141D0+231j
					; sub_141D0+237j
		call	sub_29798
		or	ax, ax
		jnz	short loc_1443F
		cmp	word_2A9F2, 1
		jnz	short loc_1443F
		mov	al, byte ptr word_2CB42
		and	al, 1
		cmp	al, 1
		jnz	short loc_1443F
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, 1Ah
		push	ax
		call	sub_29701
		add	sp, 6
		mov	word_2A9F2, 0

loc_1443F:				; CODE XREF: sub_141D0+247j
					; sub_141D0+24Ej ...
		call	sub_25C60
		and	ax, 8000h
		cmp	ax, 8000h
		jnz	short loc_1449A
		cmp	word_2CBA1, 1
		jnz	short loc_1449A
		cmp	word_2A9E2, 5
		jz	short loc_14495
		mov	al, byte ptr word_2CB42
		and	al, 1
		cmp	al, 1
		jnz	short loc_14495
		cmp	word_2A9F2, 0
		jnz	short loc_14495
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, 3
		push	ax
		call	sub_29701
		add	sp, 6
		sub	ax, ax
		push	ax
		mov	bx, word_2D3BE
		shl	bx, 1
		shl	bx, 1
		push	word_2CE1C[bx]
		mov	ax, 1
		push	ax
		call	sub_29701
		add	sp, 6

loc_14495:				; CODE XREF: sub_141D0+288j
					; sub_141D0+291j ...
		mov	[bp+var_2], 0

loc_1449A:				; CODE XREF: sub_141D0+27Aj
					; sub_141D0+281j
		inc	word_2D400
		dec	[bp+var_4]
		cmp	word_2CEE8, 0
		jz	short loc_144BF
		cmp	word_2A9E4, 0
		jnz	short loc_144BF
		mov	ax, word_2CB50
		add	ax, word_2CB9B
		or	ax, ax
		jle	short loc_144BF
		mov	[bp+var_4], 28h	; '('

loc_144BF:				; CODE XREF: sub_141D0+1ACj
					; sub_141D0+2D6j ...
		cmp	[bp+var_4], 0
		jle	short loc_144C8
		jmp	loc_14380
; ---------------------------------------------------------------------------

loc_144C8:				; CODE XREF: sub_141D0+1B6j
					; sub_141D0+2F3j
		call	sub_15860
		call	sub_260A7
		cmp	word_2A9EC, 0
		jnz	short loc_144F3
		cmp	word_2CBA1, 1
		jnz	short loc_144F3
		cmp	word_2CE14, 0
		jnz	short loc_144F3
		mov	ax, word_2D016
		cmp	[bp+var_C], ax
		jz	short loc_144F3
		push	cs
		call	near ptr sub_133B4

loc_144F3:				; CODE XREF: sub_141D0+307j
					; sub_141D0+30Ej ...
		inc	word_2A9E6
		mov	ax, [bp+var_6]
		mov	word_2D3FC, ax
		mov	ax, [bp+var_8]
		mov	word_2D3FE, ax

loc_14503:				; CODE XREF: sub_141D0+28j
					; sub_141D0+32j ...
		cmp	word_2D016, 2
		jz	short loc_1450D
		jmp	loc_1421A
; ---------------------------------------------------------------------------

loc_1450D:				; CODE XREF: sub_141D0+51j
					; sub_141D0+5Aj ...
		push	cs
		call	near ptr sub_100F6
		mov	al, byte ptr word_2CB42
		and	al, 1
		cmp	al, 1
		jnz	short loc_1452A
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, 1Ah
		push	ax
		call	sub_29701
		add	sp, 6

loc_1452A:				; CODE XREF: sub_141D0+348j
		mov	word_2A9F2, 0
		push	cs
		call	near ptr sub_1004E
		mov	ax, word_2D018
		cmp	word_2D016, ax
		jge	short loc_14542
		mov	ax, 1
		jmp	short loc_14544
; ---------------------------------------------------------------------------

loc_14542:				; CODE XREF: sub_141D0+36Bj
		sub	ax, ax

loc_14544:				; CODE XREF: sub_141D0+370j
		mov	[bp+var_A], ax
		cmp	[bp+var_2], 0
		jnz	short loc_14552
		mov	[bp+var_A], 2

loc_14552:				; CODE XREF: sub_141D0+37Bj
		mov	ax, [bp+var_A]
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_141D0	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1455A	proc far		; CODE XREF: sub_1507C+1ABp
		push	bp
		mov	bp, sp
		sub	sp, 2
		mov	word_2CE14, 1
		mov	PlayerCharID, 0
		mov	word_2CB40, 0
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, 1
		push	ax
		push	ax
		push	cs
		call	near ptr sub_10828
		add	sp, 8
		mov	word_2CB56, 0
		mov	word_2CBA1, 0
		mov	dx, word_2D380
		sub	ax, ax
		or	al, 16h
		mov	es, dx
		mov	bx, ax
		cmp	byte ptr es:[bx], 1
		jnz	short loc_145A6
		mov	word_2A9F4, 8

loc_145A6:				; CODE XREF: sub_1455A+44j
		mov	dx, es
		sub	ax, ax
		or	al, 20h
		mov	bx, ax
		cmp	byte ptr es:[bx], 1
		jnz	short loc_145BA
		mov	word_2CBA1, 0

loc_145BA:				; CODE XREF: sub_1455A+58j
		mov	dx, es
		sub	ax, ax
		or	al, 0Ch
		mov	bx, ax
		cmp	byte ptr es:[bx], 1
		jnz	short loc_145CE
		mov	word_2CBA1, 1

loc_145CE:				; CODE XREF: sub_1455A+6Cj
		push	cs
		call	near ptr sub_11E98
		push	cs
		call	near ptr sub_124FA
		push	cs
		call	near ptr sub_141D0
		call	sub_1548C
		sub	ax, ax
		push	ax
		push	cs
		call	near ptr DoPlayerWinScr
		mov	sp, bp
		pop	bp
		retf
sub_1455A	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_145EA	proc far		; CODE XREF: sub_14DDC+18Dp
					; sub_14DDC+238p

var_4		= word ptr -4
var_2		= word ptr -2

		push	bp
		mov	bp, sp
		sub	sp, 6
		push	di
		push	si
		mov	[bp+var_2], 1
		mov	word_2CF92, 0
		mov	bx, word_2A9EA
		shl	bx, 1
		mov	ax, word_2D382[bx]
		mov	word_2A9E8, ax
		mov	dx, word_2D380
		sub	ax, ax
		or	al, 16h
		mov	es, dx
		mov	bx, ax
		cmp	byte ptr es:[bx], 1
		jnz	short loc_14622
		mov	word_2D3FE, 100

loc_14622:				; CODE XREF: sub_145EA+30j
		mov	dx, es
		sub	ax, ax
		or	al, 20h
		mov	bx, ax
		cmp	byte ptr es:[bx], 1
		jnz	short loc_14636
		mov	word_2A9F4, 8

loc_14636:				; CODE XREF: sub_145EA+44j
		mov	di, [bp+var_4]
		mov	si, [bp+var_2]
		jmp	short loc_14687
; ---------------------------------------------------------------------------

loc_1463E:				; CODE XREF: sub_145EA+9Fj
		mov	word_2CE14, 1
		sub	ax, ax
		push	ax
		mov	ax, 1
		push	ax
		push	ax
		push	ax
		push	cs
		call	near ptr sub_10828
		add	sp, 8
		mov	word_2CB56, 0
		mov	word_2CBA1, 0
		push	cs
		call	near ptr sub_124FA
		push	cs
		call	near ptr sub_141D0
		mov	di, ax
		call	sub_1548C
		mov	ax, 1
		push	ax
		push	cs
		call	near ptr DoPlayerWinScr
		add	sp, 2
		mov	si, ax
		cmp	di, 1
		jnz	short loc_14687
		mov	ax, word_2CB40
		mov	PlayerCharID, ax

loc_14687:				; CODE XREF: sub_145EA+52j
					; sub_145EA+95j
		or	si, si
		jnz	short loc_1463E
		mov	[bp+var_4], di
		mov	[bp+var_2], si
		mov	bx, word_2A9EA
		shl	bx, 1
		mov	ax, word_2D382[bx]
		mov	word_2A9E8, ax
		mov	word_2CB40, ax
		mov	word_2D3FC, 3
		mov	word_2CB56, 0
		mov	word_2CBA1, 1
		mov	word_2CE14, 0
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_145EA	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

DoOpening	proc far		; CODE XREF: sub_14DDC+1CFp

var_46		= word ptr -46h
var_44		= word ptr -44h
var_42		= word ptr -42h
var_40		= byte ptr -40h

		push	bp
		mov	bp, sp
		sub	sp, 46h
		push	di
		push	si
		call	sub_25E03
		call	sub_1547E
		cmp	word_2A9E2, 5
		jnz	short loc_146DC
		jmp	loc_147F0
; ---------------------------------------------------------------------------

loc_146DC:				; CODE XREF: DoOpening+17j
		mov	ax, word_2A9E2
		or	ax, ax
		jz	short loc_14706
		cmp	ax, 1
		jnz	short loc_146EB
		jmp	loc_1477A
; ---------------------------------------------------------------------------

loc_146EB:				; CODE XREF: DoOpening+26j
		cmp	ax, 2
		jnz	short loc_146F3
		jmp	loc_14784
; ---------------------------------------------------------------------------

loc_146F3:				; CODE XREF: DoOpening+2Ej
		cmp	ax, 3
		jnz	short loc_146FB
		jmp	loc_1478E
; ---------------------------------------------------------------------------

loc_146FB:				; CODE XREF: DoOpening+36j
		cmp	ax, 4
		jnz	short loc_14703
		jmp	loc_14798
; ---------------------------------------------------------------------------

loc_14703:				; CODE XREF: DoOpening+3Ej
		jmp	short loc_1471A
; ---------------------------------------------------------------------------
		align 2

loc_14706:				; CODE XREF: DoOpening+21j
		mov	ax, offset aDVg01 ; "d:vg01"
		push	ax
		mov	ax, offset a_hgs_0 ; ".hgs"

loc_1470D:				; CODE XREF: DoOpening+C1j
					; DoOpening+CBj ...
		push	ax
		lea	ax, [bp+var_40]
		push	ax
		call	strcat
		add	sp, 6

loc_1471A:				; CODE XREF: DoOpening:loc_14703j
		lea	ax, [bp+var_40]
		push	ax
		call	MaybeLoadFile
		add	sp, 2
		mov	[bp+var_44], ax
		push	ax
		call	sub_25FA0
		add	sp, 2
		mov	[bp+var_46], ax
		push	ax
		lea	ax, [bp+var_40]
		push	ax
		call	sub_29694
		add	sp, 4
		call	sub_26363
		mov	ax, 0A800h
		push	ax
		push	[bp+var_46]
		call	sub_2A177
		add	sp, 4
		mov	[bp+var_44], ax
		push	[bp+var_46]
		call	sub_25FD0
		add	sp, 2
		push	[bp+var_44]
		call	sub_25FA0
		add	sp, 2
		mov	[bp+var_46], ax
		sub	si, si
		mov	di, [bp+var_44]
		jmp	short loc_147C4
; ---------------------------------------------------------------------------
		align 2

loc_1477A:				; CODE XREF: DoOpening+28j
		mov	ax, offset aDVg01_0 ; "d:vg01"
		push	ax
		mov	ax, offset a_hcm_0 ; ".hcm"
		jmp	short loc_1470D
; ---------------------------------------------------------------------------
		align 2

loc_14784:				; CODE XREF: DoOpening+30j
		mov	ax, offset aDVg01_1 ; "d:vg01"
		push	ax
		mov	ax, offset a_hmt_0 ; ".hmt"
		jmp	loc_1470D
; ---------------------------------------------------------------------------

loc_1478E:				; CODE XREF: DoOpening+38j
		mov	ax, offset aDVg01_2 ; "d:vg01"
		push	ax
		mov	ax, offset a_hfm_2 ; ".hfm"
		jmp	loc_1470D
; ---------------------------------------------------------------------------

loc_14798:				; CODE XREF: DoOpening+40j
		mov	ax, offset aDVg01_3 ; "d:vg01"
		push	ax
		mov	ax, offset a_hf2_0 ; ".hf2"
		jmp	loc_1470D
; ---------------------------------------------------------------------------

loc_147A2:				; CODE XREF: DoOpening+106j
		mov	ax, 10h
		push	ax
		lea	ax, [si+0A800h]
		mov	dx, ax
		sub	ax, ax
		push	dx
		push	ax
		mov	ax, [bp+var_46]
		add	ax, si
		mov	dx, ax
		sub	ax, ax
		push	dx
		push	ax
		call	sub_153EC
		add	sp, 0Ah
		inc	si

loc_147C4:				; CODE XREF: DoOpening+B7j
		cmp	si, di
		jb	short loc_147A2
		mov	[bp+var_42], si
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, 3
		push	ax
		call	sub_29701
		add	sp, 6
		sub	ax, ax
		push	ax
		push	[bp+var_46]
		mov	ax, 1
		push	ax
		call	sub_29701
		add	sp, 6
		jmp	short loc_147FF
; ---------------------------------------------------------------------------
		align 2

loc_147F0:				; CODE XREF: DoOpening+19j
		mov	ax, 1
		push	ax
		call	sub_25FA0
		add	sp, 2
		mov	[bp+var_46], ax

loc_147FF:				; CODE XREF: DoOpening+12Dj
		mov	dx, word_2D380
		sub	ax, ax
		or	al, 10h
		mov	es, dx
		mov	bx, ax
		mov	al, byte ptr word_2A9F4
		dec	al
		mov	es:[bx], al
		mov	ax, offset unk_2BCA7
		push	ax
		mov	ax, offset aDStroll_exe	; "d:stroll.exe"
		push	ax
		push	cs
		call	near ptr sub_10028
		add	sp, 4
		push	[bp+var_46]
		call	sub_25FD0
		add	sp, 2
		mov	ax, word_2CB42
		and	ax, 1
		push	ax
		call	sub_25D0E
		add	sp, 2
		call	sub_1542C
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
DoOpening	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

DoCharIntroScr	proc far		; CODE XREF: sub_14DDC+EDp

var_2		= word ptr -2
arg_0		= byte ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 4
		cmp	[bp+arg_0], 0
		jnz	short loc_14859
		mov	[bp+var_2], 0

loc_14859:				; CODE XREF: DoCharIntroScr+Aj
		cmp	[bp+arg_0], 1
		jnz	short loc_14864
		mov	[bp+var_2], 2

loc_14864:				; CODE XREF: DoCharIntroScr+15j
		cmp	[bp+arg_0], 2
		jnz	short loc_1486F
		mov	[bp+var_2], 3

loc_1486F:				; CODE XREF: DoCharIntroScr+20j
		cmp	[bp+arg_0], 3
		jnz	short loc_1487A
		mov	[bp+var_2], 1

loc_1487A:				; CODE XREF: DoCharIntroScr+2Bj
		cmp	[bp+arg_0], 4
		jnz	short loc_14885
		mov	[bp+var_2], 4

loc_14885:				; CODE XREF: DoCharIntroScr+36j
		cmp	[bp+arg_0], 5
		jnz	short loc_14890
		mov	[bp+var_2], 5

loc_14890:				; CODE XREF: DoCharIntroScr+41j
		mov	dx, word_2D380
		sub	ax, ax
		or	al, 10h
		mov	es, dx
		mov	bx, ax
		mov	al, byte ptr [bp+var_2]
		mov	es:[bx], al
		call	sub_26363
		call	sub_1547E
		call	sub_25E03
		mov	ax, offset unk_2BCB5
		push	ax
		mov	ax, offset aADandan_exe	; "a:dandan.exe"
		push	ax
		push	cs
		call	near ptr sub_10028
		add	sp, 4
		mov	ax, word_2CB42
		and	ax, 1
		push	ax
		call	sub_25D0E
		add	sp, 2
		call	sub_1542C
		sub	ax, ax
		push	ax
		mov	ax, 199
		push	ax
		mov	ax, 639
		push	ax
		sub	ax, ax
		push	ax
		mov	ax, 320
		push	ax
		call	j_ClearBox
		add	sp, 0Ah
		mov	ax, 10
		push	ax
		mov	ax, 76
		push	ax
		mov	ax, 1
		push	ax
		mov	ax, 44
		push	ax
		call	SetupTextBox
		add	sp, 8
		sub	ax, ax
		push	ax
		push	ax
		call	SetTextPosition
		add	sp, 4
		sub	ax, ax
		push	ax
		mov	ax, 6
		push	ax
		mov	ax, 28h	; '('
		push	ax
		mov	ax, 13h
		push	ax
		mov	ax, 14h
		push	ax
		call	sub_2630F
		add	sp, 0Ah
		mov	ax, 0Fh
		push	ax
		call	SetTextColor
		add	sp, 2
		sub	ax, ax
		push	ax
		call	sub_262E6
		add	sp, 2
		mov	al, byte ptr word_2CB42
		and	al, 1
		cmp	al, 1
		jnz	short loc_14960
		sub	ax, ax
		push	ax
		mov	ax, 80h	; '�'
		push	ax
		mov	ax, 1Ah
		push	ax
		call	sub_29701
		add	sp, 6

loc_14960:				; CODE XREF: DoCharIntroScr+103j
		mov	al, [bp+arg_0]
		sub	ah, ah
		or	ax, ax
		jz	short loc_14994
		cmp	ax, 1
		jnz	short loc_14971
		jmp	loc_14A5A
; ---------------------------------------------------------------------------

loc_14971:				; CODE XREF: DoCharIntroScr+124j
		cmp	ax, 2
		jnz	short loc_14979
		jmp	loc_14B08
; ---------------------------------------------------------------------------

loc_14979:				; CODE XREF: DoCharIntroScr+12Cj
		cmp	ax, 3
		jnz	short loc_14981
		jmp	loc_14B8C
; ---------------------------------------------------------------------------

loc_14981:				; CODE XREF: DoCharIntroScr+134j
		cmp	ax, 4
		jnz	short loc_14989
		jmp	loc_14C10
; ---------------------------------------------------------------------------

loc_14989:				; CODE XREF: DoCharIntroScr+13Cj
		cmp	ax, 5
		jnz	short loc_14991
		jmp	loc_14C94
; ---------------------------------------------------------------------------

loc_14991:				; CODE XREF: DoCharIntroScr+144j
		jmp	loc_14D98
; ---------------------------------------------------------------------------

loc_14994:				; CODE XREF: DoCharIntroScr+11Fj
		mov	ax, offset aATyuka ; "a:tyuka"
		push	ax
		call	LoadHNY
		add	sp, 2
		mov	word_2D3B6, ax
		mov	ax, 1
		push	ax
		call	sub_262E6
		add	sp, 2
		sub	ax, ax
		push	ax
		mov	ax, 2
		push	ax
		call	sub_15C20
		add	sp, 4
		mov	ax, offset aVuvfsiosba ; "�u�f�I��A"
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_100F6
		mov	ax, 2
		push	ax
		push	cs
		call	near ptr sub_10000
		add	sp, 2
		mov	ax, 1
		push	ax
		mov	ax, 2
		push	ax
		call	sub_15C20
		add	sp, 4
		mov	ax, offset aBwxrurb@cdnbbx ; "�w�����@�D���x�Bn"
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_100F6
		mov	ax, 0Ah
		push	ax
		push	cs
		call	near ptr sub_10000
		add	sp, 2
		mov	ax, 2
		push	ax
		push	ax
		call	sub_15C20
		add	sp, 4
		mov	ax, offset aGGnvTzra ; "�{�N�̒���"
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_100F6
		mov	ax, 2
		push	ax
		push	cs
		call	near ptr sub_10000
		add	sp, 2
		mov	ax, 3
		push	ax
		mov	ax, 2
		push	ax
		call	sub_15C20
		add	sp, 4
		mov	ax, offset aOVpvVrvcvdvc ; "�󂯂Ă��炤��"

loc_14A3F:				; CODE XREF: DoCharIntroScr+2BDj
					; DoCharIntroScr+340j ...
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_100F6
		mov	ax, 14h
		push	ax
		push	cs
		call	near ptr sub_10000
		add	sp, 2
		jmp	loc_14D98
; ---------------------------------------------------------------------------

loc_14A5A:				; CODE XREF: DoCharIntroScr+126j
		mov	ax, offset aATjun ; "a:tjun"
		push	ax
		call	LoadHNY
		add	sp, 2
		mov	word_2D3B6, ax
		mov	ax, 1
		push	ax
		call	sub_262E6
		add	sp, 2
		sub	ax, ax
		push	ax
		mov	ax, 2
		push	ax
		call	sub_15C20
		add	sp, 4
		mov	ax, offset aVuvfsios ; "�u�f�I��"
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_100F6
		mov	ax, 2
		push	ax
		push	cs
		call	near ptr sub_10000
		add	sp, 2
		mov	ax, 1
		push	ax
		mov	ax, 2
		push	ax
		call	sub_15C20
		add	sp, 4
		mov	ax, offset aBwlvxUcb@pbbxb ; "�w�v�ۓc�@���x�Bn"
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_100F6
		mov	ax, 2
		push	ax
		push	cs
		call	near ptr sub_10000
		add	sp, 2
		mov	ax, 2
		push	ax
		push	ax
		call	sub_15C20
		add	sp, 4
		mov	ax, offset aB@vavVBa ; "�@���񂽁A"
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_100F6
		mov	ax, 2
		push	ax
		push	cs
		call	near ptr sub_10000
		add	sp, 2
		mov	ax, 3
		push	ax
		mov	ax, 2
		push	ax
		call	sub_15C20
		add	sp, 4
		mov	ax, offset aLnvvvVVivdvBh ; "�����񂾂낤�ȁH"
		jmp	loc_14A3F
; ---------------------------------------------------------------------------

loc_14B08:				; CODE XREF: DoCharIntroScr+12Ej
		mov	ax, offset aATmanami ; "a:tmanami"
		push	ax
		call	LoadHNY
		add	sp, 2
		mov	word_2D3B6, ax
		mov	ax, 1
		push	ax
		call	sub_262E6
		add	sp, 2
		sub	ax, ax
		push	ax
		mov	ax, 2
		push	ax
		call	sub_15C20
		add	sp, 4
		mov	ax, offset aVuvfvVVVuvN	; "�u�f���񂵂��n"
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_100F6
		mov	ax, 2
		push	ax
		push	cs
		call	near ptr sub_10000
		add	sp, 2
		mov	ax, 1
		push	ax
		mov	ax, 2
		push	ax
		call	sub_15C20
		add	sp, 4
		mov	ax, offset aBwvnvVVlb@vVVV ; "�w�����̂��@�܂Ȃ݂����x�ł�n"
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_100F6
		mov	ax, 2
		push	ax
		push	cs
		call	near ptr sub_10000
		add	sp, 2
		mov	ax, 2
		push	ax
		push	ax
		call	sub_15C20
		add	sp, 4
		mov	ax, offset aBsvivVjvVsvBav ; "�����˂������A�����ځIn"
		jmp	loc_14A3F
; ---------------------------------------------------------------------------
		align 2

loc_14B8C:				; CODE XREF: DoCharIntroScr+136j
		mov	ax, offset aATchiho ; "a:tchiho"
		push	ax
		call	LoadHNY
		add	sp, 2
		mov	word_2D3B6, ax
		mov	ax, 1
		push	ax
		call	sub_262E6
		add	sp, 2
		sub	ax, ax
		push	ax
		mov	ax, 2
		push	ax
		call	sub_15C20
		add	sp, 4
		mov	ax, offset aBwsaucb@rcxfbx ; "�w���c�@���x�An"
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_100F6
		mov	ax, 2
		push	ax
		push	cs
		call	near ptr sub_10000
		add	sp, 2
		mov	ax, 1
		push	ax
		mov	ax, 2
		push	ax
		call	sub_15C20
		add	sp, 4
		mov	ax, offset aVuvfsiosbb ; "�u�f�I��B"
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_100F6
		mov	ax, 2
		push	ax
		push	cs
		call	near ptr sub_10000
		add	sp, 2
		mov	ax, 2
		push	ax
		push	ax
		call	sub_15C20
		add	sp, 4
		mov	ax, offset aVVabaonvVcvdvi ; "�����A�n�߂悤��n"
		jmp	loc_14A3F
; ---------------------------------------------------------------------------
		align 2

loc_14C10:				; CODE XREF: DoCharIntroScr+13Ej
		mov	ax, offset aATkaori ; "a:tkaori"
		push	ax
		call	LoadHNY
		add	sp, 2
		mov	word_2D3B6, ax
		mov	ax, 1
		push	ax
		call	sub_262E6
		add	sp, 2
		sub	ax, ax
		push	ax
		mov	ax, 2
		push	ax
		call	sub_15C20
		add	sp, 4
		mov	ax, offset aSofnuxvuvfpacd ; "�O�N�x�u�f���D���I��n"
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_100F6
		mov	ax, 2
		push	ax
		push	cs
		call	near ptr sub_10000
		add	sp, 2
		mov	ax, 1
		push	ax
		mov	ax, 2
		push	ax
		call	sub_15C20
		add	sp, 4
		mov	ax, offset aBwcRgb@vivivsb ; "�w�����@������x�Bn"
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_100F6
		mov	ax, 0Ch
		push	ax
		push	cs
		call	near ptr sub_10000
		add	sp, 2
		mov	ax, 2
		push	ax
		push	ax
		call	sub_15C20
		add	sp, 4
		mov	ax, offset aTzravVioVpvVVV ; "��������󂯂��܂���"
		jmp	loc_14A3F
; ---------------------------------------------------------------------------
		align 2

loc_14C94:				; CODE XREF: DoCharIntroScr+146j
		mov	ax, offset aATreimi ; "a:treimi"
		push	ax
		call	LoadHNY
		add	sp, 2
		mov	word_2D3B6, ax
		mov	ax, 1
		push	ax
		call	sub_262E6
		add	sp, 2
		sub	ax, ax
		push	ax
		mov	ax, 2
		push	ax
		call	sub_15C20
		add	sp, 4
		mov	ax, offset aBwoIGrgugcgfgl ; "�w�Ӊ؃R���c�F�����x��An"
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_100F6
		mov	ax, 2
		push	ax
		push	cs
		call	near ptr sub_10000
		add	sp, 2
		mov	ax, 1
		push	ax
		mov	ax, 2
		push	ax
		call	sub_15C20
		add	sp, 4
		mov	ax, offset aVVVCFsvuvfcdpq ; "�����Ė��s�u�f�D����n"
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_100F6
		mov	ax, 8
		push	ax
		push	cs
		call	near ptr sub_10000
		add	sp, 2
		mov	ax, 2
		push	ax
		push	ax
		call	sub_15C20
		add	sp, 4
		mov	ax, offset aBwgmgcgBeoIBxv ; "�w���C�~�E�Ӊ؁x��n"
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_100F6
		mov	ax, 0Ch
		push	ax
		push	cs
		call	near ptr sub_10000
		add	sp, 2
		mov	ax, 3
		push	ax
		mov	ax, 2
		push	ax
		call	sub_15C20
		add	sp, 4
		mov	ax, offset aXsiVTzraoVVavV ; "�s�^�Ȓ���҂͂��Ȃ�������Hn"
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_100F6
		mov	ax, 8
		push	ax
		push	cs
		call	near ptr sub_10000
		add	sp, 2
		mov	ax, 4
		push	ax
		mov	ax, 2
		push	ax
		call	sub_15C20
		add	sp, 4
		mov	ax, offset aBebebevBa ;	"�E�E�E���A"
		push	ax
		call	LoadText_DS
		add	sp, 2
		push	cs
		call	near ptr sub_100F6
		mov	ax, 2
		push	ax
		push	cs
		call	near ptr sub_10000
		add	sp, 2
		mov	ax, 5
		push	ax
		mov	ax, 2
		push	ax
		call	sub_15C20
		add	sp, 4
		mov	ax, offset aVivivVVcvVVsvv ; "�������Ă�����Ⴂ"
		jmp	loc_14A3F
; ---------------------------------------------------------------------------

loc_14D98:				; CODE XREF: DoCharIntroScr:loc_14991j
					; DoCharIntroScr+20Fj
		mov	ax, 32h	; '2'
		push	ax
		push	cs
		call	near ptr sub_10000
		add	sp, 2
		push	cs
		call	near ptr sub_100F6
		mov	al, byte ptr word_2CB42
		and	al, 1
		cmp	al, 1
		jnz	short loc_14DC0
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, 1Ah
		push	ax
		call	sub_29701
		add	sp, 6

loc_14DC0:				; CODE XREF: DoCharIntroScr+566j
		mov	word_2A9F2, 0
		mov	ax, 1
		push	ax
		call	sub_262E6
		add	sp, 2
		call	sub_1548C
		mov	sp, bp
		pop	bp
		retf
DoCharIntroScr	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_14DDC	proc far		; CODE XREF: sub_1507C+111p

var_10		= word ptr -10h
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
		mov	[bp+var_2], 1
		mov	[bp+var_A], 0
		mov	word_2CE14, 0
		mov	PlayerCharID, 0
		mov	word_2CB40, 0
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, 1
		push	ax
		sub	ax, ax
		push	ax
		push	cs
		call	near ptr sub_10828
		add	sp, 8
		mov	word_2D3FC, 3
		mov	word_2CB56, 0
		mov	word_2CBA1, 1
		mov	[bp+var_C], 0
		mov	word_2A9EA, 0
		sub	si, si
		mov	di, offset word_2D382

loc_14E34:				; CODE XREF: sub_14DDC+61j
		mov	[di], si
		add	di, 2
		inc	si
		cmp	si, 4
		jl	short loc_14E34
		mov	[bp+var_8], si
		mov	[bp+var_8], 4
		mov	si, offset word_2D382
		mov	[bp+var_10], 4

loc_14E4F:				; CODE XREF: sub_14DDC+9Bj
		call	sub_1525A
		and	ax, 3
		mov	[bp+var_4], ax
		mov	ax, [si]
		mov	[bp+var_6], ax
		mov	di, [bp+var_4]
		shl	di, 1
		add	di, offset word_2D382
		mov	ax, [di]
		mov	[si], ax
		mov	ax, [bp+var_6]
		mov	[di], ax
		add	si, 2
		dec	[bp+var_10]
		jnz	short loc_14E4F
		mov	word_2D38A, 4
		mov	word_2D38C, 4
		mov	word_2D38E, 5
		mov	word_2D390, 5
		mov	bx, word_2A9EA
		shl	bx, 1
		mov	ax, PlayerCharID
		cmp	word_2D382[bx],	ax
		jz	short loc_14EA3
		jmp	loc_15017
; ---------------------------------------------------------------------------

loc_14EA3:				; CODE XREF: sub_14DDC+C2j
		inc	word_2A9EA
		jmp	loc_15017
; ---------------------------------------------------------------------------

loc_14EAA:				; CODE XREF: sub_14DDC+241j
		mov	bx, word_2A9EA
		shl	bx, 1
		mov	ax, word_2D382[bx]
		mov	word_2A9E8, ax
		mov	word_2CB40, ax
		cmp	[bp+var_A], 0
		jnz	short loc_14ECF
		cmp	word_2A9EC, 0
		jnz	short loc_14ECF
		push	ax
		push	cs
		call	near ptr DoCharIntroScr
		add	sp, 2

loc_14ECF:				; CODE XREF: sub_14DDC+E2j
					; sub_14DDC+E9j
		mov	[bp+var_A], 0
		push	cs
		call	near ptr sub_124FA
		cmp	word_2A9EA, 1
		jle	short loc_14F0B
		mov	dx, word_2D380
		sub	ax, ax
		or	al, 16h
		mov	es, dx
		mov	bx, ax
		cmp	byte ptr es:[bx], 1
		jnz	short loc_14EF7
		mov	word_2D3FE, 100

loc_14EF7:				; CODE XREF: sub_14DDC+113j
		mov	dx, es
		sub	ax, ax
		or	al, 20h
		mov	bx, ax
		cmp	byte ptr es:[bx], 1
		jnz	short loc_14F0B
		mov	word_2A9F4, 8

loc_14F0B:				; CODE XREF: sub_14DDC+101j
					; sub_14DDC+127j
		push	cs
		call	near ptr sub_141D0
		or	ax, ax
		jz	short loc_14F26
		cmp	ax, 1
		jnz	short loc_14F1B
		jmp	loc_14FD4
; ---------------------------------------------------------------------------

loc_14F1B:				; CODE XREF: sub_14DDC+13Aj
		cmp	ax, 2
		jnz	short loc_14F23
		jmp	loc_1500E
; ---------------------------------------------------------------------------

loc_14F23:				; CODE XREF: sub_14DDC+142j
		jmp	loc_15017
; ---------------------------------------------------------------------------

loc_14F26:				; CODE XREF: sub_14DDC+135j
		call	sub_1548C
		inc	word_2A9EA
		cmp	word_2A9EA, 4
		jnz	short loc_14F3A
		inc	word_2A9EA

loc_14F3A:				; CODE XREF: sub_14DDC+158j
		mov	bx, word_2A9EA
		shl	bx, 1
		mov	ax, PlayerCharID
		cmp	word_2D382[bx],	ax
		jnz	short loc_14F4D
		inc	word_2A9EA

loc_14F4D:				; CODE XREF: sub_14DDC+16Bj
		cmp	word_2A9EA, 4
		jnz	short loc_14F58
		inc	word_2A9EA

loc_14F58:				; CODE XREF: sub_14DDC+176j
		mov	ax, 1
		push	ax
		push	cs
		call	near ptr DoPlayerWinScr
		add	sp, 2
		cmp	ax, 1
		jnz	short loc_14F6C
		push	cs
		call	near ptr sub_145EA

loc_14F6C:				; CODE XREF: sub_14DDC+18Aj
		cmp	word_2A9EA, 7
		jl	short loc_14FAE
		mov	[bp+var_C], 1
		mov	[bp+var_2], 0
		mov	word_2A9E8, 0
		mov	ax, PlayerCharID
		or	ax, ax
		jz	short loc_14FA6
		cmp	ax, 1
		jz	short loc_14FB6
		cmp	ax, 2
		jz	short loc_14FBC
		cmp	ax, 3
		jz	short loc_14FC2
		cmp	ax, 4
		jz	short loc_14FC8
		cmp	ax, 5
		jz	short loc_14FCE
		jmp	short loc_14FAA
; ---------------------------------------------------------------------------
		align 2

loc_14FA6:				; CODE XREF: sub_14DDC+1ACj
		push	cs
		call	near ptr DoEnd0_Yuka

loc_14FAA:				; CODE XREF: sub_14DDC+1C7j
					; sub_14DDC+1DEj ...
		push	cs
		call	near ptr DoOpening

loc_14FAE:				; CODE XREF: sub_14DDC+195j
		mov	ax, word_2A9E8
		mov	word_2CB40, ax
		jmp	short loc_15017
; ---------------------------------------------------------------------------

loc_14FB6:				; CODE XREF: sub_14DDC+1B1j
		push	cs
		call	near ptr DoEnd1_Jun
		jmp	short loc_14FAA
; ---------------------------------------------------------------------------

loc_14FBC:				; CODE XREF: sub_14DDC+1B6j
		push	cs
		call	near ptr DoEnd2_Manami
		jmp	short loc_14FAA
; ---------------------------------------------------------------------------

loc_14FC2:				; CODE XREF: sub_14DDC+1BBj
		push	cs
		call	near ptr DoEnd3_Chiho
		jmp	short loc_14FAA
; ---------------------------------------------------------------------------

loc_14FC8:				; CODE XREF: sub_14DDC+1C0j
		push	cs
		call	near ptr DoEnd4_Kaori
		jmp	short loc_14FAA
; ---------------------------------------------------------------------------

loc_14FCE:				; CODE XREF: sub_14DDC+1C5j
		push	cs
		call	near ptr DoEnd5_Reimi
		jmp	short loc_14FAA
; ---------------------------------------------------------------------------

loc_14FD4:				; CODE XREF: sub_14DDC+13Cj
		call	sub_1548C
		mov	ax, 1
		push	ax
		push	cs
		call	near ptr DoPlayerWinScr
		add	sp, 2
		or	ax, ax
		jnz	short loc_15013
		push	cs
		call	near ptr sub_11A04
		mov	[bp+var_2], ax
		cmp	ax, 1
		jnz	short loc_15017
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, 1
		push	ax
		sub	ax, ax
		push	ax
		push	cs
		call	near ptr sub_10828
		add	sp, 8
		mov	[bp+var_A], 1
		jmp	short loc_15017
; ---------------------------------------------------------------------------
		align 2

loc_1500E:				; CODE XREF: sub_14DDC+144j
		call	sub_1548C

loc_15013:				; CODE XREF: sub_14DDC+20Aj
		push	cs
		call	near ptr sub_145EA

loc_15017:				; CODE XREF: sub_14DDC+C4j
					; sub_14DDC+CBj ...
		cmp	[bp+var_2], 1
		jnz	short loc_15020
		jmp	loc_14EAA
; ---------------------------------------------------------------------------

loc_15020:				; CODE XREF: sub_14DDC+23Fj
		mov	ax, [bp+var_C]
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_14DDC	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_1502A	proc far		; CODE XREF: seg013:0068P
		call	sub_25C27
		mov	bx, word_2D012
		shl	bx, 1
		mov	word_2CF1A[bx],	ax
		inc	word_2D012
		cmp	word_2D012, 1Eh
		jnz	short locret_1504A
		mov	word_2D012, 0

locret_1504A:				; CODE XREF: sub_1502A+18j
		retf
sub_1502A	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_1504C	proc far		; CODE XREF: seg013:loc_25A2FP
		call	sub_25BD0
		mov	bx, word_2D012
		shl	bx, 1
		mov	word_2CF1A[bx],	ax
		call	sub_25B79
		mov	bx, word_2D012
		shl	bx, 1
		mov	word_2CF56[bx],	ax
		inc	word_2D012
		cmp	word_2D012, 1Eh
		jnz	short locret_1507B
		mov	word_2D012, 0

locret_1507B:				; CODE XREF: sub_1504C+27j
		retf
sub_1504C	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1507C	proc far		; CODE XREF: sub_2A894+13FP

var_2		= word ptr -2

		push	bp
		mov	bp, sp
		sub	sp, 4
		push	si
		mov	word_2CF92, 0
		mov	word_2CBDE, 0
		mov	word_2D392, 0
		mov	word_2D012, 0
		mov	[bp+var_2], 0
		mov	word_2D3FC, 3
		mov	word_2D3FE, 3
		call	sub_26039
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, 0Eh
		push	ax
		call	sub_29701
		add	sp, 6
		mov	word_2CB42, ax
		mov	al, byte ptr word_2CB42
		and	al, 2
		cmp	al, 2
		jnz	short loc_150D2
		sub	ax, ax
		jmp	short loc_150F1
; ---------------------------------------------------------------------------
		align 2

loc_150D2:				; CODE XREF: sub_1507C+4Fj
		mov	al, byte ptr word_2CB42
		and	al, 4
		cmp	al, 4
		jnz	short loc_150E0
		mov	ax, 4
		jmp	short loc_150F1
; ---------------------------------------------------------------------------

loc_150E0:				; CODE XREF: sub_1507C+5Dj
		mov	al, byte ptr word_2CB42
		and	al, 1
		cmp	al, 1
		jnz	short loc_150EE
		mov	ax, 3
		jmp	short loc_150F1
; ---------------------------------------------------------------------------

loc_150EE:				; CODE XREF: sub_1507C+6Bj
		mov	ax, 5

loc_150F1:				; CODE XREF: sub_1507C+53j
					; sub_1507C+62j ...
		mov	word_2A9E2, ax
		mov	ax, word_2CB42
		and	ax, 1
		push	ax
		call	sub_25D0E
		add	sp, 2
		mov	al, byte ptr word_2CB42
		and	al, 7
		cmp	al, 2
		jnz	short loc_15122
		mov	word_2A9EE, 1
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, 115h
		push	ax
		call	sub_29701
		add	sp, 6

loc_15122:				; CODE XREF: sub_1507C+8Ej
		test	byte ptr word_2CB42, 1
		jnz	short loc_1512F
		mov	word_2A9EE, 1

loc_1512F:				; CODE XREF: sub_1507C+ABj
		cmp	word_2A9E2, 5
		jz	short loc_15143
		sub	ax, ax
		push	ax
		push	ax
		push	ax
		call	sub_29701
		add	sp, 6

loc_15143:				; CODE XREF: sub_1507C+B8j
		mov	ax, 1
		push	ax
		call	sub_296E8
		add	sp, 2
		mov	word_2A9E8, 0
		call	sub_1542C
		call	sub_2A65A
		mov	word_2D380, ax
		mov	ax, offset aBNr3 ; "b:nr3"
		push	ax
		call	LoadHEM_2
		add	sp, 2
		mov	dx, word_2D380
		sub	ax, ax
		or	al, 0Ch
		mov	es, dx
		mov	bx, ax
		mov	al, es:[bx]
		sub	cx, cx
		or	cl, 16h
		mov	bx, cx
		mov	es:[bx], al
		mov	si, [bp+var_2]
		jmp	short loc_151B1
; ---------------------------------------------------------------------------

loc_1518C:				; CODE XREF: sub_1507C+194j
		push	cs
		call	near ptr sub_14DDC

loc_15190:				; CODE XREF: sub_1507C+1A6j
					; sub_1507C+1AEj ...
		cmp	word_2A9E2, 5
		jz	short loc_151A7
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, 3
		push	ax
		call	sub_29701
		add	sp, 6

loc_151A7:				; CODE XREF: sub_1507C+119j
		call	sub_1548C
		call	sub_1525A

loc_151B1:				; CODE XREF: sub_1507C+10Ej
		or	si, si
		jz	short loc_151B8
		jmp	loc_1523C
; ---------------------------------------------------------------------------

loc_151B8:				; CODE XREF: sub_1507C+137j
		call	sub_15322
		call	sub_16C4A
		mov	PlayerCharID, 0
		mov	word_2CB40, 0
		mov	dx, word_2D380
		sub	ax, ax
		or	al, 0Ch
		mov	es, dx
		mov	bx, ax
		mov	al, es:[bx]
		sub	cx, cx
		or	cl, 20h
		mov	bx, cx
		mov	es:[bx], al
		mov	al, byte ptr word_2CB42
		and	al, 1
		cmp	al, 1
		jnz	short loc_15208
		cmp	word_2A9EE, 0
		jnz	short loc_15208
		call	sub_2973A
		mov	ax, 2
		push	ax
		call	sub_29781
		add	sp, 2

loc_15208:				; CODE XREF: sub_1507C+172j
					; sub_1507C+179j
		push	cs
		call	near ptr sub_10F06
		or	ax, ax
		jnz	short loc_15213
		jmp	loc_1518C
; ---------------------------------------------------------------------------

loc_15213:				; CODE XREF: sub_1507C+192j
		cmp	ax, 1
		jz	short loc_15226
		cmp	ax, 2
		jz	short loc_1522E
		cmp	ax, 3
		jz	short loc_15236
		jmp	loc_15190
; ---------------------------------------------------------------------------
		align 2

loc_15226:				; CODE XREF: sub_1507C+19Aj
		push	cs
		call	near ptr sub_1455A
		jmp	loc_15190
; ---------------------------------------------------------------------------
		align 2

loc_1522E:				; CODE XREF: sub_1507C+19Fj
		push	cs
		call	near ptr sub_11462
		jmp	loc_15190
; ---------------------------------------------------------------------------
		align 2

loc_15236:				; CODE XREF: sub_1507C+1A4j
		mov	si, 1
		jmp	loc_15190
; ---------------------------------------------------------------------------

loc_1523C:				; CODE XREF: sub_1507C+139j
		mov	[bp+var_2], si
		call	sub_1539E
		call	sub_25E03
		call	sub_25E3C
		call	sub_26025
		sub	ax, ax
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_1507C	endp

seg000		ends

; ===========================================================================

; Segment type:	Pure code
seg001		segment	byte public 'CODE' use16
		assume cs:seg001
		;org 0Ah
		assume es:nothing, ss:nothing, ds:seg026, fs:nothing, gs:nothing

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1525A	proc far		; CODE XREF: sub_10F06:loc_11056P
					; sub_14DDC:loc_14E4FP	...

var_2		= word ptr -2

		push	bp
		mov	bp, sp
		sub	sp, 2
		mov	ax, word_2BEA6
		cwd
		mov	cx, 0B1h ; '�'
		idiv	cx
		shl	ax, 1
		mov	cx, ax
		mov	ax, word_2BEA6
		cwd
		mov	bx, 0B1h ; '�'
		idiv	bx
		mov	ax, dx
		mov	bx, 0ABh ; '�'
		imul	bx
		sub	ax, cx
		mov	word_2BEA6, ax
		mov	ax, word_2BEA8
		cwd
		mov	cx, 0B0h ; '�'
		idiv	cx
		mov	ax, dx
		mov	cx, 0ACh ; '�'
		imul	cx
		mov	cx, ax
		mov	ax, word_2BEA8
		cwd
		mov	bx, 0B0h ; '�'
		idiv	bx
		mov	bx, 23h	; '#'
		imul	bx
		sub	cx, ax
		mov	word_2BEA8, cx
		mov	ax, word_2BEAA
		cwd
		mov	cx, 0B2h ; '�'
		idiv	cx
		mov	ax, dx
		mov	cx, 0AAh ; '�'
		imul	cx
		mov	cx, ax
		mov	ax, word_2BEAA
		cwd
		mov	bx, 0B2h ; '�'
		idiv	bx
		mov	bx, 3Fh	; '?'
		imul	bx
		sub	cx, ax
		mov	word_2BEAA, cx
		cmp	word_2BEA6, 0
		jge	short loc_152DB
		add	word_2BEA6, 763Dh

loc_152DB:				; CODE XREF: sub_1525A+79j
		cmp	word_2BEA8, 0
		jge	short loc_152E8
		add	word_2BEA8, 7663h

loc_152E8:				; CODE XREF: sub_1525A+86j
		cmp	word_2BEAA, 0
		jge	short loc_152F5
		add	word_2BEAA, 7673h

loc_152F5:				; CODE XREF: sub_1525A+93j
		mov	ax, word_2BEA6
		add	ax, word_2BEA8
		add	ax, word_2BEAA
		mov	[bp+var_2], ax
		mov	cl, 7
		sar	ax, cl
		or	ax, ax
		jge	short loc_15316
		mov	ax, [bp+var_2]
		sar	ax, cl
		neg	ax
		mov	sp, bp
		pop	bp
		retf
; ---------------------------------------------------------------------------

loc_15316:				; CODE XREF: sub_1525A+AFj
		mov	ax, [bp+var_2]
		mov	cl, 7
		sar	ax, cl
		mov	sp, bp
		pop	bp
		retf
sub_1525A	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_15322	proc far		; CODE XREF: sub_10828+5AP
					; sub_10F06+21P ...
		call	sub_26005
		call	sub_2606B
		call	sub_262FB
		call	sub_260A7
		mov	ax, 50h	; 'P'
		push	ax
		call	sub_2591C
		add	sp, 2
		sub	ax, ax
		push	ax
		push	ax
		push	ax
		push	ax
		push	ax
		push	ax
		mov	ax, 1900h
		push	ax
		sub	ax, ax
		push	ax
		call	sub_258D1
		add	sp, 10h
		sub	ax, ax
		push	ax
		call	sub_262D1
		add	sp, 2
		mov	ax, 1
		push	ax
		call	sub_262E6
		add	sp, 2
		call	sub_26403
		sub	ax, ax
		push	ax
		call	sub_262E6
		add	sp, 2
		call	sub_26403
		call	sub_26363
		cmp	word_2A9E0, 0
		jnz	short loc_15398
		call	sub_2617F
		retf
; ---------------------------------------------------------------------------
		align 2

loc_15398:				; CODE XREF: sub_15322+6Dj
		call	sub_26228
		retf
sub_15322	endp


; =============== S U B	R O U T	I N E =======================================


sub_1539E	proc far		; CODE XREF: sub_1507C+1C3P
		call	sub_2606B
		call	sub_262FB
		call	sub_260A7
		mov	ax, 28h	; '('
		push	ax
		call	sub_2591C
		add	sp, 2
		sub	ax, ax
		push	ax
		call	sub_262D1
		add	sp, 2
		mov	ax, 1
		push	ax
		call	sub_262E6
		add	sp, 2
		call	sub_26403
		sub	ax, ax
		push	ax
		call	sub_262E6
		add	sp, 2
		call	sub_26403
		call	sub_260C5
		retf
sub_1539E	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_153EC	proc far		; CODE XREF: DoOpening+FBP
					; sub_154E4+F5p ...

var_2		= word ptr -2
arg_0		= dword	ptr  6
arg_4		= word ptr  0Ah
arg_6		= word ptr  0Ch
arg_8		= word ptr  0Eh

		push	bp
		mov	bp, sp
		sub	sp, 4
		push	di
		push	si
		mov	[bp+var_2], 0
		cmp	[bp+arg_8], 0
		jle	short loc_15426
		les	bx, [bp+arg_0]
		mov	ax, [bp+arg_4]
		mov	dx, [bp+arg_6]
		mov	cx, [bp+arg_8]
		shr	cx, 1
		mov	di, bx
		mov	si, ax
		push	ds
		mov	ds, dx
		assume ds:nothing
		repne movsw
		jnb	short loc_15419
		movsb

loc_15419:				; CODE XREF: sub_153EC+2Aj
		pop	ds
		mov	ax, [bp+arg_8]
		add	[bp+var_2], ax
		add	[bp+arg_4], ax
		add	word ptr [bp+arg_0], ax

loc_15426:				; CODE XREF: sub_153EC+11j
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_153EC	endp

		assume ds:seg026

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1542C	proc far		; CODE XREF: DoOpening+17CP
					; DoCharIntroScr+87P ...

var_2		= word ptr -2

		push	bp
		mov	bp, sp
		sub	sp, 8
		push	di
		push	si
		mov	[bp+var_2], 32h
		mov	si, offset word_2CE1C
		mov	di, (offset word_2CE1C+2)
		mov	cx, 32h

loc_15442:				; CODE XREF: sub_1542C+24j
		mov	word ptr [si], 0
		mov	word ptr [di], 0
		add	si, 4
		add	di, 4
		loop	loc_15442
		mov	word_2D37E, 0
		call	sub_25FB7
		mov	word_2D308, ax
		push	ax
		call	sub_25FA0
		add	sp, 2
		mov	word_2D30A, ax
		mov	word_2D394, ax
		add	ax, word_2D308
		mov	word_2CBE2, ax
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_1542C	endp

; ---------------------------------------------------------------------------
		db 2 dup(90h)

; =============== S U B	R O U T	I N E =======================================


sub_1547E	proc far		; CODE XREF: DoOpening+DP
					; DoCharIntroScr+5FP ...
		push	word_2D394
		call	sub_25FD0
		add	sp, 2
		retf
sub_1547E	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_1548C	proc far		; CODE XREF: sub_10828+6BBP
					; sub_10F06:loc_1120CP	...
		push	cs
		call	near ptr sub_1547E
		push	cs
		call	near ptr sub_1542C
		retf
sub_1548C	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_15496	proc far		; CODE XREF: sub_10828+B7P
					; sub_10828+1B2P ...

var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	si
		mov	[bp+var_2], 0
		mov	ax, [bp+arg_0]
		add	ax, word_2D30A
		cmp	ax, word_2CBE2
		jnb	short loc_154D6
		mov	si, word_2D37E
		mov	cl, 2
		shl	si, cl
		mov	ax, word_2D30A
		mov	[si+244Ch], ax
		mov	ax, [bp+arg_0]
		mov	[si+244Eh], ax
		add	word_2D30A, ax
		mov	ax, word_2D37E
		mov	[bp+var_2], ax
		inc	word_2D37E
		jmp	short loc_154DB
; ---------------------------------------------------------------------------
		align 2

loc_154D6:				; CODE XREF: sub_15496+17j
		mov	[bp+var_2], 0FFFFh

loc_154DB:				; CODE XREF: sub_15496+3Dj
		mov	ax, [bp+var_2]
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_15496	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_154E4	proc far		; CODE XREF: sub_12490+4P
					; sub_12490+19P ...

var_10		= word ptr -10h
var_E		= word ptr -0Eh
var_C		= word ptr -0Ch
var_A		= word ptr -0Ah
var_8		= word ptr -8
var_6		= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 10h
		push	di
		push	si
		mov	[bp+var_6], 0
		mov	bx, [bp+arg_0]
		shl	bx, 1
		shl	bx, 1
		cmp	word ptr [bx+244Ch], 0
		jnz	short loc_15508
		mov	[bp+var_6], 0FFFFh
		jmp	loc_15680
; ---------------------------------------------------------------------------
		align 2

loc_15508:				; CODE XREF: sub_154E4+19j
		mov	ax, word_2D37E
		dec	ax
		cmp	[bp+arg_0], ax
		jnz	short loc_1555A
		mov	ax, [bp+arg_0]
		shl	ax, 1
		shl	ax, 1
		mov	[bp+var_E], ax
		mov	bx, ax
		mov	ax, [bx+244Eh]
		sub	word_2D30A, ax
		mov	word ptr [bx+244Ch], 0
		mov	word ptr [bx+244Eh], 0
		mov	[bp+var_4], 31h	; '1'
		cmp	word_2CEE0, 0
		jz	short loc_15540
		jmp	loc_15679
; ---------------------------------------------------------------------------

loc_15540:				; CODE XREF: sub_154E4+57j
		mov	si, 2510h
		mov	cx, [bp+var_4]

loc_15546:				; CODE XREF: sub_154E4+70j
		or	cx, cx
		jge	short loc_1554D
		jmp	loc_15676
; ---------------------------------------------------------------------------

loc_1554D:				; CODE XREF: sub_154E4+64j
		sub	si, 4
		dec	cx
		cmp	word ptr [si], 0
		jz	short loc_15546
		jmp	loc_15676
; ---------------------------------------------------------------------------
		align 2

loc_1555A:				; CODE XREF: sub_154E4+2Bj
		mov	ax, [bp+arg_0]
		inc	ax
		mov	[bp+var_4], ax
		mov	bx, ax
		shl	bx, 1
		shl	bx, 1
		cmp	word ptr [bx+244Ch], 0
		jnz	short loc_15586
		mov	si, ax
		mov	cl, 2
		shl	si, cl
		add	si, 244Ch
		mov	cx, ax

loc_1557A:				; CODE XREF: sub_154E4+9Dj
		add	si, 4
		inc	cx
		cmp	word ptr [si], 0
		jz	short loc_1557A
		mov	[bp+var_4], cx

loc_15586:				; CODE XREF: sub_154E4+88j
		mov	[bp+var_2], 0
		mov	bx, [bp+var_4]
		shl	bx, 1
		shl	bx, 1
		mov	ax, [bx+244Ch]
		cmp	word_2D30A, ax
		jbe	short loc_155EC
		mov	di, [bp+var_4]
		mov	cl, 2
		shl	di, cl
		add	di, 244Ch
		mov	ax, [bp+arg_0]
		shl	ax, 1
		shl	ax, 1
		add	ax, 244Ch
		mov	[bp+var_C], ax
		mov	[bp+var_10], di
		mov	si, [bp+var_2]

loc_155BA:				; CODE XREF: sub_154E4+103j
		mov	ax, 10h
		push	ax
		mov	bx, [bp+var_10]
		mov	ax, [bx]
		add	ax, si
		mov	dx, ax
		sub	ax, ax
		push	dx
		push	ax
		mov	bx, [bp+var_C]
		mov	ax, [bx]
		add	ax, si
		mov	dx, ax
		sub	ax, ax
		push	dx
		push	ax
		push	cs
		call	near ptr sub_153EC
		add	sp, 0Ah
		inc	si
		mov	ax, word_2D30A
		sub	ax, [di]
		cmp	ax, si
		ja	short loc_155BA
		mov	[bp+var_2], si

loc_155EC:				; CODE XREF: sub_154E4+B6j
		mov	ax, [bp+arg_0]
		shl	ax, 1
		shl	ax, 1
		mov	[bp+var_E], ax
		mov	bx, ax
		mov	ax, [bx+244Eh]
		sub	word_2D30A, ax
		mov	bx, [bp+var_4]
		shl	bx, 1
		shl	bx, 1
		mov	ax, [bx+244Ch]
		mov	bx, [bp+var_E]
		sub	ax, [bx+244Ch]
		mov	[bp+var_8], ax
		mov	word ptr [bx+244Ch], 0
		mov	word ptr [bx+244Eh], 0
		mov	ax, [bp+arg_0]
		inc	ax
		mov	[bp+var_A], ax
		mov	ax, word_2D37E
		cmp	[bp+var_A], ax
		jnb	short loc_15657
		mov	si, [bp+var_A]
		mov	cl, 2
		shl	si, cl
		add	si, 244Ch
		mov	di, [bp+var_8]
		mov	dx, ax
		mov	cx, [bp+var_A]

loc_15643:				; CODE XREF: sub_154E4+16Ej
		cmp	word ptr [si], 0
		jz	short loc_1564A
		sub	[si], di

loc_1564A:				; CODE XREF: sub_154E4+162j
		add	si, 4
		inc	cx
		mov	ax, cx
		cmp	ax, dx
		jb	short loc_15643
		mov	[bp+var_A], cx

loc_15657:				; CODE XREF: sub_154E4+14Aj
		mov	[bp+var_4], 31h	; '1'
		cmp	word_2CEE0, 0
		jnz	short loc_15679
		mov	si, 2510h
		mov	cx, [bp+var_4]

loc_15669:				; CODE XREF: sub_154E4+190j
		or	cx, cx
		jl	short loc_15676
		sub	si, 4
		dec	cx
		cmp	word ptr [si], 0
		jz	short loc_15669

loc_15676:				; CODE XREF: sub_154E4+66j
					; sub_154E4+72j ...
		mov	[bp+var_4], cx

loc_15679:				; CODE XREF: sub_154E4+59j
					; sub_154E4+17Dj
		mov	ax, [bp+var_4]
		inc	ax
		mov	word_2D37E, ax

loc_15680:				; CODE XREF: sub_154E4+20j
		mov	ax, [bp+var_6]
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_154E4	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

strcat		proc far		; CODE XREF: sub_11A04+F0P
					; sub_11A04+149P ...

var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6
arg_2		= word ptr  8
arg_4		= word ptr  0Ah

		push	bp
		mov	bp, sp
		sub	sp, 4
		push	di
		push	si
		sub	cx, cx
		sub	dx, dx
		mov	di, [bp+arg_0]
		mov	si, [bp+arg_4]
		jmp	short loc_156A8
; ---------------------------------------------------------------------------

loc_1569E:				; CODE XREF: strcat+23j
		mov	bx, cx
		mov	al, [bx+si]
		mov	bx, dx
		mov	[bx+di], al
		inc	cx
		inc	dx

loc_156A8:				; CODE XREF: strcat+12j
		mov	bx, cx
		cmp	byte ptr [bx+si], 0
		jnz	short loc_1569E
		mov	[bp+var_4], dx
		mov	[bp+var_2], cx
		sub	cx, cx
		mov	di, [bp+arg_0]
		mov	si, [bp+arg_2]
		jmp	short loc_156CA
; ---------------------------------------------------------------------------
		align 2

loc_156C0:				; CODE XREF: strcat+45j
		mov	bx, cx
		mov	al, [bx+si]
		mov	bx, dx
		mov	[bx+di], al
		inc	cx
		inc	dx

loc_156CA:				; CODE XREF: strcat+33j
		mov	bx, cx
		cmp	byte ptr [bx+si], 0
		jnz	short loc_156C0
		mov	[bp+var_4], dx
		mov	[bp+var_2], cx
		mov	bx, dx
		mov	si, [bp+arg_0]
		mov	byte ptr [bx+si], 0
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
strcat		endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

SetPalColor	proc far		; CODE XREF: sub_10F06+253P
					; sub_10F06+28BP ...

arg_0		= word ptr  6
arg_2		= word ptr  8
arg_4		= word ptr  0Ah
arg_6		= word ptr  0Ch

		push	bp
		mov	bp, sp
		mov	ax, [bp+arg_0]
		out	0A8h, al	; Interrupt Controller #2, 8259A
		mov	ax, [bp+arg_6]
		out	0AEh, al	; Interrupt Controller #2, 8259A
		mov	ax, [bp+arg_4]
		out	0ACh, al	; Interrupt Controller #2, 8259A
		mov	ax, [bp+arg_2]
		out	0AAh, al	; Interrupt Controller #2, 8259A
		pop	bp
		retf
SetPalColor	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_15700	proc far		; CODE XREF: sub_11230P

var_8		= word ptr -8
var_6		= word ptr -6
var_2		= word ptr -2

		push	bp
		mov	bp, sp
		sub	sp, 8
		push	di
		push	si
		sub	si, si
		mov	di, 251Ah
		mov	[bp+var_6], 251Bh
		mov	[bp+var_8], 251Ch

loc_15717:				; CODE XREF: sub_15700+3Fj
		mov	al, [di]
		sub	ah, ah
		push	ax
		mov	bx, [bp+var_6]
		mov	al, [bx]
		push	ax
		mov	bx, [bp+var_8]
		mov	al, [bx]
		push	ax
		push	si
		push	cs
		call	near ptr SetPalColor
		add	sp, 8
		add	di, 3
		add	[bp+var_6], 3
		add	[bp+var_8], 3
		inc	si
		cmp	si, 10h
		jl	short loc_15717
		mov	[bp+var_2], si
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_15700	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1574A	proc far		; CODE XREF: sub_133B4+9P

var_4		= word ptr -4
var_2		= word ptr -2

		push	bp
		mov	bp, sp
		sub	sp, 8
		push	di
		push	si
		mov	[bp+var_2], 10h
		sub	si, si

loc_15759:				; CODE XREF: sub_1574A+2Dj
		sub	di, di
		mov	cx, 1
		push	si
		push	di
		lea	di, [si+297Ch]
		lea	si, [si+251Ah]
		push	ds
		pop	es
		assume es:seg026
		repne movsw
		movsb
		pop	di
		pop	si
		mov	di, 3
		add	si, di
		cmp	si, 30h	; '0'
		jl	short loc_15759
		mov	[bp+var_4], di
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_1574A	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_15782	proc far		; CODE XREF: sub_133B4+E1P

var_4		= word ptr -4
var_2		= word ptr -2

		push	bp
		mov	bp, sp
		sub	sp, 8
		push	di
		push	si
		mov	[bp+var_2], 10h
		sub	si, si

loc_15791:				; CODE XREF: sub_15782+2Dj
		sub	di, di
		mov	cx, 1
		push	si
		push	di
		lea	di, [si+251Ah]
		lea	si, [si+297Ch]
		push	ds
		pop	es
		repne movsw
		movsb
		pop	di
		pop	si
		mov	di, 3
		add	si, di
		cmp	si, 30h	; '0'
		jl	short loc_15791
		mov	[bp+var_4], di
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_15782	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_157BA	proc far		; CODE XREF: DoClearScr_A1+6AP
					; DoClearScr_A2+6AP ...

var_2		= word ptr -2

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	si
		sub	si, si

loc_157C3:				; CODE XREF: sub_157BA+1Aj
		sub	ax, ax
		push	ax
		push	ax
		push	ax
		push	si
		push	cs
		call	near ptr SetPalColor
		add	sp, 8
		inc	si
		cmp	si, 10h
		jl	short loc_157C3
		mov	[bp+var_2], si
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_157BA	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_157DE	proc far		; CODE XREF: DoClearScr_A1+74P
					; DoClearScr_A2+74P ...

var_A		= word ptr -0Ah
var_8		= word ptr -8
var_6		= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2

		push	bp
		mov	bp, sp
		sub	sp, 0Ah
		push	di
		push	si
		mov	di, 1

loc_157E9:				; CODE XREF: sub_157DE+77j
		sub	si, si
		mov	[bp+var_6], 251Ah
		mov	[bp+var_8], 251Bh
		mov	[bp+var_A], 251Ch

loc_157FA:				; CODE XREF: sub_157DE+64j
		mov	bx, [bp+var_6]
		mov	al, [bx]
		sub	ah, ah
		mov	cx, di
		mul	cx
		mov	cl, 4
		shr	ax, cl
		push	ax
		mov	bx, [bp+var_8]
		mov	al, [bx]
		sub	ah, ah
		mov	cx, di
		mul	cx
		mov	cl, 4
		shr	ax, cl
		push	ax
		mov	bx, [bp+var_A]
		mov	al, [bx]
		sub	ah, ah
		mov	cx, di
		mul	cx
		mov	cl, 4
		shr	ax, cl
		push	ax
		push	si
		push	cs
		call	near ptr SetPalColor
		add	sp, 8
		add	[bp+var_6], 3
		add	[bp+var_8], 3
		add	[bp+var_A], 3
		inc	si
		cmp	si, 10h
		jl	short loc_157FA
		mov	[bp+var_2], si
		call	MaybeWaitKey
		call	MaybeWaitKey
		inc	di
		cmp	di, 11h
		jl	short loc_157E9
		mov	[bp+var_4], di
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_157DE	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_15860	proc far		; CODE XREF: sub_133B4+4P
					; sub_133B4:loc_13486P	...

var_A		= word ptr -0Ah
var_8		= word ptr -8
var_6		= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2

		push	bp
		mov	bp, sp
		sub	sp, 0Ah
		push	di
		push	si
		mov	di, 10h

loc_1586B:				; CODE XREF: sub_15860+76j
		sub	si, si
		mov	[bp+var_6], 251Ah
		mov	[bp+var_8], 251Bh
		mov	[bp+var_A], 251Ch

loc_1587C:				; CODE XREF: sub_15860+64j
		mov	bx, [bp+var_6]
		mov	al, [bx]
		sub	ah, ah
		mov	cx, di
		mul	cx
		mov	cl, 4
		shr	ax, cl
		push	ax
		mov	bx, [bp+var_8]
		mov	al, [bx]
		sub	ah, ah
		mov	cx, di
		mul	cx
		mov	cl, 4
		shr	ax, cl
		push	ax
		mov	bx, [bp+var_A]
		mov	al, [bx]
		sub	ah, ah
		mov	cx, di
		mul	cx
		mov	cl, 4
		shr	ax, cl
		push	ax
		push	si
		push	cs
		call	near ptr SetPalColor
		add	sp, 8
		add	[bp+var_6], 3
		add	[bp+var_8], 3
		add	[bp+var_A], 3
		inc	si
		cmp	si, 10h
		jl	short loc_1587C
		mov	[bp+var_2], si
		call	MaybeWaitKey
		call	MaybeWaitKey
		dec	di
		or	di, di
		jg	short loc_1586B
		mov	[bp+var_4], di
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_15860	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

LoadMusic	proc far		; CODE XREF: sub_10828+C6P
					; sub_11A04+68P ...

var_4A		= word ptr -4Ah
var_48		= word ptr -48h
var_46		= word ptr -46h
var_44		= word ptr -44h
var_42		= word ptr -42h
var_40		= byte ptr -40h
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 4Ah
		push	di
		push	si
		cmp	word_2A9E2, 5
		jnz	short loc_158F4
		jmp	loc_15A06
; ---------------------------------------------------------------------------

loc_158F4:				; CODE XREF: LoadMusic+Dj
		mov	ax, word_2A9E2	; get music mode
		or	ax, ax
		jz	short loc_1591E
		cmp	ax, 1
		jnz	short loc_15903
		jmp	loc_159D8
; ---------------------------------------------------------------------------

loc_15903:				; CODE XREF: LoadMusic+1Cj
		cmp	ax, 2
		jnz	short loc_1590B
		jmp	loc_159E2
; ---------------------------------------------------------------------------

loc_1590B:				; CODE XREF: LoadMusic+24j
		cmp	ax, 3
		jnz	short loc_15913
		jmp	loc_159EC
; ---------------------------------------------------------------------------

loc_15913:				; CODE XREF: LoadMusic+2Cj
		cmp	ax, 4
		jnz	short loc_1591B
		jmp	loc_159F6
; ---------------------------------------------------------------------------

loc_1591B:				; CODE XREF: LoadMusic+34j
		jmp	short loc_15930
; ---------------------------------------------------------------------------
		align 2

loc_1591E:				; CODE XREF: LoadMusic+17j
		push	[bp+arg_0]
		mov	ax, offset a_hgs ; ".hgs"

loc_15924:				; CODE XREF: LoadMusic+FCj
					; LoadMusic+106j ...
		push	ax
		lea	ax, [bp+var_40]
		push	ax
		push	cs
		call	near ptr strcat
		add	sp, 6

loc_15930:				; CODE XREF: LoadMusic:loc_1591Bj
		lea	ax, [bp+var_40]
		push	ax
		call	MaybeLoadFile
		add	sp, 2
		mov	[bp+var_44], ax
		push	ax
		push	cs
		call	near ptr sub_15496
		add	sp, 2
		mov	[bp+var_46], ax
		shl	ax, 1
		shl	ax, 1
		add	ax, offset word_2CE1C
		mov	[bp+var_4A], ax
		mov	bx, ax
		push	word ptr [bx]
		lea	ax, [bp+var_40]
		push	ax
		call	sub_29694
		add	sp, 4
		call	sub_26363
		mov	ax, 0A800h
		push	ax
		mov	bx, [bp+var_4A]
		push	word ptr [bx]
		call	sub_2A177
		add	sp, 4
		mov	[bp+var_44], ax
		push	[bp+var_46]
		push	cs
		call	near ptr sub_154E4
		add	sp, 2
		push	[bp+var_44]
		push	cs
		call	near ptr sub_15496
		add	sp, 2
		mov	[bp+var_46], ax
		mov	[bp+var_42], 0
		cmp	[bp+var_44], 0
		jz	short loc_15A14
		shl	ax, 1
		shl	ax, 1
		add	ax, offset word_2CE1C
		mov	[bp+var_48], ax
		mov	di, [bp+var_44]
		mov	si, [bp+var_42]

loc_159AF:				; CODE XREF: LoadMusic+F4j
		mov	ax, 10h
		push	ax
		lea	ax, [si+0A800h]
		mov	dx, ax
		sub	ax, ax
		push	dx
		push	ax
		mov	bx, [bp+var_48]
		mov	ax, [bx]
		add	ax, si
		mov	dx, ax
		sub	ax, ax
		push	dx
		push	ax
		push	cs
		call	near ptr sub_153EC
		add	sp, 0Ah
		inc	si
		cmp	si, di
		jnb	short loc_15A00
		jmp	short loc_159AF
; ---------------------------------------------------------------------------

loc_159D8:				; CODE XREF: LoadMusic+1Ej
		push	[bp+arg_0]
		mov	ax, offset a_hcm ; ".hcm"
		jmp	loc_15924
; ---------------------------------------------------------------------------
		align 2

loc_159E2:				; CODE XREF: LoadMusic+26j
		push	[bp+arg_0]
		mov	ax, offset a_hmt ; ".hmt"
		jmp	loc_15924
; ---------------------------------------------------------------------------
		align 2

loc_159EC:				; CODE XREF: LoadMusic+2Ej
		push	[bp+arg_0]
		mov	ax, offset a_hfm ; ".hfm"
		jmp	loc_15924
; ---------------------------------------------------------------------------
		align 2

loc_159F6:				; CODE XREF: LoadMusic+36j
		push	[bp+arg_0]
		mov	ax, offset a_hf2 ; ".hf2"
		jmp	loc_15924
; ---------------------------------------------------------------------------
		align 2

loc_15A00:				; CODE XREF: LoadMusic+F2j
		mov	[bp+var_42], si
		jmp	short loc_15A14
; ---------------------------------------------------------------------------
		align 2

loc_15A06:				; CODE XREF: LoadMusic+Fj
		mov	ax, 1
		push	ax
		push	cs
		call	near ptr sub_15496
		add	sp, 2
		mov	[bp+var_46], ax

loc_15A14:				; CODE XREF: LoadMusic+BBj
					; LoadMusic+121j
		mov	ax, [bp+var_46]
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
LoadMusic	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

LoadMusic2	proc far		; CODE XREF: sub_124FA+DP
					; DoPlayerWinScr+59P

var_4A		= word ptr -4Ah
var_48		= word ptr -48h
var_46		= word ptr -46h
var_44		= word ptr -44h
var_42		= word ptr -42h
var_40		= byte ptr -40h
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 4Ah
		push	di
		push	si
		cmp	word_2A9E2, 5
		jnz	short loc_15A30
		jmp	loc_15AEE
; ---------------------------------------------------------------------------

loc_15A30:				; CODE XREF: LoadMusic2+Dj
		push	[bp+arg_0]
		mov	ax, offset a_hfm_0 ; ".hfm"
		push	ax
		lea	ax, [bp+var_40]
		push	ax
		push	cs
		call	near ptr strcat
		add	sp, 6
		lea	ax, [bp+var_40]
		push	ax
		call	MaybeLoadFile
		add	sp, 2
		mov	[bp+var_44], ax
		push	ax
		push	cs
		call	near ptr sub_15496
		add	sp, 2
		mov	[bp+var_46], ax
		shl	ax, 1
		shl	ax, 1
		add	ax, offset word_2CE1C
		mov	[bp+var_4A], ax
		mov	bx, ax
		push	word ptr [bx]
		lea	ax, [bp+var_40]
		push	ax
		call	sub_29694
		add	sp, 4
		call	sub_26363
		mov	ax, 0A800h
		push	ax
		mov	bx, [bp+var_4A]
		push	word ptr [bx]
		call	sub_2A177
		add	sp, 4
		mov	[bp+var_44], ax
		push	[bp+var_46]
		push	cs
		call	near ptr sub_154E4
		add	sp, 2
		push	[bp+var_44]
		push	cs
		call	near ptr sub_15496
		add	sp, 2
		mov	[bp+var_46], ax
		mov	[bp+var_42], 0
		cmp	[bp+var_44], 0
		jz	short loc_15AFC
		shl	ax, 1
		shl	ax, 1
		add	ax, offset word_2CE1C
		mov	[bp+var_48], ax
		mov	di, [bp+var_44]
		mov	si, [bp+var_42]

loc_15AC1:				; CODE XREF: LoadMusic2+C8j
		mov	ax, 10h
		push	ax
		lea	ax, [si+0A800h]
		mov	dx, ax
		sub	ax, ax
		push	dx
		push	ax
		mov	bx, [bp+var_48]
		mov	ax, [bx]
		add	ax, si
		mov	dx, ax
		sub	ax, ax
		push	dx
		push	ax
		push	cs
		call	near ptr sub_153EC
		add	sp, 0Ah
		inc	si
		cmp	si, di
		jb	short loc_15AC1
		mov	[bp+var_42], si
		jmp	short loc_15AFC
; ---------------------------------------------------------------------------
		align 2

loc_15AEE:				; CODE XREF: LoadMusic2+Fj
		mov	ax, 1
		push	ax
		push	cs
		call	near ptr sub_15496
		add	sp, 2
		mov	[bp+var_46], ax

loc_15AFC:				; CODE XREF: LoadMusic2+91j
					; LoadMusic2+CDj
		mov	ax, [bp+var_46]
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
LoadMusic2	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

LoadSFX		proc far		; CODE XREF: sub_10828+D5P
					; sub_124FA+40P ...

var_4A		= word ptr -4Ah
var_48		= word ptr -48h
var_46		= word ptr -46h
var_44		= word ptr -44h
var_42		= word ptr -42h
var_40		= byte ptr -40h
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 4Ah
		push	di
		push	si
		cmp	word_2A9E2, 5
		jnz	short loc_15B18
		jmp	loc_15BD6
; ---------------------------------------------------------------------------

loc_15B18:				; CODE XREF: LoadSFX+Dj
		push	[bp+arg_0]
		mov	ax, 14FAh
		push	ax
		lea	ax, [bp+var_40]
		push	ax
		push	cs
		call	near ptr strcat
		add	sp, 6
		lea	ax, [bp+var_40]
		push	ax
		call	MaybeLoadFile
		add	sp, 2
		mov	[bp+var_44], ax
		push	ax
		push	cs
		call	near ptr sub_15496
		add	sp, 2
		mov	[bp+var_46], ax
		shl	ax, 1
		shl	ax, 1
		add	ax, 244Ch
		mov	[bp+var_4A], ax
		mov	bx, ax
		push	word ptr [bx]
		lea	ax, [bp+var_40]
		push	ax
		call	sub_29694
		add	sp, 4
		call	sub_26363
		mov	ax, 0A800h
		push	ax
		mov	bx, [bp+var_4A]
		push	word ptr [bx]
		call	sub_2A177
		add	sp, 4
		mov	[bp+var_44], ax
		push	[bp+var_46]
		push	cs
		call	near ptr sub_154E4
		add	sp, 2
		push	[bp+var_44]
		push	cs
		call	near ptr sub_15496
		add	sp, 2
		mov	[bp+var_46], ax
		mov	[bp+var_42], 0
		cmp	[bp+var_44], 0
		jle	short loc_15BE4
		shl	ax, 1
		shl	ax, 1
		add	ax, 244Ch
		mov	[bp+var_48], ax
		mov	di, [bp+var_44]
		mov	si, [bp+var_42]

loc_15BA9:				; CODE XREF: LoadSFX+C9j
		mov	ax, 10h
		push	ax
		mov	ax, si
		add	ah, 0A8h ; '�'
		mov	dx, ax
		sub	ax, ax
		push	dx
		push	ax
		mov	bx, [bp+var_48]
		mov	ax, [bx]
		add	ax, si
		mov	dx, ax
		sub	ax, ax
		push	dx
		push	ax
		push	cs
		call	near ptr sub_153EC
		add	sp, 0Ah
		inc	si
		cmp	si, di
		jl	short loc_15BA9
		mov	[bp+var_42], si
		jmp	short loc_15BE4
; ---------------------------------------------------------------------------

loc_15BD6:				; CODE XREF: LoadSFX+Fj
		mov	ax, 1
		push	ax
		push	cs
		call	near ptr sub_15496
		add	sp, 2
		mov	[bp+var_46], ax

loc_15BE4:				; CODE XREF: LoadSFX+91j LoadSFX+CEj
		mov	ax, [bp+var_46]
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
LoadSFX		endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_15BEE	proc far		; CODE XREF: sub_10828+31BP
					; sub_10828+350P ...

arg_0		= byte ptr  6

		push	bp
		mov	bp, sp
		cmp	word_2A9E2, 5
		jz	short loc_15C1D
		mov	al, byte ptr word_2CB42
		and	al, 1
		cmp	al, 1
		jnz	short loc_15C1D
		cmp	word_2A9F2, 0
		jnz	short loc_15C1D
		sub	ax, ax
		push	ax
		push	ax
		mov	ah, [bp+arg_0]
		sub	al, al
		add	ax, 7
		push	ax
		call	sub_29701
		add	sp, 6

loc_15C1D:				; CODE XREF: sub_15BEE+8j
					; sub_15BEE+11j ...
		pop	bp
		retf
sub_15BEE	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_15C20	proc far		; CODE XREF: sub_10828+344P
					; sub_10828+478P ...

arg_0		= word ptr  6
arg_2		= word ptr  8

		push	bp
		mov	bp, sp
		mov	al, byte ptr word_2CB42
		and	al, 1
		cmp	al, 1
		jnz	short loc_15C8E
		cmp	word_2A9EE, 0
		jnz	short loc_15C8E
		mov	word_2A9F2, 1
		sub	ax, ax
		push	ax
		mov	ax, 80h	; '�'
		push	ax
		mov	ax, 1Ah
		push	ax
		call	sub_29701
		add	sp, 6
		mov	ax, [bp+arg_0]
		or	ax, ax
		jz	short loc_15C60
		cmp	ax, 1
		jz	short loc_15C7A
		cmp	ax, 2
		jz	short loc_15C84
		pop	bp
		retf
; ---------------------------------------------------------------------------
		align 2

loc_15C60:				; CODE XREF: sub_15C20+31j
		push	[bp+arg_2]
		mov	bx, word_2D3B8

loc_15C67:				; CODE XREF: sub_15C20+61j
					; sub_15C20+6Bj
		shl	bx, 1
		shl	bx, 1
		push	word_2CE1C[bx]
		call	sub_297AE
		add	sp, 4
		pop	bp
		retf
; ---------------------------------------------------------------------------
		align 2

loc_15C7A:				; CODE XREF: sub_15C20+36j
		push	[bp+arg_2]
		mov	bx, word_2D3BA
		jmp	short loc_15C67
; ---------------------------------------------------------------------------
		align 2

loc_15C84:				; CODE XREF: sub_15C20+3Bj
		push	[bp+arg_2]
		mov	bx, word_2D3B6
		jmp	short loc_15C67
; ---------------------------------------------------------------------------
		align 2

loc_15C8E:				; CODE XREF: sub_15C20+Aj
					; sub_15C20+11j
		pop	bp
		retf
sub_15C20	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

SetTextColor	proc far		; CODE XREF: DoPlayerWinScr+C6P
					; DoClearScr_A1+89P ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		mov	ax, [bp+arg_0]
		mov	textColor, ax
		pop	bp
		retf
SetTextColor	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


ClearTextBox	proc far		; CODE XREF: DoEnd0_Yuka+138P
					; DoEnd0_Yuka+1E7P ...
		sub	ax, ax
		push	ax
		mov	ax, textBox_YEnd
		mov	cl, 4
		shl	ax, cl
		add	ax, 0Fh
		push	ax
		mov	ax, textBox_XEnd
		mov	cl, 3
		shl	ax, cl
		add	ax, 0Fh
		push	ax
		mov	ax, textBox_YStart
		mov	cl, 4
		shl	ax, cl
		push	ax
		mov	ax, textBox_XStart
		mov	cl, 3
		shl	ax, cl
		push	ax
		call	j_ClearBox
		add	sp, 0Ah
		mov	textPosX, 0
		mov	textPosY, 0
		retf
ClearTextBox	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

LoadText_DS	proc far		; CODE XREF: DoClearScr_A1+D4P
					; DoClearScr_A1+E4P ...

var_6		= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2
txtPtr		= word ptr  6

		push	bp		; load text from Data Segment (DS)
		mov	bp, sp
		sub	sp, 6
		push	di
		push	si
		sub	di, di
		mov	si, [bp+var_2]
		jmp	loc_15DD5
; ---------------------------------------------------------------------------

loc_15CEA:				; CODE XREF: LoadText_DS+108j
		call	MaybeWaitKey
		call	MaybeWaitKey
		mov	ax, di
		add	ax, [bp+txtPtr]
		mov	[bp+var_6], ax
		mov	bx, ax
		mov	al, [bx]	; read Shift-JIS 1st byte
		sub	ah, ah
		mov	si, ax
		mov	cl, 8
		shl	si, cl
		mov	al, [bx+1]	; read Shift-JIS 2nd byte
		add	si, ax
		push	si		; push Shift-JIS character code
		sub	ax, ax
		push	ax		; push color 0 (shadow)
		mov	ax, textBox_YStart
		add	ax, textPosY
		mov	cl, 4
		shl	ax, cl
		inc	ax		; shadow1 Y pixel position = row * 16 +	1
		push	ax		; push Y position
		mov	ax, textBox_XStart
		add	ax, textPosX
		mov	cl, 3
		shl	ax, cl
		inc	ax		; shadow1 X pixel position = column * 8	+ 1
		push	ax		; push X position
		call	j_DrawTextChar
		add	sp, 8
		push	si		; draw again with (X+1)	for bold font
		sub	ax, ax
		push	ax
		mov	ax, textBox_YStart
		add	ax, textPosY
		mov	cl, 4
		shl	ax, cl
		inc	ax		; shadow2 Y pixel position = row * 16 +	1
		push	ax
		mov	ax, textBox_XStart
		add	ax, textPosX
		mov	cl, 3
		shl	ax, cl
		add	ax, 2		; shadow2 X pixel position = column * 8	+ 2
		push	ax
		call	j_DrawTextChar
		add	sp, 8
		push	si		; push Shift-JIS character code
		push	textColor	; push actual text color
		mov	ax, textBox_YStart
		add	ax, textPosY
		mov	cl, 4
		shl	ax, cl		; Y pixel position = row * 16
		push	ax
		mov	ax, textBox_XStart
		add	ax, textPosX
		mov	cl, 3
		shl	ax, cl		; X pixel position = column * 8
		push	ax
		call	j_DrawTextChar
		add	sp, 8
		push	si		; draw again with (X+1)	for bold font
		push	textColor
		mov	ax, textBox_YStart
		add	ax, textPosY
		mov	cl, 4
		shl	ax, cl
		push	ax
		mov	ax, textBox_XStart
		add	ax, textPosX
		mov	cl, 3
		shl	ax, cl
		inc	ax
		push	ax
		call	j_DrawTextChar
		add	sp, 8
		inc	di		; advance text pointer by 1
		add	textPosX, 2
		mov	ax, textBox_XEnd
		sub	ax, textBox_XStart
		cmp	ax, textPosX
		jge	short loc_15DD4
		mov	textPosX, 0	; enforce line break when reaching XEnd
		inc	textPosY
		mov	ax, textBox_YEnd
		sub	ax, textBox_YStart
		cmp	ax, textPosY
		jge	short loc_15DD4
		push	cs		; clear	text box when reaching YEnd
		call	near ptr ClearTextBox

loc_15DD4:				; CODE XREF: LoadText_DS+DDj
					; LoadText_DS+F4j ...
		inc	di		; advance text pointer by 1

loc_15DD5:				; CODE XREF: LoadText_DS+Dj
		mov	bx, [bp+txtPtr]
		cmp	byte ptr [bx+di], 0
		jz	short loc_15DF2
		cmp	byte ptr [bx+di], 'n'
		jz	short loc_15DE5	; handle newline
		jmp	loc_15CEA
; ---------------------------------------------------------------------------

loc_15DE5:				; CODE XREF: LoadText_DS+106j
		mov	textPosX, 0
		inc	textPosY
		jmp	short loc_15DD4
; ---------------------------------------------------------------------------
		align 2

loc_15DF2:				; CODE XREF: LoadText_DS+101j
		mov	[bp+var_4], di
		mov	[bp+var_2], si
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
LoadText_DS	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

LoadText_ES	proc far		; CODE XREF: j_LoadText_ES+30p

var_4		= word ptr -4
var_2		= word ptr -2
txtPtr		= dword	ptr  6

		push	bp		; load text from Extra Segment (ES)
		mov	bp, sp
		sub	sp, 4
		push	di
		push	si
		sub	si, si
		mov	di, [bp+var_2]
		jmp	loc_15EF4
; ---------------------------------------------------------------------------

loc_15E0E:				; CODE XREF: LoadText_ES+105j
		call	MaybeWaitKey
		call	MaybeWaitKey
		les	bx, [bp+txtPtr]
		assume es:nothing
		mov	al, es:[bx+si]	; read Shift-JIS 1st byte
		sub	ah, ah
		mov	di, ax
		mov	cl, 8
		shl	di, cl
		mov	al, es:[bx+si+1] ; read	Shift-JIS 2nd byte
		add	di, ax
		push	di
		sub	ax, ax
		push	ax
		mov	ax, textBox_YStart
		add	ax, textPosY
		mov	cl, 4
		shl	ax, cl
		inc	ax
		push	ax
		mov	ax, textBox_XStart
		add	ax, textPosX
		mov	cl, 3
		shl	ax, cl
		inc	ax
		push	ax
		call	j_DrawTextChar
		add	sp, 8
		push	di
		sub	ax, ax
		push	ax
		mov	ax, textBox_YStart
		add	ax, textPosY
		mov	cl, 4
		shl	ax, cl
		inc	ax
		push	ax
		mov	ax, textBox_XStart
		add	ax, textPosX
		mov	cl, 3
		shl	ax, cl
		add	ax, 2
		push	ax
		call	j_DrawTextChar
		add	sp, 8
		push	di
		push	textColor
		mov	ax, textBox_YStart
		add	ax, textPosY
		mov	cl, 4
		shl	ax, cl
		push	ax
		mov	ax, textBox_XStart
		add	ax, textPosX
		mov	cl, 3
		shl	ax, cl
		push	ax
		call	j_DrawTextChar
		add	sp, 8
		push	di
		push	textColor
		mov	ax, textBox_YStart
		add	ax, textPosY
		mov	cl, 4
		shl	ax, cl
		push	ax
		mov	ax, textBox_XStart
		add	ax, textPosX
		mov	cl, 3
		shl	ax, cl
		inc	ax
		push	ax
		call	j_DrawTextChar
		add	sp, 8
		inc	si		; advance text pointer by 1
		add	textPosX, 2
		mov	ax, textBox_XEnd
		sub	ax, textBox_XStart
		cmp	ax, textPosX
		jge	short loc_15EF3
		mov	textPosX, 0
		inc	textPosY
		mov	ax, textBox_YEnd
		sub	ax, textBox_YStart
		cmp	ax, textPosY
		jge	short loc_15EF3
		push	cs
		call	near ptr ClearTextBox

loc_15EF3:				; CODE XREF: LoadText_ES+D8j
					; LoadText_ES+EFj ...
		inc	si		; advance text pointer by 1

loc_15EF4:				; CODE XREF: LoadText_ES+Dj
		les	bx, [bp+txtPtr]
		cmp	byte ptr es:[bx+si], 0
		jz	short loc_15F12
		cmp	byte ptr es:[bx+si], 'n'
		jz	short loc_15F06	; handle newline
		jmp	loc_15E0E
; ---------------------------------------------------------------------------

loc_15F06:				; CODE XREF: LoadText_ES+103j
		mov	textPosX, 0
		inc	textPosY
		jmp	short loc_15EF3
; ---------------------------------------------------------------------------

loc_15F12:				; CODE XREF: LoadText_ES+FDj
		mov	[bp+var_2], di
		mov	[bp+var_4], si
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
LoadText_ES	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

j_LoadText_ES	proc far		; CODE XREF: DoPlayerWinScr+274P

var_8		= dword	ptr -8
var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6
arg_2		= word ptr  8

		push	bp
		mov	bp, sp
		sub	sp, 8
		mov	ax, [bp+arg_2]	; get text index
		shl	ax, 1		; index	-> offset into list of 2-byte pointers
		cwd			; extend AX -> DX:AX
		mov	bx, [bp+arg_0]
		mov	cx, ax
		or	bx, dx
		mov	word ptr [bp+var_8], cx	; save TOC pointer
		mov	word ptr [bp+var_8+2], bx ; save TOC segment
		les	bx, [bp+var_8]
		mov	ax, es:[bx]	; read pointer from TOC
		cwd			; extend AX -> DX:AX
		mov	bx, [bp+arg_0]
		mov	cx, ax
		or	bx, dx
		mov	[bp+var_4], cx	; save text pointer
		mov	[bp+var_2], bx	; save text segment
		push	bx		; text data segment
		push	cx		; text data pointer
		push	cs		; unused
		call	near ptr LoadText_ES
		mov	sp, bp
		pop	bp
		retf
j_LoadText_ES	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

SomethingTextBox proc far		; CODE XREF: DoClearScr_A1+ABP
					; DoClearScr_A1+C8P ...

var_14		= word ptr -14h
var_12		= word ptr -12h
var_10		= word ptr -10h
var_A		= word ptr -0Ah
var_8		= word ptr -8
var_6		= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6
arg_2		= word ptr  8
arg_4		= word ptr  0Ah
arg_6		= word ptr  0Ch

		push	bp
		mov	bp, sp
		sub	sp, 14h
		push	di
		push	si
		mov	ax, [bp+arg_0]
		mov	textBox_XStart,	ax
		mov	ax, [bp+arg_2]
		mov	textBox_YStart,	ax
		mov	ax, [bp+arg_4]
		mov	textBox_XEnd, ax
		mov	ax, [bp+arg_6]
		mov	textBox_YEnd, ax
		mov	ax, [bp+arg_2]
		mov	cl, 4
		shl	ax, cl
		mov	[bp+var_12], ax
		mov	ax, [bp+arg_6]
		shl	ax, cl
		mov	[bp+var_14], ax
		add	ax, [bp+var_12]
		add	ax, 0Fh
		cwd
		sub	ax, dx
		sar	ax, 1
		mov	[bp+var_4], ax
		mov	ax, [bp+var_14]
		sub	ax, [bp+var_12]
		add	ax, 1Fh
		cwd
		xor	ax, dx
		sub	ax, dx
		mov	cx, 2
		sar	ax, cl
		xor	ax, dx
		sub	ax, dx
		mov	[bp+var_6], ax
		mov	[bp+var_2], 0
		or	ax, ax
		jle	short loc_16002
		mov	ax, [bp+arg_0]
		mov	cl, 3
		shl	ax, cl
		sub	ax, 8
		mov	[bp+var_8], ax
		mov	ax, [bp+arg_4]
		shl	ax, cl
		add	ax, 0Fh
		mov	[bp+var_A], ax
		mov	si, [bp+var_4]
		mov	di, si
		mov	ax, [bp+var_6]
		mov	[bp+var_10], ax
		add	[bp+var_2], ax

loc_15FDF:				; CODE XREF: SomethingTextBox+AAj
		call	MaybeWaitKey
		sub	ax, ax
		push	ax
		push	si
		push	[bp+var_A]
		push	di
		push	[bp+var_8]
		call	sub_29D48
		add	sp, 0Ah
		add	si, 2
		sub	di, 2
		dec	[bp+var_10]
		jnz	short loc_15FDF

loc_16002:				; CODE XREF: SomethingTextBox+61j
		call	MaybeWaitKey
		sub	ax, ax
		push	ax
		mov	ax, [bp+arg_6]
		mov	cl, 4
		shl	ax, cl
		add	ax, 17h
		push	ax
		mov	ax, [bp+arg_4]
		mov	cl, 3
		shl	ax, cl
		add	ax, 0Fh
		push	ax
		mov	ax, [bp+arg_2]
		mov	cl, 4
		shl	ax, cl
		sub	ax, 8
		push	ax
		mov	ax, [bp+arg_0]
		mov	cl, 3
		shl	ax, cl
		sub	ax, 8
		push	ax
		call	sub_29D48
		add	sp, 0Ah
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
SomethingTextBox endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

SetupTextBox	proc far		; CODE XREF: DoPlayerWinScr+BAP
					; DoCharIntroScr+B6P

arg_0		= word ptr  6
arg_2		= word ptr  8
arg_4		= word ptr  0Ah
arg_6		= word ptr  0Ch

		push	bp
		mov	bp, sp
		sub	sp, 6
		mov	ax, [bp+arg_0]
		mov	textBox_XStart,	ax
		mov	ax, [bp+arg_2]
		mov	textBox_YStart,	ax
		mov	ax, [bp+arg_4]
		mov	textBox_XEnd, ax
		mov	ax, [bp+arg_6]
		mov	textBox_YEnd, ax
		mov	sp, bp
		pop	bp
		retf
SetupTextBox	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

SetTextPosition	proc far		; CODE XREF: DoPlayerWinScr+D2P
					; DoClearScr_A1+7DP ...

arg_0		= word ptr  6
arg_2		= word ptr  8

		push	bp
		mov	bp, sp
		mov	ax, [bp+arg_0]
		mov	textPosX, ax
		mov	ax, [bp+arg_2]
		mov	textPosY, ax
		pop	bp
		retf
SetTextPosition	endp

seg001		ends

; ===========================================================================

; Segment type:	Pure code
seg002		segment	byte public 'CODE' use16
		assume cs:seg002
		;org 7
		assume es:nothing, ss:nothing, ds:nothing, fs:nothing, gs:nothing
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_16078	proc far		; CODE XREF: sub_11230+35P
					; sub_11230+4BP

var_16		= word ptr -16h
var_14		= dword	ptr -14h
var_10		= word ptr -10h
var_C		= word ptr -0Ch
var_A		= word ptr -0Ah
var_8		= word ptr -8
var_6		= word ptr -6
var_4		= dword	ptr -4

		push	bp
		mov	bp, sp
		sub	sp, 16h
		push	di
		push	si
		mov	bx, ds:29DAh
		shl	bx, 1
		shl	bx, 1
		mov	dx, [bx+244Ch]
		sub	ax, ax
		mov	[bp+var_8], ax
		mov	[bp+var_6], dx
		add	[bp+var_8], 2
		mov	bx, ds:29DCh
		shl	bx, 1
		shl	bx, 1
		mov	dx, [bx+244Ch]
		mov	word ptr [bp+var_4], ax
		mov	word ptr [bp+var_4+2], dx
		mov	[bp+var_C], ax
		mov	[bp+var_16], ax
		mov	[bp+var_10], ax

loc_160B3:				; CODE XREF: sub_16078+93j
		sub	si, si
		mov	di, [bp+var_16]
		mov	ax, [bp+var_10]
		add	ax, [bp+var_8]
		mov	dx, [bp+var_6]
		mov	word ptr [bp+var_14], ax
		mov	word ptr [bp+var_14+2],	dx

loc_160C7:				; CODE XREF: sub_16078+7Ej
		les	bx, [bp+var_14]
		push	word ptr es:[bx]
		mov	bx, ds:29C8h
		shl	bx, 1
		shl	bx, 1
		push	word ptr [bx+244Ch]
		push	[bp+var_C]
		push	si
		call	sub_27C36
		add	sp, 8
		les	bx, [bp+var_4]
		add	bx, di
		mov	byte ptr es:[bx+si], 0
		add	word ptr [bp+var_14], 2
		inc	si
		cmp	si, 50h	; 'P'
		jl	short loc_160C7
		mov	[bp+var_A], si
		add	[bp+var_16], 50h ; 'P'
		add	[bp+var_10], 0A0h ; '�'
		inc	[bp+var_C]
		cmp	[bp+var_C], 17h
		jl	short loc_160B3
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_16078	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_16114	proc far		; CODE XREF: sub_10828+1E0P
					; sub_10828+1F1P ...

var_A		= word ptr -0Ah
var_8		= word ptr -8
var_6		= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2

		push	bp
		mov	bp, sp
		sub	sp, 0Ah
		push	di
		push	si
		mov	bx, ds:29DCh
		shl	bx, 1
		shl	bx, 1
		mov	dx, [bx+244Ch]
		sub	ax, ax
		mov	[bp+var_4], ax
		mov	[bp+var_2], dx
		sub	di, di
		mov	[bp+var_A], ax

loc_16135:				; CODE XREF: sub_16114+64j
		sub	si, si
		mov	bx, [bp+var_A]
		add	bx, [bp+var_4]
		mov	es, [bp+var_2]
		sub	ax, ax
		mov	cx, 14h
		push	di
		mov	di, bx
		repne stosw
		pop	di

loc_1614B:				; CODE XREF: sub_16114+57j
		mov	ax, [bp+var_A]
		add	ax, si
		push	ax
		mov	bx, ds:29C8h
		shl	bx, 1
		shl	bx, 1
		push	word ptr [bx+244Ch]
		push	di
		push	si
		call	sub_293D2
		add	sp, 8
		inc	si
		cmp	si, 28h	; '('
		jl	short loc_1614B
		mov	[bp+var_6], si
		add	[bp+var_A], 28h	; '('
		inc	di
		cmp	di, 32h	; '2'
		jl	short loc_16135
		mov	[bp+var_8], di
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_16114	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_16184	proc far		; CODE XREF: sub_126E4+7FP

var_1A		= dword	ptr -1Ah
var_16		= word ptr -16h
var_14		= dword	ptr -14h
var_10		= word ptr -10h
var_C		= word ptr -0Ch
var_A		= word ptr -0Ah
var_8		= word ptr -8
var_6		= word ptr -6
var_4		= dword	ptr -4

		push	bp
		mov	bp, sp
		sub	sp, 1Ah
		push	di
		push	si
		mov	bx, ds:29DAh
		shl	bx, 1
		shl	bx, 1
		mov	dx, [bx+244Ch]
		sub	ax, ax
		mov	[bp+var_8], ax
		mov	[bp+var_6], dx
		add	[bp+var_8], 2
		mov	bx, ds:29DCh
		shl	bx, 1
		shl	bx, 1
		mov	dx, [bx+244Ch]
		mov	word ptr [bp+var_4], ax
		mov	word ptr [bp+var_4+2], dx
		cmp	ds:2210h, ax
		jnz	short loc_16230
		mov	[bp+var_C], ax
		mov	[bp+var_16], ax
		mov	[bp+var_10], ax

loc_161C5:				; CODE XREF: sub_16184+A9j
		sub	si, si
		mov	di, [bp+var_16]
		mov	ax, [bp+var_10]
		add	ax, [bp+var_8]
		mov	dx, [bp+var_6]
		mov	word ptr [bp+var_14], ax
		mov	word ptr [bp+var_14+2],	dx

loc_161D9:				; CODE XREF: sub_16184+92j
		les	bx, [bp+var_4]
		add	bx, di
		mov	al, es:[bx+si]
		and	al, 1
		cmp	al, 1
		jnz	short loc_1620E
		les	bx, [bp+var_14]
		push	word ptr es:[bx]
		mov	bx, ds:29C8h
		shl	bx, 1
		shl	bx, 1
		push	word ptr [bx+244Ch]
		push	[bp+var_C]
		push	si
		call	sub_27C36
		add	sp, 8
		les	bx, [bp+var_4]
		add	bx, di
		and	byte ptr es:[bx+si], 10h

loc_1620E:				; CODE XREF: sub_16184+61j
		add	word ptr [bp+var_14], 2
		inc	si
		cmp	si, 50h	; 'P'
		jl	short loc_161D9
		mov	[bp+var_A], si
		add	[bp+var_16], 50h ; 'P'
		add	[bp+var_10], 0A0h ; '�'
		inc	[bp+var_C]
		cmp	[bp+var_C], 17h
		jge	short loc_162A7
		jmp	short loc_161C5
; ---------------------------------------------------------------------------
		align 2

loc_16230:				; CODE XREF: sub_16184+36j
		mov	[bp+var_C], 0
		mov	[bp+var_10], 0
		mov	word ptr [bp+var_14], 0

loc_1623F:				; CODE XREF: sub_16184+121j
		sub	si, si
		mov	di, [bp+var_10]
		mov	ax, word ptr [bp+var_14]
		add	ax, [bp+var_8]
		mov	dx, [bp+var_6]
		mov	word ptr [bp+var_1A], ax
		mov	word ptr [bp+var_1A+2],	dx

loc_16253:				; CODE XREF: sub_16184+10Cj
		les	bx, [bp+var_4]
		add	bx, di
		mov	al, es:[bx+si]
		and	al, 10h
		cmp	al, 10h
		jnz	short loc_16288
		les	bx, [bp+var_1A]
		push	word ptr es:[bx]
		mov	bx, ds:29C8h
		shl	bx, 1
		shl	bx, 1
		push	word ptr [bx+244Ch]
		push	[bp+var_C]
		push	si
		call	sub_27C36
		add	sp, 8
		les	bx, [bp+var_4]
		add	bx, di
		and	byte ptr es:[bx+si], 1

loc_16288:				; CODE XREF: sub_16184+DBj
		add	word ptr [bp+var_1A], 2
		inc	si
		cmp	si, 50h	; 'P'
		jl	short loc_16253
		mov	[bp+var_A], si
		add	[bp+var_10], 50h ; 'P'
		add	word ptr [bp+var_14], 0A0h ; '�'
		inc	[bp+var_C]
		cmp	[bp+var_C], 17h
		jl	short loc_1623F

loc_162A7:				; CODE XREF: sub_16184+A7j
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_16184	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_162AE	proc far		; CODE XREF: sub_10828+614P
					; sub_10F06+1FAP ...

var_C		= word ptr -0Ch
var_A		= word ptr -0Ah
var_8		= word ptr -8
var_6		= word ptr -6
var_4		= dword	ptr -4

		push	bp
		mov	bp, sp
		sub	sp, 0Ch
		push	di
		push	si
		mov	bx, ds:29DCh
		shl	bx, 1
		shl	bx, 1
		mov	dx, [bx+244Ch]
		sub	ax, ax
		mov	word ptr [bp+var_4], ax
		mov	word ptr [bp+var_4+2], dx
		cmp	ds:2210h, ax
		jnz	short loc_1632A
		mov	[bp+var_8], ax
		mov	[bp+var_A], ax

loc_162D6:				; CODE XREF: sub_162AE+7Aj
		sub	si, si
		mov	di, [bp+var_C]

loc_162DB:				; CODE XREF: sub_162AE+68j
		mov	bx, [bp+var_A]
		add	bx, word ptr [bp+var_4]
		mov	es, word ptr [bp+var_4+2]
		mov	al, es:[bx+si]
		and	al, 1
		cmp	al, 1
		jnz	short loc_16312
		mov	di, [bp+var_A]
		add	di, si
		push	di
		mov	bx, ds:29C8h
		shl	bx, 1
		shl	bx, 1
		push	word ptr [bx+244Ch]
		push	[bp+var_8]
		push	si
		call	sub_293D2
		add	sp, 8
		les	bx, [bp+var_4]
		and	byte ptr es:[bx+di], 10h

loc_16312:				; CODE XREF: sub_162AE+3Dj
		inc	si
		cmp	si, 28h	; '('
		jl	short loc_162DB
		mov	[bp+var_6], si
		add	[bp+var_A], 28h	; '('
		inc	[bp+var_8]
		cmp	[bp+var_8], 32h	; '2'
		jge	short loc_16386
		jmp	short loc_162D6
; ---------------------------------------------------------------------------

loc_1632A:				; CODE XREF: sub_162AE+20j
		mov	[bp+var_8], 0
		mov	[bp+var_C], 0

loc_16334:				; CODE XREF: sub_162AE+D6j
		sub	si, si
		mov	di, [bp+var_A]

loc_16339:				; CODE XREF: sub_162AE+C6j
		mov	bx, [bp+var_C]
		add	bx, word ptr [bp+var_4]
		mov	es, word ptr [bp+var_4+2]
		mov	al, es:[bx+si]
		and	al, 10h
		cmp	al, 10h
		jnz	short loc_16370
		mov	di, [bp+var_C]
		add	di, si
		push	di
		mov	bx, ds:29C8h
		shl	bx, 1
		shl	bx, 1
		push	word ptr [bx+244Ch]
		push	[bp+var_8]
		push	si
		call	sub_293D2
		add	sp, 8
		les	bx, [bp+var_4]
		and	byte ptr es:[bx+di], 1

loc_16370:				; CODE XREF: sub_162AE+9Bj
		inc	si
		cmp	si, 28h	; '('
		jl	short loc_16339
		mov	[bp+var_6], si
		add	[bp+var_C], 28h	; '('
		inc	[bp+var_8]
		cmp	[bp+var_8], 32h	; '2'
		jl	short loc_16334

loc_16386:				; CODE XREF: sub_162AE+78j
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_162AE	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1638C	proc far		; CODE XREF: LoadHEM_A1+3Dp

var_32		= word ptr -32h
var_2E		= word ptr -2Eh
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
var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6
arg_2		= word ptr  8
arg_4		= word ptr  0Ah

		push	bp
		mov	bp, sp
		sub	sp, 32h
		push	di
		push	si
		mov	ax, [bp+arg_0]
		mov	[bp+var_A], ax
		mov	[bp+var_14], 0
		cmp	[bp+arg_2], 0
		jg	short loc_163A8
		jmp	loc_16555
; ---------------------------------------------------------------------------

loc_163A8:				; CODE XREF: sub_1638C+17j
		mov	[bp+var_C], 8
		mov	dx, ax
		sub	ax, ax
		mov	[bp+var_2A], ax
		mov	[bp+var_28], dx

loc_163B7:				; CODE XREF: sub_1638C+1C6j
		mov	ax, [bp+var_14]
		cwd
		mov	cx, 28h	; '('
		idiv	cx
		mov	[bp+var_10], dx
		mov	ax, [bp+var_14]
		cwd
		idiv	cx
		mov	[bp+var_12], ax
		mov	ax, [bp+var_A]
		add	ax, 4
		mov	dx, ax
		sub	ax, ax
		mov	[bp+var_1A], ax
		mov	[bp+var_18], dx
		mov	ax, [bp+var_A]
		add	ax, 3
		mov	dx, ax
		sub	ax, ax
		mov	[bp+var_1E], ax
		mov	[bp+var_1C], dx
		mov	ax, [bp+var_A]
		add	ax, 2
		mov	dx, ax
		sub	ax, ax
		mov	[bp+var_22], ax
		mov	[bp+var_20], dx
		mov	ax, [bp+var_A]
		inc	ax
		mov	dx, ax
		sub	ax, ax
		mov	[bp+var_26], ax
		mov	[bp+var_24], dx
		mov	ax, 280h
		imul	[bp+var_12]
		mov	cx, [bp+var_10]
		shl	cx, 1
		add	ax, cx
		mov	[bp+var_2C], ax
		mov	[bp+var_2E], ax
		sub	si, si
		mov	cx, [bp+var_2]

loc_16422:				; CODE XREF: sub_1638C+1A6j
		mov	ax, [bp+var_2E]
		cwd
		or	dh, 0A8h
		mov	es, dx
		mov	bx, ax
		mov	ax, es:[bx]
		mov	[bp+var_6], ax
		mov	ax, bx
		cwd
		or	dh, 0B0h
		mov	es, dx
		mov	ax, es:[bx]
		mov	[bp+var_4], ax
		mov	ax, bx
		cwd
		or	dh, 0B8h
		mov	es, dx
		mov	ax, es:[bx]
		mov	[bp+var_E], ax
		mov	ax, bx
		cwd
		or	dh, 0E0h
		mov	es, dx
		mov	di, es:[bx]
		cmp	[bp+arg_4], 1
		jnz	short loc_164AB
		mov	cx, [bp+var_E]
		xor	cx, 0FFFFh
		mov	ax, [bp+var_4]
		xor	ax, 0FFFFh
		and	cx, ax
		and	cx, [bp+var_6]
		and	cx, di
		or	di, cx
		mov	ax, cx
		xor	ax, 0FFFFh
		and	[bp+var_E], ax
		or	[bp+var_4], cx
		or	[bp+var_6], cx
		mov	cx, [bp+var_E]
		xor	cx, 0FFFFh
		mov	ax, [bp+var_6]
		xor	ax, 0FFFFh
		and	cx, ax
		and	cx, [bp+var_4]
		and	cx, di
		or	di, cx
		or	[bp+var_E], cx
		mov	ax, cx
		xor	ax, 0FFFFh
		mov	[bp+var_32], ax
		and	[bp+var_4], ax
		and	[bp+var_6], ax

loc_164AB:				; CODE XREF: sub_1638C+D2j
		mov	ax, [bp+var_6]
		and	ax, [bp+var_4]
		and	ax, [bp+var_E]
		and	ax, di
		xor	ax, 0FFFFh
		mov	[bp+var_16], ax
		mov	ax, si
		cwd
		or	ax, [bp+var_2A]
		or	dx, [bp+var_28]
		mov	es, dx
		mov	bx, ax
		mov	ax, [bp+var_16]
		mov	es:[bx], ax
		mov	ax, si
		cwd
		or	ax, [bp+var_26]
		or	dx, [bp+var_24]
		mov	es, dx
		mov	bx, ax
		mov	ax, [bp+var_6]
		and	ax, [bp+var_16]
		mov	es:[bx], ax
		mov	ax, si
		cwd
		or	ax, [bp+var_22]
		or	dx, [bp+var_20]
		mov	es, dx
		mov	bx, ax
		mov	ax, [bp+var_4]
		and	ax, [bp+var_16]
		mov	es:[bx], ax
		mov	ax, si
		cwd
		or	ax, [bp+var_1E]
		or	dx, [bp+var_1C]
		mov	es, dx
		mov	bx, ax
		mov	ax, [bp+var_E]
		and	ax, [bp+var_16]
		mov	es:[bx], ax
		mov	ax, si
		cwd
		or	ax, [bp+var_1A]
		or	dx, [bp+var_18]
		mov	es, dx
		mov	bx, ax
		mov	ax, [bp+var_16]
		and	ax, di
		mov	es:[bx], ax
		add	[bp+var_2E], 50h ; 'P'
		add	si, 2
		cmp	si, 10h
		jge	short loc_16535
		jmp	loc_16422
; ---------------------------------------------------------------------------

loc_16535:				; CODE XREF: sub_1638C+1A4j
		mov	[bp+var_8], di
		mov	[bp+var_2], cx
		add	[bp+var_2A], 0
		adc	[bp+var_28], 5
		add	[bp+var_A], 5
		inc	[bp+var_14]
		mov	ax, [bp+arg_2]
		cmp	[bp+var_14], ax
		jge	short loc_16555
		jmp	loc_163B7
; ---------------------------------------------------------------------------

loc_16555:				; CODE XREF: sub_1638C+19j
					; sub_1638C+1C4j
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_1638C	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1655C	proc far		; CODE XREF: sub_10828+1CDP
					; sub_10F06+D4P ...

var_28		= word ptr -28h
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
var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6
arg_2		= word ptr  8

		push	bp
		mov	bp, sp
		sub	sp, 28h
		push	di
		push	si
		mov	ax, [bp+arg_0]
		mov	[bp+var_8], ax
		mov	[bp+var_12], 0
		cmp	[bp+arg_2], 0
		jg	short loc_16578
		jmp	loc_1668E
; ---------------------------------------------------------------------------

loc_16578:				; CODE XREF: sub_1655C+17j
		mov	[bp+var_28], 0
		mov	[bp+var_A], 8
		mov	dx, ax
		sub	ax, ax
		mov	[bp+var_22], ax
		mov	[bp+var_20], dx

loc_1658C:				; CODE XREF: sub_1655C+12Fj
		mov	ax, [bp+var_12]
		cwd
		mov	cx, 28h	; '('
		idiv	cx
		mov	[bp+var_E], dx
		mov	ax, [bp+var_12]
		cwd
		idiv	cx
		mov	[bp+var_10], ax
		mov	ax, [bp+var_8]
		add	ax, 3
		mov	dx, ax
		sub	ax, ax
		mov	[bp+var_16], ax
		mov	[bp+var_14], dx
		mov	ax, [bp+var_8]
		add	ax, 2
		mov	dx, ax
		sub	ax, ax
		mov	[bp+var_1A], ax
		mov	[bp+var_18], dx
		mov	ax, [bp+var_8]
		inc	ax
		mov	dx, ax
		sub	ax, ax
		mov	[bp+var_1E], ax
		mov	[bp+var_1C], dx
		mov	ax, 280h
		imul	[bp+var_10]
		mov	cx, [bp+var_E]
		shl	cx, 1
		add	ax, cx
		mov	[bp+var_24], ax
		mov	si, ax
		sub	cx, cx

loc_165E3:				; CODE XREF: sub_1655C+112j
		mov	ax, si
		cwd
		or	dh, 0A8h
		mov	es, dx
		mov	bx, ax
		mov	ax, es:[bx]
		mov	[bp+var_4], ax
		mov	ax, si
		cwd
		or	dh, 0B0h
		mov	es, dx
		mov	ax, es:[bx]
		mov	[bp+var_2], ax
		mov	ax, si
		cwd
		or	dh, 0B8h
		mov	es, dx
		mov	ax, es:[bx]
		mov	[bp+var_C], ax
		mov	ax, si
		cwd
		or	dh, 0E0h
		mov	es, dx
		mov	di, es:[bx]
		mov	ax, cx
		cwd
		or	ax, [bp+var_22]
		or	dx, [bp+var_20]
		mov	es, dx
		mov	bx, ax
		mov	ax, [bp+var_4]
		mov	es:[bx], ax
		mov	ax, cx
		cwd
		or	ax, [bp+var_1E]
		or	dx, [bp+var_1C]
		mov	es, dx
		mov	bx, ax
		mov	ax, [bp+var_2]
		mov	es:[bx], ax
		mov	ax, cx
		cwd
		or	ax, [bp+var_1A]
		or	dx, [bp+var_18]
		mov	es, dx
		mov	bx, ax
		mov	ax, [bp+var_C]
		mov	es:[bx], ax
		mov	ax, cx
		cwd
		or	ax, [bp+var_16]
		or	dx, [bp+var_14]
		mov	es, dx
		mov	bx, ax
		mov	es:[bx], di
		add	si, 50h	; 'P'
		add	cx, 2
		cmp	cx, 10h
		jge	short loc_16671
		jmp	loc_165E3
; ---------------------------------------------------------------------------

loc_16671:				; CODE XREF: sub_1655C+110j
		mov	[bp+var_6], di
		add	[bp+var_22], 0
		adc	[bp+var_20], 4
		add	[bp+var_8], 4
		inc	[bp+var_12]
		mov	ax, [bp+arg_2]
		cmp	[bp+var_12], ax
		jge	short loc_1668E
		jmp	loc_1658C
; ---------------------------------------------------------------------------

loc_1668E:				; CODE XREF: sub_1655C+19j
					; sub_1655C+12Dj
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_1655C	endp

		assume ds:seg026

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

LoadHNY		proc far		; CODE XREF: sub_106F0+90P
					; sub_10828+E4P ...

var_4A		= word ptr -4Ah
var_48		= word ptr -48h
var_46		= word ptr -46h
var_44		= word ptr -44h
var_42		= word ptr -42h
var_40		= byte ptr -40h
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 4Ah
		push	di
		push	si
		push	[bp+arg_0]
		mov	ax, offset a_hny ; ".hny"
		push	ax
		lea	ax, [bp+var_40]
		push	ax
		call	strcat
		add	sp, 6
		lea	ax, [bp+var_40]
		push	ax
		call	MaybeLoadFile
		add	sp, 2
		mov	[bp+var_44], ax
		push	ax
		call	sub_15496
		add	sp, 2
		mov	[bp+var_46], ax
		shl	ax, 1
		shl	ax, 1
		add	ax, offset word_2CE1C
		mov	[bp+var_4A], ax
		mov	bx, ax
		push	word ptr [bx]
		lea	ax, [bp+var_40]
		push	ax
		call	sub_29694
		add	sp, 4
		call	sub_26363
		mov	ax, 0A800h
		push	ax
		mov	bx, [bp+var_4A]
		push	word ptr [bx]
		call	sub_2A177
		add	sp, 4
		mov	[bp+var_44], ax
		push	[bp+var_46]
		call	sub_154E4
		add	sp, 2
		push	[bp+var_44]
		call	sub_15496
		add	sp, 2
		mov	[bp+var_46], ax
		mov	[bp+var_42], 0
		cmp	[bp+var_44], 0
		jle	short loc_1675D
		shl	ax, 1
		shl	ax, 1
		add	ax, offset word_2CE1C
		mov	[bp+var_48], ax

loc_1672B:
		mov	di, [bp+var_44]
		mov	si, [bp+var_42]

loc_16731:				; CODE XREF: LoadHNY+C4j
		mov	ax, 10h
		push	ax
		mov	ax, si
		add	ah, 0A8h ; '�'
		mov	dx, ax
		sub	ax, ax
		push	dx
		push	ax
		mov	bx, [bp+var_48]
		mov	ax, [bx]
		add	ax, si
		mov	dx, ax
		sub	ax, ax
		push	dx
		push	ax
		call	sub_153EC
		add	sp, 0Ah
		inc	si
		cmp	si, di
		jl	short loc_16731
		mov	[bp+var_42], si

loc_1675D:				; CODE XREF: LoadHNY+8Bj
		mov	ax, [bp+var_46]
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
LoadHNY		endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

LoadTBR		proc far		; CODE XREF: sub_11462+575P

var_44		= word ptr -44h
var_42		= word ptr -42h
var_40		= byte ptr -40h
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 44h
		push	si
		push	[bp+arg_0]
		mov	ax, offset a_tbr ; ".tbr"
		push	ax
		lea	ax, [bp+var_40]
		push	ax
		call	strcat
		add	sp, 6
		lea	ax, [bp+var_40]
		push	ax
		call	MaybeLoadFile
		add	sp, 2
		mov	[bp+var_42], ax
		push	ax
		call	sub_15496
		add	sp, 2
		mov	[bp+var_44], ax
		mov	si, ax
		mov	cl, 2
		shl	si, cl
		add	si, offset word_2CE1C
		push	word ptr [si]
		lea	ax, [bp+var_40]
		push	ax
		call	sub_29694
		add	sp, 4
		mov	ax, [bp+var_42]
		mov	cl, 4
		shl	ax, cl
		push	ax
		sub	ax, ax
		push	ax
		push	word ptr [si]
		mov	ax, 11h
		push	ax
		call	sub_2971C
		add	sp, 8
		push	[bp+var_44]
		call	sub_154E4
		add	sp, 2
		mov	ax, [bp+var_44]
		pop	si
		mov	sp, bp
		pop	bp
		retf
LoadTBR		endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

LoadHT2		proc far		; CODE XREF: sub_106F0+7DP

var_44		= word ptr -44h
var_42		= word ptr -42h
var_40		= byte ptr -40h
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 44h
		push	[bp+arg_0]
		mov	ax, offset a_ht2 ; ".ht2"
		push	ax
		lea	ax, [bp+var_40]
		push	ax
		call	strcat
		add	sp, 6
		lea	ax, [bp+var_40]
		push	ax
		call	MaybeLoadFile
		add	sp, 2
		mov	[bp+var_42], ax
		push	ax
		call	sub_15496
		add	sp, 2
		mov	[bp+var_44], ax
		mov	bx, ax
		shl	bx, 1
		shl	bx, 1
		push	word_2CE1C[bx]
		lea	ax, [bp+var_40]
		push	ax
		call	sub_29694
		mov	ax, [bp+var_44]
		mov	sp, bp
		pop	bp
		retf
LoadHT2		endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

LoadSP2		proc far		; CODE XREF: sub_106F0+A3P
					; sub_10828+F3P ...

var_44		= word ptr -44h
var_42		= word ptr -42h
var_40		= byte ptr -40h
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 44h
		push	[bp+arg_0]
		mov	ax, offset a_sp2 ; ".sp2"
		push	ax
		lea	ax, [bp+var_40]
		push	ax
		call	strcat
		add	sp, 6
		lea	ax, [bp+var_40]
		push	ax
		call	MaybeLoadFile
		add	sp, 2
		mov	[bp+var_42], ax
		push	ax
		call	sub_15496
		add	sp, 2
		mov	[bp+var_44], ax
		mov	bx, ax
		shl	bx, 1
		shl	bx, 1
		push	word_2CE1C[bx]
		lea	ax, [bp+var_40]
		push	ax
		call	sub_29694
		mov	ax, [bp+var_44]
		mov	sp, bp
		pop	bp
		retf
LoadSP2		endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

LoadHEM_1	proc far		; CODE XREF: sub_11A04+D6P
					; DoClearScr_A1+5EP ...

var_4A		= word ptr -4Ah
var_48		= word ptr -48h
var_46		= word ptr -46h
var_44		= word ptr -44h
var_42		= word ptr -42h
var_40		= byte ptr -40h
arg_0		= word ptr  6
arg_2		= word ptr  8
arg_4		= word ptr  0Ah
arg_6		= word ptr  0Ch

		push	bp
		mov	bp, sp
		sub	sp, 4Ah
		push	di
		push	si
		push	[bp+arg_0]
		mov	ax, offset a_hem_1 ; ".hem"
		push	ax
		lea	ax, [bp+var_40]
		push	ax
		call	strcat
		add	sp, 6
		lea	ax, [bp+var_40]
		push	ax
		call	MaybeLoadFile
		add	sp, 2
		mov	[bp+var_44], ax
		push	ax
		call	sub_15496
		add	sp, 2
		mov	[bp+var_46], ax
		shl	ax, 1
		shl	ax, 1
		add	ax, offset word_2CE1C
		mov	[bp+var_4A], ax
		mov	bx, ax
		push	word ptr [bx]
		lea	ax, [bp+var_40]
		push	ax
		call	sub_29694
		add	sp, 4
		call	sub_26363
		mov	ax, 0A800h
		push	ax
		mov	bx, [bp+var_4A]
		push	word ptr [bx]
		call	sub_2A177
		add	sp, 4
		mov	[bp+var_44], ax
		push	[bp+var_46]
		call	sub_154E4
		add	sp, 2
		push	[bp+var_44]
		call	sub_15496
		add	sp, 2
		mov	[bp+var_46], ax
		mov	[bp+var_42], 0
		cmp	[bp+var_44], 0
		jle	short loc_16945
		shl	ax, 1
		shl	ax, 1
		add	ax, offset word_2CE1C
		mov	[bp+var_48], ax
		mov	di, [bp+var_44]
		mov	si, [bp+var_42]

loc_16919:				; CODE XREF: LoadHEM_1+C4j
		mov	ax, 10h
		push	ax
		mov	ax, si
		add	ah, 0A8h ; '�'
		mov	dx, ax
		sub	ax, ax
		push	dx
		push	ax
		mov	bx, [bp+var_48]
		mov	ax, [bx]
		add	ax, si
		mov	dx, ax
		sub	ax, ax
		push	dx
		push	ax
		call	sub_153EC
		add	sp, 0Ah
		inc	si
		cmp	si, di
		jl	short loc_16919
		mov	[bp+var_42], si

loc_16945:				; CODE XREF: LoadHEM_1+8Bj
		mov	si, [bp+var_46]
		mov	cl, 2
		shl	si, cl
		add	si, offset word_2CE1C
		mov	ax, 294Ch
		push	ax
		sub	ax, ax
		push	ax
		push	word ptr [si]
		call	sub_255B5
		add	sp, 6
		push	[bp+arg_6]
		push	word ptr [si]
		push	[bp+arg_4]
		push	[bp+arg_2]
		call	sub_25666
		add	sp, 8
		push	[bp+var_46]
		call	sub_154E4
		add	sp, 2
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
LoadHEM_1	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

LoadHEM_2	proc far		; CODE XREF: sub_1507C+EAP

var_4E		= word ptr -4Eh
var_4C		= word ptr -4Ch
var_48		= word ptr -48h
var_46		= word ptr -46h
var_44		= word ptr -44h
var_42		= byte ptr -42h
var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 4Eh
		push	di
		push	si
		mov	[bp+var_2], 1
		push	[bp+arg_0]
		mov	ax, offset a_hem_0 ; ".hem"
		push	ax
		lea	ax, [bp+var_42]
		push	ax
		call	strcat
		add	sp, 6
		lea	ax, [bp+var_42]
		push	ax
		call	MaybeLoadFile
		add	sp, 2
		mov	[bp+var_46], ax
		push	ax
		call	sub_15496
		add	sp, 2
		mov	[bp+var_48], ax
		shl	ax, 1
		shl	ax, 1
		add	ax, offset word_2CE1C
		mov	[bp+var_4E], ax
		mov	bx, ax
		push	word ptr [bx]
		lea	ax, [bp+var_42]
		push	ax
		call	sub_29694
		add	sp, 4
		call	sub_26363
		mov	ax, 0A800h
		push	ax
		mov	bx, [bp+var_4E]
		push	word ptr [bx]
		call	sub_2A177
		add	sp, 4
		mov	[bp+var_46], ax
		push	[bp+var_48]
		call	sub_154E4
		add	sp, 2
		push	[bp+var_46]
		call	sub_15496
		add	sp, 2
		mov	[bp+var_48], ax
		mov	[bp+var_44], 0
		cmp	[bp+var_46], 0
		jle	short loc_16A54
		shl	ax, 1
		shl	ax, 1
		add	ax, offset word_2CE1C
		mov	[bp+var_4C], ax
		mov	di, [bp+var_46]
		mov	si, [bp+var_44]

loc_16A28:				; CODE XREF: LoadHEM_2+C9j
		mov	ax, 10h
		push	ax
		mov	ax, si
		add	ah, 0A8h ; '�'
		mov	dx, ax
		sub	ax, ax
		push	dx
		push	ax
		mov	bx, [bp+var_4C]
		mov	ax, [bx]
		add	ax, si
		mov	dx, ax
		sub	ax, ax
		push	dx
		push	ax
		call	sub_153EC
		add	sp, 0Ah
		inc	si
		cmp	si, di
		jl	short loc_16A28
		mov	[bp+var_44], si

loc_16A54:				; CODE XREF: LoadHEM_2+90j
		cmp	[bp+var_2], 0
		jz	short loc_16A92
		mov	di, [bp+var_48]
		mov	cl, 2
		shl	di, cl
		add	di, offset word_2CE1C

loc_16A65:				; CODE XREF: LoadHEM_2+107j
		push	4Ah ; 'J'
		nop
		push	word ptr [di]
		call	sub_2A68B
		add	sp, 4
		mov	si, ax
		or	si, si
		jz	short loc_16A8B
		sub	ax, ax
		push	ax
		mov	ax, 0FFFFh
		push	ax
		mov	ax, 1
		push	ax
		call	sub_29F6B
		add	sp, 6

loc_16A8B:				; CODE XREF: LoadHEM_2+F0j
		or	si, si
		jnz	short loc_16A65
		mov	[bp+var_2], si

loc_16A92:				; CODE XREF: LoadHEM_2+D2j
		push	[bp+var_48]
		call	sub_154E4
		add	sp, 2
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
LoadHEM_2	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

LoadGEM		proc far		; CODE XREF: sub_10828+1A6P
					; sub_10F06+ADP ...

var_44		= word ptr -44h
var_42		= word ptr -42h
var_40		= byte ptr -40h
arg_0		= word ptr  6
arg_2		= word ptr  8
arg_4		= word ptr  0Ah
arg_6		= word ptr  0Ch

		push	bp
		mov	bp, sp
		sub	sp, 44h
		push	si
		push	[bp+arg_0]
		mov	ax, offset a_gem ; ".gem"
		push	ax
		lea	ax, [bp+var_40]
		push	ax
		call	strcat
		add	sp, 6
		lea	ax, [bp+var_40]
		push	ax
		call	MaybeLoadFile
		add	sp, 2
		mov	[bp+var_42], ax
		push	ax
		call	sub_15496
		add	sp, 2
		mov	[bp+var_44], ax
		mov	si, ax
		mov	cl, 2
		shl	si, cl
		add	si, offset word_2CE1C
		push	word ptr [si]
		lea	ax, [bp+var_40]
		push	ax
		call	sub_29694
		add	sp, 4
		mov	ax, offset byte_2D31C
		push	ax
		sub	ax, ax
		push	ax
		push	word ptr [si]
		call	sub_255B5
		add	sp, 6
		push	[bp+arg_6]
		push	word ptr [si]
		push	[bp+arg_4]
		push	[bp+arg_2]
		call	sub_25666
		add	sp, 8
		push	[bp+var_44]
		call	sub_154E4
		add	sp, 2
		pop	si
		mov	sp, bp
		pop	bp
		retf
LoadGEM		endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

LoadHEM_A1	proc far		; CODE XREF: sub_106F0+DAP
					; sub_10828+118P ...

var_2		= word ptr -2
arg_0		= word ptr  6
arg_2		= word ptr  8
arg_4		= word ptr  0Ah

		push	bp
		mov	bp, sp
		sub	sp, 2
		sub	ax, ax
		push	ax
		push	ax
		push	ax
		push	[bp+arg_0]
		push	cs
		call	near ptr LoadHEM_1
		add	sp, 8
		mov	ax, [bp+arg_2]
		mov	cx, ax
		shl	ax, 1
		shl	ax, 1
		add	ax, cx
		push	ax
		call	sub_15496
		add	sp, 2
		mov	[bp+var_2], ax
		push	[bp+arg_4]
		push	[bp+arg_2]
		mov	bx, ax
		shl	bx, 1
		shl	bx, 1
		push	word_2CE1C[bx]
		push	cs
		call	near ptr sub_1638C
		mov	ax, [bp+var_2]
		mov	sp, bp
		pop	bp
		retf
LoadHEM_A1	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

LoadMP2		proc far		; CODE XREF: sub_124FA+E5P

var_44		= word ptr -44h
var_42		= word ptr -42h
var_40		= byte ptr -40h
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 44h
		push	[bp+arg_0]
		mov	ax, offset a_mp2 ; ".mp2"
		push	ax
		lea	ax, [bp+var_40]
		push	ax
		call	strcat
		add	sp, 6
		lea	ax, [bp+var_40]
		push	ax
		call	MaybeLoadFile
		add	sp, 2
		mov	[bp+var_42], ax
		push	ax
		call	sub_15496
		add	sp, 2
		mov	[bp+var_44], ax
		mov	bx, ax
		shl	bx, 1
		shl	bx, 1
		push	word_2CE1C[bx]
		lea	ax, [bp+var_40]
		push	ax
		call	sub_29694
		mov	ax, [bp+var_44]
		mov	sp, bp
		pop	bp
		retf
LoadMP2		endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

LoadHEM_A2	proc far		; CODE XREF: sub_124FA+10DP

var_44		= word ptr -44h
arg_0		= word ptr  6
arg_2		= word ptr  8

		push	bp
		mov	bp, sp
		sub	sp, 44h
		sub	ax, ax
		push	ax
		push	ax
		push	ax
		push	[bp+arg_0]
		push	cs
		call	near ptr LoadHEM_1
		add	sp, 8
		mov	ax, [bp+arg_2]
		shl	ax, 1
		shl	ax, 1
		push	ax
		call	sub_15496
		add	sp, 2
		mov	[bp+var_44], ax
		push	[bp+arg_2]
		mov	bx, ax
		shl	bx, 1
		shl	bx, 1
		push	word_2CE1C[bx]
		push	cs
		call	near ptr sub_1655C
		mov	ax, [bp+var_44]
		mov	sp, bp
		pop	bp
		retf
LoadHEM_A2	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_16BFC	proc far		; CODE XREF: sub_10286+6EP
					; sub_10286+91P ...

arg_0		= word ptr  6
arg_2		= word ptr  8
arg_4		= word ptr  0Ah
arg_6		= word ptr  0Ch
arg_8		= word ptr  0Eh
arg_A		= word ptr  10h
arg_C		= word ptr  12h

		push	bp
		mov	bp, sp
		push	si
		mov	ax, word_2D396
		mov	cx, ax
		shl	ax, 1
		add	ax, cx
		shl	ax, 1
		add	ax, cx
		shl	ax, 1
		mov	si, ax
		mov	ax, [bp+arg_4]
		mov	[si+2666h], ax
		mov	ax, [bp+arg_6]
		mov	[si+2664h], ax
		mov	ax, [bp+arg_8]
		mov	[si+2668h], ax
		mov	ax, [bp+arg_0]
		mov	[si+266Ah], ax
		mov	ax, [bp+arg_2]
		mov	[si+266Ch], ax
		mov	ax, [bp+arg_A]
		mov	[si+266Eh], ax
		mov	ax, [bp+arg_C]
		mov	[si+2670h], ax
		inc	word_2D396
		pop	si
		pop	bp
		retf
sub_16BFC	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_16C4A	proc far		; CODE XREF: sub_1507C+141P
		call	sub_26363
		mov	word_2D396, 0
		retf
sub_16C4A	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_16C56	proc far		; CODE XREF: sub_11230:loc_11312P
					; sub_11230:loc_113AAP	...

var_1A		= word ptr -1Ah
var_18		= word ptr -18h
var_16		= word ptr -16h
var_14		= word ptr -14h
var_E		= word ptr -0Eh
var_A		= word ptr -0Ah
var_8		= word ptr -8
var_6		= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2

		push	bp
		mov	bp, sp
		sub	sp, 1Ah
		push	di
		push	si
		call	sub_26363
		mov	bx, word_2D3AC
		shl	bx, 1
		shl	bx, 1
		mov	ax, [bx+244Ch]
		mov	[bp+var_E], ax
		mov	[bp+var_8], 0
		cmp	word_2D396, 0
		jg	short loc_16C81
		jmp	loc_16D21
; ---------------------------------------------------------------------------

loc_16C81:				; CODE XREF: sub_16C56+26j
		mov	si, 2664h
		mov	di, 2666h
		mov	[bp+var_14], 2668h
		mov	[bp+var_16], 266Eh
		mov	[bp+var_18], 266Ch
		mov	[bp+var_1A], 266Ah

loc_16C9B:				; CODE XREF: sub_16C56+C8j
		mov	bx, [si]
		shl	bx, 1
		mov	bx, [bx+29C8h]
		shl	bx, 1
		shl	bx, 1
		mov	dx, [bx+244Ch]
		sub	ax, ax
		mov	[bp+var_6], ax
		mov	[bp+var_4], dx
		mov	bx, [di]
		shl	bx, 1
		mov	bx, [bx+29C8h]
		shl	bx, 1
		shl	bx, 1
		mov	ax, [bx+244Ch]
		mov	[bp+var_A], ax
		mov	bx, [bp+var_14]
		mov	bx, [bx]
		shl	bx, 1
		add	bx, [bp+var_6]
		mov	es, dx
		mov	ax, es:[bx+2]
		mov	[bp+var_2], ax
		add	[bp+var_6], ax
		push	[bp+var_E]
		push	[bp+var_A]
		mov	bx, [bp+var_16]
		push	word ptr [bx]
		push	dx
		push	[bp+var_6]
		mov	bx, [bp+var_18]
		push	word ptr [bx]
		mov	bx, [bp+var_1A]
		push	word ptr [bx]
		call	sub_26436
		add	sp, 0Eh
		add	si, 0Eh
		add	di, 0Eh
		add	[bp+var_14], 0Eh
		add	[bp+var_16], 0Eh
		add	[bp+var_18], 0Eh
		add	[bp+var_1A], 0Eh
		inc	[bp+var_8]
		mov	ax, word_2D396
		cmp	[bp+var_8], ax
		jge	short loc_16D21
		jmp	loc_16C9B
; ---------------------------------------------------------------------------

loc_16D21:				; CODE XREF: sub_16C56+28j
					; sub_16C56+C6j
		mov	word_2D396, 0
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_16C56	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_16D2E	proc far		; CODE XREF: sub_10828+619P
					; sub_10F06+1FFP ...

var_34		= word ptr -34h
var_32		= word ptr -32h
var_30		= word ptr -30h
var_2E		= word ptr -2Eh
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
var_16		= dword	ptr -16h
var_12		= byte ptr -12h
var_10		= word ptr -10h
var_E		= word ptr -0Eh
var_C		= byte ptr -0Ch
var_A		= byte ptr -0Ah
var_8		= byte ptr -8
var_6		= byte ptr -6
var_4		= word ptr -4
var_2		= word ptr -2

		push	bp
		mov	bp, sp
		sub	sp, 34h
		push	di
		push	si
		call	sub_26363
		mov	bx, word_2D3AC
		shl	bx, 1
		shl	bx, 1
		mov	dx, [bx+244Ch]
		sub	ax, ax
		mov	[bp+var_4], ax
		mov	[bp+var_2], dx
		cmp	word_2CBE0, ax
		jnz	short loc_16D5A
		mov	al, 1
		jmp	short loc_16D5C
; ---------------------------------------------------------------------------
		align 2

loc_16D5A:				; CODE XREF: sub_16D2E+25j
		mov	al, 10h

loc_16D5C:				; CODE XREF: sub_16D2E+29j
		mov	[bp+var_A], al
		mov	[bp+var_1A], 0
		jmp	loc_16E52
; ---------------------------------------------------------------------------
		align 2

loc_16D68:				; CODE XREF: sub_16D2E+24Fj
		mov	ax, 1

loc_16D6B:				; CODE XREF: sub_16D2E+254j
		mov	cx, [bp+var_22]
		and	cx, 2
		or	ax, cx
		mov	[bp+var_22], ax

loc_16D76:				; CODE XREF: sub_16D2E+23Cj
		mov	bx, [bp+var_2A]
		mov	al, [bx]
		and	al, 2
		cmp	al, 2
		jnz	short loc_16DA4
		mov	ax, 1Fh
		sub	ax, si
		mov	si, ax
		mov	al, byte ptr [bp+var_22]
		and	al, 2
		cmp	al, 2
		jnz	short loc_16D96
		sub	ax, ax
		jmp	short loc_16D99
; ---------------------------------------------------------------------------
		align 2

loc_16D96:				; CODE XREF: sub_16D2E+61j
		mov	ax, 2

loc_16D99:				; CODE XREF: sub_16D2E+65j
		mov	cx, [bp+var_22]
		and	cx, 1
		or	ax, cx
		mov	[bp+var_22], ax

loc_16DA4:				; CODE XREF: sub_16D2E+51j
		mov	ax, [bp+var_22]
		mov	cl, 0Eh
		shl	ax, cl
		or	[bp+var_1C], ax
		mov	bx, [bp+var_28]
		mov	ax, [bx]
		add	ax, di
		sub	ax, 10h
		mov	di, ax
		mov	bx, [bp+var_26]
		mov	ax, [bx]
		mov	dx, si
		mov	cl, 3
		shl	dx, cl
		add	ax, dx
		sub	ax, 0A8h ; '�'
		mov	si, ax
		or	di, di
		jl	short loc_16E3B
		cmp	di, 27h	; '''
		jg	short loc_16E3B
		or	si, si
		jl	short loc_16E3B
		cmp	si, 188h
		jg	short loc_16E3B
		push	[bp+var_1C]
		push	[bp+var_1E]
		push	si
		push	di
		call	sub_27E4A
		add	sp, 8
		mov	ax, si
		cwd
		xor	ax, dx
		sub	ax, dx
		mov	cx, 3
		sar	ax, cl
		xor	ax, dx
		sub	ax, dx
		mov	cx, 28h	; '('
		imul	cx
		mov	bx, ax
		add	bx, di
		add	bx, [bp+var_4]
		mov	es, [bp+var_2]
		mov	al, [bp+var_A]
		or	es:[bx], al
		mov	ax, si
		test	al, 7
		jz	short loc_16E3B
		cwd
		xor	ax, dx
		sub	ax, dx
		mov	cx, 3
		sar	ax, cl
		xor	ax, dx
		sub	ax, dx
		mov	cx, 28h	; '('
		imul	cx
		mov	bx, ax
		add	bx, di
		add	bx, [bp+var_4]
		mov	al, [bp+var_A]
		or	es:[bx+28h], al

loc_16E3B:				; CODE XREF: sub_16D2E+A0j
					; sub_16D2E+A5j ...
		inc	[bp+var_20]
		mov	ax, [bp+var_24]
		cmp	[bp+var_20], ax
		jnb	short loc_16E49
		jmp	loc_16F00
; ---------------------------------------------------------------------------

loc_16E49:				; CODE XREF: sub_16D2E+116j
		mov	[bp+var_10], di
		mov	[bp+var_18], si

loc_16E4F:				; CODE XREF: sub_16D2E+1A2j
		inc	[bp+var_1A]

loc_16E52:				; CODE XREF: sub_16D2E+36j
		mov	ax, word_2D396
		cmp	[bp+var_1A], ax
		jl	short loc_16E5D
		jmp	loc_16F86
; ---------------------------------------------------------------------------

loc_16E5D:				; CODE XREF: sub_16D2E+12Aj
		mov	ax, [bp+var_1A]
		mov	cx, ax
		shl	ax, 1
		add	ax, cx
		shl	ax, 1
		add	ax, cx
		shl	ax, 1
		mov	[bp+var_2E], ax
		mov	bx, ax
		mov	bx, [bx+2664h]
		shl	bx, 1
		mov	bx, [bx+29C8h]
		shl	bx, 1
		shl	bx, 1
		mov	dx, [bx+244Ch]
		sub	ax, ax
		mov	word ptr [bp+var_16], ax
		mov	word ptr [bp+var_16+2],	dx
		mov	bx, [bp+var_2E]
		mov	bx, [bx+2666h]
		shl	bx, 1
		mov	bx, [bx+29C8h]
		shl	bx, 1
		shl	bx, 1
		mov	ax, [bx+244Ch]
		mov	[bp+var_1E], ax
		mov	bx, [bp+var_2E]
		mov	si, [bx+2668h]
		shl	si, 1
		les	bx, [bp+var_16]
		mov	ax, es:[bx+si+2]
		mov	[bp+var_E], ax
		add	word ptr [bp+var_16], ax
		mov	bx, word ptr [bp+var_16]
		inc	word ptr [bp+var_16]
		mov	al, es:[bx]
		mov	[bp+var_8], al
		mov	[bp+var_20], 0
		sub	ah, ah
		or	ax, ax
		jnz	short loc_16ED3
		jmp	loc_16E4F
; ---------------------------------------------------------------------------

loc_16ED3:				; CODE XREF: sub_16D2E+1A0j
		mov	[bp+var_24], ax
		mov	ax, cx
		shl	ax, 1
		add	ax, cx
		shl	ax, 1
		add	ax, cx
		shl	ax, 1
		mov	[bp+var_30], ax
		add	ax, 266Ch
		mov	[bp+var_26], ax
		mov	ax, [bp+var_30]
		add	ax, 266Ah
		mov	[bp+var_28], ax
		mov	ax, [bp+var_30]
		add	ax, 266Eh
		mov	[bp+var_2A], ax
		mov	[bp+var_2C], ax

loc_16F00:				; CODE XREF: sub_16D2E+118j
		les	bx, [bp+var_16]
		mov	al, es:[bx]
		mov	[bp+var_6], al
		inc	word ptr [bp+var_16]
		mov	bx, word ptr [bp+var_16]
		mov	al, es:[bx]
		mov	[bp+var_12], al
		inc	word ptr [bp+var_16]
		mov	bx, word ptr [bp+var_16]
		mov	al, es:[bx]
		mov	[bp+var_C], al
		inc	word ptr [bp+var_16]
		mov	al, [bp+var_6]
		sub	ah, ah
		mov	[bp+var_32], ax
		mov	cl, 6
		shr	ax, cl
		and	ax, 3
		mov	[bp+var_22], ax
		mov	al, [bp+var_12]
		sub	ah, ah
		mov	[bp+var_34], ax
		and	ax, 0E0h
		mov	cl, 3
		shl	ax, cl
		mov	cl, [bp+var_C]
		sub	ch, ch
		or	ax, cx
		mov	[bp+var_1C], ax
		mov	ax, [bp+var_32]
		and	ax, 1Fh
		mov	di, ax
		mov	ax, [bp+var_34]
		and	ax, 1Fh
		mov	si, ax
		mov	bx, [bp+var_2C]
		mov	al, [bx]
		and	al, 1
		cmp	al, 1
		jz	short loc_16F6D
		jmp	loc_16D76
; ---------------------------------------------------------------------------

loc_16F6D:				; CODE XREF: sub_16D2E+23Aj
		mov	ax, 1Fh
		sub	ax, di
		mov	di, ax
		mov	al, byte ptr [bp+var_22]
		and	al, 1
		cmp	al, 1
		jz	short loc_16F80
		jmp	loc_16D68
; ---------------------------------------------------------------------------

loc_16F80:				; CODE XREF: sub_16D2E+24Dj
		sub	ax, ax
		jmp	loc_16D6B
; ---------------------------------------------------------------------------
		align 2

loc_16F86:				; CODE XREF: sub_16D2E+12Cj
		mov	word_2D396, 0
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_16D2E	endp

; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		sub	sp, 4Eh
		push	di
		push	si
		mov	word ptr [bp-2], 1
		push	word ptr [bp+6]
		mov	ax, offset a_hem ; ".hem"
		push	ax
		lea	ax, [bp-42h]
		push	ax
		call	strcat
		add	sp, 6
		lea	ax, [bp-42h]
		push	ax
		call	MaybeLoadFile
		add	sp, 2
		mov	[bp-46h], ax
		push	ax
		call	sub_15496
		add	sp, 2
		mov	[bp-48h], ax
		shl	ax, 1
		shl	ax, 1
		add	ax, offset word_2CE1C
		mov	[bp-4Eh], ax
		mov	bx, ax
		push	word ptr [bx]
		lea	ax, [bp-42h]
		push	ax
		call	sub_29694
		add	sp, 4
		call	sub_26363
		mov	ax, 0A800h
		push	ax
		mov	bx, [bp-4Eh]
		push	word ptr [bx]
		call	sub_2A177
		add	sp, 4
		mov	[bp-46h], ax
		push	word ptr [bp-48h]
		call	sub_154E4
		add	sp, 2
		push	word ptr [bp-46h]
		call	sub_15496
		add	sp, 2
		mov	[bp-48h], ax
		mov	word ptr [bp-44h], 0
		cmp	word ptr [bp-46h], 0
		jle	short loc_17060
		shl	ax, 1
		shl	ax, 1
		add	ax, offset word_2CE1C
		mov	[bp-4Ch], ax
		mov	di, [bp-46h]
		mov	si, [bp-44h]

loc_17034:				; CODE XREF: seg002:0FEBj
		mov	ax, 10h
		push	ax
		mov	ax, si
		add	ah, 0A8h ; '�'
		mov	dx, ax
		sub	ax, ax
		push	dx
		push	ax
		mov	bx, [bp-4Ch]
		mov	ax, [bx]
		add	ax, si
		mov	dx, ax
		sub	ax, ax
		push	dx
		push	ax
		call	sub_153EC
		add	sp, 0Ah
		inc	si
		cmp	si, di
		jl	short loc_17034
		mov	[bp-44h], si

loc_17060:				; CODE XREF: seg002:0FB2j
		cmp	word ptr [bp-2], 0
		jz	short loc_1709E
		mov	di, [bp-48h]
		mov	cl, 2
		shl	di, cl
		add	di, offset word_2CE1C

loc_17071:				; CODE XREF: seg002:1029j
		push	4Ah ; 'J'
		nop
		push	word ptr [di]
		call	sub_2A68B
		add	sp, 4
		mov	si, ax
		or	si, si
		jz	short loc_17097
		sub	ax, ax
		push	ax
		mov	ax, 0FFFFh
		push	ax
		mov	ax, 1
		push	ax
		call	sub_29F6B
		add	sp, 6

loc_17097:				; CODE XREF: seg002:1012j
		or	si, si
		jnz	short loc_17071
		mov	[bp-2],	si

loc_1709E:				; CODE XREF: seg002:0FF4j
		push	word ptr [bp-48h]
		call	sub_154E4
		add	sp, 2
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
; ---------------------------------------------------------------------------
		align 2
seg002		ends

; ===========================================================================

; Segment type:	Pure code
seg003		segment	byte public 'CODE' use16
		assume cs:seg003
		assume es:nothing, ss:nothing, ds:seg026, fs:nothing, gs:nothing

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_170B0	proc far		; CODE XREF: sub_17682+FCp
					; sub_17A66+2D2p

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+2184h], 12h
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ACh], 1
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 2
		mov	byte ptr [si+21B1h], 1Eh
		mov	byte ptr [si+21B2h], 20h ; ' '
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 0Ch
		pop	si
		pop	bp
		retf
sub_170B0	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_170F2	proc far		; CODE XREF: sub_17426+A6p
					; sub_1758A+70p ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+2184h], 12h
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ACh], 1
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 2
		mov	byte ptr [si+21B1h], 15h
		mov	byte ptr [si+21B2h], 17h
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 0Ch
		pop	si
		pop	bp
		retf
sub_170F2	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_17134	proc far		; CODE XREF: sub_17870+D3p
					; sub_17A66+222p

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+2184h], 12h
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ACh], 2
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 3
		mov	byte ptr [si+21B1h], 18h
		mov	byte ptr [si+21B2h], 19h
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 0Fh
		pop	si
		pop	bp
		retf
sub_17134	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_17176	proc far		; CODE XREF: sub_179C6+19p
					; sub_17DF4+9Ap

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+2184h], 12h
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ACh], 3
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 3
		mov	byte ptr [si+21B1h], 2Bh ; '+'
		mov	byte ptr [si+21B2h], 2Bh ; '+'
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 0Dh
		mov	byte ptr [si+21ADh], 0Ah
		pop	si
		pop	bp
		retf
sub_17176	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_171BC	proc far		; CODE XREF: sub_17A06+19p
					; sub_17E9E+9Ap

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+2184h], 12h
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ACh], 3
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 3
		mov	byte ptr [si+21B1h], 1Ah
		mov	byte ptr [si+21B2h], 1Bh
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21ADh], 0Ah
		mov	byte ptr [si+21AAh], 0Eh
		pop	si
		pop	bp
		retf
sub_171BC	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_17202	proc far		; CODE XREF: sub_17682+124p
					; sub_17A66+286p

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+2184h], 1Ch
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ACh], 1
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 2
		mov	byte ptr [si+21B1h], 21h ; '!'
		mov	byte ptr [si+21B2h], 24h ; '$'
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 0Ch
		pop	si
		pop	bp
		retf
sub_17202	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_17244	proc far		; CODE XREF: sub_174D6+AAp
					; sub_17682+11Bp ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+2184h], 1Ch
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ACh], 1
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 2
		mov	byte ptr [si+21B1h], 25h ; '%'
		mov	byte ptr [si+21B2h], 27h ; '''
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 0Ch
		pop	si
		pop	bp
		retf
sub_17244	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_17286	proc far		; CODE XREF: sub_17870+ECp
					; sub_17A66+22Cp

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+2184h], 1Ch
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ACh], 2
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 3
		mov	byte ptr [si+21B1h], 28h ; '('
		mov	byte ptr [si+21B2h], 29h ; ')'
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 0Fh
		pop	si
		pop	bp
		retf
sub_17286	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_172C8	proc far		; CODE XREF: sub_179C6+32p
					; sub_17DF4+90p

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+2184h], 1Ch
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ACh], 3
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 3
		mov	byte ptr [si+21B1h], 2Ah ; '*'
		mov	byte ptr [si+21B2h], 2Ah ; '*'
		mov	byte ptr [si+21ADh], 0Ah
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 0Dh
		pop	si
		pop	bp
		retf
sub_172C8	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1730E	proc far		; CODE XREF: sub_17A06+32p
					; sub_17E9E+90p

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+2184h], 1Ch
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ACh], 3
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 3
		mov	byte ptr [si+21B1h], 2Ah ; '*'
		mov	byte ptr [si+21B2h], 2Ah ; '*'
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21ADh], 0Ah
		mov	byte ptr [si+21AAh], 0Eh
		pop	si
		pop	bp
		retf
sub_1730E	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_17354	proc far		; CODE XREF: sub_17682+BAp
					; sub_17870+BAp ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21AAh], 2
		mov	al, [si+21B8h]
		mov	[si+21B1h], al
		mov	al, [si+21B9h]
		mov	[si+21B2h], al
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	ax, [si+218Eh]
		mov	[si+217Eh], ax
		mov	byte ptr [si+21B0h], 4
		pop	si
		pop	bp
		retf
sub_17354	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1738E	proc far		; CODE XREF: sub_17682+B0p
					; sub_17870+B0p

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+217Ch], 0
		mov	byte ptr [si+21AAh], 3
		mov	al, [si+21B8h]
		mov	[si+21B1h], al
		mov	al, [si+21B9h]
		mov	[si+21B2h], al
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	ax, [si+218Eh]
		mov	[si+217Eh], ax
		mov	byte ptr [si+21B0h], 4
		pop	si
		pop	bp
		retf
sub_1738E	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_173CE	proc far		; CODE XREF: sub_17682+1DEp
					; sub_17870+146p ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	word ptr [si+21A6h], 0
		jnz	short loc_17422
		sub	ax, ax
		push	ax
		push	[bp+arg_0]
		call	sub_15C20
		add	sp, 4
		mov	word ptr [si+218Ah], 1
		mov	word ptr [si+2184h], 20h ; ' '
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 2
		mov	byte ptr [si+21B1h], 2Ch ; ','
		mov	byte ptr [si+21B2h], 31h ; '1'
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 18h

loc_17422:				; CODE XREF: sub_173CE+11j
		pop	si
		pop	bp
		retf
sub_173CE	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_17426	proc far		; CODE XREF: sub_17682+168p
					; sub_17A66+1AEp

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		test	byte ptr [bx+21ABh], 4
		jz	short loc_17443
		jmp	loc_174C8
; ---------------------------------------------------------------------------

loc_17443:				; CODE XREF: sub_17426+18j
		mov	ax, 4
		push	ax
		push	[bp+arg_0]
		call	sub_15C20
		add	sp, 4
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+2184h], 30h ; '0'
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21B0h], 6
		mov	byte ptr [si+21AFh], 0
		mov	bx, ax
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 4
		cmp	al, 4
		jnz	short loc_17483
		mov	byte ptr [si+21A9h], 1

loc_17483:				; CODE XREF: sub_17426+56j
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 8
		cmp	al, 8
		jnz	short loc_1749F
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		mov	byte ptr [bx+21A9h], 0

loc_1749F:				; CODE XREF: sub_17426+6Aj
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+217Ch], 0
		mov	byte ptr [si+21B1h], 34h ; '4'
		mov	byte ptr [si+21B2h], 36h ; '6'
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 14h
		pop	si
		pop	bp
		retf
; ---------------------------------------------------------------------------
		align 2

loc_174C8:				; CODE XREF: sub_17426+1Aj
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_170F2
		add	sp, 2
		pop	si
		pop	bp
		retf
sub_17426	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_174D6	proc far		; CODE XREF: sub_17682+1A6p
					; sub_17A66+1B8p

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		test	byte ptr [bx+21ABh], 4
		jz	short loc_174F3
		jmp	loc_1757C
; ---------------------------------------------------------------------------

loc_174F3:				; CODE XREF: sub_174D6+18j
		mov	ax, 4
		push	ax
		push	[bp+arg_0]
		call	sub_15C20
		add	sp, 4
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+2184h], 30h ; '0'
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ADh], 0
		mov	byte ptr [si+21B0h], 6
		mov	byte ptr [si+21AFh], 0
		mov	bx, ax
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 4
		cmp	al, 4
		jnz	short loc_17538
		mov	byte ptr [si+21A9h], 1

loc_17538:				; CODE XREF: sub_174D6+5Bj
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 8
		cmp	al, 8
		jnz	short loc_17554
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		mov	byte ptr [bx+21A9h], 0

loc_17554:				; CODE XREF: sub_174D6+6Fj
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+217Ch], 0
		mov	byte ptr [si+21B1h], 37h ; '7'
		mov	byte ptr [si+21B2h], 3Bh ; ';'
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 15h
		pop	si
		pop	bp
		retf
; ---------------------------------------------------------------------------

loc_1757C:				; CODE XREF: sub_174D6+1Aj
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_17244
		add	sp, 2
		pop	si
		pop	bp
		retf
sub_174D6	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1758A	proc far		; CODE XREF: sub_17682+187p
					; sub_17A66+1C2p

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		test	byte ptr [bx+21ABh], 4
		jnz	short loc_175F6
		mov	ax, 4
		push	ax
		push	[bp+arg_0]
		call	sub_15C20
		add	sp, 4
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+2184h], 30h ; '0'
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21B0h], 6
		mov	byte ptr [si+21AFh], 0
		mov	word ptr [si+217Ch], 0
		mov	byte ptr [si+21B1h], 1Ch
		mov	byte ptr [si+21B2h], 1Dh
		mov	byte ptr [si+21ADh], 0
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 16h
		pop	si
		pop	bp
		retf
; ---------------------------------------------------------------------------

loc_175F6:				; CODE XREF: sub_1758A+18j
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_170F2
		add	sp, 2
		pop	si
		pop	bp
		retf
sub_1758A	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_17604	proc far		; CODE XREF: sub_17682+1C5p
					; sub_17870+12Dp ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		test	byte ptr [bx+21ABh], 4
		jnz	short loc_17674
		mov	ax, 4
		push	ax
		push	[bp+arg_0]
		call	sub_15C20
		add	sp, 4
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+2184h], 30h ; '0'
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21B0h], 6
		mov	byte ptr [si+21AFh], 0
		mov	ax, [si+2192h]
		shl	ax, 1
		mov	[si+217Eh], ax
		mov	byte ptr [si+21B1h], 40h ; '@'
		mov	byte ptr [si+21B2h], 46h ; 'F'
		mov	byte ptr [si+21ADh], 0
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 17h
		pop	si
		pop	bp
		retf
; ---------------------------------------------------------------------------

loc_17674:				; CODE XREF: sub_17604+18j
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_170F2
		add	sp, 2
		pop	si
		pop	bp
		retf
sub_17604	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_17682	proc far		; CODE XREF: sub_17A46+7p
					; sub_180FE+108P ...

var_6		= byte ptr -6
var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 6
		push	di
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+218Ah], 0
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+2178h]
		cmp	[bx+2178h], ax
		jle	short loc_176C4
		mov	ax, cx
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		jmp	short loc_176D8
; ---------------------------------------------------------------------------

loc_176C4:				; CODE XREF: sub_17682+2Dj
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, cx
		imul	[bp+arg_0]

loc_176D8:				; CODE XREF: sub_17682+40j
		mov	di, ax
		mov	ax, [di+2178h]
		sub	ax, [bx+2178h]
		mov	[bp+var_2], ax
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		mov	[bp+var_6], al
		and	al, 1
		cmp	al, 1
		jnz	short loc_17742
		mov	al, [bp+var_6]
		and	al, 4
		cmp	al, 4
		jnz	short loc_17706
		mov	ax, 1
		jmp	short loc_17708
; ---------------------------------------------------------------------------
		align 2

loc_17706:				; CODE XREF: sub_17682+7Cj
		sub	ax, ax

loc_17708:				; CODE XREF: sub_17682+81j
		imul	word ptr [si+2194h]
		mov	cl, [bp+var_6]
		and	cl, 8
		mov	di, ax
		cmp	cl, 8
		jnz	short loc_1771E
		mov	ax, 1
		jmp	short loc_17720
; ---------------------------------------------------------------------------

loc_1771E:				; CODE XREF: sub_17682+95j
		sub	ax, ax

loc_17720:				; CODE XREF: sub_17682+9Aj
		imul	word ptr [si+2194h]
		sub	ax, di
		mov	[si+217Ch], ax
		or	ax, ax
		jnz	short loc_17738
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1738E
		jmp	short loc_1773F
; ---------------------------------------------------------------------------
		align 2

loc_17738:				; CODE XREF: sub_17682+AAj
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_17354

loc_1773F:				; CODE XREF: sub_17682+B3j
		add	sp, 2

loc_17742:				; CODE XREF: sub_17682+73j
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 2
		cmp	al, 2
		jnz	short loc_1775C
		push	[bp+arg_0]
		call	sub_21F72
		add	sp, 2

loc_1775C:				; CODE XREF: sub_17682+CDj
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 10h
		cmp	al, 10h
		jnz	short loc_17784
		cmp	[bp+var_2], 30h	; '0'
		jge	short loc_1777A
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_170F2
		jmp	short loc_17781
; ---------------------------------------------------------------------------

loc_1777A:				; CODE XREF: sub_17682+EDj
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_170B0

loc_17781:				; CODE XREF: sub_17682+F6j
		add	sp, 2

loc_17784:				; CODE XREF: sub_17682+E7j
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 20h
		cmp	al, 20h	; ' '
		jnz	short loc_177AC
		cmp	[bp+var_2], 30h	; '0'
		jge	short loc_177A2
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_17244
		jmp	short loc_177A9
; ---------------------------------------------------------------------------

loc_177A2:				; CODE XREF: sub_17682+115j
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_17202

loc_177A9:				; CODE XREF: sub_17682+11Ej
		add	sp, 2

loc_177AC:				; CODE XREF: sub_17682+10Fj
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		mov	[bp+var_6], al
		test	[bp+var_6], 0Ch
		jnz	short loc_177C1
		jmp	loc_1784D
; ---------------------------------------------------------------------------

loc_177C1:				; CODE XREF: sub_17682+13Aj
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		test	byte ptr [bx+21ABh], 2
		jnz	short loc_1784D
		mov	al, [bp+var_6]
		and	al, 20h
		cmp	al, 20h	; ' '
		jnz	short loc_177F0
		cmp	[bp+var_2], 30h	; '0'
		jge	short loc_177F0
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_17426
		add	sp, 2

loc_177F0:				; CODE XREF: sub_17682+15Cj
					; sub_17682+162j
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 10h
		cmp	al, 10h
		jnz	short loc_1780F
		cmp	[bp+var_2], 30h	; '0'
		jge	short loc_1780F
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1758A
		add	sp, 2

loc_1780F:				; CODE XREF: sub_17682+17Bj
					; sub_17682+181j
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 30h
		cmp	al, 30h	; '0'
		jnz	short loc_1782E
		cmp	[bp+var_2], 30h	; '0'
		jge	short loc_1782E
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_174D6
		add	sp, 2

loc_1782E:				; CODE XREF: sub_17682+19Aj
					; sub_17682+1A0j
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_18316
		add	sp, 2
		cmp	ax, 1
		jnz	short loc_1784D
		cmp	[bp+var_2], 40h	; '@'
		jge	short loc_1784D
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_17604
		add	sp, 2

loc_1784D:				; CODE XREF: sub_17682+13Cj
					; sub_17682+153j ...
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 32h
		cmp	al, 32h	; '2'
		jnz	short loc_17866
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_173CE
		add	sp, 2

loc_17866:				; CODE XREF: sub_17682+1D8j
		mov	ax, [bp+var_4]
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_17682	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_17870	proc far		; CODE XREF: sub_17A56+7p
					; sub_180FE+108P ...

var_6		= byte ptr -6
var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 6
		push	di
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+218Ah], 0
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+2178h]
		cmp	[bx+2178h], ax
		jle	short loc_178B2
		mov	ax, cx
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		jmp	short loc_178C6
; ---------------------------------------------------------------------------

loc_178B2:				; CODE XREF: sub_17870+2Dj
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, cx
		imul	[bp+arg_0]

loc_178C6:				; CODE XREF: sub_17870+40j
		mov	di, ax
		mov	ax, [di+2178h]
		sub	ax, [bx+2178h]
		mov	[bp+var_2], ax
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		mov	[bp+var_6], al
		and	al, 1
		cmp	al, 1
		jnz	short loc_17930
		mov	al, [bp+var_6]
		and	al, 4
		cmp	al, 4
		jnz	short loc_178F4
		mov	ax, 1
		jmp	short loc_178F6
; ---------------------------------------------------------------------------
		align 2

loc_178F4:				; CODE XREF: sub_17870+7Cj
		sub	ax, ax

loc_178F6:				; CODE XREF: sub_17870+81j
		imul	word ptr [si+2194h]
		mov	cl, [bp+var_6]
		and	cl, 8
		mov	di, ax
		cmp	cl, 8
		jnz	short loc_1790C
		mov	ax, 1
		jmp	short loc_1790E
; ---------------------------------------------------------------------------

loc_1790C:				; CODE XREF: sub_17870+95j
		sub	ax, ax

loc_1790E:				; CODE XREF: sub_17870+9Aj
		imul	word ptr [si+2194h]
		sub	ax, di
		mov	[si+217Ch], ax
		or	ax, ax
		jnz	short loc_17926
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1738E
		jmp	short loc_1792D
; ---------------------------------------------------------------------------
		align 2

loc_17926:				; CODE XREF: sub_17870+AAj
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_17354

loc_1792D:				; CODE XREF: sub_17870+B3j
		add	sp, 2

loc_17930:				; CODE XREF: sub_17870+73j
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 10h
		cmp	al, 10h
		jnz	short loc_17949
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_17134
		add	sp, 2

loc_17949:				; CODE XREF: sub_17870+CDj
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 20h
		cmp	al, 20h	; ' '
		jnz	short loc_17962
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_17286
		add	sp, 2

loc_17962:				; CODE XREF: sub_17870+E6j
		mov	bx, [bp+arg_0]
		shl	bx, 1
		test	byte ptr [bx+2514h], 0Ch
		jz	short loc_179A3
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		test	byte ptr [bx+21ABh], 2
		jnz	short loc_179A3
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_18316
		add	sp, 2
		cmp	ax, 1
		jnz	short loc_179A3
		cmp	[bp+var_2], 40h	; '@'
		jge	short loc_179A3
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_17604
		add	sp, 2

loc_179A3:				; CODE XREF: sub_17870+FCj
					; sub_17870+112j ...
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 32h
		cmp	al, 32h	; '2'
		jnz	short loc_179BC
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_173CE
		add	sp, 2

loc_179BC:				; CODE XREF: sub_17870+140j
		mov	ax, [bp+var_4]
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_17870	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_179C6	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 2
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 10h
		cmp	al, 10h
		jnz	short loc_179E5
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_17176
		add	sp, 2

loc_179E5:				; CODE XREF: sub_179C6+13j
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 20h
		cmp	al, 20h	; ' '
		jnz	short loc_179FE
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_172C8
		add	sp, 2

loc_179FE:				; CODE XREF: sub_179C6+2Cj
		mov	ax, [bp+var_2]
		mov	sp, bp
		pop	bp
		retf
sub_179C6	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_17A06	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 2
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 10h
		cmp	al, 10h
		jnz	short loc_17A25
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_171BC
		add	sp, 2

loc_17A25:				; CODE XREF: sub_17A06+13j
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 20h
		cmp	al, 20h	; ' '
		jnz	short loc_17A3E
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1730E
		add	sp, 2

loc_17A3E:				; CODE XREF: sub_17A06+2Cj
		mov	ax, [bp+var_2]
		mov	sp, bp
		pop	bp
		retf
sub_17A06	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_17A46	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_17682
		add	sp, 2
		pop	bp
		retf
sub_17A46	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_17A56	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_17870
		add	sp, 2
		pop	bp
		retf
sub_17A56	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_17A66	proc far		; CODE XREF: sub_17F48+1Cp
					; sub_17F84+1Cp ...

var_8		= word ptr -8
var_6		= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 8
		push	di
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+218Ah], 0
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+2178h]
		cmp	[bx+2178h], ax
		jle	short loc_17AA8
		mov	ax, cx
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		jmp	short loc_17ABC
; ---------------------------------------------------------------------------

loc_17AA8:				; CODE XREF: sub_17A66+2Dj
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, cx
		imul	[bp+arg_0]

loc_17ABC:				; CODE XREF: sub_17A66+40j
		mov	di, ax
		mov	ax, [di+2178h]
		sub	ax, [bx+2178h]
		mov	[bp+var_6], ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+2178h]
		cmp	[bx+2178h], ax
		jle	short loc_17AE8
		mov	ax, 1
		jmp	short loc_17AEB
; ---------------------------------------------------------------------------
		align 2

loc_17AE8:				; CODE XREF: sub_17A66+7Aj
		mov	ax, 0FFFFh

loc_17AEB:				; CODE XREF: sub_17A66+7Fj
		mov	[bp+var_4], ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+2178h]
		cmp	[bx+2178h], ax
		jle	short loc_17B0C
		mov	ax, 0FFFFh
		jmp	short loc_17B0F
; ---------------------------------------------------------------------------

loc_17B0C:				; CODE XREF: sub_17A66+9Fj
		mov	ax, 1

loc_17B0F:				; CODE XREF: sub_17A66+A4j
		mov	[bp+var_2], ax
		mov	byte ptr [si+21ADh], 0
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	byte ptr [bx+21ACh], 0
		jnz	short loc_17B30
		jmp	loc_17BB4
; ---------------------------------------------------------------------------

loc_17B30:				; CODE XREF: sub_17A66+C5j
		call	sub_1525A
		sub	ah, ah
		and	ax, 7
		cmp	ax, word_2A9F4
		jnb	short loc_17BB4
		push	[bp+arg_0]
		call	sub_22252
		add	sp, 2
		cmp	ax, 1
		jz	short loc_17B53
		jmp	loc_17DEA
; ---------------------------------------------------------------------------

loc_17B53:				; CODE XREF: sub_17A66+E8j
		cmp	word_2A9F4, 1
		jnz	short loc_17B5D
		jmp	loc_17DEA
; ---------------------------------------------------------------------------

loc_17B5D:				; CODE XREF: sub_17A66+F2j
		call	sub_1525A
		sub	ah, ah
		and	ax, 7
		cmp	ax, word_2A9F4
		jnb	short loc_17B94
		call	sub_1525A
		sub	ah, ah
		and	ax, 7
		cmp	ax, word_2A9F4
		jb	short loc_17B80
		jmp	loc_17DEA
; ---------------------------------------------------------------------------

loc_17B80:				; CODE XREF: sub_17A66+115j
					; sub_17A66+336j
		mov	ax, [si+2194h]
		imul	[bp+var_4]

loc_17B87:				; CODE XREF: sub_17A66+349j
		mov	[si+217Ch], ax
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_17354
		jmp	short loc_17BAE
; ---------------------------------------------------------------------------

loc_17B94:				; CODE XREF: sub_17A66+105j
		call	sub_1525A
		sub	ah, ah
		and	ax, 7
		cmp	ax, word_2A9F4
		jb	short loc_17BA7
		jmp	loc_17DEA
; ---------------------------------------------------------------------------

loc_17BA7:				; CODE XREF: sub_17A66+13Cj
					; sub_17A66+2F1j
					; DATA XREF: ...
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_173CE

loc_17BAE:				; CODE XREF: sub_17A66+12Cj
					; sub_17A66+1B1j ...
		add	sp, 2
		jmp	loc_17DEA
; ---------------------------------------------------------------------------

loc_17BB4:				; CODE XREF: sub_17A66+C7j
					; sub_17A66+D8j
		call	sub_1525A
		sub	ah, ah
		and	ax, 7
		cmp	ax, word_2A9F4
		jb	short loc_17BC7
		jmp	loc_17DCE
; ---------------------------------------------------------------------------

loc_17BC7:				; CODE XREF: sub_17A66+15Cj
		cmp	[bp+var_6], 30h	; '0'
		jl	short loc_17BD0
		jmp	loc_17C98
; ---------------------------------------------------------------------------

loc_17BD0:				; CODE XREF: sub_17A66+165j
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	al, [bx+21ABh]
		sub	ah, ah
		or	ax, ax
		jz	short loc_17BF8
		cmp	ax, 1
		jz	short loc_17C60
		cmp	ax, 2
		jz	short loc_17C72
		jmp	loc_17DEA
; ---------------------------------------------------------------------------
		align 4

loc_17BF8:				; CODE XREF: sub_17A66+181j
		call	sub_1525A
		and	ax, 7
		cmp	ax, 7
		jbe	short loc_17C08
		jmp	loc_17DEA
; ---------------------------------------------------------------------------

loc_17C08:				; CODE XREF: sub_17A66+19Dj
		add	ax, ax
		xchg	ax, bx
		jmp	cs:off_17C4C[bx]

loc_17C10:				; CODE XREF: sub_17A66+202j
					; DATA XREF: sub_17A66:off_17C4Co
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_17426
		jmp	short loc_17BAE
; ---------------------------------------------------------------------------
		align 2

loc_17C1A:				; CODE XREF: sub_17A66+1A5j
					; DATA XREF: sub_17A66+1E8o
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_174D6
		jmp	short loc_17BAE
; ---------------------------------------------------------------------------
		align 2

loc_17C24:				; CODE XREF: sub_17A66+1A5j
					; sub_17A66+207j
					; DATA XREF: ...
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1758A
		jmp	short loc_17BAE
; ---------------------------------------------------------------------------
		align 2

loc_17C2E:				; CODE XREF: sub_17A66+1A5j
					; sub_17A66+26Cj
					; DATA XREF: ...
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_17604
		jmp	loc_17BAE
; ---------------------------------------------------------------------------

loc_17C38:				; CODE XREF: sub_17A66+1A5j
					; sub_17A66+214j
					; DATA XREF: ...
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_17244
		jmp	loc_17BAE
; ---------------------------------------------------------------------------

loc_17C42:				; CODE XREF: sub_17A66+1A5j
					; sub_17A66+219j
					; DATA XREF: ...
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_170F2
		jmp	loc_17BAE
; ---------------------------------------------------------------------------
off_17C4C	dw offset loc_17C10	; DATA XREF: sub_17A66+1A5r
		dw offset loc_17C1A
		dw offset loc_17C24
		dw offset loc_17C2E
		dw offset loc_17C38
		dw offset loc_17C42
		dw offset loc_17C84
		dw offset loc_17C8E
; ---------------------------------------------------------------------------
		jmp	loc_17DEA
; ---------------------------------------------------------------------------
		align 2

loc_17C60:				; CODE XREF: sub_17A66+186j
		call	sub_1525A
		and	ax, 3
		jz	short loc_17C10
		cmp	ax, 1
		jz	short loc_17C24
		jmp	short loc_17CDA
; ---------------------------------------------------------------------------
		align 2

loc_17C72:				; CODE XREF: sub_17A66+18Bj
		call	sub_1525A
		and	ax, 3
		jz	short loc_17C38
		cmp	ax, 1
		jz	short loc_17C42
		jmp	short loc_17CDA
; ---------------------------------------------------------------------------
		align 2

loc_17C84:				; CODE XREF: sub_17A66+1A5j
					; sub_17A66+277j ...
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_17134
		jmp	loc_17BAE
; ---------------------------------------------------------------------------

loc_17C8E:				; CODE XREF: sub_17A66+1A5j
					; sub_17A66+27Cj ...
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_17286
		jmp	loc_17BAE
; ---------------------------------------------------------------------------

loc_17C98:				; CODE XREF: sub_17A66+167j
		cmp	[bp+var_6], 40h	; '@'
		jl	short loc_17CA1
		jmp	loc_17D3E
; ---------------------------------------------------------------------------

loc_17CA1:				; CODE XREF: sub_17A66+236j
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	al, [bx+21ABh]
		sub	ah, ah
		or	ax, ax
		jz	short loc_17CC8
		cmp	ax, 1
		jz	short loc_17CF2
		cmp	ax, 2
		jz	short loc_17D14
		jmp	loc_17DEA
; ---------------------------------------------------------------------------
		align 2

loc_17CC8:				; CODE XREF: sub_17A66+252j
		call	sub_1525A
		and	ax, 3
		jnz	short loc_17CD5
		jmp	loc_17C2E
; ---------------------------------------------------------------------------

loc_17CD5:				; CODE XREF: sub_17A66+26Aj
		cmp	ax, 1
		jz	short loc_17CE8

loc_17CDA:				; CODE XREF: sub_17A66+209j
					; sub_17A66+21Bj
		cmp	ax, 2
		jz	short loc_17C84
		cmp	ax, 3
		jz	short loc_17C8E
		jmp	loc_17DEA
; ---------------------------------------------------------------------------
		align 2

loc_17CE8:				; CODE XREF: sub_17A66+272j
					; sub_17A66+2A1j ...
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_17202
		jmp	loc_17BAE
; ---------------------------------------------------------------------------

loc_17CF2:				; CODE XREF: sub_17A66+257j
		call	sub_1525A
		and	ax, 3
		jnz	short loc_17CFF
		jmp	loc_17DA0
; ---------------------------------------------------------------------------

loc_17CFF:				; CODE XREF: sub_17A66+294j
		cmp	ax, 1
		jz	short loc_17C8E
		cmp	ax, 2
		jz	short loc_17CE8
		cmp	ax, 3
		jnz	short loc_17D11
		jmp	loc_17C84
; ---------------------------------------------------------------------------

loc_17D11:				; CODE XREF: sub_17A66+2A6j
		jmp	loc_17DEA
; ---------------------------------------------------------------------------

loc_17D14:				; CODE XREF: sub_17A66+25Cj
		call	sub_1525A
		and	ax, 3
		jnz	short loc_17D21
		jmp	loc_17C84
; ---------------------------------------------------------------------------

loc_17D21:				; CODE XREF: sub_17A66+2B6j
		cmp	ax, 1
		jz	short loc_17DA0
		cmp	ax, 2
		jz	short loc_17D34
		cmp	ax, 3
		jz	short loc_17CE8
		jmp	loc_17DEA
; ---------------------------------------------------------------------------
		align 2

loc_17D34:				; CODE XREF: sub_17A66+2C3j
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_170B0
		jmp	loc_17BAE
; ---------------------------------------------------------------------------

loc_17D3E:				; CODE XREF: sub_17A66+238j
		cmp	[bp+var_6], 60h	; '`'
		jge	short loc_17D7E
		call	sub_1525A
		and	ax, 7
		cmp	ax, 7
		jbe	short loc_17D54
		jmp	loc_17DEA
; ---------------------------------------------------------------------------

loc_17D54:				; CODE XREF: sub_17A66+2E9j
		add	ax, ax
		xchg	ax, bx
		jmp	cs:off_17D6C[bx]

loc_17D5C:				; DATA XREF: sub_17A66+30Ao
					; sub_17A66+30Co ...
		cmp	[bp+var_6], 60h	; '`'
		jg	short loc_17DB8

loc_17D62:				; CODE XREF: sub_17A66+350j
		cmp	[bp+var_6], 50h	; 'P'
		jge	short loc_17DDA

loc_17D68:				; CODE XREF: sub_17A66+372j
		mov	al, 2
		jmp	short loc_17DDC
; ---------------------------------------------------------------------------
off_17D6C	dw offset loc_17D94	; DATA XREF: sub_17A66+2F1r
		dw offset loc_17BA7
		dw offset loc_17D5C
		dw offset loc_17D5C
		dw offset loc_17D5C
		dw offset loc_17D5C
		dw offset loc_17D5C
		dw offset loc_17DCE
; ---------------------------------------------------------------------------
		jmp	short loc_17DEA
; ---------------------------------------------------------------------------

loc_17D7E:				; CODE XREF: sub_17A66+2DCj
		call	sub_1525A
		and	ax, 7
		cmp	ax, 7
		ja	short loc_17DEA
		add	ax, ax
		xchg	ax, bx
		jmp	cs:off_17DBC[bx]
; ---------------------------------------------------------------------------
		align 2

loc_17D94:				; CODE XREF: sub_17A66+2F1j
					; sub_17A66+328j
					; DATA XREF: ...
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		jmp	loc_17B80
; ---------------------------------------------------------------------------
		align 2

loc_17DA0:				; CODE XREF: sub_17A66+296j
					; sub_17A66+2BEj
					; DATA XREF: ...
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	ax, [si+2194h]
		imul	[bp+var_2]
		jmp	loc_17B87
; ---------------------------------------------------------------------------

loc_17DB2:				; DATA XREF: sub_17A66:off_17DBCo
		cmp	[bp+var_6], 60h	; '`'
		jle	short loc_17D62

loc_17DB8:				; CODE XREF: sub_17A66+2FAj
					; sub_17A66+36Cj
		mov	al, 1
		jmp	short loc_17DDC
; ---------------------------------------------------------------------------
off_17DBC	dw offset loc_17D94	; 0 ; DATA XREF: sub_17A66+328r
		dw offset loc_17BA7	; 1
		dw offset loc_17DA0	; 2
		dw offset loc_17DB2	; 3
		dw offset loc_17DCE	; 4
		dw offset loc_17D5C	; 5
		dw offset loc_17D5C	; 6
		dw offset loc_17D5C	; 7
; ---------------------------------------------------------------------------
		jmp	short loc_17DEA
; ---------------------------------------------------------------------------

loc_17DCE:				; CODE XREF: sub_17A66+15Ej
					; sub_17A66+2F1j
					; DATA XREF: ...
		cmp	[bp+var_6], 60h	; '`'
		jg	short loc_17DB8
		cmp	[bp+var_6], 50h	; 'P'
		jl	short loc_17D68

loc_17DDA:				; CODE XREF: sub_17A66+300j
		sub	al, al

loc_17DDC:				; CODE XREF: sub_17A66+304j
					; sub_17A66+354j
		mov	cx, ax
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		mov	[bx+21ADh], cl

loc_17DEA:				; CODE XREF: sub_17A66+EAj
					; sub_17A66+F4j ...
		mov	ax, [bp+var_8]
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_17A66	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_17DF4	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 4
		push	di
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+2178h]
		cmp	[bx+2178h], ax
		jle	short loc_17E30
		mov	ax, cx
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		jmp	short loc_17E44
; ---------------------------------------------------------------------------

loc_17E30:				; CODE XREF: sub_17DF4+27j
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, cx
		imul	[bp+arg_0]

loc_17E44:				; CODE XREF: sub_17DF4+3Aj
		mov	di, ax
		mov	ax, [di+2178h]
		sub	ax, [bx+2178h]
		mov	[bp+var_2], ax
		call	sub_1525A
		sub	ah, ah
		and	ax, 7
		cmp	ax, word_2A9F4
		jnb	short loc_17E94
		cmp	[bp+var_2], 50h	; 'P'
		jge	short loc_17E94
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+217Ah]
		cmp	[bx+217Ah], ax
		jle	short loc_17E8A
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_172C8
		jmp	short loc_17E91
; ---------------------------------------------------------------------------
		align 2

loc_17E8A:				; CODE XREF: sub_17DF4+8Aj
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_17176

loc_17E91:				; CODE XREF: sub_17DF4+93j
		add	sp, 2

loc_17E94:				; CODE XREF: sub_17DF4+6Bj
					; sub_17DF4+71j
		mov	ax, [bp+var_4]
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_17DF4	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_17E9E	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 4
		push	di
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+2178h]
		cmp	[bx+2178h], ax
		jle	short loc_17EDA
		mov	ax, cx
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		jmp	short loc_17EEE
; ---------------------------------------------------------------------------

loc_17EDA:				; CODE XREF: sub_17E9E+27j
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, cx
		imul	[bp+arg_0]

loc_17EEE:				; CODE XREF: sub_17E9E+3Aj
		mov	di, ax
		mov	ax, [di+2178h]
		sub	ax, [bx+2178h]
		mov	[bp+var_2], ax
		call	sub_1525A
		sub	ah, ah
		and	ax, 7
		cmp	ax, word_2A9F4
		jnb	short loc_17F3E
		cmp	[bp+var_2], 50h	; 'P'
		jge	short loc_17F3E
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+217Ah]
		cmp	[bx+217Ah], ax
		jge	short loc_17F34
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1730E
		jmp	short loc_17F3B
; ---------------------------------------------------------------------------
		align 2

loc_17F34:				; CODE XREF: sub_17E9E+8Aj
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_171BC

loc_17F3B:				; CODE XREF: sub_17E9E+93j
		add	sp, 2

loc_17F3E:				; CODE XREF: sub_17E9E+6Bj
					; sub_17E9E+71j
		mov	ax, [bp+var_4]
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_17E9E	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_17F48	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 4
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	al, [si+21ADh]
		sub	ah, ah
		mov	[bp+var_4], ax
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_17A66
		add	sp, 2
		mov	[bp+var_2], ax
		cmp	byte ptr [si+21AAh], 4
		jnz	short loc_17F7B
		mov	al, byte ptr [bp+var_4]
		mov	[si+21ADh], al

loc_17F7B:				; CODE XREF: sub_17F48+2Aj
		mov	ax, [bp+var_2]
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_17F48	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_17F84	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 4
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	al, [si+21ADh]
		sub	ah, ah
		mov	[bp+var_4], ax
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_17A66
		add	sp, 2
		mov	[bp+var_2], ax
		cmp	byte ptr [si+21AAh], 5
		jnz	short loc_17FB7
		mov	al, byte ptr [bp+var_4]
		mov	[si+21ADh], al

loc_17FB7:				; CODE XREF: sub_17F84+2Aj
		mov	ax, [bp+var_2]
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_17F84	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_17FC0	proc far		; CODE XREF: sub_11230+1B1P
					; sub_11230+1C4P ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	ax, 14h
		imul	[bp+arg_0]
		mov	cl, 3
		shl	ax, cl
		add	ax, 0F0h ; '�'
		mov	[si+2178h], ax
		mov	word ptr [si+217Ah], 9Eh ; '�'
		mov	word ptr [si+217Ch], 0
		mov	word ptr [si+217Ch], 0
		mov	word ptr [si+217Eh], 0
		mov	word ptr [si+2182h], 0
		mov	word ptr [si+2180h], 0C9h ; '�'
		mov	word ptr [si+2184h], 0
		mov	word ptr [si+2188h], 0
		mov	word ptr [si+218Ah], 0
		mov	word ptr [si+218Ch], 0
		mov	word ptr [si+219Ah], 0
		mov	word ptr [si+219Ch], 0
		mov	word ptr [si+219Eh], 0
		mov	word ptr [si+21A0h], 0
		mov	word ptr [si+21A2h], 0
		mov	word ptr [si+21A4h], 0
		mov	word ptr [si+21A6h], 0
		mov	word ptr [si+218Eh], 0FFD0h
		mov	word ptr [si+2190h], 6
		mov	word ptr [si+2192h], 2
		mov	word ptr [si+2194h], 8
		mov	word ptr [si+2196h], 4
		mov	byte ptr [si+21A8h], 0
		mov	word ptr [si+2198h], 0
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	[si+21A9h], al
		mov	byte ptr [si+21AAh], 0
		mov	byte ptr [si+21ABh], 0
		mov	byte ptr [si+21ACh], 0
		mov	byte ptr [si+21ADh], 0
		mov	byte ptr [si+21AEh], 7
		mov	byte ptr [si+21AFh], 0
		mov	[si+21B0h], cl
		mov	byte ptr [si+21B1h], 0
		mov	byte ptr [si+21B2h], 0
		mov	byte ptr [si+21B3h], 0Bh
		mov	byte ptr [si+21B4h], 0Eh
		mov	byte ptr [si+21B5h], 7
		mov	byte ptr [si+21B6h], 0Ah
		mov	byte ptr [si+21B7h], 11h
		mov	byte ptr [si+21B8h], 12h
		mov	byte ptr [si+21B9h], 14h
		mov	byte ptr [si+21BAh], 0Fh
		mov	byte ptr [si+21BBh], 10h
		mov	byte ptr [si+21BCh], 1
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21BDh], 0
		mov	byte ptr [si+21BEh], 6
		mov	byte ptr [si+21BFh], 2
		mov	[si+21C0h], cl
		mov	byte ptr [si+21C1h], 5
		mov	byte ptr [si+21C2h], 3Fh ; '?'
		pop	si
		pop	bp
		retf
sub_17FC0	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_180FE	proc far		; CODE XREF: sub_12822+34P
					; sub_12822+52P ...

var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	si
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	word ptr [bx+2180h], 0
		jle	short loc_18125
		cmp	word_2CEE8, 0
		jz	short loc_18125
		jmp	loc_181D3
; ---------------------------------------------------------------------------

loc_18125:				; CODE XREF: sub_180FE+1Bj
					; sub_180FE+22j
		mov	si, [bp+arg_0]
		shl	si, 1
		mov	word ptr [si+2514h], 0
		mov	word ptr [si+2448h], 0
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	byte ptr [bx+21AAh], 0
		jnz	short loc_1815B
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	byte ptr [bx+21AAh], 0Ah
		jz	short loc_1818A

loc_1815B:				; CODE XREF: sub_180FE+45j
		cmp	word_2CEE8, 0
		jnz	short loc_181D3
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+2180h]
		cmp	[bx+2180h], ax
		jge	short loc_181D3
		cmp	byte ptr [si+21AAh], 0
		jnz	short loc_181D3

loc_1818A:				; CODE XREF: sub_180FE+5Bj
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21AAh], 12h
		mov	byte ptr [si+21B0h], 4
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21ADh], 14h
		mov	byte ptr [si+21AEh], 3Dh ; '='
		mov	byte ptr [si+21B1h], 3Eh ; '>'
		mov	byte ptr [si+21B2h], 3Eh ; '>'
		mov	ax, 5
		push	ax
		push	[bp+arg_0]
		call	sub_15C20
		add	sp, 4
		mov	bx, [bp+arg_0]
		shl	bx, 1
		inc	word ptr [bx+2646h]
		mov	word_2A9E4, 1

loc_181D3:				; CODE XREF: sub_180FE+24j
					; sub_180FE+62j ...
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	ax, [bx+2514h]
		mov	[bp+var_2], ax
		push	[bp+arg_0]
		call	sub_107EA
		add	sp, 2
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	word ptr [si+2186h], 0
		jnz	short loc_18220
		push	[bp+arg_0]
		mov	bl, [si+21AAh]
		sub	bh, bh
		shl	bx, 1
		shl	bx, 1
		call	off_2BEFE[bx]
		add	sp, 2
		push	[bp+arg_0]
		mov	bl, [si+21AAh]
		sub	bh, bh
		shl	bx, 1
		shl	bx, 1
		call	off_2BFC6[bx]
		jmp	short loc_18263
; ---------------------------------------------------------------------------

loc_18220:				; CODE XREF: sub_180FE+F9j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		add	si, 21AAh
		push	[bp+arg_0]
		mov	bl, [si]
		sub	bh, bh
		shl	bx, 1
		shl	bx, 1
		call	off_2BF62[bx]
		add	sp, 2
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	word ptr [bx+2180h], 0
		jle	short loc_18266
		push	[bp+arg_0]
		mov	bl, [si]
		sub	bh, bh
		shl	bx, 1
		shl	bx, 1
		call	off_2C02A[bx]

loc_18263:				; CODE XREF: sub_180FE+120j
		add	sp, 2

loc_18266:				; CODE XREF: sub_180FE+154j
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1829A
		add	sp, 2
		push	[bp+arg_0]
		call	sub_233A6
		add	sp, 2
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		mov	ax, [bp+var_2]
		mov	[bx+2198h], ax
		push	[bp+arg_0]
		call	sub_2398E
		add	sp, 2
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_180FE	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1829A	proc far		; CODE XREF: sub_180FE+16Cp

var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	di
		push	si
		mov	[bp+var_2], 0
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	word ptr [si+21A6h], 1
		jnz	short loc_1830C
		inc	word ptr [si+219Ah]
		cmp	word ptr [si+219Ah], 33h ; '3'
		jle	short loc_182C7
		mov	word ptr [si+219Ah], 32h ; '2'

loc_182C7:				; CODE XREF: sub_1829A+25j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	word ptr [si+219Ch], 0
		jnz	short loc_182DC
		mov	ax, 0FFF0h
		jmp	short loc_182DF
; ---------------------------------------------------------------------------
		align 2

loc_182DC:				; CODE XREF: sub_1829A+3Aj
		mov	ax, 10h

loc_182DF:				; CODE XREF: sub_1829A+3Fj
		add	[si+21A2h], ax
		mov	di, word_2A9DC
		mov	cl, 3
		shl	di, cl
		lea	ax, [di-20h]
		cmp	[si+21A2h], ax
		jl	short loc_182FE
		lea	ax, [di+160h]
		cmp	[si+21A2h], ax
		jle	short loc_1830C

loc_182FE:				; CODE XREF: sub_1829A+58j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		mov	word ptr [bx+21A6h], 0

loc_1830C:				; CODE XREF: sub_1829A+1Aj
					; sub_1829A+62j
		mov	ax, [bp+var_2]
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_1829A	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_18316	proc far		; CODE XREF: sub_17682+1B0p
					; sub_17870+118p

var_1A		= word ptr -1Ah
var_18		= word ptr -18h
var_16		= word ptr -16h
var_14		= word ptr -14h
var_12		= word ptr -12h
var_10		= word ptr -10h
var_E		= byte ptr -0Eh
var_C		= word ptr -0Ch
var_A		= word ptr -0Ah
var_8		= word ptr -8
var_6		= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 1Ch
		push	di
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		mov	al, [bx+21A9h]
		mov	[bp+var_E], al
		cmp	al, 1
		jnz	short loc_18336
		mov	ax, 4
		jmp	short loc_18339
; ---------------------------------------------------------------------------

loc_18336:				; CODE XREF: sub_18316+19j
		mov	ax, 8

loc_18339:				; CODE XREF: sub_18316+1Ej
		mov	[bp+var_2], ax
		cmp	[bp+var_E], 0
		jnz	short loc_18348
		mov	ax, 4
		jmp	short loc_1834B
; ---------------------------------------------------------------------------
		align 2

loc_18348:				; CODE XREF: sub_18316+2Aj
		mov	ax, 8

loc_1834B:				; CODE XREF: sub_18316+2Fj
		mov	[bp+var_C], ax
		mov	[bp+var_6], 0
		mov	[bp+var_A], 0
		mov	ax, word_2D012
		mov	[bp+var_8], ax
		dec	[bp+var_8]
		jns	short loc_18368
		mov	[bp+var_8], 1Dh

loc_18368:				; CODE XREF: sub_18316+4Bj
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	ax, [bp+var_2]
		add	ax, 10h
		cmp	[bx+2448h], ax
		jz	short loc_1837C
		jmp	loc_1842B
; ---------------------------------------------------------------------------

loc_1837C:				; CODE XREF: sub_18316+61j
		mov	cx, 1
		mov	[bp+var_4], 0Fh
		mov	ax, 3Ch	; '<'
		imul	[bp+arg_0]
		mov	[bp+var_10], ax
		mov	ax, [bp+var_C]
		add	ax, 2
		mov	[bp+var_12], ax
		mov	ax, [bp+var_10]
		mov	[bp+var_14], ax
		mov	[bp+var_16], ax
		mov	ax, [bp+var_2]
		add	ax, 2
		mov	[bp+var_18], ax
		mov	ax, [bp+var_10]
		mov	[bp+var_1A], ax
		mov	si, 0Fh
		mov	di, [bp+var_C]
		mov	dx, [bp+var_8]

loc_183B7:				; CODE XREF: sub_18316+103j
		mov	bx, dx
		shl	bx, 1
		add	bx, [bp+var_1A]
		mov	ax, [bp+var_18]
		cmp	[bx+254Ah], ax
		jnz	short loc_183CF
		cmp	cx, 1
		jnz	short loc_183CF
		mov	cx, 2

loc_183CF:				; CODE XREF: sub_18316+AFj
					; sub_18316+B4j
		mov	bx, dx
		shl	bx, 1
		add	bx, [bp+var_16]
		cmp	word ptr [bx+254Ah], 2
		jnz	short loc_183E5
		cmp	cx, 2
		jnz	short loc_183E5
		mov	cx, 3

loc_183E5:				; CODE XREF: sub_18316+C5j
					; sub_18316+CAj
		mov	bx, dx
		shl	bx, 1
		add	bx, [bp+var_14]
		mov	ax, [bp+var_12]
		cmp	[bx+254Ah], ax
		jnz	short loc_183FD
		cmp	cx, 3
		jnz	short loc_183FD
		mov	cx, 4

loc_183FD:				; CODE XREF: sub_18316+DDj
					; sub_18316+E2j
		mov	bx, dx
		shl	bx, 1
		add	bx, [bp+var_10]
		cmp	[bx+254Ah], di
		jnz	short loc_18412
		cmp	cx, 4
		jnz	short loc_18412
		mov	cx, 5

loc_18412:				; CODE XREF: sub_18316+F2j
					; sub_18316+F7j
		dec	dx
		jns	short loc_18418
		mov	dx, 1Dh

loc_18418:				; CODE XREF: sub_18316+FDj
		dec	si
		jnz	short loc_183B7
		mov	[bp+var_8], dx
		mov	[bp+var_6], cx
		cmp	cx, 5
		jnz	short loc_1842B
		mov	[bp+var_A], 1

loc_1842B:				; CODE XREF: sub_18316+63j
					; sub_18316+10Ej
		mov	ax, [bp+var_A]
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_18316	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_18434	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+139P
					; DATA XREF: ...

var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21ABh], 0
		inc	byte ptr [si+21AFh]
		mov	al, [si+21AFh]
		cmp	[si+21B0h], al
		ja	short loc_184C0
		mov	byte ptr [si+21AFh], 0
		inc	byte ptr [si+21AEh]
		cmp	byte ptr [si+21AEh], 2Fh ; '/'
		jnz	short loc_184AC
		cmp	byte ptr [si+21A9h], 0
		jnz	short loc_18472
		mov	ax, 0FFF8h
		jmp	short loc_18475
; ---------------------------------------------------------------------------

loc_18472:				; CODE XREF: sub_18434+37j
		mov	ax, 8

loc_18475:				; CODE XREF: sub_18434+3Cj
		add	ax, [si+2178h]
		mov	[si+21A2h], ax
		mov	ax, [si+217Ah]
		mov	[si+21A4h], ax
		mov	al, [si+21A9h]
		sub	ah, ah
		mov	[si+219Ch], ax
		mov	word ptr [si+219Ah], 32h ; '2'
		mov	word ptr [si+21A6h], 1
		mov	word ptr [si+219Eh], 0
		mov	word ptr [si+21A0h], 0
		mov	byte ptr [si+21B0h], 3

loc_184AC:				; CODE XREF: sub_18434+30j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	byte ptr [si+21AEh], 30h ; '0'
		jnz	short loc_184C0
		mov	byte ptr [si+21B0h], 2

loc_184C0:				; CODE XREF: sub_18434+20j
					; sub_18434+85j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	byte ptr [si+21AEh], 31h ; '1'
		jbe	short loc_184DF
		push	[bp+arg_0]
		call	sub_21F4C
		add	sp, 2
		mov	byte ptr [si+21A8h], 0

loc_184DF:				; CODE XREF: sub_18434+99j
		mov	ax, [bp+var_2]
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_18434	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_184E8	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+139P
					; DATA XREF: ...

var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	di
		push	si
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21A8h], 1
		inc	byte ptr [si+21AFh]
		mov	al, [si+21AFh]
		cmp	[si+21B0h], al
		ja	short loc_18524
		mov	byte ptr [si+21AFh], 0
		mov	al, [si+21B2h]
		cmp	[si+21AEh], al
		jnb	short loc_18524
		inc	byte ptr [si+21AEh]

loc_18524:				; CODE XREF: sub_184E8+27j
					; sub_184E8+36j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	al, [si+21B1h]
		cmp	[si+21AEh], al
		jz	short loc_18539
		jmp	loc_185CE
; ---------------------------------------------------------------------------

loc_18539:				; CODE XREF: sub_184E8+4Cj
		mov	byte ptr [si+21B0h], 3
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	byte ptr [bx+21AAh], 10h
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	al, [bx+21BCh]
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+21AEh], cl
		cmp	byte ptr [si+21A9h], 0
		jnz	short loc_18584
		mov	ax, 0FFF0h
		jmp	short loc_18587
; ---------------------------------------------------------------------------
		align 2

loc_18584:				; CODE XREF: sub_184E8+94j
		mov	ax, 10h

loc_18587:				; CODE XREF: sub_184E8+99j
		add	ax, [si+2178h]
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+2178h], cx
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+217Ah]
		sub	ax, 10h
		mov	[bx+217Ah], ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	al, [si+21A9h]
		mov	[bx+21A9h], al

loc_185CE:				; CODE XREF: sub_184E8+4Ej
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	al, [si+21B1h]
		sub	ah, ah
		inc	ax
		mov	cl, [si+21AEh]
		sub	ch, ch
		cmp	ax, cx
		jz	short loc_185EA
		jmp	loc_1867B
; ---------------------------------------------------------------------------

loc_185EA:				; CODE XREF: sub_184E8+FDj
		mov	byte ptr [si+21B0h], 3
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	byte ptr [bx+21AAh], 10h
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	al, [bx+21BFh]
		inc	al
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+21AEh], cl
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	al, [si+21A9h]
		mov	[bx+21A9h], al
		sub	ax, ax
		add	ax, [si+2178h]
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+2178h], cx
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+217Ah]
		sub	ax, 2Ch	; ','
		mov	[bx+217Ah], ax
		mov	byte ptr [si+21ADh], 0Ah

loc_1867B:				; CODE XREF: sub_184E8+FFj
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	al, [si+21B2h]
		cmp	[si+21AEh], al
		jz	short loc_18690
		jmp	loc_188E5
; ---------------------------------------------------------------------------

loc_18690:				; CODE XREF: sub_184E8+1A3j
		mov	[si+21AEh], al
		dec	byte ptr [si+21ADh]
		cmp	byte ptr [si+21ADh], 9
		jz	short loc_186A2
		jmp	loc_1873C
; ---------------------------------------------------------------------------

loc_186A2:				; CODE XREF: sub_184E8+1B5j
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	byte ptr [bx+21AAh], 10h
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	al, [bx+21BDh]
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+21AEh], cl
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	byte ptr [si+21A9h], 1
		sbb	ax, ax
		neg	ax
		or	al, 2
		mov	[bx+21A9h], al
		cmp	byte ptr [si+21A9h], 0
		jnz	short loc_18706
		mov	ax, 38h	; '8'
		jmp	short loc_18709
; ---------------------------------------------------------------------------
		align 2

loc_18706:				; CODE XREF: sub_184E8+216j
		mov	ax, 0FFC8h

loc_18709:				; CODE XREF: sub_184E8+21Bj
		add	ax, [si+2178h]
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+2178h], cx
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+217Ah]
		add	ax, 28h	; '('
		mov	[bx+217Ah], ax

loc_1873C:				; CODE XREF: sub_184E8+1B7j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	byte ptr [si+21ADh], 7
		jz	short loc_1874E
		jmp	loc_188B5
; ---------------------------------------------------------------------------

loc_1874E:				; CODE XREF: sub_184E8+261j
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	byte ptr [bx+21B0h], 3
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	byte ptr [bx+21AFh], 0
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	al, [bx+21BFh]
		inc	al
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+21AEh], cl
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	byte ptr [bx+21AAh], 9
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	ax, [si+218Eh]
		cwd
		xor	ax, dx
		sub	ax, dx
		mov	cx, 2
		sar	ax, cl
		xor	ax, dx
		sub	ax, dx
		mov	[bx+217Eh], ax
		cmp	byte ptr [si+21A9h], 0
		jnz	short loc_187DC
		mov	ax, 10h
		jmp	short loc_187DF
; ---------------------------------------------------------------------------

loc_187DC:				; CODE XREF: sub_184E8+2EDj
		mov	ax, 0FFF0h

loc_187DF:				; CODE XREF: sub_184E8+2F2j
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+217Ch], cx
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	al, [si+21A9h]
		mov	[bx+21A9h], al
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	byte ptr [bx+21ADh], 4
		cmp	byte ptr [si+21A9h], 0
		jnz	short loc_18828
		mov	ax, 40h	; '@'
		jmp	short loc_1882B
; ---------------------------------------------------------------------------

loc_18828:				; CODE XREF: sub_184E8+339j
		mov	ax, 0FFC0h

loc_1882B:				; CODE XREF: sub_184E8+33Ej
		add	ax, [si+2178h]
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+2178h], cx
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+217Ah]
		mov	[bx+217Ah], ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		cmp	[bp+arg_0], 1
		sbb	di, di
		neg	di
		shl	di, 1
		mov	ax, 30h	; '0'
		imul	word ptr [di+2A2Ch]
		add	ax, 30h	; '0'
		cwd
		xor	ax, dx
		sub	ax, dx
		mov	cx, 2
		sar	ax, cl
		xor	ax, dx
		sub	ax, dx
		sub	[bx+2180h], ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	word ptr [bx+2180h], 0
		jg	short loc_188A9
		mov	word_2D014, 0Ah

loc_188A9:				; CODE XREF: sub_184E8+3B9j
		mov	ax, 0Dh
		push	ax
		call	sub_15BEE
		add	sp, 2

loc_188B5:				; CODE XREF: sub_184E8+263j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	byte ptr [si+21ADh], 0
		jnz	short loc_188E5
		mov	byte ptr [si+21A8h], 0
		mov	byte ptr [si+21B0h], 3
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21ADh], 2
		mov	byte ptr [si+21AAh], 11h
		mov	al, [si+21C2h]
		mov	[si+21AEh], al

loc_188E5:				; CODE XREF: sub_184E8+1A5j
					; sub_184E8+3DAj
		mov	ax, [bp+var_2]
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_184E8	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_188EE	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+139P
					; DATA XREF: ...

var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	di
		push	si
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21A8h], 1
		inc	byte ptr [si+21ADh]
		cmp	byte ptr [si+21ADh], 1
		jz	short loc_18917
		jmp	loc_189AD
; ---------------------------------------------------------------------------

loc_18917:				; CODE XREF: sub_188EE+24j
		inc	byte ptr [si+21AEh]
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	byte ptr [bx+21AAh], 10h
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		cmp	byte ptr [si+21A9h], 1
		sbb	ax, ax
		neg	ax
		mov	[bx+21A9h], al
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	al, [bx+21BDh]
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+21AEh], cl
		cmp	byte ptr [si+21A9h], 0
		jnz	short loc_1897A
		mov	ax, 0FFD0h
		jmp	short loc_1897D
; ---------------------------------------------------------------------------
		align 2

loc_1897A:				; CODE XREF: sub_188EE+84j
		mov	ax, 30h	; '0'

loc_1897D:				; CODE XREF: sub_188EE+89j
		add	ax, [si+2178h]
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+2178h], cx
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+217Ah]
		mov	[bx+217Ah], ax

loc_189AD:				; CODE XREF: sub_188EE+26j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	byte ptr [si+21ADh], 6
		jz	short loc_189BF
		jmp	loc_18A58
; ---------------------------------------------------------------------------

loc_189BF:				; CODE XREF: sub_188EE+CCj
		inc	byte ptr [si+21AEh]
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	byte ptr [bx+21AAh], 10h
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	al, [bx+21C1h]
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+21AEh], cl
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	al, [si+21A9h]
		or	al, 2
		mov	[bx+21A9h], al
		cmp	byte ptr [si+21A9h], 0
		jnz	short loc_18A22
		mov	ax, 0FFF0h
		jmp	short loc_18A25
; ---------------------------------------------------------------------------
		align 2

loc_18A22:				; CODE XREF: sub_188EE+12Cj
		mov	ax, 10h

loc_18A25:				; CODE XREF: sub_188EE+131j
		add	ax, [si+2178h]
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+2178h], cx
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+217Ah]
		add	ax, 20h	; ' '
		mov	[bx+217Ah], ax

loc_18A58:				; CODE XREF: sub_188EE+CEj
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	byte ptr [si+21ADh], 7
		jnz	short loc_18A87
		inc	byte ptr [si+21AEh]
		cmp	byte ptr [si+21A9h], 1
		jnz	short loc_18A78
		mov	ax, 0FFF8h
		jmp	short loc_18A7B
; ---------------------------------------------------------------------------
		align 2

loc_18A78:				; CODE XREF: sub_188EE+182j
		mov	ax, 8

loc_18A7B:				; CODE XREF: sub_188EE+187j
		mov	[si+217Ch], ax
		mov	ax, [si+218Eh]
		mov	[si+217Eh], ax

loc_18A87:				; CODE XREF: sub_188EE+177j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	byte ptr [si+21ADh], 8
		jz	short loc_18A99
		jmp	loc_18B52
; ---------------------------------------------------------------------------

loc_18A99:				; CODE XREF: sub_188EE+1A6j
		push	[bp+arg_0]
		call	sub_2274C
		add	sp, 2
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	byte ptr [bx+21AAh], 10h
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	al, [bx+21C1h]
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+21AEh], cl
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	al, [si+21A9h]
		or	al, 2
		mov	[bx+21A9h], al
		cmp	byte ptr [si+21A9h], 0
		jnz	short loc_18B02
		mov	ax, 0FFE8h
		jmp	short loc_18B05
; ---------------------------------------------------------------------------

loc_18B02:				; CODE XREF: sub_188EE+20Dj
		mov	ax, 18h

loc_18B05:				; CODE XREF: sub_188EE+212j
		add	ax, [si+2178h]
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+2178h], cx
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+217Ah]
		add	ax, 20h	; ' '
		mov	[bx+217Ah], ax
		cmp	word ptr [si+217Eh], 0
		jl	short loc_18B46
		inc	byte ptr [si+21AEh]
		jmp	short loc_18B52
; ---------------------------------------------------------------------------
		align 2

loc_18B46:				; CODE XREF: sub_188EE+24Fj
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		dec	byte ptr [bx+21ADh]

loc_18B52:				; CODE XREF: sub_188EE+1A8j
					; sub_188EE+255j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		add	si, 21ADh
		cmp	byte ptr [si], 9
		jz	short loc_18B66
		jmp	loc_18C14
; ---------------------------------------------------------------------------

loc_18B66:				; CODE XREF: sub_188EE+273j
		push	[bp+arg_0]
		call	sub_2274C
		add	sp, 2
		or	ax, ax
		jnz	short loc_18B77
		dec	byte ptr [si]

loc_18B77:				; CODE XREF: sub_188EE+285j
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	byte ptr [bx+21AAh], 10h
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	al, [bx+21C1h]
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+21AEh], cl
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	al, [si+21A9h]
		or	al, 2
		mov	[bx+21A9h], al
		cmp	byte ptr [si+21A9h], 0
		jnz	short loc_18BDE
		mov	ax, 0FFF0h
		jmp	short loc_18BE1
; ---------------------------------------------------------------------------
		align 2

loc_18BDE:				; CODE XREF: sub_188EE+2E8j
		mov	ax, 10h

loc_18BE1:				; CODE XREF: sub_188EE+2EDj
		add	ax, [si+2178h]
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+2178h], cx
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+217Ah]
		add	ax, 40h	; '@'
		mov	[bx+217Ah], ax

loc_18C14:				; CODE XREF: sub_188EE+275j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	byte ptr [si+21ADh], 0Ah
		jz	short loc_18C26
		jmp	loc_18CC8
; ---------------------------------------------------------------------------

loc_18C26:				; CODE XREF: sub_188EE+333j
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	byte ptr [bx+21AAh], 10h
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	al, [bx+21BFh]
		inc	al
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+21AEh], cl
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	al, [si+21A9h]
		or	al, 2
		mov	[bx+21A9h], al
		cmp	byte ptr [si+21A9h], 0
		jnz	short loc_18C86
		mov	ax, 0FFE8h
		jmp	short loc_18C89
; ---------------------------------------------------------------------------

loc_18C86:				; CODE XREF: sub_188EE+391j
		mov	ax, 18h

loc_18C89:				; CODE XREF: sub_188EE+396j
		add	ax, [si+2178h]
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+2178h], cx
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+217Ah]
		add	ax, 20h	; ' '
		mov	[bx+217Ah], ax
		mov	ax, 0Dh
		push	ax
		call	sub_15BEE
		add	sp, 2

loc_18CC8:				; CODE XREF: sub_188EE+335j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	byte ptr [si+21ADh], 0Ch
		jz	short loc_18CDA
		jmp	loc_18E05
; ---------------------------------------------------------------------------

loc_18CDA:				; CODE XREF: sub_188EE+3E7j
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	di, ax
		mov	ax, [di+218Eh]
		cwd
		mov	cx, 3
		idiv	cx
		mov	[bx+217Eh], ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	al, [bx+21BFh]
		inc	al
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+21AEh], cl
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	byte ptr [bx+21AAh], 9
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	al, [si+21A9h]
		mov	[bx+21A9h], al
		or	al, al
		jnz	short loc_18D5E
		mov	ax, 8
		jmp	short loc_18D61
; ---------------------------------------------------------------------------

loc_18D5E:				; CODE XREF: sub_188EE+469j
		mov	ax, 0FFF8h

loc_18D61:				; CODE XREF: sub_188EE+46Ej
		neg	ax
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+217Ch], cx
		cmp	byte ptr [si+21A9h], 0
		jnz	short loc_18D84
		mov	ax, 0FFE8h
		jmp	short loc_18D87
; ---------------------------------------------------------------------------

loc_18D84:				; CODE XREF: sub_188EE+48Fj
		mov	ax, 18h

loc_18D87:				; CODE XREF: sub_188EE+494j
		add	ax, [si+2178h]
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax		; CODE XREF: sub_17A66+328j
		mov	[bx+2178h], cx
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+217Ah]
		mov	[bx+217Ah], ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		cmp	[bp+arg_0], 1
		sbb	di, di
		neg	di
		shl	di, 1
		mov	ax, 30h	; '0'
		imul	word ptr [di+2A2Ch]
		add	ax, 30h	; '0'
		cwd
		xor	ax, dx
		sub	ax, dx
		mov	cx, 2
		sar	ax, cl
		xor	ax, dx
		sub	ax, dx
		sub	[bx+2180h], ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	word ptr [bx+2180h], 0
		jg	short loc_18E05
		mov	word_2D014, 0Ah

loc_18E05:				; CODE XREF: sub_188EE+3E9j
					; sub_188EE+50Fj
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	byte ptr [si+21ADh], 10h
		jnz	short loc_18E79
		cmp	byte ptr [si+21A9h], 0
		jnz	short loc_18E20
		mov	ax, 10h
		jmp	short loc_18E23
; ---------------------------------------------------------------------------

loc_18E20:				; CODE XREF: sub_188EE+52Bj
		mov	ax, 0FFF0h

loc_18E23:				; CODE XREF: sub_188EE+530j
		add	[si+2178h], ax
		cmp	byte ptr [si+21A9h], 0
		jnz	short loc_18E34
		mov	ax, 8
		jmp	short loc_18E37
; ---------------------------------------------------------------------------
		align 2

loc_18E34:				; CODE XREF: sub_188EE+53Ej
		mov	ax, 0FFF8h

loc_18E37:				; CODE XREF: sub_188EE+543j
		mov	[si+217Ch], ax
		mov	ax, [si+218Eh]
		cwd
		sub	ax, dx
		sar	ax, 1
		mov	[si+217Eh], ax
		mov	byte ptr [si+21A8h], 0
		mov	byte ptr [si+21B0h], 2
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21ADh], 0
		mov	byte ptr [si+21AAh], 0Dh
		mov	al, [si+21B8h]
		mov	[si+21B1h], al
		mov	al, [si+21B9h]
		mov	[si+21B2h], al
		mov	al, [si+21B1h]
		mov	[si+21AEh], al

loc_18E79:				; CODE XREF: sub_188EE+524j
		mov	ax, [bp+var_2]
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_188EE	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_18E82	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+139P
					; DATA XREF: ...

var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	di
		push	si
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21A8h], 1
		inc	byte ptr [si+21ADh]
		cmp	byte ptr [si+21ADh], 23h ; '#'
		ja	short loc_18EAB
		jmp	loc_18F66
; ---------------------------------------------------------------------------

loc_18EAB:				; CODE XREF: sub_18E82+24j
		cmp	byte ptr [si+21ADh], 24h ; '$'
		jz	short loc_18EB5
		jmp	loc_191A9
; ---------------------------------------------------------------------------

loc_18EB5:				; CODE XREF: sub_18E82+2Ej
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	byte ptr [bx+21AAh], 9
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	di, ax
		mov	ax, [di+218Eh]
		cwd
		sub	ax, dx
		sar	ax, 1
		mov	[bx+217Eh], ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	al, [bx+21BFh]
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+21AEh], cl
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	byte ptr [bx+21A9h], 0
		jnz	short loc_18F2E
		mov	ax, 10h
		jmp	short loc_18F31
; ---------------------------------------------------------------------------

loc_18F2E:				; CODE XREF: sub_18E82+A5j
		mov	ax, 0FFF0h

loc_18F31:				; CODE XREF: sub_18E82+AAj
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+217Ch], cx
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	byte ptr [si+21A9h], 1
		sbb	ax, ax
		neg	ax
		mov	[bx+21A9h], al
		jmp	loc_191A9
; ---------------------------------------------------------------------------
		align 2

loc_18F66:				; CODE XREF: sub_18E82+26j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	al, [si+21ADh]
		and	al, 4
		cmp	al, 4
		jz	short loc_18F7B
		jmp	loc_19116
; ---------------------------------------------------------------------------

loc_18F7B:				; CODE XREF: sub_18E82+F4j
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	byte ptr [bx+21AAh], 10h
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		cmp	byte ptr [si+21A9h], 1
		sbb	ax, ax
		neg	ax
		mov	[bx+21A9h], al
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	ax, [si+217Ah]
		sub	ax, 0Fh
		mov	[bx+217Ah], ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	al, [bx+21BCh]
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+21AEh], cl
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		cmp	byte ptr [si+21A9h], 0
		jnz	short loc_18FF8
		mov	ax, 8
		jmp	short loc_18FFB
; ---------------------------------------------------------------------------

loc_18FF8:				; CODE XREF: sub_18E82+16Fj
		mov	ax, 0FFF8h

loc_18FFB:				; CODE XREF: sub_18E82+174j
		add	ax, [si+2178h]
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+2178h], cx
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	[bp+arg_0], 1
		sbb	di, di
		neg	di
		shl	di, 1
		mov	ax, [di+2A2Ch]
		shl	ax, 1
		shl	ax, 1
		add	ax, 4
		cwd
		xor	ax, dx
		sub	ax, dx
		mov	cx, 2
		sar	ax, cl
		xor	ax, dx
		sub	ax, dx
		sub	[bx+2180h], ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	word ptr [bx+2180h], 0
		jle	short loc_19063
		jmp	loc_191A9
; ---------------------------------------------------------------------------

loc_19063:				; CODE XREF: sub_18E82+1DCj
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	byte ptr [bx+21AAh], 9
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	di, ax
		mov	ax, [di+218Eh]
		cwd
		sub	ax, dx
		sar	ax, 1
		mov	[bx+217Eh], ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	al, [bx+21BFh]
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+21AEh], cl
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	byte ptr [bx+21A9h], 0
		jnz	short loc_190DA
		mov	ax, 10h
		jmp	short loc_190DD
; ---------------------------------------------------------------------------
		align 2

loc_190DA:				; CODE XREF: sub_18E82+250j
		mov	ax, 0FFF0h

loc_190DD:				; CODE XREF: sub_18E82+255j
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+217Ch], cx
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	byte ptr [si+21A9h], 1
		sbb	ax, ax
		neg	ax
		mov	[bx+21A9h], al
		mov	byte ptr [si+21ADh], 25h ; '%'
		jmp	loc_191A9
; ---------------------------------------------------------------------------

loc_19116:				; CODE XREF: sub_18E82+F6j
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	byte ptr [bx+21AAh], 10h
		mov	ax, cx
		imul	[bp+arg_0]
		mov	si, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		cmp	byte ptr [si+21A9h], 1
		sbb	ax, ax
		neg	ax
		mov	[bx+21A9h], al
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	ax, [si+217Ah]
		sub	ax, 10h
		mov	[bx+217Ah], ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	al, [bx+21BDh]
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+21AEh], cl
		mov	al, [si+21B2h]
		mov	[si+21AEh], al
		sub	ax, ax
		add	ax, [si+2178h]
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+2178h], cx

loc_191A9:				; CODE XREF: sub_18E82+30j
					; sub_18E82+E0j ...
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	byte ptr [si+21ADh], 28h ; '('
		jnz	short loc_191E7
		mov	byte ptr [si+21A8h], 0
		push	[bp+arg_0]
		call	sub_21EF8
		add	sp, 2
		mov	al, [si+21B5h]
		mov	[si+21B1h], al
		mov	[si+21B2h], al
		mov	byte ptr [si+21B0h], 1
		mov	byte ptr [si+21AFh], 0
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 0Ch

loc_191E7:				; CODE XREF: sub_18E82+334j
		mov	ax, [bp+var_2]
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_18E82	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_191F0	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+139P
					; DATA XREF: ...

var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	di
		push	si
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21A8h], 1
		inc	byte ptr [si+21ADh]
		cmp	byte ptr [si+21ADh], 7
		jb	short loc_19219
		jmp	loc_192A0
; ---------------------------------------------------------------------------

loc_19219:				; CODE XREF: sub_191F0+24j
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	byte ptr [bx+21AAh], 10h
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		cmp	byte ptr [si+21A9h], 1
		sbb	ax, ax
		neg	ax
		mov	[bx+21A9h], al
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	al, [bx+21BDh]
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+21AEh], cl
		sub	ax, ax
		add	ax, [si+2178h]
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+2178h], cx
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+217Ah]
		sub	ax, 0Fh
		mov	[bx+217Ah], ax

loc_192A0:				; CODE XREF: sub_191F0+26j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	byte ptr [si+21ADh], 7
		jnz	short loc_192DF
		mov	ax, 1
		push	ax
		push	[bp+arg_0]
		call	sub_15C20
		add	sp, 4
		inc	byte ptr [si+21AEh]
		cmp	byte ptr [si+21A9h], 0
		jnz	short loc_192CE
		mov	ax, 4
		jmp	short loc_192D1
; ---------------------------------------------------------------------------

loc_192CE:				; CODE XREF: sub_191F0+D7j
		mov	ax, 0FFFCh

loc_192D1:				; CODE XREF: sub_191F0+DCj
		mov	[si+217Ch], ax
		mov	ax, [si+218Eh]
		shl	ax, 1
		mov	[si+217Eh], ax

loc_192DF:				; CODE XREF: sub_191F0+BDj
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	byte ptr [si+21ADh], 8
		jz	short loc_192F1
		jmp	loc_193AC
; ---------------------------------------------------------------------------

loc_192F1:				; CODE XREF: sub_191F0+FCj
		push	[bp+arg_0]
		call	sub_2274C
		add	sp, 2
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	byte ptr [bx+21AAh], 10h
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		cmp	byte ptr [si+21A9h], 1
		sbb	ax, ax
		neg	ax
		mov	[bx+21A9h], al
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	al, [bx+21BDh]
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+21AEh], cl
		sub	ax, ax
		add	ax, [si+2178h]
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+2178h], cx
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+217Ah]
		sub	ax, 0Fh
		mov	[bx+217Ah], ax
		cmp	word ptr [si+217Eh], 0
		jl	short loc_193A0
		mov	al, [si+21B2h]
		sub	al, 4
		mov	[si+21AEh], al
		mov	byte ptr [si+21B0h], 2
		mov	byte ptr [si+21AFh], 0
		jmp	short loc_193AC
; ---------------------------------------------------------------------------

loc_193A0:				; CODE XREF: sub_191F0+198j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		dec	byte ptr [bx+21ADh]

loc_193AC:				; CODE XREF: sub_191F0+FEj
					; sub_191F0+1AEj
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	byte ptr [si+21ADh], 9
		jz	short loc_193BE
		jmp	loc_1946C
; ---------------------------------------------------------------------------

loc_193BE:				; CODE XREF: sub_191F0+1C9j
		push	[bp+arg_0]
		call	sub_2274C
		add	sp, 2
		or	ax, ax
		jz	short loc_193D0
		jmp	loc_1946C
; ---------------------------------------------------------------------------

loc_193D0:				; CODE XREF: sub_191F0+1DBj
		dec	byte ptr [si+21ADh]
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	byte ptr [bx+21AAh], 10h
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	al, [bx+21C1h]
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+21AEh], cl
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	byte ptr [si+21A9h], 1
		sbb	ax, ax
		neg	ax
		mov	[bx+21A9h], al
		cmp	byte ptr [si+21A9h], 0
		jnz	short loc_19436
		mov	ax, 18h
		jmp	short loc_19439
; ---------------------------------------------------------------------------
		align 2

loc_19436:				; CODE XREF: sub_191F0+23Ej
		mov	ax, 0FFE8h

loc_19439:				; CODE XREF: sub_191F0+243j
		add	ax, [si+2178h]
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+2178h], cx
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+217Ah]
		sub	ax, 48h	; 'H'
		mov	[bx+217Ah], ax

loc_1946C:				; CODE XREF: sub_191F0+1CBj
					; sub_191F0+1DDj
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	byte ptr [si+21ADh], 0Ah
		jz	short loc_1947E
		jmp	loc_1958C
; ---------------------------------------------------------------------------

loc_1947E:				; CODE XREF: sub_191F0+289j
		mov	al, [si+21B2h]
		sub	al, 3
		mov	[si+21AEh], al
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	byte ptr [bx+21AAh], 10h
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	al, [bx+21BFh]
		inc	al
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+21AEh], cl
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	byte ptr [si+21A9h], 1
		sbb	ax, ax
		neg	ax
		mov	[bx+21A9h], al
		cmp	byte ptr [si+21A9h], 0
		jnz	short loc_194EC
		mov	ax, 18h
		jmp	short loc_194EF
; ---------------------------------------------------------------------------
		align 2

loc_194EC:				; CODE XREF: sub_191F0+2F4j
		mov	ax, 0FFE8h

loc_194EF:				; CODE XREF: sub_191F0+2F9j
		add	ax, [si+2178h]
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+2178h], cx
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+217Ah]
		sub	ax, 18h
		mov	[bx+217Ah], ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		cmp	[bp+arg_0], 1
		sbb	di, di
		neg	di
		shl	di, 1
		mov	ax, [di+2A2Ch]
		mov	cl, 6
		shl	ax, cl
		add	ax, 40h	; '@'
		cwd
		xor	ax, dx
		sub	ax, dx
		mov	cx, 2
		sar	ax, cl
		xor	ax, dx
		sub	ax, dx
		sub	[bx+2180h], ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	word ptr [bx+2180h], 0
		jg	short loc_19571
		mov	word_2D014, 0Ah

loc_19571:				; CODE XREF: sub_191F0+379j
		mov	ax, 2
		push	ax
		push	[bp+arg_0]
		call	sub_15C20
		add	sp, 4
		mov	ax, 0Dh
		push	ax
		call	sub_15BEE
		add	sp, 2

loc_1958C:				; CODE XREF: sub_191F0+28Bj
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	byte ptr [si+21ADh], 0Ah
		jb	short loc_195DE
		cmp	byte ptr [si+21ADh], 10h
		jnb	short loc_195DE
		inc	byte ptr [si+21AFh]
		mov	al, [si+21AFh]
		cmp	[si+21B0h], al
		ja	short loc_195C3
		mov	byte ptr [si+21AFh], 0
		mov	al, [si+21B2h]
		cmp	[si+21AEh], al
		jnb	short loc_195C3
		inc	byte ptr [si+21AEh]

loc_195C3:				; CODE XREF: sub_191F0+3BEj
					; sub_191F0+3CDj
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		mov	al, [bx+21ADh]
		sub	ah, ah
		and	ax, 1
		mov	cl, 3
		shl	ax, cl
		sub	ax, 4
		mov	word_2D392, ax

loc_195DE:				; CODE XREF: sub_191F0+3A9j
					; sub_191F0+3B0j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	byte ptr [si+21ADh], 10h
		jz	short loc_195F0
		jmp	loc_196D6
; ---------------------------------------------------------------------------

loc_195F0:				; CODE XREF: sub_191F0+3FBj
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	byte ptr [bx+21AAh], 9
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	di, ax
		mov	ax, [di+218Eh]
		cwd
		mov	cx, 3
		idiv	cx
		mov	[bx+217Eh], ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	al, [bx+21BFh]
		inc	al
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+21AEh], cl
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	byte ptr [si+21A9h], 1
		sbb	ax, ax
		neg	ax
		mov	[bx+21A9h], al
		cmp	byte ptr [si+21A9h], 0
		jnz	short loc_1967C
		mov	ax, 18h
		jmp	short loc_1967F
; ---------------------------------------------------------------------------

loc_1967C:				; CODE XREF: sub_191F0+485j
		mov	ax, 0FFE8h

loc_1967F:				; CODE XREF: sub_191F0+48Aj
		add	ax, [si+2178h]
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+2178h], cx
		cmp	byte ptr [si+21A9h], 0
		jnz	short loc_196A4
		mov	ax, 10h
		jmp	short loc_196A7
; ---------------------------------------------------------------------------

loc_196A4:				; CODE XREF: sub_191F0+4ADj
		mov	ax, 0FFF0h

loc_196A7:				; CODE XREF: sub_191F0+4B2j
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+217Ch], cx
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+217Ah]
		sub	ax, 20h	; ' '
		mov	[bx+217Ah], ax

loc_196D6:				; CODE XREF: sub_191F0+3FDj
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	byte ptr [si+21ADh], 11h
		jnz	short loc_1974B
		mov	byte ptr [si+21A8h], 0
		push	[bp+arg_0]
		call	sub_21EF8
		add	sp, 2
		and	byte ptr [si+2178h], 0F7h
		cmp	byte ptr [si+21A9h], 0
		jnz	short loc_19706
		mov	ax, 8
		jmp	short loc_19709
; ---------------------------------------------------------------------------

loc_19706:				; CODE XREF: sub_191F0+50Fj
		mov	ax, 0FFF8h

loc_19709:				; CODE XREF: sub_191F0+514j
		mov	[si+217Ch], ax
		mov	ax, [si+218Eh]
		cwd
		sub	ax, dx
		sar	ax, 1
		mov	[si+217Eh], ax
		mov	byte ptr [si+21A8h], 0
		mov	byte ptr [si+21B0h], 2
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21ADh], 0
		mov	byte ptr [si+21AAh], 0Dh
		mov	al, [si+21B8h]
		mov	[si+21B1h], al
		mov	al, [si+21B9h]
		mov	[si+21B2h], al
		mov	al, [si+21B1h]
		mov	[si+21AEh], al

loc_1974B:				; CODE XREF: sub_191F0+4F3j
		mov	ax, [bp+var_2]
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_191F0	endp

seg003		ends

; ===========================================================================

; Segment type:	Pure code
seg004		segment	byte public 'CODE' use16
		assume cs:seg004
		;org 4
		assume es:nothing, ss:nothing, ds:seg026, fs:nothing, gs:nothing

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_19754	proc far		; CODE XREF: sub_19C18+10Ap
					; sub_19F8C+2E6p

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+2184h], 0Eh
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ACh], 1
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 2
		mov	byte ptr [si+21B1h], 10h
		mov	byte ptr [si+21B2h], 13h
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 0Ch
		pop	si
		pop	bp
		retf
sub_19754	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_19796	proc far		; CODE XREF: sub_19B7C+92p
					; sub_19C18+101p ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+2184h], 0Eh
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ACh], 1
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 2
		mov	byte ptr [si+21B1h], 14h
		mov	byte ptr [si+21B2h], 14h
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 0Ch
		pop	si
		pop	bp
		retf
sub_19796	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_197D8	proc far		; CODE XREF: sub_19DF4+85p
					; sub_19F8C+1FCp

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+2184h], 0Eh
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ACh], 1
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 3
		mov	byte ptr [si+21B1h], 1Dh
		mov	byte ptr [si+21B2h], 1Dh
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 0Fh
		pop	si
		pop	bp
		retf
sub_197D8	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1981A	proc far		; CODE XREF: sub_19EEC+19p
					; sub_1A31C+9Ap

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+2184h], 0Eh
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ACh], 3
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 3
		mov	byte ptr [si+21B1h], 26h ; '&'
		mov	byte ptr [si+21B2h], 26h ; '&'
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 0Dh
		mov	byte ptr [si+21ADh], 0Ah
		pop	si
		pop	bp
		retf
sub_1981A	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_19860	proc far		; CODE XREF: sub_19EEC+32p
					; sub_1A31C+90p

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+2184h], 1Dh
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ACh], 3
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 1
		mov	byte ptr [si+21B1h], 27h ; '''
		mov	byte ptr [si+21B2h], 27h ; '''
		mov	byte ptr [si+21ADh], 0Ah
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 0Dh
		pop	si
		pop	bp
		retf
sub_19860	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_198A6	proc far		; CODE XREF: sub_19F2C+19p
					; sub_1A3C6+9Ap

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21ACh], 3
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 1
		mov	byte ptr [si+21B1h], 26h ; '&'
		mov	byte ptr [si+21B2h], 26h ; '&'
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21ADh], 0Ah
		mov	byte ptr [si+21AAh], 0Eh
		pop	si
		pop	bp
		retf
sub_198A6	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_198E6	proc far		; CODE XREF: sub_19F2C+32p
					; sub_1A3C6+90p

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+2184h], 1Dh
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ACh], 3
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 2
		mov	byte ptr [si+21B1h], 16h
		mov	byte ptr [si+21B2h], 19h
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21ADh], 0Fh
		mov	byte ptr [si+21AAh], 0Eh
		pop	si
		pop	bp
		retf
sub_198E6	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1992C	proc far		; CODE XREF: sub_19C18+140p
					; sub_19F8C+2BEp

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21ACh], 1
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 2
		mov	byte ptr [si+21B1h], 15h
		mov	byte ptr [si+21B2h], 19h
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 0Ch
		pop	si
		pop	bp
		retf
sub_1992C	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_19968	proc far		; CODE XREF: sub_19C18+137p
					; sub_19F8C+222p

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21ACh], 1
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 2
		mov	byte ptr [si+21B1h], 1Ah
		mov	byte ptr [si+21B2h], 1Ch
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 0Ch
		pop	si
		pop	bp
		retf
sub_19968	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_199A4	proc far		; CODE XREF: sub_19DF4+9Ep
					; sub_19F8C+294p

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+2184h], 1Dh
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ACh], 2
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 2
		mov	byte ptr [si+21B1h], 1Eh
		mov	byte ptr [si+21B2h], 24h ; '$'
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 0Fh
		pop	si
		pop	bp
		retf
sub_199A4	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_199E6	proc far		; CODE XREF: sub_19C18+B0p
					; sub_19DF4+62p ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+217Ch], 0
		mov	byte ptr [si+21AAh], 3
		mov	al, [si+21B8h]
		mov	[si+21B1h], al
		mov	al, [si+21B9h]
		mov	[si+21B2h], al
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	ax, [si+218Eh]
		mov	[si+217Eh], ax
		mov	byte ptr [si+21B0h], 4
		pop	si
		pop	bp
		retf
sub_199E6	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_19A26	proc far		; CODE XREF: sub_19C18+BAp
					; sub_19DF4+6Cp ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21AAh], 2
		mov	al, [si+21B8h]
		mov	[si+21B1h], al
		mov	al, [si+21B9h]
		mov	[si+21B2h], al
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	ax, [si+218Eh]
		mov	[si+217Eh], ax
		mov	byte ptr [si+21B0h], 4
		pop	si
		pop	bp
		retf
sub_19A26	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_19A60	proc far		; CODE XREF: sub_19C18+1B3p
					; sub_19DF4+D0p ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	word ptr [si+21A6h], 0
		jnz	short loc_19AB9
		mov	word ptr [si+218Ah], 1
		sub	ax, ax
		push	ax
		push	[bp+arg_0]
		call	sub_15C20
		add	sp, 4
		mov	word ptr [si+2184h], 20h ; ' '
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ADh], 0
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 1
		mov	byte ptr [si+21B1h], 28h ; '('
		mov	byte ptr [si+21B2h], 2Eh ; '.'
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 17h

loc_19AB9:				; CODE XREF: sub_19A60+11j
		pop	si
		pop	bp
		retf
sub_19A60	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_19ABC	proc far		; CODE XREF: sub_19C18+1CCp
					; sub_19DF4+E9p ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 1
		push	ax
		push	[bp+arg_0]
		call	sub_15C20
		add	sp, 4
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+218Ah], 1
		mov	word ptr [si+2184h], 20h ; ' '
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ADh], 0
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 1
		mov	byte ptr [si+21B1h], 32h ; '2'
		mov	byte ptr [si+21B2h], 3Ah ; ':'
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 14h
		pop	si
		pop	bp
		retf
sub_19ABC	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_19B12	proc far		; CODE XREF: sub_19C18+19Ap
					; sub_19DF4+B7p ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 2
		push	ax
		push	[bp+arg_0]
		call	sub_15C20
		add	sp, 4
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+218Ah], 1
		mov	word ptr [si+2184h], 20h ; ' '
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ADh], 0
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 2
		mov	byte ptr [si+21B1h], 3Bh ; ';'
		mov	byte ptr [si+21B2h], 3Fh ; '?'
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 16h
		cmp	byte ptr [si+21A9h], 1
		jnz	short loc_19B72
		mov	ax, 10h
		jmp	short loc_19B75
; ---------------------------------------------------------------------------
		align 2

loc_19B72:				; CODE XREF: sub_19B12+58j
		mov	ax, 0FFF0h

loc_19B75:				; CODE XREF: sub_19B12+5Dj
		mov	[si+217Ch], ax
		pop	si
		pop	bp
		retf
sub_19B12	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_19B7C	proc far		; CODE XREF: sub_19C18+181p
					; sub_19F8C+1B6p

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		test	byte ptr [bx+21ABh], 4
		jnz	short loc_19C0A
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	ax, cx
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21B0h], 6
		mov	byte ptr [si+21AFh], 0
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 4
		cmp	al, 4
		jnz	short loc_19BC1
		mov	byte ptr [si+21A9h], 1

loc_19BC1:				; CODE XREF: sub_19B7C+3Ej
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 8
		cmp	al, 8
		jnz	short loc_19BDD
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		mov	byte ptr [bx+21A9h], 0

loc_19BDD:				; CODE XREF: sub_19B7C+52j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+217Ch], 0
		mov	byte ptr [si+21ADh], 0
		mov	byte ptr [si+21B1h], 40h ; '@'
		mov	byte ptr [si+21B2h], 44h ; 'D'
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 15h
		pop	si
		pop	bp
		retf
; ---------------------------------------------------------------------------

loc_19C0A:				; CODE XREF: sub_19B7C+18j
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_19796
		add	sp, 2
		pop	si
		pop	bp
		retf
sub_19B7C	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_19C18	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_6		= byte ptr -6
var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 6
		push	di
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+218Ah], 0
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+2178h]
		cmp	[bx+2178h], ax
		jle	short loc_19C5A
		mov	ax, cx
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		jmp	short loc_19C6E
; ---------------------------------------------------------------------------

loc_19C5A:				; CODE XREF: sub_19C18+2Dj
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, cx
		imul	[bp+arg_0]

loc_19C6E:				; CODE XREF: sub_19C18+40j
		mov	di, ax
		mov	ax, [di+2178h]
		sub	ax, [bx+2178h]
		mov	[bp+var_2], ax
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		mov	[bp+var_6], al
		and	al, 1
		cmp	al, 1
		jnz	short loc_19CD8
		mov	al, [bp+var_6]
		and	al, 4
		cmp	al, 4
		jnz	short loc_19C9C
		mov	ax, 1
		jmp	short loc_19C9E
; ---------------------------------------------------------------------------
		align 2

loc_19C9C:				; CODE XREF: sub_19C18+7Cj
		sub	ax, ax

loc_19C9E:				; CODE XREF: sub_19C18+81j
		imul	word ptr [si+2194h]
		mov	cl, [bp+var_6]
		and	cl, 8
		mov	di, ax
		cmp	cl, 8
		jnz	short loc_19CB4
		mov	ax, 1
		jmp	short loc_19CB6
; ---------------------------------------------------------------------------

loc_19CB4:				; CODE XREF: sub_19C18+95j
		sub	ax, ax

loc_19CB6:				; CODE XREF: sub_19C18+9Aj
		imul	word ptr [si+2194h]
		sub	ax, di
		mov	[si+217Ch], ax
		or	ax, ax
		jnz	short loc_19CCE
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_199E6
		jmp	short loc_19CD5
; ---------------------------------------------------------------------------
		align 2

loc_19CCE:				; CODE XREF: sub_19C18+AAj
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_19A26

loc_19CD5:				; CODE XREF: sub_19C18+B3j
		add	sp, 2

loc_19CD8:				; CODE XREF: sub_19C18+73j
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 2
		cmp	al, 2
		jnz	short loc_19CF2
		push	[bp+arg_0]
		call	sub_21F72
		add	sp, 2

loc_19CF2:				; CODE XREF: sub_19C18+CDj
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 10h
		cmp	al, 10h
		jnz	short loc_19D28
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		mov	word ptr [bx+2184h], 0Eh
		cmp	[bp+var_2], 30h	; '0'
		jge	short loc_19D1E
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_19796
		jmp	short loc_19D25
; ---------------------------------------------------------------------------

loc_19D1E:				; CODE XREF: sub_19C18+FBj
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_19754

loc_19D25:				; CODE XREF: sub_19C18+104j
		add	sp, 2

loc_19D28:				; CODE XREF: sub_19C18+E7j
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 20h
		cmp	al, 20h	; ' '
		jnz	short loc_19D5E
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		mov	word ptr [bx+2184h], 1Dh
		cmp	[bp+var_2], 30h	; '0'
		jge	short loc_19D54
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_19968
		jmp	short loc_19D5B
; ---------------------------------------------------------------------------

loc_19D54:				; CODE XREF: sub_19C18+131j
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1992C

loc_19D5B:				; CODE XREF: sub_19C18+13Aj
		add	sp, 2

loc_19D5E:				; CODE XREF: sub_19C18+11Dj
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		mov	[bp+var_6], al
		test	[bp+var_6], 0Ch
		jz	short loc_19D9F
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		test	byte ptr [bx+21ABh], 2
		jnz	short loc_19D9F
		mov	al, [bp+var_6]
		and	al, 10h
		cmp	al, 10h
		jnz	short loc_19D9F
		cmp	[bp+var_2], 20h	; ' '
		jge	short loc_19D9F
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_19B7C
		add	sp, 2

loc_19D9F:				; CODE XREF: sub_19C18+156j
					; sub_19C18+16Cj ...
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1A8FA
		add	sp, 2
		cmp	ax, 1
		jnz	short loc_19DB8
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_19B12
		add	sp, 2

loc_19DB8:				; CODE XREF: sub_19C18+194j
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1A9BC
		add	sp, 2
		cmp	ax, 1
		jnz	short loc_19DD1
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_19A60
		add	sp, 2

loc_19DD1:				; CODE XREF: sub_19C18+1ADj
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1A83E
		add	sp, 2
		cmp	ax, 1
		jnz	short loc_19DEA
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_19ABC
		add	sp, 2

loc_19DEA:				; CODE XREF: sub_19C18+1C6j
		mov	ax, [bp+var_4]
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_19C18	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_19DF4	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_4		= byte ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 4
		push	di
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+218Ah], 0
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		mov	[bp+var_4], al
		and	al, 1
		cmp	al, 1
		jnz	short loc_19E66
		mov	al, [bp+var_4]
		and	al, 4
		cmp	al, 4
		jnz	short loc_19E2A
		mov	ax, 1
		jmp	short loc_19E2C
; ---------------------------------------------------------------------------

loc_19E2A:				; CODE XREF: sub_19DF4+2Fj
		sub	ax, ax

loc_19E2C:				; CODE XREF: sub_19DF4+34j
		imul	word ptr [si+2194h]
		mov	cl, [bp+var_4]
		and	cl, 8
		mov	di, ax
		cmp	cl, 8
		jnz	short loc_19E42
		mov	ax, 1
		jmp	short loc_19E44
; ---------------------------------------------------------------------------

loc_19E42:				; CODE XREF: sub_19DF4+47j
		sub	ax, ax

loc_19E44:				; CODE XREF: sub_19DF4+4Cj
		imul	word ptr [si+2194h]
		sub	ax, di
		mov	[si+217Ch], ax
		or	ax, ax
		jnz	short loc_19E5C
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_199E6
		jmp	short loc_19E63
; ---------------------------------------------------------------------------
		align 2

loc_19E5C:				; CODE XREF: sub_19DF4+5Cj
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_19A26

loc_19E63:				; CODE XREF: sub_19DF4+65j
		add	sp, 2

loc_19E66:				; CODE XREF: sub_19DF4+26j
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 10h
		cmp	al, 10h
		jnz	short loc_19E7F
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_197D8
		add	sp, 2

loc_19E7F:				; CODE XREF: sub_19DF4+7Fj
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 20h
		cmp	al, 20h	; ' '
		jnz	short loc_19E98
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_199A4
		add	sp, 2

loc_19E98:				; CODE XREF: sub_19DF4+98j
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1A8FA
		add	sp, 2
		cmp	ax, 1
		jnz	short loc_19EB1
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_19B12
		add	sp, 2

loc_19EB1:				; CODE XREF: sub_19DF4+B1j
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1A9BC
		add	sp, 2
		cmp	ax, 1
		jnz	short loc_19ECA
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_19A60
		add	sp, 2

loc_19ECA:				; CODE XREF: sub_19DF4+CAj
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1A83E
		add	sp, 2
		cmp	ax, 1
		jnz	short loc_19EE3
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_19ABC
		add	sp, 2

loc_19EE3:				; CODE XREF: sub_19DF4+E3j
		mov	ax, [bp+var_2]
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_19DF4	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_19EEC	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 2
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 10h
		cmp	al, 10h
		jnz	short loc_19F0B
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1981A
		add	sp, 2

loc_19F0B:				; CODE XREF: sub_19EEC+13j
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 20h
		cmp	al, 20h	; ' '
		jnz	short loc_19F24
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_19860
		add	sp, 2

loc_19F24:				; CODE XREF: sub_19EEC+2Cj
		mov	ax, [bp+var_2]
		mov	sp, bp
		pop	bp
		retf
sub_19EEC	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_19F2C	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 2
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 10h
		cmp	al, 10h
		jnz	short loc_19F4B
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_198A6
		add	sp, 2

loc_19F4B:				; CODE XREF: sub_19F2C+13j
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 20h
		cmp	al, 20h	; ' '
		jnz	short loc_19F64
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_198E6
		add	sp, 2

loc_19F64:				; CODE XREF: sub_19F2C+2Cj
		mov	ax, [bp+var_2]
		mov	sp, bp
		pop	bp
		retf
sub_19F2C	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_19F6C	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_19C18
		add	sp, 2
		pop	bp
		retf
sub_19F6C	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_19F7C	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_19DF4
		add	sp, 2
		pop	bp
		retf
sub_19F7C	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_19F8C	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_8		= word ptr -8
var_6		= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 8
		push	di
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+218Ah], 0
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+2178h]
		cmp	[bx+2178h], ax
		jle	short loc_19FCE
		mov	ax, cx
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		jmp	short loc_19FE2
; ---------------------------------------------------------------------------

loc_19FCE:				; CODE XREF: sub_19F8C+2Dj
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, cx
		imul	[bp+arg_0]

loc_19FE2:				; CODE XREF: sub_19F8C+40j
		mov	di, ax
		mov	ax, [di+2178h]
		sub	ax, [bx+2178h]
		mov	[bp+var_6], ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+2178h]
		cmp	[bx+2178h], ax
		jle	short loc_1A00E
		mov	ax, 1
		jmp	short loc_1A011
; ---------------------------------------------------------------------------
		align 2

loc_1A00E:				; CODE XREF: sub_19F8C+7Aj
		mov	ax, 0FFFFh

loc_1A011:				; CODE XREF: sub_19F8C+7Fj
		mov	[bp+var_4], ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+2178h]
		cmp	[bx+2178h], ax
		jle	short loc_1A032
		mov	ax, 0FFFFh
		jmp	short loc_1A035
; ---------------------------------------------------------------------------

loc_1A032:				; CODE XREF: sub_19F8C+9Fj
		mov	ax, 1

loc_1A035:				; CODE XREF: sub_19F8C+A4j
		mov	[bp+var_2], ax
		mov	byte ptr [si+21ADh], 0
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	byte ptr [bx+21ACh], 0
		jnz	short loc_1A056
		jmp	loc_1A0DA
; ---------------------------------------------------------------------------

loc_1A056:				; CODE XREF: sub_19F8C+C5j
		call	sub_1525A
		sub	ah, ah
		and	ax, 7
		cmp	ax, word_2A9F4
		jnb	short loc_1A0DA
		push	[bp+arg_0]
		call	sub_22252
		add	sp, 2
		cmp	ax, 1
		jz	short loc_1A079
		jmp	loc_1A312
; ---------------------------------------------------------------------------

loc_1A079:				; CODE XREF: sub_19F8C+E8j
		cmp	word_2A9F4, 1
		jnz	short loc_1A083
		jmp	loc_1A312
; ---------------------------------------------------------------------------

loc_1A083:				; CODE XREF: sub_19F8C+F2j
		call	sub_1525A
		sub	ah, ah
		and	ax, 7
		cmp	ax, word_2A9F4
		jnb	short loc_1A0BA
		call	sub_1525A
		sub	ah, ah
		and	ax, 7
		cmp	ax, word_2A9F4
		jb	short loc_1A0A6
		jmp	loc_1A312
; ---------------------------------------------------------------------------

loc_1A0A6:				; CODE XREF: sub_19F8C+115j
					; sub_19F8C+2DEj
		mov	ax, [si+2194h]
		imul	[bp+var_4]

loc_1A0AD:				; CODE XREF: sub_19F8C+1F5j
		mov	[si+217Ch], ax
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_19A26
		jmp	short loc_1A0D4
; ---------------------------------------------------------------------------

loc_1A0BA:				; CODE XREF: sub_19F8C+105j
		call	sub_1525A
		sub	ah, ah
		and	ax, 7
		cmp	ax, word_2A9F4
		jb	short loc_1A0CD
		jmp	loc_1A312
; ---------------------------------------------------------------------------

loc_1A0CD:				; CODE XREF: sub_19F8C+13Cj
					; sub_19F8C+33Cj
					; DATA XREF: ...
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_19A60

loc_1A0D4:				; CODE XREF: sub_19F8C+12Cj
					; sub_19F8C+1AFj ...
		add	sp, 2
		jmp	loc_1A312
; ---------------------------------------------------------------------------

loc_1A0DA:				; CODE XREF: sub_19F8C+C7j
					; sub_19F8C+D8j
		call	sub_1525A
		sub	ah, ah
		and	ax, 7
		cmp	ax, word_2A9F4
		jb	short loc_1A0ED
		jmp	loc_1A2F6
; ---------------------------------------------------------------------------

loc_1A0ED:				; CODE XREF: sub_19F8C+15Cj
		cmp	[bp+var_6], 30h	; '0'
		jl	short loc_1A0F6
		jmp	loc_1A1CE
; ---------------------------------------------------------------------------

loc_1A0F6:				; CODE XREF: sub_19F8C+165j
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	al, [bx+21ABh]
		sub	ah, ah
		or	ax, ax
		jz	short loc_1A11E
		cmp	ax, 1
		jz	short loc_1A152
		cmp	ax, 2
		jz	short loc_1A18E
		jmp	loc_1A312
; ---------------------------------------------------------------------------
		db 2 dup(90h)
; ---------------------------------------------------------------------------

loc_1A11E:				; CODE XREF: sub_19F8C+181j
		call	sub_1525A
		and	ax, 3
		jz	short loc_1A134
		cmp	ax, 1
		jz	short loc_1A13E
		cmp	ax, 2
		jz	short loc_1A148
		jmp	short loc_1A166
; ---------------------------------------------------------------------------

loc_1A134:				; CODE XREF: sub_19F8C+19Aj
					; sub_19F8C+27Cj ...
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_19ABC
		jmp	short loc_1A0D4
; ---------------------------------------------------------------------------
		align 2

loc_1A13E:				; CODE XREF: sub_19F8C+19Fj
					; sub_19F8C+1D3j
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_19B7C
		jmp	short loc_1A0D4
; ---------------------------------------------------------------------------
		align 2

loc_1A148:				; CODE XREF: sub_19F8C+1A4j
					; sub_19F8C+20Fj
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_19796
		jmp	short loc_1A0D4
; ---------------------------------------------------------------------------
		align 2

loc_1A152:				; CODE XREF: sub_19F8C+186j
		call	sub_1525A
		and	ax, 3
		jz	short loc_1A172
		cmp	ax, 1
		jz	short loc_1A13E
		cmp	ax, 2
		jz	short loc_1A184

loc_1A166:				; CODE XREF: sub_19F8C+1A6j
					; sub_19F8C+28Cj
		cmp	ax, 3
		jnz	short loc_1A16E
		jmp	loc_1A21C
; ---------------------------------------------------------------------------

loc_1A16E:				; CODE XREF: sub_19F8C+1DDj
		jmp	loc_1A312
; ---------------------------------------------------------------------------
		align 2

loc_1A172:				; CODE XREF: sub_19F8C+1CEj
					; sub_19F8C+284j ...
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	ax, [si+2194h]
		imul	[bp+var_2]
		jmp	loc_1A0AD
; ---------------------------------------------------------------------------

loc_1A184:				; CODE XREF: sub_19F8C+1D8j
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_197D8
		jmp	loc_1A0D4
; ---------------------------------------------------------------------------

loc_1A18E:				; CODE XREF: sub_19F8C+18Bj
		call	sub_1525A
		and	ax, 3
		jz	short loc_1A1AA
		cmp	ax, 1
		jz	short loc_1A148
		cmp	ax, 2
		jz	short loc_1A1B4
		cmp	ax, 3
		jz	short loc_1A1BE
		jmp	loc_1A312
; ---------------------------------------------------------------------------

loc_1A1AA:				; CODE XREF: sub_19F8C+20Aj
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_19968
		jmp	loc_1A0D4
; ---------------------------------------------------------------------------

loc_1A1B4:				; CODE XREF: sub_19F8C+214j
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_199E6
		jmp	loc_1A0D4
; ---------------------------------------------------------------------------

loc_1A1BE:				; CODE XREF: sub_19F8C+219j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		mov	byte ptr [bx+21ADh], 2
		jmp	loc_1A312
; ---------------------------------------------------------------------------

loc_1A1CE:				; CODE XREF: sub_19F8C+167j
		cmp	[bp+var_6], 40h	; '@'
		jl	short loc_1A1D7
		jmp	loc_1A278
; ---------------------------------------------------------------------------

loc_1A1D7:				; CODE XREF: sub_19F8C+246j
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	al, [bx+21ABh]
		sub	ah, ah
		or	ax, ax
		jz	short loc_1A1FE
		cmp	ax, 1
		jz	short loc_1A226
		cmp	ax, 2
		jz	short loc_1A250
		jmp	loc_1A312
; ---------------------------------------------------------------------------
		align 2

loc_1A1FE:				; CODE XREF: sub_19F8C+262j
		call	sub_1525A
		and	ax, 3
		jnz	short loc_1A20B
		jmp	loc_1A134
; ---------------------------------------------------------------------------

loc_1A20B:				; CODE XREF: sub_19F8C+27Aj
		cmp	ax, 1
		jnz	short loc_1A213
		jmp	loc_1A172
; ---------------------------------------------------------------------------

loc_1A213:				; CODE XREF: sub_19F8C+282j
					; sub_19F8C+2D4j
		cmp	ax, 2
		jz	short loc_1A26E
		jmp	loc_1A166
; ---------------------------------------------------------------------------
		align 2

loc_1A21C:				; CODE XREF: sub_19F8C+1DFj
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_199A4
		jmp	loc_1A0D4
; ---------------------------------------------------------------------------

loc_1A226:				; CODE XREF: sub_19F8C+267j
		call	sub_1525A
		and	ax, 3
		jz	short loc_1A262
		cmp	ax, 1
		jz	short loc_1A246
		cmp	ax, 2
		jnz	short loc_1A23D
		jmp	loc_1A172
; ---------------------------------------------------------------------------

loc_1A23D:				; CODE XREF: sub_19F8C+2ACj
		cmp	ax, 3
		jz	short loc_1A26E
		jmp	loc_1A312
; ---------------------------------------------------------------------------
		align 2

loc_1A246:				; CODE XREF: sub_19F8C+2A7j
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1992C
		jmp	loc_1A0D4
; ---------------------------------------------------------------------------

loc_1A250:				; CODE XREF: sub_19F8C+26Cj
		call	sub_1525A
		and	ax, 3
		jnz	short loc_1A25D
		jmp	loc_1A134
; ---------------------------------------------------------------------------

loc_1A25D:				; CODE XREF: sub_19F8C+2CCj
		cmp	ax, 1
		jnz	short loc_1A213

loc_1A262:				; CODE XREF: sub_19F8C+2A2j
					; sub_19F8C+305j ...
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		jmp	loc_1A0A6
; ---------------------------------------------------------------------------
		align 2

loc_1A26E:				; CODE XREF: sub_19F8C+28Aj
					; sub_19F8C+2B4j
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_19754
		jmp	loc_1A0D4
; ---------------------------------------------------------------------------

loc_1A278:				; CODE XREF: sub_19F8C+248j
		cmp	[bp+var_6], 60h	; '`'
		jge	short loc_1A2B8
		call	sub_1525A
		and	ax, 7
		cmp	ax, 7
		jbe	short loc_1A28E
		jmp	loc_1A312
; ---------------------------------------------------------------------------

loc_1A28E:				; CODE XREF: sub_19F8C+2FDj
		add	ax, ax
		xchg	ax, bx
		jmp	cs:off_1A2A6[bx]

loc_1A296:				; CODE XREF: sub_19F8C+33Cj
					; DATA XREF: sub_19F8C+31Eo ...
		cmp	[bp+var_6], 60h	; '`'
		jg	short loc_1A2E0

loc_1A29C:				; CODE XREF: sub_19F8C+352j
		cmp	[bp+var_6], 50h	; 'P'
		jge	short loc_1A302

loc_1A2A2:				; CODE XREF: sub_19F8C+374j
		mov	al, 2
		jmp	short loc_1A304
; ---------------------------------------------------------------------------
off_1A2A6	dw offset loc_1A262	; DATA XREF: sub_19F8C+305r
		dw offset loc_1A2D0
		dw offset loc_1A296
		dw offset loc_1A296
		dw offset loc_1A296
		dw offset loc_1A296
		dw offset loc_1A296
		dw offset loc_1A2F6
; ---------------------------------------------------------------------------
		jmp	short loc_1A312
; ---------------------------------------------------------------------------

loc_1A2B8:				; CODE XREF: sub_19F8C+2F0j
		call	sub_1525A
		and	ax, 7
		cmp	ax, 7
		ja	short loc_1A312
		add	ax, ax
		xchg	ax, bx
		jmp	cs:off_1A2E4[bx]
; ---------------------------------------------------------------------------
		jmp	short loc_1A262
; ---------------------------------------------------------------------------
		align 2

loc_1A2D0:				; CODE XREF: sub_19F8C+305j
					; sub_19F8C+33Cj
					; DATA XREF: ...
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_19B12
		jmp	loc_1A0D4
; ---------------------------------------------------------------------------

loc_1A2DA:				; CODE XREF: sub_19F8C+33Cj
					; DATA XREF: sub_19F8C+35Eo
		cmp	[bp+var_6], 60h	; '`'
		jle	short loc_1A29C

loc_1A2E0:				; CODE XREF: sub_19F8C+30Ej
					; sub_19F8C+36Ej
		mov	al, 1
		jmp	short loc_1A304
; ---------------------------------------------------------------------------
off_1A2E4	dw offset loc_1A262	; DATA XREF: sub_19F8C+33Cr
		dw offset loc_1A0CD
		dw offset loc_1A2D0
		dw offset loc_1A2DA
		dw offset loc_1A2F6
		dw offset loc_1A296
		dw offset loc_1A296
		dw offset loc_1A296
; ---------------------------------------------------------------------------
		jmp	short loc_1A312
; ---------------------------------------------------------------------------

loc_1A2F6:				; CODE XREF: sub_19F8C+15Ej
					; sub_19F8C+305j ...
		cmp	[bp+var_6], 60h	; '`'
		jg	short loc_1A2E0
		cmp	[bp+var_6], 50h	; 'P'
		jl	short loc_1A2A2

loc_1A302:				; CODE XREF: sub_19F8C+314j
		sub	al, al

loc_1A304:				; CODE XREF: sub_19F8C+318j
					; sub_19F8C+356j
		mov	cx, ax
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		mov	[bx+21ADh], cl

loc_1A312:				; CODE XREF: sub_19F8C+EAj
					; sub_19F8C+F4j ...
		mov	ax, [bp+var_8]
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_19F8C	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1A31C	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 4
		push	di
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+2178h]
		cmp	[bx+2178h], ax
		jle	short loc_1A358
		mov	ax, cx
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		jmp	short loc_1A36C
; ---------------------------------------------------------------------------

loc_1A358:				; CODE XREF: sub_1A31C+27j
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, cx
		imul	[bp+arg_0]

loc_1A36C:				; CODE XREF: sub_1A31C+3Aj
		mov	di, ax
		mov	ax, [di+2178h]
		sub	ax, [bx+2178h]
		mov	[bp+var_2], ax
		call	sub_1525A
		sub	ah, ah
		and	ax, 7
		cmp	ax, word_2A9F4
		jnb	short loc_1A3BC
		cmp	[bp+var_2], 50h	; 'P'
		jge	short loc_1A3BC
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+217Ah]
		cmp	[bx+217Ah], ax
		jle	short loc_1A3B2
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_19860
		jmp	short loc_1A3B9
; ---------------------------------------------------------------------------
		align 2

loc_1A3B2:				; CODE XREF: sub_1A31C+8Aj
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1981A

loc_1A3B9:				; CODE XREF: sub_1A31C+93j
		add	sp, 2

loc_1A3BC:				; CODE XREF: sub_1A31C+6Bj
					; sub_1A31C+71j
		mov	ax, [bp+var_4]
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_1A31C	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1A3C6	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 4
		push	di
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+2178h]
		cmp	[bx+2178h], ax
		jle	short loc_1A402
		mov	ax, cx
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		jmp	short loc_1A416
; ---------------------------------------------------------------------------

loc_1A402:				; CODE XREF: sub_1A3C6+27j
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, cx
		imul	[bp+arg_0]

loc_1A416:				; CODE XREF: sub_1A3C6+3Aj
		mov	di, ax
		mov	ax, [di+2178h]
		sub	ax, [bx+2178h]
		mov	[bp+var_2], ax
		call	sub_1525A
		sub	ah, ah
		and	ax, 7
		cmp	ax, word_2A9F4
		jnb	short loc_1A466
		cmp	[bp+var_2], 50h	; 'P'
		jge	short loc_1A466
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+217Ah]
		cmp	[bx+217Ah], ax
		jge	short loc_1A45C
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_198E6
		jmp	short loc_1A463
; ---------------------------------------------------------------------------
		align 2

loc_1A45C:				; CODE XREF: sub_1A3C6+8Aj
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_198A6

loc_1A463:				; CODE XREF: sub_1A3C6+93j
		add	sp, 2

loc_1A466:				; CODE XREF: sub_1A3C6+6Bj
					; sub_1A3C6+71j
		mov	ax, [bp+var_4]
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_1A3C6	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1A470	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 4
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	al, [si+21ADh]
		sub	ah, ah
		mov	[bp+var_4], ax
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_19F8C
		add	sp, 2
		mov	[bp+var_2], ax
		cmp	byte ptr [si+21AAh], 4
		jnz	short loc_1A4A3
		mov	al, byte ptr [bp+var_4]
		mov	[si+21ADh], al

loc_1A4A3:				; CODE XREF: sub_1A470+2Aj
		mov	ax, [bp+var_2]
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_1A470	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1A4AC	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 4
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	al, [si+21ADh]
		sub	ah, ah
		mov	[bp+var_4], ax
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_19F8C
		add	sp, 2
		mov	[bp+var_2], ax
		cmp	byte ptr [si+21AAh], 5
		jnz	short loc_1A4DF
		mov	al, byte ptr [bp+var_4]
		mov	[si+21ADh], al

loc_1A4DF:				; CODE XREF: sub_1A4AC+2Aj
		mov	ax, [bp+var_2]
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_1A4AC	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1A4E8	proc far		; CODE XREF: sub_11230+1B1P
					; sub_11230+1C4P ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	ax, 14h
		imul	[bp+arg_0]
		mov	cl, 3
		shl	ax, cl
		add	ax, 0F0h ; '�'
		mov	[si+2178h], ax
		mov	word ptr [si+217Ah], 9Eh ; '�'
		mov	word ptr [si+217Ch], 0
		mov	word ptr [si+217Ch], 0
		mov	word ptr [si+217Eh], 0
		mov	word ptr [si+2182h], 0
		mov	word ptr [si+2180h], 0C9h ; '�'
		mov	word ptr [si+2184h], 0
		mov	word ptr [si+2188h], 0
		mov	word ptr [si+218Ah], 0
		mov	word ptr [si+218Ch], 0
		mov	word ptr [si+219Ah], 0
		mov	word ptr [si+219Ch], 0
		mov	word ptr [si+219Eh], 0
		mov	word ptr [si+21A0h], 0
		mov	word ptr [si+21A2h], 0
		mov	word ptr [si+21A4h], 0
		mov	word ptr [si+21A6h], 0
		mov	word ptr [si+218Eh], 0FFBAh
		mov	word ptr [si+2190h], 0Bh
		mov	word ptr [si+2192h], 2
		mov	word ptr [si+2194h], 8
		mov	word ptr [si+2196h], 4
		mov	byte ptr [si+21A8h], 0
		mov	word ptr [si+2198h], 0
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	[si+21A9h], al
		mov	byte ptr [si+21AAh], 0
		mov	byte ptr [si+21ABh], 0
		mov	byte ptr [si+21ACh], 0
		mov	byte ptr [si+21ADh], 0
		mov	byte ptr [si+21AEh], 6
		mov	byte ptr [si+21AFh], 0
		mov	[si+21B0h], cl
		mov	byte ptr [si+21B1h], 0
		mov	byte ptr [si+21B2h], 0
		mov	byte ptr [si+21B3h], 0Ah
		mov	byte ptr [si+21B4h], 0Ch
		mov	byte ptr [si+21B5h], 6
		mov	byte ptr [si+21B6h], 9
		mov	byte ptr [si+21B7h], 0Fh
		mov	byte ptr [si+21B8h], 0Dh
		mov	byte ptr [si+21B9h], 0Eh
		mov	byte ptr [si+21BAh], 49h ; 'I'
		mov	byte ptr [si+21BBh], 4Ah ; 'J'
		mov	byte ptr [si+21BCh], 1
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21BDh], 0
		mov	byte ptr [si+21BEh], 25h ; '%'
		mov	byte ptr [si+21BFh], 2
		mov	[si+21C0h], cl
		mov	byte ptr [si+21C1h], 5
		mov	byte ptr [si+21C2h], 4Bh ; 'K'
		pop	si
		pop	bp
		retf
sub_1A4E8	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1A626	proc far		; CODE XREF: sub_12822+34P
					; sub_12822+52P ...

var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	si
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	word ptr [bx+2180h], 0
		jle	short loc_1A64D
		cmp	word_2CEE8, 0
		jz	short loc_1A64D
		jmp	loc_1A6FB
; ---------------------------------------------------------------------------

loc_1A64D:				; CODE XREF: sub_1A626+1Bj
					; sub_1A626+22j
		mov	si, [bp+arg_0]
		shl	si, 1
		mov	word ptr [si+2514h], 0
		mov	word ptr [si+2448h], 0
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	byte ptr [bx+21AAh], 0
		jnz	short loc_1A683
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	byte ptr [bx+21AAh], 0Ah
		jz	short loc_1A6B2

loc_1A683:				; CODE XREF: sub_1A626+45j
		cmp	word_2CEE8, 0
		jnz	short loc_1A6FB
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+2180h]
		cmp	[bx+2180h], ax
		jge	short loc_1A6FB
		cmp	byte ptr [si+21AAh], 0
		jnz	short loc_1A6FB

loc_1A6B2:				; CODE XREF: sub_1A626+5Bj
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21AAh], 12h
		mov	byte ptr [si+21B0h], 4
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21ADh], 14h
		mov	byte ptr [si+21AEh], 45h ; 'E'
		mov	byte ptr [si+21B1h], 48h ; 'H'
		mov	byte ptr [si+21B2h], 48h ; 'H'
		mov	ax, 4
		push	ax
		push	[bp+arg_0]
		call	sub_15C20
		add	sp, 4
		mov	bx, [bp+arg_0]
		shl	bx, 1
		inc	word ptr [bx+2646h]
		mov	word_2A9E4, 1

loc_1A6FB:				; CODE XREF: sub_1A626+24j
					; sub_1A626+62j ...
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	ax, [bx+2514h]
		mov	[bp+var_2], ax
		push	[bp+arg_0]
		call	sub_107EA
		add	sp, 2
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	word ptr [si+2186h], 0
		jnz	short loc_1A748
		push	[bp+arg_0]
		mov	bl, [si+21AAh]
		sub	bh, bh
		shl	bx, 1
		shl	bx, 1
		call	off_2C08E[bx]
		add	sp, 2
		push	[bp+arg_0]
		mov	bl, [si+21AAh]
		sub	bh, bh
		shl	bx, 1
		shl	bx, 1
		call	off_2C14E[bx]
		jmp	short loc_1A78B
; ---------------------------------------------------------------------------

loc_1A748:				; CODE XREF: sub_1A626+F9j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		add	si, 21AAh
		push	[bp+arg_0]
		mov	bl, [si]
		sub	bh, bh
		shl	bx, 1
		shl	bx, 1
		call	off_2C0EE[bx]
		add	sp, 2
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	word ptr [bx+2180h], 0
		jle	short loc_1A78E
		push	[bp+arg_0]
		mov	bl, [si]
		sub	bh, bh
		shl	bx, 1
		shl	bx, 1
		call	off_2C1B2[bx]

loc_1A78B:				; CODE XREF: sub_1A626+120j
		add	sp, 2

loc_1A78E:				; CODE XREF: sub_1A626+154j
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1A7C2
		add	sp, 2
		push	[bp+arg_0]
		call	sub_233A6
		add	sp, 2
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		mov	ax, [bp+var_2]
		mov	[bx+2198h], ax
		push	[bp+arg_0]
		call	sub_2398E
		add	sp, 2
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_1A626	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1A7C2	proc far		; CODE XREF: sub_1A626+16Cp

var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	di
		push	si
		mov	[bp+var_2], 0
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	word ptr [si+21A6h], 1
		jnz	short loc_1A834
		inc	word ptr [si+219Ah]
		cmp	word ptr [si+219Ah], 31h ; '1'
		jle	short loc_1A7EF
		mov	word ptr [si+219Ah], 2Fh ; '/'

loc_1A7EF:				; CODE XREF: sub_1A7C2+25j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	word ptr [si+219Ch], 0
		jnz	short loc_1A804
		mov	ax, 0FFF0h
		jmp	short loc_1A807
; ---------------------------------------------------------------------------
		align 2

loc_1A804:				; CODE XREF: sub_1A7C2+3Aj
		mov	ax, 10h

loc_1A807:				; CODE XREF: sub_1A7C2+3Fj
		add	[si+21A2h], ax
		mov	di, word_2A9DC
		mov	cl, 3
		shl	di, cl
		lea	ax, [di-20h]
		cmp	[si+21A2h], ax
		jl	short loc_1A826
		lea	ax, [di+160h]
		cmp	[si+21A2h], ax
		jle	short loc_1A834

loc_1A826:				; CODE XREF: sub_1A7C2+58j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		mov	word ptr [bx+21A6h], 0

loc_1A834:				; CODE XREF: sub_1A7C2+1Aj
					; sub_1A7C2+62j
		mov	ax, [bp+var_2]
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_1A7C2	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1A83E	proc far		; CODE XREF: sub_19C18+1BDp
					; sub_19DF4+DAp

var_E		= word ptr -0Eh
var_C		= word ptr -0Ch
var_A		= word ptr -0Ah
var_8		= word ptr -8
var_6		= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 10h
		push	di
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	byte ptr [bx+21A9h], 0
		jnz	short loc_1A85A
		mov	ax, 4
		jmp	short loc_1A85D
; ---------------------------------------------------------------------------

loc_1A85A:				; CODE XREF: sub_1A83E+15j
		mov	ax, 8

loc_1A85D:				; CODE XREF: sub_1A83E+1Aj
		mov	[bp+var_2], ax
		mov	[bp+var_6], 0
		mov	[bp+var_A], 0
		mov	ax, word_2D012
		mov	[bp+var_8], ax
		dec	[bp+var_8]
		jns	short loc_1A87A
		mov	[bp+var_8], 1Dh

loc_1A87A:				; CODE XREF: sub_1A83E+35j
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	ax, [bp+var_2]
		add	ax, 12h
		cmp	[bx+2448h], ax
		jnz	short loc_1A8F1
		mov	[bp+var_6], 1
		mov	[bp+var_4], 0Fh
		mov	ax, 3Ch	; '<'
		imul	[bp+arg_0]
		mov	[bp+var_C], ax
		mov	[bp+var_E], ax
		mov	si, 0Fh
		mov	di, [bp+var_2]
		mov	dx, [bp+var_6]
		mov	cx, [bp+var_8]

loc_1A8AD:				; CODE XREF: sub_1A83E+A1j
		mov	bx, cx
		shl	bx, 1
		add	bx, [bp+var_E]
		cmp	word ptr [bx+254Ah], 2
		jnz	short loc_1A8C3
		cmp	dx, 1
		jnz	short loc_1A8C3
		mov	dx, 2

loc_1A8C3:				; CODE XREF: sub_1A83E+7Bj
					; sub_1A83E+80j
		mov	bx, cx
		shl	bx, 1
		add	bx, [bp+var_C]
		cmp	[bx+254Ah], di
		jnz	short loc_1A8D8
		cmp	dx, 2
		jnz	short loc_1A8D8
		mov	dx, 3

loc_1A8D8:				; CODE XREF: sub_1A83E+90j
					; sub_1A83E+95j
		dec	cx
		jns	short loc_1A8DE
		mov	cx, 1Dh

loc_1A8DE:				; CODE XREF: sub_1A83E+9Bj
		dec	si
		jnz	short loc_1A8AD
		mov	[bp+var_6], dx
		mov	[bp+var_8], cx
		cmp	dx, 3
		jnz	short loc_1A8F1
		mov	[bp+var_A], 1

loc_1A8F1:				; CODE XREF: sub_1A83E+4Bj
					; sub_1A83E+ACj
		mov	ax, [bp+var_A]
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_1A83E	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1A8FA	proc far		; CODE XREF: sub_19C18+18Bp
					; sub_19DF4+A8p ...

var_10		= word ptr -10h
var_E		= word ptr -0Eh
var_A		= word ptr -0Ah
var_8		= word ptr -8
var_6		= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 12h
		push	di
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	byte ptr [bx+21A9h], 1
		jnz	short loc_1A916
		mov	ax, 4
		jmp	short loc_1A919
; ---------------------------------------------------------------------------

loc_1A916:				; CODE XREF: sub_1A8FA+15j
		mov	ax, 8

loc_1A919:				; CODE XREF: sub_1A8FA+1Aj
		mov	[bp+var_2], ax
		mov	[bp+var_6], 0
		mov	[bp+var_A], 0
		mov	ax, word_2D012
		mov	[bp+var_8], ax
		dec	[bp+var_8]
		jns	short loc_1A936
		mov	[bp+var_8], 1Dh

loc_1A936:				; CODE XREF: sub_1A8FA+35j
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	ax, [bp+var_2]
		add	ax, 20h	; ' '
		cmp	[bx+2448h], ax
		jnz	short loc_1A9B2
		mov	[bp+var_6], 1
		mov	[bp+var_4], 0Fh
		mov	ax, 3Ch	; '<'
		imul	[bp+arg_0]
		mov	di, ax
		mov	ax, [bp+var_2]
		add	ax, 2
		mov	[bp+var_E], ax
		mov	[bp+var_10], di
		mov	si, 0Fh
		mov	dx, [bp+var_6]
		mov	cx, [bp+var_8]

loc_1A96E:				; CODE XREF: sub_1A8FA+A6j
		mov	bx, cx
		shl	bx, 1
		add	bx, [bp+var_10]
		mov	ax, [bp+var_E]
		cmp	[bx+254Ah], ax
		jnz	short loc_1A986
		cmp	dx, 1
		jnz	short loc_1A986
		mov	dx, 2

loc_1A986:				; CODE XREF: sub_1A8FA+82j
					; sub_1A8FA+87j
		mov	bx, cx
		shl	bx, 1
		cmp	word ptr [bx+di+254Ah],	2
		jnz	short loc_1A999
		cmp	dx, 2
		jnz	short loc_1A999
		mov	dx, 3

loc_1A999:				; CODE XREF: sub_1A8FA+95j
					; sub_1A8FA+9Aj
		dec	cx
		jns	short loc_1A99F
		mov	cx, 1Dh

loc_1A99F:				; CODE XREF: sub_1A8FA+A0j
		dec	si
		jnz	short loc_1A96E
		mov	[bp+var_6], dx
		mov	[bp+var_8], cx
		cmp	dx, 3
		jnz	short loc_1A9B2
		mov	[bp+var_A], 1

loc_1A9B2:				; CODE XREF: sub_1A8FA+4Bj
					; sub_1A8FA+B1j
		mov	ax, [bp+var_A]
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_1A8FA	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1A9BC	proc far		; CODE XREF: sub_19C18+1A4p
					; sub_19DF4+C1p ...

var_10		= word ptr -10h
var_E		= word ptr -0Eh
var_A		= word ptr -0Ah
var_8		= word ptr -8
var_6		= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 12h
		push	di
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	byte ptr [bx+21A9h], 0
		jnz	short loc_1A9D8
		mov	ax, 4
		jmp	short loc_1A9DB
; ---------------------------------------------------------------------------

loc_1A9D8:				; CODE XREF: sub_1A9BC+15j
		mov	ax, 8

loc_1A9DB:				; CODE XREF: sub_1A9BC+1Aj
		mov	[bp+var_2], ax
		mov	[bp+var_6], 0
		mov	[bp+var_A], 0
		mov	ax, word_2D012
		mov	[bp+var_8], ax
		dec	[bp+var_8]
		jns	short loc_1A9F8
		mov	[bp+var_8], 1Dh

loc_1A9F8:				; CODE XREF: sub_1A9BC+35j
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	ax, [bp+var_2]
		add	ax, 10h
		cmp	[bx+2448h], ax
		jnz	short loc_1AA74
		mov	[bp+var_6], 1
		mov	[bp+var_4], 0Fh
		mov	ax, 3Ch	; '<'
		imul	[bp+arg_0]
		mov	di, ax
		mov	ax, [bp+var_2]
		add	ax, 2
		mov	[bp+var_E], ax
		mov	[bp+var_10], di
		mov	si, 0Fh
		mov	dx, [bp+var_6]
		mov	cx, [bp+var_8]

loc_1AA30:				; CODE XREF: sub_1A9BC+A6j
		mov	bx, cx
		shl	bx, 1
		add	bx, [bp+var_10]
		mov	ax, [bp+var_E]
		cmp	[bx+254Ah], ax
		jnz	short loc_1AA48
		cmp	dx, 1
		jnz	short loc_1AA48
		mov	dx, 2

loc_1AA48:				; CODE XREF: sub_1A9BC+82j
					; sub_1A9BC+87j
		mov	bx, cx
		shl	bx, 1
		cmp	word ptr [bx+di+254Ah],	2
		jnz	short loc_1AA5B
		cmp	dx, 2
		jnz	short loc_1AA5B
		mov	dx, 3

loc_1AA5B:				; CODE XREF: sub_1A9BC+95j
					; sub_1A9BC+9Aj
		dec	cx
		jns	short loc_1AA61
		mov	cx, 1Dh

loc_1AA61:				; CODE XREF: sub_1A9BC+A0j
		dec	si
		jnz	short loc_1AA30
		mov	[bp+var_6], dx
		mov	[bp+var_8], cx
		cmp	dx, 3
		jnz	short loc_1AA74
		mov	[bp+var_A], 1

loc_1AA74:				; CODE XREF: sub_1A9BC+4Bj
					; sub_1A9BC+B1j
		mov	ax, [bp+var_A]
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_1A9BC	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1AA7E	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21ABh], 0
		inc	byte ptr [si+21AFh]
		mov	al, [si+21AFh]
		cmp	[si+21B0h], al
		ja	short loc_1AB0D
		mov	byte ptr [si+21AFh], 0
		inc	byte ptr [si+21AEh]
		cmp	byte ptr [si+21AEh], 2Ch ; ','
		jnz	short loc_1AAF9
		cmp	byte ptr [si+21A9h], 0
		jnz	short loc_1AABC
		mov	ax, 0FFF8h
		jmp	short loc_1AABF
; ---------------------------------------------------------------------------

loc_1AABC:				; CODE XREF: sub_1AA7E+37j
		mov	ax, 8

loc_1AABF:				; CODE XREF: sub_1AA7E+3Cj
		add	ax, [si+2178h]
		mov	[si+21A2h], ax
		mov	ax, [si+217Ah]
		sub	ax, 24h	; '$'
		mov	[si+21A4h], ax
		mov	al, [si+21A9h]
		sub	ah, ah
		mov	[si+219Ch], ax
		mov	word ptr [si+219Ah], 2Fh ; '/'
		mov	word ptr [si+21A6h], 1
		mov	word ptr [si+219Eh], 0
		mov	word ptr [si+21A0h], 0
		mov	byte ptr [si+21B0h], 3

loc_1AAF9:				; CODE XREF: sub_1AA7E+30j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	byte ptr [si+21AEh], 2Dh ; '-'
		jnz	short loc_1AB0D
		mov	byte ptr [si+21B0h], 2

loc_1AB0D:				; CODE XREF: sub_1AA7E+20j
					; sub_1AA7E+88j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	byte ptr [bx+21AEh], 2Eh ; '.'
		jbe	short loc_1AB27
		push	[bp+arg_0]
		call	sub_21F4C
		add	sp, 2

loc_1AB27:				; CODE XREF: sub_1AA7E+9Cj
		mov	ax, [bp+var_2]
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_1AA7E	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1AB30	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	byte ptr [si+21ADh], 0
		jnz	short loc_1AB4A
		sub	al, al
		jmp	short loc_1AB4C
; ---------------------------------------------------------------------------

loc_1AB4A:				; CODE XREF: sub_1AB30+14j
		mov	al, 2

loc_1AB4C:				; CODE XREF: sub_1AB30+18j
		mov	[si+21ABh], al
		mov	byte ptr [si+21ACh], 1
		cmp	byte ptr [si+21ADh], 0
		jnz	short loc_1AB98
		inc	byte ptr [si+21AFh]
		mov	al, [si+21AFh]
		cmp	[si+21B0h], al
		ja	short loc_1AB98
		mov	byte ptr [si+21AFh], 0
		inc	byte ptr [si+21AEh]
		cmp	byte ptr [si+21AEh], 37h ; '7'
		jnz	short loc_1AB98
		cmp	byte ptr [si+21A9h], 1
		jnz	short loc_1AB86
		mov	ax, 10h
		jmp	short loc_1AB89
; ---------------------------------------------------------------------------

loc_1AB86:				; CODE XREF: sub_1AB30+4Fj
		mov	ax, 0FFF0h

loc_1AB89:				; CODE XREF: sub_1AB30+54j
		mov	[si+217Ch], ax
		mov	word ptr [si+217Eh], 0FFE8h
		mov	byte ptr [si+21ADh], 1

loc_1AB98:				; CODE XREF: sub_1AB30+2Aj
					; sub_1AB30+38j ...
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	byte ptr [si+21ADh], 1
		jnz	short loc_1ABCF
		mov	ax, [si+217Ch]
		add	[si+2178h], ax
		mov	ax, [si+217Eh]
		add	[si+217Ah], ax
		cmp	word ptr [si+217Ah], 60h ; '`'
		jg	short loc_1ABCF
		mov	byte ptr [si+21ADh], 2
		mov	word ptr [si+217Eh], 0FFE0h
		mov	word ptr [si+217Ch], 0

loc_1ABCF:				; CODE XREF: sub_1AB30+75j
					; sub_1AB30+8Cj
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	byte ptr [si+21ADh], 2
		jnz	short loc_1AC11
		push	[bp+arg_0]
		call	sub_2274C
		add	sp, 2
		cmp	word ptr [si+217Eh], 0
		jl	short loc_1AC11
		mov	byte ptr [si+21ADh], 3
		inc	byte ptr [si+21AEh]
		sub	word ptr [si+217Ah], 20h ; ' '
		cmp	byte ptr [si+21A9h], 1
		jnz	short loc_1AC0A
		mov	ax, 10h
		jmp	short loc_1AC0D
; ---------------------------------------------------------------------------

loc_1AC0A:				; CODE XREF: sub_1AB30+D3j
		mov	ax, 0FFF0h

loc_1AC0D:				; CODE XREF: sub_1AB30+D8j
		add	[si+2178h], ax

loc_1AC11:				; CODE XREF: sub_1AB30+ACj
					; sub_1AB30+BEj
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	byte ptr [si+21ADh], 3
		jnz	short loc_1AC4E
		push	[bp+arg_0]
		call	sub_2274C
		add	sp, 2
		inc	byte ptr [si+21AFh]
		mov	al, [si+21AFh]
		cmp	[si+21B0h], al
		ja	short loc_1AC4E
		mov	byte ptr [si+21AFh], 0
		inc	byte ptr [si+21AEh]
		cmp	byte ptr [si+21AEh], 39h ; '9'
		jnz	short loc_1AC4E
		mov	byte ptr [si+21ADh], 4

loc_1AC4E:				; CODE XREF: sub_1AB30+EEj
					; sub_1AB30+107j ...
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	byte ptr [si+21ADh], 4
		jnz	short loc_1AC90
		push	[bp+arg_0]
		call	sub_2274C
		add	sp, 2
		cmp	ax, 1
		jnz	short loc_1AC90
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 1
		mov	byte ptr [si+21B1h], 39h ; '9'
		mov	byte ptr [si+21AEh], 39h ; '9'
		mov	byte ptr [si+21B2h], 3Ah ; ':'
		mov	byte ptr [si+21AAh], 0Ch
		mov	byte ptr [si+21ADh], 3

loc_1AC90:				; CODE XREF: sub_1AB30+12Bj
					; sub_1AB30+13Bj
		mov	ax, [bp+var_2]
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_1AB30	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1AC98	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 4
		push	di
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+2178h]
		cmp	[bx+2178h], ax
		jle	short loc_1ACD4
		mov	ax, cx
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		jmp	short loc_1ACE8
; ---------------------------------------------------------------------------

loc_1ACD4:				; CODE XREF: sub_1AC98+27j
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, cx
		imul	[bp+arg_0]

loc_1ACE8:				; CODE XREF: sub_1AC98+3Aj
		mov	di, ax
		mov	ax, [di+2178h]
		sub	ax, [bx+2178h]
		mov	[bp+var_2], ax
		mov	byte ptr [si+21ABh], 0
		mov	byte ptr [si+21ACh], 1
		inc	byte ptr [si+21ADh]
		mov	ax, [si+217Ch]
		add	[si+2178h], ax
		cmp	[bp+var_2], 6
		jle	short loc_1AD16
		mov	byte ptr [si+21ADh], 2

loc_1AD16:				; CODE XREF: sub_1AC98+77j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	byte ptr [si+21ADh], 1
		jbe	short loc_1AD8E
		inc	byte ptr [si+21AFh]
		mov	al, [si+21AFh]
		cmp	[si+21B0h], al
		ja	short loc_1AD8E
		mov	byte ptr [si+21AFh], 0
		inc	byte ptr [si+21AEh]
		cmp	byte ptr [si+21AEh], 3Eh ; '>'
		jnz	short loc_1AD48
		mov	byte ptr [si+21B0h], 2

loc_1AD48:				; CODE XREF: sub_1AC98+A9j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	byte ptr [si+21AEh], 3Dh ; '='
		jnz	short loc_1AD5C
		mov	byte ptr [si+21B0h], 3

loc_1AD5C:				; CODE XREF: sub_1AC98+BDj
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	byte ptr [si+21AEh], 3Eh ; '>'
		jnz	short loc_1AD8E
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 1
		mov	byte ptr [si+21B1h], 3Eh ; '>'
		mov	byte ptr [si+21AEh], 3Eh ; '>'
		mov	byte ptr [si+21B2h], 3Fh ; '?'
		mov	byte ptr [si+21AAh], 0Ch
		mov	byte ptr [si+21ADh], 3

loc_1AD8E:				; CODE XREF: sub_1AC98+8Bj
					; sub_1AC98+99j ...
		mov	ax, [bp+var_4]
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_1AC98	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1AD98	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	di
		push	si
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21A8h], 1
		inc	byte ptr [si+21ADh]
		cmp	byte ptr [si+21ADh], 1
		jz	short loc_1ADC1
		jmp	loc_1AE57
; ---------------------------------------------------------------------------

loc_1ADC1:				; CODE XREF: sub_1AD98+24j
		inc	byte ptr [si+21AEh]
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	byte ptr [bx+21AAh], 10h
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		cmp	byte ptr [si+21A9h], 1
		sbb	ax, ax
		neg	ax
		mov	[bx+21A9h], al
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	al, [bx+21BDh]
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+21AEh], cl
		cmp	byte ptr [si+21A9h], 0
		jnz	short loc_1AE24
		mov	ax, 0FFE0h
		jmp	short loc_1AE27
; ---------------------------------------------------------------------------
		align 2

loc_1AE24:				; CODE XREF: sub_1AD98+84j
		mov	ax, 20h	; ' '

loc_1AE27:				; CODE XREF: sub_1AD98+89j
		add	ax, [si+2178h]
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+2178h], cx
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+217Ah]
		mov	[bx+217Ah], ax

loc_1AE57:				; CODE XREF: sub_1AD98+26j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	byte ptr [si+21ADh], 6
		jz	short loc_1AE69
		jmp	loc_1AEFD
; ---------------------------------------------------------------------------

loc_1AE69:				; CODE XREF: sub_1AD98+CCj
		inc	byte ptr [si+21AEh]
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	byte ptr [bx+21AAh], 10h
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	al, [si+21A9h]
		or	al, 2
		mov	[bx+21A9h], al
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	al, [bx+21BFh]
		inc	al
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+21AEh], cl
		cmp	byte ptr [si+21A9h], 0
		jnz	short loc_1AECA
		mov	ax, 0FFD0h
		jmp	short loc_1AECD
; ---------------------------------------------------------------------------

loc_1AECA:				; CODE XREF: sub_1AD98+12Bj
		mov	ax, 30h	; '0'

loc_1AECD:				; CODE XREF: sub_1AD98+130j
		add	ax, [si+2178h]
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+2178h], cx
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+217Ah]
		mov	[bx+217Ah], ax

loc_1AEFD:				; CODE XREF: sub_1AD98+CEj
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	byte ptr [si+21ADh], 8
		jz	short loc_1AF0F
		jmp	loc_1AFA4
; ---------------------------------------------------------------------------

loc_1AF0F:				; CODE XREF: sub_1AD98+172j
		inc	byte ptr [si+21AEh]
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	byte ptr [bx+21AAh], 10h
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	al, [si+21A9h]
		or	al, 2
		mov	[bx+21A9h], al
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	al, [bx+21BDh]
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+21AEh], cl
		cmp	byte ptr [si+21A9h], 0
		jnz	short loc_1AF6E
		mov	ax, 38h	; '8'
		jmp	short loc_1AF71
; ---------------------------------------------------------------------------

loc_1AF6E:				; CODE XREF: sub_1AD98+1CFj
		mov	ax, 0FFC8h

loc_1AF71:				; CODE XREF: sub_1AD98+1D4j
		add	ax, [si+2178h]
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+2178h], cx
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+217Ah]
		sub	ax, 10h
		mov	[bx+217Ah], ax

loc_1AFA4:				; CODE XREF: sub_1AD98+174j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	byte ptr [si+21ADh], 0Ah
		jz	short loc_1AFB6
		jmp	loc_1B0D1
; ---------------------------------------------------------------------------

loc_1AFB6:				; CODE XREF: sub_1AD98+219j
		mov	ax, 3
		push	ax
		push	[bp+arg_0]
		call	sub_15C20
		add	sp, 4
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	byte ptr [bx+21AAh], 9
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	al, [bx+21BFh]
		inc	al
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+21AEh], cl
		cmp	byte ptr [si+21A9h], 0
		jnz	short loc_1B00C
		mov	ax, 5Ch	; '\'
		jmp	short loc_1B00F
; ---------------------------------------------------------------------------

loc_1B00C:				; CODE XREF: sub_1AD98+26Dj
		mov	ax, 0FFA4h

loc_1B00F:				; CODE XREF: sub_1AD98+272j
		add	ax, [si+2178h]
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+2178h], cx
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+217Ah]
		sub	ax, 20h	; ' '
		mov	[bx+217Ah], ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	di, ax
		mov	ax, [di+218Eh]
		cwd
		xor	ax, dx
		sub	ax, dx
		mov	cx, 2
		sar	ax, cl
		xor	ax, dx
		sub	ax, dx
		mov	[bx+217Eh], ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	byte ptr [si+21A9h], 1
		sbb	ax, ax
		neg	ax
		mov	[bx+21A9h], al
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		cmp	byte ptr [bx+21A9h], 0
		jnz	short loc_1B0A4
		mov	ax, 0FFE8h
		jmp	short loc_1B0A7
; ---------------------------------------------------------------------------

loc_1B0A4:				; CODE XREF: sub_1AD98+305j
		mov	ax, 18h

loc_1B0A7:				; CODE XREF: sub_1AD98+30Aj
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+217Ch], cx
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	word ptr [bx+218Ch], 30h ; '0'

loc_1B0D1:				; CODE XREF: sub_1AD98+21Bj
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	byte ptr [si+21ADh], 0Eh
		jnz	short loc_1B0E4
		inc	byte ptr [si+21AEh]

loc_1B0E4:				; CODE XREF: sub_1AD98+346j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	byte ptr [si+21ADh], 12h
		jnz	short loc_1B103
		push	[bp+arg_0]
		call	sub_21F4C
		add	sp, 2
		mov	byte ptr [si+21A8h], 0

loc_1B103:				; CODE XREF: sub_1AD98+359j
		mov	ax, [bp+var_2]
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_1AD98	endp

seg004		ends

; ===========================================================================

; Segment type:	Pure code
seg005		segment	byte public 'CODE' use16
		assume cs:seg005
		;org 0Ch
		assume es:nothing, ss:nothing, ds:seg026, fs:nothing, gs:nothing

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1B10C	proc far		; CODE XREF: sub_1B584+A6p
					; sub_1B634+F3p ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+2184h], 19h
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ACh], 1
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 2
		mov	byte ptr [si+21B1h], 28h ; '('
		mov	byte ptr [si+21B2h], 28h ; '('
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 0Ch
		pop	si
		pop	bp
		retf
sub_1B10C	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1B14E	proc far		; CODE XREF: sub_1B634+FCp
					; sub_1B98E+28Dp

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+2184h], 19h
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ACh], 1
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 2
		mov	byte ptr [si+21B1h], 23h ; '#'
		mov	byte ptr [si+21B2h], 27h ; '''
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 0Ch
		pop	si
		pop	bp
		retf
sub_1B14E	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1B190	proc far		; CODE XREF: sub_1B7F4+85p
					; sub_1B98E+1D8p

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+2184h], 19h
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ACh], 1
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 3
		mov	byte ptr [si+21B1h], 29h ; ')'
		mov	byte ptr [si+21B2h], 29h ; ')'
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 0Fh
		pop	si
		pop	bp
		retf
sub_1B190	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1B1D2	proc far		; CODE XREF: sub_1B8EE+19p
					; sub_1BD04+9Ap

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+2184h], 19h
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ACh], 3
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 3
		mov	byte ptr [si+21B1h], 2Ah ; '*'
		mov	byte ptr [si+21B2h], 2Ah ; '*'
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 0Dh
		mov	byte ptr [si+21ADh], 0Ah
		pop	si
		pop	bp
		retf
sub_1B1D2	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1B218	proc far		; CODE XREF: sub_1B92E+19p
					; sub_1BDAE+9Ap

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+2184h], 19h
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ACh], 3
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 1
		mov	byte ptr [si+21B1h], 2Bh ; '+'
		mov	byte ptr [si+21B2h], 2Ch ; ','
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21ADh], 0Ah
		mov	byte ptr [si+21AAh], 0Eh
		pop	si
		pop	bp
		retf
sub_1B218	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1B25E	proc far		; CODE XREF: sub_1B634+11Bp
					; sub_1B98E+190p

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+2184h], 1Eh
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ACh], 1
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 2
		mov	byte ptr [si+21B1h], 16h
		mov	byte ptr [si+21B2h], 18h
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 0Ch
		pop	si
		pop	bp
		retf
sub_1B25E	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1B2A0	proc far		; CODE XREF: sub_1B634+124p
					; sub_1B98E+25Ap

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+2184h], 1Eh
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ACh], 1
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 2
		mov	byte ptr [si+21B1h], 19h
		mov	byte ptr [si+21B2h], 1Bh
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 0Ch
		pop	si
		pop	bp
		retf
sub_1B2A0	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1B2E2	proc far		; CODE XREF: sub_1B7F4+9Ep
					; sub_1B98E+264p

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+2184h], 1Eh
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ACh], 2
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 2
		mov	byte ptr [si+21B1h], 1Ch
		mov	byte ptr [si+21B2h], 1Ch
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 0Fh
		pop	si
		pop	bp
		retf
sub_1B2E2	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1B324	proc far		; CODE XREF: sub_1B8EE+32p
					; sub_1BD04+90p

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+2184h], 1Eh
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ACh], 3
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 1
		mov	byte ptr [si+21B1h], 1Dh
		mov	byte ptr [si+21B2h], 1Eh
		mov	byte ptr [si+21ADh], 0Ah
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 0Dh
		pop	si
		pop	bp
		retf
sub_1B324	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1B36A	proc far		; CODE XREF: sub_1B92E+32p
					; sub_1BDAE+90p

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+2184h], 1Eh
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ACh], 3
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 2
		mov	byte ptr [si+21B1h], 31h ; '1'
		mov	byte ptr [si+21B2h], 32h ; '2'
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21ADh], 0Fh
		mov	byte ptr [si+21AAh], 0Eh
		pop	si
		pop	bp
		retf
sub_1B36A	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1B3B0	proc far		; CODE XREF: sub_1B634+B0p
					; sub_1B7F4+62p ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+217Ch], 0
		mov	byte ptr [si+21B0h], 4
		mov	byte ptr [si+21AAh], 3
		mov	byte ptr [si+21B1h], 4Dh ; 'M'
		mov	byte ptr [si+21B2h], 4Fh ; 'O'
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	ax, [si+218Eh]
		mov	[si+217Eh], ax
		pop	si
		pop	bp
		retf
sub_1B3B0	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1B3EA	proc far		; CODE XREF: sub_1B634+BAp
					; sub_1B7F4+6Cp ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21B0h], 2
		cmp	byte ptr [si+21A9h], 0
		jnz	short loc_1B409
		cmp	word ptr [si+217Ch], 0
		jg	short loc_1B41F

loc_1B409:				; CODE XREF: sub_1B3EA+16j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	byte ptr [si+21A9h], 1
		jnz	short loc_1B438
		cmp	word ptr [si+217Ch], 0
		jge	short loc_1B438

loc_1B41F:				; CODE XREF: sub_1B3EA+1Dj
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21AAh], 2
		mov	byte ptr [si+21B1h], 47h ; 'G'
		mov	byte ptr [si+21B2h], 4Ch ; 'L'
		jmp	short loc_1B44F
; ---------------------------------------------------------------------------

loc_1B438:				; CODE XREF: sub_1B3EA+2Cj
					; sub_1B3EA+33j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21AAh], 2
		mov	byte ptr [si+21B1h], 10h
		mov	byte ptr [si+21B2h], 15h

loc_1B44F:				; CODE XREF: sub_1B3EA+4Cj
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	ax, [si+218Eh]
		mov	[si+217Eh], ax
		pop	si
		pop	bp
		retf
sub_1B3EA	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1B46A	proc far		; CODE XREF: sub_1B634+198p
					; sub_1B7F4+D1p ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		sub	ax, ax
		push	ax
		push	[bp+arg_0]
		call	sub_15C20
		add	sp, 4
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+218Ah], 1
		mov	word ptr [si+2184h], 1Eh
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ADh], 0
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 1
		mov	byte ptr [si+21B1h], 33h ; '3'
		mov	byte ptr [si+21B2h], 3Dh ; '='
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 17h
		pop	si
		pop	bp
		retf
sub_1B46A	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1B4C0	proc far		; CODE XREF: sub_1B634+1B1p
					; sub_1B7F4+EAp ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 1
		push	ax
		push	[bp+arg_0]
		call	sub_15C20
		add	sp, 4
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+218Ah], 1
		mov	word ptr [si+2184h], 1Eh
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ADh], 0
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 1
		mov	byte ptr [si+21B1h], 50h ; 'P'
		mov	byte ptr [si+21B2h], 57h ; 'W'
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 14h
		cmp	byte ptr [si+21A9h], 1
		jnz	short loc_1B520
		mov	ax, 18h
		jmp	short loc_1B523
; ---------------------------------------------------------------------------
		align 2

loc_1B520:				; CODE XREF: sub_1B4C0+58j
		mov	ax, 0FFE8h

loc_1B523:				; CODE XREF: sub_1B4C0+5Dj
		mov	[si+217Ch], ax
		pop	si
		pop	bp
		retf
sub_1B4C0	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1B52A	proc far		; CODE XREF: sub_1B634+17Ep
					; sub_1B7F4+B7p ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+218Ah], 1
		mov	word ptr [si+2184h], 1Eh
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ADh], 0
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 1
		mov	byte ptr [si+21B1h], 42h ; 'B'
		mov	byte ptr [si+21B2h], 46h ; 'F'
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 16h
		cmp	byte ptr [si+21A9h], 1
		jnz	short loc_1B57A
		mov	ax, 8
		jmp	short loc_1B57D
; ---------------------------------------------------------------------------

loc_1B57A:				; CODE XREF: sub_1B52A+49j
		mov	ax, 0FFF8h

loc_1B57D:				; CODE XREF: sub_1B52A+4Ej
		mov	[si+217Ch], ax
		pop	si
		pop	bp
		retf
sub_1B52A	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1B584	proc far		; CODE XREF: sub_1B634+165p
					; sub_1B98E+19Ap

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		test	byte ptr [bx+21ABh], 4
		jz	short loc_1B5A1
		jmp	loc_1B626
; ---------------------------------------------------------------------------

loc_1B5A1:				; CODE XREF: sub_1B584+18j
		mov	ax, 4
		push	ax
		push	[bp+arg_0]
		call	sub_15C20
		add	sp, 4
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21B0h], 6
		mov	byte ptr [si+21AFh], 0
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 4
		cmp	al, 4
		jnz	short loc_1B5DC
		mov	byte ptr [si+21A9h], 1

loc_1B5DC:				; CODE XREF: sub_1B584+51j
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 8
		cmp	al, 8
		jnz	short loc_1B5F8
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		mov	byte ptr [bx+21A9h], 0

loc_1B5F8:				; CODE XREF: sub_1B584+65j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+217Ch], 0
		mov	byte ptr [si+21ADh], 0
		mov	byte ptr [si+21B1h], 3Eh ; '>'
		mov	byte ptr [si+21B2h], 41h ; 'A'
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 15h
		pop	si
		pop	bp
		retf
; ---------------------------------------------------------------------------
		align 2

loc_1B626:				; CODE XREF: sub_1B584+1Aj
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1B10C
		add	sp, 2
		pop	si
		pop	bp
		retf
sub_1B584	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1B634	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_6		= byte ptr -6
var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 6
		push	di
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+218Ah], 0
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+2178h]
		cmp	[bx+2178h], ax
		jle	short loc_1B676
		mov	ax, cx
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		jmp	short loc_1B68A
; ---------------------------------------------------------------------------

loc_1B676:				; CODE XREF: sub_1B634+2Dj
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, cx
		imul	[bp+arg_0]

loc_1B68A:				; CODE XREF: sub_1B634+40j
		mov	di, ax
		mov	ax, [di+2178h]
		sub	ax, [bx+2178h]
		mov	[bp+var_2], ax
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		mov	[bp+var_6], al
		and	al, 1
		cmp	al, 1
		jnz	short loc_1B6F4
		mov	al, [bp+var_6]
		and	al, 4
		cmp	al, 4
		jnz	short loc_1B6B8
		mov	ax, 1
		jmp	short loc_1B6BA
; ---------------------------------------------------------------------------
		align 2

loc_1B6B8:				; CODE XREF: sub_1B634+7Cj
		sub	ax, ax

loc_1B6BA:				; CODE XREF: sub_1B634+81j
		imul	word ptr [si+2194h]
		mov	cl, [bp+var_6]
		and	cl, 8
		mov	di, ax
		cmp	cl, 8
		jnz	short loc_1B6D0
		mov	ax, 1
		jmp	short loc_1B6D2
; ---------------------------------------------------------------------------

loc_1B6D0:				; CODE XREF: sub_1B634+95j
		sub	ax, ax

loc_1B6D2:				; CODE XREF: sub_1B634+9Aj
		imul	word ptr [si+2194h]
		sub	ax, di
		mov	[si+217Ch], ax
		or	ax, ax
		jnz	short loc_1B6EA
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1B3B0
		jmp	short loc_1B6F1
; ---------------------------------------------------------------------------
		align 2

loc_1B6EA:				; CODE XREF: sub_1B634+AAj
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1B3EA

loc_1B6F1:				; CODE XREF: sub_1B634+B3j
		add	sp, 2

loc_1B6F4:				; CODE XREF: sub_1B634+73j
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 2
		cmp	al, 2
		jnz	short loc_1B70E
		push	[bp+arg_0]
		call	sub_21F72
		add	sp, 2

loc_1B70E:				; CODE XREF: sub_1B634+CDj
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 10h
		cmp	al, 10h
		jnz	short loc_1B736
		cmp	[bp+var_2], 30h	; '0'
		jge	short loc_1B72C
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1B10C
		jmp	short loc_1B733
; ---------------------------------------------------------------------------

loc_1B72C:				; CODE XREF: sub_1B634+EDj
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1B14E

loc_1B733:				; CODE XREF: sub_1B634+F6j
		add	sp, 2

loc_1B736:				; CODE XREF: sub_1B634+E7j
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 20h
		cmp	al, 20h	; ' '
		jnz	short loc_1B75E
		cmp	[bp+var_2], 30h	; '0'
		jge	short loc_1B754
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1B25E
		jmp	short loc_1B75B
; ---------------------------------------------------------------------------

loc_1B754:				; CODE XREF: sub_1B634+115j
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1B2A0

loc_1B75B:				; CODE XREF: sub_1B634+11Ej
		add	sp, 2

loc_1B75E:				; CODE XREF: sub_1B634+10Fj
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		mov	[bp+var_6], al
		test	[bp+var_6], 0Ch
		jz	short loc_1B79F
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		test	byte ptr [bx+21ABh], 2
		jnz	short loc_1B79F
		mov	al, [bp+var_6]
		and	al, 10h
		cmp	al, 10h
		jnz	short loc_1B79F
		cmp	[bp+var_2], 20h	; ' '
		jge	short loc_1B79F
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1B584
		add	sp, 2

loc_1B79F:				; CODE XREF: sub_1B634+13Aj
					; sub_1B634+150j ...
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1C26E
		add	sp, 2
		cmp	ax, 1
		jnz	short loc_1B7B8
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1B52A
		add	sp, 2

loc_1B7B8:				; CODE XREF: sub_1B634+178j
		push	[bp+arg_0]
		call	sub_1A9BC
		add	sp, 2
		cmp	ax, 1
		jnz	short loc_1B7D2
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1B46A
		add	sp, 2

loc_1B7D2:				; CODE XREF: sub_1B634+192j
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1C1A6
		add	sp, 2
		cmp	ax, 1
		jnz	short loc_1B7EB
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1B4C0
		add	sp, 2

loc_1B7EB:				; CODE XREF: sub_1B634+1ABj
		mov	ax, [bp+var_4]
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_1B634	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1B7F4	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_4		= byte ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 4
		push	di
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+218Ah], 0
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		mov	[bp+var_4], al
		and	al, 1
		cmp	al, 1
		jnz	short loc_1B866
		mov	al, [bp+var_4]
		and	al, 4
		cmp	al, 4
		jnz	short loc_1B82A
		mov	ax, 1
		jmp	short loc_1B82C
; ---------------------------------------------------------------------------

loc_1B82A:				; CODE XREF: sub_1B7F4+2Fj
		sub	ax, ax

loc_1B82C:				; CODE XREF: sub_1B7F4+34j
		imul	word ptr [si+2194h]
		mov	cl, [bp+var_4]
		and	cl, 8
		mov	di, ax
		cmp	cl, 8
		jnz	short loc_1B842
		mov	ax, 1
		jmp	short loc_1B844
; ---------------------------------------------------------------------------

loc_1B842:				; CODE XREF: sub_1B7F4+47j
		sub	ax, ax

loc_1B844:				; CODE XREF: sub_1B7F4+4Cj
		imul	word ptr [si+2194h]
		sub	ax, di
		mov	[si+217Ch], ax
		or	ax, ax
		jnz	short loc_1B85C
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1B3B0
		jmp	short loc_1B863
; ---------------------------------------------------------------------------
		align 2

loc_1B85C:				; CODE XREF: sub_1B7F4+5Cj
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1B3EA

loc_1B863:				; CODE XREF: sub_1B7F4+65j
		add	sp, 2

loc_1B866:				; CODE XREF: sub_1B7F4+26j
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 10h
		cmp	al, 10h
		jnz	short loc_1B87F
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1B190
		add	sp, 2

loc_1B87F:				; CODE XREF: sub_1B7F4+7Fj
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 20h
		cmp	al, 20h	; ' '
		jnz	short loc_1B898
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1B2E2
		add	sp, 2

loc_1B898:				; CODE XREF: sub_1B7F4+98j
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1C26E
		add	sp, 2
		cmp	ax, 1
		jnz	short loc_1B8B1
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1B52A
		add	sp, 2

loc_1B8B1:				; CODE XREF: sub_1B7F4+B1j
		push	[bp+arg_0]
		call	sub_1A9BC
		add	sp, 2
		cmp	ax, 1
		jnz	short loc_1B8CB
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1B46A
		add	sp, 2

loc_1B8CB:				; CODE XREF: sub_1B7F4+CBj
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1C1A6
		add	sp, 2
		cmp	ax, 1
		jnz	short loc_1B8E4
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1B4C0
		add	sp, 2

loc_1B8E4:				; CODE XREF: sub_1B7F4+E4j
		mov	ax, [bp+var_2]
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_1B7F4	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1B8EE	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 2
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 10h
		cmp	al, 10h
		jnz	short loc_1B90D
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1B1D2
		add	sp, 2

loc_1B90D:				; CODE XREF: sub_1B8EE+13j
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 20h
		cmp	al, 20h	; ' '
		jnz	short loc_1B926
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1B324
		add	sp, 2

loc_1B926:				; CODE XREF: sub_1B8EE+2Cj
		mov	ax, [bp+var_2]
		mov	sp, bp
		pop	bp
		retf
sub_1B8EE	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1B92E	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 2
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 10h
		cmp	al, 10h
		jnz	short loc_1B94D
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1B218
		add	sp, 2

loc_1B94D:				; CODE XREF: sub_1B92E+13j
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 20h
		cmp	al, 20h	; ' '
		jnz	short loc_1B966
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1B36A
		add	sp, 2

loc_1B966:				; CODE XREF: sub_1B92E+2Cj
		mov	ax, [bp+var_2]
		mov	sp, bp
		pop	bp
		retf
sub_1B92E	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1B96E	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1B634
		add	sp, 2
		pop	bp
		retf
sub_1B96E	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1B97E	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1B7F4
		add	sp, 2
		pop	bp
		retf
sub_1B97E	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1B98E	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_8		= word ptr -8
var_6		= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 8
		push	di
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+218Ah], 0
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+2178h]
		cmp	[bx+2178h], ax
		jle	short loc_1B9D0
		mov	ax, cx
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		jmp	short loc_1B9E4
; ---------------------------------------------------------------------------

loc_1B9D0:				; CODE XREF: sub_1B98E+2Dj
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, cx
		imul	[bp+arg_0]

loc_1B9E4:				; CODE XREF: sub_1B98E+40j
		mov	di, ax
		mov	ax, [di+2178h]
		sub	ax, [bx+2178h]
		mov	[bp+var_6], ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+2178h]
		cmp	[bx+2178h], ax
		jle	short loc_1BA10
		mov	ax, 1
		jmp	short loc_1BA13
; ---------------------------------------------------------------------------
		align 2

loc_1BA10:				; CODE XREF: sub_1B98E+7Aj
		mov	ax, 0FFFFh

loc_1BA13:				; CODE XREF: sub_1B98E+7Fj
		mov	[bp+var_4], ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+2178h]
		cmp	[bx+2178h], ax
		jle	short loc_1BA34
		mov	ax, 0FFFFh
		jmp	short loc_1BA37
; ---------------------------------------------------------------------------

loc_1BA34:				; CODE XREF: sub_1B98E+9Fj
		mov	ax, 1

loc_1BA37:				; CODE XREF: sub_1B98E+A4j
		mov	[bp+var_2], ax
		mov	byte ptr [si+21ADh], 0
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	byte ptr [bx+21ACh], 0
		jz	short loc_1BAC0
		call	sub_1525A
		sub	ah, ah
		and	ax, 7
		cmp	ax, word_2A9F4
		jnb	short loc_1BAC0
		push	[bp+arg_0]
		call	sub_22252
		add	sp, 2
		cmp	ax, 1
		jz	short loc_1BA78
		jmp	loc_1BCFA
; ---------------------------------------------------------------------------

loc_1BA78:				; CODE XREF: sub_1B98E+E5j
		cmp	word_2A9F4, 1
		jnz	short loc_1BA82
		jmp	loc_1BCFA
; ---------------------------------------------------------------------------

loc_1BA82:				; CODE XREF: sub_1B98E+EFj
		call	sub_1525A
		sub	ah, ah
		and	ax, 7
		cmp	ax, word_2A9F4
		jb	short loc_1BA95
		jmp	loc_1BCFA
; ---------------------------------------------------------------------------

loc_1BA95:				; CODE XREF: sub_1B98E+102j
		call	sub_1525A
		sub	ah, ah
		and	ax, 7
		cmp	ax, word_2A9F4
		jb	short loc_1BAA8
		jmp	loc_1BCFA
; ---------------------------------------------------------------------------

loc_1BAA8:				; CODE XREF: sub_1B98E+115j
					; sub_1B98E+2DAj
		mov	ax, [si+2194h]
		imul	[bp+var_4]

loc_1BAAF:				; CODE XREF: sub_1B98E+1D1j
		mov	[si+217Ch], ax
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1B3EA

loc_1BABA:				; CODE XREF: sub_1B98E+193j
					; sub_1B98E+19Dj ...
		add	sp, 2
		jmp	loc_1BCFA
; ---------------------------------------------------------------------------

loc_1BAC0:				; CODE XREF: sub_1B98E+C5j
					; sub_1B98E+D5j
		call	sub_1525A
		sub	ah, ah
		and	ax, 7
		cmp	ax, word_2A9F4
		jb	short loc_1BAD3
		jmp	loc_1BCDE
; ---------------------------------------------------------------------------

loc_1BAD3:				; CODE XREF: sub_1B98E+140j
		cmp	[bp+var_6], 30h	; '0'
		jl	short loc_1BADC
		jmp	loc_1BB92
; ---------------------------------------------------------------------------

loc_1BADC:				; CODE XREF: sub_1B98E+149j
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	al, [bx+21ABh]
		sub	ah, ah
		or	ax, ax
		jz	short loc_1BB02
		cmp	ax, 1
		jz	short loc_1BB38
		cmp	ax, 2
		jz	short loc_1BB6C
		jmp	loc_1BCFA
; ---------------------------------------------------------------------------

loc_1BB02:				; CODE XREF: sub_1B98E+165j
		call	sub_1525A
		and	ax, 3
		jz	short loc_1BB1A
		cmp	ax, 1
		jz	short loc_1BB24
		cmp	ax, 2
		jz	short loc_1BB2E
		jmp	loc_1BBDC
; ---------------------------------------------------------------------------
		align 2

loc_1BB1A:				; CODE XREF: sub_1B98E+17Cj
					; sub_1B98E+1E6j
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1B25E
		jmp	short loc_1BABA
; ---------------------------------------------------------------------------
		align 2

loc_1BB24:				; CODE XREF: sub_1B98E+181j
					; sub_1B98E+1B7j
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1B584
		jmp	short loc_1BABA
; ---------------------------------------------------------------------------
		align 2

loc_1BB2E:				; CODE XREF: sub_1B98E+186j
					; sub_1B98E+1EBj
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1B10C
		jmp	short loc_1BABA
; ---------------------------------------------------------------------------
		align 2

loc_1BB38:				; CODE XREF: sub_1B98E+16Aj
		call	sub_1525A
		and	ax, 3
		jz	short loc_1BB50
		cmp	ax, 1
		jz	short loc_1BB24
		cmp	ax, 2
		jz	short loc_1BB62
		jmp	loc_1BBDC
; ---------------------------------------------------------------------------
		align 2

loc_1BB50:				; CODE XREF: sub_1B98E+1B2j
					; sub_1B98E+1F5j ...
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	ax, [si+2194h]
		imul	[bp+var_2]
		jmp	loc_1BAAF
; ---------------------------------------------------------------------------

loc_1BB62:				; CODE XREF: sub_1B98E+1BCj
					; sub_1B98E+274j
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1B190
		jmp	loc_1BABA
; ---------------------------------------------------------------------------

loc_1BB6C:				; CODE XREF: sub_1B98E+16Fj
		call	sub_1525A
		and	ax, 3
		jz	short loc_1BB1A
		cmp	ax, 1
		jz	short loc_1BB2E
		cmp	ax, 2
		jz	short loc_1BB88
		cmp	ax, 3
		jz	short loc_1BB50
		jmp	loc_1BCFA
; ---------------------------------------------------------------------------

loc_1BB88:				; CODE XREF: sub_1B98E+1F0j
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1B3B0
		jmp	loc_1BABA
; ---------------------------------------------------------------------------

loc_1BB92:				; CODE XREF: sub_1B98E+14Bj
		cmp	[bp+var_6], 40h	; '@'
		jl	short loc_1BB9B
		jmp	loc_1BC42
; ---------------------------------------------------------------------------

loc_1BB9B:				; CODE XREF: sub_1B98E+208j
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	al, [bx+21ABh]
		sub	ah, ah
		or	ax, ax
		jz	short loc_1BBC2
		cmp	ax, 1
		jz	short loc_1BBF8
		cmp	ax, 2
		jz	short loc_1BC22
		jmp	loc_1BCFA
; ---------------------------------------------------------------------------
		align 2

loc_1BBC2:				; CODE XREF: sub_1B98E+224j
		call	sub_1525A
		and	ax, 3
		jnz	short loc_1BBCF
		jmp	loc_1BCAE
; ---------------------------------------------------------------------------

loc_1BBCF:				; CODE XREF: sub_1B98E+23Cj
		cmp	ax, 1
		jnz	short loc_1BBD7
		jmp	loc_1BC60
; ---------------------------------------------------------------------------

loc_1BBD7:				; CODE XREF: sub_1B98E+244j
		cmp	ax, 2
		jz	short loc_1BBE4

loc_1BBDC:				; CODE XREF: sub_1B98E+188j
					; sub_1B98E+1BEj
		cmp	ax, 3
		jz	short loc_1BBEE
		jmp	loc_1BCFA
; ---------------------------------------------------------------------------

loc_1BBE4:				; CODE XREF: sub_1B98E+24Cj
					; sub_1B98E+27Aj ...
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1B2A0
		jmp	loc_1BABA
; ---------------------------------------------------------------------------

loc_1BBEE:				; CODE XREF: sub_1B98E+251j
					; sub_1B98E+27Fj
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1B2E2
		jmp	loc_1BABA
; ---------------------------------------------------------------------------

loc_1BBF8:				; CODE XREF: sub_1B98E+229j
		call	sub_1525A
		and	ax, 3
		jnz	short loc_1BC05
		jmp	loc_1BB62
; ---------------------------------------------------------------------------

loc_1BC05:				; CODE XREF: sub_1B98E+272j
		cmp	ax, 1
		jz	short loc_1BBE4
		cmp	ax, 2
		jz	short loc_1BBEE
		cmp	ax, 3
		jz	short loc_1BC17
		jmp	loc_1BCFA
; ---------------------------------------------------------------------------

loc_1BC17:				; CODE XREF: sub_1B98E+284j
					; sub_1B98E+2A9j
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1B14E
		jmp	loc_1BABA
; ---------------------------------------------------------------------------
		align 2

loc_1BC22:				; CODE XREF: sub_1B98E+22Ej
		call	sub_1525A
		and	ax, 3
		jnz	short loc_1BC2F
		jmp	loc_1BB50
; ---------------------------------------------------------------------------

loc_1BC2F:				; CODE XREF: sub_1B98E+29Cj
		cmp	ax, 1
		jz	short loc_1BC60
		cmp	ax, 2
		jz	short loc_1BC17
		cmp	ax, 3
		jz	short loc_1BBE4
		jmp	loc_1BCFA
; ---------------------------------------------------------------------------
		align 2

loc_1BC42:				; CODE XREF: sub_1B98E+20Aj
		cmp	[bp+var_6], 60h	; '`'
		jge	short loc_1BC98
		call	sub_1525A
		and	ax, 7
		cmp	ax, 7
		jbe	short loc_1BC58
		jmp	loc_1BCFA
; ---------------------------------------------------------------------------

loc_1BC58:				; CODE XREF: sub_1B98E+2C5j
		add	ax, ax
		xchg	ax, bx
		jmp	cs:off_1BC86[bx]

loc_1BC60:				; CODE XREF: sub_1B98E+246j
					; sub_1B98E+2A4j
					; DATA XREF: ...
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		jmp	loc_1BAA8
; ---------------------------------------------------------------------------
		align 2

loc_1BC6C:				; CODE XREF: sub_1B98E+2CDj
					; DATA XREF: sub_1B98E+2FAo
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1B46A
		jmp	loc_1BABA
; ---------------------------------------------------------------------------

loc_1BC76:				; CODE XREF: sub_1B98E+2CDj
					; sub_1B98E+31Aj
					; DATA XREF: ...
		cmp	[bp+var_6], 60h	; '`'
		jg	short loc_1BCC8

loc_1BC7C:				; CODE XREF: sub_1B98E+338j
		cmp	[bp+var_6], 50h	; 'P'
		jge	short loc_1BCEA

loc_1BC82:				; CODE XREF: sub_1B98E+35Aj
		mov	al, 2
		jmp	short loc_1BCEC
; ---------------------------------------------------------------------------
off_1BC86	dw offset loc_1BC60	; DATA XREF: sub_1B98E+2CDr
		dw offset loc_1BC6C
		dw offset loc_1BC76
		dw offset loc_1BC76
		dw offset loc_1BC76
		dw offset loc_1BC76
		dw offset loc_1BC76
		dw offset loc_1BCDE
; ---------------------------------------------------------------------------
		jmp	short loc_1BCFA
; ---------------------------------------------------------------------------

loc_1BC98:				; CODE XREF: sub_1B98E+2B8j
		call	sub_1525A
		and	ax, 7
		cmp	ax, 7
		ja	short loc_1BCFA
		add	ax, ax
		xchg	ax, bx
		jmp	cs:off_1BCCC[bx]
; ---------------------------------------------------------------------------
		align 2

loc_1BCAE:				; CODE XREF: sub_1B98E+23Ej
					; sub_1B98E+31Aj
					; DATA XREF: ...
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1B4C0
		jmp	loc_1BABA
; ---------------------------------------------------------------------------

loc_1BCB8:				; CODE XREF: sub_1B98E+31Aj
					; DATA XREF: sub_1B98E+342o
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1B52A
		jmp	loc_1BABA
; ---------------------------------------------------------------------------

loc_1BCC2:				; CODE XREF: sub_1B98E+31Aj
					; DATA XREF: sub_1B98E+344o
		cmp	[bp+var_6], 60h	; '`'
		jle	short loc_1BC7C

loc_1BCC8:				; CODE XREF: sub_1B98E+2ECj
					; sub_1B98E+354j
		mov	al, 1
		jmp	short loc_1BCEC
; ---------------------------------------------------------------------------
off_1BCCC	dw offset loc_1BCAE	; DATA XREF: sub_1B98E+31Ar
		dw offset loc_1BCAE
		dw offset loc_1BCB8
		dw offset loc_1BCC2
		dw offset loc_1BCDE
		dw offset loc_1BC76
		dw offset loc_1BC76
		dw offset loc_1BC76
; ---------------------------------------------------------------------------
		jmp	short loc_1BCFA
; ---------------------------------------------------------------------------

loc_1BCDE:				; CODE XREF: sub_1B98E+142j
					; sub_1B98E+2CDj ...
		cmp	[bp+var_6], 60h	; '`'
		jg	short loc_1BCC8
		cmp	[bp+var_6], 50h	; 'P'
		jl	short loc_1BC82

loc_1BCEA:				; CODE XREF: sub_1B98E+2F2j
		sub	al, al

loc_1BCEC:				; CODE XREF: sub_1B98E+2F6j
					; sub_1B98E+33Cj
		mov	cx, ax
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		mov	[bx+21ADh], cl

loc_1BCFA:				; CODE XREF: sub_1B98E+E7j
					; sub_1B98E+F1j ...
		mov	ax, [bp+var_8]
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_1B98E	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1BD04	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 4
		push	di
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+2178h]
		cmp	[bx+2178h], ax
		jle	short loc_1BD40
		mov	ax, cx
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		jmp	short loc_1BD54
; ---------------------------------------------------------------------------

loc_1BD40:				; CODE XREF: sub_1BD04+27j
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, cx
		imul	[bp+arg_0]

loc_1BD54:				; CODE XREF: sub_1BD04+3Aj
		mov	di, ax
		mov	ax, [di+2178h]
		sub	ax, [bx+2178h]
		mov	[bp+var_2], ax
		call	sub_1525A
		sub	ah, ah
		and	ax, 7
		cmp	ax, word_2A9F4
		jnb	short loc_1BDA4
		cmp	[bp+var_2], 50h	; 'P'
		jge	short loc_1BDA4
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+217Ah]
		cmp	[bx+217Ah], ax
		jge	short loc_1BD9A
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1B324
		jmp	short loc_1BDA1
; ---------------------------------------------------------------------------
		align 2

loc_1BD9A:				; CODE XREF: sub_1BD04+8Aj
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1B1D2

loc_1BDA1:				; CODE XREF: sub_1BD04+93j
		add	sp, 2

loc_1BDA4:				; CODE XREF: sub_1BD04+6Bj
					; sub_1BD04+71j
		mov	ax, [bp+var_4]
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_1BD04	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1BDAE	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 4
		push	di
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+2178h]
		cmp	[bx+2178h], ax
		jle	short loc_1BDEA
		mov	ax, cx
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		jmp	short loc_1BDFE
; ---------------------------------------------------------------------------

loc_1BDEA:				; CODE XREF: sub_1BDAE+27j
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, cx
		imul	[bp+arg_0]

loc_1BDFE:				; CODE XREF: sub_1BDAE+3Aj
		mov	di, ax
		mov	ax, [di+2178h]
		sub	ax, [bx+2178h]
		mov	[bp+var_2], ax
		call	sub_1525A
		sub	ah, ah
		and	ax, 7
		cmp	ax, word_2A9F4
		jnb	short loc_1BE4E
		cmp	[bp+var_2], 50h	; 'P'
		jge	short loc_1BE4E
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+217Ah]
		cmp	[bx+217Ah], ax
		jle	short loc_1BE44
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1B36A
		jmp	short loc_1BE4B
; ---------------------------------------------------------------------------
		align 2

loc_1BE44:				; CODE XREF: sub_1BDAE+8Aj
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1B218

loc_1BE4B:				; CODE XREF: sub_1BDAE+93j
		add	sp, 2

loc_1BE4E:				; CODE XREF: sub_1BDAE+6Bj
					; sub_1BDAE+71j
		mov	ax, [bp+var_4]
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_1BDAE	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1BE58	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 4
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	al, [si+21ADh]
		sub	ah, ah
		mov	[bp+var_4], ax
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1B98E
		add	sp, 2
		mov	[bp+var_2], ax
		cmp	byte ptr [si+21AAh], 4
		jnz	short loc_1BE8B
		mov	al, byte ptr [bp+var_4]
		mov	[si+21ADh], al

loc_1BE8B:				; CODE XREF: sub_1BE58+2Aj
		mov	ax, [bp+var_2]
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_1BE58	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1BE94	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 4
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	al, [si+21ADh]
		sub	ah, ah
		mov	[bp+var_4], ax
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1B98E
		add	sp, 2
		mov	[bp+var_2], ax
		cmp	byte ptr [si+21AAh], 5
		jnz	short loc_1BEC7
		mov	al, byte ptr [bp+var_4]
		mov	[si+21ADh], al

loc_1BEC7:				; CODE XREF: sub_1BE94+2Aj
		mov	ax, [bp+var_2]
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_1BE94	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1BED0	proc far		; CODE XREF: sub_11230+1B1P
					; sub_11230+1C4P ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	ax, 14h
		imul	[bp+arg_0]
		mov	cl, 3
		shl	ax, cl
		add	ax, 0F0h ; '�'
		mov	[si+2178h], ax
		mov	word ptr [si+217Ah], 9Eh ; '�'
		mov	word ptr [si+217Ch], 0
		mov	word ptr [si+217Ch], 0
		mov	word ptr [si+217Eh], 0
		mov	word ptr [si+2182h], 0
		mov	word ptr [si+2180h], 0C9h ; '�'
		mov	word ptr [si+2184h], 0
		mov	word ptr [si+2188h], 0
		mov	word ptr [si+218Ah], 0
		mov	word ptr [si+218Ch], 0
		mov	word ptr [si+219Ah], 0
		mov	word ptr [si+219Ch], 0
		mov	word ptr [si+219Eh], 0
		mov	word ptr [si+21A0h], 0
		mov	word ptr [si+21A2h], 0
		mov	word ptr [si+21A4h], 0
		mov	word ptr [si+21A6h], 0
		mov	word ptr [si+218Eh], 0FFD0h
		mov	word ptr [si+2190h], 8
		mov	word ptr [si+2192h], 1
		mov	word ptr [si+2194h], 8
		mov	word ptr [si+2196h], 4
		mov	byte ptr [si+21A8h], 0
		mov	word ptr [si+2198h], 0
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	[si+21A9h], al
		mov	byte ptr [si+21AAh], 0
		mov	byte ptr [si+21ABh], 0
		mov	byte ptr [si+21ACh], 0
		mov	byte ptr [si+21ADh], 0
		mov	byte ptr [si+21AEh], 1Fh
		mov	byte ptr [si+21AFh], 0
		mov	[si+21B0h], cl
		mov	byte ptr [si+21B1h], 0
		mov	byte ptr [si+21B2h], 0
		mov	byte ptr [si+21B3h], 0Bh
		mov	byte ptr [si+21B4h], 0Fh
		mov	byte ptr [si+21B5h], 1Fh
		mov	byte ptr [si+21B6h], 22h ; '"'
		mov	byte ptr [si+21B7h], 7
		mov	byte ptr [si+21B8h], 10h
		mov	byte ptr [si+21B9h], 15h
		mov	byte ptr [si+21BAh], 0Ah
		mov	byte ptr [si+21BBh], 9
		mov	byte ptr [si+21BCh], 1
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21BDh], 0
		mov	byte ptr [si+21BEh], 8
		mov	byte ptr [si+21BFh], 2
		mov	[si+21C0h], cl
		mov	byte ptr [si+21C1h], 5
		mov	byte ptr [si+21C2h], 58h ; 'X'
		pop	si
		pop	bp
		retf
sub_1BED0	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1C00E	proc far		; CODE XREF: sub_12822+34P
					; sub_12822+52P ...

var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	si
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	word ptr [bx+2180h], 0
		jle	short loc_1C035
		cmp	word_2CEE8, 0
		jz	short loc_1C035
		jmp	loc_1C0E9
; ---------------------------------------------------------------------------

loc_1C035:				; CODE XREF: sub_1C00E+1Bj
					; sub_1C00E+22j
		mov	si, [bp+arg_0]
		shl	si, 1
		mov	word ptr [si+2514h], 0
		mov	word ptr [si+2448h], 0
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	byte ptr [bx+21AAh], 0
		jnz	short loc_1C06B
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	byte ptr [bx+21AAh], 0Ah
		jz	short loc_1C09A

loc_1C06B:				; CODE XREF: sub_1C00E+45j
		cmp	word_2CEE8, 0
		jnz	short loc_1C0E9
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+2180h]
		cmp	[bx+2180h], ax
		jge	short loc_1C0E9
		cmp	byte ptr [si+21AAh], 0
		jnz	short loc_1C0E9

loc_1C09A:				; CODE XREF: sub_1C00E+5Bj
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21AAh], 12h
		mov	byte ptr [si+21B0h], 3
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21ADh], 14h
		mov	byte ptr [si+21AEh], 2Dh ; '-'
		mov	byte ptr [si+21B1h], 31h ; '1'
		mov	byte ptr [si+21B2h], 31h ; '1'
		mov	word ptr [si+217Eh], 0FFE0h
		mov	bx, [bp+arg_0]
		shl	bx, 1
		inc	word ptr [bx+2646h]
		mov	word_2A9E4, 1
		mov	ax, 5
		push	ax
		push	[bp+arg_0]
		call	sub_15C20
		add	sp, 4

loc_1C0E9:				; CODE XREF: sub_1C00E+24j
					; sub_1C00E+62j ...
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	ax, [bx+2514h]
		mov	[bp+var_2], ax
		push	[bp+arg_0]
		call	sub_107EA
		add	sp, 2
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	word ptr [si+2186h], 0
		jnz	short loc_1C136
		push	[bp+arg_0]
		mov	bl, [si+21AAh]
		sub	bh, bh
		shl	bx, 1
		shl	bx, 1
		call	off_2C216[bx]
		add	sp, 2
		push	[bp+arg_0]
		mov	bl, [si+21AAh]
		sub	bh, bh
		shl	bx, 1
		shl	bx, 1
		call	off_2C2D6[bx]
		jmp	short loc_1C179
; ---------------------------------------------------------------------------

loc_1C136:				; CODE XREF: sub_1C00E+FFj
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		add	si, 21AAh
		push	[bp+arg_0]
		mov	bl, [si]
		sub	bh, bh
		shl	bx, 1
		shl	bx, 1
		call	off_2C276[bx]
		add	sp, 2
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	word ptr [bx+2180h], 0
		jle	short loc_1C17C
		push	[bp+arg_0]
		mov	bl, [si]
		sub	bh, bh
		shl	bx, 1
		shl	bx, 1
		call	off_2C33A[bx]

loc_1C179:				; CODE XREF: sub_1C00E+126j
		add	sp, 2

loc_1C17C:				; CODE XREF: sub_1C00E+15Aj
		push	[bp+arg_0]
		call	sub_233A6
		add	sp, 2
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		mov	ax, [bp+var_2]
		mov	[bx+2198h], ax
		push	[bp+arg_0]
		call	sub_2398E
		add	sp, 2
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_1C00E	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1C1A6	proc far		; CODE XREF: sub_1B634+1A2p
					; sub_1B7F4+DBp ...

var_12		= word ptr -12h
var_10		= byte ptr -10h
var_E		= word ptr -0Eh
var_C		= word ptr -0Ch
var_A		= word ptr -0Ah
var_8		= word ptr -8
var_6		= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 14h
		push	di
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		mov	al, [bx+21A9h]
		mov	[bp+var_10], al
		or	al, al
		jnz	short loc_1C1C6
		mov	ax, 4
		jmp	short loc_1C1C9
; ---------------------------------------------------------------------------

loc_1C1C6:				; CODE XREF: sub_1C1A6+19j
		mov	ax, 8

loc_1C1C9:				; CODE XREF: sub_1C1A6+1Ej
		mov	[bp+var_4], ax
		cmp	[bp+var_10], 1
		jnz	short loc_1C1D8
		mov	ax, 4
		jmp	short loc_1C1DB
; ---------------------------------------------------------------------------
		align 2

loc_1C1D8:				; CODE XREF: sub_1C1A6+2Aj
		mov	ax, 8

loc_1C1DB:				; CODE XREF: sub_1C1A6+2Fj
		mov	[bp+var_E], ax
		mov	[bp+var_8], 0
		mov	[bp+var_C], 0
		mov	[bp+var_2], 0
		mov	ax, word_2D012
		mov	[bp+var_A], ax
		dec	[bp+var_A]
		jns	short loc_1C1FD
		mov	[bp+var_A], 1Dh

loc_1C1FD:				; CODE XREF: sub_1C1A6+50j
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	ax, [bp+var_4]
		add	ax, 20h	; ' '
		cmp	[bx+2448h], ax
		jnz	short loc_1C265
		mov	di, 1
		mov	[bp+var_6], 1Eh
		mov	ax, 3Ch	; '<'
		imul	[bp+arg_0]
		mov	[bp+var_12], ax
		mov	si, 1Eh
		mov	dx, [bp+var_2]
		mov	cx, [bp+var_A]

loc_1C228:				; CODE XREF: sub_1C1A6+AAj
		mov	bx, cx
		shl	bx, 1
		add	bx, [bp+var_12]
		mov	ax, [bx+254Ah]
		and	ax, [bp+var_E]
		cmp	ax, [bp+var_E]
		jnz	short loc_1C249
		cmp	di, 1
		jnz	short loc_1C249
		inc	dx
		cmp	dx, 0Ah
		jnz	short loc_1C249
		mov	di, 2

loc_1C249:				; CODE XREF: sub_1C1A6+93j
					; sub_1C1A6+98j ...
		dec	cx
		jns	short loc_1C24F
		mov	cx, 1Dh

loc_1C24F:				; CODE XREF: sub_1C1A6+A4j
		dec	si
		jnz	short loc_1C228
		mov	[bp+var_8], di
		mov	[bp+var_2], dx
		mov	[bp+var_A], cx
		cmp	di, 2
		jnz	short loc_1C265
		mov	[bp+var_C], 1

loc_1C265:				; CODE XREF: sub_1C1A6+66j
					; sub_1C1A6+B8j
		mov	ax, [bp+var_C]
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_1C1A6	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1C26E	proc far		; CODE XREF: sub_1B634+16Fp
					; sub_1B7F4+A8p ...

var_12		= word ptr -12h
var_10		= byte ptr -10h
var_E		= word ptr -0Eh
var_C		= word ptr -0Ch
var_A		= word ptr -0Ah
var_8		= word ptr -8
var_6		= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 14h
		push	di
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		mov	al, [bx+21A9h]
		mov	[bp+var_10], al
		or	al, al
		jnz	short loc_1C28E
		mov	ax, 4
		jmp	short loc_1C291
; ---------------------------------------------------------------------------

loc_1C28E:				; CODE XREF: sub_1C26E+19j
		mov	ax, 8

loc_1C291:				; CODE XREF: sub_1C26E+1Ej
		mov	[bp+var_4], ax
		cmp	[bp+var_10], 1
		jnz	short loc_1C2A0
		mov	ax, 4
		jmp	short loc_1C2A3
; ---------------------------------------------------------------------------
		align 2

loc_1C2A0:				; CODE XREF: sub_1C26E+2Aj
		mov	ax, 8

loc_1C2A3:				; CODE XREF: sub_1C26E+2Fj
		mov	[bp+var_E], ax
		mov	[bp+var_8], 0
		mov	[bp+var_C], 0
		mov	[bp+var_2], 0
		mov	ax, word_2D012
		mov	[bp+var_A], ax
		dec	[bp+var_A]
		jns	short loc_1C2C5
		mov	[bp+var_A], 1Dh

loc_1C2C5:				; CODE XREF: sub_1C26E+50j
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	ax, [bp+var_4]
		add	ax, 10h
		cmp	[bx+2448h], ax
		jnz	short loc_1C32D
		mov	di, 1
		mov	[bp+var_6], 1Eh
		mov	ax, 3Ch	; '<'
		imul	[bp+arg_0]
		mov	[bp+var_12], ax
		mov	si, 1Eh
		mov	dx, [bp+var_2]
		mov	cx, [bp+var_A]

loc_1C2F0:				; CODE XREF: sub_1C26E+AAj
		mov	bx, cx
		shl	bx, 1
		add	bx, [bp+var_12]
		mov	ax, [bx+254Ah]
		and	ax, [bp+var_E]
		cmp	ax, [bp+var_E]
		jnz	short loc_1C311
		cmp	di, 1
		jnz	short loc_1C311
		inc	dx
		cmp	dx, 0Ah
		jnz	short loc_1C311
		mov	di, 2

loc_1C311:				; CODE XREF: sub_1C26E+93j
					; sub_1C26E+98j ...
		dec	cx
		jns	short loc_1C317
		mov	cx, 1Dh

loc_1C317:				; CODE XREF: sub_1C26E+A4j
		dec	si
		jnz	short loc_1C2F0
		mov	[bp+var_8], di
		mov	[bp+var_2], dx
		mov	[bp+var_A], cx
		cmp	di, 2
		jnz	short loc_1C32D
		mov	[bp+var_C], 1

loc_1C32D:				; CODE XREF: sub_1C26E+66j
					; sub_1C26E+B8j
		mov	ax, [bp+var_C]
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_1C26E	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1C336	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21ABh], 0
		mov	byte ptr [si+21ACh], 1
		inc	byte ptr [si+21AFh]
		mov	al, [si+21AFh]
		cmp	[si+21B0h], al
		ja	short loc_1C366
		mov	byte ptr [si+21AFh], 0
		inc	byte ptr [si+21AEh]

loc_1C366:				; CODE XREF: sub_1C336+25j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	byte ptr [bx+21AEh], 3Dh ; '='
		jbe	short loc_1C380
		push	[bp+arg_0]
		call	sub_21F4C
		add	sp, 2

loc_1C380:				; CODE XREF: sub_1C336+3Dj
		mov	ax, [bp+var_2]
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_1C336	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1C388	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	byte ptr [si+21ADh], 9
		jbe	short loc_1C3A2
		mov	al, 2
		jmp	short loc_1C3A4
; ---------------------------------------------------------------------------

loc_1C3A2:				; CODE XREF: sub_1C388+14j
		sub	al, al

loc_1C3A4:				; CODE XREF: sub_1C388+18j
		mov	[si+21ABh], al
		mov	byte ptr [si+21ACh], 1
		inc	byte ptr [si+21ADh]
		mov	ax, [si+217Ch]
		add	[si+2178h], ax
		inc	byte ptr [si+21AFh]
		mov	al, [si+21AFh]
		cmp	[si+21B0h], al
		ja	short loc_1C3FA
		mov	byte ptr [si+21AFh], 0
		inc	byte ptr [si+21AEh]
		cmp	byte ptr [si+21ADh], 9
		jbe	short loc_1C3E6
		cmp	byte ptr [si+21AEh], 57h ; 'W'
		jbe	short loc_1C3FA
		mov	byte ptr [si+21AEh], 54h ; 'T'
		jmp	short loc_1C3FA
; ---------------------------------------------------------------------------
		align 2

loc_1C3E6:				; CODE XREF: sub_1C388+4Dj
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		add	si, 21AEh
		cmp	byte ptr [si], 54h ; 'T'
		jnz	short loc_1C3FA
		mov	byte ptr [si], 50h ; 'P'

loc_1C3FA:				; CODE XREF: sub_1C388+3Dj
					; sub_1C388+54j ...
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	byte ptr [si+21ADh], 0Ah
		ja	short loc_1C40C
		jmp	loc_1C498
; ---------------------------------------------------------------------------

loc_1C40C:				; CODE XREF: sub_1C388+7Fj
		jnz	short loc_1C414
		mov	ax, 1
		jmp	short loc_1C416
; ---------------------------------------------------------------------------
		align 2

loc_1C414:				; CODE XREF: sub_1C388:loc_1C40Cj
		sub	ax, ax

loc_1C416:				; CODE XREF: sub_1C388+89j
		push	[bp+arg_0]
		call	sub_2274C
		add	sp, 2
		cmp	ax, 1
		jz	short loc_1C429
		jmp	loc_1C4D4
; ---------------------------------------------------------------------------

loc_1C429:				; CODE XREF: sub_1C388+9Cj
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [bx+2178h]
		mov	cl, 3
		sar	ax, cl
		mov	dx, [si+2178h]
		sar	dx, cl
		cmp	ax, dx
		jz	short loc_1C46E
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+2178h]
		cmp	[bx+2178h], ax
		jge	short loc_1C468
		sub	al, al
		jmp	short loc_1C46A
; ---------------------------------------------------------------------------
		align 2

loc_1C468:				; CODE XREF: sub_1C388+D9j
		mov	al, 1

loc_1C46A:				; CODE XREF: sub_1C388+DDj
		mov	[si+21A9h], al

loc_1C46E:				; CODE XREF: sub_1C388+C0j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	al, [si+21B5h]
		mov	[si+21B1h], al
		mov	[si+21B2h], al
		mov	byte ptr [si+21B0h], 2
		mov	byte ptr [si+21AFh], 0
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 0Ch
		jmp	short loc_1C4D4
; ---------------------------------------------------------------------------
		align 2

loc_1C498:				; CODE XREF: sub_1C388+81j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	word ptr [si+2188h], 0
		jz	short loc_1C4D4
		mov	ax, [si+217Ch]
		sub	[si+2178h], ax
		mov	byte ptr [si+21AEh], 54h ; 'T'
		mov	ax, [si+218Eh]
		mov	[si+217Eh], ax
		cmp	byte ptr [si+21A9h], 1
		jnz	short loc_1C4C8
		mov	ax, 0FFFCh
		jmp	short loc_1C4CB
; ---------------------------------------------------------------------------

loc_1C4C8:				; CODE XREF: sub_1C388+139j
		mov	ax, 4

loc_1C4CB:				; CODE XREF: sub_1C388+13Ej
		mov	[si+217Ch], ax
		mov	byte ptr [si+21ADh], 0Ah

loc_1C4D4:				; CODE XREF: sub_1C388+9Ej
					; sub_1C388+10Dj ...
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	byte ptr [si+21ADh], 8
		jnz	short loc_1C50D
		push	[bp+arg_0]
		call	sub_21EF8
		add	sp, 2
		mov	al, [si+21B5h]
		mov	[si+21B1h], al
		mov	[si+21B2h], al
		mov	byte ptr [si+21B0h], 2
		mov	byte ptr [si+21AFh], 0
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 0Ch

loc_1C50D:				; CODE XREF: sub_1C388+159j
		mov	ax, [bp+var_2]
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_1C388	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1C516	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21ABh], 2
		mov	byte ptr [si+21ACh], 1
		cmp	byte ptr [si+21ADh], 0
		jnz	short loc_1C59C
		mov	ax, [si+217Ch]
		sub	[si+2178h], ax
		inc	byte ptr [si+21AFh]
		mov	al, [si+21AFh]
		cmp	[si+21B0h], al
		ja	short loc_1C59C
		mov	byte ptr [si+21AFh], 0
		inc	byte ptr [si+21AEh]
		cmp	byte ptr [si+21AEh], 46h ; 'F'
		jnz	short loc_1C59C
		mov	byte ptr [si+21AEh], 46h ; 'F'
		mov	byte ptr [si+21ADh], 1
		mov	ax, [si+218Eh]
		cwd
		xor	ax, dx
		sub	ax, dx
		mov	cx, 2
		sar	ax, cl
		xor	ax, dx
		sub	ax, dx
		mov	cx, ax
		mov	ax, [si+218Eh]
		cwd
		sub	ax, dx
		sar	ax, 1
		add	ax, cx
		mov	[si+217Eh], ax
		shl	word ptr [si+217Ch], 1
		mov	ax, 3
		push	ax
		push	[bp+arg_0]
		call	sub_15C20
		add	sp, 4

loc_1C59C:				; CODE XREF: sub_1C516+1Ej
					; sub_1C516+34j ...
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	byte ptr [si+21ADh], 1
		jnz	short loc_1C5EA
		mov	byte ptr [si+21AEh], 46h ; 'F'
		push	[bp+arg_0]
		call	sub_2274C
		add	sp, 2
		cmp	ax, 1
		jnz	short loc_1C5EA
		push	[bp+arg_0]
		call	sub_21EF8
		add	sp, 2
		mov	al, [si+21B5h]
		mov	[si+21B1h], al
		mov	[si+21B2h], al
		mov	byte ptr [si+21B0h], 1
		mov	byte ptr [si+21AFh], 0
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 0Ch

loc_1C5EA:				; CODE XREF: sub_1C516+93j
					; sub_1C516+A8j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	byte ptr [si+21ADh], 2
		jnz	short loc_1C65E
		inc	byte ptr [si+21AFh]
		mov	al, [si+21AFh]
		cmp	[si+21B0h], al
		ja	short loc_1C61C
		mov	byte ptr [si+21AFh], 0
		inc	byte ptr [si+21AEh]
		cmp	byte ptr [si+21AEh], 57h ; 'W'
		jbe	short loc_1C61C
		mov	byte ptr [si+21AEh], 54h ; 'T'

loc_1C61C:				; CODE XREF: sub_1C516+EFj
					; sub_1C516+FFj
		push	[bp+arg_0]
		call	sub_2274C
		add	sp, 2
		cmp	ax, 1
		jnz	short loc_1C65E
		push	[bp+arg_0]
		call	sub_21EF8
		add	sp, 2
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	al, [si+21B5h]
		mov	[si+21B1h], al
		mov	[si+21B2h], al
		mov	byte ptr [si+21B0h], 1
		mov	byte ptr [si+21AFh], 0
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 0Ch

loc_1C65E:				; CODE XREF: sub_1C516+E1j
					; sub_1C516+114j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	word ptr [si+2188h], 0
		jz	short loc_1C69A
		mov	ax, [si+217Ch]
		sub	[si+2178h], ax
		mov	byte ptr [si+21AEh], 54h ; 'T'
		mov	ax, [si+218Eh]
		mov	[si+217Eh], ax
		cmp	byte ptr [si+21A9h], 1
		jnz	short loc_1C68E
		mov	ax, 0FFFCh
		jmp	short loc_1C691
; ---------------------------------------------------------------------------

loc_1C68E:				; CODE XREF: sub_1C516+171j
		mov	ax, 4

loc_1C691:				; CODE XREF: sub_1C516+176j
		mov	[si+217Ch], ax
		mov	byte ptr [si+21ADh], 2

loc_1C69A:				; CODE XREF: sub_1C516+155j
		mov	ax, [bp+var_2]
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_1C516	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1C6A2	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	di
		push	si
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21A8h], 1
		inc	byte ptr [si+21ADh]
		cmp	byte ptr [si+21ADh], 17h
		ja	short loc_1C6CB
		jmp	loc_1C7BE
; ---------------------------------------------------------------------------

loc_1C6CB:				; CODE XREF: sub_1C6A2+24j
		cmp	byte ptr [si+21ADh], 18h
		jz	short loc_1C6D5
		jmp	loc_1C799
; ---------------------------------------------------------------------------

loc_1C6D5:				; CODE XREF: sub_1C6A2+2Ej
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	byte ptr [bx+21AAh], 9
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	di, ax
		mov	ax, [di+218Eh]
		cwd
		sub	ax, dx
		sar	ax, 1
		mov	[bx+217Eh], ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	al, [bx+21BFh]
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+21AEh], cl
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	byte ptr [bx+21A9h], 0
		jnz	short loc_1C74E
		mov	ax, 10h
		jmp	short loc_1C751
; ---------------------------------------------------------------------------

loc_1C74E:				; CODE XREF: sub_1C6A2+A5j
		mov	ax, 0FFF0h

loc_1C751:				; CODE XREF: sub_1C6A2+AAj
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+217Ch], cx
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	byte ptr [si+21A9h], 1
		sbb	ax, ax
		neg	ax
		mov	[bx+21A9h], al
		mov	byte ptr [si+21A8h], 0
		mov	byte ptr [si+21B0h], 3
		mov	byte ptr [si+21AFh], 0
		mov	al, [si+21B5h]
		mov	[si+21AEh], al

loc_1C799:				; CODE XREF: sub_1C6A2+30j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	byte ptr [si+21ADh], 1Eh
		jz	short loc_1C7AB
		jmp	loc_1CA22
; ---------------------------------------------------------------------------

loc_1C7AB:				; CODE XREF: sub_1C6A2+104j
		mov	byte ptr [si+21A8h], 0
		push	[bp+arg_0]
		call	sub_21F4C
		add	sp, 2
		jmp	loc_1CA22
; ---------------------------------------------------------------------------

loc_1C7BE:				; CODE XREF: sub_1C6A2+26j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	al, [si+21ADh]
		and	al, 1
		cmp	al, 1
		jz	short loc_1C7D3
		jmp	loc_1C97A
; ---------------------------------------------------------------------------

loc_1C7D3:				; CODE XREF: sub_1C6A2+12Cj
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	byte ptr [bx+21AAh], 10h
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		cmp	byte ptr [si+21A9h], 1
		sbb	ax, ax
		neg	ax
		mov	[bx+21A9h], al
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	ax, [si+217Ah]
		mov	cl, [si+21ADh]
		sub	ch, ch
		sub	ax, cx
		mov	[bx+217Ah], ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	al, [bx+21BCh]
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+21AEh], cl
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		cmp	byte ptr [si+21A9h], 0
		jnz	short loc_1C858
		mov	ax, 0FFF8h
		jmp	short loc_1C85B
; ---------------------------------------------------------------------------

loc_1C858:				; CODE XREF: sub_1C6A2+1AFj
		mov	ax, 8

loc_1C85B:				; CODE XREF: sub_1C6A2+1B4j
		add	ax, [si+2178h]
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+2178h], cx
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	[bp+arg_0], 1
		sbb	di, di
		neg	di
		shl	di, 1
		mov	ax, [di+2A2Ch]
		shl	ax, 1
		shl	ax, 1
		add	ax, 4
		cwd
		xor	ax, dx
		sub	ax, dx
		mov	cx, 2
		sar	ax, cl
		xor	ax, dx
		sub	ax, dx
		sub	[bx+2180h], ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	word ptr [bx+2180h], 0
		jle	short loc_1C8C3
		jmp	loc_1CA22
; ---------------------------------------------------------------------------

loc_1C8C3:				; CODE XREF: sub_1C6A2+21Cj
		mov	byte ptr [si+21A8h], 0
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	byte ptr [bx+21AAh], 9
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	di, ax
		mov	ax, [di+218Eh]
		cwd
		sub	ax, dx
		sar	ax, 1
		mov	[bx+217Eh], ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	al, [bx+21BFh]
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+21AEh], cl
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	byte ptr [bx+21A9h], 0
		jnz	short loc_1C93E
		mov	ax, 10h
		jmp	short loc_1C941
; ---------------------------------------------------------------------------

loc_1C93E:				; CODE XREF: sub_1C6A2+295j
		mov	ax, 0FFF0h

loc_1C941:				; CODE XREF: sub_1C6A2+29Aj
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+217Ch], cx
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	byte ptr [si+21A9h], 1
		sbb	ax, ax
		neg	ax
		mov	[bx+21A9h], al
		mov	byte ptr [si+21ADh], 19h
		jmp	loc_1CA22
; ---------------------------------------------------------------------------

loc_1C97A:				; CODE XREF: sub_1C6A2+12Ej
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	byte ptr [bx+21AAh], 10h
		mov	ax, cx
		imul	[bp+arg_0]
		mov	si, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		cmp	byte ptr [si+21A9h], 1
		sbb	ax, ax
		neg	ax
		mov	[bx+21A9h], al
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	ax, [si+217Ah]
		mov	cl, [si+21ADh]
		sub	ch, ch
		sub	ax, cx
		mov	[bx+217Ah], ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	al, [bx+21BDh]
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+21AEh], cl
		mov	al, [si+21B2h]
		mov	[si+21AEh], al
		cmp	byte ptr [si+21A9h], 0
		jnz	short loc_1CA06
		mov	ax, 0FFF0h
		jmp	short loc_1CA09
; ---------------------------------------------------------------------------

loc_1CA06:				; CODE XREF: sub_1C6A2+35Dj
		mov	ax, 10h

loc_1CA09:				; CODE XREF: sub_1C6A2+362j
		add	ax, [si+2178h]
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+2178h], cx

loc_1CA22:				; CODE XREF: sub_1C6A2+106j
					; sub_1C6A2+119j ...
		mov	ax, [bp+var_2]
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_1C6A2	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1CA2C	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+217Ch], 0
		mov	byte ptr [si+21ABh], 0
		push	[bp+arg_0]
		call	sub_2274C
		add	sp, 2
		inc	byte ptr [si+21AFh]
		mov	al, [si+21AFh]
		cmp	[si+21B0h], al
		ja	short loc_1CA68
		mov	byte ptr [si+21AFh], 0
		inc	byte ptr [si+21AEh]

loc_1CA68:				; CODE XREF: sub_1CA2C+31j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	al, [si+21B2h]
		cmp	[si+21AEh], al
		jbe	short loc_1CA93
		dec	byte ptr [si+21ADh]
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		cmp	byte ptr [si+21ADh], 0
		jnz	short loc_1CA93
		mov	word_2A9E4, 2

loc_1CA93:				; CODE XREF: sub_1CA2C+4Cj
					; sub_1CA2C+5Fj
		mov	ax, [bp+var_2]
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_1CA2C	endp

seg005		ends

; ===========================================================================

; Segment type:	Pure code
seg006		segment	byte public 'CODE' use16
		assume cs:seg006
		;org 0Bh
		assume es:nothing, ss:nothing, ds:seg026, fs:nothing, gs:nothing
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1CA9C	proc far		; CODE XREF: sub_1CF1E+92p
					; sub_1CFBA+F3p ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+2184h], 14h
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ACh], 1
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 2
		mov	byte ptr [si+21B1h], 1Dh
		mov	byte ptr [si+21B2h], 1Fh
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 0Ch
		pop	si
		pop	bp
		retf
sub_1CA9C	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1CADE	proc far		; CODE XREF: sub_1CFBA+FCp
					; sub_1D358+2D6p

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+2184h], 14h
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ACh], 1
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 2
		mov	byte ptr [si+21B1h], 16h
		mov	byte ptr [si+21B2h], 19h
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 0Ch
		pop	si
		pop	bp
		retf
sub_1CADE	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1CB20	proc far		; CODE XREF: sub_1D172+85p
					; sub_1D358+1AAp

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+2184h], 14h
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ACh], 1
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 3
		mov	byte ptr [si+21B1h], 22h ; '"'
		mov	byte ptr [si+21B2h], 23h ; '#'
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 0Fh
		pop	si
		pop	bp
		retf
sub_1CB20	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1CB62	proc far		; CODE XREF: sub_1D264+25p
					; sub_1D6E2+DEp ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+2184h], 14h
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ACh], 3
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 3
		mov	byte ptr [si+21B1h], 2Ah ; '*'
		mov	byte ptr [si+21B2h], 2Ah ; '*'
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 0Dh
		mov	byte ptr [si+21ADh], 0Ah
		pop	si
		pop	bp
		retf
sub_1CB62	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1CBA8	proc far		; CODE XREF: sub_1D2CE+25p

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+2184h], 14h
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ACh], 3
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 1
		mov	byte ptr [si+21B1h], 2Ah ; '*'
		mov	byte ptr [si+21B2h], 2Ah ; '*'
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21ADh], 0Ah
		mov	byte ptr [si+21AAh], 0Eh
		pop	si
		pop	bp
		retf
sub_1CBA8	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1CBEE	proc far		; CODE XREF: sub_1CFBA+11Bp
					; sub_1D358+204p

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+2184h], 1Ch
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ACh], 1
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 2
		mov	byte ptr [si+21B1h], 20h ; ' '
		mov	byte ptr [si+21B2h], 21h ; '!'
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 0Ch
		pop	si
		pop	bp
		retf
sub_1CBEE	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1CC30	proc far		; CODE XREF: sub_1CFBA+124p
					; sub_1D358+2AEp

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+2184h], 1Ch
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ACh], 1
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 1
		mov	byte ptr [si+21B1h], 16h
		mov	byte ptr [si+21B2h], 1Ch
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 0Ch
		pop	si
		pop	bp
		retf
sub_1CC30	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1CC72	proc far		; CODE XREF: sub_1D172+9Ep
					; sub_1D358+284p

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+2184h], 1Ch
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ACh], 2
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 2
		mov	byte ptr [si+21B1h], 24h ; '$'
		mov	byte ptr [si+21B2h], 27h ; '''
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 0Fh
		pop	si
		pop	bp
		retf
sub_1CC72	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1CCB4	proc far		; CODE XREF: sub_1D264+53p
					; sub_1D6E2+A2p ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+2184h], 1Ch
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ACh], 3
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 1
		mov	byte ptr [si+21B1h], 28h ; '('
		mov	byte ptr [si+21B2h], 29h ; ')'
		mov	byte ptr [si+21ADh], 0Ah
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 0Dh
		pop	si
		pop	bp
		retf
sub_1CCB4	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1CCFA	proc far		; CODE XREF: sub_1D2CE+53p

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+2184h], 1Ch
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ACh], 3
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 2
		mov	byte ptr [si+21B1h], 28h ; '('
		mov	byte ptr [si+21B2h], 29h ; ')'
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21ADh], 0Fh
		mov	byte ptr [si+21AAh], 0Eh
		pop	si
		pop	bp
		retf
sub_1CCFA	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1CD40	proc far		; CODE XREF: sub_1CFBA+BAp
					; sub_1D172+6Cp ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21AAh], 2
		mov	al, [si+21B8h]
		mov	[si+21B1h], al
		mov	al, [si+21B9h]
		mov	[si+21B2h], al
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	ax, [si+218Eh]
		mov	[si+217Eh], ax
		mov	byte ptr [si+21B0h], 4
		pop	si
		pop	bp
		retf
sub_1CD40	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1CD7A	proc far		; CODE XREF: sub_1CFBA+B0p
					; sub_1D172+62p ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+217Ch], 0
		mov	byte ptr [si+21AAh], 3
		mov	al, [si+21B8h]
		mov	[si+21B1h], al
		mov	al, [si+21B9h]
		mov	[si+21B2h], al
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	ax, [si+218Eh]
		mov	[si+217Eh], ax
		mov	byte ptr [si+21B0h], 4
		pop	si
		pop	bp
		retf
sub_1CD7A	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1CDBA	proc far		; CODE XREF: sub_1CFBA+1A9p
					; sub_1D172+E2p ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	word ptr [si+21A6h], 0
		jnz	short loc_1CE13
		sub	ax, ax
		push	ax
		push	[bp+arg_0]
		call	sub_15C20
		add	sp, 4
		mov	word ptr [si+218Ah], 1
		mov	word ptr [si+2184h], 20h ; ' '
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ADh], 0
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 1
		mov	byte ptr [si+21B1h], 38h ; '8'
		mov	byte ptr [si+21B2h], 3Ch ; '<'
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 17h

loc_1CE13:				; CODE XREF: sub_1CDBA+11j
		pop	si
		pop	bp
		retf
sub_1CDBA	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1CE16	proc far		; CODE XREF: sub_1D264+5Cp
					; sub_1D2CE+5Cp ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+2184h], 1Ch
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ADh], 0
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 1
		mov	byte ptr [si+21B1h], 2Bh ; '+'
		mov	byte ptr [si+21B2h], 2Eh ; '.'
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		cmp	byte ptr [si+21A9h], 1
		jnz	short loc_1CE5C
		mov	ax, 10h
		jmp	short loc_1CE5F
; ---------------------------------------------------------------------------
		align 2

loc_1CE5C:				; CODE XREF: sub_1CE16+3Ej
		mov	ax, 0FFF0h

loc_1CE5F:				; CODE XREF: sub_1CE16+43j
		mov	[si+217Ch], ax
		mov	word ptr [si+217Eh], 10h
		mov	byte ptr [si+21AAh], 14h
		pop	si
		pop	bp
		retf
sub_1CE16	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1CE72	proc far		; CODE XREF: sub_1D264+2Ep
					; sub_1D2CE+2Ep ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+2184h], 1Ch
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ADh], 0
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 2
		mov	byte ptr [si+21B1h], 2Fh ; '/'
		mov	byte ptr [si+21B2h], 2Fh ; '/'
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 18h
		pop	si
		pop	bp
		retf
sub_1CE72	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1CEB4	proc far		; CODE XREF: sub_1CFBA+18Fp
					; sub_1D172+C8p ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 1
		push	ax
		push	[bp+arg_0]
		call	sub_15C20
		add	sp, 4
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+218Ah], 1
		mov	word ptr [si+2184h], 20h ; ' '
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ADh], 0
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 2
		mov	byte ptr [si+21B1h], 30h ; '0'
		mov	byte ptr [si+21B2h], 35h ; '5'
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 16h
		cmp	byte ptr [si+21A9h], 1
		jnz	short loc_1CF14
		mov	ax, 10h
		jmp	short loc_1CF17
; ---------------------------------------------------------------------------
		align 2

loc_1CF14:				; CODE XREF: sub_1CEB4+58j
		mov	ax, 0FFF0h

loc_1CF17:				; CODE XREF: sub_1CEB4+5Dj
		mov	[si+217Ch], ax
		pop	si
		pop	bp
		retf
sub_1CEB4	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1CF1E	proc far		; CODE XREF: sub_1CFBA+165p
					; sub_1D358+1B4p

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		test	byte ptr [bx+21ABh], 4
		jnz	short loc_1CFAC
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	ax, cx
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21B0h], 6
		mov	byte ptr [si+21AFh], 0
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 4
		cmp	al, 4
		jnz	short loc_1CF63
		mov	byte ptr [si+21A9h], 1

loc_1CF63:				; CODE XREF: sub_1CF1E+3Ej
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 8
		cmp	al, 8
		jnz	short loc_1CF7F
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		mov	byte ptr [bx+21A9h], 0

loc_1CF7F:				; CODE XREF: sub_1CF1E+52j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+217Ch], 0
		mov	byte ptr [si+21ADh], 0
		mov	byte ptr [si+21B1h], 36h ; '6'
		mov	byte ptr [si+21B2h], 37h ; '7'
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 15h
		pop	si
		pop	bp
		retf
; ---------------------------------------------------------------------------

loc_1CFAC:				; CODE XREF: sub_1CF1E+18j
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1CA9C
		add	sp, 2
		pop	si
		pop	bp
		retf
sub_1CF1E	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1CFBA	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_6		= byte ptr -6
var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 6
		push	di
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+218Ah], 0
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+2178h]
		cmp	[bx+2178h], ax
		jle	short loc_1CFFC
		mov	ax, cx
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		jmp	short loc_1D010
; ---------------------------------------------------------------------------

loc_1CFFC:				; CODE XREF: sub_1CFBA+2Dj
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, cx
		imul	[bp+arg_0]

loc_1D010:				; CODE XREF: sub_1CFBA+40j
		mov	di, ax
		mov	ax, [di+2178h]
		sub	ax, [bx+2178h]
		mov	[bp+var_2], ax
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		mov	[bp+var_6], al
		and	al, 1
		cmp	al, 1
		jnz	short loc_1D07A
		mov	al, [bp+var_6]
		and	al, 4
		cmp	al, 4
		jnz	short loc_1D03E
		mov	ax, 1
		jmp	short loc_1D040
; ---------------------------------------------------------------------------
		align 2

loc_1D03E:				; CODE XREF: sub_1CFBA+7Cj
		sub	ax, ax

loc_1D040:				; CODE XREF: sub_1CFBA+81j
		imul	word ptr [si+2194h]
		mov	cl, [bp+var_6]
		and	cl, 8
		mov	di, ax
		cmp	cl, 8
		jnz	short loc_1D056
		mov	ax, 1
		jmp	short loc_1D058
; ---------------------------------------------------------------------------

loc_1D056:				; CODE XREF: sub_1CFBA+95j
		sub	ax, ax

loc_1D058:				; CODE XREF: sub_1CFBA+9Aj
		imul	word ptr [si+2194h]
		sub	ax, di
		mov	[si+217Ch], ax
		or	ax, ax
		jnz	short loc_1D070
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1CD7A
		jmp	short loc_1D077
; ---------------------------------------------------------------------------
		align 2

loc_1D070:				; CODE XREF: sub_1CFBA+AAj
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1CD40

loc_1D077:				; CODE XREF: sub_1CFBA+B3j
		add	sp, 2

loc_1D07A:				; CODE XREF: sub_1CFBA+73j
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 2
		cmp	al, 2
		jnz	short loc_1D094
		push	[bp+arg_0]
		call	sub_21F72
		add	sp, 2

loc_1D094:				; CODE XREF: sub_1CFBA+CDj
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 10h
		cmp	al, 10h
		jnz	short loc_1D0BC
		cmp	[bp+var_2], 30h	; '0'
		jge	short loc_1D0B2
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1CA9C
		jmp	short loc_1D0B9
; ---------------------------------------------------------------------------

loc_1D0B2:				; CODE XREF: sub_1CFBA+EDj
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1CADE

loc_1D0B9:				; CODE XREF: sub_1CFBA+F6j
		add	sp, 2

loc_1D0BC:				; CODE XREF: sub_1CFBA+E7j
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 20h
		cmp	al, 20h	; ' '
		jnz	short loc_1D0E4
		cmp	[bp+var_2], 30h	; '0'
		jge	short loc_1D0DA
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1CBEE
		jmp	short loc_1D0E1
; ---------------------------------------------------------------------------

loc_1D0DA:				; CODE XREF: sub_1CFBA+115j
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1CC30

loc_1D0E1:				; CODE XREF: sub_1CFBA+11Ej
		add	sp, 2

loc_1D0E4:				; CODE XREF: sub_1CFBA+10Fj
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		mov	[bp+var_6], al
		test	[bp+var_6], 0Ch
		jz	short loc_1D125
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		test	byte ptr [bx+21ABh], 2
		jnz	short loc_1D125
		mov	al, [bp+var_6]
		and	al, 10h
		cmp	al, 10h
		jnz	short loc_1D125
		cmp	[bp+var_2], 20h	; ' '
		jge	short loc_1D125
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1CF1E
		add	sp, 2

loc_1D125:				; CODE XREF: sub_1CFBA+13Aj
					; sub_1CFBA+150j ...
		push	[bp+arg_0]
		call	sub_1A8FA
		add	sp, 2
		cmp	ax, 1
		jz	short loc_1D145
		push	[bp+arg_0]
		call	sub_1C1A6
		add	sp, 2
		cmp	ax, 1
		jnz	short loc_1D14F

loc_1D145:				; CODE XREF: sub_1CFBA+179j
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1CEB4
		add	sp, 2

loc_1D14F:				; CODE XREF: sub_1CFBA+189j
		push	[bp+arg_0]
		call	sub_1A9BC
		add	sp, 2
		cmp	ax, 1
		jnz	short loc_1D169
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1CDBA
		add	sp, 2

loc_1D169:				; CODE XREF: sub_1CFBA+1A3j
		mov	ax, [bp+var_4]
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_1CFBA	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1D172	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_4		= byte ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 4
		push	di
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+218Ah], 0
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		mov	[bp+var_4], al
		and	al, 1
		cmp	al, 1
		jnz	short loc_1D1E4
		mov	al, [bp+var_4]
		and	al, 4
		cmp	al, 4
		jnz	short loc_1D1A8
		mov	ax, 1
		jmp	short loc_1D1AA
; ---------------------------------------------------------------------------

loc_1D1A8:				; CODE XREF: sub_1D172+2Fj
		sub	ax, ax

loc_1D1AA:				; CODE XREF: sub_1D172+34j
		imul	word ptr [si+2194h]
		mov	cl, [bp+var_4]
		and	cl, 8
		mov	di, ax
		cmp	cl, 8
		jnz	short loc_1D1C0
		mov	ax, 1
		jmp	short loc_1D1C2
; ---------------------------------------------------------------------------

loc_1D1C0:				; CODE XREF: sub_1D172+47j
		sub	ax, ax

loc_1D1C2:				; CODE XREF: sub_1D172+4Cj
		imul	word ptr [si+2194h]
		sub	ax, di
		mov	[si+217Ch], ax
		or	ax, ax
		jnz	short loc_1D1DA
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1CD7A
		jmp	short loc_1D1E1
; ---------------------------------------------------------------------------
		align 2

loc_1D1DA:				; CODE XREF: sub_1D172+5Cj
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1CD40

loc_1D1E1:				; CODE XREF: sub_1D172+65j
		add	sp, 2

loc_1D1E4:				; CODE XREF: sub_1D172+26j
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 10h
		cmp	al, 10h
		jnz	short loc_1D1FD
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1CB20
		add	sp, 2

loc_1D1FD:				; CODE XREF: sub_1D172+7Fj
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 20h
		cmp	al, 20h	; ' '
		jnz	short loc_1D216
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1CC72
		add	sp, 2

loc_1D216:				; CODE XREF: sub_1D172+98j
		push	[bp+arg_0]
		call	sub_1A8FA
		add	sp, 2
		cmp	ax, 1
		jz	short loc_1D236
		push	[bp+arg_0]
		call	sub_1C1A6
		add	sp, 2
		cmp	ax, 1
		jnz	short loc_1D240

loc_1D236:				; CODE XREF: sub_1D172+B2j
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1CEB4
		add	sp, 2

loc_1D240:				; CODE XREF: sub_1D172+C2j
		push	[bp+arg_0]
		call	sub_1A9BC
		add	sp, 2
		cmp	ax, 1
		jnz	short loc_1D25A
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1CDBA
		add	sp, 2

loc_1D25A:				; CODE XREF: sub_1D172+DCj
		mov	ax, [bp+var_2]
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_1D172	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1D264	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_4		= byte ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 4
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		mov	[bp+var_4], al
		and	al, 10h
		cmp	al, 10h
		jnz	short loc_1D298
		mov	al, [bp+var_4]
		and	al, 2
		cmp	al, 2
		jz	short loc_1D28E
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1CB62
		jmp	short loc_1D295
; ---------------------------------------------------------------------------

loc_1D28E:				; CODE XREF: sub_1D264+1Fj
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1CE72

loc_1D295:				; CODE XREF: sub_1D264+28j
		add	sp, 2

loc_1D298:				; CODE XREF: sub_1D264+16j
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		mov	[bp+var_4], al
		and	al, 20h
		cmp	al, 20h	; ' '
		jnz	short loc_1D2C6
		mov	al, [bp+var_4]
		and	al, 2
		cmp	al, 2
		jz	short loc_1D2BC
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1CCB4
		jmp	short loc_1D2C3
; ---------------------------------------------------------------------------

loc_1D2BC:				; CODE XREF: sub_1D264+4Dj
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1CE16

loc_1D2C3:				; CODE XREF: sub_1D264+56j
		add	sp, 2

loc_1D2C6:				; CODE XREF: sub_1D264+44j
		mov	ax, [bp+var_2]
		mov	sp, bp
		pop	bp
		retf
sub_1D264	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1D2CE	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_4		= byte ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 4
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		mov	[bp+var_4], al
		and	al, 10h
		cmp	al, 10h
		jnz	short loc_1D302
		mov	al, [bp+var_4]
		and	al, 2
		cmp	al, 2
		jz	short loc_1D2F8
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1CBA8
		jmp	short loc_1D2FF
; ---------------------------------------------------------------------------

loc_1D2F8:				; CODE XREF: sub_1D2CE+1Fj
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1CE72

loc_1D2FF:				; CODE XREF: sub_1D2CE+28j
		add	sp, 2

loc_1D302:				; CODE XREF: sub_1D2CE+16j
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		mov	[bp+var_4], al
		and	al, 20h
		cmp	al, 20h	; ' '
		jnz	short loc_1D330
		mov	al, [bp+var_4]
		and	al, 2
		cmp	al, 2
		jz	short loc_1D326
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1CCFA
		jmp	short loc_1D32D
; ---------------------------------------------------------------------------

loc_1D326:				; CODE XREF: sub_1D2CE+4Dj
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1CE16

loc_1D32D:				; CODE XREF: sub_1D2CE+56j
		add	sp, 2

loc_1D330:				; CODE XREF: sub_1D2CE+44j
		mov	ax, [bp+var_2]
		mov	sp, bp
		pop	bp
		retf
sub_1D2CE	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1D338	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1CFBA
		add	sp, 2
		pop	bp
		retf
sub_1D338	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1D348	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1D172
		add	sp, 2
		pop	bp
		retf
sub_1D348	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1D358	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_8		= word ptr -8
var_6		= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 8
		push	di
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+218Ah], 0
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+2178h]
		cmp	[bx+2178h], ax
		jle	short loc_1D39A
		mov	ax, cx
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		jmp	short loc_1D3AE
; ---------------------------------------------------------------------------

loc_1D39A:				; CODE XREF: sub_1D358+2Dj
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, cx
		imul	[bp+arg_0]

loc_1D3AE:				; CODE XREF: sub_1D358+40j
		mov	di, ax
		mov	ax, [di+2178h]
		sub	ax, [bx+2178h]
		mov	[bp+var_6], ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+2178h]
		cmp	[bx+2178h], ax
		jle	short loc_1D3DA
		mov	ax, 1
		jmp	short loc_1D3DD
; ---------------------------------------------------------------------------
		align 2

loc_1D3DA:				; CODE XREF: sub_1D358+7Aj
		mov	ax, 0FFFFh

loc_1D3DD:				; CODE XREF: sub_1D358+7Fj
		mov	[bp+var_4], ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+2178h]
		cmp	[bx+2178h], ax
		jle	short loc_1D3FE
		mov	ax, 0FFFFh
		jmp	short loc_1D401
; ---------------------------------------------------------------------------

loc_1D3FE:				; CODE XREF: sub_1D358+9Fj
		mov	ax, 1

loc_1D401:				; CODE XREF: sub_1D358+A4j
		mov	[bp+var_2], ax
		mov	byte ptr [si+21ADh], 0
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	byte ptr [bx+21ACh], 0
		jnz	short loc_1D422
		jmp	loc_1D4A6
; ---------------------------------------------------------------------------

loc_1D422:				; CODE XREF: sub_1D358+C5j
		call	sub_1525A
		sub	ah, ah
		and	ax, 7
		cmp	ax, word_2A9F4
		jnb	short loc_1D4A6
		push	[bp+arg_0]
		call	sub_22252
		add	sp, 2
		cmp	ax, 1
		jz	short loc_1D445
		jmp	loc_1D6D8
; ---------------------------------------------------------------------------

loc_1D445:				; CODE XREF: sub_1D358+E8j
		cmp	word_2A9F4, 1
		jnz	short loc_1D44F
		jmp	loc_1D6D8
; ---------------------------------------------------------------------------

loc_1D44F:				; CODE XREF: sub_1D358+F2j
		call	sub_1525A
		sub	ah, ah
		and	ax, 7
		cmp	ax, word_2A9F4
		jnb	short loc_1D486
		call	sub_1525A
		sub	ah, ah
		and	ax, 7
		cmp	ax, word_2A9F4
		jb	short loc_1D472
		jmp	loc_1D6D8
; ---------------------------------------------------------------------------

loc_1D472:				; CODE XREF: sub_1D358+115j
					; sub_1D358+344j
		mov	ax, [si+2194h]
		imul	[bp+var_4]

loc_1D479:				; CODE XREF: sub_1D358+27Dj
		mov	[si+217Ch], ax
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1CD40
		jmp	short loc_1D4A0
; ---------------------------------------------------------------------------

loc_1D486:				; CODE XREF: sub_1D358+105j
		call	sub_1525A
		sub	ah, ah
		and	ax, 7
		cmp	ax, word_2A9F4
		jb	short loc_1D499
		jmp	loc_1D6D8
; ---------------------------------------------------------------------------

loc_1D499:				; CODE XREF: sub_1D358+13Cj
					; sub_1D358+336j
					; DATA XREF: ...
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1CDBA

loc_1D4A0:				; CODE XREF: sub_1D358+12Cj
					; sub_1D358+1ADj ...
		add	sp, 2
		jmp	loc_1D6D8
; ---------------------------------------------------------------------------

loc_1D4A6:				; CODE XREF: sub_1D358+C7j
					; sub_1D358+D8j
		call	sub_1525A
		sub	ah, ah
		and	ax, 7
		cmp	ax, word_2A9F4
		jb	short loc_1D4B9
		jmp	loc_1D6BC
; ---------------------------------------------------------------------------

loc_1D4B9:				; CODE XREF: sub_1D358+15Cj
		cmp	[bp+var_6], 30h	; '0'
		jl	short loc_1D4C2
		jmp	loc_1D57C
; ---------------------------------------------------------------------------

loc_1D4C2:				; CODE XREF: sub_1D358+165j
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	al, [bx+21ABh]
		sub	ah, ah
		or	ax, ax
		jz	short loc_1D4E8
		cmp	ax, 1
		jz	short loc_1D51C
		cmp	ax, 2
		jz	short loc_1D53C
		jmp	loc_1D6D8
; ---------------------------------------------------------------------------

loc_1D4E8:				; CODE XREF: sub_1D358+181j
		call	sub_1525A
		and	ax, 3
		jz	short loc_1D4FE
		cmp	ax, 1
		jz	short loc_1D508
		cmp	ax, 2
		jz	short loc_1D512
		jmp	short loc_1D530
; ---------------------------------------------------------------------------

loc_1D4FE:				; CODE XREF: sub_1D358+198j
					; sub_1D358+1D6j
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1CB20
		jmp	short loc_1D4A0
; ---------------------------------------------------------------------------
		align 2

loc_1D508:				; CODE XREF: sub_1D358+19Dj
					; sub_1D358+1D1j
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1CF1E
		jmp	short loc_1D4A0
; ---------------------------------------------------------------------------
		align 2

loc_1D512:				; CODE XREF: sub_1D358+1A2j
					; sub_1D358+1CCj
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1CA9C
		jmp	short loc_1D4A0
; ---------------------------------------------------------------------------
		align 2

loc_1D51C:				; CODE XREF: sub_1D358+186j
		call	sub_1525A
		and	ax, 3
		jz	short loc_1D512
		cmp	ax, 1
		jz	short loc_1D508
		cmp	ax, 2
		jz	short loc_1D4FE

loc_1D530:				; CODE XREF: sub_1D358+1A4j
					; sub_1D358+26Bj
		cmp	ax, 3
		jnz	short loc_1D538
		jmp	loc_1D5D8
; ---------------------------------------------------------------------------

loc_1D538:				; CODE XREF: sub_1D358+1DBj
		jmp	loc_1D6D8
; ---------------------------------------------------------------------------
		align 2

loc_1D53C:				; CODE XREF: sub_1D358+18Bj
		call	sub_1525A
		and	ax, 3
		jz	short loc_1D558
		cmp	ax, 1
		jz	short loc_1D558
		cmp	ax, 2
		jz	short loc_1D562
		cmp	ax, 3
		jz	short loc_1D56C
		jmp	loc_1D6D8
; ---------------------------------------------------------------------------

loc_1D558:				; CODE XREF: sub_1D358+1ECj
					; sub_1D358+1F1j
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1CBEE
		jmp	loc_1D4A0
; ---------------------------------------------------------------------------

loc_1D562:				; CODE XREF: sub_1D358+1F6j
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1CD7A
		jmp	loc_1D4A0
; ---------------------------------------------------------------------------

loc_1D56C:				; CODE XREF: sub_1D358+1FBj
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		mov	byte ptr [bx+21ADh], 2
		jmp	loc_1D6D8
; ---------------------------------------------------------------------------

loc_1D57C:				; CODE XREF: sub_1D358+167j
		cmp	[bp+var_6], 40h	; '@'
		jl	short loc_1D585
		jmp	loc_1D634
; ---------------------------------------------------------------------------

loc_1D585:				; CODE XREF: sub_1D358+228j
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	al, [bx+21ABh]
		sub	ah, ah
		or	ax, ax
		jz	short loc_1D5AC
		cmp	ax, 1
		jz	short loc_1D5E2
		cmp	ax, 2
		jz	short loc_1D60C
		jmp	loc_1D6D8
; ---------------------------------------------------------------------------
		align 2

loc_1D5AC:				; CODE XREF: sub_1D358+244j
		call	sub_1525A
		and	ax, 3
		jnz	short loc_1D5B9
		jmp	loc_1D652
; ---------------------------------------------------------------------------

loc_1D5B9:				; CODE XREF: sub_1D358+25Cj
		cmp	ax, 1
		jz	short loc_1D5C6
		cmp	ax, 2
		jz	short loc_1D62A
		jmp	loc_1D530
; ---------------------------------------------------------------------------

loc_1D5C6:				; CODE XREF: sub_1D358+264j
					; sub_1D358+29Fj
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	ax, [si+2194h]
		imul	[bp+var_2]
		jmp	loc_1D479
; ---------------------------------------------------------------------------

loc_1D5D8:				; CODE XREF: sub_1D358+1DDj
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1CC72
		jmp	loc_1D4A0
; ---------------------------------------------------------------------------

loc_1D5E2:				; CODE XREF: sub_1D358+249j
		call	sub_1525A
		and	ax, 3
		jnz	short loc_1D5EF
		jmp	loc_1D694
; ---------------------------------------------------------------------------

loc_1D5EF:				; CODE XREF: sub_1D358+292j
		cmp	ax, 1
		jz	short loc_1D602
		cmp	ax, 2
		jz	short loc_1D5C6
		cmp	ax, 3
		jz	short loc_1D62A
		jmp	loc_1D6D8
; ---------------------------------------------------------------------------
		align 2

loc_1D602:				; CODE XREF: sub_1D358+29Aj
					; sub_1D358+2CBj
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1CC30
		jmp	loc_1D4A0
; ---------------------------------------------------------------------------

loc_1D60C:				; CODE XREF: sub_1D358+24Ej
		call	sub_1525A
		and	ax, 3
		jz	short loc_1D652
		cmp	ax, 1
		jz	short loc_1D694
		cmp	ax, 2
		jz	short loc_1D62A
		cmp	ax, 3
		jz	short loc_1D602
		jmp	loc_1D6D8
; ---------------------------------------------------------------------------
		db 2 dup(90h)
; ---------------------------------------------------------------------------

loc_1D62A:				; CODE XREF: sub_1D358+269j
					; sub_1D358+2A4j ...
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1CADE
		jmp	loc_1D4A0
; ---------------------------------------------------------------------------

loc_1D634:				; CODE XREF: sub_1D358+22Aj
		cmp	[bp+var_6], 60h	; '`'
		jge	short loc_1D67E
		call	sub_1525A
		and	ax, 7
		cmp	ax, 7
		jbe	short loc_1D64A
		jmp	loc_1D6D8
; ---------------------------------------------------------------------------

loc_1D64A:				; CODE XREF: sub_1D358+2EDj
		add	ax, ax
		xchg	ax, bx
		jmp	cs:off_1D66C[bx]

loc_1D652:				; CODE XREF: sub_1D358+25Ej
					; sub_1D358+2BCj ...
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1CEB4
		jmp	loc_1D4A0
; ---------------------------------------------------------------------------

loc_1D65C:				; CODE XREF: sub_1D358+2F5j
					; sub_1D358+336j
					; DATA XREF: ...
		cmp	[bp+var_6], 60h	; '`'
		jg	short loc_1D6A6

loc_1D662:				; CODE XREF: sub_1D358+34Cj
		cmp	[bp+var_6], 50h	; 'P'
		jge	short loc_1D6C8

loc_1D668:				; CODE XREF: sub_1D358+36Ej
		mov	al, 2
		jmp	short loc_1D6CA
; ---------------------------------------------------------------------------
off_1D66C	dw offset loc_1D694	; DATA XREF: sub_1D358+2F5r
		dw offset loc_1D652
		dw offset loc_1D652
		dw offset loc_1D65C
		dw offset loc_1D65C
		dw offset loc_1D65C
		dw offset loc_1D65C
		dw offset loc_1D6BC
; ---------------------------------------------------------------------------
		jmp	short loc_1D6D8
; ---------------------------------------------------------------------------

loc_1D67E:				; CODE XREF: sub_1D358+2E0j
		call	sub_1525A
		and	ax, 7
		cmp	ax, 7
		ja	short loc_1D6D8
		add	ax, ax
		xchg	ax, bx
		jmp	cs:off_1D6AA[bx]
; ---------------------------------------------------------------------------
		align 2

loc_1D694:				; CODE XREF: sub_1D358+294j
					; sub_1D358+2C1j ...
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		jmp	loc_1D472
; ---------------------------------------------------------------------------
		align 2

loc_1D6A0:				; CODE XREF: sub_1D358+336j
					; DATA XREF: sub_1D358+358o
		cmp	[bp+var_6], 60h	; '`'
		jle	short loc_1D662

loc_1D6A6:				; CODE XREF: sub_1D358+308j
					; sub_1D358+368j
		mov	al, 1
		jmp	short loc_1D6CA
; ---------------------------------------------------------------------------
off_1D6AA	dw offset loc_1D694	; DATA XREF: sub_1D358+336r
		dw offset loc_1D499
		dw offset loc_1D652
		dw offset loc_1D6A0
		dw offset loc_1D6BC
		dw offset loc_1D65C
		dw offset loc_1D65C
		dw offset loc_1D65C
; ---------------------------------------------------------------------------
		jmp	short loc_1D6D8
; ---------------------------------------------------------------------------

loc_1D6BC:				; CODE XREF: sub_1D358+15Ej
					; sub_1D358+2F5j ...
		cmp	[bp+var_6], 60h	; '`'
		jg	short loc_1D6A6
		cmp	[bp+var_6], 50h	; 'P'
		jl	short loc_1D668

loc_1D6C8:				; CODE XREF: sub_1D358+30Ej
		sub	al, al

loc_1D6CA:				; CODE XREF: sub_1D358+312j
					; sub_1D358+350j
		mov	cx, ax
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		mov	[bx+21ADh], cl

loc_1D6D8:				; CODE XREF: sub_1D358+EAj
					; sub_1D358+F4j ...
		mov	ax, [bp+var_8]
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_1D358	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1D6E2	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 4
		push	di
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+2178h]
		cmp	[bx+2178h], ax
		jle	short loc_1D71E
		mov	ax, cx
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		jmp	short loc_1D732
; ---------------------------------------------------------------------------

loc_1D71E:				; CODE XREF: sub_1D6E2+27j
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, cx
		imul	[bp+arg_0]

loc_1D732:				; CODE XREF: sub_1D6E2+3Aj
		mov	di, ax
		mov	ax, [di+2178h]
		sub	ax, [bx+2178h]
		mov	[bp+var_2], ax
		call	sub_1525A
		sub	ah, ah
		and	ax, 7
		cmp	ax, word_2A9F4
		jnb	short loc_1D7C6
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+217Ah]
		cmp	[bx+217Ah], ax
		jle	short loc_1D7C6
		cmp	[bp+var_2], 0A0h ; '�'
		jge	short loc_1D7C6
		cmp	[bp+var_2], 50h	; 'P'
		jge	short loc_1D794
		call	sub_1525A
		and	al, 1
		cmp	al, 1
		jnz	short loc_1D78A
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1CCB4
		jmp	short loc_1D7C3
; ---------------------------------------------------------------------------
		align 2

loc_1D78A:				; CODE XREF: sub_1D6E2+9Cj
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1CE72
		jmp	short loc_1D7C3
; ---------------------------------------------------------------------------
		align 2

loc_1D794:				; CODE XREF: sub_1D6E2+91j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	word ptr [bx+217Eh], 0Ah
		jge	short loc_1D7BC
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	word ptr [bx+217Eh], 0FFF6h
		jle	short loc_1D7BC
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1CE16
		jmp	short loc_1D7C3
; ---------------------------------------------------------------------------
		align 2

loc_1D7BC:				; CODE XREF: sub_1D6E2+BFj
					; sub_1D6E2+CEj
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1CB62

loc_1D7C3:				; CODE XREF: sub_1D6E2+A5j
					; sub_1D6E2+AFj ...
		add	sp, 2

loc_1D7C6:				; CODE XREF: sub_1D6E2+6Bj
					; sub_1D6E2+84j ...
		mov	ax, [bp+var_4]
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_1D6E2	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1D7D0	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 4
		push	di
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+2178h]
		cmp	[bx+2178h], ax
		jle	short loc_1D80C
		mov	ax, cx
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		jmp	short loc_1D820
; ---------------------------------------------------------------------------

loc_1D80C:				; CODE XREF: sub_1D7D0+27j
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, cx
		imul	[bp+arg_0]

loc_1D820:				; CODE XREF: sub_1D7D0+3Aj
		mov	di, ax
		mov	ax, [di+2178h]
		sub	ax, [bx+2178h]
		mov	[bp+var_2], ax
		call	sub_1525A
		sub	ah, ah
		and	ax, 7
		cmp	ax, word_2A9F4
		jnb	short loc_1D8B4
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+217Ah]
		cmp	[bx+217Ah], ax
		jle	short loc_1D8B4
		cmp	[bp+var_2], 0A0h ; '�'
		jge	short loc_1D8B4
		cmp	[bp+var_2], 50h	; 'P'
		jge	short loc_1D882
		call	sub_1525A
		and	al, 1
		cmp	al, 1
		jnz	short loc_1D878
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1CCB4
		jmp	short loc_1D8B1
; ---------------------------------------------------------------------------
		align 2

loc_1D878:				; CODE XREF: sub_1D7D0+9Cj
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1CE72
		jmp	short loc_1D8B1
; ---------------------------------------------------------------------------
		align 2

loc_1D882:				; CODE XREF: sub_1D7D0+91j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	word ptr [bx+217Eh], 0Ah
		jge	short loc_1D8AA
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	word ptr [bx+217Eh], 0FFF6h
		jle	short loc_1D8AA
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1CE16
		jmp	short loc_1D8B1
; ---------------------------------------------------------------------------
		align 2

loc_1D8AA:				; CODE XREF: sub_1D7D0+BFj
					; sub_1D7D0+CEj
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1CB62

loc_1D8B1:				; CODE XREF: sub_1D7D0+A5j
					; sub_1D7D0+AFj ...
		add	sp, 2

loc_1D8B4:				; CODE XREF: sub_1D7D0+6Bj
					; sub_1D7D0+84j ...
		mov	ax, [bp+var_4]
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_1D7D0	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1D8BE	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 4
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	al, [si+21ADh]
		sub	ah, ah
		mov	[bp+var_4], ax
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1D358
		add	sp, 2
		mov	[bp+var_2], ax
		cmp	byte ptr [si+21AAh], 4
		jnz	short loc_1D8F1
		mov	al, byte ptr [bp+var_4]
		mov	[si+21ADh], al

loc_1D8F1:				; CODE XREF: sub_1D8BE+2Aj
		mov	ax, [bp+var_2]
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_1D8BE	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1D8FA	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 4
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	al, [si+21ADh]
		sub	ah, ah
		mov	[bp+var_4], ax
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1D358
		add	sp, 2
		mov	[bp+var_2], ax
		cmp	byte ptr [si+21AAh], 5
		jnz	short loc_1D92D
		mov	al, byte ptr [bp+var_4]
		mov	[si+21ADh], al

loc_1D92D:				; CODE XREF: sub_1D8FA+2Aj
		mov	ax, [bp+var_2]
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_1D8FA	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1D936	proc far		; CODE XREF: sub_11230+1B1P
					; sub_11230+1C4P ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	ax, 14h
		imul	[bp+arg_0]
		mov	cl, 3
		shl	ax, cl
		add	ax, 0F0h ; '�'
		mov	[si+2178h], ax
		mov	word ptr [si+217Ah], 9Eh ; '�'
		mov	word ptr [si+217Ch], 0
		mov	word ptr [si+217Ch], 0
		mov	word ptr [si+217Eh], 0
		mov	word ptr [si+2182h], 0
		mov	word ptr [si+2180h], 0C9h ; '�'
		mov	word ptr [si+2184h], 0
		mov	word ptr [si+2188h], 0
		mov	word ptr [si+218Ah], 0
		mov	word ptr [si+218Ch], 0
		mov	word ptr [si+219Ah], 0
		mov	word ptr [si+219Ch], 0
		mov	word ptr [si+219Eh], 0
		mov	word ptr [si+21A0h], 0
		mov	word ptr [si+21A2h], 0
		mov	word ptr [si+21A4h], 0
		mov	word ptr [si+21A6h], 0
		mov	word ptr [si+218Eh], 0FFB0h
		mov	word ptr [si+2190h], 0Ch
		mov	word ptr [si+2192h], 3
		mov	word ptr [si+2194h], 8
		mov	word ptr [si+2196h], 4
		mov	byte ptr [si+21A8h], 0
		mov	word ptr [si+2198h], 0
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	[si+21A9h], al
		mov	byte ptr [si+21AAh], 0
		mov	byte ptr [si+21ABh], 0
		mov	byte ptr [si+21ACh], 0
		mov	byte ptr [si+21ADh], 0
		mov	byte ptr [si+21AEh], 6
		mov	byte ptr [si+21AFh], 0
		mov	[si+21B0h], cl
		mov	byte ptr [si+21B1h], 0
		mov	byte ptr [si+21B2h], 0
		mov	byte ptr [si+21B3h], 10h
		mov	byte ptr [si+21B4h], 15h
		mov	byte ptr [si+21B5h], 6
		mov	byte ptr [si+21B6h], 9
		mov	byte ptr [si+21B7h], 0Ah
		mov	byte ptr [si+21B8h], 0Eh
		mov	byte ptr [si+21B9h], 0Fh
		mov	byte ptr [si+21BAh], 0Ch
		mov	byte ptr [si+21BBh], 0Dh
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21BCh], 1
		mov	byte ptr [si+21BDh], 0
		mov	byte ptr [si+21BEh], 0Bh
		mov	byte ptr [si+21BFh], 2
		mov	[si+21C0h], cl
		mov	byte ptr [si+21C1h], 5
		mov	byte ptr [si+21C2h], 43h ; 'C'
		pop	si
		pop	bp
		retf
sub_1D936	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1DA74	proc far		; CODE XREF: sub_12822+34P
					; sub_12822+52P ...

var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	si
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	word ptr [bx+2180h], 0
		jle	short loc_1DA9B
		cmp	word_2CEE8, 0
		jz	short loc_1DA9B
		jmp	loc_1DB49
; ---------------------------------------------------------------------------

loc_1DA9B:				; CODE XREF: sub_1DA74+1Bj
					; sub_1DA74+22j
		mov	si, [bp+arg_0]
		shl	si, 1
		mov	word ptr [si+2514h], 0
		mov	word ptr [si+2448h], 0
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	byte ptr [bx+21AAh], 0
		jnz	short loc_1DAD1
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	byte ptr [bx+21AAh], 0Ah
		jz	short loc_1DB00

loc_1DAD1:				; CODE XREF: sub_1DA74+45j
		cmp	word_2CEE8, 0
		jnz	short loc_1DB49
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+2180h]
		cmp	[bx+2180h], ax
		jge	short loc_1DB49
		cmp	byte ptr [si+21AAh], 0
		jnz	short loc_1DB49

loc_1DB00:				; CODE XREF: sub_1DA74+5Bj
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21AAh], 12h
		mov	byte ptr [si+21B0h], 4
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21ADh], 14h
		mov	byte ptr [si+21AEh], 3Fh ; '?'
		mov	byte ptr [si+21B1h], 42h ; 'B'
		mov	byte ptr [si+21B2h], 42h ; 'B'
		mov	bx, [bp+arg_0]
		shl	bx, 1
		inc	word ptr [bx+2646h]
		mov	ax, 2
		push	ax
		push	[bp+arg_0]
		call	sub_15C20
		add	sp, 4
		mov	word_2A9E4, 1

loc_1DB49:				; CODE XREF: sub_1DA74+24j
					; sub_1DA74+62j ...
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	ax, [bx+2514h]
		mov	[bp+var_2], ax
		push	[bp+arg_0]
		call	sub_107EA
		add	sp, 2
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	word ptr [si+2186h], 0
		jnz	short loc_1DB96
		push	[bp+arg_0]
		mov	bl, [si+21AAh]
		sub	bh, bh
		shl	bx, 1
		shl	bx, 1
		call	off_2C39E[bx]
		add	sp, 2
		push	[bp+arg_0]
		mov	bl, [si+21AAh]
		sub	bh, bh
		shl	bx, 1
		shl	bx, 1
		call	off_2C466[bx]
		jmp	short loc_1DBD9
; ---------------------------------------------------------------------------

loc_1DB96:				; CODE XREF: sub_1DA74+F9j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		add	si, 21AAh
		push	[bp+arg_0]
		mov	bl, [si]
		sub	bh, bh
		shl	bx, 1
		shl	bx, 1
		call	off_2C402[bx]
		add	sp, 2
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	word ptr [bx+2180h], 0
		jle	short loc_1DBDC
		push	[bp+arg_0]
		mov	bl, [si]
		sub	bh, bh
		shl	bx, 1
		shl	bx, 1
		call	off_2C4CA[bx]

loc_1DBD9:				; CODE XREF: sub_1DA74+120j
		add	sp, 2

loc_1DBDC:				; CODE XREF: sub_1DA74+154j
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1DC10
		add	sp, 2
		push	[bp+arg_0]
		call	sub_233A6
		add	sp, 2
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		mov	ax, [bp+var_2]
		mov	[bx+2198h], ax
		push	[bp+arg_0]
		call	sub_2398E
		add	sp, 2
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_1DA74	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1DC10	proc far		; CODE XREF: sub_1DA74+16Cp

var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	di
		push	si
		mov	[bp+var_2], 0
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	word ptr [si+21A6h], 1
		jnz	short loc_1DC82
		inc	word ptr [si+219Ah]
		cmp	word ptr [si+219Ah], 3Eh ; '>'
		jle	short loc_1DC3D
		mov	word ptr [si+219Ah], 3Dh ; '='

loc_1DC3D:				; CODE XREF: sub_1DC10+25j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	word ptr [si+219Ch], 0
		jnz	short loc_1DC52
		mov	ax, 0FFF0h
		jmp	short loc_1DC55
; ---------------------------------------------------------------------------
		align 2

loc_1DC52:				; CODE XREF: sub_1DC10+3Aj
		mov	ax, 10h

loc_1DC55:				; CODE XREF: sub_1DC10+3Fj
		add	[si+21A2h], ax
		mov	di, word_2A9DC
		mov	cl, 3
		shl	di, cl
		lea	ax, [di-20h]
		cmp	[si+21A2h], ax
		jl	short loc_1DC74
		lea	ax, [di+160h]
		cmp	[si+21A2h], ax
		jle	short loc_1DC82

loc_1DC74:				; CODE XREF: sub_1DC10+58j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		mov	word ptr [bx+21A6h], 0

loc_1DC82:				; CODE XREF: sub_1DC10+1Aj
					; sub_1DC10+62j
		mov	ax, [bp+var_2]
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_1DC10	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1DC8C	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21ABh], 0
		mov	byte ptr [si+21ACh], 0
		inc	byte ptr [si+21AFh]
		mov	al, [si+21AFh]
		cmp	[si+21B0h], al
		ja	short loc_1DD21
		mov	byte ptr [si+21AFh], 0
		inc	byte ptr [si+21AEh]
		cmp	byte ptr [si+21AEh], 3Ah ; ':'
		jnz	short loc_1DD0D
		cmp	byte ptr [si+21A9h], 0
		jnz	short loc_1DCD0
		mov	ax, 0FFF8h
		jmp	short loc_1DCD3
; ---------------------------------------------------------------------------
		align 2

loc_1DCD0:				; CODE XREF: sub_1DC8C+3Cj
		mov	ax, 8

loc_1DCD3:				; CODE XREF: sub_1DC8C+41j
		add	ax, [si+2178h]
		mov	[si+21A2h], ax
		mov	ax, [si+217Ah]
		sub	ax, 24h	; '$'
		mov	[si+21A4h], ax
		mov	al, [si+21A9h]
		sub	ah, ah
		mov	[si+219Ch], ax
		mov	word ptr [si+219Ah], 3Dh ; '='
		mov	word ptr [si+21A6h], 1
		mov	word ptr [si+219Eh], 0
		mov	word ptr [si+21A0h], 0
		mov	byte ptr [si+21B0h], 3

loc_1DD0D:				; CODE XREF: sub_1DC8C+35j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	byte ptr [si+21AEh], 3Bh ; ';'
		jnz	short loc_1DD21
		mov	byte ptr [si+21B0h], 2

loc_1DD21:				; CODE XREF: sub_1DC8C+25j
					; sub_1DC8C+8Ej
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	byte ptr [bx+21AEh], 3Ch ; '<'
		jbe	short loc_1DD3B
		push	[bp+arg_0]
		call	sub_21F4C
		add	sp, 2

loc_1DD3B:				; CODE XREF: sub_1DC8C+A2j
		mov	ax, [bp+var_2]
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_1DC8C	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1DD44	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21ABh], 2
		mov	byte ptr [si+21ACh], 1
		cmp	byte ptr [si+21ADh], 0
		jnz	short loc_1DD87
		inc	byte ptr [si+21AFh]
		mov	al, [si+21AFh]
		cmp	[si+21B0h], al
		ja	short loc_1DD87
		mov	byte ptr [si+21AFh], 0
		inc	byte ptr [si+21AEh]
		cmp	byte ptr [si+21AEh], 2Eh ; '.'
		jbe	short loc_1DD87
		mov	byte ptr [si+21AEh], 2Bh ; '+'

loc_1DD87:				; CODE XREF: sub_1DD44+1Ej
					; sub_1DD44+2Cj ...
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	ax, [si+217Ch]
		add	[si+2178h], ax
		mov	ax, [si+217Eh]
		add	[si+217Ah], ax
		cmp	word ptr [si+217Ah], 9Eh ; '�'
		jle	short loc_1DDDC
		mov	word ptr [si+217Ah], 9Eh ; '�'
		mov	byte ptr [si+21B0h], 3
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21ADh], 2
		mov	byte ptr [si+21AAh], 0Ch
		mov	al, [si+21B5h]
		mov	[si+21B1h], al
		mov	[si+21B2h], al
		mov	[si+21AEh], al
		push	[bp+arg_0]
		call	sub_21EF8
		add	sp, 2

loc_1DDDC:				; CODE XREF: sub_1DD44+61j
		mov	ax, [bp+var_2]
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_1DD44	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1DDE4	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21ABh], 2
		mov	byte ptr [si+21ACh], 3
		push	[bp+arg_0]
		call	sub_2274C
		add	sp, 2
		cmp	ax, 1
		jnz	short loc_1DE37
		push	[bp+arg_0]
		call	sub_21EF8
		add	sp, 2
		mov	al, [si+21B5h]
		mov	[si+21B1h], al
		mov	[si+21B2h], al
		mov	byte ptr [si+21B0h], 1
		mov	byte ptr [si+21AFh], 0
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 0Ch

loc_1DE37:				; CODE XREF: sub_1DDE4+27j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	word ptr [si+2188h], 0
		jz	short loc_1DE7D
		mov	ax, [si+218Eh]
		cwd
		sub	ax, dx
		sar	ax, 1
		mov	[si+217Eh], ax
		mov	ax, [si+217Ch]
		sub	[si+217Ch], ax
		mov	byte ptr [si+21AAh], 2
		mov	al, [si+21B8h]
		mov	[si+21B1h], al
		mov	al, [si+21B9h]
		mov	[si+21B2h], al
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21B0h], 4

loc_1DE7D:				; CODE XREF: sub_1DDE4+60j
		mov	ax, [bp+var_2]
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_1DDE4	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1DE86	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 4
		push	di
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+2178h]
		cmp	[bx+2178h], ax
		jle	short loc_1DEC2
		mov	ax, cx
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		jmp	short loc_1DED6
; ---------------------------------------------------------------------------

loc_1DEC2:				; CODE XREF: sub_1DE86+27j
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, cx
		imul	[bp+arg_0]

loc_1DED6:				; CODE XREF: sub_1DE86+3Aj
		mov	di, ax
		mov	ax, [di+2178h]
		sub	ax, [bx+2178h]
		mov	[bp+var_2], ax
		mov	byte ptr [si+21ACh], 1
		mov	byte ptr [si+21ABh], 0
		mov	byte ptr [si+21B0h], 1
		inc	byte ptr [si+21ADh]
		cmp	byte ptr [si+21AEh], 35h ; '5'
		jz	short loc_1DF1C
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		inc	byte ptr [si+21AFh]
		mov	al, [si+21AFh]
		cmp	[si+21B0h], al
		ja	short loc_1DF24
		mov	byte ptr [si+21AFh], 0
		inc	byte ptr [si+21AEh]

loc_1DF1C:				; CODE XREF: sub_1DE86+75j
		mov	ax, [si+217Ch]
		add	[si+2178h], ax

loc_1DF24:				; CODE XREF: sub_1DE86+8Bj
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	byte ptr [si+21ADh], 8
		jbe	short loc_1DF5D
		push	[bp+arg_0]
		call	sub_21EF8
		add	sp, 2
		mov	al, [si+21B5h]
		mov	[si+21B1h], al
		mov	[si+21B2h], al
		mov	byte ptr [si+21B0h], 1
		mov	byte ptr [si+21AFh], 0
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 0Ch

loc_1DF5D:				; CODE XREF: sub_1DE86+ABj
		mov	ax, [bp+var_4]
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_1DE86	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1DF66	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	di
		push	si
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21A8h], 1
		inc	byte ptr [si+21ADh]
		cmp	byte ptr [si+21ADh], 17h
		ja	short loc_1DF8F
		jmp	loc_1E0A2
; ---------------------------------------------------------------------------

loc_1DF8F:				; CODE XREF: sub_1DF66+24j
		cmp	byte ptr [si+21ADh], 18h
		jz	short loc_1DF99
		jmp	loc_1E05D
; ---------------------------------------------------------------------------

loc_1DF99:				; CODE XREF: sub_1DF66+2Ej
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	byte ptr [bx+21AAh], 9
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	di, ax
		mov	ax, [di+218Eh]
		cwd
		sub	ax, dx
		sar	ax, 1
		mov	[bx+217Eh], ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	al, [bx+21BFh]
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+21AEh], cl
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	byte ptr [bx+21A9h], 0
		jnz	short loc_1E012
		mov	ax, 10h
		jmp	short loc_1E015
; ---------------------------------------------------------------------------

loc_1E012:				; CODE XREF: sub_1DF66+A5j
		mov	ax, 0FFF0h

loc_1E015:				; CODE XREF: sub_1DF66+AAj
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+217Ch], cx
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	byte ptr [si+21A9h], 1
		sbb	ax, ax
		neg	ax
		mov	[bx+21A9h], al
		mov	byte ptr [si+21A8h], 0
		mov	byte ptr [si+21B0h], 3
		mov	byte ptr [si+21AFh], 0
		mov	al, [si+21B5h]
		mov	[si+21AEh], al

loc_1E05D:				; CODE XREF: sub_1DF66+30j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	byte ptr [si+21ADh], 1Eh
		jz	short loc_1E06F
		jmp	loc_1E30C
; ---------------------------------------------------------------------------

loc_1E06F:				; CODE XREF: sub_1DF66+104j
		mov	byte ptr [si+21A8h], 0
		push	[bp+arg_0]
		call	sub_21EF8
		add	sp, 2
		mov	al, [si+21B5h]
		mov	[si+21B1h], al
		mov	[si+21B2h], al
		mov	byte ptr [si+21B0h], 1
		mov	byte ptr [si+21AFh], 0
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 0Ch
		jmp	loc_1E30C
; ---------------------------------------------------------------------------
		align 2

loc_1E0A2:				; CODE XREF: sub_1DF66+26j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	al, [si+21ADh]
		and	al, 2
		cmp	al, 2
		jz	short loc_1E0B7
		jmp	loc_1E26C
; ---------------------------------------------------------------------------

loc_1E0B7:				; CODE XREF: sub_1DF66+14Cj
		mov	ax, 5
		push	ax
		call	sub_15BEE
		add	sp, 2
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	byte ptr [bx+21AAh], 10h
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		cmp	byte ptr [si+21A9h], 1
		sbb	ax, ax
		neg	ax
		mov	[bx+21A9h], al
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	ax, [si+217Ah]
		sub	ax, 4
		mov	[bx+217Ah], ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	al, [bx+21BCh]
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+21AEh], cl
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		cmp	byte ptr [si+21A9h], 0
		jnz	short loc_1E140
		mov	ax, 0FFF8h
		jmp	short loc_1E143
; ---------------------------------------------------------------------------

loc_1E140:				; CODE XREF: sub_1DF66+1D3j
		mov	ax, 8

loc_1E143:				; CODE XREF: sub_1DF66+1D8j
		add	ax, [si+2178h]
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+2178h], cx
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	[bp+arg_0], 1
		sbb	di, di
		neg	di
		shl	di, 1
		mov	ax, [di+2A2Ch]
		shl	ax, 1
		shl	ax, 1
		add	ax, 4
		cwd
		xor	ax, dx
		sub	ax, dx
		mov	cx, 2
		sar	ax, cl
		xor	ax, dx
		sub	ax, dx
		sub	[bx+2180h], ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	word ptr [bx+2180h], 0
		jle	short loc_1E1AB
		jmp	loc_1E30C
; ---------------------------------------------------------------------------

loc_1E1AB:				; CODE XREF: sub_1DF66+240j
		mov	ax, 10h
		push	ax
		call	sub_15BEE
		add	sp, 2
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	byte ptr [bx+21AAh], 9
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	di, ax
		mov	ax, [di+218Eh]
		cwd
		sub	ax, dx
		sar	ax, 1
		mov	[bx+217Eh], ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	al, [bx+21BFh]
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+21AEh], cl
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	byte ptr [bx+21A9h], 0
		jnz	short loc_1E230
		mov	ax, 10h
		jmp	short loc_1E233
; ---------------------------------------------------------------------------

loc_1E230:				; CODE XREF: sub_1DF66+2C3j
		mov	ax, 0FFF0h

loc_1E233:				; CODE XREF: sub_1DF66+2C8j
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+217Ch], cx
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	byte ptr [si+21A9h], 1
		sbb	ax, ax
		neg	ax
		mov	[bx+21A9h], al
		mov	byte ptr [si+21ADh], 19h
		jmp	loc_1E30C
; ---------------------------------------------------------------------------

loc_1E26C:				; CODE XREF: sub_1DF66+14Ej
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	byte ptr [bx+21AAh], 10h
		mov	ax, cx
		imul	[bp+arg_0]
		mov	si, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		cmp	byte ptr [si+21A9h], 1
		sbb	ax, ax
		neg	ax
		mov	[bx+21A9h], al
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	ax, [si+217Ah]
		sub	ax, 6
		mov	[bx+217Ah], ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	al, [bx+21BDh]
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+21AEh], cl
		mov	al, [si+21B2h]
		mov	[si+21AEh], al
		cmp	byte ptr [si+21A9h], 0
		jnz	short loc_1E2F0
		mov	ax, 0FFF0h
		jmp	short loc_1E2F3
; ---------------------------------------------------------------------------

loc_1E2F0:				; CODE XREF: sub_1DF66+383j
		mov	ax, 10h

loc_1E2F3:				; CODE XREF: sub_1DF66+388j
		add	ax, [si+2178h]
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+2178h], cx

loc_1E30C:				; CODE XREF: sub_1DF66+106j
					; sub_1DF66+138j ...
		mov	ax, [bp+var_2]
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_1DF66	endp

seg006		ends

; ===========================================================================

; Segment type:	Pure code
seg007		segment	byte public 'CODE' use16
		assume cs:seg007
		;org 5
		assume es:nothing, ss:nothing, ds:seg026, fs:nothing, gs:nothing
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1E316	proc far		; CODE XREF: sub_1E7FA+92p
					; sub_1E8F8+F3p ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+2184h], 0Ch
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ACh], 1
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 1
		mov	byte ptr [si+21B1h], 10h
		mov	byte ptr [si+21B2h], 11h
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 0Ch
		pop	si
		pop	bp
		retf
sub_1E316	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1E358	proc far		; CODE XREF: sub_1E8F8+FCp
					; sub_1F0A4+2E6p

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+2184h], 0Ch
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ACh], 1
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 1
		mov	byte ptr [si+21B1h], 12h
		mov	byte ptr [si+21B2h], 15h
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 0Ch
		pop	si
		pop	bp
		retf
sub_1E358	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1E39A	proc far		; CODE XREF: sub_1EB08+85p
					; sub_1F0A4+204p

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+2184h], 0Ch
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ACh], 1
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 2
		mov	byte ptr [si+21B1h], 1Eh
		mov	byte ptr [si+21B2h], 1Eh
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 0Fh
		pop	si
		pop	bp
		retf
sub_1E39A	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1E3DC	proc far		; CODE XREF: sub_1EC50+CCp
					; sub_1F448+138p

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+2184h], 0Ch
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ACh], 3
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 2
		mov	byte ptr [si+21B1h], 2Ch ; ','
		mov	byte ptr [si+21B2h], 2Dh ; '-'
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 0Dh
		mov	byte ptr [si+21ADh], 0Ah
		pop	si
		pop	bp
		retf
sub_1E3DC	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1E422	proc far		; CODE XREF: sub_1EE6A+CCp
					; sub_1F5E6+138p

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+2184h], 0Ch
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ACh], 3
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 2
		mov	byte ptr [si+21B1h], 2Ch ; ','
		mov	byte ptr [si+21B2h], 2Dh ; '-'
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21ADh], 0Ah
		mov	byte ptr [si+21AAh], 0Eh
		pop	si
		pop	bp
		retf
sub_1E422	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1E468	proc far		; CODE XREF: sub_1E8F8+11Bp
					; sub_1F0A4+1D0p

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+2184h], 18h
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ACh], 1
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 2
		mov	byte ptr [si+21B1h], 1Bh
		mov	byte ptr [si+21B2h], 1Dh
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 0Ch
		pop	si
		pop	bp
		retf
sub_1E468	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1E4AA	proc far		; CODE XREF: sub_1E8F8+124p
					; sub_1F0A4+2BCp

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+2184h], 18h
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ACh], 2
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 2
		mov	byte ptr [si+21B1h], 16h
		mov	byte ptr [si+21B2h], 1Ah
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 0Ch
		pop	si
		pop	bp
		retf
sub_1E4AA	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1E4EC	proc far		; CODE XREF: sub_1EB08+9Ep
					; sub_1F0A4+1B2p

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+2184h], 18h
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ACh], 2
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 2
		mov	byte ptr [si+21B1h], 1Fh
		mov	byte ptr [si+21B2h], 21h ; '!'
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 0Fh
		pop	si
		pop	bp
		retf
sub_1E4EC	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1E52E	proc far		; CODE XREF: sub_1EC50+198p
					; sub_1F448+12Ep

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+2184h], 18h
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ACh], 3
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 1
		mov	byte ptr [si+21B1h], 2Bh ; '+'
		mov	byte ptr [si+21B2h], 2Bh ; '+'
		mov	byte ptr [si+21ADh], 0Ah
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 0Dh
		pop	si
		pop	bp
		retf
sub_1E52E	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1E574	proc far		; CODE XREF: sub_1EE6A+198p
					; sub_1F5E6+12Ep

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+2184h], 18h
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ACh], 3
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 2
		mov	byte ptr [si+21B1h], 30h ; '0'
		mov	byte ptr [si+21B2h], 32h ; '2'
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21ADh], 0Fh
		mov	byte ptr [si+21AAh], 0Eh
		pop	si
		pop	bp
		retf
sub_1E574	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1E5BA	proc far		; CODE XREF: sub_1E8F8+B0p
					; sub_1EB08+62p ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+217Ch], 0
		mov	byte ptr [si+21B0h], 4
		mov	byte ptr [si+21AAh], 3
		mov	byte ptr [si+21B1h], 32h ; '2'
		mov	byte ptr [si+21B2h], 34h ; '4'
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	ax, [si+218Eh]
		mov	[si+217Eh], ax
		pop	si
		pop	bp
		retf
sub_1E5BA	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1E5F4	proc far		; CODE XREF: sub_1E8F8+BAp
					; sub_1EB08+6Cp ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21B0h], 2
		cmp	byte ptr [si+21A9h], 0
		jnz	short loc_1E613
		cmp	word ptr [si+217Ch], 0
		jg	short loc_1E629

loc_1E613:				; CODE XREF: sub_1E5F4+16j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	byte ptr [si+21A9h], 1
		jnz	short loc_1E642
		cmp	word ptr [si+217Ch], 0
		jge	short loc_1E642

loc_1E629:				; CODE XREF: sub_1E5F4+1Dj
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21AAh], 2
		mov	byte ptr [si+21B1h], 4Fh ; 'O'
		mov	byte ptr [si+21B2h], 53h ; 'S'
		jmp	short loc_1E659
; ---------------------------------------------------------------------------

loc_1E642:				; CODE XREF: sub_1E5F4+2Cj
					; sub_1E5F4+33j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21AAh], 2
		mov	byte ptr [si+21B1h], 25h ; '%'
		mov	byte ptr [si+21B2h], 2Ah ; '*'

loc_1E659:				; CODE XREF: sub_1E5F4+4Cj
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	ax, [si+218Eh]
		mov	[si+217Eh], ax
		pop	si
		pop	bp
		retf
sub_1E5F4	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1E674	proc far		; CODE XREF: sub_1E8F8+1E6p
					; sub_1EB08+11Ep ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	word ptr [si+21A6h], 0
		jnz	short loc_1E6CD
		sub	ax, ax
		push	ax
		push	[bp+arg_0]
		call	sub_15C20
		add	sp, 4
		mov	word ptr [si+218Ah], 1
		mov	word ptr [si+2184h], 18h
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ADh], 0
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 1
		mov	byte ptr [si+21B1h], 3Dh ; '='
		mov	byte ptr [si+21B2h], 41h ; 'A'
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 17h

loc_1E6CD:				; CODE XREF: sub_1E674+11j
		pop	si
		pop	bp
		retf
sub_1E674	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1E6D0	proc far		; CODE XREF: sub_1E8F8+200p
					; sub_1EB08+138p ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 1
		push	ax
		push	[bp+arg_0]
		call	sub_15C20
		add	sp, 4
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+218Ah], 1
		mov	word ptr [si+2184h], 18h
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ADh], 0
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 1
		mov	byte ptr [si+21B1h], 44h ; 'D'
		mov	byte ptr [si+21B2h], 48h ; 'H'
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 14h
		cmp	byte ptr [si+21A9h], 1
		jnz	short loc_1E730
		mov	ax, 10h
		jmp	short loc_1E733
; ---------------------------------------------------------------------------
		align 2

loc_1E730:				; CODE XREF: sub_1E6D0+58j
		mov	ax, 0FFF0h

loc_1E733:				; CODE XREF: sub_1E6D0+5Dj
		mov	[si+217Ch], ax
		pop	si
		pop	bp
		retf
sub_1E6D0	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1E73A	proc far		; CODE XREF: sub_1E8F8+199p
					; sub_1EB08+D1p ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 2
		push	ax
		call	sub_15BEE
		add	sp, 2
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+2184h], 18h
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ADh], 0
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 2
		mov	byte ptr [si+21B1h], 22h ; '"'
		mov	byte ptr [si+21B2h], 24h ; '$'
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 16h
		cmp	byte ptr [si+21A9h], 1
		jnz	short loc_1E790
		mov	ax, 10h
		jmp	short loc_1E793
; ---------------------------------------------------------------------------

loc_1E790:				; CODE XREF: sub_1E73A+4Fj
		mov	ax, 0FFF0h

loc_1E793:				; CODE XREF: sub_1E73A+54j
		mov	[si+217Ch], ax
		pop	si
		pop	bp
		retf
sub_1E73A	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1E79A	proc far		; CODE XREF: sub_1E8F8+1CDp
					; sub_1EB08+105p

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 2
		push	ax
		call	sub_15BEE
		add	sp, 2
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+2184h], 18h
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ADh], 0
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 2
		mov	byte ptr [si+21B1h], 22h ; '"'
		mov	byte ptr [si+21B2h], 24h ; '$'
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 16h
		cmp	byte ptr [si+21A9h], 1
		jnz	short loc_1E7F0
		mov	ax, 8
		jmp	short loc_1E7F3
; ---------------------------------------------------------------------------

loc_1E7F0:				; CODE XREF: sub_1E79A+4Fj
		mov	ax, 0FFF8h

loc_1E7F3:				; CODE XREF: sub_1E79A+54j
		mov	[si+217Ch], ax
		pop	si
		pop	bp
		retf
sub_1E79A	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1E7FA	proc far		; CODE XREF: sub_1E8F8+165p
					; sub_1F0A4+1BCp

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		test	byte ptr [bx+21ABh], 4
		jnz	short loc_1E888
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	ax, cx
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21B0h], 6
		mov	byte ptr [si+21AFh], 0
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 4
		cmp	al, 4
		jnz	short loc_1E83F
		mov	byte ptr [si+21A9h], 1

loc_1E83F:				; CODE XREF: sub_1E7FA+3Ej
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 8
		cmp	al, 8
		jnz	short loc_1E85B
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		mov	byte ptr [bx+21A9h], 0

loc_1E85B:				; CODE XREF: sub_1E7FA+52j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+217Ch], 0
		mov	byte ptr [si+21ADh], 0
		mov	byte ptr [si+21B1h], 38h ; '8'
		mov	byte ptr [si+21B2h], 3Ch ; '<'
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 15h
		pop	si
		pop	bp
		retf
; ---------------------------------------------------------------------------

loc_1E888:				; CODE XREF: sub_1E7FA+18j
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1E316
		add	sp, 2
		pop	si
		pop	bp
		retf
sub_1E7FA	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1E896	proc far		; CODE XREF: sub_1EC50+C3p
					; sub_1EC50+18Ep ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		test	byte ptr [bx+21ABh], 4
		jnz	short loc_1E8F4
		mov	ax, cx
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+2184h], 30h ; '0'
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ACh], 3
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 5
		mov	byte ptr [si+21B1h], 35h ; '5'
		mov	byte ptr [si+21B2h], 37h ; '7'
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21ADh], 0
		mov	byte ptr [si+21AAh], 18h
		mov	word_2D014, 4

loc_1E8F4:				; CODE XREF: sub_1E896+18j
		pop	si
		pop	bp
		retf
sub_1E896	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1E8F8	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_6		= byte ptr -6
var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 6
		push	di
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+218Ah], 0
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+2178h]
		cmp	[bx+2178h], ax
		jle	short loc_1E93A
		mov	ax, cx
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		jmp	short loc_1E94E
; ---------------------------------------------------------------------------

loc_1E93A:				; CODE XREF: sub_1E8F8+2Dj
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, cx
		imul	[bp+arg_0]

loc_1E94E:				; CODE XREF: sub_1E8F8+40j
		mov	di, ax
		mov	ax, [di+2178h]
		sub	ax, [bx+2178h]
		mov	[bp+var_2], ax
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		mov	[bp+var_6], al
		and	al, 1
		cmp	al, 1
		jnz	short loc_1E9B8
		mov	al, [bp+var_6]
		and	al, 4
		cmp	al, 4
		jnz	short loc_1E97C
		mov	ax, 1
		jmp	short loc_1E97E
; ---------------------------------------------------------------------------
		align 2

loc_1E97C:				; CODE XREF: sub_1E8F8+7Cj
		sub	ax, ax

loc_1E97E:				; CODE XREF: sub_1E8F8+81j
		imul	word ptr [si+2194h]
		mov	cl, [bp+var_6]
		and	cl, 8
		mov	di, ax
		cmp	cl, 8
		jnz	short loc_1E994
		mov	ax, 1
		jmp	short loc_1E996
; ---------------------------------------------------------------------------

loc_1E994:				; CODE XREF: sub_1E8F8+95j
		sub	ax, ax

loc_1E996:				; CODE XREF: sub_1E8F8+9Aj
		imul	word ptr [si+2194h]
		sub	ax, di
		mov	[si+217Ch], ax
		or	ax, ax
		jnz	short loc_1E9AE
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1E5BA
		jmp	short loc_1E9B5
; ---------------------------------------------------------------------------
		align 2

loc_1E9AE:				; CODE XREF: sub_1E8F8+AAj
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1E5F4

loc_1E9B5:				; CODE XREF: sub_1E8F8+B3j
		add	sp, 2

loc_1E9B8:				; CODE XREF: sub_1E8F8+73j
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 2
		cmp	al, 2
		jnz	short loc_1E9D2
		push	[bp+arg_0]
		call	sub_21F72
		add	sp, 2

loc_1E9D2:				; CODE XREF: sub_1E8F8+CDj
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 10h
		cmp	al, 10h
		jnz	short loc_1E9FA
		cmp	[bp+var_2], 30h	; '0'
		jge	short loc_1E9F0
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1E316
		jmp	short loc_1E9F7
; ---------------------------------------------------------------------------

loc_1E9F0:				; CODE XREF: sub_1E8F8+EDj
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1E358

loc_1E9F7:				; CODE XREF: sub_1E8F8+F6j
		add	sp, 2

loc_1E9FA:				; CODE XREF: sub_1E8F8+E7j
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 20h
		cmp	al, 20h	; ' '
		jnz	short loc_1EA22
		cmp	[bp+var_2], 30h	; '0'
		jge	short loc_1EA18
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1E468
		jmp	short loc_1EA1F
; ---------------------------------------------------------------------------

loc_1EA18:				; CODE XREF: sub_1E8F8+115j
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1E4AA

loc_1EA1F:				; CODE XREF: sub_1E8F8+11Ej
		add	sp, 2

loc_1EA22:				; CODE XREF: sub_1E8F8+10Fj
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		mov	[bp+var_6], al
		test	[bp+var_6], 0Ch
		jz	short loc_1EA63
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		test	byte ptr [bx+21ABh], 2
		jnz	short loc_1EA63
		mov	al, [bp+var_6]
		and	al, 10h
		cmp	al, 10h
		jnz	short loc_1EA63
		cmp	[bp+var_2], 20h	; ' '
		jge	short loc_1EA63
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1E7FA
		add	sp, 2

loc_1EA63:				; CODE XREF: sub_1E8F8+13Aj
					; sub_1E8F8+150j ...
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	byte ptr [bx+21A9h], 0
		jnz	short loc_1EA78
		mov	ax, 26h	; '&'
		jmp	short loc_1EA7B
; ---------------------------------------------------------------------------
		align 2

loc_1EA78:				; CODE XREF: sub_1E8F8+178j
		mov	ax, 2Ah	; '*'

loc_1EA7B:				; CODE XREF: sub_1E8F8+17Dj
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	cl, [bx+2514h]
		sub	ch, ch
		and	cx, 2Eh
		cmp	ax, cx
		jnz	short loc_1EA97
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1E73A
		add	sp, 2

loc_1EA97:				; CODE XREF: sub_1E8F8+193j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	byte ptr [bx+21A9h], 0
		jnz	short loc_1EAAC
		mov	ax, 16h
		jmp	short loc_1EAAF
; ---------------------------------------------------------------------------
		align 2

loc_1EAAC:				; CODE XREF: sub_1E8F8+1ACj
		mov	ax, 1Ah

loc_1EAAF:				; CODE XREF: sub_1E8F8+1B1j
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	cl, [bx+2514h]
		sub	ch, ch
		and	cx, 1Eh
		cmp	ax, cx
		jnz	short loc_1EACB
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1E79A
		add	sp, 2

loc_1EACB:				; CODE XREF: sub_1E8F8+1C7j
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1FAD6
		add	sp, 2
		cmp	ax, 1
		jnz	short loc_1EAE4
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1E674
		add	sp, 2

loc_1EAE4:				; CODE XREF: sub_1E8F8+1E0j
		push	[bp+arg_0]
		call	sub_1C26E
		add	sp, 2
		cmp	ax, 1
		jnz	short loc_1EAFE
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1E6D0
		add	sp, 2

loc_1EAFE:				; CODE XREF: sub_1E8F8+1FAj
		mov	ax, [bp+var_4]
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_1E8F8	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1EB08	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_4		= byte ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 4
		push	di
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+218Ah], 0
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		mov	[bp+var_4], al
		and	al, 1
		cmp	al, 1
		jnz	short loc_1EB7A
		mov	al, [bp+var_4]
		and	al, 4
		cmp	al, 4
		jnz	short loc_1EB3E
		mov	ax, 1
		jmp	short loc_1EB40
; ---------------------------------------------------------------------------

loc_1EB3E:				; CODE XREF: sub_1EB08+2Fj
		sub	ax, ax

loc_1EB40:				; CODE XREF: sub_1EB08+34j
		imul	word ptr [si+2194h]
		mov	cl, [bp+var_4]
		and	cl, 8
		mov	di, ax
		cmp	cl, 8
		jnz	short loc_1EB56
		mov	ax, 1
		jmp	short loc_1EB58
; ---------------------------------------------------------------------------

loc_1EB56:				; CODE XREF: sub_1EB08+47j
		sub	ax, ax

loc_1EB58:				; CODE XREF: sub_1EB08+4Cj
		imul	word ptr [si+2194h]
		sub	ax, di
		mov	[si+217Ch], ax
		or	ax, ax
		jnz	short loc_1EB70
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1E5BA
		jmp	short loc_1EB77
; ---------------------------------------------------------------------------
		align 2

loc_1EB70:				; CODE XREF: sub_1EB08+5Cj
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1E5F4

loc_1EB77:				; CODE XREF: sub_1EB08+65j
		add	sp, 2

loc_1EB7A:				; CODE XREF: sub_1EB08+26j
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 10h
		cmp	al, 10h
		jnz	short loc_1EB93
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1E39A
		add	sp, 2

loc_1EB93:				; CODE XREF: sub_1EB08+7Fj
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 20h
		cmp	al, 20h	; ' '
		jnz	short loc_1EBAC
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1E4EC
		add	sp, 2

loc_1EBAC:				; CODE XREF: sub_1EB08+98j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	byte ptr [bx+21A9h], 0
		jnz	short loc_1EBC0
		mov	ax, 26h	; '&'
		jmp	short loc_1EBC3
; ---------------------------------------------------------------------------

loc_1EBC0:				; CODE XREF: sub_1EB08+B1j
		mov	ax, 2Ah	; '*'

loc_1EBC3:				; CODE XREF: sub_1EB08+B6j
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	cl, [bx+2514h]
		sub	ch, ch
		and	cx, 2Eh
		cmp	ax, cx
		jnz	short loc_1EBDF
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1E73A
		add	sp, 2

loc_1EBDF:				; CODE XREF: sub_1EB08+CBj
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	byte ptr [bx+21A9h], 0
		jnz	short loc_1EBF4
		mov	ax, 16h
		jmp	short loc_1EBF7
; ---------------------------------------------------------------------------
		align 2

loc_1EBF4:				; CODE XREF: sub_1EB08+E4j
		mov	ax, 1Ah

loc_1EBF7:				; CODE XREF: sub_1EB08+E9j
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	cl, [bx+2514h]
		sub	ch, ch
		and	cx, 1Eh
		cmp	ax, cx
		jnz	short loc_1EC13
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1E79A
		add	sp, 2

loc_1EC13:				; CODE XREF: sub_1EB08+FFj
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1FAD6
		add	sp, 2
		cmp	ax, 1
		jnz	short loc_1EC2C
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1E674
		add	sp, 2

loc_1EC2C:				; CODE XREF: sub_1EB08+118j
		push	[bp+arg_0]
		call	sub_1C26E
		add	sp, 2
		cmp	ax, 1
		jnz	short loc_1EC46
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1E6D0
		add	sp, 2

loc_1EC46:				; CODE XREF: sub_1EB08+132j
		mov	ax, [bp+var_2]
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_1EB08	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1EC50	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	si
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 10h
		cmp	al, 10h
		jz	short loc_1EC69
		jmp	loc_1ED22
; ---------------------------------------------------------------------------

loc_1EC69:				; CODE XREF: sub_1EC50+14j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	si, ax
		mov	ax, [si+2178h]
		add	ax, 30h	; '0'
		cmp	ax, [bx+2178h]
		jg	short loc_1EC90
		jmp	loc_1ED18
; ---------------------------------------------------------------------------

loc_1EC90:				; CODE XREF: sub_1EC50+3Bj
		mov	ax, cx
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	si, ax
		mov	ax, [si+2178h]
		sub	ax, 30h	; '0'
		cmp	ax, [bx+2178h]
		jge	short loc_1ED18
		mov	ax, cx
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	si, ax
		mov	ax, [si+217Ah]
		add	ax, 40h	; '@'
		cmp	ax, [bx+217Ah]
		jle	short loc_1ED18
		mov	ax, cx
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	si, ax
		mov	ax, [si+217Ah]
		sub	ax, 40h	; '@'
		cmp	ax, [bx+217Ah]
		jge	short loc_1ED18
		mov	bx, [bp+arg_0]
		shl	bx, 1
		test	byte ptr [bx+2514h], 0Eh
		jz	short loc_1ED18
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		cmp	byte ptr [bx+21ABh], 2
		jnz	short loc_1ED18
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1E896
		jmp	short loc_1ED1F
; ---------------------------------------------------------------------------

loc_1ED18:				; CODE XREF: sub_1EC50+3Dj
					; sub_1EC50+5Ej ...
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1E3DC

loc_1ED1F:				; CODE XREF: sub_1EC50+C6j
		add	sp, 2

loc_1ED22:				; CODE XREF: sub_1EC50+16j
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 20h
		cmp	al, 20h	; ' '
		jz	short loc_1ED34
		jmp	loc_1EDEE
; ---------------------------------------------------------------------------

loc_1ED34:				; CODE XREF: sub_1EC50+DFj
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	si, ax
		mov	ax, [si+2178h]
		add	ax, 30h	; '0'
		cmp	ax, [bx+2178h]
		jg	short loc_1ED5B
		jmp	loc_1EDE4
; ---------------------------------------------------------------------------

loc_1ED5B:				; CODE XREF: sub_1EC50+106j
		mov	ax, cx
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	si, ax
		mov	ax, [si+2178h]
		sub	ax, 30h	; '0'
		cmp	ax, [bx+2178h]
		jge	short loc_1EDE4
		mov	ax, cx
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	si, ax
		mov	ax, [si+217Ah]
		add	ax, 40h	; '@'
		cmp	ax, [bx+217Ah]
		jle	short loc_1EDE4
		mov	ax, cx
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	si, ax
		mov	ax, [si+217Ah]
		sub	ax, 40h	; '@'
		cmp	ax, [bx+217Ah]
		jge	short loc_1EDE4
		mov	bx, [bp+arg_0]
		shl	bx, 1
		test	byte ptr [bx+2514h], 0Eh
		jz	short loc_1EDE4
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		cmp	byte ptr [bx+21ABh], 2
		jnz	short loc_1EDE4
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1E896
		jmp	short loc_1EDEB
; ---------------------------------------------------------------------------
		align 2

loc_1EDE4:				; CODE XREF: sub_1EC50+108j
					; sub_1EC50+129j ...
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1E52E

loc_1EDEB:				; CODE XREF: sub_1EC50+191j
		add	sp, 2

loc_1EDEE:				; CODE XREF: sub_1EC50+E1j
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 9
		cmp	al, 9
		jnz	short loc_1EE27
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	ax, word_2A9DC
		mov	cl, 3
		shl	ax, cl
		add	ax, 28h	; '('
		cmp	[si+2178h], ax
		jge	short loc_1EE27
		mov	ax, [si+2194h]
		mov	[si+217Ch], ax
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1E5F4
		add	sp, 2

loc_1EE27:				; CODE XREF: sub_1EC50+1ABj
					; sub_1EC50+1C3j
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 5
		cmp	al, 5
		jnz	short loc_1EE62
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	ax, word_2A9DC
		mov	cl, 3
		shl	ax, cl
		add	ax, 118h
		cmp	[si+2178h], ax
		jle	short loc_1EE62
		mov	ax, [si+2194h]
		neg	ax
		mov	[si+217Ch], ax
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1E5F4
		add	sp, 2

loc_1EE62:				; CODE XREF: sub_1EC50+1E4j
					; sub_1EC50+1FCj
		mov	ax, [bp+var_2]
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_1EC50	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1EE6A	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	si
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 10h
		cmp	al, 10h
		jz	short loc_1EE83
		jmp	loc_1EF3C
; ---------------------------------------------------------------------------

loc_1EE83:				; CODE XREF: sub_1EE6A+14j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	si, ax
		mov	ax, [si+2178h]
		add	ax, 30h	; '0'
		cmp	ax, [bx+2178h]
		jg	short loc_1EEAA
		jmp	loc_1EF32
; ---------------------------------------------------------------------------

loc_1EEAA:				; CODE XREF: sub_1EE6A+3Bj
		mov	ax, cx
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	si, ax
		mov	ax, [si+2178h]
		sub	ax, 30h	; '0'
		cmp	ax, [bx+2178h]
		jge	short loc_1EF32
		mov	ax, cx
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	si, ax
		mov	ax, [si+217Ah]
		add	ax, 40h	; '@'
		cmp	ax, [bx+217Ah]
		jle	short loc_1EF32
		mov	ax, cx
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	si, ax
		mov	ax, [si+217Ah]
		sub	ax, 40h	; '@'
		cmp	ax, [bx+217Ah]
		jge	short loc_1EF32
		mov	bx, [bp+arg_0]
		shl	bx, 1
		test	byte ptr [bx+2514h], 0Eh
		jz	short loc_1EF32
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		cmp	byte ptr [bx+21ABh], 2
		jnz	short loc_1EF32
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1E896
		jmp	short loc_1EF39
; ---------------------------------------------------------------------------

loc_1EF32:				; CODE XREF: sub_1EE6A+3Dj
					; sub_1EE6A+5Ej ...
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1E422

loc_1EF39:				; CODE XREF: sub_1EE6A+C6j
		add	sp, 2

loc_1EF3C:				; CODE XREF: sub_1EE6A+16j
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 20h
		cmp	al, 20h	; ' '
		jz	short loc_1EF4E
		jmp	loc_1F008
; ---------------------------------------------------------------------------

loc_1EF4E:				; CODE XREF: sub_1EE6A+DFj
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	si, ax
		mov	ax, [si+2178h]
		add	ax, 30h	; '0'
		cmp	ax, [bx+2178h]
		jg	short loc_1EF75
		jmp	loc_1EFFE
; ---------------------------------------------------------------------------

loc_1EF75:				; CODE XREF: sub_1EE6A+106j
		mov	ax, cx
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	si, ax
		mov	ax, [si+2178h]
		sub	ax, 30h	; '0'
		cmp	ax, [bx+2178h]
		jge	short loc_1EFFE
		mov	ax, cx
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	si, ax
		mov	ax, [si+217Ah]
		add	ax, 40h	; '@'
		cmp	ax, [bx+217Ah]
		jle	short loc_1EFFE
		mov	ax, cx
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	si, ax
		mov	ax, [si+217Ah]
		sub	ax, 40h	; '@'
		cmp	ax, [bx+217Ah]
		jge	short loc_1EFFE
		mov	bx, [bp+arg_0]
		shl	bx, 1
		test	byte ptr [bx+2514h], 0Eh
		jz	short loc_1EFFE
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		cmp	byte ptr [bx+21ABh], 2
		jnz	short loc_1EFFE
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1E896
		jmp	short loc_1F005
; ---------------------------------------------------------------------------
		align 2

loc_1EFFE:				; CODE XREF: sub_1EE6A+108j
					; sub_1EE6A+129j ...
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1E574

loc_1F005:				; CODE XREF: sub_1EE6A+191j
		add	sp, 2

loc_1F008:				; CODE XREF: sub_1EE6A+E1j
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 9
		cmp	al, 9
		jnz	short loc_1F041
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	ax, word_2A9DC
		mov	cl, 3
		shl	ax, cl
		add	ax, 28h	; '('
		cmp	[si+2178h], ax
		jge	short loc_1F041
		mov	ax, [si+2194h]
		mov	[si+217Ch], ax
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1E5F4
		add	sp, 2

loc_1F041:				; CODE XREF: sub_1EE6A+1ABj
					; sub_1EE6A+1C3j
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 5
		cmp	al, 5
		jnz	short loc_1F07C
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	ax, word_2A9DC
		mov	cl, 3
		shl	ax, cl
		add	ax, 118h
		cmp	[si+2178h], ax
		jle	short loc_1F07C
		mov	ax, [si+2194h]
		neg	ax
		mov	[si+217Ch], ax
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1E5F4
		add	sp, 2

loc_1F07C:				; CODE XREF: sub_1EE6A+1E4j
					; sub_1EE6A+1FCj
		mov	ax, [bp+var_2]
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_1EE6A	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1F084	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1E8F8
		add	sp, 2
		pop	bp
		retf
sub_1F084	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1F094	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1EB08
		add	sp, 2
		pop	bp
		retf
sub_1F094	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1F0A4	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_8		= word ptr -8
var_6		= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 8
		push	di
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+218Ah], 0
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+2178h]
		cmp	[bx+2178h], ax
		jle	short loc_1F0E6
		mov	ax, cx
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		jmp	short loc_1F0FA
; ---------------------------------------------------------------------------

loc_1F0E6:				; CODE XREF: sub_1F0A4+2Dj
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, cx
		imul	[bp+arg_0]

loc_1F0FA:				; CODE XREF: sub_1F0A4+40j
		mov	di, ax
		mov	ax, [di+2178h]
		sub	ax, [bx+2178h]
		mov	[bp+var_6], ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+2178h]
		cmp	[bx+2178h], ax
		jle	short loc_1F126
		mov	ax, 1
		jmp	short loc_1F129
; ---------------------------------------------------------------------------
		align 2

loc_1F126:				; CODE XREF: sub_1F0A4+7Aj
		mov	ax, 0FFFFh

loc_1F129:				; CODE XREF: sub_1F0A4+7Fj
		mov	[bp+var_4], ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+2178h]
		cmp	[bx+2178h], ax
		jle	short loc_1F14A
		mov	ax, 0FFFFh
		jmp	short loc_1F14D
; ---------------------------------------------------------------------------

loc_1F14A:				; CODE XREF: sub_1F0A4+9Fj
		mov	ax, 1

loc_1F14D:				; CODE XREF: sub_1F0A4+A4j
		mov	[bp+var_2], ax
		mov	byte ptr [si+21ADh], 0
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	byte ptr [bx+21ACh], 0
		jnz	short loc_1F16E
		jmp	loc_1F1F2
; ---------------------------------------------------------------------------

loc_1F16E:				; CODE XREF: sub_1F0A4+C5j
		call	sub_1525A
		sub	ah, ah
		and	ax, 7
		cmp	ax, word_2A9F4
		jnb	short loc_1F1F2
		push	[bp+arg_0]
		call	sub_22252
		add	sp, 2
		cmp	ax, 1
		jz	short loc_1F191
		jmp	loc_1F43E
; ---------------------------------------------------------------------------

loc_1F191:				; CODE XREF: sub_1F0A4+E8j
		cmp	word_2A9F4, 1
		jnz	short loc_1F19B
		jmp	loc_1F43E
; ---------------------------------------------------------------------------

loc_1F19B:				; CODE XREF: sub_1F0A4+F2j
		call	sub_1525A
		sub	ah, ah
		and	ax, 7
		cmp	ax, word_2A9F4
		jnb	short loc_1F1D2
		call	sub_1525A
		sub	ah, ah
		and	ax, 7
		cmp	ax, word_2A9F4
		jb	short loc_1F1BE
		jmp	loc_1F43E
; ---------------------------------------------------------------------------

loc_1F1BE:				; CODE XREF: sub_1F0A4+115j
					; sub_1F0A4+35Ej
		mov	ax, [si+2194h]
		imul	[bp+var_4]

loc_1F1C5:				; CODE XREF: sub_1F0A4+1FDj
		mov	[si+217Ch], ax
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1E5F4
		jmp	short loc_1F1EC
; ---------------------------------------------------------------------------

loc_1F1D2:				; CODE XREF: sub_1F0A4+105j
		call	sub_1525A
		sub	ah, ah
		and	ax, 7
		cmp	ax, word_2A9F4
		jb	short loc_1F1E5
		jmp	loc_1F43E
; ---------------------------------------------------------------------------

loc_1F1E5:				; CODE XREF: sub_1F0A4+13Cj
					; sub_1F0A4+350j
					; DATA XREF: ...
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1E674

loc_1F1EC:				; CODE XREF: sub_1F0A4+12Cj
					; sub_1F0A4+1B5j ...
		add	sp, 2
		jmp	loc_1F43E
; ---------------------------------------------------------------------------

loc_1F1F2:				; CODE XREF: sub_1F0A4+C7j
					; sub_1F0A4+D8j
		call	sub_1525A
		sub	ah, ah
		and	ax, 7
		cmp	ax, word_2A9F4
		jb	short loc_1F205
		jmp	loc_1F422
; ---------------------------------------------------------------------------

loc_1F205:				; CODE XREF: sub_1F0A4+15Cj
		cmp	[bp+var_6], 30h	; '0'
		jl	short loc_1F20E
		jmp	loc_1F2E4
; ---------------------------------------------------------------------------

loc_1F20E:				; CODE XREF: sub_1F0A4+165j
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	al, [bx+21ABh]
		sub	ah, ah
		or	ax, ax
		jz	short loc_1F236
		cmp	ax, 1
		jz	short loc_1F27A
		cmp	ax, 2
		jz	short loc_1F2AE
		jmp	loc_1F43E
; ---------------------------------------------------------------------------
		db 2 dup(90h)
; ---------------------------------------------------------------------------

loc_1F236:				; CODE XREF: sub_1F0A4+181j
		call	sub_1525A
		and	ax, 3
		jz	short loc_1F252
		cmp	ax, 1
		jz	short loc_1F25C
		cmp	ax, 2
		jz	short loc_1F266
		cmp	ax, 3
		jz	short loc_1F270
		jmp	loc_1F43E
; ---------------------------------------------------------------------------

loc_1F252:				; CODE XREF: sub_1F0A4+19Aj
					; sub_1F0A4+28Fj
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1E4EC
		jmp	short loc_1F1EC
; ---------------------------------------------------------------------------
		align 2

loc_1F25C:				; CODE XREF: sub_1F0A4+19Fj
					; sub_1F0A4+1E3j
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1E7FA
		jmp	short loc_1F1EC
; ---------------------------------------------------------------------------
		align 2

loc_1F266:				; CODE XREF: sub_1F0A4+1A4j
					; sub_1F0A4+212j ...
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1E316
		jmp	loc_1F1EC
; ---------------------------------------------------------------------------

loc_1F270:				; CODE XREF: sub_1F0A4+1A9j
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1E468
		jmp	loc_1F1EC
; ---------------------------------------------------------------------------

loc_1F27A:				; CODE XREF: sub_1F0A4+186j
		call	sub_1525A
		and	ax, 3
		jz	short loc_1F292
		cmp	ax, 1
		jz	short loc_1F25C
		cmp	ax, 2
		jz	short loc_1F2A4
		jmp	loc_1F32E
; ---------------------------------------------------------------------------
		align 2

loc_1F292:				; CODE XREF: sub_1F0A4+1DEj
					; sub_1F0A4+282j ...
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	ax, [si+2194h]
		imul	[bp+var_2]
		jmp	loc_1F1C5
; ---------------------------------------------------------------------------

loc_1F2A4:				; CODE XREF: sub_1F0A4+1E8j
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1E39A
		jmp	loc_1F1EC
; ---------------------------------------------------------------------------

loc_1F2AE:				; CODE XREF: sub_1F0A4+18Bj
		call	sub_1525A
		and	ax, 3
		jz	short loc_1F266
		cmp	ax, 1
		jz	short loc_1F266
		cmp	ax, 2
		jz	short loc_1F2CA
		cmp	ax, 3
		jz	short loc_1F2D4
		jmp	loc_1F43E
; ---------------------------------------------------------------------------

loc_1F2CA:				; CODE XREF: sub_1F0A4+21Cj
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1E5BA
		jmp	loc_1F1EC
; ---------------------------------------------------------------------------

loc_1F2D4:				; CODE XREF: sub_1F0A4+221j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		mov	byte ptr [bx+21ADh], 2
		jmp	loc_1F43E
; ---------------------------------------------------------------------------

loc_1F2E4:				; CODE XREF: sub_1F0A4+167j
		cmp	[bp+var_6], 40h	; '@'
		jl	short loc_1F2ED
		jmp	loc_1F390
; ---------------------------------------------------------------------------

loc_1F2ED:				; CODE XREF: sub_1F0A4+244j
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	al, [bx+21ABh]
		sub	ah, ah
		or	ax, ax
		jz	short loc_1F314
		cmp	ax, 1
		jz	short loc_1F33A
		cmp	ax, 2
		jz	short loc_1F366
		jmp	loc_1F43E
; ---------------------------------------------------------------------------
		align 2

loc_1F314:				; CODE XREF: sub_1F0A4+260j
		call	sub_1525A
		and	ax, 3
		jnz	short loc_1F321
		jmp	loc_1F3B8
; ---------------------------------------------------------------------------

loc_1F321:				; CODE XREF: sub_1F0A4+278j
		cmp	ax, 1
		jnz	short loc_1F329
		jmp	loc_1F292
; ---------------------------------------------------------------------------

loc_1F329:				; CODE XREF: sub_1F0A4+280j
		cmp	ax, 2
		jz	short loc_1F386

loc_1F32E:				; CODE XREF: sub_1F0A4+1EAj
		cmp	ax, 3
		jnz	short loc_1F336
		jmp	loc_1F252
; ---------------------------------------------------------------------------

loc_1F336:				; CODE XREF: sub_1F0A4+28Dj
		jmp	loc_1F43E
; ---------------------------------------------------------------------------
		align 2

loc_1F33A:				; CODE XREF: sub_1F0A4+265j
		call	sub_1525A
		and	ax, 3
		jnz	short loc_1F347
		jmp	loc_1F3FA
; ---------------------------------------------------------------------------

loc_1F347:				; CODE XREF: sub_1F0A4+29Ej
		cmp	ax, 1
		jz	short loc_1F35C
		cmp	ax, 2
		jnz	short loc_1F354
		jmp	loc_1F292
; ---------------------------------------------------------------------------

loc_1F354:				; CODE XREF: sub_1F0A4+2ABj
		cmp	ax, 3
		jz	short loc_1F386
		jmp	loc_1F43E
; ---------------------------------------------------------------------------

loc_1F35C:				; CODE XREF: sub_1F0A4+2A6j
					; sub_1F0A4+2DCj
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1E4AA
		jmp	loc_1F1EC
; ---------------------------------------------------------------------------

loc_1F366:				; CODE XREF: sub_1F0A4+26Aj
		call	sub_1525A
		and	ax, 3
		jz	short loc_1F3B8
		cmp	ax, 1
		jnz	short loc_1F378
		jmp	loc_1F3FA
; ---------------------------------------------------------------------------

loc_1F378:				; CODE XREF: sub_1F0A4+2CFj
		cmp	ax, 2
		jz	short loc_1F386
		cmp	ax, 3
		jz	short loc_1F35C
		jmp	loc_1F43E
; ---------------------------------------------------------------------------
		align 2

loc_1F386:				; CODE XREF: sub_1F0A4+288j
					; sub_1F0A4+2B3j ...
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1E358
		jmp	loc_1F1EC
; ---------------------------------------------------------------------------

loc_1F390:				; CODE XREF: sub_1F0A4+246j
		cmp	[bp+var_6], 60h	; '`'
		jge	short loc_1F3E4
		call	sub_1525A
		and	ax, 7
		cmp	ax, 7
		jbe	short loc_1F3A6
		jmp	loc_1F43E
; ---------------------------------------------------------------------------

loc_1F3A6:				; CODE XREF: sub_1F0A4+2FDj
		add	ax, ax
		xchg	ax, bx
		jmp	cs:off_1F3D2[bx]

loc_1F3AE:				; CODE XREF: sub_1F0A4+350j
					; DATA XREF: sub_1F0A4+330o ...
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1E73A
		jmp	loc_1F1EC
; ---------------------------------------------------------------------------

loc_1F3B8:				; CODE XREF: sub_1F0A4+27Aj
					; sub_1F0A4+2CAj ...
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1E6D0
		jmp	loc_1F1EC
; ---------------------------------------------------------------------------

loc_1F3C2:				; CODE XREF: sub_1F0A4+305j
					; sub_1F0A4+350j
					; DATA XREF: ...
		cmp	[bp+var_6], 60h	; '`'
		jg	short loc_1F40C

loc_1F3C8:				; CODE XREF: sub_1F0A4+366j
		cmp	[bp+var_6], 50h	; 'P'
		jge	short loc_1F42E

loc_1F3CE:				; CODE XREF: sub_1F0A4+388j
		mov	al, 2
		jmp	short loc_1F430
; ---------------------------------------------------------------------------
off_1F3D2	dw offset loc_1F3FA	; DATA XREF: sub_1F0A4+305r
		dw offset loc_1F3AE
		dw offset loc_1F3B8
		dw offset loc_1F3C2
		dw offset loc_1F3C2
		dw offset loc_1F3C2
		dw offset loc_1F3C2
		dw offset loc_1F422
; ---------------------------------------------------------------------------
		jmp	short loc_1F43E
; ---------------------------------------------------------------------------

loc_1F3E4:				; CODE XREF: sub_1F0A4+2F0j
		call	sub_1525A
		and	ax, 7
		cmp	ax, 7
		ja	short loc_1F43E
		add	ax, ax
		xchg	ax, bx
		jmp	cs:off_1F410[bx]
; ---------------------------------------------------------------------------
		align 2

loc_1F3FA:				; CODE XREF: sub_1F0A4+2A0j
					; sub_1F0A4+2D1j ...
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		jmp	loc_1F1BE
; ---------------------------------------------------------------------------
		align 2

loc_1F406:				; CODE XREF: sub_1F0A4+350j
					; DATA XREF: sub_1F0A4+374o
		cmp	[bp+var_6], 60h	; '`'
		jle	short loc_1F3C8

loc_1F40C:				; CODE XREF: sub_1F0A4+322j
					; sub_1F0A4+382j
		mov	al, 1
		jmp	short loc_1F430
; ---------------------------------------------------------------------------
off_1F410	dw offset loc_1F3FA	; DATA XREF: sub_1F0A4+350r
		dw offset loc_1F1E5
		dw offset loc_1F3AE
		dw offset loc_1F3B8
		dw offset loc_1F406
		dw offset loc_1F422
		dw offset loc_1F3C2
		dw offset loc_1F3C2
		dw offset loc_1FFFA+1
; ---------------------------------------------------------------------------

loc_1F422:				; CODE XREF: sub_1F0A4+15Ej
					; sub_1F0A4+305j ...
		cmp	[bp+var_6], 60h	; '`'
		jg	short loc_1F40C
		cmp	[bp+var_6], 50h	; 'P'
		jl	short loc_1F3CE

loc_1F42E:				; CODE XREF: sub_1F0A4+328j
		sub	al, al

loc_1F430:				; CODE XREF: sub_1F0A4+32Cj
					; sub_1F0A4+36Aj
		mov	cx, ax
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		mov	[bx+21ADh], cl

loc_1F43E:				; CODE XREF: sub_1F0A4+EAj
					; sub_1F0A4+F4j ...
		mov	ax, [bp+var_8]
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_1F0A4	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1F448	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 4
		push	di
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+2178h]
		cmp	[bx+2178h], ax
		jle	short loc_1F484
		mov	ax, cx
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		jmp	short loc_1F498
; ---------------------------------------------------------------------------

loc_1F484:				; CODE XREF: sub_1F448+27j
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, cx
		imul	[bp+arg_0]

loc_1F498:				; CODE XREF: sub_1F448+3Aj
		mov	di, ax
		mov	ax, [di+2178h]
		sub	ax, [bx+2178h]
		mov	[bp+var_2], ax
		call	sub_1525A
		sub	ah, ah
		and	ax, 3
		cmp	ax, word_2A9F4
		jb	short loc_1F4B8
		jmp	loc_1F586
; ---------------------------------------------------------------------------

loc_1F4B8:				; CODE XREF: sub_1F448+6Bj
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+217Ah]
		cmp	[bx+217Ah], ax
		jg	short loc_1F4D4
		jmp	loc_1F57C
; ---------------------------------------------------------------------------

loc_1F4D4:				; CODE XREF: sub_1F448+87j
		mov	ax, cx
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	di, ax
		mov	ax, [di+2178h]
		add	ax, 30h	; '0'
		cmp	ax, [bx+2178h]
		jle	short loc_1F572
		mov	ax, cx
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	di, ax
		mov	ax, [di+2178h]
		sub	ax, 30h	; '0'
		cmp	ax, [bx+2178h]
		jge	short loc_1F572
		mov	ax, cx
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	di, ax
		mov	ax, [di+217Ah]
		add	ax, 40h	; '@'
		cmp	ax, [bx+217Ah]
		jle	short loc_1F572
		mov	ax, cx
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	di, ax
		mov	ax, [di+217Ah]
		sub	ax, 40h	; '@'
		cmp	ax, [bx+217Ah]
		jge	short loc_1F572
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		cmp	byte ptr [bx+21ABh], 2
		jnz	short loc_1F572
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1E896
		jmp	short loc_1F583
; ---------------------------------------------------------------------------
		db 2 dup(90h)
; ---------------------------------------------------------------------------

loc_1F572:				; CODE XREF: sub_1F448+AAj
					; sub_1F448+CAj ...
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1E52E
		jmp	short loc_1F583
; ---------------------------------------------------------------------------
		align 2

loc_1F57C:				; CODE XREF: sub_1F448+89j
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1E3DC

loc_1F583:				; CODE XREF: sub_1F448+126j
					; sub_1F448+131j
		add	sp, 2

loc_1F586:				; CODE XREF: sub_1F448+6Dj
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	ax, word_2A9DC
		mov	cl, 3
		shl	ax, cl
		add	ax, 28h	; '('
		cmp	[si+2178h], ax
		jge	short loc_1F5B0
		mov	ax, [si+2194h]
		mov	[si+217Ch], ax
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1E5F4
		add	sp, 2

loc_1F5B0:				; CODE XREF: sub_1F448+154j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	ax, word_2A9DC
		mov	cl, 3
		shl	ax, cl
		add	ax, 118h
		cmp	[si+2178h], ax
		jle	short loc_1F5DC
		mov	ax, [si+2194h]
		neg	ax
		mov	[si+217Ch], ax
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1E5F4
		add	sp, 2

loc_1F5DC:				; CODE XREF: sub_1F448+17Ej
		mov	ax, [bp+var_4]
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_1F448	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1F5E6	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 4
		push	di
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+2178h]
		cmp	[bx+2178h], ax
		jle	short loc_1F622
		mov	ax, cx
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		jmp	short loc_1F636
; ---------------------------------------------------------------------------

loc_1F622:				; CODE XREF: sub_1F5E6+27j
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, cx
		imul	[bp+arg_0]

loc_1F636:				; CODE XREF: sub_1F5E6+3Aj
		mov	di, ax
		mov	ax, [di+2178h]
		sub	ax, [bx+2178h]
		mov	[bp+var_2], ax
		call	sub_1525A
		sub	ah, ah
		and	ax, 3
		cmp	ax, word_2A9F4
		jb	short loc_1F656
		jmp	loc_1F724
; ---------------------------------------------------------------------------

loc_1F656:				; CODE XREF: sub_1F5E6+6Bj
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+217Ah]
		cmp	[bx+217Ah], ax
		jg	short loc_1F672
		jmp	loc_1F71A
; ---------------------------------------------------------------------------

loc_1F672:				; CODE XREF: sub_1F5E6+87j
		mov	ax, cx
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	di, ax
		mov	ax, [di+2178h]
		add	ax, 30h	; '0'
		cmp	ax, [bx+2178h]
		jle	short loc_1F710
		mov	ax, cx
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	di, ax
		mov	ax, [di+2178h]
		sub	ax, 30h	; '0'
		cmp	ax, [bx+2178h]
		jge	short loc_1F710
		mov	ax, cx
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	di, ax
		mov	ax, [di+217Ah]
		add	ax, 40h	; '@'
		cmp	ax, [bx+217Ah]
		jle	short loc_1F710
		mov	ax, cx
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	di, ax
		mov	ax, [di+217Ah]
		sub	ax, 40h	; '@'
		cmp	ax, [bx+217Ah]
		jge	short loc_1F710
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		cmp	byte ptr [bx+21ABh], 2
		jnz	short loc_1F710
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1E896
		jmp	short loc_1F721
; ---------------------------------------------------------------------------
		align 4

loc_1F710:				; CODE XREF: sub_1F5E6+AAj
					; sub_1F5E6+CAj ...
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1E574
		jmp	short loc_1F721
; ---------------------------------------------------------------------------
		align 2

loc_1F71A:				; CODE XREF: sub_1F5E6+89j
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1E422

loc_1F721:				; CODE XREF: sub_1F5E6+126j
					; sub_1F5E6+131j
		add	sp, 2

loc_1F724:				; CODE XREF: sub_1F5E6+6Dj
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	ax, word_2A9DC
		mov	cl, 3
		shl	ax, cl
		add	ax, 28h	; '('
		cmp	[si+2178h], ax
		jge	short loc_1F74E
		mov	ax, [si+2194h]
		mov	[si+217Ch], ax
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1E5F4
		add	sp, 2

loc_1F74E:				; CODE XREF: sub_1F5E6+154j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	ax, word_2A9DC
		mov	cl, 3
		shl	ax, cl
		add	ax, 118h
		cmp	[si+2178h], ax
		jle	short loc_1F77A
		mov	ax, [si+2194h]
		neg	ax
		mov	[si+217Ch], ax
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1E5F4
		add	sp, 2

loc_1F77A:				; CODE XREF: sub_1F5E6+17Ej
		mov	ax, [bp+var_4]
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_1F5E6	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1F784	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 4
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	al, [si+21ADh]
		sub	ah, ah
		mov	[bp+var_4], ax
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1F0A4
		add	sp, 2
		mov	[bp+var_2], ax
		cmp	byte ptr [si+21AAh], 4
		jnz	short loc_1F7B7
		mov	al, byte ptr [bp+var_4]
		mov	[si+21ADh], al

loc_1F7B7:				; CODE XREF: sub_1F784+2Aj
		mov	ax, [bp+var_2]
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_1F784	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1F7C0	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 4
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	al, [si+21ADh]
		sub	ah, ah
		mov	[bp+var_4], ax
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1F0A4
		add	sp, 2
		mov	[bp+var_2], ax
		cmp	byte ptr [si+21AAh], 5
		jnz	short loc_1F7F3
		mov	al, byte ptr [bp+var_4]
		mov	[si+21ADh], al

loc_1F7F3:				; CODE XREF: sub_1F7C0+2Aj
		mov	ax, [bp+var_2]
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_1F7C0	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1F7FC	proc far		; CODE XREF: sub_11230+1B1P
					; sub_11230+1C4P ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	ax, 14h
		imul	[bp+arg_0]
		mov	cl, 3
		shl	ax, cl
		add	ax, 0F0h ; '�'
		mov	[si+2178h], ax
		mov	word ptr [si+217Ah], 9Eh ; '�'
		mov	word ptr [si+217Ch], 0
		mov	word ptr [si+217Ch], 0
		mov	word ptr [si+217Eh], 0
		mov	word ptr [si+2182h], 0
		mov	word ptr [si+2180h], 0C9h ; '�'
		mov	word ptr [si+2184h], 0
		mov	word ptr [si+2188h], 0
		mov	word ptr [si+218Ah], 0
		mov	word ptr [si+218Ch], 0
		mov	word ptr [si+219Ah], 0
		mov	word ptr [si+219Ch], 0
		mov	word ptr [si+219Eh], 0
		mov	word ptr [si+21A0h], 0
		mov	word ptr [si+21A2h], 0
		mov	word ptr [si+21A4h], 0
		mov	word ptr [si+21A6h], 0
		mov	word ptr [si+218Eh], 0FFB0h
		mov	word ptr [si+2190h], 0Ch
		mov	word ptr [si+2192h], 3
		mov	word ptr [si+2194h], 8
		mov	word ptr [si+2196h], 4
		mov	byte ptr [si+21A8h], 0
		mov	word ptr [si+2198h], 0
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	[si+21A9h], al
		mov	byte ptr [si+21AAh], 0
		mov	byte ptr [si+21ABh], 0
		mov	byte ptr [si+21ACh], 0
		mov	byte ptr [si+21ADh], 0
		mov	byte ptr [si+21AEh], 7
		mov	byte ptr [si+21AFh], 0
		mov	[si+21B0h], cl
		mov	byte ptr [si+21B1h], 0
		mov	byte ptr [si+21B2h], 0
		mov	byte ptr [si+21B3h], 0Bh
		mov	byte ptr [si+21B4h], 0Eh
		mov	byte ptr [si+21B5h], 7
		mov	byte ptr [si+21B6h], 0Ah
		mov	byte ptr [si+21B7h], 0Fh
		mov	byte ptr [si+21B8h], 25h ; '%'
		mov	byte ptr [si+21B9h], 2Ah ; '*'
		mov	byte ptr [si+21BAh], 2Eh ; '.'
		mov	byte ptr [si+21BBh], 2Fh ; '/'
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21BCh], 0
		mov	byte ptr [si+21BDh], 1
		mov	byte ptr [si+21BEh], 2
		mov	[si+21BFh], cl
		mov	byte ptr [si+21C0h], 4
		mov	byte ptr [si+21C1h], 6
		mov	byte ptr [si+21C2h], 54h ; 'T'
		pop	si
		pop	bp
		retf
sub_1F7FC	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1F93A	proc far		; CODE XREF: sub_12822+34P
					; sub_12822+52P ...

var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	si
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	word ptr [bx+2180h], 0
		jle	short loc_1F961
		cmp	word_2CEE8, 0
		jz	short loc_1F961
		jmp	loc_1FA0F
; ---------------------------------------------------------------------------

loc_1F961:				; CODE XREF: sub_1F93A+1Bj
					; sub_1F93A+22j
		mov	si, [bp+arg_0]
		shl	si, 1
		mov	word ptr [si+2514h], 0
		mov	word ptr [si+2448h], 0
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	byte ptr [bx+21AAh], 0
		jnz	short loc_1F997
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	byte ptr [bx+21AAh], 0Ah
		jz	short loc_1F9C6

loc_1F997:				; CODE XREF: sub_1F93A+45j
		cmp	word_2CEE8, 0
		jnz	short loc_1FA0F
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+2180h]
		cmp	[bx+2180h], ax
		jge	short loc_1FA0F
		cmp	byte ptr [si+21AAh], 0
		jnz	short loc_1FA0F

loc_1F9C6:				; CODE XREF: sub_1F93A+5Bj
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21AAh], 12h
		mov	byte ptr [si+21B0h], 2
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21ADh], 14h
		mov	byte ptr [si+21AEh], 49h ; 'I'
		mov	byte ptr [si+21B1h], 4Ch ; 'L'
		mov	byte ptr [si+21B2h], 4Eh ; 'N'
		mov	ax, 3
		push	ax
		push	[bp+arg_0]
		call	sub_15C20
		add	sp, 4
		mov	bx, [bp+arg_0]
		shl	bx, 1
		inc	word ptr [bx+2646h]
		mov	word_2A9E4, 1

loc_1FA0F:				; CODE XREF: sub_1F93A+24j
					; sub_1F93A+62j ...
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	ax, [bx+2514h]
		mov	[bp+var_2], ax
		push	[bp+arg_0]
		call	sub_107EA
		add	sp, 2
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	word ptr [si+2186h], 0
		jnz	short loc_1FA5C
		push	[bp+arg_0]
		mov	bl, [si+21AAh]
		sub	bh, bh
		shl	bx, 1
		shl	bx, 1
		call	off_2C52E[bx]
		add	sp, 2
		push	[bp+arg_0]
		mov	bl, [si+21AAh]
		sub	bh, bh
		shl	bx, 1
		shl	bx, 1
		call	off_2C5F6[bx]
		jmp	short loc_1FA9F
; ---------------------------------------------------------------------------

loc_1FA5C:				; CODE XREF: sub_1F93A+F9j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		add	si, 21AAh
		push	[bp+arg_0]
		mov	bl, [si]
		sub	bh, bh
		shl	bx, 1
		shl	bx, 1
		call	off_2C592[bx]
		add	sp, 2
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	word ptr [bx+2180h], 0
		jle	short loc_1FAA2
		push	[bp+arg_0]
		mov	bl, [si]
		sub	bh, bh
		shl	bx, 1
		shl	bx, 1
		call	off_2C65A[bx]

loc_1FA9F:				; CODE XREF: sub_1F93A+120j
		add	sp, 2

loc_1FAA2:				; CODE XREF: sub_1F93A+154j
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_1FB74
		add	sp, 2
		push	[bp+arg_0]
		call	sub_233A6
		add	sp, 2
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		mov	ax, [bp+var_2]
		mov	[bx+2198h], ax
		push	[bp+arg_0]
		call	sub_2398E
		add	sp, 2
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_1F93A	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1FAD6	proc far		; CODE XREF: sub_1E8F8+1D7p
					; sub_1EB08+10Fp

var_E		= word ptr -0Eh
var_A		= word ptr -0Ah
var_8		= word ptr -8
var_6		= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 0Eh
		push	di
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	byte ptr [bx+21A9h], 0
		jnz	short loc_1FAF2
		mov	ax, 4
		jmp	short loc_1FAF5
; ---------------------------------------------------------------------------

loc_1FAF2:				; CODE XREF: sub_1FAD6+15j
		mov	ax, 8

loc_1FAF5:				; CODE XREF: sub_1FAD6+1Aj
		mov	[bp+var_2], ax
		mov	[bp+var_6], 0
		mov	[bp+var_A], 0
		mov	ax, word_2D012
		mov	[bp+var_8], ax
		dec	[bp+var_8]
		jns	short loc_1FB12
		mov	[bp+var_8], 1Dh

loc_1FB12:				; CODE XREF: sub_1FAD6+35j
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	ax, [bp+var_2]
		add	ax, 30h	; '0'
		cmp	[bx+2448h], ax
		jnz	short loc_1FB6A
		mov	si, 1
		mov	[bp+var_4], 1Eh
		mov	ax, 3Ch	; '<'
		imul	[bp+arg_0]
		mov	di, ax
		mov	[bp+var_E], 1Eh
		mov	dx, [bp+var_E]
		mov	cx, [bp+var_8]

loc_1FB3E:				; CODE XREF: sub_1FAD6+82j
		mov	bx, cx
		shl	bx, 1
		cmp	word ptr [bx+di+254Ah],	0
		jnz	short loc_1FB51
		cmp	si, 1
		jnz	short loc_1FB51
		mov	si, 2

loc_1FB51:				; CODE XREF: sub_1FAD6+71j
					; sub_1FAD6+76j
		dec	cx
		jns	short loc_1FB57
		mov	cx, 1Dh

loc_1FB57:				; CODE XREF: sub_1FAD6+7Cj
		dec	dx
		jnz	short loc_1FB3E
		mov	[bp+var_6], si
		mov	[bp+var_8], cx
		cmp	si, 2
		jnz	short loc_1FB6A
		mov	[bp+var_A], 1

loc_1FB6A:				; CODE XREF: sub_1FAD6+4Bj
					; sub_1FAD6+8Dj
		mov	ax, [bp+var_A]
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_1FAD6	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1FB74	proc far		; CODE XREF: sub_1F93A+16Cp

var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	di
		push	si
		mov	[bp+var_2], 0
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	word ptr [si+21A6h], 1
		jnz	short loc_1FBE6
		inc	word ptr [si+219Ah]
		cmp	word ptr [si+219Ah], 43h ; 'C'
		jle	short loc_1FBA1
		mov	word ptr [si+219Ah], 42h ; 'B'

loc_1FBA1:				; CODE XREF: sub_1FB74+25j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	word ptr [si+219Ch], 0
		jnz	short loc_1FBB6
		mov	ax, 0FFF0h
		jmp	short loc_1FBB9
; ---------------------------------------------------------------------------
		align 2

loc_1FBB6:				; CODE XREF: sub_1FB74+3Aj
		mov	ax, 10h

loc_1FBB9:				; CODE XREF: sub_1FB74+3Fj
		add	[si+21A2h], ax
		mov	di, word_2A9DC
		mov	cl, 3
		shl	di, cl
		lea	ax, [di-20h]
		cmp	[si+21A2h], ax
		jl	short loc_1FBD8
		lea	ax, [di+160h]
		cmp	[si+21A2h], ax
		jle	short loc_1FBE6

loc_1FBD8:				; CODE XREF: sub_1FB74+58j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		mov	word ptr [bx+21A6h], 0

loc_1FBE6:				; CODE XREF: sub_1FB74+1Aj
					; sub_1FB74+62j
		mov	ax, [bp+var_2]
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_1FB74	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1FBF0	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21ABh], 0
		inc	byte ptr [si+21AFh]
		mov	al, [si+21AFh]
		cmp	[si+21B0h], al
		ja	short loc_1FC7F
		mov	byte ptr [si+21AFh], 0
		inc	byte ptr [si+21AEh]
		cmp	byte ptr [si+21AEh], 3Fh ; '?'
		jnz	short loc_1FC6B
		cmp	byte ptr [si+21A9h], 0
		jnz	short loc_1FC2E
		mov	ax, 0FFF8h
		jmp	short loc_1FC31
; ---------------------------------------------------------------------------

loc_1FC2E:				; CODE XREF: sub_1FBF0+37j
		mov	ax, 8

loc_1FC31:				; CODE XREF: sub_1FBF0+3Cj
		add	ax, [si+2178h]
		mov	[si+21A2h], ax
		mov	ax, [si+217Ah]
		sub	ax, 30h	; '0'
		mov	[si+21A4h], ax
		mov	al, [si+21A9h]
		sub	ah, ah
		mov	[si+219Ch], ax
		mov	word ptr [si+219Ah], 42h ; 'B'
		mov	word ptr [si+21A6h], 1
		mov	word ptr [si+219Eh], 0
		mov	word ptr [si+21A0h], 0
		mov	byte ptr [si+21B0h], 3

loc_1FC6B:				; CODE XREF: sub_1FBF0+30j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	byte ptr [si+21AEh], 40h ; '@'
		jnz	short loc_1FC7F
		mov	byte ptr [si+21B0h], 2

loc_1FC7F:				; CODE XREF: sub_1FBF0+20j
					; sub_1FBF0+88j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	byte ptr [si+21AEh], 41h ; 'A'
		jbe	short loc_1FCB8
		push	[bp+arg_0]
		call	sub_21EF8
		add	sp, 2
		mov	al, [si+21B5h]
		mov	[si+21B1h], al
		mov	[si+21B2h], al
		mov	byte ptr [si+21B0h], 1
		mov	byte ptr [si+21AFh], 0
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 0Ch

loc_1FCB8:				; CODE XREF: sub_1FBF0+9Cj
		mov	ax, [bp+var_2]
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_1FBF0	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1FCC0	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21ABh], 0
		mov	byte ptr [si+21ACh], 1
		inc	byte ptr [si+21ADh]
		mov	ax, [si+217Ch]
		add	[si+2178h], ax
		inc	byte ptr [si+21AFh]
		mov	al, [si+21AFh]
		cmp	[si+21B0h], al
		ja	short loc_1FD08
		mov	byte ptr [si+21AFh], 0
		inc	byte ptr [si+21AEh]
		cmp	byte ptr [si+21AEh], 48h ; 'H'
		jnz	short loc_1FD08
		mov	byte ptr [si+21AEh], 46h ; 'F'

loc_1FD08:				; CODE XREF: sub_1FCC0+31j
					; sub_1FCC0+41j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	byte ptr [si+21ADh], 8
		jz	short loc_1FD1E
		cmp	word ptr [si+2188h], 0
		jz	short loc_1FD50

loc_1FD1E:				; CODE XREF: sub_1FCC0+55j
		push	[bp+arg_0]
		call	sub_21EF8
		add	sp, 2
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	al, [si+21B5h]
		mov	[si+21B1h], al
		mov	[si+21B2h], al
		mov	byte ptr [si+21B0h], 2
		mov	byte ptr [si+21AFh], 0
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 0Ch

loc_1FD50:				; CODE XREF: sub_1FCC0+5Cj
		mov	ax, [bp+var_2]
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_1FCC0	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1FD58	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21ABh], 1
		mov	byte ptr [si+21ACh], 2
		inc	byte ptr [si+21ADh]
		mov	ax, [si+217Ch]
		add	[si+2178h], ax
		inc	byte ptr [si+21AFh]
		mov	al, [si+21AFh]
		cmp	[si+21B0h], al
		ja	short loc_1FDA0
		mov	byte ptr [si+21AFh], 0
		inc	byte ptr [si+21AEh]
		cmp	byte ptr [si+21AEh], 24h ; '$'
		jnz	short loc_1FDA0
		mov	byte ptr [si+21AEh], 23h ; '#'

loc_1FDA0:				; CODE XREF: sub_1FD58+31j
					; sub_1FD58+41j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	byte ptr [si+21ADh], 8
		jz	short loc_1FDB6
		cmp	word ptr [si+2188h], 0
		jz	short loc_1FDE7

loc_1FDB6:				; CODE XREF: sub_1FD58+55j
		push	[bp+arg_0]
		call	sub_21EF8
		add	sp, 2
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21B1h], 24h ; '$'
		mov	byte ptr [si+21B2h], 24h ; '$'
		mov	byte ptr [si+21B0h], 2
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21AEh], 24h ; '$'
		mov	byte ptr [si+21AAh], 0Ch

loc_1FDE7:				; CODE XREF: sub_1FD58+5Cj
		mov	ax, [bp+var_2]
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_1FD58	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1FDF0	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	di
		push	si
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21A8h], 1
		inc	byte ptr [si+21ADh]
		cmp	byte ptr [si+21ADh], 1
		jz	short loc_1FE19
		jmp	loc_1FEAF
; ---------------------------------------------------------------------------

loc_1FE19:				; CODE XREF: sub_1FDF0+24j
		inc	byte ptr [si+21AEh]
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	byte ptr [bx+21AAh], 10h
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		cmp	byte ptr [si+21A9h], 1
		sbb	ax, ax
		neg	ax
		mov	[bx+21A9h], al
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	al, [bx+21BDh]
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+21AEh], cl
		cmp	byte ptr [si+21A9h], 0
		jnz	short loc_1FE7C
		mov	ax, 0FFE8h
		jmp	short loc_1FE7F
; ---------------------------------------------------------------------------
		align 2

loc_1FE7C:				; CODE XREF: sub_1FDF0+84j
		mov	ax, 18h

loc_1FE7F:				; CODE XREF: sub_1FDF0+89j
		add	ax, [si+2178h]
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+2178h], cx
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+217Ah]
		mov	[bx+217Ah], ax

loc_1FEAF:				; CODE XREF: sub_1FDF0+26j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	byte ptr [si+21ADh], 6
		jz	short loc_1FEC1
		jmp	loc_1FF58
; ---------------------------------------------------------------------------

loc_1FEC1:				; CODE XREF: sub_1FDF0+CCj
		inc	byte ptr [si+21AEh]
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	byte ptr [bx+21AAh], 10h
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	al, [si+21A9h]
		or	al, 2
		mov	[bx+21A9h], al
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	al, [bx+21BFh]
		inc	al
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+21AEh], cl
		cmp	byte ptr [si+21A9h], 0
		jnz	short loc_1FF22
		mov	ax, 0FFD8h
		jmp	short loc_1FF25
; ---------------------------------------------------------------------------

loc_1FF22:				; CODE XREF: sub_1FDF0+12Bj
		mov	ax, 28h	; '('

loc_1FF25:				; CODE XREF: sub_1FDF0+130j
		add	ax, [si+2178h]
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+2178h], cx
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+217Ah]
		add	ax, 8
		mov	[bx+217Ah], ax

loc_1FF58:				; CODE XREF: sub_1FDF0+CEj
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	byte ptr [si+21ADh], 8
		jz	short loc_1FF6A
		jmp	loc_2000E
; ---------------------------------------------------------------------------

loc_1FF6A:				; CODE XREF: sub_1FDF0+175j
		mov	ax, 2
		push	ax
		push	[bp+arg_0]
		call	sub_15C20
		add	sp, 4
		inc	byte ptr [si+21AEh]
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	byte ptr [bx+21AAh], 10h
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	al, [si+21A9h]
		or	al, 2
		mov	[bx+21A9h], al
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	al, [bx+21BDh]
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+21AEh], cl
		cmp	byte ptr [si+21A9h], 0
		jnz	short loc_1FFD8
		mov	ax, 50h	; 'P'
		jmp	short loc_1FFDB
; ---------------------------------------------------------------------------

loc_1FFD8:				; CODE XREF: sub_1FDF0+1E1j
		mov	ax, 0FFB0h

loc_1FFDB:				; CODE XREF: sub_1FDF0+1E6j
		add	ax, [si+2178h]
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+2178h], cx
		cmp	[bp+arg_0], 1
		sbb	ax, ax

loc_1FFFA:				; CODE XREF: sub_1F0A4+350j
					; DATA XREF: sub_1F0A4+37Co
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+217Ah]
		add	ax, 8
		mov	[bx+217Ah], ax

loc_2000E:				; CODE XREF: sub_1FDF0+177j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	byte ptr [si+21ADh], 0Ah
		jz	short loc_20020
		jmp	loc_2012B
; ---------------------------------------------------------------------------

loc_20020:				; CODE XREF: sub_1FDF0+22Bj
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	byte ptr [bx+21AAh], 9
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	al, [bx+21BFh]
		inc	al
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+21AEh], cl
		cmp	byte ptr [si+21A9h], 0
		jnz	short loc_20068
		mov	ax, 68h	; 'h'
		jmp	short loc_2006B
; ---------------------------------------------------------------------------
		align 2

loc_20068:				; CODE XREF: sub_1FDF0+270j
		mov	ax, 0FF98h

loc_2006B:				; CODE XREF: sub_1FDF0+275j
		add	ax, [si+2178h]
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+2178h], cx
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+217Ah]
		mov	[bx+217Ah], ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	di, ax
		mov	ax, [di+218Eh]
		cwd
		xor	ax, dx
		sub	ax, dx
		mov	cx, 2
		sar	ax, cl
		xor	ax, dx
		sub	ax, dx
		mov	[bx+217Eh], ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	byte ptr [si+21A9h], 1
		sbb	ax, ax
		neg	ax
		mov	[bx+21A9h], al
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		cmp	byte ptr [bx+21A9h], 0
		jnz	short loc_200FE
		mov	ax, 0FFE8h
		jmp	short loc_20101
; ---------------------------------------------------------------------------
		align 2

loc_200FE:				; CODE XREF: sub_1FDF0+306j
		mov	ax, 18h

loc_20101:				; CODE XREF: sub_1FDF0+30Bj
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+217Ch], cx
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	word ptr [bx+218Ch], 30h ; '0'

loc_2012B:				; CODE XREF: sub_1FDF0+22Dj
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	byte ptr [si+21ADh], 0Eh
		jnz	short loc_2013E
		inc	byte ptr [si+21AEh]

loc_2013E:				; CODE XREF: sub_1FDF0+348j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	byte ptr [si+21ADh], 12h
		jnz	short loc_2017C
		mov	byte ptr [si+21A8h], 0
		push	[bp+arg_0]
		call	sub_21EF8
		add	sp, 2
		mov	al, [si+21B5h]
		mov	[si+21B1h], al
		mov	[si+21B2h], al
		mov	byte ptr [si+21B0h], 1
		mov	byte ptr [si+21AFh], 0
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 0Ch

loc_2017C:				; CODE XREF: sub_1FDF0+35Bj
		mov	ax, [bp+var_2]
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_1FDF0	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_20186	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	di
		push	si
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21A8h], 1
		mov	word_2D014, 0
		cmp	byte ptr [si+21ADh], 0
		jz	short loc_201B1
		jmp	loc_203AA
; ---------------------------------------------------------------------------

loc_201B1:				; CODE XREF: sub_20186+26j
		push	[bp+arg_0]
		call	sub_2274C
		add	sp, 2
		or	ax, ax
		jz	short loc_201C3
		jmp	loc_20258
; ---------------------------------------------------------------------------

loc_201C3:				; CODE XREF: sub_20186+38j
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	byte ptr [bx+21AAh], 10h
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		cmp	byte ptr [si+21A9h], 1
		sbb	ax, ax
		neg	ax
		mov	[bx+21A9h], al
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	al, [bx+21BDh]
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+21AEh], cl
		cmp	byte ptr [si+21A9h], 0
		jnz	short loc_20222
		mov	ax, 10h
		jmp	short loc_20225
; ---------------------------------------------------------------------------
		align 2

loc_20222:				; CODE XREF: sub_20186+94j
		mov	ax, 0FFF0h

loc_20225:				; CODE XREF: sub_20186+99j
		add	ax, [si+2178h]
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+2178h], cx
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+217Ah]
		mov	[bx+217Ah], ax
		jmp	loc_203F1
; ---------------------------------------------------------------------------

loc_20258:				; CODE XREF: sub_20186+3Aj
		mov	ax, 2
		push	ax
		push	[bp+arg_0]
		call	sub_15C20
		add	sp, 4
		mov	word_2D014, 4
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	byte ptr [bx+21AAh], 9
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	al, [bx+21BFh]
		inc	al
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+21AEh], cl
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	byte ptr [si+21A9h], 0
		jnz	short loc_202BC
		mov	ax, 0FFF8h
		jmp	short loc_202BF
; ---------------------------------------------------------------------------

loc_202BC:				; CODE XREF: sub_20186+12Fj
		mov	ax, 8

loc_202BF:				; CODE XREF: sub_20186+134j
		add	ax, [si+2178h]
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+2178h], cx
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+217Ah]
		sub	ax, 8
		mov	[bx+217Ah], ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	di, ax
		mov	ax, [di+218Eh]
		neg	ax
		cwd
		sub	ax, dx
		sar	ax, 1
		mov	[bx+217Eh], ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		cmp	byte ptr [si+21A9h], 1
		sbb	ax, ax
		neg	ax
		mov	[bx+21A9h], al
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		cmp	byte ptr [bx+21A9h], 0
		jnz	short loc_2034A
		mov	ax, 10h
		jmp	short loc_2034D
; ---------------------------------------------------------------------------

loc_2034A:				; CODE XREF: sub_20186+1BDj
		mov	ax, 0FFF0h

loc_2034D:				; CODE XREF: sub_20186+1C2j
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+217Ch], cx
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	word ptr [bx+218Ch], 30h ; '0'
		push	[bp+arg_0]
		call	sub_21EF8
		add	sp, 2
		mov	byte ptr [si+21B0h], 2
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21ADh], 2
		mov	al, [si+21AEh]
		mov	[si+21B1h], al
		mov	byte ptr [si+21B2h], 37h ; '7'
		mov	byte ptr [si+21AAh], 0Ch
		mov	byte ptr [si+21A8h], 0
		jmp	short loc_203F1
; ---------------------------------------------------------------------------

loc_203AA:				; CODE XREF: sub_20186+28j
		push	[bp+arg_0]
		call	sub_2274C
		add	sp, 2
		cmp	ax, 1
		jnz	short loc_203F1
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21A8h], 0
		push	[bp+arg_0]
		call	sub_21EF8
		add	sp, 2
		mov	al, [si+21B5h]
		mov	[si+21B1h], al
		mov	[si+21B2h], al
		mov	byte ptr [si+21B0h], 1
		mov	byte ptr [si+21AFh], 0
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 0Ch

loc_203F1:				; CODE XREF: sub_20186+CFj
					; sub_20186+222j ...
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		inc	byte ptr [si+21AFh]
		mov	al, [si+21AFh]
		cmp	[si+21B0h], al
		jbe	short loc_2040A
		jmp	loc_20562
; ---------------------------------------------------------------------------

loc_2040A:				; CODE XREF: sub_20186+27Fj
		mov	byte ptr [si+21AFh], 0
		inc	byte ptr [si+21AEh]
		cmp	byte ptr [si+21AEh], 36h ; '6'
		jnz	short loc_2041F
		mov	byte ptr [si+21B0h], 2

loc_2041F:				; CODE XREF: sub_20186+292j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	byte ptr [si+21AEh], 36h ; '6'
		jz	short loc_20431
		jmp	loc_2054E
; ---------------------------------------------------------------------------

loc_20431:				; CODE XREF: sub_20186+2A6j
		mov	ax, 2
		push	ax
		push	[bp+arg_0]
		call	sub_15C20
		add	sp, 4
		mov	word_2D014, 4
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	byte ptr [bx+21AAh], 9
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	al, [bx+21BFh]
		inc	al
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+21AEh], cl
		cmp	byte ptr [si+21A9h], 0
		jnz	short loc_2048E
		mov	ax, 10h
		jmp	short loc_20491
; ---------------------------------------------------------------------------
		align 2

loc_2048E:				; CODE XREF: sub_20186+300j
		mov	ax, 0FFF0h

loc_20491:				; CODE XREF: sub_20186+305j
		add	ax, [si+2178h]
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+2178h], cx
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+217Ah]
		sub	ax, 8
		mov	[bx+217Ah], ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	di, ax
		mov	ax, [di+218Eh]
		neg	ax
		cwd
		sub	ax, dx
		sar	ax, 1
		mov	[bx+217Eh], ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		cmp	byte ptr [si+21A9h], 1
		sbb	ax, ax
		neg	ax
		mov	[bx+21A9h], al
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		cmp	byte ptr [bx+21A9h], 0
		jnz	short loc_2051C
		mov	ax, 10h
		jmp	short loc_2051F
; ---------------------------------------------------------------------------

loc_2051C:				; CODE XREF: sub_20186+38Fj
		mov	ax, 0FFF0h

loc_2051F:				; CODE XREF: sub_20186+394j
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+217Ch], cx
		mov	byte ptr [si+21ADh], 1
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	word ptr [bx+218Ch], 30h ; '0'

loc_2054E:				; CODE XREF: sub_20186+2A8j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		add	si, 21AEh
		cmp	byte ptr [si], 37h ; '7'
		jbe	short loc_20562
		mov	byte ptr [si], 37h ; '7'

loc_20562:				; CODE XREF: sub_20186+281j
					; sub_20186+3D7j
		mov	ax, [bp+var_2]
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_20186	endp

seg007		ends

; ===========================================================================

; Segment type:	Pure code
seg008		segment	byte public 'CODE' use16
		assume cs:seg008
		;org 0Bh
		assume es:nothing, ss:nothing, ds:seg026, fs:nothing, gs:nothing
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_2056C	proc far		; CODE XREF: sub_209C0+92p
					; sub_20A5C+F3p ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+2184h], 0Fh
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ACh], 1
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 2
		mov	byte ptr [si+21B1h], 16h
		mov	byte ptr [si+21B2h], 18h
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 0Ch
		pop	si
		pop	bp
		retf
sub_2056C	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_205AE	proc far		; CODE XREF: sub_20A5C+FCp
					; sub_20DB6+2B2p

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+2184h], 0Fh
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ACh], 1
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 2
		mov	byte ptr [si+21B1h], 13h
		mov	byte ptr [si+21B2h], 15h
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 0Ch
		pop	si
		pop	bp
		retf
sub_205AE	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_205F0	proc far		; CODE XREF: sub_20C1C+85p
					; sub_20DB6+1E8p

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+2184h], 0Fh
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ACh], 1
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 3
		mov	byte ptr [si+21B1h], 20h ; ' '
		mov	byte ptr [si+21B2h], 22h ; '"'
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 0Fh
		pop	si
		pop	bp
		retf
sub_205F0	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_20632	proc far		; CODE XREF: sub_20D16+19p
					; seg008:0C66p

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+2184h], 0Fh
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ACh], 3
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 3
		mov	byte ptr [si+21B1h], 25h ; '%'
		mov	byte ptr [si+21B2h], 25h ; '%'
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 0Dh
		mov	byte ptr [si+21ADh], 0Ah
		pop	si
		pop	bp
		retf
sub_20632	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_20678	proc far		; CODE XREF: sub_20D56+19p
					; seg008:0D10p

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+2184h], 0Fh
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ACh], 3
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 2
		mov	byte ptr [si+21B1h], 27h ; '''
		mov	byte ptr [si+21B2h], 29h ; ')'
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21ADh], 0Ah
		mov	byte ptr [si+21AAh], 0Eh
		pop	si
		pop	bp
		retf
sub_20678	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_206BE	proc far		; CODE XREF: sub_20A5C+11Bp
					; sub_20DB6+212p

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+2184h], 1Eh
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ACh], 1
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 1
		mov	byte ptr [si+21B1h], 19h
		mov	byte ptr [si+21B2h], 1Bh
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 0Ch
		pop	si
		pop	bp
		retf
sub_206BE	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_20700	proc far		; CODE XREF: sub_20A5C+124p
					; sub_20DB6+2A8p

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+2184h], 1Eh
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ACh], 1
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 2
		mov	byte ptr [si+21B1h], 1Ch
		mov	byte ptr [si+21B2h], 1Fh
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 0Ch
		pop	si
		pop	bp
		retf
sub_20700	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_20742	proc far		; CODE XREF: sub_20C1C+9Ep
					; sub_20DB6+272p

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+2184h], 1Eh
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ACh], 2
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 2
		mov	byte ptr [si+21B1h], 23h ; '#'
		mov	byte ptr [si+21B2h], 24h ; '$'
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 0Fh
		pop	si
		pop	bp
		retf
sub_20742	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_20784	proc far		; CODE XREF: sub_20D16+32p
					; seg008:0C5Cp

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+2184h], 1Eh
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ACh], 3
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 1
		mov	byte ptr [si+21B1h], 26h ; '&'
		mov	byte ptr [si+21B2h], 26h ; '&'
		mov	byte ptr [si+21ADh], 0Ah
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 0Dh
		pop	si
		pop	bp
		retf
sub_20784	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_207CA	proc far		; CODE XREF: sub_20D56+32p
					; seg008:0D06p

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+2184h], 1Eh
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ACh], 3
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 2
		mov	byte ptr [si+21B1h], 1Ch
		mov	byte ptr [si+21B2h], 1Fh
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21ADh], 0Fh
		mov	byte ptr [si+21AAh], 0Eh
		pop	si
		pop	bp
		retf
sub_207CA	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_20810	proc far		; CODE XREF: sub_20A5C+B0p
					; sub_20C1C+62p ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+217Ch], 0
		mov	byte ptr [si+21AAh], 3
		mov	al, [si+21B8h]
		mov	[si+21B1h], al
		mov	al, [si+21B9h]
		mov	[si+21B2h], al
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	ax, [si+218Eh]
		mov	[si+217Eh], ax
		mov	byte ptr [si+21B0h], 4
		pop	si
		pop	bp
		retf
sub_20810	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_20850	proc far		; CODE XREF: sub_20A5C+BAp
					; sub_20C1C+6Cp ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21AAh], 2
		mov	al, [si+21B8h]
		mov	[si+21B1h], al
		mov	al, [si+21B9h]
		mov	[si+21B2h], al
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	ax, [si+218Eh]
		mov	[si+217Eh], ax
		mov	byte ptr [si+21B0h], 4
		pop	si
		pop	bp
		retf
sub_20850	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_2088A	proc far		; CODE XREF: sub_20A5C+17Fp
					; sub_20C1C+B8p ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	word ptr [si+21A6h], 0
		jnz	short loc_208E3
		sub	ax, ax
		push	ax
		push	[bp+arg_0]
		call	sub_15C20
		add	sp, 4
		mov	word ptr [si+218Ah], 1
		mov	word ptr [si+2184h], 20h ; ' '
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ADh], 0
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 1
		mov	byte ptr [si+21B1h], 2Ah ; '*'
		mov	byte ptr [si+21B2h], 2Eh ; '.'
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 17h

loc_208E3:				; CODE XREF: sub_2088A+11j
		pop	si
		pop	bp
		retf
sub_2088A	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_208E6	proc far		; CODE XREF: sub_20A5C+198p
					; sub_20C1C+D1p ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 1
		push	ax
		push	[bp+arg_0]
		call	sub_15C20
		add	sp, 4
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+218Ah], 1
		mov	word ptr [si+2184h], 20h ; ' '
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ADh], 0
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 1
		mov	byte ptr [si+21B1h], 31h ; '1'
		mov	byte ptr [si+21B2h], 36h ; '6'
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	word ptr [si+217Eh], 0FFE8h
		cmp	byte ptr [si+21A9h], 1
		jnz	short loc_20946
		mov	ax, 10h
		jmp	short loc_20949
; ---------------------------------------------------------------------------

loc_20946:				; CODE XREF: sub_208E6+59j
		mov	ax, 0FFF0h

loc_20949:				; CODE XREF: sub_208E6+5Ej
		mov	[si+217Ch], ax
		mov	byte ptr [si+21AAh], 14h
		pop	si
		pop	bp
		retf
sub_208E6	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_20956	proc far		; CODE XREF: sub_20A5C+1B1p
					; sub_20C1C+EAp ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 2
		push	ax
		push	[bp+arg_0]
		call	sub_15C20
		add	sp, 4
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+218Ah], 1
		mov	word ptr [si+2184h], 20h ; ' '
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	byte ptr [si+21ADh], 0
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 2
		mov	byte ptr [si+21B1h], 37h ; '7'
		mov	byte ptr [si+21B2h], 39h ; '9'
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 16h
		cmp	byte ptr [si+21A9h], 1
		jnz	short loc_209B6
		mov	ax, 10h
		jmp	short loc_209B9
; ---------------------------------------------------------------------------
		align 2

loc_209B6:				; CODE XREF: sub_20956+58j
		mov	ax, 0FFF0h

loc_209B9:				; CODE XREF: sub_20956+5Dj
		mov	[si+217Ch], ax
		pop	si
		pop	bp
		retf
sub_20956	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_209C0	proc far		; CODE XREF: sub_20A5C+165p
					; sub_20DB6+1A2p

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		test	byte ptr [bx+21ABh], 4
		jnz	short loc_20A4E
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	ax, cx
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21B0h], 3
		mov	byte ptr [si+21AFh], 0
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 4
		cmp	al, 4
		jnz	short loc_20A05
		mov	byte ptr [si+21A9h], 0

loc_20A05:				; CODE XREF: sub_209C0+3Ej
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 8
		cmp	al, 8
		jnz	short loc_20A21
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		mov	byte ptr [bx+21A9h], 1

loc_20A21:				; CODE XREF: sub_209C0+52j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+217Ch], 0
		mov	byte ptr [si+21ADh], 0
		mov	byte ptr [si+21B1h], 3Ah ; ':'
		mov	byte ptr [si+21B2h], 3Fh ; '?'
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 15h
		pop	si
		pop	bp
		retf
; ---------------------------------------------------------------------------

loc_20A4E:				; CODE XREF: sub_209C0+18j
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_2056C
		add	sp, 2
		pop	si
		pop	bp
		retf
sub_209C0	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_20A5C	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_6		= byte ptr -6
var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 6
		push	di
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+218Ah], 0
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+2178h]
		cmp	[bx+2178h], ax
		jle	short loc_20A9E
		mov	ax, cx
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		jmp	short loc_20AB2
; ---------------------------------------------------------------------------

loc_20A9E:				; CODE XREF: sub_20A5C+2Dj
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, cx
		imul	[bp+arg_0]

loc_20AB2:				; CODE XREF: sub_20A5C+40j
		mov	di, ax
		mov	ax, [di+2178h]
		sub	ax, [bx+2178h]
		mov	[bp+var_2], ax
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		mov	[bp+var_6], al
		and	al, 1
		cmp	al, 1
		jnz	short loc_20B1C
		mov	al, [bp+var_6]
		and	al, 4
		cmp	al, 4
		jnz	short loc_20AE0
		mov	ax, 1
		jmp	short loc_20AE2
; ---------------------------------------------------------------------------
		align 2

loc_20AE0:				; CODE XREF: sub_20A5C+7Cj
		sub	ax, ax

loc_20AE2:				; CODE XREF: sub_20A5C+81j
		imul	word ptr [si+2194h]
		mov	cl, [bp+var_6]
		and	cl, 8
		mov	di, ax
		cmp	cl, 8
		jnz	short loc_20AF8
		mov	ax, 1
		jmp	short loc_20AFA
; ---------------------------------------------------------------------------

loc_20AF8:				; CODE XREF: sub_20A5C+95j
		sub	ax, ax

loc_20AFA:				; CODE XREF: sub_20A5C+9Aj
		imul	word ptr [si+2194h]
		sub	ax, di
		mov	[si+217Ch], ax
		or	ax, ax
		jnz	short loc_20B12
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_20810
		jmp	short loc_20B19
; ---------------------------------------------------------------------------
		align 2

loc_20B12:				; CODE XREF: sub_20A5C+AAj
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_20850

loc_20B19:				; CODE XREF: sub_20A5C+B3j
		add	sp, 2

loc_20B1C:				; CODE XREF: sub_20A5C+73j
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 2
		cmp	al, 2
		jnz	short loc_20B36
		push	[bp+arg_0]
		call	sub_21F72
		add	sp, 2

loc_20B36:				; CODE XREF: sub_20A5C+CDj
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 10h
		cmp	al, 10h
		jnz	short loc_20B5E
		cmp	[bp+var_2], 30h	; '0'
		jge	short loc_20B54
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_2056C
		jmp	short loc_20B5B
; ---------------------------------------------------------------------------

loc_20B54:				; CODE XREF: sub_20A5C+EDj
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_205AE

loc_20B5B:				; CODE XREF: sub_20A5C+F6j
		add	sp, 2

loc_20B5E:				; CODE XREF: sub_20A5C+E7j
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 20h
		cmp	al, 20h	; ' '
		jnz	short loc_20B86
		cmp	[bp+var_2], 30h	; '0'
		jge	short loc_20B7C
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_206BE
		jmp	short loc_20B83
; ---------------------------------------------------------------------------

loc_20B7C:				; CODE XREF: sub_20A5C+115j
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_20700

loc_20B83:				; CODE XREF: sub_20A5C+11Ej
		add	sp, 2

loc_20B86:				; CODE XREF: sub_20A5C+10Fj
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		mov	[bp+var_6], al
		test	[bp+var_6], 0Ch
		jz	short loc_20BC7
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		test	byte ptr [bx+21ABh], 2
		jnz	short loc_20BC7
		mov	al, [bp+var_6]
		and	al, 10h
		cmp	al, 10h
		jnz	short loc_20BC7
		cmp	[bp+var_2], 20h	; ' '
		jge	short loc_20BC7
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_209C0
		add	sp, 2

loc_20BC7:				; CODE XREF: sub_20A5C+13Aj
					; sub_20A5C+150j ...
		push	[bp+arg_0]
		call	sub_1A9BC
		add	sp, 2
		cmp	ax, 1
		jnz	short loc_20BE1
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_2088A
		add	sp, 2

loc_20BE1:				; CODE XREF: sub_20A5C+179j
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_2164E
		add	sp, 2
		cmp	ax, 1
		jnz	short loc_20BFA
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_208E6
		add	sp, 2

loc_20BFA:				; CODE XREF: sub_20A5C+192j
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_216FA
		add	sp, 2
		cmp	ax, 1
		jnz	short loc_20C13
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_20956
		add	sp, 2

loc_20C13:				; CODE XREF: sub_20A5C+1ABj
		mov	ax, [bp+var_4]
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_20A5C	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_20C1C	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_4		= byte ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 4
		push	di
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+218Ah], 0
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		mov	[bp+var_4], al
		and	al, 1
		cmp	al, 1
		jnz	short loc_20C8E
		mov	al, [bp+var_4]
		and	al, 4
		cmp	al, 4
		jnz	short loc_20C52
		mov	ax, 1
		jmp	short loc_20C54
; ---------------------------------------------------------------------------

loc_20C52:				; CODE XREF: sub_20C1C+2Fj
		sub	ax, ax

loc_20C54:				; CODE XREF: sub_20C1C+34j
		imul	word ptr [si+2194h]
		mov	cl, [bp+var_4]
		and	cl, 8
		mov	di, ax
		cmp	cl, 8
		jnz	short loc_20C6A
		mov	ax, 1
		jmp	short loc_20C6C
; ---------------------------------------------------------------------------

loc_20C6A:				; CODE XREF: sub_20C1C+47j
		sub	ax, ax

loc_20C6C:				; CODE XREF: sub_20C1C+4Cj
		imul	word ptr [si+2194h]
		sub	ax, di
		mov	[si+217Ch], ax
		or	ax, ax
		jnz	short loc_20C84
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_20810
		jmp	short loc_20C8B
; ---------------------------------------------------------------------------
		align 2

loc_20C84:				; CODE XREF: sub_20C1C+5Cj
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_20850

loc_20C8B:				; CODE XREF: sub_20C1C+65j
		add	sp, 2

loc_20C8E:				; CODE XREF: sub_20C1C+26j
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 10h
		cmp	al, 10h
		jnz	short loc_20CA7
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_205F0
		add	sp, 2

loc_20CA7:				; CODE XREF: sub_20C1C+7Fj
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 20h
		cmp	al, 20h	; ' '
		jnz	short loc_20CC0
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_20742
		add	sp, 2

loc_20CC0:				; CODE XREF: sub_20C1C+98j
		push	[bp+arg_0]
		call	sub_1A9BC
		add	sp, 2
		cmp	ax, 1
		jnz	short loc_20CDA
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_2088A
		add	sp, 2

loc_20CDA:				; CODE XREF: sub_20C1C+B2j
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_2164E
		add	sp, 2
		cmp	ax, 1
		jnz	short loc_20CF3
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_208E6
		add	sp, 2

loc_20CF3:				; CODE XREF: sub_20C1C+CBj
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_216FA
		add	sp, 2
		cmp	ax, 1
		jnz	short loc_20D0C
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_20956
		add	sp, 2

loc_20D0C:				; CODE XREF: sub_20C1C+E4j
		mov	ax, [bp+var_2]
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_20C1C	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_20D16	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 2
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 10h
		cmp	al, 10h
		jnz	short loc_20D35
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_20632
		add	sp, 2

loc_20D35:				; CODE XREF: sub_20D16+13j
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 20h
		cmp	al, 20h	; ' '
		jnz	short loc_20D4E
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_20784
		add	sp, 2

loc_20D4E:				; CODE XREF: sub_20D16+2Cj
		mov	ax, [bp+var_2]
		mov	sp, bp
		pop	bp
		retf
sub_20D16	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_20D56	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 2
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 10h
		cmp	al, 10h
		jnz	short loc_20D75
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_20678
		add	sp, 2

loc_20D75:				; CODE XREF: sub_20D56+13j
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 20h
		cmp	al, 20h	; ' '
		jnz	short loc_20D8E
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_207CA
		add	sp, 2

loc_20D8E:				; CODE XREF: sub_20D56+2Cj
		mov	ax, [bp+var_2]
		mov	sp, bp
		pop	bp
		retf
sub_20D56	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_20D96	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_20A5C
		add	sp, 2
		pop	bp
		retf
sub_20D96	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_20DA6	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_20C1C
		add	sp, 2
		pop	bp
		retf
sub_20DA6	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_20DB6	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_8		= word ptr -8
var_6		= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 8
		push	di
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+218Ah], 0
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+2178h]
		cmp	[bx+2178h], ax
		jle	short loc_20DF8
		mov	ax, cx
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		jmp	short loc_20E0C
; ---------------------------------------------------------------------------

loc_20DF8:				; CODE XREF: sub_20DB6+2Dj
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, cx
		imul	[bp+arg_0]

loc_20E0C:				; CODE XREF: sub_20DB6+40j
		mov	di, ax
		mov	ax, [di+2178h]
		sub	ax, [bx+2178h]
		mov	[bp+var_6], ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+2178h]
		cmp	[bx+2178h], ax
		jle	short loc_20E38
		mov	ax, 1
		jmp	short loc_20E3B
; ---------------------------------------------------------------------------
		align 2

loc_20E38:				; CODE XREF: sub_20DB6+7Aj
		mov	ax, 0FFFFh

loc_20E3B:				; CODE XREF: sub_20DB6+7Fj
		mov	[bp+var_4], ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+2178h]
		cmp	[bx+2178h], ax
		jle	short loc_20E5C
		mov	ax, 0FFFFh
		jmp	short loc_20E5F
; ---------------------------------------------------------------------------

loc_20E5C:				; CODE XREF: sub_20DB6+9Fj
		mov	ax, 1

loc_20E5F:				; CODE XREF: sub_20DB6+A4j
		mov	[bp+var_2], ax
		mov	byte ptr [si+21ADh], 0
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	byte ptr [bx+21ACh], 0
		jz	short loc_20EF8
		call	sub_1525A
		sub	ah, ah
		and	ax, 7
		cmp	ax, word_2A9F4
		jnb	short loc_20EF8
		push	[bp+arg_0]
		call	sub_22252
		add	sp, 2
		cmp	ax, 1
		jz	short loc_20EA0
		jmp	loc_21122
; ---------------------------------------------------------------------------

loc_20EA0:				; CODE XREF: sub_20DB6+E5j
		call	sub_1525A
		sub	ah, ah
		and	ax, 7
		cmp	ax, word_2A9F4
		jnb	short loc_20ED8
		call	sub_1525A
		sub	ah, ah
		and	ax, 7
		cmp	ax, word_2A9F4
		jb	short loc_20EC3
		jmp	loc_21122
; ---------------------------------------------------------------------------

loc_20EC3:				; CODE XREF: sub_20DB6+108j
					; sub_20DB6+2A0j
		mov	ax, [si+2194h]
		imul	[bp+var_4]

loc_20ECA:				; CODE XREF: sub_20DB6+1E1j
		mov	[si+217Ch], ax
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_20850
		jmp	short loc_20EF2
; ---------------------------------------------------------------------------
		align 2

loc_20ED8:				; CODE XREF: sub_20DB6+F8j
		call	sub_1525A
		sub	ah, ah
		and	ax, 7
		cmp	ax, word_2A9F4
		jb	short loc_20EEB
		jmp	loc_21122
; ---------------------------------------------------------------------------

loc_20EEB:				; CODE XREF: sub_20DB6+130j
					; sub_20DB6+2D1j ...
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_2088A

loc_20EF2:				; CODE XREF: sub_20DB6+11Fj
					; sub_20DB6+1A5j ...
		add	sp, 2
		jmp	loc_21122
; ---------------------------------------------------------------------------

loc_20EF8:				; CODE XREF: sub_20DB6+C5j
					; sub_20DB6+D5j
		call	sub_1525A
		sub	ah, ah
		and	ax, 7
		cmp	ax, word_2A9F4
		jb	short loc_20F0B
		jmp	loc_21106
; ---------------------------------------------------------------------------

loc_20F0B:				; CODE XREF: sub_20DB6+150j
		cmp	[bp+var_6], 30h	; '0'
		jl	short loc_20F14
		jmp	loc_20FD8
; ---------------------------------------------------------------------------

loc_20F14:				; CODE XREF: sub_20DB6+159j
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	al, [bx+21ABh]
		sub	ah, ah
		or	ax, ax
		jz	short loc_20F3A
		cmp	ax, 1
		jz	short loc_20F68
		cmp	ax, 2
		jz	short loc_20FA4
		jmp	loc_21122
; ---------------------------------------------------------------------------

loc_20F3A:				; CODE XREF: sub_20DB6+175j
		call	sub_1525A
		and	ax, 3
		jnz	short loc_20F47
		jmp	loc_210D0
; ---------------------------------------------------------------------------

loc_20F47:				; CODE XREF: sub_20DB6+18Cj
		cmp	ax, 1
		jz	short loc_20F54
		cmp	ax, 2
		jz	short loc_20F5E
		jmp	short loc_20F7C
; ---------------------------------------------------------------------------
		align 2

loc_20F54:				; CODE XREF: sub_20DB6+194j
					; sub_20DB6+1BFj
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_209C0
		jmp	short loc_20EF2
; ---------------------------------------------------------------------------
		align 2

loc_20F5E:				; CODE XREF: sub_20DB6+199j
					; sub_20DB6+1FBj
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_2056C
		jmp	short loc_20EF2
; ---------------------------------------------------------------------------
		align 2

loc_20F68:				; CODE XREF: sub_20DB6+17Aj
		call	sub_1525A
		and	ax, 3
		jz	short loc_20F88
		cmp	ax, 1
		jz	short loc_20F54
		cmp	ax, 2
		jz	short loc_20F9A

loc_20F7C:				; CODE XREF: sub_20DB6+19Bj
					; sub_20DB6+26Bj
		cmp	ax, 3
		jnz	short loc_20F84
		jmp	loc_21024
; ---------------------------------------------------------------------------

loc_20F84:				; CODE XREF: sub_20DB6+1C9j
		jmp	loc_21122
; ---------------------------------------------------------------------------
		align 2

loc_20F88:				; CODE XREF: sub_20DB6+1BAj
					; sub_20DB6+263j ...
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	ax, [si+2194h]
		imul	[bp+var_2]
		jmp	loc_20ECA
; ---------------------------------------------------------------------------

loc_20F9A:				; CODE XREF: sub_20DB6+1C4j
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_205F0
		jmp	loc_20EF2
; ---------------------------------------------------------------------------

loc_20FA4:				; CODE XREF: sub_20DB6+17Fj
		call	sub_1525A
		and	ax, 3
		jz	short loc_20FC4
		cmp	ax, 1
		jz	short loc_20F5E
		cmp	ax, 2
		jz	short loc_20FCE
		cmp	ax, 3
		jnz	short loc_20FC0
		jmp	loc_210D0
; ---------------------------------------------------------------------------

loc_20FC0:				; CODE XREF: sub_20DB6+205j
		jmp	loc_21122
; ---------------------------------------------------------------------------
		align 2

loc_20FC4:				; CODE XREF: sub_20DB6+1F6j
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_206BE
		jmp	loc_20EF2
; ---------------------------------------------------------------------------

loc_20FCE:				; CODE XREF: sub_20DB6+200j
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_20810
		jmp	loc_20EF2
; ---------------------------------------------------------------------------

loc_20FD8:				; CODE XREF: sub_20DB6+15Bj
		cmp	[bp+var_6], 40h	; '@'
		jl	short loc_20FE1
		jmp	loc_2106E
; ---------------------------------------------------------------------------

loc_20FE1:				; CODE XREF: sub_20DB6+226j
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	al, [bx+21ABh]
		sub	ah, ah
		or	ax, ax
		jz	short loc_21007
		cmp	ax, 1
		jz	short loc_2102E
		cmp	ax, 2
		jz	short loc_21007
		jmp	loc_21122
; ---------------------------------------------------------------------------

loc_21007:				; CODE XREF: sub_20DB6+242j
					; sub_20DB6+24Cj
		call	sub_1525A
		and	ax, 3
		jnz	short loc_21014
		jmp	loc_210D0
; ---------------------------------------------------------------------------

loc_21014:				; CODE XREF: sub_20DB6+259j
		cmp	ax, 1
		jnz	short loc_2101C
		jmp	loc_20F88
; ---------------------------------------------------------------------------

loc_2101C:				; CODE XREF: sub_20DB6+261j
		cmp	ax, 2
		jz	short loc_21064
		jmp	loc_20F7C
; ---------------------------------------------------------------------------

loc_21024:				; CODE XREF: sub_20DB6+1CBj
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_20742
		jmp	loc_20EF2
; ---------------------------------------------------------------------------

loc_2102E:				; CODE XREF: sub_20DB6+247j
		call	sub_1525A
		and	ax, 3
		jz	short loc_2104E
		cmp	ax, 1
		jz	short loc_2105A
		cmp	ax, 2
		jnz	short loc_21045
		jmp	loc_20F88
; ---------------------------------------------------------------------------

loc_21045:				; CODE XREF: sub_20DB6+28Aj
		cmp	ax, 3
		jz	short loc_21064
		jmp	loc_21122
; ---------------------------------------------------------------------------
		align 2

loc_2104E:				; CODE XREF: sub_20DB6+280j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		jmp	loc_20EC3
; ---------------------------------------------------------------------------
		align 2

loc_2105A:				; CODE XREF: sub_20DB6+285j
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_20700
		jmp	loc_20EF2
; ---------------------------------------------------------------------------

loc_21064:				; CODE XREF: sub_20DB6+269j
					; sub_20DB6+292j
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_205AE
		jmp	loc_20EF2
; ---------------------------------------------------------------------------

loc_2106E:				; CODE XREF: sub_20DB6+228j
		cmp	[bp+var_6], 60h	; '`'
		jge	short loc_210B8
		call	sub_1525A
		and	ax, 7
		cmp	ax, 7
		jbe	short loc_21084
		jmp	loc_21122
; ---------------------------------------------------------------------------

loc_21084:				; CODE XREF: sub_20DB6+2C9j
		add	ax, ax
		xchg	ax, bx
		jmp	cs:off_210A6[bx]
; ---------------------------------------------------------------------------
		jmp	loc_20EEB
; ---------------------------------------------------------------------------
		align 2

loc_21090:				; CODE XREF: sub_20DB6+2D1j
					; sub_20DB6+312j
					; DATA XREF: ...
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_20956
		jmp	loc_20EF2
; ---------------------------------------------------------------------------

loc_2109A:				; CODE XREF: sub_20DB6+2D1j
					; sub_20DB6+312j
					; DATA XREF: ...
		push	[bp+arg_0]
		call	sub_22252
		jmp	loc_20EF2
; ---------------------------------------------------------------------------
		align 2
off_210A6	dw offset loc_20EEB	; DATA XREF: sub_20DB6+2D1r
		dw offset loc_210D0
		dw offset loc_21090
		dw offset loc_2109A
		dw offset loc_2109A
		dw offset loc_2109A
		dw offset loc_210E4
		dw offset loc_21106
; ---------------------------------------------------------------------------
		jmp	short loc_21122
; ---------------------------------------------------------------------------

loc_210B8:				; CODE XREF: sub_20DB6+2BCj
		call	sub_1525A
		and	ax, 7
		cmp	ax, 7
		ja	short loc_21122
		add	ax, ax
		xchg	ax, bx
		jmp	cs:off_210F4[bx]
; ---------------------------------------------------------------------------
		jmp	loc_20EEB
; ---------------------------------------------------------------------------

loc_210D0:				; CODE XREF: sub_20DB6+18Ej
					; sub_20DB6+207j ...
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_208E6
		jmp	loc_20EF2
; ---------------------------------------------------------------------------

loc_210DA:				; CODE XREF: sub_20DB6+312j
					; DATA XREF: sub_20DB6+346o
		cmp	[bp+var_6], 60h	; '`'
		jle	short loc_210EA

loc_210E0:				; CODE XREF: sub_20DB6+332j
					; sub_20DB6+354j
		mov	al, 1
		jmp	short loc_21114
; ---------------------------------------------------------------------------

loc_210E4:				; CODE XREF: sub_20DB6+2D1j
					; sub_20DB6+312j
					; DATA XREF: ...
		cmp	[bp+var_6], 60h	; '`'
		jg	short loc_210E0

loc_210EA:				; CODE XREF: sub_20DB6+328j
		cmp	[bp+var_6], 50h	; 'P'
		jge	short loc_21112

loc_210F0:				; CODE XREF: sub_20DB6+35Aj
		mov	al, 2
		jmp	short loc_21114
; ---------------------------------------------------------------------------
off_210F4	dw offset loc_20EEB	; DATA XREF: sub_20DB6+312r
		dw offset loc_210D0
		dw offset loc_21090
		dw offset loc_2109A
		dw offset loc_210DA
		dw offset loc_21106
		dw offset loc_210E4
		dw offset loc_210E4
; ---------------------------------------------------------------------------
		jmp	short loc_21122
; ---------------------------------------------------------------------------

loc_21106:				; CODE XREF: sub_20DB6+152j
					; sub_20DB6+2D1j ...
		cmp	[bp+var_6], 60h	; '`'
		jg	short loc_210E0
		cmp	[bp+var_6], 50h	; 'P'
		jl	short loc_210F0

loc_21112:				; CODE XREF: sub_20DB6+338j
		sub	al, al

loc_21114:				; CODE XREF: sub_20DB6+32Cj
					; sub_20DB6+33Cj
		mov	cx, ax
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		mov	[bx+21ADh], cl

loc_21122:				; CODE XREF: sub_20DB6+E7j
					; sub_20DB6+10Aj ...
		mov	ax, [bp+var_8]
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_20DB6	endp

; ---------------------------------------------------------------------------
		align 2
		push	bp
		mov	bp, sp
		sub	sp, 4
		push	di
		push	si
		mov	ax, 4Bh	; 'K'
		imul	word ptr [bp+6]
		mov	si, ax
		cmp	word ptr [bp+6], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+2178h]
		cmp	[bx+2178h], ax
		jle	short loc_21168
		mov	ax, cx
		imul	word ptr [bp+6]
		mov	bx, ax
		cmp	word ptr [bp+6], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		jmp	short loc_2117C
; ---------------------------------------------------------------------------

loc_21168:				; CODE XREF: seg008:0BF3j
		cmp	word ptr [bp+6], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, cx
		imul	word ptr [bp+6]

loc_2117C:				; CODE XREF: seg008:0C06j
		mov	di, ax
		mov	ax, [di+2178h]
		sub	ax, [bx+2178h]
		mov	[bp-2],	ax
		call	sub_1525A
		sub	ah, ah
		and	ax, 7
		cmp	ax, word_2A9F4
		jnb	short loc_211CC
		cmp	word ptr [bp-2], 50h ; 'P'
		jge	short loc_211CC
		cmp	word ptr [bp+6], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+217Ah]
		cmp	[bx+217Ah], ax
		jle	short loc_211C2
		push	word ptr [bp+6]
		push	cs
		call	near ptr sub_20784
		jmp	short loc_211C9
; ---------------------------------------------------------------------------
		align 2

loc_211C2:				; CODE XREF: seg008:0C56j
		push	word ptr [bp+6]
		push	cs
		call	near ptr sub_20632

loc_211C9:				; CODE XREF: seg008:0C5Fj
		add	sp, 2

loc_211CC:				; CODE XREF: seg008:0C37j seg008:0C3Dj
		mov	ax, [bp-4]
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
; ---------------------------------------------------------------------------
		align 2
		push	bp
		mov	bp, sp
		sub	sp, 4
		push	di
		push	si
		mov	ax, 4Bh	; 'K'
		imul	word ptr [bp+6]
		mov	si, ax
		cmp	word ptr [bp+6], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+2178h]
		cmp	[bx+2178h], ax
		jle	short loc_21212
		mov	ax, cx
		imul	word ptr [bp+6]
		mov	bx, ax
		cmp	word ptr [bp+6], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		jmp	short loc_21226
; ---------------------------------------------------------------------------

loc_21212:				; CODE XREF: seg008:0C9Dj
		cmp	word ptr [bp+6], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, cx
		imul	word ptr [bp+6]

loc_21226:				; CODE XREF: seg008:0CB0j
		mov	di, ax
		mov	ax, [di+2178h]
		sub	ax, [bx+2178h]
		mov	[bp-2],	ax
		call	sub_1525A
		sub	ah, ah
		and	ax, 7
		cmp	ax, word_2A9F4
		jnb	short loc_21276
		cmp	word ptr [bp-2], 50h ; 'P'
		jge	short loc_21276
		cmp	word ptr [bp+6], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+217Ah]
		cmp	[bx+217Ah], ax
		jge	short loc_2126C
		push	word ptr [bp+6]
		push	cs
		call	near ptr sub_207CA
		jmp	short loc_21273
; ---------------------------------------------------------------------------
		align 2

loc_2126C:				; CODE XREF: seg008:0D00j
		push	word ptr [bp+6]
		push	cs
		call	near ptr sub_20678

loc_21273:				; CODE XREF: seg008:0D09j
		add	sp, 2

loc_21276:				; CODE XREF: seg008:0CE1j seg008:0CE7j
		mov	ax, [bp-4]
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_21280	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 4
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	al, [si+21ADh]
		sub	ah, ah
		mov	[bp+var_4], ax
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_20DB6
		add	sp, 2
		mov	[bp+var_2], ax
		cmp	byte ptr [si+21AAh], 4
		jnz	short loc_212B3
		mov	al, byte ptr [bp+var_4]
		mov	[si+21ADh], al

loc_212B3:				; CODE XREF: sub_21280+2Aj
		mov	ax, [bp+var_2]
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_21280	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_212BC	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 4
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	al, [si+21ADh]
		sub	ah, ah
		mov	[bp+var_4], ax
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_20DB6
		add	sp, 2
		mov	[bp+var_2], ax
		cmp	byte ptr [si+21AAh], 5
		jnz	short loc_212EF
		mov	al, byte ptr [bp+var_4]
		mov	[si+21ADh], al

loc_212EF:				; CODE XREF: sub_212BC+2Aj
		mov	ax, [bp+var_2]
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_212BC	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_212F8	proc far		; CODE XREF: sub_11230+1B1P
					; sub_11230+1C4P ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	ax, 14h
		imul	[bp+arg_0]
		mov	cl, 3
		shl	ax, cl
		add	ax, 0F0h ; '�'
		mov	[si+2178h], ax
		mov	word ptr [si+217Ah], 9Eh ; '�'
		mov	word ptr [si+217Ch], 0
		mov	word ptr [si+217Ch], 0
		mov	word ptr [si+217Eh], 0
		mov	word ptr [si+2182h], 0
		mov	word ptr [si+2180h], 0C9h ; '�'
		mov	word ptr [si+2184h], 0
		mov	word ptr [si+2188h], 0
		mov	word ptr [si+218Ah], 0
		mov	word ptr [si+218Ch], 0
		mov	word ptr [si+219Ah], 0
		mov	word ptr [si+219Ch], 0
		mov	word ptr [si+219Eh], 0
		mov	word ptr [si+21A0h], 0
		mov	word ptr [si+21A2h], 0
		mov	word ptr [si+21A4h], 0
		mov	word ptr [si+21A6h], 0
		mov	word ptr [si+218Eh], 0FFC4h
		mov	word ptr [si+2190h], 0Ah
		mov	word ptr [si+2192h], 2
		mov	word ptr [si+2194h], 8
		mov	word ptr [si+2196h], 4
		mov	byte ptr [si+21A8h], 0
		mov	word ptr [si+2198h], 0
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	[si+21A9h], al
		mov	byte ptr [si+21AAh], 0
		mov	byte ptr [si+21ABh], 0
		mov	byte ptr [si+21ACh], 0
		mov	byte ptr [si+21ADh], 0
		mov	byte ptr [si+21AEh], 6
		mov	byte ptr [si+21AFh], 0
		mov	[si+21B0h], cl
		mov	byte ptr [si+21B1h], 0
		mov	byte ptr [si+21B2h], 0
		mov	byte ptr [si+21B3h], 0Ah
		mov	byte ptr [si+21B4h], 0Ch
		mov	byte ptr [si+21B5h], 6
		mov	byte ptr [si+21B6h], 9
		mov	byte ptr [si+21B7h], 10h
		mov	byte ptr [si+21B8h], 0Dh
		mov	byte ptr [si+21B9h], 0Fh
		mov	byte ptr [si+21BAh], 11h
		mov	byte ptr [si+21BBh], 12h
		mov	byte ptr [si+21BCh], 1
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21BDh], 0
		mov	byte ptr [si+21BEh], 40h ; '@'
		mov	byte ptr [si+21BFh], 2
		mov	[si+21C0h], cl
		mov	byte ptr [si+21C1h], 5
		mov	byte ptr [si+21C2h], 45h ; 'E'
		pop	si
		pop	bp
		retf
sub_212F8	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_21436	proc far		; CODE XREF: sub_12822+34P
					; sub_12822+52P ...

var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	si
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	word ptr [bx+2180h], 0
		jle	short loc_2145D
		cmp	word_2CEE8, 0
		jz	short loc_2145D
		jmp	loc_2150B
; ---------------------------------------------------------------------------

loc_2145D:				; CODE XREF: sub_21436+1Bj
					; sub_21436+22j
		mov	si, [bp+arg_0]
		shl	si, 1
		mov	word ptr [si+2514h], 0
		mov	word ptr [si+2448h], 0
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	byte ptr [bx+21AAh], 0
		jnz	short loc_21493
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	byte ptr [bx+21AAh], 0Ah
		jz	short loc_214C2

loc_21493:				; CODE XREF: sub_21436+45j
		cmp	word_2CEE8, 0
		jnz	short loc_2150B
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+2180h]
		cmp	[bx+2180h], ax
		jge	short loc_2150B
		cmp	byte ptr [si+21AAh], 0
		jnz	short loc_2150B

loc_214C2:				; CODE XREF: sub_21436+5Bj
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21AAh], 12h
		mov	byte ptr [si+21B0h], 3
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21ADh], 14h
		mov	byte ptr [si+21AEh], 41h ; 'A'
		mov	byte ptr [si+21B1h], 44h ; 'D'
		mov	byte ptr [si+21B2h], 44h ; 'D'
		mov	bx, [bp+arg_0]
		shl	bx, 1
		inc	word ptr [bx+2646h]
		mov	ax, 4
		push	ax
		push	[bp+arg_0]
		call	sub_15C20
		add	sp, 4
		mov	word_2A9E4, 1

loc_2150B:				; CODE XREF: sub_21436+24j
					; sub_21436+62j ...
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	ax, [bx+2514h]
		mov	[bp+var_2], ax
		push	[bp+arg_0]
		call	sub_107EA
		add	sp, 2
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	word ptr [si+2186h], 0
		jnz	short loc_21558
		push	[bp+arg_0]
		mov	bl, [si+21AAh]
		sub	bh, bh
		shl	bx, 1
		shl	bx, 1
		call	off_2C6BE[bx]
		add	sp, 2
		push	[bp+arg_0]
		mov	bl, [si+21AAh]
		sub	bh, bh
		shl	bx, 1
		shl	bx, 1
		call	off_2C77E[bx]
		jmp	short loc_2159B
; ---------------------------------------------------------------------------

loc_21558:				; CODE XREF: sub_21436+F9j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		add	si, 21AAh
		push	[bp+arg_0]
		mov	bl, [si]
		sub	bh, bh
		shl	bx, 1
		shl	bx, 1
		call	off_2C71E[bx]
		add	sp, 2
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	word ptr [bx+2180h], 0
		jle	short loc_2159E
		push	[bp+arg_0]
		mov	bl, [si]
		sub	bh, bh
		shl	bx, 1
		shl	bx, 1
		call	off_2C7E2[bx]

loc_2159B:				; CODE XREF: sub_21436+120j
		add	sp, 2

loc_2159E:				; CODE XREF: sub_21436+154j
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_215D2
		add	sp, 2
		push	[bp+arg_0]
		call	sub_233A6
		add	sp, 2
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		mov	ax, [bp+var_2]
		mov	[bx+2198h], ax
		push	[bp+arg_0]
		call	sub_2398E
		add	sp, 2
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_21436	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_215D2	proc far		; CODE XREF: sub_21436+16Cp

var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	di
		push	si
		mov	[bp+var_2], 0
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	word ptr [si+21A6h], 1
		jnz	short loc_21644
		inc	word ptr [si+219Ah]
		cmp	word ptr [si+219Ah], 30h ; '0'
		jle	short loc_215FF
		mov	word ptr [si+219Ah], 2Fh ; '/'

loc_215FF:				; CODE XREF: sub_215D2+25j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	word ptr [si+219Ch], 0
		jnz	short loc_21614
		mov	ax, 0FFF0h
		jmp	short loc_21617
; ---------------------------------------------------------------------------
		align 2

loc_21614:				; CODE XREF: sub_215D2+3Aj
		mov	ax, 10h

loc_21617:				; CODE XREF: sub_215D2+3Fj
		add	[si+21A2h], ax
		mov	di, word_2A9DC
		mov	cl, 3
		shl	di, cl
		lea	ax, [di-20h]
		cmp	[si+21A2h], ax
		jl	short loc_21636
		lea	ax, [di+160h]
		cmp	[si+21A2h], ax
		jle	short loc_21644

loc_21636:				; CODE XREF: sub_215D2+58j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		mov	word ptr [bx+21A6h], 0

loc_21644:				; CODE XREF: sub_215D2+1Aj
					; sub_215D2+62j
		mov	ax, [bp+var_2]
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_215D2	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_2164E	proc far		; CODE XREF: sub_20A5C+189p
					; sub_20C1C+C2p

var_E		= word ptr -0Eh
var_C		= word ptr -0Ch
var_A		= word ptr -0Ah
var_8		= word ptr -8
var_6		= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 10h
		push	di
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	byte ptr [bx+21A9h], 0
		jnz	short loc_2166A
		mov	ax, 4
		jmp	short loc_2166D
; ---------------------------------------------------------------------------

loc_2166A:				; CODE XREF: sub_2164E+15j
		mov	ax, 8

loc_2166D:				; CODE XREF: sub_2164E+1Aj
		mov	[bp+var_4], ax
		mov	[bp+var_8], 0
		mov	[bp+var_C], 0
		mov	[bp+var_2], 0
		mov	ax, word_2D012
		mov	[bp+var_A], ax
		dec	[bp+var_A]
		jns	short loc_2168F
		mov	[bp+var_A], 1Dh

loc_2168F:				; CODE XREF: sub_2164E+3Aj
		mov	bx, [bp+arg_0]
		shl	bx, 1
		cmp	word ptr [bx+2448h], 21h ; '!'
		jnz	short loc_216F0
		mov	di, 1
		mov	[bp+var_6], 1Eh
		mov	ax, 3Ch	; '<'
		imul	[bp+arg_0]
		mov	[bp+var_E], ax
		mov	si, 1Eh
		mov	dx, [bp+var_2]
		mov	cx, [bp+var_A]

loc_216B5:				; CODE XREF: sub_2164E+8Dj
		mov	bx, cx
		shl	bx, 1
		add	bx, [bp+var_E]
		mov	al, [bx+254Ah]
		and	al, 2
		cmp	al, 2
		jnz	short loc_216D4
		cmp	di, 1
		jnz	short loc_216D4
		inc	dx
		cmp	dx, 0Ah
		jnz	short loc_216D4
		mov	di, 2

loc_216D4:				; CODE XREF: sub_2164E+76j
					; sub_2164E+7Bj ...
		dec	cx
		jns	short loc_216DA
		mov	cx, 1Dh

loc_216DA:				; CODE XREF: sub_2164E+87j
		dec	si
		jnz	short loc_216B5
		mov	[bp+var_8], di
		mov	[bp+var_2], dx
		mov	[bp+var_A], cx
		cmp	di, 2
		jnz	short loc_216F0
		mov	[bp+var_C], 1

loc_216F0:				; CODE XREF: sub_2164E+4Bj
					; sub_2164E+9Bj
		mov	ax, [bp+var_C]
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_2164E	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_216FA	proc far		; CODE XREF: sub_20A5C+1A2p
					; sub_20C1C+DBp

var_12		= word ptr -12h
var_10		= byte ptr -10h
var_E		= word ptr -0Eh
var_C		= word ptr -0Ch
var_A		= word ptr -0Ah
var_8		= word ptr -8
var_6		= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 14h
		push	di
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		mov	al, [bx+21A9h]
		mov	[bp+var_10], al
		or	al, al
		jnz	short loc_2171A
		mov	ax, 4
		jmp	short loc_2171D
; ---------------------------------------------------------------------------

loc_2171A:				; CODE XREF: sub_216FA+19j
		mov	ax, 8

loc_2171D:				; CODE XREF: sub_216FA+1Ej
		mov	[bp+var_4], ax
		cmp	[bp+var_10], 1
		jnz	short loc_2172C
		mov	ax, 4
		jmp	short loc_2172F
; ---------------------------------------------------------------------------
		align 2

loc_2172C:				; CODE XREF: sub_216FA+2Aj
		mov	ax, 8

loc_2172F:				; CODE XREF: sub_216FA+2Fj
		mov	[bp+var_E], ax
		mov	[bp+var_8], 0
		mov	[bp+var_C], 0
		mov	[bp+var_2], 0
		mov	ax, word_2D012
		mov	[bp+var_A], ax
		dec	[bp+var_A]
		jns	short loc_21751
		mov	[bp+var_A], 1Dh

loc_21751:				; CODE XREF: sub_216FA+50j
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	ax, [bp+var_4]
		add	ax, 30h	; '0'
		cmp	[bx+2448h], ax
		jnz	short loc_217B9
		mov	di, 1
		mov	[bp+var_6], 1Eh
		mov	ax, 3Ch	; '<'
		imul	[bp+arg_0]
		mov	[bp+var_12], ax
		mov	si, 1Eh
		mov	dx, [bp+var_2]
		mov	cx, [bp+var_A]

loc_2177C:				; CODE XREF: sub_216FA+AAj
		mov	bx, cx
		shl	bx, 1
		add	bx, [bp+var_12]
		mov	ax, [bx+254Ah]
		and	ax, [bp+var_E]
		cmp	ax, [bp+var_E]
		jnz	short loc_2179D
		cmp	di, 1
		jnz	short loc_2179D
		inc	dx
		cmp	dx, 0Ah
		jnz	short loc_2179D
		mov	di, 2

loc_2179D:				; CODE XREF: sub_216FA+93j
					; sub_216FA+98j ...
		dec	cx
		jns	short loc_217A3
		mov	cx, 1Dh

loc_217A3:				; CODE XREF: sub_216FA+A4j
		dec	si
		jnz	short loc_2177C
		mov	[bp+var_8], di
		mov	[bp+var_2], dx
		mov	[bp+var_A], cx
		cmp	di, 2
		jnz	short loc_217B9
		mov	[bp+var_C], 1

loc_217B9:				; CODE XREF: sub_216FA+66j
					; sub_216FA+B8j
		mov	ax, [bp+var_C]
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_216FA	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_217C2	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21ABh], 0
		inc	byte ptr [si+21AFh]
		mov	al, [si+21AFh]
		cmp	[si+21B0h], al
		ja	short loc_2184C
		mov	byte ptr [si+21AFh], 0
		inc	byte ptr [si+21AEh]
		cmp	byte ptr [si+21AEh], 2Ch ; ','
		jnz	short loc_21838
		cmp	byte ptr [si+21A9h], 0
		jnz	short loc_21800
		mov	ax, 0FFF8h
		jmp	short loc_21803
; ---------------------------------------------------------------------------

loc_21800:				; CODE XREF: sub_217C2+37j
		mov	ax, 8

loc_21803:				; CODE XREF: sub_217C2+3Cj
		add	ax, [si+2178h]
		mov	[si+21A2h], ax
		mov	ax, [si+217Ah]
		sub	ax, 40h	; '@'
		mov	[si+21A4h], ax
		mov	al, [si+21A9h]
		sub	ah, ah
		mov	[si+219Ch], ax
		mov	word ptr [si+219Ah], 2Fh ; '/'
		mov	word ptr [si+21A6h], 1
		mov	word ptr [si+219Eh], 0
		mov	word ptr [si+21A0h], 0

loc_21838:				; CODE XREF: sub_217C2+30j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	byte ptr [si+21AEh], 2Dh ; '-'
		jnz	short loc_2184C
		mov	byte ptr [si+21B0h], 4

loc_2184C:				; CODE XREF: sub_217C2+20j
					; sub_217C2+83j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	byte ptr [si+21AEh], 2Eh ; '.'
		jbe	short loc_21885
		push	[bp+arg_0]
		call	sub_21EF8
		add	sp, 2
		mov	al, [si+21B5h]
		mov	[si+21B1h], al
		mov	[si+21B2h], al
		mov	byte ptr [si+21B0h], 1
		mov	byte ptr [si+21AFh], 0
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 0Ch

loc_21885:				; CODE XREF: sub_217C2+97j
		mov	ax, [bp+var_2]
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_217C2	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_2188E	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21ABh], 2
		mov	byte ptr [si+21ACh], 1
		cmp	byte ptr [si+21ADh], 1
		jnz	short loc_21918
		push	[bp+arg_0]
		call	sub_2274C
		add	sp, 2
		cmp	ax, 1
		jnz	short loc_218EA
		push	[bp+arg_0]
		call	sub_21EF8
		add	sp, 2
		mov	al, [si+21B5h]
		mov	[si+21B1h], al
		mov	[si+21B2h], al
		mov	byte ptr [si+21B0h], 1
		mov	byte ptr [si+21AFh], 0
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 0Ch
		jmp	short loc_21959
; ---------------------------------------------------------------------------

loc_218EA:				; CODE XREF: sub_2188E+2Ej
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		inc	byte ptr [si+21AFh]
		mov	al, [si+21AFh]
		cmp	[si+21B0h], al
		ja	short loc_21959
		mov	byte ptr [si+21AFh], 0
		inc	byte ptr [si+21AEh]
		cmp	byte ptr [si+21AEh], 36h ; '6'
		jbe	short loc_21959
		mov	byte ptr [si+21AEh], 36h ; '6'
		jmp	short loc_21959
; ---------------------------------------------------------------------------
		align 2

loc_21918:				; CODE XREF: sub_2188E+1Ej
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	ax, [si+217Eh]
		add	[si+217Ah], ax
		mov	ax, [si+217Ch]
		add	[si+2178h], ax
		inc	byte ptr [si+21AFh]
		mov	al, [si+21AFh]
		cmp	[si+21B0h], al
		ja	short loc_21959
		mov	byte ptr [si+21AFh], 0
		inc	byte ptr [si+21AEh]
		cmp	byte ptr [si+21AEh], 33h ; '3'
		jbe	short loc_21959
		mov	byte ptr [si+21ADh], 1
		mov	word ptr [si+217Ch], 0

loc_21959:				; CODE XREF: sub_2188E+5Aj
					; sub_2188E+70j ...
		mov	ax, [bp+var_2]
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_2188E	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_21962	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21ABh], 2
		mov	byte ptr [si+21ACh], 1
		inc	byte ptr [si+21ADh]
		mov	ax, [si+217Ch]
		add	[si+2178h], ax
		or	ax, ax
		jle	short loc_21990
		mov	ax, 0FFFFh
		jmp	short loc_21993
; ---------------------------------------------------------------------------

loc_21990:				; CODE XREF: sub_21962+27j
		mov	ax, 1

loc_21993:				; CODE XREF: sub_21962+2Cj
		add	[si+217Ch], ax
		inc	byte ptr [si+21AFh]
		mov	al, [si+21AFh]
		cmp	[si+21B0h], al
		ja	short loc_219BA
		mov	byte ptr [si+21AFh], 0
		inc	byte ptr [si+21AEh]
		cmp	byte ptr [si+21AEh], 39h ; '9'
		jnz	short loc_219BA
		mov	byte ptr [si+21AEh], 38h ; '8'

loc_219BA:				; CODE XREF: sub_21962+41j
					; sub_21962+51j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	byte ptr [si+21ADh], 8
		jnz	short loc_219CE
		mov	byte ptr [si+21AEh], 39h ; '9'

loc_219CE:				; CODE XREF: sub_21962+65j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	byte ptr [si+21ADh], 0Ah
		jnz	short loc_21A07
		push	[bp+arg_0]
		call	sub_21EF8
		add	sp, 2
		mov	al, [si+21B5h]
		mov	[si+21B1h], al
		mov	[si+21B2h], al
		mov	byte ptr [si+21B0h], 2
		mov	byte ptr [si+21AFh], 0
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 0Ch

loc_21A07:				; CODE XREF: sub_21962+79j
		mov	ax, [bp+var_2]
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_21962	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_21A10	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	si
		mov	ax, [bp+arg_0]
		mov	word_2D37C, ax
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21A8h], 1
		cmp	byte ptr [si+21ADh], 3
		jnz	short loc_21A86
		inc	byte ptr [si+21AFh]
		mov	al, [si+21AFh]
		cmp	[si+21B0h], al
		ja	short loc_21A86
		mov	byte ptr [si+21AFh], 0
		inc	byte ptr [si+21AEh]
		mov	al, [si+21B2h]
		cmp	[si+21AEh], al
		jbe	short loc_21A86
		mov	byte ptr [si+21A8h], 0
		push	[bp+arg_0]
		call	sub_21EF8
		add	sp, 2
		mov	al, [si+21B5h]
		mov	[si+21B1h], al
		mov	[si+21B2h], al
		mov	byte ptr [si+21B0h], 1
		mov	byte ptr [si+21AFh], 0
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 0Ch
		mov	byte ptr [si+21ADh], 5

loc_21A86:				; CODE XREF: sub_21A10+1Fj
					; sub_21A10+2Dj ...
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	byte ptr [si+21ADh], 2
		jz	short loc_21A98
		jmp	loc_21D3C
; ---------------------------------------------------------------------------

loc_21A98:				; CODE XREF: sub_21A10+83j
		cmp	byte ptr [si+21AFh], 1
		ja	short loc_21AA2
		jmp	loc_21C2A
; ---------------------------------------------------------------------------

loc_21AA2:				; CODE XREF: sub_21A10+8Dj
		cmp	byte ptr [si+21AFh], 2
		ja	short loc_21AAC
		jmp	loc_21BCA
; ---------------------------------------------------------------------------

loc_21AAC:				; CODE XREF: sub_21A10+97j
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	byte ptr [bx+21AAh], 10h
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		cmp	byte ptr [si+21A9h], 1
		sbb	ax, ax
		neg	ax
		or	al, 2
		mov	[bx+21A9h], al
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	al, [bx+21BCh]
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+21AEh], cl
		cmp	byte ptr [si+21A9h], 0
		jz	short loc_21B0A
		jmp	loc_21C8F
; ---------------------------------------------------------------------------

loc_21B0A:				; CODE XREF: sub_21A10+F5j
					; sub_21A10+27Cj
		mov	ax, 0FFE8h

loc_21B0D:				; CODE XREF: sub_21A10+217j
					; sub_21A10+282j
		add	ax, [si+2178h]
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+2178h], cx
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+217Ah]
		sub	ax, 20h	; ' '
		mov	[bx+217Ah], ax
		mov	ax, cx
		imul	[bp+arg_0]
		mov	si, ax
		inc	byte ptr [si+21AFh]
		mov	al, [si+21AFh]
		cmp	[si+21B0h], al
		jbe	short loc_21B58
		jmp	loc_21D3C
; ---------------------------------------------------------------------------

loc_21B58:				; CODE XREF: sub_21A10+143j
		mov	byte ptr [si+21AFh], 0
		inc	byte ptr [si+21AEh]
		mov	al, [si+21B2h]
		cmp	[si+21AEh], al
		jz	short loc_21B6E
		jmp	loc_21D3C
; ---------------------------------------------------------------------------

loc_21B6E:				; CODE XREF: sub_21A10+159j
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	byte ptr [bx+21AAh], 9
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	al, [bx+21BFh]
		inc	al
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+21AEh], cl
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	al, [si+21A9h]
		mov	[bx+21A9h], al
		cmp	al, 1
		jz	short loc_21BC4
		jmp	loc_21C96
; ---------------------------------------------------------------------------

loc_21BC4:				; CODE XREF: sub_21A10+1AFj
		mov	ax, 40h	; '@'
		jmp	loc_21C99
; ---------------------------------------------------------------------------

loc_21BCA:				; CODE XREF: sub_21A10+99j
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	byte ptr [bx+21AAh], 10h
		mov	ax, cx
		imul	[bp+arg_0]
		mov	si, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		cmp	byte ptr [si+21A9h], 1
		sbb	ax, ax
		neg	ax
		or	al, 2
		mov	[bx+21A9h], al
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	al, [bx+21BFh]
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+21AEh], cl
		sub	ax, ax
		jmp	loc_21B0D
; ---------------------------------------------------------------------------

loc_21C2A:				; CODE XREF: sub_21A10+8Fj
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	byte ptr [bx+21AAh], 10h
		mov	ax, cx
		imul	[bp+arg_0]
		mov	si, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		cmp	byte ptr [si+21A9h], 1
		sbb	ax, ax
		neg	ax
		mov	[bx+21A9h], al
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	al, [bx+21BFh]
		inc	al
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+21AEh], cl
		cmp	byte ptr [si+21A9h], 0
		jz	short loc_21C8F
		jmp	loc_21B0A
; ---------------------------------------------------------------------------

loc_21C8F:				; CODE XREF: sub_21A10+F7j
					; sub_21A10+27Aj
		mov	ax, 18h
		jmp	loc_21B0D
; ---------------------------------------------------------------------------
		align 2

loc_21C96:				; CODE XREF: sub_21A10+1B1j
		mov	ax, 0FFC0h

loc_21C99:				; CODE XREF: sub_21A10+1B7j
		add	ax, [si+2178h]
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+2178h], cx
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+217Ah]
		sub	ax, 20h	; ' '
		mov	[bx+217Ah], ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	word ptr [bx+217Eh], 0
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		cmp	byte ptr [bx+21A9h], 1
		jnz	short loc_21CF6
		mov	ax, 30h	; '0'
		jmp	short loc_21CF9
; ---------------------------------------------------------------------------

loc_21CF6:				; CODE XREF: sub_21A10+2DFj
		mov	ax, 0FFD0h

loc_21CF9:				; CODE XREF: sub_21A10+2E4j
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+217Ch], cx
		mov	byte ptr [si+21ADh], 3
		mov	byte ptr [si+21B0h], 8
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	word ptr [bx+218Ch], 30h ; '0'
		mov	ax, 1
		push	ax
		push	[bp+arg_0]
		call	sub_15C20
		add	sp, 4

loc_21D3C:				; CODE XREF: sub_21A10+85j
					; sub_21A10+145j ...
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	byte ptr [si+21ADh], 1
		jz	short loc_21D4E
		jmp	loc_21DFF
; ---------------------------------------------------------------------------

loc_21D4E:				; CODE XREF: sub_21A10+339j
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	byte ptr [bx+21AAh], 10h
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		cmp	byte ptr [si+21A9h], 1
		sbb	ax, ax
		neg	ax
		mov	[bx+21A9h], al
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	al, [bx+21BCh]
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+21AEh], cl
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+2178h]
		mov	[bx+2178h], ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	ax, [si+217Ah]
		mov	[bx+217Ah], ax
		inc	byte ptr [si+21AFh]
		mov	al, [si+21AFh]
		cmp	[si+21B0h], al
		ja	short loc_21DFF
		mov	byte ptr [si+21AFh], 0
		inc	byte ptr [si+21AEh]
		mov	al, [si+21B1h]
		sub	ah, ah
		add	ax, 4
		mov	cl, [si+21AEh]
		sub	ch, ch
		cmp	ax, cx
		jnz	short loc_21DFF
		mov	byte ptr [si+21ADh], 2
		mov	byte ptr [si+21B0h], 5

loc_21DFF:				; CODE XREF: sub_21A10+33Bj
					; sub_21A10+3C7j ...
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	byte ptr [si+21ADh], 0
		jz	short loc_21E11
		jmp	loc_21EF0
; ---------------------------------------------------------------------------

loc_21E11:				; CODE XREF: sub_21A10+3FCj
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	byte ptr [bx+21AAh], 10h
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		cmp	byte ptr [si+21A9h], 1
		sbb	ax, ax
		neg	ax
		mov	[bx+21A9h], al
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	al, [bx+21BDh]
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+21AEh], cl
		cmp	byte ptr [si+21A9h], 0
		jnz	short loc_21E70
		mov	ax, 0FFE8h
		jmp	short loc_21E73
; ---------------------------------------------------------------------------
		align 2

loc_21E70:				; CODE XREF: sub_21A10+458j
		mov	ax, 18h

loc_21E73:				; CODE XREF: sub_21A10+45Dj
		add	ax, [si+2178h]
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		mov	[bx+2178h], cx
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+217Ah]
		mov	[bx+217Ah], ax
		inc	byte ptr [si+21AFh]
		mov	al, [si+21AFh]
		cmp	[si+21B0h], al
		ja	short loc_21EF0
		mov	byte ptr [si+21AFh], 0
		inc	byte ptr [si+21AEh]
		mov	al, [si+21B1h]
		sub	ah, ah
		inc	ax
		mov	cl, [si+21AEh]
		sub	ch, ch
		cmp	ax, cx
		jnz	short loc_21ED0
		mov	byte ptr [si+21B0h], 1

loc_21ED0:				; CODE XREF: sub_21A10+4B9j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	al, [si+21B1h]
		sub	ah, ah
		add	ax, 2
		mov	cl, [si+21AEh]
		sub	ch, ch
		cmp	ax, cx
		jnz	short loc_21EF0
		mov	byte ptr [si+21ADh], 1

loc_21EF0:				; CODE XREF: sub_21A10+3FEj
					; sub_21A10+49Fj ...
		mov	ax, [bp+var_2]
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_21A10	endp

seg008		ends

; ===========================================================================

; Segment type:	Pure code
seg009		segment	byte public 'CODE' use16
		assume cs:seg009
		;org 8
		assume es:nothing, ss:nothing, ds:seg026, fs:nothing, gs:nothing

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_21EF8	proc far		; CODE XREF: sub_18E82+33EP
					; sub_191F0+4FDP ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [bx+2178h]
		mov	cl, 3
		sar	ax, cl
		mov	dx, [si+2178h]
		sar	dx, cl
		cmp	ax, dx
		jz	short loc_21F48
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+2178h]
		cmp	[bx+2178h], ax
		jge	short loc_21F42
		sub	al, al
		jmp	short loc_21F44
; ---------------------------------------------------------------------------

loc_21F42:				; CODE XREF: sub_21EF8+44j
		mov	al, 1

loc_21F44:				; CODE XREF: sub_21EF8+48j
		mov	[si+21A9h], al

loc_21F48:				; CODE XREF: sub_21EF8+2Bj
		pop	si
		pop	bp
		retf
sub_21EF8	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_21F4C	proc far		; CODE XREF: sub_18434+9EP
					; sub_1AA7E+A1P ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_21EF8
		add	sp, 2
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21AAh], 0
		mov	al, [si+21B5h]
		mov	[si+21AEh], al
		pop	si
		pop	bp
		retf
sub_21F4C	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_21F72	proc far		; CODE XREF: sub_17682+D2P
					; sub_19C18+D2P ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_21EF8
		add	sp, 2
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21AAh], 1
		mov	al, [si+21B7h]
		mov	[si+21AEh], al
		pop	si
		pop	bp
		retf
sub_21F72	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_21F98	proc far		; CODE XREF: sub_21FDC+24Ep
					; sub_22252+1E7p ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+217Ch], 0
		mov	byte ptr [si+21AAh], 4
		mov	al, [si+21BAh]
		mov	[si+21AEh], al
		pop	si
		pop	bp
		retf
sub_21F98	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_21FBA	proc far		; CODE XREF: sub_22252+B5p
					; sub_22448+82p ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+217Ch], 0
		mov	byte ptr [si+21AAh], 5
		mov	al, [si+21BBh]
		mov	[si+21AEh], al
		pop	si
		pop	bp
		retf
sub_21FBA	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_21FDC	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21ACh], 0
		mov	byte ptr [si+21ABh], 0
		mov	word ptr [si+218Ch], 0
		mov	word ptr [si+218Ah], 0
		mov	bx, [bp+arg_0]
		shl	bx, 1
		test	byte ptr [bx+2514h], 0Ch
		jz	short loc_22010
		jmp	loc_220E6
; ---------------------------------------------------------------------------

loc_22010:				; CODE XREF: sub_21FDC+2Fj
		mov	byte ptr [si+21B0h], 3
		inc	byte ptr [si+21AFh]
		mov	al, [si+21AFh]
		cmp	[si+21B0h], al
		jbe	short loc_22026
		jmp	loc_220D0
; ---------------------------------------------------------------------------

loc_22026:				; CODE XREF: sub_21FDC+45j
		mov	byte ptr [si+21AFh], 0
		inc	byte ptr [si+21AEh]
		mov	al, [si+21B5h]
		cmp	[si+21AEh], al
		jnb	short loc_2203D
		mov	[si+21AEh], al

loc_2203D:				; CODE XREF: sub_21FDC+5Bj
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	al, [si+21B6h]
		cmp	[si+21AEh], al
		jbe	short loc_22057
		mov	al, [si+21B5h]
		mov	[si+21AEh], al

loc_22057:				; CODE XREF: sub_21FDC+71j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	al, [si+21B5h]
		cmp	[si+21AEh], al
		jnz	short loc_2206F
		mov	word ptr [si+217Ah], 9Eh ; '�'

loc_2206F:				; CODE XREF: sub_21FDC+8Bj
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	al, [si+21B5h]
		sub	ah, ah
		inc	ax
		mov	cl, [si+21AEh]
		sub	ch, ch
		cmp	ax, cx
		jnz	short loc_2208E
		mov	word ptr [si+217Ah], 9Dh ; '�'

loc_2208E:				; CODE XREF: sub_21FDC+AAj
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	al, [si+21B5h]
		sub	ah, ah
		add	ax, 2
		mov	cl, [si+21AEh]
		sub	ch, ch
		cmp	ax, cx
		jnz	short loc_220AF
		mov	word ptr [si+217Ah], 9Ch ; '�'

loc_220AF:				; CODE XREF: sub_21FDC+CBj
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	al, [si+21B5h]
		sub	ah, ah
		add	ax, 3
		mov	cl, [si+21AEh]
		sub	ch, ch
		cmp	ax, cx
		jnz	short loc_220D0
		mov	word ptr [si+217Ah], 9Dh ; '�'

loc_220D0:				; CODE XREF: sub_21FDC+47j
					; sub_21FDC+ECj
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+217Ch], 0
		and	byte ptr [si+2178h], 0F8h
		jmp	loc_22230
; ---------------------------------------------------------------------------

loc_220E6:				; CODE XREF: sub_21FDC+31j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		inc	byte ptr [si+21AFh]
		mov	al, [si+21AFh]
		cmp	[si+21B0h], al
		ja	short loc_22105
		mov	byte ptr [si+21AFh], 0
		inc	byte ptr [si+21AEh]

loc_22105:				; CODE XREF: sub_21FDC+11Ej
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	al, [si+21B3h]
		cmp	[si+21AEh], al
		jnb	short loc_2211B
		mov	[si+21AEh], al

loc_2211B:				; CODE XREF: sub_21FDC+139j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	al, [si+21B4h]
		cmp	[si+21AEh], al
		jbe	short loc_22135
		mov	al, [si+21B3h]
		mov	[si+21AEh], al

loc_22135:				; CODE XREF: sub_21FDC+14Fj
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	byte ptr [si+21A9h], 0
		jnz	short loc_221BA
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 4
		cmp	al, 4
		jnz	short loc_22162
		mov	ax, [si+2194h]
		neg	ax
		mov	[si+217Ch], ax
		mov	byte ptr [si+21B0h], 1

loc_22162:				; CODE XREF: sub_21FDC+175j
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 8
		cmp	al, 8
		jz	short loc_22174
		jmp	loc_22230
; ---------------------------------------------------------------------------

loc_22174:				; CODE XREF: sub_21FDC+193j
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	byte ptr [bx+21ACh], 0
		jz	short loc_2218D
		jmp	loc_22226
; ---------------------------------------------------------------------------

loc_2218D:				; CODE XREF: sub_21FDC+1ACj
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		cmp	word ptr [bx+21A6h], 0
		jz	short loc_221A3
		jmp	loc_22226
; ---------------------------------------------------------------------------

loc_221A3:				; CODE XREF: sub_21FDC+1C2j
		mov	ax, cx
		imul	[bp+arg_0]
		mov	si, ax
		mov	ax, [si+2196h]

loc_221AE:				; CODE XREF: sub_21FDC+247j
		mov	[si+217Ch], ax
		mov	byte ptr [si+21B0h], 3
		jmp	short loc_22230
; ---------------------------------------------------------------------------
		align 2

loc_221BA:				; CODE XREF: sub_21FDC+166j
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 8
		cmp	al, 8
		jnz	short loc_221DE
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	ax, [si+2194h]
		mov	[si+217Ch], ax
		mov	byte ptr [si+21B0h], 1

loc_221DE:				; CODE XREF: sub_21FDC+1EBj
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 4
		cmp	al, 4
		jnz	short loc_22230
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	byte ptr [bx+21ACh], 0
		jnz	short loc_22226
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		cmp	word ptr [bx+21A6h], 0
		jnz	short loc_22226
		mov	ax, cx
		imul	[bp+arg_0]
		mov	si, ax
		mov	ax, [si+2196h]
		neg	ax
		jmp	short loc_221AE
; ---------------------------------------------------------------------------
		align 2

loc_22226:				; CODE XREF: sub_21FDC+1AEj
					; sub_21FDC+1C4j ...
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_21F98
		add	sp, 2

loc_22230:				; CODE XREF: sub_21FDC+107j
					; sub_21FDC+195j ...
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_21EF8
		add	sp, 2
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	ax, [si+217Ch]
		add	[si+2178h], ax
		mov	ax, [bp+var_2]
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_21FDC	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_22252	proc far		; CODE XREF: sub_17A66+DDP
					; sub_19F8C+DDP ...

var_8		= byte ptr -8
var_6		= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 8
		push	si
		mov	[bp+var_6], 0
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	word ptr [si+2186h], 0
		jz	short loc_22270
		jmp	loc_2230E
; ---------------------------------------------------------------------------

loc_22270:				; CODE XREF: sub_22252+19j
		mov	al, [si+21A9h]
		sub	ah, ah
		shl	ax, 1
		shl	ax, 1
		sub	ax, 8
		neg	ax
		mov	[bp+var_2], ax
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	ax, [bx+2514h]
		and	ax, [bp+var_2]
		cmp	ax, [bp+var_2]
		jz	short loc_22296
		jmp	loc_2243F
; ---------------------------------------------------------------------------

loc_22296:				; CODE XREF: sub_22252+3Fj
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	byte ptr [bx+21ACh], 0
		jnz	short loc_222C2
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		cmp	word ptr [bx+21A6h], 1
		jz	short loc_222C2
		jmp	loc_2243F
; ---------------------------------------------------------------------------

loc_222C2:				; CODE XREF: sub_22252+58j
					; sub_22252+6Bj
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		mov	al, [bx+21AAh]
		mov	[bp+var_8], al
		or	al, al
		jz	short loc_222E4
		cmp	al, 1
		jz	short loc_222E4
		cmp	al, 4
		jz	short loc_222E4
		cmp	al, 5
		jz	short loc_222E4
		jmp	loc_2243F
; ---------------------------------------------------------------------------

loc_222E4:				; CODE XREF: sub_22252+81j
					; sub_22252+85j ...
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 2
		cmp	al, 2
		jz	short loc_222F6
		jmp	loc_22428
; ---------------------------------------------------------------------------

loc_222F6:				; CODE XREF: sub_22252+9Fj
		mov	ax, 4Bh	; 'K'

loc_222F9:				; CODE XREF: sub_22252+1D3j
		imul	[bp+arg_0]
		mov	bx, ax
		mov	byte ptr [bx+21ADh], 4
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_21FBA
		jmp	loc_2243C
; ---------------------------------------------------------------------------
		align 2

loc_2230E:				; CODE XREF: sub_22252+1Bj
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		mov	ax, [bx+2178h]
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		cmp	[bx+21A2h], cx
		jle	short loc_22352
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	si, ax
		mov	ax, [si+21A2h]
		sub	ax, [bx+2178h]
		jmp	short loc_22370
; ---------------------------------------------------------------------------

loc_22352:				; CODE XREF: sub_22252+DDj
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, cx
		imul	[bp+arg_0]
		mov	si, ax
		mov	ax, [si+2178h]
		sub	ax, [bx+21A2h]

loc_22370:				; CODE XREF: sub_22252+FEj
		mov	[bp+var_4], ax
		call	sub_1525A
		sub	ah, ah
		and	ax, 7
		cmp	ax, word_2A9F4
		jb	short loc_22386
		jmp	loc_2243F
; ---------------------------------------------------------------------------

loc_22386:				; CODE XREF: sub_22252+12Fj
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	byte ptr [bx+21ACh], 0
		jnz	short loc_223B2
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		cmp	word ptr [bx+21A6h], 1
		jz	short loc_223B2
		jmp	loc_2243F
; ---------------------------------------------------------------------------

loc_223B2:				; CODE XREF: sub_22252+148j
					; sub_22252+15Bj
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		mov	al, [bx+21AAh]
		mov	[bp+var_8], al
		or	al, al
		jz	short loc_223D1
		cmp	al, 1
		jz	short loc_223D1
		cmp	al, 4
		jz	short loc_223D1
		cmp	al, 5
		jnz	short loc_2243F

loc_223D1:				; CODE XREF: sub_22252+171j
					; sub_22252+175j ...
		call	sub_1525A
		sub	ah, ah
		and	ax, 7
		mov	cx, word_2A9F4
		add	cx, 3
		cmp	ax, cx
		jnb	short loc_2243F
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	word ptr [bx+21A6h], 1
		jnz	short loc_22408
		cmp	[bp+var_4], 40h	; '@'
		jle	short loc_22408
		mov	ax, 1
		jmp	short loc_2240A
; ---------------------------------------------------------------------------
		align 2

loc_22408:				; CODE XREF: sub_22252+1A8j
					; sub_22252+1AEj
		sub	ax, ax

loc_2240A:				; CODE XREF: sub_22252+1B3j
		mov	[bp+var_6], ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	byte ptr [bx+21ACh], 2
		jnz	short loc_22428
		mov	ax, cx
		jmp	loc_222F9
; ---------------------------------------------------------------------------

loc_22428:				; CODE XREF: sub_22252+A1j
					; sub_22252+1CFj
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		mov	byte ptr [bx+21ADh], 4
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_21F98

loc_2243C:				; CODE XREF: sub_22252+B8j
		add	sp, 2

loc_2243F:				; CODE XREF: sub_22252+41j
					; sub_22252+6Dj ...
		mov	ax, [bp+var_6]
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_22252	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_22448	proc far		; CODE XREF: sub_22E62+49p
					; sub_22EBA+53p ...

var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 4
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	al, [si+21A9h]
		sub	ah, ah
		shl	ax, 1
		shl	ax, 1
		sub	ax, 8
		neg	ax
		mov	[bp+var_2], ax
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	ax, [bx+2514h]
		and	ax, [bp+var_2]
		cmp	ax, [bp+var_2]
		jnz	short loc_224E7
		cmp	word ptr [si+2186h], 0
		jnz	short loc_224E7
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	byte ptr [bx+21ACh], 0
		jnz	short loc_224AA
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		cmp	word ptr [bx+21A6h], 1
		jnz	short loc_224E7

loc_224AA:				; CODE XREF: sub_22448+4Dj
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 2
		cmp	al, 2
		jnz	short loc_224D0
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		mov	byte ptr [bx+21ADh], 4
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_21FBA
		jmp	short loc_224E4
; ---------------------------------------------------------------------------
		align 2

loc_224D0:				; CODE XREF: sub_22448+6Fj
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		mov	byte ptr [bx+21ADh], 4
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_21F98

loc_224E4:				; CODE XREF: sub_22448+85j
		add	sp, 2

loc_224E7:				; CODE XREF: sub_22448+30j
					; sub_22448+37j ...
		mov	ax, [bp+var_4]
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_22448	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_224F0	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+218Ah], 0
		mov	word ptr [si+218Ch], 0
		mov	byte ptr [si+21ACh], 0
		mov	byte ptr [si+21ABh], 0
		cmp	byte ptr [si+21ADh], 0
		jz	short loc_2251F
		jmp	loc_225F6
; ---------------------------------------------------------------------------

loc_2251F:				; CODE XREF: sub_224F0+2Aj
		mov	byte ptr [si+21B0h], 3
		inc	byte ptr [si+21AFh]
		mov	al, [si+21AFh]
		cmp	[si+21B0h], al
		jbe	short loc_22535
		jmp	loc_225DF
; ---------------------------------------------------------------------------

loc_22535:				; CODE XREF: sub_224F0+40j
		mov	byte ptr [si+21AFh], 0
		inc	byte ptr [si+21AEh]
		mov	al, [si+21B5h]
		cmp	[si+21AEh], al
		jnb	short loc_2254C
		mov	[si+21AEh], al

loc_2254C:				; CODE XREF: sub_224F0+56j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	al, [si+21B6h]
		cmp	[si+21AEh], al
		jbe	short loc_22566
		mov	al, [si+21B5h]
		mov	[si+21AEh], al

loc_22566:				; CODE XREF: sub_224F0+6Cj
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	al, [si+21B5h]
		cmp	[si+21AEh], al
		jnz	short loc_2257E
		mov	word ptr [si+217Ah], 9Eh ; '�'

loc_2257E:				; CODE XREF: sub_224F0+86j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	al, [si+21B5h]
		sub	ah, ah
		inc	ax
		mov	cl, [si+21AEh]
		sub	ch, ch
		cmp	ax, cx
		jnz	short loc_2259D
		mov	word ptr [si+217Ah], 9Dh ; '�'

loc_2259D:				; CODE XREF: sub_224F0+A5j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	al, [si+21B5h]
		sub	ah, ah
		add	ax, 2
		mov	cl, [si+21AEh]
		sub	ch, ch
		cmp	ax, cx
		jnz	short loc_225BE
		mov	word ptr [si+217Ah], 9Ch ; '�'

loc_225BE:				; CODE XREF: sub_224F0+C6j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	al, [si+21B5h]
		sub	ah, ah
		add	ax, 3
		mov	cl, [si+21AEh]
		sub	ch, ch
		cmp	ax, cx
		jnz	short loc_225DF
		mov	word ptr [si+217Ah], 9Dh ; '�'

loc_225DF:				; CODE XREF: sub_224F0+42j
					; sub_224F0+E7j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+217Ch], 0
		and	byte ptr [si+2178h], 0F8h
		jmp	loc_2272A
; ---------------------------------------------------------------------------
		align 2

loc_225F6:				; CODE XREF: sub_224F0+2Cj
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		inc	byte ptr [si+21AFh]
		mov	al, [si+21AFh]
		cmp	[si+21B0h], al
		ja	short loc_22615
		mov	byte ptr [si+21AFh], 0
		inc	byte ptr [si+21AEh]

loc_22615:				; CODE XREF: sub_224F0+11Aj
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	al, [si+21B3h]
		cmp	[si+21AEh], al
		jnb	short loc_2262B
		mov	[si+21AEh], al

loc_2262B:				; CODE XREF: sub_224F0+135j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	al, [si+21B4h]
		cmp	[si+21AEh], al
		jbe	short loc_22645
		mov	al, [si+21B3h]
		mov	[si+21AEh], al

loc_22645:				; CODE XREF: sub_224F0+14Bj
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	byte ptr [si+21A9h], 0
		jnz	short loc_226B4
		cmp	byte ptr [si+21ADh], 1
		jnz	short loc_2266A
		mov	ax, [si+2194h]
		neg	ax
		mov	[si+217Ch], ax
		mov	byte ptr [si+21B0h], 1

loc_2266A:				; CODE XREF: sub_224F0+169j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	byte ptr [si+21ADh], 2
		jz	short loc_2267C
		jmp	loc_2272A
; ---------------------------------------------------------------------------

loc_2267C:				; CODE XREF: sub_224F0+187j
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	byte ptr [bx+21ACh], 0
		jnz	short loc_22710
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		cmp	word ptr [bx+21A6h], 0
		jnz	short loc_22710
		mov	ax, [si+2196h]

loc_226A9:				; CODE XREF: sub_224F0+21Ej
		mov	[si+217Ch], ax
		mov	byte ptr [si+21B0h], 3
		jmp	short loc_2272A
; ---------------------------------------------------------------------------

loc_226B4:				; CODE XREF: sub_224F0+162j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	byte ptr [si+21ADh], 1
		jnz	short loc_226D0
		mov	ax, [si+2194h]
		mov	[si+217Ch], ax
		mov	byte ptr [si+21B0h], 1

loc_226D0:				; CODE XREF: sub_224F0+1D1j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	byte ptr [si+21ADh], 2
		jnz	short loc_2272A
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	byte ptr [bx+21ACh], 0
		jnz	short loc_22710
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		cmp	word ptr [bx+21A6h], 0
		jnz	short loc_22710
		mov	ax, [si+2196h]
		neg	ax
		jmp	short loc_226A9
; ---------------------------------------------------------------------------

loc_22710:				; CODE XREF: sub_224F0+1A0j
					; sub_224F0+1B3j ...
		call	sub_1525A
		sub	ah, ah
		and	ax, 7
		cmp	ax, word_2A9F4
		jnb	short loc_2272A
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_21F98
		add	sp, 2

loc_2272A:				; CODE XREF: sub_224F0+102j
					; sub_224F0+189j ...
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_21EF8
		add	sp, 2
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	ax, [si+217Ch]
		add	[si+2178h], ax
		mov	ax, [bp+var_2]
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_224F0	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_2274C	proc far		; CODE XREF: sub_188EE+1AEP
					; sub_188EE+27BP ...

var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	si
		mov	[bp+var_2], 0
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	ax, [si+2190h]
		add	[si+217Eh], ax
		mov	ax, [si+217Ch]
		add	[si+2178h], ax
		mov	ax, [si+217Eh]
		cwd
		mov	cx, [si+2192h]
		idiv	cx
		add	[si+217Ah], ax
		cmp	word ptr [si+217Ah], 9Eh ; '�'
		jle	short loc_22792
		mov	[bp+var_2], 1
		mov	word ptr [si+217Ah], 9Eh ; '�'

loc_22792:				; CODE XREF: sub_2274C+39j
		mov	ax, [bp+var_2]
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_2274C	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_2279A	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21ABh], 2
		mov	byte ptr [si+21ACh], 0
		inc	byte ptr [si+21AFh]
		mov	al, [si+21AFh]
		cmp	[si+21B0h], al
		ja	short loc_227CA
		mov	byte ptr [si+21AFh], 0
		inc	byte ptr [si+21AEh]

loc_227CA:				; CODE XREF: sub_2279A+25j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	al, [si+21B2h]
		cmp	[si+21AEh], al
		jbe	short loc_227E0
		mov	[si+21AEh], al

loc_227E0:				; CODE XREF: sub_2279A+40j
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_2274C
		add	sp, 2
		cmp	ax, 1
		jnz	short loc_22863
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [bx+2178h]
		mov	cl, 3
		sar	ax, cl
		mov	dx, [si+2178h]
		sar	dx, cl
		cmp	ax, dx
		jz	short loc_2283C
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [si+2178h]
		cmp	[bx+2178h], ax
		jge	short loc_22836
		sub	al, al
		jmp	short loc_22838
; ---------------------------------------------------------------------------
		align 2

loc_22836:				; CODE XREF: sub_2279A+95j
		mov	al, 1

loc_22838:				; CODE XREF: sub_2279A+99j
		mov	[si+21A9h], al

loc_2283C:				; CODE XREF: sub_2279A+7Cj
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	al, [si+21B5h]
		mov	[si+21B1h], al
		mov	[si+21B2h], al
		mov	byte ptr [si+21B0h], 1
		mov	byte ptr [si+21AFh], 0
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 0Ch

loc_22863:				; CODE XREF: sub_2279A+53j
		mov	ax, [bp+var_2]
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_2279A	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_2286C	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_2279A
		add	sp, 2
		pop	bp
		retf
sub_2286C	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_2287C	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21ABh], 1
		mov	byte ptr [si+21ACh], 0
		mov	word ptr [si+218Ah], 0
		mov	word ptr [si+218Ch], 0
		mov	al, [si+21B7h]
		mov	[si+21AEh], al
		mov	bx, [bp+arg_0]
		shl	bx, 1
		test	byte ptr [bx+2514h], 2
		jnz	short loc_228BF
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_21F4C
		add	sp, 2

loc_228BF:				; CODE XREF: sub_2287C+37j
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_21EF8
		add	sp, 2
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	byte ptr [bx+21A9h], 0
		jnz	short loc_228E8
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 8
		cmp	al, 8
		jmp	short loc_228F5
; ---------------------------------------------------------------------------
		align 2

loc_228E8:				; CODE XREF: sub_2287C+5Aj
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 4
		cmp	al, 4

loc_228F5:				; CODE XREF: sub_2287C+69j
		jnz	short loc_2292A
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	byte ptr [bx+21ACh], 0
		jnz	short loc_22920
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		cmp	word ptr [bx+21A6h], 1
		jnz	short loc_2292A

loc_22920:				; CODE XREF: sub_2287C+8Fj
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_21FBA
		add	sp, 2

loc_2292A:				; CODE XREF: sub_2287C:loc_228F5j
					; sub_2287C+A2j
		mov	ax, [bp+var_2]
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_2287C	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_22932	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21ABh], 1
		mov	byte ptr [si+21ACh], 0
		mov	word ptr [si+218Ah], 0
		mov	word ptr [si+218Ch], 0
		mov	al, [si+21B7h]
		mov	[si+21AEh], al
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_21F4C
		add	sp, 2
		mov	ax, [bp+var_2]
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_22932	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_22972	proc far		; CODE XREF: sub_22A90+30p
					; sub_22B5A+30p ...

var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	di
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		mov	si, [bx+2178h]
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	[bx+2178h], si
		jle	short loc_229AE
		mov	ax, cx
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		jmp	short loc_229C2
; ---------------------------------------------------------------------------

loc_229AE:				; CODE XREF: sub_22972+27j
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, cx
		imul	[bp+arg_0]

loc_229C2:				; CODE XREF: sub_22972+3Aj
		mov	di, ax
		mov	ax, [di+2178h]
		sub	ax, [bx+2178h]
		mov	[bp+var_2], ax
		mov	ax, si
		mov	cl, 3
		sar	ax, cl
		cmp	ax, 4
		jg	short loc_22A02
		cmp	[bp+var_2], 40h	; '@'
		jge	short loc_229F4
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		add	word ptr [bx+2178h], 8

loc_229F4:				; CODE XREF: sub_22972+6Cj
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		mov	word ptr [bx+2178h], 20h ; ' '

loc_22A02:				; CODE XREF: sub_22972+66j
		cmp	word_2A9E8, 6
		jnz	short loc_22A4C
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		mov	ax, [bx+2178h]
		mov	cl, 3
		sar	ax, cl
		cmp	ax, 24h	; '$'
		jl	short loc_22A89
		cmp	[bp+var_2], 40h	; '@'
		jge	short loc_22A38
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		sub	word ptr [bx+2178h], 8

loc_22A38:				; CODE XREF: sub_22972+B0j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		mov	word ptr [bx+2178h], 120h
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
; ---------------------------------------------------------------------------

loc_22A4C:				; CODE XREF: sub_22972+95j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		mov	ax, [bx+2178h]
		mov	cl, 3
		sar	ax, cl
		cmp	ax, 4Ch	; 'L'
		jl	short loc_22A89
		cmp	[bp+var_2], 40h	; '@'
		jge	short loc_22A7B
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		sub	word ptr [bx+2178h], 8

loc_22A7B:				; CODE XREF: sub_22972+F3j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		mov	word ptr [bx+2178h], 260h

loc_22A89:				; CODE XREF: sub_22972+AAj
					; sub_22972+EDj
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_22972	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_22A90	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21ABh], 0
		mov	byte ptr [si+21ACh], 0
		cmp	byte ptr [si+21ADh], 0
		jz	short loc_22AC6
		dec	byte ptr [si+21ADh]
		mov	ax, [si+217Ch]
		add	[si+2178h], ax
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_22972
		add	sp, 2

loc_22AC6:				; CODE XREF: sub_22A90+1Ej
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	al, [si+21BAh]
		mov	[si+21AEh], al
		cmp	byte ptr [si+21A9h], 0
		jnz	short loc_22AEA
		mov	bx, [bp+arg_0]
		shl	bx, 1
		test	byte ptr [bx+2514h], 8
		jmp	short loc_22AF4
; ---------------------------------------------------------------------------
		align 2

loc_22AEA:				; CODE XREF: sub_22A90+4Bj
		mov	bx, [bp+arg_0]
		shl	bx, 1
		test	byte ptr [bx+2514h], 4

loc_22AF4:				; CODE XREF: sub_22A90+57j
		jz	short loc_22B1F
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	byte ptr [bx+21ACh], 0
		jnz	short loc_22B38
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		cmp	word ptr [bx+21A6h], 0
		jnz	short loc_22B38

loc_22B1F:				; CODE XREF: sub_22A90:loc_22AF4j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	byte ptr [bx+21ADh], 0
		jnz	short loc_22B38
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_21F4C
		add	sp, 2

loc_22B38:				; CODE XREF: sub_22A90+7Aj
					; sub_22A90+8Dj ...
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		and	al, 2
		cmp	al, 2
		jnz	short loc_22B51
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_21FBA
		add	sp, 2

loc_22B51:				; CODE XREF: sub_22A90+B5j
		mov	ax, [bp+var_2]
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_22A90	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_22B5A	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_4		= byte ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 4
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21ABh], 1
		mov	byte ptr [si+21ACh], 0
		cmp	byte ptr [si+21ADh], 0
		jz	short loc_22B90
		dec	byte ptr [si+21ADh]
		mov	ax, [si+217Ch]
		add	[si+2178h], ax
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_22972
		add	sp, 2

loc_22B90:				; CODE XREF: sub_22B5A+1Ej
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	al, [si+21BBh]
		mov	[si+21AEh], al
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	al, [bx+2514h]
		mov	[bp+var_4], al
		test	[bp+var_4], 2
		jnz	short loc_22C24
		cmp	byte ptr [si+21A9h], 0
		jnz	short loc_22C18
		test	[bp+var_4], 8

loc_22BBD:				; CODE XREF: sub_22B5A+C8j
		jz	short loc_22BE8
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	byte ptr [bx+21ACh], 0
		jnz	short loc_22C00
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		cmp	word ptr [bx+21A6h], 0
		jnz	short loc_22C00

loc_22BE8:				; CODE XREF: sub_22B5A:loc_22BBDj
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	byte ptr [bx+21ADh], 0
		jnz	short loc_22C00
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_21F4C
		jmp	short loc_22C7C
; ---------------------------------------------------------------------------

loc_22C00:				; CODE XREF: sub_22B5A+79j
					; sub_22B5A+8Cj ...
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21AAh], 4
		mov	al, [si+21BAh]
		mov	[si+21AEh], al
		jmp	short loc_22C7F
; ---------------------------------------------------------------------------
		align 2

loc_22C18:				; CODE XREF: sub_22B5A+5Dj
		mov	bx, [bp+arg_0]
		shl	bx, 1
		test	byte ptr [bx+2514h], 4
		jmp	short loc_22BBD
; ---------------------------------------------------------------------------

loc_22C24:				; CODE XREF: sub_22B5A+56j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	byte ptr [bx+21A9h], 0
		jnz	short loc_22C40
		mov	bx, [bp+arg_0]
		shl	bx, 1
		test	byte ptr [bx+2514h], 8
		jmp	short loc_22C4A
; ---------------------------------------------------------------------------
		align 2

loc_22C40:				; CODE XREF: sub_22B5A+D7j
		mov	bx, [bp+arg_0]
		shl	bx, 1
		test	byte ptr [bx+2514h], 4

loc_22C4A:				; CODE XREF: sub_22B5A+E3j
		jz	short loc_22C75
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	byte ptr [bx+21ACh], 0
		jnz	short loc_22C7F
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		cmp	word ptr [bx+21A6h], 0
		jnz	short loc_22C7F

loc_22C75:				; CODE XREF: sub_22B5A:loc_22C4Aj
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_21F72

loc_22C7C:				; CODE XREF: sub_22B5A+A4j
		add	sp, 2

loc_22C7F:				; CODE XREF: sub_22B5A+BBj
					; sub_22B5A+106j ...
		mov	ax, [bp+var_2]
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_22B5A	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_22C88	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21ABh], 0
		mov	byte ptr [si+21ACh], 0
		cmp	byte ptr [si+21ADh], 0
		jz	short loc_22CBE
		dec	byte ptr [si+21ADh]
		mov	ax, [si+217Ch]
		add	[si+2178h], ax
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_22972
		add	sp, 2

loc_22CBE:				; CODE XREF: sub_22C88+1Ej
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	al, [si+21BAh]
		mov	[si+21AEh], al
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	byte ptr [bx+21ACh], 1
		jnz	short loc_22CFE
		call	sub_1525A
		sub	ah, ah
		and	ax, 7
		cmp	ax, word_2A9F4
		jnb	short loc_22CFE
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_21FBA
		add	sp, 2

loc_22CFE:				; CODE XREF: sub_22C88+5Aj
					; sub_22C88+6Aj
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		mov	al, [bx+21A9h]
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		cmp	[bx+21A9h], cl
		jz	short loc_22D4A
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	byte ptr [bx+21ACh], 0
		jnz	short loc_22D63
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		cmp	word ptr [bx+21A6h], 0
		jnz	short loc_22D63

loc_22D4A:				; CODE XREF: sub_22C88+97j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	byte ptr [bx+21ADh], 0
		jnz	short loc_22D63
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_21F4C
		add	sp, 2

loc_22D63:				; CODE XREF: sub_22C88+ADj
					; sub_22C88+C0j ...
		mov	ax, [bp+var_2]
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_22C88	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_22D6C	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21ABh], 1
		mov	byte ptr [si+21ACh], 0
		cmp	byte ptr [si+21ADh], 0
		jz	short loc_22DA2
		dec	byte ptr [si+21ADh]
		mov	ax, [si+217Ch]
		add	[si+2178h], ax
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_22972
		add	sp, 2

loc_22DA2:				; CODE XREF: sub_22D6C+1Ej
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	al, [si+21BBh]
		mov	[si+21AEh], al
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	byte ptr [bx+21ACh], 1
		jz	short loc_22DF5
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		cmp	byte ptr [bx+21ACh], 0
		jz	short loc_22DF5
		call	sub_1525A
		sub	ah, ah
		and	ax, 7
		cmp	ax, word_2A9F4
		jnb	short loc_22DF5
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_21F98
		add	sp, 2

loc_22DF5:				; CODE XREF: sub_22D6C+5Aj
					; sub_22D6C+6Dj ...
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		mov	al, [bx+21A9h]
		mov	cx, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	bx, 4Bh	; 'K'
		imul	bx
		mov	bx, ax
		cmp	[bx+21A9h], cl
		jz	short loc_22E41
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	byte ptr [bx+21ACh], 0
		jnz	short loc_22E5A
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		cmp	word ptr [bx+21A6h], 0
		jnz	short loc_22E5A

loc_22E41:				; CODE XREF: sub_22D6C+AAj
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	byte ptr [bx+21ADh], 0
		jnz	short loc_22E5A
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_21F4C
		add	sp, 2

loc_22E5A:				; CODE XREF: sub_22D6C+C0j
					; sub_22D6C+D3j ...
		mov	ax, [bp+var_2]
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_22D6C	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_22E62	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21ABh], 4
		mov	byte ptr [si+21ACh], 0
		cmp	byte ptr [si+21A9h], 1
		jnz	short loc_22E88
		mov	ax, 0FFF8h
		jmp	short loc_22E8B
; ---------------------------------------------------------------------------
		align 2

loc_22E88:				; CODE XREF: sub_22E62+1Ej
		mov	ax, 8

loc_22E8B:				; CODE XREF: sub_22E62+23j
		add	[si+2178h], ax
		mov	al, [si+21BCh]
		mov	[si+21AEh], al
		dec	byte ptr [si+21ADh]
		jnz	short loc_22EB1
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_21F4C
		add	sp, 2
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_22448
		add	sp, 2

loc_22EB1:				; CODE XREF: sub_22E62+39j
		mov	ax, [bp+var_2]
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_22E62	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_22EBA	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21ABh], 4
		mov	byte ptr [si+21ACh], 0
		cmp	byte ptr [si+21A9h], 1
		jnz	short loc_22EE0
		mov	ax, 0FFF8h
		jmp	short loc_22EE3
; ---------------------------------------------------------------------------
		align 2

loc_22EE0:				; CODE XREF: sub_22EBA+1Ej
		mov	ax, 8

loc_22EE3:				; CODE XREF: sub_22EBA+23j
		add	[si+2178h], ax
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_22972
		add	sp, 2
		mov	al, [si+21BDh]
		mov	[si+21AEh], al
		dec	byte ptr [si+21ADh]
		jnz	short loc_22F13
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_21F4C
		add	sp, 2
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_22448
		add	sp, 2

loc_22F13:				; CODE XREF: sub_22EBA+43j
		mov	ax, [bp+var_2]
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_22EBA	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_22F1C	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21ABh], 4
		mov	byte ptr [si+21ACh], 0
		cmp	byte ptr [si+21A9h], 1
		jnz	short loc_22F42
		mov	ax, 0FFF8h
		jmp	short loc_22F45
; ---------------------------------------------------------------------------
		align 2

loc_22F42:				; CODE XREF: sub_22F1C+1Ej
		mov	ax, 8

loc_22F45:				; CODE XREF: sub_22F1C+23j
		add	[si+2178h], ax
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_22972
		add	sp, 2
		mov	al, [si+21BEh]
		mov	[si+21AEh], al
		dec	byte ptr [si+21ADh]
		jnz	short loc_22F75
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_21F4C
		add	sp, 2
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_22448
		add	sp, 2

loc_22F75:				; CODE XREF: sub_22F1C+43j
		mov	ax, [bp+var_2]
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_22F1C	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_22F7E	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21ABh], 4
		mov	byte ptr [si+21ACh], 0
		inc	byte ptr [si+21AFh]
		mov	al, [si+21AFh]
		cmp	[si+21B0h], al
		ja	short loc_22FAE
		mov	byte ptr [si+21AFh], 0
		inc	byte ptr [si+21AEh]

loc_22FAE:				; CODE XREF: sub_22F7E+25j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	al, [si+21C0h]
		cmp	[si+21AEh], al
		jbe	short loc_22FC4
		mov	[si+21AEh], al

loc_22FC4:				; CODE XREF: sub_22F7E+40j
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_2274C
		add	sp, 2
		cmp	ax, 1
		jz	short loc_22FD6
		jmp	loc_23064
; ---------------------------------------------------------------------------

loc_22FD6:				; CODE XREF: sub_22F7E+53j
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_21EF8
		add	sp, 2
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	al, [si+21C0h]
		inc	al
		mov	[si+21AEh], al
		mov	ax, [si+218Eh]
		cwd
		mov	cx, 3
		idiv	cx
		mov	[si+217Eh], ax
		mov	byte ptr [si+21AAh], 0Bh
		mov	word_2D014, 4
		cmp	word ptr [si+218Ch], 0
		jle	short loc_23043
		mov	word_2D392, 4
		cmp	[bp+arg_0], 1
		sbb	bx, bx
		neg	bx
		shl	bx, 1
		mov	ax, [bx+2A2Ch]
		inc	ax
		imul	word ptr [si+218Ch]
		cwd
		xor	ax, dx
		sub	ax, dx
		mov	cx, 2
		sar	ax, cl
		xor	ax, dx
		sub	ax, dx
		sub	[si+2180h], ax
		mov	word ptr [si+218Ch], 0

loc_23043:				; CODE XREF: sub_22F7E+92j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	word ptr [bx+2180h], 0
		jg	short loc_23058
		mov	word_2D014, 0Ah

loc_23058:				; CODE XREF: sub_22F7E+D2j
		mov	ax, 3
		push	ax
		call	sub_15BEE
		add	sp, 2

loc_23064:				; CODE XREF: sub_22F7E+55j
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_22972
		add	sp, 2
		mov	ax, [bp+var_2]
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_22F7E	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_23076	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21ABh], 4
		mov	byte ptr [si+21ACh], 0
		inc	byte ptr [si+21AFh]
		mov	al, [si+21AFh]
		cmp	[si+21B0h], al
		ja	short loc_230A6
		mov	byte ptr [si+21AFh], 0
		inc	byte ptr [si+21AEh]

loc_230A6:				; CODE XREF: sub_23076+25j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	al, [si+21C0h]
		sub	ah, ah
		dec	ax
		mov	cl, [si+21AEh]
		sub	ch, ch
		cmp	ax, cx
		jnb	short loc_230C9
		mov	al, [si+21C0h]
		dec	al
		mov	[si+21AEh], al

loc_230C9:				; CODE XREF: sub_23076+47j
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_2274C
		add	sp, 2
		cmp	ax, 1
		jnz	short loc_230EC
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_21F4C
		add	sp, 2
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_22448
		add	sp, 2

loc_230EC:				; CODE XREF: sub_23076+60j
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_22972
		add	sp, 2
		mov	ax, [bp+var_2]
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_23076	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_230FE	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21ABh], 4
		mov	byte ptr [si+21ACh], 0
		mov	al, [si+21C1h]
		mov	[si+21AEh], al
		dec	byte ptr [si+21ADh]
		jnz	short loc_23141
		mov	byte ptr [si+21ADh], 2
		mov	byte ptr [si+21AAh], 11h
		mov	al, [si+21C2h]
		mov	[si+21AEh], al
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_22448
		add	sp, 2

loc_23141:				; CODE XREF: sub_230FE+25j
		mov	ax, [bp+var_2]
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_230FE	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_2314A	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21ABh], 4
		mov	byte ptr [si+21ACh], 0
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_2274C
		add	sp, 2
		cmp	ax, 1
		jnz	short loc_2319A
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_21EF8
		add	sp, 2
		mov	al, [si+21C1h]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 0Ah
		cmp	word ptr [si+2180h], 0
		jg	short loc_23194
		mov	al, 0E8h ; '�'
		jmp	short loc_23196
; ---------------------------------------------------------------------------

loc_23194:				; CODE XREF: sub_2314A+44j
		mov	al, 4

loc_23196:				; CODE XREF: sub_2314A+48j
		mov	[si+21ADh], al

loc_2319A:				; CODE XREF: sub_2314A+26j
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_22972
		add	sp, 2
		mov	ax, [bp+var_2]
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_2314A	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_231AC	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		mov	ax, [bp+arg_0]
		pop	bp
		retf
sub_231AC	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_231B4	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		mov	ax, [bp+arg_0]
		pop	bp
		retf
sub_231B4	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_231BC	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21ABh], 0
		inc	byte ptr [si+21AFh]
		mov	al, [si+21AFh]
		cmp	[si+21B0h], al
		ja	short loc_231E7
		mov	byte ptr [si+21AFh], 0
		inc	byte ptr [si+21AEh]

loc_231E7:				; CODE XREF: sub_231BC+20j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	al, [si+21B2h]
		cmp	[si+21AEh], al
		jbe	short loc_2320D
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_21F4C
		add	sp, 2
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_22448
		add	sp, 2

loc_2320D:				; CODE XREF: sub_231BC+3Bj
		mov	ax, [bp+var_2]
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_231BC	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_23216	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21ABh], 1
		inc	byte ptr [si+21AFh]
		mov	al, [si+21AFh]
		cmp	[si+21B0h], al
		ja	short loc_23241
		mov	byte ptr [si+21AFh], 0
		inc	byte ptr [si+21AEh]

loc_23241:				; CODE XREF: sub_23216+20j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	al, [si+21B2h]
		cmp	[si+21AEh], al
		jbe	short loc_23267
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_21F72
		add	sp, 2
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_22448
		add	sp, 2

loc_23267:				; CODE XREF: sub_23216+3Bj
		mov	ax, [bp+var_2]
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_23216	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_23270	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21ABh], 2
		inc	byte ptr [si+21AFh]
		dec	byte ptr [si+21ADh]
		mov	al, [si+21AFh]
		cmp	[si+21B0h], al
		ja	short loc_232A9
		mov	byte ptr [si+21AFh], 0
		mov	al, [si+21B2h]
		cmp	[si+21AEh], al
		jnb	short loc_232A9
		inc	byte ptr [si+21AEh]

loc_232A9:				; CODE XREF: sub_23270+24j
					; sub_23270+33j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	byte ptr [si+21ADh], 0
		jz	short loc_232BF
		cmp	word ptr [si+2188h], 0
		jz	short loc_232E0

loc_232BF:				; CODE XREF: sub_23270+46j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	al, [si+21B8h]
		mov	[si+21B1h], al
		mov	al, [si+21B9h]
		mov	[si+21B2h], al
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 0Dh

loc_232E0:				; CODE XREF: sub_23270+4Dj
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_2274C
		add	sp, 2
		cmp	ax, 1
		jnz	short loc_2332A
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_21EF8
		add	sp, 2
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	al, [si+21B5h]
		mov	[si+21B1h], al
		mov	[si+21B2h], al
		mov	byte ptr [si+21B0h], 1
		mov	byte ptr [si+21AFh], 0
		mov	[si+21AEh], al
		mov	byte ptr [si+21AAh], 0Ch
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_22448
		add	sp, 2

loc_2332A:				; CODE XREF: sub_23270+7Dj
		mov	ax, [bp+var_2]
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_23270	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_23332	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_23270
		add	sp, 2
		pop	bp
		retf
sub_23332	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_23342	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+217Ch], 0
		mov	byte ptr [si+21ABh], 0
		inc	byte ptr [si+21AFh]
		mov	al, [si+21AFh]
		cmp	[si+21B0h], al
		ja	short loc_23373
		mov	byte ptr [si+21AFh], 0
		inc	byte ptr [si+21AEh]

loc_23373:				; CODE XREF: sub_23342+26j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	al, [si+21B2h]
		cmp	[si+21AEh], al
		jbe	short loc_2339E
		dec	byte ptr [si+21ADh]
		mov	al, [si+21B1h]
		mov	[si+21AEh], al
		cmp	byte ptr [si+21ADh], 0
		jnz	short loc_2339E
		mov	word_2A9E4, 2

loc_2339E:				; CODE XREF: sub_23342+41j
					; sub_23342+54j
		mov	ax, [bp+var_2]
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_23342	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_233A6	proc far		; CODE XREF: sub_180FE+175P
					; sub_1A626+175P ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_236F4
		add	sp, 2
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	byte ptr [bx+21A8h], 0
		jz	short loc_233CD
		jmp	loc_23670
; ---------------------------------------------------------------------------

loc_233CD:				; CODE XREF: sub_233A6+22j
		mov	ax, cx
		imul	[bp+arg_0]
		mov	si, ax
		cmp	byte ptr [si+21A8h], 0
		jz	short loc_233DE
		jmp	loc_23670
; ---------------------------------------------------------------------------

loc_233DE:				; CODE XREF: sub_233A6+33j
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	ax, [bx+2178h]
		add	ax, 10h
		cmp	ax, [si+2178h]
		jg	short loc_233FA
		jmp	loc_23670
; ---------------------------------------------------------------------------

loc_233FA:				; CODE XREF: sub_233A6+4Fj
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	ax, [bx+2178h]
		sub	ax, 10h
		cmp	ax, [si+2178h]
		jl	short loc_23416
		jmp	loc_23670
; ---------------------------------------------------------------------------

loc_23416:				; CODE XREF: sub_233A6+6Bj
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	ax, [bx+217Ah]
		add	ax, 40h	; '@'
		cmp	ax, [si+217Ah]
		jg	short loc_23432
		jmp	loc_23670
; ---------------------------------------------------------------------------

loc_23432:				; CODE XREF: sub_233A6+87j
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	ax, [bx+217Ah]
		sub	ax, 40h	; '@'
		cmp	ax, [si+217Ah]
		jl	short loc_2344E
		jmp	loc_23670
; ---------------------------------------------------------------------------

loc_2344E:				; CODE XREF: sub_233A6+A3j
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	ax, [bx+2178h]
		mov	cl, 3
		sar	ax, cl
		mov	dx, [si+2178h]
		sar	dx, cl
		cmp	ax, dx
		jle	short loc_234B8
		cmp	word_2A9E8, 6
		jz	short loc_23476
		jmp	loc_23514
; ---------------------------------------------------------------------------

loc_23476:				; CODE XREF: sub_233A6+CBj
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [bx+2178h]
		add	ax, [si+2194h]
		cmp	ax, 120h
		jg	short loc_234A8
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	ax, [si+2194h]
		add	[bx+2178h], ax
		jmp	short loc_234B8
; ---------------------------------------------------------------------------

loc_234A8:				; CODE XREF: sub_233A6+EAj
					; sub_233A6+194j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	ax, [si+2194h]
		sub	[si+2178h], ax

loc_234B8:				; CODE XREF: sub_233A6+C4j
					; sub_233A6+100j ...
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [bx+2178h]
		mov	cl, 3
		sar	ax, cl
		mov	dx, [si+2178h]
		sar	dx, cl
		cmp	ax, dx
		jge	short loc_23560
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [bx+2178h]
		sub	ax, [si+2194h]
		cmp	ax, 20h	; ' '
		jl	short loc_23550
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	ax, [si+2194h]
		sub	[bx+2178h], ax
		jmp	short loc_23560
; ---------------------------------------------------------------------------
		align 2

loc_23514:				; CODE XREF: sub_233A6+CDj
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		mov	si, [bx+2194h]
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [bx+2178h]
		add	ax, si
		cmp	ax, 260h
		jle	short loc_2353D
		jmp	loc_234A8
; ---------------------------------------------------------------------------

loc_2353D:				; CODE XREF: sub_233A6+192j
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		add	[bx+2178h], si
		jmp	loc_234B8
; ---------------------------------------------------------------------------

loc_23550:				; CODE XREF: sub_233A6+155j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	ax, [si+2194h]
		add	[si+2178h], ax

loc_23560:				; CODE XREF: sub_233A6+139j
					; sub_233A6+16Bj
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [bx+2178h]
		mov	cl, 3
		sar	ax, cl
		mov	dx, [si+2178h]
		sar	dx, cl
		cmp	ax, dx
		jz	short loc_2358C
		jmp	loc_23670
; ---------------------------------------------------------------------------

loc_2358C:				; CODE XREF: sub_233A6+1E1j
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	byte ptr [bx+21A9h], 0
		jz	short loc_235A5
		jmp	loc_23628
; ---------------------------------------------------------------------------

loc_235A5:				; CODE XREF: sub_233A6+1FAj
		cmp	word_2A9E8, 6
		jnz	short loc_235F0
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	ax, [bx+2178h]
		add	ax, [si+2194h]
		cmp	ax, 120h
		jg	short loc_235DC
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	ax, [si+2194h]
		add	[bx+2178h], ax
		jmp	loc_23670
; ---------------------------------------------------------------------------

loc_235DC:				; CODE XREF: sub_233A6+21Dj
					; sub_233A6+26Ej
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	ax, [si+2194h]
		sub	[si+2178h], ax
		jmp	loc_23670
; ---------------------------------------------------------------------------
		align 2

loc_235F0:				; CODE XREF: sub_233A6+204j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		mov	si, [bx+2194h]
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [bx+2178h]
		add	ax, si
		cmp	ax, 260h
		jg	short loc_235DC
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		add	[bx+2178h], si
		jmp	short loc_23670
; ---------------------------------------------------------------------------

loc_23628:				; CODE XREF: sub_233A6+1FCj
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		mov	si, [bx+2194h]
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [bx+2178h]
		sub	ax, si
		cmp	ax, 20h	; ' '
		jl	short loc_23660
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		sub	[bx+2178h], si
		jmp	short loc_23670
; ---------------------------------------------------------------------------

loc_23660:				; CODE XREF: sub_233A6+2A6j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	ax, [si+2194h]
		add	[si+2178h], ax

loc_23670:				; CODE XREF: sub_233A6+24j
					; sub_233A6+35j ...
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		add	si, 2178h
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [bx+2178h]
		add	ax, 108h
		cmp	ax, [si]
		jge	short loc_236AB
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	ax, [bx+2178h]
		add	ax, 108h
		mov	[si], ax

loc_236AB:				; CODE XREF: sub_233A6+2EEj
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		add	si, 2178h
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [bx+2178h]
		sub	ax, 108h
		cmp	ax, [si]
		jle	short loc_236E6
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	ax, [bx+2178h]
		sub	ax, 108h
		mov	[si], ax

loc_236E6:				; CODE XREF: sub_233A6+329j
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_236F4
		add	sp, 2
		pop	si
		pop	bp
		retf
sub_233A6	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_236F4	proc far		; CODE XREF: sub_233A6+8p
					; sub_233A6+344p

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		cmp	word_2A9E8, 6
		jnz	short loc_23702
		jmp	loc_23840
; ---------------------------------------------------------------------------

loc_23702:				; CODE XREF: sub_236F4+9j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		mov	si, [bx+2178h]
		mov	cl, 3
		sar	si, cl
		mov	ax, word_2A9DC
		add	ax, 4
		cmp	ax, si
		jle	short loc_23722
		lea	ax, [si-4]
		mov	word_2A9DC, ax

loc_23722:				; CODE XREF: sub_236F4+26j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		mov	si, [bx+2178h]
		mov	cl, 3
		sar	si, cl
		mov	ax, word_2A9DC
		add	ax, 24h	; '$'
		cmp	ax, si
		jge	short loc_23742
		lea	ax, [si-24h]
		mov	word_2A9DC, ax

loc_23742:				; CODE XREF: sub_236F4+46j
		cmp	word_2A9DC, 0
		jge	short loc_2375D
		mov	word_2A9DC, 0
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		mov	word ptr [bx+2178h], 20h ; ' '

loc_2375D:				; CODE XREF: sub_236F4+53j
		cmp	word_2A9DC, 28h	; '('
		jle	short loc_23778
		mov	word_2A9DC, 28h	; '('
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		mov	word ptr [bx+2178h], 260h

loc_23778:				; CODE XREF: sub_236F4+6Ej
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [bx+2178h]
		mov	cl, 3
		sar	ax, cl
		mov	cx, word_2A9DC
		add	cx, 4
		cmp	ax, cx
		jge	short loc_237B7
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [bx+2178h]
		mov	cl, 3
		sar	ax, cl
		sub	ax, 4
		mov	word_2A9DC, ax

loc_237B7:				; CODE XREF: sub_236F4+A4j
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [bx+2178h]
		mov	cl, 3
		sar	ax, cl
		mov	cx, word_2A9DC
		add	cx, 24h	; '$'
		cmp	ax, cx
		jle	short loc_237F6
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [bx+2178h]
		mov	cl, 3
		sar	ax, cl
		sub	ax, 24h	; '$'
		mov	word_2A9DC, ax

loc_237F6:				; CODE XREF: sub_236F4+E3j
		cmp	word_2A9DC, 0
		jge	short loc_23818
		mov	word_2A9DC, 0
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	word ptr [bx+2178h], 20h ; ' '

loc_23818:				; CODE XREF: sub_236F4+107j
		cmp	word_2A9DC, 28h	; '('
		jg	short loc_23822
		jmp	loc_238DE
; ---------------------------------------------------------------------------

loc_23822:				; CODE XREF: sub_236F4+129j
		mov	word_2A9DC, 28h	; '('
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	word ptr [bx+2178h], 260h
		pop	si
		pop	bp
		retf
; ---------------------------------------------------------------------------

loc_23840:				; CODE XREF: sub_236F4+Bj
		mov	word_2A9DC, 0
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		add	si, 2178h
		mov	ax, [si]
		mov	cl, 3
		sar	ax, cl
		cmp	ax, 4
		jge	short loc_23861
		mov	word ptr [si], 20h ; ' '

loc_23861:				; CODE XREF: sub_236F4+167j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		add	si, 2178h
		mov	ax, [si]
		mov	cl, 3
		sar	ax, cl
		cmp	ax, 24h	; '$'
		jle	short loc_2387C
		mov	word ptr [si], 120h

loc_2387C:				; CODE XREF: sub_236F4+182j
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [bx+2178h]
		mov	cl, 3
		sar	ax, cl
		cmp	ax, 4
		jge	short loc_238AD
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	word ptr [bx+2178h], 20h ; ' '

loc_238AD:				; CODE XREF: sub_236F4+1A2j
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [bx+2178h]
		mov	cl, 3
		sar	ax, cl
		cmp	ax, 24h	; '$'
		jle	short loc_238DE
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	word ptr [bx+2178h], 120h

loc_238DE:				; CODE XREF: sub_236F4+12Bj
					; sub_236F4+1D3j
		pop	si
		pop	bp
		retf
sub_236F4	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_238E2	proc far		; CODE XREF: sub_24672+3F7p
					; sub_24B5E+373p

arg_0		= word ptr  6
arg_2		= word ptr  8
arg_4		= byte ptr  0Ah

		push	bp
		mov	bp, sp
		push	si
		mov	ax, word_2CF92
		mov	cx, ax
		shl	ax, 1
		add	ax, cx
		shl	ax, 1
		add	ax, cx
		shl	ax, 1
		mov	si, ax
		mov	ax, [bp+arg_0]
		mov	[si+2214h], ax
		mov	ax, [bp+arg_2]
		mov	[si+2216h], ax
		mov	word ptr [si+2218h], 0
		mov	word ptr [si+221Ah], 0
		mov	al, [bp+arg_4]
		mov	[si+221Ch], al
		mov	byte ptr [si+221Eh], 0
		mov	byte ptr [si+221Fh], 1
		mov	byte ptr [si+2220h], 20h ; ' '
		mov	byte ptr [si+2221h], 23h ; '#'
		mov	byte ptr [si+221Dh], 20h ; ' '
		inc	word_2CF92
		pop	si
		pop	bp
		retf
sub_238E2	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_23938	proc far		; CODE XREF: sub_24672+4C9p
					; sub_24B5E+41Bp

arg_0		= word ptr  6
arg_2		= word ptr  8
arg_4		= byte ptr  0Ah

		push	bp
		mov	bp, sp
		push	si
		mov	ax, word_2CF92
		mov	cx, ax
		shl	ax, 1
		add	ax, cx
		shl	ax, 1
		add	ax, cx
		shl	ax, 1
		mov	si, ax
		mov	ax, [bp+arg_0]
		mov	[si+2214h], ax
		mov	ax, [bp+arg_2]
		mov	[si+2216h], ax
		mov	word ptr [si+2218h], 0
		mov	word ptr [si+221Ah], 0
		mov	al, [bp+arg_4]
		mov	[si+221Ch], al
		mov	byte ptr [si+221Eh], 0
		mov	byte ptr [si+221Fh], 1
		mov	byte ptr [si+2220h], 1Ch
		mov	byte ptr [si+2221h], 1Fh
		mov	byte ptr [si+221Dh], 1Ch
		inc	word_2CF92
		pop	si
		pop	bp
		retf
sub_23938	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_2398E	proc far		; CODE XREF: sub_141D0+78P
					; sub_141D0+84P ...

var_1C		= word ptr -1Ch
var_1A		= word ptr -1Ah
var_18		= word ptr -18h
var_16		= byte ptr -16h
var_14		= dword	ptr -14h
var_10		= word ptr -10h
var_E		= word ptr -0Eh
var_C		= word ptr -0Ch
var_A		= word ptr -0Ah
var_8		= word ptr -8
var_6		= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 1Ch
		push	di
		push	si
		cmp	[bp+arg_0], 0
		jnz	short loc_239A2
		mov	bx, 5
		jmp	short loc_239A5
; ---------------------------------------------------------------------------
		align 2

loc_239A2:				; CODE XREF: sub_2398E+Cj
		mov	bx, 8

loc_239A5:				; CODE XREF: sub_2398E+11j
		shl	bx, 1
		mov	bx, [bx+29C8h]
		shl	bx, 1
		shl	bx, 1
		mov	dx, [bx+244Ch]
		sub	ax, ax
		mov	[bp+var_10], ax
		mov	[bp+var_E], dx
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	al, [si+21AEh]
		sub	ah, ah
		mov	[bp+var_2], ax
		mov	ax, [si+219Ah]
		mov	[bp+var_6], ax
		mov	ax, [bp+var_2]
		mov	cx, ax
		shl	ax, 1
		shl	ax, 1
		add	ax, cx
		shl	ax, 1
		add	ax, [bp+var_10]
		mov	dx, [bp+var_E]
		mov	word ptr [bp+var_14], ax
		mov	word ptr [bp+var_14+2],	dx
		les	bx, [bp+var_14]
		mov	al, es:[bx]
		mov	[bp+var_16], al
		or	al, al
		jnz	short loc_239FC
		jmp	loc_23B06
; ---------------------------------------------------------------------------

loc_239FC:				; CODE XREF: sub_2398E+69j
		cmp	byte ptr es:[bx+1], 0
		jnz	short loc_23A06
		jmp	loc_23B06
; ---------------------------------------------------------------------------

loc_23A06:				; CODE XREF: sub_2398E+73j
		test	byte ptr [si+21A9h], 1
		jnz	short loc_23A26
		mov	bx, cx
		mov	ax, bx
		shl	bx, 1
		shl	bx, 1
		add	bx, ax
		shl	bx, 1
		add	bx, [bp+var_10]
		mov	al, es:[bx]
		sub	ah, ah
		and	ax, 1Fh
		jmp	short loc_23A43
; ---------------------------------------------------------------------------

loc_23A26:				; CODE XREF: sub_2398E+7Dj
		mov	bx, [bp+var_2]
		mov	ax, bx
		shl	bx, 1
		shl	bx, 1
		add	bx, ax
		shl	bx, 1
		add	bx, [bp+var_10]
		mov	al, es:[bx]
		sub	ah, ah
		and	ax, 1Fh
		sub	ax, 1Fh
		neg	ax

loc_23A43:				; CODE XREF: sub_2398E+96j
		mov	[bp+var_A], ax
		test	byte ptr [si+21A9h], 2
		jnz	short loc_23A68
		mov	bx, [bp+var_2]
		mov	ax, bx
		shl	bx, 1
		shl	bx, 1
		add	bx, ax
		shl	bx, 1
		add	bx, [bp+var_10]
		mov	al, es:[bx+1]
		sub	ah, ah
		and	ax, 1Fh
		jmp	short loc_23A89
; ---------------------------------------------------------------------------

loc_23A68:				; CODE XREF: sub_2398E+BDj
		mov	bx, [bp+var_2]
		mov	ax, bx
		shl	bx, 1
		shl	bx, 1
		add	bx, ax
		shl	bx, 1
		add	bx, [bp+var_10]
		mov	es, [bp+var_E]
		mov	al, es:[bx+1]
		sub	ah, ah
		and	ax, 1Fh
		sub	ax, 1Fh
		neg	ax

loc_23A89:				; CODE XREF: sub_2398E+D8j
		mov	[bp+var_C], ax
		mov	al, [bp+var_16]
		sub	ah, ah
		mov	cl, 5
		shr	ax, cl
		and	ax, 0Fh
		mov	[bp+var_4], ax
		les	bx, [bp+var_14]
		mov	al, es:[bx+1]
		sub	ah, ah
		shr	ax, cl
		and	ax, 0Fh
		mov	[bp+var_8], ax
		mov	ax, 30h	; '0'
		imul	[bp+arg_0]
		mov	di, ax
		mov	ax, [si+2178h]
		mov	cl, 3
		sar	ax, cl
		add	ax, [bp+var_A]
		mov	[bp+var_18], ax
		sub	ax, [bp+var_4]
		sub	ax, 10h
		mov	[di+25E2h], ax
		mov	ax, [bp+var_18]
		add	ax, [bp+var_4]
		sub	ax, 10h
		mov	[di+25E6h], ax
		mov	ax, [bp+var_8]
		shl	ax, cl
		mov	[bp+var_1A], ax
		mov	ax, [bp+var_C]
		shl	ax, cl
		add	ax, [si+217Ah]
		mov	[bp+var_1C], ax
		sub	ax, [bp+var_1A]
		sub	ax, 0A8h ; '�'
		mov	[di+25E4h], ax
		mov	ax, [bp+var_1C]
		add	ax, [bp+var_1A]
		sub	ax, 0A8h ; '�'
		mov	[di+25E8h], ax
		jmp	short loc_23B26
; ---------------------------------------------------------------------------

loc_23B06:				; CODE XREF: sub_2398E+6Bj
					; sub_2398E+75j
		mov	ax, 30h	; '0'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+25E2h], 410h
		mov	word ptr [si+25E6h], 40Fh
		mov	word ptr [si+25E4h], 410h
		mov	word ptr [si+25E8h], 40Fh

loc_23B26:				; CODE XREF: sub_2398E+176j
		mov	ax, [bp+var_2]
		mov	cx, ax
		shl	ax, 1
		shl	ax, 1
		add	ax, cx
		shl	ax, 1
		add	ax, [bp+var_10]
		mov	dx, [bp+var_E]
		mov	word ptr [bp+var_14], ax
		mov	word ptr [bp+var_14+2],	dx
		les	bx, [bp+var_14]
		cmp	byte ptr es:[bx+2], 0
		jnz	short loc_23B4C
		jmp	loc_23C68
; ---------------------------------------------------------------------------

loc_23B4C:				; CODE XREF: sub_2398E+1B9j
		cmp	byte ptr es:[bx+3], 0
		jnz	short loc_23B56
		jmp	loc_23C68
; ---------------------------------------------------------------------------

loc_23B56:				; CODE XREF: sub_2398E+1C3j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		test	byte ptr [si+21A9h], 1
		jnz	short loc_23B82
		mov	bx, cx
		mov	ax, bx
		shl	bx, 1
		shl	bx, 1
		add	bx, ax
		shl	bx, 1
		add	bx, [bp+var_10]
		mov	es, [bp+var_E]
		mov	al, es:[bx+2]
		sub	ah, ah
		and	ax, 1Fh
		jmp	short loc_23BA3
; ---------------------------------------------------------------------------

loc_23B82:				; CODE XREF: sub_2398E+1D5j
		mov	bx, [bp+var_2]
		mov	ax, bx
		shl	bx, 1
		shl	bx, 1
		add	bx, ax
		shl	bx, 1
		add	bx, [bp+var_10]
		mov	es, [bp+var_E]
		mov	al, es:[bx+2]
		sub	ah, ah
		and	ax, 1Fh
		sub	ax, 1Fh
		neg	ax

loc_23BA3:				; CODE XREF: sub_2398E+1F2j
		mov	[bp+var_A], ax
		test	byte ptr [si+21A9h], 2
		jnz	short loc_23BC8
		mov	bx, [bp+var_2]
		mov	ax, bx
		shl	bx, 1
		shl	bx, 1
		add	bx, ax
		shl	bx, 1
		add	bx, [bp+var_10]
		mov	al, es:[bx+3]
		sub	ah, ah
		and	ax, 1Fh
		jmp	short loc_23BE9
; ---------------------------------------------------------------------------

loc_23BC8:				; CODE XREF: sub_2398E+21Dj
		mov	bx, [bp+var_2]
		mov	ax, bx
		shl	bx, 1
		shl	bx, 1
		add	bx, ax
		shl	bx, 1
		add	bx, [bp+var_10]
		mov	es, [bp+var_E]
		mov	al, es:[bx+3]
		sub	ah, ah
		and	ax, 1Fh
		sub	ax, 1Fh
		neg	ax

loc_23BE9:				; CODE XREF: sub_2398E+238j
		mov	[bp+var_C], ax
		les	bx, [bp+var_14]
		mov	al, es:[bx+2]
		sub	ah, ah
		mov	cl, 5
		shr	ax, cl
		and	ax, 0Fh
		mov	[bp+var_4], ax
		mov	al, es:[bx+3]
		sub	ah, ah
		shr	ax, cl
		and	ax, 0Fh
		mov	[bp+var_8], ax
		mov	ax, 30h	; '0'
		imul	[bp+arg_0]
		mov	di, ax
		mov	ax, [si+2178h]
		mov	cl, 3
		sar	ax, cl
		add	ax, [bp+var_A]
		mov	[bp+var_1C], ax
		sub	ax, [bp+var_4]
		sub	ax, 10h
		mov	[di+25EAh], ax
		mov	ax, [bp+var_1C]
		add	ax, [bp+var_4]
		sub	ax, 10h
		mov	[di+25EEh], ax
		mov	ax, [bp+var_8]
		shl	ax, cl
		mov	[bp+var_1A], ax
		mov	ax, [bp+var_C]
		shl	ax, cl
		add	ax, [si+217Ah]
		mov	[bp+var_18], ax
		sub	ax, [bp+var_1A]
		sub	ax, 0A8h ; '�'
		mov	[di+25ECh], ax
		mov	ax, [bp+var_18]
		add	ax, [bp+var_1A]
		sub	ax, 0A8h ; '�'
		mov	[di+25F0h], ax
		jmp	short loc_23C88
; ---------------------------------------------------------------------------
		align 2

loc_23C68:				; CODE XREF: sub_2398E+1BBj
					; sub_2398E+1C5j
		mov	ax, 30h	; '0'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+25EAh], 410h
		mov	word ptr [si+25EEh], 40Fh
		mov	word ptr [si+25ECh], 410h
		mov	word ptr [si+25F0h], 40Fh

loc_23C88:				; CODE XREF: sub_2398E+2D7j
		mov	ax, [bp+var_2]
		mov	cx, ax
		shl	ax, 1
		shl	ax, 1
		add	ax, cx
		shl	ax, 1
		add	ax, [bp+var_10]
		mov	dx, [bp+var_E]
		mov	word ptr [bp+var_14], ax
		mov	word ptr [bp+var_14+2],	dx
		les	bx, [bp+var_14]
		cmp	byte ptr es:[bx+4], 0
		jnz	short loc_23CAE
		jmp	loc_23DCA
; ---------------------------------------------------------------------------

loc_23CAE:				; CODE XREF: sub_2398E+31Bj
		cmp	byte ptr es:[bx+5], 0
		jnz	short loc_23CB8
		jmp	loc_23DCA
; ---------------------------------------------------------------------------

loc_23CB8:				; CODE XREF: sub_2398E+325j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		test	byte ptr [si+21A9h], 1
		jnz	short loc_23CE4
		mov	bx, cx
		mov	ax, bx
		shl	bx, 1
		shl	bx, 1
		add	bx, ax
		shl	bx, 1
		add	bx, [bp+var_10]
		mov	es, [bp+var_E]
		mov	al, es:[bx+4]
		sub	ah, ah
		and	ax, 1Fh
		jmp	short loc_23D05
; ---------------------------------------------------------------------------

loc_23CE4:				; CODE XREF: sub_2398E+337j
		mov	bx, [bp+var_2]
		mov	ax, bx
		shl	bx, 1
		shl	bx, 1
		add	bx, ax
		shl	bx, 1
		add	bx, [bp+var_10]
		mov	es, [bp+var_E]
		mov	al, es:[bx+4]
		sub	ah, ah
		and	ax, 1Fh
		sub	ax, 1Fh
		neg	ax

loc_23D05:				; CODE XREF: sub_2398E+354j
		mov	[bp+var_A], ax
		test	byte ptr [si+21A9h], 2
		jnz	short loc_23D2A
		mov	bx, [bp+var_2]
		mov	ax, bx
		shl	bx, 1
		shl	bx, 1
		add	bx, ax
		shl	bx, 1
		add	bx, [bp+var_10]
		mov	al, es:[bx+5]
		sub	ah, ah
		and	ax, 1Fh
		jmp	short loc_23D4B
; ---------------------------------------------------------------------------

loc_23D2A:				; CODE XREF: sub_2398E+37Fj
		mov	bx, [bp+var_2]
		mov	ax, bx
		shl	bx, 1
		shl	bx, 1
		add	bx, ax
		shl	bx, 1
		add	bx, [bp+var_10]
		mov	es, [bp+var_E]
		mov	al, es:[bx+5]
		sub	ah, ah
		and	ax, 1Fh
		sub	ax, 1Fh
		neg	ax

loc_23D4B:				; CODE XREF: sub_2398E+39Aj
		mov	[bp+var_C], ax
		les	bx, [bp+var_14]
		mov	al, es:[bx+4]
		sub	ah, ah
		mov	cl, 5
		shr	ax, cl
		and	ax, 0Fh
		mov	[bp+var_4], ax
		mov	al, es:[bx+5]
		sub	ah, ah
		shr	ax, cl
		and	ax, 0Fh
		mov	[bp+var_8], ax
		mov	ax, 30h	; '0'
		imul	[bp+arg_0]
		mov	di, ax
		mov	ax, [si+2178h]
		mov	cl, 3
		sar	ax, cl
		add	ax, [bp+var_A]
		mov	[bp+var_1C], ax
		sub	ax, [bp+var_4]
		sub	ax, 10h
		mov	[di+25F2h], ax
		mov	ax, [bp+var_1C]
		add	ax, [bp+var_4]
		sub	ax, 10h
		mov	[di+25F6h], ax
		mov	ax, [bp+var_8]
		shl	ax, cl
		mov	[bp+var_1A], ax
		mov	ax, [bp+var_C]
		shl	ax, cl
		add	ax, [si+217Ah]
		mov	[bp+var_18], ax
		sub	ax, [bp+var_1A]
		sub	ax, 0A8h ; '�'
		mov	[di+25F4h], ax
		mov	ax, [bp+var_18]
		add	ax, [bp+var_1A]
		sub	ax, 0A8h ; '�'
		mov	[di+25F8h], ax
		jmp	short loc_23DEA
; ---------------------------------------------------------------------------
		align 2

loc_23DCA:				; CODE XREF: sub_2398E+31Dj
					; sub_2398E+327j
		mov	ax, 30h	; '0'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+25F2h], 410h
		mov	word ptr [si+25F6h], 40Fh
		mov	word ptr [si+25F4h], 410h
		mov	word ptr [si+25F8h], 40Fh

loc_23DEA:				; CODE XREF: sub_2398E+439j
		mov	ax, [bp+var_2]
		mov	cx, ax
		shl	ax, 1
		shl	ax, 1
		add	ax, cx
		shl	ax, 1
		add	ax, [bp+var_10]
		mov	dx, [bp+var_E]
		mov	word ptr [bp+var_14], ax
		mov	word ptr [bp+var_14+2],	dx
		les	bx, [bp+var_14]
		cmp	byte ptr es:[bx+6], 0
		jnz	short loc_23E10
		jmp	loc_23F2C
; ---------------------------------------------------------------------------

loc_23E10:				; CODE XREF: sub_2398E+47Dj
		cmp	byte ptr es:[bx+7], 0
		jnz	short loc_23E1A
		jmp	loc_23F2C
; ---------------------------------------------------------------------------

loc_23E1A:				; CODE XREF: sub_2398E+487j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		test	byte ptr [si+21A9h], 1
		jnz	short loc_23E46
		mov	bx, cx
		mov	ax, bx
		shl	bx, 1
		shl	bx, 1
		add	bx, ax
		shl	bx, 1
		add	bx, [bp+var_10]
		mov	es, [bp+var_E]
		mov	al, es:[bx+6]
		sub	ah, ah
		and	ax, 1Fh
		jmp	short loc_23E67
; ---------------------------------------------------------------------------

loc_23E46:				; CODE XREF: sub_2398E+499j
		mov	bx, [bp+var_2]
		mov	ax, bx
		shl	bx, 1
		shl	bx, 1
		add	bx, ax
		shl	bx, 1
		add	bx, [bp+var_10]
		mov	es, [bp+var_E]
		mov	al, es:[bx+6]
		sub	ah, ah
		and	ax, 1Fh
		sub	ax, 1Fh
		neg	ax

loc_23E67:				; CODE XREF: sub_2398E+4B6j
		mov	[bp+var_A], ax
		test	byte ptr [si+21A9h], 2
		jnz	short loc_23E8C
		mov	bx, [bp+var_2]
		mov	ax, bx
		shl	bx, 1
		shl	bx, 1
		add	bx, ax
		shl	bx, 1
		add	bx, [bp+var_10]
		mov	al, es:[bx+7]
		sub	ah, ah
		and	ax, 1Fh
		jmp	short loc_23EAD
; ---------------------------------------------------------------------------

loc_23E8C:				; CODE XREF: sub_2398E+4E1j
		mov	bx, [bp+var_2]
		mov	ax, bx
		shl	bx, 1
		shl	bx, 1
		add	bx, ax
		shl	bx, 1
		add	bx, [bp+var_10]
		mov	es, [bp+var_E]
		mov	al, es:[bx+7]
		sub	ah, ah
		and	ax, 1Fh
		sub	ax, 1Fh
		neg	ax

loc_23EAD:				; CODE XREF: sub_2398E+4FCj
		mov	[bp+var_C], ax
		les	bx, [bp+var_14]
		mov	al, es:[bx+6]
		sub	ah, ah
		mov	cl, 5
		shr	ax, cl
		and	ax, 0Fh
		mov	[bp+var_4], ax
		mov	al, es:[bx+7]
		sub	ah, ah
		shr	ax, cl
		and	ax, 0Fh
		mov	[bp+var_8], ax
		mov	ax, 30h	; '0'
		imul	[bp+arg_0]
		mov	di, ax
		mov	ax, [si+2178h]
		mov	cl, 3
		sar	ax, cl
		add	ax, [bp+var_A]
		mov	[bp+var_1C], ax
		sub	ax, [bp+var_4]
		sub	ax, 10h
		mov	[di+25FAh], ax
		mov	ax, [bp+var_1C]
		add	ax, [bp+var_4]
		sub	ax, 10h
		mov	[di+25FEh], ax
		mov	ax, [bp+var_8]
		shl	ax, cl
		mov	[bp+var_1A], ax
		mov	ax, [bp+var_C]
		shl	ax, cl
		add	ax, [si+217Ah]
		mov	[bp+var_18], ax
		sub	ax, [bp+var_1A]
		sub	ax, 0A8h ; '�'
		mov	[di+25FCh], ax
		mov	ax, [bp+var_18]
		add	ax, [bp+var_1A]
		sub	ax, 0A8h ; '�'
		mov	[di+2600h], ax
		jmp	short loc_23F4C
; ---------------------------------------------------------------------------
		align 2

loc_23F2C:				; CODE XREF: sub_2398E+47Fj
					; sub_2398E+489j
		mov	ax, 30h	; '0'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+25FAh], 410h
		mov	word ptr [si+25FEh], 40Fh
		mov	word ptr [si+25FCh], 410h
		mov	word ptr [si+2600h], 40Fh

loc_23F4C:				; CODE XREF: sub_2398E+59Bj
		mov	ax, [bp+var_2]
		mov	cx, ax
		shl	ax, 1
		shl	ax, 1
		add	ax, cx
		shl	ax, 1
		add	ax, [bp+var_10]
		mov	dx, [bp+var_E]
		mov	word ptr [bp+var_14], ax
		mov	word ptr [bp+var_14+2],	dx
		les	bx, [bp+var_14]
		cmp	byte ptr es:[bx+8], 0
		jnz	short loc_23F72
		jmp	loc_2408E
; ---------------------------------------------------------------------------

loc_23F72:				; CODE XREF: sub_2398E+5DFj
		cmp	byte ptr es:[bx+9], 0
		jnz	short loc_23F7C
		jmp	loc_2408E
; ---------------------------------------------------------------------------

loc_23F7C:				; CODE XREF: sub_2398E+5E9j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		test	byte ptr [si+21A9h], 1
		jnz	short loc_23FA8
		mov	bx, cx
		mov	ax, bx
		shl	bx, 1
		shl	bx, 1
		add	bx, ax
		shl	bx, 1
		add	bx, [bp+var_10]
		mov	es, [bp+var_E]
		mov	al, es:[bx+8]
		sub	ah, ah
		and	ax, 1Fh
		jmp	short loc_23FC9
; ---------------------------------------------------------------------------

loc_23FA8:				; CODE XREF: sub_2398E+5FBj
		mov	bx, [bp+var_2]
		mov	ax, bx
		shl	bx, 1
		shl	bx, 1
		add	bx, ax
		shl	bx, 1
		add	bx, [bp+var_10]
		mov	es, [bp+var_E]
		mov	al, es:[bx+8]
		sub	ah, ah
		and	ax, 1Fh
		sub	ax, 1Fh
		neg	ax

loc_23FC9:				; CODE XREF: sub_2398E+618j
		mov	[bp+var_A], ax
		test	byte ptr [si+21A9h], 2
		jnz	short loc_23FEE
		mov	bx, [bp+var_2]
		mov	ax, bx
		shl	bx, 1
		shl	bx, 1
		add	bx, ax
		shl	bx, 1
		add	bx, [bp+var_10]
		mov	al, es:[bx+9]
		sub	ah, ah
		and	ax, 1Fh
		jmp	short loc_2400F
; ---------------------------------------------------------------------------

loc_23FEE:				; CODE XREF: sub_2398E+643j
		mov	bx, [bp+var_2]
		mov	ax, bx
		shl	bx, 1
		shl	bx, 1
		add	bx, ax
		shl	bx, 1
		add	bx, [bp+var_10]
		mov	es, [bp+var_E]
		mov	al, es:[bx+9]
		sub	ah, ah
		and	ax, 1Fh
		sub	ax, 1Fh
		neg	ax

loc_2400F:				; CODE XREF: sub_2398E+65Ej
		mov	[bp+var_C], ax
		les	bx, [bp+var_14]
		mov	al, es:[bx+8]
		sub	ah, ah
		mov	cl, 5
		shr	ax, cl
		and	ax, 0Fh
		mov	[bp+var_4], ax
		mov	al, es:[bx+9]
		sub	ah, ah
		shr	ax, cl
		and	ax, 0Fh
		mov	[bp+var_8], ax
		mov	ax, 30h	; '0'
		imul	[bp+arg_0]
		mov	di, ax
		mov	ax, [si+2178h]
		mov	cl, 3
		sar	ax, cl
		add	ax, [bp+var_A]
		mov	[bp+var_1C], ax
		sub	ax, [bp+var_4]
		sub	ax, 10h
		mov	[di+2602h], ax
		mov	ax, [bp+var_1C]
		add	ax, [bp+var_4]
		sub	ax, 10h
		mov	[di+2606h], ax
		mov	ax, [bp+var_8]
		shl	ax, cl
		mov	[bp+var_1A], ax
		mov	ax, [bp+var_C]
		shl	ax, cl
		add	ax, [si+217Ah]
		mov	[bp+var_18], ax
		sub	ax, [bp+var_1A]
		sub	ax, 0A8h ; '�'
		mov	[di+2604h], ax
		mov	ax, [bp+var_18]
		add	ax, [bp+var_1A]
		sub	ax, 0A8h ; '�'
		mov	[di+2608h], ax
		jmp	short loc_240AE
; ---------------------------------------------------------------------------
		align 2

loc_2408E:				; CODE XREF: sub_2398E+5E1j
					; sub_2398E+5EBj
		mov	ax, 30h	; '0'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+2602h], 410h
		mov	word ptr [si+2606h], 40Fh
		mov	word ptr [si+2604h], 410h
		mov	word ptr [si+2608h], 40Fh

loc_240AE:				; CODE XREF: sub_2398E+6FDj
		mov	ax, [bp+var_6]
		mov	cx, ax
		shl	ax, 1
		shl	ax, 1
		add	ax, cx
		shl	ax, 1
		add	ax, [bp+var_10]
		mov	dx, [bp+var_E]
		mov	word ptr [bp+var_14], ax
		mov	word ptr [bp+var_14+2],	dx
		les	bx, [bp+var_14]
		cmp	byte ptr es:[bx+8], 0
		jnz	short loc_240D4
		jmp	loc_241FE
; ---------------------------------------------------------------------------

loc_240D4:				; CODE XREF: sub_2398E+741j
		cmp	byte ptr es:[bx+9], 0
		jnz	short loc_240DE
		jmp	loc_241FE
; ---------------------------------------------------------------------------

loc_240DE:				; CODE XREF: sub_2398E+74Bj
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	word ptr [si+21A6h], 1
		jz	short loc_240F0
		jmp	loc_241FE
; ---------------------------------------------------------------------------

loc_240F0:				; CODE XREF: sub_2398E+75Dj
		test	byte ptr [si+219Ch], 1
		jnz	short loc_24114
		mov	bx, cx
		mov	ax, bx
		shl	bx, 1
		shl	bx, 1
		add	bx, ax
		shl	bx, 1
		add	bx, [bp+var_10]
		mov	es, [bp+var_E]
		mov	al, es:[bx+8]
		sub	ah, ah
		and	ax, 1Fh
		jmp	short loc_24135
; ---------------------------------------------------------------------------

loc_24114:				; CODE XREF: sub_2398E+767j
		mov	bx, [bp+var_6]
		mov	ax, bx
		shl	bx, 1
		shl	bx, 1
		add	bx, ax
		shl	bx, 1
		add	bx, [bp+var_10]
		mov	es, [bp+var_E]
		mov	al, es:[bx+8]
		sub	ah, ah
		and	ax, 1Fh
		sub	ax, 1Fh
		neg	ax

loc_24135:				; CODE XREF: sub_2398E+784j
		mov	[bp+var_A], ax
		test	byte ptr [si+219Ch], 2
		jnz	short loc_2415A
		mov	bx, [bp+var_6]
		mov	ax, bx
		shl	bx, 1
		shl	bx, 1
		add	bx, ax
		shl	bx, 1
		add	bx, [bp+var_10]
		mov	al, es:[bx+9]
		sub	ah, ah
		and	ax, 1Fh
		jmp	short loc_2417B
; ---------------------------------------------------------------------------

loc_2415A:				; CODE XREF: sub_2398E+7AFj
		mov	bx, [bp+var_6]
		mov	ax, bx
		shl	bx, 1
		shl	bx, 1
		add	bx, ax
		shl	bx, 1
		add	bx, [bp+var_10]
		mov	es, [bp+var_E]
		mov	al, es:[bx+9]
		sub	ah, ah
		and	ax, 1Fh
		sub	ax, 1Fh
		neg	ax

loc_2417B:				; CODE XREF: sub_2398E+7CAj
		mov	[bp+var_C], ax
		les	bx, [bp+var_14]
		mov	al, es:[bx+8]
		sub	ah, ah
		mov	cl, 5
		shr	ax, cl
		and	ax, 0Fh
		mov	[bp+var_4], ax
		mov	al, es:[bx+9]
		sub	ah, ah
		shr	ax, cl
		and	ax, 0Fh
		mov	[bp+var_8], ax
		mov	ax, 30h	; '0'
		imul	[bp+arg_0]
		mov	di, ax
		mov	ax, [si+21A2h]
		mov	cl, 3
		sar	ax, cl
		add	ax, [bp+var_A]
		mov	[bp+var_1C], ax
		sub	ax, [bp+var_4]
		sub	ax, 10h
		mov	[di+260Ah], ax
		mov	ax, [bp+var_1C]
		add	ax, [bp+var_4]
		sub	ax, 10h
		mov	[di+260Eh], ax
		mov	ax, [bp+var_8]
		shl	ax, cl
		mov	[bp+var_1A], ax
		mov	ax, [bp+var_C]
		shl	ax, cl
		add	ax, [si+21A4h]
		mov	[bp+var_18], ax
		sub	ax, [bp+var_1A]
		sub	ax, 0A8h ; '�'
		mov	[di+260Ch], ax
		mov	ax, [bp+var_18]
		add	ax, [bp+var_1A]
		sub	ax, 0A8h ; '�'
		mov	[di+2610h], ax
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
; ---------------------------------------------------------------------------
		align 2

loc_241FE:				; CODE XREF: sub_2398E+743j
					; sub_2398E+74Dj ...
		mov	ax, 30h	; '0'
		imul	[bp+arg_0]
		mov	si, ax
		mov	word ptr [si+260Ah], 410h
		mov	word ptr [si+260Eh], 40Fh
		mov	word ptr [si+260Ch], 410h
		mov	word ptr [si+2610h], 40Fh
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_2398E	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_24224	proc far		; CODE XREF: seg009:25B0p sub_24672+Cp

var_C		= word ptr -0Ch
var_A		= word ptr -0Ah
var_8		= word ptr -8
var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 0Ch
		push	si
		mov	[bp+var_8], 0
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 30h	; '0'
		imul	cx
		mov	bx, ax
		mov	ax, [bx+2602h]
		mov	[bp+var_A], ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	ax, [bx+2604h]
		mov	[bp+var_2], ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	ax, [bx+2606h]
		mov	[bp+var_C], ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	ax, [bx+2608h]
		mov	[bp+var_4], ax
		mov	ax, cx
		imul	[bp+arg_0]
		mov	si, ax
		mov	ax, [bp+var_A]
		cmp	[si+25E6h], ax
		jl	short loc_242AF
		mov	ax, [bp+var_2]
		cmp	[si+25E8h], ax
		jl	short loc_242AF
		mov	ax, [bp+var_C]
		cmp	[si+25E2h], ax
		jg	short loc_242AF
		mov	ax, [bp+var_4]
		cmp	[si+25E4h], ax
		jg	short loc_242AF
		mov	[bp+var_8], 1

loc_242AF:				; CODE XREF: sub_24224+69j
					; sub_24224+72j ...
		mov	ax, 30h	; '0'
		imul	[bp+arg_0]
		mov	si, ax
		mov	ax, [bp+var_A]
		cmp	[si+25EEh], ax
		jl	short loc_242DF
		mov	ax, [bp+var_2]
		cmp	[si+25F0h], ax
		jl	short loc_242DF
		mov	ax, [bp+var_C]
		cmp	[si+25EAh], ax
		jg	short loc_242DF
		mov	ax, [bp+var_4]
		cmp	[si+25ECh], ax
		jg	short loc_242DF
		or	byte ptr [bp+var_8], 2

loc_242DF:				; CODE XREF: sub_24224+9Aj
					; sub_24224+A3j ...
		mov	ax, 30h	; '0'
		imul	[bp+arg_0]
		mov	si, ax
		mov	ax, [bp+var_A]
		cmp	[si+25F6h], ax
		jl	short loc_2430F
		mov	ax, [bp+var_2]
		cmp	[si+25F8h], ax
		jl	short loc_2430F
		mov	ax, [bp+var_C]
		cmp	[si+25F2h], ax
		jg	short loc_2430F
		mov	ax, [bp+var_4]
		cmp	[si+25F4h], ax
		jg	short loc_2430F
		or	byte ptr [bp+var_8], 4

loc_2430F:				; CODE XREF: sub_24224+CAj
					; sub_24224+D3j ...
		mov	ax, 30h	; '0'
		imul	[bp+arg_0]
		mov	si, ax
		mov	ax, [bp+var_A]
		cmp	[si+25FEh], ax
		jl	short loc_24340
		mov	ax, [bp+var_2]
		cmp	[si+2600h], ax
		jl	short loc_24340
		mov	ax, [bp+var_C]
		cmp	[si+25FAh], ax
		jg	short loc_24340
		mov	ax, [bp+var_4]
		cmp	[si+25FCh], ax
		jg	short loc_24340
		or	[bp+var_8], 8

loc_24340:				; CODE XREF: sub_24224+FAj
					; sub_24224+103j ...
		cmp	[bp+var_8], 0
		jz	short loc_24350
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_22252
		add	sp, 2

loc_24350:				; CODE XREF: sub_24224+120j
		mov	ax, [bp+var_8]
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_24224	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_24358	proc far		; CODE XREF: seg009:25A4p sub_24B5E+Cp

var_C		= word ptr -0Ch
var_A		= word ptr -0Ah
var_8		= word ptr -8
var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 0Ch
		push	si
		mov	[bp+var_8], 0
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 30h	; '0'
		imul	cx
		mov	bx, ax
		mov	ax, [bx+260Ah]
		mov	[bp+var_A], ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	ax, [bx+260Ch]
		mov	[bp+var_2], ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	ax, [bx+260Eh]
		mov	[bp+var_C], ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	ax, [bx+2610h]
		mov	[bp+var_4], ax
		mov	ax, cx
		imul	[bp+arg_0]
		mov	si, ax
		mov	ax, [bp+var_A]
		cmp	[si+25E6h], ax
		jl	short loc_243E3
		mov	ax, [bp+var_2]
		cmp	[si+25E8h], ax
		jl	short loc_243E3
		mov	ax, [bp+var_C]
		cmp	[si+25E2h], ax
		jg	short loc_243E3
		mov	ax, [bp+var_4]
		cmp	[si+25E4h], ax
		jg	short loc_243E3
		mov	[bp+var_8], 1

loc_243E3:				; CODE XREF: sub_24358+69j
					; sub_24358+72j ...
		mov	ax, 30h	; '0'
		imul	[bp+arg_0]
		mov	si, ax
		mov	ax, [bp+var_A]
		cmp	[si+25EEh], ax
		jl	short loc_24413
		mov	ax, [bp+var_2]
		cmp	[si+25F0h], ax
		jl	short loc_24413
		mov	ax, [bp+var_C]
		cmp	[si+25EAh], ax
		jg	short loc_24413
		mov	ax, [bp+var_4]
		cmp	[si+25ECh], ax
		jg	short loc_24413
		or	byte ptr [bp+var_8], 2

loc_24413:				; CODE XREF: sub_24358+9Aj
					; sub_24358+A3j ...
		mov	ax, 30h	; '0'
		imul	[bp+arg_0]
		mov	si, ax
		mov	ax, [bp+var_A]
		cmp	[si+25F6h], ax
		jl	short loc_24443
		mov	ax, [bp+var_2]
		cmp	[si+25F8h], ax
		jl	short loc_24443
		mov	ax, [bp+var_C]
		cmp	[si+25F2h], ax
		jg	short loc_24443
		mov	ax, [bp+var_4]
		cmp	[si+25F4h], ax
		jg	short loc_24443
		or	byte ptr [bp+var_8], 4

loc_24443:				; CODE XREF: sub_24358+CAj
					; sub_24358+D3j ...
		mov	ax, 30h	; '0'
		imul	[bp+arg_0]
		mov	si, ax
		mov	ax, [bp+var_A]
		cmp	[si+25FEh], ax
		jl	short loc_24474
		mov	ax, [bp+var_2]
		cmp	[si+2600h], ax
		jl	short loc_24474
		mov	ax, [bp+var_C]
		cmp	[si+25FAh], ax
		jg	short loc_24474
		mov	ax, [bp+var_4]
		cmp	[si+25FCh], ax
		jg	short loc_24474
		or	[bp+var_8], 8

loc_24474:				; CODE XREF: sub_24358+FAj
					; sub_24358+103j ...
		cmp	[bp+var_8], 0
		jz	short loc_24484
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_22252
		add	sp, 2

loc_24484:				; CODE XREF: sub_24358+120j
		mov	ax, [bp+var_8]
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_24358	endp

; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		push	si
		push	word ptr [bp+6]
		push	cs
		call	near ptr sub_24358
		add	sp, 2
		push	word ptr [bp+6]
		mov	si, ax
		push	cs
		call	near ptr sub_24224
		add	sp, 2
		or	ax, si
		pop	si
		pop	bp
		retf
; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_244AC	proc far		; CODE XREF: sub_245EE+3Cp
					; sub_24630+3Cp ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21ABh], 4
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_21EF8
		add	sp, 2
		mov	ax, [si+218Eh]
		mov	[si+217Eh], ax
		cmp	byte ptr [si+21A9h], 1
		jnz	short loc_244DC
		mov	ax, 0FFF8h
		jmp	short loc_244DF
; ---------------------------------------------------------------------------
		align 2

loc_244DC:				; CODE XREF: sub_244AC+28j
		mov	ax, 8

loc_244DF:				; CODE XREF: sub_244AC+2Dj
		mov	[si+217Ch], ax
		mov	al, [si+21BFh]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 3
		mov	byte ptr [si+21ADh], 5
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	word ptr [bx+218Ah], 0
		jnz	short loc_24536
		mov	ax, cx
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	word ptr [bx+2180h], 0
		jle	short loc_24536
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		cmp	byte ptr [bx+21ACh], 2
		jz	short loc_24536
		mov	al, 13h
		jmp	short loc_24538
; ---------------------------------------------------------------------------
		align 2

loc_24536:				; CODE XREF: sub_244AC+62j
					; sub_244AC+70j ...
		mov	al, 9

loc_24538:				; CODE XREF: sub_244AC+87j
		mov	[si+21AAh], al
		pop	si
		pop	bp
		retf
sub_244AC	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_24540	proc far		; CODE XREF: sub_245EE+32p
					; sub_24630+32p

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21ABh], 4
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_21EF8
		add	sp, 2
		mov	al, [si+21BEh]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 3
		mov	byte ptr [si+21ADh], 5
		mov	byte ptr [si+21AAh], 8
		pop	si
		pop	bp
		retf
sub_24540	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_2457A	proc far		; CODE XREF: sub_24630+26p

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21ABh], 4
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_21EF8
		add	sp, 2
		mov	al, [si+21BCh]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 3
		mov	byte ptr [si+21ADh], 5
		mov	byte ptr [si+21AAh], 6
		pop	si
		pop	bp
		retf
sub_2457A	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_245B4	proc far		; CODE XREF: sub_245EE+26p

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21ABh], 4
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_21EF8
		add	sp, 2
		mov	al, [si+21BDh]
		mov	[si+21AEh], al
		mov	byte ptr [si+21AFh], 0
		mov	byte ptr [si+21B0h], 3
		mov	byte ptr [si+21ADh], 5
		mov	byte ptr [si+21AAh], 7
		pop	si
		pop	bp
		retf
sub_245B4	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_245EE	proc far		; CODE XREF: sub_24672+1A1p
					; sub_24B5E+146p

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		mov	al, [bx+21ABh]
		sub	ah, ah
		or	ax, ax
		jz	short loc_24610
		cmp	ax, 1
		jz	short loc_2461C
		cmp	ax, 2
		jz	short loc_24626
		pop	bp
		retf
; ---------------------------------------------------------------------------
		align 2

loc_24610:				; CODE XREF: sub_245EE+13j
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_245B4

loc_24617:				; CODE XREF: sub_245EE+35j
					; sub_245EE+3Fj
		add	sp, 2
		pop	bp
		retf
; ---------------------------------------------------------------------------

loc_2461C:				; CODE XREF: sub_245EE+18j
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_24540
		jmp	short loc_24617
; ---------------------------------------------------------------------------
		align 2

loc_24626:				; CODE XREF: sub_245EE+1Dj
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_244AC
		jmp	short loc_24617
sub_245EE	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_24630	proc far		; CODE XREF: sub_24672+125p
					; sub_24672+21Dp ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		mov	al, [bx+21ABh]
		sub	ah, ah
		or	ax, ax
		jz	short loc_24652
		cmp	ax, 1
		jz	short loc_2465E
		cmp	ax, 2
		jz	short loc_24668
		pop	bp
		retf
; ---------------------------------------------------------------------------
		align 2

loc_24652:				; CODE XREF: sub_24630+13j
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_2457A

loc_24659:				; CODE XREF: sub_24630+35j
					; sub_24630+3Fj
		add	sp, 2
		pop	bp
		retf
; ---------------------------------------------------------------------------

loc_2465E:				; CODE XREF: sub_24630+18j
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_24540
		jmp	short loc_24659
; ---------------------------------------------------------------------------
		align 2

loc_24668:				; CODE XREF: sub_24630+1Dj
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_244AC
		jmp	short loc_24659
sub_24630	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_24672	proc far		; CODE XREF: sub_2509E+2Fp

var_A		= byte ptr -0Ah
var_8		= word ptr -8
var_6		= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 0Ah
		push	di
		push	si
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_24224
		add	sp, 2
		mov	[bp+var_2], ax
		mov	[bp+var_4], 0
		test	byte ptr [bp+var_2], 4
		jnz	short loc_24695
		jmp	loc_24721
; ---------------------------------------------------------------------------

loc_24695:				; CODE XREF: sub_24672+1Ej
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	byte ptr [bx+21ACh], 3
		jz	short loc_24721
		mov	ax, 30h	; '0'
		imul	[bp+arg_0]
		mov	si, ax
		mov	ax, [si+25F6h]
		sub	ax, [si+25F2h]
		cwd
		sub	ax, dx
		sar	ax, 1
		add	ax, [si+25F2h]
		mov	cl, 3
		shl	ax, cl
		mov	[bp+var_6], ax
		mov	ax, [si+25F8h]
		sub	ax, [si+25F4h]
		cwd
		sub	ax, dx
		sar	ax, 1
		add	ax, [si+25F4h]
		mov	[bp+var_8], ax
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		mov	al, [bx+21AAh]
		mov	[bp+var_A], al
		cmp	al, 5
		jnz	short loc_246F5
		jmp	loc_2493C
; ---------------------------------------------------------------------------

loc_246F5:				; CODE XREF: sub_24672+7Ej
		cmp	al, 4
		jnz	short loc_24712
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	byte ptr [bx+21ACh], 2
		jz	short loc_24712
		jmp	loc_2493C
; ---------------------------------------------------------------------------

loc_24712:				; CODE XREF: sub_24672+85j
					; sub_24672+9Bj ...
		mov	[bp+var_4], 1
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_244AC
		add	sp, 2

loc_24721:				; CODE XREF: sub_24672+20j
					; sub_24672+37j ...
		test	byte ptr [bp+var_2], 1
		jz	short loc_2479D
		mov	ax, 30h	; '0'
		imul	[bp+arg_0]
		mov	si, ax
		mov	ax, [si+25E6h]
		sub	ax, [si+25E2h]
		cwd
		sub	ax, dx
		sar	ax, 1
		add	ax, [si+25E2h]
		mov	cl, 3
		shl	ax, cl
		mov	[bp+var_6], ax
		mov	ax, [si+25E8h]
		sub	ax, [si+25E4h]
		cwd
		sub	ax, dx
		sar	ax, 1
		add	ax, [si+25E4h]
		mov	[bp+var_8], ax
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		mov	al, [bx+21AAh]
		mov	[bp+var_A], al
		cmp	al, 4
		jnz	short loc_24771
		jmp	loc_2497E
; ---------------------------------------------------------------------------

loc_24771:				; CODE XREF: sub_24672+FAj
		cmp	al, 5
		jnz	short loc_2478E
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	byte ptr [bx+21ACh], 3
		jz	short loc_2478E
		jmp	loc_2497E
; ---------------------------------------------------------------------------

loc_2478E:				; CODE XREF: sub_24672+101j
					; sub_24672+117j ...
		mov	[bp+var_4], 1
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_24630
		add	sp, 2

loc_2479D:				; CODE XREF: sub_24672+B3j
					; sub_24672+34Bj
		test	byte ptr [bp+var_2], 2
		jz	short loc_24819
		mov	ax, 30h	; '0'
		imul	[bp+arg_0]
		mov	si, ax
		mov	ax, [si+25EEh]
		sub	ax, [si+25EAh]
		cwd
		sub	ax, dx
		sar	ax, 1
		add	ax, [si+25EAh]
		mov	cl, 3
		shl	ax, cl
		mov	[bp+var_6], ax
		mov	ax, [si+25F0h]
		sub	ax, [si+25ECh]
		cwd
		sub	ax, dx
		sar	ax, 1
		add	ax, [si+25ECh]
		mov	[bp+var_8], ax
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		mov	al, [bx+21AAh]
		mov	[bp+var_A], al
		cmp	al, 4
		jnz	short loc_247ED
		jmp	loc_249C0
; ---------------------------------------------------------------------------

loc_247ED:				; CODE XREF: sub_24672+176j
		cmp	al, 5
		jnz	short loc_2480A
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	byte ptr [bx+21ACh], 3
		jz	short loc_2480A
		jmp	loc_249C0
; ---------------------------------------------------------------------------

loc_2480A:				; CODE XREF: sub_24672+17Dj
					; sub_24672+193j ...
		mov	[bp+var_4], 1
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_245EE
		add	sp, 2

loc_24819:				; CODE XREF: sub_24672+12Fj
					; sub_24672+38Dj
		test	byte ptr [bp+var_2], 8
		jz	short loc_24895
		mov	ax, 30h	; '0'
		imul	[bp+arg_0]
		mov	si, ax
		mov	ax, [si+25FEh]
		sub	ax, [si+25FAh]
		cwd
		sub	ax, dx
		sar	ax, 1
		add	ax, [si+25FAh]
		mov	cl, 3
		shl	ax, cl
		mov	[bp+var_6], ax
		mov	ax, [si+2600h]
		sub	ax, [si+25FCh]
		cwd
		sub	ax, dx
		sar	ax, 1
		add	ax, [si+25FCh]
		mov	[bp+var_8], ax
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		mov	al, [bx+21AAh]
		mov	[bp+var_A], al
		cmp	al, 4
		jnz	short loc_24869
		jmp	loc_24A02
; ---------------------------------------------------------------------------

loc_24869:				; CODE XREF: sub_24672+1F2j
		cmp	al, 5
		jnz	short loc_24886
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	byte ptr [bx+21ACh], 3
		jz	short loc_24886
		jmp	loc_24A02
; ---------------------------------------------------------------------------

loc_24886:				; CODE XREF: sub_24672+1F9j
					; sub_24672+20Fj ...
		mov	[bp+var_4], 1
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_24630
		add	sp, 2

loc_24895:				; CODE XREF: sub_24672+1ABj
					; sub_24672+3CFj
		cmp	[bp+var_4], 1
		jz	short loc_2489E
		jmp	loc_24A6F
; ---------------------------------------------------------------------------

loc_2489E:				; CODE XREF: sub_24672+227j
		mov	word_2D014, 6
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	[bp+arg_0], 1
		sbb	di, di
		neg	di
		shl	di, 1
		mov	ax, [di+2A2Ch]
		inc	ax
		imul	word ptr [bx+2184h]
		cwd
		xor	ax, dx
		sub	ax, dx
		mov	cx, 2
		sar	ax, cl
		xor	ax, dx
		sub	ax, dx
		sub	[si+2180h], ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	cx, 2
		mov	ax, [bx+2184h]
		cwd
		idiv	cx
		mov	[bx+2184h], ax
		cmp	word ptr [si+2180h], 0
		jg	short loc_2491C
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_244AC
		add	sp, 2
		mov	ax, [si+218Eh]
		mov	[si+217Eh], ax
		mov	word_2D014, 0Ah

loc_2491C:				; CODE XREF: sub_24672+290j
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	word ptr [bx+218Ah], 1
		jz	short loc_24935
		jmp	loc_24A44
; ---------------------------------------------------------------------------

loc_24935:				; CODE XREF: sub_24672+2BEj
		mov	ax, 0Ah
		jmp	loc_24A47
; ---------------------------------------------------------------------------
		align 2

loc_2493C:				; CODE XREF: sub_24672+80j
					; sub_24672+9Dj
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	al, [si+21A9h]
		cmp	[bx+21A9h], al
		jnz	short loc_24960
		jmp	loc_24712
; ---------------------------------------------------------------------------

loc_24960:				; CODE XREF: sub_24672+2E9j
		or	al, al
		jnz	short loc_2496A
		mov	ax, 8
		jmp	short loc_2496D
; ---------------------------------------------------------------------------
		align 2

loc_2496A:				; CODE XREF: sub_24672+2F0j
		mov	ax, 0FFF8h

loc_2496D:				; CODE XREF: sub_24672+2F5j
		mov	[si+217Ch], ax
		mov	byte ptr [si+21ADh], 4
		mov	[bp+var_4], 2
		jmp	loc_24721
; ---------------------------------------------------------------------------

loc_2497E:				; CODE XREF: sub_24672+FCj
					; sub_24672+119j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	al, [si+21A9h]
		cmp	[bx+21A9h], al
		jnz	short loc_249A2
		jmp	loc_2478E
; ---------------------------------------------------------------------------

loc_249A2:				; CODE XREF: sub_24672+32Bj
		or	al, al
		jnz	short loc_249AC
		mov	ax, 8
		jmp	short loc_249AF
; ---------------------------------------------------------------------------
		align 2

loc_249AC:				; CODE XREF: sub_24672+332j
		mov	ax, 0FFF8h

loc_249AF:				; CODE XREF: sub_24672+337j
		mov	[si+217Ch], ax
		mov	byte ptr [si+21ADh], 4
		mov	[bp+var_4], 2
		jmp	loc_2479D
; ---------------------------------------------------------------------------

loc_249C0:				; CODE XREF: sub_24672+178j
					; sub_24672+195j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	al, [si+21A9h]
		cmp	[bx+21A9h], al
		jnz	short loc_249E4
		jmp	loc_2480A
; ---------------------------------------------------------------------------

loc_249E4:				; CODE XREF: sub_24672+36Dj
		or	al, al
		jnz	short loc_249EE
		mov	ax, 8
		jmp	short loc_249F1
; ---------------------------------------------------------------------------
		align 2

loc_249EE:				; CODE XREF: sub_24672+374j
		mov	ax, 0FFF8h

loc_249F1:				; CODE XREF: sub_24672+379j
		mov	[si+217Ch], ax
		mov	byte ptr [si+21ADh], 4
		mov	[bp+var_4], 2
		jmp	loc_24819
; ---------------------------------------------------------------------------

loc_24A02:				; CODE XREF: sub_24672+1F4j
					; sub_24672+211j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	al, [si+21A9h]
		cmp	[bx+21A9h], al
		jnz	short loc_24A26
		jmp	loc_24886
; ---------------------------------------------------------------------------

loc_24A26:				; CODE XREF: sub_24672+3AFj
		or	al, al
		jnz	short loc_24A30
		mov	ax, 8
		jmp	short loc_24A33
; ---------------------------------------------------------------------------
		align 2

loc_24A30:				; CODE XREF: sub_24672+3B6j
		mov	ax, 0FFF8h

loc_24A33:				; CODE XREF: sub_24672+3BBj
		mov	[si+217Ch], ax
		mov	byte ptr [si+21ADh], 4
		mov	[bp+var_4], 2
		jmp	loc_24895
; ---------------------------------------------------------------------------

loc_24A44:				; CODE XREF: sub_24672+2C0j
		mov	ax, 7

loc_24A47:				; CODE XREF: sub_24672+2C6j
		push	ax
		call	sub_15BEE
		add	sp, 2
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	byte ptr [bx+21A9h], 1
		sbb	ax, ax
		neg	ax
		push	ax
		push	[bp+var_8]
		push	[bp+var_6]
		push	cs
		call	near ptr sub_238E2
		add	sp, 6

loc_24A6F:				; CODE XREF: sub_24672+229j
		cmp	[bp+var_4], 2
		jz	short loc_24A78
		jmp	loc_24B41
; ---------------------------------------------------------------------------

loc_24A78:				; CODE XREF: sub_24672+401j
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	word ptr [bx+218Ah], 0
		jnz	short loc_24A91
		jmp	loc_24B16
; ---------------------------------------------------------------------------

loc_24A91:				; CODE XREF: sub_24672+41Aj
		mov	word_2D014, 6
		mov	ax, cx
		imul	[bp+arg_0]
		mov	si, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		cmp	[bp+arg_0], 1
		sbb	di, di
		neg	di
		shl	di, 1
		mov	ax, [di+2A2Ch]
		inc	ax
		imul	word ptr [bx+2184h]
		cwd
		xor	ax, dx
		sub	ax, dx
		mov	cx, 2
		sar	ax, cl
		xor	ax, dx
		sub	ax, dx
		cwd
		xor	ax, dx
		sub	ax, dx
		sar	ax, cl
		xor	ax, dx
		sub	ax, dx
		sub	[si+2180h], ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	cx, 2
		mov	ax, [bx+2184h]
		cwd
		idiv	cx
		mov	[bx+2184h], ax
		cmp	word ptr [si+2180h], 0
		jg	short loc_24B16
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_244AC
		add	sp, 2
		mov	ax, [si+218Eh]
		mov	[si+217Eh], ax
		mov	word_2D014, 0Ah

loc_24B16:				; CODE XREF: sub_24672+41Cj
					; sub_24672+48Aj
		mov	ax, 1Ch
		push	ax
		call	sub_15BEE
		add	sp, 2
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	byte ptr [bx+21A9h], 1
		sbb	ax, ax
		neg	ax
		push	ax
		push	[bp+var_8]
		push	[bp+var_6]
		push	cs
		call	near ptr sub_23938
		add	sp, 6

loc_24B41:				; CODE XREF: sub_24672+403j
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [bp+var_4]
		mov	[bx+2188h], ax
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_24672	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_24B5E	proc far		; CODE XREF: sub_2509E+39p

var_A		= byte ptr -0Ah
var_8		= word ptr -8
var_6		= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 0Ah
		push	di
		push	si
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_24358
		add	sp, 2
		mov	[bp+var_2], ax
		mov	[bp+var_4], 0
		test	byte ptr [bp+var_2], 4
		jz	short loc_24BDE
		mov	ax, 30h	; '0'
		imul	[bp+arg_0]
		mov	si, ax
		mov	ax, [si+25F6h]
		sub	ax, [si+25F2h]
		cwd
		sub	ax, dx
		sar	ax, 1
		add	ax, [si+25F2h]
		mov	cl, 3
		shl	ax, cl
		mov	[bp+var_6], ax
		mov	ax, [si+25F8h]
		sub	ax, [si+25F4h]
		cwd
		sub	ax, dx
		sar	ax, 1
		add	ax, [si+25F4h]
		mov	[bp+var_8], ax
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		mov	al, [bx+21AAh]
		mov	[bp+var_A], al
		cmp	al, 4
		jnz	short loc_24BC8
		jmp	loc_24D9C
; ---------------------------------------------------------------------------

loc_24BC8:				; CODE XREF: sub_24B5E+65j
		cmp	al, 5
		jnz	short loc_24BCF
		jmp	loc_24D9C
; ---------------------------------------------------------------------------

loc_24BCF:				; CODE XREF: sub_24B5E+6Cj
					; sub_24B5E+261j
		mov	[bp+var_4], 1
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_244AC
		add	sp, 2

loc_24BDE:				; CODE XREF: sub_24B5E+1Ej
					; sub_24B5E+27Fj
		test	byte ptr [bp+var_2], 1
		jz	short loc_24C44
		mov	ax, 30h	; '0'
		imul	[bp+arg_0]
		mov	si, ax
		mov	ax, [si+25E6h]
		sub	ax, [si+25E2h]
		cwd
		sub	ax, dx
		sar	ax, 1
		add	ax, [si+25E2h]
		mov	cl, 3
		shl	ax, cl
		mov	[bp+var_6], ax
		mov	ax, [si+25E8h]
		sub	ax, [si+25E4h]
		cwd
		sub	ax, dx
		sar	ax, 1
		add	ax, [si+25E4h]
		mov	[bp+var_8], ax
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		mov	al, [bx+21AAh]
		mov	[bp+var_A], al
		cmp	al, 4
		jnz	short loc_24C2E
		jmp	loc_24DE0
; ---------------------------------------------------------------------------

loc_24C2E:				; CODE XREF: sub_24B5E+CBj
		cmp	al, 5
		jnz	short loc_24C35
		jmp	loc_24DE0
; ---------------------------------------------------------------------------

loc_24C35:				; CODE XREF: sub_24B5E+D2j
					; sub_24B5E+2A5j
		mov	[bp+var_4], 1
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_24630
		add	sp, 2

loc_24C44:				; CODE XREF: sub_24B5E+84j
					; sub_24B5E+2C3j
		test	byte ptr [bp+var_2], 2
		jz	short loc_24CAA
		mov	ax, 30h	; '0'
		imul	[bp+arg_0]
		mov	si, ax
		mov	ax, [si+25EEh]
		sub	ax, [si+25EAh]
		cwd
		sub	ax, dx
		sar	ax, 1
		add	ax, [si+25EAh]
		mov	cl, 3
		shl	ax, cl
		mov	[bp+var_6], ax
		mov	ax, [si+25F0h]
		sub	ax, [si+25ECh]
		cwd
		sub	ax, dx
		sar	ax, 1
		add	ax, [si+25ECh]
		mov	[bp+var_8], ax
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		mov	al, [bx+21AAh]
		mov	[bp+var_A], al
		cmp	al, 4
		jnz	short loc_24C94
		jmp	loc_24E24
; ---------------------------------------------------------------------------

loc_24C94:				; CODE XREF: sub_24B5E+131j
		cmp	al, 5
		jnz	short loc_24C9B
		jmp	loc_24E24
; ---------------------------------------------------------------------------

loc_24C9B:				; CODE XREF: sub_24B5E+138j
					; sub_24B5E+2E9j
		mov	[bp+var_4], 1
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_245EE
		add	sp, 2

loc_24CAA:				; CODE XREF: sub_24B5E+EAj
					; sub_24B5E+307j
		test	byte ptr [bp+var_2], 8
		jz	short loc_24D10
		mov	ax, 30h	; '0'
		imul	[bp+arg_0]
		mov	si, ax
		mov	ax, [si+25FEh]
		sub	ax, [si+25FAh]
		cwd
		sub	ax, dx
		sar	ax, 1
		add	ax, [si+25FAh]
		mov	cl, 3
		shl	ax, cl
		mov	[bp+var_6], ax
		mov	ax, [si+2600h]
		sub	ax, [si+25FCh]
		cwd
		sub	ax, dx
		sar	ax, 1
		add	ax, [si+25FCh]
		mov	[bp+var_8], ax
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		mov	al, [bx+21AAh]
		mov	[bp+var_A], al
		cmp	al, 4
		jnz	short loc_24CFA
		jmp	loc_24E68
; ---------------------------------------------------------------------------

loc_24CFA:				; CODE XREF: sub_24B5E+197j
		cmp	al, 5
		jnz	short loc_24D01
		jmp	loc_24E68
; ---------------------------------------------------------------------------

loc_24D01:				; CODE XREF: sub_24B5E+19Ej
					; sub_24B5E+32Dj
		mov	[bp+var_4], 1
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_24630
		add	sp, 2

loc_24D10:				; CODE XREF: sub_24B5E+150j
					; sub_24B5E+34Bj
		cmp	[bp+var_4], 1
		jz	short loc_24D19
		jmp	loc_24EEC
; ---------------------------------------------------------------------------

loc_24D19:				; CODE XREF: sub_24B5E+1B6j
		mov	word_2D014, 6
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	[bp+arg_0], 1
		sbb	bx, bx
		neg	bx
		shl	bx, 1
		mov	ax, 18h
		imul	word ptr [bx+2A2Ch]
		add	ax, 18h
		cwd
		xor	ax, dx
		sub	ax, dx
		mov	cx, 2
		sar	ax, cl
		xor	ax, dx
		sub	ax, dx
		cwd
		xor	ax, dx
		sub	ax, dx
		sar	ax, cl
		xor	ax, dx
		sub	ax, dx
		sub	[si+2180h], ax
		sub	word ptr [si+2180h], 18h
		cmp	word ptr [si+2180h], 0
		jg	short loc_24D7C
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_244AC
		add	sp, 2
		mov	ax, [si+218Eh]
		mov	[si+217Eh], ax
		mov	word_2D014, 0Ah

loc_24D7C:				; CODE XREF: sub_24B5E+204j
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		cmp	word ptr [bx+218Ah], 1
		jz	short loc_24D95
		jmp	loc_24EAC
; ---------------------------------------------------------------------------

loc_24D95:				; CODE XREF: sub_24B5E+232j
		mov	ax, 0Ah
		jmp	loc_24EAF
; ---------------------------------------------------------------------------
		align 2

loc_24D9C:				; CODE XREF: sub_24B5E+67j
					; sub_24B5E+6Ej
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	al, [si+21A9h]
		sub	ah, ah
		cmp	[bx+219Ch], ax
		jnz	short loc_24DC2
		jmp	loc_24BCF
; ---------------------------------------------------------------------------

loc_24DC2:				; CODE XREF: sub_24B5E+25Fj
		cmp	al, ah
		jnz	short loc_24DCC
		mov	ax, 8
		jmp	short loc_24DCF
; ---------------------------------------------------------------------------
		align 2

loc_24DCC:				; CODE XREF: sub_24B5E+266j
		mov	ax, 0FFF8h

loc_24DCF:				; CODE XREF: sub_24B5E+26Bj
		mov	[si+217Ch], ax
		mov	byte ptr [si+21ADh], 4
		mov	[bp+var_4], 2
		jmp	loc_24BDE
; ---------------------------------------------------------------------------

loc_24DE0:				; CODE XREF: sub_24B5E+CDj
					; sub_24B5E+D4j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	al, [si+21A9h]
		sub	ah, ah
		cmp	[bx+219Ch], ax
		jnz	short loc_24E06
		jmp	loc_24C35
; ---------------------------------------------------------------------------

loc_24E06:				; CODE XREF: sub_24B5E+2A3j
		cmp	al, ah
		jnz	short loc_24E10
		mov	ax, 8
		jmp	short loc_24E13
; ---------------------------------------------------------------------------
		align 2

loc_24E10:				; CODE XREF: sub_24B5E+2AAj
		mov	ax, 0FFF8h

loc_24E13:				; CODE XREF: sub_24B5E+2AFj
		mov	[si+217Ch], ax
		mov	byte ptr [si+21ADh], 4
		mov	[bp+var_4], 2
		jmp	loc_24C44
; ---------------------------------------------------------------------------

loc_24E24:				; CODE XREF: sub_24B5E+133j
					; sub_24B5E+13Aj
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	al, [si+21A9h]
		sub	ah, ah
		cmp	[bx+219Ch], ax
		jnz	short loc_24E4A
		jmp	loc_24C9B
; ---------------------------------------------------------------------------

loc_24E4A:				; CODE XREF: sub_24B5E+2E7j
		cmp	al, ah
		jnz	short loc_24E54
		mov	ax, 8
		jmp	short loc_24E57
; ---------------------------------------------------------------------------
		align 2

loc_24E54:				; CODE XREF: sub_24B5E+2EEj
		mov	ax, 0FFF8h

loc_24E57:				; CODE XREF: sub_24B5E+2F3j
		mov	[si+217Ch], ax
		mov	byte ptr [si+21ADh], 4
		mov	[bp+var_4], 2
		jmp	loc_24CAA
; ---------------------------------------------------------------------------

loc_24E68:				; CODE XREF: sub_24B5E+199j
					; sub_24B5E+1A0j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	al, [si+21A9h]
		sub	ah, ah
		cmp	[bx+219Ch], ax
		jnz	short loc_24E8E
		jmp	loc_24D01
; ---------------------------------------------------------------------------

loc_24E8E:				; CODE XREF: sub_24B5E+32Bj
		cmp	al, ah
		jnz	short loc_24E98
		mov	ax, 8
		jmp	short loc_24E9B
; ---------------------------------------------------------------------------
		align 2

loc_24E98:				; CODE XREF: sub_24B5E+332j
		mov	ax, 0FFF8h

loc_24E9B:				; CODE XREF: sub_24B5E+337j
		mov	[si+217Ch], ax
		mov	byte ptr [si+21ADh], 4
		mov	[bp+var_4], 2
		jmp	loc_24D10
; ---------------------------------------------------------------------------

loc_24EAC:				; CODE XREF: sub_24B5E+234j
		mov	ax, 7

loc_24EAF:				; CODE XREF: sub_24B5E+23Aj
		push	ax
		call	sub_15BEE
		add	sp, 2
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	byte ptr [bx+21A9h], 1
		sbb	ax, ax
		neg	ax
		push	ax
		push	[bp+var_8]
		push	[bp+var_6]
		push	cs
		call	near ptr sub_238E2
		add	sp, 6
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	word ptr [bx+21A6h], 0

loc_24EEC:				; CODE XREF: sub_24B5E+1B8j
		cmp	[bp+var_4], 2
		jz	short loc_24EF5
		jmp	loc_24F94
; ---------------------------------------------------------------------------

loc_24EF5:				; CODE XREF: sub_24B5E+392j
		mov	word_2D014, 6
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	[bp+arg_0], 1
		sbb	bx, bx
		neg	bx
		shl	bx, 1
		mov	ax, [bx+2A2Ch]
		mov	cl, 3
		shl	ax, cl
		add	ax, 8
		cwd
		xor	ax, dx
		sub	ax, dx
		mov	cx, 2
		sar	ax, cl
		xor	ax, dx
		sub	ax, dx
		cwd
		xor	ax, dx
		sub	ax, dx
		sar	ax, cl
		xor	ax, dx
		sub	ax, dx
		sub	[si+2180h], ax
		cmp	word ptr [si+2180h], 0
		jg	short loc_24F54
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_244AC
		add	sp, 2
		mov	ax, [si+218Eh]
		mov	[si+217Eh], ax
		mov	word_2D014, 0Ah

loc_24F54:				; CODE XREF: sub_24B5E+3DCj
		mov	ax, 1Ch
		push	ax
		call	sub_15BEE
		add	sp, 2
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		cmp	byte ptr [bx+21A9h], 1
		sbb	ax, ax
		neg	ax
		push	ax
		push	[bp+var_8]
		push	[bp+var_6]
		push	cs
		call	near ptr sub_23938
		add	sp, 6
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	word ptr [bx+21A6h], 0

loc_24F94:				; CODE XREF: sub_24B5E+394j
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [bx+21A2h]
		add	ax, 18h
		cmp	ax, [si+21A2h]
		jg	short loc_24FBB
		jmp	loc_25098
; ---------------------------------------------------------------------------

loc_24FBB:				; CODE XREF: sub_24B5E+458j
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	ax, [bx+21A2h]
		sub	ax, 18h
		cmp	ax, [si+21A2h]
		jl	short loc_24FD7
		jmp	loc_25098
; ---------------------------------------------------------------------------

loc_24FD7:				; CODE XREF: sub_24B5E+474j
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		cmp	word ptr [bx+21A6h], 1
		jz	short loc_24FED
		jmp	loc_25098
; ---------------------------------------------------------------------------

loc_24FED:				; CODE XREF: sub_24B5E+48Aj
		cmp	word ptr [si+21A6h], 1
		jz	short loc_24FF7
		jmp	loc_25098
; ---------------------------------------------------------------------------

loc_24FF7:				; CODE XREF: sub_24B5E+494j
		mov	ax, 4
		push	ax
		call	sub_15BEE
		add	sp, 2
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		sub	ax, ax
		mov	[bx+21A6h], ax
		mov	[si+21A6h], ax
		mov	ax, word_2CF92
		mov	cx, ax
		shl	ax, 1
		add	ax, cx
		shl	ax, 1
		add	ax, cx
		shl	ax, 1
		mov	di, ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	ax, [bx+21A2h]
		add	ax, [si+21A2h]
		cwd
		sub	ax, dx
		sar	ax, 1
		mov	[di+2214h], ax
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		mov	ax, [bx+21A4h]
		add	ax, [si+21A4h]
		cwd
		sub	ax, dx
		sar	ax, 1
		mov	[di+2216h], ax
		mov	word ptr [di+2218h], 0
		mov	word ptr [di+221Ah], 0
		mov	byte ptr [di+221Ch], 0
		mov	byte ptr [di+221Eh], 0
		mov	byte ptr [di+221Fh], 1
		mov	byte ptr [di+2220h], 26h ; '&'
		mov	byte ptr [di+2221h], 29h ; ')'
		mov	byte ptr [di+221Dh], 26h ; '&'
		inc	word_2CF92

loc_25098:				; CODE XREF: sub_24B5E+45Aj
					; sub_24B5E+476j ...
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_24B5E	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_2509E	proc far		; CODE XREF: sub_12822+EP
					; sub_12822+1AP

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		mov	cx, 4Bh	; 'K'
		imul	cx
		mov	bx, ax
		mov	word ptr [bx+2188h], 0
		cmp	[bp+arg_0], 1
		sbb	ax, ax
		neg	ax
		imul	cx
		mov	bx, ax
		cmp	byte ptr [bx+21ACh], 0
		jz	short loc_250D3
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_24672
		add	sp, 2

loc_250D3:				; CODE XREF: sub_2509E+29j
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_24B5E
		add	sp, 2
		pop	bp
		retf
sub_2509E	endp

; ---------------------------------------------------------------------------
		align 2
		push	bp
		mov	bp, sp
		push	si
		mov	ax, word_2CF92
		mov	cx, ax
		shl	ax, 1
		add	ax, cx
		shl	ax, 1
		add	ax, cx
		shl	ax, 1
		mov	si, ax
		mov	ax, [bp+6]
		mov	[si+2214h], ax
		mov	ax, [bp+8]
		mov	[si+2216h], ax
		mov	ax, [bp+0Ah]
		mov	[si+2218h], ax
		mov	ax, [bp+0Ch]
		mov	[si+221Ah], ax
		mov	al, [bp+0Eh]
		mov	[si+221Ch], al
		mov	byte ptr [si+221Eh], 0
		mov	al, [bp+10h]
		mov	[si+221Fh], al
		mov	al, [bp+12h]
		mov	[si+2220h], al
		mov	al, [bp+14h]
		mov	[si+2221h], al
		mov	al, [bp+12h]
		mov	[si+221Dh], al
		inc	word_2CF92
		pop	si
		pop	bp
		retf

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_25140	proc far		; CODE XREF: sub_180FE+108P
					; sub_180FE+11CP ...

var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		mov	byte ptr [si+21ABh], 4
		mov	byte ptr [si+21ACh], 0
		mov	al, [si+21C2h]
		mov	[si+21AEh], al
		dec	byte ptr [si+21ADh]
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_22448
		add	sp, 2
		cmp	byte ptr [si+21ADh], 0
		jnz	short loc_25180
		push	[bp+arg_0]
		push	cs
		call	near ptr sub_21F4C
		add	sp, 2

loc_25180:				; CODE XREF: sub_25140+34j
		mov	ax, [bp+var_2]
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_25140	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_25188	proc far		; CODE XREF: sub_126E4+28P
					; sub_126E4+34P

var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 4
		push	si
		cmp	[bp+arg_0], 0
		jnz	short loc_2519A
		mov	ax, 3
		jmp	short loc_2519D
; ---------------------------------------------------------------------------

loc_2519A:				; CODE XREF: sub_25188+Bj
		mov	ax, 6

loc_2519D:				; CODE XREF: sub_25188+10j
		mov	[bp+var_2], ax
		cmp	[bp+arg_0], 0
		jnz	short loc_251AC
		mov	ax, 4
		jmp	short loc_251AF
; ---------------------------------------------------------------------------
		align 2

loc_251AC:				; CODE XREF: sub_25188+1Cj
		mov	ax, 7

loc_251AF:				; CODE XREF: sub_25188+21j
		mov	[bp+var_4], ax
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		sub	ax, ax
		push	ax
		mov	al, [si+21A9h]
		sub	ah, ah
		push	ax
		mov	al, [si+21AEh]
		push	ax
		push	[bp+var_4]
		push	[bp+var_2]
		push	word ptr [si+217Ah]
		mov	ax, [si+2178h]
		mov	cl, 3
		sar	ax, cl
		push	ax
		call	sub_16BFC
		add	sp, 0Eh
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_25188	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_251EA	proc far		; CODE XREF: sub_126E4+46P
					; sub_126E4+52P

var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 4
		push	si
		cmp	[bp+arg_0], 0
		jnz	short loc_251FC
		mov	ax, 3
		jmp	short loc_251FF
; ---------------------------------------------------------------------------

loc_251FC:				; CODE XREF: sub_251EA+Bj
		mov	ax, 6

loc_251FF:				; CODE XREF: sub_251EA+10j
		mov	[bp+var_2], ax
		cmp	[bp+arg_0], 0
		jnz	short loc_2520E
		mov	ax, 4
		jmp	short loc_25211
; ---------------------------------------------------------------------------
		align 2

loc_2520E:				; CODE XREF: sub_251EA+1Cj
		mov	ax, 7

loc_25211:				; CODE XREF: sub_251EA+21j
		mov	[bp+var_4], ax
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		cmp	word ptr [si+21A6h], 1
		jnz	short loc_25249
		sub	ax, ax
		push	ax
		push	word ptr [si+219Ch]
		push	word ptr [si+219Ah]
		push	[bp+var_4]
		push	[bp+var_2]
		push	word ptr [si+21A4h]
		mov	ax, [si+21A2h]
		mov	cl, 3
		sar	ax, cl
		push	ax
		call	sub_16BFC
		add	sp, 0Eh

loc_25249:				; CODE XREF: sub_251EA+37j
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_251EA	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_2524E	proc far		; CODE XREF: sub_126E4+AP
					; sub_126E4+16P

var_4		= word ptr -4
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 6
		push	si
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	bx, ax
		mov	ax, 9Eh	; '�'
		sub	ax, [bx+217Ah]
		mov	cl, 5
		sar	ax, cl
		mov	[bp+var_4], ax
		or	ax, ax
		jge	short loc_25274
		mov	[bp+var_4], 0

loc_25274:				; CODE XREF: sub_2524E+1Fj
		cmp	[bp+var_4], 3
		jle	short loc_2527F
		mov	[bp+var_4], 3

loc_2527F:				; CODE XREF: sub_2524E+2Aj
		mov	ax, 4Bh	; 'K'
		imul	[bp+arg_0]
		mov	si, ax
		sub	ax, ax
		push	ax
		mov	al, [si+21A9h]
		sub	ah, ah
		and	ax, 1
		push	ax
		mov	ax, [bp+var_4]
		add	ax, 12h
		push	ax
		mov	ax, 2
		push	ax
		mov	ax, 1
		push	ax
		mov	ax, 0A0h ; '�'
		push	ax
		mov	ax, [si+2178h]
		mov	cl, 3
		sar	ax, cl
		push	ax
		call	sub_16BFC
		add	sp, 0Eh
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_2524E	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_252BE	proc far		; CODE XREF: sub_126E4+5AP

var_34		= word ptr -34h
var_32		= word ptr -32h
var_30		= word ptr -30h
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
var_4		= word ptr -4
var_2		= word ptr -2

		push	bp
		mov	bp, sp
		sub	sp, 34h
		push	di
		push	si
		mov	[bp+var_2], 0
		jmp	loc_254F0
; ---------------------------------------------------------------------------

loc_252CE:				; CODE XREF: sub_252BE+23Aj
		mov	ax, [bp+var_2]
		mov	cx, ax
		shl	ax, 1
		add	ax, cx
		shl	ax, 1
		add	ax, cx
		shl	ax, 1
		mov	[bp+var_32], ax
		mov	bx, ax
		mov	si, ax
		mov	ax, [si+2218h]
		add	[bx+2214h], ax
		mov	ax, [si+221Ah]
		add	[bx+2216h], ax
		sub	ax, ax
		push	ax
		mov	al, [bx+221Ch]
		sub	ah, ah
		push	ax
		mov	al, [bx+221Dh]
		push	ax
		mov	ax, 2
		push	ax
		mov	ax, 1
		push	ax
		push	word ptr [bx+2216h]
		mov	ax, [bx+2214h]
		mov	cl, 3
		sar	ax, cl
		push	ax
		call	sub_16BFC
		add	sp, 0Eh
		mov	bx, si
		inc	byte ptr [bx+221Eh]
		mov	al, [si+221Eh]
		cmp	[bx+221Fh], al
		jbe	short loc_25333
		jmp	loc_254ED
; ---------------------------------------------------------------------------

loc_25333:				; CODE XREF: sub_252BE+70j
		mov	ax, [bp+var_2]
		mov	cx, ax
		shl	ax, 1
		add	ax, cx
		shl	ax, 1
		add	ax, cx
		shl	ax, 1
		mov	[bp+var_34], ax
		mov	bx, ax
		mov	byte ptr [bx+221Eh], 0
		inc	byte ptr [bx+221Dh]
		mov	si, ax
		mov	al, [si+2221h]
		cmp	[bx+221Dh], al
		ja	short loc_2535F
		jmp	loc_254ED
; ---------------------------------------------------------------------------

loc_2535F:				; CODE XREF: sub_252BE+9Cj
		mov	ax, cx
		mov	[bp+var_4], ax
		mov	ax, word_2CF92
		cmp	[bp+var_4], ax
		jl	short loc_2536F
		jmp	loc_254E6
; ---------------------------------------------------------------------------

loc_2536F:				; CODE XREF: sub_252BE+ACj
		mov	ax, cx
		mov	dx, ax
		shl	ax, 1
		add	ax, dx
		shl	ax, 1
		add	ax, dx
		shl	ax, 1
		mov	[bp+var_30], ax
		mov	si, ax
		add	si, 2214h
		mov	di, ax
		add	di, 2222h
		add	ax, 2216h
		mov	[bp+var_A], ax
		mov	ax, [bp+var_30]
		add	ax, 2224h
		mov	[bp+var_C], ax
		mov	ax, [bp+var_30]
		add	ax, 2218h
		mov	[bp+var_E], ax
		mov	ax, [bp+var_30]
		add	ax, 2226h
		mov	[bp+var_10], ax
		mov	ax, [bp+var_30]
		add	ax, 221Ah
		mov	[bp+var_12], ax
		mov	ax, [bp+var_30]
		add	ax, 2228h
		mov	[bp+var_14], ax
		mov	ax, [bp+var_30]
		add	ax, 221Ch
		mov	[bp+var_16], ax
		mov	ax, [bp+var_30]
		add	ax, 222Ah
		mov	[bp+var_18], ax
		mov	ax, [bp+var_30]
		add	ax, 221Eh
		mov	[bp+var_1A], ax
		mov	ax, [bp+var_30]
		add	ax, 222Ch
		mov	[bp+var_1C], ax
		mov	ax, [bp+var_30]
		add	ax, 221Fh
		mov	[bp+var_1E], ax
		mov	ax, [bp+var_30]
		add	ax, 222Dh
		mov	[bp+var_20], ax
		mov	ax, [bp+var_30]
		add	ax, 2220h
		mov	[bp+var_22], ax
		mov	ax, [bp+var_30]
		add	ax, 222Eh
		mov	[bp+var_24], ax
		mov	ax, [bp+var_30]
		add	ax, 2221h
		mov	[bp+var_26], ax
		mov	ax, [bp+var_30]
		add	ax, 222Fh
		mov	[bp+var_28], ax
		mov	ax, [bp+var_30]
		add	ax, 221Dh
		mov	[bp+var_2A], ax
		mov	ax, [bp+var_30]
		add	ax, 222Bh
		mov	[bp+var_2C], ax
		mov	cx, word_2CF92
		sub	cx, dx
		add	[bp+var_4], cx

loc_25434:				; CODE XREF: sub_252BE+225j
		mov	ax, [di]
		mov	[si], ax
		mov	bx, [bp+var_C]
		mov	ax, [bx]
		mov	bx, [bp+var_A]
		mov	[bx], ax
		mov	bx, [bp+var_10]
		mov	ax, [bx]
		mov	bx, [bp+var_E]
		mov	[bx], ax
		mov	bx, [bp+var_14]
		mov	ax, [bx]
		mov	bx, [bp+var_12]
		mov	[bx], ax
		mov	bx, [bp+var_18]
		mov	al, [bx]
		mov	bx, [bp+var_16]
		mov	[bx], al
		mov	bx, [bp+var_1C]
		mov	al, [bx]
		mov	bx, [bp+var_1A]
		mov	[bx], al
		mov	bx, [bp+var_20]
		mov	al, [bx]
		mov	bx, [bp+var_1E]
		mov	[bx], al
		mov	bx, [bp+var_24]
		mov	al, [bx]
		mov	bx, [bp+var_22]
		mov	[bx], al
		mov	bx, [bp+var_28]
		mov	al, [bx]
		mov	bx, [bp+var_26]
		mov	[bx], al
		mov	bx, [bp+var_2C]
		mov	al, [bx]
		mov	bx, [bp+var_2A]
		mov	[bx], al
		add	si, 0Eh
		add	di, 0Eh
		add	[bp+var_A], 0Eh
		add	[bp+var_C], 0Eh
		add	[bp+var_E], 0Eh
		add	[bp+var_10], 0Eh
		add	[bp+var_12], 0Eh
		add	[bp+var_14], 0Eh
		add	[bp+var_16], 0Eh
		add	[bp+var_18], 0Eh
		add	[bp+var_1A], 0Eh
		add	[bp+var_1C], 0Eh
		add	[bp+var_1E], 0Eh
		add	[bp+var_20], 0Eh
		add	[bp+var_22], 0Eh
		add	[bp+var_24], 0Eh
		add	[bp+var_26], 0Eh
		add	[bp+var_28], 0Eh
		add	[bp+var_2A], 0Eh
		add	[bp+var_2C], 0Eh
		dec	cx
		jz	short loc_254E6
		jmp	loc_25434
; ---------------------------------------------------------------------------

loc_254E6:				; CODE XREF: sub_252BE+AEj
					; sub_252BE+223j
		dec	word_2CF92
		dec	[bp+var_2]

loc_254ED:				; CODE XREF: sub_252BE+72j
					; sub_252BE+9Ej
		inc	[bp+var_2]

loc_254F0:				; CODE XREF: sub_252BE+Dj
		mov	ax, word_2CF92
		cmp	[bp+var_2], ax
		jge	short loc_254FB
		jmp	loc_252CE
; ---------------------------------------------------------------------------

loc_254FB:				; CODE XREF: sub_252BE+238j
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retf
sub_252BE	endp

seg009		ends

; ===========================================================================

; Segment type:	Pure code
seg010		segment	byte public 'CODE' use16
		assume cs:seg010
		;org 1
		assume es:nothing, ss:nothing, ds:nothing, fs:nothing, gs:nothing
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_25502	proc near		; CODE XREF: sub_25666+18Ap
					; sub_25666+1E9p ...
		mov	cx, ax

loc_25504:				; CODE XREF: sub_25502+Dj
		cmp	cx, ds:203Ah
		jb	short loc_25511
		sub	cx, ds:203Ah
		inc	di
		jmp	short loc_25504
; ---------------------------------------------------------------------------

loc_25511:				; CODE XREF: sub_25502+6j
		mov	ax, ds:1EF8h
		mul	cx
		add	di, ax
		sub	ds:2046h, cx
		jz	short loc_25520
		jnb	short loc_25547

loc_25520:				; CODE XREF: sub_25502+1Aj
		mov	ax, ds:203Ah
		add	ds:2046h, ax
		mul	word ptr ds:1EF8h
		sub	di, ax
		inc	di
		jmp	short loc_25547
sub_25502	endp


; =============== S U B	R O U T	I N E =======================================


sub_25530	proc near		; CODE XREF: sub_25666:loc_2580Bp
					; sub_25666+1CFp
		add	di, ds:1EF8h
		dec	word ptr ds:2046h
		jnz	short loc_25547
		mov	ax, ds:203Ah
		mov	ds:2046h, ax
		mul	word ptr ds:1EF8h
		sub	di, ax
		inc	di

loc_25547:				; CODE XREF: sub_25502+1Cj
					; sub_25502+2Cj ...
		cmp	byte ptr ds:204Bh, 0
		jnz	short locret_2555D
		mov	ds:2044h, di
		mov	ax, ds:2046h
		mov	ds:2048h, ax
		mov	byte ptr ds:204Bh, 1

locret_2555D:				; CODE XREF: sub_25530+1Cj
		retn
sub_25530	endp


; =============== S U B	R O U T	I N E =======================================


sub_2555E	proc near		; CODE XREF: sub_25666+10Fp
					; sub_25666:loc_2579Bp	...
		push	ds
		push	es
		push	si
		push	ds
		pop	es
		cmp	word ptr ds:203Ch, 0
		jnz	short loc_255B1
		lds	si, ds:203Eh
		lodsb
		out	7Eh, al
		lodsb
		out	7Eh, al
		lodsb
		out	7Eh, al
		lodsb
		out	7Eh, al
		sub	si, 4
		mov	cx, es:2034h
		mov	ah, 0FFh
		mov	dx, 1
		cmp	word ptr es:2036h, 0FFFFh
		jnz	short loc_25593
		add	si, cx
		jmp	short loc_255A5
; ---------------------------------------------------------------------------

loc_25593:				; CODE XREF: sub_2555E+2Fj
					; sub_2555E+43j
		lodsb
		test	es:2036h, dx
		jnz	short loc_2559D
		not	al

loc_2559D:				; CODE XREF: sub_2555E+3Bj
		and	ah, al
		rol	dx, 1
		loop	loc_25593
		not	ah

loc_255A5:				; CODE XREF: sub_2555E+33j
		mov	es:204Ah, ah
		mov	es:203Eh, si
		jmp	short $+2

loc_255B1:				; CODE XREF: sub_2555E+Aj
		pop	si
		pop	es
		pop	ds
		retn
sub_2555E	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_255B5	proc far		; CODE XREF: DoEnd4_Kaori+1EEP
					; LoadHEM_1+DDP ...

arg_0		= word ptr  6
arg_2		= word ptr  8
arg_4		= word ptr  0Ah

		push	bp
		mov	bp, sp
		push	si
		push	di
		push	ds
		push	es
		mov	es, [bp+arg_0]
		mov	si, [bp+arg_2]
		mov	di, [bp+arg_4]
		add	si, 10h
		mov	dx, 8
		mov	cx, 0F04h

loc_255CE:				; CODE XREF: sub_255B5+4Dj
		mov	al, es:[si]
		shr	al, cl
		mov	[di], al
		inc	di
		mov	al, es:[si]
		inc	si
		and	al, ch
		mov	[di], al
		inc	di
		mov	al, es:[si]
		shr	al, cl
		mov	[di], al
		inc	di
		mov	al, es:[si]
		inc	si
		and	al, ch
		mov	[di], al
		inc	di
		mov	al, es:[si]
		shr	al, cl
		mov	[di], al
		inc	di
		mov	al, es:[si]
		inc	si
		and	al, ch
		mov	[di], al
		inc	di
		dec	dx
		jnz	short loc_255CE
		pop	es
		pop	ds
		pop	di
		pop	si
		pop	bp
		retf
sub_255B5	endp

; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		push	si
		push	di
		push	ds
		push	es
		mov	ax, [bp+6]
		mov	es, ax
		mov	si, [bp+8]
		mov	ax, [bp+0Ah]
		mov	ds, ax
		mov	di, [bp+0Ch]
		add	si, 10h
		mov	dx, 8
		mov	cx, 0F04h

loc_2562A:				; CODE XREF: seg010:015Ej
		mov	al, es:[si]
		shr	al, cl
		mov	[di], al
		inc	di
		mov	al, es:[si]
		inc	si
		and	al, ch
		mov	[di], al
		inc	di
		mov	al, es:[si]
		shr	al, cl
		mov	[di], al
		inc	di
		mov	al, es:[si]
		inc	si
		and	al, ch
		mov	[di], al
		inc	di
		mov	al, es:[si]
		shr	al, cl
		mov	[di], al
		inc	di
		mov	al, es:[si]
		inc	si
		and	al, ch
		mov	[di], al
		inc	di
		dec	dx
		jnz	short loc_2562A
		pop	es
		pop	ds
		pop	di
		pop	si
		pop	bp
		retf

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_25666	proc far		; CODE XREF: sub_11A04+3E5P
					; DoEnd4_Kaori+200P ...

arg_0		= word ptr  6
arg_2		= word ptr  8
arg_4		= word ptr  0Ah
arg_6		= word ptr  0Ch

		push	bp
		mov	bp, sp
		push	si
		push	di
		push	ds
		mov	ax, ds:1EF8h
		mul	[bp+arg_2]
		add	ax, [bp+arg_0]
		mov	di, ax
		cld
		mov	es, [bp+arg_4]
		xor	si, si
		cmp	byte ptr es:[si], 47h ;	'G'
		jnz	short loc_25698
		cmp	byte ptr es:[si+1], 65h	; 'e'
		jnz	short loc_25698
		cmp	byte ptr es:[si+2], 6Dh	; 'm'
		jnz	short loc_25698
		cmp	byte ptr es:[si+3], 2
		jz	short loc_2569B

loc_25698:				; CODE XREF: sub_25666+1Bj
					; sub_25666+22j ...
		jmp	loc_25873
; ---------------------------------------------------------------------------

loc_2569B:				; CODE XREF: sub_25666+30j
		mov	ax, es:[si+6]
		mov	ds:2036h, ax
		mov	ax, es:[si+8]
		mov	ds:2038h, ax
		mov	ax, es:[si+0Ah]
		mov	ds:203Ah, ax
		mov	al, es:[si+5]
		xor	ah, ah
		mov	ds:203Ch, ax
		mov	cl, es:[si+4]
		xor	ch, ch
		mov	ds:2034h, cx
		mov	al, 1
		rol	al, cl
		dec	al
		xor	al, 0CFh
		mov	ds:204Ch, al
		add	si, 10h
		cmp	[bp+arg_6], 0
		jz	short loc_2571C
		mov	cx, 8
		xor	ah, ah

loc_256DC:				; CODE XREF: sub_25666+B2j
		mov	al, ah
		out	0A8h, al	; Interrupt Controller #2, 8259A
		mov	al, es:[si]
		shr	al, 4
		out	0AEh, al	; Interrupt Controller #2, 8259A
		mov	al, es:[si]
		inc	si
		and	al, 0Fh
		out	0ACh, al	; Interrupt Controller #2, 8259A
		mov	al, es:[si]
		shr	al, 4
		out	0AAh, al	; Interrupt Controller #2, 8259A
		inc	ah
		mov	al, ah
		out	0A8h, al	; Interrupt Controller #2, 8259A
		mov	al, es:[si]
		inc	si
		and	al, 0Fh
		out	0AEh, al	; Interrupt Controller #2, 8259A
		mov	al, es:[si]
		shr	al, 4
		out	0ACh, al	; Interrupt Controller #2, 8259A
		mov	al, es:[si]
		inc	si
		and	al, 0Fh
		out	0AAh, al	; Interrupt Controller #2, 8259A
		inc	ah
		loop	loc_256DC
		jmp	short loc_2571F
; ---------------------------------------------------------------------------

loc_2571C:				; CODE XREF: sub_25666+6Fj
		add	si, 18h

loc_2571F:				; CODE XREF: sub_25666+B4j
					; sub_25666+BFj
		mov	al, es:[si]
		inc	si
		and	al, al
		jnz	short loc_2571F
		mov	ds:203Eh, si
		mov	word ptr ds:2040h, es
		mov	es, [bp+arg_4]
		xor	si, si
		mov	ax, es:[si+0Ch]
		and	ax, 0Fh
		mov	bx, ax
		mov	ax, es:[si+0Ch]
		mov	dx, es:[si+0Eh]
		shr	dx, 1
		rcr	ax, 1
		shr	dx, 1
		rcr	ax, 1
		shr	dx, 1
		rcr	ax, 1
		shr	dx, 1
		rcr	ax, 1
		mov	dx, es
		add	ax, dx
		mov	ds:2042h, ax
		add	si, bx
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		mov	ds:2044h, di
		mov	ax, ds:203Ah
		mov	ds:2046h, ax
		mov	ds:2048h, ax
		mov	byte ptr ds:204Bh, 1
		call	sub_2555E
		mov	al, ds:204Ch
		out	7Ch, al
		mov	al, ds:204Ah
		mov	es:[di], al

loc_25783:				; CODE XREF: sub_25666+14Bj
					; sub_25666+157j ...
		push	ds
		xor	al, al
		out	7Ch, al
		mov	ds, word ptr ds:2042h
		lodsb
		mov	ah, 1
		and	al, al
		jnz	short loc_257BF

loc_25793:				; CODE XREF: sub_25666+1C4j
		cmp	[si], al
		pop	ds
		jnz	short loc_2579B
		jmp	loc_25873
; ---------------------------------------------------------------------------

loc_2579B:				; CODE XREF: sub_25666+130j
		call	sub_2555E
		mov	di, ds:2044h
		mov	ax, ds:2048h
		mov	ds:2046h, ax
		mov	byte ptr ds:204Bh, 0
		cmp	si, 8000h
		jb	short loc_25783
		add	word ptr ds:2042h, 800h
		sub	si, 8000h
		jmp	short loc_25783
; ---------------------------------------------------------------------------

loc_257BF:				; CODE XREF: sub_25666+12Bj
					; sub_25666+15Dj
		ror	ah, 1
		test	ah, al
		jz	short loc_257BF
		mov	dl, ah
		dec	ah
		and	al, ah
		jnz	short loc_257D2
		lodsw
		xchg	ah, al
		jmp	short loc_257E1
; ---------------------------------------------------------------------------

loc_257D2:				; CODE XREF: sub_25666+165j
		mov	ah, dl
		ror	ah, 1
		test	al, ah
		jnz	short loc_257DE
		xor	ah, ah
		jmp	short loc_257E1
; ---------------------------------------------------------------------------

loc_257DE:				; CODE XREF: sub_25666+172j
		xor	ah, al
		lodsb

loc_257E1:				; CODE XREF: sub_25666+16Aj
					; sub_25666+176j
		pop	ds
		mov	dh, al
		mov	al, ds:204Ch
		out	7Ch, al
		mov	al, dh
		cmp	dl, 80h	; '�'
		jnz	short loc_257FB
		call	sub_25502
		mov	al, ds:204Ah
		mov	es:[di], al
		jmp	short loc_25783
; ---------------------------------------------------------------------------

loc_257FB:				; CODE XREF: sub_25666+188j
		cmp	dl, 8
		jnz	short loc_2582D
		push	ax
		jmp	short loc_2580B
; ---------------------------------------------------------------------------

loc_25803:				; CODE XREF: sub_25666+1B9j
		push	cx
		xor	al, al
		out	7Ch, al
		call	sub_2555E

loc_2580B:				; CODE XREF: sub_25666+19Bj
		call	sub_25530
		mov	al, ds:204Ch
		out	7Ch, al
		mov	al, ds:204Ah
		mov	es:[di], al
		mov	byte ptr ds:204Bh, 0
		pop	cx
		loop	loc_25803
		push	ds
		mov	ds, word ptr ds:2042h
		xor	al, al
		out	7Ch, al
		jmp	loc_25793
; ---------------------------------------------------------------------------

loc_2582D:				; CODE XREF: sub_25666+198j
		cmp	dl, 40h	; '@'
		jnz	short loc_25844
		mov	cx, ax

loc_25834:				; CODE XREF: sub_25666+1D9j
		push	cx
		call	sub_25530
		mov	al, ds:204Ah
		mov	es:[di], al
		pop	cx
		loop	loc_25834
		jmp	loc_25783
; ---------------------------------------------------------------------------

loc_25844:				; CODE XREF: sub_25666+1CAj
		cmp	dl, 20h	; ' '
		jnz	short loc_2585E
		mov	cx, ax

loc_2584B:				; CODE XREF: sub_25666+1F3j
		push	cx
		mov	ax, 2
		call	sub_25502
		mov	al, ds:204Ah
		mov	es:[di], al
		pop	cx
		loop	loc_2584B
		jmp	loc_25783
; ---------------------------------------------------------------------------

loc_2585E:				; CODE XREF: sub_25666+1E1j
		mov	cx, ax

loc_25860:				; CODE XREF: sub_25666+208j
		push	cx
		mov	ax, 4
		call	sub_25502
		mov	al, ds:204Ah
		mov	es:[di], al
		pop	cx
		loop	loc_25860
		jmp	loc_25783
; ---------------------------------------------------------------------------

loc_25873:				; CODE XREF: sub_25666:loc_25698j
					; sub_25666+132j
		xor	al, al
		out	7Ch, al
		pop	ds
		pop	di
		pop	si
		pop	bp
		retf
sub_25666	endp

seg010		ends

; ===========================================================================

; Segment type:	Pure code
seg011		segment	byte public 'CODE' use16
		assume cs:seg011
		;org 0Ch
		assume es:nothing, ss:nothing, ds:nothing, fs:nothing, gs:nothing

; =============== S U B	R O U T	I N E =======================================


sub_2587C	proc near		; CODE XREF: sub_258D1+27p
					; sub_258D1+30p ...
		push	ax

loc_2587D:				; CODE XREF: sub_2587C+Ej
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		and	al, 2
		push	cx
		mov	cx, 3

loc_25885:				; CODE XREF: sub_2587C+Bj
		jmp	short $+2
		loop	loc_25885
		pop	cx
		jnz	short loc_2587D
		pop	ax
		mov	al, cl
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1
		push	ax

loc_25892:				; CODE XREF: sub_2587C+23j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		and	al, 2
		push	cx
		mov	cx, 3

loc_2589A:				; CODE XREF: sub_2587C+20j
		jmp	short $+2
		loop	loc_2589A
		pop	cx
		jnz	short loc_25892
		pop	ax
		mov	al, ch
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1
		push	ax

loc_258A7:				; CODE XREF: sub_2587C+38j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		and	al, 2
		push	cx
		mov	cx, 3

loc_258AF:				; CODE XREF: sub_2587C+35j
		jmp	short $+2
		loop	loc_258AF
		pop	cx
		jnz	short loc_258A7
		pop	ax
		mov	al, dl
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1
		push	ax

loc_258BC:				; CODE XREF: sub_2587C+4Dj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		and	al, 2
		push	cx
		mov	cx, 3

loc_258C4:				; CODE XREF: sub_2587C+4Aj
		jmp	short $+2
		loop	loc_258C4
		pop	cx
		jnz	short loc_258BC
		pop	ax
		mov	al, dh
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1
		retn
sub_2587C	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_258D1	proc far		; CODE XREF: sub_11A04+41P
					; sub_12626+B4P ...

var_0		= word ptr  0
arg_0		= word ptr  6
arg_2		= word ptr  8
arg_4		= word ptr  0Ah
arg_6		= word ptr  0Ch
arg_8		= word ptr  0Eh

		push	bp
		mov	bp, sp
		push	si
		push	di
		push	ds
		push	es
		add	bp, 6
		in	al, 31h
		push	ax

loc_258DE:				; CODE XREF: sub_258D1+1Aj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		and	al, 2
		push	cx
		mov	cx, 3

loc_258E6:				; CODE XREF: sub_258D1+17j
		jmp	short $+2
		loop	loc_258E6
		pop	cx
		jnz	short loc_258DE
		pop	ax
		mov	al, 70h	; 'p'
		out	0A2h, al	; Interrupt Controller #2, 8259A
		mov	cx, [bp+var_0]
		mov	dx, [bp+2]
		call	sub_2587C
		mov	cx, [bp+4]
		mov	dx, [bp+arg_0]
		call	sub_2587C
		mov	cx, [bp+arg_2]
		mov	dx, [bp+arg_4]
		call	sub_2587C
		mov	cx, [bp+arg_6]
		mov	dx, [bp+arg_8]
		call	sub_2587C
		pop	es
		pop	ds
		pop	di
		pop	si
		pop	bp
		retf
sub_258D1	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_2591C	proc far		; CODE XREF: sub_10828+68P
					; sub_10F06+2FP ...

var_0		= word ptr  0

		push	bp
		mov	bp, sp
		push	si
		push	di
		push	ds
		push	es
		add	bp, 6
		push	ax

loc_25927:				; CODE XREF: sub_2591C+18j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		and	al, 2
		push	cx
		mov	cx, 3

loc_2592F:				; CODE XREF: sub_2591C+15j
		jmp	short $+2
		loop	loc_2592F
		pop	cx
		jnz	short loc_25927
		pop	ax
		mov	al, 4Ch	; 'L'
		out	0A2h, al	; Interrupt Controller #2, 8259A
		push	ax

loc_2593C:				; CODE XREF: sub_2591C+2Dj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		and	al, 2
		push	cx
		mov	cx, 3

loc_25944:				; CODE XREF: sub_2591C+2Aj
		jmp	short $+2
		loop	loc_25944
		pop	cx
		jnz	short loc_2593C
		pop	ax
		mov	al, 0
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1
		push	ax

loc_25951:				; CODE XREF: sub_2591C+42j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		and	al, 2
		push	cx
		mov	cx, 3

loc_25959:				; CODE XREF: sub_2591C+3Fj
		jmp	short $+2
		loop	loc_25959
		pop	cx
		jnz	short loc_25951
		pop	ax
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1
		push	ax

loc_25964:				; CODE XREF: sub_2591C+55j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		and	al, 2
		push	cx
		mov	cx, 3

loc_2596C:				; CODE XREF: sub_2591C+52j
		jmp	short $+2
		loop	loc_2596C
		pop	cx
		jnz	short loc_25964
		pop	ax
		mov	al, 40h	; '@'
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1
		push	ax

loc_25979:				; CODE XREF: sub_2591C+6Aj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		and	al, 2
		push	cx
		mov	cx, 3

loc_25981:				; CODE XREF: sub_2591C+67j
		jmp	short $+2
		loop	loc_25981
		pop	cx
		jnz	short loc_25979
		pop	ax
		mov	al, 47h	; 'G'
		out	0A2h, al	; Interrupt Controller #2, 8259A
		push	ax

loc_2598E:				; CODE XREF: sub_2591C+7Fj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		and	al, 2
		push	cx
		mov	cx, 3

loc_25996:				; CODE XREF: sub_2591C+7Cj
		jmp	short $+2
		loop	loc_25996
		pop	cx
		jnz	short loc_2598E
		pop	ax
		mov	ax, [bp+var_0]
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1
		pop	es
		pop	ds
		pop	di
		pop	si
		pop	bp
		retf
sub_2591C	endp

seg011		ends

; ===========================================================================

; Segment type:	Pure code
seg012		segment	byte public 'CODE' use16
		assume cs:seg012
		;org 9
		assume es:nothing, ss:nothing, ds:nothing, fs:nothing, gs:nothing

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

MaybeWaitKey	proc far		; CODE XREF: sub_10000:loc_1001AP
					; sub_1004E:loc_10068P	...
		push	bp
		mov	bp, sp
		push	si
		push	di
		push	ds
		push	es
		add	bp, 6

loc_259B3:				; CODE XREF: MaybeWaitKey+Ej
		in	al, 60h		; 8042 keyboard	controller data	register
		test	al, 20h
		jnz	short loc_259B3

loc_259B9:				; CODE XREF: MaybeWaitKey+14j
		in	al, 60h		; 8042 keyboard	controller data	register
		test	al, 20h
		jz	short loc_259B9
		pop	es
		pop	ds
		pop	di
		pop	si
		pop	bp
		retf
MaybeWaitKey	endp

seg012		ends

; ---------------------------------------------------------------------------
; ===========================================================================

; Segment type:	Pure code
seg013		segment	byte public 'CODE' use16
		assume cs:seg013
		;org 5
		assume es:nothing, ss:nothing, ds:nothing, fs:nothing, gs:nothing
		push	ax
		push	bx
		push	cx
		push	dx
		push	si
		push	di
		push	bp
		push	ds
		push	es
		cli
		push	ax
		mov	al, 0Bh
		out	0, al
		push	cx
		mov	cx, 3

loc_259D8:				; CODE XREF: seg013:001Aj
		jmp	short $+2
		loop	loc_259D8
		pop	cx
		in	al, 0
		test	al, 80h
		jz	short loc_25A03
		mov	al, 20h	; ' '
		out	8, al		; DMA 8237A-5. cmd reg bits:
					; 0: enable mem-to-mem DMA
					; 1: enable Ch0	address	hold
					; 2: disable controller
					; 3: compressed	timing mode
					; 4: enable rotating priority
					; 5: extended write mode; 0=late write
					; 6: DRQ sensing - active high
					; 7: DACK sensing - active high
		push	cx
		mov	cx, 3

loc_259EB:				; CODE XREF: seg013:002Dj
		jmp	short $+2
		loop	loc_259EB
		pop	cx
		mov	al, 0Bh
		out	8, al		; DMA 8237A-5. cmd reg bits:
					; 0: enable mem-to-mem DMA
					; 1: enable Ch0	address	hold
					; 2: disable controller
					; 3: compressed	timing mode
					; 4: enable rotating priority
					; 5: extended write mode; 0=late write
					; 6: DRQ sensing - active high
					; 7: DACK sensing - active high
		push	cx
		mov	cx, 3

loc_259F8:				; CODE XREF: seg013:003Aj
		jmp	short $+2
		loop	loc_259F8
		pop	cx
		in	al, 8		; DMA 8237A-5. status register bits:
					; 0-3: channel 0-3 has reached terminal	count
					; 4-7: channel 0-3 has a request pending
		or	al, al
		jnz	short loc_25A07

loc_25A03:				; CODE XREF: seg013:0021j
		mov	al, 20h	; ' '
		out	0, al

loc_25A07:				; CODE XREF: seg013:0041j
		pop	ax
		sti
		mov	ax, cs:word_25E5B
		mov	ds, ax
		mov	ax, ds:293Ch
		inc	ax
		and	ax, 1Fh
		mov	ds:293Ch, ax
		and	ax, 1
		cmp	ax, 1
		jz	short loc_25A34
		cmp	word ptr ds:2444h, 1
		jz	short loc_25A2F
		call	sub_1502A
		jp	short loc_25A34

loc_25A2F:				; CODE XREF: seg013:0066j
		call	sub_1504C

loc_25A34:				; CODE XREF: seg013:005Fj seg013:006Dj
		xor	ax, ax
		out	64h, al		; 8042 keyboard	controller command register.
		pop	es
		pop	ds
		pop	bp
		pop	di
		pop	si
		pop	dx
		pop	cx
		pop	bx
		pop	ax
		iret

; =============== S U B	R O U T	I N E =======================================


sub_25A42	proc near		; CODE XREF: sub_25A4F+Dp
					; sub_25A4F+18p ...
		push	ax
		push	dx
		mov	dx, 188h

loc_25A47:				; CODE XREF: sub_25A42+8j
		in	al, dx
		test	al, 80h
		jnz	short loc_25A47
		pop	dx
		pop	ax
		retn
sub_25A42	endp


; =============== S U B	R O U T	I N E =======================================


sub_25A4F	proc near		; CODE XREF: seg013:0194p
					; sub_25BD0+46p
		push	bx
		push	cx
		push	dx
		push	si
		push	di
		push	ds
		push	es
		mov	dx, 188h
		mov	ax, 0Fh
		call	sub_25A42
		cli
		out	dx, al
		mov	dx, 18Ah
		mov	ax, 80h	; '�'
		call	sub_25A42
		out	dx, al
		sti
		mov	dx, 188h
		mov	ax, 0Eh
		call	sub_25A42
		cli
		out	dx, al
		call	sub_25A42
		mov	dx, 18Ah
		in	al, dx
		sti
		not	al
		mov	bl, al
		and	bx, 0Fh
		test	al, 10h
		jz	short loc_25A8D
		or	bl, 10h

loc_25A8D:				; CODE XREF: sub_25A4F+39j
		test	al, 20h
		jz	short loc_25A94
		or	bx, 20h

loc_25A94:				; CODE XREF: sub_25A4F+40j
		mov	ax, bx
		pop	es
		pop	ds
		pop	di
		pop	si
		pop	dx
		pop	cx
		pop	bx
		retn
sub_25A4F	endp


; =============== S U B	R O U T	I N E =======================================


sub_25A9E	proc near		; CODE XREF: seg013:01B0p
					; sub_25B79+46p
		push	bx
		push	cx
		push	dx
		push	si
		push	di
		push	ds
		push	es
		mov	dx, 188h
		mov	ax, 0Fh
		call	sub_25A42
		cli
		out	dx, al
		mov	dx, 18Ah
		mov	ax, 0C0h ; '�'
		call	sub_25A42
		out	dx, al
		sti
		mov	dx, 188h
		mov	ax, 0Eh
		call	sub_25A42
		cli
		out	dx, al
		mov	dx, 18Ah
		call	sub_25A42
		in	al, dx
		sti
		not	al
		mov	bl, al
		and	bx, 0Fh
		test	al, 10h
		jz	short loc_25ADC
		or	bl, 10h

loc_25ADC:				; CODE XREF: sub_25A9E+39j
		test	al, 20h
		jz	short loc_25AE3
		or	bx, 20h

loc_25AE3:				; CODE XREF: sub_25A9E+40j
		mov	ax, bx
		pop	es
		pop	ds
		pop	di
		pop	si
		pop	dx
		pop	cx
		pop	bx
		retn
sub_25A9E	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_25AED	proc far		; CODE XREF: sub_12904P
					; sub_12904:loc_12917P	...
		push	bp
		mov	bp, sp
		push	si
		push	di
		push	ds
		push	es
		add	bp, 6
		push	bx
		push	cx
		push	dx
		xor	ax, ax
		xor	dx, dx
		xor	bx, bx
		mov	es, ax
		assume es:nothing
		mov	es:528h, ah
		mov	si, 49Dh
		mov	di, 500h
		mov	cx, 10h

loc_25B10:				; CODE XREF: sub_25AED+36j
		shr	dx, 1
		mov	bl, cs:[si]
		inc	si
		mov	al, cs:[si]
		test	es:[bx+di], al
		jz	short loc_25B22
		or	dx, 8000h

loc_25B22:				; CODE XREF: sub_25AED+2Fj
		inc	si
		loop	loc_25B10
		mov	ax, dx
		cmp	cs:word_25E59, 0
		jz	short loc_25B38
		push	ax
		call	sub_25DF1
		mov	bx, ax
		pop	ax
		or	ax, bx

loc_25B38:				; CODE XREF: sub_25AED+40j
		pop	dx
		pop	cx
		pop	bx
		pop	es
		assume es:nothing
		pop	ds
		pop	di
		pop	si
		pop	bp
		retf
sub_25AED	endp

; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		push	si
		push	di
		push	ds
		push	es
		add	bp, 6
		xor	ax, ax
		cmp	word ptr ds:25E0h, 1
		jnz	short loc_25B57
		call	sub_25A4F

loc_25B57:				; CODE XREF: seg013:0192j
		pop	es
		pop	ds
		pop	di
		pop	si
		pop	bp
		retf
; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		push	si
		push	di
		push	ds
		push	es
		add	bp, 6
		xor	ax, ax
		cmp	word ptr ds:25E0h, 1
		jnz	short loc_25B73
		call	sub_25A9E

loc_25B73:				; CODE XREF: seg013:01AEj
		pop	es
		pop	ds
		pop	di
		pop	si
		pop	bp
		retf

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_25B79	proc far		; CODE XREF: sub_10828+22AP
					; sub_10828+26AP ...
		push	bp
		mov	bp, sp
		push	si
		push	di
		push	ds
		push	es
		add	bp, 6
		push	bx
		push	cx
		push	dx
		xor	ax, ax
		xor	dx, dx
		xor	bx, bx
		mov	es, ax
		assume es:nothing
		mov	es:528h, ah
		mov	si, 4BDh
		mov	di, 500h
		mov	cx, 10h

loc_25B9C:				; CODE XREF: sub_25B79+3Aj
		shr	dx, 1
		mov	bl, cs:[si]
		add	si, 1
		mov	al, cs:[si]
		test	es:[bx+di], al
		jz	short loc_25BB0
		or	dx, 8000h

loc_25BB0:				; CODE XREF: sub_25B79+31j
		add	si, 1
		loop	loc_25B9C
		mov	ax, dx
		cmp	word ptr ds:25E0h, 1
		jnz	short loc_25BC7
		push	ax
		call	sub_25A9E
		mov	bx, ax
		pop	ax
		or	ax, bx

loc_25BC7:				; CODE XREF: sub_25B79+43j
		pop	dx
		pop	cx
		pop	bx
		pop	es
		assume es:nothing
		pop	ds
		pop	di
		pop	si
		pop	bp
		retf
sub_25B79	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_25BD0	proc far		; CODE XREF: sub_10828:loc_10A4AP
					; sub_10828:loc_10A8AP	...
		push	bp
		mov	bp, sp
		push	si
		push	di
		push	ds
		push	es
		add	bp, 6
		push	bx
		push	cx
		push	dx
		xor	ax, ax
		xor	dx, dx
		xor	bx, bx
		mov	es, ax
		assume es:nothing
		mov	es:528h, ah
		mov	si, 4DDh
		mov	di, 500h
		mov	cx, 10h

loc_25BF3:				; CODE XREF: sub_25BD0+3Aj
		shr	dx, 1
		mov	bl, cs:[si]
		add	si, 1
		mov	al, cs:[si]
		test	es:[bx+di], al
		jz	short loc_25C07
		or	dx, 8000h

loc_25C07:				; CODE XREF: sub_25BD0+31j
		add	si, 1
		loop	loc_25BF3
		mov	ax, dx
		cmp	word ptr ds:25E0h, 1
		jnz	short loc_25C1E
		push	ax
		call	sub_25A4F
		mov	bx, ax
		pop	ax
		or	ax, bx

loc_25C1E:				; CODE XREF: sub_25BD0+43j
		pop	dx
		pop	cx
		pop	bx
		pop	es
		assume es:nothing
		pop	ds
		pop	di
		pop	si
		pop	bp
		retf
sub_25BD0	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_25C27	proc far		; CODE XREF: sub_10828+217P
					; sub_10828+253P ...
		push	bp
		mov	bp, sp
		push	si
		push	di
		push	ds
		push	es
		add	bp, 6
		call	sub_25BD0
		push	ax
		call	sub_25B79
		mov	bx, ax
		pop	ax
		or	ax, bx
		pop	es
		pop	ds
		pop	di
		pop	si
		pop	bp
		retf
sub_25C27	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_25C47	proc far		; CODE XREF: sub_10828:loc_10E66P
					; sub_10F06+20CP ...
		push	bp
		mov	bp, sp
		push	si
		push	di
		push	ds
		push	es
		add	bp, 6

loc_25C51:				; CODE XREF: sub_25C47+11j
		mov	ax, ds:293Ch
		cmp	ax, ds:264Ah
		jle	short loc_25C51
		pop	es
		pop	ds
		pop	di
		pop	si
		pop	bp
		retf
sub_25C47	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_25C60	proc far		; CODE XREF: sub_10F06+227P
					; sub_10F06:loc_11161P	...
		push	bp
		mov	bp, sp
		push	si
		push	di
		push	ds
		push	es
		add	bp, 6
		xor	ax, ax
		xor	dx, dx
		xor	bx, bx
		mov	es, ax
		assume es:nothing
		mov	es:528h, ah
		mov	si, 4FDh
		mov	di, 500h
		mov	cx, 10h

loc_25C80:				; CODE XREF: sub_25C60+37j
		shr	dx, 1
		mov	bl, cs:[si]
		add	si, 1
		mov	al, cs:[si]
		test	es:[bx+di], al
		jz	short loc_25C94
		or	dx, 8000h

loc_25C94:				; CODE XREF: sub_25C60+2Ej
		add	si, 1
		loop	loc_25C80
		mov	ax, dx
		pop	es
		assume es:nothing
		pop	ds
		pop	di
		pop	si
		pop	bp
		retf
sub_25C60	endp


; =============== S U B	R O U T	I N E =======================================


sub_25CA1	proc near		; CODE XREF: sub_25E03+30p
		xor	ax, ax
		in	al, 2		; DMA controller, 8237A-5.
					; channel 1 current address
		or	al, 4
		out	2, al		; DMA controller, 8237A-5.
					; channel 1 base address
					; (also	sets current address)
		mov	ax, 0
		mov	es, ax
		assume es:nothing
		mov	di, 28h	; '('
		mov	ax, cs:word_25EDF
		mov	es:[di], ax
		add	di, 2
		mov	ax, cs:word_25EDD
		mov	es:[di], ax
		sti
		retn
sub_25CA1	endp


; =============== S U B	R O U T	I N E =======================================


sub_25CC4	proc near		; CODE XREF: sub_25D0E+6Ap
		push	ax
		push	si
		xor	ax, ax
		mov	es, ax
		mov	si, 28h	; '('
		mov	bx, es:[si]
		inc	si
		inc	si
		mov	ax, es:[si]
		mov	es, ax
		assume es:nothing
		pop	si
		pop	ax
		mov	cs:word_25EDF, bx
		mov	bx, es
		mov	cs:word_25EDD, bx
		push	ax
		push	es
		push	dx
		push	si
		xor	ax, ax
		mov	es, ax
		assume es:nothing
		mov	ax, cs
		mov	dx, 5
		mov	si, 28h	; '('
		mov	es:[si], dx
		inc	si
		inc	si
		mov	es:[si], ax
		pop	si
		pop	dx
		pop	es
		assume es:nothing
		pop	ax
		xor	ax, ax
		in	al, 2		; DMA controller, 8237A-5.
					; channel 1 current address
		and	al, 0FBh
		out	2, al		; DMA controller, 8237A-5.
					; channel 1 base address
					; (also	sets current address)
		xor	ax, ax
		out	64h, al		; 8042 keyboard	controller command register.
		retn
sub_25CC4	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_25D0E	proc far		; CODE XREF: DoOpening+174P
					; DoCharIntroScr+7FP ...

var_0		= word ptr  0

		push	bp
		mov	bp, sp
		push	si
		push	di
		push	ds
		push	es
		add	bp, 6
		mov	ax, ds
		mov	cs:word_25E5B, ax
		mov	ax, [bp+var_0]
		mov	ds:25E0h, ax
		xor	ax, ax
		mov	es, ax
		assume es:nothing
		mov	ah, es:500h
		mov	cs:byte_25E56, ah
		or	ah, 20h
		mov	es:500h, ah
		mov	ah, es:522h
		mov	cs:byte_25E57, ah
		mov	ah, 1
		mov	es:522h, ah
		cmp	word ptr ds:25E0h, 1
		jnz	short loc_25D6D
		cli
		mov	dx, 188h
		mov	ax, 7
		call	sub_25A42
		out	dx, al
		mov	dx, 18Ah
		call	sub_25A42
		in	al, dx
		and	al, 3Fh
		or	al, 80h
		call	sub_25A42
		out	dx, al
		sti

loc_25D6D:				; CODE XREF: sub_25D0E+42j
		call	sub_25D81
		mov	ah, 3
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		mov	ah, 6
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		call	sub_25CC4
		pop	es
		assume es:nothing
		pop	ds
		pop	di
		pop	si
		pop	bp
		retf
sub_25D0E	endp


; =============== S U B	R O U T	I N E =======================================


sub_25D81	proc near		; CODE XREF: sub_25D0E:loc_25D6Dp
		mov	dx, 0E7E0h
		mov	al, 0B0h ; '�'
		out	dx, al
		in	al, dx
		mov	ah, al
		mov	cs:word_25E59, 0
		mov	dx, 0E7E2h
		in	al, dx
		and	ax, 8080h
		cmp	ax, 80h	; '�'
		jnz	short loc_25DA7
		mov	cs:word_25E59, 700h
		jmp	short locret_25DF0
; ---------------------------------------------------------------------------
		db 90h
; ---------------------------------------------------------------------------

loc_25DA7:				; CODE XREF: sub_25D81+1Aj
		mov	dx, 0E5E0h
		mov	al, 0B0h ; '�'
		out	dx, al
		in	al, dx
		mov	ah, al
		mov	cs:word_25E59, 0
		mov	dx, 0E5E2h
		in	al, dx
		and	ax, 8080h
		cmp	ax, 80h	; '�'
		jnz	short loc_25DCD
		mov	cs:word_25E59, 500h
		jmp	short locret_25DF0
; ---------------------------------------------------------------------------
		db 90h
; ---------------------------------------------------------------------------

loc_25DCD:				; CODE XREF: sub_25D81+40j
		mov	dx, 0E3E0h
		mov	al, 0B0h ; '�'
		out	dx, al
		in	al, dx
		mov	ah, al
		mov	cs:word_25E59, 0
		mov	dx, 0E3E2h
		in	al, dx
		and	ax, 8080h
		cmp	ax, 80h	; '�'
		jnz	short locret_25DF0
		mov	cs:word_25E59, 300h

locret_25DF0:				; CODE XREF: sub_25D81+23j
					; sub_25D81+49j ...
		retn
sub_25D81	endp


; =============== S U B	R O U T	I N E =======================================


sub_25DF1	proc near		; CODE XREF: sub_25AED+43p
		push	dx
		mov	dx, 0E0E0h
		add	dx, cs:word_25E59
		in	al, dx
		not	al
		and	al, 3Fh
		xor	ah, ah
		pop	dx
		retn
sub_25DF1	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_25E03	proc far		; CODE XREF: DoOpening+8P
					; DoCharIntroScr+64P ...
		push	bp
		mov	bp, sp
		push	si
		push	di
		push	ds
		push	es
		add	bp, 6
		xor	ax, ax
		mov	es, ax
		assume es:nothing
		mov	ah, cs:byte_25E57
		mov	es:522h, ah
		mov	ah, 3
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		mov	ah, 6
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		mov	dx, 188h
		mov	ax, 7
		out	dx, al
		mov	dx, 18Ah
		in	al, dx
		and	al, 3Fh
		or	al, 80h
		out	dx, al
		call	sub_25CA1
		pop	es
		assume es:nothing
		pop	ds
		pop	di
		pop	si
		pop	bp
		retf
sub_25E03	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_25E3C	proc far		; CODE XREF: sub_1507C+1CDP
		push	bp
		mov	bp, sp
		push	si
		push	di
		push	ds
		push	es
		add	bp, 6
		mov	ah, cs:byte_25E56
		mov	es:500h, ah
		pop	es
		pop	ds
		pop	di
		pop	si
		pop	bp
		retf
sub_25E3C	endp

; ---------------------------------------------------------------------------
byte_25E56	db 0			; DATA XREF: sub_25D0E+1Fw
					; sub_25E3C+Ar
byte_25E57	db 0			; DATA XREF: sub_25D0E+31w
					; sub_25E03+Er
		db 0
word_25E59	dw 0			; DATA XREF: sub_25AED+3Ar
					; sub_25D81+9w	...
word_25E5B	dw 0			; DATA XREF: seg013:0049r sub_25D0E+Cw
		db 32h,	8, 33h,	8, 32h,	40h, 33h, 1, 2Fh, 2, 2Fh, 4, 2Ah
		db 1, 30h, 10h,	38h, 1,	33h, 40h, 33h, 4, 33h, 10h, 32h
		db 80h,	32h, 4,	32h, 10h, 2Dh, 10h, 32h, 8, 33h, 8, 32h
		db 40h,	33h, 1,	31h, 8,	31h, 10h, 2Ah, 1, 30h, 10h, 38h
		db 1, 33h, 40h,	33h, 4,	33h, 10h, 32h, 80h, 32h, 4, 32h
		db 10h,	2Dh, 10h, 2Ch, 10h, 2Fh, 20h, 2Eh, 1, 2Eh, 4, 2Fh
		db 2, 2Fh, 4, 2Ah, 1, 30h, 10h,	38h, 1,	33h, 40h, 2Fh
		db 10h,	2Fh, 40h, 32h, 80h, 2Ch, 8, 2Ch, 20h, 2Dh, 10h
		db 3Ah,	4, 3Ah,	2, 2Ch,	20h, 2Ch, 40h, 2Eh, 10h, 2Ch, 80h
		db 2Ah,	1, 30h,	10h, 38h, 1, 2Fh, 80h, 2Dh, 40h, 2Dh, 1
		db 2Eh,	2, 2Dh,	20h, 32h, 10h, 2Dh, 10h
word_25EDD	dw 0			; DATA XREF: sub_25CA1+1Ar
					; sub_25CC4+1Cw
word_25EDF	dw 0			; DATA XREF: sub_25CA1+10r
					; sub_25CC4+15w
; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		push	si
		push	di
		push	ds
		push	es
		add	bp, 6
		mov	ax, [bp+0]
		mov	dx, [bp+2]
		mov	ah, 3Dh
		int	21h		; DOS -	2+ - OPEN DISK FILE WITH HANDLE
					; DS:DX	-> ASCIZ filename
					; AL = access mode
					; 0 - read, 1 -	write, 2 - read	& write
		pop	es
		pop	ds
		pop	di
		pop	si
		pop	bp
		retf
; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		push	si
		push	di
		push	ds
		push	es
		add	bp, 6
		mov	ax, [bp+0]
		mov	dx, [bp+2]
		mov	ah, 3Ch
		int	21h		; DOS -	2+ - CREATE A FILE WITH	HANDLE (CREAT)
					; CX = attributes for file
					; DS:DX	-> ASCIZ filename (may include drive and path)
		pop	es
		pop	ds
		pop	di
		pop	si
		pop	bp
		retf
; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		push	si
		push	di
		push	ds
		push	es
		add	bp, 6
		mov	bx, [bp+0]
		mov	ah, 3Eh
		int	21h		; DOS -	2+ - CLOSE A FILE WITH HANDLE
					; BX = file handle
		pop	es
		pop	ds
		pop	di
		pop	si
		pop	bp
		retf
; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		push	si
		push	di
		push	ds
		push	es
		add	bp, 6
		mov	bx, [bp+0]
		mov	dx, [bp+2]
		mov	cx, [bp+4]
		mov	ah, 3Fh
		int	21h		; DOS -	2+ - READ FROM FILE WITH HANDLE
					; BX = file handle, CX = number	of bytes to read
					; DS:DX	-> buffer
		pop	es
		pop	ds
		pop	di
		pop	si
		pop	bp
		retf
; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		push	si
		push	di
		push	ds
		push	es
		add	bp, 6
		mov	bx, [bp+0]
		mov	dx, [bp+2]
		mov	cx, [bp+4]
		mov	ah, 40h
		int	21h		; DOS -	2+ - WRITE TO FILE WITH	HANDLE
					; BX = file handle, CX = number	of bytes to write, DS:DX -> buffer
		pop	es
		pop	ds
		pop	di
		pop	si
		pop	bp
		retf
; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		push	si
		push	di
		push	ds
		push	es
		add	bp, 6
		mov	bx, [bp+0]
		lds	dx, [bp+2]
		mov	cx, [bp+6]
		mov	ah, 3Fh
		int	21h		; DOS -	2+ - READ FROM FILE WITH HANDLE
					; BX = file handle, CX = number	of bytes to read
					; DS:DX	-> buffer
		pop	es
		pop	ds
		pop	di
		pop	si
		pop	bp
		retf
; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		push	si
		push	di
		push	ds
		push	es
		add	bp, 6
		mov	bx, [bp+0]
		lds	dx, [bp+2]
		mov	cx, [bp+6]
		mov	ah, 40h
		int	21h		; DOS -	2+ - WRITE TO FILE WITH	HANDLE
					; BX = file handle, CX = number	of bytes to write, DS:DX -> buffer
		pop	es
		pop	ds
		pop	di
		pop	si
		pop	bp
		retf
seg013		ends

; ===========================================================================

; Segment type:	Pure code
seg014		segment	byte public 'CODE' use16
		assume cs:seg014
		assume es:nothing, ss:nothing, ds:nothing, fs:nothing, gs:nothing

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_25FA0	proc far		; CODE XREF: DoOpening+6AP
					; DoOpening+A7P ...

var_0		= word ptr  0

		push	bp
		mov	bp, sp
		push	si
		push	di
		push	ds
		push	es
		add	bp, 6
		mov	bx, [bp+var_0]
		mov	ah, 48h
		int	21h		; DOS -	2+ - ALLOCATE MEMORY
					; BX = number of 16-byte paragraphs desired
		pop	es
		pop	ds
		pop	di
		pop	si
		pop	bp
		retf
sub_25FA0	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_25FB7	proc far		; CODE XREF: sub_1542C+2CP
		push	bp
		mov	bp, sp
		push	si
		push	di
		push	ds
		push	es
		add	bp, 6
		mov	bx, 0FFFFh
		mov	ah, 48h
		int	21h		; DOS -	2+ - ALLOCATE MEMORY
					; BX = number of 16-byte paragraphs desired
		mov	ax, bx
		pop	es
		pop	ds
		pop	di
		pop	si
		pop	bp
		retf
sub_25FB7	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_25FD0	proc far		; CODE XREF: DoOpening+9CP
					; DoOpening+165P ...

var_0		= word ptr  0

		push	bp
		mov	bp, sp
		push	si
		push	di
		push	ds
		push	es
		add	bp, 6
		mov	ax, [bp+var_0]
		mov	es, ax
		mov	ah, 49h
		int	21h		; DOS -	2+ - FREE MEMORY
					; ES = segment address of area to be freed
		pop	es
		pop	ds
		pop	di
		pop	si
		pop	bp
		retf
sub_25FD0	endp

; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		push	si
		push	di
		push	ds
		push	es
		add	bp, 6
		mov	ax, [bp+0]
		mov	es, ax
		mov	bx, [bp+2]
		mov	ah, 4Ah
		int	21h		; DOS -	2+ - ADJUST MEMORY BLOCK SIZE (SETBLOCK)
					; ES = segment address of block	to change
					; BX = new size	in paragraphs
		pop	es
		pop	ds
		pop	di
		pop	si
		pop	bp
		retf
seg014		ends

; ===========================================================================

; Segment type:	Pure code
seg015		segment	byte public 'CODE' use16
		assume cs:seg015
		;org 5
		assume es:nothing, ss:nothing, ds:nothing, fs:nothing, gs:nothing

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_26005	proc far		; CODE XREF: sub_15322P
		push	bp
		mov	bp, sp
		push	si
		push	di
		push	ds
		push	es
		add	bp, 6
		mov	ax, 0A000h
		mov	es, ax
		assume es:nothing
		mov	di, 0
		mov	cx, 7D0h
		xor	ax, ax
		cld
		rep stosw
		pop	es
		assume es:nothing
		pop	ds
		pop	di
		pop	si
		pop	bp
		retf
sub_26005	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_26025	proc far		; CODE XREF: sub_1507C+1D2P
		push	bp
		mov	bp, sp
		push	si
		push	di
		push	ds
		push	es
		add	bp, 6
		mov	ah, 11h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		pop	es
		pop	ds
		pop	di
		pop	si
		pop	bp
		retf
sub_26025	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_26039	proc far		; CODE XREF: sub_1507C+30P
		push	bp
		mov	bp, sp
		push	si
		push	di
		push	ds
		push	es
		add	bp, 6
		mov	ah, 12h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		pop	es
		pop	ds
		pop	di
		pop	si
		pop	bp
		retf
sub_26039	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_2604D	proc far		; CODE XREF: sub_133B4+13P
					; DoEnd0_Yuka+70P ...
		push	bp
		mov	bp, sp
		push	si
		push	di
		push	ds
		push	es
		add	bp, 6
		mov	ah, 0Dh
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		int	0D6h		; used by BASIC	while in interpreter
		mov	es, ax
		mov	byte ptr es:2, 0
		pop	es
		pop	ds
		pop	di
		pop	si
		pop	bp
		retf
sub_2604D	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_2606B	proc far		; CODE XREF: sub_11230+22CP
					; sub_133B4+D7P ...
		push	bp
		mov	bp, sp
		push	si
		push	di
		push	ds
		push	es
		add	bp, 6
		mov	ah, 0Ch
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		int	0D6h		; used by BASIC	while in interpreter
		mov	es, ax
		mov	byte ptr es:2, 1
		pop	es
		pop	ds
		pop	di
		pop	si
		pop	bp
		retf
sub_2606B	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_26089	proc far		; CODE XREF: sub_10828+20CP
					; sub_10828:loc_10A5AP	...
		push	bp
		mov	bp, sp
		push	si
		push	di
		push	ds
		push	es
		add	bp, 6
		mov	ah, 40h	; '@'
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		int	0D6h		; used by BASIC	while in interpreter
		mov	es, ax
		mov	byte ptr es:3, 1
		pop	es
		pop	ds
		pop	di
		pop	si
		pop	bp
		retf
sub_26089	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_260A7	proc far		; CODE XREF: sub_10828+AEP
					; sub_10F06+42P ...
		push	bp
		mov	bp, sp
		push	si
		push	di
		push	ds
		push	es
		add	bp, 6
		mov	ah, 41h	; 'A'
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		int	0D6h		; used by BASIC	while in interpreter
		mov	es, ax
		mov	byte ptr es:3, 0
		pop	es
		pop	ds
		pop	di
		pop	si
		pop	bp
		retf
sub_260A7	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_260C5	proc far		; CODE XREF: sub_10828+5FP
					; sub_10F06+26P ...
		push	bp
		mov	bp, sp
		push	si
		push	di
		push	ds
		push	es
		add	bp, 6
		push	ax

loc_260D0:				; CODE XREF: sub_260C5+18j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		and	al, 2
		push	cx
		mov	cx, 3

loc_260D8:				; CODE XREF: sub_260C5+15j
		jmp	short $+2
		loop	loc_260D8
		pop	cx
		jnz	short loc_260D0
		pop	ax
		mov	al, 8
		out	68h, al
		push	ax

loc_260E5:				; CODE XREF: sub_260C5+2Dj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		and	al, 2
		push	cx
		mov	cx, 3

loc_260ED:				; CODE XREF: sub_260C5+2Aj
		jmp	short $+2
		loop	loc_260ED
		pop	cx
		jnz	short loc_260E5
		pop	ax
		mov	al, 4Bh	; 'K'
		out	0A2h, al	; Interrupt Controller #2, 8259A
		push	ax

loc_260FA:				; CODE XREF: sub_260C5+42j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		and	al, 2
		push	cx
		mov	cx, 3

loc_26102:				; CODE XREF: sub_260C5+3Fj
		jmp	short $+2
		loop	loc_26102
		pop	cx
		jnz	short loc_260FA
		pop	ax
		mov	al, 0
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1
		push	ax

loc_2610F:				; CODE XREF: sub_260C5+57j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		and	al, 2
		push	cx
		mov	cx, 3

loc_26117:				; CODE XREF: sub_260C5+54j
		jmp	short $+2
		loop	loc_26117
		pop	cx
		jnz	short loc_2610F
		pop	ax
		mov	cx, 0
		mov	dx, 0
		push	ax

loc_26126:				; CODE XREF: sub_260C5+6Ej
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		and	al, 2
		push	cx
		mov	cx, 3

loc_2612E:				; CODE XREF: sub_260C5+6Bj
		jmp	short $+2
		loop	loc_2612E
		pop	cx
		jnz	short loc_26126
		pop	ax
		mov	al, cl
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1
		push	ax

loc_2613B:				; CODE XREF: sub_260C5+83j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		and	al, 2
		push	cx
		mov	cx, 3

loc_26143:				; CODE XREF: sub_260C5+80j
		jmp	short $+2
		loop	loc_26143
		pop	cx
		jnz	short loc_2613B
		pop	ax
		mov	al, ch
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1
		push	ax

loc_26150:				; CODE XREF: sub_260C5+98j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		and	al, 2
		push	cx
		mov	cx, 3

loc_26158:				; CODE XREF: sub_260C5+95j
		jmp	short $+2
		loop	loc_26158
		pop	cx
		jnz	short loc_26150
		pop	ax
		mov	al, dl
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1
		push	ax

loc_26165:				; CODE XREF: sub_260C5+ADj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		and	al, 2
		push	cx
		mov	cx, 3

loc_2616D:				; CODE XREF: sub_260C5+AAj
		jmp	short $+2
		loop	loc_2616D
		pop	cx
		jnz	short loc_26165
		pop	ax
		mov	al, dh
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1
		pop	es
		pop	ds
		pop	di
		pop	si
		pop	bp
		retf
sub_260C5	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_2617F	proc far		; CODE XREF: sub_11230+18P
					; sub_15322+6FP
		push	bp
		mov	bp, sp
		push	si
		push	di
		push	ds
		push	es
		add	bp, 6
		push	ax

loc_2618A:				; CODE XREF: sub_2617F+18j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		and	al, 2
		push	cx
		mov	cx, 3

loc_26192:				; CODE XREF: sub_2617F+15j
		jmp	short $+2
		loop	loc_26192
		pop	cx
		jnz	short loc_2618A
		pop	ax
		mov	al, 8
		out	68h, al
		push	ax

loc_2619F:				; CODE XREF: sub_2617F+2Dj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		and	al, 2
		push	cx
		mov	cx, 3

loc_261A7:				; CODE XREF: sub_2617F+2Aj
		jmp	short $+2
		loop	loc_261A7
		pop	cx
		jnz	short loc_2619F
		pop	ax
		mov	al, 4Bh	; 'K'
		out	0A2h, al	; Interrupt Controller #2, 8259A
		push	ax

loc_261B4:				; CODE XREF: sub_2617F+42j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		and	al, 2
		push	cx
		mov	cx, 3

loc_261BC:				; CODE XREF: sub_2617F+3Fj
		jmp	short $+2
		loop	loc_261BC
		pop	cx
		jnz	short loc_261B4
		pop	ax
		mov	al, 1
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1
		mov	cx, 0
		mov	dx, 0
		push	ax

loc_261CF:				; CODE XREF: sub_2617F+5Dj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		and	al, 2
		push	cx
		mov	cx, 3

loc_261D7:				; CODE XREF: sub_2617F+5Aj
		jmp	short $+2
		loop	loc_261D7
		pop	cx
		jnz	short loc_261CF
		pop	ax
		mov	al, cl
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1
		push	ax

loc_261E4:				; CODE XREF: sub_2617F+72j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		and	al, 2
		push	cx
		mov	cx, 3

loc_261EC:				; CODE XREF: sub_2617F+6Fj
		jmp	short $+2
		loop	loc_261EC
		pop	cx
		jnz	short loc_261E4
		pop	ax
		mov	al, ch
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1
		push	ax

loc_261F9:				; CODE XREF: sub_2617F+87j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		and	al, 2
		push	cx
		mov	cx, 3

loc_26201:				; CODE XREF: sub_2617F+84j
		jmp	short $+2
		loop	loc_26201
		pop	cx
		jnz	short loc_261F9
		pop	ax
		mov	al, dl
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1
		push	ax

loc_2620E:				; CODE XREF: sub_2617F+9Cj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		and	al, 2
		push	cx
		mov	cx, 3

loc_26216:				; CODE XREF: sub_2617F+99j
		jmp	short $+2
		loop	loc_26216
		pop	cx
		jnz	short loc_2620E
		pop	ax
		mov	al, dh
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1
		pop	es
		pop	ds
		pop	di
		pop	si
		pop	bp
		retf
sub_2617F	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_26228	proc far		; CODE XREF: sub_11230:loc_11250P
					; sub_15322:loc_15398P
		push	bp
		mov	bp, sp
		push	si
		push	di
		push	ds
		push	es
		add	bp, 6
		push	ax

loc_26233:				; CODE XREF: sub_26228+18j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		and	al, 2
		push	cx
		mov	cx, 3

loc_2623B:				; CODE XREF: sub_26228+15j
		jmp	short $+2
		loop	loc_2623B
		pop	cx
		jnz	short loc_26233
		pop	ax
		mov	al, 8
		out	68h, al
		push	ax

loc_26248:				; CODE XREF: sub_26228+2Dj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		and	al, 2
		push	cx
		mov	cx, 3

loc_26250:				; CODE XREF: sub_26228+2Aj
		jmp	short $+2
		loop	loc_26250
		pop	cx
		jnz	short loc_26248
		pop	ax
		mov	al, 4Bh	; 'K'
		out	0A2h, al	; Interrupt Controller #2, 8259A
		push	ax

loc_2625D:				; CODE XREF: sub_26228+42j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		and	al, 2
		push	cx
		mov	cx, 3

loc_26265:				; CODE XREF: sub_26228+3Fj
		jmp	short $+2
		loop	loc_26265
		pop	cx
		jnz	short loc_2625D
		pop	ax
		mov	al, 2
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1
		mov	cx, 0
		mov	dx, 0
		push	ax

loc_26278:				; CODE XREF: sub_26228+5Dj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		and	al, 2
		push	cx
		mov	cx, 3

loc_26280:				; CODE XREF: sub_26228+5Aj
		jmp	short $+2
		loop	loc_26280
		pop	cx
		jnz	short loc_26278
		pop	ax
		mov	al, cl
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1
		push	ax

loc_2628D:				; CODE XREF: sub_26228+72j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		and	al, 2
		push	cx
		mov	cx, 3

loc_26295:				; CODE XREF: sub_26228+6Fj
		jmp	short $+2
		loop	loc_26295
		pop	cx
		jnz	short loc_2628D
		pop	ax
		mov	al, ch
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1
		push	ax

loc_262A2:				; CODE XREF: sub_26228+87j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		and	al, 2
		push	cx
		mov	cx, 3

loc_262AA:				; CODE XREF: sub_26228+84j
		jmp	short $+2
		loop	loc_262AA
		pop	cx
		jnz	short loc_262A2
		pop	ax
		mov	al, dl
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1
		push	ax

loc_262B7:				; CODE XREF: sub_26228+9Cj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		and	al, 2
		push	cx
		mov	cx, 3

loc_262BF:				; CODE XREF: sub_26228+99j
		jmp	short $+2
		loop	loc_262BF
		pop	cx
		jnz	short loc_262B7
		pop	ax
		mov	al, dh
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1
		pop	es
		pop	ds
		pop	di
		pop	si
		pop	bp
		retf
sub_26228	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_262D1	proc far		; CODE XREF: sub_10828+7EP
					; sub_10828+204P ...

var_0		= word ptr  0

		push	bp
		mov	bp, sp
		push	si
		push	di
		push	ds
		push	es
		add	bp, 6
		mov	ax, [bp+var_0]
		out	0A4h, al	; Interrupt Controller #2, 8259A
		pop	es
		pop	ds
		pop	di
		pop	si
		pop	bp
		retf
sub_262D1	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_262E6	proc far		; CODE XREF: sub_104E6+3EP
					; sub_104E6+F2P ...

var_0		= word ptr  0

		push	bp
		mov	bp, sp
		push	si
		push	di
		push	ds
		push	es
		add	bp, 6
		mov	ax, [bp+var_0]
		out	0A6h, al	; Interrupt Controller #2, 8259A
		pop	es
		pop	ds
		pop	di
		pop	si
		pop	bp
		retf
sub_262E6	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_262FB	proc far		; CODE XREF: sub_15322+AP sub_1539E+5P
		push	bp
		mov	bp, sp
		push	si
		push	di
		push	ds
		push	es
		add	bp, 6
		mov	al, 1
		out	6Ah, al
		pop	es
		pop	ds
		pop	di
		pop	si
		pop	bp
		retf
sub_262FB	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_2630F	proc far		; CODE XREF: sub_10828+17FP
					; sub_10F06+99P ...

var_0		= word ptr  0
arg_0		= word ptr  6
arg_2		= word ptr  8

		push	bp
		mov	bp, sp
		push	si
		push	di
		push	ds
		push	es
		add	bp, 6
		push	ax
		mov	al, 41h	; 'A'
		out	6Ah, al
		pop	ax
		mov	ax, [bp+2]
		mov	ah, 0A0h ; '�'
		mul	ah
		add	ax, [bp+var_0]
		add	ax, [bp+var_0]
		mov	di, ax
		mov	ax, 0A000h
		mov	es, ax
		assume es:nothing
		mov	cx, [bp+arg_0]
		mov	ax, 20h	; ' '
		mov	dx, 5
		cmp	[bp+arg_2], 0
		jnz	short loc_26348
		mov	ax, 20h	; ' '
		mov	dx, 1

loc_26348:				; CODE XREF: sub_2630F+31j
					; sub_2630F+4Cj
		push	cx
		push	di
		mov	cx, [bp+4]

loc_2634D:				; CODE XREF: sub_2630F+44j
		mov	es:[di+2000h], dx
		stosw
		loop	loc_2634D
		pop	di
		add	di, 0A0h ; '�'
		pop	cx
		loop	loc_26348
		pop	es
		assume es:nothing
		pop	ds
		pop	di
		pop	si
		pop	bp
		retf
sub_2630F	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_26363	proc far		; CODE XREF: DoOpening+82P
					; DoCharIntroScr+5AP ...
		push	bp
		mov	bp, sp
		push	si
		push	di
		push	ds
		push	es
		add	bp, 6
		mov	al, 0FFh
		out	7Eh, al
		out	7Eh, al
		out	7Eh, al
		out	7Eh, al
		mov	al, 0
		out	7Ch, al
		xor	ax, ax
		mov	es, ax
		assume es:nothing
		mov	ax, es:54Dh
		mov	cx, 0
		and	ax, 40h
		jz	short loc_263F9
		push	ax
		push	dx
		mov	al, 0C0h ; '�'
		out	7Ch, al
		mov	al, 7
		out	6Ah, al
		mov	al, 5
		out	6Ah, al
		mov	al, 6
		out	6Ah, al
		mov	dx, 4A0h
		mov	ax, 0FFF0h
		out	dx, ax
		mov	dx, 4A2h
		mov	ax, 0FFh
		out	dx, ax
		mov	dx, 4A8h
		mov	ax, 0FFFFh
		out	dx, ax
		mov	dx, 4ACh
		mov	ax, 0
		out	dx, ax
		mov	dx, 4AEh
		mov	ax, 0Fh
		out	dx, ax
		mov	al, 7
		out	6Ah, al
		mov	al, 5
		out	6Ah, al
		mov	al, 6
		out	6Ah, al
		mov	al, 0
		out	7Ch, al
		pop	dx
		pop	ax
		mov	cx, 1
		push	ax
		push	dx
		mov	ax, 0FFF0h
		mov	dx, 4A0h
		out	dx, ax
		mov	ax, 0FFFFh
		mov	dx, 4A8h
		out	dx, ax
		mov	al, 7
		out	6Ah, al
		mov	al, 4
		out	6Ah, al
		cli
		xor	ax, ax
		out	7Ch, al
		sti
		mov	al, 6
		out	6Ah, al
		pop	dx
		pop	ax

loc_263F9:				; CODE XREF: sub_26363+26j
		mov	ds:2176h, cx
		pop	es
		assume es:nothing
		pop	ds
		pop	di
		pop	si
		pop	bp
		retf
sub_26363	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_26403	proc far		; CODE XREF: sub_11230+30P
					; sub_11230+46P ...
		push	bp
		mov	bp, sp
		push	si
		push	di
		push	ds
		push	es
		add	bp, 6
		cld
		mov	al, 0
		out	7Eh, al
		out	7Eh, al
		out	7Eh, al
		out	7Eh, al
		mov	al, 0C0h ; '�'
		out	7Ch, al
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		mov	ax, 0FFFFh
		xor	di, di
		mov	cx, 4000h

loc_26429:				; CODE XREF: sub_26403+27j
		stosw
		loop	loc_26429
		mov	al, 0
		out	7Ch, al
		pop	es
		assume es:nothing
		pop	ds
		pop	di
		pop	si
		pop	bp
		retf
sub_26403	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_26436	proc far		; CODE XREF: sub_16C56+9FP

var_0		= word ptr  0
arg_2		= word ptr  8
arg_4		= word ptr  0Ah
arg_6		= word ptr  0Ch

		push	bp
		mov	bp, sp
		push	si
		push	di
		push	ds
		push	es
		add	bp, 6
		les	di, [bp+4]
		sub	ch, ch
		mov	cl, es:[di]
		inc	di
		mov	cs:byte_26591, 10h
		test	word ptr ds:2210h, 1
		jnz	short loc_2645D
		mov	cs:byte_26591, 1

loc_2645D:				; CODE XREF: sub_26436+1Fj
					; sub_26436:loc_26581j
		push	cx
		sub	ax, ax
		mov	al, es:[di+1]
		and	ax, 0E0h
		shl	ax, 3
		or	al, es:[di+2]
		mov	cs:word_2658A, ax
		sub	ax, ax
		mov	al, es:[di]
		and	al, 1Fh
		mov	cs:word_2658C, ax
		mov	al, es:[di+1]
		and	al, 1Fh
		mov	cs:word_2658E, ax
		mov	al, es:[di]
		shr	al, 4
		shr	al, 2
		and	al, 3
		mov	cs:byte_26590, al
		mov	ax, [bp+arg_2]
		test	ax, 1
		jz	short loc_264B8
		mov	bx, 1Fh
		sub	bx, cs:word_2658C
		mov	cs:word_2658C, bx
		mov	bl, cs:byte_26590
		xor	bl, 1
		mov	cs:byte_26590, bl

loc_264B8:				; CODE XREF: sub_26436+66j
		test	ax, 2
		jz	short loc_264D7
		mov	bx, 1Fh
		sub	bx, cs:word_2658E
		mov	cs:word_2658E, bx
		mov	bl, cs:byte_26590
		xor	bl, 2
		mov	cs:byte_26590, bl

loc_264D7:				; CODE XREF: sub_26436+85j
		mov	ah, cs:byte_26590
		shl	ax, 4
		shl	ax, 2
		sub	al, al
		or	ax, cs:word_2658A
		mov	bx, cs:word_2658C
		sub	bx, 10h
		add	bx, [bp+var_0]
		mov	cs:word_2658C, bx
		mov	cx, cs:word_2658E
		sub	cx, 15h
		shl	cx, 3
		add	cx, [bp+2]
		mov	cs:word_2658E, cx
		mov	dx, cx
		shr	dx, 3
		cmp	dx, 16h
		jz	short loc_26578
		cmp	bx, 0
		jb	short loc_26578
		cmp	cx, 0
		jb	short loc_26578
		cmp	bx, 4Fh	; 'O'
		ja	short loc_26578
		cmp	cx, 0C0h ; '�'
		ja	short loc_26578
		mov	dx, [bp+arg_4]
		push	ds
		push	si
		push	es
		push	di
		cmp	word ptr ds:2176h, 0
		jz	short loc_2653F
		call	sub_270B1
		jmp	short loc_26542
; ---------------------------------------------------------------------------
		db 90h
; ---------------------------------------------------------------------------

loc_2653F:				; CODE XREF: sub_26436+101j
		call	sub_265BE

loc_26542:				; CODE XREF: sub_26436+106j
		mov	ax, [bp+arg_6]
		mov	es, ax
		mov	al, cs:byte_26591
		mov	bx, cs:word_2658E
		shr	bx, 3
		shl	bx, 4
		mov	di, bx
		shl	bx, 2
		add	di, bx
		add	di, cs:word_2658C
		or	es:[di], al
		mov	bx, cs:word_2658E
		test	bx, 7
		jz	short loc_26574
		or	es:[di+50h], al

loc_26574:				; CODE XREF: sub_26436+138j
		pop	di
		pop	es
		pop	si
		pop	ds

loc_26578:				; CODE XREF: sub_26436+DEj
					; sub_26436+E3j ...
		add	di, 3
		pop	cx
		loop	loc_26581
		jmp	short loc_26584
; ---------------------------------------------------------------------------
		db 90h
; ---------------------------------------------------------------------------

loc_26581:				; CODE XREF: sub_26436+146j
		jmp	loc_2645D
; ---------------------------------------------------------------------------

loc_26584:				; CODE XREF: sub_26436+148j
		pop	es
		pop	ds
		pop	di
		pop	si
		pop	bp
		retf
sub_26436	endp

; ---------------------------------------------------------------------------
word_2658A	dw 0			; DATA XREF: sub_26436+38w
					; sub_26436+AEr
word_2658C	dw 0			; DATA XREF: sub_26436+43w
					; sub_26436+6Br ...
word_2658E	dw 0			; DATA XREF: sub_26436+4Dw
					; sub_26436+8Ar ...
byte_26590	db 0			; DATA XREF: sub_26436+5Cw
					; sub_26436+75r ...
byte_26591	db 0			; DATA XREF: sub_26436+13w
					; sub_26436+21w ...
; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		push	si
		push	di
		push	ds
		push	es
		add	bp, 6
		mov	bx, [bp+0]
		mov	cx, [bp+2]
		mov	dx, [bp+4]
		mov	ax, [bp+6]
		cmp	word ptr ds:2176h, 0
		jz	short loc_265B5
		call	sub_270B1
		jmp	short loc_265B8
; ---------------------------------------------------------------------------
		db 90h
; ---------------------------------------------------------------------------

loc_265B5:				; CODE XREF: seg015:05ADj
		call	sub_265BE

loc_265B8:				; CODE XREF: seg015:05B2j
		pop	es
		pop	ds
		pop	di
		pop	si
		pop	bp
		retf

; =============== S U B	R O U T	I N E =======================================


sub_265BE	proc near		; CODE XREF: sub_26436:loc_2653Fp
					; seg015:loc_265B5p
		shl	bx, 1
		mov	ds, dx
		shl	cx, 1
		shl	cx, 1
		shl	cx, 1
		shl	cx, 1
		shl	cx, 1
		add	bx, cx
		shl	cx, 1
		shl	cx, 1
		add	bx, cx
		mov	dx, bx
		push	ax
		and	ax, 0FFFh
		mov	cx, 5
		push	dx
		mul	cx
		pop	dx
		mov	cx, ax
		mov	ax, ds
		add	ax, cx
		mov	ds, ax
		mov	si, 0
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		pop	ax
		test	ax, 8000h
		jz	short loc_265FA
		jmp	loc_26B48
; ---------------------------------------------------------------------------

loc_265FA:				; CODE XREF: sub_265BE+37j
		test	ax, 4000h
		jz	short loc_26602
		jmp	loc_26703
; ---------------------------------------------------------------------------

loc_26602:				; CODE XREF: sub_265BE+3Fj
		mov	al, 0
		out	7Eh, al
		out	7Eh, al
		out	7Eh, al
		out	7Eh, al
		mov	al, 0C0h ; '�'
		out	7Ch, al
		mov	di, dx
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		mov	al, 0FFh
		out	7Eh, al
		out	7Eh, al
		out	7Eh, al
		out	7Eh, al
		mov	al, 0CEh ; '�'
		out	7Ch, al
		mov	di, dx
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		mov	al, 0CDh ; '�'
		out	7Ch, al
		mov	di, dx
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		mov	al, 0CBh ; '�'
		out	7Ch, al
		mov	di, dx
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		mov	al, 0C7h ; '�'
		out	7Ch, al
		mov	di, dx
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		mov	al, 0
		out	7Ch, al
		jmp	loc_270AB
; ---------------------------------------------------------------------------

loc_26703:				; CODE XREF: sub_265BE+41j
		mov	al, 0
		out	7Eh, al
		out	7Eh, al
		out	7Eh, al
		out	7Eh, al
		mov	al, 0C0h ; '�'
		out	7Ch, al
		mov	di, dx
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		mov	al, 0FFh
		out	7Eh, al
		out	7Eh, al
		out	7Eh, al
		out	7Eh, al
		mov	al, 0CEh ; '�'
		out	7Ch, al
		mov	di, dx
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		mov	al, 0CDh ; '�'
		out	7Ch, al
		mov	di, dx
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		mov	al, 0CBh ; '�'
		out	7Ch, al
		mov	di, dx
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		mov	di, dx
		mov	al, 0C7h ; '�'
		out	7Ch, al
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		jmp	loc_270AB
; ---------------------------------------------------------------------------

loc_26B48:				; CODE XREF: sub_265BE+39j
		std
		add	si, 0Eh
		test	ax, 4000h
		jz	short loc_26B54
		jmp	loc_26C5D
; ---------------------------------------------------------------------------

loc_26B54:				; CODE XREF: sub_265BE+591j
		mov	al, 0
		out	7Eh, al
		out	7Eh, al
		out	7Eh, al
		out	7Eh, al
		mov	al, 0C0h ; '�'
		out	7Ch, al
		mov	di, dx
		movsw
		add	di, 0A2h ; '�'
		movsw
		add	di, 0A2h ; '�'
		movsw
		add	di, 0A2h ; '�'
		movsw
		add	di, 0A2h ; '�'
		movsw
		add	di, 0A2h ; '�'
		movsw
		add	di, 0A2h ; '�'
		movsw
		add	di, 0A2h ; '�'
		movsw
		add	di, 0A2h ; '�'
		add	si, 20h	; ' '
		mov	al, 0FFh
		out	7Eh, al
		out	7Eh, al
		out	7Eh, al
		out	7Eh, al
		mov	al, 0CEh ; '�'
		out	7Ch, al
		mov	di, dx
		movsw
		add	di, 0A2h ; '�'
		movsw
		add	di, 0A2h ; '�'
		movsw
		add	di, 0A2h ; '�'
		movsw
		add	di, 0A2h ; '�'
		movsw
		add	di, 0A2h ; '�'
		movsw
		add	di, 0A2h ; '�'
		movsw
		add	di, 0A2h ; '�'
		movsw
		add	di, 0A2h ; '�'
		add	si, 20h	; ' '
		mov	al, 0CDh ; '�'
		out	7Ch, al
		mov	di, dx
		movsw
		add	di, 0A2h ; '�'
		movsw
		add	di, 0A2h ; '�'
		movsw
		add	di, 0A2h ; '�'
		movsw
		add	di, 0A2h ; '�'
		movsw
		add	di, 0A2h ; '�'
		movsw
		add	di, 0A2h ; '�'
		movsw
		add	di, 0A2h ; '�'
		movsw
		add	di, 0A2h ; '�'
		add	si, 20h	; ' '
		mov	al, 0CBh ; '�'
		out	7Ch, al
		mov	di, dx
		movsw
		add	di, 0A2h ; '�'
		movsw
		add	di, 0A2h ; '�'
		movsw
		add	di, 0A2h ; '�'
		movsw
		add	di, 0A2h ; '�'
		movsw
		add	di, 0A2h ; '�'
		movsw
		add	di, 0A2h ; '�'
		movsw
		add	di, 0A2h ; '�'
		movsw
		add	di, 0A2h ; '�'
		add	si, 20h	; ' '
		mov	al, 0C7h ; '�'
		out	7Ch, al
		mov	di, dx
		movsw
		add	di, 0A2h ; '�'
		movsw
		add	di, 0A2h ; '�'
		movsw
		add	di, 0A2h ; '�'
		movsw
		add	di, 0A2h ; '�'
		movsw
		add	di, 0A2h ; '�'
		movsw
		add	di, 0A2h ; '�'
		movsw
		add	di, 0A2h ; '�'
		movsw
		add	di, 0A2h ; '�'
		jmp	loc_270AB
; ---------------------------------------------------------------------------

loc_26C5D:				; CODE XREF: sub_265BE+593j
		mov	al, 0
		out	7Eh, al
		out	7Eh, al
		out	7Eh, al
		out	7Eh, al
		mov	al, 0C0h ; '�'
		out	7Ch, al
		mov	di, dx
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		add	si, 20h	; ' '
		mov	al, 0FFh
		out	7Eh, al
		out	7Eh, al
		out	7Eh, al
		out	7Eh, al
		mov	al, 0CEh ; '�'
		out	7Ch, al
		mov	di, dx
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		add	si, 20h	; ' '
		mov	al, 0CDh ; '�'
		out	7Ch, al
		mov	di, dx
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		add	si, 20h	; ' '
		mov	al, 0CBh ; '�'
		out	7Ch, al
		mov	di, dx
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		add	si, 20h	; ' '
		mov	al, 0C7h ; '�'
		out	7Ch, al
		mov	di, dx
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'

loc_270AB:				; CODE XREF: sub_265BE+142j
					; sub_265BE+587j ...
		mov	al, 0
		out	7Ch, al
		cld
		retn
sub_265BE	endp


; =============== S U B	R O U T	I N E =======================================


sub_270B1	proc near		; CODE XREF: sub_26436+103p
					; seg015:05AFp
		shl	bx, 1
		mov	ds, dx
		shl	cx, 1
		shl	cx, 1
		shl	cx, 1
		shl	cx, 1
		shl	cx, 1
		add	bx, cx
		shl	cx, 1
		shl	cx, 1
		add	bx, cx
		mov	dx, bx
		push	ax
		and	ax, 0FFFh
		mov	cx, 5
		push	dx
		mul	cx
		pop	dx
		mov	cx, ax
		mov	ax, ds
		add	ax, cx
		mov	ds, ax
		mov	si, 0
		mov	ax, 0A800h
		mov	es, ax
		pop	ax
		push	ax
		mov	al, 7
		out	6Ah, al
		mov	al, 5
		out	6Ah, al
		cli
		mov	al, 0C0h ; '�'
		out	7Ch, al
		sti
		mov	al, 6
		out	6Ah, al
		pop	ax
		test	ax, 8000h
		jz	short loc_27101
		jmp	loc_27679
; ---------------------------------------------------------------------------

loc_27101:				; CODE XREF: sub_270B1+4Bj
		test	ax, 4000h
		jz	short loc_27109
		jmp	loc_2721D
; ---------------------------------------------------------------------------

loc_27109:				; CODE XREF: sub_270B1+53j
		mov	di, dx
		push	dx
		push	ax
		mov	dx, 4A4h
		mov	ax, 0C0Ch
		out	dx, ax
		mov	dx, 4A0h
		mov	ax, 0FFF0h
		out	dx, ax
		pop	ax
		pop	dx
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		push	dx
		mov	dx, 4A4h
		mov	ax, 0CFCh
		out	dx, ax
		pop	dx
		mov	di, dx
		push	dx
		mov	dx, 4A0h
		mov	ax, 0FFFEh
		out	dx, ax
		pop	dx
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		mov	di, dx
		push	dx
		mov	dx, 4A0h
		mov	ax, 0FFFDh
		out	dx, ax
		pop	dx
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		mov	di, dx
		push	dx
		mov	dx, 4A0h
		mov	ax, 0FFFBh
		out	dx, ax
		pop	dx
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		mov	di, dx
		push	dx
		mov	dx, 4A0h
		mov	ax, 0FFF7h
		out	dx, ax
		pop	dx
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		jmp	loc_27C10
; ---------------------------------------------------------------------------

loc_2721D:				; CODE XREF: sub_270B1+55j
		push	dx
		push	ax
		mov	dx, 4A4h
		mov	ax, 0C0Ch
		out	dx, ax
		mov	dx, 4A0h
		mov	ax, 0FFF0h
		out	dx, ax
		pop	ax
		pop	dx
		mov	di, dx
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		push	dx
		mov	dx, 4A4h
		mov	ax, 0CFCh
		out	dx, ax
		pop	dx
		push	dx
		mov	dx, 4A0h
		mov	ax, 0FFFEh
		out	dx, ax
		pop	dx
		mov	di, dx
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		push	dx
		mov	dx, 4A0h
		mov	ax, 0FFFDh
		out	dx, ax
		pop	dx
		mov	di, dx
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		push	dx
		mov	dx, 4A0h
		mov	ax, 0FFFBh
		out	dx, ax
		pop	dx
		mov	di, dx
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		push	dx
		mov	dx, 4A0h
		mov	ax, 0FFF7h
		out	dx, ax
		pop	dx
		mov	di, dx
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+1D4Ah]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+1D4Ah]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		jmp	loc_27C10
; ---------------------------------------------------------------------------

loc_27679:				; CODE XREF: sub_270B1+4Dj
		std
		add	si, 0Eh
		test	ax, 4000h
		jz	short loc_27685
		jmp	loc_277A8
; ---------------------------------------------------------------------------

loc_27685:				; CODE XREF: sub_270B1+5CFj
		mov	di, dx
		push	dx
		push	ax
		mov	dx, 4A4h
		mov	ax, 0C0Ch
		out	dx, ax
		mov	dx, 4A0h
		mov	ax, 0FFF0h
		out	dx, ax
		pop	ax
		pop	dx
		movsw
		add	di, 0A2h ; '�'
		movsw
		add	di, 0A2h ; '�'
		movsw
		add	di, 0A2h ; '�'
		movsw
		add	di, 0A2h ; '�'
		movsw
		add	di, 0A2h ; '�'
		movsw
		add	di, 0A2h ; '�'
		movsw
		add	di, 0A2h ; '�'
		movsw
		add	di, 0A2h ; '�'
		add	si, 20h	; ' '
		push	dx
		mov	dx, 4A4h
		mov	ax, 0CFCh
		out	dx, ax
		pop	dx
		mov	di, dx
		push	dx
		mov	dx, 4A0h
		mov	ax, 0FFFEh
		out	dx, ax
		pop	dx
		movsw
		add	di, 0A2h ; '�'
		movsw
		add	di, 0A2h ; '�'
		movsw
		add	di, 0A2h ; '�'
		movsw
		add	di, 0A2h ; '�'
		movsw
		add	di, 0A2h ; '�'
		movsw
		add	di, 0A2h ; '�'
		movsw
		add	di, 0A2h ; '�'
		movsw
		add	di, 0A2h ; '�'
		add	si, 20h	; ' '
		mov	di, dx
		push	dx
		mov	dx, 4A0h
		mov	ax, 0FFFDh
		out	dx, ax
		pop	dx
		movsw
		add	di, 0A2h ; '�'
		movsw
		add	di, 0A2h ; '�'
		movsw
		add	di, 0A2h ; '�'
		movsw
		add	di, 0A2h ; '�'
		movsw
		add	di, 0A2h ; '�'
		movsw
		add	di, 0A2h ; '�'
		movsw
		add	di, 0A2h ; '�'
		movsw
		add	di, 0A2h ; '�'
		add	si, 20h	; ' '
		mov	di, dx
		push	dx
		mov	dx, 4A0h
		mov	ax, 0FFFBh
		out	dx, ax
		pop	dx
		movsw
		add	di, 0A2h ; '�'
		movsw
		add	di, 0A2h ; '�'
		movsw
		add	di, 0A2h ; '�'
		movsw
		add	di, 0A2h ; '�'
		movsw
		add	di, 0A2h ; '�'
		movsw
		add	di, 0A2h ; '�'
		movsw
		add	di, 0A2h ; '�'
		movsw
		add	di, 0A2h ; '�'
		add	si, 20h	; ' '
		mov	di, dx
		push	dx
		mov	dx, 4A0h
		mov	ax, 0FFF7h
		out	dx, ax
		pop	dx
		movsw
		add	di, 0A2h ; '�'
		movsw
		add	di, 0A2h ; '�'
		movsw
		add	di, 0A2h ; '�'
		movsw
		add	di, 0A2h ; '�'
		movsw
		add	di, 0A2h ; '�'
		movsw
		add	di, 0A2h ; '�'
		movsw
		add	di, 0A2h ; '�'
		movsw
		add	di, 0A2h ; '�'
		add	si, 20h	; ' '
		jmp	loc_27C10
; ---------------------------------------------------------------------------

loc_277A8:				; CODE XREF: sub_270B1+5D1j
		mov	di, dx
		push	dx
		push	ax
		mov	dx, 4A4h
		mov	ax, 0C0Ch
		out	dx, ax
		mov	dx, 4A0h
		mov	ax, 0FFF0h
		out	dx, ax
		pop	ax
		pop	dx
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:byte_27D4A[bx]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:byte_27D4A[bx]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:byte_27D4A[bx]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:byte_27D4A[bx]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:byte_27D4A[bx]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:byte_27D4A[bx]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:byte_27D4A[bx]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:byte_27D4A[bx]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:byte_27D4A[bx]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:byte_27D4A[bx]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:byte_27D4A[bx]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:byte_27D4A[bx]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:byte_27D4A[bx]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:byte_27D4A[bx]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:byte_27D4A[bx]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:byte_27D4A[bx]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		add	si, 20h	; ' '
		push	dx
		mov	dx, 4A4h
		mov	ax, 0CFCh
		out	dx, ax
		pop	dx
		mov	di, dx
		push	dx
		mov	dx, 4A0h
		mov	ax, 0FFFEh
		out	dx, ax
		pop	dx
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:byte_27D4A[bx]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:byte_27D4A[bx]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:byte_27D4A[bx]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:byte_27D4A[bx]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:byte_27D4A[bx]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:byte_27D4A[bx]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:byte_27D4A[bx]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:byte_27D4A[bx]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:byte_27D4A[bx]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:byte_27D4A[bx]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:byte_27D4A[bx]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:byte_27D4A[bx]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:byte_27D4A[bx]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:byte_27D4A[bx]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:byte_27D4A[bx]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:byte_27D4A[bx]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		add	si, 20h	; ' '
		mov	di, dx
		push	dx
		mov	dx, 4A0h
		mov	ax, 0FFFDh
		out	dx, ax
		pop	dx
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:byte_27D4A[bx]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:byte_27D4A[bx]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:byte_27D4A[bx]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:byte_27D4A[bx]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:byte_27D4A[bx]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:byte_27D4A[bx]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:byte_27D4A[bx]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:byte_27D4A[bx]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:byte_27D4A[bx]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:byte_27D4A[bx]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:byte_27D4A[bx]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:byte_27D4A[bx]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:byte_27D4A[bx]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:byte_27D4A[bx]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:byte_27D4A[bx]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:byte_27D4A[bx]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		add	si, 20h	; ' '
		mov	di, dx
		push	dx
		mov	dx, 4A0h
		mov	ax, 0FFFBh
		out	dx, ax
		pop	dx
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:byte_27D4A[bx]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:byte_27D4A[bx]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:byte_27D4A[bx]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:byte_27D4A[bx]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:byte_27D4A[bx]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:byte_27D4A[bx]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:byte_27D4A[bx]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:byte_27D4A[bx]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:byte_27D4A[bx]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:byte_27D4A[bx]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:byte_27D4A[bx]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:byte_27D4A[bx]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:byte_27D4A[bx]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:byte_27D4A[bx]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:byte_27D4A[bx]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:byte_27D4A[bx]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		add	si, 20h	; ' '
		mov	di, dx
		push	dx
		mov	dx, 4A0h
		mov	ax, 0FFF7h
		out	dx, ax
		pop	dx
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:byte_27D4A[bx]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:byte_27D4A[bx]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:byte_27D4A[bx]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:byte_27D4A[bx]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:byte_27D4A[bx]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:byte_27D4A[bx]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:byte_27D4A[bx]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:byte_27D4A[bx]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:byte_27D4A[bx]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:byte_27D4A[bx]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:byte_27D4A[bx]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:byte_27D4A[bx]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:byte_27D4A[bx]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:byte_27D4A[bx]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:byte_27D4A[bx]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:byte_27D4A[bx]
		mov	es:[di], cx
		add	di, 0A0h ; '�'
		add	si, 20h	; ' '

loc_27C10:				; CODE XREF: sub_270B1+169j
					; sub_270B1+5C5j ...
		push	ax
		push	dx
		mov	ax, 0FFF0h
		mov	dx, 4A0h
		out	dx, ax
		mov	ax, 0FFFFh
		mov	dx, 4A8h
		out	dx, ax
		mov	al, 7
		out	6Ah, al
		mov	al, 4
		out	6Ah, al
		cli
		xor	ax, ax
		out	7Ch, al
		sti
		mov	al, 6
		out	6Ah, al
		pop	dx
		pop	ax
		cld
		retn
sub_270B1	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_27C36	proc far		; CODE XREF: sub_16078+65P
					; sub_16184+79P ...

var_0		= word ptr  0
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		push	di
		push	ds
		push	es
		add	bp, 6
		mov	bx, [bp+var_0]
		mov	cx, [bp+2]
		mov	dx, [bp+4]
		mov	ax, [bp+arg_0]
		call	sub_27C57
		pop	es
		assume es:nothing
		pop	ds
		pop	di
		pop	si
		pop	bp
		retf
sub_27C36	endp


; =============== S U B	R O U T	I N E =======================================


sub_27C57	proc far		; CODE XREF: sub_27C36+16P
		shl	bx, 1
		mov	ds, dx
		shl	cx, 1
		shl	cx, 1
		shl	cx, 1
		shl	cx, 1
		shl	cx, 1
		shl	cx, 1
		shl	cx, 1
		shl	cx, 1
		add	bx, cx
		shl	cx, 1
		shl	cx, 1
		add	bx, cx
		mov	dx, bx
		push	ax
		and	ax, 3FFFh
		mov	cx, ax
		shl	cx, 1
		shl	cx, 1
		mov	ax, ds
		add	ax, cx
		mov	ds, ax
		mov	si, 0
		pop	ax
		mov	al, 0
		out	7Ch, al
		mov	di, dx
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		mov	di, dx
		mov	ax, 0B000h
		mov	es, ax
		assume es:nothing
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		mov	di, dx
		mov	ax, 0B800h
		mov	es, ax
		assume es:nothing
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		mov	di, dx
		mov	ax, 0E000h
		mov	es, ax
		assume es:nothing
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		movsw
		add	di, 9Eh	; '�'
		retf
sub_27C57	endp

; ---------------------------------------------------------------------------
byte_27D4A	db  00h, 80h, 40h,0C0h,	20h,0A0h, 60h,0E0h ; DATA XREF:	sub_270B1+710r
					; sub_270B1+719r ...
		db  10h, 90h, 50h,0D0h,	30h,0B0h, 70h,0F0h
		db  08h, 88h, 48h,0C8h,	28h,0A8h, 68h,0E8h
		db  18h, 98h, 58h,0D8h,	38h,0B8h, 78h,0F8h
		db  04h, 84h, 44h,0C4h,	24h,0A4h, 64h,0E4h
		db  14h, 94h, 54h,0D4h,	34h,0B4h, 74h,0F4h
		db  0Ch, 8Ch, 4Ch,0CCh,	2Ch,0ACh, 6Ch,0ECh
		db  1Ch, 9Ch, 5Ch,0DCh,	3Ch,0BCh, 7Ch,0FCh
		db  02h, 82h, 42h,0C2h,	22h,0A2h, 62h,0E2h
		db  12h, 92h, 52h,0D2h,	32h,0B2h, 72h,0F2h
		db  0Ah, 8Ah, 4Ah,0CAh,	2Ah,0AAh, 6Ah,0EAh
		db  1Ah, 9Ah, 5Ah,0DAh,	3Ah,0BAh, 7Ah,0FAh
		db  06h, 86h, 46h,0C6h,	26h,0A6h, 66h,0E6h
		db  16h, 96h, 56h,0D6h,	36h,0B6h, 76h,0F6h
		db  0Eh, 8Eh, 4Eh,0CEh,	2Eh,0AEh, 6Eh,0EEh
		db  1Eh, 9Eh, 5Eh,0DEh,	3Eh,0BEh, 7Eh,0FEh
		db  01h, 81h, 41h,0C1h,	21h,0A1h, 61h,0E1h
		db  11h, 91h, 51h,0D1h,	31h,0B1h, 71h,0F1h
		db  09h, 89h, 49h,0C9h,	29h,0A9h, 69h,0E9h
		db  19h, 99h, 59h,0D9h,	39h,0B9h, 79h,0F9h
		db  05h, 85h, 45h,0C5h,	25h,0A5h, 65h,0E5h
		db  15h, 95h, 55h,0D5h,	35h,0B5h, 75h,0F5h
		db  0Dh, 8Dh, 4Dh,0CDh,	2Dh,0ADh, 6Dh,0EDh
		db  1Dh, 9Dh, 5Dh,0DDh,	3Dh,0BDh, 7Dh,0FDh
		db  03h, 83h, 43h,0C3h,	23h,0A3h, 63h,0E3h
		db  13h, 93h, 53h,0D3h,	33h,0B3h, 73h,0F3h
		db  0Bh, 8Bh, 4Bh,0CBh,	2Bh,0ABh, 6Bh,0EBh
		db  1Bh, 9Bh, 5Bh,0DBh,	3Bh,0BBh, 7Bh,0FBh
		db  07h, 87h, 47h,0C7h,	27h,0A7h, 67h,0E7h
		db  17h, 97h, 57h,0D7h,	37h,0B7h, 77h,0F7h
		db  0Fh, 8Fh, 4Fh,0CFh,	2Fh,0AFh, 6Fh,0EFh
		db  1Fh, 9Fh, 5Fh,0DFh,	3Fh,0BFh, 7Fh,0FFh

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_27E4A	proc far		; CODE XREF: sub_16D2E+B9P

var_0		= word ptr  0
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		push	di
		push	ds
		push	es
		add	bp, 6
		mov	bx, [bp+var_0]
		mov	cx, [bp+2]
		mov	dx, [bp+4]
		mov	ax, [bp+arg_0]
		cmp	word ptr ds:2176h, 0
		jz	short loc_27E6D
		call	sub_288C7
		jmp	short loc_27E70
; ---------------------------------------------------------------------------
		nop

loc_27E6D:				; CODE XREF: sub_27E4A+1Bj
		call	sub_27E76

loc_27E70:				; CODE XREF: sub_27E4A+20j
		pop	es
		assume es:nothing
		pop	ds
		pop	di
		pop	si
		pop	bp
		retf
sub_27E4A	endp


; =============== S U B	R O U T	I N E =======================================


sub_27E76	proc near		; CODE XREF: sub_27E4A:loc_27E6Dp
		shl	bx, 1
		mov	ds, dx
		shl	cx, 1
		shl	cx, 1
		shl	cx, 1
		shl	cx, 1
		add	bx, cx
		shl	cx, 1
		shl	cx, 1
		add	bx, cx
		mov	dx, bx
		push	ax
		and	ax, 0FFFh
		mov	cx, 5
		push	dx
		mul	cx
		pop	dx
		mov	cx, ax
		mov	ax, ds
		add	ax, cx
		mov	ds, ax
		mov	si, 0
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		pop	ax
		test	ax, 8000h
		jz	short loc_27EB0
		jmp	loc_283AE
; ---------------------------------------------------------------------------

loc_27EB0:				; CODE XREF: sub_27E76+35j
		test	ax, 4000h
		jz	short loc_27EB8
		jmp	loc_27F91
; ---------------------------------------------------------------------------

loc_27EB8:				; CODE XREF: sub_27E76+3Dj
		mov	al, 0
		out	7Eh, al
		out	7Eh, al
		out	7Eh, al
		out	7Eh, al
		mov	al, 0C0h ; '�'
		out	7Ch, al
		mov	di, dx
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		mov	al, 0FFh
		out	7Eh, al
		out	7Eh, al
		out	7Eh, al
		out	7Eh, al
		mov	al, 0CEh ; '�'
		out	7Ch, al
		mov	di, dx
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		mov	al, 0CDh ; '�'
		out	7Ch, al
		mov	di, dx
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		mov	al, 0CBh ; '�'
		out	7Ch, al
		mov	di, dx
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		mov	al, 0C7h ; '�'
		out	7Ch, al
		mov	di, dx
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		mov	al, 0
		out	7Ch, al
		jmp	loc_288C1
; ---------------------------------------------------------------------------

loc_27F91:				; CODE XREF: sub_27E76+3Fj
		mov	al, 0
		out	7Eh, al
		out	7Eh, al
		out	7Eh, al
		out	7Eh, al
		mov	al, 0C0h ; '�'
		out	7Ch, al
		mov	di, dx
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		mov	al, 0FFh
		out	7Eh, al
		out	7Eh, al
		out	7Eh, al
		out	7Eh, al
		mov	al, 0CEh ; '�'
		out	7Ch, al
		mov	di, dx
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		mov	al, 0CDh ; '�'
		out	7Ch, al
		mov	di, dx
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		mov	al, 0CBh ; '�'
		out	7Ch, al
		mov	di, dx
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		mov	al, 0C7h ; '�'
		out	7Ch, al
		mov	di, dx
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:byte_294C4[bx]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		jmp	loc_288C1
; ---------------------------------------------------------------------------

loc_283AE:				; CODE XREF: sub_27E76+37j
		std
		add	si, 0Eh
		test	ax, 4000h
		jz	short loc_283BA
		jmp	loc_2849B
; ---------------------------------------------------------------------------

loc_283BA:				; CODE XREF: sub_27E76+53Fj
		mov	al, 0
		out	7Eh, al
		out	7Eh, al
		out	7Eh, al
		out	7Eh, al
		mov	al, 0C0h ; '�'
		out	7Ch, al
		mov	di, dx
		movsw
		add	di, 52h	; 'R'
		movsw
		add	di, 52h	; 'R'
		movsw
		add	di, 52h	; 'R'
		movsw
		add	di, 52h	; 'R'
		movsw
		add	di, 52h	; 'R'
		movsw
		add	di, 52h	; 'R'
		movsw
		add	di, 52h	; 'R'
		movsw
		add	di, 52h	; 'R'
		add	si, 20h	; ' '
		mov	al, 0FFh
		out	7Eh, al
		out	7Eh, al
		out	7Eh, al
		out	7Eh, al
		mov	al, 0CEh ; '�'
		out	7Ch, al
		mov	di, dx
		movsw
		add	di, 52h	; 'R'
		movsw
		add	di, 52h	; 'R'
		movsw
		add	di, 52h	; 'R'
		movsw
		add	di, 52h	; 'R'
		movsw
		add	di, 52h	; 'R'
		movsw
		add	di, 52h	; 'R'
		movsw
		add	di, 52h	; 'R'
		movsw
		add	di, 52h	; 'R'
		add	si, 20h	; ' '
		mov	al, 0CDh ; '�'
		out	7Ch, al
		mov	di, dx
		movsw
		add	di, 52h	; 'R'
		movsw
		add	di, 52h	; 'R'
		movsw
		add	di, 52h	; 'R'
		movsw
		add	di, 52h	; 'R'
		movsw
		add	di, 52h	; 'R'
		movsw
		add	di, 52h	; 'R'
		movsw
		add	di, 52h	; 'R'
		movsw
		add	di, 52h	; 'R'
		add	si, 20h	; ' '
		mov	al, 0CBh ; '�'
		out	7Ch, al
		mov	di, dx
		movsw
		add	di, 52h	; 'R'
		movsw
		add	di, 52h	; 'R'
		movsw
		add	di, 52h	; 'R'
		movsw
		add	di, 52h	; 'R'
		movsw
		add	di, 52h	; 'R'
		movsw
		add	di, 52h	; 'R'
		movsw
		add	di, 52h	; 'R'
		movsw
		add	di, 52h	; 'R'
		add	si, 20h	; ' '
		mov	al, 0C7h ; '�'
		out	7Ch, al
		mov	di, dx
		movsw
		add	di, 52h	; 'R'
		movsw
		add	di, 52h	; 'R'
		movsw
		add	di, 52h	; 'R'
		movsw
		add	di, 52h	; 'R'
		movsw
		add	di, 52h	; 'R'
		movsw
		add	di, 52h	; 'R'
		movsw
		add	di, 52h	; 'R'
		movsw
		add	di, 52h	; 'R'
		jmp	loc_288C1
; ---------------------------------------------------------------------------

loc_2849B:				; CODE XREF: sub_27E76+541j
		mov	al, 0
		out	7Eh, al
		out	7Eh, al
		out	7Eh, al
		out	7Eh, al
		mov	al, 0C0h ; '�'
		out	7Ch, al
		mov	di, dx
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		add	si, 20h	; ' '
		mov	al, 0FFh
		out	7Eh, al
		out	7Eh, al
		out	7Eh, al
		out	7Eh, al
		mov	al, 0CEh ; '�'
		out	7Ch, al
		mov	di, dx
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		add	si, 20h	; ' '
		mov	al, 0CDh ; '�'
		out	7Ch, al
		mov	di, dx
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		add	si, 20h	; ' '
		mov	al, 0CBh ; '�'
		out	7Ch, al
		mov	di, dx
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		add	si, 20h	; ' '
		mov	al, 0C7h ; '�'
		out	7Ch, al
		mov	di, dx
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'

loc_288C1:				; CODE XREF: sub_27E76+118j
					; sub_27E76+535j ...
		mov	al, 0
		out	7Ch, al
		cld
		retn
sub_27E76	endp


; =============== S U B	R O U T	I N E =======================================


sub_288C7	proc near		; CODE XREF: sub_27E4A+1Dp
		shl	bx, 1
		mov	ds, dx
		shl	cx, 1
		shl	cx, 1
		shl	cx, 1
		shl	cx, 1
		add	bx, cx
		shl	cx, 1
		shl	cx, 1
		add	bx, cx
		mov	dx, bx
		push	ax
		and	ax, 0FFFh
		mov	cx, 5
		push	dx
		mul	cx
		pop	dx
		mov	cx, ax
		mov	ax, ds
		add	ax, cx
		mov	ds, ax
		mov	si, 0
		mov	ax, 0A800h
		mov	es, ax
		pop	ax
		push	ax
		mov	al, 7
		out	6Ah, al
		mov	al, 5
		out	6Ah, al
		cli
		mov	al, 0C0h ; '�'
		out	7Ch, al
		sti
		mov	al, 6
		out	6Ah, al
		pop	ax
		test	ax, 8000h
		jz	short loc_28915
		jmp	loc_28E51
; ---------------------------------------------------------------------------

loc_28915:				; CODE XREF: sub_288C7+49j
		test	ax, 4000h
		jz	short loc_2891D
		jmp	loc_28A13
; ---------------------------------------------------------------------------

loc_2891D:				; CODE XREF: sub_288C7+51j
		mov	di, dx
		push	dx
		push	ax
		mov	dx, 4A4h
		mov	ax, 0C0Ch
		out	dx, ax
		mov	dx, 4A0h
		mov	ax, 0FFF0h
		out	dx, ax
		pop	ax
		pop	dx
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		push	dx
		push	ax
		mov	dx, 4A4h
		mov	ax, 0CFCh
		out	dx, ax
		pop	ax
		pop	dx
		mov	di, dx
		push	dx
		push	ax
		mov	dx, 4A0h
		mov	ax, 0FFFEh
		out	dx, ax
		pop	ax
		pop	dx
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		mov	di, dx
		push	dx
		push	ax
		mov	dx, 4A0h
		mov	ax, 0FFFDh
		out	dx, ax
		pop	ax
		pop	dx
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		mov	di, dx
		push	dx
		push	ax
		mov	dx, 4A0h
		mov	ax, 0FFFBh
		out	dx, ax
		pop	ax
		pop	dx
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		mov	di, dx
		push	dx
		push	ax
		mov	dx, 4A0h
		mov	ax, 0FFF7h
		out	dx, ax
		pop	ax
		pop	dx
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		jmp	loc_293AC
; ---------------------------------------------------------------------------

loc_28A13:				; CODE XREF: sub_288C7+53j
		push	dx
		push	ax
		mov	dx, 4A4h
		mov	ax, 0C0Ch
		out	dx, ax
		mov	dx, 4A0h
		mov	ax, 0FFF0h
		out	dx, ax
		pop	ax
		pop	dx
		mov	di, dx
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		push	dx
		push	ax
		mov	dx, 4A4h
		mov	ax, 0CFCh
		out	dx, ax
		pop	ax
		pop	dx
		push	dx
		push	ax
		mov	dx, 4A0h
		mov	ax, 0FFFEh
		out	dx, ax
		pop	ax
		pop	dx
		mov	di, dx
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		push	dx
		push	ax
		mov	dx, 4A0h
		mov	ax, 0FFFDh
		out	dx, ax
		pop	ax
		pop	dx
		mov	di, dx
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		push	dx
		push	ax
		mov	dx, 4A0h
		mov	ax, 0FFFBh
		out	dx, ax
		pop	ax
		pop	dx
		mov	di, dx
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		push	dx
		push	ax
		mov	dx, 4A0h
		mov	ax, 0FFF7h
		out	dx, ax
		pop	ax
		pop	dx
		mov	di, dx
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		jmp	loc_293AC
; ---------------------------------------------------------------------------

loc_28E51:				; CODE XREF: sub_288C7+4Bj
		std
		add	si, 0Eh
		test	ax, 4000h
		jz	short loc_28E5D
		jmp	loc_28F62
; ---------------------------------------------------------------------------

loc_28E5D:				; CODE XREF: sub_288C7+591j
		mov	di, dx
		push	dx
		push	ax
		mov	dx, 4A4h
		mov	ax, 0C0Ch
		out	dx, ax
		mov	dx, 4A0h
		mov	ax, 0FFF0h
		out	dx, ax
		pop	ax
		pop	dx
		movsw
		add	di, 52h	; 'R'
		movsw
		add	di, 52h	; 'R'
		movsw
		add	di, 52h	; 'R'
		movsw
		add	di, 52h	; 'R'
		movsw
		add	di, 52h	; 'R'
		movsw
		add	di, 52h	; 'R'
		movsw
		add	di, 52h	; 'R'
		movsw
		add	di, 52h	; 'R'
		add	si, 20h	; ' '
		push	dx
		push	ax
		mov	dx, 4A4h
		mov	ax, 0CFCh
		out	dx, ax
		pop	ax
		pop	dx
		mov	di, dx
		push	dx
		push	ax
		mov	dx, 4A0h
		mov	ax, 0FFFEh
		out	dx, ax
		pop	ax
		pop	dx
		movsw
		add	di, 52h	; 'R'
		movsw
		add	di, 52h	; 'R'
		movsw
		add	di, 52h	; 'R'
		movsw
		add	di, 52h	; 'R'
		movsw
		add	di, 52h	; 'R'
		movsw
		add	di, 52h	; 'R'
		movsw
		add	di, 52h	; 'R'
		movsw
		add	di, 52h	; 'R'
		add	si, 20h	; ' '
		mov	di, dx
		push	dx
		push	ax
		mov	dx, 4A0h
		mov	ax, 0FFFDh
		out	dx, ax
		pop	ax
		pop	dx
		movsw
		add	di, 52h	; 'R'
		movsw
		add	di, 52h	; 'R'
		movsw
		add	di, 52h	; 'R'
		movsw
		add	di, 52h	; 'R'
		movsw
		add	di, 52h	; 'R'
		movsw
		add	di, 52h	; 'R'
		movsw
		add	di, 52h	; 'R'
		movsw
		add	di, 52h	; 'R'
		add	si, 20h	; ' '
		mov	di, dx
		push	dx
		push	ax
		mov	dx, 4A0h
		mov	ax, 0FFFBh
		out	dx, ax
		pop	ax
		pop	dx
		movsw
		add	di, 52h	; 'R'
		movsw
		add	di, 52h	; 'R'
		movsw
		add	di, 52h	; 'R'
		movsw
		add	di, 52h	; 'R'
		movsw
		add	di, 52h	; 'R'
		movsw
		add	di, 52h	; 'R'
		movsw
		add	di, 52h	; 'R'
		movsw
		add	di, 52h	; 'R'
		add	si, 20h	; ' '
		mov	di, dx
		push	dx
		push	ax
		mov	dx, 4A0h
		mov	ax, 0FFF7h
		out	dx, ax
		pop	ax
		pop	dx
		movsw
		add	di, 52h	; 'R'
		movsw
		add	di, 52h	; 'R'
		movsw
		add	di, 52h	; 'R'
		movsw
		add	di, 52h	; 'R'
		movsw
		add	di, 52h	; 'R'
		movsw
		add	di, 52h	; 'R'
		movsw
		add	di, 52h	; 'R'
		movsw
		add	di, 52h	; 'R'
		add	si, 20h	; ' '
		jmp	loc_293AC
; ---------------------------------------------------------------------------

loc_28F62:				; CODE XREF: sub_288C7+593j
		mov	di, dx
		push	dx
		push	ax
		mov	dx, 4A4h
		mov	ax, 0C0Ch
		out	dx, ax
		mov	dx, 4A0h
		mov	ax, 0FFF0h
		out	dx, ax
		pop	ax
		pop	dx
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		add	si, 20h	; ' '
		push	dx
		push	ax
		mov	dx, 4A4h
		mov	ax, 0CFCh
		out	dx, ax
		pop	ax
		pop	dx
		mov	di, dx
		push	dx
		push	ax
		mov	dx, 4A0h
		mov	ax, 0FFFEh
		out	dx, ax
		pop	ax
		pop	dx
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		add	si, 20h	; ' '
		mov	di, dx
		push	dx
		push	ax
		mov	dx, 4A0h
		mov	ax, 0FFFDh
		out	dx, ax
		pop	ax
		pop	dx
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		add	si, 20h	; ' '
		mov	di, dx
		push	dx
		push	ax
		mov	dx, 4A0h
		mov	ax, 0FFFBh
		out	dx, ax
		pop	ax
		pop	dx
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		add	si, 20h	; ' '
		mov	di, dx
		push	dx
		push	ax
		mov	dx, 4A0h
		mov	ax, 0FFF7h
		out	dx, ax
		pop	ax
		pop	dx
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		lodsw
		xor	bx, bx
		mov	bl, al
		mov	ch, cs:[bx+34C4h]
		xor	bx, bx
		mov	bl, ah
		mov	cl, cs:[bx+34C4h]
		mov	es:[di], cx
		add	di, 50h	; 'P'
		add	si, 20h	; ' '

loc_293AC:				; CODE XREF: sub_288C7+149j
					; sub_288C7+587j ...
		push	ax
		push	dx
		mov	ax, 0FFF0h
		mov	dx, 4A0h
		out	dx, ax
		mov	ax, 0FFFFh
		mov	dx, 4A8h
		out	dx, ax
		mov	al, 7
		out	6Ah, al
		mov	al, 4
		out	6Ah, al
		cli
		xor	ax, ax
		out	7Ch, al
		sti
		mov	al, 6
		out	6Ah, al
		pop	dx
		pop	ax
		cld
		retn
sub_288C7	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_293D2	proc far		; CODE XREF: sub_16114+4BP
					; sub_162AE+55P ...

var_0		= word ptr  0
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		push	di
		push	ds
		push	es
		add	bp, 6
		mov	bx, [bp+var_0]
		mov	cx, [bp+2]
		mov	dx, [bp+4]
		mov	ax, [bp+arg_0]
		call	sub_293F3
		pop	es
		assume es:nothing
		pop	ds
		pop	di
		pop	si
		pop	bp
		retf
sub_293D2	endp


; =============== S U B	R O U T	I N E =======================================


sub_293F3	proc far		; CODE XREF: sub_293D2+16P
		shl	bx, 1
		mov	ds, dx
		shl	cx, 1
		shl	cx, 1
		shl	cx, 1
		shl	cx, 1
		shl	cx, 1
		shl	cx, 1
		shl	cx, 1
		add	bx, cx
		shl	cx, 1
		shl	cx, 1
		add	bx, cx
		mov	dx, bx
		push	ax
		and	ax, 3FFFh
		mov	cx, ax
		shl	cx, 1
		shl	cx, 1
		mov	ax, ds
		add	ax, cx
		mov	ds, ax
		mov	si, 0
		pop	ax
		mov	al, 0
		out	7Ch, al
		mov	di, dx
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		mov	di, dx
		mov	ax, 0B000h
		mov	es, ax
		assume es:nothing
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		mov	di, dx
		mov	ax, 0B800h
		mov	es, ax
		assume es:nothing
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		mov	di, dx
		mov	ax, 0E000h
		mov	es, ax
		assume es:nothing
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		movsw
		add	di, 4Eh	; 'N'
		retf
sub_293F3	endp

; ---------------------------------------------------------------------------
byte_294C4	db  00h, 80h, 40h,0C0h,	20h,0A0h, 60h,0E0h ; DATA XREF:	sub_27E76+4BDr
		db  10h, 90h, 50h,0D0h,	30h,0B0h, 70h,0F0h
		db  08h, 88h, 48h,0C8h,	28h,0A8h, 68h,0E8h
		db  18h, 98h, 58h,0D8h,	38h,0B8h, 78h,0F8h
		db  04h, 84h, 44h,0C4h,	24h,0A4h, 64h,0E4h
		db  14h, 94h, 54h,0D4h,	34h,0B4h, 74h,0F4h
		db  0Ch, 8Ch, 4Ch,0CCh,	2Ch,0ACh, 6Ch,0ECh
		db  1Ch, 9Ch, 5Ch,0DCh,	3Ch,0BCh, 7Ch,0FCh
		db  02h, 82h, 42h,0C2h,	22h,0A2h, 62h,0E2h
		db  12h, 92h, 52h,0D2h,	32h,0B2h, 72h,0F2h
		db  0Ah, 8Ah, 4Ah,0CAh,	2Ah,0AAh, 6Ah,0EAh
		db  1Ah, 9Ah, 5Ah,0DAh,	3Ah,0BAh, 7Ah,0FAh
		db  06h, 86h, 46h,0C6h,	26h,0A6h, 66h,0E6h
		db  16h, 96h, 56h,0D6h,	36h,0B6h, 76h,0F6h
		db  0Eh, 8Eh, 4Eh,0CEh,	2Eh,0AEh, 6Eh,0EEh
		db  1Eh, 9Eh, 5Eh,0DEh,	3Eh,0BEh, 7Eh,0FEh
		db  01h, 81h, 41h,0C1h,	21h,0A1h, 61h,0E1h
		db  11h, 91h, 51h,0D1h,	31h,0B1h, 71h,0F1h
		db  09h, 89h, 49h,0C9h,	29h,0A9h, 69h,0E9h
		db  19h, 99h, 59h,0D9h,	39h,0B9h, 79h,0F9h
		db  05h, 85h, 45h,0C5h,	25h,0A5h, 65h,0E5h
		db  15h, 95h, 55h,0D5h,	35h,0B5h, 75h,0F5h
		db  0Dh, 8Dh, 4Dh,0CDh,	2Dh,0ADh, 6Dh,0EDh
		db  1Dh, 9Dh, 5Dh,0DDh,	3Dh,0BDh, 7Dh,0FDh
		db  03h, 83h, 43h,0C3h,	23h,0A3h, 63h,0E3h
		db  13h, 93h, 53h,0D3h,	33h,0B3h, 73h,0F3h
		db  0Bh, 8Bh, 4Bh,0CBh,	2Bh,0ABh, 6Bh,0EBh
		db  1Bh, 9Bh, 5Bh,0DBh,	3Bh,0BBh, 7Bh,0FBh
		db  07h, 87h, 47h,0C7h,	27h,0A7h, 67h,0E7h
		db  17h, 97h, 57h,0D7h,	37h,0B7h, 77h,0F7h
		db  0Fh, 8Fh, 4Fh,0CFh,	2Fh,0AFh, 6Fh,0EFh
		db  1Fh, 9Fh, 5Fh,0DFh
seg015		ends

; ===========================================================================

; Segment type:	Pure code
seg016		segment	byte public 'CODE' use16
		assume cs:seg016
		assume es:nothing, ss:nothing, ds:nothing, fs:nothing, gs:nothing
		db 3Fh,	0BFh, 7Fh, 0FFh

; =============== S U B	R O U T	I N E =======================================


sub_295C4	proc near		; CODE XREF: sub_29694+30p
		mov	ax, 200h
		int	0D3h		; used by BASIC	while in interpreter
		retn
sub_295C4	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

MaybeLoadFile	proc far		; CODE XREF: sub_11A04+155P
					; DoPlayerWinScr+1FDP ...

var_0		= word ptr  0

		push	bp
		mov	bp, sp
		push	si
		push	di
		push	ds
		push	es
		add	bp, 6
		mov	dx, [bp+var_0]
		call	sub_2965E
		shr	ax, 1
		shr	ax, 1
		shr	ax, 1
		shr	ax, 1
		shl	dx, 1
		shl	dx, 1
		shl	dx, 1
		shl	dx, 1
		shl	dx, 1
		shl	dx, 1
		shl	dx, 1
		shl	dx, 1
		shl	dx, 1
		shl	dx, 1
		shl	dx, 1
		shl	dx, 1
		add	ax, dx
		inc	ax
		pop	es
		pop	ds
		pop	di
		pop	si
		pop	bp
		retf
MaybeLoadFile	endp

; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		push	si
		push	di
		push	ds
		push	es
		add	bp, 6
		mov	dx, [bp+0]
		call	sub_29679
		shr	ax, 1
		shr	ax, 1
		shr	ax, 1
		shr	ax, 1
		shl	dx, 1
		shl	dx, 1
		shl	dx, 1
		shl	dx, 1
		shl	dx, 1
		shl	dx, 1
		shl	dx, 1
		shl	dx, 1
		shl	dx, 1
		shl	dx, 1
		shl	dx, 1
		shl	dx, 1
		add	ax, dx
		inc	ax
		pop	es
		pop	ds
		pop	di
		pop	si
		pop	bp
		retf
; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		push	si
		push	di
		push	ds
		push	es
		add	bp, 6
		mov	dx, [bp+0]
		mov	ax, 501h
		int	0D3h		; used by BASIC	while in interpreter
		jnb	short loc_29655
		xor	ax, ax
		jmp	short loc_29658
; ---------------------------------------------------------------------------
		nop

loc_29655:				; CODE XREF: seg016:008Ej
		mov	ax, 1

loc_29658:				; CODE XREF: seg016:0092j
		pop	es
		pop	ds
		pop	di
		pop	si
		pop	bp
		retf

; =============== S U B	R O U T	I N E =======================================


sub_2965E	proc near		; CODE XREF: MaybeLoadFile+Dp
					; sub_29694+13p
		push	ax
		push	dx
		push	ds
		mov	ah, 1Ah
		mov	dx, offset byte_2C848
		int	21h		; DOS -	SET DISK TRANSFER AREA ADDRESS
					; DS:DX	-> disk	transfer buffer
		pop	ds
		pop	dx
		pop	ax
		mov	ax, 500h
		int	0D3h		; used by BASIC	while in interpreter
		jnb	short locret_29678
		mov	ax, 0FFFFh
		mov	dx, 0FFFFh

locret_29678:				; CODE XREF: sub_2965E+12j
		retn
sub_2965E	endp


; =============== S U B	R O U T	I N E =======================================


sub_29679	proc near		; CODE XREF: seg016:0050p
		push	ax
		push	dx
		push	ds
		mov	ah, 1Ah
		mov	dx, offset byte_2C848
		int	21h		; DOS -	SET DISK TRANSFER AREA ADDRESS
					; DS:DX	-> disk	transfer buffer
		pop	ds
		pop	dx
		pop	ax
		mov	ax, 501h
		int	0D3h		; used by BASIC	while in interpreter
		jnb	short locret_29693
		mov	ax, 0FFFFh
		mov	dx, 0FFFFh

locret_29693:				; CODE XREF: sub_29679+12j
		retn
sub_29679	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_29694	proc far		; CODE XREF: sub_11A04+17AP
					; DoPlayerWinScr+222P ...

var_0		= word ptr  0

		push	bp
		mov	bp, sp
		push	si
		push	di
		push	ds
		push	es
		add	bp, 6
		mov	word ptr ds:2032h, 0
		mov	dx, [bp+var_0]
		call	sub_2965E
		mov	ds:202Eh, ax
		mov	ds:2030h, dx
		and	ax, dx
		cmp	ax, 0FFFFh
		jz	short loc_296CF
		mov	bx, [bp+2]
		push	bx
		push	es
		mov	es, bx
		xor	bx, bx
		mov	dx, [bp+var_0]
		call	sub_295C4
		pop	es
		pop	bx
		jb	short loc_296CF
		mov	ds:2032h, bx

loc_296CF:				; CODE XREF: sub_29694+22j
					; sub_29694+35j
		mov	ax, ds:2032h
		pop	es
		pop	ds
		pop	di
		pop	si
		pop	bp
		retf
sub_29694	endp

; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		push	si
		push	di
		push	ds
		push	es
		add	bp, 6
		pop	es
		pop	ds
		pop	di
		pop	si
		pop	bp
		retf

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_296E8	proc far		; CODE XREF: sub_1507C+CBP

var_0		= word ptr  0

		push	bp
		mov	bp, sp
		push	si
		push	di
		push	ds
		push	es
		add	bp, 6
		mov	ax, [bp+var_0]
		mov	ah, 4
		int	0D3h		; used by BASIC	while in interpreter
		pop	es
		pop	ds
		pop	di
		pop	si
		pop	bp
		retf
sub_296E8	endp

; ---------------------------------------------------------------------------
		retf
seg016		ends

; ---------------------------------------------------------------------------
; ===========================================================================

; Segment type:	Pure code
seg017		segment	byte public 'CODE' use16
		assume cs:seg017
		assume es:nothing, ss:nothing, ds:nothing, fs:nothing, gs:nothing
		retf

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_29701	proc far		; CODE XREF: sub_1004E+FP
					; sub_1004E+27P ...

var_0		= word ptr  0

		push	bp
		mov	bp, sp
		push	si
		push	di
		push	ds
		push	es
		add	bp, 6
		mov	ax, [bp+var_0]
		mov	bx, [bp+2]
		mov	cx, [bp+4]
		int	0D2h		; used by BASIC	while in interpreter
		pop	es
		pop	ds
		pop	di
		pop	si
		pop	bp
		retf
sub_29701	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_2971C	proc far		; CODE XREF: LoadTBR+5EP

var_0		= word ptr  0
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		push	di
		push	ds
		push	es
		add	bp, 6
		mov	ax, [bp+var_0]
		mov	bx, [bp+2]
		mov	cx, [bp+4]
		mov	dx, [bp+arg_0]
		int	0D2h		; used by BASIC	while in interpreter
		pop	es
		pop	ds
		pop	di
		pop	si
		pop	bp
		retf
sub_2971C	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_2973A	proc far		; CODE XREF: sub_141D0:loc_14205P
					; sub_1507C+17BP
		push	bp
		mov	bp, sp
		push	si
		push	di
		push	ds
		push	es
		add	bp, 6
		mov	ah, 0
		int	0D5h		; used by BASIC	while in interpreter
		pop	es
		pop	ds
		pop	di
		pop	si
		pop	bp
		retf
sub_2973A	endp

; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		push	si
		push	di
		push	ds
		push	es
		add	bp, 6
		mov	dx, [bp+0]
		mov	di, [bp+2]
		mov	ah, 1
		int	0D5h		; used by BASIC	while in interpreter
		pop	es
		pop	ds
		pop	di
		pop	si
		pop	bp
		retf
; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		push	si
		push	di
		push	ds
		push	es
		add	bp, 6
		mov	ah, 4
		mov	dx, [bp+0]
		mov	al, dl
		int	0D5h		; used by BASIC	while in interpreter
		pop	es
		pop	ds
		pop	di
		pop	si
		pop	bp
		retf

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_29781	proc far		; CODE XREF: sub_141D0+3EP
					; sub_1507C+184P

var_0		= word ptr  0

		push	bp
		mov	bp, sp
		push	si
		push	di
		push	ds
		push	es
		add	bp, 6
		mov	ax, [bp+var_0]
		mov	ah, 5
		int	0D5h		; used by BASIC	while in interpreter
		pop	es
		pop	ds
		pop	di
		pop	si
		pop	bp
		retf
sub_29781	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_29798	proc far		; CODE XREF: sub_100F6:loc_10114P
					; sub_10828+659P ...
		push	bp
		mov	bp, sp
		push	si
		push	di
		push	ds
		push	es
		add	bp, 6
		mov	ah, 6
		int	0D5h		; used by BASIC	while in interpreter
		mov	ax, dx
		pop	es
		pop	ds
		pop	di
		pop	si
		pop	bp
		retf
sub_29798	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_297AE	proc far		; CODE XREF: sub_15C20+4FP

var_0		= word ptr  0

		push	bp
		mov	bp, sp
		push	si
		push	di
		push	ds
		push	es
		add	bp, 6
		mov	dx, [bp+var_0]
		mov	ax, [bp+2]
		call	sub_297C7
		pop	es
		pop	ds
		pop	di
		pop	si
		pop	bp
		retf
sub_297AE	endp


; =============== S U B	R O U T	I N E =======================================


sub_297C7	proc near		; CODE XREF: sub_297AE+10p
		pushf
		push	ds
		push	si
		push	di
		push	dx
		cld
		mov	ds, dx
		mov	si, 0
		mov	dx, ax
		mov	ax, [si]
		cmp	ax, dx
		jb	short loc_297EC
		shl	dx, 1
		add	si, dx
		mov	di, [si]
		mov	dx, ds
		mov	ah, 1
		int	0D5h		; used by BASIC	while in interpreter
		mov	ax, 0
		jmp	short loc_297EF
; ---------------------------------------------------------------------------
		align 2

loc_297EC:				; CODE XREF: sub_297C7+11j
		mov	ax, 0FFFFh

loc_297EF:				; CODE XREF: sub_297C7+22j
		pop	dx
		pop	di
		pop	si
		pop	ds
		popf
		retn
sub_297C7	endp

seg017		ends

; ===========================================================================

; Segment type:	Pure code
seg018		segment	byte public 'CODE' use16
		assume cs:seg018
		;org 5
		assume es:nothing, ss:nothing, ds:nothing, fs:nothing, gs:nothing
word_297F5	dw 0			; DATA XREF: ClearBox:loc_29B14w
					; ClearBox+73r	...
word_297F7	dw 0			; DATA XREF: ClearBox:loc_29B23w
					; ClearBox+87r	...
word_297F9	dw 0			; DATA XREF: ClearBox+5Bw ClearBox+7Dr ...
word_297FB	dw 0			; DATA XREF: ClearBox+6Bw ClearBox+A4r ...
word_297FD	dw 0A800h		; DATA XREF: ClearBox+9Fr
					; sub_29BD1+A2r
		align 2
		db 0A8h, 0, 0B0h, 0, 0B8h, 0, 0E0h
word_29807	dw 0			; DATA XREF: ClearBox+CBw ClearBox+DEr ...
		db 2 dup(0)
word_2980B	dw 0			; DATA XREF: ClearBox+AFw ClearBox+D2r ...
		db 8 dup(0)
byte_29815	db 0			; DATA XREF: DrawTextChar+6Dw
					; DrawTextChar+94r ...
byte_29816	db    0, 20h,	0
		db    1, 21h,	1
		db    0, 22h,	2
		db    1, 23h,	3
		db    0, 24h,	4
		db    0, 25h,	5
		db    1, 26h,	6
		db    0, 27h,	7
		db    0, 28h,	8
		db    1, 29h,	9
		db    0, 2Ah, 0Ah
		db    0, 2Bh, 0Bh
		db    1, 2Ch, 0Ch
		db    0, 2Dh, 0Dh
		db    0, 2Eh, 0Eh
		db    1, 2Fh, 0Fh
		db    0, 20h,	0
		db    0, 21h,	1
		db    0, 22h,	2
		db    0, 23h,	3
		db    0, 24h,	4
		db    0, 25h,	5
		db    0, 26h,	6
		db    0, 27h,	7
		db    0, 28h,	8
		db    0, 29h,	9
		db    0, 2Ah, 0Ah
		db    0, 2Bh, 0Bh
		db    0, 2Ch, 0Ch
		db    0, 2Dh, 0Dh
		db    0, 2Eh, 0Eh
		db    0, 2Fh, 0Fh
		db    0
		db    0,   0
		db    1,   1
		db    2,   0
		db    3,   1
		db    4,   0
		db    5,   1
		db    6,   0
		db    7,   1
		db    8,   0
		db    9,   1
		db  0Ah,   0
		db  0Bh,   1
		db  0Ch,   0
		db  0Dh,   1
		db  0Eh,   0
		db  0Fh,   1

; =============== S U B	R O U T	I N E =======================================


sub_29897	proc near		; CODE XREF: DrawTextChar+53p
		push	ax
		mov	al, 0Bh
		out	68h, al
		pop	ax
		retn
sub_29897	endp


; =============== S U B	R O U T	I N E =======================================


sub_2989E	proc near		; CODE XREF: DrawTextChar:loc_29A58p
		push	ax
		mov	al, 0Ah
		out	68h, al
		pop	ax
		retn
sub_2989E	endp


; =============== S U B	R O U T	I N E =======================================


ShiftJIS2JIS	proc near		; CODE XREF: DrawTextChar+80p
		cmp	dh, 0A0h
		jnb	short loc_298B0
		sub	dh, 71h
		jmp	short loc_298B3
; ---------------------------------------------------------------------------
		align 2

loc_298B0:				; CODE XREF: ShiftJIS2JIS+3j
		sub	dh, 0B1h

loc_298B3:				; CODE XREF: ShiftJIS2JIS+8j
		shl	dh, 1
		inc	dh
		cmp	dl, 80h
		jb	short loc_298BE
		dec	dl

loc_298BE:				; CODE XREF: ShiftJIS2JIS+15j
		cmp	dl, 9Eh
		jnb	short loc_298C9
		sub	dl, 1Fh
		jmp	short locret_298CE
; ---------------------------------------------------------------------------
		nop

loc_298C9:				; CODE XREF: ShiftJIS2JIS+1Cj
		sub	dl, 7Dh
		inc	dh

locret_298CE:				; CODE XREF: ShiftJIS2JIS+21j
		retn
ShiftJIS2JIS	endp


; =============== S U B	R O U T	I N E =======================================


DrawTextChar	proc near		; CODE XREF: DrawTextStr:loc_29AAEp
					; j_DrawTextChar+16p
		push	ax
		push	bx
		push	cx
		push	dx
		push	si
		push	di
		push	ds
		push	es
		push	bp
		pushf
		cld
		push	ax
		mov	al, 0C0h ; '�'
		out	7Ch, al
		pop	ax
		push	ax
		push	bx
		mov	bx, cx
		shr	bx, 1
		jb	short loc_298EF
		xor	al, al
		out	7Eh, al
		jmp	short loc_298F3
; ---------------------------------------------------------------------------
		nop

loc_298EF:				; CODE XREF: DrawTextChar+17j
		mov	al, 0FFh
		out	7Eh, al

loc_298F3:				; CODE XREF: DrawTextChar+1Dj
		shr	bx, 1
		jb	short loc_298FE
		xor	al, al
		out	7Eh, al
		jmp	short loc_29902
; ---------------------------------------------------------------------------
		align 2

loc_298FE:				; CODE XREF: DrawTextChar+26j
		mov	al, 0FFh
		out	7Eh, al

loc_29902:				; CODE XREF: DrawTextChar+2Cj
		shr	bx, 1
		jb	short loc_2990D
		xor	al, al
		out	7Eh, al
		jmp	short loc_29911
; ---------------------------------------------------------------------------
		nop

loc_2990D:				; CODE XREF: DrawTextChar+35j
		mov	al, 0FFh
		out	7Eh, al

loc_29911:				; CODE XREF: DrawTextChar+3Bj
		shr	bx, 1
		jb	short loc_2991C
		xor	al, al
		out	7Eh, al
		jmp	short loc_29920
; ---------------------------------------------------------------------------
		align 2

loc_2991C:				; CODE XREF: DrawTextChar+44j
		mov	al, 0FFh
		out	7Eh, al

loc_29920:				; CODE XREF: DrawTextChar+4Aj
		pop	bx
		pop	ax
		call	sub_29897
		push	dx
		mov	cx, ax
		mov	ax, 50h	; 'P'
		mul	bx
		mov	bx, cx
		shr	bx, 1
		shr	bx, 1
		shr	bx, 1
		add	ax, bx
		mov	di, ax
		and	cx, 7
		mov	cs:byte_29815, cl
		pop	dx
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		mov	ax, cs
		mov	ds, ax
		assume ds:seg018
		or	dh, dh
		jz	short loc_299C2	; single-byte character	- jump
		call	ShiftJIS2JIS	; -- two-byte character	--
		sub	dh, 20h
		mov	al, dl
		out	0A1h, al	; Interrupt Controller #2, 8259A
		mov	al, dh
		out	0A3h, al	; Interrupt Controller #2, 8259A
		mov	si, 57h
		mov	cx, 10h
		cmp	cs:byte_29815, 0
		jz	short loc_299A4

loc_2996B:				; CODE XREF: DrawTextChar+D0j
		push	cx
		mov	cl, cs:byte_29815
		xor	ax, ax
		lodsb
		out	0A5h, al	; Interrupt Controller #2, 8259A
		in	al, 0A9h	; Interrupt Controller #2, 8259A
		mov	ah, al
		shr	ah, cl
		mov	es:[di], ah
		mov	ah, al
		lodsb
		out	0A5h, al	; Interrupt Controller #2, 8259A
		in	al, 0A9h	; Interrupt Controller #2, 8259A
		xor	bx, bx
		mov	bh, al
		shr	ax, cl
		mov	es:[di+1], al
		shr	bx, cl
		mov	es:[di+2], bl
		lodsb
		or	al, al
		jnz	short loc_2999E
		add	di, 50h	; 'P'

loc_2999E:				; CODE XREF: DrawTextChar+CAj
		pop	cx
		loop	loc_2996B
		jmp	loc_29A58
; ---------------------------------------------------------------------------

loc_299A4:				; CODE XREF: DrawTextChar+9Aj
					; DrawTextChar:loc_299BDj
		lodsb
		out	0A5h, al	; Interrupt Controller #2, 8259A
		in	al, 0A9h	; Interrupt Controller #2, 8259A
		mov	es:[di], al
		lodsb
		out	0A5h, al	; Interrupt Controller #2, 8259A
		in	al, 0A9h	; Interrupt Controller #2, 8259A
		mov	es:[di+1], al
		lodsb
		or	al, al
		jnz	short loc_299BD
		add	di, 50h	; 'P'

loc_299BD:				; CODE XREF: DrawTextChar+E9j
		loop	loc_299A4
		jmp	loc_29A58
; ---------------------------------------------------------------------------

loc_299C2:				; CODE XREF: DrawTextChar+7Ej
		mov	al, dh		; -- single-byte character --
		out	0A1h, al	; Interrupt Controller #2, 8259A
		mov	al, dl
		out	0A3h, al	; Interrupt Controller #2, 8259A
		mov	si, 87h
		mov	cx, 10h
		cmp	cs:byte_29815, 0
		jz	short loc_29A24
		push	ax

loc_299D9:				; CODE XREF: DrawTextChar+117j
		push	cx
		mov	cx, 3

loc_299DD:				; CODE XREF: DrawTextChar+110j
		jmp	short $+2
		loop	loc_299DD
		pop	cx
		in	al, 60h		; 8042 keyboard	controller data	register
		and	al, 20h
		jnz	short loc_299D9
		pop	ax
		push	ax

loc_299EA:				; CODE XREF: DrawTextChar+128j
		push	cx
		mov	cx, 3

loc_299EE:				; CODE XREF: DrawTextChar+121j
		jmp	short $+2
		loop	loc_299EE
		pop	cx
		in	al, 60h		; 8042 keyboard	controller data	register
		and	al, 20h
		jz	short loc_299EA
		pop	ax

loc_299FA:				; CODE XREF: DrawTextChar+150j
		push	cx
		mov	cl, cs:byte_29815
		xor	ax, ax
		lodsb
		out	0A5h, al	; Interrupt Controller #2, 8259A
		in	al, 0A9h	; Interrupt Controller #2, 8259A
		mov	ah, al
		shr	al, cl
		mov	es:[di], al
		xor	al, al
		shr	ax, cl
		mov	es:[di+1], al
		lodsb
		or	al, al
		jnz	short loc_29A1E
		add	di, 50h	; 'P'

loc_29A1E:				; CODE XREF: DrawTextChar+14Aj
		pop	cx
		loop	loc_299FA
		jmp	short loc_29A58
; ---------------------------------------------------------------------------
		align 2

loc_29A24:				; CODE XREF: DrawTextChar+107j
		push	ax

loc_29A25:				; CODE XREF: DrawTextChar+163j
		push	cx
		mov	cx, 3

loc_29A29:				; CODE XREF: DrawTextChar+15Cj
		jmp	short $+2
		loop	loc_29A29
		pop	cx
		in	al, 60h		; 8042 keyboard	controller data	register
		and	al, 20h
		jnz	short loc_29A25
		pop	ax
		push	ax

loc_29A36:				; CODE XREF: DrawTextChar+174j
		push	cx
		mov	cx, 3

loc_29A3A:				; CODE XREF: DrawTextChar+16Dj
		jmp	short $+2
		loop	loc_29A3A
		pop	cx
		in	al, 60h		; 8042 keyboard	controller data	register
		and	al, 20h
		jz	short loc_29A36
		pop	ax

loc_29A46:				; CODE XREF: DrawTextChar:loc_29A56j
		lodsb
		out	0A5h, al	; Interrupt Controller #2, 8259A
		in	al, 0A9h	; Interrupt Controller #2, 8259A
		mov	es:[di], al
		lodsb
		or	al, al
		jnz	short loc_29A56
		add	di, 50h	; 'P'

loc_29A56:				; CODE XREF: DrawTextChar+182j
		loop	loc_29A46

		call	sub_2989E
		popf