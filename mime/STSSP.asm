; Input	MD5   :	AAD04CD358F8DC35E371484D9072105C
; Input	CRC32 :	0FEA43B9

; File Name   :	R:\STSSP.COM
; Format      :	MS-DOS COM-file
; Base Address:	1000h Range: 10100h-114C8h Loaded length: 13C8h

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
start		proc near
		cli
		mov	ax, cs
		mov	ds, ax
		mov	es, ax
		assume es:seg000
		mov	ss, ax
		assume ss:seg000
		mov	sp, 15C6h
		mov	bx, 15D8h
		shr	bx, 4
		mov	ah, 4Ah
		int	21h		; DOS -	2+ - ADJUST MEMORY BLOCK SIZE (SETBLOCK)
					; ES = segment address of block	to change
					; BX = new size	in paragraphs
		mov	ah, 0
		mov	cx, 8
		mov	dx, 0

loc_1011E:				; CODE XREF: start+25j
		mov	al, ah
		or	al, 0C0h
		out	dx, al
		inc	ah
		loop	loc_1011E
		mov	ah, 0
		mov	cx, 8
		mov	dx, 8

loc_1012F:				; CODE XREF: start+36j
		mov	al, ah
		or	al, 0C0h
		out	dx, al		; DMA 8237A-5. cmd reg bits:
					; 0: enable mem-to-mem DMA
					; 1: enable Ch0	address	hold
					; 2: disable controller
					; 3: compressed	timing mode
					; 4: enable rotating priority
					; 5: extended write mode; 0=late write
					; 6: DRQ sensing - active high
					; 7: DACK sensing - active high
		inc	ah
		loop	loc_1012F
		sti
		cld
		push	es
		xor	ax, ax
		mov	es, ax
		assume es:nothing
		mov	al, es:500h
		mov	cs:byte_10E88, al
		or	byte ptr es:500h, 20h
		pop	es
		assume es:nothing
		call	SetupIntVec05
		call	SetupIntVec06
		call	SetupIntVec23
		call	SetupIntVec24
		mov	ah, 0Dh
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		mov	ah, 12h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		mov	dx, offset a0m1h5h ; "\x1B[0m\x1B[>1h\x1B[>5h\x1B*$"
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		mov	env_PmdState, 0
		mov	env_MmdState, 0
		mov	env_MusicMode, 0
		mov	env_DispMode, 0
		mov	env_DiskMode, 1
		mov	si, 80h
		cmp	byte ptr [si], 0
		jz	short loc_101B1
		inc	si

loc_1018B:				; CODE XREF: start+8Ej
		lodsb
		cmp	al, 20h
		jz	short loc_1018B
		cmp	al, '/'
		jz	short loc_10198
		cmp	al, '-'
		jnz	short loc_101B1

loc_10198:				; CODE XREF: start+92j
		lodsb
		and	al, 0DFh
		cmp	al, 'F'
		jz	short loc_101A5
		cmp	al, 'H'
		jz	short loc_101AC
		jmp	short loc_101B1
; ---------------------------------------------------------------------------

loc_101A5:				; CODE XREF: start+9Dj
		mov	env_DiskMode, 0
		jmp	short loc_101B1
; ---------------------------------------------------------------------------

loc_101AC:				; CODE XREF: start+A1j
		mov	env_DiskMode, 1

loc_101B1:				; CODE XREF: start+88j	start+96j ...
		call	ClearScreen
		mov	si, offset PaletteDataRGB
		call	LoadPalette_RGB
		mov	bx, cs
		mov	cx, offset aM15V0E4PIK ; " # /M15/V0/E4/P/I-/K"
		mov	dx, offset aBPmd_com ; "B:PMD.COM"
		call	ExecuteProgram	; load PMD driver (FM music)
		mov	ax, 0
		jnb	short loc_101CD
		jmp	ErrExit		; Error	0: PMD.COM not found
; ---------------------------------------------------------------------------

loc_101CD:				; CODE XREF: start+C8j
		mov	dx, offset aNewLine ; "\r\n$"
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		mov	bx, cs
		mov	cx, offset aM26DK ; " /M26/D-/K"
		mov	dx, offset aBMmd_com ; "B:MMD.COM"
		call	ExecuteProgram	; load MMD driver (MIDI	music)
		mov	ax, 1
		jnb	short loc_101E7
		jmp	ErrExit		; Error	1: MMD.COM not found
; ---------------------------------------------------------------------------

loc_101E7:				; CODE XREF: start+E2j
		mov	dx, offset aNewLine ; "\r\n$"
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		mov	bx, cs
		mov	cx, offset unk_10E1F
		mov	dx, offset aBStmd_com ;	"B:STMD.COM"
		call	ExecuteProgram	; load mouse driver
		mov	ax, 2
		jnb	short loc_10201
		jmp	ErrExit		; Error	2: STMD.COM not	found
; ---------------------------------------------------------------------------

loc_10201:				; CODE XREF: start+FCj
		mov	dx, offset aNewLine ; "\r\n$"
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		mov	ax, cs
		mov	ds, ax
		mov	dx, offset aBMusMime_se_ef ; "B:MUS\\MIME_SE.EFC"
		call	fopen_r		; load sound effect file
		mov	ax, 3
		jnb	short loc_1021A
		jmp	ErrExit		; Error	3: MIME_SE.EFC not found
; ---------------------------------------------------------------------------

loc_1021A:				; CODE XREF: start+115j
		mov	ah, 0Bh		; routine 0B - get sound effect	address
		int	60h		; call PMD driver
		mov	cx, 1000h
		call	fread
		mov	ax, 3
		jnb	short loc_1022C
		jmp	ErrExit		; Error	3: MIME_SE.EFC not found
; ---------------------------------------------------------------------------

loc_1022C:				; CODE XREF: start+127j
		call	fclose
		mov	ax, 3
		jnb	short loc_10237
		jmp	ErrExit		; Error	3: MIME_SE.EFC not found
; ---------------------------------------------------------------------------

loc_10237:				; CODE XREF: start+132j
		mov	ax, cs
		mov	ds, ax
		call	CheckForPMD
		jb	short loc_1025B
		mov	ah, 9		; routine 09 - get PMD driver version
		int	60h		; call PMD driver
		cmp	al, 0FFh
		jz	short loc_10254	; AL = 0FFh -> driver loaded, but not sound chip found
		mov	env_PmdState, 1	; PMD enabled
		mov	env_MusicMode, 1 ; default to FM music
		jmp	short loc_10260
; ---------------------------------------------------------------------------

loc_10254:				; CODE XREF: start+146j
		mov	env_PmdState, 2	; PMD loaded, but no FM	chip found
		jmp	short loc_10260
; ---------------------------------------------------------------------------

loc_1025B:				; CODE XREF: start+13Ej
		mov	env_PmdState, 0	; PMD not loaded

loc_10260:				; CODE XREF: start+152j start+159j
		call	CheckForMMD
		jb	short loc_10271
		mov	env_MmdState, 1	; MMD enabled
		mov	env_MusicMode, 2 ; default to MIDI music
		jmp	short loc_10276
; ---------------------------------------------------------------------------

loc_10271:				; CODE XREF: start+163j
		mov	env_MmdState, 0	; MMD not loaded

loc_10276:				; CODE XREF: start+16Fj
		mov	ah, 2
		int	68h		;  - APPC/PC
					; DS:DX	-> control block
		mov	ah, 4
		int	68h		;  - APPC/PC
					; DS:DX	-> control block
		xor	bx, bx
		mov	dx, 9
		mov	ah, 6
		int	68h		;  - APPC/PC - CHANGE NUMBER OF	SESSIONS
					; DS:DX	-> control block
		xor	bx, bx
		xor	dx, dx
		xor	si, si
		mov	di, 12h
		mov	ah, 8
		int	68h		;  - APPC/PC
		xor	ax, ax
		mov	es, ax
		assume es:nothing
		cmp	env_PmdState, 0
		jnz	short loc_102A2
		jmp	loc_10491
; ---------------------------------------------------------------------------

loc_102A2:				; CODE XREF: start+19Dj
		cmp	env_PmdState, 2
		jnz	short loc_102AC
		jmp	loc_10491
; ---------------------------------------------------------------------------

loc_102AC:				; CODE XREF: start+1A7j
		cmp	env_MmdState, 0
		jnz	short loc_102B6
		jmp	loc_10491
; ---------------------------------------------------------------------------

loc_102B6:				; CODE XREF: start+1B1j
		mov	drawColX, 27	; start	pixel X	= 27 * 8 = 216
		mov	drawRowY, 6	; start	pixel Y	= 6 * 16 = 96
		mov	drawWidth, 11	; inner	width =	11 * 16	= 176 (excluding border	of 32 pixels)
		mov	drawHeight, 3	; inner	height = 3 * 16	= 48 (excluding	border of 32 pixels)
		call	DrawTextBox	; draw text box	for Sound Source Selection
		mov	drawColX, 29	; X = 29 * 8 = 232
		mov	drawRowY, 106	; Y = 106
		mov	txtColorMain, 4
		mov	txtColorShdw, 8
		mov	si, offset aSoundMode ;	"¡@‰¹Œ¹ƒ‚[ƒh‘I‘ğ@¡"
		call	DrawText	; "Select Sound	Mode"
		mov	drawColX, 36	; X = 36 * 8 = 288
		mov	drawRowY, 130	; Y = 130
		mov	txtColorMain, 1
		mov	txtColorShdw, 8
		mov	si, offset aSound_FM ; "‚e‚l‰¹Œ¹"
		call	DrawText	; "FM sound source"
		mov	drawColX, 34	; X = 34 * 8 = 272
		mov	drawRowY, 148	; Y = 148
		mov	txtColorMain, 3
		mov	txtColorShdw, 0
		mov	si, offset aSound_MIDI ; "‚l‚h‚c‚h‰¹Œ¹"
		call	DrawText	; "MIDI	sound source"
		mov	env_MusicMode, 1

