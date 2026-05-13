; Input	MD5   :	149818E90BE79C8F055CC64880B2A134
; Input	CRC32 :	6EC4420E

; File Name   :	R:\MESPUT.COM
; Format      :	MS-DOS COM-file
; Base Address:	1000h Range: 10100h-115F5h Loaded length: 14F5h

		.686p
		.mmx
		.model tiny

; ===========================================================================

; Segment type:	Pure code
seg000		segment	byte public 'CODE' use16
		assume cs:seg000
		org 100h
		assume es:nothing, ss:nothing, ds:seg000, fs:nothing, gs:nothing

; =============== S U B	R O U T	I N E =======================================

; Attributes: noreturn

		public start
start		proc near		; DATA XREF: start+39o
		mov	dx, offset IntF0
		mov	ax, cs
		mov	ds, ax
		mov	ah, 25h
		mov	al, 0F0h
		int	21h		; DOS -	SET INTERRUPT VECTOR
					; AL = interrupt number
					; DS:DX	= new vector to	be used	for specified interrupt
		mov	cl, 0Dh		; -> a46m
		mov	dx, offset a30m	; "\x1B[30m$"
		mov	ax, 6
		mul	cl
		add	dx, ax
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		mov	dx, offset msgResident ; "@@‚l‚d‚r‚o‚t‚sD‚b‚n‚l‚ªí’“‚µ‚Ü‚µ‚½"...
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		mov	cl, 7		; -> a37m
		mov	dx, offset a30m	; "\x1B[30m$"
		mov	ax, 6
		mul	cl
		add	dx, ax
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		mov	ah, 31h
		mov	dx, 14F5h	; size of the COM file (for TSR	feature)
		add	dx, offset start
		shr	dx, 1
		shr	dx, 1
		shr	dx, 1
		shr	dx, 1
		inc	dx
		int	21h		; DOS -	DOS 2+ - TERMINATE BUT STAY RESIDENT
start		endp			; AL = exit code, DX = program size, in	paragraphs

; ---------------------------------------------------------------------------
msgResident	db '@@‚l‚d‚r‚o‚t‚sD‚b‚n‚l‚ªí’“‚µ‚Ü‚µ‚½@@',0Dh,0Ah
					; DATA XREF: start+1Do
		db '@@Š„‚èž‚ÝƒxƒNƒgƒ‹‚Í‚e‚O‚g‚Å‚·@@@@@',0Dh,0Ah,'$' ; "  MESPUT.COM is now resident.  "
					; "  The interrupt vector is F0H.  "
; ---------------------------------------------------------------------------

IntF0:					; DATA XREF: starto
		push	ax
		push	bx
		push	cx
		push	dx
		push	si
		push	di
		push	ds
		push	es
		mov	cs:word_115EC, ds
		mov	bx, cs
		mov	ds, bx
		mov	es, bx
		assume es:seg000
		sti
		mov	word_115D6, dx
		mov	word_115D8, di
		mov	word_115D0, si
		mov	byte_115D5, al
		mov	blitMode, 0
		mov	waitTime, 16
		mov	drawInverted, 0
		cld
		mov	bh, 0
		mov	bl, ah
		add	bx, bx
		add	bx, offset apiJumpTable
		call	sub_101EA
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


sub_101EA	proc near		; CODE XREF: seg000:01DEp
		jmp	word ptr [bx]
sub_101EA	endp

; ---------------------------------------------------------------------------
apiJumpTable	dw offset api0_drawText	; 0 ; DATA XREF: seg000:01DAo
		dw offset api1		; 1
		dw offset api2_blit	; 2
		dw offset api3_clearDungeon; 3
		dw offset api4_drawSelect; 4
		dw offset api5		; 5
		dw offset api6_waitSelKey; 6
		dw offset api7_drawInt3	; 7
		dw offset api8_drawInt5	; 8
		dw offset api0_drawText	; 9
; ---------------------------------------------------------------------------

api1:					; DATA XREF: seg000:apiJumpTableo
		push	ds
		mov	ds, cs:word_115EC
		mov	di, offset textBoxXStart
		mov	cx, 4
		cld
		rep movsw
		pop	ds
		call	sub_10214
		retn

; =============== S U B	R O U T	I N E =======================================


sub_10214	proc near		; CODE XREF: seg000:0210p
		mov	ax, textBoxXStart
		mov	textPosX, ax
		mov	ax, textBoxYStart
		mov	textPosY, ax
		retn
sub_10214	endp


; =============== S U B	R O U T	I N E =======================================


api0_drawText	proc near		; CODE XREF: seg000:0664p
					; DATA XREF: seg000:apiJumpTableo

; FUNCTION CHUNK AT 0332 SIZE 0000008C BYTES

		mov	ax, 1B01h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		push	ds
		xor	ax, ax
		mov	ds, ax
		assume ds:nothing
		or	word ptr ds:500h, 20h
		pop	ds
		assume ds:seg000
		mov	textColor, 7
		mov	textErrorExit, 0
		mov	si, word_115D0

loc_1023F:				; CODE XREF: api0_drawText+3Ej
					; api0_drawText+CEj ...
		cmp	textErrorExit, 0
		jz	short loc_10249
		jmp	dtxt0A_end
