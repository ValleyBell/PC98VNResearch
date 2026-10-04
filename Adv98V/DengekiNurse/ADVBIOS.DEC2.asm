; Input	MD5   :	1687795BDFCCD7FC8242C49C7F95FC4D
; Input	CRC32 :	A3957B83

; File Name   :	R:\ADVBIOS.DEC2.OVL
; Format      :	MS-DOS executable (EXE)
; Base Address:	1000h Range: 10000h-425C0h Loaded length: 30780h
; Entry	Point :	1000:1732

		.686p
		.mmx
		.model large

; ===========================================================================

; Segment type:	Pure code
seg000		segment	byte public 'CODE' use16
		assume cs:seg000
		assume es:nothing, ss:nothing, ds:nothing, fs:nothing, gs:nothing
		db 10h dup(0)
		assume ds:seg008

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_10010	proc near		; CODE XREF: start+62p

arg_0		= word ptr  4
arg_2		= word ptr  6

		enter	0, 0
		push	di
		push	si
		call	DoMainInit
		mov	si, [bp+arg_0]
		test	si, si
		jnz	short loc_10027
		mov	si, 4
		push	0
		jmp	short loc_10042
; ---------------------------------------------------------------------------

loc_10027:				; CODE XREF: sub_10010+Ej
		test	si, si
		jz	short loc_1004A
		mov	cx, si
		mov	di, si
		dec	di
		add	di, di
		inc	si
		inc	si
		add	si, si
		mov	bx, [bp+arg_2]
		push	0

loc_1003B:				; CODE XREF: sub_10010+30j
		push	word ptr [bx+di]
		sub	di, 2
		loop	loc_1003B

loc_10042:				; CODE XREF: sub_10010+15j
		push	0EEh ; 'Ó'
		call	sub_1180C
		add	sp, si

loc_1004A:				; CODE XREF: sub_10010+19j
		pop	si
		pop	di
		leave
		retn
sub_10010	endp ; sp-analysis failed


; =============== S U B	R O U T	I N E =======================================


DoMainInit	proc near		; CODE XREF: sub_10010+6p
		call	SetupIntVec06_05
		mov	dx, offset a2j1h5hadvbiosF ; "\x1B[2J\x1B[>1h\x1B[>5hAdvBIOS for PC-9801V  $"
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		mov	dx, offset aVersion0_54	; "Version 0.54$"
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		mov	dx, offset aCopyrightCTu_0 ; "\r\nCopyright(C) Tuneup 1991,92.\rCopyrigh"...
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		mov	ax, 5
		sub	cx, cx

loc_1006B:				; CODE XREF: DoMainInit+1Ej
					; DoMainInit+21j
		nop
		loop	loc_1006B
		dec	ax
		jnz	short loc_1006B
		push	ds
		sub	ax, ax
		mov	ds, ax
		assume ds:nothing
		or	byte ptr ds:500h, 20h
		pop	ds
		assume ds:seg008
		call	SetupIntVecF1
		call	SetupIntVec33_15
		call	SetupIntVecF3
		call	SetupIntVecF6
		call	SetupIntVecF2
		call	sub_1329C
		push	offset DeinitAll
		call	sub_117BC
		add	sp, 2
		call	sub_100A2
		retn
DoMainInit	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_100A2	proc near		; CODE XREF: DoMainInit+4Fp
		mov	al, 1
		out	6Ah, al
		out	68h, al
		mov	al, 41h	; 'A'
		out	6Ah, al
		mov	ah, 10h
		int	0F3h
		mov	ax, 1100h
		int	0F3h
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	ax, 0C00h
		int	0F6h
		sub	al, al
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	ax, 0C00h
		int	0F6h
		sub	al, al
		out	0A4h, al	; Interrupt Controller #2, 8259A
		mov	ax, 110Fh
		int	0F3h
		sub	ax, ax
		int	33h		; - MS MOUSE - RESET DRIVER AND	READ STATUS
					; Return: AX = status
					; BX = number of buttons
		sub	dx, dx
		mov	ah, 6
		int	0F1h		; reserved for user interrupt
		retn
sub_100A2	endp

; ---------------------------------------------------------------------------
		nop

DeinitAll:				; DATA XREF: DoMainInit+46o
		mov	ah, 2
		int	0F4h
		mov	ax, 0A00h
		int	0F3h
		mov	ah, 10h
		int	0F3h
		mov	ax, 1100h
		int	0F3h
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	ax, 0C00h
		int	0F6h
		sub	al, al
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	ax, 0C00h
		int	0F6h
		sub	al, al
		out	0A4h, al	; Interrupt Controller #2, 8259A
		mov	ax, 110Fh
		int	0F3h
		mov	ah, 6
		sub	dx, dx
		int	0F1h		; reserved for user interrupt
		mov	ax, 0E04h
		int	0F1h		; reserved for user interrupt
		call	sub_13325
		call	RestoreIntVecF2
		call	RestoreIntVecF6
		call	RestoreIntVecF3
		call	RestoreIntVec33_15
		call	RestoreIntVecF1
		cli
		mov	dx, offset a1l5l ; "\x1B[>1l\x1B[>5l$"
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		sub	cx, cx

loc_10136:				; CODE XREF: seg000:loc_10136j
		loop	loc_10136

loc_10138:				; CODE XREF: seg000:loc_10138j
		loop	loc_10138

loc_1013A:				; CODE XREF: seg000:loc_1013Aj
		loop	loc_1013A

loc_1013C:				; CODE XREF: seg000:loc_1013Cj
		loop	loc_1013C

loc_1013E:				; CODE XREF: seg000:loc_1013Ej
		loop	loc_1013E
		push	ds
		sub	ax, ax
		mov	ds, ax
		assume ds:nothing
		and	byte ptr ds:500h, 0DFh
		pop	ds
		assume ds:nothing
		call	RestoreIntVec05_06
		retn
; ---------------------------------------------------------------------------
		nop
		assume ds:seg008

; =============== S U B	R O U T	I N E =======================================


SetupIntVecF1	proc near		; CODE XREF: DoMainInit+2Ep
		mov	al, 0F1h
		call	GetIntVec
		mov	word ptr OldIntF1Vec, dx
		mov	word ptr OldIntF1Vec+2,	es
		push	cs
		pop	es
		assume es:seg000
		mov	dx, offset IntF1
		call	SetIntVec
		push	ds
		pop	es
		assume es:seg008
		mov	di, offset byte_4086E
		mov	cx, 30h
		sub	ax, ax
		cld
		rep stosw
		mov	word_408CE, ax
		mov	word_4086C, ax
		mov	word_4086A, ax
		sub	dx, dx
		call	sub_102B0
		mov	word_40302, 0
		call	sub_108A0
		retn
SetupIntVecF1	endp


; =============== S U B	R O U T	I N E =======================================


RestoreIntVecF1	proc near		; CODE XREF: seg000:0129p
		mov	al, 0F1h
		les	dx, OldIntF1Vec
		assume es:nothing
		call	SetIntVec
		call	sub_102AA
		sub	dx, dx
		call	sub_102B0
		mov	byte ptr cs:Int_ClockTick, 0CFh	; write	"iret" instruction
		retn
RestoreIntVecF1	endp

; ---------------------------------------------------------------------------

IntF1:					; DATA XREF: SetupIntVecF1+11o
		jmp	short loc_101BA
; ---------------------------------------------------------------------------
aAdvbios98	db '++ AdvBIOS98 ++',0
; ---------------------------------------------------------------------------

loc_101BA:				; CODE XREF: seg000:IntF1j
		pusha
		push	ds
		push	es
		mov	bp, sp

loc_101BF:
		test	byte ptr [bp+19h], 2
		jz	short loc_101C6
		sti

loc_101C6:				; CODE XREF: seg000:01C3j
		and	byte ptr [bp+18h], 0FEh
		mov	bx, seg	seg008
		mov	ds, bx
		mov	es, bx
		assume es:seg008
		cmp	ah, 11h
		jbe	short loc_101D8
		mov	ah, 12h

loc_101D8:				; CODE XREF: seg000:01D4j
		mov	bl, ah
		sub	bh, bh
		add	bx, bx
		call	jumpTbl_intF1[bx]
		pop	es
		assume es:nothing
		pop	ds
		assume ds:nothing
		popa
		iret
		assume es:seg008, ds:seg008

; =============== S U B	R O U T	I N E =======================================


apiF1_SetError	proc near		; CODE XREF: seg000:01DEp
					; apiF1_02_ShiftJIS2JIS:loc_10243p ...
		or	byte ptr [bp+18h], 1
		retn
apiF1_SetError	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_101EC	proc near		; CODE XREF: seg000:01DEp
					; DATA XREF: seg008:jumpTbl_intF1o
		mov	word ptr [bp+12h], 3600h
		mov	byte ptr [bp+0Dh], 0
		retn
sub_101EC	endp


; =============== S U B	R O U T	I N E =======================================


apiF1_01_GetRandom proc	near		; CODE XREF: seg000:01DEp
					; DATA XREF: seg008:jumpTbl_intF1o
		cli
		call	RNGAdvance
		mov	[bp+12h], ax
		retn
apiF1_01_GetRandom endp


; =============== S U B	R O U T	I N E =======================================


RNGAdvance	proc near		; CODE XREF: apiF1_01_GetRandom+1p
					; sub_102FC+Bp
		mov	ax, 16961
		mul	word_40284
		mov	bx, ax
		mov	ax, 0Fh
		mul	word_40282
		add	bx, ax
		mov	ax, 16961
		mul	word_40282
		add	ax, 13849
		adc	dx, bx
		mov	word_40282, ax
		mov	word_40284, dx
		mov	ax, dx
		and	ax, 7FFFh
		retn
RNGAdvance	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


apiF1_02_ShiftJIS2JIS proc near		; CODE XREF: seg000:01DEp
					; DATA XREF: seg008:jumpTbl_intF1o
		cmp	dh, 81h
		jb	short loc_10243
		cmp	dh, 9Fh
		jbe	short loc_1023E
		cmp	dh, 0E0h
		jb	short loc_10243
		cmp	dh, 0FCh
		ja	short loc_10243

loc_1023E:				; CODE XREF: apiF1_02_ShiftJIS2JIS+8j
		call	ShiftJIS2JIS
		jmp	short loc_10248
; ---------------------------------------------------------------------------

loc_10243:				; CODE XREF: apiF1_02_ShiftJIS2JIS+3j
					; apiF1_02_ShiftJIS2JIS+Dj ...
		call	apiF1_SetError
		sub	dx, dx		; set result to	0

loc_10248:				; CODE XREF: apiF1_02_ShiftJIS2JIS+17j
		mov	[bp+0Eh], dx
		retn
apiF1_02_ShiftJIS2JIS endp


; =============== S U B	R O U T	I N E =======================================


ShiftJIS2JIS	proc near		; CODE XREF: apiF1_02_ShiftJIS2JIS:loc_1023Ep
					; apiF6_09_DrawChar:loc_10ADAp
		sub	dh, 70h
		cmp	dh, 30h
		jb	short loc_10257
		sub	dh, 40h

loc_10257:				; CODE XREF: ShiftJIS2JIS+6j
		shl	dh, 1
		cmp	dl, 7Fh
		jbe	short loc_10260
		dec	dl

loc_10260:				; CODE XREF: ShiftJIS2JIS+10j
		cmp	dl, 9Eh
		jb	short loc_1026A
		sub	dl, 5Eh
		inc	dh

loc_1026A:				; CODE XREF: ShiftJIS2JIS+17j
		dec	dh
		sub	dl, 1Fh
		retn
ShiftJIS2JIS	endp


; =============== S U B	R O U T	I N E =======================================


apiF1_03_JIS2ShiftJIS proc near		; CODE XREF: seg000:01DEp
					; DATA XREF: seg008:jumpTbl_intF1o
		cmp	dh, 21h
		jb	short loc_1029B
		cmp	dh, 7Eh
		ja	short loc_1029B
		sub	dh, 21h
		add	dl, 1Fh
		shr	dh, 1
		jnb	short loc_10287
		add	dl, 5Eh

loc_10287:				; CODE XREF: apiF1_03_JIS2ShiftJIS+12j
		add	dh, 81h
		cmp	dh, 9Fh
		jb	short loc_10292
		add	dh, 40h

loc_10292:				; CODE XREF: apiF1_03_JIS2ShiftJIS+1Dj
		cmp	dl, 7Fh
		jb	short loc_10299
		inc	dl

loc_10299:				; CODE XREF: apiF1_03_JIS2ShiftJIS+25j
		jmp	short loc_102A0
; ---------------------------------------------------------------------------

loc_1029B:				; CODE XREF: apiF1_03_JIS2ShiftJIS+3j
					; apiF1_03_JIS2ShiftJIS+8j
		call	apiF1_SetError
		sub	dx, dx

loc_102A0:				; CODE XREF: apiF1_03_JIS2ShiftJIS:loc_10299j
		mov	[bp+0Eh], dx
		retn
apiF1_03_JIS2ShiftJIS endp


; =============== S U B	R O U T	I N E =======================================


sub_102A4	proc near		; CODE XREF: seg000:01DEp
					; sub_10602+AFp ...
		mov	al, 6
		out	37h, al
		retn
sub_102A4	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_102AA	proc near		; CODE XREF: RestoreIntVecF1+Bp
					; seg000:01DEp	...
		mov	al, 7
		out	37h, al
		retn
sub_102AA	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_102B0	proc near		; CODE XREF: SetupIntVecF1+31p
					; RestoreIntVecF1+10p ...
		test	dx, dx
		jnz	short loc_102B9
		mov	dx, 370h
		jmp	short loc_102CA
; ---------------------------------------------------------------------------

loc_102B9:				; CODE XREF: sub_102B0+2j
		cmp	dx, 13h
		jnb	short loc_102C1
		mov	dx, 13h

loc_102C1:				; CODE XREF: sub_102B0+Cj
		cmp	dx, 8000h
		jb	short loc_102CA
		mov	dx, 7FFFh

loc_102CA:				; CODE XREF: sub_102B0+7j
					; sub_102B0+15j
		mov	bx, 12h
		mov	ax, 3540h
		xchg	dx, bx
		div	bx
		mov	bx, ax
		in	al, 42h		; Timer	8253-5 (AT: 8254.2).
		test	al, 20h
		jnz	short loc_102E3
		mov	ax, bx
		shr	ax, 2
		add	bx, ax

loc_102E3:				; CODE XREF: sub_102B0+2Aj
		mov	dx, 3FDFh
		mov	al, 76h	; 'v'
		out	dx, al
		jmp	short $+2
		jmp	short $+2
		mov	dx, 3FDBh
		mov	al, bl
		out	dx, al
		jmp	short $+2
		jmp	short $+2
		mov	al, bh
		out	dx, al
		retn
sub_102B0	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_102FC	proc near		; CODE XREF: seg000:01DEp
					; DATA XREF: seg008:jumpTbl_intF1o
		mov	ax, 0AFFh
		int	0F3h
		call	sub_1033C

loc_10304:				; CODE XREF: sub_102FC+26j
					; sub_102FC+34j
		call	sub_103CC
		call	RNGAdvance
		mov	ax, 0F00h
		int	0F1h		; reserved for user interrupt

loc_1030F:				; CODE XREF: seg000:0927p seg000:127Fp
		test	ax, ax
		jnz	short loc_10332
		mov	ax, 5
		int	33h		; - MS MOUSE - RETURN BUTTON PRESS DATA
					; BX = button
					; Return: AX = button states
					; BX = number of times specified button	has been pressed
					; CX = column at time specified	button was last	pressed
					; DX = row at time specified button was	last pressed
		test	ax, ax
		jnz	short loc_10332
		mov	ah, 1
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		test	bh, bh
		jz	short loc_10304
		sub	ah, ah
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		cmp	ah, 1Ch
		jz	short loc_10332
		cmp	ah, 34h	; '4'
		jnz	short loc_10304

loc_10332:				; CODE XREF: sub_102FC+15j
					; sub_102FC+1Ej ...
		call	sub_1035A
		mov	ax, 0A00h
		int	0F3h

locret_1033A:				; CODE XREF: seg000:0927p seg000:127Fp
		retn
sub_102FC	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_1033C	proc near		; CODE XREF: sub_102FC+5p sub_10364+8p
		push	cx

loc_1033D:				; CODE XREF: sub_1033C+8j
					; sub_1033C+16j
		mov	ax, 5
		int	33h		; - MS MOUSE - RETURN BUTTON PRESS DATA
					; BX = button
					; Return: AX = button states
					; BX = number of times specified button	has been pressed
					; CX = column at time specified	button was last	pressed
					; DX = row at time specified button was	last pressed
		test	ax, ax
		jnz	short loc_1033D
		mov	ah, 1
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		test	bh, bh
		jz	short loc_10354
		sub	ah, ah
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		jmp	short loc_1033D
; ---------------------------------------------------------------------------

loc_10354:				; CODE XREF: sub_1033C+10j
		pop	cx
		retn
sub_1033C	endp

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_1035A

loc_10356:				; CODE XREF: sub_1035A+6j
		sub	ah, ah
		int	18h		; TRANSFER TO ROM BASIC
; END OF FUNCTION CHUNK	FOR sub_1035A	; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all

; =============== S U B	R O U T	I N E =======================================


sub_1035A	proc near		; CODE XREF: sub_102FC:loc_10332p
					; sub_10364:loc_103AAp

; FUNCTION CHUNK AT 0356 SIZE 00000004 BYTES

		mov	ah, 1
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		test	bh, bh
		jnz	short loc_10356
		retn
sub_1035A	endp ; sp-analysis failed

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_10364	proc near		; CODE XREF: seg000:01DEp
					; DATA XREF: seg008:jumpTbl_intF1o
		mov	byte_4027A, al
		mov	ax, 0AFFh
		int	0F3h
		call	sub_1033C
		mov	word_4027C, cx

loc_10373:				; CODE XREF: sub_10364+36j
					; sub_10364+44j
		cmp	word_4027C, 0
		jz	short loc_103AA
		call	sub_103CC
		mov	ax, 0F00h
		int	0F1h		; reserved for user interrupt
		test	ax, ax
		jnz	short loc_103AA
		call	sub_103B4
		jnz	short loc_103AA
		mov	ax, 5
		int	33h		; - MS MOUSE - RETURN BUTTON PRESS DATA
					; BX = button
					; Return: AX = button states
					; BX = number of times specified button	has been pressed
					; CX = column at time specified	button was last	pressed
					; DX = row at time specified button was	last pressed
		test	ax, ax
		jnz	short loc_103AA
		mov	ah, 1
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		test	bh, bh
		jz	short loc_10373
		sub	ah, ah
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		cmp	ah, 1Ch
		jz	short loc_103AA
		cmp	ah, 34h	; '4'
		jnz	short loc_10373

loc_103AA:				; CODE XREF: sub_10364+14j
					; sub_10364+20j ...
		call	sub_1035A
		mov	ax, 0A00h
		int	0F3h
		retn
sub_10364	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_103B4	proc near		; CODE XREF: sub_10364+22p
					; sub_103F0+17p ...
		cmp	byte_4027A, 0
		jz	short locret_103CA

loc_103BB:				; CODE XREF: seg000:0927p seg000:127Fp
		mov	ah, 2
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		test	al, 1
		jnz	short locret_103CA
		mov	ax, 6
		int	33h		; - MS MOUSE - RETURN BUTTON RELEASE DATA
					; BX = button
		test	ax, ax

locret_103CA:				; CODE XREF: sub_103B4+5j sub_103B4+Dj
		retn
sub_103B4	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_103CC	proc near		; CODE XREF: sub_102FC:loc_10304p
					; sub_10364+16p ...
		cmp	word_40280, 0
		jnz	short locret_103DE
		call	sub_130F4
		mov	word_40280, 2

locret_103DE:				; CODE XREF: sub_103CC+5j
		retn
sub_103CC	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_103E0	proc far		; CODE XREF: sub_13278P
		push	ds
		push	es
		mov	ax, seg	seg008
		mov	ds, ax
		mov	es, ax
		call	sub_103CC
		pop	es
		assume es:nothing
		pop	ds
		retf
sub_103E0	endp

; ---------------------------------------------------------------------------
		align 2
		assume es:seg008

; =============== S U B	R O U T	I N E =======================================


sub_103F0	proc near		; CODE XREF: seg000:01DEp
					; DATA XREF: seg008:jumpTbl_intF1o
		mov	byte_4027A, al
		mov	word_4027C, cx

loc_103F7:				; CODE XREF: sub_103F0+1Aj
		cmp	word_4027C, 0
		jz	short locret_1040C
		mov	ax, 0F00h
		int	0F1h		; reserved for user interrupt
		test	ax, ax
		jnz	short locret_1040C
		call	sub_103B4
		jz	short loc_103F7

locret_1040C:				; CODE XREF: sub_103F0+Cj
					; sub_103F0+15j
		retn
sub_103F0	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_1040E	proc near		; CODE XREF: seg000:01DEp
					; DATA XREF: seg008:jumpTbl_intF1o
		mov	byte_4027A, al
		mov	ax, 0AFFh
		int	0F3h
		mov	word_4027C, cx

loc_1041A:				; CODE XREF: sub_1040E+22j
		cmp	word_4027C, 0
		jz	short loc_10432
		call	sub_103CC
		mov	ax, 0F00h
		int	0F1h		; reserved for user interrupt
		test	ax, ax
		jnz	short loc_10432
		call	sub_103B4
		jz	short loc_1041A

loc_10432:				; CODE XREF: sub_1040E+11j
					; sub_1040E+1Dj
		mov	ax, 0A00h
		int	0F3h
		retn
sub_1040E	endp


; =============== S U B	R O U T	I N E =======================================


sub_10438	proc near		; CODE XREF: seg000:01DEp
					; DATA XREF: seg008:jumpTbl_intF1o
		cli
		in	al, 2		; DMA controller, 8237A-5.
					; channel 1 current address
		or	al, 2
		jmp	short $+2
		jmp	short $+2
		out	2, al		; DMA controller, 8237A-5.
					; channel 1 base address
					; (also	sets current address)
		sub	ax, ax
		mov	es, ax
		assume es:nothing
		mov	bx, es:524h
		mov	es:526h, bx
		mov	es:528h, al
		in	al, 2		; DMA controller, 8237A-5.
					; channel 1 current address
		and	al, 0FDh
		jmp	short $+2
		jmp	short $+2
		out	2, al		; DMA controller, 8237A-5.
					; channel 1 base address
					; (also	sets current address)
		sti
		retn
sub_10438	endp

; ---------------------------------------------------------------------------
		align 2
		assume es:seg008

; =============== S U B	R O U T	I N E =======================================


sub_10462	proc near		; CODE XREF: seg000:01DEp
					; DATA XREF: seg008:jumpTbl_intF1o
		push	ds
		mov	bx, 750h
		mov	cx, 7D5h
		mov	ds, word ptr [bp+2]
		assume ds:nothing
		mov	ah, 5
		int	0F2h
		pop	ds
		assume ds:seg008
		jb	short loc_10492
		cmp	ax, 5
		jb	short loc_10492
		cmp	byte_408D0, 0
		jnz	short loc_10492
		mov	cx, ax
		mov	al, byte_408D3
		mul	byte_408D4
		inc	ax
		shr	ax, 1
		add	ax, 5
		cmp	ax, cx
		jbe	short loc_1049B

loc_10492:				; CODE XREF: sub_10462+Fj
					; sub_10462+14j ...
		call	apiF1_SetError
		mov	word ptr [bp+12h], 0FFFFh
		retn
; ---------------------------------------------------------------------------

loc_1049B:				; CODE XREF: sub_10462+2Ej
		mov	di, offset byte_410A5
		cld
		sub	ax, ax
		mov	cx, 1000
		rep stosw
		mov	bl, byte_408D1
		mov	bh, byte_408D3
		add	bh, bl
		mov	cl, byte_408D2
		mov	ch, byte_408D4
		add	ch, cl
		mov	si, offset byte_408D5
		jmp	short loc_104E9
; ---------------------------------------------------------------------------

loc_104BF:				; CODE XREF: sub_10462+89j
		lodsb
		mov	ah, al
		shr	al, 4
		call	sub_104F3
		mov	al, ah
		inc	bl
		cmp	bl, bh
		jb	short loc_104D6
		inc	cl
		mov	bl, byte_408D1

loc_104D6:				; CODE XREF: sub_10462+6Cj
		cmp	cl, ch
		jnb	short loc_104ED
		call	sub_104F3
		inc	bl
		cmp	bl, bh
		jb	short loc_104E9
		inc	cl
		mov	bl, byte_408D1

loc_104E9:				; CODE XREF: sub_10462+5Bj
					; sub_10462+7Fj
		cmp	cl, ch
		jb	short loc_104BF

loc_104ED:				; CODE XREF: sub_10462+76j
		mov	word ptr [bp+12h], 0
		retn
sub_10462	endp


; =============== S U B	R O U T	I N E =======================================


sub_104F3	proc near		; CODE XREF: sub_10462+63p
					; sub_10462+78p
		push	ax
		push	bx
		push	cx
		push	dx
		and	al, 0Fh
		mov	dh, al
		mov	al, 28h	; '('
		mul	cl
		mov	dl, bl
		sub	bh, bh
		shr	bx, 1
		add	bx, ax
		test	dl, 1
		jnz	short loc_1050F
		shl	dh, 4

loc_1050F:				; CODE XREF: sub_104F3+17j
		or	byte_410A5[bx],	dh
		pop	dx
		pop	cx
		pop	bx
		pop	ax
		retn
sub_104F3	endp


; =============== S U B	R O U T	I N E =======================================


sub_10518	proc near		; CODE XREF: seg000:01DEp
					; DATA XREF: seg008:jumpTbl_intF1o
		mov	ax, 1
		int	33h		; - MS MOUSE - SHOW MOUSE CURSOR
					; SeeAlso: AX=0002h, INT 16/AX=FFFEh

loc_1051D:				; CODE XREF: sub_10518+Cj
					; sub_10518+50j ...
		mov	ax, 7
		int	33h		; - MS MOUSE - DEFINE HORIZONTAL CURSOR	RANGE
					; CX = minimum column, DX = maximum column
		test	ax, ax
		jnz	short loc_1051D

loc_10526:				; CODE XREF: sub_10518+26j
		mov	ax, 0F00h
		int	0F1h		; reserved for user interrupt
		test	ax, ax
		jz	short loc_10533
		sub	ax, ax
		jmp	short loc_10574
; ---------------------------------------------------------------------------

loc_10533:				; CODE XREF: sub_10518+15j
		mov	ax, 3
		int	33h		; - MS MOUSE - RETURN POSITION AND BUTTON STATUS
					; Return: BX = button status, CX = column, DX =	row
		test	bx, bx
		jnz	short loc_1056C
		test	ax, ax
		jz	short loc_10526
		shr	dx, 3
		shr	cx, 3
		mov	ax, 28h	; '('
		mul	dx
		mov	bx, cx
		shr	bx, 1
		add	bx, ax
		mov	al, byte_410A5[bx]
		and	cx, 1
		jnz	short loc_1055D
		shr	al, 4

loc_1055D:				; CODE XREF: sub_10518+40j
		and	ax, 0Fh
		test	ax, ax
		jnz	short loc_10574
		test	byte ptr [bp+12h], 2
		jnz	short loc_1051D
		jmp	short loc_10574
; ---------------------------------------------------------------------------

loc_1056C:				; CODE XREF: sub_10518+22j
		test	byte ptr [bp+12h], 1
		jnz	short loc_1051D
		sub	ax, ax

loc_10574:				; CODE XREF: sub_10518+19j
					; sub_10518+4Aj ...
		mov	[bp+12h], ax
		mov	ax, 2
		int	33h		; - MS MOUSE - HIDE MOUSE CURSOR
					; SeeAlso: AX=0001h, INT 16/AX=FFFFh
		retn
sub_10518	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_1057E	proc near		; CODE XREF: seg000:01DEp
					; DATA XREF: seg008:jumpTbl_intF1o
		mov	al, [bp+12h]
		test	al, al
		jz	short loc_1059A
		dec	al
		jz	short loc_105B6
		dec	al
		jz	short loc_105CA
		dec	al
		jz	short loc_105DE
		dec	al
		jz	short loc_105E6
		call	apiF1_SetError
		retn
; ---------------------------------------------------------------------------
		align 2

loc_1059A:				; CODE XREF: sub_1057E+5j
		sub	ax, ax
		mov	word_4028A, ax
		mov	word_40288, ax
		mov	ax, [bp+10h]
		mov	word_40286, ax
		mov	ax, [bp+0Eh]
		mov	dx, [bp+2]
		mov	word ptr dword_40776, ax
		mov	word ptr dword_40776+2,	dx
		retn
; ---------------------------------------------------------------------------

loc_105B6:				; CODE XREF: sub_1057E+9j
		mov	ax, word_40286
		mov	[bp+10h], ax
		mov	ax, word ptr dword_40776
		mov	dx, word ptr dword_40776+2
		mov	[bp+0Ch], ax
		mov	[bp+0],	dx
		retn
; ---------------------------------------------------------------------------

loc_105CA:				; CODE XREF: sub_1057E+Dj
		mov	ax, [bp+10h]
		test	ax, ax
		jnz	short loc_105D4
		mov	ax, word_40286

loc_105D4:				; CODE XREF: sub_1057E+51j
		mov	word_40288, ax
		mov	word_4028A, 1
		retn
; ---------------------------------------------------------------------------

loc_105DE:				; CODE XREF: sub_1057E+11j
		mov	word_4028A, 0
		retn
; ---------------------------------------------------------------------------
		align 2

loc_105E6:				; CODE XREF: sub_1057E+15j
		pushf
		cli
		sub	ax, ax
		mov	word_4028A, ax
		mov	word_40288, ax
		mov	word_40286, ax
		mov	word ptr dword_40776, offset locret_10600
		mov	word ptr dword_40776+2,	cs
		popf
		retn
sub_1057E	endp

; ---------------------------------------------------------------------------
		align 2

locret_10600:				; DATA XREF: sub_1057E+75o
		retf
; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_10602	proc near		; CODE XREF: seg000:01DEp
					; DATA XREF: seg008:jumpTbl_intF1o
		mov	al, [bp+12h]
		test	al, al
		jz	short loc_1062B
		dec	al
		jz	short loc_10624
		dec	al
		jz	short loc_1061D
		dec	al
		jz	short loc_10616
		retn
; ---------------------------------------------------------------------------

loc_10616:				; CODE XREF: sub_10602+11j
		mov	word_4086C, 0
		retn
; ---------------------------------------------------------------------------

loc_1061D:				; CODE XREF: sub_10602+Dj
		mov	word_4086C, 0FFFFh
		retn
; ---------------------------------------------------------------------------

loc_10624:				; CODE XREF: sub_10602+9j
		mov	ax, word_4086A
		mov	[bp+12h], ax
		retn
; ---------------------------------------------------------------------------

loc_1062B:				; CODE XREF: sub_10602+5j
		sub	ax, ax
		mov	[bp+12h], ax
		cmp	word_4086C, 0
		jnz	short locret_10652
		mov	ah, 30h
		int	21h		; DOS -	GET DOS	VERSION
					; Return: AL = major version number (00h for DOS 1.x)
		cmp	ax, 2
		jz	short locret_10652
		cmp	ax, 0C02h
		jz	short locret_10652
		push	ds
		sub	ax, ax
		mov	ds, ax
		assume ds:nothing
		test	byte ptr ds:536h, 1
		pop	ds
		assume ds:nothing
		jnz	short loc_10653

locret_10652:				; CODE XREF: sub_10602+33j
					; sub_10602+3Cj ...
		retn
; ---------------------------------------------------------------------------

loc_10653:				; CODE XREF: sub_10602+4Ej
		mov	ah, 12h
		int	0F3h
		mov	ah, 11h
		push	ax
		cmp	al, 3
		jbe	short loc_10660
		mov	al, 3

loc_10660:				; CODE XREF: sub_10602+5Aj
		int	0F3h
		assume ds:seg008
		push	ds
		mov	si, 640h
		mov	di, 5FAh
		mov	ax, 0A000h
		mov	ds, ax
		assume ds:nothing
		mov	cx, 50h
		rep movsw
		mov	si, 2640h
		mov	cx, 50h

loc_10679:				; CODE XREF: sub_10602+79j
		lodsw
		stosb
		loop	loc_10679
		pop	ds
		assume ds:seg008
		mov	al, 0Ah
		out	68h, al
		mov	ax, 0A000h
		mov	es, ax
		assume es:nothing
		mov	di, 640h
		mov	si, offset aAskQuit ; "Å@Å@Å@Å@Å@Å@Å@Å@Å@ÅsÅ@Å@èIóπÇµÇƒÇ‡ÇÊÇÎÇ"...
		mov	bx, 2000h
		mov	cl, 0C5h
		mov	ch, 28h

loc_10694:				; CODE XREF: sub_10602+ADj
		lodsw
		xchg	ah, al
		mov	dx, ax
		mov	ah, 2
		int	0F1h		; reserved for user interrupt
		mov	ax, dx
		xchg	ah, al
		sub	al, 20h
		mov	es:[bx+di], cl
		stosw
		or	al, 80h
		mov	es:[bx+di], cl
		stosw
		dec	ch
		jnz	short loc_10694
		call	sub_102A4
		mov	word_4027C, 0Ah

loc_106BA:				; CODE XREF: sub_10602+BDj
		cmp	word_4027C, 0
		jnz	short loc_106BA
		call	sub_102AA

loc_106C4:				; CODE XREF: sub_10602+CEj
					; sub_10602+D8j
		mov	ah, 1
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		push	bx
		sub	ah, ah
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		pop	bx
		test	bh, bh
		jnz	short loc_106C4
		cmp	ah, 2Eh
		jz	short loc_106E5
		cmp	ah, 15h
		jnz	short loc_106C4
		mov	ax, 0FFFFh
		mov	[bp+12h], ax
		mov	word_4086A, ax

loc_106E5:				; CODE XREF: sub_10602+D3j
		mov	si, 5FAh
		mov	di, 640h
		mov	ax, 0A000h
		mov	es, ax
		mov	cx, 50h
		rep movsw
		mov	di, 2640h
		mov	cx, 50h

loc_106FB:				; CODE XREF: sub_10602+FBj
		lodsb
		stosw
		loop	loc_106FB
		mov	al, 0Bh
		out	68h, al
		pop	ax
		int	0F3h
		retn
sub_10602	endp

; ---------------------------------------------------------------------------
		align 2
		assume es:seg008

; =============== S U B	R O U T	I N E =======================================


sub_10708	proc near		; CODE XREF: seg000:01DEp
					; DATA XREF: seg008:jumpTbl_intF1o

; FUNCTION CHUNK AT 07D4 SIZE 00000034 BYTES

		mov	al, [bp+12h]
		test	al, al
		jz	short loc_10724
		dec	al
		jz	short loc_10758
		dec	al
		jz	short loc_10768
		dec	al
		jnz	short loc_1071E
		jmp	loc_107D4
; ---------------------------------------------------------------------------

loc_1071E:				; CODE XREF: sub_10708+11j
		mov	word ptr [bp+12h], 0FFFFh
		retn
; ---------------------------------------------------------------------------

loc_10724:				; CODE XREF: sub_10708+5j
		cmp	word_408CE, 0Fh
		jb	short loc_10731

loc_1072B:				; CODE XREF: sub_10708+38j
		mov	word ptr [bp+12h], 0
		retn
; ---------------------------------------------------------------------------

loc_10731:				; CODE XREF: sub_10708+21j
		mov	si, offset byte_4086E
		imul	di, word_408CE,	6
		add	di, si
		call	sub_1082A
		test	ax, ax
		jz	short loc_1072B
		mov	[di], ax
		mov	dx, [bp+0Eh]
		mov	[di+2],	dx
		mov	dx, [bp+0]
		mov	[di+4],	dx
		inc	word_408CE
		mov	[bp+12h], ax
		retn
; ---------------------------------------------------------------------------

loc_10758:				; CODE XREF: sub_10708+9j
		call	sub_10789
		test	ax, ax
		jnz	short loc_10764
		call	sub_107B2
		sub	ax, ax

loc_10764:				; CODE XREF: sub_10708+55j
		mov	[bp+12h], ax
		retn
; ---------------------------------------------------------------------------

loc_10768:				; CODE XREF: sub_10708+Dj
		call	sub_10789
		test	ax, ax
		jnz	short loc_10785
		push	bp
		push	di
		push	si
		push	ds
		push	es
		push	dx
		pushf
		cli
		call	dword ptr [di+2]
		pop	dx
		pop	es
		assume es:nothing
		pop	ds
		pop	si
		pop	di
		pop	bp
		call	sub_107B2
		sub	ax, ax

loc_10785:				; CODE XREF: sub_10708+65j
		mov	[bp+12h], ax
		retn
sub_10708	endp


; =============== S U B	R O U T	I N E =======================================


sub_10789	proc near		; CODE XREF: sub_10708:loc_10758p
					; sub_10708:loc_10768p
		mov	ax, [bp+0Ch]
		cmp	ax, 1
		jb	short loc_10796
		cmp	ax, 0Fh
		jb	short loc_1079A

loc_10796:				; CODE XREF: sub_10789+6j
		mov	ax, 2
		retn
; ---------------------------------------------------------------------------

loc_1079A:				; CODE XREF: sub_10789+Bj
		call	sub_10808
		cmp	ax, 0FFFFh
		jnz	short loc_107A6
		mov	ax, 1
		retn
; ---------------------------------------------------------------------------

loc_107A6:				; CODE XREF: sub_10789+17j
		mov	dx, ax
		imul	di, ax,	6
		add	di, offset byte_4086E
		sub	ax, ax
		retn
sub_10789	endp


; =============== S U B	R O U T	I N E =======================================


sub_107B2	proc near		; CODE XREF: sub_10708+57p
					; sub_10708+78p
		sub	ax, ax
		mov	[di], ax
		mov	[di+2],	ax
		mov	[di+4],	ax
		jmp	short loc_107C8
; ---------------------------------------------------------------------------

loc_107BE:				; CODE XREF: sub_107B2+19j
		lea	si, [di+6]
		mov	cx, 6
		cld
		rep movsb
		inc	dx

loc_107C8:				; CODE XREF: sub_107B2+Aj
		cmp	dx, 0Fh
		jb	short loc_107BE
		dec	word_408CE
		sub	ax, ax
		retn
sub_107B2	endp

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_10708

loc_107D4:				; CODE XREF: sub_10708+13j
		mov	si, 0Eh
		sub	dx, dx

loc_107D9:				; CODE XREF: sub_10708+FAj
		imul	di, si,	6
		add	di, offset byte_4086E
		cmp	word ptr [di], 0
		jz	short loc_10801
		push	bp
		push	di
		push	si
		push	ds
		push	es
		push	dx
		pushf
		cli
		call	dword ptr [di+2]
		pop	dx
		pop	es
		pop	ds
		pop	si
		pop	di
		pop	bp
		sub	ax, ax
		mov	[di], ax
		mov	[di+2],	ax
		mov	[di+4],	ax
		inc	dx

loc_10801:				; CODE XREF: sub_10708+DBj
		dec	si
		jge	short loc_107D9
		mov	[bp+12h], dx
		retn
; END OF FUNCTION CHUNK	FOR sub_10708

; =============== S U B	R O U T	I N E =======================================


sub_10808	proc near		; CODE XREF: sub_10789:loc_1079Ap
					; sub_1082A+6p
		push	di
		push	si
		sub	di, di
		jmp	short loc_1081A
; ---------------------------------------------------------------------------

loc_1080E:				; CODE XREF: sub_10808+16j
		imul	si, di,	6
		add	si, offset byte_4086E
		cmp	[si], ax
		jz	short loc_10825
		inc	di

loc_1081A:				; CODE XREF: sub_10808+4j
		cmp	di, word_408CE
		jb	short loc_1080E
		mov	ax, 0FFFFh
		jmp	short loc_10827
; ---------------------------------------------------------------------------

loc_10825:				; CODE XREF: sub_10808+Fj
		mov	ax, di

loc_10827:				; CODE XREF: sub_10808+1Bj
		pop	si
		pop	di
		retn
sub_10808	endp


; =============== S U B	R O U T	I N E =======================================


sub_1082A	proc near		; CODE XREF: sub_10708+33p
		push	di
		mov	di, 1

loc_1082E:				; CODE XREF: sub_1082A+12j
		mov	ax, di
		call	sub_10808
		cmp	ax, 0FFFFh
		jz	short loc_10842
		inc	di
		cmp	di, 0Fh
		jbe	short loc_1082E
		sub	ax, ax
		jmp	short loc_10844
; ---------------------------------------------------------------------------

loc_10842:				; CODE XREF: sub_1082A+Cj
		mov	ax, di

loc_10844:				; CODE XREF: sub_1082A+16j
		pop	di
		retn
sub_1082A	endp

		assume es:seg008

; =============== S U B	R O U T	I N E =======================================


sub_10846	proc near		; CODE XREF: seg000:01DEp
					; DATA XREF: seg008:jumpTbl_intF1o
		call	sub_1191C
		mov	[bp+12h], ax
		retn
sub_10846	endp

; ---------------------------------------------------------------------------
		align 2

Int_ClockTick:				; DATA XREF: RestoreIntVecF1+13w
					; sub_108A0+4o
		push	ds
		push	es
		push	ax
		push	bx
		push	cx
		mov	ax, seg	seg008
		mov	ds, ax
		cmp	word_4027C, 0
		jz	short loc_10863
		dec	word_4027C

loc_10863:				; CODE XREF: seg000:085Dj
		cmp	word_40280, 0
		jz	short loc_1086E
		dec	word_40280

loc_1086E:				; CODE XREF: seg000:0868j
		cmp	word_4028A, 0
		jz	short loc_10896
		cmp	word_40288, 0
		jz	short loc_10896
		dec	word_40288
		jnz	short loc_10896
		push	di
		push	si
		push	ds
		push	dx
		sti
		call	dword_40776
		cli
		pop	dx
		pop	ds
		pop	si
		pop	di
		mov	ax, word_40286
		mov	word_40288, ax

loc_10896:				; CODE XREF: seg000:0873j seg000:087Aj ...
		call	sub_108A0
		pop	cx
		pop	bx
		pop	ax
		pop	es
		assume es:nothing
		pop	ds
		iret
; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_108A0	proc near		; CODE XREF: SetupIntVecF1+3Ap
					; seg000:loc_10896p
		mov	ax, cs
		mov	es, ax
		assume es:seg000
		mov	bx, offset Int_ClockTick
		mov	cx, 2
		mov	ah, 2
		int	1Ch		; CLOCK	TICK
		retn
sub_108A0	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


SetupIntVecF6	proc near		; CODE XREF: DoMainInit+3Bp
		mov	al, 0F6h
		call	GetIntVec
		mov	word ptr OldIntF6Vec, dx
		mov	word ptr OldIntF6Vec+2,	es
		push	cs
		pop	es
		mov	dx, offset IntF6
		call	SetIntVec
		cld
		mov	es, word_40318
		assume es:nothing
		sub	di, di
		sub	ax, ax
		mov	cx, 7D0h
		rep stosw
		mov	al, 11h
		mov	di, 2000h
		mov	cx, 7D0h
		rep stosw
		sub	ah, ah
		int	0F6h
		mov	ax, 1B01h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		sub	ah, ah
		call	nullsub_1
		retn
SetupIntVecF6	endp


; =============== S U B	R O U T	I N E =======================================


RestoreIntVecF6	proc near		; CODE XREF: seg000:011Cp
		mov	al, 0F6h
		les	dx, OldIntF6Vec
		assume es:nothing
		call	SetIntVec
		mov	ax, 1B00h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		retn
RestoreIntVecF6	endp

; ---------------------------------------------------------------------------
		nop

IntF6:					; DATA XREF: SetupIntVecF6+11o
		pusha
		push	ds
		push	es
		mov	bp, sp
		test	byte ptr [bp+19h], 2
		jz	short loc_1090E
		sti

loc_1090E:				; CODE XREF: seg000:090Bj
		cld
		and	byte ptr [bp+18h], 0FEh
		mov	bx, seg	seg008
		mov	ds, bx
		mov	es, bx
		assume es:seg008
		cmp	ah, 13h
		jbe	short loc_10921
		mov	ah, 14h

loc_10921:				; CODE XREF: seg000:091Dj
		mov	bl, ah
		sub	bh, bh
		add	bx, bx
		call	jumpTbl_intF6[bx]
		pop	es
		assume es:nothing
		pop	ds
		assume ds:nothing
		popa
		iret
; ---------------------------------------------------------------------------
		align 2
		assume es:seg008, ds:seg008

; =============== S U B	R O U T	I N E =======================================


apiF6_SetError	proc near		; CODE XREF: seg000:0927p
					; DATA XREF: seg008:jumpTbl_intF6o
		or	byte ptr [bp+18h], 1
		retn
apiF6_SetError	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_10936	proc near		; CODE XREF: seg000:0927p
					; DATA XREF: seg008:jumpTbl_intF6o
		mov	ax, word_4031A
		test	ax, ax
		jnz	short loc_10940
		jmp	loc_109EB
; ---------------------------------------------------------------------------

loc_10940:				; CODE XREF: sub_10936+5j
		cmp	ax, 0FFFFh
		jnz	short loc_10948
		jmp	loc_109EB
; ---------------------------------------------------------------------------

loc_10948:				; CODE XREF: sub_10936+Dj
		mov	si, 7D00h
		lea	di, [si+4]
		sub	ax, ax
		mov	es, word_40310
		assume es:nothing
		mov	word ptr es:[si], 5555h
		mov	es:[di], ax
		mov	es, word_40310+2
		assume es:nothing
		mov	word ptr es:[si], 3333h
		mov	es:[di], ax
		mov	es, word_40310+4
		assume es:nothing
		mov	word ptr es:[si], 0F0Fh
		mov	es:[di], ax
		mov	es, word_40310+6
		assume es:nothing
		mov	word ptr es:[si], 0FF00h
		mov	es:[di], ax
		call	sub_109F0
		mov	dx, 4A0h
		mov	ax, 0FFF0h
		out	dx, ax
		add	dl, 2
		mov	ax, 0FFh
		out	dx, ax
		add	dl, 2
		mov	ax, 28F0h
		out	dx, ax
		add	dl, 4
		mov	ax, 0FFFFh
		out	dx, ax
		add	dl, 4
		sub	ax, ax
		out	dx, ax
		add	dl, 2
		mov	ax, 0Fh
		out	dx, ax
		mov	ax, es:[si]
		mov	es:[di], ax
		call	sub_10A04
		sub	ax, ax
		mov	es, word_40310
		assume es:nothing
		mov	dx, es:[si]
		cmp	es:[di], dx
		jnz	short loc_109E8
		mov	es, word_40310+2
		assume es:nothing
		mov	dx, es:[si]
		cmp	es:[di], dx
		jnz	short loc_109E8
		mov	es, word_40310+4
		assume es:nothing
		mov	dx, es:[si]
		cmp	es:[di], dx
		jnz	short loc_109E8
		mov	es, word_40310+6
		assume es:nothing
		mov	dx, es:[si]
		cmp	es:[di], dx
		jnz	short loc_109E8
		dec	ax

loc_109E8:				; CODE XREF: sub_10936+8Bj
					; sub_10936+97j ...
		mov	word_4031A, ax

loc_109EB:				; CODE XREF: sub_10936+7j sub_10936+Fj
		mov	[bp+12h], ax
		retn
sub_10936	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_109F0	proc near		; CODE XREF: sub_10936+4Ap sub_11168p
		pushf
		cli
		mov	al, 7
		out	6Ah, al
		mov	al, 5
		out	6Ah, al
		mov	al, 80h	; 'Ä'
		out	7Ch, al
		mov	al, 6
		out	6Ah, al
		popf
		retn
sub_109F0	endp


; =============== S U B	R O U T	I N E =======================================


sub_10A04	proc near		; CODE XREF: sub_10936+7Cp
					; sub_1109A+3Fp ...
		pushf
		cli
		mov	dx, 4A0h
		mov	ax, 0FFF0h
		out	dx, ax
		add	dl, 8
		mov	ax, 0FFFFh
		out	dx, ax
		mov	al, 7
		out	6Ah, al
		mov	al, 4
		out	6Ah, al
		sub	al, al
		out	7Ch, al
		mov	al, 6
		out	6Ah, al
		popf
		retn
sub_10A04	endp

		assume es:seg008

; =============== S U B	R O U T	I N E =======================================


sub_10A26	proc near		; CODE XREF: seg000:0927p
					; DATA XREF: seg008:jumpTbl_intF6o
		push	ds
		mov	di, 19Ch
		mov	cx, 4
		mov	ds, word ptr [bp+2]
		assume ds:nothing
		rep movsw
		pop	ds
		mov	ax, ds:19Ch
		mov	bx, ds:1A0h
		mov	dx, 4Fh	; 'O'
		call	sub_10A5C
		mov	ds:19Ch, ax
		mov	ds:1A0h, bx
		mov	ax, ds:19Eh
		mov	bx, ds:1A2h
		mov	dx, 18Fh
		call	sub_10A5C
		mov	ds:19Eh, ax
		mov	ds:1A2h, bx
		retn
sub_10A26	endp


; =============== S U B	R O U T	I N E =======================================


sub_10A5C	proc near		; CODE XREF: sub_10A26+17p
					; sub_10A26+2Bp
		cmp	ax, dx
		jbe	short loc_10A62
		mov	ax, dx

loc_10A62:				; CODE XREF: sub_10A5C+2j
		cmp	bx, dx
		jbe	short loc_10A68
		mov	bx, dx

loc_10A68:				; CODE XREF: sub_10A5C+8j
		cmp	ax, bx
		jb	short locret_10A6D
		xchg	ax, bx

locret_10A6D:				; CODE XREF: sub_10A5C+Ej
		retn
sub_10A5C	endp

		assume ds:seg008

; =============== S U B	R O U T	I N E =======================================


sub_10A6E	proc near		; CODE XREF: seg000:0927p
					; DATA XREF: seg008:jumpTbl_intF6o
		mov	si, offset word_4031C
		mov	cx, 4
		mov	es, word ptr [bp+0]
		assume es:nothing
		rep movsw
		retn
sub_10A6E	endp

		assume es:seg008

; =============== S U B	R O U T	I N E =======================================


sub_10A7A	proc near		; CODE XREF: seg000:0927p
					; DATA XREF: seg008:jumpTbl_intF6o
		and	al, 0Fh
		mov	byte_40328, al
		retn
sub_10A7A	endp


; =============== S U B	R O U T	I N E =======================================


sub_10A80	proc near		; CODE XREF: seg000:0927p
					; DATA XREF: seg008:jumpTbl_intF6o
		mov	al, byte_40328
		mov	[bp+12h], al
		retn
sub_10A80	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_10A88	proc near		; CODE XREF: seg000:0927p
					; DATA XREF: seg008:jumpTbl_intF6o
		mov	word_40324, cx
		mov	word_40326, dx
		retn
sub_10A88	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_10A92	proc near		; CODE XREF: seg000:0927p
					; DATA XREF: seg008:jumpTbl_intF6o
		mov	ax, word_40324
		mov	[bp+10h], ax
		mov	ax, word_40326
		mov	[bp+0Eh], ax
		retn
sub_10A92	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_10AA0	proc near		; CODE XREF: seg000:0927p
					; DATA XREF: seg008:jumpTbl_intF6o
		mov	word_4032A, dx
		cbw
		mov	word_4032C, ax
		retn
sub_10AA0	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_10AAA	proc near		; CODE XREF: seg000:0927p
					; DATA XREF: seg008:jumpTbl_intF6o
		mov	word_4032E, dx
		retn
sub_10AAA	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


apiF6_09_DrawChar proc near		; CODE XREF: seg000:0927p
					; apiF6_0A_DrawText+2Ap
					; DATA XREF: ...
		test	dh, dh
		jnz	short loc_10ADA	; high byte is set -> assume double-byte Shift-JIS code
		cmp	dl, 0Dh
		jnz	short loc_10ABC
		jmp	loc_10B90	; 0D - handle new-line
; ---------------------------------------------------------------------------

loc_10ABC:				; CODE XREF: apiF6_09_DrawChar+7j
		cmp	dl, 20h
		jb	short locret_10AD9 ; 00..1F - nothing to draw
		mov	dh, 29h
		cmp	dl, 7Eh
		jbe	short loc_10ADD	; 20..7E - ASCII code: use JIS mirror page 29xx
		cmp	dl, 0A0h
		jb	short locret_10AD9 ; 7F	- invalid, 80..9F - invalid (already handled)
		cmp	dl, 0DFh
		ja	short locret_10AD9 ; E0..FF - invalid (already handled)
		mov	dh, 2Ah
		sub	dl, 80h
		jmp	short loc_10ADD	; A0..DF - half-width Katakana:	use JIS	mirror page 2Axx
; ---------------------------------------------------------------------------

locret_10AD9:				; CODE XREF: apiF6_09_DrawChar+Fj
					; apiF6_09_DrawChar+1Bj ...
		retn
; ---------------------------------------------------------------------------

loc_10ADA:				; CODE XREF: apiF6_09_DrawChar+2j
		call	ShiftJIS2JIS

loc_10ADD:				; CODE XREF: apiF6_09_DrawChar+16j
					; apiF6_09_DrawChar+27j
		mov	jisCharToDraw, dx
		mov	si, offset byte_419AC
		mov	cx, si
		mov	bx, ds
		mov	ah, 14h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		call	MakeCharBold
		mov	al, byte_40328
		cmp	byte_40306, al
		jnz	short loc_10AFC
		inc	word_40308

loc_10AFC:				; CODE XREF: apiF6_09_DrawChar+46j
		cmp	byte_40307, al
		jnz	short loc_10B06
		inc	word_4030A

loc_10B06:				; CODE XREF: apiF6_09_DrawChar+50j
		lodsw
		mov	bl, ah
		cmp	bl, 2
		jnz	short loc_10B1A
		mov	ax, word_40324
		cmp	ax, word_40320
		jb	short loc_10B1A
		call	sub_10C7C

loc_10B1A:				; CODE XREF: apiF6_09_DrawChar+5Cj
					; apiF6_09_DrawChar+65j
		mov	ax, 50h
		mul	word_40326
		add	ax, word_40324
		mov	di, ax
		push	es
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		mov	al, 0C0h
		cli
		out	7Ch, al
		mov	ah, byte_40328
		sub	al, al
		shr	ah, 1
		jnb	short loc_10B3E
		dec	al

loc_10B3E:				; CODE XREF: apiF6_09_DrawChar+8Aj
		out	7Eh, al
		sub	al, al
		shr	ah, 1
		jnb	short loc_10B48
		dec	al

loc_10B48:				; CODE XREF: apiF6_09_DrawChar+94j
		out	7Eh, al
		sub	al, al
		shr	ah, 1
		jnb	short loc_10B52
		dec	al

loc_10B52:				; CODE XREF: apiF6_09_DrawChar+9Ej
		out	7Eh, al
		sub	al, al
		shr	ah, 1
		jnb	short loc_10B5C
		dec	al

loc_10B5C:				; CODE XREF: apiF6_09_DrawChar+A8j
		out	7Eh, al
		mov	cx, 10h
		cmp	bl, 2
		jz	short loc_10B71

loc_10B66:				; CODE XREF: apiF6_09_DrawChar+BDj
		lodsb
		mov	es:[di], al
		add	di, 50h
		loop	loc_10B66
		jmp	short loc_10B7A
; ---------------------------------------------------------------------------

loc_10B71:				; CODE XREF: apiF6_09_DrawChar+B4j
					; apiF6_09_DrawChar+C8j
		lodsw
		mov	es:[di], ax
		add	di, 50h
		loop	loc_10B71

loc_10B7A:				; CODE XREF: apiF6_09_DrawChar+BFj
		sub	al, al
		out	7Ch, al
		sti
		pop	es
		assume es:nothing
		mov	ax, word_40324
		sub	bh, bh
		add	ax, bx
		mov	word_40324, ax
		cmp	ax, word_40320
		jbe	short loc_10B93

loc_10B90:				; CODE XREF: apiF6_09_DrawChar+9j
		call	sub_10C7C

loc_10B93:				; CODE XREF: apiF6_09_DrawChar+DEj
		mov	cx, word_4032E
		jcxz	short loc_10BA9
		call	GetJISCharWait
		test	ax, ax
		jnz	short loc_10BA3
		call	sub_102A4

loc_10BA3:				; CODE XREF: apiF6_09_DrawChar+EEj
		call	sub_10C36
		call	sub_102AA

loc_10BA9:				; CODE XREF: apiF6_09_DrawChar+E7j
		mov	cx, word_4032A
		jcxz	short locret_10BBC
		call	GetJISCharWait
		test	ax, ax
		jz	short loc_10BB9
		add	cx, 25

loc_10BB9:				; CODE XREF: apiF6_09_DrawChar+104j
		call	sub_10C36

locret_10BBC:				; CODE XREF: apiF6_09_DrawChar+FDj
		retn
apiF6_09_DrawChar endp

; ---------------------------------------------------------------------------
		align 2
		push	si		; unused
		push	di
		push	dx
		mov	dl, byte_40328
		mov	cx, 10h
		cmp	bl, 2
		jz	short loc_10BE3

loc_10BCD:				; CODE XREF: seg000:0BDFj
		lodsb
		not	al
		and	es:[di], al
		test	dl, dh
		jz	short loc_10BDC
		not	al
		or	es:[di], al

loc_10BDC:				; CODE XREF: seg000:0BD5j
		add	di, 50h
		loop	loc_10BCD
		jmp	short loc_10BF7
; ---------------------------------------------------------------------------

loc_10BE3:				; CODE XREF: seg000:0BCBj seg000:0BF5j
		lodsw
		not	ax
		and	es:[di], ax
		test	dl, dh
		jz	short loc_10BF2
		not	ax
		or	es:[di], ax

loc_10BF2:				; CODE XREF: seg000:0BEBj
		add	di, 50h
		loop	loc_10BE3

loc_10BF7:				; CODE XREF: seg000:0BE1j
		pop	dx
		pop	di
		pop	si
		retn
; ---------------------------------------------------------------------------
		nop

; =============== S U B	R O U T	I N E =======================================


MakeCharBold	proc near		; CODE XREF: apiF6_09_DrawChar+3Cp
		cmp	enableBoldFont,	0
		jz	short locret_10C35
		push	si
		push	cx
		push	ax
		lea	si, [si+2]
		mov	cx, 10h
		cmp	byte ptr [si-1], 2
		jz	short loc_10C21

loc_10C12:				; CODE XREF: MakeCharBold+21j
		mov	al, [si]
		shr	al, 1
		jnb	short loc_10C1A
		or	al, 2

loc_10C1A:				; CODE XREF: MakeCharBold+1Aj
		or	[si], al
		inc	si
		loop	loc_10C12
		jmp	short loc_10C32
; ---------------------------------------------------------------------------

loc_10C21:				; CODE XREF: MakeCharBold+14j
					; MakeCharBold+34j
		mov	ax, [si]
		shr	al, 1
		rcr	ah, 1
		jnb	short loc_10C2C
		or	ah, 2

loc_10C2C:				; CODE XREF: MakeCharBold+2Bj
		or	[si], ax
		inc	si
		inc	si
		loop	loc_10C21

loc_10C32:				; CODE XREF: MakeCharBold+23j
		pop	ax
		pop	cx
		pop	si

locret_10C35:				; CODE XREF: MakeCharBold+5j
		retn
MakeCharBold	endp


; =============== S U B	R O U T	I N E =======================================


sub_10C36	proc near		; CODE XREF: apiF6_09_DrawChar:loc_10BA3p
					; apiF6_09_DrawChar:loc_10BB9p
		mov	word_4027C, cx

loc_10C3A:				; CODE XREF: sub_10C36+Ej
		call	sub_10C48
		jnz	short locret_10C46
		cmp	word_4027C, 0
		jnz	short loc_10C3A

locret_10C46:				; CODE XREF: sub_10C36+7j
		retn
sub_10C36	endp

; ---------------------------------------------------------------------------
		nop

; =============== S U B	R O U T	I N E =======================================


sub_10C48	proc near		; CODE XREF: sub_10C36:loc_10C3Ap
		cmp	word_4032C, 0
		jz	short locret_10C5E
		mov	ah, 2
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		test	al, 1
		jnz	short locret_10C5E
		mov	ax, 6
		int	33h		; - MS MOUSE - RETURN BUTTON RELEASE DATA
					; BX = button
		test	ax, ax

locret_10C5E:				; CODE XREF: sub_10C48+5j sub_10C48+Dj
		retn
sub_10C48	endp

; ---------------------------------------------------------------------------
		nop

; =============== S U B	R O U T	I N E =======================================


GetJISCharWait	proc near		; CODE XREF: apiF6_09_DrawChar+E9p
					; apiF6_09_DrawChar+FFp
		mov	bx, jisCharToDraw
		sub	ax, ax
		cmp	bh, 21h
		jnz	short locret_10C7B ; not control codes - return	0
		cmp	bl, 2Ah
		jbe	short loc_10C7A	; 2121..212A: sentence punctuation - return 1
		cmp	bl, 44h
		jz	short loc_10C7A	; 2144:	low dot	- return 1
		cmp	bl, 45h
		jnz	short locret_10C7B ; 2145: middle dot -	return 1

loc_10C7A:				; CODE XREF: GetJISCharWait+Ej
					; GetJISCharWait+13j
		inc	ax

locret_10C7B:				; CODE XREF: GetJISCharWait+9j
					; GetJISCharWait+18j
		retn
GetJISCharWait	endp

		assume es:seg008

; =============== S U B	R O U T	I N E =======================================


sub_10C7C	proc near		; CODE XREF: apiF6_09_DrawChar+67p
					; apiF6_09_DrawChar:loc_10B90p
		mov	ax, word_4031C
		mov	word_40324, ax
		mov	ax, word_40326
		add	ax, 14h
		cmp	ax, word_40322
		jb	short loc_10C91
		mov	ax, word_4031E

loc_10C91:				; CODE XREF: sub_10C7C+10j
		mov	word_40326, ax
		retn
sub_10C7C	endp

; ---------------------------------------------------------------------------
		nop

; =============== S U B	R O U T	I N E =======================================


apiF6_0A_DrawText proc near		; CODE XREF: seg000:0927p
					; apiF6_0A_DrawText+2Ej
					; DATA XREF: ...
		push	ds
		mov	ds, word ptr [bp+2]
		assume ds:nothing
		lodsw
		pop	ds
		test	al, al
		jz	short locret_10CC6
		cmp	al, 0FFh
		jz	short locret_10CC6
		cmp	al, 81h
		jb	short loc_10CB4
		cmp	al, 9Fh
		jbe	short loc_10CBB
		cmp	al, 0E0h
		jb	short loc_10CB4
		cmp	al, 0FCh
		jbe	short loc_10CBB

loc_10CB4:				; CODE XREF: apiF6_0A_DrawText+10j
					; apiF6_0A_DrawText+18j
		dec	si
		sub	dh, dh
		mov	dl, al
		jmp	short loc_10CBF
; ---------------------------------------------------------------------------

loc_10CBB:				; CODE XREF: apiF6_0A_DrawText+14j
					; apiF6_0A_DrawText+1Cj
		mov	dh, al
		mov	dl, ah

loc_10CBF:				; CODE XREF: apiF6_0A_DrawText+23j
		push	si
		call	apiF6_09_DrawChar
		pop	si
		jmp	short apiF6_0A_DrawText
; ---------------------------------------------------------------------------

locret_10CC6:				; CODE XREF: apiF6_0A_DrawText+8j
					; apiF6_0A_DrawText+Cj
		retn
apiF6_0A_DrawText endp

; ---------------------------------------------------------------------------
		nop
		assume ds:seg008

; =============== S U B	R O U T	I N E =======================================


sub_10CC8	proc near		; CODE XREF: seg000:0927p
					; DATA XREF: seg008:jumpTbl_intF6o
		mov	si, offset word_4031C
		push	ax
		call	sub_10CF8
		pop	ax
		call	sub_10D12
		mov	ax, word_4031C
		mov	word_40324, ax
		mov	ax, word_4031E
		mov	word_40326, ax
		retn
sub_10CC8	endp


; =============== S U B	R O U T	I N E =======================================


sub_10CE0	proc near		; CODE XREF: seg000:0927p
					; DATA XREF: seg008:jumpTbl_intF6o
		sub	di, di
		mov	cx, 50h
		mov	dx, offset word_40310
		call	sub_10D12
		retn
sub_10CE0	endp


; =============== S U B	R O U T	I N E =======================================


sub_10CEC	proc near		; CODE XREF: seg000:0927p
					; DATA XREF: seg008:jumpTbl_intF6o
		mov	ds, word ptr [bp+2]
		assume ds:nothing
		push	ax
		call	sub_10CF8
		pop	ax
		call	sub_10D12
		retn
sub_10CEC	endp


; =============== S U B	R O U T	I N E =======================================


sub_10CF8	proc near		; CODE XREF: sub_10CC8+4p sub_10CEC+4p ...
		mov	ax, [si+2]
		mov	bx, 50h
		mul	bx
		add	ax, [si]
		mov	di, ax
		mov	cx, [si+4]
		sub	cx, [si]
		inc	cx
		mov	dx, [si+6]
		sub	dx, [si+2]
		inc	dx
		retn
sub_10CF8	endp


; =============== S U B	R O U T	I N E =======================================


sub_10D12	proc near		; CODE XREF: sub_10CC8+8p sub_10CE0+8p ...
		cld
		mov	bx, 0A800h
		mov	es, bx
		assume es:nothing
		mov	ah, al
		mov	al, 80h
		out	7Ch, al
		mov	bx, 0FF00h
		mov	al, bl
		test	ah, 1
		jz	short loc_10D2A
		mov	al, bh

loc_10D2A:				; CODE XREF: sub_10D12+14j
		out	7Eh, al
		mov	al, bl
		test	ah, 2
		jz	short loc_10D35
		mov	al, bh

loc_10D35:				; CODE XREF: sub_10D12+1Fj
		out	7Eh, al
		mov	al, bl
		test	ah, 4
		jz	short loc_10D40
		mov	al, bh

loc_10D40:				; CODE XREF: sub_10D12+2Aj
		out	7Eh, al
		mov	al, bl
		test	ah, 8
		jz	short loc_10D4B
		mov	al, bh

loc_10D4B:				; CODE XREF: sub_10D12+35j
		out	7Eh, al
		mov	ax, cx
		mov	bx, 50h
		mov	si, di

loc_10D54:				; CODE XREF: sub_10D12+4Bj
		mov	cx, ax
		mov	di, si
		rep stosb
		add	si, bx
		dec	dx
		jnz	short loc_10D54
		sub	al, al
		out	7Ch, al
		retn
sub_10D12	endp

; ---------------------------------------------------------------------------
		assume es:seg008, ds:seg008

loc_10D64:				; CODE XREF: seg000:0927p
					; DATA XREF: seg008:jumpTbl_intF6o
		push	ds
		mov	ds, word ptr [bp+2]
		assume ds:nothing
		call	sub_10CF8
		pop	ds
		assume ds:seg008
		mov	al, 0FFh
		mov	bx, 50h
		mov	si, di
		mov	es, word_40310
		assume es:nothing
		call	sub_10D90
		mov	es, word_40310+2
		assume es:nothing
		call	sub_10D90
		mov	es, word_40310+4
		assume es:nothing
		call	sub_10D90
		mov	es, word_40310+6
		assume es:nothing
		call	sub_10D90
		retn

; =============== S U B	R O U T	I N E =======================================


sub_10D90	proc near		; CODE XREF: seg000:0D77p seg000:0D7Ep ...
		mov	di, si
		push	cx
		push	dx

loc_10D94:				; CODE XREF: sub_10D90+11j
		push	di
		push	cx

loc_10D96:				; CODE XREF: sub_10D90+Aj
		xor	es:[di], al
		inc	di
		loop	loc_10D96
		pop	cx
		pop	di
		add	di, bx
		dec	dx
		jnz	short loc_10D94
		pop	dx
		pop	cx
		retn
sub_10D90	endp

		assume es:seg008

; =============== S U B	R O U T	I N E =======================================


sub_10DA6	proc near		; CODE XREF: seg000:0927p
					; DATA XREF: seg008:jumpTbl_intF6o
		mov	byte ptr word_40330, ch
		mov	byte ptr word_40330+1, cl
		mov	byte_40332, dh
		mov	byte_40333, dl
		mov	es, word_40318
		assume es:nothing
		cmp	al, 7
		ja	short loc_10E08
		mov	byte_40334, al
		shl	al, 5
		or	al, 11h
		mov	dl, al
		sub	si, si

loc_10DCA:				; CODE XREF: sub_10DA6+5Ej
		mov	di, si

loc_10DCC:				; CODE XREF: sub_10DA6+2Aj
		in	al, 60h		; 8042 keyboard	controller data	register
		test	al, 20h
		jnz	short loc_10DCC

loc_10DD2:				; CODE XREF: sub_10DA6+30j
		in	al, 60h		; 8042 keyboard	controller data	register
		test	al, 20h
		jz	short loc_10DD2

loc_10DD8:				; CODE XREF: sub_10DA6+40j
		call	sub_10E56
		or	es:[bx], al
		add	di, word_40336
		cmp	di, 3E80h
		jb	short loc_10DD8
		mov	di, word_40336
		sub	di, si
		dec	di

loc_10DEF:				; CODE XREF: sub_10DA6+57j
		call	sub_10E56
		or	es:[bx], al
		add	di, word_40336
		cmp	di, 3E80h
		jb	short loc_10DEF
		inc	si
		cmp	si, word ptr unk_40338
		jb	short loc_10DCA
		retn
; ---------------------------------------------------------------------------
		db  90h	; ê
; ---------------------------------------------------------------------------

loc_10E08:				; CODE XREF: sub_10DA6+16j
		mov	dl, byte_40334
		shl	dl, 5
		or	dl, 11h
		sub	si, si

loc_10E14:				; CODE XREF: sub_10DA6+ACj
		mov	di, si

loc_10E16:				; CODE XREF: sub_10DA6+74j
		in	al, 60h		; 8042 keyboard	controller data	register
		test	al, 20h
		jnz	short loc_10E16

loc_10E1C:				; CODE XREF: sub_10DA6+7Aj
		in	al, 60h		; 8042 keyboard	controller data	register
		test	al, 20h
		jz	short loc_10E1C

loc_10E22:				; CODE XREF: sub_10DA6+8Cj
		call	sub_10E56
		not	al
		and	es:[bx], al
		add	di, word_40336
		cmp	di, 3E80h
		jb	short loc_10E22
		mov	di, word_40336
		sub	di, si
		dec	di

loc_10E3B:				; CODE XREF: sub_10DA6+A5j
		call	sub_10E56
		not	al
		and	es:[bx], al
		add	di, word_40336
		cmp	di, 3E80h
		jb	short loc_10E3B
		inc	si
		cmp	si, word ptr unk_40338
		jb	short loc_10E14
		retn
sub_10DA6	endp

; ---------------------------------------------------------------------------
		db  90h	; ê

; =============== S U B	R O U T	I N E =======================================


sub_10E56	proc near		; CODE XREF: sub_10DA6:loc_10DD8p
					; sub_10DA6:loc_10DEFp	...
		mov	ax, di
		mov	bl, 0A0h ; '†'
		div	bl
		cmp	al, byte ptr word_40330+1
		jb	short loc_10E9E
		cmp	al, byte_40333
		ja	short loc_10E9E
		cmp	ah, byte ptr word_40330
		jb	short loc_10E9E
		cmp	ah, byte_40332
		ja	short loc_10E9E
		mov	cx, ax
		and	ax, 0FCh
		mov	bl, 28h	; '('
		mul	bl
		mov	bl, ch
		and	bx, 0FEh
		add	bx, ax
		push	bx
		mov	bl, ch
		and	bx, 1
		shl	bx, 2
		and	cx, 3
		add	bx, cx
		mov	al, [bx+1BAh]
		pop	bx
		mov	es:[bx+2000h], dl
		retn
; ---------------------------------------------------------------------------

loc_10E9E:				; CODE XREF: sub_10E56+Aj
					; sub_10E56+10j ...
		sub	al, al
		retn
sub_10E56	endp

; ---------------------------------------------------------------------------
		nop

; =============== S U B	R O U T	I N E =======================================


sub_10EA2	proc near		; CODE XREF: seg000:0927p
					; DATA XREF: seg008:jumpTbl_intF6o
		call	sub_10EEE
		retn
sub_10EA2	endp


; =============== S U B	R O U T	I N E =======================================


sub_10EA6	proc near		; CODE XREF: seg000:0927p
					; DATA XREF: seg008:jumpTbl_intF6o
		push	word_4031C
		push	word_4031E
		push	word_40320
		push	word_40322
		mov	es, word ptr [bp+2]
		assume es:nothing
		mov	bx, es:[si]
		mov	word_4031C, bx
		mov	bx, es:[si+2]
		mov	word_4031E, bx
		mov	bx, es:[si+4]
		mov	word_40320, bx
		mov	bx, es:[si+6]
		mov	word_40322, bx
		push	ds
		call	sub_10EEE
		pop	ds
		pop	word_40322
		pop	word_40320
		pop	word_4031E
		pop	word_4031C
		retn
sub_10EA6	endp


; =============== S U B	R O U T	I N E =======================================


sub_10EEE	proc near		; CODE XREF: sub_10EA2p sub_10EA6+33p
		push	bp
		mov	bx, 50h
		jcxz	short loc_10F08
		mov	word_419CE, cx
		test	al, al
		jz	short loc_10F0A
		dec	al
		jz	short loc_10F1E
		dec	al
		jz	short loc_10F32
		dec	al
		jz	short loc_10F45

loc_10F08:				; CODE XREF: sub_10EEE+4j
					; sub_10EEE+2Ej ...
		pop	bp
		retn
; ---------------------------------------------------------------------------

loc_10F0A:				; CODE XREF: sub_10EEE+Cj
		mov	dx, word_4031C
		mov	ax, word_4031E
		call	sub_11188
		mov	si, di
		add	si, bx

loc_10F18:				; CODE XREF: sub_10EEE+42j
		cld
		call	sub_10F56
		jmp	short loc_10F08
; ---------------------------------------------------------------------------

loc_10F1E:				; CODE XREF: sub_10EEE+10j
		mov	dx, word_4031C
		mov	ax, word_40322
		dec	ax
		call	sub_11188
		mov	si, di
		add	di, bx
		not	bx
		inc	bx
		jmp	short loc_10F18
; ---------------------------------------------------------------------------

loc_10F32:				; CODE XREF: sub_10EEE+14j
		mov	dx, word_4031C
		mov	ax, word_4031E
		call	sub_11188
		mov	si, di
		inc	si
		cld

loc_10F40:				; CODE XREF: sub_10EEE+65j
		call	sub_10F86
		jmp	short loc_10F08
; ---------------------------------------------------------------------------

loc_10F45:				; CODE XREF: sub_10EEE+18j
		mov	dx, word_40320
		mov	ax, word_4031E
		call	sub_11188
		mov	si, di
		dec	si
		std
		jmp	short loc_10F40
sub_10EEE	endp

; ---------------------------------------------------------------------------
		nop

; =============== S U B	R O U T	I N E =======================================


sub_10F56	proc near		; CODE XREF: sub_10EEE+2Bp
		push	es
		mov	ax, word_40322
		sub	ax, word_4031E
		mov	dx, word_40320
		sub	dx, word_4031C
		inc	dx
		mov	bp, ax
		mov	ax, word_4031A
		inc	ax
		jz	short loc_10F7A

loc_10F6F:				; CODE XREF: sub_10F56+20j
		call	sub_10FA4
		dec	word_419CE
		jnz	short loc_10F6F
		jmp	short loc_10F83
; ---------------------------------------------------------------------------

loc_10F7A:				; CODE XREF: sub_10F56+17j
					; sub_10F56+2Bj
		call	sub_1109A
		dec	word_419CE
		jnz	short loc_10F7A

loc_10F83:				; CODE XREF: sub_10F56+22j
		pop	es
		retn
sub_10F56	endp

; ---------------------------------------------------------------------------
		db  90h	; ê

; =============== S U B	R O U T	I N E =======================================


sub_10F86	proc near		; CODE XREF: sub_10EEE:loc_10F40p
		push	es
		mov	ax, word_40322
		sub	ax, word_4031E
		inc	ax
		mov	dx, word_40320
		sub	dx, word_4031C
		mov	bp, ax

loc_10F99:				; CODE XREF: sub_10F86+1Aj
		call	sub_1102E
		dec	word_419CE
		jnz	short loc_10F99
		pop	es
		retn
sub_10F86	endp


; =============== S U B	R O U T	I N E =======================================


sub_10FA4	proc near		; CODE XREF: sub_10F56:loc_10F6Fp
		push	bp
		push	dx
		push	si
		push	di

loc_10FA8:				; CODE XREF: sub_10FA4+8j
		in	al, 60h		; 8042 keyboard	controller data	register
		test	al, 20h
		jnz	short loc_10FA8

loc_10FAE:				; CODE XREF: sub_10FA4+Ej
		in	al, 60h		; 8042 keyboard	controller data	register
		test	al, 20h
		jz	short loc_10FAE

loc_10FB4:				; CODE XREF: sub_10FA4+59j
		mov	ax, word_40310
		push	ds
		push	si
		push	di
		mov	ds, ax
		assume ds:nothing
		mov	es, ax
		assume es:nothing
		mov	cx, dx
		rep movsb
		pop	di
		pop	si
		pop	ds
		assume ds:nothing
		mov	ax, ds:192h
		push	ds
		push	si
		push	di
		mov	ds, ax
		mov	es, ax
		assume es:nothing
		mov	cx, dx
		rep movsb
		pop	di
		pop	si
		pop	ds
		mov	ax, ds:194h
		push	ds
		push	si
		push	di
		mov	ds, ax
		mov	es, ax
		mov	cx, dx
		rep movsb
		pop	di
		pop	si
		pop	ds
		mov	ax, ds:196h
		push	ds
		push	si
		push	di
		mov	ds, ax
		mov	es, ax
		mov	cx, dx
		rep movsb
		pop	di
		pop	si
		pop	ds
		add	si, bx
		add	di, bx
		dec	bp
		jnz	short loc_10FB4
		mov	si, di
		sub	ax, ax
		mov	es, word ptr ds:190h
		mov	cx, dx
		rep stosb
		mov	es, word ptr ds:192h
		mov	di, si
		mov	cx, dx
		rep stosb
		mov	es, word ptr ds:194h
		mov	di, si
		mov	cx, dx
		rep stosb
		mov	es, word ptr ds:196h
		mov	di, si
		mov	cx, dx
		rep stosb
		pop	di
		pop	si
		pop	dx
		pop	bp
		retn
sub_10FA4	endp


; =============== S U B	R O U T	I N E =======================================


sub_1102E	proc near		; CODE XREF: sub_10F86:loc_10F99p
		push	bp
		push	dx
		push	si
		push	di

loc_11032:				; CODE XREF: sub_1102E+8j
		in	al, 60h		; 8042 keyboard	controller data	register
		test	al, 20h
		jnz	short loc_11032

loc_11038:				; CODE XREF: sub_1102E+Ej
		in	al, 60h		; 8042 keyboard	controller data	register
		test	al, 20h
		jz	short loc_11038

loc_1103E:				; CODE XREF: sub_1102E+65j
		mov	ax, ds:190h
		push	ds
		push	si
		push	di
		mov	ds, ax
		mov	es, ax
		mov	cx, dx
		rep movsb
		mov	byte ptr [di], 0
		pop	di
		pop	si
		pop	ds
		mov	ax, ds:192h
		push	ds
		push	si
		push	di
		mov	ds, ax
		mov	es, ax
		mov	cx, dx
		rep movsb
		mov	byte ptr [di], 0
		pop	di
		pop	si
		pop	ds
		mov	ax, ds:194h
		push	ds
		push	si
		push	di
		mov	ds, ax
		mov	es, ax
		mov	cx, dx
		rep movsb
		mov	byte ptr [di], 0
		pop	di
		pop	si
		pop	ds
		mov	ax, ds:196h
		push	ds
		push	si
		push	di
		mov	ds, ax
		mov	es, ax
		mov	cx, dx
		rep movsb
		mov	byte ptr [di], 0
		pop	di
		pop	si
		pop	ds
		add	si, bx
		add	di, bx
		dec	bp
		jnz	short loc_1103E
		pop	di
		pop	si
		pop	dx
		pop	bp
		retn
sub_1102E	endp


; =============== S U B	R O U T	I N E =======================================


sub_1109A	proc near		; CODE XREF: sub_10F56:loc_10F7Ap
		push	bp
		push	dx
		push	si
		push	di
		push	dx
		call	sub_11168
		sub	ax, ax
		add	dx, 4
		out	dx, ax
		pop	ax
		push	ax
		shl	ax, 3
		dec	ax
		add	dx, 2
		out	dx, ax
		pop	dx

loc_110B3:				; CODE XREF: sub_1109A+1Dj
		in	al, 60h		; 8042 keyboard	controller data	register
		test	al, 20h
		jnz	short loc_110B3

loc_110B9:				; CODE XREF: sub_1109A+23j
		in	al, 60h		; 8042 keyboard	controller data	register
		test	al, 20h
		jz	short loc_110B9

loc_110BF:				; CODE XREF: sub_1109A+3Bj
		mov	ax, ds:190h
		push	ds
		push	si
		push	di
		mov	ds, ax
		mov	es, ax
		mov	cx, dx
		rep movsb
		pop	di
		pop	si
		pop	ds
		add	si, bx
		add	di, bx
		dec	bp
		jnz	short loc_110BF
		mov	cx, dx
		call	sub_10A04
		mov	al, 80h	; 'Ä'
		out	7Ch, al
		sub	al, al
		out	7Eh, al
		out	7Eh, al
		out	7Eh, al
		out	7Eh, al
		rep stosb
		out	7Ch, al
		pop	di
		pop	si
		pop	dx
		pop	bp
		retn
sub_1109A	endp

; ---------------------------------------------------------------------------
		nop
		push	ds
		push	bp
		push	dx
		push	si
		push	di
		push	bx
		sub	ax, ax
		mov	bx, 7D00h
		mov	es, word ptr ds:190h
		mov	es:[bx], ax
		mov	es, word ptr ds:192h
		mov	es:[bx], ax
		mov	es, word ptr ds:194h
		mov	es:[bx], ax
		mov	es, word ptr ds:196h
		mov	es:[bx], ax
		pop	bx
		mov	ax, ds:190h
		mov	ds, ax
		mov	es, ax
		push	dx
		call	sub_11168
		mov	ax, 8
		add	dx, 4
		out	dx, ax
		pop	ax
		push	ax
		dec	ax
		shl	ax, 3
		add	dx, 2
		out	dx, ax
		pop	dx

loc_11139:				; CODE XREF: seg000:113Dj
		in	al, 60h		; 8042 keyboard	controller data	register
		test	al, 20h
		jnz	short loc_11139

loc_1113F:				; CODE XREF: seg000:1143j
		in	al, 60h		; 8042 keyboard	controller data	register
		test	al, 20h
		jz	short loc_1113F

loc_11145:				; CODE XREF: seg000:115Dj
		push	si
		push	di
		mov	cx, dx
		shr	cx, 1
		rep movsw
		jnb	short loc_11151
		movsw
		dec	di

loc_11151:				; CODE XREF: seg000:114Dj
		mov	ax, ds:7D00h
		mov	[di], al
		pop	di
		pop	si
		add	si, bx
		add	di, bx
		dec	bp
		jnz	short loc_11145
		call	sub_10A04
		pop	di
		pop	si
		pop	dx
		pop	bp
		pop	ds
		retn

; =============== S U B	R O U T	I N E =======================================


sub_11168	proc near		; CODE XREF: sub_1109A+5p seg000:1124p
		call	sub_109F0
		mov	dx, 4A0h
		mov	ax, 0FFF0h
		out	dx, ax
		mov	ax, 0FFh
		add	dx, 2
		out	dx, ax
		mov	ax, 28F0h
		add	dx, 2
		out	dx, ax
		mov	ax, 0FFFFh
		add	dx, 4
		out	dx, ax
		retn
sub_11168	endp


; =============== S U B	R O U T	I N E =======================================


sub_11188	proc near		; CODE XREF: sub_10EEE+23p
					; sub_10EEE+38p ...
		push	ax
		push	bx
		push	dx
		mov	di, dx
		mov	bx, 50h	; 'P'
		mul	bx
		add	di, ax
		pop	dx
		pop	bx
		pop	ax
		retn
sub_11188	endp

		assume es:seg008, ds:seg008

; =============== S U B	R O U T	I N E =======================================


apiF6_12_GetBold proc near		; CODE XREF: seg000:0927p
					; DATA XREF: seg008:jumpTbl_intF6o
		mov	ah, [bp+12h]
apiF6_12_GetBold endp ;	sp-analysis failed


; =============== S U B	R O U T	I N E =======================================


nullsub_1	proc near		; CODE XREF: SetupIntVecF6+3Cp
		retn
nullsub_1	endp


; =============== S U B	R O U T	I N E =======================================


apiF6_13_SetBold proc near		; CODE XREF: seg000:0927p
					; DATA XREF: seg008:jumpTbl_intF6o
		mov	al, [bp+12h]
		cmp	al, 1
		ja	short loc_111A8
		mov	enableBoldFont,	al
		retn
; ---------------------------------------------------------------------------
		align 2

loc_111A8:				; CODE XREF: apiF6_13_SetBold+5j
		mov	al, enableBoldFont
		mov	[bp+12h], al
		retn
apiF6_13_SetBold endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


SetupIntVecF2	proc near		; CODE XREF: DoMainInit+3Ep
		mov	al, 0F2h
		call	GetIntVec
		mov	word ptr OldIntF2Vec, dx
		mov	word ptr OldIntF2Vec+2,	es
		push	cs
		pop	es
		assume es:seg000
		mov	dx, offset IntF2_FileAPIs
		call	SetIntVec
		mov	al, 24h
		mov	dx, offset Int24
		call	SetIntVec
		mov	ah, 2Fh
		int	21h		; DOS -	GET DISK TRANSFER AREA ADDRESS
					; Return: ES:BX	-> DTA
		mov	word ptr dword_419D4, bx
		mov	word ptr dword_419D4+2,	es
		mov	ah, 30h
		int	21h		; DOS -	GET DOS	VERSION
					; Return: AL = major version number (00h for DOS 1.x)
		cmp	ax, 2
		jnz	short loc_111EA
		sub	al, al

loc_111EA:				; CODE XREF: SetupIntVecF2+36j
		mov	byte_41A2F, al
		push	ax
		mov	ah, 19h
		int	21h		; DOS -	GET DEFAULT DISK NUMBER
		mov	defaultDiskNum,	al
		pop	ax
		test	al, al
		jz	short loc_11227
		cmp	al, 2
		jz	short loc_11207
		mov	bl, 0
		mov	ax, 4408h
		int	21h		; DOS -	2+ - IOCTL -
		jmp	short loc_11229
; ---------------------------------------------------------------------------

loc_11207:				; CODE XREF: SetupIntVecF2+4Cj
		mov	bx, 60h
		mov	es, bx
		assume es:nothing
		mov	bl, defaultDiskNum
		mov	ah, es:[bx+6Ch]
		and	ah, 7Ch
		sub	al, al
		cmp	ah, 10h
		jz	short loc_11229
		cmp	ah, 70h
		jz	short loc_11229
		inc	al
		jmp	short loc_11229
; ---------------------------------------------------------------------------

loc_11227:				; CODE XREF: SetupIntVecF2+48j
		sub	al, al

loc_11229:				; CODE XREF: SetupIntVecF2+55j
					; SetupIntVecF2+6Cj ...
		mov	hardDiskMode, al
		test	al, al
		jnz	short locret_11244
		mov	al, defaultDiskNum
		call	sub_11496
		cld
		push	ds
		pop	es
		assume es:seg008
		mov	si, offset byte_41A24
		mov	di, offset byte_41A1A
		mov	cx, 5
		rep movsw

locret_11244:				; CODE XREF: SetupIntVecF2+7Ej
		retn
SetupIntVecF2	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


RestoreIntVecF2	proc near		; CODE XREF: seg000:0119p
		mov	al, 0F2h
		les	dx, OldIntF2Vec
		assume es:nothing
		call	SetIntVec
		retn
RestoreIntVecF2	endp

; ---------------------------------------------------------------------------

IntF2_FileAPIs:				; DATA XREF: SetupIntVecF2+11o
		pusha
		push	ds
		push	es
		mov	bp, sp
		in	al, 2		; DMA controller, 8237A-5.
					; channel 1 current address
		or	al, 1
		jmp	short $+2
		out	2, al		; DMA controller, 8237A-5.
					; channel 1 base address
					; (also	sets current address)
		test	byte ptr [bp+19h], 2
		jz	short loc_11266
		sti

loc_11266:				; CODE XREF: seg000:1263j
		cld
		and	byte ptr [bp+18h], 0FEh
		mov	bx, seg	seg008
		mov	ds, bx
		mov	es, bx
		assume es:seg008
		cmp	ah, 8
		jbe	short loc_11279
		mov	ah, 9

loc_11279:				; CODE XREF: seg000:1275j
		mov	bl, ah
		sub	bh, bh
		add	bx, bx
		call	jumpTbl_intF2[bx]
		cli
		in	al, 2		; DMA controller, 8237A-5.
					; channel 1 current address
		and	al, 0FEh
		jmp	short $+2
		out	2, al		; DMA controller, 8237A-5.
					; channel 1 base address
					; (also	sets current address)
		pop	es
		assume es:nothing
		pop	ds
		assume ds:nothing
		popa
		iret
; ---------------------------------------------------------------------------

Int24:					; DATA XREF: SetupIntVecF2+1Bo
		pusha
		push	ds
		push	es
		mov	bp, sp
		cld
		mov	bx, seg	seg008
		mov	ds, bx
		assume ds:seg008
		mov	es, bx
		assume es:seg008
		mov	cs:byte_11314, 0
		test	ah, 80h
		jnz	short loc_1130C
		mov	cs:byte_11314, 1
		and	di, 0FFh
		cmp	di, 0Ch
		jbe	short loc_112BA
		mov	di, 0Ch

loc_112BA:				; CODE XREF: seg000:12B5j
		add	al, 60h		; add disk ID to 60h = 'A' (Shift-JIS, 2nd byte)
		mov	byte ptr aErrorDriveA+0Fh, al
		add	di, di
		mov	si, diskErrMsgList[di]
		push	si
		call	sub_11338
		call	BackupTRAMLine
		mov	es, word_40318
		assume es:nothing
		mov	di, 0A00h
		mov	cl, byte_4056D
		mov	bx, 2000h
		mov	si, offset aErrorDriveA	; "Å@ÅsÅ@ÉhÉâÉCÉuÇ`Ç≈ÉGÉâÅ[î≠ê∂ÅIÅ@"
		call	DrawText
		pop	si
		call	DrawText
		mov	si, offset aErrMsgEnd ;	"Å@ÅtÅ@"
		call	DrawText
		mov	ah, 12h
		int	0F3h
		mov	ah, 11h
		push	ax
		cmp	al, 3
		jbe	short loc_112F7
		mov	al, 3

loc_112F7:				; CODE XREF: seg000:12F3j
		int	0F3h
		sti
		call	sub_1135C
		call	sub_11338
		call	sub_1134A
		call	RestoreTRAMLine
		pop	ax
		int	0F3h
		call	sub_11338

loc_1130C:				; CODE XREF: seg000:12A6j
		pop	es
		assume es:nothing
		pop	ds
		assume ds:nothing
		popa
		mov	al, cs:byte_11314
		iret
; ---------------------------------------------------------------------------
byte_11314	db 0			; DATA XREF: seg000:129Dw seg000:12A8w ...
		align 2
; START	OF FUNCTION CHUNK FOR DrawText

loc_11316:				; CODE XREF: DrawText+3j
		xchg	ah, al
		mov	dx, ax
		mov	ah, 2
		int	0F1h		; reserved for user interrupt
		mov	ax, dx
		xchg	ah, al
		sub	al, 20h
		mov	es:[bx+di], cl
		stosw
		or	al, 80h
		mov	es:[bx+di], cl
		stosw
; END OF FUNCTION CHUNK	FOR DrawText

; =============== S U B	R O U T	I N E =======================================


DrawText	proc near		; CODE XREF: seg000:12DDp seg000:12E1p ...

; FUNCTION CHUNK AT 1316 SIZE 00000018 BYTES

		lodsw
		test	al, al
		jnz	short loc_11316
		retn
DrawText	endp ; sp-analysis failed

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_11338

loc_11334:				; CODE XREF: sub_11338+6j
		sub	ah, ah
		int	18h		; TRANSFER TO ROM BASIC
; END OF FUNCTION CHUNK	FOR sub_11338	; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all

; =============== S U B	R O U T	I N E =======================================


sub_11338	proc near		; CODE XREF: seg000:12C6p seg000:12FDp ...

; FUNCTION CHUNK AT 1334 SIZE 00000004 BYTES

		mov	ah, 1
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		test	bh, bh
		jnz	short loc_11334
		mov	ax, 7
		int	33h		; - MS MOUSE - DEFINE HORIZONTAL CURSOR	RANGE
					; CX = minimum column, DX = maximum column
		test	ax, ax
		jnz	short sub_11338
		retn
sub_11338	endp ; sp-analysis failed


; =============== S U B	R O U T	I N E =======================================


sub_1134A	proc near		; CODE XREF: seg000:1300p sub_1134A+Fj ...
		mov	ah, 1
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		test	bh, bh
		jnz	short locret_1135B
		mov	ax, 7
		int	33h		; - MS MOUSE - DEFINE HORIZONTAL CURSOR	RANGE
					; CX = minimum column, DX = maximum column
		test	ax, ax
		jz	short sub_1134A

locret_1135B:				; CODE XREF: sub_1134A+6j
		retn
sub_1134A	endp


; =============== S U B	R O U T	I N E =======================================


sub_1135C	proc near		; CODE XREF: seg000:12FAp
		call	sub_102A4
		mov	ah, 1Eh

loc_11361:				; CODE XREF: sub_1135C+9j
					; sub_1135C+15j
		in	al, 60h		; 8042 keyboard	controller data	register
		test	al, 20h
		jnz	short loc_11361
		jmp	short $+2

loc_11369:				; CODE XREF: sub_1135C+11j
		in	al, 60h		; 8042 keyboard	controller data	register
		test	al, 20h
		jz	short loc_11369
		dec	ah
		jnz	short loc_11361
		call	sub_102AA
		retn
sub_1135C	endp

; ---------------------------------------------------------------------------
		align 2
		assume ds:seg008

; =============== S U B	R O U T	I N E =======================================


BackupTRAMLine	proc near		; CODE XREF: seg000:12C9p
		push	ds
		mov	si, 0A00h
		mov	di, offset tramBakBuffer
		mov	ds, word_40318
		assume ds:nothing
		mov	cx, 50h
		rep movsw
		mov	si, 2A00h
		mov	cx, 50h

loc_1138E:				; CODE XREF: BackupTRAMLine+18j
		lodsw
		stosb
		loop	loc_1138E
		pop	ds
		assume ds:nothing
		mov	al, 0Ah
		out	68h, al
		retn
BackupTRAMLine	endp

		assume ds:seg008

; =============== S U B	R O U T	I N E =======================================


RestoreTRAMLine	proc near		; CODE XREF: seg000:1303p
		mov	si, offset tramBakBuffer
		mov	di, 0A00h
		mov	es, word_40318
		assume es:nothing
		mov	cx, 50h
		rep movsw
		mov	di, 2A00h
		mov	cx, 50h

loc_113AD:				; CODE XREF: RestoreTRAMLine+17j
		lodsb
		stosw
		loop	loc_113AD
		mov	al, 0Bh
		out	68h, al
		retn
RestoreTRAMLine	endp


; =============== S U B	R O U T	I N E =======================================


apiF2_SetError	proc near		; CODE XREF: seg000:0927p seg000:127Fp ...
		or	byte ptr [bp+18h], 1
		retn
apiF2_SetError	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


apiF2_00_ReadFile proc near		; CODE XREF: seg000:0927p seg000:127Fp
					; DATA XREF: ...
		mov	bx, [bp+2]
		mov	si, dx
		mov	di, offset byte_419D8
		call	CopyFileName
		call	MaybeCheckDisk
		mov	dx, di
		mov	ax, 3D00h
		int	21h		; DOS -	2+ - OPEN DISK FILE WITH HANDLE
					; DS:DX	-> ASCIZ filename
					; AL = access mode
					; 0 - read
		jb	short loc_113EC
		mov	bx, ax
		mov	dx, [bp+0Ch]
		mov	ds, word ptr [bp+0]
		assume ds:nothing
		mov	cx, 0FF00h
		mov	ah, 3Fh
		int	21h		; DOS -	2+ - READ FROM FILE WITH HANDLE
					; BX = file handle, CX = number	of bytes to read
					; DS:DX	-> buffer
		push	ax
		pushf
		mov	ah, 3Eh
		int	21h		; DOS -	2+ - CLOSE A FILE WITH HANDLE
					; BX = file handle
		popf
		pop	ax
		jnb	short loc_113F1

loc_113EC:				; CODE XREF: apiF2_00_ReadFile+15j
		call	apiF2_SetError
		sub	ax, ax

loc_113F1:				; CODE XREF: apiF2_00_ReadFile+2Ej
		mov	[bp+12h], ax
		retn
apiF2_00_ReadFile endp

; ---------------------------------------------------------------------------
		align 2
		assume ds:seg008

; =============== S U B	R O U T	I N E =======================================


apiF2_01_WriteFile proc	near		; CODE XREF: seg000:0927p seg000:127Fp
					; DATA XREF: ...
		mov	bx, [bp+2]
		mov	si, dx
		mov	di, offset byte_419D8
		call	CopyFileName
		call	MaybeCheckDisk
		mov	dx, di
		mov	cx, 20h
		mov	ah, 3Ch
		int	21h		; DOS -	2+ - CREATE A FILE WITH	HANDLE (CREAT)
					; CX = attributes for file
					; DS:DX	-> ASCIZ filename (may include drive and path)
		jb	short loc_11430
		mov	bx, ax
		mov	dx, [bp+0Ch]
		mov	ds, word ptr [bp+0]
		assume ds:nothing
		mov	cx, [bp+10h]
		mov	ah, 40h
		int	21h		; DOS -	2+ - WRITE TO FILE WITH	HANDLE
					; BX = file handle, CX = number	of bytes to write, DS:DX -> buffer
		pushf
		push	ax
		push	cx
		mov	ah, 3Eh
		int	21h		; DOS -	2+ - CLOSE A FILE WITH HANDLE
					; BX = file handle
		pop	cx
		pop	ax
		popf
		jb	short loc_11430
		cmp	ax, cx
		jz	short loc_11435
		jmp	short loc_11432
; ---------------------------------------------------------------------------

loc_11430:				; CODE XREF: apiF2_01_WriteFile+17j
					; apiF2_01_WriteFile+32j
		sub	ax, ax

loc_11432:				; CODE XREF: apiF2_01_WriteFile+38j
		call	apiF2_SetError

loc_11435:				; CODE XREF: apiF2_01_WriteFile+36j
		mov	[bp+12h], ax
		retn
apiF2_01_WriteFile endp

; ---------------------------------------------------------------------------
		align 2
		assume ds:seg008

; =============== S U B	R O U T	I N E =======================================


apiF2_02_CheckForFile proc near		; CODE XREF: seg000:0927p seg000:127Fp
					; DATA XREF: ...
		mov	bx, [bp+2]
		mov	si, dx
		mov	di, offset byte_419D8
		call	CopyFileName
		call	MaybeCheckDisk
		mov	dx, di
		mov	ax, 3D00h
		int	21h		; DOS -	2+ - OPEN DISK FILE WITH HANDLE
					; DS:DX	-> ASCIZ filename
					; AL = access mode
					; 0 - read
		jb	short loc_1145B
		mov	bx, ax
		mov	ah, 3Eh
		int	21h		; DOS -	2+ - CLOSE A FILE WITH HANDLE
					; BX = file handle
		sub	ax, ax
		jmp	short loc_11461
; ---------------------------------------------------------------------------

loc_1145B:				; CODE XREF: apiF2_02_CheckForFile+15j
		call	apiF2_SetError
		mov	ax, 0FFFFh

loc_11461:				; CODE XREF: apiF2_02_CheckForFile+1Fj
		mov	[bp+12h], ax
		retn
apiF2_02_CheckForFile endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_11466	proc near		; CODE XREF: seg000:0927p seg000:127Fp
					; DATA XREF: ...
		cmp	hardDiskMode, 0
		jz	short loc_11471
		sub	al, al
		jmp	short loc_11492
; ---------------------------------------------------------------------------

loc_11471:				; CODE XREF: sub_11466+5j
		mov	al, [bp+12h]
		add	al, defaultDiskNum
		call	sub_11496
		test	ax, ax
		jnz	short loc_1148D
		call	sub_1153C
		jnz	short loc_1148D
		mov	al, byte_41A2E
		and	al, 1Fh
		dec	al
		jmp	short loc_11492
; ---------------------------------------------------------------------------

loc_1148D:				; CODE XREF: sub_11466+17j
					; sub_11466+1Cj
		call	apiF2_SetError
		mov	al, 0FFh

loc_11492:				; CODE XREF: sub_11466+9j
					; sub_11466+25j
		mov	[bp+12h], al
		retn
sub_11466	endp


; =============== S U B	R O U T	I N E =======================================


sub_11496	proc near		; CODE XREF: SetupIntVecF2+83p
					; sub_11466+12p ...
		push	di
		push	si
		push	ds
		push	es
		mov	ah, 2Fh
		int	21h		; DOS -	GET DISK TRANSFER AREA ADDRESS
					; Return: ES:BX	-> DTA
		push	es
		push	bx
		push	ds
		lds	dx, dword_419D4
		assume ds:nothing
		mov	ah, 1Ah
		int	21h		; DOS -	SET DISK TRANSFER AREA ADDRESS
					; DS:DX	-> disk	transfer buffer
		pop	ds
		assume ds:seg008
		cmp	byte_41A2F, 0
		jz	short loc_114E1
		cmp	byte_41A2F, 2
		jnz	short loc_114E1
		mov	di, offset byte_41A24
		mov	bx, offset unk_4039A
		inc	al
		mov	[bx+7],	al
		mov	dx, bx
		mov	ah, 11h
		int	21h		; DOS -	SEARCH FIRST USING FCB
					; DS:DX	-> FCB
		cbw
		test	ax, ax
		jnz	short loc_1152F
		push	ds
		lds	bx, dword_419D4
		assume ds:nothing
		pop	es
		assume es:nothing
		lea	si, [bx+8]
		mov	cx, 0Bh
		cld
		rep movsb
		sub	ax, ax
		jmp	short loc_1152F
; ---------------------------------------------------------------------------
		assume ds:seg008

loc_114E1:				; CODE XREF: sub_11496+19j
					; sub_11496+20j
		mov	bx, offset aFileMask ; "@:\\*.*"
		add	al, 'A'
		mov	[bx], al
		mov	dx, bx
		mov	cx, 8
		mov	ah, 4Eh
		int	21h		; DOS -	2+ - FIND FIRST	ASCIZ (FINDFIRST)
					; CX = search attributes
					; DS:DX	-> ASCIZ filespec
					; (drive, path,	and wildcards allowed)
		jb	short loc_1152F
		push	ds
		lds	bx, dword_419D4
		assume ds:nothing
		lea	si, [bx+1Eh]
		pop	es
		mov	di, offset byte_41A24
		cld
		push	di
		mov	cx, 11
		mov	al, ' '
		rep stosb
		pop	di
		mov	bx, 8

loc_1150C:				; CODE XREF: sub_11496+81j
		lodsb
		test	al, al
		jz	short loc_1152D
		cmp	al, '.'
		jz	short loc_1151F
		stosb
		dec	bx
		jnz	short loc_1150C
		lodsb
		cmp	al, '.'
		jz	short loc_1151F
		dec	si

loc_1151F:				; CODE XREF: sub_11496+7Dj
					; sub_11496+86j
		add	di, bx
		mov	bx, 3

loc_11524:				; CODE XREF: sub_11496+95j
		lodsb
		test	al, al
		jz	short loc_1152D
		stosb
		dec	bx
		jnz	short loc_11524

loc_1152D:				; CODE XREF: sub_11496+79j
					; sub_11496+91j
		sub	ax, ax

loc_1152F:				; CODE XREF: sub_11496+36j
					; sub_11496+49j ...
		pop	dx
		pop	ds
		push	ax
		mov	ah, 1Ah
		int	21h		; DOS -	SET DISK TRANSFER AREA ADDRESS
					; DS:DX	-> disk	transfer buffer
		pop	ax
		pop	es
		pop	ds
		pop	si
		pop	di
		retn
sub_11496	endp

		assume ds:seg008

; =============== S U B	R O U T	I N E =======================================


sub_1153C	proc near		; CODE XREF: sub_11466+19p
					; apiF2_04_AskForDiskChg+5Cp
		mov	si, offset byte_41A1A
		mov	di, offset byte_41A24
		mov	cx, 5
		cld
		repe cmpsw
		retn
sub_1153C	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


apiF2_04_AskForDiskChg proc near	; CODE XREF: seg000:0927p seg000:127Fp
					; DATA XREF: ...
		mov	bl, [bp+12h]
		and	bx, 1
		mov	al, [bp+0Eh]
		mov	byte_4056E[bx],	al
		mov	al, defaultDiskNum
		add	al, [bp+12h]
		add	al, 60h
		mov	byte ptr aPutDiskInDrive+0Fh, al ; write drive ID
		mov	al, [bp+0Eh]
		add	al, 60h
		mov	byte ptr aPutDiskInDrive+1Fh, al ; write disk ID
		cmp	hardDiskMode, 0
		jz	short loc_11598
		retn
; ---------------------------------------------------------------------------

loc_11572:				; CODE XREF: apiF2_04_AskForDiskChg+5Aj
					; apiF2_04_AskForDiskChg+5Fj ...
		push	es
		call	sub_115B8
		call	ShowDiskChgMsg
		mov	ah, 12h
		int	0F3h
		mov	ah, 11h
		push	ax
		cmp	al, 3
		jbe	short loc_11586
		mov	al, 3

loc_11586:				; CODE XREF: apiF2_04_AskForDiskChg+38j
		int	0F3h
		call	sub_11338
		call	sub_1134A
		call	sub_115FC
		pop	ax
		int	0F3h
		call	sub_11338
		pop	es

loc_11598:				; CODE XREF: apiF2_04_AskForDiskChg+25j
		mov	al, [bp+12h]
		add	al, defaultDiskNum
		call	sub_11496
		test	ax, ax
		jnz	short loc_11572
		call	sub_1153C
		jnz	short loc_11572
		mov	al, byte_41A2E
		and	al, 1Fh
		dec	al
		cmp	al, [bp+0Eh]
		jnz	short loc_11572
		retn
apiF2_04_AskForDiskChg endp


; =============== S U B	R O U T	I N E =======================================


sub_115B8	proc near		; CODE XREF: apiF2_04_AskForDiskChg+29p
		push	ds
		push	ds
		pop	es
		assume es:seg008
		mov	ds, word_40318
		assume ds:nothing
		cld
		mov	dx, 34h
		mov	bx, 38h
		mov	si, 65Ch
		mov	di, offset byte_41A30
		mov	cx, dx
		rep movsw
		add	si, bx
		mov	cx, dx
		rep movsw
		add	si, bx
		mov	cx, dx
		rep movsw
		mov	si, 265Ch
		mov	cx, dx

loc_115E1:				; CODE XREF: sub_115B8+2Bj
		lodsw
		stosb
		loop	loc_115E1
		add	si, bx
		mov	cx, dx

loc_115E9:				; CODE XREF: sub_115B8+33j
		lodsw
		stosb
		loop	loc_115E9
		add	si, bx
		mov	cx, dx

loc_115F1:				; CODE XREF: sub_115B8+3Bj
		lodsw
		stosb
		loop	loc_115F1
		pop	ds
		assume ds:nothing
		mov	al, 0Ah
		out	68h, al
		retn
sub_115B8	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_115FC	proc near		; CODE XREF: apiF2_04_AskForDiskChg+44p
		mov	es, word ptr ds:198h
		assume es:nothing
		cld
		mov	dx, 34h	; '4'
		mov	bx, 38h	; '8'
		mov	si, 18B0h
		mov	di, 65Ch
		mov	cx, dx
		rep movsw
		add	di, bx
		mov	cx, dx
		rep movsw
		add	di, bx
		mov	cx, dx
		rep movsw
		mov	di, 265Ch
		mov	cx, dx

loc_11622:				; CODE XREF: sub_115FC+28j
		lodsb
		stosw
		loop	loc_11622
		add	di, bx
		mov	cx, dx

loc_1162A:				; CODE XREF: sub_115FC+30j
		lodsb
		stosw
		loop	loc_1162A
		add	di, bx
		mov	cx, dx

loc_11632:				; CODE XREF: sub_115FC+38j
		lodsb
		stosw
		loop	loc_11632
		mov	al, 0Bh
		out	68h, al
		retn
sub_115FC	endp

; ---------------------------------------------------------------------------
		align 2
		assume ds:seg008

; =============== S U B	R O U T	I N E =======================================


ShowDiskChgMsg	proc near		; CODE XREF: apiF2_04_AskForDiskChg+2Cp
		mov	es, word_40318
		assume es:nothing
		cld
		mov	bx, 2000h
		mov	cl, 0A5h
		mov	di, 65Ch	; start	offset (X=28, Y=14)
		mov	si, offset aTopLine ; "ÜÆÜ¢Ü¢Ü¢Ü¢Ü¢Ü¢Ü¢Ü¢Ü¢Ü¢Ü¢Ü¢Ü¢Ü¢Ü¢Ü¢Ü¢Ü¢Ü"...
		call	DrawText
		add	di, 38h		; drew 68h
		mov	si, offset aPutDiskInDrive ; "Ü§Å@Å@ÉhÉâÉCÉuÇ`Ç…ÅAÉfÉBÉXÉNÅîÇ`Çì¸ÇÍÇ"...
		call	DrawText
		add	di, 38h
		mov	si, offset aBottomLine ; "Ü∂Ü¢Ü¢Ü¢Ü¢Ü¢Ü¢Ü¢Ü¢Ü¢Ü¢Ü¢Ü¢Ü¢Ü¢Ü¢Ü¢Ü¢Ü¢Ü"...
		call	DrawText
		retn
ShowDiskChgMsg	endp


; =============== S U B	R O U T	I N E =======================================


sub_11662	proc near		; CODE XREF: seg000:0927p seg000:127Fp
					; DATA XREF: ...
		mov	bx, [bp+2]
		mov	si, dx
		mov	di, offset byte_419D8
		call	CopyFileName
		call	MaybeCheckDisk
		mov	dx, di
		mov	ax, 3D00h
		int	21h		; DOS -	2+ - OPEN DISK FILE WITH HANDLE
					; DS:DX	-> ASCIZ filename
					; AL = access mode
					; 0 - read
		jb	short loc_1169A
		mov	bx, ax
		mov	dx, [bp+0Ch]
		mov	ds, word ptr [bp+0]
		assume ds:nothing
		mov	cx, [bp+10h]
		mov	ah, 3Fh
		int	21h		; DOS -	2+ - READ FROM FILE WITH HANDLE
					; BX = file handle, CX = number	of bytes to read
					; DS:DX	-> buffer
		pushf
		push	ax
		push	cx
		mov	ah, 3Eh
		int	21h		; DOS -	2+ - CLOSE A FILE WITH HANDLE
					; BX = file handle
		pop	cx
		pop	ax
		popf
		jnb	short loc_1169F
		cmp	ax, cx
		jz	short loc_1169F
		jmp	short loc_1169C
; ---------------------------------------------------------------------------

loc_1169A:				; CODE XREF: sub_11662+15j
		sub	ax, ax

loc_1169C:				; CODE XREF: sub_11662+36j
		call	apiF2_SetError

loc_1169F:				; CODE XREF: sub_11662+30j
					; sub_11662+34j
		mov	[bp+12h], ax
		retn
sub_11662	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_116A4	proc near		; CODE XREF: seg000:0927p seg000:127Fp
					; DATA XREF: ...
		mov	es, word ptr [bp+0]
		assume es:nothing
		mov	di, [bp+0Ch]
		mov	bx, [bp+2]
		mov	si, dx
		call	CopyFileName
		retn
sub_116A4	endp

; ---------------------------------------------------------------------------
		align 2
		assume ds:seg008

; =============== S U B	R O U T	I N E =======================================


CopyFileName	proc near		; CODE XREF: apiF2_00_ReadFile+8p
					; apiF2_01_WriteFile+8p ...
		push	di
		push	si
		push	ds
		mov	cl, defaultDiskNum
		mov	ch, hardDiskMode
		mov	ds, bx
		assume ds:nothing
		cmp	byte ptr [si+1], ':'
		jnz	short loc_116D2
		lodsw
		test	ch, ch
		jnz	short loc_116D2
		dec	al
		and	al, 1
		jmp	short loc_116D4
; ---------------------------------------------------------------------------

loc_116D2:				; CODE XREF: CopyFileName+11j
					; CopyFileName+16j
		sub	al, al

loc_116D4:				; CODE XREF: CopyFileName+1Cj
		add	al, cl
		add	al, 'A'
		mov	ah, ':'
		stosw
		jmp	short loc_116DE
; ---------------------------------------------------------------------------

loc_116DD:				; CODE XREF: CopyFileName+2Dj
		inc	si

loc_116DE:				; CODE XREF: CopyFileName+27j
		cmp	byte ptr [si], '\'
		jz	short loc_116DD

loc_116E3:				; CODE XREF: CopyFileName+33j
		lodsb
		stosb
		test	al, al
		jnz	short loc_116E3
		pop	ds
		assume ds:seg008
		pop	si
		pop	di
		retn
CopyFileName	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


apiF2_07_GetDefaultDisk	proc near	; CODE XREF: seg000:0927p seg000:127Fp
					; DATA XREF: ...
		mov	al, defaultDiskNum
		mov	ah, hardDiskMode
		mov	[bp+12h], ax
		retn
apiF2_07_GetDefaultDisk	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_116FA	proc near		; CODE XREF: seg000:0927p seg000:127Fp
					; DATA XREF: ...
		mov	bl, [bp+12h]
		and	bx, 1
		mov	al, [bp+0Eh]
		mov	byte_4056E[bx],	al
		retn
sub_116FA	endp


; =============== S U B	R O U T	I N E =======================================


MaybeCheckDisk	proc near		; CODE XREF: apiF2_00_ReadFile+Bp
					; apiF2_01_WriteFile+Bp ...
		cmp	hardDiskMode, 0
		jnz	short locret_11730
		mov	ax, [di]
		cmp	ah, ':'
		jnz	short loc_11720
		sub	al, 'A'
		sub	al, defaultDiskNum
		and	al, 1
		jmp	short loc_11722
; ---------------------------------------------------------------------------

loc_11720:				; CODE XREF: MaybeCheckDisk+Cj
		sub	al, al

loc_11722:				; CODE XREF: MaybeCheckDisk+16j
		push	bx
		mov	bl, al
		sub	bh, bh
		mov	dl, byte_4056E[bx]
		pop	bx
		mov	ah, 4
		int	0F2h

locret_11730:				; CODE XREF: MaybeCheckDisk+5j
		retn
MaybeCheckDisk	endp

; ---------------------------------------------------------------------------
		nop
		assume ss:seg009, ds:nothing

; =============== S U B	R O U T	I N E =======================================

; Attributes: noreturn

		public start
start		proc near
		mov	ax, seg	seg008
		mov	bx, 2440h
		cli
		mov	ss, ax
		assume ss:seg008
		mov	sp, bx
		sti
		add	bx, 0Fh
		shr	bx, 4
		add	bx, ax
		mov	ax, es
		sub	bx, ax
		mov	ah, 4Ah
		int	21h		; DOS -	2+ - ADJUST MEMORY BLOCK SIZE (SETBLOCK)
					; ES = segment address of block	to change
					; BX = new size	in paragraphs
		jnb	short loc_1175A
		sub	ax, ax

loc_11752:				; CODE XREF: start+53j
		call	ShowErrorMsg	; cannot allocate memory
		mov	ax, 4CFFh
		int	21h		; DOS -	2+ - QUIT WITH EXIT CODE (EXIT)
					; AL = exit code
; ---------------------------------------------------------------------------

loc_1175A:				; CODE XREF: start+1Cj
		mov	ss:word_40570, es
		push	ss
		pop	es
		assume es:seg008
		cld
		sub	ax, ax
		mov	cx, 1C40h
		mov	di, offset OldIntF1Vec
		sub	cx, di
		jz	short loc_11775
		shr	cx, 1
		rep stosw
		jnb	short loc_11775
		stosb

loc_11775:				; CODE XREF: start+3Aj	start+40j
		call	sub_1198E
		push	es
		pop	ds
		assume ds:seg008
		call	VerifyUserName
		call	sub_1179E
		jz	short loc_11787
		mov	ax, 1
		jmp	short loc_11752
; ---------------------------------------------------------------------------

loc_11787:				; CODE XREF: start+4Ej
		call	sub_117B6
		mov	bp, sp
		push	word_41DB0
		push	word_41DAE
		call	sub_10010
		add	sp, 4
		push	ax
		call	exit_with_code
start		endp


; =============== S U B	R O U T	I N E =======================================


sub_1179E	proc near		; CODE XREF: start+4Bp
					; exit_with_code+16p
		mov	si, 0
		mov	cx, 0E0h ; '‡'
		sub	cx, si
		sub	ax, ax
		sub	dx, dx

loc_117AA:				; CODE XREF: sub_1179E+11j
		lodsb
		add	dx, ax
		xor	dh, al
		loop	loc_117AA
		sub	dx, 0A177h
		retn
sub_1179E	endp


; =============== S U B	R O U T	I N E =======================================


sub_117B6	proc near		; CODE XREF: start:loc_11787p
		sub	ax, ax
		mov	word_41CF4, ax
		retn
sub_117B6	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_117BC	proc near		; CODE XREF: DoMainInit+49p

arg_0		= word ptr  4

		enter	0, 0
		mov	bx, word_41CF4
		cmp	bx, 10h
		jnb	short loc_117DA
		add	bx, bx
		mov	ax, [bp+arg_0]
		mov	word_41CF6[bx],	ax
		inc	word_41CF4
		sub	ax, ax
		jmp	short locret_117DD
; ---------------------------------------------------------------------------

loc_117DA:				; CODE XREF: sub_117BC+Bj
		mov	ax, 0FFFFh

locret_117DD:				; CODE XREF: sub_117BC+1Cj
		leave
		retn
sub_117BC	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: noreturn bp-based	frame

exit_with_code	proc near		; CODE XREF: start+69p	seg000:1A72p ...

arg_0		= byte ptr  4

		enter	0, 0
		mov	si, word_41CF4
		mov	di, offset word_41CF6
		test	si, si
		jmp	short loc_117F4
; ---------------------------------------------------------------------------

loc_117EF:				; CODE XREF: exit_with_code:loc_117F4j
		call	word ptr [di]
		inc	di
		inc	di
		dec	si

loc_117F4:				; CODE XREF: exit_with_code+Dj
		jnz	short loc_117EF
		call	sub_1179E
		jz	short loc_11805
		mov	ax, 1
		call	ShowErrorMsg	; null pointer assignment
		mov	al, 0FFh
		jmp	short loc_11808
; ---------------------------------------------------------------------------

loc_11805:				; CODE XREF: exit_with_code+19j
		mov	al, [bp+arg_0]

loc_11808:				; CODE XREF: exit_with_code+23j
		mov	ah, 4Ch
		int	21h		; DOS -	2+ - QUIT WITH EXIT CODE (EXIT)
exit_with_code	endp			; AL = exit code


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1180C	proc near		; CODE XREF: sub_10010+35p

arg_0		= word ptr  4
arg_2		= byte ptr  6

		enter	0, 0
		push	di
		push	si
		push	ds
		push	bp
		mov	di, offset byte_41D16
		lea	ax, [bp+arg_2]
		push	ax
		push	di
		call	sub_11864
		add	sp, 4
		mov	bx, offset byte_41D96
		mov	word ptr [bx], 0
		mov	[bx+2],	di
		mov	word ptr [bx+4], ds
		mov	ax, word_40570
		mov	word ptr [bx+6], 5Ch ; '\'
		mov	[bx+8],	ax
		mov	word ptr [bx+0Ah], 6Ch ; 'l'
		mov	[bx+0Ch], ax
		push	ds
		pop	es
		mov	dx, [bp+arg_0]
		cli
		in	al, 2		; DMA controller, 8237A-5.
					; channel 1 current address
		or	al, 1
		jmp	short $+2
		out	2, al		; DMA controller, 8237A-5.
					; channel 1 base address
					; (also	sets current address)
		sti
		mov	ax, 4B00h
		int	21h		; DOS -	2+ - LOAD OR EXECUTE (EXEC)
					; DS:DX	-> ASCIZ filename
					; ES:BX	-> parameter block
					; AL = subfunc:	load & execute program
		mov	ax, 0FFFFh
		jb	short loc_1185D
		sub	ax, ax

loc_1185D:				; CODE XREF: sub_1180C+4Dj
		pop	bp
		pop	ds
		assume ds:nothing
		pop	si
		pop	di
		leave
		retn
sub_1180C	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_11864	proc near		; CODE XREF: sub_1180C+10p

arg_0		= word ptr  4
arg_2		= word ptr  6

		enter	0, 0
		push	di
		push	si
		mov	bx, [bp+arg_2]
		mov	di, [bp+arg_0]
		push	ds
		pop	es
		assume es:nothing
		cld
		sub	dl, dl
		inc	di

loc_11876:				; CODE XREF: sub_11864+27j
		mov	si, [bx]
		test	si, si
		jz	short loc_11892
		inc	bx
		inc	bx
		mov	al, 20h	; ' '
		stosb
		inc	dl

loc_11883:				; CODE XREF: sub_11864+2Cj
		cmp	dl, 7Eh	; '~'
		jnb	short loc_11892
		lodsb
		test	al, al
		jz	short loc_11876
		stosb
		inc	dl
		jmp	short loc_11883
; ---------------------------------------------------------------------------

loc_11892:				; CODE XREF: sub_11864+16j
					; sub_11864+22j
		mov	byte ptr [di], 0Dh
		mov	bx, [bp+arg_0]
		mov	[bx], dl
		pop	si
		pop	di
		leave
		retn
sub_11864	endp


; =============== S U B	R O U T	I N E =======================================


GetIntVec	proc far		; CODE XREF: SetupIntVecF1+2P
					; SetupIntVecF6+2P ...
		pushf
		cli
		push	ds
		sub	bx, bx
		mov	ds, bx
		assume ds:nothing
		mov	bl, al
		shl	bx, 2
		les	dx, [bx]
		pop	ds
		assume ds:nothing
		popf
		retf
GetIntVec	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


SetIntVec	proc far		; CODE XREF: SetupIntVecF1+14P
					; RestoreIntVecF1+6P ...
		pushf
		cli
		push	ds
		sub	bx, bx
		mov	ds, bx
		assume ds:nothing
		mov	bl, al
		shl	bx, 2
		mov	[bx], dx
		mov	word ptr [bx+2], es
		pop	ds
		assume ds:nothing
		popf
		retf
SetIntVec	endp

		assume ds:seg008

; =============== S U B	R O U T	I N E =======================================


SetupIntVec06_05 proc near		; CODE XREF: DoMainInitp
		push	es
		pushf
		cli
		mov	al, 5
		call	GetIntVec
		mov	word ptr OldIntVec05, dx
		mov	word ptr OldIntVec05+2,	es
		mov	al, 6
		call	GetIntVec
		mov	word ptr OldIntVec06, dx
		mov	word ptr OldIntVec06+2,	es
		push	cs
		pop	es
		assume es:seg000
		mov	dx, offset Int05_06
		mov	al, 5
		call	SetIntVec
		mov	dx, offset Int05_06
		mov	al, 6
		call	SetIntVec
		popf
		pop	es
		assume es:nothing
		retn
SetupIntVec06_05 endp


; =============== S U B	R O U T	I N E =======================================


RestoreIntVec05_06 proc	near		; CODE XREF: seg000:014Bp
		push	es
		pushf
		cli
		les	dx, OldIntVec05
		mov	al, 5
		call	SetIntVec
		les	dx, OldIntVec06
		mov	al, 6
		call	SetIntVec
		popf
		pop	es
		retn
RestoreIntVec05_06 endp

; ---------------------------------------------------------------------------

Int05_06:				; DATA XREF: SetupIntVec06_05+23o
					; SetupIntVec06_05+2Do
		iret
; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_1191C	proc near		; CODE XREF: sub_10846p
		push	bp
		push	si
		sub	si, si
		mov	ax, 2
		mov	cl, 21h	; '!'
		shr	ax, cl
		test	ax, 1
		jnz	short loc_1193A
		mov	al, 2
		push	cs
		movaps	xmm0, xmm0
		test	al, al
		jz	short loc_11988
		pop	ax
		inc	si
		jmp	short loc_11988
; ---------------------------------------------------------------------------

loc_1193A:				; CODE XREF: sub_1191C+Ej
		add	si, 2
		push	sp
		pop	ax
		cmp	ax, sp
		jnz	short loc_11988
		inc	si
		mov	bx, 4000h
		pushf
		cli
		pushf
		pop	ax
		or	ax, bx
		push	ax
		popf
		pushf
		pop	ax
		popf
		test	ax, bx
		jz	short loc_11988
		inc	si
		mov	bp, sp
		and	sp, 0FFFCh
		pushfd
		cli
		mov	ebx, 40000h
		pushfd
		pop	eax
		or	eax, ebx
		push	eax
		popfd
		pushfd
		pop	eax
		popfd
		mov	sp, bp
		test	eax, ebx
		jz	short loc_1197E
		inc	si

loc_1197E:				; CODE XREF: sub_1191C+5Fj
		smsw	ax
		and	ax, 1
		xchg	ah, al
		or	si, ax

loc_11988:				; CODE XREF: sub_1191C+18j
					; sub_1191C+1Cj ...
		mov	ax, si
		pop	si
		pop	bp
		retn
sub_1191C	endp ; sp-analysis failed

; ---------------------------------------------------------------------------
		align 2
		assume es:seg008

; =============== S U B	R O U T	I N E =======================================


sub_1198E	proc near		; CODE XREF: start:loc_11775p
		pop	es:word_41DAC
		mov	ds, es:word_40570
		assume ds:nothing
		mov	si, 80h	; 'Ä'
		mov	bl, [si]
		inc	si
		sub	bh, bh
		add	bx, si
		mov	byte ptr [bx], 0Dh
		sub	di, di
		sub	dx, dx

loc_119A9:				; CODE XREF: sub_1198E+1Ej
					; sub_1198E+22j ...
		lodsb
		cmp	al, 20h	; ' '
		jz	short loc_119A9
		cmp	al, 9
		jz	short loc_119A9
		cmp	al, 0Dh
		jz	short loc_119D0
		test	al, al
		jz	short loc_119D0
		inc	di
		dec	si

loc_119BC:				; CODE XREF: sub_1198E+40j
		lodsb
		cmp	al, 20h	; ' '
		jz	short loc_119A9
		cmp	al, 9
		jz	short loc_119A9
		cmp	al, 0Dh
		jz	short loc_119D0
		test	al, al
		jz	short loc_119D0
		inc	dx
		jmp	short loc_119BC
; ---------------------------------------------------------------------------

loc_119D0:				; CODE XREF: sub_1198E+26j
					; sub_1198E+2Aj ...
		mov	es:word_41DAE, di
		add	dx, di
		shl	di, 1
		add	dx, di
		add	dx, 4
		and	dx, 0FFFCh
		sub	sp, dx
		mov	bx, sp
		mov	es:word_41DB0, bx
		mov	si, 81h	; 'Å'
		add	di, bx

loc_119EF:				; CODE XREF: sub_1198E+64j
					; sub_1198E+68j ...
		lodsb
		cmp	al, 20h	; ' '
		jz	short loc_119EF
		cmp	al, 9
		jz	short loc_119EF
		cmp	al, 0Dh
		jz	short loc_11A1F
		test	al, al
		jz	short loc_11A1F
		mov	es:[bx], di
		add	bx, 2

loc_11A06:				; CODE XREF: sub_1198E+8Aj
		stosb
		lodsb
		cmp	al, 20h	; ' '
		jz	short loc_11A1A
		cmp	al, 9
		jz	short loc_11A1A
		cmp	al, 0Dh
		jz	short loc_11A1F
		test	al, al
		jz	short loc_11A1F
		jmp	short loc_11A06
; ---------------------------------------------------------------------------

loc_11A1A:				; CODE XREF: sub_1198E+7Cj
					; sub_1198E+80j
		sub	al, al
		stosb
		jmp	short loc_119EF
; ---------------------------------------------------------------------------

loc_11A1F:				; CODE XREF: sub_1198E+6Cj
					; sub_1198E+70j ...
		sub	al, al
		stosb
		jmp	es:word_41DAC
sub_1198E	endp ; sp-analysis failed

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


ShowErrorMsg	proc near		; CODE XREF: start:loc_11752p
					; exit_with_code+1Ep ...
		push	ss
		pop	ds
		assume ds:seg008
		cmp	ax, 2
		jbe	short loc_11A32
		mov	ax, 2

loc_11A32:				; CODE XREF: ShowErrorMsg+5j
		add	ax, ax
		mov	bx, ax
		push	errorMsgList[bx]
		mov	dx, offset a???RuntimeErro ; "\r\n??? runtime error: $"
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		pop	dx
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		mov	dx, offset asc_40712 ; "\a\r\n$"
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		retn
ShowErrorMsg	endp

; ---------------------------------------------------------------------------
		push	si		; unused
		cld
		mov	si, offset aCondifentNote
		mov	cx, 180h
		sub	dx, dx
		sub	ah, ah

loc_11A5A:				; CODE XREF: seg000:1A61j
		lodsb
		add	dx, ax
		xor	dh, al
		rol	dx, 1
		loop	loc_11A5A
		lodsw
		sub	ax, dx
		jz	short loc_11A78
		push	0FFFFh
		call	ShowErrorMsg	; cannot run on	this machine
		add	sp, 2
		push	1
		call	exit_with_code
; ---------------------------------------------------------------------------
		add	sp, 2

loc_11A78:				; CODE XREF: seg000:1A66j
		mov	si, offset aCondifentNote
		jmp	short loc_11A85
; ---------------------------------------------------------------------------

loc_11A7D:				; CODE XREF: seg000:1A88j
		xor	al, 0FFh
		mov	dl, al
		mov	ah, 6
		int	21h		; DOS -	DIRECT CONSOLE I/O CHARACTER OUTPUT
					; DL = character <> FFh
					;  Return: ZF set = no character
					;   ZF clear = character recieved, AL =	character

loc_11A85:				; CODE XREF: seg000:1A7Bj
		lodsb
		cmp	al, 0FFh
		jnz	short loc_11A7D
		mov	ax, 0C08h
		int	21h		; DOS -	CLEAR KEYBOARD BUFFER
					; AL must be 01h, 06h, 07h, 08h, or 0Ah.
		pop	si
		retn
; ---------------------------------------------------------------------------
		nop

; =============== S U B	R O U T	I N E =======================================


VerifyUserName	proc near		; CODE XREF: start+48p
		push	si
		mov	si, offset aUserNameEnc
		mov	bx, offset aUserName ; "ìdåÇÉiÅ[ÉX"
		mov	cx, 0Ah
		cld

loc_11A9D:				; CODE XREF: VerifyUserName+15j
		lodsw
		xor	ax, 0FFFFh
		cmp	[bx], ax
		jnz	short loc_11AAB	; This verifies, that the user name wasn't changed
		inc	bx		; compared to the Confidentiality Notice text.
		inc	bx
		loop	loc_11A9D
		jmp	short loc_11ABB
; ---------------------------------------------------------------------------

loc_11AAB:				; CODE XREF: VerifyUserName+11j
		push	0FFFFh
		call	ShowErrorMsg	; cannot run on	this machine
		add	sp, 2
		push	1
		call	exit_with_code
; ---------------------------------------------------------------------------
		add	sp, 2

loc_11ABB:				; CODE XREF: VerifyUserName+17j
		pop	si
		retn
VerifyUserName	endp

seg000		ends

; ===========================================================================

; Segment type:	Pure code
seg001		segment	byte public 'CODE' use16
		assume cs:seg001
		;org 0Dh
		assume es:nothing, ss:nothing, ds:nothing, fs:nothing, gs:nothing
		align 2
aMouseInterface	db '[[[  Mouse Interface Routine  Ver.0.70  /  Copyright(C) Tuneup 19'
		db '88,92  ]]]',0
aThanksToY_onoF	db '[[[  Thanks to Y.ONO, for GRCG version  ]]]',0

; =============== S U B	R O U T	I N E =======================================


SetupIntVec33_15 proc far		; CODE XREF: DoMainInit+31P
		push	ds
		mov	ax, cs
		mov	ds, ax
		assume ds:seg001
		cmp	word_11C26, 0
		jnz	short loc_11B45
		jmp	loc_11BD3
; ---------------------------------------------------------------------------

loc_11B45:				; CODE XREF: SetupIntVec33_15+Aj
		cli
		mov	dx, 7FDFh
		mov	al, 8
		out	dx, al
		jmp	short $+2
		jmp	short $+2
		mov	al, 93h	; 'ì'
		out	dx, al
		jmp	short $+2
		jmp	short $+2
		mov	al, 8
		out	dx, al
		in	al, 0Ah		; DMA controller, 8237A-5.
					; single mask bit register
					; 0-1: select channel (00=0; 01=1; 10=2; 11=3)
					; 2: 1=set mask	for channel; 0=clear mask (enable)
		jmp	short $+2
		mov	ah, cs:byte_11EB3
		not	ah
		or	al, ah
		out	0Ah, al		; DMA controller, 8237A-5.
					; single mask bit register
					; 0-1: select channel (00=0; 01=1; 10=2; 11=3)
					; 2: 1=set mask	for channel; 0=clear mask (enable)
		jmp	short $+2
		mov	al, 8
		out	dx, al
		sti
		mov	al, 33h
		call	GetIntVec
		mov	word ptr OldInt33Vec, dx
		mov	word ptr OldInt33Vec+2,	es
		mov	al, byte_11EB2
		call	GetIntVec
		mov	word ptr OldInt15Vec, dx
		mov	word ptr OldInt15Vec+2,	es
		push	cs
		pop	es
		assume es:seg001
		mov	al, 33h
		mov	dx, offset Int33
		call	SetIntVec
		mov	al, byte_11EB2
		mov	dx, offset Int15
		call	SetIntVec
		mov	word_11C26, 0
		call	sub_11CB6
		cli
		mov	dx, 7FDFh
		mov	al, 0Fh
		out	dx, al
		jmp	short $+2
		jmp	short $+2
		mov	dx, 0BFDBh
		sub	al, al
		out	dx, al
		in	al, 0Ah		; DMA controller, 8237A-5.
					; single mask bit register
					; 0-1: select channel (00=0; 01=1; 10=2; 11=3)
					; 2: 1=set mask	for channel; 0=clear mask (enable)
		jmp	short $+2
		and	al, cs:byte_11EB3
		out	0Ah, al		; DMA controller, 8237A-5.
					; single mask bit register
					; 0-1: select channel (00=0; 01=1; 10=2; 11=3)
					; 2: 1=set mask	for channel; 0=clear mask (enable)
		jmp	short $+2
		mov	dx, 7FDFh
		mov	al, 8
		out	dx, al
		sti

loc_11BD3:				; CODE XREF: SetupIntVec33_15+Cj
		pop	ds
		assume ds:nothing
		retf
SetupIntVec33_15 endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


RestoreIntVec33_15 proc	far		; CODE XREF: seg000:0124P
		push	ds
		mov	ax, cs
		mov	ds, ax
		assume ds:seg001
		cmp	word_11C26, 0
		jnz	short loc_11C1B
		cli
		mov	dx, 7FDFh
		mov	al, 9
		out	dx, al
		jmp	short $+2
		in	al, 0Ah		; DMA controller, 8237A-5.
					; single mask bit register
					; 0-1: select channel (00=0; 01=1; 10=2; 11=3)
					; 2: 1=set mask	for channel; 0=clear mask (enable)
		jmp	short $+2
		mov	ah, cs:byte_11EB3
		not	ah
		or	al, ah
		out	0Ah, al		; DMA controller, 8237A-5.
					; single mask bit register
					; 0-1: select channel (00=0; 01=1; 10=2; 11=3)
					; 2: 1=set mask	for channel; 0=clear mask (enable)
		call	sub_11D00
		mov	al, 33h
		les	dx, OldInt33Vec
		assume es:nothing
		call	SetIntVec
		mov	al, byte_11EB2
		les	dx, OldInt15Vec
		call	SetIntVec
		mov	word_11C26, 0FFFFh
		sti

loc_11C1B:				; CODE XREF: RestoreIntVec33_15+Aj
		pop	ds
		assume ds:nothing
		retf
RestoreIntVec33_15 endp

; ---------------------------------------------------------------------------
		align 2
OldInt33Vec	dd 0			; DATA XREF: SetupIntVec33_15+40w
					; RestoreIntVec33_15+29r ...
OldInt15Vec	dd 0			; DATA XREF: SetupIntVec33_15+50w
					; RestoreIntVec33_15+35r ...
word_11C26	dw 0FFFFh		; DATA XREF: SetupIntVec33_15+5r
					; SetupIntVec33_15+6Fw	...
; ---------------------------------------------------------------------------

Int33:					; DATA XREF: SetupIntVec33_15+5Co
		cmp	cs:word_11C26, 0
		jz	short loc_11C31
		iret
; ---------------------------------------------------------------------------

loc_11C31:				; CODE XREF: seg001:017Ej
		pusha
		push	ds
		push	es
		mov	bp, sp
		cmp	ax, 13h
		jbe	short loc_11C3E
		mov	ax, 14h

loc_11C3E:				; CODE XREF: seg001:0189j
		add	ax, ax
		mov	si, offset jumpTbl_int33
		add	si, ax
		mov	ax, cs
		mov	ds, ax
		assume ds:seg001
		mov	es, ax
		assume es:seg001
		call	sub_11C58
		call	word ptr [si]
		call	sub_11C6C
		pop	es
		assume es:nothing
		pop	ds
		assume ds:seg008
		popa
		iret
; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_11C58	proc near		; CODE XREF: seg001:019Bp
		pushf
		cli
		in	al, 0Ah		; DMA controller, 8237A-5.
					; single mask bit register
					; 0-1: select channel (00=0; 01=1; 10=2; 11=3)
					; 2: 1=set mask	for channel; 0=clear mask (enable)
		mov	ah, cs:byte_11EB3
		not	ah
		or	al, ah
		jmp	short $+2
		out	0Ah, al		; DMA controller, 8237A-5.
					; single mask bit register
					; 0-1: select channel (00=0; 01=1; 10=2; 11=3)
					; 2: 1=set mask	for channel; 0=clear mask (enable)
		popf
		retn
sub_11C58	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_11C6C	proc near		; CODE XREF: seg001:01A0p
		pushf
		cli
		in	al, 0Ah		; DMA controller, 8237A-5.
					; single mask bit register
					; 0-1: select channel (00=0; 01=1; 10=2; 11=3)
					; 2: 1=set mask	for channel; 0=clear mask (enable)
		and	al, cs:byte_11EB3
		jmp	short $+2
		out	0Ah, al		; DMA controller, 8237A-5.
					; single mask bit register
					; 0-1: select channel (00=0; 01=1; 10=2; 11=3)
					; 2: 1=set mask	for channel; 0=clear mask (enable)
		popf
		retn
sub_11C6C	endp

; ---------------------------------------------------------------------------
		align 2
		assume ds:seg001
jumpTbl_int33	dw offset loc_11CAC	; 0 ; DATA XREF: seg001:0190o
		dw offset loc_11CEE	; 1
		dw offset sub_11D00	; 2
		dw offset loc_11D22	; 3
		dw offset loc_11D3E	; 4
		dw offset loc_11D68	; 5
		dw offset loc_11D70	; 6
		dw offset loc_11D78	; 7
		dw offset loc_11D80	; 8
		dw offset loc_11D88	; 9
		dw offset loc_11DC6	; 0Ah
		dw offset loc_11CA6	; 0Bh
		dw offset loc_11E04	; 0Ch
		dw offset loc_11E1E	; 0Dh
		dw offset loc_11E32	; 0Eh
		dw offset locret_11E3A	; 0Fh
		dw offset loc_11E3C	; 10h
		dw offset loc_11E70	; 11h
		dw offset loc_11CA6	; 12h
		dw offset loc_11CA6	; 13h
		dw offset loc_11CA6	; 14h
; ---------------------------------------------------------------------------

loc_11CA6:				; DATA XREF: seg001:jumpTbl_int33o
		mov	word ptr [bp+12h], 0
		retn
; ---------------------------------------------------------------------------

loc_11CAC:				; DATA XREF: seg001:jumpTbl_int33o
		call	sub_11CB6
		mov	word ptr [bp+12h], 0FFFFh
		retn
; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_11CB6	proc near		; CODE XREF: SetupIntVec33_15+75p
					; seg001:loc_11CACp
		call	sub_11D00
		call	sub_127DC
		sub	ax, ax
		mov	cx, 639
		mov	dx, 399
		mov	word_11EB6, ax
		mov	word_11EB8, ax
		mov	word_11EBA, cx
		mov	word_11EBC, dx
		mov	word_11EC6, cx
		mov	word_11EC8, dx
		mov	word_11ECE, cx
		mov	word_11ED0, dx
		mov	word_11ECA, cx
		mov	word_11ECC, dx
		mov	word ptr byte_11EE0, ax
		retn
sub_11CB6	endp

; ---------------------------------------------------------------------------

loc_11CEE:				; DATA XREF: seg001:jumpTbl_int33o
		cmp	word_11EDA, 0
		jnz	short locret_11CFE
		call	sub_12728
		mov	word_11EDA, 0FFFFh

locret_11CFE:				; CODE XREF: seg001:0243j
		retn
; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_11D00	proc near		; CODE XREF: RestoreIntVec33_15+24p
					; sub_11CB6p
					; DATA XREF: ...
		call	sub_11D0A
		mov	word_11EDA, 0
		retn
sub_11D00	endp


; =============== S U B	R O U T	I N E =======================================


sub_11D0A	proc near		; CODE XREF: sub_11D00p
					; seg001:loc_11D3Ep ...
		cmp	word_11EDA, 0
		jz	short locret_11D14
		call	sub_12712

locret_11D14:				; CODE XREF: sub_11D0A+5j
		retn
sub_11D0A	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_11D16	proc near		; CODE XREF: seg001:02B3p
					; seg001:loc_11DC1p ...
		cmp	word_11EDA, 0
		jz	short locret_11D20
		call	sub_12728

locret_11D20:				; CODE XREF: sub_11D16+5j
		retn
sub_11D16	endp

; ---------------------------------------------------------------------------
		align 2

loc_11D22:				; DATA XREF: seg001:jumpTbl_int33o
		mov	al, byte ptr word_11EB4
		cbw
		mov	[bp+12h], ax
		mov	al, byte ptr word_11EB4+1
		cbw
		mov	[bp+0Ch], ax
		mov	ax, word_11EC6
		mov	[bp+10h], ax
		mov	ax, word_11EC8
		mov	[bp+0Eh], ax
		retn
; ---------------------------------------------------------------------------
		align 2

loc_11D3E:				; DATA XREF: seg001:jumpTbl_int33o
		call	sub_11D0A
		mov	ax, [bp+10h]
		mov	bx, word_11EB6
		mov	dx, word_11EBA
		call	sub_11EA4
		mov	word_11EC6, ax
		mov	ax, [bp+0Eh]
		mov	bx, word_11EB8
		mov	dx, word_11EBC
		call	sub_11EA4
		mov	word_11EC8, ax
		call	sub_11D16
		retn
; ---------------------------------------------------------------------------
		align 2

loc_11D68:				; DATA XREF: seg001:jumpTbl_int33o
		mov	al, byte ptr word_11EB4
		cbw
		mov	[bp+12h], ax
		retn
; ---------------------------------------------------------------------------

loc_11D70:				; DATA XREF: seg001:jumpTbl_int33o
		mov	al, byte ptr word_11EB4+1
		cbw
		mov	[bp+12h], ax
		retn
; ---------------------------------------------------------------------------

loc_11D78:				; DATA XREF: seg001:jumpTbl_int33o
		mov	ax, word_11EB4
		mov	[bp+12h], ax
		retn
; ---------------------------------------------------------------------------
		align 2

loc_11D80:				; DATA XREF: seg001:jumpTbl_int33o
		mov	ax, word_11EDA
		mov	[bp+12h], ax
		retn
; ---------------------------------------------------------------------------
		align 2

loc_11D88:				; DATA XREF: seg001:jumpTbl_int33o
		call	sub_11D0A
		mov	si, [bp+0Eh]
		cmp	si, 0FFFFh
		jz	short loc_11DBE
		push	ds
		mov	ds, word ptr [bp+0]
		assume ds:nothing
		call	sub_127F4
		pop	ds
		assume ds:seg001
		mov	ax, [bp+0Ch]
		mov	bx, word_11EBE
		shl	bx, 3
		cmp	ax, bx
		jb	short loc_11DAB
		xor	ax, ax

loc_11DAB:				; CODE XREF: seg001:02F7j
		mov	word_11EC2, ax
		mov	ax, [bp+10h]
		cmp	ax, word_11EC0
		jb	short loc_11DB9
		xor	ax, ax

loc_11DB9:				; CODE XREF: seg001:0305j
		mov	word_11EC4, ax
		jmp	short loc_11DC1
; ---------------------------------------------------------------------------

loc_11DBE:				; CODE XREF: seg001:02E1j
		call	sub_127DC

loc_11DC1:				; CODE XREF: seg001:030Cj
		call	sub_11D16
		retn
; ---------------------------------------------------------------------------
		align 2

loc_11DC6:				; DATA XREF: seg001:jumpTbl_int33o
		mov	cx, [bp+10h]
		call	sub_11DD0
		mov	[bp+12h], ax
		retn

; =============== S U B	R O U T	I N E =======================================


sub_11DD0	proc near		; CODE XREF: seg001:0319p
					; seg001:loc_11E2Ep
		pushf
		cli
		in	al, 0Ah		; DMA controller, 8237A-5.
					; single mask bit register
					; 0-1: select channel (00=0; 01=1; 10=2; 11=3)
					; 2: 1=set mask	for channel; 0=clear mask (enable)
		and	al, cs:byte_11EB3
		jmp	short $+2
		jmp	short $+2
		out	0Ah, al		; DMA controller, 8237A-5.
					; single mask bit register
					; 0-1: select channel (00=0; 01=1; 10=2; 11=3)
					; 2: 1=set mask	for channel; 0=clear mask (enable)
		sti
		mov	bx, 42Eh
		jcxz	short loc_11DED

loc_11DE5:				; CODE XREF: sub_11DD0+1Bj
		mov	ax, [bx]

loc_11DE7:				; CODE XREF: sub_11DD0+19j
		cmp	[bx], ax
		jz	short loc_11DE7
		loop	loc_11DE5

loc_11DED:				; CODE XREF: sub_11DD0+13j
		cli
		in	al, 0Ah		; DMA controller, 8237A-5.
					; single mask bit register
					; 0-1: select channel (00=0; 01=1; 10=2; 11=3)
					; 2: 1=set mask	for channel; 0=clear mask (enable)
		mov	ah, cs:byte_11EB3
		not	ah
		or	al, ah
		jmp	short $+2
		jmp	short $+2
		out	0Ah, al		; DMA controller, 8237A-5.
					; single mask bit register
					; 0-1: select channel (00=0; 01=1; 10=2; 11=3)
					; 2: 1=set mask	for channel; 0=clear mask (enable)
		popf
		mov	ax, [bx]
		retn
sub_11DD0	endp

; ---------------------------------------------------------------------------
		align 2

loc_11E04:				; DATA XREF: seg001:jumpTbl_int33o
		mov	word ptr byte_11EE0, 0
		mov	ax, [bp+0Eh]
		mov	word ptr byte_11EE0+2, ax
		mov	ax, [bp+0]
		mov	word ptr byte_11EE0+4, ax
		mov	ax, [bp+10h]
		mov	word ptr byte_11EE0, ax
		retn
; ---------------------------------------------------------------------------
		align 2

loc_11E1E:				; DATA XREF: seg001:jumpTbl_int33o
		mov	ax, [bp+10h]
		mov	word_11ED8, ax
		mov	cx, 2
		test	ax, ax
		jz	short loc_11E2E
		mov	cx, 4

loc_11E2E:				; CODE XREF: seg001:0379j
		call	sub_11DD0
		retn
; ---------------------------------------------------------------------------

loc_11E32:				; DATA XREF: seg001:jumpTbl_int33o
		mov	ax, word_11ED8
		mov	[bp+12h], ax
		retn
; ---------------------------------------------------------------------------
		align 2

locret_11E3A:				; DATA XREF: seg001:jumpTbl_int33o
		retn
; ---------------------------------------------------------------------------
		align 2

loc_11E3C:				; DATA XREF: seg001:jumpTbl_int33o
		call	sub_11D0A
		mov	ax, [bp+10h]
		sub	bx, bx
		mov	dx, 27Fh
		call	sub_11EA4
		mov	cx, ax
		mov	ax, [bp+0Eh]
		call	sub_11EA4
		cmp	cx, ax
		jbe	short loc_11E57
		xchg	ax, cx

loc_11E57:				; CODE XREF: seg001:03A4j
		mov	word_11EB6, cx
		mov	word_11EBA, ax
		mov	bx, cx
		mov	dx, ax
		mov	ax, word_11EC6
		call	sub_11EA4
		mov	word_11EC6, ax
		call	sub_11D16
		retn
; ---------------------------------------------------------------------------
		align 2

loc_11E70:				; DATA XREF: seg001:jumpTbl_int33o
		call	sub_11D0A
		mov	ax, [bp+10h]
		sub	bx, bx
		mov	dx, 18Fh
		call	sub_11EA4
		mov	cx, ax
		mov	ax, [bp+0Eh]
		call	sub_11EA4
		cmp	cx, ax
		jbe	short loc_11E8B
		xchg	ax, cx

loc_11E8B:				; CODE XREF: seg001:03D8j
		mov	word_11EB8, cx
		mov	word_11EBC, ax
		mov	bx, cx
		mov	dx, ax
		mov	ax, word_11EC8
		call	sub_11EA4
		mov	word_11EC8, ax
		call	sub_11D16
		retn
; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_11EA4	proc near		; CODE XREF: seg001:029Cp seg001:02ADp ...
		cmp	ax, bx
		jnb	short loc_11EAA
		mov	ax, bx

loc_11EAA:				; CODE XREF: sub_11EA4+2j
		cmp	ax, dx
		jbe	short locret_11EB0
		mov	ax, dx

locret_11EB0:				; CODE XREF: sub_11EA4+8j
		retn
sub_11EA4	endp

; ---------------------------------------------------------------------------
		align 2
byte_11EB2	db 15h			; DATA XREF: SetupIntVec33_15+48r
					; SetupIntVec33_15+64r	...
byte_11EB3	db 0DFh			; DATA XREF: SetupIntVec33_15+28r
					; SetupIntVec33_15+8Dr	...
word_11EB4	dw 0			; DATA XREF: seg001:loc_11D22r
					; seg001:loc_11D68r ...
word_11EB6	dw 0			; DATA XREF: sub_11CB6+Ew seg001:0294r ...
word_11EB8	dw 0			; DATA XREF: sub_11CB6+11w
					; seg001:02A5r	...
word_11EBA	dw 0			; DATA XREF: sub_11CB6+14w
					; seg001:0298r	...
word_11EBC	dw 0			; DATA XREF: sub_11CB6+18w
					; seg001:02A9r	...
word_11EBE	dw 0			; DATA XREF: seg001:02EEr
					; sub_12770+15r ...
word_11EC0	dw 0			; DATA XREF: seg001:0301r
					; sub_12770+47r ...
word_11EC2	dw 0			; DATA XREF: seg001:loc_11DABw
					; sub_12728+28r ...
word_11EC4	dw 0			; DATA XREF: seg001:loc_11DB9w
					; sub_12770+36r ...
word_11EC6	dw 0			; DATA XREF: sub_11CB6+1Cw
					; seg001:0280r	...
word_11EC8	dw 0			; DATA XREF: sub_11CB6+20w
					; seg001:0286r	...
word_11ECA	dw 0			; DATA XREF: sub_11CB6+2Cw
					; sub_12686+1Ar ...
word_11ECC	dw 0			; DATA XREF: sub_11CB6+30w
					; sub_12686+20r ...
word_11ECE	dw 0			; DATA XREF: sub_11CB6+24w
					; seg001:0AA3r	...
word_11ED0	dw 0			; DATA XREF: sub_11CB6+28w
					; seg001:0AACr	...
word_11ED2	dw 0			; DATA XREF: sub_12712+9r
					; sub_12728+11r ...
word_11ED4	dw 0			; DATA XREF: sub_12712+Cr
					; sub_12728+14r ...
word_11ED6	dw 0			; DATA XREF: sub_12712+5r sub_12728+6w ...
word_11ED8	dw 0			; DATA XREF: seg001:0371w
					; seg001:loc_11E32r ...
word_11EDA	dw 0			; DATA XREF: seg001:loc_11CEEr
					; seg001:0248w	...
		db    0
		db    0
word_11EDE	dw 0			; DATA XREF: seg001:0A83w
byte_11EE0	db 5A8h	dup(0)		; DATA XREF: sub_11CB6+34w
					; seg001:loc_11E04w ...
byte_12488	db 2, 20h		; DATA XREF: sub_127DC+Eo
		db 3Fh,	0FFh
		db 1Fh,	0FFh
		db 0Fh,	0FFh
		db 7, 0FFh
		db 3, 0FFh
		db 1, 0FFh
		db 0, 0FFh
		db 0, 7Fh
		db 0, 3Fh
		db 0, 1Fh
		db 0, 0Fh
		db 0, 7
		db 0, 3
		db 0, 1
		db 0, 1
		db 0, 3Fh
		db 0, 3Fh
		db 0, 1Fh
		db 0Ch,	1Fh
		db 1Ch,	0Fh
		db 3Eh,	0Fh
		db 0FEh, 7
		db 0FFh, 7
		db 0FFh, 3
		db 0FFh, 83h
		db 0FFh, 81h
		db 0FFh, 0C1h
		db 0FFh, 0C0h
		db 0FFh, 0E0h
		db 0FFh, 0E1h
		db 0FFh, 0F3h
		db 0FFh, 0FFh
		db 0, 0
		db 40h,	0
		db 60h,	0
		db 70h,	0
		db 78h,	0
		db 7Ch,	0
		db 7Eh,	0
		db 7Fh,	0
		db 7Fh,	80h
		db 7Fh,	0C0h
		db 7Fh,	0E0h
		db 7Fh,	0F0h
		db 7Fh,	0F8h
		db 7Fh,	0FCh
		db 7Fh,	0
		db 7Fh,	80h
		db 7Bh,	80h
		db 73h,	0C0h
		db 61h,	0C0h
		db 41h,	0E0h
		db 0, 0E0h
		db 0, 0F0h
		db 0, 70h
		db 0, 78h
		db 0, 38h
		db 0, 3Ch
		db 0, 1Ch
		db 0, 1Eh
		db 0, 0Eh
		db 0, 0Ch
		db 0, 0
		db 0, 0
; ---------------------------------------------------------------------------

Int15:					; DATA XREF: SetupIntVec33_15+67o
		push	ax
		push	dx
		mov	dx, 7FDFh
		mov	al, 9
		out	dx, al
		pop	dx
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
		jmp	short $+2
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
		jmp	short $+2
		in	al, 8		; DMA 8237A-5. status register bits:
					; 0-3: channel 0-3 has reached terminal	count
					; 4-7: channel 0-3 has a request pending
		test	al, al
		jnz	short loc_12529
		mov	al, 20h	; ' '
		out	0, al

loc_12529:				; CODE XREF: seg001:0A73j
		pop	ax
		pusha
		push	ds
		push	es
		mov	ax, cs
		mov	ds, ax
		mov	es, ax
		assume es:seg001
		inc	word_11EDE
		mov	di, 7FDDh
		mov	si, 7FD9h
		call	sub_12576
		call	sub_125DA
		call	sub_1263E
		call	sub_12686
		cmp	word_11EDA, 0
		jz	short loc_12568
		mov	ax, word_11EC6
		cmp	ax, word_11ECE
		jnz	short loc_12562
		mov	ax, word_11EC8
		cmp	ax, word_11ED0
		jz	short loc_12568

loc_12562:				; CODE XREF: seg001:0AA7j
		call	sub_12712
		call	sub_12728

loc_12568:				; CODE XREF: seg001:0A9Ej seg001:0AB0j
		pop	es
		assume es:nothing
		pop	ds
		assume ds:nothing
		popa
		push	ax
		push	dx
		mov	dx, 7FDFh
		mov	al, 8
		out	dx, al
		pop	dx
		pop	ax
		iret
		assume es:seg001, ds:seg001

; =============== S U B	R O U T	I N E =======================================


sub_12576	proc near		; CODE XREF: seg001:0A8Dp
		mov	al, 90h	; 'ê'
		call	sub_126FA
		test	ax, ax
		jnz	short loc_125BC
		cmp	word_11ED8, 0
		jz	short locret_125D8
		push	es
		mov	es, ax
		assume es:nothing
		mov	bx, (offset byte_11EE0+0FAh)
		test	byte ptr es:[bx+7], 10h
		jnz	short loc_125AB
		test	byte ptr es:[bx+9], 1
		jnz	short loc_125AB
		test	byte ptr es:[bx+7], 8
		jnz	short loc_125A8
		test	byte ptr es:[bx+8], 40h
		jz	short loc_125B7

loc_125A8:				; CODE XREF: sub_12576+29j
		dec	ax
		jmp	short loc_125AC
; ---------------------------------------------------------------------------

loc_125AB:				; CODE XREF: sub_12576+1Bj
					; sub_12576+22j
		inc	ax

loc_125AC:				; CODE XREF: sub_12576+33j
		test	byte ptr es:[bx+10h], 1
		jz	short loc_125B7
		add	ax, ax
		add	ax, ax

loc_125B7:				; CODE XREF: sub_12576+30j
					; sub_12576+3Bj
		pop	es
		test	ax, ax
		jz	short locret_125D8

loc_125BC:				; CODE XREF: sub_12576+7j
		add	ax, word_11EC6
		cmp	ax, word_11EB6
		jge	short loc_125C9
		mov	ax, word_11EB6

loc_125C9:				; CODE XREF: sub_12576+4Ej
		mov	word_11EC6, ax
		cmp	ax, word_11EBA
		jle	short loc_125D5
		mov	ax, word_11EBA

loc_125D5:				; CODE XREF: sub_12576+5Aj
		mov	word_11EC6, ax

locret_125D8:				; CODE XREF: sub_12576+Ej
					; sub_12576+44j
		retn
sub_12576	endp

; ---------------------------------------------------------------------------
		nop

; =============== S U B	R O U T	I N E =======================================


sub_125DA	proc near		; CODE XREF: seg001:0A90p
		mov	al, 0D0h ; '–'
		call	sub_126FA
		test	ax, ax
		jnz	short loc_12620
		cmp	word_11ED8, 0
		jz	short locret_1263C
		push	es
		mov	es, ax
		mov	bx, (offset byte_11EE0+0FAh)
		test	byte ptr es:[bx+7], 20h
		jnz	short loc_1260F
		test	byte ptr es:[bx+9], 8
		jnz	short loc_1260F
		test	byte ptr es:[bx+7], 4
		jnz	short loc_1260C
		test	byte ptr es:[bx+8], 8
		jz	short loc_1261B

loc_1260C:				; CODE XREF: sub_125DA+29j
		dec	ax
		jmp	short loc_12610
; ---------------------------------------------------------------------------

loc_1260F:				; CODE XREF: sub_125DA+1Bj
					; sub_125DA+22j
		inc	ax

loc_12610:				; CODE XREF: sub_125DA+33j
		test	byte ptr es:[bx+10h], 1
		jz	short loc_1261B
		add	ax, ax
		add	ax, ax

loc_1261B:				; CODE XREF: sub_125DA+30j
					; sub_125DA+3Bj
		pop	es
		test	ax, ax
		jz	short locret_1263C

loc_12620:				; CODE XREF: sub_125DA+7j
		add	ax, word_11EC8
		cmp	ax, word_11EB8
		jge	short loc_1262D
		mov	ax, word_11EB8

loc_1262D:				; CODE XREF: sub_125DA+4Ej
		mov	word_11EC8, ax
		cmp	ax, word_11EBC
		jle	short loc_12639
		mov	ax, word_11EBC

loc_12639:				; CODE XREF: sub_125DA+5Aj
		mov	word_11EC8, ax

locret_1263C:				; CODE XREF: sub_125DA+Ej
					; sub_125DA+44j
		retn
sub_125DA	endp

; ---------------------------------------------------------------------------
		nop

; =============== S U B	R O U T	I N E =======================================


sub_1263E	proc near		; CODE XREF: seg001:0A93p
		mov	al, 10h
		call	sub_126F0
		shr	al, 5
		mov	ah, al
		shr	al, 2
		and	ax, 101h
		xor	ax, 101h
		cmp	word_11ED8, 0
		jz	short loc_12681
		push	es
		sub	bx, bx
		mov	es, bx
		assume es:nothing
		mov	bx, (offset byte_11EE0+0FAh)
		test	byte ptr es:[bx+3], 10h
		jnz	short loc_1266E
		test	byte ptr es:[bx+6], 10h
		jz	short loc_12670

loc_1266E:				; CODE XREF: sub_1263E+27j
		or	al, 1

loc_12670:				; CODE XREF: sub_1263E+2Ej
		test	byte ptr es:[bx], 1
		jnz	short loc_1267D
		test	byte ptr es:[bx+1], 80h
		jz	short loc_12680

loc_1267D:				; CODE XREF: sub_1263E+36j
		or	ah, 1

loc_12680:				; CODE XREF: sub_1263E+3Dj
		pop	es
		assume es:seg001

loc_12681:				; CODE XREF: sub_1263E+18j
		mov	word_11EB4, ax
		retn
sub_1263E	endp

; ---------------------------------------------------------------------------
		nop

; =============== S U B	R O U T	I N E =======================================


sub_12686	proc near		; CODE XREF: seg001:0A96p
		mov	si, word ptr byte_11EE0
		test	si, si
		jz	short loc_126E2
		xor	ax, ax
		mov	bx, word_11EB4
		mov	cx, word_11EC6
		mov	dx, word_11EC8
		shr	si, 1
		jnb	short loc_126AE
		cmp	cx, word_11ECA
		jnz	short loc_126AC
		cmp	dx, word_11ECC
		jz	short loc_126AE

loc_126AC:				; CODE XREF: sub_12686+1Ej
		or	al, 1

loc_126AE:				; CODE XREF: sub_12686+18j
					; sub_12686+24j
		shr	si, 1
		jnb	short loc_126B8
		test	bl, bl
		jz	short loc_126B8
		or	al, 2

loc_126B8:				; CODE XREF: sub_12686+2Aj
					; sub_12686+2Ej
		shr	si, 1
		jnb	short loc_126C2
		test	bl, bl
		jnz	short loc_126C2
		or	al, 4

loc_126C2:				; CODE XREF: sub_12686+34j
					; sub_12686+38j
		shr	si, 1
		jnb	short loc_126CC
		test	bh, bh
		jz	short loc_126CC
		or	al, 8

loc_126CC:				; CODE XREF: sub_12686+3Ej
					; sub_12686+42j
		shr	si, 1
		jnb	short loc_126D6
		test	bh, bh
		jnz	short loc_126D6
		or	al, 10h

loc_126D6:				; CODE XREF: sub_12686+48j
					; sub_12686+4Cj
		test	ax, ax
		jz	short loc_126E2
		push	ds
		push	es
		call	dword ptr byte_11EE0+2
		pop	es
		pop	ds

loc_126E2:				; CODE XREF: sub_12686+6j
					; sub_12686+52j
		mov	ax, word_11EC6
		mov	word_11ECA, ax
		mov	ax, word_11EC8
		mov	word_11ECC, ax
		retn
sub_12686	endp

; ---------------------------------------------------------------------------
		nop

; =============== S U B	R O U T	I N E =======================================


sub_126F0	proc near		; CODE XREF: sub_1263E+2p sub_126FA+2p ...
		mov	dx, di
		out	dx, al
		jmp	short $+2
		mov	dx, si
		in	al, dx
		retn
sub_126F0	endp

; ---------------------------------------------------------------------------
		nop

; =============== S U B	R O U T	I N E =======================================


sub_126FA	proc near		; CODE XREF: sub_12576+2p sub_125DA+2p
		mov	ah, al
		call	sub_126F0
		and	al, 0Fh
		xchg	al, ah
		or	al, 20h
		call	sub_126F0
		and	al, 0Fh
		shl	al, 4
		or	al, ah
		cbw
		retn
sub_126FA	endp

; ---------------------------------------------------------------------------
		nop

; =============== S U B	R O U T	I N E =======================================


sub_12712	proc near		; CODE XREF: sub_11D0A+7p
					; seg001:loc_12562p
		push	di
		push	si
		mov	si, (offset byte_11EE0+6)
		mov	di, word_11ED6
		mov	ax, word_11ED2
		mov	dx, word_11ED4
		call	sub_1287E
		pop	si
		pop	di
		retn
sub_12712	endp


; =============== S U B	R O U T	I N E =======================================


sub_12728	proc near		; CODE XREF: seg001:0245p sub_11D16+7p ...
		push	di
		push	si
		push	bp
		call	sub_12770
		mov	word_11ED6, si
		mov	di, ds
		mov	es, di
		mov	di, (offset byte_11EE0+6)
		mov	ax, word_11ED2
		mov	dx, word_11ED4
		call	sub_12850
		mov	si, (offset byte_11EE0+3C6h)
		add	si, bp
		mov	di, word_11ED6
		mov	cl, byte ptr word_11EC6
		sub	cl, byte ptr word_11EC2
		mov	dl, byte ptr word_11ED2
		mov	dh, byte ptr word_11ED4
		call	sub_128AC
		mov	ax, word_11EC6
		mov	word_11ECE, ax
		mov	ax, word_11EC8
		mov	word_11ED0, ax
		pop	bp
		pop	si
		pop	di
		retn
sub_12728	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_12770	proc near		; CODE XREF: sub_12728+3p
		xor	bp, bp
		mov	bx, word_11EC6
		sub	bx, word_11EC2
		sar	bx, 3
		jns	short loc_1278D
		neg	bx
		xor	si, si
		add	bp, bx
		mov	cx, word_11EBE
		sub	cx, bx
		jmp	short loc_1279E
; ---------------------------------------------------------------------------

loc_1278D:				; CODE XREF: sub_12770+Dj
		mov	si, bx
		mov	cx, 50h	; 'P'
		sub	cx, bx
		cmp	cx, word_11EBE
		jbe	short loc_1279E
		mov	cx, word_11EBE

loc_1279E:				; CODE XREF: sub_12770+1Bj
					; sub_12770+28j
		mov	word_11ED2, cx
		mov	bx, word_11EC8
		sub	bx, word_11EC4
		jns	short loc_127BF
		neg	bx
		xor	dx, dx
		mov	ax, word_11EBE
		mul	bl
		add	bp, ax
		mov	cx, word_11EC0
		sub	cx, bx
		jmp	short loc_127D0
; ---------------------------------------------------------------------------

loc_127BF:				; CODE XREF: sub_12770+3Aj
		mov	dx, bx
		mov	cx, 400
		sub	cx, bx
		cmp	cx, word_11EC0
		jbe	short loc_127D0
		mov	cx, word_11EC0

loc_127D0:				; CODE XREF: sub_12770+4Dj
					; sub_12770+5Aj
		mov	word_11ED4, cx
		mov	ax, 50h
		mul	dx
		add	si, ax
		retn
sub_12770	endp


; =============== S U B	R O U T	I N E =======================================


sub_127DC	proc near		; CODE XREF: sub_11CB6+3p
					; seg001:loc_11DBEp
		push	ds
		push	es
		mov	ax, cs
		mov	ds, ax
		xor	ax, ax
		mov	word_11EC2, ax
		mov	word_11EC4, ax
		mov	si, offset byte_12488
		call	sub_127F4
		pop	es
		assume es:nothing
		pop	ds
		assume ds:nothing
		retn
sub_127DC	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_127F4	proc near		; CODE XREF: seg001:02E7p
					; sub_127DC+11p
		push	es
		cld
		lodsw
		dec	al
		dec	ah
		cmp	al, 5
		jb	short loc_12801
		mov	al, 4

loc_12801:				; CODE XREF: sub_127F4+9j
		cmp	ah, 28h	; '('
		jb	short loc_12808
		mov	ah, 27h	; '''

loc_12808:				; CODE XREF: sub_127F4+10j
		add	ax, 102h
		xor	bh, bh
		mov	bl, al
		mov	cs:word_11EBE, bx
		mov	bl, ah
		mov	cs:word_11EC0, bx
		mov	di, cs
		mov	es, di
		assume es:seg001
		mov	di, (offset byte_11EE0+3C6h)
		mov	bx, cs:word_11EBE
		dec	bx
		xor	al, al
		stosb
		mov	dx, cs:word_11EC0

loc_12830:				; CODE XREF: sub_127F4+48j
		mov	cx, bx

loc_12832:				; CODE XREF: sub_127F4+42j
		lodsb
		not	al
		stosb
		loop	loc_12832
		mov	al, cl
		stosb
		dec	dx
		jnz	short loc_12830
		xor	al, al
		mov	dx, cs:word_11EC0

loc_12845:				; CODE XREF: sub_127F4+57j
		mov	cx, bx
		rep movsb
		stosb
		dec	dx
		jnz	short loc_12845
		pop	es
		assume es:nothing
		retn
sub_127F4	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_12850	proc near		; CODE XREF: sub_12728+18p
		push	bp
		push	ds
		cld
		mov	bx, 50h	; 'P'
		sub	bx, ax
		mov	bp, 0A800h

loc_1285B:				; CODE XREF: sub_12850+22j
					; sub_12850+28j
		push	dx
		push	si
		mov	ds, bp
		assume ds:nothing

loc_1285F:				; CODE XREF: sub_12850+16j
		mov	cx, ax
		rep movsb
		add	si, bx
		dec	dx
		jnz	short loc_1285F
		pop	si
		pop	dx
		add	bp, 800h
		cmp	bp, 0C000h
		jb	short loc_1285B
		add	bp, 2000h
		jnb	short loc_1285B
		pop	ds
		assume ds:nothing
		pop	bp
		retn
sub_12850	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_1287E	proc near		; CODE XREF: sub_12712+10p
		push	bp
		push	es
		cld
		mov	bx, 50h	; 'P'
		sub	bx, ax
		mov	bp, 0A800h

loc_12889:				; CODE XREF: sub_1287E+22j
					; sub_1287E+28j
		push	dx
		push	di
		mov	es, bp
		assume es:nothing

loc_1288D:				; CODE XREF: sub_1287E+16j
		mov	cx, ax
		rep movsb
		add	di, bx
		dec	dx
		jnz	short loc_1288D
		pop	di
		pop	dx
		add	bp, 800h
		cmp	bp, 0C000h
		jb	short loc_12889
		add	bp, 2000h
		jnb	short loc_12889
		pop	es
		assume es:nothing
		pop	bp
		retn
sub_1287E	endp

; ---------------------------------------------------------------------------
		align 2
		assume ds:seg001

; =============== S U B	R O U T	I N E =======================================


sub_128AC	proc near		; CODE XREF: sub_12728+34p
		push	bp
		push	es
		cld
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		and	cl, 7
		mov	al, byte ptr word_11EBE
		mul	byte ptr word_11EC0
		mov	bp, ax
		mov	al, 0C0h ; '¿'
		out	7Ch, al

loc_128C4:				; CODE XREF: sub_128AC+4Fj
		mov	bl, ds:[bp+si]
		lodsb
		mov	bh, al
		mov	ch, dl

loc_128CC:				; CODE XREF: sub_128AC+3Bj
		mov	ah, bl
		mov	al, ds:[bp+si]
		mov	bl, al
		shr	ax, cl
		out	7Eh, al
		out	7Eh, al
		out	7Eh, al
		out	7Eh, al
		mov	ah, bh
		lodsb
		mov	bh, al
		shr	ax, cl
		stosb
		dec	ch
		jnz	short loc_128CC
		xor	ah, ah
		mov	al, dl
		sub	si, ax
		add	si, word_11EBE
		dec	si
		sub	di, ax
		add	di, 50h	; 'P'
		dec	dh
		jnz	short loc_128C4
		mov	al, dh
		out	7Ch, al
		pop	es
		assume es:nothing
		pop	bp
		retn
sub_128AC	endp

seg001		ends

; ===========================================================================

; Segment type:	Pure code
seg002		segment	byte public 'CODE' use16
		assume cs:seg002
		;org 4
		assume es:nothing, ss:nothing, ds:seg008, fs:nothing, gs:nothing

; =============== S U B	R O U T	I N E =======================================


SetupIntVecF3	proc far		; CODE XREF: DoMainInit+36P
		mov	al, 0F3h
		call	GetIntVec
		mov	word ptr dword_41876, dx
		mov	word ptr dword_41876+2,	es
		push	cs
		pop	es
		assume es:seg002
		mov	dx, offset IntF3
		call	SetIntVec
		retf
SetupIntVecF3	endp


; =============== S U B	R O U T	I N E =======================================


RestoreIntVecF3	proc far		; CODE XREF: seg000:011FP
		mov	al, 0F3h
		les	dx, dword_41876
		assume es:nothing
		call	SetIntVec
		retf
RestoreIntVecF3	endp

; ---------------------------------------------------------------------------

IntF3:					; DATA XREF: SetupIntVecF3+11o
		pusha
		push	ds
		push	es
		mov	bp, sp
		test	byte ptr [bp+19h], 2
		jz	short loc_12936
		sti

loc_12936:				; CODE XREF: seg002:0033j
		cld
		and	byte ptr [bp+18h], 0FEh
		mov	bx, seg	seg004
		mov	ds, bx
		assume ds:seg004
		mov	es, bx
		assume es:seg004

loc_12942:				; DATA XREF: sub_12C8A+3w sub_12CD6r
		cmp	ah, 0FFh
		jnz	short loc_12951
		mov	word ptr [bp+0Ch], offset byte_12D5C
		mov	word ptr [bp+0], cs
		jmp	short loc_12963
; ---------------------------------------------------------------------------

loc_12951:				; CODE XREF: seg002:0045j
		cmp	ah, 16h
		jbe	short loc_12958
		mov	ah, 17h

loc_12958:				; CODE XREF: seg002:0054j
		mov	bl, ah
		sub	bh, bh
		add	bx, bx
		call	cs:jumpTbl_intF3[bx]

loc_12963:				; CODE XREF: seg002:004Fj
		pop	es
		assume es:nothing
		pop	ds
		assume ds:nothing
		popa
		iret
; ---------------------------------------------------------------------------
		align 2
		assume ds:seg004
jumpTbl_intF3	dw offset sub_1299E	; 0 ; DATA XREF: seg002:005Er
		dw offset sub_129AE	; 1
		dw offset sub_12C36	; 2
		dw offset sub_12998	; 3
		dw offset sub_12998	; 4
		dw offset sub_12998	; 5
		dw offset sub_12E9C	; 6
		dw offset sub_12EB6	; 7
		dw offset sub_12EBC	; 8
		dw offset sub_12ED4	; 9
		dw offset sub_131BA	; 0Ah
		dw offset sub_131DA	; 0Bh
		dw offset sub_1321C	; 0Ch
		dw offset sub_1323A	; 0Dh
		dw offset sub_1324C	; 0Eh
		dw offset sub_13278	; 0Fh
		dw offset sub_12C7A	; 10h
		dw offset sub_12C8A	; 11h
		dw offset sub_12CD6	; 12h
		dw offset sub_12CDE	; 13h
		dw offset sub_12CF4	; 14h
		dw offset sub_12D04	; 15h
		dw offset sub_12D4A	; 16h
		dw offset sub_12998	; 17h

; =============== S U B	R O U T	I N E =======================================


sub_12998	proc near		; CODE XREF: seg002:005Ep
					; DATA XREF: seg002:jumpTbl_intF3o
		or	byte ptr [bp+18h], 1
		retn
sub_12998	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_1299E	proc near		; CODE XREF: seg002:005Ep
					; DATA XREF: seg002:jumpTbl_intF3o
		mov	ax, (offset byte_14E90+454h)
		mov	[bp+0Ch], ax
		mov	word ptr [bp+0], ds
		mov	word ptr [bp+10h], 0F800h
		retn
sub_1299E	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_129AE	proc near		; CODE XREF: seg002:005Ep
					; DATA XREF: seg002:jumpTbl_intF3o
		push	ds
		mov	di, 0
		mov	ds, word ptr [bp+2]
		assume ds:nothing
		mov	cx, 8
		rep movsw
		pop	ds
		assume ds:seg004
		mov	si, (offset byte_14E90+454h)
		mov	ax, [si+10h]
		mov	word ptr byte_14E90+16h, ax
		mov	word ptr byte_14E90+18h, ax
		mov	bx, 50h	; 'P'
		mul	bx
		mov	word ptr byte_14E90+1Ah, ax
		test	word ptr byte_14E90+0Eh, 1
		jz	short loc_129DA
		call	sub_12C22

loc_129DA:				; CODE XREF: sub_129AE+27j
		call	sub_12BDE
		test	word ptr byte_14E90+0Eh, 2
		jz	short loc_129EF
		mov	ax, word ptr byte_14E90+42h
		push	di
		push	si
		call	sub_12C8A
		pop	si
		pop	di

loc_129EF:				; CODE XREF: sub_129AE+35j
		mov	ax, 136h
		cmp	word ptr byte_14E90+0Ch, 0
		jz	short loc_129FC
		mov	ax, 192h

loc_129FC:				; CODE XREF: sub_129AE+49j
		mov	word ptr byte_14E90+20h, ax
		mov	word ptr byte_14E90+1Ch, 1D4h
		mov	word ptr byte_14E90+1Eh, 0FFFFh

loc_12A0B:				; CODE XREF: sub_129AE+84j
		mov	cx, word ptr byte_14E90+14h
		push	di

loc_12A10:				; CODE XREF: sub_129AE+76j
		push	cx
		call	sub_12B94
		call	sub_12B57
		call	word ptr byte_14E90+20h
		pop	cx
		add	di, word ptr byte_14E90+1Ah
		sub	cx, word ptr byte_14E90+16h
		ja	short loc_12A10
		pop	di
		add	di, 50h	; 'P'
		dec	word ptr byte_14E90+14h
		dec	word ptr byte_14E90+18h
		jnz	short loc_12A0B
		retn
sub_129AE	endp

; ---------------------------------------------------------------------------
		align 2
		push	di
		push	si
		push	es
		mov	si, (offset byte_14E90+1D5h)
		mov	cx, word ptr byte_14E90+10h
		cmp	word ptr byte_14E90+1Eh, 0
		jnz	short loc_12A4A
		call	sub_12AF4

loc_12A4A:				; CODE XREF: seg002:0145j
		mov	word ptr byte_14E90+1Eh, 0
		mov	es, word ptr byte_14E90
		assume es:nothing
		call	sub_12B08
		mov	es, word ptr byte_14E90+2
		call	sub_12B08
		mov	es, word ptr byte_14E90+4
		call	sub_12B08
		mov	es, word ptr byte_14E90+6
		call	sub_12B08
		push	ds
		pop	es
		assume es:seg004
		mov	si, (offset byte_14E90+1D5h)
		mov	cx, word ptr byte_14E90+10h
		add	cx, cx
		mov	di, 44h	; 'D'
		rep movsw
		mov	cx, word ptr byte_14E90+1Ch
		mov	di, (offset byte_14E90+1D4h)
		sub	cx, si
		jz	short loc_12A89
		rep movsb

loc_12A89:				; CODE XREF: seg002:0185j
		mov	word ptr byte_14E90+1Ch, di
		pop	es
		assume es:nothing
		pop	si
		pop	di
		retn
; ---------------------------------------------------------------------------
		align 2
		push	di
		push	si
		push	es
		mov	si, 1D5h
		mov	cx, word ptr byte_14E90+10h
		cmp	word ptr byte_14E90+1Eh, 0
		jnz	short loc_12AA6
		call	sub_12AF4

loc_12AA6:				; CODE XREF: seg002:01A1j
		mov	word ptr byte_14E90+1Eh, 0
		mov	bx, 184h
		call	sub_12B38
		mov	es, word ptr byte_14E90
		assume es:nothing
		call	sub_12B20
		mov	es, word ptr byte_14E90+2
		call	sub_12B20
		mov	es, word ptr byte_14E90+4
		call	sub_12B20
		mov	es, word ptr byte_14E90+6
		call	sub_12B20
		push	ds
		pop	es
		assume es:seg004
		mov	si, 1D5h
		mov	cx, word ptr byte_14E90+10h
		add	cx, cx
		mov	di, 44h	; 'D'
		rep movsw
		mov	cx, word ptr byte_14E90+1Ch
		mov	di, 1D4h
		sub	cx, si
		jz	short loc_12AEB
		rep movsb

loc_12AEB:				; CODE XREF: seg002:01E7j
		mov	word ptr byte_14E90+1Ch, di
		pop	es
		assume es:nothing
		pop	si
		pop	di
		retn
; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_12AF4	proc near		; CODE XREF: seg002:0147p seg002:01A3p
		push	di
		push	si
		push	cx
		mov	di, 44h	; 'D'
		xchg	si, di
		add	cx, cx

loc_12AFE:				; CODE XREF: sub_12AF4+Ej
		lodsw
		xor	ax, [di]
		stosw
		loop	loc_12AFE
		pop	cx
		pop	si
		pop	di
		retn
sub_12AF4	endp


; =============== S U B	R O U T	I N E =======================================


sub_12B08	proc near		; CODE XREF: seg002:0154p seg002:015Bp ...
		push	cx
		push	di
		rep movsb
		pop	di
		pop	cx
		retn
sub_12B08	endp

; ---------------------------------------------------------------------------
		align 2
		push	cx
		push	di
		push	bx

loc_12B13:				; CODE XREF: seg002:0219j
		lodsb
		xor	al, es:[bx]
		stosb
		inc	bx
		loop	loc_12B13
		pop	bx
		pop	di
		pop	cx
		retn
; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_12B20	proc near		; CODE XREF: seg002:01B6p seg002:01BDp ...
		push	di
		push	bx
		push	cx

loc_12B23:				; CODE XREF: sub_12B20+12j
		mov	ah, [bx]
		inc	bx
		lodsb
		and	al, ah
		not	ah
		and	es:[di], ah
		or	es:[di], al
		inc	di
		loop	loc_12B23
		pop	cx
		pop	bx
		pop	di
		retn
sub_12B20	endp


; =============== S U B	R O U T	I N E =======================================


sub_12B38	proc near		; CODE XREF: seg002:01AFp
		push	di
		push	si
		mov	di, bx
		mov	dx, cx

loc_12B3E:				; CODE XREF: sub_12B38+18j
		push	si
		mov	al, [si]
		add	si, dx
		or	al, [si]
		add	si, dx
		or	al, [si]
		add	si, dx
		or	al, [si]
		pop	si
		inc	si
		stosb
		loop	loc_12B3E
		mov	cx, dx
		pop	si
		pop	di
		retn
sub_12B38	endp


; =============== S U B	R O U T	I N E =======================================


sub_12B57	proc near		; CODE XREF: sub_129AE+66p
		push	di
		push	si
		mov	si, 1D4h
		lodsb
		test	al, al
		jz	short loc_12B90
		sub	ah, ah
		mov	dx, ax
		mov	bx, si
		mov	ax, word ptr byte_14E90+10h
		add	ax, ax
		add	ax, ax
		add	ax, si
		mov	di, ax
		mov	al, [si]
		add	si, dx
		sub	cx, cx

loc_12B78:				; CODE XREF: sub_12B57+37j
		cmp	cx, dx
		jnb	short loc_12B90

loc_12B7C:				; CODE XREF: sub_12B57+2Fj
		cmp	si, di
		jnb	short loc_12B88
		xor	[si], al
		mov	al, [si]
		add	si, dx
		jmp	short loc_12B7C
; ---------------------------------------------------------------------------

loc_12B88:				; CODE XREF: sub_12B57+27j
		mov	si, bx
		add	si, cx
		inc	si
		inc	cx
		jmp	short loc_12B78
; ---------------------------------------------------------------------------

loc_12B90:				; CODE XREF: sub_12B57+8j
					; sub_12B57+23j
		pop	si
		pop	di
		retn
sub_12B57	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_12B94	proc near		; CODE XREF: sub_129AE+63p
		push	di
		mov	di, word ptr byte_14E90+1Ch
		mov	ax, di
		sub	ax, 1D4h
		cmp	ax, word ptr byte_14E90+12h
		jnb	short loc_12BDB

loc_12BA4:				; CODE XREF: sub_12B94+41j
		lodsb
		mov	dh, al
		mov	bh, 8

loc_12BA9:				; CODE XREF: sub_12B94+36j
		rcl	dh, 1
		jnb	short loc_12BC2
		lodsb
		mov	dl, al
		mov	bl, 8

loc_12BB2:				; CODE XREF: sub_12B94+2Aj
		rcl	dl, 1
		jnb	short loc_12BB9
		movsb
		jmp	short loc_12BBC
; ---------------------------------------------------------------------------

loc_12BB9:				; CODE XREF: sub_12B94+20j
		sub	al, al
		stosb

loc_12BBC:				; CODE XREF: sub_12B94+23j
		dec	bl
		jnz	short loc_12BB2
		jmp	short loc_12BC8
; ---------------------------------------------------------------------------

loc_12BC2:				; CODE XREF: sub_12B94+17j
		sub	ax, ax
		stosw
		stosw
		stosw
		stosw

loc_12BC8:				; CODE XREF: sub_12B94+2Cj
		dec	bh
		jnz	short loc_12BA9
		mov	ax, di
		sub	ax, 1D4h
		cmp	ax, word ptr byte_14E90+12h
		jb	short loc_12BA4
		mov	word ptr byte_14E90+1Ch, di

loc_12BDB:				; CODE XREF: sub_12B94+Ej
		pop	di
		retn
sub_12B94	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_12BDE	proc near		; CODE XREF: sub_129AE:loc_129DAp
		mov	cl, 3
		mov	ax, [si+18h]
		add	si, ax
		lodsw
		add	ax, 7
		shr	ax, cl
		mov	word ptr byte_14E90+10h, ax
		add	ax, ax
		add	ax, ax
		inc	ax
		mov	word ptr byte_14E90+12h, ax
		lodsw
		mov	word ptr byte_14E90+14h, ax
		add	si, 6
		mov	ax, word ptr byte_14E90+8
		inc	ax
		jnz	short loc_12C10
		lodsw
		shr	ax, cl
		mov	word ptr byte_14E90+8, ax
		lodsw
		mov	word ptr byte_14E90+0Ah, ax
		sub	si, 4

loc_12C10:				; CODE XREF: sub_12BDE+23j
		mov	ax, 50h	; 'P'
		mul	word ptr byte_14E90+0Ah
		add	ax, word ptr byte_14E90+8
		mov	di, ax
		add	si, 4
		lodsw
		retn
sub_12BDE	endp


; =============== S U B	R O U T	I N E =======================================


sub_12C22	proc near		; CODE XREF: sub_129AE+29p
		push	si
		mov	ax, [si+14h]
		add	si, ax
		add	si, 4
		mov	cx, 10h
		mov	di, 22h	; '"'
		rep movsw
		pop	si
		retn
sub_12C22	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_12C36	proc near		; CODE XREF: seg002:005Ep
					; DATA XREF: seg002:jumpTbl_intF3o
		mov	es, word ptr [bp+0]
		mov	si, 454h
		mov	bx, [si+18h]
		add	bx, si
		mov	ax, [bx+0Ah]
		shr	ax, 3
		mov	es:[di], ax
		mov	ax, [bx+0Ch]
		mov	es:[di+2], ax
		mov	ax, [bx]
		add	ax, 7
		shr	ax, 3
		mov	es:[di+4], ax
		mov	ax, [bx+2]
		mov	es:[di+6], ax
		mov	ax, [si+10h]
		mov	es:[di+8], ax
		mov	ax, [si+14h]
		add	ax, si
		mov	es:[di+0Ah], ax
		mov	word ptr es:[di+0Ch], ds
		retn
sub_12C36	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_12C7A	proc near		; CODE XREF: seg002:005Ep
					; DATA XREF: seg002:jumpTbl_intF3o
		push	cs
		pop	ds
		assume ds:seg002
		mov	si, offset byte_12D7C
		mov	di, 22h	; '"'
		mov	cx, 10h
		cld
		rep movsw
		retn
sub_12C7A	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_12C8A	proc near		; CODE XREF: seg002:005Ep
					; sub_129AE+3Cp ...
		and	ax, 0Fh
		mov	word ptr loc_12942, ax
		mov	cl, 4
		shl	ax, cl
		add	ax, offset byte_12D9C
		mov	di, ax
		mov	si, 22h	; '"'

loc_12C9C:				; CODE XREF: sub_12C8A+16j
		in	al, 60h		; 8042 keyboard	controller data	register
		test	al, 20h
		jnz	short loc_12C9C

loc_12CA2:				; CODE XREF: sub_12C8A+1Cj
		in	al, 60h		; 8042 keyboard	controller data	register
		test	al, 20h
		jz	short loc_12CA2
		sub	ch, ch

loc_12CAA:				; CODE XREF: sub_12C8A+49j
		mov	al, ch
		out	0A8h, al	; Interrupt Controller #2, 8259A
		lodsw
		xchg	ah, al
		mov	bl, al
		and	bx, 0Fh
		mov	al, cs:[bx+di]
		out	0AAh, al	; Interrupt Controller #2, 8259A
		mov	bl, ah
		shr	bl, cl
		mov	al, cs:[bx+di]
		out	0ACh, al	; Interrupt Controller #2, 8259A
		mov	bl, ah
		and	bl, 0Fh
		mov	al, cs:[bx+di]
		out	0AEh, al	; Interrupt Controller #2, 8259A
		inc	ch
		cmp	ch, 0Fh
		jbe	short loc_12CAA
		retn
sub_12C8A	endp


; =============== S U B	R O U T	I N E =======================================


sub_12CD6	proc near		; CODE XREF: seg002:005Ep sub_12CF4+Bp ...
		mov	ax, word ptr loc_12942
		mov	[bp+12h], ax
		retn
sub_12CD6	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_12CDE	proc near		; CODE XREF: seg002:005Ep
					; DATA XREF: seg002:jumpTbl_intF3o
		mov	di, 22h	; '"'
		mov	ds, word ptr [bp+2]
		assume ds:nothing
		mov	cx, 10h
		rep movsw
		push	es
		pop	ds
		cmp	al, 0FFh
		jz	short locret_12CF2
		call	sub_12C8A

locret_12CF2:				; CODE XREF: sub_12CDE+Fj
		retn
sub_12CDE	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_12CF4	proc near		; CODE XREF: seg002:005Ep
					; DATA XREF: seg002:jumpTbl_intF3o
		mov	si, 22h	; '"'
		mov	es, word ptr [bp+0]
		mov	cx, 10h
		rep movsw
		call	sub_12CD6
		retn
sub_12CF4	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_12D04	proc near		; CODE XREF: seg002:005Ep
					; DATA XREF: seg002:jumpTbl_intF3o
		sub	ch, ch
		shl	cx, 4
		mov	di, offset byte_12D9C
		add	di, cx
		mov	bl, al
		and	bx, 0Fh
		add	bx, bx
		mov	dx, [bp+0Ch]
		and	dx, 0FFFh
		mov	[bx+22h], dx
		cmp	byte ptr [bp+10h], 0FFh
		jz	short locret_12D48
		out	0A8h, al	; Interrupt Controller #2, 8259A
		xchg	dh, dl
		mov	bl, dl
		and	bx, 0Fh
		mov	al, cs:[bx+di]
		out	0AAh, al	; Interrupt Controller #2, 8259A
		mov	bl, dh
		shr	bl, 4
		mov	al, cs:[bx+di]
		out	0ACh, al	; Interrupt Controller #2, 8259A
		mov	bl, dh
		and	bl, 0Fh
		mov	al, cs:[bx+di]
		out	0AEh, al	; Interrupt Controller #2, 8259A

locret_12D48:				; CODE XREF: sub_12D04+20j
		retn
sub_12D04	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_12D4A	proc near		; CODE XREF: seg002:005Ep
					; DATA XREF: seg002:jumpTbl_intF3o
		mov	bl, al
		and	bx, 0Fh
		add	bx, bx

loc_12D51:
		mov	ax, [bx+22h]
		mov	[bp+0Ch], ax
		call	sub_12CD6
		retn
sub_12D4A	endp

; ---------------------------------------------------------------------------
byte_12D5C	db 20h dup(0)		; DATA XREF: seg002:0047o
byte_12D7C	db    0,   0		; DATA XREF: sub_12C7A+2o
		db    7,   0
		db  70h,   0
		db  77h,   0
		db    0,   7
		db    7,   7
		db  70h,   7
		db  77h,   7
		db  33h,   3
		db  0Fh,   0
		db 0F0h,   0
		db 0FFh,   0
		db    0, 0Fh
		db  0Fh, 0Fh
		db 0F0h, 0Fh
		db 0FFh, 0Fh
byte_12D9C	db    0,   0,	0,   0,	  0,   0,   0,	 0,   0,   0,	0,   0,	  0,   0,   0,	 0
					; DATA XREF: sub_12C8A+Ao sub_12D04+5o
		db    0,   0,	0,   0,	  0,   0,   0,	 0,   1,   1,	1,   1,	  1,   1,   1,	 1
		db    0,   0,	0,   0,	  1,   1,   1,	 1,   1,   1,	1,   1,	  2,   2,   2,	 2
		db    0,   0,	0,   1,	  1,   1,   1,	 1,   2,   2,	2,   2,	  2,   3,   3,	 3
		db    0,   0,	1,   1,	  1,   1,   2,	 2,   2,   2,	3,   3,	  3,   3,   4,	 4
		db    0,   0,	1,   1,	  1,   2,   2,	 2,   3,   3,	3,   4,	  4,   4,   5,	 5
		db    0,   0,	1,   1,	  2,   2,   2,	 3,   3,   4,	4,   4,	  5,   5,   6,	 6
		db    0,   0,	1,   1,	  2,   2,   3,	 3,   4,   4,	5,   5,	  6,   6,   7,	 7
		db    0,   1,	1,   2,	  2,   3,   3,	 4,   4,   5,	5,   6,	  6,   7,   7,	 8
		db    0,   1,	1,   2,	  2,   3,   4,	 4,   5,   5,	6,   7,	  7,   8,   8,	 9
		db    0,   1,	1,   2,	  3,   3,   4,	 5,   5,   6,	7,   7,	  8,   9,   9, 0Ah
		db    0,   1,	1,   2,	  3,   4,   4,	 5,   6,   7,	7,   8,	  9, 0Ah, 0Ah, 0Bh
		db    0,   1,	2,   2,	  3,   4,   5,	 6,   6,   7,	8,   9,	0Ah, 0Ah, 0Bh, 0Ch
		db    0,   1,	2,   3,	  3,   4,   5,	 6,   7,   8,	9, 0Ah,	0Ah, 0Bh, 0Ch, 0Dh
		db    0,   1,	2,   3,	  4,   5,   6,	 7,   7,   8,	9, 0Ah,	0Bh, 0Ch, 0Dh, 0Eh
		db    0,   1,	2,   3,	  4,   5,   6,	 7,   8,   9, 0Ah, 0Bh,	0Ch, 0Dh, 0Eh, 0Fh

; =============== S U B	R O U T	I N E =======================================


sub_12E9C	proc near		; CODE XREF: seg002:005Ep
					; DATA XREF: seg002:jumpTbl_intF3o
		mov	bx, seg	seg008
		mov	ds, bx
		assume ds:seg008
		test	al, al
		jz	short loc_12EAB
		mov	cx, word_40304
		jmp	short loc_12EB2
; ---------------------------------------------------------------------------

loc_12EAB:				; CODE XREF: sub_12E9C+7j
		and	cx, 3
		xchg	cx, word_40304

loc_12EB2:				; CODE XREF: sub_12E9C+Dj
		mov	[bp+12h], cx
		retn
sub_12E9C	endp


; =============== S U B	R O U T	I N E =======================================


sub_12EB6	proc near		; CODE XREF: seg002:005Ep
					; DATA XREF: seg002:jumpTbl_intF3o
		mov	bx, seg	seg008
		mov	ds, bx
		retn
sub_12EB6	endp


; =============== S U B	R O U T	I N E =======================================


sub_12EBC	proc near		; CODE XREF: seg002:005Ep
					; DATA XREF: seg002:jumpTbl_intF3o
		and	al, 1
		mov	ax, 0
		jz	short loc_12EC6
		mov	ax, 8000h

loc_12EC6:				; CODE XREF: sub_12EBC+5j
		mov	[bp+0Ch], ax
		mov	word ptr [bp+0], seg seg005
		mov	word ptr [bp+10h], 8000h
		retn
sub_12EBC	endp


; =============== S U B	R O U T	I N E =======================================


sub_12ED4	proc near		; CODE XREF: seg002:005Ep
					; DATA XREF: seg002:jumpTbl_intF3o
		push	ds
		mov	bx, seg	seg008
		mov	ds, bx
		test	word_40304, 2
		pop	ds
		assume ds:nothing
		jnz	short loc_12EE6
		jmp	locret_1300C
; ---------------------------------------------------------------------------

loc_12EE6:				; CODE XREF: sub_12ED4+Dj
		mov	bx, 0
		and	al, 1
		jz	short loc_12EF0
		mov	bx, 8000h

loc_12EF0:				; CODE XREF: sub_12ED4+17j
		mov	ax, seg	seg005
		mov	ds, ax
		assume ds:seg005
		mov	ax, seg	seg006
		mov	es, ax
		assume es:seg006
		mov	es:word_34AF0, 0A800h
		mov	es:word_34AF2, 0B000h
		mov	es:word_34AF4, 0B800h
		mov	es:word_34AF6, 0E000h
		mov	al, [bp+0Ch]
		cmp	al, 2Eh	; '.'
		jnz	short loc_12F20
		jmp	locret_1300C
; ---------------------------------------------------------------------------

loc_12F20:				; CODE XREF: sub_12ED4+47j
		cmp	al, 20h	; ' '
		jnz	short loc_12F27
		jmp	locret_1300C
; ---------------------------------------------------------------------------

loc_12F27:				; CODE XREF: sub_12ED4+4Ej
		sub	al, 0B1h ; '±'
		sub	ah, ah
		cmp	[bx+10h], ax
		ja	short loc_12F33
		jmp	locret_1300C
; ---------------------------------------------------------------------------

loc_12F33:				; CODE XREF: sub_12ED4+5Aj
		shl	ax, 2
		mov	si, bx
		add	bx, ax
		add	bx, 18h
		add	si, [bx]
		cld
		lodsw
		mov	es:word_34B00, ax
		mov	es:word_34B02, ax
		lodsw
		add	ax, 7
		shr	ax, 3
		mov	di, ax
		lodsw
		mov	bx, 50h	; 'P'
		mul	bx
		add	di, ax
		mov	es:word_34CEC, di
		lodsw
		add	ax, 7
		shr	ax, 3
		mov	es:word_34AF8, ax
		add	ax, ax
		add	ax, ax
		mov	es:word_34B04, ax
		mov	bx, ax
		inc	ax
		mov	es:word_34AFA, ax
		mov	ax, es:word_34B00
		mul	bx
		mov	es:word_34B06, ax
		lodsw
		mov	es:word_34AFC, ax
		mov	es:word_34AFE, ax
		mov	di, 1FEh
		mov	es:word_34B08, 0BCh ; 'º'
		mov	es:word_34B0A, 0FFFFh

loc_12F9D:				; CODE XREF: sub_12ED4+F6j
		mov	cx, es:word_34AFE
		push	di

loc_12FA3:				; CODE XREF: sub_12ED4+E4j
		push	cx
		call	sub_1300E
		call	sub_1305C
		call	sub_1309C
		pop	cx
		add	di, es:word_34B06
		sub	cx, es:word_34B00
		ja	short loc_12FA3
		pop	di
		add	di, es:word_34B04
		dec	es:word_34AFE
		dec	es:word_34B02
		jnz	short loc_12F9D
		push	ds
		push	es
		pop	ds
		assume ds:seg006
		mov	si, 1FEh
		mov	bx, word_34CEC
		mov	dx, word_34AFC
		mov	ax, word_34AF8

loc_12FDD:				; CODE XREF: sub_12ED4+135j
		mov	es, word_34AF0
		assume es:nothing
		mov	cx, ax
		mov	di, bx
		rep movsb
		mov	es, word_34AF2
		mov	cx, ax
		mov	di, bx
		rep movsb
		mov	es, word_34AF4
		mov	cx, ax
		mov	di, bx
		rep movsb
		mov	es, word_34AF6
		mov	cx, ax
		mov	di, bx
		rep movsb
		add	bx, 50h	; 'P'
		dec	dx
		jnz	short loc_12FDD
		pop	ds
		assume ds:nothing

locret_1300C:				; CODE XREF: sub_12ED4+Fj
					; sub_12ED4+49j ...
		retn
sub_12ED4	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_1300E	proc near		; CODE XREF: sub_12ED4+D0p
		push	di
		mov	di, es:18h
		mov	ax, di
		sub	ax, 0BCh ; 'º'
		cmp	ax, es:0Ah
		jnb	short loc_13059

loc_13020:				; CODE XREF: sub_1300E+44j
		lodsb
		mov	dh, al
		mov	bh, 8

loc_13025:				; CODE XREF: sub_1300E+38j
		rcl	dh, 1
		jnb	short loc_1303E
		lodsb
		mov	dl, al
		mov	bl, 8

loc_1302E:				; CODE XREF: sub_1300E+2Cj
		rcl	dl, 1
		jnb	short loc_13035
		movsb
		jmp	short loc_13038
; ---------------------------------------------------------------------------

loc_13035:				; CODE XREF: sub_1300E+22j
		sub	al, al
		stosb

loc_13038:				; CODE XREF: sub_1300E+25j
		dec	bl
		jnz	short loc_1302E
		jmp	short loc_13044
; ---------------------------------------------------------------------------

loc_1303E:				; CODE XREF: sub_1300E+19j
		sub	ax, ax
		stosw
		stosw
		stosw
		stosw

loc_13044:				; CODE XREF: sub_1300E+2Ej
		dec	bh
		jnz	short loc_13025
		mov	ax, di
		sub	ax, 0BCh ; 'º'
		cmp	ax, es:0Ah
		jb	short loc_13020
		mov	es:18h,	di

loc_13059:				; CODE XREF: sub_1300E+10j
		pop	di
		retn
sub_1300E	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_1305C	proc near		; CODE XREF: sub_12ED4+D3p
		push	di
		push	si
		push	ds
		push	es
		pop	ds
		mov	si, 0BCh ; 'º'
		lodsb
		test	al, al
		jz	short loc_13098
		sub	ah, ah
		mov	dx, ax
		mov	bx, si
		mov	ax, ds:8
		add	ax, ax
		add	ax, ax
		add	ax, si
		mov	di, ax
		mov	al, [si]
		add	si, dx
		sub	cx, cx

loc_13080:				; CODE XREF: sub_1305C+3Aj
		cmp	cx, dx
		jnb	short loc_13098

loc_13084:				; CODE XREF: sub_1305C+32j
		cmp	si, di
		jnb	short loc_13090
		xor	[si], al
		mov	al, [si]
		add	si, dx
		jmp	short loc_13084
; ---------------------------------------------------------------------------

loc_13090:				; CODE XREF: sub_1305C+2Aj
		mov	si, bx
		add	si, cx
		inc	si
		inc	cx
		jmp	short loc_13080
; ---------------------------------------------------------------------------

loc_13098:				; CODE XREF: sub_1305C+Bj
					; sub_1305C+26j
		pop	ds
		pop	si
		pop	di
		retn
sub_1305C	endp


; =============== S U B	R O U T	I N E =======================================


sub_1309C	proc near		; CODE XREF: sub_12ED4+D6p
		push	di
		push	si
		push	ds
		push	es
		pop	ds
		mov	si, 0BDh ; 'Ω'
		mov	cx, ds:8
		cmp	word ptr ds:1Ah, 0
		jnz	short loc_130B2
		call	sub_130E0

loc_130B2:				; CODE XREF: sub_1309C+11j
		mov	word ptr ds:1Ah, 0
		add	cx, cx
		rep movsw
		mov	si, 0BDh ; 'Ω'
		mov	cx, ds:8
		add	cx, cx
		mov	di, 1Ch
		rep movsw
		mov	cx, ds:18h
		mov	di, 0BCh ; 'º'
		sub	cx, si
		jz	short loc_130D7
		rep movsb

loc_130D7:				; CODE XREF: sub_1309C+37j
		mov	ds:18h,	di
		pop	ds
		pop	si
		pop	di
		retn
sub_1309C	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_130E0	proc near		; CODE XREF: sub_1309C+13p
		push	di
		push	si
		push	cx
		mov	di, 1Ch
		xchg	si, di
		add	cx, cx

loc_130EA:				; CODE XREF: sub_130E0+Ej
		lodsw
		xor	ax, [di]
		stosw
		loop	loc_130EA
		pop	cx
		pop	si
		pop	di
		retn
sub_130E0	endp

		assume ds:seg008

; =============== S U B	R O U T	I N E =======================================


sub_130F4	proc far		; CODE XREF: sub_103CC+7P
		test	word_40304, 1
		jnz	short loc_130FF
		jmp	locret_131B8
; ---------------------------------------------------------------------------

loc_130FF:				; CODE XREF: sub_130F4+6j
		push	word_40304
		mov	word_40304, 2
		cld
		cmp	word_40308, 0
		jz	short loc_1315F
		mov	bx, word_4030C

loc_13115:				; CODE XREF: sub_130F4+35j
		mov	al, [bx]
		inc	bx
		test	al, al
		jnz	short loc_1312B
		dec	word_40308
		mov	bx, offset byte_4187A
		mov	al, [bx]
		test	al, al
		jz	short loc_1315F
		jmp	short loc_13115
; ---------------------------------------------------------------------------

loc_1312B:				; CODE XREF: sub_130F4+26j
		mov	word_4030C, bx
		cmp	al, 20h	; ' '
		jnz	short loc_13139
		dec	word_40308
		jmp	short loc_1315F
; ---------------------------------------------------------------------------

loc_13139:				; CODE XREF: sub_130F4+3Dj
		cmp	al, 2Eh	; '.'
		jz	short loc_1315F
		cmp	al, 7Eh	; '~'
		jnz	short loc_13158
		mov	bx, word_4030C
		mov	al, [bx]
		inc	bx
		push	bx
		mov	bl, al
		mov	ax, 900h
		int	0F3h
		pop	bx
		mov	al, [bx]
		inc	bx
		mov	word_4030C, bx

loc_13158:				; CODE XREF: sub_130F4+4Bj
		mov	bl, al
		mov	ax, 900h
		int	0F3h

loc_1315F:				; CODE XREF: sub_130F4+1Bj
					; sub_130F4+33j ...
		cmp	word_4030A, 0
		jz	short loc_131B4
		mov	bx, word_4030E

loc_1316A:				; CODE XREF: sub_130F4+8Aj
		mov	al, [bx]
		inc	bx
		test	al, al
		jnz	short loc_13180
		dec	word_4030A
		mov	bx, offset byte_41910
		mov	al, [bx]
		test	al, al
		jz	short loc_131B4
		jmp	short loc_1316A
; ---------------------------------------------------------------------------

loc_13180:				; CODE XREF: sub_130F4+7Bj
		mov	word_4030E, bx
		cmp	al, 20h	; ' '
		jnz	short loc_1318E
		dec	word_4030A
		jmp	short loc_131B4
; ---------------------------------------------------------------------------

loc_1318E:				; CODE XREF: sub_130F4+92j
		cmp	al, 2Eh	; '.'
		jz	short loc_131B4
		cmp	al, 32h	; '2'
		jnz	short loc_131AD
		mov	bx, word_4030E
		mov	al, [bx]
		inc	bx
		push	bx
		mov	bl, al
		mov	ax, 901h
		int	0F3h
		pop	bx
		mov	al, [bx]
		inc	bx
		mov	word_4030E, bx

loc_131AD:				; CODE XREF: sub_130F4+A0j
		mov	bl, al
		mov	ax, 901h
		int	0F3h

loc_131B4:				; CODE XREF: sub_130F4+70j
					; sub_130F4+88j ...
		pop	word_40304

locret_131B8:				; CODE XREF: sub_130F4+8j
		retf
sub_130F4	endp

; ---------------------------------------------------------------------------
		nop

; =============== S U B	R O U T	I N E =======================================


sub_131BA	proc near		; CODE XREF: seg002:005Ep
					; DATA XREF: seg002:jumpTbl_intF3o
		mov	bx, seg	seg008
		mov	ds, bx
		cbw
		mov	word_40302, ax
		mov	word_4030C, offset byte_4187A
		mov	word_4030E, offset byte_41910
		test	ax, ax
		jnz	short locret_131D9
		mov	word_40308, ax
		mov	word_4030A, ax

locret_131D9:				; CODE XREF: sub_131BA+17j
		retn
sub_131BA	endp


; =============== S U B	R O U T	I N E =======================================


sub_131DA	proc near		; CODE XREF: seg002:005Ep
					; DATA XREF: seg002:jumpTbl_intF3o
		mov	bx, seg	seg008
		mov	es, bx
		assume es:seg008
		mov	di, offset byte_4187A
		test	al, al
		jz	short loc_131E9
		mov	di, offset byte_41910

loc_131E9:				; CODE XREF: sub_131DA+Aj
		mov	ds, word ptr [bp+2]
		assume ds:nothing
		mov	si, [bp+6]
		sub	cx, cx

loc_131F1:				; CODE XREF: sub_131DA+28j
		lodsb
		test	al, al
		jz	short loc_13204
		cmp	al, 22h	; '"'
		jz	short loc_13204
		inc	cx
		cmp	cx, 96h	; 'ñ'
		jnb	short loc_13204
		stosb
		jmp	short loc_131F1
; ---------------------------------------------------------------------------

loc_13204:				; CODE XREF: sub_131DA+1Aj
					; sub_131DA+1Ej ...
		sub	ax, ax
		stosb
		push	es
		pop	ds
		assume ds:seg008
		mov	word_40308, ax
		mov	word_4030A, ax
		mov	word_4030C, offset byte_4187A
		mov	word_4030E, offset byte_41910
		retn
sub_131DA	endp


; =============== S U B	R O U T	I N E =======================================


sub_1321C	proc near		; CODE XREF: seg002:005Ep
					; DATA XREF: seg002:jumpTbl_intF3o
		mov	bx, seg	seg008
		mov	ds, bx
		mov	ah, al
		mov	bx, 188h
		and	al, 1
		jz	short loc_1322D
		mov	bx, 18Ah

loc_1322D:				; CODE XREF: sub_1321C+Cj
		test	ah, ah
		js	short loc_13234
		mov	[bx], cx
		retn
; ---------------------------------------------------------------------------

loc_13234:				; CODE XREF: sub_1321C+13j
		mov	ax, [bx]

loc_13236:
		mov	[bp+10h], ax
		retn
sub_1321C	endp


; =============== S U B	R O U T	I N E =======================================


sub_1323A	proc near		; CODE XREF: seg002:005Ep
					; DATA XREF: seg002:jumpTbl_intF3o
		mov	bx, seg	seg008
		mov	ds, bx
		mov	bx, 188h
		test	al, al
		jz	short loc_13249
		mov	bx, 18Ah

loc_13249:				; CODE XREF: sub_1323A+Aj
		inc	word ptr [bx]
		retn
sub_1323A	endp


; =============== S U B	R O U T	I N E =======================================


sub_1324C	proc near		; CODE XREF: seg002:005Ep
					; DATA XREF: seg002:jumpTbl_intF3o
		cli
		mov	bx, seg	seg008
		mov	ds, bx
		mov	bx, 186h
		test	al, al
		jz	short loc_1325C
		mov	bx, 187h

loc_1325C:				; CODE XREF: sub_1324C+Bj
		mov	[bx], cl
		sub	ax, ax
		cli
		mov	word_40302, ax
		mov	word_40308, ax
		mov	word_4030A, ax
		mov	word_4030C, offset byte_4187A
		mov	word_4030E, offset byte_41910
		retn
sub_1324C	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_13278	proc near		; CODE XREF: seg002:005Ep
					; DATA XREF: seg002:jumpTbl_intF3o
		call	sub_103E0
		retn
sub_13278	endp

; ---------------------------------------------------------------------------
		align 4
seg002		ends

; ===========================================================================

; Segment type:	Pure code
seg003		segment	byte public 'CODE' use16
		assume cs:seg003
		assume es:nothing, ss:nothing, ds:seg008, fs:nothing, gs:nothing

; =============== S U B	R O U T	I N E =======================================


sub_13280	proc near		; CODE XREF: sub_1329C+7p
		push	ax
		call	sub_1337C
		jz	short loc_1329A
		call	sub_1362F
		mov	ah, 0FFh
		rcr	ah, 1
		or	al, al
		jnz	short loc_13295
		or	ah, ah
		js	short loc_13298

loc_13295:				; CODE XREF: sub_13280+Fj
		call	sub_13329

loc_13298:				; CODE XREF: sub_13280+13j
		shl	ah, 1

loc_1329A:				; CODE XREF: sub_13280+4j
		pop	ax
		retn
sub_13280	endp


; =============== S U B	R O U T	I N E =======================================


sub_1329C	proc far		; CODE XREF: DoMainInit+41P
		push	ax
		push	cs
		call	near ptr sub_14E6B
		mov	al, 1
		call	sub_13280
		push	ds
		push	cs
		pop	ds
		assume ds:seg003
		call	sub_1352B
		mov	si, offset unk_132CC
		call	sub_13575
		mov	ah, 3Ch	; '<'

loc_132B4:				; CODE XREF: sub_1329C+1Cj
					; sub_1329C+26j
		in	al, 60h		; 8042 keyboard	controller data	register
		test	al, 20h
		jnz	short loc_132B4

loc_132BA:				; CODE XREF: sub_1329C+22j
		in	al, 60h		; 8042 keyboard	controller data	register
		test	al, 20h
		jz	short loc_132BA
		dec	ah
		jnz	short loc_132B4
		sub	dx, dx
		call	sub_13688
		pop	ds
		assume ds:nothing
		pop	ax
		retf
sub_1329C	endp

; ---------------------------------------------------------------------------
unk_132CC	db    1			; DATA XREF: sub_1329C+10o
		db    0
		db    1
		db    0
		db    1
		db    0
		db    0
		db  0Ah
		db    0
		db    0
		db  18h
		db  5Dh	; ]
		db    0
		db    0
		db 0D3h	; ”
		db  31h	; 1
		db    0
		db    0
		db  27h	; '
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    8
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    7
		db    0
		db 0FEh	; ˛
		db    0
		db 0FBh	; ˚
		db  47h	; G
		db    3
		db  80h	; Ä
		db 0FFh
		assume ds:seg008

; =============== S U B	R O U T	I N E =======================================


sub_13310	proc near		; CODE XREF: sub_13325p
		push	ax
		call	sub_1337C
		jnz	short loc_13323
		mov	ah, 2
		int	0F4h
		mov	ah, 81h	; 'Å'
		int	0F4h
		call	sub_1335A
		cmp	ax, ax

loc_13323:				; CODE XREF: sub_13310+4j
		pop	ax
		retn
sub_13310	endp


; =============== S U B	R O U T	I N E =======================================


sub_13325	proc far		; CODE XREF: seg000:0114P
		call	sub_13310
		retf
sub_13325	endp


; =============== S U B	R O U T	I N E =======================================


sub_13329	proc near		; CODE XREF: sub_13280:loc_13295p
		push	ds
		push	ax
		mov	cs:word_133A5, es
		mov	ax, seg	seg007
		mov	ds, ax
		assume ds:seg007
		xor	ax, ax
		mov	byte_400F0, al
		mov	byte_400F1, al
		mov	ds, ax
		assume ds:nothing
		mov	ax, ds:3D0h
		mov	cs:word_133A9, ax
		mov	ax, ds:3D2h
		mov	cs:word_133AB, ax
		mov	word ptr ds:3D0h, offset loc_1339D
		mov	word ptr ds:3D2h, cs
		pop	ax
		pop	ds
		assume ds:seg008
		retn
sub_13329	endp


; =============== S U B	R O U T	I N E =======================================


sub_1335A	proc near		; CODE XREF: sub_13310+Ep
		push	ds
		push	bx
		push	ax
		xor	ax, ax
		mov	ds, ax
		assume ds:nothing
		mov	es, ax
		assume es:nothing
		lds	bx, ds:3D0h
		assume ds:nothing
		mov	ax, [bx+0Ch]
		mov	es:3D0h, ax
		mov	ax, [bx+0Eh]
		mov	es:3D2h, ax
		mov	es, word ptr [bx+8]
		assume es:nothing
		pop	ax
		pop	bx
		pop	ds
		assume ds:seg008
		retn
sub_1335A	endp


; =============== S U B	R O U T	I N E =======================================


sub_1337C	proc near		; CODE XREF: sub_13280+1p sub_13310+1p
		push	es
		push	ds
		push	di
		push	si
		xor	si, si
		mov	ds, si
		assume ds:nothing
		lds	si, ds:3D0h
		assume ds:nothing
		add	si, 2
		mov	di, cs
		mov	es, di
		assume es:seg003
		mov	di, offset aUsddrv ; "USDdrv"
		mov	cx, 6
		cld
		repe cmpsb
		pop	si
		pop	di
		pop	ds
		pop	es
		assume es:nothing
		retn
sub_1337C	endp

; ---------------------------------------------------------------------------

loc_1339D:				; DATA XREF: sub_13329+24o
		jmp	short loc_133B0
; ---------------------------------------------------------------------------
aUsddrv		db 'USDdrv'             ; DATA XREF: sub_1337C+13o
word_133A5	dw 0			; DATA XREF: sub_13329+2w
		dw seg seg007
word_133A9	dw 0			; DATA XREF: sub_13329+19w
word_133AB	dw 0			; DATA XREF: sub_13329+20w
byte_133AD	db 0			; DATA XREF: sub_1362F+2Fw
					; sub_136C5+7r	...
word_133AE	dw 3			; DATA XREF: sub_13437+2o sub_13496r ...
; ---------------------------------------------------------------------------

loc_133B0:				; CODE XREF: seg003:loc_1339Dj
		sti
		push	bp
		mov	bp, sp
		push	es
		push	ds
		push	di
		push	si
		push	dx
		push	cx
		push	bp
		xchg	ah, al
		mov	bp, ax
		and	bp, 7
		shl	bp, 1
		cmp	al, 10h
		jb	short loc_133D9
		cmp	al, 20h	; ' '
		jb	short loc_133D6
		cmp	al, 30h	; '0'
		jb	short loc_133D3
		add	bp, 10h

loc_133D3:				; CODE XREF: seg003:014Ej
		add	bp, 10h

loc_133D6:				; CODE XREF: seg003:014Aj
		add	bp, 10h

loc_133D9:				; CODE XREF: seg003:0146j
		call	cs:off_133F7[bp]
		pop	bp
		push	ax
		lahf
		mov	al, [bp+6]
		shr	al, 1
		shr	ah, 1
		rcl	al, 1
		mov	[bp+6],	al
		pop	ax
		pop	cx
		pop	dx
		pop	si
		pop	di
		pop	ds
		pop	es
		pop	bp
		iret

; =============== S U B	R O U T	I N E =======================================


nullsub_2	proc near		; CODE XREF: seg003:loc_133D9p
					; DATA XREF: seg003:off_133F7o
		retn
nullsub_2	endp

; ---------------------------------------------------------------------------
off_133F7	dw offset sub_13460	; 0 ; DATA XREF: seg003:loc_133D9r
		dw offset sub_13496	; 1
		dw offset sub_134F7	; 2
		dw offset sub_134FD	; 3
		dw offset sub_1350E	; 4
		dw offset sub_136A7	; 5
		dw offset sub_13437	; 6
		dw offset sub_134B6	; 7
		dw offset sub_1347B	; 8
		dw offset sub_134DA	; 9
		dw offset nullsub_2	; 0Ah
		dw offset nullsub_2	; 0Bh
		dw offset nullsub_2	; 0Ch
		dw offset nullsub_2	; 0Dh
		dw offset nullsub_2	; 0Eh
		dw offset nullsub_2	; 0Fh
		dw offset sub_136C5	; 10h
		dw offset sub_13749	; 11h
		dw offset nullsub_2	; 12h
		dw offset nullsub_2	; 13h
		dw offset nullsub_2	; 14h
		dw offset nullsub_2	; 15h
		dw offset nullsub_2	; 16h
		dw offset nullsub_2	; 17h
		dw offset sub_1362F	; 18h
		dw offset sub_1366D	; 19h
		dw offset sub_13575	; 1Ah
		dw offset sub_1355D	; 1Bh
		dw offset sub_13688	; 1Ch
		dw offset sub_136A7	; 1Dh
		dw offset sub_1374E	; 1Eh
		dw offset nullsub_2	; 1Fh

; =============== S U B	R O U T	I N E =======================================


sub_13437	proc near		; CODE XREF: seg003:loc_133D9p
					; DATA XREF: seg003:off_133F7o
		push	bx
		push	cx
		mov	bx, offset word_133AE
		test	ah, ah
		jz	short loc_13445
		mov	cx, cs:[bx]
		jmp	short loc_1345B
; ---------------------------------------------------------------------------

loc_13445:				; CODE XREF: sub_13437+7j
		and	cx, 3
		xchg	cx, cs:[bx]
		test	word ptr cs:[bx], 1
		jnz	short loc_1345B
		push	cx
		push	dx
		sub	dx, dx
		call	sub_13688
		pop	dx
		pop	cx

loc_1345B:				; CODE XREF: sub_13437+Cj
					; sub_13437+19j
		mov	ax, cx
		pop	cx
		pop	bx
		retn
sub_13437	endp


; =============== S U B	R O U T	I N E =======================================


sub_13460	proc near		; CODE XREF: seg003:loc_133D9p
					; DATA XREF: seg003:off_133F7o
		xor	dx, dx
		call	sub_13688
		mov	si, bx
		mov	di, seg	seg007
		mov	es, di
		assume es:seg007
		mov	di, 0
		call	sub_1354C
		jb	short locret_1347A
		mov	es:byte_400F0, 1

locret_1347A:				; CODE XREF: sub_13460+12j
		retn
sub_13460	endp


; =============== S U B	R O U T	I N E =======================================


sub_1347B	proc near		; CODE XREF: seg003:loc_133D9p
					; DATA XREF: seg003:off_133F7o
		xor	dx, dx
		call	sub_13688
		mov	si, bx
		mov	di, seg	seg007
		mov	es, di
		mov	di, 3000h
		call	sub_1354C
		jb	short locret_13495
		mov	es:byte_400F1, 1

locret_13495:				; CODE XREF: sub_1347B+12j
		retn
sub_1347B	endp


; =============== S U B	R O U T	I N E =======================================


sub_13496	proc near		; CODE XREF: seg003:loc_133D9p
					; DATA XREF: seg003:off_133F7o
		test	cs:word_133AE, 1
		jz	short locret_134B5
		call	sub_1352B
sub_13496	endp ; sp-analysis failed


; =============== S U B	R O U T	I N E =======================================


sub_134A2	proc near		; CODE XREF: sub_1350E+Dp
		mov	si, seg	seg007
		mov	ds, si
		assume ds:seg007
		cmp	byte_400F0, 0
		stc
		jz	short locret_134B5
		mov	si, 0
		call	sub_13575

locret_134B5:				; CODE XREF: sub_13496+7j sub_134A2+Bj
		retn
sub_134A2	endp


; =============== S U B	R O U T	I N E =======================================


sub_134B6	proc near		; CODE XREF: seg003:loc_133D9p
					; DATA XREF: seg003:off_133F7o
		test	cs:word_133AE, 1
		jz	short locret_134D9
		sub	bx, bx
		sub	dx, dx
		call	sub_136A7
		mov	si, seg	seg007
		mov	ds, si
		cmp	byte_400F0, 0
		stc
		jz	short locret_134D9
		mov	si, 0
		call	sub_13575

locret_134D9:				; CODE XREF: sub_134B6+7j
					; sub_134B6+1Bj
		retn
sub_134B6	endp


; =============== S U B	R O U T	I N E =======================================


sub_134DA	proc near		; CODE XREF: seg003:loc_133D9p
					; DATA XREF: seg003:off_133F7o
		test	cs:word_133AE, 2
		jz	short locret_134F6
		mov	si, seg	seg007
		mov	ds, si
		cmp	byte_400F1, 0
		stc
		jz	short locret_134F6
		mov	si, 3000h
		call	sub_1355D

locret_134F6:				; CODE XREF: sub_134DA+7j
					; sub_134DA+14j
		retn
sub_134DA	endp


; =============== S U B	R O U T	I N E =======================================


sub_134F7	proc near		; CODE XREF: seg003:loc_133D9p
					; DATA XREF: seg003:off_133F7o
		xor	dx, dx
		call	sub_13688
		retn
sub_134F7	endp


; =============== S U B	R O U T	I N E =======================================


sub_134FD	proc near		; CODE XREF: seg003:loc_133D9p
					; DATA XREF: seg003:off_133F7o
		push	bx
		call	sub_1352B
		mov	bx, 7
		mov	cx, 0FFFFh
		xor	dx, dx
		call	sub_136A7
		pop	bx
		retn
sub_134FD	endp


; =============== S U B	R O U T	I N E =======================================


sub_1350E	proc near		; CODE XREF: seg003:loc_133D9p
					; DATA XREF: seg003:off_133F7o
		push	bx
		test	cs:word_133AE, 1
		jz	short loc_13529
		call	sub_1353B
		call	sub_134A2
		mov	bx, 7
		mov	cx, 1
		xor	dx, dx
		call	sub_136A7

loc_13529:				; CODE XREF: sub_1350E+8j
		pop	bx
		retn
sub_1350E	endp


; =============== S U B	R O U T	I N E =======================================


sub_1352B	proc near		; CODE XREF: sub_1329C+Dp sub_13496+9p ...
		push	dx
		push	cx
		push	bx
		xor	bx, bx
		mov	cx, bx
		mov	dx, bx
		call	sub_136A7
		pop	bx
		pop	cx
		pop	dx
		retn
sub_1352B	endp


; =============== S U B	R O U T	I N E =======================================


sub_1353B	proc near		; CODE XREF: sub_1350E+Ap
		push	dx
		push	cx
		push	bx
		xor	bx, bx
		mov	cx, 0FFC0h
		mov	dx, bx
		call	sub_136A7
		pop	bx
		pop	cx
		pop	dx
		retn
sub_1353B	endp


; =============== S U B	R O U T	I N E =======================================


sub_1354C	proc near		; CODE XREF: sub_13460+Fp sub_1347B+Fp
		push	ds
		push	si
		push	dx
		push	bx
		mov	dx, si
		mov	bx, di
		sub	ah, ah
		int	0F2h
		pop	bx
		pop	dx
		pop	si
		pop	ds
		assume ds:nothing
		retn
sub_1354C	endp


; =============== S U B	R O U T	I N E =======================================


sub_1355D	proc near		; CODE XREF: seg003:loc_133D9p
					; sub_134DA+19p
					; DATA XREF: ...
		push	di
		push	bx
		cmp	bx, [si]
		cmc
		jb	short loc_13572
		shl	bx, 1
		add	si, [bx+si+2]
		add	si, 2
		mov	di, 503Eh
		call	sub_1357E

loc_13572:				; CODE XREF: sub_1355D+5j
		pop	bx
		pop	di
		retn
sub_1355D	endp


; =============== S U B	R O U T	I N E =======================================


sub_13575	proc near		; CODE XREF: sub_1329C+13p
					; seg003:loc_133D9p ...
		push	di
		mov	di, 5002h
		call	sub_1357E
		pop	di
		retn
sub_13575	endp


; =============== S U B	R O U T	I N E =======================================


sub_1357E	proc near		; CODE XREF: sub_1355D+12p
					; sub_13575+4p
		push	es
		push	ds
		push	bp
		push	si
		push	dx
		push	cx
		push	bx
		push	ax
		mov	bx, si
		mov	ax, seg	seg007
		mov	es, ax
		mov	cx, [si+2]
		jcxz	short loc_13594
		jmp	short loc_13597
; ---------------------------------------------------------------------------

loc_13594:				; CODE XREF: sub_1357E+12j
		jmp	loc_13625
; ---------------------------------------------------------------------------

loc_13597:				; CODE XREF: sub_1357E+14j
		cmp	cx, 6
		jbe	short loc_1359F
		jmp	loc_13625
; ---------------------------------------------------------------------------

loc_1359F:				; CODE XREF: sub_1357E+1Cj
		push	di
		mov	al, 0Ah
		mul	cl
		mov	cx, ax
		add	si, 6
		cld
		rep movsb
		xchg	si, bx
		mov	dx, ds
		mov	ax, es
		mov	ds, ax
		assume ds:seg007
		mov	es, dx
		assume es:nothing
		mov	ax, word_4016A
		mov	dx, word_4016C
		mov	di, word_4016E
		mov	bp, word_40170
		mov	cx, es:[si+4]
		jcxz	short loc_135E6

loc_135CB:				; CODE XREF: sub_1357E+66j
		cmp	word ptr es:[bx], 0
		jnz	short loc_135D8
		lea	ax, [bx+4]
		mov	dx, es
		jmp	short loc_135DD
; ---------------------------------------------------------------------------

loc_135D8:				; CODE XREF: sub_1357E+51j
		lea	di, [bx+4]
		mov	bp, es

loc_135DD:				; CODE XREF: sub_1357E+58j
		add	bx, es:[bx+2]
		add	bx, 4
		loop	loc_135CB

loc_135E6:				; CODE XREF: sub_1357E+4Bj
		add	bx, 2
		pop	cx
		push	si
		push	cx
		mov	si, es:[si+2]
		xchg	cx, si

loc_135F2:				; CODE XREF: sub_1357E+90j
		add	[si+2],	bx
		mov	word ptr [si+4], es
		cmp	byte ptr [si], 3
		jnb	short loc_13605
		mov	[si+6],	ax
		mov	[si+8],	dx
		jmp	short loc_1360B
; ---------------------------------------------------------------------------

loc_13605:				; CODE XREF: sub_1357E+7Dj
		mov	[si+6],	di
		mov	[si+8],	bp

loc_1360B:				; CODE XREF: sub_1357E+85j
		add	si, 0Ah
		loop	loc_135F2
		pop	cx
		pop	si
		push	ds
		push	cx
		push	word ptr es:[si+2]
		push	word ptr es:[si]
		push	cs
		call	near ptr sub_13E51
		add	sp, 8
		clc
		jmp	short loc_13626
; ---------------------------------------------------------------------------

loc_13625:				; CODE XREF: sub_1357E:loc_13594j
					; sub_1357E+1Ej
		stc

loc_13626:				; CODE XREF: sub_1357E+A5j
		pop	ax
		pop	bx
		pop	cx
		pop	dx
		pop	si
		pop	bp
		pop	ds
		assume ds:nothing
		pop	es
		retn
sub_1357E	endp


; =============== S U B	R O U T	I N E =======================================


sub_1362F	proc near		; CODE XREF: sub_13280+6p
					; seg003:loc_133D9p
					; DATA XREF: ...
		push	es
		push	ds
		push	bp
		push	di
		push	si
		push	dx
		push	cx
		push	bx
		push	ax
		mov	ax, seg	seg007
		mov	ds, ax
		assume ds:seg007
		mov	word_4016C, cx
		mov	word_4016A, si
		mov	word_40170, dx
		mov	word_4016E, di
		mov	word_40172, 0
		push	cs
		call	near ptr sub_1383A
		call	sub_13769
		neg	ax
		sbb	ax, ax
		mov	cs:byte_133AD, al
		cmc
		pop	ax
		pop	bx
		pop	cx
		pop	dx
		pop	si
		pop	di
		pop	bp
		pop	ds
		assume ds:nothing
		pop	es
		retn
sub_1362F	endp


; =============== S U B	R O U T	I N E =======================================


sub_1366D	proc near		; CODE XREF: seg003:loc_133D9p
					; DATA XREF: seg003:off_133F7o
		push	es
		push	ds
		push	bp
		push	di
		push	si
		push	dx
		push	cx
		push	bx
		push	ax
		call	sub_137AF
		push	cs
		call	near ptr sub_1392E
		clc
		pop	ax
		pop	bx
		pop	cx
		pop	dx
		pop	si
		pop	di
		pop	bp
		pop	ds
		pop	es
		retn
sub_1366D	endp


; =============== S U B	R O U T	I N E =======================================


sub_13688	proc near		; CODE XREF: sub_1329C+2Ap
					; seg003:loc_133D9p ...
		push	es
		push	ds
		push	bp
		push	di
		push	si
		push	dx
		push	cx
		push	bx
		push	ax
		push	dx
		push	cs
		call	near ptr sub_13F20
		add	sp, 2
		call	sub_1352B
		clc
		pop	ax
		pop	bx
		pop	cx
		pop	dx
		pop	si
		pop	di
		pop	bp
		pop	ds
		pop	es
		retn
sub_13688	endp


; =============== S U B	R O U T	I N E =======================================


sub_136A7	proc near		; CODE XREF: seg003:loc_133D9p
					; sub_134B6+Dp	...
		push	es
		push	ds
		push	bp
		push	di
		push	si
		push	dx
		push	cx
		push	bx
		push	ax
		push	dx
		push	cx
		push	bx
		push	cs
		call	near ptr sub_14016
		add	sp, 6
		clc
		pop	ax
		pop	bx
		pop	cx
		pop	dx
		pop	si
		pop	di
		pop	bp
		pop	ds
		pop	es
		retn
sub_136A7	endp


; =============== S U B	R O U T	I N E =======================================


sub_136C5	proc near		; CODE XREF: seg003:loc_133D9p
					; DATA XREF: seg003:off_133F7o
		push	es
		push	ds
		push	bp
		push	di
		push	si
		push	dx
		push	cx
		cmp	cs:byte_133AD, 0
		jnz	short loc_136DA
		xor	ax, ax
		mov	bx, ax
		jmp	short loc_13741
; ---------------------------------------------------------------------------

loc_136DA:				; CODE XREF: sub_136C5+Dj
		sub	sp, 4
		mov	bp, sp
		mov	word ptr [bp+2], 0C00Fh
		mov	word ptr [bp+0], 1
		push	cs
		call	near ptr sub_13DF3
		mov	word ptr [bp+2], 0Eh
		mov	word ptr [bp+0], 2
		push	cs
		call	near ptr sub_13DF3
		mov	bx, ax
		mov	word ptr [bp+2], 800Fh
		mov	word ptr [bp+0], 1
		push	cs
		call	near ptr sub_13DF3
		mov	word ptr [bp+2], 0Eh
		mov	word ptr [bp+0], 2
		push	cs
		call	near ptr sub_13DF3
		mov	cx, seg	seg007
		mov	ds, cx
		assume ds:seg007
		mov	ah, bl
		not	ax
		and	ax, 3F3Fh
		mov	bl, ah
		mov	bh, bl
		mov	ah, al
		mov	cx, word_40172
		not	cx
		and	ah, cl
		and	bh, ch
		mov	cl, al
		mov	ch, bl
		mov	word_40172, cx
		add	sp, 4
		clc

loc_13741:				; CODE XREF: sub_136C5+13j
		pop	cx
		pop	dx
		pop	si
		pop	di
		pop	bp
		pop	ds
		assume ds:nothing
		pop	es
		retn
sub_136C5	endp


; =============== S U B	R O U T	I N E =======================================


sub_13749	proc near		; CODE XREF: seg003:loc_133D9p
					; DATA XREF: seg003:off_133F7o
		mov	al, cs:byte_133AD
		retn
sub_13749	endp


; =============== S U B	R O U T	I N E =======================================


sub_1374E	proc near		; CODE XREF: seg003:loc_133D9p
					; DATA XREF: seg003:off_133F7o
		push	es
		push	ds
		push	bp
		push	di
		push	si
		push	dx
		push	cx
		push	bx
		push	bx
		push	cx
		push	cs
		call	near ptr sub_13DF3
		add	sp, 4
		clc
		pop	bx
		pop	cx
		pop	dx
		pop	si
		pop	di
		pop	bp
		pop	ds
		pop	es
		retn
sub_1374E	endp


; =============== S U B	R O U T	I N E =======================================


sub_13769	proc near		; CODE XREF: sub_1362F+28p
		push	ds
		push	bx
		push	ax
		xor	ax, ax
		mov	ds, ax
		assume ds:nothing
		mov	ax, cs
		mov	bx, 50h	; 'P'

loc_13775:				; CODE XREF: sub_13769+17j
		cmp	ax, [bx+2]
		jz	short loc_13784
		add	bx, 4
		cmp	bx, 54h	; 'T'
		jbe	short loc_13775
		ja	short loc_1379B

loc_13784:				; CODE XREF: sub_13769+Fj
		pushf
		cli
		mov	ax, [bx]
		mov	word ptr cs:dword_137E0, ax
		mov	ax, [bx+2]
		mov	word ptr cs:dword_137E0+2, ax
		mov	word ptr [bx], 557h
		mov	word ptr [bx+2], cs
		popf

loc_1379B:				; CODE XREF: sub_13769+19j
		shr	bx, 1
		shr	bx, 1
		cmp	bl, 15h
		jbe	short loc_137A6
		xor	bl, bl

loc_137A6:				; CODE XREF: sub_13769+39j
		mov	cs:byte_137E4, bl
		pop	ax
		pop	bx
		pop	ds
		assume ds:nothing
		retn
sub_13769	endp


; =============== S U B	R O U T	I N E =======================================


sub_137AF	proc near		; CODE XREF: sub_1366D+9p
		push	ds
		push	bx
		push	ax
		xor	bh, bh
		mov	bl, cs:byte_137E4
		shl	bx, 1
		shl	bx, 1
		jz	short loc_137D3
		pushf
		cli
		xor	ax, ax
		mov	ds, ax
		assume ds:nothing
		mov	ax, word ptr cs:dword_137E0
		mov	[bx], ax
		mov	ax, word ptr cs:dword_137E0+2
		mov	[bx+2],	ax
		popf

loc_137D3:				; CODE XREF: sub_137AF+Ej
		pop	ax
		pop	bx
		pop	ds
		assume ds:nothing
		retn
sub_137AF	endp

; ---------------------------------------------------------------------------
		jmp	short loc_137E6
; ---------------------------------------------------------------------------
aUsdtrap	db 'USDtrap'
dword_137E0	dd 0			; DATA XREF: sub_13769+1Fw
					; sub_137AF+16r ...
byte_137E4	db 0			; DATA XREF: sub_13769:loc_137A6w
					; sub_137AF+5r
		align 2

loc_137E6:				; CODE XREF: seg003:0557j
		jmp	cs:dword_137E0
; ---------------------------------------------------------------------------
		align 8
word_137F0	dw 0			; DATA XREF: sub_1383A+13w
					; sub_1392E+Ew	...
byte_137F2	db 0			; DATA XREF: sub_1383A+1Cw
					; sub_1392E+3Bw
byte_137F3	db 0			; DATA XREF: sub_1383A+B8w
		db 0F7h, 1, 0DFh, 0
byte_137F8	db 14h			; DATA XREF: sub_1383A+50w
					; sub_1383A+59r ...
byte_137F9	db 10h			; DATA XREF: sub_1383A+54w
					; sub_1383A+C8r ...
word_137FA	dw 0			; DATA XREF: sub_1383A+Dw
					; sub_1383A+D2w ...
dword_137FC	dd 0			; DATA XREF: sub_1383A+6Aw
					; sub_1392E+2Br ...
byte_13800	db 2 dup(0)		; DATA XREF: seg003:0744w
byte_13802	db 0			; DATA XREF: sub_1383A+C5w
aCopyrightCK_ko	db 'Copyright (C) K.KONDO 1991 All rights reserved...V01.02'

; =============== S U B	R O U T	I N E =======================================


sub_1383A	proc far		; CODE XREF: sub_1362F+25p
		push	bp
		push	si
		push	di
		push	ds
		push	es
		push	bx
		push	cx
		push	dx
		mov	ax, seg	seg003
		mov	ds, ax
		assume ds:seg003
		mov	word_137FA, 0
		mov	word_137F0, 0
		cli
		mov	bl, 0BFh ; 'ø'
		mov	byte_137F2, bl
		mov	al, 7
		mov	ah, bl
		mov	dx, 188h
		out	dx, al
		jmp	short $+2
		jmp	short $+2
		mov	dx, 18Ah
		mov	al, ah
		out	dx, al
		jmp	short $+2
		jmp	short $+2
		mov	al, 7
		mov	dx, 188h
		out	dx, al
		mov	dx, 18Ah
		in	al, dx
		cmp	al, bl
		jz	short loc_13881
		jmp	loc_13921
; ---------------------------------------------------------------------------

loc_13881:				; CODE XREF: sub_1383A+42j
		mov	al, 0Eh
		call	sub_14E1B
		test	al, 80h
		jnz	short loc_13892
		inc	byte_137F8
		shl	byte_137F9, 1

loc_13892:				; CODE XREF: sub_1383A+4Ej
		push	es
		mov	bl, byte_137F8
		xor	bh, bh
		shl	bx, 1
		shl	bx, 1
		xor	ax, ax
		mov	es, ax
		assume es:nothing
		mov	ax, es:[bx]
		mov	word ptr dword_137FC, ax
		mov	ax, es:[bx+2]
		mov	word ptr dword_137FC+2,	ax
		mov	word ptr es:[bx], 720h
		mov	word ptr es:[bx+2], seg	seg003
		pop	es
		assume es:nothing
		mov	al, 2Dh	; '-'
		call	sub_14E1B
		mov	bl, 0

loc_138C1:				; CODE XREF: sub_1383A+93j
		mov	al, 28h	; '('
		mov	ah, bl
		call	sub_14E35
		inc	bl
		cmp	bl, 3
		jb	short loc_138C1
		mov	bx, 1F7h
		mov	al, 24h	; '$'
		mov	ah, bl
		call	sub_14E35
		mov	al, 25h	; '%'
		mov	ah, bh
		call	sub_14E35
		mov	al, 26h	; '&'
		mov	ah, 0DFh ; 'ﬂ'
		call	sub_14E35
		mov	bl, 30h	; '0'
		mov	al, 27h	; '''
		mov	ah, bl
		call	sub_14E35
		mov	bl, 0Fh
		mov	byte_137F3, bl
		mov	al, 27h	; '''
		mov	ah, bl
		call	sub_14E35
		in	al, 0Ah		; DMA controller, 8237A-5.
					; single mask bit register
					; 0-1: select channel (00=0; 01=1; 10=2; 11=3)
					; 2: 1=set mask	for channel; 0=clear mask (enable)
		mov	byte_13802, al
		mov	ah, byte_137F9
		not	ah
		and	al, ah
		out	0Ah, al		; DMA controller, 8237A-5.
					; single mask bit register
					; 0-1: select channel (00=0; 01=1; 10=2; 11=3)
					; 2: 1=set mask	for channel; 0=clear mask (enable)
		inc	word_137FA
		mov	ax, 0
		push	cs
		call	near ptr sub_13F62
		push	ax
		push	ax
		push	ax
		push	cs
		call	near ptr sub_14016
		add	sp, 6

loc_13921:				; CODE XREF: sub_1383A+44j
		mov	ax, word_137FA
		sti
		pop	dx
		pop	cx
		pop	bx
		pop	es
		pop	ds
		assume ds:nothing
		pop	di
		pop	si
		pop	bp
		retf
sub_1383A	endp


; =============== S U B	R O U T	I N E =======================================


sub_1392E	proc far		; CODE XREF: sub_1366D+Dp
		push	bp
		push	si
		push	di
		push	ds
		push	es
		push	ax
		push	bx
		push	cx
		push	dx
		mov	ax, seg	seg003
		mov	ds, ax
		assume ds:seg003
		mov	word_137F0, 0
		cmp	word_137FA, 0
		jz	short loc_13996
		cli
		push	es
		mov	bl, byte_137F8
		xor	bh, bh
		shl	bx, 1
		shl	bx, 1
		xor	ax, ax
		mov	es, ax
		assume es:nothing
		mov	ax, word ptr dword_137FC
		mov	es:[bx], ax
		mov	ax, word ptr dword_137FC+2
		mov	es:[bx+2], ax
		pop	es
		assume es:nothing
		mov	bl, 0BFh ; 'ø'
		mov	byte_137F2, bl
		mov	al, 7
		mov	ah, bl
		call	sub_14E35
		mov	bl, 30h	; '0'
		mov	al, 27h	; '''
		mov	ah, bl
		call	sub_14E35
		mov	bl, 0

loc_1397F:				; CODE XREF: sub_1392E+5Dj
		mov	al, 28h	; '('
		mov	ah, bl
		call	sub_14E35
		inc	bl
		cmp	bl, 3
		jb	short loc_1397F
		in	al, 0Ah		; DMA controller, 8237A-5.
					; single mask bit register
					; 0-1: select channel (00=0; 01=1; 10=2; 11=3)
					; 2: 1=set mask	for channel; 0=clear mask (enable)
		or	al, byte_137F9
		out	0Ah, al		; DMA controller, 8237A-5.
					; single mask bit register
					; 0-1: select channel (00=0; 01=1; 10=2; 11=3)
					; 2: 1=set mask	for channel; 0=clear mask (enable)
		sti

loc_13996:				; CODE XREF: sub_1392E+19j
		pop	dx
		pop	cx
		pop	bx
		pop	ax
		pop	es
		pop	ds
		assume ds:nothing
		pop	di
		pop	si
		pop	bp
		retf
sub_1392E	endp

; ---------------------------------------------------------------------------
		push	ax
		push	bx
		push	cx
		push	dx
		push	bp
		push	si
		push	di
		push	ds
		push	es
		mov	ax, cs
		mov	ds, ax
		assume ds:seg003
		mov	es, ax
		assume es:seg003
		in	al, 0Ah		; DMA controller, 8237A-5.
					; single mask bit register
					; 0-1: select channel (00=0; 01=1; 10=2; 11=3)
					; 2: 1=set mask	for channel; 0=clear mask (enable)
		or	al, byte_137F9
		out	0Ah, al		; DMA controller, 8237A-5.
					; single mask bit register
					; 0-1: select channel (00=0; 01=1; 10=2; 11=3)
					; 2: 1=set mask	for channel; 0=clear mask (enable)
		pushf
		call	dword_137FC
		sti
		inc	word_137F0
		call	sub_139E8
		mov	byte_13800+1, al
		push	cs
		call	near ptr sub_1405A
		cli
		mov	word_137F0, 0
		in	al, 0Ah		; DMA controller, 8237A-5.
					; single mask bit register
					; 0-1: select channel (00=0; 01=1; 10=2; 11=3)
					; 2: 1=set mask	for channel; 0=clear mask (enable)
		mov	ah, byte_137F9
		not	ah
		and	al, ah
		out	0Ah, al		; DMA controller, 8237A-5.
					; single mask bit register
					; 0-1: select channel (00=0; 01=1; 10=2; 11=3)
					; 2: 1=set mask	for channel; 0=clear mask (enable)
		pop	es
		assume es:nothing
		pop	ds
		assume ds:nothing
		pop	di
		pop	si
		pop	bp
		pop	dx
		pop	cx
		pop	bx
		pop	ax
		iret

; =============== S U B	R O U T	I N E =======================================


sub_139E8	proc near		; CODE XREF: seg003:0741p
		test	word ptr ds:574h, 8000h
		jz	short loc_13A0A
		mov	bx, ds:574h
		and	bx, 3FFh
		mov	ds:574h, bx
		mov	al, 24h	; '$'
		mov	ah, bl
		call	sub_14E35
		mov	al, 25h	; '%'
		mov	ah, bh
		call	sub_14E35

loc_13A0A:				; CODE XREF: sub_139E8+6j
		xor	al, al
		push	ax
		jmp	short loc_13A24
; ---------------------------------------------------------------------------

loc_13A0F:				; CODE XREF: sub_139E8+47j
		shl	al, 1
		shl	al, 1
		shl	al, 1
		shl	al, 1
		or	al, ds:573h
		mov	bl, al
		mov	al, 27h	; '''
		mov	ah, bl
		call	sub_14E35

loc_13A24:				; CODE XREF: sub_139E8+25j
		call	ReadFM
		and	al, 3
		jz	short loc_13A31
		pop	bx
		or	bl, al
		push	bx
		jmp	short loc_13A0F
; ---------------------------------------------------------------------------

loc_13A31:				; CODE XREF: sub_139E8+41j
		pop	ax
		retn
sub_139E8	endp

; ---------------------------------------------------------------------------
		align 10h
		dw 192,	144, 96, 72, 48, 36, 24, 18, 12, 9, 6
		dw	0,   25h,   4Ch,   75h,	 0A1h,	0CFh,  100h,  134h,  16Bh,  1A6h,  1E4h,  225h
		dw   26Ah,  28Fh,  2B6h,  2DFh,	 30Bh,	339h,  36Ah,  39Eh,  3D5h,  410h,  44Eh,  48Fh
		dw   4D4h,  4F9h,  520h,  549h,	 575h,	5A3h,  5D4h,  608h,  63Fh,  67Ah,  6B8h,  6F9h
		dw   73Eh,  763h,  78Ah,  7B3h,	 7DFh,	80Dh,  83Eh,  872h,  8A9h,  8E4h,  922h,  963h
		dw   9A8h,  9CDh,  9F4h, 0A1Dh,	0A49h, 0A77h, 0AA8h, 0ADCh, 0B13h, 0B4Eh, 0B8Ch, 0BCDh
		dw  0C12h, 0C37h, 0C5Eh, 0C87h,	0CB3h, 0CE1h, 0D12h, 0D46h, 0D7Dh, 0DB8h, 0DF6h, 0E37h
		dw  0E7Ch, 0EA1h, 0EC8h, 0EF1h,	0F1Dh, 0F4Bh, 0F7Ch, 0FB0h, 0FE7h, 1022h, 1060h, 10A1h
		dw  10E6h, 110Bh, 1132h, 115Bh,	1187h, 11B5h, 11E6h, 121Ah, 1251h, 128Ch, 12CAh, 130Bh
word_13B16	dw  0EE8h, 0E12h, 0D48h, 0C89h,	0BD5h, 0B2Bh, 0A8Ah,  9F3h,  964h,  8DDh,  85Eh,  7E6h
		dw   774h,  709h,  6A4h,  644h,	 5EAh,	595h,  545h,  4F9h,  4B2h,  46Fh,  42Fh,  3F3h
		dw   3BAh,  384h,  352h,  322h,	 2F5h,	2CBh,  2A3h,  27Dh,  259h,  237h,  217h,  1F9h
		dw   1DDh,  1C2h,  1A9h,  191h,	 17Bh,	165h,  151h,  13Eh,  12Dh,  11Ch,  10Ch,  0FDh
		dw   0EFh,  0E1h,  0D4h,  0C9h,	 0BDh,	0B3h,  0A9h,   9Fh,   96h,   8Eh,   86h,   7Eh
		dw    77h,   71h,   6Ah,   64h,	  5Fh,	 59h,	54h,   50h,   4Bh,   47h,   43h,   3Fh
		dw    3Ch,   38h,   35h,   32h,	  2Fh,	 2Dh,	2Ah,   28h,   26h,   23h,   21h,   20h
		dw    1Eh,   1Ch,   1Bh,   19h,	  18h,	 16h,	15h,   14h,   13h,   12h,   11h,   10h
		db 21Bh	dup(0)
		dw 0FFFFh

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_13DF3	proc far		; CODE XREF: sub_136C5+25p
					; sub_136C5+33p ...

arg_0		= word ptr  6
arg_2		= word ptr  8

		push	bp
		mov	bp, sp
		push	ds
		push	ax
		mov	ax, seg	seg003
		mov	ds, ax
		assume ds:seg003
		cmp	word_137FA, 0
		jnz	short loc_13E08
		pop	ax
		pop	ds
		assume ds:nothing
		pop	bp
		retf
; ---------------------------------------------------------------------------

loc_13E08:				; CODE XREF: sub_13DF3+Fj
		mov	ax, [bp+arg_0]
		cmp	ax, 1
		jz	short loc_13E33
		cmp	ax, 2
		jz	short loc_13E42
		cmp	ax, 0
		jnz	short loc_13E3E
		push	dx
		pushf
		cli
		mov	dl, ds:572h
		mov	ax, [bp+arg_2]
		and	al, dl
		or	ah, al
		mov	ds:572h, ah
		mov	al, 7
		call	sub_14E35
		jmp	short loc_13E3C
; ---------------------------------------------------------------------------

loc_13E33:				; CODE XREF: sub_13DF3+1Bj
		push	dx
		pushf
		cli
		mov	ax, [bp+arg_2]
		call	sub_14E35

loc_13E3C:				; CODE XREF: sub_13DF3+3Ej
		popf
		pop	dx

loc_13E3E:				; CODE XREF: sub_13DF3+25j
		pop	ax
		pop	ds
		pop	bp
		retf
; ---------------------------------------------------------------------------

loc_13E42:				; CODE XREF: sub_13DF3+20j
		push	dx
		pushf
		cli
		mov	ax, [bp+arg_2]
		call	sub_14E1B
		popf
		pop	dx
		pop	ds
		pop	ds
		pop	bp
		retf
sub_13DF3	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_13E51	proc far		; CODE XREF: sub_1357E+9Ep

arg_2		= word ptr  8
arg_4		= word ptr  0Ah
arg_6		= word ptr  0Ch

		push	bp
		mov	bp, sp
		push	ds
		push	ax
		mov	ax, seg	seg003
		mov	ds, ax
		assume ds:seg003
		cmp	word_137FA, 0
		jnz	short loc_13E66
		pop	ax
		pop	ds
		assume ds:nothing
		pop	bp
		retf
; ---------------------------------------------------------------------------

loc_13E66:				; CODE XREF: sub_13E51+Fj
		push	bx
		push	cx
		push	dx
		push	es
		push	si
		push	di
		mov	cx, [bp+arg_2]
		and	cx, cx
		jz	short loc_13EC0
		cmp	cx, 6
		jb	short loc_13E7B
		mov	cx, 6

loc_13E7B:				; CODE XREF: sub_13E51+25j
		mov	ax, [bp+arg_6]
		mov	es, ax
		mov	si, [bp+arg_4]
		cld
		pushf
		cli
		push	bp
		push	si
		push	cx

loc_13E89:				; CODE XREF: sub_13E51+52j
		push	cx
		lods	word ptr es:[si]
		mov	cl, al
		inc	cl
		mov	al, ah
		and	al, al
		jz	short loc_13E9F
		push	es
		push	si
		call	sub_13F98
		pop	si
		pop	es
		jb	short loc_13EA7

loc_13E9F:				; CODE XREF: sub_13E51+43j
		add	si, 8
		pop	cx
		loop	loc_13E89
		jmp	short loc_13EAE
; ---------------------------------------------------------------------------

loc_13EA7:				; CODE XREF: sub_13E51+4Cj
		pop	cx
		pop	cx
		pop	si
		pop	bp
		popf
		jmp	short loc_13EC0
; ---------------------------------------------------------------------------

loc_13EAE:				; CODE XREF: sub_13E51+54j
		pop	cx
		pop	si
		pop	bp
		push	bp
		call	sub_13ECA
		pop	bp
		mov	cx, [bp+arg_2]
		mov	si, [bp+arg_4]
		call	sub_13EDF
		popf

loc_13EC0:				; CODE XREF: sub_13E51+20j
					; sub_13E51+5Bj
		pop	di
		pop	si
		pop	es
		pop	dx
		pop	cx
		pop	bx
		pop	ax
		pop	ds
		pop	bp
		retf
sub_13E51	endp


; =============== S U B	R O U T	I N E =======================================


sub_13ECA	proc near		; CODE XREF: sub_13E51+61p
					; sub_13ECA+12j
		push	cx
		lods	word ptr es:[si]
		mov	cl, al
		inc	cl
		push	es
		push	si
		call	sub_13FC6
		pop	si
		pop	es
		add	si, 8
		pop	cx
		loop	sub_13ECA
		retn
sub_13ECA	endp


; =============== S U B	R O U T	I N E =======================================


sub_13EDF	proc near		; CODE XREF: sub_13E51+6Bp
					; sub_13EDF+3Ej
		lods	word ptr es:[si]
		call	sub_13FF1
		mov	[bx+2],	al
		mov	[bx+3],	ah
		lods	word ptr es:[si]
		mov	[bx+14h], ax
		mov	[bx+16h], ax
		lods	word ptr es:[si]
		mov	[bx+18h], ax
		lods	word ptr es:[si]
		mov	[bx+1Ah], ax
		lods	word ptr es:[si]
		mov	[bx+1Ch], ax
		mov	word ptr [bx+0Ch], 1
		mov	byte ptr [bx+1], 0
		mov	byte ptr [bx+7], 0
		mov	word ptr [bx+20h], 0
		mov	word ptr [bx+22h], 0
		mov	ax, [bp+6]
		mov	[bx], al
		loop	sub_13EDF
		retn
sub_13EDF	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_13F20	proc far		; CODE XREF: sub_13688+Bp

arg_0		= word ptr  6

		push	bp
		mov	bp, sp
		push	ds
		push	ax
		mov	ax, seg	seg003
		mov	ds, ax
		assume ds:seg003
		cmp	word_137FA, 0
		jnz	short loc_13F35
		pop	ax
		pop	ds
		assume ds:nothing
		pop	bp
		retf
; ---------------------------------------------------------------------------

loc_13F35:				; CODE XREF: sub_13F20+Fj
		push	bx
		push	cx
		push	dx
		push	es
		push	si
		push	di
		mov	ax, [bp+arg_0]
		mov	cx, 6
		cld
		pushf
		cli
		and	ax, ax
		jz	short loc_13F51

loc_13F48:				; CODE XREF: sub_13F20+2Dj
		push	ax
		call	sub_13FB0
		pop	ax
		loop	loc_13F48
		jmp	short loc_13F56
; ---------------------------------------------------------------------------

loc_13F51:				; CODE XREF: sub_13F20+26j
					; sub_13F20+34j
		call	sub_13FC6
		loop	loc_13F51

loc_13F56:				; CODE XREF: sub_13F20+2Fj
		sti
		popf
		pop	di
		pop	si
		pop	es
		pop	dx
		pop	cx
		pop	bx
		pop	ax
		pop	ds
		pop	bp
		retf
sub_13F20	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_13F62	proc far		; CODE XREF: sub_1383A+DAp
		push	bp
		mov	bp, sp
		push	ds
		push	ax
		mov	ax, seg	seg003
		mov	ds, ax
		assume ds:seg003
		push	bx
		push	cx
		push	dx
		mov	cx, 6
		mov	dl, 24h	; '$'
		cld
		pushf
		cli

loc_13F77:				; CODE XREF: sub_13F62:loc_13F8Ej
		mov	al, cl
		dec	al
		call	sub_13FF1
		mov	byte ptr [bx], 0
		mov	[bx+2],	al
		cmp	cl, 3
		jbe	short loc_13F8E
		mov	[bx+3Ah], dl
		shr	dl, 1

loc_13F8E:				; CODE XREF: sub_13F62+25j
		loop	loc_13F77
		popf
		pop	dx
		pop	cx
		pop	bx
		pop	ax
		pop	ds
		assume ds:nothing
		pop	bp
		retf
sub_13F62	endp


; =============== S U B	R O U T	I N E =======================================


sub_13F98	proc near		; CODE XREF: sub_13E51+47p
		push	ax
		mov	al, cl
		dec	al
		call	sub_13FF1
		cmp	byte ptr [bx], 0
		jz	short loc_13FAD
		pop	ax
		cmp	al, [bx+3]
		jnb	short loc_13FAE
		stc
		retn
; ---------------------------------------------------------------------------

loc_13FAD:				; CODE XREF: sub_13F98+Bj
		pop	ax

loc_13FAE:				; CODE XREF: sub_13F98+11j
		clc
		retn
sub_13F98	endp


; =============== S U B	R O U T	I N E =======================================


sub_13FB0	proc near		; CODE XREF: sub_13F20+29p
		push	ax
		mov	al, cl
		dec	al
		call	sub_13FF1
		cmp	byte ptr [bx], 0
		jz	short loc_13FC4
		pop	ax
		cmp	al, [bx+3]
		jnb	short loc_13FD2
		retn
; ---------------------------------------------------------------------------

loc_13FC4:				; CODE XREF: sub_13FB0+Bj
		pop	ax
		retn
sub_13FB0	endp


; =============== S U B	R O U T	I N E =======================================


sub_13FC6	proc near		; CODE XREF: sub_13ECA+9p
					; sub_13F20:loc_13F51p
		mov	al, cl
		dec	al
		call	sub_13FF1
		cmp	byte ptr [bx], 0
		jz	short locret_13FF0

loc_13FD2:				; CODE XREF: sub_13FB0+11j
		mov	ax, 0B71h
		mov	[bx+14h], ax
		mov	[bx+16h], ax
		mov	ax, seg	seg003
		mov	[bx+18h], ax
		push	cx
		cmp	cl, 3
		ja	short loc_13FEC
		call	sub_14948
		jmp	short loc_13FEF
; ---------------------------------------------------------------------------

loc_13FEC:				; CODE XREF: sub_13FC6+1Fj
		call	sub_14A52

loc_13FEF:				; CODE XREF: sub_13FC6+24j
		pop	cx

locret_13FF0:				; CODE XREF: sub_13FC6+Aj
		retn
sub_13FC6	endp


; =============== S U B	R O U T	I N E =======================================


sub_13FF1	proc near		; CODE XREF: sub_13EDF+2p
					; sub_13F62+19p ...
		cmp	al, 3
		jge	short loc_14005
		mov	bx, 57h	; 'W'
		push	ax
		xor	ah, ah
		mul	bx
		add	ax, 956h
		mov	bx, ax
		pop	ax
		jmp	short locret_14015
; ---------------------------------------------------------------------------

loc_14005:				; CODE XREF: sub_13FF1+2j
		sub	al, 3
		mov	bx, 58h	; 'X'
		push	ax
		xor	ah, ah
		mul	bx
		add	ax, 0A5Bh
		mov	bx, ax
		pop	ax

locret_14015:				; CODE XREF: sub_13FF1+12j
		retn
sub_13FF1	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_14016	proc far		; CODE XREF: sub_136A7+Dp
					; sub_1383A+E1p

arg_0		= word ptr  6
arg_2		= word ptr  8
arg_4		= word ptr  0Ah

		push	bp
		mov	bp, sp
		push	ds
		push	ax
		mov	ax, seg	seg003
		mov	ds, ax
		assume ds:seg003
		cmp	word_137FA, 0
		jnz	short loc_1402B
		pop	ax
		pop	ds
		assume ds:nothing
		pop	bp
		retf
; ---------------------------------------------------------------------------

loc_1402B:				; CODE XREF: sub_14016+Fj
		pushf
		cli
		mov	ax, [bp+arg_0]
		cmp	ax, 0
		jz	short loc_14049
		mov	ds:0B69h, ax
		mov	ds:0B6Bh, ax
		mov	ax, [bp+arg_2]
		mov	ds:0B67h, ax
		mov	ax, [bp+arg_4]
		mov	ds:0B63h, al
		jmp	short loc_14055
; ---------------------------------------------------------------------------

loc_14049:				; CODE XREF: sub_14016+1Dj
		mov	ds:0B69h, ax
		mov	ds:0B6Bh, ax
		mov	ax, [bp+arg_2]
		mov	ds:0B65h, ax

loc_14055:				; CODE XREF: sub_14016+31j
		popf
		pop	ax
		pop	ds
		pop	bp
		retf
sub_14016	endp


; =============== S U B	R O U T	I N E =======================================


sub_1405A	proc far		; CODE XREF: seg003:0748p
		cld
		mov	bx, 956h
		mov	cx, 3
		jmp	short loc_1406B
; ---------------------------------------------------------------------------

loc_14063:				; CODE XREF: sub_1405A+17j
					; sub_1405A+28j ...
		pop	cx
		add	bx, 57h	; 'W'
		loop	loc_1406B
		jmp	short loc_140C4
; ---------------------------------------------------------------------------

loc_1406B:				; CODE XREF: sub_1405A+7j sub_1405A+Dj
		push	cx
		mov	al, ds:581h
		test	[bx], al
		jz	short loc_14063
		mov	ax, [bx+0Ch]
		dec	ax
		mov	[bx+0Ch], ax
		mov	ch, [bx+1]
		jz	short loc_140A1
		test	ch, 12h
		jnz	short loc_14063
		test	ch, 1
		jz	short loc_14063
		cmp	ax, [bx+0Eh]
		jnb	short loc_14063
		mov	ah, [bx+2]
		mov	al, 28h	; '('
		call	sub_14E35
		and	ch, 0FEh
		or	ch, 10h
		mov	[bx+1],	ch
		jmp	short loc_14063
; ---------------------------------------------------------------------------

loc_140A1:				; CODE XREF: sub_1405A+23j
		test	ch, 12h
		jnz	short loc_140B3
		test	ch, 1
		jz	short loc_140B6
		mov	ah, [bx+2]
		mov	al, 28h	; '('
		call	sub_14E35

loc_140B3:				; CODE XREF: sub_1405A+4Aj
		and	ch, 0FEh

loc_140B6:				; CODE XREF: sub_1405A+4Fj
		and	ch, 0EFh
		mov	[bx+1],	ch
		inc	word ptr [bx+0Ch]
		call	sub_14948
		jmp	short loc_14063
; ---------------------------------------------------------------------------

loc_140C4:				; CODE XREF: sub_1405A+Fj
		mov	bx, 0A5Bh
		mov	cx, 3

loc_140CA:				; CODE XREF: sub_1405A+C5j
		push	cx
		mov	al, ds:581h
		test	[bx], al
		jz	short loc_1411B
		mov	ax, [bx+0Ch]
		dec	ax
		mov	[bx+0Ch], ax
		mov	ch, [bx+1]
		jz	short loc_140FD
		test	ch, 12h
		jnz	short loc_1411B
		test	ch, 1
		jz	short loc_1411B
		cmp	ax, [bx+0Eh]
		jnb	short loc_1411B
		and	ch, 0FEh
		or	ch, 10h
		mov	[bx+1],	ch
		mov	word ptr [bx+30h], 6
		jmp	short loc_1411B
; ---------------------------------------------------------------------------

loc_140FD:				; CODE XREF: sub_1405A+82j
		test	ch, 12h
		jnz	short loc_1410C
		test	ch, 1
		jz	short loc_1410F
		mov	word ptr [bx+30h], 6

loc_1410C:				; CODE XREF: sub_1405A+A6j
		and	ch, 0FEh

loc_1410F:				; CODE XREF: sub_1405A+ABj
		and	ch, 0EFh
		mov	[bx+1],	ch
		inc	word ptr [bx+0Ch]
		call	sub_14A52

loc_1411B:				; CODE XREF: sub_1405A+76j
					; sub_1405A+87j ...
		pop	cx
		add	bx, 58h	; 'X'
		loop	loc_140CA
		test	byte ptr ds:581h, 2
		mov	byte ptr ds:581h, 0
		jnz	short loc_1412E
		retf
; ---------------------------------------------------------------------------

loc_1412E:				; CODE XREF: sub_1405A+D1j
		mov	bx, 956h
		mov	cx, 3

loc_14134:				; CODE XREF: sub_1405A+10Cj
		push	cx
		cmp	byte ptr [bx], 0
		jz	short loc_14162
		test	byte ptr [bx+1], 2
		jz	short loc_14150
		call	sub_141FD
		test	byte ptr [bx+1], 4
		jnz	short loc_14156
		mov	cx, ax
		call	sub_14493
		jmp	short loc_14159
; ---------------------------------------------------------------------------

loc_14150:				; CODE XREF: sub_1405A+E4j
		test	byte ptr [bx+1], 4
		jz	short loc_14159

loc_14156:				; CODE XREF: sub_1405A+EDj
		call	sub_1437B

loc_14159:				; CODE XREF: sub_1405A+F4j
					; sub_1405A+FAj
		test	byte ptr [bx+1], 8
		jz	short loc_14162
		call	sub_144B2

loc_14162:				; CODE XREF: sub_1405A+DEj
					; sub_1405A+103j
		pop	cx
		add	bx, 57h	; 'W'
		loop	loc_14134
		mov	bx, 0A5Bh
		mov	cx, 3

loc_1416E:				; CODE XREF: sub_1405A+152j
		push	cx
		cmp	byte ptr [bx], 0
		jz	short loc_141A8
		test	byte ptr [bx+1], 2
		jz	short loc_1418A
		call	sub_141FD
		test	byte ptr [bx+1], 4
		jnz	short loc_14190
		mov	cx, ax
		call	sub_146DE
		jmp	short loc_14193
; ---------------------------------------------------------------------------

loc_1418A:				; CODE XREF: sub_1405A+11Ej
		test	byte ptr [bx+1], 4
		jz	short loc_14193

loc_14190:				; CODE XREF: sub_1405A+127j
		call	sub_145C6

loc_14193:				; CODE XREF: sub_1405A+12Ej
					; sub_1405A+134j
		test	byte ptr [bx+1], 8
		jz	short loc_1419C
		call	sub_1470F

loc_1419C:				; CODE XREF: sub_1405A+13Dj
		test	byte ptr [bx+1], 20h
		jz	short loc_141A5
		call	sub_14815

loc_141A5:				; CODE XREF: sub_1405A+146j
		call	sub_1427D

loc_141A8:				; CODE XREF: sub_1405A+118j
		pop	cx
		add	bx, 58h	; 'X'
		loop	loc_1416E
		cmp	word ptr ds:0B69h, 0
		jz	short locret_141FC
		dec	word ptr ds:0B6Bh
		jnz	short locret_141FC
		mov	ax, ds:0B69h
		mov	ds:0B6Bh, ax
		mov	ax, ds:0B67h
		cmp	ax, 0
		jg	short loc_141E7
		jl	short loc_141D3
		mov	word ptr ds:0B69h, 0
		jmp	short locret_141FC
; ---------------------------------------------------------------------------

loc_141D3:				; CODE XREF: sub_1405A+16Fj
		add	ax, ds:0B65h
		cmp	ax, 0FFC0h
		jg	short loc_141F9
		mov	ax, 0FFC0h
		mov	word ptr ds:0B69h, 0
		jmp	short loc_141F9
; ---------------------------------------------------------------------------

loc_141E7:				; CODE XREF: sub_1405A+16Dj
		add	ax, ds:0B65h
		cmp	ax, 0
		jl	short loc_141F9
		mov	ax, 0
		mov	word ptr ds:0B69h, 0

loc_141F9:				; CODE XREF: sub_1405A+180j
					; sub_1405A+18Bj ...
		mov	ds:0B65h, ax

locret_141FC:				; CODE XREF: sub_1405A+159j
					; sub_1405A+15Fj ...
		retf
sub_1405A	endp


; =============== S U B	R O U T	I N E =======================================


sub_141FD	proc near		; CODE XREF: sub_1405A+E6p
					; sub_1405A+120p
		mov	ax, [bx+10h]
		cmp	ax, [bx+12h]
		ja	short loc_14208
		jb	short loc_14217
		retn
; ---------------------------------------------------------------------------

loc_14208:				; CODE XREF: sub_141FD+6j
		sub	ax, [bx+8]
		cmp	ax, [bx+12h]
		jnb	short loc_14213
		mov	ax, [bx+12h]

loc_14213:				; CODE XREF: sub_141FD+11j
		mov	[bx+10h], ax
		retn
; ---------------------------------------------------------------------------

loc_14217:				; CODE XREF: sub_141FD+8j
		add	ax, [bx+8]
		cmp	ax, [bx+12h]
		jbe	short loc_14222
		mov	ax, [bx+12h]

loc_14222:				; CODE XREF: sub_141FD+20j
		mov	[bx+10h], ax
		retn
sub_141FD	endp


; =============== S U B	R O U T	I N E =======================================


sub_14226	proc near		; CODE XREF: sub_144B2+3Bp
					; sub_144B2+6Fp ...
		mov	ah, [bx+3]
		cmp	ah, ds:0B63h
		jb	short loc_14233
		add	cx, ds:0B65h

loc_14233:				; CODE XREF: sub_14226+7j
		push	bx
		mov	bp, bx
		mov	ah, [bx+49h]
		mov	bh, [bx+2]
		add	bh, 40h	; '@'
		mov	bl, 4
		neg	cx

loc_14243:				; CODE XREF: sub_14226+49j
		shr	ah, 1
		jnb	short loc_14269
		push	ax
		push	cx
		mov	al, ds:[bp+34h]
		cbw
		add	cx, ax
		cmp	cx, 0
		jg	short loc_14259
		mov	cl, 0
		jmp	short loc_14260
; ---------------------------------------------------------------------------

loc_14259:				; CODE XREF: sub_14226+2Dj
		cmp	cx, 7Fh	; ''
		jle	short loc_14260
		mov	cl, 7Fh	; ''

loc_14260:				; CODE XREF: sub_14226+31j
					; sub_14226+36j
		mov	al, bh
		mov	ah, cl
		call	sub_14E35
		pop	cx
		pop	ax

loc_14269:				; CODE XREF: sub_14226+1Fj
		inc	bp
		add	bh, 4
		dec	bl
		jnz	short loc_14243
		pop	bx
		retn
sub_14226	endp

; ---------------------------------------------------------------------------
off_14273	dw offset loc_14288	; DATA XREF: sub_1427D+6r
		dw offset loc_142A4
		dw offset loc_142BE
		dw offset loc_142C3
		dw offset loc_142DF

; =============== S U B	R O U T	I N E =======================================


sub_1427D	proc near		; CODE XREF: sub_1405A:loc_141A5p
					; sub_14A52+DFp
		mov	bp, [bx+30h]
		and	bp, 0Eh
		jmp	cs:off_14273[bp]

loc_14288:				; DATA XREF: seg003:off_14273o
		mov	ch, 0
		mov	ah, ch
		mov	cl, [bx+3Eh]
		add	cx, [bx+32h]
		mov	al, [bx+3Ch]
		cmp	cx, ax
		jl	short loc_1429F
		add	word ptr [bx+30h], 2
		mov	cx, ax

loc_1429F:				; CODE XREF: sub_1427D+1Aj
		mov	[bx+32h], cx
		jmp	short loc_142E2
; ---------------------------------------------------------------------------

loc_142A4:				; CODE XREF: sub_1427D+6j
					; DATA XREF: seg003:0FF5o
		mov	cx, [bx+32h]
		mov	al, [bx+3Fh]
		mov	ah, 0
		sub	cx, ax
		mov	al, [bx+3Dh]
		cmp	cx, ax
		jg	short loc_142B9
		add	word ptr [bx+30h], 2

loc_142B9:				; CODE XREF: sub_1427D+36j
		mov	[bx+32h], cx
		jmp	short loc_142E2
; ---------------------------------------------------------------------------

loc_142BE:				; CODE XREF: sub_1427D+6j
					; DATA XREF: seg003:0FF7o
		mov	al, [bx+40h]
		jmp	short loc_142C6
; ---------------------------------------------------------------------------

loc_142C3:				; CODE XREF: sub_1427D+6j
					; DATA XREF: seg003:0FF9o
		mov	al, [bx+41h]

loc_142C6:				; CODE XREF: sub_1427D+44j
		mov	ah, 0
		mov	cx, [bx+32h]
		sub	cx, ax
		jg	short loc_142DA
		mov	word ptr [bx+30h], 8
		mov	cx, 0
		call	sub_1434D

loc_142DA:				; CODE XREF: sub_1427D+50j
		mov	[bx+32h], cx
		jmp	short loc_142E2
; ---------------------------------------------------------------------------

loc_142DF:				; CODE XREF: sub_1427D+6j
					; DATA XREF: seg003:0FFBo
		mov	cx, 0

loc_142E2:				; CODE XREF: sub_1427D+25j
					; sub_1427D+3Fj ...
		mov	ah, [bx+3]
		cmp	ah, ds:0B63h
		jb	short loc_142F3
		add	cx, ds:0B65h
		add	cx, ds:0B65h

loc_142F3:				; CODE XREF: sub_1427D+6Cj
		add	cx, [bx+0Ah]
		add	cx, [bx+2Eh]
		mov	al, 8
		add	al, [bx+2]
		sar	cx, 1
		sar	cx, 1
		sar	cx, 1
		sar	cx, 1
		cmp	cx, 0
		jge	short loc_14310
		mov	cx, 0
		jmp	short loc_14318
; ---------------------------------------------------------------------------

loc_14310:				; CODE XREF: sub_1427D+8Cj
		cmp	cx, 10h
		jl	short loc_14318
		mov	cx, 0Fh

loc_14318:				; CODE XREF: sub_1427D+91j
					; sub_1427D+96j
		mov	ah, cl
		call	sub_14E35
		retn
sub_1427D	endp

; ---------------------------------------------------------------------------
		db 9, 12h, 24h
; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_14A52

loc_14321:				; CODE XREF: sub_14A52+E2j
		push	cx
		push	bx
		mov	bl, [bx+2]
		xor	bh, bh
		add	bx, 109Eh
		mov	cl, [bx]
		pop	bx
		mov	ch, ds:572h
		or	ch, cl
		mov	cl, [bx+3Ah]
		not	cl
		and	ch, cl
		mov	ds:572h, ch
		mov	al, 7
		mov	ah, ch
		call	sub_14E35
		or	byte ptr [bx+1], 1
		pop	cx
		retn
; END OF FUNCTION CHUNK	FOR sub_14A52

; =============== S U B	R O U T	I N E =======================================


sub_1434D	proc near		; CODE XREF: sub_1427D+5Ap
					; sub_14A52+CDp ...
		push	cx
		mov	al, ds:572h
		mov	cl, [bx+3Ah]
		or	cl, al
		mov	ds:572h, cl
		mov	al, 7
		mov	ah, cl
		call	sub_14E35
		and	byte ptr [bx+1], 0FEh
		mov	al, [bx+2]
		add	al, 8
		xor	cl, cl
		mov	ah, cl
		call	sub_14E35
		pop	cx
		retn
sub_1434D	endp

; ---------------------------------------------------------------------------
off_14373	dw offset loc_14392	; DATA XREF: sub_1437B+12r
		dw offset loc_143C2
		dw offset loc_14409
		dw offset loc_14462

; =============== S U B	R O U T	I N E =======================================


sub_1437B	proc near		; CODE XREF: sub_1405A:loc_14156p
		cmp	byte ptr [bx+25h], 0
		jz	short loc_14385
		dec	byte ptr [bx+25h]
		retn
; ---------------------------------------------------------------------------

loc_14385:				; CODE XREF: sub_1437B+4j
		mov	al, [bx+4Bh]
		and	ax, 6
		mov	bp, ax
		jmp	cs:off_14373[bp]

loc_14392:				; DATA XREF: seg003:off_14373o
		cmp	byte ptr [bx+24h], 0
		jnz	short loc_143A6
		inc	byte ptr [bx+24h]
		mov	al, [bx+4Dh]
		mov	[bx+26h], al
		mov	word ptr [bx+28h], 0

loc_143A6:				; CODE XREF: sub_1437B+1Bj
		dec	byte ptr [bx+26h]
		jz	short loc_143AC
		retn
; ---------------------------------------------------------------------------

loc_143AC:				; CODE XREF: sub_1437B+2Ej
		mov	cx, [bx+4Fh]
		add	cx, [bx+28h]
		mov	[bx+28h], cx
		add	cx, [bx+10h]
		call	sub_14493
		mov	al, [bx+4Dh]
		mov	[bx+26h], al
		retn
; ---------------------------------------------------------------------------

loc_143C2:				; CODE XREF: sub_1437B+12j
					; DATA XREF: seg003:10F5o
		cmp	byte ptr [bx+24h], 0
		jnz	short loc_143DC
		inc	byte ptr [bx+24h]
		mov	al, [bx+4Dh]
		mov	[bx+26h], al
		mov	al, [bx+4Eh]
		mov	[bx+27h], al
		mov	word ptr [bx+28h], 0

loc_143DC:				; CODE XREF: sub_1437B+4Bj
		dec	byte ptr [bx+26h]
		jz	short loc_143E2
		retn
; ---------------------------------------------------------------------------

loc_143E2:				; CODE XREF: sub_1437B+64j
		mov	cx, [bx+4Fh]
		add	cx, [bx+28h]
		mov	[bx+28h], cx
		add	cx, [bx+10h]
		call	sub_14493
		mov	al, [bx+4Dh]
		mov	[bx+26h], al
		dec	byte ptr [bx+27h]
		jz	short loc_143FD
		retn
; ---------------------------------------------------------------------------

loc_143FD:				; CODE XREF: sub_1437B+7Fj
		mov	word ptr [bx+28h], 0
		mov	al, [bx+4Eh]
		mov	[bx+27h], al
		retn
; ---------------------------------------------------------------------------

loc_14409:				; CODE XREF: sub_1437B+12j
					; DATA XREF: seg003:10F7o
		cmp	byte ptr [bx+24h], 0
		jnz	short loc_14429
		inc	byte ptr [bx+24h]
		mov	al, [bx+4Dh]
		mov	[bx+26h], al
		mov	al, [bx+4Eh]
		shr	al, 1
		jnz	short loc_14421
		inc	al

loc_14421:				; CODE XREF: sub_1437B+A2j
		mov	[bx+27h], al
		mov	word ptr [bx+28h], 0

loc_14429:				; CODE XREF: sub_1437B+92j
		dec	byte ptr [bx+26h]
		jz	short loc_1442F
		retn
; ---------------------------------------------------------------------------

loc_1442F:				; CODE XREF: sub_1437B+B1j
		mov	cx, [bx+4Fh]
		add	cx, [bx+28h]
		mov	[bx+28h], cx
		cmp	byte ptr [bx+24h], 1
		jz	short loc_14440
		neg	cx

loc_14440:				; CODE XREF: sub_1437B+C1j
		add	cx, [bx+10h]
		call	sub_14493
		mov	al, [bx+4Dh]
		mov	[bx+26h], al
		dec	byte ptr [bx+27h]
		jz	short loc_14452
		retn
; ---------------------------------------------------------------------------

loc_14452:				; CODE XREF: sub_1437B+D4j
		mov	word ptr [bx+28h], 0
		mov	al, [bx+4Eh]
		mov	[bx+27h], al
		xor	byte ptr [bx+24h], 3
		retn
; ---------------------------------------------------------------------------

loc_14462:				; CODE XREF: sub_1437B+12j
					; DATA XREF: seg003:10F9o
		cmp	byte ptr [bx+24h], 0
		jnz	short loc_1447A

loc_14468:				; CODE XREF: sub_1437B+109j
		mov	byte ptr [bx+24h], 1
		mov	ax, [bx+4Dh]
		mov	[bx+26h], ax
		mov	cx, [bx+4Fh]
		add	cx, [bx+10h]
		jmp	short sub_14493
; ---------------------------------------------------------------------------

loc_1447A:				; CODE XREF: sub_1437B+EBj
		dec	byte ptr [bx+26h]
		jz	short loc_14480
		retn
; ---------------------------------------------------------------------------

loc_14480:				; CODE XREF: sub_1437B+102j
		cmp	byte ptr [bx+24h], 1
		jnz	short loc_14468
		mov	byte ptr [bx+24h], 2
		mov	ax, [bx+4Dh]
		mov	[bx+26h], ax
		mov	cx, [bx+10h]
sub_1437B	endp ; sp-analysis failed


; =============== S U B	R O U T	I N E =======================================


sub_14493	proc near		; CODE XREF: sub_1405A+F1p
					; sub_1437B+3Dp ...
		call	sub_14B5B
		mov	al, 0A4h ; '§'
		add	al, [bx+2]
		push	ax
		mov	ah, ch
		call	sub_14E35
		pop	ax
		sub	al, 4
		mov	ah, cl
		call	sub_14E35
		retn
sub_14493	endp

; ---------------------------------------------------------------------------
off_144AA	dw offset loc_144C9	; DATA XREF: sub_144B2+12r
		dw offset loc_144F7
		dw offset loc_1453D
		dw offset loc_1458F

; =============== S U B	R O U T	I N E =======================================


sub_144B2	proc near		; CODE XREF: sub_1405A+105p
		cmp	byte ptr [bx+2Bh], 0
		jz	short loc_144BC
		dec	byte ptr [bx+2Bh]
		retn
; ---------------------------------------------------------------------------

loc_144BC:				; CODE XREF: sub_144B2+4j
		mov	al, [bx+51h]
		and	ax, 6
		mov	bp, ax
		jmp	cs:off_144AA[bp]

loc_144C9:				; DATA XREF: seg003:off_144AAo
		cmp	byte ptr [bx+2Ah], 0
		jnz	short loc_144DE
		inc	byte ptr [bx+2Ah]
		mov	al, [bx+53h]
		mov	[bx+2Ch], al
		mov	cx, [bx+0Ah]
		mov	[bx+2Eh], cx

loc_144DE:				; CODE XREF: sub_144B2+1Bj
		dec	byte ptr [bx+2Ch]
		jz	short loc_144E4
		retn
; ---------------------------------------------------------------------------

loc_144E4:				; CODE XREF: sub_144B2+2Fj
		mov	cx, [bx+55h]
		add	cx, [bx+2Eh]
		mov	[bx+2Eh], cx
		call	sub_14226
		mov	al, [bx+53h]
		mov	[bx+2Ch], al
		retn
; ---------------------------------------------------------------------------

loc_144F7:				; CODE XREF: sub_144B2+12j
					; DATA XREF: seg003:122Co
		cmp	byte ptr [bx+2Ah], 0
		jnz	short loc_14512
		inc	byte ptr [bx+2Ah]
		mov	al, [bx+53h]
		mov	[bx+2Ch], al
		mov	al, [bx+54h]
		mov	[bx+2Dh], al
		mov	cx, [bx+0Ah]
		mov	[bx+2Eh], cx

loc_14512:				; CODE XREF: sub_144B2+49j
		dec	byte ptr [bx+2Ch]
		jz	short loc_14518
		retn
; ---------------------------------------------------------------------------

loc_14518:				; CODE XREF: sub_144B2+63j
		mov	cx, [bx+55h]
		add	cx, [bx+2Eh]
		mov	[bx+2Eh], cx
		call	sub_14226
		mov	al, [bx+53h]
		mov	[bx+2Ch], al
		dec	byte ptr [bx+2Dh]
		jz	short loc_14530
		retn
; ---------------------------------------------------------------------------

loc_14530:				; CODE XREF: sub_144B2+7Bj
		mov	cx, [bx+0Ah]
		mov	[bx+2Eh], cx
		mov	al, [bx+54h]
		mov	[bx+2Dh], al
		retn
; ---------------------------------------------------------------------------

loc_1453D:				; CODE XREF: sub_144B2+12j
					; DATA XREF: seg003:122Eo
		cmp	byte ptr [bx+2Ah], 0
		jnz	short loc_1455E
		inc	byte ptr [bx+2Ah]
		mov	al, [bx+53h]
		mov	[bx+2Ch], al
		mov	al, [bx+54h]
		shr	al, 1
		jnz	short loc_14555
		inc	al

loc_14555:				; CODE XREF: sub_144B2+9Fj
		mov	[bx+2Dh], al
		mov	cx, [bx+0Ah]
		mov	[bx+2Eh], cx

loc_1455E:				; CODE XREF: sub_144B2+8Fj
		dec	byte ptr [bx+2Ch]
		jz	short loc_14564
		retn
; ---------------------------------------------------------------------------

loc_14564:				; CODE XREF: sub_144B2+AFj
		mov	cx, [bx+55h]
		cmp	byte ptr [bx+2Ah], 1
		jz	short loc_1456F
		neg	cx

loc_1456F:				; CODE XREF: sub_144B2+B9j
		add	cx, [bx+2Eh]
		mov	[bx+2Eh], cx
		call	sub_14226
		mov	al, [bx+53h]
		mov	[bx+2Ch], al
		dec	byte ptr [bx+2Dh]
		jz	short loc_14584
		retn
; ---------------------------------------------------------------------------

loc_14584:				; CODE XREF: sub_144B2+CFj
		mov	al, [bx+54h]
		mov	[bx+2Dh], al
		xor	byte ptr [bx+2Ah], 3
		retn
; ---------------------------------------------------------------------------

loc_1458F:				; CODE XREF: sub_144B2+12j
					; DATA XREF: seg003:1230o
		cmp	byte ptr [bx+2Ah], 0
		jnz	short loc_145A1

loc_14595:				; CODE XREF: sub_144B2+F9j
		mov	byte ptr [bx+2Ah], 1
		mov	cx, [bx+55h]
		add	cx, [bx+0Ah]
		jmp	short loc_145B4
; ---------------------------------------------------------------------------

loc_145A1:				; CODE XREF: sub_144B2+E1j
		dec	byte ptr [bx+2Ch]
		jz	short loc_145A7
		retn
; ---------------------------------------------------------------------------

loc_145A7:				; CODE XREF: sub_144B2+F2j
		cmp	byte ptr [bx+2Ah], 1
		jnz	short loc_14595
		mov	byte ptr [bx+2Ah], 2
		mov	cx, [bx+0Ah]

loc_145B4:				; CODE XREF: sub_144B2+EDj
		mov	ax, [bx+53h]
		mov	[bx+2Ch], ax
		call	sub_14226
		retn
sub_144B2	endp

; ---------------------------------------------------------------------------
off_145BE	dw offset loc_145DD	; DATA XREF: sub_145C6+12r
		dw offset loc_1460D
		dw offset loc_14654
		dw offset loc_146AD

; =============== S U B	R O U T	I N E =======================================


sub_145C6	proc near		; CODE XREF: sub_1405A:loc_14190p
		cmp	byte ptr [bx+25h], 0
		jz	short loc_145D0
		dec	byte ptr [bx+25h]
		retn
; ---------------------------------------------------------------------------

loc_145D0:				; CODE XREF: sub_145C6+4j
		mov	al, [bx+46h]
		and	ax, 6
		mov	bp, ax
		jmp	cs:off_145BE[bp]

loc_145DD:				; DATA XREF: seg003:off_145BEo
		cmp	byte ptr [bx+24h], 0
		jnz	short loc_145F1
		inc	byte ptr [bx+24h]
		mov	al, [bx+48h]
		mov	[bx+26h], al
		mov	word ptr [bx+28h], 0

loc_145F1:				; CODE XREF: sub_145C6+1Bj
		dec	byte ptr [bx+26h]
		jz	short loc_145F7
		retn
; ---------------------------------------------------------------------------

loc_145F7:				; CODE XREF: sub_145C6+2Ej
		mov	cx, [bx+4Ah]
		add	cx, [bx+28h]
		mov	[bx+28h], cx
		add	cx, [bx+10h]
		call	sub_146DE
		mov	al, [bx+48h]
		mov	[bx+26h], al
		retn
; ---------------------------------------------------------------------------

loc_1460D:				; CODE XREF: sub_145C6+12j
					; DATA XREF: seg003:1340o
		cmp	byte ptr [bx+24h], 0
		jnz	short loc_14627
		inc	byte ptr [bx+24h]
		mov	al, [bx+48h]
		mov	[bx+26h], al
		mov	al, [bx+49h]
		mov	[bx+27h], al
		mov	word ptr [bx+28h], 0

loc_14627:				; CODE XREF: sub_145C6+4Bj
		dec	byte ptr [bx+26h]
		jz	short loc_1462D
		retn
; ---------------------------------------------------------------------------

loc_1462D:				; CODE XREF: sub_145C6+64j
		mov	cx, [bx+4Ah]
		add	cx, [bx+28h]
		mov	[bx+28h], cx
		add	cx, [bx+10h]
		call	sub_146DE
		mov	al, [bx+48h]
		mov	[bx+26h], al
		dec	byte ptr [bx+27h]
		jz	short loc_14648
		retn
; ---------------------------------------------------------------------------

loc_14648:				; CODE XREF: sub_145C6+7Fj
		mov	word ptr [bx+28h], 0
		mov	al, [bx+49h]
		mov	[bx+27h], al
		retn
; ---------------------------------------------------------------------------

loc_14654:				; CODE XREF: sub_145C6+12j
					; DATA XREF: seg003:1342o
		cmp	byte ptr [bx+24h], 0
		jnz	short loc_14674
		inc	byte ptr [bx+24h]
		mov	al, [bx+48h]
		mov	[bx+26h], al
		mov	al, [bx+49h]
		shr	al, 1
		jnz	short loc_1466C
		inc	al

loc_1466C:				; CODE XREF: sub_145C6+A2j
		mov	[bx+27h], al
		mov	word ptr [bx+28h], 0

loc_14674:				; CODE XREF: sub_145C6+92j
		dec	byte ptr [bx+26h]
		jz	short loc_1467A
		retn
; ---------------------------------------------------------------------------

loc_1467A:				; CODE XREF: sub_145C6+B1j
		mov	cx, [bx+4Ah]
		add	cx, [bx+28h]
		mov	[bx+28h], cx
		cmp	byte ptr [bx+24h], 1
		jz	short loc_1468B
		neg	cx

loc_1468B:				; CODE XREF: sub_145C6+C1j
		add	cx, [bx+10h]
		call	sub_146DE
		mov	al, [bx+48h]
		mov	[bx+26h], al
		dec	byte ptr [bx+27h]
		jz	short loc_1469D
		retn
; ---------------------------------------------------------------------------

loc_1469D:				; CODE XREF: sub_145C6+D4j
		mov	word ptr [bx+28h], 0
		mov	al, [bx+49h]
		mov	[bx+27h], al
		xor	byte ptr [bx+24h], 3
		retn
; ---------------------------------------------------------------------------

loc_146AD:				; CODE XREF: sub_145C6+12j
					; DATA XREF: seg003:1344o
		cmp	byte ptr [bx+24h], 0
		jnz	short loc_146C5

loc_146B3:				; CODE XREF: sub_145C6+109j
		mov	byte ptr [bx+24h], 1
		mov	ax, [bx+48h]
		mov	[bx+26h], ax
		mov	cx, [bx+4Ah]
		add	cx, [bx+10h]
		jmp	short sub_146DE
; ---------------------------------------------------------------------------

loc_146C5:				; CODE XREF: sub_145C6+EBj
		dec	byte ptr [bx+26h]
		jz	short loc_146CB
		retn
; ---------------------------------------------------------------------------

loc_146CB:				; CODE XREF: sub_145C6+102j
		cmp	byte ptr [bx+24h], 1
		jnz	short loc_146B3
		mov	byte ptr [bx+24h], 2
		mov	ax, [bx+48h]
		mov	[bx+26h], ax
		mov	cx, [bx+10h]
sub_145C6	endp ; sp-analysis failed


; =============== S U B	R O U T	I N E =======================================


sub_146DE	proc near		; CODE XREF: sub_1405A+12Bp
					; sub_145C6+3Dp ...
		cmp	cx, 1000h
		jl	short loc_146E9
		mov	cx, 0FFFh
		jmp	short loc_146F1
; ---------------------------------------------------------------------------

loc_146E9:				; CODE XREF: sub_146DE+4j
		cmp	cx, 0
		jge	short loc_146F1
		mov	cx, 0

loc_146F1:				; CODE XREF: sub_146DE+9j sub_146DE+Ej
		mov	al, [bx+2]
		shl	al, 1
		add	al, 0
		push	ax
		mov	ah, cl
		call	sub_14E35
		pop	ax
		inc	al
		mov	ah, ch
		call	sub_14E35
		retn
sub_146DE	endp

; ---------------------------------------------------------------------------
off_14707	dw offset loc_14726	; DATA XREF: sub_1470F+12r
		dw offset loc_14750
		dw offset loc_14791
		dw offset loc_147DF

; =============== S U B	R O U T	I N E =======================================


sub_1470F	proc near		; CODE XREF: sub_1405A+13Fp
		cmp	byte ptr [bx+2Bh], 0
		jz	short loc_14719
		dec	byte ptr [bx+2Bh]
		retn
; ---------------------------------------------------------------------------

loc_14719:				; CODE XREF: sub_1470F+4j
		mov	al, [bx+4Ch]
		and	ax, 6
		mov	bp, ax
		jmp	cs:off_14707[bp]

loc_14726:				; DATA XREF: seg003:off_14707o
		cmp	byte ptr [bx+2Ah], 0
		jnz	short loc_1473A
		inc	byte ptr [bx+2Ah]
		mov	al, [bx+4Eh]
		mov	[bx+2Ch], al
		mov	word ptr [bx+2Eh], 0

loc_1473A:				; CODE XREF: sub_1470F+1Bj
		dec	byte ptr [bx+2Ch]
		jz	short loc_14740
		retn
; ---------------------------------------------------------------------------

loc_14740:				; CODE XREF: sub_1470F+2Ej
		mov	cx, [bx+50h]
		add	cx, [bx+2Eh]
		mov	[bx+2Eh], cx
		mov	al, [bx+4Eh]
		mov	[bx+2Ch], al
		retn
; ---------------------------------------------------------------------------

loc_14750:				; CODE XREF: sub_1470F+12j
					; DATA XREF: seg003:1489o
		cmp	byte ptr [bx+2Ah], 0
		jnz	short loc_1476A
		inc	byte ptr [bx+2Ah]
		mov	al, [bx+4Eh]
		mov	[bx+2Ch], al
		mov	al, [bx+4Fh]
		mov	[bx+2Dh], al
		mov	word ptr [bx+2Eh], 0

loc_1476A:				; CODE XREF: sub_1470F+45j
		dec	byte ptr [bx+2Ch]
		jz	short loc_14770
		retn
; ---------------------------------------------------------------------------

loc_14770:				; CODE XREF: sub_1470F+5Ej
		mov	cx, [bx+50h]
		add	cx, [bx+2Eh]
		mov	[bx+2Eh], cx
		mov	al, [bx+4Eh]
		mov	[bx+2Ch], al
		dec	byte ptr [bx+2Dh]
		jz	short loc_14785
		retn
; ---------------------------------------------------------------------------

loc_14785:				; CODE XREF: sub_1470F+73j
		mov	word ptr [bx+2Eh], 0
		mov	al, [bx+4Fh]
		mov	[bx+2Dh], al
		retn
; ---------------------------------------------------------------------------

loc_14791:				; CODE XREF: sub_1470F+12j
					; DATA XREF: seg003:148Bo
		cmp	byte ptr [bx+2Ah], 0
		jnz	short loc_147B1
		inc	byte ptr [bx+2Ah]
		mov	al, [bx+4Eh]
		mov	[bx+2Ch], al
		mov	al, [bx+4Fh]
		shr	al, 1
		jnz	short loc_147A9
		inc	al

loc_147A9:				; CODE XREF: sub_1470F+96j
		mov	[bx+2Dh], al
		mov	word ptr [bx+2Eh], 0

loc_147B1:				; CODE XREF: sub_1470F+86j
		dec	byte ptr [bx+2Ch]
		jz	short loc_147B7
		retn
; ---------------------------------------------------------------------------

loc_147B7:				; CODE XREF: sub_1470F+A5j
		mov	cx, [bx+50h]
		cmp	byte ptr [bx+2Ah], 1
		jz	short loc_147C2
		neg	cx

loc_147C2:				; CODE XREF: sub_1470F+AFj
		add	cx, [bx+2Eh]
		mov	[bx+2Eh], cx
		mov	al, [bx+4Eh]
		mov	[bx+2Ch], al
		dec	byte ptr [bx+2Dh]
		jz	short loc_147D4
		retn
; ---------------------------------------------------------------------------

loc_147D4:				; CODE XREF: sub_1470F+C2j
		mov	al, [bx+4Fh]
		mov	[bx+2Dh], al
		xor	byte ptr [bx+2Ah], 3
		retn
; ---------------------------------------------------------------------------

loc_147DF:				; CODE XREF: sub_1470F+12j
					; DATA XREF: seg003:148Do
		cmp	byte ptr [bx+2Ah], 0
		jnz	short loc_147F1

loc_147E5:				; CODE XREF: sub_1470F+ECj
		mov	byte ptr [bx+2Ah], 1
		mov	cx, [bx+50h]
		mov	[bx+2Eh], cx
		jmp	short loc_14806
; ---------------------------------------------------------------------------

loc_147F1:				; CODE XREF: sub_1470F+D4j
		dec	byte ptr [bx+2Ch]
		jz	short loc_147F7
		retn
; ---------------------------------------------------------------------------

loc_147F7:				; CODE XREF: sub_1470F+E5j
		cmp	byte ptr [bx+2Ah], 1
		jnz	short loc_147E5
		mov	byte ptr [bx+2Ah], 2
		mov	word ptr [bx+2Eh], 0

loc_14806:				; CODE XREF: sub_1470F+E0j
		mov	ax, [bx+4Eh]
		mov	[bx+2Ch], ax
		retn
sub_1470F	endp

; ---------------------------------------------------------------------------
off_1480D	dw offset loc_1482C	; DATA XREF: sub_14815+12r
		dw offset loc_14859
		dw offset loc_1489D
		dw offset loc_148F3

; =============== S U B	R O U T	I N E =======================================


sub_14815	proc near		; CODE XREF: sub_1405A+148p
		cmp	byte ptr [bx+35h], 0
		jz	short loc_1481F
		dec	byte ptr [bx+35h]
		retn
; ---------------------------------------------------------------------------

loc_1481F:				; CODE XREF: sub_14815+4j
		mov	al, [bx+52h]
		and	ax, 6
		mov	bp, ax
		jmp	cs:off_1480D[bp]

loc_1482C:				; DATA XREF: seg003:off_1480Do
		cmp	byte ptr [bx+34h], 0
		jnz	short loc_14840
		inc	byte ptr [bx+34h]
		mov	al, [bx+54h]
		mov	[bx+36h], al
		mov	word ptr [bx+38h], 0

loc_14840:				; CODE XREF: sub_14815+1Bj
		dec	byte ptr [bx+36h]
		jz	short loc_14846
		retn
; ---------------------------------------------------------------------------

loc_14846:				; CODE XREF: sub_14815+2Ej
		mov	cx, [bx+56h]
		add	cx, [bx+38h]
		mov	[bx+38h], cx
		call	sub_14920
		mov	al, [bx+54h]
		mov	[bx+36h], al
		retn
; ---------------------------------------------------------------------------

loc_14859:				; CODE XREF: sub_14815+12j
					; DATA XREF: seg003:158Fo
		cmp	byte ptr [bx+34h], 0
		jnz	short loc_14873
		inc	byte ptr [bx+34h]
		mov	al, [bx+54h]
		mov	[bx+36h], al
		mov	al, [bx+55h]
		mov	[bx+37h], al
		mov	word ptr [bx+38h], 0

loc_14873:				; CODE XREF: sub_14815+48j
		dec	byte ptr [bx+36h]
		jz	short loc_14879
		retn
; ---------------------------------------------------------------------------

loc_14879:				; CODE XREF: sub_14815+61j
		mov	cx, [bx+56h]
		add	cx, [bx+38h]
		mov	[bx+38h], cx
		call	sub_14920
		mov	al, [bx+54h]
		mov	[bx+36h], al
		dec	byte ptr [bx+37h]
		jz	short loc_14891
		retn
; ---------------------------------------------------------------------------

loc_14891:				; CODE XREF: sub_14815+79j
		mov	word ptr [bx+38h], 0
		mov	al, [bx+55h]
		mov	[bx+37h], al
		retn
; ---------------------------------------------------------------------------

loc_1489D:				; CODE XREF: sub_14815+12j
					; DATA XREF: seg003:1591o
		cmp	byte ptr [bx+34h], 0
		jnz	short loc_148BD
		inc	byte ptr [bx+34h]
		mov	al, [bx+54h]
		mov	[bx+36h], al
		mov	al, [bx+55h]
		shr	al, 1
		jnz	short loc_148B5
		inc	al

loc_148B5:				; CODE XREF: sub_14815+9Cj
		mov	[bx+37h], al
		mov	word ptr [bx+38h], 0

loc_148BD:				; CODE XREF: sub_14815+8Cj
		dec	byte ptr [bx+36h]
		jz	short loc_148C3
		retn
; ---------------------------------------------------------------------------

loc_148C3:				; CODE XREF: sub_14815+ABj
		mov	cx, [bx+56h]
		cmp	byte ptr [bx+34h], 1
		jz	short loc_148CE
		neg	cx

loc_148CE:				; CODE XREF: sub_14815+B5j
		add	cx, [bx+38h]
		mov	[bx+38h], cx
		call	sub_14920
		mov	al, [bx+54h]
		mov	[bx+36h], al
		dec	byte ptr [bx+37h]
		jz	short loc_148E3
		retn
; ---------------------------------------------------------------------------

loc_148E3:				; CODE XREF: sub_14815+CBj
		mov	word ptr [bx+38h], 0
		mov	al, [bx+55h]
		mov	[bx+37h], al
		xor	byte ptr [bx+34h], 3
		retn
; ---------------------------------------------------------------------------

loc_148F3:				; CODE XREF: sub_14815+12j
					; DATA XREF: seg003:1593o
		cmp	byte ptr [bx+34h], 0
		jnz	short loc_14908

loc_148F9:				; CODE XREF: sub_14815+FDj
		mov	byte ptr [bx+34h], 1
		mov	ax, [bx+54h]
		mov	[bx+36h], ax
		mov	cx, [bx+56h]
		jmp	short sub_14920
; ---------------------------------------------------------------------------

loc_14908:				; CODE XREF: sub_14815+E2j
		dec	byte ptr [bx+36h]
		jz	short loc_1490E
		retn
; ---------------------------------------------------------------------------

loc_1490E:				; CODE XREF: sub_14815+F6j
		cmp	byte ptr [bx+34h], 1
		jnz	short loc_148F9
		mov	byte ptr [bx+34h], 2
		mov	ax, [bx+54h]
		mov	[bx+36h], ax
		xor	cx, cx
sub_14815	endp ; sp-analysis failed


; =============== S U B	R O U T	I N E =======================================


sub_14920	proc near		; CODE XREF: sub_14815+3Ap
					; sub_14815+6Dp ...
		sar	cx, 1
		sar	cx, 1
		sar	cx, 1
		sar	cx, 1
		add	cl, [bx+3Bh]
		adc	ch, 0
		cmp	cx, 20h	; ' '
		jl	short loc_14938
		mov	cx, 1Fh
		jmp	short loc_14940
; ---------------------------------------------------------------------------

loc_14938:				; CODE XREF: sub_14920+11j
		cmp	cx, 0
		jge	short loc_14940
		mov	cx, 0

loc_14940:				; CODE XREF: sub_14920+16j
					; sub_14920+1Bj
		mov	al, 6
		mov	ah, cl
		call	sub_14E35
		retn
sub_14920	endp


; =============== S U B	R O U T	I N E =======================================


sub_14948	proc near		; CODE XREF: sub_13FC6+21p
					; sub_1405A+65p
		mov	ax, [bx+18h]
		mov	es, ax
		mov	si, [bx+16h]

loc_14950:				; CODE XREF: sub_14948+18j
		lods	byte ptr es:[si]
		cmp	al, 0B0h ; '∞'
		jb	short loc_14962
		cmp	al, 0C0h ; '¿'
		jnb	short loc_1495D
		jmp	loc_14A29
; ---------------------------------------------------------------------------

loc_1495D:				; CODE XREF: sub_14948+10j
		call	sub_14C5E
		jmp	short loc_14950
; ---------------------------------------------------------------------------

loc_14962:				; CODE XREF: sub_14948+Cj
		mov	di, ax
		shr	di, 1
		shr	di, 1
		shr	di, 1
		and	di, 1Eh
		mov	cx, [di+7C0h]

loc_14971:				; CODE XREF: sub_14948+F4j
		and	al, 0Fh
		jnz	short loc_14978
		jmp	loc_14A3F
; ---------------------------------------------------------------------------

loc_14978:				; CODE XREF: sub_14948+2Bj
		mov	dl, al
		add	dl, [bx+6]
		mov	[bx+4],	dl
		cmp	dl, 0
		jge	short loc_14989
		mov	dl, 0
		jmp	short loc_14990
; ---------------------------------------------------------------------------

loc_14989:				; CODE XREF: sub_14948+3Bj
		cmp	dl, 60h	; '`'
		jl	short loc_14990
		mov	dl, 5Fh	; '_'

loc_14990:				; CODE XREF: sub_14948+3Fj
					; sub_14948+44j
		and	dx, 0FFh
		shl	dx, 1
		mov	di, dx
		mov	ax, [di+7D6h]
		mov	[bx+0Ch], cx
		push	ax
		call	sub_14B97
		pop	cx
		mov	[bx+16h], si
		mov	al, [bx+7]
		cbw
		add	cx, ax
		test	byte ptr [bx+1], 2
		jnz	short loc_149B8
		mov	[bx+10h], cx
		jmp	short loc_149C7
; ---------------------------------------------------------------------------

loc_149B8:				; CODE XREF: sub_14948+69j
		cmp	word ptr [bx+12h], 0
		jnz	short loc_149C1
		mov	[bx+10h], cx

loc_149C1:				; CODE XREF: sub_14948+74j
		mov	[bx+12h], cx
		mov	cx, [bx+10h]

loc_149C7:				; CODE XREF: sub_14948+6Ej
		call	sub_14B5B
		mov	al, 0A4h ; '§'
		add	al, [bx+2]
		push	ax
		mov	ah, ch
		call	sub_14E35
		pop	ax
		sub	al, 4
		mov	ah, cl
		call	sub_14E35
		mov	cl, [bx+4Ah]
		and	cl, 0F0h
		mov	ch, [bx+2]
		test	byte ptr [bx+1], 4
		jz	short loc_149F6
		mov	byte ptr [bx+24h], 0
		mov	al, [bx+4Ch]
		mov	[bx+25h], al

loc_149F6:				; CODE XREF: sub_14948+A2j
		test	byte ptr [bx+1], 8
		jz	short loc_14A06
		mov	byte ptr [bx+2Ah], 0
		mov	al, [bx+52h]
		mov	[bx+2Bh], al

loc_14A06:				; CODE XREF: sub_14948+B2j
		test	byte ptr [bx+1], 1
		jz	short loc_14A13
		mov	al, 28h	; '('
		mov	ah, ch
		call	sub_14E35

loc_14A13:				; CODE XREF: sub_14948+C2j
		push	cx
		mov	cx, [bx+0Ah]
		call	sub_14226
		pop	cx
		or	cl, ch
		mov	al, 28h	; '('
		mov	ah, cl
		call	sub_14E35
		or	byte ptr [bx+1], 1
		retn
; ---------------------------------------------------------------------------

loc_14A29:				; CODE XREF: sub_14948+12j
		push	ax
		xor	ah, ah
		lods	byte ptr es:[si]
		test	al, 80h
		jz	short loc_14A36
		mov	ah, al
		lods	byte ptr es:[si]

loc_14A36:				; CODE XREF: sub_14948+E8j
		and	ax, 7FFFh
		mov	cx, ax
		pop	ax
		jmp	loc_14971
; ---------------------------------------------------------------------------

loc_14A3F:				; CODE XREF: sub_14948+2Dj
		mov	ah, [bx+2]
		mov	al, 28h	; '('
		call	sub_14E35
		and	byte ptr [bx+1], 0FEh
		mov	[bx+0Ch], cx
		mov	[bx+16h], si
		retn
sub_14948	endp


; =============== S U B	R O U T	I N E =======================================


sub_14A52	proc near		; CODE XREF: sub_13FC6:loc_13FECp
					; sub_1405A+BEp

; FUNCTION CHUNK AT 10A1 SIZE 0000002C BYTES

		mov	ax, [bx+18h]
		mov	es, ax
		mov	si, [bx+16h]

loc_14A5A:				; CODE XREF: sub_14A52+18j
		lods	byte ptr es:[si]
		cmp	al, 0B0h ; '∞'
		jb	short loc_14A6C
		cmp	al, 0C0h ; '¿'
		jnb	short loc_14A67
		jmp	loc_14B37
; ---------------------------------------------------------------------------

loc_14A67:				; CODE XREF: sub_14A52+10j
		call	sub_14C70
		jmp	short loc_14A5A
; ---------------------------------------------------------------------------

loc_14A6C:				; CODE XREF: sub_14A52+Cj
		mov	di, ax
		shr	di, 1
		shr	di, 1
		shr	di, 1
		and	di, 1Eh
		mov	cx, [di+7C0h]

loc_14A7B:				; CODE XREF: sub_14A52+F8j
		and	al, 0Fh
		jnz	short loc_14A82
		jmp	loc_14B4D
; ---------------------------------------------------------------------------

loc_14A82:				; CODE XREF: sub_14A52+2Bj
		mov	dl, al
		add	dl, [bx+6]
		mov	[bx+4],	dl
		cmp	dl, 0Ch
		jge	short loc_14A93
		mov	dl, 0Ch
		jmp	short loc_14A9A
; ---------------------------------------------------------------------------

loc_14A93:				; CODE XREF: sub_14A52+3Bj
		cmp	dl, 6Ch	; 'l'
		jl	short loc_14A9A
		mov	dl, 6Bh	; 'k'

loc_14A9A:				; CODE XREF: sub_14A52+3Fj
					; sub_14A52+44j
		sub	dl, 0Ch
		and	dx, 0FFh
		shl	dx, 1
		mov	di, dx
		mov	ax, [di+896h]
		mov	[bx+0Ch], cx
		push	ax
		call	sub_14B97
		pop	cx
		call	sub_14B57
		mov	al, [bx+7]
		cbw
		add	cx, ax
		test	byte ptr [bx+1], 2
		jnz	short loc_14AC5
		mov	[bx+10h], cx
		jmp	short loc_14AD4
; ---------------------------------------------------------------------------

loc_14AC5:				; CODE XREF: sub_14A52+6Cj
		cmp	word ptr [bx+12h], 0
		jnz	short loc_14ACE
		mov	[bx+10h], cx

loc_14ACE:				; CODE XREF: sub_14A52+77j
		mov	[bx+12h], cx
		mov	cx, [bx+10h]

loc_14AD4:				; CODE XREF: sub_14A52+71j
		mov	al, [bx+2]
		shl	al, 1
		add	al, 0
		push	ax
		mov	ah, cl
		call	sub_14E35
		pop	ax
		inc	al
		mov	ah, ch
		call	sub_14E35
		test	byte ptr [bx+1], 4
		jz	short loc_14AF9
		mov	byte ptr [bx+24h], 0
		mov	al, [bx+47h]
		mov	[bx+25h], al

loc_14AF9:				; CODE XREF: sub_14A52+9Bj
		test	byte ptr [bx+1], 8
		jz	short loc_14B09
		mov	byte ptr [bx+2Ah], 0
		mov	al, [bx+4Dh]
		mov	[bx+2Bh], al

loc_14B09:				; CODE XREF: sub_14A52+ABj
		test	byte ptr [bx+1], 20h
		jz	short loc_14B19
		mov	byte ptr [bx+34h], 0
		mov	al, [bx+53h]
		mov	[bx+35h], al

loc_14B19:				; CODE XREF: sub_14A52+BBj
		test	byte ptr [bx+1], 1
		jz	short loc_14B22
		call	sub_1434D

loc_14B22:				; CODE XREF: sub_14A52+CBj
		mov	word ptr [bx+2Eh], 0
		mov	word ptr [bx+32h], 0
		mov	word ptr [bx+30h], 0
		call	sub_1427D
		jmp	loc_14321
; ---------------------------------------------------------------------------

loc_14B37:				; CODE XREF: sub_14A52+12j
		push	ax
		xor	ah, ah
		lods	byte ptr es:[si]
		test	al, 80h
		jz	short loc_14B44
		mov	ah, al
		lods	byte ptr es:[si]

loc_14B44:				; CODE XREF: sub_14A52+ECj
		and	ax, 7FFFh
		mov	cx, ax
		pop	ax
		jmp	loc_14A7B
; ---------------------------------------------------------------------------

loc_14B4D:				; CODE XREF: sub_14A52+2Dj
		call	sub_1434D
		and	byte ptr [bx+1], 0FEh
		mov	[bx+0Ch], cx
sub_14A52	endp ; sp-analysis failed


; =============== S U B	R O U T	I N E =======================================


sub_14B57	proc near		; CODE XREF: sub_14A52+5Fp
		mov	[bx+16h], si
		retn
sub_14B57	endp


; =============== S U B	R O U T	I N E =======================================


sub_14B5B	proc near		; CODE XREF: sub_14493p
					; sub_14948:loc_149C7p
		push	ax
		cmp	cx, 1350h
		jl	short loc_14B67
		mov	cx, 134Fh
		jmp	short loc_14B6F
; ---------------------------------------------------------------------------

loc_14B67:				; CODE XREF: sub_14B5B+5j
		cmp	cx, 0
		jge	short loc_14B6F
		mov	cx, 0

loc_14B6F:				; CODE XREF: sub_14B5B+Aj sub_14B5B+Fj
		xor	ax, ax

loc_14B71:				; CODE XREF: sub_14B5B+22j
		cmp	cx, 26Ah
		jl	short loc_14B7F
		sub	cx, 26Ah
		add	al, 8
		jmp	short loc_14B71
; ---------------------------------------------------------------------------

loc_14B7F:				; CODE XREF: sub_14B5B+1Aj
		add	cx, 26Ah
		or	ch, al
		pop	ax
		retn
sub_14B5B	endp

; ---------------------------------------------------------------------------
off_14B87	dw offset loc_14BA6	; DATA XREF: sub_14B97+Ar
		dw offset loc_14BAC
		dw offset loc_14BAE
		dw offset loc_14BB8
		dw offset loc_14BD8
		dw offset loc_14BC6
		dw offset loc_14BD6
		dw offset loc_14BD4

; =============== S U B	R O U T	I N E =======================================


sub_14B97	proc near		; CODE XREF: sub_14948+58p
					; sub_14A52+5Bp
		mov	ax, cx
		mov	dl, [bx+5]
		and	dx, 0Eh
		mov	di, dx
		jmp	cs:off_14B87[di]

loc_14BA6:				; DATA XREF: seg003:off_14B87o
		mov	word ptr [bx+0Eh], 0
		retn
; ---------------------------------------------------------------------------

loc_14BAC:				; CODE XREF: sub_14B97+Aj
					; DATA XREF: seg003:1909o
		shr	ax, 1

loc_14BAE:				; CODE XREF: sub_14B97+Aj
					; DATA XREF: seg003:190Bo
		shr	ax, 1
		shr	ax, 1
		sub	cx, ax
		mov	[bx+0Eh], cx
		retn
; ---------------------------------------------------------------------------

loc_14BB8:				; CODE XREF: sub_14B97+Aj
					; DATA XREF: seg003:190Do
		shr	ax, 1
		mov	cx, ax
		shr	ax, 1
		shr	ax, 1
		add	cx, ax
		mov	[bx+0Eh], cx
		retn
; ---------------------------------------------------------------------------

loc_14BC6:				; CODE XREF: sub_14B97+Aj
					; DATA XREF: seg003:1911o
		shr	ax, 1
		shr	ax, 1
		mov	cx, ax
		shr	ax, 1
		add	cx, ax
		mov	[bx+0Eh], cx
		retn
; ---------------------------------------------------------------------------

loc_14BD4:				; CODE XREF: sub_14B97+Aj
					; DATA XREF: seg003:1915o
		shr	ax, 1

loc_14BD6:				; CODE XREF: sub_14B97+Aj
					; DATA XREF: seg003:1913o
		shr	ax, 1

loc_14BD8:				; CODE XREF: sub_14B97+Aj
					; DATA XREF: seg003:190Fo
		shr	ax, 1
		mov	[bx+0Eh], ax
		retn
sub_14B97	endp

; ---------------------------------------------------------------------------
off_14BDE	dw offset loc_14C8C	; DATA XREF: sub_14C5E+Dr
		dw offset loc_14CAB	; jump table for switch	statement
		dw offset loc_14CC9
		dw offset loc_14CB1
		dw offset loc_14CB7
		dw offset locret_14C83
		dw offset locret_14C83
		dw offset loc_14CD0
		dw offset loc_14CD6
		dw offset loc_14CDB
		dw offset loc_14CF5
		dw offset loc_14CFA
		dw offset loc_14D19
		dw offset locret_14C83
		dw offset locret_14C83
		dw offset locret_14C83
		dw offset locret_14C83
		dw offset locret_14C83
		dw offset locret_14C83
		dw offset locret_14C83
		dw offset locret_14C83
		dw offset locret_14C83
		dw offset locret_14C83
		dw offset locret_14C83
		dw offset locret_14C83
		dw offset locret_14C83
		dw offset locret_14C83
		dw offset locret_14C83
		dw offset locret_14C83
		dw offset locret_14C83
		dw offset loc_14D3A
		dw offset loc_14DA9
off_14C1E	dw offset loc_14C9C	; DATA XREF: sub_14C70+Dr
		dw offset loc_14CAB	; jump table for switch	statement
		dw offset loc_14CC9
		dw offset loc_14CB1
		dw offset loc_14CB7
		dw offset locret_14C83
		dw offset locret_14C83
		dw offset loc_14CD0
		dw offset loc_14CD6
		dw offset loc_14CDB
		dw offset loc_14CF5
		dw offset loc_14CFA
		dw offset loc_14D19
		dw offset locret_14C83
		dw offset locret_14C83
		dw offset locret_14C83
		dw offset locret_14C83
		dw offset locret_14C83
		dw offset locret_14C83
		dw offset locret_14C83
		dw offset locret_14C83
		dw offset locret_14C83
		dw offset locret_14C83
		dw offset locret_14C83
		dw offset locret_14C83
		dw offset locret_14C83
		dw offset locret_14C83
		dw offset locret_14C83
		dw offset locret_14C83
		dw offset locret_14C83
		dw offset loc_14D3A
		dw offset loc_14DA9

; =============== S U B	R O U T	I N E =======================================


sub_14C5E	proc near		; CODE XREF: sub_14948:loc_1495Dp
		not	al
		xor	ah, ah
		cmp	ax, 1Fh		; switch 32 cases
		ja	short locret_14C83 ; jumptable 00014C6B	default	case
		mov	di, ax
		shl	di, 1
		jmp	cs:off_14BDE[di] ; switch jump
sub_14C5E	endp


; =============== S U B	R O U T	I N E =======================================


sub_14C70	proc near		; CODE XREF: sub_14A52:loc_14A67p
		not	al
		xor	ah, ah
		cmp	ax, 1Fh		; switch 32 cases
		ja	short locret_14C83 ; jumptable 00014C6B	default	case
		mov	di, ax
		shl	di, 1
		jmp	cs:off_14C1E[di] ; switch jump
; ---------------------------------------------------------------------------
		inc	si

locret_14C83:				; CODE XREF: sub_14C5E+7j sub_14C5E+Dj ...
		retn			; jumptable 00014C6B default case
; ---------------------------------------------------------------------------
		add	si, 2
		retn
; ---------------------------------------------------------------------------
		add	si, 4
		retn
; ---------------------------------------------------------------------------

loc_14C8C:				; CODE XREF: sub_14C5E+Dj
					; DATA XREF: seg003:off_14BDEo
		mov	ah, [bx+2]	; jumptable 00014C6B case 0
		mov	al, 28h	; '('
		call	sub_14E35
		mov	cx, 0FC00h
		call	sub_14226
		jmp	short loc_14C9F
; ---------------------------------------------------------------------------

loc_14C9C:				; CODE XREF: sub_14C70+Dj
					; DATA XREF: seg003:off_14C1Eo
		call	sub_1434D	; jumptable 00014C7D case 0

loc_14C9F:				; CODE XREF: sub_14C70+2Aj
		pop	ax
		xor	ax, ax
		mov	[bx+1],	al
		mov	[bx], al
		mov	[bx+12h], ax
		retn
; ---------------------------------------------------------------------------

loc_14CAB:				; CODE XREF: sub_14C5E+Dj sub_14C70+Dj
					; DATA XREF: ...
		lods	byte ptr es:[si] ; jumptable 00014C6B case 1
					; jumptable 00014C7D case 1
		mov	[bx+6],	al
		retn
; ---------------------------------------------------------------------------

loc_14CB1:				; CODE XREF: sub_14C5E+Dj sub_14C70+Dj
					; DATA XREF: ...
		lods	byte ptr es:[si] ; jumptable 00014C6B case 3
					; jumptable 00014C7D case 3
		mov	[bx+7],	al
		retn
; ---------------------------------------------------------------------------

loc_14CB7:				; CODE XREF: sub_14C5E+Dj sub_14C70+Dj
					; DATA XREF: ...
		lods	word ptr es:[si] ; jumptable 00014C6B case 4
					; jumptable 00014C7D case 4
		or	ax, 8000h
		test	byte ptr [bx], 1
		jz	short loc_14CC5
		mov	ds:574h, ax
		retn
; ---------------------------------------------------------------------------

loc_14CC5:				; CODE XREF: sub_14C70+4Fj
		mov	ds:576h, ax
		retn
; ---------------------------------------------------------------------------

loc_14CC9:				; CODE XREF: sub_14C5E+Dj sub_14C70+Dj
					; DATA XREF: ...
		lods	byte ptr es:[si] ; jumptable 00014C6B case 2
					; jumptable 00014C7D case 2
		cbw
		mov	[bx+0Ah], ax
		retn
; ---------------------------------------------------------------------------

loc_14CD0:				; CODE XREF: sub_14C5E+Dj sub_14C70+Dj
					; DATA XREF: ...
		lods	byte ptr es:[si] ; jumptable 00014C6B case 7
					; jumptable 00014C7D case 7
		mov	[bx+5],	al
		retn
; ---------------------------------------------------------------------------

loc_14CD6:				; CODE XREF: sub_14C5E+Dj sub_14C70+Dj
					; DATA XREF: ...
		or	byte ptr [bx+1], 10h ; jumptable 00014C6B case 8
					; jumptable 00014C7D case 8
		retn
; ---------------------------------------------------------------------------

loc_14CDB:				; CODE XREF: sub_14C5E+Dj sub_14C70+Dj
					; DATA XREF: ...
		lods	byte ptr es:[si] ; jumptable 00014C6B case 9
					; jumptable 00014C7D case 9
		and	al, al
		jz	short loc_14CF0
		xor	ah, ah
		mov	[bx+8],	ax
		mov	word ptr [bx+12h], 0
		or	byte ptr [bx+1], 2
		retn
; ---------------------------------------------------------------------------

loc_14CF0:				; CODE XREF: sub_14C70+6Fj
		and	byte ptr [bx+1], 0FDh
		retn
; ---------------------------------------------------------------------------

loc_14CF5:				; CODE XREF: sub_14C5E+Dj sub_14C70+Dj ...
		lods	word ptr es:[si] ; jumptable 00014C6B case 10
					; jumptable 00014C7D case 10
		add	si, ax
		retn
; ---------------------------------------------------------------------------

loc_14CFA:				; CODE XREF: sub_14C5E+Dj sub_14C70+Dj
					; DATA XREF: ...
		lods	byte ptr es:[si] ; jumptable 00014C6B case 11
					; jumptable 00014C7D case 11
		xor	ah, ah
		add	ax, bx
		add	ax, 20h	; ' '
		mov	di, ax
		cmp	byte ptr [di], 0
		jz	short loc_14D11
		inc	si
		dec	byte ptr [di]
		jnz	short loc_14D15
		jmp	short loc_14CF5	; jumptable 00014C6B case 10
					; jumptable 00014C7D case 10
; ---------------------------------------------------------------------------

loc_14D11:				; CODE XREF: sub_14C70+98j
		lods	byte ptr es:[si]
		mov	[di], al

loc_14D15:				; CODE XREF: sub_14C70+9Dj
		add	si, 2
		retn
; ---------------------------------------------------------------------------

loc_14D19:				; CODE XREF: sub_14C5E+Dj sub_14C70+Dj
					; DATA XREF: ...
		lods	byte ptr es:[si] ; jumptable 00014C6B case 12
					; jumptable 00014C7D case 12
		xor	ah, ah
		add	ax, bx
		add	ax, 20h	; ' '
		mov	di, ax
		cmp	byte ptr [di], 0
		jz	short loc_14D30
		inc	si
		dec	byte ptr [di]
		jz	short loc_14D36
		jmp	short loc_14CF5	; jumptable 00014C6B case 10
					; jumptable 00014C7D case 10
; ---------------------------------------------------------------------------

loc_14D30:				; CODE XREF: sub_14C70+B7j
		lods	byte ptr es:[si]
		mov	[di], al
		jmp	short loc_14CF5	; jumptable 00014C6B case 10
					; jumptable 00014C7D case 10
; ---------------------------------------------------------------------------

loc_14D36:				; CODE XREF: sub_14C70+BCj
		add	si, 2
		retn
; ---------------------------------------------------------------------------

loc_14D3A:				; CODE XREF: sub_14C5E+Dj sub_14C70+Dj
					; DATA XREF: ...
		and	byte ptr [bx+1], 0F3h ;	jumptable 00014C6B case	30
					; jumptable 00014C7D case 30
		lods	byte ptr es:[si]
		mov	di, bx
		add	di, 30h	; '0'
		push	si
		push	di
		push	es
		push	ds
		push	ds
		pop	es
		mov	cx, 27h	; '''
		and	ax, 0FFh
		mul	cx
		mov	si, ax
		add	si, [bx+1Ah]
		mov	ax, [bx+1Ch]
		mov	ds, ax
		cld
		rep movsb
		pop	ds
		pop	es
		pop	si
		mov	ah, 30h	; '0'
		add	ah, [bx+2]
		mov	cx, 18h

loc_14D6B:				; CODE XREF: sub_14C70+106j
		push	ax
		lodsb
		xchg	ah, al
		call	sub_14E35
		pop	ax
		add	ah, 4
		loop	loc_14D6B
		mov	cx, 4
		xchg	ah, al
		xor	ah, ah

loc_14D7F:				; CODE XREF: sub_14C70+116j
		push	ax
		call	sub_14E35
		pop	ax
		add	al, 4
		loop	loc_14D7F
		mov	ah, 0B0h ; '∞'
		add	ah, [bx+2]
		lodsb
		xchg	ah, al
		call	sub_14E35
		pop	si
		cmp	byte ptr [bx+4Bh], 0
		jz	short loc_14D9E
		or	byte ptr [bx+1], 4

loc_14D9E:				; CODE XREF: sub_14C70+128j
		cmp	byte ptr [bx+51h], 0
		jz	short locret_14DA8
		or	byte ptr [bx+1], 8

locret_14DA8:				; CODE XREF: sub_14C70+132j
		retn
; ---------------------------------------------------------------------------

loc_14DA9:				; CODE XREF: sub_14C5E+Dj sub_14C70+Dj
					; DATA XREF: ...
		and	byte ptr [bx+1], 0D3h ;	jumptable 00014C6B case	31
					; jumptable 00014C7D case 31
		lods	byte ptr es:[si]
		mov	di, bx
		add	di, 3Ah	; ':'
		push	si
		push	es
		push	ds
		push	ds
		pop	es
		mov	cx, 1Eh
		and	ax, 0FFh
		mul	cx
		mov	si, ax
		add	si, [bx+1Ah]
		mov	ax, [bx+1Ch]
		mov	ds, ax
		cld
		rep movsb
		pop	ds
		pop	es
		pop	si
		test	byte ptr [bx+3Ah], 8
		jz	short loc_14DE9
		mov	ah, [bx+3Bh]
		mov	al, 6
		call	sub_14E35
		cmp	byte ptr [bx+52h], 0
		jz	short loc_14DE9
		or	byte ptr [bx+1], 20h

loc_14DE9:				; CODE XREF: sub_14C70+165j
					; sub_14C70+173j
		cmp	byte ptr [bx+46h], 0
		jz	short loc_14DF3
		or	byte ptr [bx+1], 4

loc_14DF3:				; CODE XREF: sub_14C70+17Dj
		cmp	byte ptr [bx+4Ch], 0
		jz	short loc_14DFD
		or	byte ptr [bx+1], 8

loc_14DFD:				; CODE XREF: sub_14C70+187j
		mov	ah, [bx+2]
		cmp	ah, 0

loc_14E03:				; CODE XREF: sub_14C70+19Aj
		jz	short locret_14E0C
		shl	byte ptr [bx+3Ah], 1
		dec	ah
		jmp	short loc_14E03
; ---------------------------------------------------------------------------

locret_14E0C:				; CODE XREF: sub_14C70:loc_14E03j
		retn
sub_14C70	endp ; sp-analysis failed

; ---------------------------------------------------------------------------
		align 4

; =============== S U B	R O U T	I N E =======================================


WaitForFM	proc near		; CODE XREF: WaitForFM+6j sub_14E1B+1p ...
		mov	dx, 188h
		in	al, dx
		test	al, 80h
		jnz	short WaitForFM
		retn
WaitForFM	endp

; ---------------------------------------------------------------------------
FMDelay		dw offset sub_14E5E	; DATA XREF: sub_14E1B+6r sub_14E1B+Br ...

; =============== S U B	R O U T	I N E =======================================


sub_14E1B	proc near		; CODE XREF: sub_1383A+49p
					; sub_1383A+82p ...
		push	ax
		call	WaitForFM
		pop	ax
		out	dx, al
		call	cs:FMDelay
		call	cs:FMDelay
		mov	dx, 18Ah
		in	al, dx
		retn
sub_14E1B	endp


; =============== S U B	R O U T	I N E =======================================


ReadFM		proc near		; CODE XREF: sub_139E8:loc_13A24p
		mov	dx, 188h
		in	al, dx
		retn
ReadFM		endp


; =============== S U B	R O U T	I N E =======================================


sub_14E35	proc near		; CODE XREF: sub_1383A+8Bp
					; sub_1383A+9Cp ...
		push	ax
		call	WaitForFM
		pop	ax
		out	dx, al
		call	cs:FMDelay
		call	cs:FMDelay
		call	WaitForFM
		mov	dx, 18Ah
		mov	al, ah
		out	dx, al
		call	cs:FMDelay
		retn
sub_14E35	endp

; ---------------------------------------------------------------------------

loc_14E54:				; DATA XREF: sub_14E6B+Co
		jmp	short $+2
		jmp	short $+2
		jmp	short $+2
		jmp	short $+2
		jmp	short $+2

; =============== S U B	R O U T	I N E =======================================


sub_14E5E	proc near		; CODE XREF: sub_14E1B+6p sub_14E1B+Bp ...
		jmp	short $+2
		retn
sub_14E5E	endp

; ---------------------------------------------------------------------------

loc_14E61:				; DATA XREF: sub_14E6B+13o
		push	cx
		mov	cx, 6

loc_14E65:				; CODE XREF: seg003:1BE7j
		out	5Fh, al
		loop	loc_14E65
		pop	cx
		retn

; =============== S U B	R O U T	I N E =======================================


sub_14E6B	proc far		; CODE XREF: sub_1329C+2p
		mov	ah, 11h
		int	0F1h		; reserved for user interrupt
		push	dx
		mov	dx, offset sub_14E5E
		cmp	al, 4
		jb	short loc_14E81
		mov	dx, offset loc_14E54
		cmp	al, 5
		jb	short loc_14E81
		mov	dx, offset loc_14E61

loc_14E81:				; CODE XREF: sub_14E6B+Aj
					; sub_14E6B+11j
		mov	cs:FMDelay, dx
		pop	dx
		retf
sub_14E6B	endp

; ---------------------------------------------------------------------------
		align 10h
seg003		ends

; ===========================================================================

; Segment type:	Regular
seg004		segment	byte public 'UNK' use16
		assume cs:seg004
		assume es:nothing, ss:nothing, ds:nothing, fs:nothing, gs:nothing
byte_14E90	db 0FC60h dup(0)	; DATA XREF: seg002:0150r seg002:01B2r ...
seg004		ends

; ===========================================================================

; Segment type:	Regular
seg005		segment	byte public 'UNK' use16
		assume cs:seg005
		assume es:nothing, ss:nothing, ds:nothing, fs:nothing, gs:nothing
byte_24AF0	db 10000h dup(0)
seg005		ends

; ===========================================================================

; Segment type:	Regular
seg006		segment	byte public 'UNK' use16
		assume cs:seg006
		assume es:nothing, ss:nothing, ds:nothing, fs:nothing, gs:nothing
word_34AF0	dw 0			; DATA XREF: sub_12ED4+26w
					; sub_12ED4:loc_12FDDr
word_34AF2	dw 0			; DATA XREF: sub_12ED4+2Dw
					; sub_12ED4+113r
word_34AF4	dw 0			; DATA XREF: sub_12ED4+34w
					; sub_12ED4+11Dr
word_34AF6	dw 0			; DATA XREF: sub_12ED4+3Bw
					; sub_12ED4+127r
word_34AF8	dw 0			; DATA XREF: sub_12ED4+92w
					; sub_12ED4+106r
word_34AFA	dw 0			; DATA XREF: sub_12ED4+A1w
word_34AFC	dw 0			; DATA XREF: sub_12ED4+B0w
					; sub_12ED4+102r
word_34AFE	dw 0			; DATA XREF: sub_12ED4+B4w
					; sub_12ED4:loc_12F9Dr	...
word_34B00	dw 0			; DATA XREF: sub_12ED4+6Dw
					; sub_12ED4+A5r ...
word_34B02	dw 0			; DATA XREF: sub_12ED4+71w
					; sub_12ED4+F1w
word_34B04	dw 0			; DATA XREF: sub_12ED4+9Aw
					; sub_12ED4+E7r
word_34B06	dw 0			; DATA XREF: sub_12ED4+ABw
					; sub_12ED4+DAr
word_34B08	dw 0			; DATA XREF: sub_12ED4+BBw
word_34B0A	dw 0			; DATA XREF: sub_12ED4+C2w
		db 1E0h	dup(0)
word_34CEC	dw 3202h dup(0)		; DATA XREF: sub_12ED4+86w
					; sub_12ED4+FEr
seg006		ends

; ===========================================================================

; Segment type:	Regular
seg007		segment	byte public 'UNK' use16
		assume cs:seg007
		assume es:nothing, ss:nothing, ds:nothing, fs:nothing, gs:nothing
byte_3B0F0	db 5000h dup(0)
byte_400F0	db 0			; DATA XREF: sub_13329+Ew
					; sub_13460+14w ...
byte_400F1	db 0			; DATA XREF: sub_13329+11w
					; sub_1347B+14w ...
		db 78h dup(0)
word_4016A	dw 0			; DATA XREF: sub_1357E+38r
					; sub_1362F+12w
word_4016C	dw 0			; DATA XREF: sub_1357E+3Br
					; sub_1362F+Ew
word_4016E	dw 0			; DATA XREF: sub_1357E+3Fr
					; sub_1362F+1Aw
word_40170	dw 0			; DATA XREF: sub_1357E+43r
					; sub_1362F+16w
word_40172	dw 0			; DATA XREF: sub_1362F+1Ew
					; sub_136C5+66r ...
		align 10h
seg007		ends

; ===========================================================================

; Segment type:	Regular
seg008		segment	byte public 'UNK' use16
		assume cs:seg008
		assume es:nothing, ss:nothing, ds:nothing, fs:nothing, gs:nothing
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
aAdvbiosForPc98	db '+++  AdvBIOS for PC-9801V  +++',0
aCopyrightCTune	db 'Copyright(C) Tuneup 1991,92.',0
aCopyrightC1991	db 'Copyright(C) ±≤√ﬁΩ 1991,92.',0
aTuneup_	db '[[[ Tuneup. ]]]',0
a2j1h5hadvbiosF	db 1Bh,'[2J',1Bh,'[>1h',1Bh,'[>5hAdvBIOS for PC-9801V  $'
					; DATA XREF: DoMainInit+3o
aCopyrightCTu_0	db 0Dh,0Ah		; DATA XREF: DoMainInit+11o
		db 'Copyright(C) Tuneup 1991,92.',0Dh,'Copyright(C) ±≤√ﬁΩ 1991,92. ',0Dh,0Ah
		db 0Dh,0Ah,'$'
a1l5l		db 1Bh,'[>1l',1Bh,'[>5l$' ; DATA XREF: seg000:012Do
aVersion0_54	db 'Version 0.54$'      ; DATA XREF: DoMainInit+Ao
		db  90h	; ê
		db 'Adv98V.Ovl',0
		db    0
byte_4027A	db 0FFh			; DATA XREF: sub_10364w sub_103B4r ...
		db  90h	; ê
word_4027C	dw 0			; DATA XREF: sub_10364+Bw
					; sub_10364:loc_10373r	...
		align 4
word_40280	dw 0			; DATA XREF: sub_103CCr sub_103CC+Cw ...
word_40282	dw 1			; DATA XREF: RNGAdvance+Cr
					; RNGAdvance+15r ...
word_40284	dw 0			; DATA XREF: RNGAdvance+3r
					; RNGAdvance+21w
word_40286	dw 0			; DATA XREF: sub_1057E+27w
					; sub_1057E:loc_105B6r	...
word_40288	dw 0			; DATA XREF: sub_1057E+21w
					; sub_1057E:loc_105D4w	...
word_4028A	dw 0			; DATA XREF: sub_1057E+1Ew
					; sub_1057E+59w ...
jumpTbl_intF1	dw offset sub_101EC	; 0 ; DATA XREF: seg000:01DEr
		dw offset apiF1_01_GetRandom; 1
		dw offset apiF1_02_ShiftJIS2JIS; 2
		dw offset apiF1_03_JIS2ShiftJIS; 3
		dw offset sub_102A4	; 4
		dw offset sub_102AA	; 5
		dw offset sub_102B0	; 6
		dw offset sub_102FC	; 7
		dw offset sub_10364	; 8
		dw offset sub_103F0	; 9
		dw offset sub_1040E	; 0Ah
		dw offset sub_10438	; 0Bh
		dw offset sub_10462	; 0Ch
		dw offset sub_10518	; 0Dh
		dw offset sub_1057E	; 0Eh
		dw offset sub_10602	; 0Fh
		dw offset sub_10708	; 10h
		dw offset sub_10846	; 11h
		dw offset apiF1_SetError; 12h
aAskQuit	db 'Å@Å@Å@Å@Å@Å@Å@Å@Å@ÅsÅ@Å@èIóπÇµÇƒÇ‡ÇÊÇÎÇµÇ¢Ç≈Ç∑Ç©ÅiÇôÅ^ÇéÅjÅHÅ@Å@Å'
					; DATA XREF: sub_10602+88o
		db 'tÅ@Å@Å@Å@Å@Å@Å@'    ; << Shall we end the game here (y/n)? >>
word_40302	dw 0			; DATA XREF: SetupIntVecF1+34w
					; sub_131BA+6w	...
word_40304	dw 3			; DATA XREF: sub_12E9C+9r
					; sub_12E9C+12w ...
byte_40306	db 10h			; DATA XREF: apiF6_09_DrawChar+42r
byte_40307	db 10h			; DATA XREF: apiF6_09_DrawChar:loc_10AFCr
word_40308	dw 0			; DATA XREF: apiF6_09_DrawChar+48w
					; sub_130F4+16r ...
word_4030A	dw 0			; DATA XREF: apiF6_09_DrawChar+52w
					; sub_130F4:loc_1315Fr	...
word_4030C	dw 16FAh		; DATA XREF: sub_130F4+1Dr
					; sub_130F4:loc_1312Bw	...
word_4030E	dw 1790h		; DATA XREF: sub_130F4+72r
					; sub_130F4:loc_13180w	...
word_40310	dw 0A800h, 0B000h, 0B800h, 0E000h ; DATA XREF: sub_10936+1Ar
					; sub_10936+81r ...
word_40318	dw 0A000h		; DATA XREF: SetupIntVecF6+1Ar
					; sub_10DA6+10r ...
word_4031A	dw 1			; DATA XREF: sub_10936r
					; sub_10936:loc_109E8w	...
word_4031C	dw 0			; DATA XREF: sub_10A6Eo sub_10C7Cr ...
word_4031E	dw 0			; DATA XREF: sub_10C7C+12r
					; sub_10CC8+11r ...
word_40320	dw 4Fh			; DATA XREF: apiF6_09_DrawChar+61r
					; apiF6_09_DrawChar+DAr ...
word_40322	dw 18Fh			; DATA XREF: sub_10C7C+Cr sub_10EA6+Cr ...
word_40324	dw 0			; DATA XREF: sub_10A88w sub_10A92r ...
word_40326	dw 0			; DATA XREF: sub_10A88+4w sub_10A92+6r ...
byte_40328	db 0Fh			; DATA XREF: sub_10A7A+2w sub_10A80r ...
enableBoldFont	db 0			; DATA XREF: MakeCharBoldr
					; apiF6_13_SetBold+7w ...
word_4032A	dw 0			; DATA XREF: sub_10AA0w
					; apiF6_09_DrawChar:loc_10BA9r
word_4032C	dw 0FFFFh		; DATA XREF: sub_10AA0+5w sub_10C48r
word_4032E	dw 0			; DATA XREF: sub_10AAAw
					; apiF6_09_DrawChar:loc_10B93r
word_40330	dw 0			; DATA XREF: sub_10DA6w sub_10E56+12r	...
byte_40332	db 9Fh			; DATA XREF: sub_10DA6+8w
					; sub_10E56+18r
byte_40333	db 63h			; DATA XREF: sub_10DA6+Cw sub_10E56+Cr
byte_40334	db 0			; DATA XREF: sub_10DA6+18w
					; sub_10DA6:loc_10E08r
		db  90h	; ê
word_40336	dw 3Eh			; DATA XREF: sub_10DA6+38r
					; sub_10DA6+42r ...
unk_40338	db  1Fh			; DATA XREF: sub_10DA6+5Ar
					; sub_10DA6+A8r
		db 0, 1, 2, 4, 8, 10h, 20h, 40h, 80h
jumpTbl_intF6	dw offset sub_10936	; 0 ; DATA XREF: seg000:0927r
		dw offset sub_10A26	; 1
		dw offset sub_10A6E	; 2
		dw offset sub_10A7A	; 3
		dw offset sub_10A80	; 4
		dw offset sub_10A88	; 5
		dw offset sub_10A92	; 6
		dw offset sub_10AA0	; 7
		dw offset sub_10AAA	; 8
		dw offset apiF6_09_DrawChar; 9
		dw offset apiF6_0A_DrawText; 0Ah
		dw offset sub_10CC8	; 0Bh
		dw offset sub_10CE0	; 0Ch
		dw offset sub_10CEC	; 0Dh
		dw offset loc_10D64	; 0Eh
		dw offset sub_10DA6	; 0Fh
		dw offset sub_10EA2	; 10h
		dw offset sub_10EA6	; 11h
		dw offset apiF6_12_GetBold; 12h
		dw offset apiF6_13_SetBold; 13h
		dw offset apiF6_SetError; 14h
jumpTbl_intF2	dw offset apiF2_00_ReadFile; 0 ; DATA XREF: seg000:127Fr
		dw offset apiF2_01_WriteFile; 1
		dw offset apiF2_02_CheckForFile; 2
		dw offset sub_11466	; 3
		dw offset apiF2_04_AskForDiskChg; 4
		dw offset sub_11662	; 5
		dw offset sub_116A4	; 6
		dw offset apiF2_07_GetDefaultDisk; 7
		dw offset sub_116FA	; 8
		dw offset apiF2_SetError; 9
diskErrMsgList	dw offset aDiskWriteProt; 0 ; DATA XREF: seg000:12C1r
		dw offset aDriveNotReady; 1 ; "ÉfÉBÉXÉNÇ™èëÇ´çûÇ›ã÷é~Ç…Ç»Ç¡ÇƒÇÈÇ›ÇΩÇ¢Ç"...
		dw offset aDriveNotReady; 2
		dw offset aDiskError	; 3
		dw offset aDiskError	; 4
		dw offset aDiskError	; 5
		dw offset aDiskError	; 6
		dw offset aDiskError	; 7
		dw offset aDiskError	; 8
		dw offset aDiskError	; 9
		dw offset aDataWriteFail; 0Ah
		dw offset aDataReadFail	; 0Bh
		dw offset aDiskError	; 0Ch
unk_4039A	db 0FFh			; DATA XREF: sub_11496+25o
		db    0
		db    0
		db    0
		db    0
		db    0
		db    8
		db    0
		db  3Fh	; ?
		db  3Fh	; ?
		db  3Fh	; ?
		db  3Fh	; ?
		db  3Fh	; ?
		db  3Fh	; ?
		db  3Fh	; ?
		db  3Fh	; ?
		db  3Fh	; ?
		db  3Fh	; ?
		db  3Fh	; ?
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db 90h
aFileMask	db '@:\*.*',0           ; DATA XREF: sub_11496:loc_114E1o
		db 90h			; +------------+
aTopLine	db 'ÜÆÜ¢Ü¢Ü¢Ü¢Ü¢Ü¢Ü¢Ü¢Ü¢Ü¢Ü¢Ü¢Ü¢Ü¢Ü¢Ü¢Ü¢Ü¢Ü¢Ü¢Ü¢Ü¢Ü¢Ü¢Ü≤',0
					; DATA XREF: ShowDiskChgMsg+Do
aPutDiskInDrive	db 'Ü§Å@Å@ÉhÉâÉCÉuÇ`Ç…ÅAÉfÉBÉXÉNÅîÇ`Çì¸ÇÍÇƒÇÀÉbÅIÅ@Å@Ü§',0
					; DATA XREF: ShowDiskChgMsg+16o
					; apiF2_04_AskForDiskChg+15w
					; Into Drive A,	please stick Disk #!
aBottomLine	db 'Ü∂Ü¢Ü¢Ü¢Ü¢Ü¢Ü¢Ü¢Ü¢Ü¢Ü¢Ü¢Ü¢Ü¢Ü¢Ü¢Ü¢Ü¢Ü¢Ü¢Ü¢Ü¢Ü¢Ü¢Ü¢Ü∫',0
					; DATA XREF: ShowDiskChgMsg+1Fo
					; +------------+
		db 90h
aErrorDriveA	db 'Å@ÅsÅ@ÉhÉâÉCÉuÇ`Ç≈ÉGÉâÅ[î≠ê∂ÅIÅ@',0 ; DATA XREF: seg000:12DAo
					; seg000:12BCw
					; << Error reading Drive A!
aDiskWriteProt	db 'ÉfÉBÉXÉNÇ™èëÇ´çûÇ›ã÷é~Ç…Ç»Ç¡ÇƒÇÈÇ›ÇΩÇ¢ÇæÇÊ',0
					; DATA XREF: seg008:diskErrMsgListo
					; Looks	like the disk's write-protected!
aDriveNotReady	db 'ÉhÉâÉCÉuÇÃèÄîıÇ™Ç≈Ç´ÇƒÇ¢Ç‹ÇπÇÒÇÊÅ`Å`ÉbÅIÅI',0
					; DATA XREF: seg008:diskErrMsgListo
					; Wait up, it isn't ready yet!
aDataWriteFail	db 'ÉNÉXÉìÅdÅdÉfÅ[É^ÇÃèëÇ´çûÇ›Ç…é∏îsÇµÇøÇ·Ç¡ÇΩ',0
					; DATA XREF: seg008:diskErrMsgListo
					; Sniff	sniff, I couldn't write any data!
aDataReadFail	db 'ÉNÉXÉìÅdÅdÉfÅ[É^ÇÃì«Ç›çûÇ›Ç…é∏îsÇµÇøÇ·Ç¡ÇΩ',0
					; DATA XREF: seg008:diskErrMsgListo
					; Sniff	sniff, I couldn't read any data!
aDiskError	db 'âΩÇ©ïœÇæÇÊÅHÅ@ÉfÉBÉXÉNÇÇÊÅ`Ç≠ämîFÇµÇƒÇÀÉb',0
					; DATA XREF: seg008:diskErrMsgListo
					; Something's up... Check the disk, will ya?
aErrMsgEnd	db 'Å@ÅtÅ@',0           ; DATA XREF: seg000:12E4o
					; >>
byte_4056D	db 65h			; DATA XREF: seg000:12D3r
byte_4056E	db 0, 1			; DATA XREF: apiF2_04_AskForDiskChg+9w
					; sub_116FA+9w	...
word_40570	dw 0			; DATA XREF: start:loc_1175Aw
					; sub_1180C+23r ...
aCondifentNote	db 0F2h, 0F5h, 7Eh, 8Ch, 74h, 0BFh, 69h, 58h, 6Ah, 24h
					; DATA XREF: seg000:1A50o
					; seg000:loc_11A78o
		db 71h,	62h, 7Dh, 36h, 75h, 29h, 7Dh, 48h, 7Dh,	16h, 6Dh ; Notice Regarding Confidentiality (XORed with	0FFh)
		db 72h,	77h, 2Ch, 7Eh, 8Bh, 0F2h, 0F5h,	0F2h, 0F5h, 7Eh
		db 0BFh, 7Eh, 0BFh, 7Dh, 4Eh, 7Dh, 33h,	7Ch, 89h, 7Ch
		db 72h,	7Ch, 0B0h, 7Ch,	76h, 7Ch, 7Fh, 7Dh, 33h, 70h, 75h
		db 68h,	0B3h, 73h, 5Fh,	7Eh, 0BEh, 74h,	86h, 7Dh, 2Eh
		db 71h,	98h, 68h, 8Fh, 73h, 5Fh, 7Dh, 32h, 7Eh,	0BEh, 68h
		db 0B3h, 73h, 3Fh, 76h,	10h, 71h, 2Fh, 7Ch, 0BEh, 7Ch
		db 0BCh, 7Ch, 99h, 7Ch,	0A7h, 7Dh, 36h,	68h, 0B3h, 7Dh
		db 17h,	7Dh, 23h, 7Dh, 48h, 7Eh, 0BDh, 0F2h, 0F5h, 7Eh
		db 0BFh, 7Eh, 0BFh, 7Dh, 23h, 7Dh, 42h,	7Eh, 0BEh, 7Dh
		db 4Eh,	7Dh, 33h, 7Ch, 89h, 7Ch, 72h, 7Ch, 0B0h, 7Ch, 76h
		db 7Ch,	7Fh, 7Dh, 32h, 7Eh, 0BEh, 68h, 0B3h, 73h, 3Fh
		db 76h,	10h, 71h, 2Fh, 7Ch, 0BEh, 7Ch, 0BCh, 7Ch, 99h
		db 7Ch,	0A7h, 7Dh, 33h,	74h, 0BFh, 69h,	58h, 71h, 69h
		db 72h,	7Fh, 7Dh, 36h, 75h, 0A6h, 6Ch, 69h, 7Dh, 4Ah, 7Dh
		db 23h,	7Dh, 48h, 7Eh, 0BDh, 0F2h, 0F5h, 7Eh, 0BFh, 7Eh
		db 0BFh, 7Dh, 4Eh, 7Dh,	33h, 7Ch, 89h, 7Ch, 72h, 7Ch, 0B0h
		db 7Ch,	76h, 7Ch, 7Fh, 7Dh, 33h, 71h, 19h, 7Dh,	17h, 77h
		db 4Ah,	7Dh, 5Dh, 7Dh, 36h, 7Dh, 32h, 7Eh, 0BEh, 70h, 0A3h
		db 6Ah,	55h, 74h, 0BCh,	7Dh, 0Fh, 7Dh, 3Dh, 7Dh, 50h, 7Dh
		db 3Bh,	76h, 45h, 7Dh, 4Ch, 7Dh, 5Dh, 7Eh, 0BDh, 0F2h
		db 0F5h, 0F2h, 0F5h, 7Eh, 0BFh,	7Eh, 0BFh, 7Dh,	4Eh, 7Dh
		db 33h,	7Ch, 89h, 7Ch, 72h, 7Ch, 0B0h, 7Ch, 76h, 7Ch, 7Fh
		db 7Dh,	33h, 71h, 98h, 68h, 8Fh, 7Dh, 32h, 7Eh,	0BEh, 77h
		db 37h,	76h, 45h, 7Dh, 36h, 6Ah, 0A3h, 71h, 59h, 7Dh, 48h
		db 7Dh,	16h, 71h, 98h, 68h, 8Fh, 71h, 2Dh, 7Dh,	33h, 7Dh
		db 22h,	7Dh, 36h, 74h, 69h, 76h, 3Dh, 7Dh, 4Ah,	7Dh, 23h
		db 7Dh,	48h, 7Eh, 0BDh,	0F2h, 0F5h, 0F2h, 0F5h,	0F6h, 0F6h
		db 71h,	98h, 68h, 8Fh, 71h, 2Dh, 69h, 43h, 7Eh,	0B9h
aUserNameEnc	db 6Ch,	9Bh, 73h, 7Dh, 7Ch, 96h, 7Eh, 0A4h, 7Ch, 0A7h
					; DATA XREF: VerifyUserName+1o
		db 5Fh,	0AFh, 0BCh, 0D2h, 0C6h,	0C7h, 0CFh, 0CEh, 0A9h
		db 5Fh,	0F2h, 0F5h, 0F2h, 0F5h,	76h, 42h, 7Dh, 56h, 7Ch
		db 0B3h, 7Eh, 0A4h, 7Dh, 0Fh, 76h, 60h,	7Dh, 4Ah, 7Dh
		db 3Bh,	76h, 45h, 7Dh, 4Ch, 7Dh, 5Dh, 7Eh, 0BDh, 0FFh
aUserName	db 'ìdåÇÉiÅ[ÉX'         ; DATA XREF: VerifyUserName+4o
					; Dengeki Nurse	PC-9801V
		db 0A0h
		db 'PC-9801V'
		db 0A0h, 0
		dw 0DE71h		; Confidentiality Notice checksum
errorMsgList	dw offset aCannotAllocate; 0 ; DATA XREF: ShowErrorMsg+Er
		dw offset aNullPointerAss; 1 ; "cannot allocate	memory.$"
		dw offset aCannotRunOnThi; 2
		dw offset aUnknownError_; 3
a???RuntimeErro	db 0Dh,0Ah		; DATA XREF: ShowErrorMsg+12o
		db '??? runtime error: $'
asc_40712	db 7,0Dh,0Ah,'$'        ; DATA XREF: ShowErrorMsg+1Eo
aCannotAllocate	db 'cannot allocate memory.$' ; DATA XREF: seg008:errorMsgListo
aNullPointerAss	db 'null pointer assignment.$' ; DATA XREF: seg008:errorMsgListo
aCannotRunOnThi	db 'cannot run on this machine.$' ; DATA XREF: seg008:errorMsgListo
aUnknownError_	db 'unknown error.$'    ; DATA XREF: seg008:errorMsgListo
OldIntF1Vec	dd 24242424h		; DATA XREF: SetupIntVecF1+7w
					; RestoreIntVecF1+2r ...
dword_40776	dd 24242424h		; DATA XREF: sub_1057E+30w
					; sub_1057E+3Er ...
		db 6 dup(24h)
		db 0EAh	dup(?)
word_4086A	dw ?			; DATA XREF: SetupIntVecF1+2Cw
					; sub_10602:loc_10624r	...
word_4086C	dw ?			; DATA XREF: SetupIntVecF1+29w
					; sub_10602:loc_10616w	...
byte_4086E	db 60h dup(?)		; DATA XREF: SetupIntVecF1+1Bo
					; sub_10708:loc_10731o	...
word_408CE	dw ?			; DATA XREF: SetupIntVecF1+26w
					; sub_10708:loc_10724r	...
byte_408D0	db ?			; DATA XREF: sub_10462+16r
byte_408D1	db ?			; DATA XREF: sub_10462+44r
					; sub_10462+70r ...
byte_408D2	db ?			; DATA XREF: sub_10462+4Er
byte_408D3	db ?			; DATA XREF: sub_10462+1Fr
					; sub_10462+48r
byte_408D4	db ?			; DATA XREF: sub_10462+22r
					; sub_10462+52r
byte_408D5	db 7D0h	dup(?)		; DATA XREF: sub_10462+58o
byte_410A5	db 7D0h	dup(?)		; DATA XREF: sub_10462:loc_1049Bo
					; sub_104F3:loc_1050Fw	...
		db    ?	;
dword_41876	dd ?			; DATA XREF: SetupIntVecF3+7w
					; RestoreIntVecF3+2r ...
byte_4187A	db 96h dup(?)		; DATA XREF: sub_130F4+2Co
					; sub_131BA+9o	...
byte_41910	db 96h dup(?)		; DATA XREF: sub_130F4+81o
					; sub_131BA+Fo	...
OldIntF6Vec	dd ?			; DATA XREF: SetupIntVecF6+7w
					; RestoreIntVecF6+2r ...
jisCharToDraw	dw ?			; DATA XREF: apiF6_09_DrawChar:loc_10ADDw
					; GetJISCharWaitr
byte_419AC	db 22h dup(?)		; DATA XREF: apiF6_09_DrawChar+31o
word_419CE	dw ?			; DATA XREF: sub_10EEE+6w
					; sub_10F56+1Cw ...
OldIntF2Vec	dd ?			; DATA XREF: SetupIntVecF2+7w
					; RestoreIntVecF2+2r ...
dword_419D4	dd ?			; DATA XREF: SetupIntVecF2+27w
					; sub_11496+Br	...
byte_419D8	db 40h dup(?)		; DATA XREF: apiF2_00_ReadFile+5o
					; apiF2_01_WriteFile+5o ...
defaultDiskNum	db ?			; DATA XREF: SetupIntVecF2+42w
					; SetupIntVecF2+5Cr ...
hardDiskMode	db ?			; DATA XREF: SetupIntVecF2:loc_11229w
					; sub_11466r ...
byte_41A1A	db 0Ah dup(?)		; DATA XREF: SetupIntVecF2+8Co
					; sub_1153Co
byte_41A24	db 0Ah dup(?)		; DATA XREF: SetupIntVecF2+89o
					; sub_11496+22o ...
byte_41A2E	db ?			; DATA XREF: sub_11466+1Er
					; apiF2_04_AskForDiskChg+61r
byte_41A2F	db ?			; DATA XREF: SetupIntVecF2:loc_111EAw
					; sub_11496+14r ...
byte_41A30	db 1D4h	dup(?)		; DATA XREF: sub_115B8+11o
tramBakBuffer	db 0A0h	dup(?)		; DATA XREF: BackupTRAMLine+4o
					; RestoreTRAMLineo
		db 50h dup(?)
word_41CF4	dw ?			; DATA XREF: sub_117B6+2w sub_117BC+4r ...
word_41CF6	dw 10h dup(?)		; DATA XREF: sub_117BC+12w
					; exit_with_code+8o
byte_41D16	db 80h dup(?)		; DATA XREF: sub_1180C+8o
byte_41D96	db 0Eh dup(?)		; DATA XREF: sub_1180C+16o
OldIntVec05	dd ?			; DATA XREF: SetupIntVec06_05+Aw
					; RestoreIntVec05_06+3r ...
OldIntVec06	dd ?			; DATA XREF: SetupIntVec06_05+19w
					; RestoreIntVec05_06+Er ...
word_41DAC	dw ?			; DATA XREF: sub_1198Ew sub_1198E+94r
word_41DAE	dw ?			; DATA XREF: start+5Er
					; sub_1198E:loc_119D0w
word_41DB0	dw ?			; DATA XREF: start+5Ar	sub_1198E+57w
		align 10h
seg008		ends

; ===========================================================================

; Segment type:	Uninitialized
seg009		segment	byte stack 'STACK' use16
		assume cs:seg009
		assume es:nothing, ss:nothing, ds:nothing, fs:nothing, gs:nothing
		db 800h	dup(?)
seg009		ends


		end start