loc_1032A:				; CODE XREF: start:loc_1039Ej
					; start+2B0j ...
		mov	al, es:52Dh
		or	al, es:530h
		test	al, 10h
		jz	short loc_1033A
		jmp	loc_10466
; ---------------------------------------------------------------------------

loc_1033A:				; CODE XREF: start+235j
		mov	al, es:531h
		test	al, 4
		jnz	short loc_103A0
		mov	al, es:532h
		test	al, 8
		jnz	short loc_103A0
		mov	al, es:531h
		test	al, 20h
		jz	short loc_10355
		jmp	loc_10403
; ---------------------------------------------------------------------------

loc_10355:				; CODE XREF: start+250j
		mov	al, es:533h
		test	al, 8
		jz	short loc_10360
		jmp	loc_10403
; ---------------------------------------------------------------------------

loc_10360:				; CODE XREF: start+25Bj
		mov	ah, 9
		int	68h		;  - APPC/PC
		test	al, 1
		jz	short loc_1036B
		jmp	loc_10466
; ---------------------------------------------------------------------------

loc_1036B:				; CODE XREF: start+266j
		test	al, 2
		jz	short loc_10372
		jmp	loc_10466
; ---------------------------------------------------------------------------

loc_10372:				; CODE XREF: start+26Dj
		mov	ah, 5
		int	68h		;  - APPC/PC - TRANSFER	MSG DATA
					; DS:DX	-> control block
		or	dx, dx
		jz	short loc_103A0
		cmp	dx, 12h
		jnz	short loc_10382
		jmp	loc_10403
; ---------------------------------------------------------------------------

loc_10382:				; CODE XREF: start+27Dj
		mov	ah, 16h		; routine 16 - read joystick
		int	60h		; call PMD driver
		not	al
		test	al, 1
		jnz	short loc_103A0
		test	al, 2
		jnz	short loc_10403
		test	al, 10h
		jz	short loc_10397
		jmp	loc_10466
; ---------------------------------------------------------------------------

loc_10397:				; CODE XREF: start+292j
		test	al, 20h
		jz	short loc_1039E
		jmp	loc_10466
; ---------------------------------------------------------------------------

loc_1039E:				; CODE XREF: start+299j
		jmp	short loc_1032A
; ---------------------------------------------------------------------------

loc_103A0:				; CODE XREF: start+240j start+248j ...
		xor	bx, bx
		mov	dx, 3
		mov	ah, 6
		int	68h		;  - APPC/PC - CHANGE NUMBER OF	SESSIONS
					; DS:DX	-> control block
		cmp	env_MusicMode, 1
		jnz	short loc_103B3
		jmp	loc_1032A
; ---------------------------------------------------------------------------

loc_103B3:				; CODE XREF: start+2AEj
		mov	drawColX, 36
		mov	drawRowY, 130
		mov	txtColorMain, 1
		mov	txtColorShdw, 8
		mov	si, offset aSound_FM ; "‚e‚l‰¹Œ¹"
		call	DrawText	; "FM sound source"
		mov	drawColX, 34
		mov	drawRowY, 148
		mov	txtColorMain, 3
		mov	txtColorShdw, 0
		mov	si, offset aSound_MIDI ; "‚l‚h‚c‚h‰¹Œ¹"
		call	DrawText	; "MIDI	sound source"
		mov	env_MusicMode, 1
		cmp	env_PmdState, 1
		jz	short loc_103FA
		jmp	loc_1032A
; ---------------------------------------------------------------------------

loc_103FA:				; CODE XREF: start+2F5j
		mov	ah, 0Ch		; routine 0C - play sound effect
		mov	al, 26h
		int	60h		; call PMD driver
		jmp	loc_1032A
; ---------------------------------------------------------------------------

loc_10403:				; CODE XREF: start+252j start+25Dj ...
		xor	bx, bx
		mov	dx, 11h
		mov	ah, 6
		int	68h		;  - APPC/PC - CHANGE NUMBER OF	SESSIONS
					; DS:DX	-> control block
		cmp	env_MusicMode, 2
		jnz	short loc_10416
		jmp	loc_1032A
; ---------------------------------------------------------------------------

loc_10416:				; CODE XREF: start+311j
		mov	drawColX, 36
		mov	drawRowY, 130
		mov	txtColorMain, 3
		mov	txtColorShdw, 0
		mov	si, offset aSound_FM ; "‚e‚l‰¹Œ¹"
		call	DrawText	; "FM sound source"
		mov	drawColX, 34
		mov	drawRowY, 148
		mov	txtColorMain, 1
		mov	txtColorShdw, 8
		mov	si, offset aSound_MIDI ; "‚l‚h‚c‚h‰¹Œ¹"
		call	DrawText	; "MIDI	sound source"
		mov	env_MusicMode, 2
		cmp	env_PmdState, 1
		jz	short loc_1045D
		jmp	loc_1032A
; ---------------------------------------------------------------------------

loc_1045D:				; CODE XREF: start+358j
		mov	ah, 0Ch		; routine 0C - play sound effect
		mov	al, 26h
		int	60h		; call PMD driver
		jmp	loc_1032A
; ---------------------------------------------------------------------------

loc_10466:				; CODE XREF: start+237j start+268j ...
		mov	ah, 9
		int	68h		;  - APPC/PC
		test	al, 1
		jnz	short loc_10466
		test	al, 2
		jnz	short loc_10466
		mov	al, es:52Dh
		or	al, es:530h
		test	al, 10h
		jnz	short loc_10466
		mov	ah, 16h		; routine 16 - read joystick
		int	60h		; call PMD driver
		not	al
		and	al, 3Fh
		or	al, al
		jnz	short loc_10466
		mov	ah, 0Ch		; routine 0C - play sound effect
		mov	al, 1
		int	60h		; call PMD driver

loc_10491:				; CODE XREF: start+19Fj start+1A9j ...
		mov	drawColX, 23	; start	pixel X	= 23 * 8 = 184
		mov	drawRowY, 12	; start	pixel Y	= 12 * 16 = 192
		mov	drawWidth, 15	; inner	width =	15 * 16	= 240
		mov	drawHeight, 3	; inner	height = 3 * 16	= 48
		call	DrawTextBox	; draw text box	for Display Mode Selection
		mov	drawColX, 25	; X = 25 * 8 = 200
		mov	drawRowY, 202	; Y = 202
		mov	txtColorMain, 4
		mov	txtColorShdw, 8
		mov	si, offset aDispMode ; "¡@ƒfƒBƒXƒvƒŒƒCƒ‚[ƒh‘I‘ğ@¡"
		call	DrawText	; "Select Display Mode"
		mov	drawColX, 30	; X = 30 * 8 = 240
		mov	drawRowY, 226	; Y = 226
		mov	txtColorMain, 1
		mov	txtColorShdw, 8
		mov	si, offset aDisp_Analog	; "ƒAƒiƒƒOƒfƒBƒXƒvƒŒƒC"
		call	DrawText	; "Analog Display"
		mov	drawColX, 32	; X = 32 * 8 = 256
		mov	drawRowY, 244	; Y = 244
		mov	txtColorMain, 3
		mov	txtColorShdw, 0
		mov	si, offset aDisp_LCD ; "‰t»ƒfƒBƒXƒvƒŒƒC"
		call	DrawText	; "LCD display"
		mov	env_DispMode, 0

loc_10505:				; CODE XREF: start:loc_10580j
					; start+492j ...
		mov	al, es:52Dh
		or	al, es:530h
		test	al, 10h
		jz	short loc_10515
		jmp	loc_10654
; ---------------------------------------------------------------------------

loc_10515:				; CODE XREF: start+410j
		mov	al, es:531h
		test	al, 4
		jnz	short loc_10582
		mov	al, es:532h
		test	al, 8
		jnz	short loc_10582
		mov	al, es:531h
		test	al, 20h
		jz	short loc_10530
		jmp	loc_105EB
; ---------------------------------------------------------------------------

loc_10530:				; CODE XREF: start+42Bj
		mov	al, es:533h
		test	al, 8
		jz	short loc_1053B
		jmp	loc_105EB
; ---------------------------------------------------------------------------

loc_1053B:				; CODE XREF: start+436j
		mov	ah, 9
		int	68h		;  - APPC/PC
		test	al, 1
		jz	short loc_10546
		jmp	loc_10654
; ---------------------------------------------------------------------------

loc_10546:				; CODE XREF: start+441j
		test	al, 2
		jz	short loc_1054D
		jmp	loc_10654
; ---------------------------------------------------------------------------

loc_1054D:				; CODE XREF: start+448j
		mov	ah, 5
		int	68h		;  - APPC/PC - TRANSFER	MSG DATA
					; DS:DX	-> control block
		or	dx, dx
		jz	short loc_10582
		cmp	dx, 12h
		jnz	short loc_1055D
		jmp	loc_105EB
; ---------------------------------------------------------------------------

loc_1055D:				; CODE XREF: start+458j
		cmp	env_PmdState, 1
		jnz	short loc_10580
		mov	ah, 16h		; routine 16 - read joystick
		int	60h		; call PMD driver
		not	al
		test	al, 1
		jnz	short loc_10582
		test	al, 2
		jnz	short loc_105EB
		test	al, 10h
		jz	short loc_10579
		jmp	loc_10654