; ---------------------------------------------------------------------------

loc_10249:				; CODE XREF: api0_drawText+23j
		push	ds
		mov	ds, word_115EC
		lodsw
		pop	ds
		cmp	al, 0
		jnz	short loc_10257
		jmp	dtxt0A_end
; ---------------------------------------------------------------------------

loc_10257:				; CODE XREF: api0_drawText+31j
		cmp	al, 9
		ja	short loc_10261

dtxt09_color:
		mov	textColor, al
		dec	si
		jmp	short loc_1023F
; ---------------------------------------------------------------------------

loc_10261:				; CODE XREF: api0_drawText+38j
		cmp	al, '+'
		jnz	short loc_10268
		jmp	dtxt2B_xadd
; ---------------------------------------------------------------------------

loc_10268:				; CODE XREF: api0_drawText+42j
		cmp	al, 1Ch
		jnz	short loc_1026F
		jmp	dtxt1C
; ---------------------------------------------------------------------------

loc_1026F:				; CODE XREF: api0_drawText+49j
		cmp	al, 30h
		jnz	short loc_10276
		jmp	dtxt30
; ---------------------------------------------------------------------------

loc_10276:				; CODE XREF: api0_drawText+50j
		cmp	al, '$'
		jz	short dtxt24_blit_end
		cmp	al, 0Dh
		jz	short dtxt0D
		cmp	al, 1Ah
		jnz	short loc_10285
		jmp	dtxt1A_esc
; ---------------------------------------------------------------------------

loc_10285:				; CODE XREF: api0_drawText+5Fj
		cmp	al, 0Ah
		jz	short dtxt0A_end
		cmp	al, 12h
		jnz	short loc_10290
		jmp	dtxt12
; ---------------------------------------------------------------------------

loc_10290:				; CODE XREF: api0_drawText+6Aj
		cmp	al, 13h
		jnz	short loc_10297
		jmp	dtxt13
; ---------------------------------------------------------------------------

loc_10297:				; CODE XREF: api0_drawText+71j
		cmp	al, 58h
		jz	short dtxt58_xset
		cmp	al, 59h
		jz	short dtxt59_yset
		cmp	al, 10h
		jnz	short loc_102A6

dtxt_10_transp:
		call	SetBlitTransp

loc_102A6:				; CODE XREF: api0_drawText+80j
		cmp	al, 11h
		jnz	short dtxt_sjis

dtxt_11_opaque:
		call	SetBlitOpaque

dtxt_sjis:				; CODE XREF: api0_drawText+87j
		xchg	ah, al
		push	si
		mov	dx, ax
		mov	al, dh
		sub	al, 70h
		cmp	al, 30h
		jb	short loc_102BC
		sub	al, 40h

loc_102BC:				; CODE XREF: api0_drawText+97j
		add	al, al
		mov	dh, al
		mov	al, dl
		cmp	al, 80h
		jb	short loc_102C8
		dec	al

loc_102C8:				; CODE XREF: api0_drawText+A3j
		cmp	al, 9Eh
		jb	short loc_102D0
		sub	al, 5Eh
		inc	dh

loc_102D0:				; CODE XREF: api0_drawText+A9j
		dec	dh
		sub	al, 1Fh
		mov	ah, dh
		mov	dx, ax
		mov	cx, offset chrDataRecvHdr
		mov	bx, cs
		mov	ah, 14h
		int	18h		; get character	data (DX = JIS code)
		call	DrawTextChar
		cmp	waitTime, 0
		jz	short loc_102EE
		call	WaitABit

loc_102EE:				; CODE XREF: api0_drawText+C8j
		pop	si
		jmp	loc_1023F
; ---------------------------------------------------------------------------

dtxt24_blit_end:			; CODE XREF: api0_drawText+57j
		call	api2_blit
		dec	si
		jmp	short dtxt0A_end
; ---------------------------------------------------------------------------

dtxt0D:					; CODE XREF: api0_drawText+5Bj
		push	si
		call	WaitForKeyPress
		pop	si
		dec	si
		jmp	loc_1023F
; ---------------------------------------------------------------------------

dtxt0A_end:				; CODE XREF: api0_drawText+25j
					; api0_drawText+33j ...
		mov	ax, 1B00h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		retn
; ---------------------------------------------------------------------------

dtxt2B_xadd:				; CODE XREF: api0_drawText+44j
		mov	al, ah
		mov	ah, 0
		add	textPosX, ax
		jmp	loc_1023F
; ---------------------------------------------------------------------------

dtxt58_xset:				; CODE XREF: api0_drawText+78j
		mov	al, ah
		mov	ah, 0
		mov	textPosX, ax
		jmp	loc_1023F
; ---------------------------------------------------------------------------

dtxt59_yset:				; CODE XREF: api0_drawText+7Cj
		mov	al, ah
		mov	ah, 0
		mov	textPosY, ax
		jmp	loc_1023F
api0_drawText	endp


; =============== S U B	R O U T	I N E =======================================


SetBlitTransp	proc near		; CODE XREF: api0_drawText:dtxt_10_transpp
		mov	blitMode, 1
		retn
