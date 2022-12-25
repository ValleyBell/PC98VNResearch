; File Name   :	R:\CANAAN\SYS98.EXE
; Format      :	MS-DOS executable (EXE)
; Base Address:	1000h Range: 10000h-27650h Loaded length: 16385h
; Entry	Point :	1000:0

		.686p
		.mmx
		.model large

; ===========================================================================

; Segment type:	Pure code
seg000		segment	byte public 'CODE' use16
		assume cs:seg000
		assume es:nothing, ss:seg003, ds:nothing, fs:nothing, gs:nothing

; =============== S U B	R O U T	I N E =======================================

; Attributes: noreturn

		public start
start		proc near

; FUNCTION CHUNK AT 01DE SIZE 00000015 BYTES

		mov	dx, seg	dseg
		mov	cs:DSegVal, dx
		mov	ah, 30h
		int	21h		; DOS -	GET DOS	VERSION
					; Return: AL = major version number (00h for DOS 1.x)
		mov	bp, ds:2
		mov	bx, ds:2Ch
		mov	ds, dx
		assume ds:dseg
		mov	word_18D2B, ax
		mov	seg_18D29, es
		mov	word ptr dword_18D23+2,	bx
		mov	word_18D39, bp
		call	SaveIntVects
		les	di, dword_18D23
		mov	ax, di
		mov	bx, ax
		mov	cx, 7FFFh
		cld

loc_10034:				; CODE XREF: start+3Cj
		repne scasb
		jcxz	short loc_10074
		inc	bx
		cmp	es:[di], al
		jnz	short loc_10034
		or	ch, 80h
		neg	cx
		mov	word ptr dword_18D23, cx
		mov	cx, 2
		shl	bx, cl
		add	bx, 10h
		and	bx, 0FFF0h
		mov	word_18D27, bx
		mov	dx, ss
		sub	bp, dx
		mov	di, word_26324
		cmp	di, 200h
		jnb	short loc_1006B
		mov	di, 200h
		mov	word_26324, di

loc_1006B:				; CODE XREF: start+62j
		mov	cl, 4
		shr	di, cl
		inc	di
		cmp	bp, di
		jnb	short loc_10077

loc_10074:				; CODE XREF: start+36j
		jmp	loc_101DE
; ---------------------------------------------------------------------------

loc_10077:				; CODE XREF: start+72j
		mov	bx, di
		add	bx, dx
		mov	word_18D31, bx
		mov	word_18D35, bx

loc_10083:
		mov	ax, seg_18D29
		sub	bx, ax
		mov	es, ax
		mov	ah, 4Ah
		push	di
		int	21h		; DOS -	2+ - ADJUST MEMORY BLOCK SIZE (SETBLOCK)
					; ES = segment address of block	to change
					; BX = new size	in paragraphs
		pop	di
		shl	di, cl
		cli
		mov	ss, dx
		assume ss:nothing
		mov	sp, di
		mov	word_26324, di
		sti
		xor	ax, ax
		mov	es, cs:DSegVal
		assume es:dseg
		mov	di, offset nameTable
		mov	cx, offset byte_275C6
		sub	cx, di
		cld
		rep stosb
		xor	bp, bp
		mov	ax, seg	dseg
		mov	ds, ax
		mov	si, 0
		mov	di, 0
		call	sub_10193
		mov	ds, cs:DSegVal
		mov	byte ptr cs:loc_101A5, 72h
		mov	byte ptr cs:sub_10193+1, 0
		push	word_18D21
		push	word_18D1F
		push	word_18D1D
		push	word_18D1B
		push	word_18D19
		call	sub_110BC
		push	ax
		call	sub_15440
start		endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: noreturn

sub_100EA	proc near		; CODE XREF: sub_15440+1Dp
		mov	ax, seg	dseg
		mov	ds, ax
		mov	si, 0
		mov	di, 0
		call	sub_10193
		mov	ds, cs:DSegVal
		call	off_2631E
		call	off_26320
		call	off_26322
sub_100EA	endp ; sp-analysis failed


; =============== S U B	R O U T	I N E =======================================

; Attributes: noreturn

sub_10109	proc near		; CODE XREF: start+1F0p
		mov	ds, cs:DSegVal
		call	RevertIntVects
		mov	bp, sp
		mov	ah, 4Ch
		mov	al, [bp+2]
		int	21h		; DOS -	2+ - QUIT WITH EXIT CODE (EXIT)
sub_10109	endp			; AL = exit code

; ---------------------------------------------------------------------------

Int00:					; DATA XREF: SaveIntVects+3Co
		mov	cx, 0Eh
		mov	dx, 2Dh
		jmp	loc_101E4

; =============== S U B	R O U T	I N E =======================================


SaveIntVects	proc near		; CODE XREF: start+25p
		push	ds
		mov	ax, 3500h
		int	21h		; DOS -	2+ - GET INTERRUPT VECTOR
					; AL = interrupt number
					; Return: ES:BX	= value	of interrupt vector
		mov	word ptr OldIntVec00, bx
		mov	word ptr OldIntVec00+2,	es
		mov	ax, 3504h
		int	21h		; DOS -	2+ - GET INTERRUPT VECTOR
					; AL = interrupt number
					; Return: ES:BX	= value	of interrupt vector
		mov	word ptr OldIntVec04, bx
		mov	word ptr OldIntVec04+2,	es
		mov	ax, 3505h
		int	21h		; DOS -	2+ - GET INTERRUPT VECTOR
					; AL = interrupt number
					; Return: ES:BX	= value	of interrupt vector
		mov	word ptr OldIntVec05, bx
		mov	word ptr OldIntVec05+2,	es
		mov	ax, 3506h
		int	21h		; DOS -	2+ - GET INTERRUPT VECTOR
					; AL = interrupt number
					; Return: ES:BX	= value	of interrupt vector
		mov	word ptr OldIntVec06, bx
		mov	word ptr OldIntVec06+2,	es
		mov	ax, 2500h
		mov	dx, cs
		mov	ds, dx
		assume ds:seg000
		mov	dx, offset Int00
		int	21h		; DOS -	SET INTERRUPT VECTOR
					; AL = interrupt number
					; DS:DX	= new vector to	be used	for specified interrupt
		pop	ds
		assume ds:dseg
		retn
SaveIntVects	endp


; =============== S U B	R O U T	I N E =======================================


RevertIntVects	proc near		; CODE XREF: sub_10109+5p
		push	ds
		mov	ax, 2500h
		lds	dx, OldIntVec00
		int	21h		; DOS -	SET INTERRUPT VECTOR
					; AL = interrupt number
					; DS:DX	= new vector to	be used	for specified interrupt
		pop	ds
		push	ds
		mov	ax, 2504h
		lds	dx, OldIntVec04
		int	21h		; DOS -	SET INTERRUPT VECTOR
					; AL = interrupt number
					; DS:DX	= new vector to	be used	for specified interrupt
		pop	ds
		push	ds
		mov	ax, 2505h
		lds	dx, OldIntVec05
		int	21h		; DOS -	SET INTERRUPT VECTOR
					; AL = interrupt number
					; DS:DX	= new vector to	be used	for specified interrupt
		pop	ds
		push	ds
		mov	ax, 2506h
		lds	dx, OldIntVec06
		int	21h		; DOS -	SET INTERRUPT VECTOR
					; AL = interrupt number
					; DS:DX	= new vector to	be used	for specified interrupt
		pop	ds
		retn
RevertIntVects	endp


; =============== S U B	R O U T	I N E =======================================


sub_10193	proc near		; CODE XREF: start+BBp	sub_100EA+Bp ...
		mov	ah, 0FFh
		mov	dx, di
		mov	bx, si

loc_10199:				; CODE XREF: sub_10193+1Cj
		cmp	bx, di
		jz	short loc_101B1
		cmp	byte ptr [bx], 0FFh
		jz	short loc_101AC
		cmp	[bx+1],	ah

loc_101A5:				; DATA XREF: start+C3w
		ja	short loc_101AC
		mov	ah, [bx+1]
		mov	dx, bx

loc_101AC:				; CODE XREF: sub_10193+Dj
					; sub_10193:loc_101A5j
		add	bx, 6
		jmp	short loc_10199
; ---------------------------------------------------------------------------

loc_101B1:				; CODE XREF: sub_10193+8j
		cmp	dx, di
		jz	short locret_101D5
		mov	bx, dx
		push	ds
		pop	es
		push	es
		cmp	byte ptr [bx], 0
		mov	byte ptr [bx], 0FFh
		mov	ds, cs:DSegVal
		jz	short loc_101CE
		call	dword ptr es:[bx+2]
		pop	ds
		jmp	short sub_10193
; ---------------------------------------------------------------------------

loc_101CE:				; CODE XREF: sub_10193+32j
		call	word ptr es:[bx+2]
		pop	ds
		jmp	short sub_10193
; ---------------------------------------------------------------------------

locret_101D5:				; CODE XREF: sub_10193+20j
		retn
sub_10193	endp


; =============== S U B	R O U T	I N E =======================================


sub_101D6	proc near		; CODE XREF: start+1E9p
		mov	ah, 40h	; '@'
		mov	bx, 2
		int	21h		; DOS -	2+ - WRITE TO FILE WITH	HANDLE
					; BX = file handle, CX = number	of bytes to write, DS:DX -> buffer
		retn
sub_101D6	endp

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR start

loc_101DE:				; CODE XREF: start:loc_10074j
		mov	cx, 1Eh
		mov	dx, offset unk_18CEB

loc_101E4:				; CODE XREF: seg000:0120j
		mov	ds, cs:DSegVal
		call	sub_101D6
		mov	ax, 3
		push	ax
		call	sub_10109
; END OF FUNCTION CHUNK	FOR start
; ---------------------------------------------------------------------------
DSegVal		dw 0			; DATA XREF: start+3w start+9Er ...
		dw 4003h

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_101F7	proc near		; CODE XREF: sub_10547+36p
					; LoadCatFile+77p ...

arg_0		= word ptr  4
arg_2		= word ptr  6

		push	bp
		mov	bp, sp
		push	[bp+arg_2]
		push	[bp+arg_0]
		call	sub_156DE
		pop	cx
		pop	cx
		pop	bp
		retn
sub_101F7	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_10207	proc near		; CODE XREF: sub_10547+B3p

arg_0		= word ptr  4
arg_2		= word ptr  6
arg_4		= word ptr  8
arg_6		= word ptr  0Ah

		push	bp
		mov	bp, sp
		push	[bp+arg_6]
		push	[bp+arg_4]
		push	[bp+arg_2]
		push	[bp+arg_0]
		call	sub_1583B
		add	sp, 8
		pop	bp
		retn
sub_10207	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1021E	proc near		; CODE XREF: sub_10547+Dp
					; sub_10547+136p

arg_0		= dword	ptr  4

		push	bp
		mov	bp, sp
		les	bx, [bp+arg_0]
		assume es:nothing
		push	word ptr es:[bx+2]
		push	word ptr es:[bx]
		call	sub_10240
		pop	cx
		pop	cx
		les	bx, [bp+arg_0]
		mov	word ptr es:[bx], 0
		mov	word ptr es:[bx+2], 0
		pop	bp
		retn
sub_1021E	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_10240	proc near		; CODE XREF: sub_1021E+Dp
					; sub_112B2+56p ...

arg_0		= word ptr  4
arg_2		= word ptr  6

		push	bp
		mov	bp, sp
		mov	ax, [bp+arg_0]
		or	ax, [bp+arg_2]
		jz	short loc_10256
		push	[bp+arg_2]
		push	[bp+arg_0]
		call	sub_155EE
		pop	cx
		pop	cx

loc_10256:				; CODE XREF: sub_10240+9j
		pop	bp
		retn
sub_10240	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

OpenFile2	proc near		; CODE XREF: ReadSceneFile+8p
					; LoadFile+47p	...

var_30		= byte ptr -30h
arg_0		= word ptr  4
arg_2		= word ptr  6
arg_4		= byte ptr  8

		push	bp
		mov	bp, sp
		sub	sp, 30h
		push	si
		push	[bp+arg_2]
		push	[bp+arg_0]
		push	ss
		lea	ax, [bp+var_30]
		push	ax
		call	sub_15487
		add	sp, 8
		mov	al, [bp+arg_4]
		push	ax
		push	ss
		lea	ax, [bp+var_30]
		push	ax
		call	fopen
		add	sp, 6
		mov	si, ax
		or	ax, ax
		jnz	short loc_10291
		push	ss
		lea	ax, [bp+var_30]
		push	ax
		call	sub_10298
		pop	cx
		pop	cx
		mov	si, ax

loc_10291:				; CODE XREF: OpenFile2+2Bj
		mov	ax, si
		pop	si
		mov	sp, bp
		pop	bp
		retn
OpenFile2	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_10298	proc near		; CODE XREF: OpenFile2+32p

var_D6		= byte ptr -0D6h
var_B6		= byte ptr -0B6h
var_A6		= byte ptr -0A6h
var_A5		= byte ptr -0A5h
var_A4		= byte ptr -0A4h
var_5A		= byte ptr -5Ah
var_56		= byte ptr -56h
var_55		= byte ptr -55h
var_54		= byte ptr -54h
var_6		= word ptr -6
var_4		= dword	ptr -4
arg_0		= word ptr  4
arg_2		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 0D6h
		push	si
		push	di
		cmp	word_18D3C, 0
		jnz	short loc_102AB
		jmp	loc_1041A
; ---------------------------------------------------------------------------

loc_102AB:				; CODE XREF: sub_10298+Ej
		push	[bp+arg_2]
		push	[bp+arg_0]
		push	ss
		lea	ax, [bp+var_56]
		push	ax
		call	sub_10797
		add	sp, 8
		lea	ax, [bp+var_A6]
		push	ss
		push	ax
		lea	ax, [bp+var_56]
		push	ss
		push	ax
		mov	cx, 50h	; 'P'
		call	near ptr sub_158A7
		mov	[bp+var_A6], 0
		mov	[bp+var_A4], 0
		push	ss
		lea	ax, [bp+var_A6]
		push	ax
		push	ss
		lea	ax, [bp+var_B6]
		push	ax
		call	sub_108BC
		add	sp, 8
		xor	si, si

loc_102EB:				; CODE XREF: sub_10298+17Fj
		push	ss
		lea	ax, [bp+var_B6]
		push	ax
		mov	ax, si
		mov	dx, 24h	; '$'
		imul	dx
		mov	dx, word ptr dword_18D3E
		add	dx, ax
		push	word ptr dword_18D3E+2
		push	dx
		call	sub_10422
		add	sp, 8
		mov	[bp+var_6], ax
		cmp	ax, 0FFFFh
		jnz	short loc_10314
		jmp	loc_1040E
; ---------------------------------------------------------------------------

loc_10314:				; CODE XREF: sub_10298+77j
		mov	ax, si
		mov	dx, 24h	; '$'
		imul	dx
		mov	dx, word ptr dword_18D3E
		add	dx, ax
		push	word ptr dword_18D3E+2
		push	dx
		push	ss
		lea	ax, [bp+var_A6]
		push	ax
		call	sub_10797
		add	sp, 8
		mov	al, [bp+var_56]
		mov	[bp+var_A6], al
		mov	al, [bp+var_55]
		mov	[bp+var_A5], al
		push	ss
		lea	ax, [bp+var_54]
		push	ax
		push	ss
		lea	ax, [bp+var_A4]
		push	ax
		call	sub_15487
		add	sp, 8
		push	ds
		mov	ax, 98h	; '˜'
		push	ax
		push	ss
		lea	ax, [bp+var_5A]
		push	ax
		call	sub_15487
		add	sp, 8
		push	ss
		lea	ax, [bp+var_A6]
		push	ax
		push	ss
		lea	ax, [bp+var_D6]
		push	ax
		call	sub_108BC
		add	sp, 8
		mov	al, 0
		push	ax
		push	ss
		lea	ax, [bp+var_D6]
		push	ax
		call	fopen
		add	sp, 6
		mov	di, ax
		or	ax, ax
		jnz	short loc_1038B
		jmp	loc_1041A
; ---------------------------------------------------------------------------

loc_1038B:				; CODE XREF: sub_10298+EEj
		mov	ax, si
		mov	dx, 24h	; '$'
		imul	dx
		les	bx, dword_18D3E
		add	bx, ax
		mov	ax, es:[bx+22h]
		mov	dx, es:[bx+20h]
		mov	word ptr [bp+var_4], dx
		mov	word ptr [bp+var_4+2], ax
		mov	dx, word ptr [bp+var_4]
		add	dx, 6
		mov	word ptr [bp+var_4], dx
		mov	word ptr [bp+var_4+2], ax
		mov	ax, [bp+var_6]
		mov	dx, 16h
		imul	dx
		mov	dx, word ptr [bp+var_4+2]
		mov	bx, word ptr [bp+var_4]
		add	bx, ax
		mov	word ptr [bp+var_4], bx
		mov	word ptr [bp+var_4+2], dx
		mov	al, 0
		push	ax
		les	bx, [bp+var_4]
		mov	ax, es:[bx+14h]
		mov	dx, es:[bx+12h]
		add	dx, 6
		adc	ax, 0
		push	ax
		push	dx
		push	di
		call	sub_10C94
		add	sp, 8
		les	bx, [bp+var_4]
		mov	al, es:[bx+0Ch]
		push	ax
		xor	ax, ax
		xor	dx, dx
		push	ax
		push	dx
		push	word ptr es:[bx+14h]
		push	word ptr es:[bx+12h]
		push	word ptr es:[bx+10h]
		push	word ptr es:[bx+0Eh]
		push	di
		call	sub_10ED4
		add	sp, 10h
		mov	ax, di
		jmp	short loc_1041C
; ---------------------------------------------------------------------------

loc_1040E:				; CODE XREF: sub_10298+79j
		inc	si
		mov	ax, si
		cmp	ax, word_18D3C
		jnb	short loc_1041A
		jmp	loc_102EB
; ---------------------------------------------------------------------------

loc_1041A:				; CODE XREF: sub_10298+10j
					; sub_10298+F0j ...
		xor	ax, ax

loc_1041C:				; CODE XREF: sub_10298+174j
		pop	di
		pop	si
		mov	sp, bp
		pop	bp
		retn
sub_10298	endp ; sp-analysis failed


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_10422	proc near		; CODE XREF: sub_10298+6Bp

var_20		= word ptr -20h
var_1E		= word ptr -1Eh
var_1C		= word ptr -1Ch
var_1A		= word ptr -1Ah
var_18		= word ptr -18h
var_16		= word ptr -16h
var_14		= dword	ptr -14h
var_10		= dword	ptr -10h
var_C		= dword	ptr -0Ch
var_8		= word ptr -8
var_6		= word ptr -6
catData		= dword	ptr -4
arg_0		= dword	ptr  4
arg_4		= word ptr  8
arg_6		= word ptr  0Ah

		push	bp
		mov	bp, sp
		sub	sp, 20h
		push	si
		push	di
		les	bx, [bp+arg_0]
		mov	ax, es:[bx+20h]
		or	ax, es:[bx+22h]
		jnz	short loc_10454
		push	word ptr [bp+arg_0+2]
		push	word ptr [bp+arg_0]
		call	LoadCatFile
		pop	cx
		pop	cx
		les	bx, [bp+arg_0]
		mov	es:[bx+20h], ax
		mov	es:[bx+22h], dx
		or	ax, dx
		jnz	short loc_10454
		jmp	loc_1053E
; ---------------------------------------------------------------------------

loc_10454:				; CODE XREF: sub_10422+13j
					; sub_10422+2Dj
		mov	[bp+var_20], 2020h
		mov	[bp+var_1E], 2020h
		mov	[bp+var_1C], 2020h
		mov	[bp+var_1A], 2020h
		mov	[bp+var_18], 2020h
		mov	[bp+var_16], 2020h
		mov	ax, [bp+arg_6]
		mov	dx, [bp+arg_4]
		mov	word ptr [bp+var_10], dx
		mov	word ptr [bp+var_10+2],	ax
		lea	ax, [bp+var_20]
		mov	word ptr [bp+var_14], ax
		mov	word ptr [bp+var_14+2],	ss
		xor	di, di

loc_10489:				; CODE XREF: sub_10422+9Ej
		les	bx, [bp+var_10]
		cmp	byte ptr es:[bx], 0
		jz	short loc_104C2
		les	bx, [bp+var_10]
		cmp	byte ptr es:[bx], 41h
		jl	short loc_104A8
		cmp	byte ptr es:[bx], 5Ah
		jg	short loc_104A8
		mov	al, es:[bx]
		or	al, 20h
		jmp	short loc_104AE
; ---------------------------------------------------------------------------

loc_104A8:				; CODE XREF: sub_10422+77j
					; sub_10422+7Dj
		les	bx, [bp+var_10]
		mov	al, es:[bx]

loc_104AE:				; CODE XREF: sub_10422+84j
		les	bx, [bp+var_14]
		mov	es:[bx], al
		inc	word ptr [bp+var_10]
		inc	word ptr [bp+var_14]
		inc	di
		mov	ax, di
		cmp	ax, 0Ch
		jb	short loc_10489

loc_104C2:				; CODE XREF: sub_10422+6Ej
		les	bx, [bp+arg_0]
		mov	ax, es:[bx+22h]
		mov	dx, es:[bx+20h]
		mov	word ptr [bp+catData], dx
		mov	word ptr [bp+catData+2], ax
		mov	dx, word ptr [bp+catData]
		add	dx, 6		; skip first 6 bytes (.CAT header)
		mov	[bp+var_8], dx
		mov	[bp+var_6], ax
		xor	si, si

loc_104E1:				; CODE XREF: sub_10422+11Aj
		mov	ax, si
		mov	dx, 16h		; 16h =	size of	TOC entry
		imul	dx
		mov	dx, [bp+var_6]
		mov	bx, [bp+var_8]
		add	bx, ax
		mov	word ptr [bp+var_C], bx
		mov	word ptr [bp+var_C+2], dx
		les	bx, [bp+var_C]
		mov	ax, es:[bx+2]
		mov	dx, es:[bx]
		cmp	ax, [bp+var_1E]
		jnz	short loc_10532
		cmp	dx, [bp+var_20]
		jnz	short loc_10532
		mov	ax, es:[bx+6]
		mov	dx, es:[bx+4]
		cmp	ax, [bp+var_1A]
		jnz	short loc_10532
		cmp	dx, [bp+var_1C]
		jnz	short loc_10532
		mov	ax, es:[bx+0Ah]
		mov	dx, es:[bx+8]
		cmp	ax, [bp+var_16]
		jnz	short loc_10532
		cmp	dx, [bp+var_18]
		jnz	short loc_10532
		mov	ax, si
		jmp	short loc_10541
; ---------------------------------------------------------------------------

loc_10532:				; CODE XREF: sub_10422+E1j
					; sub_10422+E6j ...
		les	bx, [bp+catData]
		inc	si
		mov	ax, si
		cmp	es:[bx+4], ax
		ja	short loc_104E1

loc_1053E:				; CODE XREF: sub_10422+2Fj
		mov	ax, 0FFFFh

loc_10541:				; CODE XREF: sub_10422+10Ej
		pop	di
		pop	si
		mov	sp, bp
		pop	bp
		retn
sub_10422	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_10547	proc near		; CODE XREF: sub_110BC+9p

var_2E		= byte ptr -2Eh
var_E		= word ptr -0Eh
var_C		= word ptr -0Ch
var_A		= word ptr -0Ah
var_8		= dword	ptr -8
var_4		= word ptr -4
var_2		= word ptr -2

		push	bp
		mov	bp, sp
		sub	sp, 2Eh
		push	si
		push	di
		push	ds
		mov	ax, 8Eh	; 'Ž'
		push	ax
		call	sub_1021E
		pop	cx
		pop	cx
		mov	word_18D3C, 0
		push	ds
		mov	ax, 92h	; '’'
		push	ax
		call	sub_10C1A
		pop	cx
		pop	cx
		cmp	dx, 0FFFFh
		jnz	short loc_10576
		cmp	ax, 0FFFFh
		jnz	short loc_10576
		jmp	loc_10682
; ---------------------------------------------------------------------------

loc_10576:				; CODE XREF: sub_10547+25j
					; sub_10547+2Aj
		xor	ax, ax
		mov	dx, 24h	; '$'
		push	ax
		push	dx
		call	sub_101F7
		pop	cx
		pop	cx
		mov	word ptr dword_18D3E, ax
		mov	word ptr dword_18D3E+2,	dx
		or	ax, dx
		jnz	short loc_10590
		jmp	loc_10682
; ---------------------------------------------------------------------------

loc_10590:				; CODE XREF: sub_10547+44j
		xor	si, si

loc_10592:				; CODE XREF: sub_10547+11Fj
					; sub_10547+127j
		push	ss
		lea	ax, [bp+var_2E]
		push	ax
		call	CopyFilename
		pop	cx
		pop	cx
		mov	[bp+var_E], 0
		mov	[bp+var_C], 0
		mov	al, 0
		push	ax
		push	ss
		lea	ax, [bp+var_2E]
		push	ax
		call	fopen
		add	sp, 6
		mov	di, ax
		xor	ax, ax
		mov	dx, 6
		push	ax
		push	dx
		push	ss
		lea	ax, [bp+var_E]
		push	ax
		push	di
		call	fread
		add	sp, 0Ah
		cmp	[bp+var_C], '0t'
		jnz	short loc_105D7
		cmp	[bp+var_E], 'aC'
		jz	short loc_105E5

loc_105D7:				; CODE XREF: sub_10547+87j
		cmp	[bp+var_C], '1t'
		jnz	short loc_10659
		cmp	[bp+var_E], 'aC'
		jnz	short loc_10659

loc_105E5:				; CODE XREF: sub_10547+8Ej
		cmp	[bp+var_A], 0
		jbe	short loc_10659
		add	si, 24h
		xor	ax, ax
		push	ax
		push	si
		push	word ptr dword_18D3E+2
		push	word ptr dword_18D3E
		call	sub_10207
		add	sp, 8
		mov	[bp+var_4], ax
		mov	[bp+var_2], dx
		or	ax, dx
		jz	short loc_10671
		mov	ax, [bp+var_2]
		mov	dx, [bp+var_4]
		mov	word ptr dword_18D3E, dx
		mov	word ptr dword_18D3E+2,	ax
		mov	ax, word_18D3C
		mov	dx, 24h
		imul	dx
		mov	dx, word ptr dword_18D3E+2
		mov	bx, word ptr dword_18D3E
		add	bx, ax
		mov	word ptr [bp+var_8], bx
		mov	word ptr [bp+var_8+2], dx
		push	ss
		lea	ax, [bp+var_2E]
		push	ax
		push	word ptr [bp+var_8+2]
		push	word ptr [bp+var_8]
		call	sub_15487
		add	sp, 8
		push	ss
		lea	ax, [bp+var_2E]
		push	ax
		call	LoadCatFile
		pop	cx
		pop	cx
		les	bx, [bp+var_8]
		mov	es:[bx+20h], ax
		mov	es:[bx+22h], dx
		inc	word_18D3C

loc_10659:				; CODE XREF: sub_10547+95j
					; sub_10547+9Cj ...
		push	di
		call	fclose
		pop	cx
		call	sub_10C45
		cmp	dx, 0FFFFh
		jz	short loc_10669
		jmp	loc_10592
; ---------------------------------------------------------------------------

loc_10669:				; CODE XREF: sub_10547+11Dj
		cmp	ax, 0FFFFh
		jz	short loc_10671
		jmp	loc_10592
; ---------------------------------------------------------------------------

loc_10671:				; CODE XREF: sub_10547+C1j
					; sub_10547+125j
		cmp	word_18D3C, 0
		jnz	short loc_10682
		push	ds
		mov	ax, 8Eh	; 'Ž'
		push	ax
		call	sub_1021E
		pop	cx
		pop	cx

loc_10682:				; CODE XREF: sub_10547+2Cj
					; sub_10547+46j ...
		pop	di
		pop	si
		mov	sp, bp
		pop	bp
		retn
sub_10547	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

LoadCatFile	proc near		; CODE XREF: sub_10422+1Bp
					; sub_10547+FEp

var_A		= word ptr -0Ah
var_8		= word ptr -8
var_6		= word ptr -6
catData		= dword	ptr -4
arg_0		= word ptr  4
arg_2		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 0Ah
		push	si
		push	di
		mov	al, 0
		push	ax
		push	[bp+arg_2]
		push	[bp+arg_0]
		call	fopen
		add	sp, 6
		mov	si, ax
		or	ax, ax
		jnz	short loc_106AC
		xor	dx, dx
		xor	ax, ax
		jmp	loc_10791
; ---------------------------------------------------------------------------

loc_106AC:				; CODE XREF: LoadCatFile+1Bj
		mov	word ptr [bp+catData], 0
		mov	word ptr [bp+catData+2], 0
		xor	ax, ax
		mov	dx, 6
		push	ax
		push	dx
		push	ss
		lea	ax, [bp+var_A]
		push	ax
		push	si
		call	fread
		add	sp, 0Ah
		mov	al, 0
		push	ax
		xor	ax, ax
		xor	dx, dx
		push	ax
		push	dx
		push	si
		call	sub_10C94
		add	sp, 8
		les	bx, [bp+catData]
		cmp	word ptr es:[bx+4], 0
		ja	short loc_106E6
		jmp	loc_10786
; ---------------------------------------------------------------------------

loc_106E6:				; CODE XREF: LoadCatFile+59j
		cmp	[bp+var_8], '0t'
		jnz	short loc_10721
		cmp	[bp+var_A], 'aC'
		jnz	short loc_10721
		push	si
		call	sub_10BF4
		pop	cx
		mov	di, ax
		xor	ax, ax
		push	ax
		push	di
		call	sub_101F7
		pop	cx
		pop	cx
		mov	word ptr [bp+catData], ax
		mov	word ptr [bp+catData+2], dx
		or	ax, dx
		jz	short loc_10786
		xor	ax, ax
		push	ax
		push	di
		push	word ptr [bp+catData+2]
		push	word ptr [bp+catData]
		push	si
		call	fread
		add	sp, 0Ah
		jmp	short loc_10786
; ---------------------------------------------------------------------------

loc_10721:				; CODE XREF: LoadCatFile+63j
					; LoadCatFile+6Aj
		cmp	[bp+var_8], '1t'
		jnz	short loc_10786
		cmp	[bp+var_A], 'aC'
		jnz	short loc_10786
		mov	ax, [bp+var_6]	; get number of	files
		mov	dx, 16h		; 16h =	size of	TOC entry
		imul	dx
		add	ax, 6		; skip first 6 bytes (.CAT header)
		mov	di, ax
		mov	al, 0
		push	ax
		xor	ax, ax
		mov	dx, 2
		push	ax
		push	dx
		push	si
		call	sub_10C94
		add	sp, 8
		xor	ax, ax
		push	ax
		push	di
		call	sub_101F7
		pop	cx
		pop	cx
		mov	word ptr [bp+catData], ax
		mov	word ptr [bp+catData+2], dx
		or	ax, dx
		jz	short loc_10786
		mov	ax, 6
		push	ax
		push	ss
		lea	ax, [bp+var_A]
		push	ax
		push	word ptr [bp+catData+2]
		push	word ptr [bp+catData]
		call	cat_hdr_copy	; copy 6 bytes of CAT file header
		add	sp, 0Ah
		mov	ax, word ptr [bp+catData]
		add	ax, 6
		push	word ptr [bp+catData+2]
		push	ax
		push	si
		call	ReadDecompr
		add	sp, 6

loc_10786:				; CODE XREF: LoadCatFile+5Bj
					; LoadCatFile+84j ...
		push	si
		call	fclose
		pop	cx
		mov	dx, word ptr [bp+catData+2]
		mov	ax, word ptr [bp+catData]

loc_10791:				; CODE XREF: LoadCatFile+21j
		pop	di
		pop	si
		mov	sp, bp
		pop	bp
		retn
LoadCatFile	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_10797	proc near		; CODE XREF: sub_10298+1Ep
					; sub_10298+94p

var_C		= dword	ptr -0Ch
var_8		= dword	ptr -8
var_4		= dword	ptr -4
arg_0		= word ptr  4
arg_2		= word ptr  6
arg_4		= word ptr  8
arg_6		= word ptr  0Ah

		push	bp
		mov	bp, sp
		sub	sp, 0Ch
		push	si
		push	di
		mov	ax, [bp+arg_6]
		mov	dx, [bp+arg_4]
		mov	word ptr [bp+var_4], dx
		mov	word ptr [bp+var_4+2], ax
		mov	ax, [bp+arg_2]
		mov	dx, [bp+arg_0]
		mov	word ptr [bp+var_C], dx
		mov	word ptr [bp+var_C+2], ax
		les	bx, [bp+var_4]
		cmp	byte ptr es:[bx+1], 3Ah	; ':'
		jnz	short loc_107D1
		mov	al, es:[bx]
		les	bx, [bp+var_C]
		mov	es:[bx], al
		inc	word ptr [bp+var_C]
		add	word ptr [bp+var_4], 2

loc_107D1:				; CODE XREF: sub_10797+28j
		les	bx, [bp+var_C]
		mov	byte ptr es:[bx], 0
		xor	di, di
		mov	si, 0FFFFh
		mov	ax, word ptr [bp+var_4+2]
		mov	dx, word ptr [bp+var_4]
		mov	word ptr [bp+var_8], dx
		mov	word ptr [bp+var_8+2], ax
		jmp	short loc_107F3
; ---------------------------------------------------------------------------

loc_107EB:				; CODE XREF: sub_10797+69j
		cmp	cl, 5Ch	; '\'
		jnz	short loc_107F2
		mov	si, di

loc_107F2:				; CODE XREF: sub_10797+57j
		inc	di

loc_107F3:				; CODE XREF: sub_10797+52j
		les	bx, [bp+var_8]
		inc	word ptr [bp+var_8]
		mov	al, es:[bx]
		mov	cl, al
		or	al, al
		jnz	short loc_107EB
		mov	ax, [bp+arg_2]
		mov	dx, [bp+arg_0]
		inc	dx
		inc	dx
		mov	word ptr [bp+var_C], dx
		mov	word ptr [bp+var_C+2], ax
		or	si, si
		jge	short loc_10828
		jmp	short loc_1082F
; ---------------------------------------------------------------------------

loc_10816:				; CODE XREF: sub_10797+96j
		les	bx, [bp+var_4]
		mov	al, es:[bx]
		les	bx, [bp+var_C]
		mov	es:[bx], al
		inc	word ptr [bp+var_4]
		inc	word ptr [bp+var_C]

loc_10828:				; CODE XREF: sub_10797+7Bj
		mov	ax, si
		dec	si
		or	ax, ax
		jge	short loc_10816

loc_1082F:				; CODE XREF: sub_10797+7Dj
		les	bx, [bp+var_C]
		mov	byte ptr es:[bx], 0
		mov	ax, [bp+arg_2]
		mov	dx, [bp+arg_0]
		add	dx, 43h	; 'C'
		mov	word ptr [bp+var_C], dx
		mov	word ptr [bp+var_C+2], ax
		xor	si, si
		jmp	short loc_1085F
; ---------------------------------------------------------------------------

loc_10849:				; CODE XREF: sub_10797+D5j
		cmp	cl, 2Eh	; '.'
		jz	short loc_1086E
		cmp	si, 8
		jge	short loc_1085F
		les	bx, [bp+var_C]
		mov	al, cl
		mov	es:[bx], al
		inc	word ptr [bp+var_C]
		inc	si

loc_1085F:				; CODE XREF: sub_10797+B0j
					; sub_10797+BAj
		les	bx, [bp+var_4]
		inc	word ptr [bp+var_4]
		mov	al, es:[bx]
		mov	cl, al
		or	al, al
		jnz	short loc_10849

loc_1086E:				; CODE XREF: sub_10797+B5j
		les	bx, [bp+var_C]
		mov	byte ptr es:[bx], 0
		mov	ax, [bp+arg_2]
		mov	dx, [bp+arg_0]
		add	dx, 4Ch	; 'L'
		mov	word ptr [bp+var_C], dx
		mov	word ptr [bp+var_C+2], ax
		cmp	cl, 2Eh	; '.'
		jnz	short loc_108AF
		xor	di, di

loc_1088B:				; CODE XREF: sub_10797+116j
		les	bx, [bp+var_4]
		inc	word ptr [bp+var_4]
		mov	al, es:[bx]
		mov	cl, al
		or	al, al
		jz	short loc_108AF
		les	bx, [bp+var_C]
		mov	al, cl
		mov	es:[bx], al
		inc	word ptr [bp+var_C]
		mov	ax, di
		inc	ax
		mov	di, ax
		cmp	ax, 3
		jl	short loc_1088B

loc_108AF:				; CODE XREF: sub_10797+F0j
					; sub_10797+101j
		les	bx, [bp+var_C]
		mov	byte ptr es:[bx], 0
		pop	di
		pop	si
		mov	sp, bp
		pop	bp
		retn
sub_10797	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_108BC	proc near		; CODE XREF: sub_10298+4Bp
					; sub_10298+D5p

var_8		= dword	ptr -8
var_4		= dword	ptr -4
arg_0		= word ptr  4
arg_2		= word ptr  6
arg_4		= dword	ptr  8

		push	bp
		mov	bp, sp
		sub	sp, 8
		mov	ax, [bp+arg_2]
		mov	dx, [bp+arg_0]
		mov	word ptr [bp+var_8], dx
		mov	word ptr [bp+var_8+2], ax
		les	bx, [bp+arg_4]
		cmp	byte ptr es:[bx], 0
		jz	short loc_108ED
		mov	al, es:[bx]
		les	bx, [bp+var_8]
		mov	es:[bx], al
		inc	word ptr [bp+var_8]
		les	bx, [bp+var_8]
		mov	byte ptr es:[bx], 3Ah ;	':'
		inc	word ptr [bp+var_8]

loc_108ED:				; CODE XREF: sub_108BC+19j
		les	bx, [bp+arg_4]
		cmp	byte ptr es:[bx+2], 0
		jz	short loc_10932
		mov	ax, word ptr [bp+arg_4+2]
		mov	dx, word ptr [bp+arg_4]
		inc	dx
		inc	dx
		mov	word ptr [bp+var_4], dx
		mov	word ptr [bp+var_4+2], ax
		jmp	short loc_10912
; ---------------------------------------------------------------------------

loc_10907:				; CODE XREF: sub_108BC+63j
		les	bx, [bp+var_8]
		mov	al, cl
		mov	es:[bx], al
		inc	word ptr [bp+var_8]

loc_10912:				; CODE XREF: sub_108BC+49j
		les	bx, [bp+var_4]
		inc	word ptr [bp+var_4]
		mov	al, es:[bx]
		mov	cl, al
		or	al, al
		jnz	short loc_10907
		les	bx, [bp+var_8]
		cmp	byte ptr es:[bx-1], 5Ch	; '\'
		jz	short loc_10932
		mov	byte ptr es:[bx], 5Ch ;	'\'
		inc	word ptr [bp+var_8]

loc_10932:				; CODE XREF: sub_108BC+39j
					; sub_108BC+6Dj
		mov	ax, word ptr [bp+arg_4+2]
		mov	dx, word ptr [bp+arg_4]
		add	dx, 43h	; 'C'
		mov	word ptr [bp+var_4], dx
		mov	word ptr [bp+var_4+2], ax
		jmp	short loc_1094E
; ---------------------------------------------------------------------------

loc_10943:				; CODE XREF: sub_108BC+9Fj
		les	bx, [bp+var_8]
		mov	al, cl
		mov	es:[bx], al
		inc	word ptr [bp+var_8]

loc_1094E:				; CODE XREF: sub_108BC+85j
		les	bx, [bp+var_4]
		inc	word ptr [bp+var_4]
		mov	al, es:[bx]
		mov	cl, al
		or	al, al
		jnz	short loc_10943
		les	bx, [bp+arg_4]
		cmp	byte ptr es:[bx+4Ch], 0
		jz	short loc_109B3
		mov	ax, word ptr [bp+arg_4+2]
		mov	dx, word ptr [bp+arg_4]
		add	dx, 4Ch	; 'L'
		mov	word ptr [bp+var_4], dx
		mov	word ptr [bp+var_4+2], ax
		les	bx, [bp+var_8]
		mov	byte ptr es:[bx], 2Eh ;	'.'
		inc	word ptr [bp+var_8]
		les	bx, [bp+var_4]
		mov	al, es:[bx]
		les	bx, [bp+var_8]
		mov	es:[bx], al
		inc	word ptr [bp+var_4]
		inc	word ptr [bp+var_8]
		les	bx, [bp+var_4]
		mov	al, es:[bx]
		les	bx, [bp+var_8]
		mov	es:[bx], al
		inc	word ptr [bp+var_4]
		inc	word ptr [bp+var_8]
		les	bx, [bp+var_4]
		mov	al, es:[bx]
		les	bx, [bp+var_8]
		mov	es:[bx], al
		inc	word ptr [bp+var_8]

loc_109B3:				; CODE XREF: sub_108BC+A9j
		les	bx, [bp+var_8]
		mov	byte ptr es:[bx], 0
		mov	sp, bp
		pop	bp
		retn
sub_108BC	endp


; =============== S U B	R O U T	I N E =======================================

; read file data and decompress	it
; Attributes: bp-based frame

ReadDecompr	proc near		; CODE XREF: LoadCatFile+F8p
					; ReadFullFile+3Dp

dataLen		= word ptr -8
var_6		= word ptr -6
nameTblOfs	= word ptr -4
hFile		= word ptr -2
arg_0		= word ptr  4
dstBuffer	= dword	ptr  6

		push	bp
		mov	bp, sp
		add	sp, -8
		push	bx
		push	cx
		push	si
		push	di
		push	ds
		push	es
		push	seg dseg
		pop	ds
		push	[bp+arg_0]
		call	GetHFile_LIB
		pop	cx
		test	ax, ax
		jnz	short loc_109DC
		jmp	loc_10AE9
; ---------------------------------------------------------------------------

loc_109DC:				; CODE XREF: ReadDecompr+19j
		mov	[bp+hFile], ax
		mov	bx, ax
		push	ds
		mov	cx, 4
		lea	dx, [bp+dataLen]
		push	ss
		pop	ds
		mov	ah, 3Fh
		int	21h		; DOS -	2+ - READ FROM FILE WITH HANDLE
					; BX = file handle, CX = number	of bytes to read
					; DS:DX	-> buffer
		pop	ds
		mov	cx, 200h
		mov	dx, offset comprBuffer
		mov	ah, 3Fh
		int	21h		; DOS -	2+ - READ FROM FILE WITH HANDLE
					; BX = file handle, CX = number	of bytes to read
					; DS:DX	-> buffer
		mov	dx, ax		; DX = remaining bytes in source buffer
		les	di, [bp+dstBuffer] ; DI	= destination buffer for decompressed data
		mov	si, offset comprBuffer ; SI = source buffer with compresse data
		mov	[bp+nameTblOfs], 1
		xor	cx, cx

loc_10A08:				; CODE XREF: ReadDecompr+A3j
					; ReadDecompr+120j
		add	ch, ch
		jnz	short loc_10A2D
		dec	dx
		js	short loc_10A16
		lodsb
		mov	cl, al
		mov	ch, 1
		jmp	short loc_10A2D
; ---------------------------------------------------------------------------

loc_10A16:				; CODE XREF: ReadDecompr+4Fj
		mov	cx, 200h
		mov	dx, offset comprBuffer
		mov	si, dx
		mov	bx, [bp+hFile]
		mov	ah, 3Fh
		int	21h		; DOS -	2+ - READ FROM FILE WITH HANDLE
					; BX = file handle, CX = number	of bytes to read
					; DS:DX	-> buffer
		dec	ax
		mov	dx, ax
		lodsb
		mov	cl, al
		mov	ch, 1

loc_10A2D:				; CODE XREF: ReadDecompr+4Cj
					; ReadDecompr+56j
		test	cl, ch		; test bit from	CH against CL mask
		jz	short loc_10A63
		dec	dx
		js	short loc_10A37
		lodsb
		jmp	short loc_10A4C
; ---------------------------------------------------------------------------

loc_10A37:				; CODE XREF: ReadDecompr+74j
		push	cx
		mov	cx, 200h
		mov	dx, offset comprBuffer
		mov	si, dx
		mov	bx, [bp+hFile]
		mov	ah, 3Fh
		int	21h		; DOS -	2+ - READ FROM FILE WITH HANDLE
					; BX = file handle, CX = number	of bytes to read
					; DS:DX	-> buffer
		dec	ax
		mov	dx, ax
		pop	cx
		lodsb

loc_10A4C:				; CODE XREF: ReadDecompr+77j
		stosb
		push	dx
		mov	bx, offset nameTable
		mov	dx, [bp+nameTblOfs]
		add	bx, dx
		mov	[bx], al
		inc	dx
		and	dx, 0FFFh
		mov	[bp+nameTblOfs], dx
		pop	dx
		jmp	short loc_10A08
; ---------------------------------------------------------------------------

loc_10A63:				; CODE XREF: ReadDecompr+71j
		dec	dx
		js	short loc_10A71
		jz	short loc_10A8F
		lodsb
		mov	bl, al
		lodsb
		mov	bh, al
		dec	dx
		jmp	short loc_10AAB
; ---------------------------------------------------------------------------

loc_10A71:				; CODE XREF: ReadDecompr+A6j
		push	cx
		mov	cx, 200h
		mov	dx, offset comprBuffer
		mov	si, dx
		mov	bx, [bp+hFile]
		mov	ah, 3Fh
		int	21h		; DOS -	2+ - READ FROM FILE WITH HANDLE
					; BX = file handle, CX = number	of bytes to read
					; DS:DX	-> buffer
		sub	ax, 2
		mov	dx, ax
		pop	cx
		lodsb
		mov	bl, al
		lodsb
		mov	bh, al
		jmp	short loc_10AAB
; ---------------------------------------------------------------------------

loc_10A8F:				; CODE XREF: ReadDecompr+A8j
		lodsb
		mov	bl, al
		push	cx
		push	bx
		mov	cx, 200h
		mov	dx, offset comprBuffer
		mov	si, dx
		mov	bx, [bp+hFile]
		mov	ah, 3Fh
		int	21h		; DOS -	2+ - READ FROM FILE WITH HANDLE
					; BX = file handle, CX = number	of bytes to read
					; DS:DX	-> buffer
		dec	ax
		mov	dx, ax
		pop	bx
		pop	cx
		lodsb
		mov	bh, al

loc_10AAB:				; CODE XREF: ReadDecompr+B1j
					; ReadDecompr+CFj
		test	bx, bx
		jz	short loc_10AE1
		push	cx
		push	dx
		push	si
		mov	cl, bl
		shr	bx, 4
		and	cx, 0Fh
		add	cl, 3
		mov	dx, [bp+nameTblOfs]
		mov	si, offset nameTable

loc_10AC3:				; CODE XREF: ReadDecompr+118j
		mov	al, [bx+si]
		inc	bx
		and	bx, 0FFFh
		stosb
		xchg	bx, dx
		mov	[bx+si], al
		inc	bx
		and	bx, 0FFFh
		xchg	bx, dx
		loop	loc_10AC3
		mov	[bp+nameTblOfs], dx
		pop	si
		pop	dx
		pop	cx
		jmp	loc_10A08
; ---------------------------------------------------------------------------

loc_10AE1:				; CODE XREF: ReadDecompr+EFj
		mov	ax, [bp+dataLen]
		mov	dx, [bp+var_6]
		jmp	short loc_10AED
; ---------------------------------------------------------------------------

loc_10AE9:				; CODE XREF: ReadDecompr+1Bj
		xor	ax, ax
		mov	dx, ax

loc_10AED:				; CODE XREF: ReadDecompr+129j
		pop	es
		pop	ds
		pop	di
		pop	si
		pop	cx
		pop	bx
		mov	sp, bp
		pop	bp
		retn
ReadDecompr	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

fopen		proc near		; CODE XREF: OpenFile2+21p
					; sub_10298+E4p ...

fileName	= dword	ptr  4
accessMode	= byte ptr  8

		push	bp
		mov	bp, sp
		push	bx
		push	cx
		push	dx
		push	ds
		push	seg dseg
		pop	ds
		xor	cx, cx
		mov	al, 1
		mov	ah, byte_18D4C

loc_10B0B:				; CODE XREF: fopen+1Bj
		test	ah, al
		jz	short loc_10B18
		inc	cl
		add	al, al
		jnb	short loc_10B0B
		jmp	loc_10BAD
; ---------------------------------------------------------------------------

loc_10B18:				; CODE XREF: fopen+15j
		push	cx
		mov	al, 14h
		mul	cl
		add	ax, 9Eh
		mov	bx, ax
		mov	dx, word ptr [bp+fileName]
		mov	al, [bp+accessMode]
		mov	[bx+12h], al
		cmp	al, 3
		jb	short loc_10B50
		xor	cx, cx
		push	ds
		mov	ds, word ptr [bp+fileName+2]
		cmp	al, 4
		jz	short loc_10B40
		mov	ah, 3Ch
		int	21h		; DOS -	2+ - CREATE A FILE WITH	HANDLE (CREAT)
					; CX = attributes for file
					; DS:DX	-> ASCIZ filename (may include drive and path)
		pop	ds
		jmp	short loc_10B45
; ---------------------------------------------------------------------------

loc_10B40:				; CODE XREF: fopen+3Fj
		mov	ah, 5Bh
		int	21h		; DOS -	3+ - CREATE NEW	FILE
					; DS:DX	-> ASCIZ directory path	name
					; CX = file attribute
		pop	ds

loc_10B45:				; CODE XREF: fopen+46j
		jb	short loc_10BAD
		xor	dx, dx
		mov	[bx], dx
		mov	[bx+2],	dx
		jmp	short loc_10B83
; ---------------------------------------------------------------------------

loc_10B50:				; CODE XREF: fopen+35j
		push	ds
		lds	dx, [bp+fileName]
		mov	al, [bp+accessMode]
		mov	ah, 3Dh
		int	21h		; DOS -	2+ - OPEN DISK FILE WITH HANDLE
					; DS:DX	-> ASCIZ filename
					; AL = access mode
					; 0 - read, 1 -	write, 2 - read	& write
		pop	ds
		jb	short loc_10BAD
		push	bx
		mov	bx, ax
		xor	dx, dx
		mov	cx, dx
		mov	al, 2
		mov	ah, 42h
		int	21h		; DOS -	2+ - MOVE FILE READ/WRITE POINTER (LSEEK)
					; AL = method: offset from end of file
		mov	cx, bx
		pop	bx
		mov	[bx], ax
		mov	[bx+2],	dx
		push	bx
		mov	bx, cx
		xor	dx, dx
		mov	cx, dx
		mov	al, 0
		mov	ah, 42h
		int	21h		; DOS -	2+ - MOVE FILE READ/WRITE POINTER (LSEEK)
					; AL = method: offset from beginning of	file
		mov	ax, bx
		pop	bx

loc_10B83:				; CODE XREF: fopen+56j
		mov	[bx+10h], ax
		xor	ax, ax
		mov	[bx+4],	ax
		mov	[bx+6],	ax
		mov	[bx+8],	ax
		mov	[bx+0Ah], ax
		mov	[bx+0Ch], ax
		mov	[bx+0Eh], ax
		mov	[bx+13h], al
		pop	ax
		mov	ah, 1
		mov	cl, al
		shl	ah, cl
		or	byte_18D4C, ah
		inc	al
		cbw
		jmp	short loc_10BB0
; ---------------------------------------------------------------------------

loc_10BAD:				; CODE XREF: fopen+1Dj
					; fopen:loc_10B45j ...
		pop	ax
		xor	ax, ax

loc_10BB0:				; CODE XREF: fopen+B3j
		pop	ds
		pop	dx
		pop	cx
		pop	bx
		pop	bp
		retn
fopen		endp ; sp-analysis failed


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

fclose		proc near		; CODE XREF: sub_10547+113p
					; LoadCatFile+FFp ...

arg_0		= byte ptr  4

		push	bp
		mov	bp, sp
		push	bx
		push	cx
		push	ds
		push	seg dseg
		pop	ds
		mov	al, 1
		mov	cl, [bp+arg_0]
		dec	cl
		js	short loc_10BED
		shl	al, cl
		test	byte_18D4C, al
		jz	short loc_10BED
		not	al
		and	byte_18D4C, al
		mov	al, 14h
		mul	cl
		add	ax, 9Eh
		mov	bx, ax
		mov	bx, [bx+10h]
		mov	ah, 3Eh
		int	21h		; DOS -	2+ - CLOSE A FILE WITH HANDLE
					; BX = file handle
		jb	short loc_10BED
		xor	al, al
		jmp	short loc_10BEF
; ---------------------------------------------------------------------------

loc_10BED:				; CODE XREF: fclose+11j fclose+19j ...
		mov	al, 0FFh

loc_10BEF:				; CODE XREF: fclose+35j
		pop	ds
		pop	cx
		pop	bx
		pop	bp
		retn
fclose		endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_10BF4	proc near		; CODE XREF: LoadCatFile+6Dp

arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		push	bx
		push	cx
		push	ds
		push	seg dseg
		pop	ds
		mov	ax, [bp+arg_0]
		call	GetFileCatEntry
		jb	short loc_10C11
		jz	short loc_10C11
		mov	bx, ax
		mov	dx, [bx+2]
		mov	ax, [bx]
		jmp	short loc_10C15
; ---------------------------------------------------------------------------

loc_10C11:				; CODE XREF: sub_10BF4+10j
					; sub_10BF4+12j
		xor	ax, ax
		mov	dx, ax

loc_10C15:				; CODE XREF: sub_10BF4+1Bj
		pop	ds
		pop	cx
		pop	bx
		pop	bp
		retn
sub_10BF4	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_10C1A	proc near		; CODE XREF: sub_10547+1Dp

arg_0		= dword	ptr  4

		push	bp
		mov	bp, sp
		push	cx
		push	ds
		lds	dx, [bp+arg_0]
		mov	cx, 27h
		mov	ah, 4Eh
		int	21h		; DOS -	2+ - FIND FIRST	ASCIZ (FINDFIRST)
					; CX = search attributes
					; DS:DX	-> ASCIZ filespec
					; (drive, path,	and wildcards allowed)
		jb	short loc_10C3B
		push	seg dseg
		pop	ds
		call	sub_10F5A
		mov	ax, word_18E08
		mov	dx, word_18E0A
		jmp	short loc_10C41
; ---------------------------------------------------------------------------

loc_10C3B:				; CODE XREF: sub_10C1A+Fj
		xor	ax, ax
		not	ax
		mov	dx, ax

loc_10C41:				; CODE XREF: sub_10C1A+1Fj
		pop	ds
		pop	cx
		pop	bp
		retn
sub_10C1A	endp


; =============== S U B	R O U T	I N E =======================================


sub_10C45	proc near		; CODE XREF: sub_10547+117p
		push	ds
		push	seg dseg
		pop	ds
		call	sub_10F79
		mov	ah, 4Fh
		int	21h		; DOS -	2+ - FIND NEXT ASCIZ (FINDNEXT)
					; [DTA]	= data block from
					; last AH = 4Eh/4Fh call
		jb	short loc_10C5F
		call	sub_10F5A
		mov	ax, word_18E08
		mov	dx, word_18E0A
		jmp	short loc_10C68
; ---------------------------------------------------------------------------

loc_10C5F:				; CODE XREF: sub_10C45+Cj
		call	sub_10F5A
		xor	ax, ax
		not	ax
		mov	dx, ax

loc_10C68:				; CODE XREF: sub_10C45+18j
		pop	ds
		retn
sub_10C45	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

CopyFilename	proc near		; CODE XREF: sub_10547+50p

srcFN		= dword	ptr  4

		push	bp
		mov	bp, sp
		push	ax
		push	si
		push	di
		push	ds
		push	es
		push	seg dseg
		pop	ds
		mov	si, offset byte_18E0C
		les	di, [bp+srcFN]
		cmp	byte ptr [si], '.'
		jz	short loc_10C89

loc_10C81:				; CODE XREF: CopyFilename+1Dj
		lodsb
		cmp	al, ' '
		jle	short loc_10C89
		stosb
		jmp	short loc_10C81
; ---------------------------------------------------------------------------

loc_10C89:				; CODE XREF: CopyFilename+15j
					; CopyFilename+1Aj
		mov	byte ptr es:[di], 0
		pop	es
		pop	ds
		pop	di
		pop	si
		pop	ax
		pop	bp
		retn
CopyFilename	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_10C94	proc near		; CODE XREF: sub_10298+147p
					; LoadCatFile+4Bp ...

arg_0		= word ptr  4
arg_2		= word ptr  6
arg_4		= word ptr  8
arg_6		= byte ptr  0Ah

		push	bp
		mov	bp, sp
		push	bx
		push	cx
		push	dx
		push	si
		push	ds
		push	seg dseg
		pop	ds
		mov	ax, [bp+arg_0]
		call	GetFileCatEntry
		jb	short loc_10D07
		jz	short loc_10D07
		mov	si, ax
		mov	dx, [bp+arg_2]
		mov	cx, [bp+arg_4]
		mov	bl, [bp+arg_6]
		cmp	bl, 1
		jz	short loc_10CCA
		ja	short loc_10CD2
		mov	[si+4],	dx
		mov	[si+6],	cx
		add	dx, [si+8]
		adc	cx, [si+0Ah]
		jmp	short loc_10CE5
; ---------------------------------------------------------------------------

loc_10CCA:				; CODE XREF: sub_10C94+24j
		add	[si+4],	dx
		adc	[si+6],	cx
		jmp	short loc_10CE5
; ---------------------------------------------------------------------------

loc_10CD2:				; CODE XREF: sub_10C94+26j
		add	dx, [si]
		adc	cx, [si+2]
		mov	[si+4],	dx
		mov	[si+6],	cx
		add	dx, [si+8]
		adc	cx, [si+0Ah]
		mov	bl, 0

loc_10CE5:				; CODE XREF: sub_10C94+34j
					; sub_10C94+3Cj
		mov	al, bl
		mov	bx, [si+10h]
		mov	ah, 42h
		int	21h		; DOS -	2+ - MOVE FILE READ/WRITE POINTER (LSEEK)
					; AL = method: offset from beginning of	file
		jnb	short loc_10D0B
		mov	dx, [si+8]
		mov	cx, [si+0Ah]
		mov	al, 0
		mov	bx, [si+10h]
		mov	ah, 42h
		int	21h		; DOS -	2+ - MOVE FILE READ/WRITE POINTER (LSEEK)
					; AL = method: offset from beginning of	file
		xor	ax, ax
		mov	[si+4],	ax
		mov	[si+6],	ax

loc_10D07:				; CODE XREF: sub_10C94+12j
					; sub_10C94+14j
		not	al
		jmp	short loc_10D0D
; ---------------------------------------------------------------------------

loc_10D0B:				; CODE XREF: sub_10C94+5Aj
		xor	al, al

loc_10D0D:				; CODE XREF: sub_10C94+75j
		pop	ds
		pop	si
		pop	dx
		pop	cx
		pop	bx
		pop	bp
		retn
sub_10C94	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

ReadFullFile	proc near		; CODE XREF: ReadSceneFile+23p
					; LoadFile+A3p	...

arg_0		= word ptr  4
arg_2		= word ptr  6
arg_4		= word ptr  8
arg_6		= word ptr  0Ah
arg_8		= word ptr  0Ch

		push	bp
		mov	bp, sp
		push	bx
		push	cx
		push	si
		push	ds
		push	seg dseg
		pop	ds
		mov	ax, [bp+arg_0]
		call	GetFileCatEntry
		jb	short loc_10D59
		jz	short loc_10D59
		mov	si, ax
		cmp	byte ptr [si+13h], 0 ; check "compression" flag
		ja	short loc_10D48
		push	[bp+arg_8]
		push	[bp+arg_6]
		push	[bp+arg_4]
		push	[bp+arg_2]
		push	[bp+arg_0]
		call	fread
		add	sp, 0Ah
		jmp	short loc_10D5D
; ---------------------------------------------------------------------------

loc_10D48:				; CODE XREF: ReadFullFile+1Bj
		push	[bp+arg_4]
		push	[bp+arg_2]
		push	[bp+arg_0]
		call	ReadDecompr
		add	sp, 6
		jmp	short loc_10D5D
; ---------------------------------------------------------------------------

loc_10D59:				; CODE XREF: ReadFullFile+11j
					; ReadFullFile+13j
		xor	ax, ax
		mov	dx, ax

loc_10D5D:				; CODE XREF: ReadFullFile+32j
					; ReadFullFile+43j
		pop	ds
		pop	si
		pop	cx
		pop	bx
		pop	bp
		retn
ReadFullFile	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

fread		proc near		; CODE XREF: sub_10547+7Cp
					; LoadCatFile+3Bp ...

var_8		= dword	ptr -8
var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  4
arg_2		= word ptr  6
arg_4		= word ptr  8
arg_6		= word ptr  0Ah
arg_8		= word ptr  0Ch

		push	bp
		mov	bp, sp
		add	sp, 0FFF8h
		push	bx
		push	cx
		push	si
		push	ds
		push	seg dseg
		pop	ds
		mov	ax, [bp+arg_0]
		call	GetFileCatEntry
		jnb	short loc_10D7C
		jmp	loc_10E17
; ---------------------------------------------------------------------------

loc_10D7C:				; CODE XREF: fread+14j
		jnz	short loc_10D81
		jmp	loc_10E17
; ---------------------------------------------------------------------------

loc_10D81:				; CODE XREF: fread:loc_10D7Cj
		mov	si, ax
		mov	ax, [bp+arg_4]
		mov	cx, [bp+arg_2]
		test	cx, cx
		jns	short loc_10D94
		and	cx, 7FFFh
		add	ax, 800h

loc_10D94:				; CODE XREF: fread+28j
		mov	word ptr [bp+var_8+2], ax
		mov	word ptr [bp+var_8], cx
		neg	cx
		add	cx, 8000h
		xor	ax, ax
		mov	[bp+var_4], ax
		mov	[bp+var_2], ax
		mov	bx, [si+2]
		mov	dx, [bp+arg_8]
		cmp	dx, bx
		jbe	short loc_10DB4
		mov	dx, bx

loc_10DB4:				; CODE XREF: fread+4Dj
		mov	bx, [si]
		mov	ax, [bp+arg_6]
		cmp	ax, bx
		jbe	short loc_10DBF
		mov	ax, bx

loc_10DBF:				; CODE XREF: fread+58j
		mov	bx, [si+10h]

loc_10DC2:				; CODE XREF: fread+A4j
		cmp	ax, cx
		jnb	short loc_10DD0
		test	dx, dx
		jnz	short loc_10DD0
		test	ax, ax
		jz	short loc_10E09
		mov	cx, ax

loc_10DD0:				; CODE XREF: fread+61j	fread+65j
		push	ax
		push	dx
		push	ds
		lds	dx, [bp+var_8]
		mov	ah, 3Fh
		int	21h		; DOS -	2+ - READ FROM FILE WITH HANDLE
					; BX = file handle, CX = number	of bytes to read
					; DS:DX	-> buffer
		pop	ds
		pop	dx
		pop	cx
		jb	short loc_10E09
		test	ax, ax
		jz	short loc_10E09
		add	[bp+var_4], ax
		adc	[bp+var_2], 0
		xchg	ax, cx
		sub	ax, cx
		sbb	dx, 0
		push	ax
		mov	ax, word ptr [bp+var_8]
		add	ax, cx
		jns	short loc_10E00
		and	ax, 7FFFh
		add	word ptr [bp+var_8+2], 800h

loc_10E00:				; CODE XREF: fread+93j
		mov	word ptr [bp+var_8], ax
		pop	ax
		mov	cx, 8000h
		jmp	short loc_10DC2
; ---------------------------------------------------------------------------

loc_10E09:				; CODE XREF: fread+69j	fread+7Aj ...
		mov	ax, [bp+var_4]
		mov	dx, [bp+var_2]
		add	[si+4],	ax
		adc	[si+6],	dx
		jmp	short loc_10E1B
; ---------------------------------------------------------------------------

loc_10E17:				; CODE XREF: fread+16j	fread+1Bj
		xor	ax, ax
		mov	dx, ax

loc_10E1B:				; CODE XREF: fread+B2j
		pop	ds
		pop	si
		pop	cx
		pop	bx
		mov	sp, bp
		pop	bp
		retn
fread		endp

; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		add	sp, 0FFF8h
		push	bx
		push	cx
		push	dx
		push	si
		push	ds
		push	seg dseg
		pop	ds
		mov	ax, [bp+4]
		call	GetFileCatEntry
		jnb	short loc_10E3D
		jmp	loc_10EC7
; ---------------------------------------------------------------------------

loc_10E3D:				; CODE XREF: seg000:0E38j
		jnz	short loc_10E42
		jmp	loc_10EC7
; ---------------------------------------------------------------------------

loc_10E42:				; CODE XREF: seg000:loc_10E3Dj
		mov	si, ax
		mov	ax, [bp+8]
		mov	cx, [bp+6]
		test	cx, cx
		jns	short loc_10E55
		and	cx, 7FFFh
		add	ax, 800h

loc_10E55:				; CODE XREF: seg000:0E4Cj
		mov	[bp-6],	ax
		mov	[bp-8],	cx
		neg	cx
		add	cx, 8000h
		xor	ax, ax
		mov	[bp-4],	ax
		mov	[bp-2],	ax
		mov	ax, [bp+0Ah]
		mov	dx, [bp+0Ch]

loc_10E6F:				; CODE XREF: seg000:0EB7j
		cmp	ax, cx
		jnb	short loc_10E7D
		test	dx, dx
		jnz	short loc_10E7D
		test	ax, ax
		jz	short loc_10EB9
		mov	cx, ax

loc_10E7D:				; CODE XREF: seg000:0E71j seg000:0E75j
		push	ax
		push	dx
		mov	bx, [si+10h]
		push	ds
		lds	dx, [bp-8]
		mov	ah, 40h
		int	21h		; DOS -	2+ - WRITE TO FILE WITH	HANDLE
					; BX = file handle, CX = number	of bytes to write, DS:DX -> buffer
		pop	ds
		pop	dx
		pop	cx
		jb	short loc_10EB9
		test	ax, ax
		jz	short loc_10EB9
		add	[bp-4],	ax
		adc	word ptr [bp-2], 0
		xchg	ax, cx
		sub	ax, cx
		sbb	dx, 0
		push	ax
		mov	ax, [bp-8]
		add	ax, cx
		jns	short loc_10EB0
		and	ax, 7FFFh
		add	word ptr [bp-6], 800h

loc_10EB0:				; CODE XREF: seg000:0EA6j
		mov	[bp-8],	ax
		pop	ax
		mov	cx, 8000h
		jmp	short loc_10E6F
; ---------------------------------------------------------------------------

loc_10EB9:				; CODE XREF: seg000:0E79j seg000:0E8Dj ...
		mov	ax, [bp-4]
		mov	dx, [bp-2]
		add	[si+4],	ax
		adc	[si+6],	dx
		jmp	short loc_10ECB
; ---------------------------------------------------------------------------

loc_10EC7:				; CODE XREF: seg000:0E3Aj seg000:0E3Fj
		xor	ax, ax
		mov	dx, ax

loc_10ECB:				; CODE XREF: seg000:0EC5j
		pop	ds
		pop	si
		pop	dx
		pop	cx
		pop	bx
		mov	sp, bp
		pop	bp
		retn

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_10ED4	proc near		; CODE XREF: sub_10298+16Cp

arg_0		= word ptr  4
arg_2		= word ptr  6
arg_4		= word ptr  8
arg_6		= word ptr  0Ah
arg_8		= word ptr  0Ch
arg_A		= word ptr  0Eh
arg_C		= word ptr  10h
arg_E		= byte ptr  12h

		push	bp
		mov	bp, sp
		push	ax
		push	bx
		push	ds
		push	seg dseg
		pop	ds
		mov	ax, [bp+arg_0]
		call	GetFileCatEntry
		jb	short loc_10F13
		jz	short loc_10F13
		mov	bx, ax
		mov	ax, [bp+arg_2]
		mov	[bx], ax
		mov	ax, [bp+arg_4]
		mov	[bx+2],	ax
		mov	ax, [bp+arg_6]
		mov	[bx+8],	ax
		mov	ax, [bp+arg_8]
		mov	[bx+0Ah], ax
		mov	ax, [bp+arg_A]
		mov	[bx+4],	ax
		mov	ax, [bp+arg_C]
		mov	[bx+6],	ax
		mov	al, [bp+arg_E]
		mov	[bx+13h], al

loc_10F13:				; CODE XREF: sub_10ED4+10j
					; sub_10ED4+12j
		pop	ds
		pop	bx
		pop	ax
		pop	bp
		retn
sub_10ED4	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

GetHFile_LIB	proc near		; CODE XREF: ReadDecompr+13p
					; seg000:38E0p

arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		push	bx
		push	ds
		push	seg dseg
		pop	ds
		mov	ax, [bp+arg_0]
		call	GetFileCatEntry
		jb	short loc_10F32
		jz	short loc_10F32
		mov	bx, ax
		mov	ax, [bx+10h]
		jmp	short loc_10F34
; ---------------------------------------------------------------------------

loc_10F32:				; CODE XREF: GetHFile_LIB+Fj
					; GetHFile_LIB+11j
		xor	ax, ax

loc_10F34:				; CODE XREF: GetHFile_LIB+18j
		pop	ds
		pop	bx
		pop	bp
		retn
GetHFile_LIB	endp


; =============== S U B	R O U T	I N E =======================================


GetFileCatEntry	proc near		; CODE XREF: sub_10BF4+Dp sub_10C94+Fp ...
		push	cx
		dec	ax
		js	short loc_10F57
		cmp	ax, 7
		jnb	short loc_10F57
		mov	cl, al
		mov	al, 1
		shl	al, cl
		test	byte_18D4C, al
		pushf
		mov	al, 14h
		mul	cl
		add	ax, 9Eh
		popf
		clc
		jmp	short loc_10F58
; ---------------------------------------------------------------------------

loc_10F57:				; CODE XREF: GetFileCatEntry+2j
					; GetFileCatEntry+7j
		stc

loc_10F58:				; CODE XREF: GetFileCatEntry+1Dj
		pop	cx
		retn
GetFileCatEntry	endp


; =============== S U B	R O U T	I N E =======================================


sub_10F5A	proc near		; CODE XREF: sub_10C1A+15p
					; sub_10C45+Ep	...
		push	bx
		push	cx
		push	si
		push	di
		push	ds
		push	es
		push	ds
		mov	di, 13Eh
		mov	ah, 2Fh
		int	21h		; DOS -	GET DISK TRANSFER AREA ADDRESS
					; Return: ES:BX	-> DTA
		push	es
		pop	ds
		pop	es
		mov	si, bx
		mov	cx, 16h
		rep movsw
		pop	es
		pop	ds
		pop	di
		pop	si
		pop	cx
		pop	bx
		retn
sub_10F5A	endp


; =============== S U B	R O U T	I N E =======================================


sub_10F79	proc near		; CODE XREF: sub_10C45+5p
		push	bx
		push	cx
		push	si
		push	di
		push	es
		mov	ah, 2Fh
		int	21h		; DOS -	GET DISK TRANSFER AREA ADDRESS
					; Return: ES:BX	-> DTA
		mov	si, 13Eh
		mov	di, bx
		mov	cx, 16h
		rep movsw
		pop	es
		pop	di
		pop	si
		pop	cx
		pop	bx
		retn
sub_10F79	endp


; =============== S U B	R O U T	I N E =======================================


sub_10F92	proc near		; CODE XREF: GetChrData+23p
		push	ax
		push	bx
		push	cx
		push	dx
		push	si
		push	di
		push	ds
		push	es
		mov	ax, seg	dseg
		mov	ds, ax
		mov	dl, byte_18E1A
		mov	ax, es
		mov	ds, ax
		mov	si, di
		call	sub_10FE1
		test	dl, 1
		jz	short loc_10FB7
		mov	ax, 0A800h
		call	ApplyBinOp_Or

loc_10FB7:				; CODE XREF: sub_10F92+1Dj
		test	dl, 2
		jz	short loc_10FC2
		mov	ax, 0B000h
		call	ApplyBinOp_Or

loc_10FC2:				; CODE XREF: sub_10F92+28j
		test	dl, 4
		jz	short loc_10FCD
		mov	ax, 0B800h
		call	ApplyBinOp_Or

loc_10FCD:				; CODE XREF: sub_10F92+33j
		test	dl, 8
		jz	short loc_10FD8
		mov	ax, 0E000h
		call	ApplyBinOp_Or

loc_10FD8:				; CODE XREF: sub_10F92+3Ej
		pop	es
		pop	ds
		pop	di
		pop	si
		pop	dx
		pop	cx
		pop	bx
		pop	ax
		retn
sub_10F92	endp


; =============== S U B	R O U T	I N E =======================================


sub_10FE1	proc near		; CODE XREF: sub_10F92+17p
		mov	ax, 0A800h
		call	ApplyBinOp_NAnd
		mov	ax, 0B000h
		call	ApplyBinOp_NAnd
		mov	ax, 0B800h
		call	ApplyBinOp_NAnd
		mov	ax, 0E000h
		call	ApplyBinOp_NAnd
		retn
sub_10FE1	endp


; =============== S U B	R O U T	I N E =======================================


ApplyBinOp_NAnd	proc near		; CODE XREF: sub_10FE1+3p sub_10FE1+9p ...
		push	si
		push	bx
		mov	es, ax
		mov	cx, 10h

loc_11001:				; CODE XREF: ApplyBinOp_NAnd+10j
		lodsw
		not	ax
		and	es:[bx], ax
		add	bx, 50h
		loop	loc_11001
		pop	bx
		pop	si
		retn
ApplyBinOp_NAnd	endp


; =============== S U B	R O U T	I N E =======================================


ApplyBinOp_Or	proc near		; CODE XREF: sub_10F92+22p
					; sub_10F92+2Dp ...
		push	si
		push	bx
		mov	es, ax
		mov	cx, 10h

loc_11016:				; CODE XREF: ApplyBinOp_Or+Ej
		lodsw
		or	es:[bx], ax
		add	bx, 50h
		loop	loc_11016
		pop	bx
		pop	si
		retn
ApplyBinOp_Or	endp

; Input:
;   SI - text address
;   DI - graphic destination address
; Output:
;   AL - character width (0 = half-width, 1 = full-width)

; =============== S U B	R O U T	I N E =======================================


GetChrFromROM	proc near		; CODE XREF: GetChrData+9p
		push	cx
		push	dx
		push	di
		push	di
		xor	ax, ax
		lodsb
		cmp	al, 80h
		jb	short getchr_space
		cmp	al, 0A0h
		jb	short getchr_jis
		cmp	al, 0E0h
		jb	short getchr_space

getchr_jis:				; CODE XREF: GetChrFromROM+Dj
		mov	ah, al		; AH = 80..9F /	E0..FF
		mov	al, 0Bh
		out	68h, al		; Kanji	Access Control:	Bitmap Mode
		lodsb			; AL = Shift-JIS secondary byte
		; now convert Shift-JIS	(reg AH/AL) to JIS code
		add	ah, ah		; AH = 00..3E /	C0..FE
		sub	al, 1Fh
		js	short loc_11046
		cmp	al, 61h
		adc	al, 0DEh	; original_AL <	80h: subtract -21h, else subtract 22h

loc_11046:				; CODE XREF: GetChrFromROM+1Ej
		add	ax, 1FA1h	; AH = 1F..5D/DF..1D
		and	ax, 7F7Fh	; AH/AL	now contains the JIS code for the character ROM
		push	ax
		out	0A1h, al	; character code, low byte
					;   00h	= ANK font
					;   01..7Fh = Kanji font (JIS 2nd byte)
		mov	al, ah
		sub	al, 20h
		out	0A3h, al	; character code, high byte
					;   ANK	font: ANK character code
					;   Kanji font:	(JIS 1st byte)-20h
					;     01h..08h,	0Ch..0DFh = full-width
					;     09h..0Bh = half-width
		xor	ah, ah
		mov	cx, 10h

loc_1105A:				; CODE XREF: GetChrFromROM+4Aj
		mov	al, ah
		or	al, 20h		; L/R bit = "right"
		out	0A5h, al	; write	Name Line Counter, font	pattern	"right"
		in	al, 0A9h	; read Name Character Pattern Data
		stosb
		mov	al, ah		; L/R bit = "left"
		out	0A5h, al	; write	Name Line Counter, font	pattern	"left"
		in	al, 0A9h	; read Name Character Pattern Data
		stosb
		inc	ah
		loop	loc_1105A	; read 10h words (20h bytes)
		mov	al, 0Ah
		out	68h, al		; Kanji	Access Control:	Code Access Mode
		pop	cx
		mov	al, 1		; AL = 1 -> full-width
		cmp	cx, 2921h
		jb	short loc_11083
		cmp	cx, 2B7Eh
		ja	short loc_11083
		dec	al		; CX = [2921h..2B7E] ->	AL = 0 -> half-width

loc_11083:				; CODE XREF: GetChrFromROM+57j
					; GetChrFromROM+5Dj
		pop	di
		cmp	cx, 777Eh
		ja	short loc_1109C	; CX = [777Fh..7F7Fh] -> jump
		cmp	cx, 7621h
		jb	short loc_1109C	; CX = [0..7620h] -> jump
		jmp	short loc_110B7	; CX = [7621h..777Eh] -	return
; ---------------------------------------------------------------------------

getchr_space:				; CODE XREF: GetChrFromROM+9j
					; GetChrFromROM+11j
		xor	al, al		; AL = 0 -> half-width
		mov	cx, 20h
		rep stosb		; clear	character memory
		pop	di
		jmp	short loc_110B7
; ---------------------------------------------------------------------------

loc_1109C:				; CODE XREF: GetChrFromROM+66j
					; GetChrFromROM+6Cj
		push	ax
		push	si
		push	ds
		mov	ax, es
		mov	ds, ax
		mov	si, di
		mov	cx, 10h

loc_110A8:				; CODE XREF: GetChrFromROM+90j
		lodsw
		mov	dx, ax
		add	dh, dh
		adc	dl, dl
		or	ax, dx
		stosw
		loop	loc_110A8
		pop	ds
		pop	si
		pop	ax

loc_110B7:				; CODE XREF: GetChrFromROM+6Ej
					; GetChrFromROM+78j
		pop	di
		pop	dx
		pop	cx
		retn
GetChrFromROM	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_110BC	proc near		; CODE XREF: start+E3p
		call	sub_11218
		call	sub_1123C
		call	sub_112B2
		call	sub_10547
		call	ReadSceneFile
		call	SetupInt0A_24
		call	SetupInt15
		les	si, SceneData
		add	si, 100h	; skip first 100h bytes

ScriptMainLop:				; CODE XREF: seg000:37CAj seg000:37D5j ...
		cmp	byte_1D1F3, 0
		jz	short loc_110E3
		call	sub_11503

loc_110E3:				; CODE XREF: sub_110BC+22j
		mov	ax, es:[si]	; read new command word
		inc	si
		inc	si
		cmp	ax, 100h
		jb	short loc_110EF
		xor	ax, ax		; command word >= 100h -> set to 00h (sExitDOS)

loc_110EF:				; CODE XREF: sub_110BC+2Fj
		add	ax, ax
		add	ax, offset scriptFuncList
		mov	bx, ax
		jmp	word ptr cs:[bx]
sub_110BC	endp

; ---------------------------------------------------------------------------
		align 2
scriptFuncList	dw offset sExitDOS	; 0 ; DATA XREF: sub_110BC+35o
		dw offset sUndefined	; 1
		dw offset loc_13F38	; 2
		dw offset loc_13E66	; 3
		dw offset loc_13ED2	; 4
		dw offset loc_13EF0	; 5
		dw offset sApplyPalette	; 6
		dw offset sPalFadeBW1	; 7
		dw offset sPalFadeBW2	; 8
		dw offset sPalMaskToggle; 9
		dw offset sJumpAbs	; 0Ah
		dw offset sCompareVars	; 0Bh
		dw offset sCompareValVal; 0Ch
		dw offset sCondJmp_EQ	; 0Dh
		dw offset sCondJmp_LT	; 0Eh
		dw offset sCondJmp_GT	; 0Fh
		dw offset sCondJmp_GE	; 10h
		dw offset sCondJmp_LE	; 11h
		dw offset sCondJmp_NE	; 12h
		dw offset sTblJump	; 13h
		dw offset sSetPalColour	; 14h
		dw offset loc_145B3	; 15h
		dw offset loc_1458E	; 16h
		dw offset sUndefined	; 17h
		dw offset sLoadVar_Val	; 18h
		dw offset sLoadVar_Var	; 19h
		dw offset sBGM_Play	; 1Ah
		dw offset sBGM_FadeOut	; 1Bh
		dw offset sBGM_Stop	; 1Ch
		dw offset sGetMusMode	; 1Dh
		dw offset loc_14612	; 1Eh
		dw offset sLoadScene	; 1Fh
		dw offset sFillGVRAM	; 20h
		dw offset sDelay	; 21h
		dw offset loc_1382F	; 22h
		dw offset sUndefined	; 23h
		dw offset sAddVar_Val	; 24h
		dw offset sSubVar_Val	; 25h
		dw offset sTextClear_E1	; 26h
		dw offset sAddVar_Cast	; 27h
		dw offset sSubVar_Cast	; 28h
		dw offset sGetVarXY	; 29h
		dw offset sSetVarXY	; 2Ah
		dw offset sUndefined	; 2Bh
		dw offset sUndefined	; 2Ch
		dw offset sClearVars	; 2Dh
		dw offset sUndefined	; 2Eh
		dw offset loc_13FA4	; 2Fh
		dw offset sUndefined	; 30h
		dw offset sUndefined	; 31h
		dw offset loc_145D8	; 32h
		dw offset sWritePortA4	; 33h
		dw offset sReadPortA4	; 34h
		dw offset sTextFill	; 35h
		dw offset loc_13DB3	; 36h
		dw offset sLoadXYBuf	; 37h
		dw offset sAndVar_Var	; 38h
		dw offset sOrVar_Var	; 39h
		dw offset loc_13FB5	; 3Ah
		dw offset loc_13FC6	; 3Bh
		dw offset sTextClear_01	; 3Ch
		dw offset sMulVar_Var	; 3Dh
		dw offset sDivVar_Var	; 3Eh
		dw offset loc_14761	; 3Fh
		dw offset loc_1462E	; 40h
		dw offset loc_14674	; 41h
		dw offset loc_146B1	; 42h
		dw offset loc_1473B	; 43h
		dw offset sUndefined	; 44h
		dw offset sUndefined	; 45h
		dw offset sUndefined	; 46h
		dw offset sUndefined	; 47h
		dw offset sUndefined	; 48h
		dw offset sUndefined	; 49h
		dw offset sSaveVarBuf	; 4Ah
		dw offset sLoadVarBuf	; 4Bh
		dw offset loc_1474F	; 4Ch
		dw offset sBGM_GetMeas	; 4Dh
		dw offset sSFX_PlaySSG	; 4Eh
		dw offset sSFX_PlayFM	; 4Fh
		dw offset sBGM_GetState	; 50h
		dw offset sAndVar_Val	; 51h
		dw offset sOrVar_Val	; 52h
		dw offset sStrCat	; 53h
		dw offset sCall		; 54h
		dw offset sReturn	; 55h
		dw offset sCompareStrs	; 56h
		dw offset sStrNCpy	; 57h
		dw offset sStrChrCat	; 58h
		dw offset sStr_SetVal	; 59h
		dw offset sStrClear	; 5Ah
		dw offset sStrCopy	; 5Bh
		dw offset sUndefined	; 5Ch
		dw offset sUndefined	; 5Dh
		dw offset sSomethingClear; 5Eh
		dw offset sStr_SetDate	; 5Fh
		dw offset sGetFileDate	; 60h
		dw offset sSaveXYBuf	; 61h
		dw offset loc_1400E	; 62h
		dw offset loc_13FF6	; 63h
		dw offset loc_14002	; 64h
		dw offset sUndefined	; 65h
		dw offset sUndefined	; 66h
		dw offset loc_140EE	; 67h
		dw offset loc_1406D	; 68h
		dw offset loc_1419A	; 69h
		dw offset loc_146C3	; 6Ah
		dw offset loc_146DB	; 6Bh
		dw offset sUndefined	; 6Ch
		dw offset sUndefined	; 6Dh
		dw offset sStrLen	; 6Eh
		dw offset sUndefined	; 6Fh
		dw offset sUndefined	; 70h
		dw offset sUndefined	; 71h
		dw offset sLoopInit	; 72h
		dw offset sLoopGet	; 73h
		dw offset sLoopJumpVal	; 74h
		dw offset sLoadFontChr	; 75h
		dw offset loc_14560	; 76h
		dw offset loc_14565	; 77h
		dw offset loc_1457B	; 78h
		dw offset sScriptSomething; 79h
		dw offset sLoopSetVar	; 7Ah
		dw offset sLoopJumpVar	; 7Bh
		dw offset sUndefined	; 7Ch
		dw offset sUndefined	; 7Dh
		dw offset sUndefined	; 7Eh
		dw offset sExitDOSVar	; 7Fh
		dw offset sStrsFromFile	; 80h
		dw offset sStrsToFile	; 81h
		dw offset loc_14AA8	; 82h
		dw offset loc_14B1A	; 83h
		dw offset loc_14C1A	; 84h
		dw offset loc_14FEF	; 85h
		dw offset loc_151EC	; 86h
		dw offset loc_15252	; 87h
		dw offset loc_152C6	; 88h
		dw offset loc_152EA	; 89h
		dw offset loc_1531F	; 8Ah
		dw offset loc_15350	; 8Bh
		dw offset loc_15371	; 8Ch
		dw offset loc_149E4	; 8Dh
		dw offset loc_153D1	; 8Eh

; =============== S U B	R O U T	I N E =======================================


sub_11218	proc near		; CODE XREF: sub_110BCp
		push	ds
		mov	ah, 41h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		mov	ch, 0C0h
		mov	ah, 42h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		mov	al, 1
		out	6Ah, al
		mov	al, 41h
		out	6Ah, al
		mov	ah, 40h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		push	seg seg001
		pop	ds
		assume ds:seg001
		mov	dx, offset a03l1h5h ; "\x1B)0\x1B[>3l\x1B[>1h\x1B[>5h\x1B*$"
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		pop	ds
		assume ds:dseg
		retn
sub_11218	endp


; =============== S U B	R O U T	I N E =======================================


sub_1123C	proc near		; CODE XREF: sub_110BC+3p
		push	ds
		push	ds
		pop	es
		assume es:dseg
		mov	ah, 62h
		int	21h		; DOS -	3+ - GET PSP ADDRESS
		mov	ds, bx
		mov	si, 81h
		mov	di, offset byte_1CFE2
		mov	bx, offset word_1CFDA
		mov	es:byte_1D061, 0

loc_11254:				; CODE XREF: sub_1123C+2Cj
					; sub_1123C+53j
		mov	al, [si]
		cmp	al, 0Dh
		jz	short loc_11291
		cmp	al, ' '
		jbe	short loc_11267
		mov	ah, [si+1]
		cmp	ax, 8140h
		jnz	short loc_1126A
		inc	si

loc_11267:				; CODE XREF: sub_1123C+20j
		inc	si
		jmp	short loc_11254
; ---------------------------------------------------------------------------

loc_1126A:				; CODE XREF: sub_1123C+28j
		cmp	es:byte_1D061, 4
		jnb	short loc_11291
		inc	es:byte_1D061
		mov	es:[bx], di
		inc	bx
		inc	bx

loc_1127C:				; CODE XREF: sub_1123C+4Ej
		stosb
		inc	si
		mov	al, [si]
		cmp	al, ' '
		jbe	short loc_1128C
		mov	ah, [si+1]
		cmp	ax, 8140h
		jnz	short loc_1127C

loc_1128C:				; CODE XREF: sub_1123C+46j
		xor	al, al
		stosb
		jmp	short loc_11254
; ---------------------------------------------------------------------------

loc_11291:				; CODE XREF: sub_1123C+1Cj
					; sub_1123C+34j
		cmp	es:byte_1D061, 2
		jnb	short loc_112B0
		push	seg seg001
		pop	ds
		assume ds:seg001
		mov	dx, offset a03l1l5l ; "\x1B)0\x1B[>3l\x1B[>1l\x1B[>5l\x1B*$"
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		mov	dx, offset aSystem98Ver	; "System-98 version 3.10\r\n(c) Copyright 1"...
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		mov	ax, 4C01h
		int	21h		; DOS -	2+ - QUIT WITH EXIT CODE (EXIT)
					; AL = exit code
; ---------------------------------------------------------------------------

loc_112B0:				; CODE XREF: sub_1123C+5Bj
		pop	ds
		assume ds:dseg
		retn
sub_1123C	endp


; =============== S U B	R O U T	I N E =======================================


sub_112B2	proc near		; CODE XREF: sub_110BC+6p
		push	0
		push	0C400h
		call	sub_101F7
		pop	cx
		pop	cx
		mov	cx, ax
		or	cx, dx
		jz	short loc_11317
		mov	cx, ax
		shr	ax, 4
		add	dx, ax
		and	cx, 0Fh
		mov	word ptr SceneData, cx
		mov	word ptr SceneData+2, dx
		call	sub_11328
		jb	short loc_11317
		mov	word_1D170, ax
		call	sub_11328
		jb	short loc_11317
		mov	word_1D172, ax
		call	sub_11328
		jb	short loc_11317
		mov	seg_1D16E, ax
		mov	dx, 1
		mov	ax, 8400h
		add	ax, 5800h
		adc	dx, 0
		push	dx
		push	ax
		call	sub_101F7
		pop	cx
		pop	cx
		mov	cx, ax
		or	cx, dx
		jz	short loc_11317
		push	dx
		push	ax
		call	sub_10240
		pop	cx
		pop	cx
		xor	ax, ax
		mov	word_1CE58, ax
		mov	word_1CE56, ax
		jmp	short locret_11327
; ---------------------------------------------------------------------------

loc_11317:				; CODE XREF: sub_112B2+Fj
					; sub_112B2+26j ...
		push	seg seg001
		pop	ds
		assume ds:seg001
		mov	dx, offset aNotEnoughMem ; "Œ»Ý‚Ìƒƒ‚ƒŠó‹µ‚Å‚ÍƒVƒXƒeƒ€‚ðŽÀs‚Å‚«‚"...
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		mov	ax, 4CFEh
		int	21h		; DOS -	2+ - QUIT WITH EXIT CODE (EXIT)
					; AL = exit code
; ---------------------------------------------------------------------------

locret_11327:				; CODE XREF: sub_112B2+63j
		retn
sub_112B2	endp


; =============== S U B	R O U T	I N E =======================================


sub_11328	proc near		; CODE XREF: sub_112B2+23p
					; sub_112B2+2Bp ...
		push	1
		push	10h
		call	sub_101F7
		pop	cx
		pop	cx
		mov	cx, ax
		or	cx, dx
		jz	short loc_11344
		add	ax, 0Fh
		shr	ax, 4
		add	dx, ax
		mov	ax, dx
		clc
		jmp	short locret_11345
; ---------------------------------------------------------------------------

loc_11344:				; CODE XREF: sub_11328+Dj
		stc

locret_11345:				; CODE XREF: sub_11328+1Aj
		retn
sub_11328	endp

		assume ds:dseg

; =============== S U B	R O U T	I N E =======================================


ReadSceneFile	proc near		; CODE XREF: sub_110BC+Cp
		push	ds
		push	offset byte_15AF0
		push	ds
		push	word_1CFDA
		call	OpenFile2
		pop	dx
		pop	dx
		pop	dx
		test	ax, ax
		jz	short loc_1138F
		mov	bx, ax
		push	0
		push	0BC00h
		push	word ptr SceneData+2
		push	word ptr SceneData
		push	bx
		call	ReadFullFile
		mov	cx, ax		; CX = number of read bytes
		call	fclose
		add	sp, 0Ah
		test	cx, cx
		jz	short loc_1138F
		mov	al, 1
		; -- decrypt scene file	data --
		lds	si, SceneData
		add	si, 100h	; skip first 100h bytes
		sub	cx, 100h
		jle	short loc_1138F

loc_11388:				; CODE XREF: ReadSceneFile+45j
		xor	[si], al	; XOR everything with 01h
		inc	si
		loop	loc_11388
		jmp	short loc_1139F
; ---------------------------------------------------------------------------

loc_1138F:				; CODE XREF: ReadSceneFile+10j
					; ReadSceneFile+30j ...
		push	seg seg001
		pop	ds
		assume ds:seg001
		mov	dx, offset aFileLoadErr	; "ƒtƒ@ƒCƒ‹‚Ì“Ç‚Ýž‚Ý‚ÉŽ¸”s‚µ‚Ü‚µ‚½\r\n$"
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		mov	ax, 4C01h
		int	21h		; DOS -	2+ - QUIT WITH EXIT CODE (EXIT)
					; AL = exit code
; ---------------------------------------------------------------------------

loc_1139F:				; CODE XREF: ReadSceneFile+47j
		pop	ds
		assume ds:dseg
		retn
ReadSceneFile	endp


; =============== S U B	R O U T	I N E =======================================


SetupInt0A_24	proc near		; CODE XREF: sub_110BC+Fp
		push	ds
		xor	ax, ax
		mov	es, ax
		assume es:nothing
		or	byte ptr es:500h, 20h
		xor	ax, ax
		mov	PalColLockMask,	ax
		mov	bx, MusicMode_CfgPtr
		mov	al, [bx]
		sub	al, '0'         ; convert ASCII character into an actual number
		mov	MusicMode, al
		mov	bx, offset CallPMD
		cmp	al, 3
		jb	short loc_113C6
		mov	bx, offset CallMMD

loc_113C6:				; CODE XREF: SetupInt0A_24+20j
		mov	CallMusicDriver, bx
		mov	ax, 350Ah	; 0Ah =	INT41
		int	21h		; DOS -	2+ - GET INTERRUPT VECTOR
					; AL = interrupt number
					; Return: ES:BX	= value	of interrupt vector
		mov	word ptr OldIntVec0A, bx
		mov	word ptr OldIntVec0A+2,	es
		push	ds
		push	cs
		pop	ds
		assume ds:seg000
		mov	dx, offset Int0A
		mov	ax, 250Ah	; 0Ah =	INT41
		int	21h		; DOS -	SET INTERRUPT VECTOR
					; AL = interrupt number
					; DS:DX	= new vector to	be used	for specified interrupt
		pop	ds
		assume ds:dseg
		in	al, 2		; DMA controller, 8237A-5.
					; channel 1 current address
		and	al, 0FBh
		out	2, al		; DMA controller, 8237A-5.
					; channel 1 base address
					; (also	sets current address)
		out	64h, al		; 8042 keyboard	controller command register.
		mov	ax, 3524h
		int	21h		; DOS -	2+ - GET INTERRUPT VECTOR
					; AL = interrupt number
					; Return: ES:BX	= value	of interrupt vector
		mov	word ptr OldIntVec24, bx
		mov	word ptr OldIntVec24+2,	es
		push	ds
		push	cs
		pop	ds
		assume ds:seg000
		mov	dx, offset Int24
		mov	ax, 2524h
		int	21h		; DOS -	SET INTERRUPT VECTOR
					; AL = interrupt number
					; DS:DX	= new vector to	be used	for specified interrupt
		pop	es
		assume es:nothing
		mov	ds, word ptr es:44BEh
		assume ds:dseg
		xor	dx, dx
		mov	cl, 13h
		int	0DCh		; used by BASIC	while in interpreter
		mov	ah, 19h
		int	21h		; DOS -	GET DEFAULT DISK NUMBER
		cbw
		mov	bx, ax
		add	bx, bx
		add	al, 'A'
		mov	es:DiskLetter, al
		mov	ax, [bx+1Ah]
		and	ah, 0F0h
		sub	ah, 90h
		mov	es:byte_1D113, ah
		pop	ds
		retn
SetupInt0A_24	endp


; =============== S U B	R O U T	I N E =======================================


RestoreInts	proc near		; CODE XREF: ReadFullFile2:ExitWithErrMsgp
					; sub_11D5E:loc_11D95p	...
		push	ds
		push	seg dseg
		pop	ds
		push	word ptr SceneData+2
		push	word ptr SceneData
		call	sub_10240
		pop	ax
		pop	ax
		cli
		in	al, 0Ah		; DMA controller, 8237A-5.
					; single mask bit register
					; 0-1: select channel (00=0; 01=1; 10=2; 11=3)
					; 2: 1=set mask	for channel; 0=clear mask (enable)
		or	al, 24h
		out	0Ah, al		; DMA controller, 8237A-5.
					; single mask bit register
					; 0-1: select channel (00=0; 01=1; 10=2; 11=3)
					; 2: 1=set mask	for channel; 0=clear mask (enable)
		mov	dx, 7FDFh
		mov	al, 9
		out	dx, al
		sti
		push	ds
		pop	es
		assume es:dseg
		lds	dx, OldIntVec0A
		mov	ax, 250Ah	; 0Ah =	INT41
		int	21h		; DOS -	SET INTERRUPT VECTOR
					; AL = interrupt number
					; DS:DX	= new vector to	be used	for specified interrupt
		lds	dx, es:OldIntVec15
		mov	ax, 2515h
		int	21h		; DOS -	SET INTERRUPT VECTOR
					; AL = interrupt number
					; DS:DX	= new vector to	be used	for specified interrupt
		lds	dx, es:OldIntVec24
		mov	ax, 2524h
		int	21h		; DOS -	SET INTERRUPT VECTOR
					; AL = interrupt number
					; DS:DX	= new vector to	be used	for specified interrupt
		mov	ah, 41h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		xor	al, al
		out	0A8h, al	; Interrupt Controller #2, 8259A
		out	0AAh, al	; Interrupt Controller #2, 8259A
		out	0ACh, al	; Interrupt Controller #2, 8259A
		out	0AEh, al	; Interrupt Controller #2, 8259A
		push	seg seg001
		pop	ds
		assume ds:seg001
		mov	dx, offset a5l	; "\x1B*\x1B[>5l$"
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		mov	ax, 0C00h
		int	21h		; DOS -	CLEAR KEYBOARD BUFFER
					; AL must be 01h, 06h, 07h, 08h, or 0Ah.
		xor	ax, ax
		mov	es, ax
		assume es:nothing
		and	byte ptr es:500h, 0DFh
		pop	ds
		assume ds:dseg
		retn
RestoreInts	endp


; =============== S U B	R O U T	I N E =======================================


SetupInt15	proc near		; CODE XREF: sub_110BC+12p
		cli
		mov	ax, 3515h
		int	21h		; DOS -	2+ - GET INTERRUPT VECTOR
					; AL = interrupt number
					; Return: ES:BX	= value	of interrupt vector
		mov	word ptr OldIntVec15, bx
		mov	word ptr OldIntVec15+2,	es
		push	ds
		push	cs
		pop	ds
		assume ds:seg000
		mov	dx, offset Int15
		mov	ax, 2515h
		int	21h		; DOS -	SET INTERRUPT VECTOR
					; AL = interrupt number
					; DS:DX	= new vector to	be used	for specified interrupt
		pop	ds
		assume ds:dseg
		xor	ax, ax
		mov	byte_1D1F4, al
		mov	byte_1D1F5, al
		mov	byte_1D1F8, al
		mov	byte_1D1F9, al
		mov	word_1D1FE, ax
		mov	word_1D200, ax
		mov	word_1D202, 320
		mov	word_1D204, 200
		mov	word_1D206, ax
		mov	word_1D208, ax
		mov	word_1D20A, 625
		mov	word_1D20C, 385
		mov	dx, 0BFDBh
		xor	al, al
		out	dx, al
		mov	dx, 7FDFh
		mov	al, 93h
		out	dx, al
		mov	al, 8
		out	dx, al
		mov	al, 0Fh
		out	dx, al
		mov	dx, 7FDDh
		mov	al, 80h
		out	dx, al
		in	al, 0Ah
		and	al, 0DFh
		out	0Ah, al
		sti
		retn
SetupInt15	endp


; =============== S U B	R O U T	I N E =======================================


sub_11503	proc near		; CODE XREF: sub_110BC+24p
		cli
		mov	byte_1D1F4, 0
		cmp	byte_1D1F5, 41h	; 'A'
		jz	short loc_1151C
		mov	bx, word_1D1E5
		mov	al, byte_1D1F6
		cbw
		mov	[bx], ax
		jmp	short loc_1152E
; ---------------------------------------------------------------------------

loc_1151C:				; CODE XREF: sub_11503+Bj
		mov	bx, word_1D1E9
		mov	ax, word_1D202
		mov	[bx], ax
		mov	bx, word_1D1EB
		mov	ax, word_1D204
		mov	[bx], ax

loc_1152E:				; CODE XREF: sub_11503+17j
		mov	bx, word_1D1E7
		mov	al, byte_1D1F9
		cbw
		mov	[bx], ax
		mov	byte_1D1F3, ah
		sti
		mov	ah, al

loc_1153F:				; CODE XREF: sub_11503+41j
		mov	al, byte_1D1F9
		cmp	al, ah
		jz	short loc_1153F
		mov	si, word_1D1F1
		retn
sub_11503	endp

; ---------------------------------------------------------------------------

Int15:					; DATA XREF: SetupInt15+11o
		push	ax
		push	bx
		push	cx
		push	dx
		push	si
		push	di
		push	ds
		push	es
		push	seg dseg
		pop	ds
		in	al, 0Ah		; DMA controller, 8237A-5.
					; single mask bit register
					; 0-1: select channel (00=0; 01=1; 10=2; 11=3)
					; 2: 1=set mask	for channel; 0=clear mask (enable)
		or	al, 20h
		out	0Ah, al		; DMA controller, 8237A-5.
					; single mask bit register
					; 0-1: select channel (00=0; 01=1; 10=2; 11=3)
					; 2: 1=set mask	for channel; 0=clear mask (enable)
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
		out	5Fh, al
		in	al, 8		; DMA 8237A-5. status register bits:
					; 0-3: channel 0-3 has reached terminal	count
					; 4-7: channel 0-3 has a request pending
		or	al, al
		jnz	short loc_11571
		mov	al, 20h	; ' '
		out	0, al

loc_11571:				; CODE XREF: seg000:156Bj
		sti
		mov	al, 20h	; ' '
		mov	dx, 7FDDh
		out	dx, al
		mov	dx, 7FD9h
		in	al, dx
		shl	al, 4
		mov	ah, al
		xor	al, al
		mov	dx, 7FDDh
		out	dx, al
		mov	dx, 7FD9h
		in	al, dx
		and	al, 0Fh
		or	al, ah
		cbw
		mov	word_1D1FE, ax
		mov	al, 60h	; '`'
		mov	dx, 7FDDh
		out	dx, al
		mov	dx, 7FD9h
		in	al, dx
		shl	al, 4
		mov	ah, al
		mov	al, 40h	; '@'
		mov	dx, 7FDDh
		out	dx, al
		mov	dx, 7FD9h
		in	al, dx
		and	al, 0Fh
		or	al, ah
		cbw
		mov	word_1D200, ax
		xor	ax, ax
		mov	es, ax
		mov	al, es:byte_191E1
		mov	ah, al
		and	al, 4
		mov	byte_1D1FA, al
		mov	al, ah
		and	al, 8
		mov	byte_1D1FC, al
		mov	al, ah
		and	al, 10h
		mov	byte_1D1FD, al
		mov	al, ah
		and	al, 20h
		mov	byte_1D1FB, al
		mov	al, es:byte_191E2
		mov	ah, al
		and	al, 8
		or	byte_1D1FA, al
		and	ah, 40h
		or	byte_1D1FC, ah
		mov	al, es:byte_191E3
		mov	ah, al
		and	al, 1
		or	byte_1D1FD, al
		and	ah, 8
		or	byte_1D1FB, ah
		mov	ax, word_1D1FE
		add	ax, word_1D202
		cmp	byte_1D1FC, 0
		jz	short loc_11613
		sub	ax, 2
		and	al, 0FEh
		jmp	short loc_1161F
; ---------------------------------------------------------------------------

loc_11613:				; CODE XREF: seg000:160Aj
		cmp	byte_1D1FD, 0
		jz	short loc_1161F
		add	ax, 2
		and	al, 0FEh

loc_1161F:				; CODE XREF: seg000:1611j seg000:1618j
		cmp	ax, word_1D206
		jns	short loc_11628
		mov	ax, word_1D206

loc_11628:				; CODE XREF: seg000:1623j
		cmp	ax, word_1D20A
		jb	short loc_11631
		mov	ax, word_1D20A

loc_11631:				; CODE XREF: seg000:162Cj
		mov	word_1D202, ax
		mov	ax, word_1D200
		add	ax, word_1D204
		cmp	byte_1D1FA, 0
		jz	short loc_11649
		sub	ax, 2
		and	al, 0FEh
		jmp	short loc_11655
; ---------------------------------------------------------------------------

loc_11649:				; CODE XREF: seg000:1640j
		cmp	byte_1D1FB, 0
		jz	short loc_11655
		add	ax, 2
		and	al, 0FEh

loc_11655:				; CODE XREF: seg000:1647j seg000:164Ej
		cmp	ax, word_1D208
		jns	short loc_1165E
		mov	ax, word_1D208

loc_1165E:				; CODE XREF: seg000:1659j
		cmp	ax, word_1D20C
		jb	short loc_11667
		mov	ax, word_1D20C

loc_11667:				; CODE XREF: seg000:1662j
		mov	word_1D204, ax
		xor	al, al
		mov	dx, 7FDDh
		out	dx, al
		mov	dx, 7FD9h
		in	al, dx
		not	al
		mov	ah, al
		shr	ah, 6
		and	ah, 2
		shr	al, 5
		and	al, 1
		or	ah, al
		mov	al, es:byte_191DA
		and	al, 1
		or	ah, al
		mov	al, es:byte_191DD
		shr	al, 3
		and	al, 2
		or	ah, al
		mov	al, es:byte_191DF
		shr	al, 1
		and	al, 3
		or	ah, al
		mov	al, es:byte_191E0
		shr	al, 3
		and	al, 2
		or	ah, al
		mov	al, es:byte_191E2
		shr	al, 1
		and	al, 1
		or	ah, al
		mov	al, es:byte_191E3
		shr	al, 6
		and	al, 1
		or	al, ah
		mov	byte_1D1F9, al
		mov	byte_1D1F3, 0
		cmp	byte_1D1F4, 0
		jz	short loc_116DE
		mov	byte_1D1F3, al
		cmp	byte_1D1F5, 40h	; '@'
		jnz	short loc_116DE
		call	sub_11716

loc_116DE:				; CODE XREF: seg000:16CFj seg000:16D9j
		mov	ax, word_1D1FE
		or	ax, word_1D200
		or	al, byte_1D1FA
		or	al, byte_1D1FB
		or	al, byte_1D1FC
		or	al, byte_1D1FD
		jz	short $+2
		mov	dx, 7FDDh
		mov	al, 80h
		out	dx, al
		mov	al, 0A0h
		out	dx, al
		mov	al, 0C0h
		out	dx, al
		mov	al, 0E0h
		out	dx, al
		cli
		in	al, 0Ah		; DMA controller, 8237A-5.
					; single mask bit register
					; 0-1: select channel (00=0; 01=1; 10=2; 11=3)
					; 2: 1=set mask	for channel; 0=clear mask (enable)
		and	al, 0DFh
		out	0Ah, al		; DMA controller, 8237A-5.
					; single mask bit register
					; 0-1: select channel (00=0; 01=1; 10=2; 11=3)
					; 2: 1=set mask	for channel; 0=clear mask (enable)
		pop	es
		assume es:nothing
		pop	ds
		pop	di
		pop	si
		pop	dx
		pop	cx
		pop	bx
		pop	ax
		iret

; =============== S U B	R O U T	I N E =======================================


sub_11716	proc near		; CODE XREF: seg000:16DBp
		les	si, dword_1D1ED
		cld

loc_1171B:				; CODE XREF: sub_11716+13j
		cmp	byte ptr es:[si], 0
		jz	short loc_1172B
		call	sub_11740
		jb	short locret_1173F
		add	si, 0Ah
		jmp	short loc_1171B
; ---------------------------------------------------------------------------

loc_1172B:				; CODE XREF: sub_11716+9j
		cmp	byte_1D1F7, 0FFh
		jz	short locret_1173F
		call	sub_117F8
		mov	byte_1D1F6, 0
		mov	byte_1D1F7, 0FFh

locret_1173F:				; CODE XREF: sub_11716+Ej
					; sub_11716+1Aj
		retn
sub_11716	endp


; =============== S U B	R O U T	I N E =======================================


sub_11740	proc near		; CODE XREF: sub_11716+Bp
		mov	ax, es:[si+2]
		cmp	word_1D202, ax
		jb	short loc_117B6
		mov	ax, es:[si+4]
		cmp	word_1D204, ax
		jb	short loc_117B6
		mov	ax, es:[si+6]
		dec	ax
		cmp	ax, word_1D202
		jb	short loc_117B6
		mov	ax, es:[si+8]
		dec	ax
		cmp	ax, word_1D204
		jb	short loc_117B6
		mov	al, es:[si]
		cmp	al, byte_1D1F6
		jnz	short loc_11776
		stc
		jmp	short locret_117B7
; ---------------------------------------------------------------------------

loc_11776:				; CODE XREF: sub_11740+31j
		mov	byte_1D1F6, al
		cmp	byte_1D1F7, 0FFh
		jz	short loc_11783
		call	sub_117F8

loc_11783:				; CODE XREF: sub_11740+3Ej
		call	sub_1186D
		push	si
		push	es
		call	sub_117B8
		mov	bx, off_1B22C
		lea	si, [bx+80h]
		mov	ax, 0A800h
		call	sub_1183A
		mov	ax, 0B000h
		call	sub_1183A
		mov	ax, 0B800h
		call	sub_1183A
		mov	ax, 0E000h
		call	sub_1183A
		pop	es
		pop	si
		mov	al, byte_1D1F6
		mov	byte_1D1F7, al
		stc
		jmp	short locret_117B7
; ---------------------------------------------------------------------------

loc_117B6:				; CODE XREF: sub_11740+8j
					; sub_11740+12j ...
		clc

locret_117B7:				; CODE XREF: sub_11740+34j
					; sub_11740+74j
		retn
sub_11740	endp


; =============== S U B	R O U T	I N E =======================================


sub_117B8	proc near		; CODE XREF: sub_11740+48p
		push	di
		push	ds
		mov	si, di
		mov	word_1E61A, si
		mov	word_1E61C, dx
		les	di, off_1E616
		mov	ax, 0A800h
		call	sub_117E3
		mov	ax, 0B000h
		call	sub_117E3
		mov	ax, 0B800h
		call	sub_117E3
		mov	ax, 0E000h
		call	sub_117E3
		pop	ds
		pop	di
		retn
sub_117B8	endp


; =============== S U B	R O U T	I N E =======================================


sub_117E3	proc near		; CODE XREF: sub_117B8+13p
					; sub_117B8+19p ...
		push	si
		mov	ds, ax
		mov	cx, 10h

loc_117E9:				; CODE XREF: sub_117E3+11j
		push	cx
		push	si
		mov	cx, dx
		rep movsw
		pop	si
		add	si, 50h	; 'P'
		pop	cx
		loop	loc_117E9
		pop	si
		retn
sub_117E3	endp


; =============== S U B	R O U T	I N E =======================================


sub_117F8	proc near		; CODE XREF: sub_11716+1Cp
					; sub_11740+40p
		push	si
		push	di
		push	ds
		push	es
		mov	dx, word_1E61C
		mov	di, word_1E61A
		lds	si, off_1E616
		mov	ax, 0A800h
		call	sub_11825
		mov	ax, 0B000h
		call	sub_11825
		mov	ax, 0B800h
		call	sub_11825
		mov	ax, 0E000h
		call	sub_11825
		pop	es
		pop	ds
		pop	di
		pop	si
		retn
sub_117F8	endp


; =============== S U B	R O U T	I N E =======================================


sub_11825	proc near		; CODE XREF: sub_117F8+13p
					; sub_117F8+19p ...
		push	di
		mov	es, ax
		mov	cx, 10h

loc_1182B:				; CODE XREF: sub_11825+11j
		push	cx
		push	di
		mov	cx, dx
		rep movsw
		pop	di
		add	di, 50h	; 'P'
		pop	cx
		loop	loc_1182B
		pop	di
		retn
sub_11825	endp


; =============== S U B	R O U T	I N E =======================================


sub_1183A	proc near		; CODE XREF: sub_11740+56p
					; sub_11740+5Cp ...
		push	dx
		push	si
		push	di
		mov	es, ax
		mov	cx, 10h

loc_11842:				; CODE XREF: sub_1183A+2Dj
		push	cx
		push	di
		push	dx
		mov	cx, dx

loc_11847:				; CODE XREF: sub_1183A+21j
		mov	dx, [si]
		or	dx, [di+596Eh]
		and	es:[di], dx
		mov	ax, [bx]
		not	dx
		and	ax, dx
		or	es:[di], ax
		inc	di
		inc	di
		loop	loc_11847
		pop	dx
		inc	si
		inc	si
		inc	bx
		inc	bx
		pop	di
		add	di, 50h	; 'P'
		pop	cx
		loop	loc_11842
		pop	di
		pop	si
		pop	dx
		retn
sub_1183A	endp


; =============== S U B	R O U T	I N E =======================================


sub_1186D	proc near		; CODE XREF: sub_11740:loc_11783p
		mov	di, es:[si+4]
		mov	ax, es:[si+2]
		shr	ax, 3
		shl	di, 4
		add	ax, di
		add	di, di
		add	di, di
		add	di, ax
		mov	dx, es:[si+6]
		sub	dx, es:[si+2]
		shr	dx, 4
		retn
sub_1186D	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

LoadFile	proc near		; CODE XREF: seg000:37A8p seg000:3A86p ...

arg_0		= dword	ptr  4

		push	bp
		mov	bp, sp
		push	ds
		push	es
		push	seg seg001
		pop	ds
		assume ds:seg001
		mov	word_18AF0, offset aFileLoadErr	; "ƒtƒ@ƒCƒ‹‚Ì“Ç‚Ýž‚Ý‚ÉŽ¸”s‚µ‚Ü‚µ‚½\r\n$"
		push	seg dseg
		pop	ds
		assume ds:dseg
		call	sub_119E2
		mov	al, DiskLetter
		mov	ah, ':'
		mov	FileDiskDrive, ax
		les	bx, [bp+arg_0]
		cmp	byte_1D113, 0
		jnz	short loc_1190A
		xor	ah, ah
		mov	al, es:[bx]
		cmp	al, 2
		cmc
		adc	byte ptr FileDiskDrive,	ah
		add	ax, 825Fh	; 825Fh	= full-width 'A'
		mov	byte ptr aInsertDiskX+12h, ah
		mov	byte ptr aInsertDiskX+13h, al
		call	strdup_fn

loc_118D0:				; CODE XREF: LoadFile+79j
		push	0
		push	ds
		push	offset FileDiskDrive
		call	OpenFile2
		pop	dx
		pop	dx
		pop	dx
		test	ax, ax
		jnz	short loc_11920
		mov	al, 0Ch
		call	WriteIO_A2
		xor	al, al
		mov	byte_1E5C6, al
		out	0A8h, al	; Interrupt Controller #2, 8259A
		out	0AAh, al	; Interrupt Controller #2, 8259A
		out	0ACh, al	; Interrupt Controller #2, 8259A
		out	0AEh, al	; Interrupt Controller #2, 8259A
		mov	dx, offset aInsertDiskX	; "\x1B*\x1B=+.ƒhƒ‰ƒCƒu‚Q‚É‚`ƒfƒBƒXƒN‚ðƒZƒbƒg‚µ‚"...
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"

loc_118F9:				; CODE XREF: LoadFile+6Fj
		mov	al, byte_1D1F9
		or	al, al
		jz	short loc_118F9
		mov	al, 0Dh
		call	WriteIO_A2
		call	sub_11A19
		jmp	short loc_118D0
; ---------------------------------------------------------------------------

loc_1190A:				; CODE XREF: LoadFile+26j
		call	strdup_fn
		push	0
		push	ds
		push	offset FileDiskDrive
		call	OpenFile2
		pop	dx
		pop	dx
		pop	dx
		test	ax, ax
		jnz	short loc_11920
		stc
		jmp	short loc_11940
; ---------------------------------------------------------------------------

loc_11920:				; CODE XREF: LoadFile+4Fj LoadFile+8Cj
		mov	bx, ax
		push	0
		push	FileBufSize
		push	word ptr FileLoadDstPtr+2
		push	word ptr FileLoadDstPtr
		push	bx
		call	ReadFullFile
		xchg	ax, bx
		call	fclose
		add	sp, 0Ah
		clc
		call	sub_11A19

loc_11940:				; CODE XREF: LoadFile+8Fj
		pop	es
		pop	ds
		pop	bp
		retn
LoadFile	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

WriteFile	proc near		; CODE XREF: seg000:3A4Ap seg000:3AAEp ...

arg_0		= dword	ptr  4

		push	bp
		mov	bp, sp
		push	ds
		push	es
		push	seg seg001
		pop	ds
		assume ds:seg001
		mov	word_18AF0, offset aFileWriteErr ; "ƒtƒ@ƒCƒ‹‚Ì‘‚«ž‚Ý‚ÉŽ¸”s‚µ‚Ü‚µ‚½\r\n$"
		push	seg dseg
		pop	ds
		assume ds:dseg
		call	sub_119E2
		mov	al, DiskLetter
		mov	ah, ':'
		mov	FileDiskDrive, ax
		les	bx, [bp+arg_0]
		cmp	byte_1D113, 0
		jnz	short loc_11976
		cmp	byte ptr es:[bx], 2
		cmc
		adc	byte ptr FileDiskDrive,	0

loc_11976:				; CODE XREF: WriteFile+26j
		call	strdup_fn
		mov	dx, offset FileDiskDrive
		xor	cx, cx
		mov	ah, 3Ch
		int	21h		; DOS -	2+ - CREATE A FILE WITH	HANDLE (CREAT)
					; CX = attributes for file
					; DS:DX	-> ASCIZ filename (may include drive and path)
		jnb	short loc_11987
		stc
		jmp	short loc_1199E
; ---------------------------------------------------------------------------

loc_11987:				; CODE XREF: WriteFile+3Ej
		mov	cx, FileBufSize
		lds	dx, FileLoadDstPtr
		mov	bx, ax
		mov	ah, 40h
		int	21h		; DOS -	2+ - WRITE TO FILE WITH	HANDLE
					; BX = file handle, CX = number	of bytes to write, DS:DX -> buffer
		pushf
		mov	ah, 3Eh
		int	21h		; DOS -	2+ - CLOSE A FILE WITH HANDLE
					; BX = file handle
		popf
		call	sub_11A19

loc_1199E:				; CODE XREF: WriteFile+41j
		pop	es
		pop	ds
		pop	bp
		retn
WriteFile	endp

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR ReadFullFile2

ExitWithErrMsg:				; CODE XREF: LoadPIImage2+27j
					; ReadFullFile2+30j ...
		call	RestoreInts
		push	ds
		push	seg seg001
		pop	ds
		assume ds:seg001
		mov	dx, word_18AF0
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		pop	ds
		assume ds:dseg
		mov	bx, offset FileDiskDrive

loc_119B6:				; CODE XREF: ReadFullFile2-15BDj
		mov	dl, [bx]
		inc	bx
		or	dl, dl
		jz	short loc_119C3
		mov	ah, 2
		int	21h		; DOS -	DISPLAY	OUTPUT
					; DL = character to send to standard output
		jmp	short loc_119B6
; ---------------------------------------------------------------------------

loc_119C3:				; CODE XREF: ReadFullFile2-15C3j
		mov	ax, 4C01h
		int	21h		; DOS -	2+ - QUIT WITH EXIT CODE (EXIT)
; END OF FUNCTION CHUNK	FOR ReadFullFile2 ; AL = exit code
; ---------------------------------------------------------------------------
		retn

; =============== S U B	R O U T	I N E =======================================


strdup_fn	proc near		; CODE XREF: LoadFile+3Ep
					; LoadFile:loc_1190Ap ...
		push	si
		push	ds
		push	es
		push	es
		pop	ds
		mov	si, bx
		push	seg dseg
		pop	es
		assume es:dseg
		mov	di, offset strdup_buffer
		inc	si		; skip first byte of file name (disk drive)

loc_119D8:				; CODE XREF: strdup_fn+13j
		lodsb
		stosb
		test	al, al
		jnz	short loc_119D8
		pop	es
		assume es:nothing
		pop	ds
		pop	si
		retn
strdup_fn	endp


; =============== S U B	R O U T	I N E =======================================


sub_119E2	proc near		; CODE XREF: LoadFile+13p
					; WriteFile+13p ...
		push	ax
		push	cx
		push	si
		push	di
		push	ds
		push	es
		pushf
		cld
		push	seg dseg
		pop	ds
		mov	al, byte_1E5C6
		mov	byte_1E5C7, al
		push	seg seg001
		pop	es
		assume es:seg001
		mov	di, 1000h
		push	0A000h
		pop	ds
		assume ds:nothing
		xor	si, si
		mov	cx, 800h
		rep movsw
		push	0A200h
		pop	ds
		assume ds:nothing
		xor	si, si
		mov	cx, 800h
		rep movsw
		popf
		pop	es
		assume es:nothing
		pop	ds
		assume ds:dseg
		pop	di
		pop	si
		pop	cx
		pop	ax
		retn
sub_119E2	endp


; =============== S U B	R O U T	I N E =======================================


sub_11A19	proc near		; CODE XREF: LoadFile+76p LoadFile+AEp ...
		push	ax
		push	cx
		push	si
		push	di
		push	ds
		push	es
		pushf
		cld
		push	seg seg001
		pop	ds
		assume ds:seg001
		mov	si, 1000h
		push	0A000h
		pop	es
		assume es:nothing
		xor	di, di
		mov	cx, 800h
		rep movsw
		push	0A200h
		pop	es
		assume es:nothing
		xor	di, di
		mov	cx, 800h
		rep movsw
		mov	al, 0Dh
		call	WriteIO_A2
		push	seg dseg
		pop	ds
		assume ds:dseg
		mov	al, byte_1E5C7
		mov	byte_1E5C6, al
		popf
		pop	es
		assume es:nothing
		pop	ds
		pop	di
		pop	si
		pop	cx
		pop	ax
		retn
sub_11A19	endp

; ---------------------------------------------------------------------------

Int24:					; DATA XREF: SetupInt0A_24+5Ao
		pushf
		pusha
		push	ds
		push	es
		push	seg dseg
		pop	ds
		push	ax
		mov	al, 0Ch
		call	WriteIO_A2
		xor	al, al
		mov	byte_1E5C6, al
		out	0A8h, al	; Interrupt Controller #2, 8259A
		out	0AAh, al	; Interrupt Controller #2, 8259A
		out	0ACh, al	; Interrupt Controller #2, 8259A
		out	0AEh, al	; Interrupt Controller #2, 8259A
		push	0A200h
		pop	es
		assume es:nothing
		xor	di, di
		mov	ax, 0E1h ; 'á'
		mov	cx, 800h
		rep stosw
		push	0A000h
		pop	es
		assume es:nothing
		xor	di, di
		mov	ax, 20h	; ' '
		mov	cx, 800h
		rep stosw
		push	seg seg001
		pop	ds
		assume ds:seg001
		mov	si, 319Bh
		mov	di, 65Eh
		pop	ax
		add	al, 41h	; 'A'
		cbw
		stosw
		mov	cx, 16h

loc_11A9E:				; CODE XREF: seg000:1AA0j
		movsb
		inc	di
		loop	loc_11A9E
		pop	es
		assume es:nothing
		pop	ds
		assume ds:dseg
		popa
		popf
		mov	al, 1
		iret

; =============== S U B	R O U T	I N E =======================================


WriteIO_A2	proc near		; CODE XREF: LoadFile+53p LoadFile+73p ...
		push	ax

loc_11AAA:				; CODE XREF: WriteIO_A2+9j
		jmp	short $+2
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		jmp	short $+2
		and	al, 2
		jnz	short loc_11AAA
		pop	ax
		out	0A2h, al	; Interrupt Controller #2, 8259A
		retn
WriteIO_A2	endp


; =============== S U B	R O U T	I N E =======================================


WriteIO_A0	proc near		; CODE XREF: seg000:4044p seg000:4049p ...
		push	ax

loc_11AB9:				; CODE XREF: WriteIO_A0+9j
		jmp	short $+2
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		jmp	short $+2
		and	al, 2
		jnz	short loc_11AB9
		pop	ax
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1
		retn
WriteIO_A0	endp


; =============== S U B	R O U T	I N E =======================================


WaitForVSync	proc near		; CODE XREF: WaitFrames:loc_11AE1p
					; sub_12648:loc_1265Dp	...
		push	ax

loc_11AC8:				; CODE XREF: WaitForVSync+9j
		jmp	short $+2
		in	al, 60h		; get GDC state
		jmp	short $+2
		and	al, 20h		; check	VSync flag
		jnz	short loc_11AC8	; wait until it	is set

loc_11AD2:				; CODE XREF: WaitForVSync+13j
		jmp	short $+2
		in	al, 60h		; get GDC state
		jmp	short $+2
		and	al, 20h		; check	VSync flag
		jz	short loc_11AD2	; wait until it	is clear
		pop	ax
		retn
WaitForVSync	endp


; =============== S U B	R O U T	I N E =======================================


WaitFrames	proc near		; CODE XREF: seg000:37D2p seg000:432Ap ...
		jcxz	short locret_11AE7
		push	cx

loc_11AE1:				; CODE XREF: WaitFrames+6j
		call	WaitForVSync
		loop	loc_11AE1
		pop	cx

locret_11AE7:				; CODE XREF: WaitFramesj
		retn
WaitFrames	endp

; ---------------------------------------------------------------------------

Int0A:					; DATA XREF: SetupInt0A_24+39o
		pusha
		push	ds
		push	es
		push	seg dseg
		pop	ds
		inc	scrLoopCounter
		mov	al, 20h
		out	0, al
		sti
		cmp	byte_1D1A6, 0
		jz	short loc_11B02
		call	sub_11B12

loc_11B02:				; CODE XREF: seg000:1AFDj
		cmp	byte_1E5C6, 0
		jz	short loc_11B0C
		call	sub_11B5C

loc_11B0C:				; CODE XREF: seg000:1B07j
		pop	es
		pop	ds
		popa
		out	64h, al		; 8042 keyboard	controller command register.
		iret

; =============== S U B	R O U T	I N E =======================================


sub_11B12	proc near		; CODE XREF: seg000:1AFFp
		push	0A000h
		pop	es
		assume es:nothing
		mov	di, word_1D1AE
		xor	bh, bh
		mov	bl, byte_1D1A7
		shl	bx, 2
		add	bx, offset word_1D1B0
		mov	ax, [bx]
		xchg	ah, al
		sub	al, 20h
		stosw
		or	al, 80h
		stosw
		dec	word_1D1A8
		jnz	short locret_11B5B
		inc	byte_1D1A7
		and	byte_1D1A7, 7
		jnz	short loc_11B45
		mov	bx, offset word_1D1AC

loc_11B45:				; CODE XREF: sub_11B12+2Ej
		add	bx, 4
		cmp	word ptr [bx], 0
		jnz	short loc_11B55
		mov	byte_1D1A7, 0
		mov	bx, offset word_1D1B0

loc_11B55:				; CODE XREF: sub_11B12+39j
		mov	ax, [bx+2]
		mov	word_1D1A8, ax

locret_11B5B:				; CODE XREF: sub_11B12+23j
		retn
sub_11B12	endp


; =============== S U B	R O U T	I N E =======================================


sub_11B5C	proc near		; CODE XREF: seg000:1B09p
		dec	word_1E5C8
		jnz	short locret_11B9E
		push	ds
		mov	si, SceneData2
		mov	ds, word ptr SceneData+2
		lodsw
		test	ax, ax
		jnz	short loc_11B7B
		pop	ds
		push	ds
		lds	si, SceneData
		add	si, 0BC00h
		lodsw

loc_11B7B:				; CODE XREF: sub_11B5C+12j
		mov	dx, ax
		mov	cx, 10h

loc_11B80:				; CODE XREF: sub_11B5C:loc_11B93j
		shr	dx, 1
		jnb	short loc_11B93
		mov	al, 10h
		sub	al, cl
		out	0A8h, al	; Interrupt Controller #2, 8259A
		lodsw
		out	0ACh, al	; Interrupt Controller #2, 8259A
		lodsw
		out	0AAh, al	; Interrupt Controller #2, 8259A
		lodsw
		out	0AEh, al	; Interrupt Controller #2, 8259A

loc_11B93:				; CODE XREF: sub_11B5C+26j
		loop	loc_11B80
		lodsw
		pop	ds
		mov	word_1E5C8, ax
		mov	SceneData2, si

locret_11B9E:				; CODE XREF: sub_11B5C+4j
		retn
sub_11B5C	endp


; =============== S U B	R O U T	I N E =======================================


GetVarPtr	proc near		; CODE XREF: GetVariable+1p
					; seg000:37F1p	...
		mov	bx, es:[si]
		inc	si
		inc	si
		add	bx, bx		; each word has	2 bytes
		add	bx, offset ScrVariables1 ; return pointer to script buffer parameter in	BX
		retn
GetVarPtr	endp


; =============== S U B	R O U T	I N E =======================================


GetVariable	proc near		; CODE XREF: sub_11FE3p sub_11FE3+6p ...
		push	bx
		call	GetVarPtr
		mov	ax, [bx]	; return script	parameter in AX
		pop	bx
		retn
GetVariable	endp


; =============== S U B	R O U T	I N E =======================================


GetLVarPtr	proc near		; CODE XREF: GetLVariable+1p
					; seg000:loc_13980p ...
		mov	bx, es:[si]
		inc	si
		inc	si
		sub	bx, 400h
		add	bx, bx		; using	4-byte double-words here
		add	bx, bx
		add	bx, offset ScrVariablesL
		retn
GetLVarPtr	endp


; =============== S U B	R O U T	I N E =======================================


GetLVariable	proc near		; CODE XREF: seg000:39AAp
					; seg000:loc_13B06p ...
		push	bx
		call	GetLVarPtr
		mov	ax, [bx]
		mov	dx, [bx+2]
		pop	bx
		retn
GetLVariable	endp


; =============== S U B	R O U T	I N E =======================================


GetStringPtr	proc near		; CODE XREF: seg000:sStr_SetDatep
					; seg000:389Bp	...
		push	ax
		mov	ax, es:[si]
		inc	si
		inc	si
		shl	ax, 4
		mov	bx, ax
		add	ax, ax
		add	ax, ax
		add	bx, ax		; BX = [si]*50h
		add	bx, offset ScrStringBuf
		pop	ax
		retn
GetStringPtr	endp


; =============== S U B	R O U T	I N E =======================================


GetScrBufLine	proc near		; CODE XREF: seg000:loc_13E66p
					; seg000:loc_13ED2p ...
		push	ax
		push	cx
		mov	cl, 18h
		mov	ax, es:[si]
		inc	si
		inc	si
		mul	cl
		mov	bx, ax
		add	bx, offset byte_1CE5A
		pop	cx
		pop	ax
		retn
GetScrBufLine	endp


; =============== S U B	R O U T	I N E =======================================


Int2Str_Short	proc near		; CODE XREF: seg000:2799p seg000:45F6p
		push	ax
		push	bx
		push	cx
		push	dx
		mov	i2sTextBuf, 0
		mov	cx, 10

loc_11C07:				; CODE XREF: Int2Str_Short+1Ej
		call	Int2Str_ShiftBuf
		xor	dx, dx
		div	cx
		add	dl, 4Fh
		mov	byte ptr [bx], 85h ; write Shift-JIS code (854F	+ digit)
		mov	[bx+1],	dl	; 8540..859D are mirrors of the	ASCII characters
		or	ax, ax
		jnz	short loc_11C07
		pop	dx
		pop	cx
		pop	bx
		pop	ax
		retn
Int2Str_Short	endp


; =============== S U B	R O U T	I N E =======================================


Int2Str_Long	proc near		; CODE XREF: seg000:27AFp seg000:45FEp
		push	ax
		push	bx
		push	cx
		push	dx
		mov	i2sTextBuf, 0

loc_11C29:				; CODE XREF: Int2Str_Long+1Cj
		call	Int2Str_ShiftBuf
		call	DWord_Div10
		add	cl, 4Fh
		mov	byte ptr [bx], 85h ; write Shift-JIS code (854F	+ digit)
		mov	[bx+1],	cl
		mov	cx, ax
		or	cx, dx
		jnz	short loc_11C29
		pop	dx
		pop	cx
		pop	bx
		pop	ax
		retn
Int2Str_Long	endp


; =============== S U B	R O U T	I N E =======================================


DWord_Div10	proc near		; CODE XREF: Int2Str_Long+Cp
		push	ax
		mov	ax, dx
		xor	dx, dx
		mov	cx, 10
		div	cx
		mov	cx, ax
		pop	ax
		push	cx
		mov	cx, 10
		div	cx
		mov	cx, dx
		pop	dx
		retn
DWord_Div10	endp


; =============== S U B	R O U T	I N E =======================================


Int2Str_ShiftBuf proc near		; CODE XREF: Int2Str_Short:loc_11C07p
					; Int2Str_Long:loc_11C29p
		push	ax
		mov	bx, offset i2sTextBufEnd

loc_11C5E:				; CODE XREF: Int2Str_ShiftBuf+Fj
		mov	ax, [bx-2]
		mov	[bx], ax
		dec	bx
		dec	bx
		cmp	bx, offset i2sTextBuf
		jnz	short loc_11C5E
		pop	ax
		retn
Int2Str_ShiftBuf endp


; =============== S U B	R O U T	I N E =======================================


sub_11C6D	proc near		; CODE XREF: seg000:3EB3p seg000:3EC4p
		push	si
		push	ds
		push	es
		call	sub_11D2F
		mov	si, [bx+2]
		shl	si, 4
		mov	cx, [bx+4]
		add	cx, cx
		shl	si, 4
		add	cx, si
		add	si, si
		add	si, si
		add	si, cx
		mov	dx, [bx+8]
		mov	ax, [bx+6]
		shl	ax, 4
		mov	cx, 0A800h
		call	sub_11CAE
		mov	cx, 0B000h
		call	sub_11CAE
		mov	cx, 0B800h
		call	sub_11CAE
		mov	cx, 0E000h
		call	sub_11CAE
		pop	es
		assume es:nothing
		pop	ds
		pop	si
		retn
sub_11C6D	endp


; =============== S U B	R O U T	I N E =======================================


sub_11CAE	proc near		; CODE XREF: sub_11C6D+28p
					; sub_11C6D+2Ep ...
		push	ax
		push	si
		mov	ds, cx

loc_11CB2:				; CODE XREF: sub_11CAE+Ej
		push	si
		mov	cx, dx
		rep movsw
		pop	si
		add	si, 50h
		dec	ax
		jnz	short loc_11CB2
		pop	si
		pop	ax
		retn
sub_11CAE	endp


; =============== S U B	R O U T	I N E =======================================


sub_11CC1	proc near		; CODE XREF: seg000:3EE3p
					; seg000:loc_13EE6p
		push	es
		call	sub_11CCA
		call	sub_11DB0
		pop	es
		retn
sub_11CC1	endp


; =============== S U B	R O U T	I N E =======================================


sub_11CCA	proc near		; CODE XREF: sub_11CC1+1p seg000:2690p ...
		push	si
		push	ds
		push	es
		mov	di, [bx+2]
		shl	di, 4
		mov	cx, [bx+4]
		add	cx, cx
		shl	di, 4
		add	cx, di
		add	di, di
		add	di, di
		add	di, cx
		mov	dx, [bx+8]
		mov	ax, [bx+6]
		shl	ax, 4
		cmp	word ptr [bx+16h], 0
		jz	short loc_11CF7
		lds	si, [bx+14h]
		jmp	short loc_11D00
; ---------------------------------------------------------------------------

loc_11CF7:				; CODE XREF: sub_11CCA+26j
		cmp	word ptr [bx+12h], 0
		jz	short loc_11D18
		lds	si, [bx+10h]

loc_11D00:				; CODE XREF: sub_11CCA+2Bj
		mov	cx, 0A800h
		call	sub_11D1C
		mov	cx, 0B000h
		call	sub_11D1C
		mov	cx, 0B800h
		call	sub_11D1C
		mov	cx, 0E000h
		call	sub_11D1C

loc_11D18:				; CODE XREF: sub_11CCA+31j
		pop	es
		pop	ds
		pop	si
		retn
sub_11CCA	endp


; =============== S U B	R O U T	I N E =======================================


sub_11D1C	proc near		; CODE XREF: sub_11CCA+39p
					; sub_11CCA+3Fp ...
		push	ax
		push	di
		mov	es, cx

loc_11D20:				; CODE XREF: sub_11D1C+Ej
		push	di
		mov	cx, dx
		rep movsw
		pop	di
		add	di, 50h	; 'P'
		dec	ax
		jnz	short loc_11D20
		pop	di
		pop	ax
		retn
sub_11D1C	endp


; =============== S U B	R O U T	I N E =======================================


sub_11D2F	proc near		; CODE XREF: sub_11C6D+3p

; FUNCTION CHUNK AT 3763 SIZE 00000013 BYTES

		mov	al, [bx+6]
		mov	cl, [bx+8]
		mul	cl
		shl	ax, 7
		cmp	word ptr [bx+12h], 0
		jnz	short loc_11D4B
		call	sub_11D5E
		mov	[bx+10h], di
		mov	word ptr [bx+12h], es
		jmp	short locret_11D5D
; ---------------------------------------------------------------------------

loc_11D4B:				; CODE XREF: sub_11D2F+Fj
		cmp	word ptr [bx+16h], 0
		jz	short loc_11D54
		jmp	sExitDOS
; ---------------------------------------------------------------------------

loc_11D54:				; CODE XREF: sub_11D2F+20j
		call	sub_11D5E
		mov	[bx+14h], di
		mov	word ptr [bx+16h], es

locret_11D5D:				; CODE XREF: sub_11D2F+1Aj
		retn
sub_11D2F	endp


; =============== S U B	R O U T	I N E =======================================


sub_11D5E	proc near		; CODE XREF: sub_11D2F+11p
					; sub_11D2F:loc_11D54p
		mov	cx, word_1CE58
		mov	dx, word_1CE56
		add	dx, ax
		adc	cx, 0
		cmp	cx, 1
		jb	short loc_11D76
		cmp	dx, 8400h
		ja	short loc_11D95

loc_11D76:				; CODE XREF: sub_11D5E+10j
		mov	word_1CE58, cx
		mov	word_1CE56, dx
		push	bx
		xor	cx, cx
		push	cx
		push	ax
		call	sub_101F7
		pop	cx
		pop	cx
		pop	bx
		mov	cx, ax
		or	cx, dx
		jz	short loc_11D95
		mov	es, dx
		mov	di, ax
		jmp	short locret_11DAF
; ---------------------------------------------------------------------------

loc_11D95:				; CODE XREF: sub_11D5E+16j
					; sub_11D5E+2Fj
		call	RestoreInts
		push	seg seg001
		pop	ds
		assume ds:seg001
		mov	dx, offset a03l1l5l ; "\x1B)0\x1B[>3l\x1B[>1l\x1B[>5l\x1B*$"
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		mov	dx, offset aMallocTooMuch ; "‹–—e”ÍˆÍ‚ð‰z‚¦‚Äƒƒ‚ƒŠ‚ðŽæ“¾‚µ‚Ü‚µ‚½\r\n$"
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		mov	ax, 4CFEh
		int	21h		; DOS -	2+ - QUIT WITH EXIT CODE (EXIT)
					; AL = exit code
; ---------------------------------------------------------------------------
		assume ds:dseg

locret_11DAF:				; CODE XREF: sub_11D5E+35j
		retn
sub_11D5E	endp


; =============== S U B	R O U T	I N E =======================================


sub_11DB0	proc near		; CODE XREF: sub_11CC1+4p
		push	bx
		lea	bx, [bx+14h]
		cmp	word ptr [bx+2], 0
		jnz	short loc_11DC6
		sub	bx, 4
		cmp	word ptr [bx+2], 0
		jnz	short loc_11DC6
		pop	bx
		jmp	short locret_11DF3
; ---------------------------------------------------------------------------

loc_11DC6:				; CODE XREF: sub_11DB0+8j
					; sub_11DB0+11j
		push	bx
		push	word ptr [bx+2]
		push	word ptr [bx]
		call	sub_10240
		pop	cx
		pop	cx
		pop	bx
		xor	ax, ax
		mov	[bx+2],	ax
		mov	[bx], ax
		pop	bx
		mov	al, [bx+6]
		mov	cl, [bx+8]
		mul	cl
		shl	ax, 7
		sub	word_1CE56, ax
		sbb	word_1CE58, 0
		jnb	short locret_11DF3
		jmp	sExitDOS
; ---------------------------------------------------------------------------

locret_11DF3:				; CODE XREF: sub_11DB0+14j
					; sub_11DB0+3Ej
		retn
sub_11DB0	endp


; =============== S U B	R O U T	I N E =======================================


sub_11DF4	proc near		; CODE XREF: seg000:loc_126A1p
					; seg000:loc_13EC9p ...
		push	si
		push	es
		mov	si, [bx+0Eh]
		dec	si
		js	short loc_11E77
		add	si, si
		mov	si, [si+16Ch]
		mov	di, [bx+2]
		shl	di, 4
		mov	cx, [bx+4]
		add	cx, cx
		shl	di, 4
		add	cx, di
		add	di, di
		add	di, di
		add	di, cx
		push	di
		xor	ax, ax
		call	sub_11E7A
		mov	cx, [bx+8]
		dec	cx
		dec	cx

loc_11E23:				; CODE XREF: sub_11DF4+35j
		mov	ax, 80h	; '€'
		call	sub_11E7A
		loop	loc_11E23
		mov	ax, 100h
		call	sub_11E7A
		pop	di
		add	di, 500h
		mov	cx, [bx+6]
		dec	cx
		dec	cx

loc_11E3B:				; CODE XREF: sub_11DF4+68j
		push	cx
		push	di
		mov	ax, 180h
		call	sub_11E7A
		mov	cx, [bx+8]
		dec	cx
		dec	cx

loc_11E48:				; CODE XREF: sub_11DF4+5Aj
		mov	ax, 200h
		call	sub_11E7A
		loop	loc_11E48
		mov	ax, 280h
		call	sub_11E7A
		pop	di
		add	di, 500h
		pop	cx
		loop	loc_11E3B
		mov	ax, 300h
		call	sub_11E7A
		mov	cx, [bx+8]
		dec	cx
		dec	cx

loc_11E69:				; CODE XREF: sub_11DF4+7Bj
		mov	ax, 380h
		call	sub_11E7A
		loop	loc_11E69
		mov	ax, 400h
		call	sub_11E7A

loc_11E77:				; CODE XREF: sub_11DF4+6j
		pop	es
		pop	si
		retn
sub_11DF4	endp


; =============== S U B	R O U T	I N E =======================================


sub_11E7A	proc near		; CODE XREF: sub_11DF4+27p
					; sub_11DF4+32p ...
		push	si
		add	si, ax
		mov	ax, 0A800h
		call	sub_11E99
		mov	ax, 0B000h
		call	sub_11E99
		mov	ax, 0B800h
		call	sub_11E99
		mov	ax, 0E000h
		call	sub_11E99
		inc	di
		inc	di
		pop	si
		retn
sub_11E7A	endp


; =============== S U B	R O U T	I N E =======================================


sub_11E99	proc near		; CODE XREF: sub_11E7A+6p sub_11E7A+Cp ...
		push	di
		mov	es, ax
		mov	al, 2

loc_11E9E:				; CODE XREF: sub_11E99+27j
		movsw
		add	di, 4Eh
		movsw
		add	di, 4Eh
		movsw
		add	di, 4Eh
		movsw
		add	di, 4Eh
		movsw
		add	di, 4Eh
		movsw
		add	di, 4Eh
		movsw
		add	di, 4Eh
		movsw
		add	di, 4Eh
		dec	al
		jnz	short loc_11E9E
		pop	di
		retn
sub_11E99	endp


; =============== S U B	R O U T	I N E =======================================


sub_11EC4	proc near		; CODE XREF: seg000:3EC1p
		push	si
		push	bp
		push	es
		sub	sp, 20h
		mov	bp, sp
		mov	si, [bx+0Eh]
		add	si, 3
		add	si, si
		mov	si, [si+16Ch]
		mov	di, [bx+2]
		shl	di, 4
		mov	cx, [bx+4]
		add	cx, cx
		shl	di, 4
		add	cx, di
		add	di, di
		add	di, di
		add	di, cx
		push	di
		xor	ax, ax
		call	sub_11F54
		mov	cx, [bx+8]
		dec	cx
		dec	cx

loc_11EF9:				; CODE XREF: sub_11EC4+3Bj
		mov	ax, 80h	; '€'
		call	sub_11F54
		loop	loc_11EF9
		mov	ax, 100h
		call	sub_11F54
		pop	di
		add	di, 500h
		mov	cx, [bx+6]
		dec	cx
		dec	cx

loc_11F11:				; CODE XREF: sub_11EC4+6Ej
		push	cx
		push	di
		mov	ax, 180h
		call	sub_11F54
		mov	cx, [bx+8]
		dec	cx
		dec	cx

loc_11F1E:				; CODE XREF: sub_11EC4+60j
		mov	ax, 200h
		call	sub_11F54
		loop	loc_11F1E
		mov	ax, 280h
		call	sub_11F54
		pop	di
		add	di, 500h
		pop	cx
		loop	loc_11F11
		mov	ax, 300h
		call	sub_11F54
		mov	cx, [bx+8]
		dec	cx
		dec	cx

loc_11F3F:				; CODE XREF: sub_11EC4+81j
		mov	ax, 380h
		call	sub_11F54
		loop	loc_11F3F
		mov	ax, 400h
		call	sub_11F54
		add	sp, 20h
		pop	es
		pop	bp
		pop	si
		retn
sub_11EC4	endp


; =============== S U B	R O U T	I N E =======================================


sub_11F54	proc near		; CODE XREF: sub_11EC4+2Dp
					; sub_11EC4+38p ...
		push	cx
		push	si
		add	si, ax
		push	si
		push	di
		push	es
		push	ss
		pop	es
		mov	di, bp
		mov	cx, 10h

loc_11F62:				; CODE XREF: sub_11F54+1Bj
		lodsw
		or	ax, [si+1Eh]
		or	ax, [si+3Eh]
		or	ax, [si+5Eh]
		not	ax
		stosw
		loop	loc_11F62
		pop	es
		pop	di
		pop	si
		push	0A800h
		pop	es
		assume es:nothing
		call	sub_11F95
		push	0B000h
		pop	es
		assume es:nothing
		call	sub_11F95
		push	0B800h
		pop	es
		assume es:nothing
		call	sub_11F95
		push	0E000h
		pop	es
		assume es:nothing
		call	sub_11F95
		inc	di
		inc	di
		pop	si
		pop	cx
		retn
sub_11F54	endp


; =============== S U B	R O U T	I N E =======================================


sub_11F95	proc near		; CODE XREF: sub_11F54+24p
					; sub_11F54+2Bp ...
		push	di
		push	bp
		mov	cx, 8

loc_11F9A:				; CODE XREF: sub_11F95+23j
		mov	ax, [bp+0]
		inc	bp
		inc	bp
		and	es:[di], ax
		lodsw
		or	es:[di], ax
		add	di, 50h	; 'P'
		mov	ax, [bp+0]
		inc	bp
		inc	bp
		and	es:[di], ax
		lodsw
		or	es:[di], ax
		add	di, 50h	; 'P'
		loop	loc_11F9A
		pop	bp
		pop	di
		retn
sub_11F95	endp


; =============== S U B	R O U T	I N E =======================================


sub_11FBD	proc near		; CODE XREF: seg000:loc_13FA4p
					; seg000:loc_13FF6p
		mov	al, es:[si]
		mov	byte_1D0F6, al
		mov	ax, es:[si+2]
		mov	word_1D0F8, ax
		mov	ax, es:[si+4]
		mov	word_1D0FA, ax
		mov	ax, es:[si+6]
		mov	word_1D0FE, ax
		mov	ax, es:[si+8]
		mov	word_1D100, ax
		add	si, 0Ah
		retn
sub_11FBD	endp


; =============== S U B	R O U T	I N E =======================================


sub_11FE3	proc near		; CODE XREF: seg000:loc_13FB5p
					; seg000:loc_14002p
		call	GetVariable
		mov	byte_1D0F6, al
		call	GetVariable
		mov	word_1D0F8, ax
		call	GetVariable
		mov	word_1D0FA, ax
		call	GetVariable
		mov	word_1D0FE, ax
		call	GetVariable
		mov	word_1D100, ax
		retn
sub_11FE3	endp

; ---------------------------------------------------------------------------
		mov	al, es:[si]
		mov	byte_1D103, al
		mov	ax, es:[si+2]
		mov	word_1D104, ax
		mov	ax, es:[si+4]
		mov	word_1D106, ax
		add	si, 6
		retn
; ---------------------------------------------------------------------------
		call	GetVariable
		mov	byte_1D103, al
		call	GetVariable
		mov	word_1D104, ax
		call	GetVariable
		mov	word_1D106, ax
		retn

; =============== S U B	R O U T	I N E =======================================


sub_1202D	proc near		; CODE XREF: seg000:3FA7p seg000:3FF9p
		mov	al, es:[si]
		mov	byte_1D110, al
		mov	ax, es:[si+2]
		mov	word_1D10A, ax
		mov	ax, es:[si+4]
		mov	word_1D10C, ax
		add	si, 6
		retn
sub_1202D	endp


; =============== S U B	R O U T	I N E =======================================


sub_12045	proc near		; CODE XREF: seg000:3FB8p seg000:3FE8p ...
		call	GetVariable
		mov	byte_1D110, al
		call	GetVariable
		mov	word_1D10A, ax
		call	GetVariable
		mov	word_1D10C, ax
		retn
sub_12045	endp


; =============== S U B	R O U T	I N E =======================================


scrGFXThing1	proc near		; CODE XREF: seg000:3FAFp seg000:3FC0p ...
		push	ax
		push	bx
		push	cx
		push	dx
		push	si
		push	di
		push	ds
		push	es
		mov	dx, word_1D0F8
		mov	ax, word_1D0FA
		shl	ax, 4
		add	dx, ax
		add	ax, ax
		add	ax, ax
		add	ax, dx
		mov	word_1D0FC, ax
		mov	dx, word_1D104
		mov	ax, word_1D106
		shl	ax, 4
		add	dx, ax
		add	ax, ax
		add	ax, ax
		add	ax, dx
		mov	word_1D108, ax
		mov	dx, word_1D10A
		mov	ax, word_1D10C
		shl	ax, 4
		add	dx, ax
		add	ax, ax
		add	ax, ax
		add	ax, dx
		mov	word_1D10E, ax
		mov	ax, 0A800h
		mov	bx, word_1D170
		call	DoGFXThing2
		mov	ax, 0B000h
		add	bx, 800h
		call	DoGFXThing2
		mov	ax, 0B800h
		mov	bx, word_1D172
		call	DoGFXThing2
		mov	ax, 0E000h
		add	bx, 800h
		call	DoGFXThing2
		xor	al, al
		out	0A6h, al
		pop	es
		assume es:nothing
		pop	ds
		pop	di
		pop	si
		pop	dx
		pop	cx
		pop	bx
		pop	ax
		retn
scrGFXThing1	endp


; =============== S U B	R O U T	I N E =======================================


DoGFXThing2	proc near		; CODE XREF: scrGFXThing1+4Ep
					; scrGFXThing1+58p ...
		push	ds
		push	ax
		mov	si, word_1D0FC
		mov	es, seg_1D16E
		xor	di, di
		mov	dx, ax
		cmp	byte_1D0F6, 2
		jb	short loc_120ED
		mov	dx, bx
		jmp	short loc_120F2
; ---------------------------------------------------------------------------

loc_120ED:				; CODE XREF: DoGFXThing2+13j
		mov	al, byte_1D0F6
		out	0A6h, al	; Interrupt Controller #2, 8259A

loc_120F2:				; CODE XREF: DoGFXThing2+17j
		push	ds
		push	dx
		mov	cx, word_1D100
		mov	dx, word_1D0FE
		pop	ds

loc_120FD:				; CODE XREF: DoGFXThing2+34j
		push	cx
		push	si
		mov	cx, dx
		rep movsb
		pop	si
		add	si, 50h	; 'P'
		pop	cx
		loop	loc_120FD
		pop	ds
		pop	ax
		cmp	byte_1D102, 2
		jnz	short loc_1214F
		push	ax
		mov	es, seg_1D16E
		xor	di, di
		mov	si, word_1D108
		mov	dx, ax
		cmp	byte_1D103, 2
		jb	short loc_1212B
		mov	dx, bx
		jmp	short loc_12130
; ---------------------------------------------------------------------------

loc_1212B:				; CODE XREF: DoGFXThing2+51j
		mov	al, byte_1D103
		out	0A6h, al	; Interrupt Controller #2, 8259A

loc_12130:				; CODE XREF: DoGFXThing2+55j
		push	ds
		push	dx
		mov	cx, word_1D100
		mov	dx, word_1D0FE
		pop	ds

loc_1213B:				; CODE XREF: DoGFXThing2+77j
		push	cx
		push	si
		mov	cx, dx

loc_1213F:				; CODE XREF: DoGFXThing2+70j
		lodsb
		or	es:[di], al
		inc	di
		loop	loc_1213F
		pop	si
		add	si, 50h	; 'P'
		pop	cx
		loop	loc_1213B
		pop	ds
		pop	ax

loc_1214F:				; CODE XREF: DoGFXThing2+3Dj
		cmp	byte_1D102, 1
		jnz	short loc_12192
		push	ax
		mov	es, seg_1D16E
		xor	di, di
		mov	si, word_1D108
		mov	dx, ax
		cmp	byte_1D103, 2
		jb	short loc_1216E
		mov	dx, bx
		jmp	short loc_12173
; ---------------------------------------------------------------------------

loc_1216E:				; CODE XREF: DoGFXThing2+94j
		mov	al, byte_1D103
		out	0A6h, al	; Interrupt Controller #2, 8259A

loc_12173:				; CODE XREF: DoGFXThing2+98j
		push	ds
		push	dx
		mov	cx, word_1D100
		mov	dx, word_1D0FE
		pop	ds

loc_1217E:				; CODE XREF: DoGFXThing2+BAj
		push	cx
		push	si
		mov	cx, dx

loc_12182:				; CODE XREF: DoGFXThing2+B3j
		lodsb
		and	es:[di], al
		inc	di
		loop	loc_12182
		pop	si
		add	si, 50h	; 'P'
		pop	cx
		loop	loc_1217E
		pop	ds
		pop	ax

loc_12192:				; CODE XREF: DoGFXThing2+80j
		mov	es, ax
		mov	di, word_1D10E
		xor	si, si
		cmp	byte_1D110, 2
		jb	short loc_121A5
		mov	es, bx
		jmp	short loc_121AA
; ---------------------------------------------------------------------------

loc_121A5:				; CODE XREF: DoGFXThing2+CBj
		mov	al, byte_1D110
		out	0A6h, al	; Interrupt Controller #2, 8259A

loc_121AA:				; CODE XREF: DoGFXThing2+CFj
		mov	cx, word_1D100
		mov	dx, word_1D0FE
		mov	ds, seg_1D16E

loc_121B6:				; CODE XREF: DoGFXThing2+EDj
		push	cx
		push	di
		mov	cx, dx
		rep movsb
		pop	di
		add	di, 50h	; 'P'
		pop	cx
		loop	loc_121B6
		pop	ds
		retn
DoGFXThing2	endp


; =============== S U B	R O U T	I N E =======================================


scrGFXThing2	proc near		; CODE XREF: seg000:3FFCp seg000:4008p
		push	ax
		push	bx
		push	cx
		push	dx
		push	si
		push	di
		push	ds
		push	es
		mov	dx, word_1D0F8
		mov	ax, word_1D0FA
		shl	ax, 4
		add	dx, ax
		add	ax, ax
		add	ax, ax
		add	ax, dx
		mov	word_1D0FC, ax
		mov	dx, word_1D10A
		mov	ax, word_1D10C
		shl	ax, 4
		add	dx, ax
		add	ax, ax
		add	ax, ax
		add	ax, dx
		mov	word_1D10E, ax
		mov	al, byte_1D0F6
		mov	ah, byte_1D110
		or	ax, 101h
		cmp	ax, 101h
		jnz	short loc_1220B
		call	sub_12234
		jmp	short loc_12227
; ---------------------------------------------------------------------------

loc_1220B:				; CODE XREF: scrGFXThing2+3Fj
		cmp	ax, 301h
		jnz	short loc_12215
		call	sub_122B2
		jmp	short loc_12227
; ---------------------------------------------------------------------------

loc_12215:				; CODE XREF: scrGFXThing2+49j
		cmp	ax, 103h
		jnz	short loc_1221F
		call	sub_1233A
		jmp	short loc_12227
; ---------------------------------------------------------------------------

loc_1221F:				; CODE XREF: scrGFXThing2+53j
		cmp	ax, 303h
		jnz	short loc_12227
		call	sub_123C2

loc_12227:				; CODE XREF: scrGFXThing2+44j
					; scrGFXThing2+4Ej ...
		xor	al, al
		out	0A6h, al	; Interrupt Controller #2, 8259A
		pop	es
		pop	ds
		pop	di
		pop	si
		pop	dx
		pop	cx
		pop	bx
		pop	ax
		retn
scrGFXThing2	endp


; =============== S U B	R O U T	I N E =======================================


sub_12234	proc near		; CODE XREF: scrGFXThing2+41p
		call	sub_12438
		mov	ax, 0A800h
		call	sub_12250
		mov	ax, 0B000h
		call	sub_12250
		mov	ax, 0B800h
		call	sub_12250
		mov	ax, 0E000h
		call	sub_12250
		retn
sub_12234	endp


; =============== S U B	R O U T	I N E =======================================


sub_12250	proc near		; CODE XREF: sub_12234+6p sub_12234+Cp ...
		push	ds
		push	ax
		mov	si, word_1D0FC
		mov	es, seg_1D16E
		mov	di, 8000h
		mov	al, byte_1D0F6
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	cx, word_1D100
		mov	dx, word_1D0FE
		pop	ds

loc_1226B:				; CODE XREF: sub_12250+26j
		push	cx
		push	si
		mov	cx, dx
		rep movsb
		pop	si
		pop	cx
		add	si, 50h	; 'P'
		loop	loc_1226B
		mov	ax, ds
		mov	es, ax
		assume es:dseg
		mov	ax, seg	dseg
		mov	ds, ax
		mov	di, word_1D10E
		xor	si, si
		mov	bx, 8000h
		mov	al, byte_1D110
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	cx, word_1D100
		mov	dx, word_1D0FE
		mov	ds, seg_1D16E

loc_1229B:				; CODE XREF: sub_12250+5Ej
		push	cx
		push	di
		mov	cx, dx

loc_1229F:				; CODE XREF: sub_12250+57j
		lodsb
		and	al, es:[di]
		or	al, [bx]
		stosb
		inc	bx
		loop	loc_1229F
		pop	di
		pop	cx
		add	di, 50h	; 'P'
		loop	loc_1229B
		pop	ds
		retn
sub_12250	endp


; =============== S U B	R O U T	I N E =======================================


sub_122B2	proc near		; CODE XREF: scrGFXThing2+4Bp
		call	sub_12438
		mov	ax, 0A800h
		mov	dx, word_1D170
		call	sub_122DE
		mov	ax, 0B000h
		add	dx, 800h
		call	sub_122DE
		mov	ax, 0B800h
		mov	dx, word_1D172
		call	sub_122DE
		mov	ax, 0E000h
		add	dx, 800h
		call	sub_122DE
		retn
sub_122B2	endp


; =============== S U B	R O U T	I N E =======================================


sub_122DE	proc near		; CODE XREF: sub_122B2+Ap
					; sub_122B2+14p ...
		push	dx
		push	ds
		push	ax
		mov	si, word_1D0FC
		mov	es, seg_1D16E
		assume es:nothing
		mov	di, 8000h
		mov	al, byte_1D0F6
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	cx, word_1D100
		mov	ax, word_1D0FE
		pop	ds

loc_122F9:				; CODE XREF: sub_122DE+26j
		push	cx
		push	si
		mov	cx, ax
		rep movsb
		pop	si
		pop	cx
		add	si, 50h	; 'P'
		loop	loc_122F9
		mov	ax, seg	dseg
		mov	ds, ax
		mov	es, dx
		mov	di, word_1D10E
		xor	si, si
		mov	bx, 8000h
		mov	cx, word_1D100
		mov	dx, word_1D0FE
		mov	ds, seg_1D16E

loc_12322:				; CODE XREF: sub_122DE+57j
		push	cx
		push	di
		mov	cx, dx

loc_12326:				; CODE XREF: sub_122DE+50j
		lodsb
		and	al, es:[di]
		or	al, [bx]
		stosb
		inc	bx
		loop	loc_12326
		pop	di
		pop	cx
		add	di, 50h	; 'P'
		loop	loc_12322
		pop	ds
		pop	dx
		retn
sub_122DE	endp


; =============== S U B	R O U T	I N E =======================================


sub_1233A	proc near		; CODE XREF: scrGFXThing2+55p
		call	sub_12479
		mov	ax, word_1D170
		mov	dx, 0A800h
		call	sub_12368
		mov	ax, word_1D170
		add	ax, 800h
		mov	dx, 0B000h
		call	sub_12368
		mov	ax, word_1D172
		mov	dx, 0B800h
		call	sub_12368
		mov	ax, word_1D172
		add	ax, 800h
		mov	dx, 0E000h
		call	sub_12368
		retn
sub_1233A	endp


; =============== S U B	R O U T	I N E =======================================


sub_12368	proc near		; CODE XREF: sub_1233A+9p
					; sub_1233A+15p ...
		push	ds
		push	ax
		mov	si, word_1D0FC
		mov	es, seg_1D16E
		mov	di, 8000h
		mov	cx, word_1D100
		mov	ax, word_1D0FE
		pop	ds

loc_1237D:				; CODE XREF: sub_12368+20j
		push	cx
		push	si
		mov	cx, ax
		rep movsb
		pop	si
		pop	cx
		add	si, 50h	; 'P'
		loop	loc_1237D
		mov	ax, seg	dseg
		mov	ds, ax
		mov	es, dx
		mov	di, word_1D10E
		xor	si, si
		mov	bx, 8000h
		mov	al, byte_1D110
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	cx, word_1D100
		mov	dx, word_1D0FE
		mov	ds, seg_1D16E

loc_123AB:				; CODE XREF: sub_12368+56j
		push	cx
		push	di
		mov	cx, dx

loc_123AF:				; CODE XREF: sub_12368+4Fj
		lodsb
		and	al, es:[di]
		or	al, [bx]
		stosb
		inc	bx
		loop	loc_123AF
		pop	di
		pop	cx
		add	di, 50h	; 'P'
		loop	loc_123AB
		pop	ds
		retn
sub_12368	endp


; =============== S U B	R O U T	I N E =======================================


sub_123C2	proc near		; CODE XREF: scrGFXThing2+5Fp
		call	sub_12479
		mov	ax, word_1D170
		call	sub_123E4
		mov	ax, word_1D170
		add	ax, 800h
		call	sub_123E4
		mov	ax, word_1D172
		call	sub_123E4
		mov	ax, word_1D172
		add	ax, 800h
		call	sub_123E4
		retn
sub_123C2	endp


; =============== S U B	R O U T	I N E =======================================


sub_123E4	proc near		; CODE XREF: sub_123C2+6p sub_123C2+Fp ...
		push	ax
		mov	si, word_1D0FC
		mov	es, seg_1D16E
		mov	di, 8000h
		mov	cx, word_1D100
		mov	ax, word_1D0FE
		pop	ds

loc_123F8:				; CODE XREF: sub_123E4+1Fj
		push	cx
		push	si
		mov	cx, ax
		rep movsb
		pop	si
		pop	cx
		add	si, 50h	; 'P'
		loop	loc_123F8
		mov	ax, ds
		mov	es, ax
		assume es:dseg
		push	seg dseg
		pop	ds
		mov	di, word_1D10E
		xor	si, si
		mov	bx, 8000h
		mov	cx, word_1D100
		mov	dx, word_1D0FE
		mov	ds, seg_1D16E

loc_12422:				; CODE XREF: sub_123E4+51j
		push	cx
		push	di
		mov	cx, dx

loc_12426:				; CODE XREF: sub_123E4+4Aj
		lodsb
		and	al, es:[di]
		or	al, [bx]
		stosb
		inc	bx
		loop	loc_12426
		pop	di
		pop	cx
		add	di, 50h	; 'P'
		loop	loc_12422
		retn
sub_123E4	endp


; =============== S U B	R O U T	I N E =======================================


sub_12438	proc near		; CODE XREF: sub_12234p sub_122B2p
		push	ds
		mov	al, byte_1D0F6
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	es, seg_1D16E
		assume es:nothing
		xor	di, di
		mov	si, word_1D0FC
		mov	cx, word_1D100
		mov	dx, word_1D0FE

loc_12450:				; CODE XREF: sub_12438+3Dj
		push	cx
		push	si
		mov	cx, dx

loc_12454:				; CODE XREF: sub_12438+36j
		push	0A800h
		pop	ds
		assume ds:nothing
		mov	al, [si]
		or	al, [si-8000h]
		push	0B800h
		pop	ds
		assume ds:nothing
		or	al, [si]
		push	0E000h
		pop	ds
		assume ds:nothing
		or	al, [si]
		not	al
		stosb
		inc	si
		loop	loc_12454
		pop	si
		pop	cx
		add	si, 50h	; 'P'
		loop	loc_12450
		pop	ds
		assume ds:dseg
		retn
sub_12438	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_12479	proc near		; CODE XREF: sub_1233Ap sub_123C2p

var_4		= word ptr -4
var_2		= word ptr -2

		push	bp
		mov	bp, sp
		add	sp, 0FFFCh
		push	ds
		mov	ax, word_1D170
		mov	[bp+var_2], ax
		mov	ax, word_1D172
		mov	[bp+var_4], ax
		mov	al, byte_1D0F6
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	es, seg_1D16E
		xor	di, di
		mov	si, word_1D0FC
		mov	cx, word_1D100
		mov	dx, word_1D0FE

loc_124A3:				; CODE XREF: sub_12479+4Bj
		push	cx
		push	si
		mov	cx, dx

loc_124A7:				; CODE XREF: sub_12479+44j
		mov	ds, [bp+var_2]
		mov	al, [si]
		or	al, [si-8000h]
		mov	ds, [bp+var_4]
		or	al, [si]
		or	al, [si-8000h]
		not	al
		stosb
		inc	si
		loop	loc_124A7
		pop	si
		pop	cx
		add	si, 50h	; 'P'
		loop	loc_124A3
		pop	ds
		mov	sp, bp
		pop	bp
		retn
sub_12479	endp


; =============== S U B	R O U T	I N E =======================================


UploadPalette	proc near		; CODE XREF: seg000:3F96p seg000:42DAp ...
		push	ax
		push	si
		mov	si, offset PalTarget
		pushf
		cli
		xor	ah, ah

loc_124D4:				; CODE XREF: UploadPalette+1Bj
		mov	al, ah
		out	0A8h, al	; GDC: set palette
		lodsb
		out	0AAh, al	; GDC: set colour Green
		lodsb
		out	0ACh, al	; GDC: set colour Red
		lodsb
		out	0AEh, al	; GDC: set colour Blue
		inc	ah
		cmp	ah, 10h
		jb	short loc_124D4	; loop for 16 palettes
		popf
		pop	si
		pop	ax
		retn
UploadPalette	endp


; =============== S U B	R O U T	I N E =======================================


SetPalToBlack	proc near		; CODE XREF: seg000:sPalFadeBW1p
		xor	al, al		; RGB 0	= black
		jmp	short loc_124F2
SetPalToBlack	endp


; =============== S U B	R O U T	I N E =======================================


SetPalToWhite	proc near		; CODE XREF: seg000:42F2p
		mov	al, 0Fh		; RGB 0Fh = white

loc_124F2:				; CODE XREF: SetPalToBlack+2j
		mov	bx, offset PalTarget
		mov	dx, PalColLockMask
		mov	ah, 10h		; 16 colours

loc_124FB:				; CODE XREF: SetPalToWhite+1Cj
		ror	dx, 1
		jb	short loc_12507
		mov	[bx], al
		mov	[bx+1],	al
		mov	[bx+2],	al

loc_12507:				; CODE XREF: SetPalToWhite+Dj
		add	bx, 3
		dec	ah
		jnz	short loc_124FB
		retn
SetPalToWhite	endp


; =============== S U B	R O U T	I N E =======================================


doTextFill	proc near		; CODE XREF: seg000:4496p seg000:44A2p
		push	es
		mov	dx, es:[si]
		mov	di, es:[si+2]
		shl	di, 4
		add	dx, di
		add	di, di
		add	di, di
		add	di, dx
		add	di, di		; DI = [si+2]*0A0h + [si+0]*02h
		mov	ax, 20E1h
		cmp	byte ptr es:[si+8], 0
		jz	short loc_12531
		mov	ax, textFillMode

loc_12531:				; CODE XREF: doTextFill+1Dj
		mov	cx, es:[si+6]
		mov	dx, es:[si+4]
		add	si, 0Ah
		push	0A000h
		pop	es
		assume es:nothing

loc_12540:				; CODE XREF: doTextFill+4Cj
		push	cx
		push	di
		mov	cx, dx

loc_12544:				; CODE XREF: doTextFill+44j
		mov	es:[di], ah
		mov	byte ptr es:[di+1], 0
		mov	es:[di+2000h], al
		inc	di
		inc	di
		loop	loc_12544
		pop	di
		add	di, 0A0h
		pop	cx
		loop	loc_12540
		pop	es
		assume es:nothing
		retn
doTextFill	endp


; =============== S U B	R O U T	I N E =======================================


PrintTextSomething proc	near		; CODE XREF: seg000:277Ep seg000:27BBp ...
		mov	word_1D180, offset loc_125D6
		cmp	byte_1D17A, 0FFh
		jnz	short loc_12572
		mov	word_1D180, offset loc_125BB

loc_12572:				; CODE XREF: PrintTextSomething+Bj
					; PrintTextSomething+22j ...
		cmp	byte ptr es:[si], 0Fh
		jb	short loc_12583
		jz	short loc_12593
		call	word_1D180
		call	sub_12648
		jmp	short loc_12572
; ---------------------------------------------------------------------------

loc_12583:				; CODE XREF: PrintTextSomething+17j
		mov	cx, offset off_1259A

loc_12586:				; CODE XREF: PrintTextSomething+38j
		xor	bh, bh
		mov	bl, es:[si]
		inc	si
		add	bx, bx
		add	bx, cx
		jmp	word ptr cs:[bx]
; ---------------------------------------------------------------------------

loc_12593:				; CODE XREF: PrintTextSomething+19j
		inc	si
		mov	cx, offset off_125B8
		jmp	short loc_12586
PrintTextSomething endp

; ---------------------------------------------------------------------------
		align 2
off_1259A	dw offset locret_125BA	; 0 ; DATA XREF: PrintTextSomething:loc_12583o
		dw offset loc_1266A	; 1
		dw offset loc_126EB	; 2
		dw offset loc_1275B	; 3
		dw offset loc_12765	; 4
		dw offset loc_12786	; 5
		dw offset loc_128CA	; 6
		dw offset loc_12A42	; 7
		dw offset loc_12A9A	; 8
		dw offset loc_127C3	; 9
		dw offset loc_127DD	; 0Ah
		dw offset loc_127E0	; 0Bh
		dw offset loc_12821	; 0Ch
		dw offset loc_12AA4	; 0Dh
		dw offset loc_12ACA	; 0Eh
off_125B8	dw offset loc_12ACE	; DATA XREF: PrintTextSomething+35o
; ---------------------------------------------------------------------------

locret_125BA:				; DATA XREF: seg000:off_1259Ao
		retn
; ---------------------------------------------------------------------------

loc_125BB:				; DATA XREF: PrintTextSomething+Do
		mov	dl, byte_1D178
		mov	dh, byte_1D179
		call	GetChrData
		mov	cl, byte_1D178
		mov	ch, byte_1D179
		call	sub_1261F
		mov	byte_1D178, dl
		retn
; ---------------------------------------------------------------------------

loc_125D6:				; DATA XREF: PrintTextSomethingo
		mov	bx, word_1D17E
		mov	dl, [bx+0Ch]
		mov	dh, [bx+0Ah]
		call	GetChrData
		mov	cl, [bx+0Ch]
		mov	ch, [bx+0Ah]
		call	sub_1261F
		mov	[bx+0Ch], dl
		retn

; =============== S U B	R O U T	I N E =======================================


GetChrData	proc near		; CODE XREF: seg000:25C3p seg000:25E0p
		push	bx
		push	ds
		push	es
		push	es
		les	di, chrBufPtr
		pop	ds
		call	GetChrFromROM
		push	ax
		xor	al, al
		mov	ah, dh
		add	ah, ah
		add	ah, ah
		xor	cl, cl
		mov	ch, dh
		add	ax, cx
		xor	ch, ch
		mov	cl, dl
		add	ax, cx
		mov	bx, ax
		call	sub_10F92
		pop	ax
		inc	al
		add	dl, al
		pop	es
		pop	ds
		pop	bx
		retn
GetChrData	endp


; =============== S U B	R O U T	I N E =======================================


sub_1261F	proc near		; CODE XREF: seg000:25CEp seg000:25E9p
		push	dx
		push	si
		push	es
		les	di, off_1E612
		mov	dx, [bx+0Ch]
		xor	al, al
		mov	ah, [bx+0Ah]
		add	dx, ax
		add	ax, ax
		add	ax, ax
		add	ax, dx
		add	di, ax		; DI = *off_1E612 + ([BX+0Ah] *	300h + [BX+0Ah])
		mov	si, offset characterBuffer
		mov	cx, 10h

loc_1263E:				; CODE XREF: sub_1261F+23j
		movsw
		add	di, 4Eh
		loop	loc_1263E
		pop	es
		pop	si
		pop	dx
		retn
sub_1261F	endp


; =============== S U B	R O U T	I N E =======================================


sub_12648	proc near		; CODE XREF: PrintTextSomething+1Fp
		mov	cx, word_1D17C
		jcxz	short locret_12669
		push	es
		xor	ax, ax
		mov	es, ax
		assume es:nothing
		mov	al, es:538h
		pop	es
		assume es:nothing
		shr	al, 2
		jb	short locret_12669

loc_1265D:				; CODE XREF: sub_12648+1Fj
		call	WaitForVSync
		mov	al, byte_1D1F9
		and	al, 1
		jnz	short locret_12669
		loop	loc_1265D

locret_12669:				; CODE XREF: sub_12648+4j
					; sub_12648+13j ...
		retn
sub_12648	endp

; ---------------------------------------------------------------------------

loc_1266A:				; DATA XREF: seg000:off_1259Ao
		call	sub_126F1
		cmp	byte_1D17A, 0FFh
		jnz	short loc_12677
		jmp	loc_12572
; ---------------------------------------------------------------------------

loc_12677:				; CODE XREF: seg000:2672j
		mov	bx, word_1D17E
		cmp	byte ptr [bx+1], 0
		jnz	short loc_12684
		jmp	loc_12572
; ---------------------------------------------------------------------------

loc_12684:				; CODE XREF: seg000:267Fj
		call	sub_126A7
		call	sub_126B8
		cmp	word ptr [bx+0Eh], 0
		jnz	short loc_12696
		call	sub_11CCA
		jmp	loc_12572
; ---------------------------------------------------------------------------

loc_12696:				; CODE XREF: seg000:268Ej
		cmp	byte ptr [bx], 8
		jb	short loc_126A1
		call	sub_11CCA
		jmp	loc_12572
; ---------------------------------------------------------------------------

loc_126A1:				; CODE XREF: seg000:2699j
		call	sub_11DF4
		jmp	loc_12572

; =============== S U B	R O U T	I N E =======================================


sub_126A7	proc near		; CODE XREF: seg000:loc_12684p
					; seg000:loc_13EFCp
		mov	ax, [bx+4]
		inc	ax
		add	ax, ax
		mov	[bx+0Ch], ax
		mov	ax, [bx+2]
		inc	ax
		mov	[bx+0Ah], ax
		retn
sub_126A7	endp


; =============== S U B	R O U T	I N E =======================================


sub_126B8	proc near		; CODE XREF: seg000:2687p seg000:3EB0p ...
		push	es
		les	di, off_1E612
		xor	al, al
		mov	ah, [bx+2]
		mov	cx, [bx+4]
		add	cx, cx
		add	cx, ax
		add	ax, ax
		add	ax, ax
		add	ax, cx
		add	di, ax		; DI +=	[bx+2]*500h + [bx+4]*2
		mov	dx, [bx+8]
		xor	ax, ax
		mov	cx, [bx+6]
		shl	cx, 4

loc_126DC:				; CODE XREF: sub_126B8+2Fj
		push	cx
		push	di
		mov	cx, dx
		rep stosw
		pop	di
		add	di, 50h
		pop	cx
		loop	loc_126DC
		pop	es
		retn
sub_126B8	endp

; ---------------------------------------------------------------------------

loc_126EB:				; DATA XREF: seg000:off_1259Ao
		call	sub_126F1
		jmp	loc_12572

; =============== S U B	R O U T	I N E =======================================


sub_126F1	proc near		; CODE XREF: seg000:loc_1266Ap
					; seg000:loc_126EBp
		mov	word_1D1AE, 0E50h
		cmp	byte_1D17A, 0FFh
		jz	short loc_1272B
		mov	bx, word_1D17E
		mov	ax, [bx+4]
		add	ax, [bx+8]
		dec	ax
		dec	ax
		add	ax, ax
		sub	ax, word_1D1AA
		mov	dx, [bx+2]
		add	dx, [bx+6]
		dec	dx
		dec	dx
		sub	dx, word_1D1AC
		shl	dx, 4
		add	ax, dx
		shl	dx, 2
		add	ax, dx
		add	ax, ax
		mov	word_1D1AE, ax

loc_1272B:				; CODE XREF: sub_126F1+Bj
		mov	byte_1D1A6, 0FFh

loc_12730:				; CODE XREF: sub_126F1+44j
		mov	al, byte_1D1F9
		and	al, 2
		jz	short loc_12730
		mov	byte_1D1A6, 0

loc_1273C:				; CODE XREF: sub_126F1+50j
		mov	al, byte_1D1F9
		and	al, 2
		jnz	short loc_1273C
		push	di
		push	es
		push	0A000h
		pop	es
		assume es:nothing
		mov	di, word_1D1AE
		mov	word ptr es:[di+2], 0
		mov	word ptr es:[di], 0
		pop	es
		assume es:nothing
		pop	di
		retn
sub_126F1	endp

; ---------------------------------------------------------------------------

loc_1275B:				; DATA XREF: seg000:off_1259Ao
		mov	al, es:[si]
		inc	si
		mov	byte_18E1A, al
		jmp	loc_12572
; ---------------------------------------------------------------------------

loc_12765:				; DATA XREF: seg000:off_1259Ao
		mov	al, es:[si]
		inc	si
		cbw
		push	si
		push	es
		mov	si, offset ScrStringBuf
		shl	ax, 4
		add	si, ax
		add	ax, ax
		add	ax, ax
		add	si, ax
		mov	ax, ds
		mov	es, ax
		assume es:dseg
		call	PrintTextSomething
		pop	es
		assume es:nothing
		pop	si
		jmp	loc_12572
; ---------------------------------------------------------------------------

loc_12786:				; DATA XREF: seg000:off_1259Ao
		mov	ax, es:[si]
		inc	si
		inc	si
		cmp	ax, 400h
		jnb	short loc_1279E
		mov	bx, offset ScrVariables1
		add	ax, ax
		add	bx, ax
		mov	ax, [bx]
		call	Int2Str_Short
		jnb	short loc_127B2

loc_1279E:				; CODE XREF: seg000:278Ej
		mov	bx, offset ScrVariablesL
		sub	ax, 400h
		add	ax, ax
		add	ax, ax
		add	bx, ax
		mov	ax, [bx]
		mov	dx, [bx+2]
		call	Int2Str_Long

loc_127B2:				; CODE XREF: seg000:279Cj
		push	si
		push	es
		mov	si, offset i2sTextBuf
		mov	ax, ds
		mov	es, ax
		assume es:dseg
		call	PrintTextSomething
		pop	es
		assume es:nothing
		pop	si
		jmp	loc_12572
; ---------------------------------------------------------------------------

loc_127C3:				; DATA XREF: seg000:off_1259Ao
		cmp	byte_1D17A, 0FFh
		jnz	short loc_127D2
		add	byte_1D178, 8
		jmp	loc_12572
; ---------------------------------------------------------------------------

loc_127D2:				; CODE XREF: seg000:27C8j
		mov	bx, word_1D17E
		add	word ptr [bx+0Ch], 8
		jmp	loc_12572
; ---------------------------------------------------------------------------

loc_127DD:				; DATA XREF: seg000:off_1259Ao
		jmp	loc_12572
; ---------------------------------------------------------------------------

loc_127E0:				; DATA XREF: seg000:off_1259Ao
		call	sub_1282A
		mov	al, 0Dh
		out	0A8h, al	; Interrupt Controller #2, 8259A
		mov	al, [bx+3]
		mov	ah, al
		shr	al, 4
		out	0AAh, al	; Interrupt Controller #2, 8259A
		mov	al, ah
		and	al, 0Fh
		out	0ACh, al	; Interrupt Controller #2, 8259A
		mov	al, [bx+4]
		mov	ah, al
		shr	al, 4
		out	0AEh, al	; Interrupt Controller #2, 8259A
		mov	al, 0Eh
		out	0A8h, al	; Interrupt Controller #2, 8259A
		mov	al, ah
		and	al, 0Fh
		out	0AAh, al	; Interrupt Controller #2, 8259A
		mov	al, [bx+5]
		mov	ah, al
		shr	al, 4
		out	0ACh, al	; Interrupt Controller #2, 8259A
		mov	al, ah
		and	al, 0Fh
		out	0AEh, al	; Interrupt Controller #2, 8259A
		call	sub_12840
		jmp	loc_12572
; ---------------------------------------------------------------------------

loc_12821:				; DATA XREF: seg000:off_1259Ao
		call	sub_1282A
		call	sub_12840
		jmp	loc_12572

; =============== S U B	R O U T	I N E =======================================


sub_1282A	proc near		; CODE XREF: seg000:loc_127E0p
					; seg000:loc_12821p ...
		mov	al, es:[si]
		inc	si
		and	ax, 3Fh
		mov	bx, ax
		add	ax, ax
		add	ax, ax
		add	bx, bx
		add	bx, ax
		add	bx, offset byte_1D2A4 ;	BX = byte_1D2A4	+ idx*6
		retn
sub_1282A	endp


; =============== S U B	R O U T	I N E =======================================


sub_12840	proc near		; CODE XREF: seg000:281Bp seg000:2824p
		push	si
		push	es
		mov	ax, 0A800h	; GVRAM	Plane 0
		mov	dx, word_1D170
		call	SomeGDCCopy1
		mov	ax, 0B000h	; GVRAM	Plane 1
		add	dx, 800h
		call	SomeGDCCopy1
		mov	ax, 0B800h	; GVRAM	Plane 2
		mov	dx, word_1D172
		call	SomeGDCCopy1
		mov	ax, 0E000h	; GVRAM	Plane 3
		add	dx, 800h
		call	SomeGDCCopy1
		xor	al, al
		out	0A6h, al	; Interrupt Controller #2, 8259A
		pop	es
		pop	si
		retn
sub_12840	endp


; =============== S U B	R O U T	I N E =======================================


SomeGDCCopy1	proc near		; CODE XREF: sub_12840+9p
					; sub_12840+13p ...
		push	ds
		push	ax
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	si, [bx+1]
		mov	cx, dx
		cmp	byte ptr [bx], 2
		jnb	short loc_12885
		mov	cx, ax
		mov	al, [bx]
		out	0A6h, al	; Interrupt Controller #2, 8259A

loc_12885:				; CODE XREF: SomeGDCCopy1+Cj
		mov	es, seg_1D16E
		xor	di, di
		push	ds
		mov	ds, cx
		mov	al, 60h

loc_12890:				; CODE XREF: SomeGDCCopy1+29j
		mov	cx, 6
		rep movsw
		add	si, 44h
		dec	al
		jnz	short loc_12890
		pop	ds
		mov	di, word_1D2A2
		mov	es, dx
		pop	ax
		out	0A6h, al	; Interrupt Controller #2, 8259A
		cmp	SomeGDCPlane, 2
		jnb	short loc_128B4
		mov	es, ax
		mov	al, SomeGDCPlane
		out	0A6h, al	; Interrupt Controller #2, 8259A

loc_128B4:				; CODE XREF: SomeGDCCopy1+3Aj
		mov	ds, seg_1D16E
		xor	si, si
		mov	al, 60h

loc_128BC:				; CODE XREF: SomeGDCCopy1+55j
		mov	cx, 6
		rep movsw
		add	di, 44h
		dec	al
		jnz	short loc_128BC
		pop	ds
		retn
SomeGDCCopy1	endp

; ---------------------------------------------------------------------------

loc_128CA:				; DATA XREF: seg000:off_1259Ao
		call	sub_1282A
		push	si
		push	es
		call	sub_128E4
		call	sub_1293D
		call	sub_12999
		call	sub_129E6
		xor	al, al
		out	0A6h, al	; Interrupt Controller #2, 8259A
		pop	es
		pop	si
		jmp	loc_12572

; =============== S U B	R O U T	I N E =======================================


sub_128E4	proc near		; CODE XREF: seg000:28CFp
		mov	es, seg_1D16E
		xor	di, di
		mov	al, [bx]
		cmp	al, 2
		jb	short loc_1290A
		mov	ax, word_1D170
		call	SomeGDCCopy2
		add	ax, 800h
		call	SomeGDCCopy2
		mov	ax, word_1D172
		call	SomeGDCCopy2
		add	ax, 800h
		call	SomeGDCCopy2
		jmp	short locret_12924
; ---------------------------------------------------------------------------

loc_1290A:				; CODE XREF: sub_128E4+Aj
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	ax, 0A800h	; GVRAM	Plane 0
		call	SomeGDCCopy2
		mov	ax, 0B000h	; GVRAM	Plane 1
		call	SomeGDCCopy2
		mov	ax, 0B800h	; GVRAM	Plane 2
		call	SomeGDCCopy2
		mov	ax, 0E000h	; GVRAM	Plane 3
		call	SomeGDCCopy2

locret_12924:				; CODE XREF: sub_128E4+24j
		retn
sub_128E4	endp


; =============== S U B	R O U T	I N E =======================================


SomeGDCCopy2	proc near		; CODE XREF: sub_128E4+Fp
					; sub_128E4+15p ...
		push	ds
		mov	si, [bx+1]
		mov	ds, ax
		mov	al, 60h

loc_1292D:				; CODE XREF: SomeGDCCopy2+12j
		mov	cx, 6
		rep movsw
		add	si, 44h
		dec	al
		jnz	short loc_1292D
		mov	ax, ds
		pop	ds
		retn
SomeGDCCopy2	endp


; =============== S U B	R O U T	I N E =======================================


sub_1293D	proc near		; CODE XREF: seg000:28D2p
		mov	es, seg_1D16E
		mov	di, 1200h
		mov	al, SomeGDCPlane
		cmp	al, 2
		jb	short loc_12965
		mov	ax, word_1D170
		call	SomeGDCCopy3
		add	ax, 800h
		call	SomeGDCCopy3
		mov	ax, word_1D172
		call	SomeGDCCopy3
		add	ax, 800h
		call	SomeGDCCopy3
		jmp	short locret_1297F
; ---------------------------------------------------------------------------

loc_12965:				; CODE XREF: sub_1293D+Cj
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	ax, 0A800h	; GVRAM	Plane 0
		call	SomeGDCCopy3
		mov	ax, 0B000h	; GVRAM	Plane 1
		call	SomeGDCCopy3
		mov	ax, 0B800h	; GVRAM	Plane 2
		call	SomeGDCCopy3
		mov	ax, 0E000h	; GVRAM	Plane 3
		call	SomeGDCCopy3

locret_1297F:				; CODE XREF: sub_1293D+26j
		retn
sub_1293D	endp


; =============== S U B	R O U T	I N E =======================================


SomeGDCCopy3	proc near		; CODE XREF: sub_1293D+11p
					; sub_1293D+17p ...
		push	ds
		mov	si, word_1D2A2
		mov	ds, ax
		mov	al, 60h

loc_12989:				; CODE XREF: SomeGDCCopy3+13j
		mov	cx, 6
		rep movsw
		add	si, 44h
		dec	al
		jnz	short loc_12989
		mov	ax, ds
		pop	ds
		retn
SomeGDCCopy3	endp


; =============== S U B	R O U T	I N E =======================================


sub_12999	proc near		; CODE XREF: seg000:28D5p
		push	ds
		mov	ds, seg_1D16E
		xor	bx, bx
		mov	cx, 480h

loc_129A3:				; CODE XREF: sub_12999+49j
		mov	al, [bx]
		or	al, [bx+480h]
		or	al, [bx+900h]
		or	al, [bx+0D80h]
		not	al
		and	[bx+1200h], al
		and	[bx+1680h], al
		and	[bx+1B00h], al
		and	[bx+1F80h], al
		mov	al, [bx]
		or	[bx+1200h], al
		mov	al, [bx+480h]
		or	[bx+1680h], al
		mov	al, [bx+900h]
		or	[bx+1B00h], al
		mov	al, [bx+0D80h]
		or	[bx+1F80h], al
		inc	bx
		loop	loc_129A3
		pop	ds
		retn
sub_12999	endp


; =============== S U B	R O U T	I N E =======================================


sub_129E6	proc near		; CODE XREF: seg000:28D8p
		mov	si, 1200h
		mov	al, SomeGDCPlane
		cmp	al, 2
		jb	short loc_12A0A
		mov	ax, word_1D170
		call	SomeGDCCopy4
		add	ax, 800h
		call	SomeGDCCopy4
		mov	ax, word_1D172
		call	SomeGDCCopy4
		add	ax, 800h
		call	SomeGDCCopy4
		jmp	short locret_12A24
; ---------------------------------------------------------------------------

loc_12A0A:				; CODE XREF: sub_129E6+8j
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	ax, 0A800h	; GVRAM	Plane 0
		call	SomeGDCCopy4
		mov	ax, 0B000h	; GVRAM	Plane 1
		call	SomeGDCCopy4
		mov	ax, 0B800h	; GVRAM	Plane 2
		call	SomeGDCCopy4
		mov	ax, 0E000h	; GVRAM	Plane 3
		call	SomeGDCCopy4

locret_12A24:				; CODE XREF: sub_129E6+22j
		retn
sub_129E6	endp


; =============== S U B	R O U T	I N E =======================================


SomeGDCCopy4	proc near		; CODE XREF: sub_129E6+Dp
					; sub_129E6+13p ...
		push	ds
		mov	es, ax
		mov	di, word_1D2A2
		mov	ds, seg_1D16E
		mov	al, 60h

loc_12A32:				; CODE XREF: SomeGDCCopy4+17j
		mov	cx, 6
		rep movsw
		add	di, 44h
		dec	al
		jnz	short loc_12A32
		mov	ax, es
		pop	ds
		retn
SomeGDCCopy4	endp

; ---------------------------------------------------------------------------

loc_12A42:				; DATA XREF: seg000:off_1259Ao
		push	si
		push	es
		mov	si, offset byte_1D3C4
		mov	ax, 0A800h	; GVRAM	Plane 0
		mov	dx, word_1D170
		call	SomeGDCCopy5
		mov	ax, 0B000h	; GVRAM	Plane 1
		add	dx, 800h
		call	SomeGDCCopy5
		mov	ax, 0B800h	; GVRAM	Plane 2
		mov	dx, word_1D172
		call	SomeGDCCopy5
		mov	ax, 0E000h	; GVRAM	Plane 3
		add	dx, 800h
		call	SomeGDCCopy5
		xor	al, al
		out	0A6h, al	; Interrupt Controller #2, 8259A
		pop	es
		pop	si
		jmp	loc_12572

; =============== S U B	R O U T	I N E =======================================


SomeGDCCopy5	proc near		; CODE XREF: seg000:2A4Ep seg000:2A58p ...
		mov	es, ax
		mov	al, SomeGDCPlane
		cmp	al, 2
		jb	short loc_12A85
		mov	es, dx
		xor	al, al

loc_12A85:				; CODE XREF: SomeGDCCopy5+7j
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	di, word_1D2A2
		mov	al, 60h

loc_12A8D:				; CODE XREF: SomeGDCCopy5+1Fj
		mov	cx, 6
		rep movsw
		add	di, 44h
		dec	al
		jnz	short loc_12A8D
		retn
SomeGDCCopy5	endp

; ---------------------------------------------------------------------------

loc_12A9A:				; DATA XREF: seg000:off_1259Ao
		mov	al, es:[si]
		inc	si
		mov	byte_1E5C6, al
		jmp	loc_12572
; ---------------------------------------------------------------------------

loc_12AA4:				; DATA XREF: seg000:off_1259Ao
		cmp	byte_1D17A, 0FFh
		jnz	short loc_12AB7
		mov	byte_1D178, 0
		inc	byte_1D179
		jmp	loc_12572
; ---------------------------------------------------------------------------

loc_12AB7:				; CODE XREF: seg000:2AA9j
		mov	bx, word_1D17E
		mov	ax, [bx+4]
		inc	ax
		add	ax, ax
		mov	[bx+0Ch], ax
		inc	word ptr [bx+0Ah]
		jmp	loc_12572
; ---------------------------------------------------------------------------

loc_12ACA:				; DATA XREF: seg000:off_1259Ao
		inc	si
		jmp	loc_12572
; ---------------------------------------------------------------------------

loc_12ACE:				; DATA XREF: seg000:off_125B8o
		mov	al, es:[si]
		inc	si
		and	al, 1
		cbw
		mov	cx, ax
		shl	ax, 7
		shl	cx, 5
		add	ax, cx
		add	ax, offset byte_1B22E
		mov	off_1B22C, ax
		jmp	loc_12572

; =============== S U B	R O U T	I N E =======================================


PrintInt_2Digs	proc near		; CODE XREF: seg000:3844p seg000:384Fp ...
		push	ax		; NOTE:	This takes the number from AL and converts it into a
		push	cx		; 2-digit text.	(using Shift-JIS mirrors of ASCII)
		xor	ah, ah		; The characters are added to the beginning of the string.
		mov	cl, 10
		div	cl
		xchg	ah, al
		push	ax
		mov	ah, 85h
		add	al, 4Fh
		call	str_Prepend2B
		pop	ax
		mov	al, ah
		mov	ah, 85h
		add	al, 4Fh
		call	str_Prepend2B
		pop	cx
		pop	ax
		retn
PrintInt_2Digs	endp


; =============== S U B	R O U T	I N E =======================================


str_Prepend1B	proc near		; CODE XREF: seg000:385Fp seg000:391Bp
		push	ax
		push	cx
		push	dx
		push	bx
		add	bx, 4Eh
		mov	cx, 4Fh		; == 50h / 1 - 1

loc_12B11:				; CODE XREF: str_Prepend1B+10j
		mov	dl, [bx]
		mov	[bx+1],	dl
		dec	bx
		loop	loc_12B11
		pop	bx
		mov	[bx], al
		pop	dx
		pop	cx
		pop	ax
		retn
str_Prepend1B	endp


; =============== S U B	R O U T	I N E =======================================


str_Prepend2B	proc near		; CODE XREF: PrintInt_2Digs+Fp
					; PrintInt_2Digs+19p ...
		push	ax
		push	cx
		push	dx
		push	bx
		add	bx, 4Ch
		mov	cx, 27h		; == 50h / 2 - 1

loc_12B2A:				; CODE XREF: str_Prepend2B+11j
		mov	dx, [bx]
		mov	[bx+2],	dx
		dec	bx
		dec	bx
		loop	loc_12B2A
		pop	bx
		xchg	al, ah
		mov	[bx], ax
		pop	dx
		pop	cx
		pop	ax
		retn
str_Prepend2B	endp


; =============== S U B	R O U T	I N E =======================================


DoPalThing	proc near		; CODE XREF: seg000:3F8Bp
		push	ax
		push	bx
		push	cx
		push	dx
		push	si
		push	di
		push	ds
		push	es
		mov	si, 100h
		push	ds
		pop	es
		assume es:dseg
		mov	di, offset PalCurrent
		mov	ds, seg_1D16E
		mov	ax, word_18DE4
		shr	ax, 3
		mov	es:word_1D0FE, ax
		mov	ax, word_18DE6
		mov	es:word_1D100, ax
		cld
		push	di
		push	es
		mov	cx, 10h

loc_12B67:				; CODE XREF: DoPalThing+30j
		lodsw
		xchg	ah, al		; swap "red" and "green" colour	components
		stosw
		movsb			; copy "blue" colour component
		loop	loc_12B67
		pop	ds
		pop	si
		mov	cx, 18h
		cli
		rep movsw
		sti
		pop	es
		assume es:nothing
		pop	ds
		pop	di
		pop	si
		pop	dx
		pop	cx
		pop	bx
		pop	ax
		retn
DoPalThing	endp


; =============== S U B	R O U T	I N E =======================================


LoadPIImage1	proc near		; CODE XREF: seg000:3F88p
		push	ax
		push	bx
		push	cx
		push	dx
		push	si
		push	di
		push	ds
		push	es
		mov	ax, seg	dseg
		mov	ds, ax
		mov	es, ax
		assume es:dseg
		push	ax
		cli
		mov	al, byte_1E5C6
		push	ax
		mov	byte_1E5C6, 0
		sti
		mov	dx, offset FileDiskDrive
		mov	ax, word_1D0F8
		shl	ax, 3
		mov	ds, seg_1D16E
		assume ds:nothing
		mov	ds:130h, ax
		mov	ax, es:word_1D0FA
		mov	ds:132h, ax
		mov	word ptr ds:146h, 0EBB6h
		call	LoadPIImage2
		cli
		pop	ax
		pop	ds
		assume ds:dseg
		mov	byte_1E5C6, al
		sti
		pop	es
		assume es:nothing
		pop	ds
		pop	di
		pop	si
		pop	dx
		pop	cx
		pop	bx
		pop	ax
		retn
LoadPIImage1	endp

		assume ds:nothing

; =============== S U B	R O U T	I N E =======================================


LoadPIImage2	proc near		; CODE XREF: LoadPIImage1+38p
		cld
		mov	es:word_1D176, sp
		mov	es:seg_1D174, ds
		mov	ax, es
		mov	ds, ax
		assume ds:dseg
		push	0
		push	ds
		push	dx
		call	OpenFile2
		pop	dx
		pop	dx
		pop	dx
		test	ax, ax
		jnz	short loc_12BF5
		push	seg seg001
		pop	ds
		assume ds:seg001
		mov	word_18AF0, offset aFileLoadErr	; "ƒtƒ@ƒCƒ‹‚Ì“Ç‚Ýž‚Ý‚ÉŽ¸”s‚µ‚Ü‚µ‚½\r\n$"
		jmp	ExitWithErrMsg
; ---------------------------------------------------------------------------
		assume ds:dseg

loc_12BF5:				; CODE XREF: LoadPIImage2+1Bj
		mov	bx, seg_1D174
		mov	ds, bx
		mov	es, bx
		mov	word_18DF0, ax
		mov	bx, word_18DE0
		mov	ax, word_18DE2
		shr	bx, 3
		shl	ax, 4
		add	bx, ax
		add	ax, ax
		add	ax, ax
		add	ax, bx
		mov	word_18DEE, ax
		call	ReadFullFile2
		mov	si, bx
		lodsw
		xchg	ah, al
		mov	word_18DE4, ax
		mov	cx, ax
		neg	ax
		mov	word ptr cs:loc_12D27+1, ax
		inc	ax
		mov	word ptr cs:loc_12CC6+1, ax
		dec	ax
		add	ax, ax
		mov	word ptr cs:loc_12CBB+1, ax
		add	cx, cx
		mov	ax, cx
		add	ax, offset byte_18DFA
		mov	word_18DF2, ax
		add	cx, cx
		mov	word_18DEC, cx
		add	ax, cx
		mov	word_18DF4, ax
		mov	word ptr cs:loc_12D10+2, ax
		mov	word ptr cs:loc_12D62+1, ax
		mov	word ptr cs:loc_12D95+2, ax
		mov	ax, word_18DE0
		and	ax, 7
		add	ax, word_18DE4
		mov	word_18DE8, ax
		lodsw
		xchg	ah, al
		mov	word_18DE6, ax
		mov	word_18DEA, ax
		mov	cx, 30h
		mov	di, 100h

loc_12C74:				; CODE XREF: LoadPIImage2+AEj
		lodsb
		shr	al, 4
		stosb
		loop	loc_12C74
		mov	bx, si
		call	InitPiDeltaTbl

DecomprPIImage:
		mov	dh, 1
		mov	di, offset byte_18DFA
		xor	al, al
		call	PI_ProcDeltaCode
		mov	cx, word_18DE4
		rep stosw
		xor	bp, bp
		jmp	loc_12D19
; ---------------------------------------------------------------------------

loc_12C95:				; CODE XREF: LoadPIImage2+ECj
		mov	dl, [bx]
		mov	dh, 8
		inc	bx
		cmp	bx, 0FC00h
		jnz	short loc_12CB9
		call	ReadFullFile2
		jmp	short loc_12CB9
; ---------------------------------------------------------------------------

loc_12CA5:				; CODE XREF: LoadPIImage2+F7j
		mov	dl, [bx]
		mov	dh, 8
		inc	bx
		cmp	bx, 0FC00h
		jnz	short loc_12CC4
		call	ReadFullFile2
		jmp	short loc_12CC4
; ---------------------------------------------------------------------------

loc_12CB5:				; CODE XREF: LoadPIImage2+154j
		dec	dh
		jz	short loc_12C95

loc_12CB9:				; CODE XREF: LoadPIImage2+D3j
					; LoadPIImage2+D8j
		add	dl, dl

loc_12CBB:				; DATA XREF: LoadPIImage2+68w
		mov	si, 0
		jnb	short loc_12D36
		dec	dh
		jz	short loc_12CA5

loc_12CC4:				; CODE XREF: LoadPIImage2+E3j
					; LoadPIImage2+E8j
		add	dl, dl

loc_12CC6:				; DATA XREF: LoadPIImage2+61w
		mov	si, 0
		jnb	short loc_12D36
		dec	si
		dec	si
		jmp	short loc_12D36
; ---------------------------------------------------------------------------

loc_12CCF:				; CODE XREF: LoadPIImage2+150j
		mov	dl, [bx]
		mov	dh, 8
		inc	bx
		cmp	bx, 0FC00h
		jnz	short loc_12D1D
		call	ReadFullFile2
		jmp	short loc_12D1D
; ---------------------------------------------------------------------------

loc_12CDF:				; CODE XREF: LoadPIImage2+158j
		mov	dl, [bx]
		mov	dh, 8
		inc	bx
		cmp	bx, 0FC00h
		jnz	short loc_12D25
		call	ReadFullFile2
		jmp	short loc_12D25
; ---------------------------------------------------------------------------

loc_12CEF:				; CODE XREF: LoadPIImage2+175j
		mov	dl, [bx]
		mov	dh, 8
		inc	bx
		cmp	bx, 0FC00h
		jnz	short loc_12D42
		call	ReadFullFile2
		jmp	short loc_12D42
; ---------------------------------------------------------------------------

loc_12CFF:				; CODE XREF: LoadPIImage2+183j
		mov	dl, [bx]
		mov	dh, 8
		inc	bx
		cmp	bx, 0FC00h
		jnz	short loc_12D50
		call	ReadFullFile2
		jmp	short loc_12D50
; ---------------------------------------------------------------------------

loc_12D0F:				; CODE XREF: LoadPIImage2+179j
		movsw

loc_12D10:				; DATA XREF: LoadPIImage2+81w
		cmp	di, 0
		jnz	short loc_12D19
		call	DoGFXThing

loc_12D19:				; CODE XREF: LoadPIImage2+C7j
					; LoadPIImage2+149j ...
		dec	dh
		jz	short loc_12CCF

loc_12D1D:				; CODE XREF: LoadPIImage2+10Dj
					; LoadPIImage2+112j
		add	dl, dl
		jb	short loc_12CB5
		dec	dh
		jz	short loc_12CDF

loc_12D25:				; CODE XREF: LoadPIImage2+11Dj
					; LoadPIImage2+122j
		add	dl, dl

loc_12D27:				; DATA XREF: LoadPIImage2+5Cw
		mov	si, 0
		jb	short loc_12D36
		mov	si, 0FFFCh
		mov	ax, [di-2]
		cmp	ah, al
		jz	short loc_12D81

loc_12D36:				; CODE XREF: LoadPIImage2+F3j
					; LoadPIImage2+FEj ...
		cmp	si, bp
		mov	bp, si
		jz	short loc_12D8C
		add	si, di

loc_12D3E:				; CODE XREF: LoadPIImage2+1BFj
		dec	dh
		jz	short loc_12CEF

loc_12D42:				; CODE XREF: LoadPIImage2+12Dj
					; LoadPIImage2+132j
		add	dl, dl
		jnb	short loc_12D0F
		mov	ax, 1
		xor	cx, cx

loc_12D4B:				; CODE XREF: LoadPIImage2+187j
		inc	cx
		dec	dh
		jz	short loc_12CFF

loc_12D50:				; CODE XREF: LoadPIImage2+13Dj
					; LoadPIImage2+142j
		add	dl, dl
		jb	short loc_12D4B

loc_12D54:				; CODE XREF: LoadPIImage2+191j
		dec	dh
		jz	short loc_12D71

loc_12D58:				; CODE XREF: LoadPIImage2+1AFj
					; LoadPIImage2+1B4j
		add	dl, dl
		adc	ax, ax
		loop	loc_12D54
		jb	short loc_12DBB

loc_12D60:				; CODE XREF: LoadPIImage2+1EEj
					; LoadPIImage2+1F9j ...
		mov	cx, ax

loc_12D62:				; DATA XREF: LoadPIImage2+85w
		mov	ax, 0
		sub	ax, di
		shr	ax, 1
		cmp	cx, ax
		jnb	short loc_12DAD
		rep movsw
		jmp	short loc_12D19
; ---------------------------------------------------------------------------

loc_12D71:				; CODE XREF: LoadPIImage2+18Bj
		mov	dl, [bx]
		mov	dh, 8
		inc	bx
		cmp	bx, 0FC00h
		jnz	short loc_12D58
		call	ReadFullFile2
		jmp	short loc_12D58
; ---------------------------------------------------------------------------

loc_12D81:				; CODE XREF: LoadPIImage2+169j
		cmp	si, bp
		mov	bp, si
		jz	short loc_12D8C
		lea	si, [di-2]
		jmp	short loc_12D3E
; ---------------------------------------------------------------------------

loc_12D8C:				; CODE XREF: LoadPIImage2+16Fj
					; LoadPIImage2+1BAj
		mov	al, [di-1]

loc_12D8F:				; CODE XREF: LoadPIImage2+1D6j
		call	PI_ProcDeltaCode
		stosw
		mov	al, ah

loc_12D95:				; DATA XREF: LoadPIImage2+89w
		cmp	di, 0
		jz	short loc_12DA8

loc_12D9B:				; CODE XREF: LoadPIImage2+1E0j
		dec	dh
		jz	short loc_12DD1

loc_12D9F:				; CODE XREF: LoadPIImage2+20Fj
					; LoadPIImage2+214j
		add	dl, dl
		jb	short loc_12D8F
		xor	bp, bp
		jmp	loc_12D19
; ---------------------------------------------------------------------------

loc_12DA8:				; CODE XREF: LoadPIImage2+1CEj
		call	DoGFXThing
		jmp	short loc_12D9B
; ---------------------------------------------------------------------------

loc_12DAD:				; CODE XREF: LoadPIImage2+1A0j
		sub	cx, ax
		xchg	ax, cx
		rep movsw
		call	DoGFXThing
		sub	si, word_18DEC
		jmp	short loc_12D60
; ---------------------------------------------------------------------------

loc_12DBB:				; CODE XREF: LoadPIImage2+193j
		xor	cx, cx

loc_12DBD:				; CODE XREF: LoadPIImage2+1F7j
					; LoadPIImage2+204j
		movsw
		cmp	di, word_18DF4
		loopne	loc_12DBD
		jnz	short loc_12D60
		call	DoGFXThing
		sub	si, word_18DEC
		jcxz	short loc_12D60
		jmp	short loc_12DBD
; ---------------------------------------------------------------------------

loc_12DD1:				; CODE XREF: LoadPIImage2+1D2j
		mov	dl, [bx]
		mov	dh, 8
		inc	bx
		cmp	bx, 0FC00h
		jnz	short loc_12D9F
		call	ReadFullFile2
		jmp	short loc_12D9F
LoadPIImage2	endp

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR PI_ProcDeltaCode

loc_12DE1:				; CODE XREF: PI_ProcDeltaCode-13j
		mov	dl, [bx]
		mov	dh, 8
		inc	bx
		cmp	bx, 0FC00h
		jnz	short loc_12E45
		call	ReadFullFile2
		jmp	short loc_12E45
; ---------------------------------------------------------------------------

loc_12DF1:				; CODE XREF: PI_ProcDeltaCode+8j
		mov	dl, [bx]
		mov	dh, 8
		inc	bx
		cmp	bx, 0FC00h
		jnz	short loc_12E60
		call	ReadFullFile2
		jmp	short loc_12E60
; ---------------------------------------------------------------------------

loc_12E01:				; CODE XREF: PI_ProcDeltaCode+10j
		mov	dl, [bx]
		mov	dh, 8
		inc	bx
		cmp	bx, 0FC00h
		jnz	short loc_12E68
		call	ReadFullFile2
		jmp	short loc_12E68
; ---------------------------------------------------------------------------

loc_12E11:				; CODE XREF: PI_ProcDeltaCode+1Bj
		mov	dl, [bx]
		mov	dh, 8
		inc	bx
		cmp	bx, 0FC00h
		jnz	short loc_12E73
		call	ReadFullFile2
		jmp	short loc_12E73
; ---------------------------------------------------------------------------

loc_12E21:				; CODE XREF: PI_ProcDeltaCode+23j
		mov	dl, [bx]
		mov	dh, 8
		inc	bx
		cmp	bx, 0FC00h
		jnz	short loc_12E7B
		call	ReadFullFile2
		jmp	short loc_12E7B
; ---------------------------------------------------------------------------

loc_12E31:				; CODE XREF: PI_ProcDeltaCode+2Bj
		mov	dl, [bx]
		mov	dh, 8
		inc	bx
		cmp	bx, 0FC00h
		jnz	short loc_12E83
		call	ReadFullFile2
		jmp	short loc_12E83
; ---------------------------------------------------------------------------

loc_12E41:				; CODE XREF: PI_ProcDeltaCode+Cj
		dec	dh
		jz	short loc_12DE1

loc_12E45:				; CODE XREF: PI_ProcDeltaCode-6Cj
					; PI_ProcDeltaCode-67j
		add	dl, dl
		jb	short loc_12E4C
		lodsb
		jmp	short loc_12EBB
; ---------------------------------------------------------------------------

loc_12E4C:				; CODE XREF: PI_ProcDeltaCode-Fj
		mov	ax, [si]
		xchg	ah, al
		mov	[si], ax
		xor	ah, ah
		jmp	short loc_12EBB
; END OF FUNCTION CHUNK	FOR PI_ProcDeltaCode

; =============== S U B	R O U T	I N E =======================================


PI_ProcDeltaCode proc near		; CODE XREF: LoadPIImage2+BCp
					; LoadPIImage2:loc_12D8Fp

; FUNCTION CHUNK AT 2DE1 SIZE 00000075 BYTES

		mov	bp, di
		xor	ah, ah
		mov	si, ax
		dec	dh
		jz	short loc_12DF1

loc_12E60:				; CODE XREF: PI_ProcDeltaCode-5Cj
					; PI_ProcDeltaCode-57j
		add	dl, dl
		jb	short loc_12E41
		dec	dh
		jz	short loc_12E01

loc_12E68:				; CODE XREF: PI_ProcDeltaCode-4Cj
					; PI_ProcDeltaCode-47j
		add	dl, dl
		mov	cx, 1
		jnb	short loc_12E87
		dec	dh
		jz	short loc_12E11

loc_12E73:				; CODE XREF: PI_ProcDeltaCode-3Cj
					; PI_ProcDeltaCode-37j
		add	dl, dl
		jnb	short loc_12E7F
		dec	dh
		jz	short loc_12E21

loc_12E7B:				; CODE XREF: PI_ProcDeltaCode-2Cj
					; PI_ProcDeltaCode-27j
		add	dl, dl
		adc	cx, cx

loc_12E7F:				; CODE XREF: PI_ProcDeltaCode+1Fj
		dec	dh
		jz	short loc_12E31

loc_12E83:				; CODE XREF: PI_ProcDeltaCode-1Cj
					; PI_ProcDeltaCode-17j
		add	dl, dl
		adc	cx, cx

loc_12E87:				; CODE XREF: PI_ProcDeltaCode+17j
		dec	dh
		jz	short loc_12E9B

loc_12E8B:				; CODE XREF: PI_ProcDeltaCode+4Ej
					; PI_ProcDeltaCode+53j
		add	dl, dl
		adc	cx, cx
		add	si, cx
		std
		lodsb
		lea	di, [si+1]
		rep movsb
		stosb
		jmp	short loc_12EBB
; ---------------------------------------------------------------------------

loc_12E9B:				; CODE XREF: PI_ProcDeltaCode+33j
		mov	dl, [bx]
		mov	dh, 8
		inc	bx
		cmp	bx, 0FC00h
		jnz	short loc_12E8B
		call	ReadFullFile2
		jmp	short loc_12E8B
; ---------------------------------------------------------------------------

loc_12EAB:				; CODE XREF: PI_ProcDeltaCode+6Bj
		mov	dl, [bx]
		mov	dh, 8
		inc	bx
		cmp	bx, 0FC00h
		jnz	short loc_12EC3
		call	ReadFullFile2
		jmp	short loc_12EC3
; ---------------------------------------------------------------------------

loc_12EBB:				; CODE XREF: PI_ProcDeltaCode-Cj
					; PI_ProcDeltaCode-2j ...
		xor	ah, ah
		mov	si, ax
		dec	dh
		jz	short loc_12EAB

loc_12EC3:				; CODE XREF: PI_ProcDeltaCode+5Ej
					; PI_ProcDeltaCode+63j
		add	dl, dl
		jb	short loc_12F04
		dec	dh
		jz	short loc_12F1E

loc_12ECB:				; CODE XREF: PI_ProcDeltaCode+D1j
					; PI_ProcDeltaCode+D6j
		add	dl, dl
		mov	cx, 1
		jnb	short loc_12EEA
		dec	dh
		jz	short loc_12F2E

loc_12ED6:				; CODE XREF: PI_ProcDeltaCode+E1j
					; PI_ProcDeltaCode+E6j
		add	dl, dl
		jnb	short loc_12EE2
		dec	dh
		jz	short loc_12F3E

loc_12EDE:				; CODE XREF: PI_ProcDeltaCode+F1j
					; PI_ProcDeltaCode+F6j
		add	dl, dl
		adc	cx, cx

loc_12EE2:				; CODE XREF: PI_ProcDeltaCode+82j
		dec	dh
		jz	short loc_12F4E

loc_12EE6:				; CODE XREF: PI_ProcDeltaCode+101j
					; PI_ProcDeltaCode+106j
		add	dl, dl
		adc	cx, cx

loc_12EEA:				; CODE XREF: PI_ProcDeltaCode+7Aj
		dec	dh
		jz	short loc_12F5E

loc_12EEE:				; CODE XREF: PI_ProcDeltaCode+111j
					; PI_ProcDeltaCode+116j
		add	dl, dl
		adc	cx, cx
		add	si, cx
		std
		mov	ah, al
		lodsb
		lea	di, [si+1]
		rep movsb
		stosb
		xchg	ah, al
		mov	di, bp
		cld
		retn
; ---------------------------------------------------------------------------

loc_12F04:				; CODE XREF: PI_ProcDeltaCode+6Fj
		dec	dh
		jz	short loc_12F6E

loc_12F08:				; CODE XREF: PI_ProcDeltaCode+121j
					; PI_ProcDeltaCode+126j
		add	dl, dl
		jb	short loc_12F12
		mov	ah, [si]
		mov	di, bp
		cld
		retn
; ---------------------------------------------------------------------------

loc_12F12:				; CODE XREF: PI_ProcDeltaCode+B4j
		mov	cx, [si]
		xchg	ch, cl
		mov	[si], cx
		mov	ah, cl
		mov	di, bp
		cld
		retn
; ---------------------------------------------------------------------------

loc_12F1E:				; CODE XREF: PI_ProcDeltaCode+73j
		mov	dl, [bx]
		mov	dh, 8
		inc	bx
		cmp	bx, 0FC00h
		jnz	short loc_12ECB
		call	ReadFullFile2
		jmp	short loc_12ECB
; ---------------------------------------------------------------------------

loc_12F2E:				; CODE XREF: PI_ProcDeltaCode+7Ej
		mov	dl, [bx]
		mov	dh, 8
		inc	bx
		cmp	bx, 0FC00h
		jnz	short loc_12ED6
		call	ReadFullFile2
		jmp	short loc_12ED6
; ---------------------------------------------------------------------------

loc_12F3E:				; CODE XREF: PI_ProcDeltaCode+86j
		mov	dl, [bx]
		mov	dh, 8
		inc	bx
		cmp	bx, 0FC00h
		jnz	short loc_12EDE
		call	ReadFullFile2
		jmp	short loc_12EDE
; ---------------------------------------------------------------------------

loc_12F4E:				; CODE XREF: PI_ProcDeltaCode+8Ej
		mov	dl, [bx]
		mov	dh, 8
		inc	bx
		cmp	bx, 0FC00h
		jnz	short loc_12EE6
		call	ReadFullFile2
		jmp	short loc_12EE6
; ---------------------------------------------------------------------------

loc_12F5E:				; CODE XREF: PI_ProcDeltaCode+96j
		mov	dl, [bx]
		mov	dh, 8
		inc	bx
		cmp	bx, 0FC00h
		jnz	short loc_12EEE
		call	ReadFullFile2
		jmp	short loc_12EEE
; ---------------------------------------------------------------------------

loc_12F6E:				; CODE XREF: PI_ProcDeltaCode+B0j
		mov	dl, [bx]
		mov	dh, 8
		inc	bx
		cmp	bx, 0FC00h
		jnz	short loc_12F08
		call	ReadFullFile2
		jmp	short loc_12F08
PI_ProcDeltaCode endp


; =============== S U B	R O U T	I N E =======================================


ReadFullFile2	proc near		; CODE XREF: LoadPIImage2+4Dp
					; LoadPIImage2+D5p ...

; FUNCTION CHUNK AT 19A2 SIZE 00000026 BYTES

		push	ax
		push	cx
		push	dx
		mov	dx, 104Ah
		push	dx
		push	0
		push	word_18DF6
		push	ds
		push	dx
		push	word_18DF0
		call	ReadFullFile
		test	ax, ax
		jnz	short loc_12FB1
		call	fclose
		push	seg dseg
		pop	ds
		mov	sp, word_1D176
		push	seg seg001
		pop	ds
		assume ds:seg001
		mov	word_18AF0, offset aFileLoadErr	; "ƒtƒ@ƒCƒ‹‚Ì“Ç‚Ýž‚Ý‚ÉŽ¸”s‚µ‚Ü‚µ‚½\r\n$"
		jmp	ExitWithErrMsg
; ---------------------------------------------------------------------------
		assume ds:dseg

loc_12FB1:				; CODE XREF: ReadFullFile2+19j
		add	sp, 0Ah
		pop	bx
		pop	dx
		pop	cx
		pop	ax
		retn
ReadFullFile2	endp

; resulting table:
;
;   00 F0 E0 ... 20 10
;   10 00 F0 ... 30 20
;   20 10 00 ... 40 30
;   ...
;   E0 D0 C0 ... 00 F0
;   F0 E0 D0 ... 10 00

; =============== S U B	R O U T	I N E =======================================


InitPiDeltaTbl	proc near		; CODE XREF: LoadPIImage2+B2p
		xor	di, di		; address of "PI" format colour	delta table
		mov	ax, 1000h

loc_12FBE:				; CODE XREF: InitPiDeltaTbl+11j
		mov	cx, 10h

loc_12FC1:				; CODE XREF: InitPiDeltaTbl+Bj
		stosb
		sub	al, 10h
		loop	loc_12FC1
		add	al, 10h
		dec	ah
		jnz	short loc_12FBE
		retn
InitPiDeltaTbl	endp


; =============== S U B	R O U T	I N E =======================================


DoGFXThing	proc near		; CODE XREF: LoadPIImage2+14Bp
					; LoadPIImage2:loc_12DA8p ...
		cmp	cs:byte_1374E, 2
		jnb	short loc_12FE0
		cmp	cs:byte_1374F, 0
		jz	short loc_12FEF
		jmp	loc_131AF
; ---------------------------------------------------------------------------

loc_12FE0:				; CODE XREF: DoGFXThing+6j
		cmp	cs:byte_1374F, 0
		jnz	short loc_12FEB
		jmp	loc_13393
; ---------------------------------------------------------------------------

loc_12FEB:				; CODE XREF: DoGFXThing+19j
		jmp	loc_13559
; ---------------------------------------------------------------------------
		retn
; ---------------------------------------------------------------------------

loc_12FEF:				; CODE XREF: DoGFXThing+Ej
		pusha
		push	es
		mov	si, word_18DF4
		mov	di, offset byte_15C3A
		mov	cx, word_18DE4
		sub	si, cx
		sub	si, cx
		rep movsw
		mov	si, di
		mov	cx, 4

loc_13007:				; CODE XREF: DoGFXThing+1C5j
		push	cx
		mov	di, word_18DEE
		mov	ax, word_18DE0
		and	ax, 7
		jz	short loc_1306D
		mov	cx, 8
		sub	cx, ax
		push	cx
		mov	ah, 0FFh
		shl	ah, cl
		xor	bx, bx
		mov	dx, bx

loc_13022:				; CODE XREF: DoGFXThing+66j
		lodsb
		add	al, al
		adc	bl, bl
		add	al, al
		adc	bh, bh
		add	al, al
		adc	dl, dl
		add	al, al
		adc	dh, dh
		loop	loc_13022
		mov	cl, dh
		or	cl, dl
		or	cl, bh
		or	cl, bl
		or	cl, ah
		not	cl
		or	ah, cl
		mov	cx, 0A800h	; GVRAM	Plane 0
		mov	es, cx
		assume es:nothing
		mov	es:[di], dh
		mov	ch, 0B0h	; GVRAM	Plane 1
		mov	es, cx
		assume es:nothing
		mov	es:[di], dl
		mov	ch, 0B8h	; GVRAM	Plane 2
		mov	es, cx
		assume es:nothing
		mov	es:[di], bh
		mov	ch, 0E0h	; GVRAM	Plane 3
		mov	es, cx
		assume es:nothing
		mov	es:[di], bl
		inc	di
		pop	ax
		mov	cx, word_18DE4
		sub	cx, ax
		shr	cx, 3
		jmp	short loc_13074
; ---------------------------------------------------------------------------

loc_1306D:				; CODE XREF: DoGFXThing+45j
		mov	cx, word_18DE4
		shr	cx, 3

loc_13074:				; CODE XREF: DoGFXThing+9Ej
					; DoGFXThing+158j
		lodsw
		add	al, al
		adc	bl, bl
		add	ah, ah
		adc	bl, bl
		add	al, al
		adc	bh, bh
		add	ah, ah
		adc	bh, bh
		add	al, al
		adc	dl, dl
		add	ah, ah
		adc	dl, dl
		add	al, al
		adc	dh, dh
		add	ah, ah
		adc	dh, dh
		lodsw
		add	al, al
		adc	bl, bl
		add	ah, ah
		adc	bl, bl
		add	al, al
		adc	bh, bh
		add	ah, ah
		adc	bh, bh
		add	al, al
		adc	dl, dl
		add	ah, ah
		adc	dl, dl
		add	al, al
		adc	dh, dh
		add	ah, ah
		adc	dh, dh
		lodsw
		add	al, al
		adc	bl, bl
		add	ah, ah
		adc	bl, bl
		add	al, al
		adc	bh, bh
		add	ah, ah
		adc	bh, bh
		add	al, al
		adc	dl, dl
		add	ah, ah
		adc	dl, dl
		add	al, al
		adc	dh, dh
		add	ah, ah
		adc	dh, dh
		lodsw
		add	al, al
		adc	bl, bl
		add	ah, ah
		adc	bl, bl
		add	al, al
		adc	bh, bh
		add	ah, ah
		adc	bh, bh
		add	al, al
		adc	dl, dl
		add	ah, ah
		adc	dl, dl
		add	al, al
		adc	dh, dh
		add	ah, ah
		adc	dh, dh
		push	cx

loc_130F9:
		mov	cl, dh
		or	cl, dl
		or	cl, bh
		or	cl, bl
		not	cl
		mov	ax, 0A800h	; GVRAM	Plane 0
		mov	es, ax
		assume es:nothing
		mov	es:[di], dh
		mov	ah, 0B0h	; GVRAM	Plane 1
		mov	es, ax
		assume es:nothing
		mov	es:[di], dl
		mov	ah, 0B8h	; GVRAM	Plane 2
		mov	es, ax
		assume es:nothing
		mov	es:[di], bh
		mov	ah, 0E0h	; GVRAM	Plane 3
		mov	es, ax
		assume es:nothing
		mov	es:[di], bl
		inc	di
		pop	cx
		dec	cx
		jz	short loc_13128
		jmp	loc_13074
; ---------------------------------------------------------------------------

loc_13128:				; CODE XREF: DoGFXThing+156j
		mov	cx, word_18DE8
		and	cx, 7
		jz	short loc_13183
		mov	ah, 8
		sub	ah, cl
		xor	bx, bx
		mov	dx, bx

loc_13139:				; CODE XREF: DoGFXThing+17Dj
		lodsb
		add	al, al
		adc	bl, bl
		add	al, al
		adc	bh, bh
		add	al, al
		adc	dl, dl
		add	al, al
		adc	dh, dh
		loop	loc_13139
		mov	cl, ah
		mov	ch, 0FFh
		shl	ch, cl
		not	ch
		shl	bx, cl
		shl	dx, cl
		mov	al, dh
		or	al, dl
		or	al, bh
		or	al, bl
		or	al, ch
		not	al
		or	ch, al
		mov	ax, 0A800h	; GVRAM	Plane 0
		mov	es, ax
		assume es:nothing
		mov	es:[di], dh
		mov	ah, 0B0h	; GVRAM	Plane 1
		mov	es, ax
		assume es:nothing
		mov	es:[di], dl
		mov	ah, 0B8h	; GVRAM	Plane 2
		mov	es, ax
		assume es:nothing
		mov	es:[di], bh
		mov	ah, 0E0h	; GVRAM	Plane 3
		mov	es, ax
		assume es:nothing
		mov	es:[di], bl

loc_13183:				; CODE XREF: DoGFXThing+162j
		pop	cx
		add	word_18DEE, 50h
		dec	word_18DEA
		jz	short loc_1319C
		dec	cx
		jz	short loc_13195
		jmp	loc_13007
; ---------------------------------------------------------------------------

loc_13195:				; CODE XREF: DoGFXThing+1C3j
		pop	es
		assume es:nothing
		popa
		mov	di, word_18DF2
		retn
; ---------------------------------------------------------------------------

loc_1319C:				; CODE XREF: DoGFXThing+1C0j
		push	word_18DF0
		call	fclose
		pop	ax
		push	seg dseg
		pop	ds
		mov	sp, word_1D176
		xor	ax, ax
		retn
; ---------------------------------------------------------------------------

loc_131AF:				; CODE XREF: DoGFXThing+10j
		pusha
		push	es
		mov	si, word_18DF4
		mov	di, offset byte_18DFA
		mov	cx, word_18DE4
		sub	si, cx
		sub	si, cx
		rep movsw
		mov	si, di
		mov	cx, 4

loc_131C7:				; CODE XREF: DoGFXThing+3A9j
		push	cx
		mov	di, word_18DEE
		mov	ax, word_18DE0
		and	ax, 7
		jz	short loc_13239
		mov	cx, 8
		sub	cx, ax
		push	cx
		mov	ah, 0FFh
		shl	ah, cl
		xor	bx, bx
		mov	dx, bx

loc_131E2:				; CODE XREF: DoGFXThing+226j
		lodsb
		add	al, al
		adc	bl, bl
		add	al, al
		adc	bh, bh
		add	al, al
		adc	dl, dl
		add	al, al
		adc	dh, dh
		loop	loc_131E2
		mov	cl, dh
		or	cl, dl
		or	cl, bh
		or	cl, bl
		or	cl, ah
		not	cl
		or	ah, cl
		mov	cx, 0A800h	; GVRAM	Plane 0
		mov	es, cx
		assume es:nothing
		and	es:[di], ah
		or	es:[di], dh
		mov	ch, 0B0h	; GVRAM	Plane 1
		mov	es, cx
		assume es:nothing
		and	es:[di], ah
		or	es:[di], dl
		mov	ch, 0B8h	; GVRAM	Plane 2
		mov	es, cx
		assume es:nothing
		and	es:[di], ah
		or	es:[di], bh
		mov	ch, 0E0h	; GVRAM	Plane 3
		mov	es, cx
		assume es:nothing
		and	es:[di], ah
		or	es:[di], bl
		inc	di
		pop	ax
		mov	cx, word_18DE4
		sub	cx, ax
		shr	cx, 3
		jmp	short loc_13240
; ---------------------------------------------------------------------------

loc_13239:				; CODE XREF: DoGFXThing+205j
		mov	cx, word_18DE4
		shr	cx, 3

loc_13240:				; CODE XREF: DoGFXThing+26Aj
					; DoGFXThing+330j
		lodsw
		add	al, al
		adc	bl, bl
		add	ah, ah
		adc	bl, bl
		add	al, al
		adc	bh, bh
		add	ah, ah
		adc	bh, bh
		add	al, al
		adc	dl, dl
		add	ah, ah
		adc	dl, dl
		add	al, al
		adc	dh, dh
		add	ah, ah
		adc	dh, dh
		lodsw
		add	al, al
		adc	bl, bl
		add	ah, ah
		adc	bl, bl
		add	al, al
		adc	bh, bh
		add	ah, ah
		adc	bh, bh
		add	al, al
		adc	dl, dl
		add	ah, ah
		adc	dl, dl
		add	al, al
		adc	dh, dh
		add	ah, ah
		adc	dh, dh
		lodsw
		add	al, al
		adc	bl, bl
		add	ah, ah
		adc	bl, bl
		add	al, al
		adc	bh, bh
		add	ah, ah
		adc	bh, bh
		add	al, al
		adc	dl, dl
		add	ah, ah
		adc	dl, dl
		add	al, al
		adc	dh, dh
		add	ah, ah
		adc	dh, dh
		lodsw
		add	al, al
		adc	bl, bl
		add	ah, ah
		adc	bl, bl
		add	al, al
		adc	bh, bh
		add	ah, ah
		adc	bh, bh
		add	al, al
		adc	dl, dl
		add	ah, ah
		adc	dl, dl
		add	al, al
		adc	dh, dh
		add	ah, ah
		adc	dh, dh
		push	cx
		mov	cl, dh
		or	cl, dl
		or	cl, bh
		or	cl, bl
		not	cl
		mov	ax, 0A800h	; GVRAM	Plane 0
		mov	es, ax
		assume es:nothing
		and	es:[di], cl
		or	es:[di], dh
		mov	ah, 0B0h	; GVRAM	Plane 1
		mov	es, ax
		assume es:nothing
		and	es:[di], cl
		or	es:[di], dl
		mov	ah, 0B8h	; GVRAM	Plane 2
		mov	es, ax
		assume es:nothing
		and	es:[di], cl
		or	es:[di], bh
		mov	ah, 0E0h	; GVRAM	Plane 3
		mov	es, ax
		assume es:nothing
		and	es:[di], cl
		or	es:[di], bl
		inc	di
		pop	cx
		dec	cx
		jz	short loc_13300
		jmp	loc_13240
; ---------------------------------------------------------------------------

loc_13300:				; CODE XREF: DoGFXThing+32Ej
		mov	cx, word_18DE8
		and	cx, 7
		jz	short loc_13367
		mov	ah, 8
		sub	ah, cl
		xor	bx, bx
		mov	dx, bx

loc_13311:				; CODE XREF: DoGFXThing+355j
		lodsb
		add	al, al
		adc	bl, bl
		add	al, al
		adc	bh, bh
		add	al, al
		adc	dl, dl
		add	al, al
		adc	dh, dh
		loop	loc_13311
		mov	cl, ah
		mov	ch, 0FFh
		shl	ch, cl
		not	ch
		shl	bx, cl
		shl	dx, cl
		mov	al, dh
		or	al, dl
		or	al, bh
		or	al, bl
		or	al, ch
		not	al
		or	ch, al
		mov	ax, 0A800h	; GVRAM	Plane 0
		mov	es, ax
		assume es:nothing
		and	es:[di], ch
		or	es:[di], dh
		mov	ah, 0B0h	; GVRAM	Plane 1
		mov	es, ax
		assume es:nothing
		and	es:[di], ch
		or	es:[di], dl
		mov	ah, 0B8h	; GVRAM	Plane 2
		mov	es, ax
		assume es:nothing
		and	es:[di], ch
		or	es:[di], bh
		mov	ah, 0E0h	; GVRAM	Plane 3
		mov	es, ax
		assume es:nothing
		and	es:[di], ch
		or	es:[di], bl

loc_13367:				; CODE XREF: DoGFXThing+33Aj
		pop	cx
		add	word_18DEE, 50h
		dec	word_18DEA
		jz	short loc_13380
		dec	cx
		jz	short loc_13379
		jmp	loc_131C7
; ---------------------------------------------------------------------------

loc_13379:				; CODE XREF: DoGFXThing+3A7j
		pop	es
		assume es:nothing
		popa
		mov	di, word_18DF2
		retn
; ---------------------------------------------------------------------------

loc_13380:				; CODE XREF: DoGFXThing+3A4j
		push	word_18DF0
		call	fclose
		pop	ax
		push	seg dseg
		pop	ds
		mov	sp, word_1D176
		xor	ax, ax
		retn
; ---------------------------------------------------------------------------

loc_13393:				; CODE XREF: DoGFXThing+1Bj
		pusha
		push	es
		mov	si, word_18DF4
		mov	di, offset byte_18DFA
		mov	cx, word_18DE4
		sub	si, cx
		sub	si, cx
		rep movsw
		mov	si, di
		mov	cx, 4

loc_133AB:				; CODE XREF: DoGFXThing+56Fj
		push	cx
		mov	di, word_18DEE
		mov	ax, word_18DE0
		and	ax, 7
		jz	short loc_13413
		mov	cx, 8
		sub	cx, ax
		push	cx
		mov	ah, 0FFh
		shl	ah, cl
		xor	bx, bx
		mov	dx, bx

loc_133C6:				; CODE XREF: DoGFXThing+40Aj
		lodsb
		add	al, al
		adc	bl, bl
		add	al, al
		adc	bh, bh
		add	al, al
		adc	dl, dl
		add	al, al
		adc	dh, dh
		loop	loc_133C6
		mov	cl, dh
		or	cl, dl
		or	cl, bh
		or	cl, bl
		or	cl, ah
		not	cl
		or	ah, cl
		push	ds
		mov	ax, seg	dseg
		mov	ds, ax
		mov	es, word_1D170
		mov	es:[di], dh
		mov	es:[di-8000h], dl
		mov	es, word_1D172
		mov	es:[di], bh
		mov	es:[di-8000h], bl
		pop	ds
		inc	di
		pop	ax
		mov	cx, word_18DE4
		sub	cx, ax
		shr	cx, 3
		jmp	short loc_1341A
; ---------------------------------------------------------------------------

loc_13413:				; CODE XREF: DoGFXThing+3E9j
		mov	cx, word_18DE4
		shr	cx, 3

loc_1341A:				; CODE XREF: DoGFXThing+444j
					; DoGFXThing+500j
		lodsw
		add	al, al
		adc	bl, bl
		add	ah, ah
		adc	bl, bl
		add	al, al
		adc	bh, bh
		add	ah, ah
		adc	bh, bh
		add	al, al
		adc	dl, dl
		add	ah, ah
		adc	dl, dl
		add	al, al
		adc	dh, dh
		add	ah, ah
		adc	dh, dh
		lodsw
		add	al, al
		adc	bl, bl
		add	ah, ah
		adc	bl, bl
		add	al, al
		adc	bh, bh
		add	ah, ah
		adc	bh, bh
		add	al, al
		adc	dl, dl
		add	ah, ah
		adc	dl, dl
		add	al, al
		adc	dh, dh
		add	ah, ah
		adc	dh, dh
		lodsw
		add	al, al
		adc	bl, bl
		add	ah, ah
		adc	bl, bl
		add	al, al
		adc	bh, bh
		add	ah, ah
		adc	bh, bh
		add	al, al
		adc	dl, dl
		add	ah, ah
		adc	dl, dl
		add	al, al
		adc	dh, dh
		add	ah, ah
		adc	dh, dh
		lodsw
		add	al, al
		adc	bl, bl
		add	ah, ah
		adc	bl, bl
		add	al, al
		adc	bh, bh
		add	ah, ah
		adc	bh, bh
		add	al, al
		adc	dl, dl
		add	ah, ah
		adc	dl, dl
		add	al, al
		adc	dh, dh
		add	ah, ah
		adc	dh, dh
		push	cx
		mov	cl, dh
		or	cl, dl
		or	cl, bh
		or	cl, bl
		not	cl
		push	ds
		mov	ax, seg	dseg
		mov	ds, ax
		mov	es, word_1D170
		mov	es:[di], dh
		mov	es:[di-8000h], dl
		mov	es, word_1D172
		mov	es:[di], bh
		mov	es:[di-8000h], bl
		pop	ds
		inc	di
		pop	cx
		dec	cx
		jz	short loc_134D0
		jmp	loc_1341A
; ---------------------------------------------------------------------------

loc_134D0:				; CODE XREF: DoGFXThing+4FEj
		mov	cx, word_18DE8
		and	cx, 7
		jz	short loc_1352D
		mov	ah, 8
		sub	ah, cl
		xor	bx, bx
		mov	dx, bx

loc_134E1:				; CODE XREF: DoGFXThing+525j
		lodsb
		add	al, al
		adc	bl, bl
		add	al, al
		adc	bh, bh
		add	al, al
		adc	dl, dl
		add	al, al
		adc	dh, dh
		loop	loc_134E1
		mov	cl, ah
		mov	ch, 0FFh
		shl	ch, cl
		not	ch
		shl	bx, cl
		shl	dx, cl
		mov	al, dh
		or	al, dl
		or	al, bh
		or	al, bl
		or	al, ch
		not	al
		or	ch, al
		push	ds
		mov	ax, seg	dseg
		mov	ds, ax
		mov	es, word_1D170
		mov	es:[di], dh
		mov	es:[di-8000h], dl
		mov	es, word_1D172
		mov	es:[di], bh
		mov	es:[di-8000h], bl
		pop	ds

loc_1352D:				; CODE XREF: DoGFXThing+50Aj
		pop	cx
		add	word_18DEE, 50h
		dec	word_18DEA
		jz	short loc_13546
		dec	cx
		jz	short loc_1353F
		jmp	loc_133AB
; ---------------------------------------------------------------------------

loc_1353F:				; CODE XREF: DoGFXThing+56Dj
		pop	es
		popa
		mov	di, word_18DF2
		retn
; ---------------------------------------------------------------------------

loc_13546:				; CODE XREF: DoGFXThing+56Aj
		push	word_18DF0
		call	fclose
		pop	ax
		push	seg dseg
		pop	ds
		mov	sp, word_1D176
		xor	ax, ax
		retn
; ---------------------------------------------------------------------------

loc_13559:				; CODE XREF: DoGFXThing:loc_12FEBj
		pusha
		push	es
		mov	si, word_18DF4
		mov	di, offset byte_18DFA
		mov	cx, word_18DE4
		sub	si, cx
		sub	si, cx
		rep movsw
		mov	si, di
		mov	cx, 4

loc_13571:				; CODE XREF: DoGFXThing+764j
		push	cx
		mov	di, word_18DEE
		mov	ax, word_18DE0
		and	ax, 7
		jz	short loc_135E8
		mov	cx, 8
		sub	cx, ax
		push	cx
		mov	ah, 0FFh
		shl	ah, cl
		xor	bx, bx
		mov	dx, bx

loc_1358C:				; CODE XREF: DoGFXThing+5D0j
		lodsb
		add	al, al
		adc	bl, bl
		add	al, al
		adc	bh, bh
		add	al, al
		adc	dl, dl
		add	al, al
		adc	dh, dh
		loop	loc_1358C
		mov	cl, dh
		or	cl, dl
		or	cl, bh
		or	cl, bl
		or	cl, ah
		not	cl
		or	ah, cl
		push	ds
		push	seg dseg
		pop	ds
		mov	es, word_1D170
		and	es:[di], ah
		or	es:[di], dh
		and	es:[di-8000h], ah
		or	es:[di-8000h], dl
		mov	es, word_1D172
		and	es:[di], ah
		or	es:[di], bh
		and	es:[di-8000h], ah
		or	es:[di-8000h], bl
		pop	ds
		inc	di
		pop	ax
		mov	cx, word_18DE4
		sub	cx, ax
		shr	cx, 3
		jmp	short loc_135EF
; ---------------------------------------------------------------------------

loc_135E8:				; CODE XREF: DoGFXThing+5AFj
		mov	cx, word_18DE4
		shr	cx, 3

loc_135EF:				; CODE XREF: DoGFXThing+619j
					; DoGFXThing+6E5j
		lodsw
		add	al, al
		adc	bl, bl
		add	ah, ah
		adc	bl, bl
		add	al, al
		adc	bh, bh
		add	ah, ah
		adc	bh, bh
		add	al, al
		adc	dl, dl
		add	ah, ah
		adc	dl, dl
		add	al, al
		adc	dh, dh
		add	ah, ah
		adc	dh, dh
		lodsw
		add	al, al
		adc	bl, bl
		add	ah, ah
		adc	bl, bl
		add	al, al
		adc	bh, bh
		add	ah, ah
		adc	bh, bh
		add	al, al
		adc	dl, dl
		add	ah, ah
		adc	dl, dl
		add	al, al
		adc	dh, dh
		add	ah, ah
		adc	dh, dh
		lodsw
		add	al, al
		adc	bl, bl
		add	ah, ah
		adc	bl, bl
		add	al, al
		adc	bh, bh
		add	ah, ah
		adc	bh, bh
		add	al, al
		adc	dl, dl
		add	ah, ah
		adc	dl, dl
		add	al, al
		adc	dh, dh
		add	ah, ah
		adc	dh, dh
		lodsw
		add	al, al
		adc	bl, bl
		add	ah, ah
		adc	bl, bl
		add	al, al
		adc	bh, bh
		add	ah, ah
		adc	bh, bh
		add	al, al
		adc	dl, dl
		add	ah, ah
		adc	dl, dl
		add	al, al
		adc	dh, dh
		add	ah, ah
		adc	dh, dh
		push	cx
		mov	cl, dh
		or	cl, dl
		or	cl, bh
		or	cl, bl
		not	cl
		push	ds
		mov	ax, seg	dseg
		mov	ds, ax
		mov	es, word_1D170
		and	es:[di], cl
		or	es:[di], dh
		and	es:[di-8000h], cl
		or	es:[di-8000h], dl
		mov	es, word_1D172
		and	es:[di], cl
		or	es:[di], bh
		and	es:[di-8000h], cl
		or	es:[di-8000h], bl
		pop	ds
		inc	di
		pop	cx
		dec	cx
		jz	short loc_136B5
		jmp	loc_135EF
; ---------------------------------------------------------------------------

loc_136B5:				; CODE XREF: DoGFXThing+6E3j
		mov	cx, word_18DE8
		and	cx, 7
		jz	short loc_13722
		mov	ah, 8
		sub	ah, cl
		xor	bx, bx
		mov	dx, bx

loc_136C6:				; CODE XREF: DoGFXThing+70Aj
		lodsb
		add	al, al
		adc	bl, bl
		add	al, al
		adc	bh, bh
		add	al, al
		adc	dl, dl
		add	al, al
		adc	dh, dh
		loop	loc_136C6
		mov	cl, ah
		mov	ch, 0FFh
		shl	ch, cl
		not	ch
		shl	bx, cl
		shl	dx, cl
		mov	al, dh
		or	al, dl
		or	al, bh
		or	al, bl
		or	al, ch
		not	al
		or	ch, al
		push	ds
		mov	ax, seg	dseg
		mov	ds, ax
		mov	es, word_1D170
		and	es:[di], ch
		or	es:[di], dh
		and	es:[di-8000h], ch
		or	es:[di-8000h], dl
		mov	es, word_1D172
		and	es:[di], ch
		or	es:[di], bh
		and	es:[di-8000h], ch
		or	es:[di-8000h], bl
		pop	ds

loc_13722:				; CODE XREF: DoGFXThing+6EFj
		pop	cx
		add	word_18DEE, 50h
		dec	word_18DEA
		jz	short loc_1373B
		dec	cx
		jz	short loc_13734
		jmp	loc_13571
; ---------------------------------------------------------------------------

loc_13734:				; CODE XREF: DoGFXThing+762j
		pop	es
		popa
		mov	di, word_18DF2
		retn
; ---------------------------------------------------------------------------

loc_1373B:				; CODE XREF: DoGFXThing+75Fj
		push	word_18DF0
		call	fclose
		pop	ax
		push	seg dseg
		pop	ds
		mov	sp, word_1D176
		xor	ax, ax
		retn
DoGFXThing	endp

; ---------------------------------------------------------------------------
byte_1374E	db 0			; DATA XREF: DoGFXThingr seg000:3F54w
byte_1374F	db 0			; DATA XREF: DoGFXThing+8r
					; DoGFXThing:loc_12FE0r ...
; ---------------------------------------------------------------------------

sUndefined:				; DATA XREF: seg000:scriptFuncListo
		call	RestoreInts
		push	seg seg001
		pop	ds
		assume ds:seg001
		mov	dx, offset aExecUndefined ; "–¢’è‹`‚ÌƒVƒXƒeƒ€—\\–ñ–½—ß‚ðŽÀs‚µ‚Ü‚µ‚½\r"...
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		mov	ax, 4C01h
		int	21h		; DOS -	2+ - QUIT WITH EXIT CODE (EXIT)
					; AL = exit code
; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_11D2F

sExitDOS:				; CODE XREF: sub_11D2F+22j
					; sub_11DB0+40j
					; DATA XREF: ...
		call	RestoreInts
		push	seg seg001
		pop	ds
		mov	dx, offset a03l1l5l ; "\x1B)0\x1B[>3l\x1B[>1l\x1B[>5l\x1B*$"
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		mov	ax, 4C00h
		int	21h		; DOS -	2+ - QUIT WITH EXIT CODE (EXIT)
; END OF FUNCTION CHUNK	FOR sub_11D2F	; AL = exit code
; ---------------------------------------------------------------------------

sExitDOSVar:				; DATA XREF: seg000:scriptFuncListo
		call	GetVariable
		push	ax
		call	RestoreInts
		push	seg seg001
		pop	ds
		mov	dx, offset a03l1l5l ; "\x1B)0\x1B[>3l\x1B[>1l\x1B[>5l\x1B*$"
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		pop	ax
		mov	ah, 4Ch
		int	21h		; DOS -	2+ - QUIT WITH EXIT CODE (EXIT)
					; AL = exit code
; ---------------------------------------------------------------------------
		assume ds:dseg

sLoadScene:				; DATA XREF: seg000:scriptFuncListo
		mov	FileBufSize, 0BC00h
		mov	ax, word ptr SceneData
		mov	word ptr FileLoadDstPtr, ax
		mov	ax, word ptr SceneData+2
		mov	word ptr FileLoadDstPtr+2, ax
		mov	ax, es:[si]
		add	ax, word ptr SceneData
		push	es
		push	ax
		call	LoadFile
		pop	ax
		pop	ax
		jnb	short loc_137B2
		jmp	ExitWithErrMsg
; ---------------------------------------------------------------------------

loc_137B2:				; CODE XREF: seg000:37ADj
		push	ds
		mov	al, 1
		lds	si, SceneData
		add	si, 100h
		push	si
		mov	cx, 0BB00h

loc_137C1:				; CODE XREF: seg000:37C4j
		xor	[si], al
		inc	si
		loop	loc_137C1
		pop	si
		push	ds
		pop	es
		assume es:dseg
		pop	ds
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

sDelay:					; DATA XREF: seg000:scriptFuncListo
		call	GetVariable
		mov	cx, ax
		call	WaitFrames
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

sLoopInit:				; DATA XREF: seg000:scriptFuncListo
		cli
		mov	ax, es:[si]
		inc	si
		inc	si
		mov	scrLoopCounter,	ax
		sti
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

sLoopSetVar:				; DATA XREF: seg000:scriptFuncListo
		cli
		call	GetVariable
		mov	scrLoopCounter,	ax
		sti
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

sLoopGet:				; DATA XREF: seg000:scriptFuncListo
		cli
		call	GetVarPtr
		mov	ax, scrLoopCounter
		mov	[bx], ax
		sti
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

sLoopJumpVal:				; DATA XREF: seg000:scriptFuncListo
		mov	ax, es:[si]
		cmp	ax, scrLoopCounter
		jnb	short loc_1380C
		add	si, 4
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

loc_1380C:				; CODE XREF: seg000:3804j
		mov	si, es:[si+2]
		add	si, word ptr SceneData
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

sLoopJumpVar:				; DATA XREF: seg000:scriptFuncListo
		call	GetVariable
		cmp	ax, scrLoopCounter
		jnb	short loc_13825
		inc	si
		inc	si
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

loc_13825:				; CODE XREF: seg000:381Ej
		mov	si, es:[si]
		add	si, word ptr SceneData
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

loc_1382F:				; DATA XREF: seg000:scriptFuncListo
		call	GetVariable
		mov	word_1D17C, ax
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

sStr_SetDate:				; DATA XREF: seg000:scriptFuncListo
		call	GetStringPtr
		mov	byte ptr [bx], 0 ; The function	sets the string	to the date/time string:
		mov	ah, 2Ch		; "YYYY-MM-DD HH:MM:SS"
		int	21h		; DOS -	GET CURRENT TIME
					; Return: CH = hours, CL = minutes, DH = seconds
					; DL = hundredths of seconds
		mov	al, dh
		call	PrintInt_2Digs	; print	seconds
		mov	ax, 8559h	; ':'
		call	str_Prepend2B
		mov	al, cl
		call	PrintInt_2Digs	; print	minutes
		mov	ax, 8559h	; ':'
		call	str_Prepend2B
		mov	al, ch
		call	PrintInt_2Digs	; print	hours
		mov	al, ' '
		call	str_Prepend1B
		mov	ah, 2Ah
		int	21h		; DOS -	GET CURRENT DATE
					; Return: DL = day, DH = month,	CX = year
					; AL = day of the week (0=Sunday, 1=Monday, etc.)
		mov	al, dl
		call	PrintInt_2Digs	; print	day
		mov	ax, 854Ch	; '-'
		call	str_Prepend2B
		mov	al, dh
		call	PrintInt_2Digs	; print	month
		mov	ax, 854Ch	; '-'
		call	str_Prepend2B
		mov	ax, cx
		mov	cl, 100
		div	cl
		xchg	al, ah
		call	PrintInt_2Digs	; print	year (last two digits)
		xchg	al, ah
		call	PrintInt_2Digs	; print	year (first two	digits)
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

sGetFileDate:				; DATA XREF: seg000:scriptFuncListo
		call	sub_119E2
		xor	ax, ax
		call	GetVarPtr
		mov	[bx], ax	; initialize variable with 0 (operation	fail)
		mov	dx, bx		; DX = variable	pointer
		call	GetStringPtr
		mov	[bx], al	; make string empty (write 00)
		mov	cx, bx		; CX = string pointer
		mov	bx, es:[si]
		add	bx, word ptr SceneData
		inc	si
		inc	si
		push	si
		push	es
		push	dx
		push	cx
		mov	al, DiskLetter
		mov	ah, ':'
		mov	FileDiskDrive, ax
		cmp	byte_1D113, 0
		jnz	short loc_138C9
		mov	al, es:[bx]
		cmp	al, 2
		cmc			; invert carry flag
		adc	byte ptr FileDiskDrive,	0

loc_138C9:				; CODE XREF: seg000:38BCj
		call	strdup_fn
		push	0
		push	ds
		push	offset FileDiskDrive
		call	OpenFile2
		pop	dx
		pop	dx
		pop	dx
		test	ax, ax
		jnz	short loc_138DF
		jmp	loc_13962
; ---------------------------------------------------------------------------

loc_138DF:				; CODE XREF: seg000:38DAj
		push	ax
		call	GetHFile_LIB
		mov	bx, ax
		xor	al, al
		mov	ah, 57h
		int	21h		; DOS -	2+ - GET FILE'S DATE/TIME
					; BX = file handle
		call	fclose
		pop	ax
		pop	bx
		mov	al, cl
		and	al, 1Fh
		add	al, al
		call	PrintInt_2Digs	; print	seconds
		mov	ax, 8559h	; ':'
		call	str_Prepend2B
		shr	cx, 5
		mov	al, cl
		and	al, 3Fh
		call	PrintInt_2Digs	; print	minutes
		mov	ax, 8559h	; ':'
		call	str_Prepend2B
		shr	cx, 6
		mov	al, cl
		and	al, 1Fh
		call	PrintInt_2Digs	; print	hours
		mov	al, ' '
		call	str_Prepend1B
		mov	al, dl
		and	al, 1Fh
		call	PrintInt_2Digs
		mov	ax, 854Ch	; '-'
		call	str_Prepend2B	; print	day
		shr	dx, 5
		mov	al, dl
		and	al, 0Fh
		call	PrintInt_2Digs
		mov	ax, 854Ch	; '-'
		call	str_Prepend2B	; print	month
		shr	dx, 4
		and	dl, 7Fh
		add	dx, 1980
		mov	ax, dx
		mov	cl, 100
		div	cl
		xchg	al, ah
		call	PrintInt_2Digs	; print	year (last two digits)
		xchg	al, ah
		call	PrintInt_2Digs	; print	year (first two	digits)
		pop	bx
		mov	word ptr [bx], 1 ; indicate success
		pop	es
		assume es:nothing
		pop	si
		call	sub_11A19
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

loc_13962:				; CODE XREF: seg000:38DCj
		pop	bx
		pop	bx
		pop	es
		pop	si
		call	sub_11A19
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

sLoadVar_Val:				; DATA XREF: seg000:scriptFuncListo
		cmp	word ptr es:[si], 400h
		jnb	short loc_13980
		call	GetVarPtr
		mov	ax, es:[si]
		inc	si
		inc	si
		mov	[bx], ax	; set variable to parameter value (2 bytes)
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

loc_13980:				; CODE XREF: seg000:3971j
		call	GetLVarPtr
		mov	ax, es:[si]	; set variable to parameter value (4 bytes)
		mov	[bx], ax
		mov	ax, es:[si+2]
		mov	[bx+2],	ax
		add	si, 4
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

sLoadVar_Var:				; DATA XREF: seg000:scriptFuncListo
		cmp	word ptr es:[si], 400h
		jnb	short loc_139A7
		call	GetVarPtr	; get destination variable pointer
		call	GetVariable	; get source variable contents
		mov	[bx], ax	; transfer source -> destination (2 bytes)
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

loc_139A7:				; CODE XREF: seg000:399Aj
		call	GetLVarPtr	; get destination variable pointer
		call	GetLVariable	; get source variable contents
		mov	[bx], ax	; transfer source -> destination (4 bytes)
		mov	[bx+2],	dx
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

sClearVars:				; DATA XREF: seg000:scriptFuncListo
		call	GetVarPtr	; get start offset
		mov	cx, bx
		call	GetVarPtr	; get end offset
		xchg	cx, bx		; BX = address of first	variable
		sub	cx, bx
		shr	cx, 1		; CX = number of 2-byte	variables
		inc	cx		; make the last	variable inclusive
		push	es
		push	ds
		pop	es
		assume es:dseg
		mov	di, bx
		xor	ax, ax
		rep stosw		; write	0 to all variables
		pop	es
		assume es:nothing
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

sGetVarXY:				; DATA XREF: seg000:scriptFuncListo
		call	GetVarPtr
		push	bx
		call	GetVariable	; get X	(reg BX)
		mov	bx, ax
		call	GetVariable	; get Y	(reg AX)
		add	ax, ax
		add	ax, ax
		add	bx, ax
		add	ax, ax
		add	ax, ax
		add	bx, ax
		add	bx, bx		; BX = (Y*14h +	X) * 2
		add	bx, offset ScrBufferXY
		mov	ax, [bx]
		pop	bx
		mov	[bx], ax	; variable = buffer[Y*20 + X]
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

sSetVarXY:				; DATA XREF: seg000:scriptFuncListo
		call	GetVariable	; get variable value
		push	ax
		call	GetVariable	; get X	(reg BX)
		mov	bx, ax
		call	GetVariable	; get Y	(reg AX)
		add	ax, ax
		add	ax, ax
		add	bx, ax
		add	ax, ax
		add	ax, ax
		add	bx, ax
		add	bx, bx		; BX = (Y*14h +	X) * 2
		add	bx, offset ScrBufferXY
		pop	ax
		mov	[bx], ax	; buffer[Y*20 +	X] = value
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

sSaveVarBuf:				; DATA XREF: seg000:scriptFuncListo
		mov	word ptr FileLoadDstPtr+2, ds
		mov	word ptr FileLoadDstPtr, offset	ScrVariables1
		mov	FileBufSize, 3E8h
		cmp	byte ptr es:[si], 0
		jz	short loc_13A3D
		mov	word ptr FileLoadDstPtr, offset	ScrVariables2
		mov	FileBufSize, 418h

loc_13A3D:				; CODE XREF: seg000:3A2Fj
		mov	ax, es:[si+2]
		add	ax, word ptr SceneData
		add	si, 4
		push	es
		push	ax
		call	WriteFile
		pop	ax
		pop	ax
		jnb	short loc_13A54
		jmp	ExitWithErrMsg
; ---------------------------------------------------------------------------

loc_13A54:				; CODE XREF: seg000:3A4Fj
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

sLoadVarBuf:				; DATA XREF: seg000:scriptFuncListo
		mov	word ptr FileLoadDstPtr+2, ds
		mov	word ptr FileLoadDstPtr, offset	ScrVariables1
		mov	FileBufSize, 3E8h
		cmp	byte ptr es:[si], 0
		jz	short loc_13A79
		mov	word ptr FileLoadDstPtr, offset	ScrVariables2
		mov	FileBufSize, 418h

loc_13A79:				; CODE XREF: seg000:3A6Bj
		mov	ax, es:[si+2]
		add	ax, word ptr SceneData
		add	si, 4
		push	es
		push	ax
		call	LoadFile
		pop	ax
		pop	ax
		jnb	short loc_13A90
		jmp	ExitWithErrMsg
; ---------------------------------------------------------------------------

loc_13A90:				; CODE XREF: seg000:3A8Bj
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

sSaveXYBuf:				; DATA XREF: seg000:scriptFuncListo
		mov	word ptr FileLoadDstPtr+2, ds
		mov	word ptr FileLoadDstPtr, offset	ScrBufferXY
		mov	FileBufSize, 800
		mov	ax, es:[si]
		inc	si
		inc	si
		add	ax, word ptr SceneData
		push	es
		push	ax
		call	WriteFile
		pop	ax
		pop	ax
		jnb	short loc_13AB8
		jmp	ExitWithErrMsg
; ---------------------------------------------------------------------------

loc_13AB8:				; CODE XREF: seg000:3AB3j
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

sLoadXYBuf:				; DATA XREF: seg000:scriptFuncListo
		mov	word ptr FileLoadDstPtr+2, ds
		mov	word ptr FileLoadDstPtr, offset	ScrBufferXY
		mov	FileBufSize, 800
		mov	ax, es:[si]
		inc	si
		inc	si
		add	ax, word ptr SceneData
		push	es
		push	ax
		call	LoadFile
		pop	ax
		pop	ax
		jnb	short loc_13AE0
		jmp	ExitWithErrMsg
; ---------------------------------------------------------------------------

loc_13AE0:				; CODE XREF: seg000:3ADBj
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

sAddVar_Cast:				; DATA XREF: seg000:scriptFuncListo
		cmp	word ptr es:[si], 400h
		jnb	short loc_13AF5
		call	GetVarPtr
		call	GetVariable
		add	[bx], ax	; destination is 2 bytes: just add source in 2-byte mode
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

loc_13AF5:				; CODE XREF: seg000:3AE8j
		call	GetLVarPtr	; destination is 4 bytes
		cmp	word ptr es:[si], 400h
		jnb	short loc_13B06
		call	GetVariable
		xor	dx, dx		; 2-byte source: sign-extend in	"unsigned" mode
		jmp	short loc_13B09
; ---------------------------------------------------------------------------

loc_13B06:				; CODE XREF: seg000:3AFDj
		call	GetLVariable	; 4-byte source: read 4-byte variable

loc_13B09:				; CODE XREF: seg000:3B04j
		add	[bx], ax
		adc	[bx+2],	dx
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

sAddVar_Val:				; DATA XREF: seg000:scriptFuncListo
		cmp	word ptr es:[si], 400h
		jnb	short loc_13B25
		call	GetVarPtr
		mov	ax, es:[si]
		inc	si
		inc	si
		add	[bx], ax	; add value to variable
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

loc_13B25:				; CODE XREF: seg000:3B16j
		call	GetLVarPtr
		mov	dx, es:[si]
		mov	ax, es:[si+2]
		add	si, 4
		add	[bx], dx	; add value to variable
		adc	[bx+2],	ax
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

sSubVar_Cast:				; DATA XREF: seg000:scriptFuncListo
		cmp	word ptr es:[si], 400h
		jnb	short loc_13B59
		call	GetVarPtr
		call	GetVariable
		sub	[bx], ax	; destination is 2 bytes: just subtract	source in 2-byte mode
		jb	short loc_13B4E	; handle underflow
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

loc_13B4E:				; CODE XREF: seg000:3B49j
		mov	ScrVariables1, 1 ; set "negative result" flag
		neg	word ptr [bx]	; make positive	again
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

loc_13B59:				; CODE XREF: seg000:3B3Fj
		call	GetLVarPtr	; destination is 4 bytes
		cmp	word ptr es:[si], 400h
		jnb	short loc_13B6A
		call	GetVariable
		xor	dx, dx		; 2-byte source: sign-extend in	"unsigned" mode
		jmp	short loc_13B6D
; ---------------------------------------------------------------------------

loc_13B6A:				; CODE XREF: seg000:3B61j
		call	GetLVariable	; 4-byte source: read 4-byte variable

loc_13B6D:				; CODE XREF: seg000:3B68j
		sub	[bx], ax
		sbb	[bx+2],	dx
		jb	short loc_13B77	; handle underflow
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

loc_13B77:				; CODE XREF: seg000:3B72j
		mov	ScrVariables1, 1 ; set "negative result" flag
		neg	word ptr [bx]
		neg	word ptr [bx+2]	; [bug]	the high word will be off by 1
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

sSubVar_Val:				; DATA XREF: seg000:scriptFuncListo
		cmp	word ptr es:[si], 400h
		jnb	short loc_13BA6
		call	GetVarPtr
		mov	ax, es:[si]
		inc	si
		inc	si
		sub	[bx], ax	; subtract value from variable
		jb	short loc_13B9B
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

loc_13B9B:				; CODE XREF: seg000:3B96j
		mov	ScrVariables1, 1
		neg	word ptr [bx]
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

loc_13BA6:				; CODE XREF: seg000:3B8Aj
		call	GetLVarPtr
		mov	dx, es:[si]
		mov	ax, es:[si+2]
		add	si, 4
		sub	[bx], dx	; subtract value from variable
		sbb	[bx+2],	ax
		jb	short loc_13BBD
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

loc_13BBD:				; CODE XREF: seg000:3BB8j
		mov	ScrVariables1, 1
		neg	word ptr [bx]
		neg	word ptr [bx+2]	; [bug]	the high word will be off by 1
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

sMulVar_Var:				; DATA XREF: seg000:scriptFuncListo
		cmp	word ptr es:[si], 400h
		jnb	short loc_13BE5
		call	GetVarPtr
		call	GetVariable
		mov	cx, ax
		xor	dx, dx
		mov	ax, [bx]
		mul	cx
		mov	[bx], ax
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

loc_13BE5:				; CODE XREF: seg000:3BD0j
		call	GetLVarPtr
		mov	di, bx
		xor	bx, bx
		mov	cx, bx
		xchg	bx, [di]
		xchg	cx, [di+2]
		call	GetLVariable

loc_13BF6:				; CODE XREF: seg000:3C0Aj
		push	ax
		or	ax, dx
		pop	ax
		jnz	short loc_13BFF
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

loc_13BFF:				; CODE XREF: seg000:3BFAj
		add	[di], bx
		adc	[di+2],	cx
		sub	ax, 1
		sbb	dx, 0
		jmp	short loc_13BF6
; ---------------------------------------------------------------------------

sDivVar_Var:				; DATA XREF: seg000:scriptFuncListo
		cmp	word ptr es:[si], 400h
		jnb	short loc_13C31
		call	GetVarPtr
		mov	di, bx
		mov	ax, [di]
		xor	dx, dx
		call	GetVarPtr
		mov	cx, [bx]
		or	cx, cx
		jnz	short loc_13C28
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

loc_13C28:				; CODE XREF: seg000:3C23j
		div	cx
		mov	[di], ax
		mov	[bx], dx
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

loc_13C31:				; CODE XREF: seg000:3C11j
		call	GetLVarPtr
		mov	di, bx
		call	GetLVarPtr
		mov	ax, [bx]
		mov	dx, [bx+2]
		push	ax
		or	ax, dx
		pop	ax
		jnz	short loc_13C47
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

loc_13C47:				; CODE XREF: seg000:3C42j
		push	bx
		xor	bx, bx
		mov	cx, bx
		xchg	bx, [di]
		xchg	cx, [di+2]

loc_13C51:				; CODE XREF: seg000:3C5Ej
		sub	bx, ax
		sbb	cx, dx
		jb	short loc_13C60
		add	word ptr [di], 1
		adc	word ptr [di+2], 0
		jmp	short loc_13C51
; ---------------------------------------------------------------------------

loc_13C60:				; CODE XREF: seg000:3C55j
		add	ax, bx
		adc	dx, cx
		pop	bx
		mov	[bx], ax
		mov	[bx+2],	dx
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

sAndVar_Var:				; DATA XREF: seg000:scriptFuncListo
		call	GetVarPtr
		call	GetVariable
		and	[bx], ax
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

sAndVar_Val:				; DATA XREF: seg000:scriptFuncListo
		call	GetVarPtr
		mov	ax, es:[si]
		inc	si
		inc	si
		and	[bx], ax
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

sOrVar_Var:				; DATA XREF: seg000:scriptFuncListo
		call	GetVarPtr
		call	GetVariable
		or	[bx], ax
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

sOrVar_Val:				; DATA XREF: seg000:scriptFuncListo
		call	GetVarPtr
		mov	ax, es:[si]
		inc	si
		inc	si
		or	[bx], ax
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

sCompareVars:				; DATA XREF: seg000:scriptFuncListo
		mov	scrCmpResult, 0	; reset	comparision result first
		call	GetVariable	; get variable var1
		mov	dx, ax
		call	GetVariable	; get variable var2
		cmp	dx, ax
		jnz	short loc_13CB1	; var1 == var2 -> keep 0
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

loc_13CB1:				; CODE XREF: seg000:3CACj
		jb	short loc_13CB7
		inc	scrCmpResult	; var1 > var2 -> set to	2

loc_13CB7:				; CODE XREF: seg000:loc_13CB1j
		inc	scrCmpResult	; var1 < var2 -> set to	1
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

sCompareValVal:				; DATA XREF: seg000:scriptFuncListo
		mov	scrCmpResult, 0	; reset	comparision result first
		call	GetVariable	; get variable var
		mov	dx, es:[si]
		inc	si
		inc	si
		cmp	ax, dx
		jnz	short loc_13CD2	; var == value -> keep 0
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

loc_13CD2:				; CODE XREF: seg000:3CCDj
		jb	short loc_13CD8
		inc	scrCmpResult	; var >	value -> set to	2

loc_13CD8:				; CODE XREF: seg000:loc_13CD2j
		inc	scrCmpResult	; var <	value -> set to	1
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

sJumpAbs:				; DATA XREF: seg000:scriptFuncListo
		mov	si, es:[si]
		add	si, word ptr SceneData
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

sCondJmp_EQ:				; DATA XREF: seg000:scriptFuncListo
		mov	ax, es:[si]
		inc	si
		inc	si
		cmp	scrCmpResult, 0	; test for equal
		jz	short loc_13CF8
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

loc_13CF8:				; CODE XREF: seg000:3CF3j
		add	ax, word ptr SceneData
		mov	si, ax
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

sCondJmp_LT:				; DATA XREF: seg000:scriptFuncListo
		mov	ax, es:[si]
		inc	si
		inc	si
		cmp	scrCmpResult, 1	; test for less-than
		jz	short loc_13D10
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

loc_13D10:				; CODE XREF: seg000:3D0Bj
		add	ax, word ptr SceneData
		mov	si, ax
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

sCondJmp_GT:				; DATA XREF: seg000:scriptFuncListo
		mov	ax, es:[si]
		inc	si
		inc	si
		cmp	scrCmpResult, 2	; test for greater-than
		jz	short loc_13D28
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

loc_13D28:				; CODE XREF: seg000:3D23j
		add	ax, word ptr SceneData
		mov	si, ax
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

sCondJmp_GE:				; DATA XREF: seg000:scriptFuncListo
		mov	ax, es:[si]
		inc	si
		inc	si
		cmp	scrCmpResult, 1	; test for greater-or-equal
		jnz	short loc_13D40
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

loc_13D40:				; CODE XREF: seg000:3D3Bj
		add	ax, word ptr SceneData
		mov	si, ax
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

sCondJmp_LE:				; DATA XREF: seg000:scriptFuncListo
		mov	ax, es:[si]
		inc	si
		inc	si
		cmp	scrCmpResult, 2	; test for less-or-equal
		jnz	short loc_13D58
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

loc_13D58:				; CODE XREF: seg000:3D53j
		add	ax, word ptr SceneData
		mov	si, ax
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

sCondJmp_NE:				; DATA XREF: seg000:scriptFuncListo
		mov	ax, es:[si]
		inc	si
		inc	si
		cmp	scrCmpResult, 0	; test for not-equal
		jnz	short loc_13D70
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

loc_13D70:				; CODE XREF: seg000:3D6Bj
		add	ax, word ptr SceneData
		mov	si, ax
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

sTblJump:				; DATA XREF: seg000:scriptFuncListo
		call	GetVariable
		add	ax, ax		; AX = value of	variable
		mov	bx, ax		; turn into pointer offset
		mov	si, es:[bx+si]	; read from offset right after the command
		add	si, word ptr SceneData
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

sCall:					; DATA XREF: seg000:scriptFuncListo
		mov	ax, es:[si]
		inc	si
		inc	si
		mov	bx, scrStackPtr
		mov	[bx], si
		inc	bx
		inc	bx
		mov	scrStackPtr, bx
		add	ax, word ptr SceneData
		mov	si, ax
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

sReturn:				; DATA XREF: seg000:scriptFuncListo
		mov	bx, scrStackPtr
		dec	bx
		dec	bx
		mov	si, [bx]
		mov	scrStackPtr, bx
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

loc_13DB3:				; DATA XREF: seg000:scriptFuncListo
		mov	al, 1
		out	0A6h, al
		push	si
		push	ds
		push	es
		push	ds
		pop	es
		assume es:dseg
		mov	di, 17Ch
		xor	si, si
		call	sub_13E0D
		mov	di, 5FCh
		mov	si, 6
		call	sub_13E0D
		mov	di, 0A7Ch
		mov	si, 0Ch
		call	sub_13E0D
		mov	di, 0EFCh
		mov	si, 12h
		call	sub_13E0D
		mov	di, 137Ch
		mov	si, 18h
		call	sub_13E0D
		mov	di, 17FCh
		mov	si, 1Eh
		call	sub_13E0D
		mov	di, 1C7Ch
		mov	si, 24h
		call	sub_13E0D
		mov	di, 20FCh
		mov	si, 2Ah
		call	sub_13E0D
		pop	es
		assume es:nothing
		pop	ds
		pop	si
		xor	al, al
		out	0A6h, al
		jmp	ScriptMainLop

; =============== S U B	R O U T	I N E =======================================


sub_13E0D	proc near		; CODE XREF: seg000:3DC1p seg000:3DCAp ...
		mov	dl, 3

loc_13E0F:				; CODE XREF: sub_13E0D+46j
		mov	dh, 3

loc_13E11:				; CODE XREF: sub_13E0D+42j
		mov	ax, 3
		sub	al, dh
		add	ax, ax
		mov	bx, 3
		sub	bl, dl
		shl	bx, 4
		shl	bx, 4
		add	ax, bx
		add	bx, bx
		add	bx, bx
		add	bx, ax
		xchg	bx, si
		add	si, bx
		push	0A800h		; GVRAM	Plane 0
		pop	ds
		assume ds:nothing
		call	SomeGDCCopy6
		push	0B000h		; GVRAM	Plane 1
		pop	ds
		assume ds:nothing
		call	SomeGDCCopy6
		push	0B800h		; GVRAM	Plane 2
		pop	ds
		assume ds:nothing
		call	SomeGDCCopy6
		push	0E000h		; GVRAM	Plane 3
		pop	ds
		assume ds:nothing
		call	SomeGDCCopy6
		mov	si, bx
		dec	dh
		jnz	short loc_13E11
		dec	dl
		jnz	short loc_13E0F
		retn
sub_13E0D	endp

		assume ds:dseg

; =============== S U B	R O U T	I N E =======================================


SomeGDCCopy6	proc near		; CODE XREF: sub_13E0D+26p
					; sub_13E0D+2Dp ...
		push	si
		mov	cx, 8

loc_13E5A:				; CODE XREF: SomeGDCCopy6+Cj
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		loop	loc_13E5A
		pop	si
		retn
SomeGDCCopy6	endp

; ---------------------------------------------------------------------------

loc_13E66:				; DATA XREF: seg000:scriptFuncListo
		call	GetScrBufLine
		cmp	byte ptr [bx+1], 0
		jnz	short loc_13ECC
		push	es
		mov	ax, ds
		mov	es, ax
		assume es:dseg
		mov	di, bx
		inc	di
		inc	di
		mov	cx, 0Bh
		xor	ax, ax
		rep stosw
		pop	es
		assume es:nothing
		mov	ax, es:[si]
		mov	[bx+4],	ax
		inc	ax
		add	ax, ax
		mov	[bx+0Ch], ax
		mov	ax, es:[si+2]
		mov	[bx+2],	ax
		inc	ax
		mov	[bx+0Ah], ax
		mov	ax, es:[si+4]
		mov	[bx+8],	ax
		mov	ax, es:[si+6]
		mov	[bx+6],	ax
		mov	ax, es:[si+8]
		mov	[bx+0Eh], ax
		mov	byte ptr [bx+1], 1
		call	sub_126B8
		call	sub_11C6D
		cmp	word ptr [bx+0Eh], 0
		jz	short loc_13ECC
		cmp	byte ptr [bx], 8
		jb	short loc_13EC9
		call	sub_11EC4
		call	sub_11C6D
		jmp	short loc_13ECC
; ---------------------------------------------------------------------------

loc_13EC9:				; CODE XREF: seg000:3EBFj
		call	sub_11DF4

loc_13ECC:				; CODE XREF: seg000:3E6Dj seg000:3EBAj ...
		add	si, 0Ah
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

loc_13ED2:				; DATA XREF: seg000:scriptFuncListo
		call	GetScrBufLine
		cmp	byte ptr [bx+1], 0
		jnz	short loc_13EDE
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

loc_13EDE:				; CODE XREF: seg000:3ED9j
		cmp	byte ptr [bx], 8
		jb	short loc_13EE6
		call	sub_11CC1

loc_13EE6:				; CODE XREF: seg000:3EE1j
		call	sub_11CC1
		mov	byte ptr [bx+1], 0
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

loc_13EF0:				; DATA XREF: seg000:scriptFuncListo
		call	GetScrBufLine
		cmp	byte ptr [bx+1], 0
		jnz	short loc_13EFC
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

loc_13EFC:				; CODE XREF: seg000:3EF7j
		call	sub_126A7
		call	sub_126B8
		cmp	word ptr [bx+0Eh], 0
		jnz	short loc_13F0E
		call	sub_11CCA
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

loc_13F0E:				; CODE XREF: seg000:3F06j
		cmp	byte ptr [bx], 8
		jb	short loc_13F19
		call	sub_11CCA
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

loc_13F19:				; CODE XREF: seg000:3F11j
		call	sub_11DF4
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

sWritePortA4:				; DATA XREF: seg000:scriptFuncListo
		call	GetVariable
		and	al, 1
		out	0A4h, al	; Interrupt Controller #2, 8259A
		mov	portA4State, al
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

sReadPortA4:				; DATA XREF: seg000:scriptFuncListo
		call	GetVarPtr
		mov	al, portA4State
		cbw
		mov	[bx], ax
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

loc_13F38:				; DATA XREF: seg000:scriptFuncListo
		mov	ax, es:[si]
		mov	word_1D0F8, ax
		mov	word_1D10A, ax
		mov	ax, es:[si+2]
		mov	word_1D0FA, ax
		mov	word_1D10C, ax
		mov	al, es:[si+4]
		push	ax
		mov	al, es:[si+6]
		mov	cs:byte_1374E, al
		cmp	al, 2
		jnb	short loc_13F5E
		out	0A6h, al	; Interrupt Controller #2, 8259A

loc_13F5E:				; CODE XREF: seg000:3F5Aj
		mov	ax, seg_1D16E
		mov	word ptr FileLoadDstPtr+2, ax
		xor	ax, ax
		mov	word ptr FileLoadDstPtr, ax
		mov	FileBufSize, ax
		mov	bx, es:[si+8]
		add	bx, word ptr SceneData
		mov	al, es:[si+0Ah]
		mov	cs:byte_1374F, al
		add	si, 0Ch
		push	es
		push	bx
		call	LoadFile
		pop	ax
		pop	ax
		jb	short loc_13FA0
		call	LoadPIImage1
		call	DoPalThing
		pop	ax
		test	al, al
		jz	short loc_13F99
		call	WaitForVSync
		call	UploadPalette

loc_13F99:				; CODE XREF: seg000:3F91j
		xor	al, al
		out	0A6h, al	; Interrupt Controller #2, 8259A
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

loc_13FA0:				; CODE XREF: seg000:3F86j
		pop	ax
		jmp	ExitWithErrMsg
; ---------------------------------------------------------------------------

loc_13FA4:				; DATA XREF: seg000:scriptFuncListo
		call	sub_11FBD
		call	sub_1202D
		mov	byte_1D102, 0
		call	scrGFXThing1
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

loc_13FB5:				; DATA XREF: seg000:scriptFuncListo
		call	sub_11FE3
		call	sub_12045
		mov	byte_1D102, 0
		call	scrGFXThing1
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

loc_13FC6:				; DATA XREF: seg000:scriptFuncListo
		call	GetVariable
		mov	byte_1D0F6, al
		call	GetVariable
		mov	word_1D0F8, ax
		call	GetVariable
		mov	word_1D0FA, ax
		call	GetVariable
		add	ax, ax
		add	ax, ax
		mov	word_1D0FE, ax
		call	GetVariable
		mov	word_1D100, ax
		call	sub_12045
		mov	byte_1D102, 0
		call	scrGFXThing1
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

loc_13FF6:				; DATA XREF: seg000:scriptFuncListo
		call	sub_11FBD
		call	sub_1202D
		call	scrGFXThing2
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

loc_14002:				; DATA XREF: seg000:scriptFuncListo
		call	sub_11FE3
		call	sub_12045
		call	scrGFXThing2
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

loc_1400E:				; DATA XREF: seg000:scriptFuncListo
		call	GetVariable
		mov	bx, ax
		call	GetVariable
		mov	cx, 400
		sub	cx, ax
		mov	dx, ax
		shl	ax, 3
		add	bx, ax
		shl	ax, 2
		add	bx, ax
		add	bx, 4000h
		in	al, 31h
		not	al
		and	al, 80h
		shr	al, 1
		shl	cx, 4
		shl	dx, 4
		or	ch, al
		or	dh, al
		mov	al, 70h
		call	WriteIO_A2
		mov	al, bl
		call	WriteIO_A0
		mov	al, bh
		call	WriteIO_A0
		mov	al, cl
		call	WriteIO_A0
		mov	al, ch
		call	WriteIO_A0
		xor	al, al
		call	WriteIO_A0
		mov	al, 40h
		call	WriteIO_A0
		mov	al, dl
		call	WriteIO_A0
		mov	al, dh
		call	WriteIO_A0
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

loc_1406D:				; DATA XREF: seg000:scriptFuncListo
		call	GetVariable
		mov	cx, ax
		call	GetVariable
		xchg	ax, cx
		push	si
		push	ds
		push	es
		shl	ax, 4
		mov	si, ax
		add	ax, ax
		add	ax, ax
		add	si, ax
		shl	cx, 3
		mov	ax, cx
		add	cx, cx
		add	cx, cx
		add	cx, ax
		mov	ax, 0A800h	; GVRAM	Plane 0
		call	sub_140B1
		mov	ax, 0B000h	; GVRAM	Plane 1
		call	sub_140B1
		mov	ax, 0B800h	; GVRAM	Plane 2
		call	sub_140B1
		mov	ax, 0E000h	; GVRAM	Plane 3
		call	sub_140B1
		pop	es
		pop	ds
		pop	si
		xor	al, al
		out	0A6h, al	; Interrupt Controller #2, 8259A
		jmp	ScriptMainLop

; =============== S U B	R O U T	I N E =======================================


sub_140B1	proc near		; CODE XREF: seg000:4092p seg000:4098p ...
		push	ds
		push	ax
		mov	dx, cx
		mov	bx, si
		mov	es, seg_1D16E
		xor	di, di
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		pop	ds
		rep movsw
		dec	al
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	cx, dx
		mov	si, bx
		xor	di, di

loc_140CE:				; CODE XREF: sub_140B1+25j
		mov	ax, es:[di]
		xchg	ax, [si]
		inc	si
		inc	si
		stosw
		loop	loc_140CE
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		push	ds
		push	es
		pop	ds
		pop	es
		mov	di, bx
		xor	si, si
		mov	cx, dx
		rep movsw
		mov	si, bx
		mov	cx, dx
		pop	ds
		retn
sub_140B1	endp

; ---------------------------------------------------------------------------

loc_140EE:				; DATA XREF: seg000:scriptFuncListo
		cli
		in	al, 0Ah		; DMA controller, 8237A-5.
					; single mask bit register
					; 0-1: select channel (00=0; 01=1; 10=2; 11=3)
					; 2: 1=set mask	for channel; 0=clear mask (enable)
		push	ax
		or	al, 20h
		out	0Ah, al		; DMA controller, 8237A-5.
					; single mask bit register
					; 0-1: select channel (00=0; 01=1; 10=2; 11=3)
					; 2: 1=set mask	for channel; 0=clear mask (enable)
		sti
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	dl, es:[si]
		mov	dh, es:[si+2]
		mov	cl, es:[si+4]
		mov	ch, es:[si+6]
		add	si, 8
		push	si
		push	es
		mov	ah, dh

loc_14111:				; CODE XREF: seg000:4139j
		mov	al, dl

loc_14113:				; CODE XREF: seg000:4133j
		push	0A800h		; GVRAM	Plane 0
		pop	es
		assume es:nothing
		call	SomeGDCThing
		push	0B000h		; GVRAM	Plane 1
		pop	es
		assume es:nothing
		call	SomeGDCThing
		push	0B800h		; GVRAM	Plane 2
		pop	es
		assume es:nothing
		call	SomeGDCThing
		push	0E000h		; GVRAM	Plane 3
		pop	es
		assume es:nothing
		call	SomeGDCThing
		inc	al
		cmp	cl, al
		jnb	short loc_14113
		inc	ah
		cmp	ch, ah
		jnb	short loc_14111
		pop	es
		assume es:nothing
		pop	si
		xor	al, al
		out	0A6h, al	; Interrupt Controller #2, 8259A
		cli
		pop	ax
		out	0Ah, al		; DMA controller, 8237A-5.
					; single mask bit register
					; 0-1: select channel (00=0; 01=1; 10=2; 11=3)
					; 2: 1=set mask	for channel; 0=clear mask (enable)
		sti
		jmp	ScriptMainLop

; =============== S U B	R O U T	I N E =======================================


SomeGDCThing	proc near		; CODE XREF: seg000:4117p seg000:411Ep ...
		push	ax
		push	cx
		push	dx
		mov	dh, ah
		xor	dl, dl
		shr	dx, 2
		shr	al, 1
		pushf
		add	ax, dx
		mov	di, ax
		mov	al, es:[di]
		popf
		jb	short loc_1416A
		add	al, al
		mov	al, 0F0h
		jb	short loc_14185
		not	al
		jmp	short loc_14172
; ---------------------------------------------------------------------------

loc_1416A:				; CODE XREF: SomeGDCThing+15j
		and	al, 8
		mov	al, 0Fh
		jnz	short loc_14185
		not	al

loc_14172:				; CODE XREF: SomeGDCThing+1Fj
		and	es:[di], al
		and	es:[di+50h], al
		and	es:[di+0A0h], al
		and	es:[di+0F0h], al
		jmp	short loc_14196
; ---------------------------------------------------------------------------

loc_14185:				; CODE XREF: SomeGDCThing+1Bj
					; SomeGDCThing+25j
		or	es:[di], al
		or	es:[di+50h], al
		or	es:[di+0A0h], al
		or	es:[di+0F0h], al

loc_14196:				; CODE XREF: SomeGDCThing+3Aj
		pop	dx
		pop	cx
		pop	ax
		retn
SomeGDCThing	endp

; ---------------------------------------------------------------------------

loc_1419A:				; DATA XREF: seg000:scriptFuncListo
		call	GetVariable
		push	ax
		and	ax, 7
		xchg	ax, bx
		mov	ch, bitMaskLUT[bx] ; store bit mask
		pop	bx
		shr	bx, 3
		call	GetVariable
		shl	ax, 4
		add	bx, ax
		add	ax, ax
		add	ax, ax
		add	bx, ax		; BX = (var1>>3) + (var2<<4) * 5
		push	es
		push	word_1D172
		pop	es
		xor	ax, ax
		call	sub_141D8
		push	word_1D170
		pop	es
		add	ax, ax
		add	ax, ax
		call	sub_141D8
		pop	es
		call	GetVarPtr
		mov	[bx], ax	; set script parameter
		jmp	ScriptMainLop

; =============== S U B	R O U T	I N E =======================================


sub_141D8	proc near		; CODE XREF: seg000:41C0p seg000:41CCp
		mov	cl, es:[bx-8000h]
		and	cl, ch
		jz	short loc_141E3
		or	al, 2

loc_141E3:				; CODE XREF: sub_141D8+7j
		mov	cl, es:[bx]
		and	cl, ch
		jz	short locret_141EC
		or	al, 1

locret_141EC:				; CODE XREF: sub_141D8+10j
		retn
sub_141D8	endp

; ---------------------------------------------------------------------------

sFillGVRAM:				; DATA XREF: seg000:scriptFuncListo
		mov	dl, 1Bh
		mov	ah, 2
		int	21h		; DOS -	DISPLAY	OUTPUT
					; DL = character to send to standard output
		mov	dl, '*'
		int	21h		; DOS -	DISPLAY	OUTPUT
					; DL = character to send to standard output
		xor	al, al
		out	0A6h, al
		cli
		mov	al, 80h
		out	7Ch, al
		xor	al, al
		out	7Eh, al
		jmp	short $+2
		jmp	short $+2
		out	7Eh, al
		jmp	short $+2
		jmp	short $+2
		out	7Eh, al
		jmp	short $+2
		jmp	short $+2
		out	7Eh, al
		sti
		push	es
		xor	di, di		; start	at address 0
		push	0A800h		; GVRAM	Plane 0
		pop	es
		assume es:nothing
		mov	cx, 8000h
		rep stosw
		pop	es
		assume es:nothing
		xor	al, al
		out	7Ch, al
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

sSomethingClear:			; DATA XREF: seg000:scriptFuncListo
		mov	al, es:[si]
		out	0A6h, al
		mov	dx, es:[si+2]
		mov	bx, es:[si+4]
		shl	bx, 4
		add	dx, bx
		add	bx, bx
		add	bx, bx
		add	bx, dx		; BX = [si+4]*50h + [si+2]
		mov	dx, es:[si+6]
		mov	cx, es:[si+8]
		add	si, 0Ah
		cli
		mov	al, 80h
		out	7Ch, al
		xor	al, al
		out	7Eh, al
		jmp	short $+2
		jmp	short $+2
		out	7Eh, al
		jmp	short $+2
		jmp	short $+2
		out	7Eh, al
		jmp	short $+2
		jmp	short $+2
		out	7Eh, al
		sti
		push	es
		push	0A800h
		pop	es
		assume es:nothing

loc_1426F:				; CODE XREF: seg000:427Aj
		push	cx
		mov	di, bx
		mov	cx, dx
		rep stosb
		add	bx, 50h
		pop	cx
		loop	loc_1426F
		pop	es
		assume es:nothing
		xor	al, al
		out	7Ch, al
		xor	al, al
		out	0A6h, al	; Interrupt Controller #2, 8259A
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

sSetPalColour:				; DATA XREF: seg000:scriptFuncListo
		call	GetVariable
		and	ax, 0Fh		; Palette Colour ID: 00h..0Fh
		mov	bx, ax
		add	bx, ax
		add	bx, ax		; BX = ColID * 3 -> palette array offset
		out	0A8h, al	; GDC: set palette
		call	GetVariable
		and	al, 0Fh
		mov	(PalCurrent+1)[bx], al
		mov	(PalTarget+1)[bx], al
		out	0ACh, al	; GDC: set colour Red
		call	GetVariable
		and	al, 0Fh
		mov	PalCurrent[bx],	al
		mov	PalTarget[bx], al
		out	0AAh, al	; GDC: set colour Green
		call	GetVariable
		and	al, 0Fh
		mov	(PalCurrent+2)[bx], al
		mov	(PalTarget+2)[bx], al
		out	0AEh, al	; GDC: set colour Blue
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

sApplyPalette:				; DATA XREF: seg000:scriptFuncListo
		push	si
		push	es
		mov	si, offset PalCurrent
		push	ds
		pop	es
		assume es:dseg
		mov	di, offset PalTarget
		mov	cx, 30h		; 10h colours, 3 bytes per colour
		rep movsw
		pop	es
		assume es:nothing
		pop	si
		call	WaitForVSync
		call	UploadPalette
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

sPalFadeBW1:				; DATA XREF: seg000:scriptFuncListo
		call	SetPalToBlack
		mov	ax, es:[si]
		mov	cx, es:[si+2]
		add	si, 4
		push	si
		test	ax, ax
		jz	short loc_14339
		call	SetPalToWhite

loc_142F5:				; CODE XREF: seg000:4333j
		mov	si, offset PalCurrent
		mov	di, offset PalTarget
		mov	bx, PalColLockMask
		mov	ah, 10h

loc_14301:				; CODE XREF: seg000:4328j
		ror	bx, 1
		jb	short loc_14320
		mov	al, [si]
		cmp	al, [di]
		sbb	byte ptr [di], 0 ; subtract -> fade to black
		mov	al, [si+1]
		cmp	al, [di+1]
		sbb	byte ptr [di+1], 0
		mov	al, [si+2]
		cmp	al, [di+2]
		sbb	byte ptr [di+2], 0

loc_14320:				; CODE XREF: seg000:4303j
		add	si, 3
		add	di, 3
		dec	ah
		jnz	short loc_14301
		call	WaitFrames
		call	UploadPalette
		call	CheckPalEqual
		jnz	short loc_142F5
		pop	si
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

loc_14339:				; CODE XREF: seg000:42F0j seg000:4377j
		mov	si, offset PalCurrent
		mov	di, offset PalTarget
		mov	bx, PalColLockMask
		mov	ah, 10h

loc_14345:				; CODE XREF: seg000:436Cj
		ror	bx, 1
		jb	short loc_14364
		mov	al, [si]
		cmp	[di], al
		adc	byte ptr [di], 0 ; add -> fade to white
		mov	al, [si+1]
		cmp	[di+1],	al
		adc	byte ptr [di+1], 0
		mov	al, [si+2]
		cmp	[di+2],	al
		adc	byte ptr [di+2], 0

loc_14364:				; CODE XREF: seg000:4347j
		add	si, 3
		add	di, 3
		dec	ah
		jnz	short loc_14345
		call	WaitFrames
		call	UploadPalette
		call	CheckPalEqual
		jnz	short loc_14339
		pop	si
		jmp	ScriptMainLop

; =============== S U B	R O U T	I N E =======================================


CheckPalEqual	proc near		; CODE XREF: seg000:4330p seg000:4374p
		mov	si, offset PalCurrent
		mov	di, offset PalTarget
		mov	bx, PalColLockMask
		mov	dx, 1000h

loc_1438A:				; CODE XREF: CheckPalEqual+35j
		ror	bx, 1
		jb	short loc_143AA
		mov	al, [si]
		mov	ah, [di]
		xor	al, ah
		or	dl, al
		mov	al, [si+1]
		mov	ah, [di+1]
		xor	al, ah
		or	dl, al
		mov	al, [si+2]
		mov	ah, [di+2]
		xor	al, ah
		or	dl, al

loc_143AA:				; CODE XREF: CheckPalEqual+Fj
		add	si, 3
		add	di, 3
		dec	dh
		jnz	short loc_1438A
		or	dl, dl
		retn
CheckPalEqual	endp

; ---------------------------------------------------------------------------

sPalFadeBW2:				; DATA XREF: seg000:scriptFuncListo
		mov	ax, es:[si]
		mov	cx, es:[si+2]
		add	si, 4
		test	ax, ax
		jz	short loc_14405

loc_143C5:				; CODE XREF: seg000:4400j
		mov	ax, PalColLockMask
		mov	bx, offset PalTarget
		mov	dx, 100Fh

loc_143CE:				; CODE XREF: seg000:43F5j
		ror	ax, 1
		jb	short loc_143F0
		cmp	byte ptr [bx], 0Fh
		adc	byte ptr [bx], 0
		and	dl, [bx]
		cmp	byte ptr [bx+1], 0Fh
		adc	byte ptr [bx+1], 0
		and	dl, [bx+1]
		cmp	byte ptr [bx+2], 0Fh
		adc	byte ptr [bx+2], 0
		and	dl, [bx+2]

loc_143F0:				; CODE XREF: seg000:43D0j
		add	bx, 3
		dec	dh
		jnz	short loc_143CE
		call	WaitFrames
		call	UploadPalette
		cmp	dl, 0Fh
		jnz	short loc_143C5
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

loc_14405:				; CODE XREF: seg000:43C3j seg000:443Fj
		mov	ax, PalColLockMask
		mov	bx, offset PalTarget
		mov	dx, 1000h

loc_1440E:				; CODE XREF: seg000:4435j
		ror	ax, 1
		jb	short loc_14430
		sub	byte ptr [bx], 1
		adc	byte ptr [bx], 0
		or	dl, [bx]
		sub	byte ptr [bx+1], 1
		adc	byte ptr [bx+1], 0
		or	dl, [bx+1]
		sub	byte ptr [bx+2], 1
		adc	byte ptr [bx+2], 0
		or	dl, [bx+2]

loc_14430:				; CODE XREF: seg000:4410j
		add	bx, 3
		dec	dh
		jnz	short loc_1440E
		call	WaitFrames
		call	UploadPalette
		or	dl, dl
		jnz	short loc_14405
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

sPalMaskToggle:				; DATA XREF: seg000:scriptFuncListo
		mov	cl, es:[si]
		inc	si
		inc	si
		mov	ax, 1
		rol	ax, cl
		xor	PalColLockMask,	ax
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

sScriptSomething:			; DATA XREF: seg000:scriptFuncListo
		cli
		push	si
		push	ds
		push	es
		mov	si, es:[si]
		mov	di, word ptr SceneData
		add	si, di
		add	di, 0BC00h	; DI = SceneData + 0BC00h + [si]
		mov	SceneData2, di
		push	es
		pop	ds

loc_1446C:				; CODE XREF: seg000:447Fj
		lodsw
		stosw
		or	ax, ax
		jz	short loc_14481
		mov	cx, 10h

loc_14475:				; CODE XREF: seg000:loc_1447Cj
		shr	ax, 1
		jnb	short loc_1447C
		movsw
		movsw
		movsw

loc_1447C:				; CODE XREF: seg000:4477j
		loop	loc_14475
		movsw
		jmp	short loc_1446C
; ---------------------------------------------------------------------------

loc_14481:				; CODE XREF: seg000:4470j
		pop	es
		pop	ds
		pop	si
		inc	si
		inc	si
		mov	word_1E5C8, 1
		sti
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

sTextClear_E1:				; DATA XREF: seg000:scriptFuncListo
		mov	ax, 87E1h
		mov	textFillMode, ax
		call	doTextFill
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

sTextClear_01:				; DATA XREF: seg000:scriptFuncListo
		mov	ax, 8701h
		mov	textFillMode, ax
		call	doTextFill
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

sTextFill:				; DATA XREF: seg000:scriptFuncListo
		mov	di, es:[si]
		mov	ax, es:[si+2]
		add	di, di
		add	di, di
		shl	ax, 5
		add	di, ax
		add	ax, ax
		add	ax, ax
		add	di, ax		; DI = [si+2]*0A0h + [si+0]*04h
		mov	cx, es:[si+4]
		mov	bx, es:[si+6]

loc_144C6:
		mov	ax, es:[si+8]
		mov	dx, ax
		and	al, 7
		shl	al, 5
		and	dl, 8
		shr	dl, 1
		or	dl, al
		or	dl, 1
		mov	ax, es:[si+0Ah]	; read Shift-JIS character
		add	si, 0Ch
		push	si
		push	es
		push	0A000h
		pop	es
		assume es:nothing
		add	ah, ah		; Shift-JIS -> JIS conversion
		sub	al, 1Fh
		js	short loc_144F2
		cmp	al, 61h
		adc	al, 0DEh

loc_144F2:				; CODE XREF: seg000:44ECj
		add	ax, 1FA1h
		and	ax, 7F7Fh
		xchg	ah, al
		sub	al, 20h

loc_144FC:				; CODE XREF: seg000:4517j
		push	cx
		push	di

loc_144FE:				; CODE XREF: seg000:450Ej
		and	al, 7Fh
		stosw
		or	al, 80h
		stosw
		mov	es:[di+1FFCh], dx
		mov	es:[di+1FFEh], dx
		loop	loc_144FE
		pop	di
		pop	cx
		add	di, 0A0h
		dec	bx
		jnz	short loc_144FC
		pop	es
		assume es:nothing
		pop	si
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

sLoadFontChr:				; DATA XREF: seg000:scriptFuncListo
		mov	al, 0Bh
		out	68h, al
		mov	ax, es:[si]	; get font character code
		out	0A1h, al	; ChrROM: write	character code High
		mov	al, ah
		sub	al, 20h
		out	0A3h, al	; ChrROM: write	character code Low
		push	si
		push	ds
		mov	si, es:[si+2]
		add	si, word ptr SceneData
		mov	ds, word ptr SceneData+2
		mov	cx, 10h

loc_1453E:				; CODE XREF: seg000:4552j
		mov	al, 10h
		sub	al, cl
		mov	ah, al
		or	al, 20h
		out	0A5h, al	; ChrROM: write	Pattern	Line Select
		lodsb
		out	0A9h, al	; ChrROM: write	Pattern
		mov	al, ah
		out	0A5h, al	; ChrROM: write	Pattern	Line Select
		lodsb
		out	0A9h, al	; ChrROM: write	Pattern
		loop	loc_1453E
		mov	al, 0Ah
		out	68h, al
		pop	ds
		pop	si
		add	si, 4
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

loc_14560:				; DATA XREF: seg000:scriptFuncListo
		mov	di, offset word_1D1B0
		jmp	short loc_14568
; ---------------------------------------------------------------------------

loc_14565:				; DATA XREF: seg000:scriptFuncListo
		mov	di, (offset word_1D1B0+2)

loc_14568:				; CODE XREF: seg000:4563j
		push	ds
		push	es
		pop	ds
		pop	es
		mov	cx, 8

loc_1456F:				; CODE XREF: seg000:4572j
		movsw			; ES:DI	= DS:SI
		inc	di
		inc	di
		loop	loc_1456F
		push	ds
		push	es
		pop	ds
		pop	es
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

loc_1457B:				; DATA XREF: seg000:scriptFuncListo
		mov	ax, es:[si]
		mov	word_1D1AA, ax
		mov	ax, es:[si+2]
		mov	word_1D1AC, ax
		add	si, 4
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

loc_1458E:				; DATA XREF: seg000:scriptFuncListo
		mov	byte_1D17A, 0FFh
		mov	al, es:[si]
		mov	byte_1D178, al
		mov	al, es:[si+2]
		mov	byte_1D179, al
		push	si
		mov	si, es:[si+4]
		add	si, word ptr SceneData
		call	PrintTextSomething
		pop	si
		add	si, 6
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

loc_145B3:				; DATA XREF: seg000:scriptFuncListo
		mov	al, es:[si]
		and	al, 0Fh
		mov	byte_1D17A, al
		mov	cl, 18h
		mul	cl
		add	ax, offset byte_1CE5A
		mov	word_1D17E, ax
		push	si
		mov	si, es:[si+2]
		add	si, word ptr SceneData
		call	PrintTextSomething
		pop	si
		add	si, 4
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

loc_145D8:				; DATA XREF: seg000:scriptFuncListo
		mov	al, es:[si]
		inc	si
		inc	si
		and	al, 0Fh
		mov	byte_1D17A, al
		mov	cl, 18h
		mul	cl
		add	ax, offset byte_1CE5A
		mov	word_1D17E, ax
		cmp	word ptr es:[si], 400h
		jnb	short loc_145FB
		call	GetVariable
		call	Int2Str_Short
		jmp	short loc_14601
; ---------------------------------------------------------------------------

loc_145FB:				; CODE XREF: seg000:45F1j
		call	GetLVariable
		call	Int2Str_Long

loc_14601:				; CODE XREF: seg000:45F9j
		push	si
		push	es
		mov	ax, ds
		mov	es, ax
		assume es:dseg
		mov	si, offset i2sTextBuf
		call	PrintTextSomething
		pop	es
		assume es:nothing
		pop	si
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

loc_14612:				; CODE XREF: seg000:4617j
					; DATA XREF: seg000:scriptFuncListo
		mov	al, byte_1D1F9
		or	al, al
		jz	short loc_14612
		mov	ah, al

loc_1461B:				; CODE XREF: seg000:4622j
		mov	al, byte_1D1F9
		and	al, ah
		cmp	al, ah
		jz	short loc_1461B
		call	GetVarPtr
		xchg	ah, al
		mov	[bx], ax
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

loc_1462E:				; DATA XREF: seg000:scriptFuncListo
		call	GetVarPtr
		mov	word_1D1E5, bx
		call	GetVarPtr
		mov	word_1D1E7, bx
		mov	ax, es:[si]
		add	ax, word ptr SceneData
		mov	word ptr dword_1D1ED, ax
		mov	word ptr dword_1D1ED+2,	es
		mov	ax, es:[si+2]
		add	ax, word ptr SceneData
		mov	word_1D1F1, ax
		add	si, 4
		mov	byte_1D1F6, 0
		mov	byte_1D1F7, 0FFh
		mov	byte_1D1F9, 0
		mov	byte_1D1F5, 40h
		mov	byte_1D1F4, 0FFh
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

loc_14674:				; DATA XREF: seg000:scriptFuncListo
		call	GetVarPtr
		mov	word_1D1E9, bx
		call	GetVarPtr
		mov	word_1D1EB, bx
		call	GetVarPtr
		mov	word_1D1E7, bx
		mov	ax, es:[si]
		add	ax, word ptr SceneData
		mov	word_1D1F1, ax
		inc	si
		inc	si
		mov	byte_1D1F6, 0
		mov	byte_1D1F7, 0FFh
		mov	byte_1D1F9, 0
		mov	byte_1D1F5, 41h
		mov	byte_1D1F4, 0FFh
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

loc_146B1:				; DATA XREF: seg000:scriptFuncListo
		cmp	byte_1D1F5, 0
		jz	short loc_146BE
		mov	al, es:[si]
		mov	byte_1D1F4, al

loc_146BE:				; CODE XREF: seg000:46B6j
		inc	si
		inc	si
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

loc_146C3:				; DATA XREF: seg000:scriptFuncListo
		cli
		push	es
		push	ds
		pop	es
		assume es:dseg
		pop	ds
		mov	di, offset word_1D206
		mov	cx, 4
		rep movsw
		push	es
		push	ds
		pop	es
		pop	ds
		call	sub_146F2
		sti
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

loc_146DB:				; DATA XREF: seg000:scriptFuncListo
		cli
		mov	bx, offset word_1D206
		mov	cx, 4

loc_146E2:				; CODE XREF: seg000:46E9j
		call	GetVariable
		mov	[bx], ax
		inc	bx
		inc	bx
		loop	loc_146E2
		call	sub_146F2
		sti
		jmp	ScriptMainLop

; =============== S U B	R O U T	I N E =======================================


sub_146F2	proc near		; CODE XREF: seg000:46D4p seg000:46EBp
		mov	ax, word_1D206
		cmp	ax, 270h
		jbe	short loc_146FD
		mov	ax, 270h

loc_146FD:				; CODE XREF: sub_146F2+6j
		mov	dx, word_1D20A
		cmp	dx, 270h
		jbe	short loc_1470A
		mov	dx, 270h

loc_1470A:				; CODE XREF: sub_146F2+13j
		cmp	ax, dx
		jbe	short loc_1470F
		xchg	ax, dx

loc_1470F:				; CODE XREF: sub_146F2+1Aj
		mov	word_1D206, ax
		mov	word_1D20A, dx
		mov	ax, word_1D208
		cmp	ax, 180h
		jbe	short loc_14721
		mov	ax, 180h

loc_14721:				; CODE XREF: sub_146F2+2Aj
		mov	dx, word_1D20C
		cmp	dx, 180h
		jbe	short loc_1472E
		mov	dx, 180h

loc_1472E:				; CODE XREF: sub_146F2+37j
		cmp	ax, dx
		jbe	short loc_14733
		xchg	ax, dx

loc_14733:				; CODE XREF: sub_146F2+3Ej
		mov	word_1D208, ax
		mov	word_1D20C, dx
		retn
sub_146F2	endp

; ---------------------------------------------------------------------------

loc_1473B:				; DATA XREF: seg000:scriptFuncListo
		mov	ax, word_1D202
		mov	dx, word_1D204
		call	GetVarPtr
		mov	[bx], ax
		call	GetVarPtr
		mov	[bx], dx
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

loc_1474F:				; DATA XREF: seg000:scriptFuncListo
		cli
		mov	ax, es:[si]
		mov	word_1D202, ax
		mov	ax, es:[si+2]
		mov	word_1D204, ax
		sti
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

loc_14761:				; DATA XREF: seg000:scriptFuncListo
		cli
		call	GetVariable
		mov	word_1D202, ax
		call	GetVariable
		mov	word_1D204, ax
		sti
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

CallPMD:				; DATA XREF: SetupInt0A_24+1Bo
		int	60h		; call PMD driver (OPN/OPNA)
		retn
; ---------------------------------------------------------------------------

CallMMD:				; DATA XREF: SetupInt0A_24+22o
		int	61h		; call MMD driver (MIDI)
		retn
; ---------------------------------------------------------------------------

sBGM_Play:				; DATA XREF: seg000:scriptFuncListo
		mov	bx, es:[si]
		inc	si
		inc	si
		cmp	MusicMode, 0
		jnz	short loc_14787
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

loc_14787:				; CODE XREF: seg000:4782j
		add	bx, word ptr SceneData
		mov	ah, 1
		call	CallMusicDriver	; API call 01 -	Stop Song
		push	ds
		mov	ah, 6
		call	CallMusicDriver	; API call 06 -	get Song Buffer	Address
		mov	ax, ds
		pop	ds
		mov	word ptr FileLoadDstPtr+2, ax
		mov	word ptr FileLoadDstPtr, dx
		mov	FileBufSize, 8000h
		push	es
		push	bx
		call	LoadFile
		pop	ax
		pop	ax
		jnb	short loc_147B4
		jmp	ExitWithErrMsg
; ---------------------------------------------------------------------------

loc_147B4:				; CODE XREF: seg000:47AFj
		xor	ah, ah
		call	CallMusicDriver	; API call 00 -	Play Song
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

sBGM_FadeOut:				; DATA XREF: seg000:scriptFuncListo
		cmp	MusicMode, 0
		jnz	short loc_147C7
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

loc_147C7:				; CODE XREF: seg000:47C2j
		mov	ax, 20Ah
		call	CallMusicDriver	; API call 02 -	Fade Out, speed	0Ah
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

sBGM_Stop:				; DATA XREF: seg000:scriptFuncListo
		cmp	MusicMode, 0
		jnz	short loc_147DB
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

loc_147DB:				; CODE XREF: seg000:47D6j
		mov	ah, 1
		call	CallMusicDriver	; API call 01 -	Stop Song
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

sGetMusMode:				; DATA XREF: seg000:scriptFuncListo
		call	GetVarPtr
		mov	al, MusicMode
		cbw
		mov	[bx], ax
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

sBGM_GetMeas:				; DATA XREF: seg000:scriptFuncListo
		call	GetVarPtr
		cmp	MusicMode, 0
		jnz	short loc_147FD
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

loc_147FD:				; CODE XREF: seg000:47F8j
		mov	ah, 5
		call	CallMusicDriver	; API call 05 -	Get Song Measure
		cbw
		mov	[bx], ax
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

sBGM_GetState:				; DATA XREF: seg000:scriptFuncListo
		call	GetVarPtr
		cmp	MusicMode, 0
		jnz	short loc_14816
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

loc_14816:				; CODE XREF: seg000:4811j
		mov	ah, 0Ah
		call	CallMusicDriver	; API call 0A -	Get Internal Status
		mov	[bx], ax
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

sSFX_PlaySSG:				; DATA XREF: seg000:scriptFuncListo
		mov	al, es:[si]
		inc	si
		inc	si
		cmp	MusicMode, 0
		jnz	short loc_14830
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

loc_14830:				; CODE XREF: seg000:482Bj
		mov	ah, 3		; API call 03 -	play SSG sound effect
		int	60h		; call PMD driver (OPN/OPNA)
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

sSFX_PlayFM:				; DATA XREF: seg000:scriptFuncListo
		mov	al, es:[si]
		inc	si
		inc	si
		cmp	MusicMode, 0
		jnz	short loc_14846
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

loc_14846:				; CODE XREF: seg000:4841j
		mov	ah, 0Ch		; API call 0C -	play FM	sound effect
		int	60h		; call PMD driver (OPN/OPNA)
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

sCompareStrs:				; DATA XREF: seg000:scriptFuncListo
		call	GetStringPtr
		mov	di, bx
		call	GetStringPtr
		mov	scrCmpResult, 3

loc_1485A:				; CODE XREF: seg000:4867j
		mov	al, [bx]
		cmp	[di], al
		jz	short loc_14863
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

loc_14863:				; CODE XREF: seg000:485Ej
		inc	bx
		inc	di
		test	al, al
		jnz	short loc_1485A
		mov	scrCmpResult, al
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

sStrNCpy:				; DATA XREF: seg000:scriptFuncListo
		call	GetStringPtr
		mov	di, bx
		call	GetStringPtr
		mov	cx, es:[si]	; read number of characters to copy
		inc	si
		inc	si
		push	si
		push	es
		push	ds
		pop	es
		mov	si, bx
		rep movsb
		pop	es
		assume es:nothing
		pop	si
		mov	byte ptr [di], 0
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

sStrCat:				; DATA XREF: seg000:scriptFuncListo
		call	GetStringPtr
		call	StrLen
		add	bx, ax
		mov	di, bx
		call	GetStringPtr
		call	StrCopy
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

sStrChrCat:				; DATA XREF: seg000:scriptFuncListo
		call	GetStringPtr
		call	StrLen
		add	bx, ax
		mov	di, bx
		call	GetStringPtr
		add	bx, es:[si]	; read character index
		inc	si
		inc	si
		mov	al, [bx]
		mov	[di], al	; copy this one	character over
		mov	byte ptr [di+1], 0
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

sStr_SetVal:				; DATA XREF: seg000:scriptFuncListo
		call	GetStringPtr
		call	StrLen
		add	bx, ax
		mov	di, es:[si]
		inc	si
		inc	si
		add	di, word ptr SceneData

loc_148CD:				; CODE XREF: seg000:48D6j
		mov	al, es:[di]	; copy characters from SceneData file to string	variable
		mov	[bx], al
		inc	di
		inc	bx
		test	al, al
		jnz	short loc_148CD	; stop upon reaching a 00
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

sStrClear:				; DATA XREF: seg000:scriptFuncListo
		call	GetStringPtr
		push	es
		push	ds
		pop	es
		assume es:dseg
		mov	di, bx
		xor	ax, ax
		mov	cx, 28h
		rep stosw		; write	00 into	the entire string buffer
		pop	es
		assume es:nothing
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

sStrCopy:				; DATA XREF: seg000:scriptFuncListo
		call	GetStringPtr
		mov	di, bx
		call	GetStringPtr
		call	StrCopy
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

sStrLen:				; DATA XREF: seg000:scriptFuncListo
		call	GetVarPtr
		push	bx
		call	GetStringPtr
		call	StrLen
		pop	bx
		mov	[bx], ax
		jmp	ScriptMainLop

; =============== S U B	R O U T	I N E =======================================


StrLen		proc near		; CODE XREF: seg000:488Fp seg000:48A2p ...
		push	cx
		push	di
		push	es
		push	ds
		pop	es
		assume es:dseg
		mov	di, bx
		xor	cx, cx
		mov	al, cl		; AL = 0
		not	cx		; CX = 0FFFFh -> maximum number	of bytes to check
		repne scasb		; search for 00	byte (C	string terminator)
		mov	ax, 0FFFEh
		test	cx, cx
		jz	short loc_14924
		sub	ax, cx		; AX = 0FFFE - (bytes left) -> string size excluding terminator

loc_14924:				; CODE XREF: StrLen+14j
		pop	es
		assume es:nothing
		pop	di
		pop	cx
		retn
StrLen		endp


; =============== S U B	R O U T	I N E =======================================


StrCopy		proc near		; CODE XREF: seg000:4899p seg000:48F6p
		push	cx
		push	si
		push	di
		push	es
		call	StrLen
		test	ax, ax
		js	short loc_1493E	; don't copy when length is negative
		mov	cx, ax		; string length	without	terminator
		inc	cx		; include terminator
		push	cx
		mov	si, bx
		push	ds
		pop	es
		assume es:dseg
		rep movsb		; copy bytes from [param BX] to	[param DI]
		pop	ax		; AX = number of copied	bytes

loc_1493E:				; CODE XREF: StrCopy+9j
		pop	es
		assume es:nothing
		pop	di
		pop	si
		pop	cx
		retn
StrCopy		endp

; ---------------------------------------------------------------------------

sStrsFromFile:				; DATA XREF: seg000:scriptFuncListo
		call	GetStringPtr
		push	bx
		mov	ax, seg_1D16E
		mov	word ptr FileLoadDstPtr+2, ax
		xor	ax, ax
		mov	word ptr FileLoadDstPtr, ax
		not	ax
		mov	FileBufSize, ax	; set to 0FFFFh
		mov	ax, es:[si]
		inc	si
		inc	si
		add	ax, word ptr SceneData
		push	es
		push	ax
		call	LoadFile
		pop	ax
		pop	ax
		pop	bx
		jnb	short loc_1496D
		jmp	ExitWithErrMsg
; ---------------------------------------------------------------------------

loc_1496D:				; CODE XREF: seg000:4968j
		push	es
		mov	es, seg_1D16E
		xor	di, di
		call	ReadLine
		add	bx, 50h
		call	ReadLine
		pop	es
		jmp	ScriptMainLop

; =============== S U B	R O U T	I N E =======================================


ReadLine	proc near		; CODE XREF: seg000:4974p seg000:497Ap
		push	bx

loc_14982:				; CODE XREF: ReadLine+Dj
		mov	ax, es:[di]
		inc	di
		cmp	ax, 0A0Dh
		jz	short loc_14990
		mov	[bx], al
		inc	bx
		jmp	short loc_14982
; ---------------------------------------------------------------------------

loc_14990:				; CODE XREF: ReadLine+8j
		inc	di
		mov	byte ptr [bx], 0
		pop	bx
		retn
ReadLine	endp

; ---------------------------------------------------------------------------

sStrsToFile:				; DATA XREF: seg000:scriptFuncListo
		call	GetStringPtr
		mov	ax, es:[si]
		inc	si
		inc	si
		add	ax, word ptr SceneData
		push	si
		push	es
		push	es
		push	ax
		mov	es, seg_1D16E
		xor	di, di
		mov	word ptr FileLoadDstPtr+2, es
		mov	word ptr FileLoadDstPtr, di
		call	WriteLine
		add	bx, 50h
		call	WriteLine
		mov	al, 1Ah
		stosb
		mov	FileBufSize, di
		call	WriteFile
		pop	ax
		pop	ax
		pop	es
		pop	si
		jnb	short loc_149D0
		jmp	ExitWithErrMsg
; ---------------------------------------------------------------------------

loc_149D0:				; CODE XREF: seg000:49CBj
		jmp	ScriptMainLop

; =============== S U B	R O U T	I N E =======================================


WriteLine	proc near		; CODE XREF: seg000:49B4p seg000:49BAp
		push	bx

loc_149D4:				; CODE XREF: WriteLine+9j
		mov	al, [bx]
		inc	bx
		test	al, al
		jz	short loc_149DE
		stosb
		jmp	short loc_149D4
; ---------------------------------------------------------------------------

loc_149DE:				; CODE XREF: WriteLine+6j
		mov	ax, 0A0Dh
		stosw
		pop	bx
		retn
WriteLine	endp

; ---------------------------------------------------------------------------

loc_149E4:				; DATA XREF: seg000:scriptFuncListo
		push	si
		push	ds
		push	es
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		push	ds
		mov	ax, 0A800h	; GVRAM	Plane 0
		call	SomeGDCCopy7
		mov	ax, 0B000h	; GVRAM	Plane 1
		call	SomeGDCCopy7
		mov	ax, 0B800h	; GVRAM	Plane 2
		call	SomeGDCCopy7
		mov	ax, 0E000h	; GVRAM	Plane 3
		call	SomeGDCCopy7
		pop	ds
		push	ds
		mov	ax, word_1D170
		push	ax
		call	SomeGDCCopy7
		pop	ax
		add	ax, 800h
		call	SomeGDCCopy7
		pop	ds
		push	ds
		mov	ax, word_1D172
		push	ax
		call	SomeGDCCopy7
		pop	ax
		add	ax, 800h
		call	SomeGDCCopy7
		pop	ds
		push	ds
		mov	ax, word_1D170
		mov	cx, 0A800h	; GVRAM	Plane 0
		mov	ds, cx
		assume ds:nothing
		call	SomeGDCCopy8
		add	ax, 800h
		mov	cx, 0B000h	; GVRAM	Plane 1
		mov	ds, cx
		assume ds:nothing
		call	SomeGDCCopy8
		pop	ds
		assume ds:dseg
		mov	ax, word_1D172
		mov	cx, 0B800h	; GVRAM	Plane 2
		mov	ds, cx
		assume ds:nothing
		call	SomeGDCCopy8
		add	ax, 800h
		mov	cx, 0E000h	; GVRAM	Plane 3
		mov	ds, cx
		assume ds:nothing
		call	SomeGDCCopy8
		mov	ax, 0A800h	; GVRAM	Plane 0
		call	SomeGDCCopy9
		mov	ax, 0B000h	; GVRAM	Plane 1
		call	SomeGDCCopy9
		mov	ax, 0B800h	; GVRAM	Plane 2
		call	SomeGDCCopy9
		mov	ax, 0E000h	; GVRAM	Plane 3
		call	SomeGDCCopy9
		xor	al, al
		out	0A6h, al	; Interrupt Controller #2, 8259A
		pop	es
		pop	ds
		assume ds:dseg
		pop	si
		jmp	ScriptMainLop

; =============== S U B	R O U T	I N E =======================================


SomeGDCCopy7	proc near		; CODE XREF: seg000:49EFp seg000:49F5p ...
		mov	ds, ax
		mov	es, ax
		xor	si, si
		mov	di, si
		mov	ax, 400		; 400 lines

loc_14A80:				; CODE XREF: SomeGDCCopy7+14j
		mov	cx, 1Eh
		rep movsw
		add	si, 14h
		dec	ax
		jnz	short loc_14A80
		retn
SomeGDCCopy7	endp


; =============== S U B	R O U T	I N E =======================================


SomeGDCCopy8	proc near		; CODE XREF: seg000:4A2Ep seg000:4A39p ...
		mov	es, ax
		xor	si, si
		mov	di, offset byte_1EA70
		mov	cx, 0F96h
		rep movsw
		retn
SomeGDCCopy8	endp


; =============== S U B	R O U T	I N E =======================================


SomeGDCCopy9	proc near		; CODE XREF: seg000:4A56p seg000:4A5Cp ...
		mov	ds, ax
		mov	es, ax
		mov	si, offset byte_1ABDC
		xor	di, di
		mov	cx, 1B8Ah
		rep movsw
		retn
SomeGDCCopy9	endp

; ---------------------------------------------------------------------------

loc_14AA8:				; DATA XREF: seg000:scriptFuncListo
		push	si
		push	es
		mov	es, seg_1D16E
		xor	di, di
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		push	ds
		mov	ax, 0A800h	; GVRAM	Plane 0
		call	SomeGDCCopy10
		mov	ax, 0B000h	; GVRAM	Plane 1
		call	SomeGDCCopy10
		mov	ax, 0B800h	; GVRAM	Plane 2
		call	SomeGDCCopy10
		mov	ax, 0E000h	; GVRAM	Plane 3
		call	SomeGDCCopy10
		pop	ds
		mov	al, 1
		mov	portA4State, al
		out	0A4h, al	; Interrupt Controller #2, 8259A
		dec	al
		out	0A6h, al	; Interrupt Controller #2, 8259A
		pop	es
		pop	si
		jmp	ScriptMainLop

; =============== S U B	R O U T	I N E =======================================


SomeGDCCopy10	proc near		; CODE XREF: seg000:4AB8p seg000:4ABEp ...
		mov	ds, ax
		xor	si, si
		mov	cx, offset byte_1A858
		rep movsw
		push	di
		xor	si, si
		mov	bx, ds
		mov	dx, es
		mov	cx, 4

loc_14AF1:				; CODE XREF: SomeGDCCopy10+38j
		push	cx
		xor	al, al
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	di, 0DD40h
		push	si
		push	di
		mov	cx, offset byte_19CB0
		rep movsw
		inc	al
		out	0A6h, al	; Interrupt Controller #2, 8259A
		pop	si
		pop	di
		mov	ds, dx
		mov	es, bx
		assume es:dseg
		mov	cx, offset byte_19CB0
		rep movsw
		mov	ds, bx
		mov	es, dx
		assume es:nothing
		mov	si, di
		pop	cx
		loop	loc_14AF1
		pop	di
		retn
SomeGDCCopy10	endp

; ---------------------------------------------------------------------------

loc_14B1A:				; DATA XREF: seg000:scriptFuncListo
		call	GetVariable
		cmp	ax, 480
		jb	short loc_14B25
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

loc_14B25:				; CODE XREF: seg000:4B20j
		push	si
		push	es
		mov	bx, ax
		mov	al, portA4State
		out	0A4h, al	; Interrupt Controller #2, 8259A
		xor	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	word_1D29C, 0A800h ; GVRAM Plane 0
		mov	ax, word_1D170
		mov	word_1D29E, ax
		mov	ax, seg_1D16E
		mov	word_1D2A0, ax
		call	sub_14BA9
		mov	word_1D29C, 0B000h ; GVRAM Plane 1
		mov	ax, word_1D170
		add	ax, 800h
		mov	word_1D29E, ax
		mov	ax, seg_1D16E
		add	ax, 375h
		mov	word_1D2A0, ax
		call	sub_14BA9
		mov	word_1D29C, 0B800h ; GVRAM Plane 2
		mov	ax, word_1D172
		mov	word_1D29E, ax
		mov	ax, seg_1D16E
		add	ax, 6EAh
		mov	word_1D2A0, ax
		call	sub_14BA9
		mov	word_1D29C, 0E000h ; GVRAM Plane 3
		mov	ax, word_1D172
		add	ax, 800h
		mov	word_1D29E, ax
		mov	ax, seg_1D16E
		add	ax, 0A5Fh
		mov	word_1D2A0, ax
		call	sub_14BA9
		call	WaitForVSync
		mov	al, portA4State
		out	0A6h, al	; Interrupt Controller #2, 8259A
		xor	al, 1
		out	0A4h, al	; Interrupt Controller #2, 8259A
		mov	portA4State, al
		pop	es
		pop	si
		jmp	ScriptMainLop

; =============== S U B	R O U T	I N E =======================================


sub_14BA9	proc near		; CODE XREF: seg000:4B44p seg000:4B5Fp ...
		push	bx
		push	ds
		les	di, dword ptr unk_1D29A
		mov	cx, 120h
		cmp	bx, 215h
		jnb	short loc_14BE5
		mov	ds, word_1D29E
		mov	ax, bx
		add	ax, ax
		add	ax, ax
		mov	si, bx
		shl	si, 6
		sub	si, ax

loc_14BC9:				; CODE XREF: sub_14BA9+31j
		push	cx
		mov	cx, 1Eh
		rep movsw
		add	di, 14h
		pop	cx
		inc	bx
		cmp	bx, 215h
		jnb	short loc_14BDE
		loop	loc_14BC9
		jmp	short loc_14C17
; ---------------------------------------------------------------------------

loc_14BDE:				; CODE XREF: sub_14BA9+2Fj
		dec	cx
		jz	short loc_14C17
		push	seg dseg
		pop	ds

loc_14BE5:				; CODE XREF: sub_14BA9+Dj
					; sub_14BA9+6Cj
		mov	ds, word_1D2A0
		mov	ax, bx
		sub	ax, 215h
		mov	si, ax
		add	ax, ax
		add	ax, ax
		shl	si, 6
		sub	si, ax

loc_14BF9:				; CODE XREF: sub_14BA9+61j
		push	cx
		mov	cx, 1Eh
		rep movsw
		add	di, 14h
		pop	cx
		inc	bx
		cmp	bx, 215h
		jnb	short loc_14C0E
		loop	loc_14BF9
		jmp	short loc_14C17
; ---------------------------------------------------------------------------

loc_14C0E:				; CODE XREF: sub_14BA9+5Fj
		dec	cx
		jz	short loc_14C17
		push	seg dseg
		pop	ds
		jmp	short loc_14BE5
; ---------------------------------------------------------------------------

loc_14C17:				; CODE XREF: sub_14BA9+33j
					; sub_14BA9+36j ...
		pop	ds
		pop	bx
		retn
sub_14BA9	endp

; ---------------------------------------------------------------------------

loc_14C1A:				; DATA XREF: seg000:scriptFuncListo
		push	si
		push	es
		cli
		in	al, 0Ah		; DMA controller, 8237A-5.
					; single mask bit register
					; 0-1: select channel (00=0; 01=1; 10=2; 11=3)
					; 2: 1=set mask	for channel; 0=clear mask (enable)
		or	al, 20h
		out	0Ah, al		; DMA controller, 8237A-5.
					; single mask bit register
					; 0-1: select channel (00=0; 01=1; 10=2; 11=3)
					; 2: 1=set mask	for channel; 0=clear mask (enable)
		mov	al, byte_1E5C6
		push	ax
		xor	al, al
		mov	byte_1E5C6, al
		out	0A8h, al	; Interrupt Controller #2, 8259A
		out	0AAh, al	; Interrupt Controller #2, 8259A
		out	0ACh, al	; Interrupt Controller #2, 8259A
		out	0AEh, al	; Interrupt Controller #2, 8259A
		sti
		call	sub_14C4C
		call	sub_14DD8
		cli
		pop	ax
		mov	byte_1E5C6, al
		in	al, 0Ah		; DMA controller, 8237A-5.
					; single mask bit register
					; 0-1: select channel (00=0; 01=1; 10=2; 11=3)
					; 2: 1=set mask	for channel; 0=clear mask (enable)
		and	al, 0DFh
		out	0Ah, al		; DMA controller, 8237A-5.
					; single mask bit register
					; 0-1: select channel (00=0; 01=1; 10=2; 11=3)
					; 2: 1=set mask	for channel; 0=clear mask (enable)
		sti
		pop	es
		pop	si
		jmp	ScriptMainLop

; =============== S U B	R O U T	I N E =======================================


sub_14C4C	proc near		; CODE XREF: seg000:4C35p
		mov	di, 3FDh
		mov	dx, 3C2h
		mov	cx, 30
		mov	bx, 71

loc_14C58:				; CODE XREF: sub_14C4C:loc_14C75j
		call	MayWaitForVSync
		call	sub_14C78
		xchg	di, dx
		call	sub_14D28
		xchg	di, dx
		dec	di
		inc	dx
		cmp	cl, 29
		jnz	short loc_14C6E
		mov	bl, 59

loc_14C6E:				; CODE XREF: sub_14C4C+1Ej
		cmp	cl, 12
		jnz	short loc_14C75
		mov	bl, 47

loc_14C75:				; CODE XREF: sub_14C4C+25j
		loop	loc_14C58
		retn
sub_14C4C	endp


; =============== S U B	R O U T	I N E =======================================


sub_14C78	proc near		; CODE XREF: sub_14C4C+Fp
		mov	si, offset byte_1D20E
		mov	ax, 0A800h	; GVRAM	Plane 0
		call	SomeGDCCopy11
		mov	ax, 0B000h	; GVRAM	Plane 1
		call	SomeGDCCopy11
		mov	ax, 0B800h	; GVRAM	Plane 2
		call	SomeGDCCopy11
		mov	ax, 0E000h	; GVRAM	Plane 3
		call	SomeGDCCopy11
		retn
sub_14C78	endp


; =============== S U B	R O U T	I N E =======================================


SomeGDCCopy11	proc near		; CODE XREF: sub_14C78+6p sub_14C78+Cp ...
		mov	es, ax
		mov	ax, es:[di+0Ch]
		mov	es:[di], ax
		mov	ax, es:[di+5Ch]
		mov	es:[di+50h], ax
		mov	ax, es:[di+0ACh]
		mov	es:[di+0A0h], ax
		mov	ax, es:[di+0FCh]
		mov	es:[di+0F0h], ax
		call	sub_14F16
		add	di, 140h
		mov	ch, 48h

loc_14CC2:				; CODE XREF: SomeGDCCopy11+5Aj
		mov	ax, es:[di+0Ch]
		mov	es:[di], ax
		mov	ax, es:[di+5Ch]
		mov	es:[di+50h], ax
		mov	ax, es:[di+0ACh]
		mov	es:[di+0A0h], ax
		mov	ax, es:[di+0FCh]
		mov	es:[di+0F0h], ax
		call	sub_14F47
		add	di, 140h
		dec	ch
		jnz	short loc_14CC2
		mov	ax, es:[di+0Ch]
		mov	es:[di], ax
		mov	ax, es:[di+5Ch]
		mov	es:[di+50h], ax
		mov	ax, es:[di+0ACh]
		mov	es:[di+0A0h], ax
		mov	ax, es:[di+0FCh]
		mov	es:[di+0F0h], ax
		mov	ax, es:[di+14Ch]
		mov	es:[di+140h], ax
		call	sub_14F78
		sub	di, 5B40h
		add	si, 23h
		retn
SomeGDCCopy11	endp


; =============== S U B	R O U T	I N E =======================================


sub_14D28	proc near		; CODE XREF: sub_14C4C+14p
		mov	si, offset byte_1D20E
		mov	ax, 0A800h	; GVRAM	Plane 0
		call	SomeGDCCopy12
		mov	ax, 0B000h	; GVRAM	Plane 1
		call	SomeGDCCopy12
		mov	ax, 0B800h	; GVRAM	Plane 2
		call	SomeGDCCopy12
		mov	ax, 0E000h	; GVRAM	Plane 3
		call	SomeGDCCopy12
		retn
sub_14D28	endp


; =============== S U B	R O U T	I N E =======================================


SomeGDCCopy12	proc near		; CODE XREF: sub_14D28+6p sub_14D28+Cp ...
		mov	es, ax
		mov	ax, es:[bx+di]
		mov	es:[di-1], ax
		mov	ax, es:[bx+di+50h]
		mov	es:[di+4Fh], ax
		mov	ax, es:[bx+di+0A0h]
		mov	es:[di+9Fh], ax
		mov	ax, es:[bx+di+0F0h]
		mov	es:[di+0EFh], ax
		call	sub_14E77
		add	di, 140h
		mov	ch, 48h

loc_14D72:				; CODE XREF: SomeGDCCopy12+5Aj
		mov	ax, es:[bx+di]
		mov	es:[di-1], ax
		mov	ax, es:[bx+di+50h]
		mov	es:[di+4Fh], ax
		mov	ax, es:[bx+di+0A0h]
		mov	es:[di+9Fh], ax
		mov	ax, es:[bx+di+0F0h]
		mov	es:[di+0EFh], ax
		call	sub_14EA7
		add	di, 140h
		dec	ch
		jnz	short loc_14D72
		mov	ax, es:[bx+di]
		mov	es:[di-1], ax
		mov	ax, es:[bx+di+50h]
		mov	es:[di+4Fh], ax
		mov	ax, es:[bx+di+0A0h]
		mov	es:[di+9Fh], ax
		mov	ax, es:[bx+di+0F0h]
		mov	es:[di+0EFh], ax
		mov	ax, es:[bx+di+140h]
		mov	es:[di+13Fh], ax
		call	sub_14ED8
		sub	di, 5B40h
		add	si, 23h
		retn
SomeGDCCopy12	endp


; =============== S U B	R O U T	I N E =======================================


sub_14DD8	proc near		; CODE XREF: seg000:4C38p
		mov	di, 65Fh
		mov	dx, 5C9Fh
		mov	cx, 18

loc_14DE1:				; CODE XREF: sub_14DD8+1Ej
		call	MayWaitForVSync
		call	sub_14DF9
		xchg	di, dx
		call	sub_14E36
		xchg	di, dx
		add	di, 280h
		sub	dx, 280h
		loop	loc_14DE1
		retn
sub_14DD8	endp


; =============== S U B	R O U T	I N E =======================================


sub_14DF9	proc near		; CODE XREF: sub_14DD8+Cp
		mov	si, offset byte_1D20E
		mov	ax, 0A800h	; GVRAM	Plane 0
		call	SomeGDCCopy13
		mov	ax, 0B000h	; GVRAM	Plane 1
		call	SomeGDCCopy13
		mov	ax, 0B800h	; GVRAM	Plane 2
		call	SomeGDCCopy13
		mov	ax, 0E000h	; GVRAM	Plane 3
		call	SomeGDCCopy13
		retn
sub_14DF9	endp


; =============== S U B	R O U T	I N E =======================================


SomeGDCCopy13	proc near		; CODE XREF: sub_14DF9+6p sub_14DF9+Cp ...
		mov	es, ax
		call	sub_14E77
		inc	di
		call	sub_14F16
		sub	di, 281h
		mov	ch, 8

loc_14E24:				; CODE XREF: SomeGDCCopy13+1Bj
		mov	ax, es:[di+0Ch]
		mov	es:[di], ax
		add	di, 50h
		dec	ch
		jnz	short loc_14E24
		add	si, 23h
		retn
SomeGDCCopy13	endp


; =============== S U B	R O U T	I N E =======================================


sub_14E36	proc near		; CODE XREF: sub_14DD8+11p
		mov	si, offset byte_1D20E
		mov	ax, 0A800h	; GVRAM	Plane 0
		call	SomeGDCCopy14
		mov	ax, 0B000h	; GVRAM	Plane 1
		call	SomeGDCCopy14
		mov	ax, 0B800h	; GVRAM	Plane 2
		call	SomeGDCCopy14
		mov	ax, 0E000h	; GVRAM	Plane 3
		call	SomeGDCCopy14
		retn
sub_14E36	endp


; =============== S U B	R O U T	I N E =======================================


SomeGDCCopy14	proc near		; CODE XREF: sub_14E36+6p sub_14E36+Cp ...
		mov	es, ax
		call	sub_14ED8
		inc	di
		call	sub_14F78
		add	di, 18Fh
		mov	ch, 8

loc_14E61:				; CODE XREF: SomeGDCCopy14+1Bj
		mov	ax, es:[di+0Ch]
		mov	es:[di], ax
		add	di, 50h	; 'P'
		dec	ch
		jnz	short loc_14E61
		sub	di, 410h
		add	si, 23h	; '#'
		retn
SomeGDCCopy14	endp


; =============== S U B	R O U T	I N E =======================================


sub_14E77	proc near		; CODE XREF: SomeGDCCopy12+25p
					; SomeGDCCopy13+2p ...
		mov	ah, 0F0h ; 'ð'
		mov	al, [si]
		and	es:[di], ah
		or	es:[di], al
		mov	al, [si+1]
		and	es:[di+50h], ah
		or	es:[di+50h], al
		mov	al, [si+2]
		and	es:[di+0A0h], ah
		or	es:[di+0A0h], al
		mov	al, [si+3]
		and	es:[di+0F0h], ah
		or	es:[di+0F0h], al
		retn
sub_14E77	endp


; =============== S U B	R O U T	I N E =======================================


sub_14EA7	proc near		; CODE XREF: SomeGDCCopy12+51p
					; SomeGDCCopy17+9p ...
		mov	ah, 0F0h ; 'ð'
		mov	al, [si+4]
		and	es:[di], ah
		or	es:[di], al
		mov	al, [si+5]
		and	es:[di+50h], ah
		or	es:[di+50h], al
		mov	al, [si+6]
		and	es:[di+0A0h], ah
		or	es:[di+0A0h], al
		mov	al, [si+7]
		and	es:[di+0F0h], ah
		or	es:[di+0F0h], al
		retn
sub_14EA7	endp


; =============== S U B	R O U T	I N E =======================================


sub_14ED8	proc near		; CODE XREF: SomeGDCCopy12+89p
					; SomeGDCCopy14+2p ...
		mov	ah, 0F0h ; 'ð'
		mov	al, [si+8]
		and	es:[di], ah
		or	es:[di], al
		mov	al, [si+9]
		and	es:[di+50h], ah
		or	es:[di+50h], al
		mov	al, [si+0Ah]
		and	es:[di+0A0h], ah
		or	es:[di+0A0h], al
		mov	al, [si+0Bh]
		and	es:[di+0F0h], ah
		or	es:[di+0F0h], al
		mov	al, [si+0Ch]
		and	es:[di+140h], ah
		or	es:[di+140h], al
		retn
sub_14ED8	endp


; =============== S U B	R O U T	I N E =======================================


sub_14F16	proc near		; CODE XREF: SomeGDCCopy11+25p
					; SomeGDCCopy13+6p ...
		mov	ah, 7
		mov	al, [si+0Dh]
		and	es:[di], ah
		or	es:[di], al
		mov	al, [si+0Eh]
		and	es:[di+50h], ah
		or	es:[di+50h], al
		mov	al, [si+0Fh]
		and	es:[di+0A0h], ah
		or	es:[di+0A0h], al
		mov	al, [si+10h]
		and	es:[di+0F0h], ah
		or	es:[di+0F0h], al
		retn
sub_14F16	endp


; =============== S U B	R O U T	I N E =======================================


sub_14F47	proc near		; CODE XREF: SomeGDCCopy11+51p
					; SomeGDCCopy17+28p ...
		mov	ah, 7
		mov	al, [si+11h]
		and	es:[di], ah
		or	es:[di], al
		mov	al, [si+12h]
		and	es:[di+50h], ah
		or	es:[di+50h], al
		mov	al, [si+13h]
		and	es:[di+0A0h], ah
		or	es:[di+0A0h], al
		mov	al, [si+14h]
		and	es:[di+0F0h], ah
		or	es:[di+0F0h], al
		retn
sub_14F47	endp


; =============== S U B	R O U T	I N E =======================================


sub_14F78	proc near		; CODE XREF: SomeGDCCopy11+89p
					; SomeGDCCopy14+6p ...
		mov	ah, 7
		mov	al, [si+15h]
		and	es:[di], ah
		or	es:[di], al
		mov	al, [si+16h]
		and	es:[di+50h], ah
		or	es:[di+50h], al
		mov	al, [si+17h]
		and	es:[di+0A0h], ah
		or	es:[di+0A0h], al
		mov	al, [si+18h]
		and	es:[di+0F0h], ah
		or	es:[di+0F0h], al
		mov	al, [si+19h]
		and	es:[di+140h], ah
		or	es:[di+140h], al
		retn
sub_14F78	endp


; =============== S U B	R O U T	I N E =======================================


sub_14FB6	proc near		; CODE XREF: SomeGDCCopy15+10p
					; SomeGDCCopy16+2p ...
		push	si
		push	di
		add	si, 1Ah
		movsb
		add	di, 4Fh	; 'O'
		movsb
		add	di, 4Fh	; 'O'
		movsb
		add	di, 4Fh	; 'O'
		movsb
		pop	di
		pop	si
		retn
sub_14FB6	endp


; =============== S U B	R O U T	I N E =======================================


sub_14FCB	proc near		; CODE XREF: SomeGDCCopy15+17p
					; SomeGDCCopy16+9p ...
		push	si
		push	di
		add	si, 1Eh
		movsb
		add	di, 4Fh	; 'O'
		movsb
		add	di, 4Fh	; 'O'
		movsb
		add	di, 4Fh	; 'O'
		movsb
		add	di, 4Fh	; 'O'
		movsb
		pop	di
		pop	si
		retn
sub_14FCB	endp


; =============== S U B	R O U T	I N E =======================================


MayWaitForVSync	proc near		; CODE XREF: sub_14C4C:loc_14C58p
					; sub_14DD8:loc_14DE1p	...
		test	byte_1D1F9, 1
		jnz	short locret_14FEE
		call	WaitForVSync

locret_14FEE:				; CODE XREF: MayWaitForVSync+5j
		retn
MayWaitForVSync	endp

; ---------------------------------------------------------------------------

loc_14FEF:				; DATA XREF: seg000:scriptFuncListo
		push	si
		push	es
		cli
		in	al, 0Ah		; DMA controller, 8237A-5.
					; single mask bit register
					; 0-1: select channel (00=0; 01=1; 10=2; 11=3)
					; 2: 1=set mask	for channel; 0=clear mask (enable)
		or	al, 20h
		out	0Ah, al		; DMA controller, 8237A-5.
					; single mask bit register
					; 0-1: select channel (00=0; 01=1; 10=2; 11=3)
					; 2: 1=set mask	for channel; 0=clear mask (enable)
		mov	al, byte_1E5C6
		push	ax
		xor	al, al
		mov	byte_1E5C6, al
		out	0A8h, al	; Interrupt Controller #2, 8259A
		out	0AAh, al	; Interrupt Controller #2, 8259A
		out	0ACh, al	; Interrupt Controller #2, 8259A
		out	0AEh, al	; Interrupt Controller #2, 8259A
		sti
		call	sub_15021
		call	sub_150B8
		cli
		pop	ax
		mov	byte_1E5C6, al
		in	al, 0Ah		; DMA controller, 8237A-5.
					; single mask bit register
					; 0-1: select channel (00=0; 01=1; 10=2; 11=3)
					; 2: 1=set mask	for channel; 0=clear mask (enable)
		and	al, 0DFh
		out	0Ah, al		; DMA controller, 8237A-5.
					; single mask bit register
					; 0-1: select channel (00=0; 01=1; 10=2; 11=3)
					; 2: 1=set mask	for channel; 0=clear mask (enable)
		sti
		pop	es
		pop	si
		jmp	ScriptMainLop

; =============== S U B	R O U T	I N E =======================================


sub_15021	proc near		; CODE XREF: seg000:500Ap
		mov	di, 30DEh
		mov	dx, 30E0h
		mov	cx, 30

loc_1502A:				; CODE XREF: sub_15021+18j
		call	MayWaitForVSync
		call	sub_1503C
		xchg	di, dx
		call	sub_1507A
		xchg	di, dx
		dec	di
		inc	dx
		loop	loc_1502A
		retn
sub_15021	endp


; =============== S U B	R O U T	I N E =======================================


sub_1503C	proc near		; CODE XREF: sub_15021+Cp
		mov	si, offset byte_1D20E
		mov	ax, 0A800h	; GVRAM	Plane 0
		call	SomeGDCCopy15
		mov	ax, 0B000h	; GVRAM	Plane 1
		call	SomeGDCCopy15
		mov	ax, 0B800h	; GVRAM	Plane 2
		call	SomeGDCCopy15
		mov	ax, 0E000h	; GVRAM	Plane 3
		call	SomeGDCCopy15
		retn
sub_1503C	endp


; =============== S U B	R O U T	I N E =======================================


SomeGDCCopy15	proc near		; CODE XREF: sub_1503C+6p sub_1503C+Cp ...
		mov	es, ax
		call	sub_14E77
		add	di, 140h
		call	sub_14ED8
		sub	di, 13Fh
		call	sub_14FB6
		add	di, 140h
		call	sub_14FCB
		sub	di, 141h
		add	si, 23h	; '#'
		retn
SomeGDCCopy15	endp


; =============== S U B	R O U T	I N E =======================================


sub_1507A	proc near		; CODE XREF: sub_15021+11p
		mov	si, offset byte_1D20E
		mov	ax, 0A800h	; GVRAM	Plane 0
		call	SomeGDCCopy16
		mov	ax, 0B000h	; GVRAM	Plane 1
		call	SomeGDCCopy16
		mov	ax, 0B800h	; GVRAM	Plane 2
		call	SomeGDCCopy16
		mov	ax, 0E000h	; GVRAM	Plane 3
		call	SomeGDCCopy16
		retn
sub_1507A	endp


; =============== S U B	R O U T	I N E =======================================


SomeGDCCopy16	proc near		; CODE XREF: sub_1507A+6p sub_1507A+Cp ...
		mov	es, ax
		call	sub_14FB6
		add	di, 140h
		call	sub_14FCB
		sub	di, 13Fh
		call	sub_14F16
		add	di, 140h
		call	sub_14F78
		sub	di, 141h
		add	si, 23h	; '#'
		retn
SomeGDCCopy16	endp


; =============== S U B	R O U T	I N E =======================================


sub_150B8	proc near		; CODE XREF: seg000:500Dp
		mov	di, 2E41h
		mov	dx, 3481h
		mov	cx, 18

loc_150C1:				; CODE XREF: sub_150B8+1Ej
		call	MayWaitForVSync
		call	sub_150D9
		xchg	di, dx
		call	sub_15132
		xchg	di, dx
		sub	di, 280h
		add	dx, 280h
		loop	loc_150C1
		retn
sub_150B8	endp


; =============== S U B	R O U T	I N E =======================================


sub_150D9	proc near		; CODE XREF: sub_150B8+Cp
		mov	si, offset byte_1D20E
		mov	ax, 0A800h	; GVRAM	Plane 0
		call	SomeGDCCopy17
		mov	ax, 0B000h	; GVRAM	Plane 1
		call	SomeGDCCopy17
		mov	ax, 0B800h	; GVRAM	Plane 2
		call	SomeGDCCopy17
		mov	ax, 0E000h	; GVRAM	Plane 3
		call	SomeGDCCopy17
		retn
sub_150D9	endp


; =============== S U B	R O U T	I N E =======================================


SomeGDCCopy17	proc near		; CODE XREF: sub_150D9+6p sub_150D9+Cp ...
		mov	es, ax
		call	sub_14E77
		add	di, 140h
		call	sub_14EA7
		add	di, 140h
		call	sub_14EA7
		sub	di, 27Fh
		mov	ch, 3Ch	; '<'

loc_1510E:				; CODE XREF: SomeGDCCopy17+1Fj
		call	sub_14FB6
		inc	di
		dec	ch
		jnz	short loc_1510E
		call	sub_14F16
		add	di, 140h
		call	sub_14F47
		add	di, 140h
		call	sub_14F47
		sub	di, 2BDh
		add	si, 23h	; '#'
		call	sub_1518B
		retn
SomeGDCCopy17	endp


; =============== S U B	R O U T	I N E =======================================


sub_15132	proc near		; CODE XREF: sub_150B8+11p
		mov	si, offset byte_1D20E
		mov	ax, 0A800h	; GVRAM	Plane 0
		call	SomeGDCCopy18
		mov	ax, 0B000h	; GVRAM	Plane 1
		call	SomeGDCCopy18
		mov	ax, 0B800h	; GVRAM	Plane 2
		call	SomeGDCCopy18
		mov	ax, 0E000h	; GVRAM	Plane 3
		call	SomeGDCCopy18
		retn
sub_15132	endp


; =============== S U B	R O U T	I N E =======================================


SomeGDCCopy18	proc near		; CODE XREF: sub_15132+6p sub_15132+Cp ...
		mov	es, ax
		call	sub_14ED8
		sub	di, 140h
		call	sub_14EA7
		sub	di, 140h
		call	sub_14EA7
		add	di, 281h
		mov	ch, 3Ch	; '<'

loc_15167:				; CODE XREF: SomeGDCCopy18+1Fj
		call	sub_14FCB
		inc	di
		dec	ch
		jnz	short loc_15167
		call	sub_14F78
		sub	di, 140h
		call	sub_14F47
		sub	di, 140h
		call	sub_14F47
		add	di, 243h
		add	si, 23h	; '#'
		call	sub_151A1
		retn
SomeGDCCopy18	endp


; =============== S U B	R O U T	I N E =======================================


sub_1518B	proc near		; CODE XREF: SomeGDCCopy17+39p
		push	si
		push	di
		push	ds
		push	es
		pop	ds
		add	di, 141h
		mov	si, di
		sub	si, 502h
		call	sub_151B7
		pop	ds
		pop	di
		pop	si
		retn
sub_1518B	endp


; =============== S U B	R O U T	I N E =======================================


sub_151A1	proc near		; CODE XREF: SomeGDCCopy18+39p
		push	si
		push	di
		push	ds
		push	es
		pop	ds
		sub	di, 27Fh
		mov	si, di
		sub	si, 502h
		call	sub_151B7
		pop	ds
		pop	di
		pop	si
		retn
sub_151A1	endp


; =============== S U B	R O U T	I N E =======================================


sub_151B7	proc near		; CODE XREF: sub_1518B+Fp sub_151A1+Fp
		push	ds
		mov	es, seg_1D16E
		push	cx
		push	di
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		xor	di, di
		mov	al, 8

loc_151C6:				; CODE XREF: sub_151B7+19j
		mov	cx, 1Eh
		rep movsw
		add	si, 14h
		dec	al
		jnz	short loc_151C6
		out	0A6h, al	; Interrupt Controller #2, 8259A
		pop	di
		xor	si, si
		push	ds
		push	es
		pop	ds
		pop	es
		mov	al, 8

loc_151DD:				; CODE XREF: sub_151B7+30j
		mov	cx, 1Eh
		rep movsw
		add	di, 14h
		dec	al
		jnz	short loc_151DD
		pop	cx
		pop	ds
		retn
sub_151B7	endp

; ---------------------------------------------------------------------------

loc_151EC:				; DATA XREF: seg000:scriptFuncListo
		push	si
		push	ds
		push	es
		mov	si, es:[si]
		add	si, word ptr SceneData
		push	es
		push	ds
		pop	es
		assume es:dseg
		pop	ds
		mov	di, offset byte_1D2A4
		mov	cx, 30h

loc_15200:				; CODE XREF: seg000:5248j
		lodsw
		and	al, 3
		stosb
		lodsw
		mov	dx, ax
		lodsw
		shl	ax, 4
		add	dx, ax
		add	ax, ax
		add	ax, ax
		add	ax, dx
		stosw
		lodsw
		and	al, 0Fh
		mov	es:[di], al
		lodsw
		and	al, 0Fh
		shl	al, 4
		or	es:[di], al
		lodsw
		and	al, 0Fh
		shl	al, 4
		mov	es:[di+1], al
		lodsw
		and	al, 0Fh
		shl	al, 4
		mov	es:[di+2], al
		lodsw
		and	al, 0Fh
		or	es:[di+1], al
		lodsw
		and	al, 0Fh
		or	es:[di+2], al
		add	di, 3
		loop	loc_15200
		pop	es
		assume es:nothing
		pop	ds
		pop	si
		inc	si
		inc	si
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

loc_15252:				; DATA XREF: seg000:scriptFuncListo
		mov	ax, es:[si]
		mov	bx, ax
		add	ax, ax
		add	ax, ax
		add	bx, bx
		add	bx, ax		; BX = [si+0] *	6
		add	bx, offset byte_1D2A4
		mov	al, es:[si+2]
		and	al, 3
		mov	[bx], al
		mov	dx, es:[si+4]
		mov	ax, es:[si+6]
		shl	ax, 4
		add	dx, ax
		add	ax, ax
		add	ax, ax
		add	ax, dx		; AX = [si+6]*50h + [si+4]
		mov	[bx+1],	ax
		mov	al, es:[si+8]
		and	al, 0Fh
		mov	[bx+3],	al
		mov	al, es:[si+0Ah]
		and	al, 0Fh
		shl	al, 4
		or	[bx+3],	al
		mov	al, es:[si+0Ch]
		and	al, 0Fh
		shl	al, 4
		mov	[bx+4],	al
		mov	al, es:[si+0Eh]
		and	al, 0Fh
		shl	al, 4
		mov	[bx+5],	al
		mov	al, es:[si+10h]
		and	al, 0Fh
		or	[bx+4],	al
		mov	al, es:[si+12h]
		and	al, 0Fh
		or	[bx+5],	al
		add	si, 14h
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

loc_152C6:				; DATA XREF: seg000:scriptFuncListo
		mov	al, es:[si]
		and	al, 3
		mov	SomeGDCPlane, al
		mov	dx, es:[si+2]
		mov	ax, es:[si+4]
		shl	ax, 4
		add	dx, ax
		add	ax, ax
		add	ax, ax
		add	ax, dx		; AX = [si+4]*50h + [si+6]
		mov	word_1D2A2, ax
		add	si, 6
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

loc_152EA:				; DATA XREF: seg000:scriptFuncListo
		push	si
		push	ds
		push	es
		mov	si, es:[si]
		add	si, word ptr SceneData
		push	es
		push	ds
		pop	es
		assume es:dseg
		pop	ds
		mov	di, offset byte_1D2A4
		mov	cx, 30h

loc_152FE:				; CODE XREF: seg000:5315j
		lodsw
		and	al, 3
		stosb
		lodsw
		mov	dx, ax
		lodsw
		shl	ax, 4
		add	dx, ax
		add	ax, ax
		add	ax, ax
		add	ax, dx
		stosw
		add	di, 3
		loop	loc_152FE
		pop	es
		assume es:nothing
		pop	ds
		pop	si
		inc	si
		inc	si
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

loc_1531F:				; DATA XREF: seg000:scriptFuncListo
		call	GetVariable
		mov	bx, ax
		add	ax, ax
		add	ax, ax
		add	bx, bx
		add	bx, ax		; BX = param1 *	6
		add	bx, offset byte_1D2A4
		call	GetVariable
		and	al, 3
		mov	[bx], al
		call	GetVariable
		mov	dx, ax
		call	GetVariable
		shl	ax, 4
		add	dx, ax
		add	ax, ax
		add	ax, ax
		add	ax, dx		; AX = param3 +	param4 * 50h
		mov	[bx+1],	ax
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

loc_15350:				; DATA XREF: seg000:scriptFuncListo
		call	GetVariable
		and	al, 3
		mov	SomeGDCPlane, al
		call	GetVariable
		mov	dx, ax
		call	GetVariable
		shl	ax, 4
		add	dx, ax
		add	ax, ax
		add	ax, ax
		add	ax, dx		; AX = param2 +	param3 * 50h
		mov	word_1D2A2, ax
		jmp	ScriptMainLop
; ---------------------------------------------------------------------------

loc_15371:				; DATA XREF: seg000:scriptFuncListo
		push	si
		push	es
		push	ds
		pop	es
		assume es:dseg
		mov	di, offset byte_1D3C4
		mov	ax, 0A800h	; GVRAM	Plane 0
		mov	dx, word_1D170
		call	SomeGDCCopy19
		mov	ax, 0B000h	; GVRAM	Plane 1
		add	dx, 800h
		call	SomeGDCCopy19
		mov	ax, 0B800h	; GVRAM	Plane 2
		mov	dx, word_1D172
		call	SomeGDCCopy19
		mov	ax, 0E000h	; GVRAM	Plane 3
		add	dx, 800h
		call	SomeGDCCopy19
		xor	al, al
		out	0A6h, al	; Interrupt Controller #2, 8259A
		pop	es
		assume es:nothing
		pop	si
		jmp	ScriptMainLop

; =============== S U B	R O U T	I N E =======================================


SomeGDCCopy19	proc near		; CODE XREF: seg000:537Fp seg000:5389p ...
		push	ds
		mov	si, word_1D2A2
		mov	cl, SomeGDCPlane
		mov	ds, ax		; set Data Segment to address of Plane 0/1/2/3
		cmp	cl, 2
		jb	short loc_153BD
		mov	ds, dx
		xor	cl, cl

loc_153BD:				; CODE XREF: SomeGDCCopy19+Ej
		mov	al, cl
		out	0A6h, al	; GDC: set Draw	Access Mode Write for plane 0/1
		mov	al, 60h

loc_153C3:				; CODE XREF: SomeGDCCopy19+24j
		mov	cx, 6
		rep movsw		; copy 6 bytes,	then skip 68
		add	si, 44h
		dec	al
		jnz	short loc_153C3	; repeat 96 times
		pop	ds
		retn
SomeGDCCopy19	endp

; ---------------------------------------------------------------------------

loc_153D1:				; DATA XREF: seg000:scriptFuncListo
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		push	si
		push	es
		mov	ax, ds
		mov	es, ax
		assume es:dseg
		mov	di, offset byte_1B22E
		xor	si, si
		call	sub_153FB
		call	sub_15426
		mov	di, offset byte_1B2CE
		mov	si, 2
		call	sub_153FB
		call	sub_15426
		pop	es
		assume es:nothing
		pop	si
		xor	al, al
		out	0A6h, al	; Interrupt Controller #2, 8259A
		jmp	ScriptMainLop

; =============== S U B	R O U T	I N E =======================================


sub_153FB	proc near		; CODE XREF: seg000:53E0p seg000:53ECp
		push	di
		push	ds
		mov	ax, 0A800h	; GVRAM	Plane 0
		call	SomeGDCCopy20
		mov	ax, 0B000h	; GVRAM	Plane 1
		call	SomeGDCCopy20
		mov	ax, 0B800h	; GVRAM	Plane 2
		call	SomeGDCCopy20
		mov	ax, 0E000h	; GVRAM	Plane 3
		call	SomeGDCCopy20
		pop	ds
		pop	di
		retn
sub_153FB	endp


; =============== S U B	R O U T	I N E =======================================


SomeGDCCopy20	proc near		; CODE XREF: sub_153FB+5p sub_153FB+Bp ...
		push	si
		mov	ds, ax
		mov	cx, 10h

loc_1541E:				; CODE XREF: SomeGDCCopy20+Aj
		movsw
		add	si, 4Eh	; 'N'
		loop	loc_1541E
		pop	si
		retn
SomeGDCCopy20	endp


; =============== S U B	R O U T	I N E =======================================


sub_15426	proc near		; CODE XREF: seg000:53E3p seg000:53EFp
		mov	si, di
		add	di, 80h
		mov	cx, 10h

loc_1542F:				; CODE XREF: sub_15426+16j
		lodsw
		or	ax, [si+1Eh]
		or	ax, [si+3Eh]
		or	ax, [si+5Eh]
		not	ax
		stosw
		loop	loc_1542F
		retn
sub_15426	endp


; =============== S U B	R O U T	I N E =======================================


nullsub_1	proc near		; CODE XREF: sub_100EA+13p
					; sub_100EA+17p ...
		retn
nullsub_1	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: noreturn bp-based	frame

sub_15440	proc near		; CODE XREF: start+E7p

arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		jmp	short loc_1544F
; ---------------------------------------------------------------------------

loc_15445:				; CODE XREF: sub_15440+18j
		mov	bx, word_26326
		shl	bx, 1
		call	word ptr [bx-172Ah]

loc_1544F:				; CODE XREF: sub_15440+3j
		mov	ax, word_26326
		dec	word_26326
		or	ax, ax
		jnz	short loc_15445
		push	[bp+arg_0]
		call	sub_100EA
sub_15440	endp

; ---------------------------------------------------------------------------
		pop	cx
		pop	bp
		retn

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

cat_hdr_copy	proc near		; CODE XREF: LoadCatFile+E7p

dst		= dword	ptr  4
src		= dword	ptr  8
nBytes		= word ptr  0Ch

		push	bp
		mov	bp, sp
		push	si
		push	di
		mov	dx, ds
		les	di, [bp+dst]
		lds	si, [bp+src]
		mov	cx, [bp+nBytes]
		shr	cx, 1
		cld
		rep movsw
		jnb	short loc_1547B
		movsb

loc_1547B:				; CODE XREF: cat_hdr_copy+15j
		mov	ds, dx
		mov	dx, word ptr [bp+dst+2]
		mov	ax, word ptr [bp+dst]
		pop	di
		pop	si
		pop	bp
		retn
cat_hdr_copy	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_15487	proc near		; CODE XREF: OpenFile2+12p
					; sub_10298+B3p ...

arg_0		= dword	ptr  4
arg_4		= dword	ptr  8

		push	bp
		mov	bp, sp
		push	si
		push	di
		cld
		les	di, [bp+arg_4]
		mov	si, di
		xor	al, al
		mov	cx, 0FFFFh
		repne scasb
		not	cx
		push	ds
		mov	ax, es
		mov	ds, ax
		les	di, [bp+arg_0]
		rep movsb
		pop	ds
		mov	dx, word ptr [bp+arg_0+2]
		mov	ax, word ptr [bp+arg_0]
		pop	di
		pop	si
		pop	bp
		retn
sub_15487	endp

; ---------------------------------------------------------------------------
word_154B0	dw 0			; DATA XREF: sub_154BCr sub_154BC+1Dr	...
word_154B2	dw 0			; DATA XREF: sub_154BC+14w
					; sub_154BC+27w ...
word_154B4	dw 0			; DATA XREF: sub_154BC+4Cw
					; sub_1558F+19w ...
word_154B6	dw 0			; DATA XREF: sub_154BC+32r
					; sub_154BC:loc_1550Fr	...
word_154B8	dw 0			; DATA XREF: sub_1575B+1r
					; sub_1583B+13w
word_154BA	dw 0			; DATA XREF: sub_1575B+7r
					; sub_1583B+18w

; =============== S U B	R O U T	I N E =======================================


sub_154BC	proc near		; CODE XREF: sub_155EE+18p
		cmp	dx, cs:word_154B0
		jz	short loc_154FA
		mov	ds, dx
		mov	ds, word_18CB2
		cmp	word_18CB2, 0
		jz	short loc_154D7
		mov	cs:word_154B2, ds
		jmp	short loc_1550F
; ---------------------------------------------------------------------------

loc_154D7:				; CODE XREF: sub_154BC+12j
		mov	ax, ds
		cmp	ax, cs:word_154B0
		jz	short loc_154F5
		mov	ax, word_18CB8
		mov	cs:word_154B2, ax
		push	ds
		xor	ax, ax
		push	ax
		call	sub_1558F
		mov	ds, cs:word_154B6
		jmp	short loc_15518
; ---------------------------------------------------------------------------

loc_154F5:				; CODE XREF: sub_154BC+22j
		mov	dx, cs:word_154B0

loc_154FA:				; CODE XREF: sub_154BC+5j
		mov	cs:word_154B0, 0
		mov	cs:word_154B2, 0
		mov	cs:word_154B4, 0

loc_1550F:				; CODE XREF: sub_154BC+19j
		mov	ds, cs:word_154B6
		push	dx
		xor	ax, ax
		push	ax

loc_15518:				; CODE XREF: sub_154BC+37j
		call	sub_15968
		pop	ax
		pop	ax
		retn
sub_154BC	endp


; =============== S U B	R O U T	I N E =======================================


sub_1551E	proc near		; CODE XREF: sub_155EE:loc_1560Bp
		mov	ds, dx
		push	ds
		mov	es, word_18CB2
		mov	word_18CB2, 0
		mov	word_18CB8, es
		cmp	dx, cs:word_154B0
		jz	short loc_15564
		cmp	word ptr es:2, 0
		jnz	short loc_15564
		mov	ax, word_18CB0
		pop	bx
		push	es
		add	es:0, ax
		mov	cx, es
		add	dx, ax
		mov	es, dx
		cmp	word ptr es:2, 0
		jnz	short loc_1555D
		mov	es:8, cx
		jmp	short loc_15567
; ---------------------------------------------------------------------------

loc_1555D:				; CODE XREF: sub_1551E+36j
		mov	es:2, cx
		jmp	short loc_15567
; ---------------------------------------------------------------------------

loc_15564:				; CODE XREF: sub_1551E+16j
					; sub_1551E+1Ej
		call	sub_155B8

loc_15567:				; CODE XREF: sub_1551E+3Dj
					; sub_1551E+44j
		pop	es
		mov	ax, es
		add	ax, es:0
		mov	ds, ax
		cmp	word_18CB2, 0
		jz	short loc_15579
		retn
; ---------------------------------------------------------------------------

loc_15579:				; CODE XREF: sub_1551E+58j
		mov	ax, word_18CB0
		add	es:0, ax
		mov	ax, es
		mov	bx, ds
		add	bx, word_18CB0
		mov	es, bx
		mov	es:2, ax
sub_1551E	endp ; sp-analysis failed


; =============== S U B	R O U T	I N E =======================================


sub_1558F	proc near		; CODE XREF: sub_154BC+2Fp
					; sub_156DE+66p
		mov	bx, ds
		cmp	bx, word_18CB6
		jz	short loc_155B0
		mov	es, word_18CB6
		mov	ds, word_18CB4
		mov	word_18CB6, es
		mov	word ptr es:4, ds
		mov	cs:word_154B4, ds
		mov	ds, bx
		retn
; ---------------------------------------------------------------------------

loc_155B0:				; CODE XREF: sub_1558F+6j
		mov	cs:word_154B4, 0
		retn
sub_1558F	endp


; =============== S U B	R O U T	I N E =======================================


sub_155B8	proc near		; CODE XREF: sub_1551E:loc_15564p
		mov	ax, cs:word_154B4
		or	ax, ax
		jz	short loc_155E0
		mov	bx, ss
		cli
		mov	ss, ax
		mov	es, word ptr ss:6
		mov	word ptr ss:6, ds
		mov	word_18CB4, ss
		mov	ss, bx
		sti
		mov	word ptr es:4, ds
		mov	word_18CB6, es
		retn
; ---------------------------------------------------------------------------

loc_155E0:				; CODE XREF: sub_155B8+6j
		mov	cs:word_154B4, ds
		mov	word_18CB4, ds
		mov	word_18CB6, ds
		retn
sub_155B8	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_155EE	proc near		; CODE XREF: sub_10240+11p
					; sub_1575B+6Ep ...

arg_2		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		push	di
		mov	cs:word_154B6, ds
		mov	dx, [bp+arg_2]
		or	dx, dx
		jz	short loc_1560E
		cmp	dx, cs:word_154B2
		jnz	short loc_1560B
		call	sub_154BC
		jmp	short loc_1560E
; ---------------------------------------------------------------------------

loc_1560B:				; CODE XREF: sub_155EE+16j
		call	sub_1551E

loc_1560E:				; CODE XREF: sub_155EE+Fj
					; sub_155EE+1Bj
		mov	ds, cs:word_154B6
		pop	di
		pop	si
		pop	bp
		retn
sub_155EE	endp


; =============== S U B	R O U T	I N E =======================================


sub_15617	proc near		; CODE XREF: sub_156DE:loc_15733p
		push	ax
		mov	ds, cs:word_154B6
		xor	ax, ax
		push	ax
		push	ax
		call	sub_159A7
		pop	bx
		pop	bx
		and	ax, 0Fh
		jz	short loc_1563E
		mov	dx, 10h
		sub	dx, ax
		xor	ax, ax
		mov	ds, cs:word_154B6
		push	ax
		push	dx
		call	sub_159A7
		pop	bx
		pop	bx

loc_1563E:				; CODE XREF: sub_15617+12j
		pop	ax
		push	ax
		xor	bx, bx
		mov	bl, ah
		mov	cl, 4
		shr	bx, cl
		shl	ax, cl
		mov	ds, cs:word_154B6
		push	bx
		push	ax
		call	sub_159A7
		pop	bx
		pop	bx
		pop	bx
		cmp	ax, 0FFFFh
		jz	short loc_15674
		mov	cs:word_154B0, dx
		mov	cs:word_154B2, dx
		mov	ds, dx
		mov	word_18CB0, bx
		mov	word_18CB2, dx
		mov	ax, 4
		retn
; ---------------------------------------------------------------------------

loc_15674:				; CODE XREF: sub_15617+43j
		xor	ax, ax
		cwd
		retn
sub_15617	endp


; =============== S U B	R O U T	I N E =======================================


sub_15678	proc near		; CODE XREF: sub_156DE:loc_1572Ep
		push	ax
		xor	bx, bx
		mov	bl, ah
		mov	cl, 4
		shr	bx, cl
		shl	ax, cl
		mov	ds, cs:word_154B6
		push	bx
		push	ax
		call	sub_159A7
		pop	bx
		pop	bx
		pop	bx
		cmp	ax, 0FFFFh
		jz	short loc_156AD
		mov	cx, cs:word_154B2
		mov	cs:word_154B2, dx
		mov	ds, dx
		mov	word_18CB0, bx
		mov	word_18CB2, cx
		mov	ax, 4
		retn
; ---------------------------------------------------------------------------

loc_156AD:				; CODE XREF: sub_15678+1Bj
		xor	ax, ax
		cwd
		retn
sub_15678	endp


; =============== S U B	R O U T	I N E =======================================


sub_156B1	proc near		; CODE XREF: sub_156DE:loc_15738p
		mov	bx, dx
		sub	word_18CB0, ax
		add	dx, word_18CB0
		mov	ds, dx
		mov	word_18CB0, ax
		mov	word_18CB2, bx
		mov	bx, dx
		add	bx, word_18CB0
		mov	ds, bx
		mov	word_18CB2, dx
		mov	ax, 4
		retn
sub_156B1	endp

; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		xor	dx, dx
		mov	ax, [bp+4]
		jmp	short loc_156E7

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_156DE	proc near		; CODE XREF: sub_101F7+9p sub_1575B+Dp ...

arg_0		= word ptr  4
arg_2		= word ptr  6

		push	bp
		mov	bp, sp
		mov	dx, [bp+arg_2]
		mov	ax, [bp+arg_0]

loc_156E7:				; CODE XREF: seg000:56DCj
		push	si
		push	di
		mov	cs:word_154B6, ds
		mov	cx, ax
		or	cx, dx
		jz	short loc_15752
		add	ax, 13h
		adc	dx, 0
		jb	short loc_1573D
		test	dx, 0FFF0h
		jnz	short loc_1573D
		mov	cl, 4
		shr	ax, cl
		shl	dx, cl
		or	ah, dl
		mov	dx, cs:word_154B0
		or	dx, dx
		jz	short loc_15733
		mov	dx, cs:word_154B4
		or	dx, dx
		jz	short loc_1572E
		mov	bx, dx

loc_1571E:				; CODE XREF: sub_156DE+4Ej
		mov	ds, dx
		cmp	word_18CB0, ax
		jnb	short loc_15742
		mov	dx, word_18CB6
		cmp	dx, bx
		jnz	short loc_1571E

loc_1572E:				; CODE XREF: sub_156DE+3Cj
		call	sub_15678
		jmp	short loc_15752
; ---------------------------------------------------------------------------

loc_15733:				; CODE XREF: sub_156DE+33j
		call	sub_15617
		jmp	short loc_15752
; ---------------------------------------------------------------------------

loc_15738:				; CODE XREF: sub_156DE:loc_15742j
		call	sub_156B1
		jmp	short loc_15752
; ---------------------------------------------------------------------------

loc_1573D:				; CODE XREF: sub_156DE+1Cj
					; sub_156DE+22j
		xor	ax, ax
		cwd
		jmp	short loc_15752
; ---------------------------------------------------------------------------

loc_15742:				; CODE XREF: sub_156DE+46j
		ja	short loc_15738
		call	sub_1558F
		mov	bx, word_18CB8
		mov	word_18CB2, bx
		mov	ax, offset word_18CB4

loc_15752:				; CODE XREF: sub_156DE+14j
					; sub_156DE+53j ...
		mov	ds, cs:word_154B6
		pop	di
		pop	si
		pop	bp
		retn
sub_156DE	endp


; =============== S U B	R O U T	I N E =======================================


sub_1575B	proc near		; CODE XREF: sub_1583B:loc_15888p
		push	bx
		mov	si, cs:word_154B8
		push	si
		mov	si, cs:word_154BA
		push	si
		call	sub_156DE
		pop	bx
		pop	bx
		or	dx, dx
		jnz	short loc_15773
		pop	bx
		retn
; ---------------------------------------------------------------------------

loc_15773:				; CODE XREF: sub_1575B+14j
		pop	ds
		mov	es, dx
		push	es
		push	ds
		push	bx
		mov	dx, word_18CB0
		cld
		dec	dx
		mov	di, 4
		mov	si, di
		mov	cx, 6
		rep movsw
		or	dx, dx
		jz	short loc_157C4
		mov	ax, es
		inc	ax
		mov	es, ax
		assume es:nothing
		mov	ax, ds
		inc	ax
		mov	ds, ax
		assume ds:nothing

loc_15797:				; CODE XREF: sub_1575B+67j
		xor	di, di
		mov	si, di
		mov	cx, dx
		cmp	cx, 1000h
		jbe	short loc_157A6
		mov	cx, 1000h

loc_157A6:				; CODE XREF: sub_1575B+46j
		shl	cx, 1
		shl	cx, 1
		shl	cx, 1
		rep movsw
		sub	dx, 1000h
		jbe	short loc_157C4
		mov	ax, es
		add	ax, 1000h
		mov	es, ax
		assume es:seg000
		mov	ax, ds
		add	ax, 1000h
		mov	ds, ax
		assume ds:nothing
		jmp	short loc_15797
; ---------------------------------------------------------------------------

loc_157C4:				; CODE XREF: sub_1575B+30j
					; sub_1575B+57j
		mov	ds, cs:word_154B6
		assume ds:dseg
		call	sub_155EE
		pop	dx
		pop	dx
		pop	dx
		mov	ax, 4
		retn
sub_1575B	endp


; =============== S U B	R O U T	I N E =======================================


sub_157D3	proc near		; CODE XREF: sub_1583B:loc_15883p
		cmp	bx, cs:word_154B2
		jz	short loc_1581D
		mov	di, bx
		add	di, ax
		mov	es, di
		assume es:nothing
		mov	si, cx
		sub	si, ax
		mov	es:0, si
		mov	es:2, bx
		push	es
		push	ax
		mov	es, bx
		mov	es:0, ax
		mov	dx, bx
		add	dx, cx
		mov	es, dx
		cmp	word ptr es:2, 0
		jz	short loc_1580B
		mov	es:2, di
		jmp	short loc_15810
; ---------------------------------------------------------------------------

loc_1580B:				; CODE XREF: sub_157D3+2Fj
		mov	es:8, di

loc_15810:				; CODE XREF: sub_157D3+36j
		mov	si, bx
		call	sub_155EE
		pop	dx
		pop	dx
		mov	dx, si
		mov	ax, 4
		retn
; ---------------------------------------------------------------------------

loc_1581D:				; CODE XREF: sub_157D3+5j
		push	bx
		mov	es, bx
		mov	es:0, ax
		add	bx, ax
		push	bx
		xor	ax, ax
		push	ax
		call	sub_15968
		pop	dx
		pop	dx
		pop	dx
		mov	ax, 4
		retn
sub_157D3	endp

; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		xor	dx, dx
		jmp	short loc_15841

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1583B	proc near		; CODE XREF: sub_10207+Fp

arg_2		= word ptr  6
arg_4		= word ptr  8
arg_6		= word ptr  0Ah

		push	bp
		mov	bp, sp
		mov	dx, [bp+arg_6]

loc_15841:				; CODE XREF: seg000:5839j
		mov	ax, [bp+arg_4]
		mov	bx, [bp+arg_2]
		push	si
		push	di
		mov	cs:word_154B6, ds
		mov	cs:word_154B8, dx
		mov	cs:word_154BA, ax
		or	bx, bx
		jz	short loc_1588D
		mov	cx, ax
		or	cx, dx
		jz	short loc_15894
		add	ax, 13h
		adc	dx, 0
		mov	cl, 4
		shr	ax, cl
		shl	dx, cl
		or	ah, dl
		mov	es, bx
		mov	cx, es:0
		cmp	cx, ax
		jb	short loc_15888
		ja	short loc_15883
		mov	dx, bx
		mov	ax, 4
		jmp	short loc_1589E
; ---------------------------------------------------------------------------

loc_15883:				; CODE XREF: sub_1583B+3Fj
		call	sub_157D3
		jmp	short loc_1589E
; ---------------------------------------------------------------------------

loc_15888:				; CODE XREF: sub_1583B+3Dj
		call	sub_1575B
		jmp	short loc_1589E
; ---------------------------------------------------------------------------

loc_1588D:				; CODE XREF: sub_1583B+1Ej
		push	dx
		push	ax
		call	sub_156DE
		jmp	short loc_1589C
; ---------------------------------------------------------------------------

loc_15894:				; CODE XREF: sub_1583B+24j
		push	bx
		push	ax
		call	sub_155EE
		xor	ax, ax
		cwd

loc_1589C:				; CODE XREF: sub_1583B+57j
		pop	di
		pop	di

loc_1589E:				; CODE XREF: sub_1583B+46j
					; sub_1583B+4Bj ...
		mov	ds, cs:word_154B6
		pop	di
		pop	si
		pop	bp
		retn
sub_1583B	endp


; =============== S U B	R O U T	I N E =======================================


sub_158A7	proc far		; CODE XREF: sub_10298+32p
		pop	es
		push	cs
		push	es
		push	bp
		mov	bp, sp
		push	si
		push	di
		push	ds
		lds	si, [bp+6]
		les	di, [bp+0Ah]
		cld
		shr	cx, 1
		rep movsw
		adc	cx, cx
		rep movsb
		pop	ds
		pop	di
		pop	si
		pop	bp
		retf	8
sub_158A7	endp ; sp-analysis failed

; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		cmp	word_26326, 20h	; ' '
		jnz	short loc_158D5
		mov	ax, 1
		jmp	short loc_158E8
; ---------------------------------------------------------------------------

loc_158D5:				; CODE XREF: seg000:58CEj
		mov	bx, word_26326
		shl	bx, 1
		mov	ax, [bp+4]
		mov	[bx-172Ah], ax
		inc	word_26326
		xor	ax, ax

loc_158E8:				; CODE XREF: seg000:58D3j
		pop	bp
		retn

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_158EA	proc near		; CODE XREF: sub_15968+2Fp
					; sub_159A7+5Ap

arg_0		= word ptr  4
arg_2		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		push	di
		mov	ax, [bp+arg_2]
		inc	ax
		mov	si, ax
		sub	si, seg_18D29
		mov	ax, si
		add	ax, 3Fh	; '?'
		mov	cl, 6
		shr	ax, cl
		mov	si, ax
		cmp	si, word_26328
		jnz	short loc_1591C

loc_1590A:				; CODE XREF: sub_158EA+66j
		mov	ax, [bp+arg_2]
		mov	dx, [bp+arg_0]
		mov	word_18D33, dx
		mov	word_18D35, ax
		mov	ax, 1
		jmp	short loc_15962
; ---------------------------------------------------------------------------

loc_1591C:				; CODE XREF: sub_158EA+1Ej
		mov	cl, 6
		shl	si, cl
		mov	di, word_18D39
		mov	ax, si
		add	ax, seg_18D29
		cmp	ax, di
		jbe	short loc_15936
		mov	ax, di
		sub	ax, seg_18D29
		mov	si, ax

loc_15936:				; CODE XREF: sub_158EA+42j
		push	si
		push	seg_18D29
		call	sub_15A14
		pop	cx
		pop	cx
		mov	di, ax
		cmp	di, 0FFFFh
		jnz	short loc_15952
		mov	ax, si
		mov	cl, 6
		shr	ax, cl
		mov	word_26328, ax
		jmp	short loc_1590A
; ---------------------------------------------------------------------------

loc_15952:				; CODE XREF: sub_158EA+5Bj
		mov	ax, seg_18D29
		add	ax, di
		mov	word_18D37, 0
		mov	word_18D39, ax
		xor	ax, ax

loc_15962:				; CODE XREF: sub_158EA+30j
		pop	di
		pop	si
		pop	bp
		retn	4
sub_158EA	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_15968	proc near		; CODE XREF: sub_154BC:loc_15518p
					; sub_157D3+57p

arg_0		= word ptr  4
arg_2		= word ptr  6

		push	bp
		mov	bp, sp
		mov	cx, word_18D31
		mov	bx, word_18D2F
		mov	dx, [bp+arg_2]
		mov	ax, [bp+arg_0]
		call	sub_15A90
		jb	short loc_1599E
		mov	cx, word_18D39
		mov	bx, word_18D37
		mov	dx, [bp+arg_2]
		mov	ax, [bp+arg_0]
		call	sub_15A90
		ja	short loc_1599E
		push	[bp+arg_2]
		push	[bp+arg_0]
		call	sub_158EA
		or	ax, ax
		jnz	short loc_159A3

loc_1599E:				; CODE XREF: sub_15968+14j
					; sub_15968+27j
		mov	ax, 0FFFFh
		jmp	short loc_159A5
; ---------------------------------------------------------------------------

loc_159A3:				; CODE XREF: sub_15968+34j
		xor	ax, ax

loc_159A5:				; CODE XREF: sub_15968+39j
		pop	bp
		retn
sub_15968	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_159A7	proc near		; CODE XREF: sub_15617+Ap
					; sub_15617+22p ...

var_8		= word ptr -8
var_6		= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  4
arg_2		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 8
		mov	dx, word_18D35
		mov	ax, word_18D33
		mov	cx, [bp+arg_2]
		mov	bx, [bp+arg_0]
		call	near ptr sub_15A30
		mov	[bp+var_4], ax
		mov	[bp+var_2], dx
		mov	cx, word_18D31
		mov	bx, word_18D2F
		mov	ax, [bp+var_4]
		call	sub_15A90
		jb	short loc_159E6
		mov	cx, word_18D39
		mov	bx, word_18D37
		mov	dx, [bp+var_2]
		mov	ax, [bp+var_4]
		call	sub_15A90
		jbe	short loc_159EE

loc_159E6:				; CODE XREF: sub_159A7+2Aj
					; sub_159A7+61j
		mov	dx, 0FFFFh
		mov	ax, 0FFFFh
		jmp	short loc_15A10
; ---------------------------------------------------------------------------

loc_159EE:				; CODE XREF: sub_159A7+3Dj
		mov	ax, word_18D35
		mov	dx, word_18D33
		mov	[bp+var_8], dx
		mov	[bp+var_6], ax
		push	[bp+var_2]
		push	[bp+var_4]
		call	sub_158EA
		or	ax, ax
		jnz	short loc_15A0A
		jmp	short loc_159E6
; ---------------------------------------------------------------------------

loc_15A0A:				; CODE XREF: sub_159A7+5Fj
		mov	dx, [bp+var_6]
		mov	ax, [bp+var_8]

loc_15A10:				; CODE XREF: sub_159A7+45j
		mov	sp, bp
		pop	bp
		retn
sub_159A7	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_15A14	proc near		; CODE XREF: sub_158EA+51p

arg_0		= word ptr  4
arg_2		= word ptr  6

		push	bp
		mov	bp, sp
		mov	ah, 4Ah
		mov	bx, [bp+arg_2]
		mov	es, [bp+arg_0]
		int	21h		; DOS -	2+ - ADJUST MEMORY BLOCK SIZE (SETBLOCK)
					; ES = segment address of block	to change
					; BX = new size	in paragraphs
		jb	short loc_15A28
		mov	ax, 0FFFFh
		jmp	short loc_15A2E
; ---------------------------------------------------------------------------

loc_15A28:				; CODE XREF: sub_15A14+Dj
		push	bx
		push	ax
		call	ParseSomething
		pop	ax

loc_15A2E:				; CODE XREF: sub_15A14+12j
		pop	bp
		retn
sub_15A14	endp


; =============== S U B	R O U T	I N E =======================================


sub_15A30	proc far		; CODE XREF: sub_159A7+13p
		pop	es
		push	cs
		push	es
		or	cx, cx
		jge	short loc_15A43
		not	bx
		not	cx
		add	bx, 1
		adc	cx, 0
		jmp	short loc_15A72
; ---------------------------------------------------------------------------

loc_15A43:				; CODE XREF: sub_15A30+5j
					; sub_15A30+40j
		add	ax, bx
		jnb	short loc_15A4B
		add	dx, 1000h

loc_15A4B:				; CODE XREF: sub_15A30+15j
		mov	ch, cl
		mov	cl, 4
		shl	ch, cl
		add	dh, ch
		mov	ch, al
		shr	ax, cl
		add	dx, ax
		mov	al, ch
		and	ax, 0Fh
		retf
; ---------------------------------------------------------------------------
		pop	es
		push	cs
		push	es
		or	cx, cx
		jge	short loc_15A72
		not	bx
		not	cx
		add	bx, 1
		adc	cx, 0
		jmp	short loc_15A43
; ---------------------------------------------------------------------------

loc_15A72:				; CODE XREF: sub_15A30+11j
					; sub_15A30+34j
		sub	ax, bx
		jnb	short loc_15A7A
		sub	dx, 1000h

loc_15A7A:				; CODE XREF: sub_15A30+44j
		mov	bh, cl
		mov	cl, 4
		shl	bh, cl
		xor	bl, bl
		sub	dx, bx
		mov	ch, al
		shr	ax, cl
		add	dx, ax
		mov	al, ch
		and	ax, 0Fh
		retf
sub_15A30	endp ; sp-analysis failed


; =============== S U B	R O U T	I N E =======================================


sub_15A90	proc near		; CODE XREF: sub_15968+11p
					; sub_15968+24p ...
		push	cx
		mov	ch, al
		mov	cl, 4
		shr	ax, cl
		add	dx, ax
		mov	al, ch
		mov	ah, bl
		shr	bx, cl
		pop	cx
		add	cx, bx
		mov	bl, ah
		and	ax, 0Fh
		and	bx, 0Fh
		cmp	dx, cx
		jnz	short locret_15AB0
		cmp	ax, bx

locret_15AB0:				; CODE XREF: sub_15A90+1Cj
		retn
sub_15A90	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

ParseSomething	proc near		; CODE XREF: sub_15A14+16p

arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		push	si
		mov	si, [bp+arg_0]
		or	si, si
		jl	short loc_15AD1
		cmp	si, 58h
		jle	short loc_15AC4

loc_15AC1:				; CODE XREF: ParseSomething+29j
		mov	si, 57h

loc_15AC4:				; CODE XREF: ParseSomething+Ej
		mov	word_2632A, si
		mov	al, byte_2632C[si]
		cbw
		mov	si, ax
		jmp	short loc_15AE2
; ---------------------------------------------------------------------------

loc_15AD1:				; CODE XREF: ParseSomething+9j
		mov	ax, si
		neg	ax
		mov	si, ax
		cmp	si, '#'
		jg	short loc_15AC1
		mov	word_2632A, 0FFFFh

loc_15AE2:				; CODE XREF: ParseSomething+1Ej
		mov	word_18D2D, si
		mov	ax, 0FFFFh
		pop	si
		pop	bp
		retn	2
ParseSomething	endp

; ---------------------------------------------------------------------------
		align 4
seg000		ends

; ===========================================================================

; Segment type:	Regular
seg001		segment	byte public 'UNK' use16
		assume cs:seg001
		assume es:nothing, ss:nothing, ds:dseg,	fs:nothing, gs:nothing
byte_15AF0	db 130h	dup(0)		; DATA XREF: ReadSceneFile+1o
					; dseg:off_1E616o
		dw 0
		db    0
		db    0
		dw 0
		db    0
		db    0
		dw 0
		dw 0
		db    0
		db    0
		dw 0
		dw 0
		dw 0
		dw 0
		db    0
		db    0
		db    0
		db    0
byte_15C3A	db 2EB6h dup(0)		; DATA XREF: DoGFXThing+28o
word_18AF0	dw 0			; DATA XREF: LoadFile+9w WriteFile+9w	...
aSystem98Ver	db 'System-98 version 3.10',0Dh,0Ah ; DATA XREF: sub_1123C+68o
		db '(c) Copyright 1993,1994 four¥nine/Izuho Saruta. All rights reserv'
		db 'ed.',0Dh,0Ah
		db 0Ah
		db 'System requirements: 640KB RAM (with 460KB available), Keyboard.',0Dh
		db 0Ah,'$'
aNotEnoughMem	db 'Œ»Ý‚Ìƒƒ‚ƒŠó‹µ‚Å‚ÍƒVƒXƒeƒ€‚ðŽÀs‚Å‚«‚Ü‚¹‚ñ' ; DATA XREF: sub_112B2+69o
					; The system cannot run	with the current memory	situation.
		db 0Dh,0Ah,'$'
aMallocTooMuch	db '‹–—e”ÍˆÍ‚ð‰z‚¦‚Äƒƒ‚ƒŠ‚ðŽæ“¾‚µ‚Ü‚µ‚½',0Dh,0Ah,'$'
					; DATA XREF: sub_11D5E+45o
					; Acquired more	memory than allowed
aFileLoadErr	db 'ƒtƒ@ƒCƒ‹‚Ì“Ç‚Ýž‚Ý‚ÉŽ¸”s‚µ‚Ü‚µ‚½',0Dh,0Ah,'$'
					; DATA XREF: ReadSceneFile+4Do
					; LoadFile+9o ...
					; Failed to load file
aFileWriteErr	db 'ƒtƒ@ƒCƒ‹‚Ì‘‚«ž‚Ý‚ÉŽ¸”s‚µ‚Ü‚µ‚½',0Dh,0Ah,'$' ; DATA XREF: WriteFile+9o
					; Failed to write file
aExecUndefined	db '–¢’è‹`‚ÌƒVƒXƒeƒ€—\–ñ–½—ß‚ðŽÀs‚µ‚Ü‚µ‚½',0Dh,0Ah,'$'
					; DATA XREF: seg000:3757o
					; Executed undefined system reserved instruction
a03l1h5h	db 1Bh,')0',1Bh,'[>3l',1Bh,'[>1h',1Bh,'[>5h',1Bh,'*$'
					; DATA XREF: sub_11218+1Bo
a03l1l5l	db 1Bh,')0',1Bh,'[>3l',1Bh,'[>1l',1Bh,'[>5l',1Bh,'*$'
					; DATA XREF: sub_1123C+61o
					; sub_11D5E+3Eo ...
a5l		db 1Bh,'*',1Bh,'[>5l$'  ; DATA XREF: RestoreInts+51o
aDriveNotMounted db ' drive is not mounted.',0
		db 0Eh dup(0)
seg001		ends

; ===========================================================================

; Segment type:	Pure data
dseg		segment	para public 'DATA' use16
		assume cs:dseg
word_18CB0	dw 0			; DATA XREF: sub_1551E+20r
					; sub_1551E:loc_15579r	...
word_18CB2	dw 0			; DATA XREF: sub_154BC+9r sub_154BC+Dr ...
word_18CB4	dw 7554h		; DATA XREF: sub_1558F+Cr
					; sub_155B8+17w ...
word_18CB6	dw 6272h		; DATA XREF: sub_1558F+2r sub_1558F+8r ...
word_18CB8	dw 206Fh		; DATA XREF: sub_154BC+24r
					; sub_1551E+Dw	...
		db 'C++ - Copyright 1990 Borland Intl.',0
		db 'Divide error',0Dh,0Ah
unk_18CEB	db  41h	; A		; DATA XREF: start+1E1o
		db 'bnormal program termination',0Dh,0Ah
OldIntVec00	dd 0			; DATA XREF: SaveIntVects+6w
					; RevertIntVects+4r ...
OldIntVec04	dd 0			; DATA XREF: SaveIntVects+13w
					; RevertIntVects+Fr ...
OldIntVec05	dd 0			; DATA XREF: SaveIntVects+20w
					; RevertIntVects+1Ar ...
OldIntVec06	dd 0			; DATA XREF: SaveIntVects+2Dw
					; RevertIntVects+25r ...
word_18D19	dw 0			; DATA XREF: start+DFr
word_18D1B	dw 0			; DATA XREF: start+DBr
word_18D1D	dw 0			; DATA XREF: start+D7r
word_18D1F	dw 0			; DATA XREF: start+D3r
word_18D21	dw 0			; DATA XREF: start+CFr
dword_18D23	dd 0			; DATA XREF: start+28r	start+43w ...
word_18D27	dw 0			; DATA XREF: start+52w
seg_18D29	dw 0			; DATA XREF: start+19w
					; start:loc_10083r ...
word_18D2B	dw 0			; DATA XREF: start+16w
word_18D2D	dw 0			; DATA XREF: ParseSomething:loc_15AE2w
word_18D2F	dw 0			; DATA XREF: sub_15968+7r
					; sub_159A7+20r
word_18D31	dw 0			; DATA XREF: start+7Bw	sub_15968+3r ...
word_18D33	dw 0			; DATA XREF: sub_158EA+26w
					; sub_159A7+Ar	...
word_18D35	dw 0			; DATA XREF: start+7Fw	sub_158EA+2Aw ...
word_18D37	dw 0			; DATA XREF: sub_158EA+6Dw
					; sub_15968+1Ar ...
word_18D39	dw 0			; DATA XREF: start+21w	sub_158EA+36r ...
algn_18D3B:
		align 2
word_18D3C	dw 0			; DATA XREF: sub_10298+9r
					; sub_10298+179r ...
dword_18D3E	dd 0			; DATA XREF: sub_10298+60r
					; sub_10298+83r ...
a_cat		db '*.Cat',0
aLib		db 'Lib',0
byte_18D4C	db 0			; DATA XREF: fopen+Fr fopen+ACw ...
byte_18D4D	db 93h dup(0)
word_18DE0	dw 0			; DATA XREF: LoadPIImage2+35r
					; LoadPIImage2+8Dr ...
word_18DE2	dw 0			; DATA XREF: LoadPIImage2+39r
word_18DE4	dw 0			; DATA XREF: DoPalThing+14r
					; LoadPIImage2+55w ...
word_18DE6	dw 0			; DATA XREF: DoPalThing+1Er
					; LoadPIImage2+9Dw
word_18DE8	dw 0			; DATA XREF: LoadPIImage2+97w
					; DoGFXThing:loc_13128r ...
word_18DEA	dw 0			; DATA XREF: LoadPIImage2+A0w
					; DoGFXThing+1BCw ...
word_18DEC	dw 0			; DATA XREF: LoadPIImage2+78w
					; LoadPIImage2+1EAr ...
word_18DEE	dw 0			; DATA XREF: LoadPIImage2+4Aw
					; DoGFXThing+3Br ...
word_18DF0	dw 0			; DATA XREF: LoadPIImage2+32w
					; ReadFullFile2+10r ...
word_18DF2	dw 0			; DATA XREF: LoadPIImage2+73w
					; DoGFXThing+1CAr ...
word_18DF4	dw 0			; DATA XREF: LoadPIImage2+7Ew
					; LoadPIImage2+1F3r ...
word_18DF6	dw 0			; DATA XREF: ReadFullFile2+Ar
		dw 0
byte_18DFA	db 0Eh dup(0)		; DATA XREF: LoadPIImage2+70o
					; LoadPIImage2+B7o ...
word_18E08	dw 0			; DATA XREF: sub_10C1A+18r
					; sub_10C45+11r
word_18E0A	dw 0			; DATA XREF: sub_10C1A+1Br
					; sub_10C45+14r
byte_18E0C	db 0Eh dup(0)		; DATA XREF: CopyFilename+Co
byte_18E1A	db 0Fh			; DATA XREF: sub_10F92+Dr seg000:275Fw
		align 2
		dw offset byte_18E2C
		dw offset byte_192AC
		dw offset byte_1972C
		dw offset byte_19BAC
		dw offset byte_1A02C
		dw offset byte_1A4AC
		dw offset byte_1A92C
		dw offset byte_1ADAC
byte_18E2C	db 3AEh	dup(0)		; DATA XREF: dseg:016Co
byte_191DA	db 0			; DATA XREF: seg000:1685r
		db    0
		db    0
byte_191DD	db 0			; DATA XREF: seg000:168Dr
		db    0
byte_191DF	db 0			; DATA XREF: seg000:1698r
byte_191E0	db 0			; DATA XREF: seg000:16A2r
byte_191E1	db 0			; DATA XREF: seg000:15B8r
byte_191E2	db 0			; DATA XREF: seg000:15D8r seg000:16ADr
byte_191E3	db 0C9h	dup(0)		; DATA XREF: seg000:15EBr seg000:16B7r
byte_192AC	db 480h	dup(0)		; DATA XREF: dseg:016Co
byte_1972C	db 480h	dup(0)		; DATA XREF: dseg:016Co
byte_19BAC	db 0EAh	dup(0)		; DATA XREF: dseg:016Co
		dw 0
		dw 0
		db 16h dup(0)
byte_19CB0	db 286h	dup(0)		; DATA XREF: SomeGDCCopy10+1Do
					; SomeGDCCopy10+2Co
		db 0
		align 2
		dw 0
		dw 0
		dw 0
		dw 0
		dw 0
		db 0
		db 0
		dw 0
		dw 0
		dw 0
		dw 0
		dw 0
		dw 0
		db 0
		db    0
		db    0
		db    0
		dw 0
		dw 0
		dw 0
		db 50h dup(0)
		dd 0
		dw 0
		dw 0
		dw 0
		dw 0
		db 76h dup(0)
byte_1A02C	db 480h	dup(0)		; DATA XREF: dseg:016Co
byte_1A4AC	db 3ACh	dup(0)		; DATA XREF: dseg:016Co
byte_1A858	db 0D4h	dup(0)		; DATA XREF: SomeGDCCopy10+4o
byte_1A92C	db 2B0h	dup(0)		; DATA XREF: dseg:016Co
byte_1ABDC	db 1D0h	dup(0)		; DATA XREF: SomeGDCCopy9+4o
byte_1ADAC	db 480h	dup(0)		; DATA XREF: dseg:016Co
off_1B22C	dw offset byte_1B22E	; DATA XREF: sub_11740+4Br
					; seg000:2AE2w
byte_1B22E	db 80h dup(0FFh)	; DATA XREF: seg000:2ADFo seg000:53DBo ...
		db 20h dup(0)
byte_1B2CE	db 0A0h	dup(0)		; DATA XREF: seg000:53E6o
ScrStringBuf	db 0FA0h dup(0)		; DATA XREF: GetStringPtr+11o
					; seg000:276Co
ScrBufferXY	dw 400 dup(0)		; DATA XREF: seg000:39EBo seg000:3A11o ...
ScrVariables1	dw 1F4h	dup(0)		; DATA XREF: GetVarPtr+7o seg000:2790o ...
ScrVariables2	dw 20Ch	dup(0)		; DATA XREF: seg000:3A31o seg000:3A6Do
ScrVariablesL	dd 0Ah dup(0)		; DATA XREF: GetLVarPtr+Do
					; seg000:loc_1279Eo
word_1CE56	dw 0			; DATA XREF: sub_112B2+60w
					; sub_11D5E+4r	...
word_1CE58	dw 0			; DATA XREF: sub_112B2+5Dw sub_11D5Er	...
byte_1CE5A	db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0
					; DATA XREF: GetScrBufLine+Do
					; seg000:45BFo	...
		db 1, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0
		db 2, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0
		db 3, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0
		db 4, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0
		db 5, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0
		db 6, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0
		db 7, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0
		db 8, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0
		db 9, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0
		db 0Ah,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0
		db 0Bh,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0
		db 0Ch,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0
		db 0Dh,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0
		db 0Eh,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0
		db 0Fh,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0
word_1CFDA	dw 0			; DATA XREF: sub_1123C+Fo
					; ReadSceneFile+4r
MusicMode_CfgPtr dw 0			; DATA XREF: SetupInt0A_24+10r
		db    0
		db    0
		db    0
		db    0
byte_1CFE2	db 7Fh dup(0)		; DATA XREF: sub_1123C+Co
byte_1D061	db 0			; DATA XREF: sub_1123C+12w
					; sub_1123C:loc_1126Ar	...
PalColLockMask	dw 0			; DATA XREF: SetupInt0A_24+Dw
					; SetPalToWhite+5r ...
PalCurrent	db 30h dup(0)		; DATA XREF: DoPalThing+Do
					; seg000:42AAw	...
PalTarget	db 30h dup(0)		; DATA XREF: UploadPalette+2o
					; SetPalToWhite:loc_124F2o ...
scrStackPtr	dw offset scrStack	; DATA XREF: seg000:3D8Fr seg000:3D97w ...
scrStack	db 10h dup(0)		; DATA XREF: dseg:scrStackPtro
i2sTextBuf	db 1Eh dup(0)		; DATA XREF: Int2Str_Short+4w
					; Int2Str_Long+4w ...
i2sTextBufEnd	dw 0			; DATA XREF: Int2Str_ShiftBuf+1o
byte_1D0F6	db 0			; DATA XREF: sub_11FBD+3w sub_11FE3+3w ...
		align 2
word_1D0F8	dw 0			; DATA XREF: sub_11FBD+Aw sub_11FE3+9w ...
word_1D0FA	dw 0			; DATA XREF: sub_11FBD+11w
					; sub_11FE3+Fw	...
word_1D0FC	dw 0			; DATA XREF: scrGFXThing1+1Aw
					; DoGFXThing2+2r ...
word_1D0FE	dw 0			; DATA XREF: sub_11FBD+18w
					; sub_11FE3+15w ...
word_1D100	dw 0			; DATA XREF: sub_11FBD+1Fw
					; sub_11FE3+1Bw ...
byte_1D102	db 0			; DATA XREF: DoGFXThing2+38r
					; DoGFXThing2:loc_1214Fr ...
byte_1D103	db 0			; DATA XREF: seg000:2005w seg000:201Dw ...
word_1D104	dw 0			; DATA XREF: seg000:200Cw seg000:2023w ...
word_1D106	dw 0			; DATA XREF: seg000:2013w seg000:2029w ...
word_1D108	dw 0			; DATA XREF: scrGFXThing1+2Fw
					; DoGFXThing2+46r ...
word_1D10A	dw 0			; DATA XREF: sub_1202D+Aw sub_12045+9w ...
word_1D10C	dw 0			; DATA XREF: sub_1202D+11w
					; sub_12045+Fw	...
word_1D10E	dw 0			; DATA XREF: scrGFXThing1+44w
					; DoGFXThing2+C0r ...
byte_1D110	db 0			; DATA XREF: sub_1202D+3w sub_12045+3w ...
		align 2
DiskLetter	db 0			; DATA XREF: SetupInt0A_24+79w
					; LoadFile+16r	...
byte_1D113	db 0			; DATA XREF: SetupInt0A_24+86w
					; LoadFile+21r	...
FileBufSize	dw 0			; DATA XREF: LoadFile+96r
					; WriteFile:loc_11987r	...
FileLoadDstPtr	dd 0			; DATA XREF: LoadFile+9Er
					; WriteFile+47r ...
FileDiskDrive	dw 0			; DATA XREF: LoadFile+1Bw LoadFile+30w ...
strdup_buffer	db 4Eh dup(0)		; DATA XREF: strdup_fn+Bo
SceneData	dd 0			; DATA XREF: sub_110BC+15r
					; sub_112B2+1Bw ...
seg_1D16E	dw 0			; DATA XREF: sub_112B2+38w
					; DoGFXThing2+6r ...
word_1D170	dw 0			; DATA XREF: sub_112B2+28w
					; scrGFXThing1+4Ar ...
word_1D172	dw 0			; DATA XREF: sub_112B2+30w
					; scrGFXThing1+5Er ...
seg_1D174	dw 0			; DATA XREF: LoadPIImage2+6w
					; LoadPIImage2:loc_12BF5r
word_1D176	dw 0			; DATA XREF: LoadPIImage2+1w
					; ReadFullFile2+22r ...
byte_1D178	db 0			; DATA XREF: seg000:loc_125BBr
					; seg000:25C6r	...
byte_1D179	db 0			; DATA XREF: seg000:25BFr seg000:25CAr ...
byte_1D17A	db 0			; DATA XREF: PrintTextSomething+6r
					; seg000:266Dr	...
		align 2
word_1D17C	dw 0			; DATA XREF: sub_12648r seg000:3832w
word_1D17E	dw 0			; DATA XREF: seg000:loc_125D6r
					; seg000:loc_12677r ...
word_1D180	dw 0			; DATA XREF: PrintTextSomethingw
					; PrintTextSomething+Dw ...
chrBufPtr	dd characterBuffer	; DATA XREF: GetChrData+4r
characterBuffer	db 20h dup(0)		; DATA XREF: sub_1261F+19o
					; dseg:chrBufPtro
byte_1D1A6	db 0			; DATA XREF: seg000:1AF8r
					; sub_126F1:loc_1272Bw	...
byte_1D1A7	db 0			; DATA XREF: sub_11B12+Ar
					; sub_11B12+25w ...
word_1D1A8	dw 4			; DATA XREF: sub_11B12+1Fw
					; sub_11B12+46w
word_1D1AA	dw 0			; DATA XREF: sub_126F1+1Br
					; seg000:457Ew
word_1D1AC	dw 0			; DATA XREF: sub_11B12+30o
					; sub_126F1+27r ...
word_1D1AE	dw 0			; DATA XREF: sub_11B12+4r sub_126F1w ...
word_1D1B0	dw 7721h, 4		; DATA XREF: sub_11B12+11o
					; sub_11B12+40o ...
		dw 7722h, 4
		dw 7723h, 4
		dw 7724h, 4
		dw 7725h, 4
		dw 7726h, 4
		dw 7727h, 4
		dw 7728h, 4
		db    0
		db    0
CallMusicDriver	dw 0			; DATA XREF: SetupInt0A_24:loc_113C6w
					; seg000:478Dr	...
MusicMode	db 0			; DATA XREF: SetupInt0A_24+18w
					; seg000:477Dr	...
					; 0 = none, 1 =	OPN, 2 = OPNA, 3 = GS MIDI
scrCmpResult	db 0			; DATA XREF: seg000:sCompareVarsw
					; seg000:3CB3w	...
portA4State	db 0			; DATA XREF: seg000:3F26w seg000:3F2Fr ...
OldIntVec24	dd 0			; DATA XREF: SetupInt0A_24+4Fw
					; RestoreInts+35r ...
OldIntVec0A	dd 0			; DATA XREF: SetupInt0A_24+2Ew
					; RestoreInts+22r ...
scrLoopCounter	dw 0			; DATA XREF: seg000:1AEFw seg000:37DEw ...
OldIntVec15	dd 0			; DATA XREF: RestoreInts+2Br
					; SetupInt15+6w ...
word_1D1E5	dw 0			; DATA XREF: sub_11503+Dr seg000:4631w
word_1D1E7	dw 0			; DATA XREF: sub_11503:loc_1152Er
					; seg000:4638w	...
word_1D1E9	dw 0			; DATA XREF: sub_11503:loc_1151Cr
					; seg000:4677w
word_1D1EB	dw 0			; DATA XREF: sub_11503+22r
					; seg000:467Ew
dword_1D1ED	dd 0			; DATA XREF: sub_11716r seg000:4643w ...
word_1D1F1	dw 0			; DATA XREF: sub_11503+43r
					; seg000:4652w	...
byte_1D1F3	db 0			; DATA XREF: sub_110BC:ScriptMainLopr
					; sub_11503+35w ...
byte_1D1F4	db 0			; DATA XREF: SetupInt15+1Cw
					; sub_11503+1w	...
byte_1D1F5	db 0			; DATA XREF: SetupInt15+1Fw
					; sub_11503+6r	...
byte_1D1F6	db 0			; DATA XREF: sub_11503+11r
					; sub_11716+1Fw ...
byte_1D1F7	db 0			; DATA XREF: sub_11716:loc_1172Br
					; sub_11716+24w ...
byte_1D1F8	db 0			; DATA XREF: SetupInt15+22w
byte_1D1F9	db 0			; DATA XREF: SetupInt15+25w
					; sub_11503+2Fr ...
byte_1D1FA	db 0			; DATA XREF: seg000:15C0w seg000:15E0w ...
byte_1D1FB	db 0			; DATA XREF: seg000:15D5w seg000:15FAw ...
byte_1D1FC	db 0			; DATA XREF: seg000:15C7w seg000:15E7w ...
byte_1D1FD	db 0			; DATA XREF: seg000:15CEw seg000:15F3w ...
word_1D1FE	dw 0			; DATA XREF: SetupInt15+28w
					; seg000:1590w	...
word_1D200	dw 0			; DATA XREF: SetupInt15+2Bw
					; seg000:15B1w	...
word_1D202	dw 0			; DATA XREF: SetupInt15+2Ew
					; sub_11503+1Dr ...
word_1D204	dw 0			; DATA XREF: SetupInt15+34w
					; sub_11503+26r ...
word_1D206	dw 0			; DATA XREF: SetupInt15+3Aw
					; seg000:loc_1161Fr ...
word_1D208	dw 0			; DATA XREF: SetupInt15+3Dw
					; seg000:loc_11655r ...
word_1D20A	dw 0			; DATA XREF: SetupInt15+40w
					; seg000:loc_11628r ...
word_1D20C	dw 0			; DATA XREF: SetupInt15+46w
					; seg000:loc_1165Er ...
byte_1D20E	db 0Fh,	0Fh, 0Ch, 0Dh, 0Dh, 0Dh, 0Dh, 0Dh, 0Dh,	0Dh, 0Eh
					; DATA XREF: sub_14C78o sub_14D28o ...
		db 0Fh,	0Fh, 0F8h, 0D8h, 18h, 0D8h, 0D8h, 0D8h,	0D8h, 0D8h
		db 0D8h, 0D8h, 18h, 0F8h, 0F8h,	0FFh, 0FFh, 0, 0FFh, 0FFh
		db 0FFh, 0, 0FFh, 0FFh,	0, 7, 7, 6, 6, 6, 6, 6,	6, 7, 7
		db 0, 0, 0, 0E0h, 0E0h,	60h, 60h, 60h, 60h, 60h, 60h, 0E0h
		db 0E0h, 0, 0, 0, 0FFh,	0FFh, 0, 0, 0FFh, 0FFh,	0, 0, 0
		db 7, 4, 4, 4, 4, 4, 4,	4, 5, 6, 0, 0, 0, 0C0h,	0, 40h
		db 40h,	40h, 40h, 40h, 40h, 0C0h, 0, 0,	0, 0, 0FFh, 0
		db 0, 0, 0FFh, 0, 0, 0,	0, 7, 4, 4, 4, 4, 4, 4,	4, 5, 6
		db 0, 0, 0, 0C0h, 0, 40h, 40h, 40h, 40h, 40h, 40h, 0C0h
		db 0, 0, 0, 0, 0FFh, 0,	0, 0, 0FFh, 0, 0, 0
unk_1D29A	db    2			; DATA XREF: sub_14BA9+2r
		db    5
word_1D29C	dw 0			; DATA XREF: seg000:4B32w seg000:4B47w ...
word_1D29E	dw 0			; DATA XREF: seg000:4B3Bw seg000:4B53w ...
word_1D2A0	dw 0			; DATA XREF: seg000:4B41w seg000:4B5Cw ...
word_1D2A2	dw 500Eh		; DATA XREF: SomeGDCCopy1+2Cr
					; SomeGDCCopy3+1r ...
byte_1D2A4	db 120h	dup(0)		; DATA XREF: sub_1282A+11o
					; seg000:51FAo	...
byte_1D3C4	db 1200h dup(0)		; DATA XREF: seg000:2A44o seg000:5375o
SomeGDCPlane	db 0			; DATA XREF: SomeGDCCopy1+35r
					; SomeGDCCopy1+3Er ...
		align 2
byte_1E5C6	db 0			; DATA XREF: LoadFile+58w sub_119E2+Cr ...
byte_1E5C7	db 0			; DATA XREF: sub_119E2+Fw
					; sub_11A19+2Er
word_1E5C8	dw 1			; DATA XREF: sub_11B5Cw sub_11B5C+3Bw	...
SceneData2	dw 0BC00h		; DATA XREF: sub_11B5C+7r
					; sub_11B5C+3Ew ...
bitMaskLUT	db 80h,	40h, 20h, 10h, 08h, 04h, 02h, 01h ; DATA XREF: seg000:41A2r
aInsertDiskX	db 1Bh,'*',1Bh,'=+.ƒhƒ‰ƒCƒu‚Q‚É‚`ƒfƒBƒXƒN‚ðƒZƒbƒg‚µ‚ÄƒNƒŠƒbƒN‚µ‚Ä‰º‚³‚¢$'
					; DATA XREF: LoadFile+63o
		db    0
textFillMode	dw 0			; DATA XREF: doTextFill+1Fr
					; seg000:4493w	...
off_1E612	dd byte_1E61E		; DATA XREF: sub_1261F+3r sub_126B8+1r
off_1E616	dd byte_15AF0		; DATA XREF: sub_117B8+Cr sub_117F8+Cr
word_1E61A	dw 0			; DATA XREF: sub_117B8+4w sub_117F8+8r
word_1E61C	dw 0			; DATA XREF: sub_117B8+8w sub_117F8+4r
byte_1E61E	db 452h	dup(0)		; DATA XREF: dseg:off_1E612o
byte_1EA70	db 78AEh dup(0)		; DATA XREF: SomeGDCCopy8+4o
off_2631E	dw offset nullsub_1	; DATA XREF: sub_100EA+13r
off_26320	dw offset nullsub_1	; DATA XREF: sub_100EA+17r
off_26322	dw offset nullsub_1	; DATA XREF: sub_100EA+1Br
word_26324	dw 1000h		; DATA XREF: start+5Ar	start+67w ...
word_26326	dw 0			; DATA XREF: sub_15440:loc_15445r
					; sub_15440:loc_1544Fr	...
word_26328	dw 0			; DATA XREF: sub_158EA+1Ar
					; sub_158EA+63w
word_2632A	dw 0			; DATA XREF: ParseSomething:loc_15AC4w
					; ParseSomething+2Bw
byte_2632C	db 00h			; 0 ; DATA XREF: ParseSomething+17r
		db 13h			; 1
		db 02h			; 2
		db 02h			; 3
		db 04h			; 4
		db 05h			; 5
		db 06h			; 6
		db 08h			; 7
		db 08h			; 8
		db 08h			; 9
		db 14h			; 0Ah
		db 15h			; 0Bh
		db 05h			; 0Ch
		db 13h			; 0Dh
		db 0FFh			; 0Eh
		db 16h			; 0Fh
		db 05h			; 10h
		db 11h			; 11h
		db 02h			; 12h
		db 0FFh			; 13h
		db 0FFh			; 14h
		db 0FFh			; 15h
		db 0FFh			; 16h
		db 0FFh			; 17h
		db 0FFh			; 18h
		db 0FFh			; 19h
		db 0FFh			; 1Ah
		db 0FFh			; 1Bh
		db 0FFh			; 1Ch
		db 0FFh			; 1Dh
		db 0FFh			; 1Eh
		db 0FFh			; 1Fh
		db 05h			; 20h
		db 05h			; 21h
		db 0FFh			; 22h
		db 0FFh			; 23h
		db 0FFh			; 24h
		db 0FFh			; 25h
		db 0FFh			; 26h
		db 0FFh			; 27h
		db 0FFh			; 28h
		db 0FFh			; 29h
		db 0FFh			; 2Ah
		db 0FFh			; 2Bh
		db 0FFh			; 2Ch
		db 0FFh			; 2Dh
		db 0FFh			; 2Eh
		db 0FFh			; 2Fh
		db 0FFh			; 30h
		db 0FFh			; 31h
		db 0Fh			; 32h
		db 0FFh			; 33h
		db 23h			; 34h
		db 02h			; 35h
		db 0FFh			; 36h
		db 0Fh			; 37h
		db 0FFh			; 38h
		db 0FFh			; 39h
		db 0FFh			; 3Ah
		db 0FFh			; 3Bh
		db 13h			; 3Ch
		db 0FFh			; 3Dh
		db 0FFh			; 3Eh
		db 02h			; 3Fh
		db 02h			; 40h
		db 05h			; 41h
		db 0Fh			; 42h
		db 02h			; 43h
		db 0FFh			; 44h
		db 0FFh			; 45h
		db 0FFh			; 46h
		db 13h			; 47h
		db 0FFh			; 48h
		db 0FFh			; 49h
		db 0FFh			; 4Ah
		db 0FFh			; 4Bh
		db 0FFh			; 4Ch
		db 0FFh			; 4Dh
		db 0FFh			; 4Eh
		db 0FFh			; 4Fh
		db 23h			; 50h
		db 0FFh			; 51h
		db 0FFh			; 52h
		db 0FFh			; 53h
		db 0FFh			; 54h
		db 23h			; 55h
		db 0FFh			; 56h
		db 13h			; 57h
		db 0FFh			; 58h
		db    ?	;
nameTable	db 1000h dup(?)		; DATA XREF: start+A3o	ReadDecompr+90o ...
comprBuffer	db 200h	dup(?)		; DATA XREF: ReadDecompr+34o
					; ReadDecompr+40o ...
		db 40h dup(?)
byte_275C6	db 0Ah dup(?)		; DATA XREF: start+A6o
dseg		ends

; ===========================================================================

; Segment type:	Uninitialized
seg003		segment	byte stack 'STACK' use16
		assume cs:seg003
		assume es:nothing, ss:nothing, ds:dseg,	fs:nothing, gs:nothing
byte_275D0	db 80h dup(?)
seg003		ends


		end start