; ---------------------------------------------------------------------------

loc_10579:				; CODE XREF: start+474j
		test	al, 20h
		jz	short loc_10580
		jmp	loc_10654
; ---------------------------------------------------------------------------

loc_10580:				; CODE XREF: start+462j start+47Bj
		jmp	short loc_10505
; ---------------------------------------------------------------------------

loc_10582:				; CODE XREF: start+41Bj start+423j ...
		xor	bx, bx
		mov	dx, 1
		mov	ah, 6
		int	68h		;  - APPC/PC - CHANGE NUMBER OF	SESSIONS
					; DS:DX	-> control block
		cmp	env_DispMode, 0
		jnz	short loc_10595
		jmp	loc_10505
; ---------------------------------------------------------------------------

loc_10595:				; CODE XREF: start+490j
		mov	drawColX, 30
		mov	drawRowY, 226
		mov	txtColorMain, 1
		mov	txtColorShdw, 8
		mov	si, offset aDisp_Analog	; "ƒAƒiƒƒOƒfƒBƒXƒvƒŒƒC"
		call	DrawText	; "Analog Display"
		mov	drawColX, 32
		mov	drawRowY, 244
		mov	txtColorMain, 3
		mov	txtColorShdw, 0
		mov	si, offset aDisp_LCD ; "‰t»ƒfƒBƒXƒvƒŒƒC"
		call	DrawText	; "LCD display"
		mov	env_DispMode, 0
		mov	si, offset PaletteDataRGB
		call	LoadPalette_RGB
		cmp	env_PmdState, 1
		jz	short loc_105E2
		jmp	loc_10505
; ---------------------------------------------------------------------------

loc_105E2:				; CODE XREF: start+4DDj
		mov	ah, 0Ch		; routine 0C - play sound effect
		mov	al, 26h
		int	60h		; call PMD driver
		jmp	loc_10505
; ---------------------------------------------------------------------------

loc_105EB:				; CODE XREF: start+42Dj start+438j ...
		xor	bx, bx
		mov	dx, 11h
		mov	ah, 6
		int	68h		;  - APPC/PC - CHANGE NUMBER OF	SESSIONS
					; DS:DX	-> control block
		cmp	env_DispMode, 1
		jnz	short loc_105FE
		jmp	loc_10505
; ---------------------------------------------------------------------------

loc_105FE:				; CODE XREF: start+4F9j
		mov	drawColX, 30
		mov	drawRowY, 226
		mov	txtColorMain, 3
		mov	txtColorShdw, 0
		mov	si, offset aDisp_Analog	; "ƒAƒiƒƒOƒfƒBƒXƒvƒŒƒC"
		call	DrawText	; "Analog Display"
		mov	drawColX, 32
		mov	drawRowY, 244
		mov	txtColorMain, 1
		mov	txtColorShdw, 8
		mov	si, offset aDisp_LCD ; "‰t»ƒfƒBƒXƒvƒŒƒC"
		call	DrawText	; "LCD display"
		mov	env_DispMode, 1
		mov	si, offset PaletteDataRGB
		call	LoadPalette_LCD
		cmp	env_PmdState, 1
		jz	short loc_1064B
		jmp	loc_10505
; ---------------------------------------------------------------------------

loc_1064B:				; CODE XREF: start+546j
		mov	ah, 0Ch		; routine 0C - play sound effect
		mov	al, 26h
		int	60h		; call PMD driver
		jmp	loc_10505
; ---------------------------------------------------------------------------

loc_10654:				; CODE XREF: start+412j start+443j ...
		mov	ah, 9
		int	68h		;  - APPC/PC
		test	al, 1
		jnz	short loc_10654
		test	al, 2
		jnz	short loc_10654
		cmp	env_PmdState, 1
		jnz	short loc_10681
		mov	ah, 16h		; routine 16 - read joystick
		int	60h		; call PMD driver
		not	al
		and	al, 3Fh
		or	al, al
		jnz	short loc_10654
		mov	ah, 0Ch		; routine 0C - play sound effect
		mov	al, 1
		int	60h		; call PMD driver

loc_10679:				; CODE XREF: start+57Fj
		mov	ah, 11h		; routine 11 - get number of currently playing FM sound	effect
		int	60h		; call PMD driver
		cmp	al, 0FFh
		jnz	short loc_10679	; wait for sound effect	to finish

loc_10681:				; CODE XREF: start+565j
		cmp	env_MusicMode, 2
		jnz	short loc_106F6
		mov	drawColX, 24	; start	pixel X	= 24 * 8 = 192
		mov	drawRowY, 18	; start	pixel Y	= 18 * 16 = 288
		mov	drawWidth, 14	; inner	width =	14 * 16	= 224
		mov	drawHeight, 1	; inner	height = 1 * 16	= 16
		call	DrawTextBox	; draw text box	for "MIDI Init"	message
		mov	drawColX, 26	; X = 26 * 8 = 208
		mov	drawRowY, 303	; Y = 303
		mov	txtColorMain, 0Ah
		mov	txtColorShdw, 9
		mov	si, offset aMidiInit ; "¡@‚l‚h‚c‚h‰¹Œ¹‰Šú‰»’†@¡"
		call	DrawText	; "MIDI	Initialization in progress"
		mov	ah, 1		; routine 01 - stop music
		int	61h		; call MMD driver
		mov	ax, cs
		mov	ds, ax
		mov	dx, offset aBMusGs_reset_n ; "B:MUS\\GS_RESET.N"
		call	fopen_r
		mov	ax, 4
		jnb	short loc_106D5
		jmp	ErrExit		; Error	4: GS_RESET.N not found
; ---------------------------------------------------------------------------

loc_106D5:				; CODE XREF: start+5D0j
		mov	ah, 6		; routine 06 - get song	data address
		int	61h		; call MMD driver
		mov	cx, 0FFFFh
		call	fread
		mov	ax, 4
		jnb	short loc_106E7
		jmp	ErrExit		; Error	4: GS_RESET.N not found
; ---------------------------------------------------------------------------

loc_106E7:				; CODE XREF: start+5E2j
		call	fclose
		mov	ax, 4
		jnb	short loc_106F2
		jmp	ErrExit		; Error	4: GS_RESET.N not found
; ---------------------------------------------------------------------------

loc_106F2:				; CODE XREF: start+5EDj
		mov	ah, 0		; routine 00 - start playback
		int	61h		; call MMD driver

loc_106F6:				; CODE XREF: start+586j
		mov	ax, cs
		mov	ds, ax
		mov	ax, 0C00h
		int	21h		; DOS -	CLEAR KEYBOARD BUFFER
					; AL must be 01h, 06h, 07h, 08h, or 0Ah.
		call	ClearScreen
		mov	ah, 2
		int	68h		;  - APPC/PC
					; DS:DX	-> control block
		mov	dx, offset aStssp_env ;	"STSSP.ENV"
		call	fopen_w
		jnb	short loc_10714
		mov	ax, 7
		jmp	ErrExit		; Error	7: Unable to write STSSP.ENV
; ---------------------------------------------------------------------------

loc_10714:				; CODE XREF: start+60Cj
		mov	dx, offset env_PmdState
		mov	cx, 5
		call	fwrite
		jnb	short loc_10725
		mov	ax, 7
		jmp	ErrExit		; Error	7: Unable to write STSSP.ENV
; ---------------------------------------------------------------------------

loc_10725:				; CODE XREF: start+61Dj
		call	fclose
		mov	dx, offset a0m1h5h ; "\x1B[0m\x1B[>1h\x1B[>5h\x1B*$"
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		mov	ah, 0Ch
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		mov	ax, cs
		mov	ds, ax
		mov	es, ax
		assume es:seg000
		mov	bx, cs
		cmp	env_DiskMode, 1
		jz	short loc_10747
		mov	cx, offset asc_10E32 ; " /F"
		jmp	short loc_1074A
; ---------------------------------------------------------------------------

loc_10747:				; CODE XREF: start+640j
		mov	cx, offset asc_10E36 ; " /H"

loc_1074A:				; CODE XREF: start+645j
		mov	dx, offset aBMime_op_exe ; "B:MIME_OP.EXE"
		call	ExecuteProgram	; run MIME opening
		mov	ax, 5
		jnb	short loc_10758
		jmp	ErrExit		; Error	5: MIME_OP.EXE not found
; ---------------------------------------------------------------------------

loc_10758:				; CODE XREF: start+653j
		mov	ah, 0Dh
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		mov	dx, offset a0m1h5h ; "\x1B[0m\x1B[>1h\x1B[>5h\x1B*$"
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		mov	ah, 0Ch
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		mov	ax, cs
		mov	ds, ax
		mov	es, ax
		mov	bx, cs
		cmp	env_DiskMode, 1
		jz	short loc_1077B
		mov	cx, offset asc_10E45 ; " /F"
		jmp	short loc_1077E
; ---------------------------------------------------------------------------

loc_1077B:				; CODE XREF: start+674j
		mov	cx, offset unk_10E49

loc_1077E:				; CODE XREF: start+679j
		mov	dx, offset aAMime_exe ;	"A:MIME.EXE"
		call	ExecuteProgram	; run MIME main	game
		mov	ax, 6
		jnb	short loc_1078C
		jmp	ErrExit		; Error	6: MIME.EXE not	found
; ---------------------------------------------------------------------------