SetBlitTransp	endp


; =============== S U B	R O U T	I N E =======================================


SetBlitOpaque	proc near		; CODE XREF: api0_drawText:dtxt_11_opaquep
		mov	blitMode, 0
		retn
SetBlitOpaque	endp

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR api0_drawText

dtxt1A_esc:				; CODE XREF: api0_drawText+61j
		call	api2_blit
		dec	si
		jmp	loc_1023F
; ---------------------------------------------------------------------------

dtxt1C:					; CODE XREF: api0_drawText+4Bj
		inc	api4TextPosX
		inc	api4TextPosX
		dec	si
		jmp	loc_1023F
; ---------------------------------------------------------------------------

dtxt30:					; CODE XREF: api0_drawText+52j
		mov	api4TextPosY, 750h
		mov	api4TextPosX, 0
		mov	byte_115D3, 1
		dec	si
		jmp	loc_1023F
; ---------------------------------------------------------------------------

dtxt12:					; CODE XREF: api0_drawText+6Cj
		mov	ax, textBoxXStart
		mov	textPosX, ax
		add	textPosY, 10h
		dec	si
		jmp	loc_1023F
; ---------------------------------------------------------------------------

dtxt13:					; CODE XREF: api0_drawText+73j
		mov	bp, textBoxXEnd
		sub	bp, textBoxXStart
		inc	bp
		mov	ax, textPosY
		shl	ax, 1
		shl	ax, 1
		shl	ax, 1
		shl	ax, 1
		mov	dx, ax
		shl	ax, 1
		shl	ax, 1
		add	ax, dx
		add	ax, textBoxXStart
		mov	di, ax
		push	es
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		mov	dx, 50h
		mov	cx, 10h

loc_10397:				; CODE XREF: api0_drawText+190j
		push	cx
		push	di
		mov	al, 80h
		cli
		out	7Ch, al
		xor	ax, ax
		out	7Eh, al
		out	7Eh, al
		out	7Eh, al
		mov	cx, bp
		rep stosb
		out	7Ch, al
		sti
		pop	di
		pop	cx
		add	di, dx
		loop	loc_10397
		pop	es
		assume es:nothing
		mov	ax, textBoxXStart
		mov	textPosX, ax
		dec	si
		jmp	loc_1023F
; END OF FUNCTION CHUNK	FOR api0_drawText

; =============== S U B	R O U T	I N E =======================================


WaitForKeyPress	proc near		; CODE XREF: api0_drawText+D8p
					; DrawTextChar+7p
		mov	textErrorExit, 0
		mov	byte_115F0, 1

loc_103C8:				; CODE XREF: WaitForKeyPress+30j
					; WaitForKeyPress+39j
		call	WaitABit
		mov	ax, 403h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		test	ah, 10h
		jnz	short loc_103F0
		mov	ax, 406h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		test	ah, 10h
		jnz	short loc_103F0
		mov	ax, 400h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		test	ah, 1
		jnz	short loc_103FA
		mov	byte_115F0, 0
		jmp	short loc_103C8
; ---------------------------------------------------------------------------

loc_103F0:				; CODE XREF: WaitForKeyPress+15j
					; WaitForKeyPress+1Fj
		cmp	byte_115F0, 0
		jz	short locret_103F9
		jmp	short loc_103C8
; ---------------------------------------------------------------------------

locret_103F9:				; CODE XREF: WaitForKeyPress+37j
		retn
; ---------------------------------------------------------------------------

loc_103FA:				; CODE XREF: WaitForKeyPress+29j
		mov	textErrorExit, 1
		retn
WaitForKeyPress	endp


; =============== S U B	R O U T	I N E =======================================


WaitABit	proc near		; CODE XREF: api0_drawText+CAp
					; WaitForKeyPress:loc_103C8p ...
		push	cx
		xor	cx, cx
		mov	ch, waitTime

loc_10407:				; CODE XREF: WaitABit+Cj
		nop
		nop
		nop
		nop
		nop
		loop	loc_10407	; loop waitTime*256 times
		pop	cx
		retn
WaitABit	endp


; =============== S U B	R O U T	I N E =======================================


api2_blit	proc near		; CODE XREF: api0_drawText:dtxt24_blit_endp
					; api0_drawText:dtxt1A_escp ...
		push	si
		mov	bx, textBoxYStart
		mov	textPosY, bx
		mov	cx, textBoxXStart
		mov	textPosX, cx
		mov	ax, bx
		shl	ax, 1
		shl	ax, 1
		shl	ax, 1
		shl	ax, 1
		mov	dx, ax
		shl	ax, 1
		shl	ax, 1
		add	ax, dx
		add	ax, cx
		mov	dx, ax
		mov	bx, textBoxYEnd
		sub	bx, textBoxYStart
		mov	bp, textBoxXEnd
		sub	bp, textBoxXStart
		inc	bp
		mov	si, 50h
		sub	si, bp
		push	es
		mov	ax, 0A800h
		call	Blit8xN
		mov	ax, 0B000h
		call	Blit8xN
		mov	ax, 0B800h
		call	Blit8xN
		pop	es
		pop	si
		retn
api2_blit	endp


