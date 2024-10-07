; Input	MD5   :	B8DB056C46146B356D22505D9B3D4598
; Input	CRC32 :	89B45536

; File Name   :	D:\MIME.EXE
; Format      :	MS-DOS executable (EXE)
; Base Address:	1000h Range: 10000h-2B3F0h Loaded length: 19B60h
; Entry	Point :	1000:0

		.686p
		.mmx
		.model large

; ===========================================================================

; Segment type:	Pure code
seg000		segment	byte public 'CODE' use16
		assume cs:seg000
		assume es:nothing, ss:seg009, ds:nothing, fs:nothing, gs:nothing

; =============== S U B	R O U T	I N E =======================================


		public start
start		proc near
		mov	dx, seg	dseg
		mov	cs:seg_10266, dx
		mov	ah, 30h
		int	21h		; DOS -	GET DOS	VERSION
					; Return: AL = major version number (00h for DOS 1.x)
		mov	bp, ds:2
		mov	bx, ds:2Ch
		mov	ds, dx
		assume ds:dseg
		mov	word_1DD40, ax
		mov	word_1DD3E, es
		mov	word_1DD3A, bx
		mov	word_1DD50, bp
		call	SetupIntVects
		mov	ax, word_1DD3A
		mov	es, ax
		xor	ax, ax
		mov	bx, ax
		mov	di, ax
		mov	cx, 7FFFh
		cld

loc_10037:				; CODE XREF: start+3Fj
		repne scasb
		jcxz	short loc_1007E
		inc	bx
		cmp	es:[di], al
		jnz	short loc_10037
		or	ch, 80h
		neg	cx
		mov	word_1DD38, cx
		mov	cx, 2
		shl	bx, cl
		add	bx, 10h
		and	bx, 0FFF0h
		mov	word_1DD3C, bx
		mov	dx, ss
		sub	bp, dx
		mov	di, seg	dseg
		mov	es, di
		assume es:dseg
		mov	di, es:word_29A46
		cmp	di, 200h
		jnb	short loc_10075
		mov	di, 200h
		mov	es:word_29A46, di

loc_10075:				; CODE XREF: start+6Bj
		mov	cl, 4
		shr	di, cl
		inc	di
		cmp	bp, di
		jnb	short loc_10083

loc_1007E:				; CODE XREF: start+39j
		nop
		push	cs
		call	near ptr sub_10A1E

loc_10083:				; CODE XREF: start+7Cj
		mov	bx, di
		add	bx, dx
		mov	word_1DD48, bx
		mov	word_1DD4C, bx
		mov	ax, word_1DD3E
		sub	bx, ax
		mov	es, ax
		assume es:nothing
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
		sti
		mov	ax, seg	dseg
		mov	es, ax
		assume es:dseg
		mov	es:word_29A46, di
		xor	ax, ax
		mov	es, cs:seg_10266
		assume es:nothing
		mov	di, offset word_29B5A
		mov	cx, offset byte_29BE8
		sub	cx, di
		cld
		rep stosb
		cmp	word_299C0, 14h
		jbe	short loc_10110
		cmp	byte ptr word_1DD40, 3
		jb	short loc_10110
		ja	short loc_100D7
		cmp	byte ptr word_1DD40+1, 1Eh
		jb	short loc_10110

loc_100D7:				; CODE XREF: start+CEj
		mov	ax, 5801h
		mov	bx, 2
		int	21h		; DOS -	3+ - GET/SET MEMORY ALLOCATION STRATEGY
					; AL = function	code: set allocation strategy
		jb	short loc_1010B
		mov	ah, 67h
		mov	bx, word_299C0
		int	21h		; DOS -	3.3+ - SET HANDLE COUNT
					; BX = desired number of handles (max 255)
		jb	short loc_1010B
		mov	ah, 48h
		mov	bx, 1
		int	21h		; DOS -	2+ - ALLOCATE MEMORY
					; BX = number of 16-byte paragraphs desired
		jb	short loc_1010B
		inc	ax
		mov	word_1DD50, ax
		dec	ax
		mov	es, ax
		assume es:nothing
		mov	ah, 49h
		int	21h		; DOS -	2+ - FREE MEMORY
					; ES = segment address of area to be freed
		jb	short loc_1010B
		mov	ax, 5801h
		mov	bx, 0
		int	21h		; DOS -	3+ - GET/SET MEMORY ALLOCATION STRATEGY
					; AL = function	code: set allocation strategy
		jnb	short loc_10110

loc_1010B:				; CODE XREF: start+DFj	start+E9j ...
		nop
		push	cs
		call	near ptr sub_10A1E

loc_10110:				; CODE XREF: start+C5j	start+CCj ...
		xor	bp, bp
		mov	es, cs:seg_10266
		assume es:nothing
		mov	si, 0BE62h
		mov	di, 0BE7Ah
		call	sub_101E1
		push	word_1DD36
		push	word_1DD34
		push	word_1DD32
		push	word_1DD30
		push	word_1DD2E
		call	sub_12FB3
		push	ax
		nop
		push	cs
		call	near ptr sub_10ADF
start		endp ; sp-analysis failed


; =============== S U B	R O U T	I N E =======================================


sub_1013F	proc far		; CODE XREF: sub_10A88+26p
		mov	es, cs:seg_10266
		push	si
		push	di
		mov	si, 0BE7Ah
		mov	di, 0BE7Ah
		call	sub_10225
		pop	di
		pop	si
		retf
sub_1013F	endp


; =============== S U B	R O U T	I N E =======================================


nullsub_1	proc far		; CODE XREF: sub_10A88+34p
		retf
nullsub_1	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: noreturn bp-based	frame

exit		proc near		; CODE XREF: sub_10A88+4Ep

arg_2		= byte ptr  4

		mov	bp, sp
		mov	ah, 4Ch
		mov	al, [bp+arg_2]
		int	21h		; DOS -	2+ - QUIT WITH EXIT CODE (EXIT)
exit		endp			; AL = exit code

; ---------------------------------------------------------------------------

Int00:					; DATA XREF: SetupIntVects+3Co
		mov	dx, 2Fh
		push	ds
		push	dx
		nop
		push	cs
		call	near ptr sub_10A62
		pop	dx
		pop	ds
		mov	ax, 3
		push	ax
		nop
		push	cs
		call	near ptr sub_10AEE

; =============== S U B	R O U T	I N E =======================================


SetupIntVects	proc near		; CODE XREF: start+25p
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
		mov	word ptr OldIntVec05a, bx
		mov	word ptr OldIntVec05a+2, es
		mov	ax, 3506h
		int	21h		; DOS -	2+ - GET INTERRUPT VECTOR
					; AL = interrupt number
					; Return: ES:BX	= value	of interrupt vector
		mov	word ptr OldIntVec06a, bx
		mov	word ptr OldIntVec06a+2, es
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
SetupIntVects	endp


; =============== S U B	R O U T	I N E =======================================


RestoreIntVects	proc far		; CODE XREF: sub_10A88+2Fp
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
		lds	dx, OldIntVec05a
		int	21h		; DOS -	SET INTERRUPT VECTOR
					; AL = interrupt number
					; DS:DX	= new vector to	be used	for specified interrupt
		pop	ds
		push	ds
		mov	ax, 2506h
		lds	dx, OldIntVec06a
		int	21h		; DOS -	SET INTERRUPT VECTOR
					; AL = interrupt number
					; DS:DX	= new vector to	be used	for specified interrupt
		pop	ds
		retf
RestoreIntVects	endp


; =============== S U B	R O U T	I N E =======================================


sub_101E1	proc near		; CODE XREF: start+11Dp sub_101E1+3Aj	...
		mov	ax, 100h
		mov	dx, di
		mov	bx, si

loc_101E8:				; CODE XREF: sub_101E1+22j
		cmp	bx, di
		jz	short loc_10205
		cmp	byte ptr es:[bx], 0FFh
		jz	short loc_10200
		mov	cl, es:[bx+1]
		xor	ch, ch
		cmp	cx, ax
		jnb	short loc_10200
		mov	ax, cx
		mov	dx, bx

loc_10200:				; CODE XREF: sub_101E1+Fj
					; sub_101E1+19j
		add	bx, 6
		jmp	short loc_101E8
; ---------------------------------------------------------------------------

loc_10205:				; CODE XREF: sub_101E1+9j
		cmp	dx, di
		jz	short locret_10224
		mov	bx, dx
		cmp	byte ptr es:[bx], 0
		mov	byte ptr es:[bx], 0FFh
		push	es
		jz	short loc_1021D
		call	dword ptr es:[bx+2]
		pop	es
		jmp	short sub_101E1
; ---------------------------------------------------------------------------

loc_1021D:				; CODE XREF: sub_101E1+33j
		call	word ptr es:[bx+2]
		pop	es
		jmp	short sub_101E1
; ---------------------------------------------------------------------------

locret_10224:				; CODE XREF: sub_101E1+26j
		retn
sub_101E1	endp


; =============== S U B	R O U T	I N E =======================================


sub_10225	proc near		; CODE XREF: sub_1013F+Dp
					; sub_10225+37j ...
		mov	ah, 0
		mov	dx, di
		mov	bx, si

loc_1022B:				; CODE XREF: sub_10225+1Fj
		cmp	bx, di
		jz	short loc_10246
		cmp	byte ptr es:[bx], 0FFh
		jz	short loc_10241
		cmp	es:[bx+1], ah
		jb	short loc_10241
		mov	ah, es:[bx+1]
		mov	dx, bx

loc_10241:				; CODE XREF: sub_10225+Ej
					; sub_10225+14j
		add	bx, 6
		jmp	short loc_1022B
; ---------------------------------------------------------------------------

loc_10246:				; CODE XREF: sub_10225+8j
		cmp	dx, di
		jz	short locret_10265
		mov	bx, dx
		cmp	byte ptr es:[bx], 0
		mov	byte ptr es:[bx], 0FFh
		push	es
		jz	short loc_1025E
		call	dword ptr es:[bx+2]
		pop	es
		jmp	short sub_10225
; ---------------------------------------------------------------------------

loc_1025E:				; CODE XREF: sub_10225+30j
		call	word ptr es:[bx+2]
		pop	es
		jmp	short sub_10225
; ---------------------------------------------------------------------------

locret_10265:				; CODE XREF: sub_10225+23j
		retn
sub_10225	endp

; ---------------------------------------------------------------------------
seg_10266	dw 0			; DATA XREF: start+3w start+B0r ...
		dw 0C004h
		db    0,   0,	0
		db    0,   0,	7
		db    7,   0,	0
		db    7,   0,	7
		db    0,   7,	0
		db    0,   7,	7
		db    7,   7,	0
		db    7,   7,	7
		db    0,   0,	0
		db    0,   0, 0Fh
		db  0Fh,   0,	0
		db  0Fh,   0, 0Fh
		db    0, 0Fh,	0
		db    0, 0Fh, 0Fh
		db  0Fh, 0Fh,	0
		db  0Fh, 0Fh, 0Fh
word_1029A	dw 0			; DATA XREF: seg000:02D6w fread+1Dr ...
fSegment	dw 0			; DATA XREF: seg000:02DBw seg000:0361r

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

LoadGTA		proc far		; CODE XREF: LoadGTAFile+145P

arg_0		= dword	ptr  6
arg_4		= word ptr  0Ah
arg_6		= word ptr  0Ch
arg_8		= word ptr  0Eh
arg_A		= word ptr  10h
arg_C		= word ptr  12h
arg_E		= word ptr  14h
arg_10		= word ptr  16h

		push	bp
		mov	bp, sp
		push	si
		push	di
		push	ds
		les	dx, [bp+arg_0]
		mov	ax, [bp+arg_4]
		add	ax, 0Fh
		shr	ax, 4
		add	ax, [bp+arg_6]
		mov	ds, ax
		mov	si, [bp+arg_8]
		mov	ax, [bp+arg_4]
		and	ax, 0Fh
		sub	si, ax
		mov	bx, [bp+arg_A]
		mov	cx, [bp+arg_C]
		mov	di, [bp+arg_E]
		mov	ax, [bp+arg_10]
		call	LoadGTAMain
		pop	ds
		pop	di
		pop	si
		pop	bp
		retf
LoadGTA		endp

; ---------------------------------------------------------------------------

locret_102D4:				; CODE XREF: seg000:02F7j
		retn
; ---------------------------------------------------------------------------

LoadGTAMain:				; CODE XREF: LoadGTA+2Ep
		cld
		mov	cs:word_1029A, sp
		mov	cs:fSegment, ds
		mov	word_1DE10, bx
		mov	word_1DE12, cx
		mov	word ptr byte_1DE19, ax
		mov	ax, di
		mov	byte_1DE18, al
		mov	ax, -8
		cmp	si, 10A2h
		jb	short locret_102D4
		mov	ax, si
		sub	ax, 1060h	; AX = SI - 1060h
		mov	fByteCount, ax	; maximum bytes	to read
		add	ax, 1060h	; buffer size
		mov	word ptr cs:loc_105A9+2, ax
		mov	word ptr cs:loc_105B9+2, ax
		mov	word ptr cs:loc_105C9+2, ax
		mov	word ptr cs:loc_105D9+2, ax
		mov	word ptr cs:loc_105E9+2, ax
		mov	word ptr cs:loc_10653+2, ax
		mov	word ptr cs:loc_1044D+2, ax
		mov	word ptr cs:loc_1045D+2, ax
		mov	word ptr cs:loc_10487+2, ax
		mov	word ptr cs:loc_10497+2, ax
		mov	word ptr cs:loc_104A7+2, ax
		mov	word ptr cs:loc_104B7+2, ax
		mov	word ptr cs:loc_10529+2, ax
		mov	word ptr cs:loc_10589+2, ax
		mov	word ptr cs:loc_10599+2, ax
		mov	word ptr cs:loc_10726+2, ax
		mov	word ptr cs:loc_10663+2, ax
		mov	word ptr cs:loc_106D6+2, ax
		mov	word ptr cs:loc_106E6+2, ax
		mov	word ptr cs:loc_106F6+2, ax
		mov	word ptr cs:loc_10706+2, ax
		mov	word ptr cs:loc_10716+2, ax
		push	es
		pop	ds
		call	fopen
		mov	bx, cs:fSegment
		mov	ds, bx
		mov	es, bx
		jb	short locret_10379
		mov	fHandle, ax
		call	fread
		mov	si, bx
		add	si, 0Ah		; skip "GTA_FORMAT" signature
		jmp	short loc_1037A
; ---------------------------------------------------------------------------

locret_10379:				; CODE XREF: seg000:036Aj
		retn
; ---------------------------------------------------------------------------

loc_1037A:				; CODE XREF: seg000:0377j
		mov	cx, 0
		mov	cx, word_1DE10
		mov	ax, word_1DE12
		shr	cx, 3
		shl	ax, 4
		add	cx, ax
		shl	ax, 2
		add	cx, ax
		mov	word_1DE1E, cx
		lodsw			; read image width (pixels)
		mov	gtaImgWidth, ax
		mov	cx, ax
		neg	ax
		mov	word ptr cs:loc_104DA+1, ax
		inc	ax
		mov	word ptr cs:loc_10479+1, ax
		dec	ax
		add	ax, ax
		mov	word ptr cs:loc_1046E+1, ax
		add	cx, cx
		mov	ax, cx
		add	ax, 160h
		mov	word_1DE22, ax
		add	cx, cx
		mov	word_1DE1C, cx
		add	ax, cx
		mov	word_1DE24, ax
		mov	word ptr cs:loc_10515+1, ax
		mov	word ptr cs:loc_10548+2, ax
		mov	word ptr cs:loc_104C3+2, ax
		mov	ax, word_1DE10
		and	ax, 7
		add	ax, gtaImgWidth
		mov	word_1DE2C, ax
		mov	cx, ax
		lodsw			; read image height (pixels)
		mov	gtaImgHeight, ax
		mov	gtaRemLines, ax	; remaining lines to process
		lodsw			; read flags
		xchg	al, ah
		xor	ah, ah
		test	byte_1DE19, 40h
		jz	short gtaDecodePal
		cmp	byte_1DE1A, 0FFh
		jnz	short gtaDecodePal
		cmp	al, 0FFh
		jz	short loc_10400
		mov	byte_1DE1A, al
		jmp	short gtaDecodePal
; ---------------------------------------------------------------------------

loc_10400:				; CODE XREF: seg000:03F9j
		and	byte_1DE19, 0BFh

gtaDecodePal:				; CODE XREF: seg000:03EEj seg000:03F5j ...
		mov	cx, 24		; 16 palette entries * 3 components (RGB) = 48 nibbles = 24 bytes
		; decode palette data
		mov	di, 100h	; di = Palette

loc_1040B:				; CODE XREF: seg000:0422j
		lodsb
		mov	ah, al
		not	al
		not	ah
		xor	al, cl
		xor	ah, cl
		shr	ah, 4
		and	al, 0Fh
		stosb
		and	ah, 0Fh
		mov	al, ah
		stosb
		loop	loc_1040B
		; decode palette data END
		mov	bx, si
		test	byte_1DE19, 1
		jz	short loc_10430
		call	LoadGTAPalette

loc_10430:				; CODE XREF: seg000:042Bj
		call	InitPiLUT
		; from here on,	this is	"PI" graphics data
		mov	dh, 1
		mov	di, 160h
		xor	al, al
		call	loc_10609
		mov	cx, gtaImgWidth
		rep stosw
		xor	bp, bp
		jmp	loc_104CC
; ---------------------------------------------------------------------------

loc_10448:				; CODE XREF: seg000:046Aj
		mov	dl, [bx]
		inc	bx
		mov	dh, 8

loc_1044D:				; DATA XREF: seg000:031Cw
		cmp	bx, 0
		jnz	short loc_1046C
		call	fread
		jmp	short loc_1046C
; ---------------------------------------------------------------------------

loc_10458:				; CODE XREF: seg000:0475j
		mov	dl, [bx]
		inc	bx
		mov	dh, 8

loc_1045D:				; DATA XREF: seg000:0320w
		cmp	bx, 0
		jnz	short loc_10477
		call	fread
		jmp	short loc_10477
; ---------------------------------------------------------------------------

loc_10468:				; CODE XREF: seg000:04D2j
		dec	dh
		jz	short loc_10448

loc_1046C:				; CODE XREF: seg000:0451j seg000:0456j
		add	dl, dl

loc_1046E:				; DATA XREF: seg000:03A9w
		mov	si, 0
		jnb	short loc_104E9
		dec	dh
		jz	short loc_10458

loc_10477:				; CODE XREF: seg000:0461j seg000:0466j
		add	dl, dl

loc_10479:				; DATA XREF: seg000:03A2w
		mov	si, 0
		jnb	short loc_104E9
		dec	si
		dec	si
		jmp	short loc_104E9
; ---------------------------------------------------------------------------

loc_10482:				; CODE XREF: seg000:04CEj
		mov	dl, [bx]
		inc	bx
		mov	dh, 8

loc_10487:				; DATA XREF: seg000:0324w
		cmp	bx, 0
		jnz	short loc_104D0
		call	fread
		jmp	short loc_104D0
; ---------------------------------------------------------------------------

loc_10492:				; CODE XREF: seg000:04D6j
		mov	dl, [bx]
		inc	bx
		mov	dh, 8

loc_10497:				; DATA XREF: seg000:0328w
		cmp	bx, 0
		jnz	short loc_104D8
		call	fread
		jmp	short loc_104D8
; ---------------------------------------------------------------------------

loc_104A2:				; CODE XREF: seg000:04F3j
		mov	dl, [bx]
		inc	bx
		mov	dh, 8

loc_104A7:				; DATA XREF: seg000:032Cw
		cmp	bx, 0
		jnz	short loc_104F5
		call	fread

loc_104B0:
		jmp	short loc_104F5
; ---------------------------------------------------------------------------

loc_104B2:				; CODE XREF: seg000:0501j
		mov	dl, [bx]
		inc	bx
		mov	dh, 8

loc_104B7:				; DATA XREF: seg000:0330w
		cmp	bx, 0
		jnz	short loc_10503
		call	fread
		jmp	short loc_10503
; ---------------------------------------------------------------------------

loc_104C2:				; CODE XREF: seg000:04F7j
		movsw

loc_104C3:				; DATA XREF: seg000:03CAw
		cmp	di, 0
		jnz	short loc_104CC
		call	sub_10777

loc_104CC:				; CODE XREF: seg000:0445j seg000:04C7j ...
		dec	dh
		jz	short loc_10482

loc_104D0:				; CODE XREF: seg000:048Bj seg000:0490j
		add	dl, dl
		jb	short loc_10468
		dec	dh
		jz	short loc_10492

loc_104D8:				; CODE XREF: seg000:049Bj seg000:04A0j
		add	dl, dl

loc_104DA:				; DATA XREF: seg000:039Dw
		mov	si, 0
		jb	short loc_104E9
		mov	si, 0FFFCh
		mov	ax, [di-2]
		cmp	ah, al
		jz	short loc_10534

loc_104E9:				; CODE XREF: seg000:0471j seg000:047Cj ...
		cmp	si, bp
		mov	bp, si
		jz	short loc_1053F
		add	si, di

loc_104F1:				; CODE XREF: seg000:053Dj
		dec	dh
		jz	short loc_104A2

loc_104F5:				; CODE XREF: seg000:04ABj
					; seg000:loc_104B0j
		add	dl, dl
		jnb	short loc_104C2
		mov	ax, 1
		xor	cx, cx

loc_104FE:				; CODE XREF: seg000:0505j
		inc	cx
		dec	dh
		jz	short loc_104B2

loc_10503:				; CODE XREF: seg000:04BBj seg000:04C0j
		add	dl, dl
		jb	short loc_104FE

loc_10507:				; CODE XREF: seg000:050Fj
		dec	dh
		jz	short loc_10524

loc_1050B:				; CODE XREF: seg000:052Dj seg000:0532j
		add	dl, dl
		adc	ax, ax
		loop	loc_10507
		jb	short loc_1056E

loc_10513:				; CODE XREF: seg000:056Cj seg000:0577j ...
		mov	cx, ax

loc_10515:				; DATA XREF: seg000:03C2w
		mov	ax, 0
		sub	ax, di
		shr	ax, 1
		cmp	cx, ax
		jnb	short loc_10560
		rep movsw
		jmp	short loc_104CC
; ---------------------------------------------------------------------------

loc_10524:				; CODE XREF: seg000:0509j
		mov	dl, [bx]
		inc	bx
		mov	dh, 8

loc_10529:				; DATA XREF: seg000:0334w
		cmp	bx, 0
		jnz	short loc_1050B
		call	fread
		jmp	short loc_1050B
; ---------------------------------------------------------------------------

loc_10534:				; CODE XREF: seg000:04E7j
		cmp	si, bp
		mov	bp, si
		jz	short loc_1053F
		lea	si, [di-2]
		jmp	short loc_104F1
; ---------------------------------------------------------------------------

loc_1053F:				; CODE XREF: seg000:04EDj seg000:0538j
		mov	al, [di-1]

loc_10542:				; CODE XREF: seg000:0554j
		call	loc_10609
		stosw
		mov	al, ah

loc_10548:				; DATA XREF: seg000:03C6w
		cmp	di, 0
		jz	short loc_1055B

loc_1054E:				; CODE XREF: seg000:055Ej
		dec	dh
		jz	short loc_10584

loc_10552:				; CODE XREF: seg000:058Dj seg000:0592j
		add	dl, dl
		jb	short loc_10542
		xor	bp, bp
		jmp	loc_104CC
; ---------------------------------------------------------------------------

loc_1055B:				; CODE XREF: seg000:054Cj
		call	sub_10777
		jmp	short loc_1054E
; ---------------------------------------------------------------------------

loc_10560:				; CODE XREF: seg000:051Ej
		sub	cx, ax
		xchg	ax, cx
		rep movsw
		call	sub_10777
		sub	si, word_1DE1C
		jmp	short loc_10513
; ---------------------------------------------------------------------------

loc_1056E:				; CODE XREF: seg000:0511j
		xor	cx, cx

loc_10570:				; CODE XREF: seg000:0575j seg000:0582j
		movsw
		cmp	di, word_1DE24
		loopne	loc_10570
		jnz	short loc_10513
		call	sub_10777
		sub	si, word_1DE1C
		jcxz	short loc_10513
		jmp	short loc_10570
; ---------------------------------------------------------------------------

loc_10584:				; CODE XREF: seg000:0550j
		mov	dl, [bx]
		inc	bx
		mov	dh, 8

loc_10589:				; DATA XREF: seg000:0338w
		cmp	bx, 0
		jnz	short loc_10552
		call	fread
		jmp	short loc_10552
; ---------------------------------------------------------------------------

loc_10594:				; CODE XREF: seg000:05F6j
		mov	dl, [bx]
		inc	bx
		mov	dh, 8

loc_10599:				; DATA XREF: seg000:033Cw
		cmp	bx, 0
		jnz	short loc_105F8
		call	fread
		jmp	short loc_105F8
; ---------------------------------------------------------------------------

loc_105A4:				; CODE XREF: seg000:0611j
		mov	dl, [bx]
		inc	bx
		mov	dh, 8

loc_105A9:				; DATA XREF: seg000:0304w
		cmp	bx, 0
		jnz	short loc_10613
		call	fread
		jmp	short loc_10613
; ---------------------------------------------------------------------------

loc_105B4:				; CODE XREF: seg000:0619j
		mov	dl, [bx]
		inc	bx
		mov	dh, 8

loc_105B9:				; DATA XREF: seg000:0308w
		cmp	bx, 0
		jnz	short loc_1061B
		call	fread
		jmp	short loc_1061B
; ---------------------------------------------------------------------------

loc_105C4:				; CODE XREF: seg000:0624j
		mov	dl, [bx]
		inc	bx
		mov	dh, 8

loc_105C9:				; DATA XREF: seg000:030Cw
		cmp	bx, 0
		jnz	short loc_10626
		call	fread
		jmp	short loc_10626
; ---------------------------------------------------------------------------

loc_105D4:				; CODE XREF: seg000:062Cj
		mov	dl, [bx]
		inc	bx
		mov	dh, 8

loc_105D9:				; DATA XREF: seg000:0310w
		cmp	bx, 0
		jnz	short loc_1062E
		call	fread
		jmp	short loc_1062E
; ---------------------------------------------------------------------------

loc_105E4:				; CODE XREF: seg000:0634j
		mov	dl, [bx]
		inc	bx
		mov	dh, 8

loc_105E9:				; DATA XREF: seg000:0314w
		cmp	bx, 0
		jnz	short loc_10636
		call	fread
		jmp	short loc_10636
; ---------------------------------------------------------------------------

loc_105F4:				; CODE XREF: seg000:0615j
		dec	dh
		jz	short loc_10594

loc_105F8:				; CODE XREF: seg000:059Dj seg000:05A2j
		add	dl, dl
		jb	short loc_105FF
		lodsb
		jmp	short loc_1066E
; ---------------------------------------------------------------------------

loc_105FF:				; CODE XREF: seg000:05FAj
		mov	ax, [si]
		xchg	ah, al
		mov	[si], ax
		xor	ah, ah
		jmp	short loc_1066E
; ---------------------------------------------------------------------------

loc_10609:				; CODE XREF: seg000:043Ap
					; seg000:loc_10542p
		mov	bp, di
		xor	ah, ah
		mov	si, ax
		dec	dh
		jz	short loc_105A4

loc_10613:				; CODE XREF: seg000:05ADj seg000:05B2j
		add	dl, dl
		jb	short loc_105F4
		dec	dh
		jz	short loc_105B4

loc_1061B:				; CODE XREF: seg000:05BDj seg000:05C2j
		add	dl, dl
		mov	cx, 1
		jnb	short loc_1063A
		dec	dh
		jz	short loc_105C4

loc_10626:				; CODE XREF: seg000:05CDj seg000:05D2j
		add	dl, dl
		jnb	short loc_10632
		dec	dh
		jz	short loc_105D4

loc_1062E:				; CODE XREF: seg000:05DDj seg000:05E2j
		add	dl, dl
		adc	cx, cx

loc_10632:				; CODE XREF: seg000:0628j
		dec	dh
		jz	short loc_105E4

loc_10636:				; CODE XREF: seg000:05EDj seg000:05F2j
		add	dl, dl
		adc	cx, cx

loc_1063A:				; CODE XREF: seg000:0620j
		dec	dh
		jz	short loc_1064E

loc_1063E:				; CODE XREF: seg000:0657j seg000:065Cj
		add	dl, dl
		adc	cx, cx
		add	si, cx
		std
		lodsb
		lea	di, [si+1]
		rep movsb
		stosb
		jmp	short loc_1066E
; ---------------------------------------------------------------------------

loc_1064E:				; CODE XREF: seg000:063Cj
		mov	dl, [bx]
		inc	bx
		mov	dh, 8

loc_10653:				; DATA XREF: seg000:0318w
		cmp	bx, 0
		jnz	short loc_1063E
		call	fread
		jmp	short loc_1063E
; ---------------------------------------------------------------------------

loc_1065E:				; CODE XREF: seg000:0674j
		mov	dl, [bx]
		inc	bx
		mov	dh, 8

loc_10663:				; DATA XREF: seg000:0344w
		cmp	bx, 0
		jnz	short loc_10676
		call	fread
		jmp	short loc_10676
; ---------------------------------------------------------------------------

loc_1066E:				; CODE XREF: seg000:05FDj seg000:0607j ...
		xor	ah, ah
		mov	si, ax
		dec	dh
		jz	short loc_1065E

loc_10676:				; CODE XREF: seg000:0667j seg000:066Cj
		add	dl, dl
		jb	short loc_106B7
		dec	dh
		jz	short loc_106D1

loc_1067E:				; CODE XREF: seg000:06DAj seg000:06DFj
		add	dl, dl
		mov	cx, 1
		jnb	short loc_1069D
		dec	dh
		jz	short loc_106E1

loc_10689:				; CODE XREF: seg000:06EAj seg000:06EFj
		add	dl, dl
		jnb	short loc_10695
		dec	dh
		jz	short loc_106F1

loc_10691:				; CODE XREF: seg000:06FAj seg000:06FFj
		add	dl, dl
		adc	cx, cx

loc_10695:				; CODE XREF: seg000:068Bj
		dec	dh
		jz	short loc_10701

loc_10699:				; CODE XREF: seg000:070Aj seg000:070Fj
		add	dl, dl
		adc	cx, cx

loc_1069D:				; CODE XREF: seg000:0683j
		dec	dh
		jz	short loc_10711

loc_106A1:				; CODE XREF: seg000:071Aj seg000:071Fj
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

loc_106B7:				; CODE XREF: seg000:0678j
		dec	dh
		jz	short loc_10721

loc_106BB:				; CODE XREF: seg000:072Aj seg000:072Fj
		add	dl, dl
		jb	short loc_106C5
		mov	ah, [si]
		mov	di, bp
		cld
		retn
; ---------------------------------------------------------------------------

loc_106C5:				; CODE XREF: seg000:06BDj
		mov	cx, [si]
		xchg	ch, cl
		mov	[si], cx
		mov	ah, cl
		mov	di, bp
		cld
		retn
; ---------------------------------------------------------------------------

loc_106D1:				; CODE XREF: seg000:067Cj
		mov	dl, [bx]
		inc	bx
		mov	dh, 8

loc_106D6:				; DATA XREF: seg000:0348w
		cmp	bx, 0
		jnz	short loc_1067E
		call	fread
		jmp	short loc_1067E
; ---------------------------------------------------------------------------

loc_106E1:				; CODE XREF: seg000:0687j
		mov	dl, [bx]
		inc	bx
		mov	dh, 8

loc_106E6:				; DATA XREF: seg000:034Cw
		cmp	bx, 0
		jnz	short loc_10689
		call	fread
		jmp	short loc_10689
; ---------------------------------------------------------------------------

loc_106F1:				; CODE XREF: seg000:068Fj
		mov	dl, [bx]
		inc	bx
		mov	dh, 8

loc_106F6:				; DATA XREF: seg000:0350w
		cmp	bx, 0
		jnz	short loc_10691
		call	fread
		jmp	short loc_10691
; ---------------------------------------------------------------------------

loc_10701:				; CODE XREF: seg000:0697j
		mov	dl, [bx]
		inc	bx
		mov	dh, 8

loc_10706:				; DATA XREF: seg000:0354w
		cmp	bx, 0
		jnz	short loc_10699
		call	fread
		jmp	short loc_10699
; ---------------------------------------------------------------------------

loc_10711:				; CODE XREF: seg000:069Fj
		mov	dl, [bx]
		inc	bx
		mov	dh, 8

loc_10716:				; DATA XREF: seg000:0358w
		cmp	bx, 0
		jnz	short loc_106A1
		call	fread
		jmp	short loc_106A1
; ---------------------------------------------------------------------------

loc_10721:				; CODE XREF: seg000:06B9j
		mov	dl, [bx]
		inc	bx
		mov	dh, 8

loc_10726:				; DATA XREF: seg000:0340w
		cmp	bx, 0
		jnz	short loc_106BB
		call	fread
		jmp	short loc_106BB

; =============== S U B	R O U T	I N E =======================================


InitPiLUT	proc near		; CODE XREF: seg000:loc_10430p
		xor	di, di
		mov	ax, 1000h

loc_10736:				; CODE XREF: InitPiLUT+11j
		mov	cx, 10h

loc_10739:				; CODE XREF: InitPiLUT+Bj
		stosb
		sub	al, 10h
		loop	loc_10739
		add	al, 10h
		dec	ah
		jnz	short loc_10736
		retn
InitPiLUT	endp


; =============== S U B	R O U T	I N E =======================================


fopen		proc near		; CODE XREF: seg000:035Ep
		mov	ax, 3D00h
		int	21h		; DOS -	2+ - OPEN DISK FILE WITH HANDLE
					; DS:DX	-> ASCIZ filename
					; AL = access mode
					; 0 - read
		retn
fopen		endp


; =============== S U B	R O U T	I N E =======================================


fread		proc near		; CODE XREF: seg000:036Fp seg000:0453p ...
		push	ax
		push	cx
		push	dx
		mov	bx, fHandle
		mov	dx, 1060h
		push	dx
		mov	cx, fByteCount
		mov	ah, 3Fh
		int	21h		; DOS -	2+ - READ FROM FILE WITH HANDLE
					; BX = file handle, CX = number	of bytes to read
					; DS:DX	-> buffer
		jb	short loc_10765
		pop	bx
		pop	dx
		pop	cx
		pop	ax
		retn
; ---------------------------------------------------------------------------

loc_10765:				; CODE XREF: fread+13j
		call	fclose
		mov	sp, cs:word_1029A
		retn
fread		endp


; =============== S U B	R O U T	I N E =======================================


fclose		proc near		; CODE XREF: fread:loc_10765p
					; sub_10777:loc_108D4p
		mov	bx, fHandle
		mov	ah, 3Eh
		int	21h		; DOS -	2+ - CLOSE A FILE WITH HANDLE
					; BX = file handle
		retn
fclose		endp


; =============== S U B	R O U T	I N E =======================================


sub_10777	proc near		; CODE XREF: seg000:04C9p
					; seg000:loc_1055Bp ...
		pusha
		push	es
		mov	si, word_1DE24
		mov	di, 160h
		mov	cx, gtaImgWidth
		sub	si, cx
		sub	si, cx
		rep movsw
		mov	si, di
		mov	cx, 4

loc_1078F:				; CODE XREF: sub_10777+153j
		push	cx
		mov	di, word_1DE1E
		mov	ax, word_1DE10
		and	ax, 7
		jz	short loc_107DA
		mov	cx, 8
		sub	cx, ax
		push	cx
		mov	ah, 0FFh
		shl	ah, cl
		not	al
		xor	bx, bx
		mov	dx, bx

loc_107AC:				; CODE XREF: sub_10777+46j
		lodsb
		add	al, al
		adc	bl, bl
		add	al, al
		adc	bh, bh
		add	al, al
		adc	dl, dl
		add	al, al
		adc	dh, dh
		loop	loc_107AC
		test	byte_1DE19, 40h
		jz	short loc_107CB
		call	sub_1096C
		jmp	short loc_107CE
; ---------------------------------------------------------------------------

loc_107CB:				; CODE XREF: sub_10777+4Dj
		call	sub_1092A

loc_107CE:				; CODE XREF: sub_10777+52j
		pop	ax
		mov	cx, gtaImgWidth
		sub	cx, ax
		shr	cx, 3
		jmp	short loc_107E1
; ---------------------------------------------------------------------------

loc_107DA:				; CODE XREF: sub_10777+23j
		mov	cx, gtaImgWidth
		shr	cx, 3

loc_107E1:				; CODE XREF: sub_10777+61j
					; sub_10777+FBj ...
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
		test	byte_1DE19, 40h
		jnz	short loc_10875
		call	sub_1092A
		dec	cx
		jz	short loc_1087E
		jmp	loc_107E1
; ---------------------------------------------------------------------------

loc_10875:				; CODE XREF: sub_10777+F3j
		call	sub_1096C
		dec	cx
		jz	short loc_1087E
		jmp	loc_107E1
; ---------------------------------------------------------------------------

loc_1087E:				; CODE XREF: sub_10777+F9j
					; sub_10777+102j
		mov	cx, word_1DE2C
		and	cx, 7
		jz	short loc_108BB
		mov	ah, 8
		sub	ah, cl
		xor	bx, bx
		mov	dx, bx

loc_1088F:				; CODE XREF: sub_10777+129j
		lodsb
		add	al, al
		adc	bl, bl
		add	al, al
		adc	bh, bh
		add	al, al
		adc	dl, dl
		add	al, al
		adc	dh, dh
		loop	loc_1088F
		mov	cl, ah
		mov	ch, 0FFh
		shl	ch, cl
		shl	bx, cl
		shl	dx, cl
		test	byte_1DE19, 40h
		jz	short loc_108B8
		call	sub_1096C
		jmp	short loc_108BB
; ---------------------------------------------------------------------------

loc_108B8:				; CODE XREF: sub_10777+13Aj
		call	sub_1092A

loc_108BB:				; CODE XREF: sub_10777+10Ej
					; sub_10777+13Fj
		pop	cx
		add	word_1DE1E, 50h	; 'P'
		dec	gtaRemLines
		jz	short loc_108D4
		dec	cx
		jz	short loc_108CD
		jmp	loc_1078F
; ---------------------------------------------------------------------------

loc_108CD:				; CODE XREF: sub_10777+151j
		pop	es
		popa
		mov	di, word_1DE22
		retn
; ---------------------------------------------------------------------------

loc_108D4:				; CODE XREF: sub_10777+14Ej
		call	fclose
		mov	sp, cs:word_1029A
		xor	ax, ax
		retn
sub_10777	endp


; =============== S U B	R O U T	I N E =======================================


LoadGTAPalette	proc near		; CODE XREF: seg000:042Dp
		push	bx
		mov	bl, byte_1DE18
		mov	bh, 100
		mov	di, 150h
		xor	cx, cx

loc_108EB:				; CODE XREF: LoadGTAPalette+18j
		mov	al, cl
		mul	bl
		div	bh
		stosb
		inc	cl
		cmp	cl, 10h
		jnz	short loc_108EB
		push	es
		push	di
		mov	di, seg	dseg
		mov	es, di
		assume es:dseg
		mov	di, offset byte_21DF2
		mov	si, 100h
		mov	bx, 150h
		mov	cx, 10h
		xor	ah, ah

loc_1090E:				; CODE XREF: LoadGTAPalette+45j
		mov	al, ah
		lodsb
		xlat
		mov	es:[di], al
		inc	di
		lodsb
		xlat
		mov	es:[di], al
		inc	di
		lodsb
		xlat
		mov	es:[di], al
		inc	di
		inc	ah
		loop	loc_1090E
		pop	di
		pop	es
		assume es:nothing
		pop	bx
		retn
LoadGTAPalette	endp


; =============== S U B	R O U T	I N E =======================================


sub_1092A	proc near		; CODE XREF: sub_10777:loc_107CBp
					; sub_10777+F5p ...
		mov	ax, seg	dseg
		mov	es, ax
		assume es:dseg
		mov	ax, es:word_21EAA
		mov	es, ax
		assume es:nothing
		mov	al, dh
		mov	es:[di], al
		mov	ax, seg	dseg
		mov	es, ax
		assume es:dseg
		mov	ax, es:word_21EAC
		mov	es, ax
		assume es:nothing
		mov	al, dl
		mov	es:[di], al
		mov	ax, seg	dseg
		mov	es, ax
		assume es:dseg
		mov	ax, es:word_21EAE
		mov	es, ax
		assume es:nothing
		mov	al, bh
		mov	es:[di], al
		mov	ax, seg	dseg
		mov	es, ax
		assume es:dseg
		mov	ax, es:word_21EB0
		mov	es, ax
		assume es:nothing
		mov	al, bl
		mov	es:[di], al
		inc	di
		retn
sub_1092A	endp


; =============== S U B	R O U T	I N E =======================================


sub_1096C	proc near		; CODE XREF: sub_10777+4Fp
					; sub_10777:loc_10875p	...
		pusha
		mov	cl, byte_1DE1A
		mov	ch, 0FFh
		test	cl, 1
		jz	short loc_1097A
		and	ch, dh

loc_1097A:				; CODE XREF: sub_1096C+Aj
		test	cl, 2
		jz	short loc_10981
		and	ch, dl

loc_10981:				; CODE XREF: sub_1096C+11j
		test	cl, 4
		jz	short loc_10988
		and	ch, bh

loc_10988:				; CODE XREF: sub_1096C+18j
		test	cl, 8
		jz	short loc_1098F
		and	ch, bl

loc_1098F:				; CODE XREF: sub_1096C+1Fj
		test	cl, 1
		jnz	short loc_1099A
		mov	al, dh
		not	al
		and	ch, al

loc_1099A:				; CODE XREF: sub_1096C+26j
		test	cl, 2
		jnz	short loc_109A5
		mov	al, dl
		not	al
		and	ch, al

loc_109A5:				; CODE XREF: sub_1096C+31j
		test	cl, 4
		jnz	short loc_109B0
		mov	al, bh
		not	al
		and	ch, al

loc_109B0:				; CODE XREF: sub_1096C+3Cj
		test	cl, 8
		jnz	short loc_109BB
		mov	al, bl
		not	al
		and	ch, al

loc_109BB:				; CODE XREF: sub_1096C+47j
		not	ch
		and	dh, ch
		and	dl, ch
		and	bh, ch
		and	bl, ch
		not	ch
		mov	ax, seg	dseg
		mov	es, ax
		assume es:dseg
		mov	ax, es:word_21EAA
		mov	es, ax
		assume es:nothing
		mov	al, es:[di]
		and	al, ch
		or	al, dh
		mov	es:[di], al
		mov	ax, seg	dseg
		mov	es, ax
		assume es:dseg
		mov	ax, es:word_21EAC
		mov	es, ax
		assume es:nothing
		mov	al, es:[di]
		and	al, ch
		or	al, dl
		mov	es:[di], al
		mov	ax, seg	dseg
		mov	es, ax
		assume es:dseg
		mov	ax, es:word_21EAE
		mov	es, ax
		assume es:nothing
		mov	al, es:[di]
		and	al, ch
		or	al, bh
		mov	es:[di], al
		mov	ax, seg	dseg
		mov	es, ax
		assume es:dseg
		mov	ax, es:word_21EB0
		mov	es, ax
		assume es:nothing
		mov	al, es:[di]
		and	al, ch
		or	al, bl
		mov	es:[di], al
		popa
		inc	di
		retn
sub_1096C	endp


; =============== S U B	R O U T	I N E =======================================


sub_10A1E	proc far		; CODE XREF: start+80p	start+10Dp ...
		push	ds
		mov	ax, offset aAbnormalProgra ; "Abnormal program termination\r\n"
		push	ax
		nop
		push	cs
		call	near ptr sub_10A62
		pop	cx
		pop	cx
		mov	ax, 3
		push	ax
		nop
		push	cs
		call	near ptr sub_10AEE
		pop	cx
		retf
sub_10A1E	endp

; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		cmp	word_29720, 20h	; ' '
		jnz	short loc_10A44
		mov	ax, 1
		jmp	short loc_10A60
; ---------------------------------------------------------------------------

loc_10A44:				; CODE XREF: seg000:0A3Dj
		mov	bx, word_29720
		mov	cl, 2
		shl	bx, cl
		mov	ax, [bp+8]
		mov	dx, [bp+6]
		mov	word ptr byte_29B60[bx], ax
		mov	word_29B5E[bx],	dx
		inc	word_29720
		xor	ax, ax

loc_10A60:				; CODE XREF: seg000:0A42j
		pop	bp
		retf

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_10A62	proc far		; CODE XREF: seg000:0163p sub_10A1E+7p

arg_0		= word ptr  6
arg_2		= word ptr  8

		push	bp
		mov	bp, sp
		push	[bp+arg_2]
		push	[bp+arg_0]
		nop
		push	cs
		call	near ptr sub_125F0
		pop	cx
		pop	cx
		push	ax
		push	[bp+arg_2]
		push	[bp+arg_0]
		mov	ax, 2
		push	ax
		nop
		push	cs
		call	near ptr sub_12D8C
		add	sp, 8
		pop	bp
		retf
sub_10A62	endp

; [00000001 BYTES: COLLAPSED FUNCTION nullsub_2. PRESS KEYPAD "+" TO EXPAND]

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_10A88	proc near		; CODE XREF: sub_10ADF+Ap sub_10AEE+Dp ...

arg_0		= word ptr  4
arg_2		= word ptr  6
arg_4		= word ptr  8

		push	bp
		mov	bp, sp
		push	si
		mov	si, [bp+arg_4]
		or	si, si
		jnz	short loc_10AB5
		jmp	short loc_10AA5
; ---------------------------------------------------------------------------

loc_10A95:				; CODE XREF: sub_10A88+22j
		dec	word_29720
		mov	bx, word_29720
		mov	cl, 2
		shl	bx, cl
		call	dword ptr word_29B5E[bx]

loc_10AA5:				; CODE XREF: sub_10A88+Bj
		cmp	word_29720, 0
		jnz	short loc_10A95
		nop
		push	cs
		call	near ptr sub_1013F
		call	off_29824

loc_10AB5:				; CODE XREF: sub_10A88+9j
		nop
		push	cs
		call	near ptr RestoreIntVects
		nop
		push	cs
		call	near ptr nullsub_1
		cmp	[bp+arg_2], 0
		jnz	short loc_10ADA
		or	si, si
		jnz	short loc_10AD1
		call	off_29828
		call	off_2982C

loc_10AD1:				; CODE XREF: sub_10A88+3Fj
		push	[bp+arg_0]
		nop
		push	cs
		call	exit
; ---------------------------------------------------------------------------
		pop	cx

loc_10ADA:				; CODE XREF: sub_10A88+3Bj
		pop	si
		pop	bp
		retn	6
sub_10A88	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_10ADF	proc far		; CODE XREF: start+13Cp sub_12FB3+40P	...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		xor	ax, ax
		push	ax
		push	ax
		push	[bp+arg_0]
		call	sub_10A88
		pop	bp
		retf
sub_10ADF	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_10AEE	proc far		; CODE XREF: seg000:016Ep
					; sub_10A1E+12p

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		mov	ax, 1
		push	ax
		xor	ax, ax
		push	ax
		push	[bp+arg_0]
		call	sub_10A88
		pop	bp
		retf
sub_10AEE	endp

; ---------------------------------------------------------------------------
		xor	ax, ax
		push	ax
		mov	ax, 1
		push	ax
		xor	ax, ax
		push	ax
		call	sub_10A88
		retf
; ---------------------------------------------------------------------------
		mov	ax, 1
		push	ax
		push	ax
		xor	ax, ax
		push	ax
		call	sub_10A88
		retf

; =============== S U B	R O U T	I N E =======================================


RNG_Advance	proc far		; CODE XREF: RNG_GetNext+EP
		push	si
		xchg	ax, si
		xchg	ax, dx
		test	ax, ax
		jz	short loc_10B23
		mul	bx

loc_10B23:				; CODE XREF: RNG_Advance+5j
		jcxz	short loc_10B2A
		xchg	ax, cx
		mul	si
		add	ax, cx

loc_10B2A:				; CODE XREF: RNG_Advance:loc_10B23j
		xchg	ax, si
		mul	bx
		add	dx, si
		pop	si
		retf
RNG_Advance	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

GetDate		proc far		; CODE XREF: sub_10F09+Dp
					; sub_10F09+25p

arg_0		= dword	ptr  6

		push	bp
		mov	bp, sp
		mov	ah, 2Ah
		int	21h		; DOS -	GET CURRENT DATE
					; Return: DL = day, DH = month,	CX = year
					; AL = day of the week (0=Sunday, 1=Monday, etc.)
		les	bx, [bp+arg_0]
		mov	es:[bx], cx
		mov	es:[bx+2], dx
		pop	bp
		retf
GetDate		endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

GetTime		proc far		; CODE XREF: sub_10F09+19p

arg_0		= dword	ptr  6

		push	bp
		mov	bp, sp
		mov	ah, 2Ch
		int	21h		; DOS -	GET CURRENT TIME
					; Return: CH = hours, CL = minutes, DH = seconds
					; DL = hundredths of seconds
		les	bx, [bp+arg_0]
		mov	es:[bx], cx
		mov	es:[bx+2], dx
		pop	bp
		retf
GetTime		endp


; =============== S U B	R O U T	I N E =======================================


sub_10B57	proc near		; CODE XREF: sub_1276A+48p
					; sub_1276A+74p ...
		pop	cx
		push	cs
		push	cx
sub_10B57	endp ; sp-analysis failed


; =============== S U B	R O U T	I N E =======================================


sub_10B5A	proc far		; CODE XREF: sub_12FB3+20P
					; sub_12FB3+FDP
		xor	cx, cx
		jmp	short loc_10B74
sub_10B5A	endp

; ---------------------------------------------------------------------------
		pop	cx
		push	cs
		push	cx
		mov	cx, 1
		jmp	short loc_10B74

; =============== S U B	R O U T	I N E =======================================


sub_10B66	proc far		; CODE XREF: sub_1276A+31p
					; sub_1276A+5Ep ...
		pop	cx
		push	cs
		push	cx
		mov	cx, 2
		jmp	short loc_10B74
; ---------------------------------------------------------------------------
		pop	cx
		push	cs
		push	cx
		mov	cx, 3

loc_10B74:				; CODE XREF: sub_10B5A+2j seg000:0B64j ...
		push	bp
		push	si
		push	di
		mov	bp, sp
		mov	di, cx
		mov	ax, [bp+0Ah]
		mov	dx, [bp+0Ch]
		mov	bx, [bp+0Eh]
		mov	cx, [bp+10h]
		or	cx, cx
		jnz	short loc_10B93
		or	dx, dx
		jz	short loc_10BF8
		or	bx, bx
		jz	short loc_10BF8

loc_10B93:				; CODE XREF: sub_10B66+23j
		test	di, 1
		jnz	short loc_10BB5
		or	dx, dx
		jns	short loc_10BA7
		neg	dx
		neg	ax
		sbb	dx, 0
		or	di, 0Ch

loc_10BA7:				; CODE XREF: sub_10B66+35j
		or	cx, cx
		jns	short loc_10BB5
		neg	cx
		neg	bx
		sbb	cx, 0
		xor	di, 4

loc_10BB5:				; CODE XREF: sub_10B66+31j
					; sub_10B66+43j
		mov	bp, cx
		mov	cx, 20h	; ' '
		push	di
		xor	di, di
		xor	si, si

loc_10BBF:				; CODE XREF: sub_10B66:loc_10BD6j
		shl	ax, 1
		rcl	dx, 1
		rcl	si, 1
		rcl	di, 1
		cmp	di, bp
		jb	short loc_10BD6
		ja	short loc_10BD1
		cmp	si, bx
		jb	short loc_10BD6

loc_10BD1:				; CODE XREF: sub_10B66+65j
		sub	si, bx
		sbb	di, bp
		inc	ax

loc_10BD6:				; CODE XREF: sub_10B66+63j
					; sub_10B66+69j
		loop	loc_10BBF
		pop	bx
		test	bx, 2
		jz	short loc_10BE5
		mov	ax, si
		mov	dx, di
		shr	bx, 1

loc_10BE5:				; CODE XREF: sub_10B66+77j
		test	bx, 4
		jz	short loc_10BF2
		neg	dx
		neg	ax
		sbb	dx, 0

loc_10BF2:				; CODE XREF: sub_10B66+83j
					; sub_10B66+9Dj
		pop	di
		pop	si
		pop	bp
		retf	8
; ---------------------------------------------------------------------------

loc_10BF8:				; CODE XREF: sub_10B66+27j
					; sub_10B66+2Bj
		div	bx
		test	di, 2
		jz	short loc_10C01
		xchg	ax, dx

loc_10C01:				; CODE XREF: sub_10B66+98j
		xor	dx, dx
		jmp	short loc_10BF2
sub_10B66	endp ; sp-analysis failed


; =============== S U B	R O U T	I N E =======================================


sub_10C05	proc far		; CODE XREF: sub_1197F+Dp
		pop	bx
		push	cs
		push	bx
		cmp	cl, 10h
		jnb	short loc_10C1D
		mov	bx, ax
		shl	ax, cl
		shl	dx, cl
		neg	cl
		add	cl, 10h
		shr	bx, cl
		or	dx, bx
		retf
; ---------------------------------------------------------------------------

loc_10C1D:				; CODE XREF: sub_10C05+6j
		sub	cl, 10h
		xchg	ax, dx
		xor	ax, ax
		shl	dx, cl
		retf
sub_10C05	endp ; sp-analysis failed


; =============== S U B	R O U T	I N E =======================================


sub_10C26	proc far		; CODE XREF: sub_1197F+3Ep
		pop	es
		push	cs
		push	es
		or	cx, cx
		jge	short loc_10C39
		not	bx
		not	cx
		add	bx, 1
		adc	cx, 0
		jmp	short loc_10C68
; ---------------------------------------------------------------------------

loc_10C39:				; CODE XREF: sub_10C26+5j
					; sub_10C26+40j
		add	ax, bx
		jnb	short loc_10C41
		add	dx, 1000h

loc_10C41:				; CODE XREF: sub_10C26+15j
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
		jge	short loc_10C68
		not	bx
		not	cx
		add	bx, 1
		adc	cx, 0
		jmp	short loc_10C39
; ---------------------------------------------------------------------------

loc_10C68:				; CODE XREF: sub_10C26+11j
					; sub_10C26+34j
		sub	ax, bx
		jnb	short loc_10C70
		sub	dx, 1000h

loc_10C70:				; CODE XREF: sub_10C26+44j
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
sub_10C26	endp ; sp-analysis failed


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_10C86	proc near		; CODE XREF: seg000:0CC7p
					; seek_something+23p ...

arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		push	si
		mov	si, [bp+arg_0]
		or	si, si
		jl	short loc_10CA6
		cmp	si, 58h	; 'X'
		jle	short loc_10C99

loc_10C96:				; CODE XREF: sub_10C86+25j
		mov	si, 57h	; 'W'

loc_10C99:				; CODE XREF: sub_10C86+Ej
		mov	word_299EA, si
		mov	al, byte_299EC[si]
		cbw
		mov	si, ax
		jmp	short loc_10CB3
; ---------------------------------------------------------------------------

loc_10CA6:				; CODE XREF: sub_10C86+9j
		neg	si
		cmp	si, 30h
		jg	short loc_10C96
		mov	word_299EA, 0FFFFh

loc_10CB3:				; CODE XREF: sub_10C86+1Ej
		mov	word_1DD42, si
		mov	ax, 0FFFFh
		pop	si
		pop	bp
		retn	2
sub_10C86	endp

; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		push	si
		mov	si, [bp+4]
		push	si
		call	sub_10C86
		mov	ax, si
		pop	si
		pop	bp
		retn	2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

ioctl		proc far		; CODE XREF: seg000:0E57p seg000:0E93p

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		mov	ax, 4400h
		mov	bx, [bp+arg_0]
		int	21h		; DOS -	2+ - IOCTL - GET DEVICE	INFORMATION
					; BX = file or device handle
		xchg	ax, dx
		and	ax, 80h
		pop	bp
		retf
ioctl		endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_10CE2	proc near		; CODE XREF: seg000:0D7Dp
					; sub_10F8D+220p

var_22		= byte ptr -22h
arg_0		= byte ptr  4
arg_2		= byte ptr  6
arg_4		= word ptr  8
arg_6		= dword	ptr  0Ah
arg_A		= word ptr  0Eh
arg_C		= word ptr  10h

		push	bp
		mov	bp, sp
		sub	sp, 22h
		push	si
		push	di
		push	es
		les	di, [bp+arg_6]
		mov	bx, [bp+arg_4]
		cmp	bx, 24h	; '$'
		ja	short loc_10D52
		cmp	bl, 2
		jb	short loc_10D52
		mov	ax, [bp+arg_A]
		mov	cx, [bp+arg_C]
		or	cx, cx
		jge	short loc_10D17
		cmp	[bp+arg_2], 0
		jz	short loc_10D17
		mov	byte ptr es:[di], 2Dh ;	'-'
		inc	di
		neg	cx
		neg	ax
		sbb	cx, 0

loc_10D17:				; CODE XREF: sub_10CE2+21j
					; sub_10CE2+27j
		lea	si, [bp+var_22]
		jcxz	short loc_10D2C

loc_10D1C:				; CODE XREF: sub_10CE2+48j
		xchg	ax, cx
		sub	dx, dx
		div	bx
		xchg	ax, cx
		div	bx
		mov	ss:[si], dl
		inc	si
		jcxz	short loc_10D34
		jmp	short loc_10D1C
; ---------------------------------------------------------------------------

loc_10D2C:				; CODE XREF: sub_10CE2+38j
					; sub_10CE2+54j
		sub	dx, dx
		div	bx
		mov	ss:[si], dl
		inc	si

loc_10D34:				; CODE XREF: sub_10CE2+46j
		or	ax, ax
		jnz	short loc_10D2C
		lea	cx, [bp+var_22]
		neg	cx
		add	cx, si
		cld

loc_10D40:				; CODE XREF: sub_10CE2+6Ej
		dec	si
		mov	al, ss:[si]
		sub	al, 0Ah
		jnb	short loc_10D4C
		add	al, 3Ah	; ':'
		jmp	short loc_10D4F
; ---------------------------------------------------------------------------

loc_10D4C:				; CODE XREF: sub_10CE2+64j
		add	al, [bp+arg_0]

loc_10D4F:				; CODE XREF: sub_10CE2+68j
		stosb
		loop	loc_10D40

loc_10D52:				; CODE XREF: sub_10CE2+12j
					; sub_10CE2+17j
		mov	al, 0
		stosb
		pop	es
		mov	dx, word ptr [bp+arg_6+2]
		mov	ax, word ptr [bp+arg_6]
		pop	di
		pop	si
		mov	sp, bp
		pop	bp
		retn	0Eh
sub_10CE2	endp

; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		xor	ax, ax
		push	ax
		push	word ptr [bp+8]
		push	word ptr [bp+6]
		push	word ptr [bp+4]
		mov	ax, 0Ah
		push	ax
		mov	al, 0
		push	ax
		mov	al, 61h	; 'a'
		push	ax
		call	sub_10CE2
		pop	bp
		retn	6

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

seek_something	proc far		; CODE XREF: sub_11E38+66p
					; seg000:1ED3p	...

arg_0		= word ptr  6
arg_2		= word ptr  8
arg_4		= word ptr  0Ah
method		= byte ptr  0Ch

		push	bp
		mov	bp, sp
		mov	bx, [bp+arg_0]
		shl	bx, 1
		and	word ptr byte_299C2[bx], 0FDFFh
		mov	ah, 42h
		mov	al, [bp+method]
		mov	bx, [bp+arg_0]
		mov	cx, [bp+arg_4]
		mov	dx, [bp+arg_2]
		int	21h		; DOS -	2+ - MOVE FILE READ/WRITE POINTER (LSEEK)
					; AL = method:
					; 0-from beginnig,1-from current,2-from	end
		jb	short loc_10DA6
		jmp	short loc_10DAB
; ---------------------------------------------------------------------------

loc_10DA6:				; CODE XREF: seek_something+1Ej
		push	ax
		call	sub_10C86
		cwd

loc_10DAB:				; CODE XREF: seek_something+20j
		pop	bp
		retf
seek_something	endp


; =============== S U B	R O U T	I N E =======================================


sub_10DAD	proc near		; CODE XREF: sub_12640+3Bp
					; sub_12640+54p ...
		push	si
		xchg	ax, si
		xchg	ax, dx
		test	ax, ax
		jz	short loc_10DB6
		mul	bx

loc_10DB6:				; CODE XREF: sub_10DAD+5j
		jcxz	short loc_10DBD
		xchg	ax, cx
		mul	si
		add	ax, cx

loc_10DBD:				; CODE XREF: sub_10DAD:loc_10DB6j
		xchg	ax, si
		mul	bx
		add	dx, si
		pop	si
		retn
sub_10DAD	endp


; =============== S U B	R O U T	I N E =======================================


sub_10DC4	proc near		; CODE XREF: sub_11940+11p
					; sub_11940+24p ...
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
		jnz	short locret_10DE4
		cmp	ax, bx

locret_10DE4:				; CODE XREF: sub_10DC4+1Cj
		retn
sub_10DC4	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

SetDate		proc far		; CODE XREF: seg000:0EF2p

arg_0		= dword	ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ah, 2Bh
		les	si, [bp+arg_0]
		mov	cx, es:[si]
		mov	dx, es:[si+2]
		int	21h		; DOS -	SET CURRENT DATE
					; DL = day, DH = month,	CX = year
					; Return: AL = 00h if no error /= FFh if bad value sent	to routine
		pop	si
		pop	bp
		retf
SetDate		endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

SetTime		proc far		; CODE XREF: seg000:0EFEp

arg_0		= dword	ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ah, 2Dh
		les	si, [bp+arg_0]
		mov	cx, es:[si]
		mov	dx, es:[si+2]
		int	21h		; DOS -	SET CURRENT TIME
					; CH = hours, CL = minutes, DH = seconds, DL = hundredths of seconds
					; Return: AL = 00h if no error / = FFh if bad value sent to routine
		pop	si
		pop	bp
		retf
SetTime		endp

; ---------------------------------------------------------------------------
		mov	cx, 5
		cmp	cx, word_299C0
		jnb	short loc_10E50

loc_10E18:				; CODE XREF: seg000:0E4Ej
		mov	bx, cx
		shl	bx, 1
		mov	word ptr byte_299C2[bx], 0
		mov	ax, cx
		mov	dx, 14h
		imul	dx
		mov	bx, ax
		mov	byte_29834[bx],	0FFh
		mov	ax, cx
		mov	dx, 14h
		imul	dx
		add	ax, 0BB50h
		push	ax
		mov	ax, cx
		mov	dx, 14h
		imul	dx
		mov	bx, ax
		pop	ax
		mov	word ptr (byte_29834+0Eh)[bx], ax
		inc	cx
		cmp	cx, word_299C0
		jb	short loc_10E18

loc_10E50:				; CODE XREF: seg000:0E16j
		mov	al, byte_29834
		cbw
		push	ax
		nop
		push	cs
		call	near ptr ioctl
		pop	cx
		or	ax, ax
		jnz	short loc_10E65
		and	word_29832, 0FDFFh

loc_10E65:				; CODE XREF: seg000:0E5Dj
		mov	ax, 200h
		push	ax
		test	word_29832, 200h
		jz	short loc_10E76
		mov	ax, 1
		jmp	short loc_10E78
; ---------------------------------------------------------------------------

loc_10E76:				; CODE XREF: seg000:0E6Fj
		xor	ax, ax

loc_10E78:				; CODE XREF: seg000:0E74j
		push	ax
		xor	ax, ax
		xor	dx, dx
		push	ax
		push	dx
		push	ds
		mov	ax, offset unk_29830
		push	ax
		nop
		push	cs
		call	near ptr sub_124AA
		add	sp, 0Ch
		mov	al, byte_29848
		cbw
		push	ax
		nop
		push	cs
		call	near ptr ioctl
		pop	cx
		or	ax, ax
		jnz	short loc_10EA1
		and	word_29846, 0FDFFh

loc_10EA1:				; CODE XREF: seg000:0E99j
		mov	ax, 200h
		push	ax
		test	word_29846, 200h
		jz	short loc_10EB2
		mov	ax, 2
		jmp	short loc_10EB4
; ---------------------------------------------------------------------------

loc_10EB2:				; CODE XREF: seg000:0EABj
		xor	ax, ax

loc_10EB4:				; CODE XREF: seg000:0EB0j
		push	ax
		xor	ax, ax
		xor	dx, dx
		push	ax
		push	dx
		push	ds
		mov	ax, (offset byte_29834+10h)
		push	ax
		nop
		push	cs
		call	near ptr sub_124AA
		add	sp, 0Ch
		retn
; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		sub	sp, 8
		push	ss
		lea	ax, [bp-8]
		push	ax
		push	ss
		lea	ax, [bp-4]
		push	ax
		les	bx, [bp+6]
		push	word ptr es:[bx+2]
		push	word ptr es:[bx]
		nop
		push	cs
		call	near ptr sub_1276A
		add	sp, 0Ch
		push	ss
		lea	ax, [bp-4]
		push	ax
		nop
		push	cs
		call	near ptr SetDate
		pop	cx
		pop	cx
		push	ss
		lea	ax, [bp-8]
		push	ax
		nop
		push	cs
		call	near ptr SetTime
		pop	cx
		pop	cx
		xor	ax, ax
		mov	sp, bp
		pop	bp
		retf

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_10F09	proc far		; CODE XREF: sub_12FB3+B9P

var_10		= byte ptr -10h
var_E		= byte ptr -0Eh
var_C		= word ptr -0Ch
var_A		= word ptr -0Ah
var_8		= byte ptr -8
var_4		= byte ptr -4
var_2		= byte ptr -2
arg_0		= dword	ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 10h

loc_10F0F:				; CODE XREF: sub_10F09+30j
		push	ss
		lea	ax, [bp+var_4]
		push	ax
		nop
		push	cs
		call	near ptr GetDate
		pop	cx
		pop	cx
		push	ss
		lea	ax, [bp+var_8]
		push	ax
		nop
		push	cs
		call	near ptr GetTime
		pop	cx
		pop	cx
		push	ss
		lea	ax, [bp+var_10]
		push	ax
		nop
		push	cs
		call	near ptr GetDate
		pop	cx
		pop	cx
		mov	al, [bp+var_2]
		cmp	al, [bp+var_E]
		jnz	short loc_10F0F
		push	ss
		lea	ax, [bp+var_8]
		push	ax
		push	ss
		lea	ax, [bp+var_4]
		push	ax
		nop
		push	cs
		call	near ptr sub_12640
		add	sp, 8
		mov	[bp+var_A], dx
		mov	[bp+var_C], ax
		mov	ax, word ptr [bp+arg_0]
		or	ax, word ptr [bp+arg_0+2]
		jz	short loc_10F6B
		les	bx, [bp+arg_0]
		mov	ax, [bp+var_A]
		mov	dx, [bp+var_C]
		mov	es:[bx+2], ax
		mov	es:[bx], dx

loc_10F6B:				; CODE XREF: sub_10F09+50j
		mov	dx, [bp+var_A]
		mov	ax, [bp+var_C]
		mov	sp, bp
		pop	bp
		retf
sub_10F09	endp


; =============== S U B	R O U T	I N E =======================================


sub_10F75	proc near		; CODE XREF: sub_10F8D+257p
					; sub_10F8D+260p
		mov	al, dh
		call	sub_10F7C
		mov	al, dl
sub_10F75	endp ; sp-analysis failed


; =============== S U B	R O U T	I N E =======================================


sub_10F7C	proc near		; CODE XREF: sub_10F75+2p
		aam	10h
		xchg	ah, al
		call	sub_10F85
		xchg	ah, al
sub_10F7C	endp ; sp-analysis failed


; =============== S U B	R O U T	I N E =======================================


sub_10F85	proc near		; CODE XREF: sub_10F7C+4p
		add	al, 90h	; 'ê'
		daa
		adc	al, 40h	; '@'
		daa
		stosb
		retn
sub_10F85	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_10F8D	proc near		; CODE XREF: sub_1206F+16p

var_96		= byte ptr -96h
var_46		= byte ptr -46h
var_45		= byte ptr -45h
var_16		= word ptr -16h
var_14		= word ptr -14h
var_12		= word ptr -12h
var_10		= word ptr -10h
var_E		= word ptr -0Eh
var_B		= byte ptr -0Bh
var_A		= word ptr -0Ah
var_8		= word ptr -8
var_6		= byte ptr -6
var_5		= byte ptr -5
var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  4
arg_2		= dword	ptr  6

; FUNCTION CHUNK AT 0FF1 SIZE 0000042F BYTES

		push	bp
		mov	bp, sp
		sub	sp, 96h
		push	si
		push	di
		mov	[bp+var_12], 0
		mov	[bp+var_14], 50h ; 'P'
		mov	[bp+var_16], 0
		jmp	short loc_10FF1
sub_10F8D	endp


; =============== S U B	R O U T	I N E =======================================


sub_10FA7	proc near		; CODE XREF: sub_10F8D:loc_1125Ep
					; sub_10F8D:loc_112BEp	...
		push	di
		mov	cx, 0FFFFh
		xor	al, al
		repne scasb
		not	cx
		dec	cx
		pop	di
		retn
sub_10FA7	endp


; =============== S U B	R O U T	I N E =======================================


sub_10FB4	proc near		; CODE XREF: sub_10F8D+3B7p
					; sub_10F8D+3C8p ...
		mov	ss:[di], al
		inc	di
		dec	byte ptr [bp-14h]
		jnz	short locret_10FF0
sub_10FB4	endp ; sp-analysis failed


; =============== S U B	R O U T	I N E =======================================


sub_10FBD	proc near		; CODE XREF: sub_10F8D+86p
					; sub_10F8D+40Ep ...
		push	bx
		push	cx
		push	dx
		push	es
		lea	ax, [bp-96h]
		sub	di, ax
		push	ss
		lea	ax, [bp-96h]
		push	ax
		push	di
		push	word ptr [bp+0Ch]
		push	word ptr [bp+0Ah]
		call	ss:off_1DCEE[bp]
		or	ax, ax
		jnz	short loc_10FE0
		mov	word ptr [bp-16h], 1

loc_10FE0:				; CODE XREF: sub_10FBD+1Cj
		mov	word ptr [bp-14h], 50h ; 'P'
		add	[bp-12h], di
		lea	di, [bp-96h]
		pop	es
		pop	dx
		pop	cx
		pop	bx

locret_10FF0:				; CODE XREF: sub_10FB4+7j
		retn
sub_10FBD	endp ; sp-analysis failed

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_10F8D

loc_10FF1:				; CODE XREF: sub_10F8D+18j
		push	es
		cld
		lea	di, [bp+var_96]
		mov	[bp+var_4], di

loc_10FFA:				; CODE XREF: sub_10F8D:loc_113E9j
		mov	di, [bp+var_4]

loc_10FFD:				; CODE XREF: sub_10F8D:loc_113ADj
		les	si, [bp+arg_2]

loc_11000:				; CODE XREF: sub_10F8D+84j
					; sub_10F8D+89j
		lods	byte ptr es:[si]
		or	al, al
		jz	short loc_11018
		cmp	al, 25h	; '%'
		jz	short loc_1101B

loc_1100A:				; CODE XREF: sub_10F8D+95j
		mov	ss:[di], al
		inc	di
		dec	byte ptr [bp+var_14]
		jg	short loc_11000
		call	sub_10FBD
		jmp	short loc_11000
; ---------------------------------------------------------------------------

loc_11018:				; CODE XREF: sub_10F8D+77j
		jmp	loc_11400
; ---------------------------------------------------------------------------

loc_1101B:				; CODE XREF: sub_10F8D+7Bj
		mov	[bp+var_10], si
		lods	byte ptr es:[si]
		cmp	al, 25h	; '%'
		jz	short loc_1100A
		mov	[bp+var_4], di
		xor	cx, cx
		mov	[bp+var_E], cx
		mov	[bp+var_2], 20h	; ' '
		mov	[bp+var_B], cl
		mov	[bp+var_8], 0FFFFh
		mov	[bp+var_A], 0FFFFh
		jmp	short loc_11042
; ---------------------------------------------------------------------------

loc_11040:				; CODE XREF: sub_10F8D+E2j
					; sub_10F8D+EDj ...
		lods	byte ptr es:[si]

loc_11042:				; CODE XREF: sub_10F8D+B1j
		xor	ah, ah
		mov	dx, ax
		mov	bx, ax
		sub	bl, 20h	; ' '
		cmp	bl, 60h	; '`'
		jnb	short loc_11063
		mov	bl, [bx-4291h]
		cmp	bx, 17h		; switch 24 cases
		jbe	short loc_1105C
		jmp	loc_113EC	; jumptable 0001105E default case
; ---------------------------------------------------------------------------

loc_1105C:				; CODE XREF: sub_10F8D+CAj
		shl	bx, 1
		jmp	cs:off_11420[bx] ; switch jump
; ---------------------------------------------------------------------------

loc_11063:				; CODE XREF: sub_10F8D+C1j
					; sub_10F8D+DCj ...
		jmp	loc_113EC	; jumptable 0001105E default case
; ---------------------------------------------------------------------------

loc_11066:				; CODE XREF: sub_10F8D+D1j
					; DATA XREF: seg000:off_11420o
		cmp	ch, 0		; jumptable 0001105E case 1
		ja	short loc_11063
		or	[bp+var_2], 1
		jmp	short loc_11040
; ---------------------------------------------------------------------------

loc_11071:				; CODE XREF: sub_10F8D+D1j
					; DATA XREF: seg000:off_11420o
		cmp	ch, 0		; jumptable 0001105E case 3
		ja	short loc_11063
		or	[bp+var_2], 2
		jmp	short loc_11040
; ---------------------------------------------------------------------------

loc_1107C:				; CODE XREF: sub_10F8D+D1j
					; DATA XREF: seg000:off_11420o
		cmp	ch, 0		; jumptable 0001105E case 0
		ja	short loc_11063
		cmp	[bp+var_B], 2Bh	; '+'
		jz	short loc_1108A
		mov	[bp+var_B], dl

loc_1108A:				; CODE XREF: sub_10F8D+F8j
		jmp	short loc_11040
; ---------------------------------------------------------------------------

loc_1108C:				; CODE XREF: sub_10F8D+D1j
					; DATA XREF: seg000:off_11420o
		and	[bp+var_2], 0FFDFh ; jumptable 0001105E	case 22
		jmp	short loc_11096
; ---------------------------------------------------------------------------

loc_11092:				; CODE XREF: sub_10F8D+D1j
					; DATA XREF: seg000:off_11420o
		or	[bp+var_2], 20h	; jumptable 0001105E case 23

loc_11096:				; CODE XREF: sub_10F8D+103j
					; sub_10F8D+1A1j ...
		mov	ch, 5
		jmp	short loc_11040
; ---------------------------------------------------------------------------

loc_1109A:				; CODE XREF: sub_10F8D+D1j
					; DATA XREF: seg000:off_11420o
		cmp	ch, 0		; jumptable 0001105E case 9
		ja	short loc_110EC	; jumptable 0001105E case 5
		test	[bp+var_2], 2
		jnz	short loc_110CF
		or	[bp+var_2], 8
		mov	ch, 1
		jmp	short loc_11040
; ---------------------------------------------------------------------------

loc_110AE:				; CODE XREF: sub_10F8D+148j
					; sub_10F8D+155j ...
		jmp	loc_113EC	; jumptable 0001105E default case
; ---------------------------------------------------------------------------

loc_110B1:				; CODE XREF: sub_10F8D+D1j
					; DATA XREF: seg000:off_11420o
		mov	di, [bp+arg_0]	; jumptable 0001105E case 2
		mov	ax, ss:[di]
		add	[bp+arg_0], 2
		cmp	ch, 2
		jnb	short loc_110D2
		or	ax, ax
		jns	short loc_110CA
		neg	ax
		or	[bp+var_2], 2

loc_110CA:				; CODE XREF: sub_10F8D+135j
		mov	[bp+var_8], ax
		mov	ch, 3

loc_110CF:				; CODE XREF: sub_10F8D+117j
					; sub_10F8D+16Fj ...
		jmp	loc_11040
; ---------------------------------------------------------------------------

loc_110D2:				; CODE XREF: sub_10F8D+131j
		cmp	ch, 4
		jnz	short loc_110AE
		mov	[bp+var_A], ax
		inc	ch
		jmp	loc_11040
; ---------------------------------------------------------------------------

loc_110DF:				; CODE XREF: sub_10F8D+D1j
					; DATA XREF: seg000:off_11420o
		cmp	ch, 4		; jumptable 0001105E case 4
		jnb	short loc_110AE
		mov	ch, 4
		inc	[bp+var_A]
		jmp	loc_11040
; ---------------------------------------------------------------------------

loc_110EC:				; CODE XREF: sub_10F8D+D1j
					; sub_10F8D+110j
					; DATA XREF: ...
		xchg	ax, dx		; jumptable 0001105E case 5
		sub	al, 30h	; '0'
		cbw
		cmp	ch, 2
		ja	short loc_1110E
		mov	ch, 2
		xchg	ax, [bp+var_8]
		or	ax, ax
		jl	short loc_110CF
		shl	ax, 1
		mov	dx, ax
		shl	ax, 1
		shl	ax, 1
		add	ax, dx
		add	[bp+var_8], ax
		jmp	loc_11040
; ---------------------------------------------------------------------------

loc_1110E:				; CODE XREF: sub_10F8D+166j
		cmp	ch, 4
		jnz	short loc_110AE
		xchg	ax, [bp+var_A]
		or	ax, ax
		jz	short loc_110CF
		shl	ax, 1
		mov	dx, ax
		shl	ax, 1
		shl	ax, 1
		add	ax, dx
		add	[bp+var_A], ax
		jmp	loc_11040
; ---------------------------------------------------------------------------

loc_1112A:				; CODE XREF: sub_10F8D+D1j
					; DATA XREF: seg000:off_11420o
		or	[bp+var_2], 10h	; jumptable 0001105E case 6
		jmp	loc_11096
; ---------------------------------------------------------------------------

loc_11131:				; CODE XREF: sub_10F8D+D1j
					; DATA XREF: seg000:off_11420o
		or	[bp+var_2], 100h ; jumptable 0001105E case 7

loc_11136:				; CODE XREF: sub_10F8D+D1j
					; DATA XREF: seg000:off_11420o
		and	[bp+var_2], 0FFEFh ; jumptable 0001105E	case 8
		jmp	loc_11096
; ---------------------------------------------------------------------------

loc_1113D:				; CODE XREF: sub_10F8D+D1j
					; DATA XREF: seg000:off_11420o
		mov	bh, 8		; jumptable 0001105E case 11
		jmp	short loc_1114B
; ---------------------------------------------------------------------------

loc_11141:				; CODE XREF: sub_10F8D+D1j
					; DATA XREF: seg000:off_11420o
		mov	bh, 0Ah		; jumptable 0001105E case 12
		jmp	short loc_1114F
; ---------------------------------------------------------------------------

loc_11145:				; CODE XREF: sub_10F8D+D1j
					; DATA XREF: seg000:off_11420o
		mov	bh, 10h		; jumptable 0001105E case 13
		mov	bl, 0E9h ; 'È'
		add	bl, dl

loc_1114B:				; CODE XREF: sub_10F8D+1B2j
		mov	[bp+var_B], 0

loc_1114F:				; CODE XREF: sub_10F8D+1B6j
		mov	[bp+var_5], dl
		xor	dx, dx
		mov	[bp+var_6], dl
		mov	di, [bp+arg_0]
		mov	ax, ss:[di]
		jmp	short loc_1116F
; ---------------------------------------------------------------------------

loc_1115F:				; CODE XREF: sub_10F8D+D1j
					; DATA XREF: seg000:off_11420o
		mov	bh, 0Ah		; jumptable 0001105E case 10
		mov	[bp+var_6], 1
		mov	[bp+var_5], dl
		mov	di, [bp+arg_0]
		mov	ax, ss:[di]
		cwd

loc_1116F:				; CODE XREF: sub_10F8D+1D0j
		inc	di
		inc	di
		mov	word ptr [bp+arg_2], si
		test	[bp+var_2], 10h
		jz	short loc_11180
		mov	dx, ss:[di]
		inc	di
		inc	di

loc_11180:				; CODE XREF: sub_10F8D+1ECj
		mov	[bp+arg_0], di
		lea	di, [bp+var_45]
		or	ax, ax
		jnz	short loc_1119C
		or	dx, dx
		jnz	short loc_1119C
		cmp	[bp+var_A], 0
		jnz	short loc_111A0
		mov	byte ptr ss:[di], 0
		mov	ax, di
		jmp	short loc_111B0
; ---------------------------------------------------------------------------

loc_1119C:				; CODE XREF: sub_10F8D+1FBj
					; sub_10F8D+1FFj
		or	[bp+var_2], 4

loc_111A0:				; CODE XREF: sub_10F8D+205j
		push	dx
		push	ax
		push	ss
		push	di
		mov	al, bh
		cbw
		push	ax
		mov	al, [bp+var_6]
		push	ax
		push	bx
		call	sub_10CE2

loc_111B0:				; CODE XREF: sub_10F8D+20Dj
		push	ss
		pop	es
		mov	dx, [bp+var_A]
		or	dx, dx
		jge	short loc_111BC
		jmp	loc_112B0
; ---------------------------------------------------------------------------

loc_111BC:				; CODE XREF: sub_10F8D+22Aj
		jmp	loc_112BE
; ---------------------------------------------------------------------------

loc_111BF:				; CODE XREF: sub_10F8D+D1j
					; DATA XREF: seg000:off_11420o
		mov	[bp+var_5], dl	; jumptable 0001105E case 14
		mov	word ptr [bp+arg_2], si
		lea	di, [bp+var_46]
		mov	bx, [bp+arg_0]
		push	word ptr ss:[bx]
		inc	bx
		inc	bx
		mov	[bp+arg_0], bx
		test	[bp+var_2], 20h
		jz	short loc_111EA
		mov	dx, ss:[bx]
		inc	bx
		inc	bx
		mov	[bp+arg_0], bx
		push	ss
		pop	es
		call	sub_10F75
		mov	al, 3Ah	; ':'
		stosb

loc_111EA:				; CODE XREF: sub_10F8D+24Bj
		push	ss
		pop	es
		pop	dx
		call	sub_10F75
		mov	byte ptr ss:[di], 0
		mov	[bp+var_6], 0
		and	[bp+var_2], 0FFFBh
		lea	cx, [bp+var_46]
		sub	di, cx
		xchg	cx, di
		mov	dx, [bp+var_A]
		cmp	dx, cx
		jg	short loc_1120C
		mov	dx, cx

loc_1120C:				; CODE XREF: sub_10F8D+27Bj
		jmp	loc_112B0
; ---------------------------------------------------------------------------

loc_1120F:				; CODE XREF: sub_10F8D+D1j
					; DATA XREF: seg000:off_11420o
		mov	word ptr [bp+arg_2], si	; jumptable 0001105E case 16
		mov	[bp+var_5], dl
		mov	di, [bp+arg_0]
		mov	ax, ss:[di]
		add	[bp+arg_0], 2
		push	ss
		pop	es
		lea	di, [bp+var_45]
		xor	ah, ah
		mov	ss:[di], ax
		mov	cx, 1
		jmp	loc_112F3
; ---------------------------------------------------------------------------

loc_1122F:				; CODE XREF: sub_10F8D+D1j
					; DATA XREF: seg000:off_11420o
		mov	word ptr [bp+arg_2], si	; jumptable 0001105E case 17
		mov	[bp+var_5], dl
		mov	di, [bp+arg_0]
		test	[bp+var_2], 20h
		jnz	short loc_1124C
		mov	di, ss:[di]
		add	[bp+arg_0], 2
		push	ds
		pop	es
		assume es:dseg
		or	di, di
		jmp	short loc_11257
; ---------------------------------------------------------------------------

loc_1124C:				; CODE XREF: sub_10F8D+2B0j
		les	di, ss:[di]
		assume es:nothing
		add	[bp+arg_0], 4
		mov	ax, es
		or	ax, di

loc_11257:				; CODE XREF: sub_10F8D+2BDj
		jnz	short loc_1125E
		push	ds
		pop	es
		assume es:dseg
		mov	di, 0BD68h

loc_1125E:				; CODE XREF: sub_10F8D:loc_11257j
		call	sub_10FA7
		cmp	cx, [bp+var_A]
		jbe	short loc_11269
		mov	cx, [bp+var_A]

loc_11269:				; CODE XREF: sub_10F8D+2D7j
		jmp	loc_112F3
; ---------------------------------------------------------------------------

loc_1126C:				; CODE XREF: sub_10F8D+D1j
					; DATA XREF: seg000:off_11420o
		mov	word ptr [bp+arg_2], si	; jumptable 0001105E case 15
		mov	[bp+var_5], dl
		mov	di, [bp+arg_0]
		mov	cx, [bp+var_A]
		or	cx, cx
		jge	short loc_1127F
		mov	cx, 6

loc_1127F:				; CODE XREF: sub_10F8D+2EDj
		push	ss
		push	di
		push	cx
		push	ss
		lea	bx, [bp+var_45]
		push	bx
		push	dx
		mov	ax, 1
		and	ax, [bp+var_2]
		push	ax
		mov	ax, [bp+var_2]
		test	ax, 100h
		jz	short loc_112A0
		mov	ax, 8
		add	[bp+arg_0], 0Ah
		jmp	short loc_112A7
; ---------------------------------------------------------------------------

loc_112A0:				; CODE XREF: sub_10F8D+308j
		add	[bp+arg_0], 8
		mov	ax, 6

loc_112A7:				; CODE XREF: sub_10F8D+311j
		push	ax
		call	sub_11A0A
		push	ss
		pop	es
		assume es:nothing
		lea	di, [bp+var_45]

loc_112B0:				; CODE XREF: sub_10F8D+22Cj
					; sub_10F8D:loc_1120Cj
		test	[bp+var_2], 8
		jz	short loc_112CF
		mov	dx, [bp+var_8]
		or	dx, dx
		jle	short loc_112CF

loc_112BE:				; CODE XREF: sub_10F8D:loc_111BCj
		call	sub_10FA7
		cmp	byte ptr es:[di], 2Dh ;	'-'
		jnz	short loc_112C8
		dec	cx

loc_112C8:				; CODE XREF: sub_10F8D+338j
		sub	dx, cx
		jle	short loc_112CF
		mov	[bp+var_E], dx

loc_112CF:				; CODE XREF: sub_10F8D+328j
					; sub_10F8D+32Fj ...
		cmp	byte ptr es:[di], 2Dh ;	'-'
		jz	short loc_112E0
		mov	al, [bp+var_B]
		or	al, al
		jz	short loc_112F0
		dec	di
		mov	es:[di], al

loc_112E0:				; CODE XREF: sub_10F8D+346j
		cmp	[bp+var_E], 0
		jle	short loc_112F0
		mov	cx, [bp+var_A]
		or	cx, cx
		jge	short loc_112F0
		dec	[bp+var_E]

loc_112F0:				; CODE XREF: sub_10F8D+34Dj
					; sub_10F8D+357j ...
		call	sub_10FA7

loc_112F3:				; CODE XREF: sub_10F8D+29Fj
					; sub_10F8D:loc_11269j
		mov	si, di
		mov	di, [bp+var_4]
		mov	bx, [bp+var_8]
		mov	ax, 5
		and	ax, [bp+var_2]
		cmp	ax, 5
		jnz	short loc_11319
		mov	ah, [bp+var_5]
		cmp	ah, 6Fh	; 'o'
		jnz	short loc_1131B
		cmp	[bp+var_E], 0
		jg	short loc_11319
		mov	[bp+var_E], 1

loc_11319:				; CODE XREF: sub_10F8D+377j
					; sub_10F8D+385j
		jmp	short loc_11336
; ---------------------------------------------------------------------------

loc_1131B:				; CODE XREF: sub_10F8D+37Fj
		cmp	ah, 78h	; 'x'
		jz	short loc_11325
		cmp	ah, 58h	; 'X'
		jnz	short loc_11336

loc_11325:				; CODE XREF: sub_10F8D+391j
		or	[bp+var_2], 40h
		dec	bx
		dec	bx
		sub	[bp+var_E], 2
		jge	short loc_11336
		mov	[bp+var_E], 0

loc_11336:				; CODE XREF: sub_10F8D:loc_11319j
					; sub_10F8D+396j ...
		add	cx, [bp+var_E]
		test	[bp+var_2], 2
		jnz	short loc_1134C
		jmp	short loc_11348
; ---------------------------------------------------------------------------

loc_11342:				; CODE XREF: sub_10F8D+3BDj
		mov	al, 20h	; ' '
		call	sub_10FB4
		dec	bx

loc_11348:				; CODE XREF: sub_10F8D+3B3j
		cmp	bx, cx
		jg	short loc_11342

loc_1134C:				; CODE XREF: sub_10F8D+3B1j
		test	[bp+var_2], 40h
		jz	short loc_1135E
		mov	al, 30h	; '0'
		call	sub_10FB4
		mov	al, [bp+var_5]
		call	sub_10FB4

loc_1135E:				; CODE XREF: sub_10F8D+3C4j
		mov	dx, [bp+var_E]
		or	dx, dx
		jle	short loc_1138C
		sub	cx, dx
		sub	bx, dx
		mov	al, es:[si]
		cmp	al, 2Dh	; '-'
		jz	short loc_11378
		cmp	al, 20h	; ' '
		jz	short loc_11378
		cmp	al, 2Bh	; '+'
		jnz	short loc_1137F

loc_11378:				; CODE XREF: sub_10F8D+3E1j
					; sub_10F8D+3E5j
		lods	byte ptr es:[si]
		call	sub_10FB4
		dec	cx
		dec	bx

loc_1137F:				; CODE XREF: sub_10F8D+3E9j
		xchg	cx, dx
		jcxz	short loc_1138A

loc_11383:				; CODE XREF: sub_10F8D+3FBj
		mov	al, 30h	; '0'
		call	sub_10FB4
		loop	loc_11383

loc_1138A:				; CODE XREF: sub_10F8D+3F4j
		xchg	cx, dx

loc_1138C:				; CODE XREF: sub_10F8D+3D6j
		jcxz	short loc_113A0
		sub	bx, cx

loc_11390:				; CODE XREF: sub_10F8D:loc_1139Ej
		lods	byte ptr es:[si]
		mov	ss:[di], al
		inc	di
		dec	byte ptr [bp+var_14]
		jg	short loc_1139E
		call	sub_10FBD

loc_1139E:				; CODE XREF: sub_10F8D+40Cj
		loop	loc_11390

loc_113A0:				; CODE XREF: sub_10F8D:loc_1138Cj
		or	bx, bx
		jle	short loc_113AD
		mov	cx, bx

loc_113A6:				; CODE XREF: sub_10F8D+41Ej
		mov	al, 20h	; ' '
		call	sub_10FB4
		loop	loc_113A6

loc_113AD:				; CODE XREF: sub_10F8D+415j
		jmp	loc_10FFD
; ---------------------------------------------------------------------------

loc_113B0:				; CODE XREF: sub_10F8D+D1j
					; DATA XREF: seg000:off_11420o
		mov	word ptr [bp+arg_2], si	; jumptable 0001105E case 18
		mov	di, [bp+arg_0]
		test	[bp+var_2], 20h
		jnz	short loc_113C8
		mov	di, ss:[di]
		add	[bp+arg_0], 2
		push	ds
		pop	es
		assume es:dseg
		jmp	short loc_113CF
; ---------------------------------------------------------------------------

loc_113C8:				; CODE XREF: sub_10F8D+42Ej
		les	di, ss:[di]
		assume es:nothing
		add	[bp+arg_0], 4

loc_113CF:				; CODE XREF: sub_10F8D+439j
		mov	ax, 50h	; 'P'
		sub	al, byte ptr [bp+var_14]
		add	ax, [bp+var_12]
		mov	es:[di], ax
		test	[bp+var_2], 10h
		jz	short loc_113E9
		inc	di
		inc	di
		mov	word ptr es:[di], 0

loc_113E9:				; CODE XREF: sub_10F8D+453j
		jmp	loc_10FFA
; ---------------------------------------------------------------------------

loc_113EC:				; CODE XREF: sub_10F8D+CCj
					; sub_10F8D+D1j ...
		mov	si, [bp+var_10]	; jumptable 0001105E default case
		mov	es, word ptr [bp+arg_2+2]
		mov	di, [bp+var_4]
		mov	al, 25h	; '%'

loc_113F7:				; CODE XREF: sub_10F8D+471j
		call	sub_10FB4
		lods	byte ptr es:[si]
		or	al, al
		jnz	short loc_113F7

loc_11400:				; CODE XREF: sub_10F8D:loc_11018j
		cmp	byte ptr [bp+var_14], 50h ; 'P'
		jge	short loc_11409
		call	sub_10FBD

loc_11409:				; CODE XREF: sub_10F8D+477j
		pop	es
		cmp	[bp+var_16], 0
		jz	short loc_11415
		mov	ax, 0FFFFh
		jmp	short loc_11418
; ---------------------------------------------------------------------------

loc_11415:				; CODE XREF: sub_10F8D+481j
		mov	ax, [bp+var_12]

loc_11418:				; CODE XREF: sub_10F8D+486j
		pop	di
		pop	si
		mov	sp, bp
		pop	bp
		retn	0Ch
; END OF FUNCTION CHUNK	FOR sub_10F8D
; ---------------------------------------------------------------------------
off_11420	dw offset loc_1107C	; DATA XREF: sub_10F8D+D1r
		dw offset loc_11066	; jump table for switch	statement
		dw offset loc_110B1
		dw offset loc_11071
		dw offset loc_110DF
		dw offset loc_110EC
		dw offset loc_1112A
		dw offset loc_11131
		dw offset loc_11136
		dw offset loc_1109A
		dw offset loc_1115F
		dw offset loc_1113D
		dw offset loc_11141
		dw offset loc_11145
		dw offset loc_111BF
		dw offset loc_1126C
		dw offset loc_1120F
		dw offset loc_1122F
		dw offset loc_113B0
		dw offset loc_113EC
		dw offset loc_113EC
		dw offset loc_113EC
		dw offset loc_1108C
		dw offset loc_11092

; =============== S U B	R O U T	I N E =======================================


sub_11450	proc far		; CODE XREF: sub_11A0Aj
					; DATA XREF: dseg:off_29B3Ao
		mov	dx, 0BDD0h
		jmp	short loc_11458
; ---------------------------------------------------------------------------

loc_11455:				; DATA XREF: dseg:off_29B3Ao
		mov	dx, 0BDD5h

loc_11458:				; CODE XREF: sub_11450+3j
		mov	cx, 5
		mov	ah, 40h
		mov	bx, 2
		int	21h		; DOS -	2+ - WRITE TO FILE WITH	HANDLE
					; BX = file handle, CX = number	of bytes to write, DS:DX -> buffer
		mov	cx, 27h
		mov	dx, 0BDDAh
		mov	ah, 40h
		int	21h		; DOS -	2+ - WRITE TO FILE WITH	HANDLE
					; BX = file handle, CX = number	of bytes to write, DS:DX -> buffer
		jmp	near ptr sub_10A1E
sub_11450	endp

; ---------------------------------------------------------------------------
word_1146F	dw 0			; DATA XREF: sub_1147Br sub_1147B+1Dr	...
word_11471	dw 0			; DATA XREF: sub_1147B+14w
					; sub_1147B+27w ...
word_11473	dw 0			; DATA XREF: sub_1147B+4Cw
					; sub_1154F+19w ...
word_11475	dw 0			; DATA XREF: sub_1147B+32r
					; sub_1147B:loc_114CEr	...
word_11477	dw 0			; DATA XREF: sub_11769+1r seg000:1863w
word_11479	dw 0			; DATA XREF: sub_11769+7r seg000:1868w

; =============== S U B	R O U T	I N E =======================================


sub_1147B	proc near		; CODE XREF: sub_115AF+18p
		cmp	dx, cs:word_1146F
		jz	short loc_114B9
		mov	ds, dx
		assume ds:nothing
		mov	ds, word ptr ds:2
		assume ds:dseg
		cmp	word_1DCE2, 0
		jz	short loc_11496
		mov	cs:word_11471, ds
		jmp	short loc_114CE
; ---------------------------------------------------------------------------

loc_11496:				; CODE XREF: sub_1147B+12j
		mov	ax, ds
		cmp	ax, cs:word_1146F
		jz	short loc_114B4
		mov	ax, word_1DCE8
		mov	cs:word_11471, ax
		push	ds
		xor	ax, ax
		push	ax
		call	sub_1154F
		mov	ds, cs:word_11475
		jmp	short loc_114D7
; ---------------------------------------------------------------------------

loc_114B4:				; CODE XREF: sub_1147B+22j
		mov	dx, cs:word_1146F

loc_114B9:				; CODE XREF: sub_1147B+5j
		mov	cs:word_1146F, 0
		mov	cs:word_11471, 0
		mov	cs:word_11473, 0

loc_114CE:				; CODE XREF: sub_1147B+19j
		mov	ds, cs:word_11475
		push	dx
		xor	ax, ax
		push	ax

loc_114D7:				; CODE XREF: sub_1147B+37j
		call	sub_11940
		add	sp, 4
		retn
sub_1147B	endp


; =============== S U B	R O U T	I N E =======================================


sub_114DE	proc near		; CODE XREF: sub_115AF:loc_115CCp
		mov	ds, dx
		push	ds
		mov	es, word_1DCE2
		mov	word_1DCE2, 0
		mov	word_1DCE8, es
		cmp	dx, cs:word_1146F
		jz	short loc_11524
		cmp	word ptr es:2, 0
		jnz	short loc_11524
		mov	ax, word_1DCE0
		pop	bx
		push	es
		add	es:0, ax
		mov	cx, es
		add	dx, ax
		mov	es, dx
		cmp	word ptr es:2, 0
		jnz	short loc_1151D
		mov	es:8, cx
		jmp	short loc_11527
; ---------------------------------------------------------------------------

loc_1151D:				; CODE XREF: sub_114DE+36j
		mov	es:2, cx
		jmp	short loc_11527
; ---------------------------------------------------------------------------

loc_11524:				; CODE XREF: sub_114DE+16j
					; sub_114DE+1Ej
		call	sub_11578

loc_11527:				; CODE XREF: sub_114DE+3Dj
					; sub_114DE+44j
		pop	es
		mov	ax, es
		add	ax, es:0
		mov	ds, ax
		cmp	word_1DCE2, 0
		jz	short loc_11539
		retn
; ---------------------------------------------------------------------------

loc_11539:				; CODE XREF: sub_114DE+58j
		mov	ax, word_1DCE0
		add	es:0, ax
		mov	ax, es
		mov	bx, ds
		add	bx, word_1DCE0
		mov	es, bx
		mov	es:2, ax
sub_114DE	endp ; sp-analysis failed


; =============== S U B	R O U T	I N E =======================================


sub_1154F	proc near		; CODE XREF: sub_1147B+2Fp
					; sub_116EC+66p
		mov	bx, ds
		cmp	bx, word_1DCE6
		jz	short loc_11570
		mov	es, word_1DCE6
		mov	ds, word_1DCE4
		mov	word_1DCE6, es
		mov	word ptr es:4, ds
		mov	cs:word_11473, ds
		mov	ds, bx
		retn
; ---------------------------------------------------------------------------

loc_11570:				; CODE XREF: sub_1154F+6j
		mov	cs:word_11473, 0
		retn
sub_1154F	endp


; =============== S U B	R O U T	I N E =======================================


sub_11578	proc near		; CODE XREF: sub_114DE:loc_11524p
		mov	ax, cs:word_11473
		or	ax, ax
		jz	short loc_115A1
		mov	bx, ss
		pushf
		cli
		mov	ss, ax
		mov	es, word ptr ss:6
		mov	word ptr ss:6, ds
		mov	word_1DCE4, ss
		mov	ss, bx
		popf
		mov	word ptr es:4, ds
		mov	word_1DCE6, es
		retn
; ---------------------------------------------------------------------------

loc_115A1:				; CODE XREF: sub_11578+6j
		mov	cs:word_11473, ds
		mov	word_1DCE4, ds
		mov	word_1DCE6, ds
		retn
sub_11578	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_115AF	proc far		; CODE XREF: sub_11769+71p
					; sub_117E5+40p ...

arg_2		= word ptr  8

		push	bp
		mov	bp, sp
		push	si
		push	di
		mov	cs:word_11475, ds
		mov	dx, [bp+arg_2]
		or	dx, dx
		jz	short loc_115CF
		cmp	dx, cs:word_11471
		jnz	short loc_115CC
		call	sub_1147B
		jmp	short loc_115CF
; ---------------------------------------------------------------------------

loc_115CC:				; CODE XREF: sub_115AF+16j
		call	sub_114DE

loc_115CF:				; CODE XREF: sub_115AF+Fj
					; sub_115AF+1Bj
		mov	ds, cs:word_11475
		pop	di
		pop	si
		pop	bp
		retf
sub_115AF	endp


; =============== S U B	R O U T	I N E =======================================


sub_115D8	proc near		; CODE XREF: sub_116EC:loc_11741p
		push	ax
		mov	ds, cs:word_11475
		xor	ax, ax
		push	ax
		push	ax
		call	sub_1197F
		add	sp, 4
		and	ax, 0Fh
		jz	short loc_11601
		mov	dx, 10h
		sub	dx, ax
		xor	ax, ax
		mov	ds, cs:word_11475
		push	ax
		push	dx
		call	sub_1197F
		add	sp, 4

loc_11601:				; CODE XREF: sub_115D8+13j
		pop	ax
		push	ax
		xor	bx, bx
		mov	bl, ah
		mov	cl, 4
		shr	bx, cl
		shl	ax, cl
		mov	ds, cs:word_11475
		push	bx
		push	ax
		call	sub_1197F
		add	sp, 4
		pop	bx
		cmp	ax, 0FFFFh
		jz	short loc_11638
		mov	cs:word_1146F, dx
		mov	cs:word_11471, dx
		mov	ds, dx
		mov	word_1DCE0, bx
		mov	word_1DCE2, dx
		mov	ax, 4
		retn
; ---------------------------------------------------------------------------

loc_11638:				; CODE XREF: sub_115D8+46j
		xor	ax, ax
		cwd
		retn
sub_115D8	endp


; =============== S U B	R O U T	I N E =======================================


sub_1163C	proc near		; CODE XREF: sub_116EC:loc_1173Cp
		push	ax
		mov	ds, cs:word_11475
		xor	ax, ax
		push	ax
		push	ax
		call	sub_1197F
		pop	bx
		pop	bx
		and	ax, 0Fh
		jz	short loc_11664
		mov	dx, 10h
		sub	dx, ax
		xor	ax, ax
		mov	ds, cs:word_11475
		push	ax
		push	dx
		call	sub_1197F
		add	sp, 4

loc_11664:				; CODE XREF: sub_1163C+12j
		pop	ax
		push	ax
		xor	bx, bx
		mov	bl, ah
		mov	cl, 4
		shr	bx, cl
		shl	ax, cl
		mov	ds, cs:word_11475
		push	bx
		push	ax
		call	sub_1197F
		add	sp, 4
		pop	bx
		cmp	ax, 0FFFFh
		jz	short loc_116BB
		and	ax, 0Fh
		jnz	short loc_116A0

loc_11688:				; CODE XREF: sub_1163C+7Dj
		mov	cx, cs:word_11471
		mov	cs:word_11471, dx
		mov	ds, dx
		mov	word_1DCE0, bx
		mov	word_1DCE2, cx
		mov	ax, 4
		retn
; ---------------------------------------------------------------------------

loc_116A0:				; CODE XREF: sub_1163C+4Aj
		push	bx
		push	dx
		neg	ax
		add	ax, 10h
		xor	bx, bx
		push	bx
		push	ax
		call	sub_1197F
		add	sp, 4
		pop	dx
		pop	bx
		cmp	ax, 0FFFFh
		jz	short loc_116BB
		inc	dx
		jmp	short loc_11688
; ---------------------------------------------------------------------------

loc_116BB:				; CODE XREF: sub_1163C+45j
					; sub_1163C+7Aj
		xor	ax, ax
		cwd
		retn
sub_1163C	endp


; =============== S U B	R O U T	I N E =======================================


sub_116BF	proc near		; CODE XREF: sub_116EC:loc_11746p
		mov	bx, dx
		sub	word_1DCE0, ax
		add	dx, word_1DCE0
		mov	ds, dx
		mov	word_1DCE0, ax
		mov	word_1DCE2, bx
		mov	bx, dx
		add	bx, word_1DCE0
		mov	ds, bx
		mov	word_1DCE2, dx
		mov	ax, 4
		retn
sub_116BF	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_116E2	proc far		; CODE XREF: seg000:1B84p
					; sub_124AA+D2p

arg_2		= word ptr  6

		push	bp
		mov	bp, sp
		xor	dx, dx
		mov	ax, [bp+arg_2]
		jmp	short loc_116F5
sub_116E2	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_116EC	proc far		; CODE XREF: sub_11769+Ep seg000:18ADp

arg_0		= word ptr  6
arg_2		= word ptr  8

		push	bp
		mov	bp, sp
		mov	dx, [bp+arg_2]
		mov	ax, [bp+arg_0]

loc_116F5:				; CODE XREF: sub_116E2+8j
		mov	cx, ax
		or	cx, dx
		push	si
		push	di
		mov	cs:word_11475, ds
		jz	short loc_11760
		add	ax, 13h
		adc	dx, 0
		jb	short loc_1174B
		test	dx, 0FFF0h
		jnz	short loc_1174B
		mov	cl, 4
		shr	ax, cl
		shl	dx, cl
		or	ah, dl
		mov	dx, cs:word_1146F
		or	dx, dx
		jz	short loc_11741
		mov	dx, cs:word_11473
		or	dx, dx
		jz	short loc_1173C
		mov	bx, dx

loc_1172C:				; CODE XREF: sub_116EC+4Ej
		mov	ds, dx
		cmp	word_1DCE0, ax
		jnb	short loc_11750
		mov	dx, word_1DCE6
		cmp	dx, bx
		jnz	short loc_1172C

loc_1173C:				; CODE XREF: sub_116EC+3Cj
		call	sub_1163C
		jmp	short loc_11760
; ---------------------------------------------------------------------------

loc_11741:				; CODE XREF: sub_116EC+33j
		call	sub_115D8
		jmp	short loc_11760
; ---------------------------------------------------------------------------

loc_11746:				; CODE XREF: sub_116EC:loc_11750j
		call	sub_116BF
		jmp	short loc_11760
; ---------------------------------------------------------------------------

loc_1174B:				; CODE XREF: sub_116EC+1Cj
					; sub_116EC+22j
		xor	ax, ax
		cwd
		jmp	short loc_11760
; ---------------------------------------------------------------------------

loc_11750:				; CODE XREF: sub_116EC+46j
		ja	short loc_11746
		call	sub_1154F
		mov	bx, word_1DCE8
		mov	word_1DCE2, bx
		mov	ax, offset word_1DCE4

loc_11760:				; CODE XREF: sub_116EC+14j
					; sub_116EC+53j ...
		mov	ds, cs:word_11475
		pop	di
		pop	si
		pop	bp
		retf
sub_116EC	endp


; =============== S U B	R O U T	I N E =======================================


sub_11769	proc near		; CODE XREF: seg000:loc_118A5p
		push	bx
		mov	si, cs:word_11477
		push	si
		mov	si, cs:word_11479
		push	si
		push	cs
		call	near ptr sub_116EC
		add	sp, 4
		or	dx, dx
		jnz	short loc_11783
		pop	bx
		retn
; ---------------------------------------------------------------------------

loc_11783:				; CODE XREF: sub_11769+16j
		pop	ds
		mov	es, dx
		push	es
		push	ds
		push	bx
		mov	dx, word_1DCE0
		cld
		dec	dx
		mov	di, 4
		mov	si, di
		mov	cx, 6
		rep movsw
		or	dx, dx
		jz	short loc_117D4
		mov	ax, es
		inc	ax
		mov	es, ax
		assume es:nothing
		mov	ax, ds
		inc	ax
		mov	ds, ax
		assume ds:nothing

loc_117A7:				; CODE XREF: sub_11769+69j
		xor	di, di
		mov	si, di
		mov	cx, dx
		cmp	cx, 1000h
		jbe	short loc_117B6
		mov	cx, 1000h

loc_117B6:				; CODE XREF: sub_11769+48j
		shl	cx, 1
		shl	cx, 1
		shl	cx, 1
		rep movsw
		sub	dx, 1000h
		jbe	short loc_117D4
		mov	ax, es
		add	ax, 1000h
		mov	es, ax
		assume es:seg000
		mov	ax, ds
		add	ax, 1000h
		mov	ds, ax
		assume ds:nothing
		jmp	short loc_117A7
; ---------------------------------------------------------------------------

loc_117D4:				; CODE XREF: sub_11769+32j
					; sub_11769+59j
		mov	ds, cs:word_11475
		assume ds:dseg
		push	cs
		call	near ptr sub_115AF
		add	sp, 4
		pop	dx
		mov	ax, 4
		retn
sub_11769	endp


; =============== S U B	R O U T	I N E =======================================


sub_117E5	proc near		; CODE XREF: seg000:loc_118A0p
		cmp	bx, cs:word_11471
		jz	short loc_11831
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
		jz	short loc_1181D
		mov	es:2, di
		jmp	short loc_11822
; ---------------------------------------------------------------------------

loc_1181D:				; CODE XREF: sub_117E5+2Fj
		mov	es:8, di

loc_11822:				; CODE XREF: sub_117E5+36j
		mov	si, bx
		push	cs
		call	near ptr sub_115AF
		add	sp, 4
		mov	dx, si
		mov	ax, 4
		retn
; ---------------------------------------------------------------------------

loc_11831:				; CODE XREF: sub_117E5+5j
		push	bx
		mov	es, bx
		mov	es:0, ax
		add	bx, ax
		push	bx
		xor	ax, ax
		push	ax
		call	sub_11940
		add	sp, 4
		pop	dx
		mov	ax, 4
		retn
sub_117E5	endp

; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		xor	dx, dx
		jmp	short loc_11856
; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		mov	dx, [bp+0Ch]

loc_11856:				; CODE XREF: seg000:184Ej
		mov	ax, [bp+0Ah]
		mov	bx, [bp+8]
		push	si
		push	di
		mov	cs:word_11475, ds
		mov	cs:word_11477, dx
		mov	cs:word_11479, ax
		or	bx, bx
		jz	short loc_118AA
		mov	cx, ax
		or	cx, dx
		jz	short loc_118B5
		add	ax, 13h
		adc	dx, 0
		jb	short loc_118BE
		test	dx, 0FFF0h
		jnz	short loc_118BE
		mov	cl, 4
		shr	ax, cl
		shl	dx, cl
		or	ah, dl
		mov	es, bx
		mov	cx, es:0
		cmp	cx, ax
		jb	short loc_118A5
		ja	short loc_118A0
		mov	dx, bx
		mov	ax, 4
		jmp	short loc_118C1
; ---------------------------------------------------------------------------

loc_118A0:				; CODE XREF: seg000:1897j
		call	sub_117E5
		jmp	short loc_118C1
; ---------------------------------------------------------------------------

loc_118A5:				; CODE XREF: seg000:1895j
		call	sub_11769
		jmp	short loc_118C1
; ---------------------------------------------------------------------------

loc_118AA:				; CODE XREF: seg000:186Ej
		push	dx
		push	ax
		push	cs
		call	near ptr sub_116EC
		add	sp, 4
		jmp	short loc_118C1
; ---------------------------------------------------------------------------

loc_118B5:				; CODE XREF: seg000:1874j
		push	bx
		push	ax
		push	cs
		call	near ptr sub_115AF
		add	sp, 4

loc_118BE:				; CODE XREF: seg000:187Cj seg000:1882j
		xor	ax, ax
		cwd

loc_118C1:				; CODE XREF: seg000:189Ej seg000:18A3j ...
		mov	ds, cs:word_11475
		pop	di
		pop	si
		pop	bp
		retf

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_118CA	proc near		; CODE XREF: sub_11940+2Fp
					; sub_1197F+7Ap

arg_0		= word ptr  4
arg_2		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	si, [bp+arg_2]
		inc	si
		sub	si, word_1DD3E
		add	si, 3Fh	; '?'
		mov	cl, 6
		shr	si, cl
		cmp	si, word_29AE2
		jnz	short loc_118F5

loc_118E3:				; CODE XREF: sub_118CA+5Fj
		mov	ax, [bp+arg_2]
		mov	dx, [bp+arg_0]
		mov	word_1DD4C, ax
		mov	word_1DD4A, dx
		mov	ax, 1
		jmp	short loc_1193B
; ---------------------------------------------------------------------------

loc_118F5:				; CODE XREF: sub_118CA+17j
		mov	cl, 6
		shl	si, cl
		mov	dx, word_1DD50
		mov	ax, si
		add	ax, word_1DD3E
		cmp	ax, dx
		jbe	short loc_1190D
		mov	si, dx
		sub	si, word_1DD3E

loc_1190D:				; CODE XREF: sub_118CA+3Bj
		push	si
		push	word_1DD3E
		nop
		push	cs
		call	near ptr sub_11B59
		pop	cx
		pop	cx
		mov	dx, ax
		cmp	dx, 0FFFFh
		jnz	short loc_1192B
		mov	ax, si
		mov	cl, 6
		shr	ax, cl
		mov	word_29AE2, ax
		jmp	short loc_118E3
; ---------------------------------------------------------------------------

loc_1192B:				; CODE XREF: sub_118CA+54j
		mov	ax, word_1DD3E
		add	ax, dx
		mov	word_1DD50, ax
		mov	word_1DD4E, 0
		xor	ax, ax

loc_1193B:				; CODE XREF: sub_118CA+29j
		pop	si
		pop	bp
		retn	4
sub_118CA	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_11940	proc near		; CODE XREF: sub_1147B:loc_114D7p
					; sub_117E5+59p

arg_0		= word ptr  4
arg_2		= word ptr  6

		push	bp
		mov	bp, sp
		mov	cx, word_1DD48
		mov	bx, word_1DD46
		mov	dx, [bp+arg_2]
		mov	ax, [bp+arg_0]
		call	sub_10DC4
		jb	short loc_11976
		mov	cx, word_1DD50
		mov	bx, word_1DD4E
		mov	dx, [bp+arg_2]
		mov	ax, [bp+arg_0]
		call	sub_10DC4
		ja	short loc_11976
		push	[bp+arg_2]
		push	[bp+arg_0]
		call	sub_118CA
		or	ax, ax
		jnz	short loc_1197B

loc_11976:				; CODE XREF: sub_11940+14j
					; sub_11940+27j
		mov	ax, 0FFFFh
		jmp	short loc_1197D
; ---------------------------------------------------------------------------

loc_1197B:				; CODE XREF: sub_11940+34j
		xor	ax, ax

loc_1197D:				; CODE XREF: sub_11940+39j
		pop	bp
		retn
sub_11940	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1197F	proc near		; CODE XREF: sub_115D8+Ap
					; sub_115D8+23p ...

var_8		= word ptr -8
var_6		= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  4
arg_2		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 8
		mov	ax, word_1DD4C
		xor	dx, dx
		mov	cl, 4
		call	near ptr sub_10C05
		add	ax, word_1DD4A
		adc	dx, 0
		add	ax, [bp+arg_0]
		adc	dx, [bp+arg_2]
		cmp	dx, 0Fh
		jl	short loc_119B0
		jg	short loc_119A8
		cmp	ax, 0FFFFh
		jbe	short loc_119B0

loc_119A8:				; CODE XREF: sub_1197F+22j
					; sub_1197F+52j ...
		mov	dx, 0FFFFh
		mov	ax, 0FFFFh
		jmp	short loc_11A06
; ---------------------------------------------------------------------------

loc_119B0:				; CODE XREF: sub_1197F+20j
					; sub_1197F+27j
		mov	dx, word_1DD4C
		mov	ax, word_1DD4A
		mov	cx, [bp+arg_2]
		mov	bx, [bp+arg_0]
		call	near ptr sub_10C26
		mov	[bp+var_2], dx
		mov	[bp+var_4], ax
		mov	cx, word_1DD48
		mov	bx, word_1DD46
		call	sub_10DC4
		jb	short loc_119A8
		mov	cx, word_1DD50
		mov	bx, word_1DD4E
		mov	dx, [bp+var_2]
		mov	ax, [bp+var_4]
		call	sub_10DC4
		ja	short loc_119A8
		mov	ax, word_1DD4C
		mov	dx, word_1DD4A
		mov	[bp+var_6], ax
		mov	[bp+var_8], dx
		push	[bp+var_2]
		push	[bp+var_4]
		call	sub_118CA
		or	ax, ax
		jz	short loc_119A8
		mov	dx, [bp+var_6]
		mov	ax, [bp+var_8]

loc_11A06:				; CODE XREF: sub_1197F+2Fj
		mov	sp, bp
		pop	bp
		retn
sub_1197F	endp ; sp-analysis failed


; =============== S U B	R O U T	I N E =======================================

; Attributes: thunk

sub_11A0A	proc near		; CODE XREF: sub_10F8D+31Bp
		jmp	off_29B3A
sub_11A0A	endp

; ---------------------------------------------------------------------------
word_11A0E	dw 0			; DATA XREF: seg000:1A1Cw seg000:1AF3r ...
; ---------------------------------------------------------------------------
		pop	word_29AEA
		pop	word_29AEC
		pop	word_29AEE
		mov	cs:word_11A0E, ds
		mov	word_29AF0, si
		mov	word_29AF2, di
		cld
		mov	es, word_1DD3E
		mov	si, 80h	; 'Ä'
		xor	ah, ah
		lods	byte ptr es:[si]
		inc	ax
		mov	bp, es
		xchg	dx, si
		xchg	ax, bx
		mov	si, word_1DD38
		inc	si
		inc	si
		mov	cx, 1
		cmp	byte ptr word_1DD40, 3
		jb	short loc_11A5C
		mov	es, word_1DD3A
		mov	di, si
		mov	cl, 7Fh	; ''
		xor	al, al
		repne scasb
		jcxz	short loc_11AA3
		xor	cl, 7Fh

loc_11A5C:				; CODE XREF: seg000:1A49j
		push	ax
		mov	ax, cx
		add	ax, bx
		inc	ax
		and	ax, 0FFFEh
		mov	di, sp
		sub	di, ax
		jb	short loc_11AA3
		mov	sp, di
		push	es
		pop	ds
		push	ss
		pop	es
		push	cx
		dec	cx
		rep movsb
		xor	al, al
		stosb
		mov	ds, bp
		xchg	si, dx
		xchg	bx, cx
		mov	ax, bx
		mov	dx, ax
		inc	bx

loc_11A83:				; CODE XREF: seg000:1A9Dj seg000:1AA1j
		call	sub_11AA8
		ja	short loc_11A93

loc_11A88:				; CODE XREF: seg000:1A91j
		jb	short loc_11AEE
		cmp	al, 0Dh
		jz	short loc_11A9F
		call	sub_11AA8
		ja	short loc_11A88

loc_11A93:				; CODE XREF: seg000:1A86j
		cmp	al, 20h	; ' '
		jz	short loc_11A9F
		cmp	al, 0Dh
		jz	short loc_11A9F
		cmp	al, 9
		jnz	short loc_11A83

loc_11A9F:				; CODE XREF: seg000:1A8Cj seg000:1A95j ...
		xor	al, al
		jmp	short loc_11A83
; ---------------------------------------------------------------------------

loc_11AA3:				; CODE XREF: seg000:1A57j seg000:1A69j ...
		nop
		nop
		jmp	near ptr sub_10A1E

; =============== S U B	R O U T	I N E =======================================


sub_11AA8	proc near		; CODE XREF: seg000:loc_11A83p
					; seg000:1A8Ep
		or	ax, ax
		jz	short loc_11AB3
		inc	dx
		stosb
		or	al, al
		jnz	short loc_11AB3
		inc	bx

loc_11AB3:				; CODE XREF: sub_11AA8+2j sub_11AA8+8j
		xchg	ah, al
		xor	al, al
		stc
		jcxz	short locret_11AED
		lodsb
		cmp	dh, 1
		jz	short loc_11AD2
		xor	dh, dh
		cmp	al, 81h	; 'Å'
		jb	short loc_11AD4
		cmp	al, 0A0h ; '†'
		jb	short loc_11AD2
		cmp	al, 0E0h ; '‡'
		jb	short loc_11AD4
		cmp	al, 0FDh ; '˝'
		jnb	short loc_11AD4

loc_11AD2:				; CODE XREF: sub_11AA8+16j
					; sub_11AA8+20j
		inc	dh

loc_11AD4:				; CODE XREF: sub_11AA8+1Cj
					; sub_11AA8+24j ...
		dec	cx
		sub	al, 22h	; '"'
		jz	short locret_11AED
		add	al, 22h	; '"'
		cmp	al, 5Ch	; '\'
		jnz	short loc_11AEB
		cmp	dh, 0
		jnz	short loc_11AEB
		cmp	byte ptr [si], 22h ; '"'
		jnz	short loc_11AEB
		lodsb
		dec	cx

loc_11AEB:				; CODE XREF: sub_11AA8+35j
					; sub_11AA8+3Aj ...
		or	si, si

locret_11AED:				; CODE XREF: sub_11AA8+10j
					; sub_11AA8+2Fj
		retn
sub_11AA8	endp

; ---------------------------------------------------------------------------

loc_11AEE:				; CODE XREF: seg000:loc_11A88j
		pop	cx
		xor	dh, dh
		add	cx, dx
		mov	ds, cs:word_11A0E
		mov	word_29AE4, bx
		inc	bx
		add	bx, bx
		add	bx, bx
		mov	si, sp
		mov	bp, sp
		sub	bp, bx
		jb	short loc_11AA3
		mov	sp, bp
		mov	word_29AE6, bp
		mov	word_29AE8, ss

loc_11B13:				; CODE XREF: seg000:1B24j
		jcxz	short loc_11B26
		mov	[bp+0],	si
		mov	word ptr [bp+2], ss
		add	bp, 4

loc_11B1E:				; CODE XREF: seg000:1B22j
		lods	byte ptr ss:[si]
		or	al, al
		loopne	loc_11B1E
		jz	short loc_11B13

loc_11B26:				; CODE XREF: seg000:loc_11B13j
		xor	ax, ax
		mov	[bp+0],	ax
		mov	[bp+2],	ax
		mov	ds, cs:word_11A0E
		mov	si, word_29AF0
		mov	di, word_29AF2
		push	word_29AEE
		push	word_29AEC
		mov	ax, word_29AE4
		mov	word_1DD2E, ax
		mov	ax, word_29AE8
		mov	word_1DD32, ax
		mov	ax, word_29AE6
		mov	word_1DD30, ax
		jmp	word_29AEA

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_11B59	proc far		; CODE XREF: sub_118CA+4Ap

arg_0		= word ptr  6
arg_2		= word ptr  8

		push	bp
		mov	bp, sp
		mov	ah, 4Ah	; 'J'
		mov	bx, [bp+arg_2]
		mov	es, [bp+arg_0]
		int	21h		; DOS -	2+ - ADJUST MEMORY BLOCK SIZE (SETBLOCK)
					; ES = segment address of block	to change
					; BX = new size	in paragraphs
		jb	short loc_11B6D
		mov	ax, 0FFFFh
		jmp	short loc_11B73
; ---------------------------------------------------------------------------

loc_11B6D:				; CODE XREF: sub_11B59+Dj
		push	bx
		push	ax
		call	sub_10C86
		pop	ax

loc_11B73:				; CODE XREF: sub_11B59+12j
		pop	bp
		retf
sub_11B59	endp

; ---------------------------------------------------------------------------
		push	si
		push	di
		mov	es, word_1DD3A
		xor	di, di
		push	es
		push	word_1DD3C
		nop
		push	cs
		call	near ptr sub_116E2
		pop	bx
		mov	bx, ax
		pop	es
		mov	word ptr dword_29AF4, ax
		mov	word ptr dword_29AF4+2,	dx
		push	ds
		mov	ds, dx
		or	ax, dx
		jnz	short loc_11B9E
		nop
		nop
		jmp	near ptr sub_10A1E
; ---------------------------------------------------------------------------

loc_11B9E:				; CODE XREF: seg000:1B97j
		xor	ax, ax
		mov	cx, 0FFFFh
		cmp	byte ptr es:[di], 0
		jz	short loc_11BB8

loc_11BA9:				; CODE XREF: seg000:1BB6j
		mov	[bx], di
		mov	word ptr [bx+2], es
		add	bx, 4
		repne scasb
		cmp	es:[di], al
		jnz	short loc_11BA9

loc_11BB8:				; CODE XREF: seg000:1BA7j
		mov	[bx], ax
		mov	[bx+2],	ax
		pop	ds
		pop	di
		pop	si
		mov	ax, word ptr dword_29AF4+2
		mov	word_1DD36, ax
		mov	ax, word ptr dword_29AF4
		mov	word_1DD34, ax
		retn

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_11BCD	proc far		; CODE XREF: LoadGTAFile+C3P

arg_0		= word ptr  6
arg_2		= word ptr  8
arg_4		= word ptr  0Ah

		push	bp
		mov	bp, sp
		xor	ax, ax
		push	ax
		push	[bp+arg_2]
		push	[bp+arg_0]
		nop
		push	cs
		call	near ptr sub_11C8A
		add	sp, 6
		mov	dx, ax
		cmp	dx, 0FFFFh
		jz	short loc_11C02
		test	[bp+arg_4], 2
		jz	short loc_11BF5
		test	dx, 1
		jnz	short loc_11BF9

loc_11BF5:				; CODE XREF: sub_11BCD+20j
		xor	ax, ax
		jmp	short loc_11C02
; ---------------------------------------------------------------------------

loc_11BF9:				; CODE XREF: sub_11BCD+26j
		mov	word_1DD42, 5
		mov	ax, 0FFFFh

loc_11C02:				; CODE XREF: sub_11BCD+19j
					; sub_11BCD+2Aj
		pop	bp
		retf
sub_11BCD	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_11C04	proc far		; CODE XREF: seg000:1C83p
					; sub_1296E+13Ap

arg_0		= dword	ptr  6

		push	bp
		mov	bp, sp
		push	si
		push	di
		push	es
		push	bp
		les	si, [bp+arg_0]
		cld
		sub	ax, ax
		cwd
		mov	cx, 0Ah
		mov	bh, 0
		mov	di, 0BA43h

loc_11C1A:				; CODE XREF: sub_11C04+1Dj
		mov	bl, es:[si]
		inc	si
		test	byte ptr [bx+di], 1
		jnz	short loc_11C1A
		mov	bp, 0
		cmp	bl, 2Bh	; '+'
		jz	short loc_11C31
		cmp	bl, 2Dh	; '-'
		jnz	short loc_11C35
		inc	bp

loc_11C31:				; CODE XREF: sub_11C04+25j
					; sub_11C04+41j
		mov	bl, es:[si]
		inc	si

loc_11C35:				; CODE XREF: sub_11C04+2Aj
		cmp	bl, 39h	; '9'
		ja	short loc_11C69
		sub	bl, 30h	; '0'
		jb	short loc_11C69
		mul	cx
		add	ax, bx
		adc	dl, dh
		jz	short loc_11C31
		jmp	short loc_11C5B
; ---------------------------------------------------------------------------

loc_11C49:				; CODE XREF: sub_11C04+63j
		mov	di, dx
		mov	cx, 0Ah
		mul	cx
		xchg	ax, di
		xchg	dx, cx
		mul	dx
		xchg	ax, dx
		xchg	ax, di
		add	ax, bx
		adc	dx, cx

loc_11C5B:				; CODE XREF: sub_11C04+43j
		mov	bl, es:[si]
		inc	si
		cmp	bl, 39h	; '9'
		ja	short loc_11C69
		sub	bl, 30h	; '0'
		jnb	short loc_11C49

loc_11C69:				; CODE XREF: sub_11C04+34j
					; sub_11C04+39j ...
		dec	bp
		jl	short loc_11C73
		neg	dx
		neg	ax
		sbb	dx, 0

loc_11C73:				; CODE XREF: sub_11C04+66j
		pop	bp
		pop	es
		pop	di
		pop	si
		pop	bp
		retf
sub_11C04	endp

; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		push	word ptr [bp+8]
		push	word ptr [bp+6]
		push	cs
		call	near ptr sub_11C04
		pop	cx
		pop	cx
		pop	bp
		retf

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_11C8A	proc far		; CODE XREF: sub_11BCD+Ep

arg_0		= dword	ptr  6
arg_4		= byte ptr  0Ah
arg_6		= word ptr  0Ch

		push	bp
		mov	bp, sp
		push	ds
		mov	cx, [bp+arg_6]
		mov	ah, 43h	; 'C'
		mov	al, [bp+arg_4]
		lds	dx, [bp+arg_0]
		int	21h		; DOS -
		pop	ds
		jb	short loc_11CA1
		xchg	ax, cx
		jmp	short loc_11CA5
; ---------------------------------------------------------------------------

loc_11CA1:				; CODE XREF: sub_11C8A+12j
		push	ax
		call	sub_10C86

loc_11CA5:				; CODE XREF: sub_11C8A+15j
		pop	bp
		retf
sub_11C8A	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_11CA7	proc far		; CODE XREF: sub_11D74+29p
					; sub_11E38+Fp	...

arg_0		= dword	ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, word ptr [bp+arg_0]
		or	ax, word ptr [bp+arg_0+2]
		jnz	short loc_11CBB
		nop
		push	cs
		call	near ptr sub_11D74
		jmp	loc_11D6F
; ---------------------------------------------------------------------------

loc_11CBB:				; CODE XREF: sub_11CA7+Aj
		les	bx, [bp+arg_0]
		mov	ax, es:[bx+12h]
		cmp	ax, word ptr [bp+arg_0]
		jz	short loc_11CCD

loc_11CC7:				; CODE XREF: sub_11CA7+C5j
		mov	ax, 0FFFFh
		jmp	loc_11D71
; ---------------------------------------------------------------------------

loc_11CCD:				; CODE XREF: sub_11CA7+1Ej
		les	bx, [bp+arg_0]
		cmp	word ptr es:[bx], 0
		jl	short loc_11D27
		test	word ptr es:[bx+2], 8
		jnz	short loc_11CF6
		mov	ax, es:[bx+0Eh]
		mov	dx, word ptr [bp+arg_0]
		add	dx, 5
		cmp	ax, word ptr [bp+arg_0+2]
		jz	short loc_11CF0
		jmp	loc_11D6F
; ---------------------------------------------------------------------------

loc_11CF0:				; CODE XREF: sub_11CA7+44j
		cmp	es:[bx+0Ch], dx
		jnz	short loc_11D6F

loc_11CF6:				; CODE XREF: sub_11CA7+35j
		les	bx, [bp+arg_0]
		mov	word ptr es:[bx], 0
		mov	ax, es:[bx+0Eh]
		mov	dx, word ptr [bp+arg_0]
		add	dx, 5
		cmp	ax, word ptr [bp+arg_0+2]
		jnz	short loc_11D6F
		cmp	es:[bx+0Ch], dx
		jnz	short loc_11D6F
		mov	ax, es:[bx+0Ah]
		mov	dx, es:[bx+8]
		mov	es:[bx+0Eh], ax
		mov	es:[bx+0Ch], dx
		jmp	short loc_11D6F
; ---------------------------------------------------------------------------
		jmp	short loc_11D6F
; ---------------------------------------------------------------------------

loc_11D27:				; CODE XREF: sub_11CA7+2Dj
		les	bx, [bp+arg_0]
		mov	ax, es:[bx+6]
		add	ax, es:[bx]
		inc	ax
		mov	si, ax
		sub	es:[bx], si
		push	ax
		mov	ax, es:[bx+0Ah]
		mov	dx, es:[bx+8]
		mov	es:[bx+0Eh], ax
		mov	es:[bx+0Ch], dx
		push	ax
		push	dx
		mov	al, es:[bx+4]
		cbw
		push	ax
		nop
		push	cs
		call	near ptr sub_12C3B
		add	sp, 8
		cmp	ax, si
		jz	short loc_11D6F
		les	bx, [bp+arg_0]
		test	word ptr es:[bx+2], 200h
		jnz	short loc_11D6F
		or	word ptr es:[bx+2], 10h
		jmp	loc_11CC7
; ---------------------------------------------------------------------------

loc_11D6F:				; CODE XREF: sub_11CA7+11j
					; sub_11CA7+46j ...
		xor	ax, ax

loc_11D71:				; CODE XREF: sub_11CA7+23j
		pop	si
		pop	bp
		retf
sub_11CA7	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_11D74	proc far		; CODE XREF: sub_11CA7+Ep

var_4		= dword	ptr -4

		push	bp
		mov	bp, sp
		sub	sp, 4
		push	si
		push	di
		xor	di, di
		mov	si, word_299C0
		mov	word ptr [bp+var_4+2], ds
		mov	word ptr [bp+var_4], 0BB50h
		jmp	short loc_11DA7
; ---------------------------------------------------------------------------

loc_11D8C:				; CODE XREF: sub_11D74+38j
		les	bx, [bp+var_4]
		test	word ptr es:[bx+2], 3
		jz	short loc_11DA3
		push	word ptr [bp+var_4+2]
		push	bx
		nop
		push	cs
		call	near ptr sub_11CA7
		pop	cx
		pop	cx
		inc	di

loc_11DA3:				; CODE XREF: sub_11D74+21j
		add	word ptr [bp+var_4], 14h

loc_11DA7:				; CODE XREF: sub_11D74+16j
		mov	ax, si
		dec	si
		or	ax, ax
		jnz	short loc_11D8C
		mov	ax, di
		pop	di
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_11D74	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_11DB6	proc near		; CODE XREF: sub_11E38+2Fp
					; seg000:1F72p	...

var_4		= dword	ptr -4
arg_0		= dword	ptr  4

		push	bp
		mov	bp, sp
		sub	sp, 4
		push	si
		les	bx, [bp+arg_0]
		cmp	word ptr es:[bx], 0
		jge	short loc_11DD2
		mov	cx, es:[bx+6]
		add	cx, es:[bx]
		inc	cx
		mov	si, cx
		jmp	short loc_11DE1
; ---------------------------------------------------------------------------

loc_11DD2:				; CODE XREF: sub_11DB6+Ej
		les	bx, [bp+arg_0]
		mov	ax, es:[bx]
		cwd
		xor	ax, dx
		sub	ax, dx
		mov	cx, ax
		mov	si, ax

loc_11DE1:				; CODE XREF: sub_11DB6+1Aj
		les	bx, [bp+arg_0]
		test	word ptr es:[bx+2], 40h
		jnz	short loc_11E2F
		les	bx, [bp+arg_0]
		mov	ax, es:[bx+0Eh]
		mov	dx, es:[bx+0Ch]
		mov	word ptr [bp+var_4+2], ax
		mov	word ptr [bp+var_4], dx
		cmp	word ptr es:[bx], 0
		jge	short loc_11E28
		jmp	short loc_11E12
; ---------------------------------------------------------------------------

loc_11E05:				; CODE XREF: sub_11DB6+61j
		dec	word ptr [bp+var_4]
		les	bx, [bp+var_4]
		cmp	byte ptr es:[bx], 0Ah
		jnz	short loc_11E12
		inc	si

loc_11E12:				; CODE XREF: sub_11DB6+4Dj
					; sub_11DB6+59j
		mov	ax, cx
		dec	cx
		or	ax, ax
		jnz	short loc_11E05
		jmp	short loc_11E2F
; ---------------------------------------------------------------------------

loc_11E1B:				; CODE XREF: sub_11DB6+77j
		les	bx, [bp+var_4]
		inc	word ptr [bp+var_4]
		cmp	byte ptr es:[bx], 0Ah
		jnz	short loc_11E28
		inc	si

loc_11E28:				; CODE XREF: sub_11DB6+4Bj
					; sub_11DB6+6Fj
		mov	ax, cx
		dec	cx
		or	ax, ax
		jnz	short loc_11E1B

loc_11E2F:				; CODE XREF: sub_11DB6+34j
					; sub_11DB6+63j
		mov	ax, si
		pop	si
		mov	sp, bp
		pop	bp
		retn	4
sub_11DB6	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_11E38	proc far		; CODE XREF: sub_124AA+6Bp

arg_0		= dword	ptr  6
arg_4		= word ptr  0Ah
arg_6		= word ptr  0Ch
arg_8		= word ptr  0Eh

		push	bp
		mov	bp, sp
		push	si
		mov	si, [bp+arg_8]
		push	word ptr [bp+arg_0+2]
		push	word ptr [bp+arg_0]
		nop
		push	cs
		call	near ptr sub_11CA7
		pop	cx
		pop	cx
		or	ax, ax
		jz	short loc_11E55
		mov	ax, 0FFFFh
		jmp	short loc_11EB5
; ---------------------------------------------------------------------------

loc_11E55:				; CODE XREF: sub_11E38+16j
		cmp	si, 1
		jnz	short loc_11E71
		les	bx, [bp+arg_0]
		cmp	word ptr es:[bx], 0
		jle	short loc_11E71
		push	word ptr [bp+arg_0+2]
		push	bx
		call	sub_11DB6
		cwd
		sub	[bp+arg_4], ax
		sbb	[bp+arg_6], dx

loc_11E71:				; CODE XREF: sub_11E38+20j
					; sub_11E38+29j
		les	bx, [bp+arg_0]
		and	word ptr es:[bx+2], 0FE5Fh
		mov	word ptr es:[bx], 0
		mov	ax, es:[bx+0Ah]
		mov	dx, es:[bx+8]
		mov	es:[bx+0Eh], ax
		mov	es:[bx+0Ch], dx
		push	si
		push	[bp+arg_6]
		push	[bp+arg_4]
		mov	al, es:[bx+4]
		cbw
		push	ax
		nop
		push	cs
		call	near ptr seek_something
		add	sp, 8
		cmp	dx, 0FFFFh
		jnz	short loc_11EB3
		cmp	ax, 0FFFFh
		jnz	short loc_11EB3
		mov	ax, 0FFFFh
		jmp	short loc_11EB5
; ---------------------------------------------------------------------------

loc_11EB3:				; CODE XREF: sub_11E38+6Fj
					; sub_11E38+74j
		xor	ax, ax

loc_11EB5:				; CODE XREF: sub_11E38+1Bj
					; sub_11E38+79j
		pop	si
		pop	bp
		retf
sub_11E38	endp

; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		sub	sp, 8
		mov	ax, 1
		push	ax
		xor	ax, ax
		xor	dx, dx
		push	ax
		push	dx
		les	bx, [bp+6]
		mov	al, es:[bx+4]
		cbw
		push	ax
		nop
		push	cs
		call	near ptr seek_something
		add	sp, 8
		mov	[bp-2],	dx
		mov	[bp-4],	ax
		cmp	dx, 0FFFFh
		jnz	short loc_11EEC
		cmp	ax, 0FFFFh
		jnz	short loc_11EEC
		jmp	loc_11F8E
; ---------------------------------------------------------------------------

loc_11EEC:				; CODE XREF: seg000:1EE2j seg000:1EE7j
		les	bx, [bp+6]
		cmp	word ptr es:[bx], 0
		jl	short loc_11EF8
		jmp	loc_11F7E
; ---------------------------------------------------------------------------

loc_11EF8:				; CODE XREF: seg000:1EF3j
		mov	al, es:[bx+4]
		cbw
		shl	ax, 1
		mov	bx, ax
		test	word ptr [bx-431Eh], 800h
		jz	short loc_11F6C
		mov	ax, 2
		push	ax
		xor	ax, ax
		xor	dx, dx
		push	ax
		push	dx
		mov	bx, [bp+6]
		mov	al, es:[bx+4]
		cbw
		push	ax
		nop
		push	cs
		call	near ptr seek_something
		add	sp, 8
		mov	[bp-6],	dx
		mov	[bp-8],	ax
		cmp	dx, 0FFFFh
		jnz	short loc_11F34
		cmp	ax, 0FFFFh
		jz	short loc_11F94

loc_11F34:				; CODE XREF: seg000:1F2Dj
		xor	ax, ax
		push	ax
		push	word ptr [bp-2]
		push	word ptr [bp-4]
		les	bx, [bp+6]
		mov	al, es:[bx+4]
		cbw
		push	ax
		nop
		push	cs
		call	near ptr seek_something
		add	sp, 8
		cmp	dx, 0FFFFh
		jnz	short loc_11F60
		cmp	ax, 0FFFFh
		jnz	short loc_11F60
		mov	dx, 0FFFFh
		mov	ax, 0FFFFh
		jmp	short loc_11F94
; ---------------------------------------------------------------------------

loc_11F60:				; CODE XREF: seg000:1F51j seg000:1F56j
		mov	ax, [bp-6]
		mov	dx, [bp-8]
		mov	[bp-2],	ax
		mov	[bp-4],	dx

loc_11F6C:				; CODE XREF: seg000:1F07j
		push	word ptr [bp+8]
		push	word ptr [bp+6]
		call	sub_11DB6
		cwd
		add	[bp-4],	ax
		adc	[bp-2],	dx
		jmp	short loc_11F8E
; ---------------------------------------------------------------------------

loc_11F7E:				; CODE XREF: seg000:1EF5j
		push	word ptr [bp+8]
		push	word ptr [bp+6]
		call	sub_11DB6
		cwd
		sub	[bp-4],	ax
		sbb	[bp-2],	dx

loc_11F8E:				; CODE XREF: seg000:1EE9j seg000:1F7Cj
		mov	dx, [bp-2]
		mov	ax, [bp-4]

loc_11F94:				; CODE XREF: seg000:1F32j seg000:1F5Ej
		mov	sp, bp
		pop	bp
		retf

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_11F98	proc far		; CODE XREF: sub_1296E+Ep

var_4		= dword	ptr -4
arg_0		= dword	ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 4
		push	si
		push	di
		les	di, [bp+arg_0]
		mov	ax, es
		or	ax, di
		jz	short loc_11FC9
		mov	al, 0
		mov	ah, es:[di]
		mov	cx, 0FFFFh
		cld
		repne scasb
		not	cx
		dec	cx
		jz	short loc_11FC9
		les	di, dword_29AF4
		mov	word ptr [bp+var_4+2], es
		mov	bx, es
		or	bx, di
		mov	word ptr [bp+var_4], di
		jnz	short loc_11FD6

loc_11FC9:				; CODE XREF: sub_11F98+Fj
					; sub_11F98+1Fj ...
		xor	dx, dx
		xor	ax, ax
		jmp	short loc_12002
; ---------------------------------------------------------------------------

loc_11FCF:				; CODE XREF: sub_11F98+50j
					; sub_11F98+58j ...
		add	word ptr [bp+var_4], 4
		les	di, [bp+var_4]

loc_11FD6:				; CODE XREF: sub_11F98+2Fj
		les	di, es:[di]
		mov	bx, es
		or	bx, di
		jz	short loc_11FC9
		mov	al, es:[di]
		or	al, al
		jz	short loc_11FC9
		cmp	ah, al
		jnz	short loc_11FCF
		mov	bx, cx
		cmp	byte ptr es:[bx+di], 3Dh ; '='
		jnz	short loc_11FCF
		push	ds
		lds	si, [bp+arg_0]
		repe cmpsb
		pop	ds
		xchg	cx, bx
		jnz	short loc_11FCF
		inc	di
		mov	ax, di
		mov	dx, es

loc_12002:				; CODE XREF: sub_11F98+35j
		pop	di
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_11F98	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_12008	proc near		; CODE XREF: sub_1224F+112p

arg_2		= dword	ptr  6
arg_6		= dword	ptr  0Ah
arg_A		= word ptr  0Eh

		push	bp
		mov	bp, sp
		push	si
		push	di
		mov	dx, ds
		les	di, [bp+arg_2]
		lds	si, [bp+arg_6]
		mov	cx, [bp+arg_A]
		shr	cx, 1
		cld
		rep movsw
		jnb	short loc_12020
		movsb

loc_12020:				; CODE XREF: sub_12008+15j
		mov	ds, dx
		mov	dx, word ptr [bp+arg_2+2]
		mov	ax, word ptr [bp+arg_2]
		pop	di
		pop	si
		pop	bp
sub_12008	endp ; sp-analysis failed

; [00000001 BYTES: COLLAPSED FUNCTION nullsub_3. PRESS KEYPAD "+" TO EXPAND]

; =============== S U B	R O U T	I N E =======================================


sub_1202C	proc near		; CODE XREF: sub_12050+11p
		push	bp
sub_1202C	endp ; sp-analysis failed


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1202D	proc far		; CODE XREF: sub_10FBD+17p
					; DATA XREF: dseg:0010o

arg_2		= dword	ptr  6
arg_6		= word ptr  0Ah
arg_8		= byte ptr  0Ch

		mov	bp, sp
		push	di
		les	di, [bp+arg_2]
		mov	cx, [bp+arg_6]
		mov	al, [bp+arg_8]
		mov	ah, al
		cld
		test	di, 1
		jz	short loc_12046
		jcxz	short loc_1204D
		stosb
		dec	cx

loc_12046:				; CODE XREF: sub_1202D+13j
		shr	cx, 1
		rep stosw
		jnb	short loc_1204D
		stosb

loc_1204D:				; CODE XREF: sub_1202D+15j
					; sub_1202D+1Dj
		pop	di
		pop	bp
		retf
sub_1202D	endp ; sp-analysis failed


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_12050	proc far		; CODE XREF: sub_1296E+105p

arg_0		= word ptr  6
arg_2		= word ptr  8
arg_4		= byte ptr  0Ah
arg_6		= word ptr  0Ch

		push	bp
		mov	bp, sp
		mov	al, [bp+arg_4]
		push	ax
		push	[bp+arg_6]
		push	[bp+arg_2]
		push	[bp+arg_0]
		push	cs
		call	sub_1202C
		add	sp, 8
		mov	dx, [bp+arg_2]
		mov	ax, [bp+arg_0]
		pop	bp
		retf
sub_12050	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1206F	proc far		; CODE XREF: sub_12FB3+135P
					; sub_12FB3+148P

arg_0		= word ptr  6
arg_2		= word ptr  8
arg_4		= byte ptr  0Ah

		push	bp
		mov	bp, sp
		mov	ax, 224Fh
		push	ax
		push	ds
		mov	ax, 0BB64h
		push	ax
		push	[bp+arg_2]
		push	[bp+arg_0]
		lea	ax, [bp+arg_4]
		push	ax
		call	sub_10F8D
		pop	bp
		retf
sub_1206F	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1208A	proc far		; CODE XREF: sub_1224F+1C2p

arg_0		= byte ptr  6
arg_2		= dword	ptr  8

		push	bp
		mov	bp, sp
		les	bx, [bp+arg_2]
		dec	word ptr es:[bx]
		push	word ptr [bp+arg_2+2]
		push	bx
		mov	al, [bp+arg_0]
		cbw
		push	ax
		nop
		push	cs
		call	near ptr sub_120A6
		add	sp, 6
		pop	bp
		retf
sub_1208A	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_120A6	proc far		; CODE XREF: sub_1208A+14p
					; seg000:2247p	...

arg_0		= byte ptr  6
arg_2		= dword	ptr  8

		push	bp
		mov	bp, sp
		push	si
		mov	al, [bp+arg_0]
		mov	byte_29BDE, al
		les	bx, [bp+arg_2]
		cmp	word ptr es:[bx], 0FFFFh
		jge	short loc_1210D
		inc	word ptr es:[bx]
		mov	ax, es:[bx+0Eh]
		mov	si, es:[bx+0Ch]
		inc	word ptr es:[bx+0Ch]
		mov	dl, byte_29BDE
		mov	es, ax
		mov	es:[si], dl
		mov	es, word ptr [bp+arg_2+2]
		test	word ptr es:[bx+2], 8
		jnz	short loc_120DF
		jmp	loc_12233
; ---------------------------------------------------------------------------

loc_120DF:				; CODE XREF: sub_120A6+34j
		cmp	byte_29BDE, 0Ah
		jz	short loc_120F0
		cmp	byte_29BDE, 0Dh
		jz	short loc_120F0
		jmp	loc_12233
; ---------------------------------------------------------------------------

loc_120F0:				; CODE XREF: sub_120A6+3Ej
					; sub_120A6+45j
		push	word ptr [bp+arg_2+2]
		push	word ptr [bp+arg_2]
		nop
		push	cs
		call	near ptr sub_11CA7
		pop	cx
		pop	cx
		or	ax, ax
		jnz	short loc_12104
		jmp	loc_12233
; ---------------------------------------------------------------------------

loc_12104:				; CODE XREF: sub_120A6+59j
					; sub_120A6+82j ...
		mov	ax, 0FFFFh
		jmp	loc_12238
; ---------------------------------------------------------------------------
		jmp	loc_12233
; ---------------------------------------------------------------------------

loc_1210D:				; CODE XREF: sub_120A6+11j
		les	bx, [bp+arg_2]
		test	word ptr es:[bx+2], 90h
		jnz	short loc_12120
		test	word ptr es:[bx+2], 2
		jnz	short loc_1212A

loc_12120:				; CODE XREF: sub_120A6+70j
					; sub_120A6+18Aj
		les	bx, [bp+arg_2]
		or	word ptr es:[bx+2], 10h
		jmp	short loc_12104
; ---------------------------------------------------------------------------

loc_1212A:				; CODE XREF: sub_120A6+78j
		les	bx, [bp+arg_2]
		or	word ptr es:[bx+2], 100h
		cmp	word ptr es:[bx+6], 0
		jz	short loc_121A9
		cmp	word ptr es:[bx], 0
		jz	short loc_1214F
		push	word ptr [bp+arg_2+2]
		push	bx
		nop
		push	cs
		call	near ptr sub_11CA7
		pop	cx
		pop	cx
		or	ax, ax
		jnz	short loc_12104

loc_1214F:				; CODE XREF: sub_120A6+98j
		les	bx, [bp+arg_2]
		mov	ax, es:[bx+6]
		neg	ax
		mov	es:[bx], ax
		mov	ax, es:[bx+0Eh]
		mov	si, es:[bx+0Ch]
		inc	word ptr es:[bx+0Ch]
		mov	dl, byte_29BDE
		mov	es, ax
		mov	es:[si], dl
		mov	es, word ptr [bp+arg_2+2]
		test	word ptr es:[bx+2], 8
		jnz	short loc_1217E
		jmp	loc_12233
; ---------------------------------------------------------------------------

loc_1217E:				; CODE XREF: sub_120A6+D3j
		cmp	byte_29BDE, 0Ah
		jz	short loc_1218F
		cmp	byte_29BDE, 0Dh
		jz	short loc_1218F
		jmp	loc_12233
; ---------------------------------------------------------------------------

loc_1218F:				; CODE XREF: sub_120A6+DDj
					; sub_120A6+E4j
		push	word ptr [bp+arg_2+2]
		push	word ptr [bp+arg_2]
		nop
		push	cs
		call	near ptr sub_11CA7
		pop	cx
		pop	cx
		or	ax, ax
		jnz	short loc_121A3
		jmp	loc_12233
; ---------------------------------------------------------------------------

loc_121A3:				; CODE XREF: sub_120A6+F8j
		jmp	loc_12104
; ---------------------------------------------------------------------------
		jmp	loc_12233
; ---------------------------------------------------------------------------

loc_121A9:				; CODE XREF: sub_120A6+92j
		les	bx, [bp+arg_2]
		mov	al, es:[bx+4]
		cbw
		shl	ax, 1
		mov	bx, ax
		test	word ptr [bx-431Eh], 800h
		jz	short loc_121D8
		mov	ax, 2
		push	ax
		xor	ax, ax
		xor	dx, dx
		push	ax
		push	dx
		mov	bx, word ptr [bp+arg_2]
		mov	al, es:[bx+4]
		cbw
		push	ax
		nop
		push	cs
		call	near ptr seek_something
		add	sp, 8

loc_121D8:				; CODE XREF: sub_120A6+115j
		cmp	byte_29BDE, 0Ah
		jnz	short loc_12206
		les	bx, [bp+arg_2]
		test	word ptr es:[bx+2], 40h
		jnz	short loc_12206
		mov	ax, 1
		push	ax
		push	ds
		mov	ax, 0BE18h
		push	ax
		mov	al, es:[bx+4]
		cbw
		push	ax
		nop
		push	cs
		call	near ptr sub_12D8C
		add	sp, 8
		cmp	ax, 1
		jnz	short loc_12225

loc_12206:				; CODE XREF: sub_120A6+137j
					; sub_120A6+142j
		mov	ax, 1
		push	ax
		push	ds
		mov	ax, 0BEFEh
		push	ax
		les	bx, [bp+arg_2]
		mov	al, es:[bx+4]
		cbw
		push	ax
		nop
		push	cs
		call	near ptr sub_12D8C
		add	sp, 8
		cmp	ax, 1
		jz	short loc_12233

loc_12225:				; CODE XREF: sub_120A6+15Ej
		les	bx, [bp+arg_2]
		test	word ptr es:[bx+2], 200h
		jnz	short loc_12233
		jmp	loc_12120
; ---------------------------------------------------------------------------

loc_12233:				; CODE XREF: sub_120A6+36j
					; sub_120A6+47j ...
		mov	al, byte_29BDE
		mov	ah, 0

loc_12238:				; CODE XREF: sub_120A6+61j
		pop	si
		pop	bp
		retf
sub_120A6	endp

; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		push	ds
		mov	ax, 0BB64h
		push	ax
		push	word ptr [bp+6]
		push	cs
		call	near ptr sub_120A6
		add	sp, 6
		pop	bp
		retf

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1224F	proc near		; CODE XREF: sub_12452+2Bp

var_2		= word ptr -2
arg_0		= dword	ptr  4
arg_4		= word ptr  8
arg_6		= dword	ptr  0Ah

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	si
		push	di
		mov	di, [bp+arg_4]
		mov	[bp+var_2], di
		les	bx, [bp+arg_0]
		test	word ptr es:[bx+2], 8
		jz	short loc_12296
		jmp	short loc_1228C
; ---------------------------------------------------------------------------

loc_1226A:				; CODE XREF: sub_1224F+42j
		push	word ptr [bp+arg_0+2]
		push	word ptr [bp+arg_0]
		les	bx, [bp+arg_6]
		inc	word ptr [bp+arg_6]
		mov	al, es:[bx]
		cbw
		push	ax
		push	cs
		call	near ptr sub_120A6
		add	sp, 6
		cmp	ax, 0FFFFh
		jnz	short loc_1228C

loc_12287:				; CODE XREF: sub_1224F+78j
					; sub_1224F:loc_12317j	...
		xor	ax, ax
		jmp	loc_1244A
; ---------------------------------------------------------------------------

loc_1228C:				; CODE XREF: sub_1224F+19j
					; sub_1224F+36j
		mov	ax, di
		dec	di
		or	ax, ax
		jnz	short loc_1226A
		jmp	loc_12447
; ---------------------------------------------------------------------------

loc_12296:				; CODE XREF: sub_1224F+17j
		les	bx, [bp+arg_0]
		test	word ptr es:[bx+2], 40h
		jnz	short loc_122A4
		jmp	loc_123CC
; ---------------------------------------------------------------------------

loc_122A4:				; CODE XREF: sub_1224F+50j
		cmp	word ptr es:[bx+6], 0
		jnz	short loc_122AE
		jmp	loc_12379
; ---------------------------------------------------------------------------

loc_122AE:				; CODE XREF: sub_1224F+5Aj
		cmp	es:[bx+6], di
		jnb	short loc_1231D
		cmp	word ptr es:[bx], 0
		jz	short loc_122C9
		push	word ptr [bp+arg_0+2]
		push	bx
		nop
		push	cs
		call	near ptr sub_11CA7
		pop	cx
		pop	cx
		or	ax, ax
		jnz	short loc_12287

loc_122C9:				; CODE XREF: sub_1224F+69j
		les	bx, [bp+arg_0]
		mov	al, es:[bx+4]
		cbw
		shl	ax, 1
		mov	bx, ax
		test	word ptr [bx-431Eh], 800h
		jz	short loc_122F8
		mov	ax, 2
		push	ax
		xor	ax, ax
		xor	dx, dx
		push	ax
		push	dx
		mov	bx, word ptr [bp+arg_0]
		mov	al, es:[bx+4]
		cbw
		push	ax
		nop
		push	cs
		call	near ptr seek_something
		add	sp, 8

loc_122F8:				; CODE XREF: sub_1224F+8Cj
		push	di
		push	word ptr [bp+arg_6+2]
		push	word ptr [bp+arg_6]
		les	bx, [bp+arg_0]
		mov	al, es:[bx+4]
		cbw
		push	ax
		nop
		push	cs
		call	near ptr sub_12D8C
		add	sp, 8
		cmp	ax, di
		jnz	short loc_12317
		jmp	loc_12447
; ---------------------------------------------------------------------------

loc_12317:				; CODE XREF: sub_1224F+C3j
		jmp	loc_12287
; ---------------------------------------------------------------------------
		jmp	loc_12447
; ---------------------------------------------------------------------------

loc_1231D:				; CODE XREF: sub_1224F+63j
		les	bx, [bp+arg_0]
		mov	ax, es:[bx]
		add	ax, di
		jl	short loc_1234D
		cmp	word ptr es:[bx], 0
		jnz	short loc_12339
		mov	ax, 0FFFFh
		sub	ax, es:[bx+6]
		mov	es:[bx], ax
		jmp	short loc_1234D
; ---------------------------------------------------------------------------

loc_12339:				; CODE XREF: sub_1224F+DCj
		push	word ptr [bp+arg_0+2]
		push	word ptr [bp+arg_0]
		nop
		push	cs
		call	near ptr sub_11CA7
		pop	cx
		pop	cx
		or	ax, ax
		jz	short loc_1234D
		jmp	loc_12287
; ---------------------------------------------------------------------------

loc_1234D:				; CODE XREF: sub_1224F+D6j
					; sub_1224F+E8j ...
		push	di
		push	word ptr [bp+arg_6+2]
		push	word ptr [bp+arg_6]
		les	bx, [bp+arg_0]
		push	word ptr es:[bx+0Eh]
		push	word ptr es:[bx+0Ch]
		nop
		push	cs
		call	sub_12008
		add	sp, 0Ah
		les	bx, [bp+arg_0]
		mov	ax, es:[bx]
		add	ax, di
		mov	es:[bx], ax
		add	es:[bx+0Ch], di
		jmp	loc_12447
; ---------------------------------------------------------------------------

loc_12379:				; CODE XREF: sub_1224F+5Cj
		les	bx, [bp+arg_0]
		mov	al, es:[bx+4]
		cbw
		shl	ax, 1
		mov	bx, ax
		test	word ptr [bx-431Eh], 800h
		jz	short loc_123A8
		mov	ax, 2
		push	ax
		xor	ax, ax
		xor	dx, dx
		push	ax
		push	dx
		mov	bx, word ptr [bp+arg_0]
		mov	al, es:[bx+4]
		cbw
		push	ax
		nop
		push	cs
		call	near ptr seek_something
		add	sp, 8

loc_123A8:				; CODE XREF: sub_1224F+13Cj
		push	di
		push	word ptr [bp+arg_6+2]
		push	word ptr [bp+arg_6]
		les	bx, [bp+arg_0]
		mov	al, es:[bx+4]
		cbw
		push	ax
		nop
		push	cs
		call	near ptr sub_12D8C
		add	sp, 8
		cmp	ax, di
		jnz	short loc_123C7
		jmp	loc_12447
; ---------------------------------------------------------------------------

loc_123C7:				; CODE XREF: sub_1224F+173j
		jmp	loc_12287
; ---------------------------------------------------------------------------
		jmp	short loc_12447
; ---------------------------------------------------------------------------

loc_123CC:				; CODE XREF: sub_1224F+52j
		les	bx, [bp+arg_0]
		cmp	word ptr es:[bx+6], 0
		jz	short loc_12428
		jmp	short loc_1241F
; ---------------------------------------------------------------------------

loc_123D8:				; CODE XREF: sub_1224F+1D5j
		les	bx, [bp+arg_0]
		inc	word ptr es:[bx]
		jge	short loc_12400
		mov	ax, es:[bx+0Eh]
		mov	si, es:[bx+0Ch]
		inc	word ptr es:[bx+0Ch]
		les	bx, [bp+arg_6]
		inc	word ptr [bp+arg_6]
		mov	dl, es:[bx]
		mov	es, ax
		mov	es:[si], dl
		mov	al, dl
		mov	ah, 0
		jmp	short loc_12417
; ---------------------------------------------------------------------------

loc_12400:				; CODE XREF: sub_1224F+18Fj
		push	word ptr [bp+arg_0+2]
		push	word ptr [bp+arg_0]
		les	bx, [bp+arg_6]
		inc	word ptr [bp+arg_6]
		mov	al, es:[bx]
		push	ax
		push	cs
		call	near ptr sub_1208A
		add	sp, 6

loc_12417:				; CODE XREF: sub_1224F+1AFj
		cmp	ax, 0FFFFh
		jnz	short loc_1241F
		jmp	loc_12287
; ---------------------------------------------------------------------------

loc_1241F:				; CODE XREF: sub_1224F+187j
					; sub_1224F+1CBj
		mov	ax, di
		dec	di
		or	ax, ax
		jnz	short loc_123D8
		jmp	short loc_12447
; ---------------------------------------------------------------------------

loc_12428:				; CODE XREF: sub_1224F+185j
		push	di
		push	word ptr [bp+arg_6+2]
		push	word ptr [bp+arg_6]
		les	bx, [bp+arg_0]
		mov	al, es:[bx+4]
		cbw
		push	ax
		nop
		push	cs
		call	near ptr sub_12C3B
		add	sp, 8
		cmp	ax, di
		jz	short loc_12447
		jmp	loc_12287
; ---------------------------------------------------------------------------

loc_12447:				; CODE XREF: sub_1224F+44j
					; sub_1224F+C5j ...
		mov	ax, [bp+var_2]

loc_1244A:				; CODE XREF: sub_1224F+3Aj
		pop	di
		pop	si
		mov	sp, bp
		pop	bp
		retn	0Ah
sub_1224F	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_12452	proc far		; CODE XREF: sub_12FB3+CP
					; sub_12FB3+36P ...

arg_0		= word ptr  6
arg_2		= word ptr  8

		push	bp
		mov	bp, sp
		push	si
		mov	ax, [bp+arg_0]
		or	ax, [bp+arg_2]
		jnz	short loc_12462
		xor	ax, ax
		jmp	short loc_124A7
; ---------------------------------------------------------------------------

loc_12462:				; CODE XREF: sub_12452+Aj
		push	[bp+arg_2]
		push	[bp+arg_0]
		nop
		push	cs
		call	near ptr sub_125F0
		pop	cx
		pop	cx
		mov	si, ax
		push	[bp+arg_2]
		push	[bp+arg_0]
		push	ax
		push	ds
		mov	ax, 0BB64h
		push	ax
		call	sub_1224F
		cmp	ax, si
		jz	short loc_12489
		mov	ax, 0FFFFh
		jmp	short loc_124A7
; ---------------------------------------------------------------------------

loc_12489:				; CODE XREF: sub_12452+30j
		push	ds
		mov	ax, 0BB64h
		push	ax
		mov	ax, 0Ah
		push	ax
		nop
		push	cs
		call	near ptr sub_120A6
		add	sp, 6
		cmp	ax, 0Ah
		jz	short loc_124A4
		mov	ax, 0FFFFh
		jmp	short loc_124A7
; ---------------------------------------------------------------------------

loc_124A4:				; CODE XREF: sub_12452+4Bj
		mov	ax, 0Ah

loc_124A7:				; CODE XREF: sub_12452+Ej
					; sub_12452+35j ...
		pop	si
		pop	bp
		retf
sub_12452	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_124AA	proc far		; CODE XREF: seg000:0E86p seg000:0EC2p

arg_0		= dword	ptr  6
arg_4		= word ptr  0Ah
arg_6		= word ptr  0Ch
arg_8		= word ptr  0Eh
arg_A		= word ptr  10h

		push	bp
		mov	bp, sp
		push	si
		push	di
		mov	di, [bp+arg_8]
		mov	si, [bp+arg_A]
		les	bx, [bp+arg_0]
		mov	ax, es:[bx+12h]
		cmp	ax, word ptr [bp+arg_0]
		jnz	short loc_124CC
		cmp	di, 2
		jg	short loc_124CC
		cmp	si, 7FFFh
		jbe	short loc_124D2

loc_124CC:				; CODE XREF: sub_124AA+15j
					; sub_124AA+1Aj ...
		mov	ax, 0FFFFh
		jmp	loc_125C3
; ---------------------------------------------------------------------------

loc_124D2:				; CODE XREF: sub_124AA+20j
		cmp	word_29AFC, 0
		jnz	short loc_124E8
		cmp	word ptr [bp+arg_0], 0BB64h
		jnz	short loc_124E8
		mov	word_29AFC, 1
		jmp	short loc_124FC
; ---------------------------------------------------------------------------

loc_124E8:				; CODE XREF: sub_124AA+2Dj
					; sub_124AA+34j
		cmp	word_29AFA, 0
		jnz	short loc_124FC
		cmp	word ptr [bp+arg_0], 0BB50h
		jnz	short loc_124FC
		mov	word_29AFA, 1

loc_124FC:				; CODE XREF: sub_124AA+3Cj
					; sub_124AA+43j ...
		les	bx, [bp+arg_0]
		cmp	word ptr es:[bx], 0
		jz	short loc_1251B
		mov	ax, 1
		push	ax
		xor	ax, ax
		xor	dx, dx
		push	ax
		push	dx
		push	word ptr [bp+arg_0+2]
		push	bx
		nop
		push	cs
		call	near ptr sub_11E38
		add	sp, 0Ah

loc_1251B:				; CODE XREF: sub_124AA+59j
		les	bx, [bp+arg_0]
		test	word ptr es:[bx+2], 4
		jz	short loc_12535
		push	word ptr es:[bx+0Ah]
		push	word ptr es:[bx+8]
		nop
		push	cs
		call	near ptr sub_115AF
		pop	cx
		pop	cx

loc_12535:				; CODE XREF: sub_124AA+7Aj
		les	bx, [bp+arg_0]
		and	word ptr es:[bx+2], 0FFF3h
		mov	word ptr es:[bx+6], 0
		mov	ax, word ptr [bp+arg_0+2]
		mov	dx, word ptr [bp+arg_0]
		add	dx, 5
		mov	es:[bx+0Ah], ax
		mov	es:[bx+8], dx
		mov	es:[bx+0Eh], ax
		mov	es:[bx+0Ch], dx
		cmp	di, 2
		jz	short loc_125C1
		or	si, si
		jbe	short loc_125C1
		mov	word ptr off_29824+2, seg seg000
		mov	word ptr off_29824, 2DC8h
		mov	ax, [bp+arg_4]
		or	ax, [bp+arg_6]
		jnz	short loc_1259A
		push	si
		nop
		push	cs
		call	near ptr sub_116E2
		pop	cx
		mov	[bp+arg_6], dx
		mov	[bp+arg_4], ax
		or	ax, dx
		jnz	short loc_1258D
		jmp	loc_124CC
; ---------------------------------------------------------------------------

loc_1258D:				; CODE XREF: sub_124AA+DEj
		les	bx, [bp+arg_0]
		or	word ptr es:[bx+2], 4
		jmp	short loc_1259A
; ---------------------------------------------------------------------------
		jmp	loc_124CC
; ---------------------------------------------------------------------------

loc_1259A:				; CODE XREF: sub_124AA+CDj
					; sub_124AA+EBj
		les	bx, [bp+arg_0]
		mov	ax, [bp+arg_6]
		mov	dx, [bp+arg_4]
		mov	es:[bx+0Eh], ax
		mov	es:[bx+0Ch], dx
		mov	es:[bx+0Ah], ax
		mov	es:[bx+8], dx
		mov	es:[bx+6], si
		cmp	di, 1
		jnz	short loc_125C1
		or	word ptr es:[bx+2], 8

loc_125C1:				; CODE XREF: sub_124AA+B5j
					; sub_124AA+B9j ...
		xor	ax, ax

loc_125C3:				; CODE XREF: sub_124AA+25j
		pop	di
		pop	si
		pop	bp
		retf
sub_124AA	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_125C7	proc far		; CODE XREF: sub_1296E+D6p
					; sub_1296E+EBp

arg_0		= dword	ptr  6
arg_4		= dword	ptr  0Ah

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
		retf
sub_125C7	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_125F0	proc far		; CODE XREF: sub_10A62+Bp
					; sub_12452+18p ...

arg_0		= dword	ptr  6

		push	bp
		mov	bp, sp
		push	di
		les	di, [bp+arg_0]
		xor	ax, ax
		cmp	ax, word ptr [bp+arg_0+2]
		jnz	short loc_12602
		cmp	ax, di
		jz	short loc_1260C

loc_12602:				; CODE XREF: sub_125F0+Cj
		cld
		mov	cx, 0FFFFh
		repne scasb
		xchg	ax, cx
		not	ax
		dec	ax

loc_1260C:				; CODE XREF: sub_125F0+10j
		pop	di
		pop	bp
		retf
sub_125F0	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1260F	proc far		; CODE XREF: sub_1296E+11Fp
					; sub_1296E+1C3p

arg_0		= dword	ptr  6
arg_4		= dword	ptr  0Ah
arg_8		= word ptr  0Eh

		push	bp
		mov	bp, sp
		push	si
		push	di
		cld
		les	di, [bp+arg_4]
		mov	si, di
		xor	al, al
		mov	bx, [bp+arg_8]
		mov	cx, bx
		repne scasb
		sub	bx, cx
		push	ds
		mov	di, es
		mov	ds, di
		les	di, [bp+arg_0]
		xchg	cx, bx
		rep movsb
		mov	cx, bx
		rep stosb
		pop	ds
		mov	dx, word ptr [bp+arg_0+2]
		mov	ax, word ptr [bp+arg_0]
		pop	di
		pop	si
		pop	bp
		retf
sub_1260F	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_12640	proc far		; CODE XREF: sub_10F09+3Ep

var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= dword	ptr  6
arg_4		= dword	ptr  0Ah

		push	bp
		mov	bp, sp
		sub	sp, 4
		push	si
		nop
		push	cs
		call	near ptr sub_1296E
		mov	ax, word_29B2E
		mov	dx, word_29B2C
		add	dx, 0A600h
		adc	ax, 12CEh
		mov	[bp+var_2], ax
		mov	[bp+var_4], dx
		les	bx, [bp+arg_0]
		mov	si, es:[bx]
		add	si, 0F844h
		mov	ax, si
		mov	cl, 2
		sar	ax, cl
		cwd
		push	ax
		push	dx
		mov	dx, 786h
		mov	ax, 1F80h
		pop	cx
		pop	bx
		call	sub_10DAD
		add	[bp+var_4], ax
		adc	[bp+var_2], dx
		mov	ax, si
		and	ax, 3
		cwd
		push	ax
		push	dx
		mov	dx, 1E1h
		mov	ax, 3380h
		pop	cx
		pop	bx
		call	sub_10DAD
		add	[bp+var_4], ax
		adc	[bp+var_2], dx
		test	si, 3
		jz	short loc_126AC
		add	[bp+var_4], 5180h
		adc	[bp+var_2], 1

loc_126AC:				; CODE XREF: sub_12640+61j
		xor	cx, cx
		les	bx, [bp+arg_0]
		mov	al, es:[bx+3]
		cbw
		dec	ax
		mov	si, ax
		jmp	short loc_126C3
; ---------------------------------------------------------------------------

loc_126BB:				; CODE XREF: sub_12640+85j
		dec	si
		mov	al, [si-41E2h]
		cbw
		add	cx, ax

loc_126C3:				; CODE XREF: sub_12640+79j
		or	si, si
		jg	short loc_126BB
		les	bx, [bp+arg_0]
		mov	al, es:[bx+2]
		cbw
		dec	ax
		add	cx, ax
		cmp	byte ptr es:[bx+3], 2
		jle	short loc_126E1
		test	word ptr es:[bx], 3
		jnz	short loc_126E1
		inc	cx

loc_126E1:				; CODE XREF: sub_12640+97j
					; sub_12640+9Ej
		les	bx, [bp+arg_4]
		mov	al, es:[bx+1]
		mov	ah, 0
		push	ax
		mov	ax, cx
		mov	dx, 18h
		imul	dx
		pop	dx
		add	ax, dx
		mov	si, ax
		cmp	word_29B30, 0
		jz	short loc_1271B
		mov	al, es:[bx+1]
		mov	ah, 0
		push	ax
		push	cx
		xor	ax, ax
		push	ax
		les	bx, [bp+arg_0]
		mov	ax, es:[bx]
		add	ax, 0F84Eh
		push	ax
		call	sub_12B5C
		or	ax, ax
		jz	short loc_1271B
		dec	si

loc_1271B:				; CODE XREF: sub_12640+BCj
					; sub_12640+D8j
		mov	ax, si
		cwd
		push	ax
		push	dx
		xor	dx, dx
		mov	ax, 0E10h
		pop	cx
		pop	bx
		call	sub_10DAD
		add	[bp+var_4], ax
		adc	[bp+var_2], dx
		les	bx, [bp+arg_4]
		mov	al, es:[bx]
		mov	ah, 0
		cwd
		push	ax
		push	dx
		xor	dx, dx
		mov	ax, 3Ch	; '<'
		pop	cx
		pop	bx
		call	sub_10DAD
		les	bx, [bp+arg_4]
		mov	bl, es:[bx+3]
		mov	bh, 0
		push	ax
		mov	ax, bx
		push	dx
		cwd
		pop	bx
		pop	cx
		add	cx, ax
		adc	bx, dx
		add	[bp+var_4], cx
		adc	[bp+var_2], bx
		mov	dx, [bp+var_2]
		mov	ax, [bp+var_4]
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_12640	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1276A	proc far		; CODE XREF: seg000:0EE5p

arg_0		= word ptr  6
arg_2		= word ptr  8
arg_4		= dword	ptr  0Ah
arg_8		= dword	ptr  0Eh

		push	bp
		mov	bp, sp
		nop
		push	cs
		call	near ptr sub_1296E
		mov	ax, word_29B2E
		mov	dx, word_29B2C
		add	dx, 0A600h
		adc	ax, 12CEh
		sub	[bp+arg_0], dx
		sbb	[bp+arg_2], ax
		les	bx, [bp+arg_8]
		mov	byte ptr es:[bx+2], 0
		xor	ax, ax
		mov	dx, 3Ch	; '<'
		push	ax
		push	dx
		push	[bp+arg_2]
		push	[bp+arg_0]
		call	near ptr sub_10B66
		les	bx, [bp+arg_8]
		mov	es:[bx+3], al
		xor	ax, ax
		mov	dx, 3Ch	; '<'
		push	ax
		push	dx
		push	[bp+arg_2]
		push	[bp+arg_0]
		call	sub_10B57
		mov	[bp+arg_2], dx
		mov	[bp+arg_0], ax
		xor	ax, ax
		mov	dx, 3Ch	; '<'
		push	ax
		push	dx
		push	[bp+arg_2]
		push	[bp+arg_0]
		call	near ptr sub_10B66
		les	bx, [bp+arg_8]
		mov	es:[bx], al
		xor	ax, ax
		mov	dx, 3Ch	; '<'
		push	ax
		push	dx
		push	[bp+arg_2]
		push	[bp+arg_0]
		call	sub_10B57
		mov	[bp+arg_2], dx
		mov	[bp+arg_0], ax
		xor	ax, ax
		mov	dx, 88F8h
		push	ax
		push	dx
		push	[bp+arg_2]
		push	[bp+arg_0]
		call	sub_10B57
		mov	cl, 2
		shl	ax, cl
		add	ax, 7BCh
		les	bx, [bp+arg_4]
		mov	es:[bx], ax
		xor	ax, ax
		mov	dx, 88F8h
		push	ax
		push	dx
		push	[bp+arg_2]
		push	[bp+arg_0]
		call	near ptr sub_10B66
		mov	[bp+arg_2], dx
		mov	[bp+arg_0], ax
		cmp	[bp+arg_2], 0
		jl	short loc_12864
		jnz	short loc_12829
		cmp	[bp+arg_0], 2250h
		jb	short loc_12864

loc_12829:				; CODE XREF: sub_1276A+B6j
		sub	[bp+arg_0], 2250h
		sbb	[bp+arg_2], 0
		les	bx, [bp+arg_4]
		inc	word ptr es:[bx]
		xor	ax, ax
		mov	dx, 2238h
		push	ax
		push	dx
		push	[bp+arg_2]
		push	[bp+arg_0]
		call	sub_10B57
		les	bx, [bp+arg_4]
		add	es:[bx], ax
		xor	ax, ax
		mov	dx, 2238h
		push	ax
		push	dx
		push	[bp+arg_2]
		push	[bp+arg_0]
		call	near ptr sub_10B66
		mov	[bp+arg_2], dx
		mov	[bp+arg_0], ax

loc_12864:				; CODE XREF: sub_1276A+B4j
					; sub_1276A+BDj
		cmp	word_29B30, 0
		jz	short loc_128A9
		xor	ax, ax
		mov	dx, 18h
		push	ax
		push	dx
		push	[bp+arg_2]
		push	[bp+arg_0]
		call	near ptr sub_10B66
		push	ax
		xor	ax, ax
		mov	dx, 18h
		push	ax
		push	dx
		push	[bp+arg_2]
		push	[bp+arg_0]
		call	sub_10B57
		push	ax
		xor	ax, ax
		push	ax
		les	bx, [bp+arg_4]
		mov	ax, es:[bx]
		add	ax, 0F84Eh
		push	ax
		call	sub_12B5C
		or	ax, ax
		jz	short loc_128A9
		add	[bp+arg_0], 1
		adc	[bp+arg_2], 0

loc_128A9:				; CODE XREF: sub_1276A+FFj
					; sub_1276A+135j
		xor	ax, ax
		mov	dx, 18h
		push	ax
		push	dx
		push	[bp+arg_2]
		push	[bp+arg_0]
		call	near ptr sub_10B66
		les	bx, [bp+arg_8]
		mov	es:[bx+1], al
		xor	ax, ax
		mov	dx, 18h
		push	ax
		push	dx
		push	[bp+arg_2]
		push	[bp+arg_0]
		call	sub_10B57
		mov	[bp+arg_2], dx
		mov	[bp+arg_0], ax
		add	[bp+arg_0], 1
		adc	[bp+arg_2], 0
		les	bx, [bp+arg_4]
		test	word ptr es:[bx], 3
		jnz	short loc_1291B
		cmp	[bp+arg_2], 0
		jl	short loc_12900
		jg	short loc_128F6
		cmp	[bp+arg_0], 3Ch	; '<'
		jbe	short loc_12900

loc_128F6:				; CODE XREF: sub_1276A+184j
		sub	[bp+arg_0], 1
		sbb	[bp+arg_2], 0
		jmp	short loc_1291B
; ---------------------------------------------------------------------------

loc_12900:				; CODE XREF: sub_1276A+182j
					; sub_1276A+18Aj
		cmp	[bp+arg_2], 0
		jnz	short loc_1291B
		cmp	[bp+arg_0], 3Ch	; '<'
		jnz	short loc_1291B
		les	bx, [bp+arg_4]
		mov	byte ptr es:[bx+3], 2
		mov	byte ptr es:[bx+2], 1Dh
		jmp	short loc_1296C
; ---------------------------------------------------------------------------

loc_1291B:				; CODE XREF: sub_1276A+17Cj
					; sub_1276A+194j ...
		les	bx, [bp+arg_4]
		mov	byte ptr es:[bx+3], 0
		jmp	short loc_12942
; ---------------------------------------------------------------------------

loc_12925:				; CODE XREF: sub_1276A+1EBj
					; sub_1276A+1F2j
		les	bx, [bp+arg_4]
		mov	al, es:[bx+3]
		cbw
		mov	bx, ax
		mov	al, [bx-41E2h]
		cbw
		cwd
		sub	[bp+arg_0], ax
		sbb	[bp+arg_2], dx
		mov	bx, word ptr [bp+arg_4]
		inc	byte ptr es:[bx+3]

loc_12942:				; CODE XREF: sub_1276A+1B9j
		les	bx, [bp+arg_4]
		mov	al, es:[bx+3]
		cbw
		mov	bx, ax
		mov	al, [bx-41E2h]
		cbw
		cwd
		cmp	dx, [bp+arg_2]
		jl	short loc_12925
		jnz	short loc_1295E
		cmp	ax, [bp+arg_0]
		jb	short loc_12925

loc_1295E:				; CODE XREF: sub_1276A+1EDj
		les	bx, [bp+arg_4]
		inc	byte ptr es:[bx+3]
		mov	al, byte ptr [bp+arg_0]
		mov	es:[bx+2], al

loc_1296C:				; CODE XREF: sub_1276A+1AFj
		pop	bp
		retf
sub_1276A	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1296E	proc far		; CODE XREF: sub_12640+9p sub_1276A+5p
					; DATA XREF: ...

var_4		= dword	ptr -4

		push	bp
		mov	bp, sp
		sub	sp, 4
		push	si
		push	ds
		mov	ax, 0BE52h
		push	ax
		nop
		push	cs
		call	near ptr sub_11F98
		pop	cx
		pop	cx
		mov	word ptr [bp+var_4+2], dx
		mov	word ptr [bp+var_4], ax
		or	ax, dx
		jnz	short loc_1298E
		jmp	loc_12A23
; ---------------------------------------------------------------------------

loc_1298E:				; CODE XREF: sub_1296E+1Bj
		push	dx
		push	word ptr [bp+var_4]
		nop
		push	cs
		call	near ptr sub_125F0
		pop	cx
		pop	cx
		cmp	ax, 4
		jnb	short loc_129A1
		jmp	loc_12A23
; ---------------------------------------------------------------------------

loc_129A1:				; CODE XREF: sub_1296E+2Ej
		les	bx, [bp+var_4]
		mov	al, es:[bx]
		cbw
		mov	bx, ax
		mov	al, [bx-45BDh]
		cbw
		test	ax, 0Ch
		jz	short loc_12A23
		mov	bx, word ptr [bp+var_4]
		mov	al, es:[bx+1]
		cbw
		mov	bx, ax
		mov	al, [bx-45BDh]
		cbw
		test	ax, 0Ch
		jz	short loc_12A23
		mov	bx, word ptr [bp+var_4]
		mov	al, es:[bx+2]
		cbw
		mov	bx, ax
		mov	al, [bx-45BDh]
		cbw
		test	ax, 0Ch
		jz	short loc_12A23
		mov	bx, word ptr [bp+var_4]
		cmp	byte ptr es:[bx+3], 2Dh	; '-'
		jz	short loc_129FB
		cmp	byte ptr es:[bx+3], 2Bh	; '+'
		jz	short loc_129FB
		mov	al, es:[bx+3]
		cbw
		mov	bx, ax
		test	byte ptr [bx-45BDh], 2
		jz	short loc_12A23

loc_129FB:				; CODE XREF: sub_1296E+76j
					; sub_1296E+7Dj
		les	bx, [bp+var_4]
		mov	al, es:[bx+3]
		cbw
		mov	bx, ax
		mov	al, [bx-45BDh]
		cbw
		test	ax, 2
		jnz	short loc_12A62
		mov	bx, word ptr [bp+var_4]
		mov	al, es:[bx+4]
		cbw
		mov	bx, ax
		mov	al, [bx-45BDh]
		cbw
		test	ax, 2
		jnz	short loc_12A62

loc_12A23:				; CODE XREF: sub_1296E+1Dj
					; sub_1296E+30j ...
		mov	word_29B30, 0
		mov	word_29B2E, 0FFFFh
		mov	word_29B2C, 8170h
		push	ds
		mov	ax, 0BE55h
		push	ax
		push	seg_29B26
		push	word_29B24
		nop
		push	cs
		call	near ptr sub_125C7
		add	sp, 8
		push	ds
		mov	ax, 0BE59h
		push	ax
		push	seg_29B2A
		push	word_29B28
		nop
		push	cs
		call	near ptr sub_125C7
		add	sp, 8
		jmp	loc_12B57
; ---------------------------------------------------------------------------

loc_12A62:				; CODE XREF: sub_1296E+9Fj
					; sub_1296E+B3j
		mov	ax, 4
		push	ax
		xor	ax, ax
		push	ax
		push	seg_29B2A
		push	word_29B28
		nop
		push	cs
		call	near ptr sub_12050
		add	sp, 8
		mov	ax, 3
		push	ax
		push	word ptr [bp+var_4+2]
		push	word ptr [bp+var_4]
		push	seg_29B26
		push	word_29B24
		nop
		push	cs
		call	near ptr sub_1260F
		add	sp, 0Ah
		les	bx, dword ptr word_29B24
		mov	byte ptr es:[bx+3], 0
		mov	ax, word ptr [bp+var_4]
		add	ax, 3
		push	word ptr [bp+var_4+2]
		push	ax
		nop
		push	cs
		call	near ptr sub_11C04
		pop	cx
		pop	cx
		push	ax
		push	dx
		xor	dx, dx
		mov	ax, 0E10h
		pop	cx
		pop	bx
		call	sub_10DAD
		mov	word_29B2E, dx
		mov	word_29B2C, ax
		mov	word_29B30, 0
		mov	si, 3
		jmp	short loc_12B49
; ---------------------------------------------------------------------------

loc_12ACB:				; CODE XREF: sub_1296E+1E6j
		les	bx, [bp+var_4]
		add	bx, si
		mov	al, es:[bx]
		cbw
		mov	bx, ax
		test	byte ptr [bx-45BDh], 0Ch
		jz	short loc_12B48
		mov	ax, word ptr [bp+var_4]
		add	ax, si
		push	word ptr [bp+var_4+2]
		push	ax
		nop
		push	cs
		call	near ptr sub_125F0
		pop	cx
		pop	cx
		cmp	ax, 3
		jb	short loc_12B57
		les	bx, [bp+var_4]
		mov	al, es:[bx+si+1]
		cbw
		mov	bx, ax
		mov	al, [bx-45BDh]
		cbw
		test	ax, 0Ch
		jz	short loc_12B57
		mov	bx, word ptr [bp+var_4]
		mov	al, es:[bx+si+2]
		cbw
		mov	bx, ax
		mov	al, [bx-45BDh]
		cbw
		test	ax, 0Ch
		jz	short loc_12B57
		mov	ax, 3
		push	ax
		mov	ax, word ptr [bp+var_4]
		add	ax, si
		push	word ptr [bp+var_4+2]
		push	ax
		push	seg_29B2A
		push	word_29B28
		nop
		push	cs
		call	near ptr sub_1260F
		add	sp, 0Ah
		les	bx, dword ptr word_29B28
		mov	byte ptr es:[bx+3], 0
		mov	word_29B30, 1
		jmp	short loc_12B57
; ---------------------------------------------------------------------------

loc_12B48:				; CODE XREF: sub_1296E+16Dj
		inc	si

loc_12B49:				; CODE XREF: sub_1296E+15Bj
		les	bx, [bp+var_4]
		add	bx, si
		cmp	byte ptr es:[bx], 0
		jz	short loc_12B57
		jmp	loc_12ACB
; ---------------------------------------------------------------------------

loc_12B57:				; CODE XREF: sub_1296E+F1j
					; sub_1296E+182j ...
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_1296E	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_12B5C	proc near		; CODE XREF: sub_12640+D3p
					; sub_1276A+130p

arg_0		= word ptr  4
arg_2		= word ptr  6
arg_4		= word ptr  8
arg_6		= byte ptr  0Ah

		push	bp
		mov	bp, sp
		push	si
		cmp	[bp+arg_2], 0
		jnz	short loc_12B92
		mov	si, [bp+arg_4]
		cmp	[bp+arg_4], 3Bh	; ';'
		jb	short loc_12B7B
		mov	ax, [bp+arg_0]
		add	ax, 46h	; 'F'
		test	ax, 3
		jnz	short loc_12B7B
		dec	si

loc_12B7B:				; CODE XREF: sub_12B5C+11j
					; sub_12B5C+1Cj
		mov	[bp+arg_2], 0
		jmp	short loc_12B85
; ---------------------------------------------------------------------------

loc_12B82:				; CODE XREF: sub_12B5C+32j
		inc	[bp+arg_2]

loc_12B85:				; CODE XREF: sub_12B5C+24j
		mov	bx, [bp+arg_2]
		shl	bx, 1
		cmp	[bx-41D6h], si
		jbe	short loc_12B82
		jmp	short loc_12BB3
; ---------------------------------------------------------------------------

loc_12B92:				; CODE XREF: sub_12B5C+8j
		mov	bx, [bp+arg_2]
		dec	bx
		shl	bx, 1
		mov	ax, [bx-41D6h]
		add	[bp+arg_4], ax
		cmp	[bp+arg_2], 3
		jbe	short loc_12BB3
		mov	ax, [bp+arg_0]
		add	ax, 46h	; 'F'
		test	ax, 3
		jnz	short loc_12BB3
		inc	[bp+arg_4]

loc_12BB3:				; CODE XREF: sub_12B5C+34j
					; sub_12B5C+47j ...
		cmp	[bp+arg_2], 4
		jb	short loc_12C34
		jz	short loc_12BC3
		cmp	[bp+arg_2], 0Ah
		ja	short loc_12C34
		jnz	short loc_12C2F

loc_12BC3:				; CODE XREF: sub_12B5C+5Dj
		mov	bx, [bp+arg_2]
		shl	bx, 1
		cmp	[bp+arg_0], 10h
		jle	short loc_12BDD
		cmp	[bp+arg_2], 4
		jnz	short loc_12BDD
		mov	cx, [bx-41D8h]
		add	cx, 7
		jmp	short loc_12BE1
; ---------------------------------------------------------------------------

loc_12BDD:				; CODE XREF: sub_12B5C+70j
					; sub_12B5C+76j
		mov	cx, [bx-41D6h]

loc_12BE1:				; CODE XREF: sub_12B5C+7Fj
		mov	bx, [bp+arg_0]
		add	bx, 7B2h
		test	bl, 3
		jz	short loc_12BEE
		dec	cx

loc_12BEE:				; CODE XREF: sub_12B5C+8Fj
		mov	bx, [bp+arg_0]
		inc	bx
		sar	bx, 1
		sar	bx, 1
		add	bx, cx
		mov	ax, 16Dh
		mul	[bp+arg_0]
		add	ax, bx
		add	ax, 4
		xor	dx, dx
		mov	bx, 7
		div	bx
		sub	cx, dx
		mov	ax, [bp+arg_4]
		cmp	[bp+arg_2], 4
		jnz	short loc_12C23
		cmp	ax, cx
		ja	short loc_12C2F
		jnz	short loc_12C34
		cmp	[bp+arg_6], 2
		jb	short loc_12C34
		jmp	short loc_12C2F
; ---------------------------------------------------------------------------

loc_12C23:				; CODE XREF: sub_12B5C+B7j
		cmp	ax, cx
		jb	short loc_12C2F
		jnz	short loc_12C34
		cmp	[bp+arg_6], 1
		ja	short loc_12C34

loc_12C2F:				; CODE XREF: sub_12B5C+65j
					; sub_12B5C+BBj ...
		mov	ax, 1
		jmp	short loc_12C36
; ---------------------------------------------------------------------------

loc_12C34:				; CODE XREF: sub_12B5C+5Bj
					; sub_12B5C+63j ...
		xor	ax, ax

loc_12C36:				; CODE XREF: sub_12B5C+D6j
		pop	si
		pop	bp
		retn	8
sub_12B5C	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_12C3B	proc far		; CODE XREF: sub_11CA7+ABp
					; sub_1224F+1EBp

var_8E		= byte ptr -8Eh
var_C		= dword	ptr -0Ch
var_7		= byte ptr -7
var_6		= word ptr -6
var_4		= dword	ptr -4
arg_0		= word ptr  6
arg_2		= word ptr  8
arg_4		= word ptr  0Ah
arg_6		= word ptr  0Ch

		push	bp
		mov	bp, sp
		sub	sp, 8Eh
		push	si
		push	di
		mov	di, [bp+arg_0]
		cmp	di, word_299C0
		jb	short loc_12C57
		mov	ax, 6
		push	ax
		call	sub_10C86
		jmp	loc_12D86
; ---------------------------------------------------------------------------

loc_12C57:				; CODE XREF: sub_12C3B+10j
		mov	ax, [bp+arg_6]
		inc	ax
		cmp	ax, 2
		jnb	short loc_12C65
		xor	ax, ax
		jmp	loc_12D86
; ---------------------------------------------------------------------------

loc_12C65:				; CODE XREF: sub_12C3B+23j
		mov	bx, di
		shl	bx, 1
		test	word ptr [bx-431Eh], 800h
		jz	short loc_12C84
		mov	ax, 2
		push	ax
		xor	ax, ax
		xor	dx, dx
		push	ax
		push	dx
		push	di
		nop
		push	cs
		call	near ptr seek_something
		add	sp, 8

loc_12C84:				; CODE XREF: sub_12C3B+34j
		mov	bx, di
		shl	bx, 1
		test	word ptr [bx-431Eh], 4000h
		jnz	short loc_12CA5
		push	[bp+arg_6]
		push	[bp+arg_4]
		push	[bp+arg_2]
		push	di
		nop
		push	cs
		call	near ptr sub_12D8C
		add	sp, 8
		jmp	loc_12D86
; ---------------------------------------------------------------------------

loc_12CA5:				; CODE XREF: sub_12C3B+53j
		mov	bx, di
		shl	bx, 1
		and	word ptr [bx-431Eh], 0FDFFh
		mov	ax, [bp+arg_4]
		mov	dx, [bp+arg_2]
		mov	word ptr [bp+var_C+2], ax
		mov	word ptr [bp+var_C], dx
		mov	ax, [bp+arg_6]
		mov	[bp+var_6], ax
		jmp	short loc_12D38
; ---------------------------------------------------------------------------

loc_12CC3:				; CODE XREF: sub_12C3B+10Dj
		dec	[bp+var_6]
		les	bx, [bp+var_C]
		inc	word ptr [bp+var_C]
		mov	al, es:[bx]
		mov	[bp+var_7], al
		cmp	al, 0Ah
		jnz	short loc_12CE0
		les	bx, [bp+var_4]
		mov	byte ptr es:[bx], 0Dh
		inc	word ptr [bp+var_4]

loc_12CE0:				; CODE XREF: sub_12C3B+99j
		les	bx, [bp+var_4]
		mov	al, [bp+var_7]
		mov	es:[bx], al
		inc	word ptr [bp+var_4]
		lea	ax, [bp+var_8E]
		mov	dx, word ptr [bp+var_4]
		xor	bx, bx
		sub	dx, ax
		sbb	bx, 0
		or	bx, bx
		jl	short loc_12D42
		jnz	short loc_12D06
		cmp	dx, 80h	; 'Ä'
		jb	short loc_12D42

loc_12D06:				; CODE XREF: sub_12C3B+C3j
		lea	ax, [bp+var_8E]
		mov	si, word ptr [bp+var_4]
		xor	dx, dx
		sub	si, ax
		sbb	dx, 0
		push	si
		push	ss
		push	ax
		push	di
		nop
		push	cs
		call	near ptr sub_12D8C
		add	sp, 8
		mov	dx, ax
		cmp	ax, si
		jz	short loc_12D38
		cmp	dx, 0FFFFh
		jnz	short loc_12D30

loc_12D2B:				; CODE XREF: sub_12C3B+13Dj
		mov	ax, 0FFFFh
		jmp	short loc_12D81
; ---------------------------------------------------------------------------

loc_12D30:				; CODE XREF: sub_12C3B+EEj
		mov	ax, [bp+arg_6]
		sub	ax, [bp+var_6]
		jmp	short loc_12D7D
; ---------------------------------------------------------------------------

loc_12D38:				; CODE XREF: sub_12C3B+86j
					; sub_12C3B+E9j
		lea	ax, [bp+var_8E]
		mov	word ptr [bp+var_4+2], ss
		mov	word ptr [bp+var_4], ax

loc_12D42:				; CODE XREF: sub_12C3B+C1j
					; sub_12C3B+C9j
		cmp	[bp+var_6], 0
		jz	short loc_12D4B
		jmp	loc_12CC3
; ---------------------------------------------------------------------------

loc_12D4B:				; CODE XREF: sub_12C3B+10Bj
		lea	ax, [bp+var_8E]
		mov	si, word ptr [bp+var_4]
		xor	dx, dx
		sub	si, ax
		sbb	dx, 0
		mov	ax, si
		or	ax, ax
		jbe	short loc_12D83
		push	si
		push	ss
		lea	ax, [bp+var_8E]
		push	ax
		push	di
		nop
		push	cs
		call	near ptr sub_12D8C
		add	sp, 8
		mov	dx, ax
		cmp	ax, si
		jz	short loc_12D83
		cmp	dx, 0FFFFh
		jz	short loc_12D2B
		mov	ax, [bp+arg_6]

loc_12D7D:				; CODE XREF: sub_12C3B+FBj
		add	ax, dx
		sub	ax, si

loc_12D81:				; CODE XREF: sub_12C3B+F3j
		jmp	short loc_12D86
; ---------------------------------------------------------------------------

loc_12D83:				; CODE XREF: sub_12C3B+122j
					; sub_12C3B+138j
		mov	ax, [bp+arg_6]

loc_12D86:				; CODE XREF: sub_12C3B+19j
					; sub_12C3B+27j ...
		pop	di
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_12C3B	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_12D8C	proc far		; CODE XREF: sub_10A62+1Dp
					; sub_120A6+155p ...

arg_0		= word ptr  6
arg_2		= dword	ptr  8
arg_6		= word ptr  0Ch

		push	bp
		mov	bp, sp
		mov	bx, [bp+arg_0]
		shl	bx, 1
		test	word ptr [bx-431Eh], 1
		jz	short loc_12DA2
		mov	ax, 5
		push	ax
		jmp	short loc_12DC3
; ---------------------------------------------------------------------------

loc_12DA2:				; CODE XREF: sub_12D8C+Ej
		push	ds
		mov	ah, 40h	; '@'
		mov	bx, [bp+arg_0]
		mov	cx, [bp+arg_6]
		lds	dx, [bp+arg_2]
		int	21h		; DOS -	2+ - WRITE TO FILE WITH	HANDLE
					; BX = file handle, CX = number	of bytes to write, DS:DX -> buffer
		pop	ds
		jb	short loc_12DC2
		push	ax
		mov	bx, [bp+arg_0]
		shl	bx, 1
		or	word ptr [bx-431Eh], 1000h
		pop	ax
		jmp	short loc_12DC6
; ---------------------------------------------------------------------------

loc_12DC2:				; CODE XREF: sub_12D8C+25j
		push	ax

loc_12DC3:				; CODE XREF: sub_12D8C+14j
		call	sub_10C86

loc_12DC6:				; CODE XREF: sub_12D8C+34j
		pop	bp
		retf
sub_12D8C	endp

; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		sub	sp, 4
		push	si
		mov	si, 4
		mov	word ptr [bp-2], ds
		mov	word ptr [bp-4], 0BB50h
		jmp	short loc_12DF7
; ---------------------------------------------------------------------------

loc_12DDC:				; CODE XREF: seg000:2DF9j
		les	bx, [bp-4]
		test	word ptr es:[bx+2], 3
		jz	short loc_12DF2
		push	word ptr [bp-2]
		push	bx
		nop
		push	cs
		call	near ptr sub_11CA7
		pop	cx
		pop	cx

loc_12DF2:				; CODE XREF: seg000:2DE5j
		dec	si
		add	word ptr [bp-4], 14h

loc_12DF7:				; CODE XREF: seg000:2DDAj
		or	si, si
		jnz	short loc_12DDC
		pop	si
		mov	sp, bp
		pop	bp
		retf
seg000		ends

; ===========================================================================

; Segment type:	Pure code
seg001		segment	byte public 'CODE' use16
		assume cs:seg001
		assume es:nothing, ss:nothing, ds:dseg,	fs:nothing, gs:nothing

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

LoadGTAFile	proc far		; CODE XREF: seg007:7408P seg007:8B36P

var_A		= word ptr -0Ah
var_8		= word ptr -8
var_6		= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= dword	ptr  6
arg_4		= word ptr  0Ah
arg_6		= word ptr  0Ch

		push	bp
		mov	bp, sp
		sub	sp, 0Ah
		push	si
		push	di
		mov	dx, [bp+arg_6]
		and	dx, 3
		mov	ax, [bp+arg_6]
		and	ax, 10h
		sar	ax, 4
		mov	[bp+var_2], ax
		cmp	[bp+var_2], 0
		jz	short loc_12E2B
		push	dx
		call	sub_13ECE
		add	sp, 2
		jmp	short loc_12E64
; ---------------------------------------------------------------------------

loc_12E2B:				; CODE XREF: LoadGTAFile+1Ej
		mov	ax, word_21EAA
		mov	[bp+var_A], ax
		mov	ax, word_21EAC
		mov	[bp+var_8], ax
		mov	ax, word_21EAE
		mov	[bp+var_6], ax
		mov	ax, word_21EB0
		mov	[bp+var_4], ax
		mov	word_21EAA, 0A800h
		mov	word_21EAC, 0B000h
		mov	word_21EAE, 0B800h
		mov	word_21EB0, 0E000h
		push	dx
		call	WritePortA6
		add	sp, 2

loc_12E64:				; CODE XREF: LoadGTAFile+29j
		test	MiscFlags, 1
		jz	short loc_12ED6
		push	ds
		pop	es
		assume es:dseg
		mov	di, offset gtaNameBuffer
		mov	si, offset aA	; "A:"
		mov	cx, 1
		rep movsw
		movsb
		mov	ax, ds
		mov	si, offset gtaNameBuffer
		les	di, [bp+arg_0]
		assume es:nothing
		push	ax
		xor	ax, ax
		mov	cx, 0FFFFh
		repne scasb
		not	cx
		sub	di, cx
		mov	ax, ds
		pop	ds
		push	ax
		xchg	si, di
		mov	bx, ds
		mov	ax, es
		mov	ds, ax
		mov	es, bx
		assume es:dseg
		push	cx
		mov	cx, 0FFFFh
		xor	ax, ax
		repne scasb
		dec	di
		pop	cx
		rep movsb
		pop	ds
		push	ds
		pop	es
		mov	di, offset gtaNameBuffer
		mov	si, offset aGtaExtension1 ; ".GTA"
		mov	cx, 0FFFFh
		xor	ax, ax
		repne scasb
		dec	di
		mov	cx, 5
		rep movsb
		push	ax
		push	ds
		push	offset gtaNameBuffer
		call	sub_11BCD
		add	sp, 6
		or	ax, ax
		jz	short loc_12F17
		mov	gtaNameBuffer, 'B'
		jmp	short loc_12F17
; ---------------------------------------------------------------------------

loc_12ED6:				; CODE XREF: LoadGTAFile+6Aj
		push	ds
		pop	es
		mov	di, offset gtaNameBuffer
		push	es
		mov	es, word ptr [bp+arg_0+2]
		assume es:nothing
		push	di
		mov	di, word ptr [bp+arg_0]
		xor	ax, ax
		mov	cx, 0FFFFh
		repne scasb
		not	cx
		sub	di, cx
		shr	cx, 1
		mov	ax, word ptr [bp+arg_0+2]
		mov	si, word ptr [bp+arg_0]
		pop	di
		pop	es
		push	ds
		mov	ds, ax
		rep movsw
		adc	cx, cx
		rep movsb
		pop	ds
		push	ds
		pop	es
		assume es:dseg
		mov	di, offset gtaNameBuffer
		mov	si, offset aGtaExtension2 ; ".GTA"
		mov	cx, 0FFFFh
		xor	ax, ax
		repne scasb
		dec	di
		mov	cx, 5
		rep movsb

loc_12F17:				; CODE XREF: LoadGTAFile+CDj
					; LoadGTAFile+D4j
		mov	ax, [bp+arg_6]
		sar	ax, 4
		and	ax, 0F40h
		or	ax, 1
		push	ax
		push	100
		mov	ax, [bp+arg_4]
		mov	bx, 50h	; 'P'
		cwd
		idiv	bx
		push	ax
		mov	ax, [bp+arg_4]
		cwd
		idiv	bx
		shl	dx, 3
		push	dx
		push	3000h
		push	ds
		push	offset byte_1DDF2
		push	ds
		push	offset gtaNameBuffer
		call	LoadGTA
		add	sp, 12h
		cmp	[bp+var_2], 0
		jnz	short loc_12F6B
		mov	ax, [bp+var_A]
		mov	word_21EAA, ax
		mov	ax, [bp+var_8]
		mov	word_21EAC, ax
		mov	ax, [bp+var_6]
		mov	word_21EAE, ax
		mov	ax, [bp+var_4]
		mov	word_21EB0, ax

loc_12F6B:				; CODE XREF: LoadGTAFile+151j
		test	[bp+arg_6], 100h
		jz	short loc_12F77
		call	CopyGTAPalette

loc_12F77:				; CODE XREF: LoadGTAFile+170j
		pop	di
		pop	si
		leave
		retf
LoadGTAFile	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

RNG_Init	proc far		; CODE XREF: sub_12FB3+C3p

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		mov	ax, [bp+arg_0]
		mov	word_1DD54, 0
		mov	word_1DD52, ax
		pop	bp
		retf
RNG_Init	endp


; =============== S U B	R O U T	I N E =======================================


RNG_GetNext	proc far		; CODE XREF: seg007:846AP seg007:8B4BP
		mov	cx, word_1DD54
		mov	bx, word_1DD52
		mov	dx, 16838
		mov	ax, 20077
		call	RNG_Advance
		add	ax, 12345
		adc	dx, 0
		mov	word_1DD54, dx
		mov	word_1DD52, ax
		mov	ax, word_1DD54
		and	ax, 7FFFh
		retf
RNG_GetNext	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_12FB3	proc far		; CODE XREF: start+134P

var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6
arg_2		= word ptr  8
arg_4		= word ptr  0Ah

		push	bp
		mov	bp, sp
		sub	sp, 4
		push	si
		push	di
		push	ds
		push	offset a1h5hpc98MimeC1 ; "\x1B[>1h\x1B[>5hPC98 MIME (C)1995 Studio Twin"...
		call	sub_12452
		add	sp, 4
		push	0
		push	40h ; '@'
		call	malloc
		push	0
		push	ax
		call	sub_10B5A
		mov	[bp+var_2], ax
		call	malloc
		cmp	ax, 5E00h
		ja	short loc_12FFB
		push	ds
		push	offset aErrorNoMemory_ ; "error	: no memory."
		call	sub_12452
		add	sp, 4
		push	0FFFFh
		call	sub_10ADF
		add	sp, 2

loc_12FFB:				; CODE XREF: sub_12FB3+30j
		cmp	[bp+arg_0], 1
		jle	short loc_13063
		mov	di, 1
		mov	si, [bp+arg_2]
		add	si, 4
		cmp	di, [bp+arg_0]
		jge	short loc_13063

loc_1300F:				; CODE XREF: sub_12FB3+AEj
		mov	es, [bp+arg_4]
		assume es:nothing
		les	bx, es:[si]
		cmp	byte ptr es:[bx], 2Dh ;	'-'
		jz	short loc_13028
		mov	es, [bp+arg_4]
		mov	es, word ptr es:[si+2]
		cmp	byte ptr es:[bx], 2Fh ;	'/'
		jnz	short loc_1305A

loc_13028:				; CODE XREF: sub_12FB3+66j
		mov	es, [bp+arg_4]
		les	bx, es:[si]
		mov	al, es:[bx+1]
		cbw
		cmp	ax, 46h	; 'F'
		jz	short loc_1303D
		cmp	ax, 66h	; 'f'
		jnz	short loc_13044

loc_1303D:				; CODE XREF: sub_12FB3+83j
		or	MiscFlags, 1
		jmp	short loc_1305A
; ---------------------------------------------------------------------------

loc_13044:				; CODE XREF: sub_12FB3+88j
		push	ds
		push	offset aErrorOptionErr ; "error	: option error"
		call	sub_12452
		add	sp, 4
		push	0FFFFh
		call	sub_10ADF
		add	sp, 2

loc_1305A:				; CODE XREF: sub_12FB3+73j
					; sub_12FB3+8Fj
		add	si, 4
		inc	di
		cmp	di, [bp+arg_0]
		jl	short loc_1300F

loc_13063:				; CODE XREF: sub_12FB3+4Cj
					; sub_12FB3+5Aj
		call	SetupIntVec24
		push	ds
		push	offset word_29B5A
		call	sub_10F09
		add	sp, 4
		push	ax
		push	cs
		call	near ptr RNG_Init
		add	sp, 2
		call	sub_1431D
		push	2000
		push	1
		call	sub_14375
		add	sp, 4
		push	2000
		push	2
		call	sub_14375
		add	sp, 4
		call	ReadEnvFile
		mov	ah, 2
		int	68h		;  - APPC/PC
					; DS:DX	-> control block
		push	0
		push	64
		call	malloc
		push	0
		push	ax
		call	sub_10B5A
		mov	[bp+var_4], ax
		push	0
		call	sub_14920
		add	sp, 2
		call	SetupIntVec09

loc_130C7:				; CODE XREF: sub_12FB3+11Bj
		call	far ptr	LoadScript
		or	ax, ax
		jz	short loc_130C7
		call	RestoreIntVec09
		push	ds
		push	offset a1l5l	; "\x1B[>1l\x1B[>5l"
		call	sub_12452
		add	sp, 4
		push	[bp+var_4]
		push	ds
		push	offset aRemainMemoryDk ; "remain memory	: %dKB\n"
		call	sub_1206F
		add	sp, 6
		mov	ax, [bp+var_2]
		sub	ax, [bp+var_4]
		push	ax
		push	ds
		push	offset aUseMemoryDkb ; "   use memory :	%dKB\n"
		call	sub_1206F
		add	sp, 6
		call	RestoreIntVec24
		pop	di
		pop	si
		leave
		retf
sub_12FB3	endp

seg001		ends

; ===========================================================================

; Segment type:	Pure code
seg002		segment	byte public 'CODE' use16
		assume cs:seg002
		;org 0Ch
		assume es:nothing, ss:nothing, ds:dseg,	fs:nothing, gs:nothing
aStssp_env	db 'STSSP.ENV',0        ; DATA XREF: ReadEnvFile+6o
OldIntVec05b	dd 0			; DATA XREF: SetupIntVec24+2Cw
					; RestoreIntVec24+9r ...
OldIntVec06b	dd 0			; DATA XREF: SetupIntVec24+49w
					; RestoreIntVec24+19r ...
OldIntVec24	dd 0			; DATA XREF: SetupIntVec24+Fw
					; RestoreIntVec24+29r ...

; =============== S U B	R O U T	I N E =======================================


malloc		proc far		; CODE XREF: sub_12FB3+18P
					; sub_12FB3+28P ...
		pushf
		push	bx
		mov	bx, 0FFFFh
		mov	ah, 48h
		int	21h		; DOS -	2+ - ALLOCATE MEMORY
					; BX = number of 16-byte paragraphs desired
		mov	ax, bx
		pop	bx
		popf
		retf
malloc		endp


; =============== S U B	R O U T	I N E =======================================


ReadEnvFile	proc far		; CODE XREF: sub_12FB3+E8P
		pusha
		push	ds
		mov	ax, cs
		mov	ds, ax
		assume ds:seg002
		mov	dx, offset aStssp_env ;	"STSSP.ENV"
		xor	al, al
		mov	ah, 3Dh
		int	21h		; DOS -	2+ - OPEN DISK FILE WITH HANDLE
					; DS:DX	-> ASCIZ filename
					; AL = access mode
					; 0 - read
		push	ax
		push	ax
		mov	dx, 0Ch
		mov	cx, 4
		pop	bx
		mov	ah, 3Fh
		int	21h		; DOS -	2+ - READ FROM FILE WITH HANDLE
					; BX = file handle, CX = number	of bytes to read
					; DS:DX	-> buffer
		pop	bx
		mov	ah, 3Eh
		int	21h		; DOS -	2+ - CLOSE A FILE WITH HANDLE
					; BX = file handle
		mov	ax, seg	dseg
		mov	ds, ax
		assume ds:dseg
		mov	si, dx
		cmp	byte ptr cs:[si+2], 2
		jnz	short loc_13166
		or	MiscFlags, 4
		jmp	short loc_13172
; ---------------------------------------------------------------------------

loc_13166:				; CODE XREF: ReadEnvFile+2Dj
		cmp	byte ptr cs:[si+2], 1
		jnz	short loc_13172
		or	MiscFlags, 8

loc_13172:				; CODE XREF: ReadEnvFile+34j
					; ReadEnvFile+3Bj
		cmp	byte ptr cs:[si], 1
		jnz	short loc_1317D
		or	MiscFlags, 10h

loc_1317D:				; CODE XREF: ReadEnvFile+46j
		cmp	byte ptr cs:[si+3], 0
		jz	short loc_13189
		or	MiscFlags, 2

loc_13189:				; CODE XREF: ReadEnvFile+52j
		pop	ds
		popa
		retf
ReadEnvFile	endp


; =============== S U B	R O U T	I N E =======================================


SetupIntVec24	proc far		; CODE XREF: sub_12FB3:loc_13063P
		pusha
		push	ds
		push	es
		cli
		mov	al, 24h
		mov	ah, 35h
		int	21h		; DOS -	2+ - GET INTERRUPT VECTOR
					; AL = interrupt number
					; Return: ES:BX	= value	of interrupt vector
		mov	word ptr cs:OldIntVec24+2, es
		mov	word ptr cs:OldIntVec24, bx
		mov	ax, cs
		mov	ds, ax
		assume ds:seg002
		mov	dx, offset Int24
		mov	al, 24h
		mov	ah, 25h
		int	21h		; DOS -	SET INTERRUPT VECTOR
					; AL = interrupt number
					; DS:DX	= new vector to	be used	for specified interrupt
		mov	al, 5
		mov	ah, 35h
		int	21h		; DOS -	2+ - GET INTERRUPT VECTOR
					; AL = interrupt number
					; Return: ES:BX	= value	of interrupt vector
		mov	word ptr cs:OldIntVec05b+2, es
		mov	word ptr cs:OldIntVec05b, bx
		mov	ax, cs
		mov	ds, ax
		mov	dx, offset IntDummy
		mov	al, 5
		mov	ah, 25h
		int	21h		; DOS -	SET INTERRUPT VECTOR
					; AL = interrupt number
					; DS:DX	= new vector to	be used	for specified interrupt
		mov	al, 6
		mov	ah, 35h
		int	21h		; DOS -	2+ - GET INTERRUPT VECTOR
					; AL = interrupt number
					; Return: ES:BX	= value	of interrupt vector
		mov	word ptr cs:OldIntVec06b+2, es
		mov	word ptr cs:OldIntVec06b, bx
		mov	ax, cs
		mov	ds, ax
		mov	dx, offset IntDummy
		mov	al, 6
		mov	ah, 25h
		int	21h		; DOS -	SET INTERRUPT VECTOR
					; AL = interrupt number
					; DS:DX	= new vector to	be used	for specified interrupt
		sti
		pop	es
		pop	ds
		assume ds:dseg
		popa
		retf
SetupIntVec24	endp

; ---------------------------------------------------------------------------

Int24:					; DATA XREF: SetupIntVec24+18o
		pushf
		xor	al, al
		popf
		iret
; ---------------------------------------------------------------------------

IntDummy:				; DATA XREF: SetupIntVec24+35o
					; SetupIntVec24+52o
		iret

; =============== S U B	R O U T	I N E =======================================


RestoreIntVec24	proc far		; CODE XREF: sub_12FB3+150P
		push	ax
		push	cx
		push	ds
		cli
		mov	ds, word ptr cs:OldIntVec05b+2
		mov	dx, word ptr cs:OldIntVec05b
		mov	al, 5
		mov	ah, 25h
		int	21h		; DOS -	SET INTERRUPT VECTOR
					; AL = interrupt number
					; DS:DX	= new vector to	be used	for specified interrupt
		mov	ds, word ptr cs:OldIntVec06b+2
		mov	dx, word ptr cs:OldIntVec06b
		mov	al, 6
		mov	ah, 25h
		int	21h		; DOS -	SET INTERRUPT VECTOR
					; AL = interrupt number
					; DS:DX	= new vector to	be used	for specified interrupt
		mov	ds, word ptr cs:OldIntVec24+2
		mov	dx, word ptr cs:OldIntVec24
		mov	al, 24h
		mov	ah, 25h
		int	21h		; DOS -	SET INTERRUPT VECTOR
					; AL = interrupt number
					; DS:DX	= new vector to	be used	for specified interrupt
		sti
		mov	cx, 80h

loc_1322A:				; CODE XREF: RestoreIntVec24+3Cj
		mov	ah, 5
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		loop	loc_1322A
		xor	ax, ax
		mov	ds, ax
		assume ds:nothing
		and	byte ptr ds:500h, 0DFh
		out	0A8h, al	; Interrupt Controller #2, 8259A
		out	0ACh, al	; Interrupt Controller #2, 8259A
		out	0AAh, al	; Interrupt Controller #2, 8259A
		out	0AEh, al	; Interrupt Controller #2, 8259A
		call	sub_1430F
		mov	al, 0Ah
		out	68h, al
		push	cs
		call	near ptr sub_13252
		pop	ds
		assume ds:dseg
		pop	cx
		pop	ax
		retf
RestoreIntVec24	endp


; =============== S U B	R O U T	I N E =======================================


sub_13252	proc far		; CODE XREF: RestoreIntVec24+59p
		push	ax
		mov	ah, 0Ch
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		pop	ax
		retf
sub_13252	endp


; =============== S U B	R O U T	I N E =======================================


WaitForVSync	proc far		; CODE XREF: seg002:0170p
					; sub_140FA:loc_14119P	...
		push	ax

loc_1325A:				; CODE XREF: WaitForVSync+5j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1325A

loc_13260:				; CODE XREF: WaitForVSync+Bj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_13260
		pop	ax
		retf
WaitForVSync	endp

; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		push	cx
		mov	cx, [bp+6]

loc_1326F:				; CODE XREF: seg002:0173j
		push	cs
		call	near ptr WaitForVSync
		loop	loc_1326F
		pop	cx
		pop	bp
		retf
seg002		ends

; ===========================================================================

; Segment type:	Pure code
seg003		segment	byte public 'CODE' use16
		assume cs:seg003
		;org 8
		assume es:nothing, ss:nothing, ds:dseg,	fs:nothing, gs:nothing
FontDataBuffer	db 20h dup(0)		; DATA XREF: PrintFontChar+2Fo
					; PrintFontChar+93o
textChrMode	dw 0			; DATA XREF: PrintFontChar+56w
					; PrintFontChar:loc_139FFw ...
byte_1329A	db 0			; DATA XREF: PrintFontChar+Cw
					; PrintFontChar:gfc_customw ...
CustomFontData	dw  210Dh, 0000h, 0000h, 0020h,	0070h, 00C0h, 0300h, 0608h, 181Ch, 2070h, 0180h, 0300h,	0C00h, 1000h, 0000h, 0000h, 0000h
					; DATA XREF: PrintFontChar:gfc_jiso
		dw  220Dh, 0000h, 0000h, 0000h,	0604h, 1B98h, 20E0h, 0040h, 0604h, 1B98h, 20E0h, 0040h,	0000h, 0000h, 0000h, 0000h, 0000h
		dw  230Dh, 0000h, 0100h, 0280h,	0280h, 4444h, 3458h, 2828h, 1830h, 0820h, 0C60h, 16D0h,	1290h, 1110h, 0000h, 0000h, 0000h
		dw  240Dh, 0000h, 0000h, 0000h,	1000h, 1000h, 1000h, 1020h, 1820h, 7FFCh, 1820h, 1820h,	1800h, 1800h, 0000h, 0000h, 0000h
		dw  250Dh, 0000h, 0000h, 0030h,	0C20h, 1860h, 1040h, 20C0h, 3FFCh, 0184h, 0308h, 0218h,	0630h, 0400h, 0C00h, 0000h, 0000h
		dw  260Dh, 0000h, 0000h, 0000h,	07E0h, 0810h, 1008h, 1008h, 1188h, 1188h, 1008h, 1008h,	0810h, 07E0h, 0000h, 0000h, 0000h
		dw  270Dh, 0000h, 0000h, 0C18h,	0C18h, 09C8h, 09C8h, 0888h, 0FF8h, 0080h, 0080h, 0080h,	0080h, 0080h, 0080h, 0000h, 0000h
		dw  280Dh, 0000h, 0080h, 0C98h,	0490h, 0490h, 0490h, 0490h, 0490h, 03E0h, 01C0h, 0080h,	0080h, 0080h, 01C0h, 0000h, 0000h
		dw  290Dh, 0000h, 0820h, 0440h,	0280h, 0100h, 0380h, 06C0h, 0C60h, 06C0h, 0380h, 0100h,	0280h, 0440h, 0820h, 0000h, 0000h
		dw  2A0Dh, 0000h, 0040h, 0240h,	0742h, 09C2h, 10C2h, 2062h, 6E52h, 334Ah, 3946h, 24C6h,	22C6h, 11C0h, 0EE0h, 0060h, 0000h
		dw  2B0Dh, 0000h, 2004h, 2004h,	300Ch, 281Ch, 243Ch, 227Ch, 21FCh, 227Ch, 243Ch, 281Ch,	300Ch, 2004h, 2004h, 0000h, 0000h
		dw  2C0Dh, 0000h, 0200h, 0200h,	0600h, 03E0h, 0260h, 0200h, 0600h, 03E0h, 0260h, 0200h,	0200h, 0300h, 0300h, 0300h, 0000h
		dw  2D0Dh, 0000h, 0440h, 0640h,	0640h, 0540h, 04C0h, 0440h, 0400h, 0400h, 0440h, 04C0h,	0540h, 0640h, 0640h, 0440h, 0000h
		dw  300Dh, 0000h, 7C00h, 2200h,	2200h, 3C00h, 2200h, 2200h, 7C78h, 0084h, 0080h, 0078h,	0004h, 0084h, 0078h, 0000h, 0000h
		dw  310Dh,0F000h, 8000h, 8000h,0F000h, 8000h, 8440h,0F640h, 0640h, 0540h, 04DCh, 04D2h,	0451h, 0011h, 0011h, 0012h, 001Ch
		dw  320Dh, 0000h, 3FFCh, 6002h,	7002h, 5802h, 4C02h, 4602h, 4302h, 4182h, 40C2h, 4062h,	4032h, 401Ah, 400Eh, 3FFCh, 0000h
		dw  330Dh, 0000h, 3FFCh, 4002h,	4002h, 4182h, 4182h, 4182h, 4FF2h, 4FF2h, 4182h, 4182h,	4182h, 4002h, 4002h, 3FFCh, 0000h
		dw  340Dh, 0000h, 3FFCh, 4002h,	4002h, 4002h, 4002h, 4002h, 47E2h, 47E2h, 4002h, 4002h,	4002h, 4002h, 4002h, 3FFCh, 0000h
		dw  650Dh, 0000h, 0000h, 1C1Ch,	3E3Eh, 6363h, 41C1h, 4081h, 4001h, 2002h, 2002h, 1004h,	0C18h, 0630h, 0360h, 01C0h, 0080h
		dw  660Dh, 0100h, 0100h, 0100h,	0100h, 0100h, 0300h, 0300h, 0300h, 0240h, 0600h, 0640h,	0440h, 0440h, 06C0h, 0380h, 0000h
		dw  670Dh, 0000h, 0180h, 03C0h,	0240h, 04C0h, 0080h, 0900h, 0200h, 0400h, 0800h, 1018h,	0044h, 010Ch, 0078h, 0000h, 0000h
		dw  680Dh, 0000h, 0000h, 3C38h,	2210h, 2110h, 2110h, 2310h, 3E10h, 3810h, 2410h, 2210h,	2310h, 21B8h, 0000h, 0000h, 0000h
		dw  690Dh, 0000h, 0000h, 8430h,0C448h,0C48Ch,0E484h,0A480h,0A480h, 949Ch, 948Ch, 8C84h,	8C48h, 8430h, 0000h, 0000h, 0000h
		dw  4109h, 0006h, 000Eh, 001Eh,	0036h, 0066h, 00C6h, 0186h, 03FEh, 07FEh, 0C06h, 1806h,	3FFEh, 7FFEh,0C006h, 8006h, 0000h
		dw  4209h, 18C0h, 19E0h, 19E0h,	18C0h, 1800h, 18C0h, 19E0h, 19E0h, 18C0h, 1800h, 18C0h,	19E0h, 19E0h, 18C0h, 1800h, 0000h
		dw  4309h, 0030h, 0030h, 0030h,	0030h, 0030h, 0630h, 0F30h, 0F30h, 0630h, 0030h, 0030h,	0030h, 0030h, 0030h, 0030h, 0000h
		dw  4409h, 3300h, 3300h, 3300h,	3300h, 3300h, 3318h, 333Ch, 333Ch, 3318h, 3300h, 3300h,	3300h, 3300h, 3300h, 3300h, 0000h
		dw  4509h, 3000h, 30C0h, 31E0h,	31E0h, 30C0h, 3000h, 3000h, 3FF8h, 3FF8h, 3000h, 30C0h,	31E0h, 31E0h, 30C0h, 3000h, 0000h
		dw  4609h, 1800h, 18C0h, 19E0h,	19E0h, 18C0h, 1800h, 18C0h, 19E0h, 19E0h, 18C0h, 1800h,	1800h, 1800h, 1800h, 1800h, 0000h
		dw  4709h, 6000h, 6000h, 6000h,	6000h, 6000h, 6180h, 63C0h, 63C0h, 6180h, 6000h, 6000h,	6000h, 6000h, 7FFEh, 7FFEh, 0000h
		dw  4809h, 6006h, 6006h, 6006h,	6006h, 6006h, 6006h, 6186h, 63C6h, 63C6h, 6186h, 6006h,	6006h, 6006h, 6006h, 6006h, 0000h
		dw  4909h, 0180h, 0180h, 0180h,	0180h, 0180h, 0180h, 0180h, 0180h, 0180h, 0180h, 0180h,	0180h, 0180h, 0180h, 0180h, 0000h
		dw  4A09h, 3FF8h, 0000h,0FFFEh,0FFFEh, 018Ch, 018Ch, 0198h, 0198h, 01B0h, 01B0h, 01E0h,	01E0h, 01C0h, 01C0h, 0180h, 0000h
		dw  4B09h, 0180h, 0180h, 0180h,	01B8h, 01F8h, 07D8h, 1F98h, 7998h, 1F98h, 07D8h, 01F8h,	01B8h, 0180h, 0180h, 0180h, 0000h
		dw  4C09h,0C000h,0C000h,0C000h,0C000h,0C000h,0C000h,0C000h,0C000h,0C000h,0FFFCh,0FFFCh,0C000h,0C000h,0FFFCh,0FFFCh, 0000h
		dw  4D09h, 3030h, 3030h, 3030h,	3030h, 3030h, 3030h,0FFFCh,0FFFCh, 3030h, 3330h, 37B0h,	37B0h, 3330h, 3030h, 3030h, 0000h
		dw  4E09h, 1818h, 1818h, 1818h,	1818h, 7818h, 7818h, 1E18h, 1F98h, 19F8h, 1878h, 181Eh,	181Eh, 1818h, 1818h, 1818h, 0000h
		dw  4F09h, 03C0h, 0FF0h, 1C38h,	300Ch, 300Ch, 6006h, 6006h, 6006h, 6006h, 6006h, 300Ch,	300Ch, 1C38h, 0FF0h, 03C0h, 0000h
		dw  5009h, 07E0h, 0FF0h, 1818h,	300Ch, 300Ch, 300Ch, 300Ch, 1818h, 0FF0h, 07E0h, 0000h,	0180h, 03C0h, 03C0h, 0180h, 0000h
		dw  5109h, 03C0h, 0FF0h, 1C38h,	300Ch, 300Ch, 6006h, 63C6h, 63C6h, 63C6h, 6006h, 300Ch,	300Ch, 1C38h, 0FF0h, 03C0h, 0000h
		dw  5209h, 63C0h, 6FF0h, 7C38h,	700Ch, 6006h, 6006h, 6006h, 700Ch, 7C38h, 6FF0h, 63C0h,	6000h, 6000h, 6000h, 6000h, 0000h
		dw  5309h, 0180h, 0190h, 01B0h,	01F0h, 01F0h, 01B0h, 0190h, 0980h, 0D80h, 0F80h, 0F80h,	0D80h, 0980h, 0180h, 0180h, 0000h
		dw  5409h, 0180h, 0180h, 0180h,	0180h, 0180h, 0180h, 7FFEh, 7FFEh, 0180h, 0180h, 0180h,	0180h, 0180h, 0180h, 0180h, 0000h
		dw  5509h, 0000h, 0FC0h, 3FF0h,	7038h, 400Ch, 0006h, 0006h, 0006h, 0006h, 0006h, 400Ch,	7038h, 3FF0h, 0FC0h, 0000h, 0000h
		dw  5609h, 7FFEh, 7FFEh, 6006h,	6006h, 300Ch, 300Ch, 1818h, 1818h, 0C30h, 0C30h, 0660h,	0660h, 03C0h, 0180h, 0180h, 0000h
		dw  5709h, 7FFEh, 7FFEh, 63C6h,	63C6h, 63C6h, 366Ch, 366Ch, 366Ch, 366Ch, 1C38h, 1C38h,	1C38h, 0810h, 0810h, 0810h, 0000h
		dw  5809h, 7FFEh, 7FFEh, 300Ch,	1818h, 0C30h, 0660h, 03C0h, 0180h, 03C0h, 0660h, 0C30h,	1818h, 300Ch, 7FFEh, 7FFEh, 0000h
		dw  5909h, 7FFEh, 7FFEh, 6006h,	300Ch, 1818h, 0C30h, 0660h, 03C0h, 0180h, 0000h, 0000h,	0180h, 03C0h, 03C0h, 0180h, 0000h
		dw  5A09h, 7FFEh, 7FFEh, 0000h,	1FF8h, 0000h, 0180h, 03C0h, 03C0h, 0180h, 0000h, 1FF8h,	0000h, 7FFEh, 7FFEh, 0000h, 0000h
		dw  0000h

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

ShiftJIS2JIS	proc far		; CODE XREF: seg007:7139P seg007:724FP ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		mov	ax, [bp+arg_0]
		pop	bp
		sub	al, 81h
		shl	al, 1
		jns	short loc_1392E
		sub	al, 80h

loc_1392E:				; CODE XREF: ShiftJIS2JIS+Bj
		inc	al
		cmp	ah, 80h
		jb	short loc_13944
		cmp	ah, 9Fh
		jb	short loc_13940
		inc	al
		sub	ah, 7Eh
		retf
; ---------------------------------------------------------------------------

loc_13940:				; CODE XREF: ShiftJIS2JIS+19j
		sub	ah, 20h
		retf
; ---------------------------------------------------------------------------

loc_13944:				; CODE XREF: ShiftJIS2JIS+14j
		sub	ah, 1Fh
		retf
ShiftJIS2JIS	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

PrintFontChar	proc far		; CODE XREF: seg007:714DP seg007:7263P ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		pusha
		push	ds
		push	es
		cld
		cli
		mov	al, 0C0h
		out	7Ch, al
		mov	cs:byte_1329A, 0
		mov	ax, [bp+arg_0]
		or	ah, ah
		jz	short gfc_get_ascii
		jmp	short gfc_jis
; ---------------------------------------------------------------------------

gfc_get_ascii:				; CODE XREF: PrintFontChar+17j
		mov	ah, al
		mov	al, 9		; AL 00..7F -> page 09h	- ASCII	mirror
		cmp	ah, 80h
		jb	short loc_13971	; choose JIS page 09h/0Ah depending on character code
		mov	al, 0Ah		; AL 80..FF -> page 0Ah	- half-width Katakana
		add	ah, 80h

loc_13971:				; CODE XREF: PrintFontChar+22j
		out	0A3h, al	; character code, high byte (page)
		mov	al, ah
		out	0A1h, al	; character code, low byte
		mov	si, offset FontDataBuffer
		mov	dx, si
		xor	cl, cl

loc_1397E:				; CODE XREF: PrintFontChar+54j
		mov	al, cl
		out	0A5h, al	; Interrupt Controller #2, 8259A
		in	al, 0A9h	; Interrupt Controller #2, 8259A
		mov	ah, al
		mov	al, cl
		add	al, 20h
		out	0A5h, al	; Interrupt Controller #2, 8259A
		in	al, 0A9h	; Interrupt Controller #2, 8259A
		shl	ax, 8
		mov	cs:[si], ax
		add	si, 2
		inc	cl
		cmp	cl, 10h
		jb	short loc_1397E
		mov	cs:textChrMode,	1 ; mode 1 - half-width
		jmp	short loc_13A06
; ---------------------------------------------------------------------------

gfc_jis:				; CODE XREF: PrintFontChar+19j
		mov	si, offset CustomFontData

loc_139AA:				; CODE XREF: PrintFontChar+70j
		mov	bx, cs:[si]
		or	bx, bx
		jz	short gfc_get_jis ; list end reached - jump
		sub	bx, ax
		jz	short gfc_custom ; character has an entry in the Custom	Font list - jump
		add	si, 22h
		jmp	short loc_139AA	; try next entry
; ---------------------------------------------------------------------------

gfc_custom:				; CODE XREF: PrintFontChar+6Bj
		mov	cs:byte_1329A, 1
		mov	bx, cs
		mov	ds, bx
		assume ds:seg003
		add	si, 2
		mov	es, bx
		assume es:seg003
		mov	di, 8
		mov	dx, di
		mov	cx, 10h
		rep movsw
		jmp	short loc_139FF
; ---------------------------------------------------------------------------

gfc_get_jis:				; CODE XREF: PrintFontChar+67j
		out	0A3h, al	; character code, high byte (page)
		mov	al, ah
		out	0A1h, al	; character code, low byte
		mov	si, offset FontDataBuffer
		mov	dx, si
		xor	cl, cl

loc_139E2:				; CODE XREF: PrintFontChar+B5j
		mov	al, cl
		or	al, 20h
		out	0A5h, al	; Interrupt Controller #2, 8259A
		in	al, 0A9h	; Interrupt Controller #2, 8259A
		mov	ah, al
		mov	al, cl
		out	0A5h, al	; Interrupt Controller #2, 8259A
		in	al, 0A9h	; Interrupt Controller #2, 8259A
		mov	cs:[si], ax
		add	si, 2
		inc	cl
		cmp	cl, 10h
		jb	short loc_139E2

loc_139FF:				; CODE XREF: PrintFontChar+8Bj
		mov	cs:textChrMode,	0 ; mode 0 - full-width

loc_13A06:				; CODE XREF: PrintFontChar+5Dj
		mov	ax, seg	dseg
		mov	ds, ax
		assume ds:dseg
		mov	ah, byte ptr txtColorShdw
		shr	ah, 1
		sbb	al, al
		out	7Eh, al
		shr	ah, 1
		sbb	al, al
		out	7Eh, al
		shr	ah, 1
		sbb	al, al
		out	7Eh, al
		shr	ah, 1
		sbb	al, al
		out	7Eh, al
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		mov	di, textDrawPtr
		push	di
		add	di, 50h
		mov	si, dx
		xor	cl, cl

loc_13A38:				; CODE XREF: PrintFontChar+109j
		mov	ax, cs:[si]
		mov	bx, ax
		shr	bx, 1		; make bold by duplicating all pixels 1	to the right
		or	ax, bx
		xchg	al, ah
		mov	es:[di], ax
		add	di, 50h
		add	si, 2
		inc	cl
		cmp	cl, 10h
		jb	short loc_13A38
		mov	ax, seg	dseg
		mov	ds, ax
		mov	ah, byte ptr txtColorMain
		shr	ah, 1
		sbb	al, al
		out	7Eh, al
		shr	ah, 1
		sbb	al, al
		out	7Eh, al
		shr	ah, 1
		sbb	al, al
		out	7Eh, al
		shr	ah, 1
		sbb	al, al
		out	7Eh, al
		pop	di
		mov	si, dx
		xor	cl, cl

loc_13A79:				; CODE XREF: PrintFontChar+158j
		mov	ax, cs:[si]
		test	cs:byte_1329A, 1
		jnz	short loc_13A90
		mov	bx, ax
		shl	bx, 1
		not	bx
		and	ax, bx
		not	bx
		or	ax, bx

loc_13A90:				; CODE XREF: PrintFontChar+13Aj
		xchg	al, ah
		mov	es:[di], ax
		add	di, 50h
		add	si, 2
		inc	cl
		cmp	cl, 10h
		jb	short loc_13A79
		xor	al, al
		out	7Ch, al
		sti
		sub	di, 4FEh	; subtract 4FEh	(full-width) or	4FFh (half-width)
		sub	di, cs:textChrMode ; i.e. DI = DI - 500h + txtChrMode
		mov	ax, seg	dseg
		mov	ds, ax
		mov	textDrawPtr, di
		pop	es
		assume es:nothing
		pop	ds
		popa
		pop	bp
		retf
PrintFontChar	endp

seg003		ends

; ===========================================================================

; Segment type:	Pure code
seg004		segment	byte public 'CODE' use16
		assume cs:seg004
		;org 0Eh
		assume es:nothing, ss:nothing, ds:dseg,	fs:nothing, gs:nothing
DecomprEndPtr	dw 0			; DATA XREF: ReadFile_Compr+73w
					; ReadFile_Compr+81r ...
MaxDecomprSize	dw 0FFFFh		; DATA XREF: ReadFile_Compr+65r
					; ReadFile_Compr+6Cr

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

ReadFile_Compr	proc far		; CODE XREF: LoadScript+25P
					; LoadScript+35P ...

arg_0		= word ptr  6
arg_2		= word ptr  8
arg_4		= word ptr  0Ah
arg_6		= word ptr  0Ch

		push	bp
		mov	bp, sp
		pusha
		push	es
		push	ds
		mov	ax, [bp+arg_2]
		mov	ds, ax
		mov	dx, [bp+arg_0]
		xor	al, al
		mov	ah, 3Dh
		int	21h		; DOS -	2+ - OPEN DISK FILE WITH HANDLE
					; DS:DX	-> ASCIZ filename
					; AL = access mode
					; 0 - read
		jnb	short loc_13ADB
		jmp	loc_13D50
; ---------------------------------------------------------------------------

loc_13ADB:				; CODE XREF: ReadFile_Compr+14j
		mov	bx, 0A800h
		mov	ds, bx
		assume ds:nothing
		xor	dx, dx
		mov	cx, 8000h
		mov	bx, ax
		mov	ah, 3Fh
		int	21h		; DOS -	2+ - READ FROM FILE WITH HANDLE
					; BX = file handle, CX = number	of bytes to read
					; DS:DX	-> buffer
		mov	ah, 3Eh
		int	21h		; DOS -	2+ - CLOSE A FILE WITH HANDLE
					; BX = file handle

LZSS_Decompress:
		xor	si, si
		mov	es, [bp+arg_6]
		mov	di, [bp+arg_4]
		cld
		push	di
		push	es
		mov	ax, ds
		mov	es, ax
		assume es:nothing
		mov	di, 8000h	; initialize LZSS nametable
		xor	al, al

loc_13B03:				; CODE XREF: ReadFile_Compr+48j
		mov	cx, 0Dh
		rep stosb
		inc	al
		jnz	short loc_13B03

loc_13B0C:				; CODE XREF: ReadFile_Compr+4Dj
		stosb
		inc	al
		jnz	short loc_13B0C

loc_13B11:				; CODE XREF: ReadFile_Compr+52j
		dec	al
		stosb
		jnz	short loc_13B11
		mov	cx, 80h
		rep stosb
		mov	al, ' '
		mov	cx, 6Eh
		rep stosb
		pop	es
		assume es:nothing
		pop	di		; parse	file header
		lodsw			; skip "compressed size", low word
		lodsw			; skip "compressed size", high word
		lodsw			; read "decompressed size", low	word
		cmp	ax, cs:MaxDecomprSize
		jbe	short loc_13B32
		mov	ax, cs:MaxDecomprSize

loc_13B32:				; CODE XREF: ReadFile_Compr+6Aj
		push	ax
		add	ax, di
		mov	cs:DecomprEndPtr, ax
		lodsw			; skip "decompressed size", high word
		mov	bp, 0FEEh	; start	actual decompression
		mov	dx, 0FFFh

lzss_dec_loop:				; CODE XREF: ReadFile_Compr+288j
		lodsb
		mov	ah, al
		cmp	di, cs:DecomprEndPtr
		jnb	short loc_13B83
		shr	ah, 1
		jnb	short loc_13B5A
		lodsb
		stosb
		mov	ds:[bp+8000h], al
		inc	bp
		and	bp, dx
		jmp	short loc_13B83
; ---------------------------------------------------------------------------

loc_13B5A:				; CODE XREF: ReadFile_Compr+8Aj
		mov	bx, [si]
		add	si, 2
		mov	cl, bh
		and	cx, 0Fh
		add	cx, 3
		shr	bh, 4

loc_13B6A:				; CODE XREF: ReadFile_Compr+BFj
		mov	al, [bx+8000h]
		inc	bx
		and	bx, dx
		stosb
		mov	ds:[bp+8000h], al
		inc	bp
		and	bp, dx
		cmp	di, cs:DecomprEndPtr
		jnb	short loc_13B83
		loop	loc_13B6A

loc_13B83:				; CODE XREF: ReadFile_Compr+86j
					; ReadFile_Compr+96j ...
		cmp	di, cs:DecomprEndPtr
		jnb	short loc_13BC3
		shr	ah, 1
		jnb	short loc_13B9A
		lodsb
		stosb
		mov	ds:[bp+8000h], al
		inc	bp
		and	bp, dx
		jmp	short loc_13BC3
; ---------------------------------------------------------------------------

loc_13B9A:				; CODE XREF: ReadFile_Compr+CAj
		mov	bx, [si]
		add	si, 2
		mov	cl, bh
		and	cx, 0Fh
		add	cx, 3
		shr	bh, 4

loc_13BAA:				; CODE XREF: ReadFile_Compr+FFj
		mov	al, [bx+8000h]
		inc	bx
		and	bx, dx
		stosb
		mov	ds:[bp+8000h], al
		inc	bp
		and	bp, dx
		cmp	di, cs:DecomprEndPtr
		jnb	short loc_13BC3
		loop	loc_13BAA

loc_13BC3:				; CODE XREF: ReadFile_Compr+C6j
					; ReadFile_Compr+D6j ...
		cmp	di, cs:DecomprEndPtr
		jnb	short loc_13C03
		shr	ah, 1
		jnb	short loc_13BDA
		lodsb
		stosb
		mov	ds:[bp+8000h], al
		inc	bp
		and	bp, dx
		jmp	short loc_13C03
; ---------------------------------------------------------------------------

loc_13BDA:				; CODE XREF: ReadFile_Compr+10Aj
		mov	bx, [si]
		add	si, 2
		mov	cl, bh
		and	cx, 0Fh
		add	cx, 3
		shr	bh, 4

loc_13BEA:				; CODE XREF: ReadFile_Compr+13Fj
		mov	al, [bx+8000h]
		inc	bx
		and	bx, dx
		stosb
		mov	ds:[bp+8000h], al
		inc	bp
		and	bp, dx
		cmp	di, cs:DecomprEndPtr
		jnb	short loc_13C03
		loop	loc_13BEA

loc_13C03:				; CODE XREF: ReadFile_Compr+106j
					; ReadFile_Compr+116j ...
		cmp	di, cs:DecomprEndPtr
		jnb	short loc_13C43
		shr	ah, 1
		jnb	short loc_13C1A
		lodsb
		stosb
		mov	ds:[bp+8000h], al
		inc	bp
		and	bp, dx
		jmp	short loc_13C43
; ---------------------------------------------------------------------------

loc_13C1A:				; CODE XREF: ReadFile_Compr+14Aj
		mov	bx, [si]
		add	si, 2
		mov	cl, bh
		and	cx, 0Fh
		add	cx, 3
		shr	bh, 4

loc_13C2A:				; CODE XREF: ReadFile_Compr+17Fj
		mov	al, [bx+8000h]
		inc	bx
		and	bx, dx
		stosb
		mov	ds:[bp+8000h], al
		inc	bp
		and	bp, dx
		cmp	di, cs:DecomprEndPtr
		jnb	short loc_13C43
		loop	loc_13C2A

loc_13C43:				; CODE XREF: ReadFile_Compr+146j
					; ReadFile_Compr+156j ...
		cmp	di, cs:DecomprEndPtr
		jnb	short loc_13C83
		shr	ah, 1
		jnb	short loc_13C5A
		lodsb
		stosb
		mov	ds:[bp+8000h], al
		inc	bp
		and	bp, dx
		jmp	short loc_13C83
; ---------------------------------------------------------------------------

loc_13C5A:				; CODE XREF: ReadFile_Compr+18Aj
		mov	bx, [si]
		add	si, 2
		mov	cl, bh
		and	cx, 0Fh
		add	cx, 3
		shr	bh, 4

loc_13C6A:				; CODE XREF: ReadFile_Compr+1BFj
		mov	al, [bx+8000h]
		inc	bx
		and	bx, dx
		stosb
		mov	ds:[bp+8000h], al
		inc	bp
		and	bp, dx
		cmp	di, cs:DecomprEndPtr
		jnb	short loc_13C83
		loop	loc_13C6A

loc_13C83:				; CODE XREF: ReadFile_Compr+186j
					; ReadFile_Compr+196j ...
		cmp	di, cs:DecomprEndPtr
		jnb	short loc_13CC3
		shr	ah, 1
		jnb	short loc_13C9A
		lodsb
		stosb
		mov	ds:[bp+8000h], al
		inc	bp
		and	bp, dx
		jmp	short loc_13CC3
; ---------------------------------------------------------------------------

loc_13C9A:				; CODE XREF: ReadFile_Compr+1CAj
		mov	bx, [si]
		add	si, 2
		mov	cl, bh
		and	cx, 0Fh
		add	cx, 3
		shr	bh, 4

loc_13CAA:				; CODE XREF: ReadFile_Compr+1FFj
		mov	al, [bx+8000h]
		inc	bx
		and	bx, dx
		stosb
		mov	ds:[bp+8000h], al
		inc	bp
		and	bp, dx
		cmp	di, cs:DecomprEndPtr
		jnb	short loc_13CC3
		loop	loc_13CAA

loc_13CC3:				; CODE XREF: ReadFile_Compr+1C6j
					; ReadFile_Compr+1D6j ...
		cmp	di, cs:DecomprEndPtr
		jnb	short loc_13D03
		shr	ah, 1
		jnb	short loc_13CDA
		lodsb
		stosb
		mov	ds:[bp+8000h], al
		inc	bp
		and	bp, dx
		jmp	short loc_13D03
; ---------------------------------------------------------------------------

loc_13CDA:				; CODE XREF: ReadFile_Compr+20Aj
		mov	bx, [si]
		add	si, 2
		mov	cl, bh
		and	cx, 0Fh
		add	cx, 3
		shr	bh, 4

loc_13CEA:				; CODE XREF: ReadFile_Compr+23Fj
		mov	al, [bx+8000h]
		inc	bx
		and	bx, dx
		stosb
		mov	ds:[bp+8000h], al
		inc	bp
		and	bp, dx
		cmp	di, cs:DecomprEndPtr
		jnb	short loc_13D03
		loop	loc_13CEA

loc_13D03:				; CODE XREF: ReadFile_Compr+206j
					; ReadFile_Compr+216j ...
		cmp	di, cs:DecomprEndPtr
		jnb	short loc_13D43
		shr	ah, 1
		jnb	short loc_13D1A
		lodsb
		stosb
		mov	ds:[bp+8000h], al
		inc	bp
		and	bp, dx
		jmp	short loc_13D43
; ---------------------------------------------------------------------------

loc_13D1A:				; CODE XREF: ReadFile_Compr+24Aj
		mov	bx, [si]
		add	si, 2
		mov	cl, bh
		and	cx, 0Fh
		add	cx, 3
		shr	bh, 4

loc_13D2A:				; CODE XREF: ReadFile_Compr+27Fj
		mov	al, [bx+8000h]
		inc	bx
		and	bx, dx
		stosb
		mov	ds:[bp+8000h], al
		inc	bp
		and	bp, dx
		cmp	di, cs:DecomprEndPtr
		jnb	short loc_13D43
		loop	loc_13D2A

loc_13D43:				; CODE XREF: ReadFile_Compr+246j
					; ReadFile_Compr+256j ...
		cmp	di, cs:DecomprEndPtr
		jnb	short loc_13D4D
		jmp	lzss_dec_loop
; ---------------------------------------------------------------------------

loc_13D4D:				; CODE XREF: ReadFile_Compr+286j
		pop	ax
		xor	dx, dx

loc_13D50:				; CODE XREF: ReadFile_Compr+16j
		pop	ds
		assume ds:dseg
		pop	es
		popa
		pop	bp
		retf
ReadFile_Compr	endp

seg004		ends

; ===========================================================================

; Segment type:	Pure code
seg005		segment	byte public 'CODE' use16
		assume cs:seg005
		;org 5
		assume es:nothing, ss:nothing, ds:dseg,	fs:nothing, gs:nothing
		align 2
word_13D56	dw 0			; DATA XREF: ImageCopy2+14w
					; ImageCopy2+124r ...
word_13D58	dw 0			; DATA XREF: ImageCopy2+18w
					; ImageCopy2+12Dr ...
word_13D5A	dw 0			; DATA XREF: ImageCopy3+130w
					; ImageCopy3+16Cr ...
word_13D5C	dw 0			; DATA XREF: ImageCopy3+142w
					; ImageCopy3+179r ...
		db 48h dup(0)
word_13DA6	dw 0A800h		; DATA XREF: sub_13EF4+36r
					; sub_13EF4+8Cr ...
word_13DA8	dw 0B000h		; DATA XREF: sub_13EF4+48r
					; sub_13EF4+9Er
word_13DAA	dw 0B800h		; DATA XREF: sub_13EF4+5Ar
					; sub_13EF4+B0r
word_13DAC	dw 0E000h		; DATA XREF: sub_13EF4+6Cr
					; sub_13EF4+C2r
word_13DAE	dw  1200,  561		; DATA XREF: ImageCopy2+Eo
		dw  1120,  481
		dw  1040,  401
		dw   960,  321
		dw   880,  241
		dw   800,  161
		dw   720,   81
		dw   640,    1
		dw  1201,  560
		dw  1121,  480
		dw  1041,  400
		dw   961,  320
		dw   881,  240
		dw   801,  160
		dw   721,   80
		dw   641,    0
		dw   641, 1200
		dw   721, 1120
		dw   801, 1040
		dw   881,  960
		dw   961,  880
		dw  1041,  800
		dw  1121,  720
		dw  1201,  640
		dw     1,  560
		dw    81,  480
		dw   161,  400
		dw   241,  320
		dw   321,  240
		dw   401,  160
		dw   481,   80
		dw   561,    0
		dw  1201,  560
		dw  1120,  481
		dw  1041,  400
		dw   960,  321
		dw   881,  240
		dw   800,  161
		dw   721,   80
		dw   640,    1
		dw  1200,  561
		dw  1121,  480
		dw  1040,  401
		dw   961,  320
		dw   880,  241
		dw   801,  160
		dw   720,   81
		dw   641,    0
		db 00h,	00h, 00h
		db 00h,	00h, 00h
		db 00h,	00h, 00h
		db 00h,	0Fh, 00h
		db 0Fh,	00h, 00h
		db 00h,	00h, 00h
		db 0Fh,	00h, 00h
		db 00h,	0Fh, 00h
		db 00h,	00h, 0Fh
		db 00h,	00h, 00h
		db 00h,	00h, 0Fh
		db 00h,	0Fh, 00h
		db 0Fh,	00h, 0Fh
		db 00h,	00h, 00h
		db 0Fh,	00h, 0Fh
		db 00h,	0Fh, 00h
word_13E9E	dw 0			; DATA XREF: ImageCopy1+25r
					; ImageCopy1+7Br ...
word_13EA0	dw 0			; DATA XREF: ImageCopy1+37r
					; ImageCopy1+8Dr ...
word_13EA2	dw 0			; DATA XREF: ImageCopy1+49r
					; ImageCopy1+9Fr ...
word_13EA4	dw 0			; DATA XREF: ImageCopy1+5Br
					; ImageCopy1+B1r ...
word_13EA6	dw 0			; DATA XREF: sub_1416A+28r
					; sub_1416A+72r ...
word_13EA8	dw 0			; DATA XREF: sub_1416A+37r
					; sub_1416A+81r ...
word_13EAA	dw 0			; DATA XREF: sub_1416A+46r
					; sub_1416A+90r ...
word_13EAC	dw 0			; DATA XREF: sub_1416A+55r
					; sub_1416A+9Fr ...
byte_13EAE	db 20h dup(0)		; DATA XREF: sub_13ECE+10o
					; sub_14375+12o

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_13ECE	proc far		; CODE XREF: LoadGTAFile+21P
					; sub_1431D+21p ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		pusha
		push	ds
		push	es
		mov	ax, cs
		mov	ds, ax
		assume ds:seg005
		mov	si, [bp+arg_0]
		shl	si, 3
		add	si, offset byte_13EAE
		mov	ax, seg	dseg
		mov	es, ax
		assume es:dseg
		mov	di, offset word_21EAA
		mov	cx, 4
		rep movsw
		pop	es
		assume es:nothing
		pop	ds
		assume ds:dseg
		popa
		pop	bp
		retf
sub_13ECE	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_13EF4	proc far		; CODE XREF: seg007:8F29P seg007:8F47P

arg_0		= word ptr  6
arg_2		= word ptr  8
arg_4		= word ptr  0Ah
arg_6		= word ptr  0Ch

		push	bp
		mov	bp, sp
		pusha
		push	ds
		push	es
		mov	ax, seg	dseg
		mov	ds, ax
		mov	si, 0BA18h
		mov	ax, cs
		mov	es, ax
		assume es:seg005
		mov	di, offset byte_1DF5F
		mov	cx, 4
		rep movsw
		mov	bx, [bp+arg_0]
		mov	dx, [bp+arg_6]
		mov	cx, [bp+arg_4]
		mov	ax, [bp+arg_2]
		shr	ax, 3
		test	ax, 1
		jz	short loc_13F76

loc_13F22:				; CODE XREF: sub_13EF4+7Ej
		push	cx
		mov	ds, cs:word_13FCF
		assume ds:nothing
		mov	si, bx
		mov	es, cs:word_13DA6
		assume es:nothing
		mov	di, dx
		mov	cx, ax
		rep movsb
		mov	ds, cs:word_13FD1
		mov	si, bx
		mov	es, cs:word_13DA8
		assume es:nothing
		mov	di, dx
		mov	cx, ax
		rep movsb
		mov	ds, cs:word_13FD3
		mov	si, bx
		mov	es, cs:word_13DAA
		assume es:nothing
		mov	di, dx
		mov	cx, ax
		rep movsb
		mov	ds, cs:word_13FD5
		mov	si, bx
		mov	es, cs:word_13DAC
		assume es:nothing
		mov	di, dx
		mov	cx, ax
		rep movsb
		add	bx, 50h
		add	dx, 50h
		pop	cx
		loop	loc_13F22
		jmp	short loc_13FCA
; ---------------------------------------------------------------------------

loc_13F76:				; CODE XREF: sub_13EF4+2Cj
		shr	ax, 1

loc_13F78:				; CODE XREF: sub_13EF4+D4j
		push	cx
		mov	ds, cs:word_13FCF
		mov	si, bx
		mov	es, cs:word_13DA6
		assume es:nothing
		mov	di, dx
		mov	cx, ax
		rep movsw
		mov	ds, cs:word_13FD1
		mov	si, bx
		mov	es, cs:word_13DA8
		assume es:nothing
		mov	di, dx
		mov	cx, ax
		rep movsw
		mov	ds, cs:word_13FD3
		mov	si, bx
		mov	es, cs:word_13DAA
		assume es:nothing
		mov	di, dx
		mov	cx, ax
		rep movsw
		mov	ds, cs:word_13FD5
		mov	si, bx
		mov	es, cs:word_13DAC
		assume es:nothing
		mov	di, dx
		mov	cx, ax
		rep movsw
		add	bx, 50h
		add	dx, 50h
		pop	cx
		loop	loc_13F78

loc_13FCA:				; CODE XREF: sub_13EF4+80j
		pop	es
		assume es:nothing
		pop	ds
		assume ds:dseg
		popa
		pop	bp
		retf
sub_13EF4	endp

; ---------------------------------------------------------------------------
word_13FCF	dw 0			; DATA XREF: sub_13EF4+2Fr
					; sub_13EF4+85r
word_13FD1	dw 0			; DATA XREF: sub_13EF4+41r
					; sub_13EF4+97r
word_13FD3	dw 0			; DATA XREF: sub_13EF4+53r
					; sub_13EF4+A9r
word_13FD5	dw 0			; DATA XREF: sub_13EF4+65r
					; sub_13EF4+BBr

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

WritePortA6	proc far		; CODE XREF: LoadGTAFile+5CP
					; sub_14005+Bp	...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	ax
		mov	ax, [bp+arg_0]
		out	0A6h, al	; Interrupt Controller #2, 8259A
		pop	ax
		pop	bp
		retf
WritePortA6	endp


; =============== S U B	R O U T	I N E =======================================


CopyGTAPalette	proc far		; CODE XREF: LoadGTAFile+172P
		push	ax
		push	cx
		push	si
		push	di
		push	ds
		push	es
		mov	ax, seg	dseg
		mov	ds, ax
		mov	si, offset byte_21DF2
		mov	ax, seg	dseg
		mov	es, ax
		assume es:dseg
		mov	di, offset byte_21EB3
		mov	cx, 18h
		rep movsw
		pop	es
		assume es:nothing
		pop	ds
		pop	di
		pop	si
		pop	cx
		pop	ax
		retf
CopyGTAPalette	endp


; =============== S U B	R O U T	I N E =======================================


sub_14005	proc far		; CODE XREF: seg007:7B8FP seg007:7E48P ...
		pusha
		push	ds
		push	es
		xor	bx, bx
		mov	dx, 400

loc_1400D:				; CODE XREF: sub_14005+EEj
		push	0
		push	cs
		call	near ptr WritePortA6
		add	sp, 2
		mov	ax, 0A800h
		mov	ds, ax
		assume ds:nothing
		mov	si, bx
		mov	ax, cs
		mov	es, ax
		assume es:seg005
		mov	di, 6
		mov	cx, 28h
		rep movsw
		push	1
		push	cs
		call	near ptr WritePortA6
		add	sp, 2
		mov	ax, cs
		mov	ds, ax
		assume ds:seg005
		mov	si, 6
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		mov	di, bx
		mov	cx, 28h
		rep movsw
		push	0
		push	cs
		call	near ptr WritePortA6
		add	sp, 2
		mov	ax, 0B000h
		mov	ds, ax
		assume ds:nothing
		mov	si, bx
		mov	ax, cs
		mov	es, ax
		assume es:seg005
		mov	di, 6
		mov	cx, 28h
		rep movsw
		push	1
		push	cs
		call	near ptr WritePortA6
		add	sp, 2
		mov	ax, cs
		mov	ds, ax
		assume ds:seg005
		mov	si, 6
		mov	ax, 0B000h
		mov	es, ax
		assume es:nothing
		mov	di, bx
		mov	cx, 28h
		rep movsw
		push	0
		push	cs
		call	near ptr WritePortA6
		add	sp, 2
		mov	ax, 0B800h
		mov	ds, ax
		assume ds:nothing
		mov	si, bx
		mov	ax, cs
		mov	es, ax
		assume es:seg005
		mov	di, 6
		mov	cx, 28h
		rep movsw
		push	1
		push	cs
		call	near ptr WritePortA6
		add	sp, 2
		mov	ax, cs
		mov	ds, ax
		assume ds:seg005
		mov	si, 6
		mov	ax, 0B800h
		mov	es, ax
		assume es:nothing
		mov	di, bx
		mov	cx, 28h
		rep movsw
		push	0
		push	cs
		call	near ptr WritePortA6
		add	sp, 2
		mov	ax, 0E000h
		mov	ds, ax
		assume ds:nothing
		mov	si, bx
		mov	ax, cs
		mov	es, ax
		assume es:seg005
		mov	di, 6
		mov	cx, 28h
		rep movsw
		push	1
		push	cs
		call	near ptr WritePortA6
		add	sp, 2
		mov	ax, cs
		mov	ds, ax
		assume ds:seg005
		mov	si, 6
		mov	ax, 0E000h
		mov	es, ax
		assume es:nothing
		mov	di, bx
		mov	cx, 28h
		rep movsw
		dec	dx
		jz	short loc_140F6
		add	bx, 50h
		jmp	loc_1400D
; ---------------------------------------------------------------------------

loc_140F6:				; CODE XREF: sub_14005+E9j
		pop	es
		assume es:nothing
		pop	ds
		assume ds:dseg
		popa
		retf
sub_14005	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_140FA	proc far		; CODE XREF: seg007:7EB1P

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	ax
		push	bx
		push	cx
		push	ds
		mov	ax, seg	dseg
		mov	ds, ax
		xor	cl, cl

loc_14108:				; CODE XREF: sub_140FA+32j
		mov	bx, word_21EE3
		add	bx, [bp+arg_0]
		cmp	bx, 100
		jb	short loc_14119
		mov	bx, 100
		inc	cl

loc_14119:				; CODE XREF: sub_140FA+18j
		call	WaitForVSync
		push	bx
		push	cs
		call	near ptr sub_14920
		add	sp, 2
		mov	word_21EE3, bx
		or	cl, cl
		jz	short loc_14108
		pop	ds
		pop	cx
		pop	bx
		pop	ax
		pop	bp
		retf
sub_140FA	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_14134	proc far		; CODE XREF: seg007:7EBEP

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	ax
		push	bx
		push	cx
		push	ds
		mov	ax, seg	dseg
		mov	ds, ax
		xor	cl, cl

loc_14142:				; CODE XREF: sub_14134+2Ej
		mov	bx, word_21EE3
		sub	bx, [bp+arg_0]
		jnb	short loc_1414F
		xor	bx, bx
		inc	cl

loc_1414F:				; CODE XREF: sub_14134+15j
		call	WaitForVSync
		push	bx
		push	cs
		call	near ptr sub_14920
		add	sp, 2
		mov	word_21EE3, bx
		or	cl, cl
		jz	short loc_14142
		pop	ds
		pop	cx
		pop	bx
		pop	ax
		pop	bp
		retf
sub_14134	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1416A	proc far		; CODE XREF: seg007:85EDP

arg_0		= word ptr  6
arg_2		= word ptr  8
arg_4		= word ptr  0Ah
arg_6		= byte ptr  0Ch
arg_8		= word ptr  0Eh

		push	bp
		mov	bp, sp
		pusha
		push	es
		push	[bp+arg_8]
		call	ImageCopySetup
		add	sp, 2
		mov	si, [bp+arg_0]
		mov	cx, [bp+arg_4]
		mov	bx, [bp+arg_2]
		shr	bx, 3
		test	bx, 1
		jz	short loc_141D2

loc_1418A:				; CODE XREF: sub_1416A+64j
		push	cx
		mov	ah, [bp+arg_6]
		shr	ah, 1
		sbb	al, al
		mov	es, cs:word_13EA6
		assume es:nothing
		mov	di, si
		mov	cx, bx
		rep stosb
		shr	ah, 1
		sbb	al, al
		mov	es, cs:word_13EA8
		mov	di, si
		mov	cx, bx
		rep stosb
		shr	ah, 1
		sbb	al, al
		mov	es, cs:word_13EAA
		mov	di, si
		mov	cx, bx
		rep stosb
		shr	ah, 1
		sbb	al, al
		mov	es, cs:word_13EAC
		mov	di, si
		mov	cx, bx
		rep stosb
		add	si, 50h
		pop	cx
		loop	loc_1418A
		jmp	short loc_1421A
; ---------------------------------------------------------------------------

loc_141D2:				; CODE XREF: sub_1416A+1Ej
		shr	bx, 1

loc_141D4:				; CODE XREF: sub_1416A+AEj
		push	cx
		mov	dh, [bp+arg_6]
		shr	dh, 1
		sbb	ax, ax
		mov	es, cs:word_13EA6
		mov	di, si
		mov	cx, bx
		rep stosw
		shr	dh, 1
		sbb	ax, ax
		mov	es, cs:word_13EA8
		mov	di, si
		mov	cx, bx
		rep stosw
		shr	dh, 1
		sbb	ax, ax
		mov	es, cs:word_13EAA

loc_141FF:
		mov	di, si
		mov	cx, bx
		rep stosw
		shr	dh, 1
		sbb	ax, ax
		mov	es, cs:word_13EAC
		mov	di, si
		mov	cx, bx
		rep stosw
		add	si, 50h
		pop	cx
		loop	loc_141D4

loc_1421A:				; CODE XREF: sub_1416A+66j
		pop	es
		assume es:nothing
		popa
		pop	bp
		retf
sub_1416A	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1421E	proc far		; CODE XREF: sub_142DC+27p
					; sub_14920+33p

arg_0		= word ptr  6
arg_2		= word ptr  8
arg_4		= word ptr  0Ah
arg_6		= word ptr  0Ch

		push	bp
		mov	bp, sp
		push	ax
		push	bx
		push	cx
		push	dx
		push	ds
		mov	ax, seg	dseg
		mov	ds, ax
		mov	ax, word_21EE3
		mov	cx, ax
		mov	bx, 100
		mul	[bp+arg_2]
		div	bx
		mov	[bp+arg_2], ax
		mov	ax, cx
		mul	[bp+arg_4]
		div	bx
		mov	[bp+arg_4], ax
		mov	ax, cx
		mul	[bp+arg_6]
		div	bx
		mov	[bp+arg_6], ax
		mov	ax, seg	dseg
		mov	ds, ax
		mov	ax, MiscFlags
		test	al, 2
		jz	short loc_142C1
		mov	ax, [bp+arg_2]
		mov	bx, ax
		shl	ax, 5
		add	bx, bx
		add	ax, bx
		add	bx, bx
		add	ax, bx
		mov	bx, [bp+arg_4]
		mov	dx, bx
		mov	cx, dx
		shl	bx, 6
		shl	dx, 3
		add	bx, dx
		mov	dx, cx
		add	dx, dx
		add	bx, dx
		mov	dx, cx
		add	bx, dx
		add	ax, bx
		mov	bx, [bp+arg_6]
		mov	dx, bx
		shl	bx, 4
		sub	bx, dx
		add	ax, bx
		add	ax, 40h
		shr	ax, 8
		mov	bx, 7
		sub	bx, ax
		add	bx, bx
		mov	dx, bx
		add	bx, bx
		add	bx, dx
		add	bx, offset byte_1DDFE
		mov	ax, cs:[bx]
		add	bx, 2
		mov	[bp+arg_2], ax
		mov	ax, cs:[bx]
		add	bx, 2
		mov	[bp+arg_4], ax
		mov	ax, cs:[bx]
		mov	[bp+arg_6], ax

loc_142C1:				; CODE XREF: sub_1421E+3Bj
		mov	ax, [bp+arg_0]
		out	0A8h, al	; Interrupt Controller #2, 8259A
		mov	ax, [bp+arg_2]
		out	0ACh, al	; Interrupt Controller #2, 8259A
		mov	ax, [bp+arg_4]
		out	0AAh, al	; Interrupt Controller #2, 8259A
		mov	ax, [bp+arg_6]
		out	0AEh, al	; Interrupt Controller #2, 8259A
		pop	ds
		pop	dx
		pop	cx
		pop	bx
		pop	ax
		pop	bp
		retf
sub_1421E	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_142DC	proc far		; CODE XREF: ImageCopy2+133p
					; seg007:869AP

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	ax
		push	bx
		push	si
		push	ds
		mov	ax, seg	dseg
		mov	ds, ax
		mov	si, offset byte_21EB3
		mov	bx, [bp+arg_0]
		add	si, bx
		add	si, bx
		add	si, bx
		xor	ah, ah
		mov	al, [si+2]
		push	ax
		mov	al, [si+1]
		push	ax
		mov	al, [si]
		push	ax
		push	bx
		push	cs
		call	near ptr sub_1421E
		add	sp, 8
		pop	ds
		pop	si
		pop	bx
		pop	ax
		pop	bp
		retf
sub_142DC	endp


; =============== S U B	R O U T	I N E =======================================


sub_1430F	proc far		; CODE XREF: RestoreIntVec24+4FP
		push	ax
		mov	ah, 41h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		pop	ax
		retf
sub_1430F	endp


; =============== S U B	R O U T	I N E =======================================


sub_14316	proc far		; CODE XREF: sub_1431D+4Ep
		push	ax
		mov	ah, 40h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		pop	ax
		retf
sub_14316	endp


; =============== S U B	R O U T	I N E =======================================


sub_1431D	proc far		; CODE XREF: sub_12FB3+C9P
		push	ax
		push	ds
		mov	ax, seg	dseg
		mov	ds, ax
		in	al, 31h
		not	al
		shr	al, 1
		and	al, 40h
		mov	byte_21EB2, al
		push	7D0h
		push	0
		push	cs
		call	near ptr sub_14375
		add	sp, 4
		push	0
		push	cs
		call	near ptr sub_13ECE
		add	sp, 2
		xor	ax, ax
		mov	ds, ax
		assume ds:nothing
		or	byte ptr ds:500h, 20h
		mov	ax, 1
		out	6Ah, al
		mov	ch, 0C0h
		mov	ah, 42h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		push	0
		push	cs
		call	near ptr WritePortA6
		add	sp, 2
		push	0
		push	cs
		call	near ptr WritePortA4
		add	sp, 2
		push	cs
		call	near ptr sub_14316
		mov	al, 0Bh
		out	68h, al
		pop	ds
		assume ds:dseg
		pop	ax
		retf
sub_1431D	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_14375	proc far		; CODE XREF: sub_12FB3+D3P
					; sub_12FB3+E0P ...

arg_0		= word ptr  6
arg_2		= word ptr  8

		push	bp
		mov	bp, sp
		push	ax
		push	bx
		push	cx
		push	si
		push	ds
		mov	si, [bp+arg_0]
		shl	si, 3
		mov	ax, cs
		mov	ds, ax
		assume ds:seg005
		add	si, offset byte_13EAE
		mov	cx, [bp+arg_2]
		mov	bx, cx
		mov	ah, 48h
		int	21h		; DOS -	2+ - ALLOCATE MEMORY
					; BX = number of 16-byte paragraphs desired
		mov	[si], ax
		mov	bx, cx
		mov	ah, 48h
		int	21h		; DOS -	2+ - ALLOCATE MEMORY
					; BX = number of 16-byte paragraphs desired
		mov	[si+2],	ax
		mov	bx, cx
		mov	ah, 48h
		int	21h		; DOS -	2+ - ALLOCATE MEMORY
					; BX = number of 16-byte paragraphs desired
		mov	[si+4],	ax
		mov	bx, cx
		mov	ah, 48h
		int	21h		; DOS -	2+ - ALLOCATE MEMORY
					; BX = number of 16-byte paragraphs desired
		mov	[si+6],	ax
		pop	ds
		assume ds:dseg
		pop	si
		pop	cx
		pop	bx
		pop	ax
		pop	bp
		retf
sub_14375	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

ImageCopy1	proc far		; CODE XREF: seg007:7317P seg007:7337P ...

arg_0		= word ptr  6
arg_2		= word ptr  8
arg_4		= word ptr  0Ah
arg_6		= word ptr  0Ch
arg_8		= word ptr  0Eh

		push	bp
		mov	bp, sp
		pusha
		push	ds
		push	es
		mov	ax, [bp+arg_8]
		push	ax
		call	ImageCopySetup
		add	sp, 2
		mov	bx, [bp+arg_0]
		mov	dx, [bp+arg_6]
		mov	cx, [bp+arg_4]
		mov	ax, [bp+arg_2]
		shr	ax, 3
		test	ax, 1
		jz	short loc_14430

loc_143DC:				; CODE XREF: ImageCopy1+74j
		push	cx
		mov	ds, cs:word_13E9E
		assume ds:nothing
		mov	si, bx
		mov	es, cs:word_13EA6
		assume es:nothing
		mov	di, dx
		mov	cx, ax
		rep movsb
		mov	ds, cs:word_13EA0
		mov	si, bx
		mov	es, cs:word_13EA8
		mov	di, dx
		mov	cx, ax
		rep movsb
		mov	ds, cs:word_13EA2
		mov	si, bx
		mov	es, cs:word_13EAA
		mov	di, dx
		mov	cx, ax
		rep movsb
		mov	ds, cs:word_13EA4
		mov	si, bx
		mov	es, cs:word_13EAC
		mov	di, dx
		mov	cx, ax
		rep movsb
		add	bx, 50h
		add	dx, 50h
		pop	cx
		loop	loc_143DC
		jmp	short loc_14484
; ---------------------------------------------------------------------------

loc_14430:				; CODE XREF: ImageCopy1+22j
		shr	ax, 1

loc_14432:				; CODE XREF: ImageCopy1+CAj
		push	cx
		mov	ds, cs:word_13E9E
		mov	si, bx
		mov	es, cs:word_13EA6
		mov	di, dx
		mov	cx, ax
		rep movsw
		mov	ds, cs:word_13EA0
		mov	si, bx
		mov	es, cs:word_13EA8
		mov	di, dx
		mov	cx, ax
		rep movsw
		mov	ds, cs:word_13EA2
		mov	si, bx
		mov	es, cs:word_13EAA
		mov	di, dx
		mov	cx, ax
		rep movsw
		mov	ds, cs:word_13EA4
		mov	si, bx
		mov	es, cs:word_13EAC
		mov	di, dx
		mov	cx, ax
		rep movsw
		add	bx, 50h
		add	dx, 50h
		pop	cx
		loop	loc_14432

loc_14484:				; CODE XREF: ImageCopy1+76j
		pop	es
		assume es:nothing
		pop	ds
		assume ds:dseg
		popa
		pop	bp
		retf
ImageCopy1	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

ImageCopy2	proc far		; CODE XREF: seg007:7425P seg007:8AC4P

arg_0		= word ptr  6
arg_2		= word ptr  8
arg_4		= word ptr  0Ah
arg_6		= word ptr  0Ch
arg_8		= word ptr  0Eh

		push	bp
		mov	bp, sp
		pusha
		push	ds
		push	es
		shr	[bp+arg_2], 4
		shr	[bp+arg_4], 4
		mov	bx, offset word_13DAE
		mov	ax, [bp+arg_8]
		mov	cs:word_13D56, ax
		mov	cs:word_13D58, 0
		and	ax, 0Fh
		shl	ax, 6
		add	bx, ax
		push	2
		call	ImageCopySetup
		add	sp, 2

loc_144B8:				; CODE XREF: ImageCopy2+145j
		mov	dx, cs:[bx]
		mov	si, [bp+arg_0]
		mov	di, [bp+arg_6]
		mov	cx, [bp+arg_4]

loc_144C4:				; CODE XREF: ImageCopy2+3Fj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_144C4

loc_144CA:				; CODE XREF: ImageCopy2+45j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_144CA

loc_144D0:				; CODE XREF: ImageCopy2+4Bj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_144D0

loc_144D6:				; CODE XREF: ImageCopy2+51j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_144D6

loc_144DC:				; CODE XREF: ImageCopy2+57j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_144DC

loc_144E2:				; CODE XREF: ImageCopy2+5Dj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_144E2

loc_144E8:				; CODE XREF: ImageCopy2+B8j
		push	cx
		mov	cx, [bp+arg_2]
		push	si
		push	di
		add	si, dx
		add	di, dx

loc_144F2:				; CODE XREF: ImageCopy2+ABj
		mov	ds, cs:word_13E9E
		assume ds:nothing
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		mov	al, [si]
		mov	es:[di], al
		mov	ds, cs:word_13EA0
		mov	ax, 0B000h
		mov	es, ax
		assume es:nothing
		mov	al, [si]
		mov	es:[di], al
		mov	ds, cs:word_13EA2
		mov	ax, 0B800h
		mov	es, ax
		assume es:nothing
		mov	al, [si]
		mov	es:[di], al
		mov	ds, cs:word_13EA4
		mov	ax, 0E000h
		mov	es, ax
		assume es:nothing
		mov	al, [si]
		mov	es:[di], al
		add	si, 2
		add	di, 2
		loop	loc_144F2
		pop	di
		pop	si
		pop	cx
		add	si, 500h
		add	di, 500h
		loop	loc_144E8
		add	bx, 2
		mov	dx, cs:[bx]
		mov	si, [bp+arg_0]
		mov	di, [bp+arg_6]
		mov	cx, [bp+arg_4]

loc_14552:				; CODE XREF: ImageCopy2+122j
		push	cx
		mov	cx, [bp+arg_2]
		push	si
		push	di
		add	si, dx
		add	di, dx

loc_1455C:				; CODE XREF: ImageCopy2+115j
		mov	ds, cs:word_13E9E
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		mov	al, [si]
		mov	es:[di], al
		mov	ds, cs:word_13EA0
		mov	ax, 0B000h
		mov	es, ax
		assume es:nothing
		mov	al, [si]
		mov	es:[di], al
		mov	ds, cs:word_13EA2
		mov	ax, 0B800h
		mov	es, ax
		assume es:nothing
		mov	al, [si]
		mov	es:[di], al
		mov	ds, cs:word_13EA4
		mov	ax, 0E000h
		mov	es, ax
		assume es:nothing
		mov	al, [si]
		mov	es:[di], al
		add	si, 2
		add	di, 2
		loop	loc_1455C
		pop	di
		pop	si
		pop	cx
		add	si, 500h
		add	di, 500h
		loop	loc_14552
		test	cs:word_13D56, 10h
		jz	short loc_145C7
		mov	ax, cs:word_13D58
		push	ax
		push	cs
		call	near ptr sub_142DC
		add	sp, 2
		inc	ax
		mov	cs:word_13D58, ax

loc_145C7:				; CODE XREF: ImageCopy2+12Bj
		or	dx, dx
		jz	short loc_145D1
		add	bx, 2
		jmp	loc_144B8
; ---------------------------------------------------------------------------

loc_145D1:				; CODE XREF: ImageCopy2+140j
		pop	es
		assume es:nothing
		pop	ds
		assume ds:dseg
		popa
		pop	bp
		retf
ImageCopy2	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

ImageCopy3	proc far		; CODE XREF: seg007:74CDP seg007:7BCDP ...

arg_0		= word ptr  6
arg_2		= word ptr  8
arg_4		= word ptr  0Ah
arg_6		= word ptr  0Ch
arg_8		= word ptr  0Eh

		push	bp
		mov	bp, sp
		pusha
		push	ds
		push	es
		mov	ax, [bp+arg_8]
		push	ax
		call	ImageCopySetup
		add	sp, 2
		shr	ax, 4
		mov	es, ax
		mov	si, [bp+arg_0]
		mov	di, [bp+arg_6]
		mov	cx, [bp+arg_4]
		mov	dx, [bp+arg_2]
		shr	dx, 3
		test	dx, 1
		jnz	short loc_14603
		jmp	loc_146CE
; ---------------------------------------------------------------------------

loc_14603:				; CODE XREF: ImageCopy3+28j
					; ImageCopy3+F2j
		push	cx
		push	si
		push	di
		mov	cl, dl

loc_14608:				; CODE XREF: ImageCopy3+E3j
		push	cx
		mov	ds, cs:word_13E9E
		assume ds:nothing
		mov	ah, [si]
		mov	ds, cs:word_13EA0
		mov	bl, [si]
		mov	ds, cs:word_13EA2
		mov	bh, [si]
		mov	ds, cs:word_13EA4
		mov	dh, [si]
		mov	cx, es
		not	ch
		test	cl, 1
		jz	short loc_14630
		and	ch, ah

loc_14630:				; CODE XREF: ImageCopy3+56j
		test	cl, 2
		jz	short loc_14637
		and	ch, bl

loc_14637:				; CODE XREF: ImageCopy3+5Dj
		test	cl, 4
		jz	short loc_1463E
		and	ch, bh

loc_1463E:				; CODE XREF: ImageCopy3+64j
		test	cl, 8
		jz	short loc_14645
		and	ch, dh

loc_14645:				; CODE XREF: ImageCopy3+6Bj
		test	cl, 1
		jnz	short loc_14650
		mov	al, ah
		not	al
		and	ch, al

loc_14650:				; CODE XREF: ImageCopy3+72j
		test	cl, 2
		jnz	short loc_1465B
		mov	al, bl
		not	al
		and	ch, al

loc_1465B:				; CODE XREF: ImageCopy3+7Dj
		test	cl, 4
		jnz	short loc_14666
		mov	al, bh
		not	al
		and	ch, al

loc_14666:				; CODE XREF: ImageCopy3+88j
		test	cl, 8
		jnz	short loc_14671
		mov	al, dh
		not	al
		and	ch, al

loc_14671:				; CODE XREF: ImageCopy3+93j
		not	ch
		and	ah, ch
		and	bl, ch
		and	bh, ch
		and	dh, ch
		not	ch
		mov	ds, cs:word_13EA6
		mov	al, [di]
		and	al, ch
		or	al, ah
		mov	[di], al
		mov	ds, cs:word_13EA8
		mov	al, [di]
		and	al, ch
		or	al, bl
		mov	[di], al
		mov	ds, cs:word_13EAA
		mov	al, [di]
		and	al, ch
		or	al, bh
		mov	[di], al
		mov	ds, cs:word_13EAC
		mov	al, [di]
		and	al, ch
		or	al, dh
		mov	[di], al
		inc	si
		inc	di
		pop	cx
		xor	ch, ch
		dec	cx
		jz	short loc_146BC
		jmp	loc_14608
; ---------------------------------------------------------------------------

loc_146BC:				; CODE XREF: ImageCopy3+E1j
		pop	di
		pop	si
		pop	cx
		add	di, 50h
		add	si, 50h
		dec	cx
		jz	short loc_146CB
		jmp	loc_14603
; ---------------------------------------------------------------------------

loc_146CB:				; CODE XREF: ImageCopy3+F0j
		jmp	loc_147CB
; ---------------------------------------------------------------------------

loc_146CE:				; CODE XREF: ImageCopy3+2Aj
		shr	dx, 1

loc_146D0:				; CODE XREF: ImageCopy3+1F2j
		push	cx
		push	si
		push	di
		mov	cx, dx

loc_146D5:				; CODE XREF: ImageCopy3+1E3j
		push	cx
		mov	cx, es
		mov	bx, 0FFFFh
		mov	ds, cs:word_13E9E
		mov	ax, [si]
		mov	cs:word_13D56, ax
		test	cl, 1
		jz	short loc_146ED
		and	bx, ax

loc_146ED:				; CODE XREF: ImageCopy3+113j
		mov	ds, cs:word_13EA0
		mov	ax, [si]
		mov	cs:word_13D58, ax
		test	cl, 2
		jz	short loc_146FF
		and	bx, ax

loc_146FF:				; CODE XREF: ImageCopy3+125j
		mov	ds, cs:word_13EA2
		mov	ax, [si]
		mov	cs:word_13D5A, ax
		test	cl, 4
		jz	short loc_14711
		and	bx, ax

loc_14711:				; CODE XREF: ImageCopy3+137j
		mov	ds, cs:word_13EA4
		mov	ax, [si]
		mov	cs:word_13D5C, ax
		test	cl, 8
		jz	short loc_14723
		and	bx, ax

loc_14723:				; CODE XREF: ImageCopy3+149j
		test	cl, 1
		jnz	short loc_14730
		mov	ax, cs:word_13D56
		not	ax
		and	bx, ax

loc_14730:				; CODE XREF: ImageCopy3+150j
		test	cl, 2
		jnz	short loc_1473D
		mov	ax, cs:word_13D58
		not	ax
		and	bx, ax

loc_1473D:				; CODE XREF: ImageCopy3+15Dj
		test	cl, 4
		jnz	short loc_1474A
		mov	ax, cs:word_13D5A
		not	ax
		and	bx, ax

loc_1474A:				; CODE XREF: ImageCopy3+16Aj
		test	cl, 8
		jnz	short loc_14757
		mov	ax, cs:word_13D5C
		not	ax
		and	bx, ax

loc_14757:				; CODE XREF: ImageCopy3+177j
		not	bx
		and	cs:word_13D56, bx
		and	cs:word_13D58, bx
		and	cs:word_13D5A, bx
		and	cs:word_13D5C, bx
		not	bx
		mov	ds, cs:word_13EA6
		mov	ax, [di]
		and	ax, bx
		or	ax, cs:word_13D56
		mov	[di], ax
		mov	ds, cs:word_13EA8
		mov	ax, [di]
		and	ax, bx
		or	ax, cs:word_13D58
		mov	[di], ax
		mov	ds, cs:word_13EAA
		mov	ax, [di]
		and	ax, bx
		or	ax, cs:word_13D5A
		mov	[di], ax
		mov	ds, cs:word_13EAC
		mov	ax, [di]
		and	ax, bx
		or	ax, cs:word_13D5C
		mov	[di], ax
		add	si, 2
		add	di, 2
		pop	cx
		dec	cx
		jz	short loc_147BC
		jmp	loc_146D5
; ---------------------------------------------------------------------------

loc_147BC:				; CODE XREF: ImageCopy3+1E1j
		pop	di
		pop	si
		pop	cx
		add	di, 50h
		add	si, 50h
		dec	cx
		jz	short loc_147CB
		jmp	loc_146D0
; ---------------------------------------------------------------------------

loc_147CB:				; CODE XREF: ImageCopy3:loc_146CBj
					; ImageCopy3+1F0j
		pop	es
		pop	ds
		assume ds:dseg
		popa
		pop	bp
		retf
ImageCopy3	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_147D0	proc far		; CODE XREF: seg007:88E6P seg007:8911P ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		pusha
		mov	word_21EE5, 0
		mov	byte_21EE7, 0
		mov	word_21EE8, 190h
		mov	word_21EEA, 0
		mov	byte_21EEC, 0
		mov	word_21EED, 0
		mov	word_21EEF, 0
		mov	ax, [bp+arg_0]
		or	ax, ax
		js	short loc_1482C
		push	ax
		mov	dx, 28h
		mul	dx
		add	word_21EE5, ax
		pop	ax
		add	word_21EED, ax
		sub	word_21EE8, ax
		ja	short loc_14855
		sub	word_21EED, 190h
		sub	word_21EE5, 3E80h
		add	word_21EE8, 190h
		jmp	short loc_14855
; ---------------------------------------------------------------------------

loc_1482C:				; CODE XREF: sub_147D0+31j
		neg	ax
		push	ax
		mov	dx, 28h
		mul	dx
		sub	word_21EE5, ax
		pop	ax
		add	word_21EE8, ax
		sub	word_21EED, ax
		jnb	short loc_14855
		add	word_21EED, 190h
		add	word_21EE5, 3E80h
		sub	word_21EE8, 190h

loc_14855:				; CODE XREF: sub_147D0+46j
					; sub_147D0+5Aj ...
		mov	ax, word_21EE5
		add	ax, ax
		mov	word_21EEF, ax
		sub	bx, bx
		mov	cx, 4
		mov	si, offset word_21EE5
		lodsb
		call	sub_148CA
		inc	bx
		lodsb
		call	sub_148CA
		inc	bx
		lodsb
		mov	ah, al
		lodsb
		mov	dl, al
		shl	al, cl
		shr	dl, cl
		or	al, ah
		call	sub_148CA
		inc	bx
		lodsb
		shl	al, cl
		or	al, dl
		push	bx
		push	ds
		mov	bx, seg	dseg
		mov	ds, bx
		or	al, byte_21EB2
		pop	ds
		pop	bx
		call	sub_148CA
		inc	bx
		lodsb
		call	sub_148CA
		inc	bx
		lodsb
		call	sub_148CA
		inc	bx
		lodsb
		mov	ah, al
		lodsb
		mov	dl, al
		shl	al, cl
		shr	dl, cl
		or	al, ah
		call	sub_148CA
		inc	bx
		lodsb
		shl	al, cl
		or	al, dl
		push	bx
		push	ds
		mov	bx, seg	dseg
		mov	ds, bx
		or	al, byte_21EB2
		pop	ds
		pop	bx
		call	sub_148CA
		call	sub_148CA
		popa
		pop	bp
		retf
sub_147D0	endp


; =============== S U B	R O U T	I N E =======================================


sub_148CA	proc near		; CODE XREF: sub_147D0+96p
					; sub_147D0+9Bp ...
		push	ax
		mov	al, 70h
		or	al, bl
		out	0A2h, al	; Interrupt Controller #2, 8259A
		pop	ax
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1
		retn
sub_148CA	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

ImageCopySetup	proc near		; CODE XREF: sub_1416A+8p
					; ImageCopy1+Ap ...

arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		pusha
		push	ds
		push	es
		mov	bx, [bp+arg_0]
		mov	ax, cs
		mov	es, ax
		assume es:seg005
		mov	di, offset byte_1DE2E
		test	bx, 2
		jz	short loc_148F5
		mov	ax, seg	dseg
		mov	ds, ax
		mov	si, offset word_21EAA
		jmp	short loc_148FA
; ---------------------------------------------------------------------------

loc_148F5:				; CODE XREF: ImageCopySetup+14j
		mov	ds, ax
		mov	si, offset word_1DD36

loc_148FA:				; CODE XREF: ImageCopySetup+1Ej
		mov	cx, 4
		rep movsw
		test	bx, 1
		jz	short loc_1490F
		mov	ax, seg	dseg
		mov	ds, ax
		mov	si, offset word_21EAA
		jmp	short loc_14916
; ---------------------------------------------------------------------------

loc_1490F:				; CODE XREF: ImageCopySetup+2Ej
		mov	ax, cs
		mov	ds, ax
		assume ds:seg005
		mov	si, offset word_13DA6

loc_14916:				; CODE XREF: ImageCopySetup+38j
		mov	cx, 4
		rep movsw
		pop	es
		assume es:nothing
		pop	ds
		assume ds:dseg
		popa
		pop	bp
		retn
ImageCopySetup	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_14920	proc far		; CODE XREF: sub_12FB3+107P
					; sub_140FA+26p ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	ax
		push	bx
		push	cx
		push	dx
		push	si
		push	ds
		mov	ax, seg	dseg
		mov	ds, ax
		mov	ax, [bp+arg_0]
		mov	word_21EE3, ax
		mov	ax, seg	dseg
		mov	ds, ax
		mov	si, offset byte_21EB3
		mov	cx, 10h
		xor	bx, bx
		xor	dh, dh

loc_14943:				; CODE XREF: sub_14920+3Aj
		mov	dl, [si+2]
		push	dx
		mov	dl, [si+1]
		push	dx
		mov	dl, [si]
		add	si, 3
		push	dx
		push	bx
		push	cs
		call	near ptr sub_1421E
		add	sp, 8
		inc	bx
		loop	loc_14943
		pop	ds
		pop	si
		pop	dx
		pop	cx
		pop	bx
		pop	ax
		pop	bp
		retf
sub_14920	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

WritePortA4	proc far		; CODE XREF: sub_1431D+47p
					; seg007:7B96P	...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	ax
		mov	ax, [bp+arg_0]
		out	0A4h, al	; Interrupt Controller #2, 8259A
		pop	ax
		pop	bp
		retf
WritePortA4	endp

seg005		ends

; ===========================================================================

; Segment type:	Pure code
seg006		segment	byte public 'CODE' use16
		assume cs:seg006
		assume es:nothing, ss:nothing, ds:dseg,	fs:nothing, gs:nothing
byte_14970	db 2 dup(0)		; DATA XREF: seg006:0154r
					; seg006:loc_14BE0w ...
byte_14972	db 0			; DATA XREF: SetupIntVec09+20w
					; seg006:0143r	...
OldVecInt09	dd 0			; DATA XREF: RestoreIntVec09+9r
					; SetupIntVec09+9w ...

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_14977	proc far		; CODE XREF: sub_1499B+28p
					; sub_1499B+3Ap ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	bx
		push	cx
		mov	ax, [bp+arg_0]
		mov	ah, 4
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		mov	bl, ah
		mov	cx, 400h

loc_14988:				; CODE XREF: sub_14977+13j
		out	5Fh, al
		loop	loc_14988
		mov	ax, [bp+arg_0]
		mov	ah, 4
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		or	ah, bl
		mov	al, ah
		pop	cx
		pop	bx
		pop	bp
		retf
sub_14977	endp


; =============== S U B	R O U T	I N E =======================================


sub_1499B	proc far		; CODE XREF: seg007:loc_1C9F4P
					; seg007:loc_1CB03P ...
		push	ds
		mov	ax, seg	dseg
		mov	ds, ax
		test	MiscFlags, 10h
		jnz	short loc_149AD
		xor	ax, ax
		jmp	short loc_149B8
; ---------------------------------------------------------------------------

loc_149AD:				; CODE XREF: sub_1499B+Cj
		mov	ah, 16h		; routine 16h -	read joystick
		int	60h		; call PMD driver
		not	ax
		or	al, ah
		and	ax, 3Fh

loc_149B8:				; CODE XREF: sub_1499B+10j
		cli
		or	ah, cs:byte_14970+1
		mov	bx, ax
		push	0
		push	cs
		call	near ptr sub_14977
		add	sp, 2
		test	ax, 1
		jz	short loc_149D2
		or	bx, 80h

loc_149D2:				; CODE XREF: sub_1499B+31j
		push	3
		push	cs
		call	near ptr sub_14977
		add	sp, 2
		test	ax, 10h
		jz	short loc_149E3
		or	bx, 10h

loc_149E3:				; CODE XREF: sub_1499B+43j
		push	6
		push	cs
		call	near ptr sub_14977
		add	sp, 2
		test	ax, 10h
		jz	short loc_149F4
		or	bx, 20h

loc_149F4:				; CODE XREF: sub_1499B+54j
		push	7
		push	cs
		call	near ptr sub_14977
		add	sp, 2
		test	ax, 4
		jz	short loc_14A05
		or	bx, 1

loc_14A05:				; CODE XREF: sub_1499B+65j
		test	ax, 20h
		jz	short loc_14A0D
		or	bx, 2

loc_14A0D:				; CODE XREF: sub_1499B+6Dj
		test	ax, 8
		jz	short loc_14A15
		or	bx, 4

loc_14A15:				; CODE XREF: sub_1499B+75j
		test	ax, 10h
		jz	short loc_14A1D
		or	bx, 8

loc_14A1D:				; CODE XREF: sub_1499B+7Dj
		push	8
		push	cs
		call	near ptr sub_14977
		add	sp, 2
		test	ax, 8
		jz	short loc_14A2E
		or	bx, 1

loc_14A2E:				; CODE XREF: sub_1499B+8Ej
		test	ax, 40h
		jz	short loc_14A36
		or	bx, 4

loc_14A36:				; CODE XREF: sub_1499B+96j
		push	9
		push	cs
		call	near ptr sub_14977
		add	sp, 2
		test	ax, 40h
		jz	short loc_14A47
		or	bx, 20h

loc_14A47:				; CODE XREF: sub_1499B+A7j
		test	ax, 8
		jz	short loc_14A4F
		or	bx, 2

loc_14A4F:				; CODE XREF: sub_1499B+AFj
		test	ax, 1
		jz	short loc_14A57
		or	bx, 8

loc_14A57:				; CODE XREF: sub_1499B+B7j
		push	0Eh
		push	cs
		call	near ptr sub_14977
		add	sp, 2
		test	ax, 1
		jz	short loc_14A68
		or	bx, 40h

loc_14A68:				; CODE XREF: sub_1499B+C8j
		mov	ax, bx
		sti
		pop	ds
		retf
sub_1499B	endp


; =============== S U B	R O U T	I N E =======================================


RestoreIntVec09	proc far		; CODE XREF: sub_12FB3+11DP
		push	ax
		push	ds
		cli
		mov	ax, word ptr cs:OldVecInt09+2
		mov	ds, ax
		mov	dx, word ptr cs:OldVecInt09
		mov	al, 9
		mov	ah, 25h
		int	21h		; DOS -	SET INTERRUPT VECTOR
					; AL = interrupt number
					; DS:DX	= new vector to	be used	for specified interrupt
		sti
		pop	ds
		pop	ax
		retf
RestoreIntVec09	endp


; =============== S U B	R O U T	I N E =======================================


SetupIntVec09	proc far		; CODE XREF: sub_12FB3+10FP
		push	ax
		push	ds
		cli
		mov	al, 9
		mov	ah, 35h
		int	21h		; DOS -	2+ - GET INTERRUPT VECTOR
					; AL = interrupt number
					; Return: ES:BX	= value	of interrupt vector
		mov	word ptr cs:OldVecInt09, bx
		mov	word ptr cs:OldVecInt09+2, es
		mov	ax, cs
		mov	ds, ax
		assume ds:seg006
		mov	dx, offset Int09
		mov	al, 9
		mov	ah, 25h
		int	21h		; DOS -	SET INTERRUPT VECTOR
					; AL = interrupt number
					; DS:DX	= new vector to	be used	for specified interrupt
		mov	cs:byte_14972, 0
		sti
		pop	ds
		assume ds:dseg
		pop	ax
		retf
SetupIntVec09	endp

; ---------------------------------------------------------------------------

Int09:					; DATA XREF: SetupIntVec09+17o
		pushf
		pusha
		push	ds
		push	es
		cmp	cs:byte_14972, 1
		jnz	short loc_14ABE
		jmp	loc_14BF0
; ---------------------------------------------------------------------------

loc_14ABE:				; CODE XREF: seg006:0149j
		mov	cs:byte_14972, 1
		mov	dl, cs:byte_14970
		mov	dh, cs:byte_14970+1
		in	al, 41h		; Timer	8253-5 (AT: 8254.2).
		test	al, 80h
		jnz	short loc_14AD7
		jmp	loc_14B62
; ---------------------------------------------------------------------------

loc_14AD7:				; CODE XREF: seg006:0162j
		cmp	al, 80h
		jnz	short loc_14AE1
		and	dl, 7Fh
		jmp	loc_14BE0
; ---------------------------------------------------------------------------

loc_14AE1:				; CODE XREF: seg006:0169j
		cmp	al, 0F0h
		jnz	short loc_14AEB
		and	dl, 0BFh
		jmp	loc_14BE0
; ---------------------------------------------------------------------------

loc_14AEB:				; CODE XREF: seg006:0173j
		cmp	al, 0BAh
		jnz	short loc_14AF5

loc_14AEF:				; CODE XREF: seg006:0187j
		and	dl, 0FEh
		jmp	loc_14BE0
; ---------------------------------------------------------------------------

loc_14AF5:				; CODE XREF: seg006:017Dj
		cmp	al, 0C3h
		jz	short loc_14AEF
		cmp	al, 0BDh
		jnz	short loc_14B03

loc_14AFD:				; CODE XREF: seg006:0195j
		and	dl, 0FDh
		jmp	loc_14BE0
; ---------------------------------------------------------------------------

loc_14B03:				; CODE XREF: seg006:018Bj
		cmp	al, 0CBh
		jz	short loc_14AFD
		cmp	al, 0BBh
		jnz	short loc_14B11

loc_14B0B:				; CODE XREF: seg006:01A3j
		and	dl, 0FBh
		jmp	loc_14BE0
; ---------------------------------------------------------------------------

loc_14B11:				; CODE XREF: seg006:0199j
		cmp	al, 0C6h
		jz	short loc_14B0B
		cmp	al, 0BCh
		jnz	short loc_14B1F

loc_14B19:				; CODE XREF: seg006:01B1j
		and	dl, 0F7h
		jmp	loc_14BE0
; ---------------------------------------------------------------------------

loc_14B1F:				; CODE XREF: seg006:01A7j
		cmp	al, 0C8h
		jz	short loc_14B19
		cmp	al, 9Ch
		jnz	short loc_14B2D
		and	dl, 0EFh
		jmp	loc_14BE0
; ---------------------------------------------------------------------------

loc_14B2D:				; CODE XREF: seg006:01B5j
		cmp	al, 0CEh
		jnz	short loc_14B37

loc_14B31:				; CODE XREF: seg006:01C9j
		and	dl, 0DFh
		jmp	loc_14BE0
; ---------------------------------------------------------------------------

loc_14B37:				; CODE XREF: seg006:01BFj
		cmp	al, 0B4h
		jz	short loc_14B31
		cmp	al, 0E2h
		jnz	short loc_14B45
		and	dh, 0FEh
		jmp	loc_14BE0
; ---------------------------------------------------------------------------

loc_14B45:				; CODE XREF: seg006:01CDj
		cmp	al, 0E3h
		jnz	short loc_14B4F
		and	dh, 0FDh
		jmp	loc_14BE0
; ---------------------------------------------------------------------------

loc_14B4F:				; CODE XREF: seg006:01D7j
		cmp	al, 0E4h
		jnz	short loc_14B59
		and	dh, 0FBh
		jmp	loc_14BE0
; ---------------------------------------------------------------------------

loc_14B59:				; CODE XREF: seg006:01E1j
		cmp	al, 0E5h
		jnz	short loc_14B60
		and	dh, 0F7h

loc_14B60:				; CODE XREF: seg006:01EBj
		jmp	short loc_14BE0
; ---------------------------------------------------------------------------

loc_14B62:				; CODE XREF: seg006:0164j
		or	al, al
		jnz	short loc_14B6B
		or	dl, 80h
		jmp	short loc_14BE0
; ---------------------------------------------------------------------------

loc_14B6B:				; CODE XREF: seg006:01F4j
		cmp	al, 70h
		jnz	short loc_14B74
		or	dl, 40h
		jmp	short loc_14BE0
; ---------------------------------------------------------------------------

loc_14B74:				; CODE XREF: seg006:01FDj
		cmp	al, 3Ah
		jnz	short loc_14B7D

loc_14B78:				; CODE XREF: seg006:020Fj
		or	dl, 1
		jmp	short loc_14BE0
; ---------------------------------------------------------------------------

loc_14B7D:				; CODE XREF: seg006:0206j
		cmp	al, 43h
		jz	short loc_14B78
		cmp	al, 3Dh
		jnz	short loc_14B8A

loc_14B85:				; CODE XREF: seg006:021Cj
		or	dl, 2
		jmp	short loc_14BE0
; ---------------------------------------------------------------------------

loc_14B8A:				; CODE XREF: seg006:0213j
		cmp	al, 4Bh
		jz	short loc_14B85
		cmp	al, 3Bh
		jnz	short loc_14B97

loc_14B92:				; CODE XREF: seg006:0229j
		or	dl, 4
		jmp	short loc_14BE0
; ---------------------------------------------------------------------------

loc_14B97:				; CODE XREF: seg006:0220j
		cmp	al, 46h
		jz	short loc_14B92
		cmp	al, 3Ch
		jnz	short loc_14BA4

loc_14B9F:				; CODE XREF: seg006:0236j
		or	dl, 8
		jmp	short loc_14BE0
; ---------------------------------------------------------------------------

loc_14BA4:				; CODE XREF: seg006:022Dj
		cmp	al, 48h
		jz	short loc_14B9F
		cmp	al, 1Ch
		jnz	short loc_14BB1
		or	dl, 10h
		jmp	short loc_14BE0
; ---------------------------------------------------------------------------

loc_14BB1:				; CODE XREF: seg006:023Aj
		cmp	al, 4Eh
		jnz	short loc_14BBA

loc_14BB5:				; CODE XREF: seg006:024Cj
		or	dl, 20h
		jmp	short loc_14BE0
; ---------------------------------------------------------------------------

loc_14BBA:				; CODE XREF: seg006:0243j
		cmp	al, 34h
		jz	short loc_14BB5
		cmp	al, 62h
		jnz	short loc_14BC7
		or	dh, 1
		jmp	short loc_14BE0
; ---------------------------------------------------------------------------

loc_14BC7:				; CODE XREF: seg006:0250j
		cmp	al, 63h
		jnz	short loc_14BD0
		or	dh, 2
		jmp	short loc_14BE0
; ---------------------------------------------------------------------------

loc_14BD0:				; CODE XREF: seg006:0259j
		cmp	al, 64h
		jnz	short loc_14BD9
		or	dh, 4
		jmp	short loc_14BE0
; ---------------------------------------------------------------------------

loc_14BD9:				; CODE XREF: seg006:0262j
		cmp	al, 65h
		jnz	short loc_14BE0
		or	dh, 8

loc_14BE0:				; CODE XREF: seg006:016Ej seg006:0178j ...
		mov	cs:byte_14970, dl
		mov	cs:byte_14970+1, dh
		mov	cs:byte_14972, 0

loc_14BF0:				; CODE XREF: seg006:014Bj
		mov	al, 20h
		out	0, al
		pop	es
		pop	ds
		popa
		popf
		jmp	cs:OldVecInt09
; ---------------------------------------------------------------------------
		push	ds
		pusha
		mov	bx, offset a000	; "000"
		xor	dx, dx
		mov	cx, 1000h
		div	cx
		cmp	ax, 0Ah
		jnb	short loc_14C15
		add	al, '0'

loc_14C10:				; CODE XREF: seg006:02A7j
		mov	cs:[bx], al
		jmp	short loc_14C19
; ---------------------------------------------------------------------------

loc_14C15:				; CODE XREF: seg006:029Cj
		add	al, 'A'-0Ah
		jmp	short loc_14C10
; ---------------------------------------------------------------------------

loc_14C19:				; CODE XREF: seg006:02A3j
		mov	ax, dx
		xor	dx, dx
		mov	cx, 100h
		div	cx
		cmp	ax, 0Ah
		jnb	short loc_14C2F
		add	al, '0'

loc_14C29:				; CODE XREF: seg006:02C1j
		mov	cs:[bx+1], al
		jmp	short loc_14C33
; ---------------------------------------------------------------------------

loc_14C2F:				; CODE XREF: seg006:02B5j
		add	al, 'A'-0Ah
		jmp	short loc_14C29
; ---------------------------------------------------------------------------

loc_14C33:				; CODE XREF: seg006:02BDj
		mov	ax, dx
		xor	dx, dx
		mov	cx, 10h
		div	cx
		cmp	ax, 0Ah
		jnb	short loc_14C49
		add	al, '0'

loc_14C43:				; CODE XREF: seg006:02DBj
		mov	cs:[bx+2], al
		jmp	short loc_14C4D
; ---------------------------------------------------------------------------

loc_14C49:				; CODE XREF: seg006:02CFj
		add	al, 'A'-0Ah
		jmp	short loc_14C43
; ---------------------------------------------------------------------------

loc_14C4D:				; CODE XREF: seg006:02D7j
		mov	ax, dx
		cmp	ax, 0Ah
		jnb	short loc_14C5C
		add	al, '0'

loc_14C56:				; CODE XREF: seg006:02EEj
		mov	cs:[bx+3], al
		jmp	short loc_14C60
; ---------------------------------------------------------------------------

loc_14C5C:				; CODE XREF: seg006:02E2j
		add	al, 'A'-0Ah
		jmp	short loc_14C56
; ---------------------------------------------------------------------------

loc_14C60:				; CODE XREF: seg006:02EAj
		mov	ax, cs
		mov	ds, ax
		assume ds:seg006
		mov	dx, bx
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		popa
		pop	ds
		assume ds:dseg
		retn
; ---------------------------------------------------------------------------
a000		db '000'                ; DATA XREF: seg006:028Fo
seg006		ends

; ===========================================================================

; Segment type:	Pure code
seg007		segment	byte public 'CODE' use16
		assume cs:seg007
		assume es:nothing, ss:nothing, ds:dseg,	fs:nothing, gs:nothing
a0		db '0',0Dh,0Ah,'$'
word_14C74	dw 0			; DATA XREF: seg007:8F55r
		db 0A0h	dup(0)
scrJumpTbl	dw offset scr00_TalkDungeon; 0 ; DATA XREF: LoadScript+85o
		dw offset scr01_BGMLoad	; 1
		dw offset scr02_TalkFullScr; 2
		dw offset scr03_NextScript; 3
		dw offset scr04_TextColor; 4
		dw offset scr05_PortA6	; 5
		dw offset scr06_Wait	; 6
		dw offset scr07_VarSetVal; 7
		dw offset scr08_VarSetVar; 8
		dw offset scr09_VarAddVal; 9
		dw offset scr0A_VarAddVar; 0Ah
		dw offset scr0B_VarSubVal; 0Bh
		dw offset scr0C_VarSubVar; 0Ch
		dw offset scr0D_ImgCopy1Val; 0Dh
		dw offset scr0E_ImgCopy2Val; 0Eh
		dw offset scr0F		; 0Fh
		dw offset scr10_VarBitClear; 10h
		dw offset scr11_VarBitSet; 11h
		dw offset scr12_VarsSetVal; 12h
		dw offset scr13_GoSub	; 13h
		dw offset scr14_Return	; 14h
		dw offset scr15_Jump	; 15h
		dw offset scr16_JEQ	; 16h
		dw offset scr17_JGT	; 17h
		dw offset scr18_JLT	; 18h
		dw offset scr1A_LoadGTA	; 19h
		dw offset scr1A_LoadGTA	; 1Ah
		dw offset scr1B_ImgFXVal; 1Bh
		dw offset scr1C_SetNextScript; 1Ch
		dw offset scr1D_ShowMenu; 1Dh
		dw offset scr1E_Quit	; 1Eh
		dw offset scr1F		; 1Fh
		dw offset scr20		; 20h
		dw offset scr21_LoadSaveGame; 21h
		dw offset scr22		; 22h
		dw offset scr23		; 23h
		dw offset scr24_ReadMap	; 24h
		dw offset scr25_VarBitTest; 25h
		dw offset scr26_ImgCopy3Val; 26h
		dw offset scr27_DoInput	; 27h
		dw offset scr28		; 28h
		dw offset scr29		; 29h
		dw offset scr2A		; 2Ah
		dw offset scr2B_BGMPlay	; 2Bh
		dw offset scr2C_BGMFadeWait; 2Ch
		dw offset scr2D		; 2Dh
		dw offset scr2E_WriteMap; 2Eh
		dw offset scr2F_DrawMap	; 2Fh
		dw offset scr30_PrintSJIS; 30h
		dw offset scr31		; 31h
		dw offset scr32		; 32h
		dw offset scr33_PlrName_AddChr;	33h
		dw offset scr34_PlrName_DelChr;	34h
		dw offset scr35		; 35h
		dw offset scr36		; 36h
		dw offset scr37		; 37h
		dw offset scr38_WriteSaveGame; 38h
		dw offset scr39_VarRandomVal; 39h
		dw offset scr3A_PrintASCII; 3Ah
		dw offset scr3B_PrintVarStr; 3Bh
		dw offset scr3C_PrintNum_H_5Dig; 3Ch
		dw offset scr3D		; 3Dh
		dw offset scr3E		; 3Eh
		dw offset scr3F_PlaySFX_FM; 3Fh
		dw offset scr40_DiskWait; 40h
		dw offset scr41_ImgCopy4Val; 41h
		dw offset scr42_PrintNum_F_5Dig; 42h
		dw offset scr43_VarMulValDiv100; 43h
		dw offset scr44		; 44h
		dw offset scr45_Print6Var_F; 45h
		dw offset scr46_VarDigitsAdd; 46h
		dw offset scr47_VarDigitsSub; 47h
		dw offset scr48		; 48h
		dw offset scr49_VarDigitsAdd; 49h
		dw offset scr4A_VarDigitsSub; 4Ah
		dw offset scr4B_BGMWaitMeasure;	4Bh
		dw offset scr4C		; 4Ch
		dw offset scr4D		; 4Dh
		dw offset scr4E_VarVarCompare; 4Eh
		dw offset scr4F_MulVarVal; 4Fh
		dw offset scr50_MulVarVar; 50h
		dw offset scr51_DivVarVal; 51h
		dw offset scr52_DivVarVar; 52h
		dw offset scr53_GetItemData; 53h
		dw offset scr54_GetMonsterData;	54h
		dw offset scr55_ImgCopy1Var; 55h
		dw offset scr56_ImgCopy2Var; 56h
		dw offset scr57_ImgFXVar; 57h
		dw offset scr58_ImgCopy3Var; 58h
		dw offset scr59_LoadGTA	; 59h
		dw offset scr5A_VarRandomVar; 5Ah
		dw offset scr5B_GetDiskID; 5Bh
		dw offset scr5C		; 5Ch
		dw offset scr5D_PrintSJIS; 5Dh
		dw offset scr5E_PrintVarStr; 5Eh
		dw offset scr5F		; 5Fh
		dw offset scr60		; 60h
		dw offset scr61_PrintNum_H; 61h
		dw offset scr62_PrintNum_F; 62h
		dw offset scr63_SetDiskLetter; 63h
tempVar0	dw 0			; DATA XREF: seg007:scr00_TalkDungeonw
					; seg007:loc_1BD66r ...
tempVar1	dw 0			; DATA XREF: seg007:7103r seg007:7110w ...
tempVar2	dw 0			; DATA XREF: seg007:7CE0w seg007:7D56r ...
tempVar3	dw 0			; DATA XREF: seg007:7B66w seg007:7BDBr ...
tempVar4	dw 0			; DATA XREF: seg007:7B7Bw seg007:7C19r ...
tempVar5	dw 0			; DATA XREF: seg007:7450w seg007:7CA3r ...
tempVar6	dw 0			; DATA XREF: seg007:7B6Ew seg007:7E6Dr
tempVar7	dw 0			; DATA XREF: seg007:7B83w seg007:7E68r
tempVar8	dw 0			; DATA XREF: seg007:74B1w
					; seg007:loc_1C130r ...
tempVar9	dw 0			; DATA XREF: seg007:7D07w seg007:7D4Fw ...
aZ1010_dat	db 'Z1010.DAT',0        ; DATA XREF: LoadScript+32o
aZ1020_dat	db 'Z1020.DAT',0        ; DATA XREF: LoadScript+67o
aZ1030_dat	db 'Z1030.DAT',0        ; DATA XREF: LoadScript+57o
					; LoadScript:loc_1BD02w
screenSizeX	dw 640			; DATA XREF: seg007:7FC9r
					; seg007:loc_1CC4Ew
screenSizeY	dw 400			; DATA XREF: seg007:7FD0r seg007:7FE3w
bitMask_Clear	dw 0FFFEh,0FFFDh,0FFFBh,0FFF7h ; DATA XREF: seg007:7355o
		dw 0FFEFh,0FFDFh,0FFBFh,0FF7Fh
		dw 0FEFFh,0FDFFh,0FBFFh,0F7FFh
		dw 0EFFFh,0DFFFh,0BFFFh, 7FFFh
bitMask_Set	dw	1,     2,     4,     8 ; DATA XREF: seg007:7368o
					; seg007:7F20o
		dw    10h,   20h,   40h,   80h
		dw   100h,  200h,  400h,  800h
		dw  1000h, 2000h, 4000h, 8000h
ScriptToLoad	db 'A:SCN\Z0000.DAT',0  ; DATA XREF: LoadScript+11o
					; LoadScript+22o ...
		db '$'
aProgrammedByBe	db 'programmed by bez$'
off_14E77	dw offset loc_1DADE, offset loc_1DB46 ;	DATA XREF: seg007:8358o
ScriptMemory	dw 11C6h dup(0)		; DATA XREF: seg007:7100o seg007:7213o ...
CurItemData	dw 12h dup(0)		; DATA XREF: seg007:89E0o
ItemData	db 2A30h dup(0)		; DATA XREF: LoadScript+2Eo
					; seg007:89D1o
MonsterGrpData	dw 87h dup(0)		; DATA XREF: LoadScript+53o
CurMonsterData	db 48h dup(0)		; DATA XREF: seg007:8A07o
MonsterData	db 1B02h dup(0)		; DATA XREF: LoadScript+63o
					; seg007:89F8o
scrCallStack	dw 2			; DATA XREF: seg007:scr13_GoSubo
					; seg007:739Fw	...
		db 10h dup(0)
aGbgcgugvgngogi	db 0Dh,0Ah
		db 0Dh,0Ah
		db 'ÉÅÉCÉìÉvÉçÉOÉâÉÄç≈èIí≤êÆ by TAKAHIRO NOGI. as NOGICHAN. 1995/09/1'
		db '1(Mon.)',0Dh,0Ah
		db 0Dh,0Ah
MapImageRects	dw	0, 0A0Ah	; DATA XREF: seg007:810Eo
		dw	1, 1E04h
		dw	2, 2302h
		dw	3, 2304h
		dw	4, 1E00h
		dw	5, 461Eh
		dw	6, 2300h
		dw	7, 230Ah
		dw	8, 1902h
		dw	9, 1904h
		dw    0Ah, 411Eh
		dw    0Bh, 1E0Ch
		dw    0Ch, 1900h
		dw    0Dh, 190Ah
		dw    0Eh, 1E08h
		dw    0Fh, 1E02h
		dw    10h, 0A04h
		dw    12h, 3702h
		dw    14h, 411Ah
		dw    16h, 371Ah
		dw    18h, 3202h
		dw    1Ah, 3224h
		dw    1Ch, 2D12h
		dw    1Eh, 4108h
		dw    20h, 0F02h
		dw    21h, 4602h
		dw    24h, 4600h
		dw    25h, 3722h
		dw    28h, 4116h
		dw    29h, 3214h
		dw    2Ch, 3218h
		dw    2Dh, 4608h
		dw    30h, 0F04h
		dw    34h, 2312h
		dw    38h, 1E1Ch
		dw    3Ch, 410Ch
		dw    40h, 0A00h
		dw    41h, 461Ah
		dw    42h, 3700h
		dw    43h, 3712h
		dw    48h, 3200h
		dw    49h, 2D1Ah
		dw    4Ah, 3220h
		dw    4Bh, 4606h
		dw    50h, 0A14h
		dw    52h, 2322h
		dw    58h, 1922h
		dw    5Ah, 4112h
		dw    60h, 0F00h
		dw    61h, 231Ah
		dw    68h, 1E10h
		dw    69h, 410Eh
		dw    70h, 0F0Ah
		dw    78h, 3206h
		dw    80h,  502h
		dw    81h, 4102h
		dw    82h, 4616h
		dw    83h, 321Ch
		dw    84h, 4100h
		dw    85h, 2D22h
		dw    86h, 3210h
		dw    87h, 4106h
		dw    90h,  504h
		dw    92h, 1E14h
		dw    94h, 191Ah
		dw    96h, 460Ch
		dw   0A0h, 0A10h
		dw   0A1h, 1E24h
		dw   0A4h, 1E20h
		dw   0A5h, 4612h
		dw   0B0h, 0A0Ch
		dw   0B4h, 3706h
		dw   0C0h,  500h
		dw   0C1h, 1912h
		dw   0C2h, 1E18h
		dw   0C3h, 460Eh
		dw   0D0h,  50Ah
		dw   0D2h, 3708h
		dw   0E0h, 0A08h
		dw   0E1h, 3208h
		dw   0F0h, 0A02h
		dw 0FFFFh
aZ1001_dat	db 'Z1001.DAT',0        ; DATA XREF: seg007:7533o seg007:7888o ...
SaveGameID	db 0			; DATA XREF: seg007:750Ew seg007:7520r ...
floorID		dw 0			; DATA XREF: seg007:7549o seg007:7559r ...
SaveGame_Level	dw 0			; DATA XREF: seg007:78B3o seg007:7955r
SaveGame_Day	dw 0			; DATA XREF: seg007:78C8o seg007:78D6r
SaveGame_Month	dw 0			; DATA XREF: seg007:78FBr
SaveGame_Hour	dw 0			; DATA XREF: seg007:791Dr
SaveGame_Minute	dw 0			; DATA XREF: seg007:793Fr
aSavNamePattern	db '**/** **:**  Level**' ; DATA XREF: PrintSaveGameName+1C5o
					; seg007:78E5w	...
NameChg_CharTbl	dw 0A082h,0A282h,0A482h,0A682h,0A882h, 4081h,0AA82h,0AC82h,0AE82h,0B082h,0B282h, 4081h,	4183h, 4383h, 4583h, 4783h, 4983h; 0
					; DATA XREF: seg007:82ECo
		dw 0A982h,0AB82h,0AD82h,0AF82h,0B182h, 4081h,0B482h,0B682h,0B882h,0BA82h,0BC82h, 4081h,	4A83h, 4C83h, 4E83h, 5083h, 5283h; 11h
		dw 0B382h,0B582h,0B782h,0B982h,0BB82h, 4081h,0BE82h,0BF82h,0C382h,0C582h,0C782h, 4081h,	5483h, 5683h, 5883h, 5A83h, 5C83h; 22h
		dw 0BD82h,0BF82h,0C282h,0C482h,0C682h, 4081h,0CE82h,0D182h,0D482h,0D782h,0DA82h, 4081h,	5E83h, 6083h, 6383h, 6583h, 6783h; 33h
		dw 0C882h,0C982h,0CA82h,0CB82h,0CC82h, 4081h,0CF82h,0D282h,0D582h,0D882h,0DB82h, 4081h,	6983h, 6A83h, 6B83h, 6C83h, 6D83h; 44h
		dw 0CD82h,0D082h,0D382h,0D682h,0D982h, 4081h, 4B83h, 4D83h, 4F83h, 5183h, 5383h, 4081h,	6E83h, 7183h, 7483h, 7783h, 7A83h; 55h
		dw 0DC82h,0DD82h,0DE82h,0DF82h,0E082h, 4081h, 5583h, 5783h, 5983h, 5B83h, 5D83h, 4081h,	7D83h, 7E83h, 8083h, 8183h, 8283h; 66h
		dw 0E282h, 4081h,0E482h, 4081h,0E682h, 4081h, 5F83h, 6183h, 6483h, 6683h, 6883h, 4081h,	8483h, 4081h, 8683h, 4081h, 8883h; 77h
		dw 0E782h,0E882h,0E982h,0EA82h,0EB82h, 4081h, 6F83h, 7283h, 7583h, 7883h, 7B83h, 4081h,	8983h, 8A83h, 8B83h, 8C83h, 8D83h; 88h
		dw 0ED82h, 4081h,0F082h, 4081h,0F182h, 4081h, 7083h, 7383h, 7683h, 7983h, 7C83h, 4081h,	8F83h, 4081h, 9283h, 4081h, 9383h; 99h
		dw  9F82h,0A182h,0A382h,0A582h,0A782h, 4081h, 4F82h, 5082h, 5182h, 5282h, 5382h, 4081h,	4083h, 4283h, 4483h, 4683h, 4883h; 0AAh
		dw 0E182h,0E382h,0E582h, 4081h,0C182h, 4081h, 5482h, 5582h, 5682h, 5782h, 5882h, 4081h,	8383h, 8583h, 8783h, 4081h, 6283h; 0BBh
		dw  6082h, 6182h, 6282h, 6382h,	6482h, 6582h, 6682h, 4081h, 6782h, 6882h, 6982h, 6A82h,	6B82h, 6C82h, 6D82h, 4081h, 4081h; 0CCh
		dw  6E82h, 6F82h, 7082h, 7182h,	7282h, 7382h, 7482h, 4081h, 7582h, 7682h, 7782h, 7882h,	7982h, 5B81h, 6081h, 4081h, 4081h; 0DDh
		dw  8182h, 8282h, 8382h, 8482h,	8582h, 8682h, 8782h, 4081h, 8882h, 8982h, 8A82h, 8B82h,	8C82h, 8D82h, 8E82h, 4081h, 2A2Ah; 0EEh
		dw  8F82h, 9082h, 9182h, 9282h,	9382h, 9482h, 9582h, 4081h, 9682h, 9782h, 9882h, 9982h,	9A82h, 4581h, 4481h, 4081h, 2A2Ah; 0FFh
word_1BCA6	dw 0			; DATA XREF: seg007:8368w seg007:8E83r ...
word_1BCA8	dw 0			; DATA XREF: seg007:836Fw seg007:8E72r ...
word_1BCAA	dw 0			; DATA XREF: seg007:81EBw seg007:8E8Er ...
word_1BCAC	dw 0			; DATA XREF: seg007:8376w seg007:8EF4r ...
word_1BCAE	dw 0			; DATA XREF: seg007:837Dw
OldInt8Vec	dd 0			; DATA XREF: seg007:8347w seg007:83D9r ...

; =============== S U B	R O U T	I N E =======================================


LoadScript	proc near		; CODE XREF: sub_12FB3:loc_130C7P
		pusha
		push	ds
		push	es
		push	1
		call	WritePortA6
		add	sp, 2
		mov	ax, cs
		mov	ds, ax
		assume ds:seg007
		mov	si, offset ScriptToLoad	; "A:SCN\\Z0000.DAT"
		call	scr63_SetDiskLetter
		mov	ax, seg	dseg
		mov	ds, ax
		assume ds:dseg
		mov	si, offset ScriptData
		push	ds
		push	si
		push	cs
		push	offset ScriptToLoad ; "A:SCN\\Z0000.DAT"
		call	ReadFile_Compr	; load game script data
		add	sp, 8
		push	cs
		push	offset ItemData
		push	cs
		push	offset aZ1010_dat ; "Z1010.DAT"
		call	ReadFile_Compr	; load item list
		add	sp, 8
		mov	ax, cs:ScriptMemory+1Eh
		cmp	ax, 0Ah
		jb	short loc_1BD00
		sub	al, 0Ah
		add	al, 'A'
		jmp	short loc_1BD02
; ---------------------------------------------------------------------------

loc_1BD00:				; CODE XREF: LoadScript+44j
		add	al, '0'

loc_1BD02:				; CODE XREF: LoadScript+4Aj
		mov	byte ptr cs:aZ1030_dat+4, al
		push	cs
		push	offset MonsterGrpData
		push	cs
		push	offset aZ1030_dat ; "Z1030.DAT"
		call	ReadFile_Compr	; load list of monster groups for the current floor
		add	sp, 8
		push	cs
		push	offset MonsterData
		push	cs
		push	offset aZ1020_dat ; "Z1020.DAT"
		call	ReadFile_Compr	; load monster list
		add	sp, 8
		push	0
		call	WritePortA6
		add	sp, 2

ScriptMainLoop:				; CODE XREF: seg007:7120j seg007:71DCj ...
		mov	al, [si]	; read command ID
		inc	si
		xor	ah, ah
		mov	di, ax
		add	di, di		; ID ->	offset into table of 2-byte pointers
		add	di, offset scrJumpTbl
		jmp	word ptr cs:[di]
LoadScript	endp

; ---------------------------------------------------------------------------

scr00_TalkDungeon:			; DATA XREF: seg007:scrJumpTblo
		mov	cs:tempVar0, 0	; mode "normal text"
		mov	ax, seg	dseg
		mov	es, ax
		assume es:dseg
		mov	di, 5AB8h
		mov	bh, 16		; 16 full-width	characters per line
		xor	dl, dl
		call	WaitForVSync

loc_1BD58:				; CODE XREF: seg007:7171j
		mov	es:textDrawPtr,	di
		or	dl, dl
		jz	short loc_1BD64
		add	di, 2

loc_1BD64:				; CODE XREF: seg007:70EFj
		xor	bl, bl

loc_1BD66:				; CODE XREF: seg007:7134j seg007:715Fj
		test	cs:tempVar0, 1
		jz	short loc_1BD88
		push	di		; handle mode "character name"
		mov	di, offset ScriptMemory
		add	di, cs:tempVar1
		mov	ax, cs:[di]
		pop	di
		or	ax, ax
		jz	short loc_1BD88
		add	cs:tempVar1, 2
		jmp	short loc_1BDA6
; ---------------------------------------------------------------------------

loc_1BD88:				; CODE XREF: seg007:70FDj seg007:710Ej
		mov	ax, [si]
		add	si, 2
		cmp	ax, 5C5Ch	; '\\'
		jz	short ScriptMainLoop
		cmp	ax, 2323h	; '##'
		jnz	short loc_1BDA6
		or	cs:tempVar0, 1	; set mode "character name"
		mov	cs:tempVar1, 0
		jmp	short loc_1BD66
; ---------------------------------------------------------------------------

loc_1BDA6:				; CODE XREF: seg007:7116j seg007:7125j
		mov	cx, ax
		push	ax
		call	ShiftJIS2JIS
		add	sp, 2
		push	cs:ScriptMemory+0Ch ; push ScriptMemory[06h]
		call	WaitFrames
		add	sp, 2
		push	ax
		call	PrintFontChar
		add	sp, 2
		inc	bl
		cmp	bl, bh
		jz	short loc_1BDD5
		cmp	cx, 7A81h	; Shift-JIS closing bracket
		jnz	short loc_1BD66
		mov	dl, 1
		jmp	short loc_1BDDD
; ---------------------------------------------------------------------------

loc_1BDD5:				; CODE XREF: seg007:7159j
		or	dl, dl
		jz	short loc_1BDDD
		dec	bh
		xor	dl, dl

loc_1BDDD:				; CODE XREF: seg007:7163j seg007:7167j
		add	di, 5F0h
		jmp	loc_1BD58
; ---------------------------------------------------------------------------

scr01_BGMLoad:				; DATA XREF: seg007:scrJumpTblo
		push	ds
		mov	ax, seg	dseg
		mov	es, ax
		test	es:MiscFlags, 4
		jz	short loc_1BDF8
		mov	bx, 1
		jmp	short loc_1BE03
; ---------------------------------------------------------------------------

loc_1BDF8:				; CODE XREF: seg007:7181j
		test	es:MiscFlags, 8
		jz	short loc_1BE42
		xor	bx, bx

loc_1BE03:				; CODE XREF: seg007:7186j
		mov	ax, seg	dseg
		mov	ds, ax
		mov	dx, si
		call	scr63_SetDiskLetter
		or	bx, bx
		jz	short loc_1BE1F
		push	si		; MIDI mode - replace extension	with ".N"

loc_1BE12:				; CODE XREF: seg007:71A8j
		cmp	byte ptr [si], '.'
		jz	short loc_1BE1A
		inc	si
		jmp	short loc_1BE12
; ---------------------------------------------------------------------------

loc_1BE1A:				; CODE XREF: seg007:71A5j
		mov	byte ptr [si+1], 'N'
		pop	si

loc_1BE1F:				; CODE XREF: seg007:719Fj
		xor	al, al
		mov	ah, 3Dh
		int	21h		; DOS -	2+ - OPEN DISK FILE WITH HANDLE
					; DS:DX	-> ASCIZ filename
					; AL = access mode
					; 0 - read
		push	ax
		push	ax
		or	bx, bx
		jz	short loc_1BE31
		mov	ah, 6		; routine 06 - get song	data address
		int	61h		; [MIDI	mode] call MMD driver
		jmp	short loc_1BE35
; ---------------------------------------------------------------------------

loc_1BE31:				; CODE XREF: seg007:71B9j
		mov	ah, 6		; routine 06 - get song	data address
		int	60h		; [FM mode] call PMD driver

loc_1BE35:				; CODE XREF: seg007:71BFj
		mov	cx, 6800h
		pop	bx
		mov	ah, 3Fh
		int	21h		; DOS -	2+ - READ FROM FILE WITH HANDLE
					; BX = file handle, CX = number	of bytes to read
					; DS:DX	-> buffer
		pop	bx
		mov	ah, 3Eh
		int	21h		; DOS -	2+ - CLOSE A FILE WITH HANDLE
					; BX = file handle

loc_1BE42:				; CODE XREF: seg007:718Fj
		pop	ds

loc_1BE43:				; CODE XREF: seg007:71D9j
		cmp	byte ptr [si], 0
		jz	short loc_1BE4B
		inc	si
		jmp	short loc_1BE43
; ---------------------------------------------------------------------------

loc_1BE4B:				; CODE XREF: seg007:71D6j
					; seg007:loc_1C0B4j ...
		inc	si
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

scr02_TalkFullScr:			; DATA XREF: seg007:scrJumpTblo
		mov	cs:tempVar0, 0
		mov	ax, seg	dseg
		mov	es, ax
		mov	di, 6723h
		mov	bh, 37		; 37 full-width	characters per line
		xor	dl, dl
		call	WaitForVSync

loc_1BE67:				; CODE XREF: seg007:729Ej
		or	dl, dl
		jz	short loc_1BE72
		add	di, 2
		dec	bh
		xor	dl, dl

loc_1BE72:				; CODE XREF: seg007:71F9j
		mov	es:textDrawPtr,	di
		xor	bl, bl

loc_1BE79:				; CODE XREF: seg007:724Aj seg007:7275j ...
		test	cs:tempVar0, 1
		jz	short loc_1BE9B
		push	di
		mov	di, offset ScriptMemory
		add	di, cs:tempVar1
		mov	ax, cs:[di]
		pop	di
		or	ax, ax
		jz	short loc_1BE9B
		add	cs:tempVar1, 2
		jmp	short loc_1BEBC
; ---------------------------------------------------------------------------

loc_1BE9B:				; CODE XREF: seg007:7210j seg007:7221j
		mov	ax, [si]
		add	si, 2
		cmp	ax, 5C5Ch	; '\\'
		jnz	short loc_1BEA8
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

loc_1BEA8:				; CODE XREF: seg007:7233j
		cmp	ax, 2323h	; '##'
		jnz	short loc_1BEBC
		or	cs:tempVar0, 1
		mov	cs:tempVar1, 0
		jmp	short loc_1BE79
; ---------------------------------------------------------------------------

loc_1BEBC:				; CODE XREF: seg007:7229j seg007:723Bj
		mov	cx, ax
		push	ax
		call	ShiftJIS2JIS
		add	sp, 2
		push	cs:ScriptMemory+0Ch ; push ScriptMemory[06h]
		call	WaitFrames
		add	sp, 2
		push	ax
		call	PrintFontChar
		add	sp, 2
		inc	bl
		cmp	bl, bh
		jz	short loc_1BF04
		cmp	cx, 7A81h	; Shift-JIS closing bracket
		jnz	short loc_1BE79
		mov	dl, 1
		cmp	bl, 7
		ja	short loc_1BEFD
		mov	bl, 7
		mov	di, 6731h
		mov	es:textDrawPtr,	di

loc_1BEF8:				; CODE XREF: seg007:7292j
		mov	dh, bl
		jmp	loc_1BE79
; ---------------------------------------------------------------------------

loc_1BEFD:				; CODE XREF: seg007:727Cj
		mov	di, es:textDrawPtr
		jmp	short loc_1BEF8
; ---------------------------------------------------------------------------

loc_1BF04:				; CODE XREF: seg007:726Fj
		or	dl, dl
		jz	short loc_1BF0A
		sub	bh, dh

loc_1BF0A:				; CODE XREF: seg007:7296j
		add	di, 5A0h
		jmp	loc_1BE67
; ---------------------------------------------------------------------------

scr03_NextScript:			; DATA XREF: seg007:scrJumpTblo
		pop	es
		assume es:nothing
		pop	ds
		popa
		xor	ax, ax
		retf
; ---------------------------------------------------------------------------

scr04_TextColor:			; DATA XREF: seg007:scrJumpTblo
		mov	ax, seg	dseg
		mov	es, ax
		assume es:dseg
		mov	ax, [si]
		mov	es:txtColorMain, ax
		mov	ax, [si+2]
		mov	es:txtColorShdw, ax

scr_fin_4b:				; CODE XREF: seg007:72DFj seg007:72E7j ...
		add	si, 4
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

scr05_PortA6:				; DATA XREF: seg007:scrJumpTblo
		push	word ptr [si]
		call	WritePortA6
		add	sp, 2

scr_fin_2b:				; CODE XREF: seg007:72D7j seg007:734Fj ...
		add	si, 2
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

scr06_Wait:				; DATA XREF: seg007:scrJumpTblo
		push	word ptr [si]
		call	WaitFrames
		add	sp, 2
		jmp	short scr_fin_2b
; ---------------------------------------------------------------------------

scr07_VarSetVal:			; DATA XREF: seg007:scrJumpTblo
		call	GetScriptVarVal
		mov	cs:[di], ax	; set variable to immediate value
		jmp	short scr_fin_4b
; ---------------------------------------------------------------------------

scr08_VarSetVar:			; DATA XREF: seg007:scrJumpTblo
		call	GetScriptVarVar
		mov	cs:[bx], cx	; set variable to contents of other variable
		jmp	short scr_fin_4b
; ---------------------------------------------------------------------------

scr09_VarAddVal:			; DATA XREF: seg007:scrJumpTblo
		call	GetScriptVarVal
		add	cs:[di], ax
		jmp	short scr_fin_4b
; ---------------------------------------------------------------------------

scr0A_VarAddVar:			; DATA XREF: seg007:scrJumpTblo
		call	GetScriptVarVar
		add	cs:[bx], cx
		jmp	short scr_fin_4b
; ---------------------------------------------------------------------------

scr0B_VarSubVal:			; DATA XREF: seg007:scrJumpTblo
		call	GetScriptVarVal
		sub	cs:[di], ax
		jmp	short scr_fin_4b
; ---------------------------------------------------------------------------

scr0C_VarSubVar:			; DATA XREF: seg007:scrJumpTblo
		call	GetScriptVarVar
		sub	cs:[bx], cx
		jmp	short scr_fin_4b
; ---------------------------------------------------------------------------

scr0D_ImgCopy1Val:			; DATA XREF: seg007:scrJumpTblo
		push	word ptr [si+8]	; copy mode
		push	word ptr [si+6]	; destination address
		push	word ptr [si+4]	; height (pixels)
		push	word ptr [si+2]	; width	(pixels)
		push	word ptr [si]	; source address
		call	ImageCopy1
		add	sp, 0Ah

scr_fin_10b:				; CODE XREF: seg007:742Dj seg007:7F51j ...
		add	si, 0Ah
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

scr0E_ImgCopy2Val:			; DATA XREF: seg007:scrJumpTblo
		push	2		; copy from background image to	screen
		push	word ptr [si+6]
		push	word ptr [si+4]
		push	word ptr [si+2]
		push	word ptr [si]
		call	WaitForVSync
		call	ImageCopy1
		add	sp, 0Ah
		add	si, 8
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

scr0F:					; DATA XREF: seg007:scrJumpTblo
		push	word ptr [si]
		call	sub_13ECE
		add	sp, 2
		jmp	scr_fin_2b
; ---------------------------------------------------------------------------

scr10_VarBitClear:			; DATA XREF: seg007:scrJumpTblo
		call	GetScriptVarVal
		mov	bx, offset bitMask_Clear
		add	ax, ax
		add	bx, ax
		mov	ax, cs:[bx]	; get mask for bit with	number AX
		and	cs:[di], ax	; clear	that bit in the	variable
		jmp	scr_fin_4b
; ---------------------------------------------------------------------------

scr11_VarBitSet:			; DATA XREF: seg007:scrJumpTblo
		call	GetScriptVarVal
		mov	bx, offset bitMask_Set
		add	ax, ax
		add	bx, ax
		mov	ax, cs:[bx]	; get mask for bit with	number AX
		or	cs:[di], ax	; clear	that bit in the	variable
		jmp	scr_fin_4b
; ---------------------------------------------------------------------------

scr12_VarsSetVal:			; DATA XREF: seg007:scrJumpTblo
		call	GetScriptVarVar
		sub	bx, di
		mov	cx, bx
		shr	cx, 1
		inc	cx
		mov	ax, cs
		mov	es, ax
		assume es:seg007
		mov	ax, [si+4]
		rep stosw

scr_fin_6b:				; CODE XREF: seg007:loc_1C04Bj
					; seg007:73E5j	...
		add	si, 6
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

scr13_GoSub:				; DATA XREF: seg007:scrJumpTblo
		mov	di, offset scrCallStack

loc_1C004:
		add	di, cs:[di]
		mov	ax, si
		add	ax, 2
		mov	cs:[di], ax
		add	cs:scrCallStack, 2
		mov	ax, offset ScriptData
		add	ax, [si]
		mov	si, ax
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

scr14_Return:				; DATA XREF: seg007:scrJumpTblo
		sub	cs:scrCallStack, 2
		mov	di, offset scrCallStack
		add	di, cs:[di]
		mov	si, cs:[di]
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

scr15_Jump:				; DATA XREF: seg007:scrJumpTblo
		mov	ax, offset ScriptData
		add	ax, [si]

loc_1C036:				; CODE XREF: seg007:73D9j
		mov	si, ax
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

scr16_JEQ:				; DATA XREF: seg007:scrJumpTblo
		call	GetScriptVarVal
		cmp	cs:[di], ax
		jnz	short loc_1C04B	; skip when !=,	execute	jump when ==

loc_1C043:				; CODE XREF: seg007:73E3j seg007:73EDj
		mov	ax, offset ScriptData
		add	ax, [si+4]
		jmp	short loc_1C036
; ---------------------------------------------------------------------------

loc_1C04B:				; CODE XREF: seg007:73D1j
		jmp	short scr_fin_6b
; ---------------------------------------------------------------------------

scr17_JGT:				; DATA XREF: seg007:scrJumpTblo
		call	GetScriptVarVal
		cmp	cs:[di], ax
		ja	short loc_1C043	; jump when >
		jmp	short scr_fin_6b
; ---------------------------------------------------------------------------

scr18_JLT:				; DATA XREF: seg007:scrJumpTblo
		call	GetScriptVarVal
		cmp	cs:[di], ax
		jb	short loc_1C043	; jump when <
		jmp	short scr_fin_6b
; ---------------------------------------------------------------------------

scr1A_LoadGTA:				; DATA XREF: seg007:scrJumpTblo
		pusha
		mov	ax, ds
		mov	es, ax
		assume es:dseg
		mov	di, offset scrGtaNameBuf ; "?????"
		mov	cx, 5
		push	word ptr [si]
		push	word ptr [si+2]
		add	si, 4
		push	es
		push	di
		rep movsb		; copy exactly 5 bytes
		call	LoadGTAFile
		add	sp, 8
		popa
		add	si, 9
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

scr1B_ImgFXVal:				; DATA XREF: seg007:scrJumpTblo
		push	word ptr [si+8]
		push	word ptr [si+6]
		push	word ptr [si+4]
		push	word ptr [si+2]
		push	word ptr [si]
		call	ImageCopy2
		add	sp, 0Ah
		jmp	scr_fin_10b
; ---------------------------------------------------------------------------

scr1C_SetNextScript:			; DATA XREF: seg007:scrJumpTblo
		mov	ax, cs		; This is usually followed by command 03 (End).
		mov	es, ax
		assume es:seg007
		mov	di, offset ScriptToLoad	; "A:SCN\\Z0000.DAT"

loc_1C0A7:				; CODE XREF: seg007:7442j
		mov	al, [si]
		mov	es:[di], al
		or	al, al
		jz	short loc_1C0B4	; stop when reaching a 0
		inc	si
		inc	di
		jmp	short loc_1C0A7
; ---------------------------------------------------------------------------

loc_1C0B4:				; CODE XREF: seg007:743Ej
		jmp	loc_1BE4B
; ---------------------------------------------------------------------------

scr1D_ShowMenu:				; DATA XREF: seg007:scrJumpTblo
		mov	ax, [si]
		mov	cs:tempVar0, ax
		add	ax, 641
		mov	cs:tempVar5, ax
		add	si, 2
		push	2
		call	sub_13ECE
		add	sp, 2
		push	1
		push	0
		push	192
		push	320
		push	ax
		call	ImageCopy1
		add	sp, 0Ah
		push	1
		call	WritePortA6
		add	sp, 2
		push	2
		push	0
		push	192
		push	320
		push	0
		call	ImageCopy1
		add	sp, 0Ah
		push	2
		push	28h
		push	192
		push	320
		push	0
		call	ImageCopy1
		add	sp, 0Ah
		mov	dx, cs:ScriptMemory+16h
		shl	dx, 4
		or	dx, 2
		mov	cs:tempVar8, dx
		xor	dx, dx
		mov	bx, 12

loc_1C12B:				; CODE XREF: seg007:74DFj
		mov	ax, dx
		mov	cx, 40

loc_1C130:				; CODE XREF: seg007:74D8j
		push	cs:tempVar8
		push	ax
		push	16
		push	16
		push	3EABh
		call	ImageCopy3
		add	sp, 0Ah
		add	ax, 2
		loop	loc_1C130
		add	dx, 500h
		dec	bx
		jnz	short loc_1C12B
		mov	cx, [si]	; read number of menutexts
		mov	cs:tempVar1, cx
		add	si, 2
		xor	dh, dh
		mov	ax, seg	dseg
		mov	es, ax
		assume es:dseg
		xor	bx, bx
		mov	cx, cs:tempVar1
		cmp	cs:ScriptMemory+66h, 1 ; menu type == 1	-> show	save game list
		jz	short ShowSavedGames
		cmp	cs:ScriptMemory+66h, 3 ; menu type == 3	-> show	save game list
		jz	short ShowSavedGames
		jmp	ShowMenuTexts
; ---------------------------------------------------------------------------

ShowSavedGames:				; CODE XREF: seg007:74FFj seg007:7507j
		pusha
		dec	cx
		mov	cs:SaveGameID, '1'
		mov	cs:ScriptMemory+6Eh, 0

ssg_list_loop:				; CODE XREF: seg007:79BBj
		mov	es:textDrawPtr,	bx
		mov	al, cs:SaveGameID
		mov	byte ptr cs:aZ1001_dat+4, al ; modify save game	name
		inc	cs:SaveGameID
		pusha
		push	ds
		mov	ax, cs
		mov	ds, ax
		assume ds:seg007
		mov	dx, offset aZ1001_dat ;	"Z1001.DAT"
		xor	al, al
		mov	ah, 3Dh
		int	21h		; DOS -	2+ - OPEN DISK FILE WITH HANDLE
					; DS:DX	-> ASCIZ filename
					; AL = access mode
					; 0 - read
		mov	bx, ax
		xor	al, al
		xor	cx, cx
		mov	dx, 0Ah
		mov	ah, 42h
		int	21h		; DOS -	2+ - MOVE FILE READ/WRITE POINTER (LSEEK)
					; AL = method: offset from beginning of	file
		mov	dx, offset floorID
		mov	cx, 1
		mov	ah, 3Fh
		int	21h		; DOS -	2+ - READ FROM FILE WITH HANDLE
					; BX = file handle, CX = number	of bytes to read
					; DS:DX	-> buffer
		mov	ah, 3Eh
		int	21h		; DOS -	2+ - CLOSE A FILE WITH HANDLE
					; BX = file handle
		pop	ds
		assume ds:dseg
		popa
		cmp	cs:floorID, 0
		jz	short loc_1C1D4	; floor	0 - assume invalid file
		jmp	LoadSaveG_Header
; ---------------------------------------------------------------------------

loc_1C1D4:				; CODE XREF: seg007:755Fj
		jmp	loc_1C2D4

; =============== S U B	R O U T	I N E =======================================

; Prints the following characters:
; 8140 8140 8140 8366 815B 835E	82CD 82A0 82E8 82DC 82B9 82F1
; -> "	 No data available."

Print_NoData	proc near		; CODE XREF: seg007:loc_1C2D4p
					; seg007:768Dp
		mov	ax, 4081h	; Shift-JIS full-width space
		push	ax
		call	ShiftJIS2JIS
		add	sp, 2
		push	ax
		call	PrintFontChar
		add	sp, 2
		mov	ax, 4081h
		push	ax
		call	ShiftJIS2JIS
		add	sp, 2
		push	ax
		call	PrintFontChar
		add	sp, 2
		mov	ax, 4081h
		push	ax
		call	ShiftJIS2JIS
		add	sp, 2
		push	ax
		call	PrintFontChar
		add	sp, 2
		mov	ax, 6683h
		push	ax
		call	ShiftJIS2JIS
		add	sp, 2
		push	ax
		call	PrintFontChar
		add	sp, 2
		mov	ax, 5B81h
		push	ax
		call	ShiftJIS2JIS
		add	sp, 2
		push	ax
		call	PrintFontChar
		add	sp, 2
		mov	ax, 5E83h
		push	ax
		call	ShiftJIS2JIS
		add	sp, 2
		push	ax
		call	PrintFontChar
		add	sp, 2
		mov	ax, 0CD82h
		push	ax
		call	ShiftJIS2JIS
		add	sp, 2
		push	ax
		call	PrintFontChar
		add	sp, 2
		mov	ax, 0A082h
		push	ax
		call	ShiftJIS2JIS
		add	sp, 2
		push	ax
		call	PrintFontChar
		add	sp, 2
		mov	ax, 0E882h
		push	ax
		call	ShiftJIS2JIS
		add	sp, 2
		push	ax
		call	PrintFontChar
		add	sp, 2
		mov	ax, 0DC82h
		push	ax
		call	ShiftJIS2JIS
		add	sp, 2
		push	ax
		call	PrintFontChar
		add	sp, 2
		mov	ax, 0B982h
		push	ax
		call	ShiftJIS2JIS
		add	sp, 2
		push	ax
		call	PrintFontChar
		add	sp, 2
		mov	ax, 0F182h
		push	ax
		call	ShiftJIS2JIS
		add	sp, 2
		push	ax
		call	PrintFontChar
		add	sp, 2
		retn
Print_NoData	endp

; ---------------------------------------------------------------------------

loc_1C2D4:				; CODE XREF: seg007:loc_1C1D4j
		call	Print_NoData
		add	bx, 28h
		mov	es:textDrawPtr,	bx
		push	es:txtColorMain
		push	es:txtColorShdw
		push	cs:ScriptMemory+12h
		pop	es:txtColorMain
		push	cs:ScriptMemory+14h
		pop	es:txtColorShdw
		call	Print_NoData
		pop	es:txtColorShdw
		pop	es:txtColorMain
		jmp	loc_1C61F

; =============== S U B	R O U T	I N E =======================================

; Format: "  X Labyrinth  DD/MM	hh:mm  Level N"

PrintSaveGameName proc near		; CODE XREF: seg007:7979p seg007:79A2p
		mov	ax, 4081h	; Shift-JIS full-width space
		push	ax
		call	ShiftJIS2JIS
		add	sp, 2
		push	ax
		call	PrintFontChar
		add	sp, 2
		mov	ax, cs:floorID
		or	ax, ax
		jz	short loc_1C3A9
		cmp	ax, 3
		ja	short loc_1C332
		jmp	loc_1C3C1
; ---------------------------------------------------------------------------

loc_1C332:				; CODE XREF: PrintSaveGameName+20j
		cmp	ax, 4
		jnz	short loc_1C33A
		jmp	loc_1C3D9
; ---------------------------------------------------------------------------

loc_1C33A:				; CODE XREF: PrintSaveGameName+28j
		cmp	ax, 5
		jnz	short loc_1C342
		jmp	loc_1C3F1
; ---------------------------------------------------------------------------

loc_1C342:				; CODE XREF: PrintSaveGameName+30j
		cmp	ax, 6
		jnz	short loc_1C34A
		jmp	loc_1C409
; ---------------------------------------------------------------------------

loc_1C34A:				; CODE XREF: PrintSaveGameName+38j
		cmp	ax, 7
		jnz	short loc_1C352
		jmp	loc_1C420
; ---------------------------------------------------------------------------

loc_1C352:				; CODE XREF: PrintSaveGameName+40j
		cmp	ax, 8
		jnz	short loc_1C35A
		jmp	loc_1C437
; ---------------------------------------------------------------------------

loc_1C35A:				; CODE XREF: PrintSaveGameName+48j
		cmp	ax, 9
		jnz	short loc_1C362
		jmp	loc_1C44E
; ---------------------------------------------------------------------------

loc_1C362:				; CODE XREF: PrintSaveGameName+50j
		cmp	ax, 10
		jnz	short loc_1C36A
		jmp	loc_1C465
; ---------------------------------------------------------------------------

loc_1C36A:				; CODE XREF: PrintSaveGameName+58j
		cmp	ax, 11
		jnz	short loc_1C372
		jmp	loc_1C47C
; ---------------------------------------------------------------------------

loc_1C372:				; CODE XREF: PrintSaveGameName+60j
		cmp	ax, 12
		jnz	short loc_1C379
		jmp	short loc_1C391
; ---------------------------------------------------------------------------

loc_1C379:				; CODE XREF: PrintSaveGameName+68j
		mov	ax, 0B990h	; Shift-JIS 90B9 = Holy
		push	ax
		call	ShiftJIS2JIS
		add	sp, 2
		push	ax
		call	PrintFontChar
		add	sp, 2
		jmp	loc_1C491
; ---------------------------------------------------------------------------

loc_1C391:				; CODE XREF: PrintSaveGameName+6Aj
		mov	ax, 0B396h	; Shift-JIS 96B3 = Nothing
		push	ax
		call	ShiftJIS2JIS
		add	sp, 2
		push	ax
		call	PrintFontChar
		add	sp, 2
		jmp	loc_1C491
; ---------------------------------------------------------------------------

loc_1C3A9:				; CODE XREF: PrintSaveGameName+1Bj
		mov	ax, 0B68Ch	; Shift-JIS 8CB6 = Illusion
		push	ax
		call	ShiftJIS2JIS
		add	sp, 2
		push	ax
		call	PrintFontChar
		add	sp, 2
		jmp	loc_1C491
; ---------------------------------------------------------------------------

loc_1C3C1:				; CODE XREF: PrintSaveGameName+22j
		mov	ax, 0F78Eh	; Shift-JIS 8EF7 = Tree
		push	ax
		call	ShiftJIS2JIS
		add	sp, 2
		push	ax
		call	PrintFontChar
		add	sp, 2
		jmp	loc_1C491
; ---------------------------------------------------------------------------

loc_1C3D9:				; CODE XREF: PrintSaveGameName+2Aj
		mov	ax, 5697h	; Shift-JIS 9756 = Play
		push	ax
		call	ShiftJIS2JIS
		add	sp, 2
		push	ax
		call	PrintFontChar
		add	sp, 2
		jmp	loc_1C491
; ---------------------------------------------------------------------------

loc_1C3F1:				; CODE XREF: PrintSaveGameName+32j
		mov	ax, 0DC97h	; Shift-JIS 97DC = Tears
		push	ax
		call	ShiftJIS2JIS
		add	sp, 2
		push	ax
		call	PrintFontChar
		add	sp, 2
		jmp	loc_1C491
; ---------------------------------------------------------------------------

loc_1C409:				; CODE XREF: PrintSaveGameName+3Aj
		mov	ax, 448Ah	; Shift-JIS 8A44 = Ash
		push	ax
		call	ShiftJIS2JIS
		add	sp, 2
		push	ax
		call	PrintFontChar
		add	sp, 2
		jmp	short loc_1C491
; ---------------------------------------------------------------------------

loc_1C420:				; CODE XREF: PrintSaveGameName+42j
		mov	ax, 0F48Eh	; Shift-JIS 8EF4 = Curse
		push	ax
		call	ShiftJIS2JIS
		add	sp, 2
		push	ax
		call	PrintFontChar
		add	sp, 2
		jmp	short loc_1C491
; ---------------------------------------------------------------------------

loc_1C437:				; CODE XREF: PrintSaveGameName+4Aj
		mov	ax, 438Ah	; Shift-JIS 8A43 = Ocean
		push	ax
		call	ShiftJIS2JIS
		add	sp, 2
		push	ax
		call	PrintFontChar
		add	sp, 2
		jmp	short loc_1C491
; ---------------------------------------------------------------------------

loc_1C44E:				; CODE XREF: PrintSaveGameName+52j
		mov	ax, 8A89h	; Shift-JIS 898A = Flame
		push	ax
		call	ShiftJIS2JIS
		add	sp, 2
		push	ax
		call	PrintFontChar
		add	sp, 2
		jmp	short loc_1C491
; ---------------------------------------------------------------------------

loc_1C465:				; CODE XREF: PrintSaveGameName+5Aj
		mov	ax, 6E92h	; Shift-JIS 926E = Earth
		push	ax
		call	ShiftJIS2JIS
		add	sp, 2
		push	ax
		call	PrintFontChar
		add	sp, 2
		jmp	short loc_1C491
; ---------------------------------------------------------------------------

loc_1C47C:				; CODE XREF: PrintSaveGameName+62j
		mov	ax, 9795h	; Shift-JIS 9597 = Wind
		push	ax
		call	ShiftJIS2JIS
		add	sp, 2
		push	ax
		call	PrintFontChar
		add	sp, 2

loc_1C491:				; CODE XREF: PrintSaveGameName+81j
					; PrintSaveGameName+99j ...
		mov	ax, 0C096h	; Shift-JIS 96C0 8B7B 8140 -> "Labyrinth "
		push	ax
		call	ShiftJIS2JIS
		add	sp, 2
		push	ax
		call	PrintFontChar
		add	sp, 2
		mov	ax, 7B8Bh
		push	ax
		call	ShiftJIS2JIS
		add	sp, 2
		push	ax
		call	PrintFontChar
		add	sp, 2
		mov	ax, 4081h
		push	ax
		call	ShiftJIS2JIS
		add	sp, 2
		push	ax
		call	PrintFontChar
		add	sp, 2
		push	bx
		push	cx
		mov	bx, offset aSavNamePattern ; "**/** **:**  Level**"
		mov	cx, 15h
		xor	ah, ah

loc_1C4DA:				; CODE XREF: PrintSaveGameName+1DAj
		mov	al, cs:[bx]
		push	ax
		call	PrintFontChar
		add	sp, 2
		inc	bx
		loop	loc_1C4DA
		pop	cx
		pop	bx
		retn
PrintSaveGameName endp

; ---------------------------------------------------------------------------

LoadSaveG_Header:			; CODE XREF: seg007:7561j
		or	cs:ScriptMemory+6Eh, 1
		pusha
		push	ds
		mov	ax, cs
		mov	ds, ax
		assume ds:seg007
		mov	dx, offset aZ1001_dat ;	"Z1001.DAT"
		xor	al, al
		mov	ah, 3Dh
		int	21h		; DOS -	2+ - OPEN DISK FILE WITH HANDLE
					; DS:DX	-> ASCIZ filename
					; AL = access mode
					; 0 - read
		mov	bx, ax
		xor	al, al
		xor	cx, cx
		mov	dx, 1Eh
		mov	ah, 42h
		int	21h		; DOS -	2+ - MOVE FILE READ/WRITE POINTER (LSEEK)
					; AL = method: offset from beginning of	file
		mov	dx, offset floorID
		mov	cx, 2
		mov	ah, 3Fh
		int	21h		; DOS -	2+ - READ FROM FILE WITH HANDLE
					; BX = file handle, CX = number	of bytes to read
					; DS:DX	-> buffer
		xor	al, al
		xor	cx, cx
		mov	dx, 21E8h
		mov	ah, 42h
		int	21h		; DOS -	2+ - MOVE FILE READ/WRITE POINTER (LSEEK)
					; AL = method: offset from beginning of	file
		mov	dx, offset SaveGame_Level
		mov	cx, 2
		mov	ah, 3Fh
		int	21h		; DOS -	2+ - READ FROM FILE WITH HANDLE
					; BX = file handle, CX = number	of bytes to read
					; DS:DX	-> buffer
		xor	al, al
		xor	cx, cx
		mov	dx, 96h
		mov	ah, 42h
		int	21h		; DOS -	2+ - MOVE FILE READ/WRITE POINTER (LSEEK)
					; AL = method: offset from beginning of	file
		mov	dx, offset SaveGame_Day
		mov	cx, 8
		mov	ah, 3Fh
		int	21h		; DOS -	2+ - READ FROM FILE WITH HANDLE
					; BX = file handle, CX = number	of bytes to read
					; DS:DX	-> buffer
		mov	ah, 3Eh
		int	21h		; DOS -	2+ - CLOSE A FILE WITH HANDLE
					; BX = file handle
		mov	ax, cs:SaveGame_Day
		mov	bx, 10
		xor	dx, dx
		div	bx
		or	ax, ax
		jz	short loc_1C55D
		mov	byte ptr cs:aSavNamePattern, '1' ; "**/** **:**  Level**"
		jmp	short loc_1C563
; ---------------------------------------------------------------------------

loc_1C55D:				; CODE XREF: seg007:78E3j
		mov	byte ptr cs:aSavNamePattern, ' ' ; "**/** **:**  Level**"

loc_1C563:				; CODE XREF: seg007:78EBj
		add	dl, '0'
		mov	byte ptr cs:aSavNamePattern+1, dl
		mov	ax, cs:SaveGame_Month
		xor	dx, dx
		div	bx
		or	ax, ax
		jz	short loc_1C57F
		add	al, '0'
		mov	byte ptr cs:aSavNamePattern+3, al
		jmp	short loc_1C585
; ---------------------------------------------------------------------------

loc_1C57F:				; CODE XREF: seg007:7905j
		mov	byte ptr cs:aSavNamePattern+3, ' '

loc_1C585:				; CODE XREF: seg007:790Dj
		add	dl, '0'
		mov	byte ptr cs:aSavNamePattern+4, dl
		mov	ax, cs:SaveGame_Hour
		xor	dx, dx
		div	bx
		or	ax, ax
		jz	short loc_1C5A1
		add	al, '0'
		mov	byte ptr cs:aSavNamePattern+6, al
		jmp	short loc_1C5A7
; ---------------------------------------------------------------------------

loc_1C5A1:				; CODE XREF: seg007:7927j
		mov	byte ptr cs:aSavNamePattern+6, ' '

loc_1C5A7:				; CODE XREF: seg007:792Fj
		add	dl, '0'
		mov	byte ptr cs:aSavNamePattern+7, dl
		mov	ax, cs:SaveGame_Minute
		xor	dx, dx
		div	bx
		add	al, '0'
		mov	byte ptr cs:aSavNamePattern+9, al
		add	dl, '0'
		mov	byte ptr cs:aSavNamePattern+0Ah, dl
		mov	ax, cs:SaveGame_Level
		xor	dx, dx
		div	bx
		or	ax, ax
		jz	short loc_1C5D9
		add	al, '0'
		mov	byte ptr cs:aSavNamePattern+12h, al
		jmp	short loc_1C5DF
; ---------------------------------------------------------------------------

loc_1C5D9:				; CODE XREF: seg007:795Fj
		mov	byte ptr cs:aSavNamePattern+12h, ' '

loc_1C5DF:				; CODE XREF: seg007:7967j
		add	dl, '0'
		mov	byte ptr cs:aSavNamePattern+13h, dl
		pop	ds
		assume ds:dseg
		popa
		call	PrintSaveGameName
		add	bx, 28h
		mov	es:textDrawPtr,	bx
		push	es:txtColorMain
		push	es:txtColorShdw
		push	cs:ScriptMemory+12h
		pop	es:txtColorMain
		push	cs:ScriptMemory+14h
		pop	es:txtColorShdw
		call	PrintSaveGameName
		pop	es:txtColorShdw
		pop	es:txtColorMain

loc_1C61F:				; CODE XREF: seg007:769Aj
		shl	cs:ScriptMemory+6Eh, 1
		add	bx, 4D8h
		dec	cx
		jz	short loc_1C62E
		jmp	ssg_list_loop
; ---------------------------------------------------------------------------

loc_1C62E:				; CODE XREF: seg007:79B9j
		jmp	loc_1C704

; =============== S U B	R O U T	I N E =======================================

; Prints the following characters:
; 8140 8140 8140 8140 8140 8140	8EE6 82E8 8FC1 82B5
; -> "	    Cancel"

Print_Cancel	proc near		; CODE XREF: seg007:7A99p seg007:7AC2p
		mov	ax, 4081h	; Shift-JIS full-width space
		push	ax
		call	ShiftJIS2JIS
		add	sp, 2
		push	ax
		call	PrintFontChar
		add	sp, 2
		mov	ax, 4081h
		push	ax
		call	ShiftJIS2JIS
		add	sp, 2
		push	ax
		call	PrintFontChar
		add	sp, 2
		mov	ax, 4081h
		push	ax
		call	ShiftJIS2JIS
		add	sp, 2
		push	ax
		call	PrintFontChar
		add	sp, 2
		mov	ax, 4081h
		push	ax
		call	ShiftJIS2JIS
		add	sp, 2
		push	ax
		call	PrintFontChar
		add	sp, 2
		mov	ax, 4081h
		push	ax
		call	ShiftJIS2JIS
		add	sp, 2
		push	ax
		call	PrintFontChar
		add	sp, 2
		mov	ax, 4081h
		push	ax
		call	ShiftJIS2JIS
		add	sp, 2
		push	ax
		call	PrintFontChar
		add	sp, 2
		mov	ax, 0E68Eh
		push	ax
		call	ShiftJIS2JIS
		add	sp, 2
		push	ax
		call	PrintFontChar
		add	sp, 2
		mov	ax, 0E882h
		push	ax
		call	ShiftJIS2JIS
		add	sp, 2
		push	ax
		call	PrintFontChar
		add	sp, 2
		mov	ax, 0C18Fh
		push	ax
		call	ShiftJIS2JIS
		add	sp, 2
		push	ax
		call	PrintFontChar
		add	sp, 2
		mov	ax, 0B582h
		push	ax
		call	ShiftJIS2JIS
		add	sp, 2
		push	ax
		call	PrintFontChar
		add	sp, 2
		retn
Print_Cancel	endp

; ---------------------------------------------------------------------------

loc_1C704:				; CODE XREF: seg007:loc_1C62Ej
		mov	es:textDrawPtr,	bx
		call	Print_Cancel
		add	bx, 28h
		mov	es:textDrawPtr,	bx
		push	es:txtColorMain
		push	es:txtColorShdw
		push	cs:ScriptMemory+12h
		pop	es:txtColorMain
		push	cs:ScriptMemory+14h
		pop	es:txtColorShdw
		call	Print_Cancel
		pop	es:txtColorShdw
		pop	es:txtColorMain
		popa
		mov	dh, 10h
		add	si, 0CCh
		jmp	short loc_1C7BB
; ---------------------------------------------------------------------------

ShowMenuTexts:				; CODE XREF: seg007:7509j seg007:7B49j
		xor	dl, dl
		mov	es:textDrawPtr,	bx

loc_1C74F:				; CODE XREF: seg007:7B3Aj
		mov	ax, [si]
		add	si, 2
		cmp	ax, 5C5Ch	; \\
		jz	short loc_1C7AC
		inc	dl		; count	number of written full-width characters
		push	ax
		call	ShiftJIS2JIS
		add	sp, 2
		push	ax
		call	PrintFontChar	; draw unselected text (white)
		add	sp, 2
		add	es:textDrawPtr,	26h
		push	es:txtColorMain
		push	es:txtColorShdw
		push	cs:ScriptMemory+12h
		pop	es:txtColorMain
		push	cs:ScriptMemory+14h
		pop	es:txtColorShdw
		push	ax
		call	PrintFontChar	; draw selected	text (red)
		add	sp, 2
		pop	es:txtColorShdw
		pop	es:txtColorMain
		sub	es:textDrawPtr,	28h
		jmp	short loc_1C74F
; ---------------------------------------------------------------------------

loc_1C7AC:				; CODE XREF: seg007:7AE7j
		add	bx, 500h
		cmp	dl, dh
		jb	short loc_1C7B6
		mov	dh, dl		; dh = max(dl, dh)

loc_1C7B6:				; CODE XREF: seg007:7B42j
		dec	cx
		jz	short loc_1C7BB
		jmp	short ShowMenuTexts
; ---------------------------------------------------------------------------

loc_1C7BB:				; CODE XREF: seg007:7AD6j seg007:7B47j
		push	1
		push	0
		push	192
		push	640
		push	0
		call	ImageCopy1
		add	sp, 0Ah
		mov	dl, dh
		xor	dh, dh
		shl	dx, 4
		mov	cs:tempVar3, dx
		add	dx, 16
		mov	cs:tempVar6, dx
		mov	cx, cs:tempVar1
		shl	cx, 4
		mov	cs:tempVar4, cx
		add	cx, 16
		mov	cs:tempVar7, cx
		mov	cs:ScriptMemory+6Ah, 1
		call	sub_14005
		push	1
		call	WritePortA4
		add	sp, 2
		push	0
		call	WritePortA6
		add	sp, 2
		push	1
		push	3C00h
		push	cx
		push	dx
		push	cs:tempVar0
		call	ImageCopy1
		add	sp, 0Ah
		mov	ax, cs:tempVar0
		push	cs:tempVar8
		push	ax
		push	8
		push	8
		push	3C2Ah
		call	ImageCopy3
		add	sp, 0Ah
		mov	bx, cs:tempVar0
		inc	bx
		mov	cx, cs:tempVar3
		shr	cx, 4

loc_1C853:				; CODE XREF: seg007:7BFBj
		push	cs:tempVar8
		push	bx
		push	8
		push	16
		push	3C2Bh
		call	ImageCopy3
		add	sp, 0Ah
		add	bx, 2
		loop	loc_1C853
		push	cs:tempVar8
		push	bx
		push	8
		push	8
		push	3C2Dh
		call	ImageCopy3
		add	sp, 0Ah
		add	ax, 280h
		add	bx, 280h
		mov	cx, cs:tempVar4
		shr	cx, 4

loc_1C891:				; CODE XREF: seg007:7C52j
		push	cs:tempVar8
		push	ax
		push	16
		push	8
		push	3EAAh
		call	ImageCopy3
		add	sp, 0Ah
		push	cs:tempVar8
		push	bx
		push	10h
		push	8
		push	3EADh
		call	ImageCopy3
		add	sp, 0Ah
		add	ax, 500h
		add	bx, 500h
		loop	loc_1C891
		push	cs:tempVar8
		push	ax
		push	8
		push	8
		push	43AAh
		call	ImageCopy3
		add	sp, 0Ah
		push	cs:tempVar8
		push	bx
		push	8
		push	8
		push	43ADh
		call	ImageCopy3
		add	sp, 0Ah
		inc	ax
		mov	cx, cs:tempVar3
		shr	cx, 4

loc_1C8F7:				; CODE XREF: seg007:7C9Fj
		push	cs:tempVar8
		push	ax
		push	8
		push	10h
		push	43ABh
		call	ImageCopy3
		add	sp, 0Ah
		add	ax, 2
		loop	loc_1C8F7
		xor	bx, bx
		mov	ax, cs:tempVar5
		mov	cx, cs:tempVar1

loc_1C91C:				; CODE XREF: seg007:7CC6j
		push	2
		push	ax
		push	10h
		push	cs:tempVar3
		push	bx
		call	ImageCopy1
		add	sp, 0Ah
		add	bx, 500h
		add	ax, 500h
		loop	loc_1C91C
		push	2
		push	cs:tempVar5
		push	16
		push	cs:tempVar3
		push	28h
		call	ImageCopy1
		add	sp, 0Ah
		mov	cs:tempVar2, 0
		call	WaitForVSync
		push	0
		call	WritePortA4
		add	sp, 2
		mov	cs:ScriptMemory+6Ah, 0
		xor	al, al
		mov	ah, 0Bh
		int	68h		;  - APPC/PC

loc_1C973:				; CODE XREF: seg007:7DC9j seg007:7DF2j ...
		mov	ah, 3
		int	68h		;  - APPC/PC
					; DS:DX	-> control block
		mov	cs:tempVar9, 0
		mov	ah, 5
		int	68h		;  - APPC/PC - TRANSFER	MSG DATA
					; DS:DX	-> control block
		shr	bx, 3
		mov	ax, cs:tempVar5
		mov	di, dx
		push	bx
		mov	bx, 80
		xor	dx, dx
		div	bx
		mov	cx, ax
		pop	bx
		cmp	bx, dx
		jb	short loc_1C9DD
		mov	ax, cs:tempVar3
		shr	ax, 3
		add	dx, ax
		cmp	bx, dx
		jnb	short loc_1C9DD
		mov	dx, di
		mov	di, cx
		cmp	dx, cx
		jb	short loc_1C9DD
		add	cx, cs:tempVar4
		cmp	dx, cx
		jnb	short loc_1C9DD
		mov	ax, di
		sub	dx, ax
		shr	dx, 4
		mov	cs:tempVar9, 1
		cmp	dx, cs:tempVar2
		jz	short loc_1C9DD
		mov	cs:tempVar9, 0
		mov	di, dx
		call	sub_1DA95
		mov	ax, di
		jmp	short loc_1CA0E
; ---------------------------------------------------------------------------

loc_1C9DD:				; CODE XREF: seg007:7D28j seg007:7D35j ...
		mov	ah, 9
		int	68h		;  - APPC/PC
		test	al, 2
		jz	short loc_1C9E8
		jmp	loc_1CA94
; ---------------------------------------------------------------------------

loc_1C9E8:				; CODE XREF: seg007:7D73j
		cmp	cs:ScriptMemory+66h, 2
		jb	short loc_1C9F4
		test	al, 1
		jnz	short loc_1CA73

loc_1C9F4:				; CODE XREF: seg007:7D7Ej
		call	sub_1499B
		test	ax, 1
		jz	short loc_1CA3C
		call	sub_1DA95
		cmp	ax, 0
		jnz	short loc_1CA0D
		mov	ax, cs:tempVar1
		dec	ax
		jmp	short loc_1CA0E
; ---------------------------------------------------------------------------

loc_1CA0D:				; CODE XREF: seg007:7D94j
		dec	ax

loc_1CA0E:				; CODE XREF: seg007:7D6Bj seg007:7D9Bj ...
		call	sub_1DA6B
		cmp	cs:tempVar9, 0
		jz	short loc_1CA31
		mov	ax, cx
		mov	bx, 80
		xor	dx, dx
		div	bx
		add	ax, 13
		mov	cx, ax
		mov	ah, 5
		int	68h		;  - APPC/PC - TRANSFER	MSG DATA
					; DS:DX	-> control block
		mov	dx, cx
		mov	ah, 6
		int	68h		;  - APPC/PC - CHANGE NUMBER OF	SESSIONS
					; DS:DX	-> control block

loc_1CA31:				; CODE XREF: seg007:7DA7j
		push	6
		call	WaitFrames
		add	sp, 2
		jmp	loc_1C973
; ---------------------------------------------------------------------------

loc_1CA3C:				; CODE XREF: seg007:7D8Cj
		test	ax, 2
		jz	short loc_1CA55
		call	sub_1DA95
		mov	cx, cs:tempVar1
		dec	cx
		cmp	ax, cx
		jnz	short loc_1CA52
		xor	ax, ax
		jmp	short loc_1CA0E
; ---------------------------------------------------------------------------

loc_1CA52:				; CODE XREF: seg007:7DDCj
		inc	ax
		jmp	short loc_1CA0E
; ---------------------------------------------------------------------------

loc_1CA55:				; CODE XREF: seg007:7DCFj
		test	ax, 10h
		jnz	short loc_1CA94
		cmp	cs:ScriptMemory+66h, 1
		ja	short loc_1CA65
		jmp	loc_1C973
; ---------------------------------------------------------------------------

loc_1CA65:				; CODE XREF: seg007:7DF0j
		cmp	cs:ScriptMemory+66h, 0
		test	ax, 0A0h
		jnz	short loc_1CA73
		jmp	loc_1C973
; ---------------------------------------------------------------------------

loc_1CA73:				; CODE XREF: seg007:7D82j seg007:7DFEj
		cmp	cs:ScriptMemory+66h, 2
		jb	short loc_1CA94
		mov	cs:tempVar2, 0FFFEh
		cmp	cs:ScriptMemory+6Ch, 0
		jz	short loc_1CAA4
		push	ax
		mov	al, 2
		mov	ah, 0Ch
		int	60h		; call PMD driver
		pop	ax
		jmp	short loc_1CAA4
; ---------------------------------------------------------------------------

loc_1CA94:				; CODE XREF: seg007:7D75j seg007:7DE8j ...
		cmp	cs:ScriptMemory+6Ch, 0
		jz	short loc_1CAA4
		push	ax
		mov	al, 1
		mov	ah, 0Ch
		int	60h		; call PMD driver
		pop	ax

loc_1CAA4:				; CODE XREF: seg007:7E18j seg007:7E22j ...
		mov	ah, 4
		int	68h		;  - APPC/PC
					; DS:DX	-> control block
		mov	ax, cs:tempVar2
		inc	ax
		mov	cs:ScriptMemory+10h, ax
		mov	cs:ScriptMemory+6Ah, 1
		call	sub_14005
		push	1
		call	WritePortA4
		add	sp, 2
		push	0
		call	WritePortA6
		add	sp, 2
		push	2
		push	cs:tempVar0
		push	cs:tempVar7
		push	cs:tempVar6
		push	3C00h
		call	ImageCopy1
		add	sp, 0Ah
		call	WaitForVSync
		push	0
		call	WritePortA4
		add	sp, 2
		mov	cs:ScriptMemory+6Ah, 0

loc_1CB03:				; CODE XREF: seg007:7E9Bj
		call	sub_1499B
		test	ax, 0B0h
		jnz	short loc_1CB03

loc_1CB0D:				; CODE XREF: seg007:7EA3j
		mov	ah, 9
		int	68h		;  - APPC/PC
		test	al, 3
		jnz	short loc_1CB0D
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

scr1E_Quit:				; DATA XREF: seg007:scrJumpTblo
		pop	es
		assume es:nothing
		pop	ds
		popa
		mov	ax, 1
		retf
; ---------------------------------------------------------------------------

scr1F:					; DATA XREF: seg007:scrJumpTblo
		push	word ptr [si]
		call	sub_140FA
		add	sp, 2
		jmp	scr_fin_2b
; ---------------------------------------------------------------------------

scr20:					; DATA XREF: seg007:scrJumpTblo
		push	word ptr [si]
		call	sub_14134
		add	sp, 2
		jmp	scr_fin_2b
; ---------------------------------------------------------------------------

scr21_LoadSaveGame:			; DATA XREF: seg007:scrJumpTblo
		push	ds
		mov	dx, si
		xor	al, al
		mov	ah, 3Dh
		int	21h		; DOS -	2+ - OPEN DISK FILE WITH HANDLE
					; DS:DX	-> ASCIZ filename
					; AL = access mode
					; 0 - read
		push	ax
		mov	bx, ax
		mov	cx, cs
		mov	ds, cx
		assume ds:seg007
		mov	dx, offset ScriptMemory
		mov	cx, 2488h
		mov	ah, 3Fh
		int	21h		; DOS -	2+ - READ FROM FILE WITH HANDLE
					; BX = file handle, CX = number	of bytes to read
					; DS:DX	-> buffer
		pop	bx
		mov	ah, 3Eh
		int	21h		; DOS -	2+ - CLOSE A FILE WITH HANDLE
					; BX = file handle
		pop	ds
		assume ds:dseg

loc_1CB59:				; CODE XREF: seg007:7EEFj
		cmp	byte ptr [si], 0
		jz	short loc_1CB61
		inc	si
		jmp	short loc_1CB59
; ---------------------------------------------------------------------------

loc_1CB61:				; CODE XREF: seg007:7EECj
		jmp	loc_1BE4B
; ---------------------------------------------------------------------------

scr22:					; DATA XREF: seg007:scrJumpTblo
		call	sub_14005
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

scr23:					; DATA XREF: seg007:scrJumpTblo
		call	WaitForVSync
		push	word ptr [si]
		call	WritePortA4
		add	sp, 2
		jmp	scr_fin_2b
; ---------------------------------------------------------------------------

scr24_ReadMap:				; DATA XREF: seg007:scrJumpTblo
		call	GetMapDataPtr
		mov	cs:ScriptMemory+0Eh, ax	; set ScriptMemory[07h]
		jmp	scr_fin_2b
; ---------------------------------------------------------------------------

scr25_VarBitTest:			; DATA XREF: seg007:scrJumpTblo
		call	GetScriptVarVal
		mov	bx, cs:[di]	; get variable
		add	ax, ax
		mov	di, offset bitMask_Set
		add	di, ax
		and	bx, cs:[di]	; extract that bit from	the variable
		jnz	short loc_1CBA0	; bit is non-zero - advance by 4 bytes
		add	si, 7		; bit is zero -	advance	by 7 bytes, skipping the next command
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

loc_1CBA0:				; CODE XREF: seg007:7F28j
		jmp	scr_fin_4b
; ---------------------------------------------------------------------------

scr26_ImgCopy3Val:			; DATA XREF: seg007:scrJumpTblo
		mov	ax, cs:ScriptMemory+2Ah	; get ScriptMemory[15h]
		shl	ax, 4
		or	ax, [si+8]
		push	ax
		push	word ptr [si+6]
		push	word ptr [si+4]
		push	word ptr [si+2]
		push	word ptr [si]
		call	ImageCopy3
		add	sp, 0Ah
		jmp	scr_fin_10b
; ---------------------------------------------------------------------------

scr27_DoInput:				; CODE XREF: seg007:7FDBj seg007:7FEEj
					; DATA XREF: ...
		call	sub_1499B
		mov	cx, ax
		mov	ah, 9
		int	68h		;  - APPC/PC
		test	al, 2
		jz	short loc_1CBD6
		or	cx, 10h

loc_1CBD6:				; CODE XREF: seg007:7F61j
		test	al, 1
		jz	short loc_1CC2D
		or	cx, 20h
		cmp	cs:ScriptMemory+4Ch, 1
		jz	short loc_1CC2D
		mov	ax, cs:ScriptMemory+34h
		mov	bx, cs:ScriptMemory+32h
		or	bx, bx
		jz	short loc_1CBF9
		cmp	bx, 1
		jz	short loc_1CC09
		jmp	short loc_1CC1B
; ---------------------------------------------------------------------------

loc_1CBF9:				; CODE XREF: seg007:7F80j
		inc	ax
		cmp	ax, 1
		jnz	short loc_1CC00
		inc	ax

loc_1CC00:				; CODE XREF: seg007:7F8Dj
		cmp	ax, 3
		jbe	short loc_1CC1B
		xor	ax, ax
		jmp	short loc_1CC1B
; ---------------------------------------------------------------------------

loc_1CC09:				; CODE XREF: seg007:7F85j
		inc	ax
		cmp	ax, 2
		jz	short loc_1CC18
		cmp	ax, 4
		jbe	short loc_1CC1B
		xor	ax, ax
		jmp	short loc_1CC1B
; ---------------------------------------------------------------------------

loc_1CC18:				; CODE XREF: seg007:7F9Dj
		mov	ax, 4

loc_1CC1B:				; CODE XREF: seg007:7F87j seg007:7F93j ...
		mov	cs:ScriptMemory+34h, ax
		mov	ah, 0Bh
		int	68h		;  - APPC/PC

loc_1CC23:				; CODE XREF: seg007:7FB9j
		mov	ah, 9
		int	68h		;  - APPC/PC
		test	al, 1
		jnz	short loc_1CC23
		xor	cx, cx

loc_1CC2D:				; CODE XREF: seg007:7F68j seg007:7F73j
		cmp	cs:ScriptMemory+4Ch, 1
		jnz	short loc_1CC5A
		mov	ah, 5
		int	68h		;  - APPC/PC - TRANSFER	MSG DATA
					; DS:DX	-> control block
		cmp	cs:screenSizeX,	bx
		jnz	short loc_1CC4E
		cmp	cs:screenSizeY,	dx
		jnz	short loc_1CC4E
		or	cx, cx
		jnz	short loc_1CC65
		jmp	scr27_DoInput
; ---------------------------------------------------------------------------

loc_1CC4E:				; CODE XREF: seg007:7FCEj seg007:7FD5j
		mov	cs:screenSizeX,	bx
		mov	cs:screenSizeY,	dx
		jmp	short loc_1CC65
; ---------------------------------------------------------------------------

loc_1CC5A:				; CODE XREF: seg007:7FC3j
		or	cx, cx
		jnz	short loc_1CC61
		jmp	scr27_DoInput
; ---------------------------------------------------------------------------

loc_1CC61:				; CODE XREF: seg007:7FECj
		mov	ah, 5
		int	68h		;  - APPC/PC - TRANSFER	MSG DATA
					; DS:DX	-> control block

loc_1CC65:				; CODE XREF: seg007:7FD9j seg007:7FE8j
		mov	cs:ScriptMemory+2Ch, cx
		mov	cs:ScriptMemory+2Eh, bx
		mov	cs:ScriptMemory+30h, dx

loc_1CC74:				; CODE XREF: seg007:8025j
		call	sub_1499B
		mov	cx, ax
		mov	ah, 9
		int	68h		;  - APPC/PC
		test	al, 4
		jz	short loc_1CC91
		test	al, 2
		jz	short loc_1CC8A
		or	cx, 10h

loc_1CC8A:				; CODE XREF: seg007:8015j
		test	al, 1
		jz	short loc_1CC91
		or	cx, 20h

loc_1CC91:				; CODE XREF: seg007:8011j seg007:801Cj
		test	cx, 0B0h
		jnz	short loc_1CC74
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

scr28:					; DATA XREF: seg007:scrJumpTblo
		mov	ah, 3
		int	68h		;  - APPC/PC
					; DS:DX	-> control block
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

scr29:					; DATA XREF: seg007:scrJumpTblo
		mov	ah, 4
		int	68h		;  - APPC/PC
					; DS:DX	-> control block
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

scr2A:					; DATA XREF: seg007:scrJumpTblo
		mov	ax, cs:ScriptMemory+34h
		mov	ah, 0Bh
		int	68h		;  - APPC/PC
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

scr2B_BGMPlay:				; DATA XREF: seg007:scrJumpTblo
		mov	ax, seg	dseg
		mov	es, ax
		assume es:dseg
		test	es:MiscFlags, 4
		jz	short loc_1CCC8
		mov	ah, 0		; routine 00 - start playback
		int	61h		; [MIDI	mode] call MMD driver
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

loc_1CCC8:				; CODE XREF: seg007:804Fj
		test	es:MiscFlags, 8
		jz	short loc_1CCD5
		mov	ah, 0		; routine 00 - start playback
		int	60h		; [FM mode] call PMD driver

loc_1CCD5:				; CODE XREF: seg007:805Fj
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

scr2C_BGMFadeWait:			; DATA XREF: seg007:scrJumpTblo
		mov	ax, seg	dseg
		mov	es, ax
		test	es:MiscFlags, 4
		jz	short loc_1CCFD
		mov	ax, [si]
		shr	ax, 2
		mov	ah, 2		; routine 02 - fade out
		int	61h		; [MIDI	mode] call MMD driver

loc_1CCEF:				; CODE XREF: seg007:8085j
		mov	ah, 8		; routine 08 - get driver attenuation
		int	61h
		cmp	al, 0FFh
		jnz	short loc_1CCEF	; wait until the music stopped (attenuation == 0FFh)
		mov	ah, 1		; routine 01 - stop music
		int	61h
		jmp	short loc_1CD18
; ---------------------------------------------------------------------------

loc_1CCFD:				; CODE XREF: seg007:8074j
		test	es:MiscFlags, 8
		jz	short loc_1CD18
		mov	ax, [si]
		mov	ah, 2		; routine 02 - fade out
		int	60h		; [FM mode] call PMD driver

loc_1CD0C:				; CODE XREF: seg007:80A2j
		mov	ah, 8		; routine 08 - get driver attenuation
		int	60h
		cmp	al, 0FFh
		jnz	short loc_1CD0C	; wait until the music stopped (attenuation == 0FFh)
		mov	ah, 1		; routine 01 - stop music
		int	60h

loc_1CD18:				; CODE XREF: seg007:808Bj seg007:8094j
		jmp	scr_fin_2b
; ---------------------------------------------------------------------------

scr2D:					; DATA XREF: seg007:scrJumpTblo
		call	GetScriptVarVal
		mov	bx, cs:[di]
		add	si, 2
		call	GetScriptVarVal
		mov	dx, cs:[di]
		mov	ah, 6
		int	68h		;  - APPC/PC - CHANGE NUMBER OF	SESSIONS
					; DS:DX	-> control block
		jmp	scr_fin_2b
; ---------------------------------------------------------------------------

scr2E_WriteMap:				; DATA XREF: seg007:scrJumpTblo
		call	GetMapDataPtr
		mov	ax, cs:ScriptMemory+0Eh	; get ScriptMemory[07h]
		mov	cs:[bx], ax
		jmp	scr_fin_2b
; ---------------------------------------------------------------------------

scr2F_DrawMap:				; DATA XREF: seg007:scrJumpTblo
		push	ds
		push	si
		mov	ax, cs
		mov	ds, ax
		assume ds:seg007
		mov	si, offset tempVar3
		mov	cs:tempVar3, 13h
		mov	cs:tempVar4, 14h
		mov	cs:ScriptMemory+26h, 0
		mov	cs:ScriptMemory+28h, 0

drawmap_loop:				; CODE XREF: seg007:81C8j
		call	GetMapDataPtr
		sub	si, 2
		mov	cx, ax
		test	cx, 100h	; position uncovered?
		jz	short loc_1CD97	; no - jump
		or	cx, 8000h
		mov	cs:tempVar0, cx	; mark as "in use"
		and	cx, 0FFh	; keep only the	"door" and "wall" flags
		mov	di, offset MapImageRects

loc_1CD81:				; CODE XREF: seg007:811Fj
		cmp	cx, cs:[di]	; walk through all values and choose the proper	16x16 graphic
		jz	short loc_1CD91
		add	di, 4
		cmp	word ptr cs:[di], 0FFFFh ; reached end of the table?
		jz	short loc_1CD97	; yes -	jump and draw empty square
		jmp	short loc_1CD81
; ---------------------------------------------------------------------------

loc_1CD91:				; CODE XREF: seg007:8114j
		mov	cx, cs:[di+2]	; get graphic address
		jmp	short loc_1CD9E
; ---------------------------------------------------------------------------

loc_1CD97:				; CODE XREF: seg007:80FFj seg007:811Dj
		xor	cx, cx
		mov	cs:tempVar0, cx	; draw empty square

loc_1CD9E:				; CODE XREF: seg007:8125j
		mov	di, 518h	; start	drawing	at X=192 Y=16
		mov	ax, cs:ScriptMemory+26h	; get map X position
		add	ax, ax
		add	di, ax
		mov	ax, cs:ScriptMemory+28h	; get map Y position
		mov	dx, 500h
		mul	dx
		add	di, ax
		push	2
		push	di
		push	16
		push	16
		push	cx
		call	ImageCopy1
		add	sp, 0Ah
		mov	cx, cs:tempVar0
		test	cx, 8000h
		jz	short drawmap_next ; unknown spot - continue with next square
		test	cx, 400h
		jz	short loc_1CDE8
		push	2		; draw "stairs up" on top
		push	di
		push	16
		push	16
		push	0Ah
		call	ImageCopy3
		add	sp, 0Ah
		jmp	short drawmap_next
; ---------------------------------------------------------------------------

loc_1CDE8:				; CODE XREF: seg007:8163j
		test	cx, 800h
		jz	short loc_1CE01
		push	2		; draw "stairs down" on	top
		push	di
		push	16
		push	16
		push	0Ch
		call	ImageCopy3
		add	sp, 0Ah
		jmp	short drawmap_next
; ---------------------------------------------------------------------------

loc_1CE01:				; CODE XREF: seg007:817Cj
		test	cx, 200h
		jz	short drawmap_next
		push	2		; draw "event" on top
		push	di
		push	16
		push	16
		push	0Eh
		call	ImageCopy3
		add	sp, 0Ah

drawmap_next:				; CODE XREF: seg007:815Dj seg007:8176j ...
		mov	ax, cs:ScriptMemory+26h
		mov	bx, cs:ScriptMemory+28h
		inc	ax
		cmp	ax, 10h
		jnz	short loc_1CE2A
		xor	ax, ax
		inc	bx

loc_1CE2A:				; CODE XREF: seg007:81B5j
		cmp	bx, 10h
		jz	short loc_1CE3B
		mov	cs:ScriptMemory+26h, ax
		mov	cs:ScriptMemory+28h, bx
		jmp	drawmap_loop
; ---------------------------------------------------------------------------

loc_1CE3B:				; CODE XREF: seg007:81BDj
		mov	cx, cs:ScriptMemory+18h
		add	cx, cx
		add	cx, 2
		mov	di, 518h
		mov	ax, cs:ScriptMemory+1Ah
		add	ax, ax
		add	di, ax
		mov	ax, cs:ScriptMemory+1Ch
		mov	dx, 500h
		mul	dx
		add	di, ax
		mov	cs:word_1BCAA, di
		push	0
		call	sub_13ECE
		add	sp, 2
		push	1
		push	7800h
		push	16
		push	16
		push	di
		call	ImageCopy1
		add	sp, 0Ah
		push	2
		call	sub_13ECE
		add	sp, 2
		push	2
		push	di
		push	16
		push	16
		push	cx
		call	ImageCopy3
		add	sp, 0Ah
		push	0
		call	sub_13ECE
		add	sp, 2
		push	1
		push	7802h
		push	16
		push	16
		push	di
		call	ImageCopy1
		add	sp, 0Ah
		pop	si
		pop	ds
		assume ds:dseg
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

scr30_PrintSJIS:			; DATA XREF: seg007:scrJumpTblo
		cmp	word ptr [si], 0FFFFh
		jz	short loc_1CEC7
		mov	ax, seg	dseg
		mov	es, ax
		mov	ax, [si]
		mov	es:textDrawPtr,	ax

loc_1CEC7:				; CODE XREF: seg007:824Aj
		add	si, 2

loc_1CECA:				; CODE XREF: seg007:8279j
		mov	ax, [si]
		add	si, 2
		cmp	ax, 5C5Ch	; \\
		jnz	short loc_1CED7
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

loc_1CED7:				; CODE XREF: seg007:8262j
		push	ax
		call	ShiftJIS2JIS
		add	sp, 2
		push	ax
		call	PrintFontChar
		add	sp, 2
		jmp	short loc_1CECA
; ---------------------------------------------------------------------------

scr31:					; DATA XREF: seg007:scrJumpTblo
		mov	di, 12D6h
		mov	ax, cs:ScriptMemory+22h
		add	ax, ax
		add	di, ax
		mov	ax, cs:ScriptMemory+24h
		mov	dx, 1600
		mul	dx
		add	di, ax
		push	2
		push	di
		push	10h
		push	10h
		push	di
		call	ImageCopy1
		add	sp, 0Ah
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

scr32:					; DATA XREF: seg007:scrJumpTblo
		mov	bx, cs:ScriptMemory+22h
		shl	bx, 4
		add	bx, 191
		mov	ax, cs:ScriptMemory+24h
		mov	dx, 20
		mul	dx
		mov	dx, ax
		add	dx, 75
		mov	ah, 6
		int	68h		;  - APPC/PC - CHANGE NUMBER OF	SESSIONS
					; DS:DX	-> control block
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

scr33_PlrName_AddChr:			; DATA XREF: seg007:scrJumpTblo
		mov	cx, cs:ScriptMemory+0Eh	; get variable 7 (player name length)
		add	cx, cx		; index	-> offset for 2-byte words
		mov	ax, seg	dseg
		mov	es, ax
		mov	ax, offset plrName_ScrOfs
		add	ax, cx
		mov	es:textDrawPtr,	ax
		mov	di, cs:ScriptMemory+22h	; get table cursor X position
		add	di, di
		mov	ax, cs:ScriptMemory+24h	; get table cursor Y position
		mov	dx, 22h
		mul	dx
		add	di, ax
		add	di, offset NameChg_CharTbl
		mov	ax, cs:[di]	; look up character from "name change character	table"
		mov	bx, offset ScriptMemory
		add	bx, cx
		mov	cs:[bx], ax	; place	the character into the respective variable
		push	ax		; then draw it to the screen
		call	ShiftJIS2JIS
		add	sp, 2
		push	ax
		call	PrintFontChar
		add	sp, 2
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

scr34_PlrName_DelChr:			; DATA XREF: seg007:scrJumpTblo
		mov	ax, cs:ScriptMemory+0Eh	; get variable 7 (player name length)
		add	ax, ax
		mov	bx, offset ScriptMemory
		add	bx, ax
		mov	word ptr cs:[bx], 0 ; set the variable to 0 to clear the character
		mov	di, offset plrName_ScrOfs
		add	di, ax
		push	2		; then draw the	background to the screen
		push	di
		push	10h
		push	10h
		push	di
		call	ImageCopy1
		add	sp, 0Ah
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

scr35:					; DATA XREF: seg007:scrJumpTblo
		pushf
		cli
		xor	ax, ax
		mov	es, ax
		assume es:nothing
		mov	ax, es:20h
		mov	dx, es:22h
		mov	word ptr cs:OldInt8Vec,	ax
		mov	word ptr cs:OldInt8Vec+2, dx
		xor	ax, ax
		mov	es, ax
		mov	bx, [si]
		add	bx, bx
		add	bx, offset off_14E77
		mov	ax, cs:[bx]
		mov	es:20h,	ax
		mov	word ptr es:22h, cs
		mov	cs:word_1BCA6, 0
		mov	cs:word_1BCA8, 0
		mov	cs:word_1BCAC, 0
		mov	cs:word_1BCAE, 0
		push	ds
		push	si
		mov	ax, seg	dseg
		mov	ds, ax
		mov	si, offset word_21EAA
		mov	ax, seg	dseg
		mov	es, ax
		assume es:dseg
		mov	di, offset byte_296F8
		mov	cx, 4
		rep movsw
		pop	si
		pop	ds
		xor	ax, ax
		mov	es, ax
		assume es:nothing
		mov	bx, 6000h
		mov	al, es:501h
		test	al, 80h
		jz	short loc_1D01F
		mov	bx, 4E00h

loc_1D01F:				; CODE XREF: seg007:83AAj
		mov	al, 36h	; '6'
		out	77h, al
		jmp	short $+2
		jmp	short $+2
		mov	al, bl
		out	71h, al		; CMOS Memory:
					; used by real-time clock
		jmp	short $+2
		jmp	short $+2
		mov	al, bh
		out	71h, al		; CMOS Memory:
					;
		in	al, 2		; DMA controller, 8237A-5.
					; channel 1 current address
		and	al, 0FEh
		out	2, al		; DMA controller, 8237A-5.
					; channel 1 base address
					; (also	sets current address)
		popf
		jmp	scr_fin_2b
; ---------------------------------------------------------------------------

scr36:					; DATA XREF: seg007:scrJumpTblo
		pushf
		cli
		in	al, 2		; DMA controller, 8237A-5.
					; channel 1 current address
		or	al, 1
		out	2, al		; DMA controller, 8237A-5.
					; channel 1 base address
					; (also	sets current address)
		xor	ax, ax
		mov	es, ax
		mov	ax, word ptr cs:OldInt8Vec
		mov	dx, word ptr cs:OldInt8Vec+2
		mov	es:20h,	ax
		mov	es:22h,	dx
		popf
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

scr37:					; CODE XREF: seg007:840Aj
					; DATA XREF: seg007:scrJumpTblo
		call	sub_1499B
		mov	cx, ax
		mov	ah, 9
		int	68h		;  - APPC/PC
		test	al, 2
		jz	short loc_1D071
		or	cx, 10h

loc_1D071:				; CODE XREF: seg007:83FCj
		test	al, 1
		jz	short loc_1D078
		or	cx, 20h

loc_1D078:				; CODE XREF: seg007:8403j
		or	cx, cx
		jnz	short scr37
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

scr38_WriteSaveGame:			; DATA XREF: seg007:scrJumpTblo
		mov	ah, 2Ah
		int	21h		; DOS -	GET CURRENT DATE
					; Return: DL = day, DH = month,	CX = year
					; AL = day of the week (0=Sunday, 1=Monday, etc.)
		xor	bx, bx
		mov	bl, dh
		mov	cs:ScriptMemory+96h, bx
		xor	dh, dh
		mov	cs:ScriptMemory+98h, dx
		mov	ah, 2Ch
		int	21h		; DOS -	GET CURRENT TIME
					; Return: CH = hours, CL = minutes, DH = seconds
					; DL = hundredths of seconds
		xor	bx, bx
		mov	bl, ch
		mov	cs:ScriptMemory+9Ah, bx
		xor	ch, ch
		mov	cs:ScriptMemory+9Ch, cx
		push	ds
		mov	dx, si
		mov	al, 1
		mov	ah, 3Dh
		int	21h		; DOS -	2+ - OPEN DISK FILE WITH HANDLE
					; DS:DX	-> ASCIZ filename
					; AL = access mode
					; 1 - write
		mov	bx, ax
		mov	cx, cs
		mov	ds, cx
		assume ds:seg007
		mov	dx, offset ScriptMemory
		mov	cx, 2488h
		mov	ah, 40h
		int	21h		; DOS -	2+ - WRITE TO FILE WITH	HANDLE
					; BX = file handle, CX = number	of bytes to write, DS:DX -> buffer
		mov	ah, 3Eh
		int	21h		; DOS -	2+ - CLOSE A FILE WITH HANDLE
					; BX = file handle
		pop	ds
		assume ds:dseg

loc_1D0C5:				; CODE XREF: seg007:845Bj
		cmp	byte ptr [si], 0
		jz	short loc_1D0CD
		inc	si
		jmp	short loc_1D0C5
; ---------------------------------------------------------------------------

loc_1D0CD:				; CODE XREF: seg007:8458j
		jmp	loc_1BE4B
; ---------------------------------------------------------------------------

scr39_VarRandomVal:			; DATA XREF: seg007:scrJumpTblo
		call	GetScriptVarVal
		mov	bx, ax
		push	bx
		push	si
		push	di
		push	ds
		push	es
		call	RNG_GetNext
		pop	es
		assume es:nothing
		pop	ds
		pop	di
		pop	si
		pop	bx
		xor	dx, dx
		div	bx
		mov	cs:[di], dx
		jmp	scr_fin_4b
; ---------------------------------------------------------------------------

scr3A_PrintASCII:			; DATA XREF: seg007:scrJumpTblo
		cmp	word ptr [si], 0FFFFh
		jz	short loc_1D0FE
		mov	ax, seg	dseg
		mov	es, ax
		assume es:dseg
		mov	ax, [si]
		mov	es:textDrawPtr,	ax

loc_1D0FE:				; CODE XREF: seg007:8481j
		add	si, 2
		xor	ah, ah

loc_1D103:				; CODE XREF: seg007:84A6j
		mov	al, [si]
		inc	si
		cmp	al, '\'         ; stop at backslash (\)
		jnz	short loc_1D10D
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

loc_1D10D:				; CODE XREF: seg007:8498j
		push	ax
		call	PrintFontChar
		add	sp, 2
		jmp	short loc_1D103
; ---------------------------------------------------------------------------

scr3B_PrintVarStr:			; DATA XREF: seg007:scrJumpTblo
		cmp	word ptr [si], 0FFFFh
		jz	short loc_1D128
		mov	ax, seg	dseg
		mov	es, ax
		mov	ax, [si]
		mov	es:textDrawPtr,	ax

loc_1D128:				; CODE XREF: seg007:84ABj
		add	si, 2
		call	GetScriptVarVal

loc_1D12E:				; CODE XREF: seg007:84E6j
		mov	ax, cs:[di]
		add	di, 2
		cmp	ax, 0		; stop at character code 0
		jnz	short loc_1D13C
		jmp	scr_fin_2b
; ---------------------------------------------------------------------------

loc_1D13C:				; CODE XREF: seg007:84C7j
		cmp	ax, 5C5Ch	; stop at double-backslash (\\)	as well
		jnz	short loc_1D144
		jmp	scr_fin_2b
; ---------------------------------------------------------------------------

loc_1D144:				; CODE XREF: seg007:84CFj
		push	ax
		call	ShiftJIS2JIS
		add	sp, 2
		push	ax
		call	PrintFontChar
		add	sp, 2
		jmp	short loc_1D12E
; ---------------------------------------------------------------------------

scr3C_PrintNum_H_5Dig:			; DATA XREF: seg007:scrJumpTblo
		mov	cs:tempVar0, 0	; print	number with 5 half-width digits
		cmp	word ptr [si], 0FFFFh ;	(right-aligned,	padded with spaces)
		jz	short loc_1D16F
		mov	ax, seg	dseg
		mov	es, ax
		mov	ax, [si]
		mov	es:textDrawPtr,	ax

loc_1D16F:				; CODE XREF: seg007:84F2j
		add	si, 2
		call	GetScriptVarVal
		mov	ax, cs:[di]
		xor	dx, dx
		mov	bx, 10000
		div	bx
		call	PrintDigit_HPS
		mov	ax, dx
		xor	dx, dx
		mov	bx, 1000
		div	bx
		call	PrintDigit_HPS
		mov	ax, dx
		xor	dx, dx
		mov	bx, 100
		div	bx
		call	PrintDigit_HPS
		mov	ax, dx
		xor	dx, dx
		mov	bx, 10
		div	bx
		call	PrintDigit_HPS
		mov	ax, dx
		call	PrintDigit_HP
		jmp	scr_fin_2b

; =============== S U B	R O U T	I N E =======================================

; print	digit -	half width, incl. space-padding

PrintDigit_HPS	proc near		; CODE XREF: seg007:850Fp seg007:851Bp ...
		cmp	cs:tempVar0, 1
		jz	short loc_1D1C5
		or	al, al
		jnz	short PrintDigit_HP
		mov	al, 20h		; print	space instead of a 0
		jmp	short loc_1D1C7
PrintDigit_HPS	endp


; =============== S U B	R O U T	I N E =======================================


PrintDigit_HP	proc near		; CODE XREF: seg007:8538p
					; PrintDigit_HPS+Aj
		mov	cs:tempVar0, 1

loc_1D1C5:				; CODE XREF: PrintDigit_HPS+6j
		add	al, '0'

loc_1D1C7:				; CODE XREF: PrintDigit_HPS+Ej
		push	ax
		call	PrintFontChar
		add	sp, 2
		retn
PrintDigit_HP	endp

; ---------------------------------------------------------------------------

scr3D:					; DATA XREF: seg007:scrJumpTblo
		mov	ax, cs
		mov	es, ax
		assume es:seg007
		mov	di, offset word_1DCE4
		mov	cx, 51h
		rep movsw
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

scr3E:					; DATA XREF: seg007:scrJumpTblo
		mov	ax, [si]
		mov	ah, 0Fh
		int	68h		;  - APPC/PC
		jmp	scr_fin_2b
; ---------------------------------------------------------------------------

scr3F_PlaySFX_FM:			; DATA XREF: seg007:scrJumpTblo
		mov	ax, seg	dseg
		mov	es, ax
		assume es:dseg
		test	es:MiscFlags, 10h
		jz	short loc_1D207
		mov	ax, [si]
		or	al, al
		jnz	short loc_1D203
		mov	ah, 0Dh		; routine 0Dh -	stop FM	SFX
		int	60h		; [FM mode] call PMD driver
		jmp	short loc_1D207
; ---------------------------------------------------------------------------

loc_1D203:				; CODE XREF: seg007:858Bj
		mov	ah, 0Ch		; routine 0Ch -	play FM	sound effect
		int	60h		; [FM mode] call PMD driver

loc_1D207:				; CODE XREF: seg007:8585j seg007:8591j
		jmp	scr_fin_2b
; ---------------------------------------------------------------------------

scr40_DiskWait:				; DATA XREF: seg007:scrJumpTblo
		mov	ax, seg	dseg
		mov	es, ax
		test	es:MiscFlags, 1
		jnz	short loc_1D21E

loc_1D218:				; CODE XREF: seg007:85DDj
		add	si, 0Ch
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

loc_1D21E:				; CODE XREF: seg007:85A6j seg007:85DBj
		push	ds
		mov	dx, si		; parameter [si+0..9]: file name of "DISK_ID" file

loc_1D221:				; CODE XREF: seg007:85B7j
		xor	al, al
		mov	ah, 3Dh
		int	21h		; DOS -	2+ - OPEN DISK FILE WITH HANDLE
					; DS:DX	-> ASCIZ filename
					; AL = access mode
					; 0 - read
		jb	short loc_1D221
		push	ax
		mov	bx, ax
		mov	cx, cs
		mov	ds, cx
		assume ds:seg007
		mov	dx, offset tempVar0
		mov	cx, 1
		mov	ah, 3Fh
		int	21h		; DOS -	2+ - READ FROM FILE WITH HANDLE
					; BX = file handle, CX = number	of bytes to read
					; DS:DX	-> buffer
		pop	bx
		mov	ah, 3Eh
		int	21h		; DOS -	2+ - CLOSE A FILE WITH HANDLE
					; BX = file handle
		pop	ds
		assume ds:dseg
		xor	ah, ah
		mov	al, byte ptr cs:tempVar0
		sub	al, 'A'
		cmp	ax, [si+0Ah]	; parameter [si+0Ah]: wanted disk ID
		jnz	short loc_1D21E	; no match - try reading again
		jmp	short loc_1D218	; success - continue
; ---------------------------------------------------------------------------

scr41_ImgCopy4Val:			; DATA XREF: seg007:scrJumpTblo
		push	word ptr [si+8]
		push	word ptr [si+6]
		push	word ptr [si+4]
		push	word ptr [si+2]
		push	word ptr [si]
		call	sub_1416A
		add	sp, 0Ah
		jmp	scr_fin_10b
; ---------------------------------------------------------------------------

scr42_PrintNum_F_5Dig:			; DATA XREF: seg007:scrJumpTblo
		mov	cs:tempVar0, 0	; print	number with 5 full-width digits
		cmp	word ptr [si], 0FFFFh ;	(right-aligned,	padded with spaces)
		jz	short loc_1D27F
		mov	ax, seg	dseg
		mov	es, ax
		mov	ax, [si]
		mov	es:textDrawPtr,	ax

loc_1D27F:				; CODE XREF: seg007:8602j
		add	si, 2
		call	GetScriptVarVal
		mov	ax, cs:[di]
		xor	dx, dx
		mov	bx, 10000
		div	bx
		call	PrintDigit_FPS
		mov	ax, dx
		xor	dx, dx
		mov	bx, 1000
		div	bx
		call	PrintDigit_FPS
		mov	ax, dx
		xor	dx, dx
		mov	bx, 100
		div	bx
		call	PrintDigit_FPS
		mov	ax, dx
		xor	dx, dx
		mov	bx, 10
		div	bx
		call	PrintDigit_FPS
		mov	ax, dx
		call	PrintDigit_FP
		jmp	scr_fin_2b

; =============== S U B	R O U T	I N E =======================================

; print	digit -	full width, incl. space-padding

PrintDigit_FPS	proc near		; CODE XREF: seg007:861Fp seg007:862Bp ...
		cmp	cs:tempVar0, 1
		jz	short loc_1D2D6
		or	ax, ax
		jnz	short PrintDigit_FP
		mov	ax, 4081h	; Shift-JIS full-width space
		jmp	short loc_1D2DB
PrintDigit_FPS	endp


; =============== S U B	R O U T	I N E =======================================


PrintDigit_FP	proc near		; CODE XREF: seg007:8648p
					; PrintDigit_FPS+Aj ...
		mov	cs:tempVar0, 1

loc_1D2D6:				; CODE XREF: PrintDigit_FPS+6j
		xchg	al, ah
		add	ax, 4F82h	; Shift-JIS full-width '0'

loc_1D2DB:				; CODE XREF: PrintDigit_FPS+Fj
		push	ax
		call	ShiftJIS2JIS
		add	sp, 2
		push	ax
		call	PrintFontChar
		add	sp, 2
		retn
PrintDigit_FP	endp

; ---------------------------------------------------------------------------

scr43_VarMulValDiv100:			; DATA XREF: seg007:scrJumpTblo
		call	GetScriptVarVal
		mov	bx, ax
		mov	ax, cs:[di]	; get register contents
		mul	bx		; [parameter] *	[variable] / 100
		mov	cx, 100
		div	cx
		mov	cs:ScriptMemory+6Eh, ax	; store	in variable 37h
		jmp	scr_fin_4b
; ---------------------------------------------------------------------------

scr44:					; DATA XREF: seg007:scrJumpTblo
		xor	ax, ax
		mov	cx, 10h

loc_1D309:				; CODE XREF: seg007:86A3j
		push	ax
		call	sub_142DC
		add	sp, 2
		inc	ax
		loop	loc_1D309
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

scr45_Print6Var_F:			; DATA XREF: seg007:scrJumpTblo
		mov	cs:tempVar0, 0	; print	digits from 6 consecutive variables
		mov	ax, seg	dseg	; as full-width	digits
		mov	es, ax
		mov	ax, [si]
		mov	es:textDrawPtr,	ax
		add	si, 2
		call	GetScriptVarVal
		mov	ax, cs:[di]
		call	PrintDigit_FPS
		mov	ax, cs:[di+2]
		call	PrintDigit_FPS
		mov	ax, cs:[di+4]
		call	PrintDigit_FPS
		mov	ax, cs:[di+6]
		call	PrintDigit_FPS
		mov	ax, cs:[di+8]
		call	PrintDigit_FPS
		mov	ax, cs:[di+0Ah]
		call	PrintDigit_FP
		jmp	scr_fin_2b
; ---------------------------------------------------------------------------

scr46_VarDigitsAdd:			; DATA XREF: seg007:scrJumpTblo
		call	GetScriptVarVal

loc_1D35F:				; CODE XREF: seg007:888Fj
		call	Number2Digits
		mov	ax, cs:[di+0Ah]
		add	ax, cs:tempVar4
		cmp	ax, 10
		jb	short loc_1D377
		sub	ax, 10
		inc	word ptr cs:[di+8]

loc_1D377:				; CODE XREF: seg007:86FEj
		mov	cs:[di+0Ah], ax
		mov	ax, cs:[di+8]
		add	ax, cs:tempVar3
		cmp	ax, 10
		jb	short loc_1D390
		sub	ax, 10
		inc	word ptr cs:[di+6]

loc_1D390:				; CODE XREF: seg007:8717j
		mov	cs:[di+8], ax
		mov	ax, cs:[di+6]
		add	ax, cs:tempVar2
		cmp	ax, 10
		jb	short loc_1D3A9
		sub	ax, 10
		inc	word ptr cs:[di+4]

loc_1D3A9:				; CODE XREF: seg007:8730j
		mov	cs:[di+6], ax
		mov	ax, cs:[di+4]
		add	ax, cs:tempVar1
		cmp	ax, 10
		jb	short loc_1D3C2
		sub	ax, 10
		inc	word ptr cs:[di+2]

loc_1D3C2:				; CODE XREF: seg007:8749j
		mov	cs:[di+4], ax
		mov	ax, cs:[di+2]
		add	ax, cs:tempVar0
		cmp	ax, 10
		jb	short loc_1D3DA
		sub	ax, 10
		inc	word ptr cs:[di]

loc_1D3DA:				; CODE XREF: seg007:8762j
		mov	cs:[di+2], ax
		cmp	word ptr cs:[di], 10
		jb	short loc_1D407
		mov	word ptr cs:[di], 9 ; overflow - set all digits	to 9
		mov	word ptr cs:[di+2], 9
		mov	word ptr cs:[di+4], 9
		mov	word ptr cs:[di+6], 9
		mov	word ptr cs:[di+8], 9
		mov	word ptr cs:[di+0Ah], 9

loc_1D407:				; CODE XREF: seg007:8772j
		jmp	scr_fin_4b

; =============== S U B	R O U T	I N E =======================================


Number2Digits	proc near		; CODE XREF: seg007:loc_1D35Fp
					; seg007:loc_1D44Cp
		xor	dx, dx
		mov	bx, 10000
		div	bx
		mov	cs:tempVar0, ax
		mov	ax, dx
		xor	dx, dx
		mov	bx, 1000
		div	bx
		mov	cs:tempVar1, ax
		mov	ax, dx
		xor	dx, dx
		mov	bx, 100
		div	bx
		mov	cs:tempVar2, ax
		mov	ax, dx
		xor	dx, dx
		mov	bx, 10
		div	bx
		mov	cs:tempVar3, ax
		mov	cs:tempVar4, dx
		retn
Number2Digits	endp

; ---------------------------------------------------------------------------

scr47_VarDigitsSub:			; DATA XREF: seg007:scrJumpTblo
		mov	cs:ScriptMemory+6Eh, 0
		call	GetScriptVarVal

loc_1D44C:				; CODE XREF: seg007:88ADj
		call	Number2Digits
		mov	ax, cs:[di+0Ah]
		sub	ax, cs:tempVar4
		or	ax, ax
		jns	short loc_1D463
		add	ax, 10
		dec	word ptr cs:[di+8]

loc_1D463:				; CODE XREF: seg007:87EAj
		mov	cs:[di+0Ah], ax
		mov	ax, cs:[di+8]
		sub	ax, cs:tempVar3
		or	ax, ax
		jns	short loc_1D47B
		add	ax, 10
		dec	word ptr cs:[di+6]

loc_1D47B:				; CODE XREF: seg007:8802j
		mov	cs:[di+8], ax
		mov	ax, cs:[di+6]
		sub	ax, cs:tempVar2
		or	ax, ax
		jns	short loc_1D493
		add	ax, 10
		dec	word ptr cs:[di+4]

loc_1D493:				; CODE XREF: seg007:881Aj
		mov	cs:[di+6], ax
		mov	ax, cs:[di+4]
		sub	ax, cs:tempVar1
		or	ax, ax
		jns	short loc_1D4AB
		add	ax, 10
		dec	word ptr cs:[di+2]

loc_1D4AB:				; CODE XREF: seg007:8832j
		mov	cs:[di+4], ax
		mov	ax, cs:[di+2]
		sub	ax, cs:tempVar0
		or	ax, ax
		jns	short loc_1D4C2
		add	ax, 10
		dec	word ptr cs:[di]

loc_1D4C2:				; CODE XREF: seg007:884Aj
		mov	cs:[di+2], ax
		mov	ax, cs:[di]
		or	ax, ax
		jns	short loc_1D4D4
		mov	cs:ScriptMemory+6Eh, 0FFFFh

loc_1D4D4:				; CODE XREF: seg007:885Bj
		mov	cs:[di], ax
		jmp	scr_fin_4b
; ---------------------------------------------------------------------------

scr48:					; DATA XREF: seg007:scrJumpTblo
		mov	ax, seg	dseg
		mov	es, ax
		test	es:MiscFlags, 1
		jnz	short loc_1D4F2
		mov	cs:ScriptMemory+6Eh, 0
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

loc_1D4F2:				; CODE XREF: seg007:8876j
		mov	cs:ScriptMemory+6Eh, 1
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

scr49_VarDigitsAdd:			; DATA XREF: seg007:scrJumpTblo
		call	sub_1D502
		jmp	loc_1D35F

; =============== S U B	R O U T	I N E =======================================


sub_1D502	proc near		; CODE XREF: seg007:scr49_VarDigitsAddp
					; seg007:88AAp
		call	GetScriptVarVal
		mov	bx, offset ScriptMemory
		mov	ax, [si+2]
		add	ax, ax
		add	bx, ax
		mov	ax, cs:[bx]
		retn
sub_1D502	endp

; ---------------------------------------------------------------------------

scr4A_VarDigitsSub:			; DATA XREF: seg007:scrJumpTblo
		mov	cs:ScriptMemory+6Eh, 0
		call	sub_1D502
		jmp	loc_1D44C
; ---------------------------------------------------------------------------

scr4B_BGMWaitMeasure:			; DATA XREF: seg007:scrJumpTblo
		mov	ax, seg	dseg
		mov	es, ax
		test	es:MiscFlags, 4
		jz	short loc_1D53E
		mov	bx, [si+2]

loc_1D531:				; CODE XREF: seg007:88CAj
		mov	dx, 0C0h
		mov	ah, 5		; routine 05h -	get song measure
		int	61h		; [MIDI	mode] call MMD driver
		cmp	ax, bx
		jb	short loc_1D531
		jmp	short loc_1D551
; ---------------------------------------------------------------------------

loc_1D53E:				; CODE XREF: seg007:88BCj
		test	es:MiscFlags, 8
		jz	short loc_1D551
		mov	bx, [si]

loc_1D549:				; CODE XREF: seg007:88DFj
		mov	ah, 5		; routine 05h -	get song measure
		int	60h		; [FM mode] call PMD driver
		cmp	ax, bx
		jb	short loc_1D549

loc_1D551:				; CODE XREF: seg007:88CCj seg007:88D5j
		jmp	scr_fin_4b
; ---------------------------------------------------------------------------

scr4C:					; DATA XREF: seg007:scrJumpTblo
		push	0
		call	sub_147D0
		add	sp, 2
		mov	bx, 0
		mov	cx, 400
		mov	dx, 0

loc_1D567:				; CODE XREF: seg007:891Cj
		call	WaitForVSync
		push	2
		push	bx
		push	1
		push	640
		push	bx
		call	ImageCopy1
		add	sp, 0Ah
		add	dx, 1
		push	dx
		call	sub_147D0
		add	sp, 2
		add	bx, 50h
		loop	loc_1D567
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

scr4D:					; DATA XREF: seg007:scrJumpTblo
		push	0
		call	sub_147D0
		add	sp, 2
		mov	bx, 7CB0h
		mov	cx, 400
		mov	dx, 400

loc_1D5A4:				; CODE XREF: seg007:8959j
		call	WaitForVSync
		push	2
		push	bx
		push	1
		push	640
		push	bx
		call	ImageCopy1
		add	sp, 0Ah
		sub	dx, 1
		push	dx
		call	sub_147D0
		add	sp, 2
		sub	bx, 50h
		loop	loc_1D5A4
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

scr4E_VarVarCompare:			; DATA XREF: seg007:scrJumpTblo
		call	GetScriptVarVar
		cmp	cs:[bx], cx	; cmp var2, var1
		jz	short loc_1D5EC	; var2 == var1 -> 0
		ja	short loc_1D5E2	; var2 > var1 -> 1
		mov	cs:ScriptMemory+6Eh, -1	; var2 < var1 -> -1
		jmp	scr_fin_4b
; ---------------------------------------------------------------------------

loc_1D5E2:				; CODE XREF: seg007:8966j
		mov	cs:ScriptMemory+6Eh, 1
		jmp	scr_fin_4b
; ---------------------------------------------------------------------------

loc_1D5EC:				; CODE XREF: seg007:8964j
		mov	cs:ScriptMemory+6Eh, 0
		jmp	scr_fin_4b
; ---------------------------------------------------------------------------

scr4F_MulVarVal:			; DATA XREF: seg007:scrJumpTblo
		call	GetScriptVarVal
		mov	bx, cs:[di]
		mul	bx		; var *= value
		mov	cs:[di], ax

loc_1D601:				; CODE XREF: seg007:89A4j seg007:89B5j ...
		mov	cs:ScriptMemory+6Eh, dx
		jmp	scr_fin_4b
; ---------------------------------------------------------------------------

scr50_MulVarVar:			; DATA XREF: seg007:scrJumpTblo
		call	GetScriptVarVar
		mov	ax, cs:[bx]
		mul	cx
		mov	cs:[bx], ax
		jmp	short loc_1D601
; ---------------------------------------------------------------------------

scr51_DivVarVal:			; DATA XREF: seg007:scrJumpTblo
		call	GetScriptVarVal
		mov	bx, ax
		mov	ax, cs:[di]
		xor	dx, dx
		div	bx
		mov	cs:[di], ax	; store	quotient
		jmp	short loc_1D601	; store	remainder in ScriptMemory[37h]
; ---------------------------------------------------------------------------

scr52_DivVarVar:			; DATA XREF: seg007:scrJumpTblo
		call	GetScriptVarVar
		mov	ax, cs:[bx]
		xor	dx, dx
		div	cx
		mov	cs:[bx], ax
		jmp	short loc_1D601
; ---------------------------------------------------------------------------

scr53_GetItemData:			; DATA XREF: seg007:scrJumpTblo
		call	GetScriptVarVal
		mov	ax, cs:[di]
		mov	bx, 24h
		mul	bx
		mov	bx, offset ItemData
		add	bx, ax
		push	ds
		push	si
		mov	ax, cs
		mov	ds, ax
		assume ds:seg007
		mov	si, bx
		mov	es, ax
		assume es:seg007
		mov	di, offset CurItemData ; copy to ScriptMemory+238Ch
		mov	cx, 12h
		rep movsw
		pop	si
		pop	ds
		assume ds:dseg
		jmp	scr_fin_2b
; ---------------------------------------------------------------------------

scr54_GetMonsterData:			; DATA XREF: seg007:scrJumpTblo
		call	GetScriptVarVal
		mov	ax, cs:[di]
		mov	bx, 48h
		mul	bx
		mov	bx, offset MonsterData
		add	bx, ax
		push	ds
		push	si
		mov	ax, cs
		mov	ds, ax
		assume ds:seg007
		mov	si, bx
		mov	es, ax
		mov	di, offset CurMonsterData ; copy to ScriptMemory+4EEEh
		mov	cx, 24h
		rep movsw
		pop	si
		pop	ds
		assume ds:dseg
		jmp	scr_fin_2b
; ---------------------------------------------------------------------------

scr55_ImgCopy1Var:			; DATA XREF: seg007:scrJumpTblo
		call	GetScriptVarVal
		mov	ax, cs:[di]
		mov	cs:tempVar0, ax
		add	si, 2
		call	GetScriptVarVal
		mov	bx, cs:[di]
		add	si, 2
		call	GetScriptVarVal
		mov	cx, cs:[di]
		add	si, 2
		call	GetScriptVarVal
		mov	dx, cs:[di]
		add	si, 2
		call	GetScriptVarVal
		mov	di, cs:[di]
		push	di
		push	dx
		push	cx
		push	bx
		push	cs:tempVar0
		call	ImageCopy1
		add	sp, 0Ah
		jmp	scr_fin_2b
; ---------------------------------------------------------------------------

scr56_ImgCopy2Var:			; DATA XREF: seg007:scrJumpTblo
		call	GetScriptVarVal
		mov	bx, cs:[di]
		add	si, 2
		call	GetScriptVarVal
		mov	cx, cs:[di]
		add	si, 2
		call	GetScriptVarVal
		mov	dx, cs:[di]
		add	si, 2
		call	GetScriptVarVal
		mov	di, cs:[di]
		push	2
		push	di
		push	dx
		push	cx
		push	bx
		call	WaitForVSync
		call	ImageCopy1
		add	sp, 0Ah
		jmp	scr_fin_2b
; ---------------------------------------------------------------------------

scr57_ImgFXVar:				; DATA XREF: seg007:scrJumpTblo
		call	GetScriptVarVal
		mov	ax, cs:[di]
		mov	cs:tempVar0, ax
		add	si, 2
		call	GetScriptVarVal
		mov	bx, cs:[di]
		add	si, 2
		call	GetScriptVarVal
		mov	cx, cs:[di]
		add	si, 2
		call	GetScriptVarVal
		mov	dx, cs:[di]
		add	si, 2
		call	GetScriptVarVal
		mov	di, cs:[di]
		push	di
		push	dx
		push	cx
		push	bx
		push	cs:tempVar0
		call	ImageCopy2
		add	sp, 0Ah
		jmp	scr_fin_2b
; ---------------------------------------------------------------------------

scr58_ImgCopy3Var:			; DATA XREF: seg007:scrJumpTblo
		call	GetScriptVarVal
		mov	ax, cs:[di]
		mov	cs:tempVar0, ax
		add	si, 2
		call	GetScriptVarVal
		mov	bx, cs:[di]
		add	si, 2
		call	GetScriptVarVal
		mov	cx, cs:[di]
		add	si, 2
		call	GetScriptVarVal
		mov	dx, cs:[di]
		add	si, 2
		call	GetScriptVarVal
		mov	di, cs:[di]
		mov	ax, cs:ScriptMemory+2Ah	; get ScriptMemory[15h]
		shl	ax, 4
		or	ax, di
		push	ax
		push	dx
		push	cx
		push	bx
		push	cs:tempVar0
		call	ImageCopy3
		add	sp, 0Ah
		jmp	scr_fin_2b
; ---------------------------------------------------------------------------

scr59_LoadGTA:				; DATA XREF: seg007:scrJumpTblo
		call	GetScriptVarVal
		mov	bx, di
		add	si, 2
		call	GetScriptVarVal
		mov	cx, cs:[di]
		add	si, 2
		call	GetScriptVarVal
		mov	dx, cs:[di]
		pusha
		push	dx
		push	cx
		push	cs		; file name segment
		push	bx		; file name pointer
		call	LoadGTAFile
		add	sp, 8
		popa
		jmp	scr_fin_2b
; ---------------------------------------------------------------------------

scr5A_VarRandomVar:			; DATA XREF: seg007:scrJumpTblo
		call	GetScriptVarVar
		push	bx
		push	cx
		push	si
		push	di
		push	ds
		push	es
		call	RNG_GetNext
		pop	es
		assume es:nothing
		pop	ds
		pop	di
		pop	si
		pop	cx
		pop	bx
		xor	dx, dx
		div	cx
		mov	cs:[bx], dx
		jmp	scr_fin_4b
; ---------------------------------------------------------------------------

scr5B_GetDiskID:			; DATA XREF: seg007:scrJumpTblo
		mov	ax, seg	dseg
		mov	es, ax
		assume es:dseg
		test	es:MiscFlags, 1
		jnz	short loc_1D7E1
		jmp	scr_fin_10b
; ---------------------------------------------------------------------------

loc_1D7E1:				; CODE XREF: seg007:8B6Cj
		push	ds
		mov	dx, si

loc_1D7E4:				; CODE XREF: seg007:8B7Aj
		xor	al, al
		mov	ah, 3Dh
		int	21h		; DOS -	2+ - OPEN DISK FILE WITH HANDLE
					; DS:DX	-> ASCIZ filename
					; AL = access mode
					; 0 - read
		jb	short loc_1D7E4	; try opening the DISK_ID file until it	succeeds
		push	ax
		mov	bx, ax
		mov	cx, cs
		mov	ds, cx
		assume ds:seg007
		mov	dx, offset tempVar0
		mov	cx, 1
		mov	ah, 3Fh
		int	21h		; DOS -	2+ - READ FROM FILE WITH HANDLE
					; BX = file handle, CX = number	of bytes to read
					; DS:DX	-> buffer
		pop	bx
		mov	ah, 3Eh
		int	21h		; DOS -	2+ - CLOSE A FILE WITH HANDLE
					; BX = file handle
		pop	ds
		assume ds:dseg
		xor	ah, ah
		mov	al, byte ptr cs:tempVar0
		sub	al, 'A'
		mov	cs:ScriptMemory+6Eh, ax	; save resulting disk ID
		jmp	scr_fin_10b
; ---------------------------------------------------------------------------

scr5C:					; DATA XREF: seg007:scrJumpTblo
		call	GetScriptVarVal
		push	word ptr cs:[di]
		call	sub_147D0
		add	sp, 2
		jmp	scr_fin_2b
; ---------------------------------------------------------------------------

scr5D_PrintSJIS:			; DATA XREF: seg007:scrJumpTblo
		call	GetScriptVarVal
		mov	cx, cs:[di]
		cmp	cx, 0FFFFh
		jz	short loc_1D838
		mov	ax, seg	dseg
		mov	es, ax
		mov	es:textDrawPtr,	cx

loc_1D838:				; CODE XREF: seg007:8BBCj
		add	si, 2

loc_1D83B:				; CODE XREF: seg007:8BEAj
		mov	ax, [si]
		add	si, 2
		cmp	ax, 5C5Ch	; \\
		jnz	short loc_1D848
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

loc_1D848:				; CODE XREF: seg007:8BD3j
		push	ax
		call	ShiftJIS2JIS
		add	sp, 2
		push	ax
		call	PrintFontChar
		add	sp, 2
		jmp	short loc_1D83B
; ---------------------------------------------------------------------------

scr5E_PrintVarStr:			; DATA XREF: seg007:scrJumpTblo
		call	GetScriptVarVal
		mov	cx, cs:[di]
		cmp	cx, 0FFFFh
		jz	short loc_1D871
		mov	ax, seg	dseg
		mov	es, ax
		mov	es:textDrawPtr,	cx

loc_1D871:				; CODE XREF: seg007:8BF5j
		add	si, 2
		call	GetScriptVarVal

loc_1D877:				; CODE XREF: seg007:8C2Fj
		mov	ax, cs:[di]
		add	di, 2
		cmp	ax, 0
		jnz	short loc_1D885
		jmp	scr_fin_2b
; ---------------------------------------------------------------------------

loc_1D885:				; CODE XREF: seg007:8C10j
		cmp	ax, 5C5Ch	; \\
		jnz	short loc_1D88D
		jmp	scr_fin_2b
; ---------------------------------------------------------------------------

loc_1D88D:				; CODE XREF: seg007:8C18j
		push	ax
		call	ShiftJIS2JIS
		add	sp, 2
		push	ax
		call	PrintFontChar
		add	sp, 2
		jmp	short loc_1D877
; ---------------------------------------------------------------------------

scr5F:					; DATA XREF: seg007:scrJumpTblo
		call	GetScriptVarVal
		mov	bx, [si]
		add	si, 2
		call	GetScriptVarVal
		mov	dx, [si]
		add	si, 2
		call	GetScriptVarVal
		mov	cx, [si]
		add	si, 2
		call	GetScriptVarVal
		mov	di, [si]
		push	si
		mov	si, cx
		mov	ah, 8
		int	68h		;  - APPC/PC
		pop	si
		jmp	scr_fin_2b
; ---------------------------------------------------------------------------

scr60:					; DATA XREF: seg007:scrJumpTblo
		call	sub_1499B
		mov	cx, ax
		mov	ah, 9
		int	68h		;  - APPC/PC
		test	al, 2
		jz	short loc_1D8DB
		or	cx, 10h

loc_1D8DB:				; CODE XREF: seg007:8C66j
		test	al, 1
		jz	short loc_1D8E2
		or	cx, 20h

loc_1D8E2:				; CODE XREF: seg007:8C6Dj
		mov	ah, 5
		int	68h		;  - APPC/PC - TRANSFER	MSG DATA
					; DS:DX	-> control block
		mov	cs:ScriptMemory+2Ch, cx
		mov	cs:ScriptMemory+2Eh, bx
		mov	cs:ScriptMemory+30h, dx
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

scr61_PrintNum_H:			; DATA XREF: seg007:scrJumpTblo
		mov	cs:tempVar0, 0
		cmp	word ptr [si], 0FFFFh
		jz	short loc_1D90F
		mov	ax, seg	dseg
		mov	es, ax
		assume es:nothing
		mov	ax, [si]
		mov	es:textDrawPtr,	ax

loc_1D90F:				; CODE XREF: seg007:8C92j
		add	si, 2
		call	GetScriptVarVal
		mov	ax, cs:[di]
		xor	dx, dx
		mov	bx, 10000
		div	bx
		call	PrintDigit_HNS
		mov	ax, dx
		xor	dx, dx
		mov	bx, 1000
		div	bx
		call	PrintDigit_HNS
		mov	ax, dx
		xor	dx, dx
		mov	bx, 100
		div	bx
		call	PrintDigit_HNS
		mov	ax, dx
		xor	dx, dx
		mov	bx, 10
		div	bx
		call	PrintDigit_HNS
		mov	ax, dx
		call	PrintDigit_HN
		jmp	scr_fin_2b

; =============== S U B	R O U T	I N E =======================================

; print	digit -	half width, no padding

PrintDigit_HNS	proc near		; CODE XREF: seg007:8CAFp seg007:8CBBp ...
		cmp	cs:tempVar0, 1
		jz	short loc_1D964
		or	al, al
		jnz	short PrintDigit_HN
		retn
PrintDigit_HNS	endp

; ---------------------------------------------------------------------------
		jmp	short loc_1D966

; =============== S U B	R O U T	I N E =======================================


PrintDigit_HN	proc near		; CODE XREF: seg007:8CD8p
					; PrintDigit_HNS+Aj
		mov	cs:tempVar0, 1

loc_1D964:				; CODE XREF: PrintDigit_HNS+6j
		add	al, '0'

loc_1D966:				; CODE XREF: seg007:8CEBj
		push	ax
		call	PrintFontChar
		add	sp, 2
		retn
PrintDigit_HN	endp

; ---------------------------------------------------------------------------

scr62_PrintNum_F:			; DATA XREF: seg007:scrJumpTblo
		mov	cs:tempVar0, 0
		cmp	word ptr [si], 0FFFFh
		jz	short loc_1D987
		mov	ax, seg	dseg
		mov	es, ax
		assume es:dseg
		mov	ax, [si]
		mov	es:textDrawPtr,	ax

loc_1D987:				; CODE XREF: seg007:8D0Aj
		add	si, 2
		call	GetScriptVarVal
		mov	ax, cs:[di]
		xor	dx, dx
		mov	bx, 10000
		div	bx
		call	PrintDigit_FNS
		mov	ax, dx
		xor	dx, dx
		mov	bx, 1000
		div	bx
		call	PrintDigit_FNS
		mov	ax, dx
		xor	dx, dx
		mov	bx, 100
		div	bx
		call	PrintDigit_FNS
		mov	ax, dx
		xor	dx, dx
		mov	bx, 10
		div	bx
		call	PrintDigit_FNS
		mov	ax, dx
		call	PrintDigit_FP
		jmp	scr_fin_2b

; =============== S U B	R O U T	I N E =======================================

; print	digit -	full width, no padding

PrintDigit_FNS	proc near		; CODE XREF: seg007:8D27p seg007:8D33p ...
		cmp	cs:tempVar0, 1
		jz	short loc_1D9DA
		or	ax, ax
		jnz	short PrintDigit_FN
		retn
; ---------------------------------------------------------------------------

PrintDigit_FN:				; CODE XREF: PrintDigit_FNS+Aj
		mov	cs:tempVar0, 1

loc_1D9DA:				; CODE XREF: PrintDigit_FNS+6j
		xchg	al, ah
		add	ax, 4F82h	; Shift-JIS full-width '0'
		push	ax
		call	ShiftJIS2JIS
		add	sp, 2
		push	ax
		call	PrintFontChar
		add	sp, 2
		retn
PrintDigit_FNS	endp


; =============== S U B	R O U T	I N E =======================================


scr63_SetDiskLetter proc near		; CODE XREF: LoadScript+14p
					; seg007:719Ap
					; DATA XREF: ...
		push	ax
		push	si
		push	es
		mov	ax, seg	dseg
		mov	es, ax
		test	es:MiscFlags, 1
		jnz	short loc_1DA19

loc_1DA03:				; CODE XREF: scr63_SetDiskLetter+1Cj
		cmp	byte ptr [si], ':'
		jz	short loc_1DA10
		cmp	byte ptr [si], 0
		jz	short loc_1DA19
		inc	si
		jmp	short loc_1DA03
; ---------------------------------------------------------------------------

loc_1DA10:				; CODE XREF: scr63_SetDiskLetter+14j
		mov	ah, 19h
		int	21h		; DOS -	GET DEFAULT DISK NUMBER
		add	al, 'A'
		mov	[si-1],	al

loc_1DA19:				; CODE XREF: scr63_SetDiskLetter+Fj
					; scr63_SetDiskLetter+19j
		pop	es
		assume es:nothing
		pop	si
		pop	ax
		retn
scr63_SetDiskLetter endp


; =============== S U B	R O U T	I N E =======================================


GetMapDataPtr	proc near		; CODE XREF: seg007:scr24_ReadMapp
					; seg007:scr2E_WriteMapp ...
		mov	ax, cs:ScriptMemory+1Eh	; AX = ScriptMemory[0Fh] = floor index
		mov	dx, 200h
		mul	dx
		add	ax, (offset ScriptMemory+3E8h)
		mov	dx, ax		; DX = &ScriptMemory[500 + AX*100h]
		call	GetScriptVarVal
		mov	bx, cs:[di]	; read variable	1 value	to get X
		add	si, 2
		call	GetScriptVarVal
		mov	cx, cs:[di]	; read variable	2 value	to get Y
		shl	cx, 4
		add	bx, cx
		add	bx, bx
		add	bx, dx		; BX = &DX[Y * 0x10 + X]
		mov	ax, cs:[bx]
		retn
GetMapDataPtr	endp

; ---------------------------------------------------------------------------
		retn

; =============== S U B	R O U T	I N E =======================================


GetScriptVarVal	proc near		; CODE XREF: seg007:scr07_VarSetValp
					; seg007:scr09_VarAddValp ...
		mov	di, offset ScriptMemory
		mov	ax, [si]	; read variable	ID
		add	ax, ax		; ID ->	offset into 2-byte values
		add	di, ax		; DI = &ScriptMemory[varID]
		mov	ax, [si+2]	; AX = next value
		retn
GetScriptVarVal	endp


; =============== S U B	R O U T	I N E =======================================


GetScriptVarVar	proc near		; CODE XREF: seg007:scr08_VarSetVarp
					; seg007:scr0A_VarAddVarp ...
		mov	di, offset ScriptMemory
		mov	bx, di
		mov	ax, [si]	; read variable	ID
		add	ax, ax		; ID ->	offset into 2-byte values
		add	di, ax		; DI = &ScriptMemory[varID1]
		mov	cx, cs:[di]	; CX = content of variable
		mov	ax, [si+2]	; read variable	ID
		add	ax, ax		; ID ->	offset into 2-byte values
		add	bx, ax		; BX = &ScriptMemory[varID2]
		retn
GetScriptVarVar	endp


; =============== S U B	R O U T	I N E =======================================


sub_1DA6B	proc near		; CODE XREF: seg007:loc_1CA0Ep
		mov	cs:tempVar2, ax
		shl	ax, 4
		mov	dx, 50h
		mul	dx
		mov	cx, cs:tempVar5
		add	cx, ax
		add	ax, 28h
		push	2
		push	cx
		push	10h
		push	cs:tempVar3
		push	ax
		call	ImageCopy1
		add	sp, 0Ah
		retn
sub_1DA6B	endp


; =============== S U B	R O U T	I N E =======================================


sub_1DA95	proc near		; CODE XREF: seg007:7D66p seg007:7D8Ep ...
		mov	ah, 4
		int	68h		;  - APPC/PC
					; DS:DX	-> control block
		mov	bx, cs:tempVar2
		mov	ax, bx
		shl	bx, 4
		push	ax
		mov	ax, bx
		mov	dx, 50h
		mul	dx
		mov	bx, ax
		pop	ax
		mov	cx, cs:tempVar5
		add	cx, bx
		push	2
		push	cx
		push	10h
		push	cs:tempVar3
		push	bx
		call	ImageCopy1
		add	sp, 0Ah
		retn
sub_1DA95	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

WaitFrames	proc near		; CODE XREF: seg007:7146p seg007:725Cp ...

arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		push	cx
		mov	cx, [bp+arg_0]
		or	cx, cx
		jz	short loc_1DADB

loc_1DAD4:				; CODE XREF: WaitFrames+10j
		call	WaitForVSync
		loop	loc_1DAD4

loc_1DADB:				; CODE XREF: WaitFrames+9j
		pop	cx
		pop	bp
		retn
WaitFrames	endp

; ---------------------------------------------------------------------------

loc_1DADE:				; DATA XREF: seg007:off_14E77o
		pushf
		pusha
		push	es
		push	ds
		cmp	cs:word_1BCA8, 0
		jz	short loc_1DAEC
		jmp	short loc_1DB3D
; ---------------------------------------------------------------------------

loc_1DAEC:				; CODE XREF: seg007:8E78j
		mov	cs:word_1BCA8, 1
		mov	ax, cs:word_1BCA6
		cmp	ax, 25
		jnz	short loc_1DB14
		push	2
		push	cs:word_1BCAA
		push	10h
		push	10h
		push	7800h
		call	ImageCopy1
		add	sp, 0Ah
		jmp	short loc_1DB31
; ---------------------------------------------------------------------------

loc_1DB14:				; CODE XREF: seg007:8E8Aj
		cmp	ax, 50
		jnz	short loc_1DB31
		push	2
		push	cs:word_1BCAA
		push	10h
		push	10h
		push	7802h
		call	ImageCopy1
		add	sp, 0Ah
		xor	ax, ax

loc_1DB31:				; CODE XREF: seg007:8EA2j seg007:8EA7j
		inc	ax
		mov	cs:word_1BCA6, ax
		mov	cs:word_1BCA8, 0

loc_1DB3D:				; CODE XREF: seg007:8E7Aj
		mov	al, 20h
		out	0, al
		pop	ds
		pop	es
		popa
		popf
		iret
; ---------------------------------------------------------------------------

loc_1DB46:				; DATA XREF: seg007:off_14E77o
		pushf
		pusha
		push	es
		push	ds
		cmp	cs:word_1BCA8, 0
		jz	short loc_1DB55
		jmp	loc_1DBE1
; ---------------------------------------------------------------------------

loc_1DB55:				; CODE XREF: seg007:8EE0j
		mov	cs:word_1BCA8, 1
		cmp	cs:ScriptMemory+6Ah, 1
		jz	short loc_1DBDA
		mov	cx, cs:word_1BCAC
		mov	di, 6
		mov	ax, cx
		add	ax, ax
		add	di, ax
		shl	ax, 2
		add	di, ax
		mov	ax, cs:word_1BCA6
		cmp	ax, cs:[di]
		jnz	short loc_1DBD0
		push	ax
		mov	ah, 9
		int	68h		;  - APPC/PC
		test	al, 4
		jnz	short loc_1DBA3
		push	word ptr cs:[di+8]
		push	word ptr cs:[di+6]
		push	word ptr cs:[di+4]
		push	word ptr cs:[di+2]
		call	sub_13EF4
		add	sp, 8
		jmp	short loc_1DBC3
; ---------------------------------------------------------------------------

loc_1DBA3:				; CODE XREF: seg007:8F17j
		mov	ah, 4
		int	68h		;  - APPC/PC
					; DS:DX	-> control block
		push	word ptr cs:[di+8]
		push	word ptr cs:[di+6]
		push	word ptr cs:[di+4]
		push	word ptr cs:[di+2]
		call	sub_13EF4
		add	sp, 8
		mov	ah, 3
		int	68h		;  - APPC/PC
					; DS:DX	-> control block

loc_1DBC3:				; CODE XREF: seg007:8F31j
		pop	ax
		inc	cx
		cmp	cx, cs:word_14C74
		jnz	short loc_1DBD0
		xor	ax, ax
		xor	cx, cx

loc_1DBD0:				; CODE XREF: seg007:8F0Ej seg007:8F5Aj
		inc	ax
		mov	cs:word_1BCA6, ax
		mov	cs:word_1BCAC, cx

loc_1DBDA:				; CODE XREF: seg007:8EF2j
		mov	cs:word_1BCA8, 0

loc_1DBE1:				; CODE XREF: seg007:8EE2j
		sti
		mov	al, 20h
		out	0, al
		pop	ds
		pop	es
		popa
		popf
		iret
; ---------------------------------------------------------------------------
		push	ds		; unused
		pusha
		mov	bx, offset a0000 ; "0000\r\n$"
		xor	dx, dx
		mov	cx, 1000h
		div	cx
		cmp	ax, 0Ah
		jnb	short loc_1DC03
		add	al, '0'

loc_1DBFE:				; CODE XREF: seg007:8F95j
		mov	cs:[bx], al
		jmp	short loc_1DC07
; ---------------------------------------------------------------------------

loc_1DC03:				; CODE XREF: seg007:8F8Aj
		add	al, 'A'-0Ah
		jmp	short loc_1DBFE
; ---------------------------------------------------------------------------

loc_1DC07:				; CODE XREF: seg007:8F91j
		mov	ax, dx
		xor	dx, dx
		mov	cx, 100h
		div	cx
		cmp	ax, 0Ah
		jnb	short loc_1DC1D
		add	al, '0'

loc_1DC17:				; CODE XREF: seg007:8FAFj
		mov	cs:[bx+1], al
		jmp	short loc_1DC21
; ---------------------------------------------------------------------------

loc_1DC1D:				; CODE XREF: seg007:8FA3j
		add	al, 'A'-0Ah
		jmp	short loc_1DC17
; ---------------------------------------------------------------------------

loc_1DC21:				; CODE XREF: seg007:8FABj
		mov	ax, dx
		xor	dx, dx
		mov	cx, 10h
		div	cx
		cmp	ax, 0Ah
		jnb	short loc_1DC37
		add	al, '0'

loc_1DC31:				; CODE XREF: seg007:8FC9j
		mov	cs:[bx+2], al
		jmp	short loc_1DC3B
; ---------------------------------------------------------------------------

loc_1DC37:				; CODE XREF: seg007:8FBDj
		add	al, 'A'-0Ah
		jmp	short loc_1DC31
; ---------------------------------------------------------------------------

loc_1DC3B:				; CODE XREF: seg007:8FC5j
		mov	ax, dx
		cmp	ax, 0Ah
		jnb	short loc_1DC4A
		add	al, '0'

loc_1DC44:				; CODE XREF: seg007:8FDCj
		mov	cs:[bx+3], al
		jmp	short loc_1DC4E
; ---------------------------------------------------------------------------

loc_1DC4A:				; CODE XREF: seg007:8FD0j
		add	al, 'A'-0Ah
		jmp	short loc_1DC44
; ---------------------------------------------------------------------------

loc_1DC4E:				; CODE XREF: seg007:8FD8j
		mov	ax, cs
		mov	ds, ax
		assume ds:seg007
		mov	dx, bx
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		popa
		pop	ds
		assume ds:dseg
		retn
; ---------------------------------------------------------------------------
a0000		db '0000',0Dh,0Ah,'$'   ; DATA XREF: seg007:8F7Do
; ---------------------------------------------------------------------------
		push	ds
		pusha
		mov	bx, offset a0000_0 ; "0000 $"
		xor	dx, dx
		mov	cx, 1000h
		div	cx
		cmp	ax, 0Ah
		jnb	short loc_1DC7A
		add	al, '0'

loc_1DC75:				; CODE XREF: seg007:900Cj
		mov	cs:[bx], al
		jmp	short loc_1DC7E
; ---------------------------------------------------------------------------

loc_1DC7A:				; CODE XREF: seg007:9001j
		add	al, 'A'-0Ah
		jmp	short loc_1DC75
; ---------------------------------------------------------------------------

loc_1DC7E:				; CODE XREF: seg007:9008j
		mov	ax, dx
		xor	dx, dx
		mov	cx, 100h
		div	cx
		cmp	ax, 0Ah
		jnb	short loc_1DC94
		add	al, '0'

loc_1DC8E:				; CODE XREF: seg007:9026j
		mov	cs:[bx+1], al
		jmp	short loc_1DC98
; ---------------------------------------------------------------------------

loc_1DC94:				; CODE XREF: seg007:901Aj
		add	al, 'A'-0Ah
		jmp	short loc_1DC8E
; ---------------------------------------------------------------------------

loc_1DC98:				; CODE XREF: seg007:9022j
		mov	ax, dx
		xor	dx, dx
		mov	cx, 10h
		div	cx
		cmp	ax, 0Ah
		jnb	short loc_1DCAE
		add	al, '0'

loc_1DCA8:				; CODE XREF: seg007:9040j
		mov	cs:[bx+2], al
		jmp	short loc_1DCB2
; ---------------------------------------------------------------------------

loc_1DCAE:				; CODE XREF: seg007:9034j
		add	al, 'A'-0Ah
		jmp	short loc_1DCA8
; ---------------------------------------------------------------------------

loc_1DCB2:				; CODE XREF: seg007:903Cj
		mov	ax, dx
		cmp	ax, 0Ah
		jnb	short loc_1DCC1
		add	al, '0'

loc_1DCBB:				; CODE XREF: seg007:9053j
		mov	cs:[bx+3], al
		jmp	short loc_1DCC5
; ---------------------------------------------------------------------------

loc_1DCC1:				; CODE XREF: seg007:9047j
		add	al, 'A'-0Ah
		jmp	short loc_1DCBB
; ---------------------------------------------------------------------------

loc_1DCC5:				; CODE XREF: seg007:904Fj
		mov	ax, cs
		mov	ds, ax
		assume ds:seg007
		mov	dx, bx
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		popa
		pop	ds
		assume ds:dseg
		retn
; ---------------------------------------------------------------------------
a0000_0		db '0000 $'             ; DATA XREF: seg007:8FF4o
		db 8 dup(0)
seg007		ends

; ===========================================================================

; Segment type:	Pure data
dseg		segment	para public 'DATA' use16
		assume cs:dseg
word_1DCE0	dw 0			; DATA XREF: sub_114DE+20r
					; sub_114DE:loc_11539r	...
word_1DCE2	dw 0			; DATA XREF: sub_1147B+Dr sub_114DE+3r ...
word_1DCE4	dw 6F42h		; DATA XREF: sub_1154F+Cr
					; sub_11578+18w ...
word_1DCE6	dw 6C72h		; DATA XREF: sub_1154F+2r sub_1154F+8r ...
word_1DCE8	dw 6E61h		; DATA XREF: sub_1147B+24r
					; sub_114DE+Dw	...
		db 64h,	20h, 43h, 2Bh
off_1DCEE	dw offset nullsub_3	; DATA XREF: sub_10FBD+17r
		dw offset sub_1202D
aCopyright1991B	db 'Copyright 1991 Borland Intl.',0
aDivideError	db 'Divide error',0Dh,0Ah,0
OldIntVec00	dd 0			; DATA XREF: SetupIntVects+6w
					; RestoreIntVects+4r ...
OldIntVec04	dd 0			; DATA XREF: SetupIntVects+13w
					; RestoreIntVects+Fr ...
OldIntVec05a	dd 0			; DATA XREF: SetupIntVects+20w
					; RestoreIntVects+1Ar ...
OldIntVec06a	dd 0			; DATA XREF: SetupIntVects+2Dw
					; RestoreIntVects+25r ...
word_1DD2E	dw 0			; DATA XREF: start+130r seg000:1B46w
word_1DD30	dw 0			; DATA XREF: start+12Cr seg000:1B52w
word_1DD32	dw 0			; DATA XREF: start+128r seg000:1B4Cw
word_1DD34	dw 0			; DATA XREF: start+124r seg000:1BC9w
word_1DD36	dw 0			; DATA XREF: start+120r seg000:1BC3w ...
word_1DD38	dw 0			; DATA XREF: start+46w	seg000:1A3Br
word_1DD3A	dw 0			; DATA XREF: start+1Dw	start+28r ...
word_1DD3C	dw 0			; DATA XREF: start+55w	seg000:1B7Er
word_1DD3E	dw 0			; DATA XREF: start+19w	start+8Fr ...
word_1DD40	dw 0			; DATA XREF: start+16w	start+C7r ...
word_1DD42	dw 0			; DATA XREF: sub_10C86:loc_10CB3w
					; sub_11BCD:loc_11BF9w
		dw 0BF08h
word_1DD46	dw 0			; DATA XREF: sub_11940+7r
					; sub_1197F+4Br
word_1DD48	dw 0			; DATA XREF: start+87w	sub_11940+3r ...
word_1DD4A	dw 0			; DATA XREF: sub_118CA+22w
					; sub_1197F+10r ...
word_1DD4C	dw 0			; DATA XREF: start+8Bw	sub_118CA+1Fw ...
word_1DD4E	dw 0			; DATA XREF: sub_118CA+69w
					; sub_11940+1Ar ...
word_1DD50	dw 0			; DATA XREF: start+21w	start+F5w ...
word_1DD52	dw 1			; DATA XREF: RNG_Init+Cw
					; RNG_GetNext+4r ...
word_1DD54	dw 0			; DATA XREF: RNG_Init+6w RNG_GetNextr	...
aA		db 'A:',0               ; DATA XREF: LoadGTAFile+71o
aGtaExtension1	db '.GTA',0             ; DATA XREF: LoadGTAFile+AEo
aGtaExtension2	db '.GTA',0             ; DATA XREF: LoadGTAFile+107o
a1h5hpc98MimeC1	db 1Bh,'[>1h',1Bh,'[>5hPC98 MIME (C)1995 Studio Twin',27h,'kle',1Bh,'[2J',0
					; DATA XREF: sub_12FB3+9o
aErrorNoMemory_	db 'error : no memory.',0 ; DATA XREF: sub_12FB3+33o
aErrorOptionErr	db 'error : option error',0 ; DATA XREF: sub_12FB3+92o
a1l5l		db 1Bh,'[>1l',1Bh,'[>5l',0 ; DATA XREF: sub_12FB3+123o
aRemainMemoryDk	db 'remain memory : %dKB',0Ah,0 ; DATA XREF: sub_12FB3+132o
aUseMemoryDkb	db '   use memory : %dKB',0Ah,0 ; DATA XREF: sub_12FB3+145o
byte_1DDF2	db 0Ch dup(0)		; DATA XREF: LoadGTAFile+13Eo
byte_1DDFE	db 12h dup(0)		; DATA XREF: sub_1421E+87o
word_1DE10	dw 0			; DATA XREF: seg000:02E0w seg000:037Dr ...
word_1DE12	dw 0			; DATA XREF: seg000:02E4w seg000:0381r
gtaImgWidth	dw 0			; DATA XREF: seg000:0396w seg000:03D4r ...
gtaImgHeight	dw 0			; DATA XREF: seg000:03DEw
byte_1DE18	db 0			; DATA XREF: seg000:02EDw
					; LoadGTAPalette+1r
byte_1DE19	db 0			; DATA XREF: seg000:02E8w seg000:03E9r ...
byte_1DE1A	db 0			; DATA XREF: seg000:03F0r seg000:03FBw ...
		db    0
word_1DE1C	dw 0			; DATA XREF: seg000:03B9w seg000:0568r ...
word_1DE1E	dw 0			; DATA XREF: seg000:0391w
					; sub_10777+19r ...
fHandle		dw 0			; DATA XREF: seg000:036Cw fread+3r ...
word_1DE22	dw 0			; DATA XREF: seg000:03B4w
					; sub_10777+158r
word_1DE24	dw 0			; DATA XREF: seg000:03BFw seg000:0571r ...
fByteCount	dw 0			; DATA XREF: seg000:02FEw fread+Br
		db    0
		db    0
gtaRemLines	dw 0			; DATA XREF: seg000:03E1w
					; sub_10777+14Aw
word_1DE2C	dw 0			; DATA XREF: seg000:03D8w
					; sub_10777:loc_1087Er
byte_1DE2E	db 0BDh	dup(0)		; DATA XREF: ImageCopySetup+Do
		db 74h dup(0)
byte_1DF5F	db 231h	dup(0)		; DATA XREF: sub_13EF4+12o
byte_1E190	db 1B2h	dup(0)
plrName_ScrOfs	dw 0			; DATA XREF: seg007:82D1o seg007:8320o
		db 0C72h dup(0)
		db 2E3Ch dup(0)
byte_21DF2	db 30h dup(0)		; DATA XREF: LoadGTAPalette+21o
					; CopyGTAPalette+Bo
MiscFlags	dw 0			; DATA XREF: LoadGTAFile:loc_12E64r
					; sub_12FB3:loc_1303Dw	...
					; Bit 0	(01h): HDD installation	(disables disk swapping)
					; Bit 2	(04h): music mode: FM (0) / MIDI (1)
					; Bit 3	(08h): music off
gtaNameBuffer	db 80h dup(0)		; DATA XREF: LoadGTAFile+6Eo
					; LoadGTAFile+7Co ...
textDrawPtr	dw 0			; DATA XREF: PrintFontChar+E4r
					; PrintFontChar+16Dw ...
txtColorMain	dw 1			; DATA XREF: PrintFontChar+110r
					; seg007:72AEw	...
txtColorShdw	dw 0			; DATA XREF: PrintFontChar+C3r
					; seg007:72B5w	...
word_21EAA	dw 0			; DATA XREF: sub_1092A+5r
					; sub_1096C+60r ...
word_21EAC	dw 0			; DATA XREF: sub_1092A+15r
					; sub_1096C+75r ...
word_21EAE	dw 0			; DATA XREF: sub_1092A+25r
					; sub_1096C+8Ar ...
word_21EB0	dw 0			; DATA XREF: sub_1092A+35r
					; sub_1096C+9Fr ...
byte_21EB2	db 0			; DATA XREF: sub_1431D+Fw
					; sub_147D0+BBr ...
byte_21EB3	db 30h dup(0)		; DATA XREF: CopyGTAPalette+13o
					; sub_142DC+Co	...
word_21EE3	dw 100			; DATA XREF: sub_140FA:loc_14108r
					; sub_140FA+2Cw ...
word_21EE5	dw 0			; DATA XREF: sub_147D0+4w
					; sub_147D0+39w ...
byte_21EE7	db 0			; DATA XREF: sub_147D0+Aw
word_21EE8	dw 0			; DATA XREF: sub_147D0+Fw
					; sub_147D0+42w ...
word_21EEA	dw 0			; DATA XREF: sub_147D0+15w
byte_21EEC	db 0			; DATA XREF: sub_147D0+1Bw
word_21EED	dw 0			; DATA XREF: sub_147D0+20w
					; sub_147D0+3Ew ...
word_21EEF	dw 0			; DATA XREF: sub_147D0+26w
					; sub_147D0+8Aw
		db    0
ScriptData	db 7800h dup(0)		; DATA XREF: LoadScript+1Co
					; seg007:73A5o	...
scrGtaNameBuf	db '?????',0            ; DATA XREF: seg007:73F6o
byte_296F8	db 8 dup(0)		; DATA XREF: seg007:8393o
aAbnormalProgra	db 'Abnormal program termination',0Dh,0Ah,0 ; DATA XREF: sub_10A1E+1o
		db    0
word_29720	dw 0			; DATA XREF: seg000:0A38r
					; seg000:loc_10A44r ...
		db    0, 20h, 20h, 20h,	20h, 20h, 20h, 20h
		db  20h, 20h, 21h, 21h,	21h, 21h, 21h, 20h
		db  20h, 20h, 20h, 20h,	20h, 20h, 20h, 20h
		db  20h, 20h, 20h, 20h,	20h, 20h, 20h, 20h
		db  20h,   1, 40h, 40h,	40h, 40h, 40h, 40h
		db  40h, 40h, 40h, 40h,	40h, 40h, 40h, 40h
		db  40h,   2,	2,   2,	  2,   2,   2,	 2
		db    2,   2,	2, 40h,	40h, 40h, 40h, 40h
		db  40h, 40h, 14h, 14h,	14h, 14h, 14h, 14h
		db    4,   4,	4,   4,	  4,   4,   4,	 4
		db    4,   4,	4,   4,	  4,   4,   4,	 4
		db    4,   4,	4,   4,	40h, 40h, 40h, 40h
		db  40h, 40h, 18h, 18h,	18h, 18h, 18h, 18h
		db    8,   8,	8,   8,	  8,   8,   8,	 8
		db    8,   8,	8,   8,	  8,   8,   8,	 8
		db    8,   8,	8,   8,	40h, 40h, 40h, 40h
		db  20h,   0,	0,   0,	  0,   0,   0,	 0
		db    0,   0,	0,   0,	  0,   0,   0,	 0
		db    0,   0,	0,   0,	  0,   0,   0,	 0
		db    0,   0,	0,   0,	  0,   0,   0,	 0
		db    0,   0,	0,   0,	  0,   0,   0,	 0
		db    0,   0,	0,   0,	  0,   0,   0,	 0
		db    0,   0,	0,   0,	  0,   0,   0,	 0
		db    0,   0,	0,   0,	  0,   0,   0,	 0
		db    0,   0,	0,   0,	  0,   0,   0,	 0
		db    0,   0,	0,   0,	  0,   0,   0,	 0
		db    0,   0,	0,   0,	  0,   0,   0,	 0
		db    0,   0,	0,   0,	  0,   0,   0,	 0
		db    0,   0,	0,   0,	  0,   0,   0,	 0
		db    0,   0,	0,   0,	  0,   0,   0,	 0
		db    0,   0,	0,   0,	  0,   0,   0,	 0
		db    0,   0,	0,   0,	  0,   0,   0,	 0
		db    0,   0
off_29824	dd nullsub_2		; DATA XREF: sub_10A88+29r
					; sub_124AA+C1w ...
off_29828	dd nullsub_2		; DATA XREF: sub_10A88+41r
off_2982C	dd nullsub_2		; DATA XREF: sub_10A88+45r
unk_29830	db    0			; DATA XREF: seg000:0E80o
		db    0
word_29832	dw 209h			; DATA XREF: seg000:0E5Fw seg000:0E69r
byte_29834	db 0Eh dup(0), 50h, 0BBh, 2 dup(0) ; DATA XREF:	seg000:0E2Bw
					; seg000:loc_10E50r ...
word_29846	dw 20Ah			; DATA XREF: seg000:0E9Bw seg000:0EA5r
byte_29848	db 1, 0Dh dup(0), 64h, 0BBh, 2 dup(0), 3 dup(2), 0Dh dup(0)
					; DATA XREF: seg000:0E8Cr
		db 78h,	0BBh, 2	dup(0),	43h, 2,	3, 0Dh dup(0), 8Ch, 0BBh
		db 2 dup(0), 42h, 2, 4,	0Dh dup(0), 0A0h, 0BBh,	12Ch dup(0)
word_299C0	dw 14h			; DATA XREF: start+C0r	start+E3r ...
byte_299C2	db 1, 60h		; DATA XREF: seek_something+8w
					; seg000:0E1Cw
		db 2, 60h
		db 2, 60h
		db 4, 0A0h
		db 2, 0A0h
		db 1Eh dup(0)
word_299EA	dw 0			; DATA XREF: sub_10C86:loc_10C99w
					; sub_10C86+27w
byte_299EC	db 0, 19, 2, 2,	4, 5, 6, 8, 8, 8, 20, 21, 5, 19, 14, 22
					; DATA XREF: sub_10C86+17r
		db 5, 17, 2, 30, 41, 44, 40, 40, 40, 40, 40, 41, 44, 40
		db 40, 40, 5, 5, 41, 23, 23, 14, 14, 14, 14, 14, 14, 14
		db 14, 14, 14, 14, 14, 14, 15, 44, 35, 2, 44, 15, 42, 40
		db 40, 40, 19, 27, 28, 2, 2, 5,	15, 2, 23, 40, 42, 19
		db 42, 14, 14, 14, 14, 14, 14, 14, 35, 14, 28, 40, 23
		db 35, 37, 19, 40, 0
word_29A46	dw 1000h		; DATA XREF: start+62r	start+70w ...
aNull		db '(null)',0
		align 2
		db 20, 20, 1, 20, 21, 20, 20, 20, 20, 2, 0, 20,	3, 4, 20
		db 9, 5, 5, 5, 5, 5, 5,	5, 5, 5, 20, 20, 20, 20, 20, 20
		db 20, 20, 20, 20, 20, 15, 23, 15, 8, 20, 20, 20, 7, 20
		db 22, 20, 20, 20, 20, 20, 20, 20, 20, 20, 13, 20, 20
		db 20, 20, 20, 20, 20, 20, 20, 20, 16, 10, 15, 15, 15
		db 8, 10, 20, 20, 6, 20, 18, 11, 14, 20, 20, 17, 20, 12
		db 20, 20, 13, 20, 20, 20, 20, 20, 20, 20, 0
aPrintScanfFloa	db 'print scanf : floating point formats not linked',0Dh,0Ah,0
word_29AE2	dw 0			; DATA XREF: sub_118CA+13r
					; sub_118CA+5Cw
word_29AE4	dw 0			; DATA XREF: seg000:1AF8w seg000:1B43r
word_29AE6	dw 0			; DATA XREF: seg000:1B0Bw seg000:1B4Fr
word_29AE8	dw 0			; DATA XREF: seg000:1B0Fw seg000:1B49r
word_29AEA	dw 0			; DATA XREF: seg000:1A10w seg000:1B55r
word_29AEC	dw 0			; DATA XREF: seg000:1A14w seg000:1B3Fr
word_29AEE	dw 0			; DATA XREF: seg000:1A18w seg000:1B3Br
word_29AF0	dw 0			; DATA XREF: seg000:1A21w seg000:1B33r
word_29AF2	dw 0			; DATA XREF: seg000:1A25w seg000:1B37r
dword_29AF4	dd 0			; DATA XREF: seg000:1B8Bw seg000:1BC6r ...
		db  0Dh
		db    0
word_29AFA	dw 0			; DATA XREF: sub_124AA:loc_124E8r
					; sub_124AA+4Cw
word_29AFC	dw 0			; DATA XREF: sub_124AA:loc_124D2r
					; sub_124AA+36w
		db 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31
		dw 0, 1Fh, 3Bh,	5Ah, 78h, 97h, 0B5h, 0D4h, 0F3h, 111h
		dw 130h, 14Eh, 16Dh
word_29B24	dw 0BF04h		; DATA XREF: sub_1296E+D0r
					; sub_1296E+119r ...
seg_29B26	dw seg dseg		; DATA XREF: sub_1296E+CCr
					; sub_1296E+115r
word_29B28	dw 0BF00h		; DATA XREF: sub_1296E+E5r
					; sub_1296E+FFr ...
seg_29B2A	dw seg dseg		; DATA XREF: sub_1296E+E1r
					; sub_1296E+FBr ...
word_29B2C	dw 8170h		; DATA XREF: sub_12640+Fr sub_1276A+Br ...
word_29B2E	dw 0FFFFh		; DATA XREF: sub_12640+Cr sub_1276A+8r ...
word_29B30	dw 0			; DATA XREF: sub_12640+B7r
					; sub_1276A:loc_12864r	...
aTz		db 'TZ',0
aJst		db 'JST',0
		db    0
off_29B3A	dw offset sub_11450	; 0 ; DATA XREF: sub_11A0Ar
		dw offset loc_11455	; 1
		dw offset loc_11455	; 2
		dw offset loc_11455	; 3
		db 0, 2, 15, 14, 0, 0, 0, 16, 16, 26, 0, 0, 0, 16, 117
		db 27, 0, 0, 1,	30
		dd sub_1296E
word_29B5A	dw 0			; DATA XREF: start+B5o	sub_12FB3+B6o
		dw 0
word_29B5E	dw 0			; DATA XREF: seg000:0A56w
					; sub_10A88+19r
byte_29B60	db 7Eh dup(?)		; DATA XREF: seg000:0A52w
byte_29BDE	db 0Ah dup(?)		; DATA XREF: sub_120A6+7w
					; sub_120A6+22r ...
byte_29BE8	db 8 dup(?)		; DATA XREF: start+B8o
dseg		ends

; ===========================================================================

; Segment type:	Uninitialized
seg009		segment	byte stack 'STACK' use16
		assume cs:seg009
		assume es:nothing, ss:nothing, ds:dseg,	fs:nothing, gs:nothing
byte_29BF0	db 1800h dup(?)
seg009		ends


		end start