loc_1078C:				; CODE XREF: start+687j
		mov	dx, offset aNewLine ; "\r\n$"
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		mov	bx, cs
		mov	cx, offset aR_1	; " /R"
		mov	dx, offset aBStmd_com ;	"B:STMD.COM"
		call	ExecuteProgram	; remove mouse driver
		mov	ax, 2
		jnb	short loc_107A6
		jmp	ErrExit		; Error	5: STMD.COM not	found
; ---------------------------------------------------------------------------

loc_107A6:				; CODE XREF: start+6A1j
		mov	dx, offset aNewLine ; "\r\n$"
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		mov	bx, cs
		mov	cx, offset aR_0	; " /R"
		mov	dx, offset aBMmd_com ; "B:MMD.COM"
		call	ExecuteProgram	; remove MMD driver (MIDI music)
		mov	ax, 1
		jb	short ErrExit	; Error	1: MMD.COM not found
		mov	dx, offset aNewLine ; "\r\n$"
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		mov	bx, cs
		mov	cx, offset aR	; " # /R"
		mov	dx, offset aBPmd_com ; "B:PMD.COM"
		call	ExecuteProgram	; remove PMD driver (FM	music)
		mov	ax, 0
		jb	short ErrExit	; Error	0: PMD.COM not found
		mov	ax, cs
		mov	ds, ax
		mov	dx, offset aNewLine ; "\r\n$"
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		mov	si, offset PaletteDataRGB
		call	LoadPalette_RGB
		call	ClearScreen
		mov	dx, offset GreetingText	; "Studio Twin'kle System Startup Program "...
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		mov	ax, 0C00h
		int	21h		; DOS -	CLEAR KEYBOARD BUFFER
					; AL must be 01h, 06h, 07h, 08h, or 0Ah.
		cmp	env_DiskMode, 0
		jz	short loc_1082A
		mov	dx, offset QuitText_HDD	; "\x1B[7;36m‚¨”æ‚ê—l‚Å‚µ‚½.\x1B[m\r\n$"
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		mov	dx, offset a1l5l ; "\x1B[>1l\x1B[>5l$"
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		mov	ah, 0Ch
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		mov	ah, 11h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		call	RestoreIntVec05
		call	RestoreIntVec06
		push	es
		xor	ax, ax
		mov	es, ax
		assume es:nothing
		mov	al, cs:byte_10E88
		mov	es:500h, al
		pop	es
		assume es:nothing
		mov	ax, 4C00h
		int	21h		; DOS -	2+ - QUIT WITH EXIT CODE (EXIT)
					; AL = exit code
; ---------------------------------------------------------------------------

loc_1082A:				; CODE XREF: start+6F9j
		mov	dx, offset QuitText_Floppy ; "\x1B[7;36m‚¨”æ‚ê—l‚Å‚µ‚½.	ƒfƒBƒXƒN‚ğ”²‚¢‚Ä"...
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		mov	dx, offset a1l5l ; "\x1B[>1l\x1B[>5l$"
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"

loc_10838:				; CODE XREF: start:loc_10838j
		jmp	short loc_10838
; ---------------------------------------------------------------------------

ErrExit:				; CODE XREF: start+CAj	start+E4j ...
		pusha
		mov	ax, cs
		mov	ds, ax
		mov	es, ax
		assume es:seg000
		mov	si, offset PaletteDataRGB
		call	LoadPalette_RGB
		call	ClearScreen
		mov	bx, cs
		mov	cx, offset aR_1	; " /R"
		mov	dx, offset aBStmd_com ;	"B:STMD.COM"
		call	ExecuteProgram	; remove mouse driver
		mov	bx, cs
		mov	cx, offset aR_0	; " /R"
		mov	dx, offset aBMmd_com ; "B:MMD.COM"
		call	ExecuteProgram	; remove MMD driver (MIDI music)
		mov	bx, cs
		mov	cx, offset aR	; " # /R"
		mov	dx, offset aBPmd_com ; "B:PMD.COM"
		call	ExecuteProgram	; remove PMD driver (FM	music)
		mov	dx, offset a0m1h5h ; "\x1B[0m\x1B[>1h\x1B[>5h\x1B*$"
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		mov	ax, cs
		mov	ds, ax
		mov	ax, 0C00h
		int	21h		; DOS -	CLEAR KEYBOARD BUFFER
					; AL must be 01h, 06h, 07h, 08h, or 0Ah.
		mov	ah, 0Ch
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		mov	dx, offset GreetingText	; "Studio Twin'kle System Startup Program "...
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		mov	dx, offset a5731m ; "\x1B[5;7;31m$"
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		popa
		cmp	ax, 7
		jz	short loc_108AE
		cmp	ax, 8
		jz	short loc_108B7
		add	ax, ax
		mov	bx, offset FileNameList
		add	bx, ax
		mov	dx, [bx]
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		mov	dx, offset Err_NotFound	; " ‚ªŒ©‚Â‚©‚è‚Ü‚¹‚ñ$"
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		jmp	short loc_108BE
; ---------------------------------------------------------------------------

loc_108AE:				; CODE XREF: start+791j
		mov	dx, offset Err_WriteEnv	; "STSSP.ENV ‚ª‘‚«‚İo—ˆ‚Ü‚¹‚ñ$"
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		jmp	short loc_108BE
; ---------------------------------------------------------------------------

loc_108B7:				; CODE XREF: start+796j
		mov	dx, offset Err_CantOperate ; "‚±‚ÌŠÂ‹«‚Å‚Í“®ìo—ˆ‚Ü‚¹‚ñ$"
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"

loc_108BE:				; CODE XREF: start+7ACj start+7B5j
		mov	dx, offset aExclamation	; "I\x1B[m\r\n$"
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		mov	dx, offset a1l5l ; "\x1B[>1l\x1B[>5l$"
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		cmp	env_DiskMode, 0
		jz	short loc_108F0
		mov	ah, 11h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		call	RestoreIntVec05
		call	RestoreIntVec06
		push	es
		xor	ax, ax
		mov	es, ax
		assume es:nothing
		mov	al, cs:byte_10E88
		mov	es:500h, al
		pop	es
		assume es:nothing
		mov	ax, 4C01h
		int	21h		; DOS -	2+ - QUIT WITH EXIT CODE (EXIT)
					; AL = exit code
; ---------------------------------------------------------------------------

loc_108F0:				; CODE XREF: start+7D1j
		mov	dx, offset Err_PleaseReset ; "\r\n•œ‹Ao—ˆ‚Ü‚¹‚ñ. ƒŠƒZƒbƒg‚µ‚Ä‚­‚¾‚³‚¢."...
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"

loc_108F7:				; CODE XREF: start:loc_108F7j
		jmp	short loc_108F7
start		endp


; =============== S U B	R O U T	I N E =======================================


ExecuteProgram	proc near		; CODE XREF: start+C2p	start+DCp ...
		push	ds
		push	es
		mov	ax, cs
		mov	ds, ax
		mov	es, ax
		assume es:seg000
		mov	di, offset byte_10E6E
		mov	ax, 2Ch
		mov	[di], ax
		mov	[di+4],	bx
		mov	[di+2],	cx
		mov	bx, es
		mov	[di+8],	bx
		mov	[di+0Ch], bx
		mov	cx, 5Ch
		mov	[di+6],	cx
		mov	cx, 6Ch
		mov	[di+0Ah], cx
		mov	ax, cs
		mov	es, ax
		mov	bx, di
		cmp	cs:env_DiskMode, 1
		jnz	short loc_10934
		add	dx, 2

loc_10934:				; CODE XREF: ExecuteProgram+36j
		mov	ax, 4B00h
		int	21h		; DOS -	2+ - LOAD OR EXECUTE (EXEC)
					; DS:DX	-> ASCIZ filename
					; ES:BX	-> parameter block
					; AL = subfunc:	load & execute program
		pop	es
		assume es:nothing
		pop	ds
		retn
ExecuteProgram	endp


; =============== S U B	R O U T	I N E =======================================


ClearScreen	proc near		; CODE XREF: start:loc_101B1p
					; start+5FFp ...
		call	WaitForVSync
		mov	ah, 41h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		mov	al, 2
		out	68h, al
		mov	al, 8
		out	68h, al
		mov	al, 1
		out	6Ah, al
		mov	al, 41h
		out	6Ah, al
		mov	ah, 42h
		mov	ch, 0C0h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		xor	al, al
		out	0A4h, al	; Interrupt Controller #2, 8259A
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	al, 80h
		out	7Ch, al
		xor	al, al
		mov	dx, 7Eh
		out	dx, al
		out	dx, al
		out	dx, al
		out	dx, al
		mov	ah, 0A8h
		mov	es, ax
		assume es:nothing
		xor	di, di
		mov	cx, 3E80h
		rep stosw
		out	7Ch, al
		mov	ah, 40h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		retn
ClearScreen	endp


; =============== S U B	R O U T	I N E =======================================


LoadPalette_RGB	proc near		; CODE XREF: start+B7p	start+4D5p ...
		push	ax
		push	cx
		call	WaitForVSync
		mov	cx, 10h

loc_10986:				; CODE XREF: LoadPalette_RGB+17j
		mov	al, 10h
		sub	al, cl
		out	0A8h, al	; Interrupt Controller #2, 8259A
		lodsb
		out	0ACh, al	; Interrupt Controller #2, 8259A
		lodsb
		out	0AAh, al	; Interrupt Controller #2, 8259A
		lodsb
		out	0AEh, al	; Interrupt Controller #2, 8259A
		loop	loc_10986
		pop	cx
		pop	ax
		retn