; =============== S U B	R O U T	I N E =======================================


Blit8xN		proc near		; CODE XREF: api2_blit+41p
					; api2_blit+47p ...
		push	bx
		mov	es, ax
		xor	ax, ax
		mov	di, dx

loc_1046A:				; CODE XREF: Blit8xN+Ej
		mov	cx, bp
		rep stosb
		add	di, si
		dec	bx
		jnz	short loc_1046A
		pop	bx
		retn
Blit8xN		endp


; =============== S U B	R O U T	I N E =======================================


DrawTextChar	proc near		; CODE XREF: api0_drawText+C0p

; FUNCTION CHUNK AT 0670 SIZE 00000026 BYTES

		cmp	textPosIsBad, 0
		jz	short loc_10482
		call	WaitForKeyPress
		call	api2_blit

loc_10482:				; CODE XREF: DrawTextChar+5j
		cmp	drawInverted, 0
		jz	short loc_1048C
		jmp	dtc_inverted
; ---------------------------------------------------------------------------

loc_1048C:				; CODE XREF: DrawTextChar+12j
					; PrintChar+32p
		call	CalcTOfsAndWrap
		test	textColor, 1
		jz	short loc_1049C
		mov	ax, 0A800h
		call	Blit8x16

loc_1049C:				; CODE XREF: DrawTextChar+1Fj
		test	textColor, 2
		jz	short loc_104A9
		mov	ax, 0B000h
		call	Blit8x16

loc_104A9:				; CODE XREF: DrawTextChar+2Cj
		test	textColor, 4
		jz	short locret_104B6
		mov	ax, 0B800h
		call	Blit8x16

locret_104B6:				; CODE XREF: DrawTextChar+39j
		retn
DrawTextChar	endp


; =============== S U B	R O U T	I N E =======================================


Blit8x16	proc near		; CODE XREF: DrawTextChar+24p
					; DrawTextChar+31p ...
		cmp	blitMode, 0
		jnz	short loc_104D3	; blitMode == 1	-> transparent drawing
		push	es		; blitMode == 0	-> opaque drawing
		mov	es, ax
		mov	di, dx
		mov	si, offset chrDataRecvBuf
		mov	cx, 10h
		mov	bx, 4Eh

loc_104CC:				; CODE XREF: Blit8x16+18j
		movsw
		add	di, bx
		loop	loc_104CC
		pop	es
		retn
; ---------------------------------------------------------------------------

loc_104D3:				; CODE XREF: Blit8x16+5j
		push	es
		mov	es, ax
		mov	di, dx
		mov	si, offset chrDataRecvBuf
		mov	cx, 10h
		mov	bx, 4Eh

loc_104E1:				; CODE XREF: Blit8x16+30j
		lodsw
		not	ax
		stosw
		add	di, bx
		loop	loc_104E1
		pop	es
		retn
Blit8x16	endp


; =============== S U B	R O U T	I N E =======================================


CalcTOfsAndWrap	proc near		; CODE XREF: DrawTextChar:loc_1048Cp
					; seg000:0543p	...
		mov	textPosIsBad, 0
		mov	ax, textPosY
		shl	ax, 1
		shl	ax, 1
		shl	ax, 1
		shl	ax, 1
		mov	dx, ax
		shl	ax, 1
		shl	ax, 1
		add	ax, dx
		add	ax, textPosX
		mov	dx, ax		; [output] DX =	VRAM offset for	text
		mov	ax, textPosX
		add	ax, 2		; increase X position by 2 (== 16 pixels) <-- modify for half-width support
		mov	textPosX, ax
		cmp	ax, textBoxXEnd
		jb	short locret_10538
		mov	ax, textBoxXStart
		mov	textPosX, ax
		mov	ax, textPosY
		add	ax, 16
		mov	textPosY, ax
		cmp	ax, textBoxYEnd
		jb	short locret_10538
		mov	ax, textBoxYStart
		mov	textPosY, ax
		mov	textPosIsBad, 1

locret_10538:				; CODE XREF: CalcTOfsAndWrap+2Bj
					; CalcTOfsAndWrap+40j
		retn
CalcTOfsAndWrap	endp

; ---------------------------------------------------------------------------

api7_drawInt3:				; DATA XREF: seg000:apiJumpTableo
		mov	textColor, 7
		mov	ax, 1B01h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		call	CalcTOfsAndWrap
		mov	ax, word_115D6
		xor	ah, ah
		mov	byte_115F4, 0
		mov	cl, 100
		call	PrintDigit
		mov	al, ah
		mov	cl, 10
		call	PrintDigit
		mov	al, ah
		xor	ah, ah
		add	ax, 824Fh
		call	PrintChar
		mov	ax, 1B00h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		retn

; =============== S U B	R O U T	I N E =======================================


PrintDigit_NoPad proc near		; CODE XREF: seg000:05AEp seg000:05B6p ...
		xor	dx, dx
		div	cx
		and	ax, ax
		jz	short loc_1058E
		jmp	short loc_1057E
PrintDigit_NoPad endp


; =============== S U B	R O U T	I N E =======================================


PrintDigit	proc near		; CODE XREF: seg000:0552p seg000:0559p
		xor	ah, ah
		div	cl
		and	al, al
		jz	short loc_1058E

