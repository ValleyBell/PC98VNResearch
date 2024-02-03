; Input	MD5   :	74D47E0AA673C3B177E0EE816F051973
; Input	CRC32 :	6310625F

; File Name   :	D:\ENDING.EXE
; Format      :	MS-DOS executable (EXE)
; Base Address:	1000h Range: 10000h-19410h Loaded length: 92D2h
; Entry	Point :	1000:0

		.686p
		.mmx
		.model large

; ===========================================================================

; Segment type:	Pure code
seg000		segment	byte public 'CODE' use16
		assume cs:seg000
		assume es:nothing, ss:seg008, ds:nothing, fs:nothing, gs:nothing

; =============== S U B	R O U T	I N E =======================================

; Attributes: noreturn

		public start
start		proc near

; FUNCTION CHUNK AT 01E4 SIZE 00000016 BYTES

		mov	dx, seg	dseg
		mov	cs:dataSeg, dx
		mov	ah, 30h
		int	21h		; DOS -	GET DOS	VERSION
					; Return: AL = major version number (00h for DOS 1.x)
		mov	bp, ds:2
		mov	bx, ds:2Ch
		mov	ds, dx
		assume ds:dseg
		mov	word_1650B, ax
		mov	word_16509, es
		mov	word ptr dword_16503+2,	bx
		mov	word_16519, bp
		call	SetupInts
		les	di, dword_16503
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
		mov	word ptr dword_16503, cx
		mov	cx, 2
		shl	bx, cl
		add	bx, 10h
		and	bx, 0FFF0h
		mov	word_16507, bx
		mov	dx, ss
		sub	bp, dx
		mov	di, word_191C2
		cmp	di, 200h
		jnb	short loc_1006B
		mov	di, 200h
		mov	word_191C2, di

loc_1006B:				; CODE XREF: start+62j
		mov	cl, 4
		shr	di, cl
		inc	di
		cmp	bp, di
		jnb	short loc_10077

loc_10074:				; CODE XREF: start+36j
		jmp	Except_Abort
; ---------------------------------------------------------------------------

loc_10077:				; CODE XREF: start+72j
		mov	bx, di
		add	bx, dx
		mov	word_16511, bx
		mov	word_16515, bx
		mov	ax, word_16509
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
		mov	word_191C2, di
		sti
		xor	ax, ax
		mov	es, cs:dataSeg
		mov	di, offset word_192D2
		mov	cx, offset word_192D2
		sub	cx, di
		cld
		rep stosb
		xor	bp, bp

loc_100B0:
		mov	ax, seg	seg006
		mov	ds, ax
		assume ds:seg006
		mov	si, offset byte_16480
		mov	di, 0Ch
		call	sub_10199
		mov	ds, cs:dataSeg
		assume ds:dseg

loc_100C3:
		mov	byte ptr cs:loc_101AB, 72h ; 'r'
		mov	byte ptr cs:sub_10199+1, 0
		push	word_16501
		push	word_164FF
		push	word_164FD
		push	word_164FB

loc_100DF:
		push	word_164F9
		call	sub_1566E
		push	ax
		call	sub_10294
start		endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: noreturn

sub_100EE	proc near		; CODE XREF: sub_10294+1Fp
		mov	ax, seg	seg006
		mov	ds, ax
		assume ds:seg006
		mov	si, offset byte_1648C
		mov	di, 0Ch
		call	sub_10199
		mov	ds, cs:dataSeg
		assume ds:dseg
		call	off_18FEE
		call	off_18FF2
		call	off_18FF6
		push	ax
sub_100EE	endp ; sp-analysis failed


; =============== S U B	R O U T	I N E =======================================

; Attributes: noreturn

exit		proc near		; CODE XREF: start+1F7p
		mov	ds, cs:dataSeg
		push	cs
		call	near ptr RestoreInts
		mov	bp, sp
		mov	ah, 4Ch
		mov	al, [bp+4]
		int	21h		; DOS -	2+ - QUIT WITH EXIT CODE (EXIT)
exit		endp			; AL = exit code

; ---------------------------------------------------------------------------

Except_DivideErr:			; DATA XREF: SetupInts+3Co
		mov	cx, 0Eh
		mov	dx, offset aDivideError	; "Divide error\r\n"
		jmp	loc_101EA

; =============== S U B	R O U T	I N E =======================================


SetupInts	proc near		; CODE XREF: start+25p
		push	ds
		mov	ax, 3500h
		int	21h		; DOS -	2+ - GET INTERRUPT VECTOR
					; AL = interrupt number
					; Return: ES:BX	= value	of interrupt vector
		mov	word ptr dword_164E9, bx
		mov	word ptr dword_164E9+2,	es
		mov	ax, 3504h
		int	21h		; DOS -	2+ - GET INTERRUPT VECTOR
					; AL = interrupt number
					; Return: ES:BX	= value	of interrupt vector
		mov	word ptr dword_164ED, bx
		mov	word ptr dword_164ED+2,	es
		mov	ax, 3505h
		int	21h		; DOS -	2+ - GET INTERRUPT VECTOR
					; AL = interrupt number
					; Return: ES:BX	= value	of interrupt vector
		mov	word ptr dword_164F1, bx
		mov	word ptr dword_164F1+2,	es
		mov	ax, 3506h
		int	21h		; DOS -	2+ - GET INTERRUPT VECTOR
					; AL = interrupt number
					; Return: ES:BX	= value	of interrupt vector
		mov	word ptr dword_164F5, bx
		mov	word ptr dword_164F5+2,	es
		mov	ax, 2500h
		mov	dx, cs
		mov	ds, dx
		assume ds:seg000
		mov	dx, offset Except_DivideErr
		int	21h		; DOS -	SET INTERRUPT VECTOR
					; AL = interrupt number
					; DS:DX	= new vector to	be used	for specified interrupt
		pop	ds
		assume ds:dseg
		retn
SetupInts	endp


; =============== S U B	R O U T	I N E =======================================


RestoreInts	proc far		; CODE XREF: exit+6p
		push	ds
		mov	ax, 2500h
		lds	dx, dword_164E9
		int	21h		; DOS -	SET INTERRUPT VECTOR
					; AL = interrupt number
					; DS:DX	= new vector to	be used	for specified interrupt
		pop	ds
		push	ds
		mov	ax, 2504h
		lds	dx, dword_164ED
		int	21h		; DOS -	SET INTERRUPT VECTOR
					; AL = interrupt number
					; DS:DX	= new vector to	be used	for specified interrupt
		pop	ds
		push	ds
		mov	ax, 2505h
		lds	dx, dword_164F1
		int	21h		; DOS -	SET INTERRUPT VECTOR
					; AL = interrupt number
					; DS:DX	= new vector to	be used	for specified interrupt
		pop	ds
		push	ds
		mov	ax, 2506h
		lds	dx, dword_164F5
		int	21h		; DOS -	SET INTERRUPT VECTOR
					; AL = interrupt number
					; DS:DX	= new vector to	be used	for specified interrupt
		pop	ds
		retf
RestoreInts	endp


; =============== S U B	R O U T	I N E =======================================


sub_10199	proc near		; CODE XREF: start+BBp	sub_100EE+Bp ...
		mov	ah, 0FFh
		mov	dx, di
		mov	bx, si

loc_1019F:				; CODE XREF: sub_10199+1Cj
		cmp	bx, di
		jz	short loc_101B7
		cmp	byte ptr [bx], 0FFh
		jz	short loc_101B2
		cmp	[bx+1],	ah

loc_101AB:				; DATA XREF: start:loc_100C3w
		ja	short loc_101B2
		mov	ah, [bx+1]
		mov	dx, bx

loc_101B2:				; CODE XREF: sub_10199+Dj
					; sub_10199:loc_101ABj
		add	bx, 6
		jmp	short loc_1019F
; ---------------------------------------------------------------------------

loc_101B7:				; CODE XREF: sub_10199+8j
		cmp	dx, di
		jz	short locret_101DB
		mov	bx, dx
		push	ds
		pop	es
		assume es:dseg
		push	es
		cmp	byte ptr [bx], 0
		mov	byte ptr [bx], 0FFh
		mov	ds, cs:dataSeg
		jz	short loc_101D4
		call	dword ptr es:[bx+2]
		pop	ds
		jmp	short sub_10199
; ---------------------------------------------------------------------------

loc_101D4:				; CODE XREF: sub_10199+32j
		call	word ptr es:[bx+2]
		pop	ds
		jmp	short sub_10199
; ---------------------------------------------------------------------------

locret_101DB:				; CODE XREF: sub_10199+20j
		retn
sub_10199	endp


; =============== S U B	R O U T	I N E =======================================


fwrite_stderr	proc near		; CODE XREF: start+1EFp
		mov	ah, 40h
		mov	bx, 2
		int	21h		; DOS -	2+ - WRITE TO FILE WITH	HANDLE
					; BX = file handle, CX = number	of bytes to write, DS:DX -> buffer
		retn
fwrite_stderr	endp

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR start

Except_Abort:				; CODE XREF: start:loc_10074j
					; seg000:2E11J
		mov	cx, 1Eh
		mov	dx, offset aAbnormalProgra ; "Abnormal program termination\r\n"

loc_101EA:				; CODE XREF: seg000:0126j
		mov	ds, cs:dataSeg
		call	fwrite_stderr
		mov	ax, 3
		push	ax
		push	cs
		call	exit
; END OF FUNCTION CHUNK	FOR start
; ---------------------------------------------------------------------------
dataSeg		dw 0			; DATA XREF: start+3w start+9Er ...
		db    4
		db 0C0h	; À
; ---------------------------------------------------------------------------

loc_101FE:				; CODE XREF: seg000:157AP
		push	bp
		mov	bp, sp
		push	si
		xor	ax, ax
		push	ax
		push	word ptr [bp+8]
		push	word ptr [bp+6]
		call	sub_117B6
		add	sp, 6
		mov	si, ax
		cmp	si, 0FFFFh
		jnz	short loc_1021C
		jmp	short loc_10236
; ---------------------------------------------------------------------------

loc_1021C:				; CODE XREF: seg000:0218j
		test	word ptr [bp+0Ah], 2
		jz	short loc_10229
		test	si, 1
		jnz	short loc_1022D

loc_10229:				; CODE XREF: seg000:0221j
		xor	ax, ax
		jmp	short loc_10236
; ---------------------------------------------------------------------------

loc_1022D:				; CODE XREF: seg000:0227j
		mov	word_1650D, 5
		mov	ax, 0FFFFh

loc_10236:				; CODE XREF: seg000:021Aj seg000:022Bj
		pop	si
		pop	bp
		retf
; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		cmp	word_18EEA, 20h	; ' '
		jnz	short loc_10248
		mov	ax, 1
		jmp	short loc_10264
; ---------------------------------------------------------------------------

loc_10248:				; CODE XREF: seg000:0241j
		mov	bx, word_18EEA
		shl	bx, 1
		shl	bx, 1
		mov	ax, [bp+8]
		mov	dx, [bp+6]
		mov	word ptr dword_192E6[bx], dx
		mov	word ptr (dword_192E6+2)[bx], ax
		inc	word_18EEA
		xor	ax, ax

loc_10264:				; CODE XREF: seg000:0246j
		pop	bp
		retf

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_10266	proc far		; CODE XREF: sub_103E5+63P

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	si, [bp+arg_0]
		or	si, si
		jl	short loc_10276
		cmp	si, 14h
		jl	short loc_1027F

loc_10276:				; CODE XREF: sub_10266+9j
		mov	ax, 6
		push	ax
		call	sub_11AB8
		jmp	short loc_10290
; ---------------------------------------------------------------------------

loc_1027F:				; CODE XREF: sub_10266+Ej
		mov	bx, si
		shl	bx, 1
		mov	word_1918C[bx],	0FFFFh
		push	si
		call	sub_117D3
		pop	cx

loc_10290:				; CODE XREF: sub_10266+17j
		pop	si
		pop	bp
		retf
sub_10266	endp


; =============== S U B	R O U T	I N E =======================================


nullsub_1	proc far		; CODE XREF: sub_100EE+13P
					; sub_100EE+17P ...
		retf
nullsub_1	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: noreturn bp-based	frame

sub_10294	proc far		; CODE XREF: start+E9P

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		jmp	short loc_102A5
; ---------------------------------------------------------------------------

loc_10299:				; CODE XREF: sub_10294+1Aj
		mov	bx, word_18EEA
		shl	bx, 1
		shl	bx, 1
		call	dword_192E6[bx]

loc_102A5:				; CODE XREF: sub_10294+3j
		mov	ax, word_18EEA
		dec	word_18EEA
		or	ax, ax
		jnz	short loc_10299
		push	[bp+arg_0]
		call	sub_100EE
sub_10294	endp

; ---------------------------------------------------------------------------
		pop	cx
		pop	bp
		retf

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_102B9	proc near		; CODE XREF: sub_10339+2Fp
					; sub_10378+5Ap

arg_0		= word ptr  4
arg_2		= word ptr  6

		push	bp
		mov	bp, sp
		push	si
		push	di
		mov	ax, [bp+arg_2]
		inc	ax
		mov	si, ax
		sub	si, word_16509
		mov	ax, si
		add	ax, 3Fh	; '?'
		mov	cl, 6
		shr	ax, cl
		mov	si, ax
		cmp	si, word_18FFA
		jnz	short loc_102EB

loc_102D9:				; CODE XREF: sub_102B9+68j
		mov	ax, [bp+arg_2]
		mov	dx, [bp+arg_0]
		mov	word_16513, dx
		mov	word_16515, ax
		mov	ax, 1
		jmp	short loc_10333
; ---------------------------------------------------------------------------

loc_102EB:				; CODE XREF: sub_102B9+1Ej
		mov	cl, 6
		shl	si, cl
		mov	di, word_16519
		mov	ax, si
		add	ax, word_16509
		cmp	ax, di
		jbe	short loc_10305
		mov	ax, di
		sub	ax, word_16509
		mov	si, ax

loc_10305:				; CODE XREF: sub_102B9+42j
		push	si
		push	word_16509
		call	sub_11F2C
		pop	cx
		pop	cx
		mov	di, ax
		cmp	di, 0FFFFh
		jnz	short loc_10323
		mov	ax, si
		mov	cl, 6
		shr	ax, cl
		mov	word_18FFA, ax
		jmp	short loc_102D9
; ---------------------------------------------------------------------------

loc_10323:				; CODE XREF: sub_102B9+5Dj
		mov	ax, word_16509
		add	ax, di
		mov	word_16517, 0
		mov	word_16519, ax
		xor	ax, ax

loc_10333:				; CODE XREF: sub_102B9+30j
		pop	di
		pop	si
		pop	bp
		retn	4
sub_102B9	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_10339	proc near		; CODE XREF: sub_1285C:loc_128B8p
					; sub_12B75+58p

arg_0		= word ptr  4
arg_2		= word ptr  6

		push	bp
		mov	bp, sp
		mov	cx, word_16511
		mov	bx, word_1650F
		mov	dx, [bp+arg_2]
		mov	ax, [bp+arg_0]
		call	sub_12DC8
		jb	short loc_1036F
		mov	cx, word_16519
		mov	bx, word_16517
		mov	dx, [bp+arg_2]
		mov	ax, [bp+arg_0]
		call	sub_12DC8
		ja	short loc_1036F
		push	[bp+arg_2]
		push	[bp+arg_0]
		call	sub_102B9
		or	ax, ax
		jnz	short loc_10374

loc_1036F:				; CODE XREF: sub_10339+14j
					; sub_10339+27j
		mov	ax, 0FFFFh
		jmp	short loc_10376
; ---------------------------------------------------------------------------

loc_10374:				; CODE XREF: sub_10339+34j
		xor	ax, ax

loc_10376:				; CODE XREF: sub_10339+39j
		pop	bp
		retn
sub_10339	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_10378	proc near		; CODE XREF: sub_129B7+Ap
					; sub_129B7+22p ...

var_8		= word ptr -8
var_6		= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  4
arg_2		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 8
		mov	dx, word_16515
		mov	ax, word_16513
		mov	cx, [bp+arg_2]
		mov	bx, [bp+arg_0]
		call	near ptr sub_12D32
		mov	[bp+var_4], ax
		mov	[bp+var_2], dx
		mov	cx, word_16511
		mov	bx, word_1650F
		mov	ax, [bp+var_4]
		call	sub_12DC8
		jb	short loc_103B7
		mov	cx, word_16519
		mov	bx, word_16517
		mov	dx, [bp+var_2]
		mov	ax, [bp+var_4]
		call	sub_12DC8
		jbe	short loc_103BF

loc_103B7:				; CODE XREF: sub_10378+2Aj
					; sub_10378+61j
		mov	dx, 0FFFFh
		mov	ax, 0FFFFh
		jmp	short loc_103E1
; ---------------------------------------------------------------------------

loc_103BF:				; CODE XREF: sub_10378+3Dj
		mov	ax, word_16515
		mov	dx, word_16513
		mov	[bp+var_8], dx
		mov	[bp+var_6], ax
		push	[bp+var_2]
		push	[bp+var_4]
		call	sub_102B9
		or	ax, ax
		jnz	short loc_103DB
		jmp	short loc_103B7
; ---------------------------------------------------------------------------

loc_103DB:				; CODE XREF: sub_10378+5Fj
		mov	dx, [bp+var_6]
		mov	ax, [bp+var_8]

loc_103E1:				; CODE XREF: sub_10378+45j
		mov	sp, bp
		pop	bp
		retn
sub_10378	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_103E5	proc far		; CODE XREF: fopen2+AFP seg000:07CBP ...

arg_0		= dword	ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	si, 0FFFFh
		les	bx, [bp+arg_0]
		assume es:nothing
		mov	ax, es:[bx+12h]
		cmp	ax, word ptr [bp+arg_0]
		jz	short loc_103FB
		jmp	loc_1048F
; ---------------------------------------------------------------------------

loc_103FB:				; CODE XREF: sub_103E5+11j
		les	bx, [bp+arg_0]
		cmp	word ptr es:[bx+6], 0
		jz	short loc_10438
		cmp	word ptr es:[bx], 0
		jge	short loc_1041E
		push	word ptr [bp+arg_0+2]
		push	word ptr [bp+arg_0]
		call	sub_10494
		pop	cx
		pop	cx
		or	ax, ax
		jz	short loc_1041E
		jmp	short loc_1048F
; ---------------------------------------------------------------------------

loc_1041E:				; CODE XREF: sub_103E5+24j
					; sub_103E5+35j
		les	bx, [bp+arg_0]
		test	word ptr es:[bx+2], 4
		jz	short loc_10438
		push	word ptr es:[bx+0Ah]
		push	word ptr es:[bx+8]
		call	sub_1298E
		pop	cx
		pop	cx

loc_10438:				; CODE XREF: sub_103E5+1Ej
					; sub_103E5+42j
		les	bx, [bp+arg_0]
		cmp	byte ptr es:[bx+4], 0
		jl	short loc_10450
		mov	al, es:[bx+4]
		cbw
		push	ax
		call	sub_10266
		pop	cx
		mov	si, ax

loc_10450:				; CODE XREF: sub_103E5+5Bj
		les	bx, [bp+arg_0]
		mov	word ptr es:[bx+2], 0
		mov	word ptr es:[bx+6], 0
		mov	word ptr es:[bx], 0
		mov	byte ptr es:[bx+4], 0FFh
		cmp	word ptr es:[bx+10h], 0
		jz	short loc_1048F
		xor	ax, ax
		xor	dx, dx
		push	ax
		push	dx
		push	word ptr es:[bx+10h]
		call	sub_114E2
		push	dx
		push	ax
		call	file_remove
		pop	cx
		pop	cx
		les	bx, [bp+arg_0]
		mov	word ptr es:[bx+10h], 0

loc_1048F:				; CODE XREF: sub_103E5+13j
					; sub_103E5+37j ...
		mov	ax, si
		pop	si
		pop	bp
		retf
sub_103E5	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_10494	proc far		; CODE XREF: sub_103E5+2CP
					; sub_10564+28P ...

arg_0		= dword	ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ax, word ptr [bp+arg_0]
		or	ax, word ptr [bp+arg_0+2]
		jnz	short loc_104A8
		call	sub_10564
		jmp	loc_1055F
; ---------------------------------------------------------------------------

loc_104A8:				; CODE XREF: sub_10494+Aj
		les	bx, [bp+arg_0]
		mov	ax, es:[bx+12h]
		cmp	ax, word ptr [bp+arg_0]
		jz	short loc_104BA

loc_104B4:				; CODE XREF: sub_10494+C8j
		mov	ax, 0FFFFh
		jmp	loc_10561
; ---------------------------------------------------------------------------

loc_104BA:				; CODE XREF: sub_10494+1Ej
		les	bx, [bp+arg_0]
		cmp	word ptr es:[bx], 0
		jl	short loc_10511
		test	word ptr es:[bx+2], 8
		jnz	short loc_104E0
		mov	ax, es:[bx+0Eh]
		mov	dx, word ptr [bp+arg_0]
		add	dx, 5
		cmp	ax, word ptr [bp+arg_0+2]
		jnz	short loc_1050F
		cmp	es:[bx+0Ch], dx
		jnz	short loc_1050F

loc_104E0:				; CODE XREF: sub_10494+35j
		les	bx, [bp+arg_0]
		mov	word ptr es:[bx], 0
		mov	ax, es:[bx+0Eh]
		mov	dx, word ptr [bp+arg_0]
		add	dx, 5
		cmp	ax, word ptr [bp+arg_0+2]
		jnz	short loc_1050F
		cmp	es:[bx+0Ch], dx
		jnz	short loc_1050F
		mov	ax, es:[bx+0Ah]
		mov	dx, es:[bx+8]
		mov	es:[bx+0Ch], dx
		mov	es:[bx+0Eh], ax
		jmp	short loc_1055F
; ---------------------------------------------------------------------------

loc_1050F:				; CODE XREF: sub_10494+44j
					; sub_10494+4Aj ...
		jmp	short loc_1055F
; ---------------------------------------------------------------------------

loc_10511:				; CODE XREF: sub_10494+2Dj
		les	bx, [bp+arg_0]
		mov	ax, es:[bx+6]
		add	ax, es:[bx]
		inc	ax
		mov	si, ax
		mov	ax, es:[bx]
		sub	ax, si
		mov	es:[bx], ax
		push	si
		mov	ax, es:[bx+0Ah]
		mov	dx, es:[bx+8]
		mov	es:[bx+0Ch], dx
		mov	es:[bx+0Eh], ax
		push	ax
		push	dx
		mov	al, es:[bx+4]
		cbw
		push	ax
		call	sub_1158F
		add	sp, 8
		cmp	ax, si
		jz	short loc_1055F
		les	bx, [bp+arg_0]
		test	word ptr es:[bx+2], 200h
		jnz	short loc_1055F
		or	word ptr es:[bx+2], 10h
		jmp	loc_104B4
; ---------------------------------------------------------------------------

loc_1055F:				; CODE XREF: sub_10494+11j
					; sub_10494+79j ...
		xor	ax, ax

loc_10561:				; CODE XREF: sub_10494+23j
		pop	si
		pop	bp
		retf
sub_10494	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_10564	proc far		; CODE XREF: sub_10494+CP

var_4		= dword	ptr -4

		push	bp
		mov	bp, sp
		sub	sp, 4
		push	si
		push	di
		xor	di, di
		mov	si, 14h
		mov	word ptr [bp+var_4], offset unk_18FFC
		mov	word ptr [bp+var_4+2], ds
		jmp	short loc_10598
; ---------------------------------------------------------------------------

loc_1057B:				; CODE XREF: sub_10564+39j
		les	bx, [bp+var_4]
		test	word ptr es:[bx+2], 3
		jz	short loc_10594
		push	word ptr [bp+var_4+2]
		push	word ptr [bp+var_4]
		call	sub_10494
		pop	cx
		pop	cx
		inc	di

loc_10594:				; CODE XREF: sub_10564+20j
		add	word ptr [bp+var_4], 14h

loc_10598:				; CODE XREF: sub_10564+15j
		mov	ax, si
		dec	si
		or	ax, ax
		jnz	short loc_1057B
		mov	ax, di
		pop	di
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_10564	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_105A7	proc near		; CODE XREF: fopen2+16p

arg_0		= dword	ptr  4
arg_4		= dword	ptr  8
arg_8		= dword	ptr  0Ch

		push	bp
		mov	bp, sp
		push	si
		push	di
		xor	si, si
		xor	cx, cx
		xor	di, di
		les	bx, [bp+arg_8]
		inc	word ptr [bp+arg_8]
		mov	al, es:[bx]
		mov	dl, al
		cmp	al, 72h	; 'r'
		jnz	short loc_105C9
		mov	si, 1
		mov	di, 1
		jmp	short loc_105E8
; ---------------------------------------------------------------------------

loc_105C9:				; CODE XREF: sub_105A7+18j
		cmp	dl, 77h	; 'w'
		jnz	short loc_105D3
		mov	si, 302h
		jmp	short loc_105DB
; ---------------------------------------------------------------------------

loc_105D3:				; CODE XREF: sub_105A7+25j
		cmp	dl, 61h	; 'a'
		jnz	short loc_105E3
		mov	si, 902h

loc_105DB:				; CODE XREF: sub_105A7+2Aj
		mov	cx, 80h	; '€'
		mov	di, 2
		jmp	short loc_105E8
; ---------------------------------------------------------------------------

loc_105E3:				; CODE XREF: sub_105A7+2Fj
		xor	ax, ax
		jmp	loc_1066D
; ---------------------------------------------------------------------------

loc_105E8:				; CODE XREF: sub_105A7+20j
					; sub_105A7+3Aj
		les	bx, [bp+arg_8]
		mov	al, es:[bx]
		mov	dl, al
		inc	word ptr [bp+arg_8]
		cmp	dl, 2Bh	; '+'
		jz	short loc_1060B
		les	bx, [bp+arg_8]
		cmp	byte ptr es:[bx], 2Bh ;	'+'
		jnz	short loc_10628
		cmp	dl, 74h	; 't'
		jz	short loc_1060B
		cmp	dl, 62h	; 'b'
		jnz	short loc_10628

loc_1060B:				; CODE XREF: sub_105A7+4Fj
					; sub_105A7+5Dj
		cmp	dl, 2Bh	; '+'
		jnz	short loc_10618
		les	bx, [bp+arg_8]
		mov	al, es:[bx]
		mov	dl, al

loc_10618:				; CODE XREF: sub_105A7+67j
		mov	ax, si
		and	ax, 0FFFCh
		or	ax, 4
		mov	si, ax
		mov	cx, 180h
		mov	di, 3

loc_10628:				; CODE XREF: sub_105A7+58j
					; sub_105A7+62j
		cmp	dl, 74h	; 't'
		jnz	short loc_10633
		or	si, 4000h
		jmp	short loc_10651
; ---------------------------------------------------------------------------

loc_10633:				; CODE XREF: sub_105A7+84j
		cmp	dl, 62h	; 'b'
		jnz	short loc_1063E
		or	si, 8000h
		jmp	short loc_1064D
; ---------------------------------------------------------------------------

loc_1063E:				; CODE XREF: sub_105A7+8Fj
		mov	ax, word_191B4
		and	ax, 0C000h
		or	si, ax
		mov	ax, si
		test	ax, 8000h
		jz	short loc_10651

loc_1064D:				; CODE XREF: sub_105A7+95j
		or	di, 40h

loc_10651:				; CODE XREF: sub_105A7+8Aj
					; sub_105A7+A4j
		mov	word ptr off_18FF2, offset loc_116BC
		mov	word ptr off_18FF2+2, seg seg000
		les	bx, [bp+arg_4]
		mov	es:[bx], si
		les	bx, [bp+arg_0]
		mov	ax, cx
		mov	es:[bx], ax
		mov	ax, di

loc_1066D:				; CODE XREF: sub_105A7+3Ej
		pop	di
		pop	si
		pop	bp
		retn	0Ch
sub_105A7	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

fopen2		proc near		; CODE XREF: fopen+2Bp	seg000:07E4p ...

var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  4
arg_2		= word ptr  6
arg_4		= word ptr  8
arg_6		= word ptr  0Ah
arg_8		= dword	ptr  0Ch

		push	bp
		mov	bp, sp
		sub	sp, 4
		push	[bp+arg_2]
		push	[bp+arg_0]
		push	ss
		lea	ax, [bp+var_2]
		push	ax
		push	ss
		lea	ax, [bp+var_4]
		push	ax
		call	sub_105A7
		les	bx, [bp+arg_8]
		mov	es:[bx+2], ax
		or	ax, ax
		jz	short loc_106BD
		cmp	byte ptr es:[bx+4], 0
		jge	short loc_106D1
		push	[bp+var_4]
		push	[bp+var_2]
		push	[bp+arg_6]
		push	[bp+arg_4]
		call	sub_11CB4
		add	sp, 8
		les	bx, [bp+arg_8]
		mov	es:[bx+4], al
		or	al, al
		jge	short loc_106D1

loc_106BD:				; CODE XREF: fopen2+22j
		les	bx, [bp+arg_8]
		mov	byte ptr es:[bx+4], 0FFh
		mov	word ptr es:[bx+2], 0

loc_106CB:				; CODE XREF: fopen2+B6j
		xor	dx, dx
		xor	ax, ax
		jmp	short loc_1073A
; ---------------------------------------------------------------------------

loc_106D1:				; CODE XREF: fopen2+29j fopen2+48j
		les	bx, [bp+arg_8]
		mov	al, es:[bx+4]
		cbw
		push	ax
		call	sub_11AF5
		pop	cx
		or	ax, ax
		jz	short loc_106ED
		les	bx, [bp+arg_8]
		or	word ptr es:[bx+2], 200h

loc_106ED:				; CODE XREF: fopen2+6Fj
		mov	ax, 200h
		push	ax
		les	bx, [bp+arg_8]
		test	word ptr es:[bx+2], 200h
		jz	short loc_10701
		mov	ax, 1
		jmp	short loc_10703
; ---------------------------------------------------------------------------

loc_10701:				; CODE XREF: fopen2+87j
		xor	ax, ax

loc_10703:				; CODE XREF: fopen2+8Cj
		push	ax
		xor	ax, ax
		xor	dx, dx
		push	ax
		push	dx
		push	word ptr [bp+arg_8+2]
		push	word ptr [bp+arg_8]
		call	sub_10FCC
		add	sp, 0Ch
		or	ax, ax
		jz	short loc_1072B
		push	word ptr [bp+arg_8+2]
		push	word ptr [bp+arg_8]
		call	sub_103E5
		pop	cx
		pop	cx
		jmp	short loc_106CB
; ---------------------------------------------------------------------------

loc_1072B:				; CODE XREF: fopen2+A7j
		les	bx, [bp+arg_8]
		mov	word ptr es:[bx+10h], 0
		mov	dx, word ptr [bp+arg_8+2]
		mov	ax, word ptr [bp+arg_8]

loc_1073A:				; CODE XREF: fopen2+5Cj
		mov	sp, bp
		pop	bp
		retn	0Ch
fopen2		endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_10740	proc near		; CODE XREF: fopen+6p seg000:07F5p

var_4		= dword	ptr -4

		push	bp
		mov	bp, sp
		sub	sp, 4
		mov	word ptr [bp+var_4], offset unk_18FFC
		mov	word ptr [bp+var_4+2], ds

loc_1074E:				; CODE XREF: sub_10740+22j
		les	bx, [bp+var_4]
		cmp	byte ptr es:[bx+4], 0
		jl	short loc_10764
		mov	ax, word ptr [bp+var_4]
		add	word ptr [bp+var_4], 14h
		cmp	ax, 2CFCh
		jb	short loc_1074E

loc_10764:				; CODE XREF: sub_10740+16j
		les	bx, [bp+var_4]
		cmp	byte ptr es:[bx+4], 0
		jl	short loc_10774
		xor	dx, dx
		xor	ax, ax
		jmp	short loc_1077A
; ---------------------------------------------------------------------------

loc_10774:				; CODE XREF: sub_10740+2Cj
		mov	dx, word ptr [bp+var_4+2]
		mov	ax, word ptr [bp+var_4]

loc_1077A:				; CODE XREF: sub_10740+32j
		mov	sp, bp
		pop	bp
		retn
sub_10740	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

fopen		proc far		; CODE XREF: sub_1566E+146P
					; sub_1566E+1BAP

var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6
arg_2		= word ptr  8
arg_4		= word ptr  0Ah
arg_6		= word ptr  0Ch

		push	bp
		mov	bp, sp
		sub	sp, 4
		call	sub_10740
		mov	[bp+var_4], ax
		mov	[bp+var_2], dx
		or	ax, dx
		jnz	short loc_10797
		xor	dx, dx
		xor	ax, ax
		jmp	short loc_107AC
; ---------------------------------------------------------------------------

loc_10797:				; CODE XREF: fopen+11j
		push	[bp+var_2]
		push	[bp+var_4]
		push	[bp+arg_2]
		push	[bp+arg_0]
		push	[bp+arg_6]
		push	[bp+arg_4]
		call	fopen2

loc_107AC:				; CODE XREF: fopen+17j
		mov	sp, bp
		pop	bp
		retf
fopen		endp

; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		les	bx, [bp+0Eh]
		mov	ax, es:[bx+12h]
		cmp	ax, [bp+0Eh]
		jz	short loc_107C5
		xor	dx, dx
		xor	ax, ax
		jmp	short loc_107E7
; ---------------------------------------------------------------------------

loc_107C5:				; CODE XREF: seg000:07BDj
		push	word ptr [bp+10h]
		push	word ptr [bp+0Eh]
		call	sub_103E5
		pop	cx
		pop	cx
		push	word ptr [bp+10h]
		push	word ptr [bp+0Eh]
		push	word ptr [bp+8]
		push	word ptr [bp+6]
		push	word ptr [bp+0Ch]
		push	word ptr [bp+0Ah]
		call	fopen2

loc_107E7:				; CODE XREF: seg000:07C3j
		pop	bp
		retf
; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		sub	sp, 4
		cmp	word ptr [bp+6], 0
		jl	short loc_10802
		call	sub_10740
		mov	[bp-4],	ax
		mov	[bp-2],	dx
		or	ax, dx
		jnz	short loc_10808

loc_10802:				; CODE XREF: seg000:07F3j
		xor	dx, dx
		xor	ax, ax
		jmp	short loc_10827
; ---------------------------------------------------------------------------

loc_10808:				; CODE XREF: seg000:0800j
		les	bx, [bp-4]
		mov	al, [bp+6]
		mov	es:[bx+4], al
		push	word ptr [bp-2]
		push	word ptr [bp-4]
		xor	ax, ax
		xor	dx, dx
		push	ax
		push	dx
		push	word ptr [bp+0Ah]
		push	word ptr [bp+8]
		call	fopen2

loc_10827:				; CODE XREF: seg000:0806j
		mov	sp, bp
		pop	bp
		retf

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1082B	proc near		; CODE XREF: sub_10924+3Fp
					; sub_10924+7Ep

var_2		= word ptr -2
arg_0		= dword	ptr  4
arg_4		= word ptr  8
arg_6		= dword	ptr  0Ah

		push	bp
		mov	bp, sp
		dec	sp
		dec	sp
		push	si
		push	di
		mov	di, [bp+arg_4]
		jmp	loc_10913
; ---------------------------------------------------------------------------

loc_10838:				; CODE XREF: sub_1082B+ECj
		inc	di
		les	bx, [bp+arg_0]
		cmp	es:[bx+6], di
		jbe	short loc_10846
		mov	ax, di
		jmp	short loc_1084D
; ---------------------------------------------------------------------------

loc_10846:				; CODE XREF: sub_1082B+15j
		les	bx, [bp+arg_0]
		mov	ax, es:[bx+6]

loc_1084D:				; CODE XREF: sub_1082B+19j
		mov	si, ax
		les	bx, [bp+arg_0]
		test	word ptr es:[bx+2], 40h
		jz	short loc_108C3
		cmp	word ptr es:[bx+6], 0
		jz	short loc_108C3
		cmp	es:[bx+6], di
		jnb	short loc_108C3
		cmp	word ptr es:[bx], 0
		jnz	short loc_108C3
		dec	di
		xor	si, si
		jmp	short loc_1087D
; ---------------------------------------------------------------------------

loc_10872:				; CODE XREF: sub_1082B+59j
		les	bx, [bp+arg_0]
		add	si, es:[bx+6]
		sub	di, es:[bx+6]

loc_1087D:				; CODE XREF: sub_1082B+45j
		les	bx, [bp+arg_0]
		cmp	es:[bx+6], di
		jbe	short loc_10872
		push	si
		push	word ptr [bp+arg_6+2]
		push	word ptr [bp+arg_6]
		mov	al, es:[bx+4]
		cbw
		push	ax
		call	sub_11F10
		add	sp, 8
		mov	[bp+var_2], ax
		add	word ptr [bp+arg_6], ax
		cmp	[bp+var_2], si
		jz	short loc_10913
		mov	ax, si
		sub	ax, [bp+var_2]
		add	di, ax

loc_108AD:				; CODE XREF: sub_1082B+E6j
		les	bx, [bp+arg_0]
		or	word ptr es:[bx+2], 20h
		jmp	short loc_1091A
; ---------------------------------------------------------------------------

loc_108B7:				; CODE XREF: sub_1082B+DEj
		les	bx, [bp+arg_6]
		mov	al, byte ptr [bp+var_2]
		mov	es:[bx], al
		inc	word ptr [bp+arg_6]

loc_108C3:				; CODE XREF: sub_1082B+2Dj
					; sub_1082B+34j ...
		dec	di
		mov	ax, di
		or	ax, ax
		jz	short loc_1090B
		dec	si
		jz	short loc_1090B
		les	bx, [bp+arg_0]
		mov	ax, es:[bx]
		dec	ax
		mov	es:[bx], ax
		or	ax, ax
		jl	short loc_108F6
		mov	ax, es:[bx+0Eh]
		push	ax
		push	bx
		mov	bx, es:[bx+0Ch]
		mov	ax, bx
		pop	bx
		inc	word ptr es:[bx+0Ch]
		mov	bx, ax
		pop	es
		mov	al, es:[bx]
		mov	ah, 0
		jmp	short loc_10903
; ---------------------------------------------------------------------------

loc_108F6:				; CODE XREF: sub_1082B+AEj
		push	word ptr [bp+arg_0+2]
		push	word ptr [bp+arg_0]
		call	sub_11911
		pop	cx
		pop	cx

loc_10903:				; CODE XREF: sub_1082B+C9j
		mov	[bp+var_2], ax
		cmp	ax, 0FFFFh
		jnz	short loc_108B7

loc_1090B:				; CODE XREF: sub_1082B+9Dj
					; sub_1082B+A0j
		cmp	[bp+var_2], 0FFFFh
		jnz	short loc_10913
		jmp	short loc_108AD
; ---------------------------------------------------------------------------

loc_10913:				; CODE XREF: sub_1082B+Aj
					; sub_1082B+79j ...
		or	di, di
		jz	short loc_1091A
		jmp	loc_10838
; ---------------------------------------------------------------------------

loc_1091A:				; CODE XREF: sub_1082B+8Aj
					; sub_1082B+EAj
		mov	ax, di
		pop	di
		pop	si
		mov	sp, bp
		pop	bp
		retn	0Ah
sub_1082B	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_10924	proc far		; CODE XREF: sub_1566E+171P

var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6
arg_2		= word ptr  8
arg_4		= word ptr  0Ah
arg_6		= word ptr  0Ch
arg_8		= word ptr  0Eh
arg_A		= word ptr  10h

		push	bp
		mov	bp, sp
		sub	sp, 4
		push	si
		push	di
		mov	di, [bp+arg_4]
		or	di, di
		jnz	short loc_10937
		xor	ax, ax
		jmp	short loc_109AE
; ---------------------------------------------------------------------------

loc_10937:				; CODE XREF: sub_10924+Dj
		mov	bx, di
		xor	cx, cx
		mov	ax, [bp+arg_6]
		xor	dx, dx
		call	sub_12DB1
		mov	[bp+var_4], ax
		mov	[bp+var_2], dx
		cmp	dx, 1
		ja	short loc_10973
		jb	short loc_10954
		or	ax, ax
		jnb	short loc_10973

loc_10954:				; CODE XREF: sub_10924+2Aj
		push	[bp+arg_2]
		push	[bp+arg_0]
		push	[bp+var_4]
		push	[bp+arg_A]
		push	[bp+arg_8]
		call	sub_1082B
		push	ax
		mov	ax, [bp+var_4]
		pop	dx
		sub	ax, dx
		xor	dx, dx
		div	di
		jmp	short loc_109AE
; ---------------------------------------------------------------------------

loc_10973:				; CODE XREF: sub_10924+28j
					; sub_10924+2Ej
		mov	ax, [bp+arg_6]
		inc	ax
		mov	si, ax
		jmp	short loc_1098E
; ---------------------------------------------------------------------------

loc_1097B:				; CODE XREF: sub_10924+83j
		mov	bx, di
		xor	cx, cx
		mov	dx, [bp+arg_2]
		mov	ax, [bp+arg_0]
		call	near ptr sub_12D32
		mov	[bp+arg_0], ax
		mov	[bp+arg_2], dx

loc_1098E:				; CODE XREF: sub_10924+55j
		dec	si
		mov	ax, si
		or	ax, ax
		jz	short loc_109A9
		push	[bp+arg_2]
		push	[bp+arg_0]
		push	di
		push	[bp+arg_A]
		push	[bp+arg_8]
		call	sub_1082B
		or	ax, ax
		jz	short loc_1097B

loc_109A9:				; CODE XREF: sub_10924+6Fj
		mov	ax, [bp+arg_6]
		sub	ax, si

loc_109AE:				; CODE XREF: sub_10924+11j
					; sub_10924+4Dj
		pop	di
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_10924	endp ; sp-analysis failed


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_109B4	proc near		; CODE XREF: sub_10A38+2Ep
					; seg000:0AE2p	...

var_4		= dword	ptr -4
arg_0		= dword	ptr  4

		push	bp
		mov	bp, sp
		sub	sp, 4
		push	si
		push	di
		les	bx, [bp+arg_0]
		cmp	word ptr es:[bx], 0
		jge	short loc_109CF
		mov	ax, es:[bx+6]
		add	ax, es:[bx]
		inc	ax
		jmp	short loc_109DA
; ---------------------------------------------------------------------------

loc_109CF:				; CODE XREF: sub_109B4+Fj
		les	bx, [bp+arg_0]
		mov	ax, es:[bx]
		cwd
		xor	ax, dx
		sub	ax, dx

loc_109DA:				; CODE XREF: sub_109B4+19j
		mov	si, ax
		mov	di, ax
		les	bx, [bp+arg_0]
		test	word ptr es:[bx+2], 40h
		jz	short loc_109EB
		jmp	short loc_10A2E
; ---------------------------------------------------------------------------

loc_109EB:				; CODE XREF: sub_109B4+33j
		les	bx, [bp+arg_0]
		mov	ax, es:[bx+0Eh]
		mov	dx, es:[bx+0Ch]
		mov	word ptr [bp+var_4], dx
		mov	word ptr [bp+var_4+2], ax
		cmp	word ptr es:[bx], 0
		jge	short loc_10A27
		jmp	short loc_10A11
; ---------------------------------------------------------------------------

loc_10A04:				; CODE XREF: sub_109B4+62j
		dec	word ptr [bp+var_4]
		les	bx, [bp+var_4]
		cmp	byte ptr es:[bx], 0Ah
		jnz	short loc_10A11
		inc	di

loc_10A11:				; CODE XREF: sub_109B4+4Ej
					; sub_109B4+5Aj
		mov	ax, si
		dec	si
		or	ax, ax
		jnz	short loc_10A04
		jmp	short loc_10A2E
; ---------------------------------------------------------------------------

loc_10A1A:				; CODE XREF: sub_109B4+78j
		les	bx, [bp+var_4]
		inc	word ptr [bp+var_4]
		cmp	byte ptr es:[bx], 0Ah
		jnz	short loc_10A27
		inc	di

loc_10A27:				; CODE XREF: sub_109B4+4Cj
					; sub_109B4+70j
		mov	ax, si
		dec	si
		or	ax, ax
		jnz	short loc_10A1A

loc_10A2E:				; CODE XREF: sub_109B4+35j
					; sub_109B4+64j
		mov	ax, di
		pop	di
		pop	si
		mov	sp, bp
		pop	bp
		retn	4
sub_109B4	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_10A38	proc far		; CODE XREF: sub_10FCC+6BP

arg_0		= dword	ptr  6
arg_4		= word ptr  0Ah
arg_6		= word ptr  0Ch
arg_8		= word ptr  0Eh

		push	bp
		mov	bp, sp
		push	word ptr [bp+arg_0+2]
		push	word ptr [bp+arg_0]
		call	sub_10494
		pop	cx
		pop	cx
		or	ax, ax
		jz	short loc_10A51
		mov	ax, 0FFFFh
		jmp	short loc_10AB6
; ---------------------------------------------------------------------------

loc_10A51:				; CODE XREF: sub_10A38+12j
		cmp	[bp+arg_8], 1
		jnz	short loc_10A70
		les	bx, [bp+arg_0]
		cmp	word ptr es:[bx], 0
		jle	short loc_10A70
		push	word ptr [bp+arg_0+2]
		push	word ptr [bp+arg_0]
		call	sub_109B4
		cwd
		sub	[bp+arg_4], ax
		sbb	[bp+arg_6], dx

loc_10A70:				; CODE XREF: sub_10A38+1Dj
					; sub_10A38+26j
		les	bx, [bp+arg_0]
		and	word ptr es:[bx+2], 0FE5Fh
		mov	word ptr es:[bx], 0
		mov	ax, es:[bx+0Ah]
		mov	dx, es:[bx+8]
		mov	es:[bx+0Ch], dx
		mov	es:[bx+0Eh], ax
		push	[bp+arg_8]
		push	[bp+arg_6]
		push	[bp+arg_4]
		mov	al, es:[bx+4]
		cbw
		push	ax
		call	sub_11B06
		add	sp, 8
		cmp	dx, 0FFFFh
		jnz	short loc_10AB4
		cmp	ax, 0FFFFh
		jnz	short loc_10AB4
		mov	ax, 0FFFFh
		jmp	short loc_10AB6
; ---------------------------------------------------------------------------

loc_10AB4:				; CODE XREF: sub_10A38+70j
					; sub_10A38+75j
		xor	ax, ax

loc_10AB6:				; CODE XREF: sub_10A38+17j
					; sub_10A38+7Aj
		pop	bp
		retf
sub_10A38	endp

; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		sub	sp, 4
		les	bx, [bp+6]
		mov	al, es:[bx+4]
		cbw
		push	ax
		call	sub_11197
		pop	cx
		mov	[bp-4],	ax
		mov	[bp-2],	dx
		les	bx, [bp+6]
		cmp	word ptr es:[bx], 0
		jge	short loc_10AEE
		push	word ptr [bp+8]
		push	word ptr [bp+6]
		call	sub_109B4
		cwd
		add	[bp-4],	ax
		adc	[bp-2],	dx
		jmp	short loc_10AFE
; ---------------------------------------------------------------------------

loc_10AEE:				; CODE XREF: seg000:0ADAj
		push	word ptr [bp+8]
		push	word ptr [bp+6]
		call	sub_109B4
		cwd
		sub	[bp-4],	ax
		sbb	[bp-2],	dx

loc_10AFE:				; CODE XREF: seg000:0AECj
		mov	dx, [bp-2]
		mov	ax, [bp-4]
		mov	sp, bp
		pop	bp
		retf

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_10B08	proc far		; CODE XREF: sub_1566E+1E2P

var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6
arg_2		= word ptr  8
arg_4		= word ptr  0Ah
arg_6		= word ptr  0Ch
arg_8		= word ptr  0Eh
arg_A		= word ptr  10h

		push	bp
		mov	bp, sp
		sub	sp, 4
		push	si
		push	di
		mov	di, [bp+arg_4]
		or	di, di
		jnz	short loc_10B19
		jmp	short loc_10B8F
; ---------------------------------------------------------------------------

loc_10B19:				; CODE XREF: sub_10B08+Dj
		mov	bx, di
		xor	cx, cx
		mov	ax, [bp+arg_6]
		xor	dx, dx
		call	sub_12DB1
		mov	[bp+var_4], ax
		mov	[bp+var_2], dx
		cmp	dx, 1
		ja	short loc_10B4E
		jb	short loc_10B36
		or	ax, ax
		jnb	short loc_10B4E

loc_10B36:				; CODE XREF: sub_10B08+28j
		push	[bp+arg_2]
		push	[bp+arg_0]
		push	[bp+var_4]
		push	[bp+arg_A]
		push	[bp+arg_8]
		call	sub_10D74
		xor	dx, dx
		div	di
		jmp	short loc_10B92
; ---------------------------------------------------------------------------

loc_10B4E:				; CODE XREF: sub_10B08+26j
					; sub_10B08+2Cj
		xor	si, si
		jmp	short loc_10B8A
; ---------------------------------------------------------------------------

loc_10B52:				; CODE XREF: sub_10B08+85j
		push	[bp+arg_2]
		push	[bp+arg_0]
		push	di
		push	[bp+arg_A]
		push	[bp+arg_8]
		call	sub_10D74
		xor	dx, dx
		mov	[bp+var_4], ax
		mov	[bp+var_2], dx
		or	dx, dx
		jnz	short loc_10B72
		cmp	ax, di
		jz	short loc_10B76

loc_10B72:				; CODE XREF: sub_10B08+64j
		mov	ax, si
		jmp	short loc_10B92
; ---------------------------------------------------------------------------

loc_10B76:				; CODE XREF: sub_10B08+68j
		mov	bx, di
		xor	cx, cx
		mov	dx, [bp+arg_2]
		mov	ax, [bp+arg_0]
		call	near ptr sub_12D32
		mov	[bp+arg_0], ax
		mov	[bp+arg_2], dx
		inc	si

loc_10B8A:				; CODE XREF: sub_10B08+48j
		cmp	si, [bp+arg_6]
		jb	short loc_10B52

loc_10B8F:				; CODE XREF: sub_10B08+Fj
		mov	ax, [bp+arg_6]

loc_10B92:				; CODE XREF: sub_10B08+44j
					; sub_10B08+6Cj
		pop	di
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_10B08	endp ; sp-analysis failed


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_10B98	proc far		; CODE XREF: sub_1112B+BP
					; sub_1112B+23P

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
sub_10B98	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_10BAB	proc far		; CODE XREF: sub_1112B+17P

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
sub_10BAB	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

DoPrintThing	proc far		; CODE XREF: sub_1566E+34P

arg_0		= word ptr  6
arg_2		= word ptr  8
arg_4		= byte ptr  0Ah

		push	bp
		mov	bp, sp
		mov	ax, 0D74h
		push	ax
		push	ds
		mov	ax, 2B80h
		push	ax
		push	[bp+arg_2]
		push	[bp+arg_0]
		lea	ax, [bp+arg_4]
		push	ax
		call	sub_12325
		pop	bp
		retf
DoPrintThing	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_10BD9	proc far		; CODE XREF: sub_10D74+16Ap

arg_0		= byte ptr  6
arg_2		= dword	ptr  8

		push	bp
		mov	bp, sp
		les	bx, [bp+arg_2]
		mov	ax, es:[bx]
		dec	ax
		mov	es:[bx], ax
		push	word ptr [bp+arg_2+2]
		push	word ptr [bp+arg_2]
		mov	al, [bp+arg_0]
		cbw
		push	ax
		call	sub_10BFB
		add	sp, 6
		pop	bp
		retf
sub_10BD9	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_10BFB	proc far		; CODE XREF: sub_10BD9+18P
					; seg000:0D6Bp	...

arg_0		= byte ptr  6
arg_2		= dword	ptr  8

		push	bp
		mov	bp, sp
		push	si
		mov	al, [bp+arg_0]
		mov	byte_19366, al
		les	bx, [bp+arg_2]
		cmp	word ptr es:[bx], 0FFFFh
		jge	short loc_10C5D
		mov	ax, es:[bx]
		inc	ax
		mov	es:[bx], ax
		mov	ax, es:[bx+0Eh]
		mov	si, es:[bx+0Ch]
		inc	word ptr es:[bx+0Ch]
		mov	dl, byte_19366
		mov	es, ax
		mov	es:[si], dl
		mov	es, word ptr [bp+arg_2+2]
		test	word ptr es:[bx+2], 8
		jz	short loc_10C5A
		cmp	byte_19366, 0Ah
		jz	short loc_10C43
		cmp	byte_19366, 0Dh
		jnz	short loc_10C5A

loc_10C43:				; CODE XREF: sub_10BFB+3Fj
		push	word ptr [bp+arg_2+2]
		push	word ptr [bp+arg_2]
		call	sub_10494
		pop	cx
		pop	cx
		or	ax, ax
		jz	short loc_10C5A

loc_10C54:				; CODE XREF: sub_10BFB+7Ej
					; sub_10BFB+A7j ...
		mov	ax, 0FFFFh
		jmp	loc_10D5A
; ---------------------------------------------------------------------------

loc_10C5A:				; CODE XREF: sub_10BFB+38j
					; sub_10BFB+46j ...
		jmp	loc_10D55
; ---------------------------------------------------------------------------

loc_10C5D:				; CODE XREF: sub_10BFB+11j
		les	bx, [bp+arg_2]
		test	word ptr es:[bx+2], 90h
		jnz	short loc_10C70
		test	word ptr es:[bx+2], 2
		jnz	short loc_10C7B

loc_10C70:				; CODE XREF: sub_10BFB+6Bj
		les	bx, [bp+arg_2]
		or	word ptr es:[bx+2], 10h
		jmp	short loc_10C54
; ---------------------------------------------------------------------------

loc_10C7B:				; CODE XREF: sub_10BFB+73j
		les	bx, [bp+arg_2]
		or	word ptr es:[bx+2], 100h
		cmp	word ptr es:[bx+6], 0
		jz	short loc_10CF4
		cmp	word ptr es:[bx], 0
		jz	short loc_10CA4
		push	word ptr [bp+arg_2+2]
		push	word ptr [bp+arg_2]
		call	sub_10494
		pop	cx
		pop	cx
		or	ax, ax
		jz	short loc_10CA4
		jmp	short loc_10C54
; ---------------------------------------------------------------------------

loc_10CA4:				; CODE XREF: sub_10BFB+94j
					; sub_10BFB+A5j
		les	bx, [bp+arg_2]
		mov	ax, es:[bx+6]
		neg	ax
		mov	es:[bx], ax
		mov	ax, es:[bx+0Eh]
		mov	si, es:[bx+0Ch]
		inc	word ptr es:[bx+0Ch]
		mov	dl, byte_19366
		mov	es, ax
		mov	es:[si], dl
		mov	es, word ptr [bp+arg_2+2]
		test	word ptr es:[bx+2], 8
		jz	short loc_10CF2
		cmp	byte_19366, 0Ah
		jz	short loc_10CDE
		cmp	byte_19366, 0Dh
		jnz	short loc_10CF2

loc_10CDE:				; CODE XREF: sub_10BFB+DAj
		push	word ptr [bp+arg_2+2]
		push	word ptr [bp+arg_2]
		call	sub_10494
		pop	cx
		pop	cx
		or	ax, ax
		jz	short loc_10CF2
		jmp	loc_10C54
; ---------------------------------------------------------------------------

loc_10CF2:				; CODE XREF: sub_10BFB+D3j
					; sub_10BFB+E1j ...
		jmp	short loc_10D55
; ---------------------------------------------------------------------------

loc_10CF4:				; CODE XREF: sub_10BFB+8Ej
		cmp	byte_19366, 0Ah
		jnz	short loc_10D22
		les	bx, [bp+arg_2]
		test	word ptr es:[bx+2], 40h
		jnz	short loc_10D22
		mov	ax, 1
		push	ax
		push	ds
		mov	ax, offset unk_191B8
		push	ax
		mov	al, es:[bx+4]
		cbw
		push	ax
		call	sub_127FD
		add	sp, 8
		cmp	ax, 1
		jnz	short loc_10D41

loc_10D22:				; CODE XREF: sub_10BFB+FEj
					; sub_10BFB+109j
		mov	ax, 1
		push	ax
		push	ds
		mov	ax, offset byte_19366
		push	ax
		les	bx, [bp+arg_2]
		mov	al, es:[bx+4]
		cbw
		push	ax
		call	sub_127FD
		add	sp, 8
		cmp	ax, 1
		jz	short loc_10D55

loc_10D41:				; CODE XREF: sub_10BFB+125j
		les	bx, [bp+arg_2]
		test	word ptr es:[bx+2], 200h
		jnz	short loc_10D55
		or	word ptr es:[bx+2], 10h
		jmp	loc_10C54
; ---------------------------------------------------------------------------

loc_10D55:				; CODE XREF: sub_10BFB:loc_10C5Aj
					; sub_10BFB:loc_10CF2j	...
		mov	al, byte_19366
		mov	ah, 0

loc_10D5A:				; CODE XREF: sub_10BFB+5Cj
		pop	si
		pop	bp
		retf
sub_10BFB	endp

; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		push	si
		mov	si, [bp+6]
		push	ds
		mov	ax, offset unk_19010
		push	ax
		push	si
		push	cs
		call	near ptr sub_10BFB
		add	sp, 6
		pop	si
		pop	bp
		retf

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_10D74	proc near		; CODE XREF: sub_10B08+3Dp
					; sub_10B08+57p

arg_0		= dword	ptr  4
arg_4		= word ptr  8
arg_6		= dword	ptr  0Ah

		push	bp
		mov	bp, sp
		push	si
		push	di
		mov	si, [bp+arg_4]
		mov	di, si
		les	bx, [bp+arg_0]
		test	word ptr es:[bx+2], 8
		jz	short loc_10DB7
		jmp	short loc_10DAD
; ---------------------------------------------------------------------------

loc_10D8B:				; CODE XREF: sub_10D74+3Ej
		push	word ptr [bp+arg_0+2]
		push	word ptr [bp+arg_0]
		les	bx, [bp+arg_6]
		inc	word ptr [bp+arg_6]
		mov	al, es:[bx]
		cbw
		push	ax
		push	cs
		call	near ptr sub_10BFB
		add	sp, 6
		cmp	ax, 0FFFFh
		jnz	short loc_10DAD

loc_10DA8:				; CODE XREF: sub_10D74+78j
					; sub_10D74+96j ...
		xor	ax, ax
		jmp	loc_10F16
; ---------------------------------------------------------------------------

loc_10DAD:				; CODE XREF: sub_10D74+15j
					; sub_10D74+32j
		mov	ax, si
		dec	si
		or	ax, ax
		jnz	short loc_10D8B
		jmp	loc_10F14
; ---------------------------------------------------------------------------

loc_10DB7:				; CODE XREF: sub_10D74+13j
		les	bx, [bp+arg_0]
		test	word ptr es:[bx+2], 40h
		jnz	short loc_10DC5
		jmp	loc_10E8D
; ---------------------------------------------------------------------------

loc_10DC5:				; CODE XREF: sub_10D74+4Cj
		cmp	word ptr es:[bx+6], 0
		jnz	short loc_10DCF
		jmp	loc_10E6B
; ---------------------------------------------------------------------------

loc_10DCF:				; CODE XREF: sub_10D74+56j
		cmp	es:[bx+6], si
		jnb	short loc_10E0F
		cmp	word ptr es:[bx], 0
		jz	short loc_10DEE
		push	word ptr [bp+arg_0+2]
		push	word ptr [bp+arg_0]
		call	sub_10494
		pop	cx
		pop	cx
		or	ax, ax
		jz	short loc_10DEE
		jmp	short loc_10DA8
; ---------------------------------------------------------------------------

loc_10DEE:				; CODE XREF: sub_10D74+65j
					; sub_10D74+76j
		push	si
		push	word ptr [bp+arg_6+2]
		push	word ptr [bp+arg_6]
		les	bx, [bp+arg_0]
		mov	al, es:[bx+4]
		cbw
		push	ax
		call	sub_127FD
		add	sp, 8
		cmp	ax, si
		jnb	short loc_10E0C
		jmp	short loc_10DA8
; ---------------------------------------------------------------------------

loc_10E0C:				; CODE XREF: sub_10D74+94j
		jmp	loc_10F14
; ---------------------------------------------------------------------------

loc_10E0F:				; CODE XREF: sub_10D74+5Fj
		les	bx, [bp+arg_0]
		mov	ax, es:[bx]
		add	ax, si
		jl	short loc_10E3F
		cmp	word ptr es:[bx], 0
		jnz	short loc_10E2B
		mov	ax, 0FFFFh
		sub	ax, es:[bx+6]
		mov	es:[bx], ax
		jmp	short loc_10E3F
; ---------------------------------------------------------------------------

loc_10E2B:				; CODE XREF: sub_10D74+A9j
		push	word ptr [bp+arg_0+2]
		push	word ptr [bp+arg_0]
		call	sub_10494
		pop	cx
		pop	cx
		or	ax, ax
		jz	short loc_10E3F
		jmp	loc_10DA8
; ---------------------------------------------------------------------------

loc_10E3F:				; CODE XREF: sub_10D74+A3j
					; sub_10D74+B5j ...
		push	si
		push	word ptr [bp+arg_6+2]
		push	word ptr [bp+arg_6]
		les	bx, [bp+arg_0]
		push	word ptr es:[bx+0Eh]
		push	word ptr es:[bx+0Ch]
		call	sub_11C20
		add	sp, 0Ah
		les	bx, [bp+arg_0]
		mov	ax, es:[bx]
		add	ax, si
		mov	es:[bx], ax
		add	es:[bx+0Ch], si
		jmp	loc_10F14
; ---------------------------------------------------------------------------

loc_10E6B:				; CODE XREF: sub_10D74+58j
		push	si
		push	word ptr [bp+arg_6+2]
		push	word ptr [bp+arg_6]
		les	bx, [bp+arg_0]
		mov	al, es:[bx+4]
		cbw
		push	ax
		call	sub_127FD
		add	sp, 8
		cmp	ax, si
		jnb	short loc_10E8A
		jmp	loc_10DA8
; ---------------------------------------------------------------------------

loc_10E8A:				; CODE XREF: sub_10D74+111j
		jmp	loc_10F14
; ---------------------------------------------------------------------------

loc_10E8D:				; CODE XREF: sub_10D74+4Ej
		les	bx, [bp+arg_0]
		cmp	word ptr es:[bx+6], 0
		jz	short loc_10EF5
		jmp	short loc_10EEC
; ---------------------------------------------------------------------------

loc_10E99:				; CODE XREF: sub_10D74+17Dj
		les	bx, [bp+arg_0]
		mov	ax, es:[bx]
		inc	ax
		mov	es:[bx], ax
		or	ax, ax
		jge	short loc_10ECD
		mov	ax, es:[bx+0Eh]
		push	ax
		push	bx
		mov	bx, es:[bx+0Ch]
		mov	ax, bx
		pop	bx
		inc	word ptr es:[bx+0Ch]
		les	bx, [bp+arg_6]
		inc	word ptr [bp+arg_6]
		mov	dl, es:[bx]
		mov	bx, ax
		pop	es
		mov	es:[bx], dl
		mov	al, dl
		mov	ah, 0
		jmp	short loc_10EE4
; ---------------------------------------------------------------------------

loc_10ECD:				; CODE XREF: sub_10D74+131j
		push	word ptr [bp+arg_0+2]
		push	word ptr [bp+arg_0]
		les	bx, [bp+arg_6]
		inc	word ptr [bp+arg_6]
		mov	al, es:[bx]
		push	ax
		push	cs
		call	near ptr sub_10BD9
		add	sp, 6

loc_10EE4:				; CODE XREF: sub_10D74+157j
		cmp	ax, 0FFFFh
		jnz	short loc_10EEC
		jmp	loc_10DA8
; ---------------------------------------------------------------------------

loc_10EEC:				; CODE XREF: sub_10D74+123j
					; sub_10D74+173j
		mov	ax, si
		dec	si
		or	ax, ax
		jnz	short loc_10E99
		jmp	short loc_10F14
; ---------------------------------------------------------------------------

loc_10EF5:				; CODE XREF: sub_10D74+121j
		push	si
		push	word ptr [bp+arg_6+2]
		push	word ptr [bp+arg_6]
		les	bx, [bp+arg_0]
		mov	al, es:[bx+4]
		cbw
		push	ax
		call	sub_1158F
		add	sp, 8
		cmp	ax, si
		jnb	short loc_10F14
		jmp	loc_10DA8
; ---------------------------------------------------------------------------

loc_10F14:				; CODE XREF: sub_10D74+40j
					; sub_10D74:loc_10E0Cj	...
		mov	ax, di

loc_10F16:				; CODE XREF: sub_10D74+36j
		pop	di
		pop	si
		pop	bp
		retn	0Ah
sub_10D74	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_10F1C	proc far		; CODE XREF: sub_1566E+77P

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		mov	ax, [bp+arg_0]
		mov	word_191BA, ax
		mov	word_191BC, 0
		pop	bp
		retf
sub_10F1C	endp


; =============== S U B	R O U T	I N E =======================================


sub_10F2D	proc far		; CODE XREF: sub_1566E+9FP
		mov	cx, word_191BC
		mov	bx, word_191BA
		mov	dx, 15Ah
		mov	ax, 4E35h
		call	sub_12DB1
		add	ax, 1
		adc	dx, 0
		mov	word_191BA, ax
		mov	word_191BC, dx
		mov	ax, word_191BC
		cwd
		and	ax, 7FFFh
		retf
sub_10F2D	endp

; ---------------------------------------------------------------------------

loc_10F53:				; DATA XREF: seg006:0002o
		mov	al, byte_19000
		cbw
		push	ax
		call	sub_11AF5
		pop	cx
		or	ax, ax
		jnz	short loc_10F68
		and	word_18FFE, 0FDFFh

loc_10F68:				; CODE XREF: seg000:0F60j
		mov	ax, 200h
		push	ax
		test	word_18FFE, 200h
		jz	short loc_10F79
		mov	ax, 1
		jmp	short loc_10F7B
; ---------------------------------------------------------------------------

loc_10F79:				; CODE XREF: seg000:0F72j
		xor	ax, ax

loc_10F7B:				; CODE XREF: seg000:0F77j
		push	ax
		xor	ax, ax
		xor	dx, dx
		push	ax
		push	dx
		push	ds
		mov	ax, offset unk_18FFC
		push	ax
		call	sub_10FCC
		add	sp, 0Ch
		mov	al, byte_19014
		cbw
		push	ax
		call	sub_11AF5
		pop	cx
		or	ax, ax
		jnz	short loc_10FA4
		and	word_19012, 0FDFFh

loc_10FA4:				; CODE XREF: seg000:0F9Cj
		mov	ax, 200h
		push	ax
		test	word_19012, 200h
		jz	short loc_10FB5
		mov	ax, 2
		jmp	short loc_10FB7
; ---------------------------------------------------------------------------

loc_10FB5:				; CODE XREF: seg000:0FAEj
		xor	ax, ax

loc_10FB7:				; CODE XREF: seg000:0FB3j
		push	ax
		xor	ax, ax
		xor	dx, dx
		push	ax
		push	dx
		push	ds
		mov	ax, offset unk_19010
		push	ax
		call	sub_10FCC
		add	sp, 0Ch
		retn

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_10FCC	proc far		; CODE XREF: fopen2+9DP seg000:0F87P ...

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
		jnz	short loc_10FEE
		cmp	di, 2
		jg	short loc_10FEE
		cmp	si, 7FFFh
		jbe	short loc_10FF4

loc_10FEE:				; CODE XREF: sub_10FCC+15j
					; sub_10FCC+1Aj ...
		mov	ax, 0FFFFh
		jmp	loc_110E7
; ---------------------------------------------------------------------------

loc_10FF4:				; CODE XREF: sub_10FCC+20j
		cmp	word_191C0, 0
		jnz	short loc_1100A
		cmp	word ptr [bp+arg_0], offset unk_19010
		jnz	short loc_1100A
		mov	word_191C0, 1
		jmp	short loc_1101E
; ---------------------------------------------------------------------------

loc_1100A:				; CODE XREF: sub_10FCC+2Dj
					; sub_10FCC+34j
		cmp	word_191BE, 0
		jnz	short loc_1101E
		cmp	word ptr [bp+arg_0], offset unk_18FFC
		jnz	short loc_1101E
		mov	word_191BE, 1

loc_1101E:				; CODE XREF: sub_10FCC+3Cj
					; sub_10FCC+43j ...
		les	bx, [bp+arg_0]
		cmp	word ptr es:[bx], 0
		jz	short loc_1103F
		mov	ax, 1
		push	ax
		xor	ax, ax
		xor	dx, dx
		push	ax
		push	dx
		push	word ptr [bp+arg_0+2]
		push	word ptr [bp+arg_0]
		call	sub_10A38
		add	sp, 0Ah

loc_1103F:				; CODE XREF: sub_10FCC+59j
		les	bx, [bp+arg_0]
		test	word ptr es:[bx+2], 4
		jz	short loc_11059
		push	word ptr es:[bx+0Ah]
		push	word ptr es:[bx+8]
		call	sub_1298E
		pop	cx
		pop	cx

loc_11059:				; CODE XREF: sub_10FCC+7Cj
		les	bx, [bp+arg_0]
		and	word ptr es:[bx+2], 0FFF3h
		mov	word ptr es:[bx+6], 0
		mov	ax, word ptr [bp+arg_0+2]
		mov	dx, word ptr [bp+arg_0]
		add	dx, 5
		mov	es:[bx+8], dx
		mov	es:[bx+0Ah], ax
		mov	es:[bx+0Ch], dx
		mov	es:[bx+0Eh], ax
		cmp	di, 2
		jz	short loc_110E5
		or	si, si
		jbe	short loc_110E5
		mov	word ptr off_18FEE, offset loc_116F6
		mov	word ptr off_18FEE+2, seg seg000
		mov	ax, [bp+arg_4]
		or	ax, [bp+arg_6]
		jnz	short loc_110BD
		push	si
		call	sub_12A74
		pop	cx
		mov	[bp+arg_4], ax
		mov	[bp+arg_6], dx
		or	ax, dx
		jz	short loc_110BA
		les	bx, [bp+arg_0]
		or	word ptr es:[bx+2], 4
		jmp	short loc_110BD
; ---------------------------------------------------------------------------

loc_110BA:				; CODE XREF: sub_10FCC+E1j
		jmp	loc_10FEE
; ---------------------------------------------------------------------------

loc_110BD:				; CODE XREF: sub_10FCC+D0j
					; sub_10FCC+ECj
		les	bx, [bp+arg_0]
		mov	ax, [bp+arg_6]
		mov	dx, [bp+arg_4]
		mov	es:[bx+0Ch], dx
		mov	es:[bx+0Eh], ax
		mov	es:[bx+8], dx
		mov	es:[bx+0Ah], ax
		mov	es:[bx+6], si
		cmp	di, 1
		jnz	short loc_110E5
		or	word ptr es:[bx+2], 8

loc_110E5:				; CODE XREF: sub_10FCC+B8j
					; sub_10FCC+BCj ...
		xor	ax, ax

loc_110E7:				; CODE XREF: sub_10FCC+25j
		pop	di
		pop	si
		pop	bp
		retf
sub_10FCC	endp

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
		call	sub_112DE
		add	sp, 0Ch
		push	ss
		lea	ax, [bp-4]
		push	ax
		call	sub_11F48
		pop	cx
		pop	cx
		push	ss
		lea	ax, [bp-8]
		push	ax
		call	sub_11F5D
		pop	cx
		pop	cx
		xor	ax, ax
		mov	sp, bp
		pop	bp
		retf

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1112B	proc far		; CODE XREF: sub_1566E+6FP

var_10		= word ptr -10h
var_E		= word ptr -0Eh
var_C		= byte ptr -0Ch
var_8		= byte ptr -8
var_6		= byte ptr -6
var_4		= byte ptr -4
var_2		= byte ptr -2
arg_0		= dword	ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 10h

loc_11131:				; CODE XREF: sub_1112B+30j
		push	ss
		lea	ax, [bp+var_4]
		push	ax
		call	sub_10B98
		pop	cx
		pop	cx
		push	ss
		lea	ax, [bp+var_C]
		push	ax
		call	sub_10BAB
		pop	cx
		pop	cx
		push	ss
		lea	ax, [bp+var_8]
		push	ax
		call	sub_10B98
		pop	cx
		pop	cx
		mov	al, [bp+var_2]
		cmp	al, [bp+var_6]
		jnz	short loc_11131
		push	ss
		lea	ax, [bp+var_C]
		push	ax
		push	ss
		lea	ax, [bp+var_4]
		push	ax
		call	sub_111B1
		add	sp, 8
		mov	[bp+var_10], ax
		mov	[bp+var_E], dx
		mov	ax, word ptr [bp+arg_0]
		or	ax, word ptr [bp+arg_0+2]
		jz	short loc_1118D
		les	bx, [bp+arg_0]
		mov	ax, [bp+var_E]
		mov	dx, [bp+var_10]
		mov	es:[bx], dx
		mov	es:[bx+2], ax

loc_1118D:				; CODE XREF: sub_1112B+50j
		mov	dx, [bp+var_E]
		mov	ax, [bp+var_10]
		mov	sp, bp
		pop	bp
		retf
sub_1112B	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_11197	proc far		; CODE XREF: seg000:0AC7P

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		mov	ax, 1
		push	ax
		xor	ax, ax
		xor	dx, dx
		push	ax
		push	dx
		push	[bp+arg_0]
		call	sub_11B06
		add	sp, 8
		pop	bp
		retf
sub_11197	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_111B1	proc far		; CODE XREF: sub_1112B+3CP

var_6		= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= dword	ptr  6
arg_4		= dword	ptr  0Ah

		push	bp
		mov	bp, sp
		sub	sp, 6
		push	si
		push	di
		call	far ptr	sub_1202A
		mov	ax, word_1925A
		mov	dx, word_19258
		add	dx, 0A600h
		adc	ax, 12CEh
		mov	[bp+var_4], dx
		mov	[bp+var_2], ax
		les	bx, [bp+arg_0]
		mov	ax, es:[bx]
		add	ax, 0F844h
		mov	si, ax
		sar	ax, 1
		sar	ax, 1
		cwd
		push	ax
		push	dx
		mov	dx, 786h
		mov	ax, 1F80h
		pop	cx
		pop	bx
		call	sub_12DB1
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
		call	sub_12DB1
		add	[bp+var_4], ax
		adc	[bp+var_2], dx
		test	si, 3
		jz	short loc_1121D
		add	[bp+var_4], 5180h
		adc	[bp+var_2], 1

loc_1121D:				; CODE XREF: sub_111B1+61j
		xor	di, di
		les	bx, [bp+arg_0]
		mov	al, es:[bx+3]
		cbw
		dec	ax
		mov	si, ax
		jmp	short loc_11234
; ---------------------------------------------------------------------------

loc_1122C:				; CODE XREF: sub_111B1+85j
		dec	si
		mov	al, [si+2D34h]
		cbw
		add	di, ax

loc_11234:				; CODE XREF: sub_111B1+79j
		or	si, si
		jg	short loc_1122C
		les	bx, [bp+arg_0]
		mov	al, es:[bx+2]
		cbw
		dec	ax
		add	di, ax
		cmp	byte ptr es:[bx+3], 2
		jle	short loc_11252
		test	word ptr es:[bx], 3
		jnz	short loc_11252
		inc	di

loc_11252:				; CODE XREF: sub_111B1+97j
					; sub_111B1+9Ej
		mov	ax, di
		mov	dx, 18h
		imul	dx
		les	bx, [bp+arg_4]
		mov	dl, es:[bx+1]
		mov	dh, 0
		add	ax, dx
		mov	[bp+var_6], ax
		cmp	word_1925C, 0
		jz	short loc_1128D
		mov	al, es:[bx+1]
		mov	ah, 0
		push	ax
		push	di
		xor	ax, ax
		push	ax
		les	bx, [bp+arg_0]
		mov	ax, es:[bx]
		add	ax, 0F84Eh
		push	ax
		call	sub_12216
		or	ax, ax
		jz	short loc_1128D
		dec	[bp+var_6]

loc_1128D:				; CODE XREF: sub_111B1+BBj
					; sub_111B1+D7j
		mov	ax, [bp+var_6]
		cwd
		push	ax
		push	dx
		xor	dx, dx
		mov	ax, 0E10h
		pop	cx
		pop	bx
		call	sub_12DB1
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
		call	sub_12DB1
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
		pop	di
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_111B1	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_112DE	proc far		; CODE XREF: seg000:1105P

arg_0		= word ptr  6
arg_2		= word ptr  8
arg_4		= dword	ptr  0Ah
arg_8		= dword	ptr  0Eh

		push	bp
		mov	bp, sp
		call	far ptr	sub_1202A
		mov	ax, word_1925A
		mov	dx, word_19258
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
		call	near ptr sub_12C72
		les	bx, [bp+arg_8]
		mov	es:[bx+3], al
		xor	ax, ax
		mov	dx, 3Ch	; '<'
		push	ax
		push	dx
		push	[bp+arg_2]
		push	[bp+arg_0]
		call	sub_12C63
		mov	[bp+arg_0], ax
		mov	[bp+arg_2], dx
		xor	ax, ax
		mov	dx, 3Ch	; '<'
		push	ax
		push	dx
		push	[bp+arg_2]
		push	[bp+arg_0]
		call	near ptr sub_12C72
		les	bx, [bp+arg_8]
		mov	es:[bx], al
		xor	ax, ax
		mov	dx, 3Ch	; '<'
		push	ax
		push	dx
		push	[bp+arg_2]
		push	[bp+arg_0]
		call	sub_12C63
		mov	[bp+arg_0], ax
		mov	[bp+arg_2], dx
		xor	ax, ax
		mov	dx, 88F8h
		push	ax
		push	dx
		push	[bp+arg_2]
		push	[bp+arg_0]
		call	sub_12C63
		shl	ax, 1
		shl	ax, 1
		add	ax, 7BCh
		les	bx, [bp+arg_4]
		mov	es:[bx], ax
		xor	ax, ax
		mov	dx, 88F8h
		push	ax
		push	dx
		push	[bp+arg_2]
		push	[bp+arg_0]
		call	near ptr sub_12C72
		mov	[bp+arg_0], ax
		mov	[bp+arg_2], dx
		cmp	[bp+arg_2], 0
		jl	short loc_113D8
		jg	short loc_1139D
		cmp	[bp+arg_0], 2250h
		jbe	short loc_113D8

loc_1139D:				; CODE XREF: sub_112DE+B6j
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
		call	sub_12C63
		les	bx, [bp+arg_4]
		add	es:[bx], ax
		xor	ax, ax
		mov	dx, 2238h
		push	ax
		push	dx
		push	[bp+arg_2]
		push	[bp+arg_0]
		call	near ptr sub_12C72
		mov	[bp+arg_0], ax
		mov	[bp+arg_2], dx

loc_113D8:				; CODE XREF: sub_112DE+B4j
					; sub_112DE+BDj
		cmp	word_1925C, 0
		jz	short loc_1141D
		xor	ax, ax
		mov	dx, 18h
		push	ax
		push	dx
		push	[bp+arg_2]
		push	[bp+arg_0]
		call	near ptr sub_12C72
		push	ax
		xor	ax, ax
		mov	dx, 18h
		push	ax
		push	dx
		push	[bp+arg_2]
		push	[bp+arg_0]
		call	sub_12C63
		push	ax
		xor	ax, ax
		push	ax
		les	bx, [bp+arg_4]
		mov	ax, es:[bx]
		add	ax, 0F84Eh
		push	ax
		call	sub_12216
		or	ax, ax
		jz	short loc_1141D
		add	[bp+arg_0], 1
		adc	[bp+arg_2], 0

loc_1141D:				; CODE XREF: sub_112DE+FFj
					; sub_112DE+135j
		xor	ax, ax
		mov	dx, 18h
		push	ax
		push	dx
		push	[bp+arg_2]
		push	[bp+arg_0]
		call	near ptr sub_12C72
		les	bx, [bp+arg_8]
		mov	es:[bx+1], al
		xor	ax, ax
		mov	dx, 18h
		push	ax
		push	dx
		push	[bp+arg_2]
		push	[bp+arg_0]
		call	sub_12C63
		mov	[bp+arg_0], ax
		mov	[bp+arg_2], dx
		add	[bp+arg_0], 1
		adc	[bp+arg_2], 0
		les	bx, [bp+arg_4]
		test	word ptr es:[bx], 3
		jnz	short loc_1148F
		cmp	[bp+arg_2], 0
		jl	short loc_11474
		jg	short loc_1146A
		cmp	[bp+arg_0], 3Ch	; '<'
		jbe	short loc_11474

loc_1146A:				; CODE XREF: sub_112DE+184j
		sub	[bp+arg_0], 1
		sbb	[bp+arg_2], 0
		jmp	short loc_1148F
; ---------------------------------------------------------------------------

loc_11474:				; CODE XREF: sub_112DE+182j
					; sub_112DE+18Aj
		cmp	[bp+arg_2], 0
		jnz	short loc_1148F
		cmp	[bp+arg_0], 3Ch	; '<'
		jnz	short loc_1148F
		les	bx, [bp+arg_4]
		mov	byte ptr es:[bx+3], 2
		mov	byte ptr es:[bx+2], 1Dh
		jmp	short loc_114E0
; ---------------------------------------------------------------------------

loc_1148F:				; CODE XREF: sub_112DE+17Cj
					; sub_112DE+194j ...
		les	bx, [bp+arg_4]
		mov	byte ptr es:[bx+3], 0
		jmp	short loc_114B6
; ---------------------------------------------------------------------------

loc_11499:				; CODE XREF: sub_112DE+1EBj
					; sub_112DE+1F2j
		les	bx, [bp+arg_4]
		mov	al, es:[bx+3]
		cbw
		mov	bx, ax
		mov	al, [bx+2D34h]
		cbw
		cwd
		sub	[bp+arg_0], ax
		sbb	[bp+arg_2], dx
		mov	bx, word ptr [bp+arg_4]
		inc	byte ptr es:[bx+3]

loc_114B6:				; CODE XREF: sub_112DE+1B9j
		les	bx, [bp+arg_4]
		mov	al, es:[bx+3]
		cbw
		mov	bx, ax
		mov	al, [bx+2D34h]
		cbw
		cwd
		cmp	dx, [bp+arg_2]
		jl	short loc_11499
		jnz	short loc_114D2
		cmp	ax, [bp+arg_0]
		jb	short loc_11499

loc_114D2:				; CODE XREF: sub_112DE+1EDj
		les	bx, [bp+arg_4]
		inc	byte ptr es:[bx+3]
		mov	al, byte ptr [bp+arg_0]
		mov	es:[bx+2], al

loc_114E0:				; CODE XREF: sub_112DE+1AFj
		pop	bp
		retf
sub_112DE	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_114E2	proc near		; CODE XREF: sub_103E5+95p
					; seg000:1568p

arg_0		= word ptr  4
arg_2		= dword	ptr  6

		push	bp
		mov	bp, sp
		mov	ax, word ptr [bp+arg_2]
		or	ax, word ptr [bp+arg_2+2]
		jnz	short loc_114F5
		mov	word ptr [bp+arg_2], offset byte_1936A
		mov	word ptr [bp+arg_2+2], ds

loc_114F5:				; CODE XREF: sub_114E2+9j
		les	bx, [bp+arg_2]
		mov	byte ptr es:[bx], 0
		push	ds
		mov	ax, offset aTmp	; "TMP"
		push	ax
		push	word ptr [bp+arg_2+2]
		push	word ptr [bp+arg_2]
		call	strcat
		add	sp, 8
		mov	ax, 0Ah
		push	ax
		mov	ax, word ptr [bp+arg_2]
		add	ax, 3
		push	word ptr [bp+arg_2+2]
		push	ax
		xor	ax, ax
		push	ax
		push	[bp+arg_0]
		call	sub_11BDB
		add	sp, 0Ah
		push	ds
		mov	ax, offset a_	; ".$$$"
		push	ax
		push	word ptr [bp+arg_2+2]
		push	word ptr [bp+arg_2]
		call	strcat
		add	sp, 8
		mov	dx, word ptr [bp+arg_2+2]
		mov	ax, word ptr [bp+arg_2]
		pop	bp
		retn	6
sub_114E2	endp

; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp

loc_1154B:				; CODE XREF: seg000:1585j
		push	word ptr [bp+8]
		push	word ptr [bp+6]
		cmp	word_19368, 0FFFFh
		jnz	short loc_1155D
		mov	ax, 2
		jmp	short loc_11560
; ---------------------------------------------------------------------------

loc_1155D:				; CODE XREF: seg000:1556j
		mov	ax, 1

loc_11560:				; CODE XREF: seg000:155Bj
		add	word_19368, ax
		mov	ax, word_19368
		push	ax
		call	sub_114E2
		mov	[bp+6],	ax
		mov	[bp+8],	dx
		xor	ax, ax
		push	ax
		push	word ptr [bp+8]
		push	word ptr [bp+6]
		call	far ptr	loc_101FE
		add	sp, 6
		cmp	ax, 0FFFFh
		jnz	short loc_1154B
		mov	dx, [bp+8]
		mov	ax, [bp+6]
		pop	bp
		retf

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1158F	proc far		; CODE XREF: sub_10494+ABP
					; sub_10D74+191P

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
		mov	ax, [bp+arg_6]
		inc	ax
		cmp	ax, 2
		jnb	short loc_115A6
		xor	ax, ax
		jmp	loc_116B6
; ---------------------------------------------------------------------------

loc_115A6:				; CODE XREF: sub_1158F+10j
		mov	bx, [bp+arg_0]
		shl	bx, 1
		test	word_1918C[bx],	8000h
		jz	short loc_115CA
		push	[bp+arg_6]
		push	[bp+arg_4]
		push	[bp+arg_2]
		push	[bp+arg_0]
		call	sub_127FD
		add	sp, 8
		jmp	loc_116B6
; ---------------------------------------------------------------------------

loc_115CA:				; CODE XREF: sub_1158F+22j
		mov	bx, [bp+arg_0]
		shl	bx, 1
		and	word_1918C[bx],	-201h
		mov	ax, [bp+arg_4]
		mov	dx, [bp+arg_2]
		mov	word ptr [bp+var_C], dx
		mov	word ptr [bp+var_C+2], ax
		mov	ax, [bp+arg_6]
		mov	[bp+var_6], ax
		jmp	short loc_11663
; ---------------------------------------------------------------------------

loc_115E9:				; CODE XREF: sub_1158F+E4j
		dec	[bp+var_6]
		les	bx, [bp+var_C]
		inc	word ptr [bp+var_C]
		mov	al, es:[bx]
		mov	[bp+var_7], al
		cmp	al, 0Ah
		jnz	short loc_11606
		les	bx, [bp+var_4]
		mov	byte ptr es:[bx], 0Dh
		inc	word ptr [bp+var_4]

loc_11606:				; CODE XREF: sub_1158F+6Bj
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
		jl	short loc_1166D
		jnz	short loc_1162C
		cmp	dx, 80h	; '€'
		jb	short loc_1166D

loc_1162C:				; CODE XREF: sub_1158F+95j
		lea	ax, [bp+var_8E]
		mov	dx, word ptr [bp+var_4]
		xor	bx, bx
		sub	dx, ax
		sbb	bx, 0
		mov	si, dx
		push	si
		push	ss
		push	ax
		push	[bp+arg_0]
		call	sub_127FD
		add	sp, 8
		mov	di, ax
		cmp	ax, si
		jz	short loc_11663
		or	di, di
		jnb	short loc_11659

loc_11654:				; CODE XREF: sub_1158F+119j
		mov	ax, 0FFFFh
		jmp	short loc_116B1
; ---------------------------------------------------------------------------

loc_11659:				; CODE XREF: sub_1158F+C3j
		mov	ax, [bp+arg_6]
		sub	ax, [bp+var_6]
		jmp	short loc_116AD
; ---------------------------------------------------------------------------
		jmp	short loc_116B1
; ---------------------------------------------------------------------------

loc_11663:				; CODE XREF: sub_1158F+58j
					; sub_1158F+BFj
		lea	ax, [bp+var_8E]
		mov	word ptr [bp+var_4], ax
		mov	word ptr [bp+var_4+2], ss

loc_1166D:				; CODE XREF: sub_1158F+93j
					; sub_1158F+9Bj
		cmp	[bp+var_6], 0
		jz	short loc_11676
		jmp	loc_115E9
; ---------------------------------------------------------------------------

loc_11676:				; CODE XREF: sub_1158F+E2j
		lea	ax, [bp+var_8E]
		mov	dx, word ptr [bp+var_4]
		xor	bx, bx
		sub	dx, ax
		sbb	bx, 0
		mov	si, dx
		mov	ax, dx
		or	ax, ax
		jbe	short loc_116B3
		push	si
		push	ss
		lea	ax, [bp+var_8E]
		push	ax
		push	[bp+arg_0]
		call	sub_127FD
		add	sp, 8
		mov	di, ax
		cmp	ax, si
		jz	short loc_116B3
		or	di, di
		jnb	short loc_116AA
		jmp	short loc_11654
; ---------------------------------------------------------------------------

loc_116AA:				; CODE XREF: sub_1158F+117j
		mov	ax, [bp+arg_6]

loc_116AD:				; CODE XREF: sub_1158F+D0j
		add	ax, di
		sub	ax, si

loc_116B1:				; CODE XREF: sub_1158F+C8j
					; sub_1158F+D2j
		jmp	short loc_116B6
; ---------------------------------------------------------------------------

loc_116B3:				; CODE XREF: sub_1158F+FBj
					; sub_1158F+113j
		mov	ax, [bp+arg_6]

loc_116B6:				; CODE XREF: sub_1158F+14j
					; sub_1158F+38j ...
		pop	di
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_1158F	endp

; ---------------------------------------------------------------------------

loc_116BC:				; DATA XREF: sub_105A7:loc_10651o
		push	bp
		mov	bp, sp
		sub	sp, 4
		push	si
		xor	si, si
		mov	word ptr [bp-4], offset	unk_18FFC
		mov	word ptr [bp-2], ds
		jmp	short loc_116EC
; ---------------------------------------------------------------------------

loc_116CF:				; CODE XREF: seg000:16EFj
		les	bx, [bp-4]
		test	word ptr es:[bx+2], 3
		jz	short loc_116E7
		push	word ptr [bp-2]
		push	word ptr [bp-4]
		call	sub_103E5
		pop	cx
		pop	cx

loc_116E7:				; CODE XREF: seg000:16D8j
		add	word ptr [bp-4], 14h
		inc	si

loc_116EC:				; CODE XREF: seg000:16CDj
		cmp	si, 14h
		jl	short loc_116CF
		pop	si
		mov	sp, bp
		pop	bp
		retf
; ---------------------------------------------------------------------------

loc_116F6:				; DATA XREF: sub_10FCC+BEo
		push	bp
		mov	bp, sp
		sub	sp, 4
		push	si
		mov	si, 4
		mov	word ptr [bp-4], offset	unk_18FFC
		mov	word ptr [bp-2], ds
		jmp	short loc_11727
; ---------------------------------------------------------------------------

loc_1170A:				; CODE XREF: seg000:1729j
		les	bx, [bp-4]
		test	word ptr es:[bx+2], 3
		jz	short loc_11722
		push	word ptr [bp-2]
		push	word ptr [bp-4]
		call	sub_10494
		pop	cx
		pop	cx

loc_11722:				; CODE XREF: seg000:1713j
		dec	si
		add	word ptr [bp-4], 14h

loc_11727:				; CODE XREF: seg000:1708j
		or	si, si
		jnz	short loc_1170A
		pop	si
		mov	sp, bp
		pop	bp
		retf

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_11730	proc far		; CODE XREF: seg000:17AFp
					; sub_1202D+137P

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
		mov	di, 2A5Dh

loc_11746:				; CODE XREF: sub_11730+1Dj
		mov	bl, es:[si]
		inc	si
		test	byte ptr [bx+di], 1
		jnz	short loc_11746
		mov	bp, 0
		cmp	bl, 2Bh	; '+'
		jz	short loc_1175D
		cmp	bl, 2Dh	; '-'
		jnz	short loc_11761
		inc	bp

loc_1175D:				; CODE XREF: sub_11730+25j
					; sub_11730+41j
		mov	bl, es:[si]
		inc	si

loc_11761:				; CODE XREF: sub_11730+2Aj
		cmp	bl, 39h	; '9'
		ja	short loc_11795
		sub	bl, 30h	; '0'
		jb	short loc_11795
		mul	cx
		add	ax, bx
		adc	dl, dh
		jz	short loc_1175D
		jmp	short loc_11787
; ---------------------------------------------------------------------------

loc_11775:				; CODE XREF: sub_11730+63j
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

loc_11787:				; CODE XREF: sub_11730+43j
		mov	bl, es:[si]
		inc	si
		cmp	bl, 39h	; '9'
		ja	short loc_11795
		sub	bl, 30h	; '0'
		jnb	short loc_11775

loc_11795:				; CODE XREF: sub_11730+34j
					; sub_11730+39j ...
		dec	bp
		jl	short loc_1179F
		neg	dx
		neg	ax
		sbb	dx, 0

loc_1179F:				; CODE XREF: sub_11730+66j
		pop	bp
		pop	es
		pop	di
		pop	si
		pop	bp
		retf
sub_11730	endp

; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		push	word ptr [bp+8]
		push	word ptr [bp+6]
		push	cs
		call	near ptr sub_11730
		pop	cx
		pop	cx
		pop	bp
		retf

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_117B6	proc far		; CODE XREF: seg000:020BP
					; sub_11CB4+44P ...

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
		jb	short loc_117CD
		xchg	ax, cx
		jmp	short loc_117D1
; ---------------------------------------------------------------------------

loc_117CD:				; CODE XREF: sub_117B6+12j
		push	ax
		call	sub_11AB8

loc_117D1:				; CODE XREF: sub_117B6+15j
		pop	bp
		retf
sub_117B6	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_117D3	proc far		; CODE XREF: sub_10266+24P
					; sub_11CB4+91P

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		mov	ah, 3Eh	; '>'
		mov	bx, [bp+arg_0]
		int	21h		; DOS -	2+ - CLOSE A FILE WITH HANDLE
					; BX = file handle
		jb	short loc_117EB
		shl	bx, 1
		mov	word ptr [bx+2CFCh], 0FFFFh
		xor	ax, ax
		jmp	short loc_117EF
; ---------------------------------------------------------------------------

loc_117EB:				; CODE XREF: sub_117D3+Aj
		push	ax
		call	sub_11AB8

loc_117EF:				; CODE XREF: sub_117D3+16j
		pop	bp
		retf
sub_117D3	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_117F1	proc far		; CODE XREF: sub_1192F+A0P

var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 4
		mov	bx, [bp+arg_0]
		shl	bx, 1
		test	word ptr [bx+2CFCh], 200h
		jz	short loc_11809

loc_11804:				; CODE XREF: sub_117F1:loc_1184Bj
		mov	ax, 1
		jmp	short loc_11855
; ---------------------------------------------------------------------------

loc_11809:				; CODE XREF: sub_117F1+11j
		mov	ax, 4400h
		mov	bx, [bp+arg_0]
		int	21h		; DOS -	2+ - IOCTL - GET DEVICE	INFORMATION
					; BX = file or device handle
		jb	short loc_11851
		test	dl, 80h
		jnz	short loc_1184D
		mov	ax, 4201h
		xor	cx, cx
		mov	dx, cx
		int	21h		; DOS -	2+ - MOVE FILE READ/WRITE POINTER (LSEEK)
					; AL = method: offset from present location
		jb	short loc_11851
		push	dx
		push	ax
		mov	ax, 4202h
		xor	cx, cx
		mov	dx, cx
		int	21h		; DOS -	2+ - MOVE FILE READ/WRITE POINTER (LSEEK)
					; AL = method: offset from end of file
		mov	[bp+var_4], ax
		mov	[bp+var_2], dx
		pop	dx
		pop	cx
		jb	short loc_11851
		mov	ax, 4200h
		int	21h		; DOS -	2+ - MOVE FILE READ/WRITE POINTER (LSEEK)
					; AL = method: offset from beginning of	file
		jb	short loc_11851
		cmp	dx, [bp+var_2]
		jb	short loc_1184D
		ja	short loc_1184B
		cmp	ax, [bp+var_4]
		jb	short loc_1184D

loc_1184B:				; CODE XREF: sub_117F1+53j
		jmp	short loc_11804
; ---------------------------------------------------------------------------

loc_1184D:				; CODE XREF: sub_117F1+25j
					; sub_117F1+51j ...
		xor	ax, ax
		jmp	short loc_11855
; ---------------------------------------------------------------------------

loc_11851:				; CODE XREF: sub_117F1+20j
					; sub_117F1+30j ...
		push	ax
		call	sub_11AB8

loc_11855:				; CODE XREF: sub_117F1+16j
					; sub_117F1+5Ej
		mov	sp, bp
		pop	bp
		retf
sub_117F1	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_11859	proc near		; CODE XREF: sub_11899+Ep
					; sub_1192F+76p

var_4		= dword	ptr -4

		push	bp
		mov	bp, sp
		sub	sp, 4
		push	si
		mov	si, 14h
		mov	word ptr [bp+var_4], offset unk_18FFC
		mov	word ptr [bp+var_4+2], ds
		jmp	short loc_1188D
; ---------------------------------------------------------------------------

loc_1186D:				; CODE XREF: sub_11859+39j
		les	bx, [bp+var_4]
		mov	ax, es:[bx+2]
		and	ax, 300h
		cmp	ax, 300h
		jnz	short loc_11889
		push	word ptr [bp+var_4+2]
		push	word ptr [bp+var_4]
		call	sub_10494
		pop	cx
		pop	cx

loc_11889:				; CODE XREF: sub_11859+21j
		add	word ptr [bp+var_4], 14h

loc_1188D:				; CODE XREF: sub_11859+12j
		mov	ax, si
		dec	si
		or	ax, ax
		jnz	short loc_1186D
		pop	si
		mov	sp, bp
		pop	bp
		retn
sub_11859	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_11899	proc near		; CODE XREF: sub_1192F+60p

arg_0		= dword	ptr  4

		push	bp
		mov	bp, sp
		les	bx, [bp+arg_0]
		test	word ptr es:[bx+2], 200h
		jz	short loc_118AA
		call	sub_11859

loc_118AA:				; CODE XREF: sub_11899+Cj
		les	bx, [bp+arg_0]
		push	word ptr es:[bx+6]
		mov	ax, es:[bx+0Ah]
		mov	dx, es:[bx+8]
		mov	es:[bx+0Ch], dx
		mov	es:[bx+0Eh], ax
		push	ax
		push	dx
		mov	al, es:[bx+4]
		cbw
		push	ax
		call	sub_11E52
		add	sp, 8
		les	bx, [bp+arg_0]
		mov	es:[bx], ax
		or	ax, ax
		jle	short loc_118E4
		and	word ptr es:[bx+2], 0FFDFh
		xor	ax, ax
		jmp	short loc_1190D
; ---------------------------------------------------------------------------

loc_118E4:				; CODE XREF: sub_11899+40j
		les	bx, [bp+arg_0]
		cmp	word ptr es:[bx], 0
		jnz	short loc_118FD
		mov	ax, es:[bx+2]
		and	ax, 0FE7Fh
		or	ax, 20h
		mov	es:[bx+2], ax
		jmp	short loc_1190A
; ---------------------------------------------------------------------------

loc_118FD:				; CODE XREF: sub_11899+52j
		les	bx, [bp+arg_0]
		mov	word ptr es:[bx], 0
		or	word ptr es:[bx+2], 10h

loc_1190A:				; CODE XREF: sub_11899+62j
		mov	ax, 0FFFFh

loc_1190D:				; CODE XREF: sub_11899+49j
		pop	bp
		retn	4
sub_11899	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_11911	proc far		; CODE XREF: sub_1082B+D1P

arg_0		= dword	ptr  6

		push	bp
		mov	bp, sp
		les	bx, [bp+arg_0]
		mov	ax, es:[bx]
		inc	ax
		mov	es:[bx], ax
		push	word ptr [bp+arg_0+2]
		push	word ptr [bp+arg_0]
		push	cs
		call	near ptr sub_1192F
		pop	cx
		pop	cx
		pop	bp
		retf
sub_11911	endp

; ---------------------------------------------------------------------------
		pop	ax
		push	cs
		push	ax

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1192F	proc far		; CODE XREF: sub_11911+14p
					; seg000:1A19p

arg_0		= dword	ptr  6

		push	bp
		mov	bp, sp
		push	si
		les	bx, [bp+arg_0]
		cmp	word ptr es:[bx], 0
		jle	short loc_1195A

loc_1193C:				; CODE XREF: sub_1192F:loc_11998j
		les	bx, [bp+arg_0]
		mov	ax, es:[bx]
		dec	ax
		mov	es:[bx], ax
		mov	ax, es:[bx+0Eh]
		mov	si, es:[bx+0Ch]
		inc	word ptr es:[bx+0Ch]
		mov	es, ax
		mov	al, es:[si]
		jmp	loc_11A0E
; ---------------------------------------------------------------------------

loc_1195A:				; CODE XREF: sub_1192F+Bj
		les	bx, [bp+arg_0]
		cmp	word ptr es:[bx], 0
		jl	short loc_1196B
		test	word ptr es:[bx+2], 110h
		jz	short loc_11979

loc_1196B:				; CODE XREF: sub_1192F+32j
					; sub_1192F+ABj
		les	bx, [bp+arg_0]
		or	word ptr es:[bx+2], 10h

loc_11973:				; CODE XREF: sub_1192F+67j
					; sub_1192F+BEj ...
		mov	ax, 0FFFFh
		jmp	loc_11A10
; ---------------------------------------------------------------------------

loc_11979:				; CODE XREF: sub_1192F+3Aj
		les	bx, [bp+arg_0]
		or	word ptr es:[bx+2], 80h
		cmp	word ptr es:[bx+6], 0
		jz	short loc_1199A
		push	word ptr [bp+arg_0+2]
		push	word ptr [bp+arg_0]
		call	sub_11899
		or	ax, ax
		jz	short loc_11998
		jmp	short loc_11973
; ---------------------------------------------------------------------------

loc_11998:				; CODE XREF: sub_1192F+65j
		jmp	short loc_1193C
; ---------------------------------------------------------------------------

loc_1199A:				; CODE XREF: sub_1192F+58j
					; sub_1192F+D2j
		les	bx, [bp+arg_0]
		test	word ptr es:[bx+2], 200h
		jz	short loc_119A8
		call	sub_11859

loc_119A8:				; CODE XREF: sub_1192F+74j
		mov	ax, 1
		push	ax
		push	ds
		mov	ax, 2EE8h
		push	ax
		les	bx, [bp+arg_0]
		mov	al, es:[bx+4]
		cbw
		push	ax
		call	sub_11F10
		add	sp, 8
		or	ax, ax
		jnz	short loc_119F1
		les	bx, [bp+arg_0]
		mov	al, es:[bx+4]
		cbw
		push	ax
		call	sub_117F1
		pop	cx
		cmp	ax, 1
		jz	short loc_119DC
		jmp	short loc_1196B
; ---------------------------------------------------------------------------

loc_119DC:				; CODE XREF: sub_1192F+A9j
		les	bx, [bp+arg_0]
		mov	ax, es:[bx+2]
		and	ax, 0FE7Fh
		or	ax, 20h
		mov	es:[bx+2], ax
		jmp	short loc_11973
; ---------------------------------------------------------------------------
		jmp	short loc_11973
; ---------------------------------------------------------------------------

loc_119F1:				; CODE XREF: sub_1192F+95j
		cmp	byte_19378, 0Dh
		jnz	short loc_11A03
		les	bx, [bp+arg_0]
		test	word ptr es:[bx+2], 40h
		jz	short loc_1199A

loc_11A03:				; CODE XREF: sub_1192F+C7j
		les	bx, [bp+arg_0]
		and	word ptr es:[bx+2], 0FFDFh
		mov	al, byte_19378

loc_11A0E:				; CODE XREF: sub_1192F+28j
		mov	ah, 0

loc_11A10:				; CODE XREF: sub_1192F+47j
		pop	si
		pop	bp
		retf
sub_1192F	endp

; ---------------------------------------------------------------------------
		push	ds
		mov	ax, 2B6Ch
		push	ax
		push	cs
		call	near ptr sub_1192F
		pop	cx
		pop	cx
		retf

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_11A1F	proc far		; CODE XREF: sub_1202D+9P

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
		jz	short loc_11A50
		mov	al, 0
		mov	ah, es:[di]
		mov	cx, 0FFFFh
		cld
		repne scasb
		not	cx
		dec	cx
		jz	short loc_11A50
		les	di, dword_192CE
		mov	word ptr [bp+var_4+2], es
		mov	bx, es
		or	bx, di
		mov	word ptr [bp+var_4], di
		jnz	short loc_11A5D

loc_11A50:				; CODE XREF: sub_11A1F+Fj
					; sub_11A1F+1Fj ...
		xor	dx, dx
		xor	ax, ax
		jmp	short loc_11A89
; ---------------------------------------------------------------------------

loc_11A56:				; CODE XREF: sub_11A1F+50j
					; sub_11A1F+58j ...
		add	word ptr [bp+var_4], 4
		les	di, [bp+var_4]

loc_11A5D:				; CODE XREF: sub_11A1F+2Fj
		les	di, es:[di]
		mov	bx, es
		or	bx, di
		jz	short loc_11A50
		mov	al, es:[di]
		or	al, al
		jz	short loc_11A50
		cmp	ah, al
		jnz	short loc_11A56
		mov	bx, cx
		cmp	byte ptr es:[bx+di], 3Dh ; '='
		jnz	short loc_11A56
		push	ds
		lds	si, [bp+arg_0]
		repe cmpsb
		pop	ds
		xchg	cx, bx
		jnz	short loc_11A56
		inc	di
		mov	ax, di
		mov	dx, es

loc_11A89:				; CODE XREF: sub_11A1F+35j
		pop	di
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_11A1F	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_11A8F	proc far		; CODE XREF: sub_11CB4+CCP
					; sub_11CB4+F4P

arg_0		= word ptr  6
arg_2		= word ptr  8
arg_4		= dword	ptr  0Ah
arg_8		= word ptr  0Eh

		push	bp
		mov	bp, sp
		push	ds
		mov	ah, 44h	; 'D'
		mov	al, byte ptr [bp+arg_2]
		mov	bx, [bp+arg_0]
		mov	cx, [bp+arg_8]
		lds	dx, [bp+arg_4]
		int	21h		; DOS -	2+ - IOCTL -
		pop	ds
		jb	short loc_11AB2
		cmp	[bp+arg_2], 0
		jnz	short loc_11AB0
		mov	ax, dx
		jmp	short loc_11AB6
; ---------------------------------------------------------------------------

loc_11AB0:				; CODE XREF: sub_11A8F+1Bj
		jmp	short loc_11AB6
; ---------------------------------------------------------------------------

loc_11AB2:				; CODE XREF: sub_11A8F+15j
		push	ax
		call	sub_11AB8

loc_11AB6:				; CODE XREF: sub_11A8F+1Fj
					; sub_11A8F:loc_11AB0j
		pop	bp
		retf
sub_11A8F	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_11AB8	proc near		; CODE XREF: sub_10266+14p
					; sub_117B6+18p ...

arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		push	si
		mov	si, [bp+arg_0]
		or	si, si
		jl	short loc_11AD8
		cmp	si, 58h	; 'X'
		jle	short loc_11ACB

loc_11AC8:				; CODE XREF: sub_11AB8+29j
		mov	si, 57h	; 'W'

loc_11ACB:				; CODE XREF: sub_11AB8+Ej
		mov	word_191DA, si
		mov	al, byte_191DC[si]
		cbw
		mov	si, ax
		jmp	short loc_11AE9
; ---------------------------------------------------------------------------

loc_11AD8:				; CODE XREF: sub_11AB8+9j
		mov	ax, si
		neg	ax
		mov	si, ax
		cmp	si, 23h	; '#'
		jg	short loc_11AC8
		mov	word_191DA, 0FFFFh

loc_11AE9:				; CODE XREF: sub_11AB8+1Ej
		mov	word_1650D, si
		mov	ax, 0FFFFh
		pop	si
		pop	bp
		retn	2
sub_11AB8	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_11AF5	proc far		; CODE XREF: fopen2+67P seg000:0F58P ...

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
sub_11AF5	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_11B06	proc far		; CODE XREF: sub_10A38+65P
					; sub_11197+10P ...

arg_0		= word ptr  6
arg_2		= word ptr  8
arg_4		= word ptr  0Ah
arg_6		= byte ptr  0Ch

		push	bp
		mov	bp, sp
		mov	bx, [bp+arg_0]
		shl	bx, 1
		and	word ptr [bx+2CFCh], 0FDFFh
		mov	ah, 42h	; 'B'
		mov	al, [bp+arg_6]
		mov	bx, [bp+arg_0]
		mov	cx, [bp+arg_4]
		mov	dx, [bp+arg_2]
		int	21h		; DOS -	2+ - MOVE FILE READ/WRITE POINTER (LSEEK)
					; AL = method:
					; 0-from beginnig,1-from current,2-from	end
		jb	short loc_11B28
		jmp	short loc_11B2D
; ---------------------------------------------------------------------------

loc_11B28:				; CODE XREF: sub_11B06+1Ej
		push	ax
		call	sub_11AB8
		cwd

loc_11B2D:				; CODE XREF: sub_11B06+20j
		pop	bp
		retf
sub_11B06	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_11B2F	proc near		; CODE XREF: seg000:1BD6p
					; sub_11BDB+18p ...

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
		ja	short loc_11B9F
		cmp	bl, 2
		jb	short loc_11B9F
		mov	ax, [bp+arg_A]
		mov	cx, [bp+arg_C]
		or	cx, cx
		jge	short loc_11B64
		cmp	[bp+arg_2], 0
		jz	short loc_11B64
		mov	byte ptr es:[di], 2Dh ;	'-'
		inc	di
		neg	cx
		neg	ax
		sbb	cx, 0

loc_11B64:				; CODE XREF: sub_11B2F+21j
					; sub_11B2F+27j
		lea	si, [bp+var_22]
		jcxz	short loc_11B79

loc_11B69:				; CODE XREF: sub_11B2F+48j
		xchg	ax, cx
		sub	dx, dx
		div	bx
		xchg	ax, cx
		div	bx
		mov	ss:[si], dl
		inc	si
		jcxz	short loc_11B81
		jmp	short loc_11B69
; ---------------------------------------------------------------------------

loc_11B79:				; CODE XREF: sub_11B2F+38j
					; sub_11B2F+54j
		sub	dx, dx
		div	bx
		mov	ss:[si], dl
		inc	si

loc_11B81:				; CODE XREF: sub_11B2F+46j
		or	ax, ax
		jnz	short loc_11B79
		lea	cx, [bp+var_22]
		neg	cx
		add	cx, si
		cld

loc_11B8D:				; CODE XREF: sub_11B2F+6Ej
		dec	si
		mov	al, ss:[si]
		sub	al, 0Ah
		jnb	short loc_11B99
		add	al, 3Ah	; ':'
		jmp	short loc_11B9C
; ---------------------------------------------------------------------------

loc_11B99:				; CODE XREF: sub_11B2F+64j
		add	al, [bp+arg_0]

loc_11B9C:				; CODE XREF: sub_11B2F+68j
		stosb
		loop	loc_11B8D

loc_11B9F:				; CODE XREF: sub_11B2F+12j
					; sub_11B2F+17j
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
sub_11B2F	endp

; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		cmp	word ptr [bp+0Ch], 0Ah
		jnz	short loc_11BC0
		mov	ax, [bp+6]
		cwd
		jmp	short loc_11BC5
; ---------------------------------------------------------------------------

loc_11BC0:				; CODE XREF: seg000:1BB8j
		mov	ax, [bp+6]
		xor	dx, dx

loc_11BC5:				; CODE XREF: seg000:1BBEj
		push	dx
		push	ax
		push	word ptr [bp+0Ah]
		push	word ptr [bp+8]
		push	word ptr [bp+0Ch]
		mov	al, 1
		push	ax
		mov	al, 61h	; 'a'
		push	ax
		call	sub_11B2F
		pop	bp
		retf

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_11BDB	proc far		; CODE XREF: sub_114E2+41P

arg_0		= word ptr  6
arg_2		= word ptr  8
arg_4		= word ptr  0Ah
arg_6		= word ptr  0Ch
arg_8		= word ptr  0Eh

		push	bp
		mov	bp, sp
		push	[bp+arg_2]
		push	[bp+arg_0]
		push	[bp+arg_6]
		push	[bp+arg_4]
		push	[bp+arg_8]
		mov	al, 0
		push	ax
		mov	al, 61h	; 'a'
		push	ax
		call	sub_11B2F
		pop	bp
		retf
sub_11BDB	endp

; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		push	word ptr [bp+8]
		push	word ptr [bp+6]
		push	word ptr [bp+0Ch]
		push	word ptr [bp+0Ah]
		push	word ptr [bp+0Eh]
		cmp	word ptr [bp+0Eh], 0Ah
		jnz	short loc_11C15
		mov	ax, 1
		jmp	short loc_11C17
; ---------------------------------------------------------------------------

loc_11C15:				; CODE XREF: seg000:1C0Ej
		xor	ax, ax

loc_11C17:				; CODE XREF: seg000:1C13j
		push	ax
		mov	al, 61h	; 'a'
		push	ax
		call	sub_11B2F
		pop	bp
		retf

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_11C20	proc far		; CODE XREF: sub_10D74+DDP

arg_0		= dword	ptr  6
arg_4		= dword	ptr  0Ah
arg_8		= word ptr  0Eh

		push	bp
		mov	bp, sp
		push	si
		push	di
		mov	dx, ds
		les	di, [bp+arg_0]
		lds	si, [bp+arg_4]
		mov	cx, [bp+arg_8]
		shr	cx, 1
		cld
		rep movsw
		jnb	short loc_11C38
		movsb

loc_11C38:				; CODE XREF: sub_11C20+15j
		mov	ds, dx
		mov	dx, word ptr [bp+arg_0+2]
		mov	ax, word ptr [bp+arg_0]
		pop	di
		pop	si
		pop	bp
		retf
sub_11C20	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_11C44	proc far		; CODE XREF: sub_11C68+11p

arg_0		= dword	ptr  6
arg_4		= word ptr  0Ah
arg_6		= byte ptr  0Ch

		push	bp
		mov	bp, sp
		push	di
		les	di, [bp+arg_0]
		mov	cx, [bp+arg_4]
		mov	al, [bp+arg_6]
		mov	ah, al
		cld
		test	di, 1
		jz	short loc_11C5E
		jcxz	short loc_11C65
		stosb
		dec	cx

loc_11C5E:				; CODE XREF: sub_11C44+14j
		shr	cx, 1
		rep stosw
		jnb	short loc_11C65
		stosb

loc_11C65:				; CODE XREF: sub_11C44+16j
					; sub_11C44+1Ej
		pop	di
		pop	bp
		retf
sub_11C44	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_11C68	proc far		; CODE XREF: sub_1202D+102P

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
		call	near ptr sub_11C44
		add	sp, 8
		mov	dx, [bp+arg_2]
		mov	ax, [bp+arg_0]
		pop	bp
		retf
sub_11C68	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_11C87	proc near		; CODE XREF: sub_11CB4+74p
					; sub_11CB4+A2p

arg_0		= word ptr  4
arg_2		= dword	ptr  6

		push	bp
		mov	bp, sp
		push	ds
		mov	cx, [bp+arg_0]
		mov	ah, 3Ch	; '<'
		lds	dx, [bp+arg_2]
		int	21h		; DOS -	2+ - CREATE A FILE WITH	HANDLE (CREAT)
					; CX = attributes for file
					; DS:DX	-> ASCIZ filename (may include drive and path)
		pop	ds
		jb	short loc_11C9A
		jmp	short loc_11C9E
; ---------------------------------------------------------------------------

loc_11C9A:				; CODE XREF: sub_11C87+Fj
		push	ax
		call	sub_11AB8

loc_11C9E:				; CODE XREF: sub_11C87+11j
		pop	bp
		retn	6
sub_11C87	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_11CA2	proc near		; CODE XREF: sub_11CB4+105p

arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		mov	bx, [bp+arg_0]
		sub	cx, cx
		sub	dx, dx
		mov	ah, 40h
		int	21h		; DOS -	2+ - WRITE TO FILE WITH	HANDLE
					; BX = file handle, CX = number	of bytes to write, DS:DX -> buffer
		pop	bp
		retn	2
sub_11CA2	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_11CB4	proc far		; CODE XREF: fopen2+37P

var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  6
arg_2		= word ptr  8
arg_4		= word ptr  0Ah
arg_6		= word ptr  0Ch

		push	bp
		mov	bp, sp
		sub	sp, 4
		push	si
		push	di
		mov	si, [bp+arg_4]
		test	si, 0C000h
		jnz	short loc_11CD1
		mov	ax, word_191B4
		and	ax, 0C000h
		mov	dx, si
		or	dx, ax
		mov	si, dx

loc_11CD1:				; CODE XREF: sub_11CB4+Fj
		test	si, 100h
		jnz	short loc_11CDA
		jmp	loc_11D62
; ---------------------------------------------------------------------------

loc_11CDA:				; CODE XREF: sub_11CB4+21j
		mov	ax, word_191B6
		and	[bp+arg_6], ax
		mov	ax, [bp+arg_6]
		test	ax, 180h
		jnz	short loc_11CEF
		mov	ax, 1
		push	ax
		call	sub_11AB8

loc_11CEF:				; CODE XREF: sub_11CB4+32j
		xor	ax, ax
		push	ax
		push	[bp+arg_2]
		push	[bp+arg_0]
		call	sub_117B6
		add	sp, 6
		mov	[bp+var_2], ax
		cmp	ax, 0FFFFh
		jnz	short loc_11D34
		test	[bp+arg_6], 80h
		jz	short loc_11D13
		xor	ax, ax
		jmp	short loc_11D16
; ---------------------------------------------------------------------------

loc_11D13:				; CODE XREF: sub_11CB4+59j
		mov	ax, 1

loc_11D16:				; CODE XREF: sub_11CB4+5Dj
		mov	[bp+var_2], ax
		test	si, 0F0h
		jz	short loc_11D4D
		push	[bp+arg_2]
		push	[bp+arg_0]
		xor	ax, ax
		push	ax
		call	sub_11C87
		mov	di, ax
		or	ax, ax
		jge	short loc_11D44
		jmp	loc_11DFC
; ---------------------------------------------------------------------------

loc_11D34:				; CODE XREF: sub_11CB4+52j
		test	si, 400h
		jz	short loc_11D62
		mov	ax, 50h	; 'P'
		push	ax
		call	sub_11AB8
		jmp	loc_11DFE
; ---------------------------------------------------------------------------

loc_11D44:				; CODE XREF: sub_11CB4+7Bj
		push	di
		call	sub_117D3
		pop	cx
		jmp	short loc_11D67
; ---------------------------------------------------------------------------

loc_11D4D:				; CODE XREF: sub_11CB4+69j
		push	[bp+arg_2]
		push	[bp+arg_0]
		push	[bp+var_2]
		call	sub_11C87
		mov	di, ax
		or	ax, ax
		jge	short loc_11DDB
		jmp	loc_11DFC
; ---------------------------------------------------------------------------

loc_11D62:				; CODE XREF: sub_11CB4+23j
					; sub_11CB4+84j
		mov	[bp+var_2], 0

loc_11D67:				; CODE XREF: sub_11CB4+97j
		push	si
		push	[bp+arg_2]
		push	[bp+arg_0]
		call	sub_11E04
		add	sp, 6
		mov	di, ax
		or	ax, ax
		jl	short loc_11DDB
		xor	ax, ax
		push	ax
		push	di
		call	sub_11A8F
		pop	cx
		pop	cx
		mov	[bp+var_4], ax
		test	ax, 80h
		jz	short loc_11DB2
		or	si, 2000h
		test	si, 8000h
		jz	short loc_11DBC
		and	ax, 0FFh
		or	ax, 20h
		xor	dx, dx
		push	dx
		push	ax
		mov	ax, 1
		push	ax
		push	di
		call	sub_11A8F
		add	sp, 8
		jmp	short loc_11DBC
; ---------------------------------------------------------------------------

loc_11DB2:				; CODE XREF: sub_11CB4+D9j
		test	si, 200h
		jz	short loc_11DBC
		push	di
		call	sub_11CA2

loc_11DBC:				; CODE XREF: sub_11CB4+E3j
					; sub_11CB4+FCj ...
		cmp	[bp+var_2], 0
		jz	short loc_11DDB
		test	si, 0F0h
		jz	short loc_11DDB
		mov	ax, 1
		push	ax
		push	ax
		push	[bp+arg_2]
		push	[bp+arg_0]
		call	sub_117B6
		add	sp, 8

loc_11DDB:				; CODE XREF: sub_11CB4+A9j
					; sub_11CB4+C6j ...
		or	di, di
		jl	short loc_11DFC
		test	si, 300h
		jz	short loc_11DEA
		mov	ax, 1000h
		jmp	short loc_11DEC
; ---------------------------------------------------------------------------

loc_11DEA:				; CODE XREF: sub_11CB4+12Fj
		xor	ax, ax

loc_11DEC:				; CODE XREF: sub_11CB4+134j
		mov	dx, si
		and	dx, 0F8FFh
		or	dx, ax
		mov	bx, di
		shl	bx, 1
		mov	[bx+2CFCh], dx

loc_11DFC:				; CODE XREF: sub_11CB4+7Dj
					; sub_11CB4+ABj ...
		mov	ax, di

loc_11DFE:				; CODE XREF: sub_11CB4+8Dj
		pop	di
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_11CB4	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_11E04	proc far		; CODE XREF: sub_11CB4+BAP

var_2		= word ptr -2
arg_0		= dword	ptr  6
arg_4		= word ptr  0Ah

		push	bp
		mov	bp, sp
		dec	sp
		dec	sp
		mov	al, 1
		mov	cx, [bp+arg_4]
		test	cx, 2
		jnz	short loc_11E1E
		mov	al, 2
		test	cx, 4
		jnz	short loc_11E1E
		mov	al, 0

loc_11E1E:				; CODE XREF: sub_11E04+Ej
					; sub_11E04+16j
		push	ds
		lds	dx, [bp+arg_0]
		mov	cl, 0F0h ; 'ð'
		and	cl, byte ptr [bp+arg_4]
		or	al, cl
		mov	ah, 3Dh
		int	21h		; DOS -	2+ - OPEN DISK FILE WITH HANDLE
					; DS:DX	-> ASCIZ filename
					; AL = access mode
					; 0 - read, 1 -	write, 2 - read	& write
		pop	ds
		jb	short loc_11E4A
		mov	[bp+var_2], ax
		mov	bx, [bp+var_2]
		shl	bx, 1
		mov	ax, [bp+arg_4]
		and	ax, 0F8FFh
		or	ax, 8000h
		mov	[bx+2CFCh], ax
		mov	ax, [bp+var_2]
		jmp	short loc_11E4E
; ---------------------------------------------------------------------------

loc_11E4A:				; CODE XREF: sub_11E04+2Aj
		push	ax
		call	sub_11AB8

loc_11E4E:				; CODE XREF: sub_11E04+44j
		mov	sp, bp
		pop	bp
		retf
sub_11E04	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_11E52	proc far		; CODE XREF: sub_11899+30P

var_3		= byte ptr -3
var_2		= word ptr -2
arg_0		= word ptr  6
arg_2		= dword	ptr  8
arg_6		= word ptr  0Ch

		push	bp
		mov	bp, sp
		sub	sp, 4
		push	si
		push	di
		mov	ax, [bp+arg_6]
		inc	ax
		cmp	ax, 2
		jb	short loc_11E70
		mov	bx, [bp+arg_0]
		shl	bx, 1
		test	word ptr [bx+2CFCh], 200h
		jz	short loc_11E75

loc_11E70:				; CODE XREF: sub_11E52+Fj
		xor	ax, ax
		jmp	loc_11F0A
; ---------------------------------------------------------------------------

loc_11E75:				; CODE XREF: sub_11E52+1Cj
					; sub_11E52+8Fj
		push	[bp+arg_6]
		push	word ptr [bp+arg_2+2]
		push	word ptr [bp+arg_2]
		push	[bp+arg_0]
		call	sub_11F10
		add	sp, 8
		mov	[bp+var_2], ax
		inc	ax
		cmp	ax, 2
		jb	short loc_11E9F
		mov	bx, [bp+arg_0]
		shl	bx, 1
		test	word ptr [bx+2CFCh], 8000h
		jz	short loc_11EA4

loc_11E9F:				; CODE XREF: sub_11E52+3Ej
		mov	ax, [bp+var_2]
		jmp	short loc_11F0A
; ---------------------------------------------------------------------------

loc_11EA4:				; CODE XREF: sub_11E52+4Bj
		mov	cx, [bp+var_2]
		les	si, [bp+arg_2]
		mov	di, si
		mov	bx, si
		cld

loc_11EAF:				; CODE XREF: sub_11E52+68j
					; sub_11E52:loc_11EBEj
		lods	byte ptr es:[si]
		cmp	al, 1Ah
		jz	short loc_11EE5
		cmp	al, 0Dh
		jz	short loc_11EBE
		stosb
		loop	loc_11EAF
		jmp	short loc_11EDD
; ---------------------------------------------------------------------------

loc_11EBE:				; CODE XREF: sub_11E52+65j
		loop	loc_11EAF
		push	es
		push	bx
		mov	ax, 1
		push	ax
		lea	ax, [bp+var_3]
		push	ss
		push	ax
		push	[bp+arg_0]
		call	sub_11F10
		add	sp, 8
		pop	bx
		pop	es
		cld
		mov	al, [bp+var_3]
		stosb

loc_11EDD:				; CODE XREF: sub_11E52+6Aj
		cmp	di, bx
		jnz	short loc_11EE3
		jmp	short loc_11E75
; ---------------------------------------------------------------------------

loc_11EE3:				; CODE XREF: sub_11E52+8Dj
		jmp	short loc_11F07
; ---------------------------------------------------------------------------

loc_11EE5:				; CODE XREF: sub_11E52+61j
		push	bx
		mov	ax, 1
		push	ax
		neg	cx
		sbb	ax, ax
		push	ax
		push	cx
		push	[bp+arg_0]
		call	sub_11B06
		add	sp, 8
		mov	bx, [bp+arg_0]
		shl	bx, 1
		or	word ptr [bx+2CFCh], 200h
		pop	bx

loc_11F07:				; CODE XREF: sub_11E52:loc_11EE3j
		sub	di, bx
		xchg	ax, di

loc_11F0A:				; CODE XREF: sub_11E52+20j
					; sub_11E52+50j
		pop	di
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_11E52	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_11F10	proc far		; CODE XREF: sub_1082B+68P
					; sub_1192F+8BP ...

arg_0		= word ptr  6
arg_2		= dword	ptr  8
arg_6		= word ptr  0Ch

		push	bp
		mov	bp, sp
		push	ds
		mov	ah, 3Fh	; '?'
		mov	bx, [bp+arg_0]
		mov	cx, [bp+arg_6]
		lds	dx, [bp+arg_2]
		int	21h		; DOS -	2+ - READ FROM FILE WITH HANDLE
					; BX = file handle, CX = number	of bytes to read
					; DS:DX	-> buffer
		pop	ds
		jb	short loc_11F26
		jmp	short loc_11F2A
; ---------------------------------------------------------------------------

loc_11F26:				; CODE XREF: sub_11F10+12j
		push	ax
		call	sub_11AB8

loc_11F2A:				; CODE XREF: sub_11F10+14j
		pop	bp
		retf
sub_11F10	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_11F2C	proc far		; CODE XREF: sub_102B9+51P

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
		jb	short loc_11F40
		mov	ax, 0FFFFh
		jmp	short loc_11F46
; ---------------------------------------------------------------------------

loc_11F40:				; CODE XREF: sub_11F2C+Dj
		push	bx
		push	ax
		call	sub_11AB8
		pop	ax

loc_11F46:				; CODE XREF: sub_11F2C+12j
		pop	bp
		retf
sub_11F2C	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_11F48	proc far		; CODE XREF: seg000:1112P

arg_0		= dword	ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ah, 2Bh	; '+'
		les	si, [bp+arg_0]
		mov	cx, es:[si]
		mov	dx, es:[si+2]
		int	21h		; DOS -	SET CURRENT DATE
					; DL = day, DH = month,	CX = year
					; Return: AL = 00h if no error /= FFh if bad value sent	to routine
		pop	si
		pop	bp
		retf
sub_11F48	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_11F5D	proc far		; CODE XREF: seg000:111EP

arg_0		= dword	ptr  6

		push	bp
		mov	bp, sp
		push	si
		mov	ah, 2Dh	; '-'
		les	si, [bp+arg_0]
		mov	cx, es:[si]
		mov	dx, es:[si+2]
		int	21h		; DOS -	SET CURRENT TIME
					; CH = hours, CL = minutes, DH = seconds, DL = hundredths of seconds
					; Return: AL = 00h if no error / = FFh if bad value sent to routine
		pop	si
		pop	bp
		retf
sub_11F5D	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

strcat		proc far		; CODE XREF: sub_114E2+25P
					; sub_114E2+54P

arg_0		= dword	ptr  6
arg_4		= dword	ptr  0Ah

		push	bp
		mov	bp, sp
		push	si
		push	di
		cld
		push	ds
		les	di, [bp+arg_0]
		mov	dx, di
		xor	al, al
		mov	cx, 0FFFFh
		repne scasb
		push	es
		lea	si, [di-1]
		les	di, [bp+arg_4]
		mov	cx, 0FFFFh
		repne scasb
		not	cx
		sub	di, cx
		push	es
		pop	ds
		pop	es
		xchg	si, di
		test	si, 1
		jz	short loc_11FA2
		movsb
		dec	cx

loc_11FA2:				; CODE XREF: strcat+2Cj
		shr	cx, 1
		rep movsw
		jnb	short loc_11FA9
		movsb

loc_11FA9:				; CODE XREF: strcat+34j
		xchg	ax, dx
		mov	dx, es
		pop	ds
		pop	di
		pop	si
		pop	bp
		retf
strcat		endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_11FB1	proc far		; CODE XREF: sub_1202D+D3P
					; sub_1202D+E8P

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
sub_11FB1	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_11FDA	proc far		; CODE XREF: sub_1202D+23P
					; sub_1202D+175P

arg_0		= dword	ptr  6

		push	bp
		mov	bp, sp
		push	di
		les	di, [bp+arg_0]
		xor	ax, ax
		cmp	ax, word ptr [bp+arg_0+2]
		jnz	short loc_11FEC
		cmp	ax, di
		jz	short loc_11FF6

loc_11FEC:				; CODE XREF: sub_11FDA+Cj
		cld
		mov	cx, 0FFFFh
		repne scasb
		xchg	ax, cx
		not	ax
		dec	ax

loc_11FF6:				; CODE XREF: sub_11FDA+10j
		pop	di
		pop	bp
		retf
sub_11FDA	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_11FF9	proc far		; CODE XREF: sub_1202D+11CP
					; sub_1202D+1BEP

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
sub_11FF9	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1202A	proc near		; CODE XREF: sub_111B1+8P sub_112DE+3P
		push	bp
		mov	bp, sp
sub_1202A	endp ; sp-analysis failed


; =============== S U B	R O U T	I N E =======================================


sub_1202D	proc far		; CODE XREF: sub_12355+17p
					; DATA XREF: dseg:off_1649Eo
		sub	sp, 4
		push	si
		push	ds
		mov	ax, offset aTz	; "TZ"
		push	ax
		call	sub_11A1F
		pop	cx
		pop	cx
		mov	[bp-4],	ax
		mov	[bp-2],	dx
		or	ax, dx
		jnz	short loc_1204A
		jmp	loc_120E1
; ---------------------------------------------------------------------------

loc_1204A:				; CODE XREF: sub_1202D+18j
		push	word ptr [bp-2]
		push	word ptr [bp-4]
		call	sub_11FDA
		pop	cx
		pop	cx
		cmp	ax, 4
		jnb	short loc_1205F
		jmp	loc_120E1
; ---------------------------------------------------------------------------

loc_1205F:				; CODE XREF: sub_1202D+2Dj
		les	bx, [bp-4]
		mov	al, es:[bx]
		cbw
		mov	bx, ax
		mov	al, byte_18EED[bx]
		cbw
		test	ax, 0Ch
		jz	short loc_120E1
		mov	bx, [bp-4]
		mov	al, es:[bx+1]
		cbw
		mov	bx, ax
		mov	al, byte_18EED[bx]
		cbw
		test	ax, 0Ch
		jz	short loc_120E1
		mov	bx, [bp-4]
		mov	al, es:[bx+2]
		cbw
		mov	bx, ax
		mov	al, byte_18EED[bx]
		cbw
		test	ax, 0Ch
		jz	short loc_120E1
		mov	bx, [bp-4]
		cmp	byte ptr es:[bx+3], '-'
		jz	short loc_120B9
		cmp	byte ptr es:[bx+3], '+'
		jz	short loc_120B9
		mov	al, es:[bx+3]
		cbw
		mov	bx, ax
		test	byte_18EED[bx],	2
		jz	short loc_120E1

loc_120B9:				; CODE XREF: sub_1202D+75j
					; sub_1202D+7Cj
		les	bx, [bp-4]
		mov	al, es:[bx+3]
		cbw
		mov	bx, ax
		mov	al, byte_18EED[bx]
		cbw
		test	ax, 2
		jnz	short loc_12120
		mov	bx, [bp-4]
		mov	al, es:[bx+4]
		cbw
		mov	bx, ax
		mov	al, byte_18EED[bx]
		cbw
		test	ax, 2
		jnz	short loc_12120

loc_120E1:				; CODE XREF: sub_1202D+1Aj
					; sub_1202D+2Fj ...
		mov	word_1925C, 0
		mov	word_19258, 8170h
		mov	word_1925A, 0FFFFh
		push	ds
		mov	ax, offset aJst	; "JST"
		push	ax
		push	seg_19252
		push	word_19250
		call	sub_11FB1
		add	sp, 8
		push	ds
		mov	ax, offset unk_19265
		push	ax
		push	seg_19256
		push	word_19254
		call	sub_11FB1
		add	sp, 8
		jmp	loc_12211
; ---------------------------------------------------------------------------

loc_12120:				; CODE XREF: sub_1202D+9Ej
					; sub_1202D+B2j
		mov	ax, 4
		push	ax
		xor	ax, ax
		push	ax
		push	seg_19256
		push	word_19254
		call	sub_11C68
		add	sp, 8
		mov	ax, 3
		push	ax
		push	word ptr [bp-2]
		push	word ptr [bp-4]
		push	seg_19252
		push	word_19250
		call	sub_11FF9
		add	sp, 0Ah
		les	bx, dword ptr word_19250
		mov	byte ptr es:[bx+3], 0
		mov	ax, [bp-4]
		add	ax, 3
		push	word ptr [bp-2]
		push	ax
		call	sub_11730
		pop	cx
		pop	cx
		push	ax
		push	dx
		xor	dx, dx
		mov	ax, 3600
		pop	cx
		pop	bx
		call	sub_12DB1
		mov	word_19258, ax
		mov	word_1925A, dx
		mov	word_1925C, 0
		mov	si, 3
		jmp	short loc_12205
; ---------------------------------------------------------------------------

loc_12189:				; CODE XREF: sub_1202D+1E1j
		les	bx, [bp-4]
		mov	al, es:[bx+si]
		cbw
		mov	bx, ax
		test	byte_18EED[bx],	0Ch
		jz	short loc_12204
		mov	ax, [bp-4]
		add	ax, si
		push	word ptr [bp-2]
		push	ax
		call	sub_11FDA
		pop	cx
		pop	cx
		cmp	ax, 3
		jb	short loc_12211
		les	bx, [bp-4]
		mov	al, es:[bx+si+1]
		cbw
		mov	bx, ax
		mov	al, byte_18EED[bx]
		cbw
		test	ax, 0Ch
		jz	short loc_12211
		mov	bx, [bp-4]
		mov	al, es:[bx+si+2]
		cbw
		mov	bx, ax
		mov	al, byte_18EED[bx]
		cbw
		test	ax, 0Ch
		jz	short loc_12211
		mov	ax, 3
		push	ax
		mov	ax, [bp-4]
		add	ax, si
		push	word ptr [bp-2]
		push	ax
		push	seg_19256
		push	word_19254
		call	sub_11FF9
		add	sp, 0Ah
		les	bx, dword ptr word_19254
		mov	byte ptr es:[bx+3], 0
		mov	word_1925C, 1
		jmp	short loc_12211
; ---------------------------------------------------------------------------

loc_12204:				; CODE XREF: sub_1202D+16Aj
		inc	si

loc_12205:				; CODE XREF: sub_1202D+15Aj
		les	bx, [bp-4]
		cmp	byte ptr es:[bx+si], 0
		jz	short loc_12211
		jmp	loc_12189
; ---------------------------------------------------------------------------

loc_12211:				; CODE XREF: sub_1202D+F0j
					; sub_1202D+17Fj ...
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_1202D	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_12216	proc near		; CODE XREF: sub_111B1+D2p
					; sub_112DE+130p

arg_0		= word ptr  4
arg_2		= word ptr  6
arg_4		= word ptr  8
arg_6		= byte ptr  0Ah

		push	bp
		mov	bp, sp
		push	si
		cmp	[bp+arg_2], 0
		jnz	short loc_1224C
		mov	si, [bp+arg_4]
		cmp	[bp+arg_4], 3Bh	; ';'
		jb	short loc_12235
		mov	ax, [bp+arg_0]
		add	ax, 46h	; 'F'
		test	ax, 3
		jnz	short loc_12235
		dec	si

loc_12235:				; CODE XREF: sub_12216+11j
					; sub_12216+1Cj
		mov	[bp+arg_2], 0
		jmp	short loc_1223F
; ---------------------------------------------------------------------------

loc_1223C:				; CODE XREF: sub_12216+32j
		inc	[bp+arg_2]

loc_1223F:				; CODE XREF: sub_12216+24j
		mov	bx, [bp+arg_2]
		shl	bx, 1
		cmp	word_19236[bx],	si
		jbe	short loc_1223C
		jmp	short loc_1226D
; ---------------------------------------------------------------------------

loc_1224C:				; CODE XREF: sub_12216+8j
		cmp	[bp+arg_2], 3
		jb	short loc_1225D
		mov	ax, [bp+arg_0]
		add	ax, 46h	; 'F'
		test	ax, 3
		jz	short loc_12260

loc_1225D:				; CODE XREF: sub_12216+3Aj
		dec	[bp+arg_4]

loc_12260:				; CODE XREF: sub_12216+45j
		mov	bx, [bp+arg_2]
		dec	bx
		shl	bx, 1
		mov	ax, word_19236[bx]
		add	[bp+arg_4], ax

loc_1226D:				; CODE XREF: sub_12216+34j
		cmp	[bp+arg_2], 4
		jb	short loc_122EE
		jz	short loc_1227D
		cmp	[bp+arg_2], 0Ah
		ja	short loc_122EE
		jnz	short loc_122E9

loc_1227D:				; CODE XREF: sub_12216+5Dj
		mov	bx, [bp+arg_2]
		shl	bx, 1
		cmp	[bp+arg_0], 10h
		jle	short loc_12297
		cmp	[bp+arg_2], 4
		jnz	short loc_12297
		mov	cx, word_19234[bx]
		add	cx, 7
		jmp	short loc_1229B
; ---------------------------------------------------------------------------

loc_12297:				; CODE XREF: sub_12216+70j
					; sub_12216+76j
		mov	cx, word_19236[bx]

loc_1229B:				; CODE XREF: sub_12216+7Fj
		mov	bx, [bp+arg_0]
		add	bx, 1970
		test	bl, 3
		jz	short loc_122A8
		dec	cx

loc_122A8:				; CODE XREF: sub_12216+8Fj
		mov	bx, [bp+arg_0]
		inc	bx
		sar	bx, 1
		sar	bx, 1
		add	bx, cx
		mov	ax, 365
		mul	[bp+arg_0]
		add	ax, bx
		add	ax, 4
		xor	dx, dx
		mov	bx, 7
		div	bx
		sub	cx, dx
		mov	ax, [bp+arg_4]
		cmp	[bp+arg_2], 4
		jnz	short loc_122DD
		cmp	ax, cx
		ja	short loc_122E9
		jnz	short loc_122EE
		cmp	[bp+arg_6], 2
		jb	short loc_122EE
		jmp	short loc_122E9
; ---------------------------------------------------------------------------

loc_122DD:				; CODE XREF: sub_12216+B7j
		cmp	ax, cx
		jb	short loc_122E9
		jnz	short loc_122EE
		cmp	[bp+arg_6], 1
		ja	short loc_122EE

loc_122E9:				; CODE XREF: sub_12216+65j
					; sub_12216+BBj ...
		mov	ax, 1
		jmp	short loc_122F0
; ---------------------------------------------------------------------------

loc_122EE:				; CODE XREF: sub_12216+5Bj
					; sub_12216+63j ...
		xor	ax, ax

loc_122F0:				; CODE XREF: sub_12216+D6j
		pop	si
		pop	bp
		retn	8
sub_12216	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

file_remove	proc far		; CODE XREF: sub_103E5+9AP

arg_0		= dword	ptr  6

		push	bp
		mov	bp, sp
		push	ds
		mov	ah, 41h
		lds	dx, [bp+arg_0]
		int	21h		; DOS -	2+ - DELETE A FILE (UNLINK)
					; DS:DX	-> ASCIZ pathname of file to delete (no	wildcards allowed)
		pop	ds
		jb	short loc_12307
		xor	ax, ax
		jmp	short loc_1230B
; ---------------------------------------------------------------------------

loc_12307:				; CODE XREF: file_remove+Cj
		push	ax
		call	sub_11AB8

loc_1230B:				; CODE XREF: file_remove+10j
		pop	bp
		retf
file_remove	endp


; =============== S U B	R O U T	I N E =======================================


sub_1230D	proc near		; CODE XREF: sub_12325+274p
					; sub_12325+27Dp
		mov	al, dh
		call	sub_12314
		mov	al, dl
sub_1230D	endp ; sp-analysis failed


; =============== S U B	R O U T	I N E =======================================


sub_12314	proc near		; CODE XREF: sub_1230D+2p
		aam	10h
		xchg	ah, al
		call	bcd_add
		xchg	ah, al
sub_12314	endp ; sp-analysis failed


; =============== S U B	R O U T	I N E =======================================


bcd_add		proc near		; CODE XREF: sub_12314+4p
		add	al, 90h	; ''
		daa
		adc	al, 40h	; '@'
		daa
		stosb
		retn
bcd_add		endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_12325	proc near		; CODE XREF: DoPrintThing+16p

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

; FUNCTION CHUNK AT 2389 SIZE 00000444 BYTES

		push	bp
		mov	bp, sp
		sub	sp, 96h
		push	si
		push	di
		mov	[bp+var_12], 0
		mov	[bp+var_14], 50h ; 'P'
		mov	[bp+var_16], 0
		jmp	short loc_12389
sub_12325	endp


; =============== S U B	R O U T	I N E =======================================


sub_1233F	proc near		; CODE XREF: sub_12325:loc_12613p
					; sub_12325:loc_12673p	...
		push	di
		mov	cx, 0FFFFh
		xor	al, al
		repne scasb
		not	cx
		dec	cx
		pop	di
		retn
sub_1233F	endp


; =============== S U B	R O U T	I N E =======================================


sub_1234C	proc near		; CODE XREF: sub_12325+224p
					; sub_12325+3CCp ...
		mov	ss:[di], al
		inc	di
		dec	byte ptr [bp-14h]
		jnz	short locret_12388
sub_1234C	endp ; sp-analysis failed


; =============== S U B	R O U T	I N E =======================================


sub_12355	proc near		; CODE XREF: sub_12325+86p
					; sub_12325+423p ...
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
		call	ss:off_1649E[bp]
		or	ax, ax
		jnz	short loc_12378
		mov	word ptr [bp-16h], 1

loc_12378:				; CODE XREF: sub_12355+1Cj
		mov	word ptr [bp-14h], 50h ; 'P'
		add	[bp-12h], di
		lea	di, [bp-96h]
		pop	es
		pop	dx
		pop	cx
		pop	bx

locret_12388:				; CODE XREF: sub_1234C+7j
		retn
sub_12355	endp ; sp-analysis failed

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_12325

loc_12389:				; CODE XREF: sub_12325+18j
		push	es
		cld
		lea	di, [bp+var_96]
		mov	[bp+var_4], di

loc_12392:				; CODE XREF: sub_12325:loc_12796j
		mov	di, [bp+var_4]

loc_12395:				; CODE XREF: sub_12325:loc_1254Ej
					; sub_12325:loc_1275Aj
		les	si, [bp+arg_2]

loc_12398:				; CODE XREF: sub_12325+84j
					; sub_12325+89j
		lods	byte ptr es:[si]
		or	al, al
		jz	short loc_123B0
		cmp	al, 25h	; '%'
		jz	short loc_123B3

loc_123A2:				; CODE XREF: sub_12325+95j
		mov	ss:[di], al
		inc	di
		dec	byte ptr [bp+var_14]
		jg	short loc_12398
		call	sub_12355
		jmp	short loc_12398
; ---------------------------------------------------------------------------

loc_123B0:				; CODE XREF: sub_12325+77j
		jmp	loc_127AD
; ---------------------------------------------------------------------------

loc_123B3:				; CODE XREF: sub_12325+7Bj
		mov	[bp+var_10], si
		lods	byte ptr es:[si]
		cmp	al, 25h	; '%'
		jz	short loc_123A2
		mov	[bp+var_4], di
		xor	cx, cx
		mov	[bp+var_E], cx
		mov	[bp+var_2], 20h
		mov	[bp+var_B], cl
		mov	[bp+var_8], 0FFFFh
		mov	[bp+var_A], 0FFFFh
		jmp	short loc_123DA
; ---------------------------------------------------------------------------

loc_123D8:				; CODE XREF: sub_12325+E2j
					; sub_12325+EDj ...
		lods	byte ptr es:[si]

loc_123DA:				; CODE XREF: sub_12325+B1j
		xor	ah, ah
		mov	dx, ax
		mov	bx, ax
		sub	bl, 20h
		cmp	bl, 60h
		jnb	short loc_123FB
		mov	bl, byte_1926D[bx]
		cmp	bx, 17h		; switch 24 cases
		jbe	short loc_123F4
		jmp	loc_12799	; jumptable 000123F6 default case
; ---------------------------------------------------------------------------

loc_123F4:				; CODE XREF: sub_12325+CAj
		shl	bx, 1
		jmp	cs:off_127CD[bx] ; switch jump
; ---------------------------------------------------------------------------

loc_123FB:				; CODE XREF: sub_12325+C1j
					; sub_12325+DCj ...
		jmp	loc_12799	; jumptable 000123F6 default case
; ---------------------------------------------------------------------------

loc_123FE:				; CODE XREF: sub_12325+D1j
					; DATA XREF: seg000:off_127CDo
		cmp	ch, 0		; jumptable 000123F6 case 1
		ja	short loc_123FB
		or	[bp+var_2], 1
		jmp	short loc_123D8
; ---------------------------------------------------------------------------

loc_12409:				; CODE XREF: sub_12325+D1j
					; DATA XREF: seg000:off_127CDo
		cmp	ch, 0		; jumptable 000123F6 case 3
		ja	short loc_123FB
		or	[bp+var_2], 2
		jmp	short loc_123D8
; ---------------------------------------------------------------------------

loc_12414:				; CODE XREF: sub_12325+D1j
					; DATA XREF: seg000:off_127CDo
		cmp	ch, 0		; jumptable 000123F6 case 0
		ja	short loc_123FB
		cmp	[bp+var_B], 2Bh
		jz	short loc_12422
		mov	[bp+var_B], dl

loc_12422:				; CODE XREF: sub_12325+F8j
		jmp	short loc_123D8
; ---------------------------------------------------------------------------

loc_12424:				; CODE XREF: sub_12325+D1j
					; DATA XREF: seg000:off_127CDo
		and	[bp+var_2], 0FFDFh ; jumptable 000123F6	case 22
		jmp	short loc_1242E
; ---------------------------------------------------------------------------

loc_1242A:				; CODE XREF: sub_12325+D1j
					; DATA XREF: seg000:off_127CDo
		or	[bp+var_2], 20h	; jumptable 000123F6 case 23

loc_1242E:				; CODE XREF: sub_12325+103j
					; sub_12325+1A1j ...
		mov	ch, 5
		jmp	short loc_123D8
; ---------------------------------------------------------------------------

loc_12432:				; CODE XREF: sub_12325+D1j
					; DATA XREF: seg000:off_127CDo
		cmp	ch, 0		; jumptable 000123F6 case 9
		ja	short loc_12484	; jumptable 000123F6 case 5
		test	[bp+var_2], 2
		jnz	short loc_12467
		or	[bp+var_2], 8
		mov	ch, 1
		jmp	short loc_123D8
; ---------------------------------------------------------------------------

loc_12446:				; CODE XREF: sub_12325+148j
					; sub_12325+155j ...
		jmp	loc_12799	; jumptable 000123F6 default case
; ---------------------------------------------------------------------------

loc_12449:				; CODE XREF: sub_12325+D1j
					; DATA XREF: seg000:off_127CDo
		mov	di, [bp+arg_0]	; jumptable 000123F6 case 2
		mov	ax, ss:[di]
		add	[bp+arg_0], 2
		cmp	ch, 2
		jnb	short loc_1246A
		or	ax, ax
		jns	short loc_12462
		neg	ax
		or	[bp+var_2], 2

loc_12462:				; CODE XREF: sub_12325+135j
		mov	[bp+var_8], ax
		mov	ch, 3

loc_12467:				; CODE XREF: sub_12325+117j
					; sub_12325+16Fj ...
		jmp	loc_123D8
; ---------------------------------------------------------------------------

loc_1246A:				; CODE XREF: sub_12325+131j
		cmp	ch, 4
		jnz	short loc_12446
		mov	[bp+var_A], ax
		inc	ch
		jmp	loc_123D8
; ---------------------------------------------------------------------------

loc_12477:				; CODE XREF: sub_12325+D1j
					; DATA XREF: seg000:off_127CDo
		cmp	ch, 4		; jumptable 000123F6 case 4
		jnb	short loc_12446
		mov	ch, 4
		inc	[bp+var_A]
		jmp	loc_123D8
; ---------------------------------------------------------------------------

loc_12484:				; CODE XREF: sub_12325+D1j
					; sub_12325+110j
					; DATA XREF: ...
		xchg	ax, dx		; jumptable 000123F6 case 5
		sub	al, '0'
		cbw
		cmp	ch, 2
		ja	short loc_124A6
		mov	ch, 2
		xchg	ax, [bp+var_8]
		or	ax, ax
		jl	short loc_12467
		shl	ax, 1
		mov	dx, ax
		shl	ax, 1
		shl	ax, 1
		add	ax, dx
		add	[bp+var_8], ax
		jmp	loc_123D8
; ---------------------------------------------------------------------------

loc_124A6:				; CODE XREF: sub_12325+166j
		cmp	ch, 4
		jnz	short loc_12446
		xchg	ax, [bp+var_A]
		or	ax, ax
		jz	short loc_12467
		shl	ax, 1
		mov	dx, ax
		shl	ax, 1
		shl	ax, 1
		add	ax, dx
		add	[bp+var_A], ax
		jmp	loc_123D8
; ---------------------------------------------------------------------------

loc_124C2:				; CODE XREF: sub_12325+D1j
					; DATA XREF: seg000:off_127CDo
		or	[bp+var_2], 10h	; jumptable 000123F6 case 6
		jmp	loc_1242E
; ---------------------------------------------------------------------------

loc_124C9:				; CODE XREF: sub_12325+D1j
					; DATA XREF: seg000:off_127CDo
		or	[bp+var_2], 100h ; jumptable 000123F6 case 7

loc_124CE:				; CODE XREF: sub_12325+D1j
					; DATA XREF: seg000:off_127CDo
		and	[bp+var_2], 0FFEFh ; jumptable 000123F6	case 8
		jmp	loc_1242E
; ---------------------------------------------------------------------------

loc_124D5:				; CODE XREF: sub_12325+D1j
					; DATA XREF: seg000:off_127CDo
		mov	bh, 8		; jumptable 000123F6 case 11
		jmp	short loc_124E3
; ---------------------------------------------------------------------------

loc_124D9:				; CODE XREF: sub_12325+D1j
					; DATA XREF: seg000:off_127CDo
		mov	bh, 0Ah		; jumptable 000123F6 case 12
		jmp	short loc_124E7
; ---------------------------------------------------------------------------

loc_124DD:				; CODE XREF: sub_12325+D1j
					; DATA XREF: seg000:off_127CDo
		mov	bh, 10h		; jumptable 000123F6 case 13
		mov	bl, 0E9h ; 'é'
		add	bl, dl

loc_124E3:				; CODE XREF: sub_12325+1B2j
		mov	[bp+var_B], 0

loc_124E7:				; CODE XREF: sub_12325+1B6j
		mov	[bp+var_5], dl
		xor	dx, dx
		mov	[bp+var_6], dl
		mov	di, [bp+arg_0]
		mov	ax, ss:[di]
		jmp	short loc_12507
; ---------------------------------------------------------------------------

loc_124F7:				; CODE XREF: sub_12325+D1j
					; DATA XREF: seg000:off_127CDo
		mov	bh, 0Ah		; jumptable 000123F6 case 10
		mov	[bp+var_6], 1
		mov	[bp+var_5], dl
		mov	di, [bp+arg_0]
		mov	ax, ss:[di]
		cwd

loc_12507:				; CODE XREF: sub_12325+1D0j
		inc	di
		inc	di
		mov	word ptr [bp+arg_2], si
		test	[bp+var_2], 10h
		jz	short loc_12518
		mov	dx, ss:[di]
		inc	di
		inc	di

loc_12518:				; CODE XREF: sub_12325+1ECj
		mov	[bp+arg_0], di
		lea	di, [bp+var_45]

loc_1251E:
		or	ax, ax
		jnz	short loc_12551
		or	dx, dx
		jnz	short loc_12551
		cmp	[bp+var_A], 0
		jnz	short loc_12555
		mov	di, [bp+var_4]
		mov	cx, [bp+var_8]
		jcxz	short loc_1254E
		cmp	cx, 0FFFFh
		jz	short loc_1254E
		mov	ax, [bp+var_2]
		and	ax, 8
		jz	short loc_12545
		mov	dl, 30h	; '0'
		jmp	short loc_12547
; ---------------------------------------------------------------------------

loc_12545:				; CODE XREF: sub_12325+21Aj
		mov	dl, 20h	; ' '

loc_12547:				; CODE XREF: sub_12325+21Ej
					; sub_12325+227j
		mov	al, dl
		call	sub_1234C
		loop	loc_12547

loc_1254E:				; CODE XREF: sub_12325+20Dj
					; sub_12325+212j
		jmp	loc_12395
; ---------------------------------------------------------------------------

loc_12551:				; CODE XREF: sub_12325+1FBj
					; sub_12325+1FFj
		or	[bp+var_2], 4

loc_12555:				; CODE XREF: sub_12325+205j
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
		call	sub_11B2F
		push	ss
		pop	es
		mov	dx, [bp+var_A]
		or	dx, dx
		jg	short loc_12571
		jmp	loc_12665
; ---------------------------------------------------------------------------

loc_12571:				; CODE XREF: sub_12325+247j
		jmp	loc_12673
; ---------------------------------------------------------------------------

loc_12574:				; CODE XREF: sub_12325+D1j
					; DATA XREF: seg000:off_127CDo
		mov	[bp+var_5], dl	; jumptable 000123F6 case 14
		mov	word ptr [bp+arg_2], si
		lea	di, [bp+var_46]
		mov	bx, [bp+arg_0]
		push	word ptr ss:[bx]
		inc	bx
		inc	bx
		mov	[bp+arg_0], bx
		test	[bp+var_2], 20h
		jz	short loc_1259F
		mov	dx, ss:[bx]
		inc	bx
		inc	bx
		mov	[bp+arg_0], bx
		push	ss
		pop	es
		call	sub_1230D
		mov	al, 3Ah	; ':'
		stosb

loc_1259F:				; CODE XREF: sub_12325+268j
		push	ss
		pop	es
		pop	dx
		call	sub_1230D
		mov	byte ptr ss:[di], 0
		mov	[bp+var_6], 0
		and	[bp+var_2], 0FFFBh
		lea	cx, [bp+var_46]
		sub	di, cx
		xchg	cx, di
		mov	dx, [bp+var_A]
		cmp	dx, cx
		jg	short loc_125C1
		mov	dx, cx

loc_125C1:				; CODE XREF: sub_12325+298j
		jmp	loc_12665
; ---------------------------------------------------------------------------

loc_125C4:				; CODE XREF: sub_12325+D1j
					; DATA XREF: seg000:off_127CDo
		mov	word ptr [bp+arg_2], si	; jumptable 000123F6 case 16
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
		jmp	loc_126A0
; ---------------------------------------------------------------------------

loc_125E4:				; CODE XREF: sub_12325+D1j
					; DATA XREF: seg000:off_127CDo
		mov	word ptr [bp+arg_2], si	; jumptable 000123F6 case 17
		mov	[bp+var_5], dl
		mov	di, [bp+arg_0]
		test	[bp+var_2], 20h
		jnz	short loc_12601
		mov	di, ss:[di]
		add	[bp+arg_0], 2
		push	ds
		pop	es
		assume es:dseg
		or	di, di
		jmp	short loc_1260C
; ---------------------------------------------------------------------------

loc_12601:				; CODE XREF: sub_12325+2CDj
		les	di, ss:[di]
		assume es:nothing
		add	[bp+arg_0], 4
		mov	ax, es
		or	ax, di

loc_1260C:				; CODE XREF: sub_12325+2DAj
		jnz	short loc_12613
		push	ds
		pop	es
		assume es:dseg
		mov	di, offset aNull ; "(null)"

loc_12613:				; CODE XREF: sub_12325:loc_1260Cj
		call	sub_1233F
		cmp	cx, [bp+var_A]
		jbe	short loc_1261E
		mov	cx, [bp+var_A]

loc_1261E:				; CODE XREF: sub_12325+2F4j
		jmp	loc_126A0
; ---------------------------------------------------------------------------

loc_12621:				; CODE XREF: sub_12325+D1j
					; DATA XREF: seg000:off_127CDo
		mov	word ptr [bp+arg_2], si	; jumptable 000123F6 case 15
		mov	[bp+var_5], dl
		mov	di, [bp+arg_0]
		mov	cx, [bp+var_A]
		or	cx, cx
		jge	short loc_12634
		mov	cx, 6

loc_12634:				; CODE XREF: sub_12325+30Aj
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
		jz	short loc_12655
		mov	ax, 8
		add	[bp+arg_0], 0Ah
		jmp	short loc_1265C
; ---------------------------------------------------------------------------

loc_12655:				; CODE XREF: sub_12325+325j
		add	[bp+arg_0], 8
		mov	ax, 6

loc_1265C:				; CODE XREF: sub_12325+32Ej
		push	ax
		call	sub_12DE9
		push	ss
		pop	es
		assume es:nothing
		lea	di, [bp+var_45]

loc_12665:				; CODE XREF: sub_12325+249j
					; sub_12325:loc_125C1j
		test	[bp+var_2], 8
		jz	short loc_12684
		mov	dx, [bp+var_8]
		or	dx, dx
		jle	short loc_12684

loc_12673:				; CODE XREF: sub_12325:loc_12571j
		call	sub_1233F
		cmp	byte ptr es:[di], '-'
		jnz	short loc_1267D
		dec	cx

loc_1267D:				; CODE XREF: sub_12325+355j
		sub	dx, cx
		jle	short loc_12684
		mov	[bp+var_E], dx

loc_12684:				; CODE XREF: sub_12325+345j
					; sub_12325+34Cj ...
		mov	al, [bp+var_B]
		or	al, al
		jz	short loc_1269D
		cmp	byte ptr es:[di], '-'
		jz	short loc_1269D
		sub	[bp+var_E], 1
		adc	[bp+var_E], 0
		dec	di
		mov	es:[di], al

loc_1269D:				; CODE XREF: sub_12325+364j
					; sub_12325+36Aj
		call	sub_1233F

loc_126A0:				; CODE XREF: sub_12325+2BCj
					; sub_12325:loc_1261Ej
		mov	si, di
		mov	di, [bp+var_4]
		mov	bx, [bp+var_8]
		mov	ax, 5
		and	ax, [bp+var_2]
		cmp	ax, 5
		jnz	short loc_126C6
		mov	ah, [bp+var_5]
		cmp	ah, 6Fh	; 'o'
		jnz	short loc_126C8
		cmp	[bp+var_E], 0
		jg	short loc_126C6
		mov	[bp+var_E], 1

loc_126C6:				; CODE XREF: sub_12325+38Cj
					; sub_12325+39Aj
		jmp	short loc_126E3
; ---------------------------------------------------------------------------

loc_126C8:				; CODE XREF: sub_12325+394j
		cmp	ah, 78h	; 'x'
		jz	short loc_126D2
		cmp	ah, 58h	; 'X'
		jnz	short loc_126E3

loc_126D2:				; CODE XREF: sub_12325+3A6j
		or	[bp+var_2], 40h
		dec	bx
		dec	bx
		sub	[bp+var_E], 2
		jge	short loc_126E3
		mov	[bp+var_E], 0

loc_126E3:				; CODE XREF: sub_12325:loc_126C6j
					; sub_12325+3ABj ...
		add	cx, [bp+var_E]
		test	[bp+var_2], 2
		jnz	short loc_126F9
		jmp	short loc_126F5
; ---------------------------------------------------------------------------

loc_126EF:				; CODE XREF: sub_12325+3D2j
		mov	al, 20h	; ' '
		call	sub_1234C
		dec	bx

loc_126F5:				; CODE XREF: sub_12325+3C8j
		cmp	bx, cx
		jg	short loc_126EF

loc_126F9:				; CODE XREF: sub_12325+3C6j
		test	[bp+var_2], 40h
		jz	short loc_1270B
		mov	al, 30h	; '0'
		call	sub_1234C
		mov	al, [bp+var_5]
		call	sub_1234C

loc_1270B:				; CODE XREF: sub_12325+3D9j
		mov	dx, [bp+var_E]
		or	dx, dx
		jle	short loc_12739
		sub	cx, dx
		sub	bx, dx
		mov	al, es:[si]
		cmp	al, 2Dh	; '-'
		jz	short loc_12725
		cmp	al, 20h	; ' '
		jz	short loc_12725
		cmp	al, 2Bh	; '+'
		jnz	short loc_1272C

loc_12725:				; CODE XREF: sub_12325+3F6j
					; sub_12325+3FAj
		lods	byte ptr es:[si]
		call	sub_1234C
		dec	cx
		dec	bx

loc_1272C:				; CODE XREF: sub_12325+3FEj
		xchg	cx, dx
		jcxz	short loc_12737

loc_12730:				; CODE XREF: sub_12325+410j
		mov	al, 30h	; '0'
		call	sub_1234C
		loop	loc_12730

loc_12737:				; CODE XREF: sub_12325+409j
		xchg	cx, dx

loc_12739:				; CODE XREF: sub_12325+3EBj
		jcxz	short loc_1274D
		sub	bx, cx

loc_1273D:				; CODE XREF: sub_12325:loc_1274Bj
		lods	byte ptr es:[si]
		mov	ss:[di], al
		inc	di
		dec	byte ptr [bp+var_14]
		jg	short loc_1274B
		call	sub_12355

loc_1274B:				; CODE XREF: sub_12325+421j
		loop	loc_1273D

loc_1274D:				; CODE XREF: sub_12325:loc_12739j
		or	bx, bx
		jle	short loc_1275A
		mov	cx, bx

loc_12753:				; CODE XREF: sub_12325+433j
		mov	al, 20h	; ' '
		call	sub_1234C
		loop	loc_12753

loc_1275A:				; CODE XREF: sub_12325+42Aj
		jmp	loc_12395
; ---------------------------------------------------------------------------

loc_1275D:				; CODE XREF: sub_12325+D1j
					; DATA XREF: seg000:off_127CDo
		mov	word ptr [bp+arg_2], si	; jumptable 000123F6 case 18
		mov	di, [bp+arg_0]
		test	[bp+var_2], 20h
		jnz	short loc_12775
		mov	di, ss:[di]
		add	[bp+arg_0], 2
		push	ds
		pop	es
		assume es:dseg
		jmp	short loc_1277C
; ---------------------------------------------------------------------------

loc_12775:				; CODE XREF: sub_12325+443j
		les	di, ss:[di]
		assume es:nothing
		add	[bp+arg_0], 4

loc_1277C:				; CODE XREF: sub_12325+44Ej
		mov	ax, 50h	; 'P'
		sub	al, byte ptr [bp+var_14]
		add	ax, [bp+var_12]
		mov	es:[di], ax
		test	[bp+var_2], 10h
		jz	short loc_12796
		inc	di
		inc	di
		mov	word ptr es:[di], 0

loc_12796:				; CODE XREF: sub_12325+468j
		jmp	loc_12392
; ---------------------------------------------------------------------------

loc_12799:				; CODE XREF: sub_12325+CCj
					; sub_12325+D1j ...
		mov	si, [bp+var_10]	; jumptable 000123F6 default case
		mov	es, word ptr [bp+arg_2+2]
		mov	di, [bp+var_4]
		mov	al, 25h	; '%'

loc_127A4:				; CODE XREF: sub_12325+486j
		call	sub_1234C
		lods	byte ptr es:[si]
		or	al, al
		jnz	short loc_127A4

loc_127AD:				; CODE XREF: sub_12325:loc_123B0j
		cmp	byte ptr [bp+var_14], 50h ; 'P'
		jge	short loc_127B6
		call	sub_12355

loc_127B6:				; CODE XREF: sub_12325+48Cj
		pop	es
		cmp	[bp+var_16], 0
		jz	short loc_127C2
		mov	ax, 0FFFFh
		jmp	short loc_127C5
; ---------------------------------------------------------------------------

loc_127C2:				; CODE XREF: sub_12325+496j
		mov	ax, [bp+var_12]

loc_127C5:				; CODE XREF: sub_12325+49Bj
		pop	di
		pop	si
		mov	sp, bp
		pop	bp
		retn	0Ch
; END OF FUNCTION CHUNK	FOR sub_12325
; ---------------------------------------------------------------------------
off_127CD	dw offset loc_12414	; DATA XREF: sub_12325+D1r
		dw offset loc_123FE	; jump table for switch	statement
		dw offset loc_12449
		dw offset loc_12409
		dw offset loc_12477
		dw offset loc_12484
		dw offset loc_124C2
		dw offset loc_124C9
		dw offset loc_124CE
		dw offset loc_12432
		dw offset loc_124F7
		dw offset loc_124D5
		dw offset loc_124D9
		dw offset loc_124DD
		dw offset loc_12574
		dw offset loc_12621
		dw offset loc_125C4
		dw offset loc_125E4
		dw offset loc_1275D
		dw offset loc_12799
		dw offset loc_12799
		dw offset loc_12799
		dw offset loc_12424
		dw offset loc_1242A

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_127FD	proc far		; CODE XREF: sub_10BFB+11AP
					; sub_10BFB+139P ...

arg_0		= word ptr  6
arg_2		= dword	ptr  8
arg_6		= word ptr  0Ch

		push	bp
		mov	bp, sp
		mov	bx, [bp+arg_0]
		shl	bx, 1
		test	word_1918C[bx],	800h
		jz	short loc_12822
		mov	ax, 2
		push	ax
		xor	ax, ax
		xor	dx, dx
		push	ax
		push	dx
		push	[bp+arg_0]
		call	sub_11B06
		add	sp, 8

loc_12822:				; CODE XREF: sub_127FD+Ej
		push	ds
		mov	ah, 40h	; '@'
		mov	bx, [bp+arg_0]
		mov	cx, [bp+arg_6]
		lds	dx, [bp+arg_2]
		int	21h		; DOS -	2+ - WRITE TO FILE WITH	HANDLE
					; BX = file handle, CX = number	of bytes to write, DS:DX -> buffer
		pop	ds
		jb	short loc_12842
		push	ax
		mov	bx, [bp+arg_0]
		shl	bx, 1
		or	word_1918C[bx],	1000h
		pop	ax
		jmp	short loc_12846
; ---------------------------------------------------------------------------

loc_12842:				; CODE XREF: sub_127FD+34j
		push	ax
		call	sub_11AB8

loc_12846:				; CODE XREF: sub_127FD+43j
		pop	bp
		retf
sub_127FD	endp

; ---------------------------------------------------------------------------
		align 10h
word_12850	dw 0			; DATA XREF: sub_1285Cr sub_1285C+1Dr	...
word_12852	dw 0			; DATA XREF: sub_1285C+14w
					; sub_1285C+27w ...
word_12854	dw 0			; DATA XREF: sub_1285C+4Cw
					; sub_1292F+19w ...
word_12856	dw 0			; DATA XREF: sub_1285C+32r
					; sub_1285C:loc_128AFr	...
word_12858	dw 0			; DATA XREF: sub_12AFB+1r seg000:2BF1w
word_1285A	dw 0			; DATA XREF: sub_12AFB+7r seg000:2BF6w

; =============== S U B	R O U T	I N E =======================================


sub_1285C	proc near		; CODE XREF: sub_1298E+18p
		cmp	dx, cs:word_12850
		jz	short loc_1289A
		mov	ds, dx
		mov	ds, word_16492
		cmp	word_16492, 0
		jz	short loc_12877
		mov	cs:word_12852, ds
		jmp	short loc_128AF
; ---------------------------------------------------------------------------

loc_12877:				; CODE XREF: sub_1285C+12j
		mov	ax, ds
		cmp	ax, cs:word_12850
		jz	short loc_12895
		mov	ax, word_16498
		mov	cs:word_12852, ax
		push	ds
		xor	ax, ax
		push	ax
		call	sub_1292F
		mov	ds, cs:word_12856
		jmp	short loc_128B8
; ---------------------------------------------------------------------------

loc_12895:				; CODE XREF: sub_1285C+22j
		mov	dx, cs:word_12850

loc_1289A:				; CODE XREF: sub_1285C+5j
		mov	cs:word_12850, 0
		mov	cs:word_12852, 0
		mov	cs:word_12854, 0

loc_128AF:				; CODE XREF: sub_1285C+19j
		mov	ds, cs:word_12856
		push	dx
		xor	ax, ax
		push	ax

loc_128B8:				; CODE XREF: sub_1285C+37j
		call	sub_10339
		pop	ax
		pop	ax
		retn
sub_1285C	endp


; =============== S U B	R O U T	I N E =======================================


sub_128BE	proc near		; CODE XREF: sub_1298E:loc_129ABp
		mov	ds, dx
		push	ds
		mov	es, word_16492
		mov	word_16492, 0
		mov	word_16498, es
		cmp	dx, cs:word_12850
		jz	short loc_12904
		cmp	word ptr es:2, 0
		jnz	short loc_12904
		mov	ax, word_16490
		pop	bx
		push	es
		add	es:0, ax
		mov	cx, es
		add	dx, ax
		mov	es, dx
		cmp	word ptr es:2, 0
		jnz	short loc_128FD
		mov	es:8, cx
		jmp	short loc_12907
; ---------------------------------------------------------------------------

loc_128FD:				; CODE XREF: sub_128BE+36j
		mov	es:2, cx
		jmp	short loc_12907
; ---------------------------------------------------------------------------

loc_12904:				; CODE XREF: sub_128BE+16j
					; sub_128BE+1Ej
		call	sub_12958

loc_12907:				; CODE XREF: sub_128BE+3Dj
					; sub_128BE+44j
		pop	es
		mov	ax, es
		add	ax, es:0
		mov	ds, ax
		cmp	word_16492, 0
		jz	short loc_12919
		retn
; ---------------------------------------------------------------------------

loc_12919:				; CODE XREF: sub_128BE+58j
		mov	ax, word_16490
		add	es:0, ax
		mov	ax, es
		mov	bx, ds
		add	bx, word_16490
		mov	es, bx
		mov	es:2, ax
sub_128BE	endp ; sp-analysis failed


; =============== S U B	R O U T	I N E =======================================


sub_1292F	proc near		; CODE XREF: sub_1285C+2Fp
					; sub_12A7E+66p
		mov	bx, ds
		cmp	bx, word_16496
		jz	short loc_12950
		mov	es, word_16496
		mov	ds, word_16494
		mov	word_16496, es
		mov	word ptr es:4, ds
		mov	cs:word_12854, ds
		mov	ds, bx
		retn
; ---------------------------------------------------------------------------

loc_12950:				; CODE XREF: sub_1292F+6j
		mov	cs:word_12854, 0
		retn
sub_1292F	endp


; =============== S U B	R O U T	I N E =======================================


sub_12958	proc near		; CODE XREF: sub_128BE:loc_12904p
		mov	ax, cs:word_12854
		or	ax, ax
		jz	short loc_12980
		mov	bx, ss
		cli
		mov	ss, ax
		mov	es, word ptr ss:6
		mov	word ptr ss:6, ds
		mov	word_16494, ss
		mov	ss, bx
		sti
		mov	word ptr es:4, ds
		mov	word_16496, es
		retn
; ---------------------------------------------------------------------------

loc_12980:				; CODE XREF: sub_12958+6j
		mov	cs:word_12854, ds
		mov	word_16494, ds
		mov	word_16496, ds
		retn
sub_12958	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1298E	proc far		; CODE XREF: sub_103E5+4CP
					; sub_10FCC+86P ...

arg_2		= word ptr  8

		push	bp
		mov	bp, sp
		push	si
		push	di
		mov	cs:word_12856, ds
		mov	dx, [bp+arg_2]
		or	dx, dx
		jz	short loc_129AE
		cmp	dx, cs:word_12852
		jnz	short loc_129AB
		call	sub_1285C
		jmp	short loc_129AE
; ---------------------------------------------------------------------------

loc_129AB:				; CODE XREF: sub_1298E+16j
		call	sub_128BE

loc_129AE:				; CODE XREF: sub_1298E+Fj
					; sub_1298E+1Bj
		mov	ds, cs:word_12856
		pop	di
		pop	si
		pop	bp
		retf
sub_1298E	endp


; =============== S U B	R O U T	I N E =======================================


sub_129B7	proc near		; CODE XREF: sub_12A7E:loc_12AD3p
		push	ax
		mov	ds, cs:word_12856
		xor	ax, ax
		push	ax
		push	ax
		call	sub_10378
		pop	bx
		pop	bx
		and	ax, 0Fh
		jz	short loc_129DE
		mov	dx, 10h
		sub	dx, ax
		xor	ax, ax
		mov	ds, cs:word_12856
		push	ax
		push	dx
		call	sub_10378
		pop	bx
		pop	bx

loc_129DE:				; CODE XREF: sub_129B7+12j
		pop	ax
		push	ax
		xor	bx, bx
		mov	bl, ah
		mov	cl, 4
		shr	bx, cl
		shl	ax, cl
		mov	ds, cs:word_12856
		push	bx
		push	ax
		call	sub_10378
		pop	bx
		pop	bx
		pop	bx
		cmp	ax, 0FFFFh
		jz	short loc_12A14
		mov	cs:word_12850, dx
		mov	cs:word_12852, dx
		mov	ds, dx
		mov	word_16490, bx
		mov	word_16492, dx
		mov	ax, 4
		retn
; ---------------------------------------------------------------------------

loc_12A14:				; CODE XREF: sub_129B7+43j
		xor	ax, ax
		cwd
		retn
sub_129B7	endp


; =============== S U B	R O U T	I N E =======================================


sub_12A18	proc near		; CODE XREF: sub_12A7E:loc_12ACEp
		push	ax
		xor	bx, bx
		mov	bl, ah
		mov	cl, 4
		shr	bx, cl
		shl	ax, cl
		mov	ds, cs:word_12856
		push	bx
		push	ax
		call	sub_10378
		pop	bx
		pop	bx
		pop	bx
		cmp	ax, 0FFFFh
		jz	short loc_12A4D
		mov	cx, cs:word_12852
		mov	cs:word_12852, dx
		mov	ds, dx
		mov	word_16490, bx
		mov	word_16492, cx
		mov	ax, 4
		retn
; ---------------------------------------------------------------------------

loc_12A4D:				; CODE XREF: sub_12A18+1Bj
		xor	ax, ax
		cwd
		retn
sub_12A18	endp


; =============== S U B	R O U T	I N E =======================================


sub_12A51	proc near		; CODE XREF: sub_12A7E:loc_12AD8p
		mov	bx, dx
		sub	word_16490, ax
		add	dx, word_16490
		mov	ds, dx
		mov	word_16490, ax
		mov	word_16492, bx
		mov	bx, dx
		add	bx, word_16490
		mov	ds, bx
		mov	word_16492, dx
		mov	ax, 4
		retn
sub_12A51	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_12A74	proc far		; CODE XREF: sub_10FCC+D3P
					; seg000:2DFAP

arg_2		= word ptr  6

		push	bp
		mov	bp, sp
		xor	dx, dx
		mov	ax, [bp+arg_2]
		jmp	short loc_12A87
sub_12A74	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_12A7E	proc far		; CODE XREF: sub_12AFB+Ep seg000:2C33p ...

arg_0		= word ptr  6
arg_2		= word ptr  8

		push	bp
		mov	bp, sp
		mov	dx, [bp+arg_2]
		mov	ax, [bp+arg_0]

loc_12A87:				; CODE XREF: sub_12A74+8j
		push	si
		push	di
		mov	cs:word_12856, ds
		mov	cx, ax
		or	cx, dx
		jz	short loc_12AF2
		add	ax, 13h
		adc	dx, 0
		jb	short loc_12ADD
		test	dx, 0FFF0h
		jnz	short loc_12ADD
		mov	cl, 4
		shr	ax, cl
		shl	dx, cl
		or	ah, dl
		mov	dx, cs:word_12850
		or	dx, dx
		jz	short loc_12AD3
		mov	dx, cs:word_12854
		or	dx, dx
		jz	short loc_12ACE
		mov	bx, dx

loc_12ABE:				; CODE XREF: sub_12A7E+4Ej
		mov	ds, dx
		cmp	word_16490, ax
		jnb	short loc_12AE2
		mov	dx, word_16496
		cmp	dx, bx
		jnz	short loc_12ABE

loc_12ACE:				; CODE XREF: sub_12A7E+3Cj
		call	sub_12A18
		jmp	short loc_12AF2
; ---------------------------------------------------------------------------

loc_12AD3:				; CODE XREF: sub_12A7E+33j
		call	sub_129B7
		jmp	short loc_12AF2
; ---------------------------------------------------------------------------

loc_12AD8:				; CODE XREF: sub_12A7E:loc_12AE2j
		call	sub_12A51
		jmp	short loc_12AF2
; ---------------------------------------------------------------------------

loc_12ADD:				; CODE XREF: sub_12A7E+1Cj
					; sub_12A7E+22j
		xor	ax, ax
		cwd
		jmp	short loc_12AF2
; ---------------------------------------------------------------------------

loc_12AE2:				; CODE XREF: sub_12A7E+46j
		ja	short loc_12AD8
		call	sub_1292F
		mov	bx, word_16498
		mov	word_16492, bx
		mov	ax, offset word_16494

loc_12AF2:				; CODE XREF: sub_12A7E+14j
					; sub_12A7E+53j ...
		mov	ds, cs:word_12856
		pop	di
		pop	si
		pop	bp
		retf
sub_12A7E	endp


; =============== S U B	R O U T	I N E =======================================


sub_12AFB	proc near		; CODE XREF: seg000:loc_12C2Bp
		push	bx
		mov	si, cs:word_12858
		push	si
		mov	si, cs:word_1285A
		push	si
		push	cs
		call	near ptr sub_12A7E
		pop	bx
		pop	bx
		or	dx, dx
		jnz	short loc_12B14
		pop	bx
		retn
; ---------------------------------------------------------------------------

loc_12B14:				; CODE XREF: sub_12AFB+15j
		pop	ds
		mov	es, dx
		push	es
		push	ds
		push	bx
		mov	dx, word_16490
		cld
		dec	dx
		mov	di, 4
		mov	si, di
		mov	cx, 6
		rep movsw
		or	dx, dx
		jz	short loc_12B65
		mov	ax, es
		inc	ax
		mov	es, ax
		assume es:nothing
		mov	ax, ds
		inc	ax
		mov	ds, ax
		assume ds:nothing

loc_12B38:				; CODE XREF: sub_12AFB+68j
		xor	di, di
		mov	si, di
		mov	cx, dx
		cmp	cx, 1000h
		jbe	short loc_12B47
		mov	cx, 1000h

loc_12B47:				; CODE XREF: sub_12AFB+47j
		shl	cx, 1
		shl	cx, 1
		shl	cx, 1
		rep movsw
		sub	dx, 1000h
		jbe	short loc_12B65
		mov	ax, es
		add	ax, 1000h
		mov	es, ax
		assume es:seg000
		mov	ax, ds
		add	ax, 1000h
		mov	ds, ax
		assume ds:nothing
		jmp	short loc_12B38
; ---------------------------------------------------------------------------

loc_12B65:				; CODE XREF: sub_12AFB+31j
					; sub_12AFB+58j
		mov	ds, cs:word_12856
		assume ds:dseg
		push	cs
		call	near ptr sub_1298E
		pop	dx
		pop	dx
		pop	dx
		mov	ax, 4
		retn
sub_12AFB	endp


; =============== S U B	R O U T	I N E =======================================


sub_12B75	proc near		; CODE XREF: seg000:loc_12C26p
		cmp	bx, cs:word_12852
		jz	short loc_12BC0
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
		jz	short loc_12BAD
		mov	es:2, di
		jmp	short loc_12BB2
; ---------------------------------------------------------------------------

loc_12BAD:				; CODE XREF: sub_12B75+2Fj
		mov	es:8, di

loc_12BB2:				; CODE XREF: sub_12B75+36j
		mov	si, bx
		push	cs
		call	near ptr sub_1298E
		pop	dx
		pop	dx
		mov	dx, si
		mov	ax, 4
		retn
; ---------------------------------------------------------------------------

loc_12BC0:				; CODE XREF: sub_12B75+5j
		push	bx
		mov	es, bx
		mov	es:0, ax
		add	bx, ax
		push	bx
		xor	ax, ax
		push	ax
		call	sub_10339
		pop	dx
		pop	dx
		pop	dx
		mov	ax, 4
		retn
sub_12B75	endp

; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		xor	dx, dx
		jmp	short loc_12BE4
; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		mov	dx, [bp+0Ch]

loc_12BE4:				; CODE XREF: seg000:2BDCj
		mov	ax, [bp+0Ah]
		mov	bx, [bp+8]
		push	si
		push	di
		mov	cs:word_12856, ds
		mov	cs:word_12858, dx
		mov	cs:word_1285A, ax
		or	bx, bx
		jz	short loc_12C30
		mov	cx, ax
		or	cx, dx
		jz	short loc_12C38
		add	ax, 13h
		adc	dx, 0
		mov	cl, 4
		shr	ax, cl
		shl	dx, cl
		or	ah, dl
		mov	es, bx
		mov	cx, es:0
		cmp	cx, ax
		jb	short loc_12C2B
		ja	short loc_12C26
		mov	dx, bx
		mov	ax, 4
		jmp	short loc_12C43
; ---------------------------------------------------------------------------

loc_12C26:				; CODE XREF: seg000:2C1Dj
		call	sub_12B75
		jmp	short loc_12C43
; ---------------------------------------------------------------------------

loc_12C2B:				; CODE XREF: seg000:2C1Bj
		call	sub_12AFB
		jmp	short loc_12C43
; ---------------------------------------------------------------------------

loc_12C30:				; CODE XREF: seg000:2BFCj
		push	dx
		push	ax
		push	cs
		call	near ptr sub_12A7E
		jmp	short loc_12C41
; ---------------------------------------------------------------------------

loc_12C38:				; CODE XREF: seg000:2C02j
		push	bx
		push	ax
		push	cs
		call	near ptr sub_1298E
		xor	ax, ax
		cwd

loc_12C41:				; CODE XREF: seg000:2C36j
		pop	di
		pop	di

loc_12C43:				; CODE XREF: seg000:2C24j seg000:2C29j ...
		mov	ds, cs:word_12856
		pop	di
		pop	si
		pop	bp
		retf

; =============== S U B	R O U T	I N E =======================================


sub_12C4C	proc far		; CODE XREF: sub_1566E+9DCP
		push	si
		xchg	ax, si
		xchg	ax, dx
		test	ax, ax
		jz	short loc_12C55
		mul	bx

loc_12C55:				; CODE XREF: sub_12C4C+5j
		jcxz	short loc_12C5C
		xchg	ax, cx
		mul	si
		add	ax, cx

loc_12C5C:				; CODE XREF: sub_12C4C:loc_12C55j
		xchg	ax, si
		mul	bx
		add	dx, si
		pop	si
		retf
sub_12C4C	endp


; =============== S U B	R O U T	I N E =======================================


sub_12C63	proc near		; CODE XREF: sub_112DE+48p
					; sub_112DE+74p ...
		pop	cx
		push	cs
		push	cx
sub_12C63	endp ; sp-analysis failed


; =============== S U B	R O U T	I N E =======================================


sub_12C66	proc far		; CODE XREF: sub_1566E+AEP
		xor	cx, cx
		jmp	short loc_12C80
sub_12C66	endp

; ---------------------------------------------------------------------------
		pop	cx
		push	cs
		push	cx

; =============== S U B	R O U T	I N E =======================================


sub_12C6D	proc far		; CODE XREF: sub_1548E+A6P
		mov	cx, 1
		jmp	short loc_12C80
sub_12C6D	endp


; =============== S U B	R O U T	I N E =======================================


sub_12C72	proc far		; CODE XREF: sub_112DE+31p
					; sub_112DE+5Ep ...
		pop	cx
		push	cs
		push	cx
		mov	cx, 2
		jmp	short loc_12C80
sub_12C72	endp

; ---------------------------------------------------------------------------
		pop	cx
		push	cs
		push	cx

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_12C7D	proc far		; CODE XREF: sub_1548E+33P
					; sub_1548E+5EP ...

arg_0		= word ptr  0Ah
arg_2		= word ptr  0Ch
arg_4		= word ptr  0Eh
arg_6		= word ptr  10h

		mov	cx, 3

loc_12C80:				; CODE XREF: sub_12C66+2j sub_12C6D+3j ...
		push	bp
		push	si
		push	di
		mov	bp, sp
		mov	di, cx
		mov	ax, [bp+arg_0]
		mov	dx, [bp+arg_2]
		mov	bx, [bp+arg_4]
		mov	cx, [bp+arg_6]
		or	cx, cx
		jnz	short loc_12C9F
		or	dx, dx
		jz	short loc_12D04
		or	bx, bx
		jz	short loc_12D04

loc_12C9F:				; CODE XREF: sub_12C7D+18j
		test	di, 1
		jnz	short loc_12CC1
		or	dx, dx
		jns	short loc_12CB3
		neg	dx
		neg	ax
		sbb	dx, 0
		or	di, 0Ch

loc_12CB3:				; CODE XREF: sub_12C7D+2Aj
		or	cx, cx
		jns	short loc_12CC1
		neg	cx
		neg	bx
		sbb	cx, 0
		xor	di, 4

loc_12CC1:				; CODE XREF: sub_12C7D+26j
					; sub_12C7D+38j
		mov	bp, cx
		mov	cx, 20h	; ' '
		push	di
		xor	di, di
		xor	si, si

loc_12CCB:				; CODE XREF: sub_12C7D:loc_12CE2j
		shl	ax, 1
		rcl	dx, 1
		rcl	si, 1
		rcl	di, 1
		cmp	di, bp
		jb	short loc_12CE2
		ja	short loc_12CDD
		cmp	si, bx
		jb	short loc_12CE2

loc_12CDD:				; CODE XREF: sub_12C7D+5Aj
		sub	si, bx
		sbb	di, bp
		inc	ax

loc_12CE2:				; CODE XREF: sub_12C7D+58j
					; sub_12C7D+5Ej
		loop	loc_12CCB
		pop	bx
		test	bx, 2
		jz	short loc_12CF1
		mov	ax, si
		mov	dx, di
		shr	bx, 1

loc_12CF1:				; CODE XREF: sub_12C7D+6Cj
		test	bx, 4
		jz	short loc_12CFE
		neg	dx
		neg	ax
		sbb	dx, 0

loc_12CFE:				; CODE XREF: sub_12C7D+78j
					; sub_12C7D+92j
		pop	di
		pop	si
		pop	bp
		retf	8
; ---------------------------------------------------------------------------

loc_12D04:				; CODE XREF: sub_12C7D+1Cj
					; sub_12C7D+20j
		div	bx
		test	di, 2
		jz	short loc_12D0D
		xchg	ax, dx

loc_12D0D:				; CODE XREF: sub_12C7D+8Dj
		xor	dx, dx
		jmp	short loc_12CFE
sub_12C7D	endp

; ---------------------------------------------------------------------------
		pop	bx
		push	cs
		push	bx

; =============== S U B	R O U T	I N E =======================================


sub_12D14	proc far		; CODE XREF: sub_1566E+A7P
		cmp	cl, 10h
		jnb	short loc_12D29
		mov	bx, ax
		shl	ax, cl
		shl	dx, cl
		neg	cl
		add	cl, 10h
		shr	bx, cl
		or	dx, bx
		retf
; ---------------------------------------------------------------------------

loc_12D29:				; CODE XREF: sub_12D14+3j
		sub	cl, 10h
		xchg	ax, dx
		xor	ax, ax
		shl	dx, cl
		retf
sub_12D14	endp


; =============== S U B	R O U T	I N E =======================================


sub_12D32	proc far		; CODE XREF: sub_10378+13p
					; sub_10924+61p ...
		pop	es
		push	cs
		push	es
		or	cx, cx
		jge	short loc_12D45
		not	bx
		not	cx
		add	bx, 1
		adc	cx, 0
		jmp	short loc_12D74
; ---------------------------------------------------------------------------

loc_12D45:				; CODE XREF: sub_12D32+5j
					; sub_12D32+40j
		add	ax, bx
		jnb	short loc_12D4D
		add	dx, 1000h

loc_12D4D:				; CODE XREF: sub_12D32+15j
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
		jge	short loc_12D74
		not	bx
		not	cx
		add	bx, 1
		adc	cx, 0
		jmp	short loc_12D45
; ---------------------------------------------------------------------------

loc_12D74:				; CODE XREF: sub_12D32+11j
					; sub_12D32+34j
		sub	ax, bx
		jnb	short loc_12D7C
		sub	dx, 1000h

loc_12D7C:				; CODE XREF: sub_12D32+44j
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
sub_12D32	endp ; sp-analysis failed

; ---------------------------------------------------------------------------
		pop	es
		push	cs
		push	es

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

memcpy		proc far		; CODE XREF: sub_1566E+17P
					; sub_1566E+2AP ...

arg_0		= dword	ptr  6
arg_4		= dword	ptr  0Ah

		push	bp
		mov	bp, sp
		push	si
		push	di
		push	ds
		lds	si, [bp+arg_0]
		les	di, [bp+arg_4]
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
memcpy		endp


; =============== S U B	R O U T	I N E =======================================


sub_12DB1	proc near		; CODE XREF: sub_10924+1Cp
					; sub_10B08+1Ap ...
		push	si
		xchg	ax, si
		xchg	ax, dx
		test	ax, ax
		jz	short loc_12DBA
		mul	bx

loc_12DBA:				; CODE XREF: sub_12DB1+5j
		jcxz	short loc_12DC1
		xchg	ax, cx
		mul	si
		add	ax, cx

loc_12DC1:				; CODE XREF: sub_12DB1:loc_12DBAj
		xchg	ax, si
		mul	bx
		add	dx, si
		pop	si
		retn
sub_12DB1	endp


; =============== S U B	R O U T	I N E =======================================


sub_12DC8	proc near		; CODE XREF: sub_10339+11p
					; sub_10339+24p ...
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
		jnz	short locret_12DE8
		cmp	ax, bx

locret_12DE8:				; CODE XREF: sub_12DC8+1Cj
		retn
sub_12DC8	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: thunk

sub_12DE9	proc near		; CODE XREF: sub_12325+338p
		jmp	word_192D2
sub_12DE9	endp

; ---------------------------------------------------------------------------

loc_12DED:				; DATA XREF: seg006:0008o
		push	si
		push	di
		mov	es, word ptr dword_16503+2
		xor	di, di
		push	es
		push	word_16507
		call	sub_12A74
		pop	bx
		mov	bx, ax
		pop	es
		mov	word ptr dword_192CE, ax
		mov	word ptr dword_192CE+2,	dx
		push	ds
		mov	ds, dx
		or	ax, dx
		jnz	short loc_12E16
		jmp	far ptr	Except_Abort
; ---------------------------------------------------------------------------

loc_12E16:				; CODE XREF: seg000:2E0Fj
		xor	ax, ax
		mov	cx, 0FFFFh

loc_12E1B:				; CODE XREF: seg000:2E28j
		mov	[bx], di
		mov	word ptr [bx+2], es
		add	bx, 4
		repne scasb
		cmp	es:[di], al
		jnz	short loc_12E1B
		mov	[bx], ax
		mov	[bx+2],	ax
		pop	ds
		pop	di
		pop	si
		mov	ax, word ptr dword_192CE+2
		mov	word_16501, ax
		mov	ax, word ptr dword_192CE
		mov	word_164FF, ax
		retn

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_12E3F	proc far		; CODE XREF: sub_1566E+253P
					; sub_1566E+605P ...

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		xor	ax, ax
		mov	es, ax
		assume es:nothing
		test	byte ptr es:501h, 8
		jz	short loc_12E66
		mov	ax, 3284
		test	byte ptr es:54Ch, 20h
		jz	short loc_12E7F
		test	byte ptr es:459h, 8
		jz	short loc_12E7F
		mov	ax, 5000
		jmp	short loc_12E7F
; ---------------------------------------------------------------------------

loc_12E66:				; CODE XREF: sub_12E3F+Dj
		mov	ax, 3147
		test	byte ptr es:54Ch, 20h
		jnz	short loc_12E7F
		mov	ax, 2483
		test	byte ptr es:53Ch, 80h
		jnz	short loc_12E7F
		mov	ax, 1575

loc_12E7F:				; CODE XREF: sub_12E3F+18j
					; sub_12E3F+20j ...
		mov	dx, [bp+6]
		cmp	dx, 1
		jb	short loc_12EB2
		jz	short loc_12E8C
		mul	dx
		inc	dx

loc_12E8C:				; CODE XREF: sub_12E3F+48j
		dec	dx
		mov	bx, 100
		xchg	ax, cx
		xchg	ax, dx
		xor	dx, dx
		div	bx
		xchg	ax, cx
		div	bx
		mov	bx, cx
		inc	bx
		mov	cx, ax
		mov	dx, 60h	; '`'
		mov	ah, 40h	; '@'

loc_12EA3:				; CODE XREF: sub_12E3F+67j
					; sub_12E3F+6Ej ...
		in	al, dx		; 8042 keyboard	controller data	register
		test	al, ah
		jz	short loc_12EA3

loc_12EA8:				; CODE XREF: sub_12E3F+6Cj
		in	al, dx		; 8042 keyboard	controller data	register
		test	al, ah
		jnz	short loc_12EA8
		loop	loc_12EA3
		dec	bx

loc_12EB0:
		jnz	short loc_12EA3

loc_12EB2:				; CODE XREF: sub_12E3F+46j
		pop	bp
		retf
sub_12E3F	endp

seg000		ends

; ---------------------------------------------------------------------------
; ===========================================================================

; Segment type:	Pure code
seg001		segment	byte public 'CODE' use16
		assume cs:seg001
		;org 4
		assume es:nothing, ss:nothing, ds:dseg,	fs:nothing, gs:nothing
		jmp	short loc_12EBB
; ---------------------------------------------------------------------------

loc_12EB6:				; CODE XREF: seg001:0011j
		popf
		jmp	short $+2
		jmp	short $+2

loc_12EBB:				; CODE XREF: seg001:0004j
		pushf
		cli
		in	al, 60h		; 8042 keyboard	controller data	register
		test	al, 20h
		jz	short loc_12EB6
		popf
		retn

; =============== S U B	R O U T	I N E =======================================


sub_12EC5	proc near		; CODE XREF: seg001:00F0p seg001:018Ap ...
		push	ax
		push	cx
		push	di
		push	ax
		mov	al, 0Bh
		out	68h, al
		pop	ax
		sub	ax, 2000h
		out	0A1h, al	; Interrupt Controller #2, 8259A
		xchg	ah, al
		out	0A3h, al	; Interrupt Controller #2, 8259A
		xor	ah, ah
		mov	cx, 10h

loc_12EDC:				; CODE XREF: sub_12EC5+30j
		mov	al, ah
		or	al, 20h
		out	0A5h, al	; Interrupt Controller #2, 8259A

loc_12EE2:				; Interrupt Controller #2, 8259A
		in	al, 0A9h
		mov	[di], al
		mov	al, ah
		out	0A5h, al	; Interrupt Controller #2, 8259A
		in	al, 0A9h	; Interrupt Controller #2, 8259A
		mov	[di+1],	al
		add	di, 2
		inc	ah
		dec	cx
		jnz	short loc_12EDC
		mov	al, 0Ah
		out	68h, al
		pop	di
		pop	cx
		pop	ax
		retn
sub_12EC5	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_12F00	proc near		; CODE XREF: seg001:loc_132C6p
					; seg001:loc_132DDp ...
		push	ax
		push	bx
		push	cx
		shl	bx, 4
		mov	cx, bx
		shl	bx, 2
		add	bx, cx
		mov	cx, ax
		shr	ax, 3
		add	bx, ax
		and	cx, 7
		mov	al, 80h	; '€'
		shr	al, cl
		mov	es:[bx], al
		pop	cx
		pop	bx
		pop	ax
		retn
sub_12F00	endp

; ---------------------------------------------------------------------------
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
; ---------------------------------------------------------------------------

PrintCharacter:
		enter	0, 0
		push	si
		push	di
		push	ds
		mov	si, [bp+8]
		mov	di, 72h	; 'r'
		mov	al, 0Bh
		out	68h, al
		mov	dx, [bp+0Ah]
		mov	ax, [bp+6]
		mov	ax, ax
		add	ah, ah
		sub	al, 1Fh
		js	short loc_12F98
		nop
		nop
		nop
		cmp	al, 61h
		adc	al, 0DEh

loc_12F98:				; CODE XREF: seg001:00DFj
		add	ax, 1FA1h
		and	ax, 7F7Fh
		push	cs
		pop	ds
		assume ds:seg001
		call	sub_12EC5
		call	sub_12FAB
		pop	ds
		assume ds:dseg
		pop	di
		pop	si
		leave
		retf

; =============== S U B	R O U T	I N E =======================================


sub_12FAB	proc near		; CODE XREF: seg001:00F3p
		pushf
		cli
		cld
		mov	al, 0C0h ; 'À'
		out	7Ch, al
		mov	bx, dx
		mov	bh, 1

loc_12FB6:				; CODE XREF: sub_12FAB+1Dj
		mov	al, 0FFh
		test	bl, bh
		jnz	short loc_12FC1
		nop
		nop
		nop
		mov	al, 0

loc_12FC1:				; CODE XREF: sub_12FAB+Fj
		out	7Eh, al
		shl	bh, 1
		cmp	bh, 10h
		jnz	short loc_12FB6
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		xchg	si, di
		mov	cx, 10h
		test	dl, 80h
		jz	short loc_12FF1
		nop
		nop
		nop

loc_12FDC:				; CODE XREF: sub_12FAB+41j
		lodsw
		mov	dx, ax
		xchg	ah, al
		shr	ax, 1
		xchg	ah, al
		or	ax, dx
		stosw
		add	di, 4Eh	; 'N'
		dec	cx
		jnz	short loc_12FDC
		jmp	short loc_12FF8
; ---------------------------------------------------------------------------
		nop

loc_12FF1:				; CODE XREF: sub_12FAB+2Cj
					; sub_12FAB+4Bj
		movsw
		add	di, 4Eh	; 'N'
		dec	cx
		jnz	short loc_12FF1

loc_12FF8:				; CODE XREF: sub_12FAB+43j
		xor	al, al
		out	7Ch, al
		popf
		retn
sub_12FAB	endp

; ---------------------------------------------------------------------------
		enter	0, 0
		push	si
		push	di
		push	ds
		mov	ax, [bp+0Ah]
		shl	ax, 4
		mov	si, ax
		shl	ax, 2
		add	si, ax
		mov	bx, [bp+8]
		mov	dx, bx
		shr	bx, 3
		add	si, bx
		and	dx, 7
		mov	di, 72h	; 'r'
		mov	ax, [bp+6]
		add	ah, ah
		sub	al, 1Fh
		js	short loc_13032
		nop
		nop
		nop
		cmp	al, 61h	; 'a'
		adc	al, 0DEh ; 'Þ'

loc_13032:				; CODE XREF: seg001:0179j
		add	ax, 1FA1h
		and	ax, 7F7Fh
		push	cs
		pop	ds
		assume ds:seg001
		call	sub_12EC5
		mov	ax, 0E000h
		mov	es, ax
		assume es:nothing
		xchg	si, di
		mov	bx, 10h
		mov	cx, dx

loc_13049:				; CODE XREF: seg001:01B7j
		push	di
		mov	ax, [si]
		push	ax
		xchg	ah, al
		shr	ax, cl
		xchg	ah, al
		or	es:[di], ax
		pop	ax
		xor	al, al
		shr	ax, cl
		or	es:[di+2], al
		add	si, 2
		pop	di
		add	di, 50h	; 'P'
		dec	bx
		jnz	short loc_13049
		pop	ds
		assume ds:dseg
		pop	di
		pop	si
		leave
		retf
; ---------------------------------------------------------------------------
		enter	0, 0
		push	si
		push	di
		push	ds
		mov	ax, [bp+0Ah]
		shl	ax, 4
		mov	si, ax
		shl	ax, 2
		add	si, ax
		mov	bx, [bp+8]
		mov	dx, bx
		shr	bx, 3
		add	si, bx
		and	dx, 7
		mov	di, 72h	; 'r'
		mov	ax, [bp+6]
		add	ah, ah
		sub	al, 1Fh
		js	short loc_130A2
		nop
		nop
		nop
		cmp	al, 61h	; 'a'
		adc	al, 0DEh ; 'Þ'

loc_130A2:				; CODE XREF: seg001:01E9j
		add	ax, 1FA1h
		and	ax, 7F7Fh
		push	cs
		pop	ds
		assume ds:seg001
		call	sub_12EC5
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		xchg	si, di
		mov	ax, [bp+0Eh]
		add	ax, ax
		add	si, ax
		mov	bx, [bp+10h]
		mov	cx, dx

loc_130C0:				; CODE XREF: seg001:022Ej
		push	di
		mov	ax, [si]
		push	ax
		xchg	ah, al
		shr	ax, cl
		xchg	ah, al
		mov	es:[di], ax
		pop	ax
		xor	al, al
		shr	ax, cl
		mov	es:[di+2], al
		add	si, 2
		pop	di
		add	di, 50h	; 'P'
		dec	bx
		jnz	short loc_130C0
		pop	ds
		assume ds:dseg
		pop	di
		pop	si
		leave
		retf
; ---------------------------------------------------------------------------
		enter	0, 0
		push	si
		push	di
		push	ds
		mov	ax, [bp+0Ah]
		shl	ax, 4
		mov	si, ax
		shl	ax, 2
		add	si, ax
		mov	bx, [bp+8]
		mov	dx, bx
		shr	bx, 3
		add	si, bx
		and	dx, 7
		mov	di, 72h	; 'r'
		mov	ax, [bp+6]
		add	ah, ah
		sub	al, 1Fh
		js	short loc_13119
		nop
		nop
		nop
		cmp	al, 61h	; 'a'
		adc	al, 0DEh ; 'Þ'

loc_13119:				; CODE XREF: seg001:0260j
		add	ax, 1FA1h
		and	ax, 7F7Fh
		push	cs
		pop	ds
		assume ds:seg001
		call	sub_12EC5
		mov	ax, 0E000h
		mov	es, ax
		assume es:nothing
		xchg	si, di
		mov	bx, 10h
		mov	cx, dx

loc_13130:				; CODE XREF: seg001:02A7j
		push	di
		mov	ax, [si]
		push	ax
		xchg	ah, al
		shr	ax, cl
		xchg	ah, al
		or	es:[di], ax
		or	es:[di+50h], ax
		pop	ax
		xor	al, al
		shr	ax, cl
		or	es:[di+2], al
		or	es:[di+52h], al
		add	si, 2
		pop	di
		add	di, 0A0h ; ' '
		dec	bx
		jnz	short loc_13130
		pop	ds
		assume ds:dseg
		pop	di
		pop	si
		leave
		retf

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1315E	proc far		; CODE XREF: sub_15553+6BP
					; sub_15553+92P

arg_0		= word ptr  6
arg_2		= word ptr  8
arg_4		= word ptr  0Ah
arg_6		= word ptr  0Ch

		enter	0, 0
		push	si
		push	di
		push	ds
		mov	ax, [bp+arg_4]
		shl	ax, 4
		mov	si, ax
		shl	ax, 2
		add	si, ax
		mov	bx, [bp+arg_2]
		mov	dx, bx
		shr	bx, 3
		add	si, bx
		and	dx, 7
		mov	di, 72h	; 'r'
		mov	ax, [bp+arg_0]
		add	ah, ah
		sub	al, 1Fh
		js	short loc_13192
		nop
		nop
		nop
		cmp	al, 61h	; 'a'
		adc	al, 0DEh ; 'Þ'

loc_13192:				; CODE XREF: sub_1315E+2Bj
		add	ax, 1FA1h
		and	ax, 7F7Fh
		push	cs
		pop	ds
		assume ds:seg001
		call	sub_12EC5
		mov	al, 0C0h ; 'À'
		out	7Ch, al
		mov	bx, [bp+arg_6]
		mov	bh, 1

loc_131A6:				; CODE XREF: sub_1315E+5Aj
		mov	al, 0FFh
		test	bl, bh
		jnz	short loc_131B1
		nop
		nop
		nop
		mov	al, 0

loc_131B1:				; CODE XREF: sub_1315E+4Cj
		out	7Eh, al
		shl	bh, 1
		cmp	bh, 10h
		jnz	short loc_131A6
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		xchg	si, di
		mov	bx, 10h
		mov	cx, dx

loc_131C6:				; CODE XREF: sub_1315E+8Fj
		push	di
		mov	ax, [si]
		push	ax
		xchg	ah, al
		shr	ax, cl
		xchg	ah, al
		mov	es:[di], ax
		mov	es:[di+50h], ax
		pop	ax
		xor	al, al
		shr	ax, cl
		mov	es:[di+2], al
		mov	es:[di+52h], al
		add	si, 2
		pop	di
		add	di, 0A0h ; ' '
		dec	bx
		jnz	short loc_131C6
		pop	ds
		assume ds:dseg
		pop	di
		pop	si
		leave
		retf
sub_1315E	endp


; =============== S U B	R O U T	I N E =======================================


sub_131F4	proc far		; CODE XREF: sub_131F4+8j sub_131FF+1p ...
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 2
		jmp	short $+2
		jmp	short $+2
		jnz	short near ptr sub_131F4
		retf
sub_131F4	endp


; =============== S U B	R O U T	I N E =======================================


sub_131FF	proc far		; CODE XREF: sub_1566E+20FP
		push	cs
		call	near ptr sub_131F4
		mov	al, 0Dh
		out	0A2h, al	; Interrupt Controller #2, 8259A
		mov	ax, 0
		mov	es, ax
		assume es:nothing
		mov	al, 80h	; '€'
		or	es:54Ch, al
		retf
sub_131FF	endp

; ---------------------------------------------------------------------------
		push	cs
		call	near ptr sub_131F4
		mov	al, 0Ch
		out	0A2h, al	; Interrupt Controller #2, 8259A
		mov	ax, 0
		mov	es, ax
		mov	al, 7Fh	; ''
		and	es:54Ch, al
		retf

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_13229	proc far		; CODE XREF: sub_1566E+52P
					; sub_1566E+3F2P ...

arg_0		= byte ptr  6
arg_2		= byte ptr  8

		enter	0, 0
		mov	al, [bp+arg_0]
		mov	ah, [bp+arg_2]
		and	ax, 101h
		out	0A4h, al	; Interrupt Controller #2, 8259A
		mov	al, [bp+arg_2]
		jmp	short $+2
		jmp	short $+2
		out	0A6h, al	; Interrupt Controller #2, 8259A
		leave
		retf
sub_13229	endp


; =============== S U B	R O U T	I N E =======================================


sub_13243	proc far		; CODE XREF: sub_13243+8j
					; sub_1566E:loc_158E5P	...
		jmp	short $+2
		jmp	short $+2
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short near ptr sub_13243
		pushf

loc_1324E:				; CODE XREF: sub_13243+17j
		cli
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1325C
		nop
		nop
		nop
		popf
		pushf
		jmp	short loc_1324E
; ---------------------------------------------------------------------------

loc_1325C:				; CODE XREF: sub_13243+10j
		popf
		retf
sub_13243	endp

; ---------------------------------------------------------------------------
		enter	0, 0
		push	si
		push	di
		mov	al, 0C0h ; 'À'
		out	7Ch, al
		mov	bx, [bp+0Eh]
		mov	bh, 1

loc_1326D:				; CODE XREF: seg001:03CFj
		mov	al, 0FFh
		test	bl, bh
		jnz	short loc_13278
		nop
		nop
		nop
		mov	al, 0

loc_13278:				; CODE XREF: seg001:03C1j
		out	7Eh, al
		shl	bh, 1
		cmp	bh, 10h
		jnz	short loc_1326D
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		mov	ax, [bp+6]
		mov	bx, [bp+8]
		mov	cx, [bp+0Ah]
		mov	dx, [bp+0Ch]
		cmp	ax, cx
		jz	short loc_132B8
		nop
		nop
		nop
		cmp	bx, dx
		jz	short loc_132D0
		nop
		nop
		nop
		cmp	ax, cx
		jbe	short loc_132AA
		nop
		nop
		nop
		xchg	ax, cx
		xchg	bx, dx

loc_132AA:				; CODE XREF: seg001:03F2j
		mov	si, cx
		sub	si, ax
		cmp	bx, dx
		jb	short loc_13330
		nop
		nop
		nop
		jmp	short loc_132E7
; ---------------------------------------------------------------------------
		align 2

loc_132B8:				; CODE XREF: seg001:03E4j
		cmp	bx, dx
		jb	short loc_132C1
		nop
		nop
		nop
		xchg	bx, dx

loc_132C1:				; CODE XREF: seg001:040Aj
		mov	cx, dx
		sub	cx, bx
		inc	cx

loc_132C6:				; CODE XREF: seg001:041Bj
		call	sub_12F00
		inc	bx
		dec	cx
		jnz	short loc_132C6
		jmp	loc_13371
; ---------------------------------------------------------------------------

loc_132D0:				; CODE XREF: seg001:03EBj
		cmp	ax, cx
		jb	short loc_132D8
		nop
		nop
		nop
		xchg	ax, cx

loc_132D8:				; CODE XREF: seg001:0422j
		mov	dx, cx
		sub	dx, ax
		inc	dx

loc_132DD:				; CODE XREF: seg001:0432j
		call	sub_12F00
		inc	ax
		dec	dx
		jnz	short loc_132DD
		jmp	loc_13371
; ---------------------------------------------------------------------------

loc_132E7:				; CODE XREF: seg001:0405j
		mov	di, bx
		sub	di, dx
		cmp	si, di
		ja	short loc_132F5
		nop
		nop
		nop
		jmp	short loc_13310
; ---------------------------------------------------------------------------
		nop

loc_132F5:				; CODE XREF: seg001:043Dj
		mov	dx, si
		shr	dx, 1

loc_132F9:				; CODE XREF: seg001:045Bj
		call	sub_12F00
		inc	ax
		add	dx, di
		cmp	dx, si
		jb	short loc_13309
		nop
		nop
		nop
		sub	dx, si
		dec	bx

loc_13309:				; CODE XREF: seg001:0451j
		cmp	ax, cx
		jbe	short loc_132F9
		jmp	short loc_13371
; ---------------------------------------------------------------------------
		align 2

loc_13310:				; CODE XREF: seg001:0442j
		mov	cx, di
		shr	cx, 1

loc_13314:				; CODE XREF: seg001:047Bj
		call	sub_12F00
		add	cx, si
		cmp	cx, di
		jb	short loc_13323
		nop
		nop
		nop
		sub	cx, di
		inc	ax

loc_13323:				; CODE XREF: seg001:046Bj
		cmp	bx, dx
		jz	short loc_1332D
		nop
		nop
		nop
		dec	bx
		jmp	short loc_13314
; ---------------------------------------------------------------------------

loc_1332D:				; CODE XREF: seg001:0475j
		jmp	short loc_13371
; ---------------------------------------------------------------------------
		align 2

loc_13330:				; CODE XREF: seg001:0400j
		mov	di, dx
		sub	di, bx
		cmp	si, di
		ja	short loc_1333E
		nop
		nop
		nop
		jmp	short loc_13359
; ---------------------------------------------------------------------------
		align 2

loc_1333E:				; CODE XREF: seg001:0486j
		mov	dx, si
		shr	dx, 1

loc_13342:				; CODE XREF: seg001:04A4j
		call	sub_12F00
		inc	ax
		add	dx, di
		cmp	dx, si
		jb	short loc_13352
		nop
		nop
		nop
		sub	dx, si
		inc	bx

loc_13352:				; CODE XREF: seg001:049Aj
		cmp	ax, cx
		jbe	short loc_13342
		jmp	short loc_13371
; ---------------------------------------------------------------------------
		db 90h
; ---------------------------------------------------------------------------

loc_13359:				; CODE XREF: seg001:048Bj
		mov	cx, di
		shr	cx, 1

loc_1335D:				; CODE XREF: seg001:04BFj
		call	sub_12F00
		inc	bx
		add	cx, si
		cmp	cx, di
		jb	short loc_1336D
		nop
		nop
		nop
		sub	cx, di
		inc	ax

loc_1336D:				; CODE XREF: seg001:04B5j
		cmp	bx, dx
		jbe	short loc_1335D

loc_13371:				; CODE XREF: seg001:041Dj seg001:0434j ...
		xor	al, al
		out	7Ch, al
		pop	di
		pop	si
		leave
		retf
; ---------------------------------------------------------------------------
		enter	0, 0
		push	bx
		mov	al, 0C0h ; 'À'
		out	7Ch, al
		mov	bx, [bp+0Ah]
		mov	bh, 1

loc_13387:				; CODE XREF: seg001:04E9j
		mov	al, 0FFh
		test	bl, bh
		jnz	short loc_13392
		nop
		nop
		nop
		mov	al, 0

loc_13392:				; CODE XREF: seg001:04DBj
		out	7Eh, al
		shl	bh, 1
		cmp	bh, 10h
		jnz	short loc_13387
		mov	ax, 0A800h
		mov	es, ax
		mov	ax, [bp+6]
		mov	bx, [bp+8]
		call	sub_12F00
		xor	al, al
		out	7Ch, al
		pop	bx
		leave
		retf

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_133B0	proc far		; CODE XREF: sub_1566E+48P
					; sub_1566E+81FP ...

arg_0		= word ptr  6

		enter	0, 0
		push	di
		mov	al, 80h	; '€'
		out	7Ch, al
		mov	bx, [bp+arg_0]
		mov	bh, 1

loc_133BE:				; CODE XREF: sub_133B0+20j
		mov	al, 0FFh
		test	bl, bh
		jnz	short loc_133C9
		nop
		nop
		nop
		mov	al, 0

loc_133C9:				; CODE XREF: sub_133B0+12j
		out	7Eh, al
		shl	bh, 1
		cmp	bh, 10h
		jnz	short loc_133BE
		mov	ax, 0A800h
		mov	es, ax
		xor	di, di
		mov	cx, 3E80h
		rep stosw
		xor	al, al
		out	7Ch, al
		pop	di
		leave
		retf
sub_133B0	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_133E5	proc far		; CODE XREF: sub_161D5+42P

arg_0		= byte ptr  6

		enter	0, 0
		push	di
		mov	ax, 0A000h
		mov	es, ax
		assume es:nothing
		xor	di, di
		mov	cx, 7D0h
		xor	ah, ah
		mov	al, [bp+arg_0]
		rep stosw
		mov	ax, 0A200h
		mov	es, ax
		assume es:nothing
		xor	di, di
		mov	cx, 7D0h
		xor	ax, ax

loc_13407:				; CODE XREF: sub_133E5+25j
		stosb
		inc	di
		dec	cx
		jnz	short loc_13407
		pop	di
		leave
		retf
sub_133E5	endp

; ---------------------------------------------------------------------------
		enter	0, 0
		mov	ax, [bp+8]
		shl	ax, 5
		mov	bx, ax
		shl	ax, 2
		add	bx, ax
		mov	ax, [bp+6]
		add	ax, ax
		add	bx, ax
		mov	ax, [bp+0Ah]
		mov	dx, [bp+0Ch]
		mov	cx, 0A000h
		mov	es, cx
		assume es:nothing
		mov	es:[bx], ax
		add	bx, 2000h
		mov	es:[bx], dx
		leave
		retf
; ---------------------------------------------------------------------------
		enter	0, 0
		mov	ax, [bp+8]
		shl	ax, 5
		mov	bx, ax
		shl	ax, 2
		add	bx, ax
		mov	ax, [bp+6]
		add	ax, ax
		add	bx, ax
		mov	ax, 0A000h
		mov	es, ax
		mov	ax, es:[bx]
		leave
		retf
; ---------------------------------------------------------------------------
		enter	0, 0
		mov	ax, [bp+8]
		shl	ax, 5
		mov	bx, ax
		shl	ax, 2
		add	bx, ax
		mov	ax, [bp+6]
		add	ax, ax
		add	bx, ax
		mov	ax, 0A200h
		mov	es, ax
		assume es:nothing
		mov	ax, es:[bx]
		leave
		retf
; ---------------------------------------------------------------------------
		enter	0, 0
		mov	ax, [bp+8]
		shl	ax, 5
		mov	bx, ax
		shl	ax, 2
		add	bx, ax
		mov	ax, [bp+6]
		add	ax, ax
		add	bx, ax
		mov	ax, 0A200h
		mov	es, ax
		mov	ax, [bp+0Ah]
		or	es:[bx], ax
		leave
		retf
; ---------------------------------------------------------------------------
		enter	0, 0
		mov	ax, [bp+8]
		shl	ax, 5
		mov	bx, ax
		shl	ax, 2
		add	bx, ax
		mov	ax, [bp+6]
		add	ax, ax
		add	bx, ax
		mov	ax, 0A200h
		mov	es, ax
		mov	ax, [bp+0Ah]
		xor	es:[bx], ax
		leave
		retf
; ---------------------------------------------------------------------------
		enter	0, 0
		mov	ax, 0A000h
		mov	es, ax
		assume es:nothing
		mov	ax, [bp+8]
		shl	ax, 5
		mov	bx, ax
		shl	ax, 2
		add	bx, ax
		mov	ax, [bp+6]
		add	ax, ax
		add	bx, ax
		mov	ax, [bp+0Ah]
		mov	dx, [bp+0Ch]
		add	bx, 2000h
		mov	es:[bx], dx
		mov	es:[bx+2], dx
		mov	es:[bx+4], dx
		mov	es:[bx+6], dx
		sub	bx, 2000h
		mov	cl, 4

loc_13508:				; CODE XREF: seg001:0676j
		rol	ax, 4
		mov	dl, al
		and	dl, 0Fh
		cmp	dl, 9
		jbe	short loc_1351B
		nop
		nop
		nop
		add	dl, 27h	; '''

loc_1351B:				; CODE XREF: seg001:0663j
		add	dl, 30h	; '0'
		mov	es:[bx], dl
		add	bx, 2
		dec	cl
		jnz	short loc_13508
		leave
		retf
; ---------------------------------------------------------------------------
		enter	0, 0
		push	ds
		push	si
		push	di
		mov	cs:word_1358C, ds
		mov	ax, 0A000h
		mov	es, ax
		mov	ax, [bp+8]
		shl	ax, 5
		mov	di, ax
		shl	ax, 2
		add	di, ax
		mov	ax, [bp+6]
		add	ax, ax
		add	di, ax
		mov	si, 8Ch	; 'Œ'
		mov	ax, es:[di]
		mov	dx, es:[di+2]
		mov	[si], ax
		mov	[si+2],	ax
		add	di, 2000h
		mov	ax, es:[di]
		mov	dx, es:[di+2]
		mov	[si+4],	ax
		mov	[si+6],	dx
		mov	word ptr es:[di], 0C5C5h
		mov	word ptr es:[di+2], 0C5C5h
		sub	di, 2000h
		mov	word ptr es:[di], 2020h
		mov	word ptr es:[di+2], 2020h
		pop	di
		pop	si
		pop	ds
; ---------------------------------------------------------------------------
word_1358C	dw 0			; DATA XREF: seg001:0681w
; ---------------------------------------------------------------------------
		leave
		retf
; ---------------------------------------------------------------------------
		enter	0, 0
		mov	ax, 0
		mov	es, ax
		assume es:nothing
		mov	al, [bp+6]
		and	al, 1
		shl	al, 5
		and	byte ptr es:500h, 0DFh
		or	es:500h, al
		leave
		retf

; =============== S U B	R O U T	I N E =======================================


sub_135AE	proc far		; CODE XREF: sub_1566E+40P
		mov	al, 0Dh
		out	62h, al		; PC/XT	PPI port C. Bits:
					; 0-3: values of DIP switches
					; 5: 1=Timer 2 channel out
					; 6: 1=I/O channel check
					; 7: 1=RAM parity check	error occurred.
		retf
sub_135AE	endp

; ---------------------------------------------------------------------------
		mov	al, 0Ch
		out	62h, al		; PC/XT	PPI port C. Bits:
					; 0-3: values of DIP switches
					; 5: 1=Timer 2 channel out
					; 6: 1=I/O channel check
					; 7: 1=RAM parity check	error occurred.
		retf
; ---------------------------------------------------------------------------
		enter	0, 0
		push	ds
		push	si
		push	di
		mov	ax, 0A000h
		mov	es, ax
		assume es:nothing
		mov	ax, 0A200h
		mov	ds, ax
		assume ds:nothing
		mov	cl, [bp+0Ch]
		mov	ax, [bp+8]
		shl	ax, 5
		mov	di, ax
		shl	ax, 2
		add	di, ax
		mov	ax, [bp+6]
		add	ax, ax
		add	di, ax
		xor	dx, dx
		mov	ax, [bp+0Ah]
		mov	bx, 0Ah
		div	bx
		mov	es:[di+8], dl
		mov	[di+8],	cl
		div	bx
		mov	es:[di+6], dl
		mov	[di+6],	cl
		div	bx
		mov	es:[di+4], dl
		mov	[di+4],	cl
		div	bx
		mov	es:[di+2], dl
		mov	[di+2],	cl
		mov	es:[di], al
		mov	[di], cl
		pop	di
		pop	si
		pop	ds
		assume ds:dseg
		leave
		retf
; ---------------------------------------------------------------------------
		enter	0, 0
		cld
		push	si
		push	di
		push	bp
		push	ds
		mov	ax, [bp+6]
		mov	bx, [bp+8]
		mov	cx, [bp+0Ah]
		mov	dx, [bp+0Ch]
		cmp	ax, cx
		jb	short loc_13633
		nop
		nop
		nop
		xchg	ax, cx

loc_13633:				; CODE XREF: seg001:077Dj
		cmp	bx, dx
		jb	short loc_1363C
		nop
		nop
		nop
		xchg	bx, dx

loc_1363C:				; CODE XREF: seg001:0785j
		push	bx
		shl	bx, 4
		mov	si, bx
		shl	bx, 2
		add	si, bx
		shr	ax, 3
		shr	cx, 3
		add	si, ax
		pop	bx
		sub	cx, ax
		sub	dx, bx
		inc	cx
		inc	dx

loc_13656:				; CODE XREF: seg001:0818j
		push	ds
		pop	es
		assume es:dseg
		push	si
		mov	di, 8Ch	; 'Œ'
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		push	si
		push	cx
		mov	ax, 0A800h
		mov	ds, ax
		assume ds:nothing
		rep movsb
		pop	cx
		pop	si
		push	si
		push	cx
		mov	ax, 0B000h
		mov	ds, ax
		assume ds:nothing
		rep movsb
		pop	cx
		pop	si
		push	si
		push	cx
		mov	ax, 0B800h
		mov	ds, ax
		assume ds:nothing
		rep movsb
		pop	cx
		pop	si
		push	si
		push	cx
		mov	ax, 0E000h
		mov	ds, ax
		assume ds:nothing
		rep movsb
		pop	cx
		pop	si
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		push	es
		pop	ds
		assume ds:dseg
		mov	di, si
		mov	si, 8Ch	; 'Œ'
		push	di
		push	cx
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		rep movsb
		pop	cx
		pop	di
		push	di
		push	cx
		mov	ax, 0B000h
		mov	es, ax
		assume es:nothing
		rep movsb
		pop	cx
		pop	di
		push	di
		push	cx
		mov	ax, 0B800h
		mov	es, ax
		assume es:nothing
		rep movsb
		pop	cx
		pop	di
		push	di
		push	cx
		mov	ax, 0E000h
		mov	es, ax
		assume es:nothing
		rep movsb
		pop	cx
		pop	di
		pop	si
		add	si, 50h	; 'P'
		dec	dx
		jnz	short loc_13656
		pop	ds
		pop	bp
		pop	di
		pop	si
		leave
		retf

; =============== S U B	R O U T	I N E =======================================


sub_136D0	proc near		; CODE XREF: seg001:0840p seg001:0846p ...
		mov	cx, 3E80h
		xor	si, si
		mov	es, ax
		assume es:nothing

loc_136D7:				; CODE XREF: sub_136D0+19j
		mov	bx, es:[si]
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	es:[si], bx
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		add	si, 2
		dec	cx
		jnz	short loc_136D7
		retn
sub_136D0	endp

; ---------------------------------------------------------------------------
		push	si
		mov	ax, 0A800h
		call	sub_136D0
		mov	ax, 0B000h
		call	sub_136D0
		mov	ax, 0B800h
		call	sub_136D0
		mov	ax, 0E000h
		call	sub_136D0
		pop	si
		retf

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_13707	proc far		; CODE XREF: sub_1566E+228P
					; sub_1566E+247P ...

arg_0		= byte ptr  6
arg_2		= byte ptr  8
arg_4		= byte ptr  0Ah
arg_6		= byte ptr  0Ch
arg_8		= byte ptr  0Eh
arg_A		= byte ptr  10h

		enter	0, 0
		push	ds
		push	di
		mov	al, [bp+arg_0]
		mov	ah, [bp+arg_2]
		mov	dl, [bp+arg_4]
		mov	dh, [bp+arg_6]
		cmp	al, dl
		jb	short loc_13722
		nop
		nop
		nop
		xchg	al, dl

loc_13722:				; CODE XREF: sub_13707+14j
		cmp	ah, dh
		jb	short loc_1372B
		nop
		nop
		nop
		xchg	ah, dh

loc_1372B:				; CODE XREF: sub_13707+1Dj
		mov	ch, dh
		sub	ch, ah
		mov	cl, dl
		sub	cl, al
		xor	dx, dx
		mov	dl, ah
		shl	dx, 5
		mov	di, dx
		shl	dx, 2
		add	di, dx
		xor	ah, ah
		add	di, ax
		add	di, ax
		mov	ax, 0A000h
		mov	es, ax
		assume es:nothing
		mov	ax, 0A200h
		mov	ds, ax
		assume ds:nothing
		mov	ah, [bp+arg_8]
		mov	al, [bp+arg_A]
		mov	bx, di
		inc	cl
		inc	ch
		mov	dl, cl

loc_1375F:				; CODE XREF: sub_13707+6Ej
		mov	cl, dl
		mov	di, bx

loc_13763:				; CODE XREF: sub_13707+66j
		mov	es:[di], ah
		mov	[di], al
		add	di, 2
		dec	cl
		jnz	short loc_13763
		add	bx, 0A0h ; ' '
		dec	ch
		jnz	short loc_1375F
		pop	di
		pop	ds
		assume ds:dseg
		leave
		retf
sub_13707	endp

; ---------------------------------------------------------------------------
		enter	0, 0
		push	ds
		push	di
		mov	al, [bp+0Ah]
		xor	ah, ah
		shl	ax, 5
		mov	di, ax
		shl	ax, 2
		add	di, ax
		mov	al, [bp+8]
		xor	ah, ah
		add	di, ax
		add	di, ax
		mov	ax, [bp+6]
		xchg	ah, al
		mov	ax, ax
		add	ah, ah
		sub	al, 1Fh
		js	short loc_137AD
		nop
		nop
		nop
		cmp	al, 61h	; 'a'
		adc	al, 0DEh ; 'Þ'

loc_137AD:				; CODE XREF: seg001:08F4j
		add	ax, 1FA1h
		and	ax, 7F7Fh
		mov	bx, 0A000h
		mov	es, bx
		mov	bx, 0A200h
		mov	ds, bx
		assume ds:nothing
		sub	ah, 20h	; ' '
		mov	dh, ah
		or	dh, 80h
		mov	dl, [bp+0Ch]
		mov	es:[di], ah
		mov	es:[di+1], al
		mov	es:[di+2], dh
		mov	es:[di+3], al
		mov	[di], dl
		mov	[di+2],	dl
		pop	di
		pop	ds
		assume ds:dseg
		leave
		retf
; ---------------------------------------------------------------------------
		enter	0, 0
		push	ds
		push	si
		push	di
		xor	ah, ah
		mov	al, [bp+0Ch]
		shl	ax, 5
		mov	di, ax
		xor	bh, bh
		mov	bl, [bp+0Ah]
		shl	ax, 2
		shl	bx, 1
		add	di, ax
		add	di, bx
		lds	si, [bp+6]
		mov	ax, 0A000h
		mov	dl, [bp+0Eh]
		mov	es, ax
		xor	dh, dh
		xor	ah, ah
		push	di

loc_1380F:				; CODE XREF: seg001:096Cj
		mov	al, [si]
		inc	si
		and	al, al
		jz	short loc_1381E
		nop
		nop
		nop
		stosw
		inc	dh
		jmp	short loc_1380F
; ---------------------------------------------------------------------------

loc_1381E:				; CODE XREF: seg001:0964j
		pop	di
		mov	cl, dh
		xor	ch, ch
		mov	al, dl
		xor	ah, ah
		mov	bx, 0A200h
		mov	es, bx
		assume es:nothing
		rep stosw
		pop	di
		pop	si
		pop	ds
		leave
		retf
; ---------------------------------------------------------------------------
		enter	0, 0
		push	si
		push	di
		push	ds
		mov	ax, [bp+10h]
		shl	ax, 4
		mov	di, ax
		shl	ax, 2
		add	di, ax
		mov	ax, [bp+0Eh]
		shr	ax, 3
		add	di, ax
		mov	bx, [bp+8]
		shl	bx, 4
		mov	si, bx
		shl	bx, 2
		add	si, bx
		mov	bx, [bp+6]
		shr	bx, 3
		add	si, bx
		mov	cx, [bp+0Ah]
		shr	cx, 3
		mov	dx, [bp+0Ch]

loc_1386D:				; CODE XREF: seg001:09F4j
		mov	bx, 0F8Ch
		mov	ah, 4

loc_13872:				; CODE XREF: seg001:09EBj
		push	si
		push	di
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		push	ds
		pop	es
		assume es:dseg
		mov	ds, word ptr [bx]
		push	cx
		push	di
		mov	di, 8Ch	; 'Œ'
		rep movsb
		pop	di
		pop	cx
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		push	ds
		push	es
		pop	ds
		pop	es
		assume es:nothing
		mov	si, 8Ch	; 'Œ'
		push	cx
		rep movsb
		pop	cx
		pop	di
		pop	si
		add	bx, 2
		dec	ah
		jnz	short loc_13872
		add	di, 50h	; 'P'
		add	si, 50h	; 'P'
		dec	dx
		jnz	short loc_1386D
		pop	ds
		pop	di
		pop	si
		leave
		retf

; =============== S U B	R O U T	I N E =======================================


sub_138AB	proc near		; CODE XREF: seg001:0A3Bp seg001:0A41p ...
		mov	ds, ax
		push	si
		push	dx

loc_138AF:				; CODE XREF: sub_138AB+Ej
		push	cx
		push	si
		rep movsb
		pop	si
		pop	cx
		add	si, 50h	; 'P'
		dec	dx
		jnz	short loc_138AF
		pop	dx
		pop	si
		retn
sub_138AB	endp

; ---------------------------------------------------------------------------
		enter	0, 0
		push	ds
		push	si
		push	di
		pushf
		cld
		les	di, [bp+6]
		mov	ax, [bp+0Ch]
		shl	ax, 4
		mov	si, ax
		shl	ax, 2
		add	si, ax
		mov	ax, [bp+0Ah]
		shr	ax, 3
		add	si, ax
		mov	dx, [bp+10h]
		mov	cx, [bp+0Eh]
		shr	cx, 3
		mov	ax, 0A800h
		call	sub_138AB
		mov	ax, 0B000h
		call	sub_138AB
		mov	ax, 0B800h
		call	sub_138AB
		mov	ax, 0E000h
		call	sub_138AB
		popf
		pop	di
		pop	si
		pop	ds
		leave
		retf

; =============== S U B	R O U T	I N E =======================================


sub_13906	proc near		; CODE XREF: seg001:0A97p seg001:0A9Dp ...
		mov	es, ax
		push	di
		push	dx

loc_1390A:				; CODE XREF: sub_13906+Ej
		push	cx
		push	di
		rep movsb
		pop	di
		pop	cx
		add	di, 50h	; 'P'
		dec	dx
		jnz	short loc_1390A
		pop	dx
		pop	di
		retn
sub_13906	endp

; ---------------------------------------------------------------------------
		enter	0, 0
		push	ds
		push	si
		push	di
		pushf
		cld
		lds	si, [bp+6]
		mov	ax, [bp+0Ch]
		shl	ax, 4
		mov	di, ax
		shl	ax, 2
		add	di, ax
		mov	ax, [bp+0Ah]
		shr	ax, 3
		add	di, ax
		mov	dx, [bp+10h]
		mov	cx, [bp+0Eh]
		shr	cx, 3
		inc	cx
		mov	ax, 0A800h
		call	sub_13906
		mov	ax, 0B000h
		call	sub_13906
		mov	ax, 0B800h
		call	sub_13906
		mov	ax, 0E000h
		call	sub_13906
		popf
		pop	di
		pop	si
		pop	ds
		leave
		retf
; ---------------------------------------------------------------------------
		enter	0, 0
		push	di
		mov	di, 0F8Ch
		xor	bx, bx
		mov	bl, [bp+0Eh]
		shl	bx, 1
		mov	ax, [bx+di]
		mov	es, ax
		mov	ax, [bp+8]
		shl	ax, 4
		mov	di, ax
		shl	ax, 2
		add	di, ax
		mov	ax, [bp+6]
		shr	ax, 3
		add	di, ax
		mov	dx, [bp+0Ch]
		mov	cx, [bp+0Ah]
		shr	cx, 3
		mov	al, [bp+10h]

loc_13996:				; CODE XREF: seg001:0AF0j
		push	di
		push	cx
		rep stosb
		pop	cx
		pop	di
		add	di, 50h	; 'P'
		dec	dx
		jnz	short loc_13996
		pop	di
		leave
		retf

; =============== S U B	R O U T	I N E =======================================


sub_139A5	proc near		; CODE XREF: seg001:0B89p seg001:0B9Bp
		push	ax
		push	bx
		push	cx
		push	si
		push	di
		mov	si, offset byte_17424
		add	si, 300h
		shl	bx, 4
		add	si, bx
		mov	ch, 10h

loc_139B8:				; CODE XREF: sub_139A5+26j
		mov	ah, [si]
		xor	al, al
		shr	ax, cl
		xchg	ah, al
		mov	es:[di], ax
		add	di, 50h
		add	si, 1
		dec	ch
		jnz	short loc_139B8
		pop	di
		pop	si
		pop	cx
		pop	bx
		pop	ax
		retn
sub_139A5	endp

; ---------------------------------------------------------------------------
		enter	0, 0
		push	bp
		mov	bp, sp
		add	bp, 2
		push	si
		push	di
		mov	al, 0C0h
		out	7Ch, al
		mov	bx, [bp+10h]
		mov	bh, 1

loc_139E8:				; CODE XREF: seg001:0B4Aj
		mov	al, 0FFh
		test	bl, bh
		jnz	short loc_139F3
		nop
		nop
		nop
		mov	al, 0

loc_139F3:				; CODE XREF: seg001:0B3Cj
		out	7Eh, al
		shl	bh, 1
		cmp	bh, 10h
		jnz	short loc_139E8
		mov	cx, [bp+0Ah]
		mov	di, cx
		dec	di
		mov	ch, cl
		mov	ax, [bp+0Eh]
		shl	ax, 4
		add	di, ax
		shl	ax, 2
		add	di, ax
		mov	ax, [bp+0Ch]
		mov	cl, al
		and	cl, 7
		shr	ax, 3
		add	di, ax
		les	ax, [bp+6]
		mov	dx, es
		mov	bx, 0A800h
		mov	es, bx
		assume es:nothing

loc_13A28:				; CODE XREF: seg001:0BA3j
		and	dx, dx
		jnz	short loc_13A44
		nop
		nop
		nop
		and	ax, ax
		jnz	short loc_13A44
		nop
		nop
		nop

loc_13A36:				; CODE XREF: seg001:0B8Fj
		mov	bx, 0
		call	sub_139A5
		dec	di
		dec	ch
		jnz	short loc_13A36
		jmp	short loc_13A55
; ---------------------------------------------------------------------------
		align 2

loc_13A44:				; CODE XREF: seg001:0B7Aj seg001:0B81j
		mov	bx, 0Ah
		div	bx
		mov	bx, dx
		call	sub_139A5
		xor	dx, dx
		dec	di
		dec	ch
		jnz	short loc_13A28

loc_13A55:				; CODE XREF: seg001:0B91j
		xor	al, al
		out	7Ch, al
		pop	di
		pop	si
		pop	bp
		leave
		retf
; ---------------------------------------------------------------------------
		enter	0, 0
		push	si
		push	di
		push	ds
		push	ds
		pop	es
		assume es:dseg
		mov	ax, [bp+8]
		mov	bx, [bp+0Ch]
		mov	cx, [bp+6]
		mov	dx, [bp+0Ah]
		cmp	ax, bx
		jnb	short loc_13A7B
		nop
		nop
		nop
		xchg	ax, bx

loc_13A7B:				; CODE XREF: seg001:0BC5j
		cmp	cx, dx
		jnb	short loc_13A84
		nop
		nop
		nop
		xchg	cx, dx

loc_13A84:				; CODE XREF: seg001:0BCDj
		shr	cx, 3
		shr	dx, 3
		sub	ax, bx
		inc	ax
		sub	cx, dx
		inc	cx
		shl	bx, 4
		mov	si, bx
		shl	bx, 2
		add	si, bx
		add	si, dx
		mov	di, 8Ch
		mov	bx, 0A800h
		call	sub_13ABC
		mov	bx, 0B000h
		call	sub_13ABC
		mov	bx, 0B800h
		call	sub_13ABC
		mov	bx, 0E000h
		call	sub_13ABC
		pop	ds
		pop	di
		pop	si
		leave
		retf

; =============== S U B	R O U T	I N E =======================================


sub_13ABC	proc near		; CODE XREF: seg001:0BF2p seg001:0BF8p ...
		push	ax
		push	cx
		push	si
		mov	ds, bx
		mov	dx, 1
		call	sub_13AF2
		push	ax
		push	si
		mov	bx, 50h	; 'P'
		dec	ax
		mul	bx
		add	si, ax
		mov	dx, 1
		call	sub_13AF2
		pop	si
		pop	ax
		push	cx
		mov	dx, 50h	; 'P'
		mov	cx, ax
		call	sub_13AF2
		pop	cx
		add	si, cx
		dec	si
		mov	cx, ax
		mov	dx, 50h	; 'P'
		call	sub_13AF2
		pop	si
		pop	cx
		pop	ax
		retn
sub_13ABC	endp


; =============== S U B	R O U T	I N E =======================================


sub_13AF2	proc near		; CODE XREF: sub_13ABC+8p
					; sub_13ABC+18p ...
		push	ax
		push	cx
		push	si

loc_13AF5:				; CODE XREF: sub_13AF2+Cj
		mov	al, [si]
		mov	es:[di], al
		add	si, dx
		inc	di
		dec	cx
		jnz	short loc_13AF5
		pop	si
		pop	cx
		pop	ax
		retn
sub_13AF2	endp

; ---------------------------------------------------------------------------
		enter	0, 0
		push	si
		push	di
		push	ds
		mov	ax, [bp+8]
		mov	bx, [bp+0Ch]
		mov	cx, [bp+6]
		mov	dx, [bp+0Ah]
		cmp	ax, bx
		jnb	short loc_13B1F
		nop
		nop
		nop
		xchg	ax, bx

loc_13B1F:				; CODE XREF: seg001:0C69j
		cmp	cx, dx
		jnb	short loc_13B28
		nop
		nop
		nop
		xchg	cx, dx

loc_13B28:				; CODE XREF: seg001:0C71j
		shr	cx, 3
		shr	dx, 3
		sub	ax, bx
		inc	ax
		sub	cx, dx
		inc	cx
		shl	bx, 4
		mov	di, bx
		shl	bx, 2
		add	di, bx
		add	di, dx
		mov	si, 8Ch
		mov	bx, 0A800h
		call	sub_13B60
		mov	bx, 0B000h
		call	sub_13B60
		mov	bx, 0B800h
		call	sub_13B60
		mov	bx, 0E000h
		call	sub_13B60
		pop	ds
		pop	di
		pop	si
		leave
		retf

; =============== S U B	R O U T	I N E =======================================


sub_13B60	proc near		; CODE XREF: seg001:0C96p seg001:0C9Cp ...
		push	ax
		push	cx
		push	di
		mov	es, bx
		assume es:nothing
		mov	dx, 1
		call	sub_13B96
		push	ax
		push	di
		mov	bx, 50h
		dec	ax
		mul	bx
		add	di, ax
		mov	dx, 1
		call	sub_13B96
		pop	di
		pop	ax
		push	cx
		mov	dx, 50h
		mov	cx, ax
		call	sub_13B96
		pop	cx
		add	di, cx
		dec	di
		mov	cx, ax
		mov	dx, 50h
		call	sub_13B96
		pop	di
		pop	cx
		pop	ax
		retn
sub_13B60	endp


; =============== S U B	R O U T	I N E =======================================


sub_13B96	proc near		; CODE XREF: sub_13B60+8p
					; sub_13B60+18p ...
		push	ax
		push	cx
		push	di

loc_13B99:				; CODE XREF: sub_13B96+Cj
		mov	al, [si]
		mov	es:[di], al
		inc	si
		add	di, dx
		dec	cx
		jnz	short loc_13B99
		pop	di
		pop	cx
		pop	ax
		retn
sub_13B96	endp

; ---------------------------------------------------------------------------
		enter	0, 0
		pushf
		cli
		mov	al, 0C0h
		out	7Ch, al
		mov	dx, 0
		mov	es, dx
		assume es:nothing
		mov	es:495h, al
		popf
		mov	cx, [bp+6]
		and	cx, 0Fh
		mov	ax, 0FFFFh
		shr	ax, cl
		mov	cs:word_13C02, ax
		mov	cx, [bp+0Ah]
		and	cx, 0Fh
		sub	cx, 10h
		neg	cx
		mov	ax, 0FFFFh
		shl	ax, cl
		mov	cs:word_13C04, ax
		mov	bx, [bp+6]
		mov	dx, [bp+0Ah]
		shr	bx, 4
		mov	di, bx
		shr	dx, 4
		sub	dx, di
		dec	dx
		mov	cs:word_13C06, dx
		mov	bx, cs:word_13C02
		mov	dx, cs:word_13C04
		mov	ax, 0FFFFh
; ---------------------------------------------------------------------------
word_13C02	dw 0			; DATA XREF: seg001:0D17w seg001:0D45r
word_13C04	dw 0			; DATA XREF: seg001:0D2Bw seg001:0D4Ar
word_13C06	dw 0			; DATA XREF: seg001:0D40w
; ---------------------------------------------------------------------------
		enter	0, 0
		push	si
		push	di
		pushf
		cli
		mov	al, 0C0h
		out	7Ch, al
		mov	bx, [bp+0Eh]
		mov	bh, 1

loc_13C19:				; CODE XREF: seg001:0D7Bj
		mov	al, 0FFh
		test	bl, bh
		jnz	short loc_13C24
		nop
		nop
		nop
		mov	al, 0

loc_13C24:				; CODE XREF: seg001:0D6Dj
		out	7Eh, al
		shl	bh, 1
		cmp	bh, 10h
		jnz	short loc_13C19
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		mov	ax, [bp+8]
		shl	ax, 4
		mov	di, ax
		shl	ax, 2
		add	di, ax
		mov	ax, [bp+6]
		mov	cl, al
		shr	ax, 3
		add	di, ax
		mov	dx, 0FFFFh
		and	cl, 7
		shr	dh, cl
		mov	bx, [bp+0Ah]
		mov	cl, bl
		and	cl, 7
		inc	cl
		shr	dl, cl
		xor	dl, 0FFh
		shr	bx, 3
		sub	bx, ax
		mov	ax, [bp+8]
		mov	cx, [bp+0Ch]
		sub	cx, ax
		inc	cx
		and	bx, bx
		jz	short loc_13C9E
		nop
		nop
		nop

loc_13C75:				; CODE XREF: seg001:0DE3j
		push	bx
		push	cx
		push	di
		mov	es:[di], dh
		inc	di

loc_13C7C:				; CODE XREF: seg001:0DD7j
		dec	bx
		jz	short loc_13C89
		nop
		nop
		nop
		mov	byte ptr es:[di], 0FFh
		inc	di
		jmp	short loc_13C7C
; ---------------------------------------------------------------------------

loc_13C89:				; CODE XREF: seg001:0DCDj
		mov	es:[di], dl
		pop	di
		pop	cx
		pop	bx
		add	di, 50h
		dec	cx
		jnz	short loc_13C75
		xor	al, al
		out	7Ch, al
		popf
		pop	di
		pop	si
		leave
		retf
; ---------------------------------------------------------------------------

loc_13C9E:				; CODE XREF: seg001:0DC0j
		and	dh, dl

loc_13CA0:				; CODE XREF: seg001:0DF7j
		mov	es:[di], dh
		add	di, 50h
		dec	cx
		jnz	short loc_13CA0
		xor	al, al
		out	7Ch, al
		popf
		pop	di
		pop	si
		leave
		retf
; ---------------------------------------------------------------------------
		enter	0, 0
		push	di
		push	si
		mov	ax, [bp+6]
		shl	ax, 4
		mov	si, offset byte_17424
		add	si, ax
		mov	dx, [bp+0Ah]
		mov	ax, [bp+8]
		shl	dx, 4
		mov	di, dx
		shl	dx, 2
		add	di, dx
		mov	cl, al
		and	cl, 7
		shr	ax, 3
		add	di, ax
		mov	ax, 0E000h
		mov	es, ax
		assume es:nothing
		mov	ch, 10h

loc_13CE4:				; CODE XREF: seg001:0E45j
		mov	ah, [si]
		inc	si
		xor	al, al
		shr	ax, cl
		xchg	ah, al
		or	es:[di], ax
		add	di, 50h
		dec	ch
		jnz	short loc_13CE4
		pop	si
		pop	di
		leave
		retf
; ---------------------------------------------------------------------------
		enter	0, 0
		push	di
		push	si
		mov	ax, [bp+6]
		shl	ax, 4
		mov	si, offset byte_17424
		add	si, ax
		mov	dx, [bp+0Ah]
		mov	ax, [bp+8]
		shl	dx, 4
		mov	di, dx
		shl	dx, 2
		add	di, dx
		mov	cl, al
		and	cl, 7
		shr	ax, 3
		add	di, ax
		mov	ax, 0E000h
		mov	es, ax
		mov	ch, 10h

loc_13D2D:				; CODE XREF: seg001:0E93j
		mov	ah, [si]
		inc	si
		xor	al, al
		shr	ax, cl
		xchg	ah, al
		or	es:[di], ax
		or	es:[di+50h], ax
		add	di, 0A0h
		dec	ch
		jnz	short loc_13D2D
		pop	si
		pop	di
		leave
		retf

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_13D49	proc far		; CODE XREF: sub_1548E+3CP
					; sub_1548E+67P ...

arg_0		= word ptr  6
arg_2		= word ptr  8
arg_4		= word ptr  0Ah
arg_6		= word ptr  0Ch

		enter	0, 0
		push	di
		push	si
		mov	ax, [bp+arg_0]
		shl	ax, 4
		mov	si, offset byte_17424
		add	si, ax
		mov	dx, [bp+arg_4]
		mov	ax, [bp+arg_2]
		shl	dx, 4
		mov	di, dx
		shl	dx, 2
		add	di, dx
		mov	cl, al
		and	cl, 7
		shr	ax, 3
		add	di, ax
		mov	al, 0C0h
		out	7Ch, al
		mov	bx, [bp+arg_6]
		mov	bh, 1

loc_13D7D:				; CODE XREF: sub_13D49+46j
		mov	al, 0FFh
		test	bl, bh
		jnz	short loc_13D88
		nop
		nop
		nop
		mov	al, 0

loc_13D88:				; CODE XREF: sub_13D49+38j
		out	7Eh, al
		shl	bh, 1
		cmp	bh, 10h
		jnz	short loc_13D7D
		mov	ax, 0E000h
		mov	es, ax
		mov	ch, 10h

loc_13D98:				; CODE XREF: sub_13D49+65j
		mov	ah, [si]
		inc	si
		xor	al, al
		shr	ax, cl
		xchg	ah, al
		mov	es:[di], ax
		mov	es:[di+50h], ax
		add	di, 0A0h
		dec	ch
		jnz	short loc_13D98
		xor	al, al
		out	7Ch, al
		pop	si
		pop	di
		leave
		retf
sub_13D49	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_13DB8	proc far		; CODE XREF: sub_1566E+64CP

arg_0		= word ptr  6
arg_2		= word ptr  8

		enter	0, 0
		push	si
		push	di
		pushf
		mov	si, offset word_1741C
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	ax, [bx+si]
		mov	es, ax
		assume es:nothing
		mov	ax, [bp+arg_2]
		mov	cx, 3E80h
		xor	di, di
		cld
		rep stosw
		popf
		pop	di
		pop	si
		leave
		retf
sub_13DB8	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_13DDB	proc far		; CODE XREF: sub_1566E+44CP
					; sub_1566E+5BBP

arg_0		= word ptr  6
arg_2		= word ptr  8
arg_4		= word ptr  0Ah
arg_6		= word ptr  0Ch
arg_8		= word ptr  0Eh

		enter	0, 0
		push	si
		push	di
		pushf
		cli
		mov	si, offset word_1741C
		mov	bx, [bp+arg_8]
		add	bx, bx
		mov	ax, [bx+si]
		mov	es, ax
		mov	ax, [bp+arg_2]
		shl	ax, 4
		mov	di, ax
		shl	ax, 2
		add	di, ax
		mov	ax, [bp+arg_0]
		mov	cl, al

loc_13E01:
		shr	ax, 3
		add	di, ax
		mov	dx, 0FFFFh
		and	cl, 7
		shr	dh, cl
		mov	bx, [bp+arg_4]
		mov	cl, bl
		and	cl, 7
		inc	cl
		shr	dl, cl
		xor	dl, 0FFh
		xor	dx, 0FFFFh
		shr	bx, 3
		sub	bx, ax
		mov	ax, [bp+arg_2]
		mov	cx, [bp+arg_6]
		sub	cx, ax
		inc	cx
		and	bx, bx
		jz	short loc_13E5C
		nop
		nop
		nop

loc_13E35:				; CODE XREF: sub_13DDB+7Aj
		push	bx
		push	cx
		push	di
		mov	byte ptr es:[di], 0
		inc	di

loc_13E3D:				; CODE XREF: sub_13DDB+6Dj
		dec	bx
		jz	short loc_13E4A
		nop
		nop
		nop
		mov	byte ptr es:[di], 0
		inc	di
		jmp	short loc_13E3D
; ---------------------------------------------------------------------------

loc_13E4A:				; CODE XREF: sub_13DDB+63j
		mov	byte ptr es:[di], 0
		pop	di
		pop	cx
		pop	bx
		add	di, 50h	; 'P'
		dec	cx
		jnz	short loc_13E35
		popf
		pop	di
		pop	si
		leave
		retf
; ---------------------------------------------------------------------------

loc_13E5C:				; CODE XREF: sub_13DDB+55j
		and	dh, dl

loc_13E5E:				; CODE XREF: sub_13DDB+8Bj
		mov	byte ptr es:[di], 0
		add	di, 50h	; 'P'
		dec	cx
		jnz	short loc_13E5E
		popf
		pop	di
		pop	si
		leave
		retf
sub_13DDB	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_13E6D	proc far		; CODE XREF: sub_1566E+430P
					; sub_1566E+59BP

arg_0		= dword	ptr  6
arg_4		= word ptr  0Ah
arg_6		= word ptr  0Ch
arg_8		= word ptr  0Eh
arg_A		= word ptr  10h

		enter	0, 0
		push	ds
		push	si
		push	di
		mov	ax, [bp+arg_6]
		shl	ax, 4
		mov	si, ax
		shl	ax, 2
		add	si, ax
		mov	ax, [bp+arg_4]
		shr	ax, 3
		add	si, ax
		les	di, [bp+arg_0]
		mov	ax, 0E000h
		mov	dx, [bp+arg_A]
		mov	ds, ax
		assume ds:nothing
		mov	cx, [bp+arg_8]
		dec	cx
		shr	cx, 3
		inc	cx

loc_13E9C:				; CODE XREF: sub_13E6D+39j
		push	si
		push	cx
		rep movsb
		pop	cx
		pop	si
		add	si, 50h
		dec	dx
		jnz	short loc_13E9C
		pop	di
		pop	si
		pop	ds
		assume ds:dseg
		leave
		retf
sub_13E6D	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_13EAD	proc far		; CODE XREF: sub_1566E+48BP

arg_0		= dword	ptr  6
arg_4		= word ptr  0Ah
arg_6		= word ptr  0Ch
arg_8		= word ptr  0Eh
arg_A		= word ptr  10h

		enter	0, 0
		push	si
		push	di
		push	ds
		mov	ax, 0E000h
		mov	es, ax
		assume es:nothing
		lds	si, [bp+arg_0]
		mov	ax, [bp+arg_6]
		shl	ax, 4
		mov	di, ax
		shl	ax, 2
		add	di, ax
		mov	ax, [bp+arg_4]
		mov	cx, ax
		and	cx, 7
		shr	ax, 3
		add	di, ax
		mov	dx, [bp+arg_A]
		mov	bx, [bp+arg_8]
		dec	bx
		shr	bx, 3
		inc	bx

loc_13EE1:				; CODE XREF: sub_13EAD+57j
		push	di
		push	bx
		xor	al, al

loc_13EE5:				; CODE XREF: sub_13EAD+46j
		mov	ah, al
		mov	al, [si]
		push	ax
		shr	ax, cl
		mov	es:[di], al
		pop	ax
		inc	si
		inc	di
		dec	bx
		jnz	short loc_13EE5
		mov	ah, al
		xor	al, al
		shr	ax, cl
		mov	es:[di], al
		pop	bx
		pop	di
		add	di, 50h
		dec	dx
		jnz	short loc_13EE1
		pop	ds
		pop	di
		pop	si
		leave
		retf
sub_13EAD	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_13F0B	proc far		; CODE XREF: sub_1566E+298P

arg_0		= word ptr  6
arg_2		= word ptr  8
arg_4		= word ptr  0Ah

		enter	0, 0
		push	si
		push	di
		push	ds
		mov	si, offset word_1741C
		mov	bx, [bp+arg_4]
		add	bx, bx
		mov	ax, [bx+si]
		mov	ds, ax
		mov	es, ax
		assume es:nothing
		mov	cx, [bp+arg_2]
		shr	cx, 4
		shl	cx, 1
		mov	di, [bp+arg_0]
		shr	di, 4
		shl	di, 1
		sub	cx, di
		shr	cx, 1
		mov	si, di
		add	si, 50h
		mov	dx, 18Fh

loc_13F3C:				; CODE XREF: sub_13F0B+40j
		push	cx
		push	di
		push	si
		rep movsw
		pop	si
		pop	di
		pop	cx
		add	si, 50h
		add	di, 50h
		dec	dx
		jnz	short loc_13F3C
		pop	ds
		pop	di
		pop	si
		leave
		retf
sub_13F0B	endp

; ---------------------------------------------------------------------------
		enter	0, 0
		push	si
		push	di
		push	ds
		pushf
		mov	bx, [bp+6]
		add	bx, bx
		mov	si, offset word_1741C
		mov	ax, [bx+si]
		mov	es, ax
		mov	ds, ax
		mov	si, 50h
		xor	di, di
		mov	cx, 3E58h
		cld
		rep movsw
		popf
		pop	ds
		pop	di
		pop	si
		leave
		retf
; ---------------------------------------------------------------------------
		enter	0, 0
		push	si
		push	di
		push	ds
		mov	ax, [bp+8]
		shl	ax, 4
		mov	si, ax
		shl	ax, 2
		add	si, ax
		mov	ax, [bp+6]
		shr	ax, 3
		add	si, ax
		mov	ax, [bp+10h]
		shl	ax, 4
		mov	di, ax
		shl	ax, 2
		add	di, ax
		mov	ax, [bp+0Eh]
		shr	ax, 3
		add	di, ax
		mov	cs:word_14041, si
		mov	cs:word_14043, di
		shr	word ptr [bp+0Ah], 3

loc_13FB8:				; CODE XREF: seg001:1189j
		mov	di, 8Ch
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	ax, ds
		mov	es, ax
		assume es:dseg
		mov	ax, 0A800h
		mov	ds, ax
		assume ds:nothing
		mov	cx, [bp+0Ah]
		mov	si, cs:word_14041
		rep movsb
		mov	ax, 0B000h
		mov	ds, ax
		assume ds:nothing
		mov	cx, [bp+0Ah]
		mov	si, cs:word_14041
		rep movsb
		mov	ax, 0B800h
		mov	ds, ax
		assume ds:nothing
		mov	cx, [bp+0Ah]
		mov	si, cs:word_14041
		rep movsb
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	ax, es
		mov	ds, ax
		assume ds:dseg
		mov	si, 8Ch
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		mov	di, cs:word_14043
		mov	cx, [bp+0Ah]
		rep movsb
		mov	ax, 0B000h
		mov	es, ax
		assume es:nothing
		mov	di, cs:word_14043
		mov	cx, [bp+0Ah]
		rep movsb
		mov	ax, 0B800h
		mov	es, ax
		assume es:nothing
		mov	di, cs:word_14043
		mov	cx, [bp+0Ah]
		rep movsb
		add	cs:word_14041, 50h
		add	cs:word_14043, 50h
		dec	word ptr [bp+0Ch]
		jz	short loc_1403C
		jmp	loc_13FB8
; ---------------------------------------------------------------------------

loc_1403C:				; CODE XREF: seg001:1187j
		pop	ds
		pop	di
		pop	si
		leave
		retf
; ---------------------------------------------------------------------------
word_14041	dw 0			; DATA XREF: seg001:10FAw seg001:111Br ...
word_14043	dw 0			; DATA XREF: seg001:10FFw seg001:1150r ...
byte_14045	db 30h dup(0)		; DATA XREF: seg001:122Ao seg001:1257o
byte_14075	db 30h dup(0)		; DATA XREF: seg001:122Do sub_141A3+Eo ...
word_140A5	dw 0			; DATA XREF: seg001:120Aw seg001:1213r ...
word_140A7	dw 0			; DATA XREF: seg001:1290w sub_14197r ...
		dw 0
word_140AB	dw 0			; DATA XREF: SetupInt0A+Cw
					; RestoreInt0A+10r
word_140AD	dw 0			; DATA XREF: SetupInt0A+7w
					; RestoreInt0A+Cr
word_140AF	dw 0Ah			; DATA XREF: seg001:120Fr
					; sub_141A3+19w ...
		align 2

Int0A:					; DATA XREF: SetupInt0A+15o
		push	ax
		push	bx
		push	cx
		push	dx
		push	ds
		push	es
		push	si
		push	di
		inc	cs:word_140A5
		mov	ax, cs:word_140AF
		mov	bx, cs:word_140A5
		cmp	bx, ax
		jb	short loc_1413A
		nop
		nop
		nop
		xor	dx, dx
		mov	cx, 30h
		mov	ax, cs
		mov	ds, ax
		assume ds:seg001
		mov	es, ax
		assume es:seg001
		mov	si, offset byte_14045
		mov	di, offset byte_14075

loc_140E0:				; CODE XREF: seg001:1250j
		mov	bh, [si]
		mov	bl, [di]
		cmp	bh, bl
		jz	short loc_140FD
		nop
		nop
		nop
		jb	short loc_140F8
		nop
		nop
		nop
		dec	byte ptr [si]
		or	dx, 1
		jmp	short loc_140FD
; ---------------------------------------------------------------------------
		align 2

loc_140F8:				; CODE XREF: seg001:123Bj
		inc	byte ptr [si]
		or	dx, 1

loc_140FD:				; CODE XREF: seg001:1236j seg001:1245j
		inc	si
		inc	di
		dec	cx
		jnz	short loc_140E0
		mov	cx, 10h
		mov	ah, 0
		mov	si, offset byte_14045

loc_1410A:				; CODE XREF: seg001:127Aj
		mov	al, ah
		out	0A8h, al	; Interrupt Controller #2, 8259A
		jmp	short $+2
		jmp	short $+2
		lodsb
		out	0ACh, al	; Interrupt Controller #2, 8259A
		jmp	short $+2
		jmp	short $+2
		lodsb
		out	0AAh, al	; Interrupt Controller #2, 8259A
		jmp	short $+2
		jmp	short $+2
		lodsb
		out	0AEh, al	; Interrupt Controller #2, 8259A
		jmp	short $+2
		jmp	short $+2
		inc	ah
		dec	cx
		jnz	short loc_1410A
		mov	cs:word_140A5, 0
		and	dx, dx
		jz	short loc_1413A
		nop
		nop
		nop

loc_1413A:				; CODE XREF: seg001:121Aj seg001:1285j
		out	64h, al		; 8042 keyboard	controller command register.
		mov	al, 20h
		out	0, al
		inc	cs:word_140A7
		pop	di
		pop	si
		pop	es
		assume es:nothing
		pop	ds
		assume ds:dseg
		pop	dx
		pop	cx
		pop	bx
		pop	ax
		iret

; =============== S U B	R O U T	I N E =======================================


SetupInt0A	proc far		; CODE XREF: sub_1566E+59P
		pushf
		cli
		mov	ax, 350Ah
		int	21h		; DOS -	2+ - GET INTERRUPT VECTOR
					; AL = interrupt number
					; Return: ES:BX	= value	of interrupt vector
		mov	cs:word_140AD, bx
		mov	cs:word_140AB, es
		xor	ax, ax
		mov	es, ax
		assume es:nothing
		mov	ax, offset Int0A
		mov	es:28h,	ax
		mov	word ptr es:2Ah, cs
		in	al, 2		; DMA controller, 8237A-5.
					; channel 1 current address
		and	al, 0FBh
		out	2, al		; DMA controller, 8237A-5.
					; channel 1 base address
					; (also	sets current address)
		popf
		retf
SetupInt0A	endp


; =============== S U B	R O U T	I N E =======================================


RestoreInt0A	proc far		; CODE XREF: sub_1566E+ADBP
					; sub_1566E:loc_16180P
		pushf
		cli
		in	al, 2		; DMA controller, 8237A-5.
					; channel 1 current address
		or	al, 4
		out	2, al		; DMA controller, 8237A-5.
					; channel 1 base address
					; (also	sets current address)
		xor	ax, ax
		mov	es, ax
		mov	ax, cs:word_140AD
		mov	bx, cs:word_140AB
		mov	es:28h,	ax
		mov	es:2Ah,	bx
		popf
		retf
RestoreInt0A	endp


; =============== S U B	R O U T	I N E =======================================


sub_14197	proc far		; CODE XREF: sub_1566E+25EP
					; sub_1566E:loc_158D3P	...
		mov	ax, cs:word_140A7
		mov	cs:word_140A7, 0
		retf
sub_14197	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_141A3	proc far		; CODE XREF: sub_1566E+207P
					; sub_1566E+614P ...

arg_0		= dword	ptr  6
arg_4		= word ptr  0Ah

		enter	0, 0
		push	si
		push	di
		push	ds
		lds	si, [bp+arg_0]
		mov	ax, cs
		mov	es, ax
		assume es:seg001
		mov	di, offset byte_14075
		mov	cx, 30h
		rep movsb
		mov	ax, [bp+arg_4]
		mov	cs:word_140AF, ax
		pop	ds
		pop	di
		pop	si
		leave
		retf
sub_141A3	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_141C5	proc far		; CODE XREF: sub_161D5+148P

arg_0		= dword	ptr  6
arg_4		= word ptr  0Ah

		enter	0, 0
		push	si
		push	di
		push	ds
		lds	si, [bp+arg_0]
		mov	ax, cs
		mov	es, ax
		mov	di, offset byte_14075
		mov	cx, 10h

loc_141D9:				; CODE XREF: sub_141C5+33j
		lodsw
		mov	bl, ah
		and	bl, 0Fh
		mov	ah, al
		and	al, 0Fh
		shr	ah, 4
		and	ah, 0Fh
		mov	es:[di], ah
		mov	es:[di+1], bl
		mov	es:[di+2], al
		add	di, 3
		dec	cx
		jnz	short loc_141D9
		mov	ax, [bp+arg_4]
		mov	cs:word_140AF, ax
		pop	ds
		pop	di
		pop	si
		leave
		retf
sub_141C5	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_14206	proc far		; CODE XREF: sub_1566E+4ECP
					; sub_1566E+50CP ...

arg_0		= word ptr  6
arg_2		= word ptr  8
arg_4		= word ptr  0Ah
arg_6		= word ptr  0Ch
arg_8		= dword	ptr  0Eh
arg_C		= word ptr  12h

		enter	0, 0
		push	si
		push	di
		push	ds
		les	di, [bp+arg_8]
		assume es:nothing
		mov	cx, [bp+arg_4]
		shr	cx, 4
		mov	si, offset word_1741C
		mov	bx, [bp+arg_C]
		add	bx, bx
		mov	ax, [bx+si]
		mov	ds, ax
		mov	ax, [bp+arg_2]
		shl	ax, 4
		mov	si, ax
		shl	ax, 2
		add	si, ax
		mov	ax, [bp+arg_0]
		shr	ax, 3
		add	si, ax

loc_14237:				; CODE XREF: sub_14206+3Dj
		push	cx
		push	si
		rep movsw
		pop	si
		pop	cx
		add	si, 50h
		dec	[bp+arg_6]
		jnz	short loc_14237
		pop	ds
		pop	di
		pop	si
		leave
		retf
sub_14206	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1424A	proc far		; CODE XREF: sub_1566E+930P

arg_0		= word ptr  6
arg_2		= word ptr  8
arg_4		= word ptr  0Ah
arg_6		= word ptr  0Ch
arg_8		= dword	ptr  0Eh
arg_C		= word ptr  12h

		enter	0, 0
		push	si
		push	di
		push	ds
		mov	cx, [bp+arg_4]
		shr	cx, 4
		mov	di, offset word_1741C
		mov	bx, [bp+arg_C]
		add	bx, bx
		mov	ax, [bx+di]
		mov	es, ax
		lds	si, [bp+arg_8]
		mov	ax, [bp+arg_2]
		shl	ax, 4
		mov	di, ax
		shl	ax, 2
		add	di, ax
		mov	ax, [bp+arg_0]
		shr	ax, 3
		add	di, ax

loc_1427B:				; CODE XREF: sub_1424A+3Dj
		push	cx
		push	di
		rep movsw
		pop	di
		pop	cx
		add	di, 50h
		dec	[bp+arg_6]
		jnz	short loc_1427B
		pop	ds
		pop	di
		pop	si
		leave
		retf
sub_1424A	endp

; ---------------------------------------------------------------------------
		enter	0, 0
		push	si
		push	di
		push	ds
		les	di, [bp+0Eh]
		mov	cx, [bp+0Ah]
		shr	cx, 3
		mov	si, offset word_1741C
		mov	bx, [bp+12h]
		add	bx, bx
		mov	ax, [bx+si]
		mov	ds, ax
		mov	ax, [bp+8]
		shl	ax, 4
		mov	si, ax
		shl	ax, 2
		add	si, ax
		mov	ax, [bp+6]
		shr	ax, 3
		add	si, ax

loc_142BF:				; CODE XREF: seg001:141Bj
		push	cx
		push	si
		rep movsb
		pop	si
		pop	cx
		add	si, 50h
		dec	word ptr [bp+0Ch]
		jnz	short loc_142BF
		pop	ds
		pop	di
		pop	si
		leave
		retf

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_142D2	proc far		; CODE XREF: sub_1566E+35DP
					; sub_1566E+380P ...

arg_0		= word ptr  6
arg_2		= word ptr  8
arg_4		= word ptr  0Ah
arg_6		= word ptr  0Ch
arg_8		= dword	ptr  0Eh
arg_C		= word ptr  12h
arg_E		= word ptr  14h

		enter	0, 0
		push	si
		push	di
		push	ds
		mov	ax, [bp+arg_2]
		shl	ax, 4
		mov	di, ax
		shl	ax, 2
		add	di, ax
		mov	ax, [bp+arg_0]
		shr	ax, 3
		add	di, ax
		mov	bx, [bp+arg_C]
		add	bx, bx
		mov	si, offset word_1741C
		mov	ax, [bx+si]
		mov	es, ax
		lds	si, [bp+arg_8]
		shr	[bp+arg_4], 3
		shr	[bp+arg_6], 3
		mov	ax, [bp+arg_4]
		shl	ax, 3
		mov	cs:word_1435D, ax
		mov	bx, [bp+arg_E]
		mov	bh, bl
		shr	bh, 3
		and	bl, 7
		mov	ax, 50h
		mul	bh
		add	di, ax
		mov	ax, [bp+arg_4]
		mul	bh
		add	si, ax
		mov	dx, 101h
		mov	cl, bl
		shl	dx, cl
		xor	dh, 0FFh

loc_14332:				; CODE XREF: sub_142D2+84j
		push	cx
		push	di
		push	si
		mov	cx, [bp+arg_4]

loc_14338:				; CODE XREF: sub_142D2+73j
		mov	al, [si]
		and	al, dl
		and	es:[di], dh
		or	es:[di], al
		inc	di
		inc	si
		dec	cx
		jnz	short loc_14338
		pop	si
		pop	di
		pop	cx
		add	di, 280h
		add	si, cs:word_1435D
		dec	[bp+arg_6]
		jnz	short loc_14332
		pop	ds
		pop	di
		pop	si
		leave
		retf
sub_142D2	endp

; ---------------------------------------------------------------------------
word_1435D	dw 0			; DATA XREF: sub_142D2+39w
					; sub_142D2+7Cr

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1435F	proc far		; CODE XREF: sub_1566E+2ECP
					; sub_1566E+307P ...

arg_0		= word ptr  6
arg_2		= word ptr  8
arg_4		= word ptr  0Ah
arg_6		= word ptr  0Ch
arg_8		= word ptr  0Eh
arg_A		= word ptr  10h

		enter	0, 0
		push	di
		push	ds
		mov	bx, [bp+arg_8]
		add	bx, bx
		mov	di, offset word_1741C
		mov	ax, [bx+di]
		mov	es, ax
		mov	ax, [bp+arg_2]
		shl	ax, 4
		mov	di, ax
		shl	ax, 2
		add	di, ax
		mov	ax, [bp+arg_0]
		shr	ax, 3
		add	di, ax
		shr	[bp+arg_4], 3
		shr	[bp+arg_6], 3
		mov	cx, [bp+arg_A]
		mov	ch, cl
		shr	ch, 3
		and	cl, 7
		mov	ax, 50h	; 'P'
		mul	ch
		add	di, ax
		mov	dh, 0FEh ; 'þ'
		rol	dh, cl

loc_143A4:				; CODE XREF: sub_1435F+58j
		push	di
		mov	cx, [bp+arg_4]

loc_143A8:				; CODE XREF: sub_1435F+4Ej
		and	es:[di], dh
		inc	di
		dec	cx
		jnz	short loc_143A8
		pop	di
		add	di, 280h
		dec	[bp+arg_6]
		jnz	short loc_143A4
		pop	ds
		pop	di
		leave
		retf
sub_1435F	endp


; =============== S U B	R O U T	I N E =======================================


sub_143BD	proc near		; CODE XREF: sub_143D0+4Ap
					; sub_143D0+54p ...
		push	si
		push	dx
		mov	ds, ax

loc_143C1:				; CODE XREF: sub_143BD+Ej
		push	si
		push	cx
		rep movsb
		pop	cx
		pop	si
		add	si, 50h	; 'P'
		dec	dx
		jnz	short loc_143C1
		pop	dx
		pop	si
		retn
sub_143BD	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_143D0	proc far		; CODE XREF: sub_1566E+814P
					; sub_161D5+D6P ...

arg_0		= dword	ptr  6
arg_4		= word ptr  0Ah
arg_6		= word ptr  0Ch
arg_8		= word ptr  0Eh
arg_A		= word ptr  10h
arg_C		= word ptr  12h

		enter	0, 0
		push	si
		push	di
		push	ds
		les	di, [bp+arg_0]
		mov	ax, [bp+arg_6]
		shl	ax, 4
		mov	si, ax
		shl	ax, 2
		add	si, ax
		mov	ax, [bp+arg_4]
		shr	ax, 3
		add	si, ax
		mov	al, 80h	; '€'
		out	7Ch, al
		mov	bx, [bp+arg_C]
		mov	bh, 1

loc_143F8:				; CODE XREF: sub_143D0+3Aj
		mov	al, 0FFh
		test	bl, bh
		jnz	short loc_14403
		nop
		nop
		nop
		mov	al, 0

loc_14403:				; CODE XREF: sub_143D0+2Cj
		out	7Eh, al
		shl	bh, 1
		cmp	bh, 10h
		jnz	short loc_143F8
		mov	cx, [bp+arg_8]
		mov	dx, [bp+arg_A]
		dec	cx
		shr	cx, 3
		inc	cx
		mov	ax, 0A800h
		call	sub_143BD
		xor	al, al
		out	7Ch, al
		mov	ax, 0A800h
		call	sub_143BD
		mov	ax, 0B000h
		call	sub_143BD
		mov	ax, 0B800h
		call	sub_143BD
		mov	ax, 0E000h
		call	sub_143BD
		pop	ds
		pop	di
		pop	si
		leave
		retf
sub_143D0	endp


; =============== S U B	R O U T	I N E =======================================


sub_1443E	proc near		; CODE XREF: sub_14490+41p
					; sub_14490+47p ...
		mov	es, ax
		push	di
		push	bx
		push	dx

loc_14443:				; CODE XREF: sub_1443E+4Cj
		push	di
		push	cx
		push	dx
		xor	al, al
		mov	dl, 0FFh

loc_1444A:				; CODE XREF: sub_1443E+2Cj
		mov	ah, al
		mov	dh, dl
		mov	al, [si]
		mov	dl, [bx]
		push	ax
		push	dx
		shr	ax, cl
		shr	dx, cl
		and	es:[di], dl
		xor	dl, 0FFh
		and	al, dl
		or	es:[di], al
		pop	dx
		pop	ax
		inc	si
		inc	di
		inc	bx
		dec	ch
		jnz	short loc_1444A
		mov	ah, al
		mov	dh, dl
		xor	al, al
		mov	dl, 0FFh
		shr	ax, cl
		shr	dx, cl
		and	es:[di], dl
		xor	dl, 0FFh
		and	al, dl
		or	es:[di], al
		pop	dx
		pop	cx
		pop	di
		add	di, 50h	; 'P'
		dec	dx
		jnz	short loc_14443
		pop	dx
		pop	bx
		pop	di
		retn
sub_1443E	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_14490	proc far		; CODE XREF: sub_1566E+95BP
					; sub_161D5+1C1P ...

arg_0		= dword	ptr  6
arg_4		= word ptr  0Ah
arg_6		= word ptr  0Ch
arg_8		= word ptr  0Eh
arg_A		= word ptr  10h

		enter	0, 0
		push	si
		push	di
		push	ds
		lds	bx, [bp+arg_0]
		mov	ax, [bp+arg_6]
		shl	ax, 4
		mov	di, ax
		shl	ax, 2
		add	di, ax
		mov	ax, [bp+arg_4]
		shr	ax, 3
		add	di, ax
		mov	ax, [bp+arg_8]
		dec	ax
		shr	ax, 3
		inc	ax
		mov	cx, ax
		mov	dx, [bp+arg_A]
		mul	dx
		mov	si, bx
		add	si, ax
		mov	ax, [bp+arg_4]
		mov	ch, cl
		and	al, 7
		mov	cl, al
		mov	dx, [bp+arg_A]
		mov	ax, 0A800h
		call	sub_1443E
		mov	ax, 0B000h
		call	sub_1443E
		mov	ax, 0B800h
		call	sub_1443E
		mov	ax, 0E000h
		call	sub_1443E
		pop	ds
		pop	di
		pop	si
		leave
		retf
sub_14490	endp

; ---------------------------------------------------------------------------
		align 2
		enter	0, 0
		push	ds
		mov	cl, 13h
		lds	dx, [bp+6]
		int	0DCh		; used by BASIC	while in interpreter
		pop	ds
		leave
		retf
; ---------------------------------------------------------------------------
		mov	ah, 0Ch
		xor	al, al

loc_144FF:				; DOS -	CLEAR KEYBOARD BUFFER
		int	21h		; AL must be 01h, 06h, 07h, 08h, or 0Ah.
		retf
seg001		ends

; ---------------------------------------------------------------------------
; ===========================================================================

; Segment type:	Pure code
seg002		segment	byte public 'CODE' use16
		assume cs:seg002
		;org 2
		assume es:nothing, ss:nothing, ds:dseg,	fs:nothing, gs:nothing
		mov	ah, 40h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		retf
; ---------------------------------------------------------------------------
		mov	ah, 41h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		retf

; =============== S U B	R O U T	I N E =======================================


sub_1450C	proc far		; CODE XREF: sub_1566E+3BP
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
		retf
sub_1450C	endp

; ---------------------------------------------------------------------------
		enter	0, 0
		push	si
		mov	al, [bp+10h]
		mov	bx, 1F94h
		and	al, 7
		mov	[bx], al
		mov	byte ptr [bx+2], 0
		mov	ax, [bp+6]

loc_14531:
		mov	[bx+8],	ax
		mov	dx, [bp+8]
		mov	[bx+0Ah], dx
		mov	ax, [bp+0Ah]
		mov	[bx+16h], ax
		mov	dx, [bp+0Ch]
		mov	[bx+18h], dx
		mov	dx, [bp+0Eh]
		mov	[bx+20h], dx
		mov	byte ptr [bx+28h], 1
		mov	ah, 47h	; 'G'
		mov	ch, 0B0h ; '°'
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		pop	si
		leave
		retf
; ---------------------------------------------------------------------------
		enter	0, 0
		push	si
		mov	al, [bp+0Eh]
		mov	si, 1F94h
		and	al, 7
		mov	[si], al
		mov	ax, [bp+6]
		mov	bx, [bp+8]
		mov	cx, [bp+0Ah]
		mov	dx, [bp+0Ch]
		cmp	ax, cx
		jb	short loc_14579
		xchg	ax, cx

loc_14579:				; CODE XREF: seg002:0076j
		cmp	bx, dx
		jb	short loc_1457F
		xchg	bx, dx

loc_1457F:				; CODE XREF: seg002:007Bj
		mov	[si+8],	ax
		mov	[si+0Ah], bx
		mov	[si+16h], cx
		mov	[si+18h], dx
		mov	word ptr [si+20h], 0FFFFh
		mov	byte ptr [si+28h], 2
		mov	ah, 47h	; 'G'
		mov	ch, 0B0h ; '°'
		mov	bx, si
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		pop	si
		leave
		retf
; ---------------------------------------------------------------------------
		enter	0, 0
		push	si
		mov	al, [bp+0Ah]
		mov	si, 1F94h
		and	al, 7
		mov	[si], al
		mov	ax, [bp+6]
		mov	bx, [bp+8]
		mov	[si+8],	ax
		mov	[si+0Ah], bx
		mov	word ptr [si+20h], 0FFFFh
		mov	byte ptr [si+28h], 2
		mov	ah, 47h	; 'G'
		mov	ch, 0B0h ; '°'
		mov	bx, si
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		pop	si
		leave
		retf
; ---------------------------------------------------------------------------
		enter	0, 0
		les	cx, [bp+6]
		mov	dx, [bp+0Ah]
		mov	bx, es
		mov	ah, 14h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		leave
		retf
; ---------------------------------------------------------------------------
		xor	ax, ax
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		retf
; ---------------------------------------------------------------------------
		enter	0, 0
		mov	ah, 4
		mov	al, [bp+6]
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		mov	al, ah
		xor	ah, ah
		leave
		retf
; ---------------------------------------------------------------------------
		mov	ax, 300h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		retf
; ---------------------------------------------------------------------------
		enter	0, 0
		mov	ax, [bp+6]
		mov	ah, 4
		int	1Bh		; CTRL-BREAK KEY
		mov	al, 0
		jnb	short locret_1460D
		mov	al, 1

locret_1460D:				; CODE XREF: seg002:0109j
		leave
		retf
; ---------------------------------------------------------------------------
		db    0
seg002		ends

; ===========================================================================

; Segment type:	Pure code
seg003		segment	byte public 'CODE' use16
		assume cs:seg003
		assume es:nothing, ss:nothing, ds:dseg,	fs:nothing, gs:nothing
word_14610	dw 0			; DATA XREF: sub_14B4C+3Ew
					; sub_14BA7+Ar	...
word_14612	dw 0			; DATA XREF: sub_14B4C+43w
					; sub_14BA7+Fr	...
word_14614	dw 0			; DATA XREF: sub_14B4C+48w
					; sub_14BA7+14r ...
byte_14616	db 0			; DATA XREF: sub_14B4C+4Dw
					; sub_14BA7+19r ...
word_14617	dw 0A100h		; DATA XREF: sub_14B4C+8r
					; sub_14B4C+30r ...
		align 4
word_1461C	dw  32h, 34h, 36h, 38h,	3Ah, 3Ch, 3Eh, 30h
		dw    2,   4,	6,   8,	0Ah, 0Ch, 0Eh, 10h
		dw  42h, 44h, 46h, 48h,	4Ah, 4Ch, 4Eh, 40h
		dw  12h, 14h, 16h, 18h,	1Ah, 1Ch, 1Eh, 20h
		dw  52h, 54h, 56h, 58h,	5Ah, 5Ch, 5Eh, 50h
		dw  22h, 24h, 26h, 28h,	2Ah, 2Ch, 2Eh
byte_1467A	db 0			; DATA XREF: sub_14F3E+40w
					; sub_14F3E+ACr ...
byte_1467B	db 0			; DATA XREF: sub_14F3E+44w
					; sub_14F3E:loc_14FE3r	...
byte_1467C	db 0			; DATA XREF: sub_14F3E+48w
					; sub_14F3E+B3r ...
byte_1467D	db 0			; DATA XREF: sub_14F3E+62w
					; sub_14F3E+7Dr
byte_1467E	db 0			; DATA XREF: sub_14F3E+52w
					; sub_14F3E+66r ...
byte_1467F	db 0			; DATA XREF: sub_14F3E+6Dw
					; sub_14F3E+122r ...
byte_14680	db 0			; DATA XREF: sub_14F3E+86w
					; sub_14F3E+12Ar ...
off_14681	dw offset loc_15058	; DATA XREF: sub_14F3E+A0r
		dw offset loc_15074
		dw offset loc_15090
		dw offset loc_150AC
		dw offset loc_150C8
		dw offset loc_150E4
byte_1468D	db 0C0h	dup(0)		; DATA XREF: sub_15249+4o
byte_1474D	db 0			; DATA XREF: LoadGraphics1:loc_147DEw
					; LoadGraphics1:loc_147E7w ...
		db 6 dup(0)
byte_14754	db 64h dup(0)		; DATA XREF: LoadGraphics1+64o
					; LoadGraphics1+74o

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

LoadGraphics1	proc far		; CODE XREF: LoadVDF+2EP sub_161D5+A3P ...

arg_0		= dword	ptr  6

		enter	0, 0
		push	si
		push	di
		push	ds
		push	bp
		lds	si, [bp+arg_0]
		cmp	byte ptr [si], 'L'
		jz	short loc_147DE
		nop
		nop
		nop
		cmp	byte ptr [si], 'V'
		jz	short loc_147E7
		nop
		nop
		nop
		cmp	byte ptr [si], 'M'
		jz	short loc_147F0
		nop
		nop
		nop
		jmp	short loc_1480E
; ---------------------------------------------------------------------------
		align 2

loc_147DE:				; CODE XREF: LoadGraphics1+Ej
		mov	cs:byte_1474D, 1
		jmp	short loc_147F9
; ---------------------------------------------------------------------------
		db 90h
; ---------------------------------------------------------------------------

loc_147E7:				; CODE XREF: LoadGraphics1+16j
		mov	cs:byte_1474D, 2
		jmp	short loc_147F9
; ---------------------------------------------------------------------------
		align 2

loc_147F0:				; CODE XREF: LoadGraphics1+1Ej
		mov	cs:byte_1474D, 4
		jmp	short loc_147F9
; ---------------------------------------------------------------------------
		db 90h
; ---------------------------------------------------------------------------

loc_147F9:				; CODE XREF: LoadGraphics1+2Cj
					; LoadGraphics1+35j ...
		inc	si
		cmp	byte ptr [si], 'D'
		jnz	short loc_1480E
		nop
		nop
		nop
		inc	si
		cmp	byte ptr [si], 'F'
		jnz	short loc_1480E
		nop
		nop
		nop
		jmp	short loc_14817
; ---------------------------------------------------------------------------
		align 2

loc_1480E:				; CODE XREF: LoadGraphics1+23j
					; LoadGraphics1+45j ...
		pop	bp
		pop	ds
		pop	di
		pop	si
		mov	ax, 0FFFFh
		leave
		retf
; ---------------------------------------------------------------------------

loc_14817:				; CODE XREF: LoadGraphics1+53j
		add	si, 2
		push	ds
		push	si
		mov	di, offset byte_14754
		mov	ax, cs
		mov	es, ax
		assume es:seg003
		mov	cx, 48
		rep movsw
		mov	ax, cs
		mov	ds, ax
		assume ds:seg003
		mov	si, offset byte_14754
		call	sub_14F3E
		pop	si
		pop	ds
		assume ds:dseg
		add	si, 60h
		cmp	cs:byte_1474D, 1
		jz	short loc_14855
		nop
		nop
		nop
		cmp	cs:byte_1474D, 4
		jz	short loc_1485D
		nop
		nop
		nop
		xor	di, di
		call	sub_1498D
		jmp	short loc_14867
; ---------------------------------------------------------------------------
		nop

loc_14855:				; CODE XREF: LoadGraphics1+85j
		xor	di, di
		call	sub_14A68
		jmp	short loc_14867
; ---------------------------------------------------------------------------
		nop

loc_1485D:				; CODE XREF: LoadGraphics1+90j
		xor	di, di
		call	sub_14D78
		xor	di, di
		call	sub_14DE2

loc_14867:				; CODE XREF: LoadGraphics1+9Aj
					; LoadGraphics1+A2j
		pop	bp
		pop	ds
		pop	di
		pop	si
		mov	dx, cs
		mov	ax, 7Dh	; '}'
		leave
		retf
LoadGraphics1	endp

; ---------------------------------------------------------------------------

LoadGraphics2:
		enter	0, 0
		push	si
		push	di
		push	ds
		push	bp
		lds	si, [bp+6]
		les	di, [bp+0Ah]
		assume es:nothing
		cmp	byte ptr [si], 'L'
		jz	short loc_1489B
		nop
		nop
		nop
		cmp	byte ptr [si], 'V'
		jz	short loc_148A4
		nop
		nop
		nop
		cmp	byte ptr [si], 'M'
		jz	short loc_148AD
		nop
		nop
		nop
		jmp	short loc_148CB
; ---------------------------------------------------------------------------
		nop

loc_1489B:				; CODE XREF: seg003:0273j
		mov	cs:byte_1474D, 1
		jmp	short loc_148B6
; ---------------------------------------------------------------------------
		align 2

loc_148A4:				; CODE XREF: seg003:027Bj
		mov	cs:byte_1474D, 2
		jmp	short loc_148B6
; ---------------------------------------------------------------------------
		db 90h
; ---------------------------------------------------------------------------

loc_148AD:				; CODE XREF: seg003:0283j
		mov	cs:byte_1474D, 4
		jmp	short loc_148B6
; ---------------------------------------------------------------------------
		align 2

loc_148B6:				; CODE XREF: seg003:0291j seg003:029Aj ...
		inc	si
		cmp	byte ptr [si], 44h ; 'D'
		jnz	short loc_148CB
		nop
		nop
		nop
		inc	si
		cmp	byte ptr [si], 46h ; 'F'
		jnz	short loc_148CB
		nop
		nop
		nop
		jmp	short loc_148D4
; ---------------------------------------------------------------------------
		db 90h
; ---------------------------------------------------------------------------

loc_148CB:				; CODE XREF: seg003:0288j seg003:02AAj ...
		pop	bp
		pop	ds
		pop	di
		pop	si
		mov	ax, 0FFFFh
		leave
		retf
; ---------------------------------------------------------------------------

loc_148D4:				; CODE XREF: seg003:02B8j
		add	si, 2
		push	ds
		push	si
		push	es
		push	di
		mov	di, 144h
		mov	ax, cs
		mov	es, ax
		assume es:seg003
		mov	cx, 30h	; '0'
		rep movsw
		mov	ax, cs
		mov	ds, ax
		assume ds:seg003
		mov	si, 144h
		call	sub_14F3E
		call	sub_15249
		pop	di
		pop	es
		assume es:nothing
		pop	si
		pop	ds
		assume ds:dseg
		add	si, 60h	; '`'
		cmp	cs:byte_1474D, 1
		jz	short loc_1490C
		nop
		nop
		nop
		call	sub_1491B
		jmp	short loc_14912
; ---------------------------------------------------------------------------
		align 2

loc_1490C:				; CODE XREF: seg003:02F1j
		call	sub_149E8
		jmp	short loc_14912
; ---------------------------------------------------------------------------
		align 2

loc_14912:				; CODE XREF: seg003:02F9j seg003:02FFj
		pop	bp
		pop	ds
		pop	di
		pop	si
		mov	ax, 0
		leave
		retf

; =============== S U B	R O U T	I N E =======================================


sub_1491B	proc near		; CODE XREF: seg003:02F6p
		pusha
		push	es
		call	sub_14AD4
		lodsb
		xor	ch, ch
		mov	cl, al
		lodsw
		mov	dx, ax
		lodsb
		xor	ah, ah
		mov	bp, ax
		shl	al, 1
		jnb	short loc_14988
		nop
		nop
		nop
		mov	bx, dx
		mov	ax, cx
		mul	dx
		mov	dx, bx
		mov	cs:word_1498B, ax
		mov	bx, cx
		dec	bx

loc_14943:				; CODE XREF: sub_1491B+6Bj
		push	cx
		push	di
		push	bp
		shr	bp, 1
		jnb	short loc_14955
		nop
		nop
		nop
		call	sub_14AF7
		add	di, cs:word_1498B

loc_14955:				; CODE XREF: sub_1491B+2Dj
		shr	bp, 1
		jnb	short loc_14964
		nop
		nop
		nop
		call	sub_14AF7
		add	di, cs:word_1498B

loc_14964:				; CODE XREF: sub_1491B+3Cj
		shr	bp, 1
		jnb	short loc_14973
		nop
		nop
		nop
		call	sub_14AF7
		add	di, cs:word_1498B

loc_14973:				; CODE XREF: sub_1491B+4Bj
		shr	bp, 1
		jnb	short loc_14982
		nop
		nop
		nop
		call	sub_14AF7
		add	di, cs:word_1498B

loc_14982:				; CODE XREF: sub_1491B+5Aj
		pop	bp
		pop	di
		pop	cx
		inc	di
		loop	loc_14943

loc_14988:				; CODE XREF: sub_1491B+14j
		pop	es
		popa
		retn
sub_1491B	endp

; ---------------------------------------------------------------------------
word_1498B	dw 0			; DATA XREF: sub_1491B+21w
					; sub_1491B+35r ...

; =============== S U B	R O U T	I N E =======================================


sub_1498D	proc near		; CODE XREF: LoadGraphics1+97p
		pusha
		push	es
		call	sub_14AD4
		lodsb
		xor	ch, ch
		mov	cl, al
		lodsw
		mov	dx, ax
		lodsb
		xor	ah, ah
		mov	bp, ax
		mov	bx, 4Fh	; 'O'

loc_149A2:				; CODE XREF: sub_1498D+56j
		push	cx
		push	bp
		shr	bp, 1
		jnb	short loc_149B3
		nop
		nop
		nop
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		call	sub_14AF7

loc_149B3:				; CODE XREF: sub_1498D+19j
		shr	bp, 1
		jnb	short loc_149C2
		nop
		nop
		nop
		mov	ax, 0B000h
		mov	es, ax
		assume es:nothing
		call	sub_14AF7

loc_149C2:				; CODE XREF: sub_1498D+28j
		shr	bp, 1
		jnb	short loc_149D1
		nop
		nop
		nop
		mov	ax, 0B800h
		mov	es, ax
		assume es:nothing
		call	sub_14AF7

loc_149D1:				; CODE XREF: sub_1498D+37j
		shr	bp, 1
		jnb	short loc_149E0
		nop
		nop
		nop
		mov	ax, 0E000h
		mov	es, ax
		assume es:nothing
		call	sub_14AF7

loc_149E0:				; CODE XREF: sub_1498D+46j
		inc	di
		pop	bp
		pop	cx
		loop	loc_149A2
		pop	es
		assume es:nothing
		popa
		retn
sub_1498D	endp


; =============== S U B	R O U T	I N E =======================================


sub_149E8	proc near		; CODE XREF: seg003:loc_1490Cp
		pusha
		push	es
		call	sub_14B4C
		call	sub_14BA7
		xor	ch, ch
		mov	cl, al
		call	sub_14BA7
		mov	dl, al
		call	sub_14BA7
		mov	dh, al
		call	sub_14BA7
		xor	ah, ah
		mov	bp, ax
		shl	al, 1
		jnb	short loc_14A60
		nop
		nop
		nop
		mov	bx, dx
		mov	ax, cx
		mul	dx
		mov	dx, bx
		mov	cs:word_14A66, ax
		mov	bx, cx
		dec	bx

loc_14A1B:				; CODE XREF: sub_149E8+76j
		push	cx
		push	di
		push	bp
		shr	bp, 1
		jnb	short loc_14A2D
		nop
		nop
		nop
		call	sub_14CC3
		add	di, cs:word_14A66

loc_14A2D:				; CODE XREF: sub_149E8+38j
		shr	bp, 1
		jnb	short loc_14A3C
		nop
		nop
		nop
		call	sub_14CC3
		add	di, cs:word_14A66

loc_14A3C:				; CODE XREF: sub_149E8+47j
		shr	bp, 1
		jnb	short loc_14A4B
		nop
		nop
		nop
		call	sub_14CC3
		add	di, cs:word_14A66

loc_14A4B:				; CODE XREF: sub_149E8+56j
		shr	bp, 1
		jnb	short loc_14A5A
		nop
		nop
		nop
		call	sub_14CC3
		add	di, cs:word_14A66

loc_14A5A:				; CODE XREF: sub_149E8+65j
		pop	bp
		pop	di
		pop	cx
		inc	di
		loop	loc_14A1B

loc_14A60:				; CODE XREF: sub_149E8+1Fj
		call	sub_14D2F
		pop	es
		popa
		retn
sub_149E8	endp

; ---------------------------------------------------------------------------
word_14A66	dw 0			; DATA XREF: sub_149E8+2Cw
					; sub_149E8+40r ...

; =============== S U B	R O U T	I N E =======================================


sub_14A68	proc near		; CODE XREF: LoadGraphics1+9Fp
		pusha
		push	es
		call	sub_14B4C
		call	sub_14D4C
		call	sub_14BA7
		xor	ch, ch
		mov	cl, al
		call	sub_14BA7
		mov	dl, al
		call	sub_14BA7
		mov	dh, al
		call	sub_14BA7
		xor	ah, ah
		mov	bp, ax
		mov	bx, 4Fh	; 'O'

loc_14A8B:				; CODE XREF: sub_14A68+64j
		push	cx
		push	bp
		shr	bp, 1
		jnb	short loc_14A9C
		nop
		nop
		nop
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		call	sub_14CC3

loc_14A9C:				; CODE XREF: sub_14A68+27j
		shr	bp, 1
		jnb	short loc_14AAB
		nop
		nop
		nop
		mov	ax, 0B000h
		mov	es, ax
		assume es:nothing
		call	sub_14CC3

loc_14AAB:				; CODE XREF: sub_14A68+36j
		shr	bp, 1
		jnb	short loc_14ABA
		nop
		nop
		nop
		mov	ax, 0B800h
		mov	es, ax
		assume es:nothing
		call	sub_14CC3

loc_14ABA:				; CODE XREF: sub_14A68+45j
		shr	bp, 1
		jnb	short loc_14AC9
		nop
		nop
		nop
		mov	ax, 0E000h
		mov	es, ax
		assume es:nothing
		call	sub_14CC3

loc_14AC9:				; CODE XREF: sub_14A68+54j
		inc	di
		pop	bp
		pop	cx
		loop	loc_14A8B
		call	sub_14D2F
		pop	es
		assume es:nothing
		popa
		retn
sub_14A68	endp


; =============== S U B	R O U T	I N E =======================================


sub_14AD4	proc near		; CODE XREF: sub_1491B+2p sub_1498D+2p
		push	ax
		push	bx
		push	cx
		push	dx
		lodsb
		sub	ch, ch
		mov	cl, al
		lodsw
		mov	dx, ax
		mov	ax, dx
		shl	ax, 4
		mov	di, ax
		shl	di, 2
		add	di, ax
		xor	ah, ah
		mov	ax, cx
		add	di, ax
		pop	dx
		pop	cx
		pop	bx
		pop	ax
		retn
sub_14AD4	endp


; =============== S U B	R O U T	I N E =======================================


sub_14AF7	proc near		; CODE XREF: sub_1491B+32p
					; sub_1491B+41p ...
		push	di
		mov	cx, dx

loc_14AFA:				; CODE XREF: sub_14AF7:loc_14B17j
		lodsb
		cmp	al, 5
		ja	short loc_14B14
		nop
		nop
		nop
		jz	short loc_14B2F
		nop
		nop
		nop
		cmp	al, 3
		jb	short loc_14B14
		nop
		nop
		nop
		jz	short loc_14B1B
		nop
		nop
		nop
		lodsb

loc_14B14:				; CODE XREF: sub_14AF7+6j
					; sub_14AF7+12j
		stosb
		add	di, bx

loc_14B17:				; CODE XREF: sub_14AF7+36j
					; sub_14AF7+53j
		loop	loc_14AFA
		pop	di
		retn
; ---------------------------------------------------------------------------

loc_14B1B:				; CODE XREF: sub_14AF7+17j
		xor	ah, ah
		lodsb
		dec	al
		inc	ax
		sub	cx, ax
		push	cx
		xchg	ax, cx
		lodsb

loc_14B26:				; CODE XREF: sub_14AF7+32j
		stosb
		add	di, bx
		loop	loc_14B26
		pop	cx
		inc	cx
		jmp	short loc_14B17
; ---------------------------------------------------------------------------

loc_14B2F:				; CODE XREF: sub_14AF7+Bj
		xor	ah, ah
		lodsb
		dec	al
		inc	ax
		sub	cx, ax
		sub	cx, ax
		push	cx
		xchg	ax, cx
		lodsw

loc_14B3C:				; CODE XREF: sub_14AF7+4Fj
		stosb
		add	di, bx
		xchg	ah, al
		stosb
		add	di, bx
		xchg	ah, al
		loop	loc_14B3C
		pop	cx
		inc	cx
		jmp	short loc_14B17
sub_14AF7	endp


; =============== S U B	R O U T	I N E =======================================


sub_14B4C	proc near		; CODE XREF: sub_149E8+2p sub_14A68+2p ...
		push	ds
		push	es
		push	ax
		push	bx
		push	cx
		push	dx
		push	di
		push	bp
		mov	es, cs:word_14617
		assume es:nothing
		xor	di, di
		xor	ax, ax

loc_14B5D:				; CODE XREF: sub_14B4C+18j
		mov	cx, 0Dh
		rep stosb
		inc	al
		jnz	short loc_14B5D

loc_14B66:				; CODE XREF: sub_14B4C+1Dj
		stosb
		inc	al
		jnz	short loc_14B66

loc_14B6B:				; CODE XREF: sub_14B4C+22j
		dec	al
		stosb
		jnz	short loc_14B6B
		mov	cx, 40h	; '@'
		rep stosw
		mov	al, 20h	; ' '
		mov	cx, 6Eh	; 'n'
		rep stosb
		mov	ds, cs:word_14617
		assume ds:nothing
		mov	bp, di
		mov	dh, 80h	; '€'
		xor	ah, ah
		add	si, 8
		mov	cs:word_14610, bx
		mov	cs:word_14612, dx
		mov	cs:word_14614, bp
		mov	cs:byte_14616, ah
		pop	bp
		pop	di
		pop	dx
		pop	cx
		pop	bx
		pop	ax
		pop	es
		assume es:nothing
		pop	ds
		assume ds:dseg
		retn
sub_14B4C	endp


; =============== S U B	R O U T	I N E =======================================


sub_14BA7	proc near		; CODE XREF: sub_149E8+5p sub_149E8+Cp ...
		push	ds
		push	bx
		push	cx
		push	dx
		push	bp
		mov	cs:byte_14C4E, ah
		mov	bx, cs:word_14610
		mov	dx, cs:word_14612
		mov	bp, cs:word_14614
		mov	ah, cs:byte_14616
		or	ah, ah
		jnz	short loc_14C17
		nop
		nop
		nop
		rol	dh, 1
		jnb	short loc_14BD6
		nop
		nop
		nop
		lodsb
		mov	dl, al

loc_14BD6:				; CODE XREF: sub_14BA7+27j
		shr	dl, 1
		jnb	short loc_14C0B
		nop
		nop
		nop
		lodsb
		mov	ds, cs:word_14617
		assume ds:nothing
		mov	ds:[bp+0], al
		inc	bp
		and	bp, 0FFFh
		mov	cs:word_14610, bx
		mov	cs:word_14612, dx
		mov	cs:word_14614, bp
		mov	cs:byte_14616, ah
		mov	ah, cs:byte_14C4E
		pop	bp
		pop	dx
		pop	cx
		pop	bx
		pop	ds
		assume ds:dseg
		retn
; ---------------------------------------------------------------------------

loc_14C0B:				; CODE XREF: sub_14BA7+31j
		lodsw
		mov	bx, ax
		shr	bh, 4
		and	ah, 0Fh
		add	ah, 3

loc_14C17:				; CODE XREF: sub_14BA7+20j
		mov	ds, cs:word_14617
		assume ds:nothing
		mov	al, [bx]
		inc	bx
		and	bx, 0FFFh
		mov	ds:[bp+0], al
		inc	bp
		and	bp, 0FFFh
		dec	ah
		mov	cs:word_14610, bx
		mov	cs:word_14612, dx
		mov	cs:word_14614, bp
		mov	cs:byte_14616, ah
		mov	ah, cs:byte_14C4E
		pop	bp
		pop	dx
		pop	cx
		pop	bx
		pop	ds
		assume ds:dseg
		retn
sub_14BA7	endp

; ---------------------------------------------------------------------------
		align 2
byte_14C4E	db 0			; DATA XREF: sub_14BA7+5w
					; sub_14BA7+59r ...
; ---------------------------------------------------------------------------
		mov	es, cs:word_14617
		assume es:nothing
		xor	di, di
		xor	ax, ax

loc_14C58:				; CODE XREF: seg003:064Fj
		mov	cx, 0Dh
		rep stosb
		inc	al
		jnz	short loc_14C58

loc_14C61:				; CODE XREF: seg003:0654j
		stosb
		inc	al
		jnz	short loc_14C61

loc_14C66:				; CODE XREF: seg003:0659j
		dec	al
		stosb
		jnz	short loc_14C66
		mov	cx, 40h	; '@'
		rep stosw
		mov	al, 20h	; ' '
		mov	cx, 6Eh	; 'n'
		rep stosb
		mov	bp, di
		mov	dh, 80h	; '€'
		xor	ah, ah
		add	si, 8
		retn
; ---------------------------------------------------------------------------
		or	ah, ah
		jnz	short loc_14CB0
		nop
		nop
		nop
		rol	dh, 1
		jnb	short loc_14C92
		nop
		nop
		nop
		lodsb
		mov	dl, al

loc_14C92:				; CODE XREF: seg003:067Aj
		shr	dl, 1
		jnb	short loc_14CA4
		nop
		nop
		nop
		lodsb
		mov	ds:[bp+0], al
		inc	bp
		and	bp, 0FFFh
		retn
; ---------------------------------------------------------------------------

loc_14CA4:				; CODE XREF: seg003:0684j
		lodsw
		mov	bx, ax
		shr	bh, 4
		and	ah, 0Fh
		add	ah, 3

loc_14CB0:				; CODE XREF: seg003:0673j
		mov	al, [bx]
		inc	bx
		and	bx, 0FFFh
		mov	ds:[bp+0], al
		inc	bp
		and	bp, 0FFFh
		dec	ah
		retn

; =============== S U B	R O U T	I N E =======================================


sub_14CC3	proc near		; CODE XREF: sub_149E8+3Dp
					; sub_149E8+4Cp ...
		push	di
		mov	cx, dx

loc_14CC6:				; CODE XREF: sub_14CC3:loc_14CE7j
		call	sub_14BA7
		cmp	al, 5
		ja	short loc_14CE4
		nop
		nop
		nop
		jz	short loc_14D03
		nop
		nop
		nop
		cmp	al, 3
		jb	short loc_14CE4
		nop
		nop
		nop
		jz	short loc_14CEB
		nop
		nop
		nop
		call	sub_14BA7

loc_14CE4:				; CODE XREF: sub_14CC3+8j
					; sub_14CC3+14j
		stosb
		add	di, bx

loc_14CE7:				; CODE XREF: sub_14CC3+3Ej
					; sub_14CC3+6Aj
		loop	loc_14CC6
		pop	di
		retn
; ---------------------------------------------------------------------------

loc_14CEB:				; CODE XREF: sub_14CC3+19j
		xor	ah, ah
		call	sub_14BA7
		dec	al
		inc	ax
		sub	cx, ax
		push	cx
		xchg	ax, cx
		call	sub_14BA7

loc_14CFA:				; CODE XREF: sub_14CC3+3Aj
		stosb
		add	di, bx
		loop	loc_14CFA
		pop	cx
		inc	cx
		jmp	short loc_14CE7
; ---------------------------------------------------------------------------

loc_14D03:				; CODE XREF: sub_14CC3+Dj
		xor	ah, ah
		call	sub_14BA7
		dec	al
		inc	ax
		sub	cx, ax
		sub	cx, ax
		push	cx
		xchg	ax, cx
		push	dx
		call	sub_14BA7
		mov	dl, al
		call	sub_14BA7
		mov	ah, al
		mov	al, dl
		pop	dx

loc_14D1F:				; CODE XREF: sub_14CC3+66j
		stosb
		add	di, bx
		xchg	ah, al
		stosb
		add	di, bx
		xchg	ah, al
		loop	loc_14D1F
		pop	cx
		inc	cx
		jmp	short loc_14CE7
sub_14CC3	endp


; =============== S U B	R O U T	I N E =======================================


sub_14D2F	proc near		; CODE XREF: sub_149E8:loc_14A60p
					; sub_14A68+66p ...
		push	es
		cmp	cs:word_14617, 0A100h
		jnz	short loc_14D4A
		nop
		nop
		nop
		mov	ax, 0A100h
		mov	es, ax
		xor	di, di
		mov	cx, 50h	; 'P'
		xor	ax, ax
		rep stosw

loc_14D4A:				; CODE XREF: sub_14D2F+8j
		pop	es
		assume es:nothing
		retn
sub_14D2F	endp


; =============== S U B	R O U T	I N E =======================================


sub_14D4C	proc near		; CODE XREF: sub_14A68+5p sub_14D78+4p ...
		push	ax
		push	bx
		push	cx
		push	dx
		call	sub_14BA7
		xor	ch, ch
		mov	cl, al
		call	sub_14BA7
		mov	dl, al
		call	sub_14BA7
		mov	dh, al
		mov	ax, dx
		shl	ax, 4
		mov	di, ax
		shl	di, 2
		add	di, ax
		xor	ah, ah
		mov	ax, cx
		add	di, ax
		pop	dx
		pop	cx
		pop	bx
		pop	ax
		retn
sub_14D4C	endp


; =============== S U B	R O U T	I N E =======================================


sub_14D78	proc near		; CODE XREF: LoadGraphics1+A7p
		push	es
		call	sub_14B4C
		call	sub_14D4C
		call	sub_14BA7
		xor	ch, ch
		mov	cl, al
		call	sub_14BA7
		mov	dl, al
		call	sub_14BA7
		mov	dh, al
		call	sub_14BA7
		xor	ah, ah
		mov	bp, ax
		mov	bx, 4Fh	; 'O'

loc_14D9A:				; CODE XREF: sub_14D78+63j
		push	cx
		push	bp
		shr	bp, 1
		jnb	short loc_14DAB
		nop
		nop
		nop
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		call	sub_14E4E

loc_14DAB:				; CODE XREF: sub_14D78+26j
		shr	bp, 1
		jnb	short loc_14DBA
		nop
		nop
		nop
		mov	ax, 0B000h
		mov	es, ax
		assume es:nothing
		call	sub_14E4E

loc_14DBA:				; CODE XREF: sub_14D78+35j
		shr	bp, 1
		jnb	short loc_14DC9
		nop
		nop
		nop
		mov	ax, 0B800h
		mov	es, ax
		assume es:nothing
		call	sub_14E4E

loc_14DC9:				; CODE XREF: sub_14D78+44j
		shr	bp, 1
		jnb	short loc_14DD8
		nop
		nop
		nop
		mov	ax, 0E000h
		mov	es, ax
		assume es:nothing
		call	sub_14E4E

loc_14DD8:				; CODE XREF: sub_14D78+53j
		inc	di
		pop	bp
		pop	cx
		loop	loc_14D9A
		call	sub_14D2F
		pop	es
		assume es:nothing
		retn
sub_14D78	endp


; =============== S U B	R O U T	I N E =======================================


sub_14DE2	proc near		; CODE XREF: LoadGraphics1+ACp
		pusha
		push	es
		call	sub_14B4C
		call	sub_14D4C
		call	sub_14BA7
		xor	ch, ch
		mov	cl, al
		call	sub_14BA7
		mov	dl, al
		call	sub_14BA7
		mov	dh, al
		call	sub_14BA7
		xor	ah, ah
		mov	bp, ax
		mov	bx, 4Fh	; 'O'

loc_14E05:				; CODE XREF: sub_14DE2+64j
		push	cx
		push	bp
		shr	bp, 1
		jnb	short loc_14E16
		nop
		nop
		nop
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		call	sub_14EC6

loc_14E16:				; CODE XREF: sub_14DE2+27j
		shr	bp, 1
		jnb	short loc_14E25
		nop
		nop
		nop
		mov	ax, 0B000h
		mov	es, ax
		assume es:nothing
		call	sub_14EC6

loc_14E25:				; CODE XREF: sub_14DE2+36j
		shr	bp, 1
		jnb	short loc_14E34
		nop
		nop
		nop
		mov	ax, 0B800h
		mov	es, ax
		assume es:nothing
		call	sub_14EC6

loc_14E34:				; CODE XREF: sub_14DE2+45j
		shr	bp, 1
		jnb	short loc_14E43
		nop
		nop
		nop
		mov	ax, 0E000h
		mov	es, ax
		assume es:nothing
		call	sub_14EC6

loc_14E43:				; CODE XREF: sub_14DE2+54j
		inc	di
		pop	bp
		pop	cx
		loop	loc_14E05
		call	sub_14D2F
		pop	es
		assume es:nothing
		popa
		retn
sub_14DE2	endp


; =============== S U B	R O U T	I N E =======================================


sub_14E4E	proc near		; CODE XREF: sub_14D78+30p
					; sub_14D78+3Fp ...
		push	di
		mov	cx, dx

loc_14E51:				; CODE XREF: sub_14E4E:loc_14E75j
		call	sub_14BA7
		cmp	al, 5
		ja	short loc_14E6F
		nop
		nop
		nop
		jz	short loc_14E94
		nop
		nop
		nop
		cmp	al, 3
		jb	short loc_14E6F
		nop
		nop
		nop
		jz	short loc_14E79
		nop
		nop
		nop
		call	sub_14BA7

loc_14E6F:				; CODE XREF: sub_14E4E+8j
					; sub_14E4E+14j
		and	es:[di], al
		inc	di
		add	di, bx

loc_14E75:				; CODE XREF: sub_14E4E+44j
					; sub_14E4E+76j
		loop	loc_14E51
		pop	di
		retn
; ---------------------------------------------------------------------------

loc_14E79:				; CODE XREF: sub_14E4E+19j
		xor	ah, ah
		call	sub_14BA7
		dec	al
		inc	ax
		sub	cx, ax
		push	cx
		xchg	ax, cx
		call	sub_14BA7

loc_14E88:				; CODE XREF: sub_14E4E+40j
		and	es:[di], al
		inc	di
		add	di, bx
		loop	loc_14E88
		pop	cx
		inc	cx
		jmp	short loc_14E75
; ---------------------------------------------------------------------------

loc_14E94:				; CODE XREF: sub_14E4E+Dj
		xor	ah, ah
		call	sub_14BA7
		dec	al
		inc	ax
		sub	cx, ax
		sub	cx, ax
		push	cx
		xchg	ax, cx
		push	dx
		call	sub_14BA7
		mov	dl, al
		call	sub_14BA7
		mov	ah, al
		mov	al, dl
		pop	dx

loc_14EB0:				; CODE XREF: sub_14E4E+72j
		and	es:[di], al
		inc	di
		add	di, bx
		xchg	ah, al
		and	es:[di], al
		inc	di
		add	di, bx
		xchg	ah, al
		loop	loc_14EB0
		pop	cx
		inc	cx
		jmp	short loc_14E75
sub_14E4E	endp


; =============== S U B	R O U T	I N E =======================================


sub_14EC6	proc near		; CODE XREF: sub_14DE2+31p
					; sub_14DE2+40p ...
		push	di
		mov	cx, dx

loc_14EC9:				; CODE XREF: sub_14EC6:loc_14EEDj
		call	sub_14BA7
		cmp	al, 5
		ja	short loc_14EE7
		nop
		nop
		nop
		jz	short loc_14F0C
		nop
		nop
		nop
		cmp	al, 3
		jb	short loc_14EE7
		nop
		nop
		nop
		jz	short loc_14EF1
		nop
		nop
		nop
		call	sub_14BA7

loc_14EE7:				; CODE XREF: sub_14EC6+8j
					; sub_14EC6+14j
		or	es:[di], al
		inc	di
		add	di, bx

loc_14EED:				; CODE XREF: sub_14EC6+44j
					; sub_14EC6+76j
		loop	loc_14EC9
		pop	di
		retn
; ---------------------------------------------------------------------------

loc_14EF1:				; CODE XREF: sub_14EC6+19j
		xor	ah, ah
		call	sub_14BA7
		dec	al
		inc	ax
		sub	cx, ax
		push	cx
		xchg	ax, cx
		call	sub_14BA7

loc_14F00:				; CODE XREF: sub_14EC6+40j
		or	es:[di], al
		inc	di
		add	di, bx
		loop	loc_14F00
		pop	cx
		inc	cx
		jmp	short loc_14EED
; ---------------------------------------------------------------------------

loc_14F0C:				; CODE XREF: sub_14EC6+Dj
		xor	ah, ah
		call	sub_14BA7
		dec	al
		inc	ax
		sub	cx, ax
		sub	cx, ax
		push	cx
		xchg	ax, cx
		push	dx
		call	sub_14BA7
		mov	dl, al
		call	sub_14BA7
		mov	ah, al
		mov	al, dl
		pop	dx

loc_14F28:				; CODE XREF: sub_14EC6+72j
		or	es:[di], al
		inc	di
		add	di, bx
		xchg	ah, al
		or	es:[di], al
		inc	di
		add	di, bx
		xchg	ah, al
		loop	loc_14F28
		pop	cx
		inc	cx
		jmp	short loc_14EED
sub_14EC6	endp


; =============== S U B	R O U T	I N E =======================================


sub_14F3E	proc near		; CODE XREF: LoadGraphics1+77p
					; seg003:02DEp

; FUNCTION CHUNK AT 0A48 SIZE 000000A8 BYTES

		mov	ax, cs
		mov	es, ax
		assume es:seg003
		mov	di, 7Dh	; '}'
		pusha
		push	ds
		push	es
		push	di
		mov	di, 0DDh ; 'Ý'
		mov	cx, 30h	; '0'
		mov	bx, 0Ah
		cld

loc_14F53:				; CODE XREF: sub_14F3E+24j
		push	si
		add	si, cs:[bx]
		add	bx, 2
		lodsw
		mov	cs:[di], ax
		add	di, 2
		pop	si
		loop	loc_14F53
		pop	di
		mov	ax, cs
		mov	ds, ax
		assume ds:seg003
		mov	si, 0DDh ; 'Ý'
		mov	cx, 10h

loc_14F6F:				; CODE XREF: sub_14F3E:loc_15000j
		push	cx
		cmp	word ptr cs:[si+20h], 0
		jnz	short loc_14F8D
		nop
		nop
		nop
		mov	ax, cs:[si+40h]
		mov	cs:byte_1467A, al
		mov	cs:byte_1467B, al
		mov	cs:byte_1467C, al
		jmp	short loc_14FE3
; ---------------------------------------------------------------------------
		db 90h
; ---------------------------------------------------------------------------

loc_14F8D:				; CODE XREF: sub_14F3E+37j
		mov	ax, [si+40h]
		mov	cs:byte_1467E, al
		mov	cl, al
		mov	ax, cs:[si+20h]
		mul	cl
		mov	cl, 64h	; 'd'
		div	cl
		mov	cs:byte_1467D, al
		mov	ah, cs:byte_1467E
		sub	ah, al
		mov	cs:byte_1467F, ah
		mov	ax, [si]
		mov	cx, 3Ch	; '<'
		div	cl
		mov	al, ah
		xor	ah, ah
		mov	ch, cs:byte_1467D
		mul	ch
		div	cl
		mov	cs:byte_14680, al
		nop
		mov	ax, [si]
		mov	cx, 3Ch	; '<'
		div	cl
		mov	bl, al
		xor	bh, bh
		cmp	bx, 6
		jnb	short loc_15007
		nop
		nop
		nop
		shl	bx, 1
		jmp	cs:off_14681[bx]
; ---------------------------------------------------------------------------

loc_14FE3:				; CODE XREF: sub_14F3E+4Cj
					; sub_14F3E+133j ...
		mov	al, cs:byte_1467B
		call	sub_15041
		mov	al, cs:byte_1467A
		call	sub_15041
		mov	al, cs:byte_1467C
		call	sub_15041
		pop	cx
		add	si, 2
		loop	loc_15000
		jmp	short loc_15003
; ---------------------------------------------------------------------------

loc_15000:				; CODE XREF: sub_14F3E+BEj
		jmp	loc_14F6F
; ---------------------------------------------------------------------------

loc_15003:				; CODE XREF: sub_14F3E+C0j
		clc
		jmp	short loc_1500B
; ---------------------------------------------------------------------------
		db 90h
; ---------------------------------------------------------------------------

loc_15007:				; CODE XREF: sub_14F3E+99j
		stc
		mov	al, 0Ah
		pop	cx

loc_1500B:				; CODE XREF: sub_14F3E+C6j
		mov	ax, cs
		mov	ds, ax
		mov	si, 7Dh	; '}'
		nop
		mov	cx, 10h
		mov	si, 7Dh	; '}'
		mov	di, 7Dh	; '}'

loc_1501C:				; CODE XREF: sub_14F3E+FDj
		mov	dl, cs:[si]
		mov	bl, cs:[si+1]
		mov	al, cs:[si+2]
		shl	bl, 4
		and	al, 0Fh
		or	al, bl
		mov	cs:[di], al
		mov	cs:[di+1], dl
		add	si, 3
		add	di, 2
		loop	loc_1501C
		pop	es
		assume es:nothing
		pop	ds
		assume ds:dseg
		popa
		retn
sub_14F3E	endp


; =============== S U B	R O U T	I N E =======================================


sub_15041	proc near		; CODE XREF: sub_14F3E+A9p
					; sub_14F3E+B0p ...
		mov	cl, 64h	; 'd'
		xor	ah, ah
		imul	ax, 0Fh
		add	ax, 32h	; '2'
		div	cl
		cmp	al, 10h
		jb	short loc_15056
		nop
		nop
		nop
		mov	al, 0Fh

loc_15056:				; CODE XREF: sub_15041+Ej
		stosb
		retn
sub_15041	endp

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_14F3E

loc_15058:				; CODE XREF: sub_14F3E+A0j
					; DATA XREF: seg003:off_14681o
		mov	al, cs:byte_1467E
		mov	cs:byte_1467A, al
		mov	al, cs:byte_1467F
		mov	cs:byte_1467C, al
		add	al, cs:byte_14680
		mov	cs:byte_1467B, al
		jmp	loc_14FE3
; ---------------------------------------------------------------------------

loc_15074:				; CODE XREF: sub_14F3E+A0j
					; DATA XREF: seg003:0073o
		mov	al, cs:byte_1467E
		mov	cs:byte_1467B, al
		sub	al, cs:byte_14680
		mov	cs:byte_1467A, al
		mov	al, cs:byte_1467F
		mov	cs:byte_1467C, al
		jmp	loc_14FE3
; ---------------------------------------------------------------------------

loc_15090:				; CODE XREF: sub_14F3E+A0j
					; DATA XREF: seg003:0075o
		mov	al, cs:byte_1467F
		mov	cs:byte_1467A, al
		add	al, cs:byte_14680
		mov	cs:byte_1467C, al
		mov	al, cs:byte_1467E
		mov	cs:byte_1467B, al
		jmp	loc_14FE3
; ---------------------------------------------------------------------------

loc_150AC:				; CODE XREF: sub_14F3E+A0j
					; DATA XREF: seg003:0077o
		mov	al, cs:byte_1467F
		mov	cs:byte_1467A, al
		mov	al, cs:byte_1467E
		mov	cs:byte_1467C, al
		sub	al, cs:byte_14680
		mov	cs:byte_1467B, al
		jmp	loc_14FE3
; ---------------------------------------------------------------------------

loc_150C8:				; CODE XREF: sub_14F3E+A0j
					; DATA XREF: seg003:0079o
		mov	al, cs:byte_1467F
		mov	cs:byte_1467B, al
		add	al, cs:byte_14680
		mov	cs:byte_1467A, al
		mov	al, cs:byte_1467E
		mov	cs:byte_1467C, al
		jmp	loc_14FE3
; ---------------------------------------------------------------------------

loc_150E4:				; CODE XREF: sub_14F3E+A0j
					; DATA XREF: seg003:007Bo
		mov	al, cs:byte_1467E
		mov	cs:byte_1467A, al
		sub	al, cs:byte_14680
		mov	cs:byte_1467C, al
		mov	al, cs:byte_1467F
		mov	cs:byte_1467B, al
		jmp	loc_14FE3
; END OF FUNCTION CHUNK	FOR sub_14F3E
; ---------------------------------------------------------------------------
		push	es
		push	ds
		mov	ax, cs
		mov	es, ax
		assume es:seg003
		mov	di, 7Dh	; '}'
		xor	dx, dx
		mov	cx, 30h	; '0'
		rep movsw
		mov	ax, cs
		mov	ds, ax
		assume ds:seg003
		mov	es, ax
		mov	si, 7Dh	; '}'
		mov	cs:word_1522B, si
		mov	cs:word_1522D, si
		mov	cx, 2

loc_15126:				; CODE XREF: seg003:0B34j
		push	cx
		mov	cx, 8

loc_1512A:				; CODE XREF: seg003:0B2Bj
		push	cx
		call	sub_15162
		add	cs:word_1522B, 2
		add	cs:word_1522D, 2
		pop	cx
		loop	loc_1512A
		add	cs:word_1522B, 20h ; ' '
		pop	cx
		loop	loc_15126
		mov	ax, cs
		mov	ds, ax
		mov	si, 7Dh	; '}'
		mov	cx, 7

loc_15150:				; CODE XREF: seg003:0B4Dj
		add	si, 2
		mov	ax, [si]
		mov	bx, [si+10h]
		mov	[si], bx
		mov	[si+10h], ax
		loop	loc_15150
		pop	ds
		assume ds:dseg
		pop	es
		assume es:nothing
		retn

; =============== S U B	R O U T	I N E =======================================


sub_15162	proc near		; CODE XREF: seg003:0B1Bp
		mov	si, cs:word_1522B
		mov	di, 0C0Fh
		mov	ax, [si]
		stosw
		mov	ax, [si+10h]
		stosw
		mov	ax, [si+20h]
		stosw
		mov	ax, cs:word_1521F
		mov	si, 3Ch	; '<'
		xor	dx, dx
		div	si
		shr	dx, 2
		mov	si, ax
		shl	si, 1
		add	si, ax
		add	si, 0C1Fh
		mov	di, 0C15h
		call	sub_151F9
		mov	bx, 0C15h
		mov	cx, 3

loc_15199:				; CODE XREF: sub_15162+56j
		push	cx
		mov	ax, 64h	; 'd'
		sub	ax, cs:word_15221
		mov	dx, 10h
		sub	dx, cs:[bx]
		mul	dx
		mov	cx, 65h	; 'e'
		xor	dx, dx
		div	cx
		add	cs:[bx], ax
		add	bx, 2
		pop	cx
		loop	loc_15199
		mov	bx, 0C15h
		mov	cx, 3

loc_151C0:				; CODE XREF: sub_15162+78j
		push	cx
		mov	ax, cs:[bx]
		inc	ax
		mov	dx, cs:word_15223
		mul	dx
		mov	cx, 65h	; 'e'
		xor	dx, dx
		div	cx
		mov	cs:[bx], ax
		add	bx, 2
		pop	cx
		loop	loc_151C0
		mov	al, cs:byte_15225
		mov	ah, cs:byte_15227
		and	al, 0Fh
		shl	ah, 4
		or	al, ah
		mov	ah, cs:byte_15229
		mov	si, cs:word_1522D
		mov	[si], ax
		retn
sub_15162	endp


; =============== S U B	R O U T	I N E =======================================


sub_151F9	proc near		; CODE XREF: sub_15162+2Ep
		mov	cx, 3

loc_151FC:				; CODE XREF: sub_151F9+13j
		mov	bl, cs:[si]
		inc	si
		xor	bh, bh
		shl	bx, 1
		add	bx, offset off_15241
		call	word ptr cs:[bx]
		stosw
		loop	loc_151FC
		retn
sub_151F9	endp

; ---------------------------------------------------------------------------

loc_1520F:				; DATA XREF: seg003:off_15241o
		mov	ax, 0Fh
		sub	ax, dx
		retn
; ---------------------------------------------------------------------------

loc_15215:				; DATA XREF: seg003:off_15241o
		mov	ax, 0Fh
		retn
; ---------------------------------------------------------------------------

loc_15219:				; DATA XREF: seg003:off_15241o
		mov	ax, dx
		retn
; ---------------------------------------------------------------------------

loc_1521C:				; DATA XREF: seg003:off_15241o
		xor	ax, ax
		retn
; ---------------------------------------------------------------------------
word_1521F	dw 0			; DATA XREF: sub_15162+13r
word_15221	dw 0			; DATA XREF: sub_15162+3Br
word_15223	dw 0			; DATA XREF: sub_15162+63r
byte_15225	db 0			; DATA XREF: sub_15162+7Ar
		db 0
byte_15227	db 0			; DATA XREF: sub_15162+7Er
		db 0
byte_15229	db 0			; DATA XREF: sub_15162+8Ar
		db 0
word_1522B	dw 0			; DATA XREF: seg003:0B09w seg003:0B1Ew ...
word_1522D	dw 0			; DATA XREF: seg003:0B0Ew seg003:0B24w ...
		db 0, 2, 1
		db 0, 3, 2
		db 1, 0, 2
		db 2, 0, 3
		db 2, 1, 0
		db 3, 2, 0
off_15241	dw offset loc_1521C	; DATA XREF: sub_151F9+Bo
		dw offset loc_15219
		dw offset loc_15215
		dw offset loc_1520F

; =============== S U B	R O U T	I N E =======================================


sub_15249	proc near		; CODE XREF: seg003:02E1p
		mov	ax, cs
		mov	ds, ax
		assume ds:seg003
		mov	si, offset byte_1468D
		mov	cx, 10h

loc_15253:				; CODE XREF: sub_15249:loc_15270j
		mov	al, 10h
		sub	al, cl
		out	0A8h, al	; Interrupt Controller #2, 8259A
		jmp	short $+2
		jmp	short $+2
		lodsb
		mov	ah, al
		and	al, 0Fh
		out	0AEh, al	; Interrupt Controller #2, 8259A
		mov	al, ah
		shr	al, 4
		out	0ACh, al	; Interrupt Controller #2, 8259A
		lodsb
		and	al, 0Fh
		out	0AAh, al	; Interrupt Controller #2, 8259A

loc_15270:
		loop	loc_15253
		retn
sub_15249	endp

seg003		ends

; ===========================================================================

; Segment type:	Pure code
seg004		segment	byte public 'CODE' use16
		assume cs:seg004
		;org 3
		assume es:nothing, ss:nothing, ds:dseg,	fs:nothing, gs:nothing
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_15274	proc far		; CODE XREF: LoadVDF+11P
					; sub_1566E+98BP ...

arg_0		= dword	ptr  6
arg_4		= dword	ptr  0Ah

		enter	0, 0
		push	si
		push	di
		push	ds
		mov	ax, 1

loc_1527E:
		lds	si, [bp+arg_0]
		les	di, [bp+arg_4]
		int	7Dh		; not used
		jnb	short loc_1528E
		nop
		nop
		nop
		mov	ax, 0FFFFh

loc_1528E:				; CODE XREF: sub_15274+12j
		pop	ds
		pop	di
		pop	si
		leave
		retf
sub_15274	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_15293	proc far		; CODE XREF: sub_1566E+1F8P

arg_0		= word ptr  6

		enter	0, 0
		mov	ax, [bp+arg_0]
		cmp	ax, 2
		jz	short loc_152BB
		nop
		nop
		nop

loc_152A2:
		cmp	ax, 3
		jz	short loc_152C5
		nop
		nop
		nop
		mov	cs:musicMode, 0
		mov	dx, ax
		mov	ax, 0Ah
		int	7Eh		; not used
		jmp	short locret_152CC
; ---------------------------------------------------------------------------
		db 90h
; ---------------------------------------------------------------------------

loc_152BB:				; CODE XREF: sub_15293+Aj
		mov	cs:musicMode, 2
		jmp	short locret_152CC
; ---------------------------------------------------------------------------
		db 90h
; ---------------------------------------------------------------------------

loc_152C5:				; CODE XREF: sub_15293+12j
		mov	cs:musicMode, 3

locret_152CC:				; CODE XREF: sub_15293+25j
					; sub_15293+2Fj
		leave
		retf
sub_15293	endp


; =============== S U B	R O U T	I N E =======================================


DetectMusicDriver proc far		; CODE XREF: sub_1566E+5EP
		push	ds
		push	es
		pusha
		mov	ax, cs
		mov	ds, ax
		assume ds:seg004
		jmp	short loc_152DC
; ---------------------------------------------------------------------------
		align 2
aMfd		db 'MFD',0              ; DATA XREF: DetectMusicDriver+18o
; ---------------------------------------------------------------------------

loc_152DC:				; CODE XREF: DetectMusicDriver+7j
		mov	ax, 357Ch
		int	21h		; DOS -	2+ - GET INTERRUPT VECTOR
					; AL = interrupt number
					; Return: ES:BX	= value	of interrupt vector
		sub	bx, 4
		mov	di, bx
		mov	si, offset aMfd	; "MFD"
		mov	cx, 3
		cld
		repe cmpsb
		jz	short loc_15349
		nop
		nop
		nop
		mov	ax, cs
		mov	ds, ax
		mov	ax, 357Eh
		int	21h		; DOS -	2+ - GET INTERRUPT VECTOR
					; AL = interrupt number
					; Return: ES:BX	= value	of interrupt vector
		sub	bx, 5
		mov	di, bx
		mov	si, offset aUsmd ; "USMD"
		mov	cx, 4
		cld
		repe cmpsb
		jz	short loc_15337
		nop
		nop
		nop
		mov	ax, cs
		mov	ds, ax
		mov	ax, 3560h
		int	21h		; DOS -	2+ - GET INTERRUPT VECTOR
					; AL = interrupt number
					; Return: ES:BX	= value	of interrupt vector
		add	bx, 2
		mov	di, bx
		mov	si, offset aPmd	; "PMD"
		mov	cx, 3
		cld
		repe cmpsb
		jz	short loc_15340
		nop
		nop
		nop
		mov	cs:musicMode, 0FFFFh

loc_15333:				; CODE XREF: DetectMusicDriver+70j
					; DetectMusicDriver+79j ...
		popa
		pop	es
		pop	ds
		assume ds:dseg
		retf
; ---------------------------------------------------------------------------

loc_15337:				; CODE XREF: DetectMusicDriver+3Dj
		mov	cs:musicMode, 0
		jmp	short loc_15333
; ---------------------------------------------------------------------------

loc_15340:				; CODE XREF: DetectMusicDriver+59j
		mov	cs:musicMode, 1
		jmp	short loc_15333
; ---------------------------------------------------------------------------

loc_15349:				; CODE XREF: DetectMusicDriver+21j
		mov	cs:musicMode, 2
		jmp	short loc_15333
DetectMusicDriver endp

; ---------------------------------------------------------------------------
aUsmd		db 'USMD'               ; DATA XREF: DetectMusicDriver+34o
aPmd		db 'PMD'                ; DATA XREF: DetectMusicDriver+50o
; ---------------------------------------------------------------------------

Music_Stop:
		cmp	cs:musicMode, 2
		jz	short loc_1538C
		nop
		nop
		nop
		cmp	cs:musicMode, 1
		jz	short loc_15385
		nop
		nop
		nop
		cmp	cs:musicMode, 0
		jz	short loc_1537D
		nop
		nop
		nop
		jmp	short loc_15393
; ---------------------------------------------------------------------------
		nop

loc_1537D:				; CODE XREF: seg004:0105j
		mov	ax, 3
		int	7Eh		; not used
		jmp	short loc_15393
; ---------------------------------------------------------------------------
		nop

loc_15385:				; CODE XREF: seg004:00FAj
		mov	ah, 1
		int	60h		;  - FTP Packet	Driver - BASIC FUNC -
		jmp	short loc_15393
; ---------------------------------------------------------------------------
		nop

loc_1538C:				; CODE XREF: seg004:00EFj
		mov	ah, 1
		int	7Ch		; IBM REXX88PC command language
		jmp	short loc_15393
; ---------------------------------------------------------------------------
		nop

loc_15393:				; CODE XREF: seg004:010Aj seg004:0112j ...
		clc
		retf

; =============== S U B	R O U T	I N E =======================================


sub_15395	proc far		; CODE XREF: sub_1566E+AB1P
		cmp	cs:musicMode, 2
		jz	short loc_153CD
		nop
		nop
		nop
		cmp	cs:musicMode, 1
		jz	short loc_153C4
		nop
		nop
		nop
		cmp	cs:musicMode, 0
		jz	short loc_153B9
		nop
		nop
		nop
		jmp	short loc_153D6
; ---------------------------------------------------------------------------
		nop

loc_153B9:				; CODE XREF: sub_15395+1Cj
		mov	dx, 9
		mov	ax, 4
		int	7Eh		; not used
		jmp	short loc_153D6
; ---------------------------------------------------------------------------
		nop

loc_153C4:				; CODE XREF: sub_15395+11j
		mov	ah, 2
		mov	al, 14h
		int	60h		; - FTP	Packet Driver -	BASIC FUNC - ACCESS TYPE
					; AL = interface class,	BX = interface type, DL	= interface number
					; DS:SI	-> type, CX = length, ES:DI -> receiver
					; Return: CF set on error, DH =	error code
					; CF clear if successful, AX = handle
		jmp	short loc_153D6
; ---------------------------------------------------------------------------
		nop

loc_153CD:				; CODE XREF: sub_15395+6j
		mov	ah, 3
		mov	al, 4
		int	7Ch		; IBM REXX88PC command language
		jmp	short loc_153D6
; ---------------------------------------------------------------------------
		nop

loc_153D6:				; CODE XREF: sub_15395+21j
					; sub_15395+2Cj ...
		clc
		retf
sub_15395	endp

; ---------------------------------------------------------------------------
		push	ds
		push	es
		cmp	cs:musicMode, 1
		jz	short loc_15411
		nop
		nop
		nop
		cmp	cs:musicMode, 0
		jz	short loc_15409
		nop
		nop
		nop
		cmp	cs:musicMode, 2
		jz	short loc_15409
		nop
		nop
		nop
		cmp	cs:musicMode, 2
		jz	short loc_15418
		nop
		nop
		nop
		jmp	short loc_1541B
; ---------------------------------------------------------------------------
		nop

loc_15409:				; CODE XREF: seg004:017Bj seg004:0186j
		mov	ax, 3
		int	7Eh		; not used
		jmp	short loc_1541B
; ---------------------------------------------------------------------------
		nop

loc_15411:				; CODE XREF: seg004:0170j
		mov	ah, 4
		int	60h		; - FTP	Packet Driver -	BASIC FUNC - SEND PACKET
					; DS:SI	-> buffer, CX =	length
					; Return: CF set on error, DH =	error code
					; CF clear if successful
		jmp	short loc_1541B
; ---------------------------------------------------------------------------
		nop

loc_15418:				; CODE XREF: seg004:0191j
		jmp	short loc_1541B
; ---------------------------------------------------------------------------
		nop

loc_1541B:				; CODE XREF: seg004:0196j seg004:019Ej ...
		pop	es
		pop	ds
		clc
		retf
; ---------------------------------------------------------------------------
		cmp	cs:musicMode, 2
		jz	short loc_1544D
		nop
		nop
		nop
		cmp	cs:musicMode, 1
		jz	short loc_15446
		nop
		nop
		nop
		cmp	cs:musicMode, 0
		jz	short loc_15443
		nop
		nop
		nop
		jmp	short loc_15450
; ---------------------------------------------------------------------------
		nop

loc_15443:				; CODE XREF: seg004:01CBj
		jmp	short loc_15450
; ---------------------------------------------------------------------------
		nop

loc_15446:				; CODE XREF: seg004:01C0j
		mov	ah, 19h
		int	60h		; - FTP	Packet Driver -	EXTENDED FUNC -	SET NETWORK ADDRESS
					; ES:DI	-> address, CX = length	of address
					; Return: CF set on error, DH =	error code (0Dh,0Eh)
					; CF clear if successful, CX = length
		jmp	short loc_15450
; ---------------------------------------------------------------------------
		nop

loc_1544D:				; CODE XREF: seg004:01B5j
		jmp	short loc_15450
; ---------------------------------------------------------------------------
		nop

loc_15450:				; CODE XREF: seg004:01D0j
					; seg004:loc_15443j ...
		clc
		retn
; ---------------------------------------------------------------------------
		cmp	cs:musicMode, 2
		jz	short loc_15485
		nop
		nop
		nop
		cmp	cs:musicMode, 1
		jz	short loc_1547E
		nop
		nop
		nop
		cmp	cs:musicMode, 0
		jz	short loc_15476
		nop
		nop
		nop
		jmp	short loc_15488
; ---------------------------------------------------------------------------
		nop

loc_15476:				; CODE XREF: seg004:01FEj
		mov	ax, 0Ch
		int	7Eh		; not used
		jmp	short loc_15488
; ---------------------------------------------------------------------------
		nop

loc_1547E:				; CODE XREF: seg004:01F3j
		mov	ah, 1
; ---------------------------------------------------------------------------

loc_15480:
		int	60h
		jmp	short loc_15488
; ---------------------------------------------------------------------------
		nop

loc_15485:
		jmp	short loc_15488
; ---------------------------------------------------------------------------
		nop

loc_15488:				; CODE XREF: seg004:0212j
					; seg004:loc_15485j
		clc
		retf
; ---------------------------------------------------------------------------
		align 4
musicMode	dw 0			; DATA XREF: sub_15293+17w
					; sub_15293:loc_152BBw	...
seg004		ends

; ===========================================================================

; Segment type:	Pure code
seg005		segment	byte public 'CODE' use16
		assume cs:seg005
		;org 0Eh
		assume es:nothing, ss:nothing, ds:dseg,	fs:nothing, gs:nothing

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1548E	proc far		; CODE XREF: sub_1566E+A3Fp
					; sub_1566E+A5Cp ...

arg_0		= word ptr  6
arg_2		= word ptr  8
arg_4		= word ptr  0Ah
arg_6		= word ptr  0Ch
arg_8		= word ptr  0Eh
arg_A		= word ptr  10h

		push	bp
		mov	bp, sp
		push	si
		push	di
		mov	ax, [bp+arg_4]
		dec	ax
		mov	si, ax
		mov	dx, 0Ah
		imul	dx
		mov	si, ax
		xor	di, di
		jmp	loc_15547
; ---------------------------------------------------------------------------

loc_154A5:				; CODE XREF: sub_1548E+BEj
		xor	ax, ax
		push	ax
		mov	ax, [bp+arg_8]
		inc	ax
		push	ax
		mov	ax, [bp+arg_6]
		add	ax, si
		inc	ax
		push	ax
		xor	ax, ax
		mov	dx, 0Ah
		push	ax
		push	dx
		push	[bp+arg_2]
		push	[bp+arg_0]
		call	sub_12C7D
		add	ax, 30h	; '0'
		push	ax
		call	sub_13D49
		add	sp, 8
		push	[bp+arg_A]
		push	[bp+arg_8]
		mov	ax, [bp+arg_6]
		add	ax, si
		inc	ax
		push	ax
		xor	ax, ax
		mov	dx, 0Ah
		push	ax
		push	dx
		push	[bp+arg_2]
		push	[bp+arg_0]
		call	sub_12C7D
		add	ax, 30h	; '0'
		push	ax
		call	sub_13D49
		add	sp, 8
		push	[bp+arg_A]
		push	[bp+arg_8]
		mov	ax, [bp+arg_6]
		add	ax, si
		push	ax
		xor	ax, ax
		mov	dx, 0Ah
		push	ax
		push	dx
		push	[bp+arg_2]
		push	[bp+arg_0]
		call	sub_12C7D
		add	ax, 30h	; '0'
		push	ax
		call	sub_13D49
		add	sp, 8
		xor	ax, ax
		mov	dx, 0Ah
		push	ax
		push	dx
		push	[bp+arg_2]
		push	[bp+arg_0]
		call	sub_12C6D
		mov	[bp+arg_0], ax
		mov	[bp+arg_2], dx
		mov	ax, si
		add	ax, 0FFF6h
		mov	si, ax
		inc	di

loc_15547:				; CODE XREF: sub_1548E+14j
		cmp	di, [bp+arg_4]
		jge	short loc_1554F
		jmp	loc_154A5
; ---------------------------------------------------------------------------

loc_1554F:				; CODE XREF: sub_1548E+BCj
		pop	di
		pop	si
		pop	bp
		retf
sub_1548E	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_15553	proc far		; CODE XREF: sub_1566E+A22p
					; sub_1566E+A74p

var_2		= byte ptr -2
var_1		= byte ptr -1
arg_0		= dword	ptr  6
arg_4		= word ptr  0Ah
arg_6		= word ptr  0Ch
arg_8		= word ptr  0Eh

		push	bp
		mov	bp, sp
		dec	sp
		dec	sp
		push	si
		push	di
		mov	di, [bp+arg_4]
		xor	si, si
		jmp	loc_15625
; ---------------------------------------------------------------------------

loc_15562:				; CODE XREF: sub_15553+DBj
		les	bx, [bp+arg_0]
		mov	al, es:[bx+si]
		mov	[bp+var_1], al
		mov	al, es:[bx+si+1]
		mov	[bp+var_2], al
		cmp	[bp+var_1], 81h	; ''
		jb	short loc_1557E
		cmp	[bp+var_1], 9Fh	; 'Ÿ'
		jbe	short loc_1558A

loc_1557E:				; CODE XREF: sub_15553+23j
		cmp	[bp+var_1], 0E0h ; 'à'
		jb	short loc_155F4
		cmp	[bp+var_1], 0FCh ; 'ü'
		ja	short loc_155F4

loc_1558A:				; CODE XREF: sub_15553+29j
		cmp	[bp+var_2], 40h	; '@'
		jb	short loc_15596
		cmp	[bp+var_2], 7Eh	; '~'
		jbe	short loc_155A2

loc_15596:				; CODE XREF: sub_15553+3Bj
		cmp	[bp+var_2], 80h	; '€'
		jb	short loc_155F4
		cmp	[bp+var_2], 0FCh ; 'ü'
		ja	short loc_155F4

loc_155A2:				; CODE XREF: sub_15553+41j
		push	[bp+arg_8]
		push	[bp+arg_6]
		push	di
		les	bx, [bp+arg_0]
		mov	al, es:[bx+si]
		mov	ah, 0
		mov	cl, 8
		shl	ax, cl
		mov	dl, es:[bx+si+1]
		mov	dh, 0
		add	ax, dx
		push	ax
		call	sub_1315E
		add	sp, 8
		push	[bp+arg_8]
		push	[bp+arg_6]
		mov	ax, di
		inc	ax
		push	ax
		les	bx, [bp+arg_0]
		mov	al, es:[bx+si]
		mov	ah, 0
		mov	cl, 8
		shl	ax, cl
		mov	dl, es:[bx+si+1]
		mov	dh, 0
		add	ax, dx
		push	ax
		call	sub_1315E
		add	sp, 8
		add	di, 10h
		inc	si
		inc	si
		jmp	short loc_15625
; ---------------------------------------------------------------------------

loc_155F4:				; CODE XREF: sub_15553+2Fj
					; sub_15553+35j ...
		push	[bp+arg_8]
		push	[bp+arg_6]
		push	di
		mov	al, [bp+var_1]
		mov	ah, 0
		push	ax
		call	sub_13D49
		add	sp, 8
		push	[bp+arg_8]
		push	[bp+arg_6]
		mov	ax, di
		inc	ax
		push	ax
		mov	al, [bp+var_1]
		mov	ah, 0
		push	ax
		call	sub_13D49
		add	sp, 8
		add	di, 8
		inc	si

loc_15625:				; CODE XREF: sub_15553+Cj
					; sub_15553+9Fj
		les	bx, [bp+arg_0]
		cmp	byte ptr es:[bx+si], 0
		jz	short loc_15631
		jmp	loc_15562
; ---------------------------------------------------------------------------

loc_15631:				; CODE XREF: sub_15553+D9j
		pop	di
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_15553	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

LoadVDF		proc far		; CODE XREF: sub_1566E+406p
					; sub_1566E+4C3p ...

arg_0		= word ptr  6
arg_2		= word ptr  8

		push	bp
		mov	bp, sp
		push	word ptr dword_192E2+2
		push	word ptr dword_192E2
		push	[bp+arg_2]
		push	[bp+arg_0]
		call	sub_15274
		add	sp, 8
		cmp	ax, 0FFFFh
		jnz	short loc_1565D
		mov	dx, 0FFFFh
		mov	ax, 0FFFFh
		jmp	short loc_1566C
; ---------------------------------------------------------------------------

loc_1565D:				; CODE XREF: LoadVDF+1Cj
		push	word ptr dword_192E2+2
		push	word ptr dword_192E2
		call	LoadGraphics1
		pop	cx
		pop	cx

loc_1566C:				; CODE XREF: LoadVDF+24j
		pop	bp
		retf
LoadVDF		endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1566E	proc far		; CODE XREF: start+E3P

var_D9		= byte ptr -0D9h
var_CC		= byte ptr -0CCh
var_A4		= byte ptr -0A4h
var_98		= byte ptr -98h
var_18		= word ptr -18h
var_16		= word ptr -16h
var_14		= word ptr -14h
var_12		= word ptr -12h
var_10		= word ptr -10h
var_E		= word ptr -0Eh
var_C		= byte ptr -0Ch
var_B		= byte ptr -0Bh
var_A		= word ptr -0Ah
var_8		= word ptr -8
var_6		= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2

		push	bp
		mov	bp, sp
		sub	sp, 0CCh
		push	si
		push	di
		push	ss
		lea	ax, [bp+var_A4]
		push	ax
		push	ds
		mov	ax, offset aConfig_nsd ; "Config.nsd"
		push	ax
		mov	cx, 0Bh
		call	memcpy
		push	ss
		lea	ax, [bp+var_CC]
		push	ax
		push	ds
		mov	ax, offset aFile1_nsd ;	"FILE1.NSD"
		push	ax
		mov	cx, 27h
		call	memcpy
		push	ds
		mov	ax, offset a2j1h ; "\x1B[2J\x1B[>1h"
		push	ax
		call	DoPrintThing
		pop	cx
		pop	cx
		call	sub_1450C
		call	sub_135AE
		xor	ax, ax
		push	ax
		call	sub_133B0
		pop	cx
		xor	ax, ax
		push	ax
		push	ax
		call	sub_13229
		pop	cx
		pop	cx
		call	SetupInt0A
		call	DetectMusicDriver
		mov	dx, 100
		mov	al, 0
		out	dx, al		; 8042 keyboard	controller command register.
		xor	ax, ax
		xor	dx, dx
		push	ax
		push	dx
		call	sub_1112B
		pop	cx
		pop	cx
		push	ax
		call	sub_10F1C
		pop	cx
		xor	si, si
		jmp	short loc_156FD
; ---------------------------------------------------------------------------

loc_156EF:				; CODE XREF: sub_1566E+92j
		mov	bx, si
		shl	bx, 1
		lea	ax, [bp+var_98]
		add	bx, ax
		mov	ss:[bx], si
		inc	si

loc_156FD:				; CODE XREF: sub_1566E+7Fj
		cmp	si, 40h	; '@'
		jl	short loc_156EF
		xor	si, si
		jmp	short loc_15757
; ---------------------------------------------------------------------------

loc_15706:				; CODE XREF: sub_1566E+ECj
		xor	ax, ax
		mov	dx, 8000h
		push	ax
		push	dx
		call	sub_10F2D
		cwd
		mov	cl, 6
		call	sub_12D14
		push	dx
		push	ax
		call	sub_12C66
		mov	[bp+var_2], ax
		mov	bx, si
		shl	bx, 1
		lea	ax, [bp+var_98]
		add	bx, ax
		mov	di, ss:[bx]
		mov	bx, [bp+var_2]
		shl	bx, 1
		add	bx, ax
		mov	ax, ss:[bx]
		mov	bx, si
		shl	bx, 1
		lea	dx, [bp+var_98]
		add	bx, dx
		mov	ss:[bx], ax
		mov	bx, [bp+var_2]
		shl	bx, 1
		lea	ax, [bp+var_98]
		add	bx, ax
		mov	ss:[bx], di
		inc	si

loc_15757:				; CODE XREF: sub_1566E+96j
		cmp	si, 40h	; '@'
		jl	short loc_15706
		mov	[bp+var_12], 0
		mov	ax, 1
		xor	dx, dx
		push	ax
		push	dx
		call	sub_12A7E
		pop	cx
		pop	cx
		mov	word ptr dword_192E2, ax
		mov	word ptr dword_192E2+2,	dx
		or	ax, dx
		jnz	short loc_1577D
		jmp	loc_161CC
; ---------------------------------------------------------------------------

loc_1577D:				; CODE XREF: sub_1566E+10Aj
		xor	si, si
		jmp	short loc_157A5
; ---------------------------------------------------------------------------

loc_15781:				; CODE XREF: sub_1566E+13Aj
		xor	ax, ax
		mov	dx, 7D00h
		push	ax
		push	dx
		call	sub_12A7E
		pop	cx
		pop	cx
		mov	bx, si
		shl	bx, 1
		shl	bx, 1
		mov	word_192D2[bx],	ax
		mov	word_192D4[bx],	dx
		or	ax, dx
		jnz	short loc_157A4
		jmp	loc_161CC
; ---------------------------------------------------------------------------

loc_157A4:				; CODE XREF: sub_1566E+131j
		inc	si

loc_157A5:				; CODE XREF: sub_1566E+111j
		cmp	si, 4
		jl	short loc_15781
		push	ds
		mov	ax, offset aRb	; "rb"
		push	ax
		push	ds
		mov	ax, offset aConfig_nsd_0 ; "Config.nsd"
		push	ax
		call	fopen
		add	sp, 8
		mov	[bp+var_18], ax
		mov	[bp+var_16], dx
		or	ax, dx
		jnz	short loc_157C9
		jmp	loc_16180
; ---------------------------------------------------------------------------

loc_157C9:				; CODE XREF: sub_1566E+156j
		push	[bp+var_16]
		push	[bp+var_18]
		mov	ax, 1F4h
		push	ax
		mov	ax, 1
		push	ax
		push	word ptr dword_192E2+2
		push	word ptr dword_192E2
		call	sub_10924
		add	sp, 0Ch
		mov	di, ax
		push	[bp+var_16]
		push	[bp+var_18]
		call	sub_103E5
		pop	cx
		pop	cx
		les	bx, dword_192E2
		mov	al, es:[bx+27h]
		mov	ah, 0
		mov	si, ax
		mov	al, es:[bx+2Fh]
		mov	ah, 0
		mov	[bp+var_2], ax
		cmp	[bp+var_2], 0
		jnz	short loc_15814
		jmp	loc_16180
; ---------------------------------------------------------------------------

loc_15814:				; CODE XREF: sub_1566E+1A1j
		les	bx, dword_192E2
		mov	word ptr es:[bx+2Fh], 0
		push	ds
		mov	ax, offset aWb	; "wb"
		push	ax
		push	ds
		mov	ax, offset aConfig_nsd_1 ; "Config.nsd"
		push	ax
		call	fopen
		add	sp, 8
		mov	[bp+var_18], ax
		mov	[bp+var_16], dx
		or	ax, dx
		jnz	short loc_1583D
		jmp	loc_16180
; ---------------------------------------------------------------------------

loc_1583D:				; CODE XREF: sub_1566E+1CAj
		push	[bp+var_16]
		push	[bp+var_18]
		push	di
		mov	ax, 1
		push	ax
		push	word ptr dword_192E2+2
		push	word ptr dword_192E2
		call	sub_10B08
		add	sp, 0Ch
		push	[bp+var_16]
		push	[bp+var_18]
		call	sub_103E5
		pop	cx
		pop	cx
		push	si
		call	sub_15293
		pop	cx
		mov	ax, 3
		push	ax
		push	ds
		mov	ax, offset byte_18B0A
		push	ax
		call	sub_141A3
		add	sp, 6
		call	sub_131FF
		mov	ax, 4
		push	ax
		mov	ax, 20h	; ' '
		push	ax
		mov	ax, 18h
		push	ax
		mov	ax, 4Fh	; 'O'
		push	ax
		xor	ax, ax
		push	ax
		push	ax
		call	sub_13707
		add	sp, 0Ch
		mov	ax, 1
		push	ax
		mov	ax, 20h	; ' '
		push	ax
		mov	ax, 15h
		push	ax
		mov	ax, 4Fh	; 'O'
		push	ax
		mov	ax, 2
		push	ax
		xor	ax, ax
		push	ax
		call	sub_13707
		add	sp, 0Ch
		mov	ax, 2000
		push	ax
		call	sub_12E3F
		pop	cx
		mov	[bp+var_6], 0
		call	sub_14197
		xor	si, si

loc_158D3:				; CODE XREF: sub_1566E+5FEj
		call	sub_14197
		mov	[bp+var_2], ax
		cmp	[bp+var_2], 3
		jge	short loc_158FA
		xor	di, di
		jmp	short loc_158EB
; ---------------------------------------------------------------------------

loc_158E5:				; CODE XREF: sub_1566E+285j
		call	sub_13243
		inc	di

loc_158EB:				; CODE XREF: sub_1566E+275j
		mov	ax, [bp+var_2]
		add	ax, di
		cmp	ax, 3
		jl	short loc_158E5
		call	sub_14197

loc_158FA:				; CODE XREF: sub_1566E+271j
		mov	ax, 3
		push	ax
		mov	ax, 200h
		push	ax
		mov	ax, 80h	; '€'
		push	ax
		call	sub_13F0B
		add	sp, 6
		cmp	[bp+var_12], 0
		jnz	short loc_15917
		jmp	loc_15A27
; ---------------------------------------------------------------------------

loc_15917:				; CODE XREF: sub_1566E+2A4j
		mov	bx, [bp+var_14]
		shl	bx, 1
		lea	ax, [bp+var_98]
		add	bx, ax
		mov	ax, ss:[bx]
		mov	[bp+var_4], ax
		cmp	[bp+var_12], 0C9h
		jle	short loc_15998
		mov	bx, [bp+var_12]
		shl	bx, 1
		shl	bx, 1
		mov	ax, word ptr (byte_18ADA+8)[bx]
		mov	[bp+var_2], ax
		mov	bx, [bp+var_12]
		shl	bx, 1
		shl	bx, 1
		mov	di, word ptr (byte_18ADA+0Ah)[bx]
		push	[bp+var_4]
		xor	ax, ax
		push	ax
		mov	ax, 200
		push	ax
		mov	ax, 320
		push	ax
		push	di
		push	[bp+var_2]
		call	sub_1435F
		add	sp, 0Ch
		push	[bp+var_4]
		mov	ax, 1
		push	ax
		mov	ax, 200
		push	ax
		mov	ax, 320
		push	ax
		push	di
		push	[bp+var_2]
		call	sub_1435F
		add	sp, 0Ch
		push	[bp+var_4]
		mov	ax, 2
		push	ax
		mov	ax, 200
		push	ax
		mov	ax, 320
		push	ax
		push	di
		push	[bp+var_2]
		call	sub_1435F
		add	sp, 0Ch

loc_15998:				; CODE XREF: sub_1566E+2BFj
		mov	bx, [bp+var_12]
		shl	bx, 1
		shl	bx, 1
		mov	ax, word ptr (byte_18ADA+0Ch)[bx]
		mov	[bp+var_2], ax
		mov	bx, [bp+var_12]
		shl	bx, 1
		shl	bx, 1
		mov	di, word ptr (byte_18ADA+0Eh)[bx]
		push	[bp+var_4]
		xor	ax, ax
		push	ax
		push	word_192D4
		push	word_192D2
		mov	ax, 200
		push	ax
		mov	ax, 320
		push	ax
		push	di
		push	[bp+var_2]
		call	sub_142D2
		add	sp, 10h
		push	[bp+var_4]
		mov	ax, 1
		push	ax
		push	word_192D8
		push	word_192D6
		mov	ax, 200
		push	ax
		mov	ax, 320
		push	ax
		push	di
		push	[bp+var_2]
		call	sub_142D2
		add	sp, 10h
		push	[bp+var_4]
		mov	ax, 2
		push	ax
		push	word_192DC
		push	word_192DA
		mov	ax, 200
		push	ax
		mov	ax, 320
		push	ax
		push	di
		push	[bp+var_2]
		call	sub_142D2
		add	sp, 10h
		inc	[bp+var_14]
		cmp	[bp+var_14], 40h ; '@'
		jl	short loc_15A27
		mov	[bp+var_12], 0

loc_15A27:				; CODE XREF: sub_1566E+2A6j
					; sub_1566E+3B2j
		mov	ax, si
		mov	bx, 20h
		cwd
		idiv	bx
		or	dx, dx
		jz	short loc_15A36
		jmp	loc_15C6B
; ---------------------------------------------------------------------------

loc_15A36:				; CODE XREF: sub_1566E+3C3j
		mov	bx, [bp+var_6]
		shl	bx, 1
		mov	di, word_18524[bx]
		cmp	di, 0FFh
		jnz	short loc_15A48
		jmp	loc_15C6F
; ---------------------------------------------------------------------------

loc_15A48:				; CODE XREF: sub_1566E+3D5j
		cmp	di, 100
		jg	short loc_15A50
		jmp	loc_15B04
; ---------------------------------------------------------------------------

loc_15A50:				; CODE XREF: sub_1566E+3DDj
		cmp	di, 200
		jle	short loc_15A59
		jmp	loc_15B04
; ---------------------------------------------------------------------------

loc_15A59:				; CODE XREF: sub_1566E+3E6j
		mov	ax, 1
		push	ax
		xor	ax, ax
		push	ax
		call	sub_13229
		pop	cx
		pop	cx
		push	ds
		mov	ax, di
		mov	dx, 0Dh
		imul	dx
		add	ax, offset aStff_101_vdf-(101*0Dh) ; "STFF_101.VDF"
		push	ax
		push	cs
		call	near ptr LoadVDF ; load	STFF_1xx.VDF
		pop	cx
		pop	cx
		cmp	dx, 0FFFFh
		jnz	short loc_15A86
		cmp	ax, 0FFFFh
		jnz	short loc_15A86
		jmp	loc_161CC
; ---------------------------------------------------------------------------

loc_15A86:				; CODE XREF: sub_1566E+40Ej
					; sub_1566E+413j
		mov	ax, 24
		push	ax
		mov	bx, di
		shl	bx, 1
		push	word ptr (stff1_widths-(101*2))[bx]
		xor	ax, ax
		push	ax
		push	ax
		push	word ptr dword_192E2+2
		push	word ptr dword_192E2
		call	sub_13E6D
		add	sp, 0Ch
		mov	ax, 3
		push	ax
		mov	ax, 24
		push	ax
		mov	bx, di
		shl	bx, 1
		push	word ptr (stff1_widths-(101*2))[bx]
		xor	ax, ax
		push	ax
		push	ax
		call	sub_13DDB
		add	sp, 0Ah
		xor	ax, ax
		push	ax
		push	ax
		call	sub_13229
		pop	cx
		pop	cx
		mov	ax, 24
		push	ax
		mov	bx, di
		shl	bx, 1
		push	word ptr (stff1_widths-(101*2))[bx]
		mov	ax, 359
		push	ax
		mov	bx, di
		shl	bx, 1
		mov	ax, word ptr (stff1_widths-(101*2))[bx]

loc_15AE5:				; CODE XREF: sub_1566E+5F4j
		mov	bx, 2
		cwd
		idiv	bx
		mov	dx, 320
		sub	dx, ax
		push	dx
		push	word ptr dword_192E2+2
		push	word ptr dword_192E2
		call	sub_13EAD
		add	sp, 0Ch
		jmp	loc_15C68
; ---------------------------------------------------------------------------

loc_15B04:				; CODE XREF: sub_1566E+3DFj
					; sub_1566E+3E8j
		cmp	di, 200
		jg	short loc_15B0D
		jmp	loc_15BB8
; ---------------------------------------------------------------------------

loc_15B0D:				; CODE XREF: sub_1566E+49Aj
		cmp	di, 250
		jle	short loc_15B16
		jmp	loc_15BB8
; ---------------------------------------------------------------------------

loc_15B16:				; CODE XREF: sub_1566E+4A3j
		mov	ax, 1
		push	ax
		xor	ax, ax
		push	ax
		call	sub_13229
		pop	cx
		pop	cx
		push	ds
		mov	ax, di
		mov	dx, 0Dh
		imul	dx
		add	ax, offset aC01_end_vdf-(201*0Dh) ; "C01_END.VDF"
		push	ax
		push	cs
		call	near ptr LoadVDF ; load	Cxx_END.VDF
		pop	cx
		pop	cx
		cmp	dx, 0FFFFh
		jnz	short loc_15B43
		cmp	ax, 0FFFFh
		jnz	short loc_15B43
		jmp	loc_161CC
; ---------------------------------------------------------------------------

loc_15B43:				; CODE XREF: sub_1566E+4CBj
					; sub_1566E+4D0j
		xor	ax, ax
		push	ax
		push	word_192D4
		push	word_192D2
		mov	ax, 200
		push	ax
		mov	ax, 320
		push	ax
		xor	ax, ax
		push	ax
		push	ax
		call	sub_14206
		add	sp, 0Eh
		mov	ax, 1
		push	ax
		push	word_192D8
		push	word_192D6
		mov	ax, 200
		push	ax
		mov	ax, 320
		push	ax
		xor	ax, ax
		push	ax
		push	ax
		call	sub_14206
		add	sp, 0Eh
		mov	ax, 2
		push	ax
		push	word_192DC
		push	word_192DA
		mov	ax, 200
		push	ax
		mov	ax, 320
		push	ax
		xor	ax, ax
		push	ax
		push	ax
		call	sub_14206
		add	sp, 0Eh
		xor	ax, ax
		push	ax
		push	ax
		call	sub_13229
		pop	cx
		pop	cx
		mov	[bp+var_14], 0
		mov	[bp+var_12], di
		jmp	loc_15C65
; ---------------------------------------------------------------------------

loc_15BB8:				; CODE XREF: sub_1566E+49Cj
					; sub_1566E+4A5j
		or	di, di
		jnz	short loc_15BBF
		jmp	loc_15C65
; ---------------------------------------------------------------------------

loc_15BBF:				; CODE XREF: sub_1566E+54Cj
		dec	di
		mov	ax, 1
		push	ax
		xor	ax, ax
		push	ax
		call	sub_13229
		pop	cx
		pop	cx
		push	ds
		mov	ax, di
		mov	dx, 0Dh
		imul	dx
		add	ax, offset aStff_001_vdf ; "STFF_001.VDF"
		push	ax
		push	cs
		call	near ptr LoadVDF ; load	STFF_0xx.VDF
		pop	cx
		pop	cx
		cmp	dx, 0FFFFh
		jnz	short loc_15BED
		cmp	ax, 0FFFFh
		jnz	short loc_15BED
		jmp	loc_161CC
; ---------------------------------------------------------------------------

loc_15BED:				; CODE XREF: sub_1566E+575j
					; sub_1566E+57Aj
		mov	bx, di
		shl	bx, 1
		push	stff0_heights[bx]
		mov	bx, di
		shl	bx, 1
		push	stff0_widths[bx]
		xor	ax, ax
		push	ax
		push	ax
		push	word ptr dword_192E2+2
		push	word ptr dword_192E2
		call	sub_13E6D
		add	sp, 0Ch
		mov	ax, 3
		push	ax
		mov	bx, di
		shl	bx, 1
		push	stff0_heights[bx]
		mov	bx, di
		shl	bx, 1
		push	stff0_widths[bx]
		xor	ax, ax
		push	ax
		push	ax
		call	sub_13DDB
		add	sp, 0Ah
		xor	ax, ax
		push	ax
		push	ax
		call	sub_13229
		pop	cx
		pop	cx
		mov	bx, di
		shl	bx, 1
		mov	ax, stff0_heights[bx]
		dec	ax
		push	ax
		mov	bx, di
		shl	bx, 1
		push	stff0_widths[bx]
		mov	bx, di
		shl	bx, 1
		mov	ax, 398
		sub	ax, stff0_heights[bx]
		push	ax
		mov	bx, di
		shl	bx, 1
		mov	ax, stff0_widths[bx]
		jmp	loc_15AE5
; ---------------------------------------------------------------------------

loc_15C65:				; CODE XREF: sub_1566E+547j
					; sub_1566E+54Ej
		add	si, 8

loc_15C68:				; CODE XREF: sub_1566E+493j
		inc	[bp+var_6]

loc_15C6B:				; CODE XREF: sub_1566E+3C5j
		inc	si
		jmp	loc_158D3
; ---------------------------------------------------------------------------

loc_15C6F:				; CODE XREF: sub_1566E+3D7j
		mov	ax, 5000
		push	ax
		call	sub_12E3F
		pop	cx
		mov	ax, 6
		push	ax
		push	ds
		mov	ax, offset byte_18B3A
		push	ax
		call	sub_141A3
		add	sp, 6
		mov	ax, 1
		push	ax
		mov	ax, 20h	; ' '
		push	ax
		mov	ax, 18h
		push	ax
		mov	ax, 4Fh	; 'O'
		push	ax
		mov	ax, 2
		push	ax
		xor	ax, ax
		push	ax
		call	sub_13707
		add	sp, 0Ch
		mov	ax, 1000
		push	ax
		call	sub_12E3F
		pop	cx
		xor	ax, ax
		push	ax
		mov	ax, 3
		push	ax
		call	sub_13DB8
		pop	cx
		pop	cx
		xor	ax, ax
		push	ax
		push	ds
		mov	ax, 26DAh
		push	ax
		call	sub_141A3
		add	sp, 6
		mov	ax, 1
		push	ax
		xor	ax, ax
		push	ax
		call	sub_13229
		pop	cx
		pop	cx
		push	ds
		mov	ax, offset aEarth01_vdf	; "EARTH01.VDF"
		push	ax
		push	cs
		call	near ptr LoadVDF ; load	EARTH01.VDF
		pop	cx
		pop	cx
		mov	[bp+var_10], ax
		mov	[bp+var_E], dx
		xor	ax, ax
		push	ax
		push	word_192D4
		push	word_192D2
		mov	ax, 400
		push	ax
		mov	ax, 640
		push	ax
		xor	ax, ax
		push	ax
		push	ax
		call	sub_14206
		add	sp, 0Eh
		mov	ax, 1
		push	ax
		push	word_192D8
		push	word_192D6
		mov	ax, 400
		push	ax
		mov	ax, 640
		push	ax
		xor	ax, ax
		push	ax
		push	ax
		call	sub_14206
		add	sp, 0Eh
		mov	ax, 2
		push	ax
		push	word_192DC
		push	word_192DA
		mov	ax, 400
		push	ax
		mov	ax, 640
		push	ax
		xor	ax, ax
		push	ax
		push	ax
		call	sub_14206
		add	sp, 0Eh
		mov	ax, 3
		push	ax
		push	word_192E0
		push	word_192DE
		mov	ax, 400
		push	ax
		mov	ax, 640
		push	ax
		xor	ax, ax
		push	ax
		push	ax
		call	sub_14206
		add	sp, 0Eh
		xor	ax, ax
		push	ax
		push	ax
		call	sub_13229
		pop	cx
		pop	cx
		mov	ax, 6
		push	ax
		push	ds
		mov	ax, offset byte_18B9A
		push	ax
		call	sub_141A3
		add	sp, 6
		xor	si, si
		jmp	loc_15E49
; ---------------------------------------------------------------------------

loc_15D90:				; CODE XREF: sub_1566E+7E0j
		call	sub_13243
		mov	bx, si
		shl	bx, 1
		lea	ax, [bp+var_98]
		add	bx, ax
		push	word ptr ss:[bx]
		xor	ax, ax
		push	ax
		push	word_192D4
		push	word_192D2
		mov	ax, 400
		push	ax
		mov	ax, 640
		push	ax
		xor	ax, ax
		push	ax
		push	ax
		call	sub_142D2
		add	sp, 10h
		mov	bx, si
		shl	bx, 1
		lea	ax, [bp+var_98]
		add	bx, ax
		push	word ptr ss:[bx]
		mov	ax, 1
		push	ax
		push	word_192D8
		push	word_192D6
		mov	ax, 400
		push	ax
		mov	ax, 640
		push	ax
		xor	ax, ax
		push	ax
		push	ax
		call	sub_142D2
		add	sp, 10h
		mov	bx, si
		shl	bx, 1
		lea	ax, [bp+var_98]
		add	bx, ax
		push	word ptr ss:[bx]
		mov	ax, 2
		push	ax
		push	word_192DC
		push	word_192DA
		mov	ax, 400
		push	ax
		mov	ax, 640
		push	ax
		xor	ax, ax
		push	ax
		push	ax
		call	sub_142D2
		add	sp, 10h
		mov	bx, si
		shl	bx, 1
		lea	ax, [bp+var_98]
		add	bx, ax
		push	word ptr ss:[bx]
		mov	ax, 3
		push	ax
		push	word_192E0
		push	word_192DE
		mov	ax, 400
		push	ax
		mov	ax, 640
		push	ax
		xor	ax, ax
		push	ax
		push	ax
		call	sub_142D2
		add	sp, 10h
		inc	si

loc_15E49:				; CODE XREF: sub_1566E+71Fj
		cmp	si, 40h	; '@'
		jge	short loc_15E51
		jmp	loc_15D90
; ---------------------------------------------------------------------------

loc_15E51:				; CODE XREF: sub_1566E+7DEj
		mov	ax, 1
		push	ax
		xor	ax, ax
		push	ax
		call	sub_13229
		pop	cx
		pop	cx
		push	ds
		mov	ax, offset aBrk_c_vdf ;	"brk_c.vdf"
		push	ax
		push	cs
		call	near ptr LoadVDF ; load	brk_c.vdf
		pop	cx
		pop	cx
		mov	ax, 1
		push	ax
		mov	ax, 184
		push	ax
		mov	ax, 208
		push	ax
		xor	ax, ax
		push	ax
		push	ax
		push	word ptr dword_192E2+2
		push	word ptr dword_192E2
		call	sub_143D0
		add	sp, 0Eh
		xor	ax, ax
		push	ax
		call	sub_133B0
		pop	cx
		xor	ax, ax
		push	ax
		push	ax
		call	sub_13229
		pop	cx
		pop	cx
		xor	si, si
		jmp	short loc_15EC6
; ---------------------------------------------------------------------------

loc_15EA2:				; CODE XREF: sub_1566E+85Bj
		push	si
		mov	bx, si
		shl	bx, 1
		shl	bx, 1
		push	word_192D4[bx]
		push	word_192D2[bx]
		mov	ax, 400
		push	ax
		mov	ax, 640
		push	ax
		xor	ax, ax
		push	ax
		push	ax
		call	sub_14206
		add	sp, 0Eh
		inc	si

loc_15EC6:				; CODE XREF: sub_1566E+832j
		cmp	si, 4
		jl	short loc_15EA2
		mov	[bp+var_B], 1
		mov	[bp+var_C], 0
		call	sub_14197
		xor	ax, ax
		push	ax
		push	ax
		call	sub_13229
		pop	cx
		pop	cx
		mov	ax, 3000
		push	ax
		call	sub_12E3F
		pop	cx
		xor	si, si
		jmp	loc_15FE2
; ---------------------------------------------------------------------------

loc_15EF2:				; CODE XREF: sub_1566E+97Aj
		cmp	si, 250
		jl	short loc_15F28
		cmp	si, 290
		jge	short loc_15F28
		mov	ax, si
		mov	bx, 4
		cwd
		idiv	bx
		or	dx, dx
		jnz	short loc_15F28
		mov	ax, 2
		push	ax
		push	ds
		mov	ax, si
		add	ax, -250
		cwd
		idiv	bx
		mov	dx, 48
		imul	dx
		add	ax, offset byte_18C2A
		push	ax
		call	sub_141A3
		add	sp, 6

loc_15F28:				; CODE XREF: sub_1566E+888j
					; sub_1566E+88Ej ...
		cmp	si, 380
		jnz	short loc_15F3F
		mov	ax, 6
		push	ax
		push	ds
		mov	ax, offset byte_18ADA
		push	ax
		call	sub_141A3
		add	sp, 6

loc_15F3F:				; CODE XREF: sub_1566E+8BEj
		call	sub_14197
		mov	[bp+var_2], ax
		cmp	[bp+var_2], 8
		jge	short loc_15F66
		xor	di, di
		jmp	short loc_15F57
; ---------------------------------------------------------------------------

loc_15F51:				; CODE XREF: sub_1566E+8F1j
		call	sub_13243
		inc	di

loc_15F57:				; CODE XREF: sub_1566E+8E1j
		mov	ax, [bp+var_2]
		add	ax, di
		cmp	ax, 8
		jl	short loc_15F51
		call	sub_14197

loc_15F66:				; CODE XREF: sub_1566E+8DDj
		mov	al, [bp+var_B]
		mov	ah, 0
		push	ax
		mov	al, [bp+var_C]
		mov	ah, 0
		push	ax
		call	sub_13229
		pop	cx
		pop	cx
		mov	[bp+var_2], 0
		jmp	short loc_15FA9
; ---------------------------------------------------------------------------

loc_15F80:				; CODE XREF: sub_1566E+93Fj
		push	[bp+var_2]
		mov	bx, [bp+var_2]
		shl	bx, 1
		shl	bx, 1
		push	word_192D4[bx]
		push	word_192D2[bx]
		mov	ax, 400
		push	ax
		mov	ax, 640
		push	ax
		xor	ax, ax
		push	ax
		push	ax
		call	sub_1424A
		add	sp, 0Eh
		inc	[bp+var_2]

loc_15FA9:				; CODE XREF: sub_1566E+910j
		cmp	[bp+var_2], 4
		jl	short loc_15F80
		mov	ax, 184
		push	ax
		mov	ax, 208
		push	ax
		mov	ax, 160
		push	ax
		mov	ax, 432
		sub	ax, si
		push	ax
		push	word ptr dword_192E2+2
		push	word ptr dword_192E2
		call	sub_14490
		add	sp, 0Ch
		mov	al, [bp+var_B]
		xor	al, 1
		mov	[bp+var_B], al
		mov	al, [bp+var_C]
		xor	al, 1
		mov	[bp+var_C], al
		inc	si

loc_15FE2:				; CODE XREF: sub_1566E+881j
		cmp	si, 400
		jge	short loc_15FEB
		jmp	loc_15EF2
; ---------------------------------------------------------------------------

loc_15FEB:				; CODE XREF: sub_1566E+978j
		push	word ptr dword_192E2+2
		push	word ptr dword_192E2
		push	ss
		lea	ax, [bp+var_A4]
		push	ax
		call	sub_15274
		add	sp, 8
		les	bx, dword_192E2
		mov	si, es:[bx+21h]
		push	word ptr dword_192E2+2
		push	word ptr dword_192E2
		push	ss
		mov	ax, si
		mov	dx, 0Dh
		imul	dx
		lea	dx, [bp+var_D9]
		add	ax, dx
		push	ax
		call	sub_15274
		add	sp, 8
		les	bx, dword_192E2
		mov	di, es:[bx+0A0h]
		mov	si, es:[bx+0A2h]
		mov	ax, es:[bx+0A4h]
		mov	[bp+var_2], ax
		mov	ax, si
		cwd
		push	ax
		push	dx
		xor	dx, dx
		mov	ax, 0FFFFh
		pop	cx
		pop	bx
		call	sub_12C4C
		push	ax
		mov	ax, [bp+var_2]
		push	dx
		cwd
		pop	bx
		pop	cx
		add	cx, ax
		adc	bx, dx
		mov	[bp+var_A], cx
		mov	[bp+var_8], bx
		or	di, di
		jnz	short loc_1606A
		call	sub_161D5

loc_1606A:				; CODE XREF: sub_1566E+9F5j
		xor	ax, ax
		push	ax
		push	ax
		call	sub_13229
		pop	cx
		pop	cx
		xor	ax, ax
		push	ax
		call	sub_133B0
		pop	cx
		mov	ax, 0Fh
		push	ax
		mov	ax, 200
		push	ax
		mov	ax, 160
		push	ax
		push	ds
		mov	ax, offset aVrvgvpvtve ; "‚r‚ƒ‚‚’‚…"
		push	ax
		push	cs
		call	near ptr sub_15553
		add	sp, 0Ah
		mov	ax, 0Fh
		push	ax
		mov	ax, 200
		push	ax
		mov	ax, 360
		push	ax
		mov	ax, 0Ah
		push	ax
		push	[bp+var_8]
		push	[bp+var_A]
		push	cs
		call	near ptr sub_1548E
		add	sp, 0Ch
		mov	ax, 0Fh
		push	ax
		mov	ax, 200
		push	ax
		mov	ax, 460
		push	ax
		mov	ax, 2
		push	ax
		xor	ax, ax
		xor	dx, dx
		push	ax
		push	dx
		push	cs
		call	near ptr sub_1548E
		add	sp, 0Ch
		mov	ax, 0Fh
		push	ax
		mov	ax, 240
		push	ax
		mov	ax, 160
		push	ax
		push	ds
		mov	ax, offset aVbvpvxvovfvivo ; "‚b‚‚•‚Ž‚”‚‰‚Ž‚•‚…"
		push	ax
		push	cs
		call	near ptr sub_15553
		add	sp, 0Ah
		mov	ax, 0Fh
		push	ax
		mov	ax, 240
		push	ax
		mov	ax, 360
		push	ax
		mov	ax, 0Ch
		push	ax
		mov	ax, di
		cwd
		push	dx
		push	ax
		push	cs
		call	near ptr sub_1548E
		add	sp, 0Ch
		mov	ax, 3
		push	ax
		push	ds
		mov	ax, offset byte_18B0A
		push	ax
		call	sub_141A3
		add	sp, 6
		mov	ax, 3000
		push	ax
		call	sub_12E3F
		pop	cx
		call	sub_15395
		mov	ax, 2000
		push	ax
		call	sub_12E3F
		pop	cx
		mov	ax, 3
		push	ax
		push	ds
		mov	ax, offset byte_18ADA
		push	ax
		call	sub_141A3
		add	sp, 6
		mov	ax, 1000
		push	ax
		call	sub_12E3F
		pop	cx
		call	RestoreInt0A
		push	word ptr dword_192E2+2
		push	word ptr dword_192E2
		call	sub_1298E
		pop	cx
		pop	cx
		xor	si, si
		jmp	short loc_16177
; ---------------------------------------------------------------------------

loc_16161:				; CODE XREF: sub_1566E+B0Cj
		mov	bx, si
		shl	bx, 1
		shl	bx, 1
		push	word_192D4[bx]
		push	word_192D2[bx]
		call	sub_1298E
		pop	cx
		pop	cx
		inc	si

loc_16177:				; CODE XREF: sub_1566E+AF1j
		cmp	si, 4
		jl	short loc_16161
		xor	ax, ax
		jmp	short loc_161CF
; ---------------------------------------------------------------------------

loc_16180:				; CODE XREF: sub_1566E+158j
					; sub_1566E+1A3j ...
		call	RestoreInt0A
		mov	ax, word ptr dword_192E2
		or	ax, word ptr dword_192E2+2
		jz	short loc_1619D
		push	word ptr dword_192E2+2
		push	word ptr dword_192E2
		call	sub_1298E
		pop	cx
		pop	cx

loc_1619D:				; CODE XREF: sub_1566E+B1Ej
		xor	si, si
		jmp	short loc_161C7
; ---------------------------------------------------------------------------

loc_161A1:				; CODE XREF: sub_1566E+B5Cj
		mov	bx, si
		shl	bx, 1
		shl	bx, 1
		mov	ax, word_192D2[bx]
		or	ax, word_192D4[bx]
		jz	short loc_161C6
		mov	bx, si
		shl	bx, 1
		shl	bx, 1
		push	word_192D4[bx]
		push	word_192D2[bx]
		call	sub_1298E
		pop	cx
		pop	cx

loc_161C6:				; CODE XREF: sub_1566E+B41j
		inc	si

loc_161C7:				; CODE XREF: sub_1566E+B31j
		cmp	si, 4
		jl	short loc_161A1

loc_161CC:				; CODE XREF: sub_1566E+10Cj
					; sub_1566E+133j ...
		mov	ax, 0FFFFh

loc_161CF:				; CODE XREF: sub_1566E+B10j
		pop	di
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_1566E	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_161D5	proc far		; CODE XREF: sub_1566E+9F7P

var_52		= byte ptr -52h
var_2B		= byte ptr -2Bh
var_1E		= byte ptr -1Eh
var_18		= byte ptr -18h
var_10		= word ptr -10h
var_E		= word ptr -0Eh
var_C		= word ptr -0Ch
var_A		= word ptr -0Ah
var_8		= word ptr -8
var_6		= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2

		push	bp
		mov	bp, sp
		sub	sp, 52h
		push	si
		push	di
		push	ss
		lea	ax, [bp+var_52]
		push	ax
		push	ds
		mov	ax, offset aNo_con_a_vdf ; "NO_CON_A.VDF"
		push	ax
		mov	cx, 34h
		call	memcpy
		push	ss
		lea	ax, [bp+var_18]
		push	ax
		push	ds
		mov	ax, offset word_18E98
		push	ax
		mov	cx, 8
		call	memcpy
		push	ss
		lea	ax, [bp+var_1E]
		push	ax
		push	ds
		mov	ax, offset word_18EA0
		push	ax
		mov	cx, 6
		call	memcpy
		mov	ax, 20h
		push	ax
		call	sub_133E5
		pop	cx
		mov	ax, word ptr dword_192E2+2
		mov	dx, word ptr dword_192E2
		mov	[bp+var_C], dx
		mov	[bp+var_A], ax
		mov	ax, word ptr dword_192E2+2
		mov	dx, word ptr dword_192E2
		add	dx, 3FE8h
		mov	[bp+var_10], dx
		mov	[bp+var_E], ax
		xor	ax, ax
		push	ax
		call	sub_133B0
		pop	cx
		mov	ax, 1
		push	ax
		xor	ax, ax
		push	ax
		call	sub_13229
		pop	cx
		pop	cx
		xor	ax, ax
		push	ax
		call	sub_133B0
		pop	cx
		push	word ptr dword_192E2+2
		push	word ptr dword_192E2
		push	ss
		lea	ax, [bp+var_2B]
		push	ax
		call	sub_15274
		add	sp, 8
		push	word ptr dword_192E2+2
		push	word ptr dword_192E2
		call	LoadGraphics1
		pop	cx
		pop	cx
		mov	[bp+var_8], ax
		mov	[bp+var_6], dx
		xor	si, si
		jmp	short loc_162B4
; ---------------------------------------------------------------------------

loc_16289:				; CODE XREF: sub_161D5+E2j
		xor	ax, ax
		push	ax
		mov	ax, 10h
		push	ax
		push	ax
		xor	ax, ax
		push	ax
		mov	ax, si
		mov	cl, 4
		shl	ax, cl
		push	ax
		mov	ax, si
		mov	dx, 200
		imul	dx
		mov	dx, [bp+var_10]
		add	dx, ax
		push	[bp+var_E]
		push	dx
		call	sub_143D0
		add	sp, 0Eh
		inc	si

loc_162B4:				; CODE XREF: sub_161D5+B2j
		cmp	si, 6
		jl	short loc_16289
		xor	ax, ax
		push	ax
		push	ax
		call	sub_13229
		pop	cx
		pop	cx
		xor	di, di
		jmp	loc_16433
; ---------------------------------------------------------------------------

loc_162C9:				; CODE XREF: sub_161D5+263j
		mov	ax, 1
		push	ax
		xor	ax, ax
		push	ax
		call	sub_13229
		pop	cx
		pop	cx
		xor	ax, ax
		push	ax
		call	sub_133B0
		pop	cx
		push	word ptr dword_192E2+2
		push	word ptr dword_192E2
		push	ss
		mov	ax, di
		mov	dx, 0Dh
		imul	dx
		lea	dx, [bp+var_52]
		add	ax, dx
		push	ax
		call	sub_15274
		add	sp, 8
		push	word ptr dword_192E2+2
		push	word ptr dword_192E2
		call	LoadGraphics1
		pop	cx
		pop	cx
		mov	[bp+var_8], ax
		mov	[bp+var_6], dx
		mov	ax, 2
		push	ax
		push	[bp+var_6]
		push	[bp+var_8]
		call	sub_141C5
		add	sp, 6
		mov	[bp+var_2], 0
		jmp	loc_16414
; ---------------------------------------------------------------------------

loc_1632D:				; CODE XREF: sub_161D5+250j
		mov	ax, 1
		push	ax
		xor	ax, ax
		push	ax
		call	sub_13229
		pop	cx
		pop	cx
		xor	ax, ax
		push	ax
		mov	ax, 18h
		push	ax
		push	ax
		xor	ax, ax
		push	ax
		mov	ax, [bp+var_2]
		mov	dx, 18h
		imul	dx
		push	ax
		push	[bp+var_A]
		push	[bp+var_C]
		call	sub_143D0
		add	sp, 0Eh
		xor	ax, ax
		push	ax
		push	ax
		call	sub_13229
		pop	cx
		pop	cx
		xor	ax, ax
		push	ax
		mov	ax, 18h
		push	ax
		push	ax
		mov	ax, di
		mov	dx, 30h	; '0'
		imul	dx
		add	ax, 60h	; '`'
		push	ax
		mov	bx, di
		shl	bx, 1
		lea	ax, [bp+var_18]
		add	bx, ax
		mov	ax, [bp+var_2]
		mov	dx, 18h
		imul	dx
		add	ax, ss:[bx]
		push	ax
		push	[bp+var_A]
		push	[bp+var_C]
		call	sub_14490
		add	sp, 0Eh
		or	di, di
		jnz	short loc_16402
		cmp	[bp+var_2], 1
		jnz	short loc_16402
		xor	si, si
		jmp	short loc_163B2
; ---------------------------------------------------------------------------

loc_163AC:				; CODE XREF: sub_161D5+1E0j
		call	sub_13243
		inc	si

loc_163B2:				; CODE XREF: sub_161D5+1D5j
		cmp	si, 0Fh
		jl	short loc_163AC
		xor	si, si
		jmp	short loc_163FD
; ---------------------------------------------------------------------------

loc_163BB:				; CODE XREF: sub_161D5+22Bj
		mov	ax, 10h
		push	ax
		push	ax
		mov	ax, 52h	; 'R'
		push	ax
		mov	ax, si
		mov	dx, 0Ah
		imul	dx
		add	ax, 38h	; '8'
		push	ax
		mov	ax, si

loc_163D1:
		mov	dx, 0C8h ; 'È'
		imul	dx
		mov	dx, [bp+var_10]
		add	dx, ax
		push	[bp+var_E]
		push	dx
		call	sub_14490
		add	sp, 0Ch
		mov	[bp+var_4], 0
		jmp	short loc_163F6
; ---------------------------------------------------------------------------

loc_163EE:				; CODE XREF: sub_161D5+225j
		call	sub_13243
		inc	[bp+var_4]

loc_163F6:				; CODE XREF: sub_161D5+217j
		cmp	[bp+var_4], 0Fh
		jl	short loc_163EE
		inc	si

loc_163FD:				; CODE XREF: sub_161D5+1E4j
		cmp	si, 6
		jl	short loc_163BB

loc_16402:				; CODE XREF: sub_161D5+1CBj
					; sub_161D5+1D1j
		xor	si, si
		jmp	short loc_1640C
; ---------------------------------------------------------------------------

loc_16406:				; CODE XREF: sub_161D5+23Aj
		call	sub_13243
		inc	si

loc_1640C:				; CODE XREF: sub_161D5+22Fj
		cmp	si, 0Fh
		jl	short loc_16406
		inc	[bp+var_2]

loc_16414:				; CODE XREF: sub_161D5+155j
		mov	bx, di
		shl	bx, 1
		lea	ax, [bp+var_1E]
		add	bx, ax
		mov	ax, ss:[bx]
		cmp	ax, [bp+var_2]
		jle	short loc_16428
		jmp	loc_1632D
; ---------------------------------------------------------------------------

loc_16428:				; CODE XREF: sub_161D5+24Ej
		mov	ax, 1000
		push	ax
		call	sub_12E3F
		pop	cx
		inc	di

loc_16433:				; CODE XREF: sub_161D5+F1j
		cmp	di, 3
		jge	short loc_1643B
		jmp	loc_162C9
; ---------------------------------------------------------------------------

loc_1643B:				; CODE XREF: sub_161D5+261j
		mov	ax, 5000
		push	ax
		call	sub_12E3F
		pop	cx
		xor	di, di
		jmp	short loc_16452
; ---------------------------------------------------------------------------

loc_16449:				; CODE XREF: sub_161D5+280j
		les	bx, dword_192E2
		mov	byte ptr es:[bx+di], 0
		inc	di

loc_16452:				; CODE XREF: sub_161D5+272j
		cmp	di, 40h	; '@'
		jl	short loc_16449
		mov	ax, 3
		push	ax
		push	word ptr dword_192E2+2
		push	word ptr dword_192E2
		call	sub_141A3
		add	sp, 6
		mov	ax, 3000
		push	ax
		call	sub_12E3F
		pop	cx
		xor	ax, ax
		pop	di
		pop	si
		mov	sp, bp
		pop	bp
		retf
sub_161D5	endp

; ---------------------------------------------------------------------------
		align 4
seg005		ends

; ===========================================================================

; Segment type:	Regular
seg006		segment	byte public 'UNK' use16
		assume cs:seg006
		assume es:nothing, ss:nothing, ds:dseg,	fs:nothing, gs:nothing
byte_16480	db 0, 2			; DATA XREF: start+B5o
		dw offset loc_10F53
		dw 0
		db 0, 10h
		dw offset loc_12DED
		dw 0
byte_1648C	db 0, 0			; DATA XREF: sub_100EE+5o
		dw 0
seg006		ends

; ===========================================================================

; Segment type:	Pure data
dseg		segment	para public 'DATA' use16
		assume cs:dseg
word_16490	dw 0			; DATA XREF: sub_128BE+20r
					; sub_128BE:loc_12919r	...
word_16492	dw 0			; DATA XREF: sub_1285C+9r sub_1285C+Dr ...
word_16494	dw 7554h		; DATA XREF: sub_1292F+Cr
					; sub_12958+17w ...
word_16496	dw 6272h		; DATA XREF: sub_1292F+2r sub_1292F+8r ...
word_16498	dw 206Fh		; DATA XREF: sub_1285C+24r
					; sub_128BE+Dw	...
		db  43h	; C
		db  2Bh	; +
		db  2Bh	; +
		db  20h
off_1649E	dw offset sub_1202D	; DATA XREF: sub_12355+17r
aCopyright1990B	db 'Copyright 1990 Borland Intl.',0
aDivideError	db 'Divide error',0Dh,0Ah ; DATA XREF: seg000:0123o
aAbnormalProgra	db 'Abnormal program termination',0Dh,0Ah ; DATA XREF: start+1E7o
dword_164E9	dd 0			; DATA XREF: SetupInts+6w
					; RestoreInts+4r ...
dword_164ED	dd 0			; DATA XREF: SetupInts+13w
					; RestoreInts+Fr ...
dword_164F1	dd 0			; DATA XREF: SetupInts+20w
					; RestoreInts+1Ar ...
dword_164F5	dd 0			; DATA XREF: SetupInts+2Dw
					; RestoreInts+25r ...
word_164F9	dw 0			; DATA XREF: start:loc_100DFr
word_164FB	dw 0			; DATA XREF: start+DBr
word_164FD	dw 0			; DATA XREF: start+D7r
word_164FF	dw 0			; DATA XREF: start+D3r	seg000:2E3Bw
word_16501	dw 0			; DATA XREF: start+CFr	seg000:2E35w
dword_16503	dd 0			; DATA XREF: start+28r	start+43w ...
word_16507	dw 0			; DATA XREF: start+52w	seg000:2DF6r
word_16509	dw 0			; DATA XREF: start+19w	start+83r ...
word_1650B	dw 0			; DATA XREF: start+16w
word_1650D	dw 0			; DATA XREF: seg000:loc_1022Dw
					; sub_11AB8:loc_11AE9w
word_1650F	dw 0			; DATA XREF: sub_10339+7r
					; sub_10378+20r
word_16511	dw 0			; DATA XREF: start+7Bw	sub_10339+3r ...
word_16513	dw 0			; DATA XREF: sub_102B9+26w
					; sub_10378+Ar	...
word_16515	dw 0			; DATA XREF: start+7Fw	sub_102B9+2Aw ...
word_16517	dw 0			; DATA XREF: sub_102B9+6Fw
					; sub_10339+1Ar ...
word_16519	dw 0			; DATA XREF: start+21w	sub_102B9+36r ...
byte_1651B	db 0F01h dup(0)
word_1741C	dw 0A800h, 0B000h, 0B800h, 0E000h ; DATA XREF: sub_13DB8+7o
					; sub_13DDB+8o	...
byte_17424	db    0,   0,	0,   0,	  0,   0,   0,	 0,   0,   0,	0,   0,	  0,   0,   0,	 0
					; DATA XREF: sub_139A5+5o seg001:0E0Eo ...
		db  38h, 44h, 40h, 38h,	  4, 44h, 38h,	 0, 11h, 11h, 11h, 1Fh,	11h, 11h, 11h,	 0
		db  38h, 44h, 40h, 38h,	  4, 44h, 38h,	 0, 11h, 11h, 0Ah,   4,	0Ah, 11h, 11h,	 0
		db  7Ch, 40h, 40h, 78h,	40h, 40h, 7Ch,	 0, 11h, 11h, 0Ah,   4,	0Ah, 11h, 11h,	 0
		db  7Ch, 40h, 40h, 78h,	40h, 40h, 7Ch,	 0, 1Fh,   4,	4,   4,	  4,   4,   4,	 0
		db  7Ch, 40h, 40h, 78h,	40h, 40h, 7Ch,	 0, 0Eh, 11h, 11h, 11h,	15h, 12h, 0Dh,	 0
		db  10h, 28h, 44h, 7Ch,	44h, 44h, 44h,	 0, 11h, 12h, 14h, 18h,	14h, 12h, 11h,	 0
		db  78h, 44h, 44h, 78h,	44h, 44h, 78h,	 0, 10h, 10h, 10h, 10h,	10h, 10h, 1Fh,	 0
		db  78h, 44h, 44h, 78h,	44h, 44h, 78h,	 0, 0Eh, 11h, 10h, 0Eh,	  1, 11h, 0Eh,	 0
		db  44h, 44h, 44h, 7Ch,	44h, 44h, 44h,	 0, 1Fh,   4,	4,   4,	  4,   4,   4,	 0
		db  40h, 40h, 40h, 40h,	40h, 40h, 7Ch,	 0, 1Fh, 10h, 10h, 1Eh,	10h, 10h, 10h,	 0
		db  44h, 44h, 44h, 7Ch,	44h, 44h, 44h,	 0, 11h, 1Bh, 1Bh, 15h,	15h, 11h, 11h,	 0
		db  38h, 44h, 40h, 40h,	40h, 44h, 38h,	 0, 10h, 10h, 10h, 10h,	10h, 10h, 1Fh,	 0
		db  38h, 44h, 40h, 40h,	40h, 44h, 38h,	 0, 1Eh, 11h, 11h, 1Eh,	14h, 12h, 11h,	 0
		db  38h, 44h, 40h, 38h,	  4, 44h, 38h,	 0, 0Eh, 11h, 11h, 11h,	11h, 11h, 0Eh,	 0
		db  38h, 44h, 40h, 38h,	  4, 44h, 38h,	 0, 0Eh,   4,	4,   4,	  4,   4, 0Eh,	 0
		db  78h, 44h, 44h, 44h,	44h, 44h, 78h,	 0, 1Fh, 10h, 10h, 1Eh,	10h, 10h, 1Fh,	 0
		db  78h, 44h, 44h, 44h,	44h, 44h, 78h,	 0,   4, 0Ch,	4,   4,	  4,   4, 0Eh,	 0
		db  78h, 44h, 44h, 44h,	44h, 44h, 78h,	 0, 0Eh, 11h,	1,   2,	  4,   8, 1Fh,	 0
		db  78h, 44h, 44h, 44h,	44h, 44h, 78h,	 0, 0Eh, 11h,	1, 0Eh,	  1, 11h, 0Eh,	 0
		db  78h, 44h, 44h, 44h,	44h, 44h, 78h,	 0,   2,   4, 0Ah, 12h,	1Fh,   2,   2,	 0
		db  44h, 44h, 64h, 54h,	4Ch, 44h, 44h,	 0, 11h, 12h, 14h, 18h,	14h, 12h, 11h,	 0
		db  38h, 44h, 40h, 38h,	  4, 44h, 38h,	 0, 11h, 11h, 19h, 15h,	13h, 11h, 11h,	 0
		db  7Ch, 40h, 40h, 78h,	40h, 40h, 7Ch,	 0, 1Eh, 11h, 11h, 1Eh,	11h, 11h, 1Eh,	 0
		db  38h, 44h, 40h, 40h,	40h, 44h, 38h,	 0, 11h, 11h, 19h, 15h,	13h, 11h, 11h,	 0
		db  7Ch, 40h, 40h, 78h,	40h, 40h, 7Ch,	 0, 11h, 1Bh, 1Bh, 15h,	15h, 11h, 11h,	 0
		db  38h, 44h, 40h, 38h,	  4, 44h, 38h,	 0, 1Eh, 11h, 11h, 1Eh,	11h, 11h, 1Eh,	 0
		db  7Ch, 40h, 40h, 78h,	40h, 40h, 7Ch,	 0, 0Eh, 11h, 10h, 10h,	10h, 11h, 0Eh,	 0
		db    0,   0,	8,   8,	  4,   4, 7Eh,	 4,   4,   8,	8,   0,	  0,   0,   0,	 0
		db    0,   0, 10h, 10h,	20h, 20h, 7Eh, 20h, 20h, 10h, 10h,   0,	  0,   0,   0,	 0
		db    0,   0,	8,   8,	1Ch, 1Ch, 2Ah, 2Ah,   8,   8,	8,   8,	  8,   8,   0,	 0
		db    0,   0,	8,   8,	  8,   8,   8,	 8, 2Ah, 2Ah, 1Ch, 1Ch,	  8,   8,   0,	 0
		db    0,   0,	0,   0,	  0,   0,   0,	 0,   0,   0,	0,   0,	  0,   0,   0,	 0
		db    0,   0,	0, 10h,	10h, 10h, 10h, 10h, 10h, 10h,	0,   0,	10h, 10h,   0,	 0
		db    0,   0,	0, 36h,	36h, 12h, 24h,	 0,   0,   0,	0,   0,	  0,   0,   0,	 0
		db    0,   0,	0, 22h,	22h, 7Fh, 22h, 22h, 22h, 22h, 22h, 7Fh,	22h, 22h,   0,	 0
		db    0,   0,	8,   8,	3Eh, 49h, 49h, 48h, 3Eh,   9, 49h, 49h,	3Eh,   8,   8,	 0
		db    0,   0,	0, 20h,	50h, 51h, 22h,	 4,   8, 10h, 22h, 45h,	  5,   2,   0,	 0
		db    0,   0,	0, 38h,	44h, 44h, 44h, 28h, 10h, 28h, 45h, 42h,	46h, 39h,   0,	 0
		db    0,   0,	0, 18h,	18h,   8, 10h,	 0,   0,   0,	0,   0,	  0,   0,   0,	 0
		db    0,   0,	0,   2,	  4,   4,   8,	 8,   8,   8,	8,   4,	  4,   2,   0,	 0
		db    0,   0,	0, 20h,	10h, 10h,   8,	 8,   8,   8,	8, 10h,	10h, 20h,   0,	 0
		db    0,   0,	0,   0,	  0,   0,   8, 2Ah, 1Ch, 2Ah,	8,   0,	  0,   0,   0,	 0
		db    0,   0,	0,   0,	  0,   8,   8,	 8, 7Fh,   8,	8,   8,	  0,   0,   0,	 0
		db    0,   0,	0,   0,	  0,   0,   0,	 0,   0,   0,	0, 18h,	18h,   8, 10h,	 0
		db    0,   0,	0,   0,	  0,   0,   0,	 0, 7Fh,   0,	0,   0,	  0,   0,   0,	 0
		db    0,   0,	0,   0,	  0,   0,   0,	 0,   0,   0,	0,   0,	18h, 18h,   0,	 0
		db    0,   0,	0,   0,	  0,   1,   2,	 4,   8, 10h, 20h, 40h,	  0,   0,   0,	 0
		db    0,   0,	0, 3Eh,	43h, 43h, 45h, 45h, 49h, 51h, 51h, 61h,	61h, 3Eh,   0,	 0
		db    0,   0,	0,   8,	18h, 28h,   8,	 8,   8,   8,	8,   8,	  8, 1Ch,   0,	 0
		db    0,   0,	0, 1Ch,	22h, 41h, 41h,	 1,   6, 18h, 20h, 40h,	40h, 7Fh,   0,	 0
		db    0,   0,	0, 1Ch,	22h, 41h,   1,	 2, 1Ch,   2,	1, 41h,	22h, 1Ch,   0,	 0
		db    0,   0,	0,   2,	  6, 0Ah, 0Ah, 12h, 12h, 22h, 22h, 7Fh,	  2,   2,   0,	 0
		db    0,   0,	0, 7Eh,	40h, 40h, 40h, 5Ch, 62h,   1,	1, 41h,	22h, 1Ch,   0,	 0
		db    0,   0,	0, 1Ch,	22h, 41h, 40h, 5Ch, 62h, 41h, 41h, 41h,	22h, 1Ch,   0,	 0
		db    0,   0,	0, 7Fh,	41h, 42h,   4,	 4,   8,   8,	8,   8,	  8,   8,   0,	 0
		db    0,   0,	0, 1Ch,	22h, 41h, 41h, 22h, 1Ch, 22h, 41h, 41h,	22h, 1Ch,   0,	 0
		db    0,   0,	0, 1Ch,	22h, 41h, 41h, 41h, 23h, 1Dh,	1, 41h,	22h, 1Ch,   0,	 0
		db    0,   0,	0,   0,	  0,   0, 18h, 18h,   0,   0,	0, 18h,	18h,   0,   0,	 0
		db    0,   0,	0,   0,	  0,   0, 18h, 18h,   0,   0,	0, 18h,	18h,   8, 10h,	 0
		db    0,   0,	0,   0,	  2,   4,   8, 10h, 20h, 10h,	8,   4,	  2,   0,   0,	 0
		db    0,   0,	0,   0,	  0,   0,   0, 7Fh,   0,   0, 7Fh,   0,	  0,   0,   0,	 0
		db    0,   0,	0,   0,	20h, 10h,   8,	 4,   2,   4,	8, 10h,	20h,   0,   0,	 0
		db    0,   0,	0, 1Ch,	22h, 41h, 41h,	 1,   6,   8,	8,   0,	  8,   8,   0,	 0
		db    0,   0,	0, 1Ch,	22h, 41h,   1, 31h, 49h, 49h, 49h, 49h,	49h, 36h,   0,	 0
		db    0,   0,	0,   8,	14h, 22h, 41h, 41h, 41h, 41h, 7Fh, 41h,	41h, 41h,   0,	 0
		db    0,   0,	0, 7Ch,	42h, 41h, 41h, 42h, 7Ch, 42h, 41h, 41h,	42h, 7Ch,   0,	 0
		db    0,   0,	0, 1Ch,	22h, 41h, 40h, 40h, 40h, 40h, 40h, 41h,	22h, 1Ch,   0,	 0
		db    0,   0,	0, 7Ch,	22h, 21h, 21h, 21h, 21h, 21h, 21h, 21h,	22h, 7Ch,   0,	 0
		db    0,   0,	0, 7Fh,	40h, 40h, 40h, 40h, 7Eh, 40h, 40h, 40h,	40h, 7Fh,   0,	 0
		db    0,   0,	0, 7Fh,	40h, 40h, 40h, 40h, 7Eh, 40h, 40h, 40h,	40h, 40h,   0,	 0
		db    0,   0,	0, 1Ch,	22h, 41h, 40h, 40h, 47h, 41h, 41h, 41h,	23h, 1Dh,   0,	 0
		db    0,   0,	0, 41h,	41h, 41h, 41h, 41h, 7Fh, 41h, 41h, 41h,	41h, 41h,   0,	 0
		db    0,   0,	0, 1Ch,	  8,   8,   8,	 8,   8,   8,	8,   8,	  8, 1Ch,   0,	 0
		db    0,   0,	0,   7,	  2,   2,   2,	 2,   2,   2,	2, 42h,	44h, 38h,   0,	 0
		db    0,   0,	0, 41h,	42h, 44h, 48h, 50h, 60h, 50h, 48h, 44h,	42h, 41h,   0,	 0
		db    0,   0,	0, 20h,	20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h,	20h, 3Fh,   0,	 0
		db    0,   0,	0, 41h,	63h, 55h, 49h, 49h, 41h, 41h, 41h, 41h,	41h, 41h,   0,	 0
		db    0,   0,	0, 41h,	61h, 51h, 51h, 49h, 49h, 45h, 45h, 43h,	41h, 41h,   0,	 0
		db    0,   0,	0, 1Ch,	22h, 41h, 41h, 41h, 41h, 41h, 41h, 41h,	22h, 1Ch,   0,	 0
		db    0,   0,	0, 7Ch,	42h, 41h, 41h, 41h, 42h, 7Ch, 40h, 40h,	40h, 40h,   0,	 0
		db    0,   0,	0, 1Ch,	22h, 41h, 41h, 41h, 41h, 41h, 5Dh, 63h,	22h, 1Dh,   0,	 0
		db    0,   0,	0, 7Ch,	42h, 41h, 41h, 42h, 7Ch, 48h, 44h, 42h,	42h, 41h,   0,	 0
		db    0,   0,	0, 1Ch,	22h, 41h, 40h, 20h, 1Ch,   2,	1, 41h,	22h, 1Ch,   0,	 0
		db    0,   0,	0, 7Fh,	  8,   8,   8,	 8,   8,   8,	8,   8,	  8,   8,   0,	 0
		db    0,   0,	0, 41h,	41h, 41h, 41h, 41h, 41h, 41h, 41h, 41h,	41h, 3Eh,   0,	 0
		db    0,   0,	0, 41h,	41h, 41h, 41h, 41h, 41h, 41h, 41h, 22h,	14h,   8,   0,	 0
		db    0,   0,	0, 41h,	41h, 41h, 41h, 41h, 49h, 49h, 55h, 55h,	22h, 22h,   0,	 0
		db    0,   0,	0, 41h,	41h, 41h, 22h, 14h,   8, 14h, 22h, 41h,	41h, 41h,   0,	 0
		db    0,   0,	0, 41h,	41h, 41h, 22h, 14h,   8,   8,	8,   8,	  8,   8,   0,	 0
		db    0,   0,	0, 7Fh,	  1,   1,   2,	 4,   8, 10h, 20h, 40h,	40h, 7Fh,   0,	 0
		db    0,   0,	0, 0Eh,	  8,   8,   8,	 8,   8,   8,	8,   8,	  8, 0Eh,   0,	 0
		db    0,   0,	0, 41h,	22h, 14h,   8, 7Fh,   8,   8, 7Fh,   8,	  8,   8,   0,	 0
		db    0,   0,	0, 38h,	  8,   8,   8,	 8,   8,   8,	8,   8,	  8, 38h,   0,	 0
		db    0,   0,	0,   8,	14h, 22h, 41h,	 0,   0,   0,	0,   0,	  0,   0,   0,	 0
		db    0,   0,	0,   0,	  0,   0,   0,	 0,   0,   0,	0,   0,	  0, 7Fh,   0,	 0
		db  10h, 18h, 0Ch,   4,	  0,   0,   0,	 0,   0,   0,	0,   0,	  0,   0,   0,	 0
		db    0,   0,	0,   0,	  0,   0, 3Ch, 42h,   2, 3Eh, 42h, 42h,	46h, 3Ah,   0,	 0
		db    0,   0,	0, 20h,	20h, 20h, 2Ch, 32h, 21h, 21h, 21h, 21h,	32h, 2Ch,   0,	 0
		db    0,   0,	0,   0,	  0,   0, 1Ch, 22h, 41h, 40h, 40h, 41h,	22h, 1Ch,   0,	 0
		db    0,   0,	0,   2,	  2,   2, 1Ah, 26h, 42h, 42h, 42h, 42h,	26h, 1Ah,   0,	 0
		db    0,   0,	0,   0,	  0,   0, 1Ch, 22h, 41h, 7Fh, 40h, 41h,	22h, 1Ch,   0,	 0
		db    0,   0,	0, 0Ch,	12h, 10h, 3Ch, 10h, 10h, 10h, 10h, 10h,	10h, 10h,   0,	 0
		db    0,   0,	0,   0,	  0,   0, 1Dh, 23h, 41h, 41h, 41h, 23h,	1Dh, 41h, 22h, 1Ch
		db    0,   0,	0, 20h,	20h, 20h, 2Ch, 32h, 21h, 21h, 21h, 21h,	21h, 21h,   0,	 0
		db    0,   0,	0,   8,	  8,   0,   0,	 8,   8,   8,	8,   8,	  8,   8,   0,	 0
		db    0,   0,	0,   4,	  4,   0,   0,	 4,   4,   4,	4,   4,	  4,   4, 24h, 18h
		db    0,   0,	0, 20h,	20h, 20h, 21h, 22h, 24h, 28h, 38h, 24h,	22h, 21h,   0,	 0
		db    0,   0,	0, 18h,	  8,   8,   8,	 8,   8,   8,	8,   8,	  8,   8,   0,	 0
		db    0,   0,	0,   0,	  0,   0, 76h, 49h, 49h, 49h, 49h, 49h,	49h, 49h,   0,	 0
		db    0,   0,	0,   0,	  0,   0, 2Eh, 31h, 21h, 21h, 21h, 21h,	21h, 21h,   0,	 0
		db    0,   0,	0,   0,	  0,   0, 1Ch, 22h, 41h, 41h, 41h, 41h,	22h, 1Ch,   0,	 0
		db    0,   0,	0,   0,	  0,   0, 2Ch, 32h, 21h, 21h, 21h, 21h,	32h, 2Ch, 20h, 20h
		db    0,   0,	0,   0,	  0,   0, 1Ah, 26h, 42h, 42h, 42h, 42h,	26h, 1Ah,   2,	 2
		db    0,   0,	0,   0,	  0,   0, 2Ch, 32h, 20h, 20h, 20h, 20h,	20h, 20h,   0,	 0
		db    0,   0,	0,   0,	  0,   0, 3Eh, 41h, 40h, 3Eh,	1,   1,	41h, 3Eh,   0,	 0
		db    0,   0,	0, 10h,	10h, 10h, 7Ch, 10h, 10h, 10h, 10h, 10h,	12h, 0Ch,   0,	 0
		db    0,   0,	0,   0,	  0,   0, 42h, 42h, 42h, 42h, 42h, 42h,	46h, 3Ah,   0,	 0
		db    0,   0,	0,   0,	  0,   0, 41h, 41h, 22h, 22h, 14h, 14h,	  8,   8,   0,	 0
		db    0,   0,	0,   0,	  0,   0, 41h, 41h, 41h, 49h, 49h, 55h,	22h, 22h,   0,	 0
		db    0,   0,	0,   0,	  0,   0, 41h, 22h, 14h,   8,	8, 14h,	22h, 41h,   0,	 0
		db    0,   0,	0,   0,	  0,   0, 21h, 21h, 21h, 21h, 21h, 11h,	0Ah,   4,   8, 30h
		db    0,   0,	0,   0,	  0,   0, 7Fh,	 2,   4,   8, 10h, 20h,	40h, 7Fh,   0,	 0
		db    0,   0,	0,   6,	  8,   8,   8,	 8, 10h,   8,	8,   8,	  8,   6,   0,	 0
		db    0,   0,	8,   8,	  8,   8,   0,	 0,   0,   0,	8,   8,	  8,   8,   0,	 0
		db    0,   0,	0, 30h,	  8,   8,   8,	 8,   4,   8,	8,   8,	  8, 30h,   0,	 0
		db    0,   0,	0, 30h,	49h,   6,   0,	 0,   0,   0,	0,   0,	  0,   0,   0,	 0
		db    0,   0,	0,   0,	  0,   0,   0,	 0,   0,   0,	0,   0,	  0,   0,   0,	 0
		db    0,   0,	0,   0,	  0,   0,   0,	 0,   0,   0,	0,   0,	  0,   0,0FFh,0FFh
		db    0,   0,	0,   0,	  0,   0,   0,	 0,   0,   0,	0,   0,0FFh,0FFh,0FFh,0FFh
		db    0,   0,	0,   0,	  0,   0,   0,	 0,   0,   0,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
		db    0,   0,	0,   0,	  0,   0,   0,	 0,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
		db    0,   0,	0,   0,	  0,   0,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
		db    0,   0,	0,   0,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
		db    0,   0,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
		db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
		db  80h, 80h, 80h, 80h,	80h, 80h, 80h, 80h, 80h, 80h, 80h, 80h,	80h, 80h, 80h, 80h
		db 0C0h,0C0h,0C0h,0C0h,0C0h,0C0h,0C0h,0C0h,0C0h,0C0h,0C0h,0C0h,0C0h,0C0h,0C0h,0C0h
		db 0E0h,0E0h,0E0h,0E0h,0E0h,0E0h,0E0h,0E0h,0E0h,0E0h,0E0h,0E0h,0E0h,0E0h,0E0h,0E0h
		db 0F0h,0F0h,0F0h,0F0h,0F0h,0F0h,0F0h,0F0h,0F0h,0F0h,0F0h,0F0h,0F0h,0F0h,0F0h,0F0h
		db 0F8h,0F8h,0F8h,0F8h,0F8h,0F8h,0F8h,0F8h,0F8h,0F8h,0F8h,0F8h,0F8h,0F8h,0F8h,0F8h
		db 0FCh,0FCh,0FCh,0FCh,0FCh,0FCh,0FCh,0FCh,0FCh,0FCh,0FCh,0FCh,0FCh,0FCh,0FCh,0FCh
		db 0FEh,0FEh,0FEh,0FEh,0FEh,0FEh,0FEh,0FEh,0FEh,0FEh,0FEh,0FEh,0FEh,0FEh,0FEh,0FEh
		db    8,   8,	8,   8,	  8,   8,   8,	 8,0FFh,   8,	8,   8,	  8,   8,   8,	 8
		db    8,   8,	8,   8,	  8,   8,   8,	 8,0FFh,   0,	0,   0,	  0,   0,   0,	 0
		db    0,   0,	0,   0,	  0,   0,   0,	 0,0FFh,   8,	8,   8,	  8,   8,   8,	 8
		db    8,   8,	8,   8,	  8,   8,   8,	 8,0F8h,   8,	8,   8,	  8,   8,   8,	 8
		db    8,   8,	8,   8,	  8,   8,   8,	 8, 0Fh,   8,	8,   8,	  8,   8,   8,	 8
		db 0FFh,   0,	0,   0,	  0,   0,   0,	 0,   0,   0,	0,   0,	  0,   0,   0,	 0
		db    0,   0,	0,   0,	  0,   0,   0,	 0,0FFh,   0,	0,   0,	  0,   0,   0,	 0
		db    8,   8,	8,   8,	  8,   8,   8,	 8,   8,   8,	8,   8,	  8,   8,   8,	 8
		db    1,   1,	1,   1,	  1,   1,   1,	 1,   1,   1,	1,   1,	  1,   1,   1,	 1
		db    0,   0,	0,   0,	  0,   0,   0,	 0, 0Fh,   8,	8,   8,	  8,   8,   8,	 8
		db    0,   0,	0,   0,	  0,   0,   0,	 0,0F8h,   8,	8,   8,	  8,   8,   8,	 8
		db    8,   8,	8,   8,	  8,   8,   8,	 8, 0Fh,   0,	0,   0,	  0,   0,   0,	 0
		db    8,   8,	8,   8,	  8,   8,   8,	 8,0F8h,   0,	0,   0,	  0,   0,   0,	 0
		db    0,   0,	0,   0,	  0,   0,   0,	 0,   1,   2,	4,   4,	  8,   8,   8,	 8
		db    0,   0,	0,   0,	  0,   0,   0,	 0,0C0h, 20h, 10h, 10h,	  8,   8,   8,	 8
		db    8,   8,	8,   8,	  8,   4,   4,	 2,   1,   0,	0,   0,	  0,   0,   0,	 0
		db    8,   8,	8,   8,	  8, 10h, 10h, 20h,0C0h,   0,	0,   0,	  0,   0,   0,	 0
		db    0,   0,	0,   0,	  0,   0,   0,	 0,   0,   0,	0,   0,	  0,   0,   0,	 0
		db    0,   0,	0,   0,	  0,   0,   0,	 0,   0,   0, 18h, 24h,	24h, 18h,   0,	 0
		db    0,   0,	0, 1Eh,	10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h,	  0,   0,   0,	 0
		db    0,   0,	0,   0,	  0,   4,   4,	 4,   4,   4,	4,   4,	  4, 3Ch,   0,	 0
		db    0,   0,	0,   0,	  0,   0,   0,	 0,   0,   0,	0, 40h,	20h, 10h,   0,	 0
		db    0,   0,	0,   0,	  0,   0,   0, 18h, 18h,   0,	0,   0,	  0,   0,   0,	 0
		db    0,   0,	0,   0,	7Fh,   1,   1, 7Fh,   1,   1,	2,   4,	  8, 30h,   0,	 0
		db    0,   0,	0,   0,	  0,   0,   0, 7Fh,   1,   9, 0Eh,   8,	10h, 60h,   0,	 0
		db    0,   0,	0,   0,	  0,   0,   1,	 2,   4, 1Ch, 64h,   4,	  4,   4,   0,	 0
		db    0,   0,	0,   0,	  0,   0,   8, 7Fh, 41h, 41h,	1,   2,	  4, 18h,   0,	 0
		db    0,   0,	0,   0,	  0,   0,   0, 3Eh,   8,   8,	8,   8,	  8, 7Fh,   0,	 0
		db    0,   0,	0,   0,	  0,   0,   4,	 4, 7Fh,   4, 0Ch, 14h,	24h, 44h,   0,	 0
		db    0,   0,	0,   0,	  0,   0, 10h, 10h, 7Fh, 11h, 12h, 10h,	10h, 10h,   0,	 0
		db    0,   0,	0,   0,	  0,   0,   0, 3Ch,   4,   4,	4,   4,	  4, 7Fh,   0,	 0
		db    0,   0,	0,   0,	  0,   0,   0, 7Eh,   2,   2, 3Eh,   2,	  2, 7Eh,   0,	 0
		db    0,   0,	0,   0,	  0,   0,   0, 49h, 49h, 49h,	1,   2,	  4, 18h,   0,	 0
		db    0,   0,	0,   0,	  0,   0,   0,	 0,   0, 7Fh,	0,   0,	  0,   0,   0,	 0
		db    0,   0,	0,   0,	7Fh,   1,   1,	 9, 0Eh,   8, 10h, 10h,	20h, 40h,   0,	 0
		db    0,   0,	0,   1,	  1,   2,   2,	 4, 1Ch, 64h,	4,   4,	  4,   4,   0,	 0
		db    0,   0,	0,   8,	  8, 7Fh, 41h, 41h, 41h,   1,	1,   2,	  4, 18h,   0,	 0
		db    0,   0,	0,   0,	3Eh,   8,   8,	 8,   8,   8,	8,   8,	  8, 7Fh,   0,	 0
		db    0,   0,	0,   4,	  4, 7Fh,   4, 0Ch, 0Ch, 14h, 14h, 24h,	44h,   4,   0,	 0
		db    0,   0,	0,   8,	  8, 7Fh,   9,	 9,   9, 11h, 11h, 21h,	21h, 46h,   0,	 0
		db    0,   0,	0,   8,	  8, 7Fh,   8,	 8,   8,   8, 7Fh,   8,	  8,   8,   0,	 0
		db    0,   0,	0, 10h,	1Fh, 11h, 21h, 21h, 41h,   1,	2,   4,	  8, 30h,   0,	 0
		db    0,   0,	0, 20h,	20h, 3Fh, 24h, 44h,   4,   4,	4,   8,	10h, 20h,   0,	 0
		db    0,   0,	0,   0,	7Fh,   1,   1,	 1,   1,   1,	1,   1,	  1, 7Fh,   0,	 0
		db    0,   0,	0, 22h,	22h, 22h, 7Fh, 22h, 22h, 22h,	2,   4,	  8, 10h,   0,	 0
		db    0,   0,	0,   0,	60h, 11h,   1, 61h, 11h,   1,	2,   4,	  8, 70h,   0,	 0
		db    0,   0,	0,   0,	7Eh,   2,   2,	 4,   4,   8,	8, 14h,	22h, 41h,   0,	 0
		db    0,   0,	0, 10h,	10h, 7Fh, 11h, 11h, 12h, 10h, 10h, 10h,	10h, 0Fh,   0,	 0
		db    0,   0,	0,   0,	41h, 21h, 21h, 11h, 11h,   1,	2,   4,	  8, 30h,   0,	 0
		db    0,   0,	0, 10h,	1Fh, 11h, 21h, 21h, 51h,   9,	6,   4,	  8, 30h,   0,	 0
		db    0,   0,	0,   3,	3Ch,   4,   4, 7Fh,   4,   4,	4,   8,	10h, 60h,   0,	 0
		db    0,   0,	0,   0,	49h, 49h, 49h, 49h,   1,   1,	2,   4,	  8, 30h,   0,	 0
		db    0,   0,	0,   0,	3Eh,   0,   0, 7Fh,   8,   8,	8,   8,	10h, 60h,   0,	 0
		db    0,   0,	0, 20h,	20h, 20h, 20h, 30h, 28h, 24h, 22h, 20h,	20h, 20h,   0,	 0
		db    0,   0,	0,   8,	  8,   8, 7Fh,	 8,   8,   8,	8,   8,	10h, 60h,   0,	 0
		db    0,   0,	0,   0,	3Eh,   0,   0,	 0,   0,   0,	0,   0,	  0, 7Fh,   0,	 0
		db    0,   0,	0,   0,	7Eh,   2,   2, 22h, 12h, 0Ch,	8, 14h,	22h, 40h,   0,	 0
		db    0,   0,	0,   8,	  8, 7Fh,   1,	 2,   4, 0Ch, 1Ah, 69h,	  8,   8,   0,	 0
		db    0,   0,	0,   0,	  1,   1,   1,	 2,   2,   4,	4,   8,	10h, 60h,   0,	 0
		db    0,   0,	0,   8,	  4, 22h, 21h, 21h, 21h, 21h, 21h, 21h,	41h,   0,   0,	 0
		db    0,   0,	0, 40h,	40h, 40h, 7Fh, 40h, 40h, 40h, 40h, 40h,	3Fh,   0,   0,	 0
		db    0,   0,	0,   0,	7Fh,   1,   1,	 2,   2,   4,	4,   8,	10h, 20h,   0,	 0
		db    0,   0,	0,   0,	10h, 18h, 28h, 24h, 44h,   2,	2,   1,	  1,   0,   0,	 0
		db    0,   0,	0,   8,	  8,   8, 7Fh,	 8,   8, 2Ah, 2Ah, 49h,	49h,   8,   0,	 0
		db    0,   0,	0,   0,	7Fh,   1,   1,	 2,   2, 24h, 18h,   8,	  4,   2,   0,	 0
		db    0,   0,	0,   0,	3Ch,   2,   0,	 0, 3Ch,   2,	0,   0,	7Eh,   1,   0,	 0
		db    0,   0,	0,   8,	  8,   8, 10h, 10h, 22h, 22h, 42h, 42h,	7Dh,   1,   0,	 0
		db    0,   0,	0,   2,	  2,   2, 22h, 12h, 0Ah,   4, 0Ah, 11h,	20h, 40h,   0,	 0
		db    0,   0,	0,   0,	7Fh, 10h, 10h, 10h, 7Fh, 10h, 10h, 10h,	10h, 0Fh,   0,	 0
		db    0,   0,	0, 10h,	10h, 7Fh, 11h, 11h, 12h, 10h, 10h, 10h,	10h, 10h,   0,	 0
		db    0,   0,	0,   0,	3Ch,   4,   4,	 4,   4,   4,	4,   4,	  4, 7Fh,   0,	 0
		db    0,   0,	0,   0,	7Fh,   1,   1,	 1, 3Fh,   1,	1,   1,	  1, 7Fh,   0,	 0
		db    0,   0,	0, 3Eh,	  0,   0, 7Fh,	 1,   1,   1,	2,   4,	  8, 30h,   0,	 0
		db    0,   0,	0, 22h,	22h, 22h, 22h, 22h, 22h,   2,	2,   4,	  4, 18h,   0,	 0
		db    0,   0,	0,   8,	  8, 28h, 28h, 28h, 28h, 29h, 29h, 2Ah,	2Ch, 48h,   0,	 0
		db    0,   0,	0, 20h,	20h, 20h, 20h, 20h, 20h, 21h, 22h, 24h,	28h, 30h,   0,	 0
		db    0,   0,	0,   0,	7Fh, 41h, 41h, 41h, 41h, 41h, 41h, 41h,	41h, 7Fh,   0,	 0
		db    0,   0,	0,   0,	7Fh, 41h, 41h, 41h,   1,   1,	2,   4,	  8, 30h,   0,	 0
		db    0,   0,	0,   0,	60h, 18h,   1,	 1,   1,   1,	2,   4,	  8, 70h,   0,	 0
		db    0,   0, 48h, 24h,	12h,   0,   0,	 0,   0,   0,	0,   0,	  0,   0,   0,	 0
		db    0,   0, 30h, 48h,	48h, 30h,   0,	 0,   0,   0,	0,   0,	  0,   0,   0,	 0
		db    0,   0,	0,   0,0FFh,   0,   0,	 0,   0,   0,0FFh,   0,	  0,   0,   0,	 0
		db    8,   8,	8,   8,	0Fh,   8,   8,	 8,   8,   8, 0Fh,   8,	  8,   8,   8,	 8
		db    8,   8,	8,   8,0FFh,   8,   8,	 8,   8,   8,0FFh,   8,	  8,   8,   8,	 8
		db    8,   8,	8,   8,0F8h,   8,   8,	 8,   8,   8,0F8h,   8,	  8,   8,   8,	 8
		db    1,   1,	3,   3,	  7,   7, 0Fh, 0Fh, 1Fh, 1Fh, 3Fh, 3Fh,	7Fh, 7Fh,0FFh,0FFh
		db  80h, 80h,0C0h,0C0h,0E0h,0E0h,0F0h,0F0h,0F8h,0F8h,0FCh,0FCh,0FEh,0FEh,0FFh,0FFh
		db 0FFh,0FFh, 7Fh, 7Fh,	3Fh, 3Fh, 1Fh, 1Fh, 0Fh, 0Fh,	7,   7,	  3,   3,   1,	 1
		db 0FFh,0FFh,0FEh,0FEh,0FCh,0FCh,0F8h,0F8h,0F0h,0F0h,0E0h,0E0h,0C0h,0C0h, 80h, 80h
		db    8,   8, 1Ch, 1Ch,	3Eh, 3Eh, 7Fh, 7Fh, 7Fh, 7Fh, 2Ah,   8,	1Ch, 3Eh,   0,	 0
		db  36h, 36h, 7Fh, 7Fh,	7Fh, 7Fh, 7Fh, 7Fh, 3Eh, 3Eh, 1Ch, 1Ch,	  8,   8,   0,	 0
		db    8,   8, 1Ch, 1Ch,	3Eh, 3Eh, 7Fh, 7Fh, 3Eh, 3Eh, 1Ch, 1Ch,	  8,   8,   0,	 0
		db    8, 1Ch, 1Ch, 1Ch,	2Ah, 7Fh, 7Fh, 7Fh, 7Fh, 2Ah,	8,   8,	1Ch, 3Eh,   0,	 0
		db    0,   0, 1Ch, 3Eh,	7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh,	3Eh, 1Ch,   0,	 0
		db    0,   0, 1Ch, 22h,	41h, 41h, 41h, 41h, 41h, 41h, 41h, 41h,	22h, 1Ch,   0,	 0
		db    1,   1,	2,   2,	  4,   4,   8,	 8, 10h, 10h, 20h, 20h,	40h, 40h, 80h, 80h
		db  80h, 80h, 40h, 40h,	20h, 20h, 10h, 10h,   8,   8,	4,   4,	  2,   2,   1,	 1
		db  81h, 81h, 42h, 42h,	24h, 24h, 18h, 18h, 18h, 18h, 24h, 24h,	42h, 42h, 81h, 81h
		db    0, 7Fh, 49h, 49h,	49h, 49h, 49h, 7Fh, 41h, 41h, 41h, 41h,	41h, 43h,   0,	 0
		db    0, 20h, 20h, 3Fh,	44h,   4, 3Fh, 24h, 24h, 24h, 7Fh,   4,	  4,   4,   0,	 0
		db    0, 3Fh, 21h, 21h,	21h, 3Fh, 21h, 21h, 21h, 3Fh, 21h, 21h,	41h, 43h,   0,	 0
		db    0, 7Eh, 42h, 42h,	42h, 42h, 42h, 7Eh, 42h, 42h, 42h, 42h,	42h, 7Eh,   0,	 0
		db    0,   4,	4, 7Eh,	54h, 54h, 5Fh, 72h, 5Fh, 52h, 5Ah, 76h,	  2,   6,   0,	 0
		db    0,   4, 12h, 21h,	21h, 41h,   0, 7Fh, 11h, 11h, 11h, 11h,	21h, 43h,   0,	 0
		db    0, 14h, 24h, 64h,	2Ch, 2Eh, 75h, 24h, 75h, 65h, 65h, 22h,	24h, 28h,   0,	 0
		db    0,   0,	0,   0,	  0,   0,   0,	 0,   0,   0,	0,   0,	  0,   0,   0,	 0
		db    0,   0,	0,   0,	  0,   0,   0,	 0,   0,   0,	0,   0,	  0,   0,   0,	 0
		db    0,   0,	0,   0,	  0,   0,   0,	 0,   0,   0,	0,   0,	  0,   0,   0,	 0
		db    0,   0,	0,   0,	  0,   0,   0,	 0,   0,   0,	0,   0,	  0,   0,   0,	 0
		db    0,   0,	0,   0,	  0, 40h, 20h, 10h,   8,   4,	2,   1,	  0,   0,   0,	 0
		db    0,   0,	0,   0,	  0,   0,   0,	 0,   0,   0,	0,   0,	  0,   0,   0,	 0
		db    0,   0,	0,   0,	  0,   0,   0,	 0,   0,   0,	0,   0,	  0,   0,   0,	 0
		db    0,   0,	0,   0,	  0,   0,   0,	 0,   0,   0,	0,   0,	  0,   0,   0,	 0
		db    0,   0,	0,   0,	  0,   0,   0,	 0,   0,   0,	0,   0,	  0,   0,   0,	 0
		db    0,   0,	0,   0,	  0,   0,   0,	 0,   0,   0,	0,   0,	  0,   0,   0,	 0
		db    0,   0,	0,   0,	  0,   0,   0,	 0,   0,   0,	0,   0,	  0,   0,   0,	 0
		db    0,   0,	0,   0,	  0,   0,   0,	 0,   0,   0,	0,   0,	  0,   0,   0,	 0
		db    0,   0,	0,   0,	  0,   0,   0,	 0,   0,   0,	0,   0,	  0,   0,   0,	 0
		db    0,   0,	0,   0,	  0,   0,   0,	 0,   0,   0,	0,   0,	  0,   0,   0,	 0
		db    0,   0,	0,   0,	  0,   0,   0,	 0,   0,   0,	0,   0,	  0,   0,   0,	 0
		db    0,   0,	0,   0,	  0,   0,   0,	 0,   0,   0,	0,   0,	  0,   0,   0,	 0
		db    0,   0,	0,   0,	  0,   0,   0,	 0,   0,   0,	0,   0,	  0,   0,   0,	 0
		db    0,   0,	0,   0,	  0,   0,   0,	 0,   0,   0,	0,   0,	  0,   0,   0,	 0
		db    0,   0,	0,   0,	  0,   0,   0,	 0,   0,   0,	0,   0,	  0,   0,   0,	 0
		db    0,   0,	0,   0,	  0,   0,   0,	 0,   0,   0,	0,   0,	  0,   0,   0,	 0
		db    0,   0,	0,   0,	  0,   0,   0,	 0,   0,   0,	0,   0,	  0,   0,   0,	 0
		db    0,   0,	0,   0,	  0,   0,   0,	 0,   0,   0,	0,   0,	  0,   0,   0,	 0
		db    0,   0,	0,   0,	  0,   0,   0,	 0,   0,   0,	0,   0,	  0,   0,   0,	 0
		db    0,   0,	0,   0,	  0,   0,   0,	 0,   0,   0,	0,   0,	  0,   0
		dw 0
word_18524	dw 65h,	0, 0, 0, 0, 0, 0, 0, 0,	0 ; DATA XREF: sub_1566E+3CDr
		dw 66h,	0, 1, 0C9h, 0, 0, 0, 0
		dw 67h,	0, 1, 0, 0, 0, 0, 0
		dw 68h,	0, 1, 0, 0, 0, 0CAh, 0
		dw 69h,	0, 1, 2, 0, 0, 0, 0, 0
		dw 6Ah,	0, 3, 0, 0, 0, 0, 0
		dw 6Bh,	0, 4, 0CBh, 0, 0, 0, 0
		dw 6Ch,	0, 1, 5, 0, 0, 0, 0, 0,	7Fh, 0,	3, 4, 5, 8, 0, 0, 0, 0,	0, 0
		dw 6Dh,	0, 5, 6, 7, 0, 0, 0, 0,	0
		dw 6Eh,	0, 8, 0CCh, 0, 0, 0, 0
		dw 6Fh,	0, 2, 0, 0, 0, 0, 0
		dw 70h,	0, 8, 0, 0, 0, 0, 0
		dw 71h,	0, 6, 0CDh, 0, 0, 0, 0
		dw 72h,	0, 9, 0Ah, 0, 0, 0, 0, 0
		dw 73h,	0, 9, 0, 0, 0, 0, 0
		dw 74h,	0, 6, 0CEh, 0, 0, 0, 0
		dw 75h,	0, 0Ah,	0, 0, 0, 0, 0
		dw 76h,	0, 0Ah,	0, 0, 0, 0, 0
		dw 77h,	0, 2, 0CFh, 0, 0, 0, 0
		dw 78h,	0, 2, 0, 0, 0, 0, 0, 79h, 0, 0Bh, 0, 0,	0, 0, 0
		dw 7Ah,	0, 0Ch,	0D0h, 0, 0, 0, 0
		dw 7Bh,	0, 0Dh,	0Eh, 0Fh, 10h, 11h, 12h, 13h, 0, 0, 0, 0, 0D1h,	0, 0, 0, 0, 0, 0, 0
		dw 7Ch,	0, 14h,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0
		dw 7Dh,	0, 2, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0D2h, 0, 0
		dw 7Eh,	0, 15h,	0, 16h,	0, 0, 0, 0
		dw 0FFh
aC01_end_vdf	db 'C01_END.VDF',0,0    ; DATA XREF: sub_1566E+4BEt
aC02_end_vdf	db 'C02_END.VDF',0,0
aC03_end_vdf	db 'C03_END.VDF',0,0
aC05_end_vdf	db 'C05_END.VDF',0,0
aC13_end_vdf	db 'C13_END.VDF',0,0
aC14_end_vdf	db 'C14_END.VDF',0,0
aC15_end_vdf	db 'C15_END.VDF',0,0
aC43_end_vdf	db 'C43_END.VDF',0,0
aC49_end_vdf	db 'C49_END.VDF',0,0
aC48_end_vdf	db 'C48_END.VDF',0,0
aEarth01_vdf	db 'EARTH01.VDF',0,0    ; DATA XREF: sub_1566E+672o
aBrk_c_vdf	db 'brk_c.vdf',0,0,0,0  ; DATA XREF: sub_1566E+7F2o
aEnd_mark_vdf	db 'END_MARK.VDF',0
aStff_001_vdf	db 'STFF_001.VDF',0     ; DATA XREF: sub_1566E+568o
aStff_002_vdf	db 'STFF_002.VDF',0
aStff_003_vdf	db 'STFF_003.VDF',0
aStff_004_vdf	db 'STFF_004.VDF',0
aStff_005_vdf	db 'STFF_005.VDF',0
aStff_006_vdf	db 'STFF_006.VDF',0
aStff_007_vdf	db 'STFF_007.VDF',0
aStff_008_vdf	db 'STFF_008.VDF',0
aStff_009_vdf	db 'STFF_009.VDF',0
aStff_010_vdf	db 'STFF_010.VDF',0
aStff_011_vdf	db 'STFF_011.VDF',0
aStff_012_vdf	db 'STFF_012.VDF',0
aStff_013_vdf	db 'STFF_013.VDF',0
aStff_014_vdf	db 'STFF_014.VDF',0
aStff_015_vdf	db 'STFF_015.VDF',0
aStff_016_vdf	db 'STFF_016.VDF',0
aStff_017_vdf	db 'STFF_017.VDF',0
aStff_018_vdf	db 'STFF_018.VDF',0
aStff_019_vdf	db 'STFF_019.VDF',0
aStff_020_vdf	db 'STFF_020.VDF',0
aMelody_vdf	db 'MELODY.VDF',0,0,0
aPanda_vdf	db 'PANDA.VDF',0,0,0,0
stff0_heights	dw 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32
					; DATA XREF: sub_1566E+583r
					; sub_1566E+5ABr ...
		dw 32, 32, 32, 32, 32, 32, 32, 44, 40
aStff_101_vdf	db 'STFF_101.VDF',0     ; DATA XREF: sub_1566E+401t
aStff_102_vdf	db 'STFF_102.VDF',0
aStff_103_vdf	db 'STFF_103.VDF',0
aStff_104_vdf	db 'STFF_104.VDF',0
aStff_105_vdf	db 'STFF_105.VDF',0
aStff_106_vdf	db 'STFF_106.VDF',0
aStff_107_vdf	db 'STFF_107.VDF',0
aStff_108_vdf	db 'STFF_108.VDF',0
aStff_109_vdf	db 'STFF_109.VDF',0
aStff_110_vdf	db 'STFF_110.VDF',0
aStff_111_vdf	db 'STFF_111.VDF',0
aStff_112_vdf	db 'STFF_112.VDF',0
aStff_113_vdf	db 'STFF_113.VDF',0
aStff_114_vdf	db 'STFF_114.VDF',0
aStff_115_vdf	db 'STFF_115.VDF',0
aStff_116_vdf	db 'STFF_116.VDF',0
aStff_117_vdf	db 'STFF_117.VDF',0
aStff_118_vdf	db 'STFF_118.VDF',0
aStff_119_vdf	db 'STFF_119.VDF',0
aStff_120_vdf	db 'STFF_120.VDF',0
aStff_121_vdf	db 'STFF_121.VDF',0
aStff_122_vdf	db 'STFF_122.VDF',0
aStff_123_vdf	db 'STFF_123.VDF',0
aStff_124_vdf	db 'STFF_124.VDF',0
aStff_125_vdf	db 'STFF_125.VDF',0
aStff_126_vdf	db 'STFF_126.VDF',0
aStff_127_vdf	db 'STFF_127.VDF',0
stff1_widths	dw 296,	168, 208, 184, 192, 216, 144, 144, 168,	216, 96
					; DATA XREF: sub_1566E+420t
					; sub_1566E+444t ...
		dw 72, 96, 240,	168, 240, 96, 120, 216,	96, 224, 144, 144
		dw 168,	144, 80, 192
stff0_widths	dw 336,	352, 288, 288, 288, 128, 96, 288, 128, 256, 320
					; DATA XREF: sub_1566E+58Br
					; sub_1566E+5B3r ...
		dw 128,	128, 128, 128, 128, 128, 128, 128, 384,	64, 144
byte_18ADA	db 30h dup(0)		; DATA XREF: sub_1566E+8C5o
					; sub_1566E+AC5o ...
byte_18B0A	db 0, 0, 0, 1, 1, 2, 2,	2, 3, 4, 4, 5, 7, 7, 8,	9, 8, 8, 0Bh, 0Ah, 0Ah,	0Dh, 0Ch, 0Ch
					; DATA XREF: sub_1566E+203o
					; sub_1566E+A9Bo
		db 0Dh,	0Dh, 0Dh, 0Dh, 0Dh, 0Dh, 0Eh, 0Eh, 0Eh,	0Eh, 0Eh, 0Eh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh,	0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh
byte_18B3A	db 0, 0, 0, 1, 1, 2, 2,	2, 3, 4, 4, 5, 7, 7, 8,	9, 8, 8, 0Bh, 0Ah, 0Ah,	0Dh, 0Ch, 0Ch
					; DATA XREF: sub_1566E+610o
		db 0, 0, 0, 1, 1, 2, 2,	2, 3, 4, 4, 5, 7, 7, 8,	9, 8, 8, 0Bh, 0Ah, 0Ah,	0Dh, 0Ch, 0Ch
		db 0, 0, 0, 1, 1, 2, 2,	2, 3, 4, 4, 5, 7, 7, 8,	9, 8, 8, 0Bh, 0Ah, 0Ah,	0Dh, 0Ch, 0Ch
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0
byte_18B9A	db 0, 0, 0, 0, 0, 1, 1,	0, 1, 3, 0, 2, 5, 1, 2,	8, 2, 3, 0Ah, 3, 3, 0Ch, 4, 4
					; DATA XREF: sub_1566E+711o
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0, 0, 1, 1,	0, 1, 2, 0, 0, 4, 1, 0,	6, 3, 1, 8, 5, 3, 0Ah, 7, 5
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0, 0, 1, 1,	0, 1, 3, 0, 2, 5, 1, 2,	8, 2, 3, 0Ah, 3, 3, 0Ch, 4, 4
		db 3, 2, 2, 5, 4, 3, 7,	5, 5, 9, 7, 7, 0Bh, 9, 9, 0Dh, 0Bh, 0Ah, 0Fh, 0Dh, 0Bh,	0Fh, 0Fh, 0Fh
byte_18C2A	db 0, 0, 0, 0, 0, 1, 1,	0, 1, 3, 0, 2, 5, 1, 2,	8, 2, 3, 0Ah, 3, 3, 0Ch, 4, 4
					; DATA XREF: sub_1566E+8AEo
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 2, 0, 0,	3, 1, 0, 4, 2, 1, 8, 7,	6
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 2, 0, 1, 4, 0, 1,	7, 1, 2, 9, 2, 2, 0Bh, 3, 3
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 1, 1, 1, 3, 1, 1,	5, 3, 2, 7, 5, 4, 9, 8,	8
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 1, 0, 0, 3, 0, 0,	6, 0, 1, 8, 1, 1, 0Ah, 2, 2
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 3, 2, 1, 5, 3, 3,	6, 4, 3, 8, 6, 4, 0Dh, 0Dh, 0Dh
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 1, 0, 0, 3, 0, 0,	6, 0, 1, 8, 1, 1, 0Ah, 2, 2
		db 0, 0, 0, 0, 0, 0, 3,	2, 1, 4, 3, 2, 6, 4, 4,	7, 5, 4, 9, 7, 5, 0Fh, 0Fh, 0Fh
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 1, 0, 0, 3, 0, 0,	6, 0, 1, 8, 1, 1, 0Ah, 2, 2
		db 0, 0, 0, 3, 2, 1, 4,	3, 2, 5, 4, 3, 7, 5, 5,	8, 6, 5, 0Ah, 8, 6, 0Fh, 0Fh, 0Fh
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 1, 0, 0, 3, 0, 0,	6, 0, 1, 8, 1, 1, 0Ah, 2, 2
		db 0, 0, 0, 3, 2, 0, 5,	3, 3, 6, 5, 4, 8, 6, 6,	9, 7, 6, 0Bh, 9, 7, 0Fh, 0Fh, 0Fh
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 1, 0, 0, 3, 0, 0,	6, 0, 1, 8, 1, 1, 0Ah, 2, 2
		db 1, 0, 0, 4, 3, 2, 5,	4, 3, 7, 6, 5, 8, 6, 6,	0Bh, 9,	8, 0Dh,	0Bh, 9,	0Fh, 0Fh, 0Fh
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 1, 0, 0, 3, 0, 0,	6, 0, 1, 8, 1, 1, 0Ah, 2, 2
		db 2, 1, 1, 4, 3, 2, 6,	5, 4, 8, 6, 6, 0Ah, 8, 8, 0Ch, 0Ah, 9, 0Eh, 0Ch, 0Ah, 0Fh, 0Fh,	0Fh
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 1, 0, 0, 3, 0, 0,	6, 0, 1, 8, 1, 1, 0Ah, 2, 2
		db 3, 2, 2, 5, 4, 3, 7,	5, 5, 9, 7, 7, 0Bh, 9, 9, 0Dh, 0Bh, 0Ah, 0Fh, 0Dh, 0Bh,	0Fh, 0Fh, 0Fh
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 1, 0, 0, 3, 0, 0,	6, 0, 1, 8, 1, 1, 0Ah, 2, 2
		db 3, 2, 2, 5, 4, 3, 7,	5, 5, 0Ah, 8, 8, 0Ch, 0Ah, 0Ah,	0Eh, 0Ch, 0Bh, 0Fh, 0Eh, 0Ch, 0Fh, 0Fh,	0Fh
		dw 0, 80, 304, 120, 64,	64, 160, 144, 64, 80, 24, 144
		dw 120,	64, 96,	96, 256, 128, 160, 96
aConfig_nsd	db 'Config.nsd',0       ; DATA XREF: sub_1566E+10o
aFile1_nsd	db 'FILE1.NSD',0,0,0,0  ; DATA XREF: sub_1566E+23o
aFile2_nsd	db 'FILE2.NSD',0,0,0,0
aFile3_nsd	db 'FILE3.NSD',0,0,0,0
aNo_con_a_vdf	db 'NO_CON_A.VDF',0     ; DATA XREF: sub_161D5+Eo
aNo_con_b_vdf	db 'NO_CON_B.VDF',0
aNo_con_c_vdf	db 'NO_CON_C.VDF',0
aNo_con_d_vdf	db 'NO_CON_D.VDF',0
word_18E98	dw 40h,	60h, 80h, 40h	; DATA XREF: sub_161D5+20o
word_18EA0	dw 16h,	13h, 10h	; DATA XREF: sub_161D5+32o
a2j1h		db 1Bh,'[2J',1Bh,'[>1h',0 ; DATA XREF: sub_1566E+30o
aConfig_nsd_0	db 'Config.nsd',0       ; DATA XREF: sub_1566E+142o
aRb		db 'rb',0               ; DATA XREF: sub_1566E+13Do
aConfig_nsd_1	db 'Config.nsd',0       ; DATA XREF: sub_1566E+1B6o
aWb		db 'wb',0               ; DATA XREF: sub_1566E+1B1o
aVrvgvpvtve	db '‚r‚ƒ‚‚’‚…',0       ; DATA XREF: sub_1566E+A1Do
aVbvpvxvovfvivo	db '‚b‚‚•‚Ž‚”‚‰‚Ž‚•‚…',0 ; DATA XREF: sub_1566E+A6Fo
word_18EEA	dw 0			; DATA XREF: seg000:023Cr
					; seg000:loc_10248r ...
		db 00h
byte_18EED	db  20h, 20h, 20h, 20h,	20h, 20h, 20h, 20h ; DATA XREF:	sub_1202D+3Br
					; sub_1202D+4Fr ...
		db  20h, 21h, 21h, 21h,	21h, 21h, 20h, 20h
		db  20h, 20h, 20h, 20h,	20h, 20h, 20h, 20h
		db  20h, 20h, 20h, 20h,	20h, 20h, 20h, 20h
		db  01h, 40h, 40h, 40h,	40h, 40h, 40h, 40h
		db  40h, 40h, 40h, 40h,	40h, 40h, 40h, 40h
		db  02h, 02h, 02h, 02h,	02h, 02h, 02h, 02h
		db  02h, 02h, 40h, 40h,	40h, 40h, 40h, 40h
		db  40h, 14h, 14h, 14h,	14h, 14h, 14h, 04h
		db  04h, 04h, 04h, 04h,	04h, 04h, 04h, 04h
		db  04h, 04h, 04h, 04h,	04h, 04h, 04h, 04h
		db  04h, 04h, 04h, 40h,	40h, 40h, 40h, 40h
		db  40h, 18h, 18h, 18h,	18h, 18h, 18h, 08h
		db  08h, 08h, 08h, 08h,	08h, 08h, 08h, 08h
		db  08h, 08h, 08h, 08h,	08h, 08h, 08h, 08h
		db  08h, 08h, 08h, 40h,	40h, 40h, 40h, 20h
		db 81h dup(0)
off_18FEE	dd nullsub_1		; DATA XREF: sub_100EE+13r
					; sub_10FCC+BEw ...
off_18FF2	dd nullsub_1		; DATA XREF: sub_100EE+17r
					; sub_105A7:loc_10651w	...
off_18FF6	dd nullsub_1		; DATA XREF: sub_100EE+1Br
word_18FFA	dw 0			; DATA XREF: sub_102B9+1Ar
					; sub_102B9+65w
unk_18FFC	db    0			; DATA XREF: sub_10564+Do sub_10740+6o ...
		db    0
word_18FFE	dw 209h			; DATA XREF: seg000:0F62w seg000:0F6Cr
byte_19000	db 0			; DATA XREF: seg000:loc_10F53r
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		dw offset unk_18FFC
unk_19010	db    0			; DATA XREF: seg000:0D65o seg000:0FBFo ...
		db    0
word_19012	dw 20Ah			; DATA XREF: seg000:0F9Ew seg000:0FA8r
byte_19014	db 1			; DATA XREF: seg000:0F8Fr
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		dw offset unk_19010
unk_19024	db    0			; DATA XREF: dseg:2BA6o
		db    0
		db    2
		db    2
		db    2
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		dw offset unk_19024
unk_19038	db    0			; DATA XREF: dseg:2BBAo
		db    0
		db  43h	; C
		db    2
		db    3
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		dw offset unk_19038
unk_1904C	db    0			; DATA XREF: dseg:2BCEo
		db    0
		db  42h	; B
		db    2
		db    4
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		dw offset unk_1904C
unk_19060	db    0			; DATA XREF: dseg:2BE2o
		db    0
		db    0
		db    0
		db 0FFh
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		dw offset unk_19060
unk_19074	db    0			; DATA XREF: dseg:2BF6o
		db    0
		db    0
		db    0
		db 0FFh
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		dw offset unk_19074
unk_19088	db    0			; DATA XREF: dseg:2C0Ao
		db    0
		db    0
		db    0
		db 0FFh
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		dw offset unk_19088
unk_1909C	db    0			; DATA XREF: dseg:2C1Eo
		db    0
		db    0
		db    0
		db 0FFh
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		dw offset unk_1909C
unk_190B0	db    0			; DATA XREF: dseg:2C32o
		db    0
		db    0
		db    0
		db 0FFh
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		dw offset unk_190B0
unk_190C4	db    0			; DATA XREF: dseg:2C46o
		db    0
		db    0
		db    0
		db 0FFh
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		dw offset unk_190C4
unk_190D8	db    0			; DATA XREF: dseg:2C5Ao
		db    0
		db    0
		db    0
		db 0FFh
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		dw offset unk_190D8
unk_190EC	db    0			; DATA XREF: dseg:2C6Eo
		db    0
		db    0
		db    0
		db 0FFh
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		dw offset unk_190EC
unk_19100	db    0			; DATA XREF: dseg:2C82o
		db    0
		db    0
		db    0
		db 0FFh
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		dw offset unk_19100
unk_19114	db    0			; DATA XREF: dseg:2C96o
		db    0
		db    0
		db    0
		db 0FFh
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		dw offset unk_19114
unk_19128	db    0			; DATA XREF: dseg:2CAAo
		db    0
		db    0
		db    0
		db 0FFh
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		dw offset unk_19128
unk_1913C	db    0			; DATA XREF: dseg:2CBEo
		db    0
		db    0
		db    0
		db 0FFh
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		dw offset unk_1913C
unk_19150	db    0			; DATA XREF: dseg:2CD2o
		db    0
		db    0
		db    0
		db 0FFh
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		dw offset unk_19150
unk_19164	db    0			; DATA XREF: dseg:2CE6o
		db    0
		db    0
		db    0
		db 0FFh
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		dw offset unk_19164
unk_19178	db    0			; DATA XREF: dseg:2CFAo
		db    0
		db    0
		db    0
		db 0FFh
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		dw offset unk_19178
word_1918C	dw 2001h, 2002h, 2002h	; DATA XREF: sub_10266+1Dw
					; sub_1158F+1Cr ...
		dw 0A004h, 0A002h
		db 1Eh dup(0FFh)
word_191B4	dw 4000h		; DATA XREF: sub_105A7:loc_1063Er
					; sub_11CB4+11r
word_191B6	dw 0FFFFh		; DATA XREF: sub_11CB4:loc_11CDAr
unk_191B8	db  0Dh			; DATA XREF: sub_10BFB+110o
		db    0
word_191BA	dw 1			; DATA XREF: sub_10F1C+6w sub_10F2D+4r ...
word_191BC	dw 0			; DATA XREF: sub_10F1C+9w sub_10F2Dr ...
word_191BE	dw 0			; DATA XREF: sub_10FCC:loc_1100Ar
					; sub_10FCC+4Cw
word_191C0	dw 0			; DATA XREF: sub_10FCC:loc_10FF4r
					; sub_10FCC+36w
word_191C2	dw 1000h		; DATA XREF: start+5Ar	start+67w ...
		dw 1C1Fh, 1E1Fh, 1E1Fh,	1F1Fh, 1F1Eh, 1F1Eh
aTmp		db 'TMP',0              ; DATA XREF: sub_114E2+1Bo
a_		db '.$$$',0             ; DATA XREF: sub_114E2+4Ao
		db    0
word_191DA	dw 0			; DATA XREF: sub_11AB8:loc_11ACBw
					; sub_11AB8+2Bw
byte_191DC	db 0, 13h, 2, 2, 4, 5, 6, 8, 8,	8, 14h,	15h, 5,	13h, 0FFh
					; DATA XREF: sub_11AB8+17r
		db 16h,	5, 11h,	2, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh
		db 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 5,	5, 0FFh
		db 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh
		db 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0Fh, 0FFh, 23h
		db 2, 0FFh, 0Fh, 0FFh, 0FFh, 0FFh, 0FFh, 13h, 0FFh, 0FFh
		db 2, 2, 5, 0Fh, 2, 0FFh, 0FFh,	0FFh, 13h, 0FFh, 0FFh
		db 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 23h, 0FFh, 0FFh
		db 0FFh, 0FFh, 23h, 0FFh, 13h
word_19234	dw 0FFh			; DATA XREF: sub_12216+78r
word_19236	dw 0, 1Fh, 3Bh,	5Ah, 78h, 97h, 0B5h, 0D4h, 0F3h, 111h
					; DATA XREF: sub_12216+2Er
					; sub_12216+50r ...
		dw 130h, 14Eh, 16Dh
word_19250	dw 2EEAh		; DATA XREF: sub_1202D+CFr
					; sub_1202D+118r ...
seg_19252	dw seg dseg		; DATA XREF: sub_1202D+CBr
					; sub_1202D+114r
word_19254	dw 2EEEh		; DATA XREF: sub_1202D+E4r
					; sub_1202D+FEr ...
seg_19256	dw seg dseg		; DATA XREF: sub_1202D+E0r
					; sub_1202D+FAr ...
word_19258	dw 8170h		; DATA XREF: sub_111B1+10r
					; sub_112DE+Br	...
word_1925A	dw 0FFFFh		; DATA XREF: sub_111B1+Dr sub_112DE+8r ...
word_1925C	dw 0			; DATA XREF: sub_111B1+B6r
					; sub_112DE:loc_113D8r	...
aTz		db 'TZ',0               ; DATA XREF: sub_1202D+5o
aJst		db 'JST',0              ; DATA XREF: sub_1202D+C7o
unk_19265	db    0			; DATA XREF: sub_1202D+DCo
aNull		db '(null)',0           ; DATA XREF: sub_12325+2EBo
byte_1926D	db 0			; DATA XREF: sub_12325+C3r
		db 14h,	14h, 1,	14h, 15h, 14h, 14h, 14h, 14h, 2, 0, 14h
		db 3, 4, 14h, 9, 5, 5, 5, 5, 5,	5, 5, 5, 5, 14h, 14h, 14h
		db 14h,	14h, 14h, 14h, 14h, 14h, 14h, 14h, 0Fh,	17h, 0Fh
		db 8, 14h, 14h,	14h, 7,	14h, 16h, 14h, 14h, 14h, 14h, 14h
		db 14h,	14h, 14h, 14h, 0Dh, 14h, 14h, 14h, 14h,	14h, 14h
		db 14h,	14h, 14h, 14h, 10h, 0Ah, 0Fh, 0Fh, 0Fh,	8, 0Ah
		db 14h,	14h, 6,	14h, 12h, 0Bh, 0Eh, 14h, 14h, 11h, 14h
		db 0Ch,	14h, 14h, 0Dh, 14h, 14h, 14h, 14h, 14h,	14h, 14h
		db 0
dword_192CE	dd 0			; DATA XREF: sub_11A1F+21r
					; seg000:2E03w	...
word_192D2	dw ?			; DATA XREF: start+A3o	start+A6o ...
word_192D4	dw ?			; DATA XREF: sub_1566E+12Bw
					; sub_1566E+349r ...
word_192D6	dw ?			; DATA XREF: sub_1566E+370r
					; sub_1566E+4FCr ...
word_192D8	dw ?			; DATA XREF: sub_1566E+36Cr
					; sub_1566E+4F8r ...
word_192DA	dw ?			; DATA XREF: sub_1566E+393r
					; sub_1566E+51Cr ...
word_192DC	dw ?			; DATA XREF: sub_1566E+38Fr
					; sub_1566E+518r ...
word_192DE	dw ?			; DATA XREF: sub_1566E+6E9r
					; sub_1566E+7C2r
word_192E0	dw ?			; DATA XREF: sub_1566E+6E5r
					; sub_1566E+7BEr
dword_192E2	dd ?			; DATA XREF: LoadVDF+7r LoadVDF+2Ar ...
dword_192E6	dd ?			; DATA XREF: seg000:0256w sub_10294+Dr ...
		db 7Ch dup(?)
byte_19366	db ?			; DATA XREF: sub_10BFB+7w
					; sub_10BFB+26r ...
		align 2
word_19368	dw ?			; DATA XREF: seg000:1551r
					; seg000:loc_11560w ...
byte_1936A	db ?, ?, ?, ?, ?, ?, ?,	?, ?, ?, ?, ?, ?, ? ; DATA XREF: sub_114E2+Bo
byte_19378	db ?			; DATA XREF: sub_1192F:loc_119F1r
					; sub_1192F+DCr
		align 20h
dseg		ends

; ===========================================================================

; Segment type:	Uninitialized
seg008		segment	byte stack 'STACK' use16
		assume cs:seg008
		assume es:nothing, ss:nothing, ds:dseg,	fs:nothing, gs:nothing
byte_19390	db 80h dup(?)
seg008		ends


		end start