LoadPalette_RGB	endp


; =============== S U B	R O U T	I N E =======================================


LoadPalette_LCD	proc near		; CODE XREF: start+53Ep
		pusha
		mov	cx, 10h
		xor	ax, ax
		call	WaitForVSync

loc_109A3:				; CODE XREF: LoadPalette_LCD+12j
		push	ax
		out	0A8h, al	; GDC: set palette
		call	LoadColour_LCD
		pop	ax
		inc	al
		loop	loc_109A3
		popa
		retn
LoadPalette_LCD	endp


; =============== S U B	R O U T	I N E =======================================


LoadColour_LCD	proc near		; CODE XREF: LoadPalette_LCD+Cp
		push	ax
		push	bx
		push	cx
		push	dx
		lodsb
		xor	ah, ah
		mov	word_10EBE, ax
		lodsb
		xor	ah, ah
		mov	word_10EC0, ax
		lodsb
		xor	ah, ah
		mov	word_10EC2, ax
		mov	ax, word_10EBE
		mov	bx, ax
		shl	ax, 5
		add	bx, bx
		add	ax, bx
		add	bx, bx
		add	ax, bx
		mov	bx, word_10EC0
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
		mov	bx, word_10EC0
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
		add	bx, offset PaletteDataLCD
		mov	ax, cs:[bx]
		out	0ACh, al	; GDC: set colour Red
		mov	ax, cs:[bx+2]
		out	0AAh, al	; GDC: set colour Green
		mov	ax, cs:[bx+4]
		out	0AEh, al	; GDC: set colour Blue
		pop	dx
		pop	cx
		pop	bx
		pop	ax
		retn
LoadColour_LCD	endp

; ---------------------------------------------------------------------------
PaletteDataLCD	db    0,   0,	0	; DATA XREF: LoadColour_LCD+62o
		db    0,   0,	0
		db    0,   0,	0
		db    0, 0Fh,	0
		db  0Fh,   0,	0
		db    0,   0,	0
		db  0Fh,   0,	0
		db    0, 0Fh,	0
		db    0,   0, 0Fh
		db    0,   0,	0
		db    0,   0, 0Fh
		db    0, 0Fh,	0
		db  0Fh,   0, 0Fh
		db    0,   0,	0
		db  0Fh,   0, 0Fh
		db    0, 0Fh,	0

; =============== S U B	R O U T	I N E =======================================


WaitForVSync	proc near		; CODE XREF: ClearScreenp
					; LoadPalette_RGB+2p ...
		push	ax

loc_10A5D:				; CODE XREF: WaitForVSync+5j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_10A5D

loc_10A63:				; CODE XREF: WaitForVSync+Bj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_10A63
		pop	ax
		retn
WaitForVSync	endp


; =============== S U B	R O U T	I N E =======================================


DrawText	proc near		; CODE XREF: start+1EAp start+206p ...
		push	ax
		push	ds
		mov	ax, cs
		mov	ds, ax
		mov	bx, drawColX
		mov	cx, drawRowY
		imul	dx, cx,	50h
		add	dx, bx
		mov	textDrawPtr, dx
		call	WaitForVSync
		mov	al, 0Bh
		out	68h, al

loc_10A89:				; CODE XREF: DrawText+28j
		lodsw
		or	al, al
		jz	short loc_10A95
		xchg	al, ah
		call	DrawTextChar
		jmp	short loc_10A89
; ---------------------------------------------------------------------------

loc_10A95:				; CODE XREF: DrawText+21j
		mov	al, 0Ah
		out	68h, al
		pop	ds
		pop	ax
		retn
DrawText	endp


; =============== S U B	R O U T	I N E =======================================


DrawTextChar	proc near		; CODE XREF: DrawText+25p
		pusha
		push	ds
		push	es
		push	ax
		mov	ax, cs
		mov	ds, ax
		mov	di, cs:textDrawPtr
		mov	ax, 0A800h
		mov	es, ax
		mov	al, 0C0h
		out	7Ch, al
		pop	ax

dtc_sjis2jis:				; convert Shift-JIS to JIS code
		add	ah, ah
		sub	al, 1Fh
		js	short loc_10ABD
		cmp	al, 61h
		adc	al, 0DEh

loc_10ABD:				; CODE XREF: DrawTextChar+1Bj
		add	ax, 1FA1h
		and	ax, 7F7Fh
		sub	ax, 2000h

dtc_getchar:				; character code, low byte
		out	0A1h, al
		mov	al, ah
		out	0A3h, al	; character code, high byte (page)
		mov	si, offset txtFontCache
		mov	dx, si
		xor	cl, cl

loc_10AD3:				; CODE XREF: DrawTextChar+52j
		mov	al, cl
		or	al, 20h		; L/R bit = "right"
		out	0A5h, al	; write	Name Line Counter, font	pattern	"right"
		in	al, 0A9h	; read Name Character Pattern Data
		mov	ah, al
		mov	al, cl		; L/R bit = "left"
		out	0A5h, al	; write	Name Line Counter, font	pattern	"left"
		in	al, 0A9h	; read Name Character Pattern Data
		mov	cs:[si], ax
		add	si, 2
		inc	cl
		cmp	cl, 10h
		jb	short loc_10AD3

dtc_draw:
		mov	ah, cs:txtColorShdw
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
		push	di
		add	di, 50h
		mov	si, dx
		xor	cl, cl

loc_10B15:				; CODE XREF: DrawTextChar+92j
		mov	ax, cs:[si]
		mov	bx, ax
		shr	bx, 1
		or	ax, bx
		xchg	al, ah
		mov	es:[di], ax
		add	di, 50h
		add	si, 2
		inc	cl
		cmp	cl, 10h
		jb	short loc_10B15
		mov	ah, cs:txtColorMain
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

loc_10B52:				; CODE XREF: DrawTextChar+D5j
		mov	ax, cs:[si]
		mov	bx, ax
		shl	bx, 1
		not	bx
		and	ax, bx
		not	bx
		or	ax, bx
		xchg	al, ah
		mov	es:[di], ax
		add	di, 50h
		add	si, 2
		inc	cl
		cmp	cl, 10h
		jb	short loc_10B52
		xor	al, al
		out	7Ch, al
		sub	di, 4FEh	; go back by 16	lines (500h bytes) minus 2 bytes (1x full-width)
		mov	cs:textDrawPtr,	di
		pop	es
		assume es:nothing
		pop	ds
		popa
		retn
DrawTextChar	endp


; =============== S U B	R O U T	I N E =======================================


DrawTextBox	proc near		; CODE XREF: start+1CEp start+3A9p ...
		pusha
		push	ds
		push	es
		mov	ax, cs
		mov	ds, ax
		mov	bx, drawColX
		mov	cx, drawRowY
		imul	dx, cx,	500h
		add	dx, bx
		mov	di, dx
		call	WaitForVSync
		push	di
		mov	si, offset TextBoxBrd_UL
		call	CopyBoxSquare
		mov	si, offset TextBoxBrd_UM
		mov	cx, drawWidth

loc_10BAC:				; CODE XREF: DrawTextBox+2Bj
		call	CopyBoxSquare
		loop	loc_10BAC
		mov	si, offset TextBoxBrd_UR
		call	CopyBoxSquare
		pop	di
		push	di
		add	di, 500h
		mov	cx, drawHeight

loc_10BC1:				; CODE XREF: DrawTextBox+65j
		push	cx
		mov	si, offset TextBoxBrd_ML
		call	CopyBoxSquare
		mov	si, offset TextBoxBG
		mov	cx, drawWidth

loc_10BCF:				; CODE XREF: DrawTextBox+4Ej
		call	CopyBoxSquare
		loop	loc_10BCF
		mov	si, offset TextBoxBrd_MR
		call	CopyBoxSquare
		mov	ax, drawWidth
		add	ax, ax		; 16 pixel units -> 8 pixel units
		add	ax, 4		; add 32 pixels	for border (left/right)
		add	di, 500h
		sub	di, ax
		pop	cx
		loop	loc_10BC1
		pop	di
		add	di, 500h
		mov	cx, drawHeight
		imul	ax, cx,	500h
		add	di, ax
		mov	si, offset TextBoxBrd_LL
		call	CopyBoxSquare
		mov	si, offset TextBoxBrd_LM
		mov	cx, drawWidth

loc_10C07:				; CODE XREF: DrawTextBox+86j
		call	CopyBoxSquare
		loop	loc_10C07
		mov	si, offset TextBoxBrd_LR
		call	CopyBoxSquare
		pop	es
		pop	ds
		popa
		retn
DrawTextBox	endp


; =============== S U B	R O U T	I N E =======================================


CopyBoxSquare	proc near		; CODE XREF: DrawTextBox+1Ep
					; DrawTextBox:loc_10BACp ...
		push	cx
		push	si
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		push	di
		mov	cx, 10h

loc_10C21:				; CODE XREF: CopyBoxSquare+Fj
		movsw
		add	di, 4Eh
		loop	loc_10C21
		pop	di
		mov	ax, 0B000h
		mov	es, ax
		assume es:nothing
		push	di
		mov	cx, 10h

loc_10C31:				; CODE XREF: CopyBoxSquare+1Fj
		movsw
		add	di, 4Eh
		loop	loc_10C31
		pop	di
		mov	ax, 0B800h
		mov	es, ax
		assume es:nothing
		push	di
		mov	cx, 10h

loc_10C41:				; CODE XREF: CopyBoxSquare+2Fj
		movsw
		add	di, 4Eh
		loop	loc_10C41
		pop	di
		mov	ax, 0E000h
		mov	es, ax
		assume es:nothing
		xor	ax, ax
		push	di
		mov	cx, 10h