loc_1057E:				; CODE XREF: PrintDigit_NoPad+8j
					; PrintDigit+1Dj
		push	ax
		xor	ah, ah
		add	ax, 824Fh
		call	PrintChar
		pop	ax
		mov	byte_115F4, 1
		retn
; ---------------------------------------------------------------------------

loc_1058E:				; CODE XREF: PrintDigit_NoPad+6j
					; PrintDigit+6j
		cmp	byte_115F4, 0
		jnz	short loc_1057E
		retn
PrintDigit	endp

; ---------------------------------------------------------------------------

api8_drawInt5:				; DATA XREF: seg000:apiJumpTableo
		mov	textColor, 7
		mov	ax, 1B01h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		call	CalcTOfsAndWrap
		mov	ax, word_115D6
		mov	byte_115F4, 0
		mov	cx, 10000
		call	PrintDigit_NoPad
		mov	ax, dx
		mov	cx, 1000
		call	PrintDigit_NoPad
		mov	ax, dx
		mov	cx, 100
		call	PrintDigit_NoPad
		mov	ax, dx
		mov	cx, 10
		call	PrintDigit_NoPad
		mov	ax, dx
		xor	ah, ah
		add	ax, 824Fh
		call	PrintChar
		mov	ax, 1B00h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		retn

; =============== S U B	R O U T	I N E =======================================


PrintChar	proc near		; CODE XREF: seg000:0563p
					; PrintDigit+Ep ...
		pusha
		mov	dx, ax
		mov	al, dh
		sub	al, 70h
		cmp	al, 30h
		jb	short loc_105E6
		sub	al, 40h

loc_105E6:				; CODE XREF: PrintChar+9j
		add	al, al
		mov	dh, al
		mov	al, dl
		cmp	al, 80h
		jb	short loc_105F2
		dec	al

loc_105F2:				; CODE XREF: PrintChar+15j
		cmp	al, 9Eh
		jb	short loc_105FA
		sub	al, 5Eh
		inc	dh

loc_105FA:				; CODE XREF: PrintChar+1Bj
		dec	dh
		sub	al, 1Fh
		mov	ah, dh
		mov	dx, ax
		mov	cx, offset chrDataRecvHdr
		mov	bx, cs
		mov	ah, 14h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		call	loc_1048C
		popa
		retn
PrintChar	endp

; ---------------------------------------------------------------------------

api3_clearDungeon:			; DATA XREF: seg000:apiJumpTableo
		mov	di, 321		; start	X = pixel 8 (column 1),	Y = 40 pixel
		mov	dx, 20		; skip 20 bytes	each line (60+20 = 80 =	line size)
		mov	bp, 320		; 320 lines to clear
		mov	bx, 30		; copy width = 30*2 (480 pixels)
		mov	es, word_115E6
		assume es:nothing
		cli
		mov	al, 80h
		out	7Ch, al
		xor	ax, ax
		out	7Eh, al
		out	7Eh, al
		out	7Eh, al

loc_1062D:				; CODE XREF: seg000:0634j
		mov	cx, bx
		rep stosw
		add	di, dx
		dec	bp
		jnz	short loc_1062D
		xor	ax, ax
		out	7Ch, al
		sti
		retn
; ---------------------------------------------------------------------------

api4_drawSelect:			; DATA XREF: seg000:apiJumpTableo
		mov	waitTime, 0
		mov	drawInverted, 1
		mov	byte_115D2, 0
		mov	byte_115D3, 0
		mov	api4TextPosX, 0
		mov	api4TextPosY, 0
		mov	textColor, 7
		call	ClearTextBox
		call	api0_drawText
		call	RestoreTextBox
		mov	ax, 1B00h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		retn
; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR DrawTextChar

dtc_inverted:				; CODE XREF: DrawTextChar+14j
		mov	di, api4TextPosY
		add	di, api4TextPosX
		add	di, offset textDrawBuffer
		mov	si, offset chrDataRecvBuf
		inc	api4TextPosX
		inc	api4TextPosX
		mov	cx, 10h
		mov	bx, 4Ch

loc_1068D:				; CODE XREF: DrawTextChar+21Ej
		lodsw
		not	ax
		stosw
		add	di, bx
		loop	loc_1068D
		retn
; END OF FUNCTION CHUNK	FOR DrawTextChar

; =============== S U B	R O U T	I N E =======================================


