; ---------------------------------------------------------------------------

SpriteObject	struc ;	(sizeof=0xC)
layer		db ?			; sprite layer (0..4)
field_1		db ?
field_2		db ?
mode		db ?			; render mode (0..4)
dataSeg		dw ?
dataPtr		dw ?
posX		dw ?
posY		dw ?
SpriteObject	ends


; File Name   :	D:\NSG.DEC.EXE
; Format      :	MS-DOS executable (EXE)
; Base Address:	1000h Range: 10000h-2FFB0h Loaded length: 1FAACh
; Entry	Point :	1000:0

		.686p
		.mmx
		.model large

; ===========================================================================

; Segment type:	Pure code
seg000		segment	byte public 'CODE' use16
		assume cs:seg000
		assume es:nothing, ss:seg002, ds:nothing, fs:nothing, gs:nothing

; =============== S U B	R O U T	I N E =======================================

; Attributes: noreturn

		public start
start		proc near		; DATA XREF: seg000:off_145A5o
					; seg000:off_1467Ao ...
		cld
		mov	cs:word_1018D, ds
		push	ds
		push	cs
		pop	ds
		assume ds:seg000
		mov	dx, offset a5h1h3l ; "\x1B*\x1B[>5h\x1B[>1h\x1B[>3l$"
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		pop	ds
		assume ds:nothing
		cli
		mov	bx, ss
		add	bx, 83h	; 'É'
		mov	ax, cs
		sub	bx, ax
		mov	ah, 4Ah
		int	21h		; DOS -	2+ - ADJUST MEMORY BLOCK SIZE (SETBLOCK)
					; ES = segment address of block	to change
					; BX = new size	in paragraphs
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		mov	es, ax
		assume es:seg001
		mov	di, 0FABCh
		mov	ds, cs:word_1018D
		assume ds:nothing
		sub	si, si
		mov	cx, 80h	; 'Ä'
		rep movsw
		sti
		sub	ax, ax
		mov	es, ax
		assume es:nothing
		or	byte ptr es:500h, 20h
		call	sub_1BD6B
		call	sub_1204C
		mov	al, 41h	; 'A'
		out	6Ah, al
		call	sub_11D1E
		call	sub_11CDE
		call	DetectMusicDriver
		call	sub_198D6
		call	sub_1214A
		call	SetIO_A6_00
		call	sub_120B8
		call	SetIO_A6_01
		call	sub_120B8
		mov	al, 1
		out	6Ah, al
		jmp	short $+2
		mov	ah, 40h	; '@'
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		jmp	short $+2
		call	SetIO_A6_00
		call	SetIO_A4_00
		mov	al, 4Bh	; 'K'
		out	0A2h, al	; Interrupt Controller #2, 8259A
		mov	al, 0
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1
		push	ax

loc_10081:				; CODE XREF: start+85j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_10081

loc_10087:				; CODE XREF: start+8Bj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_10087
		pop	ax
		call	SetIO_A2A0
		sub	cx, cx
		sub	dx, dx
		call	sub_1E7A8
		jmp	short $+2
		jmp	short $+2
		mov	al, 4Bh	; 'K'
		out	0A2h, al	; Interrupt Controller #2, 8259A
		mov	al, 0
		jmp	short $+2
		jmp	short $+2
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1
		call	WriteFontData2
		push	es
		push	ds
		pusha
		mov	ax, cs
		mov	ds, ax
		assume ds:seg000
		mov	es, ax
		assume es:seg000
		popa
		pop	ds
		assume ds:nothing
		pop	es
		assume es:nothing
		call	SetIO_A6_00
		call	SetIO_A4_00
		sub	ax, ax
		mov	ds, ax
		assume ds:nothing
		test	byte ptr ds:54Dh, 20h
		jz	short loc_100D1
		mov	cs:word_102A1, 1
		jmp	short loc_10121
; ---------------------------------------------------------------------------

loc_100D1:				; CODE XREF: start+C6j
		mov	ax, 1600h
		int	2Fh		; - Multiplex -	MS WINDOWS - ENHANCED WINDOWS INSTALLATION CHECK
					; Return: AL = anything	else
					; AL = Windows major version number >= 3
					; AH = Windows minor version number
		test	al, 7Fh
		jz	short loc_100E3
		mov	cs:word_102A3, 1
		jmp	short loc_10121
; ---------------------------------------------------------------------------

loc_100E3:				; CODE XREF: start+D8j
		call	sub_1BC4E
		call	DetectFMChip
		sub	dx, dx
		call	Music_Stop
		call	sub_1BA9D
		jb	short loc_10121
		call	sub_1BA76
		jb	short loc_10121
		call	sub_1BAC6
		jb	short loc_10121
		call	sub_1BA1A
		jb	short loc_10121
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		mov	ax, cs
		mov	es, ax
		assume es:seg000
		mov	di, 0FB3Dh
		mov	si, offset a_cmf ; ".CMF"
		cld
		call	ArgFileNameWithExt
		jb	short loc_1011E
		mov	si, dx
		call	CmfMainLoopA
		jmp	short loc_10121
; ---------------------------------------------------------------------------

loc_1011E:				; CODE XREF: start+115j
		call	LevelLoop

loc_10121:				; CODE XREF: start+CFj	start+E1j ...
		cmp	cs:byte_1018C, 0FFh
		jz	short loc_1012F
		mov	dx, 0
		call	Music_Stop

loc_1012F:				; CODE XREF: start+127j
		call	sub_1200C
		call	sub_11D4A
		call	sub_11D63
		cmp	cs:word_102A1, 0
		jz	short loc_1014B
		push	ds
		push	cs
		pop	ds
		assume ds:seg000
		mov	dx, offset aSystemGdcVk5Mh ; "System : GDC Ç™ 5	mhz Ç…Ç»Ç¡ÇƒÇ¢Ç‹Ç∑ÅB\r"...
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		pop	ds
		assume ds:nothing

loc_1014B:				; CODE XREF: start+13Ej
		cmp	cs:word_102A3, 0
		jz	short $+2
		call	SetIO_A4_01
		call	SetIO_A6_01
		call	sub_120B8
		call	SetIO_A4_00
		call	SetIO_A6_00
		call	sub_120B8
		sub	ax, ax
		mov	es, ax
		assume es:nothing
		and	byte ptr es:500h, 0DFh
		mov	ah, 0Ch
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		jmp	short $+2
		cmp	cs:byte_1018C, 0
		jz	short loc_10180
		call	sub_103A9

loc_10180:				; CODE XREF: start+17Bj
		call	sub_10546
		mov	ax, 4C00h
		mov	al, cs:byte_1018C
		int	21h		; DOS -	2+ - QUIT WITH EXIT CODE (EXIT)
start		endp			; AL = exit code

; ---------------------------------------------------------------------------
byte_1018C	db 0			; DATA XREF: start:loc_10121r
					; start+175r ...
word_1018D	dw 0			; DATA XREF: start+1w start+2Ar
		align 2
aNst_com	db 0Dh,'Nst.com',0
		db 12h dup(0)
a_cmf		db '.CMF',0             ; DATA XREF: start+10Eo
a000_key	db '000.KEY',0
aSystemGdcVk5Mh	db 'System : GDC Ç™ 5 mhz Ç…Ç»Ç¡ÇƒÇ¢Ç‹Ç∑ÅB',0Dh,0Ah ; DATA XREF: start+143o
		db '         2.5 mhz Ç…ê›íËÇµÇƒÇ©ÇÁÅAãNìÆÇµÇƒÇ≠ÇæÇ≥Ç¢ÅB',0Dh,0Ah
		db ' (ÉfÉBÉbÉvÉXÉCÉbÉ`Ç™Ç†ÇÈã@éÌÇÕÉfÉBÉbÉvÉXÉCÉbÉ`Ç'
		db 0F0h
		db 'ïœçXÇ∑ÇÈÇ©ÅA',0Dh,0Ah
		db ' Ç‡ÇµÇ≠ÇÕ ÅyHELPÅzÉLÅ[Ç'
		db 0F0h
		db 'âüÇµÇ»Ç™ÇÁÉäÉZÉbÉgÉXÉCÉbÉ`Ç'
		db 0F0h
		db 'âüÇ∑éñÇ≈ïœçXÇ≈Ç´Ç‹Ç∑)',0Dh,0Ah
		db 0Dh,0Ah,'$'
word_102A1	dw 0			; DATA XREF: start+C8w	start+138r
word_102A3	dw 0			; DATA XREF: start+DAw
					; start:loc_1014Br
		align 2

; =============== S U B	R O U T	I N E =======================================


DetectFMChip	proc near		; CODE XREF: start+E6p
		mov	ax, cs
		mov	ds, ax
		assume ds:seg000
		mov	dx, offset aConfig_nsd ; "CONFIG.NSD"
		call	LoadFile	; CONFIG.NSD
		mov	ds, ax
		assume ds:nothing
		push	ds
		mov	ax, ds:21h
		mov	cs:word_10399, ax
		add	ax, '0'
		mov	byte ptr cs:aFile1_nsd+4, al
		cmp	word ptr ds:2Bh, 0
		jz	short loc_102D8
		cmp	word ptr ds:2Bh, 1
		jz	short loc_102E1
		cmp	word ptr ds:2Bh, 2
		jz	short loc_102EA
		jmp	short loc_102F3
; ---------------------------------------------------------------------------

loc_102D8:				; CODE XREF: DetectFMChip+20j
		mov	cs:FMPort, 188h
		jmp	short loc_102F3
; ---------------------------------------------------------------------------

loc_102E1:				; CODE XREF: DetectFMChip+27j
		mov	cs:FMPort, 88h
		jmp	short loc_102F3
; ---------------------------------------------------------------------------

loc_102EA:				; CODE XREF: DetectFMChip+2Ej
		mov	cs:FMPort, 288h
		jmp	short $+2

loc_102F3:				; CODE XREF: DetectFMChip+30j
					; DetectFMChip+39j ...
		mov	ax, ds:23h
		mov	cs:word_103A5, ax
		mov	ax, ds:2Dh
		mov	cs:word_103A7, ax
		mov	ax, ds:29h
		cmp	ax, 0
		jz	short loc_1031E
		cmp	ax, 1
		jz	short loc_10317
		mov	ax, 0
		mov	cs:word_1BDE8, ax
		jmp	short loc_1031E
; ---------------------------------------------------------------------------

loc_10317:				; CODE XREF: DetectFMChip+66j
		mov	ax, 1
		mov	cs:word_1BDE8, ax

loc_1031E:				; CODE XREF: DetectFMChip+61j
					; DetectFMChip+6Fj
		mov	ax, ds:27h
		call	sub_1E406
		mov	ax, ds:25h
		cmp	ax, 0
		jz	short loc_10382
		cmp	ax, 1
		jz	short loc_1033D
		cmp	ax, 2
		jz	short loc_10354
		cmp	ax, 3
		jz	short loc_1036B
		jmp	short loc_10382
; ---------------------------------------------------------------------------

loc_1033D:				; CODE XREF: DetectFMChip+89j
		mov	cs:word_1BDF0, 1
		mov	cs:word_1BDEE, 1
		mov	cs:word_1BDF2, 0
		jmp	short loc_10382
; ---------------------------------------------------------------------------

loc_10354:				; CODE XREF: DetectFMChip+8Ej
		mov	cs:word_1BDF0, 0
		mov	cs:word_1BDEE, 0
		mov	cs:word_1BDF2, 1
		jmp	short loc_10382
; ---------------------------------------------------------------------------

loc_1036B:				; CODE XREF: DetectFMChip+93j
		mov	cs:word_1BDF0, 0
		mov	cs:word_1BDEE, 1
		mov	cs:word_1BDF2, 0
		jmp	short $+2

loc_10382:				; CODE XREF: DetectFMChip+84j
					; DetectFMChip+95j ...
		pop	ds
		push	es
		mov	ax, ds
		mov	es, ax
		assume es:nothing
		mov	ah, 49h
		int	21h		; DOS -	2+ - FREE MEMORY
					; ES = segment address of area to be freed
		pop	es
		retn
DetectFMChip	endp

; ---------------------------------------------------------------------------
aConfig_nsd	db 'CONFIG.NSD',0       ; DATA XREF: DetectFMChip+4o
word_10399	dw 0			; DATA XREF: DetectFMChip+10w
aFile1_nsd	db 'FILE1.NSD',0        ; DATA XREF: sub_103E5+7o sub_10486+7o ...
word_103A5	dw 0			; DATA XREF: DetectFMChip+50w
					; sub_1260A+23Fr
word_103A7	dw 0			; DATA XREF: DetectFMChip+57w
					; sub_1C058r

; =============== S U B	R O U T	I N E =======================================


sub_103A9	proc near		; CODE XREF: start+17Dp
		mov	ax, cs
		mov	ds, ax
		assume ds:seg000
		mov	dx, offset aConfig_nsd_0 ; "CONFIG.NSD"
		call	LoadFile	; CONFIG.NSD
		mov	es, ax
		push	es
		sub	ax, ax
		mov	al, cs:byte_1018C
		mov	es:2Fh,	ax
		or	es:31h,	ax
		mov	ax, cs
		mov	ds, ax
		mov	dx, 3DAh
		sub	bx, bx
		mov	cx, 33h	; '3'
		call	WriteFile
		pop	es
		mov	ah, 49h
		int	21h		; DOS -	2+ - FREE MEMORY
					; ES = segment address of area to be freed
		retn
sub_103A9	endp

; ---------------------------------------------------------------------------
aConfig_nsd_0	db 'CONFIG.NSD',0       ; DATA XREF: sub_103A9+4o

; =============== S U B	R O U T	I N E =======================================


sub_103E5	proc near		; CODE XREF: LevelLoopp
		push	es
		push	ds
		pusha
		mov	ax, cs
		mov	ds, ax
		mov	dx, offset aFile1_nsd ;	"FILE1.NSD"
		call	LoadFile	; FILE1.NSD
		mov	ds, ax
		assume ds:nothing
		push	ds
		mov	ax, ds:18h
		mov	cs:word_1EA78, ax
		cmp	ax, 1
		jz	short loc_10477
		mov	ax, ds:1Ah
		mov	cs:ScoreCounterH, ax
		mov	ax, ds:1Ch
		mov	cs:ScoreCounterL, ax
		mov	ax, ds:0A0h
		mov	cs:word_10544, ax
		mov	ax, ds:1Eh
		mov	cs:word_1F398, ax
		mov	ax, ds:34h
		mov	cs:word_1F3B0, ax
		mov	ax, ds:4Ah
		mov	cs:word_1F3C8, ax
		cld
		mov	ax, cs
		mov	es, ax
		assume es:seg000
		mov	si, 20h
		mov	di, offset word_1F39A
		mov	cx, 0Ah
		rep movsw
		mov	ax, cs
		mov	es, ax
		mov	si, 36h
		mov	di, offset word_1F3B2
		mov	cx, 0Ah
		rep movsw
		mov	ax, cs
		mov	es, ax
		mov	si, 4Ch
		mov	di, offset word_1F3CA
		mov	cx, 0Ah
		rep movsw
		mov	ax, cs
		mov	es, ax
		mov	si, 60h
		mov	di, offset word_1F839
		mov	cx, 10h
		rep movsw
		mov	ax, cs
		mov	es, ax
		mov	si, 80h
		mov	di, offset word_1F859
		mov	cx, 10h
		rep movsw

loc_10477:				; CODE XREF: sub_103E5+1Aj
		pop	ds
		push	es
		mov	ax, ds
		mov	es, ax
		assume es:nothing
		mov	ah, 49h
		int	21h		; DOS -	2+ - FREE MEMORY
					; ES = segment address of area to be freed
		pop	es
		popa
		pop	ds
		pop	es
		retn
sub_103E5	endp


; =============== S U B	R O U T	I N E =======================================


sub_10486	proc near		; CODE XREF: LoadCockpit+55p
		push	es
		push	ds
		pusha
		mov	ax, cs
		mov	ds, ax
		assume ds:seg000
		mov	dx, offset aFile1_nsd ;	"FILE1.NSD"
		call	LoadFile	; FILE1.NSD
		mov	es, ax
		push	es
		mov	ax, cs:word_1EA78
		mov	es:18h,	ax
		mov	ax, cs:word_10542
		mov	es:0A6h, ax
		mov	ax, cs:ScoreCounterH
		mov	es:1Ah,	ax
		mov	ax, cs:ScoreCounterL
		mov	es:1Ch,	ax
		mov	ax, cs:ScoreCounterH
		mov	es:0A2h, ax
		mov	ax, cs:ScoreCounterL
		mov	es:0A4h, ax
		mov	ax, cs:word_1F398
		mov	es:1Eh,	ax
		mov	ax, cs:word_1F3B0
		mov	es:34h,	ax
		mov	ax, cs:word_1F3C8
		mov	es:4Ah,	ax
		cld
		mov	ax, cs
		mov	ds, ax
		mov	di, 20h
		mov	si, offset word_1F39A
		mov	cx, 0Ah
		rep movsw
		mov	ax, cs
		mov	ds, ax
		mov	di, 36h
		mov	si, offset word_1F3B2
		mov	cx, 0Ah
		rep movsw
		mov	ax, cs
		mov	ds, ax
		mov	di, 4Ch
		mov	si, offset word_1F3CA
		mov	cx, 0Ah
		rep movsw
		mov	ax, cs
		mov	ds, ax
		mov	di, 60h
		mov	si, offset word_1F839
		mov	cx, 10h
		rep movsw
		mov	ax, cs
		mov	ds, ax
		mov	di, 80h
		mov	si, offset word_1F859
		mov	cx, 10h
		rep movsw
		mov	ax, cs
		mov	ds, ax
		mov	dx, offset aFile1_nsd ;	"FILE1.NSD"
		sub	bx, bx
		mov	cx, 0A8h
		call	WriteFile
		pop	es
		mov	ah, 49h
		int	21h		; DOS -	2+ - FREE MEMORY
					; ES = segment address of area to be freed
		popa
		pop	ds
		assume ds:nothing
		pop	es
		retn
sub_10486	endp

; ---------------------------------------------------------------------------
word_10542	dw 0			; DATA XREF: sub_10486+18r
					; DoOneLevel+13w
word_10544	dw 0			; DATA XREF: sub_103E5+2Dw
					; DoOneLevel+1Cr

; =============== S U B	R O U T	I N E =======================================


sub_10546	proc near		; CODE XREF: start:loc_10180p
		push	es
		push	ds
		pusha
		mov	ax, cs
		mov	ds, ax
		assume ds:seg000
		mov	dx, offset aFile1_nsd ;	"FILE1.NSD"
		call	LoadFile	; FILE1.NSD
		mov	es, ax
		push	es
		mov	ax, cs:ScoreCounterH
		mov	es:0A2h, ax
		mov	ax, cs:ScoreCounterL
		mov	es:0A4h, ax
		mov	ax, cs
		mov	ds, ax
		mov	dx, 39Bh
		sub	bx, bx
		mov	cx, 0A8h ; '®'
		call	WriteFile
		pop	es
		mov	ah, 49h
		int	21h		; DOS -	2+ - FREE MEMORY
					; ES = segment address of area to be freed
		popa
		pop	ds
		assume ds:nothing
		pop	es
		retn
sub_10546	endp


; =============== S U B	R O U T	I N E =======================================


sub_1057E	proc near		; CODE XREF: DoOneLevel+D7p
					; DoOneLevel+1A8p
		mov	ax, cs
		mov	ds, ax
		assume ds:seg000
		mov	dx, offset aFile1_nsd ;	"FILE1.NSD"
		call	LoadFile	; FILE1.NSD
		mov	es, ax
		push	es
		inc	word ptr es:0A0h
		mov	ax, cs
		mov	ds, ax
		mov	dx, 39Bh
		sub	bx, bx
		mov	cx, 0A8h ; '®'
		call	WriteFile
		pop	es
		mov	ah, 49h
		int	21h		; DOS -	2+ - FREE MEMORY
					; ES = segment address of area to be freed
		retn
sub_1057E	endp


; =============== S U B	R O U T	I N E =======================================


LevelLoop	proc near		; CODE XREF: start:loc_1011Ep
		call	sub_103E5
		mov	cx, 12h
		inc	cx
		sub	cx, cs:word_1EA78

loc_105B1:				; CODE XREF: LevelLoop+18j
		push	cx
		mov	ax, 12h
		sub	ax, cx
		call	DoOneLevel
		pop	cx
		jb	short locret_105BF
		loop	loc_105B1

locret_105BF:				; CODE XREF: LevelLoop+16j
		retn
LevelLoop	endp


; =============== S U B	R O U T	I N E =======================================


DoOneLevel	proc near		; CODE XREF: LevelLoop+12p
		mov	bx, ax
		add	bx, bx
		mov	ax, cs
		mov	ds, ax
		mov	dx, cs:LevelSceneList[bx]
		mov	si, dx
		lodsw
		mov	bx, ax
		lodsw
		mov	cs:word_10542, ax
		cmp	bx, 0
		jz	short loc_105E4
		cmp	cs:word_10544, 0
		jnz	short loc_105E7

loc_105E4:				; CODE XREF: DoOneLevel+1Aj
		call	CmfMainLoopA

loc_105E7:				; CODE XREF: DoOneLevel+22j
		inc	cs:word_1EA78
		clc
		cmp	cs:word_12F27, 0
		jnz	short loc_10601
		cmp	cs:word_111EF, 0
		jz	short locret_10600
		jmp	loc_1069C
; ---------------------------------------------------------------------------

locret_10600:				; CODE XREF: DoOneLevel+3Bj
		retn
; ---------------------------------------------------------------------------

loc_10601:				; CODE XREF: DoOneLevel+33j
		call	SetIO_A6_00
		call	SetIO_A4_00
		mov	al, 4Bh	; 'K'
		out	0A2h, al	; Interrupt Controller #2, 8259A
		mov	al, 0
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1
		push	ax

loc_10610:				; CODE XREF: DoOneLevel+54j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_10610

loc_10616:				; CODE XREF: DoOneLevel+5Aj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_10616
		pop	ax
		call	SetIO_A2A0
		sub	cx, cx
		sub	dx, dx
		call	sub_1E7A8
		jmp	short $+2
		jmp	short $+2
		mov	al, 4Bh	; 'K'
		out	0A2h, al	; Interrupt Controller #2, 8259A
		mov	al, 0
		jmp	short $+2
		jmp	short $+2
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1
		mov	ah, 0Dh
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		jmp	short $+2
		call	sub_1DA00
		mov	ax, cs
		mov	ds, ax
		mov	dx, offset aGm_over_vdf	; "gm_over.vdf"
		call	LoadFile	; gm_over.vdf
		mov	ds, ax
		assume ds:nothing
		sub	si, si
		push	ds
		call	LoadGFXData
		pop	ds
		push	es
		mov	ax, ds
		mov	es, ax
		mov	ah, 49h
		int	21h		; DOS -	2+ - FREE MEMORY
					; ES = segment address of area to be freed
		pop	es
		mov	ax, cs
		mov	ds, ax
		assume ds:seg000
		mov	si, offset aNsc03_uso ;	"nsc03.uso"
		push	si
		push	ds
		push	si
		push	ds
		mov	dx, 0
		call	Music_Stop
		pop	ds
		pop	si
		sub	di, di
		call	Music_Load
		sub	si, si
		mov	dx, 0
		call	Music_Start
		pop	ds
		assume ds:nothing
		pop	si
		mov	ax, 0Fh
		call	mdrGraphicEffect

loc_10685:				; CODE XREF: DoOneLevel+CCj
		call	TestUserInput
		test	dx, 0F0h
		jz	short loc_10685
		mov	ax, 0Bh
		call	mdrGraphicEffect
		call	sub_1DA4F
		call	sub_1057E
		stc
		retn
; ---------------------------------------------------------------------------

loc_1069C:				; CODE XREF: DoOneLevel+3Dj
		call	SetIO_A6_00
		call	SetIO_A4_00
		mov	al, 4Bh	; 'K'
		out	0A2h, al	; Interrupt Controller #2, 8259A
		mov	al, 0
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1
		push	ax

loc_106AB:				; CODE XREF: DoOneLevel+EFj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_106AB

loc_106B1:				; CODE XREF: DoOneLevel+F5j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_106B1
		pop	ax
		call	SetIO_A2A0
		sub	cx, cx
		sub	dx, dx
		call	sub_1E7A8
		jmp	short $+2
		jmp	short $+2
		mov	al, 4Bh	; 'K'
		out	0A2h, al	; Interrupt Controller #2, 8259A
		mov	al, 0
		jmp	short $+2
		jmp	short $+2
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1
		mov	ah, 0Dh
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		jmp	short $+2
		mov	ax, cs
		mov	ds, ax
		assume ds:seg000
		mov	dx, offset aM_failed_vdf ; "m_failed.vdf"
		call	LoadFile	; m_failed.vdf
		mov	ds, ax
		assume ds:nothing
		sub	si, si
		push	ds
		call	LoadGFXData
		pop	ds
		push	es
		mov	ax, ds
		mov	es, ax
		mov	ah, 49h
		int	21h		; DOS -	2+ - FREE MEMORY
					; ES = segment address of area to be freed
		pop	es
		mov	ax, cs
		mov	ds, ax
		assume ds:seg000
		mov	si, 777h
		push	si
		push	ds
		push	si
		push	ds
		mov	dx, 0
		call	Music_Stop
		pop	ds
		assume ds:nothing
		pop	si
		sub	di, di
		call	Music_Load
		sub	si, si
		mov	dx, 0
		call	Music_Start
		pop	ds
		pop	si
		mov	ax, 0Ah
		call	mdrGraphicEffect
		mov	cx, 78h	; 'x'

loc_10720:				; CODE XREF: DoOneLevel+16Ej
		push	ax

loc_10721:				; CODE XREF: DoOneLevel+165j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_10721

loc_10727:				; CODE XREF: DoOneLevel+16Bj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_10727
		pop	ax
		loop	loc_10720
		mov	ax, 10h
		call	mdrGraphicEffect
		mov	ax, cs
		mov	ds, ax
		assume ds:seg000
		mov	dx, offset aGm_over_vdf	; "gm_over.vdf"
		call	LoadFile	; gm_over.vdf
		mov	ds, ax
		assume ds:nothing
		sub	si, si
		push	ds
		call	LoadGFXData
		pop	ds
		push	es
		mov	ax, ds
		mov	es, ax
		mov	ah, 49h
		int	21h		; DOS -	2+ - FREE MEMORY
					; ES = segment address of area to be freed
		pop	es
		mov	ax, 0Fh
		call	mdrGraphicEffect

loc_10759:				; CODE XREF: DoOneLevel+1A0j
		call	TestUserInput
		test	dx, 0F0h
		jz	short loc_10759
		mov	ax, 0Bh
		call	mdrGraphicEffect
		call	sub_1057E
		stc
		retn
DoOneLevel	endp

; ---------------------------------------------------------------------------
aNsc03_uso	db 'nsc03.uso',0        ; DATA XREF: DoOneLevel+A1o
aNsc02_uso	db 'nsc02.uso',0
aGm_over_vdf	db 'gm_over.vdf',0      ; DATA XREF: DoOneLevel+84o
					; DoOneLevel+17Ao
aM_failed_vdf	db 'm_failed.vdf',0     ; DATA XREF: DoOneLevel+11Co
LevelSceneList	dw offset word_107BE	; DATA XREF: DoOneLevel+8r
		dw offset word_107CD
		dw offset word_107DC
		dw offset word_107EB
		dw offset word_107FA
		dw offset word_10809
		dw offset word_10818
		dw offset word_10827
		dw offset word_10836
		dw offset word_10845
		dw offset word_10854
		dw offset word_10863
		dw offset word_10873
		dw offset word_10883
		dw offset word_10892
		dw offset word_108A1
		dw offset word_108B1
		dw offset word_108C0
word_107BE	dw 0, 0			; DATA XREF: seg000:LevelSceneListo
aShip_p_cmf	db 'ship_p.CMF',0
word_107CD	dw 0, 0			; DATA XREF: seg000:LevelSceneListo
aNsstg1_cmf	db 'NSSTG1.CMF',0
word_107DC	dw 0, 1			; DATA XREF: seg000:LevelSceneListo
aShip_e_cmf	db 'ship_e.CMF',0
word_107EB	dw 0, 1			; DATA XREF: seg000:LevelSceneListo
aNsstg2_cmf	db 'NSSTG2.CMF',0
word_107FA	dw 0, 2			; DATA XREF: seg000:LevelSceneListo
aNseve2_cmf	db 'NSEVE2.CMF',0
word_10809	dw 0, 2			; DATA XREF: seg000:LevelSceneListo
aNsstg3_cmf	db 'NSSTG3.CMF',0
word_10818	dw 1, 2			; DATA XREF: seg000:LevelSceneListo
aNsstg0_cmf	db 'NSSTG0.CMF',0
word_10827	dw 0, 3			; DATA XREF: seg000:LevelSceneListo
aNsstg4_cmf	db 'NSSTG4.CMF',0
word_10836	dw 0, 3			; DATA XREF: seg000:LevelSceneListo
aNseve1_cmf	db 'NSEVE1.CMF',0
word_10845	dw 0, 4			; DATA XREF: seg000:LevelSceneListo
aNsstg5_cmf	db 'NSSTG5.CMF',0
word_10854	dw 0, 5			; DATA XREF: seg000:LevelSceneListo
aNsstg6_cmf	db 'NSSTG6.CMF',0
word_10863	dw 0, 6			; DATA XREF: seg000:LevelSceneListo
aNsstg7__cmf	db 'NSSTG7_.CMF',0
word_10873	dw 1, 6			; DATA XREF: seg000:LevelSceneListo
aNsstg0__cmf	db 'NSSTG0_.CMF',0
word_10883	dw 0, 6			; DATA XREF: seg000:LevelSceneListo
aNsstg7_cmf	db 'NSSTG7.CMF',0
word_10892	dw 0, 7			; DATA XREF: seg000:LevelSceneListo
aNsstg8_cmf	db 'NSSTG8.CMF',0
word_108A1	dw 0, 7			; DATA XREF: seg000:LevelSceneListo
aNsstg8b_cmf	db 'NSSTG8b.CMF',0
word_108B1	dw 0, 8			; DATA XREF: seg000:LevelSceneListo
aNsstg9_cmf	db 'NSSTG9.CMF',0
word_108C0	dw 0, 8			; DATA XREF: seg000:LevelSceneListo
aFinal_cmf	db 'FINAL.CMF',0

; =============== S U B	R O U T	I N E =======================================


ArgFileNameWithExt proc	near		; CODE XREF: start+112p
		mov	cx, 50h

loc_108D1:				; CODE XREF: ArgFileNameWithExt+Ej
		cmp	byte ptr [di], 0Dh
		jz	short loc_1091E	; file name end	- return
		cmp	byte ptr [di], ' '
		jnz	short loc_108E0	; letter/number	- start	reading	file name
		inc	di		; space	- skip
		loop	loc_108D1
		jmp	short loc_1091E
; ---------------------------------------------------------------------------

loc_108E0:				; CODE XREF: ArgFileNameWithExt+Bj
		mov	dx, di

loc_108E2:				; CODE XREF: ArgFileNameWithExt+29j
		cmp	byte ptr [di], 0Dh
		jz	short loc_108FB
		cmp	byte ptr [di], '.'
		jz	short loc_108FB
		cmp	byte ptr [di], ' '
		jz	short loc_108FB
		or	byte ptr [di], 0
		jz	short loc_108FB
		inc	di
		loop	loc_108E2
		jmp	short loc_1091E
; ---------------------------------------------------------------------------

loc_108FB:				; CODE XREF: ArgFileNameWithExt+17j
					; ArgFileNameWithExt+1Cj ...
		mov	al, es:[si]	; append file extension	(".ABC"	+ 00)
		mov	[di], al
		inc	si
		inc	di
		mov	al, es:[si]
		mov	[di], al
		inc	si
		inc	di
		mov	al, es:[si]
		mov	[di], al
		inc	si
		inc	di
		mov	al, es:[si]
		mov	[di], al
		inc	si
		inc	di
		mov	al, es:[si]
		mov	[di], al
		clc
		retn
; ---------------------------------------------------------------------------

loc_1091E:				; CODE XREF: ArgFileNameWithExt+6j
					; ArgFileNameWithExt+10j ...
		stc
		retn
ArgFileNameWithExt endp


; =============== S U B	R O U T	I N E =======================================


SetupAction	proc near		; CODE XREF: cmfA0F_LoadAction+2p
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		mov	dx, offset aRay__hdf ; "Ray_.hdf"
		call	LoadFile	; Ray_.hdf
		jnb	short loc_10930
		jmp	sact_LoadErr
; ---------------------------------------------------------------------------

loc_10930:				; CODE XREF: SetupAction+Bj
		mov	cs:segHdf_ray, ax
		mov	dx, offset aSmoke_hdf ;	"smoke.hdf"
		call	LoadFile	; smoke.hdf
		jnb	short loc_1093F
		jmp	sact_LoadErr
; ---------------------------------------------------------------------------

loc_1093F:				; CODE XREF: SetupAction+1Aj
		mov	cs:segHdf_smoke, ax
		mov	dx, offset aShot_hdf ; "shot.hdf"
		call	LoadFile	; shot.hdf
		jnb	short loc_1094E
		jmp	sact_LoadErr
; ---------------------------------------------------------------------------

loc_1094E:				; CODE XREF: SetupAction+29j
		mov	cs:segHdf_shot,	ax
		mov	dx, offset aTool_hdf ; "tool.hdf"
		call	LoadFile	; tool.hdf
		jnb	short loc_1095D
		jmp	sact_LoadErr
; ---------------------------------------------------------------------------

loc_1095D:				; CODE XREF: SetupAction+38j
		mov	cs:segHdf_tool,	ax
		mov	dx, offset aBang3_hdf ;	"bang3.hdf"
		call	LoadFile	; bang3.hdf
		jnb	short loc_1096C
		jmp	sact_LoadErr
; ---------------------------------------------------------------------------

loc_1096C:				; CODE XREF: SetupAction+47j
		mov	cs:segHdf_bang3, ax
		mov	dx, offset aShoth_hdf ;	"shoth.hdf"
		call	LoadFile	; shoth.hdf
		jnb	short loc_1097B
		jmp	sact_LoadErr
; ---------------------------------------------------------------------------

loc_1097B:				; CODE XREF: SetupAction+56j
		mov	cs:segHdf_shoth, ax
		mov	dx, offset aItemp_hdf ;	"itemp.hdf"
		call	LoadFile	; itemp.hdf
		jnb	short loc_1098A
		jmp	sact_LoadErr
; ---------------------------------------------------------------------------

loc_1098A:				; CODE XREF: SetupAction+65j
		mov	cs:segHdf_itemp, ax
		mov	dx, offset aPgage_hdf ;	"pgage.hdf"
		call	LoadFile	; pgage.hdf
		jnb	short loc_10999
		jmp	sact_LoadErr
; ---------------------------------------------------------------------------

loc_10999:				; CODE XREF: SetupAction+74j
		mov	cs:segHdf_pgage, ax
		mov	dx, offset aEshot6_hdf ; "ESHOT6.hdf"
		call	LoadFile	; ESHOT6.hdf
		jnb	short loc_109A8
		jmp	sact_LoadErr
; ---------------------------------------------------------------------------

loc_109A8:				; CODE XREF: SetupAction+83j
		mov	cs:segHdf_eshot6, ax
		mov	dx, offset aEfire_hdf ;	"EFire.hdf"
		call	LoadFile	; EFire.hdf
		jb	short sact_LoadErr
		mov	cs:segHdf_efire, ax
		mov	dx, offset aEshot1_hdf ; "ESHOT1.hdf"
		call	LoadFile	; ESHOT1.hdf
		jb	short sact_LoadErr
		mov	cs:segHdf_eshot1, ax
		mov	dx, offset aNs_e1_hdf ;	"ns_e1.hdf"
		call	LoadFile	; ns_e1.hdf
		jb	short sact_LoadErr
		mov	cs:segHdf_ns_e1, ax
		call	sub_10B7F
		jb	short sact_LoadErr
		call	sub_10CCF
		jb	short sact_LoadErr
		call	sub_10E2F
		jb	short sact_LoadErr
		mov	cx, 0
		ror	cx, 1
		cmc
		rcr	cx, 1
		mov	ah, 42h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		mov	al, 8
		out	68h, al
		call	SetIO_A2A0
		call	SetIO_A4_00
		call	SetIO_A6_00
		mov	di, 0
		mov	ch, 19h
		mov	cl, 2
		call	sub_11FE3
		mov	di, 9Ch	; 'ú'
		mov	ch, 19h
		mov	cl, 2
		call	sub_11FE3
		mov	di, 0
		mov	ch, 1
		mov	cl, 50h	; 'P'
		call	sub_11FE3
		mov	di, offset byte_20E50
		mov	ch, 2
		mov	cl, 50h	; 'P'
		call	sub_11FE3
		mov	ah, 0Ch
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		jmp	short $+2

loc_10A26:				; CODE XREF: SetupAction+114j
		clc
		retn
; ---------------------------------------------------------------------------

sact_LoadErr:				; CODE XREF: SetupAction+Dj
					; SetupAction+1Cj ...
		push	ds
		push	cs
		pop	ds
		assume ds:seg000
		mov	dx, offset aSetupactionoNs ; "SetupActioné¿çsíÜÇ…ÉGÉâÅ[î≠ê∂!!\r\n$"
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		pop	ds
		assume ds:nothing
		stc
		jmp	short loc_10A26
SetupAction	endp

; ---------------------------------------------------------------------------
aSetupactionoNs	db 'SetupActioné¿çsíÜÇ…ÉGÉâÅ[î≠ê∂!!',0Dh,0Ah,'$'
					; DATA XREF: SetupAction+10Bo

; =============== S U B	R O U T	I N E =======================================


cmfA_FreeAllMem	proc near		; CODE XREF: cmfA10_FreeAllMem+2p
		cmp	cs:segHdf_rayoX, 0
		jz	short loc_10A76
		mov	ds, cs:segHdf_rayoX
		push	es
		mov	ax, ds
		mov	es, ax
		mov	ah, 49h
		int	21h		; DOS -	2+ - FREE MEMORY
					; ES = segment address of area to be freed
		pop	es
		mov	cs:segHdf_rayoX, 0

loc_10A76:				; CODE XREF: cmfA_FreeAllMem+6j
		cmp	cs:segHdf_missle, 0
		jz	short loc_10A94
		mov	ds, cs:segHdf_missle
		push	es
		mov	ax, ds
		mov	es, ax
		mov	ah, 49h
		int	21h		; DOS -	2+ - FREE MEMORY
					; ES = segment address of area to be freed
		pop	es
		mov	cs:segHdf_missle, 0

loc_10A94:				; CODE XREF: cmfA_FreeAllMem+24j
		mov	ds, cs:segHdf_ns_e1
		push	es
		mov	ax, ds
		mov	es, ax
		mov	ah, 49h
		int	21h		; DOS -	2+ - FREE MEMORY
					; ES = segment address of area to be freed
		pop	es
		mov	ds, cs:segHdf_eshot1
		push	es
		mov	ax, ds
		mov	es, ax
		mov	ah, 49h
		int	21h		; DOS -	2+ - FREE MEMORY
					; ES = segment address of area to be freed
		pop	es
		mov	ds, cs:segHdf_efire
		push	es
		mov	ax, ds
		mov	es, ax
		mov	ah, 49h
		int	21h		; DOS -	2+ - FREE MEMORY
					; ES = segment address of area to be freed
		pop	es
		mov	ds, cs:segHdf_eshot6
		push	es
		mov	ax, ds
		mov	es, ax
		mov	ah, 49h
		int	21h		; DOS -	2+ - FREE MEMORY
					; ES = segment address of area to be freed
		pop	es
		mov	ds, cs:segHdf_pgage
		push	es
		mov	ax, ds
		mov	es, ax
		mov	ah, 49h
		int	21h		; DOS -	2+ - FREE MEMORY
					; ES = segment address of area to be freed
		pop	es
		mov	ds, cs:segHdf_itemp
		push	es
		mov	ax, ds
		mov	es, ax
		mov	ah, 49h
		int	21h		; DOS -	2+ - FREE MEMORY
					; ES = segment address of area to be freed
		pop	es
		mov	ds, cs:segHdf_shoth
		push	es
		mov	ax, ds
		mov	es, ax
		mov	ah, 49h
		int	21h		; DOS -	2+ - FREE MEMORY
					; ES = segment address of area to be freed
		pop	es
		mov	ds, cs:segHdf_bang3
		push	es
		mov	ax, ds
		mov	es, ax
		mov	ah, 49h
		int	21h		; DOS -	2+ - FREE MEMORY
					; ES = segment address of area to be freed
		pop	es
		mov	ds, cs:segHdf_tool
		push	es
		mov	ax, ds
		mov	es, ax
		mov	ah, 49h
		int	21h		; DOS -	2+ - FREE MEMORY
					; ES = segment address of area to be freed
		pop	es
		mov	ds, cs:segHdf_shot
		push	es
		mov	ax, ds
		mov	es, ax
		mov	ah, 49h
		int	21h		; DOS -	2+ - FREE MEMORY
					; ES = segment address of area to be freed
		pop	es
		mov	ds, cs:segHdf_smoke
		push	es
		mov	ax, ds
		mov	es, ax
		mov	ah, 49h
		int	21h		; DOS -	2+ - FREE MEMORY
					; ES = segment address of area to be freed
		pop	es
		mov	ds, cs:word_1E9BA
		push	es
		mov	ax, ds
		mov	es, ax
		mov	ah, 49h
		int	21h		; DOS -	2+ - FREE MEMORY
					; ES = segment address of area to be freed
		pop	es
		mov	ds, cs:segHdf_raymX
		push	es
		mov	ax, ds
		mov	es, ax
		mov	ah, 49h
		int	21h		; DOS -	2+ - FREE MEMORY
					; ES = segment address of area to be freed
		pop	es
		mov	ds, cs:word_10CCD
		push	es
		mov	ax, ds
		mov	es, ax
		mov	ah, 49h
		int	21h		; DOS -	2+ - FREE MEMORY
					; ES = segment address of area to be freed
		pop	es
		mov	ds, cs:segHdf_ray
		push	es
		mov	ax, ds
		mov	es, ax
		mov	ah, 49h
		int	21h		; DOS -	2+ - FREE MEMORY
					; ES = segment address of area to be freed
		pop	es
		call	cmfA_FreeAllHDF
		xor	dx, dx
		mov	ah, 16h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		retn
cmfA_FreeAllMem	endp


; =============== S U B	R O U T	I N E =======================================


sub_10B7F	proc near		; CODE XREF: SetupAction+B0p
		cmp	cs:word_13BB3, 0
		jz	short loc_10BA9
		cmp	cs:word_13BB3, 1
		jz	short loc_10BEF
		cmp	cs:word_13BB3, 2
		jnz	short loc_10B9A
		jmp	loc_10C34
; ---------------------------------------------------------------------------

loc_10B9A:				; CODE XREF: sub_10B7F+16j
		cmp	cs:word_13BB3, 3
		jnz	short loc_10BA5
		jmp	loc_10C80
; ---------------------------------------------------------------------------

loc_10BA5:				; CODE XREF: sub_10B7F+21j
					; sub_10B7F+58j ...
		clc
		retn
; ---------------------------------------------------------------------------

loc_10BA7:				; CODE XREF: sub_10B7F+42j
					; sub_10B7F+52j ...
		stc
		retn
; ---------------------------------------------------------------------------

loc_10BA9:				; CODE XREF: sub_10B7F+6j
		mov	ax, 3A1Ah
		mov	cs:off_13A16, ax
		mov	ax, 3A3Eh
		mov	cs:off_13A18, ax
		mov	ax, cs
		mov	ds, ax
		assume ds:seg000
		mov	dx, offset aRayga_hdf ;	"Rayga.hdf"
		call	LoadFile	; Rayga.hdf
		jb	short loc_10BA7
		mov	cs:word_1E9BA, ax
		mov	ax, cs
		mov	ds, ax
		mov	dx, offset aMshot1__hdf	; "mshot1_.hdf"
		call	LoadFile	; mshot1_.hdf
		jb	short loc_10BA7
		mov	cs:word_10CCD, ax
		jmp	short loc_10BA5
; ---------------------------------------------------------------------------
aMshot1__hdf	db 'mshot1_.hdf',0      ; DATA XREF: sub_10B7F+4Co
aRayga_hdf	db 'Rayga.hdf',0        ; DATA XREF: sub_10B7F+3Co
; ---------------------------------------------------------------------------

loc_10BEF:				; CODE XREF: sub_10B7F+Ej
		mov	ax, offset word_13A62
		mov	cs:off_13A16, ax
		mov	ax, offset word_13A86
		mov	cs:off_13A18, ax
		mov	ax, cs
		mov	ds, ax
		mov	dx, offset aRaygb_hdf ;	"Raygb.hdf"
		call	LoadFile	; Raygb.hdf
		jb	short loc_10BA7
		mov	cs:word_1E9BA, ax
		mov	ax, cs
		mov	ds, ax
		mov	dx, offset aMshot2_hdf ; "mshot2.hdf"
		call	LoadFile	; mshot2.hdf
		jb	short loc_10BA7
		mov	cs:word_10CCD, ax
		jmp	short loc_10BA5
; ---------------------------------------------------------------------------
aMshot2_hdf	db 'mshot2.hdf',0       ; DATA XREF: sub_10B7F+92o
aRaygb_hdf	db 'Raygb.hdf',0        ; DATA XREF: sub_10B7F+82o
; ---------------------------------------------------------------------------

loc_10C34:				; CODE XREF: sub_10B7F+18j
		mov	ax, offset word_13AAA
		mov	cs:off_13A16, ax
		mov	ax, offset word_13ACE
		mov	cs:off_13A18, ax
		mov	ax, cs
		mov	ds, ax
		mov	dx, offset aRaygc_hdf ;	"Raygc.hdf"
		call	LoadFile	; Raygc.hdf
		jnb	short loc_10C51
		jmp	loc_10BA7
; ---------------------------------------------------------------------------

loc_10C51:				; CODE XREF: sub_10B7F+CDj
		mov	cs:word_1E9BA, ax
		mov	ax, cs
		mov	ds, ax
		mov	dx, offset aMshot3_hdf ; "mshot3.hdf"
		call	LoadFile	; mshot3.hdf
		jnb	short loc_10C64
		jmp	loc_10BA7
; ---------------------------------------------------------------------------

loc_10C64:				; CODE XREF: sub_10B7F+E0j
		mov	cs:word_10CCD, ax
		jmp	loc_10BA5
; ---------------------------------------------------------------------------
aMshot3_hdf	db 'mshot3.hdf',0       ; DATA XREF: sub_10B7F+DAo
aRaygc_hdf	db 'Raygc.hdf',0        ; DATA XREF: sub_10B7F+C7o
; ---------------------------------------------------------------------------

loc_10C80:				; CODE XREF: sub_10B7F+23j
		mov	ax, offset word_13A1A
		mov	cs:off_13A16, ax
		mov	ax, offset word_13A3E
		mov	cs:off_13A18, ax
		mov	ax, cs
		mov	ds, ax
		mov	dx, offset aRaygd_hdf ;	"Raygd.hdf"
		call	LoadFile	; Raygd.hdf
		jnb	short loc_10C9D
		jmp	loc_10BA7
; ---------------------------------------------------------------------------

loc_10C9D:				; CODE XREF: sub_10B7F+119j
		mov	cs:word_1E9BA, ax
		mov	ax, cs
		mov	ds, ax
		mov	dx, offset aMshot4__hdf	; "mshot4_.hdf"
		call	LoadFile	; mshot4_.hdf
		jnb	short loc_10CB0
		jmp	loc_10BA7
; ---------------------------------------------------------------------------

loc_10CB0:				; CODE XREF: sub_10B7F+12Cj
		mov	cs:word_10CCD, ax
		jmp	loc_10BA5
sub_10B7F	endp

; ---------------------------------------------------------------------------
aMshot4__hdf	db 'mshot4_.hdf',0      ; DATA XREF: sub_10B7F+126o
aRaygd_hdf	db 'Raygd.hdf',0        ; DATA XREF: sub_10B7F+113o
word_10CCD	dw 0			; DATA XREF: cmfA_FreeAllMem+FFr
					; sub_10B7F+54w ...

; =============== S U B	R O U T	I N E =======================================


sub_10CCF	proc near		; CODE XREF: SetupAction+B5p
		cmp	cs:word_13CB9, 0
		jz	short loc_10D1B
		cmp	cs:word_13CB9, 1
		jz	short loc_10D5C
		cmp	cs:word_13CB9, 2
		jnz	short loc_10CEA
		jmp	loc_10D9B
; ---------------------------------------------------------------------------

loc_10CEA:				; CODE XREF: sub_10CCF+16j
		cmp	cs:word_13CB9, 3
		jnz	short loc_10CF5
		jmp	loc_10DE4
; ---------------------------------------------------------------------------

loc_10CF5:				; CODE XREF: sub_10CCF+21j
		cmp	cs:word_13DAD, 3
		jz	short loc_10D0D
		mov	ax, cs
		mov	ds, ax
		mov	dx, offset aRayma_hdf ;	"rayma.hdf"
		call	LoadFile	; rayma.hdf
		jb	short loc_10D0F
		mov	cs:segHdf_raymX, ax

loc_10D0D:				; CODE XREF: sub_10CCF+2Cj
					; sub_10CCF+62j ...
		clc
		retn
; ---------------------------------------------------------------------------

loc_10D0F:				; CODE XREF: sub_10CCF+38j
					; sub_10CCF+56j ...
		stc
		retn
; ---------------------------------------------------------------------------
aRayma_hdf	db 'rayma.hdf',0        ; DATA XREF: sub_10CCF+32o
; ---------------------------------------------------------------------------

loc_10D1B:				; CODE XREF: sub_10CCF+6j
		mov	ax, cs
		mov	ds, ax
		mov	dx, offset aMissile1_hdf ; "missile1.hdf"
		call	LoadFile	; missile1.hdf
		jb	short loc_10D0F
		mov	cs:segHdf_missle, ax
		cmp	cs:word_13DAD, 3
		jz	short loc_10D0D
		mov	ax, cs
		mov	ds, ax
		mov	dx, offset aRaymb_hdf ;	"Raymb.hdf"
		call	LoadFile	; Raymb.hdf
		jb	short loc_10D0F
		mov	cs:segHdf_raymX, ax
		jmp	short loc_10D0D
; ---------------------------------------------------------------------------
aMissile1_hdf	db 'missile1.hdf',0     ; DATA XREF: sub_10CCF+50o
aRaymb_hdf	db 'Raymb.hdf',0        ; DATA XREF: sub_10CCF+68o
; ---------------------------------------------------------------------------

loc_10D5C:				; CODE XREF: sub_10CCF+Ej
		mov	ax, cs
		mov	ds, ax
		mov	dx, offset aSshot1_hdf ; "sshot1.hdf"
		call	LoadFile	; sshot1.hdf
		jb	short loc_10D0F
		mov	cs:segHdf_missle, ax
		cmp	cs:word_13DAD, 3
		jz	short loc_10D0D
		mov	ax, cs
		mov	ds, ax
		mov	dx, offset aRaymc_hdf ;	"Raymc.hdf"
		call	LoadFile	; Raymc.hdf
		jb	short loc_10D0F
		mov	cs:segHdf_raymX, ax
		jmp	short loc_10D0D
; ---------------------------------------------------------------------------
aSshot1_hdf	db 'sshot1.hdf',0       ; DATA XREF: sub_10CCF+91o
aRaymc_hdf	db 'Raymc.hdf',0        ; DATA XREF: sub_10CCF+A9o
; ---------------------------------------------------------------------------

loc_10D9B:				; CODE XREF: sub_10CCF+18j
		mov	ax, cs
		mov	ds, ax
		mov	dx, offset aSshot2_hdf ; "sshot2.hdf"
		call	LoadFile	; sshot2.hdf
		jnb	short loc_10DAA
		jmp	loc_10D0F
; ---------------------------------------------------------------------------

loc_10DAA:				; CODE XREF: sub_10CCF+D6j
		mov	cs:segHdf_missle, ax
		cmp	cs:word_13DAD, 3
		jnz	short loc_10DB9
		jmp	loc_10D0D
; ---------------------------------------------------------------------------

loc_10DB9:				; CODE XREF: sub_10CCF+E5j
		mov	ax, cs
		mov	ds, ax
		mov	dx, offset aRaymd_hdf ;	"Raymd.hdf"
		call	LoadFile	; Raymd.hdf
		jnb	short loc_10DC8
		jmp	loc_10D0F
; ---------------------------------------------------------------------------

loc_10DC8:				; CODE XREF: sub_10CCF+F4j
		mov	cs:segHdf_raymX, ax
		jmp	loc_10D0D
; ---------------------------------------------------------------------------
aSshot2_hdf	db 'sshot2.hdf',0       ; DATA XREF: sub_10CCF+D0o
aRaymd_hdf	db 'Raymd.hdf',0        ; DATA XREF: sub_10CCF+EEo
; ---------------------------------------------------------------------------

loc_10DE4:				; CODE XREF: sub_10CCF+23j
		mov	ax, cs
		mov	ds, ax
		mov	dx, offset aSshot3_hdf ; "sshot3.hdf"
		call	LoadFile	; sshot3.hdf
		jnb	short loc_10DF3
		jmp	loc_10D0F
; ---------------------------------------------------------------------------

loc_10DF3:				; CODE XREF: sub_10CCF+11Fj
		mov	cs:segHdf_missle, ax
		cmp	cs:word_13DAD, 3
		jnz	short loc_10E02
		jmp	loc_10D0D
; ---------------------------------------------------------------------------

loc_10E02:				; CODE XREF: sub_10CCF+12Ej
		mov	ax, cs
		mov	ds, ax
		mov	dx, offset aRayme_hdf ;	"Rayme.hdf"
		call	LoadFile	; Rayme.hdf
		jnb	short loc_10E11
		jmp	loc_10D0F
; ---------------------------------------------------------------------------

loc_10E11:				; CODE XREF: sub_10CCF+13Dj
		mov	cs:segHdf_raymX, ax
		jmp	loc_10D0D
sub_10CCF	endp

; ---------------------------------------------------------------------------
aSshot3_hdf	db 'sshot3.hdf',0       ; DATA XREF: sub_10CCF+119o
aRayme_hdf	db 'Rayme.hdf',0        ; DATA XREF: sub_10CCF+137o
segHdf_missle	dw 0			; DATA XREF: cmfA_FreeAllMem:loc_10A76r
					; cmfA_FreeAllMem+26r ...

; =============== S U B	R O U T	I N E =======================================


sub_10E2F	proc near		; CODE XREF: SetupAction+BAp
		cmp	cs:word_13DAD, 1
		jz	short loc_10E4B
		cmp	cs:word_13DAD, 2
		jz	short loc_10E5E
		cmp	cs:word_13DAD, 3
		jz	short loc_10E7A

loc_10E47:				; CODE XREF: sub_10E2F+2Dj
					; sub_10E2F+3Fj ...
		clc
		retn
; ---------------------------------------------------------------------------

loc_10E49:				; CODE XREF: sub_10E2F+27j
					; sub_10E2F+39j ...
		stc
		retn
; ---------------------------------------------------------------------------

loc_10E4B:				; CODE XREF: sub_10E2F+6j
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		mov	dx, offset aSfan_hdf ; "sfan.hdf"
		call	LoadFile	; sfan.hdf
		jb	short loc_10E49
		mov	cs:segHdf_rayoX, ax
		jmp	short loc_10E47
; ---------------------------------------------------------------------------

loc_10E5E:				; CODE XREF: sub_10E2F+Ej
		mov	ax, cs
		mov	ds, ax
		assume ds:seg000
		mov	dx, offset aRayob_hdf ;	"rayob.hdf"
		call	LoadFile	; rayob.hdf
		jb	short loc_10E49
		mov	cs:segHdf_rayoX, ax
		jmp	short loc_10E47
; ---------------------------------------------------------------------------
aRayob_hdf	db 'rayob.hdf',0        ; DATA XREF: sub_10E2F+33o
; ---------------------------------------------------------------------------

loc_10E7A:				; CODE XREF: sub_10E2F+16j
		mov	ax, cs
		mov	ds, ax
		mov	dx, offset aRayoa_hdf ;	"rayoa.hdf"
		call	LoadFile	; rayoa.hdf
		jb	short loc_10E49
		mov	cs:segHdf_rayoX, ax
		jmp	short loc_10E47
sub_10E2F	endp

; ---------------------------------------------------------------------------
aRayoa_hdf	db 'rayoa.hdf',0        ; DATA XREF: sub_10E2F+4Fo

; =============== S U B	R O U T	I N E =======================================


DrawPowerGage	proc near		; CODE XREF: sub_10F09+63p
		mov	ds, cs:segHdf_pgage
		assume ds:nothing
		sub	si, si
		mov	ax, 0
		mov	cx, 16
		mov	dx, 160
		push	cx
		push	dx
		push	bx
		call	AddHDFSpr_Mode1
		pop	bx
		pop	dx
		pop	cx
		add	cx, 16
		mov	bx, cs:word_1EA64
		mov	ax, 1

loc_10EBA:				; CODE XREF: DrawPowerGage+46j
		push	ax
		mov	ds, cs:segHdf_pgage
		sub	si, si
		dec	bx
		cmp	bx, 0
		jnz	short loc_10ECB
		add	ax, 6

loc_10ECB:				; CODE XREF: DrawPowerGage+30j
		push	cx
		push	dx
		push	bx
		call	AddHDFSpr_Mode1
		pop	bx
		pop	dx
		pop	cx
		add	cx, 48
		pop	ax
		inc	ax
		cmp	ax, 6
		jnz	short loc_10EBA
		sub	si, si
		mov	ax, 6
		mov	dx, 160
		call	AddHDFSpr_Mode1
		retn
DrawPowerGage	endp


; =============== S U B	R O U T	I N E =======================================


sub_10EEA	proc near		; CODE XREF: sub_1B696+16Cp
		push	es
		push	ds
		pusha
		sub	si, 2
		and	word ptr [si], 3FFh
		mov	di, si
		mov	si, ax
		sub	cx, cs:BasePosX
		sub	dx, cs:BasePosY
		call	cmfA_LoadEnemies
		popa
		pop	ds
		pop	es
		retn
sub_10EEA	endp


; =============== S U B	R O U T	I N E =======================================


sub_10F09	proc near		; CODE XREF: cmfA1C_CallCMFB+17p
		mov	cs:word_1EA76, 0
		mov	cs:word_111ED, 0
		mov	cs:word_111EF, 0
		mov	cs:word_111E9, 0FFFFh
		mov	cs:word_111EB, 0FFFFh
		mov	cs:word_111F1, 0
		mov	cs:word_11FCC, 0

loc_10F3A:				; CODE XREF: sub_10F09:loc_1111Aj
					; sub_10F09+229j ...
		call	sub_19609
		call	ResetSprites
		call	sub_1AAC8
		call	sub_19615
		call	sub_18C3F
		call	sub_1462F
		call	sub_15F5E
		call	sub_14415
		call	ToCmfMainB
		cmp	cs:word_1EA76, 1
		jz	short loc_10F62
		call	sub_1260A
		jmp	short $+2

loc_10F62:				; CODE XREF: sub_10F09+52j
		call	sub_11402
		mov	cs:word_1B8B9, 4
		call	DrawPowerGage
		call	DrawShieldBar
		call	DrawAllSprites
		call	PrintCmfTxt3A
		call	PrintCmfTxt4F
		cmp	cs:word_111E9, 0FFFFh
		jz	short loc_10FC1
		mov	ax, cs:MapPosX
		mov	bx, cs:word_111E9
		and	ax, 0FFF0h
		and	bx, 0FFF0h
		cmp	ax, bx
		jz	short loc_10FBA
		jb	short loc_10FAB
		mov	ax, cs:BasePosX
		sub	cs:MapPosX, 8
		mov	cs:BasePosX, 8
		jmp	short loc_10FC1
; ---------------------------------------------------------------------------

loc_10FAB:				; CODE XREF: sub_10F09+8Dj
		add	cs:MapPosX, 8
		mov	cs:BasePosX, 0FFF8h
		jmp	short loc_10FC1
; ---------------------------------------------------------------------------

loc_10FBA:				; CODE XREF: sub_10F09+8Bj
		mov	cs:BasePosX, 0

loc_10FC1:				; CODE XREF: sub_10F09+78j
					; sub_10F09+A0j ...
		cmp	cs:word_111EB, 0FFFFh
		jz	short loc_10FFD
		mov	ax, cs:MapPosY
		mov	bx, cs:word_111EB
		cmp	ax, bx
		jz	short loc_10FF6
		jb	short loc_10FE7
		sub	cs:MapPosY, 1
		mov	cs:BasePosY, 1
		jmp	short loc_10FFD
; ---------------------------------------------------------------------------

loc_10FE7:				; CODE XREF: sub_10F09+CDj
		add	cs:MapPosY, 1
		mov	cs:BasePosY, 0FFFFh
		jmp	short loc_10FFD
; ---------------------------------------------------------------------------

loc_10FF6:				; CODE XREF: sub_10F09+CBj
		mov	cs:BasePosY, 0

loc_10FFD:				; CODE XREF: sub_10F09+BEj
					; sub_10F09+DCj ...
		cmp	cs:word_1753F, 0
		jnz	short loc_1100F
		cmp	cs:word_17541, 0
		jnz	short loc_1100F
		jmp	short loc_11039
; ---------------------------------------------------------------------------

loc_1100F:				; CODE XREF: sub_10F09+FAj
					; sub_10F09+102j
		mov	cs:BasePosX, 0
		mov	ax, cs:word_1753F
		sub	cs:BasePosX, ax
		add	cs:MapPosX, ax
		mov	cs:BasePosY, 0
		mov	ax, cs:word_17541
		sub	cs:BasePosY, ax
		add	cs:MapPosY, ax

loc_11039:				; CODE XREF: sub_10F09+104j
		cmp	cs:word_1753F, 0
		jnz	short loc_11064
		cmp	cs:word_17541, 0
		jnz	short loc_11064
		cmp	cs:word_111E9, 0FFFFh
		jnz	short loc_11064
		cmp	cs:word_111EB, 0FFFFh
		jnz	short loc_11064
		cmp	cs:word_1EA76, 1
		jz	short loc_11064
		call	sub_14167

loc_11064:				; CODE XREF: sub_10F09+136j
					; sub_10F09+13Ej ...
		mov	cs:word_1753F, 0
		mov	cs:word_17541, 0
		mov	ax, cs:word_12233
		cmp	cs:word_11FCC, ax
		jz	short loc_1108E

loc_1107D:				; CODE XREF: sub_10F09+17Bj
		sti
		cmp	cs:word_11FCC, ax
		cli
		jb	short loc_1107D
		inc	ax
		cmp	cs:word_11FCC, ax
		jb	short loc_1109F

loc_1108E:				; CODE XREF: sub_10F09+172j
		sti
		mov	cs:word_11FCC, 0

loc_11096:				; CODE XREF: sub_10F09+193j
		cmp	cs:word_11FCC, 1
		jnz	short loc_11096
		cli

loc_1109F:				; CODE XREF: sub_10F09+183j
		call	DrawDebugInfo
		sti
		mov	cs:word_11FCC, 0
		cmp	cs:word_111DB, 1
		jz	short loc_11103
		cmp	cs:word_111ED, 0
		jz	short loc_110BD
		call	sub_111BF

loc_110BD:				; CODE XREF: sub_10F09+1AFj
		cmp	cs:word_111EF, 0
		jz	short loc_110C8
		call	sub_111BF

loc_110C8:				; CODE XREF: sub_10F09+1BAj
		mov	ax, cs:word_1BE0C
		mov	bx, cs:word_1EA52
		shr	bx, 4
		add	ax, bx
		cmp	ax, cs:word_111DF
		jb	short loc_11103
		cmp	ax, cs:word_111E3
		jnb	short loc_11103
		mov	ax, cs:word_1BE10
		mov	bx, cs:word_1EA56
		shr	bx, 3
		add	ax, bx
		cmp	ax, cs:word_111E1
		jb	short loc_11103
		cmp	ax, cs:word_111E5
		jnb	short loc_11103
		call	sub_111BF

loc_11103:				; CODE XREF: sub_10F09+1A7j
					; sub_10F09+1D2j ...
		cmp	cs:word_111DB, 1
		jnz	short loc_1111D
		inc	cs:word_111DD
		cmp	cs:word_111DD, 30h ; '0'
		jb	short loc_1111A
		jmp	short loc_1117D
; ---------------------------------------------------------------------------

loc_1111A:				; CODE XREF: sub_10F09+20Dj
		jmp	loc_10F3A
; ---------------------------------------------------------------------------

loc_1111D:				; CODE XREF: sub_10F09+200j
		cmp	cs:word_12F27, 3Ch ; '<'
		jnb	short loc_1117D

loc_11125:
		sub	ax, ax
		mov	es, ax
		assume es:nothing
		mov	bx, 52Ah
		test	byte ptr es:[bx], 1
		jnz	short loc_11135
		jmp	loc_10F3A
; ---------------------------------------------------------------------------

loc_11135:				; CODE XREF: sub_10F09+227j
		pusha
		mov	dx, 5
		call	sub_1E653
		popa
		mov	al, 0Ch
		call	sub_1E582
		call	Music_FadeOut
		sub	ax, ax
		mov	es, ax
		mov	bx, 52Ah

loc_1114C:				; CODE XREF: sub_10F09+247j
		test	byte ptr es:[bx], 1
		jnz	short loc_1114C

loc_11152:				; CODE XREF: sub_10F09+252j
		call	sub_111F3
		jb	short loc_1117D
		test	byte ptr es:[bx], 1
		jz	short loc_11152
		call	Music_FadeIn
		pusha
		mov	dx, 5
		call	sub_1E653
		popa
		mov	al, 0Ch
		call	sub_1E582
		sub	ax, ax
		mov	es, ax
		mov	bx, 52Ah

loc_11174:				; CODE XREF: sub_10F09+26Fj
		test	byte ptr es:[bx], 1
		jnz	short loc_11174
		jmp	loc_10F3A
; ---------------------------------------------------------------------------

loc_1117D:				; CODE XREF: sub_10F09+20Fj
					; sub_10F09+21Aj ...
		cmp	cs:word_11579, 0
		jz	short loc_111B7
		call	sub_1200C
		mov	di, 0
		mov	ch, 19h
		mov	cl, 2
		call	sub_11FE3
		mov	di, 9Ch	; 'ú'
		mov	ch, 19h
		mov	cl, 2
		call	sub_11FE3
		mov	di, 0
		mov	ch, 1
		mov	cl, 50h	; 'P'
		call	sub_11FE3
		mov	di, 0E60h
		mov	ch, 2
		mov	cl, 50h	; 'P'
		call	sub_11FE3
		mov	cs:word_11579, 0

loc_111B7:				; CODE XREF: sub_10F09+27Aj
		mov	cs:word_111DB, 0
		retn
sub_10F09	endp


; =============== S U B	R O U T	I N E =======================================


sub_111BF	proc near		; CODE XREF: sub_10F09+1B1p
					; sub_10F09+1BCp ...
		mov	cs:byte_12237, 0Fh
		mov	cs:word_12235, 2
		mov	cs:word_111DD, 0
		mov	cs:word_111DB, 1
		retn
sub_111BF	endp

; ---------------------------------------------------------------------------
word_111DB	dw 0			; DATA XREF: sub_10F09+1A1r
					; sub_10F09:loc_11103r	...
word_111DD	dw 0			; DATA XREF: sub_10F09+202w
					; sub_10F09+207r ...
word_111DF	dw 0FFFFh		; DATA XREF: sub_10F09+1CDr cmfA1A+1w
word_111E1	dw 0FFFFh		; DATA XREF: sub_10F09+1E9r cmfA1A+6w
word_111E3	dw 0FFFFh		; DATA XREF: sub_10F09+1D4r cmfA1A+Bw
word_111E5	dw 0FFFFh		; DATA XREF: sub_10F09+1F0r cmfA1A+10w
word_111E7	dw 0			; DATA XREF: sub_12FAF+185w
					; sub_16D98+1w	...
word_111E9	dw 0FFFFh		; DATA XREF: sub_10F09+15w
					; sub_10F09+72r ...
word_111EB	dw 0FFFFh		; DATA XREF: sub_10F09+1Cw
					; sub_10F09:loc_10FC1r	...
word_111ED	dw 0			; DATA XREF: sub_10F09+7w
					; sub_10F09+1A9r ...
word_111EF	dw 0			; DATA XREF: DoOneLevel+35r
					; sub_10F09+Ew	...
word_111F1	dw 0			; DATA XREF: sub_10F09+23w
					; sub_111F3:loc_112FEw	...

; =============== S U B	R O U T	I N E =======================================


sub_111F3	proc near		; CODE XREF: sub_10F09:loc_11152p

; FUNCTION CHUNK AT 12C5 SIZE 0000012B BYTES

		push	es
		push	ds
		pusha
		call	sub_19609
		push	ax

loc_111FA:				; CODE XREF: sub_111F3+Bj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_111FA

loc_11200:				; CODE XREF: sub_111F3+11j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_11200
		pop	ax
		call	sub_19615
		call	sub_195EE
		cmp	cs:word_113F3, dx
		jnz	short loc_11217
		jmp	loc_112AB
; ---------------------------------------------------------------------------

loc_11217:				; CODE XREF: sub_111F3+1Fj
		mov	cs:word_113F3, dx
		or	dx, dx
		jnz	short loc_11223
		jmp	loc_112AB
; ---------------------------------------------------------------------------

loc_11223:				; CODE XREF: sub_111F3+2Bj
		mov	ax, cs
		mov	ds, ax
		assume ds:seg000
		mov	es, ax
		assume es:seg000
		mov	si, 13F6h
		mov	di, 13F5h
		mov	cx, 9
		rep movsb
		mov	cs:byte_113FE, dl
		mov	ax, seg	seg001
		mov	es, ax
		assume es:seg001
		mov	si, 13F5h
		mov	di, 50h	; 'P'
		call	sub_112B0
		jb	short loc_112C5
		mov	si, 13F5h
		mov	di, 14h
		call	sub_112B0
		jnb	short loc_11257
		jmp	loc_112FB
; ---------------------------------------------------------------------------

loc_11257:				; CODE XREF: sub_111F3+5Fj
		mov	si, 13F5h
		mov	di, 1Eh
		call	sub_112B0
		jnb	short loc_11265
		jmp	loc_112FE
; ---------------------------------------------------------------------------

loc_11265:				; CODE XREF: sub_111F3+6Dj
		mov	si, 13F5h
		mov	di, 28h	; '('
		call	sub_112B0
		jnb	short loc_11273
		jmp	loc_11314
; ---------------------------------------------------------------------------

loc_11273:				; CODE XREF: sub_111F3+7Bj
		mov	si, 13F5h
		mov	di, 32h	; '2'
		call	sub_112B0
		jnb	short loc_11281
		jmp	loc_11328
; ---------------------------------------------------------------------------

loc_11281:				; CODE XREF: sub_111F3+89j
		mov	si, 13F5h
		mov	di, 3Ch	; '<'
		call	sub_112B0
		jnb	short loc_1128F
		jmp	loc_11362
; ---------------------------------------------------------------------------

loc_1128F:				; CODE XREF: sub_111F3+97j
		mov	si, 13F5h
		mov	di, 46h	; 'F'
		call	sub_112B0
		jnb	short loc_1129D
		jmp	loc_1139C
; ---------------------------------------------------------------------------

loc_1129D:				; CODE XREF: sub_111F3+A5j
		mov	si, 13F5h
		mov	di, 0Ah
		call	sub_112B0
		jnb	short loc_112AB
		jmp	loc_113E6
; ---------------------------------------------------------------------------

loc_112AB:				; CODE XREF: sub_111F3+21j
					; sub_111F3+2Dj ...
		clc

loc_112AC:				; CODE XREF: sub_111F3+109j
		popa
		pop	ds
		assume ds:nothing
		pop	es
		assume es:nothing
		retn
sub_111F3	endp


; =============== S U B	R O U T	I N E =======================================


sub_112B0	proc near		; CODE XREF: sub_111F3+51p
					; sub_111F3+5Cp ...
		sub	dx, dx

loc_112B2:				; CODE XREF: sub_112B0+Fj
		lodsb
		mov	bl, es:[di]
		inc	dx
		cmp	dx, 0Bh
		jz	short loc_112C3
		inc	di
		cmp	al, bl
		jz	short loc_112B2
		clc
		retn
; ---------------------------------------------------------------------------

loc_112C3:				; CODE XREF: sub_112B0+Aj
		stc
		retn
sub_112B0	endp

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_111F3

loc_112C5:				; CODE XREF: sub_111F3+54j
		mov	ax, cs:word_1EA62
		sub	ax, cs:word_1EA60
		inc	ax
		shr	ax, 2
		inc	ax
		mov	cs:word_119F6, ax
		mov	cs:word_1EA64, 0
		mov	cs:word_1EA66, 10h
		mov	cs:word_1318E, 10h
		mov	cs:word_12235, 8
		mov	cs:byte_12237, 10h
		jmp	short loc_112AB
; ---------------------------------------------------------------------------

loc_112FB:				; CODE XREF: sub_111F3+61j
		stc
		jmp	short loc_112AC
; ---------------------------------------------------------------------------

loc_112FE:				; CODE XREF: sub_111F3+6Fj
		mov	cs:word_111F1, 1
		mov	cs:word_12235, 8
		mov	cs:byte_12237, 10h
		jmp	short loc_112AB
; ---------------------------------------------------------------------------

loc_11314:				; CODE XREF: sub_111F3+7Dj
		inc	cs:word_1EA64
		mov	cs:word_12235, 8
		mov	cs:byte_12237, 10h
		jmp	short loc_112AB
; ---------------------------------------------------------------------------

loc_11328:				; CODE XREF: sub_111F3+8Bj
		mov	cs:WeaponGun1, 0
		add	cs:WeaponGun2, 8
		inc	cs:WeaponGun3
		mov	cs:word_1EA64, 0
		mov	cs:word_1EA66, 10h
		mov	cs:word_1318E, 10h
		call	sub_13D01
		mov	cs:word_12235, 8
		mov	cs:byte_12237, 10h
		jmp	loc_112AB
; ---------------------------------------------------------------------------

loc_11362:				; CODE XREF: sub_111F3+99j
		mov	cs:WeaponSub1, 0
		add	cs:WeaponSub2, 4
		inc	cs:WeaponSub3
		mov	cs:word_1EA64, 0
		mov	cs:word_1EA66, 10h
		mov	cs:word_1318E, 10h
		call	sub_13CBD
		mov	cs:word_12235, 8
		mov	cs:byte_12237, 10h
		jmp	loc_112AB
; ---------------------------------------------------------------------------

loc_1139C:				; CODE XREF: sub_111F3+A7j
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		mov	bp, offset EnemyObjects
		mov	cx, 60

loc_113A7:				; CODE XREF: sub_111F3+1E1j
		cmp	word ptr ds:[bp+2], 0
		jz	short loc_113D0
		cmp	word ptr ds:[bp+26h], 0
		jz	short loc_113D0
		cmp	byte ptr ds:[bp+95h], 1
		jz	short loc_113D0
		cmp	word ptr ds:[bp+42h], 0
		jz	short loc_113D0
		mov	word ptr ds:[bp+30h], 4000
		mov	word ptr ds:[bp+2Eh], 1

loc_113D0:				; CODE XREF: sub_111F3+1B9j
					; sub_111F3+1C0j ...
		add	bp, 98h
		loop	loc_113A7
		mov	cs:word_12235, 8
		mov	cs:byte_12237, 10h
		jmp	loc_112AB
; ---------------------------------------------------------------------------

loc_113E6:				; CODE XREF: sub_111F3+B5j
		mov	cs:word_11400, 1
		jmp	loc_112AB
; END OF FUNCTION CHUNK	FOR sub_111F3
; ---------------------------------------------------------------------------
		db 2 dup(30h), 0
word_113F3	dw 0			; DATA XREF: sub_111F3+1Ar
					; sub_111F3:loc_11217w
		db 9 dup(0)
byte_113FE	db 0			; DATA XREF: sub_111F3+41w
		align 2
word_11400	dw 0			; DATA XREF: sub_111F3:loc_113E6w
					; DrawDebugInfo:loc_1A814r

; =============== S U B	R O U T	I N E =======================================


sub_11402	proc near		; CODE XREF: sub_10F09:loc_10F62p

; FUNCTION CHUNK AT 151E SIZE 00000017 BYTES

		cmp	cs:word_1157D, 1
		jnz	short loc_1140D
		jmp	loc_1151E
; ---------------------------------------------------------------------------

loc_1140D:				; CODE XREF: sub_11402+6j
		cmp	cs:word_11579, 0
		jnz	short loc_11418
		jmp	locret_11506
; ---------------------------------------------------------------------------

loc_11418:				; CODE XREF: sub_11402+11j
		cmp	cs:word_11579, 1
		jnz	short loc_1142A
		mov	cs:word_11579, 2
		jmp	locret_11506
; ---------------------------------------------------------------------------

loc_1142A:				; CODE XREF: sub_11402+1Cj
		mov	cx, cs:word_11579
		shr	cx, 4
		mov	bp, offset word_11535
		inc	cx

loc_11436:				; CODE XREF: sub_11402:loc_114E5j
		push	cx
		mov	cx, cs:[bp+0]
		mov	dx, cs:[bp+2]
		mov	ax, 0
		add	ax, 21h
		call	DrawChar
		mov	cx, cs:[bp+0]
		mov	dx, cs:[bp+2]
		add	dx, 8
		mov	ax, 0
		add	ax, 21h
		call	DrawChar
		add	word ptr cs:[bp+2], 28h
		sub	word ptr cs:[bp+0], 10h
		mov	ax, cs:[bp+0]
		sub	ax, 16
		cmp	ax, 600
		jb	short loc_11491
		mov	word ptr cs:[bp+2], 18h
		mov	ax, 24
		call	GetRandomInRange
		add	cs:[bp+2], ax
		mov	ax, 580
		push	bp
		call	GetRandomInRange
		pop	bp
		add	ax, 32
		mov	cs:[bp+0], ax

loc_11491:				; CODE XREF: sub_11402+6Ej
		cmp	word ptr cs:[bp+2], 180
		jb	short loc_114B8
		mov	word ptr cs:[bp+2], 24
		mov	ax, 24
		call	GetRandomInRange
		add	cs:[bp+2], ax
		mov	ax, 580
		push	bp
		call	GetRandomInRange
		pop	bp
		add	ax, 32
		mov	cs:[bp+0], ax

loc_114B8:				; CODE XREF: sub_11402+95j
		mov	cx, cs:[bp+0]
		mov	dx, cs:[bp+2]
		mov	ax, 46h
		add	ax, 21h
		call	DrawChar
		mov	cx, cs:[bp+0]
		mov	dx, cs:[bp+2]
		add	dx, 8
		mov	ax, 47h
		add	ax, 21h
		call	DrawChar
		add	bp, 4
		pop	cx
		loop	loc_114E5
		jmp	short loc_114E8
; ---------------------------------------------------------------------------

loc_114E5:				; CODE XREF: sub_11402+DFj
		jmp	loc_11436
; ---------------------------------------------------------------------------

loc_114E8:				; CODE XREF: sub_11402+E1j
		cmp	cs:word_11579, 0FFh
		jz	short loc_114F8
		inc	cs:word_11579
		jmp	short locret_11506
; ---------------------------------------------------------------------------

loc_114F8:				; CODE XREF: sub_11402+EDj
		mov	ax, 50
		call	GetRandomInRange
		cmp	ax, 0
		jnz	short locret_11506
		call	sub_11507

locret_11506:				; CODE XREF: sub_11402+13j
					; sub_11402+25j ...
		retn
sub_11402	endp


; =============== S U B	R O U T	I N E =======================================


sub_11507	proc near		; CODE XREF: sub_11402+101p
		cmp	cs:word_111DB, 0
		jnz	short locret_11506
		mov	cs:byte_12237, 10h
		mov	cs:word_12235, 4
		jmp	short locret_11506
sub_11507	endp

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_11402

loc_1151E:				; CODE XREF: sub_11402+8j
		cmp	cs:byte_12237, 0
		jnz	short locret_11506
		mov	cs:byte_12237, 10h
		mov	cs:word_12235, 5
		jmp	short locret_11506
; END OF FUNCTION CHUNK	FOR sub_11402
; ---------------------------------------------------------------------------
word_11535	dw 22h dup(20h)		; DATA XREF: sub_11402+30o
word_11579	dw 0			; DATA XREF: sub_10F09:loc_1117Dr
					; sub_10F09+2A7w ...
		dw 0
word_1157D	dw 0			; DATA XREF: sub_11402r

; =============== S U B	R O U T	I N E =======================================


PrintCmfTxt3A	proc near		; CODE XREF: sub_10F09+6Cp
		cmp	cs:txt3ADoDraw,	0
		jz	short locret_115ED
		mov	cx, 32
		mov	dx, 128
		mov	si, 607
		mov	di, 175
		mov	ah, 1
		mov	bx, 55AAh
		call	cmfDrawTextBox
		add	cx, 16
		add	dx, 8
		mov	ds, cs:txt3ADataSeg
		assume ds:nothing
		mov	bx, cs:txt3ADataPtr
		mov	ah, cs:txt3ATextColor
		mov	al, cs:txt3ADrawLen
		call	PrintSJISText_H1
		dec	cs:txt3ACharDelay
		jnz	short locret_115ED
		mov	cs:txt3ACharDelay, 1
		mov	al, cs:txt3ADrawLen
		inc	al
		inc	al
		cmp	al, cs:txt3ATextLen
		jz	short loc_115D9
		mov	cs:txt3ADrawLen, al
		jmp	short locret_115ED
; ---------------------------------------------------------------------------

loc_115D9:				; CODE XREF: PrintCmfTxt3A+52j
		dec	cs:txt3AEndDelay
		cmp	cs:txt3AEndDelay, 0
		jnz	short locret_115ED
		mov	cs:txt3ADoDraw,	0

locret_115ED:				; CODE XREF: PrintCmfTxt3A+6j
					; PrintCmfTxt3A+3Dj ...
		retn
PrintCmfTxt3A	endp


; =============== S U B	R O U T	I N E =======================================


cmfLoadTxtPtr3A	proc near		; CODE XREF: DrawShieldBar+DAp
					; cmfA0A_Text+Ep ...
		mov	cs:txt3ADataSeg, ds
		mov	cs:txt3ADataPtr, bx
		mov	cs:txt3ADoDraw,	1
		mov	cs:txt3ADrawLen, 2
		mov	cs:txt3ATextLen, al
		mov	cs:txt3ATextColor, ah
		mov	cs:txt3ACharDelay, 1
		mov	cs:txt3AEndDelay, 20
		push	bx
		push	si
		mov	si, bx
		sub	bx, bx

loc_11620:				; CODE XREF: cmfLoadTxtPtr3A+37j
		lodsw
		inc	bx
		inc	bx
		or	ax, ax
		jnz	short loc_11620
		mov	cs:txt3ATextLen, bl
		pop	si
		pop	bx
		retn
cmfLoadTxtPtr3A	endp

; ---------------------------------------------------------------------------
txt3ADoDraw	dw 0			; DATA XREF: PrintCmfTxt3Ar
					; PrintCmfTxt3A+67w ...
txt3ADataPtr	dw 0			; DATA XREF: PrintCmfTxt3A+27r
					; cmfLoadTxtPtr3A+5w
txt3ADataSeg	dw 0			; DATA XREF: PrintCmfTxt3A+22r
					; cmfLoadTxtPtr3Aw
txt3ATextColor	db 0			; DATA XREF: PrintCmfTxt3A+2Cr
					; cmfLoadTxtPtr3A+1Bw
txt3ADrawLen	db 0			; DATA XREF: PrintCmfTxt3A+31r
					; PrintCmfTxt3A+45r ...
txt3ATextLen	db 0			; DATA XREF: PrintCmfTxt3A+4Dr
					; cmfLoadTxtPtr3A+17w ...
txt3ACharDelay	db 0			; DATA XREF: PrintCmfTxt3A+38w
					; PrintCmfTxt3A+3Fw ...
txt3AEndDelay	db 0			; DATA XREF: PrintCmfTxt3A:loc_115D9w
					; PrintCmfTxt3A+5Fr ...

; =============== S U B	R O U T	I N E =======================================


PrintCmfTxt4F	proc near		; CODE XREF: sub_10F09+6Fp
					; PrintCmfTxt4F:loc_117D8j ...
		cmp	cs:txt4FDoDraw,	0
		jnz	short loc_11645
		jmp	loc_11818
; ---------------------------------------------------------------------------

loc_11645:				; CODE XREF: PrintCmfTxt4F+6j
		mov	cs:word_11891, 0
		mov	cx, 32
		mov	dx, 128
		mov	si, 607
		mov	di, 175
		mov	ah, 1
		mov	bx, 55AAh
		call	cmfDrawTextBox
		add	cx, 16
		add	dx, 8
		mov	ds, cs:txt4FDataSeg
		mov	bx, cs:txt4FDataPtr
		mov	ah, cs:txt4FTextColor
		mov	al, cs:txt4FDrawLen
		call	PrintSJISText_H1
		mov	cs:txt4FTxtPosX, cx
		mov	cs:txt4FTxtPosY, dx
		dec	cs:txt4FCharDelay
		jz	short loc_11690
		jmp	loc_117DC
; ---------------------------------------------------------------------------

loc_11690:				; CODE XREF: PrintCmfTxt4F+51j
		mov	cs:txt4FCharDelay, 1
		mov	al, cs:txt4FDrawLen
		inc	al
		inc	al
		cmp	al, cs:txt4FTextLen
		jz	short loc_116AC
		mov	cs:txt4FDrawLen, al
		jmp	loc_117DC
; ---------------------------------------------------------------------------

loc_116AC:				; CODE XREF: PrintCmfTxt4F+69j
		dec	cs:txt4FEndDelay
		cmp	cs:txt4FEndDelay, 0
		jz	short loc_116BC
		jmp	loc_117DC
; ---------------------------------------------------------------------------

loc_116BC:				; CODE XREF: PrintCmfTxt4F+7Dj
					; PrintCmfTxt4F+97j
		push	ax

loc_116BD:				; CODE XREF: PrintCmfTxt4F+87j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_116BD

loc_116C3:				; CODE XREF: PrintCmfTxt4F+8Dj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_116C3
		pop	ax
		call	TestUserInput
		test	dx, 0F0h
		jnz	short loc_116BC
		add	cs:txt4FTxtPosX, 16

loc_116D9:				; CODE XREF: PrintCmfTxt4F+129j
		mov	cx, 20

loc_116DC:				; CODE XREF: PrintCmfTxt4F+B9j
		push	ax

loc_116DD:				; CODE XREF: PrintCmfTxt4F+A7j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_116DD

loc_116E3:				; CODE XREF: PrintCmfTxt4F+ADj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_116E3
		pop	ax
		call	TestUserInput
		test	dx, 0F0h
		jnz	short loc_11766
		loop	loc_116DC
		mov	cx, cs:txt4FTxtPosX
		mov	dx, cs:txt4FTxtPosY
		mov	ax, 72
		add	ax, 33
		call	DrawChar
		mov	cx, cs:txt4FTxtPosX
		mov	dx, cs:txt4FTxtPosY
		add	dx, 8
		mov	ax, 73
		add	ax, 33
		call	DrawChar
		mov	cx, 20

loc_11721:				; CODE XREF: PrintCmfTxt4F+FEj
		push	ax

loc_11722:				; CODE XREF: PrintCmfTxt4F+ECj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_11722

loc_11728:				; CODE XREF: PrintCmfTxt4F+F2j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_11728
		pop	ax
		call	TestUserInput
		test	dx, 0F0h
		jnz	short loc_11766
		loop	loc_11721
		mov	cx, cs:txt4FTxtPosX
		mov	dx, cs:txt4FTxtPosY
		mov	ax, 69
		add	ax, 33
		call	DrawChar_Space
		mov	cx, cs:txt4FTxtPosX
		mov	dx, cs:txt4FTxtPosY
		add	dx, 8
		mov	ax, 69
		add	ax, 33
		call	DrawChar_Space
		jmp	loc_116D9
; ---------------------------------------------------------------------------

loc_11766:				; CODE XREF: PrintCmfTxt4F+B7j
					; PrintCmfTxt4F+FCj
		mov	cx, cs:txt4FTxtPosX
		mov	dx, cs:txt4FTxtPosY
		mov	ax, 69
		add	ax, 33
		call	DrawChar_Space
		mov	cx, cs:txt4FTxtPosX
		mov	dx, cs:txt4FTxtPosY
		add	dx, 8
		mov	ax, 69
		add	ax, 33
		call	DrawChar_Space

loc_1178F:				; CODE XREF: PrintCmfTxt4F+16Aj
		push	ax

loc_11790:				; CODE XREF: PrintCmfTxt4F+15Aj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_11790

loc_11796:				; CODE XREF: PrintCmfTxt4F+160j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_11796
		pop	ax
		call	TestUserInput
		test	dx, 0F0h
		jnz	short loc_1178F
		mov	cs:txt4FDoDraw,	0
		cmp	cs:txt4FFollow4F, 1
		jnz	short loc_117D8
		call	sub_1AAC8
		call	DrawAllSprites
		call	DrawDebugInfo
		mov	ds, cs:txt4FDataSeg
		mov	bx, cs:txt4FDataPtr

loc_117C8:				; CODE XREF: PrintCmfTxt4F+194j
		add	bx, 2
		cmp	word ptr [bx], 0
		jnz	short loc_117C8
		add	bx, 0Ch
		mov	ah, 0Fh
		call	cmfLoadTxtPtr4F

loc_117D8:				; CODE XREF: PrintCmfTxt4F+179j
		jmp	PrintCmfTxt4F
; ---------------------------------------------------------------------------
		retn
; ---------------------------------------------------------------------------

loc_117DC:				; CODE XREF: PrintCmfTxt4F+53j
					; PrintCmfTxt4F+6Fj ...
		call	sub_1AAC8
		call	DrawAllSprites
		call	TestUserInput
		test	dx, 70h
		jz	short loc_117F5
		mov	al, cs:txt4FTextLen
		sub	al, 2
		mov	cs:txt4FDrawLen, al

loc_117F5:				; CODE XREF: PrintCmfTxt4F+1AFj
		push	ax

loc_117F6:				; CODE XREF: PrintCmfTxt4F+1C0j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_117F6

loc_117FC:				; CODE XREF: PrintCmfTxt4F+1C6j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_117FC
		pop	ax
		push	ax

loc_11804:				; CODE XREF: PrintCmfTxt4F+1CEj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_11804

loc_1180A:				; CODE XREF: PrintCmfTxt4F+1D4j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1180A
		pop	ax
		call	DrawDebugInfo
		jmp	PrintCmfTxt4F
; ---------------------------------------------------------------------------
		retn
; ---------------------------------------------------------------------------

loc_11818:				; CODE XREF: PrintCmfTxt4F+8j
		call	sub_1BA1A
		retn
PrintCmfTxt4F	endp


; =============== S U B	R O U T	I N E =======================================


cmfLoadTxtPtr4F	proc near		; CODE XREF: PrintCmfTxt4F+19Bp
					; cmfLoadText4F+8p
		cmp	cs:word_11891, 0
		jnz	short locret_1187F
		mov	cs:word_11891, 1
		mov	cs:txt4FFollow4F, 0
		mov	cs:txt4FDataSeg, ds
		mov	cs:txt4FDataPtr, bx
		mov	cs:txt4FDoDraw,	1
		mov	cs:txt4FDrawLen, 2
		mov	cs:txt4FTextLen, al
		mov	cs:txt4FTextColor, ah
		mov	cs:txt4FCharDelay, 1
		mov	cs:txt4FEndDelay, 1
		push	bx
		push	si
		mov	si, bx
		sub	bx, bx

loc_11864:				; CODE XREF: cmfLoadTxtPtr4F+4Dj
		lodsw
		inc	bx
		inc	bx
		or	ax, ax
		jnz	short loc_11864
		mov	cs:txt4FTextLen, bl
		lodsw
		cmp	ax, 4Fh
		jnz	short loc_1187D
		mov	cs:txt4FFollow4F, 1

loc_1187D:				; CODE XREF: cmfLoadTxtPtr4F+58j
		pop	si
		pop	bx

locret_1187F:				; CODE XREF: cmfLoadTxtPtr4F+6j
		retn
cmfLoadTxtPtr4F	endp

; ---------------------------------------------------------------------------
txt4FFollow4F	dw 0			; DATA XREF: PrintCmfTxt4F+173r
					; cmfLoadTxtPtr4F+Fw ...
txt4FDoDraw	dw 0			; DATA XREF: PrintCmfTxt4Fr
					; PrintCmfTxt4F+16Cw ...
txt4FDataPtr	dw 0			; DATA XREF: PrintCmfTxt4F+31r
					; PrintCmfTxt4F+189r ...
txt4FDataSeg	dw 0			; DATA XREF: PrintCmfTxt4F+2Cr
					; PrintCmfTxt4F+184r ...
txt4FTextColor	db 0			; DATA XREF: PrintCmfTxt4F+36r
					; cmfLoadTxtPtr4F+31w
txt4FDrawLen	db 0			; DATA XREF: PrintCmfTxt4F+3Br
					; PrintCmfTxt4F+5Cr ...
txt4FTextLen	db 0			; DATA XREF: PrintCmfTxt4F+64r
					; PrintCmfTxt4F+1B1r ...
txt4FCharDelay	db 0			; DATA XREF: PrintCmfTxt4F+4Cw
					; PrintCmfTxt4F:loc_11690w ...
txt4FEndDelay	db 0			; DATA XREF: PrintCmfTxt4F:loc_116ACw
					; PrintCmfTxt4F+77r ...
txt4FTxtPosX	dw 0			; DATA XREF: PrintCmfTxt4F+42w
					; PrintCmfTxt4F+99w ...
txt4FTxtPosY	dw 0			; DATA XREF: PrintCmfTxt4F+47w
					; PrintCmfTxt4F+C0r ...
word_11891	dw 0			; DATA XREF: PrintCmfTxt4F:loc_11645w
					; cmfLoadTxtPtr4Fr ...

; =============== S U B	R O U T	I N E =======================================


DrawShieldBar	proc near		; CODE XREF: sub_10F09+66p
					; DATA XREF: seg000:off_1E63Co
		cmp	cs:word_119F6, 0
		jz	short loc_118C2
		pusha
		mov	dx, 5
		call	sub_1E653
		popa
		mov	al, 0Eh
		call	sub_1E582
		dec	cs:word_119F6
		add	cs:word_1EA60, 4
		mov	ax, cs:word_1EA62
		cmp	cs:word_1EA60, ax
		jb	short loc_118C2
		mov	cs:word_1EA60, ax

loc_118C2:				; CODE XREF: DrawShieldBar+6j
					; DrawShieldBar+29j
		mov	ds, cs:segHdf_tool
		sub	si, si
		mov	ax, 0
		mov	cx, 208
		mov	dx, 12
		push	cx
		push	dx
		push	bx
		call	AddHDFSpr_Mode1
		pop	bx
		pop	dx
		pop	cx
		add	cx, 8
		mov	bx, cs:word_1EA60
		shr	bx, 4
		cmp	bx, 0
		jz	short loc_11901
		push	bx

loc_118EC:				; CODE XREF: DrawShieldBar+6Bj
		push	cx
		push	dx
		push	bx
		mov	ax, 1
		sub	si, si
		call	AddHDFSpr_Mode1
		pop	bx
		pop	dx
		pop	cx
		add	cx, 8
		dec	bx
		jnz	short loc_118EC
		pop	bx

loc_11901:				; CODE XREF: DrawShieldBar+56j
		mov	ax, cs:word_1EA62
		shr	ax, 4
		sub	ax, bx
		xchg	ax, bx
		cmp	bx, 0
		jz	short loc_11924

loc_11910:				; CODE XREF: DrawShieldBar+8Fj
		push	cx
		push	dx
		push	bx
		mov	ax, 2
		sub	si, si
		call	AddHDFSpr_Mode1
		pop	bx
		pop	dx
		pop	cx
		add	cx, 8
		dec	bx
		jnz	short loc_11910

loc_11924:				; CODE XREF: DrawShieldBar+7Bj
		mov	ax, 3
		sub	si, si
		push	cx
		push	dx
		push	bx
		call	AddHDFSpr_Mode1
		pop	bx
		pop	dx
		pop	cx
		mov	bx, cs:word_1EA60
		shr	bx, 4
		mov	ax, cs:word_1EA62
		shr	ax, 6
		cmp	bx, ax
		jnb	short loc_11978
		cmp	cs:word_11980, 1
		jz	short locret_11977
		cmp	cs:ShiedLowState, 1
		jz	short loc_11962
		cmp	cs:ShiedLowState, 2
		jz	short loc_11970
		mov	bx, offset msgShieldDec1 ; "ÅyêÁîøÅzÅ@óÌÅAÉVÅ[ÉãÉhÇÃèoóÕÇ™í·â∫ÇµÇƒÇ"...
		jmp	short loc_11965
; ---------------------------------------------------------------------------

loc_11962:				; CODE XREF: DrawShieldBar+C0j
		mov	bx, offset msgShieldDec2 ; "ÅyÉIÉtÉBÉTÅ[ÅzÅ@óÌÅAÉVÅ[ÉãÉhÇÃèoóÕÇ™í·â"...

loc_11965:				; CODE XREF: DrawShieldBar+CDj
		mov	ax, cs
		mov	ds, ax
		assume ds:seg000
		mov	al, 32h
		mov	ah, 0Fh
		call	cmfLoadTxtPtr3A

loc_11970:				; CODE XREF: DrawShieldBar+C8j
		mov	cs:word_11980, 1

locret_11977:				; CODE XREF: DrawShieldBar+B8j
		retn
; ---------------------------------------------------------------------------

loc_11978:				; CODE XREF: DrawShieldBar+B0j
		mov	cs:word_11980, 0
		retn
DrawShieldBar	endp

; ---------------------------------------------------------------------------
word_11980	dw 0			; DATA XREF: DrawShieldBar+B2r
					; DrawShieldBar:loc_11970w ...
msgShieldDec1	db 'ÅyêÁîøÅzÅ@óÌÅAÉVÅ[ÉãÉhÇÃèoóÕÇ™í·â∫ÇµÇƒÇ¢ÇÈÇÌÅI',0,0
					; DATA XREF: DrawShieldBar+CAo
					; [Chiho] Rei, the shield output is decreasing!
msgShieldDec2	db 'ÅyÉIÉtÉBÉTÅ[ÅzÅ@óÌÅAÉVÅ[ÉãÉhÇÃèoóÕÇ™í·â∫ÇµÇƒÇ¢ÇÈÇÌÇÊÅBãCÇÇ¬ÇØÇƒÅ'
					; DATA XREF: DrawShieldBar:loc_11962o
		db 'I',0,0              ; [Officer] Rei, the shield output is decreasing. Be careful!
word_119F6	dw 0			; DATA XREF: sub_111F3+E0w
					; DrawShieldBarr ...
ShiedLowState	dw 0			; DATA XREF: DrawShieldBar+BAr
					; DrawShieldBar+C2r ...

; =============== S U B	R O U T	I N E =======================================


DrawHUD		proc near		; CODE XREF: sub_11C1C:loc_11C38p
					; cmfA1C_CallCMFB+14p ...
		mov	dx, cs:ScoreCounterH
		mov	ax, cs:ScoreCounterL
		push	dx
		push	cx
		push	ax
		mov	dx, dx
		mov	ax, ax
		mov	cx, 10000
		div	cx
		push	cx
		push	ax
		mov	ax, ax
		mov	cl, 100
		div	cl
		push	cx
		push	ax
		mov	al, al
		xor	ah, ah
		mov	cl, 100
		div	cl
		mov	al, ah
		xor	ah, ah
		mov	cl, 10
		div	cl
		add	al, '0'
		mov	byte ptr cs:aScoreNumber, al ; "0000000000"
		add	ah, '0'
		mov	byte ptr cs:aScoreNumber+1, ah
		pop	ax
		pop	cx
		push	cx
		push	ax
		mov	al, ah
		xor	ah, ah
		mov	cl, 100
		div	cl
		mov	al, ah
		xor	ah, ah
		mov	cl, 10
		div	cl
		add	al, '0'
		mov	byte ptr cs:aScoreNumber+2, al
		add	ah, '0'
		mov	byte ptr cs:aScoreNumber+3, ah
		pop	ax
		pop	cx
		pop	ax
		pop	cx
		push	cx
		push	ax
		mov	ax, dx
		mov	cl, 100
		div	cl
		push	cx
		push	ax
		mov	al, al
		xor	ah, ah
		mov	cl, 100
		div	cl
		mov	al, ah
		xor	ah, ah
		mov	cl, 10
		div	cl
		add	al, '0'
		mov	byte ptr cs:aScoreNumber+4, al
		add	ah, '0'
		mov	byte ptr cs:aScoreNumber+5, ah
		pop	ax
		pop	cx
		push	cx
		push	ax
		mov	al, ah
		xor	ah, ah
		mov	cl, 100
		div	cl
		mov	al, ah
		xor	ah, ah
		mov	cl, 10
		div	cl
		add	al, '0'
		mov	byte ptr cs:aScoreNumber+6, al
		add	ah, '0'
		mov	byte ptr cs:aScoreNumber+7, ah
		pop	ax
		pop	cx
		pop	ax
		pop	cx
		pop	ax
		pop	cx
		pop	dx
		mov	ax, cs
		mov	ds, ax
		mov	si, offset aScoreText ;	"SCORE"
		mov	cx, 32
		mov	dx, 8
		call	DrawASCIIStr
		mov	si, offset aScoreNumber	; "0000000000"
		mov	bx, 0
		mov	cx, 9

loc_11AC7:				; CODE XREF: DrawHUD+D5j
		lodsb
		cmp	al, '0'
		jnz	short loc_11AD2
		add	bx, 10h
		loop	loc_11AC7
		inc	si

loc_11AD2:				; CODE XREF: DrawHUD+D0j
		dec	si
		mov	cx, 32
		add	cx, bx
		mov	dx, 10h
		call	DrawASCIIStr
		mov	ax, cs:WeaponGun1
		push	cx
		push	ax
		mov	al, al
		xor	ah, ah
		mov	cl, 100
		div	cl
		mov	al, ah
		xor	ah, ah
		mov	cl, 10
		div	cl
		add	al, '0'
		mov	byte ptr cs:aWeapan_Gun+7, al
		add	ah, '0'
		mov	byte ptr cs:aWeapan_Gun+8, ah
		pop	ax
		pop	cx
		mov	ax, cs:WeaponGun2
		push	cx
		push	ax
		mov	al, al
		xor	ah, ah
		mov	cl, 100
		div	cl
		mov	al, ah
		xor	ah, ah
		mov	cl, 10
		div	cl
		add	al, '0'
		mov	byte ptr cs:aWeapan_Gun+0Ah, al
		add	ah, '0'
		mov	byte ptr cs:aWeapan_Gun+0Bh, ah
		pop	ax
		pop	cx
		mov	ax, cs:WeaponGun3
		inc	ax
		push	cx
		push	ax
		mov	al, al
		xor	ah, ah
		mov	cl, 100
		div	cl
		mov	al, ah
		xor	ah, ah
		mov	cl, 10
		div	cl
		add	al, '0'
		mov	byte ptr cs:aWeapan_Gun+4, al
		add	ah, '0'
		mov	byte ptr cs:aWeapan_Gun+5, ah
		pop	ax
		pop	cx
		mov	byte ptr cs:aWeapan_Gun+4, 'L'
		mov	ax, cs
		mov	ds, ax
		mov	si, offset aWeapan_Gun ; "GUN L0 00/00"
		mov	cx, 416
		mov	dx, 8
		call	DrawASCIIStr
		mov	ax, cs:WeaponSub1
		push	cx
		push	ax
		mov	al, al
		xor	ah, ah
		mov	cl, 100
		div	cl
		mov	al, ah
		xor	ah, ah
		mov	cl, 10
		div	cl
		add	al, '0'
		mov	byte ptr cs:aWeapan_Sub+7, al
		add	ah, '0'
		mov	byte ptr cs:aWeapan_Sub+8, ah
		pop	ax
		pop	cx
		mov	ax, cs:WeaponSub2
		push	cx
		push	ax
		mov	al, al
		xor	ah, ah
		mov	cl, 100
		div	cl
		mov	al, ah
		xor	ah, ah
		mov	cl, 10
		div	cl
		add	al, '0'
		mov	byte ptr cs:aWeapan_Sub+0Ah, al
		add	ah, '0'
		mov	byte ptr cs:aWeapan_Sub+0Bh, ah
		pop	ax
		pop	cx
		mov	ax, cs:WeaponSub3
		inc	ax
		push	cx
		push	ax
		mov	al, al
		xor	ah, ah
		mov	cl, 100
		div	cl
		mov	al, ah
		xor	ah, ah
		mov	cl, 10
		div	cl
		add	al, '0'
		mov	byte ptr cs:aWeapan_Sub+4, al
		add	ah, '0'
		mov	byte ptr cs:aWeapan_Sub+5, ah
		pop	ax
		pop	cx
		mov	byte ptr cs:aWeapan_Sub+4, 'L'
		mov	ax, cs
		mov	ds, ax
		mov	si, offset aWeapan_Sub ; "SUB L0 00/00"
		mov	cx, 416
		mov	dx, 16
		call	DrawASCIIStr
		retn
DrawHUD		endp

; ---------------------------------------------------------------------------
aScoreText	db 'SCORE',0            ; DATA XREF: DrawHUD+B8o
aScoreNumber	db '0000000000',0       ; DATA XREF: DrawHUD+31w DrawHUD+C4o ...
aWeapan_Gun	db 'GUN L0 00/00',0     ; DATA XREF: DrawHUD+161o DrawHUD+149w ...
aWeapan_Sub	db 'SUB L0 00/00',0     ; DATA XREF: DrawHUD+1EAo DrawHUD+1D2w ...

; =============== S U B	R O U T	I N E =======================================


sub_11C1C	proc near		; CODE XREF: seg000:59BDp sub_17058+Dp ...
		push	ds
		add	cs:ScoreCounterL, ax
		adc	cs:ScoreCounterH, 0
		cmp	cs:ScoreCounterH, 9999
		jnz	short loc_11C38
		mov	cs:ScoreCounterL, 9999

loc_11C38:				; CODE XREF: sub_11C1C+13j
		call	DrawHUD
		pop	ds
		assume ds:nothing
		retn
sub_11C1C	endp

; ---------------------------------------------------------------------------
		cmp	cs:LifeBonus, 0
		jnz	short loc_11C48
		jmp	locret_11CC8
; ---------------------------------------------------------------------------

loc_11C48:				; CODE XREF: seg000:1C43j
		push	ds
		mov	ax, cs
		mov	ds, ax
		assume ds:seg000
		mov	ax, cs:LifeBonus
		push	cx
		push	ax
		mov	ax, ax
		mov	cl, 100
		div	cl
		push	cx
		push	ax
		mov	al, al
		xor	ah, ah
		mov	cl, 100
		div	cl
		mov	al, ah
		xor	ah, ah
		mov	cl, 10
		div	cl
		add	al, '0'
		mov	byte ptr cs:aLifeText+0Eh, al
		add	ah, '0'
		mov	byte ptr cs:aLifeText+0Fh, ah
		pop	ax
		pop	cx
		push	cx
		push	ax
		mov	al, ah
		xor	ah, ah
		mov	cl, 100
		div	cl
		mov	al, ah
		xor	ah, ah
		mov	cl, 10
		div	cl
		add	al, '0'
		mov	byte ptr cs:aLifeText+10h, al
		add	ah, '0'
		mov	byte ptr cs:aLifeText+11h, ah
		pop	ax
		pop	cx
		pop	ax
		pop	cx
		mov	si, (offset aLifeText+0Ah)
		mov	bx, 0
		mov	cx, 9

loc_11CA8:				; CODE XREF: seg000:1CB4j
		lodsb
		cmp	al, '0'
		jnz	short loc_11CB7
		mov	byte ptr [si-1], ' '
		add	bx, 10h
		loop	loc_11CA8
		inc	si

loc_11CB7:				; CODE XREF: seg000:1CABj
		mov	byte ptr [si-1], ' '
		mov	si, offset aLifeText ; "LIFE BONUS0000000000"
		mov	cx, 128
		mov	dx, 80
		call	DrawASCIIStr
		pop	ds
		assume ds:nothing

locret_11CC8:				; CODE XREF: seg000:1C45j
		retn
; ---------------------------------------------------------------------------
aLifeText	db 'LIFE BONUS0000000000',0 ; DATA XREF: seg000:1CBBo
					; seg000:1C9Fo	...

; =============== S U B	R O U T	I N E =======================================


sub_11CDE	proc near		; CODE XREF: start+4Ep
		pushf
		cli
		push	ds
		push	es
		pusha
		xor	ax, ax
		mov	ds, ax
		assume ds:nothing
		mov	si, 28h
		mov	di, offset byte_11D1A
		mov	ax, cs
		mov	es, ax
		assume es:seg000
		movsw
		movsw
		xor	ax, ax
		mov	es, ax
		assume es:nothing
		mov	di, 28h
		mov	ax, offset loc_11D7C
		stosw
		mov	ax, cs
		stosw
		in	al, 2		; DMA controller, 8237A-5.
					; channel 1 current address
		and	al, 0FBh
		out	2, al		; DMA controller, 8237A-5.
					; channel 1 base address
					; (also	sets current address)
		jmp	short $+2
		jmp	short $+2
		jmp	short $+2
		out	64h, al		; 8042 keyboard	controller command register.
		jmp	short $+2
		jmp	short $+2
		jmp	short $+2
		popa
		pop	es
		assume es:nothing
		pop	ds
		assume ds:nothing
		popf
		retn
sub_11CDE	endp

; ---------------------------------------------------------------------------
byte_11D1A	db 4 dup(0)		; DATA XREF: sub_11CDE+Co sub_11D4A+Co ...

; =============== S U B	R O U T	I N E =======================================


sub_11D1E	proc near		; CODE XREF: start+4Bp
		pushf
		cli
		push	ds
		push	es
		pusha
		xor	ax, ax
		mov	ds, ax
		assume ds:nothing
		mov	si, 60h
		mov	di, offset byte_11D46
		mov	ax, cs
		mov	es, ax
		assume es:seg000
		movsw
		movsw
		xor	ax, ax
		mov	es, ax
		assume es:nothing
		mov	di, 60h
		mov	ax, offset loc_11FD2
		stosw
		mov	ax, cs
		stosw
		popa
		pop	es
		assume es:nothing
		pop	ds
		assume ds:nothing
		popf
		retn
sub_11D1E	endp

; ---------------------------------------------------------------------------
byte_11D46	db 4 dup(0)		; DATA XREF: sub_11D1E+Co sub_11D63+Co ...

; =============== S U B	R O U T	I N E =======================================


sub_11D4A	proc near		; CODE XREF: start+132p
		push	ds
		push	es
		pusha
		cli
		mov	ax, cs
		mov	ds, ax
		assume ds:seg000
		xor	ax, ax
		mov	es, ax
		assume es:nothing
		mov	si, offset byte_11D1A
		mov	di, 28h
		movsw
		movsw
		sti
		popa
		pop	es
		assume es:nothing
		pop	ds
		assume ds:nothing
		retn
sub_11D4A	endp


; =============== S U B	R O U T	I N E =======================================


sub_11D63	proc near		; CODE XREF: start+135p
		push	ds
		push	es
		pusha
		cli
		mov	ax, cs
		mov	ds, ax
		assume ds:seg000
		xor	ax, ax
		mov	es, ax
		assume es:nothing
		mov	si, offset byte_11D46
		mov	di, 60h
		movsw
		movsw
		sti
		popa
		pop	es
		assume es:nothing
		pop	ds
		assume ds:nothing
		retn
sub_11D63	endp

; ---------------------------------------------------------------------------

loc_11D7C:				; DATA XREF: sub_11CDE+1Co
		pushf
		push	ax
		cmp	cs:word_12235, 0
		jnz	short loc_11D89
		jmp	loc_11FAE
; ---------------------------------------------------------------------------

loc_11D89:				; CODE XREF: seg000:1D84j
		dec	cs:word_12238
		cmp	cs:word_12238, 0
		jz	short loc_11D99
		jmp	loc_11FAE
; ---------------------------------------------------------------------------

loc_11D99:				; CODE XREF: seg000:1D94j
		mov	cs:word_12238, 3
		pusha
		mov	bx, cs:word_12235
		dec	bx
		shl	bx, 1
		jmp	cs:off_11DAE[bx]
; ---------------------------------------------------------------------------
off_11DAE	dw offset loc_11DC4	; 0 ; DATA XREF: seg000:1DA9r
		dw offset loc_11DEE	; 1
		dw offset loc_11E13	; 2
		dw offset loc_11E35	; 3
		dw offset loc_11E60	; 4
		dw offset loc_11E8B	; 5
		dw offset loc_11EB9	; 6
		dw offset loc_11EFD	; 7
		dw offset loc_11F2F	; 8
		dw offset loc_11F55	; 9
		dw offset loc_11F81	; 0Ah
; ---------------------------------------------------------------------------

loc_11DC4:				; CODE XREF: seg000:1DA9j
					; DATA XREF: seg000:off_11DAEo
		mov	bp, 0FFFFh
		mov	bl, cs:byte_12237
		call	Palette_SetMult
		inc	cs:byte_12237
		cmp	cs:byte_12237, 10h
		jz	short loc_11DDF
		jmp	loc_11FAD
; ---------------------------------------------------------------------------

loc_11DDF:				; CODE XREF: seg000:1DDAj
		dec	cs:byte_12237
		mov	cs:word_12235, 0
		jmp	loc_11FAD
; ---------------------------------------------------------------------------

loc_11DEE:				; CODE XREF: seg000:1DA9j
					; DATA XREF: seg000:off_11DAEo
		mov	bp, 0FFFFh
		mov	bl, cs:byte_12237
		call	Palette_SetMult
		dec	cs:byte_12237
		cmp	cs:byte_12237, 0
		jz	short loc_11E09
		jmp	loc_11FAD
; ---------------------------------------------------------------------------

loc_11E09:				; CODE XREF: seg000:1E04j
		mov	cs:word_12235, 0
		jmp	loc_11FAD
; ---------------------------------------------------------------------------

loc_11E13:				; CODE XREF: seg000:1DA9j
					; DATA XREF: seg000:off_11DAEo
		mov	bp, 0FFFFh
		mov	bl, cs:byte_12237
		call	Palette_SetMult
		dec	cs:byte_12237
		cmp	cs:byte_12237, 4
		jz	short loc_11E2E
		jmp	loc_11FAD
; ---------------------------------------------------------------------------

loc_11E2E:				; CODE XREF: seg000:1E29j
		mov	cs:word_12235, 0

loc_11E35:				; CODE XREF: seg000:1DA9j
					; DATA XREF: seg000:off_11DAEo
		push	es
		push	ds
		mov	bp, 0FFFFh
		sub	bx, bx
		mov	bl, cs:byte_12237
		call	sub_1DE03
		dec	cs:byte_12237
		cmp	cs:byte_12237, 0
		pop	ds
		pop	es
		jz	short loc_11E56
		jmp	loc_11FAD
; ---------------------------------------------------------------------------

loc_11E56:				; CODE XREF: seg000:1E51j
		mov	cs:word_12235, 0
		jmp	loc_11FAD
; ---------------------------------------------------------------------------

loc_11E60:				; CODE XREF: seg000:1DA9j
					; DATA XREF: seg000:off_11DAEo
		push	es
		push	ds
		mov	bp, 0FFFFh
		sub	bx, bx
		mov	bl, cs:byte_12237
		call	sub_1DE03
		dec	cs:byte_12237
		cmp	cs:byte_12237, 0
		pop	ds
		pop	es
		jz	short loc_11E81
		jmp	loc_11FAD
; ---------------------------------------------------------------------------

loc_11E81:				; CODE XREF: seg000:1E7Cj
		mov	cs:word_12235, 0
		jmp	loc_11FAD
; ---------------------------------------------------------------------------

loc_11E8B:				; CODE XREF: seg000:1DA9j
					; DATA XREF: seg000:off_11DAEo
		push	es
		push	ds
		mov	bp, 0FFFFh
		sub	bx, bx
		mov	bl, cs:byte_12237
		shr	bl, 2
		call	sub_1DE03
		dec	cs:byte_12237
		cmp	cs:byte_12237, 0
		pop	ds
		pop	es
		jz	short loc_11EAF
		jmp	loc_11FAD
; ---------------------------------------------------------------------------

loc_11EAF:				; CODE XREF: seg000:1EAAj
		mov	cs:word_12235, 0
		jmp	loc_11FAD
; ---------------------------------------------------------------------------

loc_11EB9:				; CODE XREF: seg000:1DA9j
					; DATA XREF: seg000:off_11DAEo
		push	es
		push	ds
		mov	bp, 0FFFFh
		sub	bx, bx
		mov	bl, cs:byte_12237
		shr	bl, 2
		call	sub_1DE03
		inc	cs:byte_12237
		cmp	cs:byte_12237, 40h ; '@'
		pop	ds
		pop	es
		jz	short loc_11EDD
		jmp	loc_11FAD
; ---------------------------------------------------------------------------

loc_11EDD:				; CODE XREF: seg000:1ED8j
		mov	cs:word_12235, 0
		push	es
		push	ds
		cld
		mov	ax, cs
		mov	ds, ax
		assume ds:seg000
		mov	es, ax
		assume es:seg000
		mov	di, 0E150h
		mov	si, 0E1B0h
		mov	cx, 30h	; '0'
		rep movsw
		pop	ds
		assume ds:nothing
		pop	es
		assume es:nothing
		jmp	loc_11FAD
; ---------------------------------------------------------------------------

loc_11EFD:				; CODE XREF: seg000:1DA9j
					; DATA XREF: seg000:off_11DAEo
		mov	bp, 0FFFFh
		mov	bl, cs:byte_12237
		call	sub_1E39A
		dec	cs:byte_12237
		cmp	cs:byte_12237, 0
		jz	short loc_11F18
		jmp	loc_11FAD
; ---------------------------------------------------------------------------

loc_11F18:				; CODE XREF: seg000:1F13j
		mov	bl, 10h
		call	Palette_SetMult
		mov	ax, cs:word_11FCE
		mov	cs:word_12235, ax
		mov	al, cs:byte_11FD0
		mov	cs:byte_12237, al
		jmp	short loc_11FAD
; ---------------------------------------------------------------------------

loc_11F2F:				; CODE XREF: seg000:1DA9j
					; DATA XREF: seg000:off_11DAEo
		mov	bp, 0FFFFh
		mov	bl, cs:byte_12237
		call	sub_1E39A
		inc	cs:byte_12237
		cmp	cs:byte_12237, 11h
		jnz	short loc_11FAD
		dec	cs:byte_12237
		mov	cs:word_12235, 0
		jmp	short loc_11FAD
; ---------------------------------------------------------------------------

loc_11F55:				; CODE XREF: seg000:1DA9j
					; DATA XREF: seg000:off_11DAEo
		push	es
		push	ds
		mov	bp, 0FFFFh
		sub	bx, bx
		mov	bl, cs:byte_12237
		call	sub_1DE03
		inc	cs:byte_12237
		cmp	cs:byte_12237, 11h
		pop	ds
		pop	es
		jnz	short loc_11FAD
		dec	cs:byte_12237
		mov	cs:word_12235, 0Bh
		jmp	short loc_11FAD
; ---------------------------------------------------------------------------

loc_11F81:				; CODE XREF: seg000:1DA9j
					; DATA XREF: seg000:off_11DAEo
		push	es
		push	ds
		mov	bp, 0FFFFh
		sub	bx, bx
		mov	bl, cs:byte_12237
		call	sub_1DE03
		dec	cs:byte_12237
		cmp	cs:byte_12237, 0FFh
		pop	ds
		pop	es
		jnz	short loc_11FAD
		inc	cs:byte_12237
		mov	cs:word_12235, 0Ah
		jmp	short $+2

loc_11FAD:				; CODE XREF: seg000:1DDCj seg000:1DEBj ...
		popa

loc_11FAE:				; CODE XREF: seg000:1D86j seg000:1D96j
		out	64h, al		; 8042 keyboard	controller command register.
		jmp	short $+2
		jmp	short $+2
		jmp	short $+2
		mov	al, 20h	; ' '
		out	0, al
		jmp	short $+2
		jmp	short $+2
		jmp	short $+2
		inc	cs:word_11FCC
		pop	ax
		popf
		jmp	dword ptr cs:byte_11D1A
; ---------------------------------------------------------------------------
word_11FCC	dw 0			; DATA XREF: sub_10F09+2Aw
					; sub_10F09+16Dr ...
word_11FCE	dw 0			; DATA XREF: seg000:1F1Dr
					; sub_12FAF+190w
byte_11FD0	db 0			; DATA XREF: seg000:1F25r
					; sub_12FAF+198w
		align 2

loc_11FD2:				; DATA XREF: sub_11D1E+1Co
		pushf
		call	dword ptr cs:byte_11D46
		push	ax
		in	al, 2		; DMA controller, 8237A-5.
					; channel 1 current address
		and	al, 0FBh
		out	2, al		; DMA controller, 8237A-5.
					; channel 1 base address
					; (also	sets current address)
		out	64h, al		; 8042 keyboard	controller command register.
		pop	ax
		iret

; =============== S U B	R O U T	I N E =======================================


sub_11FE3	proc near		; CODE XREF: SetupAction+DFp
					; SetupAction+E9p ...
		pusha
		push	ds
		mov	ax, 0A000h
		mov	ds, ax
		assume ds:nothing
		mov	ax, 20h	; ' '
		mov	bx, 0FF04h

loc_11FF0:				; CODE XREF: sub_11FE3+24j
		push	di
		push	cx

loc_11FF2:				; CODE XREF: sub_11FE3+1Aj
		mov	[di], ax
		mov	[di+2000h], bx
		add	di, 2
		dec	cl
		jnz	short loc_11FF2
		pop	cx
		pop	di
		add	di, 0A0h ; '†'
		dec	ch
		jnz	short loc_11FF0
		pop	ds
		assume ds:nothing
		popa
		retn
sub_11FE3	endp


; =============== S U B	R O U T	I N E =======================================


sub_1200C	proc near		; CODE XREF: start:loc_1012Fp
					; sub_10F09+27Cp
		pusha
		push	ds
		mov	ax, 0A000h
		mov	ds, ax
		assume ds:nothing
		mov	cx, 7D0h
		mov	ax, 20h
		mov	bx, 0FFE1h
		xor	di, di

loc_1201E:				; CODE XREF: sub_1200C+1Bj
		mov	[di], ax
		mov	[di+2000h], bx
		add	di, 2
		loop	loc_1201E
		pop	ds
		assume ds:nothing
		popa
		retn
sub_1200C	endp

; ---------------------------------------------------------------------------
		pusha
		push	ds
		mov	ax, 0A000h
		mov	ds, ax
		assume ds:nothing
		mov	cx, 7D0h
		mov	ax, 20h
		mov	bx, 0FFE1h
		xor	di, di

loc_1203E:				; CODE XREF: seg000:2047j
		mov	[di], ax
		mov	[di+2000h], bx
		add	di, 2
		loop	loc_1203E
		pop	ds
		assume ds:nothing
		popa
		retn

; =============== S U B	R O U T	I N E =======================================


sub_1204C	proc near		; CODE XREF: start+44p
		mov	ax, cs:word_1BDE4
		push	ax
		cmp	al, 0
		jz	short loc_1206B
		cmp	al, 1
		jz	short loc_12074
		cmp	al, 2
		jz	short loc_1207D
		cmp	al, 3
		jz	short loc_12086
		cmp	al, 4
		jz	short loc_1208F
		cmp	al, 5
		jz	short loc_12098
		jmp	short loc_120A1
; ---------------------------------------------------------------------------

loc_1206B:				; CODE XREF: sub_1204C+7j
		mov	cs:word_12233, 10
		jmp	short loc_120A1
; ---------------------------------------------------------------------------

loc_12074:				; CODE XREF: sub_1204C+Bj
		mov	cs:word_12233, 4
		jmp	short loc_120A1
; ---------------------------------------------------------------------------

loc_1207D:				; CODE XREF: sub_1204C+Fj
		mov	cs:word_12233, 3
		jmp	short loc_120A1
; ---------------------------------------------------------------------------

loc_12086:				; CODE XREF: sub_1204C+13j
		mov	cs:word_12233, 3
		jmp	short loc_120A1
; ---------------------------------------------------------------------------

loc_1208F:				; CODE XREF: sub_1204C+17j
		mov	cs:word_12233, 3
		jmp	short loc_120A1
; ---------------------------------------------------------------------------

loc_12098:				; CODE XREF: sub_1204C+1Bj
		mov	cs:word_12233, 3
		jmp	short $+2

loc_120A1:				; CODE XREF: sub_1204C+1Dj
					; sub_1204C+26j ...
		pop	ax
		cmp	ah, 0
		jz	short locret_120A9
		jmp	short $+2

locret_120A9:				; CODE XREF: sub_1204C+59j
		retn
sub_1204C	endp


; =============== S U B	R O U T	I N E =======================================


LoadFileToBuffer proc near		; CODE XREF: cmfA11_LoadSDF+9p
					; cmfA12_LoadRDF+9p ...
		mov	ax, 1
		int	7Dh		; call EXDD disk driver
		cmp	ax, 1
		jz	short loc_120B6
		clc
		retn
; ---------------------------------------------------------------------------

loc_120B6:				; CODE XREF: LoadFileToBuffer+8j
		stc
		retn
LoadFileToBuffer endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_120B8	proc near		; CODE XREF: start+5Dp	start+63p ...
		push	bp
		mov	bp, sp
		push	es
		push	di
		mov	ax, 80h	; 'Ä'
		out	7Ch, ax
		xor	ax, ax
		out	7Eh, ax
		out	7Eh, ax
		out	7Eh, ax
		out	7Eh, ax
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		xor	di, di
		mov	cx, 3E80h
		cld
		rep stosw
		jmp	short $+2
		jmp	short $+2
		mov	al, 0FFh
		out	7Eh, al
		jmp	short $+2
		jmp	short $+2
		mov	al, 0FFh
		out	7Eh, al
		jmp	short $+2
		jmp	short $+2
		mov	al, 0FFh
		out	7Eh, al
		jmp	short $+2
		jmp	short $+2
		mov	al, 0FFh
		out	7Eh, al
		xor	ax, ax
		out	7Ch, ax
		pop	di
		pop	es
		assume es:nothing
		pop	bp
		retn
sub_120B8	endp

; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		push	es
		push	di
		mov	ax, 80h	; 'Ä'
		out	7Ch, ax
		xor	ax, ax
		out	7Eh, ax
		out	7Eh, ax
		out	7Eh, ax
		out	7Eh, ax
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		xor	di, di
		mov	cx, 1F40h
		cld
		rep stosw
		jmp	short $+2
		jmp	short $+2
		mov	al, 0FFh
		out	7Eh, al
		jmp	short $+2
		jmp	short $+2
		mov	al, 0FFh
		out	7Eh, al
		jmp	short $+2
		jmp	short $+2
		mov	al, 0FFh
		out	7Eh, al
		jmp	short $+2
		jmp	short $+2
		mov	al, 0FFh
		out	7Eh, al
		xor	ax, ax
		out	7Ch, ax
		pop	di
		pop	es
		assume es:nothing
		pop	bp
		retn

; =============== S U B	R O U T	I N E =======================================


sub_1214A	proc near		; CODE XREF: start+57p
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		mov	si, 0DAh ; '⁄'
		mov	di, 4E20h
		call	LoadSFX
		mov	si, 0E5h ; 'Â'
		add	di, 64h	; 'd'
		call	LoadSFX
		mov	si, 0F0h ; ''
		add	di, 64h	; 'd'
		call	LoadSFX
		mov	si, 0FBh ; '˚'
		add	di, 64h	; 'd'
		call	LoadSFX
		mov	si, 106h
		add	di, 64h	; 'd'
		call	LoadSFX
		mov	si, 111h
		add	di, 64h	; 'd'
		call	LoadSFX
		mov	si, 11Ch
		add	di, 64h	; 'd'
		call	LoadSFX
		mov	si, 127h
		add	di, 64h	; 'd'
		call	LoadSFX
		mov	si, 132h
		add	di, 64h	; 'd'
		call	LoadSFX
		mov	si, 13Dh
		add	di, 64h	; 'd'
		call	LoadSFX
		mov	si, 148h
		add	di, 64h	; 'd'
		call	LoadSFX
		mov	si, 153h
		add	di, 64h	; 'd'
		call	LoadSFX
		mov	si, 15Eh
		add	di, 64h	; 'd'
		call	LoadSFX
		mov	si, 169h
		add	di, 64h	; 'd'
		call	LoadSFX
		mov	si, 174h
		add	di, 64h	; 'd'
		call	LoadSFX
		retn
sub_1214A	endp


; =============== S U B	R O U T	I N E =======================================


LoadFile	proc near		; CODE XREF: DetectFMChip+7p
					; sub_103A9+7p	...
		sub	di, di
		mov	si, dx
		mov	ax, 5
		int	7Dh		; call EXDD disk driver
		cmp	ax, 1
		jz	short loc_121E7
		clc			; returns data segment of file data in AX
		retn
; ---------------------------------------------------------------------------

loc_121E7:				; CODE XREF: LoadFile+Cj
		stc
		retn
LoadFile	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

WriteFile	proc near		; CODE XREF: sub_103A9+28p
					; sub_10486+B0p ...

var_6		= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2

		push	dx
		push	bx
		push	si
		push	di
		push	ds
		enter	6, 0
		mov	[bp+var_6], bx
		mov	[bp+var_4], cx
		mov	cx, 0
		mov	ah, 3Ch
		int	21h		; DOS -	2+ - CREATE A FILE WITH	HANDLE (CREAT)
					; CX = attributes for file
					; DS:DX	-> ASCIZ filename (may include drive and path)
		mov	[bp+var_2], ax
		jb	short loc_1222A
		push	es
		pop	ds
		assume ds:nothing
		mov	bx, [bp+var_2]
		mov	dx, [bp+var_6]
		mov	cx, [bp+var_4]
		mov	ah, 40h
		int	21h		; DOS -	2+ - WRITE TO FILE WITH	HANDLE
					; BX = file handle, CX = number	of bytes to write, DS:DX -> buffer
		jb	short loc_1222A
		cmp	ax, [bp+var_4]
		jnz	short loc_1222E
		mov	bx, [bp+var_2]
		mov	ah, 3Eh
		int	21h		; DOS -	2+ - CLOSE A FILE WITH HANDLE
					; BX = file handle
		jb	short loc_1222A

locret_12223:				; CODE XREF: WriteFile+43j
					; WriteFile+48j
		leave
		pop	ds
		pop	di
		pop	si
		pop	bx
		pop	dx
		retn
; ---------------------------------------------------------------------------

loc_1222A:				; CODE XREF: WriteFile+19j
					; WriteFile+2Aj ...
		mov	al, 3
		jmp	short locret_12223
; ---------------------------------------------------------------------------

loc_1222E:				; CODE XREF: WriteFile+2Fj
		mov	al, 5
		stc
		jmp	short locret_12223
WriteFile	endp

; ---------------------------------------------------------------------------
word_12233	dw 2			; DATA XREF: sub_10F09+169r
					; sub_1204C:loc_1206Bw	...
word_12235	dw 0			; DATA XREF: sub_111BF+6w
					; sub_111F3+F9w ...
byte_12237	db 0			; DATA XREF: sub_111BFw sub_111F3+100w ...
word_12238	dw 3			; DATA XREF: seg000:loc_11D89w
					; seg000:1D8Er	...
a5h1h3l		db 1Bh,'*',1Bh,'[>5h',1Bh,'[>1h',1Bh,'[>3l$' ; DATA XREF: start+9o

; =============== S U B	R O U T	I N E =======================================


CmfMainLoopA	proc near		; CODE XREF: start+119p
					; DoOneLevel:loc_105E4p
		mov	dx, si
		call	LoadFile	; load CMF file
		mov	cs:cmfDataSeg, ax
		mov	ds, ax
		mov	si, 2
		push	ds

loc_1225B:				; CODE XREF: CmfMainLoopA+29j
		cmp	cs:word_12F27, 60
		jnb	short loc_122C3
		cmp	cs:word_111EF, 0
		jnz	short loc_122C3
		lodsw
		mov	bx, ax
		shl	bx, 1
		call	word ptr cs:cmfJumpTblA[bx]
		jmp	short loc_1225B
; ---------------------------------------------------------------------------
cmfJumpTblA:				; DATA XREF: CmfMainLoopA+24r
		dw offset cmfA00_End	; 0
		dw offset cmfA01_SetMapPos; 1
		dw offset cmfA02_MoveMap; 2
		dw offset cmfA03	; 3
		dw offset sub_1260A	; 4
		dw offset sub_125FB	; 5
		dw offset sub_1260A	; 6
		dw offset cmfA07_LoadHDF; 7
		dw offset cmfA08_FreeHDF; 8
		dw offset cmfA09_AddSpr	; 9
		dw offset cmfA0A_Text	; 0Ah
		dw offset sub_12342	; 0Bh
		dw offset cmfA0C_LoadEnemies; 0Ch
		dw offset cmfA0D_LoadMDR; 0Dh
		dw offset cmfA0E_DoCockpit; 0Eh
		dw offset cmfA0F_LoadAction; 0Fh
		dw offset cmfA10_FreeAllMem; 10h
		dw offset cmfA11_LoadSDF; 11h
		dw offset cmfA12_LoadRDF; 12h
		dw offset cmfA13_LoadTDF; 13h
		dw offset cmfA14_LoadBGM; 14h
		dw offset cmfA15	; 15h
		dw offset cmfA16_SetMapPos; 16h
		dw offset cmfA17	; 17h
		dw offset cmfA18	; 18h
		dw offset cmfA19	; 19h
		dw offset cmfA1A	; 1Ah
		dw offset cmfA1B_PalFade; 1Bh
		dw offset cmfA1C_CallCMFB; 1Ch
		dw offset cmfA1D	; 1Dh
		dw offset cmfA1E	; 1Eh
		dw offset cmfA1F	; 1Fh
		dw offset cmfA20_CallEXE; 20h
		dw offset cmfA21_MissionEnd; 21h
		dw offset sub_12550	; 22h
		dw offset sub_12554	; 23h
		dw offset sub_1255A	; 24h
		dw offset sub_12560	; 25h
; ---------------------------------------------------------------------------

loc_122C3:				; CODE XREF: CmfMainLoopA+15j
					; CmfMainLoopA+1Dj ...
		pop	ds
		push	es
		mov	ax, ds
		mov	es, ax
		mov	ah, 49h
		int	21h		; DOS -	2+ - FREE MEMORY
					; ES = segment address of area to be freed
		pop	es
		clc
		retn
CmfMainLoopA	endp


; =============== S U B	R O U T	I N E =======================================


cmfA00_End	proc near		; CODE XREF: CmfMainLoopA+24p
					; DATA XREF: CmfMainLoopA:cmfJumpTblAo
		pop	ax
		jmp	short loc_122C3
cmfA00_End	endp ; sp-analysis failed


; =============== S U B	R O U T	I N E =======================================


cmfA01_SetMapPos proc near		; DATA XREF: CmfMainLoopA:cmfJumpTblAo
		lodsw
		mov	cs:MapPosX, ax
		lodsw
		mov	cs:MapPosY, ax
		retn
cmfA01_SetMapPos endp


; =============== S U B	R O U T	I N E =======================================


cmfA02_MoveMap	proc near		; DATA XREF: CmfMainLoopA:cmfJumpTblAo
		lodsw
		add	cs:MapPosX, ax
		lodsw
		add	cs:MapPosY, ax
		neg	ax
		mov	cs:BasePosY, ax
		retn
cmfA02_MoveMap	endp


; =============== S U B	R O U T	I N E =======================================


cmfA03		proc near		; DATA XREF: CmfMainLoopA:cmfJumpTblAo
		lodsw
		dec	ax
		cmp	ax, 0
		jz	short loc_12300
		mov	[si-2],	ax
		lodsw
		lodsw
		mov	si, ax
		retn
; ---------------------------------------------------------------------------

loc_12300:				; CODE XREF: cmfA03+5j
		lodsw
		mov	[si-4],	ax
		lodsw
		retn
cmfA03		endp


; =============== S U B	R O U T	I N E =======================================


cmfA09_AddSpr	proc near		; DATA XREF: CmfMainLoopA:cmfJumpTblAo
		push	si
		push	ds
		lodsw
		mov	bx, offset gfxBufPtrs_HDF
		shl	ax, 1
		add	bx, ax
		mov	bp, cs:[bx]
		lodsw
		mov	bx, ax
		lodsw
		mov	cx, ax
		lodsw
		mov	dx, ax
		lodsw
		mov	bh, al
		mov	ds, bp
		mov	ax, bx
		sub	si, si
		call	AddHDFSpr_Mode2
		pop	ds
		pop	si
		add	si, 0Ah
		retn
cmfA09_AddSpr	endp


; =============== S U B	R O U T	I N E =======================================


cmfA0A_Text	proc near		; DATA XREF: CmfMainLoopA:cmfJumpTblAo
		lodsw
		push	si
		push	ds
		mov	bx, ax
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		mov	al, 32h	; '2'
		mov	ah, 0Fh
		call	cmfLoadTxtPtr3A
		pop	ds
		assume ds:nothing
		pop	si
		retn
cmfA0A_Text	endp


; =============== S U B	R O U T	I N E =======================================


sub_12342	proc near		; DATA XREF: CmfMainLoopA:cmfJumpTblAo
		lodsw
		push	si
		push	ds
		call	sub_15EF8
		pop	ds
		pop	si
		retn
sub_12342	endp


; =============== S U B	R O U T	I N E =======================================


cmfA0C_LoadEnemies proc	near		; DATA XREF: CmfMainLoopA:cmfJumpTblAo
		lodsw
		mov	cx, ax
		lodsw
		mov	dx, ax
		lodsw
		push	si
		push	ds
		call	cmfA_LoadEnemies
		pop	ds
		pop	si
		retn
cmfA0C_LoadEnemies endp


; =============== S U B	R O U T	I N E =======================================


cmfA0D_LoadMDR	proc near		; DATA XREF: CmfMainLoopA:cmfJumpTblAo
		push	es
		push	ds
		pusha
		mov	dx, si
		call	LoadFile	; load MDR file
		mov	ds, ax
		push	ds
		sub	si, si
		call	sub_1C058
		pop	ds
		push	es
		mov	ax, ds
		mov	es, ax
		mov	ah, 49h
		int	21h		; DOS -	2+ - FREE MEMORY
					; ES = segment address of area to be freed
		pop	es
		popa
		pop	ds
		pop	es

loc_12378:				; CODE XREF: cmfA0D_LoadMDR+21j
		lodsb
		or	al, al
		jnz	short loc_12378
		retn
cmfA0D_LoadMDR	endp


; =============== S U B	R O U T	I N E =======================================


cmfA0E_DoCockpit proc near		; DATA XREF: CmfMainLoopA:cmfJumpTblAo
		push	si
		push	ds
		call	LoadCockpit
		pop	ds
		pop	si
		retn
cmfA0E_DoCockpit endp


; =============== S U B	R O U T	I N E =======================================


cmfA0F_LoadAction proc near		; DATA XREF: CmfMainLoopA:cmfJumpTblAo
		push	si
		push	ds
		call	SetupAction
		pop	ds
		pop	si
		retn
cmfA0F_LoadAction endp


; =============== S U B	R O U T	I N E =======================================


cmfA10_FreeAllMem proc near		; DATA XREF: CmfMainLoopA:cmfJumpTblAo
		push	si
		push	ds
		call	cmfA_FreeAllMem
		pop	ds
		pop	si
		retn
cmfA10_FreeAllMem endp


; =============== S U B	R O U T	I N E =======================================


cmfA11_LoadSDF	proc near		; DATA XREF: CmfMainLoopA:cmfJumpTblAo
		push	si
		push	ds
		mov	es, cs:gfxBufPtr_SDF
		sub	di, di
		call	LoadFileToBuffer
		pop	ds
		pop	si

loc_123A4:				; CODE XREF: cmfA11_LoadSDF+11j
		lodsb
		or	al, al
		jnz	short loc_123A4
		retn
cmfA11_LoadSDF	endp


; =============== S U B	R O U T	I N E =======================================


cmfA12_LoadRDF	proc near		; DATA XREF: CmfMainLoopA:cmfJumpTblAo
		push	si
		push	ds
		mov	es, cs:gfxBufPtr_RDF
		sub	di, di
		call	LoadFileToBuffer
		call	sub_1BAEF
		pop	ds
		pop	si

loc_123BB:				; CODE XREF: cmfA12_LoadRDF+14j
		lodsb
		or	al, al
		jnz	short loc_123BB
		retn
cmfA12_LoadRDF	endp


; =============== S U B	R O U T	I N E =======================================


cmfA13_LoadTDF	proc near		; DATA XREF: CmfMainLoopA:cmfJumpTblAo
		push	si
		push	ds
		mov	es, cs:gfxBufPtr_TDF
		sub	di, di
		call	LoadFileToBuffer
		pop	ds
		pop	si

loc_123CF:				; CODE XREF: cmfA13_LoadTDF+11j
		lodsb
		or	al, al
		jnz	short loc_123CF
		retn
cmfA13_LoadTDF	endp


; =============== S U B	R O U T	I N E =======================================


cmfA14_LoadBGM	proc near		; DATA XREF: CmfMainLoopA:cmfJumpTblAo
		push	si
		push	ds
		push	si
		push	ds
		mov	dx, 0
		call	Music_Stop
		pop	ds
		pop	si
		sub	di, di
		call	Music_Load
		sub	si, si
		mov	dx, 0
		call	Music_Start
		pop	ds
		pop	si

loc_123F0:				; CODE XREF: cmfA14_LoadBGM+1Ej
		lodsb
		or	al, al
		jnz	short loc_123F0
		retn
cmfA14_LoadBGM	endp


; =============== S U B	R O U T	I N E =======================================


cmfA15		proc near		; DATA XREF: CmfMainLoopA:cmfJumpTblAo
		push	si
		push	ds
		call	sub_175CD
		call	sub_1654D
		mov	cs:BasePosX, 0
		mov	cs:BasePosY, 0
		mov	cs:word_1EA68, 24h ; '$'
		mov	cs:word_1EA5C, 3
		mov	cs:word_1EA54, 0
		mov	cs:word_1EA58, 0
		call	sub_1BA1A
		pop	ds
		pop	si
		retn
cmfA15		endp


; =============== S U B	R O U T	I N E =======================================


cmfA16_SetMapPos proc near		; DATA XREF: CmfMainLoopA:cmfJumpTblAo
		lodsw
		mov	cs:MapPosX, ax
		lodsw
		mov	cs:MapPosY, ax
		retn
cmfA16_SetMapPos endp


; =============== S U B	R O U T	I N E =======================================


cmfA17		proc near		; DATA XREF: CmfMainLoopA:cmfJumpTblAo
		lodsw
		mov	cs:word_1BE30, ax
		retn
cmfA17		endp


; =============== S U B	R O U T	I N E =======================================


cmfA18		proc near		; DATA XREF: CmfMainLoopA:cmfJumpTblAo
		lodsw
		push	si
		push	ds
		call	sub_1BB7E
		pop	ds
		pop	si
		retn
cmfA18		endp


; =============== S U B	R O U T	I N E =======================================


cmfA19		proc near		; DATA XREF: CmfMainLoopA:cmfJumpTblAo
		lodsw
		mov	cs:word_1EA52, ax
		mov	cs:word_13399, ax
		lodsw
		mov	cs:word_1EA56, ax
		mov	cs:word_1339D, ax
		retn
cmfA19		endp


; =============== S U B	R O U T	I N E =======================================


cmfA1A		proc near		; DATA XREF: CmfMainLoopA:cmfJumpTblAo
		lodsw
		mov	cs:word_111DF, ax
		lodsw
		mov	cs:word_111E1, ax
		lodsw
		mov	cs:word_111E3, ax
		lodsw
		mov	cs:word_111E5, ax
		retn
cmfA1A		endp


; =============== S U B	R O U T	I N E =======================================


cmfA1B_PalFade	proc near		; DATA XREF: CmfMainLoopA:cmfJumpTblAo
		lodsw
		push	si
		push	ds
		mov	si, ax
		call	Palette_Refresh
		call	Palette_DoBlack
		pop	ds
		pop	si
		retn
cmfA1B_PalFade	endp


; =============== S U B	R O U T	I N E =======================================


cmfA1C_CallCMFB	proc near		; DATA XREF: CmfMainLoopA:cmfJumpTblAo
		lodsw
		push	si
		push	ds
		mov	cs:cmfMainBStartPos, ax
		mov	cs:byte_12237, 0
		mov	cs:word_12235, 1
		call	DrawHUD
		call	sub_10F09
		call	cmfA_FreeAllHDF
		pop	ds
		pop	si
		retn
cmfA1C_CallCMFB	endp


; =============== S U B	R O U T	I N E =======================================


cmfA1D		proc near		; DATA XREF: CmfMainLoopA:cmfJumpTblAo
		lodsw
		push	si
		push	ds
		mov	si, ax
		call	LoadVDFPalette
		mov	ax, cs
		mov	ds, ax
		assume ds:seg000
		mov	es, ax
		assume es:seg000
		cld
		mov	si, offset PaletteBuffer
		mov	di, (offset PaletteBuffer+60h)
		mov	cx, 30h
		rep movsw
		pop	ds
		assume ds:nothing
		pop	si
		retn
cmfA1D		endp


; =============== S U B	R O U T	I N E =======================================


cmfA1E		proc near		; DATA XREF: CmfMainLoopA:cmfJumpTblAo
		lodsw
		mov	cs:word_12FA9, ax
		retn
cmfA1E		endp


; =============== S U B	R O U T	I N E =======================================


cmfA1F		proc near		; DATA XREF: CmfMainLoopA:cmfJumpTblAo
		lodsw
		mov	cs:word_15FDA, ax
		lodsw
		mov	cs:word_15FDC, ax
		retn
cmfA1F		endp


; =============== S U B	R O U T	I N E =======================================


cmfA20_CallEXE	proc near		; DATA XREF: CmfMainLoopA:cmfJumpTblAo
		push	es
		push	ds
		pusha
		mov	cs:byte_12523, 2
		mov	byte ptr cs:fileNameBuffer, ' ' ; "                    \r"
		mov	byte ptr cs:fileNameBuffer+1, ' '
		mov	byte ptr cs:fileNameBuffer+2, 0Dh
		mov	ax, cs
		mov	es, ax
		mov	dx, si
		mov	bx, (offset fileNameBuffer+15h)
		mov	cs:word_1253B, offset byte_12523
		mov	cs:word_1253D, cs
		mov	cs:word_1253F, 5Ch
		mov	cs:word_12541, cs
		mov	cs:word_12543, 6Ch
		mov	cs:word_12545, cs
		mov	al, 0
		mov	ah, 4Bh
		int	21h		; DOS -	2+ - LOAD OR EXECUTE (EXEC)
					; DS:DX	-> ASCIZ filename
					; ES:BX	-> parameter block
					; AL = subfunc:	load & execute program
		popa
		pop	ds
		pop	es
		assume es:nothing

loc_1251D:				; CODE XREF: cmfA20_CallEXE+54j
		lodsb
		cmp	al, 0
		jnz	short loc_1251D
		retn
cmfA20_CallEXE	endp

; ---------------------------------------------------------------------------
byte_12523	db 14h			; DATA XREF: cmfA20_CallEXE+3w
					; cmfA20_CallEXE+24o
fileNameBuffer	db '                    ',0Dh,0 ; DATA XREF: cmfA20_CallEXE+9w
					; cmfA20_CallEXE+Fw ...
		db 0
word_1253B	dw 0			; DATA XREF: cmfA20_CallEXE+24w
word_1253D	dw 0			; DATA XREF: cmfA20_CallEXE+2Bw
word_1253F	dw 0			; DATA XREF: cmfA20_CallEXE+30w
word_12541	dw 0			; DATA XREF: cmfA20_CallEXE+37w
word_12543	dw 0			; DATA XREF: cmfA20_CallEXE+3Cw
word_12545	dw 0			; DATA XREF: cmfA20_CallEXE+43w

; =============== S U B	R O U T	I N E =======================================


cmfA21_MissionEnd proc near		; DATA XREF: CmfMainLoopA:cmfJumpTblAo
		lodsw
		push	si
		push	ds
		call	ShowMissionEnd
		pop	ds
		pop	si
		retn
cmfA21_MissionEnd endp


; =============== S U B	R O U T	I N E =======================================


sub_12550	proc near		; DATA XREF: CmfMainLoopA:cmfJumpTblAo
		call	sub_18B77
		retn
sub_12550	endp


; =============== S U B	R O U T	I N E =======================================


sub_12554	proc near		; DATA XREF: CmfMainLoopA:cmfJumpTblAo
		lodsw
		mov	cs:word_12FAD, ax
		retn
sub_12554	endp


; =============== S U B	R O U T	I N E =======================================


sub_1255A	proc near		; DATA XREF: CmfMainLoopA:cmfJumpTblAo
		lodsw
		mov	cs:ShiedLowState, ax
		retn
sub_1255A	endp


; =============== S U B	R O U T	I N E =======================================


sub_12560	proc near		; DATA XREF: CmfMainLoopA:cmfJumpTblAo
		lodsw
		mov	cs:word_1EA76, ax
		retn
sub_12560	endp

; ---------------------------------------------------------------------------
cmfDataSeg	dw 0			; DATA XREF: CmfMainLoopA+5w
					; sub_17619+9r	...

; =============== S U B	R O U T	I N E =======================================


cmfA07_LoadHDF	proc near		; CODE XREF: sub_16DC1+3p
					; DATA XREF: CmfMainLoopA:cmfJumpTblAo
		mov	dx, si
		push	si
		call	LoadFile	; load HDF file
		pop	si
		mov	dx, ax
		cld

loc_12572:				; CODE XREF: cmfA07_LoadHDF+Dj
		lodsb
		or	al, al
		jnz	short loc_12572
		lodsw
		mov	bx, offset gfxBufPtrs_HDF
		shl	ax, 1
		add	bx, ax
		cmp	word ptr cs:[bx], 0
		jnz	short loc_12589

loc_12585:				; CODE XREF: cmfA07_LoadHDF+32j
		mov	cs:[bx], dx	; save segment
		retn
; ---------------------------------------------------------------------------

loc_12589:				; CODE XREF: cmfA07_LoadHDF+1Bj
		push	es
		push	ds
		pusha
		push	ds
		push	cs
		pop	ds
		assume ds:seg000
		mov	dx, offset aCC_loadspriteV ; "ñΩóﬂ : .LoadSprite Ç…àŸèÌÇ™Ç†ÇËÇ‹Ç∑.\r\n$"
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		pop	ds
		assume ds:nothing
		popa
		pop	ds
		pop	es
		jmp	short loc_12585
cmfA07_LoadHDF	endp

; ---------------------------------------------------------------------------
aCC_loadspriteV	db 'ñΩóﬂ : .LoadSprite Ç…àŸèÌÇ™Ç†ÇËÇ‹Ç∑.',0Dh,0Ah,'$'
					; DATA XREF: cmfA07_LoadHDF+27o

; =============== S U B	R O U T	I N E =======================================


cmfA08_FreeHDF	proc near		; CODE XREF: sub_16DCC+2p
					; DATA XREF: CmfMainLoopA:cmfJumpTblAo
		lodsw
cmfA08_FreeHDF	endp ; sp-analysis failed


; =============== S U B	R O U T	I N E =======================================


cmfA_FreeHDF	proc near		; CODE XREF: cmfA_FreeAllHDF+4p
		pusha
		push	ds
		mov	bx, offset gfxBufPtrs_HDF
		shl	ax, 1
		add	bx, ax
		cmp	word ptr cs:[bx], 0
		jz	short loc_125E9
		mov	ax, cs:[bx]
		mov	ds, ax
		push	bx
		push	es
		mov	ax, ds
		mov	es, ax
		mov	ah, 49h
		int	21h		; DOS -	2+ - FREE MEMORY
					; ES = segment address of area to be freed
		pop	es
		pop	bx
		mov	word ptr cs:[bx], 0

loc_125E9:				; CODE XREF: cmfA_FreeHDF+Dj
		pop	ds
		popa
		retn
cmfA_FreeHDF	endp


; =============== S U B	R O U T	I N E =======================================


cmfA_FreeAllHDF	proc near		; CODE XREF: cmfA_FreeAllMem+11Dp
					; cmfA1C_CallCMFB+1Ap
		mov	ax, 0

loc_125EF:				; CODE XREF: cmfA_FreeAllHDF+Cj
		push	ax
		call	cmfA_FreeHDF
		pop	ax
		inc	ax
		cmp	ax, 14h
		jnz	short loc_125EF
		retn
cmfA_FreeAllHDF	endp


; =============== S U B	R O U T	I N E =======================================


sub_125FB	proc near		; DATA XREF: CmfMainLoopA:cmfJumpTblAo
		push	si
		push	ds
		mov	cs:word_11FCC, 0
		call	sub_1AAC8
		pop	ds
		pop	si
		retn
sub_125FB	endp


; =============== S U B	R O U T	I N E =======================================


sub_1260A	proc near		; CODE XREF: sub_10F09+54p
					; DATA XREF: CmfMainLoopA:cmfJumpTblAo
		cmp	cs:word_12FAD, 1
		jz	short loc_1262F
		cmp	cs:word_1EA56, 0B4h ; '¥'
		jb	short loc_1262F
		mov	ax, 28h	; '('
		call	sub_13EE7
		mov	cs:word_1EA58, 0FFF4h
		mov	cs:word_12F41, 0

loc_1262F:				; CODE XREF: sub_1260A+6j sub_1260A+Fj
		mov	ax, cs:BasePosX
		add	cs:word_1EA52, ax
		mov	ax, cs:BasePosY
		add	cs:word_1EA56, ax
		cmp	cs:word_12F27, 0
		jz	short loc_1264C
		jmp	loc_12F51
; ---------------------------------------------------------------------------

loc_1264C:				; CODE XREF: sub_1260A+3Dj
		cmp	cs:word_12F4B, 0
		jz	short loc_12659
		dec	cs:word_12F4B

loc_12659:				; CODE XREF: sub_1260A+48j
		cmp	cs:word_12F4D, 0
		jz	short loc_12666
		dec	cs:word_12F4D

loc_12666:				; CODE XREF: sub_1260A+55j
		sub	dx, dx
		cmp	cs:word_12F33, 0
		jnz	short loc_12673
		call	sub_195EE

loc_12673:				; CODE XREF: sub_1260A+64j
		test	dx, 80h
		jz	short loc_12680
		mov	cs:word_13EE5, 1

loc_12680:				; CODE XREF: sub_1260A+6Dj
		test	dx, 8
		jz	short loc_126C8
		mov	ax, 40h	; '@'
		call	sub_13E85
		mov	ax, 2
		add	cs:word_1EA54, ax
		mov	cs:word_1EA5C, 3
		cmp	cs:word_12FA9, 2
		jnz	short loc_126AA
		mov	cs:word_1EA54, 10h

loc_126AA:				; CODE XREF: sub_1260A+97j
		cmp	cs:word_12FA9, 0
		jnz	short loc_126C8
		cmp	cs:word_12F4B, 2
		jnz	short loc_126C1
		mov	cs:word_12F47, 14h

loc_126C1:				; CODE XREF: sub_1260A+AEj
		mov	cs:word_12F4B, 4

loc_126C8:				; CODE XREF: sub_1260A+7Aj
					; sub_1260A+A6j
		test	dx, 2
		jz	short loc_126EF
		mov	ax, 80h	; 'Ä'
		call	sub_13E85
		cmp	cs:word_12FA9, 0
		jz	short loc_126EF
		inc	cs:word_1EA58
		cmp	cs:word_12FA9, 2
		jnz	short loc_126EF
		add	cs:word_1EA58, 3

loc_126EF:				; CODE XREF: sub_1260A+C2j
					; sub_1260A+D0j ...
		test	dx, 4
		jz	short loc_12737
		mov	ax, 40h	; '@'
		call	sub_13E85
		mov	ax, 2
		sub	cs:word_1EA54, ax
		mov	cs:word_1EA5C, 0
		cmp	cs:word_12FA9, 2
		jnz	short loc_12719
		mov	cs:word_1EA54, 0FFF0h

loc_12719:				; CODE XREF: sub_1260A+106j
		cmp	cs:word_12FA9, 0
		jnz	short loc_12737
		cmp	cs:word_12F4D, 2
		jnz	short loc_12730
		mov	cs:word_12F47, 14h

loc_12730:				; CODE XREF: sub_1260A+11Dj
		mov	cs:word_12F4D, 4

loc_12737:				; CODE XREF: sub_1260A+E9j
					; sub_1260A+115j
		test	dx, 1
		jz	short loc_1275D
		sub	ax, ax
		call	sub_13E85
		cmp	cs:word_12FA9, 0
		jz	short loc_1275D
		dec	cs:word_1EA58
		cmp	cs:word_12FA9, 2
		jnz	short loc_1275D
		sub	cs:word_1EA58, 3

loc_1275D:				; CODE XREF: sub_1260A+131j
					; sub_1260A+13Ej ...
		test	dx, 20h
		jnz	short loc_12766
		jmp	loc_1281A
; ---------------------------------------------------------------------------

loc_12766:				; CODE XREF: sub_1260A+157j
		cmp	cs:word_12FA9, 0
		jnz	short loc_127ED
		test	cs:word_12F4F, 20h
		jnz	short loc_1277E
		mov	cs:word_12F3B, 1

loc_1277E:				; CODE XREF: sub_1260A+16Bj
		cmp	cs:word_12F3D, 1
		jz	short loc_127D7
		cmp	cs:word_12F37, 0
		jz	short loc_12791
		jmp	loc_1281A
; ---------------------------------------------------------------------------

loc_12791:				; CODE XREF: sub_1260A+182j
		cmp	cs:word_1EA58, 0
		jz	short loc_127A2
		test	cs:word_1EA58, 8000h
		jz	short loc_127CE

loc_127A2:				; CODE XREF: sub_1260A+18Dj
		mov	cs:word_12F47, 0
		cmp	cs:word_12F3B, 0
		jz	short loc_127CE
		cmp	cs:word_12F39, 4
		jnb	short loc_127CE
		inc	cs:word_12F39
		mov	cs:word_1EA58, 0FFF8h
		mov	cs:word_12F35, 8
		jmp	short loc_12836
; ---------------------------------------------------------------------------

loc_127CE:				; CODE XREF: sub_1260A+196j
					; sub_1260A+1A5j ...
		mov	cs:word_12F3D, 1
		jmp	short loc_12836
; ---------------------------------------------------------------------------

loc_127D7:				; CODE XREF: sub_1260A+17Aj
		test	cs:word_1EA58, 8000h
		jnz	short loc_12836
		cmp	cs:word_13DAD, 2
		jz	short loc_127ED
		inc	cs:word_12F41

loc_127ED:				; CODE XREF: sub_1260A+162j
					; sub_1260A+1DCj
		mov	cs:word_12F49, 1
		cmp	cs:word_12F41, 14h
		jnb	short loc_12828
		cmp	cs:word_12F3F, 0Eh
		jnb	short loc_12836
		add	cs:word_12F3F, 2
		mov	cs:word_12F43, 1
		mov	cs:word_12F45, 1
		jmp	short loc_12836
; ---------------------------------------------------------------------------

loc_1281A:				; CODE XREF: sub_1260A+159j
					; sub_1260A+184j
		mov	cs:word_12F49, 0
		mov	cs:word_12F43, 0

loc_12828:				; CODE XREF: sub_1260A+1F0j
		mov	cs:word_12F3B, 0
		mov	cs:word_12F45, 0

loc_12836:				; CODE XREF: sub_1260A+1C2j
					; sub_1260A+1CBj ...
		cmp	cs:word_12F3F, 0
		jz	short loc_12843
		dec	cs:word_12F3F

loc_12843:				; CODE XREF: sub_1260A+232j
		test	dx, 10h
		jz	short loc_1285B
		cmp	cs:word_103A5, 0
		jz	short loc_12858
		mov	cs:word_13EE5, 1

loc_12858:				; CODE XREF: sub_1260A+245j
		call	sub_138A5

loc_1285B:				; CODE XREF: sub_1260A+23Dj
		cmp	cs:word_139EC, 0
		jz	short loc_12868
		dec	cs:word_139EC

loc_12868:				; CODE XREF: sub_1260A+257j
		cmp	cs:word_139EE, 0
		jz	short loc_12875
		dec	cs:word_139EE

loc_12875:				; CODE XREF: sub_1260A+264j
		cmp	cs:word_139F0, 0
		jz	short loc_12882
		dec	cs:word_139F0

loc_12882:				; CODE XREF: sub_1260A+271j
		test	dx, 40h
		jz	short loc_1288B
		call	sub_12FAF

loc_1288B:				; CODE XREF: sub_1260A+27Cj
		mov	cs:word_12F4F, dx
		cmp	cs:word_12FA9, 0
		jz	short loc_1289B
		jmp	loc_129A6
; ---------------------------------------------------------------------------

loc_1289B:				; CODE XREF: sub_1260A+28Cj
		cmp	cs:word_13DAD, 3
		jnz	short loc_128A6
		jmp	loc_12926
; ---------------------------------------------------------------------------

loc_128A6:				; CODE XREF: sub_1260A+297j
		cmp	cs:word_12F47, 0
		jnz	short loc_128EB
		mov	ax, cs:word_1EA54
		cmp	ax, 0
		jz	short loc_128E4
		test	ah, 80h
		jz	short loc_128D3
		cmp	cs:word_1EA58, 0
		jnz	short loc_128C5
		inc	ax

loc_128C5:				; CODE XREF: sub_1260A+2B8j
		push	ax
		neg	ax
		cmp	ax, 8
		pop	ax
		jb	short loc_128E4
		mov	ax, 0FFF8h
		jmp	short loc_128E4
; ---------------------------------------------------------------------------

loc_128D3:				; CODE XREF: sub_1260A+2B0j
		cmp	cs:word_1EA58, 0
		jnz	short loc_128DC
		dec	ax

loc_128DC:				; CODE XREF: sub_1260A+2CFj
		cmp	ax, 8
		jb	short loc_128E4
		mov	ax, 8

loc_128E4:				; CODE XREF: sub_1260A+2ABj
					; sub_1260A+2C2j ...
		mov	cs:word_1EA54, ax
		jmp	loc_12A52
; ---------------------------------------------------------------------------

loc_128EB:				; CODE XREF: sub_1260A+2A2j
		mov	ax, cs:word_1EA54
		cmp	ax, 0
		jz	short loc_1291F
		test	ah, 80h
		jz	short loc_1290F
		cmp	cs:word_1EA58, 0
		jnz	short $+2
		push	ax
		neg	ax
		cmp	ax, 0Eh
		pop	ax
		jb	short loc_1291F
		mov	ax, 0FFF2h
		jmp	short loc_1291F
; ---------------------------------------------------------------------------

loc_1290F:				; CODE XREF: sub_1260A+2EDj
		cmp	cs:word_1EA58, 0
		jnz	short $+2
		cmp	ax, 0Eh
		jb	short loc_1291F
		mov	ax, 0Eh

loc_1291F:				; CODE XREF: sub_1260A+2E8j
					; sub_1260A+2FEj ...
		mov	cs:word_1EA54, ax
		jmp	loc_12A52
; ---------------------------------------------------------------------------

loc_12926:				; CODE XREF: sub_1260A+299j
		cmp	cs:word_12F47, 0
		jnz	short loc_1296B
		mov	ax, cs:word_1EA54
		cmp	ax, 0
		jz	short loc_12964
		test	ah, 80h
		jz	short loc_12953
		cmp	cs:word_1EA58, 0
		jnz	short loc_12945
		inc	ax

loc_12945:				; CODE XREF: sub_1260A+338j
		push	ax
		neg	ax
		cmp	ax, 7
		pop	ax
		jb	short loc_12964
		mov	ax, 0FFF9h
		jmp	short loc_12964
; ---------------------------------------------------------------------------

loc_12953:				; CODE XREF: sub_1260A+330j
		cmp	cs:word_1EA58, 0
		jnz	short loc_1295C
		dec	ax

loc_1295C:				; CODE XREF: sub_1260A+34Fj
		cmp	ax, 7
		jb	short loc_12964
		mov	ax, 7

loc_12964:				; CODE XREF: sub_1260A+32Bj
					; sub_1260A+342j ...
		mov	cs:word_1EA54, ax
		jmp	loc_12A52
; ---------------------------------------------------------------------------

loc_1296B:				; CODE XREF: sub_1260A+322j
		mov	ax, cs:word_1EA54
		cmp	ax, 0
		jz	short loc_1299F
		test	ah, 80h
		jz	short loc_1298F
		cmp	cs:word_1EA58, 0
		jnz	short $+2
		push	ax
		neg	ax
		cmp	ax, 0Ah
		pop	ax
		jb	short loc_1299F
		mov	ax, 0FFF6h
		jmp	short loc_1299F
; ---------------------------------------------------------------------------

loc_1298F:				; CODE XREF: sub_1260A+36Dj
		cmp	cs:word_1EA58, 0
		jnz	short $+2
		cmp	ax, 0Ah
		jb	short loc_1299F
		mov	ax, 0Ah

loc_1299F:				; CODE XREF: sub_1260A+368j
					; sub_1260A+37Ej ...
		mov	cs:word_1EA54, ax
		jmp	loc_12A52
; ---------------------------------------------------------------------------

loc_129A6:				; CODE XREF: sub_1260A+28Ej
		cmp	cs:word_12F49, 0
		jnz	short loc_12A00
		mov	ax, cs:word_1EA54
		cmp	ax, 0
		jz	short loc_129D2
		test	ah, 80h
		jz	short loc_129CA
		push	ax
		neg	ax
		cmp	ax, 8
		pop	ax
		jb	short loc_129D2
		mov	ax, 0FFF8h
		jmp	short loc_129D2
; ---------------------------------------------------------------------------

loc_129CA:				; CODE XREF: sub_1260A+3B0j
		cmp	ax, 8
		jb	short loc_129D2
		mov	ax, 8

loc_129D2:				; CODE XREF: sub_1260A+3ABj
					; sub_1260A+3B9j ...
		mov	cs:word_1EA54, ax
		mov	ax, cs:word_1EA58
		cmp	ax, 0
		jz	short loc_129FA
		test	ah, 80h
		jz	short loc_129F2
		push	ax
		neg	ax
		cmp	ax, 4
		pop	ax
		jb	short loc_129FA
		mov	ax, 0FFFCh
		jmp	short loc_129FA
; ---------------------------------------------------------------------------

loc_129F2:				; CODE XREF: sub_1260A+3D8j
		cmp	ax, 4
		jb	short loc_129FA
		mov	ax, 4

loc_129FA:				; CODE XREF: sub_1260A+3D3j
					; sub_1260A+3E1j ...
		mov	cs:word_1EA58, ax
		jmp	short loc_12A52
; ---------------------------------------------------------------------------

loc_12A00:				; CODE XREF: sub_1260A+3A2j
		mov	ax, cs:word_1EA54
		cmp	ax, 0
		jz	short loc_12A24
		test	ah, 80h
		jz	short loc_12A1C
		push	ax
		neg	ax
		cmp	ax, 10h
		pop	ax
		jb	short loc_12A24
		mov	ax, 0FFF0h
		jmp	short loc_12A24
; ---------------------------------------------------------------------------

loc_12A1C:				; CODE XREF: sub_1260A+402j
		cmp	ax, 10h
		jb	short loc_12A24
		mov	ax, 10h

loc_12A24:				; CODE XREF: sub_1260A+3FDj
					; sub_1260A+40Bj ...
		mov	cs:word_1EA54, ax
		mov	ax, cs:word_1EA58
		cmp	ax, 0
		jz	short loc_12A4C
		test	ah, 80h
		jz	short loc_12A44
		push	ax
		neg	ax
		cmp	ax, 8
		pop	ax
		jb	short loc_12A4C
		mov	ax, 0FFF8h
		jmp	short loc_12A4C
; ---------------------------------------------------------------------------

loc_12A44:				; CODE XREF: sub_1260A+42Aj
		cmp	ax, 8
		jb	short loc_12A4C
		mov	ax, 8

loc_12A4C:				; CODE XREF: sub_1260A+425j
					; sub_1260A+433j ...
		mov	cs:word_1EA58, ax
		jmp	short $+2

loc_12A52:				; CODE XREF: sub_1260A+2DEj
					; sub_1260A+319j ...
		mov	ax, cs:word_1EA54
		add	cs:word_1EA52, ax
		mov	ax, cs:word_1EA58
		cmp	cs:word_12FA9, 0
		jnz	short loc_12A6C
		sub	ax, cs:word_12F3F

loc_12A6C:				; CODE XREF: sub_1260A+45Bj
		add	cs:word_1EA56, ax
		cmp	cs:word_12FA9, 2
		jnz	short loc_12A87
		mov	cs:word_1EA54, 0
		mov	cs:word_1EA58, 0

loc_12A87:				; CODE XREF: sub_1260A+46Dj
		mov	cx, cs:word_1EA52
		mov	dx, cs:word_1EA56
		call	sub_140F9
		cmp	cs:word_12FA9, 0
		jz	short loc_12A9F
		jmp	loc_12B53
; ---------------------------------------------------------------------------

loc_12A9F:				; CODE XREF: sub_1260A+490j
		call	sub_140BC
		jnb	short loc_12ADE
		cmp	cs:word_12F35, 6
		jb	short loc_12AB3
		mov	cs:word_12F47, 0

loc_12AB3:				; CODE XREF: sub_1260A+4A0j
		inc	cs:word_12F35
		inc	cs:word_1EA58
		test	cs:word_1EA58, 8000h
		jz	short loc_12AC9
		jmp	loc_12B92
; ---------------------------------------------------------------------------

loc_12AC9:				; CODE XREF: sub_1260A+4BAj
		cmp	cs:word_1EA58, 8
		jnb	short loc_12AD4
		jmp	loc_12B92
; ---------------------------------------------------------------------------

loc_12AD4:				; CODE XREF: sub_1260A+4C5j
		mov	cs:word_1EA58, 8
		jmp	loc_12B92
; ---------------------------------------------------------------------------

loc_12ADE:				; CODE XREF: sub_1260A+498j
		mov	bx, 19h

loc_12AE1:				; CODE XREF: sub_1260A+4E4j
		dec	cs:word_1EA56
		dec	bx
		jz	short loc_12AF2
		push	bx
		call	sub_140BC
		pop	bx
		jnb	short loc_12AE1
		jmp	short loc_12B1A
; ---------------------------------------------------------------------------

loc_12AF2:				; CODE XREF: sub_1260A+4DDj
		mov	cx, cs:word_1EA52
		mov	dx, cs:word_1EA56
		mov	ax, 30h	; '0'
		call	GetRandomInRange
		add	cx, ax
		mov	ax, 30h	; '0'
		call	GetRandomInRange
		add	dx, ax
		mov	ax, 2
		call	sub_15EF8
		mov	ax, 0Ah
		call	sub_13EE7
		jmp	short loc_12B29
; ---------------------------------------------------------------------------

loc_12B1A:				; CODE XREF: sub_1260A+4E6j
		cmp	cs:word_12F35, 6
		jb	short loc_12B29
		mov	cs:word_12F37, 0Ch

loc_12B29:				; CODE XREF: sub_1260A+50Ej
					; sub_1260A+516j
		inc	cs:word_1EA56
		mov	cs:word_1EA58, 0
		mov	cs:word_12F35, 0
		mov	cs:word_12F39, 0
		mov	cs:word_12F41, 0
		mov	cs:word_12F3D, 0
		jmp	short loc_12B92
; ---------------------------------------------------------------------------

loc_12B53:				; CODE XREF: sub_1260A+492j
		mov	bx, 19h

loc_12B56:				; CODE XREF: sub_1260A+559j
		dec	cs:word_1EA56
		dec	bx
		jz	short loc_12B67
		push	bx
		call	sub_140BC
		pop	bx
		jnb	short loc_12B56
		jmp	short loc_12B8D
; ---------------------------------------------------------------------------

loc_12B67:				; CODE XREF: sub_1260A+552j
		mov	cx, cs:word_1EA52
		mov	dx, cs:word_1EA56
		mov	ax, 30h	; '0'
		call	GetRandomInRange
		add	cx, ax
		mov	ax, 30h	; '0'
		call	GetRandomInRange
		add	dx, ax
		mov	ax, 2
		call	sub_15EF8
		mov	ax, 0Ah
		call	sub_13EE7

loc_12B8D:				; CODE XREF: sub_1260A+55Bj
		inc	cs:word_1EA56

loc_12B92:				; CODE XREF: sub_1260A+4BCj
					; sub_1260A+4C7j ...
		mov	bx, 19h

loc_12B95:				; CODE XREF: sub_1260A+59Dj
		inc	cs:word_1EA52
		inc	cs:word_1EA52
		dec	bx
		jz	short loc_12BAB
		push	bx
		call	sub_14094
		pop	bx
		jnb	short loc_12B95
		jmp	short loc_12BD1
; ---------------------------------------------------------------------------

loc_12BAB:				; CODE XREF: sub_1260A+596j
		mov	cx, cs:word_1EA52
		mov	dx, cs:word_1EA56
		mov	ax, 30h	; '0'
		call	GetRandomInRange
		add	cx, ax
		mov	ax, 30h	; '0'
		call	GetRandomInRange
		add	dx, ax
		mov	ax, 2
		call	sub_15EF8
		mov	ax, 0Ah
		call	sub_13EE7

loc_12BD1:				; CODE XREF: sub_1260A+59Fj
		dec	cs:word_1EA52
		dec	cs:word_1EA52
		mov	bx, 19h

loc_12BDE:				; CODE XREF: sub_1260A+5E6j
		dec	cs:word_1EA52
		dec	cs:word_1EA52
		dec	bx
		jz	short loc_12BF4
		push	bx
		call	sub_1406C
		pop	bx
		jnb	short loc_12BDE
		jmp	short loc_12C1A
; ---------------------------------------------------------------------------

loc_12BF4:				; CODE XREF: sub_1260A+5DFj
		mov	cx, cs:word_1EA52
		mov	dx, cs:word_1EA56
		mov	ax, 30h	; '0'
		call	GetRandomInRange
		add	cx, ax
		mov	ax, 30h	; '0'
		call	GetRandomInRange
		add	dx, ax
		mov	ax, 2
		call	sub_15EF8
		mov	ax, 0Ah
		call	sub_13EE7

loc_12C1A:				; CODE XREF: sub_1260A+5E8j
		inc	cs:word_1EA52

loc_12C1F:
		inc	cs:word_1EA52
		mov	bx, 19h

loc_12C27:				; CODE XREF: sub_1260A+62Aj
		inc	cs:word_1EA56
		dec	bx
		jz	short loc_12C38
		push	bx
		call	sub_14135
		pop	bx
		jnb	short loc_12C27
		jmp	short loc_12C5E
; ---------------------------------------------------------------------------

loc_12C38:				; CODE XREF: sub_1260A+623j
		mov	cx, cs:word_1EA52
		mov	dx, cs:word_1EA56
		mov	ax, 30h	; '0'
		call	GetRandomInRange
		add	cx, ax
		mov	ax, 30h	; '0'
		call	GetRandomInRange
		add	dx, ax
		mov	ax, 2
		call	sub_15EF8
		mov	ax, 0Ah
		call	sub_13EE7

loc_12C5E:				; CODE XREF: sub_1260A+62Cj
		dec	cs:word_1EA56
		call	sub_1385A
		call	sub_1344A
		cmp	cs:word_1318E, 0
		jz	short loc_12C9C
		dec	cs:word_1318E
		mov	cx, cs:word_1EA52
		mov	dx, cs:word_1EA56
		sub	cx, 20h	; ' '
		mov	ax, 80h	; 'Ä'
		call	GetRandomInRange
		add	cx, ax
		sub	dx, 18h
		mov	ax, 40h	; '@'
		call	GetRandomInRange
		add	dx, ax
		mov	ax, 10h
		call	sub_14567

loc_12C9C:				; CODE XREF: sub_1260A+665j
		cmp	cs:word_1EA66, 0
		jz	short loc_12CB5
		dec	cs:word_1EA66
		test	cs:word_1EA66, 1
		jz	short loc_12CB5
		jmp	loc_12F1F
; ---------------------------------------------------------------------------

loc_12CB5:				; CODE XREF: sub_1260A+698j
					; sub_1260A+6A6j
		mov	cx, cs:word_1EA52
		mov	dx, cs:word_1EA56
		call	sub_140F9
		sub	dx, cs:word_14133
		mov	cs:word_1B8B9, 2
		push	cx
		push	dx
		mov	ax, cs:word_13790
		mov	bx, cs:word_1EA5C
		shl	bx, 1
		add	ax, bx
		add	cx, cs:word_13794
		add	dx, cs:word_13796
		mov	ds, cs:segHdf_ray
		sub	si, si
		cmp	cs:word_1318E, 0
		jnz	short loc_12CFB
		call	AddHDFSpr_Mode0
		jmp	short loc_12D00
; ---------------------------------------------------------------------------

loc_12CFB:				; CODE XREF: sub_1260A+6EAj
		mov	ah, 0Fh
		call	AddHDFSpr_Mode2

loc_12D00:				; CODE XREF: sub_1260A+6EFj
		pop	dx
		pop	cx
		push	cx
		push	dx
		mov	ax, 2
		cmp	cs:word_12FA9, 2
		jz	short loc_12D32
		cmp	cs:word_12F43, 0
		jz	short loc_12D94
		test	cs:word_12F3F, 1
		jz	short loc_12D94
		cmp	cs:word_12F41, 14h
		jb	short loc_12D3A
		mov	ax, cs:word_12F41
		sub	ax, 13h
		shr	ax, 2

loc_12D32:				; CODE XREF: sub_1260A+703j
		inc	ax
		call	GetRandomInRange
		or	ax, ax
		jnz	short loc_12D94

loc_12D3A:				; CODE XREF: sub_1260A+71Cj
		cmp	cs:word_1EA5C, 0
		jz	short loc_12D6C
		push	cx
		push	dx
		sub	cx, 28h	; '('
		add	dx, 8
		mov	ax, 13h
		mov	ds, cs:segHdf_ray
		sub	si, si
		call	AddHDFSpr_Mode0
		pop	dx
		pop	cx
		mov	ax, 10h
		call	GetRandomInRange
		sub	si, ax
		mov	ax, 0
		mov	di, 0
		call	sub_143A7
		jmp	short loc_12D94
; ---------------------------------------------------------------------------

loc_12D6C:				; CODE XREF: sub_1260A+736j
		push	cx
		push	dx
		add	cx, 18h
		add	dx, 8
		mov	ax, 12h
		mov	ds, cs:segHdf_ray
		sub	si, si
		call	AddHDFSpr_Mode0
		pop	dx
		pop	cx
		mov	ax, 10h
		call	GetRandomInRange
		sub	si, ax
		mov	ax, 0
		mov	di, 0
		call	sub_143A7

loc_12D94:				; CODE XREF: sub_1260A+70Bj
					; sub_1260A+714j ...
		pop	dx
		pop	cx
		push	cx
		push	dx
		sub	cx, 8
		sub	dx, 8
		mov	ax, cs:word_137A2
		add	ax, cs:word_1EA5C
		add	dx, cs:word_1379C
		cmp	cs:word_13DAD, 3
		jz	short loc_12DCF
		mov	ds, cs:segHdf_raymX
		sub	si, si
		cmp	cs:word_1318E, 0
		jnz	short loc_12DC8
		call	AddHDFSpr_Mode0
		jmp	short loc_12DEC
; ---------------------------------------------------------------------------

loc_12DC8:				; CODE XREF: sub_1260A+7B7j
					; sub_1260A+7DBj
		mov	ah, 0Fh
		call	AddHDFSpr_Mode2
		jmp	short loc_12DEC
; ---------------------------------------------------------------------------

loc_12DCF:				; CODE XREF: sub_1260A+7A8j
		sub	cx, 8
		mov	ax, cs:word_1EA5C
		shr	ax, 1
		mov	ds, cs:segHdf_rayoX
		sub	si, si
		cmp	cs:word_1318E, 0
		jnz	short loc_12DC8
		call	AddHDFSpr_Mode0
		jmp	short $+2

loc_12DEC:				; CODE XREF: sub_1260A+7BCj
					; sub_1260A+7C3j
		pop	dx
		pop	cx
		cmp	cs:word_13DAD, 2
		jnz	short loc_12E2F
		push	cx
		push	dx
		sub	cx, 30h	; '0'
		sub	dx, 8
		cmp	cs:word_1EA5C, 0
		jnz	short loc_12E09
		add	cx, 40h	; '@'

loc_12E09:				; CODE XREF: sub_1260A+7FAj
		mov	ax, cs:word_1EA5C
		shr	ax, 1
		add	dx, cs:word_1379C
		mov	ds, cs:segHdf_rayoX
		sub	si, si
		cmp	cs:word_1318E, 0
		jnz	short loc_12E28
		call	AddHDFSpr_Mode0
		jmp	short loc_12E2D
; ---------------------------------------------------------------------------

loc_12E28:				; CODE XREF: sub_1260A+817j
		mov	ah, 0Fh
		call	AddHDFSpr_Mode2

loc_12E2D:				; CODE XREF: sub_1260A+81Cj
		pop	dx
		pop	cx

loc_12E2F:				; CODE XREF: sub_1260A+7EAj
		push	cx
		push	dx
		mov	ax, cs:word_13792
		mov	bx, cs:word_1EA5C
		shl	bx, 1
		add	ax, bx
		add	cx, cs:word_13798
		add	dx, cs:word_1379A
		mov	ds, cs:segHdf_ray
		sub	si, si
		cmp	cs:word_1318E, 0
		jnz	short loc_12E5C
		call	AddHDFSpr_Mode0
		jmp	short loc_12E61
; ---------------------------------------------------------------------------

loc_12E5C:				; CODE XREF: sub_1260A+84Bj
		mov	ah, 0Fh
		call	AddHDFSpr_Mode2

loc_12E61:				; CODE XREF: sub_1260A+850j
		pop	dx
		pop	cx
		cmp	cs:word_12FA9, 0
		jnz	short loc_12EBF
		cmp	cs:word_12F47, 0
		jz	short loc_12EBF
		cmp	cs:word_1EA5C, 0
		jz	short loc_12E9E
		push	cx
		push	dx
		sub	cx, 10h
		add	dx, 18h
		mov	ax, 16h
		mov	bx, cs:word_12F47
		and	bx, 1
		add	ax, bx
		mov	ds, cs:segHdf_ray
		sub	si, si
		call	AddHDFSpr_Mode0
		pop	dx
		pop	cx
		jmp	short loc_12EBF
; ---------------------------------------------------------------------------

loc_12E9E:				; CODE XREF: sub_1260A+86Fj
		push	cx
		push	dx
		add	cx, 17h
		add	dx, 18h
		mov	ax, 14h
		mov	bx, cs:word_12F47
		and	bx, 1
		add	ax, bx
		mov	ds, cs:segHdf_ray
		sub	si, si
		call	AddHDFSpr_Mode0
		pop	dx
		pop	cx

loc_12EBF:				; CODE XREF: sub_1260A+85Fj
					; sub_1260A+867j ...
		push	cx
		push	dx
		call	sub_13DB1
		pop	dx
		pop	cx
		cmp	cs:word_13190, 0
		jz	short loc_12F1F
		sub	ax, ax
		cmp	cs:word_13190, 0C8h ; '»'
		jnb	short loc_12EE3
		inc	ax
		cmp	cs:word_13190, 64h ; 'd'
		jnb	short loc_12EE3
		inc	ax

loc_12EE3:				; CODE XREF: sub_1260A+8CDj
					; sub_1260A+8D6j
		cmp	cs:word_1EA5C, 0
		jz	short loc_12F06
		push	cx
		push	dx
		sub	cx, 10h
		add	dx, cs:word_1379C
		add	ax, 0Fh
		mov	ds, cs:segHdf_ray
		sub	si, si
		call	AddHDFSpr_Mode0
		pop	dx
		pop	cx
		jmp	short loc_12F1F
; ---------------------------------------------------------------------------

loc_12F06:				; CODE XREF: sub_1260A+8DFj
		push	cx
		push	dx
		add	cx, 17h
		add	dx, cs:word_1379C
		add	ax, 0Ch
		mov	ds, cs:segHdf_ray
		sub	si, si
		call	AddHDFSpr_Mode0
		pop	dx
		pop	cx

loc_12F1F:				; CODE XREF: sub_1260A+6A8j
					; sub_1260A+8C2j ...
		call	sub_13192

locret_12F22:				; CODE XREF: sub_1260A+952j
		retn
; ---------------------------------------------------------------------------
		db 4 dup(0)
word_12F27	dw 0			; DATA XREF: DoOneLevel+2Dr
					; sub_10F09:loc_1111Dr	...
word_12F29	dw 0			; DATA XREF: sub_1260A+954r
					; sub_1260A+980w ...
word_12F2B	dw 0			; DATA XREF: sub_1260A+97Cr
					; sub_13EE7+76w
word_12F2D	dw 0			; DATA XREF: sub_1260A+959r
					; sub_1260A+989w ...
word_12F2F	dw 0			; DATA XREF: sub_1260A+977w
					; sub_1260A+985r ...
word_12F31	dw 0			; DATA XREF: sub_1260A+963r
					; sub_1260A+96Cw ...
word_12F33	dw 0			; DATA XREF: sub_1260A+5Er
					; sub_16D80+1w
word_12F35	dw 0			; DATA XREF: sub_1260A+1BBw
					; sub_1260A+49Ar ...
word_12F37	dw 0			; DATA XREF: sub_1260A+17Cr
					; sub_1260A+518w ...
word_12F39	dw 0			; DATA XREF: sub_1260A+1A7r
					; sub_1260A+1AFw ...
word_12F3B	dw 0			; DATA XREF: sub_1260A+16Dw
					; sub_1260A+19Fr ...
word_12F3D	dw 0			; DATA XREF: sub_1260A:loc_1277Er
					; sub_1260A:loc_127CEw	...
word_12F3F	dw 0			; DATA XREF: sub_1260A+1F2r
					; sub_1260A+1FAw ...
word_12F41	dw 0			; DATA XREF: sub_1260A+1Ew
					; sub_1260A+1DEw ...
word_12F43	dw 0			; DATA XREF: sub_1260A+200w
					; sub_1260A+217w ...
word_12F45	dw 0			; DATA XREF: sub_1260A+207w
					; sub_1260A+225w ...
word_12F47	dw 1			; DATA XREF: sub_1260A+B0w
					; sub_1260A+11Fw ...
word_12F49	dw 0			; DATA XREF: sub_1260A:loc_127EDw
					; sub_1260A:loc_1281Aw	...
word_12F4B	dw 0			; DATA XREF: sub_1260A:loc_1264Cr
					; sub_1260A+4Aw ...
word_12F4D	dw 0			; DATA XREF: sub_1260A:loc_12659r
					; sub_1260A+57w ...
word_12F4F	dw 0			; DATA XREF: sub_1260A+164r
					; sub_1260A:loc_1288Bw
; ---------------------------------------------------------------------------

loc_12F51:				; CODE XREF: sub_1260A+3Fj
		inc	cs:word_12F27
		cmp	cs:word_12F27, 3Ch ; '<'
		jnb	short locret_12F22
		mov	cx, cs:word_12F29
		mov	dx, cs:word_12F2D
		mov	ds, cs:word_1E9BA
		mov	ax, cs:word_12F31
		sub	si, si
		call	AddHDFSpr_Mode0
		inc	cs:word_12F31
		and	cs:word_12F31, 7
		inc	cs:word_12F2F
		mov	ax, cs:word_12F2B
		add	cs:word_12F29, ax
		mov	ax, cs:word_12F2F
		add	cs:word_12F2D, ax
		mov	cx, cs:word_12F29
		mov	dx, cs:word_12F2D
		mov	ax, 2
		call	sub_15EF8
		retn
sub_1260A	endp

; ---------------------------------------------------------------------------
word_12FA9	dw 0			; DATA XREF: cmfA1E+1w	sub_1260A+91r ...
word_12FAB	dw 0			; DATA XREF: sub_17323+1w
word_12FAD	dw 0			; DATA XREF: sub_12554+1w sub_1260Ar

; =============== S U B	R O U T	I N E =======================================


sub_12FAF	proc near		; CODE XREF: sub_1260A+27Ep
		cmp	cs:word_1EA64, 1
		jz	short loc_12FE3
		cmp	cs:word_1EA64, 2
		jz	short loc_12FFB
		cmp	cs:word_1EA64, 3
		jnz	short loc_12FCA
		jmp	loc_13057
; ---------------------------------------------------------------------------

loc_12FCA:				; CODE XREF: sub_12FAF+16j
		cmp	cs:word_1EA64, 4
		jnz	short loc_12FD5
		jmp	loc_130B3
; ---------------------------------------------------------------------------

loc_12FD5:				; CODE XREF: sub_12FAF+21j
		cmp	cs:word_1EA64, 5
		jnz	short loc_12FE0
		jmp	loc_130DD
; ---------------------------------------------------------------------------

loc_12FE0:				; CODE XREF: sub_12FAF+2Cj
		jmp	loc_1318A
; ---------------------------------------------------------------------------

loc_12FE3:				; CODE XREF: sub_12FAF+6j
		mov	cs:word_119F6, 10h
		mov	cs:word_1EA64, 0
		mov	cs:word_1EA66, 10h
		jmp	loc_1318A
; ---------------------------------------------------------------------------

loc_12FFB:				; CODE XREF: sub_12FAF+Ej
		mov	ax, cs:word_13BAD
		cmp	cs:WeaponGun3, ax
		jnz	short loc_13009
		jmp	loc_1318A
; ---------------------------------------------------------------------------

loc_13009:				; CODE XREF: sub_12FAF+55j
		inc	cs:WeaponGun1
		mov	ax, cs:WeaponGun2
		cmp	cs:WeaponGun1, ax
		jnz	short loc_13046
		mov	cs:WeaponGun1, 0
		add	cs:WeaponGun2, 8
		inc	cs:WeaponGun3
		mov	cs:word_1EA64, 0
		mov	cs:word_1EA66, 10h
		mov	cs:word_1318E, 10h
		call	sub_13D01
		jmp	loc_1318A
; ---------------------------------------------------------------------------

loc_13046:				; CODE XREF: sub_12FAF+68j
		mov	cs:word_1EA64, 0
		mov	cs:word_1EA66, 10h
		jmp	loc_1318A
; ---------------------------------------------------------------------------

loc_13057:				; CODE XREF: sub_12FAF+18j
		mov	ax, cs:word_13CB3
		cmp	cs:WeaponSub3, ax
		jnz	short loc_13065
		jmp	loc_1318A
; ---------------------------------------------------------------------------

loc_13065:				; CODE XREF: sub_12FAF+B1j
		inc	cs:WeaponSub1
		mov	ax, cs:WeaponSub2
		cmp	cs:WeaponSub1, ax
		jnz	short loc_130A2
		mov	cs:WeaponSub1, 0
		add	cs:WeaponSub2, 4
		inc	cs:WeaponSub3
		mov	cs:word_1EA64, 0
		mov	cs:word_1EA66, 10h
		mov	cs:word_1318E, 10h
		call	sub_13CBD
		jmp	loc_1318A
; ---------------------------------------------------------------------------

loc_130A2:				; CODE XREF: sub_12FAF+C4j
		mov	cs:word_1EA64, 0
		mov	cs:word_1EA66, 10h
		jmp	loc_1318A
; ---------------------------------------------------------------------------

loc_130B3:				; CODE XREF: sub_12FAF+23j
		cmp	cs:word_13190, 0
		jz	short loc_130BE
		jmp	loc_1318A
; ---------------------------------------------------------------------------

loc_130BE:				; CODE XREF: sub_12FAF+10Aj
		mov	cs:word_1EA64, 0
		mov	cs:word_13190, 12Ch
		mov	cs:word_1EA66, 10h
		mov	cs:word_1318E, 10h
		jmp	loc_1318A
; ---------------------------------------------------------------------------

loc_130DD:				; CODE XREF: sub_12FAF+2Ej
		push	bp
		push	ds
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		mov	bp, 0D684h
		mov	cx, 3Ch	; '<'

loc_130EA:				; CODE XREF: sub_12FAF+168j
		cmp	word ptr ds:[bp+2], 0
		jz	short loc_13113
		cmp	word ptr ds:[bp+26h], 0
		jz	short loc_13113
		cmp	byte ptr ds:[bp+95h], 1
		jz	short loc_13113
		cmp	word ptr ds:[bp+42h], 0
		jz	short loc_13113
		mov	word ptr ds:[bp+30h], 12Ch
		mov	word ptr ds:[bp+2Eh], 1

loc_13113:				; CODE XREF: sub_12FAF+140j
					; sub_12FAF+147j ...
		add	bp, 98h	; 'ò'
		loop	loc_130EA
		mov	bp, 0FFFFh
		mov	bl, 7
		call	Palette_SetMult
		mov	cx, 1Eh

loc_13124:				; CODE XREF: sub_12FAF+183j
		push	ax

loc_13125:				; CODE XREF: sub_12FAF+17Aj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_13125

loc_1312B:				; CODE XREF: sub_12FAF+180j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1312B
		pop	ax
		loop	loc_13124
		mov	cs:word_111E7, 1Eh
		mov	ax, cs:word_12235
		mov	cs:word_11FCE, ax
		mov	al, cs:byte_12237
		mov	cs:byte_11FD0, al
		mov	cs:word_12235, 9
		mov	cs:byte_12237, 0
		mov	cx, 1Eh

loc_1315B:				; CODE XREF: sub_12FAF+1BAj
		push	ax

loc_1315C:				; CODE XREF: sub_12FAF+1B1j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1315C

loc_13162:				; CODE XREF: sub_12FAF+1B7j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_13162
		pop	ax
		loop	loc_1315B
		mov	cs:word_12235, 8
		mov	cs:byte_12237, 10h
		mov	cs:word_1EA64, 0
		mov	cs:word_1EA66, 20h ; ' '
		pop	ds
		assume ds:nothing
		pop	bp
		jmp	short $+2

loc_1318A:				; CODE XREF: sub_12FAF:loc_12FE0j
					; sub_12FAF+49j ...
		call	DrawHUD
		retn
sub_12FAF	endp

; ---------------------------------------------------------------------------
word_1318E	dw 0			; DATA XREF: sub_111F3+F2w
					; sub_111F3+155w ...
word_13190	dw 0			; DATA XREF: sub_1260A+8BCr
					; sub_1260A+8C6r ...

; =============== S U B	R O U T	I N E =======================================


sub_13192	proc near		; CODE XREF: sub_1260A:loc_12F1Fp
		cmp	cs:word_13DAD, 1
		jz	short loc_1319B
		retn
; ---------------------------------------------------------------------------

loc_1319B:				; CODE XREF: sub_13192+6j
		cmp	cs:word_133A9, 0
		jnz	short loc_131D3
		mov	ax, cs:word_1EA52
		sub	ax, 10h
		mov	cs:word_133A1, ax
		mov	ax, cs:word_1EA56
		sub	ax, 30h	; '0'
		mov	cs:word_133A3, ax
		cmp	cs:word_1EA5C, 0
		jz	short loc_131CA
		mov	cs:word_133A7, 0
		jmp	short loc_131D1
; ---------------------------------------------------------------------------

loc_131CA:				; CODE XREF: sub_13192+2Dj
		mov	cs:word_133A7, 80h ; 'Ä'

loc_131D1:				; CODE XREF: sub_13192+36j
		jmp	short loc_1322E
; ---------------------------------------------------------------------------

loc_131D3:				; CODE XREF: sub_13192+Fj
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		mov	bp, cs:word_133AB
		cmp	word ptr ds:[bp+2], 0
		jnz	short loc_131ED
		mov	cs:word_133A9, 0
		jmp	short loc_1322E
; ---------------------------------------------------------------------------

loc_131ED:				; CODE XREF: sub_13192+50j
		mov	ax, cs:word_1EA52
		sub	ax, 10h
		mov	cs:word_133A1, ax
		mov	ax, cs:word_1EA56
		sub	ax, 30h	; '0'
		mov	cs:word_133A3, ax
		mov	cx, cs:word_13399
		mov	dx, cs:word_1339D
		sar	cx, 3
		sar	dx, 3
		mov	si, ds:[bp+4]
		add	si, ds:[bp+50h]
		mov	di, ds:[bp+6]
		add	di, ds:[bp+52h]
		call	sub_1BF6B
		and	cx, 0FFF0h
		mov	cs:word_133A7, cx

loc_1322E:				; CODE XREF: sub_13192:loc_131D1j
					; sub_13192+59j
		mov	ax, cs:word_133A7
		and	ax, 0FFF0h
		cmp	cs:word_133A5, ax
		jz	short loc_1324E
		jb	short loc_13246
		sub	cs:word_133A5, 10h
		jmp	short loc_13299
; ---------------------------------------------------------------------------

loc_13246:				; CODE XREF: sub_13192+AAj
		add	cs:word_133A5, 10h
		jmp	short loc_13299
; ---------------------------------------------------------------------------

loc_1324E:				; CODE XREF: sub_13192+A8j
		cmp	cs:word_133A9, 0
		jz	short loc_13299
		mov	cx, cs:word_13399
		mov	dx, cs:word_1339D
		mov	di, cs:word_133AB
		mov	si, cs:word_133A5
		sar	cx, 3
		sar	dx, 3
		mov	ax, 9
		call	sub_14567
		mov	cs:word_133A9, 0
		mov	si, cs:word_133A5
		mov	ax, si
		call	sub_1BE93
		sar	cx, 1
		sar	dx, 1
		neg	cx
		neg	dx
		add	cs:word_1339B, cx
		add	cs:word_1339F, dx

loc_13299:				; CODE XREF: sub_13192+B2j
					; sub_13192+BAj ...
		mov	ax, cs:BasePosX
		shl	ax, 3
		add	cs:word_13399, ax
		mov	ax, cs:BasePosY
		shl	ax, 3
		add	cs:word_1339D, ax
		mov	cx, cs:word_13399
		mov	dx, cs:word_1339D
		sar	cx, 3
		sar	dx, 3
		mov	ds, cs:segHdf_rayoX
		assume ds:nothing
		sub	si, si
		mov	ax, cs:word_133A5
		shr	ax, 4
		and	ax, 0Fh
		push	cx
		push	dx
		call	AddHDFSpr_Mode0
		pop	dx
		pop	cx
		mov	si, cs:word_133A1
		mov	di, cs:word_133A3
		call	sub_1BE3A
		sar	cx, 3
		sar	dx, 3
		add	cs:word_1339B, cx
		add	cs:word_1339F, dx
		mov	ax, cs:word_1339B
		test	ah, 80h
		jnz	short loc_1330D
		cmp	ax, 80h	; 'Ä'
		jb	short loc_13319
		mov	ax, 7Fh	; ''
		mov	cs:word_1339B, ax
		jmp	short loc_13319
; ---------------------------------------------------------------------------

loc_1330D:				; CODE XREF: sub_13192+16Bj
		cmp	ax, 0FF80h
		jnb	short loc_13319
		mov	ax, 0FF81h
		mov	cs:word_1339B, ax

loc_13319:				; CODE XREF: sub_13192+170j
					; sub_13192+179j ...
		add	cs:word_13399, ax
		mov	ax, cs:word_1339F
		test	ah, 80h
		jnz	short loc_13335
		cmp	ax, 40h	; '@'
		jb	short loc_13341
		mov	ax, 3Fh	; '?'
		mov	cs:word_1339F, ax
		jmp	short loc_13341
; ---------------------------------------------------------------------------

loc_13335:				; CODE XREF: sub_13192+193j
		cmp	ax, 0FFC0h
		jnb	short loc_13341
		mov	ax, 0FFC1h
		mov	cs:word_1339F, ax

loc_13341:				; CODE XREF: sub_13192+198j
					; sub_13192+1A1j ...
		add	cs:word_1339D, ax
		jmp	short locret_13398
; ---------------------------------------------------------------------------
		mov	ax, cs:word_1339B
		test	ah, 80h
		jnz	short loc_1335F
		cmp	ax, 80h	; 'Ä'
		jb	short loc_1336B
		mov	ax, 7Fh	; ''
		mov	cs:word_1339B, ax
		jmp	short loc_1336B
; ---------------------------------------------------------------------------

loc_1335F:				; CODE XREF: sub_13192+1BDj
		cmp	ax, 0FF80h
		jnb	short loc_1336B
		mov	ax, 0FF81h
		mov	cs:word_1339B, ax

loc_1336B:				; CODE XREF: sub_13192+1C2j
					; sub_13192+1CBj ...
		add	cs:word_13399, ax
		mov	ax, cs:word_1339F
		test	ah, 80h
		jnz	short loc_13387
		cmp	ax, 40h	; '@'
		jb	short loc_13393
		mov	ax, 3Fh	; '?'
		mov	cs:word_1339F, ax
		jmp	short loc_13393
; ---------------------------------------------------------------------------

loc_13387:				; CODE XREF: sub_13192+1E5j
		cmp	ax, 0FFC0h
		jnb	short loc_13393
		mov	ax, 0FFC1h
		mov	cs:word_1339F, ax

loc_13393:				; CODE XREF: sub_13192+1EAj
					; sub_13192+1F3j ...
		add	cs:word_1339D, ax

locret_13398:				; CODE XREF: sub_13192+1B4j
		retn
sub_13192	endp

; ---------------------------------------------------------------------------
word_13399	dw 0			; DATA XREF: cmfA19+5w	sub_13192+71r ...
word_1339B	dw 0			; DATA XREF: sub_13192+FDw
					; sub_13192+15Aw ...
word_1339D	dw 0			; DATA XREF: cmfA19+Ew	sub_13192+76r ...
word_1339F	dw 0			; DATA XREF: sub_13192+102w
					; sub_13192+15Fw ...
word_133A1	dw 0			; DATA XREF: sub_13192+18w
					; sub_13192+62w ...
word_133A3	dw 0			; DATA XREF: sub_13192+23w
					; sub_13192+6Dw ...
word_133A5	dw 0			; DATA XREF: sub_13192+A3r
					; sub_13192+ACw ...
word_133A7	dw 0			; DATA XREF: sub_13192+2Fw
					; sub_13192:loc_131CAw	...
word_133A9	dw 0			; DATA XREF: sub_13192:loc_1319Br
					; sub_13192+52w ...
word_133AB	dw 0			; DATA XREF: sub_13192+46r
					; sub_13192+CEr ...

; =============== S U B	R O U T	I N E =======================================


sub_133AD	proc near		; CODE XREF: sub_13D49:loc_13D7Bp
					; seg000:455Fp
		cmp	cs:word_13DAD, 1
		jz	short loc_133B6
		retn
; ---------------------------------------------------------------------------

loc_133B6:				; CODE XREF: sub_133AD+6j
		cmp	cs:word_133A9, 0
		jz	short loc_133C1
		jmp	locret_13447
; ---------------------------------------------------------------------------

loc_133C1:				; CODE XREF: sub_133AD+Fj
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001

loc_133C6:				; CODE XREF: sub_133AD+8Cj
		sub	dx, dx
		mov	bx, 0D684h
		mov	cx, 3Ch	; '<'

loc_133CE:				; CODE XREF: sub_133AD+87j
		cmp	word ptr [bx+2], 0
		jz	short loc_13430
		cmp	word ptr [bx+26h], 0
		jz	short loc_13430
		cmp	word ptr [bx+6Bh], 0
		jnz	short loc_13430
		cmp	cs:word_1EA5C, 0
		jnz	short loc_133FC
		mov	ax, cs:word_1EA52
		mov	cx, [bx+4]
		add	cx, 280h
		add	ax, 280h
		cmp	cx, ax
		jb	short loc_13410
		jmp	short loc_13430
; ---------------------------------------------------------------------------

loc_133FC:				; CODE XREF: sub_133AD+39j
		mov	ax, cs:word_1EA52
		mov	cx, [bx+4]
		add	cx, 280h
		add	ax, 280h
		cmp	cx, ax
		jnb	short loc_13410
		jmp	short loc_13430
; ---------------------------------------------------------------------------

loc_13410:				; CODE XREF: sub_133AD+4Bj
					; sub_133AD+5Fj
		mov	dx, 1
		mov	ax, 2
		push	dx
		push	bx
		call	GetRandomInRange
		pop	bx
		pop	dx
		cmp	ax, 0
		jnz	short loc_13430
		mov	cs:word_133AB, bx
		mov	cs:word_133A9, 1
		jmp	short locret_13447
; ---------------------------------------------------------------------------

loc_13430:				; CODE XREF: sub_133AD+25j
					; sub_133AD+2Bj ...
		add	bx, 98h	; 'ò'
		loop	loc_133CE
		cmp	dx, 0
		jnz	short loc_133C6
		cmp	cs:word_1EA5C, 0
		jz	short loc_13445
		jmp	short locret_13447
; ---------------------------------------------------------------------------

loc_13445:				; CODE XREF: sub_133AD+94j
		jmp	short $+2

locret_13447:				; CODE XREF: sub_133AD+11j
					; sub_133AD+81j ...
		retn
sub_133AD	endp

; ---------------------------------------------------------------------------
		db 2 dup(0)

; =============== S U B	R O U T	I N E =======================================


sub_1344A	proc near		; CODE XREF: sub_1260A+65Cp
		cmp	cs:word_12FA9, 0
		jz	short loc_13455
		jmp	loc_13752
; ---------------------------------------------------------------------------

loc_13455:				; CODE XREF: sub_1344A+6j
		cmp	cs:word_12F47, 0
		jz	short loc_13460
		jmp	loc_136E7
; ---------------------------------------------------------------------------

loc_13460:				; CODE XREF: sub_1344A+11j
		cmp	cs:word_12F45, 1
		jnz	short loc_1346B
		jmp	loc_13529
; ---------------------------------------------------------------------------

loc_1346B:				; CODE XREF: sub_1344A+1Cj
		cmp	cs:word_12F35, 6
		jb	short loc_1347E
		cmp	cs:word_1EA58, 0
		jz	short loc_1347E
		jmp	loc_13520
; ---------------------------------------------------------------------------

loc_1347E:				; CODE XREF: sub_1344A+27j
					; sub_1344A+2Fj
		mov	ax, cs:word_1EA54
		add	cs:word_1378E, ax
		and	cs:word_1378E, 3Fh
		mov	bx, cs:word_1378E
		shr	bx, 3
		push	bx
		shl	bx, 4
		add	bx, 37A4h
		sub	ax, ax
		mov	ax, cs:[bx]
		mov	cs:word_13790, ax
		mov	ax, cs:[bx+2]
		mov	cs:word_13794, ax
		mov	ax, cs:[bx+4]
		mov	cs:word_13796, ax
		mov	ax, cs:[bx+6]
		mov	cs:word_1379C, ax
		add	bx, 8
		mov	ax, cs:[bx]
		mov	cs:word_13792, ax
		mov	ax, cs:[bx+2]
		mov	cs:word_13798, ax
		mov	ax, cs:[bx+4]
		mov	cs:word_1379A, ax
		mov	ax, cs:[bx+4]
		mov	cs:word_1379A, ax
		mov	ax, cs:[bx+6]
		mov	cs:word_1379C, ax
		pop	bx
		shl	bx, 2
		add	bx, 3824h
		mov	ax, cs:[bx]
		mov	cs:word_1379E, ax
		mov	ax, cs:[bx+2]
		mov	cs:word_137A0, ax
		mov	bx, cs:word_13B18
		shr	bx, 4
		sub	ax, ax
		mov	al, cs:[bx+3844h]
		mov	cs:word_137A2, ax
		cmp	cs:word_12F37, 0
		jz	short loc_1351D
		jmp	loc_13682
; ---------------------------------------------------------------------------

loc_1351D:				; CODE XREF: sub_1344A+CEj
		jmp	locret_1378D
; ---------------------------------------------------------------------------

loc_13520:				; CODE XREF: sub_1344A+31j
		mov	ax, cs:word_1EA58
		test	ah, 80h
		jz	short loc_13564

loc_13529:				; CODE XREF: sub_1344A+1Ej
		mov	cs:word_137A2, 0
		mov	cs:word_13790, 5
		mov	cs:word_13794, 0FFFCh
		mov	cs:word_13796, 0Eh
		mov	cs:word_1379C, 2
		mov	cs:word_13792, 2
		mov	cs:word_13798, 9
		mov	cs:word_1379A, 12h
		jmp	loc_1363C
; ---------------------------------------------------------------------------

loc_13564:				; CODE XREF: sub_1344A+DDj
		mov	cs:word_12F47, 0
		cmp	ax, 4
		jb	short loc_135BA
		cmp	ax, 8
		jnb	short loc_13578
		jmp	loc_135FB
; ---------------------------------------------------------------------------

loc_13578:				; CODE XREF: sub_1344A+129j
		mov	cs:word_137A2, 2
		mov	cs:word_13790, 4
		mov	cs:word_13794, 0FFF0h
		mov	cs:word_13796, 12h
		mov	cs:word_1379C, 2
		mov	cs:word_13792, 1
		mov	cs:word_13798, 0FFFFh
		mov	cs:word_1379A, 11h
		mov	cs:word_137A0, 0FFFEh
		jmp	loc_1365C
; ---------------------------------------------------------------------------

loc_135BA:				; CODE XREF: sub_1344A+124j
		mov	cs:word_137A2, 2
		mov	cs:word_13790, 4
		mov	cs:word_13794, 0FFF4h
		mov	cs:word_13796, 12h
		mov	cs:word_1379C, 2
		mov	cs:word_13792, 1
		mov	cs:word_13798, 0FFFDh
		mov	cs:word_1379A, 10h
		mov	cs:word_137A0, 0FFFFh
		jmp	short loc_1365C
; ---------------------------------------------------------------------------

loc_135FB:				; CODE XREF: sub_1344A+12Bj
		mov	cs:word_137A2, 2
		mov	cs:word_13790, 4
		mov	cs:word_13794, 0FFF0h
		mov	cs:word_13796, 12h
		mov	cs:word_1379C, 2
		mov	cs:word_13792, 1
		mov	cs:word_13798, 0FFFFh
		mov	cs:word_1379A, 11h
		mov	cs:word_137A0, 0FFFFh
		jmp	short loc_1365C
; ---------------------------------------------------------------------------

loc_1363C:				; CODE XREF: sub_1344A+117j
					; sub_1344A+340j
		cmp	cs:word_1EA5C, 0
		jnz	short loc_13647
		jmp	locret_1378D
; ---------------------------------------------------------------------------

loc_13647:				; CODE XREF: sub_1344A+1F8j
		mov	ax, cs:word_13794
		mov	bx, cs:word_13798
		mov	cs:word_13794, bx
		mov	cs:word_13798, ax
		jmp	locret_1378D
; ---------------------------------------------------------------------------

loc_1365C:				; CODE XREF: sub_1344A+16Dj
					; sub_1344A+1AFj ...
		cmp	cs:word_1EA5C, 0
		jnz	short loc_13667
		jmp	locret_1378D
; ---------------------------------------------------------------------------

loc_13667:				; CODE XREF: sub_1344A+218j
		mov	ax, cs:word_13794
		mov	bx, cs:word_13798
		add	ax, 10h
		add	bx, 10h
		mov	cs:word_13794, bx
		mov	cs:word_13798, ax
		jmp	locret_1378D
; ---------------------------------------------------------------------------

loc_13682:				; CODE XREF: sub_1344A+D0j
		mov	cs:word_137A2, 2
		mov	bx, 0Ch
		sub	bx, cs:word_12F37
		sub	ax, ax
		mov	al, cs:[bx+384Dh]
		add	ax, 2
		mov	cs:word_1379C, ax
		shr	ax, 1
		mov	cs:word_137A0, ax
		pusha
		mov	dx, 4
		call	sub_1E653
		popa
		pusha
		mov	al, 9
		call	sub_1E582
		popa
		pusha
		mov	ax, 0
		mov	cx, cs:word_1EA52
		mov	dx, cs:word_1EA56
		mov	si, cs:word_1EA54
		neg	si
		mov	di, 0
		add	cx, 8
		call	sub_143A7
		add	cx, 10h
		call	sub_143A7
		add	cx, 18h
		call	sub_143A7
		popa
		dec	cs:word_12F37
		jmp	locret_1378D
; ---------------------------------------------------------------------------

loc_136E7:				; CODE XREF: sub_1344A+13j
		mov	cs:word_137A2, 2
		mov	cs:word_1379C, 8
		mov	cs:word_137A0, 5
		mov	cs:word_13794, 0FFFAh
		mov	cs:word_13796, 10h
		mov	cs:word_13790, 3
		mov	cs:word_13792, 0
		mov	cs:word_13798, 0Bh
		mov	cs:word_1379A, 10h
		pusha
		mov	ax, 0
		mov	cx, cs:word_1EA52
		mov	dx, cs:word_1EA56
		mov	si, cs:word_1EA54
		neg	si
		mov	di, 0
		add	cx, 8
		call	sub_143A7
		add	cx, 18h
		call	sub_143A7
		popa
		dec	cs:word_12F47
		jmp	short locret_1378D
; ---------------------------------------------------------------------------

loc_13752:				; CODE XREF: sub_1344A+8j
		mov	cs:word_137A2, 1
		mov	cs:word_13790, 5
		mov	cs:word_13794, 0FFFCh
		mov	cs:word_13796, 0Eh
		mov	cs:word_1379C, 2
		mov	cs:word_13792, 2
		mov	cs:word_13798, 9
		mov	cs:word_1379A, 12h
		jmp	loc_1363C
; ---------------------------------------------------------------------------

locret_1378D:				; CODE XREF: sub_1344A:loc_1351Dj
					; sub_1344A+1FAj ...
		retn
sub_1344A	endp

; ---------------------------------------------------------------------------
word_1378E	dw 0			; DATA XREF: sub_1344A+38w
					; sub_1344A+3Dw ...
word_13790	dw 0			; DATA XREF: sub_1260A+6C6r
					; sub_1344A+58w ...
word_13792	dw 0			; DATA XREF: sub_1260A+827r
					; sub_1344A+7Aw ...
word_13794	dw 0			; DATA XREF: sub_1260A+6D3r
					; sub_1344A+60w ...
word_13796	dw 0			; DATA XREF: sub_1260A+6D8r
					; sub_1344A+68w ...
word_13798	dw 0			; DATA XREF: sub_1260A+834r
					; sub_1344A+82w ...
word_1379A	dw 0			; DATA XREF: sub_1260A+839r
					; sub_1344A+8Aw ...
word_1379C	dw 0			; DATA XREF: sub_1260A+79Dr
					; sub_1260A+805r ...
word_1379E	dw 0			; DATA XREF: sub_1344A+A9w
					; sub_13DB1+8Er ...
word_137A0	dw 0			; DATA XREF: sub_1344A+B1w
					; sub_1344A+166w ...
word_137A2	dw 0			; DATA XREF: sub_1260A+794r
					; sub_1344A+C4w ...
		db 3, 0, 0FAh, 0FFh, 10h, 5 dup(0), 0Eh, 0, 10h, 0, 2
		db 0, 3, 0, 2 dup(0FFh), 0Fh, 5	dup(0),	9, 0, 10h, 0, 3
		db 0, 3, 0, 4, 0, 0Eh, 5 dup(0), 4, 0, 10h, 0, 4, 0, 3
		db 0, 9, 0, 0Fh, 5 dup(0), 2 dup(0FFh),	10h, 0,	3, 0, 3
		db 0, 0Eh, 0, 10h, 5 dup(0), 0FAh, 0FFh, 10h, 0, 2, 0
		db 3, 0, 9, 0, 10h, 5 dup(0), 2	dup(0FFh), 0Fh,	0, 3, 0
		db 3, 0, 4, 0, 10h, 5 dup(0), 4, 0, 0Eh, 0, 4, 0, 3, 0
		db 2 dup(0FFh),	10h, 5 dup(0), 9, 0, 0Fh, 0, 3,	0, 6, 3	dup(0)
		db 4, 0, 2, 0, 2, 0, 3,	0, 1, 0, 2, 5 dup(0), 2, 0, 2
		db 0, 4, 0, 3, 0, 6, 0,	2, 4 dup(0), 3 dup(1), 3 dup(2)
		db 1, 2, 3, 4, 6, 2 dup(8), 6, 4, 3, 2,	1, 0

; =============== S U B	R O U T	I N E =======================================


sub_1385A	proc near		; CODE XREF: sub_1260A+659p
		mov	ax, cs:word_1EA52
		cmp	ax, 260h
		jb	short loc_1387F
		cmp	ax, 7530h
		jnb	short loc_1386F
		cmp	ax, 260h
		jnb	short loc_13878
		jmp	short loc_1387F
; ---------------------------------------------------------------------------

loc_1386F:				; CODE XREF: sub_1385A+Cj
		mov	cs:word_1EA52, 0
		jmp	short loc_1387F
; ---------------------------------------------------------------------------

loc_13878:				; CODE XREF: sub_1385A+11j
		mov	cs:word_1EA52, 260h

loc_1387F:				; CODE XREF: sub_1385A+7j
					; sub_1385A+13j ...
		mov	ax, cs:word_1EA56
		cmp	ax, 0B8h ; '∏'
		jb	short locret_138A4
		cmp	ax, 7530h
		jnb	short loc_13894
		cmp	ax, 0D8h ; 'ÿ'
		jnb	short loc_1389D
		jmp	short locret_138A4
; ---------------------------------------------------------------------------

loc_13894:				; CODE XREF: sub_1385A+31j
		mov	cs:word_1EA56, 0
		jmp	short locret_138A4
; ---------------------------------------------------------------------------

loc_1389D:				; CODE XREF: sub_1385A+36j
		mov	cs:word_1EA56, 0B8h ; '∏'

locret_138A4:				; CODE XREF: sub_1385A+2Cj
					; sub_1385A+38j ...
		retn
sub_1385A	endp


; =============== S U B	R O U T	I N E =======================================


sub_138A5	proc near		; CODE XREF: sub_1260A:loc_12858p
		pusha
		call	sub_13BB7
		call	sub_13D49
		cmp	cs:word_139EC, 0
		jz	short loc_138B7
		jmp	loc_139EA
; ---------------------------------------------------------------------------

loc_138B7:				; CODE XREF: sub_138A5+Dj
		mov	ax, cs:word_13BB5
		mov	cs:word_139EC, ax
		mov	bx, cs:word_1EA6A
		shl	bx, 2
		mov	ax, cs:[bx+39F2h]
		cmp	cs:word_1EA5C, 0
		jz	short loc_138D6
		neg	ax

loc_138D6:				; CODE XREF: sub_138A5+2Dj
		mov	cs:word_13B1A, ax
		mov	ax, cs:[bx+39F4h]
		mov	cs:word_13B1C, ax
		mov	si, 3A16h
		cmp	cs:word_1EA5C, 0
		jz	short loc_138F1
		mov	si, 3A18h

loc_138F1:				; CODE XREF: sub_138A5+47j
		mov	bx, cs:word_1EA6A
		shl	bx, 2
		add	bx, cs:[si]
		mov	cx, cs:[bx]
		mov	dx, cs:[bx+2]
		add	cx, cs:word_13E81
		add	dx, cs:word_13E83
		sub	cx, 8
		sub	dx, 4
		mov	si, 0C0h ; '¿'
		add	si, cs:word_13B18
		cmp	cs:word_1EA5C, 0
		jnz	short loc_1392B
		mov	si, 0C0h ; '¿'
		sub	si, cs:word_13B18

loc_1392B:				; CODE XREF: sub_138A5+7Cj
		shl	bx, 1
		push	cx
		push	dx
		call	sub_13B22
		pop	dx
		pop	cx
		sub	cx, 8
		sub	dx, 4
		cmp	cs:word_13BB3, 0
		jz	short loc_1394C
		cmp	cs:word_13BB3, 3
		jz	short loc_1396F
		jmp	short loc_13983
; ---------------------------------------------------------------------------

loc_1394C:				; CODE XREF: sub_138A5+9Bj
		mov	ax, 2
		call	GetRandomInRange
		mov	ds, cs:word_10CCD
		assume ds:nothing
		sub	si, si
		add	ax, 5
		mov	cs:word_1B8B9, 4
		call	AddHDFSpr_Mode0
		mov	cs:word_1B8B9, 2
		jmp	short loc_13983
; ---------------------------------------------------------------------------

loc_1396F:				; CODE XREF: sub_138A5+A3j
		mov	cs:word_1B8B9, 4
		mov	ax, 22h	; '"'
		call	sub_14567
		mov	cs:word_1B8B9, 2

loc_13983:				; CODE XREF: sub_138A5+A5j
					; sub_138A5+C8j
		mov	cx, cs:word_1EA52
		mov	dx, cs:word_1EA56
		add	cx, 18h
		add	dx, 8
		mov	si, cs:word_1EA54
		shl	si, 1
		neg	si
		mov	ax, 4
		call	GetRandomInRange
		add	ax, 4
		neg	ax
		mov	di, ax
		mov	ax, 8
		call	GetRandomInRange
		mov	bx, ax
		mov	ax, 3
		cmp	cs:word_1EA5C, 0
		jz	short loc_139C1
		mov	ax, 2
		neg	bx

loc_139C1:				; CODE XREF: sub_138A5+115j
		add	si, bx
		call	sub_14567
		pusha
		mov	dx, 4
		call	sub_1E653
		popa
		mov	al, 0
		call	sub_1E582
		add	cs:word_13B16, 1
		cmp	cs:word_13B16, 3
		jnz	short loc_139E8
		mov	cs:word_13B16, 0

loc_139E8:				; CODE XREF: sub_138A5+13Aj
					; sub_138A5:loc_139EAj
		popa
		retn
; ---------------------------------------------------------------------------

loc_139EA:				; CODE XREF: sub_138A5+Fj
		jmp	short loc_139E8
sub_138A5	endp

; ---------------------------------------------------------------------------
word_139EC	dw 0			; DATA XREF: sub_1260A:loc_1285Br
					; sub_1260A+259w ...
word_139EE	dw 0			; DATA XREF: sub_1260A:loc_12868r
					; sub_1260A+266w ...
word_139F0	dw 0			; DATA XREF: sub_1260A:loc_12875r
					; sub_1260A+273w ...
		align 4
		dw 4, 4, 3, 6, 3, 6, 2,	8, 0, 6, -2, 6,	-3, 4, -3, 0, -4
off_13A16	dw offset word_13A1A	; DATA XREF: sub_10B7F+2Dw
					; sub_10B7F+73w ...
off_13A18	dw offset word_13A3E	; DATA XREF: sub_10B7F+34w
					; sub_10B7F+7Aw ...
word_13A1A	dw 36h,	6		; DATA XREF: sub_10B7F:loc_10C80o
					; seg000:off_13A16o
		dw 22h,	0Ah
		dw 17h,	0Ah
		dw 0Eh,	0Eh
		dw 0Ch,	13h
		dw 14h,	1Bh
		dw 1Bh,	20h
		dw 2Bh,	23h
		dw 39h,	23h
word_13A3E	dw 1Ah,	6		; DATA XREF: sub_10B7F+108o
					; seg000:off_13A18o
		dw 2Dh,	0Ah
		dw 38h,	0Ah
		dw 44h,	0Eh
		dw 46h,	13h
		dw 3Ch,	1Bh
		dw 35h,	20h
		dw 25h,	23h
		dw 18h,	23h
word_13A62	dw 0, 0			; DATA XREF: sub_10B7F:loc_10BEFo
		dw 2Eh,	3
		dw 1Bh,	5
		dw 0Ch,	0Ah
		dw 8, 0Fh
		dw 0Bh,	16h
		dw 13h,	1Ch
		dw 24h,	22h
		dw 0, 0
word_13A86	dw 0, 0			; DATA XREF: sub_10B7F+77o
		dw 22h,	3
		dw 35h,	5
		dw 44h,	0Ah
		dw 48h,	0Fh
		dw 45h,	16h
		dw 3Dh,	1Ch
		dw 2Ch,	22h
		dw 0, 0
word_13AAA	dw 0, 0			; DATA XREF: sub_10B7F:loc_10C34o
		dw 23h,	3
		dw 0Fh,	6
		dw 4, 0Dh
		dw 3, 14h
		dw 9, 1Ch
		dw 0Ch,	23h
		dw 2Ch,	27h
		dw 0, 0
word_13ACE	dw 0, 0			; DATA XREF: sub_10B7F+BCo
		dw 2Dh,	3
		dw 41h,	6
		dw 4Ch,	0Dh
		dw 4Dh,	14h
		dw 47h,	1Ch
		dw 44h,	23h
		dw 24h,	27h
		dw 0, 0
		dw 0, -16h
		dw -1Eh, -1Ah
		dw -28h, -16h
		dw -2Ch, -0Ah
		dw -30h, 0
		dw -2Ch, 0Ah
		dw -28h, 14h
		dw -14h, 16h
		dw 0, 18h
word_13B16	dw 0			; DATA XREF: sub_138A5+12Ew
					; sub_138A5+134r ...
word_13B18	dw 40h			; DATA XREF: sub_1344A+B5r
					; sub_138A5+71r ...
word_13B1A	dw 0			; DATA XREF: sub_138A5:loc_138D6w
					; sub_13DB1+32r ...
word_13B1C	dw 0			; DATA XREF: sub_138A5+3Aw
					; sub_13DB1+37r ...
		db 4 dup(0)

; =============== S U B	R O U T	I N E =======================================


sub_13B22	proc near		; CODE XREF: sub_138A5+8Ap
		cmp	cs:word_13BB3, 0
		jz	short loc_13B43
		cmp	cs:word_13BB3, 1
		jz	short loc_13B65
		cmp	cs:word_13BB3, 2
		jz	short loc_13B93
		cmp	cs:word_13BB3, 3
		jz	short loc_13B9F
		retn
; ---------------------------------------------------------------------------

loc_13B43:				; CODE XREF: sub_13B22+6j
		push	cx
		mov	ax, 1
		mov	cx, cs:WeaponGun3
		shl	ax, cl
		sub	si, ax
		mov	ax, cs:word_13B16
		shl	ax, cl
		add	si, ax
		pop	cx
		mov	ax, 0Bh
		add	ax, cs:WeaponGun3
		call	sub_14567
		retn
; ---------------------------------------------------------------------------

loc_13B65:				; CODE XREF: sub_13B22+Ej
		push	cx
		push	dx
		push	si
		mov	ax, si
		and	ax, 0FFh
		call	sub_1BE93
		sar	cx, 6
		sar	dx, 6
		neg	cx
		neg	dx
		add	cs:word_1EA54, cx
		add	cs:word_1EA58, dx
		pop	si
		pop	dx
		pop	cx
		mov	ax, 11h
		add	ax, cs:WeaponGun3
		call	sub_14567
		retn
; ---------------------------------------------------------------------------

loc_13B93:				; CODE XREF: sub_13B22+16j
		mov	ax, 18h
		add	ax, cs:WeaponGun3
		call	sub_14567
		retn
; ---------------------------------------------------------------------------

loc_13B9F:				; CODE XREF: sub_13B22+1Ej
		mov	ax, 1Bh
		add	ax, cs:WeaponGun3
		call	sub_14567
		retn
sub_13B22	endp

; ---------------------------------------------------------------------------
WeaponGun3	dw 0			; DATA XREF: sub_111F3+142w
					; DrawHUD+130r	...
word_13BAD	dw 4			; DATA XREF: sub_12FAF:loc_12FFBr
					; LoadCockpit+161w ...
WeaponGun1	dw 0			; DATA XREF: sub_111F3:loc_11328w
					; DrawHUD+E4r ...
WeaponGun2	dw 3			; DATA XREF: sub_111F3+13Cw
					; DrawHUD+10Ar	...
word_13BB3	dw 0			; DATA XREF: sub_10B7Fr sub_10B7F+8r ...
word_13BB5	dw 2			; DATA XREF: sub_138A5:loc_138B7r
					; sub_13D01+1Cw ...

; =============== S U B	R O U T	I N E =======================================


sub_13BB7	proc near		; CODE XREF: sub_138A5+1p
		cmp	cs:word_139EE, 0
		jnz	short locret_13BEA
		mov	ax, cs:word_13CBB
		mov	cs:word_139EE, ax
		cmp	cs:word_13CB9, 0
		jz	short loc_13BEB
		cmp	cs:word_13CB9, 1
		jz	short loc_13C0D
		cmp	cs:word_13CB9, 2
		jz	short loc_13C52
		cmp	cs:word_13CB9, 3
		jnz	short locret_13BEA
		jmp	loc_13C83
; ---------------------------------------------------------------------------

locret_13BEA:				; CODE XREF: sub_13BB7+6j
					; sub_13BB7+2Ej
		retn
; ---------------------------------------------------------------------------

loc_13BEB:				; CODE XREF: sub_13BB7+16j
		mov	cx, cs:word_1EA52
		mov	dx, cs:word_1EA56
		cmp	cs:word_1EA5C, 0
		jnz	short loc_13C00
		add	cx, 30h	; '0'

loc_13C00:				; CODE XREF: sub_13BB7+44j
		push	cx
		push	dx
		push	si
		mov	ax, 8
		call	sub_14567
		pop	si
		pop	dx
		pop	cx
		retn
; ---------------------------------------------------------------------------

loc_13C0D:				; CODE XREF: sub_13BB7+1Ej
		mov	si, 2D8h
		mov	cx, cs:word_1EA52
		mov	dx, cs:word_1EA56
		cmp	cs:word_1EA5C, 0
		jnz	short loc_13C28
		add	cx, 30h	; '0'
		mov	si, 0FD28h

loc_13C28:				; CODE XREF: sub_13BB7+69j
		mov	di, 0FD90h
		mov	ax, cs:word_1EA54
		shl	ax, 5
		add	si, ax
		mov	ax, cs:word_1EA58
		shl	ax, 4
		add	di, ax
		push	cx
		push	dx
		push	si
		push	di
		mov	ax, 14h
		call	sub_14567
		pop	di
		pop	si
		pop	dx
		pop	cx
		mov	ax, 15h
		call	sub_14567
		retn
; ---------------------------------------------------------------------------

loc_13C52:				; CODE XREF: sub_13BB7+26j
		mov	si, 5B0h
		mov	cx, cs:word_1EA52
		mov	dx, cs:word_1EA56
		cmp	cs:word_1EA5C, 0
		jnz	short loc_13C6D
		add	cx, 30h	; '0'
		mov	si, 0FA00h

loc_13C6D:				; CODE XREF: sub_13BB7+AEj
		mov	di, 0FE70h
		push	cx
		push	dx
		push	si
		mov	ax, 14h
		call	sub_14567
		pop	si
		pop	dx
		pop	cx
		mov	ax, 17h
		call	sub_14567
		retn
; ---------------------------------------------------------------------------

loc_13C83:				; CODE XREF: sub_13BB7+30j
		mov	si, 0FE94h
		mov	cx, cs:word_1EA52
		mov	dx, cs:word_1EA56
		add	dx, 10h
		cmp	cs:word_1EA5C, 0
		jnz	short loc_13CA1
		add	cx, 30h	; '0'
		mov	si, 16Ch

loc_13CA1:				; CODE XREF: sub_13BB7+E2j
		mov	di, 0FF80h
		push	cx
		push	dx
		push	si
		mov	ax, 1Fh
		call	sub_14567
		pop	si
		pop	dx
		pop	cx
		retn
sub_13BB7	endp

; ---------------------------------------------------------------------------
WeaponSub3	dw 0			; DATA XREF: sub_111F3+17Cw
					; DrawHUD+1B9r	...
word_13CB3	dw 4			; DATA XREF: sub_12FAF:loc_13057r
					; LoadCockpit+2D5w ...
WeaponSub1	dw 0			; DATA XREF: sub_111F3:loc_11362w
					; DrawHUD+16Dr	...
WeaponSub2	dw 3			; DATA XREF: sub_111F3+176w
					; DrawHUD+193r	...
word_13CB9	dw 0			; DATA XREF: sub_10CCFr sub_10CCF+8r ...
word_13CBB	dw 0Fh			; DATA XREF: sub_13BB7+8r
					; sub_13CBD+1Cw ...

; =============== S U B	R O U T	I N E =======================================


sub_13CBD	proc near		; CODE XREF: sub_111F3+196p
					; sub_12FAF+EDp ...
		push	es
		push	ds
		pusha
		mov	bx, cs:word_13CB9
		shl	bx, 1
		mov	ax, cs:[bx+3CE1h]
		mov	bx, ax
		mov	ax, cs:WeaponSub3
		shl	ax, 1
		add	bx, ax
		mov	ax, cs:[bx]
		mov	cs:word_13CBB, ax
		popa
		pop	ds
		pop	es
		retn
sub_13CBD	endp

; ---------------------------------------------------------------------------
		dw offset word_13CE9
		dw offset word_13CEF
		dw offset word_13CF5
		dw offset word_13CFB
word_13CE9	dw 0Fh,	0Ah, 5		; DATA XREF: seg000:3CE1o
word_13CEF	dw 0Fh,	0Ah, 5		; DATA XREF: seg000:3CE1o
word_13CF5	dw 5, 4, 2		; DATA XREF: seg000:3CE1o
word_13CFB	dw 11h,	0Ch, 7		; DATA XREF: seg000:3CE1o

; =============== S U B	R O U T	I N E =======================================


sub_13D01	proc near		; CODE XREF: sub_111F3+15Cp
					; sub_12FAF+91p ...
		push	es
		push	ds
		pusha
		mov	bx, cs:word_13BB3
		shl	bx, 1
		mov	ax, cs:off_13D25[bx]
		mov	bx, ax
		mov	ax, cs:WeaponGun3
		shl	ax, 1
		add	bx, ax
		mov	ax, cs:[bx]
		mov	cs:word_13BB5, ax
		popa
		pop	ds
		pop	es
		retn
sub_13D01	endp

; ---------------------------------------------------------------------------
off_13D25	dw offset word_13D2D	; DATA XREF: sub_13D01+Ar
		dw offset word_13D37
		dw offset word_13D3D
		dw offset word_13D43
word_13D2D	dw 2, 2, 2, 2, 2	; DATA XREF: seg000:off_13D25o
word_13D37	dw 0Dh,	0Bh, 9		; DATA XREF: seg000:off_13D25o
word_13D3D	dw 2, 3, 3		; DATA XREF: seg000:off_13D25o
word_13D43	dw 0Ah,	5, 1		; DATA XREF: seg000:off_13D25o

; =============== S U B	R O U T	I N E =======================================


sub_13D49	proc near		; CODE XREF: sub_138A5+4p
		cmp	cs:word_139F0, 0
		jnz	short locret_13D79
		mov	ax, cs:word_13DAF
		mov	cs:word_139F0, ax
		cmp	cs:word_13DAD, 0
		jz	short locret_13D7A
		cmp	cs:word_13DAD, 1
		jz	short loc_13D7B
		cmp	cs:word_13DAD, 2
		jz	short locret_13D7F
		cmp	cs:word_13DAD, 3
		jz	short loc_13D80

locret_13D79:				; CODE XREF: sub_13D49+6j
		retn
; ---------------------------------------------------------------------------

locret_13D7A:				; CODE XREF: sub_13D49+16j
		retn
; ---------------------------------------------------------------------------

loc_13D7B:				; CODE XREF: sub_13D49+1Ej
		call	sub_133AD
		retn
; ---------------------------------------------------------------------------

locret_13D7F:				; CODE XREF: sub_13D49+26j
		retn
; ---------------------------------------------------------------------------

loc_13D80:				; CODE XREF: sub_13D49+2Ej
		mov	cx, cs:word_1EA52
		mov	dx, cs:word_1EA56
		add	dx, 8
		sub	dx, cs:word_14133
		mov	si, 0F800h
		sub	cx, 20h
		cmp	cs:word_1EA5C, 0
		jz	short loc_13DA6
		add	cx, 50h
		mov	si, 800h

loc_13DA6:				; CODE XREF: sub_13D49+55j
		mov	ax, 21h
		call	sub_14567
		retn
sub_13D49	endp

; ---------------------------------------------------------------------------
word_13DAD	dw 0			; DATA XREF: sub_10CCF:loc_10CF5r
					; sub_10CCF+5Cr ...
word_13DAF	dw 1Eh			; DATA XREF: sub_13D49+8r
					; LoadCockpit+442w ...

; =============== S U B	R O U T	I N E =======================================


sub_13DB1	proc near		; CODE XREF: sub_1260A+8B7p
		mov	ax, cs:word_13B18
		shr	ax, 4
		mov	cs:word_1EA6A, ax
		mov	cx, cs:word_1EA52
		mov	dx, cs:word_1EA56
		sub	dx, cs:word_14133
		sub	cx, 38
		sub	dx, 8
		add	dx, cs:word_137A0
		mov	ax, cs:word_1EA6A
		mov	bx, ax
		shl	bx, 1
		sub	dx, cs:word_13E6F[bx]
		add	cx, cs:word_13B1A
		add	dx, cs:word_13B1C
		cmp	cs:word_13B1A, 0
		jz	short loc_13E14
		test	cs:word_13B1A, 8000h
		jz	short loc_13E0A
		inc	cs:word_13B1A
		inc	cs:word_13B1A
		jmp	short loc_13E14
; ---------------------------------------------------------------------------

loc_13E0A:				; CODE XREF: sub_13DB1+4Bj
		dec	cs:word_13B1A
		dec	cs:word_13B1A

loc_13E14:				; CODE XREF: sub_13DB1+42j
					; sub_13DB1+57j
		cmp	cs:word_13B1C, 0
		jz	short loc_13E31
		test	cs:word_13B1C, 8000h
		jz	short loc_13E2C
		inc	cs:word_13B1C
		jmp	short loc_13E31
; ---------------------------------------------------------------------------

loc_13E2C:				; CODE XREF: sub_13DB1+72j
		dec	cs:word_13B1C

loc_13E31:				; CODE XREF: sub_13DB1+69j
					; sub_13DB1+79j
		cmp	cs:word_1EA5C, 0
		jz	short loc_13E46
		add	cx, 46
		add	ax, 9
		sub	cx, cs:word_1379E
		jmp	short loc_13E4B
; ---------------------------------------------------------------------------

loc_13E46:				; CODE XREF: sub_13DB1+86j
		add	cx, cs:word_1379E

loc_13E4B:				; CODE XREF: sub_13DB1+93j
		mov	cs:word_13E81, cx
		mov	cs:word_13E83, dx
		mov	ds, cs:word_1E9BA
		sub	si, si
		cmp	cs:word_1318E, 0
		jnz	short loc_13E69
		call	AddHDFSpr_Mode0
		jmp	short locret_13E6E
; ---------------------------------------------------------------------------

loc_13E69:				; CODE XREF: sub_13DB1+B1j
		mov	ah, 0Fh
		call	AddHDFSpr_Mode2

locret_13E6E:				; CODE XREF: sub_13DB1+B6j
		retn
sub_13DB1	endp

; ---------------------------------------------------------------------------
word_13E6F	dw 0Bh,	0Dh, 0Bh, 6, 0	; DATA XREF: sub_13DB1+2Dr
		dw -4, -6, -8, -8
word_13E81	dw 0			; DATA XREF: sub_138A5+5Er
					; sub_13DB1:loc_13E4Bw
word_13E83	dw 0			; DATA XREF: sub_138A5+63r
					; sub_13DB1+9Fw

; =============== S U B	R O U T	I N E =======================================


sub_13E85	proc near		; CODE XREF: sub_1260A+7Fp
					; sub_1260A+C7p ...
		cmp	cs:word_13EE5, 1
		jz	short loc_13EDD
		cmp	cs:word_13BB3, 1
		jz	short loc_13EB8
		cmp	cs:word_13BB3, 2
		jz	short loc_13EB8
		push	bx
		mov	bx, cs:word_13B18
		cmp	ax, bx
		jz	short loc_13EB1
		jnb	short loc_13EAE
		sub	bx, 8
		jmp	short loc_13EB1
; ---------------------------------------------------------------------------

loc_13EAE:				; CODE XREF: sub_13E85+22j
		add	bx, 8

loc_13EB1:				; CODE XREF: sub_13E85+20j
					; sub_13E85+27j
		mov	cs:word_13B18, bx
		pop	bx
		retn
; ---------------------------------------------------------------------------

loc_13EB8:				; CODE XREF: sub_13E85+Ej
					; sub_13E85+16j
		push	bx
		mov	bx, cs:word_13B18
		cmp	ax, bx
		jz	short loc_13ED6
		jnb	short loc_13ECE
		cmp	bx, 10h
		jz	short loc_13ED6
		sub	bx, 8
		jmp	short loc_13ED6
; ---------------------------------------------------------------------------

loc_13ECE:				; CODE XREF: sub_13E85+3Dj
		cmp	bx, 120
		jz	short loc_13ED6
		add	bx, 8

loc_13ED6:				; CODE XREF: sub_13E85+3Bj
					; sub_13E85+42j ...
		mov	cs:word_13B18, bx
		pop	bx
		retn
; ---------------------------------------------------------------------------

loc_13EDD:				; CODE XREF: sub_13E85+6j
		mov	cs:word_13EE5, 0
		retn
sub_13E85	endp

; ---------------------------------------------------------------------------
word_13EE5	dw 0			; DATA XREF: sub_1260A+6Fw
					; sub_1260A+247w ...

; =============== S U B	R O U T	I N E =======================================


sub_13EE7	proc near		; CODE XREF: sub_1260A+14p
					; sub_1260A+50Bp ...
		cmp	cs:word_13190, 0
		jz	short loc_13EF2
		jmp	loc_13FC4
; ---------------------------------------------------------------------------

loc_13EF2:				; CODE XREF: sub_13EE7+6j
		cmp	cs:word_1EA66, 0
		jnz	short locret_13F19
		cmp	cs:word_13DAD, 3
		jnz	short loc_13F04
		sar	ax, 1

loc_13F04:				; CODE XREF: sub_13EE7+19j
		sub	cs:word_1EA60, ax
		cmp	cs:word_1EA60, 10000
		jnb	short loc_13F1A
		mov	cs:word_1EA66, 10h

locret_13F19:				; CODE XREF: sub_13EE7+11j
					; sub_13EE7+40j ...
		retn
; ---------------------------------------------------------------------------

loc_13F1A:				; CODE XREF: sub_13EE7+29j
		mov	cs:word_1EA60, 0
		cmp	cs:word_12F27, 0
		jnz	short locret_13F19
		push	es
		push	ds
		pusha
		sub	dx, dx
		call	Music_FadeOut
		mov	cs:word_12F27, 1
		mov	cs:word_12235, 9
		mov	cs:byte_12237, 0
		mov	cs:word_1EA60, 0
		mov	ax, cs:word_1EA52
		mov	cs:word_12F29, ax
		mov	ax, 10h
		call	GetRandomInRange
		sub	ax, 8
		mov	cs:word_12F2B, ax
		mov	ax, cs:word_1EA56
		mov	cs:word_12F2D, ax
		mov	cs:word_12F2F, -8
		mov	cs:word_12F31, 0
		mov	ax, cs
		mov	ds, ax
		assume ds:seg000
		mov	bx, offset aDeathScream	; "ÅyóÌÅzÅ@ÉLÉÉÉAÉAÉAÉAÉAÉAÉAÉAÉAÉAÉAÉAÉAÉ"...
		mov	al, 32h
		mov	ah, 0Fh
		call	cmfLoadTxtPtr3A
		popa
		pop	ds
		assume ds:nothing
		pop	es
		jmp	short locret_13F19
; ---------------------------------------------------------------------------
aDeathScream	db 'ÅyóÌÅzÅ@ÉLÉÉÉAÉAÉAÉAÉAÉAÉAÉAÉAÉAÉAÉAÉAÉAÉAÉAÉAÉAÉAÉAÅI',0
					; DATA XREF: sub_13EE7+94o
					; [Rei]	Kyaaaaaaaaaaaaaaaaaaaa!
		align 4

loc_13FC4:				; CODE XREF: sub_13EE7+8j
		mov	cs:word_1318E, 1
		sub	cs:word_13190, ax
		test	cs:word_13190, 8000h
		jnz	short loc_13FDC
		jmp	locret_13F19
; ---------------------------------------------------------------------------

loc_13FDC:				; CODE XREF: sub_13EE7+F0j
		mov	cs:word_13190, 0
		mov	ax, 0
		call	sub_13EE7
		mov	cx, cs:word_1EA52
		mov	dx, cs:word_1EA56
		mov	ax, 30h
		call	GetRandomInRange
		add	cx, ax
		mov	ax, 30h
		call	GetRandomInRange
		add	dx, ax
		mov	ax, 2
		call	sub_15EF8
		jmp	locret_13F19
sub_13EE7	endp

; ---------------------------------------------------------------------------
		dw 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 100
		dw 100,	100, 100, 100, 100, 100, 0, 0, 0, 0, 0,	0, 0, 0
		dw 0, 0, 0, 0, 0, 0, 0,	0, 100,	100, 100, 100, 100, 100
		dw 100,	100

; =============== S U B	R O U T	I N E =======================================


sub_1406C	proc near		; CODE XREF: sub_1260A+5E2p
		push	ax
		push	cx
		push	dx
		push	bx
		mov	cx, cs:word_1EA52
		mov	dx, cs:word_1EA56
		add	dx, 10h
		add	cx, 40h
		call	sub_1A65E
		cmp	ax, cs:word_1BE30
		jnb	short loc_1408F
		pop	bx
		pop	dx
		pop	cx
		pop	ax
		retn
; ---------------------------------------------------------------------------

loc_1408F:				; CODE XREF: sub_1406C+1Cj
		pop	bx
		pop	dx
		pop	cx
		pop	ax
		retn
sub_1406C	endp


; =============== S U B	R O U T	I N E =======================================


sub_14094	proc near		; CODE XREF: sub_1260A+599p
		push	ax
		push	cx
		push	dx
		push	bx
		mov	cx, cs:word_1EA52
		mov	dx, cs:word_1EA56
		add	dx, 16
		sub	cx, 16
		call	sub_1A65E
		cmp	ax, cs:word_1BE30
		jnb	short loc_140B7
		pop	bx
		pop	dx
		pop	cx
		pop	ax
		retn
; ---------------------------------------------------------------------------

loc_140B7:				; CODE XREF: sub_14094+1Cj
		pop	bx
		pop	dx
		pop	cx
		pop	ax
		retn
sub_14094	endp


; =============== S U B	R O U T	I N E =======================================


sub_140BC	proc near		; CODE XREF: sub_1260A:loc_12A9Fp
					; sub_1260A+4E0p ...
		push	ax
		push	cx
		push	dx
		push	bx
		call	sub_140F9
		mov	cx, cs:word_1EA52
		mov	dx, cs:word_1EA56
		add	dx, cs:word_14133
		add	dx, 40
		add	cx, 16
		call	sub_1A65E
		cmp	ax, cs:word_1BE30
		jnb	short loc_140F4
		add	cx, 16
		call	sub_1A65E
		cmp	ax, cs:word_1BE30
		jnb	short loc_140F4
		pop	bx
		pop	dx
		pop	cx
		pop	ax
		retn
; ---------------------------------------------------------------------------

loc_140F4:				; CODE XREF: sub_140BC+24j
					; sub_140BC+31j
		pop	bx
		pop	dx
		pop	cx
		pop	ax
		retn
sub_140BC	endp


; =============== S U B	R O U T	I N E =======================================


sub_140F9	proc near		; CODE XREF: sub_1260A+487p
					; sub_1260A+6B5p ...
		push	ax
		push	cx
		push	dx
		push	bx
		mov	cx, cs:word_1EA52
		mov	dx, cs:word_1EA56
		add	dx, 20h	; ' '
		mov	cs:word_14133, 0
		add	cx, 10h
		mov	bx, 10h

loc_14117:				; CODE XREF: sub_140F9+33j
		push	bx
		call	sub_1A65E
		cmp	cs:word_14133, bx
		jnb	short loc_14127
		mov	cs:word_14133, bx

loc_14127:				; CODE XREF: sub_140F9+27j
		pop	bx
		add	cx, 2
		dec	bx
		jnz	short loc_14117
		pop	bx
		pop	dx
		pop	cx
		pop	ax
		retn
sub_140F9	endp

; ---------------------------------------------------------------------------
word_14133	dw 0			; DATA XREF: sub_1260A+6B8r
					; sub_13D49+44r ...

; =============== S U B	R O U T	I N E =======================================


sub_14135	proc near		; CODE XREF: sub_1260A+626p
		push	ax
		push	cx
		push	dx
		push	bx
		mov	cx, cs:word_1EA52
		mov	dx, cs:word_1EA56
		add	cx, 10h
		call	sub_1A65E
		cmp	ax, cs:word_1BE30
		jnb	short loc_14162
		add	cx, 10h
		call	sub_1A65E
		cmp	ax, cs:word_1BE30
		jnb	short loc_14162
		pop	bx
		pop	dx
		pop	cx
		pop	ax
		retn
; ---------------------------------------------------------------------------

loc_14162:				; CODE XREF: sub_14135+19j
					; sub_14135+26j
		pop	bx
		pop	dx
		pop	cx
		pop	ax
		retn
sub_14135	endp


; =============== S U B	R O U T	I N E =======================================


sub_14167	proc near		; CODE XREF: sub_10F09+158p
		push	ax
		push	bx
		mov	ax, cs:word_1EA54
		mov	bx, cs:word_1EA58
		mov	cx, cs:word_1EA52
		mov	dx, cs:word_1EA56
		push	bx
		mov	bx, cs:word_1BDF8
		cmp	cs:word_1BE0C, bx
		pop	bx
		jb	short loc_141C1
		jz	short loc_141C1
		cmp	cs:word_1BE0C, 0
		jz	short loc_141C1
		test	ah, 80h
		jz	short loc_141C3
		push	bx
		mov	bx, cs:word_1BDF8
		cmp	cs:word_1BE0C, bx
		pop	bx
		jb	short loc_141C1
		jz	short loc_141C1
		cmp	cs:word_1BE0C, 0
		jz	short loc_141C1
		cmp	cx, 190h
		jnb	short loc_141C1
		add	cs:MapPosX, ax
		sub	cs:word_14399, ax

loc_141C1:				; CODE XREF: sub_14167+21j
					; sub_14167+23j ...
		jmp	short loc_141F7
; ---------------------------------------------------------------------------

loc_141C3:				; CODE XREF: sub_14167+30j
		push	bx
		mov	bx, cs:word_1BDFA
		sub	bx, 28h	; '('
		cmp	cs:word_1BE0C, bx
		pop	bx
		jnb	short loc_141F7
		jz	short loc_141F7
		push	bx
		mov	bx, cs:word_1BDF6
		sub	bx, 28h	; '('
		cmp	cs:word_1BE0C, bx
		pop	bx
		jz	short loc_141F7
		cmp	cx, 0A0h ; '†'
		jb	short loc_141F7
		add	cs:MapPosX, ax
		sub	cs:word_14399, ax

loc_141F7:				; CODE XREF: sub_14167:loc_141C1j
					; sub_14167+6Bj ...
		push	bx
		mov	bx, cs:word_1BDFE
		cmp	cs:word_1BE10, bx
		pop	bx
		jb	short loc_14226
		jz	short loc_14226
		cmp	cs:word_1BE10, 1
		jz	short loc_14226
		cmp	dx, 68h	; 'h'
		jnb	short loc_14226
		mov	bx, cs:word_1EA56
		sub	bx, 68h	; 'h'
		add	cs:MapPosY, bx
		sub	cs:word_1439B, bx

loc_14226:				; CODE XREF: sub_14167+9Cj
					; sub_14167+9Ej ...
		mov	ax, cs:word_1BE00
		sub	ax, 19h
		cmp	cs:word_1BE10, ax
		jnb	short loc_1425B
		jz	short loc_1425B
		mov	ax, cs:word_1BDFC
		sub	ax, 19h
		cmp	cs:word_1BE10, ax
		jz	short loc_1425B
		cmp	dx, 68h	; 'h'
		jb	short loc_1425B
		mov	bx, cs:word_1EA56
		sub	bx, 68h	; 'h'
		add	cs:MapPosY, bx
		sub	cs:word_1439B, bx

loc_1425B:				; CODE XREF: sub_14167+CBj
					; sub_14167+CDj ...
		jmp	short $+2
		cmp	cs:word_1EA54, 0
		jz	short loc_142D8
		mov	cx, cs:word_1EA52
		add	cx, cs:word_14399
		test	cs:word_1EA54, 8000h
		jz	short loc_142A4
		push	bx
		mov	bx, cs:word_1BDF8
		cmp	cs:word_1BE0C, bx
		pop	bx
		jb	short loc_142A2
		jz	short loc_142A2
		cmp	cs:word_1BE0C, 0
		jz	short loc_142A2
		cmp	cx, 190h
		jnb	short loc_142A2
		add	cs:MapPosX, 0FFF8h
		sub	cs:word_14399, 0FFF8h

loc_142A2:				; CODE XREF: sub_14167+11Dj
					; sub_14167+11Fj ...
		jmp	short loc_142D8
; ---------------------------------------------------------------------------

loc_142A4:				; CODE XREF: sub_14167+10Fj
		mov	bx, cs:word_1BDFA
		sub	bx, 28h	; '('
		cmp	cs:word_1BE0C, bx
		jnb	short loc_142D6
		jz	short loc_142D6
		mov	bx, cs:word_1BDF6
		sub	bx, 28h	; '('
		cmp	cs:word_1BE0C, bx
		jz	short loc_142D6
		cmp	cx, 0A0h ; '†'
		jb	short loc_142D6
		add	cs:MapPosX, 8
		sub	cs:word_14399, 8

loc_142D6:				; CODE XREF: sub_14167+14Aj
					; sub_14167+14Cj ...
		jmp	short $+2

loc_142D8:				; CODE XREF: sub_14167+FCj
					; sub_14167:loc_142A2j
		cmp	cs:word_14399, 0
		jz	short loc_142E8
		mov	ax, cs:word_14399
		mov	cs:word_143A1, ax

loc_142E8:				; CODE XREF: sub_14167+177j
		cmp	cs:word_1BDF0, 0
		jnz	short loc_14349
		cmp	cs:word_1BDEE, 0
		jnz	short loc_1435A
		jmp	short loc_14349
; ---------------------------------------------------------------------------
		mov	cs:BasePosX, 0
		mov	ax, cs:word_14399
		cmp	ax, 0
		jz	short loc_14337
		test	ah, 80h
		jz	short loc_14326
		neg	ax
		cmp	ax, 8
		jb	short loc_14337
		and	ax, 0FFF8h
		neg	ax
		mov	cs:BasePosX, ax
		sub	cs:word_14399, ax
		jmp	short loc_14337
; ---------------------------------------------------------------------------

loc_14326:				; CODE XREF: sub_14167+1A6j
		cmp	ax, 8
		jb	short loc_14337
		and	ax, 0FFF8h
		mov	cs:BasePosX, ax
		sub	cs:word_14399, ax

loc_14337:				; CODE XREF: sub_14167+1A1j
					; sub_14167+1ADj ...
		mov	ax, cs:word_1439B
		mov	cs:BasePosY, ax
		mov	cs:word_1439B, 0
		pop	bx
		pop	ax
		retn
; ---------------------------------------------------------------------------

loc_14349:				; CODE XREF: sub_14167+187j
					; sub_14167+191j
		mov	ax, cs:word_14399
		mov	cs:BasePosX, ax
		mov	cs:word_14399, 0
		jmp	short loc_14337
; ---------------------------------------------------------------------------

loc_1435A:				; CODE XREF: sub_14167+18Fj
		mov	cs:BasePosX, 0
		mov	ax, cs:word_14399
		cmp	ax, 0
		jz	short loc_14337
		test	ah, 80h
		jz	short loc_14386
		neg	ax
		cmp	ax, 10h
		jb	short loc_14337
		and	ax, 0FFF0h
		neg	ax
		mov	cs:BasePosX, ax
		sub	cs:word_14399, ax
		jmp	short loc_14337
; ---------------------------------------------------------------------------

loc_14386:				; CODE XREF: sub_14167+206j
		cmp	ax, 10h
		jb	short loc_14337
		and	ax, 0FFF0h
		mov	cs:BasePosX, ax
		sub	cs:word_14399, ax
		jmp	short loc_14337
sub_14167	endp

; ---------------------------------------------------------------------------
word_14399	dw 0			; DATA XREF: sub_14167+55w
					; sub_14167+8Bw ...
word_1439B	dw 0			; DATA XREF: sub_14167+BAw
					; sub_14167+EFw ...
		db 4 dup(0)
word_143A1	dw 0			; DATA XREF: sub_14167+17Dw
					; seg000:5930r
; ---------------------------------------------------------------------------
		retn
; ---------------------------------------------------------------------------
		push	bx
		pop	bx
		retn

; =============== S U B	R O U T	I N E =======================================


sub_143A7	proc near		; CODE XREF: sub_1260A+75Dp
					; sub_1260A+787p ...
		pusha
		mov	bp, 447Eh
		mov	bx, cx
		mov	cx, 0Ah

loc_143B0:				; CODE XREF: sub_143A7+67j
		push	cx
		cmp	word ptr cs:[bp+0], 0
		jnz	short loc_1440A
		mov	word ptr cs:[bp+0], 1
		mov	word ptr cs:[bp+2], 0
		mov	cs:[bp+8], bx

loc_143C8:				; CODE XREF: sub_143A7+36j
		add	dx, 2
		cmp	dx, 0BEh ; 'æ'
		jnb	short loc_143E5
		mov	cx, bx
		push	bx
		call	sub_1A65E
		pop	bx
		cmp	ax, cs:word_1BE30
		jb	short loc_143C8
		cmp	dx, 0BEh ; 'æ'
		jb	short loc_143ED

loc_143E5:				; CODE XREF: sub_143A7+28j
		mov	word ptr cs:[bp+0], 0
		jmp	short loc_14412
; ---------------------------------------------------------------------------

loc_143ED:				; CODE XREF: sub_143A7+3Cj
		sub	dx, 6
		mov	cs:[bp+0Ah], dx
		mov	cs:[bp+0Ch], si
		mov	cs:[bp+0Eh], di
		mov	word ptr cs:[bp+6], 2
		mov	word ptr cs:[bp+4], 3
		jmp	short loc_14412
; ---------------------------------------------------------------------------

loc_1440A:				; CODE XREF: sub_143A7+Fj
		pop	cx
		add	bp, 10h
		loop	loc_143B0

loc_14410:				; CODE XREF: sub_143A7+6Cj
		popa
		retn
; ---------------------------------------------------------------------------

loc_14412:				; CODE XREF: sub_143A7+44j
					; sub_143A7+61j
		pop	cx
		jmp	short loc_14410
sub_143A7	endp


; =============== S U B	R O U T	I N E =======================================


sub_14415	proc near		; CODE XREF: sub_10F09+46p
		mov	ds, cs:segHdf_smoke
		mov	bp, 447Eh
		mov	cx, 0Ah

loc_14420:				; CODE XREF: sub_14415+66j
		push	cx
		cmp	word ptr cs:[bp+0], 0
		jz	short loc_14477
		sub	si, si
		mov	ax, cs:[bp+2]
		mov	cx, cs:[bp+0Ch]
		mov	dx, cs:[bp+0Eh]
		add	cs:[bp+8], cx
		add	cs:[bp+0Ah], dx
		mov	cx, cs:[bp+8]
		mov	dx, cs:[bp+0Ah]
		push	bp
		call	AddHDFSpr_Mode3
		pop	bp
		dec	word ptr cs:[bp+6]
		cmp	word ptr cs:[bp+6], 0
		jnz	short loc_14477
		mov	word ptr cs:[bp+6], 2
		dec	word ptr cs:[bp+4]
		inc	word ptr cs:[bp+2]
		cmp	word ptr cs:[bp+4], 0
		jnz	short loc_14477
		mov	word ptr cs:[bp+4], 3
		mov	word ptr cs:[bp+0], 0

loc_14477:				; CODE XREF: sub_14415+11j
					; sub_14415+3Fj ...
		pop	cx
		add	bp, 10h
		loop	loc_14420
		retn
sub_14415	endp

; ---------------------------------------------------------------------------
		db 4 dup(0), 3,	0, 2, 0Dh dup(0), 3, 0,	2, 0Dh dup(0)
		db 3, 0, 2, 0Dh	dup(0),	3, 0, 2, 0Dh dup(0), 3,	0, 2, 0Dh dup(0)
		db 3, 0, 2, 0Dh	dup(0),	3, 0, 2, 0Dh dup(0), 3,	0, 2, 0Dh dup(0)
		db 3, 0, 2, 0Dh	dup(0),	3, 0, 2, 0Dh dup(0), 3,	0, 2, 9	dup(0)
; ---------------------------------------------------------------------------
		cmp	cs:word_14565, 0
		jnz	short locret_14562
		mov	ax, cs:word_14563
		mov	cs:word_14565, ax
		mov	cx, cs:word_1EA52
		mov	dx, cs:word_1EA56
		cmp	cs:word_1EA5C, 0
		jnz	short loc_14553
		add	cx, 30h	; '0'

loc_14553:				; CODE XREF: seg000:454Ej
		push	cx
		push	dx
		push	si
		mov	ax, 8
		call	sub_14567
		pop	si
		pop	dx
		pop	cx
		call	sub_133AD

locret_14562:				; CODE XREF: seg000:4534j
		retn
; ---------------------------------------------------------------------------
word_14563	dw 0Fh			; DATA XREF: seg000:4536r
word_14565	dw 0			; DATA XREF: seg000:452Er seg000:453Aw ...

; =============== S U B	R O U T	I N E =======================================


sub_14567	proc near		; CODE XREF: sub_1260A+68Fp
					; sub_13192+E1p ...
		push	cx
		push	bp
		push	ds
		push	ax
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		pop	ax
		mov	cs:word_145EB, cx
		mov	bp, offset byte_202A0
		mov	cx, 46h

loc_1457C:				; CODE XREF: sub_14567+38j
		cmp	byte ptr ds:[bp+0], 0
		jnz	short loc_1459C
		mov	ds:[bp+0], al
		mov	bx, ax
		shl	bx, 1
		push	cx
		push	bp
		mov	cx, cs:word_145EB
		call	cs:off_145A5[bx]
		pop	bp
		pop	cx
		mov	cx, 1

loc_1459C:				; CODE XREF: sub_14567+1Aj
		add	bp, 17h
		loop	loc_1457C
		pop	ds
		assume ds:nothing
		pop	bp
		pop	cx
		retn
sub_14567	endp

; ---------------------------------------------------------------------------
off_145A5	dw offset start		; 0 ; DATA XREF: sub_14567+2Br
					; seg000:461Br
		dw offset loc_147E8	; 1
		dw offset loc_155CC	; 2
		dw offset loc_155ED	; 3
		dw offset loc_1560E	; 4
		dw offset loc_1561E	; 5
		dw offset loc_1562E	; 6
		dw offset loc_1565B	; 7
		dw offset loc_1567B	; 8
		dw offset loc_1573F	; 9
		dw offset loc_1577D	; 0Ah
		dw offset loc_151CE	; 0Bh
		dw offset loc_1520A	; 0Ch
		dw offset loc_15240	; 0Dh
		dw offset loc_15276	; 0Eh
		dw offset loc_152AC	; 0Fh
		dw offset loc_152E2	; 10h
		dw offset loc_1482C	; 11h
		dw offset loc_14868	; 12h
		dw offset loc_148A4	; 13h
		dw offset loc_14CBE	; 14h
		dw offset loc_14D31	; 15h
		dw offset loc_15014	; 16h
		dw offset loc_14F6F	; 17h
		dw offset loc_14B7E	; 18h
		dw offset loc_14BB9	; 19h
		dw offset loc_14BF8	; 1Ah
		dw offset loc_148E0	; 1Bh
		dw offset loc_14923	; 1Ch
		dw offset loc_14966	; 1Dh
		dw offset loc_149A9	; 1Eh
		dw offset loc_14D63	; 1Fh
		dw offset loc_14D91	; 20h
		dw offset loc_146C0	; 21h
		dw offset loc_1480A	; 22h
word_145EB	dw 0			; DATA XREF: sub_14567+Aw
					; sub_14567+26r
; ---------------------------------------------------------------------------
		push	ax
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		pop	ax
		push	cx
		push	bp
		mov	cs:word_1462D, cx
		mov	bp, offset byte_202A0
		add	bp, 64Ah
		mov	cx, 46h

loc_14605:				; CODE XREF: seg000:4628j
		cmp	byte ptr ds:[bp+0], 0
		jnz	short loc_14625

loc_1460C:
		mov	ds:[bp+0], al
		mov	bx, ax
		shl	bx, 1
		push	cx
		push	bp

loc_14616:
		mov	cx, cs:word_1462D
		call	cs:off_145A5[bx]
		pop	bp
		pop	cx
		mov	cx, 1

loc_14625:				; CODE XREF: seg000:460Aj
		sub	bp, 17h
		loop	loc_14605
		pop	bp
		pop	cx
		retn
; ---------------------------------------------------------------------------
word_1462D	dw 0			; DATA XREF: seg000:45F6w
					; seg000:loc_14616r

; =============== S U B	R O U T	I N E =======================================


sub_1462F	proc near		; CODE XREF: sub_10F09+40p
		push	ax
		mov	ax, seg	seg001
		mov	ds, ax
		pop	ax
		cmp	cs:word_14565, 0
		jz	short loc_14643
		dec	cs:word_14565

loc_14643:				; CODE XREF: sub_1462F+Dj
		mov	bp, offset byte_202A0
		mov	cx, 46h

loc_14649:				; CODE XREF: sub_1462F+48j
		cmp	byte ptr ds:[bp+0], 0
		jz	short loc_14674
		mov	ax, cs:word_1B8B9
		push	ax
		mov	cs:word_1B8B9, 4
		sub	ah, ah
		mov	al, ds:[bp+0]
		mov	bx, ax
		shl	bx, 1
		push	cx
		push	bp
		call	cs:off_1467A[bx]
		pop	bp
		pop	cx
		pop	ax
		mov	cs:word_1B8B9, ax

loc_14674:				; CODE XREF: sub_1462F+1Fj
		add	bp, 17h
		loop	loc_14649
		retn
sub_1462F	endp

; ---------------------------------------------------------------------------
off_1467A	dw offset start		; 0 ; DATA XREF: sub_1462F+39r
		dw offset loc_157A7	; 1
		dw offset loc_1582E	; 2
		dw offset loc_1582E	; 3
		dw offset loc_1587A	; 4
		dw offset loc_1587A	; 5
		dw offset loc_158AD	; 6
		dw offset loc_158E3	; 7
		dw offset loc_159CF	; 8
		dw offset loc_15AF8	; 9
		dw offset loc_15C23	; 0Ah
		dw offset loc_15315	; 0Bh
		dw offset loc_15315	; 0Ch
		dw offset loc_15315	; 0Dh
		dw offset loc_15315	; 0Eh
		dw offset loc_15315	; 0Fh
		dw offset loc_1557B	; 10h
		dw offset loc_15118	; 11h
		dw offset loc_15118	; 12h
		dw offset loc_15118	; 13h
		dw offset loc_14CEA	; 14h
		dw offset loc_14DC3	; 15h
		dw offset loc_15040	; 16h
		dw offset loc_14F97	; 17h
		dw offset loc_14C39	; 18h
		dw offset loc_14C39	; 19h
		dw offset loc_14C39	; 1Ah
		dw offset loc_14A56	; 1Bh
		dw offset loc_14A56	; 1Ch
		dw offset loc_14AEA	; 1Dh
		dw offset loc_149E0	; 1Eh
		dw offset loc_14E6A	; 1Fh
		dw offset loc_14F18	; 20h
		dw offset loc_14718	; 21h
; ---------------------------------------------------------------------------
		jmp	short locret_14717
; ---------------------------------------------------------------------------

loc_146C0:				; DATA XREF: seg000:off_145A5o
		mov	ax, cs:word_1B8B9
		mov	cs:word_1B8B9, 4
		push	ax
		push	cx
		push	dx
		push	si
		push	ds
		mov	ds, cs:segHdf_rayoX
		assume ds:nothing
		sub	si, si
		mov	ax, 2

loc_146DA:
		call	AddHDFSpr_Mode0
		pop	ds
		pop	si
		pop	dx
		pop	cx
		pop	ax
		mov	cs:word_1B8B9, ax
		mov	ax, 3
		test	si, 8000h
		jz	short loc_146F3
		inc	ax

loc_146F0:
		sub	cx, 20h	; ' '

loc_146F3:				; CODE XREF: seg000:46EDj
		add	dx, 4
		call	sub_15D5F
		mov	ds:[bp+9], si
		mov	word ptr ds:[bp+0Bh], 0
		mov	ds:[bp+0Dh], ax
		mov	word ptr ds:[bp+0Fh], 0
		mov	byte ptr ds:[bp+11h], 1
		mov	byte ptr ds:[bp+12h], 2

locret_14717:				; CODE XREF: seg000:46BEj
		retn
; ---------------------------------------------------------------------------

loc_14718:				; DATA XREF: seg000:off_1467Ao
		call	sub_15C93
		call	sub_15C7C
		cmp	word ptr ds:[bp+0Fh], 0
		jz	short loc_14780
		dec	word ptr ds:[bp+0Fh]
		test	word ptr ds:[bp+0Fh], 1
		jz	short loc_1475C
		mov	ax, 5
		mov	cx, ds:[bp+3]
		shr	cx, 6
		mov	ds:[bp+1], cx
		mov	dx, ds:[bp+7]
		shr	dx, 6
		mov	ds:[bp+5], dx
		push	ds
		sub	cx, 20h	; ' '
		sub	dx, 10h
		mov	ds, cs:segHdf_rayoX
		sub	si, si
		call	AddHDFSpr_Mode0
		pop	ds

loc_1475C:				; CODE XREF: seg000:472Fj
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		sub	cx, 20h	; ' '
		sub	dx, 10h
		sub	ah, ah
		mov	al, ds:[bp+12h]
		call	sub_1823E
		cmp	word ptr ds:[bp+0Fh], 0
		jnz	short locret_1477F
		mov	byte ptr ds:[bp+0], 0

locret_1477F:				; CODE XREF: seg000:4778j
		retn
; ---------------------------------------------------------------------------

loc_14780:				; CODE XREF: seg000:4723j
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		call	sub_15CB6
		jnb	short loc_147D9
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		sub	ah, ah
		mov	al, ds:[bp+12h]
		call	sub_1823E
		jb	short loc_147CA
		mov	ax, ds:[bp+0Dh]
		mov	cx, ds:[bp+3]
		shr	cx, 6
		mov	ds:[bp+1], cx
		mov	dx, ds:[bp+7]
		shr	dx, 6
		mov	ds:[bp+5], dx
		push	ds
		mov	ds, cs:segHdf_rayoX
		sub	si, si
		call	AddHDFSpr_Mode0
		pop	ds
		call	sub_15D7A
		retn
; ---------------------------------------------------------------------------

loc_147CA:				; CODE XREF: seg000:479Ej
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		mov	word ptr ds:[bp+0Fh], 8
		retn
; ---------------------------------------------------------------------------

loc_147D9:				; CODE XREF: seg000:478Bj
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		mov	word ptr ds:[bp+0Fh], 8
		retn
; ---------------------------------------------------------------------------

loc_147E8:				; DATA XREF: seg000:off_145A5o
		call	sub_15D5F
		mov	ds:[bp+9], cx
		mov	ds:[bp+0Bh], dx
		mov	word ptr ds:[bp+0Dh], 11h
		mov	word ptr ds:[bp+0Fh], 0
		mov	byte ptr ds:[bp+11h], 1
		mov	byte ptr ds:[bp+12h], 1
		retn
; ---------------------------------------------------------------------------

loc_1480A:				; DATA XREF: seg000:off_145A5o
		call	sub_15D5F
		mov	ds:[bp+9], cx
		mov	ds:[bp+0Bh], dx
		mov	word ptr ds:[bp+0Dh], 10h
		mov	word ptr ds:[bp+0Fh], 4
		mov	byte ptr ds:[bp+11h], 1
		mov	byte ptr ds:[bp+12h], 1
		retn
; ---------------------------------------------------------------------------

loc_1482C:				; DATA XREF: seg000:off_145A5o
		sub	cx, 8
		sub	dx, 4
		call	sub_15D5F
		mov	ax, si
		and	ax, 0FFh
		call	sub_1BE93
		mov	ax, si
		add	ax, 8
		and	ax, 0FFh
		shr	ax, 4
		and	ax, 0Fh
		mov	ds:[bp+9], cx
		mov	ds:[bp+0Bh], dx
		mov	ds:[bp+0Dh], ax
		mov	word ptr ds:[bp+0Fh], 0
		mov	byte ptr ds:[bp+11h], 1
		mov	byte ptr ds:[bp+12h], 0Fh
		retn
; ---------------------------------------------------------------------------

loc_14868:				; DATA XREF: seg000:off_145A5o
		sub	cx, 8
		sub	dx, 4
		call	sub_15D5F
		mov	ax, si
		and	ax, 0FFh
		call	sub_1BE93
		mov	ax, si
		add	ax, 8
		and	ax, 0FFh
		shr	ax, 4
		and	ax, 0Fh
		mov	ds:[bp+9], cx
		mov	ds:[bp+0Bh], dx
		mov	ds:[bp+0Dh], ax
		mov	word ptr ds:[bp+0Fh], 0
		mov	byte ptr ds:[bp+11h], 1
		mov	byte ptr ds:[bp+12h], 12h
		retn
; ---------------------------------------------------------------------------

loc_148A4:				; DATA XREF: seg000:off_145A5o
		sub	cx, 8
		sub	dx, 4
		call	sub_15D5F
		mov	ax, si
		and	ax, 0FFh
		call	sub_1BE93
		mov	ax, si
		add	ax, 8
		and	ax, 0FFh
		shr	ax, 4
		and	ax, 0Fh
		mov	ds:[bp+9], cx
		mov	ds:[bp+0Bh], dx
		mov	ds:[bp+0Dh], ax
		mov	word ptr ds:[bp+0Fh], 0
		mov	byte ptr ds:[bp+11h], 1
		mov	byte ptr ds:[bp+12h], 14h
		retn
; ---------------------------------------------------------------------------

loc_148E0:				; DATA XREF: seg000:off_145A5o
		sub	cx, 8
		sub	dx, 4
		call	sub_15D5F
		mov	ax, si
		and	ax, 0FFh
		call	sub_1BE93
		shl	cx, 2
		shl	dx, 2
		mov	ax, si
		and	ax, 0FFh
		shr	ax, 3
		and	ax, 0Fh
		mov	ds:[bp+13h], si
		mov	ds:[bp+9], cx
		mov	ds:[bp+0Bh], dx
		mov	ds:[bp+0Dh], ax
		mov	word ptr ds:[bp+0Fh], 0
		mov	byte ptr ds:[bp+11h], 4
		mov	byte ptr ds:[bp+12h], 5
		retn
; ---------------------------------------------------------------------------

loc_14923:				; DATA XREF: seg000:off_145A5o
		sub	cx, 8
		sub	dx, 4
		call	sub_15D5F
		mov	ax, si
		and	ax, 0FFh
		call	sub_1BE93
		shl	cx, 2
		shl	dx, 2
		mov	ax, si
		and	ax, 0FFh
		shr	ax, 3
		and	ax, 0Fh
		mov	ds:[bp+13h], si
		mov	ds:[bp+9], cx
		mov	ds:[bp+0Bh], dx
		mov	ds:[bp+0Dh], ax
		mov	word ptr ds:[bp+0Fh], 0
		mov	byte ptr ds:[bp+11h], 8
		mov	byte ptr ds:[bp+12h], 3
		retn
; ---------------------------------------------------------------------------

loc_14966:				; DATA XREF: seg000:off_145A5o
		sub	cx, 8
		sub	dx, 4
		call	sub_15D5F
		mov	ax, si
		and	ax, 0FFh
		call	sub_1BE93
		shl	cx, 2
		shl	dx, 2
		mov	ax, si
		and	ax, 0FFh
		shr	ax, 3
		and	ax, 0Fh
		mov	ds:[bp+13h], si
		mov	ds:[bp+9], cx
		mov	ds:[bp+0Bh], dx
		mov	ds:[bp+0Dh], ax
		mov	word ptr ds:[bp+0Fh], 0
		mov	byte ptr ds:[bp+11h], 0Ch
		mov	byte ptr ds:[bp+12h], 2
		retn
; ---------------------------------------------------------------------------

loc_149A9:				; DATA XREF: seg000:off_145A5o
		call	sub_15D5F
		mov	ax, si
		and	ax, 0FFh
		call	sub_1BE93
		mov	ax, si
		and	ax, 0FFh
		shr	ax, 3
		and	ax, 0Fh
		mov	ds:[bp+13h], si
		mov	ds:[bp+9], cx
		mov	ds:[bp+0Bh], dx
		mov	ds:[bp+0Dh], ax
		mov	word ptr ds:[bp+0Fh], 0
		mov	byte ptr ds:[bp+11h], 1
		mov	byte ptr ds:[bp+12h], 0
		retn
; ---------------------------------------------------------------------------

loc_149E0:				; DATA XREF: seg000:off_1467Ao
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		sub	ah, ah
		mov	al, ds:[bp+12h]
		call	sub_1823E
		mov	ax, ds:[bp+0Fh]
		inc	ax
		cmp	ax, 4
		jb	short loc_14A00
		mov	byte ptr ds:[bp+0], 0

loc_14A00:				; CODE XREF: seg000:49F9j
		mov	ds:[bp+0Fh], ax
		mov	ax, ds:[bp+0Dh]
		mov	cx, ds:[bp+3]
		shr	cx, 6
		mov	ds:[bp+1], cx
		mov	dx, ds:[bp+7]
		shr	dx, 6
		mov	ds:[bp+5], dx
		mov	bx, ds:[bp+0Fh]
		mov	ah, cs:[bx+4A51h]
		push	ds
		mov	ds, cs:word_10CCD
		sub	si, si
		call	AddHDFSpr_Mode2
		pop	ds
		retn
; ---------------------------------------------------------------------------
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		mov	byte ptr ds:[bp+0], 0
		mov	ax, 1
		call	sub_15EF8
		call	sub_15E2A
		retn
; ---------------------------------------------------------------------------
		mov	byte ptr ds:[bp+0], 0
		retn
; ---------------------------------------------------------------------------
		femms
		or	ax, 10Ch

loc_14A56:				; DATA XREF: seg000:off_1467Ao
		call	sub_15C93
		call	sub_15CB6
		jb	short loc_14A61
		jmp	loc_14AE4
; ---------------------------------------------------------------------------

loc_14A61:				; CODE XREF: seg000:4A5Cj
		mov	cx, 2

loc_14A64:				; CODE XREF: seg000:4AC9j
		push	cx
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		sub	ah, ah
		mov	al, ds:[bp+12h]
		call	sub_1823E
		mov	ax, ds:[bp+9]
		add	ds:[bp+3], ax
		mov	ax, ds:[bp+0Bh]
		add	ds:[bp+7], ax
		mov	ax, ds:[bp+0Dh]
		mov	cx, ds:[bp+3]
		shr	cx, 6
		mov	ds:[bp+1], cx
		mov	dx, ds:[bp+7]
		shr	dx, 6
		mov	ds:[bp+5], dx
		push	bp
		push	ds
		mov	ds, cs:word_10CCD
		sub	si, si
		mov	ah, 0Fh
		call	AddHDFSpr_Mode2
		pop	ds
		pop	bp
		mov	si, ds:[bp+13h]
		mov	cx, ds:[bp+3]
		shr	cx, 6
		mov	dx, ds:[bp+7]
		shr	dx, 6
		mov	ax, 1Eh
		call	sub_14567
		pop	cx
		loop	loc_14A64
		retn
; ---------------------------------------------------------------------------
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		mov	byte ptr ds:[bp+0], 0
		mov	ax, 1
		call	sub_15EF8
		call	sub_15E2A
		pop	cx
		retn
; ---------------------------------------------------------------------------

loc_14AE4:				; CODE XREF: seg000:4A5Ej
		mov	byte ptr ds:[bp+0], 0
		retn
; ---------------------------------------------------------------------------

loc_14AEA:				; DATA XREF: seg000:off_1467Ao
		call	sub_15C93
		call	sub_15CB6
		jb	short loc_14AF5
		jmp	loc_14B78
; ---------------------------------------------------------------------------

loc_14AF5:				; CODE XREF: seg000:4AF0j
		mov	cx, 2

loc_14AF8:				; CODE XREF: seg000:4B5Dj
		push	cx
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		sub	ah, ah
		mov	al, ds:[bp+12h]
		call	sub_1823E
		mov	ax, ds:[bp+9]
		add	ds:[bp+3], ax
		mov	ax, ds:[bp+0Bh]
		add	ds:[bp+7], ax
		mov	ax, ds:[bp+0Dh]
		mov	cx, ds:[bp+3]
		shr	cx, 6
		mov	ds:[bp+1], cx
		mov	dx, ds:[bp+7]
		shr	dx, 6
		mov	ds:[bp+5], dx
		push	bp
		push	ds
		mov	ds, cs:word_10CCD
		sub	si, si
		mov	ah, 0Fh
		call	AddHDFSpr_Mode2
		pop	ds
		pop	bp
		mov	si, ds:[bp+13h]
		mov	cx, ds:[bp+3]
		shr	cx, 6
		mov	dx, ds:[bp+7]
		shr	dx, 6
		mov	ax, 1Eh
		call	sub_14567
		pop	cx
		loop	loc_14AF8
		retn
; ---------------------------------------------------------------------------
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		mov	byte ptr ds:[bp+0], 0
		mov	ax, 1
		call	sub_15EF8
		call	sub_15E2A
		pop	cx
		retn
; ---------------------------------------------------------------------------

loc_14B78:				; CODE XREF: seg000:4AF2j
		mov	byte ptr ds:[bp+0], 0
		retn
; ---------------------------------------------------------------------------

loc_14B7E:				; DATA XREF: seg000:off_145A5o
		sub	cx, 8
		sub	dx, 4
		call	sub_15D5F
		mov	ax, si
		and	ax, 0FFh
		call	sub_1BE93
		mov	ax, si
		add	ax, 8
		and	ax, 0FFh
		shr	ax, 4
		mov	ds:[bp+9], cx
		mov	ds:[bp+0Bh], dx
		mov	word ptr ds:[bp+0Dh], 0
		mov	word ptr ds:[bp+0Fh], 0
		mov	byte ptr ds:[bp+11h], 1
		mov	byte ptr ds:[bp+12h], 1
		retn
; ---------------------------------------------------------------------------

loc_14BB9:				; DATA XREF: seg000:off_145A5o
		sub	cx, 8
		sub	dx, 4
		call	sub_15D5F
		mov	ax, si
		and	ax, 0FFh
		call	sub_1BE93
		shl	cx, 1
		shl	dx, 1
		mov	ax, si
		add	ax, 8
		and	ax, 0FFh
		shr	ax, 4
		mov	ds:[bp+9], cx
		mov	ds:[bp+0Bh], dx
		mov	word ptr ds:[bp+0Dh], 0
		mov	word ptr ds:[bp+0Fh], 0
		mov	byte ptr ds:[bp+11h], 1
		mov	byte ptr ds:[bp+12h], 1
		retn
; ---------------------------------------------------------------------------

loc_14BF8:				; DATA XREF: seg000:off_145A5o
		sub	cx, 8
		sub	dx, 4
		call	sub_15D5F
		mov	ax, si
		and	ax, 0FFh
		call	sub_1BE93
		shl	cx, 2
		shl	dx, 2
		mov	ax, si
		add	ax, 8
		and	ax, 0FFh
		shr	ax, 4
		mov	ds:[bp+9], cx
		mov	ds:[bp+0Bh], dx
		mov	word ptr ds:[bp+0Dh], 0
		mov	word ptr ds:[bp+0Fh], 0
		mov	byte ptr ds:[bp+11h], 1
		mov	byte ptr ds:[bp+12h], 1
		retn
; ---------------------------------------------------------------------------

loc_14C39:				; DATA XREF: seg000:off_1467Ao
		call	sub_15C93
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		sub	ah, ah
		mov	al, ds:[bp+12h]
		call	sub_1823E
		call	sub_15D7A
		mov	ax, ds:[bp+0Fh]
		inc	ax
		cmp	ax, 0Ah
		jb	short loc_14C62
		mov	ax, 0Ah
		mov	byte ptr ds:[bp+0], 0

loc_14C62:				; CODE XREF: seg000:4C58j
		mov	ds:[bp+0Fh], ax
		mov	ax, ds:[bp+0Fh]
		shr	ax, 1
		add	ax, ds:[bp+0Dh]
		mov	cx, ds:[bp+3]
		shr	cx, 6
		mov	ds:[bp+1], cx
		mov	dx, ds:[bp+7]
		shr	dx, 6
		mov	ds:[bp+5], dx
		push	ds
		mov	ds, cs:word_10CCD
		sub	si, si
		call	AddHDFSpr_Mode0
		pop	ds
		retn
; ---------------------------------------------------------------------------
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		mov	byte ptr ds:[bp+0], 0
		mov	ax, 1
		call	sub_15EF8
		call	sub_15E2A
		retn
; ---------------------------------------------------------------------------
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		mov	byte ptr ds:[bp+0], 0
		mov	ax, 1
		call	sub_14567
		retn
; ---------------------------------------------------------------------------

loc_14CBE:				; DATA XREF: seg000:off_145A5o
		sub	cx, 8
		sub	dx, 4
		call	sub_15D5F
		mov	word ptr ds:[bp+9], 0
		mov	word ptr ds:[bp+0Bh], 0
		mov	word ptr ds:[bp+0Dh], 8
		mov	word ptr ds:[bp+0Fh], 0
		mov	byte ptr ds:[bp+11h], 1
		mov	byte ptr ds:[bp+12h], 9
		retn
; ---------------------------------------------------------------------------

loc_14CEA:				; DATA XREF: seg000:off_1467Ao
		call	sub_15C7C
		call	sub_15C93
		mov	ax, ds:[bp+0Dh]
		add	ax, ds:[bp+0Fh]
		mov	cx, ds:[bp+3]
		shr	cx, 6
		mov	ds:[bp+1], cx
		mov	dx, ds:[bp+7]
		shr	dx, 6
		mov	ds:[bp+5], dx
		push	ds
		mov	ds, cs:segHdf_missle
		sub	si, si
		call	AddHDFSpr_Mode1
		pop	ds
		mov	ax, ds:[bp+0Fh]
		inc	ax
		cmp	ax, 2
		jb	short loc_14D2C
		mov	ax, 2
		mov	byte ptr ds:[bp+0], 0

loc_14D2C:				; CODE XREF: seg000:4D22j
		mov	ds:[bp+0Fh], ax
		retn
; ---------------------------------------------------------------------------

loc_14D31:				; DATA XREF: seg000:off_145A5o
		sub	cx, 8
		sub	dx, 4
		call	sub_15D5F
		mov	ax, 0
		test	si, 8000h
		jz	short loc_14D46
		mov	ax, 4

loc_14D46:				; CODE XREF: seg000:4D41j
		mov	ds:[bp+9], si
		mov	ds:[bp+0Bh], di
		mov	ds:[bp+0Dh], ax
		mov	word ptr ds:[bp+0Fh], 0
		mov	byte ptr ds:[bp+11h], 1
		mov	byte ptr ds:[bp+12h], 5
		retn
; ---------------------------------------------------------------------------

loc_14D63:				; DATA XREF: seg000:off_145A5o
		sub	cx, 8
		sub	dx, 4
		call	sub_15D5F
		mov	ds:[bp+9], si
		mov	ds:[bp+0Bh], di
		mov	word ptr ds:[bp+0Dh], 0
		mov	word ptr ds:[bp+0Fh], 0
		mov	byte ptr ds:[bp+11h], 1
		mov	byte ptr ds:[bp+12h], 0Ah
		mov	word ptr ds:[bp+13h], 4
		retn
; ---------------------------------------------------------------------------

loc_14D91:				; DATA XREF: seg000:off_145A5o
		sub	cx, 8
		sub	dx, 4
		call	sub_15D5F
		mov	word ptr ds:[bp+9], 0
		mov	word ptr ds:[bp+0Bh], 0
		mov	word ptr ds:[bp+0Dh], 8
		mov	word ptr ds:[bp+0Fh], 0
		mov	byte ptr ds:[bp+11h], 1
		mov	byte ptr ds:[bp+12h], 5
		mov	word ptr ds:[bp+13h], 4
		retn
; ---------------------------------------------------------------------------

loc_14DC3:				; DATA XREF: seg000:off_1467Ao
		call	sub_15C7C
		call	sub_15C93
		call	sub_15CB6
		jb	short loc_14DD1
		jmp	loc_14E56
; ---------------------------------------------------------------------------

loc_14DD1:				; CODE XREF: seg000:4DCCj
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		sub	ah, ah
		mov	al, ds:[bp+12h]
		call	sub_1823E
		jb	short loc_14E42
		call	sub_15D7A
		mov	ax, ds:[bp+0Dh]
		test	word ptr ds:[bp+0Bh], 8000h
		jnz	short loc_14E00
		cmp	word ptr ds:[bp+0Bh], 128h
		jb	short loc_14E0D
		add	ax, 3
		jmp	short loc_14E10
; ---------------------------------------------------------------------------

loc_14E00:				; CODE XREF: seg000:4DF1j
		inc	word ptr ds:[bp+0Fh]
		mov	bx, ds:[bp+0Fh]
		and	bx, 1
		jmp	short loc_14E10
; ---------------------------------------------------------------------------

loc_14E0D:				; CODE XREF: seg000:4DF9j
		add	ax, 2

loc_14E10:				; CODE XREF: seg000:4DFEj seg000:4E0Bj
		add	ax, bx
		mov	cx, ds:[bp+3]
		shr	cx, 6
		mov	ds:[bp+1], cx

loc_14E1D:
		mov	dx, ds:[bp+7]
		shr	dx, 6
		mov	ds:[bp+5], dx
		push	ds
		mov	ds, cs:segHdf_missle
		sub	si, si
		call	AddHDFSpr_Mode0
		pop	ds
		cmp	cs:word_12FA9, 1
		jz	short locret_14E41
		add	word ptr ds:[bp+0Bh], 40h ; '@'

locret_14E41:				; CODE XREF: seg000:4E3Aj
		retn
; ---------------------------------------------------------------------------

loc_14E42:				; CODE XREF: seg000:4DE2j
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		mov	byte ptr ds:[bp+0], 0
		mov	ax, 16h
		call	sub_14567
		retn
; ---------------------------------------------------------------------------

loc_14E56:				; CODE XREF: seg000:4DCEj
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		mov	byte ptr ds:[bp+0], 0
		mov	ax, 16h
		call	sub_14567
		retn
; ---------------------------------------------------------------------------

loc_14E6A:				; DATA XREF: seg000:off_1467Ao
		call	sub_15C7C
		call	sub_15C93
		call	sub_15CB6
		jnb	short loc_14EED
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		sub	ah, ah
		mov	al, ds:[bp+12h]
		call	sub_1823E
		jb	short loc_14ED8

loc_14E88:				; CODE XREF: seg000:4EEBj seg000:4F0Cj ...
		call	sub_15D7A
		cmp	word ptr ds:[bp+13h], 0
		jz	short loc_14E96
		inc	word ptr ds:[bp+0Fh]

loc_14E96:				; CODE XREF: seg000:4E90j
		inc	word ptr ds:[bp+0Dh]
		cmp	word ptr ds:[bp+0Dh], 48h ; 'H'
		jnb	short loc_14ED8
		mov	ax, ds:[bp+0Fh]
		and	ax, 7
		mov	cx, ds:[bp+3]
		shr	cx, 6
		mov	ds:[bp+1], cx
		mov	dx, ds:[bp+7]
		shr	dx, 6
		mov	ds:[bp+5], dx
		push	ds
		mov	ds, cs:segHdf_missle
		sub	si, si
		call	AddHDFSpr_Mode0
		pop	ds
		cmp	cs:word_12FA9, 1
		jz	short locret_14ED7
		add	word ptr ds:[bp+0Bh], 40h ; '@'

locret_14ED7:				; CODE XREF: seg000:4ED0j
		retn
; ---------------------------------------------------------------------------

loc_14ED8:				; CODE XREF: seg000:4E86j seg000:4E9Fj
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		mov	byte ptr ds:[bp+0], 0
		mov	ax, 20h	; ' '
		call	sub_14567
		jmp	short loc_14E88
; ---------------------------------------------------------------------------

loc_14EED:				; CODE XREF: seg000:4E73j
		mov	ax, ds:[bp+0Bh]
		neg	ax
		sar	ax, 1
		mov	ds:[bp+0Bh], ax
		add	ds:[bp+7], ax
		sar	word ptr ds:[bp+9], 1
		dec	word ptr ds:[bp+13h]
		cmp	word ptr ds:[bp+13h], 0
		jz	short loc_14F0F
		jmp	loc_14E88
; ---------------------------------------------------------------------------

loc_14F0F:				; CODE XREF: seg000:4F0Aj
		mov	word ptr ds:[bp+9], 0
		jmp	loc_14E88
; ---------------------------------------------------------------------------

loc_14F18:				; DATA XREF: seg000:off_1467Ao
		call	sub_15C7C
		call	sub_15C93
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		sub	ah, ah
		mov	al, ds:[bp+12h]
		call	sub_1823E
		inc	word ptr ds:[bp+0Fh]
		cmp	word ptr ds:[bp+0Fh], 10h
		jnb	short loc_14F68
		test	word ptr ds:[bp+0Fh], 1
		jz	short locret_14F67
		mov	ax, 8
		mov	cx, ds:[bp+3]
		shr	cx, 6
		mov	ds:[bp+1], cx
		mov	dx, ds:[bp+7]
		shr	dx, 6
		mov	ds:[bp+5], dx
		push	ds
		mov	ds, cs:segHdf_missle
		sub	si, si
		call	AddHDFSpr_Mode0
		pop	ds

locret_14F67:				; CODE XREF: seg000:4F40j seg000:4F6Dj
		retn
; ---------------------------------------------------------------------------

loc_14F68:				; CODE XREF: seg000:4F38j
		mov	byte ptr ds:[bp+0], 0
		jmp	short locret_14F67
; ---------------------------------------------------------------------------

loc_14F6F:				; DATA XREF: seg000:off_145A5o
		sub	cx, 8
		sub	dx, 4
		call	sub_15D5F
		mov	ds:[bp+9], si
		mov	ds:[bp+0Bh], di
		mov	word ptr ds:[bp+0Dh], 0
		mov	word ptr ds:[bp+0Fh], 0
		mov	byte ptr ds:[bp+11h], 1
		mov	byte ptr ds:[bp+12h], 2
		retn
; ---------------------------------------------------------------------------

loc_14F97:				; DATA XREF: seg000:off_1467Ao
		call	sub_15C93
		call	sub_15C7C
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		call	sub_15CB6
		jnb	short loc_15006
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		sub	ah, ah
		mov	al, ds:[bp+12h]
		call	sub_1823E
		jb	short loc_14FF8
		inc	word ptr ds:[bp+0Fh]
		inc	word ptr ds:[bp+0Fh]
		and	word ptr ds:[bp+0Fh], 7
		mov	ax, ds:[bp+0Dh]
		add	ax, ds:[bp+0Fh]
		mov	cx, ds:[bp+3]
		shr	cx, 6
		mov	ds:[bp+1], cx
		mov	dx, ds:[bp+7]
		shr	dx, 6
		mov	ds:[bp+5], dx
		push	ds
		mov	ds, cs:segHdf_missle
		sub	si, si
		call	AddHDFSpr_Mode0
		pop	ds
		call	sub_15D7A
		retn
; ---------------------------------------------------------------------------

loc_14FF8:				; CODE XREF: seg000:4FBBj
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		mov	byte ptr ds:[bp+0], 0
		retn
; ---------------------------------------------------------------------------

loc_15006:				; CODE XREF: seg000:4FA8j
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		mov	byte ptr ds:[bp+0], 0
		retn
; ---------------------------------------------------------------------------

loc_15014:				; DATA XREF: seg000:off_145A5o
		sub	cx, 8
		sub	dx, 4
		call	sub_15D5F
		mov	word ptr ds:[bp+9], 0
		mov	word ptr ds:[bp+0Bh], 0
		mov	word ptr ds:[bp+0Dh], 0Bh
		mov	word ptr ds:[bp+0Fh], 0
		mov	byte ptr ds:[bp+11h], 1
		mov	byte ptr ds:[bp+12h], 1
		retn
; ---------------------------------------------------------------------------

loc_15040:				; DATA XREF: seg000:off_1467Ao
		call	sub_15C93
		call	sub_15C7C
		mov	ax, ds:[bp+0Fh]
		inc	ax
		cmp	ax, 0Ah
		jb	short loc_15055
		mov	byte ptr ds:[bp+0], 0

loc_15055:				; CODE XREF: seg000:504Ej
		mov	ds:[bp+0Fh], ax
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		sub	ah, ah
		mov	al, ds:[bp+12h]
		call	sub_1823E
		mov	cx, ds:[bp+1]
		add	cx, 20h	; ' '
		mov	dx, ds:[bp+5]
		sub	ah, ah
		mov	al, ds:[bp+12h]
		call	sub_1823E
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		add	dx, 10h
		sub	ah, ah
		mov	al, ds:[bp+12h]
		call	sub_1823E
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		add	cx, 20h	; ' '
		add	dx, 10h
		sub	ah, ah
		mov	al, ds:[bp+12h]
		call	sub_1823E
		mov	ax, ds:[bp+9]
		add	ds:[bp+3], ax
		mov	ax, ds:[bp+0Bh]
		add	ds:[bp+7], ax
		mov	ax, ds:[bp+9]
		sar	ax, 3
		add	ds:[bp+9], ax
		mov	ax, ds:[bp+0Bh]
		sar	ax, 3
		add	ds:[bp+0Bh], ax
		test	word ptr ds:[bp+0Fh], 1
		jz	short locret_15103
		mov	ax, ds:[bp+0Dh]
		mov	cx, ds:[bp+3]
		shr	cx, 6
		mov	ds:[bp+1], cx
		mov	dx, ds:[bp+7]
		shr	dx, 6
		mov	ds:[bp+5], dx
		mov	bx, ds:[bp+0Fh]
		push	ds
		mov	ds, cs:segHdf_missle
		sub	si, si
		mov	ah, bl
		call	AddHDFSpr_Mode2
		pop	ds

locret_15103:				; CODE XREF: seg000:50D5j
		retn
; ---------------------------------------------------------------------------
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		mov	byte ptr ds:[bp+0], 0
		mov	ax, 16h
		call	sub_14567
		retn
; ---------------------------------------------------------------------------

loc_15118:				; DATA XREF: seg000:off_1467Ao
		call	sub_15C93
		call	sub_15C7C
		call	sub_15CB6
		jb	short loc_15126
		jmp	loc_151BA
; ---------------------------------------------------------------------------

loc_15126:				; CODE XREF: seg000:5121j
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		sub	ah, ah
		mov	al, ds:[bp+12h]
		call	sub_1823E
		jb	short loc_1519D
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		add	dx, 8
		sub	ah, ah
		mov	al, ds:[bp+12h]
		call	sub_1823E
		jb	short loc_1519D
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		mov	ax, 8
		call	sub_15EF8
		call	sub_15D7A
		mov	ax, ds:[bp+9]
		sar	ax, 3
		add	ds:[bp+9], ax
		mov	ax, ds:[bp+0Bh]
		sar	ax, 3
		add	ds:[bp+0Bh], ax
		mov	ax, ds:[bp+0Dh]
		mov	cx, ds:[bp+3]
		shr	cx, 6
		mov	ds:[bp+1], cx
		mov	dx, ds:[bp+7]
		shr	dx, 6
		mov	ds:[bp+5], dx
		push	ds
		mov	ds, cs:word_10CCD
		sub	si, si
		call	AddHDFSpr_Mode0
		pop	ds
		retn
; ---------------------------------------------------------------------------

loc_1519D:				; CODE XREF: seg000:5137j seg000:514Dj
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		mov	byte ptr ds:[bp+0], 0
		mov	ax, 1
		call	sub_15EF8
		push	es
		push	ds
		pusha
		call	sub_15E2A
		popa
		pop	ds
		pop	es
		retn
; ---------------------------------------------------------------------------

loc_151BA:				; CODE XREF: seg000:5123j
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		mov	byte ptr ds:[bp+0], 0
		mov	ax, 1
		call	sub_14567
		retn
; ---------------------------------------------------------------------------

loc_151CE:				; DATA XREF: seg000:off_145A5o
		call	sub_15D5F
		mov	ax, si
		and	ax, 0FFh
		call	sub_1BE93
		shl	cx, 2
		shl	dx, 2
		mov	word ptr ds:[bp+15h], 0FFFFh
		mov	word ptr ds:[bp+13h], 1
		mov	ds:[bp+9], cx
		mov	ds:[bp+0Bh], dx
		mov	word ptr ds:[bp+0Dh], 0
		mov	word ptr ds:[bp+0Fh], 0
		mov	byte ptr ds:[bp+11h], 1
		mov	byte ptr ds:[bp+12h], 1
		retn
; ---------------------------------------------------------------------------

loc_1520A:				; DATA XREF: seg000:off_145A5o
		call	sub_15D5F
		mov	ax, si
		and	ax, 0FFh
		call	sub_1BE93
		shl	cx, 2
		shl	dx, 2
		mov	word ptr ds:[bp+13h], 2
		mov	ds:[bp+9], cx
		mov	ds:[bp+0Bh], dx
		mov	word ptr ds:[bp+0Dh], 1
		mov	word ptr ds:[bp+0Fh], 0
		mov	byte ptr ds:[bp+11h], 1
		mov	byte ptr ds:[bp+12h], 1
		retn
; ---------------------------------------------------------------------------

loc_15240:				; DATA XREF: seg000:off_145A5o
		call	sub_15D5F
		mov	ax, si
		and	ax, 0FFh
		call	sub_1BE93
		shl	cx, 2
		shl	dx, 2
		mov	word ptr ds:[bp+13h], 3
		mov	ds:[bp+9], cx
		mov	ds:[bp+0Bh], dx
		mov	word ptr ds:[bp+0Dh], 2
		mov	word ptr ds:[bp+0Fh], 0
		mov	byte ptr ds:[bp+11h], 1
		mov	byte ptr ds:[bp+12h], 2
		retn
; ---------------------------------------------------------------------------

loc_15276:				; DATA XREF: seg000:off_145A5o
		call	sub_15D5F
		mov	ax, si
		and	ax, 0FFh
		call	sub_1BE93
		shl	cx, 2
		shl	dx, 2
		mov	word ptr ds:[bp+13h], 4
		mov	ds:[bp+9], cx
		mov	ds:[bp+0Bh], dx
		mov	word ptr ds:[bp+0Dh], 3
		mov	word ptr ds:[bp+0Fh], 0
		mov	byte ptr ds:[bp+11h], 1
		mov	byte ptr ds:[bp+12h], 3
		retn
; ---------------------------------------------------------------------------

loc_152AC:				; DATA XREF: seg000:off_145A5o
		call	sub_15D5F
		mov	ax, si
		and	ax, 0FFh
		call	sub_1BE93
		shl	cx, 2
		shl	dx, 2
		mov	word ptr ds:[bp+13h], 5
		mov	ds:[bp+9], cx
		mov	ds:[bp+0Bh], dx
		mov	word ptr ds:[bp+0Dh], 4
		mov	word ptr ds:[bp+0Fh], 0
		mov	byte ptr ds:[bp+11h], 1
		mov	byte ptr ds:[bp+12h], 4
		retn
; ---------------------------------------------------------------------------

loc_152E2:				; DATA XREF: seg000:off_145A5o
		call	sub_15D5F
		mov	si, cs:word_1EA52
		mov	di, cs:word_1EA56
		call	sub_1BE3A
		shl	cx, 1
		shl	dx, 1
		mov	ds:[bp+9], cx
		mov	ds:[bp+0Bh], dx
		mov	word ptr ds:[bp+0Dh], 0
		mov	word ptr ds:[bp+0Fh], 4
		mov	byte ptr ds:[bp+11h], 1
		mov	byte ptr ds:[bp+12h], 5
		retn
; ---------------------------------------------------------------------------

loc_15315:				; DATA XREF: seg000:off_1467Ao
		call	sub_15C7C
		call	sub_15C93
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		add	dx, 8
		call	sub_1A6B7
		cmp	ax, cs:word_1BE30
		jb	short loc_15333
		jmp	loc_153DC
; ---------------------------------------------------------------------------

loc_15333:				; CODE XREF: seg000:532Ej
		sub	dx, 8
		call	sub_1A6B7
		cmp	ax, cs:word_1BE30
		jb	short loc_15343
		jmp	loc_153DC
; ---------------------------------------------------------------------------

loc_15343:				; CODE XREF: seg000:533Ej
		sub	cx, 10h
		call	sub_1A6B7
		cmp	ax, cs:word_1BE30
		jb	short loc_15353
		jmp	loc_153E8
; ---------------------------------------------------------------------------

loc_15353:				; CODE XREF: seg000:534Ej
		add	cx, 20h	; ' '
		add	dx, 8
		call	sub_1A6B7
		cmp	ax, cs:word_1BE30
		jb	short loc_15366
		jmp	loc_153E8
; ---------------------------------------------------------------------------

loc_15366:				; CODE XREF: seg000:5361j
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		sub	ah, ah
		mov	al, ds:[bp+12h]
		call	sub_1823E
		jb	short loc_153A3

loc_15379:				; CODE XREF: seg000:53E6j seg000:53F2j
		call	sub_15D7A
		mov	ax, ds:[bp+0Dh]
		mov	cx, ds:[bp+3]
		shr	cx, 6
		mov	ds:[bp+1], cx
		mov	dx, ds:[bp+7]
		shr	dx, 6
		mov	ds:[bp+5], dx
		push	ds
		mov	ds, cs:word_10CCD
		sub	si, si
		call	AddHDFSpr_Mode1
		pop	ds
		retn
; ---------------------------------------------------------------------------

loc_153A3:				; CODE XREF: seg000:5377j
					; seg000:loc_153C6j
		mov	cx, 2

loc_153A6:				; CODE XREF: seg000:53C3j
		push	cx
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		mov	byte ptr ds:[bp+0], 0
		mov	ax, 0Ah
		mov	si, ds:[bp+9]
		mov	di, ds:[bp+0Bh]
		call	sub_15EF8
		pop	cx
		loop	loc_153A6
		retn
; ---------------------------------------------------------------------------

loc_153C6:				; CODE XREF: seg000:53E0j seg000:53ECj
		jmp	short loc_153A3
; ---------------------------------------------------------------------------
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		mov	byte ptr ds:[bp+0], 0
		mov	ax, 6
		call	sub_14567
		retn
; ---------------------------------------------------------------------------

loc_153DC:				; CODE XREF: seg000:5330j seg000:5340j
		dec	word ptr ds:[bp+13h]
		jz	short loc_153C6
		neg	word ptr ds:[bp+0Bh]
		jmp	short loc_15379
; ---------------------------------------------------------------------------

loc_153E8:				; CODE XREF: seg000:5350j seg000:5363j
		dec	word ptr ds:[bp+13h]
		jz	short loc_153C6
		neg	word ptr ds:[bp+9]
		jmp	short loc_15379
; ---------------------------------------------------------------------------

loc_153F4:				; CODE XREF: seg000:5407j
		call	sub_15CED
		mov	bx, ds:[bp+15h]
		cmp	word ptr [bx+2], 0
		jnz	short loc_15409
		mov	word ptr ds:[bp+15h], 0FFFFh
		jmp	short loc_153F4
; ---------------------------------------------------------------------------

loc_15409:				; CODE XREF: seg000:53FFj
		mov	ax, ds:[bp+1]
		mov	dx, [bx+4]
		mov	cx, [bx+42h]
		shr	cx, 1
		add	dx, cx
		cmp	dx, ax
		jnb	short loc_15423
		sub	word ptr ds:[bp+9], 80h	; 'Ä'
		jmp	short loc_15429
; ---------------------------------------------------------------------------

loc_15423:				; CODE XREF: seg000:5419j
		add	word ptr ds:[bp+9], 80h	; 'Ä'

loc_15429:				; CODE XREF: seg000:5421j
		mov	ax, ds:[bp+5]
		mov	dx, [bx+6]
		mov	cx, [bx+46h]
		shr	cx, 1
		add	dx, cx
		cmp	dx, ax
		jnb	short loc_15442
		sub	word ptr ds:[bp+0Bh], 40h ; '@'
		jmp	short loc_15447
; ---------------------------------------------------------------------------

loc_15442:				; CODE XREF: seg000:5439j
		add	word ptr ds:[bp+0Bh], 40h ; '@'

loc_15447:				; CODE XREF: seg000:5440j
		call	sub_15C7C
		call	sub_15C93
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		add	dx, 8
		call	sub_1A6B7
		cmp	ax, cs:word_1BE30
		jb	short loc_15465
		jmp	loc_15561
; ---------------------------------------------------------------------------

loc_15465:				; CODE XREF: seg000:5460j
		sub	dx, 8
		call	sub_1A6B7
		cmp	ax, cs:word_1BE30
		jb	short loc_15475
		jmp	loc_15561
; ---------------------------------------------------------------------------

loc_15475:				; CODE XREF: seg000:5470j
		sub	cx, 10h
		call	sub_1A6B7
		cmp	ax, cs:word_1BE30
		jb	short loc_15485
		jmp	loc_1556E
; ---------------------------------------------------------------------------

loc_15485:				; CODE XREF: seg000:5480j
		add	cx, 20h	; ' '
		add	dx, 8
		call	sub_1A6B7
		cmp	ax, cs:word_1BE30
		jb	short loc_15498
		jmp	loc_1556E
; ---------------------------------------------------------------------------

loc_15498:				; CODE XREF: seg000:5493j
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		sub	ah, ah
		mov	al, ds:[bp+12h]
		call	sub_1823E
		jb	short loc_15528

loc_154AB:				; CODE XREF: seg000:556Bj seg000:5578j
		mov	ax, ds:[bp+9]
		test	ah, 80h
		jnz	short loc_154C2
		cmp	ax, 0BE8h
		jb	short loc_154D2
		mov	ax, 0BE6h
		mov	ds:[bp+9], ax
		jmp	short loc_154D2
; ---------------------------------------------------------------------------

loc_154C2:				; CODE XREF: seg000:54B2j
		neg	ax
		cmp	ax, 0BE8h
		jb	short loc_154CC
		mov	ax, 0BE6h

loc_154CC:				; CODE XREF: seg000:54C7j
		neg	ax
		mov	ds:[bp+9], ax

loc_154D2:				; CODE XREF: seg000:54B7j seg000:54C0j
		add	ds:[bp+3], ax
		mov	ax, ds:[bp+0Bh]
		test	ah, 80h
		jnz	short loc_154ED
		cmp	ax, 590h
		jb	short loc_154FD
		mov	ax, 58Eh
		mov	ds:[bp+0Bh], ax
		jmp	short loc_154FD
; ---------------------------------------------------------------------------

loc_154ED:				; CODE XREF: seg000:54DDj
		neg	ax
		cmp	ax, 590h
		jb	short loc_154F7
		mov	ax, 58Eh

loc_154F7:				; CODE XREF: seg000:54F2j
		neg	ax
		mov	ds:[bp+0Bh], ax

loc_154FD:				; CODE XREF: seg000:54E2j seg000:54EBj
		add	ds:[bp+7], ax
		mov	ax, ds:[bp+0Dh]
		mov	cx, ds:[bp+3]
		shr	cx, 6
		mov	ds:[bp+1], cx
		mov	dx, ds:[bp+7]
		shr	dx, 6
		mov	ds:[bp+5], dx
		push	ds
		mov	ds, cs:word_10CCD
		sub	si, si
		call	AddHDFSpr_Mode1
		pop	ds
		retn
; ---------------------------------------------------------------------------

loc_15528:				; CODE XREF: seg000:54A9j
					; seg000:loc_1554Bj
		mov	cx, 2

loc_1552B:				; CODE XREF: seg000:5548j
		push	cx
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		mov	byte ptr ds:[bp+0], 0
		mov	ax, 0Ah
		mov	si, ds:[bp+9]
		mov	di, ds:[bp+0Bh]
		call	sub_15EF8
		pop	cx
		loop	loc_1552B
		retn
; ---------------------------------------------------------------------------

loc_1554B:				; CODE XREF: seg000:5565j seg000:5572j
		jmp	short loc_15528
; ---------------------------------------------------------------------------
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		mov	byte ptr ds:[bp+0], 0
		mov	ax, 6
		call	sub_14567
		retn
; ---------------------------------------------------------------------------

loc_15561:				; CODE XREF: seg000:5462j seg000:5472j
		dec	word ptr ds:[bp+13h]
		jz	short loc_1554B
		neg	word ptr ds:[bp+0Bh]
		jmp	loc_154AB
; ---------------------------------------------------------------------------

loc_1556E:				; CODE XREF: seg000:5482j seg000:5495j
		dec	word ptr ds:[bp+13h]
		jz	short loc_1554B
		neg	word ptr ds:[bp+9]
		jmp	loc_154AB
; ---------------------------------------------------------------------------

loc_1557B:				; DATA XREF: seg000:off_1467Ao
		call	sub_15C7C
		call	sub_15C93
		mov	cx, ds:[bp+1]

loc_15585:
		mov	dx, ds:[bp+5]
		call	sub_15D7A
		mov	ax, ds:[bp+0Fh]
		dec	ax
		cmp	ax, 0
		jnz	short loc_1559B
		mov	byte ptr ds:[bp+0], 0

loc_1559B:				; CODE XREF: seg000:5594j
		mov	ds:[bp+0Fh], ax
		mov	ax, ds:[bp+0Dh]
		add	ax, ds:[bp+0Fh]
		mov	cx, ds:[bp+3]
		shr	cx, 6
		mov	ds:[bp+1], cx
		mov	dx, ds:[bp+7]
		shr	dx, 6
		mov	ds:[bp+5], dx
		push	ds
		mov	ds, cs:word_10CCD
		sub	si, si
		mov	ah, 0Fh
		call	AddHDFSpr_Mode2
		pop	ds
		retn
; ---------------------------------------------------------------------------

loc_155CC:				; DATA XREF: seg000:off_145A5o
		push	cx
		push	dx
		mov	ds:[bp+1], cx
		mov	ds:[bp+5], dx
		pop	dx
		pop	cx
		mov	ds:[bp+9], si
		mov	ds:[bp+0Bh], di
		mov	word ptr ds:[bp+0Fh], 0
		mov	word ptr ds:[bp+0Dh], 0
		retn
; ---------------------------------------------------------------------------

loc_155ED:				; DATA XREF: seg000:off_145A5o
		push	cx
		push	dx
		mov	ds:[bp+1], cx
		mov	ds:[bp+5], dx
		pop	dx
		pop	cx
		mov	ds:[bp+9], si
		mov	ds:[bp+0Bh], di
		mov	word ptr ds:[bp+0Fh], 0
		mov	word ptr ds:[bp+0Dh], 0
		retn
; ---------------------------------------------------------------------------

loc_1560E:				; DATA XREF: seg000:off_145A5o
		call	sub_15D5F
		mov	word ptr ds:[bp+0Dh], 22h ; '"'
		mov	word ptr ds:[bp+0Fh], 0
		retn
; ---------------------------------------------------------------------------

loc_1561E:				; DATA XREF: seg000:off_145A5o
		call	sub_15D5F
		mov	word ptr ds:[bp+0Dh], 25h ; '%'
		mov	word ptr ds:[bp+0Fh], 0
		retn
; ---------------------------------------------------------------------------

loc_1562E:				; DATA XREF: seg000:off_145A5o
		push	cx
		push	dx
		sub	cx, 8
		sub	dx, 4
		mov	ds:[bp+1], cx
		shl	cx, 6
		mov	ds:[bp+3], cx
		mov	ds:[bp+5], dx
		shl	dx, 6
		mov	ds:[bp+7], dx
		pop	dx
		pop	cx
		mov	word ptr ds:[bp+0Dh], 33h ; '3'
		mov	word ptr ds:[bp+0Fh], 0
		retn
; ---------------------------------------------------------------------------

loc_1565B:				; DATA XREF: seg000:off_145A5o
		sub	cx, 18h
		sub	dx, 8
		mov	ds:[bp+1], cx
		mov	ds:[bp+5], dx
		mov	word ptr ds:[bp+0Dh], 0
		mov	word ptr ds:[bp+0Fh], 0
		mov	byte ptr ds:[bp+11h], 64h ; 'd'
		retn
; ---------------------------------------------------------------------------

loc_1567B:				; DATA XREF: seg000:off_145A5o
		call	sub_15D5F
		mov	word ptr ds:[bp+13h], 0
		mov	word ptr ds:[bp+15h], 0FFFFh
		mov	si, 0F0h ; ''
		mov	ax, si
		call	sub_1BE6D
		shl	cx, 2
		shl	dx, 2
		mov	bx, si
		sar	bx, 4
		cmp	bx, 17h
		shl	bx, 1
		mov	ax, cs:[bx+56F5h]
		mov	word ptr ds:[bp+9], 0FE00h
		cmp	cs:word_1EA5C, 0
		jnz	short loc_156B9
		neg	word ptr ds:[bp+9]

loc_156B9:				; CODE XREF: seg000:56B3j
		mov	word ptr ds:[bp+0Bh], 0FF81h
		mov	ds:[bp+0Dh], ax
		mov	word ptr ds:[bp+0Fh], 0
		mov	byte ptr ds:[bp+11h], 1
		mov	byte ptr ds:[bp+12h], 5
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		push	ds
		mov	ds, cs:segHdf_missle
		sub	si, si
		mov	ax, 2
		call	GetRandomInRange
		xchg	ah, al
		add	ah, 2
		mov	al, 10h
		call	AddHDFSpr_Mode2
		pop	ds
		retn
; ---------------------------------------------------------------------------
		db 6 dup(0), 1,	0, 2, 0, 3, 0, 4, 0, 5,	0, 6, 0, 6, 0
		db 7, 0, 8, 0, 8, 0, 9,	0, 9, 0, 0Ah, 0, 0Bh, 0, 0Ch, 0
		db 0Ch,	0, 0Dh,	0, 0Eh,	0, 0Fh,	7 dup(0), 1, 0,	2, 0, 3
		db 0, 4, 0, 4, 0, 5, 0,	6, 0, 7, 0, 8, 0, 8, 0,	8, 0, 9
		db 0
; ---------------------------------------------------------------------------

loc_1573F:				; DATA XREF: seg000:off_145A5o
		add	cx, 10h
		call	sub_15D5F
		mov	ds:[bp+13h], si
		mov	ds:[bp+15h], di
		mov	ax, si
		shr	ax, 4
		and	ax, 7
		mov	ds:[bp+0Dh], ax
		mov	ax, si
		call	sub_1BE93
		shl	cx, 2
		shl	dx, 2
		mov	ds:[bp+9], cx
		mov	ds:[bp+0Bh], dx
		mov	word ptr ds:[bp+0Fh], 0
		mov	byte ptr ds:[bp+11h], 14h
		mov	byte ptr ds:[bp+12h], 3
		retn
; ---------------------------------------------------------------------------

loc_1577D:				; DATA XREF: seg000:off_145A5o
		call	sub_15D5F
		mov	word ptr ds:[bp+13h], 0
		mov	word ptr ds:[bp+15h], 0FFFFh
		mov	word ptr ds:[bp+0Bh], 0FF81h
		mov	ds:[bp+0Dh], si
		mov	word ptr ds:[bp+0Fh], 0
		mov	byte ptr ds:[bp+11h], 1
		mov	byte ptr ds:[bp+12h], 3
		retn
; ---------------------------------------------------------------------------

loc_157A7:				; DATA XREF: seg000:off_1467Ao
		call	sub_15C7C
		call	sub_15C93
		mov	ax, ds:[bp+0Fh]
		inc	ax
		cmp	ax, 3
		jb	short loc_157BC
		mov	byte ptr ds:[bp+0], 0

loc_157BC:				; CODE XREF: seg000:57B5j
		mov	ds:[bp+0Fh], ax
		mov	ax, ds:[bp+0Dh]
		add	ax, ds:[bp+0Fh]
		mov	cx, ds:[bp+3]
		shr	cx, 6
		mov	ds:[bp+1], cx
		mov	dx, ds:[bp+7]
		shr	dx, 6
		mov	ds:[bp+5], dx
		push	ds
		mov	ds, cs:word_10CCD
		sub	si, si
		call	AddHDFSpr_Mode1
		pop	ds
		retn
; ---------------------------------------------------------------------------
		call	sub_15C93
		mov	ax, ds:[bp+0Fh]
		dec	ax
		cmp	ax, 0
		jnz	short loc_157FD
		mov	byte ptr ds:[bp+0], 0

loc_157FD:				; CODE XREF: seg000:57F6j
		mov	ds:[bp+0Fh], ax
		mov	ax, ds:[bp+0Dh]
		add	ax, ds:[bp+0Fh]
		mov	cx, ds:[bp+3]
		shr	cx, 6
		mov	ds:[bp+1], cx
		mov	dx, ds:[bp+7]
		shr	dx, 6
		mov	ds:[bp+5], dx
		push	ds
		mov	ds, cs:word_10CCD
		sub	si, si
		mov	ah, 0Fh
		call	AddHDFSpr_Mode3
		pop	ds
		retn
; ---------------------------------------------------------------------------

loc_1582E:				; DATA XREF: seg000:off_1467Ao
		mov	ax, ds:[bp+9]
		add	ds:[bp+1], ax
		mov	ax, ds:[bp+0Bh]
		add	ds:[bp+5], ax
		call	sub_15C93
		cmp	cs:word_12FA9, 1
		jz	short loc_15851
		inc	word ptr ds:[bp+0Bh]
		inc	word ptr ds:[bp+0Bh]

loc_15851:				; CODE XREF: seg000:5847j
		inc	word ptr ds:[bp+0Fh]
		and	word ptr ds:[bp+0Fh], 7
		mov	ax, ds:[bp+0Dh]
		add	ax, ds:[bp+0Fh]
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		push	ds
		mov	ds, cs:segHdf_shot
		sub	si, si
		call	AddHDFSpr_Mode1
		pop	ds
		call	sub_15C7C
		retn
; ---------------------------------------------------------------------------

loc_1587A:				; DATA XREF: seg000:off_1467Ao
		call	sub_15C93
		mov	ax, ds:[bp+0Dh]
		add	ax, ds:[bp+0Fh]
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		push	ds
		mov	ds, cs:segHdf_shot
		sub	si, si
		pop	ds
		call	sub_15C7C
		mov	ax, ds:[bp+0Fh]
		inc	ax
		cmp	ax, 3
		jb	short loc_158A8
		mov	byte ptr ds:[bp+0], 0

loc_158A8:				; CODE XREF: seg000:58A1j
		mov	ds:[bp+0Fh], ax
		retn
; ---------------------------------------------------------------------------

loc_158AD:				; DATA XREF: seg000:off_1467Ao
		call	sub_15C93
		mov	ax, ds:[bp+0Fh]
		and	ax, 1
		add	ax, ds:[bp+0Dh]
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		push	ds
		mov	ds, cs:segHdf_shot
		sub	si, si
		pop	ds
		call	sub_15C7C
		mov	ax, ds:[bp+0Fh]
		inc	ax
		cmp	ax, 2
		jb	short loc_158DE
		mov	byte ptr ds:[bp+0], 0

loc_158DE:				; CODE XREF: seg000:58D7j
		mov	ds:[bp+0Fh], ax
		retn
; ---------------------------------------------------------------------------

loc_158E3:				; DATA XREF: seg000:off_1467Ao
		mov	ax, cs:BasePosX
		add	ds:[bp+1], ax
		mov	ax, cs:BasePosY
		add	ds:[bp+5], ax
		call	sub_15C93

loc_158F6:				; CODE XREF: seg000:590Cj
		mov	bx, ds:[bp+0Fh]
		shl	bx, 1
		mov	ax, cs:[bx+59C1h]
		cmp	ax, 0FFFFh
		jnz	short loc_1590E
		mov	word ptr ds:[bp+0Fh], 0
		jmp	short loc_158F6
; ---------------------------------------------------------------------------

loc_1590E:				; CODE XREF: seg000:5904j
		cmp	byte ptr ds:[bp+11h], 3Ch ; '<'
		jnb	short loc_1591C
		test	byte ptr ds:[bp+11h], 1
		jz	short loc_1594B

loc_1591C:				; CODE XREF: seg000:5913j
		add	ax, ds:[bp+0Dh]
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		cmp	cs:word_1BDF0, 0
		jnz	short loc_1593F
		test	cs:word_143A1, 8000h
		jnz	short loc_1593F
		and	cx, 0FFF8h
		add	cx, 8

loc_1593F:				; CODE XREF: seg000:592Ej seg000:5937j
		push	ds
		mov	ds, cs:segHdf_itemp
		sub	si, si
		call	AddHDFSpr_Mode1
		pop	ds

loc_1594B:				; CODE XREF: seg000:591Aj
		dec	byte ptr ds:[bp+11h]
		cmp	byte ptr ds:[bp+11h], 0
		jnz	short loc_1595B
		mov	byte ptr ds:[bp+0], 0

loc_1595B:				; CODE XREF: seg000:5954j
		inc	word ptr ds:[bp+0Fh]
		mov	cx, cs:word_1EA52
		mov	dx, cs:word_1EA56
		mov	ax, ds:[bp+1]
		mov	bx, ds:[bp+5]
		sub	ax, 20h	; ' '
		sub	bx, 20h	; ' '
		cmp	cx, ax
		jb	short locret_159C0
		cmp	dx, bx
		jb	short locret_159C0
		add	ax, 60h	; '`'
		add	bx, 20h	; ' '
		cmp	dx, bx
		jnb	short locret_159C0
		cmp	cx, ax
		jnb	short locret_159C0
		mov	byte ptr ds:[bp+0], 0
		mov	cs:word_1EA66, 10h
		pusha
		mov	dx, 5
		call	sub_1E653
		popa
		mov	al, 0Bh
		call	sub_1E582
		inc	cs:word_1EA64
		cmp	cs:word_1EA64, 6
		jb	short locret_159C0
		mov	cs:word_1EA64, 1
		mov	ax, 1Eh
		call	sub_11C1C

locret_159C0:				; CODE XREF: seg000:5979j seg000:597Dj ...
		retn
; ---------------------------------------------------------------------------
		db 2 dup(0), 1,	0, 2, 0, 3, 0, 2, 0, 1,	0, 2 dup(0FFh)
; ---------------------------------------------------------------------------

loc_159CF:				; CODE XREF: seg000:59E2j
					; DATA XREF: seg000:off_1467Ao
		call	sub_15CED
		mov	bx, ds:[bp+15h]
		cmp	word ptr [bx+2], 0
		jnz	short loc_159E4
		mov	word ptr ds:[bp+15h], 0FFFFh
		jmp	short loc_159CF
; ---------------------------------------------------------------------------

loc_159E4:				; CODE XREF: seg000:59DAj
		call	sub_15C93
		mov	ax, ds:[bp+13h]
		call	sub_1BE93
		sar	cx, 2
		sar	dx, 1
		add	ds:[bp+9], cx
		add	ds:[bp+0Bh], dx
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		mov	bx, ds:[bp+15h]
		mov	si, [bx+4]
		mov	di, [bx+6]
		add	si, [bx+50h]
		add	di, [bx+52h]
		call	sub_1BF6B
		mov	ds:[bp+0Dh], ax
		mov	ds:[bp+13h], cx
		jmp	short loc_15A36
; ---------------------------------------------------------------------------
		cmp	ds:[bp+13h], cx
		jz	short loc_15A36
		jnb	short loc_15A2A
		jb	short loc_15A31

loc_15A2A:				; CODE XREF: seg000:5A26j
		add	word ptr ds:[bp+13h], 10h
		jmp	short loc_15A36
; ---------------------------------------------------------------------------

loc_15A31:				; CODE XREF: seg000:5A28j
		sub	word ptr ds:[bp+13h], 10h

loc_15A36:				; CODE XREF: seg000:5A1Ej seg000:5A24j ...
		mov	ax, ds:[bp+9]
		test	ah, 80h
		jnz	short loc_15A4D
		cmp	ax, 400h
		jb	short loc_15A59
		mov	ax, 3FFh
		mov	ds:[bp+9], ax
		jmp	short loc_15A59
; ---------------------------------------------------------------------------

loc_15A4D:				; CODE XREF: seg000:5A3Dj
		cmp	ax, 0FC00h
		jnb	short loc_15A59
		mov	ax, 0FC01h
		mov	ds:[bp+9], ax

loc_15A59:				; CODE XREF: seg000:5A42j seg000:5A4Bj ...
		add	ds:[bp+3], ax
		mov	ax, ds:[bp+0Bh]
		test	ah, 80h
		jnz	short loc_15A74
		cmp	ax, 100h
		jb	short loc_15A80
		mov	ax, 0FFh
		mov	ds:[bp+0Bh], ax
		jmp	short loc_15A80
; ---------------------------------------------------------------------------

loc_15A74:				; CODE XREF: seg000:5A64j
		cmp	ax, 0FF00h
		jnb	short loc_15A80
		mov	ax, 0FF01h
		mov	ds:[bp+0Bh], ax

loc_15A80:				; CODE XREF: seg000:5A69j seg000:5A72j ...
		add	ds:[bp+7], ax
		call	sub_15C7C
		call	sub_15CB6
		jnb	short loc_15AE7
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		sub	ah, ah
		mov	al, ds:[bp+12h]
		call	sub_1823E
		jb	short loc_15AE7
		mov	ax, ds:[bp+0Dh]
		mov	cx, ds:[bp+3]
		shr	cx, 6
		mov	ds:[bp+1], cx
		mov	dx, ds:[bp+7]
		sar	dx, 6
		mov	ds:[bp+5], dx
		push	ds
		mov	ds, cs:segHdf_missle
		sub	si, si
		call	AddHDFSpr_Mode0
		pop	ds
		mov	ax, 2
		call	GetRandomInRange
		or	ax, ax
		jnz	short locret_15AE6
		push	bp
		mov	si, ds:[bp+13h]
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		add	dx, 2
		mov	ax, 9
		call	sub_15EF8
		pop	bp

locret_15AE6:				; CODE XREF: seg000:5ACDj
		retn
; ---------------------------------------------------------------------------

loc_15AE7:				; CODE XREF: seg000:5A8Aj seg000:5A9Dj
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		mov	byte ptr ds:[bp+0], 0
		call	sub_15E2A
		retn
; ---------------------------------------------------------------------------

loc_15AF8:				; DATA XREF: seg000:off_1467Ao
		mov	cx, 6

loc_15AFB:				; CODE XREF: seg000:loc_15BF3j
		push	cx
		mov	ax, ds:[bp+13h]
		call	sub_1BE93
		sar	cx, 4
		sar	dx, 4
		add	ds:[bp+9], cx
		add	ds:[bp+0Bh], dx
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		mov	bx, ds:[bp+15h]
		mov	si, [bx+4]
		mov	di, [bx+6]
		call	sub_1BF6B
		cmp	ds:[bp+13h], cx
		jz	short loc_15B3C
		jnb	short loc_15B30
		jb	short loc_15B37

loc_15B30:				; CODE XREF: seg000:5B2Cj
		sub	word ptr ds:[bp+13h], 8
		jmp	short loc_15B3C
; ---------------------------------------------------------------------------

loc_15B37:				; CODE XREF: seg000:5B2Ej
		add	word ptr ds:[bp+13h], 8

loc_15B3C:				; CODE XREF: seg000:5B2Aj seg000:5B35j
		mov	ax, ds:[bp+9]
		test	ah, 80h
		jnz	short loc_15B53
		cmp	ax, 17Dh
		jb	short loc_15B63
		mov	ax, 17Ch
		mov	ds:[bp+9], ax
		jmp	short loc_15B63
; ---------------------------------------------------------------------------

loc_15B53:				; CODE XREF: seg000:5B43j
		neg	ax
		cmp	ax, 17Dh
		jb	short loc_15B5D
		mov	ax, 17Ch

loc_15B5D:				; CODE XREF: seg000:5B58j
		neg	ax
		mov	ds:[bp+9], ax

loc_15B63:				; CODE XREF: seg000:5B48j seg000:5B51j
		add	ds:[bp+3], ax
		mov	ax, ds:[bp+0Bh]
		test	ah, 80h
		jnz	short loc_15B7E
		cmp	ax, 0B2h ; '≤'
		jb	short loc_15B8E
		mov	ax, 0B1h ; '±'
		mov	ds:[bp+0Bh], ax
		jmp	short loc_15B8E
; ---------------------------------------------------------------------------

loc_15B7E:				; CODE XREF: seg000:5B6Ej
		neg	ax
		cmp	ax, 0B2h ; '≤'
		jb	short loc_15B88
		mov	ax, 0B1h ; '±'

loc_15B88:				; CODE XREF: seg000:5B83j
		neg	ax
		mov	ds:[bp+0Bh], ax

loc_15B8E:				; CODE XREF: seg000:5B73j seg000:5B7Cj
		add	ds:[bp+7], ax
		call	sub_15C93
		call	sub_15CB6
		jnb	short loc_15C14
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		sub	ah, ah
		mov	al, ds:[bp+12h]
		call	sub_1823E
		jb	short loc_15BF7

loc_15BAD:				; CODE XREF: seg000:5C0Bj seg000:5C12j ...
		mov	ax, ds:[bp+0Dh]
		mov	cx, ds:[bp+3]
		shr	cx, 6
		mov	ds:[bp+1], cx
		mov	dx, ds:[bp+7]
		shr	dx, 6
		mov	ds:[bp+5], dx
		push	ds
		mov	ds, cs:segHdf_rayoX
		sub	si, si
		mov	ax, 10h
		mov	ah, 0Fh
		call	AddHDFSpr_Mode2
		pop	ds
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		mov	ax, 0Ah
		mov	si, ds:[bp+0Dh]
		push	cx
		push	dx
		call	sub_14567
		pop	dx
		pop	cx
		pop	cx
		loop	loc_15BF3
		jmp	short locret_15BF6
; ---------------------------------------------------------------------------

loc_15BF3:				; CODE XREF: seg000:5BEFj
		jmp	loc_15AFB
; ---------------------------------------------------------------------------

locret_15BF6:				; CODE XREF: seg000:5BF1j
		retn
; ---------------------------------------------------------------------------

loc_15BF7:				; CODE XREF: seg000:5BABj
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		call	sub_15E2A
		dec	byte ptr ds:[bp+11h]
		cmp	byte ptr ds:[bp+11h], 0
		jnz	short loc_15BAD
		mov	byte ptr ds:[bp+0], 0
		jmp	short loc_15BAD
; ---------------------------------------------------------------------------

loc_15C14:				; CODE XREF: seg000:5B98j
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		mov	byte ptr ds:[bp+0], 0
		jmp	short loc_15BAD
; ---------------------------------------------------------------------------

loc_15C23:				; DATA XREF: seg000:off_1467Ao
		call	sub_15C93
		mov	ax, ds:[bp+0Dh]
		mov	cx, ds:[bp+3]
		shr	cx, 6
		mov	ds:[bp+1], cx
		mov	dx, ds:[bp+7]
		shr	dx, 6
		mov	ds:[bp+5], dx
		mov	bx, ds:[bp+0Fh]
		mov	ax, 10h
		mov	ah, cs:[bx+5C77h]
		push	ds
		mov	ds, cs:segHdf_rayoX
		sub	si, si
		call	AddHDFSpr_Mode2
		pop	ds
		inc	word ptr ds:[bp+0Fh]
		cmp	word ptr ds:[bp+0Fh], 5
		jb	short locret_15C68
		mov	byte ptr ds:[bp+0], 0

locret_15C68:				; CODE XREF: seg000:5C61j
		retn
; ---------------------------------------------------------------------------
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		mov	byte ptr ds:[bp+0], 0
		retn
; ---------------------------------------------------------------------------
		db 0Fh,	0Eh, 0Dh, 0Ch, 1

; =============== S U B	R O U T	I N E =======================================


sub_15C7C	proc near		; CODE XREF: seg000:471Bp
					; seg000:loc_14CEAp ...
		mov	ax, cs:BasePosX
		shl	ax, 6
		add	ds:[bp+3], ax
		mov	ax, cs:BasePosY
		shl	ax, 6
		add	ds:[bp+7], ax
		retn
sub_15C7C	endp


; =============== S U B	R O U T	I N E =======================================


sub_15C93	proc near		; CODE XREF: seg000:loc_14718p
					; seg000:loc_14A56p ...
		mov	ax, ds:[bp+1]
		add	ax, 0A0h ; '†'
		cmp	ax, 3C0h
		jb	short loc_15CA4
		mov	byte ptr ds:[bp+0], 0

loc_15CA4:				; CODE XREF: sub_15C93+Aj
		mov	ax, ds:[bp+5]
		add	ax, 3Ch	; '<'
		cmp	ax, 140h
		jb	short locret_15CB5
		mov	byte ptr ds:[bp+0], 0

locret_15CB5:				; CODE XREF: sub_15C93+1Bj
		retn
sub_15C93	endp


; =============== S U B	R O U T	I N E =======================================


sub_15CB6	proc near		; CODE XREF: seg000:4788p seg000:4A59p ...
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		sub	cx, 10h
		call	sub_1A6B7
		cmp	ax, cs:word_1BE30
		jnb	short loc_15CEA
		add	cx, 10h
		call	sub_1A6B7
		cmp	ax, cs:word_1BE30
		jnb	short loc_15CEA
		sub	cx, 10h
		add	dx, 8
		call	sub_1A6B7
		cmp	ax, cs:word_1BE30
		jnb	short loc_15CEA
		stc
		retn
; ---------------------------------------------------------------------------

loc_15CEA:				; CODE XREF: sub_15CB6+13j
					; sub_15CB6+20j ...
		clc
		retn
sub_15CB6	endp

; ---------------------------------------------------------------------------
		retn

; =============== S U B	R O U T	I N E =======================================


sub_15CED	proc near		; CODE XREF: seg000:loc_153F4p
					; seg000:loc_159CFp ...
		cmp	word ptr ds:[bp+15h], 0FFFFh
		jnz	short locret_15D5D
		sub	dx, dx
		mov	bx, 0D684h
		mov	cx, 3Ch	; '<'

loc_15CFC:				; CODE XREF: sub_15CED+51j
		cmp	word ptr [bx+2], 0
		jz	short loc_15D3A
		cmp	word ptr [bx+26h], 0
		jz	short loc_15D3A
		cmp	cs:word_1EA5C, 0
		jnz	short loc_15D1B
		mov	ax, cs:word_1EA52
		cmp	[bx+4],	ax
		jb	short loc_15D26
		jmp	short loc_15D3A
; ---------------------------------------------------------------------------

loc_15D1B:				; CODE XREF: sub_15CED+21j
		mov	ax, cs:word_1EA52
		cmp	[bx+4],	ax
		jnb	short loc_15D26
		jmp	short loc_15D3A
; ---------------------------------------------------------------------------

loc_15D26:				; CODE XREF: sub_15CED+2Aj
					; sub_15CED+35j
		mov	dx, 1
		mov	ax, 2
		call	GetRandomInRange
		cmp	ax, 0
		jnz	short loc_15D3A
		mov	ds:[bp+15h], bx
		jmp	short locret_15D5D
; ---------------------------------------------------------------------------

loc_15D3A:				; CODE XREF: sub_15CED+13j
					; sub_15CED+19j ...
		add	bx, 98h	; 'ò'
		loop	loc_15CFC
		cmp	dx, 0
		jnz	short sub_15CED
		cmp	cs:word_1EA5C, 0
		jz	short loc_15D55
		mov	word ptr ds:[bp+15h], 180h
		jmp	short locret_15D5E
; ---------------------------------------------------------------------------

loc_15D55:				; CODE XREF: sub_15CED+5Ej
		mov	word ptr ds:[bp+15h], 218h
		jmp	short locret_15D5E
; ---------------------------------------------------------------------------

locret_15D5D:				; CODE XREF: sub_15CED+5j
					; sub_15CED+4Bj
		retn
; ---------------------------------------------------------------------------

locret_15D5E:				; CODE XREF: sub_15CED+66j
					; sub_15CED+6Ej
		retn
sub_15CED	endp


; =============== S U B	R O U T	I N E =======================================


sub_15D5F	proc near		; CODE XREF: seg000:46F6p
					; seg000:loc_147E8p ...
		push	cx
		push	dx
		mov	ds:[bp+1], cx
		shl	cx, 6
		mov	ds:[bp+3], cx
		mov	ds:[bp+5], dx
		shl	dx, 6
		mov	ds:[bp+7], dx
		pop	dx
		pop	cx
		retn
sub_15D5F	endp


; =============== S U B	R O U T	I N E =======================================


sub_15D7A	proc near		; CODE XREF: seg000:47C6p seg000:4C4Dp ...
		mov	ax, ds:[bp+9]
		add	ds:[bp+3], ax
		mov	ax, ds:[bp+0Bh]
		add	ds:[bp+7], ax
		retn
sub_15D7A	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_15D8C	proc near		; CODE XREF: sub_16D21+1Ap
					; sub_176C1+2D8p ...
		push	si
		push	es
		push	ds
		sub	cx, 20h	; ' '
		mov	ax, ds:[bp+42h]
		add	ax, 28h	; '('
		call	GetRandomInRange
		add	cx, ax
		sub	dx, 8
		mov	ax, ds:[bp+46h]
		add	ax, 10h
		call	GetRandomInRange
		add	dx, ax

loc_15DAD:				; CODE XREF: sub_15E2A+3j
		mov	ax, 168h
		call	GetRandomInRange
		mov	si, ax
		mov	ax, 1
		push	cx
		push	dx
		call	sub_15EF8
		pop	dx
		pop	cx
		mov	ax, 168h
		call	GetRandomInRange
		mov	si, ax
		mov	ax, 1
		push	cx
		push	dx
		call	sub_15EF8
		pop	dx
		pop	cx
		mov	ax, 168h
		call	GetRandomInRange
		mov	si, ax
		mov	ax, 1
		push	cx
		push	dx
		call	sub_15EF8
		pop	dx
		pop	cx
		mov	ax, 168h
		call	GetRandomInRange
		mov	si, ax
		mov	ax, 3
		push	cx
		push	dx
		call	sub_15EF8
		pop	dx
		pop	cx
		mov	ax, 168h
		call	GetRandomInRange
		mov	si, ax
		mov	ax, 3
		push	cx
		push	dx
		call	sub_15EF8
		pop	dx
		pop	cx
		mov	ax, 168h
		call	GetRandomInRange
		mov	si, ax
		mov	ax, 3
		push	cx
		push	dx
		call	sub_15EF8
		pop	dx
		pop	cx
		pusha
		mov	dx, 5
		call	sub_1E653
		popa
		mov	al, 2
		call	sub_1E582
		pop	ds
		pop	es
		pop	si
		retn
sub_15D8C	endp


; =============== S U B	R O U T	I N E =======================================


sub_15E2A	proc near		; CODE XREF: seg000:4A47p seg000:4ADFp ...
		push	si
		push	es
		push	ds
		jmp	loc_15DAD
sub_15E2A	endp


; =============== S U B	R O U T	I N E =======================================


sub_15E30	proc near		; CODE XREF: sub_16D21+1Ap
					; DATA XREF: seg000:6D47o
		push	si
		push	es
		push	ds
		sub	cx, 20h	; ' '
		mov	ax, ds:[bp+42h]
		add	ax, 28h	; '('
		call	GetRandomInRange
		add	cx, ax
		sub	dx, 8
		mov	ax, ds:[bp+46h]
		add	ax, 10h
		call	GetRandomInRange
		add	dx, ax

loc_15E51:				; CODE XREF: seg000:5EF5j
		mov	ax, 168h
		call	GetRandomInRange
		mov	si, ax
		mov	ax, 1
		push	cx
		push	dx
		call	sub_15EF8
		pop	dx
		pop	cx
		mov	ax, 168h
		call	GetRandomInRange
		mov	si, ax
		mov	ax, 1
		push	cx
		push	dx
		call	sub_15EF8
		pop	dx
		pop	cx
		mov	ax, 168h
		call	GetRandomInRange
		mov	si, ax
		mov	ax, 1
		push	cx
		push	dx
		call	sub_15EF8
		pop	dx
		pop	cx
		mov	ax, 168h
		call	GetRandomInRange
		mov	si, ax
		mov	ax, 1
		push	cx
		push	dx
		call	sub_15EF8
		pop	dx
		pop	cx
		mov	ax, 168h
		call	GetRandomInRange
		mov	si, ax
		mov	ax, 3
		push	cx
		push	dx
		call	sub_15EF8
		pop	dx
		pop	cx
		mov	ax, 168h
		call	GetRandomInRange
		mov	si, ax
		mov	ax, 3
		push	cx
		push	dx
		call	sub_15EF8
		pop	dx
		pop	cx
		mov	ax, 168h
		call	GetRandomInRange
		mov	si, ax
		mov	ax, 3
		push	cx
		push	dx
		call	sub_15EF8
		pop	dx
		pop	cx
		mov	ax, 168h
		call	GetRandomInRange
		mov	si, ax
		mov	ax, 3
		push	cx
		push	dx
		call	sub_15EF8
		pop	dx
		pop	cx
		pusha
		mov	dx, 5
		call	sub_1E653
		popa
		mov	al, 5
		call	sub_1E582
		pop	ds
		pop	es
		pop	si
		retn
sub_15E30	endp

; ---------------------------------------------------------------------------
		push	si
		push	es
		push	ds
		jmp	loc_15E51

; =============== S U B	R O U T	I N E =======================================


sub_15EF8	proc near		; CODE XREF: sub_12342+3p
					; sub_1260A+505p ...
		push	cx
		push	dx
		push	bp
		push	es
		push	ds
		push	ax
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		pop	ax
		mov	cs:word_15F5C, cx
		mov	bp, offset byte_208EA
		mov	cx, 1Eh

loc_15F0F:				; CODE XREF: sub_15EF8+3Aj
		cmp	byte ptr ds:[bp+0], 0
		jnz	short loc_15F2F
		mov	ds:[bp+0], al
		mov	bx, ax
		shl	bx, 1
		push	cx
		push	bp
		mov	cx, cs:word_15F5C
		call	cs:off_15F3A[bx]
		pop	bp
		pop	cx
		mov	cx, 1

loc_15F2F:				; CODE XREF: sub_15EF8+1Cj
		add	bp, 0Fh
		loop	loc_15F0F
		pop	ds
		assume ds:nothing
		pop	es
		pop	bp
		pop	dx
		pop	cx
		retn
sub_15EF8	endp

; ---------------------------------------------------------------------------
off_15F3A	dw offset start		; 0 ; DATA XREF: sub_15EF8+2Dr
		dw offset loc_15FDE	; 1
		dw offset loc_15FFD	; 2
		dw offset loc_1603D	; 3
		dw offset loc_161E3	; 4
		dw offset loc_1622D	; 5
		dw offset loc_1601D	; 6
		dw offset loc_16180	; 7
		dw offset loc_16166	; 8
		dw offset loc_1605C	; 9
		dw offset loc_16082	; 0Ah
		dw offset loc_160B7	; 0Bh
		dw offset loc_16180	; 0Ch
		dw offset loc_161A1	; 0Dh
		dw offset loc_161A1	; 0Eh
		dw offset loc_161C2	; 0Fh
		dw offset loc_161C2	; 10h
word_15F5C	dw 0			; DATA XREF: sub_15EF8+Cw
					; sub_15EF8+28r

; =============== S U B	R O U T	I N E =======================================


sub_15F5E	proc near		; CODE XREF: sub_10F09+43p
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		mov	bp, 8FAh
		mov	cx, 1Eh

loc_15F69:				; CODE XREF: sub_15F5E+57j
		cmp	byte ptr ds:[bp+0], 0
		jz	short loc_15FB2
		sub	ah, ah
		mov	al, ds:[bp+0]
		mov	bx, ax
		shl	bx, 1
		push	cx
		push	bp
		mov	ax, cs:word_1B8B9
		push	ax
		mov	cs:word_1B8B9, 4
		mov	ax, cs:word_15FDA
		add	ds:[bp+1], ax
		shl	ax, 6
		add	ds:[bp+3], ax
		mov	ax, cs:word_15FDC
		add	ds:[bp+5], ax
		shl	ax, 6
		add	ds:[bp+7], ax
		call	cs:off_15FB8[bx]
		pop	ax
		mov	cs:word_1B8B9, ax
		pop	bp
		pop	cx

loc_15FB2:				; CODE XREF: sub_15F5E+10j
		add	bp, 0Fh
		loop	loc_15F69
		retn
sub_15F5E	endp

; ---------------------------------------------------------------------------
off_15FB8	dw offset start		; 0 ; DATA XREF: sub_15F5E+48r
		dw offset loc_1627E	; 1
		dw offset loc_1627E	; 2
		dw offset loc_16322	; 3
		dw offset loc_164CB	; 4
		dw offset loc_16518	; 5
		dw offset loc_162CC	; 6
		dw offset loc_16410	; 7
		dw offset loc_16372	; 8
		dw offset loc_163C0	; 9
		dw offset loc_160EA	; 0Ah
		dw offset loc_1613D	; 0Bh
		dw offset loc_1646C	; 0Ch
		dw offset loc_16410	; 0Dh
		dw offset loc_1646C	; 0Eh
		dw offset loc_16410	; 0Fh
		dw offset loc_1646C	; 10h
word_15FDA	dw 0			; DATA XREF: cmfA1F+1w	sub_15F5E+2Ar ...
word_15FDC	dw 0			; DATA XREF: cmfA1F+6w	sub_15F5E+39r ...
; ---------------------------------------------------------------------------

loc_15FDE:				; DATA XREF: seg000:off_15F3Ao
		call	ObjPos_Set2nd
		mov	ax, si
		call	sub_1BE6D
		shl	cx, 1
		shl	dx, 1
		mov	ds:[bp+9], cx
		mov	ds:[bp+0Bh], dx
		mov	byte ptr ds:[bp+0Dh], 0
		mov	byte ptr ds:[bp+0Eh], 0
		retn
; ---------------------------------------------------------------------------

loc_15FFD:				; DATA XREF: seg000:off_15F3Ao
		sub	cx, 10h
		sub	dx, 8
		call	ObjPos_Set2nd
		mov	word ptr ds:[bp+9], 0
		mov	word ptr ds:[bp+0Bh], 0
		mov	byte ptr ds:[bp+0Dh], 0
		mov	byte ptr ds:[bp+0Eh], 0
		retn
; ---------------------------------------------------------------------------

loc_1601D:				; DATA XREF: seg000:off_15F3Ao
		sub	cx, 28h	; '('
		sub	dx, 14h
		call	ObjPos_Set2nd
		mov	word ptr ds:[bp+9], 0
		mov	word ptr ds:[bp+0Bh], 0
		mov	byte ptr ds:[bp+0Dh], 0Fh
		mov	byte ptr ds:[bp+0Eh], 0
		retn
; ---------------------------------------------------------------------------

loc_1603D:				; DATA XREF: seg000:off_15F3Ao
		call	ObjPos_Set2nd
		mov	ax, si
		call	sub_1BE6D
		shl	cx, 1
		shl	dx, 1
		mov	ds:[bp+9], cx
		mov	ds:[bp+0Bh], dx
		mov	byte ptr ds:[bp+0Dh], 7
		mov	byte ptr ds:[bp+0Eh], 0
		retn
; ---------------------------------------------------------------------------

loc_1605C:				; DATA XREF: seg000:off_15F3Ao
		sub	dx, 2
		call	ObjPos_Set2nd
		mov	ax, si
		call	sub_1BE93
		shl	cx, 1
		shl	dx, 1
		neg	cx
		neg	dx
		mov	ds:[bp+9], cx
		mov	ds:[bp+0Bh], dx
		mov	byte ptr ds:[bp+0Dh], 1Bh
		mov	byte ptr ds:[bp+0Eh], 0
		retn
; ---------------------------------------------------------------------------

loc_16082:				; DATA XREF: seg000:off_15F3Ao
		sub	dx, 2
		call	ObjPos_Set2nd
		sar	si, 2
		sar	di, 2
		mov	ax, 100h
		call	GetRandomInRange
		sub	ax, 80h	; 'Ä'
		add	si, ax
		mov	ax, 80h	; 'Ä'
		call	GetRandomInRange
		sub	ax, 40h	; '@'
		add	di, ax
		mov	ds:[bp+9], si
		mov	ds:[bp+0Bh], di
		mov	byte ptr ds:[bp+0Dh], 0
		mov	byte ptr ds:[bp+0Eh], 0
		retn
; ---------------------------------------------------------------------------

loc_160B7:				; DATA XREF: seg000:off_15F3Ao
		sub	dx, 2
		call	ObjPos_Set2nd
		sar	si, 1
		sar	di, 1
		mov	ax, 200h
		call	GetRandomInRange
		sub	ax, 100h
		add	si, ax
		mov	ax, 100h
		call	GetRandomInRange
		sub	ax, 80h	; 'Ä'
		add	di, ax
		mov	ds:[bp+9], si
		mov	ds:[bp+0Bh], di
		mov	byte ptr ds:[bp+0Dh], 0
		mov	byte ptr ds:[bp+0Eh], 0
		retn
; ---------------------------------------------------------------------------

loc_160EA:				; DATA XREF: seg000:off_15FB8o
		call	sub_16569
		sub	ah, ah
		mov	al, ds:[bp+0Dh]
		add	al, ds:[bp+0Eh]
		mov	cx, ds:[bp+3]	; X position
		shr	cx, 6
		mov	ds:[bp+1], cx
		mov	dx, ds:[bp+7]	; Y position
		shr	dx, 6
		mov	ds:[bp+5], dx
		push	ds
		mov	ds, cs:segHdf_shoth
		assume ds:nothing
		sub	si, si
		call	AddHDFSpr_Mode0
		pop	ds
		sub	ah, ah
		mov	al, ds:[bp+0Eh]
		inc	ax
		cmp	ax, 7
		jb	short loc_1612D
		mov	byte ptr ds:[bp+0], 0
		mov	ax, 0

loc_1612D:				; CODE XREF: seg000:6123j
		mov	ds:[bp+0Eh], al
		call	AddPos_BaseTo2
		call	CheckPos1
		add	word ptr ds:[bp+0Bh], 20h ; ' '
		retn
; ---------------------------------------------------------------------------

loc_1613D:				; DATA XREF: seg000:off_15FB8o
		call	sub_16569
		mov	cx, ds:[bp+3]	; X position
		shr	cx, 6
		mov	ds:[bp+1], cx
		mov	dx, ds:[bp+7]	; Y position
		shr	dx, 6
		mov	ds:[bp+5], dx
		push	ds
		mov	ah, 0Fh
		call	sub_1990B
		pop	ds
		call	CheckPos1
		add	word ptr ds:[bp+0Bh], 40h ; '@'
		retn
; ---------------------------------------------------------------------------

loc_16166:				; DATA XREF: seg000:off_15F3Ao
		call	ObjPos_Set2nd
		mov	word ptr ds:[bp+9], 0
		mov	word ptr ds:[bp+0Bh], 0
		mov	byte ptr ds:[bp+0Dh], 7
		mov	byte ptr ds:[bp+0Eh], 0
		retn
; ---------------------------------------------------------------------------

loc_16180:				; DATA XREF: seg000:off_15F3Ao
		call	ObjPos_Set2nd
		mov	ax, si
		call	sub_1BE6D
		shl	cx, 2
		shl	dx, 3
		mov	ds:[bp+9], cx
		mov	ds:[bp+0Bh], dx
		mov	byte ptr ds:[bp+0Dh], 17h
		mov	byte ptr ds:[bp+0Eh], 0
		retn
; ---------------------------------------------------------------------------

loc_161A1:				; DATA XREF: seg000:off_15F3Ao
		call	ObjPos_Set2nd
		mov	ax, si
		call	sub_1BE6D
		shl	cx, 2
		shl	dx, 3
		mov	ds:[bp+9], cx
		mov	ds:[bp+0Bh], dx
		mov	byte ptr ds:[bp+0Dh], 21h ; '!'
		mov	byte ptr ds:[bp+0Eh], 0
		retn
; ---------------------------------------------------------------------------

loc_161C2:				; DATA XREF: seg000:off_15F3Ao
		call	ObjPos_Set2nd
		mov	ax, si
		call	sub_1BE6D
		shl	cx, 2
		shl	dx, 2
		mov	ds:[bp+9], cx
		mov	ds:[bp+0Bh], dx
		mov	byte ptr ds:[bp+0Dh], 25h ; '%'
		mov	byte ptr ds:[bp+0Eh], 0
		retn
; ---------------------------------------------------------------------------

loc_161E3:				; CODE XREF: seg000:61EEj
					; DATA XREF: seg000:off_15F3Ao
		add	dx, 2
		call	sub_1A65E
		cmp	ax, cs:word_1BE30
		jb	short loc_161E3
		cmp	dx, 0BEh ; 'æ'
		jb	short loc_161FD
		mov	byte ptr ds:[bp+0], 0
		jmp	short locret_1622C
; ---------------------------------------------------------------------------

loc_161FD:				; CODE XREF: seg000:61F4j
		sub	dx, 6
		call	ObjPos_Set2nd
		mov	ax, si
		test	ax, 8000h
		jz	short loc_1620C
		neg	ax

loc_1620C:				; CODE XREF: seg000:6208j
		inc	ax
		call	GetRandomInRange
		test	si, 8000h
		jz	short loc_16218
		neg	ax

loc_16218:				; CODE XREF: seg000:6214j
		mov	ds:[bp+9], ax
		mov	word ptr ds:[bp+0Bh], 0
		mov	byte ptr ds:[bp+0Dh], 0
		mov	byte ptr ds:[bp+0Eh], 0

locret_1622C:				; CODE XREF: seg000:61FBj
		retn
; ---------------------------------------------------------------------------

loc_1622D:				; DATA XREF: seg000:off_15F3Ao
		mov	ax, 0Ah
		call	GetRandomInRange
		cmp	ax, 8
		jb	short loc_16277
		mov	cx, 280h
		mov	ax, 0B4h ; '¥'
		call	GetRandomInRange
		mov	dx, ax
		and	ax, 0FFFEh
		sub	dx, 6
		call	ObjPos_Set2nd
		mov	ax, 20h	; ' '
		call	GetRandomInRange
		add	ax, 10h
		and	ax, 0FFFEh
		neg	ax
		shl	ax, 2
		mov	ds:[bp+9], ax
		mov	word ptr ds:[bp+0Bh], 0
		mov	byte ptr ds:[bp+0Dh], 0
		mov	ax, 2
		call	GetRandomInRange
		mov	ds:[bp+0Eh], al

locret_16276:				; CODE XREF: seg000:627Cj
		retn
; ---------------------------------------------------------------------------

loc_16277:				; CODE XREF: seg000:6236j
		mov	byte ptr ds:[bp+0], 0
		jmp	short locret_16276
; ---------------------------------------------------------------------------

loc_1627E:				; DATA XREF: seg000:off_15FB8o
		call	sub_16569
		sub	ah, ah
		mov	al, ds:[bp+0Dh]
		add	al, ds:[bp+0Eh]
		mov	cx, ds:[bp+3]	; X position
		shr	cx, 6
		mov	ds:[bp+1], cx
		mov	dx, ds:[bp+7]	; Y position
		shr	dx, 6
		mov	ds:[bp+5], dx
		push	ds
		mov	ds, cs:segHdf_bang3
		sub	si, si
		call	AddHDFSpr_Mode0
		pop	ds
		sub	ah, ah
		mov	al, ds:[bp+0Eh]
		inc	ax
		cmp	ax, 7
		jb	short loc_162C1
		mov	byte ptr ds:[bp+0], 0
		mov	ax, 0

loc_162C1:				; CODE XREF: seg000:62B7j
		mov	ds:[bp+0Eh], al
		call	AddPos_BaseTo2
		call	CheckPos1
		retn
; ---------------------------------------------------------------------------

loc_162CC:				; DATA XREF: seg000:off_15FB8o
		call	sub_16569
		sub	ah, ah
		mov	al, ds:[bp+0Eh]
		shr	al, 1
		add	al, ds:[bp+0Dh]
		mov	cx, ds:[bp+3]	; X position
		shr	cx, 6
		mov	ds:[bp+1], cx
		mov	dx, ds:[bp+7]	; Y position
		shr	dx, 6
		mov	ds:[bp+5], dx
		push	ds
		mov	ds, cs:segHdf_bang3
		sub	si, si
		call	AddHDFSpr_Mode0
		pop	ds
		sub	ah, ah
		mov	al, ds:[bp+0Eh]
		inc	ax
		cmp	ax, 6
		jb	short loc_1630A
		inc	ax

loc_1630A:				; CODE XREF: seg000:6307j
		cmp	ax, 10h
		jb	short loc_16317
		mov	byte ptr ds:[bp+0], 0
		mov	ax, 0

loc_16317:				; CODE XREF: seg000:630Dj
		mov	ds:[bp+0Eh], al
		call	AddPos_BaseTo2
		call	CheckPos1
		retn
; ---------------------------------------------------------------------------

loc_16322:				; DATA XREF: seg000:off_15FB8o
		call	sub_16569
		sub	ah, ah
		mov	al, ds:[bp+0Eh]
		shr	ax, 1
		add	al, ds:[bp+0Dh]
		mov	cx, ds:[bp+3]	; X position
		shr	cx, 6
		mov	ds:[bp+1], cx
		mov	dx, ds:[bp+7]	; Y position
		shr	dx, 6
		mov	ds:[bp+5], dx
		push	ds
		mov	ds, cs:segHdf_bang3
		sub	si, si
		call	AddHDFSpr_Mode3
		pop	ds
		sub	ah, ah
		mov	al, ds:[bp+0Eh]
		inc	ax
		cmp	ax, 8
		jb	short loc_16367
		mov	byte ptr ds:[bp+0], 0
		mov	ax, 8

loc_16367:				; CODE XREF: seg000:635Dj
		mov	ds:[bp+0Eh], al
		call	AddPos_BaseTo2
		call	CheckPos1
		retn
; ---------------------------------------------------------------------------

loc_16372:				; DATA XREF: seg000:off_15FB8o
		call	sub_16569
		sub	ah, ah
		mov	al, ds:[bp+0Dh]
		add	al, ds:[bp+0Eh]
		mov	cx, ds:[bp+3]	; X position
		shr	cx, 6
		mov	ds:[bp+1], cx
		mov	dx, ds:[bp+7]	; Y position
		shr	dx, 6
		mov	ds:[bp+5], dx
		push	ds
		mov	ds, cs:segHdf_bang3
		sub	si, si
		call	AddHDFSpr_Mode3
		pop	ds
		sub	ah, ah
		mov	al, ds:[bp+0Eh]
		inc	ax
		cmp	ax, 4
		jb	short loc_163B5
		mov	byte ptr ds:[bp+0], 0
		mov	ax, 4

loc_163B5:				; CODE XREF: seg000:63ABj
		mov	ds:[bp+0Eh], al
		call	AddPos_BaseTo2
		call	CheckPos1
		retn
; ---------------------------------------------------------------------------

loc_163C0:				; DATA XREF: seg000:off_15FB8o
		call	sub_16569
		sub	ah, ah
		mov	al, ds:[bp+0Dh]
		add	al, ds:[bp+0Eh]
		mov	cx, ds:[bp+3]	; X position
		shr	cx, 6
		mov	ds:[bp+1], cx
		mov	dx, ds:[bp+7]	; Y position
		shr	dx, 6
		mov	ds:[bp+5], dx
		push	ds
		mov	ds, cs:segHdf_bang3
		sub	si, si
		mov	ah, 0Fh
		call	AddHDFSpr_Mode2
		pop	ds
		sub	ah, ah
		mov	al, ds:[bp+0Eh]
		inc	ax
		cmp	ax, 6
		jb	short loc_16405
		mov	byte ptr ds:[bp+0], 0
		mov	ax, 0

loc_16405:				; CODE XREF: seg000:63FBj
		mov	ds:[bp+0Eh], al
		call	AddPos_BaseTo2
		call	CheckPos1
		retn
; ---------------------------------------------------------------------------

loc_16410:				; DATA XREF: seg000:off_15FB8o
		mov	ax, 2
		call	GetRandomInRange
		or	ax, ax
		jnz	short $+2
		call	sub_16569
		cmp	cs:word_12FA9, 1
		jz	short loc_1642B
		add	word ptr ds:[bp+0Bh], 80h ; 'Ä'

loc_1642B:				; CODE XREF: seg000:6423j
		sub	ah, ah
		mov	al, ds:[bp+0Dh]
		add	al, ds:[bp+0Eh]
		mov	cx, ds:[bp+3]	; X position
		shr	cx, 6
		mov	ds:[bp+1], cx
		mov	dx, ds:[bp+7]	; Y position
		shr	dx, 6
		mov	ds:[bp+5], dx
		push	ds
		mov	ds, cs:segHdf_bang3
		sub	si, si
		call	AddHDFSpr_Mode0
		pop	ds
		sub	ah, ah
		mov	al, ds:[bp+0Eh]
		inc	ax
		and	ax, 3
		mov	ds:[bp+0Eh], al
		call	AddPos_BaseTo2
		call	CheckPos1
		retn
; ---------------------------------------------------------------------------

loc_1646C:				; DATA XREF: seg000:off_15FB8o
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		mov	ax, 2
		call	sub_15EF8
		call	sub_16569
		cmp	cs:word_12FA9, 1
		jz	short loc_1648A
		add	word ptr ds:[bp+0Bh], 40h ; '@'

loc_1648A:				; CODE XREF: seg000:6483j
		sub	ah, ah
		mov	al, ds:[bp+0Dh]
		add	al, ds:[bp+0Eh]
		mov	cx, ds:[bp+3]	; X position
		shr	cx, 6
		mov	ds:[bp+1], cx
		mov	dx, ds:[bp+7]	; Y position
		shr	dx, 6
		mov	ds:[bp+5], dx
		push	ds
		mov	ds, cs:segHdf_bang3
		sub	si, si
		call	AddHDFSpr_Mode0
		pop	ds
		sub	ah, ah
		mov	al, ds:[bp+0Eh]
		inc	ax
		and	ax, 3
		mov	ds:[bp+0Eh], al
		call	AddPos_BaseTo2
		call	CheckPos1
		retn
; ---------------------------------------------------------------------------

loc_164CB:				; DATA XREF: seg000:off_15FB8o
		mov	ax, ds:[bp+9]
		add	ds:[bp+1], ax
		mov	ax, ds:[bp+0Bh]
		add	ds:[bp+5], ax
		sub	ah, ah
		mov	al, ds:[bp+0Dh]
		add	al, ds:[bp+0Eh]
		mov	cx, ds:[bp+1]	; X position
		mov	dx, ds:[bp+5]	; Y position
		push	ds
		mov	ds, cs:segHdf_smoke
		sub	si, si
		call	AddHDFSpr_Mode3
		pop	ds
		sub	ah, ah
		mov	al, ds:[bp+0Eh]
		inc	ax
		cmp	ax, 3
		jb	short loc_1650D
		mov	byte ptr ds:[bp+0], 0
		mov	ax, 0

loc_1650D:				; CODE XREF: seg000:6503j
		mov	ds:[bp+0Eh], al
		call	AddPos_BaseTo1
		call	CheckPos1
		retn
; ---------------------------------------------------------------------------

loc_16518:				; DATA XREF: seg000:off_15FB8o
		mov	ax, ds:[bp+9]
		add	ds:[bp+1], ax
		mov	ax, ds:[bp+0Bh]
		add	ds:[bp+5], ax
		sub	ah, ah
		mov	al, ds:[bp+0Dh]
		add	al, ds:[bp+0Eh]
		mov	cx, ds:[bp+1]	; X position
		mov	dx, ds:[bp+5]	; Y position
		push	ds
		mov	ds, cs:gfxBufPtrs_HDF
		assume ds:nothing
		sub	si, si
		call	AddHDFSpr_Mode1
		pop	ds
		assume ds:nothing
		call	AddPos_BaseTo1
		call	CheckPos1
		retn

; =============== S U B	R O U T	I N E =======================================


sub_1654D	proc near		; CODE XREF: cmfA15+5p
		push	es
		push	ds
		pusha
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		mov	bp, offset byte_208EA
		mov	cx, 1Eh

loc_1655B:				; CODE XREF: sub_1654D+16j
		mov	byte ptr ds:[bp+0], 0
		add	bp, 0Fh
		loop	loc_1655B
		popa
		pop	ds
		assume ds:nothing
		pop	es
		retn
sub_1654D	endp


; =============== S U B	R O U T	I N E =======================================


sub_16569	proc near		; CODE XREF: seg000:loc_160EAp
					; seg000:loc_1613Dp ...
		mov	ax, ds:[bp+9]
		add	ds:[bp+3], ax
		mov	ax, ds:[bp+0Bh]
		add	ds:[bp+7], ax
		retn
sub_16569	endp


; =============== S U B	R O U T	I N E =======================================


ObjPos_Set2nd	proc near		; CODE XREF: seg000:loc_15FDEp
					; seg000:6003p	...
		push	cx
		push	dx
		mov	ds:[bp+1], cx
		shl	cx, 6
		mov	ds:[bp+3], cx
		mov	ds:[bp+5], dx
		shl	dx, 6
		mov	ds:[bp+7], dx
		pop	dx
		pop	cx
		retn
ObjPos_Set2nd	endp


; =============== S U B	R O U T	I N E =======================================


AddPos_BaseTo1	proc near		; CODE XREF: seg000:6511p seg000:6546p
		mov	ax, cs:BasePosX
		add	ds:[bp+1], ax
		mov	ax, cs:BasePosY
		add	ds:[bp+5], ax
		retn
AddPos_BaseTo1	endp


; =============== S U B	R O U T	I N E =======================================


AddPos_BaseTo2	proc near		; CODE XREF: seg000:6131p seg000:62C5p ...
		mov	ax, cs:BasePosX
		shl	ax, 6
		add	ds:[bp+3], ax
		mov	ax, cs:BasePosY
		shl	ax, 6
		add	ds:[bp+7], ax
		retn
AddPos_BaseTo2	endp


; =============== S U B	R O U T	I N E =======================================


CheckPos1	proc near		; CODE XREF: seg000:6134p seg000:615Dp ...
		cmp	word ptr ds:[bp+1], 640
		jb	short loc_165CA
		mov	byte ptr ds:[bp+0], 0 ;	bad position - set flag	to 0

loc_165CA:				; CODE XREF: CheckPos1+6j
		cmp	word ptr ds:[bp+5], 200
		jb	short locret_165D7
		mov	byte ptr ds:[bp+0], 0 ;	bad position - set flag	to 0

locret_165D7:				; CODE XREF: CheckPos1+13j
		retn
CheckPos1	endp


; =============== S U B	R O U T	I N E =======================================


CmfMainLoopB	proc near		; CODE XREF: seg000:800Ep
					; DoCmfMainB+13p
		mov	ax, seg	seg001
		mov	es, ax
		assume es:seg001

loc_165DD:				; CODE XREF: CmfMainLoopB+1Dj
		cmp	word ptr es:[bp+5Ah], 0
		jz	short loc_165EB
		dec	word ptr es:[bp+5Ah]
		jmp	loc_166F8
; ---------------------------------------------------------------------------

loc_165EB:				; CODE XREF: CmfMainLoopB+Aj
		lodsw
		mov	bx, ax
		shl	bx, 1
		call	word ptr cs:cmfJumpTblB[bx]
		jb	short loc_165DD
		jmp	loc_166F8
; ---------------------------------------------------------------------------
cmfJumpTblB:				; DATA XREF: CmfMainLoopB+18r
		dw offset sub_16722	; 0
		dw offset sub_1672E	; 1
		dw offset sub_167CE	; 2
		dw offset cmfB03_Jump	; 3
		dw offset sub_167DA	; 4
		dw offset cmfB05_Wait	; 5
		dw offset sub_16811	; 6
		dw offset sub_16798	; 7
		dw offset cmfB08_SetSprFrames; 8
		dw offset sub_16823	; 9
		dw offset sub_1683E	; 0Ah
		dw offset sub_1686A	; 0Bh
		dw offset sub_168D8	; 0Ch
		dw offset sub_168DF	; 0Dh
		dw offset sub_168EC	; 0Eh
		dw offset sub_168F8	; 0Fh
		dw offset cmfB10_MoveMap; 10h
		dw offset cmfB11_SetSprPos; 11h
		dw offset sub_1693C	; 12h
		dw offset sub_16943	; 13h
		dw offset cmfB14	; 14h
		dw offset sub_16964	; 15h
		dw offset sub_16981	; 16h
		dw offset sub_1698E	; 17h
		dw offset sub_169C3	; 18h
		dw offset sub_169DE	; 19h
		dw offset sub_169EF	; 1Ah
		dw offset sub_16A29	; 1Bh
		dw offset sub_16A30	; 1Ch
		dw offset sub_16A3F	; 1Dh
		dw offset cmfB1E_Thing_Wait; 1Eh
		dw offset sub_16A7E	; 1Fh
		dw offset sub_16AB4	; 20h
		dw offset sub_16ABB	; 21h
		dw offset cmfB22_Thing_Wait; 22h
		dw offset sub_16AF0	; 23h
		dw offset sub_16AF7	; 24h
		dw offset sub_16B64	; 25h
		dw offset cmfB26_Thing_Wait; 26h
		dw offset sub_16C1B	; 27h
		dw offset sub_16C3F	; 28h
		dw offset sub_16C50	; 29h
		dw offset sub_16C80	; 2Ah
		dw offset cmfB2B_DoHDF	; 2Bh
		dw offset cmfB2C	; 2Ch
		dw offset sub_16CAF	; 2Dh
		dw offset sub_16CB6	; 2Eh
		dw offset sub_16CC7	; 2Fh
		dw offset sub_16CCE	; 30h
		dw offset sub_16CD5	; 31h
		dw offset sub_16CDB	; 32h
		dw offset sub_16CE8	; 33h
		dw offset cmfB34_HDF_GfxInc; 34h
		dw offset sub_16CFB	; 35h
		dw offset sub_16D02	; 36h
		dw offset sub_16D09	; 37h
		dw offset sub_16D15	; 38h
		dw offset sub_16D21	; 39h
		dw offset cmfB3A_TextWait; 3Ah
		dw offset sub_16D79	; 3Bh
		dw offset sub_16D80	; 3Ch
		dw offset sub_16D87	; 3Dh
		dw offset sub_16D98	; 3Eh
		dw offset sub_16D9F	; 3Fh
		dw offset sub_16DB5	; 40h
		dw offset sub_16DC1	; 41h
		dw offset sub_16DCC	; 42h
		dw offset cmdB43_CondJump; 43h
		dw offset sub_16DEA	; 44h
		dw offset sub_16E0C	; 45h
		dw offset sub_16E1C	; 46h
		dw offset sub_16E7C	; 47h
		dw offset sub_16E96	; 48h
		dw offset sub_16E9D	; 49h
		dw offset sub_16EA4	; 4Ah
		dw offset sub_16EB4	; 4Bh
		dw offset sub_16F4A	; 4Ch
		dw offset sub_16F5A	; 4Dh
		dw offset sub_1703D	; 4Eh
		dw offset cmfB4F_Text	; 4Fh
		dw offset sub_1704C	; 50h
		dw offset sub_17051	; 51h
		dw offset sub_17058	; 52h
		dw offset sub_17073	; 53h
		dw offset sub_170AF	; 54h
		dw offset sub_16FBC	; 55h
		dw offset sub_16FCC	; 56h
		dw offset sub_170C5	; 57h
		dw offset sub_170DC	; 58h
		dw offset sub_17135	; 59h
		dw offset sub_17158	; 5Ah
		dw offset cmfB5B_LoadBGM; 5Bh
		dw offset sub_17199	; 5Ch
		dw offset sub_171A8	; 5Dh
		dw offset sub_171B7	; 5Eh
		dw offset sub_171CE	; 5Fh
		dw offset sub_171D7	; 60h
		dw offset sub_171E6	; 61h
		dw offset sub_171FE	; 62h
		dw offset sub_17216	; 63h
		dw offset sub_17225	; 64h
		dw offset sub_17258	; 65h
		dw offset sub_1725F	; 66h
		dw offset sub_17266	; 67h
		dw offset sub_1726E	; 68h
		dw offset sub_17277	; 69h
		dw offset sub_172C7	; 6Ah
		dw offset sub_172D7	; 6Bh
		dw offset sub_172E6	; 6Ch
		dw offset sub_172F5	; 6Dh
		dw offset sub_172FD	; 6Eh
		dw offset sub_17309	; 6Fh
		dw offset sub_17323	; 70h
		dw offset sub_1732A	; 71h
		dw offset sub_1739B	; 72h
		dw offset sub_173AD	; 73h
		dw offset sub_1741F	; 74h
		dw offset sub_1742E	; 75h
		dw offset sub_17450	; 76h
		dw offset sub_17458	; 77h
		dw offset sub_1745F	; 78h
		dw offset sub_1746B	; 79h
		dw offset sub_17478	; 7Ah
		dw offset sub_17485	; 7Bh
		dw offset sub_174A4	; 7Ch
		dw offset sub_174B4	; 7Dh
		dw offset sub_1751A	; 7Eh
; ---------------------------------------------------------------------------

loc_166F8:				; CODE XREF: CmfMainLoopB+10j
					; CmfMainLoopB+1Fj
		cmp	word ptr es:[bp+12h], 2
		jz	short locret_1671F
		mov	cs:word_16720, 0
		push	si
		push	ds
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		call	sub_176C1
		pop	ds
		assume ds:nothing
		pop	si
		cmp	cs:word_16720, 0
		jz	short locret_1671F
		mov	si, cs:word_16720

locret_1671F:				; CODE XREF: CmfMainLoopB+125j
					; CmfMainLoopB+140j
		retn
CmfMainLoopB	endp

; ---------------------------------------------------------------------------
word_16720	dw 0			; DATA XREF: CmfMainLoopB+127w
					; CmfMainLoopB+13Ar ...

; =============== S U B	R O U T	I N E =======================================


sub_16722	proc near		; CODE XREF: CmfMainLoopB+18p
					; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		mov	word ptr es:[bp+2], 0
		call	sub_180F2
		pop	ax
		clc
		retn
sub_16722	endp ; sp-analysis failed


; =============== S U B	R O U T	I N E =======================================


sub_1672E	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		cmp	ax, 0FFFEh
		jz	short loc_16762
		mov	es:[bp+48h], ax
		and	ax, es:[bp+58h]
		push	si
		push	ds
		call	sub_1BE93
		pop	ds
		pop	si
		mov	ax, cx
		mov	cx, es:[bp+4Ah]
		shl	ax, cl
		shl	dx, cl
		sar	ax, 4
		sar	dx, 4

loc_16753:				; CODE XREF: sub_1672E+68j
		mov	es:[bp+4Ch], ax
		mov	es:[bp+4Eh], dx
		lodsw
		mov	es:[bp+5Ah], ax
		clc
		retn
; ---------------------------------------------------------------------------

loc_16762:				; CODE XREF: sub_1672E+4j
		push	si
		mov	si, cs:word_1EA52
		mov	di, cs:word_1EA56
		mov	cx, es:[bp+4]
		mov	dx, es:[bp+6]
		call	sub_1BF6B
		mov	ax, cx
		pop	si
		and	ax, es:[bp+58h]
		call	sub_1BE93
		mov	ax, cx
		mov	es:[bp+48h], ax
		mov	cx, es:[bp+4Ah]
		shl	ax, cl
		shl	dx, cl
		sar	ax, 4
		sar	dx, 4
		jmp	short loc_16753
sub_1672E	endp


; =============== S U B	R O U T	I N E =======================================


sub_16798	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		sub	ax, ax
		mov	bx, es:[bp+4]
		cmp	cs:word_1EA52, bx
		jnb	short loc_167A8
		mov	ax, 80h	; 'Ä'

loc_167A8:				; CODE XREF: sub_16798+Bj
		and	ax, es:[bp+58h]
		call	sub_1BE93
		mov	ax, cx
		mov	cx, es:[bp+4Ah]
		shl	ax, cl
		shl	dx, cl
		sar	ax, 4
		sar	dx, 4
		mov	es:[bp+4Ch], ax
		mov	es:[bp+4Eh], dx
		lodsw
		mov	es:[bp+5Ah], ax
		clc
		retn
sub_16798	endp


; =============== S U B	R O U T	I N E =======================================


sub_167CE	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		mov	es:[bp+4Ah], ax
		stc
		retn
sub_167CE	endp


; =============== S U B	R O U T	I N E =======================================


cmfB03_Jump	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		mov	si, ax
		stc
		retn
cmfB03_Jump	endp


; =============== S U B	R O U T	I N E =======================================


sub_167DA	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		cmp	word ptr es:[bp+5Ch], 0
		jnz	short loc_167EB
		lodsw
		mov	es:[bp+5Ch], ax
		lodsw
		mov	si, ax
		stc
		retn
; ---------------------------------------------------------------------------

loc_167EB:				; CODE XREF: sub_167DA+5j
		dec	word ptr es:[bp+5Ch]
		lodsw
		lodsw
		cmp	word ptr es:[bp+5Ch], 0
		jz	short loc_167FC
		mov	si, ax
		stc
		retn
; ---------------------------------------------------------------------------

loc_167FC:				; CODE XREF: sub_167DA+1Cj
		stc
		retn
sub_167DA	endp


; =============== S U B	R O U T	I N E =======================================


cmfB05_Wait	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		mov	word ptr es:[bp+4Ch], 0
		mov	word ptr es:[bp+4Eh], 0
		lodsw
		mov	es:[bp+5Ah], ax
		clc
		retn
cmfB05_Wait	endp


; =============== S U B	R O U T	I N E =======================================


sub_16811	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		mov	es:[bp+58h], ax
		stc
		retn
sub_16811	endp


; =============== S U B	R O U T	I N E =======================================


cmfB08_SetSprFrames proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw			; read file pointer
		mov	es:[bp+38h], ax	; set current file position for	"sprite	frames"
		mov	es:[bp+3Ah], ax	; set base file	position for "sprite frames"
		stc
		retn
cmfB08_SetSprFrames endp


; =============== S U B	R O U T	I N E =======================================


sub_16823	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		mov	bx, bp
		add	bx, 8Ah
		lodsw
		mov	es:[bx], ax
		lodsw
		mov	es:[bx+4], ax
		lodsw
		mov	es:[bx+6], ax
		lodsw
		mov	es:[bx+8], ax
		stc
		retn
sub_16823	endp


; =============== S U B	R O U T	I N E =======================================


sub_1683E	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		mov	ax, cs:word_1EA52
		mov	bx, es:[bp+4]
		cmp	word ptr es:[bp+6Bh], 0
		jz	short loc_16857
		push	si
		mov	si, es:[bp+6Bh]
		add	bx, es:[si+4]
		pop	si

loc_16857:				; CODE XREF: sub_1683E+Dj
		add	ax, 280h
		add	bx, 280h
		cmp	bx, ax
		jb	short loc_16865
		lodsw
		stc
		retn
; ---------------------------------------------------------------------------

loc_16865:				; CODE XREF: sub_1683E+22j
		lodsw
		mov	si, ax
		stc
		retn
sub_1683E	endp


; =============== S U B	R O U T	I N E =======================================


sub_1686A	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		mov	cx, es:[bp+4]
		mov	dx, es:[bp+6]
		sub	dx, es:[bp+54h]
		add	cx, es:[bp+50h]
		add	dx, es:[bp+52h]
		call	sub_175B3
		lodsw
		add	cx, ax
		lodsw
		add	dx, ax
		lodsw
		mov	di, ax
		push	cx
		push	dx
		push	si
		push	di
		push	es
		push	ds
		mov	si, cs:word_1EA52
		mov	di, cs:word_1EA56
		call	sub_1BF6B
		mov	bx, cx
		pop	ds
		pop	es
		assume es:nothing
		pop	di
		pop	si
		pop	dx
		pop	cx
		cmp	di, 0FFFFh
		jz	short loc_168AE
		lodsw
		lodsw
		jmp	short loc_168CC
; ---------------------------------------------------------------------------

loc_168AE:				; CODE XREF: sub_1686A+3Ej
		add	bx, 100h
		lodsw
		add	ax, 100h
		cmp	bx, ax
		jnb	short loc_168BF
		sub	ax, 100h
		mov	di, ax

loc_168BF:				; CODE XREF: sub_1686A+4Ej
		lodsw
		add	ax, 100h
		cmp	bx, ax
		jb	short loc_168CC
		sub	ax, 100h
		mov	di, ax

loc_168CC:				; CODE XREF: sub_1686A+42j
					; sub_1686A+5Bj
		lodsw
		push	si
		push	ds
		mov	si, di
		call	sub_18BDE
		pop	ds
		pop	si
		stc
		retn
sub_1686A	endp


; =============== S U B	R O U T	I N E =======================================


sub_168D8	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		mov	es:[bp+1Ah], al
		stc
		retn
sub_168D8	endp


; =============== S U B	R O U T	I N E =======================================


sub_168DF	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		mov	word ptr es:[bp+65h], 1
		lodsw
		mov	es:[bp+67h], ax
		stc
		retn
sub_168DF	endp


; =============== S U B	R O U T	I N E =======================================


sub_168EC	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		cmp	word ptr es:[bp+65h], 0
		jz	short loc_168F6
		sub	si, 2

loc_168F6:				; CODE XREF: sub_168EC+5j
		clc
		retn
sub_168EC	endp


; =============== S U B	R O U T	I N E =======================================


sub_168F8	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		mov	cs:word_16E7A, ax
		lodsw
		mov	cx, ax
		lodsw
		mov	dx, ax
		lodsw
		call	sub_175B3
		add	cx, es:[bp+4]
		add	dx, es:[bp+6]
		call	cmfA_LoadEnemies
		stc
		retn
sub_168F8	endp


; =============== S U B	R O U T	I N E =======================================


cmfB10_MoveMap	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		add	cs:MapPosX, ax
		lodsw
		add	cs:MapPosY, ax
		stc
		retn
cmfB10_MoveMap	endp


; =============== S U B	R O U T	I N E =======================================


cmfB11_SetSprPos proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		mov	es:[bp+4], ax
		shl	ax, 4
		mov	es:[bp+3Ch], ax
		lodsw
		mov	es:[bp+6], ax
		shl	ax, 4
		mov	es:[bp+3Eh], ax
		stc
		retn
cmfB11_SetSprPos endp


; =============== S U B	R O U T	I N E =======================================


sub_1693C	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		mov	es:[bp+0Eh], ax
		stc
		retn
sub_1693C	endp


; =============== S U B	R O U T	I N E =======================================


sub_16943	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		push	si
		push	ds
		mov	bx, ax
		call	bx
		pop	ds
		pop	si
		stc
		retn
sub_16943	endp


; =============== S U B	R O U T	I N E =======================================


cmfB14		proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		mov	es:[bp+40h], ax
		lodsw
		mov	es:[bp+44h], ax
		lodsw
		mov	es:[bp+42h], ax
		lodsw
		mov	es:[bp+46h], ax
		stc
		retn
cmfB14		endp


; =============== S U B	R O U T	I N E =======================================


sub_16964	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		mov	cx, ax
		lodsw
		mov	dx, ax
		lodsw
		call	sub_17EB9
		lodsw
		mov	bx, bp
		add	bx, 74h	; 't'
		add	ax, ax
		add	bx, ax
		mov	ax, cs:word_17F73
		mov	es:[bx], ax
		stc
		retn
sub_16964	endp


; =============== S U B	R O U T	I N E =======================================


sub_16981	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		mov	es:[bp+6Dh], ax
		mov	word ptr es:[bp+6Fh], 1
		stc
		retn
sub_16981	endp


; =============== S U B	R O U T	I N E =======================================


sub_1698E	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		mov	bx, ax
		lodsw
		mov	cx, ax
		lodsw
		mov	dx, ax
		mov	ax, cs:word_1EA52
		sub	ax, es:[bp+4]
		test	ah, 80h
		jz	short loc_169A6
		neg	ax

loc_169A6:				; CODE XREF: sub_1698E+14j
		cmp	ax, bx
		jnb	short loc_169AC
		mov	si, dx

loc_169AC:				; CODE XREF: sub_1698E+1Aj
		mov	ax, cs:word_1EA56
		sub	ax, es:[bp+6]
		test	ah, 80h
		jz	short loc_169BB
		neg	ax

loc_169BB:				; CODE XREF: sub_1698E+29j
		cmp	ax, cx
		jnb	short loc_169C1
		mov	si, dx

loc_169C1:				; CODE XREF: sub_1698E+2Fj
		stc
		retn
sub_1698E	endp


; =============== S U B	R O U T	I N E =======================================


sub_169C3	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		mov	ax, cs:word_1EA56
		mov	bx, es:[bp+6]
		add	ax, 280h
		add	bx, 280h
		cmp	bx, ax
		jb	short loc_169D9
		lodsw
		stc
		retn
; ---------------------------------------------------------------------------

loc_169D9:				; CODE XREF: sub_169C3+11j
		lodsw
		mov	si, ax
		stc
		retn
sub_169C3	endp


; =============== S U B	R O U T	I N E =======================================


sub_169DE	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		mov	es:[bp+5Fh], ax
		lodsw
		mov	es:[bp+61h], ax
		lodsw
		mov	es:[bp+63h], ax
		stc
		retn
sub_169DE	endp


; =============== S U B	R O U T	I N E =======================================


sub_169EF	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		mov	cx, es:[bp+4]
		mov	dx, es:[bp+6]
		call	sub_175B3
		lodsw
		add	cx, ax
		lodsw
		add	dx, ax
		lodsw
		mov	bx, ax
		cmp	bx, 0FFFFh
		jnz	short loc_16A10
		mov	ax, 100h
		call	GetRandomInRange
		mov	bx, ax

loc_16A10:				; CODE XREF: sub_169EF+17j
		lodsw
		push	bx
		call	GetRandomInRange
		pop	bx
		or	ax, ax
		jz	short loc_16A1D
		lodsw
		jmp	short loc_16A27
; ---------------------------------------------------------------------------

loc_16A1D:				; CODE XREF: sub_169EF+29j
		lodsw
		push	si
		push	ds
		mov	si, bx
		call	sub_15EF8
		pop	ds
		pop	si

loc_16A27:				; CODE XREF: sub_169EF+2Cj
		stc
		retn
sub_169EF	endp


; =============== S U B	R O U T	I N E =======================================


sub_16A29	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		mov	es:[bp+71h], al
		stc
		retn
sub_16A29	endp


; =============== S U B	R O U T	I N E =======================================


sub_16A30	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		push	si
		push	ds
		mov	si, es:[bp+6Bh]
		mov	es:[si+0Eh], ax
		pop	ds
		pop	si
		stc
		retn
sub_16A30	endp


; =============== S U B	R O U T	I N E =======================================


sub_16A3F	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		push	si
		mov	cx, es:[bp+4]
		mov	dx, es:[bp+6]
		call	sub_175B3
		mov	si, cs:word_1EA52
		mov	di, cs:word_1EA56
		call	sub_1BF6B
		pop	si
		lodsw
		mov	bx, ax
		lodsw
		cmp	cx, bx
		jb	short loc_16A6A
		cmp	cx, ax
		jnb	short loc_16A6A
		lodsw
		mov	si, ax
		stc
		retn
; ---------------------------------------------------------------------------

loc_16A6A:				; CODE XREF: sub_16A3F+20j
					; sub_16A3F+24j
		lodsw
		stc
		retn
sub_16A3F	endp


; =============== S U B	R O U T	I N E =======================================


cmfB1E_Thing_Wait proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		mov	es:[bp+4Ch], ax
		lodsw
		mov	es:[bp+4Eh], ax
		lodsw
		mov	es:[bp+5Ah], ax	; set wait countdown
		clc
		retn
cmfB1E_Thing_Wait endp


; =============== S U B	R O U T	I N E =======================================


sub_16A7E	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		mov	bx, bp
		add	bx, 74h	; 't'
		add	ax, ax
		add	bx, ax
		mov	ax, es:[bx]
		mov	bx, ax
		lodsw
		add	es:[bx+3Ch], ax
		mov	ax, es:[bx+3Ch]
		sar	ax, 4
		mov	es:[bx+4], ax
		lodsw
		add	es:[bx+3Eh], ax
		mov	ax, es:[bx+3Eh]
		sar	ax, 4
		mov	es:[bx+6], ax
		lodsw
		mov	es:[bx+32h], ax
		stc
		retn
sub_16A7E	endp


; =============== S U B	R O U T	I N E =======================================


sub_16AB4	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		mov	es:[bp+72h], al
		stc
		retn
sub_16AB4	endp


; =============== S U B	R O U T	I N E =======================================


sub_16ABB	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		mov	es:[bp+73h], al
		stc
		retn
sub_16ABB	endp


; =============== S U B	R O U T	I N E =======================================


cmfB22_Thing_Wait proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		mov	ax, es:[bp+48h]
		and	ax, es:[bp+58h]
		push	si
		push	ds
		call	sub_1BE93
		pop	ds
		pop	si
		mov	ax, cx
		mov	cx, es:[bp+4Ah]
		shl	ax, cl
		shl	dx, cl
		sar	ax, 4
		sar	dx, 4
		mov	es:[bp+4Ch], ax
		mov	es:[bp+4Eh], dx
		lodsw
		mov	es:[bp+5Ah], ax
		clc
		retn
cmfB22_Thing_Wait endp


; =============== S U B	R O U T	I N E =======================================


sub_16AF0	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		mov	es:[bp+48h], ax
		stc
		retn
sub_16AF0	endp


; =============== S U B	R O U T	I N E =======================================


sub_16AF7	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		cmp	ax, 0
		jz	short loc_16B0C
		cmp	ax, 1
		jz	short loc_16B22
		cmp	ax, 2
		jz	short loc_16B38
		cmp	ax, 3
		jz	short loc_16B4E

loc_16B0C:				; CODE XREF: sub_16AF7+4j
		mov	bx, es:[bp+48h]
		add	bx, 4
		shr	bx, 4
		and	bx, 0Fh
		lodsw
		add	bx, ax
		mov	es:[bp+32h], bx
		stc
		retn
; ---------------------------------------------------------------------------

loc_16B22:				; CODE XREF: sub_16AF7+9j
		mov	bx, es:[bp+48h]
		add	bx, 4
		shr	bx, 3
		and	bx, 1Fh
		lodsw
		add	bx, ax
		mov	es:[bp+32h], bx
		stc
		retn
; ---------------------------------------------------------------------------

loc_16B38:				; CODE XREF: sub_16AF7+Ej
		mov	bx, es:[bp+48h]
		add	bx, 0Fh
		shr	bx, 5
		and	bx, 7
		lodsw
		add	bx, ax
		mov	es:[bp+32h], bx
		stc
		retn
; ---------------------------------------------------------------------------

loc_16B4E:				; CODE XREF: sub_16AF7+13j
		mov	bx, es:[bp+48h]
		add	bx, 8
		shr	bx, 4
		and	bx, 7
		lodsw
		add	bx, ax
		mov	es:[bp+32h], bx
		stc
		retn
sub_16AF7	endp


; =============== S U B	R O U T	I N E =======================================


sub_16B64	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		push	si
		mov	si, cs:word_1EA52
		mov	di, cs:word_1EA56
		add	si, 20h	; ' '
		add	di, 10h
		mov	cx, es:[bp+4]
		mov	dx, es:[bp+6]
		call	sub_175B3
		call	sub_1BF6B
		pop	si
		mov	bx, es:[bp+48h]
		mov	ax, 80h	; 'Ä'
		sub	al, bl
		add	bl, al
		add	cl, al
		lodsw
		cmp	cl, 80h	; 'Ä'
		jz	short loc_16BAF
		jnb	short loc_16BA5
		mov	bx, es:[bp+48h]
		sub	bx, ax
		mov	es:[bp+48h], bx
		jmp	short loc_16BAF
; ---------------------------------------------------------------------------

loc_16BA5:				; CODE XREF: sub_16B64+33j
		mov	bx, es:[bp+48h]
		add	bx, ax
		mov	es:[bp+48h], bx

loc_16BAF:				; CODE XREF: sub_16B64+31j
					; sub_16B64+3Fj
		stc
		retn
sub_16B64	endp


; =============== S U B	R O U T	I N E =======================================


cmfB26_Thing_Wait proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		mov	ax, es:[bp+48h]
		and	ax, es:[bp+58h]
		push	si
		push	ds
		call	sub_1BE93
		pop	ds
		pop	si
		mov	ax, cx
		mov	cx, es:[bp+4Ah]
		shl	ax, cl
		shl	dx, cl
		sar	ax, 4
		sar	dx, 4
		add	ax, es:[bp+4Ch]
		add	dx, es:[bp+4Eh]
		mov	cx, ax
		mov	bx, cx
		test	ch, 80h
		jz	short loc_16BE3
		neg	bx

loc_16BE3:				; CODE XREF: cmfB26_Thing_Wait+2Ej
		lodsw
		cmp	bx, ax
		jb	short loc_16BEA
		mov	bx, ax

loc_16BEA:				; CODE XREF: cmfB26_Thing_Wait+35j
		test	ch, 80h
		jz	short loc_16BF1
		neg	bx

loc_16BF1:				; CODE XREF: cmfB26_Thing_Wait+3Cj
		mov	cx, bx
		mov	bx, dx
		test	dh, 80h
		jz	short loc_16BFC
		neg	bx

loc_16BFC:				; CODE XREF: cmfB26_Thing_Wait+47j
		lodsw
		cmp	bx, ax
		jb	short loc_16C03
		mov	bx, ax

loc_16C03:				; CODE XREF: cmfB26_Thing_Wait+4Ej
		test	dh, 80h
		jz	short loc_16C0A
		neg	bx

loc_16C0A:				; CODE XREF: cmfB26_Thing_Wait+55j
		mov	dx, bx
		mov	es:[bp+4Ch], cx
		mov	es:[bp+4Eh], dx
		lodsw
		mov	es:[bp+5Ah], ax	; set wait time
		clc
		retn
cmfB26_Thing_Wait endp


; =============== S U B	R O U T	I N E =======================================


sub_16C1B	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		mov	bx, bp
		add	bx, 74h	; 't'
		add	ax, ax
		add	bx, ax
		mov	ax, es:[bx]
		mov	bx, ax
		lodsw
		cmp	word ptr es:[bx+2], 0
		jz	short loc_16C3D
		mov	es:[bx+88h], ax
		mov	word ptr es:[bx+5Ah], 0

loc_16C3D:				; CODE XREF: sub_16C1B+15j
		stc
		retn
sub_16C1B	endp


; =============== S U B	R O U T	I N E =======================================


sub_16C3F	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		mov	ax, cs:word_1EA52
		mov	es:[bp+4], ax
		shl	ax, 4
		mov	es:[bp+3Ch], ax
		stc
		retn
sub_16C3F	endp


; =============== S U B	R O U T	I N E =======================================


sub_16C50	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		push	si
		push	ds
		mov	bx, es:[bp+4]
		lodsw
		cmp	bx, ax
		jb	short loc_16C78
		lodsw
		cmp	bx, ax
		jnb	short loc_16C78
		mov	bx, es:[bp+6]
		lodsw
		cmp	bx, ax
		jb	short loc_16C78
		lodsw
		cmp	bx, ax
		jnb	short loc_16C78
		pop	ds
		pop	si
		add	si, 8
		lodsw
		mov	si, ax
		stc
		retn
; ---------------------------------------------------------------------------

loc_16C78:				; CODE XREF: sub_16C50+9j sub_16C50+Ej ...
		pop	ds
		pop	si
		add	si, 8
		lodsw
		stc
		retn
sub_16C50	endp


; =============== S U B	R O U T	I N E =======================================


sub_16C80	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		call	sub_182E0
		stc
		retn
sub_16C80	endp


; =============== S U B	R O U T	I N E =======================================


cmfB2B_DoHDF	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		push	si
		push	ds
		call	cmfB_DoSomethingHDF
		pop	ds
		pop	si
		stc
		retn
cmfB2B_DoHDF	endp


; =============== S U B	R O U T	I N E =======================================


cmfB2C		proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw			; same as cmfB14, except that it also writes to	+50h/+52h
		mov	es:[bp+40h], ax
		lodsw
		mov	es:[bp+44h], ax
		lodsw
		mov	es:[bp+42h], ax
		lodsw
		mov	es:[bp+46h], ax
		lodsw
		mov	es:[bp+50h], ax
		lodsw
		mov	es:[bp+52h], ax
		stc
		retn
cmfB2C		endp


; =============== S U B	R O U T	I N E =======================================


sub_16CAF	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		mov	es:[bp+24h], ax
		stc
		retn
sub_16CAF	endp


; =============== S U B	R O U T	I N E =======================================


sub_16CB6	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		mov	es:[bp+26h], ax
		mov	es:[bp+28h], ax
		mov	word ptr es:[bp+2Ah], 1
		stc
		retn
sub_16CB6	endp


; =============== S U B	R O U T	I N E =======================================


sub_16CC7	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		mov	es:[bp+1Bh], ax
		stc
		retn
sub_16CC7	endp


; =============== S U B	R O U T	I N E =======================================


sub_16CCE	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		mov	es:[bp+22h], al
		stc
		retn
sub_16CCE	endp


; =============== S U B	R O U T	I N E =======================================


sub_16CD5	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		call	sub_189AF
		stc
		retn
sub_16CD5	endp


; =============== S U B	R O U T	I N E =======================================


sub_16CDB	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		mov	es:[bp+1Ah], al
		mov	word ptr es:[bp+54h], 0
		stc
		retn
sub_16CDB	endp


; =============== S U B	R O U T	I N E =======================================


sub_16CE8	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		mov	es:[bp+5Eh], al
		stc
		retn
sub_16CE8	endp


; =============== S U B	R O U T	I N E =======================================


cmfB34_HDF_GfxInc proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		mov	es:[bp+56h], al	; set HDF graphic step increment
		mov	byte ptr es:[bp+57h], 0
		stc
		retn
cmfB34_HDF_GfxInc endp


; =============== S U B	R O U T	I N E =======================================


sub_16CFB	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		mov	es:[bp+36h], ax
		stc
		retn
sub_16CFB	endp


; =============== S U B	R O U T	I N E =======================================


sub_16D02	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		mov	es:[bp+5Fh], ax
		stc
		retn
sub_16D02	endp


; =============== S U B	R O U T	I N E =======================================


sub_16D09	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		mov	cs:word_1EA54, ax
		lodsw
		mov	cs:word_1EA58, ax
		stc
		retn
sub_16D09	endp


; =============== S U B	R O U T	I N E =======================================


sub_16D15	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		push	si
		push	es
		push	ds
		call	sub_13EE7
		pop	ds
		pop	es
		pop	si
		stc
		retn
sub_16D15	endp


; =============== S U B	R O U T	I N E =======================================


sub_16D21	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		push	si
		push	es
		push	ds
		mov	bx, ax
		push	bx
		mov	cx, es:[bp+4]
		mov	dx, es:[bp+6]
		call	sub_175B3
		pop	bx
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		shl	bx, 1
		call	cs:off_16D45[bx]
		pop	ds
		assume ds:nothing
		pop	es
		pop	si
		stc
		retn
sub_16D21	endp

; ---------------------------------------------------------------------------
off_16D45	dw offset sub_15D8C	; DATA XREF: sub_16D21+1Ar
		dw offset sub_15E30
		dw offset sub_18A8A
		dw offset sub_18A2D
		dw offset sub_18ADA
		dw offset sub_18B2A

; =============== S U B	R O U T	I N E =======================================


cmfB3A_TextWait	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		mov	es:[bp+5Ah], ax	; set wait time
		lodsw			; load text pointer
		push	si
		push	es
		push	ds
		mov	si, ax
		call	cmfLoadText3A
		pop	ds
		pop	es
		pop	si
		stc
		retn
cmfB3A_TextWait	endp


; =============== S U B	R O U T	I N E =======================================


cmfB4F_Text	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw			; read ignored word
		mov	word ptr es:[bp+5Ah], 0	; wait time = 0
		lodsw
		push	si
		push	es
		push	ds
		mov	si, ax
		call	cmfLoadText4F
		pop	ds
		pop	es
		pop	si
		stc
		retn
cmfB4F_Text	endp


; =============== S U B	R O U T	I N E =======================================


sub_16D79	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		mov	es:[bp+12h], ax
		stc
		retn
sub_16D79	endp


; =============== S U B	R O U T	I N E =======================================


sub_16D80	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		mov	cs:word_12F33, ax
		stc
		retn
sub_16D80	endp


; =============== S U B	R O U T	I N E =======================================


sub_16D87	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		mov	es:[bp+14h], ax
		lodsw
		mov	es:[bp+16h], ax
		lodsw
		mov	es:[bp+18h], ax
		stc
		retn
sub_16D87	endp


; =============== S U B	R O U T	I N E =======================================


sub_16D98	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		mov	cs:word_111E7, ax
		stc
		retn
sub_16D98	endp


; =============== S U B	R O U T	I N E =======================================


sub_16D9F	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		mov	cs:word_1BDF8, ax
		lodsw
		mov	cs:word_1BDFE, ax
		lodsw
		mov	cs:word_1BDFA, ax
		lodsw
		mov	cs:word_1BE00, ax
		stc
		retn
sub_16D9F	endp


; =============== S U B	R O U T	I N E =======================================


sub_16DB5	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		mov	cs:word_111E9, ax
		lodsw
		mov	cs:word_111EB, ax
		stc
		retn
sub_16DB5	endp


; =============== S U B	R O U T	I N E =======================================


sub_16DC1	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		push	es
		push	ds
		push	bp
		call	cmfA07_LoadHDF
		pop	bp
		pop	ds
		pop	es
		stc
		retn
sub_16DC1	endp


; =============== S U B	R O U T	I N E =======================================


sub_16DCC	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		push	es
		push	ds
		call	cmfA08_FreeHDF
		pop	ds
		pop	es
		stc
		retn
sub_16DCC	endp


; =============== S U B	R O U T	I N E =======================================


cmdB43_CondJump	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		mov	ax, 100
		call	GetRandomInRange
		mov	bx, ax
		lodsw
		cmp	bx, ax
		jnb	short loc_16DE7
		lodsw
		mov	si, ax
		stc
		retn
; ---------------------------------------------------------------------------

loc_16DE7:				; CODE XREF: cmdB43_CondJump+Bj
		lodsw
		stc
		retn
cmdB43_CondJump	endp


; =============== S U B	R O U T	I N E =======================================


sub_16DEA	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		inc	ax
		call	GetRandomInRange
		mov	es:[bp+4], ax
		shl	ax, 4
		mov	es:[bp+3Ch], ax
		lodsw
		inc	ax
		call	GetRandomInRange
		mov	es:[bp+6], ax
		shl	ax, 4
		mov	es:[bp+3Eh], ax
		stc
		retn
sub_16DEA	endp


; =============== S U B	R O U T	I N E =======================================


sub_16E0C	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		shl	ax, 4
		mov	cs:word_16E76, ax
		lodsw
		shl	ax, 4
		mov	cs:word_16E78, ax
sub_16E0C	endp ; sp-analysis failed


; =============== S U B	R O U T	I N E =======================================


sub_16E1C	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		mov	bx, ax
		lodsw
		mov	cs:word_16E7A, ax
		push	bx
		push	si
		push	ds
		call	sub_1BE93
		pop	ds
		pop	si
		pop	bx
		mov	ax, cx
		mov	cx, bx
		shl	ax, cl
		shl	dx, cl
		sar	ax, 2
		sar	dx, 2
		mov	bx, dx
		push	ax
		lodsw
		mov	cx, ax
		lodsw
		mov	di, ax
		pop	ax
		push	si
		push	es
		push	ds

loc_16E48:				; CODE XREF: sub_16E1C+53j
		push	cx
		add	cs:word_16E76, ax
		add	cs:word_16E78, bx
		push	ax
		push	bx
		mov	ax, di
		mov	cx, cs:word_16E76
		mov	dx, cs:word_16E78
		sar	cx, 4
		sar	dx, 4
		push	di
		call	sub_17EB9
		pop	di
		pop	bx
		pop	ax
		pop	cx
		loop	loc_16E48
		pop	ds
		pop	es
		pop	si
		stc
		retn
sub_16E1C	endp

; ---------------------------------------------------------------------------
word_16E76	dw 0			; DATA XREF: sub_16E0C+4w
					; sub_16E1C+2Dw ...
word_16E78	dw 0			; DATA XREF: sub_16E0C+Cw
					; sub_16E1C+32w ...
word_16E7A	dw 0			; DATA XREF: sub_168F8+1w sub_16E1C+4w ...

; =============== S U B	R O U T	I N E =======================================


sub_16E7C	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		add	es:[bp+4], ax
		shl	ax, 4
		add	es:[bp+3Ch], ax
		lodsw
		add	es:[bp+6], ax
		shl	ax, 4
		add	es:[bp+3Eh], ax
		stc
		retn
sub_16E7C	endp


; =============== S U B	R O U T	I N E =======================================


sub_16E96	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		mov	es:[bp+10h], ax
		stc
		retn
sub_16E96	endp


; =============== S U B	R O U T	I N E =======================================


sub_16E9D	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		mov	cs:word_11579, ax
		stc
		retn
sub_16E9D	endp


; =============== S U B	R O U T	I N E =======================================


sub_16EA4	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		shl	ax, 4
		mov	cs:word_175AF, ax
		lodsw
		shl	ax, 4
		mov	cs:word_175B1, ax
sub_16EA4	endp ; sp-analysis failed


; =============== S U B	R O U T	I N E =======================================


sub_16EB4	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		push	si
		push	di
		push	es
		push	ds
		mov	ax, cs
		mov	ds, ax
		assume ds:seg000
		mov	es, ax
		assume es:seg000
		mov	si, (offset byte_1756D+2)
		mov	di, offset byte_1756D
		mov	cx, 1Fh
		rep movsw
		pop	ds
		assume ds:nothing
		pop	es
		assume es:nothing
		pop	di
		pop	si
		lodsw
		mov	cs:word_175AD, ax
		mov	bx, ax
		lodsw
		mov	cs:word_1758B, ax
		push	ax
		lodsw
		mov	cx, ax
		lodsw
		mov	di, ax
		pop	ax
		push	si
		push	es
		push	ds
		mov	bx, offset byte_1756D
		add	bx, 1Eh

loc_16EEA:				; CODE XREF: sub_16EB4+8Fj
		push	cx
		push	bx
		mov	ax, cs:[bx]
		mov	cs:word_16E7A, ax
		push	bx
		push	si
		push	ds
		call	sub_1BE93
		pop	ds
		pop	si
		pop	bx
		mov	bx, cs:word_175AD
		push	dx
		mov	ax, cx
		mul	bx
		mov	cx, ax
		pop	dx
		mov	ax, dx
		mul	bx
		mov	dx, ax
		mov	ax, cx
		mov	bx, dx
		sar	ax, 4
		sar	bx, 4
		add	cs:word_175AF, ax
		add	cs:word_175B1, bx
		push	ax
		push	bx
		mov	ax, di
		mov	cx, cs:word_175AF
		mov	dx, cs:word_175B1
		sar	cx, 4
		sar	dx, 4
		push	di
		call	sub_17EB9
		pop	di
		pop	bx
		pop	ax
		pop	bx
		pop	cx
		sub	bx, 2
		loop	loc_16EEA
		pop	ds
		pop	es
		pop	si
		stc
		retn
sub_16EB4	endp


; =============== S U B	R O U T	I N E =======================================


sub_16F4A	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		shl	ax, 4
		mov	cs:word_16E76, ax
		lodsw
		shl	ax, 4
		mov	cs:word_16E78, ax
sub_16F4A	endp ; sp-analysis failed


; =============== S U B	R O U T	I N E =======================================


sub_16F5A	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		mov	bx, ax
		lodsw
		mov	cs:word_16E7A, ax
		push	bx
		push	si
		push	ds
		call	sub_1BE93
		pop	ds
		pop	si
		pop	bx
		push	dx
		mov	ax, cx
		mul	bx
		mov	cx, ax
		pop	dx
		mov	ax, dx
		mul	bx
		mov	dx, ax
		sar	cx, 2
		sar	dx, 2
		mov	ax, cx
		mov	bx, dx
		push	ax
		lodsw
		mov	cx, ax
		lodsw
		mov	di, ax
		pop	ax
		push	si
		push	es
		push	ds

loc_16F8E:				; CODE XREF: sub_16F5A+5Bj
		push	cx
		add	cs:word_16E76, ax
		add	cs:word_16E78, bx
		push	ax
		push	bx
		mov	ax, di
		mov	cx, cs:word_16E76
		mov	dx, cs:word_16E78
		sar	cx, 4
		sar	dx, 4
		push	di
		call	sub_17EB9
		pop	di
		pop	bx
		pop	ax
		pop	cx
		loop	loc_16F8E
		pop	ds
		pop	es
		pop	si
		stc
		retn
sub_16F5A	endp


; =============== S U B	R O U T	I N E =======================================


sub_16FBC	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		shl	ax, 4
		mov	cs:word_16E76, ax
		lodsw
		shl	ax, 4
		mov	cs:word_16E78, ax
sub_16FBC	endp ; sp-analysis failed


; =============== S U B	R O U T	I N E =======================================


sub_16FCC	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		mov	bx, ax
		lodsw
		mov	ax, es:[bp+48h]
		mov	cs:word_16E7A, ax
		push	bx
		push	si
		push	ds
		call	sub_1BE93
		pop	ds
		pop	si
		pop	bx
		push	dx
		mov	ax, cx
		mul	bx
		mov	cx, ax
		pop	dx
		mov	ax, dx
		mul	bx
		mov	dx, ax
		sar	cx, 5
		sar	dx, 5
		mov	ax, cx
		mov	bx, dx
		push	ax
		lodsw
		mov	cx, ax
		lodsw
		mov	di, ax
		pop	ax
		push	si
		push	es
		push	ds

loc_17004:				; CODE XREF: sub_16FCC+6Aj
		push	cx
		add	cs:word_16E76, ax
		add	cs:word_16E78, bx
		push	ax
		push	bx
		mov	ax, di
		mov	cx, cs:word_16E76
		mov	dx, cs:word_16E78
		sar	cx, 4
		sar	dx, 4
		add	cx, es:[bp+4]
		add	dx, es:[bp+6]
		call	sub_175B3
		push	di
		call	cmfA_LoadEnemies
		pop	di
		pop	bx
		pop	ax
		pop	cx
		loop	loc_17004
		pop	ds
		pop	es
		pop	si
		stc
		retn
sub_16FCC	endp


; =============== S U B	R O U T	I N E =======================================


sub_1703D	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		cmp	es:[bp+26h], ax
		jb	short loc_17047
		lodsw
		stc
		retn
; ---------------------------------------------------------------------------

loc_17047:				; CODE XREF: sub_1703D+5j
		lodsw
		mov	si, ax
		stc
		retn
sub_1703D	endp


; =============== S U B	R O U T	I N E =======================================


sub_1704C	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		call	sub_175F0
		stc
		retn
sub_1704C	endp


; =============== S U B	R O U T	I N E =======================================


sub_17051	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		mov	es:[bp+23h], al
		stc
		retn
sub_17051	endp


; =============== S U B	R O U T	I N E =======================================


sub_17058	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		mov	ax, es:[bp+24h]
		push	bp
		push	si
		push	es
		push	ds
		mov	bx, seg	seg001
		mov	ds, bx
		assume ds:seg001
		call	sub_11C1C
		pop	ds
		assume ds:nothing
		pop	es
		pop	si
		pop	bp
		mov	byte ptr es:[bp+1Eh], 1
		stc
		retn
sub_17058	endp


; =============== S U B	R O U T	I N E =======================================


sub_17073	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		push	bp
		push	si
		push	es
		push	ds
		mov	bx, seg	seg001
		mov	ds, bx
		assume ds:seg001
		cmp	byte ptr ds:[bp+5Eh], 0
		jz	short loc_170A9
		mov	cx, ds:[bp+4]
		mov	dx, ds:[bp+6]
		add	cx, ds:[bp+40h]
		mov	ax, ds:[bp+42h]
		shr	ax, 1
		add	cx, ax
		add	dx, ds:[bp+44h]
		mov	ax, ds:[bp+46h]
		shr	ax, 1
		add	dx, ax
		mov	ax, 7
		call	sub_14567

loc_170A9:				; CODE XREF: sub_17073+Ej
		pop	ds
		assume ds:nothing
		pop	es
		pop	si
		pop	bp
		stc
		retn
sub_17073	endp


; =============== S U B	R O U T	I N E =======================================


sub_170AF	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		mov	ax, es:[bp+24h]
		push	bp
		push	si
		push	es
		push	ds
		mov	bx, seg	seg001
		mov	ds, bx
		assume ds:seg001
		call	sub_11C1C
		pop	ds
		assume ds:nothing
		pop	es
		pop	si
		pop	bp
		stc
		retn
sub_170AF	endp


; =============== S U B	R O U T	I N E =======================================


sub_170C5	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		mov	cx, es:[bp+4]
		mov	dx, es:[bp+6]
		call	sub_175B3
		mov	cs:word_1EA52, cx
		mov	cs:word_1EA56, dx
		stc
		retn
sub_170C5	endp


; =============== S U B	R O U T	I N E =======================================


sub_170DC	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		mov	bx, ax
		lodsw
		mov	cx, ax
		lodsw
		mov	dx, ax
		mov	ax, cs:word_1EA52
		sub	ax, es:[bp+4]
		cmp	word ptr es:[bp+6Bh], 0
		jz	short loc_170FE
		push	si
		mov	si, es:[bp+6Bh]
		sub	ax, es:[si+4]
		pop	si

loc_170FE:				; CODE XREF: sub_170DC+16j
		test	ah, 80h
		jz	short loc_17105
		neg	ax

loc_17105:				; CODE XREF: sub_170DC+25j
		cmp	ax, bx
		jnb	short loc_17133
		mov	ax, cs:word_1EA56
		sub	ax, es:[bp+6]
		cmp	word ptr es:[bp+6Bh], 0
		jz	short loc_17126
		push	si
		mov	si, es:[bp+6Bh]
		sub	ax, es:[si+6]
		add	ax, es:[si+54h]
		pop	si

loc_17126:				; CODE XREF: sub_170DC+3Aj
		test	ah, 80h
		jz	short loc_1712D
		neg	ax

loc_1712D:				; CODE XREF: sub_170DC+4Dj
		cmp	ax, cx
		jnb	short loc_17133
		mov	si, dx

loc_17133:				; CODE XREF: sub_170DC+2Bj
					; sub_170DC+53j
		stc
		retn
sub_170DC	endp


; =============== S U B	R O U T	I N E =======================================


sub_17135	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		push	si
		mov	si, cs:word_1EA52
		mov	di, cs:word_1EA56
		add	si, 20h	; ' '
		add	di, 10h
		mov	cx, es:[bp+4]
		mov	dx, es:[bp+6]
		call	sub_1BF6B
		pop	si
		mov	es:[bp+48h], cx
		stc
		retn
sub_17135	endp


; =============== S U B	R O U T	I N E =======================================


sub_17158	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		mov	cs:word_1756B, ax
		lodsw
		mov	cx, ax
		lodsw
		mov	dx, ax
		lodsw
		call	sub_175B3
		add	cx, es:[bp+4]
		add	dx, es:[bp+6]
		call	sub_17E0C
		stc
		retn
sub_17158	endp


; =============== S U B	R O U T	I N E =======================================


cmfB5B_LoadBGM	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		push	es
		push	ds
		pusha
		push	si
		push	ds
		mov	dx, 0
		call	Music_Stop
		pop	ds
		pop	si
		sub	di, di
		call	Music_Load
		sub	si, si
		mov	dx, 0
		call	Music_Start
		popa
		pop	ds
		pop	es
		cld

loc_17192:				; CODE XREF: cmfB5B_LoadBGM+21j
		lodsb
		or	al, al
		jnz	short loc_17192
		stc
		retn
cmfB5B_LoadBGM	endp


; =============== S U B	R O U T	I N E =======================================


sub_17199	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		mov	cs:byte_12237, 0
		mov	cs:word_12235, 7
		clc
		retn
sub_17199	endp


; =============== S U B	R O U T	I N E =======================================


sub_171A8	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		mov	bx, ax
		shl	bx, 1
		add	bx, 8B8Dh
		lodsw
		mov	cs:[bx], ax
		stc
		retn
sub_171A8	endp


; =============== S U B	R O U T	I N E =======================================


sub_171B7	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		mov	bx, ax
		shl	bx, 1
		add	bx, 8B8Dh
		lodsw
		cmp	cs:[bx], ax
		jz	short loc_171C9
		lodsw
		stc
		retn
; ---------------------------------------------------------------------------

loc_171C9:				; CODE XREF: sub_171B7+Dj
		lodsw
		mov	si, ax
		stc
		retn
sub_171B7	endp


; =============== S U B	R O U T	I N E =======================================


sub_171CE	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		mov	cs:word_111ED, 1
		stc
		retn
sub_171CE	endp


; =============== S U B	R O U T	I N E =======================================


sub_171D7	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		mov	cs:word_12235, 8
		mov	cs:byte_12237, 10h
		stc
		retn
sub_171D7	endp


; =============== S U B	R O U T	I N E =======================================


sub_171E6	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		sub	ax, cs:MapPosX
		sub	ax, cs:BasePosX
		mov	es:[bp+4], ax
		shl	ax, 4
		mov	es:[bp+3Ch], ax
		stc
		retn
sub_171E6	endp


; =============== S U B	R O U T	I N E =======================================


sub_171FE	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		sub	ax, cs:MapPosY
		sub	ax, cs:BasePosY
		mov	es:[bp+6], ax
		shl	ax, 4
		mov	es:[bp+3Eh], ax
		stc
		retn
sub_171FE	endp


; =============== S U B	R O U T	I N E =======================================


sub_17216	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		mov	bx, es:[bp+32h]
		cmp	bx, ax
		jb	short loc_17223
		mov	es:[bp+32h], ax

loc_17223:				; CODE XREF: sub_17216+7j
		stc
		retn
sub_17216	endp


; =============== S U B	R O U T	I N E =======================================


sub_17225	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		push	si
		mov	si, cs:word_1EA52
		mov	di, cs:word_1EA56
		add	si, 20h
		add	di, 10h
		mov	cx, es:[bp+4]
		mov	dx, es:[bp+6]
		call	sub_1BF6B
		pop	si
		mov	bx, es:[bp+48h]
		shr	cx, 4
		shr	bx, 4
		cmp	cx, bx
		jz	short loc_17255
		lodsw
		mov	si, ax
		stc
		retn
; ---------------------------------------------------------------------------

loc_17255:				; CODE XREF: sub_17225+29j
		lodsw
		stc
		retn
sub_17225	endp


; =============== S U B	R O U T	I N E =======================================


sub_17258	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		mov	cs:word_1EA76, ax
		stc
		retn
sub_17258	endp


; =============== S U B	R O U T	I N E =======================================


sub_1725F	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		mov	cs:word_111F1, ax
		stc
		retn
sub_1725F	endp


; =============== S U B	R O U T	I N E =======================================


sub_17266	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		mov	es:[bp+95h], al
		stc
		retn
sub_17266	endp


; =============== S U B	R O U T	I N E =======================================


sub_1726E	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		mov	cs:word_111EF, 1
		stc
		retn
sub_1726E	endp


; =============== S U B	R O U T	I N E =======================================


sub_17277	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		mov	es:[bp+96h], ax
		cmp	ax, 0
		jz	short loc_172C5
		lodsw
		mov	bx, ax
		lodsw
		mov	cx, ax
		mov	di, 7543h
		dec	cx

loc_1728C:				; CODE XREF: sub_17277+32j
		push	cx
		push	bx
		mov	ax, bx
		mov	cx, es:[bp+4]
		mov	dx, es:[bp+6]
		push	di
		call	cmfA_LoadEnemies
		pop	di
		mov	ax, cs:word_17E02
		mov	cs:[di], ax
		pop	bx
		pop	cx
		add	di, 2
		loop	loc_1728C
		mov	ax, bx
		inc	ax
		mov	cx, es:[bp+4]
		mov	dx, es:[bp+6]
		push	di
		call	cmfA_LoadEnemies
		pop	di
		mov	ax, cs:word_17E02
		mov	cs:[di], ax
		add	di, 2

loc_172C5:				; CODE XREF: sub_17277+9j
		stc
		retn
sub_17277	endp


; =============== S U B	R O U T	I N E =======================================


sub_172C7	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		mov	ax, es:[bp+48h]
		add	ax, 80h	; 'Ä'
		and	ax, 0FFh
		mov	es:[bp+48h], ax
		stc
		retn
sub_172C7	endp


; =============== S U B	R O U T	I N E =======================================


sub_172D7	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		mov	bx, ax
		shl	bx, 1
		add	bx, 8B8Dh
		lodsw
		add	cs:[bx], ax
		stc
		retn
sub_172D7	endp


; =============== S U B	R O U T	I N E =======================================


sub_172E6	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		mov	ax, 100h
		call	GetRandomInRange
		and	ax, 0FFh
		mov	es:[bp+48h], ax
		stc
		retn
sub_172E6	endp


; =============== S U B	R O U T	I N E =======================================


sub_172F5	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		mov	cs:byte_1018C, 0FFh
		stc
		retn
sub_172F5	endp


; =============== S U B	R O U T	I N E =======================================


sub_172FD	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		mov	cs:word_1753F, ax
		lodsw
		mov	cs:word_17541, ax
		stc
		retn
sub_172FD	endp


; =============== S U B	R O U T	I N E =======================================


sub_17309	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		mov	ax, cs:word_1EA60
		cmp	ax, 17Ch
		jnz	short loc_17315
		mov	ax, 3E8h

loc_17315:				; CODE XREF: sub_17309+7j
		mov	dx, 0
		mov	bx, 0Ah
		div	bx
		mov	cs:LifeBonus, ax
		stc
		retn
sub_17309	endp


; =============== S U B	R O U T	I N E =======================================


sub_17323	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		mov	cs:word_12FAB, ax
		stc
		retn
sub_17323	endp


; =============== S U B	R O U T	I N E =======================================


sub_1732A	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		mov	bx, ax
		lodsw
		mov	di, ax
		push	bx
		push	di
		mov	ax, bx
		mov	bx, di
		mov	cx, es:[bp+4]
		mov	dx, es:[bp+6]
		sar	ax, 4
		sar	bx, 3
		sar	cx, 4
		sar	dx, 3
		cmp	cx, ax
		jnz	short loc_17356
		cmp	dx, bx
		jnz	short loc_17356
		pop	di
		pop	bx
		jmp	short loc_17399
; ---------------------------------------------------------------------------

loc_17356:				; CODE XREF: sub_1732A+22j
					; sub_1732A+26j
		pop	di
		pop	bx
		push	si
		push	ds
		mov	si, bx
		mov	cx, es:[bp+4]
		mov	dx, es:[bp+6]
		call	sub_1BF6B
		mov	ax, cx
		and	ax, es:[bp+58h]
		call	sub_1BE93
		mov	ax, cx
		mov	es:[bp+48h], ax
		mov	cx, es:[bp+4Ah]
		shl	ax, cl
		shl	dx, cl
		sar	ax, 4
		sar	dx, 4
		mov	es:[bp+4Ch], ax
		mov	es:[bp+4Eh], dx
		mov	word ptr es:[bp+5Ah], 0
		pop	ds
		pop	si
		sub	si, 6
		clc
		retn
; ---------------------------------------------------------------------------

loc_17399:				; CODE XREF: sub_1732A+2Aj
		clc
		retn
sub_1732A	endp


; =============== S U B	R O U T	I N E =======================================


sub_1739B	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		push	bp
		push	si
		push	es
		push	ds
		pusha
		mov	dx, 0
		call	Music_FadeOut
		popa
		pop	ds
		pop	es
		pop	si
		pop	bp
		stc
		retn
sub_1739B	endp


; =============== S U B	R O U T	I N E =======================================


sub_173AD	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		mov	bx, ax
		lodsw
		mov	di, ax
		push	bx
		push	di
		mov	ax, bx
		mov	bx, di
		mov	cx, es:[bp+4]
		mov	dx, es:[bp+6]
		sar	ax, 4
		sar	bx, 3
		sar	cx, 4
		sar	dx, 3
		cmp	cx, ax
		jnz	short loc_173D9
		cmp	dx, bx
		jnz	short loc_173D9
		pop	di
		pop	bx
		jmp	short loc_1741A
; ---------------------------------------------------------------------------

loc_173D9:				; CODE XREF: sub_173AD+22j
					; sub_173AD+26j
		pop	di
		pop	bx
		push	si
		push	ds
		mov	si, bx
		mov	cx, es:[bp+4]
		mov	dx, es:[bp+6]
		call	sub_1BF6B
		mov	ax, cx
		and	ax, es:[bp+58h]
		call	sub_1BE93
		mov	ax, cx
		mov	es:[bp+48h], ax
		mov	cx, es:[bp+4Ah]
		shl	ax, cl
		shl	dx, cl
		sar	ax, 4
		sar	dx, 4
		mov	es:[bp+4Ch], ax
		mov	es:[bp+4Eh], dx
		mov	word ptr es:[bp+5Ah], 0
		pop	ds
		pop	si
		lodsw
		clc
		retn
; ---------------------------------------------------------------------------

loc_1741A:				; CODE XREF: sub_173AD+2Aj
		lodsw
		mov	si, ax
		clc
		retn
sub_173AD	endp


; =============== S U B	R O U T	I N E =======================================


sub_1741F	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		mov	cs:word_12235, 9
		mov	cs:byte_12237, 0
		stc
		retn
sub_1741F	endp


; =============== S U B	R O U T	I N E =======================================


sub_1742E	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		inc	ax
		call	GetRandomInRange
		add	es:[bp+4], ax
		shl	ax, 4
		add	es:[bp+3Ch], ax
		lodsw
		inc	ax
		call	GetRandomInRange
		add	es:[bp+6], ax
		shl	ax, 4
		add	es:[bp+3Eh], ax
		stc
		retn
sub_1742E	endp


; =============== S U B	R O U T	I N E =======================================


sub_17450	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		mov	word ptr es:[bp+5Ch], 0
		stc
		retn
sub_17450	endp


; =============== S U B	R O U T	I N E =======================================


sub_17458	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		mov	cs:word_12FA9, ax
		stc
		retn
sub_17458	endp


; =============== S U B	R O U T	I N E =======================================


sub_1745F	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		mov	cs:word_15FDA, ax
		lodsw
		mov	cs:word_15FDC, ax
		stc
		retn
sub_1745F	endp


; =============== S U B	R O U T	I N E =======================================


sub_1746B	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		mov	cs:word_12235, ax
		mov	cs:byte_12237, 0
		stc
		retn
sub_1746B	endp


; =============== S U B	R O U T	I N E =======================================


sub_17478	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		add	es:[bp+48h], ax
		and	word ptr es:[bp+48h], 0FFh
		stc
		retn
sub_17478	endp


; =============== S U B	R O U T	I N E =======================================


sub_17485	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		mov	ax, es:[bp+48h]
		mov	cs:word_16E7A, ax
		lodsw
		mov	cx, ax
		lodsw
		mov	dx, ax
		call	sub_175B3
		lodsw
		add	cx, es:[bp+4]
		add	dx, es:[bp+6]
		call	cmfA_LoadEnemies
		stc
		retn
sub_17485	endp


; =============== S U B	R O U T	I N E =======================================


sub_174A4	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		shl	ax, 4
		mov	cs:word_16E76, ax
		lodsw
		shl	ax, 4
		mov	cs:word_16E78, ax
sub_174A4	endp ; sp-analysis failed


; =============== S U B	R O U T	I N E =======================================


sub_174B4	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		lodsw
		mov	bx, ax
		lodsw
		mov	ax, es:[bp+48h]
		mov	cs:word_16E7A, ax
		push	bx
		push	si
		push	ds
		call	sub_1BE93
		pop	ds
		pop	si
		pop	bx
		push	dx
		mov	ax, cx
		mul	bx
		mov	cx, ax
		pop	dx
		mov	ax, dx
		mul	bx
		mov	dx, ax
		sar	cx, 5
		sar	dx, 5
		mov	ax, cx
		mov	bx, dx
		push	ax
		lodsw
		mov	cx, ax
		lodsw
		mov	di, ax
		pop	ax
		push	si
		push	es
		push	ds

loc_174EC:				; CODE XREF: sub_174B4+5Fj
		push	cx
		add	cs:word_16E76, ax
		add	cs:word_16E78, bx
		push	ax
		push	bx
		mov	ax, di
		mov	cx, cs:word_16E76
		mov	dx, cs:word_16E78
		sar	cx, 4
		sar	dx, 4
		push	di
		call	sub_17EB9
		pop	di
		pop	bx
		pop	ax
		pop	cx
		loop	loc_174EC
		pop	ds
		pop	es
		pop	si
		stc
		retn
sub_174B4	endp


; =============== S U B	R O U T	I N E =======================================


sub_1751A	proc near		; DATA XREF: CmfMainLoopB:cmfJumpTblBo
		push	si
		mov	cx, es:[bp+4]
		mov	dx, es:[bp+6]
		call	sub_175B3
		mov	cx, es:[bp+48h]
		pop	si
		lodsw
		mov	bx, ax
		lodsw
		cmp	cx, bx
		jb	short loc_1753C
		cmp	cx, ax
		jnb	short loc_1753C
		lodsw
		mov	si, ax
		stc
		retn
; ---------------------------------------------------------------------------

loc_1753C:				; CODE XREF: sub_1751A+17j
					; sub_1751A+1Bj
		lodsw
		stc
		retn
sub_1751A	endp

; ---------------------------------------------------------------------------
word_1753F	dw 0			; DATA XREF: sub_10F09:loc_10FFDr
					; sub_10F09+10Dr ...
word_17541	dw 0			; DATA XREF: sub_10F09+FCr
					; sub_10F09+122r ...
		db 28h dup(0)
word_1756B	dw 0			; DATA XREF: sub_17158+1w
					; sub_17E0C+93r
byte_1756D	db 1Eh dup(0)		; DATA XREF: sub_16EB4+Do
					; sub_16EB4+30o ...
word_1758B	dw 0			; DATA XREF: sub_16EB4+21w
		db 20h dup(0)
word_175AD	dw 0			; DATA XREF: sub_16EB4+1Aw
					; sub_16EB4+48r
word_175AF	dw 0			; DATA XREF: sub_16EA4+4w
					; sub_16EB4+65w ...
word_175B1	dw 0			; DATA XREF: sub_16EA4+Cw
					; sub_16EB4+6Aw ...

; =============== S U B	R O U T	I N E =======================================


sub_175B3	proc near		; CODE XREF: sub_1686A+14p
					; sub_168F8+Cp	...
		cmp	word ptr es:[bp+6Bh], 0
		jz	short locret_175CC
		push	si
		mov	si, es:[bp+6Bh]
		add	cx, es:[si+4]
		add	dx, es:[si+6]
		sub	dx, es:[si+54h]
		pop	si

locret_175CC:				; CODE XREF: sub_175B3+5j
		retn
sub_175B3	endp


; =============== S U B	R O U T	I N E =======================================


sub_175CD	proc near		; CODE XREF: cmfA15+2p
		push	bp
		push	es
		push	ds
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		mov	es, ax
		assume es:seg001
		mov	bp, offset EnemyObjects
		mov	cx, 3Ch

loc_175DD:				; CODE XREF: sub_175CD+1Dj
		mov	word ptr ds:[bp+2], 0
		call	sub_182E0
		add	bp, 98h
		loop	loc_175DD
		pop	ds
		assume ds:nothing
		pop	es
		assume es:nothing
		pop	bp
		retn
sub_175CD	endp


; =============== S U B	R O U T	I N E =======================================


sub_175F0	proc near		; CODE XREF: sub_1704Cp
		mov	dx, bp
		push	bp
		push	ds
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		mov	bp, offset EnemyObjects
		mov	cx, 3Ch	; '<'

loc_175FF:				; CODE XREF: sub_175F0+24j
		cmp	bp, dx
		jz	short loc_17610
		mov	word ptr ds:[bp+2], 0
		mov	word ptr ds:[bp+96h], 0

loc_17610:				; CODE XREF: sub_175F0+11j
		add	bp, 98h
		loop	loc_175FF
		pop	ds
		assume ds:nothing
		pop	bp
		retn
sub_175F0	endp


; =============== S U B	R O U T	I N E =======================================


sub_17619	proc near		; CODE XREF: sub_176C1+8p
		push	es
		push	ds
		mov	si, ds:[bp+96h]
		mov	di, si
		mov	ax, cs:cmfDataSeg
		mov	ds, ax
		mov	es, ax
		add	si, 638h
		add	di, 640h
		mov	cx, 320h
		std
		rep movsw
		cld
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		mov	di, ds:[bp+96h]
		mov	ax, ds:[bp+4]
		add	ax, cs:MapPosX
		add	ax, cs:BasePosX
		mov	bx, ds:[bp+42h]
		sar	bx, 1
		add	ax, bx
		mov	es:[di], ax
		mov	ax, ds:[bp+6]
		add	ax, cs:MapPosY
		add	ax, cs:BasePosY
		mov	bx, ds:[bp+46h]
		sar	bx, 1
		add	ax, bx
		mov	es:[di+2], ax
		mov	ax, ds:[bp+48h]
		mov	es:[di+4], ax
		mov	di, ds:[bp+96h]
		mov	bx, 7543h
		mov	cx, 14h

loc_17689:				; CODE XREF: sub_17619+A3j
		add	di, 10h
		mov	si, cs:[bx]
		add	bx, 2
		mov	ax, es:[di]
		sub	ax, cs:MapPosX
		mov	[si+4],	ax
		shl	ax, 4
		mov	[si+3Ch], ax
		mov	ax, es:[di+2]
		sub	ax, cs:MapPosY
		mov	[si+6],	ax
		shl	ax, 4
		mov	[si+3Eh], ax
		mov	ax, es:[di+4]
		mov	[si+48h], ax
		loop	loc_17689
		pop	ds
		assume ds:nothing
		pop	es
		retn
sub_17619	endp


; =============== S U B	R O U T	I N E =======================================


sub_176C1	proc near		; CODE XREF: CmfMainLoopB+135p
		cmp	word ptr ds:[bp+96h], 0
		jz	short loc_176CC
		call	sub_17619

loc_176CC:				; CODE XREF: sub_176C1+6j
		mov	ax, ds:[bp+28h]
		shr	ax, 1
		cmp	ds:[bp+26h], ax
		jnb	short loc_176ED
		inc	word ptr ds:[bp+2Ah]
		mov	bx, ds:[bp+26h]
		inc	bx
		cmp	ds:[bp+2Ah], bx
		jb	short loc_176ED
		mov	word ptr ds:[bp+2Ah], 0

loc_176ED:				; CODE XREF: sub_176C1+15j
					; sub_176C1+24j
		cmp	word ptr ds:[bp+6Bh], 0
		jz	short loc_1771E
		mov	si, ds:[bp+6Bh]
		mov	ax, [si+4]
		add	ds:[bp+4], ax
		shl	ax, 4
		add	ds:[bp+3Ch], ax
		mov	ax, [si+6]
		sub	ax, [si+54h]
		add	ds:[bp+6], ax
		shl	ax, 4
		add	ds:[bp+3Eh], ax
		mov	ax, [si+2Eh]
		or	ds:[bp+2Eh], ax

loc_1771E:				; CODE XREF: sub_176C1+31j
		mov	ax, ds:[bp+4Ch]
		add	ds:[bp+3Ch], ax
		mov	ax, ds:[bp+4Eh]
		add	ds:[bp+3Eh], ax
		cmp	byte ptr ds:[bp+94h], 1
		jz	short loc_17755
		cmp	byte ptr ds:[bp+23h], 0
		jnz	short loc_1775A
		mov	ax, cs:BasePosX
		shl	ax, 4
		add	ds:[bp+3Ch], ax
		mov	ax, cs:BasePosY
		shl	ax, 4
		add	ds:[bp+3Eh], ax
		jmp	short loc_1775A
; ---------------------------------------------------------------------------

loc_17755:				; CODE XREF: sub_176C1+73j
		mov	byte ptr ds:[bp+23h], 0

loc_1775A:				; CODE XREF: sub_176C1+7Aj
					; sub_176C1+92j
		call	sub_17A47
		mov	ax, ds:[bp+3Ch]
		sar	ax, 4
		mov	ds:[bp+4], ax
		mov	ax, ds:[bp+3Eh]
		sar	ax, 4
		mov	ds:[bp+6], ax
		cmp	byte ptr ds:[bp+1Ah], 0
		jz	short loc_1777D
		call	sub_17B2F

loc_1777D:				; CODE XREF: sub_176C1+B7j
		mov	ax, ds:[bp+3Ch]
		sar	ax, 4
		mov	ds:[bp+4], ax
		mov	ax, ds:[bp+3Eh]
		sar	ax, 4
		mov	ds:[bp+6], ax
		call	sub_18188
		mov	ax, ds:[bp+32h]
		cmp	word ptr ds:[bp+38h], 0
		jz	short loc_177DC

loc_177A1:				; CODE XREF: sub_176C1+112j
					; sub_176C1+119j
		mov	es, cs:cmfDataSeg
		mov	bx, ds:[bp+38h]
		add	word ptr ds:[bp+38h], 2
		mov	dx, es:[bx]	; get HDF sub-sprite ID
		test	dh, 80h
		jnz	short loc_177BB
		add	ax, dx
		jmp	short loc_177DC
; ---------------------------------------------------------------------------

loc_177BB:				; CODE XREF: sub_176C1+F4j
		cmp	dx, 0FFFFh
		jnz	short loc_177D5
		mov	bx, ds:[bp+38h]
		mov	cx, es:[bx]
		shl	cx, 1
		mov	bx, ds:[bp+3Ah]
		add	bx, cx
		mov	ds:[bp+38h], bx
		jmp	short loc_177A1
; ---------------------------------------------------------------------------

loc_177D5:				; CODE XREF: sub_176C1+FDj
		sub	word ptr ds:[bp+38h], 4
		jmp	short loc_177A1
; ---------------------------------------------------------------------------

loc_177DC:				; CODE XREF: sub_176C1+DEj
					; sub_176C1+F8j
		mov	bx, ds:[bp+4Ch]
		or	bx, bx
		jz	short loc_177FA
		test	bh, 80h
		jnz	short loc_177F5
		sub	bh, bh
		mov	bl, ds:[bp+56h]
		mov	ds:[bp+57h], bl
		jmp	short loc_177FA
; ---------------------------------------------------------------------------

loc_177F5:				; CODE XREF: sub_176C1+126j
		mov	byte ptr ds:[bp+57h], 0

loc_177FA:				; CODE XREF: sub_176C1+121j
					; sub_176C1+132j
		cmp	word ptr ds:[bp+36h], 0
		jz	short loc_17852
		cmp	word ptr ds:[bp+36h], 1
		jz	short loc_1782D
		push	ax
		push	cx
		push	dx
		push	si
		push	di
		mov	cx, ds:[bp+4]
		mov	dx, ds:[bp+6]
		mov	si, cs:word_1EA52
		mov	di, cs:word_1EA56
		call	sub_1BEFA
		mov	bx, ax
		pop	di
		pop	si
		pop	dx
		pop	cx
		pop	ax
		add	ax, bx
		jmp	short loc_17852
; ---------------------------------------------------------------------------

loc_1782D:				; CODE XREF: sub_176C1+145j
		push	ax
		push	cx
		push	dx
		push	si
		push	di
		mov	cx, ds:[bp+4]
		mov	dx, ds:[bp+6]
		mov	si, cs:word_1EA52
		mov	di, cs:word_1EA56
		call	sub_1BEB0
		mov	bx, ax
		pop	di
		pop	si
		pop	dx
		pop	cx
		pop	ax
		add	ax, bx
		jmp	short $+2

loc_17852:				; CODE XREF: sub_176C1+13Ej
					; sub_176C1+16Aj
		cmp	word ptr ds:[bp+5Fh], 0
		jz	short loc_1787E
		mov	cx, ds:[bp+4]
		add	cx, ds:[bp+50h]
		mov	dx, ds:[bp+6]
		add	dx, ds:[bp+52h]
		call	sub_194CF
		jnb	short loc_1787E
		push	ax
		mov	ax, ds:[bp+5Fh]
		mov	cs:word_16720, ax
		mov	word ptr ds:[bp+5Ah], 0
		pop	ax

loc_1787E:				; CODE XREF: sub_176C1+196j
					; sub_176C1+1ABj
		push	ax
		cmp	word ptr ds:[bp+14h], 0
		jz	short loc_178C6
		mov	cx, ds:[bp+4]
		add	cx, ds:[bp+16h]
		mov	dx, ds:[bp+6]
		add	dx, ds:[bp+18h]
		cmp	word ptr ds:[bp+6Bh], 0
		jz	short loc_178AC
		push	si
		mov	si, ds:[bp+6Bh]
		add	cx, [si+4]
		add	dx, [si+6]
		sub	dx, [si+54h]
		pop	si

loc_178AC:				; CODE XREF: sub_176C1+1DAj
		push	bx
		call	sub_1A65E
		pop	bx
		cmp	ax, cs:word_1BE30
		jb	short loc_178C6
		mov	ax, ds:[bp+14h]
		mov	cs:word_16720, ax
		mov	word ptr ds:[bp+5Ah], 0

loc_178C6:				; CODE XREF: sub_176C1+1C3j
					; sub_176C1+1F5j
		pop	ax
		cmp	word ptr ds:[bp+12h], 1
		jnz	short loc_178D1
		jmp	loc_179D1
; ---------------------------------------------------------------------------

loc_178D1:				; CODE XREF: sub_176C1+20Bj
		add	al, ds:[bp+57h]
		mov	ds:[bp+34h], ax
		mov	cx, ds:[bp+4]	; get X	position
		mov	dx, ds:[bp+6]	; get Y	position
		sub	dx, ds:[bp+54h]
		mov	bx, ds:[bp+10h]
		mov	cs:word_1B8B9, bx
		sub	bx, bx
		mov	bl, ds:[bp+73h]
		or	bl, bl
		jz	short loc_17903
		push	ax
		mov	ax, bx
		inc	ax
		inc	ax
		call	GetRandomInRange
		add	dx, ax
		pop	ax

loc_17903:				; CODE XREF: sub_176C1+235j
		mov	bl, ds:[bp+72h]
		mov	di, bx
		mov	bx, ds:[bp+0Ch]
		sub	si, si
		cmp	word ptr ds:[bp+2Eh], 0
		jnz	short loc_17944
		push	ds
		cmp	word ptr ds:[bp+26h], 0
		jz	short loc_17925
		cmp	word ptr ds:[bp+2Ah], 0
		jz	short loc_17936

loc_17925:				; CODE XREF: sub_176C1+25Bj
		mov	ds, bx
		cmp	di, 0
		jz	short loc_17931
		call	AddHDFSpr_Mode1
		jmp	short loc_1793D
; ---------------------------------------------------------------------------

loc_17931:				; CODE XREF: sub_176C1+269j
		call	AddHDFSpr_Mode0
		jmp	short loc_1793D
; ---------------------------------------------------------------------------

loc_17936:				; CODE XREF: sub_176C1+262j
		mov	ds, bx
		mov	ah, 3
		call	AddHDFSpr_Mode2

loc_1793D:				; CODE XREF: sub_176C1+26Ej
					; sub_176C1+273j
		pop	ds
		call	sub_1893C
		jmp	loc_179D1
; ---------------------------------------------------------------------------

loc_17944:				; CODE XREF: sub_176C1+253j
		push	ds
		mov	ds, bx
		cmp	di, 0
		jz	short loc_17953
		mov	ah, 0Fh
		call	AddHDFSpr_Mode3
		jmp	short loc_17958
; ---------------------------------------------------------------------------

loc_17953:				; CODE XREF: sub_176C1+289j
		mov	ah, 0Fh
		call	AddHDFSpr_Mode2

loc_17958:				; CODE XREF: sub_176C1+290j
		pop	ds
		cmp	word ptr ds:[bp+26h], 0
		jz	short loc_179D1
		mov	ax, ds:[bp+30h]
		mov	word ptr ds:[bp+30h], 0
		sub	ds:[bp+26h], ax
		cmp	word ptr ds:[bp+26h], 0
		jz	short loc_1797D
		cmp	word ptr ds:[bp+26h], 0EA60h
		jb	short loc_179D1

loc_1797D:				; CODE XREF: sub_176C1+2B2j
		mov	word ptr ds:[bp+26h], 0
		cmp	word ptr ds:[bp+1Bh], 0
		jnz	short loc_179BC
		cmp	byte ptr ds:[bp+1Dh], 0
		jnz	short loc_179AE
		mov	cx, ds:[bp+4]
		mov	dx, ds:[bp+6]
		call	sub_15D8C
		mov	ax, ds:[bp+24h]
		call	sub_11C1C
		mov	word ptr ds:[bp+2], 0
		call	sub_180F2
		jmp	short loc_179D1
; ---------------------------------------------------------------------------

loc_179AE:				; CODE XREF: sub_176C1+2CEj
		mov	ax, ds:[bp+24h]
		call	sub_11C1C
		mov	byte ptr ds:[bp+1Eh], 1
		jmp	short loc_179D1
; ---------------------------------------------------------------------------

loc_179BC:				; CODE XREF: sub_176C1+2C7j
		mov	ax, ds:[bp+1Bh]
		mov	cs:word_16720, ax
		mov	word ptr ds:[bp+5Ah], 0
		mov	ax, ds:[bp+24h]
		call	sub_11C1C

loc_179D1:				; CODE XREF: sub_176C1+20Dj
					; sub_176C1+280j ...
		sub	ax, ax
		mov	al, ds:[bp+22h]
		or	ax, ax
		jz	short loc_179E5
		cmp	ax, 3
		jz	short loc_179EF
		dec	ax
		jz	short loc_179EA
		jmp	short loc_179F2
; ---------------------------------------------------------------------------

loc_179E5:				; CODE XREF: sub_176C1+318j
		call	sub_18062
		jmp	short loc_179F2
; ---------------------------------------------------------------------------

loc_179EA:				; CODE XREF: sub_176C1+320j
		call	sub_18094
		jmp	short loc_179F2
; ---------------------------------------------------------------------------

loc_179EF:				; CODE XREF: sub_176C1+31Dj
		call	sub_180C6

loc_179F2:				; CODE XREF: sub_176C1+322j
					; sub_176C1+327j ...
		cmp	word ptr ds:[bp+6Bh], 0
		jz	short locret_17A46
		mov	si, ds:[bp+6Bh]
		mov	ax, [si+4]
		sub	ds:[bp+4], ax
		shl	ax, 4
		sub	ds:[bp+3Ch], ax
		mov	ax, [si+6]
		sub	ax, [si+54h]
		sub	ds:[bp+6], ax
		shl	ax, 4
		sub	ds:[bp+3Eh], ax
		cmp	word ptr [si+2], 0
		jnz	short loc_17A28
		mov	word ptr ds:[bp+2], 0

loc_17A28:				; CODE XREF: sub_176C1+35Fj
		cmp	word ptr [si+6Dh], 0
		jz	short locret_17A46
		mov	ax, [si+6Dh]
		mov	ds:[bp+0Eh], ax
		cmp	word ptr [si+6Fh], 0
		jz	short locret_17A46
		pop	ax
		pop	ds
		pop	si
		push	si
		push	ds
		push	ax
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001

locret_17A46:				; CODE XREF: sub_176C1+336j
					; sub_176C1+36Bj ...
		retn
sub_176C1	endp


; =============== S U B	R O U T	I N E =======================================


sub_17A47	proc near		; CODE XREF: sub_176C1:loc_1775Ap
		cmp	word ptr ds:[bp+65h], 0
		jnz	short loc_17A51
		jmp	locret_17AEF
; ---------------------------------------------------------------------------

loc_17A51:				; CODE XREF: sub_17A47+5j
		call	sub_17BE1
		mov	ax, ds:[bp+67h]
		mov	ds:[bp+4Eh], ax
		add	word ptr ds:[bp+67h], 10h
		test	word ptr ds:[bp+67h], 8000h
		jz	short loc_17A6C
		jmp	locret_17AEF
; ---------------------------------------------------------------------------

loc_17A6C:				; CODE XREF: sub_17A47+20j
		mov	cx, ds:[bp+4]
		mov	dx, ds:[bp+6]
		add	dx, ds:[bp+44h]
		add	dx, ds:[bp+46h]
		mov	bx, ds:[bp+42h]
		shr	bx, 4

loc_17A83:				; CODE XREF: sub_17A47+4Cj
		push	bx
		call	sub_1A65E
		pop	bx
		cmp	ax, cs:word_1BE30
		jb	short loc_17AAE
		add	cx, 10h
		dec	bx
		jnz	short loc_17A83
		mov	word ptr ds:[bp+65h], 0
		mov	byte ptr ds:[bp+1Ah], 1
		mov	ax, ds:[bp+67h]
		neg	ax
		mov	ds:[bp+4Eh], ax
		mov	dx, ds:[bp+6]

loc_17AAE:				; CODE XREF: sub_17A47+46j
		mov	cx, ds:[bp+4]
		mov	dx, ds:[bp+6]
		add	dx, ds:[bp+44h]
		add	dx, ds:[bp+46h]
		add	dx, 8
		mov	bx, ds:[bp+42h]
		shr	bx, 4

loc_17AC8:				; CODE XREF: sub_17A47+91j
		push	bx
		call	sub_1A65E
		pop	bx
		cmp	ax, cs:word_1BE30
		jb	short locret_17AEF
		add	cx, 10h
		dec	bx
		jnz	short loc_17AC8
		mov	word ptr ds:[bp+65h], 0
		mov	byte ptr ds:[bp+1Ah], 1
		mov	ax, ds:[bp+67h]
		neg	ax
		mov	dx, ds:[bp+6]

locret_17AEF:				; CODE XREF: sub_17A47+7j
					; sub_17A47+22j ...
		retn
sub_17A47	endp

; ---------------------------------------------------------------------------

loc_17AF0:				; CODE XREF: seg000:7B2Cj
		mov	cx, ds:[bp+4]
		mov	dx, ds:[bp+6]
		sub	dx, 4
		add	dx, ds:[bp+46h]
		mov	bx, ds:[bp+42h]
		shr	bx, 4
		sub	di, di

loc_17B08:				; CODE XREF: seg000:7B1Bj
		push	bx
		call	sub_1A65E
		pop	bx
		cmp	ax, cs:word_1BE30
		jb	short loc_17B17
		mov	di, 1

loc_17B17:				; CODE XREF: seg000:7B12j
		add	cx, 10h
		dec	bx
		jnz	short loc_17B08
		cmp	di, 0
		jz	short locret_17B2E
		sub	word ptr ds:[bp+6], 1
		sub	word ptr ds:[bp+3Eh], 10h
		jmp	short loc_17AF0
; ---------------------------------------------------------------------------

locret_17B2E:				; CODE XREF: seg000:7B20j
		retn

; =============== S U B	R O U T	I N E =======================================


sub_17B2F	proc near		; CODE XREF: sub_176C1+B9p
		mov	ax, ds:[bp+69h]
		add	ds:[bp+6], ax
		shl	ax, 4
		add	ds:[bp+3Eh], ax
		call	sub_17CDB
		jnb	short loc_17B5E
		inc	word ptr ds:[bp+69h]
		test	word ptr ds:[bp+69h], 8000h
		jnz	short loc_17B83
		cmp	word ptr ds:[bp+69h], 8
		jb	short loc_17B83
		mov	word ptr ds:[bp+69h], 8
		jmp	short loc_17B83
; ---------------------------------------------------------------------------

loc_17B5E:				; CODE XREF: sub_17B2F+12j
		mov	bx, 9

loc_17B61:				; CODE XREF: sub_17B2F+43j
		dec	word ptr ds:[bp+6]
		sub	word ptr ds:[bp+3Eh], 10h
		dec	bx
		jz	short loc_17B74
		push	bx
		call	sub_17CDB
		pop	bx
		jnb	short loc_17B61

loc_17B74:				; CODE XREF: sub_17B2F+3Cj
		inc	word ptr ds:[bp+6]
		add	word ptr ds:[bp+3Eh], 10h
		mov	word ptr ds:[bp+69h], 0

loc_17B83:				; CODE XREF: sub_17B2F+1Ej
					; sub_17B2F+25j ...
		mov	bx, 9

loc_17B86:				; CODE XREF: sub_17B2F+68j
		inc	word ptr ds:[bp+4]
		add	word ptr ds:[bp+3Ch], 10h
		dec	bx
		jz	short loc_17B99
		push	bx
		call	sub_17C79
		pop	bx
		jnb	short loc_17B86

loc_17B99:				; CODE XREF: sub_17B2F+61j
		dec	word ptr ds:[bp+4]
		sub	word ptr ds:[bp+3Ch], 10h
		mov	bx, 9

loc_17BA5:				; CODE XREF: sub_17B2F+87j
		dec	word ptr ds:[bp+4]
		sub	word ptr ds:[bp+3Ch], 10h
		dec	bx
		jz	short loc_17BB8
		push	bx
		call	sub_17C3F
		pop	bx
		jnb	short loc_17BA5

loc_17BB8:				; CODE XREF: sub_17B2F+80j
		inc	word ptr ds:[bp+4]
		add	word ptr ds:[bp+3Ch], 10h
		mov	bx, 9

loc_17BC4:				; CODE XREF: sub_17B2F+A6j
		inc	word ptr ds:[bp+6]
		add	word ptr ds:[bp+3Eh], 10h
		dec	bx
		jz	short loc_17BD7
		push	bx
		call	sub_17CAF
		pop	bx
		jnb	short loc_17BC4

loc_17BD7:				; CODE XREF: sub_17B2F+9Fj
		dec	word ptr ds:[bp+6]
		sub	word ptr ds:[bp+3Eh], 10h
		retn
sub_17B2F	endp


; =============== S U B	R O U T	I N E =======================================


sub_17BE1	proc near		; CODE XREF: sub_17A47:loc_17A51p
		mov	bx, 9

loc_17BE4:				; CODE XREF: sub_17BE1+14j
		inc	word ptr ds:[bp+4]
		add	word ptr ds:[bp+3Ch], 10h
		dec	bx
		jz	short loc_17BF7
		push	bx
		call	sub_17C79
		pop	bx
		jnb	short loc_17BE4

loc_17BF7:				; CODE XREF: sub_17BE1+Dj
		dec	word ptr ds:[bp+4]
		sub	word ptr ds:[bp+3Ch], 10h
		mov	bx, 9

loc_17C03:				; CODE XREF: sub_17BE1+33j
		dec	word ptr ds:[bp+4]
		sub	word ptr ds:[bp+3Ch], 10h
		dec	bx
		jz	short loc_17C16
		push	bx
		call	sub_17C3F
		pop	bx
		jnb	short loc_17C03

loc_17C16:				; CODE XREF: sub_17BE1+2Cj
		inc	word ptr ds:[bp+4]
		add	word ptr ds:[bp+3Ch], 10h
		mov	bx, 9

loc_17C22:				; CODE XREF: sub_17BE1+52j
		inc	word ptr ds:[bp+6]
		add	word ptr ds:[bp+3Eh], 10h
		dec	bx
		jz	short loc_17C35
		push	bx
		call	sub_17CAF
		pop	bx
		jnb	short loc_17C22

loc_17C35:				; CODE XREF: sub_17BE1+4Bj
		dec	word ptr ds:[bp+6]
		sub	word ptr ds:[bp+3Eh], 10h
		retn
sub_17BE1	endp


; =============== S U B	R O U T	I N E =======================================


sub_17C3F	proc near		; CODE XREF: sub_17B2F+83p
					; sub_17BE1+2Fp
		mov	cx, ds:[bp+4]
		add	cx, ds:[bp+40h]
		add	cx, ds:[bp+42h]
		add	cx, 10h
		mov	dx, ds:[bp+6]
		add	dx, ds:[bp+44h]
		mov	bx, ds:[bp+46h]
		cmp	bx, 8
		jb	short locret_17C78
		sub	bx, 8
		shr	bx, 3

loc_17C65:				; CODE XREF: sub_17C3F+36j
		push	bx
		call	sub_1A65E
		pop	bx
		cmp	ax, cs:word_1BE30
		jnb	short locret_17C78
		add	dx, 8
		dec	bx
		jnz	short loc_17C65
		stc

locret_17C78:				; CODE XREF: sub_17C3F+1Ej
					; sub_17C3F+30j
		retn
sub_17C3F	endp


; =============== S U B	R O U T	I N E =======================================


sub_17C79	proc near		; CODE XREF: sub_17B2F+64p
					; sub_17BE1+10p
		mov	cx, ds:[bp+4]
		add	cx, ds:[bp+40h]
		sub	cx, 10h
		mov	dx, ds:[bp+6]
		add	dx, ds:[bp+44h]
		mov	bx, ds:[bp+46h]
		cmp	bx, 8
		jb	short locret_17CAE
		sub	bx, 8
		shr	bx, 3

loc_17C9B:				; CODE XREF: sub_17C79+32j
		push	bx
		call	sub_1A65E
		pop	bx
		cmp	ax, cs:word_1BE30
		jnb	short locret_17CAE
		add	dx, 8
		dec	bx
		jnz	short loc_17C9B
		stc

locret_17CAE:				; CODE XREF: sub_17C79+1Aj
					; sub_17C79+2Cj
		retn
sub_17C79	endp


; =============== S U B	R O U T	I N E =======================================


sub_17CAF	proc near		; CODE XREF: sub_17B2F+A2p
					; sub_17BE1+4Ep
		mov	cx, ds:[bp+4]
		add	cx, ds:[bp+40h]
		mov	dx, ds:[bp+6]
		add	dx, ds:[bp+44h]
		mov	bx, ds:[bp+42h]
		shr	bx, 4
		inc	bx

loc_17CC7:				; CODE XREF: sub_17CAF+28j
		push	bx
		call	sub_1A65E
		pop	bx
		cmp	ax, cs:word_1BE30
		jnb	short locret_17CDA
		add	cx, 8
		dec	bx
		jnz	short loc_17CC7
		stc

locret_17CDA:				; CODE XREF: sub_17CAF+22j
		retn
sub_17CAF	endp


; =============== S U B	R O U T	I N E =======================================


sub_17CDB	proc near		; CODE XREF: sub_17B2F+Fp
					; sub_17B2F+3Fp
		call	sub_17D16
		mov	cx, ds:[bp+4]
		add	cx, ds:[bp+40h]
		mov	dx, ds:[bp+6]
		add	dx, ds:[bp+54h]
		add	dx, ds:[bp+44h]
		add	dx, ds:[bp+46h]
		mov	bx, ds:[bp+42h]
		sub	bx, ds:[bp+40h]
		shr	bx, 4
		inc	bx

loc_17D02:				; CODE XREF: sub_17CDB+37j
		push	bx
		call	sub_1A65E
		pop	bx
		cmp	ax, cs:word_1BE30
		jnb	short locret_17D15
		add	cx, 10h
		dec	bx
		jnz	short loc_17D02
		stc

locret_17D15:				; CODE XREF: sub_17CDB+31j
		retn
sub_17CDB	endp


; =============== S U B	R O U T	I N E =======================================


sub_17D16	proc near		; CODE XREF: sub_17CDBp
		mov	cx, ds:[bp+4]
		add	cx, ds:[bp+40h]
		mov	word ptr ds:[bp+54h], 0
		mov	dx, ds:[bp+6]
		add	dx, ds:[bp+44h]
		add	dx, ds:[bp+46h]
		sub	dx, 8
		mov	bx, ds:[bp+42h]
		sub	bx, ds:[bp+40h]
		shr	bx, 1
		inc	bx

loc_17D3E:				; CODE XREF: sub_17D16+3Bj
		push	bx
		call	sub_1A65E
		cmp	ds:[bp+54h], bx
		jnb	short loc_17D4C
		mov	ds:[bp+54h], bx

loc_17D4C:				; CODE XREF: sub_17D16+30j
		pop	bx
		add	cx, 2
		dec	bx
		jnz	short loc_17D3E
		retn
sub_17D16	endp


; =============== S U B	R O U T	I N E =======================================


cmfA_LoadEnemies proc near		; CODE XREF: sub_10EEA+18p
					; cmfA0C_LoadEnemies+9p ...
		push	cx
		push	bp
		push	si
		push	es
		push	ds
		mov	cs:word_17E04, bp
		mov	es, cs:cmfDataSeg
		mov	bp, cs:cmfMainBStartPos
		cmp	ax, es:[bp+0]
		jb	short loc_17D71
		jmp	loc_17DFC
; ---------------------------------------------------------------------------

loc_17D71:				; CODE XREF: cmfA_LoadEnemies+18j
		push	ax
		mov	ax, seg	seg001
		mov	ds, ax
		pop	ax
		mov	cs:word_17E06, cx
		mov	bp, offset EnemyObjects
		mov	cx, 60

loc_17D83:				; CODE XREF: cmfA_LoadEnemies+A6j
		cmp	word ptr ds:[bp+2], 0
		jnz	short loc_17DF6
		mov	ds:[bp+8], di
		mov	ds:[bp+0Ah], si
		mov	word ptr ds:[bp+0Eh], 1
		mov	word ptr ds:[bp+6Bh], 0
		mov	byte ptr ds:[bp+23h], 0
		mov	word ptr ds:[bp+5Ah], 0
		mov	word ptr ds:[bp+32h], 0
		mov	word ptr ds:[bp+34h], 0
		mov	cs:word_17E02, bp
		mov	bx, ax
		shl	bx, 1
		mov	cx, cs:word_17E06
		add	bx, cs:cmfMainBStartPos
		mov	word ptr ds:[bp+2], 1
		mov	ax, es:[bx]
		mov	ds:[bp+88h], ax
		mov	ds:[bp+4], cx
		mov	ds:[bp+6], dx
		shl	cx, 4
		mov	ds:[bp+3Ch], cx
		shl	dx, 4
		mov	ds:[bp+3Eh], dx
		mov	ax, cs:word_16E7A
		mov	ds:[bp+48h], ax
		jmp	short loc_17DFC
; ---------------------------------------------------------------------------

loc_17DF6:				; CODE XREF: cmfA_LoadEnemies+34j
		add	bp, 98h
		loop	loc_17D83

loc_17DFC:				; CODE XREF: cmfA_LoadEnemies+1Aj
					; cmfA_LoadEnemies+A0j
		pop	ds
		assume ds:nothing
		pop	es
		pop	si
		pop	bp
		pop	cx
		retn
cmfA_LoadEnemies endp

; ---------------------------------------------------------------------------
word_17E02	dw 0			; DATA XREF: sub_17277+26r
					; sub_17277+44r ...
word_17E04	dw 0			; DATA XREF: cmfA_LoadEnemies+5w
word_17E06	dw 0			; DATA XREF: cmfA_LoadEnemies+24w
					; cmfA_LoadEnemies+6Ar
		db 4 dup(0)

; =============== S U B	R O U T	I N E =======================================


sub_17E0C	proc near		; CODE XREF: sub_17158+17p
		push	cx
		push	bp
		push	si
		push	es
		push	ds
		mov	cs:word_17EB5, bp
		mov	es, cs:cmfDataSeg
		mov	bp, cs:cmfMainBStartPos
		cmp	ax, es:[bp+0]
		jb	short loc_17E29
		jmp	loc_17EAF
; ---------------------------------------------------------------------------

loc_17E29:				; CODE XREF: sub_17E0C+18j
		push	ax
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		pop	ax
		mov	cs:word_17EB7, cx
		mov	bp, 0D684h
		mov	cx, 3Ch	; '<'

loc_17E3B:				; CODE XREF: sub_17E0C+A1j
		cmp	word ptr ds:[bp+2], 0
		jnz	short loc_17EA9
		mov	ds:[bp+8], di
		mov	ds:[bp+0Ah], si
		mov	word ptr ds:[bp+0Eh], 1
		mov	word ptr ds:[bp+6Bh], 0
		mov	byte ptr ds:[bp+23h], 0
		mov	word ptr ds:[bp+5Ah], 0
		mov	word ptr ds:[bp+32h], 0
		mov	word ptr ds:[bp+34h], 0
		mov	bx, ax
		shl	bx, 1
		mov	cx, cs:word_17EB7
		add	bx, cs:cmfMainBStartPos
		mov	word ptr ds:[bp+2], 1
		mov	ax, es:[bx]
		mov	ds:[bp+88h], ax
		mov	ds:[bp+4], cx
		mov	ds:[bp+6], dx
		shl	cx, 4
		mov	ds:[bp+3Ch], cx
		shl	dx, 4
		mov	ds:[bp+3Eh], dx
		mov	ax, cs:word_1756B
		mov	ds:[bp+32h], ax
		jmp	short loc_17EAF
; ---------------------------------------------------------------------------

loc_17EA9:				; CODE XREF: sub_17E0C+34j
		add	bp, 98h	; 'ò'
		loop	loc_17E3B

loc_17EAF:				; CODE XREF: sub_17E0C+1Aj
					; sub_17E0C+9Bj
		pop	ds
		assume ds:nothing
		pop	es
		pop	si
		pop	bp
		pop	cx
		retn
sub_17E0C	endp

; ---------------------------------------------------------------------------
word_17EB5	dw 0			; DATA XREF: sub_17E0C+5w
word_17EB7	dw 0			; DATA XREF: sub_17E0C+24w
					; sub_17E0C+65r

; =============== S U B	R O U T	I N E =======================================


sub_17EB9	proc near		; CODE XREF: sub_16964+7p
					; sub_16E1C+4Cp ...
		mov	cs:word_17F71, bp
		push	cx
		push	bp
		push	si
		push	es
		push	ds
		mov	es, cs:cmfDataSeg
		mov	bp, cs:cmfMainBStartPos
		cmp	ax, es:[bp+0]
		jb	short loc_17ED6
		jmp	loc_17F69
; ---------------------------------------------------------------------------

loc_17ED6:				; CODE XREF: sub_17EB9+18j
		push	ax
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		pop	ax
		mov	cs:word_17F6F, cx
		mov	bp, offset EnemyObjects
		add	bp, 2308h
		mov	cx, 3Bh	; ';'

loc_17EEC:				; CODE XREF: sub_17EB9+AEj
		cmp	word ptr ds:[bp+2], 0
		jnz	short loc_17F63
		mov	ds:[bp+8], di
		mov	ds:[bp+0Ah], si
		mov	word ptr ds:[bp+0Eh], 1
		mov	word ptr ds:[bp+5Ah], 0
		mov	word ptr ds:[bp+32h], 0
		mov	word ptr ds:[bp+34h], 0
		push	ax
		mov	ax, cs:word_17F71
		mov	ds:[bp+6Bh], ax
		mov	byte ptr ds:[bp+23h], 1
		mov	cs:word_17F73, bp
		pop	ax
		mov	bx, ax
		shl	bx, 1
		mov	cx, cs:word_17F6F
		add	bx, cs:cmfMainBStartPos
		mov	word ptr ds:[bp+2], 1
		mov	ax, es:[bx]
		mov	ds:[bp+88h], ax
		mov	ds:[bp+4], cx
		mov	ds:[bp+6], dx
		shl	cx, 4
		mov	ds:[bp+3Ch], cx
		shl	dx, 4
		mov	ds:[bp+3Eh], dx
		mov	ax, cs:word_16E7A
		mov	ds:[bp+48h], ax
		jmp	short loc_17F69
; ---------------------------------------------------------------------------

loc_17F63:				; CODE XREF: sub_17EB9+38j
		sub	bp, 98h	; 'ò'
		loop	loc_17EEC

loc_17F69:				; CODE XREF: sub_17EB9+1Aj
					; sub_17EB9+A8j
		pop	ds
		assume ds:nothing
		pop	es
		pop	si
		pop	bp
		pop	cx
		retn
sub_17EB9	endp

; ---------------------------------------------------------------------------
word_17F6F	dw 0			; DATA XREF: sub_17EB9+24w
					; sub_17EB9+72r
word_17F71	dw 0			; DATA XREF: sub_17EB9w sub_17EB9+5Br
word_17F73	dw 0			; DATA XREF: sub_16964+14r
					; sub_17EB9+68w

; =============== S U B	R O U T	I N E =======================================


ToCmfMainB	proc near		; CODE XREF: sub_10F09+49p
		call	sub_182C4
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		mov	bp, offset EnemyObjects
		mov	cx, 60

loc_17F83:				; CODE XREF: ToCmfMainB+22j
		cmp	word ptr ds:[bp+2], 0
		jz	short loc_17F93
		push	cx
		push	bp
		push	ds
		call	DoCmfMainB
		pop	ds
		assume ds:nothing
		pop	bp
		pop	cx

loc_17F93:				; CODE XREF: ToCmfMainB+13j
		add	bp, 98h
		loop	loc_17F83
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		mov	bp, offset EnemyObjects
		mov	cx, 60

loc_17FA4:				; CODE XREF: ToCmfMainB+46j
		cmp	word ptr ds:[bp+2], 0
		jz	short loc_17FB7
		mov	word ptr ds:[bp+2Eh], 0
		mov	word ptr ds:[bp+6Fh], 0

loc_17FB7:				; CODE XREF: ToCmfMainB+34j
		add	bp, 98h
		loop	loc_17FA4
		mov	bp, offset EnemyObjects
		mov	cx, 60

loc_17FC3:				; CODE XREF: ToCmfMainB+8Aj
		cmp	word ptr ds:[bp+2], 0
		jz	short loc_17FFB
		cmp	byte ptr ds:[bp+95h], 0
		jz	short loc_17FFB
		push	es
		push	ds
		pusha
		mov	cx, ds:[bp+4]
		add	cx, 10h
		mov	dx, ds:[bp+6]
		add	dx, 8
		mov	ax, ds:[bp+26h]
		call	sub_1823E
		popa
		pop	ds
		assume ds:nothing
		pop	es
		jnb	short loc_17FFB
		mov	word ptr ds:[bp+26h], 1
		mov	word ptr ds:[bp+30h], 1

loc_17FFB:				; CODE XREF: ToCmfMainB+53j
					; ToCmfMainB+5Bj ...
		add	bp, 98h
		loop	loc_17FC3
		retn
ToCmfMainB	endp

; ---------------------------------------------------------------------------
		mov	si, ds:[bp+88h]
		push	ds
		mov	ax, cs:cmfDataSeg
		mov	ds, ax
		call	CmfMainLoopB
		pop	ds
		mov	ds:[bp+88h], si
		retn

; =============== S U B	R O U T	I N E =======================================


DoCmfMainB	proc near		; CODE XREF: ToCmfMainB+18p
		cmp	byte ptr ds:[bp+1Eh], 1
		jz	short loc_18035
		mov	si, ds:[bp+88h]
		push	ds
		mov	ax, cs:cmfDataSeg
		mov	ds, ax
		call	CmfMainLoopB
		pop	ds
		mov	ds:[bp+88h], si
		retn
; ---------------------------------------------------------------------------

loc_18035:				; CODE XREF: DoCmfMainB+5j
		call	sub_183E1
		retn
DoCmfMainB	endp

; ---------------------------------------------------------------------------
		cmp	word ptr ds:[bp+26h], 0
		dec	word ptr ds:[bp+26h]
		cmp	word ptr ds:[bp+26h], 0
		jnz	short loc_1805F
		mov	cx, ds:[bp+4]
		mov	dx, ds:[bp+6]
		call	sub_15D8C
		mov	word ptr ds:[bp+2], 0
		call	sub_180F2
		stc

locret_1805E:				; CODE XREF: seg000:8060j
		retn
; ---------------------------------------------------------------------------

loc_1805F:				; CODE XREF: seg000:8047j
		clc
		jmp	short locret_1805E

; =============== S U B	R O U T	I N E =======================================


sub_18062	proc near		; CODE XREF: sub_176C1:loc_179E5p
		cmp	word ptr ds:[bp+6Bh], 0
		jnz	short sub_18094
		mov	ax, ds:[bp+4]
		add	ax, 140h
		cmp	ax, 4B0h
		jb	short loc_1807D
		call	sub_18164
		call	sub_180F2
		jmp	short loc_18093
; ---------------------------------------------------------------------------

loc_1807D:				; CODE XREF: sub_18062+11j
		mov	ax, ds:[bp+6]
		add	ax, 3Ch	; '<'
		cmp	ax, 140h
		jb	short loc_18091
		call	sub_18164
		call	sub_180F2
		jmp	short loc_18093
; ---------------------------------------------------------------------------

loc_18091:				; CODE XREF: sub_18062+25j
		clc
		retn
; ---------------------------------------------------------------------------

loc_18093:				; CODE XREF: sub_18062+19j
					; sub_18062+2Dj
		stc
sub_18062	endp ; sp-analysis failed


; =============== S U B	R O U T	I N E =======================================


sub_18094	proc near		; CODE XREF: sub_176C1:loc_179EAp
					; sub_18062+5j	...
		mov	ax, ds:[bp+4]
		add	ax, 140h
		cmp	ax, 4B0h
		jb	short loc_180AB
		mov	word ptr ds:[bp+2], 0
		call	sub_180F2
		jmp	short loc_180C4
; ---------------------------------------------------------------------------

loc_180AB:				; CODE XREF: sub_18094+Aj
		mov	ax, ds:[bp+6]
		add	ax, 3Ch	; '<'
		cmp	ax, 140h
		jb	short loc_180C2
		mov	word ptr ds:[bp+2], 0
		call	sub_180F2
		jmp	short loc_180C4
; ---------------------------------------------------------------------------

loc_180C2:				; CODE XREF: sub_18094+21j
		clc
		retn
; ---------------------------------------------------------------------------

loc_180C4:				; CODE XREF: sub_18094+15j
					; sub_18094+2Cj
		stc
		retn
sub_18094	endp


; =============== S U B	R O U T	I N E =======================================


sub_180C6	proc near		; CODE XREF: sub_176C1:loc_179EFp
		cmp	word ptr ds:[bp+6Bh], 0
		jnz	short sub_18094
		mov	ax, ds:[bp+4]
		add	ax, 140h
		cmp	ax, 4B0h
		jb	short loc_180DF
		call	sub_180F2
		call	sub_1811C

loc_180DF:				; CODE XREF: sub_180C6+11j
		mov	ax, ds:[bp+6]
		add	ax, 3Ch	; '<'
		cmp	ax, 140h
		jb	short locret_180F1
		call	sub_180F2
		call	sub_1811C

locret_180F1:				; CODE XREF: sub_180C6+23j
		retn
sub_180C6	endp


; =============== S U B	R O U T	I N E =======================================


sub_180F2	proc near		; CODE XREF: sub_16722+6p
					; sub_176C1+2E8p ...
		push	ax
		push	cx
		push	dx
		push	bp
		push	ds
		mov	dx, bp
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		mov	bp, offset EnemyObjects
		mov	cx, 60

loc_18104:				; CODE XREF: sub_180F2+22j
		cmp	ds:[bp+6Bh], dx
		jnz	short loc_18110
		mov	word ptr ds:[bp+2], 0

loc_18110:				; CODE XREF: sub_180F2+16j
		add	bp, 98h
		loop	loc_18104
		pop	ds
		assume ds:nothing
		pop	bp
		pop	dx
		pop	cx
		pop	ax
		retn
sub_180F2	endp


; =============== S U B	R O U T	I N E =======================================


sub_1811C	proc near		; CODE XREF: sub_180C6+16p
					; sub_180C6+28p
		mov	cx, ds:[bp+4]
		mov	dx, ds:[bp+6]
		mov	bx, cs:word_1BDF6
		shl	bx, 1
		mov	ax, cs:word_1BE10
		shr	dx, 3
		add	ax, dx
		mul	bx
		sar	cx, 4
		add	cx, cs:word_1BE0C
		shl	cx, 1
		add	ax, cx
		mov	di, ax
		and	di, 0FFFEh
		push	es
		mov	word ptr ds:[bp+2], 0
		mov	es, cs:gfxBufPtr_SDF
		mov	ax, ds:[bp+0Ah]
		shl	ax, 0Ah
		and	word ptr es:[di], 3FFh
		or	es:[di], ax
		pop	es
		retn
sub_1811C	endp


; =============== S U B	R O U T	I N E =======================================


sub_18164	proc near		; CODE XREF: sub_18062+13p
					; sub_18062+27p
		push	es
		mov	word ptr ds:[bp+2], 0
		call	sub_180F2
		mov	es, cs:gfxBufPtr_SDF
		mov	di, ds:[bp+8]
		mov	ax, ds:[bp+0Ah]
		shl	ax, 0Ah
		and	word ptr es:[di], 3FFh
		or	es:[di], ax
		pop	es
		retn
sub_18164	endp


; =============== S U B	R O U T	I N E =======================================


sub_18188	proc near		; CODE XREF: sub_176C1+D2p
		push	es
		push	ds
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		cmp	word ptr ds:[bp+2], 0
		jnz	short loc_18199
		jmp	loc_1823B
; ---------------------------------------------------------------------------

loc_18199:				; CODE XREF: sub_18188+Cj
		cmp	word ptr ds:[bp+42h], 0
		jnz	short loc_181A3
		jmp	loc_1823B
; ---------------------------------------------------------------------------

loc_181A3:				; CODE XREF: sub_18188+16j
		cmp	word ptr ds:[bp+46h], 0
		jnz	short loc_181AD
		jmp	loc_1823B
; ---------------------------------------------------------------------------

loc_181AD:				; CODE XREF: sub_18188+20j
		mov	ax, ds:[bp+6]
		add	ax, ds:[bp+44h]
		add	ax, 64h	; 'd'
		cmp	ax, 190h
		jnb	short loc_1823B
		add	ax, ds:[bp+46h]
		cmp	ax, 190h
		jnb	short loc_1823B
		mov	ax, ds:[bp+4]
		add	ax, ds:[bp+40h]
		add	ax, 0A0h ; '†'
		cmp	ax, 3C0h
		jnb	short loc_1823B
		add	ax, ds:[bp+42h]
		cmp	ax, 3C0h
		jnb	short loc_1823B
		mov	ax, seg	seg001
		mov	ds, ax
		mov	es, ax
		assume es:seg001
		mov	ax, ds:[bp+6]
		add	ax, ds:[bp+44h]
		add	ax, 64h	; 'd'
		sar	ax, 2
		shl	ax, 5
		mov	di, ax
		shl	ax, 2
		add	di, ax
		mov	ax, ds:[bp+4]
		add	ax, ds:[bp+40h]
		sar	ax, 3
		add	ax, 28h	; '('
		add	di, ax
		add	di, offset byte_20AAC
		mov	ax, ds:[bp+0]
		cmp	byte ptr ds:[bp+71h], 0
		jz	short loc_1821F
		or	al, 80h

loc_1821F:				; CODE XREF: sub_18188+93j
		mov	cx, ds:[bp+46h]
		shr	cx, 2
		mov	bx, di

loc_18228:				; CODE XREF: sub_18188+B1j
		push	cx
		mov	cx, ds:[bp+42h]
		shr	cx, 3
		rep stosb
		pop	cx
		add	bx, 0A0h
		mov	di, bx
		loop	loc_18228

loc_1823B:				; CODE XREF: sub_18188+Ej
					; sub_18188+18j ...
		pop	ds
		assume ds:nothing
		pop	es
		assume es:nothing
		retn
sub_18188	endp


; =============== S U B	R O U T	I N E =======================================


sub_1823E	proc near		; CODE XREF: seg000:4770p seg000:479Bp ...
		push	bp
		push	es
		push	ds
		mov	cs:word_182C2, ax
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		mov	es, ax
		assume es:seg001
		mov	ax, dx
		add	ax, 64h	; 'd'
		sar	ax, 2
		shl	ax, 5
		mov	si, ax
		shl	ax, 2
		add	si, ax
		mov	ax, cx
		sar	ax, 3
		add	ax, 28h	; '('
		add	si, ax
		add	si, offset byte_20AAC
		sub	ax, ax
		lodsb
		cmp	al, 0
		jnz	short loc_1828B
		lodsb
		cmp	al, 0
		jnz	short loc_1828B
		add	si, 9Eh
		lodsb
		cmp	al, 0
		jnz	short loc_1828B
		lodsb
		cmp	al, 0
		jnz	short loc_1828B
		clc
		pop	ds
		assume ds:nothing
		pop	es
		assume es:nothing
		pop	bp
		retn
; ---------------------------------------------------------------------------

loc_1828B:				; CODE XREF: sub_1823E+33j
					; sub_1823E+38j ...
		and	ax, 0FF7Fh
		mov	bx, ax
		mov	ax, 98h
		dec	bx
		mul	bx
		mov	bp, offset EnemyObjects
		add	bp, ax
		cmp	word ptr ds:[bp+26h], 0
		jz	short loc_182BD
		mov	word ptr ds:[bp+2Eh], 1
		mov	ax, cs:word_182C2
		add	ds:[bp+30h], ax
		pusha
		mov	dx, 4
		call	sub_1E653
		popa
		mov	al, 1
		call	sub_1E582

loc_182BD:				; CODE XREF: sub_1823E+62j
		stc
		pop	ds
		pop	es
		pop	bp
		retn
sub_1823E	endp

; ---------------------------------------------------------------------------
word_182C2	dw 0			; DATA XREF: sub_1823E+3w
					; sub_1823E+6Ar

; =============== S U B	R O U T	I N E =======================================


sub_182C4	proc near		; CODE XREF: ToCmfMainBp
		push	cx
		push	si
		push	es
		push	ds
		mov	ax, seg	seg001
		mov	es, ax
		assume es:seg001
		mov	ds, ax
		assume ds:seg001
		mov	di, offset byte_20AAC
		mov	cx, 1F40h
		sub	ax, ax
		rep stosw
		pop	ds
		assume ds:nothing
		pop	es
		assume es:nothing
		pop	si
		pop	cx
		retn
sub_182C4	endp

; ---------------------------------------------------------------------------
		retn
; ---------------------------------------------------------------------------
		retn

; =============== S U B	R O U T	I N E =======================================


sub_182E0	proc near		; CODE XREF: sub_16C80p sub_175CD+16p
		mov	word ptr es:[bp+26h], 0
		mov	word ptr es:[bp+2Ah], 0
		mov	word ptr es:[bp+40h], 0
		mov	word ptr es:[bp+44h], 0
		mov	word ptr es:[bp+42h], 0
		mov	word ptr es:[bp+46h], 0
		mov	word ptr es:[bp+4Ch], 0
		mov	word ptr es:[bp+4Eh], 0
		mov	word ptr es:[bp+4Ah], 0
		mov	word ptr es:[bp+50h], 0
		mov	word ptr es:[bp+52h], 0
		mov	word ptr es:[bp+24h], 1
		mov	word ptr es:[bp+36h], 0
		mov	word ptr es:[bp+0Eh], 1
		mov	word ptr es:[bp+38h], 0
		mov	word ptr es:[bp+2Ch], 0
		mov	word ptr es:[bp+2Eh], 0
		mov	byte ptr es:[bp+1Dh], 0
		mov	byte ptr es:[bp+1Eh], 0
		mov	word ptr es:[bp+1Bh], 0
		mov	byte ptr es:[bp+22h], 1
		mov	byte ptr es:[bp+1Ah], 0
		mov	word ptr es:[bp+54h], 0
		mov	byte ptr es:[bp+56h], 0
		mov	byte ptr es:[bp+57h], 0
		mov	word ptr es:[bp+58h], 0FFFFh
		mov	word ptr es:[bp+5Ah], 0
		mov	word ptr es:[bp+5Ch], 0
		mov	byte ptr es:[bp+5Eh], 0
		mov	word ptr es:[bp+5Fh], 0
		mov	word ptr es:[bp+61h], 0
		mov	word ptr es:[bp+63h], 1
		mov	word ptr es:[bp+8Ah], 0
		mov	word ptr es:[bp+65h], 0
		mov	word ptr es:[bp+67h], 0
		mov	word ptr es:[bp+6Dh], 0
		mov	byte ptr es:[bp+71h], 0
		mov	byte ptr es:[bp+72h], 0
		mov	byte ptr es:[bp+73h], 0
		mov	word ptr es:[bp+12h], 0
		mov	word ptr es:[bp+14h], 0
		mov	word ptr es:[bp+10h], 0
		mov	byte ptr es:[bp+95h], 0
		mov	word ptr es:[bp+96h], 0
		retn
sub_182E0	endp


; =============== S U B	R O U T	I N E =======================================


sub_183E1	proc near		; CODE XREF: DoCmfMainB:loc_18035p
		cmp	word ptr ds:[bp+6Bh], 0
		jz	short loc_18404
		mov	si, ds:[bp+6Bh]
		mov	ax, [si+4]
		add	ds:[bp+4], ax
		mov	ax, [si+6]
		sub	ax, [si+54h]
		add	ds:[bp+6], ax
		mov	ax, [si+2Eh]
		or	ds:[bp+2Eh], ax

loc_18404:				; CODE XREF: sub_183E1+5j
		cmp	byte ptr ds:[bp+23h], 0
		jnz	short loc_1841B
		mov	ax, cs:BasePosX
		add	ds:[bp+4], ax
		mov	ax, cs:BasePosY
		add	ds:[bp+6], ax

loc_1841B:				; CODE XREF: sub_183E1+28j
		sub	bh, bh
		mov	bl, ds:[bp+1Dh]
		dec	bx
		shl	bx, 1
		call	cs:off_18453[bx]
		cmp	word ptr ds:[bp+6Bh], 0
		jz	short locret_18452
		mov	si, ds:[bp+6Bh]
		mov	ax, [si+4]
		sub	ds:[bp+4], ax
		mov	ax, [si+6]
		add	ax, [si+54h]
		sub	ds:[bp+6], ax
		cmp	word ptr [si+6Dh], 0
		jz	short locret_18452
		mov	ax, [si+6Dh]
		mov	ds:[bp+0Eh], ax

locret_18452:				; CODE XREF: sub_183E1+4Dj
					; sub_183E1+68j
		retn
sub_183E1	endp

; ---------------------------------------------------------------------------
off_18453	dw offset sub_18461	; DATA XREF: sub_183E1+43r
		dw offset sub_18508
		dw offset sub_1858E
		dw offset sub_18661
		dw offset sub_186CC
		dw offset sub_18796
		dw offset sub_18851

; =============== S U B	R O U T	I N E =======================================


sub_18461	proc near		; CODE XREF: sub_183E1+43p
					; DATA XREF: seg000:off_18453o
		call	sub_18912
		mov	cx, ds:[bp+4]
		mov	dx, ds:[bp+6]
		mov	ax, ds:[bp+42h]
		call	GetRandomInRange
		add	cx, ax
		mov	ax, ds:[bp+46h]
		call	GetRandomInRange
		add	dx, ax
		mov	ax, 1
		call	sub_189C3
		sub	byte ptr ds:[bp+20h], 0Ah
		cmp	byte ptr ds:[bp+20h], 0
		jnz	short locret_18507
		mov	byte ptr ds:[bp+1Eh], 0
		mov	word ptr ds:[bp+2], 0
		call	sub_180F2
		mov	ax, 3
		call	GetRandomInRange
		inc	ax
		mov	cx, ax

loc_184A7:				; CODE XREF: sub_18461+77j
		push	cx
		mov	cx, ds:[bp+4]
		mov	dx, ds:[bp+6]
		sub	dx, ds:[bp+54h]
		mov	ax, ds:[bp+42h]
		call	GetRandomInRange
		add	cx, ax
		mov	ax, ds:[bp+46h]
		call	GetRandomInRange
		add	dx, ax
		mov	ax, 0B4h ; '¥'
		call	GetRandomInRange
		add	ax, 0B4h ; '¥'
		mov	si, ax
		mov	ax, 7
		call	sub_15EF8
		pop	cx
		loop	loc_184A7
		cmp	byte ptr ds:[bp+5Eh], 0
		jz	short locret_18507
		mov	cx, ds:[bp+4]
		mov	dx, ds:[bp+6]
		add	cx, ds:[bp+40h]
		mov	ax, ds:[bp+42h]
		shr	ax, 1
		add	cx, ax
		add	dx, ds:[bp+44h]
		mov	ax, ds:[bp+46h]
		shr	ax, 1
		add	dx, ax
		mov	ax, 7
		call	sub_14567

locret_18507:				; CODE XREF: sub_18461+2Dj
					; sub_18461+7Ej ...
		retn
sub_18461	endp


; =============== S U B	R O U T	I N E =======================================


sub_18508	proc near		; CODE XREF: sub_183E1+43p
					; DATA XREF: seg000:8455o
		mov	ax, ds:[bp+34h]
		mov	cx, ds:[bp+4]
		mov	dx, ds:[bp+6]
		sub	dx, ds:[bp+54h]
		mov	bx, ds:[bp+0Ch]
		push	ds
		mov	ds, bx
		sub	si, si
		call	AddHDFSpr_Mode1
		pop	ds
		mov	cx, ds:[bp+4]
		mov	dx, ds:[bp+6]
		mov	ax, ds:[bp+42h]
		call	GetRandomInRange
		add	cx, ax
		mov	ax, ds:[bp+46h]
		call	GetRandomInRange
		add	dx, ax
		pusha
		mov	dx, 5
		call	sub_1E653
		popa
		mov	al, 2
		call	sub_1E582
		mov	ax, 6
		call	sub_15EF8
		mov	byte ptr ds:[bp+1Eh], 0
		mov	word ptr ds:[bp+2], 0
		call	sub_180F2
		cmp	byte ptr ds:[bp+5Eh], 0
		jz	short locret_1858D
		mov	cx, ds:[bp+4]
		mov	dx, ds:[bp+6]
		add	cx, ds:[bp+40h]
		mov	ax, ds:[bp+42h]
		shr	ax, 1
		add	cx, ax
		add	dx, ds:[bp+44h]
		mov	ax, ds:[bp+46h]
		shr	ax, 1
		add	dx, ax
		mov	ax, 7
		call	sub_14567

locret_1858D:				; CODE XREF: sub_18508+5Dj
		retn
sub_18508	endp


; =============== S U B	R O U T	I N E =======================================


sub_1858E	proc near		; CODE XREF: sub_183E1+43p
					; DATA XREF: seg000:8457o
		mov	ax, ds:[bp+34h]
		mov	cx, ds:[bp+4]
		mov	dx, ds:[bp+6]
		sub	dx, ds:[bp+54h]
		mov	bx, ds:[bp+0Ch]
		push	ds
		mov	ds, bx
		sub	si, si
		call	AddHDFSpr_Mode1
		pop	ds
		mov	cx, ds:[bp+4]
		mov	dx, ds:[bp+6]
		mov	ax, ds:[bp+42h]
		call	GetRandomInRange
		add	cx, ax
		mov	ax, ds:[bp+46h]
		call	GetRandomInRange
		add	dx, ax
		mov	ax, 6
		call	sub_15EF8
		mov	cx, ds:[bp+4]
		mov	dx, ds:[bp+6]
		mov	ax, ds:[bp+42h]
		call	GetRandomInRange
		add	cx, ax
		mov	ax, ds:[bp+46h]
		call	GetRandomInRange
		add	dx, ax
		mov	ax, 6
		call	sub_15EF8
		pusha
		mov	dx, 5
		call	sub_1E653
		popa
		mov	al, 2
		call	sub_1E582
		mov	si, 0
		mov	ax, 3
		call	sub_15EF8
		mov	si, 2Dh	; '-'
		mov	ax, 3
		call	sub_15EF8
		mov	si, 5Ah	; 'Z'
		mov	ax, 2
		call	sub_15EF8
		mov	si, 0B4h ; '¥'
		mov	ax, 3
		call	sub_15EF8
		mov	si, 87h	; 'á'
		mov	ax, 2
		call	sub_15EF8
		mov	byte ptr ds:[bp+1Eh], 0
		mov	word ptr ds:[bp+2], 0
		call	sub_180F2
		cmp	byte ptr ds:[bp+5Eh], 0
		jz	short locret_18660
		mov	cx, ds:[bp+4]
		mov	dx, ds:[bp+6]
		add	cx, ds:[bp+40h]
		mov	ax, ds:[bp+42h]
		shr	ax, 1
		add	cx, ax
		add	dx, ds:[bp+44h]
		mov	ax, ds:[bp+46h]
		shr	ax, 1
		add	dx, ax
		mov	ax, 7
		call	sub_14567

locret_18660:				; CODE XREF: sub_1858E+AAj
		retn
sub_1858E	endp


; =============== S U B	R O U T	I N E =======================================


sub_18661	proc near		; CODE XREF: sub_183E1+43p
					; DATA XREF: seg000:8459o
		call	sub_18912
		mov	cx, ds:[bp+4]
		mov	dx, ds:[bp+6]
		mov	ax, ds:[bp+42h]
		call	GetRandomInRange
		add	cx, ax
		mov	ax, ds:[bp+46h]
		call	GetRandomInRange
		add	dx, ax
		mov	ax, 1
		call	sub_189C3
		sub	byte ptr ds:[bp+20h], 14h
		cmp	byte ptr ds:[bp+20h], 0
		jnz	short locret_186CB
		mov	byte ptr ds:[bp+1Eh], 0
		mov	word ptr ds:[bp+2], 0
		call	sub_180F2
		cmp	byte ptr ds:[bp+5Eh], 0
		jz	short locret_186CB
		mov	cx, ds:[bp+4]
		mov	dx, ds:[bp+6]
		add	cx, ds:[bp+40h]
		mov	ax, ds:[bp+42h]
		shr	ax, 1
		add	cx, ax
		add	dx, ds:[bp+44h]
		mov	ax, ds:[bp+46h]
		shr	ax, 1
		add	dx, ax
		mov	ax, 7
		call	sub_14567

locret_186CB:				; CODE XREF: sub_18661+2Dj
					; sub_18661+42j
		retn
sub_18661	endp


; =============== S U B	R O U T	I N E =======================================


sub_186CC	proc near		; CODE XREF: sub_183E1+43p
					; DATA XREF: seg000:845Bo
		call	sub_18912
		mov	cx, ds:[bp+4]
		mov	dx, ds:[bp+6]
		mov	ax, ds:[bp+42h]
		call	GetRandomInRange
		add	cx, ax
		mov	ax, ds:[bp+46h]
		call	GetRandomInRange
		add	dx, ax
		mov	ax, 168h
		call	GetRandomInRange
		mov	si, ax
		mov	ax, 1
		call	sub_15EF8
		mov	ax, 168h
		call	GetRandomInRange
		mov	si, ax
		mov	ax, 3
		call	sub_15EF8
		mov	ax, 1
		call	GetRandomInRange
		inc	ax
		mov	cx, ax

loc_1870E:				; CODE XREF: sub_186CC+73j
		push	cx
		mov	cx, ds:[bp+4]
		mov	dx, ds:[bp+6]
		sub	dx, ds:[bp+54h]
		mov	ax, ds:[bp+42h]
		call	GetRandomInRange
		add	cx, ax
		mov	ax, ds:[bp+46h]
		call	GetRandomInRange
		add	dx, ax
		mov	ax, 0B4h ; '¥'
		call	GetRandomInRange
		add	ax, 0B4h ; '¥'
		mov	si, ax
		mov	ax, 0Ch
		call	sub_15EF8
		pop	cx
		loop	loc_1870E
		pusha
		mov	dx, 5
		call	sub_1E653
		popa
		mov	al, 2
		call	sub_1E582
		sub	byte ptr ds:[bp+20h], 5
		cmp	byte ptr ds:[bp+20h], 0
		jnz	short locret_18795
		mov	byte ptr ds:[bp+1Eh], 0
		mov	word ptr ds:[bp+2], 0
		call	sub_180F2
		cmp	byte ptr ds:[bp+5Eh], 0
		jz	short locret_18795
		mov	cx, ds:[bp+4]
		mov	dx, ds:[bp+6]
		add	cx, ds:[bp+40h]
		mov	ax, ds:[bp+42h]
		shr	ax, 1
		add	cx, ax
		add	dx, ds:[bp+44h]
		mov	ax, ds:[bp+46h]
		shr	ax, 1
		add	dx, ax
		mov	ax, 7
		call	sub_14567

locret_18795:				; CODE XREF: sub_186CC+8Cj
					; sub_186CC+A1j
		retn
sub_186CC	endp


; =============== S U B	R O U T	I N E =======================================


sub_18796	proc near		; CODE XREF: sub_183E1+43p
					; DATA XREF: seg000:845Do
		call	sub_18912
		mov	cx, ds:[bp+4]
		mov	dx, ds:[bp+6]
		mov	ax, ds:[bp+42h]
		shr	ax, 1
		add	cx, ax
		mov	ax, ds:[bp+46h]
		shr	ax, 2
		add	dx, ax
		push	cx
		push	dx
		sub	ah, ah
		mov	al, ds:[bp+21h]
		call	sub_1BE6D
		mov	si, ax
		sar	cx, 3
		sar	dx, 3
		mov	ax, cx
		mov	bx, dx
		pop	dx
		pop	cx
		add	cx, ax
		add	dx, bx
		add	byte ptr ds:[bp+21h], 3Ch ; '<'
		mov	ax, 2
		call	sub_15EF8
		sub	byte ptr ds:[bp+20h], 0Ah
		cmp	byte ptr ds:[bp+20h], 0
		jz	short loc_187E9
		jmp	locret_18507
; ---------------------------------------------------------------------------

loc_187E9:				; CODE XREF: sub_18796+4Ej
		mov	byte ptr ds:[bp+1Eh], 0
		mov	word ptr ds:[bp+2], 0
		call	sub_180F2
		mov	cx, ds:[bp+4]
		mov	dx, ds:[bp+6]
		mov	ax, ds:[bp+42h]
		shr	ax, 1
		add	cx, ax
		mov	ax, ds:[bp+46h]
		shr	ax, 2
		add	dx, ax
		mov	ax, 2
		call	sub_15EF8
		pusha
		mov	dx, 5
		call	sub_1E653
		popa
		mov	al, 2
		call	sub_1E582
		cmp	byte ptr ds:[bp+5Eh], 0
		jz	short locret_18850
		mov	cx, ds:[bp+4]
		mov	dx, ds:[bp+6]
		add	cx, ds:[bp+40h]
		mov	ax, ds:[bp+42h]
		shr	ax, 1
		add	cx, ax
		add	dx, ds:[bp+44h]
		mov	ax, ds:[bp+46h]
		shr	ax, 1
		add	dx, ax
		mov	ax, 7
		call	sub_14567

locret_18850:				; CODE XREF: sub_18796+92j
		retn
sub_18796	endp


; =============== S U B	R O U T	I N E =======================================


sub_18851	proc near		; CODE XREF: sub_183E1+43p
					; DATA XREF: seg000:845Fo
		call	sub_18912
		mov	cx, ds:[bp+4]
		mov	dx, ds:[bp+6]
		mov	ax, ds:[bp+42h]
		shr	ax, 1
		add	cx, ax
		mov	ax, ds:[bp+46h]
		shr	ax, 2
		add	dx, ax
		push	cx
		push	dx
		mov	ax, 168h
		call	GetRandomInRange
		mov	si, ax
		call	sub_1BE6D
		sar	cx, 3
		sar	dx, 3
		mov	ax, cx
		mov	bx, dx
		pop	dx
		pop	cx
		add	cx, ax
		add	dx, bx
		add	byte ptr ds:[bp+21h], 14h
		mov	ax, 1
		call	sub_15EF8
		mov	ax, 2
		call	sub_15EF8
		pusha
		mov	dx, 5
		call	sub_1E653
		popa
		mov	al, 2
		call	sub_1E582
		sub	byte ptr ds:[bp+20h], 5
		cmp	byte ptr ds:[bp+20h], 0
		jz	short loc_188B7
		jmp	locret_18507
; ---------------------------------------------------------------------------

loc_188B7:				; CODE XREF: sub_18851+61j
		mov	byte ptr ds:[bp+1Eh], 0
		mov	word ptr ds:[bp+2], 0
		call	sub_180F2
		mov	cx, ds:[bp+4]
		mov	dx, ds:[bp+6]
		mov	ax, ds:[bp+42h]
		shr	ax, 1
		add	cx, ax
		mov	ax, ds:[bp+46h]
		shr	ax, 2
		add	dx, ax
		mov	ax, 2
		call	sub_15EF8
		cmp	byte ptr ds:[bp+5Eh], 0
		jz	short locret_18911
		mov	cx, ds:[bp+4]
		mov	dx, ds:[bp+6]
		add	cx, ds:[bp+40h]
		mov	ax, ds:[bp+42h]
		shr	ax, 1
		add	cx, ax
		add	dx, ds:[bp+44h]
		mov	ax, ds:[bp+46h]
		shr	ax, 1
		add	dx, ax
		mov	ax, 7
		call	sub_14567

locret_18911:				; CODE XREF: sub_18851+98j
		retn
sub_18851	endp


; =============== S U B	R O U T	I N E =======================================


sub_18912	proc near		; CODE XREF: sub_18461p sub_18661p ...
		xor	byte ptr ds:[bp+1Fh], 0FFh
		cmp	byte ptr ds:[bp+1Fh], 0
		jz	short locret_1893B
		mov	ax, ds:[bp+34h]	; get graphics ID
		mov	cx, ds:[bp+4]	; X position
		mov	dx, ds:[bp+6]	; Y position
		sub	dx, ds:[bp+54h]
		sub	si, si		; SI = pointer to offset 0
		mov	bx, ds:[bp+0Ch]	; load HDF segment
		push	ds
		mov	ds, bx
		call	AddHDFSpr_Mode1
		pop	ds

locret_1893B:				; CODE XREF: sub_18912+Aj
		retn
sub_18912	endp


; =============== S U B	R O U T	I N E =======================================


sub_1893C	proc near		; CODE XREF: sub_176C1+27Dp
		push	si
		push	es
		mov	si, bp
		add	si, 8Ah	; 'ä'
		cmp	word ptr [si], 0
		jz	short loc_18981
		mov	ax, [si+4]
		add	al, ds:[bp+57h]
		mov	cx, ds:[bp+4]
		mov	dx, ds:[bp+6]
		add	cx, [si+6]
		add	dx, [si+8]
		sub	dx, ds:[bp+54h]
		mov	bx, ds:[bp+0Ch]
		sub	si, si
		cmp	word ptr ds:[bp+2Eh], 0
		jnz	short loc_18978
		push	ds
		mov	ds, bx
		call	AddHDFSpr_Mode0
		pop	ds
		jmp	short loc_18981
; ---------------------------------------------------------------------------

loc_18978:				; CODE XREF: sub_1893C+31j
		push	ds
		mov	ds, bx
		mov	ah, 0Fh
		call	AddHDFSpr_Mode2
		pop	ds

loc_18981:				; CODE XREF: sub_1893C+Bj
					; sub_1893C+3Aj
		pop	es
		pop	si
		retn
sub_1893C	endp


; =============== S U B	R O U T	I N E =======================================


cmfLoadText3A	proc near		; CODE XREF: cmfB3A_TextWait+Bp
		push	es
		push	ds
		mov	bx, si
		mov	al, 32h
		mov	ah, 0Fh
		call	cmfLoadTxtPtr3A
		pop	ds
		pop	es
		retn
cmfLoadText3A	endp


; =============== S U B	R O U T	I N E =======================================


cmfLoadText4F	proc near		; CODE XREF: cmfB4F_Text+Dp
		push	es
		push	ds
		mov	bx, si
		mov	al, 32h
		mov	ah, 0Fh
		call	cmfLoadTxtPtr4F
		pop	ds
		pop	es
		retn
cmfLoadText4F	endp


; =============== S U B	R O U T	I N E =======================================


cmfB_DoSomethingHDF proc near		; CODE XREF: cmfB2B_DoHDF+3p
		mov	bx, offset gfxBufPtrs_HDF
		shl	ax, 1
		add	bx, ax
		mov	ax, cs:[bx]
		mov	es:[bp+0Ch], ax
		retn
cmfB_DoSomethingHDF endp


; =============== S U B	R O U T	I N E =======================================


sub_189AF	proc near		; CODE XREF: sub_16CD5+1p
		mov	es:[bp+1Dh], al
		mov	byte ptr es:[bp+1Fh], 0
		mov	byte ptr es:[bp+20h], 64h
		mov	byte ptr es:[bp+21h], 0
		retn
sub_189AF	endp


; =============== S U B	R O U T	I N E =======================================


sub_189C3	proc near		; CODE XREF: sub_18461+20p
					; sub_18661+20p
		call	GetRandomInRange
		or	ax, ax
		jnz	short nullsub_2
		mov	ax, 2
		call	GetRandomInRange
		mov	bx, ax
		shl	bx, 1
		call	cs:off_189DB[bx]
		jmp	short nullsub_2
sub_189C3	endp

; ---------------------------------------------------------------------------
off_189DB	dw offset sub_189E3	; DATA XREF: sub_189C3+11r
		dw offset sub_189F7
		dw offset sub_18A0B
		dw offset sub_18A1A

; =============== S U B	R O U T	I N E =======================================


sub_189E3	proc near		; CODE XREF: sub_189C3+11p
					; DATA XREF: seg000:off_189DBo
		pusha
		mov	dx, 5
		call	sub_1E653
		popa
		mov	al, 2
		call	sub_1E582
		mov	ax, 6
		call	sub_15EF8
		retn
sub_189E3	endp


; =============== S U B	R O U T	I N E =======================================


sub_189F7	proc near		; CODE XREF: sub_189C3+11p
					; DATA XREF: seg000:89DDo
		pusha
		mov	dx, 5
		call	sub_1E653
		popa
		mov	al, 2
		call	sub_1E582
		mov	ax, 2
		call	sub_15EF8
		retn
sub_189F7	endp


; =============== S U B	R O U T	I N E =======================================


sub_18A0B	proc near		; CODE XREF: sub_189C3+11p
					; DATA XREF: seg000:89DFo
		mov	ax, 168h
		call	GetRandomInRange
		mov	si, ax
		mov	ax, 3
		call	sub_15EF8
		retn
sub_18A0B	endp


; =============== S U B	R O U T	I N E =======================================


sub_18A1A	proc near		; CODE XREF: sub_189C3+11p
					; DATA XREF: seg000:89E1o
		mov	ax, 0B4h ; '¥'
		call	GetRandomInRange
		add	ax, 0B4h ; '¥'
		mov	si, ax
		mov	ax, 7
		call	sub_15EF8
		retn
sub_18A1A	endp

; [00000001 BYTES: COLLAPSED FUNCTION nullsub_2. PRESS KEYPAD "+" TO EXPAND]

; =============== S U B	R O U T	I N E =======================================


sub_18A2D	proc near		; CODE XREF: sub_16D21+1Ap
					; DATA XREF: seg000:6D4Bo
		mov	cx, ds:[bp+4]
		mov	dx, ds:[bp+6]
		cmp	word ptr ds:[bp+6Bh], 0
		jz	short loc_18A4B
		push	si
		mov	si, ds:[bp+6Bh]
		add	cx, [si+4]
		add	dx, [si+6]
		sub	dx, [si+54h]
		pop	si

loc_18A4B:				; CODE XREF: sub_18A2D+Dj
		sub	cx, 20h	; ' '
		mov	ax, ds:[bp+42h]
		add	ax, 28h	; '('
		call	GetRandomInRange
		add	cx, ax
		sub	dx, 8
		mov	ax, ds:[bp+46h]
		add	ax, 10h
		call	GetRandomInRange
		add	dx, ax
		mov	ax, 2
		call	GetRandomInRange
		cmp	ax, 0
		jz	short loc_18A7B
		cmp	ax, 1
		jz	short loc_18A83
		jmp	short locret_18A89
; ---------------------------------------------------------------------------

loc_18A7B:				; CODE XREF: sub_18A2D+45j
		mov	ax, 2
		call	sub_15EF8
		jmp	short locret_18A89
; ---------------------------------------------------------------------------

loc_18A83:				; CODE XREF: sub_18A2D+4Aj
		mov	ax, 6
		call	sub_15EF8

locret_18A89:				; CODE XREF: sub_18A2D+4Cj
					; sub_18A2D+54j
		retn
sub_18A2D	endp


; =============== S U B	R O U T	I N E =======================================


sub_18A8A	proc near		; CODE XREF: sub_16D21+1Ap
					; DATA XREF: seg000:6D49o
		mov	cx, ds:[bp+4]
		mov	dx, ds:[bp+6]
		cmp	word ptr ds:[bp+6Bh], 0
		jz	short loc_18AA8
		push	si
		mov	si, ds:[bp+6Bh]
		add	cx, [si+4]
		add	dx, [si+6]
		sub	dx, [si+54h]
		pop	si

loc_18AA8:				; CODE XREF: sub_18A8A+Dj
		sub	cx, 20h	; ' '
		mov	ax, ds:[bp+42h]
		add	ax, 28h	; '('
		call	GetRandomInRange
		add	cx, ax
		sub	dx, 8
		mov	ax, ds:[bp+46h]
		add	ax, 10h
		call	GetRandomInRange
		add	dx, ax
		push	cx
		mov	ax, 0B4h ; '¥'
		call	GetRandomInRange
		add	ax, 0B4h ; '¥'
		mov	si, ax
		mov	ax, 7
		call	sub_15EF8
		pop	cx
		retn
sub_18A8A	endp


; =============== S U B	R O U T	I N E =======================================


sub_18ADA	proc near		; CODE XREF: sub_16D21+1Ap
					; DATA XREF: seg000:6D4Do
		mov	cx, ds:[bp+4]
		mov	dx, ds:[bp+6]
		cmp	word ptr ds:[bp+6Bh], 0
		jz	short loc_18AF8
		push	si
		mov	si, ds:[bp+6Bh]
		add	cx, [si+4]
		add	dx, [si+6]
		sub	dx, [si+54h]
		pop	si

loc_18AF8:				; CODE XREF: sub_18ADA+Dj
		sub	cx, 20h	; ' '
		mov	ax, ds:[bp+42h]
		add	ax, 28h	; '('
		call	GetRandomInRange
		add	cx, ax
		sub	dx, 8
		mov	ax, ds:[bp+46h]
		add	ax, 10h
		call	GetRandomInRange
		add	dx, ax
		push	cx
		mov	ax, 0B4h ; '¥'
		call	GetRandomInRange
		add	ax, 0B4h ; '¥'
		mov	si, ax
		mov	ax, 0Ch
		call	sub_15EF8
		pop	cx
		retn
sub_18ADA	endp


; =============== S U B	R O U T	I N E =======================================


sub_18B2A	proc near		; CODE XREF: sub_16D21+1Ap
					; DATA XREF: seg000:6D4Fo
		mov	cx, ds:[bp+4]
		mov	dx, ds:[bp+6]
		cmp	word ptr ds:[bp+6Bh], 0
		jz	short loc_18B48
		push	si
		mov	si, ds:[bp+6Bh]
		add	cx, [si+4]
		add	dx, [si+6]
		sub	dx, [si+54h]
		pop	si

loc_18B48:				; CODE XREF: sub_18B2A+Dj
		sub	cx, 20h	; ' '
		mov	ax, ds:[bp+42h]
		add	ax, 28h	; '('
		call	GetRandomInRange
		add	cx, ax
		sub	dx, 8
		mov	ax, ds:[bp+46h]
		add	ax, 10h
		call	GetRandomInRange
		add	dx, ax
		push	cx
		mov	ax, 168h
		call	GetRandomInRange
		mov	si, ax
		mov	ax, 0Bh
		call	sub_15EF8
		pop	cx
		retn
sub_18B2A	endp


; =============== S U B	R O U T	I N E =======================================


sub_18B77	proc near		; CODE XREF: sub_12550p
		push	es
		push	ds
		pusha
		mov	ax, cs
		mov	es, ax
		assume es:seg000
		mov	di, offset byte_18B8D
		mov	cx, 28h
		sub	ax, ax
		cld
		rep stosw
		popa
		pop	ds
		pop	es
		assume es:nothing
		retn
sub_18B77	endp

; ---------------------------------------------------------------------------
byte_18B8D	db 51h dup(0)		; DATA XREF: sub_18B77+7o

; =============== S U B	R O U T	I N E =======================================


sub_18BDE	proc near		; CODE XREF: sub_1686A+67p
					; seg000:8F64p	...
		push	bp
		push	es
		push	ds
		push	ax
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		pop	ax
		mov	cs:word_18C3D, cx
		mov	bp, offset byte_2492C
		mov	cx, 1Eh

loc_18BF3:				; CODE XREF: sub_18BDE+3Dj
		cmp	byte ptr ds:[bp+0], 0
		jnz	short loc_18C18
		mov	ds:[bp+0], al
		mov	byte ptr ds:[bp+13h], 1
		mov	bx, ax
		shl	bx, 1
		push	cx
		push	bp

loc_18C09:
		mov	cx, cs:word_18C3D
		call	cs:off_18C21[bx]
		pop	bp
		pop	cx
		mov	cx, 1

loc_18C18:				; CODE XREF: sub_18BDE+1Aj
		add	bp, 15h
		loop	loc_18BF3
		pop	ds
		assume ds:nothing
		pop	es
		pop	bp
		retn
sub_18BDE	endp

; ---------------------------------------------------------------------------
off_18C21	dw offset start		; 0 ; DATA XREF: sub_18BDE+30r
		dw offset loc_18D16	; 1
		dw offset loc_18D5B	; 2
		dw offset loc_18EA4	; 3
		dw offset loc_18ECB	; 4
		dw offset loc_19249	; 5
		dw offset loc_19354	; 6
		dw offset loc_18D98	; 7
		dw offset loc_18DD5	; 8
		dw offset loc_18E1A	; 9
		dw offset loc_18E5F	; 0Ah
		dw offset loc_18C86	; 0Bh
		dw offset loc_18CD4	; 0Ch
		dw offset loc_1914D	; 0Dh
word_18C3D	dw 0			; DATA XREF: sub_18BDE+Aw
					; sub_18BDE:loc_18C09r

; =============== S U B	R O U T	I N E =======================================


sub_18C3F	proc near		; CODE XREF: sub_10F09+3Dp
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		mov	bp, offset byte_2492C
		mov	cx, 1Eh

loc_18C4A:				; CODE XREF: sub_18C3F+28j
		cmp	byte ptr ds:[bp+0], 0
		jz	short loc_18C64
		sub	ah, ah
		mov	al, ds:[bp+0]
		mov	bx, ax
		shl	bx, 1
		push	cx
		push	bp
		call	cs:off_18C6A[bx]
		pop	bp
		pop	cx

loc_18C64:				; CODE XREF: sub_18C3F+10j
		add	bp, 15h
		loop	loc_18C4A
		retn
sub_18C3F	endp

; ---------------------------------------------------------------------------
off_18C6A	dw offset start		; 0 ; DATA XREF: sub_18C3F+1Er
		dw offset loc_193D7	; 1
		dw offset loc_193D7	; 2
		dw offset loc_1945B	; 3
		dw offset loc_190D2	; 4
		dw offset loc_1928C	; 5
		dw offset loc_19376	; 6
		dw offset loc_193D7	; 7
		dw offset loc_193D7	; 8
		dw offset loc_193D7	; 9
		dw offset loc_193D7	; 0Ah
		dw offset loc_18F26	; 0Bh
		dw offset sub_19077	; 0Ch
		dw offset loc_1918A	; 0Dh
; ---------------------------------------------------------------------------

loc_18C86:				; DATA XREF: seg000:off_18C21o
		sub	cx, 8
		sub	dx, 4
		call	sub_1952C
		cmp	si, 0FFFFh
		jnz	short loc_18CC7
		mov	si, cs:word_1EA52
		mov	di, cs:word_1EA56
		call	sub_1BE3A
		shl	cx, 2
		shl	dx, 2

loc_18CA7:				; CODE XREF: seg000:8CD2j
		mov	byte ptr ds:[bp+14h], 4
		mov	ds:[bp+9], cx
		mov	ds:[bp+0Bh], dx
		mov	word ptr ds:[bp+0Dh], 0
		mov	word ptr ds:[bp+0Fh], 0
		mov	word ptr ds:[bp+11h], 10h
		retn
; ---------------------------------------------------------------------------

loc_18CC7:				; CODE XREF: seg000:8C92j
		mov	ax, si
		call	sub_1BE93
		shl	cx, 2
		shl	dx, 2
		jmp	short loc_18CA7
; ---------------------------------------------------------------------------

loc_18CD4:				; DATA XREF: seg000:off_18C21o
		call	sub_1952C
		cmp	si, 0FFFFh
		jnz	short loc_18D0F
		mov	si, cs:word_1EA52
		mov	di, cs:word_1EA56
		call	sub_1BE3A
		shl	cx, 1
		shl	dx, 1

loc_18CED:				; CODE XREF: seg000:8D14j
		mov	word ptr ds:[bp+9], 0
		mov	word ptr ds:[bp+0Bh], 0
		mov	word ptr ds:[bp+0Dh], 0
		mov	word ptr ds:[bp+0Fh], 0
		mov	word ptr ds:[bp+11h], 10h
		call	sub_19077
		retn
; ---------------------------------------------------------------------------

loc_18D0F:				; CODE XREF: seg000:8CDAj
		mov	ax, si
		call	sub_1BE93
		jmp	short loc_18CED
; ---------------------------------------------------------------------------

loc_18D16:				; DATA XREF: seg000:off_18C21o
		sub	cx, 8
		sub	dx, 4
		call	sub_1952C
		cmp	si, 0FFFFh
		jnz	short loc_18D50
		mov	si, cs:word_1EA52
		mov	di, cs:word_1EA56
		call	sub_1BE3A
		shl	cx, 1
		shl	dx, 1

loc_18D35:				; CODE XREF: seg000:8D59j
		mov	ds:[bp+9], cx
		mov	ds:[bp+0Bh], dx
		mov	word ptr ds:[bp+0Dh], 0
		mov	word ptr ds:[bp+0Fh], 0
		mov	word ptr ds:[bp+11h], 10h
		retn
; ---------------------------------------------------------------------------

loc_18D50:				; CODE XREF: seg000:8D22j
		mov	ax, si
		call	sub_1BE93
		shl	cx, 1
		shl	dx, 1
		jmp	short loc_18D35
; ---------------------------------------------------------------------------

loc_18D5B:				; DATA XREF: seg000:off_18C21o
		sub	cx, 8
		sub	dx, 4
		call	sub_1952C
		cmp	si, 0FFFFh
		jnz	short loc_18D91
		mov	si, cs:word_1EA52
		mov	di, cs:word_1EA56
		call	sub_1BE3A

loc_18D76:				; CODE XREF: seg000:8D96j
		mov	ds:[bp+9], cx
		mov	ds:[bp+0Bh], dx
		mov	word ptr ds:[bp+0Dh], 4
		mov	word ptr ds:[bp+0Fh], 0
		mov	word ptr ds:[bp+11h], 20h ; ' '
		retn
; ---------------------------------------------------------------------------

loc_18D91:				; CODE XREF: seg000:8D67j
		mov	ax, si
		call	sub_1BE93
		jmp	short loc_18D76
; ---------------------------------------------------------------------------

loc_18D98:				; DATA XREF: seg000:off_18C21o
		sub	cx, 8
		sub	dx, 4
		call	sub_1952C
		cmp	si, 0FFFFh
		jnz	short loc_18DCE
		mov	si, cs:word_1EA52
		mov	di, cs:word_1EA56
		call	sub_1BE3A

loc_18DB3:				; CODE XREF: seg000:8DD3j
		mov	ds:[bp+9], cx
		mov	ds:[bp+0Bh], dx
		mov	word ptr ds:[bp+0Dh], 8
		mov	word ptr ds:[bp+0Fh], 0
		mov	word ptr ds:[bp+11h], 20h ; ' '
		retn
; ---------------------------------------------------------------------------

loc_18DCE:				; CODE XREF: seg000:8DA4j
		mov	ax, si
		call	sub_1BE93
		jmp	short loc_18DB3
; ---------------------------------------------------------------------------

loc_18DD5:				; DATA XREF: seg000:off_18C21o
		sub	cx, 8
		sub	dx, 4
		call	sub_1952C
		cmp	si, 0FFFFh
		jnz	short loc_18E0F
		mov	si, cs:word_1EA52
		mov	di, cs:word_1EA56
		call	sub_1BE3A
		shl	cx, 1
		shl	dx, 1

loc_18DF4:				; CODE XREF: seg000:8E18j
		mov	ds:[bp+9], cx
		mov	ds:[bp+0Bh], dx
		mov	word ptr ds:[bp+0Dh], 0Ch
		mov	word ptr ds:[bp+0Fh], 0
		mov	word ptr ds:[bp+11h], 10h
		retn
; ---------------------------------------------------------------------------

loc_18E0F:				; CODE XREF: seg000:8DE1j
		mov	ax, si
		call	sub_1BE93
		shl	cx, 1
		shl	dx, 1
		jmp	short loc_18DF4
; ---------------------------------------------------------------------------

loc_18E1A:				; DATA XREF: seg000:off_18C21o
		sub	cx, 8
		sub	dx, 4
		call	sub_1952C
		cmp	si, 0FFFFh
		jnz	short loc_18E54
		mov	si, cs:word_1EA52
		mov	di, cs:word_1EA56
		call	sub_1BE3A
		shl	cx, 1
		shl	dx, 1

loc_18E39:				; CODE XREF: seg000:8E5Dj
		mov	ds:[bp+9], cx
		mov	ds:[bp+0Bh], dx
		mov	word ptr ds:[bp+0Dh], 10h
		mov	word ptr ds:[bp+0Fh], 0
		mov	word ptr ds:[bp+11h], 18h
		retn
; ---------------------------------------------------------------------------

loc_18E54:				; CODE XREF: seg000:8E26j
		mov	ax, si
		call	sub_1BE93
		shl	cx, 1
		shl	dx, 1
		jmp	short loc_18E39
; ---------------------------------------------------------------------------

loc_18E5F:				; DATA XREF: seg000:off_18C21o
		sub	cx, 8
		sub	dx, 4
		call	sub_1952C
		cmp	si, 0FFFFh
		jnz	short loc_18E99
		mov	si, cs:word_1EA52
		mov	di, cs:word_1EA56
		call	sub_1BE3A
		shl	cx, 1
		shl	dx, 1

loc_18E7E:				; CODE XREF: seg000:8EA2j
		mov	ds:[bp+9], cx
		mov	ds:[bp+0Bh], dx
		mov	word ptr ds:[bp+0Dh], 14h
		mov	word ptr ds:[bp+0Fh], 0
		mov	word ptr ds:[bp+11h], 30h ; '0'
		retn
; ---------------------------------------------------------------------------

loc_18E99:				; CODE XREF: seg000:8E6Bj
		mov	ax, si
		call	sub_1BE93
		shl	cx, 1
		shl	dx, 1
		jmp	short loc_18E7E
; ---------------------------------------------------------------------------

loc_18EA4:				; DATA XREF: seg000:off_18C21o
		call	sub_1952C
		mov	ax, si
		call	sub_1BE6D
		shl	cx, 1
		shl	dx, 1
		mov	ds:[bp+9], cx
		mov	ds:[bp+0Bh], dx

loc_18EB8:
		mov	word ptr ds:[bp+0Dh], 4
		mov	word ptr ds:[bp+0Fh], 0
		mov	word ptr ds:[bp+11h], 8
		retn
; ---------------------------------------------------------------------------

loc_18ECB:				; DATA XREF: seg000:off_18C21o
		sub	cx, 8
		sub	dx, 4
		call	sub_1952C
		cmp	si, 0FFFFh
		jnz	short loc_18F0D
		mov	ax, si
		shr	ax, 4
		and	ax, 0Fh
		mov	ds:[bp+0Dh], ax
		mov	si, cs:word_1EA52
		mov	di, cs:word_1EA56
		call	sub_1BE3A
		shl	cx, 2
		shl	dx, 2

loc_18EF8:				; CODE XREF: seg000:8F24j
		mov	ds:[bp+9], cx
		mov	ds:[bp+0Bh], dx
		mov	word ptr ds:[bp+0Fh], 0
		mov	word ptr ds:[bp+11h], 8
		retn
; ---------------------------------------------------------------------------

loc_18F0D:				; CODE XREF: seg000:8ED7j
		mov	ax, si
		shr	ax, 4
		and	ax, 0Fh
		mov	ds:[bp+0Dh], ax
		mov	ax, si
		call	sub_1BE93
		shl	cx, 2
		shl	dx, 2
		jmp	short loc_18EF8
; ---------------------------------------------------------------------------

loc_18F26:				; DATA XREF: seg000:off_18C6Ao
		cmp	byte ptr ds:[bp+13h], 0
		jz	short loc_18F4E
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		push	ds
		mov	ds, cs:segHdf_ns_e1
		assume ds:nothing
		sub	si, si
		mov	ax, 0
		mov	ah, 0Fh
		call	AddHDFSpr_Mode2
		pop	ds
		mov	byte ptr ds:[bp+13h], 0
		jmp	locret_19076
; ---------------------------------------------------------------------------

loc_18F4E:				; CODE XREF: seg000:8F2Bj
		sub	ch, ch
		mov	cl, ds:[bp+14h]
		shr	cx, 3
		inc	cx

loc_18F58:				; CODE XREF: seg000:8FCFj
		push	cx
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		mov	ax, 0Ch
		call	sub_18BDE
		call	sub_1951B
		mov	ax, ds:[bp+0Dh]
		mov	cx, ds:[bp+3]
		shr	cx, 6
		mov	ds:[bp+1], cx
		mov	dx, ds:[bp+7]
		shr	dx, 6
		mov	ds:[bp+5], dx
		push	ds
		mov	ds, cs:segHdf_ns_e1
		sub	si, si
		mov	ah, 0Fh
		call	AddHDFSpr_Mode2
		pop	ds
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		call	sub_194CF
		jnb	short loc_18FCE
		call	sub_1959D
		mov	ax, ds:[bp+9]
		sar	ax, 4
		mov	cs:word_1EA54, ax
		mov	ax, ds:[bp+0Bh]
		sar	ax, 4
		mov	cs:word_1EA58, ax
		mov	si, 0FFFFh
		mov	byte ptr ds:[bp+0], 0
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		mov	ax, 0Bh
		call	sub_18BDE

loc_18FCE:				; CODE XREF: seg000:8F9Dj
		pop	cx
		loop	loc_18F58
		mov	ax, ds:[bp+1]
		cmp	cs:word_1EA52, ax
		jnb	short loc_18FE3
		sub	word ptr ds:[bp+9], 20h	; ' '
		jmp	short loc_18FE8
; ---------------------------------------------------------------------------

loc_18FE3:				; CODE XREF: seg000:8FDAj
		add	word ptr ds:[bp+9], 20h	; ' '

loc_18FE8:				; CODE XREF: seg000:8FE1j
		mov	ax, ds:[bp+5]
		cmp	cs:word_1EA56, ax
		jnb	short loc_18FFA
		sub	word ptr ds:[bp+0Bh], 20h ; ' '
		jmp	short loc_18FFF
; ---------------------------------------------------------------------------

loc_18FFA:				; CODE XREF: seg000:8FF1j
		add	word ptr ds:[bp+0Bh], 20h ; ' '

loc_18FFF:				; CODE XREF: seg000:8FF8j
		mov	ax, ds:[bp+9]
		test	ah, 80h
		jnz	short loc_19016
		cmp	ax, 17Dh
		jb	short loc_19026
		mov	ax, 17Ch
		mov	ds:[bp+9], ax
		jmp	short loc_19026
; ---------------------------------------------------------------------------

loc_19016:				; CODE XREF: seg000:9006j
		neg	ax
		cmp	ax, 17Dh
		jb	short loc_19020
		mov	ax, 17Ch

loc_19020:				; CODE XREF: seg000:901Bj
		neg	ax
		mov	ds:[bp+9], ax

loc_19026:				; CODE XREF: seg000:900Bj seg000:9014j
		mov	ax, ds:[bp+0Bh]
		test	ah, 80h
		jnz	short loc_1903D
		cmp	ax, 0B2h ; '≤'
		jb	short loc_1904D
		mov	ax, 0B1h ; '±'
		mov	ds:[bp+0Bh], ax
		jmp	short loc_1904D
; ---------------------------------------------------------------------------

loc_1903D:				; CODE XREF: seg000:902Dj
		neg	ax
		cmp	ax, 0B2h ; '≤'
		jb	short loc_19047
		mov	ax, 0B1h ; '±'

loc_19047:				; CODE XREF: seg000:9042j
		neg	ax
		mov	ds:[bp+0Bh], ax

loc_1904D:				; CODE XREF: seg000:9032j seg000:903Bj
		inc	byte ptr ds:[bp+14h]
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		add	cx, 80h	; 'Ä'
		add	dx, 20h	; ' '
		cmp	cx, 380h
		jb	short loc_1906B
		mov	byte ptr ds:[bp+0], 0

loc_1906B:				; CODE XREF: seg000:9064j
		cmp	dx, 108h
		jb	short locret_19076
		mov	byte ptr ds:[bp+0], 0

locret_19076:				; CODE XREF: seg000:8F4Bj seg000:906Fj
		retn

; =============== S U B	R O U T	I N E =======================================


sub_19077	proc near		; CODE XREF: seg000:8D0Bp
					; DATA XREF: seg000:off_18C6Ao
		call	sub_1951B
		mov	ax, ds:[bp+0Dh]
		mov	bx, ds:[bp+0Fh]
		mov	ah, cs:byte_190CD[bx]
		mov	cx, ds:[bp+3]
		shr	cx, 6
		mov	ds:[bp+1], cx
		mov	dx, ds:[bp+7]
		shr	dx, 6
		mov	ds:[bp+5], dx
		push	ds
		mov	ds, cs:segHdf_ns_e1
		sub	si, si
		call	AddHDFSpr_Mode2
		pop	ds
		mov	ax, ds:[bp+0Fh]
		inc	ax
		cmp	ax, 4
		jb	short loc_190B8
		mov	byte ptr ds:[bp+0], 0

loc_190B8:				; CODE XREF: sub_19077+3Aj
		mov	ds:[bp+0Fh], ax
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		call	sub_194CF
		jnb	short locret_190CC
		call	sub_1959D

locret_190CC:				; CODE XREF: sub_19077+50j
		retn
sub_19077	endp

; ---------------------------------------------------------------------------
byte_190CD	db 0Fh,	0Eh, 0Dh, 0Ch, 1 ; DATA	XREF: sub_19077+Br
; ---------------------------------------------------------------------------

loc_190D2:				; DATA XREF: seg000:off_18C6Ao
		call	sub_19547
		cmp	byte ptr ds:[bp+13h], 0
		jz	short loc_190F9
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		push	ds
		mov	ds, cs:segHdf_shot
		sub	si, si
		mov	ax, 14h
		mov	ah, 0Fh
		pop	ds
		mov	byte ptr ds:[bp+13h], 0
		jmp	short locret_1914C
; ---------------------------------------------------------------------------

loc_190F9:				; CODE XREF: seg000:90DAj
		call	sub_1951B
		mov	ax, ds:[bp+0Dh]
		add	ax, ds:[bp+0Fh]
		mov	cx, ds:[bp+3]
		shr	cx, 6
		mov	ds:[bp+1], cx
		mov	dx, ds:[bp+7]
		shr	dx, 6
		mov	ds:[bp+5], dx
		push	ds
		mov	ds, cs:segHdf_eshot6
		sub	si, si
		call	AddHDFSpr_Mode0
		pop	ds
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		call	sub_194CF
		jnb	short loc_19149
		call	sub_1959D
		mov	byte ptr ds:[bp+0], 0
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		mov	ax, 5
		call	sub_14567

loc_19149:				; CODE XREF: seg000:9131j
		call	sub_1955E

locret_1914C:				; CODE XREF: seg000:90F7j
		retn
; ---------------------------------------------------------------------------

loc_1914D:				; DATA XREF: seg000:off_18C21o
		sub	cx, 18h
		sub	dx, 0Ch
		call	sub_1952C
		cmp	si, 0FFFFh
		jnz	short loc_1917F
		call	sub_1BE93
		shl	cx, 3
		shl	dx, 3

loc_19164:				; CODE XREF: seg000:9188j
		mov	ds:[bp+9], cx
		mov	ds:[bp+0Bh], dx
		mov	word ptr ds:[bp+0Dh], 0
		mov	word ptr ds:[bp+0Fh], 0
		mov	word ptr ds:[bp+11h], 20h ; ' '
		retn
; ---------------------------------------------------------------------------

loc_1917F:				; CODE XREF: seg000:9159j
		mov	ax, si
		call	sub_1BE93
		shl	cx, 1
		shl	dx, 1
		jmp	short loc_19164
; ---------------------------------------------------------------------------

loc_1918A:				; DATA XREF: seg000:off_18C6Ao
		call	sub_19547
		call	sub_1951B
		mov	ax, ds:[bp+0Dh]
		add	ax, ds:[bp+0Fh]
		mov	cx, ds:[bp+3]
		shr	cx, 6
		mov	ds:[bp+1], cx
		mov	dx, ds:[bp+7]
		shr	dx, 6
		mov	ds:[bp+5], dx
		push	ds
		mov	ds, cs:segHdf_efire
		sub	si, si
		call	AddHDFSpr_Mode0
		pop	ds
		mov	ax, ds:[bp+0Fh]
		inc	ax
		cmp	ax, 4
		jb	short loc_191D4
		mov	ax, 4
		mov	byte ptr ds:[bp+0], 0
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]

loc_191D4:				; CODE XREF: seg000:91C2j
		mov	ds:[bp+0Fh], ax
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		call	sub_194CF
		jnb	short loc_191FB
		call	sub_1959D
		mov	byte ptr ds:[bp+0], 0
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		mov	ax, 6
		call	sub_18BDE

loc_191FB:				; CODE XREF: seg000:91E3j
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		add	cx, 40h	; '@'
		add	dx, 20h	; ' '
		cmp	cx, 2A0h
		jb	short loc_19214
		mov	byte ptr ds:[bp+0], 0

loc_19214:				; CODE XREF: seg000:920Dj
		cmp	dx, 0D8h ; 'ÿ'
		jb	short loc_1921F
		mov	byte ptr ds:[bp+0], 0

loc_1921F:				; CODE XREF: seg000:9218j
		sub	cx, 40h	; '@'
		sub	dx, 20h	; ' '
		sub	cx, 8
		add	dx, 8
		call	sub_1A65E
		cmp	ax, cs:word_1BE30
		jb	short locret_19248
		mov	byte ptr ds:[bp+0], 0
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		mov	ax, 6
		call	sub_18BDE

locret_19248:				; CODE XREF: seg000:9233j
		retn
; ---------------------------------------------------------------------------

loc_19249:				; DATA XREF: seg000:off_18C21o
		sub	cx, 18h
		sub	dx, 0Ch
		call	sub_1952C
		cmp	si, 0FFFFh
		jnz	short loc_19285
		mov	si, cs:word_1EA52
		mov	di, cs:word_1EA56
		call	sub_1BE3A
		shl	cx, 3
		shl	dx, 3

loc_1926A:				; CODE XREF: seg000:928Aj
		mov	ds:[bp+9], cx
		mov	ds:[bp+0Bh], dx
		mov	word ptr ds:[bp+0Dh], 0
		mov	word ptr ds:[bp+0Fh], 0
		mov	word ptr ds:[bp+11h], 20h ; ' '
		retn
; ---------------------------------------------------------------------------

loc_19285:				; CODE XREF: seg000:9255j
		mov	ax, si
		call	sub_1BE93
		jmp	short loc_1926A
; ---------------------------------------------------------------------------

loc_1928C:				; DATA XREF: seg000:off_18C6Ao
		call	sub_19547
		call	sub_1951B
		mov	ax, ds:[bp+0Dh]
		add	ax, ds:[bp+0Fh]
		shr	ax, 2
		mov	cx, ds:[bp+3]
		shr	cx, 6
		mov	ds:[bp+1], cx
		mov	dx, ds:[bp+7]
		shr	dx, 6
		mov	ds:[bp+5], dx
		push	ds
		mov	ds, cs:segHdf_efire
		sub	si, si
		call	AddHDFSpr_Mode0
		pop	ds
		mov	ax, ds:[bp+0Fh]
		inc	ax
		cmp	ax, 10h
		jb	short loc_192DF
		mov	ax, 10h
		mov	byte ptr ds:[bp+0], 0
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		mov	ax, 6
		call	sub_18BDE

loc_192DF:				; CODE XREF: seg000:92C7j
		mov	ds:[bp+0Fh], ax
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		call	sub_194CF
		jnb	short loc_19306
		call	sub_1959D
		mov	byte ptr ds:[bp+0], 0
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		mov	ax, 6
		call	sub_18BDE

loc_19306:				; CODE XREF: seg000:92EEj
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		add	cx, 40h	; '@'
		add	dx, 20h	; ' '
		cmp	cx, 2A0h
		jb	short loc_1931F
		mov	byte ptr ds:[bp+0], 0

loc_1931F:				; CODE XREF: seg000:9318j
		cmp	dx, 0D8h ; 'ÿ'
		jb	short loc_1932A
		mov	byte ptr ds:[bp+0], 0

loc_1932A:				; CODE XREF: seg000:9323j
		sub	cx, 40h	; '@'
		sub	dx, 20h	; ' '
		sub	cx, 8
		add	dx, 8
		call	sub_1A65E
		cmp	ax, cs:word_1BE30
		jb	short locret_19353
		mov	byte ptr ds:[bp+0], 0
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		mov	ax, 6
		call	sub_18BDE

locret_19353:				; CODE XREF: seg000:933Ej
		retn
; ---------------------------------------------------------------------------

loc_19354:				; DATA XREF: seg000:off_18C21o
		call	sub_1952C
		mov	word ptr ds:[bp+9], 0
		mov	word ptr ds:[bp+0Bh], 0
		mov	word ptr ds:[bp+0Dh], 0
		mov	word ptr ds:[bp+0Fh], 8
		mov	word ptr ds:[bp+11h], 10h
		retn
; ---------------------------------------------------------------------------

loc_19376:				; DATA XREF: seg000:off_18C6Ao
		call	sub_19547
		call	sub_1951B
		mov	ax, ds:[bp+0Dh]
		add	ax, ds:[bp+0Fh]
		shr	ax, 1
		mov	cx, ds:[bp+3]
		shr	cx, 6
		mov	ds:[bp+1], cx
		mov	dx, ds:[bp+7]
		shr	dx, 6
		mov	ds:[bp+5], dx
		push	ds
		mov	ds, cs:segHdf_efire
		sub	si, si
		call	AddHDFSpr_Mode0
		pop	ds
		mov	ax, ds:[bp+0Fh]
		dec	ax
		cmp	ax, 0
		jnz	short loc_193BA
		mov	ax, 1
		mov	byte ptr ds:[bp+0], 0

loc_193BA:				; CODE XREF: seg000:93B0j
		mov	ds:[bp+0Fh], ax
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		call	sub_194CF
		jnb	short loc_193D3
		call	sub_1959D
		mov	byte ptr ds:[bp+0], 0

loc_193D3:				; CODE XREF: seg000:93C9j
		call	sub_1955E
		retn
; ---------------------------------------------------------------------------

loc_193D7:				; DATA XREF: seg000:off_18C6Ao
		call	sub_19547
		cmp	byte ptr ds:[bp+13h], 0
		jz	short loc_193FE
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		push	ds
		mov	ds, cs:segHdf_shot
		sub	si, si
		mov	ax, 14h
		mov	ah, 0Fh
		pop	ds
		mov	byte ptr ds:[bp+13h], 0
		jmp	short locret_1945A
; ---------------------------------------------------------------------------

loc_193FE:				; CODE XREF: seg000:93DFj
		call	sub_1951B
		inc	word ptr ds:[bp+0Fh]
		and	word ptr ds:[bp+0Fh], 3
		mov	ax, ds:[bp+0Dh]
		add	ax, ds:[bp+0Fh]
		mov	cx, ds:[bp+3]
		shr	cx, 6
		mov	ds:[bp+1], cx
		mov	dx, ds:[bp+7]
		shr	dx, 6
		mov	ds:[bp+5], dx
		push	ds
		mov	ds, cs:segHdf_eshot1
		sub	si, si
		call	AddHDFSpr_Mode0
		pop	ds
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		call	sub_194CF
		jnb	short loc_19457
		call	sub_1959D
		mov	byte ptr ds:[bp+0], 0
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		mov	ax, 5
		call	sub_14567

loc_19457:				; CODE XREF: seg000:943Fj
		call	sub_1955E

locret_1945A:				; CODE XREF: seg000:93FCj
		retn
; ---------------------------------------------------------------------------

loc_1945B:				; DATA XREF: seg000:off_18C6Ao
		call	sub_1951B
		mov	ax, ds:[bp+0Fh]
		inc	ax
		cmp	ax, 5
		jb	short loc_19469
		dec	ax

loc_19469:				; CODE XREF: seg000:9466j
		mov	ds:[bp+0Fh], ax
		mov	ax, ds:[bp+0Dh]
		add	ax, ds:[bp+0Fh]
		mov	cx, ds:[bp+3]
		shr	cx, 6
		mov	ds:[bp+1], cx
		mov	dx, ds:[bp+7]
		shr	dx, 6
		mov	ds:[bp+5], dx
		push	ds
		mov	ds, cs:segHdf_shot
		sub	si, si
		pop	ds
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		call	sub_194CF
		jnb	short loc_194C8
		mov	ax, ds:[bp+11h]
		call	sub_13EE7
		mov	ax, 2
		call	sub_15EF8
		mov	ax, 168h
		call	GetRandomInRange
		mov	si, ax
		mov	ax, 3
		call	sub_15EF8
		mov	cs:word_1EA54, 0FFFCh
		mov	byte ptr ds:[bp+0], 0

loc_194C8:				; CODE XREF: seg000:949Fj
		call	sub_19547
		call	sub_1955E
		retn

; =============== S U B	R O U T	I N E =======================================


sub_194CF	proc near		; CODE XREF: sub_176C1+1A8p
					; seg000:8F9Ap	...
		push	cx
		push	dx
		push	si
		push	di
		cmp	cs:word_111F1, 0
		jnz	short loc_19515
		cmp	cs:word_1EA66, 0
		jnz	short loc_19515
		add	cx, 7
		add	dx, 3
		mov	si, cs:word_1EA52
		mov	di, cs:word_1EA56
		add	si, 10h
		add	di, 0
		cmp	cx, si
		jb	short loc_19515
		cmp	dx, di
		jb	short loc_19515
		add	si, 20h	; ' '
		add	di, 28h	; '('
		cmp	cx, si
		jnb	short loc_19515
		cmp	dx, di
		jnb	short loc_19515
		pop	di
		pop	si
		pop	dx
		pop	cx
		stc
		retn
; ---------------------------------------------------------------------------

loc_19515:				; CODE XREF: sub_194CF+Aj
					; sub_194CF+12j ...
		pop	di
		pop	si
		pop	dx
		pop	cx
		clc
		retn
sub_194CF	endp


; =============== S U B	R O U T	I N E =======================================


sub_1951B	proc near		; CODE XREF: seg000:8F67p sub_19077p ...
		mov	ax, ds:[bp+9]
		add	ds:[bp+3], ax
		mov	ax, ds:[bp+0Bh]
		add	ds:[bp+7], ax
		retn
sub_1951B	endp


; =============== S U B	R O U T	I N E =======================================


sub_1952C	proc near		; CODE XREF: seg000:8C8Cp
					; seg000:loc_18CD4p ...
		push	cx
		push	dx
		mov	ds:[bp+1], cx
		shl	cx, 6
		mov	ds:[bp+3], cx
		mov	ds:[bp+5], dx
		shl	dx, 6
		mov	ds:[bp+7], dx
		pop	dx
		pop	cx
		retn
sub_1952C	endp


; =============== S U B	R O U T	I N E =======================================


sub_19547	proc near		; CODE XREF: seg000:loc_190D2p
					; seg000:loc_1918Ap ...
		mov	ax, cs:BasePosX
		shl	ax, 6
		add	ds:[bp+3], ax
		mov	ax, cs:BasePosY
		shl	ax, 6
		add	ds:[bp+7], ax
		retn
sub_19547	endp


; =============== S U B	R O U T	I N E =======================================


sub_1955E	proc near		; CODE XREF: seg000:loc_19149p
					; seg000:loc_193D3p ...
		mov	cx, ds:[bp+1]
		mov	dx, ds:[bp+5]
		add	cx, 80h	; 'Ä'
		add	dx, 40h	; '@'
		cmp	cx, 380h
		jb	short loc_19578
		mov	byte ptr ds:[bp+0], 0

loc_19578:				; CODE XREF: sub_1955E+13j
		cmp	dx, 148h
		jb	short loc_19583
		mov	byte ptr ds:[bp+0], 0

loc_19583:				; CODE XREF: sub_1955E+1Ej
		sub	cx, 80h	; 'Ä'
		sub	dx, 40h	; '@'
		sub	cx, 8
		call	sub_1A65E
		cmp	ax, cs:word_1BE30
		jb	short locret_1959C
		mov	byte ptr ds:[bp+0], 0

locret_1959C:				; CODE XREF: sub_1955E+37j
		retn
sub_1955E	endp


; =============== S U B	R O U T	I N E =======================================


sub_1959D	proc near		; CODE XREF: seg000:8F9Fp
					; sub_19077+52p ...
		mov	ax, ds:[bp+11h]
		call	sub_13EE7
		mov	ax, 2
		call	sub_15EF8
		pusha
		mov	dx, 5
		call	sub_1E653
		mov	ax, 6
		call	sub_1E582
		popa
		retn
sub_1959D	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


TestUserInput	proc near		; CODE XREF: DoOneLevel:loc_10685p
					; DoOneLevel:loc_10759p ...
		push	es
		push	ds
		push	ax
		push	cx
		push	bx
		push	si
		push	di
		call	sub_19620
		call	sub_196BD
		mov	dx, si
		and	dx, 0FFh
		pop	di
		pop	si
		pop	bx
		pop	cx
		pop	ax
		pop	ds
		pop	es
		cmp	cs:word_195EA, 0
		jnz	short loc_195E4
		cmp	dx, 32h
		jnz	short loc_195E4
		mov	dx, 40h

loc_195E4:				; CODE XREF: TestUserInput+20j
					; TestUserInput+25j ...
		mov	cs:word_195EA, dx
		retn
TestUserInput	endp

; ---------------------------------------------------------------------------
word_195EA	dw 0FF00h		; DATA XREF: TestUserInput+1Ar
					; TestUserInput:loc_195E4w ...
		db 2 dup(0)

; =============== S U B	R O U T	I N E =======================================


sub_195EE	proc near		; CODE XREF: sub_111F3+17p
					; sub_1260A+66p
		mov	dx, cs:word_1961E
		and	dx, 0FFh
		cmp	cs:word_195EA, 0
		jnz	short loc_195E4
		cmp	dx, 32h
		jnz	short loc_195E4
		mov	dx, 40h
		jmp	short loc_195E4
sub_195EE	endp


; =============== S U B	R O U T	I N E =======================================


sub_19609	proc near		; CODE XREF: sub_10F09:loc_10F3Ap
					; sub_111F3+3p
		call	sub_19620
		call	sub_196BD
		mov	cs:word_1961E, si
		retn
sub_19609	endp


; =============== S U B	R O U T	I N E =======================================


sub_19615	proc near		; CODE XREF: sub_10F09+3Ap
					; sub_111F3+14p
		call	sub_19620
		or	cs:word_1961E, si
		retn
sub_19615	endp

; ---------------------------------------------------------------------------
word_1961E	dw 0			; DATA XREF: sub_195EEr sub_19609+6w ...

; =============== S U B	R O U T	I N E =======================================


sub_19620	proc near		; CODE XREF: TestUserInput+7p
					; sub_19609p ...
		sub	bx, bx
		mov	es, bx
		assume es:nothing
		mov	di, bx
		mov	cl, es:52Eh
		mov	ch, es:531h
		mov	dx, es:532h
		mov	al, es:52Ch
		and	al, 1
		neg	al
		rcl	bx, 1
		mov	al, es:52Fh
		and	ax, 8
		neg	ax
		rcl	bx, 1
		mov	al, es:52Fh
		mov	ah, es:52Dh
		and	ax, 1004h
		neg	ax
		rcl	bx, 1
		mov	al, es:52Fh
		mov	ah, es:530h
		and	ax, 1002h
		neg	ax
		rcl	bx, 1
		mov	ax, cx
		and	ax, 1020h
		shr	al, 1
		or	ax, dx
		and	ax, 1110h
		neg	ax
		rcl	bx, 1
		mov	ax, cx
		and	al, 4
		shr	ah, 1
		or	ax, dx
		and	ax, 444h
		neg	ax
		rcl	bx, 1
		mov	ax, cx
		and	ax, 2008h
		or	al, dh
		and	al, 1Ch
		neg	ax
		rcl	bx, 1
		mov	ax, cx
		and	ax, 410h
		or	al, dl
		and	al, 1Ch
		neg	ax
		rcl	bx, 1
		and	bx, 7Fh
		mov	al, es:538h
		and	al, 1
		neg	al
		shl	al, 7
		or	bl, al
		mov	si, bx
		mov	al, es:52Ah
		and	ax, 1
		retn
sub_19620	endp


; =============== S U B	R O U T	I N E =======================================


sub_196BD	proc near		; CODE XREF: TestUserInput+Ap
					; sub_19609+3p
		mov	cx, ax
		pushf
		cli
		mov	bl, 80h
		call	sub_19700
		and	ax, 3Fh
		or	si, ax
		popf
		mov	cs:word_19719, si
		retn
sub_196BD	endp


; =============== S U B	R O U T	I N E =======================================


sub_196D2	proc near		; CODE XREF: sub_19700+2p
		mov	dx, cs:FMPort
		out	5Fh, al
		mov	al, bh
		pushf
		cli
		out	dx, al
		popf
		out	5Fh, al
		inc	dx
		inc	dx
		mov	al, bl
		pushf
		cli
		out	dx, al
		popf
		retn
sub_196D2	endp

; ---------------------------------------------------------------------------
		mov	dx, cs:FMPort
		out	5Fh, al
		mov	al, bh
		pushf
		cli
		out	dx, al
		popf
		out	5Fh, al
		inc	dx
		inc	dx
		pushf
		cli
		in	al, dx
		popf
		retn

; =============== S U B	R O U T	I N E =======================================


sub_19700	proc near		; CODE XREF: sub_196BD+6p
		mov	bh, 0Fh
		call	sub_196D2
		mov	dx, cs:FMPort
		mov	al, 0Eh
		pushf
		cli
		out	dx, al
		popf
		inc	dx
		inc	dx
		pushf
		cli
		in	al, dx
		popf
		not	al
		retn
sub_19700	endp

; ---------------------------------------------------------------------------
word_19719	dw 0			; DATA XREF: sub_196BD+Fw
FMPort		dw 188h			; DATA XREF: DetectFMChip:loc_102D8w
					; DetectFMChip:loc_102E1w ...
; ---------------------------------------------------------------------------
		xchg	dx, bx
		out	dx, al
		xchg	dx, bx
		in	al, dx
		not	al
		retn
; ---------------------------------------------------------------------------
		mov	ah, 0
		add	ax, 5680h
		and	al, 7Fh
		push	ax
		mov	al, 0Bh
		out	68h, al
		pop	ax
		call	WriteFontData1
		mov	al, 0Ah
		out	68h, al
		retn
; ---------------------------------------------------------------------------
		push	ds
		push	si
		mov	al, 0Bh
		out	68h, al
		mov	dx, 0

loc_19744:				; CODE XREF: seg000:9750j
		mov	ax, dx
		adc	ax, 5680h
		and	al, 7Fh
		call	WriteFontData1
		inc	dl
		jnz	short loc_19744
		mov	al, 0Ah
		out	68h, al
		pop	si
		pop	ds
		retn

; =============== S U B	R O U T	I N E =======================================


WriteFontData1	proc near		; CODE XREF: seg000:9733p seg000:974Bp
		out	0A1h, al	; Interrupt Controller #2, 8259A
		mov	al, ah
		out	0A3h, al	; Interrupt Controller #2, 8259A
		mov	cx, 10h
		mov	bx, 0

loc_19765:				; CODE XREF: WriteFontData1+1Ej
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
		loop	loc_19765
		retn
WriteFontData1	endp

		assume es:nothing

; =============== S U B	R O U T	I N E =======================================


DrawChar	proc near		; CODE XREF: sub_11402+43p
					; sub_11402+57p ...
		push	di
		shr	cx, 3
		shr	dx, 3
		push	ax
		mov	ax, dx
		mov	di, ax
		shl	ax, 1
		shl	ax, 1
		add	di, ax
		shl	di, 1
		add	di, 0A000h
		mov	es, di
		mov	di, cx
		shl	di, 1
		pop	ax
		xchg	ah, al
		mov	al, 0
		rol	ax, 1
		shr	ax, 1
		adc	ax, 56h
		mov	bx, 0FFE1h
		mov	es:[di+2000h], bx ; set	Text RAM: character mode
		stosw			; set Text RAM:	character value
		or	ah, 80h		; repeat for 2nd byte
		mov	es:[di+2000h], bx
		stosw
		pop	di
		retn
DrawChar	endp


; =============== S U B	R O U T	I N E =======================================


DrawChar_Space	proc near		; CODE XREF: PrintCmfTxt4F+110p
					; PrintCmfTxt4F+126p ...
		push	di
		shr	cx, 3
		shr	dx, 3
		push	ax
		mov	ax, dx
		mov	di, ax
		shl	ax, 1
		shl	ax, 1
		add	di, ax
		shl	di, 1
		add	di, 0A000h
		mov	es, di
		mov	di, cx
		shl	di, 1
		pop	ax
		xchg	ah, al
		mov	al, 0
		rol	ax, 1
		shr	ax, 1
		adc	ax, 56h
		mov	bx, 0FFE1h
		mov	ax, 20h
		mov	es:[di+2000h], bx ; set	Text RAM: character mode
		stosw			; set Text RAM:	character value
		or	ah, 80h
		mov	ax, 20h		; repeat for 2nd byte
		mov	es:[di+2000h], bx
		stosw
		pop	di
		retn
DrawChar_Space	endp


; =============== S U B	R O U T	I N E =======================================


WriteFontData2	proc near		; CODE XREF: start+A8p
		cld
		mov	ax, cs
		mov	ds, ax
		assume ds:seg000
		mov	dx, offset aFontgj_ndf ; "FontGJ.ndf"
		call	LoadFile	; FontGJ.ndf
		jb	short locret_1985F
		mov	cs:word_19860, ax
		mov	ds, ax
		assume ds:nothing
		mov	si, 3
		lodsw
		mov	cx, ax
		mov	ax, 21h

loc_19818:				; CODE XREF: WriteFontData2+52j
		push	ax
		push	cx
		mov	ah, 0
		add	ax, 5680h
		and	al, 7Fh
		push	ax
		mov	al, 0Bh
		out	68h, al
		pop	ax
		out	0A1h, al	; Interrupt Controller #2, 8259A
		mov	al, ah
		out	0A3h, al	; Interrupt Controller #2, 8259A
		mov	cx, 10h
		mov	bx, 0

loc_19833:				; CODE XREF: WriteFontData2+49j
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
		loop	loc_19833
		mov	al, 0Ah
		out	68h, al
		pop	cx
		pop	ax
		inc	ax
		loop	loc_19818
		mov	ds, cs:word_19860
		push	es
		mov	ax, ds
		mov	es, ax
		mov	ah, 49h
		int	21h		; DOS -	2+ - FREE MEMORY
					; ES = segment address of area to be freed
		pop	es

locret_1985F:				; CODE XREF: WriteFontData2+Bj
		retn
WriteFontData2	endp

; ---------------------------------------------------------------------------
word_19860	dw 0			; DATA XREF: WriteFontData2+Dw
					; WriteFontData2+54r
aFontgj_ndf	db 'FontGJ.ndf',0       ; DATA XREF: WriteFontData2+5o

; =============== S U B	R O U T	I N E =======================================


DrawASCIIStr	proc near		; CODE XREF: DrawHUD+C1p DrawHUD+E1p ...
		sub	ah, ah
		lodsb
		cmp	al, 0
		jz	short locret_1987C
		call	DrawASCIIChar
		add	cx, 16
		jmp	short DrawASCIIStr
; ---------------------------------------------------------------------------

locret_1987C:				; CODE XREF: DrawASCIIStr+5j
		retn
DrawASCIIStr	endp


; =============== S U B	R O U T	I N E =======================================


DrawASCIIChar	proc near		; CODE XREF: DrawASCIIStr+7p
		push	cx
		push	dx
		push	si
		push	ds
		cmp	ax, 20h
		jb	short loc_19891	; char <space -> end
		jz	short loc_19896	; char == space	-> jump
		sub	ax, 20h
		add	ax, 21h
		call	DrawChar

loc_19891:				; CODE XREF: DrawASCIIChar+7j
					; DrawASCIIChar+1Cj
		pop	ds
		pop	si
		pop	dx
		pop	cx
		retn
; ---------------------------------------------------------------------------

loc_19896:				; CODE XREF: DrawASCIIChar+9j
		call	DrawChar_Space
		jmp	short loc_19891
DrawASCIIChar	endp


; =============== S U B	R O U T	I N E =======================================


GetRandomInRange proc near		; CODE XREF: sub_11402+79p
					; sub_11402+84p ...
		push	cx
		push	dx
		push	bx
		cmp	ax, 0
		jz	short loc_198B2
		mov	cx, ax
		call	GetRandomNumber
		xor	dx, dx
		div	cx
		mov	ax, dx
		pop	bx
		pop	dx
		pop	cx
		retn
; ---------------------------------------------------------------------------

loc_198B2:				; CODE XREF: GetRandomInRange+6j
		sub	ax, ax
		pop	bx
		pop	dx
		pop	cx
		retn
GetRandomInRange endp


; =============== S U B	R O U T	I N E =======================================


GetRandomNumber	proc near		; CODE XREF: GetRandomInRange+Ap
					; sub_198D6:loc_198FFp
		mov	ax, cs:rngSeed
		mov	bx, cs:rngIncrement
		add	ax, bx
		mov	cs:rngSeed, bx
		add	ax, 3711h
		mov	cs:rngIncrement, ax
		xchg	al, ah
		retn
GetRandomNumber	endp

; ---------------------------------------------------------------------------
rngSeed		dw 9371h		; DATA XREF: GetRandomNumberr
					; GetRandomNumber+Bw ...
rngIncrement	dw 5713h		; DATA XREF: GetRandomNumber+4r
					; GetRandomNumber+13w ...

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_198D6	proc near		; CODE XREF: start+54p

var_6		= byte ptr -6
var_4		= word ptr -4
var_2		= word ptr -2
var_0		= word ptr  0

		push	ax
		push	dx
		push	bx
		push	bp
		push	es
		enter	6, 0
		push	ss
		pop	es
		assume es:seg002
		lea	bx, [bp+var_6]
		xor	ah, ah
		int	1Ch		; CLOCK	TICK
		mov	dx, [bp+var_0]
		xor	dx, [bp+var_2]
		mov	ax, [bp+var_4]
		xor	ax, dx
		xor	cs:rngSeed, ax
		sub	cs:rngIncrement, ax
		mov	cx, ax

loc_198FF:				; CODE XREF: sub_198D6+2Cj
		call	GetRandomNumber
		loop	loc_198FF
		leave
		pop	es
		assume es:nothing
		pop	bp
		pop	bx
		pop	dx
		pop	ax
		retn
sub_198D6	endp


; =============== S U B	R O U T	I N E =======================================


sub_1990B	proc near		; CODE XREF: seg000:6159p
		cmp	cs:ShowDebugState, 0FFFFh
		jz	short locret_19949
		sub	cx, 16
		sub	dx, 16
		cmp	cx, 608
		jnb	short locret_19949
		cmp	dx, 168
		jnb	short locret_19949
		add	cx, 16
		add	dx, 16
		add	dx, cs:SomeYPosOffset
		push	ax
		push	cx
		push	dx
		push	si
		push	di
		mov	si, 2
		mov	di, 10h
		call	cmfB_GFXThing
		pop	di
		pop	si
		pop	dx
		pop	cx
		pop	ax
		mov	bx, 4		; render mode
		call	AddSprite

locret_19949:				; CODE XREF: sub_1990B+6j
					; sub_1990B+12j ...
		retn
sub_1990B	endp


; =============== S U B	R O U T	I N E =======================================


AddHDFSpr_Mode0	proc near		; CODE XREF: sub_1260A+6ECp
					; sub_1260A+74Ap ...
		push	bp
		cmp	cs:ShowDebugState, 0FFFFh
		jz	short loc_1997C
		shl	ax, 2
		add	si, ax
		add	si, 2
		lodsw
		xchg	ah, al
		mov	si, ax
		add	dx, cs:SomeYPosOffset
		push	cx
		push	dx
		push	si
		push	di
		mov	di, [si+4]
		mov	si, [si+2]
		call	cmfB_GFXThing
		pop	di
		pop	si
		pop	dx
		pop	cx
		mov	bx, 0		; render mode
		call	AddSprite

loc_1997C:				; CODE XREF: AddHDFSpr_Mode0+7j
		pop	bp
		retn
AddHDFSpr_Mode0	endp


; =============== S U B	R O U T	I N E =======================================


AddHDFSpr_Mode1	proc near		; CODE XREF: DrawPowerGage+13p
					; DrawPowerGage+38p ...
		push	bp
		cmp	cs:ShowDebugState, 0FFFFh
		jz	short loc_199B0
		shl	ax, 2
		add	si, ax
		add	si, 2
		lodsw
		xchg	ah, al		; convert Big Endian ->	Little Endian
		mov	si, ax		; sprite data pointer
		add	dx, cs:SomeYPosOffset ;	modify Y position
		push	cx
		push	dx
		push	si
		push	di
		mov	di, [si+4]
		mov	si, [si+2]
		call	cmfB_GFXThing
		pop	di
		pop	si
		pop	dx
		pop	cx
		mov	bx, 1		; render mode
		call	AddSprite

loc_199B0:				; CODE XREF: AddHDFSpr_Mode1+7j
		pop	bp
		retn
AddHDFSpr_Mode1	endp


; =============== S U B	R O U T	I N E =======================================


AddHDFSpr_Mode2	proc near		; CODE XREF: cmfA09_AddSpr+1Fp
					; sub_1260A+6F3p ...
		push	bp
		cmp	cs:ShowDebugState, 0FFFFh
		jz	short loc_199E9
		push	ax
		and	ax, 0FFh
		shl	ax, 2
		add	si, ax
		add	si, 2
		lodsw
		xchg	ah, al
		mov	si, ax
		add	dx, cs:SomeYPosOffset
		push	cx
		push	dx
		push	si
		push	di
		mov	di, [si+4]
		mov	si, [si+2]
		call	cmfB_GFXThing
		pop	di
		pop	si
		pop	dx
		pop	cx
		pop	ax
		mov	bx, 2		; render mode
		call	AddSprite

loc_199E9:				; CODE XREF: AddHDFSpr_Mode2+7j
		pop	bp
		retn
AddHDFSpr_Mode2	endp

; ---------------------------------------------------------------------------
		db 4 dup(0)

; =============== S U B	R O U T	I N E =======================================


AddHDFSpr_Mode3	proc near		; CODE XREF: sub_14415+32p
					; seg000:5829p	...
		push	bp
		cmp	cs:ShowDebugState, 0FFFFh
		jz	short loc_19A28
		push	ax
		and	ax, 0FFh
		shl	ax, 2
		add	si, ax
		add	si, 2
		lodsw
		xchg	ah, al
		mov	si, ax
		add	dx, cs:SomeYPosOffset
		push	cx
		push	dx
		push	si
		push	di
		mov	di, [si+4]
		mov	si, [si+2]
		call	cmfB_GFXThing
		pop	di
		pop	si
		pop	dx
		pop	cx
		pop	ax
		mov	ah, 0Fh
		mov	bx, 3		; render mode
		call	AddSprite

loc_19A28:				; CODE XREF: AddHDFSpr_Mode3+7j
		pop	bp
		retn
AddHDFSpr_Mode3	endp

; ---------------------------------------------------------------------------
		db 4 dup(0)

; =============== S U B	R O U T	I N E =======================================

; unused

AddSpr_ASCIIStr	proc near		; CODE XREF: AddSpr_ASCIIStr+Dj
		sub	ah, ah
		lodsb
		cmp	al, 0
		jz	short locret_19A3D
		call	AddSpr_ASCIIChr
		add	cx, 10h
		jmp	short AddSpr_ASCIIStr
; ---------------------------------------------------------------------------

locret_19A3D:				; CODE XREF: AddSpr_ASCIIStr+5j
		retn
AddSpr_ASCIIStr	endp


; =============== S U B	R O U T	I N E =======================================


AddSpr_ASCIIChr	proc near		; CODE XREF: AddSpr_ASCIIStr+7p
		push	cx
		push	dx
		push	si
		push	ds
		cmp	ax, ' '
		jz	short loc_19A74
		mov	ds, cs:word_1BE36
		assume ds:nothing
		sub	si, si
		cmp	ax, 30h
		jb	short loc_19A74
		cmp	ax, 3Ah
		jb	short loc_19A64	; 30h..39h -> draw character 0..9
		cmp	ax, 41h
		jb	short loc_19A74
		cmp	ax, 5Bh
		jb	short loc_19A69	; 41h..5Ah -> draw character A..Z
		jmp	short loc_19A74
; ---------------------------------------------------------------------------

loc_19A64:				; CODE XREF: AddSpr_ASCIIChr+18j
		sub	ax, '0'
		jmp	short loc_19A71
; ---------------------------------------------------------------------------

loc_19A69:				; CODE XREF: AddSpr_ASCIIChr+22j
		sub	ax, 'A'
		add	ax, 10
		jmp	short $+2

loc_19A71:				; CODE XREF: AddSpr_ASCIIChr+29j
		call	AddHDFSpr_Mode3

loc_19A74:				; CODE XREF: AddSpr_ASCIIChr+7j
					; AddSpr_ASCIIChr+13j ...
		pop	ds
		assume ds:nothing
		pop	si
		pop	dx
		pop	cx
		retn
AddSpr_ASCIIChr	endp


; =============== S U B	R O U T	I N E =======================================


SpriteDraw0A	proc near		; CODE XREF: SpriteDraw0B+8p
					; sprDraw0+12p
		lodsw
		lodsw
		mov	bx, ax
		lodsw
		mov	di, ax
		xchg	bx, si
		shl	si, 3
		add	cx, cs:word_1BE04
		mov	cs:word_1BE18, cx
		mov	cs:word_1BE1A, dx
		mov	cs:word_1BE1C, si
		mov	cs:word_1BE1E, di
		and	cl, 0Fh
		mov	byte ptr cs:loc_19FB0+1, cl
		and	cl, 7
		mov	byte ptr cs:loc_19E2B+2, cl
		mov	byte ptr cs:loc_19DED+2, cl
		mov	byte ptr cs:loc_1A0DD+2, cl
		mov	byte ptr cs:loc_19E00+2, cl
		mov	byte ptr cs:loc_19E3E+2, cl
		mov	byte ptr cs:loc_19E11+2, cl
		mov	byte ptr cs:loc_19E4F+2, cl
		mov	byte ptr cs:loc_1A09F+2, cl
		mov	cx, cs:word_1BE18
		mov	al, 0FFh
		mov	cs:word_1BE20, 0
		mov	cs:word_1BE22, 0
		mov	cs:word_1BE24, 0
		add	si, cx
		add	di, dx
		cmp	cx, cs:word_1BE2C
		jge	short loc_19AFF
		mov	cx, cs:word_1BE2C
		xor	al, al

loc_19AFF:				; CODE XREF: SpriteDraw0A+7Dj
		cmp	si, cs:word_1BE2E
		jle	short loc_19B17
		sub	si, cs:word_1BE2E
		mov	cs:word_1BE20, si
		mov	si, cs:word_1BE2E
		xor	al, al

loc_19B17:				; CODE XREF: SpriteDraw0A+8Bj
		cmp	cx, si
		jge	short locret_19B5F
		sub	si, cx
		cmp	dx, 0
		jge	short loc_19B30
		mov	ax, 0
		sub	ax, dx
		mov	cs:word_1BE22, ax
		mov	dx, 0
		xor	al, al

loc_19B30:				; CODE XREF: SpriteDraw0A+A7j
		cmp	di, 0BFh ; 'ø'
		jle	short loc_19B44
		sub	di, 0BFh ; 'ø'
		mov	cs:word_1BE24, di
		mov	di, 0BFh ; 'ø'
		xor	al, al

loc_19B44:				; CODE XREF: SpriteDraw0A+BBj
		cmp	dx, di
		jge	short locret_19B5F
		sub	di, dx
		or	al, al
		jz	short loc_19B58
		add	dx, cs:word_1BE06
		call	sub_19E60
		jmp	short locret_19B5F
; ---------------------------------------------------------------------------

loc_19B58:				; CODE XREF: SpriteDraw0A+D3j
		push	bx
		push	bp
		call	sub_19C48
		pop	bp
		pop	bx

locret_19B5F:				; CODE XREF: SpriteDraw0A+A0j
					; SpriteDraw0A+CDj ...
		retn
SpriteDraw0A	endp


; =============== S U B	R O U T	I N E =======================================


SpriteDraw1A	proc near		; CODE XREF: SpriteDraw1B+8p
					; sprDraw1+1Ap
		lodsw
		lodsw
		mov	bx, ax
		lodsw
		mov	di, ax
		xchg	bx, si
		add	cx, cs:word_1BE04
		shl	si, 3
		mov	cs:word_1BE18, cx
		mov	cs:word_1BE1A, dx
		mov	cs:word_1BE1C, si
		mov	cs:word_1BE1E, di
		and	cl, 0Fh
		mov	byte ptr cs:loc_19FB0+1, cl
		and	cl, 7
		mov	byte ptr cs:loc_19E2B+2, cl
		mov	byte ptr cs:loc_19DED+2, cl
		mov	byte ptr cs:loc_1A0DD+2, cl
		mov	byte ptr cs:loc_19E00+2, cl
		mov	byte ptr cs:loc_19E3E+2, cl
		mov	byte ptr cs:loc_19E11+2, cl
		mov	byte ptr cs:loc_19E4F+2, cl
		mov	byte ptr cs:loc_1A09F+2, cl
		mov	cx, cs:word_1BE18
		mov	al, 0FFh
		mov	cs:word_1BE20, 0
		mov	cs:word_1BE22, 0
		mov	cs:word_1BE24, 0
		add	si, cx
		add	di, dx
		cmp	cx, cs:word_1BE2C
		jge	short loc_19BE6
		mov	cx, cs:word_1BE2C
		xor	al, al

loc_19BE6:				; CODE XREF: SpriteDraw1A+7Dj
		cmp	si, cs:word_1BE2E
		jle	short loc_19BFE
		sub	si, cs:word_1BE2E
		mov	cs:word_1BE20, si
		mov	si, cs:word_1BE2E
		xor	al, al

loc_19BFE:				; CODE XREF: SpriteDraw1A+8Bj
		cmp	cx, si
		jge	short locret_19C46
		sub	si, cx
		cmp	dx, 0
		jge	short loc_19C17
		mov	ax, 0
		sub	ax, dx
		mov	cs:word_1BE22, ax
		mov	dx, 0
		xor	al, al

loc_19C17:				; CODE XREF: SpriteDraw1A+A7j
		cmp	di, 191
		jle	short loc_19C2B
		sub	di, 191
		mov	cs:word_1BE24, di
		mov	di, 191
		xor	al, al

loc_19C2B:				; CODE XREF: SpriteDraw1A+BBj
		cmp	dx, di
		jge	short locret_19C46
		sub	di, dx
		or	al, al
		jz	short loc_19C3F
		add	dx, cs:word_1BE06
		call	sub_1A0F0
		jmp	short locret_19C46
; ---------------------------------------------------------------------------

loc_19C3F:				; CODE XREF: SpriteDraw1A+D3j
		push	bx
		push	bp
		call	sub_19C48
		pop	bp
		pop	bx

locret_19C46:				; CODE XREF: SpriteDraw1A+A0j
					; SpriteDraw1A+CDj ...
		retn
SpriteDraw1A	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_19C48	proc near		; CODE XREF: SpriteDraw0A+E1p
					; SpriteDraw1A+E1p
		push	di
		push	si
		mov	di, dx
		shl	di, 2
		add	di, dx
		shl	di, 4
		mov	ax, cs:word_1BE18
		sar	ax, 3
		add	di, ax
		sub	dx, cs:word_1BE1A
		mov	si, dx
		mov	ax, cs:word_1BE1C
		shr	ax, 3
		xor	dx, dx
		mul	si
		mov	si, ax
		add	si, bx
		pop	bx
		push	cx
		sub	cx, cs:word_1BE18
		sar	cx, 3
		add	si, cx
		add	di, cx
		mov	bp, cs:word_1BE20
		shr	bp, 3
		add	bp, cx
		mov	ax, bx
		mov	bx, cs:word_1BE1C
		shr	bx, 3
		sub	bx, bp
		dec	bx
		dec	bx
		pop	cx
		cmp	ax, 8
		jbe	short loc_19CC3
		push	cx
		mov	cx, cs:word_1BE20
		and	cl, 7
		mov	al, 0FFh
		shl	al, cl
		mov	byte ptr cs:word_1BE2A+1, al
		pop	cx
		sub	cx, cs:word_1BE18
		and	cl, 7
		mov	al, 0FFh
		shr	al, cl
		mov	byte ptr cs:word_1BE2A,	al
		jmp	short loc_19CF0
; ---------------------------------------------------------------------------

loc_19CC3:				; CODE XREF: sub_19C48+55j
		mov	ch, cl
		mov	cl, al
		mov	ax, 0FFFFh
		shr	ax, cl
		mov	cl, ch
		xor	ch, ch
		sub	cx, cs:word_1BE18
		and	cl, 7
		ror	ax, cl
		not	ax
		mov	byte ptr cs:word_1BE2A,	ah
		mov	byte ptr cs:word_1BE2A+1, al
		test	bh, 80h
		jz	short loc_19CEE
		neg	bx
		sub	bp, bx

loc_19CEE:				; CODE XREF: sub_19C48+A0j
		xor	bx, bx

loc_19CF0:				; CODE XREF: sub_19C48+79j
		mov	word ptr cs:loc_19DF8+1, bx
		mov	word ptr cs:loc_19E36+1, bx
		mov	ax, cs:word_1BE1C
		shr	ax, 3
		mov	cx, ax
		xor	dx, dx
		mul	cs:word_1BE1E
		shl	ax, 2
		mov	bx, ax
		add	bx, si
		mov	ax, cx
		mul	cs:word_1BE22
		xchg	ax, cx
		mul	cs:word_1BE24
		add	ax, cx
		mov	cs:word_1BE28, ax
		mov	ax, cs:word_1BE2A
		not	ax
		mov	cs:word_1BE26, ax
		pop	dx
		mov	al, 0C0h ; '¿'
		out	7Ch, al
		sub	ah, ah
		mov	al, cs:byte_1A1AE
		test	al, 80h
		jz	short loc_19D41
		and	al, 7Fh
		mov	ah, al

loc_19D41:				; CODE XREF: sub_19C48+F3j
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		add	di, cs:word_1BE08
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		push	dx
		push	bx
		push	di
		call	sub_19E22
		pop	di
		pop	bx
		pop	dx
		add	si, cs:word_1BE28
		test	cs:byte_1A1AE, 80h
		jnz	short locret_19DE2
		add	si, 6
		mov	ah, 0Fh
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		mov	al, 0CEh ; 'Œ'
		out	7Ch, al
		push	dx
		push	bx
		push	di
		call	sub_19E22
		pop	di
		pop	bx
		pop	dx
		add	si, cs:word_1BE28
		mov	al, 0CDh ; 'Õ'
		out	7Ch, al
		push	dx
		push	bx
		push	di
		call	sub_19E22
		pop	di
		pop	bx
		pop	dx
		add	si, cs:word_1BE28
		mov	al, 0CBh ; 'À'
		out	7Ch, al
		push	dx
		push	bx
		push	di
		call	sub_19E22
		pop	di
		pop	bx
		pop	dx
		add	si, cs:word_1BE28
		mov	al, 0C7h ; '«'
		out	7Ch, al
		push	dx
		push	bx
		push	di
		call	sub_19E22
		pop	di
		pop	bx
		pop	dx
		add	si, cs:word_1BE28
		xor	al, al
		out	7Ch, al

locret_19DE2:				; CODE XREF: sub_19C48+12Fj
		retn
sub_19C48	endp ; sp-analysis failed

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_19DE4	proc near		; CODE XREF: sub_19DE4+3Aj
		push	di
		xor	ah, ah
		lodsb
		and	al, byte ptr cs:word_1BE2A

loc_19DED:				; DATA XREF: SpriteDraw0A+35w
					; SpriteDraw1A+35w
		ror	ax, 0FFh
		or	es:[di], al
		or	es:[di+1], ah
		inc	di

loc_19DF8:				; DATA XREF: sub_19C48:loc_19CF0w
		mov	cx, 1234h
		jcxz	short loc_19E09

loc_19DFD:				; CODE XREF: sub_19DE4+23j
		xor	ah, ah
		lodsb

loc_19E00:				; DATA XREF: SpriteDraw0A+3Fw
					; SpriteDraw1A+3Fw
		ror	ax, 0FFh
		or	es:[di], ax
		inc	di
		loop	loc_19DFD

loc_19E09:				; CODE XREF: sub_19DE4+17j
		xor	ah, ah
		lodsb
		and	al, byte ptr cs:word_1BE2A+1

loc_19E11:				; DATA XREF: SpriteDraw0A+49w
					; SpriteDraw1A+49w ...
		ror	ax, 0FFh
		or	es:[di], ax
		add	si, bp
		pop	di
		add	di, 50h	; 'P'
		dec	dx
		jnz	short sub_19DE4
		retn
sub_19DE4	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_19E22	proc near		; CODE XREF: sub_19C48+11Ep
					; sub_19C48+155p ...
		push	di
		sub	ah, ah
		lodsb
		and	al, byte ptr cs:word_1BE2A

loc_19E2B:				; DATA XREF: SpriteDraw0A+30w
					; SpriteDraw1A+30w
		ror	ax, 0FFh
		mov	es:[di], al
		mov	es:[di+1], ah
		inc	di

loc_19E36:				; DATA XREF: sub_19C48+ADw
		mov	cx, 1234h
		jcxz	short loc_19E47

loc_19E3B:				; CODE XREF: sub_19E22+23j
		xor	ah, ah
		lodsb

loc_19E3E:				; DATA XREF: SpriteDraw0A+44w
					; SpriteDraw1A+44w
		ror	ax, 0FFh
		mov	es:[di], ax
		inc	di
		loop	loc_19E3B

loc_19E47:				; CODE XREF: sub_19E22+17j
		sub	ah, ah
		lodsb
		and	al, byte ptr cs:word_1BE2A+1

loc_19E4F:				; DATA XREF: SpriteDraw0A+4Ew
					; SpriteDraw1A+4Ew
		ror	ax, 0FFh
		mov	es:[di], ax
		add	si, bp
		pop	di
		add	di, 50h
		dec	dx
		jnz	short sub_19E22
		retn
sub_19E22	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_19E60	proc near		; CODE XREF: SpriteDraw0A+DAp
		mov	cs:word_1A076, si
		shr	si, 3
		mov	bp, si
		xchg	si, bx
		push	di
		xchg	di, dx
		mov	ax, di
		shl	di, 2
		add	di, ax
		shl	di, 4
		sar	cx, 3
		add	di, cx
		pop	dx
		mov	cx, bp
		jcxz	short loc_19E85
		jmp	short loc_19E88
; ---------------------------------------------------------------------------

loc_19E85:				; CODE XREF: sub_19E60+21j
		jmp	locret_1A073
; ---------------------------------------------------------------------------

loc_19E88:				; CODE XREF: sub_19E60+23j
		mov	bp, 50h	; 'P'
		sub	bp, cx
		cmp	cs:word_1BDE8, 1
		jnz	short loc_19E98
		jmp	loc_19F84
; ---------------------------------------------------------------------------

loc_19E98:				; CODE XREF: sub_19E60+33j
		or	byte ptr cs:loc_19E11+2, 0
		jnz	short loc_19F1D
		mov	al, 0C0h ; '¿'
		out	7Ch, al
		sub	ah, ah
		mov	al, cs:byte_1A1AE
		test	al, 80h
		jz	short loc_19EB2
		and	al, 7Fh
		mov	ah, al

loc_19EB2:				; CODE XREF: sub_19E60+4Cj
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		mov	ax, 0A800h
		mov	es, ax
		call	sub_1A088
		test	cs:byte_1A1AE, 80h
		jz	short loc_19EDD
		jmp	locret_1A073
; ---------------------------------------------------------------------------

loc_19EDD:				; CODE XREF: sub_19E60+78j
		add	si, 6
		mov	ah, 0Fh
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		mov	al, 0CEh ; 'Œ'
		out	7Ch, al
		call	sub_1A078
		mov	al, 0CDh ; 'Õ'
		out	7Ch, al
		call	sub_1A078
		mov	al, 0CBh ; 'À'
		out	7Ch, al
		call	sub_1A078
		mov	al, 0C7h ; '«'
		out	7Ch, al
		call	sub_1A078
		xor	al, al
		out	7Ch, al
		jmp	locret_1A073
; ---------------------------------------------------------------------------

loc_19F1D:				; CODE XREF: sub_19E60+3Ej
		mov	al, 0C0h ; '¿'
		out	7Ch, al
		sub	ah, ah
		mov	al, cs:byte_1A1AE
		test	al, 80h
		jz	short loc_19F2F
		and	al, 7Fh
		mov	ah, al

loc_19F2F:				; CODE XREF: sub_19E60+C9j
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		mov	ax, 0A800h
		mov	es, ax
		call	sub_1A0D6
		test	cs:byte_1A1AE, 80h
		jz	short loc_19F5A
		jmp	locret_1A073
; ---------------------------------------------------------------------------

loc_19F5A:				; CODE XREF: sub_19E60+F5j
		add	si, 6
		xor	al, al
		out	7Ch, al
		mov	ax, 0A800h
		mov	es, ax
		call	sub_1A098
		mov	ax, 0B000h
		mov	es, ax
		assume es:nothing
		call	sub_1A098
		mov	ax, 0B800h
		mov	es, ax
		assume es:nothing
		call	sub_1A098
		mov	ax, 0E000h
		mov	es, ax
		assume es:nothing
		call	sub_1A098
		jmp	locret_1A073
; ---------------------------------------------------------------------------

loc_19F84:				; CODE XREF: sub_19E60+35j
		push	dx
		mov	al, 80h	; 'Ä'
		out	7Ch, al
		mov	al, 7
		out	6Ah, al
		mov	al, 5
		out	6Ah, al
		mov	ax, 0FFh
		mov	dx, 4A2h
		out	dx, ax
		mov	ax, 0
		mov	dx, 4ACh
		out	dx, ax
		mov	ax, 0C0Ch
		mov	dx, 4A4h
		out	dx, ax
		mov	ax, 0FFFFh
		mov	dx, 4A8h
		out	dx, ax
		mov	ax, 0

loc_19FB0:				; DATA XREF: SpriteDraw0A+28w
					; SpriteDraw1A+28w
		mov	al, 0
		shl	al, 4
		mov	dx, 4ACh
		out	dx, ax
		mov	ax, cs:word_1A076
		mov	dx, 4AEh
		out	dx, ax
		mov	ax, 0FFF0h
		mov	dx, 4A0h
		out	dx, ax
		pop	dx
		shr	cx, 1
		and	di, 0FFFEh
		and	bp, 0FFFEh
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		mov	al, cs:byte_1A1AE
		test	al, 80h
		jz	short loc_1A003
		push	dx
		push	ax
		mov	ax, 40FFh
		mov	dx, 4A2h
		out	dx, ax
		pop	ax
		and	ax, 7Fh
		mov	dx, 4A6h
		out	dx, ax
		mov	ax, 2CACh
		mov	dx, 4A4h
		out	dx, ax
		pop	dx
		call	sub_1A0B2
		mov	ax, 0FFh
		mov	dx, 4A2h
		out	dx, ax
		jmp	short loc_1A060
; ---------------------------------------------------------------------------

loc_1A003:				; CODE XREF: sub_19E60+17Cj
		call	sub_1A0B2
		add	si, 6
		push	dx
		mov	ax, 0CFCh
		mov	dx, 4A4h
		out	dx, ax
		mov	ax, 0FFFEh
		mov	dx, 4A0h
		out	dx, ax
		mov	ax, cs:word_1A076
		mov	dx, 4AEh
		out	dx, ax
		pop	dx
		call	sub_1A0B2
		push	dx
		mov	ax, 0FFFDh
		mov	dx, 4A0h
		out	dx, ax
		mov	ax, cs:word_1A076
		mov	dx, 4AEh
		out	dx, ax
		pop	dx
		call	sub_1A0B2
		push	dx
		mov	ax, 0FFFBh
		mov	dx, 4A0h
		out	dx, ax
		mov	ax, cs:word_1A076
		mov	dx, 4AEh
		out	dx, ax
		pop	dx
		call	sub_1A0B2
		push	dx
		mov	ax, 0FFF7h
		mov	dx, 4A0h
		out	dx, ax
		mov	ax, cs:word_1A076
		mov	dx, 4AEh
		out	dx, ax
		pop	dx
		call	sub_1A0B2

loc_1A060:				; CODE XREF: sub_19E60+1A1j
		mov	ax, 0FFF0h
		mov	dx, 4A0h
		out	dx, ax
		mov	al, 4
		out	6Ah, al
		mov	al, 6
		out	6Ah, al
		mov	al, 0
		out	7Ch, al

locret_1A073:				; CODE XREF: sub_19E60:loc_19E85j
					; sub_19E60+7Aj ...
		retn
sub_19E60	endp ; sp-analysis failed

; ---------------------------------------------------------------------------
		db 2 dup(0)
word_1A076	dw 0			; DATA XREF: sub_19E60w sub_19E60+159r ...

; =============== S U B	R O U T	I N E =======================================


sub_1A078	proc near		; CODE XREF: sub_19E60+9Ep
					; sub_19E60+A5p ...
		push	dx
		push	bx
		push	di

loc_1A07B:				; CODE XREF: sub_1A078+Aj
		push	cx
		rep movsb
		pop	cx
		add	di, bp
		dec	dx
		jnz	short loc_1A07B
		pop	di
		pop	bx
		pop	dx
		retn
sub_1A078	endp


; =============== S U B	R O U T	I N E =======================================


sub_1A088	proc near		; CODE XREF: sub_19E60+6Fp
		push	dx
		push	bx
		push	di

loc_1A08B:				; CODE XREF: sub_1A088+Aj
		push	cx
		rep movsb
		pop	cx
		add	di, bp
		dec	dx
		jnz	short loc_1A08B
		pop	di
		pop	bx
		pop	dx
		retn
sub_1A088	endp


; =============== S U B	R O U T	I N E =======================================


sub_1A098	proc near		; CODE XREF: sub_19E60+106p
					; sub_19E60+10Ep ...
		push	dx
		push	bx
		push	di

loc_1A09B:				; CODE XREF: sub_1A098+14j
		push	cx

loc_1A09C:				; CODE XREF: sub_1A098+Ej
		sub	ah, ah
		lodsb

loc_1A09F:				; DATA XREF: SpriteDraw0A+53w
					; SpriteDraw1A+53w
		ror	ax, 0FFh
		or	es:[di], ax
		inc	di
		loop	loc_1A09C
		pop	cx
		add	di, bp
		dec	dx
		jnz	short loc_1A09B
		pop	di
		pop	bx
		pop	dx
		retn
sub_1A098	endp


; =============== S U B	R O U T	I N E =======================================


sub_1A0B2	proc near		; CODE XREF: sub_19E60+197p
					; sub_19E60:loc_1A003p	...
		push	dx
		push	bx
		push	di

loc_1A0B5:				; CODE XREF: sub_1A0B2+10j
		push	cx
		rep movsw
		sub	ax, ax
		stosw
		sub	di, 2
		pop	cx
		add	di, bp
		dec	dx
		jnz	short loc_1A0B5
		pop	di
		pop	bx
		pop	dx
		retn
sub_1A0B2	endp


; =============== S U B	R O U T	I N E =======================================


sub_1A0C8	proc near
		push	dx
		push	bx
		push	di

loc_1A0CB:				; CODE XREF: sub_1A0C8+8j
		add	si, cx
		add	si, cx
		dec	dx
		jnz	short loc_1A0CB
		pop	di
		pop	bx
		pop	dx
		retn
sub_1A0C8	endp


; =============== S U B	R O U T	I N E =======================================


sub_1A0D6	proc near		; CODE XREF: sub_19E60+ECp
		push	dx
		push	bx
		push	di

loc_1A0D9:				; CODE XREF: sub_1A0D6+14j
		push	cx

loc_1A0DA:				; CODE XREF: sub_1A0D6+Ej
		sub	ah, ah
		lodsb

loc_1A0DD:				; DATA XREF: SpriteDraw0A+3Aw
					; SpriteDraw1A+3Aw
		ror	ax, 0FFh
		mov	es:[di], ax
		inc	di
		loop	loc_1A0DA
		pop	cx
		add	di, bp
		dec	dx
		jnz	short loc_1A0D9
		pop	di
		pop	bx
		pop	dx
		retn
sub_1A0D6	endp


; =============== S U B	R O U T	I N E =======================================


sub_1A0F0	proc near		; CODE XREF: SpriteDraw1A+DAp
		shr	si, 3
		mov	bp, si
		xchg	si, bx
		push	di
		xchg	di, dx
		mov	ax, di
		shl	di, 2
		add	di, ax
		shl	di, 4
		sar	cx, 3
		add	di, cx
		pop	dx
		mov	cx, bp
		jcxz	short locret_1A18C
		mov	bp, 50h	; 'P'
		sub	bp, cx
		mov	al, 0C0h ; '¿'
		out	7Ch, al
		sub	ah, ah
		mov	al, cs:byte_1A1AE
		test	al, 80h
		jz	short loc_1A125
		and	al, 7Fh
		mov	ah, al

loc_1A125:				; CODE XREF: sub_1A0F0+2Fj
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		mov	ax, 0A800h
		mov	es, ax
		call	sub_1A19E
		test	cs:byte_1A1AE, 80h
		jnz	short locret_1A18C
		add	si, 6
		mov	ah, 0Fh
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		mov	al, 0CEh ; 'Œ'
		out	7Ch, al
		call	sub_1A18E
		mov	al, 0CDh ; 'Õ'
		out	7Ch, al
		call	sub_1A18E
		mov	al, 0CBh ; 'À'
		out	7Ch, al
		call	sub_1A18E
		mov	al, 0C7h ; '«'
		out	7Ch, al
		call	sub_1A18E
		xor	al, al
		out	7Ch, al
		jmp	short $+2

locret_1A18C:				; CODE XREF: sub_1A0F0+1Cj
					; sub_1A0F0+5Bj
		retn
sub_1A0F0	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_1A18E	proc near		; CODE XREF: sub_1A0F0+7Ep
					; sub_1A0F0+85p ...
		push	dx
		push	bx
		push	di

loc_1A191:				; CODE XREF: sub_1A18E+Aj
		push	cx
		rep movsb
		pop	cx
		add	di, bp
		dec	dx
		jnz	short loc_1A191
		pop	di
		pop	bx
		pop	dx
		retn
sub_1A18E	endp


; =============== S U B	R O U T	I N E =======================================


sub_1A19E	proc near		; CODE XREF: sub_1A0F0+52p
		push	dx
		push	bx
		push	di

loc_1A1A1:				; CODE XREF: sub_1A19E+Aj
		push	cx
		rep movsb
		pop	cx
		add	di, bp
		dec	dx
		jnz	short loc_1A1A1
		pop	di
		pop	bx
		pop	dx
		retn
sub_1A19E	endp

; ---------------------------------------------------------------------------
byte_1A1AE	db 0			; DATA XREF: sub_19C48+EDr
					; sub_19C48+129r ...

; =============== S U B	R O U T	I N E =======================================


SpriteDraw0B	proc near		; CODE XREF: sprDraw2+16p
		or	ah, 80h
		mov	cs:byte_1A1AE, ah
		call	SpriteDraw0A
		mov	cs:byte_1A1AE, 0
		xor	al, al
		out	7Ch, al
		xor	al, al
		out	7Ch, al
		retn
SpriteDraw0B	endp


; =============== S U B	R O U T	I N E =======================================


SpriteDraw1B	proc near		; CODE XREF: PrintSJISText_H1+71p
					; sprDraw3+1Ep
		or	ah, 80h
		mov	cs:byte_1A1AE, ah
		call	SpriteDraw1A
		mov	cs:byte_1A1AE, 0
		xor	al, al
		out	7Ch, al
		xor	al, al
		out	7Ch, al
		retn
SpriteDraw1B	endp

; ---------------------------------------------------------------------------
		retn
; ---------------------------------------------------------------------------
		push	es
		push	ds
		pusha
		mov	al, 0C0h
		out	7Ch, al
		mov	al, 0C0h
		out	7Ch, al
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		mov	ax, 0A800h
		mov	es, ax
		mov	cs:word_1BE18, cx
		mov	cs:word_1BE1A, dx
		mov	cs:word_1BE1C, si
		mov	cs:word_1BE1E, di
		and	cl, 7
		mov	byte ptr cs:loc_1A300+2, cl
		mov	byte ptr cs:loc_1A30F+2, cl
		mov	byte ptr cs:loc_1A31E+2, cl
		mov	byte ptr cs:loc_1A361+2, cl
		mov	cx, cs:word_1BE18
		call	sub_1A32C
		jmp	short $+2
		xor	al, al
		out	7Ch, al
		xor	al, al
		out	7Ch, al
		popa
		pop	ds
		pop	es
		assume es:nothing
		retn
; ---------------------------------------------------------------------------
		push	si
		push	di
		mov	di, dx
		shl	di, 2
		add	di, dx
		shl	di, 4
		mov	ax, cs:word_1BE18
		sar	ax, 3
		add	di, ax
		sub	dx, cs:word_1BE1A
		mov	si, dx
		mov	ax, cs:word_1BE1C
		shr	ax, 3
		xor	dx, dx
		mul	si
		mov	si, ax
		add	si, bx
		pop	dx
		pop	bx
		push	cx
		sub	cx, cs:word_1BE18
		sar	cx, 3
		add	si, cx
		add	di, cx
		mov	bp, cs:word_1BE20
		shr	bp, 3
		add	bp, cx
		mov	ax, bx
		mov	bx, cs:word_1BE1C
		shr	bx, 3
		sub	bx, bp
		dec	bx
		dec	bx
		pop	cx
		cmp	ax, 8
		jbe	short loc_1A2C9
		push	cx
		mov	cx, cs:word_1BE20
		and	cl, 7
		mov	al, 0FFh
		shl	al, cl
		mov	byte ptr cs:word_1BE2A+1, al
		pop	cx
		sub	cx, cs:word_1BE18
		and	cl, 7
		mov	al, 0FFh
		shr	al, cl
		mov	byte ptr cs:word_1BE2A,	al
		jmp	short loc_1A2F7
; ---------------------------------------------------------------------------

loc_1A2C9:				; CODE XREF: seg000:A2A3j
		push	cx
		mov	cl, al
		mov	ax, 0FFFFh
		shr	ax, cl
		pop	cx
		sub	cx, cs:word_1BE18
		and	cl, 7
		ror	ax, cl
		not	ax
		mov	byte ptr cs:word_1BE2A,	ah
		mov	byte ptr cs:word_1BE2A+1, al
		test	bh, 80h
		jz	short loc_1A2F0
		neg	bx
		sub	bp, bx

loc_1A2F0:				; CODE XREF: seg000:A2EAj
		xor	bx, bx
		add	di, cs:word_1BE08

loc_1A2F7:				; CODE XREF: seg000:A2C7j seg000:A329j
		push	di
		xor	ah, ah
		lodsb
		and	al, byte ptr cs:word_1BE2A

loc_1A300:				; DATA XREF: seg000:A223w
		ror	ax, 0FFh
		stosb
		mov	al, ah
		stosb
		dec	di
		mov	cx, bx
		jcxz	short loc_1A316

loc_1A30C:				; CODE XREF: seg000:A314j
		xor	ah, ah
		lodsb

loc_1A30F:				; DATA XREF: seg000:A228w
		ror	ax, 0FFh
		stosw
		dec	di
		loop	loc_1A30C

loc_1A316:				; CODE XREF: seg000:A30Aj
		xor	ah, ah
		lodsb
		and	al, byte ptr cs:word_1BE2A+1

loc_1A31E:				; DATA XREF: seg000:A22Dw
		ror	ax, 0FFh
		stosw
		add	si, bp
		pop	di
		add	di, 50h	; 'P'
		dec	dx
		jnz	short loc_1A2F7
		retn

; =============== S U B	R O U T	I N E =======================================


sub_1A32C	proc near		; CODE XREF: seg000:A23Cp
		shr	si, 3
		xchg	si, bx
		xchg	di, dx
		mov	bp, 50h	; 'P'
		sub	bp, bx
		mov	ax, di
		shl	di, 2
		add	di, ax
		shl	di, 4
		mov	ax, cx
		shr	ax, 3
		add	di, ax
		push	di
		test	cl, 7
		jnz	short loc_1A35A

loc_1A34F:				; CODE XREF: sub_1A32C+2Aj
		mov	cx, bx
		rep movsb
		add	di, bp
		dec	dx
		jnz	short loc_1A34F
		jmp	short loc_1A36D
; ---------------------------------------------------------------------------

loc_1A35A:				; CODE XREF: sub_1A32C+21j
					; sub_1A32C+3Fj
		xor	al, al
		mov	cx, bx

loc_1A35E:				; CODE XREF: sub_1A32C+3Aj
		xor	ah, ah
		lodsb

loc_1A361:				; DATA XREF: seg000:A232w
		ror	ax, 0FFh
		stosw
		dec	di
		loop	loc_1A35E
		add	di, bp
		dec	dx
		jnz	short loc_1A35A

loc_1A36D:				; CODE XREF: sub_1A32C+2Cj
		pop	di
		retn
sub_1A32C	endp

; ---------------------------------------------------------------------------
		shr	si, 3
		xchg	si, bx
		xchg	di, dx
		mov	bp, 50h	; 'P'
		sub	bp, bx
		mov	ax, di
		shl	di, 2
		add	di, ax
		shl	di, 4
		mov	ax, cx
		shr	ax, 3
		add	di, ax
		push	di

loc_1A38D:				; CODE XREF: seg000:A394j
		mov	cx, bx
		rep movsb
		add	di, bp
		dec	dx
		jnz	short loc_1A38D
		pop	di
		retn

; =============== S U B	R O U T	I N E =======================================


cmfDrawTextBox	proc near		; CODE XREF: PrintCmfTxt3A+19p
					; PrintCmfTxt4F+23p
		pusha
		push	es
		add	dx, cs:SomeYPosOffset
		add	di, cs:SomeYPosOffset
		pusha
		sub	si, cx
		sub	di, dx
		shr	si, 3
		add	di, 8
		call	cmfB_GFXThing
		popa
		add	dx, cs:word_1BE06
		add	di, cs:word_1BE06
		mov	al, 0C0h
		out	7Ch, al
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		xchg	dx, cx
		xchg	si, bx
		sub	bx, dx
		sub	di, cx
		xchg	di, cx
		call	sub_1A3F2
		xor	al, al
		out	7Ch, al
		pop	es
		assume es:nothing
		popa
		retn
cmfDrawTextBox	endp


; =============== S U B	R O U T	I N E =======================================


sub_1A3F2	proc near		; CODE XREF: cmfDrawTextBox+50p
		mov	byte ptr cs:loc_1A4B5+3, 0
		mov	byte ptr cs:loc_1A4C0+3, 0
		mov	byte ptr cs:loc_1A4CB+3, 0
		mov	byte ptr cs:loc_1A4D6+3, 0
		mov	ax, dx
		xor	dx, dx
		mov	bp, 8
		div	bp
		mov	bp, di
		shl	di, 2
		add	di, bp
		shl	di, 4
		add	di, ax
		add	di, cs:word_1BE02
		add	di, cs:word_1BE02
		push	cx
		cmp	bx, 8
		jnb	short loc_1A462
		mov	cx, bx
		mov	ax, 0FF00h
		shr	ax, cl
		mov	ah, al
		xor	al, al
		mov	cx, dx
		shr	ax, cl
		mov	dx, si
		and	dh, ah
		and	dl, ah
		mov	byte ptr cs:loc_1A4B5+3, dh
		mov	byte ptr cs:loc_1A4CB+3, dl
		mov	dx, si
		and	dh, al
		and	dl, al
		mov	byte ptr cs:loc_1A4C0+3, dh
		mov	byte ptr cs:loc_1A4D6+3, dl
		xor	bp, bp
		jmp	short loc_1A4AB
; ---------------------------------------------------------------------------

loc_1A462:				; CODE XREF: sub_1A3F2+3Bj
		or	dx, dx
		jnz	short loc_1A469
		dec	di
		jmp	short loc_1A486
; ---------------------------------------------------------------------------

loc_1A469:				; CODE XREF: sub_1A3F2+72j
		mov	ax, 8
		sub	ax, dx
		sub	bx, ax
		mov	cx, dx
		mov	dx, 0FFh
		shr	dx, cl
		mov	ax, si
		and	ah, dl
		and	al, dl
		mov	byte ptr cs:loc_1A4B5+3, ah
		mov	byte ptr cs:loc_1A4CB+3, al

loc_1A486:				; CODE XREF: sub_1A3F2+75j
		mov	ax, bx
		mov	bp, 8
		xor	dx, dx
		div	bp
		mov	bp, ax
		or	dx, dx
		jz	short loc_1A4AB
		mov	cx, dx
		mov	dx, 0FF00h
		shr	dx, cl
		mov	ax, si
		and	ah, dl
		and	al, dl
		mov	byte ptr cs:loc_1A4C0+3, ah
		mov	byte ptr cs:loc_1A4D6+3, al

loc_1A4AB:				; CODE XREF: sub_1A3F2+6Ej
					; sub_1A3F2+A1j
		pop	cx
		mov	dx, 4Fh
		sub	dx, bp
		mov	bx, si
		mov	si, cx

loc_1A4B5:				; CODE XREF: sub_1A3F2+EBj
					; DATA XREF: sub_1A3F2w ...
		mov	byte ptr es:[di], 0FFh
		inc	di
		mov	cx, bp
		mov	al, bh
		rep stosb

loc_1A4C0:				; DATA XREF: sub_1A3F2+6w
					; sub_1A3F2+62w ...
		mov	byte ptr es:[di], 0FFh
		add	di, dx
		dec	si
		jnz	short loc_1A4CB
		jmp	short locret_1A4DF
; ---------------------------------------------------------------------------

loc_1A4CB:				; CODE XREF: sub_1A3F2+D5j
					; DATA XREF: sub_1A3F2+Cw ...
		mov	byte ptr es:[di], 0FFh
		inc	di
		mov	cx, bp
		mov	al, bl
		rep stosb

loc_1A4D6:				; DATA XREF: sub_1A3F2+12w
					; sub_1A3F2+67w ...
		mov	byte ptr es:[di], 0FFh
		add	di, dx
		dec	si
		jnz	short loc_1A4B5

locret_1A4DF:				; CODE XREF: sub_1A3F2+D7j
		retn
sub_1A3F2	endp

		assume ds:seg000

; =============== S U B	R O U T	I N E =======================================


GetFontChar_H1	proc near		; CODE XREF: PrintSJISText_H1+41p
		cmp	ah, 0E0h
		jb	short loc_1A4E8
		sub	ah, 40h

loc_1A4E8:				; CODE XREF: GetFontChar_H1+3j
		cmp	al, 9Eh
		jbe	short loc_1A4F3
		sub	ax, 807Eh
		shl	ah, 1
		jmp	short loc_1A4FE
; ---------------------------------------------------------------------------

loc_1A4F3:				; CODE XREF: GetFontChar_H1+Aj
		sub	ax, 8120h
		shl	ah, 1
		inc	ah
		cmp	al, 60h
		adc	al, 0

loc_1A4FE:				; CODE XREF: GetFontChar_H1+11j
		out	0A1h, al	; Interrupt Controller #2, 8259A
		mov	al, ah
		out	0A3h, al	; Interrupt Controller #2, 8259A
		mov	si, offset byte_1A51B
		mov	dx, 0A5h
		mov	cx, 10h

loc_1A50D:				; CODE XREF: GetFontChar_H1+38j
		outs	dx, byte ptr cs:[si]
		in	al, 0A9h	; Interrupt Controller #2, 8259A
		mov	ah, al
		outs	dx, byte ptr cs:[si]
		in	al, 0A9h	; Interrupt Controller #2, 8259A
		stosw
		loop	loc_1A50D
		retn
GetFontChar_H1	endp

; ---------------------------------------------------------------------------
byte_1A51B	db 0, 20h		; DATA XREF: GetFontChar_H1+24o
					; GetFontChar_H2+24o
		db 1, 21h
		db 2, 22h
		db 3, 23h
		db 4, 24h
		db 5, 25h
		db 6, 26h
		db 7, 27h
		db 8, 28h
		db 9, 29h
		db 0Ah,	2Ah
		db 0Bh,	2Bh
		db 0Ch,	2Ch
		db 0Dh,	2Dh
		db 0Eh,	2Eh
		db 0Fh,	2Fh

; =============== S U B	R O U T	I N E =======================================


PrintSJISText_H1 proc near		; CODE XREF: PrintCmfTxt3A+35p
					; PrintCmfTxt4F+3Fp
		pusha
		push	es
		add	dx, cs:SomeYPosOffset
		mov	cs:ptx1RemBytes, al
		mov	cs:ptx1PrintColor, ah
		push	cs
		pop	es
		assume es:seg000
		mov	si, bx
		mov	di, offset ptx1GlyphBuffer
		mov	bx, di
		mov	al, 0Bh
		out	68h, al

ptx1_next:				; CODE XREF: PrintSJISText_H1+35j
					; PrintSJISText_H1+98j	...
		lodsb
		or	al, al
		jnz	short loc_1A560
		jmp	ptx1_end	; byte 00 - end
; ---------------------------------------------------------------------------

loc_1A560:				; CODE XREF: PrintSJISText_H1+20j
		cmp	al, 0E0h
		jnb	short ptx1_sjis	; 0E0h .. 0FFh -> draw Shift-JIS character
		cmp	al, 0A0h
		jnb	short ptx1_skip	; 0A0h .. 0DFh -> draw space
		cmp	al, 80h
		jnb	short ptx1_sjis	; 80h .. 9Fh ->	draw Shift-JIS character
		cmp	al, 20h
		jnb	short ptx1_skip	; 20h .. 7Fh ->	draw space
		jmp	short ptx1_next	; 00h .. 1Fh ->	just read next byte
; ---------------------------------------------------------------------------

ptx1_sjis:				; CODE XREF: PrintSJISText_H1+27j
					; PrintSJISText_H1+2Fj
		mov	ah, al
		lodsb
		push	si
		push	di
		push	ds
		push	cx
		push	dx
		push	es
		pop	ds
		call	GetFontChar_H1
		dec	cs:ptx1RemBytes
		jnz	short loc_1A58F	; note:	This jump is *always* taken.
		xor	al, al		; This part would crash	the program. see PrintSJISText_H2
		mov	cx, 10h

loc_1A58B:				; CODE XREF: PrintSJISText_H1+52j
		inc	di
		stosb
		loop	loc_1A58B

loc_1A58F:				; CODE XREF: PrintSJISText_H1+49j
		call	Font_MakeBold_H1
		pop	dx
		pop	cx
		mov	si, offset word_1A60C
		mov	di, 16
		mov	ah, cs:ptx1PrintColor
		push	es
		push	ds
		pusha
		mov	cs:ptx1TxtXPos,	cx
		mov	cs:ptx1TxtYPos,	dx
		call	SpriteDraw1B
		popa
		pop	ds
		assume ds:nothing
		pop	es
		assume es:nothing
		add	cx, 16		; advance X pointer
		cmp	cx, 592
		jb	short loc_1A5C1
		mov	cx, 48		; reset	X pointer
		add	dx, 16		; advance Y pointer

loc_1A5C1:				; CODE XREF: PrintSJISText_H1+7Ej
		pop	ds
		pop	di
		pop	si
		or	cs:ptx1RemBytes, 0
		jz	short ptx1_end
		dec	cs:ptx1RemBytes
		jz	short ptx1_end
		jmp	short ptx1_next
; ---------------------------------------------------------------------------

ptx1_skip:				; CODE XREF: PrintSJISText_H1+2Bj
					; PrintSJISText_H1+33j
		push	si
		push	di
		push	ds
		push	cx
		push	dx
		push	es
		pop	ds
		pop	dx
		pop	cx
		mov	si, 8
		mov	di, 10h
		mov	ah, cs:ptx1PrintColor
		add	cx, 8
		pop	ds
		pop	di
		pop	si
		dec	cs:ptx1RemBytes
		jz	short ptx1_end
		jmp	ptx1_next
; ---------------------------------------------------------------------------

ptx1_end:				; CODE XREF: PrintSJISText_H1+22j
					; PrintSJISText_H1+8Fj	...
		mov	al, 0Ah
		out	68h, al
		pop	es
		popa
		mov	cx, cs:ptx1TxtXPos
		mov	dx, cs:ptx1TxtYPos
		retn
PrintSJISText_H1 endp

; ---------------------------------------------------------------------------
ptx1RemBytes	db 0			; DATA XREF: PrintSJISText_H1+7w
					; PrintSJISText_H1+44w	...
ptx1PrintColor	db 0			; DATA XREF: PrintSJISText_H1+Bw
					; PrintSJISText_H1+5Fr	...
word_1A60C	dw 0FFFFh		; DATA XREF: PrintSJISText_H1+59o
word_1A60E	dw 2
word_1A610	dw 10h
ptx1GlyphBuffer	db 20h dup(0)		; DATA XREF: PrintSJISText_H1+14o
ptx1TxtXPos	dw 0			; DATA XREF: PrintSJISText_H1+67w
					; PrintSJISText_H1+C4r
ptx1TxtYPos	dw 0			; DATA XREF: PrintSJISText_H1+6Cw
					; PrintSJISText_H1+C9r

; =============== S U B	R O U T	I N E =======================================


Font_MakeBold_H1 proc near		; CODE XREF: PrintSJISText_H1:loc_1A58Fp
		push	ax
		mov	si, bx
		mov	di, bx
		mov	cx, 10h

loc_1A63E:				; CODE XREF: Font_MakeBold_H1+10j
		lodsw
		mov	dx, ax
		rol	dx, 1
		or	ax, dx
		stosw
		loop	loc_1A63E
		pop	ax
		retn
Font_MakeBold_H1 endp

; ---------------------------------------------------------------------------
		push	ax
		mov	si, bx
		mov	di, bx
		mov	cx, 10h

loc_1A652:				; CODE XREF: seg000:A65Aj
		lodsb
		mov	dl, al
		shl	dl, 1
		or	al, dl
		stosb
		loop	loc_1A652
		pop	ax
		retn

; =============== S U B	R O U T	I N E =======================================


sub_1A65E	proc near		; CODE XREF: sub_1406C+14p
					; sub_14094+14p ...
		push	cx
		push	dx
		push	si
		push	ds
		push	cx
		add	dx, cs:SomeYPosOffset
		mov	ds, cs:gfxBufPtr_SDF
		mov	bx, cs:word_1BDF6
		shl	bx, 1
		mov	ax, cs:word_1BE10
		sar	dx, 3
		add	ax, dx
		mul	bx
		sar	cx, 4
		add	cx, cs:word_1BE0C
		shl	cx, 1
		add	ax, cx
		mov	si, ax
		lodsw
		and	ax, 3FFh
		pop	cx
		sub	bx, bx
		cmp	ax, 20h
		jb	short loc_1A6AF
		and	cx, 0Fh
		shr	cx, 1
		sub	ax, 20h
		mov	si, ax
		mov	ds, cs:gfxBufPtr_TDF
		shl	si, 3
		add	si, cx
		mov	bl, [si]

loc_1A6AF:				; CODE XREF: sub_1A65E+39j
		pop	ds
		pop	si
		pop	dx
		pop	cx
		call	sub_1A70D
		retn
sub_1A65E	endp


; =============== S U B	R O U T	I N E =======================================


sub_1A6B7	proc near		; CODE XREF: seg000:5326p seg000:5336p ...
		push	cx
		push	dx
		push	si
		push	ds
		push	cx
		add	dx, cs:SomeYPosOffset
		mov	ds, cs:gfxBufPtr_SDF
		mov	bx, cs:word_1BDF6
		shl	bx, 1
		mov	ax, cs:word_1BE10
		sar	dx, 3
		add	ax, dx
		mul	bx
		sar	cx, 4
		add	cx, cs:word_1BE0C
		shl	cx, 1
		add	ax, cx
		mov	si, ax
		lodsw
		and	ax, 3FFh
		pop	cx
		sub	bx, bx
		cmp	ax, 20h	; ' '
		jb	short loc_1A708
		and	cx, 0Fh
		shr	cx, 1
		sub	ax, 20h	; ' '
		mov	si, ax
		mov	ds, cs:gfxBufPtr_TDF
		shl	si, 3
		add	si, cx
		mov	bl, [si]

loc_1A708:				; CODE XREF: sub_1A6B7+39j
		pop	ds
		pop	si
		pop	dx
		pop	cx
		retn
sub_1A6B7	endp


; =============== S U B	R O U T	I N E =======================================


sub_1A70D	proc near		; CODE XREF: sub_1A65E+55p
		cmp	ax, 1B0h
		jnb	short locret_1A75F
		push	cx
		push	dx
		push	si
		push	es
		push	ds
		push	ax
		push	bx
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		mov	es, ax
		assume es:seg001
		mov	ax, dx
		add	ax, 100
		sar	ax, 2
		shl	ax, 5
		mov	si, ax
		shl	ax, 2
		add	si, ax
		mov	ax, cx
		sar	ax, 3
		add	ax, 40
		add	si, ax
		add	si, offset byte_20AAC
		sub	ax, ax
		lodsb
		test	al, 80h
		jnz	short loc_1A750
		lodsb
		test	al, 80h
		jnz	short loc_1A750
		pop	bx
		pop	ax
		jmp	short loc_1A75A
; ---------------------------------------------------------------------------

loc_1A750:				; CODE XREF: sub_1A70D+38j
					; sub_1A70D+3Dj
		pop	bx
		pop	ax
		mov	ax, cs:word_1BE30
		inc	ax
		mov	bx, 0

loc_1A75A:				; CODE XREF: sub_1A70D+41j
		pop	ds
		assume ds:nothing
		pop	es
		assume es:nothing
		pop	si
		pop	dx
		pop	cx

locret_1A75F:				; CODE XREF: sub_1A70D+3j
		retn
sub_1A70D	endp


; =============== S U B	R O U T	I N E =======================================


cmfB_GFXThing	proc near		; CODE XREF: sub_1990B+30p
					; AddHDFSpr_Mode0+25p ...
		push	bx
		mov	ax, cs:word_1BE0A
		shl	ax, 1
		add	si, ax
		test	dx, 7
		jz	short loc_1A772
		add	di, 8

loc_1A772:				; CODE XREF: cmfB_GFXThing+Dj
		add	cx, 320
		add	dx, 80
		cmp	dx, 352
		jb	short loc_1A782
		mov	dx, 0

loc_1A782:				; CODE XREF: cmfB_GFXThing+1Dj
		cmp	cx, 1264
		jb	short loc_1A78B
		mov	cx, 0

loc_1A78B:				; CODE XREF: cmfB_GFXThing+26j
		mov	ax, cx
		add	ax, si
		cmp	ax, 1280
		jb	short loc_1A799
		sub	ax, 1280
		sub	si, ax

loc_1A799:				; CODE XREF: cmfB_GFXThing+32j
		mov	ax, dx
		add	ax, di
		cmp	ax, 360
		jb	short loc_1A7A7
		sub	ax, 360
		sub	di, ax

loc_1A7A7:				; CODE XREF: cmfB_GFXThing+40j
		mov	cs:word_1A7F7, si
		mov	cs:word_1A7F9, di
		push	es
		shr	dx, 3
		shl	dx, 5
		mov	di, dx
		shl	dx, 2
		add	di, dx
		shr	cx, 4
		shl	cx, 1
		add	di, cx
		add	di, cs:off_1BDF4
		mov	ax, seg	seg001
		mov	es, ax
		assume es:seg001
		sub	ax, ax
		mov	dx, cs:word_1A7F9
		shr	dx, 3
		sub	di, 2
		cld

loc_1A7DE:				; CODE XREF: cmfB_GFXThing+92j
		mov	bx, di
		mov	cx, cs:word_1A7F7
		shr	cx, 1
		inc	cx
		inc	cx
		rep stosw
		mov	di, bx
		add	di, 0A0h
		dec	dx
		jnz	short loc_1A7DE
		pop	es
		assume es:nothing
		pop	bx
		retn
cmfB_GFXThing	endp

; ---------------------------------------------------------------------------
word_1A7F7	dw 0			; DATA XREF: cmfB_GFXThing:loc_1A7A7w
					; cmfB_GFXThing+80r
word_1A7F9	dw 0			; DATA XREF: cmfB_GFXThing+4Cw
					; cmfB_GFXThing+72r

; =============== S U B	R O U T	I N E =======================================


DrawDebugInfo	proc near		; CODE XREF: sub_10F09:loc_1109Fp
					; PrintCmfTxt4F+181p ...
		cmp	cs:ShowDebugTrigger, 0
		jz	short loc_1A809
		xor	cs:ShowDebugState, 0FFFFh

loc_1A809:				; CODE XREF: DrawDebugInfo+6j
		cmp	cs:ShowDebugState, 0FFFFh
		jnz	short loc_1A814
		jmp	locret_1AAB8
; ---------------------------------------------------------------------------

loc_1A814:				; CODE XREF: DrawDebugInfo+14j
		cmp	cs:word_11400, 0
		jnz	short loc_1A81F
		jmp	loc_1AA2E
; ---------------------------------------------------------------------------

loc_1A81F:				; CODE XREF: DrawDebugInfo+1Fj
		push	es
		push	ds
		pusha
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		mov	cx, 60
		mov	bp, offset EnemyObjects
		sub	bx, bx

loc_1A82F:				; CODE XREF: DrawDebugInfo+40j
		cmp	word ptr ds:[bp+2], 0
		jz	short loc_1A837
		inc	bx

loc_1A837:				; CODE XREF: DrawDebugInfo+39j
		add	bp, 98h
		loop	loc_1A82F
		mov	cs:EnemyObjCount, bx
		mov	ax, seg	seg001
		mov	ds, ax
		mov	cx, 160
		mov	dx, 48
		mov	si, offset aDebugInfomatio ; "DEBUG INFOMATION MODE"
		call	DrawASCIIStr
		mov	ax, cs:MapPosX
		push	cx
		push	ax
		mov	ax, ax
		mov	cl, 100
		div	cl
		push	cx
		push	ax
		mov	al, al
		xor	ah, ah
		mov	cl, 100
		div	cl
		mov	al, ah
		xor	ah, ah
		mov	cl, 10
		div	cl
		add	al, '0'
		mov	byte ptr aMapX00000000+0Fh, al
		add	ah, '0'
		mov	byte ptr aMapX00000000+10h, ah
		pop	ax
		pop	cx
		push	cx
		push	ax
		mov	al, ah
		xor	ah, ah
		mov	cl, 100
		div	cl
		mov	al, ah
		xor	ah, ah
		mov	cl, 10
		div	cl
		add	al, '0'
		mov	byte ptr aMapX00000000+11h, al
		add	ah, 48
		mov	byte ptr aMapX00000000+12h, ah
		pop	ax
		pop	cx
		pop	ax
		pop	cx
		shr	ax, 4
		push	cx
		push	ax
		mov	ax, ax
		mov	cl, 100
		div	cl
		push	cx
		push	ax
		mov	al, al
		xor	ah, ah
		mov	cl, 100
		div	cl
		mov	al, ah
		xor	ah, ah
		mov	cl, 10
		div	cl
		add	al, '0'
		mov	byte ptr aMapX00000000+9, al
		add	ah, '0'
		mov	byte ptr aMapX00000000+0Ah, ah
		pop	ax
		pop	cx
		push	cx
		push	ax
		mov	al, ah
		xor	ah, ah
		mov	cl, 100
		div	cl
		mov	al, ah
		xor	ah, ah
		mov	cl, 10
		div	cl
		add	al, '0'
		mov	byte ptr aMapX00000000+0Bh, al
		add	ah, '0'
		mov	byte ptr aMapX00000000+0Ch, ah
		pop	ax
		pop	cx
		pop	ax
		pop	cx
		mov	cx, 192
		mov	dx, 64
		mov	si, offset aMapX00000000 ; "MAP	X  : 0000 (0000)"
		call	DrawASCIIStr
		mov	ax, cs:MapPosY
		push	cx
		push	ax
		mov	ax, ax
		mov	cl, 100
		div	cl
		push	cx
		push	ax
		mov	al, al
		xor	ah, ah
		mov	cl, 100
		div	cl
		mov	al, ah
		xor	ah, ah
		mov	cl, 10
		div	cl
		add	al, '0'
		mov	byte ptr aMapY00000000+0Fh, al
		add	ah, '0'
		mov	byte ptr aMapY00000000+10h, ah
		pop	ax
		pop	cx
		push	cx
		push	ax
		mov	al, ah
		xor	ah, ah
		mov	cl, 100
		div	cl
		mov	al, ah
		xor	ah, ah
		mov	cl, 10
		div	cl
		add	al, '0'
		mov	byte ptr aMapY00000000+11h, al
		add	ah, '0'
		mov	byte ptr aMapY00000000+12h, ah
		pop	ax
		pop	cx
		pop	ax
		pop	cx
		shr	ax, 3
		push	cx
		push	ax
		mov	ax, ax
		mov	cl, 100
		div	cl
		push	cx
		push	ax
		mov	al, al
		xor	ah, ah
		mov	cl, 100
		div	cl
		mov	al, ah
		xor	ah, ah
		mov	cl, 10
		div	cl
		add	al, '0'
		mov	byte ptr aMapY00000000+9, al
		add	ah, '0'
		mov	byte ptr aMapY00000000+0Ah, ah
		pop	ax
		pop	cx
		push	cx
		push	ax
		mov	al, ah
		xor	ah, ah
		mov	cl, 100
		div	cl
		mov	al, ah
		xor	ah, ah
		mov	cl, 10
		div	cl
		add	al, '0'
		mov	byte ptr aMapY00000000+0Bh, al
		add	ah, '0'
		mov	byte ptr aMapY00000000+0Ch, ah
		pop	ax
		pop	cx
		pop	ax
		pop	cx
		mov	cx, 192
		mov	dx, 72
		mov	si, offset aMapY00000000 ; "MAP	Y  : 0000 (0000)"
		call	DrawASCIIStr
		mov	ax, cs:SpriteCount
		push	cx
		push	ax
		mov	ax, ax
		mov	cl, 100
		div	cl
		push	cx
		push	ax
		mov	al, al
		xor	ah, ah
		mov	cl, 100
		div	cl
		mov	al, ah
		xor	ah, ah
		mov	cl, 10
		div	cl
		add	al, '0'
		mov	byte ptr aSprite0000+9,	al
		add	ah, '0'
		mov	byte ptr aSprite0000+0Ah, ah
		pop	ax
		pop	cx
		push	cx
		push	ax
		mov	al, ah
		xor	ah, ah
		mov	cl, 100
		div	cl
		mov	al, ah
		xor	ah, ah
		mov	cl, 10
		div	cl
		add	al, '0'
		mov	byte ptr aSprite0000+0Bh, al
		add	ah, '0'
		mov	byte ptr aSprite0000+0Ch, ah
		pop	ax
		pop	cx
		pop	ax
		pop	cx
		mov	cx, 192
		mov	dx, 80
		mov	si, offset aSprite0000 ; "SPRITE : 0000"
		call	DrawASCIIStr
		mov	ax, cs:EnemyObjCount
		push	cx
		push	ax
		mov	al, al
		xor	ah, ah
		mov	cl, 100
		div	cl
		mov	al, ah
		xor	ah, ah
		mov	cl, 10
		div	cl
		add	al, '0'
		mov	byte ptr aEnemyObject006+0Fh, al
		add	ah, '0'
		mov	byte ptr aEnemyObject006+10h, ah
		pop	ax
		pop	cx
		mov	cx, 96
		mov	dx, 88
		mov	si, offset aEnemyObject006 ; "ENEMY OBJECT : 00	/ 60"
		call	DrawASCIIStr
		popa
		pop	ds
		assume ds:nothing
		pop	es

loc_1AA2E:				; CODE XREF: DrawDebugInfo+21j
		mov	bx, cs:SomeYPosOffset
		add	bx, cs:word_1BE06
		cmp	cs:word_111E7, 0
		jz	short loc_1AA5D
		dec	cs:word_111E7
		push	ax
		mov	ax, 8
		call	GetRandomInRange
		inc	ax
		sub	ax, 4
		add	bx, ax
		cmp	bx, 190h
		jb	short loc_1AA5C
		sub	bx, ax
		sub	bx, ax

loc_1AA5C:				; CODE XREF: DrawDebugInfo+25Bj
		pop	ax

loc_1AA5D:				; CODE XREF: DrawDebugInfo+243j
		mov	dx, 190h
		sub	bx, dx
		sbb	ax, ax
		and	bx, ax
		add	bx, dx
		sub	dx, bx
		mov	bp, bx
		mov	cx, 1
		shl	bx, 1
		shl	dx, 1
		mov	cl, 4

loc_1AA75:				; CODE XREF: DrawDebugInfo+280j
		jmp	short $+2
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 4
		jz	short loc_1AA75
		mov	al, 70h	; 'p'
		out	0A2h, al	; Interrupt Controller #2, 8259A
		mov	ax, bp
		shl	ax, 2
		add	ax, bp
		shl	ax, 3
		add	ax, cs:word_1BE02
		call	sub_1AABB
		mov	ax, dx
		shl	ax, 4
		call	sub_1AABB
		sub	ax, ax
		call	sub_1AABB
		mov	ax, bx
		shl	ax, 4
		call	sub_1AABB
		cmp	cs:word_1BE0A, 0
		jz	short loc_1AAB5
		call	SetIO_A4_01
		jmp	short locret_1AAB8
; ---------------------------------------------------------------------------

loc_1AAB5:				; CODE XREF: DrawDebugInfo+2B3j
		call	SetIO_A4_00

locret_1AAB8:				; CODE XREF: DrawDebugInfo+16j
					; DrawDebugInfo+2B8j
		retn
DrawDebugInfo	endp

; ---------------------------------------------------------------------------
EnemyObjCount	dw 0			; DATA XREF: DrawDebugInfo+42w
					; DrawDebugInfo+200r

; =============== S U B	R O U T	I N E =======================================


sub_1AABB	proc near		; CODE XREF: DrawDebugInfo+295p
					; DrawDebugInfo+29Dp ...
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1
		mov	al, ah
		jmp	short $+2
		jmp	short $+2
		jmp	short $+2
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1
		retn
sub_1AABB	endp


; =============== S U B	R O U T	I N E =======================================


sub_1AAC8	proc near		; CODE XREF: sub_10F09+37p
					; PrintCmfTxt4F+17Bp ...
		mov	ax, cs:MapPosY
		push	ax
		shr	ax, 3
		mov	cs:word_1BE10, ax
		pop	ax
		and	ax, 7
		mov	cs:SomeYPosOffset, ax
		mov	ax, cs:MapPosX
		shr	ax, 4
		mov	cs:word_1BE0C, ax
		cmp	cs:word_1BDF2, 0
		jz	short loc_1AB12
		sub	dx, dx
		mov	ax, cs:word_1BE0C
		mov	cs:word_1BE02, ax
		shl	ax, 4
		mov	cs:word_1BE04, ax
		mov	dx, ax
		mov	cs:word_1BE2C, dx
		add	dx, 27Fh
		mov	cs:word_1BE2E, dx
		jmp	short loc_1AB20
; ---------------------------------------------------------------------------

loc_1AB12:				; CODE XREF: sub_1AAC8+25j
		mov	cs:word_1BE2C, 10h
		mov	cs:word_1BE2E, 270h

loc_1AB20:				; CODE XREF: sub_1AAC8+48j
		cmp	cs:ShowDebugState, 0FFFFh
		jnz	short loc_1AB2B
		jmp	locret_1AC19
; ---------------------------------------------------------------------------

loc_1AB2B:				; CODE XREF: sub_1AAC8+5Ej
		cmp	cs:word_1BDE8, 1
		jnz	short loc_1AB36
		jmp	loc_1AD52
; ---------------------------------------------------------------------------

loc_1AB36:				; CODE XREF: sub_1AAC8+69j
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		cmp	cs:word_1BE06, 0
		jnz	short loc_1AB53
		mov	cs:word_1BE06, 0C8h ; '»'
		mov	cs:word_1BE08, 3E80h
		jmp	short loc_1AB61
; ---------------------------------------------------------------------------

loc_1AB53:				; CODE XREF: sub_1AAC8+79j
		mov	cs:word_1BE06, 0
		mov	cs:word_1BE08, 0

loc_1AB61:				; CODE XREF: sub_1AAC8+89j
		mov	ax, cs:MapPosX
		shr	ax, 3
		test	ax, 1
		jnz	short loc_1ABC9
		cmp	cs:word_1BE06, 0
		jnz	short loc_1AB9F
		call	SetIO_A6_00
		mov	di, offset word_25C1A
		mov	cs:off_1BDF4, di
		add	di, 640h
		call	sub_1B696
		mov	si, (offset word_25C1A+708h)
		mov	di, 281h
		call	sub_1AE88
		mov	cs:word_1BE0A, 0
		add	cs:word_1BE2C, 8
		jmp	short locret_1AC19
; ---------------------------------------------------------------------------

loc_1AB9F:				; CODE XREF: sub_1AAC8+ABj
		call	SetIO_A6_00
		mov	di, offset word_29462
		mov	cs:off_1BDF4, di
		add	di, 640h
		call	sub_1B696
		mov	si, (offset word_29462+708h)
		mov	di, 4101h
		call	sub_1AE88
		mov	cs:word_1BE0A, 0
		add	cs:word_1BE2C, 8
		jmp	short locret_1AC19
; ---------------------------------------------------------------------------

loc_1ABC9:				; CODE XREF: sub_1AAC8+A3j
		cmp	cs:word_1BE06, 0
		jnz	short loc_1ABF5
		call	SetIO_A6_01
		mov	di, offset word_2783E
		mov	cs:off_1BDF4, di
		add	di, 640h
		call	sub_1B696
		mov	di, 280h
		mov	si, (offset word_2783E+708h)
		call	sub_1AE88
		mov	cs:word_1BE0A, 1
		jmp	short locret_1AC19
; ---------------------------------------------------------------------------

loc_1ABF5:				; CODE XREF: sub_1AAC8+107j
		call	SetIO_A6_01
		mov	di, offset word_2B086
		mov	cs:off_1BDF4, di
		add	di, 640h
		call	sub_1B696
		mov	si, (offset word_2B086+708h)
		mov	di, 4100h
		call	sub_1AE88
		mov	cs:word_1BE0A, 1
		jmp	short $+2

locret_1AC19:				; CODE XREF: sub_1AAC8+60j
					; sub_1AAC8+D5j ...
		retn
; ---------------------------------------------------------------------------
SomeYPosOffset	dw 0			; DATA XREF: sub_1990B+20r
					; AddHDFSpr_Mode0+16r ...
		db 2 dup(0)
; ---------------------------------------------------------------------------

loc_1AC1E:				; CODE XREF: sub_1AAC8:loc_1AD65j
		cmp	cs:word_1BE0A, 0
		jz	short loc_1AC4E
		call	SetIO_A6_00
		mov	di, offset word_25C1A
		mov	cs:off_1BDF4, di
		add	di, 640h
		call	sub_1B696
		mov	di, 280h
		mov	si, offset word_25C1A
		add	si, 708h
		call	sub_1B02A
		mov	cs:word_1BE0A, 0
		jmp	short locret_1AC76
; ---------------------------------------------------------------------------

loc_1AC4E:				; CODE XREF: sub_1AAC8+15Cj
		call	SetIO_A6_01
		mov	di, offset word_2783E
		mov	cs:off_1BDF4, di
		add	di, 640h
		call	sub_1B696
		mov	si, offset word_2783E
		add	si, 708h
		mov	di, 280h
		call	sub_1B02A
		mov	cs:word_1BE0A, 1
		jmp	short $+2

locret_1AC76:				; CODE XREF: sub_1AAC8+184j
		retn
; ---------------------------------------------------------------------------

loc_1AC77:				; CODE XREF: sub_1AAC8+29Aj
		cmp	cs:word_1BE0A, 0
		jz	short loc_1ACE3
		call	SetIO_A6_00
		mov	di, offset word_25C1A
		mov	cs:off_1BDF4, di
		mov	ax, cs:MapPosX
		cmp	cs:word_1AD4A, ax
		jz	short loc_1ACA9
		mov	cs:word_1AD4A, ax
		mov	ax, cs:MapPosY
		and	ax, 0FFF8h
		mov	cs:word_1AD4C, ax
		call	sub_1B9FE
		jmp	short loc_1ACC6
; ---------------------------------------------------------------------------

loc_1ACA9:				; CODE XREF: sub_1AAC8+1CBj
		mov	ax, cs:MapPosY
		and	ax, 0FFF8h
		cmp	cs:word_1AD4C, ax
		jz	short loc_1ACC6
		mov	cs:word_1AD4C, ax
		mov	ax, cs:MapPosX
		mov	cs:word_1AD4A, ax
		call	sub_1B9FE

loc_1ACC6:				; CODE XREF: sub_1AAC8+1DFj
					; sub_1AAC8+1EDj
		add	di, 640h
		call	sub_1B696
		mov	di, 280h
		mov	si, offset word_25C1A
		add	si, 708h
		call	sub_1B0F4
		mov	cs:word_1BE0A, 0
		jmp	short locret_1AD49
; ---------------------------------------------------------------------------

loc_1ACE3:				; CODE XREF: sub_1AAC8+1B5j
		call	SetIO_A6_01
		mov	di, offset word_2783E
		mov	cs:off_1BDF4, di
		mov	ax, cs:MapPosX
		cmp	cs:word_1AD4E, ax
		jz	short loc_1AD0D
		mov	cs:word_1AD4E, ax
		mov	ax, cs:MapPosY
		and	ax, 0FFF8h
		mov	cs:word_1AD50, ax
		call	sub_1B9FE
		jmp	short loc_1AD2C
; ---------------------------------------------------------------------------

loc_1AD0D:				; CODE XREF: sub_1AAC8+22Fj
		mov	ax, cs:MapPosY
		and	ax, 0FFF8h
		cmp	cs:word_1AD50, ax
		jz	short loc_1AD2C
		mov	cs:word_1AD50, ax
		mov	ax, cs:MapPosX
		mov	cs:word_1AD4E, ax
		call	sub_1B9FE
		jmp	short $+2

loc_1AD2C:				; CODE XREF: sub_1AAC8+243j
					; sub_1AAC8+251j
		add	di, 640h
		call	sub_1B696
		mov	si, offset word_2783E
		add	si, 708h
		mov	di, 280h
		call	sub_1B0F4
		mov	cs:word_1BE0A, 1
		jmp	short $+2

locret_1AD49:				; CODE XREF: sub_1AAC8+219j
		retn
; ---------------------------------------------------------------------------
word_1AD4A	dw 0			; DATA XREF: sub_1AAC8+1C6r
					; sub_1AAC8+1CDw ...
word_1AD4C	dw 0			; DATA XREF: sub_1AAC8+1D8w
					; sub_1AAC8+1E8r ...
word_1AD4E	dw 0			; DATA XREF: sub_1AAC8+22Ar
					; sub_1AAC8+231w ...
word_1AD50	dw 0			; DATA XREF: sub_1AAC8+23Cw
					; sub_1AAC8+24Cr ...
; ---------------------------------------------------------------------------

loc_1AD52:				; CODE XREF: sub_1AAC8+6Bj
		cmp	cs:word_1BDEE, 1
		jnz	short loc_1AD68
		cmp	cs:word_1BDF0, 1
		jnz	short loc_1AD65
		jmp	loc_1AC77
; ---------------------------------------------------------------------------

loc_1AD65:				; CODE XREF: sub_1AAC8+298j
		jmp	loc_1AC1E
; ---------------------------------------------------------------------------

loc_1AD68:				; CODE XREF: sub_1AAC8+290j
		mov	ax, seg	seg001
		mov	ds, ax
		cmp	cs:word_1BE06, 0
		jnz	short loc_1AD85
		mov	cs:word_1BE06, 0C8h ; '»'
		mov	cs:word_1BE08, 3E80h
		jmp	short loc_1AD93
; ---------------------------------------------------------------------------

loc_1AD85:				; CODE XREF: sub_1AAC8+2ABj
		mov	cs:word_1BE06, 0
		mov	cs:word_1BE08, 0

loc_1AD93:				; CODE XREF: sub_1AAC8+2BBj
		mov	ax, cs:MapPosX
		shr	ax, 3
		test	ax, 1
		jnz	short loc_1AE1A
		cmp	cs:word_1BE06, 0
		jnz	short loc_1ADE1
		call	SetIO_A6_00
		mov	di, offset word_25C1A
		mov	cs:off_1BDF4, di
		add	di, 640h
		call	sub_1B696
		mov	si, offset word_25C1A
		add	si, 708h
		mov	di, 280h
		call	nullsub_1
		inc	di
		mov	cs:word_1B405, 77h ; 'w'
		call	sub_1B40A
		mov	cs:word_1BE0A, 0
		add	cs:word_1BE2C, 8
		jmp	locret_1AE86
; ---------------------------------------------------------------------------

loc_1ADE1:				; CODE XREF: sub_1AAC8+2DDj
		call	SetIO_A6_00
		mov	di, offset word_29462
		mov	cs:off_1BDF4, di
		add	di, 640h
		call	sub_1B696
		mov	si, offset word_29462
		add	si, 708h
		mov	di, 4100h
		call	nullsub_1
		inc	di
		mov	cs:word_1B405, 77h ; 'w'
		call	sub_1B40A
		mov	cs:word_1BE0A, 0
		add	cs:word_1BE2C, 8
		jmp	short locret_1AE86
; ---------------------------------------------------------------------------

loc_1AE1A:				; CODE XREF: sub_1AAC8+2D5j
		cmp	cs:word_1BE06, 0
		jnz	short loc_1AE54
		call	SetIO_A6_01
		mov	di, offset word_2783E
		mov	cs:off_1BDF4, di
		add	di, 640h
		call	sub_1B696
		mov	di, 280h
		mov	si, offset word_2783E
		add	si, 708h
		call	nullsub_1
		mov	cs:word_1B405, 0
		call	sub_1B1D8
		mov	cs:word_1BE0A, 1
		jmp	short locret_1AE86
; ---------------------------------------------------------------------------

loc_1AE54:				; CODE XREF: sub_1AAC8+358j
		call	SetIO_A6_01
		mov	di, offset word_2B086
		mov	cs:off_1BDF4, di
		add	di, 640h
		call	sub_1B696
		mov	si, offset word_2B086
		add	si, 708h
		mov	di, 4100h
		call	nullsub_1
		mov	cs:word_1B405, 0
		call	sub_1B1D8
		mov	cs:word_1BE0A, 1
		jmp	short $+2

locret_1AE86:				; CODE XREF: sub_1AAC8+316j
					; sub_1AAC8+350j ...
		retn
sub_1AAC8	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_1AE88	proc near		; CODE XREF: sub_1AAC8+C5p
					; sub_1AAC8+EFp ...
		add	di, cs:word_1BE02
		add	di, cs:word_1BE02
		mov	ds, cs:gfxBufPtr_RDF
		assume ds:nothing
		mov	ax, seg	seg001
		mov	es, ax
		assume es:seg001
		mov	cx, 17h

loc_1AE9F:				; CODE XREF: sub_1AE88:loc_1B01Cj
		push	cx
		mov	cx, 28h	; '('

loc_1AEA3:				; CODE XREF: sub_1AE88:loc_1B00Dj
		mov	ax, es:[si]
		add	si, 2
		mov	dx, si
		test	ax, 0FC00h
		jnz	short loc_1AEB3
		jmp	loc_1B005
; ---------------------------------------------------------------------------

loc_1AEB3:				; CODE XREF: sub_1AE88+26j
		mov	cs:byte_1AF65, al
		mov	cs:byte_1AFB4, al
		mov	bp, ax
		sub	ax, 20h	; ' '
		and	ax, 3FFh
		shl	ax, 4
		mov	si, ax
		shl	ax, 2
		add	si, ax
		shr	bp, 9
		and	bp, 0FFFEh
		mov	bx, 0B020h
		add	bx, bp
		jmp	word ptr cs:[bx]
; ---------------------------------------------------------------------------
		mov	bx, di
		mov	bp, 4Eh	; 'N'
		push	es
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		movsw
		add	di, bp
		movsw
		add	di, bp
		movsw
		add	di, bp
		movsw
		add	di, bp
		movsw
		add	di, bp
		movsw
		add	di, bp
		movsw
		add	di, bp
		movsw
		mov	di, bx
		mov	ax, 0B000h
		mov	es, ax
		assume es:nothing
		movsw
		add	di, bp
		movsw
		add	di, bp
		movsw
		add	di, bp
		movsw
		add	di, bp
		movsw
		add	di, bp
		movsw
		add	di, bp
		movsw
		add	di, bp
		movsw
		mov	di, bx
		mov	ax, 0B800h
		mov	es, ax
		assume es:nothing
		movsw
		add	di, bp
		movsw
		add	di, bp
		movsw
		add	di, bp
		movsw
		add	di, bp
		movsw
		add	di, bp
		movsw
		add	di, bp
		movsw
		add	di, bp
		movsw
		mov	di, bx
		mov	ax, 0E000h
		mov	es, ax
		assume es:nothing
		movsw
		add	di, bp
		movsw
		add	di, bp
		movsw
		add	di, bp
		movsw
		add	di, bp
		movsw
		add	di, bp
		movsw
		add	di, bp
		movsw
		add	di, bp
		movsw
		mov	di, bx
		pop	es
		assume es:nothing
		jmp	loc_1B005
; ---------------------------------------------------------------------------
		jmp	loc_1B005
; ---------------------------------------------------------------------------
		db 0B0h, 0C0h, 0E6h, 7Ch, 8Bh, 0C5h, 86h, 0E0h,	0B4h
byte_1AF65	db 0			; DATA XREF: sub_1AE88:loc_1AEB3w
; ---------------------------------------------------------------------------
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		mov	bx, di
		mov	bp, 4Eh	; 'N'
		push	es
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		mov	ax, 0FFFFh
		stosw
		add	di, bp
		stosw
		add	di, bp
		stosw
		add	di, bp
		stosw
		add	di, bp
		stosw
		add	di, bp
		stosw
		add	di, bp
		stosw
		add	di, bp
		stosw
		pop	es
		assume es:nothing
		xor	al, al
		out	7Ch, al
		mov	di, bx
		jmp	short loc_1B005
; ---------------------------------------------------------------------------
		db 0B0h, 0C0h, 0E6h, 7Ch, 8Bh, 0C5h, 86h, 0E0h,	0B4h
byte_1AFB4	db 0			; DATA XREF: sub_1AE88+2Fw
; ---------------------------------------------------------------------------
		sub	ah, 10h
		ror	ah, 1
		sbb	al, al
		or	al, 55h
		out	7Eh, al
		ror	ah, 1
		sbb	al, al
		and	al, 0AAh
		out	7Eh, al
		ror	ah, 1
		sbb	al, al
		and	al, 0AAh
		out	7Eh, al
		ror	ah, 1
		sbb	al, al
		and	al, 0AAh
		out	7Eh, al
		mov	bx, di
		mov	bp, 4Eh	; 'N'
		push	es
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		mov	ax, 0FFFFh
		stosw
		add	di, bp
		stosw
		add	di, bp
		stosw
		add	di, bp
		stosw
		add	di, bp
		stosw
		add	di, bp
		stosw
		add	di, bp
		stosw
		add	di, bp
		stosw
		pop	es
		assume es:nothing
		sub	al, al
		out	7Ch, al
		mov	di, bx
		jmp	short $+2

loc_1B005:				; CODE XREF: sub_1AE88+28j
					; sub_1AE88+CEj ...
		inc	di
		inc	di
		mov	si, dx
		loop	loc_1B00D
		jmp	short loc_1B010
; ---------------------------------------------------------------------------

loc_1B00D:				; CODE XREF: sub_1AE88+181j
		jmp	loc_1AEA3
; ---------------------------------------------------------------------------

loc_1B010:				; CODE XREF: sub_1AE88+183j
		add	di, 230h
		add	si, 50h	; 'P'
		pop	cx
		loop	loc_1B01C
		jmp	short locret_1B01F
; ---------------------------------------------------------------------------

loc_1B01C:				; CODE XREF: sub_1AE88+190j
		jmp	loc_1AE9F
; ---------------------------------------------------------------------------

locret_1B01F:				; CODE XREF: sub_1AE88+192j
		retn
sub_1AE88	endp

; ---------------------------------------------------------------------------
		add	ax, 0DBB0h
		scasb
		pop	cx
		scasw
		pop	sp
		scasw
		stosw
		scasw

; =============== S U B	R O U T	I N E =======================================


sub_1B02A	proc near		; CODE XREF: sub_1AAC8+17Ap
					; sub_1AAC8+1A2p
		mov	al, 80h	; 'Ä'
		out	7Ch, al
		mov	al, 7
		out	6Ah, al
		mov	al, 5
		out	6Ah, al

loc_1B036:				; CODE XREF: sub_1B0F4+18j
		mov	ax, 0
		mov	dx, 4ACh
		out	dx, ax
		mov	ax, 0Fh
		mov	dx, 4AEh
		out	dx, ax
		mov	ax, 29F0h
		mov	dx, 4A4h
		out	dx, ax
		mov	ax, 0FFFFh
		mov	dx, 4A8h
		out	dx, ax
		add	di, cs:word_1BE02
		add	di, cs:word_1BE02
		mov	ax, 0A800h
		mov	ds, ax
		assume ds:nothing
		mov	ax, seg	seg001
		mov	es, ax
		assume es:seg001
		mov	cx, 17h

loc_1B069:				; CODE XREF: sub_1B02A+B3j
		push	cx
		mov	cx, 28h	; '('

loc_1B06D:				; CODE XREF: sub_1B02A+A9j
		mov	ax, es:[si]
		add	si, 2
		mov	dx, si
		test	ax, 0FC00h
		jz	short loc_1B0CF
		mov	bp, ax
		and	ax, 3FFh
		push	dx
		sub	dx, dx
		mov	bx, 28h	; '('
		div	bx
		shl	ax, 3
		shl	ax, 4
		mov	si, ax
		shl	ax, 2
		add	si, ax
		shl	dx, 1
		add	si, dx
		add	si, 3ED0h
		pop	dx
		mov	bx, di
		mov	bp, 4Eh	; 'N'
		push	es
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		movsw
		add	si, bp
		add	di, bp
		movsw
		add	si, bp
		add	di, bp
		movsw
		add	si, bp
		add	di, bp
		movsw
		add	si, bp
		add	di, bp
		movsw
		add	si, bp
		add	di, bp
		movsw
		add	si, bp
		add	di, bp
		movsw
		add	si, bp
		add	di, bp
		movsw
		mov	di, bx
		pop	es
		assume es:nothing

loc_1B0CF:				; CODE XREF: sub_1B02A+4Ej
		inc	di
		inc	di
		mov	si, dx
		loop	loc_1B06D
		add	di, 230h
		add	si, 50h	; 'P'
		pop	cx
		loop	loc_1B069
		mov	ax, 0
		mov	dx, 4ACh
		out	dx, ax
		mov	al, 4
		out	6Ah, al
		mov	al, 6
		out	6Ah, al
		mov	al, 0
		out	7Ch, al
		retn
sub_1B02A	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_1B0F4	proc near		; CODE XREF: sub_1AAC8+20Fp
					; sub_1AAC8+275p
		mov	al, 80h	; 'Ä'
		out	7Ch, al
		mov	al, 7
		out	6Ah, al
		mov	al, 5
		out	6Ah, al
		mov	ax, cs:MapPosX
		and	ax, 0Fh
		cmp	ax, 0Fh
		jnz	short loc_1B10F
		jmp	loc_1B036
; ---------------------------------------------------------------------------

loc_1B10F:				; CODE XREF: sub_1B0F4+16j
		xor	ax, 0Fh
		shl	ax, 4
		mov	dx, 4ACh
		out	dx, ax
		mov	ax, 0Fh
		mov	dx, 4AEh
		out	dx, ax
		mov	ax, 29F0h
		mov	dx, 4A4h
		out	dx, ax
		mov	ax, 0FFFFh
		mov	dx, 4A8h
		out	dx, ax
		add	di, cs:word_1BE02
		add	di, cs:word_1BE02
		mov	ax, 0A800h
		mov	ds, ax
		mov	ax, seg	seg001
		mov	es, ax
		assume es:seg001
		mov	cx, 17h

loc_1B145:				; CODE XREF: sub_1B0F4+CDj
		push	cx
		mov	cx, 28h	; '('

loc_1B149:				; CODE XREF: sub_1B0F4+C3j
		mov	ax, es:[si]
		add	si, 2
		mov	dx, si
		test	ax, 0FC00h
		jz	short loc_1B1B3
		mov	bp, ax
		and	ax, 3FFh
		push	dx
		sub	dx, dx
		mov	bx, 28h	; '('
		div	bx
		shl	ax, 3
		shl	ax, 4
		mov	si, ax
		shl	ax, 2
		add	si, ax
		shl	dx, 1
		add	si, dx
		add	si, 3ED0h
		pop	dx
		mov	bx, di
		mov	bp, 4Ch	; 'L'
		push	es
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		movsw
		movsw
		add	si, bp
		add	di, bp
		movsw
		movsw
		add	si, bp
		add	di, bp
		movsw
		movsw
		add	si, bp
		add	di, bp
		movsw
		movsw
		add	si, bp
		add	di, bp
		movsw
		movsw
		add	si, bp
		add	di, bp
		movsw
		movsw
		add	si, bp
		add	di, bp
		movsw
		movsw
		add	si, bp
		add	di, bp
		movsw
		movsw
		mov	di, bx
		pop	es
		assume es:nothing

loc_1B1B3:				; CODE XREF: sub_1B0F4+60j
		inc	di
		inc	di
		mov	si, dx
		loop	loc_1B149
		add	di, 230h
		add	si, 50h	; 'P'
		pop	cx
		loop	loc_1B145
		mov	ax, 0
		mov	dx, 4ACh
		out	dx, ax
		mov	al, 4
		out	6Ah, al
		mov	al, 6
		out	6Ah, al
		mov	al, 0
		out	7Ch, al
		retn
sub_1B0F4	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_1B1D8	proc near		; CODE XREF: sub_1AAC8+380p
					; sub_1AAC8+3B2p
		mov	al, 80h	; 'Ä'
		out	7Ch, al
		mov	al, 7
		out	6Ah, al
		mov	al, 5
		out	6Ah, al
		mov	ax, 0
		mov	dx, 4ACh
		out	dx, ax
		mov	ax, 0Fh
		mov	dx, 4AEh
		out	dx, ax
		mov	ax, 29F0h
		mov	dx, 4A4h
		out	dx, ax
		add	di, cs:word_1BE02
		add	di, cs:word_1BE02
		mov	ds, cs:gfxBufPtr_RDF
		assume ds:nothing
		mov	ax, seg	seg001
		mov	es, ax
		assume es:seg001
		mov	cx, 17h

loc_1B210:				; CODE XREF: sub_1B1D8:loc_1B3EBj
		push	cx
		mov	cx, 28h	; '('

loc_1B214:				; CODE XREF: sub_1B1D8:loc_1B3DCj
		mov	ax, es:[si]
		add	si, 2
		mov	dx, si
		test	ax, 0FC00h
		jnz	short loc_1B224
		jmp	loc_1B3D4
; ---------------------------------------------------------------------------

loc_1B224:				; CODE XREF: sub_1B1D8+47j
		mov	cs:byte_1B2F0, al
		mov	cs:byte_1B340, al
		mov	bp, ax
		and	ax, 3FFh
		mov	bx, ax
		shl	bx, 1
		add	bx, 5586h
		mov	bx, es:[bx]
		or	bx, bx
		jz	short loc_1B243
		jmp	loc_1B391
; ---------------------------------------------------------------------------

loc_1B243:				; CODE XREF: sub_1B1D8+66j
		sub	ax, 20h	; ' '
		shl	ax, 4
		mov	si, ax
		shl	ax, 2
		add	si, ax
		shr	bp, 9
		and	bp, 0FFFEh
		mov	bx, 0B3FBh
		add	bx, bp
		jmp	word ptr cs:[bx]
; ---------------------------------------------------------------------------
		xor	al, al
		out	7Ch, al
		mov	bx, di
		mov	bp, 4Eh	; 'N'
		push	es
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		movsw
		add	di, bp
		movsw
		add	di, bp
		movsw
		add	di, bp
		movsw
		add	di, bp
		movsw
		add	di, bp
		movsw
		add	di, bp
		movsw
		add	di, bp
		movsw
		mov	di, bx
		mov	ax, 0B000h
		mov	es, ax
		assume es:nothing
		movsw
		add	di, bp
		movsw
		add	di, bp
		movsw
		add	di, bp
		movsw
		add	di, bp
		movsw
		add	di, bp
		movsw
		add	di, bp
		movsw
		add	di, bp
		movsw
		mov	di, bx
		mov	ax, 0B800h
		mov	es, ax
		assume es:nothing
		movsw
		add	di, bp
		movsw
		add	di, bp
		movsw
		add	di, bp
		movsw
		add	di, bp
		movsw
		add	di, bp
		movsw
		add	di, bp
		movsw
		add	di, bp
		movsw
		mov	di, bx
		mov	ax, 0E000h
		mov	es, ax
		assume es:nothing
		movsw
		add	di, bp
		movsw
		add	di, bp
		movsw
		add	di, bp
		movsw
		add	di, bp
		movsw
		add	di, bp
		movsw
		add	di, bp
		movsw
		add	di, bp
		movsw
		mov	di, bx
		pop	es
		assume es:nothing
		mov	al, 0C0h ; '¿'
		out	7Ch, al
		jmp	loc_1B3D4
; ---------------------------------------------------------------------------
		jmp	loc_1B3D4
; ---------------------------------------------------------------------------
		db 0B0h, 4, 0E6h, 6Ah, 8Bh, 0C5h, 86h, 0E0h, 0B4h
byte_1B2F0	db 0			; DATA XREF: sub_1B1D8:loc_1B224w
; ---------------------------------------------------------------------------
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		mov	bx, di
		mov	bp, 4Eh	; 'N'
		push	es
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		mov	ax, 0FFFFh
		stosw
		add	di, bp
		stosw
		add	di, bp
		stosw
		add	di, bp
		stosw
		add	di, bp
		stosw
		add	di, bp
		stosw
		add	di, bp
		stosw
		add	di, bp
		stosw
		pop	es
		assume es:nothing
		mov	di, bx
		mov	al, 5
		out	6Ah, al
		jmp	loc_1B3D4
; ---------------------------------------------------------------------------
		db 0B0h, 4, 0E6h, 6Ah, 8Bh, 0C5h, 86h, 0E0h, 0B4h
byte_1B340	db 0			; DATA XREF: sub_1B1D8+50w
; ---------------------------------------------------------------------------
		sub	ah, 10h
		ror	ah, 1
		sbb	al, al
		or	al, 55h
		out	7Eh, al
		ror	ah, 1
		sbb	al, al
		and	al, 0AAh
		out	7Eh, al
		ror	ah, 1
		sbb	al, al
		and	al, 0AAh
		out	7Eh, al
		ror	ah, 1
		sbb	al, al
		and	al, 0AAh
		out	7Eh, al
		mov	bx, di
		mov	bp, 4Eh	; 'N'
		push	es
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		mov	ax, 0FFFFh
		stosw
		add	di, bp
		stosw
		add	di, bp
		stosw
		add	di, bp
		stosw
		add	di, bp
		stosw
		add	di, bp
		stosw
		add	di, bp
		stosw
		add	di, bp
		stosw
		pop	es
		assume es:nothing
		mov	di, bx
		mov	al, 5
		out	6Ah, al
		jmp	short loc_1B3D4
; ---------------------------------------------------------------------------

loc_1B391:				; CODE XREF: sub_1B1D8+68j
		mov	si, bx
		mov	bx, di
		mov	bp, 4Eh	; 'N'
		push	es
		push	ds
		push	dx
		mov	ax, 0FFFFh
		mov	dx, 4A8h
		out	dx, ax
		pop	dx
		mov	ax, 0A800h
		mov	ds, ax
		assume ds:nothing
		mov	es, ax
		assume es:nothing
		movsw
		add	si, bp
		add	di, bp
		movsw
		add	si, bp
		add	di, bp
		movsw
		add	si, bp
		add	di, bp
		movsw
		add	si, bp
		add	di, bp
		movsw
		add	si, bp
		add	di, bp
		movsw
		add	si, bp
		add	di, bp
		movsw
		add	si, bp
		add	di, bp
		movsw
		mov	di, bx
		pop	ds
		assume ds:nothing
		pop	es
		assume es:nothing
		jmp	short $+2

loc_1B3D4:				; CODE XREF: sub_1B1D8+49j
					; sub_1B1D8+109j ...
		inc	di
		inc	di
		mov	si, dx
		loop	loc_1B3DC
		jmp	short loc_1B3DF
; ---------------------------------------------------------------------------

loc_1B3DC:				; CODE XREF: sub_1B1D8+200j
		jmp	loc_1B214
; ---------------------------------------------------------------------------

loc_1B3DF:				; CODE XREF: sub_1B1D8+202j
		add	di, 230h
		add	si, 50h	; 'P'
		pop	cx
		loop	loc_1B3EB
		jmp	short loc_1B3EE
; ---------------------------------------------------------------------------

loc_1B3EB:				; CODE XREF: sub_1B1D8+20Fj
		jmp	loc_1B210
; ---------------------------------------------------------------------------

loc_1B3EE:				; CODE XREF: sub_1B1D8+211j
		mov	al, 4
		out	6Ah, al
		mov	al, 6
		out	6Ah, al
		mov	al, 0
		out	7Ch, al
		retn
sub_1B1D8	endp

; ---------------------------------------------------------------------------
		db 0D4h, 0B3h, 5Eh, 0B2h, 0E4h,	0B2h, 0E7h, 0B2h, 37h
		db 0B3h
word_1B405	dw 0			; DATA XREF: sub_1AAC8+2FFw
					; sub_1AAC8+339w ...
		db 2 dup(0), 90h

; =============== S U B	R O U T	I N E =======================================


sub_1B40A	proc near		; CODE XREF: sub_1AAC8+306p
					; sub_1AAC8+340p
		mov	al, 80h	; 'Ä'
		out	7Ch, al
		mov	al, 7
		out	6Ah, al
		mov	al, 5
		out	6Ah, al
		mov	ax, 88h	; 'à'
		mov	dx, 4ACh
		out	dx, ax
		mov	ax, 0Fh
		mov	dx, 4AEh
		out	dx, ax
		mov	ax, 29F0h
		mov	dx, 4A4h
		out	dx, ax
		add	di, cs:word_1BE02
		add	di, cs:word_1BE02
		mov	ds, cs:gfxBufPtr_RDF
		mov	ax, seg	seg001
		mov	es, ax
		assume es:seg001
		mov	cx, 17h

loc_1B442:				; CODE XREF: sub_1B40A:loc_1B628j
		push	cx
		mov	cx, 28h	; '('

loc_1B446:				; CODE XREF: sub_1B40A:loc_1B619j
		mov	ax, es:[si]
		add	si, 2
		mov	dx, si
		test	ax, 0FC00h
		jnz	short loc_1B456
		jmp	loc_1B611
; ---------------------------------------------------------------------------

loc_1B456:				; CODE XREF: sub_1B40A+47j
		mov	byte ptr cs:loc_1B521+1, al
		mov	byte ptr cs:loc_1B571+1, al
		mov	bp, ax
		and	ax, 3FFh
		mov	bx, ax
		shl	bx, 1
		add	bx, 5586h
		mov	bx, es:[bx]
		or	bx, bx
		jz	short loc_1B475
		jmp	loc_1B5C3
; ---------------------------------------------------------------------------

loc_1B475:				; CODE XREF: sub_1B40A+66j
		sub	ax, 20h	; ' '
		shl	ax, 4
		mov	si, ax
		shl	ax, 2
		add	si, ax
		shr	bp, 9
		and	bp, 0FFFEh
		mov	bx, offset off_1B638
		add	bx, bp
		jmp	word ptr cs:[bx]
; ---------------------------------------------------------------------------

loc_1B490:				; DATA XREF: seg000:off_1B638o
		xor	al, al
		out	7Ch, al
		mov	bx, di
		mov	bp, 4Eh	; 'N'
		push	es
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		movsw
		add	di, bp
		movsw
		add	di, bp
		movsw
		add	di, bp
		movsw
		add	di, bp
		movsw
		add	di, bp
		movsw
		add	di, bp
		movsw
		add	di, bp
		movsw
		mov	di, bx
		mov	ax, 0B000h
		mov	es, ax
		assume es:nothing
		movsw
		add	di, bp
		movsw
		add	di, bp
		movsw
		add	di, bp
		movsw
		add	di, bp
		movsw
		add	di, bp
		movsw
		add	di, bp
		movsw
		add	di, bp
		movsw
		mov	di, bx
		mov	ax, 0B800h
		mov	es, ax
		assume es:nothing
		movsw
		add	di, bp
		movsw
		add	di, bp
		movsw
		add	di, bp
		movsw
		add	di, bp
		movsw
		add	di, bp
		movsw
		add	di, bp
		movsw
		add	di, bp
		movsw
		mov	di, bx
		mov	ax, 0E000h
		mov	es, ax
		assume es:nothing
		movsw
		add	di, bp
		movsw
		add	di, bp
		movsw
		add	di, bp
		movsw
		add	di, bp
		movsw
		add	di, bp
		movsw
		add	di, bp
		movsw
		add	di, bp
		movsw
		mov	di, bx
		pop	es
		assume es:nothing
		mov	al, 0C0h ; '¿'
		out	7Ch, al
		jmp	loc_1B611
; ---------------------------------------------------------------------------

loc_1B516:				; DATA XREF: seg000:off_1B638o
		jmp	loc_1B611
; ---------------------------------------------------------------------------

loc_1B519:				; DATA XREF: seg000:off_1B638o
		mov	al, 4
		out	6Ah, al
		mov	ax, bp
		xchg	ah, al

loc_1B521:				; DATA XREF: sub_1B40A:loc_1B456w
		mov	ah, 0
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		mov	bx, di
		mov	bp, 4Eh	; 'N'
		push	es
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		mov	ax, 0FFFFh
		stosw
		add	di, bp
		stosw
		add	di, bp
		stosw
		add	di, bp
		stosw
		add	di, bp
		stosw
		add	di, bp
		stosw
		add	di, bp
		stosw
		add	di, bp
		stosw
		pop	es
		assume es:nothing
		mov	di, bx
		mov	al, 5
		out	6Ah, al
		jmp	loc_1B611
; ---------------------------------------------------------------------------

loc_1B569:				; DATA XREF: seg000:off_1B638o
		mov	al, 4
		out	6Ah, al
		mov	ax, bp
		xchg	ah, al

loc_1B571:				; DATA XREF: sub_1B40A+50w
		mov	ah, 0
		sub	ah, 10h
		ror	ah, 1
		sbb	al, al
		or	al, 55h
		out	7Eh, al
		ror	ah, 1
		sbb	al, al
		and	al, 0AAh
		out	7Eh, al
		ror	ah, 1
		sbb	al, al
		and	al, 0AAh
		out	7Eh, al
		ror	ah, 1
		sbb	al, al
		and	al, 0AAh
		out	7Eh, al
		mov	bx, di
		mov	bp, 4Eh	; 'N'
		push	es
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		mov	ax, 0FFFFh
		stosw
		add	di, bp
		stosw
		add	di, bp
		stosw
		add	di, bp
		stosw
		add	di, bp
		stosw
		add	di, bp
		stosw
		add	di, bp
		stosw
		add	di, bp
		stosw
		pop	es
		assume es:nothing
		mov	di, bx
		mov	al, 5
		out	6Ah, al
		jmp	short loc_1B611
; ---------------------------------------------------------------------------

loc_1B5C3:				; CODE XREF: sub_1B40A+68j
		mov	si, bx
		mov	bx, di
		push	dx
		mov	ax, 0FFFFh
		mov	dx, 4A8h
		out	dx, ax
		pop	dx
		mov	bp, 4Ch	; 'L'
		push	es
		push	ds
		and	di, 0FFFEh
		mov	ax, 0A800h
		mov	ds, ax
		assume ds:nothing
		mov	es, ax
		assume es:nothing
		movsw
		movsw
		add	si, bp
		add	di, bp
		movsw
		movsw
		add	si, bp
		add	di, bp
		movsw
		movsw
		add	si, bp
		add	di, bp
		movsw
		movsw
		add	si, bp
		add	di, bp
		movsw
		movsw
		add	si, bp
		add	di, bp
		movsw
		movsw
		add	si, bp
		add	di, bp
		movsw
		movsw
		add	si, bp
		add	di, bp
		movsw
		movsw
		mov	di, bx
		pop	ds
		assume ds:nothing
		pop	es
		assume es:nothing
		jmp	short $+2

loc_1B611:				; CODE XREF: sub_1B40A+49j
					; sub_1B40A+109j ...
		inc	di
		inc	di
		mov	si, dx
		loop	loc_1B619
		jmp	short loc_1B61C
; ---------------------------------------------------------------------------

loc_1B619:				; CODE XREF: sub_1B40A+20Bj
		jmp	loc_1B446
; ---------------------------------------------------------------------------

loc_1B61C:				; CODE XREF: sub_1B40A+20Dj
		add	di, 230h
		add	si, 50h	; 'P'
		pop	cx
		loop	loc_1B628
		jmp	short loc_1B62B
; ---------------------------------------------------------------------------

loc_1B628:				; CODE XREF: sub_1B40A+21Aj
		jmp	loc_1B442
; ---------------------------------------------------------------------------

loc_1B62B:				; CODE XREF: sub_1B40A+21Cj
		mov	al, 4
		out	6Ah, al
		mov	al, 6
		out	6Ah, al
		mov	al, 0
		out	7Ch, al
		retn
sub_1B40A	endp

; ---------------------------------------------------------------------------
off_1B638	dw offset loc_1B611	; DATA XREF: sub_1B40A+7Eo
		dw offset loc_1B490
		dw offset loc_1B516
		dw offset loc_1B519
		dw offset loc_1B569

; =============== S U B	R O U T	I N E =======================================


nullsub_1	proc near		; CODE XREF: sub_1AAC8+2FBp
					; sub_1AAC8+335p ...
		retn
nullsub_1	endp

; ---------------------------------------------------------------------------
		cmp	cs:word_1BDE8, 0
		jz	short locret_1B695
		push	si
		push	di
		push	di
		push	es
		mov	ax, seg	seg001
		mov	es, ax
		assume es:seg001
		mov	cx, 320h
		sub	ax, ax
		mov	di, 5586h
		rep stosw
		pop	es
		assume es:nothing
		pop	di
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		add	di, cs:word_1BE02
		add	di, cs:word_1BE02
		mov	dx, 14h

loc_1B672:				; CODE XREF: seg000:B691j
		mov	cx, 26h	; '&'

loc_1B675:				; CODE XREF: seg000:B687j
		lodsw
		test	ax, 0FC00h
		jnz	short loc_1B685
		mov	bx, ax
		shl	bx, 1
		add	bx, 5586h
		mov	[bx], di

loc_1B685:				; CODE XREF: seg000:B679j
		inc	di
		inc	di
		loop	loc_1B675
		add	di, 234h
		add	si, 54h	; 'T'
		dec	dx
		jnz	short loc_1B672
		pop	di
		pop	si

locret_1B695:				; CODE XREF: seg000:B649j
		retn

; =============== S U B	R O U T	I N E =======================================


sub_1B696	proc near		; CODE XREF: sub_1AAC8+BCp
					; sub_1AAC8+E6p ...
		mov	ax, cs:MapPosX
		and	ax, 0Fh
		mov	cs:word_1B86D, ax
		add	di, 14h
		cmp	cs:word_1BDF2, 0
		jnz	short loc_1B6AF
		jmp	loc_1B767
; ---------------------------------------------------------------------------

loc_1B6AF:				; CODE XREF: sub_1B696+14j
		mov	ax, seg	seg001
		mov	ds, ax
		mov	es, ax
		assume es:seg001
		mov	bx, cs:off_1BDF4
		add	bx, 1C20h
		mov	ax, cs:word_1BE0C
		cmp	[bx], ax
		jnz	short loc_1B6CA
		jmp	loc_1B767
; ---------------------------------------------------------------------------

loc_1B6CA:				; CODE XREF: sub_1B696+2Fj
		sub	ax, [bx]
		test	ax, 8000h
		jnz	short loc_1B71A
		cmp	ax, 28h	; '('
		jb	short loc_1B6E2
		call	sub_1B9FE
		mov	ax, cs:word_1BE0C
		mov	[bx], ax
		jmp	loc_1B767
; ---------------------------------------------------------------------------

loc_1B6E2:				; CODE XREF: sub_1B696+3Ej
		mov	dx, ax
		shl	ax, 1
		push	si
		push	di
		add	di, 14h
		mov	si, di
		add	si, ax
		mov	cx, 19h

loc_1B6F2:				; CODE XREF: sub_1B696+78j
		push	cx
		mov	cx, 28h	; '('
		sub	cx, dx
		rep movsw
		mov	cx, dx
		mov	ax, dx
		shl	ax, 1
		add	si, ax
		mov	ax, 0FFFFh
		rep stosw
		pop	cx
		add	si, 50h	; 'P'
		add	di, 50h	; 'P'
		loop	loc_1B6F2
		mov	ax, cs:word_1BE0C
		mov	[bx], ax
		pop	di
		pop	si
		jmp	short loc_1B767
; ---------------------------------------------------------------------------

loc_1B71A:				; CODE XREF: sub_1B696+39j
		neg	ax
		cmp	ax, 28h	; '('
		jb	short loc_1B72C
		call	sub_1B9FE
		mov	ax, cs:word_1BE0C
		mov	[bx], ax
		jmp	short loc_1B767
; ---------------------------------------------------------------------------

loc_1B72C:				; CODE XREF: sub_1B696+89j
		mov	dx, ax
		shl	ax, 1
		push	si
		push	di
		add	di, 1002h
		mov	si, di
		sub	si, ax
		mov	cx, 19h
		std

loc_1B73E:				; CODE XREF: sub_1B696+C4j
		push	cx
		mov	cx, 28h	; '('
		sub	cx, dx
		rep movsw
		mov	cx, dx
		mov	ax, dx
		shl	ax, 1
		sub	si, ax
		mov	ax, 0FFFFh
		rep stosw
		pop	cx
		sub	si, 50h	; 'P'
		sub	di, 50h	; 'P'
		loop	loc_1B73E
		cld
		mov	ax, cs:word_1BE0C
		mov	[bx], ax
		pop	di
		pop	si
		jmp	short $+2

loc_1B767:				; CODE XREF: sub_1B696+16j
					; sub_1B696+31j ...
		mov	ax, cs:word_1BE0C
		sub	ax, 0Ah
		mov	cs:word_1B867, ax
		mov	ds, cs:gfxBufPtr_SDF
		assume ds:nothing
		mov	bx, cs:word_1BDF6
		shl	bx, 1
		mov	ax, cs:word_1BE10
		mul	bx
		mov	cx, cs:word_1BE0C
		shl	cx, 1
		add	ax, cx
		mov	si, ax
		sub	si, 14h
		mov	ax, seg	seg001
		mov	es, ax
		mov	cx, 19h
		mov	cs:word_1B86B, 0

loc_1B7A1:				; CODE XREF: sub_1B696:loc_1B861j
		mov	bx, si
		push	cx
		mov	cx, 3Ch	; '<'
		mov	cs:word_1B869, 0FF60h
		mov	ax, cs:word_1B867
		mov	cs:word_1B865, ax

loc_1B7B6:				; CODE XREF: sub_1B696:loc_1B846j
		lodsw
		test	ax, 0FC00h
		jz	short loc_1B811
		push	ax
		mov	ax, cs:word_1BDF6
		cmp	cs:word_1B865, ax
		pop	ax
		jnb	short loc_1B811
		mov	dx, ax
		push	cx
		push	dx
		mov	cx, cs:word_1B869
		mov	dx, cs:word_1B86B
		push	cx
		push	dx
		sar	cx, 4
		sar	dx, 3
		add	cx, cs:word_1BE0C
		add	dx, cs:word_1BE10
		or	cx, dx
		test	ch, 80h
		jnz	short loc_1B80B
		pop	dx
		pop	cx
		sub	dx, cs:SomeYPosOffset
		sub	cx, cs:word_1B86D
		add	cx, 10h
		shr	ax, 0Ah
		call	sub_10EEA
		pop	dx
		pop	cx
		mov	ax, dx
		jmp	short loc_1B811
; ---------------------------------------------------------------------------

loc_1B80B:				; CODE XREF: sub_1B696+158j
		pop	dx
		pop	cx
		pop	dx
		pop	cx
		mov	ax, dx

loc_1B811:				; CODE XREF: sub_1B696+124j
					; sub_1B696+131j ...
		and	ax, 3FFh
		mov	dx, es:[di]
		and	dx, 3FFh
		cmp	ax, dx
		jz	short loc_1B836
		mov	dl, 4
		cmp	ax, 10h
		jnb	short loc_1B82A
		mov	dl, 0Ch
		jmp	short loc_1B831
; ---------------------------------------------------------------------------

loc_1B82A:				; CODE XREF: sub_1B696+18Ej
		cmp	ax, 20h	; ' '
		jnb	short loc_1B831
		mov	dl, 10h

loc_1B831:				; CODE XREF: sub_1B696+192j
					; sub_1B696+197j
		or	ah, dl
		stosw
		jmp	short loc_1B837
; ---------------------------------------------------------------------------

loc_1B836:				; CODE XREF: sub_1B696+187j
		stosw

loc_1B837:				; CODE XREF: sub_1B696+19Ej
		add	cs:word_1B869, 10h
		inc	cs:word_1B865
		loop	loc_1B846
		jmp	short loc_1B849
; ---------------------------------------------------------------------------

loc_1B846:				; CODE XREF: sub_1B696+1ACj
		jmp	loc_1B7B6
; ---------------------------------------------------------------------------

loc_1B849:				; CODE XREF: sub_1B696+1AEj
		add	cs:word_1B86B, 8
		mov	si, bx
		mov	ax, cs:word_1BDF6
		add	si, ax
		add	si, ax
		add	di, 28h	; '('
		pop	cx
		loop	loc_1B861
		jmp	short locret_1B864
; ---------------------------------------------------------------------------

loc_1B861:				; CODE XREF: sub_1B696+1C7j
		jmp	loc_1B7A1
; ---------------------------------------------------------------------------

locret_1B864:				; CODE XREF: sub_1B696+1C9j
		retn
sub_1B696	endp

; ---------------------------------------------------------------------------
word_1B865	dw 0			; DATA XREF: sub_1B696+11Cw
					; sub_1B696+12Br ...
word_1B867	dw 0			; DATA XREF: sub_1B696+D8w
					; sub_1B696+118r
word_1B869	dw 0			; DATA XREF: sub_1B696+111w
					; sub_1B696+137r ...
word_1B86B	dw 0			; DATA XREF: sub_1B696+104w
					; sub_1B696+13Cr ...
word_1B86D	dw 0			; DATA XREF: sub_1B696+7w
					; sub_1B696+161r
		db 2 dup(0)

; =============== S U B	R O U T	I N E =======================================


AddSprite	proc near		; CODE XREF: sub_1990B+3Bp
					; AddHDFSpr_Mode0+2Fp ...
		cmp	cs:SpriteCount,	200
		jz	short locret_1B8B8
		push	ax
		push	dx
		push	bx
		mov	ax, seg	seg001
		mov	es, ax
		mov	bp, offset SpriteObjs
		mov	ax, cs:SpriteCount
		mov	bx, 0Ch
		mul	bx
		add	bp, ax
		pop	bx
		pop	dx
		pop	ax
		mov	es:[bp+2], ah
		mov	es:[bp+3], bl	; store	render mode
		mov	word ptr es:[bp+4], ds ; store sprite data segment
		mov	es:[bp+6], si	; store	sprite data pointer
		mov	es:[bp+8], cx	; store	X position
		mov	es:[bp+0Ah], dx	; store	Y position
		mov	ax, cs:word_1B8B9
		mov	es:[bp+0], ax	; store	layer
		inc	cs:SpriteCount

locret_1B8B8:				; CODE XREF: AddSprite+7j
		retn
AddSprite	endp

; ---------------------------------------------------------------------------
word_1B8B9	dw 0			; DATA XREF: sub_10F09+5Cw
					; sub_1260A+6BDw ...

; =============== S U B	R O U T	I N E =======================================


DrawAllSprites	proc near		; CODE XREF: sub_10F09+69p
					; PrintCmfTxt4F+17Ep ...
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		mov	es, ax
		mov	cx, cs:SpriteCount
		cmp	cx, 0
		jz	short locret_1B8EA
		mov	bx, 0
		call	DrawSpriteLayer
		mov	bx, 1
		call	DrawSpriteLayer
		mov	bx, 2
		call	DrawSpriteLayer
		mov	bx, 3
		call	DrawSpriteLayer
		mov	bx, 4
		call	DrawSpriteLayer

locret_1B8EA:				; CODE XREF: DrawAllSprites+Fj
		retn
DrawAllSprites	endp


; =============== S U B	R O U T	I N E =======================================


DrawSpriteLayer	proc near		; CODE XREF: DrawAllSprites+14p
					; DrawAllSprites+1Ap ...
		mov	bp, offset SpriteObjs
		mov	cx, cs:SpriteCount

loc_1B8F3:				; CODE XREF: DrawSpriteLayer+26j
		cmp	ds:[bp+0], bx
		jnz	short loc_1B90E	; draw only sprites with matching layer	ID
		push	cx
		push	bx
		push	bp
		push	ds
		sub	bx, bx
		mov	bl, ds:[bp+3]	; get sprite draw mode
		shl	bx, 1
		call	cs:sprDrawJumpTbl[bx]
		pop	ds
		assume ds:nothing
		pop	bp
		pop	bx
		pop	cx

loc_1B90E:				; CODE XREF: DrawSpriteLayer+Cj
		add	bp, 0Ch
		loop	loc_1B8F3
		retn
DrawSpriteLayer	endp

; ---------------------------------------------------------------------------
sprDrawJumpTbl	dw offset sprDraw0	; 0 ; DATA XREF: DrawSpriteLayer+1Ar
		dw offset sprDraw1	; 1
		dw offset sprDraw2	; 2
		dw offset sprDraw3	; 3
		dw offset sprDraw4	; 4

; =============== S U B	R O U T	I N E =======================================


sprDraw0	proc near		; CODE XREF: DrawSpriteLayer+1Ap
					; sprDraw1+6j
					; DATA XREF: ...
		mov	cx, ds:[bp+8]	; X position
		mov	dx, ds:[bp+0Ah]	; Y position
		mov	si, ds:[bp+6]	; get data pointer
		mov	bx, ds:[bp+4]	; get data segment
		mov	ds, bx
		call	SpriteDraw0A
		retn
sprDraw0	endp


; =============== S U B	R O U T	I N E =======================================


sprDraw1	proc near		; DATA XREF: seg000:sprDrawJumpTblo
		cmp	cs:word_1BDF0, 0
		jnz	short sprDraw0
		mov	cx, ds:[bp+8]
		mov	dx, ds:[bp+0Ah]
		mov	si, ds:[bp+6]
		mov	bx, ds:[bp+4]
		mov	ds, bx
		call	SpriteDraw1A
		retn
sprDraw1	endp


; =============== S U B	R O U T	I N E =======================================


sprDraw2	proc near		; CODE XREF: sprDraw3+6j
					; DATA XREF: seg000:sprDrawJumpTblo
		mov	cx, ds:[bp+8]
		mov	dx, ds:[bp+0Ah]
		mov	si, ds:[bp+6]
		mov	bx, ds:[bp+4]
		mov	ah, ds:[bp+2]
		mov	ds, bx
		call	SpriteDraw0B
		retn
sprDraw2	endp


; =============== S U B	R O U T	I N E =======================================


sprDraw3	proc near		; DATA XREF: seg000:sprDrawJumpTblo
		cmp	cs:word_1BDF0, 0
		jnz	short sprDraw2
		mov	cx, ds:[bp+8]
		mov	dx, ds:[bp+0Ah]
		mov	si, ds:[bp+6]
		mov	bx, ds:[bp+4]
		mov	ah, ds:[bp+2]
		mov	ds, bx
		call	SpriteDraw1B
		retn
sprDraw3	endp


; =============== S U B	R O U T	I N E =======================================


sprDraw4	proc near		; DATA XREF: seg000:sprDrawJumpTblo
		mov	cx, ds:[bp+8]
		mov	dx, ds:[bp+0Ah]
		mov	ah, ds:[bp+2]
		push	cx
		push	dx
		push	di
		push	es
		add	dx, cs:word_1BE06
		mov	al, 0C0h
		out	7Ch, al
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		xchg	cx, dx
		xor	ax, ax
		mov	di, 8
		xchg	ax, dx
		div	di
		mov	di, cx
		shl	di, 2
		add	di, cx
		shl	di, 4
		add	di, ax
		add	di, cs:word_1BE02
		add	di, cs:word_1BE02
		mov	cl, dl
		mov	al, 0C0h
		shr	al, cl
		stosb
		xor	al, al
		out	7Ch, al
		pop	es
		assume es:nothing
		pop	di
		pop	dx
		pop	cx
		retn
sprDraw4	endp


; =============== S U B	R O U T	I N E =======================================


ResetSprites	proc near		; CODE XREF: sub_10F09+34p
		mov	cs:SpriteCount,	0
		retn
ResetSprites	endp

; ---------------------------------------------------------------------------
SpriteCount	dw 0			; DATA XREF: DrawDebugInfo+1A6r
					; AddSpriter ...

; =============== S U B	R O U T	I N E =======================================


sub_1B9FE	proc near		; CODE XREF: sub_1AAC8+1DCp
					; sub_1AAC8+1FBp ...
		cld
		push	es
		push	ds
		pusha
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		mov	es, ax
		assume es:seg001
		mov	di, cs:off_1BDF4
		mov	cx, 0E10h
		mov	ax, 0FFFFh
		rep stosw
		popa
		pop	ds
		assume ds:nothing
		pop	es
		assume es:nothing
		retn
sub_1B9FE	endp


; =============== S U B	R O U T	I N E =======================================


sub_1BA1A	proc near		; CODE XREF: start+FDp
					; PrintCmfTxt4F:loc_11818p ...
		cld
		push	es
		push	ds
		pusha
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		mov	es, ax
		assume es:seg001
		mov	di, offset word_25C1A
		mov	cs:off_1BDF4, di
		mov	cx, 0E10h
		mov	ax, 0FFFFh
		rep stosw
		mov	di, offset word_2783E
		mov	cx, 0E10h
		mov	ax, 0FFFFh
		rep stosw
		mov	di, offset word_29462
		mov	cx, 0E10h
		mov	ax, 0FFFFh
		rep stosw
		mov	di, offset word_2B086
		mov	cx, 0E10h
		mov	ax, 0FFFFh
		rep stosw
		mov	ax, cs:MapPosX
		shr	ax, 4
		mov	di, offset word_2783A
		stosw
		stosw
		mov	di, offset word_2945E
		stosw
		stosw
		mov	di, offset word_2B082
		stosw
		stosw
		mov	di, offset word_2CCA6
		stosw
		stosw
		popa
		pop	ds
		assume ds:nothing
		pop	es
		assume es:nothing
		clc
		retn
sub_1BA1A	endp


; =============== S U B	R O U T	I N E =======================================


sub_1BA76	proc near		; CODE XREF: start+F3p
		push	es
		push	ds
		pusha
		mov	bx, 0FFFFh
		shr	bx, 4
		inc	bx
		mov	ah, 48h
		int	21h		; DOS -	2+ - ALLOCATE MEMORY
					; BX = number of 16-byte paragraphs desired
		jb	short loc_1BA9B
		mov	cs:gfxBufPtr_SDF, ax
		mov	es, ax
		sub	di, di
		cld
		mov	cx, 7FFFh
		sub	ax, ax
		rep stosw
		clc
		popa
		pop	ds
		pop	es
		retn
; ---------------------------------------------------------------------------

loc_1BA9B:				; CODE XREF: sub_1BA76+Ej
		stc
		retn
sub_1BA76	endp ; sp-analysis failed


; =============== S U B	R O U T	I N E =======================================


sub_1BA9D	proc near		; CODE XREF: start+EEp
		push	es
		push	ds
		pusha
		mov	bx, 0FFFFh
		shr	bx, 4
		inc	bx
		mov	ah, 48h
		int	21h		; DOS -	2+ - ALLOCATE MEMORY
					; BX = number of 16-byte paragraphs desired
		jb	short loc_1BAC1
		mov	cs:gfxBufPtr_RDF, ax
		mov	es, ax
		cld
		mov	cx, 7FFFh
		mov	ax, 0FFFFh
		rep stosw
		clc
		popa
		pop	ds
		pop	es
		retn
; ---------------------------------------------------------------------------

loc_1BAC1:				; CODE XREF: sub_1BA9D+Ej
		stc
		popa
		pop	ds
		pop	es
		retn
sub_1BA9D	endp


; =============== S U B	R O U T	I N E =======================================


sub_1BAC6	proc near		; CODE XREF: start+F8p
		push	es
		push	ds
		pusha
		mov	bx, 2000h
		shr	bx, 4
		inc	bx
		mov	ah, 48h
		int	21h		; DOS -	2+ - ALLOCATE MEMORY
					; BX = number of 16-byte paragraphs desired
		jb	short loc_1BAEA
		mov	cs:gfxBufPtr_TDF, ax
		mov	es, ax
		cld
		mov	cx, 0FFFh
		mov	ax, 0
		rep stosw
		clc
		popa
		pop	ds
		pop	es
		retn
; ---------------------------------------------------------------------------

loc_1BAEA:				; CODE XREF: sub_1BAC6+Ej
		stc
		popa
		pop	ds
		pop	es
		retn
sub_1BAC6	endp

		assume ds:seg001

; =============== S U B	R O U T	I N E =======================================


sub_1BAEF	proc near		; CODE XREF: cmfA12_LoadRDF+Cp
		push	es
		push	ds
		pusha
		cmp	cs:word_1BDEE, 0
		jz	short loc_1BB72
		call	SetIO_A6_00
		mov	cx, 2

loc_1BB00:				; CODE XREF: sub_1BAEF+67j
		push	cx
		mov	cs:word_1BB7C, 0
		mov	di, offset word_25C1A
		mov	cs:off_1BDF4, di
		add	di, 708h
		cld
		mov	ax, seg	seg001
		mov	es, ax
		assume es:seg001
		mov	cx, 19h

loc_1BB1D:				; CODE XREF: sub_1BAEF+58j
		push	cx
		mov	cx, 28h	; '('

loc_1BB21:				; CODE XREF: sub_1BAEF+52j
		mov	ax, cs:word_1BB7C
		mov	dl, 4
		cmp	ax, 10h
		jnb	short loc_1BB30
		mov	dl, 0Ch
		jmp	short loc_1BB37
; ---------------------------------------------------------------------------

loc_1BB30:				; CODE XREF: sub_1BAEF+3Bj
		cmp	ax, 20h	; ' '
		jnb	short loc_1BB37
		mov	dl, 10h

loc_1BB37:				; CODE XREF: sub_1BAEF+3Fj
					; sub_1BAEF+44j
		or	ah, dl
		or	ah, dl
		stosw
		inc	cs:word_1BB7C
		loop	loc_1BB21
		add	di, 50h	; 'P'
		pop	cx
		loop	loc_1BB1D
		mov	si, (offset word_25C1A+708h)
		mov	di, 3ED0h
		call	sub_1AE88
		call	sub_1E92E
		pop	cx
		loop	loc_1BB00
		call	SetIO_A6_00
		mov	ax, seg	seg001
		mov	ds, ax
		mov	es, ax
		mov	di, offset word_25C1A
		mov	cs:off_1BDF4, di
		mov	cx, 0E10h
		mov	ax, 0FFFFh
		rep stosw

loc_1BB72:				; CODE XREF: sub_1BAEF+9j
		clc
		popa
		pop	ds
		assume ds:nothing
		pop	es
		assume es:nothing
		retn
sub_1BAEF	endp

; ---------------------------------------------------------------------------
		stc
		popa
		pop	ds
		pop	es
		retn
; ---------------------------------------------------------------------------
word_1BB7C	dw 0			; DATA XREF: sub_1BAEF+12w
					; sub_1BAEF:loc_1BB21r	...

; =============== S U B	R O U T	I N E =======================================


sub_1BB7E	proc near		; CODE XREF: cmfA18+3p
		push	es
		push	ds
		pusha
		cmp	ax, 0
		jz	short loc_1BB98
		cmp	ax, 1
		jz	short loc_1BBC5
		cmp	ax, 2
		jz	short loc_1BBF1
		cmp	ax, 3
		jnz	short loc_1BB98
		jmp	loc_1BC1D
; ---------------------------------------------------------------------------

loc_1BB98:				; CODE XREF: sub_1BB7E+6j
					; sub_1BB7E+15j
		mov	cs:word_1BDF6, 640
		mov	cs:word_1BDF8, 1
		mov	cs:word_1BDFA, 640
		mov	cs:word_1BDFC, 50
		mov	cs:word_1BDFE, 1
		mov	cs:word_1BE00, 50
		jmp	loc_1BC49
; ---------------------------------------------------------------------------

loc_1BBC5:				; CODE XREF: sub_1BB7E+Bj
		mov	cs:word_1BDF6, 320
		mov	cs:word_1BDF8, 1
		mov	cs:word_1BDFA, 320
		mov	cs:word_1BDFC, 100
		mov	cs:word_1BDFE, 1
		mov	cs:word_1BE00, 100
		jmp	short loc_1BC49
; ---------------------------------------------------------------------------

loc_1BBF1:				; CODE XREF: sub_1BB7E+10j
		mov	cs:word_1BDF6, 160
		mov	cs:word_1BDF8, 1
		mov	cs:word_1BDFA, 160
		mov	cs:word_1BDFC, 200
		mov	cs:word_1BDFE, 1
		mov	cs:word_1BE00, 200
		jmp	short loc_1BC49
; ---------------------------------------------------------------------------

loc_1BC1D:				; CODE XREF: sub_1BB7E+17j
		mov	cs:word_1BDF6, 80
		mov	cs:word_1BDF8, 1
		mov	cs:word_1BDFA, 80
		mov	cs:word_1BDFC, 400
		mov	cs:word_1BDFE, 1
		mov	cs:word_1BE00, 400
		jmp	short $+2

loc_1BC49:				; CODE XREF: sub_1BB7E+44j
					; sub_1BB7E+71j ...
		pop	ds
		pop	es
		popa
		clc
		retn
sub_1BB7E	endp


; =============== S U B	R O U T	I N E =======================================


sub_1BC4E	proc near		; CODE XREF: start:loc_100E3p
		mov	ax, cs:word_1BDE4
		or	ax, ax
		jnz	short loc_1BC59
		call	sub_1BD6B

loc_1BC59:				; CODE XREF: sub_1BC4E+6j
		mov	cs:ShowDebugTrigger, 0
		mov	ax, cs:word_1BDE4
		cmp	ax, 3
		jnb	short loc_1BC70
		mov	cs:ShowDebugTrigger, 1

loc_1BC70:				; CODE XREF: sub_1BC4E+19j
		sub	ax, ax
		mov	es, ax
		assume es:nothing
		test	byte ptr es:54Dh, 40h
		jnz	short loc_1BC7F
		jmp	loc_1BD0D
; ---------------------------------------------------------------------------

loc_1BC7F:				; CODE XREF: sub_1BC4E+2Cj
		mov	cs:word_1BDE8, 1
		mov	dx, 0EE8Eh
		mov	al, 0
		out	dx, al
		mov	al, 7
		out	6Ah, al
		mov	al, 5
		out	6Ah, al
		mov	ax, 0FFF0h
		mov	dx, 4A0h
		out	dx, ax
		mov	ax, 0FFh
		mov	dx, 4A2h
		out	dx, ax
		mov	ax, 8F0h
		mov	dx, 4A4h
		out	dx, ax
		mov	ax, 0
		mov	dx, 4A6h
		out	dx, ax
		mov	ax, 0FFFFh
		mov	dx, 4A8h
		out	dx, ax
		mov	ax, 0
		mov	dx, 4AAh
		out	dx, ax
		mov	ax, 0
		mov	dx, 4ACh
		out	dx, ax
		mov	ax, 27Fh
		mov	dx, 4AEh
		out	dx, ax
		mov	al, 4
		out	6Ah, al
		mov	al, 6
		out	6Ah, al
		mov	al, 0
		out	7Ch, al

loc_1BCD8:				; CODE XREF: sub_1BC4E+C6j
		mov	ax, cs:word_1BDE4
		cmp	al, 5
		jz	short loc_1BCF7
		mov	cs:word_1BDF0, 0
		mov	cs:word_1BDEE, 0
		mov	cs:word_1BDF2, 1
		jmp	short locret_1BD0C
; ---------------------------------------------------------------------------

loc_1BCF7:				; CODE XREF: sub_1BC4E+90j
		mov	cs:word_1BDF0, 1
		mov	cs:word_1BDEE, 1
		mov	cs:word_1BDF2, 0

locret_1BD0C:				; CODE XREF: sub_1BC4E+A7j
		retn
; ---------------------------------------------------------------------------

loc_1BD0D:				; CODE XREF: sub_1BC4E+2Ej
		mov	cs:word_1BDE8, 0
		jmp	short loc_1BCD8
sub_1BC4E	endp

; ---------------------------------------------------------------------------
aVVGGvguvVEgcvk	db 'Ç±ÇÃÉ}ÉVÉìÇ…ÇÕEGCÇ™ìãç⁄Ç≥ÇÍÇƒÇ¢Ç‹Ç∑.',0Dh,0Ah,'$'
aVVGGvguvVEgcvU	db 'Ç±ÇÃÉ}ÉVÉìÇ…ÇÕEGCÇÕìãç⁄Ç≥ÇÍÇƒÇ¢Ç‹ÇπÇ'
		db 0F1h
aT_t_		db '(T_T).',0Dh,0Ah,'$'

; =============== S U B	R O U T	I N E =======================================


sub_1BD6B	proc near		; CODE XREF: start+41p	sub_1BC4E+8p
		push	bp
		push	si
		push	cx
		push	bx
		sub	si, si
		mov	ax, 2
		mov	cl, 21h	; '!'
		shr	ax, cl
		test	ax, 1
		jnz	short loc_1BD8B
		mov	al, 2
		push	cs
		movaps	xmm0, xmm0
		test	al, al
		jz	short loc_1BDD9
		pop	ax
		inc	si
		jmp	short loc_1BDD9
; ---------------------------------------------------------------------------

loc_1BD8B:				; CODE XREF: sub_1BD6B+10j
		add	si, 2
		push	sp
		pop	ax
		cmp	ax, sp
		jnz	short loc_1BDD9
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
		jz	short loc_1BDD9
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
		jz	short loc_1BDCF
		inc	si

loc_1BDCF:				; CODE XREF: sub_1BD6B+61j
		smsw	ax
		and	ax, 1
		xchg	ah, al
		or	si, ax

loc_1BDD9:				; CODE XREF: sub_1BD6B+1Aj
					; sub_1BD6B+1Ej ...
		mov	ax, si
		pop	bx
		pop	cx
		pop	si
		pop	bp
		mov	cs:word_1BDE4, ax
		retn
sub_1BD6B	endp ; sp-analysis failed

; ---------------------------------------------------------------------------
word_1BDE4	dw 0			; DATA XREF: sub_1204Cr sub_1BC4Er ...
word_1BDE6	dw 0			; DATA XREF: LoadCockpit+CCw
					; sub_1EFB9+C6w
word_1BDE8	dw 0			; DATA XREF: DetectFMChip+6Bw
					; DetectFMChip+74w ...
ShowDebugTrigger dw 0			; DATA XREF: DrawDebugInfor
					; sub_1BC4E:loc_1BC59w	...
ShowDebugState	dw 0			; DATA XREF: sub_1990Br
					; AddHDFSpr_Mode0+1r ...
word_1BDEE	dw 1			; DATA XREF: DetectFMChip+9Ew
					; DetectFMChip+B5w ...
word_1BDF0	dw 1			; DATA XREF: DetectFMChip:loc_1033Dw
					; DetectFMChip:loc_10354w ...
word_1BDF2	dw 0			; DATA XREF: DetectFMChip+A5w
					; DetectFMChip+BCw ...
off_1BDF4	dw offset word_25C1A	; DATA XREF: cmfB_GFXThing+66r
					; sub_1AAC8+B3w ...
word_1BDF6	dw 640			; DATA XREF: sub_14167+70r
					; sub_14167+14Er ...
word_1BDF8	dw 0			; DATA XREF: sub_14167+16r
					; sub_14167+33r ...
word_1BDFA	dw 640			; DATA XREF: sub_14167+5Dr
					; sub_14167:loc_142A4r	...
word_1BDFC	dw 50			; DATA XREF: sub_14167+CFr
					; sub_1BB7E+2Fw ...
word_1BDFE	dw 0			; DATA XREF: sub_14167+91r
					; sub_16D9F+6w	...
word_1BE00	dw 50			; DATA XREF: sub_14167:loc_14226r
					; sub_16D9F+10w ...
word_1BE02	dw 0			; DATA XREF: sub_1A3F2+2Dr
					; sub_1A3F2+32r ...
word_1BE04	dw 0			; DATA XREF: SpriteDraw0A+Cr
					; SpriteDraw1A+9r ...
word_1BE06	dw 0			; DATA XREF: SpriteDraw0A+D5r
					; SpriteDraw1A+D5r ...
word_1BE08	dw 0			; DATA XREF: sub_19C48+111r
					; seg000:A2F2r	...
word_1BE0A	dw 0			; DATA XREF: cmfB_GFXThing+1r
					; DrawDebugInfo+2ADr ...
word_1BE0C	dw 0			; DATA XREF: sub_10F09:loc_110C8r
					; sub_14167+1Br ...
		align 4
word_1BE10	dw 0			; DATA XREF: sub_10F09+1DBr
					; sub_14167+96r ...
		align 4
MapPosX		dw 0			; DATA XREF: sub_10F09+7Ar
					; sub_10F09+93w ...
MapPosY		dw 0			; DATA XREF: sub_10F09+C0r
					; sub_10F09+CFw ...
word_1BE18	dw 0			; DATA XREF: SpriteDraw0A+11w
					; SpriteDraw0A+58r ...
word_1BE1A	dw 0			; DATA XREF: SpriteDraw0A+16w
					; SpriteDraw1A+16w ...
word_1BE1C	dw 0			; DATA XREF: SpriteDraw0A+1Bw
					; SpriteDraw1A+1Bw ...
word_1BE1E	dw 0			; DATA XREF: SpriteDraw0A+20w
					; SpriteDraw1A+20w ...
word_1BE20	dw 0			; DATA XREF: SpriteDraw0A+5Fw
					; SpriteDraw0A+92w ...
word_1BE22	dw 0			; DATA XREF: SpriteDraw0A+66w
					; SpriteDraw0A+AEw ...
word_1BE24	dw 0			; DATA XREF: SpriteDraw0A+6Dw
					; SpriteDraw0A+C1w ...
word_1BE26	dw 0			; DATA XREF: sub_19C48+E2w
word_1BE28	dw 0			; DATA XREF: sub_19C48+D8w
					; sub_19C48+124r ...
word_1BE2A	dw 0			; DATA XREF: sub_19C48+75w
					; sub_19C48+94w ...
word_1BE2C	dw 0			; DATA XREF: SpriteDraw0A+78r
					; SpriteDraw0A+7Fr ...
word_1BE2E	dw 27Fh			; DATA XREF: SpriteDraw0A:loc_19AFFr
					; SpriteDraw0A+8Dr ...
word_1BE30	dw 174h			; DATA XREF: cmfA17+1w	sub_1406C+17r ...
gfxBufPtr_SDF	dw 0			; DATA XREF: cmfA11_LoadSDF+2r
					; sub_1811C+32r ...
gfxBufPtr_RDF	dw 0			; DATA XREF: cmfA12_LoadRDF+2r
					; sub_1AE88+Ar	...
word_1BE36	dw 0			; DATA XREF: AddSpr_ASCIIChr+9r
gfxBufPtr_TDF	dw 0			; DATA XREF: cmfA13_LoadTDF+2r
					; sub_1A65E+45r ...

; =============== S U B	R O U T	I N E =======================================


sub_1BE3A	proc near		; CODE XREF: sub_13192+151p
					; seg000:52EFp	...
		push	bp
		push	es
		push	ds
		add	si, 20h	; ' '
		add	di, 10h
		xchg	cx, si
		xchg	dx, di
		sub	cx, si
		sub	dx, di
		shl	dx, 1
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		mov	es, ax
		assume es:seg001
		call	sub_1BFF1
		mov	bx, ax
		mov	al, [bx-2AE6h]
		cbw
		mov	cx, ax
		mov	al, [bx-2B40h]
		cbw
		mov	dx, ax
		shl	cx, 1
		pop	ds
		assume ds:nothing
		pop	es
		assume es:nothing
		pop	bp
		retn
sub_1BE3A	endp


; =============== S U B	R O U T	I N E =======================================


sub_1BE6D	proc near		; CODE XREF: seg000:568Fp seg000:5FE3p ...
		push	bp
		push	ds
		push	ax
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		pop	ax
		cmp	ax, 168h
		jb	short loc_1BE7E
		sub	ax, 168h

loc_1BE7E:				; CODE XREF: sub_1BE6D+Cj
		mov	bx, ax
		mov	al, [bx-2AE6h]
		cbw
		mov	cx, ax
		mov	al, [bx-2B40h]
		cbw
		mov	dx, ax
		shl	cx, 1
		pop	ds
		assume ds:nothing
		pop	bp
		retn
sub_1BE6D	endp


; =============== S U B	R O U T	I N E =======================================


sub_1BE93	proc near		; CODE XREF: sub_13192+F2p
					; sub_13B22+4Bp ...
		push	bp
		push	ds
		push	ax
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		pop	ax
		and	ax, 0FFh
		mov	bx, ax
		shl	bx, 1
		mov	cx, word_2CD2A[bx]
		mov	dx, word_2CCAA[bx]
		shl	cx, 1
		pop	ds
		assume ds:nothing
		pop	bp
		retn
sub_1BE93	endp


; =============== S U B	R O U T	I N E =======================================


sub_1BEB0	proc near		; CODE XREF: sub_176C1+183p
		push	bp
		push	es
		push	ds
		xchg	dx, di
		sub	cx, si
		sub	dx, di
		shl	dx, 1
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		mov	es, ax
		assume es:seg001
		call	sub_1BF8C
		mov	cx, ax
		shr	ax, 4
		and	ax, 0Fh
		shl	ax, 1
		mov	bx, ax
		mov	ax, cs:word_1BEDA[bx]
		pop	ds
		assume ds:nothing
		pop	es
		assume es:nothing
		pop	bp
		retn
sub_1BEB0	endp

; ---------------------------------------------------------------------------
word_1BEDA	dw 8, 8, 8, 8, 0, 0, 0,	0, 1, 2, 3, 4, 5, 6, 7,	8 ; DATA XREF: sub_1BEB0+21r

; =============== S U B	R O U T	I N E =======================================


sub_1BEFA	proc near		; CODE XREF: sub_176C1+15Ep
		push	bp
		push	es
		push	ds
		xchg	dx, di
		sub	cx, si
		sub	dx, di
		shl	dx, 1
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		mov	es, ax
		assume es:seg001
		call	sub_1BF8C
		mov	cx, ax
		shr	ax, 4
		and	ax, 0Fh
		shl	ax, 1
		mov	bx, ax
		mov	ax, cs:word_1BF24[bx]
		pop	ds
		assume ds:nothing
		pop	es
		assume es:nothing
		pop	bp
		retn
sub_1BEFA	endp

; ---------------------------------------------------------------------------
word_1BF24	dw 8, 7, 6, 5, 4, 3, 2,	1, 0, 0, 0, 0, 8, 8, 8,	8 ; DATA XREF: sub_1BEFA+21r
; ---------------------------------------------------------------------------
		push	bp
		push	es
		push	ds
		add	si, 20h
		add	di, 20h
		xchg	dx, di
		sub	cx, si
		sub	dx, di
		shl	dx, 1
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		mov	es, ax
		assume es:seg001
		call	sub_1BF8C
		mov	cx, ax
		shr	ax, 4
		and	ax, 0Fh
		pop	ds
		assume ds:nothing
		pop	es
		assume es:nothing
		pop	bp
		retn

; =============== S U B	R O U T	I N E =======================================


sub_1BF6B	proc near		; CODE XREF: sub_13192+91p
					; seg000:5A13p	...
		push	bp
		push	es
		push	ds
		xchg	cx, si
		xchg	dx, di
		sub	cx, si
		sub	dx, di
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		mov	es, ax
		assume es:seg001
		call	sub_1BF8C
		mov	cx, ax
		shr	ax, 4
		and	ax, 0Fh
		pop	ds
		assume ds:nothing
		pop	es
		assume es:nothing
		pop	bp
		retn
sub_1BF6B	endp

		assume ds:seg001

; =============== S U B	R O U T	I N E =======================================


sub_1BF8C	proc near		; CODE XREF: sub_1BEB0+12p
					; sub_1BEFA+12p ...
		mov	bp, cx
		mov	cx, dx
		mov	ax, cx
		or	ax, bp
		jz	short loc_1BFEE
		mov	ax, cx
		cwd
		xor	ax, dx
		sub	ax, dx
		mov	bx, ax
		mov	ax, bp
		cwd
		xor	ax, dx
		sub	ax, dx
		mov	dx, ax
		cmp	dx, bx
		jz	short loc_1BFC2
		jl	short loc_1BFC6
		mov	ax, bx
		mov	bx, dx
		xor	dh, dh
		mov	dl, ah
		mov	ah, al
		mov	al, dh
		div	bx
		mov	bx, offset byte_2D2B0
		xlat
		jmp	short loc_1BFDA
; ---------------------------------------------------------------------------

loc_1BFC2:				; CODE XREF: sub_1BF8C+1Ej
		mov	al, 20h
		jmp	short loc_1BFDA
; ---------------------------------------------------------------------------

loc_1BFC6:				; CODE XREF: sub_1BF8C+20j
		mov	ax, dx
		xor	dh, dh
		mov	dl, ah
		mov	ah, al
		mov	al, dh
		div	bx
		mov	bx, offset byte_2D2B0
		xlat
		neg	al
		add	al, 40h

loc_1BFDA:				; CODE XREF: sub_1BF8C+34j
					; sub_1BF8C+38j
		xor	ah, ah
		or	bp, bp
		jge	short loc_1BFE5
		neg	ax
		add	ax, 80h

loc_1BFE5:				; CODE XREF: sub_1BF8C+52j
		or	cx, cx
		jge	short loc_1BFEB
		neg	al

loc_1BFEB:				; CODE XREF: sub_1BF8C+5Bj
		xor	ah, ah
		retn
; ---------------------------------------------------------------------------

loc_1BFEE:				; CODE XREF: sub_1BF8C+8j
		sub	ax, ax
		retn
sub_1BF8C	endp


; =============== S U B	R O U T	I N E =======================================


sub_1BFF1	proc near		; CODE XREF: sub_1BE3A+1Ap
		mov	bp, cx
		mov	cx, dx
		mov	ax, cx
		or	ax, bp
		jz	short loc_1C055
		mov	ax, cx
		cwd
		xor	ax, dx
		sub	ax, dx
		mov	bx, ax
		mov	ax, bp
		cwd
		xor	ax, dx
		sub	ax, dx
		mov	dx, ax
		cmp	dx, bx
		jz	short loc_1C028
		jl	short loc_1C02C
		mov	ax, bx
		mov	bx, dx
		xor	dh, dh
		mov	dl, ah
		mov	ah, al
		mov	al, dh
		div	bx
		mov	bx, offset byte_2D3B0
		xlat
		jmp	short loc_1C040
; ---------------------------------------------------------------------------
		align 2

loc_1C028:				; CODE XREF: sub_1BFF1+1Ej
		mov	al, 2Dh
		jmp	short loc_1C040
; ---------------------------------------------------------------------------

loc_1C02C:				; CODE XREF: sub_1BFF1+20j
		mov	ax, dx
		xor	dh, dh
		mov	dl, ah
		mov	ah, al
		mov	al, dh
		div	bx
		mov	bx, offset byte_2D3B0
		xlat
		neg	al
		add	al, 5Ah

loc_1C040:				; CODE XREF: sub_1BFF1+34j
					; sub_1BFF1+39j
		xor	ah, ah
		or	bp, bp
		jge	short loc_1C04B
		neg	ax
		add	ax, 0B4h

loc_1C04B:				; CODE XREF: sub_1BFF1+53j
		or	cx, cx
		jge	short locret_1C054
		sub	ax, 168h
		neg	ax

locret_1C054:				; CODE XREF: sub_1BFF1+5Cj
		retn
; ---------------------------------------------------------------------------

loc_1C055:				; CODE XREF: sub_1BFF1+8j
		sub	ax, ax
		retn
sub_1BFF1	endp


; =============== S U B	R O U T	I N E =======================================


sub_1C058	proc near		; CODE XREF: cmfA0D_LoadMDR+Dp
		cmp	cs:word_103A7, 0
		jz	short loc_1C061
		retn
; ---------------------------------------------------------------------------

loc_1C061:				; CODE XREF: sub_1C058+6j
		push	si
		push	ds
		call	SetIO_A6_00
		call	SetIO_A4_00
		mov	al, 4Bh	; 'K'
		out	0A2h, al	; Interrupt Controller #2, 8259A
		mov	al, 0
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1
		push	ax

loc_1C072:				; CODE XREF: sub_1C058+1Ej
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1C072

loc_1C078:				; CODE XREF: sub_1C058+24j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1C078
		pop	ax
		call	SetIO_A2A0
		sub	cx, cx
		sub	dx, dx
		call	sub_1E7A8
		jmp	short $+2
		jmp	short $+2
		mov	al, 4Bh	; 'K'
		out	0A2h, al	; Interrupt Controller #2, 8259A
		mov	al, 0
		jmp	short $+2
		jmp	short $+2
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1
		mov	ah, 0Dh
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		jmp	short $+2
		call	sub_1DA00
		pop	ds
		assume ds:nothing
		pop	si

loc_1C0A4:				; CODE XREF: sub_1C058+56j
		lodsw
		mov	bx, ax
		shl	bx, 1
		call	word ptr cs:mdrJumpTbl[bx]
		jnb	short loc_1C0A4
		jmp	short loc_1C0C4
; ---------------------------------------------------------------------------
mdrJumpTbl:				; DATA XREF: sub_1C058+51r
		dw offset mdr00_EOF	; 0
		dw offset mdr01_LoadVDF	; 1
		dw offset mdr02_FadeScreen; 2
		dw offset mdr03_Text	; 3
		dw offset mdr04_UserWait; 4
		dw offset mdr05_LoadBGM	; 5
		dw offset mdr06_FadeBGM	; 6
		dw offset mdr07_Timeout	; 7
		dw offset mdr08_Text	; 8
; ---------------------------------------------------------------------------

loc_1C0C4:				; CODE XREF: sub_1C058+58j
					; mdr01_LoadVDF+29j
		call	sub_1DA4F
		retn
sub_1C058	endp


; =============== S U B	R O U T	I N E =======================================


mdr00_EOF	proc near		; CODE XREF: sub_1C058+51p
					; DATA XREF: sub_1C058:mdrJumpTblo
		stc
		retn
mdr00_EOF	endp


; =============== S U B	R O U T	I N E =======================================


mdr01_LoadVDF	proc near		; DATA XREF: sub_1C058:mdrJumpTblo
		push	si
		push	ds
		mov	dx, si
		call	LoadFile	; load VDF file
		jb	short loc_1C0F0
		mov	ds, ax
		sub	si, si
		push	ds
		call	LoadGFXData
		pop	ds
		push	es
		mov	ax, ds
		mov	es, ax
		mov	ah, 49h
		int	21h		; DOS -	2+ - FREE MEMORY
					; ES = segment address of area to be freed
		pop	es
		pop	ds
		pop	si
		cld

loc_1C0E9:				; CODE XREF: mdr01_LoadVDF+22j
		lodsb
		cmp	al, 0
		jnz	short loc_1C0E9
		clc
		retn
; ---------------------------------------------------------------------------

loc_1C0F0:				; CODE XREF: mdr01_LoadVDF+7j
		pop	ds
		pop	si
		stc
		jmp	short loc_1C0C4
mdr01_LoadVDF	endp


; =============== S U B	R O U T	I N E =======================================


mdr02_FadeScreen proc near		; DATA XREF: sub_1C058:mdrJumpTblo
		lodsw
		push	si
		push	ds
		call	mdrGraphicEffect
		pop	ds
		pop	si
		clc
		retn
mdr02_FadeScreen endp


; =============== S U B	R O U T	I N E =======================================


mdr03_Text	proc near		; DATA XREF: sub_1C058:mdrJumpTblo
		push	si
		push	ds
		push	si
		push	ds
		call	SetIO_A6_01
		call	SetIO_A4_00
		mov	ax, 9
		call	mdrGraphicEffect
		mov	cx, 20h		; text box X start
		mov	dx, 120h	; text box Y start
		mov	si, 607		; text box X end
		mov	di, 383		; text box Y end
		mov	ah, 0		; colour 00h (black)
		mov	bx, 77DDh	; backgorund pattern
		call	mdrDrawTextBox
		push	ax

loc_1C124:				; CODE XREF: mdr03_Text+29j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1C124

loc_1C12A:				; CODE XREF: mdr03_Text+2Fj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1C12A
		pop	ax
		call	SetIO_A6_00
		call	SetIO_A4_01
		mov	ax, 9
		call	mdrGraphicEffect
		mov	cx, 32		; text box X start
		mov	dx, 288		; text box Y start
		mov	si, 607		; text box X end
		mov	di, 383		; text box Y end
		mov	ah, 0		; colour 00h (black)
		mov	bx, 77DDh	; backgorund pattern
		call	mdrDrawTextBox
		call	SetIO_A4_00
		pop	ds
		pop	si
		mov	bx, si
		mov	al, 32h
		mov	ah, 0Fh		; colour 0Fh (white)
		call	mdrLoadTxtPtr
		call	mdrTextPrint_H2
		call	mdrWaitUserInp
		pop	ds
		pop	si
		jb	short loc_1C171
		cld

loc_1C16A:				; CODE XREF: mdr03_Text+6Ej
		lodsw			; skip the shown text
		or	ax, ax		; Note:	assumes	2-byte Shift-JIS and thus requires 2x 00h as terminator.
		jnz	short loc_1C16A
		clc
		retn
; ---------------------------------------------------------------------------

loc_1C171:				; CODE XREF: mdr03_Text+68j
		push	si
		push	ds
		mov	dx, 0
		call	Music_FadeOut
		pop	ds
		pop	si
		mov	ax, 0Bh
		call	mdrGraphicEffect
		stc
		retn
mdr03_Text	endp


; =============== S U B	R O U T	I N E =======================================


mdr04_UserWait	proc near		; DATA XREF: sub_1C058:mdrJumpTblo
		push	si
		push	ds

loc_1C185:				; CODE XREF: mdr04_UserWait+8j
		call	TestUserInput
		cmp	dx, 0
		jz	short loc_1C185

loc_1C18D:				; CODE XREF: mdr04_UserWait+10j
		call	TestUserInput
		cmp	dx, 0
		jz	short loc_1C18D
		pop	ds
		pop	si
		clc
		retn
mdr04_UserWait	endp


; =============== S U B	R O U T	I N E =======================================


mdr05_LoadBGM	proc near		; DATA XREF: sub_1C058:mdrJumpTblo
		push	si
		push	ds
		push	si
		push	ds
		mov	dx, 0
		call	Music_Stop
		pop	ds
		pop	si
		sub	di, di
		call	Music_Load
		sub	si, si
		mov	dx, 0
		call	Music_Start
		pop	ds
		pop	si
		cld

loc_1C1B5:				; CODE XREF: mdr05_LoadBGM+1Fj
		lodsb
		or	al, al
		jnz	short loc_1C1B5
		clc
		retn
mdr05_LoadBGM	endp


; =============== S U B	R O U T	I N E =======================================


mdr06_FadeBGM	proc near		; DATA XREF: sub_1C058:mdrJumpTblo
		push	si
		push	ds
		mov	dx, 0
		call	Music_FadeOut
		pop	ds
		pop	si
		clc
		retn
mdr06_FadeBGM	endp


; =============== S U B	R O U T	I N E =======================================


mdr07_Timeout	proc near		; DATA XREF: sub_1C058:mdrJumpTblo
		lodsw			; load timeout into AX
		mov	cx, ax

loc_1C1CB:				; CODE XREF: mdr07_Timeout+18j
		push	ax

loc_1C1CC:				; CODE XREF: mdr07_Timeout+8j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1C1CC

loc_1C1D2:				; CODE XREF: mdr07_Timeout+Ej
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1C1D2
		pop	ax
		call	TestUserInput
		or	dx, dx
		jnz	short loc_1C1E2	; exit when a certain key is pressed?
		loop	loc_1C1CB

loc_1C1E2:				; CODE XREF: mdr07_Timeout+16j
		clc
		retn
mdr07_Timeout	endp


; =============== S U B	R O U T	I N E =======================================


mdr08_Text	proc near		; DATA XREF: sub_1C058:mdrJumpTblo
		push	si
		push	ds
		push	si
		push	ds
		call	SetIO_A6_01
		call	SetIO_A4_00
		mov	ax, 9
		call	mdrGraphicEffect
		mov	cx, 32		; text box X start
		mov	dx, 288		; text box Y start
		mov	si, 607		; text box X end
		mov	di, 383		; text box Y end
		mov	ah, 0		; colour 00h (black)
		mov	bx, 77DDh	; pattern
		call	mdrDrawTextBox
		push	ax

loc_1C209:				; CODE XREF: mdr08_Text+29j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1C209

loc_1C20F:				; CODE XREF: mdr08_Text+2Fj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1C20F
		pop	ax
		call	SetIO_A6_00
		call	SetIO_A4_01
		mov	ax, 9
		call	mdrGraphicEffect
		mov	cx, 32		; text box X start
		mov	dx, 288		; text box Y start
		mov	si, 607		; text box X end
		mov	di, 383		; text box Y end
		mov	ah, 0		; colour 00h (black)
		mov	bx, 77DDh
		call	mdrDrawTextBox
		call	SetIO_A4_00
		pop	ds
		pop	si
		mov	bx, si
		mov	al, 32h
		mov	ah, 0Fh		; colour 0Fh (white)
		call	mdrLoadTxtPtr
		call	mdrTextPrint_H2
		mov	cx, 90

loc_1C24A:				; CODE XREF: mdr08_Text+7Bj
		push	ax

loc_1C24B:				; CODE XREF: mdr08_Text+6Bj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1C24B

loc_1C251:				; CODE XREF: mdr08_Text+71j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1C251
		pop	ax
		call	TestUserInput
		or	dx, dx
		jnz	short loc_1C261
		loop	loc_1C24A

loc_1C261:				; CODE XREF: mdr08_Text+79j
		pop	ds
		pop	si
		cld

loc_1C264:				; CODE XREF: mdr08_Text+83j
		lodsw			; skip the shown text
		or	ax, ax		; Note:	assumes	2-byte Shift-JIS and thus requires 2x 00h as terminator.
		jnz	short loc_1C264
		clc
		retn
mdr08_Text	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; get double-height font character

GetFontChar_H2	proc near		; CODE XREF: PrintSJISText_H2+3Cp
		cmp	ah, 0E0h
		jb	short loc_1C274
		sub	ah, 40h

loc_1C274:				; CODE XREF: GetFontChar_H2+3j
		cmp	al, 9Eh
		jbe	short loc_1C27F
		sub	ax, 807Eh
		shl	ah, 1
		jmp	short loc_1C28A
; ---------------------------------------------------------------------------

loc_1C27F:				; CODE XREF: GetFontChar_H2+Aj
		sub	ax, 8120h
		shl	ah, 1
		inc	ah
		cmp	al, 60h
		adc	al, 0

loc_1C28A:				; CODE XREF: GetFontChar_H2+11j
		out	0A1h, al	; Interrupt Controller #2, 8259A
		mov	al, ah
		out	0A3h, al	; Interrupt Controller #2, 8259A
		mov	si, offset byte_1A51B
		mov	dx, 0A5h
		mov	cx, 10h

loc_1C299:				; CODE XREF: GetFontChar_H2+39j
		outs	dx, byte ptr cs:[si]
		in	al, 0A9h	; Interrupt Controller #2, 8259A
		mov	ah, al
		outs	dx, byte ptr cs:[si]
		in	al, 0A9h	; Interrupt Controller #2, 8259A
		stosw			; store	twice for double height
		stosw
		loop	loc_1C299
		retn
GetFontChar_H2	endp

; Parameters:
;  AL -	bytes to draw
;  AH -	color
;  BX -	text data pointer
;  DS -	text data segment

; =============== S U B	R O U T	I N E =======================================


PrintSJISText_H2 proc near		; CODE XREF: mdrWaitUserInp+37p
					; mdrWaitUserInp+50p ...
		pusha
		push	es
		mov	cs:ptx2RemBytes, al
		mov	cs:ptx2PrintColor, ah
		push	cs
		pop	es
		assume es:seg000
		mov	si, bx
		mov	di, offset ptx2GlyphBuffer
		mov	bx, di
		mov	al, 0Bh
		out	68h, al

ptx2_next:				; CODE XREF: PrintSJISText_H2+30j
					; PrintSJISText_H2+93j	...
		lodsb
		or	al, al
		jnz	short loc_1C2C8
		jmp	ptx2_end	; byte 00 - end
; ---------------------------------------------------------------------------

loc_1C2C8:				; CODE XREF: PrintSJISText_H2+1Bj
		cmp	al, 0E0h
		jnb	short ptx2_sjis	; 0E0h .. 0FFh -> draw Shift-JIS character
		cmp	al, 0A0h
		jnb	short ptx2_skip	; 0A0h .. 0DFh -> draw space
		cmp	al, 80h
		jnb	short ptx2_sjis	; 80h .. 9Fh ->	draw Shift-JIS character
		cmp	al, 20h
		jnb	short ptx2_skip	; 20h .. 7Fh ->	draw space
		jmp	short ptx2_next	; 00h .. 1Fh ->	just read next byte
; ---------------------------------------------------------------------------

ptx2_sjis:				; CODE XREF: PrintSJISText_H2+22j
					; PrintSJISText_H2+2Aj
		mov	ah, al
		lodsb
		push	si
		push	di
		push	ds
		push	cx
		push	dx
		push	es
		pop	ds
		assume ds:seg000
		call	GetFontChar_H2	; get double-height font character
		dec	cs:ptx2RemBytes
		jnz	short loc_1C2F7	; note:	This jump is *always* taken.
		xor	al, al		; BUG: At this point, DI = 0C3B0h. This	means it will overwrite
		mov	cx, 10h		; parts	of the Font_MakeBold_H2	function and thus crash	the program.

loc_1C2F3:				; CODE XREF: PrintSJISText_H2+4Dj
		inc	di		; This is supposed to clear the	2nd 8x16 part of the character.
		stosb
		loop	loc_1C2F3

loc_1C2F7:				; CODE XREF: PrintSJISText_H2+44j
		call	Font_MakeBold_H2
		pop	dx
		pop	cx
		mov	si, offset word_1C36A
		mov	di, 16		; note:	discarded by ptx2DrawChar
		mov	ah, cs:ptx2PrintColor
		push	es
		push	ds
		pusha
		mov	cs:ptx2TxtXPos,	cx
		mov	cs:ptx2TxtYPos,	dx
		call	ptx2DrawChar
		popa
		pop	ds
		assume ds:nothing
		pop	es
		assume es:nothing
		add	cx, 16		; advance X pointer
		cmp	cx, 592
		jb	short loc_1C329
		mov	cx, 48		; reset	X pointer
		add	dx, 32		; advance Y pointer

loc_1C329:				; CODE XREF: PrintSJISText_H2+79j
		pop	ds
		pop	di
		pop	si
		or	cs:ptx2RemBytes, 0
		jz	short ptx2_end
		dec	cs:ptx2RemBytes
		jz	short ptx2_end
		jmp	short ptx2_next
; ---------------------------------------------------------------------------

ptx2_skip:				; CODE XREF: PrintSJISText_H2+26j
					; PrintSJISText_H2+2Ej
		push	si
		push	di
		push	ds
		push	cx
		push	dx
		push	es
		pop	ds
		pop	dx
		pop	cx
		mov	si, 8
		mov	di, 10h
		mov	ah, cs:ptx2PrintColor
		add	cx, 8
		pop	ds
		pop	di
		pop	si
		dec	cs:ptx2RemBytes
		jz	short ptx2_end
		jmp	ptx2_next
; ---------------------------------------------------------------------------

ptx2_end:				; CODE XREF: PrintSJISText_H2+1Dj
					; PrintSJISText_H2+8Aj	...
		mov	al, 0Ah
		out	68h, al
		pop	es
		popa
		retn
PrintSJISText_H2 endp

; ---------------------------------------------------------------------------
ptx2RemBytes	db 0			; DATA XREF: PrintSJISText_H2+2w
					; PrintSJISText_H2+3Fw	...
ptx2PrintColor	db 0			; DATA XREF: PrintSJISText_H2+6w
					; PrintSJISText_H2+5Ar	...
word_1C36A	dw 0FFFFh		; DATA XREF: PrintSJISText_H2+54o
word_1C36C	dw 2
word_1C36E	dw 20h
ptx2GlyphBuffer	db 40h dup(0)		; DATA XREF: PrintSJISText_H2+Fo
ptx2TxtXPos	dw 0			; DATA XREF: PrintSJISText_H2+62w
					; mdrWaitUserInp+11w ...
ptx2TxtYPos	dw 0			; DATA XREF: PrintSJISText_H2+67w
					; mdrWaitUserInp+2Fr ...

; =============== S U B	R O U T	I N E =======================================


Font_MakeBold_H2 proc near		; CODE XREF: PrintSJISText_H2:loc_1C2F7p
		push	ax
		mov	si, bx
		mov	di, bx
		mov	cx, 20h

loc_1C3BC:				; CODE XREF: Font_MakeBold_H2+10j
		lodsw
		mov	dx, ax
		rol	dx, 1
		or	ax, dx
		stosw
		loop	loc_1C3BC
		pop	ax
		retn
Font_MakeBold_H2 endp

; ---------------------------------------------------------------------------
		push	ax
		mov	si, bx
		mov	di, bx
		mov	cx, 20h

loc_1C3D0:				; CODE XREF: seg000:C3D8j
		lodsb
		mov	dl, al
		shl	dl, 1
		or	al, dl
		stosb
		loop	loc_1C3D0
		pop	ax
		retn

; =============== S U B	R O U T	I N E =======================================


mdrWaitUserInp	proc near		; CODE XREF: mdr03_Text+63p
		push	si
		push	ds
		mov	bx, 140h
		shr	bx, 4
		inc	bx
		mov	ah, 48h
		int	21h		; DOS -	2+ - ALLOCATE MEMORY
					; BX = number of 16-byte paragraphs desired
		mov	cs:mdrWait_BufSeg, ax
		add	cs:ptx2TxtXPos,	16
		call	sub_1C49C	; draw single text character?

loc_1C3F6:				; CODE XREF: mdrWaitUserInp+1Fj
		call	TestUserInput
		or	dx, dx
		jnz	short loc_1C3F6

loc_1C3FD:				; CODE XREF: mdrWaitUserInp+98j
		mov	ax, cs
		mov	ds, ax
		assume ds:seg000
		mov	bx, offset UserPressIcon
		mov	al, 2
		mov	cx, cs:ptx2TxtXPos
		mov	dx, cs:ptx2TxtYPos
		inc	dx
		mov	ah, 0		; colour 00h (black)
		call	PrintSJISText_H2 ; draw	text shadow
		mov	ax, cs
		mov	ds, ax
		mov	bx, offset UserPressIcon
		mov	ah, 0Fh		; colour 0Fh (white)
		mov	al, 2
		mov	cx, cs:ptx2TxtXPos
		mov	dx, cs:ptx2TxtYPos
		dec	dx
		call	PrintSJISText_H2 ; draw	text
		mov	cx, 20

loc_1C432:				; CODE XREF: mdrWaitUserInp+72j
		push	cx
		push	ax

loc_1C434:				; CODE XREF: mdrWaitUserInp+5Cj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1C434

loc_1C43A:				; CODE XREF: mdrWaitUserInp+62j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1C43A
		pop	ax
		call	TestUserInput
		pop	cx
		or	dx, dx
		jnz	short loc_1C476
		call	sub_1C92C
		jb	short loc_1C489
		loop	loc_1C432
		call	sub_1C6E5
		mov	cx, 20

loc_1C456:				; CODE XREF: mdrWaitUserInp+96j
		push	cx
		push	ax

loc_1C458:				; CODE XREF: mdrWaitUserInp+80j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1C458

loc_1C45E:				; CODE XREF: mdrWaitUserInp+86j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1C45E
		pop	ax
		call	TestUserInput
		pop	cx
		or	dx, dx
		jnz	short loc_1C476
		call	sub_1C92C
		jb	short loc_1C489
		loop	loc_1C456
		jmp	short loc_1C3FD
; ---------------------------------------------------------------------------

loc_1C476:				; CODE XREF: mdrWaitUserInp+6Bj
					; mdrWaitUserInp+8Fj
		mov	ds, cs:mdrWait_BufSeg
		assume ds:nothing
		push	es
		mov	ax, ds
		mov	es, ax
		mov	ah, 49h
		int	21h		; DOS -	2+ - FREE MEMORY
					; ES = segment address of area to be freed
		pop	es
		pop	ds
		pop	si
		clc
		retn
; ---------------------------------------------------------------------------

loc_1C489:				; CODE XREF: mdrWaitUserInp+70j
					; mdrWaitUserInp+94j
		mov	ds, cs:mdrWait_BufSeg
		push	es
		mov	ax, ds
		mov	es, ax
		mov	ah, 49h
		int	21h		; DOS -	2+ - FREE MEMORY
					; ES = segment address of area to be freed
		pop	es
		pop	ds
		pop	si
		stc
		retn
mdrWaitUserInp	endp


; =============== S U B	R O U T	I N E =======================================


sub_1C49C	proc near		; CODE XREF: mdrWaitUserInp+17p
		mov	cx, cs:ptx2TxtXPos
		mov	dx, cs:ptx2TxtYPos
		mov	di, dx
		mov	dx, cx
		mov	ax, dx
		xor	dx, dx
		mov	bp, 8
		div	bp
		mov	bp, di
		shl	di, 2
		add	di, bp
		shl	di, 4
		add	di, ax
		mov	si, di
		sub	di, di
		mov	es, cs:mdrWait_BufSeg
		mov	ax, 0B000h
		mov	ds, ax
		assume ds:nothing
		push	si
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		pop	si
		mov	ax, 0A800h
		mov	ds, ax
		assume ds:nothing
		push	si
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		pop	si
		mov	ax, 0B800h
		mov	ds, ax
		assume ds:nothing
		push	si
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		pop	si
		mov	ax, 0E000h
		mov	ds, ax
		assume ds:nothing
		push	si
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		movsw
		add	si, 4Eh
		pop	si
		retn
sub_1C49C	endp


; =============== S U B	R O U T	I N E =======================================


sub_1C6E5	proc near		; CODE XREF: mdrWaitUserInp+74p
		mov	cx, cs:ptx2TxtXPos
		mov	dx, cs:ptx2TxtYPos
		mov	di, dx
		mov	dx, cx
		mov	ax, dx
		xor	dx, dx
		mov	bp, 8
		div	bp
		mov	bp, di
		shl	di, 2
		add	di, bp
		shl	di, 4
		add	di, ax
		sub	si, si
		mov	ds, cs:mdrWait_BufSeg
		assume ds:nothing
		mov	ax, 0B000h
		mov	es, ax
		assume es:nothing
		push	di
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
		pop	di
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		push	di
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
		pop	di
		mov	ax, 0B800h
		mov	es, ax
		assume es:nothing
		push	di
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
		pop	di
		mov	ax, 0E000h
		mov	es, ax
		assume es:nothing
		push	di
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
		pop	di
		retn
sub_1C6E5	endp


; =============== S U B	R O U T	I N E =======================================


sub_1C92C	proc near		; CODE XREF: mdrWaitUserInp+6Dp
					; mdrWaitUserInp+91p
		push	bx
		push	es
		sub	ax, ax
		mov	es, ax
		assume es:nothing
		mov	bx, 52Ah
		test	byte ptr es:[bx], 1
		pop	es
		assume es:nothing
		pop	bx
		jz	short loc_1C93F
		stc
		retn
; ---------------------------------------------------------------------------

loc_1C93F:				; CODE XREF: sub_1C92C+Fj
		clc
		retn
sub_1C92C	endp

; ---------------------------------------------------------------------------
mdrWait_BufSeg	dw 0			; DATA XREF: mdrWaitUserInp+Dw
					; mdrWaitUserInp:loc_1C476r ...
UserPressIcon	db 81h,	0A5h, 0		; DATA XREF: mdrWaitUserInp+25o
					; mdrWaitUserInp+3Eo

; =============== S U B	R O U T	I N E =======================================


mdrTextPrint_H2	proc near		; CODE XREF: mdr03_Text+60p
					; mdr08_Text+60p ...
		cmp	cs:mdrDoTxtDraw, 0
		jnz	short loc_1C951
		jmp	loc_1C9D8
; ---------------------------------------------------------------------------

loc_1C951:				; CODE XREF: mdrTextPrint_H2+6j
		mov	cx, 32		; text box X start
		mov	dx, 288		; text box Y start
		mov	si, 607		; text box X end
		mov	di, 191		; text box Y end
		add	cx, 16		; text X start offset
		add	dx, 16		; text Y start offset
		sub	bx, bx
		mov	bl, cs:mdrTxtDrawPos
		sub	bx, 2
		cmp	bx, 68
		jb	short loc_1C978
		sub	bx, 68		; wrap to next line
		add	dx, 32

loc_1C978:				; CODE XREF: mdrTextPrint_H2+2Aj
		shl	bx, 3		; pixel	X = text X * 8
		add	cx, bx
		inc	dx
		mov	ds, cs:mdrTextSeg
		mov	bx, cs:mdrTextPtr
		mov	ah, cs:mdrTextColor
		mov	al, cs:mdrTxtDrawPos
		mov	al, 2
		mov	ah, 0		; force	colour 00h (black)
		push	cx
		push	dx
		call	PrintSJISText_H2 ; draw	text shadow
		pop	dx
		pop	cx
		mov	ds, cs:mdrTextSeg
		mov	bx, cs:mdrTextPtr
		mov	ah, cs:mdrTextColor
		mov	al, cs:mdrTxtDrawPos
		mov	al, 2
		dec	dx
		call	PrintSJISText_H2 ; draw	text
		add	cs:mdrTextPtr, 2
		mov	al, cs:mdrTxtDrawPos
		inc	al
		inc	al
		cmp	al, cs:mdrTextLen
		jz	short loc_1C9D0
		mov	cs:mdrTxtDrawPos, al
		jmp	short loc_1C9D8
; ---------------------------------------------------------------------------

loc_1C9D0:				; CODE XREF: mdrTextPrint_H2+82j
		mov	cs:mdrDoTxtDraw, 0
		retn
; ---------------------------------------------------------------------------

loc_1C9D8:				; CODE XREF: mdrTextPrint_H2+8j
					; mdrTextPrint_H2+88j
		call	TestUserInput
		or	dx, dx
		jnz	short loc_1CA09
		push	ax

loc_1C9E0:				; CODE XREF: mdrTextPrint_H2+9Ej
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1C9E0

loc_1C9E6:				; CODE XREF: mdrTextPrint_H2+A4j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1C9E6
		pop	ax
		push	ax

loc_1C9EE:				; CODE XREF: mdrTextPrint_H2+ACj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1C9EE

loc_1C9F4:				; CODE XREF: mdrTextPrint_H2+B2j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1C9F4
		pop	ax
		push	ax

loc_1C9FC:				; CODE XREF: mdrTextPrint_H2+BAj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1C9FC

loc_1CA02:				; CODE XREF: mdrTextPrint_H2+C0j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1CA02
		pop	ax

loc_1CA09:				; CODE XREF: mdrTextPrint_H2+97j
		jmp	mdrTextPrint_H2
mdrTextPrint_H2	endp


; =============== S U B	R O U T	I N E =======================================


mdrLoadTxtPtr	proc near		; CODE XREF: mdr03_Text+5Dp
					; mdr08_Text+5Dp
		mov	cs:mdrTextSeg, ds
		mov	cs:mdrTextPtr, bx
		mov	cs:mdrDoTxtDraw, 1 ; enable text drawing
		mov	cs:mdrTxtDrawPos, 2 ; position 2 = 16 pixels border
		mov	cs:mdrTextLen, al
		mov	cs:mdrTextColor, ah
		mov	cs:byte_1CA56, 1
		mov	cs:byte_1CA57, 20
		push	bx
		push	si
		mov	si, bx
		sub	bx, bx

loc_1CA3E:				; CODE XREF: mdrLoadTxtPtr+37j
		lodsw
		inc	bx
		inc	bx
		or	ax, ax
		jnz	short loc_1CA3E
		mov	cs:mdrTextLen, bl
		pop	si
		pop	bx
		retn
mdrLoadTxtPtr	endp

; ---------------------------------------------------------------------------
mdrDoTxtDraw	dw 0			; DATA XREF: mdrTextPrint_H2r
					; mdrTextPrint_H2:loc_1C9D0w ...
mdrTextPtr	dw 0			; DATA XREF: mdrTextPrint_H2+3Dr
					; mdrTextPrint_H2+5Br ...
mdrTextSeg	dw 0			; DATA XREF: mdrTextPrint_H2+38r
					; mdrTextPrint_H2+56r ...
mdrTextColor	db 0			; DATA XREF: mdrTextPrint_H2+42r
					; mdrTextPrint_H2+60r ...
mdrTxtDrawPos	db 0			; DATA XREF: mdrTextPrint_H2+1Fr
					; mdrTextPrint_H2+47r ...
mdrTextLen	db 0			; DATA XREF: mdrTextPrint_H2+7Dr
					; mdrLoadTxtPtr+17w ...
byte_1CA56	db 0			; DATA XREF: mdrLoadTxtPtr+20w
byte_1CA57	db 0			; DATA XREF: mdrLoadTxtPtr+26w

; =============== S U B	R O U T	I N E =======================================


ptx2DrawChar	proc near		; CODE XREF: PrintSJISText_H2+6Cp
		mov	al, 0C0h
		out	7Ch, al
		mov	al, 0C0h
		out	7Ch, al
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		lodsw			; read and discard word_1C36A
		lodsw			; read word_1C36C
		mov	bx, ax
		lodsw			; read word_1C36E
		mov	di, ax		; DI = character glyph size in bytes
		xchg	bx, si
		shl	si, 3		; SI = character width in pixels
		mov	cs:mcd2_PosX, cx
		mov	cs:mcd2_PosY, dx
		mov	cs:mcd2_ChrWidth, si
		mov	cs:mcd2_ChrBytes, di
		and	cl, 7
		mov	cx, cs:mcd2_PosX
		mov	al, 0FFh
		mov	cs:mcd2_PosXWrap, 0
		add	si, cx
		add	di, dx
		cmp	cx, cs:mdc2_XMin ; clamp X position to [0 .. 639]
		jge	short loc_1CAC0
		mov	cx, cs:mdc2_XMin
		xor	al, al

loc_1CAC0:				; CODE XREF: ptx2DrawChar+5Fj
		cmp	si, cs:mdc2_XMax
		jle	short loc_1CAD8
		sub	si, cs:mdc2_XMax
		mov	cs:mcd2_PosXWrap, si
		mov	si, cs:mdc2_XMax
		xor	al, al		; prevent character drawing

loc_1CAD8:				; CODE XREF: ptx2DrawChar+6Dj
		cmp	cx, si
		jge	short loc_1CB02
		sub	si, cx
		cmp	dx, 0		; clamp	Y position to [0 .. 399]
		jge	short loc_1CAE8
		mov	dx, 0
		xor	al, al

loc_1CAE8:				; CODE XREF: ptx2DrawChar+89j
		cmp	di, 399
		jle	short loc_1CAF3
		mov	di, 399
		xor	al, al

loc_1CAF3:				; CODE XREF: ptx2DrawChar+94j
		cmp	dx, di
		jge	short loc_1CB02
		sub	di, dx
		or	al, al
		jz	short loc_1CB02
		call	mdrCopyChar_H2
		jmp	short $+2

loc_1CB02:				; CODE XREF: ptx2DrawChar+82j
					; ptx2DrawChar+9Dj ...
		mov	cx, cs:mcd2_PosX
		mov	dx, cs:mcd2_PosY
		xor	al, al
		out	7Ch, al
		xor	al, al
		out	7Ch, al
		retn
ptx2DrawChar	endp


; =============== S U B	R O U T	I N E =======================================


mdrCopyChar_H2	proc near		; CODE XREF: ptx2DrawChar+A5p
		shr	si, 3
		xchg	si, bx
		xchg	di, dx
		mov	bp, 50h
		sub	bp, bx
		mov	ax, di
		shl	di, 2
		add	di, ax
		shl	di, 4
		mov	ax, cx
		shr	ax, 3
		add	di, ax
		push	di

loc_1CB33:				; CODE XREF: mdrCopyChar_H2+25j
		mov	cx, bx
		rep movsb
		add	di, bp
		dec	dx
		jnz	short loc_1CB33
		pop	di
		retn
mdrCopyChar_H2	endp


; =============== S U B	R O U T	I N E =======================================


mdrDrawTextBox	proc near		; CODE XREF: mdr03_Text+21p
					; mdr03_Text+4Fp ...
		pusha
		push	es
		mov	al, 0C0h
		out	7Ch, al
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		mov	ax, 0A800h
		mov	es, ax
		xchg	dx, cx
		xchg	si, bx
		sub	bx, dx
		sub	di, cx
		xchg	di, cx
		call	loc_1CB76
		xor	al, al
		out	7Ch, al
		pop	es
		assume es:nothing
		popa
		retn
mdrDrawTextBox	endp

; ---------------------------------------------------------------------------
		align 2

loc_1CB76:				; CODE XREF: mdrDrawTextBox+2Dp
		mov	byte ptr cs:loc_1CC2F+3, 0
		mov	byte ptr cs:loc_1CC3A+3, 0
		mov	byte ptr cs:loc_1CC45+3, 0
		mov	byte ptr cs:loc_1CC50+3, 0
		mov	ax, dx
		xor	dx, dx
		mov	bp, 8
		div	bp
		mov	bp, di
		shl	di, 2
		add	di, bp
		shl	di, 4
		add	di, ax
		push	cx
		cmp	bx, 8
		jnb	short loc_1CBDC
		mov	cx, bx
		mov	ax, 0FF00h
		shr	ax, cl
		mov	ah, al
		xor	al, al
		mov	cx, dx
		shr	ax, cl
		mov	dx, si
		and	dh, ah
		and	dl, ah
		mov	byte ptr cs:loc_1CC2F+3, dh
		mov	byte ptr cs:loc_1CC45+3, dl
		mov	dx, si
		and	dh, al
		and	dl, al
		mov	byte ptr cs:loc_1CC3A+3, dh
		mov	byte ptr cs:loc_1CC50+3, dl
		xor	bp, bp
		jmp	short loc_1CC25
; ---------------------------------------------------------------------------

loc_1CBDC:				; CODE XREF: seg000:CBA7j
		or	dx, dx
		jnz	short loc_1CBE3
		dec	di
		jmp	short loc_1CC00
; ---------------------------------------------------------------------------

loc_1CBE3:				; CODE XREF: seg000:CBDEj
		mov	ax, 8
		sub	ax, dx
		sub	bx, ax
		mov	cx, dx
		mov	dx, 0FFh
		shr	dx, cl
		mov	ax, si
		and	ah, dl
		and	al, dl
		mov	byte ptr cs:loc_1CC2F+3, ah
		mov	byte ptr cs:loc_1CC45+3, al

loc_1CC00:				; CODE XREF: seg000:CBE1j
		mov	ax, bx
		mov	bp, 8
		xor	dx, dx
		div	bp
		mov	bp, ax
		or	dx, dx
		jz	short loc_1CC25
		mov	cx, dx
		mov	dx, 0FF00h
		shr	dx, cl
		mov	ax, si
		and	ah, dl
		and	al, dl
		mov	byte ptr cs:loc_1CC3A+3, ah
		mov	byte ptr cs:loc_1CC50+3, al

loc_1CC25:				; CODE XREF: seg000:CBDAj seg000:CC0Dj
		pop	cx
		mov	dx, 4Fh
		sub	dx, bp
		mov	bx, si
		mov	si, cx

loc_1CC2F:				; CODE XREF: seg000:CC57j
					; DATA XREF: seg000:loc_1CB76w	...
		mov	byte ptr es:[di], 0FFh
		inc	di
		mov	cx, bp
		mov	al, bh
		rep stosb

loc_1CC3A:				; DATA XREF: seg000:CB7Cw seg000:CBCEw ...
		mov	byte ptr es:[di], 0FFh
		add	di, dx
		dec	si
		jnz	short loc_1CC45
		jmp	short locret_1CC59
; ---------------------------------------------------------------------------

loc_1CC45:				; CODE XREF: seg000:CC41j
					; DATA XREF: seg000:CB82w ...
		mov	byte ptr es:[di], 0FFh
		inc	di
		mov	cx, bp
		mov	al, bl
		rep stosb

loc_1CC50:				; DATA XREF: seg000:CB88w seg000:CBD3w ...
		mov	byte ptr es:[di], 0FFh
		add	di, dx
		dec	si
		jnz	short loc_1CC2F

locret_1CC59:				; CODE XREF: seg000:CC43j
		retn

; =============== S U B	R O U T	I N E =======================================


mdrGraphicEffect proc near		; CODE XREF: DoOneLevel+C2p
					; DoOneLevel+D1p ...

; FUNCTION CHUNK AT CF44 SIZE 00000122 BYTES
; FUNCTION CHUNK AT D0B4 SIZE 0000032D BYTES
; FUNCTION CHUNK AT D4A1 SIZE 00000066 BYTES
; FUNCTION CHUNK AT D586 SIZE 000003B5 BYTES

		push	ax
		mov	ax, cs
		mov	ds, ax
		assume ds:seg000
		mov	si, offset vdfHeaderData
		call	LoadVDFPalette
		pop	ax
		cmp	ax, 1
		jnz	short loc_1CC6E
		jmp	mdr02_01
; ---------------------------------------------------------------------------

loc_1CC6E:				; CODE XREF: mdrGraphicEffect+Fj
		cmp	ax, 2
		jnz	short loc_1CC76
		jmp	mdr02_02_ShowVDF
; ---------------------------------------------------------------------------

loc_1CC76:				; CODE XREF: mdrGraphicEffect+17j
		cmp	ax, 3
		jnz	short loc_1CC7E
		jmp	mdr02_03
; ---------------------------------------------------------------------------

loc_1CC7E:				; CODE XREF: mdrGraphicEffect+1Fj
		cmp	ax, 4
		jnz	short loc_1CC86
		jmp	mdr02_04
; ---------------------------------------------------------------------------

loc_1CC86:				; CODE XREF: mdrGraphicEffect+27j
		cmp	ax, 5
		jnz	short loc_1CC8E
		jmp	mdr02_05
; ---------------------------------------------------------------------------

loc_1CC8E:				; CODE XREF: mdrGraphicEffect+2Fj
		cmp	ax, 6
		jnz	short loc_1CC96
		jmp	mdr02_06
; ---------------------------------------------------------------------------

loc_1CC96:				; CODE XREF: mdrGraphicEffect+37j
		cmp	ax, 7
		jnz	short loc_1CC9E
		jmp	mdr02_07
; ---------------------------------------------------------------------------

loc_1CC9E:				; CODE XREF: mdrGraphicEffect+3Fj
		cmp	ax, 8
		jnz	short loc_1CCA6
		jmp	mdr02_08
; ---------------------------------------------------------------------------

loc_1CCA6:				; CODE XREF: mdrGraphicEffect+47j
		cmp	ax, 9
		jnz	short loc_1CCAE
		jmp	mdr02_09
; ---------------------------------------------------------------------------

loc_1CCAE:				; CODE XREF: mdrGraphicEffect+4Fj
		cmp	ax, 0Ah
		jnz	short loc_1CCB6
		jmp	mdr02_0A_ScrFadeIn
; ---------------------------------------------------------------------------

loc_1CCB6:				; CODE XREF: mdrGraphicEffect+57j
		cmp	ax, 0Bh
		jnz	short loc_1CCBE
		jmp	mdr02_0B
; ---------------------------------------------------------------------------

loc_1CCBE:				; CODE XREF: mdrGraphicEffect+5Fj
		cmp	ax, 0Ch
		jnz	short loc_1CCC6
		jmp	mdr02_0C
; ---------------------------------------------------------------------------

loc_1CCC6:				; CODE XREF: mdrGraphicEffect+67j
		cmp	ax, 0Dh
		jnz	short loc_1CCCE
		jmp	mdr02_0D
; ---------------------------------------------------------------------------

loc_1CCCE:				; CODE XREF: mdrGraphicEffect+6Fj
		cmp	ax, 0Eh
		jnz	short loc_1CCD6
		jmp	mdr02_0E
; ---------------------------------------------------------------------------

loc_1CCD6:				; CODE XREF: mdrGraphicEffect+77j
		cmp	ax, 0Fh
		jz	short mdr02_0F
		cmp	ax, 10h
		jz	short mdr02_10
		jmp	mdr02_bad
; ---------------------------------------------------------------------------

mdr02_0F:				; CODE XREF: mdrGraphicEffect+7Fj
		mov	ax, cs
		mov	ds, ax
		mov	si, offset vdfHeaderData
		call	LoadVDFPalette
		call	SetIO_A6_01
		call	sub_1D066
		call	SetIO_A6_00
		call	sub_1D066
		call	SetIO_A4_00
		mov	cx, 10h

loc_1CCFF:				; CODE XREF: mdrGraphicEffect+FFj
		push	cx
		push	cx
		call	TestUserInput
		pop	cx
		or	dx, dx
		jnz	short loc_1CD41
		push	ax

loc_1CD0A:				; CODE XREF: mdrGraphicEffect+B4j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1CD0A

loc_1CD10:				; CODE XREF: mdrGraphicEffect+BAj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1CD10
		pop	ax
		push	ax

loc_1CD18:				; CODE XREF: mdrGraphicEffect+C2j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1CD18

loc_1CD1E:				; CODE XREF: mdrGraphicEffect+C8j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1CD1E
		pop	ax
		push	ax

loc_1CD26:				; CODE XREF: mdrGraphicEffect+D0j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1CD26

loc_1CD2C:				; CODE XREF: mdrGraphicEffect+D6j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1CD2C
		pop	ax
		push	ax

loc_1CD34:				; CODE XREF: mdrGraphicEffect+DEj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1CD34

loc_1CD3A:				; CODE XREF: mdrGraphicEffect+E4j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1CD3A
		pop	ax

loc_1CD41:				; CODE XREF: mdrGraphicEffect+ADj
		push	ax

loc_1CD42:				; CODE XREF: mdrGraphicEffect+ECj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1CD42

loc_1CD48:				; CODE XREF: mdrGraphicEffect+F2j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1CD48
		pop	ax
		mov	bp, 0FFFFh
		mov	bx, cx
		dec	bx
		call	sub_1E39A
		pop	cx
		loop	loc_1CCFF
		retn
; ---------------------------------------------------------------------------

mdr02_10:				; CODE XREF: mdrGraphicEffect+84j
		mov	ax, cs
		mov	ds, ax
		mov	si, offset vdfHeaderData
		call	SetIO_A6_01
		call	sub_1D066
		call	SetIO_A6_00
		call	sub_1D066
		call	SetIO_A4_00
		mov	cx, 10h

loc_1CD75:				; CODE XREF: mdrGraphicEffect+17Aj
		push	cx
		push	cx
		call	TestUserInput
		pop	cx
		or	dx, dx
		jz	short loc_1CD82
		jmp	loc_1CF9F
; ---------------------------------------------------------------------------

loc_1CD82:				; CODE XREF: mdrGraphicEffect+123j
		push	ax

loc_1CD83:				; CODE XREF: mdrGraphicEffect+12Dj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1CD83

loc_1CD89:				; CODE XREF: mdrGraphicEffect+133j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1CD89
		pop	ax
		push	ax

loc_1CD91:				; CODE XREF: mdrGraphicEffect+13Bj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1CD91

loc_1CD97:				; CODE XREF: mdrGraphicEffect+141j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1CD97
		pop	ax
		push	ax

loc_1CD9F:				; CODE XREF: mdrGraphicEffect+149j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1CD9F

loc_1CDA5:				; CODE XREF: mdrGraphicEffect+14Fj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1CDA5
		pop	ax
		push	ax

loc_1CDAD:				; CODE XREF: mdrGraphicEffect+157j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1CDAD

loc_1CDB3:				; CODE XREF: mdrGraphicEffect+15Dj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1CDB3
		pop	ax
		push	ax

loc_1CDBB:				; CODE XREF: mdrGraphicEffect+165j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1CDBB

loc_1CDC1:				; CODE XREF: mdrGraphicEffect+16Bj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1CDC1
		pop	ax
		mov	bp, 0FFFFh
		mov	bx, 10h
		sub	bx, cx
		call	sub_1E39A
		pop	cx
		loop	loc_1CD75
		retn
; ---------------------------------------------------------------------------

mdr02_0E:				; CODE XREF: mdrGraphicEffect+79j
		mov	cs:word_1CEF8, 0
		sub	cx, cx
		sub	dx, dx
		call	sub_1E7A8
		mov	cx, 190h
		mov	bx, 0F0h

loc_1CDEB:				; CODE XREF: mdrGraphicEffect:loc_1CE45j
		push	cx
		push	bx
		call	TestUserInput
		or	dx, dx
		jnz	short loc_1CE02
		push	ax

loc_1CDF5:				; CODE XREF: mdrGraphicEffect+19Fj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1CDF5

loc_1CDFB:				; CODE XREF: mdrGraphicEffect+1A5j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1CDFB
		pop	ax

loc_1CE02:				; CODE XREF: mdrGraphicEffect+198j
		sub	cx, cx
		mov	dx, 1
		call	sub_1E778
		sub	cx, cx
		mov	dx, 18Fh
		call	sub_1E86E
		mov	di, bx
		mov	si, cs:word_1CEF8
		mov	cx, 28h	; '('
		call	sub_1CEFA
		add	cs:word_1CEF8, 50h ; 'P'
		dec	bx
		pop	bx
		pop	cx
		push	bx
		push	bp
		push	ds
		mov	bp, 0FFFFh
		shr	bx, 4
		mov	bh, bl
		mov	bl, 10h
		sub	bl, bh
		push	cx
		call	sub_1E39A
		pop	cx
		pop	ds
		assume ds:nothing
		pop	bp
		pop	bx
		cmp	bx, 0
		jz	short loc_1CE45
		dec	bx

loc_1CE45:				; CODE XREF: mdrGraphicEffect+1E8j
		loop	loc_1CDEB
		sub	cx, cx
		sub	dx, dx
		call	sub_1E7A8
		retn
; ---------------------------------------------------------------------------

mdr02_0D:				; CODE XREF: mdrGraphicEffect+71j
		mov	cs:word_1CEF8, 0
		sub	cx, cx
		sub	dx, dx
		call	sub_1E7A8
		mov	cx, 190h

loc_1CE60:				; CODE XREF: mdrGraphicEffect+240j
		push	cx
		call	TestUserInput
		or	dx, dx
		jnz	short loc_1CE76
		push	ax

loc_1CE69:				; CODE XREF: mdrGraphicEffect+213j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1CE69

loc_1CE6F:				; CODE XREF: mdrGraphicEffect+219j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1CE6F
		pop	ax

loc_1CE76:				; CODE XREF: mdrGraphicEffect+20Cj
		sub	cx, cx
		mov	dx, 1
		call	sub_1E778
		sub	cx, cx
		mov	dx, 18Fh
		call	sub_1E86E
		mov	di, bx
		mov	si, cs:word_1CEF8
		mov	cx, 28h	; '('
		call	sub_1CEFA
		add	cs:word_1CEF8, 50h ; 'P'
		pop	cx
		loop	loc_1CE60
		sub	cx, cx
		sub	dx, dx
		call	sub_1E7A8
		retn
; ---------------------------------------------------------------------------

mdr02_0C:				; CODE XREF: mdrGraphicEffect+69j
		mov	cs:word_1CEF8, 7CB0h
		sub	cx, cx
		sub	dx, dx
		call	sub_1E7A8
		mov	cx, 190h

loc_1CEB5:				; CODE XREF: mdrGraphicEffect+294j
		push	cx
		call	TestUserInput
		or	dx, dx
		jnz	short loc_1CECB
		push	ax

loc_1CEBE:				; CODE XREF: mdrGraphicEffect+268j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1CEBE

loc_1CEC4:				; CODE XREF: mdrGraphicEffect+26Ej
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1CEC4
		pop	ax

loc_1CECB:				; CODE XREF: mdrGraphicEffect+261j
		sub	cx, cx
		mov	dx, 0FFFFh
		call	sub_1E778
		sub	cx, cx
		sub	dx, dx
		call	sub_1E86E
		mov	di, bx
		mov	si, cs:word_1CEF8
		mov	cx, 28h	; '('
		call	sub_1CEFA
		sub	cs:word_1CEF8, 50h ; 'P'
		pop	cx
		loop	loc_1CEB5
		sub	cx, cx
		sub	dx, dx
		call	sub_1E7A8
		retn
mdrGraphicEffect endp

; ---------------------------------------------------------------------------
word_1CEF8	dw 0			; DATA XREF: mdrGraphicEffect:mdr02_0Ew
					; mdrGraphicEffect+1BAr ...

; =============== S U B	R O U T	I N E =======================================


sub_1CEFA	proc near		; CODE XREF: mdrGraphicEffect+1C2p
					; mdrGraphicEffect+236p ...
		cld
		push	cx
		push	si
		push	di
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		mov	ds, cs:word_1DD48
		rep movsw
		pop	di
		pop	si
		pop	cx
		push	cx
		push	si
		push	di
		mov	ax, 0B000h
		mov	es, ax
		assume es:nothing
		mov	ds, cs:word_1DD4A
		rep movsw
		pop	di
		pop	si
		pop	cx
		push	cx
		push	si
		push	di
		mov	ax, 0B800h
		mov	es, ax
		assume es:nothing
		mov	ds, cs:word_1DD4C
		rep movsw
		pop	di
		pop	si
		pop	cx
		push	cx
		push	si
		push	di
		mov	ax, 0E000h
		mov	es, ax
		assume es:nothing
		mov	ds, cs:word_1DD4E
		rep movsw
		pop	di
		pop	si
		pop	cx
		retn
sub_1CEFA	endp

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR mdrGraphicEffect

mdr02_0B:				; CODE XREF: mdrGraphicEffect+61j
		mov	ax, cs
		mov	ds, ax
		assume ds:seg000
		mov	si, offset vdfHeaderData
		call	SetIO_A6_01
		call	sub_1D066
		call	SetIO_A6_00
		call	sub_1D066
		call	SetIO_A4_00
		mov	cx, 0Eh

loc_1CF5D:				; CODE XREF: mdrGraphicEffect+35Cj
		push	cx
		push	cx
		call	TestUserInput
		pop	cx
		or	dx, dx
		jnz	short loc_1CF9F
		push	ax

loc_1CF68:				; CODE XREF: mdrGraphicEffect+312j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1CF68

loc_1CF6E:				; CODE XREF: mdrGraphicEffect+318j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1CF6E
		pop	ax
		push	ax

loc_1CF76:				; CODE XREF: mdrGraphicEffect+320j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1CF76

loc_1CF7C:				; CODE XREF: mdrGraphicEffect+326j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1CF7C
		pop	ax
		push	ax

loc_1CF84:				; CODE XREF: mdrGraphicEffect+32Ej
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1CF84

loc_1CF8A:				; CODE XREF: mdrGraphicEffect+334j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1CF8A
		pop	ax
		push	ax

loc_1CF92:				; CODE XREF: mdrGraphicEffect+33Cj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1CF92

loc_1CF98:				; CODE XREF: mdrGraphicEffect+342j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1CF98
		pop	ax

loc_1CF9F:				; CODE XREF: mdrGraphicEffect+125j
					; mdrGraphicEffect+30Bj
		push	ax

loc_1CFA0:				; CODE XREF: mdrGraphicEffect+34Aj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1CFA0

loc_1CFA6:				; CODE XREF: mdrGraphicEffect+350j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1CFA6
		pop	ax
		mov	bp, 0FFFFh
		mov	bx, cx
		call	Palette_SetMult
		pop	cx
		loop	loc_1CF5D
		retn
; ---------------------------------------------------------------------------

mdr02_0A_ScrFadeIn:			; CODE XREF: mdrGraphicEffect+59j
		mov	ax, cs
		mov	ds, ax
		mov	si, offset vdfHeaderData
		call	Palette_DoBlack
		call	SetIO_A6_01
		call	sub_1D066
		call	SetIO_A6_00
		call	sub_1D066
		call	SetIO_A4_00
		mov	cx, 10h

loc_1CFD5:				; CODE XREF: mdrGraphicEffect+3D7j
		push	cx
		push	cx
		call	TestUserInput
		pop	cx
		or	dx, dx
		jnz	short loc_1D017
		push	ax

loc_1CFE0:				; CODE XREF: mdrGraphicEffect+38Aj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1CFE0

loc_1CFE6:				; CODE XREF: mdrGraphicEffect+390j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1CFE6
		pop	ax
		push	ax

loc_1CFEE:				; CODE XREF: mdrGraphicEffect+398j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1CFEE

loc_1CFF4:				; CODE XREF: mdrGraphicEffect+39Ej
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1CFF4
		pop	ax
		push	ax

loc_1CFFC:				; CODE XREF: mdrGraphicEffect+3A6j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1CFFC

loc_1D002:				; CODE XREF: mdrGraphicEffect+3ACj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1D002
		pop	ax
		push	ax

loc_1D00A:				; CODE XREF: mdrGraphicEffect+3B4j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1D00A

loc_1D010:				; CODE XREF: mdrGraphicEffect+3BAj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1D010
		pop	ax

loc_1D017:				; CODE XREF: mdrGraphicEffect+383j
		push	ax

loc_1D018:				; CODE XREF: mdrGraphicEffect+3C2j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1D018

loc_1D01E:				; CODE XREF: mdrGraphicEffect+3C8j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1D01E
		pop	ax
		mov	bp, 0FFFFh
		mov	bx, 10h
		sub	bx, cx
		call	Palette_SetMult
		pop	cx
		loop	loc_1CFD5
		retn
; ---------------------------------------------------------------------------

mdr02_09:				; CODE XREF: mdrGraphicEffect+51j
		call	sub_1D066
		retn
; ---------------------------------------------------------------------------

mdr02_08:				; CODE XREF: mdrGraphicEffect+49j
		call	SetIO_A6_01
		call	SetIO_A4_00
		call	sub_1D066
		call	SetIO_A6_00
		push	ax

loc_1D045:				; CODE XREF: mdrGraphicEffect+3EFj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1D045

loc_1D04B:				; CODE XREF: mdrGraphicEffect+3F5j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1D04B
		pop	ax
		mov	ax, cs
		mov	ds, ax
		mov	si, offset vdfHeaderData
		call	Palette_Refresh
		call	SetIO_A4_01
		call	sub_1D066
		call	SetIO_A4_00
		retn
; END OF FUNCTION CHUNK	FOR mdrGraphicEffect

; =============== S U B	R O U T	I N E =======================================


sub_1D066	proc near		; CODE XREF: mdrGraphicEffect+96p
					; mdrGraphicEffect+9Cp	...
		cld
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		mov	ds, cs:word_1DD48
		assume ds:nothing
		mov	cx, 3E80h
		sub	si, si
		sub	di, di
		rep movsw
		mov	ax, 0B000h
		mov	es, ax
		assume es:nothing
		mov	ds, cs:word_1DD4A
		mov	cx, 3E80h
		sub	si, si
		sub	di, di
		rep movsw
		mov	ax, 0B800h
		mov	es, ax
		assume es:nothing
		mov	ds, cs:word_1DD4C
		mov	cx, 3E80h
		sub	si, si
		sub	di, di
		rep movsw
		mov	ax, 0E000h
		mov	es, ax
		assume es:nothing
		mov	ds, cs:word_1DD4E
		mov	cx, 3E80h
		sub	si, si
		sub	di, di
		rep movsw
		retn
sub_1D066	endp

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR mdrGraphicEffect

mdr02_07:				; CODE XREF: mdrGraphicEffect+41j
		cld
		mov	ax, 0A800h
		mov	ds, ax
		assume ds:nothing
		mov	es, cs:word_1DD48
		assume es:nothing
		mov	cx, 3E80h
		sub	si, si
		sub	di, di
		rep movsw
		mov	ax, 0B000h
		mov	ds, ax
		assume ds:nothing
		mov	es, cs:word_1DD4A
		mov	cx, 3E80h
		sub	si, si
		sub	di, di
		rep movsw
		mov	ax, 0B800h
		mov	ds, ax
		assume ds:nothing
		mov	es, cs:word_1DD4C
		mov	cx, 3E80h
		sub	si, si
		sub	di, di
		rep movsw
		mov	ax, 0E000h
		mov	ds, ax
		assume ds:nothing
		mov	es, cs:word_1DD4E
		mov	cx, 3E80h
		sub	si, si
		sub	di, di
		rep movsw
		push	ax

loc_1D102:				; CODE XREF: mdrGraphicEffect+4ACj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1D102

loc_1D108:				; CODE XREF: mdrGraphicEffect+4B2j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1D108
		pop	ax
		mov	ax, cs
		mov	ds, ax
		assume ds:seg000
		mov	si, offset vdfHeaderData
		call	Palette_Refresh
		call	SetIO_A4_00
		call	SetIO_A6_01
		mov	bx, 0
		mov	cx, 50h

loc_1D125:				; CODE XREF: mdrGraphicEffect+501j
		push	cx
		push	bx
		mov	di, 0
		call	sub_1D435
		push	ax

loc_1D12E:				; CODE XREF: mdrGraphicEffect+4D8j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1D12E

loc_1D134:				; CODE XREF: mdrGraphicEffect+4DEj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1D134
		pop	ax
		call	sub_1E917
		call	sub_1E92E
		pop	bx
		pop	cx
		jmp	short $+2
		jmp	short $+2
		mov	al, 4Bh
		out	0A2h, al	; Interrupt Controller #2, 8259A
		mov	al, bl
		jmp	short $+2
		jmp	short $+2
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1
		inc	bx
		add	cx, 50h
		cmp	cx, 0A00h
		jnz	short loc_1D125
		call	sub_1E92E
		retn
; ---------------------------------------------------------------------------

mdr02_06:				; CODE XREF: mdrGraphicEffect+39j
		push	ax

loc_1D162:				; CODE XREF: mdrGraphicEffect+50Cj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1D162

loc_1D168:				; CODE XREF: mdrGraphicEffect+512j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1D168
		pop	ax
		mov	ax, cs
		mov	ds, ax
		mov	si, offset vdfHeaderData
		call	Palette_Refresh
		call	SetIO_A4_00
		call	SetIO_A6_01
		mov	bx, 1Fh
		mov	cx, 0A00h

loc_1D185:				; CODE XREF: mdrGraphicEffect+55Dj
		push	cx
		push	bx
		mov	di, 0
		call	sub_1D435
		push	ax

loc_1D18E:				; CODE XREF: mdrGraphicEffect+538j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1D18E

loc_1D194:				; CODE XREF: mdrGraphicEffect+53Ej
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1D194
		pop	ax
		call	sub_1E917
		call	sub_1E92E
		pop	bx
		pop	cx
		jmp	short $+2
		jmp	short $+2
		mov	al, 4Bh
		out	0A2h, al	; Interrupt Controller #2, 8259A
		mov	al, bl
		jmp	short $+2
		jmp	short $+2
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1
		dec	bx
		sub	cx, 50h
		jnz	short loc_1D185
		call	sub_1E92E
		retn
; ---------------------------------------------------------------------------

mdr02_05:				; CODE XREF: mdrGraphicEffect+31j
		mov	ax, cs
		mov	ds, ax
		mov	si, offset vdfHeaderData
		call	Palette_Refresh
		call	SetIO_A4_00
		call	SetIO_A6_01
		mov	cx, 500h
		mov	di, 3DE0h

loc_1D1D3:				; CODE XREF: mdrGraphicEffect+5B8j
		sub	di, di
		push	cx
		push	di
		call	sub_1D435
		push	ax

loc_1D1DB:				; CODE XREF: mdrGraphicEffect+585j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1D1DB

loc_1D1E1:				; CODE XREF: mdrGraphicEffect+58Bj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1D1E1
		pop	ax
		push	ax

loc_1D1E9:				; CODE XREF: mdrGraphicEffect+593j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1D1E9

loc_1D1EF:				; CODE XREF: mdrGraphicEffect+599j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1D1EF
		pop	ax
		push	ax

loc_1D1F7:				; CODE XREF: mdrGraphicEffect+5A1j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1D1F7

loc_1D1FD:				; CODE XREF: mdrGraphicEffect+5A7j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1D1FD
		pop	ax
		call	sub_1E917
		call	sub_1E92E
		pop	di
		pop	cx
		sub	cx, 50h	; 'P'
		cmp	cx, 0
		jnz	short loc_1D1D3
		retn
; ---------------------------------------------------------------------------

mdr02_04:				; CODE XREF: mdrGraphicEffect+29j
		mov	ah, 41h	; 'A'
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		jmp	short $+2
		call	SetIO_A6_01
		mov	cx, 500h
		mov	di, 0
		call	sub_1D435
		mov	cx, 280h
		mov	di, 7D0h
		call	sub_1D435
		mov	cx, 140h
		mov	di, 1770h
		call	sub_1D435
		mov	cx, 0A0h ; '†'
		mov	di, 36B0h
		call	sub_1D435
		call	SetIO_A6_00
		mov	cx, 50h	; 'P'
		mov	di, 0
		call	sub_1D435
		push	ax

loc_1D24F:				; CODE XREF: mdrGraphicEffect+5F9j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1D24F

loc_1D255:				; CODE XREF: mdrGraphicEffect+5FFj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1D255
		pop	ax
		push	ax

loc_1D25D:				; CODE XREF: mdrGraphicEffect+607j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1D25D

loc_1D263:				; CODE XREF: mdrGraphicEffect+60Dj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1D263
		pop	ax
		push	ax

loc_1D26B:				; CODE XREF: mdrGraphicEffect+615j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1D26B

loc_1D271:				; CODE XREF: mdrGraphicEffect+61Bj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1D271
		pop	ax
		push	ax

loc_1D279:				; CODE XREF: mdrGraphicEffect+623j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1D279

loc_1D27F:				; CODE XREF: mdrGraphicEffect+629j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1D27F
		pop	ax
		mov	ah, 40h	; '@'
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		jmp	short $+2
		call	SetIO_A4_01
		mov	bx, 0
		call	sub_1D3E1
		jmp	short $+2
		jmp	short $+2
		mov	al, 4Bh	; 'K'
		out	0A2h, al	; Interrupt Controller #2, 8259A
		mov	al, 0Fh
		jmp	short $+2
		jmp	short $+2
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1
		push	ax

loc_1D2A6:				; CODE XREF: mdrGraphicEffect+650j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1D2A6

loc_1D2AC:				; CODE XREF: mdrGraphicEffect+656j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1D2AC
		pop	ax
		push	ax

loc_1D2B4:				; CODE XREF: mdrGraphicEffect+65Ej
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1D2B4

loc_1D2BA:				; CODE XREF: mdrGraphicEffect+664j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1D2BA
		pop	ax
		push	ax

loc_1D2C2:				; CODE XREF: mdrGraphicEffect+66Cj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1D2C2

loc_1D2C8:				; CODE XREF: mdrGraphicEffect+672j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1D2C8
		pop	ax
		push	ax

loc_1D2D0:				; CODE XREF: mdrGraphicEffect+67Aj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1D2D0

loc_1D2D6:				; CODE XREF: mdrGraphicEffect+680j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1D2D6
		pop	ax
		mov	bx, 19h
		call	sub_1D3E1
		jmp	short $+2
		jmp	short $+2
		mov	al, 4Bh	; 'K'
		out	0A2h, al	; Interrupt Controller #2, 8259A
		mov	al, 7
		jmp	short $+2
		jmp	short $+2
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1
		push	ax

loc_1D2F4:				; CODE XREF: mdrGraphicEffect+69Ej
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1D2F4

loc_1D2FA:				; CODE XREF: mdrGraphicEffect+6A4j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1D2FA
		pop	ax
		push	ax

loc_1D302:				; CODE XREF: mdrGraphicEffect+6ACj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1D302

loc_1D308:				; CODE XREF: mdrGraphicEffect+6B2j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1D308
		pop	ax
		push	ax

loc_1D310:				; CODE XREF: mdrGraphicEffect+6BAj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1D310

loc_1D316:				; CODE XREF: mdrGraphicEffect+6C0j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1D316
		pop	ax
		push	ax

loc_1D31E:				; CODE XREF: mdrGraphicEffect+6C8j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1D31E

loc_1D324:				; CODE XREF: mdrGraphicEffect+6CEj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1D324
		pop	ax
		mov	bx, 4Bh	; 'K'
		call	sub_1D3E1
		jmp	short $+2
		jmp	short $+2
		mov	al, 4Bh	; 'K'
		out	0A2h, al	; Interrupt Controller #2, 8259A
		mov	al, 3
		jmp	short $+2
		jmp	short $+2
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1
		push	ax

loc_1D342:				; CODE XREF: mdrGraphicEffect+6ECj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1D342

loc_1D348:				; CODE XREF: mdrGraphicEffect+6F2j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1D348
		pop	ax
		push	ax

loc_1D350:				; CODE XREF: mdrGraphicEffect+6FAj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1D350

loc_1D356:				; CODE XREF: mdrGraphicEffect+700j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1D356
		pop	ax
		push	ax

loc_1D35E:				; CODE XREF: mdrGraphicEffect+708j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1D35E

loc_1D364:				; CODE XREF: mdrGraphicEffect+70Ej
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1D364
		pop	ax
		push	ax

loc_1D36C:				; CODE XREF: mdrGraphicEffect+716j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1D36C

loc_1D372:				; CODE XREF: mdrGraphicEffect+71Cj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1D372
		pop	ax
		mov	bx, 0AFh ; 'Ø'
		call	sub_1D3E1
		jmp	short $+2
		jmp	short $+2
		mov	al, 4Bh	; 'K'
		out	0A2h, al	; Interrupt Controller #2, 8259A
		mov	al, 1
		jmp	short $+2
		jmp	short $+2
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1
		push	ax

loc_1D390:				; CODE XREF: mdrGraphicEffect+73Aj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1D390

loc_1D396:				; CODE XREF: mdrGraphicEffect+740j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1D396
		pop	ax
		push	ax

loc_1D39E:				; CODE XREF: mdrGraphicEffect+748j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1D39E

loc_1D3A4:				; CODE XREF: mdrGraphicEffect+74Ej
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1D3A4
		pop	ax
		push	ax

loc_1D3AC:				; CODE XREF: mdrGraphicEffect+756j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1D3AC

loc_1D3B2:				; CODE XREF: mdrGraphicEffect+75Cj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1D3B2
		pop	ax
		push	ax

loc_1D3BA:				; CODE XREF: mdrGraphicEffect+764j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1D3BA

loc_1D3C0:				; CODE XREF: mdrGraphicEffect+76Aj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1D3C0
		pop	ax
		call	SetIO_A4_00
		mov	bx, 0
		call	sub_1D3E1
		jmp	short $+2
		jmp	short $+2
		mov	al, 4Bh	; 'K'
		out	0A2h, al	; Interrupt Controller #2, 8259A
		mov	al, 0
		jmp	short $+2
		jmp	short $+2
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1
		retn
; END OF FUNCTION CHUNK	FOR mdrGraphicEffect

; =============== S U B	R O U T	I N E =======================================


sub_1D3E1	proc near		; CODE XREF: mdrGraphicEffect+638p
					; mdrGraphicEffect+686p ...
		mov	dx, 190h
		sub	bx, dx
		sbb	ax, ax
		and	bx, ax
		add	bx, dx
		sub	dx, bx
		mov	bp, bx
		mov	cx, 1
		shl	bx, 1
		shl	dx, 1
		mov	cl, 4

loc_1D3F9:				; CODE XREF: sub_1D3E1+1Ej
		jmp	short $+2
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 4
		jz	short loc_1D3F9
		mov	al, 70h	; 'p'
		out	0A2h, al	; Interrupt Controller #2, 8259A
		mov	ax, bp
		shl	ax, 2
		add	ax, bp
		shl	ax, 3
		call	sub_1D428
		mov	ax, dx
		shl	ax, 4
		call	sub_1D428
		sub	ax, ax
		call	sub_1D428
		mov	ax, bx
		shl	ax, 4
		call	sub_1D428
		retn
sub_1D3E1	endp


; =============== S U B	R O U T	I N E =======================================


sub_1D428	proc near		; CODE XREF: sub_1D3E1+2Ep
					; sub_1D3E1+36p ...
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1
		mov	al, ah
		jmp	short $+2
		jmp	short $+2
		jmp	short $+2
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1
		retn
sub_1D428	endp


; =============== S U B	R O U T	I N E =======================================


sub_1D435	proc near		; CODE XREF: mdrGraphicEffect+4D0p
					; mdrGraphicEffect+530p ...
		mov	bx, 7D00h
		mov	si, 0

loc_1D43B:				; CODE XREF: sub_1D435+69j
		push	cx
		push	dx
		push	bx
		cld
		mov	ds, cs:word_1DD48
		assume ds:nothing
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		push	si
		push	di
		mov	cx, 28h	; '('
		rep movsw
		pop	di
		pop	si
		mov	ds, cs:word_1DD4A
		mov	ax, 0B000h
		mov	es, ax
		assume es:nothing
		push	si
		push	di
		mov	cx, 28h	; '('
		rep movsw
		pop	di
		pop	si
		mov	ds, cs:word_1DD4C
		mov	ax, 0B800h
		mov	es, ax
		assume es:nothing
		push	si
		push	di
		mov	cx, 28h	; '('
		rep movsw
		pop	di
		pop	si
		mov	ds, cs:word_1DD4E
		mov	ax, 0E000h
		mov	es, ax
		assume es:nothing
		push	si
		push	di
		mov	cx, 28h	; '('
		rep movsw
		pop	di
		pop	si
		pop	bx
		pop	dx
		pop	cx
		add	di, 50h	; 'P'
		add	si, cx
		sub	bx, cx
		cmp	bx, 0
		jz	short locret_1D4A0
		cmp	bx, 7D00h
		jb	short loc_1D43B

locret_1D4A0:				; CODE XREF: sub_1D435+63j
		retn
sub_1D435	endp

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR mdrGraphicEffect

mdr02_03:				; CODE XREF: mdrGraphicEffect+21j
		mov	cs:word_1D583, 1

loc_1D4A8:				; CODE XREF: mdrGraphicEffect+87Bj
		sub	si, si
		mov	cx, cs:word_1D583
		push	ax

loc_1D4B0:				; CODE XREF: mdrGraphicEffect+85Aj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1D4B0

loc_1D4B6:				; CODE XREF: mdrGraphicEffect+860j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1D4B6
		pop	ax

loc_1D4BD:				; CODE XREF: mdrGraphicEffect+86Dj
		push	cx
		call	sub_1D507
		pop	cx
		add	si, 0A0h ; '†'
		inc	bp
		loop	loc_1D4BD
		inc	cs:word_1D583
		cmp	cs:word_1D583, 0C8h ; '»'
		jnz	short loc_1D4A8

loc_1D4D7:				; CODE XREF: mdrGraphicEffect+8A8j
		sub	si, si
		mov	cx, 0C8h ; '»'
		push	ax

loc_1D4DD:				; CODE XREF: mdrGraphicEffect+887j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1D4DD

loc_1D4E3:				; CODE XREF: mdrGraphicEffect+88Dj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1D4E3
		pop	ax

loc_1D4EA:				; CODE XREF: mdrGraphicEffect+89Aj
		push	cx
		call	sub_1D507
		pop	cx
		add	si, 0A0h ; '†'
		inc	bp
		loop	loc_1D4EA
		inc	cs:word_1D583
		cmp	cs:word_1D583, 190h
		jnz	short loc_1D4D7
		jmp	mdr02_bad
; END OF FUNCTION CHUNK	FOR mdrGraphicEffect

; =============== S U B	R O U T	I N E =======================================


sub_1D507	proc near		; CODE XREF: mdrGraphicEffect+864p
					; mdrGraphicEffect+891p
		push	bp
		shl	bp, 1
		mov	di, si
		mov	cx, cs:[bp+0]
		cmp	cx, 0
		jz	short loc_1D557
		sub	cx, 2
		mov	cs:[bp+0], cx
		mov	ax, cx
		mov	cx, 28h	; '('
		sub	cx, ax
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		mov	ds, cs:word_1DD48
		call	sub_1D559
		mov	ax, 0B000h
		mov	es, ax
		assume es:nothing
		mov	ds, cs:word_1DD4A
		call	sub_1D559
		mov	ax, 0B800h
		mov	es, ax
		assume es:nothing
		mov	ds, cs:word_1DD4C
		call	sub_1D559
		mov	ax, 0E000h
		mov	es, ax
		assume es:nothing
		mov	ds, cs:word_1DD4E
		call	sub_1D559

loc_1D557:				; CODE XREF: sub_1D507+Cj
		pop	bp
		retn
sub_1D507	endp


; =============== S U B	R O U T	I N E =======================================


sub_1D559	proc near		; CODE XREF: sub_1D507+26p
					; sub_1D507+33p ...
		push	si
		push	di
		mov	dx, cx
		shl	dx, 1
		mov	bx, si
		mov	si, bx
		mov	di, bx
		add	si, 50h
		mov	bx, si
		sub	si, dx
		cld
		push	cx
		rep movsw
		pop	cx
		mov	si, bx
		mov	di, bx
		add	di, 50h
		mov	bx, di
		sub	di, dx
		push	cx
		rep movsw
		pop	cx
		pop	di
		pop	si
		retn
sub_1D559	endp

; ---------------------------------------------------------------------------
word_1D583	dw 1			; DATA XREF: mdrGraphicEffect:mdr02_03w
					; mdrGraphicEffect+850r ...
		align 2
; START	OF FUNCTION CHUNK FOR mdrGraphicEffect

mdr02_02_ShowVDF:			; CODE XREF: mdrGraphicEffect+19j
		mov	ax, cs		; includes a transition	effect
		mov	ds, ax
		assume ds:seg000
		mov	si, offset vdfHeaderData
		call	Palette_Refresh
		sub	si, si
		mov	cx, 40		; effect duration: 40 frames

loc_1D595:				; CODE XREF: mdrGraphicEffect+9B0j
		push	cx
		push	si
		push	ax

loc_1D598:				; CODE XREF: mdrGraphicEffect+942j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1D598

loc_1D59E:				; CODE XREF: mdrGraphicEffect+948j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1D59E
		pop	ax
		mov	cx, 400		; 400 lines on the screen

loc_1D5A8:				; CODE XREF: mdrGraphicEffect+9A9j
		push	cx
		mov	di, si
		mov	ax, 8
		call	GetRandomInRange
		add	ax, 2
		mov	cx, ax
		cld
		mov	ds, cs:word_1DD48
		assume ds:nothing
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		push	cx
		push	si
		push	di
		rep movsw
		pop	di
		pop	si
		pop	cx
		mov	ds, cs:word_1DD4A
		mov	ax, 0B000h
		mov	es, ax
		assume es:nothing
		push	cx
		push	si
		push	di
		rep movsw
		pop	di
		pop	si
		pop	cx
		mov	ds, cs:word_1DD4C
		mov	ax, 0B800h
		mov	es, ax
		assume es:nothing
		push	cx
		push	si
		push	di
		rep movsw
		pop	di
		pop	si
		pop	cx
		mov	ds, cs:word_1DD4E
		mov	ax, 0E000h
		mov	es, ax
		assume es:nothing
		push	cx
		push	si
		push	di
		rep movsw
		pop	di
		pop	si
		pop	cx
		pop	cx
		add	si, 50h
		loop	loc_1D5A8
		pop	si
		pop	cx
		add	si, 4
		loop	loc_1D595
		jmp	mdr02_bad
; ---------------------------------------------------------------------------

mdr02_01:				; CODE XREF: mdrGraphicEffect+11j
		mov	ax, cs
		mov	ds, ax
		assume ds:seg000
		mov	si, offset vdfHeaderData
		call	Palette_Refresh
		mov	bx, 0FA0h
		shr	bx, 4
		inc	bx
		mov	ah, 48h
		int	21h		; DOS -	2+ - ALLOCATE MEMORY
					; BX = number of 16-byte paragraphs desired
		jnb	short loc_1D629
		jmp	loc_1D938
; ---------------------------------------------------------------------------

loc_1D629:				; CODE XREF: mdrGraphicEffect+9CAj
		mov	cs:word_1D93B, ax
		mov	es, ax
		assume es:nothing
		sub	di, di
		mov	cx, 7D0h
		sub	ax, ax
		cld
		rep stosw
		mov	cx, 99

loc_1D63C:				; CODE XREF: mdrGraphicEffect:loc_1D7C4j
		push	cx
		push	ax

loc_1D63E:				; CODE XREF: mdrGraphicEffect+9E8j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1D63E

loc_1D644:				; CODE XREF: mdrGraphicEffect+9EEj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1D644
		pop	ax
		mov	cx, 40

loc_1D64E:				; CODE XREF: mdrGraphicEffect:loc_1D7BCj
		push	cx

loc_1D64F:				; CODE XREF: mdrGraphicEffect+A2Dj
		sub	ax, ax
		mov	es, ax
		assume es:nothing
		mov	bx, 52Ah
		test	byte ptr es:[bx], 1
		jz	short loc_1D661
		pop	cx
		pop	cx
		jmp	loc_1D7C7
; ---------------------------------------------------------------------------

loc_1D661:				; CODE XREF: mdrGraphicEffect+A00j
		mov	ax, 80
		call	GetRandomInRange
		mov	cx, ax
		mov	ax, 50
		call	GetRandomInRange
		mov	dx, ax
		mov	di, dx
		shl	di, 2
		add	di, dx
		shl	di, 4
		mov	ax, cx
		add	di, ax
		mov	ds, cs:word_1D93B
		assume ds:nothing
		cmp	byte ptr [di], 0
		jnz	short loc_1D64F
		mov	byte ptr [di], 1
		shl	dx, 3
		mov	di, dx
		shl	di, 2
		add	di, dx
		shl	di, 4
		mov	ax, cx
		add	di, ax
		mov	si, di
		mov	ds, cs:word_1DD48
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		push	si
		push	di
		movsb
		add	si, 4Fh
		add	di, 4Fh
		movsb
		add	si, 4Fh
		add	di, 4Fh
		movsb
		add	si, 4Fh
		add	di, 4Fh
		movsb
		add	si, 4Fh
		add	di, 4Fh
		movsb
		add	si, 4Fh
		add	di, 4Fh
		movsb
		add	si, 4Fh
		add	di, 4Fh
		movsb
		add	si, 4Fh
		add	di, 4Fh
		movsb
		add	si, 4Fh
		add	di, 4Fh
		pop	di
		pop	si
		mov	ds, cs:word_1DD4A
		mov	ax, 0B000h
		mov	es, ax
		assume es:nothing
		push	si
		push	di
		movsb
		add	si, 4Fh
		add	di, 4Fh
		movsb
		add	si, 4Fh
		add	di, 4Fh
		movsb
		add	si, 4Fh
		add	di, 4Fh
		movsb
		add	si, 4Fh
		add	di, 4Fh
		movsb
		add	si, 4Fh
		add	di, 4Fh
		movsb
		add	si, 4Fh
		add	di, 4Fh
		movsb
		add	si, 4Fh
		add	di, 4Fh
		movsb
		add	si, 4Fh
		add	di, 4Fh
		pop	di
		pop	si
		mov	ds, cs:word_1DD4C
		mov	ax, 0B800h
		mov	es, ax
		assume es:nothing
		push	si
		push	di
		movsb
		add	si, 4Fh
		add	di, 4Fh
		movsb
		add	si, 4Fh
		add	di, 4Fh
		movsb
		add	si, 4Fh
		add	di, 4Fh
		movsb
		add	si, 4Fh
		add	di, 4Fh
		movsb
		add	si, 4Fh
		add	di, 4Fh
		movsb
		add	si, 4Fh
		add	di, 4Fh
		movsb
		add	si, 4Fh
		add	di, 4Fh
		movsb
		add	si, 4Fh
		add	di, 4Fh
		pop	di
		pop	si
		mov	ds, cs:word_1DD4E
		mov	ax, 0E000h
		mov	es, ax
		assume es:nothing
		push	si
		push	di
		movsb
		add	si, 4Fh
		add	di, 4Fh
		movsb
		add	si, 4Fh
		add	di, 4Fh
		movsb
		add	si, 4Fh
		add	di, 4Fh
		movsb
		add	si, 4Fh
		add	di, 4Fh
		movsb
		add	si, 4Fh
		add	di, 4Fh
		movsb
		add	si, 4Fh
		add	di, 4Fh
		movsb
		add	si, 4Fh
		add	di, 4Fh
		movsb
		add	si, 4Fh
		add	di, 4Fh
		pop	di
		pop	si
		pop	cx
		loop	loc_1D7BC
		jmp	short loc_1D7BF
; ---------------------------------------------------------------------------

loc_1D7BC:				; CODE XREF: mdrGraphicEffect+B5Ej
		jmp	loc_1D64E
; ---------------------------------------------------------------------------

loc_1D7BF:				; CODE XREF: mdrGraphicEffect+B60j
		pop	cx
		loop	loc_1D7C4
		jmp	short loc_1D7C7
; ---------------------------------------------------------------------------

loc_1D7C4:				; CODE XREF: mdrGraphicEffect+B66j
		jmp	loc_1D63C
; ---------------------------------------------------------------------------

loc_1D7C7:				; CODE XREF: mdrGraphicEffect+A04j
					; mdrGraphicEffect+B68j
		mov	cx, 80

loc_1D7CA:				; CODE XREF: mdrGraphicEffect:loc_1D923j
		push	cx
		dec	cx
		mov	dx, 50

loc_1D7CF:				; CODE XREF: mdrGraphicEffect+CC1j
		push	dx
		dec	dx
		mov	di, dx
		shl	di, 2
		add	di, dx
		shl	di, 4
		mov	ax, cx
		add	di, ax
		mov	ds, cs:word_1D93B
		cmp	byte ptr [di], 0
		jz	short loc_1D7EC
		jmp	loc_1D917
; ---------------------------------------------------------------------------

loc_1D7EC:				; CODE XREF: mdrGraphicEffect+B8Dj
		shl	dx, 3
		mov	di, dx
		shl	di, 2
		add	di, dx
		shl	di, 4
		mov	ax, cx
		add	di, ax
		mov	si, di
		mov	ds, cs:word_1DD48
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		push	si
		push	di
		movsb
		add	si, 4Fh
		add	di, 4Fh
		movsb
		add	si, 4Fh
		add	di, 4Fh
		movsb
		add	si, 4Fh
		add	di, 4Fh
		movsb
		add	si, 4Fh
		add	di, 4Fh
		movsb
		add	si, 4Fh
		add	di, 4Fh
		movsb
		add	si, 4Fh
		add	di, 4Fh
		movsb
		add	si, 4Fh
		add	di, 4Fh
		movsb
		add	si, 4Fh
		add	di, 4Fh
		pop	di
		pop	si
		mov	ds, cs:word_1DD4A
		mov	ax, 0B000h
		mov	es, ax
		assume es:nothing
		push	si
		push	di
		movsb
		add	si, 4Fh
		add	di, 4Fh
		movsb
		add	si, 4Fh
		add	di, 4Fh
		movsb
		add	si, 4Fh
		add	di, 4Fh
		movsb
		add	si, 4Fh
		add	di, 4Fh
		movsb
		add	si, 4Fh
		add	di, 4Fh
		movsb
		add	si, 4Fh
		add	di, 4Fh
		movsb
		add	si, 4Fh
		add	di, 4Fh
		movsb
		add	si, 4Fh
		add	di, 4Fh
		pop	di
		pop	si
		mov	ds, cs:word_1DD4C
		mov	ax, 0B800h
		mov	es, ax
		assume es:nothing
		push	si
		push	di
		movsb
		add	si, 4Fh
		add	di, 4Fh
		movsb
		add	si, 4Fh
		add	di, 4Fh
		movsb
		add	si, 4Fh
		add	di, 4Fh
		movsb
		add	si, 4Fh
		add	di, 4Fh
		movsb
		add	si, 4Fh
		add	di, 4Fh
		movsb
		add	si, 4Fh
		add	di, 4Fh
		movsb
		add	si, 4Fh
		add	di, 4Fh
		movsb
		add	si, 4Fh
		add	di, 4Fh
		pop	di
		pop	si
		mov	ds, cs:word_1DD4E
		mov	ax, 0E000h
		mov	es, ax
		assume es:nothing
		push	si
		push	di
		movsb
		add	si, 4Fh
		add	di, 4Fh
		movsb
		add	si, 4Fh
		add	di, 4Fh
		movsb
		add	si, 4Fh
		add	di, 4Fh
		movsb
		add	si, 4Fh
		add	di, 4Fh
		movsb
		add	si, 4Fh
		add	di, 4Fh
		movsb
		add	si, 4Fh
		add	di, 4Fh
		movsb
		add	si, 4Fh
		add	di, 4Fh
		movsb
		add	si, 4Fh
		add	di, 4Fh
		pop	di
		pop	si

loc_1D917:				; CODE XREF: mdrGraphicEffect+B8Fj
		pop	dx
		dec	dx
		jz	short loc_1D91E
		jmp	loc_1D7CF
; ---------------------------------------------------------------------------

loc_1D91E:				; CODE XREF: mdrGraphicEffect+CBFj
		pop	cx
		loop	loc_1D923
		jmp	short loc_1D926
; ---------------------------------------------------------------------------

loc_1D923:				; CODE XREF: mdrGraphicEffect+CC5j
		jmp	loc_1D7CA
; ---------------------------------------------------------------------------

loc_1D926:				; CODE XREF: mdrGraphicEffect+CC7j
		mov	ds, cs:word_1D93B
		push	es
		mov	ax, ds
		mov	es, ax
		assume es:nothing
		mov	ah, 49h
		int	21h		; DOS -	2+ - FREE MEMORY
					; ES = segment address of area to be freed
		pop	es
		jmp	short $+2

mdr02_bad:				; CODE XREF: mdrGraphicEffect+86j
					; mdrGraphicEffect+8AAj ...
		retn
; ---------------------------------------------------------------------------

loc_1D938:				; CODE XREF: mdrGraphicEffect+9CCj
		stc
		jmp	short mdr02_bad
; END OF FUNCTION CHUNK	FOR mdrGraphicEffect
; ---------------------------------------------------------------------------
word_1D93B	dw 0			; DATA XREF: mdrGraphicEffect:loc_1D629w
					; mdrGraphicEffect+A25r ...

; =============== S U B	R O U T	I N E =======================================


LoadGFXData	proc near		; CODE XREF: DoOneLevel+8Fp
					; DoOneLevel+127p ...
		cmp	byte ptr [si], 'L'
		jz	short loc_1D94F
		cmp	byte ptr [si], 'V'
		jz	short loc_1D966
		cmp	byte ptr [si], 'M'
		jz	short loc_1D97D
		jmp	loc_1D9FD
; ---------------------------------------------------------------------------

loc_1D94F:				; CODE XREF: LoadGFXData+3j
		mov	cs:word_1DD74, 0
		mov	cs:word_1DD76, 1
		mov	cs:word_1DD78, 0
		jmp	short loc_1D994
; ---------------------------------------------------------------------------

loc_1D966:				; CODE XREF: LoadGFXData+8j
		mov	cs:word_1DD74, 1
		mov	cs:word_1DD76, 0
		mov	cs:word_1DD78, 0
		jmp	short loc_1D994
; ---------------------------------------------------------------------------

loc_1D97D:				; CODE XREF: LoadGFXData+Dj
		mov	cs:word_1DD74, 0
		mov	cs:word_1DD76, 0
		mov	cs:word_1DD78, 1
		jmp	short $+2

loc_1D994:				; CODE XREF: LoadGFXData+27j
					; LoadGFXData+3Ej
		inc	si
		cmp	byte ptr [si], 'D'
		jnz	short loc_1D9FD
		inc	si
		cmp	byte ptr [si], 'F'
		jnz	short loc_1D9FD
		cmp	cs:word_1DD74, 1
		jz	short loc_1D9BA
		cmp	cs:word_1DD76, 1
		jz	short loc_1D9BC
		cmp	cs:word_1DD78, 1
		jz	short loc_1D9BE
		jmp	short loc_1D9FD
; ---------------------------------------------------------------------------

loc_1D9BA:				; CODE XREF: LoadGFXData+69j
		jmp	short loc_1D9C0
; ---------------------------------------------------------------------------

loc_1D9BC:				; CODE XREF: LoadGFXData+71j
		jmp	short loc_1D9C0
; ---------------------------------------------------------------------------

loc_1D9BE:				; CODE XREF: LoadGFXData+79j
		jmp	short $+2

loc_1D9C0:				; CODE XREF: LoadGFXData:loc_1D9BAj
					; LoadGFXData:loc_1D9BCj
		inc	si
		inc	si
		push	si
		push	ds
		mov	si, 4
		mov	di, offset vdfHeaderData
		mov	ax, cs
		mov	es, ax
		assume es:seg000
		mov	cx, 30h
		rep movsw
		pop	ds
		pop	si
		add	si, 60h
		cmp	cs:word_1DD76, 1
		jz	short loc_1D9EC
		cmp	cs:word_1DD78, 1
		jz	short loc_1D9F3
		xor	di, di
		jmp	short loc_1D9F7
; ---------------------------------------------------------------------------

loc_1D9EC:				; CODE XREF: LoadGFXData+A1j
		xor	di, di
		call	sub_1DAF2
		jmp	short loc_1D9F7
; ---------------------------------------------------------------------------

loc_1D9F3:				; CODE XREF: LoadGFXData+A9j
		xor	di, di
		xor	di, di

loc_1D9F7:				; CODE XREF: LoadGFXData+ADj
					; LoadGFXData+B4j
		push	si
		push	ds
		pop	ds
		pop	si
		jmp	short locret_1D9FF
; ---------------------------------------------------------------------------

loc_1D9FD:				; CODE XREF: LoadGFXData+Fj
					; LoadGFXData+5Bj ...
		jmp	short $+2

locret_1D9FF:				; CODE XREF: LoadGFXData+BEj
		retn
LoadGFXData	endp


; =============== S U B	R O U T	I N E =======================================


sub_1DA00	proc near		; CODE XREF: DoOneLevel+7Dp
					; sub_1C058+47p ...
		push	es
		push	ds
		pusha
		mov	bx, 8000h
		shr	bx, 4
		inc	bx
		mov	ah, 48h
		int	21h		; DOS -	2+ - ALLOCATE MEMORY
					; BX = number of 16-byte paragraphs desired
		jb	short loc_1DA4C
		mov	cs:word_1DD48, ax
		mov	bx, 8000h
		shr	bx, 4
		inc	bx
		mov	ah, 48h
		int	21h		; DOS -	2+ - ALLOCATE MEMORY
					; BX = number of 16-byte paragraphs desired
		jb	short loc_1DA4C
		mov	cs:word_1DD4A, ax
		mov	bx, 8000h
		shr	bx, 4
		inc	bx
		mov	ah, 48h
		int	21h		; DOS -	2+ - ALLOCATE MEMORY
					; BX = number of 16-byte paragraphs desired
		jb	short loc_1DA4C
		mov	cs:word_1DD4C, ax
		mov	bx, 8000h
		shr	bx, 4
		inc	bx
		mov	ah, 48h
		int	21h		; DOS -	2+ - ALLOCATE MEMORY
					; BX = number of 16-byte paragraphs desired
		jb	short loc_1DA4C
		mov	cs:word_1DD4E, ax
		clc

loc_1DA48:				; CODE XREF: sub_1DA00+4Dj
		popa
		pop	ds
		pop	es
		assume es:nothing
		retn
; ---------------------------------------------------------------------------

loc_1DA4C:				; CODE XREF: sub_1DA00+Ej
					; sub_1DA00+1Fj ...
		stc
		jmp	short loc_1DA48
sub_1DA00	endp


; =============== S U B	R O U T	I N E =======================================


sub_1DA4F	proc near		; CODE XREF: DoOneLevel+D4p
					; sub_1C058:loc_1C0C4p	...
		push	es
		push	ds
		pusha
		mov	ds, cs:word_1DD4E
		push	es
		mov	ax, ds
		mov	es, ax
		mov	ah, 49h
		int	21h		; DOS -	2+ - FREE MEMORY
					; ES = segment address of area to be freed
		pop	es
		mov	cs:word_1DD4E, 0E000h
		mov	ds, cs:word_1DD4C
		push	es
		mov	ax, ds
		mov	es, ax
		mov	ah, 49h
		int	21h		; DOS -	2+ - FREE MEMORY
					; ES = segment address of area to be freed
		pop	es
		mov	cs:word_1DD4C, 0B800h
		mov	ds, cs:word_1DD4A
		push	es
		mov	ax, ds
		mov	es, ax
		mov	ah, 49h
		int	21h		; DOS -	2+ - FREE MEMORY
					; ES = segment address of area to be freed
		pop	es
		mov	cs:word_1DD4A, 0B000h
		mov	ds, cs:word_1DD48
		push	es
		mov	ax, ds
		mov	es, ax
		mov	ah, 49h
		int	21h		; DOS -	2+ - FREE MEMORY
					; ES = segment address of area to be freed
		pop	es
		mov	cs:word_1DD48, 0A800h
		clc

loc_1DAAB:				; CODE XREF: seg000:DAB0j
		popa
		pop	ds
		pop	es
		retn
sub_1DA4F	endp

; ---------------------------------------------------------------------------
		stc
		jmp	short loc_1DAAB

; =============== S U B	R O U T	I N E =======================================


sub_1DAB2	proc near		; CODE XREF: sub_1DAF2+5p
		push	ax
		push	cx
		push	dx
		push	bx
		call	sub_1DC3D
		xor	ch, ch
		mov	cl, al
		call	sub_1DC3D
		mov	dl, al
		call	sub_1DC3D
		mov	dh, al
		mov	ax, dx
		shl	ax, 4
		mov	di, ax
		shl	di, 2
		add	di, ax
		xor	ah, ah
		mov	ax, cx
		add	di, ax
		call	sub_1DAE1
		pop	bx
		pop	dx
		pop	cx
		pop	ax
		retn
sub_1DAB2	endp


; =============== S U B	R O U T	I N E =======================================


sub_1DAE1	proc near		; CODE XREF: sub_1DAB2+27p
		push	bx
		mov	bx, offset byte_1DD54
		mov	cs:[bx], cx
		mov	cs:[bx+2], dx
		mov	cs:[bx+4], di
		pop	bx
		retn
sub_1DAE1	endp


; =============== S U B	R O U T	I N E =======================================


sub_1DAF2	proc near		; CODE XREF: LoadGFXData+B1p
		pusha
		push	es
		call	sub_1DBDA
		call	sub_1DAB2
		call	sub_1DC3D
		xor	ch, ch
		mov	cl, al
		mov	cs:word_1DD50, cx
		call	sub_1DC3D
		mov	dl, al
		call	sub_1DC3D
		mov	dh, al
		mov	cs:word_1DD52, dx
		call	sub_1DC3D
		xor	ah, ah
		mov	bp, ax
		mov	bx, 4Fh

loc_1DB1F:				; CODE XREF: sub_1DAF2+66j
		push	cx
		push	bp
		shr	bp, 1
		jnb	short loc_1DB2E
		mov	ax, cs:word_1DD48
		mov	es, ax
		call	sub_1DB60

loc_1DB2E:				; CODE XREF: sub_1DAF2+31j
		shr	bp, 1
		jnb	short loc_1DB3B
		mov	ax, cs:word_1DD4A
		mov	es, ax
		call	sub_1DB60

loc_1DB3B:				; CODE XREF: sub_1DAF2+3Ej
		shr	bp, 1
		jnb	short loc_1DB48
		mov	ax, cs:word_1DD4C
		mov	es, ax
		call	sub_1DB60

loc_1DB48:				; CODE XREF: sub_1DAF2+4Bj
		shr	bp, 1
		jnb	short loc_1DB55
		mov	ax, cs:word_1DD4E
		mov	es, ax
		call	sub_1DB60

loc_1DB55:				; CODE XREF: sub_1DAF2+58j
		inc	di
		pop	bp
		pop	cx
		loop	loc_1DB1F
		call	sub_1DBC0
		pop	es
		popa
		retn
sub_1DAF2	endp


; =============== S U B	R O U T	I N E =======================================


sub_1DB60	proc near		; CODE XREF: sub_1DAF2+39p
					; sub_1DAF2+46p ...
		push	di
		mov	cx, dx

loc_1DB63:				; CODE XREF: sub_1DB60:loc_1DB78j
		call	sub_1DC3D
		cmp	al, 5
		ja	short loc_1DB75
		jz	short loc_1DB94
		cmp	al, 3
		jb	short loc_1DB75
		jz	short loc_1DB7C
		call	sub_1DC3D

loc_1DB75:				; CODE XREF: sub_1DB60+8j sub_1DB60+Ej
		stosb
		add	di, bx

loc_1DB78:				; CODE XREF: sub_1DB60+32j
					; sub_1DB60+5Ej
		loop	loc_1DB63
		pop	di
		retn
; ---------------------------------------------------------------------------

loc_1DB7C:				; CODE XREF: sub_1DB60+10j
		xor	ah, ah
		call	sub_1DC3D
		dec	al
		inc	ax
		sub	cx, ax
		push	cx
		xchg	ax, cx
		call	sub_1DC3D

loc_1DB8B:				; CODE XREF: sub_1DB60+2Ej
		stosb
		add	di, bx
		loop	loc_1DB8B
		pop	cx
		inc	cx
		jmp	short loc_1DB78
; ---------------------------------------------------------------------------

loc_1DB94:				; CODE XREF: sub_1DB60+Aj
		xor	ah, ah
		call	sub_1DC3D
		dec	al
		inc	ax
		sub	cx, ax
		sub	cx, ax
		push	cx
		xchg	ax, cx
		push	dx
		call	sub_1DC3D
		mov	dl, al
		call	sub_1DC3D
		mov	ah, al
		mov	al, dl
		pop	dx

loc_1DBB0:				; CODE XREF: sub_1DB60+5Aj
		stosb
		add	di, bx
		xchg	ah, al
		stosb
		add	di, bx
		xchg	ah, al
		loop	loc_1DBB0
		pop	cx
		inc	cx
		jmp	short loc_1DB78
sub_1DB60	endp


; =============== S U B	R O U T	I N E =======================================


sub_1DBC0	proc near		; CODE XREF: sub_1DAF2+68p
		push	es
		cmp	cs:word_1DD0D, 0A100h
		jnz	short loc_1DBD8
		mov	ax, 0A100h
		mov	es, ax
		assume es:nothing
		xor	di, di
		mov	cx, 50h
		xor	ax, ax
		rep stosw

loc_1DBD8:				; CODE XREF: sub_1DBC0+8j
		pop	es
		assume es:nothing
		retn
sub_1DBC0	endp


; =============== S U B	R O U T	I N E =======================================


sub_1DBDA	proc near		; CODE XREF: sub_1DAF2+2p
		push	ds
		push	es
		push	ax
		push	bx
		push	cx
		push	dx
		push	di
		push	bp
		mov	es, cs:word_1DD0D
		assume es:nothing
		xor	di, di
		xor	ax, ax

loc_1DBEB:				; CODE XREF: sub_1DBDA+18j
		mov	cx, 0Dh
		rep stosb
		inc	al
		jnz	short loc_1DBEB

loc_1DBF4:				; CODE XREF: sub_1DBDA+1Dj
		stosb
		inc	al
		jnz	short loc_1DBF4

loc_1DBF9:				; CODE XREF: sub_1DBDA+22j
		dec	al
		stosb
		jnz	short loc_1DBF9
		mov	cx, 40h
		rep stosw
		mov	al, 20h
		mov	cx, 6Eh
		rep stosb
		mov	ds, cs:word_1DD0D
		assume ds:nothing
		mov	bp, di
		mov	dh, 80h
		xor	ah, ah
		add	si, 8
		mov	cs:word_1DC36, bx
		mov	cs:word_1DC38, dx
		mov	cs:word_1DC3A, bp
		mov	cs:byte_1DC3C, ah
		pop	bp
		pop	di
		pop	dx
		pop	cx
		pop	bx
		pop	ax
		pop	es
		assume es:nothing
		pop	ds
		assume ds:nothing
		retn
sub_1DBDA	endp

; ---------------------------------------------------------------------------
		align 2
word_1DC36	dw 0			; DATA XREF: sub_1DBDA+3Ew
					; sub_1DC3D+Ar	...
word_1DC38	dw 0			; DATA XREF: sub_1DBDA+43w
					; sub_1DC3D+Fr	...
word_1DC3A	dw 0			; DATA XREF: sub_1DBDA+48w
					; sub_1DC3D+14r ...
byte_1DC3C	db 0			; DATA XREF: sub_1DBDA+4Dw
					; sub_1DC3D+19r ...

; =============== S U B	R O U T	I N E =======================================


sub_1DC3D	proc near		; CODE XREF: sub_1DAB2+4p sub_1DAB2+Bp ...
		push	ds
		push	bx
		push	cx
		push	dx
		push	bp
		mov	cs:byte_1DCDA, ah
		mov	bx, cs:word_1DC36
		mov	dx, cs:word_1DC38
		mov	bp, cs:word_1DC3A
		mov	ah, cs:byte_1DC3C
		or	ah, ah
		jnz	short loc_1DCA4
		rol	dh, 1
		jnb	short loc_1DC66
		lodsb
		mov	dl, al

loc_1DC66:				; CODE XREF: sub_1DC3D+24j
		shr	dl, 1
		jnb	short loc_1DC98
		lodsb
		mov	ds, cs:word_1DD0D
		assume ds:nothing
		mov	ds:[bp+0], al
		inc	bp
		and	bp, 0FFFh
		mov	cs:word_1DC36, bx
		mov	cs:word_1DC38, dx
		mov	cs:word_1DC3A, bp
		mov	cs:byte_1DC3C, ah
		mov	ah, cs:byte_1DCDA
		pop	bp
		pop	dx
		pop	cx
		pop	bx
		pop	ds
		assume ds:nothing
		retn
; ---------------------------------------------------------------------------

loc_1DC98:				; CODE XREF: sub_1DC3D+2Bj
		lodsw
		mov	bx, ax
		shr	bh, 4
		and	ah, 0Fh
		add	ah, 3

loc_1DCA4:				; CODE XREF: sub_1DC3D+20j
		mov	ds, cs:word_1DD0D
		assume ds:nothing
		mov	al, [bx]
		inc	bx
		and	bx, 0FFFh
		mov	ds:[bp+0], al
		inc	bp
		and	bp, 0FFFh
		dec	ah
		mov	cs:word_1DC36, bx
		mov	cs:word_1DC38, dx
		mov	cs:word_1DC3A, bp
		mov	cs:byte_1DC3C, ah
		mov	ah, cs:byte_1DCDA
		pop	bp
		pop	dx
		pop	cx
		pop	bx
		pop	ds
		assume ds:nothing
		retn
sub_1DC3D	endp

; ---------------------------------------------------------------------------
byte_1DCDA	db 0			; DATA XREF: sub_1DC3D+5w
					; sub_1DC3D+50r ...
; ---------------------------------------------------------------------------
		mov	es, cs:word_1DD0D
		assume es:nothing
		xor	di, di
		xor	ax, ax

loc_1DCE4:				; CODE XREF: seg000:DCEBj
		mov	cx, 0Dh
		rep stosb
		inc	al
		jnz	short loc_1DCE4

loc_1DCED:				; CODE XREF: seg000:DCF0j
		stosb
		inc	al
		jnz	short loc_1DCED

loc_1DCF2:				; CODE XREF: seg000:DCF5j
		dec	al
		stosb
		jnz	short loc_1DCF2
		mov	cx, 40h	; '@'
		rep stosw
		mov	al, 20h	; ' '
		mov	cx, 6Eh	; 'n'
		rep stosb
		mov	bp, di
		mov	dh, 80h	; 'Ä'
		xor	ah, ah
		add	si, 8
		retn
; ---------------------------------------------------------------------------
word_1DD0D	dw 0A100h		; DATA XREF: sub_1DBC0+1r sub_1DBDA+8r ...
; ---------------------------------------------------------------------------
		or	ah, ah
		jnz	short loc_1DD35
		rol	dh, 1
		jnb	short loc_1DD1A
		lodsb
		mov	dl, al

loc_1DD1A:				; CODE XREF: seg000:DD15j
		shr	dl, 1
		jnb	short loc_1DD29
		lodsb
		mov	ds:[bp+0], al
		inc	bp
		and	bp, 0FFFh
		retn
; ---------------------------------------------------------------------------

loc_1DD29:				; CODE XREF: seg000:DD1Cj
		lodsw
		mov	bx, ax
		shr	bh, 4
		and	ah, 0Fh
		add	ah, 3

loc_1DD35:				; CODE XREF: seg000:DD11j
		mov	al, [bx]
		inc	bx
		and	bx, 0FFFh
		mov	ds:[bp+0], al
		inc	bp
		and	bp, 0FFFh
		dec	ah
		retn
; ---------------------------------------------------------------------------
word_1DD48	dw 0A800h		; DATA XREF: sub_1CEFA+9r sub_1D066+6r ...
word_1DD4A	dw 0B000h		; DATA XREF: sub_1CEFA+1Br
					; sub_1D066+19r ...
word_1DD4C	dw 0B800h		; DATA XREF: sub_1CEFA+2Dr
					; sub_1D066+2Cr ...
word_1DD4E	dw 0E000h		; DATA XREF: sub_1CEFA+3Fr
					; sub_1D066+3Fr ...
word_1DD50	dw 0			; DATA XREF: sub_1DAF2+Fw
word_1DD52	dw 0			; DATA XREF: sub_1DAF2+1Ew
byte_1DD54	db 20h dup(0)		; DATA XREF: sub_1DAE1+1o
word_1DD74	dw 0			; DATA XREF: LoadGFXData:loc_1D94Fw
					; LoadGFXData:loc_1D966w ...
word_1DD76	dw 0			; DATA XREF: LoadGFXData+19w
					; LoadGFXData+30w ...
word_1DD78	dw 0			; DATA XREF: LoadGFXData+20w
					; LoadGFXData+37w ...
vdfHeaderData	db 60h dup(0)		; DATA XREF: mdrGraphicEffect+5o
					; mdrGraphicEffect+8Do	...
		db    0
		db    0
		db    0
		db    0
mcd2_PosX	dw 0			; DATA XREF: ptx2DrawChar+31w
					; ptx2DrawChar+48r ...
mcd2_PosY	dw 0			; DATA XREF: ptx2DrawChar+36w
					; ptx2DrawChar+AFr
mcd2_ChrWidth	dw 0			; DATA XREF: ptx2DrawChar+3Bw
mcd2_ChrBytes	dw 0			; DATA XREF: ptx2DrawChar+40w
mcd2_PosXWrap	dw 0			; DATA XREF: ptx2DrawChar+4Fw
					; ptx2DrawChar+74w
		db 0Ah dup(0)
mdc2_XMin	dw 0			; DATA XREF: ptx2DrawChar+5Ar
					; ptx2DrawChar+61r
mdc2_XMax	dw 639			; DATA XREF: ptx2DrawChar:loc_1CAC0r
					; ptx2DrawChar+6Fr ...

; =============== S U B	R O U T	I N E =======================================


Palette_DoBlack	proc near		; CODE XREF: cmfA1B_PalFade+8p
					; mdrGraphicEffect+366p
		push	si
		push	ds
		mov	bp, 0FFFFh
		mov	bl, 0
		call	Palette_SetMult
		pop	ds
		pop	si
		retn
Palette_DoBlack	endp


; =============== S U B	R O U T	I N E =======================================


sub_1DE03	proc near		; CODE XREF: seg000:1E41p seg000:1E6Cp ...
		mov	ax, cs
		mov	ds, ax
		assume ds:seg000
		mov	si, 0E150h
		mov	bh, 10h
		mov	cx, 10h

loc_1DE0F:				; CODE XREF: sub_1DE03:loc_1DE6Cj
		mov	al, 10h
		sub	al, cl
		out	0A8h, al	; Interrupt Controller #2, 8259A
		lodsw
		shl	bp, 1
		jnb	short loc_1DE6C
		mov	dx, ax
		mov	ah, [si+5Eh]
		and	ax, 0F0Fh
		sub	ah, al
		xchg	ah, al
		mul	bl
		div	bh
		mov	ah, al
		mov	al, dl
		and	al, 0Fh
		add	al, ah
		out	0AEh, al	; Interrupt Controller #2, 8259A
		mov	al, dl
		mov	ah, [si+5Eh]
		shr	al, 4
		shr	ah, 4
		sub	ah, al
		xchg	ah, al
		mul	bl
		div	bh
		mov	ah, al
		mov	al, dl
		shr	al, 4
		add	al, ah
		out	0ACh, al	; Interrupt Controller #2, 8259A
		mov	al, dh
		mov	ah, [si+5Fh]
		and	ax, 0F0Fh
		sub	ah, al
		xchg	ah, al
		mul	bl
		div	bh
		mov	ah, al
		mov	al, dh
		and	al, 0Fh
		add	al, ah
		out	0AAh, al	; Interrupt Controller #2, 8259A

loc_1DE6C:				; CODE XREF: sub_1DE03+15j
		loop	loc_1DE0F
		retn
sub_1DE03	endp


; =============== S U B	R O U T	I N E =======================================


LoadVDFPalette	proc near		; CODE XREF: cmfA1D+5p
					; mdrGraphicEffect+8p ...

; FUNCTION CHUNK AT DFD4 SIZE 000000A8 BYTES

		mov	ax, cs
		mov	es, ax
		assume es:seg000
		mov	di, offset PaletteBuffer
		pusha
		push	ds
		push	es
		push	di
		mov	di, offset byte_1E0F0
		mov	cx, 30h		; 10h colours, 3 values	each
		mov	bx, offset PalIndexLUT
		cld

loc_1DE84:				; CODE XREF: LoadVDFPalette+24j
		push	si
		add	si, cs:[bx]
		add	bx, 2
		lodsw
		mov	cs:[di], ax
		add	di, 2
		pop	si
		loop	loc_1DE84
		pop	di
		mov	ax, cs
		mov	ds, ax
		mov	si, offset byte_1E0F0
		mov	cx, 10h

loc_1DEA0:				; CODE XREF: LoadVDFPalette:loc_1DF28j
		push	cx
		cmp	word ptr cs:[si+20h], 0
		jnz	short loc_1DEBA
		mov	ax, cs:[si+40h]
		mov	cs:byte_1E0E8, al
		mov	cs:byte_1E0E9, al
		mov	cs:byte_1E0EA, al
		jmp	short loc_1DF0B
; ---------------------------------------------------------------------------

loc_1DEBA:				; CODE XREF: LoadVDFPalette+37j
		mov	ax, [si+40h]
		mov	cs:byte_1E0EC, al
		mov	cl, al
		mov	ax, [si+20h]
		mul	cl
		mov	cl, 100
		div	cl
		mov	cs:byte_1E0EB, al
		mov	ah, cs:byte_1E0EC
		sub	ah, al
		mov	cs:byte_1E0ED, ah
		mov	ax, [si]
		mov	cx, 60
		div	cl
		mov	al, ah
		xor	ah, ah
		mov	ch, cs:byte_1E0EB
		mul	ch
		div	cl
		mov	cs:byte_1E0EE, al
		mov	ax, [si]
		mov	cx, 60
		div	cl
		mov	bl, al
		xor	bh, bh
		cmp	bx, 6
		jnb	short loc_1DF2E
		shl	bx, 1
		jmp	cs:off_1E07C[bx]
; ---------------------------------------------------------------------------

loc_1DF0B:				; CODE XREF: LoadVDFPalette+49j
					; LoadVDFPalette+17Ej ...
		mov	al, cs:byte_1E0E9
		call	sub_1DFC0
		mov	al, cs:byte_1E0E8
		call	sub_1DFC0
		mov	al, cs:byte_1E0EA
		call	sub_1DFC0
		pop	cx
		add	si, 2
		loop	loc_1DF28
		jmp	short loc_1DF2B
; ---------------------------------------------------------------------------

loc_1DF28:				; CODE XREF: LoadVDFPalette+B5j
		jmp	loc_1DEA0
; ---------------------------------------------------------------------------

loc_1DF2B:				; CODE XREF: LoadVDFPalette+B7j
		clc
		jmp	short loc_1DF30
; ---------------------------------------------------------------------------

loc_1DF2E:				; CODE XREF: LoadVDFPalette+93j
		stc
		pop	cx

loc_1DF30:				; CODE XREF: LoadVDFPalette+BDj
		mov	cx, 10h
		mov	si, 0E150h
		mov	di, 0E150h

loc_1DF39:				; CODE XREF: LoadVDFPalette+F4j
		mov	dl, cs:[si]
		mov	bl, cs:[si+1]
		mov	al, cs:[si+2]
		cmp	cs:word_1E9B6, 0
		jz	short loc_1DF4F
		call	sub_1DF69

loc_1DF4F:				; CODE XREF: LoadVDFPalette+DBj
		shl	bl, 4
		and	al, 0Fh
		or	al, bl
		mov	cs:[di], al
		mov	cs:[di+1], dl
		add	si, 3
		add	di, 2
		loop	loc_1DF39
		pop	es
		assume es:nothing
		pop	ds
		assume ds:nothing
		popa
		retn
LoadVDFPalette	endp


; =============== S U B	R O U T	I N E =======================================


sub_1DF69	proc near		; CODE XREF: LoadVDFPalette+DDp
		push	cx
		sub	cx, cx
		mov	cl, al
		add	cl, bl
		add	cl, dl
		shr	cx, 2
		shl	cx, 2
		push	si
		mov	si, 0DF8Ch
		add	si, cx
		mov	bl, cs:[si]
		mov	dl, cs:[si+1]
		mov	al, cs:[si+2]
		pop	si
		pop	cx
		retn
sub_1DF69	endp

; ---------------------------------------------------------------------------
		db 6 dup(0), 0Fh, 3 dup(0), 0Fh, 0, 0Fh, 3 dup(0), 0Fh
		db 3 dup(0), 0Fh, 3 dup(0), 0Fh, 0, 0Fh, 0, 0Fh, 0, 0Fh
		db 0, 0Fh, 0, 0Fh, 2 dup(0), 2 dup(0Fh), 0, 2 dup(0Fh)
		db 2 dup(0), 3 dup(0Fh), 0, 3 dup(0Fh),	0

; =============== S U B	R O U T	I N E =======================================


sub_1DFC0	proc near		; CODE XREF: LoadVDFPalette+A0p
					; LoadVDFPalette+A7p ...
		mov	cl, 64h	; 'd'
		xor	ah, ah
		imul	ax, 0Fh
		add	ax, 32h	; '2'
		div	cl
		cmp	al, 10h
		jb	short loc_1DFD2
		mov	al, 0Fh

loc_1DFD2:				; CODE XREF: sub_1DFC0+Ej
		stosb
		retn
sub_1DFC0	endp

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR LoadVDFPalette

loc_1DFD4:				; CODE XREF: LoadVDFPalette+97j
					; DATA XREF: seg000:off_1E07Co
		mov	al, cs:byte_1E0EC
		mov	cs:byte_1E0E8, al
		mov	al, cs:byte_1E0ED
		mov	cs:byte_1E0EA, al
		add	al, cs:byte_1E0EE
		mov	cs:byte_1E0E9, al
		jmp	loc_1DF0B
; ---------------------------------------------------------------------------

loc_1DFF0:				; CODE XREF: LoadVDFPalette+97j
					; DATA XREF: seg000:off_1E07Co
		mov	al, cs:byte_1E0EC
		mov	cs:byte_1E0E9, al
		sub	al, cs:byte_1E0EE
		mov	cs:byte_1E0E8, al
		mov	al, cs:byte_1E0ED
		mov	cs:byte_1E0EA, al
		jmp	loc_1DF0B
; ---------------------------------------------------------------------------

loc_1E00C:				; CODE XREF: LoadVDFPalette+97j
					; DATA XREF: seg000:off_1E07Co
		mov	al, cs:byte_1E0ED
		mov	cs:byte_1E0E8, al
		add	al, cs:byte_1E0EE
		mov	cs:byte_1E0EA, al
		mov	al, cs:byte_1E0EC
		mov	cs:byte_1E0E9, al
		jmp	loc_1DF0B
; ---------------------------------------------------------------------------

loc_1E028:				; CODE XREF: LoadVDFPalette+97j
					; DATA XREF: seg000:off_1E07Co
		mov	al, cs:byte_1E0ED
		mov	cs:byte_1E0E8, al
		mov	al, cs:byte_1E0EC
		mov	cs:byte_1E0EA, al
		sub	al, cs:byte_1E0EE
		mov	cs:byte_1E0E9, al
		jmp	loc_1DF0B
; ---------------------------------------------------------------------------

loc_1E044:				; CODE XREF: LoadVDFPalette+97j
					; DATA XREF: seg000:off_1E07Co
		mov	al, cs:byte_1E0ED
		mov	cs:byte_1E0E9, al
		add	al, cs:byte_1E0EE
		mov	cs:byte_1E0E8, al
		mov	al, cs:byte_1E0EC
		mov	cs:byte_1E0EA, al
		jmp	loc_1DF0B
; ---------------------------------------------------------------------------

loc_1E060:				; CODE XREF: LoadVDFPalette+97j
					; DATA XREF: seg000:off_1E07Co
		mov	al, cs:byte_1E0EC
		mov	cs:byte_1E0E8, al
		sub	al, cs:byte_1E0EE
		mov	cs:byte_1E0EA, al
		mov	al, cs:byte_1E0ED
		mov	cs:byte_1E0E9, al
		jmp	loc_1DF0B
; END OF FUNCTION CHUNK	FOR LoadVDFPalette
; ---------------------------------------------------------------------------
off_1E07C	dw offset loc_1DFD4	; 0 ; DATA XREF: LoadVDFPalette+97r
		dw offset loc_1DFF0	; 1
		dw offset loc_1E00C	; 2
		dw offset loc_1E028	; 3
		dw offset loc_1E044	; 4
		dw offset loc_1E060	; 5
PalIndexLUT	dw    0, 32h, 34h, 36h,	38h, 3Ah, 3Ch, 3Eh ; DATA XREF:	LoadVDFPalette+11o
		dw  30h,   2,	4,   6,	  8, 0Ah, 0Ch, 0Eh
		dw  10h, 42h, 44h, 46h,	48h, 4Ah, 4Ch, 4Eh
		dw  40h, 12h, 14h, 16h,	18h, 1Ah, 1Ch, 1Eh
		dw  20h, 52h, 54h, 56h,	58h, 5Ah, 5Ch, 5Eh
		dw  50h, 22h, 24h, 26h,	28h, 2Ah, 2Ch, 2Eh
byte_1E0E8	db 0			; DATA XREF: LoadVDFPalette+3Dw
					; LoadVDFPalette+A3r ...
byte_1E0E9	db 0			; DATA XREF: LoadVDFPalette+41w
					; LoadVDFPalette:loc_1DF0Br ...
byte_1E0EA	db 0			; DATA XREF: LoadVDFPalette+45w
					; LoadVDFPalette+AAr ...
byte_1E0EB	db 0			; DATA XREF: LoadVDFPalette+5Dw
					; LoadVDFPalette+78r
byte_1E0EC	db 0			; DATA XREF: LoadVDFPalette+4Ew
					; LoadVDFPalette+61r ...
byte_1E0ED	db 0			; DATA XREF: LoadVDFPalette+68w
					; LoadVDFPalette+16Dr ...
byte_1E0EE	db 0			; DATA XREF: LoadVDFPalette+81w
					; LoadVDFPalette+175r ...
		db 90h
byte_1E0F0	db 60h dup(0)		; DATA XREF: LoadVDFPalette+Bo
					; LoadVDFPalette+2Bo
PaletteBuffer	db 1E0h	dup(7Fh)	; DATA XREF: cmfA1D+Fo
					; LoadVDFPalette+4o ...

; =============== S U B	R O U T	I N E =======================================


Palette_Refresh	proc near		; CODE XREF: cmfA1B_PalFade+5p
					; mdrGraphicEffect+3FFp ...
		push	ds
		call	LoadVDFPalette
		mov	ax, cs
		mov	ds, ax
		assume ds:seg000
		mov	si, offset PaletteBuffer
		mov	cx, 10h

loc_1E33E:				; CODE XREF: Palette_Refresh+2Bj
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
		loop	loc_1E33E
		pop	ds
		assume ds:nothing
		retn
Palette_Refresh	endp


; =============== S U B	R O U T	I N E =======================================


Palette_SetMult	proc near		; CODE XREF: seg000:1DCCp seg000:1DF6p ...
		push	ds
		mov	ax, cs
		mov	ds, ax
		assume ds:seg000
		mov	si, offset PaletteBuffer
		mov	bh, 10h		; BL = factor (0.4 fixed point), BH = fixed point factor (10h)
		mov	cx, 10h		; 16 colours

loc_1E36C:				; CODE XREF: Palette_SetMult:loc_1E396j
		mov	al, 10h
		sub	al, cl
		out	0A8h, al	; Interrupt Controller #2, 8259A
		lodsw
		shl	bp, 1
		jnb	short loc_1E396
		mov	dx, ax
		and	al, 0Fh
		mul	bl
		div	bh
		out	0AEh, al	; Interrupt Controller #2, 8259A
		mov	al, dl
		shr	al, 4
		mul	bl
		div	bh
		out	0ACh, al	; Interrupt Controller #2, 8259A
		mov	al, dh
		and	al, 0Fh
		mul	bl
		div	bh
		out	0AAh, al	; Interrupt Controller #2, 8259A

loc_1E396:				; CODE XREF: Palette_SetMult+16j
		loop	loc_1E36C
		pop	ds
		assume ds:nothing
		retn
Palette_SetMult	endp


; =============== S U B	R O U T	I N E =======================================


sub_1E39A	proc near		; CODE XREF: seg000:1F05p seg000:1F37p ...
		push	ds
		mov	ax, cs
		mov	ds, ax
		assume ds:seg000
		mov	si, 0E150h
		mov	bh, 10h
		mov	cx, 10h

loc_1E3A7:				; CODE XREF: sub_1E39A:loc_1E3F2j
		mov	al, 10h
		sub	al, cl
		out	0A8h, al	; Interrupt Controller #2, 8259A
		lodsw
		shl	bp, 1
		jnb	short loc_1E3F2
		mov	dx, ax
		and	al, 0Fh
		mov	cs:byte_1E3F6, al
		xor	al, 0Fh
		mul	bl
		div	bh
		add	al, cs:byte_1E3F6
		out	0AEh, al	; Interrupt Controller #2, 8259A
		mov	al, dl
		shr	al, 4
		mov	cs:byte_1E3F6, al
		xor	al, 0Fh
		mul	bl
		div	bh
		add	al, cs:byte_1E3F6
		out	0ACh, al	; Interrupt Controller #2, 8259A
		mov	al, dh
		and	al, 0Fh
		mov	cs:byte_1E3F6, al
		xor	al, 0Fh
		mul	bl
		div	bh
		add	al, cs:byte_1E3F6
		out	0AAh, al	; Interrupt Controller #2, 8259A

loc_1E3F2:				; CODE XREF: sub_1E39A+16j
		loop	loc_1E3A7
		pop	ds
		assume ds:nothing
		retn
sub_1E39A	endp

; ---------------------------------------------------------------------------
byte_1E3F6	db 0			; DATA XREF: sub_1E39A+1Cw
					; sub_1E39A+26r ...
		db 0Fh dup(0)

; =============== S U B	R O U T	I N E =======================================


sub_1E406	proc near		; CODE XREF: DetectFMChip+7Bp
		cmp	ax, 2
		jz	short loc_1E420
		cmp	ax, 3
		jz	short loc_1E429
		mov	cs:musicMode, 0
		mov	dx, ax
		mov	ax, 0Ah
		int	7Eh		; not used
		jmp	short locret_1E430
; ---------------------------------------------------------------------------

loc_1E420:				; CODE XREF: sub_1E406+3j
		mov	cs:musicMode, 2
		jmp	short locret_1E430
; ---------------------------------------------------------------------------

loc_1E429:				; CODE XREF: sub_1E406+8j
		mov	cs:musicMode, 3

locret_1E430:				; CODE XREF: sub_1E406+18j
					; sub_1E406+21j
		retn
sub_1E406	endp


; =============== S U B	R O U T	I N E =======================================


DetectMusicDriver proc near		; CODE XREF: start+51p
		push	es
		push	ds
		pusha
		mov	ax, cs
		mov	ds, ax
		assume ds:seg000
		jmp	short loc_1E43E
; ---------------------------------------------------------------------------
aMfd		db 'MFD',0              ; DATA XREF: DetectMusicDriver+17o
; ---------------------------------------------------------------------------

loc_1E43E:				; CODE XREF: DetectMusicDriver+7j
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
		jz	short loc_1E4A2
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
		jz	short loc_1E490
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
		jz	short loc_1E499
		mov	cs:musicMode, -1

loc_1E48C:				; CODE XREF: DetectMusicDriver+66j
					; DetectMusicDriver+6Fj ...
		popa
		pop	ds
		assume ds:nothing
		pop	es
		retn
; ---------------------------------------------------------------------------

loc_1E490:				; CODE XREF: DetectMusicDriver+39j
		mov	cs:musicMode, 0	; enable USMD support (FM)
		jmp	short loc_1E48C
; ---------------------------------------------------------------------------

loc_1E499:				; CODE XREF: DetectMusicDriver+52j
		mov	cs:musicMode, 1	; enable PMD support (FM)
		jmp	short loc_1E48C
; ---------------------------------------------------------------------------

loc_1E4A2:				; CODE XREF: DetectMusicDriver+20j
		mov	cs:musicMode, 2	; enable MFD support (MIDI)
		jmp	short loc_1E48C
DetectMusicDriver endp

; ---------------------------------------------------------------------------
aUsmd		db 'USMD'               ; DATA XREF: DetectMusicDriver+30o
aPmd		db 'PMD'                ; DATA XREF: DetectMusicDriver+49o

; =============== S U B	R O U T	I N E =======================================


Music_Start	proc near		; CODE XREF: DoOneLevel+BAp
					; DoOneLevel+152p ...
		cmp	cs:musicMode, 2
		jz	short loc_1E4D9
		cmp	cs:musicMode, 1
		jz	short loc_1E4D3
		cmp	cs:musicMode, 0
		jz	short loc_1E4CC
		jmp	short loc_1E4DF
; ---------------------------------------------------------------------------

loc_1E4CC:				; CODE XREF: Music_Start+16j
		mov	ax, 2
		int	7Eh		; USMD call 02:	Play Music
		jmp	short loc_1E4DF
; ---------------------------------------------------------------------------

loc_1E4D3:				; CODE XREF: Music_Start+Ej
		mov	ah, 0
		int	60h		; USMD call 00:	Play Music
		jmp	short loc_1E4DF
; ---------------------------------------------------------------------------

loc_1E4D9:				; CODE XREF: Music_Start+6j
		mov	ah, 0
		int	7Ch		; MFD call 00: Play Music
		jmp	short $+2

loc_1E4DF:				; CODE XREF: Music_Start+18j
					; Music_Start+1Fj ...
		clc
		retn
Music_Start	endp


; =============== S U B	R O U T	I N E =======================================


Music_Stop	proc near		; CODE XREF: start+EBp	start+12Cp ...
		cmp	cs:musicMode, 2
		jz	short loc_1E508
		cmp	cs:musicMode, 1
		jz	short loc_1E502
		cmp	cs:musicMode, 0
		jz	short loc_1E4FB
		jmp	short loc_1E50E
; ---------------------------------------------------------------------------

loc_1E4FB:				; CODE XREF: Music_Stop+16j
		mov	ax, 3
		int	7Eh		; USMD call 03:	Stop Music
		jmp	short loc_1E50E
; ---------------------------------------------------------------------------

loc_1E502:				; CODE XREF: Music_Stop+Ej
		mov	ah, 1
		int	60h		; PMD call 01: Stop Music
		jmp	short loc_1E50E
; ---------------------------------------------------------------------------

loc_1E508:				; CODE XREF: Music_Stop+6j
		mov	ah, 1
		int	7Ch		; MFD call 01: Stop Music
		jmp	short $+2

loc_1E50E:				; CODE XREF: Music_Stop+18j
					; Music_Stop+1Fj ...
		clc
		retn
Music_Stop	endp


; =============== S U B	R O U T	I N E =======================================


Music_FadeOut	proc near		; CODE XREF: sub_10F09+239p
					; sub_13EE7+47p ...
		cmp	cs:musicMode, 2
		jz	short loc_1E53C
		cmp	cs:musicMode, 1
		jz	short loc_1E534
		cmp	cs:musicMode, 0
		jz	short loc_1E52A
		jmp	short loc_1E544
; ---------------------------------------------------------------------------

loc_1E52A:				; CODE XREF: Music_FadeOut+16j
		mov	dx, 9
		mov	ax, 4
		int	7Eh		; PMD call 04: Fade Out, speed 9
		jmp	short loc_1E544
; ---------------------------------------------------------------------------

loc_1E534:				; CODE XREF: Music_FadeOut+Ej
		mov	ah, 2
		mov	al, 14h
		int	60h		; PMD call 02: Fade Out, speed 20
		jmp	short loc_1E544
; ---------------------------------------------------------------------------

loc_1E53C:				; CODE XREF: Music_FadeOut+6j
		mov	ah, 3
		mov	al, 4
		int	7Ch		; MFD call 03: Fade Out, speed 4
		jmp	short $+2

loc_1E544:				; CODE XREF: Music_FadeOut+18j
					; Music_FadeOut+22j ...
		clc
		retn
Music_FadeOut	endp


; =============== S U B	R O U T	I N E =======================================


Music_FadeIn	proc near		; CODE XREF: sub_10F09+254p
		cmp	cs:musicMode, 2
		jz	short loc_1E57A
		cmp	cs:musicMode, 1
		jz	short loc_1E56A
		cmp	cs:musicMode, 0
		jz	short loc_1E560
		jmp	short loc_1E580
; ---------------------------------------------------------------------------

loc_1E560:				; CODE XREF: Music_FadeIn+16j
		mov	dx, 9
		mov	ax, 5
		int	7Eh		; MFD call 05: Fade In,	speed 9
		jmp	short loc_1E580
; ---------------------------------------------------------------------------

loc_1E56A:				; CODE XREF: Music_FadeIn+Ej
		call	Music_Start
		mov	al, 0FFh
		call	sub_1E68A
		mov	ah, 2
		mov	al, -20
		int	60h		; PMD call 02: Fade In,	speed 20
		jmp	short loc_1E580
; ---------------------------------------------------------------------------

loc_1E57A:				; CODE XREF: Music_FadeIn+6j
		mov	ah, 0
		int	7Ch		; MFD call 00: Play Music
		jmp	short $+2

loc_1E580:				; CODE XREF: Music_FadeIn+18j
					; Music_FadeIn+22j ...
		clc
		retn
Music_FadeIn	endp


; =============== S U B	R O U T	I N E =======================================


sub_1E582	proc near		; CODE XREF: sub_10F09+236p
					; sub_10F09+261p ...
		push	es
		push	ds
		mov	cs:byte_1E64E, al
		mov	cs:byte_1E650, cl
		mov	cs:byte_1E64F, ch
		mov	cs:word_1E651, dx
		cmp	cs:musicMode, 1
		jz	short loc_1E5CE
		cmp	cs:musicMode, 0
		jz	short loc_1E5B9
		cmp	cs:musicMode, 2
		jz	short loc_1E5B9
		cmp	cs:musicMode, 2
		jz	short loc_1E630
		jmp	short loc_1E638
; ---------------------------------------------------------------------------

loc_1E5B9:				; CODE XREF: sub_1E582+23j
					; sub_1E582+2Bj ...
		mov	bl, al
		sub	bh, bh
		mov	ax, 100
		mul	bl
		mov	si, 20000
		add	si, ax
		mov	ax, 8
		int	7Eh		; MFD call 08: ??
		jmp	short loc_1E638
; ---------------------------------------------------------------------------

loc_1E5CE:				; CODE XREF: sub_1E582+1Bj
		mov	ah, 9
		int	60h		; PMD call 09: ??
		cmp	al, 0
		jz	short loc_1E638
		cmp	al, 1
		jz	short loc_1E5DE
		cmp	al, 2
		jz	short loc_1E5FC

loc_1E5DE:				; CODE XREF: sub_1E582+56j
		mov	al, cs:byte_1E64E
		mov	cl, cs:byte_1E650
		mov	ch, cs:byte_1E64F
		mov	bx, cs:word_1E651
		shl	bx, 1
		mov	dx, cs:off_1E63C[bx]
		mov	ah, 0Fh
		int	60h		; PMD call 0F: ??

loc_1E5FC:				; CODE XREF: sub_1E582+5Aj
		mov	al, cs:byte_1E64E
		mov	cl, cs:byte_1E650
		mov	ch, cs:byte_1E64F
		cmp	ch, 2
		jz	short loc_1E619
		cmp	ch, 3
		jz	short loc_1E61D
		cmp	ch, 1
		jz	short loc_1E621

loc_1E619:				; CODE XREF: sub_1E582+8Bj
		sub	ch, ch
		jmp	short loc_1E625
; ---------------------------------------------------------------------------

loc_1E61D:				; CODE XREF: sub_1E582+90j
		mov	ch, 7Fh
		jmp	short loc_1E625
; ---------------------------------------------------------------------------

loc_1E621:				; CODE XREF: sub_1E582+95j
		mov	ch, 80h
		jmp	short $+2

loc_1E625:				; CODE XREF: sub_1E582+99j
					; sub_1E582+9Dj
		mov	dx, cs:word_1E651
		mov	ah, 0Fh
		int	60h
		jmp	short loc_1E638
; ---------------------------------------------------------------------------

loc_1E630:				; CODE XREF: sub_1E582+33j
		jmp	short loc_1E5B9
; ---------------------------------------------------------------------------
		mov	ah, 6
		int	7Ch		; MFD call 06: ??
		jmp	short $+2

loc_1E638:				; CODE XREF: sub_1E582+35j
					; sub_1E582+4Aj ...
		pop	ds
		pop	es
		clc
		retn
sub_1E582	endp

; ---------------------------------------------------------------------------
off_1E63C	dw offset DrawShieldBar	; DATA XREF: sub_1E582+71r
		db 0DDh, 24h, 5, 0
		db 0DDh, 24h, 49h, 0Ch
		db 0BAh, 49h, 5Ch, 0BAh
		db 74h,	93h, 16h, 4
byte_1E64E	db 0			; DATA XREF: sub_1E582+2w
					; sub_1E582:loc_1E5DEr	...
byte_1E64F	db 0			; DATA XREF: sub_1E582+Bw
					; sub_1E582+65r ...
byte_1E650	db 0			; DATA XREF: sub_1E582+6w
					; sub_1E582+60r ...
word_1E651	dw 0			; DATA XREF: sub_1E582+10w
					; sub_1E582+6Ar ...

; =============== S U B	R O U T	I N E =======================================


sub_1E653	proc near		; CODE XREF: sub_10F09+230p
					; sub_10F09+25Bp ...
		push	es
		push	ds
		cmp	cs:musicMode, 1
		jz	short loc_1E67E
		cmp	cs:musicMode, 0
		jz	short loc_1E677
		cmp	cs:musicMode, 2
		jz	short loc_1E677
		cmp	cs:musicMode, 2
		jz	short loc_1E684
		jmp	short loc_1E686
; ---------------------------------------------------------------------------

loc_1E677:				; CODE XREF: sub_1E653+10j
					; sub_1E653+18j
		mov	ax, 3
		int	7Eh		; USMD call 03:	??
		jmp	short loc_1E686
; ---------------------------------------------------------------------------

loc_1E67E:				; CODE XREF: sub_1E653+8j
		mov	ah, 4
		int	60h		; PMD call 04: ??
		jmp	short loc_1E686
; ---------------------------------------------------------------------------

loc_1E684:				; CODE XREF: sub_1E653+20j
		jmp	short $+2

loc_1E686:				; CODE XREF: sub_1E653+22j
					; sub_1E653+29j ...
		pop	ds
		pop	es
		clc
		retn
sub_1E653	endp


; =============== S U B	R O U T	I N E =======================================


sub_1E68A	proc near		; CODE XREF: Music_FadeIn+29p
		cmp	cs:musicMode, 2
		jz	short loc_1E6AC
		cmp	cs:musicMode, 1
		jz	short loc_1E6A6
		cmp	cs:musicMode, 0
		jz	short loc_1E6A4
		jmp	short loc_1E6AE
; ---------------------------------------------------------------------------

loc_1E6A4:				; CODE XREF: sub_1E68A+16j
		jmp	short loc_1E6AE
; ---------------------------------------------------------------------------

loc_1E6A6:				; CODE XREF: sub_1E68A+Ej
		mov	ah, 19h
		int	60h		; PMD call 19: ??
		jmp	short loc_1E6AE
; ---------------------------------------------------------------------------

loc_1E6AC:				; CODE XREF: sub_1E68A+6j
		jmp	short $+2

loc_1E6AE:				; CODE XREF: sub_1E68A+18j
					; sub_1E68A:loc_1E6A4j	...
		clc
		retn
sub_1E68A	endp

; ---------------------------------------------------------------------------
		cmp	cs:musicMode, 2
		jz	short loc_1E6D7
		cmp	cs:musicMode, 1
		jz	short loc_1E6D1
		cmp	cs:musicMode, 0
		jz	short loc_1E6CA
		jmp	short loc_1E6D9
; ---------------------------------------------------------------------------

loc_1E6CA:				; CODE XREF: seg000:E6C6j
		mov	ax, 0Ch
		int	7Eh		; USMD call 0C:	??
		jmp	short loc_1E6D9
; ---------------------------------------------------------------------------

loc_1E6D1:				; CODE XREF: seg000:E6BEj
		mov	ah, 1
		int	60h		; PMD call 01: Stop Music
		jmp	short loc_1E6D9
; ---------------------------------------------------------------------------

loc_1E6D7:				; CODE XREF: seg000:E6B6j
		jmp	short $+2

loc_1E6D9:				; CODE XREF: seg000:E6C8j seg000:E6CFj ...
		clc
		retn
; Parameter: SI	= address of file name

; =============== S U B	R O U T	I N E =======================================


Music_Load	proc near		; CODE XREF: DoOneLevel+B2p
					; DoOneLevel+14Ap ...
		cmp	cs:musicMode, 2
		jz	short loc_1E6FE	; MIDI mode - jump
		cmp	cs:musicMode, 1
		jz	short loc_1E6FC
		cmp	cs:musicMode, 0
		jz	short loc_1E6F5
		jmp	short loc_1E725
; ---------------------------------------------------------------------------

loc_1E6F5:				; CODE XREF: Music_Load+16j
		mov	ax, 1
		int	7Eh		; USMD call 01:	Load Song
		jmp	short loc_1E725
; ---------------------------------------------------------------------------

loc_1E6FC:				; CODE XREF: Music_Load+Ej
		jmp	short loc_1E725
; ---------------------------------------------------------------------------

loc_1E6FE:				; CODE XREF: Music_Load+6j
		push	si

loc_1E6FF:				; CODE XREF: Music_Load+27j
		lodsb
		cmp	al, '.'         ; search for file extension
		jnz	short loc_1E6FF
		mov	byte ptr [si], 'M' ; replace with "MFD"
		mov	byte ptr [si+1], 'F'
		mov	byte ptr [si+2], 'D' ; Note: No null-terminator is added.
		pop	si
		mov	ah, 9
		int	7Ch		; MFD call 09: get music buffer	pointer
		mov	di, ax
		mov	ah, 0Ah
		int	7Ch		; MFD call 0A: get music buffer	segment
		mov	es, ax
		push	si
		push	ds
		call	LoadFileToBuffer
		pop	ds
		pop	si
		jmp	short $+2

loc_1E725:				; CODE XREF: Music_Load+18j
					; Music_Load+1Fj ...
		clc
		retn
Music_Load	endp


; =============== S U B	R O U T	I N E =======================================


LoadSFX		proc near		; CODE XREF: sub_1214A+Bp
					; sub_1214A+14p ...
		cmp	cs:musicMode, 2
		jz	short loc_1E741
		cmp	cs:musicMode, 1
		jz	short loc_1E748
		cmp	cs:musicMode, 0
		jz	short loc_1E741
		jmp	short loc_1E771
; ---------------------------------------------------------------------------

loc_1E741:				; CODE XREF: LoadSFX+6j LoadSFX+16j
		mov	ax, 1
		int	7Eh		; USMD call 01:	Load Song
		jmp	short loc_1E771
; ---------------------------------------------------------------------------

loc_1E748:				; CODE XREF: LoadSFX+Ej
		jmp	short loc_1E771
; ---------------------------------------------------------------------------
		push	si

loc_1E74B:				; CODE XREF: LoadSFX+27j
		lodsb
		cmp	al, '.'
		jnz	short loc_1E74B
		mov	byte ptr [si], 'M'
		mov	byte ptr [si+1], 'F'
		mov	byte ptr [si+2], 'D'
		pop	si
		mov	ah, 9
		int	7Ch		; MFD call 09: get music buffer	pointer
		mov	di, ax
		mov	ah, 0Ah
		int	7Ch		; MFD call 0A: get music buffer	segment
		mov	es, ax
		push	si
		push	ds
		call	LoadFileToBuffer
		pop	ds
		pop	si
		jmp	short $+2

loc_1E771:				; CODE XREF: LoadSFX+18j LoadSFX+1Fj ...
		clc
		retn
LoadSFX		endp

; ---------------------------------------------------------------------------
		db 2 dup(0)
musicMode	dw 0			; DATA XREF: sub_1E406+Aw
					; sub_1E406:loc_1E420w	...
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_1E778	proc near		; CODE XREF: mdrGraphicEffect+1ADp
					; mdrGraphicEffect+221p ...
		push	cx
		push	dx
		push	bx
		add	cx, cs:word_1E86A
		add	dx, cs:word_1E86C
		push	dx
		xor	dx, dx
		mov	ax, cx
		mov	bx, 640
		add	ax, 640
		div	bx
		mov	cx, dx
		pop	dx
		mov	ax, dx
		xor	dx, dx
		add	ax, 400
		mov	bx, 400
		div	bx
		pop	bx
		call	sub_1E7A8
		pop	dx
		pop	cx
		retn
sub_1E778	endp


; =============== S U B	R O U T	I N E =======================================


sub_1E7A8	proc near		; CODE XREF: start+95p	DoOneLevel+64p	...
		push	ax
		push	cx
		push	dx
		and	cx, 0FFF0h
		mov	cs:word_1E86A, cx
		mov	cs:word_1E86C, dx
		mov	al, 70h	; 'p'
		out	0A2h, al	; Interrupt Controller #2, 8259A
		jmp	short $+2
		jmp	short $+2
		jmp	short $+2
		jmp	short $+2
		jmp	short $+2
		mov	ax, dx
		shl	dx, 2
		add	ax, dx
		shl	ax, 3
		shr	cx, 4
		add	ax, cx
		add	ax, 4000h
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1
		jmp	short $+2
		jmp	short $+2
		jmp	short $+2
		jmp	short $+2
		jmp	short $+2
		mov	al, ah
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1
		jmp	short $+2
		jmp	short $+2
		jmp	short $+2
		jmp	short $+2
		jmp	short $+2
		mov	ax, 190h
		sub	ax, cs:word_1E86C
		shl	ax, 4
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1
		jmp	short $+2
		jmp	short $+2
		jmp	short $+2
		jmp	short $+2
		jmp	short $+2
		mov	al, ah
		or	al, cs:byte_1E9B4
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1
		jmp	short $+2
		jmp	short $+2
		jmp	short $+2
		jmp	short $+2
		jmp	short $+2
		mov	ax, cs:word_1E86A
		shr	ax, 4
		add	ax, 4000h
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1
		jmp	short $+2
		jmp	short $+2
		jmp	short $+2
		jmp	short $+2
		jmp	short $+2
		mov	al, ah
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1
		jmp	short $+2
		jmp	short $+2
		jmp	short $+2
		jmp	short $+2
		jmp	short $+2
		mov	ax, cs:word_1E86C
		shl	ax, 4
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1
		jmp	short $+2
		jmp	short $+2
		jmp	short $+2
		jmp	short $+2
		jmp	short $+2
		mov	al, ah
		or	al, cs:byte_1E9B4
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1
		jmp	short $+2
		jmp	short $+2
		jmp	short $+2
		jmp	short $+2
		jmp	short $+2
		pop	dx
		pop	cx
		pop	ax
		retn
sub_1E7A8	endp

; ---------------------------------------------------------------------------
word_1E86A	dw 0			; DATA XREF: sub_1E778+3r sub_1E7A8+6w ...
word_1E86C	dw 0			; DATA XREF: sub_1E778+8r sub_1E7A8+Bw ...

; =============== S U B	R O U T	I N E =======================================


sub_1E86E	proc near		; CODE XREF: mdrGraphicEffect+1B5p
					; mdrGraphicEffect+229p ...
		push	cx
		push	dx
		mov	bx, dx
		mov	ax, 400
		sub	ax, cs:word_1E86C
		cmp	dx, ax
		jb	short loc_1E882
		sub	bx, ax
		jmp	short loc_1E887
; ---------------------------------------------------------------------------

loc_1E882:				; CODE XREF: sub_1E86E+Ej
		add	bx, cs:word_1E86C

loc_1E887:				; CODE XREF: sub_1E86E+12j
		mov	ax, bx
		shl	bx, 2
		add	bx, ax
		shl	bx, 4
		mov	ax, 640
		sub	ax, cs:word_1E86A
		cmp	cx, ax
		jb	short loc_1E8A1
		sub	cx, ax
		jmp	short loc_1E8A6
; ---------------------------------------------------------------------------

loc_1E8A1:				; CODE XREF: sub_1E86E+2Dj
		add	cx, cs:word_1E86A

loc_1E8A6:				; CODE XREF: sub_1E86E+31j
		sar	cx, 3
		add	bx, cx
		pop	dx
		pop	cx
		retn
sub_1E86E	endp

; ---------------------------------------------------------------------------
		mov	cx, cs:word_1E86A
		mov	dx, cs:word_1E86C
		retn
; ---------------------------------------------------------------------------
		retn
; ---------------------------------------------------------------------------
		push	ax

loc_1E8BB:				; CODE XREF: seg000:E8BFj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1E8BB

loc_1E8C1:				; CODE XREF: seg000:E8C5j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1E8C1
		pop	ax
		retn

; =============== S U B	R O U T	I N E =======================================


SetIO_A6_00	proc near		; CODE XREF: start+5Ap	start+72p ...
		xor	al, al
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	cs:byte_1E8DC, al
		jmp	short $+2
		jmp	short $+2
		jmp	short $+2
		jmp	short $+2
		jmp	short $+2
		retn
SetIO_A6_00	endp

; ---------------------------------------------------------------------------
byte_1E8DC	db 0			; DATA XREF: SetIO_A6_00+4w
					; SetIO_A6_01+4w ...

; =============== S U B	R O U T	I N E =======================================


SetIO_A6_01	proc near		; CODE XREF: start+60p	start+156p ...
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	cs:byte_1E8DC, al
		jmp	short $+2
		jmp	short $+2
		jmp	short $+2
		jmp	short $+2
		jmp	short $+2
		retn
SetIO_A6_01	endp


; =============== S U B	R O U T	I N E =======================================


SetIO_A4_00	proc near		; CODE XREF: start+75p	start+BAp ...
		xor	al, al
		out	0A4h, al	; Interrupt Controller #2, 8259A
		mov	cs:byte_1E903, al
		jmp	short $+2
		jmp	short $+2
		jmp	short $+2
		jmp	short $+2
		jmp	short $+2
		retn
SetIO_A4_00	endp

; ---------------------------------------------------------------------------
byte_1E903	db 0			; DATA XREF: SetIO_A4_00+4w
					; SetIO_A4_01+4w ...

; =============== S U B	R O U T	I N E =======================================


SetIO_A4_01	proc near		; CODE XREF: start+153p
					; DrawDebugInfo+2B5p ...
		mov	al, 1
		out	0A4h, al	; Interrupt Controller #2, 8259A
		mov	cs:byte_1E903, al
		jmp	short $+2
		jmp	short $+2
		jmp	short $+2
		jmp	short $+2
		jmp	short $+2
		retn
SetIO_A4_01	endp


; =============== S U B	R O U T	I N E =======================================


sub_1E917	proc near		; CODE XREF: mdrGraphicEffect+4E1p
					; mdrGraphicEffect+541p ...
		mov	al, cs:byte_1E903
		xor	al, 1
		out	0A4h, al	; Interrupt Controller #2, 8259A
		mov	cs:byte_1E903, al
		jmp	short $+2
		jmp	short $+2
		jmp	short $+2
		jmp	short $+2
		jmp	short $+2
		retn
sub_1E917	endp


; =============== S U B	R O U T	I N E =======================================


sub_1E92E	proc near		; CODE XREF: sub_1BAEF+63p
					; mdrGraphicEffect+4E4p ...
		mov	al, cs:byte_1E8DC
		xor	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	cs:byte_1E8DC, al
		jmp	short $+2
		jmp	short $+2
		jmp	short $+2
		jmp	short $+2
		jmp	short $+2
		retn
sub_1E92E	endp

; ---------------------------------------------------------------------------
		push	es
		push	cx
		mov	al, 80h
		out	7Ch, al
		jmp	short $+2
		jmp	short $+2
		jmp	short $+2
		jmp	short $+2
		jmp	short $+2
		xor	al, al
		out	7Eh, al
		out	7Eh, al
		out	7Eh, al
		out	7Eh, al
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		xor	di, di
		mov	cx, 3E80h
		rep stosw
		xor	al, al
		out	7Ch, al
		pop	cx
		pop	es
		assume es:nothing
		retn
; ---------------------------------------------------------------------------
		push	es
		mov	ax, 0A000h
		mov	es, ax
		assume es:nothing
		xor	di, di
		xor	ax, ax
		mov	cx, 1000h
		rep stosw
		mov	ax, 0E1h
		mov	cx, 1000h
		rep stosw
		pop	es
		assume es:nothing
		retn

; =============== S U B	R O U T	I N E =======================================


SetIO_A2A0	proc near		; CODE XREF: start+8Ep	DoOneLevel+5Dp	...
		in	al, 31h
		and	al, 80h
		xor	al, 80h
		shr	al, 1
		mov	cs:byte_1E9B4, al
		mov	al, 47h
		out	0A2h, al	; Interrupt Controller #2, 8259A
		jmp	short $+2
		jmp	short $+2
		jmp	short $+2
		jmp	short $+2
		jmp	short $+2
		mov	al, 28h
		mov	cl, cs:byte_1E9B4
		shr	cl, 6
		shl	al, cl
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1
		retn
SetIO_A2A0	endp

; ---------------------------------------------------------------------------
byte_1E9B4	db 40h			; DATA XREF: sub_1E7A8+63r
					; sub_1E7A8+ADr ...
		align 2
word_1E9B6	dw 0			; DATA XREF: LoadVDFPalette+D5r
segHdf_ray	dw 0			; DATA XREF: SetupAction:loc_10930w
					; cmfA_FreeAllMem+10Er	...
word_1E9BA	dw 0			; DATA XREF: cmfA_FreeAllMem+E1r
					; sub_10B7F+44w ...
segHdf_raymX	dw 0			; DATA XREF: cmfA_FreeAllMem+F0r
					; sub_10CCF+3Aw ...
segHdf_smoke	dw 0			; DATA XREF: SetupAction:loc_1093Fw
					; cmfA_FreeAllMem+D2r ...
segHdf_tool	dw 0			; DATA XREF: SetupAction:loc_1095Dw
					; cmfA_FreeAllMem+B4r ...
segHdf_bang3	dw 0			; DATA XREF: SetupAction:loc_1096Cw
					; cmfA_FreeAllMem+A5r ...
		align 8
segHdf_shot	dw 0			; DATA XREF: SetupAction:loc_1094Ew
					; cmfA_FreeAllMem+C3r ...
segHdf_shoth	dw 0			; DATA XREF: SetupAction:loc_1097Bw
					; cmfA_FreeAllMem+96r ...
segHdf_rayoX	dw 0			; DATA XREF: cmfA_FreeAllMemr
					; cmfA_FreeAllMem+8r ...
		db 4 dup(0)
segHdf_itemp	dw 0			; DATA XREF: SetupAction:loc_1098Aw
					; cmfA_FreeAllMem+87r ...
segHdf_pgage	dw 0			; DATA XREF: SetupAction:loc_10999w
					; cmfA_FreeAllMem+78r ...
gfxBufPtrs_HDF	dw 0			; DATA XREF: cmfA09_AddSpr+3o
					; cmfA07_LoadHDF+10o ...
		db 3Ah dup(0)
segHdf_eshot6	dw 0			; DATA XREF: SetupAction:loc_109A8w
					; cmfA_FreeAllMem+69r ...
segHdf_efire	dw 0			; DATA XREF: SetupAction+94w
					; cmfA_FreeAllMem+5Ar ...
segHdf_eshot1	dw 0			; DATA XREF: SetupAction+A0w
					; cmfA_FreeAllMem+4Br ...
segHdf_ns_e1	dw 0			; DATA XREF: SetupAction+ACw
					; cmfA_FreeAllMem:loc_10A94r ...
		db 34h dup(0)
BasePosX	dw 0			; DATA XREF: sub_10EEA+Er
					; sub_10F09+8Fr ...
BasePosY	dw 0			; DATA XREF: sub_10EEA+13r
					; sub_10F09+D5w ...
word_1EA52	dw 0			; DATA XREF: sub_10F09+1C3r cmfA19+1w	...
word_1EA54	dw 0			; DATA XREF: cmfA15+24w sub_1260A+85w	...
word_1EA56	dw 90h			; DATA XREF: sub_10F09+1DFr cmfA19+Aw	...
word_1EA58	dw 0			; DATA XREF: cmfA15+2Bw sub_1260A+17w	...
		db 1, 0
word_1EA5C	dw 0			; DATA XREF: cmfA15+1Dw sub_1260A+8Aw	...
		align 4
word_1EA60	dw 17Ch			; DATA XREF: sub_111F3+D6r
					; DrawShieldBar+1Aw ...
word_1EA62	dw 17Ch			; DATA XREF: sub_111F3:loc_112C5r
					; DrawShieldBar+20r ...
word_1EA64	dw 0			; DATA XREF: DrawPowerGage+1Cr
					; sub_111F3+E4w ...
word_1EA66	dw 0			; DATA XREF: sub_111F3+EBw
					; sub_111F3+14Ew ...
word_1EA68	dw 0			; DATA XREF: cmfA15+16w
word_1EA6A	dw 0			; DATA XREF: sub_138A5+1Ar
					; sub_138A5:loc_138F1r	...
ScoreCounterH	dw 0			; DATA XREF: sub_103E5+1Fw
					; sub_10486+20r ...
ScoreCounterL	dw 0			; DATA XREF: sub_103E5+26w
					; sub_10486+28r ...
		db 4 dup(0)
cmfMainBStartPos dw 0			; DATA XREF: cmfA1C_CallCMFB+3w
					; cmfA_LoadEnemies+Fr ...
word_1EA76	dw 0			; DATA XREF: sub_10F09w sub_10F09+4Cr	...
word_1EA78	dw 1			; DATA XREF: sub_103E5+13w
					; sub_10486+10r ...
LifeBonus	dw 0			; DATA XREF: seg000:1C3Dr seg000:1C4Dr ...

; =============== S U B	R O U T	I N E =======================================


LoadCockpit	proc near		; CODE XREF: cmfA0E_DoCockpit+2p
		push	es
		push	ds
		pusha
		call	SetIO_A6_00
		call	SetIO_A4_00
		mov	al, 4Bh	; 'K'
		out	0A2h, al	; Interrupt Controller #2, 8259A
		mov	al, 0
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1
		push	ax

loc_1EA8E:				; CODE XREF: LoadCockpit+16j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1EA8E

loc_1EA94:				; CODE XREF: LoadCockpit+1Cj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1EA94
		pop	ax
		call	SetIO_A2A0
		sub	cx, cx
		sub	dx, dx
		call	sub_1E7A8
		jmp	short $+2
		jmp	short $+2
		mov	al, 4Bh	; 'K'
		out	0A2h, al	; Interrupt Controller #2, 8259A
		mov	al, 0
		jmp	short $+2
		jmp	short $+2
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1
		mov	ah, 0Dh
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		jmp	short $+2
		mov	cs:word_13190, 0
		mov	cs:word_13B18, 40h ; '@'
		mov	ax, cs:word_1EA62
		mov	cs:word_1EA60, ax
		call	sub_10486
		mov	word ptr cs:0FFF1h, 0
		mov	word ptr cs:0FFF3h, 27Fh
		mov	dx, 0
		call	Music_Stop
		mov	ax, cs
		mov	ds, ax
		assume ds:seg000
		mov	si, offset aNsc00_uso ;	"nsc00.uso"
		sub	di, di
		call	Music_Load
		sub	si, si
		mov	dx, 0
		call	Music_Start
		call	sub_1DA00
		mov	ax, cs
		mov	ds, ax
		mov	dx, offset aC06_vdf ; "c06.vdf"
		call	LoadFile	; c06.vdf
		jnb	short loc_1EB0E
		jmp	loc_1EFB5
; ---------------------------------------------------------------------------

loc_1EB0E:				; CODE XREF: LoadCockpit+8Dj
		mov	ds, ax
		assume ds:nothing
		sub	si, si
		push	ds
		call	LoadGFXData
		mov	ax, 6
		call	mdrGraphicEffect
		pop	ds
		push	es
		mov	ax, ds
		mov	es, ax
		mov	ah, 49h
		int	21h		; DOS -	2+ - FREE MEMORY
					; ES = segment address of area to be freed
		pop	es
		call	sub_1DA4F
		cmp	cs:word_1F398, 0
		jnz	short loc_1EB35
		jmp	loc_1EC9B
; ---------------------------------------------------------------------------

loc_1EB35:				; CODE XREF: LoadCockpit+B4j
		mov	ax, cs
		mov	ds, ax
		assume ds:seg000
		mov	dx, offset aCsrg_hdf ; "csrg.hdf"
		call	LoadFile	; csrg.hdf
		jnb	short loc_1EB44
		jmp	loc_1EFB5
; ---------------------------------------------------------------------------

loc_1EB44:				; CODE XREF: LoadCockpit+C3j
		mov	cs:word_1F388, ax
		mov	cs:word_1BDE6, 1
		mov	cs:word_1F384, 68h ; 'h'
		mov	cs:word_1F386, 88h ; 'à'
		call	sub_1F0CA
		mov	ax, cs
		mov	ds, ax
		mov	dx, offset aMaing_hdf ;	"maing.hdf"
		call	LoadFile	; maing.hdf
		jnb	short loc_1EB6F
		jmp	loc_1EFB5
; ---------------------------------------------------------------------------

loc_1EB6F:				; CODE XREF: LoadCockpit+EEj
		mov	cs:word_1F38A, ax
		mov	cs:word_1F382, offset word_1F39A
		mov	cs:word_1F38E, 1
		mov	ax, cs:word_1F398
		mov	cs:word_1F390, ax
		mov	cs:word_1F392, 80h ; 'Ä'
		mov	cs:word_1F394, 50h ; 'P'
		mov	cs:word_1F396, 0
		call	sub_1EFB9
		mov	ax, cs:word_1F38E
		dec	ax
		add	ax, ax
		mov	bx, offset word_1F39A
		add	bx, ax
		mov	ax, cs:[bx]
		cmp	ax, 4
		jz	short loc_1EBCF
		cmp	ax, 2
		jz	short loc_1EBED
		cmp	ax, 3
		jz	short loc_1EC29
		cmp	ax, 1
		jz	short loc_1EC0B
		mov	cs:word_1EBCD, 1
		jmp	short loc_1EC47
; ---------------------------------------------------------------------------
word_1EBCD	dw 1			; DATA XREF: LoadCockpit+148w
					; LoadCockpit+168w ...
; ---------------------------------------------------------------------------

loc_1EBCF:				; CODE XREF: LoadCockpit+137j
		mov	cs:word_13BB3, 0
		mov	cs:word_13BB5, 2
		mov	cs:word_13BAD, 4
		mov	cs:word_1EBCD, 7
		jmp	short loc_1EC47
; ---------------------------------------------------------------------------

loc_1EBED:				; CODE XREF: LoadCockpit+13Cj
		mov	cs:word_13BB5, 0Ah
		mov	cs:word_13BB3, 1
		mov	cs:word_13BAD, 2
		mov	cs:word_1EBCD, 3
		jmp	short loc_1EC47
; ---------------------------------------------------------------------------

loc_1EC0B:				; CODE XREF: LoadCockpit+146j
		mov	cs:word_13BB5, 2
		mov	cs:word_13BB3, 2
		mov	cs:word_13BAD, 2
		mov	cs:word_1EBCD, 1
		jmp	short loc_1EC47
; ---------------------------------------------------------------------------

loc_1EC29:				; CODE XREF: LoadCockpit+141j
		mov	cs:word_13BB5, 1
		mov	cs:word_13BB3, 3
		mov	cs:word_13BAD, 2
		mov	cs:word_1EBCD, 5
		jmp	short $+2

loc_1EC47:				; CODE XREF: LoadCockpit+14Fj
					; LoadCockpit+16Fj ...
		mov	word ptr cs:0FFF5h, 50h	; 'P'
		mov	word ptr cs:0FFF7h, 80h	; 'Ä'
		mov	cs:word_1F394, 4Eh ; 'N'
		mov	cx, 30h	; '0'

loc_1EC5F:				; CODE XREF: LoadCockpit+20Ej
		push	cx
		push	ax

loc_1EC61:				; CODE XREF: LoadCockpit+1E9j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1EC61

loc_1EC67:				; CODE XREF: LoadCockpit+1EFj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1EC67
		pop	ax
		mov	dx, cs:word_1F394
		add	dx, cx
		mov	cx, cs:word_1F392
		mov	ds, cs:word_1F38A
		assume ds:nothing
		sub	si, si
		mov	ax, cs:word_1EBCD
		call	sub_1F8C0
		pop	cx
		dec	cx
		loop	loc_1EC5F
		mov	ds, cs:word_1F38A
		push	es
		mov	ax, ds
		mov	es, ax
		mov	ah, 49h
		int	21h		; DOS -	2+ - FREE MEMORY
					; ES = segment address of area to be freed
		pop	es

loc_1EC9B:				; CODE XREF: LoadCockpit+B6j
		cmp	cs:word_1F3B0, 0
		jnz	short loc_1ECA6
		jmp	loc_1EE0F
; ---------------------------------------------------------------------------

loc_1ECA6:				; CODE XREF: LoadCockpit+225j
		mov	ax, cs
		mov	ds, ax
		assume ds:seg000
		mov	dx, offset aSubg_hdf ; "subg.hdf"
		call	LoadFile	; subg.hdf
		jnb	short loc_1ECB5
		jmp	loc_1EFB5
; ---------------------------------------------------------------------------

loc_1ECB5:				; CODE XREF: LoadCockpit+234j
		mov	cs:word_1F38A, ax
		mov	cx, 70h	; 'p'
		mov	dx, 80h	; 'Ä'
		mov	si, 200h
		mov	di, 120h
		mov	ah, 0
		call	sub_1FF1A
		mov	word ptr cs:0FFF5h, 90h	; 'ê'
		mov	word ptr cs:0FFF7h, 120h
		mov	cs:word_1F384, 68h ; 'h'
		mov	cs:word_1F386, 88h ; 'à'
		call	sub_1F0CA
		mov	cs:word_1F382, offset word_1F3B2
		mov	cs:word_1F38E, 1
		mov	ax, cs:word_1F3B0
		mov	cs:word_1F390, ax
		mov	cs:word_1F392, 100h
		mov	cs:word_1F394, 50h ; 'P'
		mov	cs:word_1F396, 0
		call	sub_1EFB9
		mov	ax, cs:word_1F38E
		dec	ax
		add	ax, ax
		mov	bx, 0F3B2h
		add	bx, ax
		mov	ax, cs:[bx]
		cmp	ax, 4
		jz	short loc_1ED9D
		cmp	ax, 3
		jz	short loc_1ED7F
		cmp	ax, 2
		jz	short loc_1ED61
		cmp	ax, 1
		jz	short loc_1ED43
		mov	cs:word_1EBCD, 1
		jmp	short loc_1EDBB
; ---------------------------------------------------------------------------

loc_1ED43:				; CODE XREF: LoadCockpit+2BCj
		mov	cs:word_13CB9, 0
		mov	cs:word_13CBB, 0Fh
		mov	cs:word_13CB3, 2
		mov	cs:word_1EBCD, 1
		jmp	short loc_1EDBB
; ---------------------------------------------------------------------------

loc_1ED61:				; CODE XREF: LoadCockpit+2B7j
		mov	cs:word_13CBB, 0Fh
		mov	cs:word_13CB9, 2
		mov	cs:word_13CB3, 2
		mov	cs:word_1EBCD, 3
		jmp	short loc_1EDBB
; ---------------------------------------------------------------------------

loc_1ED7F:				; CODE XREF: LoadCockpit+2B2j
		mov	cs:word_13CBB, 0Fh
		mov	cs:word_13CB9, 3
		mov	cs:word_13CB3, 2
		mov	cs:word_1EBCD, 5
		jmp	short loc_1EDBB
; ---------------------------------------------------------------------------

loc_1ED9D:				; CODE XREF: LoadCockpit+2ADj
		mov	cs:word_13CBB, 0Fh
		mov	cs:word_13CB9, 1
		mov	cs:word_13CB3, 2
		mov	cs:word_1EBCD, 7
		jmp	short $+2

loc_1EDBB:				; CODE XREF: LoadCockpit+2C5j
					; LoadCockpit+2E3j ...
		mov	word ptr cs:0FFF5h, 50h	; 'P'
		mov	word ptr cs:0FFF7h, 80h	; 'Ä'
		mov	cs:word_1F394, 4Eh ; 'N'
		mov	cx, 32h	; '2'

loc_1EDD3:				; CODE XREF: LoadCockpit+382j
		push	cx
		push	ax

loc_1EDD5:				; CODE XREF: LoadCockpit+35Dj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1EDD5

loc_1EDDB:				; CODE XREF: LoadCockpit+363j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1EDDB
		pop	ax
		mov	dx, cs:word_1F394
		add	dx, cx
		mov	cx, cs:word_1F392
		mov	ds, cs:word_1F38A
		assume ds:nothing
		sub	si, si
		mov	ax, cs:word_1EBCD
		call	sub_1F8C0
		pop	cx
		dec	cx
		loop	loc_1EDD3
		mov	ds, cs:word_1F38A
		push	es
		mov	ax, ds
		mov	es, ax
		mov	ah, 49h
		int	21h		; DOS -	2+ - FREE MEMORY
					; ES = segment address of area to be freed
		pop	es

loc_1EE0F:				; CODE XREF: LoadCockpit+227j
		cmp	cs:word_1F3C8, 0
		jnz	short loc_1EE1A
		jmp	loc_1EF67
; ---------------------------------------------------------------------------

loc_1EE1A:				; CODE XREF: LoadCockpit+399j
		mov	ax, cs
		mov	ds, ax
		assume ds:seg000
		mov	dx, offset aOptg_hdf ; "optg.hdf"
		call	LoadFile	; optg.hdf
		jnb	short loc_1EE29
		jmp	loc_1EFB5
; ---------------------------------------------------------------------------

loc_1EE29:				; CODE XREF: LoadCockpit+3A8j
		mov	cs:word_1F38A, ax
		mov	cx, 70h	; 'p'
		mov	dx, 80h	; 'Ä'
		mov	si, 200h
		mov	di, 120h
		mov	ah, 0
		call	sub_1FF1A
		mov	word ptr cs:0FFF5h, 90h	; 'ê'
		mov	word ptr cs:0FFF7h, 120h
		mov	cs:word_1F384, 68h ; 'h'
		mov	cs:word_1F386, 88h ; 'à'
		call	sub_1F0CA
		mov	cs:word_1F382, 0F3CAh
		mov	cs:word_1F38E, 1
		mov	ax, cs:word_1F3C8
		mov	cs:word_1F390, ax
		mov	cs:word_1F392, 180h
		mov	cs:word_1F394, 50h ; 'P'
		mov	cs:word_1F396, 0
		call	sub_1EFB9
		mov	ax, cs:word_1F38E
		dec	ax
		add	ax, ax
		mov	bx, 0F3CAh
		add	bx, ax
		mov	ax, cs:[bx]
		cmp	ax, 4
		jz	short loc_1EEFC
		cmp	ax, 3
		jz	short loc_1EEE5
		cmp	ax, 2
		jz	short loc_1EECE
		cmp	ax, 1
		jz	short loc_1EEB7
		mov	cs:word_1EBCD, 1
		jmp	short loc_1EF13
; ---------------------------------------------------------------------------

loc_1EEB7:				; CODE XREF: LoadCockpit+430j
		mov	cs:word_13DAD, 0
		mov	cs:word_13DAF, 0Fh
		mov	cs:word_1EBCD, 1
		jmp	short loc_1EF13
; ---------------------------------------------------------------------------

loc_1EECE:				; CODE XREF: LoadCockpit+42Bj
		mov	cs:word_13DAF, 0Fh
		mov	cs:word_13DAD, 1
		mov	cs:word_1EBCD, 3
		jmp	short loc_1EF13
; ---------------------------------------------------------------------------

loc_1EEE5:				; CODE XREF: LoadCockpit+426j
		mov	cs:word_13DAF, 0Fh
		mov	cs:word_13DAD, 2
		mov	cs:word_1EBCD, 5
		jmp	short loc_1EF13
; ---------------------------------------------------------------------------

loc_1EEFC:				; CODE XREF: LoadCockpit+421j
		mov	cs:word_13DAF, 0Fh
		mov	cs:word_13DAD, 3
		mov	cs:word_1EBCD, 7
		jmp	short $+2

loc_1EF13:				; CODE XREF: LoadCockpit+439j
					; LoadCockpit+450j ...
		mov	cs:word_1F394, 4Eh ; 'N'
		mov	word ptr cs:0FFF5h, 50h	; 'P'
		mov	word ptr cs:0FFF7h, 80h	; 'Ä'
		mov	cx, 32h	; '2'

loc_1EF2B:				; CODE XREF: LoadCockpit+4DAj
		push	cx
		push	ax

loc_1EF2D:				; CODE XREF: LoadCockpit+4B5j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1EF2D

loc_1EF33:				; CODE XREF: LoadCockpit+4BBj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1EF33
		pop	ax
		mov	dx, cs:word_1F394
		add	dx, cx
		mov	cx, cs:word_1F392
		mov	ds, cs:word_1F38A
		assume ds:nothing
		sub	si, si
		mov	ax, cs:word_1EBCD
		call	sub_1F8C0
		pop	cx
		dec	cx
		loop	loc_1EF2B
		mov	ds, cs:word_1F38A
		push	es
		mov	ax, ds
		mov	es, ax
		mov	ah, 49h
		int	21h		; DOS -	2+ - FREE MEMORY
					; ES = segment address of area to be freed
		pop	es

loc_1EF67:				; CODE XREF: LoadCockpit+39Bj
		mov	ds, cs:word_1F388
		push	es
		mov	ax, ds
		mov	es, ax
		mov	ah, 49h
		int	21h		; DOS -	2+ - FREE MEMORY
					; ES = segment address of area to be freed
		pop	es
		call	sub_1F879
		call	sub_13D01
		call	sub_13CBD
		call	Music_FadeOut
		mov	ax, cs
		mov	ds, ax
		assume ds:seg000
		mov	dx, offset aNbl_vdf ; "nbl.vdf"
		call	LoadFile	; nbl.vdf
		jb	short loc_1EFB5
		mov	ds, ax
		assume ds:nothing
		push	ds
		call	sub_1DA00
		mov	ax, 7
		call	mdrGraphicEffect
		pop	ds
		sub	si, si
		push	ds
		call	LoadGFXData
		mov	ax, 6
		call	mdrGraphicEffect
		pop	ds
		push	es
		mov	ax, ds
		mov	es, ax
		mov	ah, 49h
		int	21h		; DOS -	2+ - FREE MEMORY
					; ES = segment address of area to be freed
		pop	es
		call	sub_1DA4F

loc_1EFB5:				; CODE XREF: LoadCockpit+8Fj
					; LoadCockpit+C5j ...
		popa
		pop	ds
		pop	es
		retn
LoadCockpit	endp


; =============== S U B	R O U T	I N E =======================================


sub_1EFB9	proc near		; CODE XREF: LoadCockpit+122p
					; LoadCockpit+298p ...
		mov	word ptr cs:0FFF5h, 90h	; 'ê'
		mov	word ptr cs:0FFF7h, 120h
		mov	cx, 6
		mov	dx, 10h

loc_1EFCD:				; CODE XREF: sub_1EFB9+1Ej
		push	cx
		push	dx
		call	sub_1F1E7
		pop	dx
		pop	cx
		add	dx, 10h
		loop	loc_1EFCD
		push	cx
		push	dx
		call	sub_1F1E7
		pop	dx
		pop	cx
		add	dx, 8
		push	cx
		push	dx
		call	sub_1F1E7
		pop	dx
		pop	cx
		add	dx, 8
		push	cx
		push	dx
		call	sub_1F1E7
		pop	dx
		pop	cx
		add	dx, 4
		push	cx
		push	dx
		call	sub_1F1E7
		pop	dx
		pop	cx
		add	dx, 4
		push	cx
		push	dx
		call	sub_1F1E7
		pop	dx
		pop	cx
		add	dx, 2
		push	cx
		push	dx
		call	sub_1F1E7
		pop	dx
		pop	cx
		add	dx, 2
		push	cx
		push	dx
		call	sub_1F1E7
		pop	dx
		pop	cx
		add	dx, 1
		push	cx
		push	dx
		call	sub_1F1E7
		pop	dx
		pop	cx
		add	dx, 1
		push	cx
		push	dx
		call	sub_1F1E7
		pop	dx
		pop	cx
		add	dx, 1
		push	cx
		push	dx
		call	sub_1F1E7
		pop	dx
		pop	cx
		add	dx, 1
		push	cx
		push	dx
		call	sub_1F1E7
		pop	dx
		pop	cx

loc_1F044:				; CODE XREF: sub_1EFB9+B7j
		push	ax

loc_1F045:				; CODE XREF: sub_1EFB9+90j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1F045

loc_1F04B:				; CODE XREF: sub_1EFB9+96j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1F04B
		pop	ax
		call	sub_1F087
		call	TestUserInput
		test	dx, 1
		jz	short loc_1F061
		call	sub_1F16D

loc_1F061:				; CODE XREF: sub_1EFB9+A3j
		test	dx, 2
		jz	short loc_1F06A
		call	sub_1F0F0

loc_1F06A:				; CODE XREF: sub_1EFB9+ACj
		test	dx, 30h
		jnz	short loc_1F072
		jmp	short loc_1F044
; ---------------------------------------------------------------------------

loc_1F072:				; CODE XREF: sub_1EFB9+B5j
		pusha
		mov	dx, 5
		call	sub_1E653
		mov	al, 0Dh
		call	sub_1E582
		popa
		mov	cs:word_1BDE6, 0
		retn
sub_1EFB9	endp


; =============== S U B	R O U T	I N E =======================================


sub_1F087	proc near		; CODE XREF: sub_1EFB9+99p
		inc	cs:word_1F396
		cmp	cs:word_1F396, 1Eh
		jb	short locret_1F0C7
		mov	cs:word_1F396, 0
		xor	cs:word_1F0C8, 0FFFFh
		mov	cx, cs:word_1F392
		mov	dx, cs:word_1F394
		mov	si, cx
		mov	di, dx
		add	si, 80h	; 'Ä'
		add	di, 30h	; '0'
		add	cx, 2
		add	dx, 2
		sub	si, 2
		sub	di, 2
		mov	ah, 40h	; '@'
		call	sub_1FDE8

locret_1F0C7:				; CODE XREF: sub_1F087+Bj
		retn
sub_1F087	endp

; ---------------------------------------------------------------------------
word_1F0C8	dw 0			; DATA XREF: sub_1F087+14w

; =============== S U B	R O U T	I N E =======================================


sub_1F0CA	proc near		; CODE XREF: LoadCockpit+E1p
					; LoadCockpit+26Ap ...
		push	ax

loc_1F0CB:				; CODE XREF: sub_1F0CA+5j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1F0CB

loc_1F0D1:				; CODE XREF: sub_1F0CA+Bj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1F0D1
		pop	ax
		mov	ds, cs:word_1F388
		mov	cx, cs:word_1F384
		mov	dx, cs:word_1F386
		mov	ax, 0
		sub	si, si
		call	sub_1F8C0
		retn
sub_1F0CA	endp


; =============== S U B	R O U T	I N E =======================================


sub_1F0F0	proc near		; CODE XREF: sub_1EFB9+AEp

; FUNCTION CHUNK AT F27A SIZE 00000063 BYTES

		pusha
		mov	dx, 5
		call	sub_1E653
		mov	al, 0Eh
		call	sub_1E582
		popa
		mov	ax, cs:word_1F38E
		cmp	cs:word_1F390, ax
		jz	short locret_1F16C
		inc	cs:word_1F38E
		cmp	cs:word_1F386, 0E8h ; 'Ë'
		jnz	short loc_1F119
		jmp	loc_1F27A
; ---------------------------------------------------------------------------

loc_1F119:				; CODE XREF: sub_1F0F0+24j
		push	dx
		add	cs:word_1F386, 10h
		call	sub_1F0CA
		add	cs:word_1F386, 8
		call	sub_1F0CA
		add	cs:word_1F386, 8
		call	sub_1F0CA
		add	cs:word_1F386, 4
		call	sub_1F0CA
		add	cs:word_1F386, 4
		call	sub_1F0CA
		add	cs:word_1F386, 4
		call	sub_1F0CA
		add	cs:word_1F386, 2
		call	sub_1F0CA
		add	cs:word_1F386, 1
		call	sub_1F0CA
		add	cs:word_1F386, 1
		call	sub_1F0CA
		pop	dx

locret_1F16C:				; CODE XREF: sub_1F0F0+16j
		retn
sub_1F0F0	endp


; =============== S U B	R O U T	I N E =======================================


sub_1F16D	proc near		; CODE XREF: sub_1EFB9+A5p

; FUNCTION CHUNK AT F2DD SIZE 00000066 BYTES

		pusha
		mov	dx, 5
		call	sub_1E653
		mov	al, 0Eh
		call	sub_1E582
		popa
		cmp	cs:word_1F38E, 1
		jz	short locret_1F1E6
		dec	cs:word_1F38E
		cmp	cs:word_1F386, 88h ; 'à'
		jnz	short loc_1F193
		jmp	loc_1F2DD
; ---------------------------------------------------------------------------

loc_1F193:				; CODE XREF: sub_1F16D+21j
		push	dx
		sub	cs:word_1F386, 10h
		call	sub_1F0CA
		sub	cs:word_1F386, 8
		call	sub_1F0CA
		sub	cs:word_1F386, 8
		call	sub_1F0CA
		sub	cs:word_1F386, 4
		call	sub_1F0CA
		sub	cs:word_1F386, 4
		call	sub_1F0CA
		sub	cs:word_1F386, 4
		call	sub_1F0CA
		sub	cs:word_1F386, 2
		call	sub_1F0CA
		sub	cs:word_1F386, 1
		call	sub_1F0CA
		sub	cs:word_1F386, 1
		call	sub_1F0CA
		pop	dx

locret_1F1E6:				; CODE XREF: sub_1F16D+13j
		retn
sub_1F16D	endp


; =============== S U B	R O U T	I N E =======================================


sub_1F1E7	proc near		; CODE XREF: sub_1EFB9+16p
					; sub_1EFB9+22p ...
		push	ax

loc_1F1E8:				; CODE XREF: sub_1F1E7+5j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1F1E8

loc_1F1EE:				; CODE XREF: sub_1F1E7+Bj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1F1EE
		pop	ax
		mov	ds, cs:word_1F38A
		mov	cx, 80h	; 'Ä'
		mov	si, cs:word_1F382
		mov	ax, cs:[si]
		or	ax, ax
		jz	short loc_1F213
		dec	ax
		shl	ax, 1
		sub	si, si
		push	dx
		call	sub_1F8C0
		pop	dx

loc_1F213:				; CODE XREF: sub_1F1E7+20j
		mov	ds, cs:word_1F38A
		mov	cx, 80h	; 'Ä'
		mov	si, cs:word_1F382
		mov	ax, cs:[si+2]
		or	ax, ax
		jz	short loc_1F235
		dec	ax
		shl	ax, 1
		sub	si, si
		add	dx, 30h	; '0'
		push	dx
		call	sub_1F8C0
		pop	dx

loc_1F235:				; CODE XREF: sub_1F1E7+3Fj
		mov	ds, cs:word_1F38A
		mov	cx, 80h	; 'Ä'
		mov	si, cs:word_1F382
		mov	ax, cs:[si+4]
		or	ax, ax
		jz	short loc_1F257
		dec	ax
		shl	ax, 1
		sub	si, si
		add	dx, 30h	; '0'
		push	dx
		call	sub_1F8C0
		pop	dx

loc_1F257:				; CODE XREF: sub_1F1E7+61j
		mov	ds, cs:word_1F38A
		mov	cx, 80h	; 'Ä'
		mov	si, cs:word_1F382
		mov	ax, cs:[si+6]
		or	ax, ax
		jz	short locret_1F279
		dec	ax
		shl	ax, 1
		sub	si, si
		add	dx, 30h	; '0'
		push	dx
		call	sub_1F8C0
		pop	dx

locret_1F279:				; CODE XREF: sub_1F1E7+83j
		retn
sub_1F1E7	endp

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_1F0F0

loc_1F27A:				; CODE XREF: sub_1F0F0+26j
		push	dx
		mov	cx, 6
		mov	dx, 90h	; 'ê'
		sub	dx, 10h
		push	cx
		push	dx
		call	sub_1F1E7
		pop	dx
		pop	cx
		sub	dx, 8
		push	cx
		push	dx
		call	sub_1F1E7
		pop	dx
		pop	cx
		sub	dx, 8
		push	cx
		push	dx
		call	sub_1F1E7
		pop	dx
		pop	cx
		sub	dx, 4
		push	cx
		push	dx
		call	sub_1F1E7
		pop	dx
		pop	cx
		sub	dx, 4
		push	cx
		push	dx
		call	sub_1F1E7
		pop	dx
		pop	cx
		sub	dx, 2
		push	cx
		push	dx
		call	sub_1F1E7
		pop	dx
		pop	cx
		sub	dx, 2
		push	cx
		push	dx
		call	sub_1F1E7
		pop	dx
		pop	cx
		sub	dx, 2
		push	cx
		push	dx
		call	sub_1F1E7
		pop	dx
		pop	cx
		sub	dx, 2
		push	cx
		push	dx
		call	sub_1F1E7
		pop	dx
		pop	cx
		pop	dx
		retn
; END OF FUNCTION CHUNK	FOR sub_1F0F0
; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_1F16D

loc_1F2DD:				; CODE XREF: sub_1F16D+23j
		push	dx
		mov	cx, 6
		mov	dx, 90h	; 'ê'
		sub	dx, 30h	; '0'
		add	dx, 10h
		push	cx
		push	dx
		call	sub_1F1E7
		pop	dx
		pop	cx
		add	dx, 8
		push	cx
		push	dx
		call	sub_1F1E7
		pop	dx
		pop	cx
		add	dx, 8
		push	cx
		push	dx
		call	sub_1F1E7
		pop	dx
		pop	cx
		add	dx, 4
		push	cx
		push	dx
		call	sub_1F1E7
		pop	dx
		pop	cx
		add	dx, 4
		push	cx
		push	dx
		call	sub_1F1E7
		pop	dx
		pop	cx
		add	dx, 2
		push	cx
		push	dx
		call	sub_1F1E7
		pop	dx
		pop	cx
		add	dx, 2
		push	cx
		push	dx
		call	sub_1F1E7
		pop	dx
		pop	cx
		add	dx, 2
		push	cx
		push	dx
		call	sub_1F1E7
		pop	dx
		pop	cx
		add	dx, 2
		push	cx
		push	dx
		call	sub_1F1E7
		pop	dx
		pop	cx
		pop	dx
		retn
; END OF FUNCTION CHUNK	FOR sub_1F16D
; ---------------------------------------------------------------------------
aC06_vdf	db 'c06.vdf',0          ; DATA XREF: LoadCockpit+87o
aNbl_vdf	db 'nbl.vdf',0          ; DATA XREF: LoadCockpit+50Ao
aCsrg_hdf	db 'csrg.hdf',0         ; DATA XREF: LoadCockpit+BDo
aMaing_hdf	db 'maing.hdf',0        ; DATA XREF: LoadCockpit+E8o
aSubg_hdf	db 'subg.hdf',0         ; DATA XREF: LoadCockpit+22Eo
aOptg_hdf	db 'optg.hdf',0         ; DATA XREF: LoadCockpit+3A2o
aNsc00_uso	db 'nsc00.uso',0        ; DATA XREF: LoadCockpit+70o
word_1F382	dw 0F39Ah		; DATA XREF: LoadCockpit+F7w
					; LoadCockpit+26Dw ...
word_1F384	dw 0			; DATA XREF: LoadCockpit+D3w
					; LoadCockpit+25Cw ...
word_1F386	dw 0			; DATA XREF: LoadCockpit+DAw
					; LoadCockpit+263w ...
word_1F388	dw 0			; DATA XREF: LoadCockpit:loc_1EB44w
					; LoadCockpit:loc_1EF67r ...
word_1F38A	dw 0			; DATA XREF: LoadCockpit:loc_1EB6Fw
					; LoadCockpit+1FEr ...
		db 2 dup(0)
word_1F38E	dw 0			; DATA XREF: LoadCockpit+FEw
					; LoadCockpit+125r ...
word_1F390	dw 0			; DATA XREF: LoadCockpit+109w
					; LoadCockpit+27Fw ...
word_1F392	dw 0			; DATA XREF: LoadCockpit+10Dw
					; LoadCockpit+1F9r ...
word_1F394	dw 0			; DATA XREF: LoadCockpit+114w
					; LoadCockpit+1D9w ...
word_1F396	dw 0			; DATA XREF: LoadCockpit+11Bw
					; LoadCockpit+291w ...
word_1F398	dw 1			; DATA XREF: sub_103E5+34w
					; sub_10486+40r ...
word_1F39A	dw 4, 0Ah dup(0)	; DATA XREF: sub_103E5+4Eo
					; sub_10486+60o ...
word_1F3B0	dw 1			; DATA XREF: sub_103E5+3Bw
					; sub_10486+48r ...
word_1F3B2	dw 1, 0Ah dup(0)	; DATA XREF: sub_103E5+5Do
					; sub_10486+6Fo ...
word_1F3C8	dw 0			; DATA XREF: sub_103E5+42w
					; sub_10486+50r ...
word_1F3CA	dw 0Ah dup(0)		; DATA XREF: sub_103E5+6Co
					; sub_10486+7Eo ...
		dw 0

; =============== S U B	R O U T	I N E =======================================


ShowMissionEnd	proc near		; CODE XREF: cmfA21_MissionEnd+3p
		push	es
		push	ds
		pusha
		mov	word ptr cs:0FFF1h, 0
		mov	word ptr cs:0FFF3h, 27Fh
		mov	cs:word_1F7EC, ax
		call	sub_1F7F2
		call	SetIO_A6_00
		call	SetIO_A4_00
		mov	al, 4Bh	; 'K'
		out	0A2h, al	; Interrupt Controller #2, 8259A
		mov	al, 0
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1
		push	ax

loc_1F407:				; CODE XREF: ShowMissionEnd+2Bj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1F407

loc_1F40D:				; CODE XREF: ShowMissionEnd+31j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1F40D
		pop	ax
		call	SetIO_A2A0
		sub	cx, cx
		sub	dx, dx
		call	sub_1E7A8
		jmp	short $+2
		jmp	short $+2
		mov	al, 4Bh	; 'K'
		out	0A2h, al	; Interrupt Controller #2, 8259A
		mov	al, 0
		jmp	short $+2
		jmp	short $+2
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1
		mov	ah, 0Dh
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		jmp	short $+2
		mov	cs:word_1F7EE, 90h ; 'ê'
		mov	dx, 0
		call	Music_Stop
		mov	ax, cs
		mov	ds, ax
		assume ds:seg000
		mov	si, offset aNsc05_uso ;	"nsc05.uso"
		sub	di, di
		call	Music_Load
		sub	si, si
		mov	dx, 0
		call	Music_Start
		call	sub_1DA00
		mov	ax, cs
		mov	ds, ax
		mov	dx, offset aC06b_vdf ; "c06b.vdf"
		call	LoadFile	; c06b.vdf
		jnb	short loc_1F467
		jmp	loc_1F56F
; ---------------------------------------------------------------------------

loc_1F467:				; CODE XREF: ShowMissionEnd+82j
		mov	ds, ax
		assume ds:nothing
		sub	si, si
		push	ds
		call	LoadGFXData
		mov	ax, 0Ah
		call	mdrGraphicEffect
		pop	ds
		push	es
		mov	ax, ds
		mov	es, ax
		mov	ah, 49h
		int	21h		; DOS -	2+ - FREE MEMORY
					; ES = segment address of area to be freed
		pop	es
		call	sub_1DA4F
		mov	word ptr cs:0FFF5h, 90h	; 'ê'
		mov	word ptr cs:0FFF7h, 120h
		mov	ax, cs
		mov	ds, ax
		assume ds:seg000
		mov	dx, offset aMaing_hdf_0	; "maing.hdf"
		call	LoadFile	; maing.hdf
		jnb	short loc_1F4A0
		jmp	loc_1F56F
; ---------------------------------------------------------------------------

loc_1F4A0:				; CODE XREF: ShowMissionEnd+BBj
		mov	cs:word_1F7F0, ax
		cmp	cs:word_1F7EC, 1
		jnz	short loc_1F4BB
		mov	si, offset word_1F39A
		mov	bx, offset word_1F799
		mov	di, offset word_1F398
		mov	dx, 3
		call	sub_1F593

loc_1F4BB:				; CODE XREF: ShowMissionEnd+CAj
		mov	si, offset word_1F39A
		mov	bx, offset word_1F799
		mov	di, offset word_1F398
		call	sub_1F573
		mov	ds, cs:word_1F7F0
		assume ds:nothing
		push	es
		mov	ax, ds
		mov	es, ax
		mov	ah, 49h
		int	21h		; DOS -	2+ - FREE MEMORY
					; ES = segment address of area to be freed
		pop	es
		mov	ax, cs
		mov	ds, ax
		assume ds:seg000
		mov	dx, offset aSubg_hdf_0 ; "subg.hdf"
		call	LoadFile	; subg.hdf
		jnb	short loc_1F4E5
		jmp	loc_1F56F
; ---------------------------------------------------------------------------

loc_1F4E5:				; CODE XREF: ShowMissionEnd+100j
		mov	cs:word_1F7F0, ax
		cmp	cs:word_1F7EC, 2
		jnz	short loc_1F500
		mov	si, offset word_1F3B2
		mov	bx, offset word_1F7A5
		mov	di, offset word_1F3B0
		mov	dx, 4
		call	sub_1F593

loc_1F500:				; CODE XREF: ShowMissionEnd+10Fj
		mov	si, offset word_1F3B2
		mov	bx, offset word_1F7A5
		mov	di, offset word_1F3B0
		call	sub_1F573
		mov	ds, cs:word_1F7F0
		assume ds:nothing
		push	es
		mov	ax, ds
		mov	es, ax
		mov	ah, 49h
		int	21h		; DOS -	2+ - FREE MEMORY
					; ES = segment address of area to be freed
		pop	es
		mov	ax, cs
		mov	ds, ax
		assume ds:seg000
		mov	dx, offset aOptg_hdf_0 ; "optg.hdf"
		call	LoadFile	; optg.hdf
		jb	short loc_1F56F
		mov	cs:word_1F7F0, ax
		cmp	cs:word_1F7EC, 3
		jnz	short loc_1F542
		mov	si, offset word_1F3CA
		mov	bx, offset word_1F7B1
		mov	di, offset word_1F3C8
		mov	dx, 3
		call	sub_1F593

loc_1F542:				; CODE XREF: ShowMissionEnd+151j
		mov	si, offset word_1F3CA
		mov	bx, offset word_1F7B1
		mov	di, offset word_1F3C8
		call	sub_1F573
		mov	ds, cs:word_1F7F0
		assume ds:nothing
		push	es
		mov	ax, ds
		mov	es, ax
		mov	ah, 49h
		int	21h		; DOS -	2+ - FREE MEMORY
					; ES = segment address of area to be freed
		pop	es

loc_1F55D:				; CODE XREF: ShowMissionEnd+184j
		call	TestUserInput
		test	dx, 0F0h
		jz	short loc_1F55D
		call	Music_FadeOut
		mov	ax, 0Bh
		call	mdrGraphicEffect

loc_1F56F:				; CODE XREF: ShowMissionEnd+84j
					; ShowMissionEnd+BDj ...
		popa
		pop	ds
		pop	es
		retn
ShowMissionEnd	endp


; =============== S U B	R O U T	I N E =======================================


sub_1F573	proc near		; CODE XREF: ShowMissionEnd+E4p
					; ShowMissionEnd+129p ...
		cmp	word ptr cs:[bx], 0
		jz	short locret_1F592
		mov	ax, cs:ScoreCounterL
		cmp	cs:[bx+2], ax
		jz	short loc_1F585
		jnb	short loc_1F58D

loc_1F585:				; CODE XREF: sub_1F573+Ej
		push	bx
		mov	dx, cs:[bx]
		call	sub_1F593
		pop	bx

loc_1F58D:				; CODE XREF: sub_1F573+10j
		add	bx, 4
		jmp	short sub_1F573
; ---------------------------------------------------------------------------

locret_1F592:				; CODE XREF: sub_1F573+4j
		retn
sub_1F573	endp


; =============== S U B	R O U T	I N E =======================================


sub_1F593	proc near		; CODE XREF: ShowMissionEnd+D8p
					; ShowMissionEnd+11Dp ...
		push	si
		mov	ax, cs
		mov	ds, ax
		assume ds:seg000

loc_1F598:				; CODE XREF: sub_1F593+Fj
		lodsw
		cmp	ax, 0
		jz	short loc_1F5A6
		cmp	ax, dx
		jz	short loc_1F5A4
		jmp	short loc_1F598
; ---------------------------------------------------------------------------

loc_1F5A4:				; CODE XREF: sub_1F593+Dj
		pop	si
		retn
; ---------------------------------------------------------------------------

loc_1F5A6:				; CODE XREF: sub_1F593+9j
		sub	si, 2
		mov	[si], dx
		inc	word ptr cs:[di]
		mov	ax, dx
		dec	ax
		shl	ax, 1
		call	sub_1F5BF
		add	cs:word_1F7EE, 30h ; '0'
		stc
		pop	si
		retn
sub_1F593	endp


; =============== S U B	R O U T	I N E =======================================


sub_1F5BF	proc near		; CODE XREF: sub_1F593+20p
		push	es
		push	ds
		pusha
		pusha
		mov	dx, 5
		call	sub_1E653
		mov	al, 0Dh
		call	sub_1E582
		popa
		push	ax

loc_1F5D0:				; CODE XREF: sub_1F5BF+15j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1F5D0

loc_1F5D6:				; CODE XREF: sub_1F5BF+1Bj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1F5D6
		pop	ax
		mov	dx, cs:word_1F7EE
		mov	cx, 80h	; 'Ä'
		mov	ds, cs:word_1F7F0
		assume ds:nothing
		sub	si, si
		push	dx
		call	sub_1F8C0
		pop	dx
		push	ax

loc_1F5F2:				; CODE XREF: sub_1F5BF+37j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1F5F2

loc_1F5F8:				; CODE XREF: sub_1F5BF+3Dj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1F5F8
		pop	ax
		push	ax

loc_1F600:				; CODE XREF: sub_1F5BF+45j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1F600

loc_1F606:				; CODE XREF: sub_1F5BF+4Bj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1F606
		pop	ax
		push	ax

loc_1F60E:				; CODE XREF: sub_1F5BF+53j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1F60E

loc_1F614:				; CODE XREF: sub_1F5BF+59j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1F614
		pop	ax
		push	ax

loc_1F61C:				; CODE XREF: sub_1F5BF+61j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1F61C

loc_1F622:				; CODE XREF: sub_1F5BF+67j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1F622
		pop	ax
		push	ax

loc_1F62A:				; CODE XREF: sub_1F5BF+6Fj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1F62A

loc_1F630:				; CODE XREF: sub_1F5BF+75j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1F630
		pop	ax
		push	ax

loc_1F638:				; CODE XREF: sub_1F5BF+7Dj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1F638

loc_1F63E:				; CODE XREF: sub_1F5BF+83j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1F63E
		pop	ax
		push	ax

loc_1F646:				; CODE XREF: sub_1F5BF+8Bj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1F646

loc_1F64C:				; CODE XREF: sub_1F5BF+91j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1F64C
		pop	ax
		push	ax

loc_1F654:				; CODE XREF: sub_1F5BF+99j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1F654

loc_1F65A:				; CODE XREF: sub_1F5BF+9Fj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1F65A
		pop	ax
		push	ax

loc_1F662:				; CODE XREF: sub_1F5BF+A7j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1F662

loc_1F668:				; CODE XREF: sub_1F5BF+ADj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1F668
		pop	ax
		push	ax

loc_1F670:				; CODE XREF: sub_1F5BF+B5j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1F670

loc_1F676:				; CODE XREF: sub_1F5BF+BBj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1F676
		pop	ax
		push	ax

loc_1F67E:				; CODE XREF: sub_1F5BF+C3j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1F67E

loc_1F684:				; CODE XREF: sub_1F5BF+C9j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1F684
		pop	ax
		push	ax

loc_1F68C:				; CODE XREF: sub_1F5BF+D1j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1F68C

loc_1F692:				; CODE XREF: sub_1F5BF+D7j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1F692
		pop	ax
		push	ax

loc_1F69A:				; CODE XREF: sub_1F5BF+DFj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1F69A

loc_1F6A0:				; CODE XREF: sub_1F5BF+E5j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1F6A0
		pop	ax
		push	ax

loc_1F6A8:				; CODE XREF: sub_1F5BF+EDj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1F6A8

loc_1F6AE:				; CODE XREF: sub_1F5BF+F3j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1F6AE
		pop	ax
		push	ax

loc_1F6B6:				; CODE XREF: sub_1F5BF+FBj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1F6B6

loc_1F6BC:				; CODE XREF: sub_1F5BF+101j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1F6BC
		pop	ax
		push	ax

loc_1F6C4:				; CODE XREF: sub_1F5BF+109j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1F6C4

loc_1F6CA:				; CODE XREF: sub_1F5BF+10Fj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1F6CA
		pop	ax
		push	ax

loc_1F6D2:				; CODE XREF: sub_1F5BF+117j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1F6D2

loc_1F6D8:				; CODE XREF: sub_1F5BF+11Dj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1F6D8
		pop	ax
		push	ax

loc_1F6E0:				; CODE XREF: sub_1F5BF+125j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1F6E0

loc_1F6E6:				; CODE XREF: sub_1F5BF+12Bj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1F6E6
		pop	ax
		push	ax

loc_1F6EE:				; CODE XREF: sub_1F5BF+133j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1F6EE

loc_1F6F4:				; CODE XREF: sub_1F5BF+139j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1F6F4
		pop	ax
		push	ax

loc_1F6FC:				; CODE XREF: sub_1F5BF+141j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1F6FC

loc_1F702:				; CODE XREF: sub_1F5BF+147j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1F702
		pop	ax
		push	ax

loc_1F70A:				; CODE XREF: sub_1F5BF+14Fj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1F70A

loc_1F710:				; CODE XREF: sub_1F5BF+155j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1F710
		pop	ax
		push	ax

loc_1F718:				; CODE XREF: sub_1F5BF+15Dj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1F718

loc_1F71E:				; CODE XREF: sub_1F5BF+163j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1F71E
		pop	ax
		push	ax

loc_1F726:				; CODE XREF: sub_1F5BF+16Bj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1F726

loc_1F72C:				; CODE XREF: sub_1F5BF+171j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1F72C
		pop	ax
		push	ax

loc_1F734:				; CODE XREF: sub_1F5BF+179j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1F734

loc_1F73A:				; CODE XREF: sub_1F5BF+17Fj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1F73A
		pop	ax
		push	ax

loc_1F742:				; CODE XREF: sub_1F5BF+187j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1F742

loc_1F748:				; CODE XREF: sub_1F5BF+18Dj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1F748
		pop	ax
		push	ax

loc_1F750:				; CODE XREF: sub_1F5BF+195j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1F750

loc_1F756:				; CODE XREF: sub_1F5BF+19Bj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1F756
		pop	ax
		push	ax

loc_1F75E:				; CODE XREF: sub_1F5BF+1A3j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1F75E

loc_1F764:				; CODE XREF: sub_1F5BF+1A9j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1F764
		pop	ax
		push	ax

loc_1F76C:				; CODE XREF: sub_1F5BF+1B1j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1F76C

loc_1F772:				; CODE XREF: sub_1F5BF+1B7j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1F772
		pop	ax
		push	ax

loc_1F77A:				; CODE XREF: sub_1F5BF+1BFj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1F77A

loc_1F780:				; CODE XREF: sub_1F5BF+1C5j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1F780
		pop	ax
		push	ax

loc_1F788:				; CODE XREF: sub_1F5BF+1CDj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1F788

loc_1F78E:				; CODE XREF: sub_1F5BF+1D3j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1F78E
		pop	ax
		popa
		pop	ds
		pop	es
		retn
sub_1F5BF	endp

; ---------------------------------------------------------------------------
word_1F799	dw 2, 1000		; DATA XREF: ShowMissionEnd+CFo
					; ShowMissionEnd+DEo
		dw 1, 3000
		dw 0, 0
word_1F7A5	dw 2, 2000		; DATA XREF: ShowMissionEnd+114o
					; ShowMissionEnd+123o
		dw 3, 4000
		dw 0, 0
word_1F7B1	dw 2, 6000		; DATA XREF: ShowMissionEnd+156o
					; ShowMissionEnd+165o
		dw 4, 8000
		dw 0, 0
aNsc05_uso	db 'nsc05.uso',0        ; DATA XREF: ShowMissionEnd+65o
aC06b_vdf	db 'c06b.vdf',0         ; DATA XREF: ShowMissionEnd+7Co
aMaing_hdf_0	db 'maing.hdf',0        ; DATA XREF: ShowMissionEnd+B5o
aSubg_hdf_0	db 'subg.hdf',0         ; DATA XREF: ShowMissionEnd+FAo
aOptg_hdf_0	db 'optg.hdf',0         ; DATA XREF: ShowMissionEnd+13Fo
word_1F7EC	dw 0			; DATA XREF: ShowMissionEnd+11w
					; ShowMissionEnd+C4r ...
word_1F7EE	dw 0			; DATA XREF: ShowMissionEnd+54w
					; sub_1F593+23w ...
word_1F7F0	dw 0			; DATA XREF: ShowMissionEnd:loc_1F4A0w
					; ShowMissionEnd+E7r ...

; =============== S U B	R O U T	I N E =======================================


sub_1F7F2	proc near		; CODE XREF: ShowMissionEnd+15p
		mov	bx, cs:word_13BB3
		shl	bx, 3
		add	bx, offset word_1F839
		mov	ax, cs:WeaponGun3
		mov	cs:[bx], ax
		mov	ax, cs:WeaponGun1
		mov	cs:[bx+2], ax
		mov	ax, cs:WeaponGun2
		mov	cs:[bx+4], ax
		mov	bx, cs:word_13CB9
		shl	bx, 3
		add	bx, offset word_1F859
		mov	ax, cs:WeaponSub3
		mov	cs:[bx], ax
		mov	ax, cs:WeaponSub1
		mov	cs:[bx+2], ax
		mov	ax, cs:WeaponSub2
		mov	cs:[bx+4], ax
		retn
sub_1F7F2	endp

; ---------------------------------------------------------------------------
word_1F839	dw 0, 0, 4, 0		; DATA XREF: sub_103E5+7Bo
					; sub_10486+8Do ...
		dw 0, 0, 4, 0
		dw 0, 0, 4, 0
		dw 0, 0, 4, 0
word_1F859	dw 0, 0, 8, 0		; DATA XREF: sub_103E5+8Ao
					; sub_10486+9Co ...
		dw 0, 0, 8, 0
		dw 0, 0, 8, 0
		dw 0, 0, 8, 0

; =============== S U B	R O U T	I N E =======================================


sub_1F879	proc near		; CODE XREF: LoadCockpit+4FAp
		mov	bx, cs:word_13BB3
		shl	bx, 3
		add	bx, offset word_1F839
		mov	ax, cs:[bx]
		mov	cs:WeaponGun3, ax
		mov	ax, cs:[bx+2]
		mov	cs:WeaponGun1, ax
		mov	ax, cs:[bx+4]
		mov	cs:WeaponGun2, ax
		mov	bx, cs:word_13CB9
		shl	bx, 3
		add	bx, offset word_1F859
		mov	ax, cs:[bx]
		mov	cs:WeaponSub3, ax
		mov	ax, cs:[bx+2]
		mov	cs:WeaponSub1, ax
		mov	ax, cs:[bx+4]
		mov	cs:WeaponSub2, ax
		retn
sub_1F879	endp


; =============== S U B	R O U T	I N E =======================================


sub_1F8C0	proc near		; CODE XREF: LoadCockpit+209p
					; LoadCockpit+37Dp ...
		push	bp
		shl	ax, 2
		add	si, ax
		add	si, 2
		lodsw
		xchg	ah, al
		mov	si, ax
		call	sub_1F8D3
		pop	bp
		retn
sub_1F8C0	endp


; =============== S U B	R O U T	I N E =======================================


sub_1F8D3	proc near		; CODE XREF: sub_1F8C0+Ep
		lodsw
		lodsw
		mov	bx, ax
		lodsw
		mov	di, ax
		xchg	bx, si
		shl	si, 3
		mov	cs:word_1FFDD, cx
		mov	cs:word_1FFDF, dx
		mov	cs:word_1FFE1, si
		mov	cs:word_1FFE3, di
		and	cl, 0Fh
		mov	cs:byte_1FC7F, cl
		and	cl, 7
		mov	cs:byte_1FB3B, cl
		mov	cs:byte_1FAFD, cl
		mov	cs:byte_1FD71, cl
		mov	cs:byte_1FB10, cl
		mov	cs:byte_1FB4E, cl
		mov	cs:byte_1FB21, cl
		mov	cs:byte_1FB5F, cl
		mov	cs:byte_1FD43, cl
		mov	cx, cs:word_1FFDD
		mov	al, 0FFh
		mov	cs:word_1FFE5, 0
		mov	cs:word_1FFE7, 0
		mov	cs:word_1FFE9, 0
		add	si, cx
		add	di, dx
		cmp	cx, cs:0FFF1h
		jge	short loc_1F954
		mov	cx, cs:0FFF1h
		xor	al, al

loc_1F954:				; CODE XREF: sub_1F8D3+78j
		cmp	si, cs:0FFF3h
		jle	short loc_1F96C
		sub	si, cs:0FFF3h
		mov	cs:word_1FFE5, si
		mov	si, cs:0FFF3h
		xor	al, al

loc_1F96C:				; CODE XREF: sub_1F8D3+86j
		cmp	cx, si
		jge	short locret_1F9B8
		sub	si, cx
		cmp	dx, cs:0FFF5h
		jge	short loc_1F98A
		mov	ax, cs:0FFF5h
		sub	ax, dx
		mov	cs:word_1FFE7, ax
		mov	dx, cs:0FFF5h
		xor	al, al

loc_1F98A:				; CODE XREF: sub_1F8D3+A4j
		cmp	di, cs:0FFF7h
		jle	short loc_1F9A2
		sub	di, cs:0FFF7h
		mov	cs:word_1FFE9, di
		mov	di, cs:0FFF7h
		xor	al, al

loc_1F9A2:				; CODE XREF: sub_1F8D3+BCj
		cmp	dx, di
		jge	short locret_1F9B8
		sub	di, dx
		or	al, al
		jz	short loc_1F9B1
		call	sub_1FD82
		jmp	short locret_1F9B8
; ---------------------------------------------------------------------------

loc_1F9B1:				; CODE XREF: sub_1F8D3+D7j
		push	bx
		push	bp
		call	sub_1F9BA
		pop	bp
		pop	bx

locret_1F9B8:				; CODE XREF: sub_1F8D3+9Bj
					; sub_1F8D3+D1j ...
		retn
sub_1F8D3	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_1F9BA	proc near		; CODE XREF: sub_1F8D3+E0p
		push	di
		push	si
		mov	di, dx
		shl	di, 2
		add	di, dx
		shl	di, 4
		mov	ax, cs:word_1FFDD
		sar	ax, 3
		add	di, ax
		sub	dx, cs:word_1FFDF
		mov	si, dx
		mov	ax, cs:word_1FFE1
		shr	ax, 3
		xor	dx, dx
		mul	si
		mov	si, ax
		add	si, bx
		pop	bx
		push	cx
		sub	cx, cs:word_1FFDD
		sar	cx, 3
		add	si, cx
		add	di, cx
		mov	bp, cs:word_1FFE5
		shr	bp, 3
		add	bp, cx
		mov	ax, bx
		mov	bx, cs:word_1FFE1
		shr	bx, 3
		sub	bx, bp
		dec	bx
		dec	bx
		pop	cx
		cmp	ax, 8
		jbe	short loc_1FA35
		push	cx
		mov	cx, cs:word_1FFE5
		and	cl, 7
		mov	al, 0FFh
		shl	al, cl
		mov	cs:0FFF0h, al
		pop	cx
		sub	cx, cs:word_1FFDD
		and	cl, 7
		mov	al, 0FFh
		shr	al, cl
		mov	cs:byte_1FFEF, al
		jmp	short loc_1FA62
; ---------------------------------------------------------------------------

loc_1FA35:				; CODE XREF: sub_1F9BA+55j
		mov	ch, cl
		mov	cl, al
		mov	ax, 0FFFFh
		shr	ax, cl
		mov	cl, ch
		xor	ch, ch
		sub	cx, cs:word_1FFDD
		and	cl, 7
		ror	ax, cl
		not	ax
		mov	cs:byte_1FFEF, ah
		mov	cs:0FFF0h, al
		test	bh, 80h
		jz	short loc_1FA60
		neg	bx
		sub	bp, bx

loc_1FA60:				; CODE XREF: sub_1F9BA+A0j
		xor	bx, bx

loc_1FA62:				; CODE XREF: sub_1F9BA+79j
		mov	cs:word_1FB07, bx
		mov	cs:word_1FB45, bx
		mov	ax, cs:word_1FFE1
		shr	ax, 3
		mov	cx, ax
		xor	dx, dx
		mul	cs:word_1FFE3
		shl	ax, 2
		mov	bx, ax
		add	bx, si
		mov	ax, cx
		mul	cs:word_1FFE7
		xchg	ax, cx
		mul	cs:word_1FFE9
		add	ax, cx
		mov	cs:word_1FFED, ax
		mov	ax, word ptr cs:byte_1FFEF
		not	ax
		mov	cs:word_1FFEB, ax
		pop	dx
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		push	dx
		push	bx
		push	di
		call	loc_1FB30
		pop	di
		pop	bx
		pop	dx
		add	si, cs:word_1FFED
		mov	ax, 0B000h
		mov	es, ax
		assume es:nothing
		push	dx
		push	bx
		push	di
		call	loc_1FB30
		pop	di
		pop	bx
		pop	dx
		add	si, cs:word_1FFED
		mov	ax, 0B800h
		mov	es, ax
		assume es:nothing
		push	dx
		push	bx
		push	di
		call	loc_1FB30
		pop	di
		pop	bx
		pop	dx
		add	si, cs:word_1FFED
		mov	ax, 0E000h
		mov	es, ax
		assume es:nothing
		push	dx
		push	bx
		push	di
		call	loc_1FB30
		pop	di
		pop	bx
		pop	dx
		add	si, cs:word_1FFED
		xor	al, al
		out	7Ch, al
		retn
sub_1F9BA	endp ; sp-analysis failed

; ---------------------------------------------------------------------------
		db 57h,	32h, 0E4h, 0ACh, 2Eh, 22h, 6, 0EFh, 0FFh, 0C1h
		db 0C8h
byte_1FAFD	db 0FFh			; DATA XREF: sub_1F8D3+30w
		db 26h,	8, 5, 26h, 8, 65h, 1, 47h, 0B9h
word_1FB07	dw 1234h		; DATA XREF: sub_1F9BA:loc_1FA62w
		db 0E3h, 0Ch, 32h, 0E4h, 0ACh, 0C1h, 0C8h
byte_1FB10	db 0FFh			; DATA XREF: sub_1F8D3+3Aw
		db 26h,	9, 5, 47h, 0E2h, 0F4h, 32h, 0E4h, 0ACh,	2Eh, 22h
		db 6, 0F0h, 0FFh, 0C1h,	0C8h
byte_1FB21	db 0FFh			; DATA XREF: sub_1F8D3+44w
					; seg000:FB9Bw
		db 26h,	9, 5, 3, 0F5h, 5Fh, 83h, 0C7h, 50h, 4Ah, 75h, 0C4h
		db 0C3h, 90h
; ---------------------------------------------------------------------------

loc_1FB30:				; CODE XREF: sub_1F9BA+EFp
					; sub_1F9BA+102p ...
		push	di
		sub	ah, ah
		lodsb
		and	al, cs:byte_1FFEF
; ---------------------------------------------------------------------------
		db 0C1h, 0C8h
byte_1FB3B	db 0FFh			; DATA XREF: sub_1F8D3+2Bw
byte_1FB3C	db 26h,	88h, 5,	26h, 88h, 65h, 1, 47h, 0B9h
word_1FB45	dw 1234h		; DATA XREF: sub_1F9BA+ADw
		db 0E3h, 0Ch, 32h, 0E4h, 0ACh, 0C1h, 0C8h
byte_1FB4E	db 0FFh			; DATA XREF: sub_1F8D3+3Fw
		db 26h,	89h, 5,	47h, 0E2h, 0F4h, 2Ah, 0E4h, 0ACh, 2Eh
		db 22h,	6, 0F0h, 0FFh, 0C1h, 0C8h
byte_1FB5F	db 0FFh			; DATA XREF: sub_1F8D3+49w
; ---------------------------------------------------------------------------
		mov	es:[di], ax
		add	si, bp
		pop	di
		add	di, 50h	; 'P'
		dec	dx
		jnz	short loc_1FB30
		retn
; ---------------------------------------------------------------------------
		align 2
		mov	cs:word_1FD17, si
		shr	si, 3
		mov	bp, si
		xchg	si, bx
		push	di
		xchg	di, dx
		mov	ax, di
		shl	di, 2
		add	di, ax
		shl	di, 4
		sar	cx, 3
		add	di, cx
		pop	dx
		mov	cx, bp
		jcxz	short loc_1FB93
		jmp	short loc_1FB96
; ---------------------------------------------------------------------------

loc_1FB93:				; CODE XREF: seg000:FB8Fj
		jmp	locret_1FD14
; ---------------------------------------------------------------------------

loc_1FB96:				; CODE XREF: seg000:FB91j
		mov	bp, 50h	; 'P'
		sub	bp, cx
		or	cs:byte_1FB21, 0
		jnz	short loc_1FC09
		mov	al, 0C0h ; '¿'
		out	7Ch, al
		sub	ah, ah
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		call	sub_1FD2A
		add	si, 6
		mov	ah, 0Fh
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		mov	al, 0CEh ; 'Œ'
		out	7Ch, al
		call	sub_1FD1A
		mov	al, 0CDh ; 'Õ'
		out	7Ch, al
		call	sub_1FD1A
		mov	al, 0CBh ; 'À'
		out	7Ch, al
		call	sub_1FD1A
		mov	al, 0C7h ; '«'
		out	7Ch, al
		call	sub_1FD1A
		xor	al, al
		out	7Ch, al
		jmp	locret_1FD14
; ---------------------------------------------------------------------------

loc_1FC09:				; CODE XREF: seg000:FBA1j
		mov	al, 0C0h ; '¿'
		out	7Ch, al
		sub	ah, ah
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		mov	ax, 0A800h
		mov	es, ax
		call	loc_1FD68
		add	si, 6
		xor	al, al
		out	7Ch, al
		mov	ax, 0A800h
		mov	es, ax
		call	loc_1FD3A
		mov	ax, 0B000h
		mov	es, ax
		assume es:nothing
		call	loc_1FD3A
		mov	ax, 0B800h
		mov	es, ax
		assume es:nothing
		call	loc_1FD3A
		mov	ax, 0E000h
		mov	es, ax
		assume es:nothing
		call	loc_1FD3A
		jmp	locret_1FD14
; ---------------------------------------------------------------------------
		db 52h,	0B0h, 80h, 0E6h, 7Ch, 0B0h, 7, 0E6h, 6Ah, 0B0h
		db 5, 0E6h, 6Ah, 0B8h, 2 dup(0), 0BAh, 0ACh, 4,	0EFh, 0B8h
		db 2 dup(0Ch), 0BAh, 0A4h, 4, 0EFh, 0B8h, 2 dup(0FFh)
		db 0BAh, 0A8h, 4, 0EFh,	0B8h, 2	dup(0),	0B0h
byte_1FC7F	db 0			; DATA XREF: sub_1F8D3+23w
; ---------------------------------------------------------------------------
		shl	al, 4
		mov	dx, 4ACh
		out	dx, ax
		mov	ax, cs:word_1FD17
		mov	dx, 4AEh
		out	dx, ax
		mov	ax, 0FFF0h
		mov	dx, 4A0h
		out	dx, ax
		pop	dx
		shr	cx, 1
		and	di, 0FFFEh
		and	bp, 0FFFEh
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		call	sub_1FD54
		add	si, 6
		push	dx
		mov	ax, 0CFCh
		mov	dx, 4A4h
		out	dx, ax
		mov	ax, 0FFFEh
		mov	dx, 4A0h
		out	dx, ax
		mov	ax, cs:word_1FD17
		mov	dx, 4AEh
		out	dx, ax
		pop	dx
		call	sub_1FD54
		push	dx
		mov	ax, 0FFFDh
		mov	dx, 4A0h
		out	dx, ax
		mov	ax, cs:word_1FD17
		mov	dx, 4AEh
		out	dx, ax
		pop	dx
		call	sub_1FD54
		push	dx
		mov	ax, 0FFFBh
		mov	dx, 4A0h
		out	dx, ax
		mov	ax, cs:word_1FD17
		mov	dx, 4AEh
		out	dx, ax
		pop	dx
		call	sub_1FD54
		push	dx
		mov	ax, 0FFF7h
		mov	dx, 4A0h
		out	dx, ax
		mov	ax, cs:word_1FD17
		mov	dx, 4AEh
		out	dx, ax
		pop	dx
		call	sub_1FD54
		mov	ax, 0FFF0h
		mov	dx, 4A0h
		out	dx, ax
		mov	al, 4
		out	6Ah, al
		mov	al, 6
		out	6Ah, al
		mov	al, 0
		out	7Ch, al

locret_1FD14:				; CODE XREF: seg000:loc_1FB93j
					; seg000:FC06j	...
		retn
; ---------------------------------------------------------------------------
		db 2 dup(0)
word_1FD17	dw 0			; DATA XREF: seg000:FB6Ew seg000:FC87r ...
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_1FD1A	proc near		; CODE XREF: seg000:FBEAp seg000:FBF1p ...
		push	dx
		push	bx
		push	di

loc_1FD1D:				; CODE XREF: sub_1FD1A+Aj
		push	cx
		rep movsb
		pop	cx
		add	di, bp
		dec	dx
		jnz	short loc_1FD1D
		pop	di
		pop	bx
		pop	dx
		retn
sub_1FD1A	endp


; =============== S U B	R O U T	I N E =======================================


sub_1FD2A	proc near		; CODE XREF: seg000:FBC6p
		push	dx
		push	bx
		push	di

loc_1FD2D:				; CODE XREF: sub_1FD2A+Aj
		push	cx
		rep movsb
		pop	cx
		add	di, bp
		dec	dx
		jnz	short loc_1FD2D
		pop	di
		pop	bx
		pop	dx
		retn
sub_1FD2A	endp

; ---------------------------------------------------------------------------

loc_1FD3A:				; CODE XREF: seg000:FC3Bp seg000:FC43p ...
		push	dx
		push	bx
		push	di

loc_1FD3D:				; CODE XREF: seg000:FD4Ej
		push	cx

loc_1FD3E:				; CODE XREF: seg000:FD48j
		sub	ah, ah
		lodsb
; ---------------------------------------------------------------------------
		db 0C1h, 0C8h
byte_1FD43	db 0FFh			; DATA XREF: sub_1F8D3+4Ew
; ---------------------------------------------------------------------------
		or	es:[di], ax
		inc	di
		loop	loc_1FD3E
		pop	cx
		add	di, bp
		dec	dx
		jnz	short loc_1FD3D
		pop	di
		pop	bx
		pop	dx
		retn

; =============== S U B	R O U T	I N E =======================================


sub_1FD54	proc near		; CODE XREF: seg000:FCA4p seg000:FCC2p ...
		push	dx
		push	bx
		push	di

loc_1FD57:				; CODE XREF: sub_1FD54+Ej
		push	cx
		rep movsw
		stosw
		sub	di, 2
		pop	cx
		add	di, bp
		dec	dx
		jnz	short loc_1FD57
		pop	di
		pop	bx
		pop	dx
		retn
sub_1FD54	endp

; ---------------------------------------------------------------------------

loc_1FD68:				; CODE XREF: seg000:FC2Cp
		push	dx
		push	bx
		push	di

loc_1FD6B:				; CODE XREF: seg000:FD7Cj
		push	cx

loc_1FD6C:				; CODE XREF: seg000:FD76j
		sub	ah, ah
		lodsb
; ---------------------------------------------------------------------------
		db 0C1h, 0C8h
byte_1FD71	db 0FFh			; DATA XREF: sub_1F8D3+35w
; ---------------------------------------------------------------------------
		mov	es:[di], ax
		inc	di
		loop	loc_1FD6C
		pop	cx
		add	di, bp
		dec	dx
		jnz	short loc_1FD6B
		pop	di
		pop	bx
		pop	dx
		retn

; =============== S U B	R O U T	I N E =======================================


sub_1FD82	proc near		; CODE XREF: sub_1F8D3+D9p
		shr	si, 3
		mov	bp, si
		xchg	si, bx
		push	di
		xchg	di, dx
		mov	ax, di
		shl	di, 2
		add	di, ax
		shl	di, 4
		sar	cx, 3
		add	di, cx
		pop	dx
		mov	cx, bp
		jcxz	short locret_1FDC7
		mov	bp, 50h	; 'P'
		sub	bp, cx
		mov	ax, 0A800h
		mov	es, ax
		call	sub_1FDC8
		mov	ax, 0B000h
		mov	es, ax
		assume es:nothing
		call	sub_1FDC8
		mov	ax, 0B800h
		mov	es, ax
		assume es:nothing
		call	sub_1FDC8
		mov	ax, 0E000h
		mov	es, ax
		assume es:nothing
		call	sub_1FDC8
		jmp	short $+2

locret_1FDC7:				; CODE XREF: sub_1FD82+1Cj
		retn
sub_1FD82	endp


; =============== S U B	R O U T	I N E =======================================


sub_1FDC8	proc near		; CODE XREF: sub_1FD82+28p
					; sub_1FD82+30p ...
		push	dx
		push	bx
		push	di

loc_1FDCB:				; CODE XREF: sub_1FDC8+Aj
		push	cx
		rep movsb
		pop	cx
		add	di, bp
		dec	dx
		jnz	short loc_1FDCB
		pop	di
		pop	bx
		pop	dx
		retn
sub_1FDC8	endp

; ---------------------------------------------------------------------------
		push	dx
		push	bx
		push	di

loc_1FDDB:				; CODE XREF: seg000:FDE2j
		push	cx
		rep movsb
		pop	cx
		add	di, bp
		dec	dx
		jnz	short loc_1FDDB
		pop	di
		pop	bx
		pop	dx
		retn

; =============== S U B	R O U T	I N E =======================================


sub_1FDE8	proc near		; CODE XREF: sub_1F087+3Dp
		pusha
		push	es
		mov	bx, si
		cmp	cx, bx
		jbe	short loc_1FDF2
		xchg	cx, bx

loc_1FDF2:				; CODE XREF: sub_1FDE8+6j
		sub	bx, cx
		jnz	short loc_1FDF9
		jmp	loc_1FEFF
; ---------------------------------------------------------------------------

loc_1FDF9:				; CODE XREF: sub_1FDE8+Cj
		cmp	dx, di
		jbe	short loc_1FDFF
		xchg	dx, di

loc_1FDFF:				; CODE XREF: sub_1FDE8+13j
		sub	di, dx
		jnz	short loc_1FE06
		jmp	loc_1FEFF
; ---------------------------------------------------------------------------

loc_1FE06:				; CODE XREF: sub_1FDE8+19j
		push	ax
		mov	bp, di
		mov	di, dx
		shl	di, 2
		add	di, dx
		shl	di, 4
		mov	ax, cx
		shr	ax, 3
		add	di, ax
		shl	ax, 3
		sub	cx, ax
		cmp	bx, 8
		jb	short loc_1FE98
		sub	bx, 8
		mov	dx, 0FF00h
		jcxz	short loc_1FE35
		add	bx, cx
		mov	ax, 0FFh
		shr	ax, cl
		mov	dh, al

loc_1FE35:				; CODE XREF: sub_1FDE8+42j
		mov	cx, bx
		shr	bx, 3
		mov	si, bx
		shl	bx, 3
		sub	cx, bx
		jcxz	short loc_1FE4A
		mov	ax, 0FF00h
		shr	ax, cl
		mov	dl, al

loc_1FE4A:				; CODE XREF: sub_1FDE8+59j
		pop	ax
		mov	al, 0FFh
		mov	bx, dx
		mov	dx, bp
		mov	bp, 4Fh	; 'O'
		sub	bp, si
		shl	ah, 1
		jb	short loc_1FE66
		mov	cx, 0A800h
		mov	es, cx
		assume es:nothing
		push	dx
		push	di
		call	sub_1FF02
		pop	di
		pop	dx

loc_1FE66:				; CODE XREF: sub_1FDE8+70j
		shl	ah, 1
		jb	short loc_1FE76
		mov	cx, 0B000h
		mov	es, cx
		assume es:nothing
		push	dx
		push	di
		call	sub_1FF02
		pop	di
		pop	dx

loc_1FE76:				; CODE XREF: sub_1FDE8+80j
		shl	ah, 1
		jb	short loc_1FE86
		mov	cx, 0B800h
		mov	es, cx
		assume es:nothing
		push	dx
		push	di
		call	sub_1FF02
		pop	di
		pop	dx

loc_1FE86:				; CODE XREF: sub_1FDE8+90j
		shl	ah, 1
		jb	short loc_1FE96
		mov	cx, 0E000h
		mov	es, cx
		assume es:nothing
		push	dx
		push	di
		call	sub_1FF02
		pop	di
		pop	dx

loc_1FE96:				; CODE XREF: sub_1FDE8+A0j
		jmp	short loc_1FEFF
; ---------------------------------------------------------------------------

loc_1FE98:				; CODE XREF: sub_1FDE8+3Aj
		pop	dx
		mov	ch, cl
		mov	cl, bl
		mov	ax, 0FFh
		rcr	ax, cl
		xor	al, al
		mov	cl, ch
		shr	ax, cl
		mov	si, 50h	; 'P'
		mov	cx, bp
		xchg	ah, al
		shl	dh, 1
		jb	short loc_1FEC3
		mov	bx, 0A800h
		mov	es, bx
		assume es:nothing
		push	cx
		push	di

loc_1FEBA:				; CODE XREF: sub_1FDE8+D7j
		xor	es:[di], ax
		add	di, si
		loop	loc_1FEBA
		pop	di
		pop	cx

loc_1FEC3:				; CODE XREF: sub_1FDE8+C9j
		shl	dh, 1
		jb	short loc_1FED7
		mov	bx, 0B000h
		mov	es, bx
		assume es:nothing
		push	cx
		push	di

loc_1FECE:				; CODE XREF: sub_1FDE8+EBj
		xor	es:[di], ax
		add	di, si
		loop	loc_1FECE
		pop	di
		pop	cx

loc_1FED7:				; CODE XREF: sub_1FDE8+DDj
		shl	dh, 1
		jb	short loc_1FEEB
		mov	bx, 0B800h
		mov	es, bx
		assume es:nothing
		push	cx
		push	di

loc_1FEE2:				; CODE XREF: sub_1FDE8+FFj
		xor	es:[di], ax
		add	di, si
		loop	loc_1FEE2
		pop	di
		pop	cx

loc_1FEEB:				; CODE XREF: sub_1FDE8+F1j
		shl	dh, 1
		jb	short loc_1FEFF
		mov	bx, 0E000h
		mov	es, bx
		assume es:nothing
		push	cx
		push	di

loc_1FEF6:				; CODE XREF: sub_1FDE8+113j
		xor	es:[di], ax
		add	di, si
		loop	loc_1FEF6
		pop	di
		pop	cx

loc_1FEFF:				; CODE XREF: sub_1FDE8+Ej
					; sub_1FDE8+1Bj ...
		pop	es
		assume es:nothing
		popa
		retn
sub_1FDE8	endp


; =============== S U B	R O U T	I N E =======================================


sub_1FF02	proc near		; CODE XREF: sub_1FDE8+79p
					; sub_1FDE8+89p ...
		xor	es:[di], bh
		inc	di
		mov	cx, si
		jcxz	short loc_1FF10

loc_1FF0A:				; CODE XREF: sub_1FF02+Cj
		xor	es:[di], al
		inc	di
		loop	loc_1FF0A

loc_1FF10:				; CODE XREF: sub_1FF02+6j
		xor	es:[di], bl
		add	di, bp
		dec	dx
		jnz	short sub_1FF02
		retn
sub_1FF02	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_1FF1A	proc near		; CODE XREF: LoadCockpit+24Bp
					; LoadCockpit+3BFp
		pusha
		push	es
		mov	bx, si
		cmp	cx, bx
		jbe	short loc_1FF24
		xchg	cx, bx

loc_1FF24:				; CODE XREF: sub_1FF1A+6j
		sub	bx, cx
		jnz	short loc_1FF2B
		jmp	loc_1FFD6
; ---------------------------------------------------------------------------

loc_1FF2B:				; CODE XREF: sub_1FF1A+Cj
		cmp	dx, di
		jbe	short loc_1FF31
		xchg	dx, di

loc_1FF31:				; CODE XREF: sub_1FF1A+13j
		sub	di, dx
		jnz	short loc_1FF38
		jmp	loc_1FFD6
; ---------------------------------------------------------------------------

loc_1FF38:				; CODE XREF: sub_1FF1A+19j
		inc	bx
		inc	di
		mov	al, 0C0h ; '¿'
		out	7Ch, al
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		ror	ah, 1
		sbb	al, al
		out	7Eh, al
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		mov	bp, di
		mov	di, dx
		shl	di, 2
		add	di, dx
		shl	di, 4
		mov	ax, cx
		shr	ax, 3
		add	di, ax
		shl	ax, 3
		sub	cx, ax
		cmp	bx, 8
		jb	short loc_1FFBB
		sub	bx, 8
		mov	dx, 0FF00h
		jcxz	short loc_1FF89
		add	bx, cx
		mov	ax, 0FFh
		shr	ax, cl
		mov	dh, al

loc_1FF89:				; CODE XREF: sub_1FF1A+64j
		mov	cx, bx
		shr	bx, 3
		mov	si, bx
		shl	bx, 3
		sub	cx, bx
		jcxz	short loc_1FF9E
		mov	ax, 0FF00h
		shr	ax, cl
		mov	dl, al

loc_1FF9E:				; CODE XREF: sub_1FF1A+7Bj
		mov	al, 0FFh
		mov	bx, dx
		mov	dx, bp
		mov	bp, 4Fh	; 'O'
		sub	bp, si

loc_1FFA9:				; CODE XREF: sub_1FF1A+9Dj
		mov	es:[di], bh
		inc	di
		mov	cx, si
		rep stosb
		mov	es:[di], bl
		add	di, bp
		dec	dx
		jnz	short loc_1FFA9
		jmp	short loc_1FFD6
; ---------------------------------------------------------------------------

loc_1FFBB:				; CODE XREF: sub_1FF1A+5Cj
		mov	ch, cl
		mov	cl, bl
		mov	ax, 0FFh
		rcr	ax, cl
		xor	al, al
		mov	cl, ch
		shr	ax, cl
		mov	si, 4Eh	; 'N'
		mov	cx, bp
		xchg	ah, al

loc_1FFD1:				; CODE XREF: sub_1FF1A+BAj
		stosw
		add	di, si
		loop	loc_1FFD1

loc_1FFD6:				; CODE XREF: sub_1FF1A+Ej
					; sub_1FF1A+1Bj ...
		xor	al, al
		out	7Ch, al
		pop	es
		assume es:nothing
		popa
		retn
sub_1FF1A	endp

; ---------------------------------------------------------------------------
word_1FFDD	dw 0			; DATA XREF: sub_1F8D3+Cw
					; sub_1F8D3+53r ...
word_1FFDF	dw 0			; DATA XREF: sub_1F8D3+11w
					; sub_1F9BA+15r
word_1FFE1	dw 0			; DATA XREF: sub_1F8D3+16w
					; sub_1F9BA+1Cr ...
word_1FFE3	dw 0			; DATA XREF: sub_1F8D3+1Bw
					; sub_1F9BA+BDr
word_1FFE5	dw 0			; DATA XREF: sub_1F8D3+5Aw
					; sub_1F8D3+8Dw ...
word_1FFE7	dw 0			; DATA XREF: sub_1F8D3+61w
					; sub_1F8D3+ACw ...
word_1FFE9	dw 0			; DATA XREF: sub_1F8D3+68w
					; sub_1F8D3+C3w ...
word_1FFEB	dw 0			; DATA XREF: sub_1F9BA+E2w
word_1FFED	dw 0			; DATA XREF: sub_1F9BA+D8w
					; sub_1F9BA+F5r ...
byte_1FFEF	db 0			; DATA XREF: sub_1F9BA+75w
					; sub_1F9BA+94w ...
seg000		ends

; ===========================================================================

; Segment type:	Regular
seg001		segment	byte public 'UNK' use16
		assume cs:seg001
		assume es:nothing, ss:nothing, ds:nothing, fs:nothing, gs:nothing
unk_1FFF0	db    0			; DATA XREF: sub_1F9BA+64w
					; sub_1F9BA+99w
word_1FFF1	dw 0			; DATA XREF: LoadCockpit+58w
					; ShowMissionEnd+3w ...
word_1FFF3	dw 27Fh			; DATA XREF: LoadCockpit+5Fw
					; ShowMissionEnd+Aw ...
word_1FFF5	dw 90h			; DATA XREF: LoadCockpit:loc_1EC47w
					; LoadCockpit+24Ew ...
word_1FFF7	dw 120h			; DATA XREF: LoadCockpit+1D2w
					; LoadCockpit+255w ...
		align 2
byte_1FFFA	db    1,   1,	2,   2,	  4,   8,   4,	 8, 20h, 10h
		db    1,   2,	1,   2,	  4,   8,   4,	 8, 10h, 10h
		db    1,   8,	2,   4,	  1,   8,   2,	 4,   2,   1
		db    1,   1,	2,   2,	  4,   4,   8,	 8, 10h, 20h
		db    4,   2,	4,   2,	  8,   1,   8,	 1, 20h, 10h
		db    8,   2,	8,   2,	  4,   1,   4,	 1, 20h, 10h
		db    1,   8,	2,   4,	  1,   8,   2,	 4, 20h, 10h
		db    4,   8,	4,   8,	  4,   4,   8,	 8,   2,   1
aRay__hdf	db 'Ray_.hdf',0         ; DATA XREF: SetupAction+5o
aSmoke_hdf	db 'smoke.hdf',0        ; DATA XREF: SetupAction+14o
aShot_hdf	db 'shot.hdf',0         ; DATA XREF: SetupAction+23o
aTool_hdf	db 'tool.hdf',0         ; DATA XREF: SetupAction+32o
aBang3_hdf	db 'bang3.hdf',0        ; DATA XREF: SetupAction+41o
aItemp_hdf	db 'itemp.hdf',0        ; DATA XREF: SetupAction+5Fo
aPgage_hdf	db 'pgage.hdf',0        ; DATA XREF: SetupAction+6Eo
aEshot6_hdf	db 'ESHOT6.hdf',0       ; DATA XREF: SetupAction+7Do
aEfire_hdf	db 'EFire.hdf',0        ; DATA XREF: SetupAction+8Co
aEshot1_hdf	db 'ESHOT1.hdf',0       ; DATA XREF: SetupAction+98o
aNs_e1_hdf	db 'ns_e1.hdf',0        ; DATA XREF: SetupAction+A4o
aSfan_hdf	db 'sfan.hdf',0         ; DATA XREF: sub_10E2F+21o
aShoth_hdf	db 'shoth.hdf',0        ; DATA XREF: SetupAction+50o
aNsse01_uso	db 'nsse01.uso',0
aNsse02_uso	db 'nsse02.uso',0
aNsse03_uso	db 'nsse03.uso',0
aNsse04_uso	db 'nsse04.uso',0
aNsse05_uso	db 'nsse05.uso',0
aNsse06_uso	db 'nsse06.uso',0
aNsse07_uso	db 'nsse07.uso',0
aNsse08_uso	db 'nsse08.uso',0
aNsse09_uso	db 'nsse09.uso',0
aNsse10_uso	db 'nsse10.uso',0
aNsse11_uso	db 'nsse11.uso',0
aNsse46_uso	db 'nsse46.uso',0
aNsse79_uso	db 'nsse79.uso',0
aNsse30_uso	db 'nsse30.uso',0
aNsse50_uso	db 'nsse50.uso',0
		db 3 dup(0), 1,	0, 84h,	3, 32h,	29h dup(0), 1, 0Ch dup(0)
		db 0A0h, 80h, 0Ch, 2 dup(0), 10h, 3 dup(0), 10h, 11h dup(0)
		db 2 dup(0FFh),	40h dup(0), 1, 0, 0C0h,	0FEh, 32h, 29h dup(0)
		db 1, 0Ch dup(0), 0A0h,	80h, 0Ch, 2 dup(0), 10h, 3 dup(0)
		db 10h,	11h dup(0), 2 dup(0FFh), 3Eh dup(0)
byte_202A0	db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 1, 0, 0, 0FFh,	0FFh
					; DATA XREF: sub_14567+Fo seg000:45FBo ...
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 1, 0, 0, 0FFh,	0FFh
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 1, 0, 0, 0FFh,	0FFh
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 1, 0, 0, 0FFh,	0FFh
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 1, 0, 0, 0FFh,	0FFh
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 1, 0, 0, 0FFh,	0FFh
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 1, 0, 0, 0FFh,	0FFh
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 1, 0, 0, 0FFh,	0FFh
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 1, 0, 0, 0FFh,	0FFh
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 1, 0, 0, 0FFh,	0FFh
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 1, 0, 0, 0FFh,	0FFh
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 1, 0, 0, 0FFh,	0FFh
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 1, 0, 0, 0FFh,	0FFh
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 1, 0, 0, 0FFh,	0FFh
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 1, 0, 0, 0FFh,	0FFh
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 1, 0, 0, 0FFh,	0FFh
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 1, 0, 0, 0FFh,	0FFh
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 1, 0, 0, 0FFh,	0FFh
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 1, 0, 0, 0FFh,	0FFh
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 1, 0, 0, 0FFh,	0FFh
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 1, 0, 0, 0FFh,	0FFh
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 1, 0, 0, 0FFh,	0FFh
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 1, 0, 0, 0FFh,	0FFh
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 1, 0, 0, 0FFh,	0FFh
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 1, 0, 0, 0FFh,	0FFh
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 1, 0, 0, 0FFh,	0FFh
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 1, 0, 0, 0FFh,	0FFh
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 1, 0, 0, 0FFh,	0FFh
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 1, 0, 0, 0FFh,	0FFh
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 1, 0, 0, 0FFh,	0FFh
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 1, 0, 0, 0FFh,	0FFh
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 1, 0, 0, 0FFh,	0FFh
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 1, 0, 0, 0FFh,	0FFh
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 1, 0, 0, 0FFh,	0FFh
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 1, 0, 0, 0FFh,	0FFh
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 1, 0, 0, 0FFh,	0FFh
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 1, 0, 0, 0FFh,	0FFh
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 1, 0, 0, 0FFh,	0FFh
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 1, 0, 0, 0FFh,	0FFh
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 1, 0, 0, 0FFh,	0FFh
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 1, 0, 0, 0FFh,	0FFh
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 1, 0, 0, 0FFh,	0FFh
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 1, 0, 0, 0FFh,	0FFh
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 1, 0, 0, 0FFh,	0FFh
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 1, 0, 0, 0FFh,	0FFh
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 1, 0, 0, 0FFh,	0FFh
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 1, 0, 0, 0FFh,	0FFh
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 1, 0, 0, 0FFh,	0FFh
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 1, 0, 0, 0FFh,	0FFh
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 1, 0, 0, 0FFh,	0FFh
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 1, 0, 0, 0FFh,	0FFh
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 1, 0, 0, 0FFh,	0FFh
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 1, 0, 0, 0FFh,	0FFh
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 1, 0, 0, 0FFh,	0FFh
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 1, 0, 0, 0FFh,	0FFh
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 1, 0, 0, 0FFh,	0FFh
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 1, 0, 0, 0FFh,	0FFh
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 1, 0, 0, 0FFh,	0FFh
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 1, 0, 0, 0FFh,	0FFh
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 1, 0, 0, 0FFh,	0FFh
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 1, 0, 0, 0FFh,	0FFh
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 1, 0, 0, 0FFh,	0FFh
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 1, 0, 0, 0FFh,	0FFh
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 1, 0, 0, 0FFh,	0FFh
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 1, 0, 0, 0FFh,	0FFh
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 1, 0, 0, 0FFh,	0FFh
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 1, 0, 0, 0FFh,	0FFh
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 1, 0, 0, 0FFh,	0FFh
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 1, 0, 0, 0FFh,	0FFh
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 1, 0, 0, 0FFh,	0FFh
byte_208EA	db 1C2h	dup(0)		; DATA XREF: sub_15EF8+11o
					; sub_1654D+8o
byte_20AAC	db 3A4h	dup(0)		; DATA XREF: sub_18188+86o
					; sub_1823E+2Ao ...
byte_20E50	db 3ADCh dup(0)		; DATA XREF: SetupAction+F6o
byte_2492C	db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 8, 0, 1, 0
					; DATA XREF: sub_18BDE+Fo sub_18C3F+5o
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 8, 0, 1, 0
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 8, 0, 1, 0
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 8, 0, 1, 0
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 8, 0, 1, 0
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 8, 0, 1, 0
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 8, 0, 1, 0
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 8, 0, 1, 0
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 8, 0, 1, 0
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 8, 0, 1, 0
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 8, 0, 1, 0
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 8, 0, 1, 0
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 8, 0, 1, 0
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 8, 0, 1, 0
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 8, 0, 1, 0
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 8, 0, 1, 0
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 8, 0, 1, 0
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 8, 0, 1, 0
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 8, 0, 1, 0
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 8, 0, 1, 0
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 8, 0, 1, 0
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 8, 0, 1, 0
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 8, 0, 1, 0
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 8, 0, 1, 0
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 8, 0, 1, 0
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 8, 0, 1, 0
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 8, 0, 1, 0
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 8, 0, 1, 0
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 8, 0, 1, 0
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 8, 0, 1, 0
a00		db '00',0
aDebugInfomatio	db 'DEBUG INFOMATION MODE',0 ; DATA XREF: DrawDebugInfo+52o
aMapX00000000	db 'MAP X  : 0000 (0000)',0 ; DATA XREF: DrawDebugInfo+F9o
					; DrawDebugInfo+C5w ...
aMapY00000000	db 'MAP Y  : 0000 (0000)',0 ; DATA XREF: DrawDebugInfo+1A0o
					; DrawDebugInfo+16Cw ...
aSprite0000	db 'SPRITE : 0000',0    ; DATA XREF: DrawDebugInfo+1FAo
					; DrawDebugInfo+1C6w ...
aEnemyObject006	db 'ENEMY OBJECT : 00 / 60',0 ; DATA XREF: DrawDebugInfo+22Ao
					; DrawDebugInfo+218w
SpriteObjs	SpriteObject 0C8h dup(<0>) ; DATA XREF:	AddSprite+11o
					; DrawSpriteLayero
		db 6B0h	dup(0)
word_25C1A	dw 0E10h dup(10Fh)	; DATA XREF: sub_1AAC8+B0o
					; sub_1AAC8+161o ...
word_2783A	dw 0, 0			; DATA XREF: sub_1BA1A+43o
word_2783E	dw 0E10h dup(10Fh)	; DATA XREF: sub_1AAC8+10Co
					; sub_1AAC8+189o ...
word_2945E	dw 0, 0			; DATA XREF: sub_1BA1A+48o
word_29462	dw 0E10h dup(10Fh)	; DATA XREF: sub_1AAC8+DAo
					; sub_1AAC8+31Co ...
word_2B082	dw 0, 0			; DATA XREF: sub_1BA1A+4Do
word_2B086	dw 0E10h dup(10Fh)	; DATA XREF: sub_1AAC8+130o
					; sub_1AAC8+38Fo ...
word_2CCA6	dw 0, 0			; DATA XREF: sub_1BA1A+52o
word_2CCAA	dw     0,    6,	 0Dh,  13h,  19h,  1Fh,	 26h,  2Ch
					; DATA XREF: sub_1BE93+14r
		dw   32h,  38h,	 3Eh,  44h,  4Ah,  50h,	 56h,  5Ch
		dw   62h,  68h,	 6Dh,  73h,  79h,  7Eh,	 84h,  89h
		dw   8Eh,  93h,	 98h,  9Dh, 0A2h, 0A7h,	0ACh, 0B1h
		dw  0B5h, 0B9h,	0BEh, 0C2h, 0C6h, 0CAh,	0CEh, 0D1h
		dw  0D5h, 0D8h,	0DCh, 0DFh, 0E2h, 0E5h,	0E7h, 0EAh
		dw  0EDh, 0EFh,	0F1h, 0F3h, 0F5h, 0F7h,	0F8h, 0FAh
		dw  0FBh, 0FCh,	0FDh, 0FEh, 0FFh, 0FFh,	100h, 100h
word_2CD2A	dw  100h, 100h,	100h, 0FFh, 0FFh, 0FEh,	0FDh, 0FCh
					; DATA XREF: sub_1BE93+10r
		dw  0FBh, 0FAh,	0F8h, 0F7h, 0F5h, 0F3h,	0F1h, 0EFh
		dw  0EDh, 0EAh,	0E7h, 0E5h, 0E2h, 0DFh,	0DCh, 0D8h
		dw  0D5h, 0D1h,	0CEh, 0CAh, 0C6h, 0C2h,	0BEh, 0B9h
		dw  0B5h, 0B1h,	0ACh, 0A7h, 0A2h,  9Dh,	 98h,  93h
		dw   8Eh,  89h,	 84h,  7Eh,  79h,  73h,	 6Dh,  68h
		dw   62h,  5Ch,	 56h,  50h,  4Ah,  44h,	 3Eh,  38h
		dw   32h,  2Ch,	 26h,  1Fh,  19h,  13h,	 0Dh,	 6
		dw     0,   -6,	-0Dh, -13h, -19h, -1Fh,	-26h, -2Ch
		dw  -32h, -38h,	-3Eh, -44h, -4Ah, -50h,	-56h, -5Ch
		dw  -62h, -68h,	-6Dh, -73h, -79h, -7Eh,	-84h, -89h
		dw  -8Eh, -93h,	-98h, -9Dh,-0A2h,-0A7h,-0ACh,-0B1h
		dw -0B5h,-0B9h,-0BEh,-0C2h,-0C6h,-0CAh,-0CEh,-0D1h
		dw -0D5h,-0D8h,-0DCh,-0DFh,-0E2h,-0E5h,-0E7h,-0EAh
		dw -0EDh,-0EFh,-0F1h,-0F3h,-0F5h,-0F7h,-0F8h,-0FAh
		dw -0FBh,-0FCh,-0FDh,-0FEh,-0FFh,-0FFh,-100h,-100h
word_2CE2A	dw -100h,-100h,-100h,-0FFh,-0FFh,-0FEh,-0FDh,-0FCh
		dw -0FBh,-0FAh,-0F8h,-0F7h,-0F5h,-0F3h,-0F1h,-0EFh
		dw -0EDh,-0EAh,-0E7h,-0E5h,-0E2h,-0DFh,-0DCh,-0D8h
		dw -0D5h,-0D1h,-0CEh,-0CAh,-0C6h,-0C2h,-0BEh,-0B9h
		dw -0B5h,-0B1h,-0ACh,-0A7h,-0A2h, -9Dh,	-98h, -93h
		dw  -8Eh, -89h,	-84h, -7Eh, -79h, -73h,	-6Dh, -68h
		dw  -62h, -5Ch,	-56h, -50h, -4Ah, -44h,	-3Eh, -38h
		dw  -32h, -2Ch,	-26h, -1Fh, -19h, -13h,	-0Dh,	-6
word_2CEAA	dw     0,    6,	 0Dh,  13h,  19h,  1Fh,	 26h,  2Ch
		dw   32h,  38h,	 3Eh,  44h,  4Ah,  50h,	 56h,  5Ch
		dw   62h,  68h,	 6Dh,  73h,  79h,  7Eh,	 84h,  89h
		dw   8Eh,  93h,	 98h,  9Dh, 0A2h, 0A7h,	0ACh, 0B1h
		dw  0B5h, 0B9h,	0BEh, 0C2h, 0C6h, 0CAh,	0CEh, 0D1h
		dw  0D5h, 0D8h,	0DCh, 0DFh, 0E2h, 0E5h,	0E7h, 0EAh
		dw  0EDh, 0EFh,	0F1h, 0F3h, 0F5h, 0F7h,	0F8h, 0FAh
		dw  0FBh, 0FCh,	0FDh, 0FEh, 0FFh, 0FFh,	100h, 100h
word_2CF2A	dw     0,    4,	   9,  0Dh,  12h,  16h,	 1Bh,  1Fh
		dw   24h,  28h,	 2Ch,  31h,  35h,  3Ah,	 3Eh,  42h
		dw   47h,  4Bh,	 4Fh,  53h,  58h,  5Ch,	 60h,  64h
		dw   68h,  6Ch,	 70h,  74h,  78h,  7Ch,	 80h,  84h
		dw   88h,  8Bh,	 8Fh,  93h,  96h,  9Ah,	 9Eh, 0A1h
		dw  0A5h, 0A8h,	0ABh, 0AFh, 0B2h, 0B5h,	0B8h, 0BBh
		dw  0BEh, 0C1h,	0C4h, 0C7h, 0CAh, 0CCh,	0CFh, 0D2h
		dw  0D4h, 0D7h,	0D9h, 0DBh, 0DEh, 0E0h,	0E2h, 0E4h
		dw  0E6h, 0E8h,	0EAh, 0ECh, 0EDh, 0EFh,	0F1h, 0F2h
		dw  0F3h, 0F5h,	0F6h, 0F7h, 0F8h, 0F9h,	0FAh, 0FBh
		dw  0FCh, 0FDh,	0FEh, 0FEh, 0FFh, 0FFh,	0FFh, 100h
		dw  100h, 100h,	100h, 100h, 100h, 100h,	0FFh, 0FFh
		dw  0FFh, 0FEh,	0FEh, 0FDh, 0FCh, 0FBh,	0FAh, 0F9h
		dw  0F8h, 0F7h,	0F6h, 0F5h, 0F3h, 0F2h,	0F1h, 0EFh
		dw  0EDh, 0ECh,	0EAh, 0E8h, 0E6h, 0E4h,	0E2h, 0E0h
		dw  0DEh, 0DBh,	0D9h, 0D7h, 0D4h, 0D2h,	0CFh, 0CCh
		dw  0CAh, 0C7h,	0C4h, 0C1h, 0BEh, 0BBh,	0B8h, 0B5h
		dw  0B2h, 0AFh,	0ABh, 0A8h, 0A5h, 0A1h,	 9Eh,  9Ah
		dw   96h,  93h,	 8Fh,  8Bh,  88h,  84h,	 80h,  7Ch
		dw   78h,  74h,	 70h,  6Ch,  68h,  64h,	 60h,  5Ch
		dw   58h,  53h,	 4Fh,  4Bh,  47h,  42h,	 3Eh,  3Ah
		dw   35h,  31h,	 2Ch,  28h,  24h,  1Fh,	 1Bh,  16h
		dw   12h,  0Dh,	   9,	 4,    0,   -4,	  -9, -0Dh
		dw  -12h, -16h,	-1Bh, -1Fh, -24h, -28h,	-2Ch, -31h
		dw  -35h, -3Ah,	-3Eh, -42h, -47h, -4Bh,	-4Fh, -53h
		dw  -58h, -5Ch,	-60h, -64h, -68h, -6Ch,	-70h, -74h
		dw  -78h, -7Ch,	-80h, -84h, -88h, -8Bh,	-8Fh, -93h
		dw  -96h, -9Ah,	-9Eh,-0A1h,-0A5h,-0A8h,-0ABh,-0AFh
		dw -0B2h,-0B5h,-0B8h,-0BBh,-0BEh,-0C1h,-0C4h,-0C7h
		dw -0CAh,-0CCh,-0CFh,-0D2h,-0D4h,-0D7h,-0D9h,-0DBh
		dw -0DEh,-0E0h,-0E2h,-0E4h,-0E6h,-0E8h,-0EAh,-0ECh
		dw -0EDh,-0EFh,-0F1h,-0F2h,-0F3h,-0F5h,-0F6h,-0F7h
		dw -0F8h,-0F9h,-0FAh,-0FBh,-0FCh,-0FDh,-0FEh,-0FEh
		dw -0FFh,-0FFh,-0FFh,-100h,-100h,-100h,-100h,-100h
		dw -100h,-100h,-0FFh,-0FFh,-0FFh,-0FEh,-0FEh,-0FDh
		dw -0FCh,-0FBh,-0FAh,-0F9h,-0F8h,-0F7h,-0F6h,-0F5h
		dw -0F3h,-0F2h,-0F1h,-0EFh,-0EDh,-0ECh,-0EAh,-0E8h
		dw -0E6h,-0E4h,-0E2h,-0E0h,-0DEh,-0DBh,-0D9h,-0D7h
		dw -0D4h,-0D2h,-0CFh,-0CCh,-0CAh,-0C7h,-0C4h,-0C1h
		dw -0BEh,-0BBh,-0B8h,-0B5h,-0B2h,-0AFh,-0ABh,-0A8h
		dw -0A5h,-0A1h,	-9Eh, -9Ah, -96h, -93h,	-8Fh, -8Bh
		dw  -88h, -84h,	-80h, -7Ch, -78h, -74h,	-70h, -6Ch
		dw  -68h, -64h,	-60h, -5Ch, -58h, -53h,	-4Fh, -4Bh
		dw  -47h, -42h,	-3Eh, -3Ah, -35h, -31h,	-2Ch, -28h
		dw  -24h, -1Fh,	-1Bh, -16h, -12h, -0Dh,	  -9,	-4
		dw     0,    4,	   9,  0Dh,  12h,  16h,	 1Bh,  1Fh
		dw   24h,  28h,	 2Ch,  31h,  35h,  3Ah,	 3Eh,  42h
		dw   47h,  4Bh,	 4Fh,  53h,  58h,  5Ch,	 60h,  64h
		dw   68h,  6Ch,	 70h,  74h,  78h,  7Ch,	 80h,  84h
		dw   88h,  8Bh,	 8Fh,  93h,  96h,  9Ah,	 9Eh, 0A1h
		dw  0A5h, 0A8h,	0ABh, 0AFh, 0B2h, 0B5h,	0B8h, 0BBh
		dw  0BEh, 0C1h,	0C4h, 0C7h, 0CAh, 0CCh,	0CFh, 0D2h
		dw  0D4h, 0D7h,	0D9h, 0DBh, 0DEh, 0E0h,	0E2h, 0E4h
		dw  0E6h, 0E8h,	0EAh, 0ECh, 0EDh, 0EFh,	0F1h, 0F2h
		dw  0F3h, 0F5h,	0F6h, 0F7h, 0F8h, 0F9h,	0FAh, 0FBh
		dw  0FCh, 0FDh,	0FEh, 0FEh, 0FFh, 0FFh,	0FFh, 100h
		dw  100h, 100h,	100h
byte_2D2B0	db    0,   0,	0,   0,	  1,   1,   1,	 1 ; DATA XREF:	sub_1BF8C+30o
					; sub_1BF8C+46o
		db    1,   1,	2,   2,	  2,   2,   2,	 2
		db    3,   3,	3,   3,	  3,   3,   3,	 4
		db    4,   4,	4,   4,	  4,   5,   5,	 5
		db    5,   5,	5,   6,	  6,   6,   6,	 6
		db    6,   6,	7,   7,	  7,   7,   7,	 7
		db    8,   8,	8,   8,	  8,   8,   8,	 9
		db    9,   9,	9,   9,	  9, 0Ah, 0Ah, 0Ah
		db  0Ah, 0Ah, 0Ah, 0Ah,	0Bh, 0Bh, 0Bh, 0Bh
		db  0Bh, 0Bh, 0Bh, 0Ch,	0Ch, 0Ch, 0Ch, 0Ch
		db  0Ch, 0Ch, 0Dh, 0Dh,	0Dh, 0Dh, 0Dh, 0Dh
		db  0Dh, 0Eh, 0Eh, 0Eh,	0Eh, 0Eh, 0Eh, 0Eh
		db  0Fh, 0Fh, 0Fh, 0Fh,	0Fh, 0Fh, 0Fh, 10h
		db  10h, 10h, 10h, 10h,	10h, 10h, 11h, 11h
		db  11h, 11h, 11h, 11h,	11h, 11h, 12h, 12h
		db  12h, 12h, 12h, 12h,	12h, 13h, 13h, 13h
		db  13h, 13h, 13h, 13h,	13h, 14h, 14h, 14h
		db  14h, 14h, 14h, 14h,	14h, 15h, 15h, 15h
		db  15h, 15h, 15h, 15h,	15h, 15h, 16h, 16h
		db  16h, 16h, 16h, 16h,	16h, 16h, 17h, 17h
		db  17h, 17h, 17h, 17h,	17h, 17h, 17h, 18h
		db  18h, 18h, 18h, 18h,	18h, 18h, 18h, 18h
		db  19h, 19h, 19h, 19h,	19h, 19h, 19h, 19h
		db  19h, 19h, 1Ah, 1Ah,	1Ah, 1Ah, 1Ah, 1Ah
		db  1Ah, 1Ah, 1Ah, 1Bh,	1Bh, 1Bh, 1Bh, 1Bh
		db  1Bh, 1Bh, 1Bh, 1Bh,	1Bh, 1Ch, 1Ch, 1Ch
		db  1Ch, 1Ch, 1Ch, 1Ch,	1Ch, 1Ch, 1Ch, 1Ch
		db  1Dh, 1Dh, 1Dh, 1Dh,	1Dh, 1Dh, 1Dh, 1Dh
		db  1Dh, 1Dh, 1Dh, 1Eh,	1Eh, 1Eh, 1Eh, 1Eh
		db  1Eh, 1Eh, 1Eh, 1Eh,	1Eh, 1Eh, 1Fh, 1Fh
		db  1Fh, 1Fh, 1Fh, 1Fh,	1Fh, 1Fh, 1Fh, 1Fh
		db  1Fh, 1Fh, 20h, 20h,	20h, 20h, 20h, 20h
byte_2D3B0	db  00h, 00h, 00h, 01h,	01h, 01h, 01h, 02h; 0 ;	DATA XREF: sub_1BFF1+30o
					; sub_1BFF1+47o
		db  02h, 02h, 02h, 02h,	03h, 03h, 03h, 03h; 8
		db  04h, 04h, 04h, 04h,	04h, 05h, 05h, 05h; 10h
		db  05h, 06h, 06h, 06h,	06h, 06h, 07h, 07h; 18h
		db  07h, 07h, 08h, 08h,	08h, 08h, 08h, 09h; 20h
		db  09h, 09h, 09h, 0Ah,	0Ah, 0Ah, 0Ah, 0Ah; 28h
		db  0Bh, 0Bh, 0Bh, 0Bh,	0Bh, 0Ch, 0Ch, 0Ch; 30h
		db  0Ch, 0Dh, 0Dh, 0Dh,	0Dh, 0Dh, 0Eh, 0Eh; 38h
		db  0Eh, 0Eh, 0Eh, 0Fh,	0Fh, 0Fh, 0Fh, 10h; 40h
		db  10h, 10h, 10h, 10h,	11h, 11h, 11h, 11h; 48h
		db  11h, 12h, 12h, 12h,	12h, 12h, 13h, 13h; 50h
		db  13h, 13h, 13h, 14h,	14h, 14h, 14h, 14h; 58h
		db  15h, 15h, 15h, 15h,	15h, 16h, 16h, 16h; 60h
		db  16h, 16h, 16h, 17h,	17h, 17h, 17h, 17h; 68h
		db  18h, 18h, 18h, 18h,	18h, 19h, 19h, 19h; 70h
		db  19h, 19h, 19h, 1Ah,	1Ah, 1Ah, 1Ah, 1Ah; 78h
		db  1Bh, 1Bh, 1Bh, 1Bh,	1Bh, 1Bh, 1Ch, 1Ch; 80h
		db  1Ch, 1Ch, 1Ch, 1Dh,	1Dh, 1Dh, 1Dh, 1Dh; 88h
		db  1Dh, 1Eh, 1Eh, 1Eh,	1Eh, 1Eh, 1Eh, 1Fh; 90h
		db  1Fh, 1Fh, 1Fh, 1Fh,	1Fh, 20h, 20h, 20h; 98h
		db  20h, 20h, 20h, 20h,	21h, 21h, 21h, 21h; 0A0h
		db  21h, 21h, 22h, 22h,	22h, 22h, 22h, 22h; 0A8h
		db  23h, 23h, 23h, 23h,	23h, 23h, 23h, 24h; 0B0h
		db  24h, 24h, 24h, 24h,	24h, 24h, 25h, 25h; 0B8h
		db  25h, 25h, 25h, 25h,	25h, 26h, 26h, 26h; 0C0h
		db  26h, 26h, 26h, 26h,	27h, 27h, 27h, 27h; 0C8h
		db  27h, 27h, 27h, 27h,	28h, 28h, 28h, 28h; 0D0h
		db  28h, 28h, 28h, 29h,	29h, 29h, 29h, 29h; 0D8h
		db  29h, 29h, 29h, 2Ah,	2Ah, 2Ah, 2Ah, 2Ah; 0E0h
		db  2Ah, 2Ah, 2Ah, 2Bh,	2Bh, 2Bh, 2Bh, 2Bh; 0E8h
		db  2Bh, 2Bh, 2Bh, 2Ch,	2Ch, 2Ch, 2Ch, 2Ch; 0F0h
		db  2Ch, 2Ch, 2Ch, 2Ch,	2Dh, 2Dh, 2Dh, 2Dh; 0F8h
		db  00h, 02h, 04h, 07h,	09h, 0Bh, 0Dh, 0Fh; 0
		db  12h, 14h, 16h, 18h,	1Ah, 1Dh, 1Fh, 21h; 8
		db  23h, 25h, 27h, 29h,	2Bh, 2Eh, 30h, 32h; 10h
		db  34h, 36h, 38h, 3Ah,	3Ch, 3Eh, 40h, 41h; 18h
		db  43h, 45h, 47h, 49h,	4Bh, 4Ch, 4Eh, 50h; 20h
		db  52h, 53h, 55h, 57h,	58h, 5Ah, 5Bh, 5Dh; 28h
		db  5Eh, 60h, 61h, 63h,	64h, 65h, 67h, 68h; 30h
		db  69h, 6Bh, 6Ch, 6Dh,	6Eh, 6Fh, 70h, 71h; 38h
		db  72h, 73h, 74h, 75h,	76h, 77h, 77h, 78h; 40h
		db  79h, 79h, 7Ah, 7Bh,	7Bh, 7Ch, 7Ch, 7Dh; 48h
		db  7Dh, 7Dh, 7Eh, 7Eh,	7Eh, 7Fh, 7Fh, 7Fh; 50h
		db  7Fh, 7Fh, 7Fh, 7Fh,	7Fh, 7Fh, 7Fh, 7Fh; 58h
		db  7Eh, 7Eh, 7Eh, 7Dh,	7Dh, 7Dh, 7Ch, 7Ch; 60h
		db  7Bh, 7Bh, 7Ah, 79h,	79h, 78h, 77h, 77h; 68h
		db  76h, 75h, 74h, 73h,	72h, 71h, 70h, 6Fh; 70h
		db  6Eh, 6Dh, 6Ch, 6Bh,	69h, 68h, 67h, 65h; 78h
		db  64h, 63h, 61h, 60h,	5Eh, 5Dh, 5Bh, 5Ah; 80h
		db  58h, 57h, 55h, 53h,	52h, 50h, 4Eh, 4Ch; 88h
		db  4Bh, 49h, 47h, 45h,	43h, 41h, 3Fh, 3Eh; 90h
		db  3Ch, 3Ah, 38h, 36h,	34h, 32h, 30h, 2Eh; 98h
		db  2Bh, 29h, 27h, 25h,	23h, 21h, 1Fh, 1Dh; 0A0h
		db  1Ah, 18h, 16h, 14h,	12h, 0Fh, 0Dh, 0Bh; 0A8h
		db  09h, 07h, 04h, 02h,	00h,-02h,-04h,-07h; 0B0h
		db -09h,-0Bh,-0Dh,-0Fh,-12h,-14h,-16h,-18h; 0B8h
		db -1Ah,-1Dh,-1Fh,-21h,-23h,-25h,-27h,-29h; 0C0h
		db -2Bh,-2Eh,-30h,-32h,-34h,-36h,-38h,-3Ah; 0C8h
		db -3Ch,-3Eh,-40h,-41h,-43h,-45h,-47h,-49h; 0D0h
		db -4Bh,-4Ch,-4Eh,-50h,-52h,-53h,-55h,-57h; 0D8h
		db -58h,-5Ah,-5Bh,-5Dh,-5Eh,-60h,-61h,-63h; 0E0h
		db -64h,-65h,-67h,-68h,-69h,-6Bh,-6Ch,-6Dh; 0E8h
		db -6Eh,-6Fh,-70h,-71h,-72h,-73h,-74h,-75h; 0F0h
		db -76h,-77h,-77h,-78h,-79h,-79h,-7Ah,-7Bh; 0F8h
		db -7Bh,-7Ch,-7Ch,-7Dh,-7Dh,-7Dh,-7Eh,-7Eh; 100h
		db -7Eh,-7Fh,-7Fh,-7Fh,-7Fh,-7Fh,-7Fh,-7Fh; 108h
		db -7Fh,-7Fh,-7Fh,-7Fh,-7Eh,-7Eh,-7Eh,-7Dh; 110h
		db -7Dh,-7Dh,-7Ch,-7Ch,-7Bh,-7Bh,-7Ah,-79h; 118h
		db -79h,-78h,-77h,-77h,-76h,-75h,-74h,-73h; 120h
		db -72h,-71h,-70h,-6Fh,-6Eh,-6Dh,-6Ch,-6Bh; 128h
		db -69h,-68h,-67h,-65h,-64h,-63h,-61h,-60h; 130h
		db -5Eh,-5Dh,-5Bh,-5Ah,-58h,-57h,-55h,-53h; 138h
		db -52h,-50h,-4Eh,-4Ch,-4Bh,-49h,-47h,-45h; 140h
		db -43h,-41h,-3Fh,-3Eh,-3Ch,-3Ah,-38h,-36h; 148h
		db -34h,-32h,-30h,-2Eh,-2Bh,-29h,-27h,-25h; 150h
		db -23h,-21h,-1Fh,-1Dh,-1Ah,-18h,-16h,-14h; 158h
		db -12h,-0Fh,-0Dh,-0Bh,-09h,-07h,-04h,-02h; 160h
		db  00h, 02h, 04h, 07h,	09h, 0Bh, 0Dh, 0Fh; 168h
		db  12h, 14h, 16h, 18h,	1Ah, 1Dh, 1Fh, 21h; 170h
		db  23h, 25h, 27h, 29h,	2Bh, 2Eh, 30h, 32h; 178h
		db  34h, 36h, 38h, 3Ah,	3Ch, 3Eh, 40h, 41h; 180h
		db  43h, 45h, 47h, 49h,	4Bh, 4Ch, 4Eh, 50h; 188h
		db  52h, 53h, 55h, 57h,	58h, 5Ah, 5Bh, 5Dh; 190h
		db  5Eh, 60h, 61h, 63h,	64h, 65h, 67h, 68h; 198h
		db  69h, 6Bh, 6Ch, 6Dh,	6Eh, 6Fh, 70h, 71h; 1A0h
		db  72h, 73h, 74h, 75h,	76h, 77h, 77h, 78h; 1A8h
		db  79h, 79h, 7Ah, 7Bh,	7Bh, 7Ch, 7Ch, 7Dh; 1B0h
		db  7Dh, 7Dh, 7Eh, 7Eh,	7Eh, 7Fh, 7Fh, 7Fh; 1B8h
		db  7Fh, 7Fh, 7Fh	; 1C0h
		align 2
EnemyObjects	db 1, 3	dup(0),	80h, 2,	32h, 29h dup(0), 1, 0Ch	dup(0)
					; DATA XREF: sub_111F3+1AEo
					; sub_175CD+Ao	...
		db 0A0h, 80h, 0Ch, 2 dup(0), 10h, 3 dup(0), 10h, 11h dup(0)
		db 2 dup(0FFh),	3Eh dup(0), 2, 3 dup(0), 80h, 2, 32h, 29h dup(0)
		db 1, 0Ch dup(0), 0A0h,	80h, 0Ch, 2 dup(0), 10h, 3 dup(0)
		db 10h,	11h dup(0), 2 dup(0FFh), 3Eh dup(0), 3,	3 dup(0)
		db 80h,	2, 32h,	29h dup(0), 1, 0Ch dup(0), 0A0h, 80h, 0Ch
		db 2 dup(0), 10h, 3 dup(0), 10h, 11h dup(0), 2 dup(0FFh)
		db 3Eh dup(0), 4, 3 dup(0), 80h, 2, 32h, 29h dup(0), 1
		db 0Ch dup(0), 0A0h, 80h, 0Ch, 2 dup(0), 10h, 3	dup(0)
		db 10h,	11h dup(0), 2 dup(0FFh), 3Eh dup(0), 5,	3 dup(0)
		db 80h,	2, 32h,	29h dup(0), 1, 0Ch dup(0), 0A0h, 80h, 0Ch
		db 2 dup(0), 10h, 3 dup(0), 10h, 11h dup(0), 2 dup(0FFh)
		db 3Eh dup(0), 6, 3 dup(0), 80h, 2, 32h, 29h dup(0), 1
		db 0Ch dup(0), 0A0h, 80h, 0Ch, 2 dup(0), 10h, 3	dup(0)
		db 10h,	11h dup(0), 2 dup(0FFh), 3Eh dup(0), 7,	3 dup(0)
		db 80h,	2, 32h,	29h dup(0), 1, 0Ch dup(0), 0A0h, 80h, 0Ch
		db 2 dup(0), 10h, 3 dup(0), 10h, 11h dup(0), 2 dup(0FFh)
		db 3Eh dup(0), 8, 3 dup(0), 80h, 2, 32h, 29h dup(0), 1
		db 0Ch dup(0), 0A0h, 80h, 0Ch, 2 dup(0), 10h, 3	dup(0)
		db 10h,	11h dup(0), 2 dup(0FFh), 3Eh dup(0), 9,	3 dup(0)
		db 80h,	2, 32h,	29h dup(0), 1, 0Ch dup(0), 0A0h, 80h, 0Ch
		db 2 dup(0), 10h, 3 dup(0), 10h, 11h dup(0), 2 dup(0FFh)
		db 3Eh dup(0), 0Ah, 3 dup(0), 80h, 2, 32h, 29h dup(0)
		db 1, 0Ch dup(0), 0A0h,	80h, 0Ch, 2 dup(0), 10h, 3 dup(0)
		db 10h,	11h dup(0), 2 dup(0FFh), 3Eh dup(0), 0Bh, 3 dup(0)
		db 80h,	2, 32h,	29h dup(0), 1, 0Ch dup(0), 0A0h, 80h, 0Ch
		db 2 dup(0), 10h, 3 dup(0), 10h, 11h dup(0), 2 dup(0FFh)
		db 3Eh dup(0), 0Ch, 3 dup(0), 80h, 2, 32h, 29h dup(0)
		db 1, 0Ch dup(0), 0A0h,	80h, 0Ch, 2 dup(0), 10h, 3 dup(0)
		db 10h,	11h dup(0), 2 dup(0FFh), 3Eh dup(0), 0Dh, 3 dup(0)
		db 80h,	2, 32h,	29h dup(0), 1, 0Ch dup(0), 0A0h, 80h, 0Ch
		db 2 dup(0), 10h, 3 dup(0), 10h, 11h dup(0), 2 dup(0FFh)
		db 3Eh dup(0), 0Eh, 3 dup(0), 80h, 2, 32h, 29h dup(0)
		db 1, 0Ch dup(0), 0A0h,	80h, 0Ch, 2 dup(0), 10h, 3 dup(0)
		db 10h,	11h dup(0), 2 dup(0FFh), 3Eh dup(0), 0Fh, 3 dup(0)
		db 80h,	2, 32h,	29h dup(0), 1, 0Ch dup(0), 0A0h, 80h, 0Ch
		db 2 dup(0), 10h, 3 dup(0), 10h, 11h dup(0), 2 dup(0FFh)
		db 3Eh dup(0), 10h, 3 dup(0), 80h, 2, 32h, 29h dup(0)
		db 1, 0Ch dup(0), 0A0h,	80h, 0Ch, 2 dup(0), 10h, 3 dup(0)
		db 10h,	11h dup(0), 2 dup(0FFh), 3Eh dup(0), 11h, 3 dup(0)
		db 80h,	2, 32h,	29h dup(0), 1, 0Ch dup(0), 0A0h, 80h, 0Ch
		db 2 dup(0), 10h, 3 dup(0), 10h, 11h dup(0), 2 dup(0FFh)
		db 3Eh dup(0), 12h, 3 dup(0), 80h, 2, 32h, 29h dup(0)
		db 1, 0Ch dup(0), 0A0h,	80h, 0Ch, 2 dup(0), 10h, 3 dup(0)
		db 10h,	11h dup(0), 2 dup(0FFh), 3Eh dup(0), 13h, 3 dup(0)
		db 80h,	2, 32h,	29h dup(0), 1, 0Ch dup(0), 0A0h, 80h, 0Ch
		db 2 dup(0), 10h, 3 dup(0), 10h, 11h dup(0), 2 dup(0FFh)
		db 3Eh dup(0), 14h, 3 dup(0), 80h, 2, 32h, 29h dup(0)
		db 1, 0Ch dup(0), 0A0h,	80h, 0Ch, 2 dup(0), 10h, 3 dup(0)
		db 10h,	11h dup(0), 2 dup(0FFh), 3Eh dup(0), 15h, 3 dup(0)
		db 80h,	2, 32h,	29h dup(0), 1, 0Ch dup(0), 0A0h, 80h, 0Ch
		db 2 dup(0), 10h, 3 dup(0), 10h, 11h dup(0), 2 dup(0FFh)
		db 3Eh dup(0), 16h, 3 dup(0), 80h, 2, 32h, 29h dup(0)
		db 1, 0Ch dup(0), 0A0h,	80h, 0Ch, 2 dup(0), 10h, 3 dup(0)
		db 10h,	11h dup(0), 2 dup(0FFh), 3Eh dup(0), 17h, 3 dup(0)
		db 80h,	2, 32h,	29h dup(0), 1, 0Ch dup(0), 0A0h, 80h, 0Ch
		db 2 dup(0), 10h, 3 dup(0), 10h, 11h dup(0), 2 dup(0FFh)
		db 3Eh dup(0), 18h, 3 dup(0), 80h, 2, 32h, 29h dup(0)
		db 1, 0Ch dup(0), 0A0h,	80h, 0Ch, 2 dup(0), 10h, 3 dup(0)
		db 10h,	11h dup(0), 2 dup(0FFh), 3Eh dup(0), 19h, 3 dup(0)
		db 80h,	2, 32h,	29h dup(0), 1, 0Ch dup(0), 0A0h, 80h, 0Ch
		db 2 dup(0), 10h, 3 dup(0), 10h, 11h dup(0), 2 dup(0FFh)
		db 3Eh dup(0), 1Ah, 3 dup(0), 80h, 2, 32h, 29h dup(0)
		db 1, 0Ch dup(0), 0A0h,	80h, 0Ch, 2 dup(0), 10h, 3 dup(0)
		db 10h,	11h dup(0), 2 dup(0FFh), 3Eh dup(0), 1Bh, 3 dup(0)
		db 80h,	2, 32h,	29h dup(0), 1, 0Ch dup(0), 0A0h, 80h, 0Ch
		db 2 dup(0), 10h, 3 dup(0), 10h, 11h dup(0), 2 dup(0FFh)
		db 3Eh dup(0), 1Ch, 3 dup(0), 80h, 2, 32h, 29h dup(0)
		db 1, 0Ch dup(0), 0A0h,	80h, 0Ch, 2 dup(0), 10h, 3 dup(0)
		db 10h,	11h dup(0), 2 dup(0FFh), 3Eh dup(0), 1Dh, 3 dup(0)
		db 80h,	2, 32h,	29h dup(0), 1, 0Ch dup(0), 0A0h, 80h, 0Ch
		db 2 dup(0), 10h, 3 dup(0), 10h, 11h dup(0), 2 dup(0FFh)
		db 3Eh dup(0), 1Eh, 3 dup(0), 80h, 2, 32h, 29h dup(0)
		db 1, 0Ch dup(0), 0A0h,	80h, 0Ch, 2 dup(0), 10h, 3 dup(0)
		db 10h,	11h dup(0), 2 dup(0FFh), 3Eh dup(0), 1Fh, 3 dup(0)
		db 80h,	2, 32h,	29h dup(0), 1, 0Ch dup(0), 0A0h, 80h, 0Ch
		db 2 dup(0), 10h, 3 dup(0), 10h, 11h dup(0), 2 dup(0FFh)
		db 3Eh dup(0), 20h, 3 dup(0), 80h, 2, 32h, 29h dup(0)
		db 1, 0Ch dup(0), 0A0h,	80h, 0Ch, 2 dup(0), 10h, 3 dup(0)
		db 10h,	11h dup(0), 2 dup(0FFh), 3Eh dup(0), 21h, 3 dup(0)
		db 80h,	2, 32h,	29h dup(0), 1, 0Ch dup(0), 0A0h, 80h, 0Ch
		db 2 dup(0), 10h, 3 dup(0), 10h, 11h dup(0), 2 dup(0FFh)
		db 3Eh dup(0), 22h, 3 dup(0), 80h, 2, 32h, 29h dup(0)
		db 1, 0Ch dup(0), 0A0h,	80h, 0Ch, 2 dup(0), 10h, 3 dup(0)
		db 10h,	11h dup(0), 2 dup(0FFh), 3Eh dup(0), 23h, 3 dup(0)
		db 80h,	2, 32h,	29h dup(0), 1, 0Ch dup(0), 0A0h, 80h, 0Ch
		db 2 dup(0), 10h, 3 dup(0), 10h, 11h dup(0), 2 dup(0FFh)
		db 3Eh dup(0), 24h, 3 dup(0), 80h, 2, 32h, 29h dup(0)
		db 1, 0Ch dup(0), 0A0h,	80h, 0Ch, 2 dup(0), 10h, 3 dup(0)
		db 10h,	11h dup(0), 2 dup(0FFh), 3Eh dup(0), 25h, 3 dup(0)
		db 80h,	2, 32h,	29h dup(0), 1, 0Ch dup(0), 0A0h, 80h, 0Ch
		db 2 dup(0), 10h, 3 dup(0), 10h, 11h dup(0), 2 dup(0FFh)
		db 3Eh dup(0), 26h, 3 dup(0), 80h, 2, 32h, 29h dup(0)
		db 1, 0Ch dup(0), 0A0h,	80h, 0Ch, 2 dup(0), 10h, 3 dup(0)
		db 10h,	11h dup(0), 2 dup(0FFh), 3Eh dup(0), 27h, 3 dup(0)
		db 80h,	2, 32h,	29h dup(0), 1, 0Ch dup(0), 0A0h, 80h, 0Ch
		db 2 dup(0), 10h, 3 dup(0), 10h, 11h dup(0), 2 dup(0FFh)
		db 3Eh dup(0), 28h, 3 dup(0), 80h, 2, 32h, 29h dup(0)
		db 1, 0Ch dup(0), 0A0h,	80h, 0Ch, 2 dup(0), 10h, 3 dup(0)
		db 10h,	11h dup(0), 2 dup(0FFh), 3Eh dup(0), 29h, 3 dup(0)
		db 80h,	2, 32h,	29h dup(0), 1, 0Ch dup(0), 0A0h, 80h, 0Ch
		db 2 dup(0), 10h, 3 dup(0), 10h, 11h dup(0), 2 dup(0FFh)
		db 3Eh dup(0), 2Ah, 3 dup(0), 80h, 2, 32h, 29h dup(0)
		db 1, 0Ch dup(0), 0A0h,	80h, 0Ch, 2 dup(0), 10h, 3 dup(0)
		db 10h,	11h dup(0), 2 dup(0FFh), 3Eh dup(0), 2Bh, 3 dup(0)
		db 80h,	2, 32h,	29h dup(0), 1, 0Ch dup(0), 0A0h, 80h, 0Ch
		db 2 dup(0), 10h, 3 dup(0), 10h, 11h dup(0), 2 dup(0FFh)
		db 3Eh dup(0), 2Ch, 3 dup(0), 80h, 2, 32h, 29h dup(0)
		db 1, 0Ch dup(0), 0A0h,	80h, 0Ch, 2 dup(0), 10h, 3 dup(0)
		db 10h,	11h dup(0), 2 dup(0FFh), 3Eh dup(0), 2Dh, 3 dup(0)
		db 80h,	2, 32h,	29h dup(0), 1, 0Ch dup(0), 0A0h, 80h, 0Ch
		db 2 dup(0), 10h, 3 dup(0), 10h, 11h dup(0), 2 dup(0FFh)
		db 3Eh dup(0), 2Eh, 3 dup(0), 80h, 2, 32h, 29h dup(0)
		db 1, 0Ch dup(0), 0A0h,	80h, 0Ch, 2 dup(0), 10h, 3 dup(0)
		db 10h,	11h dup(0), 2 dup(0FFh), 3Eh dup(0), 2Fh, 3 dup(0)
		db 80h,	2, 32h,	29h dup(0), 1, 0Ch dup(0), 0A0h, 80h, 0Ch
		db 2 dup(0), 10h, 3 dup(0), 10h, 11h dup(0), 2 dup(0FFh)
		db 3Eh dup(0), 30h, 3 dup(0), 80h, 2, 32h, 29h dup(0)
		db 1, 0Ch dup(0), 0A0h,	80h, 0Ch, 2 dup(0), 10h, 3 dup(0)
		db 10h,	11h dup(0), 2 dup(0FFh), 3Eh dup(0), 31h, 3 dup(0)
		db 80h,	2, 32h,	29h dup(0), 1, 0Ch dup(0), 0A0h, 80h, 0Ch
		db 2 dup(0), 10h, 3 dup(0), 10h, 11h dup(0), 2 dup(0FFh)
		db 3Eh dup(0), 32h, 3 dup(0), 80h, 2, 32h, 29h dup(0)
		db 1, 0Ch dup(0), 0A0h,	80h, 0Ch, 2 dup(0), 10h, 3 dup(0)
		db 10h,	11h dup(0), 2 dup(0FFh), 3Eh dup(0), 33h, 3 dup(0)
		db 80h,	2, 32h,	29h dup(0), 1, 0Ch dup(0), 0A0h, 80h, 0Ch
		db 2 dup(0), 10h, 3 dup(0), 10h, 11h dup(0), 2 dup(0FFh)
		db 3Eh dup(0), 34h, 3 dup(0), 80h, 2, 32h, 29h dup(0)
		db 1, 0Ch dup(0), 0A0h,	80h, 0Ch, 2 dup(0), 10h, 3 dup(0)
		db 10h,	11h dup(0), 2 dup(0FFh), 3Eh dup(0), 35h, 3 dup(0)
		db 80h,	2, 32h,	29h dup(0), 1, 0Ch dup(0), 0A0h, 80h, 0Ch
		db 2 dup(0), 10h, 3 dup(0), 10h, 11h dup(0), 2 dup(0FFh)
		db 3Eh dup(0), 36h, 3 dup(0), 80h, 2, 32h, 29h dup(0)
		db 1, 0Ch dup(0), 0A0h,	80h, 0Ch, 2 dup(0), 10h, 3 dup(0)
		db 10h,	11h dup(0), 2 dup(0FFh), 3Eh dup(0), 37h, 3 dup(0)
		db 80h,	2, 32h,	29h dup(0), 1, 0Ch dup(0), 0A0h, 80h, 0Ch
		db 2 dup(0), 10h, 3 dup(0), 10h, 11h dup(0), 2 dup(0FFh)
		db 3Eh dup(0), 38h, 3 dup(0), 80h, 2, 32h, 29h dup(0)
		db 1, 0Ch dup(0), 0A0h,	80h, 0Ch, 2 dup(0), 10h, 3 dup(0)
		db 10h,	11h dup(0), 2 dup(0FFh), 3Eh dup(0), 39h, 3 dup(0)
		db 80h,	2, 32h,	29h dup(0), 1, 0Ch dup(0), 0A0h, 80h, 0Ch
		db 2 dup(0), 10h, 3 dup(0), 10h, 11h dup(0), 2 dup(0FFh)
		db 3Eh dup(0), 3Ah, 3 dup(0), 80h, 2, 32h, 29h dup(0)
		db 1, 0Ch dup(0), 0A0h,	80h, 0Ch, 2 dup(0), 10h, 3 dup(0)
		db 10h,	11h dup(0), 2 dup(0FFh), 3Eh dup(0), 3Bh, 3 dup(0)
		db 80h,	2, 32h,	29h dup(0), 1, 0Ch dup(0), 0A0h, 80h, 0Ch
		db 2 dup(0), 10h, 3 dup(0), 10h, 11h dup(0), 2 dup(0FFh)
		db 3Eh dup(0), 3Ch, 3 dup(0), 80h, 2, 32h, 29h dup(0)
		db 1, 0Ch dup(0), 0A0h,	80h, 0Ch, 2 dup(0), 10h, 3 dup(0)
		db 10h,	11h dup(0), 2 dup(0FFh), 3Eh dup(0)
		db 3Dh,	3 dup(0), 80h, 2, 32h, 29h dup(0), 1, 0Ch dup(0)
		db 0A0h, 80h, 0Ch, 2 dup(0), 10h, 3 dup(0), 10h, 11h dup(0)
		db 2 dup(0FFh),	3Eh dup(0)
		db 104h	dup(?)
seg001		ends

; ===========================================================================

; Segment type:	Uninitialized
seg002		segment	byte stack 'STACK' use16
		assume cs:seg002
		assume es:nothing, ss:nothing, ds:nothing, fs:nothing, gs:nothing
byte_2FBB0	db 400h	dup(?)
seg002		ends


		end start