loc_10C53:				; CODE XREF: CopyBoxSquare+41j
		stosw
		add	di, 4Eh
		loop	loc_10C53
		pop	di
		add	di, 2
		pop	si
		pop	cx
		retn
CopyBoxSquare	endp


; =============== S U B	R O U T	I N E =======================================


CheckForPMD	proc near		; CODE XREF: start+13Bp
		push	es
		xor	ax, ax
		mov	es, ax
		assume es:nothing
		les	bx, es:180h
		assume es:nothing
		cmp	byte ptr es:[bx+2], 'P'
		jnz	short loc_10C82
		cmp	byte ptr es:[bx+3], 'M'
		jnz	short loc_10C82
		cmp	byte ptr es:[bx+4], 'D'
		jnz	short loc_10C82
		pop	es
		clc
		retn
; ---------------------------------------------------------------------------

loc_10C82:				; CODE XREF: CheckForPMD+Fj
					; CheckForPMD+16j ...
		pop	es
		stc
		retn
CheckForPMD	endp


; =============== S U B	R O U T	I N E =======================================


CheckForMMD	proc near		; CODE XREF: start:loc_10260p
		push	es
		xor	ax, ax
		mov	es, ax
		assume es:nothing
		les	bx, es:184h
		assume es:nothing
		cmp	byte ptr es:[bx+2], 'M'
		jnz	short loc_10CA7
		cmp	byte ptr es:[bx+3], 'M'
		jnz	short loc_10CA7
		cmp	byte ptr es:[bx+4], 'D'
		jnz	short loc_10CA7
		pop	es
		clc
		retn
; ---------------------------------------------------------------------------

loc_10CA7:				; CODE XREF: CheckForMMD+Fj
					; CheckForMMD+16j ...
		pop	es
		stc
		retn
CheckForMMD	endp


; =============== S U B	R O U T	I N E =======================================


fopen_r		proc near		; CODE XREF: start+10Fp start+5CAp
		cmp	cs:env_DiskMode, 1
		jnz	short loc_10CB5
		add	dx, 2

loc_10CB5:				; CODE XREF: fopen_r+6j
		mov	ax, 3D00h
		int	21h		; DOS -	2+ - OPEN DISK FILE WITH HANDLE
					; DS:DX	-> ASCIZ filename
					; AL = access mode
					; 0 - read
		mov	cs:word_10E86, ax
		retn
fopen_r		endp


; =============== S U B	R O U T	I N E =======================================


fread		proc near		; CODE XREF: start+121p start+5DCp
		mov	bx, cs:word_10E86
		mov	ah, 3Fh
		int	21h		; DOS -	2+ - READ FROM FILE WITH HANDLE
					; BX = file handle, CX = number	of bytes to read
					; DS:DX	-> buffer
		retn
fread		endp


; =============== S U B	R O U T	I N E =======================================


fclose		proc near		; CODE XREF: start:loc_1022Cp
					; start:loc_106E7p ...
		mov	ah, 3Eh
		mov	bx, cs:word_10E86
		int	21h		; DOS -	2+ - CLOSE A FILE WITH HANDLE
					; BX = file handle
		retn
fclose		endp


; =============== S U B	R O U T	I N E =======================================


fopen_w		proc near		; CODE XREF: start+609p
		mov	ah, 3Ch
		xor	cx, cx
		int	21h		; DOS -	2+ - CREATE A FILE WITH	HANDLE (CREAT)
					; CX = attributes for file
					; DS:DX	-> ASCIZ filename (may include drive and path)
		mov	cs:word_10E86, ax
		retn
fopen_w		endp


; =============== S U B	R O U T	I N E =======================================


fwrite		proc near		; CODE XREF: start+61Ap
		mov	ah, 40h
		mov	bx, cs:word_10E86
		int	21h		; DOS -	2+ - WRITE TO FILE WITH	HANDLE
					; BX = file handle, CX = number	of bytes to write, DS:DX -> buffer
		retn
fwrite		endp


; =============== S U B	R O U T	I N E =======================================


SetupIntVec05	proc near		; CODE XREF: start+4Ep
		cli
		push	ax
		push	ds
		push	es
		mov	ax, cs
		mov	ds, ax
		xor	ax, ax
		mov	es, ax
		assume es:nothing
		mov	ax, es:14h
		mov	word ptr OldIntVec05, ax
		mov	ax, es:16h
		mov	word ptr OldIntVec05+2,	ax
		mov	word ptr es:14h, offset	locret_10D13
		mov	word ptr es:16h, cs
		pop	es
		assume es:nothing
		pop	ds
		pop	ax
		sti
		retn
SetupIntVec05	endp

; ---------------------------------------------------------------------------

locret_10D13:				; DATA XREF: SetupIntVec05+1Ao
		iret

; =============== S U B	R O U T	I N E =======================================


RestoreIntVec05	proc near		; CODE XREF: start+711p start+7D7p
		cli
		push	ax
		push	ds
		push	es
		mov	ax, cs
		mov	ds, ax
		xor	ax, ax
		mov	es, ax
		assume es:nothing
		mov	ax, word ptr OldIntVec05
		mov	es:14h,	ax
		mov	ax, word ptr OldIntVec05+2
		mov	es:16h,	ax
		pop	es
		assume es:nothing
		pop	ds
		pop	ax
		sti
		retn
RestoreIntVec05	endp


; =============== S U B	R O U T	I N E =======================================


SetupIntVec06	proc near		; CODE XREF: start+51p
		cli
		push	ax
		push	ds
		push	es
		mov	ax, cs
		mov	ds, ax
		xor	ax, ax
		mov	es, ax
		assume es:nothing
		mov	ax, es:18h
		mov	word ptr OldIntVec06, ax
		mov	ax, es:1Ah
		mov	word ptr OldIntVec06+2,	ax
		mov	word ptr es:18h, offset	locret_10D5E
		mov	word ptr es:1Ah, cs
		pop	es
		assume es:nothing
		pop	ds
		pop	ax
		sti
		retn
SetupIntVec06	endp

; ---------------------------------------------------------------------------

locret_10D5E:				; DATA XREF: SetupIntVec06+1Ao
		iret

; =============== S U B	R O U T	I N E =======================================


RestoreIntVec06	proc near		; CODE XREF: start+714p start+7DAp
		cli
		push	ax
		push	ds
		push	es
		mov	ax, cs
		mov	ds, ax
		xor	ax, ax
		mov	es, ax
		assume es:nothing
		mov	ax, word ptr OldIntVec06
		mov	es:18h,	ax
		mov	ax, word ptr OldIntVec06+2
		mov	es:1Ah,	ax
		pop	es
		assume es:nothing
		pop	ds
		pop	ax
		sti
		retn
RestoreIntVec06	endp


; =============== S U B	R O U T	I N E =======================================


SetupIntVec23	proc near		; CODE XREF: start+54p
		cli
		push	ax
		push	ds
		push	es
		mov	ax, cs
		mov	ds, ax
		xor	ax, ax
		mov	es, ax
		assume es:nothing
		mov	word ptr es:8Ch, offset	loc_10D9B
		mov	word ptr es:8Eh, cs
		pop	es
		assume es:nothing
		pop	ds
		pop	ax
		sti
		retn
SetupIntVec23	endp

; ---------------------------------------------------------------------------

loc_10D9B:				; DATA XREF: SetupIntVec23+Co
		popf
		popf
		popf
		iret

; =============== S U B	R O U T	I N E =======================================


SetupIntVec24	proc near		; CODE XREF: start+57p
		cli
		push	ax
		push	ds
		push	es
		mov	ax, cs
		mov	ds, ax
		xor	ax, ax
		mov	es, ax
		assume es:nothing
		mov	word ptr es:90h, offset	loc_10DBC
		mov	word ptr es:92h, cs
		pop	es
		assume es:nothing
		pop	ds
		pop	ax
		sti
		retn
SetupIntVec24	endp

; ---------------------------------------------------------------------------

loc_10DBC:				; DATA XREF: SetupIntVec24+Co
		pop	ax
		pop	ax
		pop	ax
		pop	ax
		mov	ax, di
		mov	ah, al
		pop	bx
		pop	cx
		pop	dx
		pop	si
		pop	di
		pop	bp
		pop	ds
		pop	es
		push	bx
		mov	bx, sp
		or	byte ptr ss:[bx+6], 1
		pop	bx
		iret
; ---------------------------------------------------------------------------
aBPmd_com	db 'B:PMD.COM',0        ; DATA XREF: start+BFo start+6C9o ...
aM15V0E4PIK	db ' # /M15/V0/E4/P/I-/K',0 ; DATA XREF: start+BCo
aR		db ' # /R',0            ; DATA XREF: start+6C6o start+762o
aBMmd_com	db 'B:MMD.COM',0        ; DATA XREF: start+D9o start+6B2o ...
aM26DK		db ' /M26/D-/K',0       ; DATA XREF: start+D6o
aR_0		db ' /R',0              ; DATA XREF: start+6AFo start+757o
aBStmd_com	db 'B:STMD.COM',0       ; DATA XREF: start+F3o start+698o ...
unk_10E1F	db    0			; DATA XREF: start+F0o
aR_1		db ' /R',0              ; DATA XREF: start+695o start+74Co
aBMime_op_exe	db 'B:MIME_OP.EXE',0    ; DATA XREF: start:loc_1074Ao
asc_10E32	db ' /F',0              ; DATA XREF: start+642o
asc_10E36	db ' /H',0              ; DATA XREF: start:loc_10747o
aAMime_exe	db 'A:MIME.EXE',0       ; DATA XREF: start:loc_1077Eo
asc_10E45	db ' /F',0              ; DATA XREF: start+676o
unk_10E49	db    0			; DATA XREF: start:loc_1077Bo
aBMusGs_reset_n	db 'B:MUS\GS_RESET.N',0 ; DATA XREF: start+5C7o
aBMusMime_se_ef	db 'B:MUS\MIME_SE.EFC',0 ; DATA XREF: start+10Co
		db  90h	; 