ClearTextBox	proc near		; CODE XREF: seg000:0661p
		mov	di, offset textDrawBuffer
		xor	ax, ax
		mov	cx, 618h	; 40 lines (39 [line width] * 2	[word size] * 40 [lines] = 1560	[bytes]
		rep stosw
		retn
ClearTextBox	endp


; =============== S U B	R O U T	I N E =======================================


RestoreTextBox	proc near		; CODE XREF: seg000:0667p
		push	es
		mov	es, word_115E6
		mov	si, offset textDrawBuffer
		call	TextBoxBuf2VRAM
		pop	es
		assume es:nothing
		retn
RestoreTextBox	endp


; =============== S U B	R O U T	I N E =======================================


TextBoxBuf2VRAM	proc near		; CODE XREF: RestoreTextBox+8p
					; seg000:0730p	...
		mov	di, 76C1h	; X = pixel 8 (column 1), Y = pixel 380
		mov	bx, 39		; copy width = 39*2 (624 pixels)
		mov	dx, 2
		mov	cx, 10h

loc_106BA:				; CODE XREF: TextBoxBuf2VRAM+10j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		and	al, 20h
		jnz	short loc_106BA

loc_106C0:				; CODE XREF: TextBoxBuf2VRAM+16j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		and	al, 20h
		jz	short loc_106C0

loc_106C6:				; CODE XREF: TextBoxBuf2VRAM+4Cj
		push	cx
		cli
		mov	al, 80h
		out	7Ch, al
		xor	ax, ax
		out	7Eh, al
		out	7Eh, al
		out	7Eh, al
		xor	ax, ax
		push	di
		mov	cx, bx
		rep stosw
		pop	di
		xor	ax, ax
		out	7Ch, al
		sti
		mov	al, 0C0h
		cli
		out	7Ch, al
		mov	al, 0FFh
		out	7Eh, al
		out	7Eh, al
		out	7Eh, al
		mov	cx, bx
		rep movsw
		xor	ax, ax
		out	7Ch, al
		sti
		add	di, dx
		pop	cx
		loop	loc_106C6
		retn
TextBoxBuf2VRAM	endp

; ---------------------------------------------------------------------------

api5:					; DATA XREF: seg000:apiJumpTableo
		cmp	byte_115D3, 0
		jz	short loc_1075B
		cmp	byte_115D5, 0
		jnz	short loc_1075B
		push	es
		mov	es, word_115E6
		assume es:nothing
		mov	waitTime, 1
		mov	cx, 18h
		cmp	byte_115D2, 0
		jnz	short loc_1073E
		xor	bp, bp

loc_10721:				; CODE XREF: seg000:0735j
		push	cx
		mov	ax, 4Eh
		mul	bp
		mov	si, ax
		add	si, 9C9h
		call	WaitABit
		call	TextBoxBuf2VRAM
		pop	cx
		inc	bp
		loop	loc_10721
		pop	es
		assume es:nothing
		mov	byte_115D2, 1
		retn
; ---------------------------------------------------------------------------

loc_1073E:				; CODE XREF: seg000:071Dj seg000:0752j
		push	cx
		mov	ax, 4Eh
		mul	cx
		mov	si, ax
		add	si, 92Dh
		call	WaitABit
		call	TextBoxBuf2VRAM
		pop	cx
		inc	bp
		loop	loc_1073E
		pop	es
		mov	byte_115D2, 0
		retn
; ---------------------------------------------------------------------------

loc_1075B:				; CODE XREF: seg000:0702j seg000:0709j
		mov	al, byte_115D2
		jmp	short loc_107C2
; ---------------------------------------------------------------------------

api6_waitSelKey:			; DATA XREF: seg000:apiJumpTableo
		mov	byte_115F3, 1	; wait for pressing a key during the selection

a6_loop:				; CODE XREF: seg000:07C0j seg000:07D8j ...
		mov	al, 0Ch
		mov	ah, 4
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		test	ah, 4
		jnz	short loc_107D3
		test	ah, 8
		jnz	short loc_107F2
		test	ah, 10h
		jz	short loc_1077D
		jmp	loc_10811
; ---------------------------------------------------------------------------

loc_1077D:				; CODE XREF: seg000:0778j
		test	ah, 20h
		jz	short loc_10785
		jmp	loc_10830
; ---------------------------------------------------------------------------

loc_10785:				; CODE XREF: seg000:0780j
		test	ah, 40h
		jz	short loc_1078D
		jmp	loc_10850
; ---------------------------------------------------------------------------

loc_1078D:				; CODE XREF: seg000:0788j
		test	ah, 80h
		jz	short loc_10795
		jmp	loc_10870
; ---------------------------------------------------------------------------

loc_10795:				; CODE XREF: seg000:0790j
		mov	al, 0Dh
		mov	ah, 4
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		test	ah, 1
		jz	short loc_107A3
		jmp	loc_10882
; ---------------------------------------------------------------------------

loc_107A3:				; CODE XREF: seg000:079Ej
		test	ah, 2
		jz	short loc_107AB
		jmp	loc_10894
; ---------------------------------------------------------------------------

loc_107AB:				; CODE XREF: seg000:07A6j
		test	ah, 4
		jz	short loc_107B3
		jmp	loc_108A6
; ---------------------------------------------------------------------------

loc_107B3:				; CODE XREF: seg000:07AEj
		test	ah, 8
		jz	short loc_107BB
		jmp	loc_108B8
; ---------------------------------------------------------------------------

loc_107BB:				; CODE XREF: seg000:07B6j
		mov	byte_115F3, 0
		jmp	short a6_loop
; ---------------------------------------------------------------------------

loc_107C2:				; CODE XREF: seg000:075Ej seg000:07F0j ...
		mov	selectKeyPress,	al
		pop	bx
		pop	es
		pop	ds
		pop	di
		pop	si
		pop	dx
		pop	cx
		pop	bx
		pop	ax
		mov	al, cs:selectKeyPress ;	return selected	key - 1	= F1, 9	= F9
		iret
; ---------------------------------------------------------------------------

loc_107D3:				; CODE XREF: seg000:076Ej
		cmp	byte_115F3, 0
		jnz	short a6_loop
		cmp	byte_115D3, 0
		jz	short loc_107EB
		cmp	byte_115D2, 0
		jz	short loc_107EB
		jmp	loc_10870
; ---------------------------------------------------------------------------

loc_107EB:				; CODE XREF: seg000:07DFj seg000:07E6j
		mov	al, 1
		call	ShowMenuSelect
		jmp	short loc_107C2
; ---------------------------------------------------------------------------

loc_107F2:				; CODE XREF: seg000:0773j
		cmp	byte_115F3, 0
		jz	short loc_107FC
		jmp	a6_loop
; ---------------------------------------------------------------------------

loc_107FC:				; CODE XREF: seg000:07F7j
		cmp	byte_115D3, 0
		jz	short loc_1080A
		cmp	byte_115D2, 0
		jnz	short loc_10882

loc_1080A:				; CODE XREF: seg000:0801j
		mov	al, 2
		call	ShowMenuSelect
		jmp	short loc_107C2
; ---------------------------------------------------------------------------

loc_10811:				; CODE XREF: seg000:077Aj
		cmp	byte_115F3, 0
		jz	short loc_1081B
		jmp	a6_loop
; ---------------------------------------------------------------------------

loc_1081B:				; CODE XREF: seg000:0816j
		cmp	byte_115D3, 0
		jz	short loc_10829
		cmp	byte_115D2, 0
		jnz	short loc_10894

loc_10829:				; CODE XREF: seg000:0820j
		mov	al, 3
		call	ShowMenuSelect
		jmp	short loc_107C2
; ---------------------------------------------------------------------------

loc_10830:				; CODE XREF: seg000:0782j
		cmp	byte_115F3, 0
		jz	short loc_1083A
		jmp	a6_loop
; ---------------------------------------------------------------------------

loc_1083A:				; CODE XREF: seg000:0835j
		cmp	byte_115D3, 0
		jz	short loc_10848
		cmp	byte_115D2, 0
		jnz	short loc_108A6

loc_10848:				; CODE XREF: seg000:083Fj
		mov	al, 4
		call	ShowMenuSelect
		jmp	loc_107C2
; ---------------------------------------------------------------------------

loc_10850:				; CODE XREF: seg000:078Aj
		cmp	byte_115F3, 0
		jz	short loc_1085A
		jmp	a6_loop
; ---------------------------------------------------------------------------

loc_1085A:				; CODE XREF: seg000:0855j
		cmp	byte_115D3, 0
		jz	short loc_10868
		cmp	byte_115D2, 0
		jnz	short loc_108B8

loc_10868:				; CODE XREF: seg000:085Fj
		mov	al, 5
		call	ShowMenuSelect
		jmp	loc_107C2
; ---------------------------------------------------------------------------

loc_10870:				; CODE XREF: seg000:0792j seg000:07E8j
		cmp	byte_115F3, 0
		jz	short loc_1087A
		jmp	a6_loop
; ---------------------------------------------------------------------------

loc_1087A:				; CODE XREF: seg000:0875j
		mov	al, 6
		call	ShowMenuSelect
		jmp	loc_107C2
; ---------------------------------------------------------------------------

loc_10882:				; CODE XREF: seg000:07A0j seg000:0808j
		cmp	byte_115F3, 0
		jz	short loc_1088C
		jmp	a6_loop
; ---------------------------------------------------------------------------

loc_1088C:				; CODE XREF: seg000:0887j
		mov	al, 7
		call	ShowMenuSelect
		jmp	loc_107C2
; ---------------------------------------------------------------------------

loc_10894:				; CODE XREF: seg000:07A8j seg000:0827j
		cmp	byte_115F3, 0
		jz	short loc_1089E
		jmp	a6_loop
; ---------------------------------------------------------------------------

loc_1089E:				; CODE XREF: seg000:0899j
		mov	al, 8
		call	ShowMenuSelect
		jmp	loc_107C2
; ---------------------------------------------------------------------------

loc_108A6:				; CODE XREF: seg000:07B0j seg000:0846j
		cmp	byte_115F3, 0
		jz	short loc_108B0
		jmp	a6_loop
; ---------------------------------------------------------------------------

loc_108B0:				; CODE XREF: seg000:08ABj
		mov	al, 9
		call	ShowMenuSelect
		jmp	loc_107C2
; ---------------------------------------------------------------------------

loc_108B8:				; CODE XREF: seg000:07B8j seg000:0866j
		cmp	byte_115F3, 0
		jz	short loc_108C2
		jmp	a6_loop
; ---------------------------------------------------------------------------

loc_108C2:				; CODE XREF: seg000:08BDj
		mov	al, 0Ah
		call	ShowMenuSelect
		jmp	loc_107C2

; =============== S U B	R O U T	I N E =======================================


ShowMenuSelect	proc near		; CODE XREF: seg000:07EDp seg000:080Cp ...
		push	ds		; change colour	of selected action entry
		push	ax
		dec	al		; The first entry has index 1.
		shl	al, 4		; each entry = 16 half-width characters
		xor	ah, ah
		add	ax, 76C1h	; add VRAM start offset
		mov	di, ax
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		cli
		mov	al, 83h
		out	7Ch, al
		xor	ax, ax
		out	7Eh, al
		out	7Eh, al
		out	7Eh, al
		mov	bx, 10h		; do 16	lines
		mov	bp, 40h		; 50h (line size) - 10h	(16 HW-chars) =	40h
		mov	dx, 8		; 8 words = 16 half-width characters

loc_108F3:				; CODE XREF: ShowMenuSelect+30j
		mov	cx, dx
		rep stosw
		add	di, bp
		dec	bx
		jnz	short loc_108F3
		xor	ax, ax
		out	7Ch, al
		sti
		pop	ax
		pop	ds
		retn
ShowMenuSelect	endp

; ---------------------------------------------------------------------------
a000000h	db 1Bh,'[000;000H$'     ; unused
a000c		db 1Bh,'[000C$'         ; unused
a30m		db 1Bh,'[30m$'          ; DATA XREF: start+Fo start+26o
a34m		db 1Bh,'[34m$'
a31m		db 1Bh,'[31m$'
a35m		db 1Bh,'[35m$'
a32m		db 1Bh,'[32m$'
a36m		db 1Bh,'[36m$'
a33m		db 1Bh,'[33m$'
a37m		db 1Bh,'[37m$'
a40m		db 1Bh,'[40m$'
a44m		db 1Bh,'[44m$'
a41m		db 1Bh,'[41m$'
a45m		db 1Bh,'[45m$'
a42m		db 1Bh,'[42m$'
a46m		db 1Bh,'[46m$'
a43m		db 1Bh,'[43m$'
a47m		db 1Bh,'[47m$'
api4TextPosX	dw 0			; DATA XREF: api0_drawText:dtxt1Cw
					; api0_drawText+11Cw ...
api4TextPosY	dw 0			; DATA XREF: api0_drawText:dtxt30w
					; seg000:0656w	...
		db    0
textDrawBuffer	db 0C30h dup(0)		; DATA XREF: DrawTextChar+203o
					; ClearTextBoxo ...
		db    0
chrDataRecvHdr	db 0, 0			; DATA XREF: api0_drawText+B7o
					; PrintChar+29o
chrDataRecvBuf	db 20h dup(0)		; DATA XREF: Blit8x16+Co Blit8x16+21o	...
textColor	db 0			; DATA XREF: api0_drawText+10w
					; api0_drawText:dtxt09_colorw ...
textPosIsBad	db 0			; DATA XREF: DrawTextCharr
					; CalcTOfsAndWrapw ...
word_115D0	dw 0			; DATA XREF: seg000:01BDw
					; api0_drawText+1Ar
byte_115D2	db 0			; DATA XREF: seg000:0646w seg000:0718r ...
byte_115D3	db 0			; DATA XREF: api0_drawText+130w
					; seg000:064Bw	...
selectKeyPress	db 0			; DATA XREF: seg000:loc_107C2w
					; seg000:07CEr
byte_115D5	db 0			; DATA XREF: seg000:01C1w seg000:0704r
word_115D6	dw 0			; DATA XREF: seg000:01B5w seg000:0546r ...
word_115D8	dw 0			; DATA XREF: seg000:01B9w
textPosX	dw 2			; DATA XREF: sub_10214+3w
					; api0_drawText+EAw ...
textPosY	dw 136h			; DATA XREF: sub_10214+9w
					; api0_drawText+FFw ...
textBoxXStart	dw 2			; DATA XREF: seg000:0206o sub_10214r ...
textBoxYStart	dw 310			; DATA XREF: sub_10214+6r api2_blit+1r ...
textBoxXEnd	dw 76			; DATA XREF: api0_drawText:dtxt13r
					; api2_blit+2Fr ...
textBoxYEnd	dw 390			; DATA XREF: api2_blit+27r
					; CalcTOfsAndWrap+3Cr
word_115E6	dw 0A800h		; DATA XREF: seg000:061Cr
					; RestoreTextBox+1r ...
		dw 0B000h
		dw 0B800h
word_115EC	dw 0			; DATA XREF: seg000:01A9w seg000:0201r ...
blitMode	db 0			; DATA XREF: seg000:01C4w
					; SetBlitTranspw ...
textErrorExit	db 0			; DATA XREF: api0_drawText+15w
					; api0_drawText:loc_1023Fr ...
byte_115F0	db 0			; DATA XREF: WaitForKeyPress+5w
					; WaitForKeyPress+2Bw ...
waitTime	db 0			; DATA XREF: seg000:01C9w
					; api0_drawText+C3r ...
drawInverted	db 0			; DATA XREF: seg000:01CEw
					; DrawTextChar:loc_10482r ...
byte_115F3	db 0			; DATA XREF: seg000:api6_waitSelKeyw
					; seg000:loc_107BBw ...
byte_115F4	db 0			; DATA XREF: seg000:054Bw
					; PrintDigit+12w ...
seg000		ends


		end start