byte_10E6E	db 0Eh dup(0)		; DATA XREF: ExecuteProgram+8o
aStssp_env	db 'STSSP.ENV',0        ; DATA XREF: start+606o
word_10E86	dw 0			; DATA XREF: fopen_r+10w freadr ...
byte_10E88	db 0			; DATA XREF: start+43w	start+71Cr ...
		align 4
; --- STSSP.ENV	data start ---
env_PmdState	db 0			; DATA XREF: start+69w	start+148w ...
env_MmdState	db 0			; DATA XREF: start+6Ew	start+165w ...
env_MusicMode	db 0			; DATA XREF: start+73w	start+14Dw ...
					; detected music source
					; 0 = no music
					; 1 = FM only
					; 2 = FM+MIDI
env_DispMode	db 0			; DATA XREF: start+78w	start+400w ...
					; 0 = colour, 1	= LCD
env_DiskMode	db 0			; DATA XREF: start+7Dw
					; start:loc_101A5w ...
; --- STSSP.ENV	data end ---		; 0 = floppy, 1	= hard disk
		align 2
textDrawPtr	dw 0			; DATA XREF: DrawText+13w
					; DrawTextChar+8r ...
drawColX	dw 0			; DATA XREF: start:loc_102B6w
					; start+1D1w ...
drawRowY	dw 0			; DATA XREF: start+1BCw start+1D7w ...
drawWidth	dw 0			; DATA XREF: start+1C2w start+39Dw ...
drawHeight	dw 0			; DATA XREF: start+1C8w start+3A3w ...
txtColorMain	db 0			; DATA XREF: start+1DDw start+1F9w ...
txtColorShdw	db 0			; DATA XREF: start+1E2w start+1FEw ...
txtFontCache	db 20h dup(0)		; DATA XREF: DrawTextChar+30o
word_10EBE	dw 0			; DATA XREF: LoadColour_LCD+7w
					; LoadColour_LCD+16r
word_10EC0	dw 0			; DATA XREF: LoadColour_LCD+Dw
					; LoadColour_LCD+26r ...
word_10EC2	dw 0			; DATA XREF: LoadColour_LCD+13w
OldIntVec05	dd 0			; DATA XREF: SetupIntVec05+10w
					; RestoreIntVec05+Cr ...
OldIntVec06	dd 0			; DATA XREF: SetupIntVec06+10w
					; RestoreIntVec06+Cr ...
PaletteDataRGB	db    0,   0,	0	; DATA XREF: start+B4o	start+4D2o ...
		db  0Fh, 0Fh, 0Fh
		db  0Ah, 0Ah, 0Fh
		db    6,   4, 0Bh
		db  0Fh, 0Fh,	7
		db  0Ah,   9,	4
		db    7,   5,	2
		db    0,   7,	3
		db  0Eh,   3,	4
		db    8,   0,	0
		db  0Fh,   7, 0Bh
		db    9,   4,	9
		db    6,   6,	6
		db    9,   9,	9
		db  0Ah,   7,	6
		db  0Fh, 0Bh, 0Ah
TextBoxBrd_UL	db 0, 0, 14h, 0, 30h, 0, 7, 0FFh, 2Ch, 0, 0Ah, 0FFh, 8
					; DATA XREF: DrawTextBox+1Bo
		db 55h,	0Bh, 0FFh, 9, 55h, 0Bh,	0FFh, 9, 55h, 0Bh, 0FFh
		db 9, 55h, 0Bh,	0FFh, 9, 55h, 0Bh, 0FFh, 14h, 0, 2Ah, 0
		db 4Fh,	0FFh, 30h, 0, 53h, 0FFh, 35h, 0FFh, 17h, 55h, 17h
		db 0FFh, 15h, 55h, 17h,	0FFh, 15h, 55h,	17h, 0FFh, 15h
		db 55h,	17h, 0FFh, 15h,	55h, 17h, 0FFh,	14h, 0,	3Eh, 0
		db 7Fh,	0FFh, 3Fh, 0FFh, 7Bh, 0FFh, 3Fh, 0, 1Fh, 0, 1Ch
		db 0, 1Ch, 0, 1Ch, 0, 1Ch, 0, 1Ch, 0, 1Ch, 0, 1Ch, 0, 1Ch
		db 0, 1Ch, 0
TextBoxBrd_UM	db 0, 0, 0, 0, 0, 0, 0FFh, 0FFh, 0, 0, 0FFh, 0FFh, 55h
					; DATA XREF: DrawTextBox+21o
		db 55h,	0FFh, 0FFh, 55h, 55h, 0FFh, 0FFh, 55h, 55h, 0FFh
		db 0FFh, 55h, 55h, 0FFh, 0FFh, 55h, 55h, 0FFh, 0FFh, 0
		db 0, 0, 0, 0FFh, 0FFh,	0, 0, 0FFh, 0FFh, 0FFh,	0FFh, 55h
		db 55h,	0FFh, 0FFh, 55h, 55h, 0FFh, 0FFh, 55h, 55h, 0FFh
		db 0FFh, 55h, 55h, 0FFh, 0FFh, 55h, 55h, 0FFh, 0FFh, 0
		db 0, 0, 0, 0FFh, 0FFh,	0FFh, 0FFh, 0FFh, 0FFh,	0, 0, 0
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0
		db 0
TextBoxBrd_UR	db 0, 0, 0, 28h, 0, 0Ch, 0FFh, 0E0h, 0,	34h, 0FFh, 50h
					; DATA XREF: DrawTextBox+2Do
		db 55h,	10h, 0FFh, 0D0h, 55h, 50h, 0FFh, 0D0h, 55h, 50h
		db 0FFh, 0D0h, 55h, 50h, 0FFh, 0D0h, 55h, 50h, 0FFh, 0D0h
		db 0, 28h, 0, 54h, 0FFh, 0F2h, 0, 0Ch, 0FFh, 0CAh, 0FFh
		db 0ACh, 55h, 0E8h, 0FFh, 0E8h,	55h, 68h, 0FFh,	0E8h, 55h
		db 68h,	0FFh, 0E8h, 55h, 68h, 0FFh, 0E8h, 55h, 68h, 0FFh
		db 0E8h, 0, 28h, 0, 7Ch, 0FFh, 0FEh, 0FFh, 0FCh, 0FFh
		db 0DEh, 0, 0FCh, 0, 0F8h, 0, 38h, 0, 38h, 0, 38h, 0, 38h
		db 0, 38h, 0, 38h, 0, 38h, 0, 38h, 0, 38h
TextBoxBrd_ML	db 9, 55h, 0Bh,	0FFh, 9, 55h, 0Bh, 0FFh, 9, 55h, 0Bh, 0FFh
					; DATA XREF: DrawTextBox+3Eo
		db 9, 55h, 0Bh,	0FFh, 9, 55h, 0Bh, 0FFh, 9, 55h, 0Bh, 0FFh
		db 9, 55h, 0Bh,	0FFh, 9, 55h, 0Bh, 0FFh, 15h, 55h, 17h
		db 0FFh, 15h, 55h, 17h,	0FFh, 15h, 55h,	17h, 0FFh, 15h
		db 55h,	17h, 0FFh, 15h,	55h, 17h, 0FFh,	15h, 55h, 17h
		db 0FFh, 15h, 55h, 17h,	0FFh, 15h, 55h,	17h, 0FFh, 1Ch
		db 0, 1Ch, 0, 1Ch, 0, 1Ch, 0, 1Ch, 0, 1Ch, 0, 1Ch, 0, 1Ch
		db 0, 1Ch, 0, 1Ch, 0, 1Ch, 0, 1Ch, 0, 1Ch, 0, 1Ch, 0, 1Ch
		db 0, 1Ch, 0
TextBoxBG	db 55h,	55h, 0FFh, 0FFh, 55h, 55h, 0FFh, 0FFh, 55h, 55h
					; DATA XREF: DrawTextBox+44o
		db 0FFh, 0FFh, 55h, 55h, 0FFh, 0FFh, 55h, 55h, 0FFh, 0FFh
		db 55h,	55h, 0FFh, 0FFh, 55h, 55h, 0FFh, 0FFh, 55h, 55h
		db 0FFh, 0FFh, 55h, 55h, 0FFh, 0FFh, 55h, 55h, 0FFh, 0FFh
		db 55h,	55h, 0FFh, 0FFh, 55h, 55h, 0FFh, 0FFh, 55h, 55h
		db 0FFh, 0FFh, 55h, 55h, 0FFh, 0FFh, 55h, 55h, 0FFh, 0FFh
		db 55h,	55h, 0FFh, 0FFh, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0
		db 0, 0, 0, 0
TextBoxBrd_MR	db 55h,	50h, 0FFh, 0D0h, 55h, 50h, 0FFh, 0D0h, 55h, 50h
					; DATA XREF: DrawTextBox+50o
		db 0FFh, 0D0h, 55h, 50h, 0FFh, 0D0h, 55h, 50h, 0FFh, 0D0h
		db 55h,	50h, 0FFh, 0D0h, 55h, 50h, 0FFh, 0D0h, 55h, 50h
		db 0FFh, 0D0h, 55h, 68h, 0FFh, 0E8h, 55h, 68h, 0FFh, 0E8h
		db 55h,	68h, 0FFh, 0E8h, 55h, 68h, 0FFh, 0E8h, 55h, 68h
		db 0FFh, 0E8h, 55h, 68h, 0FFh, 0E8h, 55h, 68h, 0FFh, 0E8h
		db 55h,	68h, 0FFh, 0E8h, 0, 38h, 0, 38h, 0, 38h, 0, 38h
		db 0, 38h, 0, 38h, 0, 38h, 0, 38h, 0, 38h, 0, 38h, 0, 38h
		db 0, 38h, 0, 38h, 0, 38h, 0, 38h, 0, 38h
TextBoxBrd_LL	db 9, 55h, 0Bh,	0FFh, 9, 55h, 0Bh, 0FFh, 9, 55h, 0Bh, 0FFh
					; DATA XREF: DrawTextBox+76o
		db 9, 55h, 0Bh,	0FFh, 8, 55h, 0Ah, 0FFh, 2Ch, 0, 7, 0FFh
		db 30h,	0, 14h,	0, 0, 0, 0, 0, 15h, 55h, 17h, 0FFh, 15h
		db 55h,	17h, 0FFh, 15h,	55h, 17h, 0FFh,	15h, 55h, 17h
		db 0FFh, 17h, 55h, 35h,	0FFh, 53h, 0FFh, 30h, 0, 4Fh, 0FFh
		db 2Ah,	0, 14h,	0, 0, 0, 1Ch, 0, 1Ch, 0, 1Ch, 0, 1Ch, 0
		db 1Ch,	0, 1Ch,	0, 1Ch,	0, 1Ch,	0, 1Fh,	0, 3Fh,	0, 7Bh
		db 0FFh, 3Fh, 0FFh, 7Fh, 0FFh, 3Eh, 0, 14h, 0, 0, 0
TextBoxBrd_LM	db 55h,	55h, 0FFh, 0FFh, 55h, 55h, 0FFh, 0FFh, 55h, 55h
					; DATA XREF: DrawTextBox+7Co
		db 0FFh, 0FFh, 55h, 55h, 0FFh, 0FFh, 55h, 55h, 0FFh, 0FFh
		db 0, 0, 0FFh, 0FFh, 0,	0, 0, 0, 0, 0, 0, 0, 55h, 55h
		db 0FFh, 0FFh, 55h, 55h, 0FFh, 0FFh, 55h, 55h, 0FFh, 0FFh
		db 55h,	55h, 0FFh, 0FFh, 55h, 55h, 0FFh, 0FFh, 0FFh, 0FFh
		db 0, 0, 0FFh, 0FFh, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0FFh, 0FFh
		db 0FFh, 0FFh, 0FFh, 0FFh, 0, 0, 0, 0, 0, 0
TextBoxBrd_LR	db 55h,	50h, 0FFh, 0D0h, 55h, 50h, 0FFh, 0D0h, 55h, 50h
					; DATA XREF: DrawTextBox+88o
		db 0FFh, 0D0h, 55h, 50h, 0FFh, 0D0h, 55h, 10h, 0FFh, 50h
		db 0, 34h, 0FFh, 0E0h, 0, 0Ch, 0, 28h, 0, 0, 0,	0, 55h
		db 68h,	0FFh, 0E8h, 55h, 68h, 0FFh, 0E8h, 55h, 68h, 0FFh
		db 0E8h, 55h, 68h, 0FFh, 0E8h, 55h, 0E8h, 0FFh,	0ACh, 0FFh
		db 0CAh, 0, 0Ch, 0FFh, 0F2h, 0,	54h, 0,	28h, 0,	0, 0, 38h
		db 0, 38h, 0, 38h, 0, 38h, 0, 38h, 0, 38h, 0, 38h, 0, 38h
		db 0, 0F8h, 0, 0FCh, 0FFh, 0DEh, 0FFh, 0FCh, 0FFh, 0FEh
		db 0, 7Ch, 0, 28h, 0, 0
GreetingText	db 'Studio Twin',27h,'kle System Startup Program ',27h,'STSSP.COM',27h,' ver.0'
					; DATA XREF: start+6E8o start+77Fo
		db '.9k  For •‘–²',0Dh,0Ah
		db 'Programmed by TAKAHIRO NOGI.(NOGICHAN) 1995/08/10',0Dh,0Ah
		db 0Dh,0Ah,'$'
QuitText_Floppy	db 1Bh,'[7;36m‚¨”æ‚ê—l‚Å‚µ‚½. ƒfƒBƒXƒN‚ğ”²‚¢‚Ä‚©‚ç“dŒ¹‚ğØ‚Á‚Ä‚­‚¾‚³‚¢.',1Bh
					; DATA XREF: start:loc_1082Ao
		db '[m',0Dh,0Ah,'$'     ; Thank you for playing. Please remove the disk before you turn off your machine.
QuitText_HDD	db 1Bh,'[7;36m‚¨”æ‚ê—l‚Å‚µ‚½.',1Bh,'[m',0Dh,0Ah,'$' ; DATA XREF: start+6FBo
					; Thank	you for	playing.
FileNameList	dw offset aPmd_com_0	; 0 ; DATA XREF: start+79Ao
		dw offset aMmd_com	; 1 ; "PMD.COM$"
		dw offset aStmd_com	; 2
		dw offset aMime_se_efc	; 3
		dw offset aGs_reset_n	; 4
		dw offset aMime_op_exe	; 5
		dw offset aMime_exe	; 6
		dw offset Err_WriteEnv	; 7
		dw offset Err_CantOperate; 8
aPmd_com_0	db 'PMD.COM$'           ; DATA XREF: seg000:FileNameListo
aMmd_com	db 'MMD.COM$'           ; DATA XREF: seg000:FileNameListo
aStmd_com	db 'STMD.COM$'          ; DATA XREF: seg000:FileNameListo
aMime_se_efc	db 'MIME_SE.EFC$'       ; DATA XREF: seg000:FileNameListo
aGs_reset_n	db 'GS_RESET.N$'        ; DATA XREF: seg000:FileNameListo
aMime_op_exe	db 'MIME_OP.EXE$'       ; DATA XREF: seg000:FileNameListo
aMime_exe	db 'MIME.EXE$'          ; DATA XREF: seg000:FileNameListo
Err_WriteEnv	db 'STSSP.ENV ‚ª‘‚«‚İo—ˆ‚Ü‚¹‚ñ$' ; DATA XREF: start:loc_108AEo
					; seg000:FileNameListo
					; Unable to write STSSP.ENV.
Err_CantOperate	db '‚±‚ÌŠÂ‹«‚Å‚Í“®ìo—ˆ‚Ü‚¹‚ñ$' ; DATA XREF: start:loc_108B7o
					; seg000:FileNameListo
					; It cannot operate in this environment.
Err_NotFound	db ' ‚ªŒ©‚Â‚©‚è‚Ü‚¹‚ñ$' ; DATA XREF: start+7A5o
					; " not	found."
Err_PleaseReset	db 0Dh,0Ah		; DATA XREF: start:loc_108F0o
		db '•œ‹Ao—ˆ‚Ü‚¹‚ñ. ƒŠƒZƒbƒg‚µ‚Ä‚­‚¾‚³‚¢.',0Dh,0Ah,'$' ; Cannot recover. Please reset.
a5731m		db 1Bh,'[5;7;31m$'      ; DATA XREF: start+786o
aExclamation	db 'I',1Bh,'[m',0Dh,0Ah,'$' ; DATA XREF: start:loc_108BEo
					; "!\x1B[m\r\n"
a0m1h5h		db 1Bh,'[0m',1Bh,'[>1h',1Bh,'[>5h',1Bh,'*$' ; DATA XREF: start+62o
					; start+628o ...
aNewLine	db 0Dh,0Ah,'$'          ; DATA XREF: start:loc_101CDo
					; start:loc_101E7o ...
a1l5l		db 1Bh,'[>1l',1Bh,'[>5l$' ; DATA XREF: start+702o start+731o ...
aSoundMode	db '¡@‰¹Œ¹ƒ‚[ƒh‘I‘ğ@¡',0 ; DATA XREF: start+1E7o
					; Select Sound Mode
aSound_FM	db '‚e‚l‰¹Œ¹',0         ; DATA XREF: start+203o start+2C9o ...
					; FM sound source
aSound_MIDI	db '‚l‚h‚c‚h‰¹Œ¹',0     ; DATA XREF: start+21Fo start+2E5o ...
					; MIDI sound source
aDispMode	db '¡@ƒfƒBƒXƒvƒŒƒCƒ‚[ƒh‘I‘ğ@¡',0 ; DATA XREF: start+3C2o
					; Select Display Mode
aDisp_Analog	db 'ƒAƒiƒƒOƒfƒBƒXƒvƒŒƒC',0 ; DATA XREF: start+3DEo start+4ABo ...
					; Analog Display
aDisp_LCD	db '‰t»ƒfƒBƒXƒvƒŒƒC',0 ; DATA XREF: start+3FAo start+4C7o ...
					; LCD display
aMidiInit	db '¡@‚l‚h‚c‚h‰¹Œ¹‰Šú‰»’†@¡',0 ; DATA XREF: start+5B9o
seg000		ends			; MIDI Initialization in progress


		end start
