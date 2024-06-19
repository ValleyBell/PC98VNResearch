; Input	MD5   :	0125F42A56F1EDA7242C1DB081BF46A3
; Input	CRC32 :	EC227C8D

; File Name   :	D:\MIME_OP.EXE
; Format      :	MS-DOS executable (EXE)
; Base Address:	1000h Range: 10000h-19A50h Loaded length: 8250h
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


		public start
start		proc near
		cld
		mov	cs:byte_16CEE, 0
		mov	ss:byte_18250+0AFh, 0
		mov	si, 80h
		inc	si

loc_10011:				; CODE XREF: start+14j
		lodsb
		cmp	al, ' '
		jz	short loc_10011
		cmp	al, '/'
		jz	short loc_1001E
		cmp	al, '-'
		jnz	short loc_10039

loc_1001E:				; CODE XREF: start+18j
		lodsb
		and	al, not	20h
		cmp	al, 'F'
		jz	short loc_1002B
		cmp	al, 'H'
		jz	short loc_10033
		jmp	short loc_10039
; ---------------------------------------------------------------------------

loc_1002B:				; CODE XREF: start+23j
		mov	cs:byte_16CEE, 0
		jmp	short loc_10039
; ---------------------------------------------------------------------------

loc_10033:				; CODE XREF: start+27j
		mov	cs:byte_16CEE, 1

loc_10039:				; CODE XREF: start+1Cj	start+29j ...
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		mov	dx, offset aAStssp_env ; "A:STSSP.ENV"
		call	fopen1_r
		jnb	short loc_10049
		jmp	ErrExit_fopen
; ---------------------------------------------------------------------------

loc_10049:				; CODE XREF: start+44j
		mov	dx, offset unk_178FE
		mov	cx, 5
		call	fread1
		jnb	short loc_10057
		jmp	ErrExit_fopen
; ---------------------------------------------------------------------------

loc_10057:				; CODE XREF: start+52j
		call	fclose1
		pushf
		pop	ax
		pushf
		or	ax, 4000h
		push	ax
		popf
		pushf
		pop	ax
		popf
		and	ax, 0C000h
		cmp	ax, 4000h
		jnz	short loc_10074
		mov	byte_1757E, 1
		jmp	short loc_10079
; ---------------------------------------------------------------------------

loc_10074:				; CODE XREF: start+6Bj
		mov	byte_1757E, 0

loc_10079:				; CODE XREF: start+72j
		push	es
		xor	ax, ax
		mov	es, ax
		assume es:nothing
		mov	al, es:54Ch
		and	al, 20h
		shr	al, 5
		mov	byte_17920, al
		pop	es
		assume es:nothing
		call	sub_16B10
		call	sub_167D7
		mov	al, 0
		out	76h, al
		mov	ah, 51h
		int	21h		; DOS -	2+ internal - GET PSP SEGMENT
					; Return: BX = current PSP segment
		mov	word_1757A, bx
		mov	ax, word_1757A
		mov	es, ax
		mov	bx, 0A00h
		inc	bx
		mov	ah, 4Ah
		int	21h		; DOS -	2+ - ADJUST MEMORY BLOCK SIZE (SETBLOCK)
					; ES = segment address of block	to change
					; BX = new size	in paragraphs
		mov	bx, 6000h
		shr	bx, 4
		inc	bx
		mov	ah, 48h
		int	21h		; DOS -	2+ - ALLOCATE MEMORY
					; BX = number of 16-byte paragraphs desired
		jnb	short loc_100BA
		jmp	ErrExit_malloc
; ---------------------------------------------------------------------------

loc_100BA:				; CODE XREF: start+B5j
		mov	word_17938, ax
		mov	si, 0
		mov	cx, 8000h
		call	DoSomeMalloc
		jnb	short loc_100CB
		jmp	ErrExit_malloc
; ---------------------------------------------------------------------------

loc_100CB:				; CODE XREF: start+C6j
		mov	si, 1
		mov	cx, 8000h
		call	DoSomeMalloc
		jnb	short loc_100D9
		jmp	ErrExit_malloc
; ---------------------------------------------------------------------------

loc_100D9:				; CODE XREF: start+D4j
		mov	si, 2
		mov	cx, 8000h
		call	DoSomeMalloc
		jnb	short loc_100E7
		jmp	ErrExit_malloc
; ---------------------------------------------------------------------------

loc_100E7:				; CODE XREF: start+E2j
		mov	bx, 0FFFFh
		mov	ah, 48h
		int	21h		; DOS -	2+ - ALLOCATE MEMORY
					; BX = number of 16-byte paragraphs desired
		jb	short loc_100F3
		jmp	loc_1689C
; ---------------------------------------------------------------------------

loc_100F3:				; CODE XREF: start+EEj
		mov	word_1757C, bx
		mov	byte_17932, 0
		mov	byte_17924, 0
		mov	byte_1793E, 0
		mov	byte_1790D, 0
		call	SetupInts

loc_1010E:				; CODE XREF: start+5F9Ej
		call	WaitForVSync
		call	WaitForVSync
		call	WaitForVSync
		call	WaitForVSync
		call	WaitForVSync
		call	WaitForVSync
		call	WaitForVSync
		call	WaitForVSync
		call	WaitForVSync
		call	WaitForVSync
		mov	CurFrameID, 0
		mov	FrameCounter, 0
		mov	word_17912, 0
		mov	byte_1758A, 0
		mov	byte_1758B, 0
		mov	byte_17924, 0
		mov	byte_17932, 0
		call	DoBlackPalette
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		call	ClearPlane
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		call	ClearPlane
		mov	byte_17922, 2

loc_10168:				; CODE XREF: start+16Dj
		cmp	byte_17922, 0
		jnz	short loc_10168
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	dx, 0FFFFh
		call	sub_168A3
		mov	ax, 0FFFFh
		mov	si, offset aBOp_01a_gta	; "B:OP_01A.GTA"
		mov	word_1793A, 0
		mov	word_1793C, 0
		call	LoadGTA
		jnb	short loc_10193
		jmp	ErrExit_fopen
; ---------------------------------------------------------------------------

loc_10193:				; CODE XREF: start+18Ej
		mov	PaletteID, 0
		call	CopyPalette
		mov	PaletteID, 0
		mov	PalFadeStart, 0
		mov	byte_1793F, 0
		mov	byte_1793E, 1
		call	WaitForVSync
		mov	byte_17922, 1

loc_101B8:				; CODE XREF: start+1BDj
		cmp	byte_17922, 0
		jnz	short loc_101B8
		mov	FrameCounter, 0
		mov	FramesToWait, 10
		call	WaitFrames
		mov	PaletteID, 0
		mov	PalFadeStart, 0	; start	fading in Studio Twin'kle logo
		mov	PalFadeEnd, 100
		mov	PalFadeInc, 1
		mov	PalFade_StepDelay, 1
		mov	byte_1793F, 1
		mov	byte_1793E, 1
		mov	FrameCounter, 0
		mov	FramesToWait, 250
		call	WaitFrames
		mov	PaletteID, 0
		mov	PalFadeStart, 100 ; start fading out Studio Twin'kle logo
		mov	PalFadeEnd, 0
		mov	PalFadeInc, 1
		mov	PalFade_StepDelay, 1
		mov	byte_1793F, 1
		mov	byte_1793E, 1
		mov	FrameCounter, 0
		mov	FramesToWait, 120
		call	WaitFrames
		mov	byte_1758A, 0
		mov	byte_1758B, 0
		push	es
		mov	ax, 0A000h
		mov	es, ax
		assume es:nothing
		xor	di, di
		mov	cx, 820h
		xor	ah, ah
		mov	al, 0
		rep stosw
		mov	ax, 0A200h
		mov	es, ax
		assume es:nothing
		xor	di, di
		mov	cx, 820h
		xor	ah, ah
		cmp	byte_17901, 1
		jz	short loc_1026C
		mov	al, 5
		jmp	short loc_1026E
; ---------------------------------------------------------------------------

loc_1026C:				; CODE XREF: start+266j
		mov	al, 0E5h

loc_1026E:				; CODE XREF: start+26Aj
		rep stosw
		pop	es
		assume es:nothing
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		call	ClearPlane
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		call	ClearPlane
		mov	byte_17922, 1

loc_10284:				; CODE XREF: start+289j
		cmp	byte_17922, 0
		jnz	short loc_10284
		mov	dx, 0
		call	sub_168A3
		mov	ax, 0FFFFh
		mov	si, offset aBOp_01d_gta	; "B:OP_01D.GTA"
		mov	word_1793A, 0
		mov	word_1793C, 0
		call	LoadGTA
		jnb	short loc_102AB
		jmp	ErrExit_fopen
; ---------------------------------------------------------------------------

loc_102AB:				; CODE XREF: start+2A6j
		mov	PaletteID, 4
		call	CopyPalette
		mov	dx, 0
		call	sub_168A3
		mov	ax, 0FFFFh
		mov	si, offset aBOp_01e_gta	; "B:OP_01E.GTA"
		mov	word_1793A, 320
		mov	word_1793C, 0
		call	LoadGTA
		jnb	short loc_102D3
		jmp	ErrExit_fopen
; ---------------------------------------------------------------------------

loc_102D3:				; CODE XREF: start+2CEj
		mov	PaletteID, 5
		call	CopyPalette
		mov	dx, 0
		call	sub_168A3
		mov	ax, 0FFFFh
		mov	si, offset aBOp_01f_gta	; "B:OP_01F.GTA"
		mov	word_1793A, 0
		mov	word_1793C, 200
		call	LoadGTA
		jnb	short loc_102FB
		jmp	ErrExit_fopen
; ---------------------------------------------------------------------------

loc_102FB:				; CODE XREF: start+2F6j
		mov	PaletteID, 6
		call	CopyPalette
		mov	dx, 0
		call	sub_168A3
		mov	ax, 0FFFFh
		mov	si, offset aBOp_01g_gta	; "B:OP_01G.GTA"
		mov	word_1793A, 320
		mov	word_1793C, 200
		call	LoadGTA
		jnb	short loc_10323
		jmp	ErrExit_fopen
; ---------------------------------------------------------------------------

loc_10323:				; CODE XREF: start+31Ej
		mov	PaletteID, 7
		call	CopyPalette
		mov	dx, 1
		call	sub_168A3
		mov	ax, 0FFFFh
		mov	si, offset aBOp_01h_gta	; "B:OP_01H.GTA"
		mov	word_1793A, 0
		mov	word_1793C, 0
		call	LoadGTA
		jnb	short loc_1034B
		jmp	ErrExit_fopen
; ---------------------------------------------------------------------------

loc_1034B:				; CODE XREF: start+346j
		mov	PaletteID, 8
		call	CopyPalette
		mov	dx, 2
		call	sub_168A3
		mov	ax, 0FFFFh
		mov	si, offset aBOp_01i_gta	; "B:OP_01I.GTA"
		mov	word_1793A, 0
		mov	word_1793C, 0
		call	LoadGTA
		jnb	short loc_10373
		jmp	ErrExit_fopen
; ---------------------------------------------------------------------------

loc_10373:				; CODE XREF: start+36Ej
		mov	PaletteID, 1
		call	CopyPalette
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	dx, 0FFFFh
		call	sub_168A3
		mov	ax, 0FFFFh
		mov	si, offset aBOp_01b_gta	; "B:OP_01B.GTA"
		mov	word_1793A, 0
		mov	word_1793C, 0
		call	LoadGTA
		jnb	short loc_1039F
		jmp	ErrExit_fopen
; ---------------------------------------------------------------------------

loc_1039F:				; CODE XREF: start+39Aj
		mov	PaletteID, 2
		call	CopyPalette
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	dx, 0FFFFh
		call	sub_168A3
		mov	ax, 0FFFFh
		mov	si, offset aBOp_01c_gta	; "B:OP_01C.GTA"
		mov	word_1793A, 0
		mov	word_1793C, 0
		call	LoadGTA
		jnb	short loc_103CB
		jmp	ErrExit_fopen
; ---------------------------------------------------------------------------

loc_103CB:				; CODE XREF: start+3C6j
		mov	PaletteID, 3
		call	CopyPalette
		call	WaitForVSync
		call	WaitForVSync
		call	WaitForVSync
		call	WaitForVSync
		call	WaitForVSync
		call	WaitForVSync
		call	WaitForVSync
		call	WaitForVSync
		call	WaitForVSync
		call	WaitForVSync
		mov	CurFrameID, 0
		mov	FrameCounter, 0
		mov	bl, 0
		call	PlayBGM		; play music OP_1
		jnb	short loc_10407
		jmp	ErrExit_fopen
; ---------------------------------------------------------------------------

loc_10407:				; CODE XREF: start+402j
		mov	PaletteID, 2
		mov	PalFadeStart, 100
		mov	byte_1793F, 0
		mov	byte_1793E, 1
		call	WaitForVSync
		mov	DestFrmWaitTick, 23h
		mov	DestFMWaitTick,	23h
		mov	DestMIDWaitTick, 0BDh
		call	WaitForMusic1
		jnb	short loc_10446
		cmp	ax, 1
		jnz	short loc_1043E
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_1043E:				; CODE XREF: start+439j
		cmp	ax, 2
		jnz	short loc_10446
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_10446:				; CODE XREF: start+434j start+441j
		mov	byte_17925, 0
		mov	ax, 0Ch
		shl	ax, 1
		mov	bx, 4
		imul	di, bx,	0A0h
		add	di, ax
		mov	word_17936, di
		mov	word_17928, 60
		mov	byte_17924, 1
		mov	DestFrmWaitTick, 223h
		mov	DestFMWaitTick,	0E3h
		mov	DestMIDWaitTick, 17Dh
		call	WaitForMusic1
		jnb	short loc_1048F
		cmp	ax, 1
		jnz	short loc_10487
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_10487:				; CODE XREF: start+482j
		cmp	ax, 2
		jnz	short loc_1048F
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_1048F:				; CODE XREF: start+47Dj start+48Aj
		mov	byte_17925, 0
		mov	ax, 0Ah
		shl	ax, 1
		mov	bx, 9
		imul	di, bx,	0A0h
		add	di, ax
		mov	word_17936, di
		mov	word_17928, 41h	; 'A'
		mov	byte_17924, 1
		mov	DestFrmWaitTick, 4A3h
		mov	DestFMWaitTick,	263h
		mov	DestMIDWaitTick, 2FDh
		call	WaitForMusic1
		jnb	short loc_104D8
		cmp	ax, 1
		jnz	short loc_104D0
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_104D0:				; CODE XREF: start+4CBj
		cmp	ax, 2
		jnz	short loc_104D8
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_104D8:				; CODE XREF: start+4C6j start+4D3j
		mov	byte_17925, 1
		mov	ax, 14h
		shl	ax, 1
		mov	bx, 0Dh
		imul	di, bx,	0A0h
		add	di, ax
		mov	word_17936, di
		mov	word_17928, 2Dh	; '-'
		mov	byte_17924, 1
		mov	DestFrmWaitTick, 723h
		mov	DestFMWaitTick,	323h
		mov	DestMIDWaitTick, 3C0h
		call	WaitForMusic1
		jnb	short loc_10521
		cmp	ax, 1
		jnz	short loc_10519
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_10519:				; CODE XREF: start+514j
		cmp	ax, 2
		jnz	short loc_10521
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_10521:				; CODE XREF: start+50Fj start+51Cj
		mov	PaletteID, 2
		mov	PalFadeStart, 100
		mov	PalFadeEnd, 0
		mov	PalFadeInc, 1
		mov	PalFade_StepDelay, 2
		mov	byte_1793F, 1
		mov	byte_1793E, 1
		mov	DestFrmWaitTick, 81Dh
		mov	DestFMWaitTick,	3ABh
		mov	DestMIDWaitTick, 439h
		call	WaitForMusic1
		jnb	short loc_1056F
		cmp	ax, 1
		jnz	short loc_10567
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_10567:				; CODE XREF: start+562j
		cmp	ax, 2
		jnz	short loc_1056F
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_1056F:				; CODE XREF: start+55Dj start+56Aj
		mov	byte_17924, 0
		push	es
		mov	ax, 0A000h
		mov	es, ax
		assume es:nothing
		xor	di, di
		mov	cx, 820h
		xor	ah, ah
		mov	al, 0
		rep stosw
		mov	ax, 0A200h
		mov	es, ax
		assume es:nothing
		xor	di, di
		mov	cx, 820h
		xor	ah, ah
		cmp	byte_17901, 1
		jz	short loc_1059C
		mov	al, 0E1h ; 'á'
		jmp	short loc_1059E
; ---------------------------------------------------------------------------

loc_1059C:				; CODE XREF: start+596j
		mov	al, 1

loc_1059E:				; CODE XREF: start+59Aj
		rep stosw
		pop	es
		assume es:nothing
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		call	ClearPlane
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	byte_17922, 2

loc_105B1:				; CODE XREF: start+5B6j
		cmp	byte_17922, 0
		jnz	short loc_105B1
		mov	si, offset OpeningText ; "//"
		mov	DispTextPtr, si
		mov	byte_17932, 1
		mov	DestFrmWaitTick, 0C78h
		mov	DestFMWaitTick,	619h
		mov	DestMIDWaitTick, 6BAh
		call	WaitForMusic1
		jnb	short loc_105EB
		cmp	ax, 1
		jnz	short loc_105E3
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_105E3:				; CODE XREF: start+5DEj
		cmp	ax, 2
		jnz	short loc_105EB
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_105EB:				; CODE XREF: start+5D9j start+5E6j
		mov	PaletteID, 3
		mov	PalFadeStart, 0
		mov	PalFadeEnd, 100
		mov	PalFadeInc, 3
		mov	PalFade_StepDelay, 2
		mov	byte_1793F, 1
		mov	byte_1793E, 1
		mov	DestFrmWaitTick, 119Fh
		mov	DestFMWaitTick,	923h
		mov	DestMIDWaitTick, 9C0h
		call	WaitForMusic1
		jnb	short loc_10639
		cmp	ax, 1
		jnz	short loc_10631
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_10631:				; CODE XREF: start+62Cj
		cmp	ax, 2
		jnz	short loc_10639
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_10639:				; CODE XREF: start+627j start+634j
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 0
		mov	dx, 1F54h
		mov	cx, 0C8h ; 'È'
		mov	cs:word_16D90, bx
		mov	cs:word_16D92, dx
		mov	cs:word_16D98, 28h ; '('
		mov	cs:word_16D9A, cx
		dec	cx
		imul	cx, 50h
		add	bx, cx
		add	dx, cx
		mov	cs:word_16D94, bx
		mov	cs:word_16D96, dx
		mov	cs:byte_16D9C, 1

loc_10679:				; CODE XREF: start+67Fj
		cmp	cs:byte_16D9C, 0FFh
		jnz	short loc_10679
		mov	PaletteID, 5
		mov	PalFadeStart, 100
		mov	byte_1793F, 0
		mov	byte_1793E, 1
		call	WaitForVSync
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 28h	; '('
		mov	dx, 1F54h
		mov	cx, 0C8h ; 'È'
		mov	cs:word_16D90, bx
		mov	cs:word_16D92, dx
		mov	cs:word_16D98, 28h ; '('
		mov	cs:word_16D9A, cx
		dec	cx
		imul	cx, 50h
		add	bx, cx
		add	dx, cx
		mov	cs:word_16D94, bx
		mov	cs:word_16D96, dx
		mov	cs:byte_16D9C, 1

loc_106D9:				; CODE XREF: start+6DFj
		cmp	cs:byte_16D9C, 0FFh
		jnz	short loc_106D9
		mov	DestFrmWaitTick, 1AF9h
		mov	DestFMWaitTick,	0E03h
		mov	DestMIDWaitTick, 0EA0h
		call	WaitForMusic1
		jnb	short loc_10708
		cmp	ax, 1
		jnz	short loc_10700
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_10700:				; CODE XREF: start+6FBj
		cmp	ax, 2
		jnz	short loc_10708
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_10708:				; CODE XREF: start+6F6j start+703j
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 0
		mov	dx, 1F54h
		mov	cx, 0C8h ; 'È'
		mov	cs:word_16D90, bx
		mov	cs:word_16D92, dx
		mov	cs:word_16D98, 28h ; '('
		mov	cs:word_16D9A, cx
		dec	cx
		imul	cx, 50h
		add	bx, cx
		add	dx, cx
		mov	cs:word_16D94, bx
		mov	cs:word_16D96, dx
		mov	cs:byte_16D9C, 1

loc_10748:				; CODE XREF: start+74Ej
		cmp	cs:byte_16D9C, 0FFh
		jnz	short loc_10748
		mov	PaletteID, 6
		mov	PalFadeStart, 100
		mov	byte_1793F, 0
		mov	byte_1793E, 1
		call	WaitForVSync
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 3E80h
		mov	dx, 1F54h
		mov	cx, 0C8h ; 'È'
		mov	cs:word_16D90, bx
		mov	cs:word_16D92, dx
		mov	cs:word_16D98, 28h ; '('
		mov	cs:word_16D9A, cx
		dec	cx
		imul	cx, 50h
		add	bx, cx
		add	dx, cx
		mov	cs:word_16D94, bx
		mov	cs:word_16D96, dx
		mov	cs:byte_16D9C, 1

loc_107A8:				; CODE XREF: start+7AEj
		cmp	cs:byte_16D9C, 0FFh
		jnz	short loc_107A8
		mov	DestFrmWaitTick, 1FDFh
		mov	DestFMWaitTick,	11C3h
		mov	DestMIDWaitTick, 1260h
		call	WaitForMusic1
		jnb	short loc_107D7
		cmp	ax, 1
		jnz	short loc_107CF
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_107CF:				; CODE XREF: start+7CAj
		cmp	ax, 2
		jnz	short loc_107D7
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_107D7:				; CODE XREF: start+7C5j start+7D2j
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 0
		mov	dx, 1F54h
		mov	cx, 0C8h ; 'È'
		mov	cs:word_16D90, bx
		mov	cs:word_16D92, dx
		mov	cs:word_16D98, 28h ; '('
		mov	cs:word_16D9A, cx
		dec	cx
		imul	cx, 50h
		add	bx, cx
		add	dx, cx
		mov	cs:word_16D94, bx
		mov	cs:word_16D96, dx
		mov	cs:byte_16D9C, 1

loc_10817:				; CODE XREF: start+81Dj
		cmp	cs:byte_16D9C, 0FFh
		jnz	short loc_10817
		mov	PaletteID, 7
		mov	PalFadeStart, 100
		mov	byte_1793F, 0
		mov	byte_1793E, 1
		call	WaitForVSync
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 3EA8h
		mov	dx, 1F54h
		mov	cx, 0C8h ; 'È'
		mov	cs:word_16D90, bx
		mov	cs:word_16D92, dx
		mov	cs:word_16D98, 28h ; '('
		mov	cs:word_16D9A, cx
		dec	cx
		imul	cx, 50h
		add	bx, cx
		add	dx, cx
		mov	cs:word_16D94, bx
		mov	cs:word_16D96, dx
		mov	cs:byte_16D9C, 1

loc_10877:				; CODE XREF: start+87Dj
		cmp	cs:byte_16D9C, 0FFh
		jnz	short loc_10877
		mov	DestFrmWaitTick, 291Bh
		mov	DestFMWaitTick,	1883h
		mov	DestMIDWaitTick, 1920h
		call	WaitForMusic1
		jnb	short loc_108A6
		cmp	ax, 1
		jnz	short loc_1089E
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_1089E:				; CODE XREF: start+899j
		cmp	ax, 2
		jnz	short loc_108A6
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_108A6:				; CODE XREF: start+894j start+8A1j
		mov	bx, 2
		mov	dx, 1
		call	sub_168CE
		mov	bx, 0
		mov	dx, 1F54h
		mov	cx, 0C8h ; 'È'
		mov	cs:word_16D90, bx
		mov	cs:word_16D92, dx
		mov	cs:word_16D98, 28h ; '('
		mov	cs:word_16D9A, cx
		dec	cx
		imul	cx, 50h
		add	bx, cx
		add	dx, cx
		mov	cs:word_16D94, bx
		mov	cs:word_16D96, dx
		mov	cs:byte_16D9C, 1

loc_108E6:				; CODE XREF: start+8ECj
		cmp	cs:byte_16D9C, 0FFh
		jnz	short loc_108E6
		mov	DestFrmWaitTick, 2AC0h
		mov	DestFMWaitTick,	1943h
		mov	DestMIDWaitTick, 19E0h
		call	WaitForMusic1
		jnb	short loc_10915
		cmp	ax, 1
		jnz	short loc_1090D
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_1090D:				; CODE XREF: start+908j
		cmp	ax, 2
		jnz	short loc_10915
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_10915:				; CODE XREF: start+903j start+910j
		mov	PaletteID, 8
		mov	PalFadeStart, 100
		mov	byte_1793F, 0
		mov	byte_1793E, 1
		call	WaitForVSync
		mov	bx, 2
		mov	dx, 1
		call	sub_168CE
		mov	bx, 28h	; '('
		mov	dx, 28h	; '('
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_169BD
		mov	DestFrmWaitTick, 2AC8h
		mov	DestFMWaitTick,	1947h
		mov	DestMIDWaitTick, 19E4h
		call	WaitForMusic1
		jnb	short loc_1096C
		cmp	ax, 1
		jnz	short loc_10964
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_10964:				; CODE XREF: start+95Fj
		cmp	ax, 2
		jnz	short loc_1096C
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_1096C:				; CODE XREF: start+95Aj start+967j
		mov	bx, 2
		mov	dx, 1
		call	sub_168CE
		mov	bx, 3E80h
		mov	dx, 28h	; '('
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_169BD
		mov	DestFrmWaitTick, 2AD0h
		mov	DestFMWaitTick,	194Bh
		mov	DestMIDWaitTick, 19E8h
		call	WaitForMusic1
		jnb	short loc_109AB
		cmp	ax, 1
		jnz	short loc_109A3
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_109A3:				; CODE XREF: start+99Ej
		cmp	ax, 2
		jnz	short loc_109AB
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_109AB:				; CODE XREF: start+999j start+9A6j
		mov	bx, 2
		mov	dx, 1
		call	sub_168CE
		mov	bx, 3EA8h
		mov	dx, 28h	; '('
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_169BD
		mov	DestFrmWaitTick, 2B50h
		mov	DestFMWaitTick,	199Eh
		mov	DestMIDWaitTick, 1A40h
		call	WaitForMusic1
		jnb	short loc_109EA
		cmp	ax, 1
		jnz	short loc_109E2
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_109E2:				; CODE XREF: start+9DDj
		cmp	ax, 2
		jnz	short loc_109EA
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_109EA:				; CODE XREF: start+9D8j start+9E5j
		mov	PaletteID, 8
		mov	PalFade_StepDelay, 0Fh
		mov	byte_1793F, 2
		mov	byte_1793E, 1
		mov	DestFrmWaitTick, 2E5Ah
		mov	DestFMWaitTick,	1B6Ah
		mov	DestMIDWaitTick, 1C0Ch
		call	WaitForMusic1
		jnb	short loc_10A26
		cmp	ax, 1
		jnz	short loc_10A1E
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_10A1E:				; CODE XREF: start+A19j
		cmp	ax, 2
		jnz	short loc_10A26
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_10A26:				; CODE XREF: start+A14j start+A21j
		mov	PaletteID, 8
		mov	PalFadeStart, 100
		mov	PalFadeEnd, 0
		mov	PalFadeInc, 1
		mov	PalFade_StepDelay, 6
		mov	byte_1793F, 1
		mov	byte_1793E, 1
		mov	DestFrmWaitTick, 3442h
		mov	DestFMWaitTick,	1E28h
		mov	DestMIDWaitTick, 1EC0h
		call	WaitForMusic1
		jnb	short loc_10A74
		cmp	ax, 1
		jnz	short loc_10A6C
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_10A6C:				; CODE XREF: start+A67j
		cmp	ax, 2
		jnz	short loc_10A74
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_10A74:				; CODE XREF: start+A62j start+A6Fj
		mov	bx, 2
		mov	dx, 2
		call	sub_168CE
		mov	bx, 0
		mov	dx, 0
		mov	ax, 50h	; 'P'
		mov	cx, 190h
		call	sub_16909
		mov	DestFrmWaitTick, 353Fh
		mov	DestFMWaitTick,	1F01h
		mov	DestMIDWaitTick, 1F92h
		call	WaitForMusic1
		jnb	short loc_10AB3
		cmp	ax, 1
		jnz	short loc_10AAB
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_10AAB:				; CODE XREF: start+AA6j
		cmp	ax, 2
		jnz	short loc_10AB3
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_10AB3:				; CODE XREF: start+AA1j start+AAEj
		mov	PaletteID, 1
		mov	PalFadeStart, 0
		mov	PalFadeEnd, 100
		mov	PalFadeInc, 2
		mov	PalFade_StepDelay, 2
		mov	byte_1793F, 1
		mov	byte_1793E, 1
		mov	DestFrmWaitTick, 375Bh
		mov	DestFMWaitTick,	20C3h
		mov	DestMIDWaitTick, 20E4h
		call	WaitForMusic1
		jnb	short loc_10AFE
		cmp	ax, 1
		jnz	short loc_10AF9
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_10AF9:				; CODE XREF: start+AF4j
		cmp	ax, 2
		jz	short loc_10B68

loc_10AFE:				; CODE XREF: start+AEFj
		mov	PaletteID, 1
		mov	PalFadeStart, 100
		mov	PalFadeEnd, 0
		mov	PalFadeInc, 1
		mov	PalFade_StepDelay, 2
		mov	byte_1793F, 1
		mov	byte_1793E, 1
		mov	DestFrmWaitTick, 383Fh
		mov	DestFMWaitTick,	2123h
		mov	DestMIDWaitTick, 2144h
		call	WaitForMusic1
		jnb	short loc_10B49
		cmp	ax, 1
		jnz	short loc_10B44
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_10B44:				; CODE XREF: start+B3Fj
		cmp	ax, 2
		jz	short loc_10B68

loc_10B49:				; CODE XREF: start+B3Aj
		mov	byte_17932, 0
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		call	ClearPlane
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		call	ClearPlane
		mov	byte_17922, 1

loc_10B61:				; CODE XREF: start+B66j
		cmp	byte_17922, 0
		jnz	short loc_10B61

loc_10B68:				; CODE XREF: start+443j start+48Cj ...
		mov	CurFrameID, 0
		mov	FrameCounter, 0
		mov	word_17912, 0
		mov	byte_1758A, 0
		mov	byte_1758B, 0
		mov	byte_17924, 0
		mov	byte_17932, 0
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		call	ClearPlane
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		call	ClearPlane
		mov	byte_17922, 1

loc_10BA1:				; CODE XREF: start+BA6j
		cmp	byte_17922, 0
		jnz	short loc_10BA1
		mov	al, 0
		out	76h, al
		call	DoBlackPalette
		push	es
		mov	ax, 0A000h
		mov	es, ax
		assume es:nothing
		xor	di, di
		mov	cx, 820h
		xor	ah, ah
		mov	al, 0
		rep stosw
		mov	ax, 0A200h
		mov	es, ax
		assume es:nothing
		xor	di, di
		mov	cx, 820h
		xor	ah, ah
		mov	al, 0E1h ; 'á'
		rep stosw
		pop	es
		assume es:nothing
		mov	dx, 0
		call	sub_168A3
		mov	ax, 0FFFFh
		mov	si, offset aBOp_h01_gta	; "B:OP_H01.GTA"
		mov	word_1793A, 0
		mov	word_1793C, 0
		call	LoadGTA
		jnb	short loc_10BF1
		jmp	ErrExit_fopen
; ---------------------------------------------------------------------------

loc_10BF1:				; CODE XREF: start+BECj
		mov	PaletteID, 0
		call	CopyPalette
		mov	dx, 1
		call	sub_168A3
		mov	ax, 0FFFFh
		mov	si, offset aBOp_h02_gta	; "B:OP_H02.GTA"
		mov	word_1793A, 0
		mov	word_1793C, 0
		call	LoadGTA
		jnb	short loc_10C19
		jmp	ErrExit_fopen
; ---------------------------------------------------------------------------

loc_10C19:				; CODE XREF: start+C14j
		mov	PaletteID, 1
		call	CopyPalette
		mov	dx, 2
		call	sub_168A3
		mov	ax, 0FFFFh
		mov	si, offset aBOp_h03_gta	; "B:OP_H03.GTA"
		mov	word_1793A, 0
		mov	word_1793C, 0
		call	LoadGTA
		jnb	short loc_10C41
		jmp	ErrExit_fopen
; ---------------------------------------------------------------------------

loc_10C41:				; CODE XREF: start+C3Cj
		mov	PaletteID, 2
		call	CopyPalette
		mov	bl, 1
		call	PlayBGM		; play music OP_2
		jnb	short loc_10C53
		jmp	ErrExit_fopen
; ---------------------------------------------------------------------------

loc_10C53:				; CODE XREF: start+C4Ej
		call	WaitForVSync
		call	WaitForVSync
		call	WaitForVSync
		call	WaitForVSync
		call	WaitForVSync
		call	WaitForVSync
		call	WaitForVSync
		call	WaitForVSync
		call	WaitForVSync
		call	WaitForVSync
		mov	CurFrameID, 0
		mov	FrameCounter, 0
		mov	word_17912, 0
		mov	byte_1758A, 0
		mov	byte_1758B, 0
		mov	DestFrmWaitTick, 1E0h
		mov	DestFMWaitTick,	198h
		mov	DestMIDWaitTick, 1B6h
		call	WaitForMusic1
		jnb	short loc_10CB4
		cmp	ax, 1
		jnz	short loc_10CAC
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_10CAC:				; CODE XREF: start+CA7j
		cmp	ax, 2
		jnz	short loc_10CB4
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_10CB4:				; CODE XREF: start+CA2j start+CAFj
		mov	PaletteID, 0
		mov	PalFadeStart, 0
		mov	byte_1793F, 0
		mov	byte_1793E, 1
		call	WaitForVSync
		mov	PaletteID, 0
		mov	PalFadeStart, 0
		mov	PalFadeEnd, 100
		mov	PalFadeInc, 1
		mov	PalFade_StepDelay, 1
		mov	byte_1793F, 1
		mov	byte_1793E, 1
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 0
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	byte_17922, 2

loc_10D14:				; CODE XREF: start+D19j
		cmp	byte_17922, 0
		jnz	short loc_10D14
		jmp	short loc_10D66
; ---------------------------------------------------------------------------

loc_10D1D:				; CODE XREF: start+E58j
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 0
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 2
		call	WaitFrames2
		jnb	short loc_10D5A
		cmp	ax, 1
		jnz	short loc_10D52
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_10D52:				; CODE XREF: start+D4Dj
		cmp	ax, 2
		jnz	short loc_10D5A
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_10D5A:				; CODE XREF: start+D48j start+D55j
		mov	byte_17922, 2

loc_10D5F:				; CODE XREF: start+D64j
		cmp	byte_17922, 0
		jnz	short loc_10D5F

loc_10D66:				; CODE XREF: start+D1Bj
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 28h	; '('
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 2
		call	WaitFrames2
		jnb	short loc_10DA3
		cmp	ax, 1
		jnz	short loc_10D9B
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_10D9B:				; CODE XREF: start+D96j
		cmp	ax, 2
		jnz	short loc_10DA3
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_10DA3:				; CODE XREF: start+D91j start+D9Ej
		mov	byte_17922, 1

loc_10DA8:				; CODE XREF: start+DADj
		cmp	byte_17922, 0
		jnz	short loc_10DA8
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 3E80h
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 2
		call	WaitFrames2
		jnb	short loc_10DEC
		cmp	ax, 1
		jnz	short loc_10DE4
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_10DE4:				; CODE XREF: start+DDFj
		cmp	ax, 2
		jnz	short loc_10DEC
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_10DEC:				; CODE XREF: start+DDAj start+DE7j
		mov	byte_17922, 2

loc_10DF1:				; CODE XREF: start+DF6j
		cmp	byte_17922, 0
		jnz	short loc_10DF1
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 3EA8h
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 2
		call	WaitFrames2
		jnb	short loc_10E35
		cmp	ax, 1
		jnz	short loc_10E2D
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_10E2D:				; CODE XREF: start+E28j
		cmp	ax, 2
		jnz	short loc_10E35
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_10E35:				; CODE XREF: start+E23j start+E30j
		mov	byte_17922, 1

loc_10E3A:				; CODE XREF: start+E3Fj
		cmp	byte_17922, 0
		jnz	short loc_10E3A
		mov	DestFrmWaitTick, 336h
		mov	DestFMWaitTick,	2ACh
		mov	DestMIDWaitTick, 2CAh
		call	WaitForMusic2
		jb	short loc_10E5B
		jmp	loc_10D1D
; ---------------------------------------------------------------------------

loc_10E5B:				; CODE XREF: start+E56j
		cmp	ax, 1
		jz	short loc_10E70
		cmp	ax, 2
		jnz	short loc_10E68
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_10E68:				; CODE XREF: start+E63j
		cmp	ax, 3
		jnz	short loc_10E70
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_10E70:				; CODE XREF: start+E5Ej start+E6Bj
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 1
		call	sub_168CE
		mov	bx, 0
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_10EAD
		cmp	ax, 1
		jnz	short loc_10EA5
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_10EA5:				; CODE XREF: start+EA0j
		cmp	ax, 2
		jnz	short loc_10EAD
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_10EAD:				; CODE XREF: start+E9Bj start+EA8j
		mov	byte_17922, 2

loc_10EB2:				; CODE XREF: start+EB7j
		cmp	byte_17922, 0
		jnz	short loc_10EB2
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 1
		call	sub_168CE
		mov	bx, 28h	; '('
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_10EF6
		cmp	ax, 1
		jnz	short loc_10EEE
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_10EEE:				; CODE XREF: start+EE9j
		cmp	ax, 2
		jnz	short loc_10EF6
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_10EF6:				; CODE XREF: start+EE4j start+EF1j
		mov	byte_17922, 1

loc_10EFB:				; CODE XREF: start+F00j
		cmp	byte_17922, 0
		jnz	short loc_10EFB
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 1
		call	sub_168CE
		mov	bx, 3E80h
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_10F3F
		cmp	ax, 1
		jnz	short loc_10F37
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_10F37:				; CODE XREF: start+F32j
		cmp	ax, 2
		jnz	short loc_10F3F
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_10F3F:				; CODE XREF: start+F2Dj start+F3Aj
		mov	byte_17922, 2

loc_10F44:				; CODE XREF: start+F49j
		cmp	byte_17922, 0
		jnz	short loc_10F44
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 1
		call	sub_168CE
		mov	bx, 3EA8h
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_10F88
		cmp	ax, 1
		jnz	short loc_10F80
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_10F80:				; CODE XREF: start+F7Bj
		cmp	ax, 2
		jnz	short loc_10F88
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_10F88:				; CODE XREF: start+F76j start+F83j
		mov	byte_17922, 1

loc_10F8D:				; CODE XREF: start+F92j
		cmp	byte_17922, 0
		jnz	short loc_10F8D
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 2
		call	sub_168CE
		mov	bx, 0
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_10FD1
		cmp	ax, 1
		jnz	short loc_10FC9
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_10FC9:				; CODE XREF: start+FC4j
		cmp	ax, 2
		jnz	short loc_10FD1
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_10FD1:				; CODE XREF: start+FBFj start+FCCj
		mov	byte_17922, 2

loc_10FD6:				; CODE XREF: start+FDBj
		cmp	byte_17922, 0
		jnz	short loc_10FD6
		cmp	byte_1757E, 1
		jnz	short loc_10FEE
		cmp	byte_17902, 1
		jnz	short loc_10FEE
		jmp	loc_111C8
; ---------------------------------------------------------------------------

loc_10FEE:				; CODE XREF: start+FE2j start+FE9j
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		call	ClearPlane
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A

loc_10FF9:				; CODE XREF: start+FFEj
		cmp	byte_1793E, 0FFh
		jnz	short loc_10FF9
		mov	dx, 0FFFFh
		call	sub_168A3
		mov	ax, 0FFFFh
		mov	si, offset aBOp_h00_gta	; "B:OP_H00.GTA"
		mov	word_1793A, 0
		mov	word_1793C, 0
		call	LoadGTA
		jnb	short loc_11020
		jmp	ErrExit_fopen
; ---------------------------------------------------------------------------

loc_11020:				; CODE XREF: start+101Bj
		mov	PaletteID, 9
		call	CopyPalette
		mov	DestFrmWaitTick, 3A8h
		mov	DestFMWaitTick,	318h
		mov	DestMIDWaitTick, 336h
		call	WaitForMusic1
		jnb	short loc_1104F
		cmp	ax, 1
		jnz	short loc_11047
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_11047:				; CODE XREF: start+1042j
		cmp	ax, 2
		jnz	short loc_1104F
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_1104F:				; CODE XREF: start+103Dj start+104Aj
		mov	PaletteID, 0
		mov	PalFadeStart, 100
		mov	PalFadeEnd, 0
		mov	PalFadeInc, 1
		mov	PalFade_StepDelay, 1
		mov	byte_1793F, 1
		mov	byte_1793E, 1

loc_11076:				; CODE XREF: start+107Bj
		cmp	byte_1793E, 0FFh
		jnz	short loc_11076
		mov	DestFrmWaitTick, 486h
		mov	DestFMWaitTick,	3D2h
		mov	DestMIDWaitTick, 3F0h
		call	WaitForMusic1
		jnb	short loc_110A4
		cmp	ax, 1
		jnz	short loc_1109C
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_1109C:				; CODE XREF: start+1097j
		cmp	ax, 2
		jnz	short loc_110A4
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_110A4:				; CODE XREF: start+1092j start+109Fj
		mov	PaletteID, 9
		mov	PalFadeStart, 0
		mov	PalFadeEnd, 100
		mov	PalFadeInc, 1
		mov	PalFade_StepDelay, 1
		mov	byte_1793F, 1
		mov	byte_1793E, 1
		mov	byte_17922, 1

loc_110D0:				; CODE XREF: start+10D5j
		cmp	byte_17922, 0
		jnz	short loc_110D0

loc_110D7:				; CODE XREF: start+10DCj
		cmp	byte_1793E, 0FFh
		jnz	short loc_110D7
		mov	dx, 0
		call	sub_168A3
		mov	ax, 0FFFFh
		mov	si, offset aBOp_h11_gta	; "B:OP_H11.GTA"
		mov	word_1793A, 0
		mov	word_1793C, 0
		call	LoadGTA
		jnb	short loc_110FE
		jmp	ErrExit_fopen
; ---------------------------------------------------------------------------

loc_110FE:				; CODE XREF: start+10F9j
		mov	PaletteID, 0
		call	CopyPalette
		mov	dx, 1
		call	sub_168A3
		mov	ax, 0FFFFh
		mov	si, offset aBOp_h12_gta	; "B:OP_H12.GTA"
		mov	word_1793A, 0
		mov	word_1793C, 0
		call	LoadGTA
		jnb	short loc_11126
		jmp	ErrExit_fopen
; ---------------------------------------------------------------------------

loc_11126:				; CODE XREF: start+1121j
		mov	PaletteID, 1
		call	CopyPalette
		mov	dx, 2
		call	sub_168A3
		mov	ax, 0FFFFh
		mov	si, offset aBOp_h13_gta	; "B:OP_H13.GTA"
		mov	word_1793A, 0
		mov	word_1793C, 0
		call	LoadGTA
		jnb	short loc_1114E
		jmp	ErrExit_fopen
; ---------------------------------------------------------------------------

loc_1114E:				; CODE XREF: start+1149j
		mov	PaletteID, 2
		call	CopyPalette
		mov	DestFrmWaitTick, 64Eh
		mov	DestFMWaitTick,	552h
		mov	DestMIDWaitTick, 570h
		call	WaitForMusic1
		jnb	short loc_1117D
		cmp	ax, 1
		jnz	short loc_11175
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_11175:				; CODE XREF: start+1170j
		cmp	ax, 2
		jnz	short loc_1117D
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_1117D:				; CODE XREF: start+116Bj start+1178j
		mov	PaletteID, 9
		mov	PalFadeStart, 100
		mov	PalFadeEnd, 0
		mov	PalFadeInc, 1
		mov	PalFade_StepDelay, 1
		mov	byte_1793F, 1
		mov	byte_1793E, 1

loc_111A4:				; CODE XREF: start+11A9j
		cmp	byte_1793E, 0FFh
		jnz	short loc_111A4
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		call	ClearPlane
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		call	ClearPlane
		mov	byte_17922, 1

loc_111BE:				; CODE XREF: start+11C3j
		cmp	byte_17922, 0
		jnz	short loc_111BE
		jmp	loc_11996
; ---------------------------------------------------------------------------

loc_111C8:				; CODE XREF: start+FEBj start+11CDj
		cmp	byte_1793E, 0FFh
		jnz	short loc_111C8
		mov	dx, 0
		call	sub_168A3
		mov	ax, 0FFFFh
		mov	si, offset aBOp_h05_gta	; "B:OP_H05.GTA"
		mov	word_1793A, 0
		mov	word_1793C, 0
		call	LoadGTA
		jnb	short loc_111EF
		jmp	ErrExit_fopen
; ---------------------------------------------------------------------------

loc_111EF:				; CODE XREF: start+11EAj
		mov	PaletteID, 4
		call	CopyPalette
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		call	ClearPlane
		mov	DestFrmWaitTick, 3A8h
		mov	DestFMWaitTick,	318h
		mov	DestMIDWaitTick, 336h
		call	WaitForMusic1
		jnb	short loc_11225
		cmp	ax, 1
		jnz	short loc_1121D
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_1121D:				; CODE XREF: start+1218j
		cmp	ax, 2
		jnz	short loc_11225
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_11225:				; CODE XREF: start+1213j start+1220j
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 0
		mov	dx, 0C10h
		mov	ax, 11h
		mov	cx, 0CBh ; 'Ë'
		call	sub_16909
		mov	byte_17922, 1

loc_11246:				; CODE XREF: start+124Bj
		cmp	byte_17922, 0
		jnz	short loc_11246
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		call	ClearPlane
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 19h
		mov	dx, 0C10h
		mov	ax, 11h
		mov	cx, 0CBh ; 'Ë'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_11291
		cmp	ax, 1
		jnz	short loc_11289
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_11289:				; CODE XREF: start+1284j
		cmp	ax, 2
		jnz	short loc_11291
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_11291:				; CODE XREF: start+127Fj start+128Cj
		mov	byte_17922, 2

loc_11296:				; CODE XREF: start+129Bj
		cmp	byte_17922, 0
		jnz	short loc_11296
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 32h	; '2'
		mov	dx, 0C10h
		mov	ax, 11h
		mov	cx, 0CBh ; 'Ë'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_112DA
		cmp	ax, 1
		jnz	short loc_112D2
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_112D2:				; CODE XREF: start+12CDj
		cmp	ax, 2
		jnz	short loc_112DA
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_112DA:				; CODE XREF: start+12C8j start+12D5j
		mov	byte_17922, 1

loc_112DF:				; CODE XREF: start+12E4j
		cmp	byte_17922, 0
		jnz	short loc_112DF
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 32h	; '2'
		mov	dx, 0C10h
		mov	ax, 11h
		mov	cx, 0CBh ; 'Ë'
		call	sub_16909
		mov	dx, 0
		call	sub_168A3
		mov	ax, 0FFFFh
		mov	si, offset aBOp_h04_gta	; "B:OP_H04.GTA"
		mov	word_1793A, 0
		mov	word_1793C, 0
		call	LoadGTA
		jnb	short loc_11322
		jmp	ErrExit_fopen
; ---------------------------------------------------------------------------

loc_11322:				; CODE XREF: start+131Dj
		mov	PaletteID, 3
		call	CopyPalette
		mov	DestFrmWaitTick, 41Ah
		mov	DestFMWaitTick,	378h
		mov	DestMIDWaitTick, 396h
		call	WaitForMusic1
		jnb	short loc_11351
		cmp	ax, 1
		jnz	short loc_11349
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_11349:				; CODE XREF: start+1344j
		cmp	ax, 2
		jnz	short loc_11351
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_11351:				; CODE XREF: start+133Fj start+134Cj
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 0
		mov	dx, 3B32h
		mov	ax, 1Fh
		mov	cx, 8Dh	; ''
		call	sub_169BD
		mov	byte_17922, 2

loc_11372:				; CODE XREF: start+1377j
		cmp	byte_17922, 0
		jnz	short loc_11372
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 28h	; '('
		mov	dx, 3B32h
		mov	ax, 1Fh
		mov	cx, 8Dh	; ''
		call	sub_169BD
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_113B6
		cmp	ax, 1
		jnz	short loc_113AE
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_113AE:				; CODE XREF: start+13A9j
		cmp	ax, 2
		jnz	short loc_113B6
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_113B6:				; CODE XREF: start+13A4j start+13B1j
		mov	byte_17922, 1

loc_113BB:				; CODE XREF: start+13C0j
		cmp	byte_17922, 0
		jnz	short loc_113BB
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 3E80h
		mov	dx, 3B32h
		mov	ax, 1Fh
		mov	cx, 8Dh	; ''
		call	sub_169BD
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_113FF
		cmp	ax, 1
		jnz	short loc_113F7
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_113F7:				; CODE XREF: start+13F2j
		cmp	ax, 2
		jnz	short loc_113FF
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_113FF:				; CODE XREF: start+13EDj start+13FAj
		mov	byte_17922, 2

loc_11404:				; CODE XREF: start+1409j
		cmp	byte_17922, 0
		jnz	short loc_11404
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 3E80h
		mov	dx, 3B32h
		mov	ax, 1Fh
		mov	cx, 8Dh	; ''
		call	sub_169BD
		mov	dx, 0
		call	sub_168A3
		mov	ax, 0FFFFh
		mov	si, offset aBOp_h06_gta	; "B:OP_H06.GTA"
		mov	word_1793A, 0
		mov	word_1793C, 0
		call	LoadGTA
		jnb	short loc_11447
		jmp	ErrExit_fopen
; ---------------------------------------------------------------------------

loc_11447:				; CODE XREF: start+1442j
		mov	PaletteID, 5
		call	CopyPalette
		mov	DestFrmWaitTick, 48Ch
		mov	DestFMWaitTick,	3D8h
		mov	DestMIDWaitTick, 3F6h
		call	WaitForMusic1
		jnb	short loc_11476
		cmp	ax, 1
		jnz	short loc_1146E
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_1146E:				; CODE XREF: start+1469j
		cmp	ax, 2
		jnz	short loc_11476
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_11476:				; CODE XREF: start+1464j start+1471j
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 0
		mov	dx, 0C02h
		mov	ax, 1Bh
		mov	cx, 9Ch	; 'œ'
		call	sub_169BD
		mov	byte_17922, 1

loc_11497:				; CODE XREF: start+149Cj
		cmp	byte_17922, 0
		jnz	short loc_11497
		jmp	short loc_114E9
; ---------------------------------------------------------------------------

loc_114A0:				; CODE XREF: start+15DBj
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 0
		mov	dx, 0C02h
		mov	ax, 1Bh
		mov	cx, 9Ch	; 'œ'
		call	sub_169BD
		mov	FrameCounter, 0
		mov	FramesToWait, 4
		call	WaitFrames2
		jnb	short loc_114DD
		cmp	ax, 1
		jnz	short loc_114D5
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_114D5:				; CODE XREF: start+14D0j
		cmp	ax, 2
		jnz	short loc_114DD
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_114DD:				; CODE XREF: start+14CBj start+14D8j
		mov	byte_17922, 1

loc_114E2:				; CODE XREF: start+14E7j
		cmp	byte_17922, 0
		jnz	short loc_114E2

loc_114E9:				; CODE XREF: start+149Ej
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 28h	; '('
		mov	dx, 0C02h
		mov	ax, 1Bh
		mov	cx, 9Ch	; 'œ'
		call	sub_169BD
		mov	FrameCounter, 0
		mov	FramesToWait, 4
		call	WaitFrames2
		jnb	short loc_11526
		cmp	ax, 1
		jnz	short loc_1151E
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_1151E:				; CODE XREF: start+1519j
		cmp	ax, 2
		jnz	short loc_11526
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_11526:				; CODE XREF: start+1514j start+1521j
		mov	byte_17922, 2

loc_1152B:				; CODE XREF: start+1530j
		cmp	byte_17922, 0
		jnz	short loc_1152B
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 3E80h
		mov	dx, 0C02h
		mov	ax, 1Bh
		mov	cx, 9Ch	; 'œ'
		call	sub_169BD
		mov	FrameCounter, 0
		mov	FramesToWait, 4
		call	WaitFrames2
		jnb	short loc_1156F
		cmp	ax, 1
		jnz	short loc_11567
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_11567:				; CODE XREF: start+1562j
		cmp	ax, 2
		jnz	short loc_1156F
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_1156F:				; CODE XREF: start+155Dj start+156Aj
		mov	byte_17922, 1

loc_11574:				; CODE XREF: start+1579j
		cmp	byte_17922, 0
		jnz	short loc_11574
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 3EA8h
		mov	dx, 0C02h
		mov	ax, 1Bh
		mov	cx, 9Ch	; 'œ'
		call	sub_169BD
		mov	FrameCounter, 0
		mov	FramesToWait, 4
		call	WaitFrames2
		jnb	short loc_115B8
		cmp	ax, 1
		jnz	short loc_115B0
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_115B0:				; CODE XREF: start+15ABj
		cmp	ax, 2
		jnz	short loc_115B8
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_115B8:				; CODE XREF: start+15A6j start+15B3j
		mov	byte_17922, 2

loc_115BD:				; CODE XREF: start+15C2j
		cmp	byte_17922, 0
		jnz	short loc_115BD
		mov	DestFrmWaitTick, 4FEh
		mov	DestFMWaitTick,	438h
		mov	DestMIDWaitTick, 456h
		call	WaitForMusic2
		jb	short loc_115DE
		jmp	loc_114A0
; ---------------------------------------------------------------------------

loc_115DE:				; CODE XREF: start+15D9j
		cmp	ax, 1
		jz	short loc_115F3
		cmp	ax, 2
		jnz	short loc_115EB
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_115EB:				; CODE XREF: start+15E6j
		cmp	ax, 3
		jnz	short loc_115F3
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_115F3:				; CODE XREF: start+15E1j start+15EEj
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 3EA8h
		mov	dx, 0C02h
		mov	ax, 1Bh
		mov	cx, 9Ch	; 'œ'
		call	sub_169BD
		mov	dx, 0
		call	sub_168A3
		mov	ax, 0FFFFh
		mov	si, offset aBOp_h07_gta	; "B:OP_H07.GTA"
		mov	word_1793A, 0
		mov	word_1793C, 0
		call	LoadGTA
		jnb	short loc_1162F
		jmp	ErrExit_fopen
; ---------------------------------------------------------------------------

loc_1162F:				; CODE XREF: start+162Aj
		mov	PaletteID, 0
		call	CopyPalette
		mov	dx, 1
		call	sub_168A3
		mov	ax, 0FFFFh
		mov	si, offset aBOp_h08_gta	; "B:OP_H08.GTA"
		mov	word_1793A, 0
		mov	word_1793C, 0
		call	LoadGTA
		jnb	short loc_11657
		jmp	ErrExit_fopen
; ---------------------------------------------------------------------------

loc_11657:				; CODE XREF: start+1652j
		mov	PaletteID, 1
		call	CopyPalette
		mov	dx, 2
		call	sub_168A3
		mov	ax, 0FFFFh
		mov	si, offset aBOp_h09_gta	; "B:OP_H09.GTA"
		mov	word_1793A, 0
		mov	word_1793C, 0
		call	LoadGTA
		jnb	short loc_1167F
		jmp	ErrExit_fopen
; ---------------------------------------------------------------------------

loc_1167F:				; CODE XREF: start+167Aj
		mov	PaletteID, 2
		call	CopyPalette
		mov	DestFrmWaitTick, 570h
		mov	DestFMWaitTick,	498h
		mov	DestMIDWaitTick, 4B6h
		call	WaitForMusic1
		jnb	short loc_116AE
		cmp	ax, 1
		jnz	short loc_116A6
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_116A6:				; CODE XREF: start+16A1j
		cmp	ax, 2
		jnz	short loc_116AE
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_116AE:				; CODE XREF: start+169Cj start+16A9j
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 0
		mov	dx, 0BECh
		mov	ax, 16h
		mov	cx, 124h
		call	sub_16909
		mov	byte_17922, 1

loc_116CF:				; CODE XREF: start+16D4j
		cmp	byte_17922, 0
		jnz	short loc_116CF
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 19h
		mov	dx, 0BECh
		mov	ax, 16h
		mov	cx, 124h
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 14h
		call	WaitFrames2
		jnb	short loc_11713
		cmp	ax, 1
		jnz	short loc_1170B
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_1170B:				; CODE XREF: start+1706j
		cmp	ax, 2
		jnz	short loc_11713
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_11713:				; CODE XREF: start+1701j start+170Ej
		mov	byte_17922, 2

loc_11718:				; CODE XREF: start+171Dj
		cmp	byte_17922, 0
		jnz	short loc_11718
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 32h	; '2'
		mov	dx, 0BECh
		mov	ax, 16h
		mov	cx, 124h
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 14h
		call	WaitFrames2
		jnb	short loc_1175C
		cmp	ax, 1
		jnz	short loc_11754
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_11754:				; CODE XREF: start+174Fj
		cmp	ax, 2
		jnz	short loc_1175C
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_1175C:				; CODE XREF: start+174Aj start+1757j
		mov	byte_17922, 1

loc_11761:				; CODE XREF: start+1766j
		cmp	byte_17922, 0
		jnz	short loc_11761
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 1
		call	sub_168CE
		mov	bx, 0
		mov	dx, 0BECh
		mov	ax, 16h
		mov	cx, 124h
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 14h
		call	WaitFrames2
		jnb	short loc_117A5
		cmp	ax, 1
		jnz	short loc_1179D
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_1179D:				; CODE XREF: start+1798j
		cmp	ax, 2
		jnz	short loc_117A5
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_117A5:				; CODE XREF: start+1793j start+17A0j
		mov	byte_17922, 2

loc_117AA:				; CODE XREF: start+17AFj
		cmp	byte_17922, 0
		jnz	short loc_117AA
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 1
		call	sub_168CE
		mov	bx, 19h
		mov	dx, 0BECh
		mov	ax, 16h
		mov	cx, 124h
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 14h
		call	WaitFrames2
		jnb	short loc_117EE
		cmp	ax, 1
		jnz	short loc_117E6
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_117E6:				; CODE XREF: start+17E1j
		cmp	ax, 2
		jnz	short loc_117EE
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_117EE:				; CODE XREF: start+17DCj start+17E9j
		mov	byte_17922, 1

loc_117F3:				; CODE XREF: start+17F8j
		cmp	byte_17922, 0
		jnz	short loc_117F3
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 1
		call	sub_168CE
		mov	bx, 32h	; '2'
		mov	dx, 0BECh
		mov	ax, 16h
		mov	cx, 124h
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 14h
		call	WaitFrames2
		jnb	short loc_11837
		cmp	ax, 1
		jnz	short loc_1182F
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_1182F:				; CODE XREF: start+182Aj
		cmp	ax, 2
		jnz	short loc_11837
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_11837:				; CODE XREF: start+1825j start+1832j
		mov	byte_17922, 2

loc_1183C:				; CODE XREF: start+1841j
		cmp	byte_17922, 0
		jnz	short loc_1183C
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 2
		call	sub_168CE
		mov	bx, 0
		mov	dx, 0BECh
		mov	ax, 16h
		mov	cx, 124h
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 14h
		call	WaitFrames2
		jnb	short loc_11880
		cmp	ax, 1
		jnz	short loc_11878
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_11878:				; CODE XREF: start+1873j
		cmp	ax, 2
		jnz	short loc_11880
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_11880:				; CODE XREF: start+186Ej start+187Bj
		mov	byte_17922, 1

loc_11885:				; CODE XREF: start+188Aj
		cmp	byte_17922, 0
		jnz	short loc_11885
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 2
		call	sub_168CE
		mov	bx, 19h
		mov	dx, 0BECh
		mov	ax, 16h
		mov	cx, 124h
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 14h
		call	WaitFrames2
		jnb	short loc_118C9
		cmp	ax, 1
		jnz	short loc_118C1
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_118C1:				; CODE XREF: start+18BCj
		cmp	ax, 2
		jnz	short loc_118C9
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_118C9:				; CODE XREF: start+18B7j start+18C4j
		mov	byte_17922, 2

loc_118CE:				; CODE XREF: start+18D3j
		cmp	byte_17922, 0
		jnz	short loc_118CE
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 2
		call	sub_168CE
		mov	bx, 32h	; '2'
		mov	dx, 0BECh
		mov	ax, 16h
		mov	cx, 124h
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 14h
		call	WaitFrames2
		jnb	short loc_11912
		cmp	ax, 1
		jnz	short loc_1190A
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_1190A:				; CODE XREF: start+1905j
		cmp	ax, 2
		jnz	short loc_11912
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_11912:				; CODE XREF: start+1900j start+190Dj
		mov	byte_17922, 1

loc_11917:				; CODE XREF: start+191Cj
		cmp	byte_17922, 0
		jnz	short loc_11917
		mov	dx, 0
		call	sub_168A3
		mov	ax, 0FFFFh
		mov	si, offset aBOp_h11_gta	; "B:OP_H11.GTA"
		mov	word_1793A, 0
		mov	word_1793C, 0
		call	LoadGTA
		jnb	short loc_1193E
		jmp	ErrExit_fopen
; ---------------------------------------------------------------------------

loc_1193E:				; CODE XREF: start+1939j
		mov	PaletteID, 0
		call	CopyPalette
		mov	dx, 1
		call	sub_168A3
		mov	ax, 0FFFFh
		mov	si, offset aBOp_h12_gta	; "B:OP_H12.GTA"
		mov	word_1793A, 0
		mov	word_1793C, 0
		call	LoadGTA
		jnb	short loc_11966
		jmp	ErrExit_fopen
; ---------------------------------------------------------------------------

loc_11966:				; CODE XREF: start+1961j
		mov	PaletteID, 1
		call	CopyPalette
		mov	dx, 2
		call	sub_168A3
		mov	ax, 0FFFFh
		mov	si, offset aBOp_h13_gta	; "B:OP_H13.GTA"
		mov	word_1793A, 0
		mov	word_1793C, 0
		call	LoadGTA
		jnb	short loc_1198E
		jmp	ErrExit_fopen
; ---------------------------------------------------------------------------

loc_1198E:				; CODE XREF: start+1989j
		mov	PaletteID, 2
		call	CopyPalette

loc_11996:				; CODE XREF: start+11C5j
		mov	DestFrmWaitTick, 708h
		mov	DestFMWaitTick,	5E8h
		mov	DestMIDWaitTick, 606h
		call	WaitForMusic1
		jnb	short loc_119BD
		cmp	ax, 1
		jnz	short loc_119B5
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_119B5:				; CODE XREF: start+19B0j
		cmp	ax, 2
		jnz	short loc_119BD
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_119BD:				; CODE XREF: start+19ABj start+19B8j
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		call	ClearPlane
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	PaletteID, 0
		mov	PalFadeStart, 100
		mov	byte_1793F, 0
		mov	byte_1793E, 1
		call	WaitForVSync
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 0
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	byte_17922, 2

loc_119FD:				; CODE XREF: start+1A02j
		cmp	byte_17922, 0
		jnz	short loc_119FD
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		call	ClearPlane
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 28h	; '('
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 13h
		call	WaitFrames2
		jnb	short loc_11A48
		cmp	ax, 1
		jnz	short loc_11A40
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_11A40:				; CODE XREF: start+1A3Bj
		cmp	ax, 2
		jnz	short loc_11A48
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_11A48:				; CODE XREF: start+1A36j start+1A43j
		mov	byte_17922, 1

loc_11A4D:				; CODE XREF: start+1A52j
		cmp	byte_17922, 0
		jnz	short loc_11A4D
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 3E80h
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 13h
		call	WaitFrames2
		jnb	short loc_11A91
		cmp	ax, 1
		jnz	short loc_11A89
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_11A89:				; CODE XREF: start+1A84j
		cmp	ax, 2
		jnz	short loc_11A91
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_11A91:				; CODE XREF: start+1A7Fj start+1A8Cj
		mov	byte_17922, 2

loc_11A96:				; CODE XREF: start+1A9Bj
		cmp	byte_17922, 0
		jnz	short loc_11A96
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 3EA8h
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 13h
		call	WaitFrames2
		jnb	short loc_11ADA
		cmp	ax, 1
		jnz	short loc_11AD2
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_11AD2:				; CODE XREF: start+1ACDj
		cmp	ax, 2
		jnz	short loc_11ADA
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_11ADA:				; CODE XREF: start+1AC8j start+1AD5j
		mov	byte_17922, 1

loc_11ADF:				; CODE XREF: start+1AE4j
		cmp	byte_17922, 0
		jnz	short loc_11ADF
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 1
		call	sub_168CE
		mov	bx, 0
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 13h
		call	WaitFrames2
		jnb	short loc_11B23
		cmp	ax, 1
		jnz	short loc_11B1B
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_11B1B:				; CODE XREF: start+1B16j
		cmp	ax, 2
		jnz	short loc_11B23
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_11B23:				; CODE XREF: start+1B11j start+1B1Ej
		mov	byte_17922, 2

loc_11B28:				; CODE XREF: start+1B2Dj
		cmp	byte_17922, 0
		jnz	short loc_11B28
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 1
		call	sub_168CE
		mov	bx, 28h	; '('
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 13h
		call	WaitFrames2
		jnb	short loc_11B6C
		cmp	ax, 1
		jnz	short loc_11B64
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_11B64:				; CODE XREF: start+1B5Fj
		cmp	ax, 2
		jnz	short loc_11B6C
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_11B6C:				; CODE XREF: start+1B5Aj start+1B67j
		mov	byte_17922, 1

loc_11B71:				; CODE XREF: start+1B76j
		cmp	byte_17922, 0
		jnz	short loc_11B71
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 1
		call	sub_168CE
		mov	bx, 3E80h
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 13h
		call	WaitFrames2
		jnb	short loc_11BB5
		cmp	ax, 1
		jnz	short loc_11BAD
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_11BAD:				; CODE XREF: start+1BA8j
		cmp	ax, 2
		jnz	short loc_11BB5
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_11BB5:				; CODE XREF: start+1BA3j start+1BB0j
		mov	byte_17922, 2

loc_11BBA:				; CODE XREF: start+1BBFj
		cmp	byte_17922, 0
		jnz	short loc_11BBA
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 1
		call	sub_168CE
		mov	bx, 3EA8h
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 13h
		call	WaitFrames2
		jnb	short loc_11BFE
		cmp	ax, 1
		jnz	short loc_11BF6
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_11BF6:				; CODE XREF: start+1BF1j
		cmp	ax, 2
		jnz	short loc_11BFE
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_11BFE:				; CODE XREF: start+1BECj start+1BF9j
		mov	byte_17922, 1

loc_11C03:				; CODE XREF: start+1C08j
		cmp	byte_17922, 0
		jnz	short loc_11C03
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 2
		call	sub_168CE
		mov	bx, 0
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 13h
		call	WaitFrames2
		jnb	short loc_11C47
		cmp	ax, 1
		jnz	short loc_11C3F
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_11C3F:				; CODE XREF: start+1C3Aj
		cmp	ax, 2
		jnz	short loc_11C47
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_11C47:				; CODE XREF: start+1C35j start+1C42j
		mov	byte_17922, 2

loc_11C4C:				; CODE XREF: start+1C51j
		cmp	byte_17922, 0
		jnz	short loc_11C4C
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 2
		call	sub_168CE
		mov	bx, 0
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 2
		call	sub_168CE
		mov	bx, 3E80h
		mov	dx, 5DC0h
		mov	ax, 50h	; 'P'
		mov	cx, 32h	; '2'
		call	sub_169BD
		mov	DestFrmWaitTick, 81Ch
		mov	DestFMWaitTick,	6D8h
		mov	DestMIDWaitTick, 6F6h
		call	WaitForMusic1
		jnb	short loc_11CB2
		cmp	ax, 1
		jnz	short loc_11CAA
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_11CAA:				; CODE XREF: start+1CA5j
		cmp	ax, 2
		jnz	short loc_11CB2
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_11CB2:				; CODE XREF: start+1CA0j start+1CADj
		mov	byte_17922, 1

loc_11CB7:				; CODE XREF: start+1CBCj
		cmp	byte_17922, 0
		jnz	short loc_11CB7
		mov	dx, 0
		call	sub_168A3
		mov	ax, 0FFFFh
		mov	si, offset aBOp_e01_gta	; "B:OP_E01.GTA"
		mov	word_1793A, 0
		mov	word_1793C, 0
		call	LoadGTA
		jnb	short loc_11CDE
		jmp	ErrExit_fopen
; ---------------------------------------------------------------------------

loc_11CDE:				; CODE XREF: start+1CD9j
		mov	PaletteID, 0
		call	CopyPalette
		mov	dx, 1
		call	sub_168A3
		mov	ax, 0FFFFh
		mov	si, offset aBOp_e02_gta	; "B:OP_E02.GTA"
		mov	word_1793A, 0
		mov	word_1793C, 0
		call	LoadGTA
		jnb	short loc_11D06
		jmp	ErrExit_fopen
; ---------------------------------------------------------------------------

loc_11D06:				; CODE XREF: start+1D01j
		mov	PaletteID, 1
		call	CopyPalette
		mov	dx, 2
		call	sub_168A3
		mov	ax, 0FFFFh
		mov	si, offset aBOp_e03_gta	; "B:OP_E03.GTA"
		mov	word_1793A, 0
		mov	word_1793C, 0
		call	LoadGTA
		jnb	short loc_11D2E
		jmp	ErrExit_fopen
; ---------------------------------------------------------------------------

loc_11D2E:				; CODE XREF: start+1D29j
		mov	PaletteID, 2
		call	CopyPalette
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		call	ClearPlane
		mov	DestFrmWaitTick, 900h
		mov	DestFMWaitTick,	798h
		mov	DestMIDWaitTick, 7B6h
		call	WaitForMusic1
		jnb	short loc_11D64
		cmp	ax, 1
		jnz	short loc_11D5C
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_11D5C:				; CODE XREF: start+1D57j
		cmp	ax, 2
		jnz	short loc_11D64
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_11D64:				; CODE XREF: start+1D52j start+1D5Fj
		mov	PaletteID, 0
		mov	PalFadeStart, 0
		mov	byte_1793F, 0
		mov	byte_1793E, 1
		call	WaitForVSync
		call	WaitForVSync
		call	WaitForVSync
		call	WaitForVSync
		call	WaitForVSync
		mov	PaletteID, 0
		mov	PalFadeStart, 0
		mov	PalFadeEnd, 100
		mov	PalFadeInc, 1
		mov	PalFade_StepDelay, 1
		mov	byte_1793F, 1
		mov	byte_1793E, 1
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 0
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	byte_17922, 2

loc_11DD0:				; CODE XREF: start+1DD5j
		cmp	byte_17922, 0
		jnz	short loc_11DD0
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		call	ClearPlane
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 28h	; '('
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_11E1B
		cmp	ax, 1
		jnz	short loc_11E13
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_11E13:				; CODE XREF: start+1E0Ej
		cmp	ax, 2
		jnz	short loc_11E1B
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_11E1B:				; CODE XREF: start+1E09j start+1E16j
		mov	byte_17922, 1

loc_11E20:				; CODE XREF: start+1E25j
		cmp	byte_17922, 0
		jnz	short loc_11E20
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 3E80h
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_11E64
		cmp	ax, 1
		jnz	short loc_11E5C
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_11E5C:				; CODE XREF: start+1E57j
		cmp	ax, 2
		jnz	short loc_11E64
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_11E64:				; CODE XREF: start+1E52j start+1E5Fj
		mov	byte_17922, 2

loc_11E69:				; CODE XREF: start+1E6Ej
		cmp	byte_17922, 0
		jnz	short loc_11E69
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 3EA8h
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_11EAD
		cmp	ax, 1
		jnz	short loc_11EA5
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_11EA5:				; CODE XREF: start+1EA0j
		cmp	ax, 2
		jnz	short loc_11EAD
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_11EAD:				; CODE XREF: start+1E9Bj start+1EA8j
		mov	byte_17922, 1

loc_11EB2:				; CODE XREF: start+1EB7j
		cmp	byte_17922, 0
		jnz	short loc_11EB2
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 0
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_11EF6
		cmp	ax, 1
		jnz	short loc_11EEE
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_11EEE:				; CODE XREF: start+1EE9j
		cmp	ax, 2
		jnz	short loc_11EF6
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_11EF6:				; CODE XREF: start+1EE4j start+1EF1j
		mov	byte_17922, 2

loc_11EFB:				; CODE XREF: start+1F00j
		cmp	byte_17922, 0
		jnz	short loc_11EFB
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 28h	; '('
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_11F3F
		cmp	ax, 1
		jnz	short loc_11F37
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_11F37:				; CODE XREF: start+1F32j
		cmp	ax, 2
		jnz	short loc_11F3F
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_11F3F:				; CODE XREF: start+1F2Dj start+1F3Aj
		mov	byte_17922, 1

loc_11F44:				; CODE XREF: start+1F49j
		cmp	byte_17922, 0
		jnz	short loc_11F44
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 3E80h
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_11F88
		cmp	ax, 1
		jnz	short loc_11F80
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_11F80:				; CODE XREF: start+1F7Bj
		cmp	ax, 2
		jnz	short loc_11F88
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_11F88:				; CODE XREF: start+1F76j start+1F83j
		mov	byte_17922, 2

loc_11F8D:				; CODE XREF: start+1F92j
		cmp	byte_17922, 0
		jnz	short loc_11F8D
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 3EA8h
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_11FD1
		cmp	ax, 1
		jnz	short loc_11FC9
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_11FC9:				; CODE XREF: start+1FC4j
		cmp	ax, 2
		jnz	short loc_11FD1
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_11FD1:				; CODE XREF: start+1FBFj start+1FCCj
		mov	byte_17922, 1

loc_11FD6:				; CODE XREF: start+1FDBj
		cmp	byte_17922, 0
		jnz	short loc_11FD6
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 1
		call	sub_168CE
		mov	bx, 0
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_1201A
		cmp	ax, 1
		jnz	short loc_12012
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_12012:				; CODE XREF: start+200Dj
		cmp	ax, 2
		jnz	short loc_1201A
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_1201A:				; CODE XREF: start+2008j start+2015j
		mov	byte_17922, 2

loc_1201F:				; CODE XREF: start+2024j
		cmp	byte_17922, 0
		jnz	short loc_1201F
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 1
		call	sub_168CE
		mov	bx, 28h	; '('
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_12063
		cmp	ax, 1
		jnz	short loc_1205B
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_1205B:				; CODE XREF: start+2056j
		cmp	ax, 2
		jnz	short loc_12063
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_12063:				; CODE XREF: start+2051j start+205Ej
		mov	byte_17922, 1

loc_12068:				; CODE XREF: start+206Dj
		cmp	byte_17922, 0
		jnz	short loc_12068
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 1
		call	sub_168CE
		mov	bx, 3E80h
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_120AC
		cmp	ax, 1
		jnz	short loc_120A4
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_120A4:				; CODE XREF: start+209Fj
		cmp	ax, 2
		jnz	short loc_120AC
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_120AC:				; CODE XREF: start+209Aj start+20A7j
		mov	byte_17922, 2

loc_120B1:				; CODE XREF: start+20B6j
		cmp	byte_17922, 0
		jnz	short loc_120B1
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 1
		call	sub_168CE
		mov	bx, 3EA8h
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_120F5
		cmp	ax, 1
		jnz	short loc_120ED
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_120ED:				; CODE XREF: start+20E8j
		cmp	ax, 2
		jnz	short loc_120F5
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_120F5:				; CODE XREF: start+20E3j start+20F0j
		mov	byte_17922, 1

loc_120FA:				; CODE XREF: start+20FFj
		cmp	byte_17922, 0
		jnz	short loc_120FA

loc_12101:				; CODE XREF: start+223Cj
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 2
		call	sub_168CE
		mov	bx, 0
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_1213E
		cmp	ax, 1
		jnz	short loc_12136
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_12136:				; CODE XREF: start+2131j
		cmp	ax, 2
		jnz	short loc_1213E
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_1213E:				; CODE XREF: start+212Cj start+2139j
		mov	byte_17922, 2

loc_12143:				; CODE XREF: start+2148j
		cmp	byte_17922, 0
		jnz	short loc_12143
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 2
		call	sub_168CE
		mov	bx, 28h	; '('
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_12187
		cmp	ax, 1
		jnz	short loc_1217F
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_1217F:				; CODE XREF: start+217Aj
		cmp	ax, 2
		jnz	short loc_12187
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_12187:				; CODE XREF: start+2175j start+2182j
		mov	byte_17922, 1

loc_1218C:				; CODE XREF: start+2191j
		cmp	byte_17922, 0
		jnz	short loc_1218C
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 2
		call	sub_168CE
		mov	bx, 3E80h
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_121D0
		cmp	ax, 1
		jnz	short loc_121C8
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_121C8:				; CODE XREF: start+21C3j
		cmp	ax, 2
		jnz	short loc_121D0
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_121D0:				; CODE XREF: start+21BEj start+21CBj
		mov	byte_17922, 2

loc_121D5:				; CODE XREF: start+21DAj
		cmp	byte_17922, 0
		jnz	short loc_121D5
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 2
		call	sub_168CE
		mov	bx, 3EA8h
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_12219
		cmp	ax, 1
		jnz	short loc_12211
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_12211:				; CODE XREF: start+220Cj
		cmp	ax, 2
		jnz	short loc_12219
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_12219:				; CODE XREF: start+2207j start+2214j
		mov	byte_17922, 1

loc_1221E:				; CODE XREF: start+2223j
		cmp	byte_17922, 0
		jnz	short loc_1221E
		mov	DestFrmWaitTick, 0A3Eh
		mov	DestFMWaitTick,	8A0h
		mov	DestMIDWaitTick, 8BEh
		call	WaitForMusic2
		jb	short loc_1223F
		jmp	loc_12101
; ---------------------------------------------------------------------------

loc_1223F:				; CODE XREF: start+223Aj
		cmp	ax, 1
		jz	short loc_12254
		cmp	ax, 2
		jnz	short loc_1224C
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_1224C:				; CODE XREF: start+2247j
		cmp	ax, 3
		jnz	short loc_12254
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_12254:				; CODE XREF: start+2242j start+224Fj
		cmp	byte_1757E, 1
		jnz	short loc_12265
		cmp	byte_17902, 1
		jnz	short loc_12265
		jmp	loc_12417
; ---------------------------------------------------------------------------

loc_12265:				; CODE XREF: start+2259j start+2260j
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		call	ClearPlane
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A

loc_12270:				; CODE XREF: start+2275j
		cmp	byte_1793E, 0FFh
		jnz	short loc_12270
		mov	dx, 0FFFFh
		call	sub_168A3
		mov	ax, 0FFFFh
		mov	si, offset aBOp_e00_gta	; "B:OP_E00.GTA"
		mov	word_1793A, 0
		mov	word_1793C, 0
		call	LoadGTA
		jnb	short loc_12297
		jmp	ErrExit_fopen
; ---------------------------------------------------------------------------

loc_12297:				; CODE XREF: start+2292j
		mov	PaletteID, 9
		call	CopyPalette
		mov	DestFrmWaitTick, 0AC8h
		mov	DestFMWaitTick,	918h
		mov	DestMIDWaitTick, 936h
		call	WaitForMusic1
		jnb	short loc_122C6
		cmp	ax, 1
		jnz	short loc_122BE
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_122BE:				; CODE XREF: start+22B9j
		cmp	ax, 2
		jnz	short loc_122C6
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_122C6:				; CODE XREF: start+22B4j start+22C1j
		mov	PaletteID, 0
		mov	PalFadeStart, 100
		mov	PalFadeEnd, 0
		mov	PalFadeInc, 1
		mov	PalFade_StepDelay, 1
		mov	byte_1793F, 1
		mov	byte_1793E, 1

loc_122ED:				; CODE XREF: start+22F2j
		cmp	byte_1793E, 0FFh
		jnz	short loc_122ED
		mov	DestFrmWaitTick, 0BACh
		mov	DestFMWaitTick,	9D8h
		mov	DestMIDWaitTick, 9F6h
		call	WaitForMusic1
		jnb	short loc_1231B
		cmp	ax, 1
		jnz	short loc_12313
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_12313:				; CODE XREF: start+230Ej
		cmp	ax, 2
		jnz	short loc_1231B
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_1231B:				; CODE XREF: start+2309j start+2316j
		mov	PaletteID, 9
		mov	PalFadeStart, 0
		mov	PalFadeEnd, 100
		mov	PalFadeInc, 1
		mov	PalFade_StepDelay, 1
		mov	byte_1793F, 1
		mov	byte_1793E, 1
		mov	byte_17922, 2

loc_12347:				; CODE XREF: start+234Cj
		cmp	byte_17922, 0
		jnz	short loc_12347

loc_1234E:				; CODE XREF: start+2353j
		cmp	byte_1793E, 0FFh
		jnz	short loc_1234E
		mov	dx, 0
		call	sub_168A3
		mov	ax, 0FFFFh
		mov	si, offset aBOp_e10_gta	; "B:OP_E10.GTA"
		mov	word_1793A, 0
		mov	word_1793C, 0
		call	LoadGTA
		jnb	short loc_12375
		jmp	ErrExit_fopen
; ---------------------------------------------------------------------------

loc_12375:				; CODE XREF: start+2370j
		mov	PaletteID, 0
		call	CopyPalette
		mov	dx, 1
		call	sub_168A3
		mov	ax, 0FFFFh
		mov	si, offset aBOp_e11_gta	; "B:OP_E11.GTA"
		mov	word_1793A, 0
		mov	word_1793C, 0
		call	LoadGTA
		jnb	short loc_1239D
		jmp	ErrExit_fopen
; ---------------------------------------------------------------------------

loc_1239D:				; CODE XREF: start+2398j
		mov	PaletteID, 1
		call	CopyPalette
		mov	DestFrmWaitTick, 0EACh
		mov	DestFMWaitTick,	0C5Ah
		mov	DestMIDWaitTick, 0C78h
		call	WaitForMusic1
		jnb	short loc_123CC
		cmp	ax, 1
		jnz	short loc_123C4
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_123C4:				; CODE XREF: start+23BFj
		cmp	ax, 2
		jnz	short loc_123CC
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_123CC:				; CODE XREF: start+23BAj start+23C7j
		mov	PaletteID, 9
		mov	PalFadeStart, 100
		mov	PalFadeEnd, 0
		mov	PalFadeInc, 1
		mov	PalFade_StepDelay, 1
		mov	byte_1793F, 1
		mov	byte_1793E, 1

loc_123F3:				; CODE XREF: start+23F8j
		cmp	byte_1793E, 0FFh
		jnz	short loc_123F3
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		call	ClearPlane
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		call	ClearPlane
		mov	byte_17922, 2

loc_1240D:				; CODE XREF: start+2412j
		cmp	byte_17922, 0
		jnz	short loc_1240D
		jmp	loc_12E13
; ---------------------------------------------------------------------------

loc_12417:				; CODE XREF: start+2262j start+241Cj
		cmp	byte_1793E, 0FFh
		jnz	short loc_12417
		mov	dx, 0
		call	sub_168A3
		mov	ax, 0FFFFh
		mov	si, offset aBOp_e04_gta	; "B:OP_E04.GTA"
		mov	word_1793A, 0
		mov	word_1793C, 0
		call	LoadGTA
		jnb	short loc_1243E
		jmp	ErrExit_fopen
; ---------------------------------------------------------------------------

loc_1243E:				; CODE XREF: start+2439j
		mov	PaletteID, 3
		call	CopyPalette
		mov	DestFrmWaitTick, 0AC8h
		mov	DestFMWaitTick,	918h
		mov	DestMIDWaitTick, 936h
		call	WaitForMusic1
		jnb	short loc_1246D
		cmp	ax, 1
		jnz	short loc_12465
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_12465:				; CODE XREF: start+2460j
		cmp	ax, 2
		jnz	short loc_1246D
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_1246D:				; CODE XREF: start+245Bj start+2468j
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		call	ClearPlane
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 0
		mov	dx, 3704h
		mov	ax, 26h	; '&'
		mov	cx, 99h	; '™'
		call	sub_16909
		mov	byte_17922, 2

loc_12495:				; CODE XREF: start+249Aj
		cmp	byte_17922, 0
		jnz	short loc_12495
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		call	ClearPlane
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 28h	; '('
		mov	dx, 3704h
		mov	ax, 26h	; '&'
		mov	cx, 99h	; '™'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_124E0
		cmp	ax, 1
		jnz	short loc_124D8
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_124D8:				; CODE XREF: start+24D3j
		cmp	ax, 2
		jnz	short loc_124E0
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_124E0:				; CODE XREF: start+24CEj start+24DBj
		mov	byte_17922, 1

loc_124E5:				; CODE XREF: start+24EAj
		cmp	byte_17922, 0
		jnz	short loc_124E5
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 3E80h
		mov	dx, 3704h
		mov	ax, 26h	; '&'
		mov	cx, 99h	; '™'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_12529
		cmp	ax, 1
		jnz	short loc_12521
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_12521:				; CODE XREF: start+251Cj
		cmp	ax, 2
		jnz	short loc_12529
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_12529:				; CODE XREF: start+2517j start+2524j
		mov	byte_17922, 2

loc_1252E:				; CODE XREF: start+2533j
		cmp	byte_17922, 0
		jnz	short loc_1252E

loc_12535:				; CODE XREF: start+264Fj
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 0
		mov	dx, 3704h
		mov	ax, 26h	; '&'
		mov	cx, 99h	; '™'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_12572
		cmp	ax, 1
		jnz	short loc_1256A
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_1256A:				; CODE XREF: start+2565j
		cmp	ax, 2
		jnz	short loc_12572
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_12572:				; CODE XREF: start+2560j start+256Dj
		mov	byte_17922, 1

loc_12577:				; CODE XREF: start+257Cj
		cmp	byte_17922, 0
		jnz	short loc_12577
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 28h	; '('
		mov	dx, 3704h
		mov	ax, 26h	; '&'
		mov	cx, 99h	; '™'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_125BB
		cmp	ax, 1
		jnz	short loc_125B3
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_125B3:				; CODE XREF: start+25AEj
		cmp	ax, 2
		jnz	short loc_125BB
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_125BB:				; CODE XREF: start+25A9j start+25B6j
		mov	byte_17922, 2

loc_125C0:				; CODE XREF: start+25C5j
		cmp	byte_17922, 0
		jnz	short loc_125C0
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 3E80h
		mov	dx, 3704h
		mov	ax, 26h	; '&'
		mov	cx, 99h	; '™'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_12604
		cmp	ax, 1
		jnz	short loc_125FC
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_125FC:				; CODE XREF: start+25F7j
		cmp	ax, 2
		jnz	short loc_12604
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_12604:				; CODE XREF: start+25F2j start+25FFj
		mov	byte_17922, 1

loc_12609:				; CODE XREF: start+260Ej
		cmp	byte_17922, 0
		jnz	short loc_12609
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 3E80h
		mov	dx, 3704h
		mov	ax, 26h	; '&'
		mov	cx, 99h	; '™'
		call	sub_16909
		mov	byte_17922, 2

loc_12631:				; CODE XREF: start+2636j
		cmp	byte_17922, 0
		jnz	short loc_12631
		mov	DestFrmWaitTick, 0B22h
		mov	DestFMWaitTick,	960h
		mov	DestMIDWaitTick, 97Eh
		call	WaitForMusic2
		jb	short loc_12652
		jmp	loc_12535
; ---------------------------------------------------------------------------

loc_12652:				; CODE XREF: start+264Dj
		cmp	ax, 1
		jz	short loc_12667
		cmp	ax, 2
		jnz	short loc_1265F
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_1265F:				; CODE XREF: start+265Aj
		cmp	ax, 3
		jnz	short loc_12667
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_12667:				; CODE XREF: start+2655j start+2662j
		mov	dx, 0
		call	sub_168A3
		mov	ax, 0FFFFh
		mov	si, offset aBOp_e06_gta	; "B:OP_E06.GTA"
		mov	word_1793A, 0
		mov	word_1793C, 0
		call	LoadGTA
		jnb	short loc_12687
		jmp	ErrExit_fopen
; ---------------------------------------------------------------------------

loc_12687:				; CODE XREF: start+2682j
		mov	PaletteID, 5
		call	CopyPalette
		mov	DestFrmWaitTick, 0BACh
		mov	DestFMWaitTick,	9D8h
		mov	DestMIDWaitTick, 9F6h
		call	WaitForMusic1
		jnb	short loc_126B6
		cmp	ax, 1
		jnz	short loc_126AE
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_126AE:				; CODE XREF: start+26A9j
		cmp	ax, 2
		jnz	short loc_126B6
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_126B6:				; CODE XREF: start+26A4j start+26B1j
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 0
		mov	dx, 0C3Dh
		mov	ax, 1Dh
		mov	cx, 7Ch	; '|'
		call	sub_16909
		mov	byte_17922, 1

loc_126D7:				; CODE XREF: start+26DCj
		cmp	byte_17922, 0
		jnz	short loc_126D7
		jmp	short loc_12729
; ---------------------------------------------------------------------------

loc_126E0:				; CODE XREF: start+27FAj
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 0
		mov	dx, 0C3Dh
		mov	ax, 1Dh
		mov	cx, 7Ch	; '|'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_1271D
		cmp	ax, 1
		jnz	short loc_12715
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_12715:				; CODE XREF: start+2710j
		cmp	ax, 2
		jnz	short loc_1271D
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_1271D:				; CODE XREF: start+270Bj start+2718j
		mov	byte_17922, 1

loc_12722:				; CODE XREF: start+2727j
		cmp	byte_17922, 0
		jnz	short loc_12722

loc_12729:				; CODE XREF: start+26DEj
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 28h	; '('
		mov	dx, 0C3Dh
		mov	ax, 1Dh
		mov	cx, 7Ch	; '|'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_12766
		cmp	ax, 1
		jnz	short loc_1275E
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_1275E:				; CODE XREF: start+2759j
		cmp	ax, 2
		jnz	short loc_12766
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_12766:				; CODE XREF: start+2754j start+2761j
		mov	byte_17922, 2

loc_1276B:				; CODE XREF: start+2770j
		cmp	byte_17922, 0
		jnz	short loc_1276B
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 3E80h
		mov	dx, 0C3Dh
		mov	ax, 1Dh
		mov	cx, 7Ch	; '|'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_127AF
		cmp	ax, 1
		jnz	short loc_127A7
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_127A7:				; CODE XREF: start+27A2j
		cmp	ax, 2
		jnz	short loc_127AF
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_127AF:				; CODE XREF: start+279Dj start+27AAj
		mov	byte_17922, 1

loc_127B4:				; CODE XREF: start+27B9j
		cmp	byte_17922, 0
		jnz	short loc_127B4
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 3E80h
		mov	dx, 0C3Dh
		mov	ax, 1Dh
		mov	cx, 7Ch	; '|'
		call	sub_16909
		mov	byte_17922, 2

loc_127DC:				; CODE XREF: start+27E1j
		cmp	byte_17922, 0
		jnz	short loc_127DC
		mov	DestFrmWaitTick, 0C06h
		mov	DestFMWaitTick,	0A20h
		mov	DestMIDWaitTick, 0A3Eh
		call	WaitForMusic2
		jb	short loc_127FD
		jmp	loc_126E0
; ---------------------------------------------------------------------------

loc_127FD:				; CODE XREF: start+27F8j
		cmp	ax, 1
		jz	short loc_12812
		cmp	ax, 2
		jnz	short loc_1280A
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_1280A:				; CODE XREF: start+2805j
		cmp	ax, 3
		jnz	short loc_12812
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_12812:				; CODE XREF: start+2800j start+280Dj
		mov	dx, 0
		call	sub_168A3
		mov	ax, 0FFFFh
		mov	si, offset aBOp_e05_gta	; "B:OP_E05.GTA"
		mov	word_1793A, 0
		mov	word_1793C, 0
		call	LoadGTA
		jnb	short loc_12832
		jmp	ErrExit_fopen
; ---------------------------------------------------------------------------

loc_12832:				; CODE XREF: start+282Dj
		mov	PaletteID, 4
		call	CopyPalette
		mov	DestFrmWaitTick, 0C90h
		mov	DestFMWaitTick,	0A98h
		mov	DestMIDWaitTick, 0AB6h
		call	WaitForMusic1
		jnb	short loc_12861
		cmp	ax, 1
		jnz	short loc_12859
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_12859:				; CODE XREF: start+2854j
		cmp	ax, 2
		jnz	short loc_12861
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_12861:				; CODE XREF: start+284Fj start+285Cj
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 0
		mov	dx, 34DDh
		mov	ax, 1Ch
		mov	cx, 98h	; '˜'
		call	sub_169BD
		mov	byte_17922, 1

loc_12882:				; CODE XREF: start+2887j
		cmp	byte_17922, 0
		jnz	short loc_12882
		jmp	short loc_128D4
; ---------------------------------------------------------------------------

loc_1288B:				; CODE XREF: start+2A58j
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 0
		mov	dx, 34DDh
		mov	ax, 1Ch
		mov	cx, 98h	; '˜'
		call	sub_169BD
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_128C8
		cmp	ax, 1
		jnz	short loc_128C0
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_128C0:				; CODE XREF: start+28BBj
		cmp	ax, 2
		jnz	short loc_128C8
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_128C8:				; CODE XREF: start+28B6j start+28C3j
		mov	byte_17922, 1

loc_128CD:				; CODE XREF: start+28D2j
		cmp	byte_17922, 0
		jnz	short loc_128CD

loc_128D4:				; CODE XREF: start+2889j
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 28h	; '('
		mov	dx, 34DDh
		mov	ax, 1Ch
		mov	cx, 98h	; '˜'
		call	sub_169BD
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_12911
		cmp	ax, 1
		jnz	short loc_12909
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_12909:				; CODE XREF: start+2904j
		cmp	ax, 2
		jnz	short loc_12911
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_12911:				; CODE XREF: start+28FFj start+290Cj
		mov	byte_17922, 2

loc_12916:				; CODE XREF: start+291Bj
		cmp	byte_17922, 0
		jnz	short loc_12916
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 3E80h
		mov	dx, 34DDh
		mov	ax, 1Ch
		mov	cx, 98h	; '˜'
		call	sub_169BD
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_1295A
		cmp	ax, 1
		jnz	short loc_12952
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_12952:				; CODE XREF: start+294Dj
		cmp	ax, 2
		jnz	short loc_1295A
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_1295A:				; CODE XREF: start+2948j start+2955j
		mov	byte_17922, 1

loc_1295F:				; CODE XREF: start+2964j
		cmp	byte_17922, 0
		jnz	short loc_1295F
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 0
		mov	dx, 34DDh
		mov	ax, 1Ch
		mov	cx, 98h	; '˜'
		call	sub_169BD
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_129A3
		cmp	ax, 1
		jnz	short loc_1299B
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_1299B:				; CODE XREF: start+2996j
		cmp	ax, 2
		jnz	short loc_129A3
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_129A3:				; CODE XREF: start+2991j start+299Ej
		mov	byte_17922, 2

loc_129A8:				; CODE XREF: start+29ADj
		cmp	byte_17922, 0
		jnz	short loc_129A8
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 28h	; '('
		mov	dx, 34DDh
		mov	ax, 1Ch
		mov	cx, 98h	; '˜'
		call	sub_169BD
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_129EC
		cmp	ax, 1
		jnz	short loc_129E4
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_129E4:				; CODE XREF: start+29DFj
		cmp	ax, 2
		jnz	short loc_129EC
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_129EC:				; CODE XREF: start+29DAj start+29E7j
		mov	byte_17922, 1

loc_129F1:				; CODE XREF: start+29F6j
		cmp	byte_17922, 0
		jnz	short loc_129F1
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 3E80h
		mov	dx, 34DDh
		mov	ax, 1Ch
		mov	cx, 98h	; '˜'
		call	sub_169BD
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_12A35
		cmp	ax, 1
		jnz	short loc_12A2D
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_12A2D:				; CODE XREF: start+2A28j
		cmp	ax, 2
		jnz	short loc_12A35
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_12A35:				; CODE XREF: start+2A23j start+2A30j
		mov	byte_17922, 2

loc_12A3A:				; CODE XREF: start+2A3Fj
		cmp	byte_17922, 0
		jnz	short loc_12A3A
		mov	DestFrmWaitTick, 0D8Ch
		mov	DestFMWaitTick,	0B70h
		mov	DestMIDWaitTick, 0B8Eh
		call	WaitForMusic2
		jb	short loc_12A5B
		jmp	loc_1288B
; ---------------------------------------------------------------------------

loc_12A5B:				; CODE XREF: start+2A56j
		cmp	ax, 1
		jz	short loc_12A70
		cmp	ax, 2
		jnz	short loc_12A68
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_12A68:				; CODE XREF: start+2A63j
		cmp	ax, 3
		jnz	short loc_12A70
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_12A70:				; CODE XREF: start+2A5Ej start+2A6Bj
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 3E80h
		mov	dx, 34DDh
		mov	ax, 1Ch
		mov	cx, 98h	; '˜'
		call	sub_169BD
		mov	dx, 0
		call	sub_168A3
		mov	ax, 0FFFFh
		mov	si, offset aBOp_e07_gta	; "B:OP_E07.GTA"
		mov	word_1793A, 0
		mov	word_1793C, 0
		call	LoadGTA
		jnb	short loc_12AAC
		jmp	ErrExit_fopen
; ---------------------------------------------------------------------------

loc_12AAC:				; CODE XREF: start+2AA7j
		mov	PaletteID, 0
		call	CopyPalette
		mov	dx, 1
		call	sub_168A3
		mov	ax, 0FFFFh
		mov	si, offset aBOp_e08_gta	; "B:OP_E08.GTA"
		mov	word_1793A, 0
		mov	word_1793C, 0
		call	LoadGTA
		jnb	short loc_12AD4
		jmp	ErrExit_fopen
; ---------------------------------------------------------------------------

loc_12AD4:				; CODE XREF: start+2ACFj
		mov	PaletteID, 1
		call	CopyPalette
		mov	dx, 2
		call	sub_168A3
		mov	ax, 0FFFFh
		mov	si, offset aBOp_e09_gta	; "B:OP_E09.GTA"
		mov	word_1793A, 0
		mov	word_1793C, 0
		call	LoadGTA
		jnb	short loc_12AFC
		jmp	ErrExit_fopen
; ---------------------------------------------------------------------------

loc_12AFC:				; CODE XREF: start+2AF7j
		mov	PaletteID, 2
		call	CopyPalette
		mov	DestFrmWaitTick, 0E28h
		mov	DestFMWaitTick,	0BE8h
		mov	DestMIDWaitTick, 0C06h
		call	WaitForMusic1
		jnb	short loc_12B2B
		cmp	ax, 1
		jnz	short loc_12B23
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_12B23:				; CODE XREF: start+2B1Ej
		cmp	ax, 2
		jnz	short loc_12B2B
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_12B2B:				; CODE XREF: start+2B19j start+2B26j
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 0
		mov	dx, 0B6Ah
		mov	ax, 17h
		mov	cx, 125h
		call	sub_16909
		mov	byte_17922, 1

loc_12B4C:				; CODE XREF: start+2B51j
		cmp	byte_17922, 0
		jnz	short loc_12B4C
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 19h
		mov	dx, 0B6Ah
		mov	ax, 17h
		mov	cx, 125h
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 13h
		call	WaitFrames2
		jnb	short loc_12B90
		cmp	ax, 1
		jnz	short loc_12B88
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_12B88:				; CODE XREF: start+2B83j
		cmp	ax, 2
		jnz	short loc_12B90
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_12B90:				; CODE XREF: start+2B7Ej start+2B8Bj
		mov	byte_17922, 2

loc_12B95:				; CODE XREF: start+2B9Aj
		cmp	byte_17922, 0
		jnz	short loc_12B95
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 32h	; '2'
		mov	dx, 0B6Ah
		mov	ax, 17h
		mov	cx, 125h
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 13h
		call	WaitFrames2
		jnb	short loc_12BD9
		cmp	ax, 1
		jnz	short loc_12BD1
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_12BD1:				; CODE XREF: start+2BCCj
		cmp	ax, 2
		jnz	short loc_12BD9
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_12BD9:				; CODE XREF: start+2BC7j start+2BD4j
		mov	byte_17922, 1

loc_12BDE:				; CODE XREF: start+2BE3j
		cmp	byte_17922, 0
		jnz	short loc_12BDE
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 1
		call	sub_168CE
		mov	bx, 0
		mov	dx, 0B6Ah
		mov	ax, 17h
		mov	cx, 125h
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 13h
		call	WaitFrames2
		jnb	short loc_12C22
		cmp	ax, 1
		jnz	short loc_12C1A
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_12C1A:				; CODE XREF: start+2C15j
		cmp	ax, 2
		jnz	short loc_12C22
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_12C22:				; CODE XREF: start+2C10j start+2C1Dj
		mov	byte_17922, 2

loc_12C27:				; CODE XREF: start+2C2Cj
		cmp	byte_17922, 0
		jnz	short loc_12C27
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 1
		call	sub_168CE
		mov	bx, 19h
		mov	dx, 0B6Ah
		mov	ax, 17h
		mov	cx, 125h
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 13h
		call	WaitFrames2
		jnb	short loc_12C6B
		cmp	ax, 1
		jnz	short loc_12C63
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_12C63:				; CODE XREF: start+2C5Ej
		cmp	ax, 2
		jnz	short loc_12C6B
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_12C6B:				; CODE XREF: start+2C59j start+2C66j
		mov	byte_17922, 1

loc_12C70:				; CODE XREF: start+2C75j
		cmp	byte_17922, 0
		jnz	short loc_12C70
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 1
		call	sub_168CE
		mov	bx, 32h	; '2'
		mov	dx, 0B6Ah
		mov	ax, 17h
		mov	cx, 125h
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 13h
		call	WaitFrames2
		jnb	short loc_12CB4
		cmp	ax, 1
		jnz	short loc_12CAC
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_12CAC:				; CODE XREF: start+2CA7j
		cmp	ax, 2
		jnz	short loc_12CB4
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_12CB4:				; CODE XREF: start+2CA2j start+2CAFj
		mov	byte_17922, 2

loc_12CB9:				; CODE XREF: start+2CBEj
		cmp	byte_17922, 0
		jnz	short loc_12CB9
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 2
		call	sub_168CE
		mov	bx, 0
		mov	dx, 0B6Ah
		mov	ax, 17h
		mov	cx, 125h
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 13h
		call	WaitFrames2
		jnb	short loc_12CFD
		cmp	ax, 1
		jnz	short loc_12CF5
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_12CF5:				; CODE XREF: start+2CF0j
		cmp	ax, 2
		jnz	short loc_12CFD
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_12CFD:				; CODE XREF: start+2CEBj start+2CF8j
		mov	byte_17922, 1

loc_12D02:				; CODE XREF: start+2D07j
		cmp	byte_17922, 0
		jnz	short loc_12D02
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 2
		call	sub_168CE
		mov	bx, 19h
		mov	dx, 0B6Ah
		mov	ax, 17h
		mov	cx, 125h
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 13h
		call	WaitFrames2
		jnb	short loc_12D46
		cmp	ax, 1
		jnz	short loc_12D3E
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_12D3E:				; CODE XREF: start+2D39j
		cmp	ax, 2
		jnz	short loc_12D46
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_12D46:				; CODE XREF: start+2D34j start+2D41j
		mov	byte_17922, 2

loc_12D4B:				; CODE XREF: start+2D50j
		cmp	byte_17922, 0
		jnz	short loc_12D4B
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 2
		call	sub_168CE
		mov	bx, 32h	; '2'
		mov	dx, 0B6Ah
		mov	ax, 17h
		mov	cx, 125h
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 13h
		call	WaitFrames2
		jnb	short loc_12D8F
		cmp	ax, 1
		jnz	short loc_12D87
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_12D87:				; CODE XREF: start+2D82j
		cmp	ax, 2
		jnz	short loc_12D8F
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_12D8F:				; CODE XREF: start+2D7Dj start+2D8Aj
		mov	byte_17922, 1

loc_12D94:				; CODE XREF: start+2D99j
		cmp	byte_17922, 0
		jnz	short loc_12D94
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 2
		call	sub_168CE
		mov	bx, 32h	; '2'
		mov	dx, 0B6Ah
		mov	ax, 17h
		mov	cx, 125h
		call	sub_16909
		mov	byte_17922, 2

loc_12DBC:				; CODE XREF: start+2DC1j
		cmp	byte_17922, 0
		jnz	short loc_12DBC
		mov	dx, 0
		call	sub_168A3
		mov	ax, 0FFFFh
		mov	si, offset aBOp_e10_gta	; "B:OP_E10.GTA"
		mov	word_1793A, 0
		mov	word_1793C, 0
		call	LoadGTA
		jnb	short loc_12DE3
		jmp	ErrExit_fopen
; ---------------------------------------------------------------------------

loc_12DE3:				; CODE XREF: start+2DDEj
		mov	PaletteID, 0
		call	CopyPalette
		mov	dx, 1
		call	sub_168A3
		mov	ax, 0FFFFh
		mov	si, offset aBOp_e11_gta	; "B:OP_E11.GTA"
		mov	word_1793A, 0
		mov	word_1793C, 0
		call	LoadGTA
		jnb	short loc_12E0B
		jmp	ErrExit_fopen
; ---------------------------------------------------------------------------

loc_12E0B:				; CODE XREF: start+2E06j
		mov	PaletteID, 1
		call	CopyPalette

loc_12E13:				; CODE XREF: start+2414j
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		call	ClearPlane
		mov	DestFrmWaitTick, 0F96h
		mov	DestFMWaitTick,	0D20h
		mov	DestMIDWaitTick, 0D3Eh
		call	WaitForMusic1
		jnb	short loc_12E41
		cmp	ax, 1
		jnz	short loc_12E39
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_12E39:				; CODE XREF: start+2E34j
		cmp	ax, 2
		jnz	short loc_12E41
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_12E41:				; CODE XREF: start+2E2Fj start+2E3Cj
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	PaletteID, 0
		mov	PalFadeStart, 100
		mov	byte_1793F, 0
		mov	byte_1793E, 1
		call	WaitForVSync
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 0
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	byte_17922, 1

loc_12E7A:				; CODE XREF: start+2E7Fj
		cmp	byte_17922, 0
		jnz	short loc_12E7A
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		call	ClearPlane
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 28h	; '('
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 13h
		call	WaitFrames2
		jnb	short loc_12EC5
		cmp	ax, 1
		jnz	short loc_12EBD
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_12EBD:				; CODE XREF: start+2EB8j
		cmp	ax, 2
		jnz	short loc_12EC5
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_12EC5:				; CODE XREF: start+2EB3j start+2EC0j
		mov	byte_17922, 2

loc_12ECA:				; CODE XREF: start+2ECFj
		cmp	byte_17922, 0
		jnz	short loc_12ECA
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 3E80h
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 13h
		call	WaitFrames2
		jnb	short loc_12F0E
		cmp	ax, 1
		jnz	short loc_12F06
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_12F06:				; CODE XREF: start+2F01j
		cmp	ax, 2
		jnz	short loc_12F0E
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_12F0E:				; CODE XREF: start+2EFCj start+2F09j
		mov	byte_17922, 1

loc_12F13:				; CODE XREF: start+2F18j
		cmp	byte_17922, 0
		jnz	short loc_12F13
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 3EA8h
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 13h
		call	WaitFrames2
		jnb	short loc_12F57
		cmp	ax, 1
		jnz	short loc_12F4F
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_12F4F:				; CODE XREF: start+2F4Aj
		cmp	ax, 2
		jnz	short loc_12F57
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_12F57:				; CODE XREF: start+2F45j start+2F52j
		mov	byte_17922, 2

loc_12F5C:				; CODE XREF: start+2F61j
		cmp	byte_17922, 0
		jnz	short loc_12F5C
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 1
		call	sub_168CE
		mov	bx, 0
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 13h
		call	WaitFrames2
		jnb	short loc_12FA0
		cmp	ax, 1
		jnz	short loc_12F98
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_12F98:				; CODE XREF: start+2F93j
		cmp	ax, 2
		jnz	short loc_12FA0
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_12FA0:				; CODE XREF: start+2F8Ej start+2F9Bj
		mov	byte_17922, 1

loc_12FA5:				; CODE XREF: start+2FAAj
		cmp	byte_17922, 0
		jnz	short loc_12FA5
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 1
		call	sub_168CE
		mov	bx, 0
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	byte_17922, 2

loc_12FCD:				; CODE XREF: start+2FD2j
		cmp	byte_17922, 0
		jnz	short loc_12FCD
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 1
		call	sub_168CE
		mov	bx, 3E80h
		mov	dx, 5DC0h
		mov	ax, 50h	; 'P'
		mov	cx, 32h	; '2'
		call	sub_169BD
		mov	DestFrmWaitTick, 1020h
		mov	DestFMWaitTick,	0D98h
		mov	DestMIDWaitTick, 0DB6h
		call	WaitForMusic1
		jnb	short loc_13017
		cmp	ax, 1
		jnz	short loc_1300F
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_1300F:				; CODE XREF: start+300Aj
		cmp	ax, 2
		jnz	short loc_13017
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_13017:				; CODE XREF: start+3005j start+3012j
		mov	byte_17922, 1

loc_1301C:				; CODE XREF: start+3021j
		cmp	byte_17922, 0
		jnz	short loc_1301C
		mov	dx, 0
		call	sub_168A3
		mov	ax, 0FFFFh
		mov	si, offset aBOp_t01_gta	; "B:OP_T01.GTA"
		mov	word_1793A, 0
		mov	word_1793C, 0
		call	LoadGTA
		jnb	short loc_13043
		jmp	ErrExit_fopen
; ---------------------------------------------------------------------------

loc_13043:				; CODE XREF: start+303Ej
		mov	PaletteID, 0
		call	CopyPalette
		mov	dx, 1
		call	sub_168A3
		mov	ax, 0FFFFh
		mov	si, offset aBOp_t02_gta	; "B:OP_T02.GTA"
		mov	word_1793A, 0
		mov	word_1793C, 0
		call	LoadGTA
		jnb	short loc_1306B
		jmp	ErrExit_fopen
; ---------------------------------------------------------------------------

loc_1306B:				; CODE XREF: start+3066j
		mov	PaletteID, 1
		call	CopyPalette
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		call	ClearPlane
		mov	DestFrmWaitTick, 1104h
		mov	DestFMWaitTick,	0E58h
		mov	DestMIDWaitTick, 0E76h
		call	WaitForMusic1
		jnb	short loc_130A1
		cmp	ax, 1
		jnz	short loc_13099
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_13099:				; CODE XREF: start+3094j
		cmp	ax, 2
		jnz	short loc_130A1
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_130A1:				; CODE XREF: start+308Fj start+309Cj
		mov	PaletteID, 0
		mov	PalFadeStart, 0
		mov	byte_1793F, 0
		mov	byte_1793E, 1
		call	WaitForVSync
		call	WaitForVSync
		call	WaitForVSync
		call	WaitForVSync
		call	WaitForVSync
		mov	PaletteID, 0
		mov	PalFadeStart, 0
		mov	PalFadeEnd, 100
		mov	PalFadeInc, 1
		mov	PalFade_StepDelay, 1
		mov	byte_1793F, 1
		mov	byte_1793E, 1
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 0
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	byte_17922, 2

loc_1310D:				; CODE XREF: start+3112j
		cmp	byte_17922, 0
		jnz	short loc_1310D
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		call	ClearPlane
		mov	FrameCounter, 0
		mov	FramesToWait, 0Fh
		call	WaitFrames2
		jnb	short loc_1313C
		cmp	ax, 1
		jnz	short loc_13134
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_13134:				; CODE XREF: start+312Fj
		cmp	ax, 2
		jnz	short loc_1313C
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_1313C:				; CODE XREF: start+312Aj start+3137j
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 28h	; '('
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_13179
		cmp	ax, 1
		jnz	short loc_13171
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_13171:				; CODE XREF: start+316Cj
		cmp	ax, 2
		jnz	short loc_13179
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_13179:				; CODE XREF: start+3167j start+3174j
		mov	byte_17922, 1

loc_1317E:				; CODE XREF: start+3183j
		cmp	byte_17922, 0
		jnz	short loc_1317E
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 3E80h
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_131C2
		cmp	ax, 1
		jnz	short loc_131BA
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_131BA:				; CODE XREF: start+31B5j
		cmp	ax, 2
		jnz	short loc_131C2
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_131C2:				; CODE XREF: start+31B0j start+31BDj
		mov	byte_17922, 2

loc_131C7:				; CODE XREF: start+31CCj
		cmp	byte_17922, 0
		jnz	short loc_131C7

loc_131CE:				; CODE XREF: start+339Bj
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 3EA8h
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_1320B
		cmp	ax, 1
		jnz	short loc_13203
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_13203:				; CODE XREF: start+31FEj
		cmp	ax, 2
		jnz	short loc_1320B
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_1320B:				; CODE XREF: start+31F9j start+3206j
		mov	byte_17922, 1

loc_13210:				; CODE XREF: start+3215j
		cmp	byte_17922, 0
		jnz	short loc_13210
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 1
		call	sub_168CE
		mov	bx, 0
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_13254
		cmp	ax, 1
		jnz	short loc_1324C
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_1324C:				; CODE XREF: start+3247j
		cmp	ax, 2
		jnz	short loc_13254
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_13254:				; CODE XREF: start+3242j start+324Fj
		mov	byte_17922, 2

loc_13259:				; CODE XREF: start+325Ej
		cmp	byte_17922, 0
		jnz	short loc_13259
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 1
		call	sub_168CE
		mov	bx, 28h	; '('
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_1329D
		cmp	ax, 1
		jnz	short loc_13295
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_13295:				; CODE XREF: start+3290j
		cmp	ax, 2
		jnz	short loc_1329D
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_1329D:				; CODE XREF: start+328Bj start+3298j
		mov	byte_17922, 1

loc_132A2:				; CODE XREF: start+32A7j
		cmp	byte_17922, 0
		jnz	short loc_132A2
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 3EA8h
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_132E6
		cmp	ax, 1
		jnz	short loc_132DE
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_132DE:				; CODE XREF: start+32D9j
		cmp	ax, 2
		jnz	short loc_132E6
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_132E6:				; CODE XREF: start+32D4j start+32E1j
		mov	byte_17922, 2

loc_132EB:				; CODE XREF: start+32F0j
		cmp	byte_17922, 0
		jnz	short loc_132EB
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 1
		call	sub_168CE
		mov	bx, 0
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_1332F
		cmp	ax, 1
		jnz	short loc_13327
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_13327:				; CODE XREF: start+3322j
		cmp	ax, 2
		jnz	short loc_1332F
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_1332F:				; CODE XREF: start+331Dj start+332Aj
		mov	byte_17922, 1

loc_13334:				; CODE XREF: start+3339j
		cmp	byte_17922, 0
		jnz	short loc_13334
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 1
		call	sub_168CE
		mov	bx, 28h	; '('
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_13378
		cmp	ax, 1
		jnz	short loc_13370
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_13370:				; CODE XREF: start+336Bj
		cmp	ax, 2
		jnz	short loc_13378
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_13378:				; CODE XREF: start+3366j start+3373j
		mov	byte_17922, 2

loc_1337D:				; CODE XREF: start+3382j
		cmp	byte_17922, 0
		jnz	short loc_1337D
		mov	DestFrmWaitTick, 1242h
		mov	DestFMWaitTick,	0F60h
		mov	DestMIDWaitTick, 0F7Eh
		call	WaitForMusic2
		jb	short loc_1339E
		jmp	loc_131CE
; ---------------------------------------------------------------------------

loc_1339E:				; CODE XREF: start+3399j
		cmp	ax, 1
		jz	short loc_133B3
		cmp	ax, 2
		jnz	short loc_133AB
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_133AB:				; CODE XREF: start+33A6j
		cmp	ax, 3
		jnz	short loc_133B3
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_133B3:				; CODE XREF: start+33A1j start+33AEj
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 1
		call	sub_168CE
		mov	bx, 28h	; '('
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	byte_17922, 1

loc_133D4:				; CODE XREF: start+33D9j
		cmp	byte_17922, 0
		jnz	short loc_133D4
		cmp	byte_1757E, 1
		jnz	short loc_133EC
		cmp	byte_17902, 1
		jnz	short loc_133EC
		jmp	loc_135C6
; ---------------------------------------------------------------------------

loc_133EC:				; CODE XREF: start+33E0j start+33E7j
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		call	ClearPlane
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A

loc_133F7:				; CODE XREF: start+33FCj
		cmp	byte_1793E, 0FFh
		jnz	short loc_133F7
		mov	dx, 0FFFFh
		call	sub_168A3
		mov	ax, 0FFFFh
		mov	si, offset aBOp_t00_gta	; "B:OP_T00.GTA"
		mov	word_1793A, 0
		mov	word_1793C, 0
		call	LoadGTA
		jnb	short loc_1341E
		jmp	ErrExit_fopen
; ---------------------------------------------------------------------------

loc_1341E:				; CODE XREF: start+3419j
		mov	PaletteID, 9
		call	CopyPalette
		mov	DestFrmWaitTick, 12CCh
		mov	DestFMWaitTick,	0FD8h
		mov	DestMIDWaitTick, 0FF6h
		call	WaitForMusic1
		jnb	short loc_1344D
		cmp	ax, 1
		jnz	short loc_13445
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_13445:				; CODE XREF: start+3440j
		cmp	ax, 2
		jnz	short loc_1344D
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_1344D:				; CODE XREF: start+343Bj start+3448j
		mov	PaletteID, 0
		mov	PalFadeStart, 100
		mov	PalFadeEnd, 0
		mov	PalFadeInc, 1
		mov	PalFade_StepDelay, 1
		mov	byte_1793F, 1
		mov	byte_1793E, 1

loc_13474:				; CODE XREF: start+3479j
		cmp	byte_1793E, 0FFh
		jnz	short loc_13474
		mov	DestFrmWaitTick, 13B0h
		mov	DestFMWaitTick,	1098h
		mov	DestMIDWaitTick, 10B6h
		call	WaitForMusic1
		jnb	short loc_134A2
		cmp	ax, 1
		jnz	short loc_1349A
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_1349A:				; CODE XREF: start+3495j
		cmp	ax, 2
		jnz	short loc_134A2
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_134A2:				; CODE XREF: start+3490j start+349Dj
		mov	PaletteID, 9
		mov	PalFadeStart, 0
		mov	PalFadeEnd, 100
		mov	PalFadeInc, 1
		mov	PalFade_StepDelay, 1
		mov	byte_1793F, 1
		mov	byte_1793E, 1
		mov	byte_17922, 2

loc_134CE:				; CODE XREF: start+34D3j
		cmp	byte_17922, 0
		jnz	short loc_134CE

loc_134D5:				; CODE XREF: start+34DAj
		cmp	byte_1793E, 0FFh
		jnz	short loc_134D5
		mov	dx, 0
		call	sub_168A3
		mov	ax, 0FFFFh
		mov	si, offset aBOp_t12_gta	; "B:OP_T12.GTA"
		mov	word_1793A, 0
		mov	word_1793C, 0
		call	LoadGTA
		jnb	short loc_134FC
		jmp	ErrExit_fopen
; ---------------------------------------------------------------------------

loc_134FC:				; CODE XREF: start+34F7j
		mov	PaletteID, 0
		call	CopyPalette
		mov	dx, 1
		call	sub_168A3
		mov	ax, 0FFFFh
		mov	si, offset aBOp_t13_gta	; "B:OP_T13.GTA"
		mov	word_1793A, 0
		mov	word_1793C, 0
		call	LoadGTA
		jnb	short loc_13524
		jmp	ErrExit_fopen
; ---------------------------------------------------------------------------

loc_13524:				; CODE XREF: start+351Fj
		mov	PaletteID, 1
		call	CopyPalette
		mov	dx, 2
		call	sub_168A3
		mov	ax, 0FFFFh
		mov	si, offset aBOp_t14_gta	; "B:OP_T14.GTA"
		mov	word_1793A, 0
		mov	word_1793C, 0
		call	LoadGTA
		jnb	short loc_1354C
		jmp	ErrExit_fopen
; ---------------------------------------------------------------------------

loc_1354C:				; CODE XREF: start+3547j
		mov	PaletteID, 2
		call	CopyPalette
		mov	DestFrmWaitTick, 15D2h
		mov	DestFMWaitTick,	1260h
		mov	DestMIDWaitTick, 127Eh
		call	WaitForMusic1
		jnb	short loc_1357B
		cmp	ax, 1
		jnz	short loc_13573
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_13573:				; CODE XREF: start+356Ej
		cmp	ax, 2
		jnz	short loc_1357B
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_1357B:				; CODE XREF: start+3569j start+3576j
		mov	PaletteID, 9
		mov	PalFadeStart, 100
		mov	PalFadeEnd, 0
		mov	PalFadeInc, 1
		mov	PalFade_StepDelay, 1
		mov	byte_1793F, 1
		mov	byte_1793E, 1

loc_135A2:				; CODE XREF: start+35A7j
		cmp	byte_1793E, 0FFh
		jnz	short loc_135A2
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		call	ClearPlane
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		call	ClearPlane
		mov	byte_17922, 2

loc_135BC:				; CODE XREF: start+35C1j
		cmp	byte_17922, 0
		jnz	short loc_135BC
		jmp	loc_14429
; ---------------------------------------------------------------------------

loc_135C6:				; CODE XREF: start+33E9j start+35CBj
		cmp	byte_1793E, 0FFh
		jnz	short loc_135C6
		mov	dx, 0
		call	sub_168A3
		mov	ax, 0FFFFh
		mov	si, offset aBOp_t05_gta	; "B:OP_T05.GTA"
		mov	word_1793A, 0
		mov	word_1793C, 0
		call	LoadGTA
		jnb	short loc_135ED
		jmp	ErrExit_fopen
; ---------------------------------------------------------------------------

loc_135ED:				; CODE XREF: start+35E8j
		mov	PaletteID, 0
		call	CopyPalette
		mov	dx, 1
		call	sub_168A3
		mov	ax, 0FFFFh
		mov	si, offset aBOp_t06_gta	; "B:OP_T06.GTA"
		mov	word_1793A, 0
		mov	word_1793C, 0
		call	LoadGTA
		jnb	short loc_13615
		jmp	ErrExit_fopen
; ---------------------------------------------------------------------------

loc_13615:				; CODE XREF: start+3610j
		mov	PaletteID, 1
		call	CopyPalette
		mov	DestFrmWaitTick, 12CCh
		mov	DestFMWaitTick,	0FD8h
		mov	DestMIDWaitTick, 0FF6h
		call	WaitForMusic1
		jnb	short loc_13644
		cmp	ax, 1
		jnz	short loc_1363C
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_1363C:				; CODE XREF: start+3637j
		cmp	ax, 2
		jnz	short loc_13644
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_13644:				; CODE XREF: start+3632j start+363Fj
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		call	ClearPlane
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 0
		mov	dx, 0B4Eh
		mov	ax, 1Bh
		mov	cx, 83h	; 'ƒ'
		call	sub_16909
		mov	byte_17922, 2

loc_1366C:				; CODE XREF: start+3671j
		cmp	byte_17922, 0
		jnz	short loc_1366C
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		call	ClearPlane
		jmp	short loc_136C5
; ---------------------------------------------------------------------------

loc_1367C:				; CODE XREF: start+396Dj
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 0
		mov	dx, 0B4Eh
		mov	ax, 1Bh
		mov	cx, 83h	; 'ƒ'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_136B9
		cmp	ax, 1
		jnz	short loc_136B1
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_136B1:				; CODE XREF: start+36ACj
		cmp	ax, 2
		jnz	short loc_136B9
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_136B9:				; CODE XREF: start+36A7j start+36B4j
		mov	byte_17922, 2

loc_136BE:				; CODE XREF: start+36C3j
		cmp	byte_17922, 0
		jnz	short loc_136BE

loc_136C5:				; CODE XREF: start+367Aj
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 28h	; '('
		mov	dx, 0B4Eh
		mov	ax, 1Bh
		mov	cx, 83h	; 'ƒ'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_13702
		cmp	ax, 1
		jnz	short loc_136FA
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_136FA:				; CODE XREF: start+36F5j
		cmp	ax, 2
		jnz	short loc_13702
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_13702:				; CODE XREF: start+36F0j start+36FDj
		mov	byte_17922, 1

loc_13707:				; CODE XREF: start+370Cj
		cmp	byte_17922, 0
		jnz	short loc_13707
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 3E80h
		mov	dx, 0B4Eh
		mov	ax, 1Bh
		mov	cx, 83h	; 'ƒ'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_1374B
		cmp	ax, 1
		jnz	short loc_13743
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_13743:				; CODE XREF: start+373Ej
		cmp	ax, 2
		jnz	short loc_1374B
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_1374B:				; CODE XREF: start+3739j start+3746j
		mov	byte_17922, 2

loc_13750:				; CODE XREF: start+3755j
		cmp	byte_17922, 0
		jnz	short loc_13750
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 3EA8h
		mov	dx, 0B4Eh
		mov	ax, 1Bh
		mov	cx, 83h	; 'ƒ'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_13794
		cmp	ax, 1
		jnz	short loc_1378C
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_1378C:				; CODE XREF: start+3787j
		cmp	ax, 2
		jnz	short loc_13794
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_13794:				; CODE XREF: start+3782j start+378Fj
		mov	byte_17922, 1

loc_13799:				; CODE XREF: start+379Ej
		cmp	byte_17922, 0
		jnz	short loc_13799
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 1
		call	sub_168CE
		mov	bx, 0
		mov	dx, 0B4Eh
		mov	ax, 1Bh
		mov	cx, 83h	; 'ƒ'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_137DD
		cmp	ax, 1
		jnz	short loc_137D5
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_137D5:				; CODE XREF: start+37D0j
		cmp	ax, 2
		jnz	short loc_137DD
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_137DD:				; CODE XREF: start+37CBj start+37D8j
		mov	byte_17922, 2

loc_137E2:				; CODE XREF: start+37E7j
		cmp	byte_17922, 0
		jnz	short loc_137E2
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 0
		mov	dx, 0B4Eh
		mov	ax, 1Bh
		mov	cx, 83h	; 'ƒ'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_13826
		cmp	ax, 1
		jnz	short loc_1381E
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_1381E:				; CODE XREF: start+3819j
		cmp	ax, 2
		jnz	short loc_13826
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_13826:				; CODE XREF: start+3814j start+3821j
		mov	byte_17922, 1

loc_1382B:				; CODE XREF: start+3830j
		cmp	byte_17922, 0
		jnz	short loc_1382B
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 28h	; '('
		mov	dx, 0B4Eh
		mov	ax, 1Bh
		mov	cx, 83h	; 'ƒ'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_1386F
		cmp	ax, 1
		jnz	short loc_13867
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_13867:				; CODE XREF: start+3862j
		cmp	ax, 2
		jnz	short loc_1386F
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_1386F:				; CODE XREF: start+385Dj start+386Aj
		mov	byte_17922, 2

loc_13874:				; CODE XREF: start+3879j
		cmp	byte_17922, 0
		jnz	short loc_13874
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 3E80h
		mov	dx, 0B4Eh
		mov	ax, 1Bh
		mov	cx, 83h	; 'ƒ'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_138B8
		cmp	ax, 1
		jnz	short loc_138B0
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_138B0:				; CODE XREF: start+38ABj
		cmp	ax, 2
		jnz	short loc_138B8
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_138B8:				; CODE XREF: start+38A6j start+38B3j
		mov	byte_17922, 1

loc_138BD:				; CODE XREF: start+38C2j
		cmp	byte_17922, 0
		jnz	short loc_138BD
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 3EA8h
		mov	dx, 0B4Eh
		mov	ax, 1Bh
		mov	cx, 83h	; 'ƒ'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_13901
		cmp	ax, 1
		jnz	short loc_138F9
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_138F9:				; CODE XREF: start+38F4j
		cmp	ax, 2
		jnz	short loc_13901
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_13901:				; CODE XREF: start+38EFj start+38FCj
		mov	byte_17922, 2

loc_13906:				; CODE XREF: start+390Bj
		cmp	byte_17922, 0
		jnz	short loc_13906
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 1
		call	sub_168CE
		mov	bx, 0
		mov	dx, 0B4Eh
		mov	ax, 1Bh
		mov	cx, 83h	; 'ƒ'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_1394A
		cmp	ax, 1
		jnz	short loc_13942
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_13942:				; CODE XREF: start+393Dj
		cmp	ax, 2
		jnz	short loc_1394A
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_1394A:				; CODE XREF: start+3938j start+3945j
		mov	byte_17922, 1

loc_1394F:				; CODE XREF: start+3954j
		cmp	byte_17922, 0
		jnz	short loc_1394F
		mov	DestFrmWaitTick, 133Eh
		mov	DestFMWaitTick,	1038h
		mov	DestMIDWaitTick, 1056h
		call	WaitForMusic2
		jb	short loc_13970
		jmp	loc_1367C
; ---------------------------------------------------------------------------

loc_13970:				; CODE XREF: start+396Bj
		cmp	ax, 1
		jz	short loc_13985
		cmp	ax, 2
		jnz	short loc_1397D
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_1397D:				; CODE XREF: start+3978j
		cmp	ax, 3
		jnz	short loc_13985
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_13985:				; CODE XREF: start+3973j start+3980j
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 1
		call	sub_168CE
		mov	bx, 0
		mov	dx, 0B4Eh
		mov	ax, 1Bh
		mov	cx, 83h	; 'ƒ'
		call	sub_16909
		mov	dx, 0
		call	sub_168A3
		mov	ax, 0FFFFh
		mov	si, offset aBOp_t03_gta	; "B:OP_T03.GTA"
		mov	word_1793A, 0
		mov	word_1793C, 0
		call	LoadGTA
		jnb	short loc_139C1
		jmp	ErrExit_fopen
; ---------------------------------------------------------------------------

loc_139C1:				; CODE XREF: start+39BCj
		mov	PaletteID, 0
		call	CopyPalette
		mov	DestFrmWaitTick, 13B0h
		mov	DestFMWaitTick,	1098h
		mov	DestMIDWaitTick, 10B6h
		call	WaitForMusic1
		jnb	short loc_139F0
		cmp	ax, 1
		jnz	short loc_139E8
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_139E8:				; CODE XREF: start+39E3j
		cmp	ax, 2
		jnz	short loc_139F0
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_139F0:				; CODE XREF: start+39DEj start+39EBj
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 0
		mov	dx, 0CDDh
		mov	ax, 1Ch
		mov	cx, 0AFh ; '¯'
		call	sub_169BD
		mov	byte_17922, 2

loc_13A11:				; CODE XREF: start+3A16j
		cmp	byte_17922, 0
		jnz	short loc_13A11
		jmp	short loc_13A63
; ---------------------------------------------------------------------------

loc_13A1A:				; CODE XREF: start+3B55j
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 0
		mov	dx, 0CDDh
		mov	ax, 1Ch
		mov	cx, 0AFh ; '¯'
		call	sub_169BD
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_13A57
		cmp	ax, 1
		jnz	short loc_13A4F
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_13A4F:				; CODE XREF: start+3A4Aj
		cmp	ax, 2
		jnz	short loc_13A57
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_13A57:				; CODE XREF: start+3A45j start+3A52j
		mov	byte_17922, 2

loc_13A5C:				; CODE XREF: start+3A61j
		cmp	byte_17922, 0
		jnz	short loc_13A5C

loc_13A63:				; CODE XREF: start+3A18j
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 3E80h
		mov	dx, 0CDDh
		mov	ax, 1Ch
		mov	cx, 0AFh ; '¯'
		call	sub_169BD
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_13AA0
		cmp	ax, 1
		jnz	short loc_13A98
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_13A98:				; CODE XREF: start+3A93j
		cmp	ax, 2
		jnz	short loc_13AA0
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_13AA0:				; CODE XREF: start+3A8Ej start+3A9Bj
		mov	byte_17922, 1

loc_13AA5:				; CODE XREF: start+3AAAj
		cmp	byte_17922, 0
		jnz	short loc_13AA5
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 3EA8h
		mov	dx, 0CDDh
		mov	ax, 1Ch
		mov	cx, 0AFh ; '¯'
		call	sub_169BD
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_13AE9
		cmp	ax, 1
		jnz	short loc_13AE1
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_13AE1:				; CODE XREF: start+3ADCj
		cmp	ax, 2
		jnz	short loc_13AE9
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_13AE9:				; CODE XREF: start+3AD7j start+3AE4j
		mov	byte_17922, 2

loc_13AEE:				; CODE XREF: start+3AF3j
		cmp	byte_17922, 0
		jnz	short loc_13AEE
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 28h	; '('
		mov	dx, 0CDDh
		mov	ax, 1Ch
		mov	cx, 0AFh ; '¯'
		call	sub_169BD
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_13B32
		cmp	ax, 1
		jnz	short loc_13B2A
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_13B2A:				; CODE XREF: start+3B25j
		cmp	ax, 2
		jnz	short loc_13B32
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_13B32:				; CODE XREF: start+3B20j start+3B2Dj
		mov	byte_17922, 1

loc_13B37:				; CODE XREF: start+3B3Cj
		cmp	byte_17922, 0
		jnz	short loc_13B37
		mov	DestFrmWaitTick, 1464h
		mov	DestFMWaitTick,	1128h
		mov	DestMIDWaitTick, 1146h
		call	WaitForMusic2
		jb	short loc_13B58
		jmp	loc_13A1A
; ---------------------------------------------------------------------------

loc_13B58:				; CODE XREF: start+3B53j
		cmp	ax, 1
		jz	short loc_13B6D
		cmp	ax, 2
		jnz	short loc_13B65
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_13B65:				; CODE XREF: start+3B60j
		cmp	ax, 3
		jnz	short loc_13B6D
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_13B6D:				; CODE XREF: start+3B5Bj start+3B68j
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 28h	; '('
		mov	dx, 0CDDh
		mov	ax, 1Ch
		mov	cx, 0AFh ; '¯'
		call	sub_169BD
		mov	dx, 0
		call	sub_168A3
		mov	ax, 0FFFFh
		mov	si, offset aBOp_t07_gta	; "B:OP_T07.GTA"
		mov	word_1793A, 0
		mov	word_1793C, 0
		call	LoadGTA
		jnb	short loc_13BA9
		jmp	ErrExit_fopen
; ---------------------------------------------------------------------------

loc_13BA9:				; CODE XREF: start+3BA4j
		mov	PaletteID, 0
		call	CopyPalette
		mov	dx, 1
		call	sub_168A3
		mov	ax, 0FFFFh
		mov	si, offset aBOp_t08_gta	; "B:OP_T08.GTA"
		mov	word_1793A, 0
		mov	word_1793C, 0
		call	LoadGTA
		jnb	short loc_13BD1
		jmp	ErrExit_fopen
; ---------------------------------------------------------------------------

loc_13BD1:				; CODE XREF: start+3BCCj
		mov	PaletteID, 1
		call	CopyPalette
		mov	DestFrmWaitTick, 14ACh
		mov	DestFMWaitTick,	1170h
		mov	DestMIDWaitTick, 118Eh
		call	WaitForMusic1
		jnb	short loc_13C00
		cmp	ax, 1
		jnz	short loc_13BF8
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_13BF8:				; CODE XREF: start+3BF3j
		cmp	ax, 2
		jnz	short loc_13C00
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_13C00:				; CODE XREF: start+3BEEj start+3BFBj
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 0
		mov	dx, 45BDh
		mov	ax, 1Bh
		mov	cx, 6Bh	; 'k'
		call	sub_16909
		mov	byte_17922, 2

loc_13C21:				; CODE XREF: start+3C26j
		cmp	byte_17922, 0
		jnz	short loc_13C21
		jmp	short loc_13C73
; ---------------------------------------------------------------------------

loc_13C2A:				; CODE XREF: start+3DF7j
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 0
		mov	dx, 45BDh
		mov	ax, 1Bh
		mov	cx, 6Bh	; 'k'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_13C67
		cmp	ax, 1
		jnz	short loc_13C5F
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_13C5F:				; CODE XREF: start+3C5Aj
		cmp	ax, 2
		jnz	short loc_13C67
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_13C67:				; CODE XREF: start+3C55j start+3C62j
		mov	byte_17922, 2

loc_13C6C:				; CODE XREF: start+3C71j
		cmp	byte_17922, 0
		jnz	short loc_13C6C

loc_13C73:				; CODE XREF: start+3C28j
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 28h	; '('
		mov	dx, 45BDh
		mov	ax, 1Bh
		mov	cx, 6Bh	; 'k'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_13CB0
		cmp	ax, 1
		jnz	short loc_13CA8
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_13CA8:				; CODE XREF: start+3CA3j
		cmp	ax, 2
		jnz	short loc_13CB0
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_13CB0:				; CODE XREF: start+3C9Ej start+3CABj
		mov	byte_17922, 1

loc_13CB5:				; CODE XREF: start+3CBAj
		cmp	byte_17922, 0
		jnz	short loc_13CB5
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 2580h
		mov	dx, 45BDh
		mov	ax, 1Bh
		mov	cx, 6Bh	; 'k'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_13CF9
		cmp	ax, 1
		jnz	short loc_13CF1
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_13CF1:				; CODE XREF: start+3CECj
		cmp	ax, 2
		jnz	short loc_13CF9
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_13CF9:				; CODE XREF: start+3CE7j start+3CF4j
		mov	byte_17922, 2

loc_13CFE:				; CODE XREF: start+3D03j
		cmp	byte_17922, 0
		jnz	short loc_13CFE
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 0
		mov	dx, 45BDh
		mov	ax, 1Bh
		mov	cx, 6Bh	; 'k'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_13D42
		cmp	ax, 1
		jnz	short loc_13D3A
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_13D3A:				; CODE XREF: start+3D35j
		cmp	ax, 2
		jnz	short loc_13D42
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_13D42:				; CODE XREF: start+3D30j start+3D3Dj
		mov	byte_17922, 1

loc_13D47:				; CODE XREF: start+3D4Cj
		cmp	byte_17922, 0
		jnz	short loc_13D47
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 28h	; '('
		mov	dx, 45BDh
		mov	ax, 1Bh
		mov	cx, 6Bh	; 'k'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_13D8B
		cmp	ax, 1
		jnz	short loc_13D83
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_13D83:				; CODE XREF: start+3D7Ej
		cmp	ax, 2
		jnz	short loc_13D8B
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_13D8B:				; CODE XREF: start+3D79j start+3D86j
		mov	byte_17922, 2

loc_13D90:				; CODE XREF: start+3D95j
		cmp	byte_17922, 0
		jnz	short loc_13D90
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 2580h
		mov	dx, 45BDh
		mov	ax, 1Bh
		mov	cx, 6Bh	; 'k'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_13DD4
		cmp	ax, 1
		jnz	short loc_13DCC
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_13DCC:				; CODE XREF: start+3DC7j
		cmp	ax, 2
		jnz	short loc_13DD4
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_13DD4:				; CODE XREF: start+3DC2j start+3DCFj
		mov	byte_17922, 1

loc_13DD9:				; CODE XREF: start+3DDEj
		cmp	byte_17922, 0
		jnz	short loc_13DD9
		mov	DestFrmWaitTick, 14BEh
		mov	DestFMWaitTick,	1170h
		mov	DestMIDWaitTick, 118Eh
		call	WaitForMusic2
		jb	short loc_13DFA
		jmp	loc_13C2A
; ---------------------------------------------------------------------------

loc_13DFA:				; CODE XREF: start+3DF5j
		cmp	ax, 1
		jz	short loc_13E0F
		cmp	ax, 2
		jnz	short loc_13E07
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_13E07:				; CODE XREF: start+3E02j
		cmp	ax, 3
		jnz	short loc_13E0F
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_13E0F:				; CODE XREF: start+3DFDj start+3E0Aj
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 25A8h
		mov	dx, 45BDh
		mov	ax, 1Bh
		mov	cx, 6Bh	; 'k'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_13E4C
		cmp	ax, 1
		jnz	short loc_13E44
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_13E44:				; CODE XREF: start+3E3Fj
		cmp	ax, 2
		jnz	short loc_13E4C
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_13E4C:				; CODE XREF: start+3E3Aj start+3E47j
		mov	byte_17922, 2

loc_13E51:				; CODE XREF: start+3E56j
		cmp	byte_17922, 0
		jnz	short loc_13E51

loc_13E58:				; CODE XREF: start+4025j
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 4B00h
		mov	dx, 45BDh
		mov	ax, 1Bh
		mov	cx, 6Bh	; 'k'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_13E95
		cmp	ax, 1
		jnz	short loc_13E8D
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_13E8D:				; CODE XREF: start+3E88j
		cmp	ax, 2
		jnz	short loc_13E95
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_13E95:				; CODE XREF: start+3E83j start+3E90j
		mov	byte_17922, 1

loc_13E9A:				; CODE XREF: start+3E9Fj
		cmp	byte_17922, 0
		jnz	short loc_13E9A
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 4B28h
		mov	dx, 45BDh
		mov	ax, 1Bh
		mov	cx, 6Bh	; 'k'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_13EDE
		cmp	ax, 1
		jnz	short loc_13ED6
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_13ED6:				; CODE XREF: start+3ED1j
		cmp	ax, 2
		jnz	short loc_13EDE
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_13EDE:				; CODE XREF: start+3ECCj start+3ED9j
		mov	byte_17922, 2

loc_13EE3:				; CODE XREF: start+3EE8j
		cmp	byte_17922, 0
		jnz	short loc_13EE3
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 1
		call	sub_168CE
		mov	bx, 0
		mov	dx, 45BDh
		mov	ax, 1Bh
		mov	cx, 6Bh	; 'k'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_13F27
		cmp	ax, 1
		jnz	short loc_13F1F
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_13F1F:				; CODE XREF: start+3F1Aj
		cmp	ax, 2
		jnz	short loc_13F27
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_13F27:				; CODE XREF: start+3F15j start+3F22j
		mov	byte_17922, 1

loc_13F2C:				; CODE XREF: start+3F31j
		cmp	byte_17922, 0
		jnz	short loc_13F2C
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 4B00h
		mov	dx, 45BDh
		mov	ax, 1Bh
		mov	cx, 6Bh	; 'k'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_13F70
		cmp	ax, 1
		jnz	short loc_13F68
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_13F68:				; CODE XREF: start+3F63j
		cmp	ax, 2
		jnz	short loc_13F70
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_13F70:				; CODE XREF: start+3F5Ej start+3F6Bj
		mov	byte_17922, 2

loc_13F75:				; CODE XREF: start+3F7Aj
		cmp	byte_17922, 0
		jnz	short loc_13F75
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 4B28h
		mov	dx, 45BDh
		mov	ax, 1Bh
		mov	cx, 6Bh	; 'k'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_13FB9
		cmp	ax, 1
		jnz	short loc_13FB1
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_13FB1:				; CODE XREF: start+3FACj
		cmp	ax, 2
		jnz	short loc_13FB9
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_13FB9:				; CODE XREF: start+3FA7j start+3FB4j
		mov	byte_17922, 1

loc_13FBE:				; CODE XREF: start+3FC3j
		cmp	byte_17922, 0
		jnz	short loc_13FBE
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 1
		call	sub_168CE
		mov	bx, 0
		mov	dx, 45BDh
		mov	ax, 1Bh
		mov	cx, 6Bh	; 'k'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_14002
		cmp	ax, 1
		jnz	short loc_13FFA
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_13FFA:				; CODE XREF: start+3FF5j
		cmp	ax, 2
		jnz	short loc_14002
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_14002:				; CODE XREF: start+3FF0j start+3FFDj
		mov	byte_17922, 2

loc_14007:				; CODE XREF: start+400Cj
		cmp	byte_17922, 0
		jnz	short loc_14007
		mov	DestFrmWaitTick, 1506h
		mov	DestFMWaitTick,	11B8h
		mov	DestMIDWaitTick, 11D6h
		call	WaitForMusic2
		jb	short loc_14028
		jmp	loc_13E58
; ---------------------------------------------------------------------------

loc_14028:				; CODE XREF: start+4023j
		cmp	ax, 1
		jz	short loc_1403D
		cmp	ax, 2
		jnz	short loc_14035
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_14035:				; CODE XREF: start+4030j
		cmp	ax, 3
		jnz	short loc_1403D
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_1403D:				; CODE XREF: start+402Bj start+4038j
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 1
		call	sub_168CE
		mov	bx, 0
		mov	dx, 45BDh
		mov	ax, 1Bh
		mov	cx, 6Bh	; 'k'
		call	sub_16909
		mov	dx, 0
		call	sub_168A3
		mov	ax, 0FFFFh
		mov	si, offset aBOp_t09_gta	; "B:OP_T09.GTA"
		mov	word_1793A, 0
		mov	word_1793C, 0
		call	LoadGTA
		jnb	short loc_14079
		jmp	ErrExit_fopen
; ---------------------------------------------------------------------------

loc_14079:				; CODE XREF: start+4074j
		mov	PaletteID, 0
		call	CopyPalette
		mov	dx, 1
		call	sub_168A3
		mov	ax, 0FFFFh
		mov	si, offset aBOp_t10_gta	; "B:OP_T10.GTA"
		mov	word_1793A, 0
		mov	word_1793C, 0
		call	LoadGTA
		jnb	short loc_140A1
		jmp	ErrExit_fopen
; ---------------------------------------------------------------------------

loc_140A1:				; CODE XREF: start+409Cj
		mov	PaletteID, 1
		call	CopyPalette
		mov	dx, 2
		call	sub_168A3
		mov	ax, 0FFFFh
		mov	si, offset aBOp_t11_gta	; "B:OP_T11.GTA"
		mov	word_1793A, 0
		mov	word_1793C, 0
		call	LoadGTA
		jnb	short loc_140C9
		jmp	ErrExit_fopen
; ---------------------------------------------------------------------------

loc_140C9:				; CODE XREF: start+40C4j
		mov	PaletteID, 2
		call	CopyPalette
		mov	DestFrmWaitTick, 1560h
		mov	DestFMWaitTick,	1200h
		mov	DestMIDWaitTick, 121Eh
		call	WaitForMusic1
		jnb	short loc_140F8
		cmp	ax, 1
		jnz	short loc_140F0
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_140F0:				; CODE XREF: start+40EBj
		cmp	ax, 2
		jnz	short loc_140F8
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_140F8:				; CODE XREF: start+40E6j start+40F3j
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 0
		mov	dx, 0B68h
		mov	ax, 1Ah
		mov	cx, 126h
		call	sub_169BD
		mov	FrameCounter, 0
		mov	FramesToWait, 13h
		call	WaitFrames2
		jnb	short loc_14135
		cmp	ax, 1
		jnz	short loc_1412D
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_1412D:				; CODE XREF: start+4128j
		cmp	ax, 2
		jnz	short loc_14135
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_14135:				; CODE XREF: start+4123j start+4130j
		mov	byte_17922, 1

loc_1413A:				; CODE XREF: start+413Fj
		cmp	byte_17922, 0
		jnz	short loc_1413A
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 1Ah
		mov	dx, 0B68h
		mov	ax, 1Ah
		mov	cx, 126h
		call	sub_169BD
		mov	FrameCounter, 0
		mov	FramesToWait, 13h
		call	WaitFrames2
		jnb	short loc_1417E
		cmp	ax, 1
		jnz	short loc_14176
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_14176:				; CODE XREF: start+4171j
		cmp	ax, 2
		jnz	short loc_1417E
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_1417E:				; CODE XREF: start+416Cj start+4179j
		mov	byte_17922, 2

loc_14183:				; CODE XREF: start+4188j
		cmp	byte_17922, 0
		jnz	short loc_14183
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 34h	; '4'
		mov	dx, 0B68h
		mov	ax, 1Ah
		mov	cx, 126h
		call	sub_169BD
		mov	FrameCounter, 0
		mov	FramesToWait, 13h
		call	WaitFrames2
		jnb	short loc_141C7
		cmp	ax, 1
		jnz	short loc_141BF
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_141BF:				; CODE XREF: start+41BAj
		cmp	ax, 2
		jnz	short loc_141C7
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_141C7:				; CODE XREF: start+41B5j start+41C2j
		mov	byte_17922, 1

loc_141CC:				; CODE XREF: start+41D1j
		cmp	byte_17922, 0
		jnz	short loc_141CC
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 1
		call	sub_168CE
		mov	bx, 0
		mov	dx, 0B68h
		mov	ax, 1Ah
		mov	cx, 126h
		call	sub_169BD
		mov	FrameCounter, 0
		mov	FramesToWait, 13h
		call	WaitFrames2
		jnb	short loc_14210
		cmp	ax, 1
		jnz	short loc_14208
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_14208:				; CODE XREF: start+4203j
		cmp	ax, 2
		jnz	short loc_14210
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_14210:				; CODE XREF: start+41FEj start+420Bj
		mov	byte_17922, 2

loc_14215:				; CODE XREF: start+421Aj
		cmp	byte_17922, 0
		jnz	short loc_14215
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 1
		call	sub_168CE
		mov	bx, 1Ah
		mov	dx, 0B68h
		mov	ax, 1Ah
		mov	cx, 126h
		call	sub_169BD
		mov	FrameCounter, 0
		mov	FramesToWait, 13h
		call	WaitFrames2
		jnb	short loc_14259
		cmp	ax, 1
		jnz	short loc_14251
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_14251:				; CODE XREF: start+424Cj
		cmp	ax, 2
		jnz	short loc_14259
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_14259:				; CODE XREF: start+4247j start+4254j
		mov	byte_17922, 1

loc_1425E:				; CODE XREF: start+4263j
		cmp	byte_17922, 0
		jnz	short loc_1425E
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 1
		call	sub_168CE
		mov	bx, 34h	; '4'
		mov	dx, 0B68h
		mov	ax, 1Ah
		mov	cx, 126h
		call	sub_169BD
		mov	FrameCounter, 0
		mov	FramesToWait, 13h
		call	WaitFrames2
		jnb	short loc_142A2
		cmp	ax, 1
		jnz	short loc_1429A
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_1429A:				; CODE XREF: start+4295j
		cmp	ax, 2
		jnz	short loc_142A2
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_142A2:				; CODE XREF: start+4290j start+429Dj
		mov	byte_17922, 2

loc_142A7:				; CODE XREF: start+42ACj
		cmp	byte_17922, 0
		jnz	short loc_142A7
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 2
		call	sub_168CE
		mov	bx, 0
		mov	dx, 0B68h
		mov	ax, 1Ah
		mov	cx, 126h
		call	sub_169BD
		mov	FrameCounter, 0
		mov	FramesToWait, 13h
		call	WaitFrames2
		jnb	short loc_142EB
		cmp	ax, 1
		jnz	short loc_142E3
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_142E3:				; CODE XREF: start+42DEj
		cmp	ax, 2
		jnz	short loc_142EB
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_142EB:				; CODE XREF: start+42D9j start+42E6j
		mov	byte_17922, 1

loc_142F0:				; CODE XREF: start+42F5j
		cmp	byte_17922, 0
		jnz	short loc_142F0
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 2
		call	sub_168CE
		mov	bx, 1Ah
		mov	dx, 0B68h
		mov	ax, 1Ah
		mov	cx, 126h
		call	sub_169BD
		mov	FrameCounter, 0
		mov	FramesToWait, 13h
		call	WaitFrames2
		jnb	short loc_14334
		cmp	ax, 1
		jnz	short loc_1432C
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_1432C:				; CODE XREF: start+4327j
		cmp	ax, 2
		jnz	short loc_14334
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_14334:				; CODE XREF: start+4322j start+432Fj
		mov	byte_17922, 2

loc_14339:				; CODE XREF: start+433Ej
		cmp	byte_17922, 0
		jnz	short loc_14339
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 2
		call	sub_168CE
		mov	bx, 34h	; '4'
		mov	dx, 0B68h
		mov	ax, 1Ah
		mov	cx, 126h
		call	sub_169BD
		mov	FrameCounter, 0
		mov	FramesToWait, 13h
		call	WaitFrames2
		jnb	short loc_1437D
		cmp	ax, 1
		jnz	short loc_14375
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_14375:				; CODE XREF: start+4370j
		cmp	ax, 2
		jnz	short loc_1437D
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_1437D:				; CODE XREF: start+436Bj start+4378j
		mov	byte_17922, 1

loc_14382:				; CODE XREF: start+4387j
		cmp	byte_17922, 0
		jnz	short loc_14382
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 2
		call	sub_168CE
		mov	bx, 34h	; '4'
		mov	dx, 0B68h
		mov	ax, 1Ah
		mov	cx, 126h
		call	sub_169BD
		mov	byte_17922, 2

loc_143AA:				; CODE XREF: start+43AFj
		cmp	byte_17922, 0
		jnz	short loc_143AA
		mov	dx, 0
		call	sub_168A3
		mov	ax, 0FFFFh
		mov	si, offset aBOp_t12_gta	; "B:OP_T12.GTA"
		mov	word_1793A, 0
		mov	word_1793C, 0
		call	LoadGTA
		jnb	short loc_143D1
		jmp	ErrExit_fopen
; ---------------------------------------------------------------------------

loc_143D1:				; CODE XREF: start+43CCj
		mov	PaletteID, 0
		call	CopyPalette
		mov	dx, 1
		call	sub_168A3
		mov	ax, 0FFFFh
		mov	si, offset aBOp_t13_gta	; "B:OP_T13.GTA"
		mov	word_1793A, 0
		mov	word_1793C, 0
		call	LoadGTA
		jnb	short loc_143F9
		jmp	ErrExit_fopen
; ---------------------------------------------------------------------------

loc_143F9:				; CODE XREF: start+43F4j
		mov	PaletteID, 1
		call	CopyPalette
		mov	dx, 2
		call	sub_168A3
		mov	ax, 0FFFFh
		mov	si, offset aBOp_t14_gta	; "B:OP_T14.GTA"
		mov	word_1793A, 0
		mov	word_1793C, 0
		call	LoadGTA
		jnb	short loc_14421
		jmp	ErrExit_fopen
; ---------------------------------------------------------------------------

loc_14421:				; CODE XREF: start+441Cj
		mov	PaletteID, 2
		call	CopyPalette

loc_14429:				; CODE XREF: start+35C3j
		mov	DestFrmWaitTick, 16B6h
		mov	DestFMWaitTick,	1320h
		mov	DestMIDWaitTick, 133Eh
		call	WaitForMusic1
		jnb	short loc_14450
		cmp	ax, 1
		jnz	short loc_14448
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_14448:				; CODE XREF: start+4443j
		cmp	ax, 2
		jnz	short loc_14450
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_14450:				; CODE XREF: start+443Ej start+444Bj
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		call	ClearPlane
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	PaletteID, 0
		mov	PalFadeStart, 100
		mov	byte_1793F, 0
		mov	byte_1793E, 1
		call	WaitForVSync
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 0
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	byte_17922, 1

loc_14490:				; CODE XREF: start+4495j
		cmp	byte_17922, 0
		jnz	short loc_14490
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		call	ClearPlane
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 28h	; '('
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 13h
		call	WaitFrames2
		jnb	short loc_144DB
		cmp	ax, 1
		jnz	short loc_144D3
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_144D3:				; CODE XREF: start+44CEj
		cmp	ax, 2
		jnz	short loc_144DB
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_144DB:				; CODE XREF: start+44C9j start+44D6j
		mov	byte_17922, 2

loc_144E0:				; CODE XREF: start+44E5j
		cmp	byte_17922, 0
		jnz	short loc_144E0
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 3E80h
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 13h
		call	WaitFrames2
		jnb	short loc_14524
		cmp	ax, 1
		jnz	short loc_1451C
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_1451C:				; CODE XREF: start+4517j
		cmp	ax, 2
		jnz	short loc_14524
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_14524:				; CODE XREF: start+4512j start+451Fj
		mov	byte_17922, 1

loc_14529:				; CODE XREF: start+452Ej
		cmp	byte_17922, 0
		jnz	short loc_14529
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 3EA8h
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 13h
		call	WaitFrames2
		jnb	short loc_1456D
		cmp	ax, 1
		jnz	short loc_14565
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_14565:				; CODE XREF: start+4560j
		cmp	ax, 2
		jnz	short loc_1456D
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_1456D:				; CODE XREF: start+455Bj start+4568j
		mov	byte_17922, 2

loc_14572:				; CODE XREF: start+4577j
		cmp	byte_17922, 0
		jnz	short loc_14572
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 1
		call	sub_168CE
		mov	bx, 0
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 13h
		call	WaitFrames2
		jnb	short loc_145B6
		cmp	ax, 1
		jnz	short loc_145AE
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_145AE:				; CODE XREF: start+45A9j
		cmp	ax, 2
		jnz	short loc_145B6
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_145B6:				; CODE XREF: start+45A4j start+45B1j
		mov	byte_17922, 1

loc_145BB:				; CODE XREF: start+45C0j
		cmp	byte_17922, 0
		jnz	short loc_145BB
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 1
		call	sub_168CE
		mov	bx, 28h	; '('
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 13h
		call	WaitFrames2
		jnb	short loc_145FF
		cmp	ax, 1
		jnz	short loc_145F7
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_145F7:				; CODE XREF: start+45F2j
		cmp	ax, 2
		jnz	short loc_145FF
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_145FF:				; CODE XREF: start+45EDj start+45FAj
		mov	byte_17922, 2

loc_14604:				; CODE XREF: start+4609j
		cmp	byte_17922, 0
		jnz	short loc_14604
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 1
		call	sub_168CE
		mov	bx, 3E80h
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 13h
		call	WaitFrames2
		jnb	short loc_14648
		cmp	ax, 1
		jnz	short loc_14640
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_14640:				; CODE XREF: start+463Bj
		cmp	ax, 2
		jnz	short loc_14648
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_14648:				; CODE XREF: start+4636j start+4643j
		mov	byte_17922, 1

loc_1464D:				; CODE XREF: start+4652j
		cmp	byte_17922, 0
		jnz	short loc_1464D
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 1
		call	sub_168CE
		mov	bx, 3EA8h
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 13h
		call	WaitFrames2
		jnb	short loc_14691
		cmp	ax, 1
		jnz	short loc_14689
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_14689:				; CODE XREF: start+4684j
		cmp	ax, 2
		jnz	short loc_14691
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_14691:				; CODE XREF: start+467Fj start+468Cj
		mov	byte_17922, 2

loc_14696:				; CODE XREF: start+469Bj
		cmp	byte_17922, 0
		jnz	short loc_14696
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 2
		call	sub_168CE
		mov	bx, 0
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 13h
		call	WaitFrames2
		jnb	short loc_146DA
		cmp	ax, 1
		jnz	short loc_146D2
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_146D2:				; CODE XREF: start+46CDj
		cmp	ax, 2
		jnz	short loc_146DA
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_146DA:				; CODE XREF: start+46C8j start+46D5j
		mov	byte_17922, 1

loc_146DF:				; CODE XREF: start+46E4j
		cmp	byte_17922, 0
		jnz	short loc_146DF
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 2
		call	sub_168CE
		mov	bx, 28h	; '('
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 13h
		call	WaitFrames2
		jnb	short loc_14723
		cmp	ax, 1
		jnz	short loc_1471B
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_1471B:				; CODE XREF: start+4716j
		cmp	ax, 2
		jnz	short loc_14723
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_14723:				; CODE XREF: start+4711j start+471Ej
		mov	byte_17922, 2

loc_14728:				; CODE XREF: start+472Dj
		cmp	byte_17922, 0
		jnz	short loc_14728
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 2
		call	sub_168CE
		mov	bx, 3E80h
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 13h
		call	WaitFrames2
		jnb	short loc_1476C
		cmp	ax, 1
		jnz	short loc_14764
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_14764:				; CODE XREF: start+475Fj
		cmp	ax, 2
		jnz	short loc_1476C
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_1476C:				; CODE XREF: start+475Aj start+4767j
		mov	byte_17922, 1

loc_14771:				; CODE XREF: start+4776j
		cmp	byte_17922, 0
		jnz	short loc_14771
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 2
		call	sub_168CE
		mov	bx, 3EA8h
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 13h
		call	WaitFrames2
		jnb	short loc_147B5
		cmp	ax, 1
		jnz	short loc_147AD
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_147AD:				; CODE XREF: start+47A8j
		cmp	ax, 2
		jnz	short loc_147B5
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_147B5:				; CODE XREF: start+47A3j start+47B0j
		mov	byte_17922, 2

loc_147BA:				; CODE XREF: start+47BFj
		cmp	byte_17922, 0
		jnz	short loc_147BA
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 2
		call	sub_168CE
		mov	bx, 3EA8h
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	byte_17922, 1

loc_147E2:				; CODE XREF: start+47E7j
		cmp	byte_17922, 0
		jnz	short loc_147E2
		mov	dx, 0
		call	sub_168A3
		mov	ax, 0FFFFh
		mov	si, offset aBOp_t15_gta	; "B:OP_T15.GTA"
		mov	word_1793A, 0
		mov	word_1793C, 0
		call	LoadGTA
		jnb	short loc_14809
		jmp	ErrExit_fopen
; ---------------------------------------------------------------------------

loc_14809:				; CODE XREF: start+4804j
		mov	PaletteID, 0
		call	CopyPalette
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 0
		mov	dx, 5DC0h
		mov	ax, 50h	; 'P'
		mov	cx, 32h	; '2'
		call	sub_169BD
		mov	DestFrmWaitTick, 1824h
		mov	DestFMWaitTick,	1458h
		mov	DestMIDWaitTick, 1476h
		call	WaitForMusic1
		jnb	short loc_14854
		cmp	ax, 1
		jnz	short loc_1484C
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_1484C:				; CODE XREF: start+4847j
		cmp	ax, 2
		jnz	short loc_14854
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_14854:				; CODE XREF: start+4842j start+484Fj
		mov	byte_17922, 2

loc_14859:				; CODE XREF: start+485Ej
		cmp	byte_17922, 0
		jnz	short loc_14859
		mov	dx, 0
		call	sub_168A3
		mov	ax, 0FFFFh
		mov	si, offset aBOp_i01_gta	; "B:OP_I01.GTA"
		mov	word_1793A, 0
		mov	word_1793C, 0
		call	LoadGTA
		jnb	short loc_14880
		jmp	ErrExit_fopen
; ---------------------------------------------------------------------------

loc_14880:				; CODE XREF: start+487Bj
		mov	PaletteID, 0
		call	CopyPalette
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		call	ClearPlane
		mov	DestFrmWaitTick, 18F0h
		mov	DestFMWaitTick,	1500h
		mov	DestMIDWaitTick, 151Eh
		call	WaitForMusic1
		jnb	short loc_148B6
		cmp	ax, 1
		jnz	short loc_148AE
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_148AE:				; CODE XREF: start+48A9j
		cmp	ax, 2
		jnz	short loc_148B6
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_148B6:				; CODE XREF: start+48A4j start+48B1j
		mov	PaletteID, 0
		mov	PalFadeStart, 0
		mov	byte_1793F, 0
		mov	byte_1793E, 1
		call	WaitForVSync
		call	WaitForVSync
		call	WaitForVSync
		call	WaitForVSync
		call	WaitForVSync
		mov	PaletteID, 0
		mov	PalFadeStart, 0
		mov	PalFadeEnd, 100
		mov	PalFadeInc, 1
		mov	PalFade_StepDelay, 1
		mov	byte_1793F, 1
		mov	byte_1793E, 1
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 0
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	byte_17922, 1

loc_14922:				; CODE XREF: start+4927j
		cmp	byte_17922, 0
		jnz	short loc_14922
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		call	ClearPlane
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 28h	; '('
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_1496D
		cmp	ax, 1
		jnz	short loc_14965
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_14965:				; CODE XREF: start+4960j
		cmp	ax, 2
		jnz	short loc_1496D
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_1496D:				; CODE XREF: start+495Bj start+4968j
		mov	byte_17922, 2

loc_14972:				; CODE XREF: start+4977j
		cmp	byte_17922, 0
		jnz	short loc_14972
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 3E80h
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_149B6
		cmp	ax, 1
		jnz	short loc_149AE
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_149AE:				; CODE XREF: start+49A9j
		cmp	ax, 2
		jnz	short loc_149B6
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_149B6:				; CODE XREF: start+49A4j start+49B1j
		mov	byte_17922, 1

loc_149BB:				; CODE XREF: start+49C0j
		cmp	byte_17922, 0
		jnz	short loc_149BB

loc_149C2:				; CODE XREF: start+4B8Fj
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 0
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_149FF
		cmp	ax, 1
		jnz	short loc_149F7
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_149F7:				; CODE XREF: start+49F2j
		cmp	ax, 2
		jnz	short loc_149FF
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_149FF:				; CODE XREF: start+49EDj start+49FAj
		mov	byte_17922, 2

loc_14A04:				; CODE XREF: start+4A09j
		cmp	byte_17922, 0
		jnz	short loc_14A04
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 28h	; '('
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_14A48
		cmp	ax, 1
		jnz	short loc_14A40
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_14A40:				; CODE XREF: start+4A3Bj
		cmp	ax, 2
		jnz	short loc_14A48
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_14A48:				; CODE XREF: start+4A36j start+4A43j
		mov	byte_17922, 1

loc_14A4D:				; CODE XREF: start+4A52j
		cmp	byte_17922, 0
		jnz	short loc_14A4D
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 3E80h
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_14A91
		cmp	ax, 1
		jnz	short loc_14A89
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_14A89:				; CODE XREF: start+4A84j
		cmp	ax, 2
		jnz	short loc_14A91
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_14A91:				; CODE XREF: start+4A7Fj start+4A8Cj
		mov	byte_17922, 2

loc_14A96:				; CODE XREF: start+4A9Bj
		cmp	byte_17922, 0
		jnz	short loc_14A96
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 0
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_14ADA
		cmp	ax, 1
		jnz	short loc_14AD2
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_14AD2:				; CODE XREF: start+4ACDj
		cmp	ax, 2
		jnz	short loc_14ADA
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_14ADA:				; CODE XREF: start+4AC8j start+4AD5j
		mov	byte_17922, 1

loc_14ADF:				; CODE XREF: start+4AE4j
		cmp	byte_17922, 0
		jnz	short loc_14ADF
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 28h	; '('
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_14B23
		cmp	ax, 1
		jnz	short loc_14B1B
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_14B1B:				; CODE XREF: start+4B16j
		cmp	ax, 2
		jnz	short loc_14B23
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_14B23:				; CODE XREF: start+4B11j start+4B1Ej
		mov	byte_17922, 2

loc_14B28:				; CODE XREF: start+4B2Dj
		cmp	byte_17922, 0
		jnz	short loc_14B28
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 3E80h
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_14B6C
		cmp	ax, 1
		jnz	short loc_14B64
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_14B64:				; CODE XREF: start+4B5Fj
		cmp	ax, 2
		jnz	short loc_14B6C
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_14B6C:				; CODE XREF: start+4B5Aj start+4B67j
		mov	byte_17922, 1

loc_14B71:				; CODE XREF: start+4B76j
		cmp	byte_17922, 0
		jnz	short loc_14B71
		mov	DestFrmWaitTick, 1A5Eh
		mov	DestFMWaitTick,	1638h
		mov	DestMIDWaitTick, 1656h
		call	WaitForMusic2
		jb	short loc_14B92
		jmp	loc_149C2
; ---------------------------------------------------------------------------

loc_14B92:				; CODE XREF: start+4B8Dj
		cmp	ax, 1
		jz	short loc_14BA7
		cmp	ax, 2
		jnz	short loc_14B9F
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_14B9F:				; CODE XREF: start+4B9Aj
		cmp	ax, 3
		jnz	short loc_14BA7
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_14BA7:				; CODE XREF: start+4B95j start+4BA2j
		cmp	byte_1757E, 1
		jnz	short loc_14BB8
		cmp	byte_17902, 1
		jnz	short loc_14BB8
		jmp	loc_14D6A
; ---------------------------------------------------------------------------

loc_14BB8:				; CODE XREF: start+4BACj start+4BB3j
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		call	ClearPlane
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A

loc_14BC3:				; CODE XREF: start+4BC8j
		cmp	byte_1793E, 0FFh
		jnz	short loc_14BC3
		mov	dx, 0FFFFh
		call	sub_168A3
		mov	ax, 0FFFFh
		mov	si, offset aBOp_i00_gta	; "B:OP_I00.GTA"
		mov	word_1793A, 0
		mov	word_1793C, 0
		call	LoadGTA
		jnb	short loc_14BEA
		jmp	ErrExit_fopen
; ---------------------------------------------------------------------------

loc_14BEA:				; CODE XREF: start+4BE5j
		mov	PaletteID, 9
		call	CopyPalette
		mov	DestFrmWaitTick, 1AD0h
		mov	DestFMWaitTick,	1698h
		mov	DestMIDWaitTick, 16B6h
		call	WaitForMusic1
		jnb	short loc_14C19
		cmp	ax, 1
		jnz	short loc_14C11
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_14C11:				; CODE XREF: start+4C0Cj
		cmp	ax, 2
		jnz	short loc_14C19
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_14C19:				; CODE XREF: start+4C07j start+4C14j
		mov	PaletteID, 0
		mov	PalFadeStart, 100
		mov	PalFadeEnd, 0
		mov	PalFadeInc, 1
		mov	PalFade_StepDelay, 1
		mov	byte_1793F, 1
		mov	byte_1793E, 1

loc_14C40:				; CODE XREF: start+4C45j
		cmp	byte_1793E, 0FFh
		jnz	short loc_14C40
		mov	DestFrmWaitTick, 1BB4h
		mov	DestFMWaitTick,	1758h
		mov	DestMIDWaitTick, 1776h
		call	WaitForMusic1
		jnb	short loc_14C6E
		cmp	ax, 1
		jnz	short loc_14C66
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_14C66:				; CODE XREF: start+4C61j
		cmp	ax, 2
		jnz	short loc_14C6E
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_14C6E:				; CODE XREF: start+4C5Cj start+4C69j
		mov	PaletteID, 9
		mov	PalFadeStart, 0
		mov	PalFadeEnd, 100
		mov	PalFadeInc, 1
		mov	PalFade_StepDelay, 1
		mov	byte_1793F, 1
		mov	byte_1793E, 1
		mov	byte_17922, 2

loc_14C9A:				; CODE XREF: start+4C9Fj
		cmp	byte_17922, 0
		jnz	short loc_14C9A

loc_14CA1:				; CODE XREF: start+4CA6j
		cmp	byte_1793E, 0FFh
		jnz	short loc_14CA1
		mov	dx, 0
		call	sub_168A3
		mov	ax, 0FFFFh
		mov	si, offset aBOp_i07_gta	; "B:OP_I07.GTA"
		mov	word_1793A, 0
		mov	word_1793C, 0
		call	LoadGTA
		jnb	short loc_14CC8
		jmp	ErrExit_fopen
; ---------------------------------------------------------------------------

loc_14CC8:				; CODE XREF: start+4CC3j
		mov	PaletteID, 0
		call	CopyPalette
		mov	dx, 1
		call	sub_168A3
		mov	ax, 0FFFFh
		mov	si, offset aBOp_i08_gta	; "B:OP_I08.GTA"
		mov	word_1793A, 0
		mov	word_1793C, 0
		call	LoadGTA
		jnb	short loc_14CF0
		jmp	ErrExit_fopen
; ---------------------------------------------------------------------------

loc_14CF0:				; CODE XREF: start+4CEBj
		mov	PaletteID, 1
		call	CopyPalette
		mov	DestFrmWaitTick, 1F80h
		mov	DestFMWaitTick,	1A82h
		mov	DestMIDWaitTick, 1AA0h
		call	WaitForMusic1
		jnb	short loc_14D1F
		cmp	ax, 1
		jnz	short loc_14D17
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_14D17:				; CODE XREF: start+4D12j
		cmp	ax, 2
		jnz	short loc_14D1F
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_14D1F:				; CODE XREF: start+4D0Dj start+4D1Aj
		mov	PaletteID, 9
		mov	PalFadeStart, 100
		mov	PalFadeEnd, 0
		mov	PalFadeInc, 1
		mov	PalFade_StepDelay, 1
		mov	byte_1793F, 1
		mov	byte_1793E, 1

loc_14D46:				; CODE XREF: start+4D4Bj
		cmp	byte_1793E, 0FFh
		jnz	short loc_14D46
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		call	ClearPlane
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		call	ClearPlane
		mov	byte_17922, 2

loc_14D60:				; CODE XREF: start+4D65j
		cmp	byte_17922, 0
		jnz	short loc_14D60
		jmp	loc_15916
; ---------------------------------------------------------------------------

loc_14D6A:				; CODE XREF: start+4BB5j start+4D6Fj
		cmp	byte_1793E, 0FFh
		jnz	short loc_14D6A
		mov	dx, 0
		call	sub_168A3
		mov	ax, 0FFFFh
		mov	si, offset aBOp_i03_gta	; "B:OP_I03.GTA"
		mov	word_1793A, 0
		mov	word_1793C, 0
		call	LoadGTA
		jnb	short loc_14D91
		jmp	ErrExit_fopen
; ---------------------------------------------------------------------------

loc_14D91:				; CODE XREF: start+4D8Cj
		mov	PaletteID, 0
		call	CopyPalette
		mov	DestFrmWaitTick, 1AD0h
		mov	DestFMWaitTick,	1698h
		mov	DestMIDWaitTick, 16B6h
		call	WaitForMusic1
		jnb	short loc_14DC0
		cmp	ax, 1
		jnz	short loc_14DB8
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_14DB8:				; CODE XREF: start+4DB3j
		cmp	ax, 2
		jnz	short loc_14DC0
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_14DC0:				; CODE XREF: start+4DAEj start+4DBBj
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		call	ClearPlane
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 0
		mov	dx, 0C55h
		mov	ax, 1Dh
		mov	cx, 63h	; 'c'
		call	sub_16909
		mov	byte_17922, 2

loc_14DE8:				; CODE XREF: start+4DEDj
		cmp	byte_17922, 0
		jnz	short loc_14DE8
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		call	ClearPlane
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 26h	; '&'
		mov	dx, 0C55h
		mov	ax, 1Dh
		mov	cx, 63h	; 'c'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_14E33
		cmp	ax, 1
		jnz	short loc_14E2B
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_14E2B:				; CODE XREF: start+4E26j
		cmp	ax, 2
		jnz	short loc_14E33
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_14E33:				; CODE XREF: start+4E21j start+4E2Ej
		mov	byte_17922, 1

loc_14E38:				; CODE XREF: start+4E3Dj
		cmp	byte_17922, 0
		jnz	short loc_14E38
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 20D0h
		mov	dx, 0C55h
		mov	ax, 1Dh
		mov	cx, 63h	; 'c'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_14E7C
		cmp	ax, 1
		jnz	short loc_14E74
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_14E74:				; CODE XREF: start+4E6Fj
		cmp	ax, 2
		jnz	short loc_14E7C
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_14E7C:				; CODE XREF: start+4E6Aj start+4E77j
		mov	byte_17922, 2

loc_14E81:				; CODE XREF: start+4E86j
		cmp	byte_17922, 0
		jnz	short loc_14E81

loc_14E88:				; CODE XREF: start+4FA2j
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 0
		mov	dx, 0C55h
		mov	ax, 1Dh
		mov	cx, 63h	; 'c'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_14EC5
		cmp	ax, 1
		jnz	short loc_14EBD
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_14EBD:				; CODE XREF: start+4EB8j
		cmp	ax, 2
		jnz	short loc_14EC5
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_14EC5:				; CODE XREF: start+4EB3j start+4EC0j
		mov	byte_17922, 1

loc_14ECA:				; CODE XREF: start+4ECFj
		cmp	byte_17922, 0
		jnz	short loc_14ECA
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 26h	; '&'
		mov	dx, 0C55h
		mov	ax, 1Dh
		mov	cx, 63h	; 'c'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_14F0E
		cmp	ax, 1
		jnz	short loc_14F06
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_14F06:				; CODE XREF: start+4F01j
		cmp	ax, 2
		jnz	short loc_14F0E
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_14F0E:				; CODE XREF: start+4EFCj start+4F09j
		mov	byte_17922, 2

loc_14F13:				; CODE XREF: start+4F18j
		cmp	byte_17922, 0
		jnz	short loc_14F13
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 20D0h
		mov	dx, 0C55h
		mov	ax, 1Dh
		mov	cx, 63h	; 'c'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_14F57
		cmp	ax, 1
		jnz	short loc_14F4F
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_14F4F:				; CODE XREF: start+4F4Aj
		cmp	ax, 2
		jnz	short loc_14F57
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_14F57:				; CODE XREF: start+4F45j start+4F52j
		mov	byte_17922, 1

loc_14F5C:				; CODE XREF: start+4F61j
		cmp	byte_17922, 0
		jnz	short loc_14F5C
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 20D0h
		mov	dx, 0C55h
		mov	ax, 1Dh
		mov	cx, 63h	; 'c'
		call	sub_16909
		mov	byte_17922, 2

loc_14F84:				; CODE XREF: start+4F89j
		cmp	byte_17922, 0
		jnz	short loc_14F84
		mov	DestFrmWaitTick, 1C0Eh
		mov	DestFMWaitTick,	17A0h
		mov	DestMIDWaitTick, 17BEh
		call	WaitForMusic2
		jb	short loc_14FA5
		jmp	loc_14E88
; ---------------------------------------------------------------------------

loc_14FA5:				; CODE XREF: start+4FA0j
		cmp	ax, 1
		jz	short loc_14FBA
		cmp	ax, 2
		jnz	short loc_14FB2
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_14FB2:				; CODE XREF: start+4FADj
		cmp	ax, 3
		jnz	short loc_14FBA
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_14FBA:				; CODE XREF: start+4FA8j start+4FB5j
		mov	dx, 1
		call	sub_168A3
		mov	ax, 0FFFFh
		mov	si, offset aBOp_i02_gta	; "B:OP_I02.GTA"
		mov	word_1793A, 0
		mov	word_1793C, 0
		call	LoadGTA
		jnb	short loc_14FDA
		jmp	ErrExit_fopen
; ---------------------------------------------------------------------------

loc_14FDA:				; CODE XREF: start+4FD5j
		mov	PaletteID, 1
		call	CopyPalette
		mov	DestFrmWaitTick, 1C98h
		mov	DestFMWaitTick,	1818h
		mov	DestMIDWaitTick, 1836h
		call	WaitForMusic1
		jnb	short loc_15009
		cmp	ax, 1
		jnz	short loc_15001
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_15001:				; CODE XREF: start+4FFCj
		cmp	ax, 2
		jnz	short loc_15009
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_15009:				; CODE XREF: start+4FF7j start+5004j
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 1
		call	sub_168CE
		mov	bx, 0
		mov	dx, 2E15h
		mov	ax, 12h
		mov	cx, 0B6h ; '¶'
		call	sub_16909
		mov	byte_17922, 1

loc_1502A:				; CODE XREF: start+502Fj
		cmp	byte_17922, 0
		jnz	short loc_1502A
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 1
		call	sub_168CE
		mov	bx, 13h
		mov	dx, 2E15h
		mov	ax, 12h
		mov	cx, 0B6h ; '¶'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_1506E
		cmp	ax, 1
		jnz	short loc_15066
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_15066:				; CODE XREF: start+5061j
		cmp	ax, 2
		jnz	short loc_1506E
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_1506E:				; CODE XREF: start+505Cj start+5069j
		mov	byte_17922, 2

loc_15073:				; CODE XREF: start+5078j
		cmp	byte_17922, 0
		jnz	short loc_15073
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 1
		call	sub_168CE
		mov	bx, 26h	; '&'
		mov	dx, 2E15h
		mov	ax, 12h
		mov	cx, 0B6h ; '¶'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_150B7
		cmp	ax, 1
		jnz	short loc_150AF
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_150AF:				; CODE XREF: start+50AAj
		cmp	ax, 2
		jnz	short loc_150B7
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_150B7:				; CODE XREF: start+50A5j start+50B2j
		mov	byte_17922, 1

loc_150BC:				; CODE XREF: start+50C1j
		cmp	byte_17922, 0
		jnz	short loc_150BC
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 1
		call	sub_168CE
		mov	bx, 39h	; '9'
		mov	dx, 2E15h
		mov	ax, 12h
		mov	cx, 0B6h ; '¶'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_15100
		cmp	ax, 1
		jnz	short loc_150F8
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_150F8:				; CODE XREF: start+50F3j
		cmp	ax, 2
		jnz	short loc_15100
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_15100:				; CODE XREF: start+50EEj start+50FBj
		mov	byte_17922, 2

loc_15105:				; CODE XREF: start+510Aj
		cmp	byte_17922, 0
		jnz	short loc_15105
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 1
		call	sub_168CE
		mov	bx, 3E80h
		mov	dx, 2E15h
		mov	ax, 12h
		mov	cx, 0B6h ; '¶'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_15149
		cmp	ax, 1
		jnz	short loc_15141
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_15141:				; CODE XREF: start+513Cj
		cmp	ax, 2
		jnz	short loc_15149
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_15149:				; CODE XREF: start+5137j start+5144j
		mov	byte_17922, 1

loc_1514E:				; CODE XREF: start+5153j
		cmp	byte_17922, 0
		jnz	short loc_1514E
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 1
		call	sub_168CE
		mov	bx, 3E93h
		mov	dx, 2E15h
		mov	ax, 12h
		mov	cx, 0B6h ; '¶'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_15192
		cmp	ax, 1
		jnz	short loc_1518A
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_1518A:				; CODE XREF: start+5185j
		cmp	ax, 2
		jnz	short loc_15192
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_15192:				; CODE XREF: start+5180j start+518Dj
		mov	byte_17922, 2

loc_15197:				; CODE XREF: start+519Cj
		cmp	byte_17922, 0
		jnz	short loc_15197
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 1
		call	sub_168CE
		mov	bx, 3EA6h
		mov	dx, 2E15h
		mov	ax, 12h
		mov	cx, 0B6h ; '¶'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_151DB
		cmp	ax, 1
		jnz	short loc_151D3
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_151D3:				; CODE XREF: start+51CEj
		cmp	ax, 2
		jnz	short loc_151DB
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_151DB:				; CODE XREF: start+51C9j start+51D6j
		mov	byte_17922, 1

loc_151E0:				; CODE XREF: start+51E5j
		cmp	byte_17922, 0
		jnz	short loc_151E0

loc_151E7:				; CODE XREF: start+5425j
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 1
		call	sub_168CE
		mov	bx, 0
		mov	dx, 2E15h
		mov	ax, 12h
		mov	cx, 0B6h ; '¶'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_15224
		cmp	ax, 1
		jnz	short loc_1521C
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_1521C:				; CODE XREF: start+5217j
		cmp	ax, 2
		jnz	short loc_15224
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_15224:				; CODE XREF: start+5212j start+521Fj
		mov	byte_17922, 2

loc_15229:				; CODE XREF: start+522Ej
		cmp	byte_17922, 0
		jnz	short loc_15229
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 1
		call	sub_168CE
		mov	bx, 13h
		mov	dx, 2E15h
		mov	ax, 12h
		mov	cx, 0B6h ; '¶'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_1526D
		cmp	ax, 1
		jnz	short loc_15265
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_15265:				; CODE XREF: start+5260j
		cmp	ax, 2
		jnz	short loc_1526D
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_1526D:				; CODE XREF: start+525Bj start+5268j
		mov	byte_17922, 1

loc_15272:				; CODE XREF: start+5277j
		cmp	byte_17922, 0
		jnz	short loc_15272
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 1
		call	sub_168CE
		mov	bx, 26h	; '&'
		mov	dx, 2E15h
		mov	ax, 12h
		mov	cx, 0B6h ; '¶'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_152B6
		cmp	ax, 1
		jnz	short loc_152AE
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_152AE:				; CODE XREF: start+52A9j
		cmp	ax, 2
		jnz	short loc_152B6
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_152B6:				; CODE XREF: start+52A4j start+52B1j
		mov	byte_17922, 2

loc_152BB:				; CODE XREF: start+52C0j
		cmp	byte_17922, 0
		jnz	short loc_152BB
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 1
		call	sub_168CE
		mov	bx, 39h	; '9'
		mov	dx, 2E15h
		mov	ax, 12h
		mov	cx, 0B6h ; '¶'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_152FF
		cmp	ax, 1
		jnz	short loc_152F7
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_152F7:				; CODE XREF: start+52F2j
		cmp	ax, 2
		jnz	short loc_152FF
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_152FF:				; CODE XREF: start+52EDj start+52FAj
		mov	byte_17922, 1

loc_15304:				; CODE XREF: start+5309j
		cmp	byte_17922, 0
		jnz	short loc_15304
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 1
		call	sub_168CE
		mov	bx, 3E80h
		mov	dx, 2E15h
		mov	ax, 12h
		mov	cx, 0B6h ; '¶'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_15348
		cmp	ax, 1
		jnz	short loc_15340
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_15340:				; CODE XREF: start+533Bj
		cmp	ax, 2
		jnz	short loc_15348
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_15348:				; CODE XREF: start+5336j start+5343j
		mov	byte_17922, 2

loc_1534D:				; CODE XREF: start+5352j
		cmp	byte_17922, 0
		jnz	short loc_1534D
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 1
		call	sub_168CE
		mov	bx, 3E93h
		mov	dx, 2E15h
		mov	ax, 12h
		mov	cx, 0B6h ; '¶'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_15391
		cmp	ax, 1
		jnz	short loc_15389
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_15389:				; CODE XREF: start+5384j
		cmp	ax, 2
		jnz	short loc_15391
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_15391:				; CODE XREF: start+537Fj start+538Cj
		mov	byte_17922, 1

loc_15396:				; CODE XREF: start+539Bj
		cmp	byte_17922, 0
		jnz	short loc_15396
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 1
		call	sub_168CE
		mov	bx, 3EA6h
		mov	dx, 2E15h
		mov	ax, 12h
		mov	cx, 0B6h ; '¶'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 5
		call	WaitFrames2
		jnb	short loc_153DA
		cmp	ax, 1
		jnz	short loc_153D2
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_153D2:				; CODE XREF: start+53CDj
		cmp	ax, 2
		jnz	short loc_153DA
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_153DA:				; CODE XREF: start+53C8j start+53D5j
		mov	byte_17922, 2

loc_153DF:				; CODE XREF: start+53E4j
		cmp	byte_17922, 0
		jnz	short loc_153DF
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 1
		call	sub_168CE
		mov	bx, 3EA6h
		mov	dx, 2E15h
		mov	ax, 12h
		mov	cx, 0B6h ; '¶'
		call	sub_16909
		mov	byte_17922, 1

loc_15407:				; CODE XREF: start+540Cj
		cmp	byte_17922, 0
		jnz	short loc_15407
		mov	DestFrmWaitTick, 1DEEh
		mov	DestFMWaitTick,	1938h
		mov	DestMIDWaitTick, 1956h
		call	WaitForMusic2
		jb	short loc_15428
		jmp	loc_151E7
; ---------------------------------------------------------------------------

loc_15428:				; CODE XREF: start+5423j
		cmp	ax, 1
		jz	short loc_1543D
		cmp	ax, 2
		jnz	short loc_15435
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_15435:				; CODE XREF: start+5430j
		cmp	ax, 3
		jnz	short loc_1543D
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_1543D:				; CODE XREF: start+542Bj start+5438j
		mov	DestFrmWaitTick, 1E60h
		mov	DestFMWaitTick,	1968h
		mov	DestMIDWaitTick, 1986h
		call	WaitForMusic1
		jnb	short loc_15464
		cmp	ax, 1
		jnz	short loc_1545C
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_1545C:				; CODE XREF: start+5457j
		cmp	ax, 2
		jnz	short loc_15464
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_15464:				; CODE XREF: start+5452j start+545Fj
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 41A0h
		mov	dx, 2E23h
		mov	ax, 0Fh
		mov	cx, 0B6h ; '¶'
		call	sub_169BD
		mov	byte_17922, 2

loc_15485:				; CODE XREF: start+548Aj
		cmp	byte_17922, 0
		jnz	short loc_15485
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 41AFh
		mov	dx, 2E23h
		mov	ax, 0Fh
		mov	cx, 0B6h ; '¶'
		call	sub_169BD
		mov	FrameCounter, 0
		mov	FramesToWait, 6
		call	WaitFrames2
		jnb	short loc_154C9
		cmp	ax, 1
		jnz	short loc_154C1
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_154C1:				; CODE XREF: start+54BCj
		cmp	ax, 2
		jnz	short loc_154C9
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_154C9:				; CODE XREF: start+54B7j start+54C4j
		mov	byte_17922, 1

loc_154CE:				; CODE XREF: start+54D3j
		cmp	byte_17922, 0
		jnz	short loc_154CE
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 41BEh
		mov	dx, 2E23h
		mov	ax, 0Fh
		mov	cx, 0B6h ; '¶'
		call	sub_169BD
		mov	FrameCounter, 0
		mov	FramesToWait, 6
		call	WaitFrames2
		jnb	short loc_15512
		cmp	ax, 1
		jnz	short loc_1550A
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_1550A:				; CODE XREF: start+5505j
		cmp	ax, 2
		jnz	short loc_15512
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_15512:				; CODE XREF: start+5500j start+550Dj
		mov	byte_17922, 2

loc_15517:				; CODE XREF: start+551Cj
		cmp	byte_17922, 0
		jnz	short loc_15517
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 41CDh
		mov	dx, 2E23h
		mov	ax, 0Fh
		mov	cx, 0B6h ; '¶'
		call	sub_169BD
		mov	FrameCounter, 0
		mov	FramesToWait, 6
		call	WaitFrames2
		jnb	short loc_1555B
		cmp	ax, 1
		jnz	short loc_15553
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_15553:				; CODE XREF: start+554Ej
		cmp	ax, 2
		jnz	short loc_1555B
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_1555B:				; CODE XREF: start+5549j start+5556j
		mov	byte_17922, 1

loc_15560:				; CODE XREF: start+5565j
		cmp	byte_17922, 0
		jnz	short loc_15560
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 41CDh
		mov	dx, 2E23h
		mov	ax, 0Fh
		mov	cx, 0B6h ; '¶'
		call	sub_169BD
		mov	byte_17922, 2

loc_15588:				; CODE XREF: start+558Dj
		cmp	byte_17922, 0
		jnz	short loc_15588
		mov	dx, 0
		call	sub_168A3
		mov	ax, 0FFFFh
		mov	si, offset aBOp_i04_gta	; "B:OP_I04.GTA"
		mov	word_1793A, 0
		mov	word_1793C, 0
		call	LoadGTA
		jnb	short loc_155AF
		jmp	ErrExit_fopen
; ---------------------------------------------------------------------------

loc_155AF:				; CODE XREF: start+55AAj
		mov	PaletteID, 0
		call	CopyPalette
		mov	dx, 1
		call	sub_168A3
		mov	ax, 0FFFFh
		mov	si, offset aBOp_i05_gta	; "B:OP_I05.GTA"
		mov	word_1793A, 0
		mov	word_1793C, 0
		call	LoadGTA
		jnb	short loc_155D7
		jmp	ErrExit_fopen
; ---------------------------------------------------------------------------

loc_155D7:				; CODE XREF: start+55D2j
		mov	PaletteID, 1
		call	CopyPalette
		mov	dx, 2
		call	sub_168A3
		mov	ax, 0FFFFh
		mov	si, offset aBOp_i06_gta	; "B:OP_I06.GTA"
		mov	word_1793A, 0
		mov	word_1793C, 0
		call	LoadGTA
		jnb	short loc_155FF
		jmp	ErrExit_fopen
; ---------------------------------------------------------------------------

loc_155FF:				; CODE XREF: start+55FAj
		mov	PaletteID, 2
		call	CopyPalette
		mov	DestFrmWaitTick, 1EBAh
		mov	DestFMWaitTick,	19E0h
		mov	DestMIDWaitTick, 19FEh
		call	WaitForMusic1
		jnb	short loc_1562E
		cmp	ax, 1
		jnz	short loc_15626
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_15626:				; CODE XREF: start+5621j
		cmp	ax, 2
		jnz	short loc_1562E
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_1562E:				; CODE XREF: start+561Cj start+5629j
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 0
		mov	dx, 0C3Dh
		mov	ax, 18h
		mov	cx, 122h
		call	sub_16909
		mov	byte_17922, 1

loc_1564F:				; CODE XREF: start+5654j
		cmp	byte_17922, 0
		jnz	short loc_1564F
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 19h
		mov	dx, 0C3Dh
		mov	ax, 18h
		mov	cx, 122h
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 14h
		call	WaitFrames2
		jnb	short loc_15693
		cmp	ax, 1
		jnz	short loc_1568B
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_1568B:				; CODE XREF: start+5686j
		cmp	ax, 2
		jnz	short loc_15693
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_15693:				; CODE XREF: start+5681j start+568Ej
		mov	byte_17922, 2

loc_15698:				; CODE XREF: start+569Dj
		cmp	byte_17922, 0
		jnz	short loc_15698
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 32h	; '2'
		mov	dx, 0C3Dh
		mov	ax, 18h
		mov	cx, 122h
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 14h
		call	WaitFrames2
		jnb	short loc_156DC
		cmp	ax, 1
		jnz	short loc_156D4
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_156D4:				; CODE XREF: start+56CFj
		cmp	ax, 2
		jnz	short loc_156DC
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_156DC:				; CODE XREF: start+56CAj start+56D7j
		mov	byte_17922, 1

loc_156E1:				; CODE XREF: start+56E6j
		cmp	byte_17922, 0
		jnz	short loc_156E1
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 1
		call	sub_168CE
		mov	bx, 0
		mov	dx, 0C3Dh
		mov	ax, 18h
		mov	cx, 122h
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 14h
		call	WaitFrames2
		jnb	short loc_15725
		cmp	ax, 1
		jnz	short loc_1571D
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_1571D:				; CODE XREF: start+5718j
		cmp	ax, 2
		jnz	short loc_15725
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_15725:				; CODE XREF: start+5713j start+5720j
		mov	byte_17922, 2

loc_1572A:				; CODE XREF: start+572Fj
		cmp	byte_17922, 0
		jnz	short loc_1572A
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 1
		call	sub_168CE
		mov	bx, 19h
		mov	dx, 0C3Dh
		mov	ax, 18h
		mov	cx, 122h
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 14h
		call	WaitFrames2
		jnb	short loc_1576E
		cmp	ax, 1
		jnz	short loc_15766
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_15766:				; CODE XREF: start+5761j
		cmp	ax, 2
		jnz	short loc_1576E
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_1576E:				; CODE XREF: start+575Cj start+5769j
		mov	byte_17922, 1

loc_15773:				; CODE XREF: start+5778j
		cmp	byte_17922, 0
		jnz	short loc_15773
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 1
		call	sub_168CE
		mov	bx, 32h	; '2'
		mov	dx, 0C3Dh
		mov	ax, 18h
		mov	cx, 122h
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 14h
		call	WaitFrames2
		jnb	short loc_157B7
		cmp	ax, 1
		jnz	short loc_157AF
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_157AF:				; CODE XREF: start+57AAj
		cmp	ax, 2
		jnz	short loc_157B7
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_157B7:				; CODE XREF: start+57A5j start+57B2j
		mov	byte_17922, 2

loc_157BC:				; CODE XREF: start+57C1j
		cmp	byte_17922, 0
		jnz	short loc_157BC
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 2
		call	sub_168CE
		mov	bx, 0
		mov	dx, 0C3Dh
		mov	ax, 18h
		mov	cx, 122h
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 14h
		call	WaitFrames2
		jnb	short loc_15800
		cmp	ax, 1
		jnz	short loc_157F8
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_157F8:				; CODE XREF: start+57F3j
		cmp	ax, 2
		jnz	short loc_15800
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_15800:				; CODE XREF: start+57EEj start+57FBj
		mov	byte_17922, 1

loc_15805:				; CODE XREF: start+580Aj
		cmp	byte_17922, 0
		jnz	short loc_15805
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 2
		call	sub_168CE
		mov	bx, 19h
		mov	dx, 0C3Dh
		mov	ax, 18h
		mov	cx, 122h
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 14h
		call	WaitFrames2
		jnb	short loc_15849
		cmp	ax, 1
		jnz	short loc_15841
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_15841:				; CODE XREF: start+583Cj
		cmp	ax, 2
		jnz	short loc_15849
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_15849:				; CODE XREF: start+5837j start+5844j
		mov	byte_17922, 2

loc_1584E:				; CODE XREF: start+5853j
		cmp	byte_17922, 0
		jnz	short loc_1584E
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 2
		call	sub_168CE
		mov	bx, 32h	; '2'
		mov	dx, 0C3Dh
		mov	ax, 18h
		mov	cx, 122h
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 14h
		call	WaitFrames2
		jnb	short loc_15892
		cmp	ax, 1
		jnz	short loc_1588A
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_1588A:				; CODE XREF: start+5885j
		cmp	ax, 2
		jnz	short loc_15892
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_15892:				; CODE XREF: start+5880j start+588Dj
		mov	byte_17922, 1

loc_15897:				; CODE XREF: start+589Cj
		cmp	byte_17922, 0
		jnz	short loc_15897
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 2
		call	sub_168CE
		mov	bx, 32h	; '2'
		mov	dx, 0C3Dh
		mov	ax, 18h
		mov	cx, 122h
		call	sub_16909
		mov	byte_17922, 2

loc_158BF:				; CODE XREF: start+58C4j
		cmp	byte_17922, 0
		jnz	short loc_158BF
		mov	dx, 0
		call	sub_168A3
		mov	ax, 0FFFFh
		mov	si, offset aBOp_i07_gta	; "B:OP_I07.GTA"
		mov	word_1793A, 0
		mov	word_1793C, 0
		call	LoadGTA
		jnb	short loc_158E6
		jmp	ErrExit_fopen
; ---------------------------------------------------------------------------

loc_158E6:				; CODE XREF: start+58E1j
		mov	PaletteID, 0
		call	CopyPalette
		mov	dx, 1
		call	sub_168A3
		mov	ax, 0FFFFh
		mov	si, offset aBOp_i08_gta	; "B:OP_I08.GTA"
		mov	word_1793A, 0
		mov	word_1793C, 0
		call	LoadGTA
		jnb	short loc_1590E
		jmp	ErrExit_fopen
; ---------------------------------------------------------------------------

loc_1590E:				; CODE XREF: start+5909j
		mov	PaletteID, 1
		call	CopyPalette

loc_15916:				; CODE XREF: start+4D67j
		mov	DestFrmWaitTick, 2028h
		mov	DestFMWaitTick,	1B18h
		mov	DestMIDWaitTick, 1B36h
		call	WaitForMusic1
		jnb	short loc_1593D
		cmp	ax, 1
		jnz	short loc_15935
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_15935:				; CODE XREF: start+5930j
		cmp	ax, 2
		jnz	short loc_1593D
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_1593D:				; CODE XREF: start+592Bj start+5938j
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		call	ClearPlane
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	PaletteID, 0
		mov	PalFadeStart, 100
		mov	byte_1793F, 0
		mov	byte_1793E, 1
		call	WaitForVSync
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 0
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	byte_17922, 1

loc_1597D:				; CODE XREF: start+5982j
		cmp	byte_17922, 0
		jnz	short loc_1597D
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		call	ClearPlane
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 28h	; '('
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 12h
		call	WaitFrames2
		jnb	short loc_159C8
		cmp	ax, 1
		jnz	short loc_159C0
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_159C0:				; CODE XREF: start+59BBj
		cmp	ax, 2
		jnz	short loc_159C8
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_159C8:				; CODE XREF: start+59B6j start+59C3j
		mov	byte_17922, 2

loc_159CD:				; CODE XREF: start+59D2j
		cmp	byte_17922, 0
		jnz	short loc_159CD
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 0
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 12h
		call	WaitFrames2
		jnb	short loc_15A11
		cmp	ax, 1
		jnz	short loc_15A09
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_15A09:				; CODE XREF: start+5A04j
		cmp	ax, 2
		jnz	short loc_15A11
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_15A11:				; CODE XREF: start+59FFj start+5A0Cj
		mov	byte_17922, 1

loc_15A16:				; CODE XREF: start+5A1Bj
		cmp	byte_17922, 0
		jnz	short loc_15A16
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 28h	; '('
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 12h
		call	WaitFrames2
		jnb	short loc_15A5A
		cmp	ax, 1
		jnz	short loc_15A52
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_15A52:				; CODE XREF: start+5A4Dj
		cmp	ax, 2
		jnz	short loc_15A5A
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_15A5A:				; CODE XREF: start+5A48j start+5A55j
		mov	byte_17922, 2

loc_15A5F:				; CODE XREF: start+5A64j
		cmp	byte_17922, 0
		jnz	short loc_15A5F
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 3E80h
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 12h
		call	WaitFrames2
		jnb	short loc_15AA3
		cmp	ax, 1
		jnz	short loc_15A9B
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_15A9B:				; CODE XREF: start+5A96j
		cmp	ax, 2
		jnz	short loc_15AA3
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_15AA3:				; CODE XREF: start+5A91j start+5A9Ej
		mov	byte_17922, 1

loc_15AA8:				; CODE XREF: start+5AADj
		cmp	byte_17922, 0
		jnz	short loc_15AA8
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 0
		call	sub_168CE
		mov	bx, 3EA8h
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 0Fh
		call	WaitFrames2
		jnb	short loc_15AEC
		cmp	ax, 1
		jnz	short loc_15AE4
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_15AE4:				; CODE XREF: start+5ADFj
		cmp	ax, 2
		jnz	short loc_15AEC
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_15AEC:				; CODE XREF: start+5ADAj start+5AE7j
		mov	byte_17922, 2

loc_15AF1:				; CODE XREF: start+5AF6j
		cmp	byte_17922, 0
		jnz	short loc_15AF1
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 1
		call	sub_168CE
		mov	bx, 0
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 6
		call	WaitFrames2
		jnb	short loc_15B35
		cmp	ax, 1
		jnz	short loc_15B2D
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_15B2D:				; CODE XREF: start+5B28j
		cmp	ax, 2
		jnz	short loc_15B35
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_15B35:				; CODE XREF: start+5B23j start+5B30j
		mov	byte_17922, 1

loc_15B3A:				; CODE XREF: start+5B3Fj
		cmp	byte_17922, 0
		jnz	short loc_15B3A
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 1
		call	sub_168CE
		mov	bx, 28h	; '('
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	FrameCounter, 0
		mov	FramesToWait, 6
		call	WaitFrames2
		jnb	short loc_15B7E
		cmp	ax, 1
		jnz	short loc_15B76
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_15B76:				; CODE XREF: start+5B71j
		cmp	ax, 2
		jnz	short loc_15B7E
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_15B7E:				; CODE XREF: start+5B6Cj start+5B79j
		mov	byte_17922, 2

loc_15B83:				; CODE XREF: start+5B88j
		cmp	byte_17922, 0
		jnz	short loc_15B83
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 1
		call	sub_168CE
		mov	bx, 28h	; '('
		mov	dx, 1B44h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	byte_17922, 1

loc_15BAB:				; CODE XREF: start+5BB0j
		cmp	byte_17922, 0
		jnz	short loc_15BAB
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	bx, 2
		mov	dx, 1
		call	sub_168CE
		mov	bx, 3E80h
		mov	dx, 5DC0h
		mov	ax, 50h	; 'P'
		mov	cx, 32h	; '2'
		call	sub_169BD
		mov	DestFrmWaitTick, 20CAh
		mov	DestFMWaitTick,	1BA8h
		mov	DestMIDWaitTick, 1BC6h
		call	WaitForMusic1
		jnb	short loc_15BF5
		cmp	ax, 1
		jnz	short loc_15BED
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_15BED:				; CODE XREF: start+5BE8j
		cmp	ax, 2
		jnz	short loc_15BF5
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_15BF5:				; CODE XREF: start+5BE3j start+5BF0j
		mov	byte_17922, 2

loc_15BFA:				; CODE XREF: start+5BFFj
		cmp	byte_17922, 0
		jnz	short loc_15BFA
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	dx, 0FFFFh
		call	sub_168A3
		mov	ax, 0FFFFh
		mov	si, offset aBOp_02a_gta	; "B:OP_02A.GTA"
		mov	word_1793A, 0
		mov	word_1793C, 0
		call	LoadGTA
		jnb	short loc_15C25
		jmp	ErrExit_fopen
; ---------------------------------------------------------------------------

loc_15C25:				; CODE XREF: start+5C20j
		mov	PaletteID, 1
		call	CopyPalette
		mov	dx, 1
		mov	bx, 1
		call	sub_168CE
		mov	bx, 0
		mov	dx, 0
		mov	ax, 50h	; 'P'
		mov	cx, 190h
		call	sub_16909
		mov	dx, 2
		mov	bx, 1
		call	sub_168CE
		mov	bx, 0
		mov	dx, 0
		mov	ax, 50h	; 'P'
		mov	cx, 190h
		call	sub_16909
		mov	dx, 2
		call	sub_168A3
		mov	ax, 0
		mov	si, offset aBOp_02b_gta	; "B:OP_02B.GTA"
		mov	word_1793A, 0
		mov	word_1793C, 0
		call	LoadGTA
		jnb	short loc_15C7D
		jmp	ErrExit_fopen
; ---------------------------------------------------------------------------

loc_15C7D:				; CODE XREF: start+5C78j
		mov	PaletteID, 2
		call	CopyPalette
		mov	DestFrmWaitTick, 217Eh
		mov	DestFMWaitTick,	1C38h
		mov	DestMIDWaitTick, 1C56h
		call	WaitForMusic1
		jnb	short loc_15CAC
		cmp	ax, 1
		jnz	short loc_15CA4
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_15CA4:				; CODE XREF: start+5C9Fj
		cmp	ax, 2
		jnz	short loc_15CAC
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_15CAC:				; CODE XREF: start+5C9Aj start+5CA7j
		mov	PaletteID, 0
		mov	PalFadeStart, 100
		mov	PalFadeEnd, 0
		mov	PalFadeInc, 2
		mov	PalFade_StepDelay, 1
		mov	byte_1793F, 1
		mov	byte_1793E, 1

loc_15CD3:				; CODE XREF: start+5CD8j
		cmp	byte_1793E, 0FFh
		jnz	short loc_15CD3
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		call	ClearPlane
		mov	byte_17922, 2

loc_15CE6:				; CODE XREF: start+5CEBj
		cmp	byte_17922, 0
		jnz	short loc_15CE6
		mov	PaletteID, 1
		mov	PalFadeStart, 100
		mov	byte_1793F, 0
		mov	byte_1793E, 1
		call	WaitForVSync
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		call	ClearPlane
		mov	bx, 2
		mov	dx, 1
		call	sub_168CE
		mov	bx, 0
		mov	dx, 0
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	DestFrmWaitTick, 21F0h
		mov	DestFMWaitTick,	1C98h
		mov	DestMIDWaitTick, 1CB6h
		call	WaitForMusic1
		jnb	short loc_15D4F
		cmp	ax, 1
		jnz	short loc_15D47
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_15D47:				; CODE XREF: start+5D42j
		cmp	ax, 2
		jnz	short loc_15D4F
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_15D4F:				; CODE XREF: start+5D3Dj start+5D4Aj
		mov	byte_17922, 1

loc_15D54:				; CODE XREF: start+5D59j
		cmp	byte_17922, 0
		jnz	short loc_15D54
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		call	ClearPlane
		mov	bx, 2
		mov	dx, 1
		call	sub_168CE
		mov	bx, 28h	; '('
		mov	dx, 28h	; '('
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	DestFrmWaitTick, 2202h
		mov	DestFMWaitTick,	1CAAh
		mov	DestMIDWaitTick, 1CC8h
		call	WaitForMusic1
		jnb	short loc_15DA5
		cmp	ax, 1
		jnz	short loc_15D9D
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_15D9D:				; CODE XREF: start+5D98j
		cmp	ax, 2
		jnz	short loc_15DA5
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_15DA5:				; CODE XREF: start+5D93j start+5DA0j
		mov	byte_17922, 2

loc_15DAA:				; CODE XREF: start+5DAFj
		cmp	byte_17922, 0
		jnz	short loc_15DAA
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		call	ClearPlane
		mov	bx, 2
		mov	dx, 1
		call	sub_168CE
		mov	bx, 3E80h
		mov	dx, 3E80h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	DestFrmWaitTick, 2214h
		mov	DestFMWaitTick,	1CBCh
		mov	DestMIDWaitTick, 1CDAh
		call	WaitForMusic1
		jnb	short loc_15DFB
		cmp	ax, 1
		jnz	short loc_15DF3
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_15DF3:				; CODE XREF: start+5DEEj
		cmp	ax, 2
		jnz	short loc_15DFB
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_15DFB:				; CODE XREF: start+5DE9j start+5DF6j
		mov	byte_17922, 1

loc_15E00:				; CODE XREF: start+5E05j
		cmp	byte_17922, 0
		jnz	short loc_15E00
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		call	ClearPlane
		mov	bx, 2
		mov	dx, 1
		call	sub_168CE
		mov	bx, 3EA8h
		mov	dx, 3EA8h
		mov	ax, 28h	; '('
		mov	cx, 0C8h ; 'È'
		call	sub_16909
		mov	DestFrmWaitTick, 2226h
		mov	DestFMWaitTick,	1CCEh
		mov	DestMIDWaitTick, 1CECh
		call	WaitForMusic1
		jnb	short loc_15E51
		cmp	ax, 1
		jnz	short loc_15E49
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_15E49:				; CODE XREF: start+5E44j
		cmp	ax, 2
		jnz	short loc_15E51
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_15E51:				; CODE XREF: start+5E3Fj start+5E4Cj
		mov	byte_17922, 2

loc_15E56:				; CODE XREF: start+5E5Bj
		cmp	byte_17922, 0
		jnz	short loc_15E56
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		call	ClearPlane
		mov	DestFrmWaitTick, 2238h
		mov	DestFMWaitTick,	1CE0h
		mov	DestMIDWaitTick, 1CFEh
		call	WaitForMusic1
		jnb	short loc_15E8B
		cmp	ax, 1
		jnz	short loc_15E83
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_15E83:				; CODE XREF: start+5E7Ej
		cmp	ax, 2
		jnz	short loc_15E8B
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_15E8B:				; CODE XREF: start+5E79j start+5E86j
		mov	byte_17922, 1

loc_15E90:				; CODE XREF: start+5E95j
		cmp	byte_17922, 0
		jnz	short loc_15E90
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		call	ClearPlane
		mov	bx, 2
		mov	dx, 1
		call	sub_168CE
		mov	bx, 0
		mov	dx, 0
		mov	ax, 50h	; 'P'
		mov	cx, 190h
		call	sub_16909
		mov	DestFrmWaitTick, 2292h
		mov	DestFMWaitTick,	1D28h
		mov	DestMIDWaitTick, 1D46h
		call	WaitForMusic1
		jnb	short loc_15EE1
		cmp	ax, 1
		jnz	short loc_15ED9
		jmp	ExitOK
; ---------------------------------------------------------------------------

loc_15ED9:				; CODE XREF: start+5ED4j
		cmp	ax, 2
		jnz	short loc_15EE1
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_15EE1:				; CODE XREF: start+5ECFj start+5EDCj
		mov	byte_17922, 2

loc_15EE6:				; CODE XREF: start+5EEBj
		cmp	byte_17922, 0
		jnz	short loc_15EE6
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		call	ClearPlane
		mov	bx, 2
		mov	dx, 2
		call	sub_168CE
		mov	bx, 0
		mov	dx, 0
		mov	ax, 50h	; 'P'
		mov	cx, 190h
		call	sub_16909
		mov	DestFrmWaitTick, 22A2h
		mov	DestFMWaitTick,	1D38h
		mov	DestMIDWaitTick, 1D56h
		call	WaitForMusic1
		jnb	short loc_15F34
		cmp	ax, 1
		jz	short ExitOK
		cmp	ax, 2
		jnz	short loc_15F34
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_15F34:				; CODE XREF: start+5F25j start+5F2Fj
		mov	byte_17922, 1

loc_15F39:				; CODE XREF: start+5F3Ej
		cmp	byte_17922, 0
		jnz	short loc_15F39
		mov	DestFrmWaitTick, 23E8h
		mov	DestFMWaitTick,	1E48h
		mov	DestMIDWaitTick, 1E66h
		call	WaitForMusic1
		jnb	short loc_15F64
		cmp	ax, 1
		jz	short ExitOK
		cmp	ax, 2
		jnz	short loc_15F64
		jmp	loc_10B68
; ---------------------------------------------------------------------------

loc_15F64:				; CODE XREF: start+5F55j start+5F5Fj
		mov	PaletteID, 1
		mov	PalFadeStart, 100
		mov	PalFadeEnd, 0
		mov	PalFadeInc, 2
		mov	PalFade_StepDelay, 2
		mov	byte_1793F, 1
		mov	byte_1793E, 1

loc_15F8B:				; CODE XREF: start+5F90j
		cmp	byte_1793E, 0FFh
		jnz	short loc_15F8B
		call	WaitForVSync
		call	WaitForVSync
		call	WaitForVSync
		call	WaitForVSync
		jmp	loc_1010E
; ---------------------------------------------------------------------------

ExitOK:					; CODE XREF: start+43Bj start+484j ...
		mov	ax, seg	seg001
		mov	ds, ax
		call	FadeMusic
		call	DoBlackPalette
		call	RestoreInts
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		call	ClearPlane
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		call	ClearPlane
		call	sub_167D7
		mov	al, 0
		out	76h, al
		call	sub_16B58
		mov	ax, 0C00h
		int	21h		; DOS -	CLEAR KEYBOARD BUFFER
					; AL must be 01h, 06h, 07h, 08h, or 0Ah.
		mov	ax, 4C00h
		int	21h		; DOS -	2+ - QUIT WITH EXIT CODE (EXIT)
start		endp			; AL = exit code


; =============== S U B	R O U T	I N E =======================================


DoBlackPalette	proc near		; CODE XREF: start+152p start+BACp ...
		push	ds
		mov	ax, seg	seg001
		mov	ds, ax
		mov	byte_1793E, 0
		mov	byte_1793F, 0
		mov	PaletteID, 0
		mov	PalFadeStart, 0
		mov	PalFadeEnd, 0
		mov	PalFadeInc, 0
		mov	PalFade_StepDelay, 0
		mov	PalFade_StepCntr, 0
		mov	word_1794C, 0
		pop	ds
		assume ds:nothing
		retn
DoBlackPalette	endp


; =============== S U B	R O U T	I N E =======================================


WaitForMusic1	proc near		; CODE XREF: start+431p start+47Ap ...
		push	ds
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		cmp	MusicMode, 1
		jz	short waitmus_fm
		cmp	MusicMode, 2
		jz	short waitmus_midi

loc_16020:				; CODE XREF: WaitForMusic1+29j
		cmp	byte_1758A, 0
		jnz	short loc_1606E
		cmp	byte_1758B, 7
		jz	short loc_16074
		mov	ax, DestFrmWaitTick
		cmp	CurFrameID, ax
		jle	short loc_16020
		jmp	short loc_16069
; ---------------------------------------------------------------------------

waitmus_fm:				; CODE XREF: WaitForMusic1+Bj
					; WaitForMusic1+42j
		cmp	byte_1758A, 0
		jnz	short loc_1606E
		cmp	byte_1758B, 7
		jz	short loc_16074
		mov	ax, DestFMWaitTick
		cmp	CurFMTick, ax
		jle	short waitmus_fm
		jmp	short loc_16069
; ---------------------------------------------------------------------------

waitmus_midi:				; CODE XREF: WaitForMusic1+12j
					; WaitForMusic1+5Bj
		cmp	byte_1758A, 0
		jnz	short loc_1606E
		cmp	byte_1758B, 7
		jz	short loc_16074
		mov	ax, DestMIDWaitTick
		cmp	CurMIDITick, ax
		jle	short waitmus_midi

loc_16069:				; CODE XREF: WaitForMusic1+2Bj
					; WaitForMusic1+44j
		pop	ds
		assume ds:nothing
		xor	ax, ax
		clc
		retn
; ---------------------------------------------------------------------------

loc_1606E:				; CODE XREF: WaitForMusic1+19j
					; WaitForMusic1+32j ...
		pop	ds
		mov	ax, 1
		stc
		retn
; ---------------------------------------------------------------------------

loc_16074:				; CODE XREF: WaitForMusic1+20j
					; WaitForMusic1+39j ...
		pop	ds
		mov	ax, 2
		stc
		retn
WaitForMusic1	endp


; =============== S U B	R O U T	I N E =======================================


WaitForMusic2	proc near		; CODE XREF: start+E53p start+15D6p ...
		push	ds
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		cmp	MusicMode, 1
		jz	short loc_160A7
		cmp	MusicMode, 2
		jz	short loc_160C0
		cmp	byte_1758A, 1
		jz	short loc_160E4
		cmp	byte_1758B, 7
		jz	short loc_160EA
		mov	ax, DestFrmWaitTick
		cmp	CurFrameID, ax
		jle	short loc_160D9
		jmp	short loc_160DE
; ---------------------------------------------------------------------------

loc_160A7:				; CODE XREF: WaitForMusic2+Bj
		cmp	byte_1758A, 1
		jz	short loc_160E4
		cmp	byte_1758B, 7
		jz	short loc_160EA
		mov	ax, DestFMWaitTick
		cmp	CurFMTick, ax
		jle	short loc_160D9
		jmp	short loc_160DE
; ---------------------------------------------------------------------------

loc_160C0:				; CODE XREF: WaitForMusic2+12j
		cmp	byte_1758A, 1
		jz	short loc_160E4
		cmp	byte_1758B, 7
		jz	short loc_160EA
		mov	ax, DestMIDWaitTick
		cmp	CurMIDITick, ax
		jle	short loc_160D9
		jmp	short loc_160DE
; ---------------------------------------------------------------------------

loc_160D9:				; CODE XREF: WaitForMusic2+29j
					; WaitForMusic2+42j ...
		pop	ds
		assume ds:nothing
		xor	ax, ax
		clc
		retn
; ---------------------------------------------------------------------------

loc_160DE:				; CODE XREF: WaitForMusic2+2Bj
					; WaitForMusic2+44j ...
		pop	ds
		mov	ax, 1
		stc
		retn
; ---------------------------------------------------------------------------

loc_160E4:				; CODE XREF: WaitForMusic2+19j
					; WaitForMusic2+32j ...
		pop	ds
		mov	ax, 2
		stc
		retn
; ---------------------------------------------------------------------------

loc_160EA:				; CODE XREF: WaitForMusic2+20j
					; WaitForMusic2+39j ...
		pop	ds
		mov	ax, 3
		stc
		retn
WaitForMusic2	endp


; =============== S U B	R O U T	I N E =======================================


WaitFrames2	proc near		; CODE XREF: start+D45p start+D8Ep ...
		push	ds
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001

loc_160F6:				; CODE XREF: WaitFrames2+1Bj
		cmp	byte_1758A, 0
		jnz	short loc_16112
		cmp	byte_1758B, 7
		jz	short loc_16118
		mov	ax, FramesToWait
		cmp	FrameCounter, ax
		jle	short loc_160F6
		pop	ds
		assume ds:nothing
		xor	ax, ax
		clc
		retn
; ---------------------------------------------------------------------------

loc_16112:				; CODE XREF: WaitFrames2+Bj
		pop	ds
		mov	ax, 1
		stc
		retn
; ---------------------------------------------------------------------------

loc_16118:				; CODE XREF: WaitFrames2+12j
		pop	ds
		mov	ax, 2
		stc
		retn
WaitFrames2	endp


; =============== S U B	R O U T	I N E =======================================


WaitFrames	proc near		; CODE XREF: start+1CBp start+201p ...
		push	ds
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001

loc_16124:				; CODE XREF: WaitFrames+Dj
		mov	ax, FramesToWait
		cmp	FrameCounter, ax
		jle	short loc_16124
		pop	ds
		assume ds:nothing
		retn
WaitFrames	endp

; ---------------------------------------------------------------------------

FrameInterrupt:				; DATA XREF: SetupInts+1Ao
		cli
		pushf
		pusha
		push	ds
		push	es
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		mov	ax, 0A000h
		mov	es, ax
		assume es:nothing
		cmp	byte_1790D, 1
		jnz	short loc_16148
		jmp	loc_1670C
; ---------------------------------------------------------------------------

loc_16148:				; CODE XREF: seg000:6143j
		mov	byte_1790D, 1
		cmp	byte_17920, 1
		jnz	short loc_1616A
		inc	word_17912
		cmp	word_17912, 5
		jnb	short loc_16161
		jmp	short loc_1616A
; ---------------------------------------------------------------------------

loc_16161:				; CODE XREF: seg000:615Dj
		mov	word_17912, 0
		jmp	loc_16714
; ---------------------------------------------------------------------------

loc_1616A:				; CODE XREF: seg000:6152j seg000:615Fj
		cmp	byte_17922, 0
		jz	short loc_1617D
		mov	al, byte_17922
		dec	al
		out	0A4h, al	; Interrupt Controller #2, 8259A
		mov	byte_17922, 0

loc_1617D:				; CODE XREF: seg000:616Fj
		cmp	byte_17932, 1
		jz	short loc_16187
		jmp	loc_16221
; ---------------------------------------------------------------------------

loc_16187:				; CODE XREF: seg000:6182j
		inc	byte_17933
		cmp	byte_17933, 6
		jnb	short loc_16195
		jmp	loc_16221
; ---------------------------------------------------------------------------

loc_16195:				; CODE XREF: seg000:6190j
		mov	byte_17933, 0
		cmp	byte_17934, 1
		jz	short loc_161E6
		mov	si, DispTextPtr
		mov	di, 0FA0h
		mov	cx, 50h
		xor	ax, ax
		rep stosw
		mov	di, 0FA0h	; DI = text buffer

parse_text_loop:			; CODE XREF: seg000:61D6j
		lodsw
		cmp	ah, 2Fh	; '/'
		jz	short loc_161D8	; character xx2F (usually //) -> line end
		or	ah, ah
		jz	short loc_161F6	; character xx00 (here 0000) ->	text end
		xchg	ah, al		; do Shift-JIS -> ROM access code conversion
		add	ah, ah
		sub	al, 1Fh
		js	short loc_161C8
		cmp	al, 61h
		adc	al, -22h

loc_161C8:				; CODE XREF: seg000:61C2j
		add	ax, 1FA1h
		and	ax, 7F7Fh
		xchg	ah, al
		sub	al, 20h
		stosw
		or	al, 80h
		stosw
		jmp	short parse_text_loop
; ---------------------------------------------------------------------------

loc_161D8:				; CODE XREF: seg000:61B6j
		mov	DispTextPtr, si
		mov	byte_17935, 0
		mov	byte_17934, 1

loc_161E6:				; CODE XREF: seg000:619Fj
		mov	al, byte_17935
		inc	al
		cmp	al, 10h
		jnb	short loc_161FD
		out	76h, al
		mov	byte_17935, al
		jmp	short loc_16221
; ---------------------------------------------------------------------------

loc_161F6:				; CODE XREF: seg000:61BAj
		mov	byte_17932, 0FFh
		jmp	short loc_16221
; ---------------------------------------------------------------------------

loc_161FD:				; CODE XREF: seg000:61EDj seg000:6201j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_161FD
		xor	al, al
		out	76h, al
		mov	ax, 0A000h
		mov	ds, ax
		assume ds:nothing
		mov	cx, 7D0h
		mov	si, 0A0h
		mov	di, 0
		rep movsw
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		mov	byte_17934, 0

loc_16221:				; CODE XREF: seg000:6184j seg000:6192j ...
		cmp	byte_17924, 1
		jnz	short loc_1628A
		mov	di, word_17936
		cmp	word_1792E, 0
		jnz	short loc_16256
		cmp	byte_17925, 1
		jz	short loc_16249
		mov	si, offset byte_178F2
		mov	word_1792C, si
		mov	word_1792E, 4
		jmp	short loc_16256
; ---------------------------------------------------------------------------

loc_16249:				; CODE XREF: seg000:6238j
		mov	si, offset byte_178F6
		mov	word_1792C, si
		mov	word_1792E, 8

loc_16256:				; CODE XREF: seg000:6231j seg000:6247j
		xor	ax, ax
		mov	si, word_1792C
		mov	al, [si]
		mov	es:[di], ax
		mov	es:[di+0A0h], ax
		mov	es:[di+140h], ax
		mov	es:[di+1E0h], ax
		inc	word_1792C
		dec	word_1792E
		jnz	short loc_1628A
		add	word_17936, 2
		dec	word_17928
		jnz	short loc_1628A
		mov	byte_17924, 0FFh

loc_1628A:				; CODE XREF: seg000:6226j seg000:6278j ...
		cmp	byte_1793E, 1
		jz	short loc_16294
		jmp	loc_164A4
; ---------------------------------------------------------------------------

loc_16294:				; CODE XREF: seg000:628Fj
		cmp	byte_1793F, 0
		jnz	short loc_1629E
		jmp	loc_163D1
; ---------------------------------------------------------------------------

loc_1629E:				; CODE XREF: seg000:6299j
		inc	PalFade_StepCntr
		cmp	byte_1793F, 1
		jnz	short loc_162AC
		jmp	loc_163DC
; ---------------------------------------------------------------------------

loc_162AC:				; CODE XREF: seg000:62A7j
		cmp	byte_1793F, 2
		jnz	short loc_162B6
		jmp	loc_16440
; ---------------------------------------------------------------------------

loc_162B6:				; CODE XREF: seg000:62B1j
		jmp	loc_164A4

; =============== S U B	R O U T	I N E =======================================


DoPalFade	proc near		; CODE XREF: seg000:loc_163D1p
					; seg000:63FCp	...
		xor	ax, ax
		mov	al, PaletteID
		cmp	al, 0FFh
		jz	short loc_162CB
		imul	si, ax,	30h
		add	si, offset Palette2
		jmp	short loc_162CE
; ---------------------------------------------------------------------------

loc_162CB:				; CODE XREF: DoPalFade+7j
		mov	si, offset Palette1

loc_162CE:				; CODE XREF: DoPalFade+10j
		mov	ax, PalFadeStart
		mov	bl, al
		mov	bh, 100
		mov	cx, 10h
		xor	ax, ax
		cmp	byte_17901, 1
		jz	short loc_162FC

loc_162E1:				; CODE XREF: DoPalFade+40j
		push	ax
		out	0A8h, al	; Interrupt Controller #2, 8259A
		lodsb
		call	DoPalColorMult
		out	0ACh, al	; Interrupt Controller #2, 8259A
		lodsb
		call	DoPalColorMult
		out	0AAh, al	; Interrupt Controller #2, 8259A
		lodsb
		call	DoPalColorMult
		out	0AEh, al	; Interrupt Controller #2, 8259A
		pop	ax
		inc	al
		loop	loc_162E1
		retn
; ---------------------------------------------------------------------------

loc_162FC:				; CODE XREF: DoPalFade+26j
					; DoPalFade+4Cj
		push	ax
		out	0A8h, al	; Interrupt Controller #2, 8259A
		call	sub_16308
		pop	ax
		inc	al
		loop	loc_162FC
		retn
DoPalFade	endp


; =============== S U B	R O U T	I N E =======================================


sub_16308	proc near		; CODE XREF: DoPalFade+46p
		push	ax
		push	bx
		push	cx
		push	dx
		xor	ax, ax
		lodsb
		call	DoPalColorMult
		xor	ah, ah
		mov	word_17B5E, ax
		xor	ax, ax
		lodsb
		call	DoPalColorMult
		xor	ah, ah
		mov	word_17B60, ax
		xor	ax, ax
		lodsb
		call	DoPalColorMult
		xor	ah, ah
		mov	word_17B62, ax
		mov	ax, word_17B5E
		mov	bx, ax
		shl	ax, 5
		add	bx, bx
		add	ax, bx
		add	bx, bx
		add	ax, bx
		mov	bx, word_17B60
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
		mov	bx, word_17B60
		mov	dx, bx
		shl	bx, 4
		sub	bx, dx
		add	ax, bx
		add	ax, 40h	; '@'
		shr	ax, 8
		mov	bx, 7
		sub	bx, ax
		add	bx, bx
		mov	dx, bx
		add	bx, bx
		add	bx, dx
		add	bx, offset byte_16393
		mov	ax, cs:[bx]
		out	0ACh, al	; Interrupt Controller #2, 8259A
		mov	ax, cs:[bx+2]
		out	0AAh, al	; Interrupt Controller #2, 8259A
		mov	ax, cs:[bx+4]
		out	0AEh, al	; Interrupt Controller #2, 8259A
		pop	dx
		pop	cx
		pop	bx
		pop	ax
		retn
sub_16308	endp

; ---------------------------------------------------------------------------
byte_16393	db  00h, 00h, 00h	; DATA XREF: sub_16308+71o
		db  00h, 00h, 00h
		db  00h, 00h, 00h
		db  00h, 0Fh, 00h
		db  0Fh, 00h, 00h
		db  00h, 00h, 00h
		db  0Fh, 00h, 00h
		db  00h, 0Fh, 00h
		db  00h, 00h, 0Fh
		db  00h, 00h, 00h
		db  00h, 00h, 0Fh
		db  00h, 0Fh, 00h
		db  0Fh, 00h, 0Fh
		db  00h, 00h, 00h
		db  0Fh, 00h, 0Fh
		db  00h, 0Fh, 00h

; =============== S U B	R O U T	I N E =======================================


DoPalColorMult	proc near		; CODE XREF: DoPalFade+2Cp
					; DoPalFade+32p ...
		mul	bl
		xor	dx, dx
		div	bh
		cmp	al, 10h
		jnb	short loc_163CE
		retn
; ---------------------------------------------------------------------------

loc_163CE:				; CODE XREF: DoPalColorMult+8j
		mov	al, 0Fh
		retn
DoPalColorMult	endp

; ---------------------------------------------------------------------------

loc_163D1:				; CODE XREF: seg000:629Bj
		call	DoPalFade
		mov	byte_1793E, 0FFh
		jmp	loc_164A4
; ---------------------------------------------------------------------------

loc_163DC:				; CODE XREF: seg000:62A9j
		mov	cx, PalFade_StepDelay
		cmp	cx, PalFade_StepCntr
		jz	short loc_163E9
		jmp	loc_164A4
; ---------------------------------------------------------------------------

loc_163E9:				; CODE XREF: seg000:63E4j
		mov	PalFade_StepCntr, 0
		mov	ax, PalFadeStart
		mov	bx, PalFadeEnd
		cmp	ax, bx
		jz	short loc_16430
		ja	short loc_16414
		call	DoPalFade
		mov	ax, PalFadeStart
		mov	bx, PalFadeInc
		add	ax, bx
		mov	PalFadeStart, ax
		cmp	ax, PalFadeEnd
		jnb	short loc_16430
		jmp	loc_164A4
; ---------------------------------------------------------------------------

loc_16414:				; CODE XREF: seg000:63FAj
		call	DoPalFade
		mov	ax, PalFadeStart
		mov	bx, PalFadeInc
		sub	ax, bx
		mov	PalFadeStart, ax
		jb	short loc_16430
		cmp	ax, PalFadeEnd
		jbe	short loc_16430
		mov	PalFadeStart, ax
		jmp	short loc_164A4
; ---------------------------------------------------------------------------

loc_16430:				; CODE XREF: seg000:63F8j seg000:640Fj ...
		mov	ax, PalFadeEnd
		mov	PalFadeStart, ax
		call	DoPalFade
		mov	byte_1793E, 0FFh
		jmp	short loc_164A4
; ---------------------------------------------------------------------------

loc_16440:				; CODE XREF: seg000:62B3j
		mov	cx, PalFade_StepDelay
		cmp	cx, PalFade_StepCntr
		jnz	short loc_164A4
		mov	PalFade_StepCntr, 0
		mov	ax, seg	seg001
		mov	es, ax
		assume es:seg001
		xor	ax, ax
		mov	al, PaletteID
		cmp	al, 0FFh
		jz	short loc_16467
		imul	si, ax,	30h
		add	si, offset Palette2
		jmp	short loc_1646A
; ---------------------------------------------------------------------------

loc_16467:				; CODE XREF: seg000:645Cj
		mov	si, offset Palette1

loc_1646A:				; CODE XREF: seg000:6465j
		mov	di, si
		mov	PalFadeStart, 100
		mov	cx, 10h
		push	si

loc_16476:				; CODE XREF: seg000:648Ej
		lodsb
		cmp	al, 0Fh
		jz	short loc_1647D
		inc	al

loc_1647D:				; CODE XREF: seg000:6479j
		stosb
		lodsb
		or	al, al
		jz	short loc_16485
		dec	al

loc_16485:				; CODE XREF: seg000:6481j
		stosb
		lodsb
		or	al, al
		jz	short loc_1648D
		dec	al

loc_1648D:				; CODE XREF: seg000:6489j
		stosb
		loop	loc_16476
		pop	si
		call	DoPalFade
		inc	word_1794C
		cmp	word_1794C, 0Fh
		jnz	short loc_164A4
		mov	byte_1793E, 0FFh

loc_164A4:				; CODE XREF: seg000:6291j
					; seg000:loc_162B6j ...
		cmp	cs:byte_16D9C, 1
		jz	short loc_164AF
		jmp	loc_1666B
; ---------------------------------------------------------------------------

loc_164AF:				; CODE XREF: seg000:64AAj
		mov	ax, cs:word_16D98
		test	ax, 1
		jnz	short loc_164BD
		shr	ax, 1
		jmp	loc_16597
; ---------------------------------------------------------------------------

loc_164BD:				; CODE XREF: seg000:64B6j
		mov	bx, cs:word_16D90
		mov	dx, cs:word_16D92
		mov	ds, cs:word_16CF8
		assume ds:nothing
		mov	si, bx
		mov	es, cs:word_16D00
		assume es:nothing
		mov	di, dx
		mov	cx, ax
		rep movsb
		mov	ds, cs:word_16CFA
		mov	si, bx
		mov	es, cs:word_16D02
		mov	di, dx
		mov	cx, ax
		rep movsb
		mov	ds, cs:word_16CFC
		mov	si, bx
		mov	es, cs:word_16D04
		mov	di, dx
		mov	cx, ax
		rep movsb
		mov	ds, cs:word_16CFE
		mov	si, bx
		mov	es, cs:word_16D06
		mov	di, dx
		mov	cx, ax
		rep movsb
		mov	bx, cs:word_16D94
		mov	dx, cs:word_16D96
		mov	ds, cs:word_16CF8
		mov	si, bx
		mov	es, cs:word_16D00
		mov	di, dx
		mov	cx, ax
		rep movsb
		mov	ds, cs:word_16CFA
		mov	si, bx
		mov	es, cs:word_16D02
		mov	di, dx
		mov	cx, ax
		rep movsb
		mov	ds, cs:word_16CFC
		mov	si, bx
		mov	es, cs:word_16D04
		mov	di, dx
		mov	cx, ax
		rep movsb
		mov	ds, cs:word_16CFE
		mov	si, bx
		mov	es, cs:word_16D06
		mov	di, dx
		mov	cx, ax
		rep movsb
		add	cs:word_16D90, 0A0h ; ' '
		add	cs:word_16D92, 0A0h ; ' '
		sub	cs:word_16D94, 0A0h ; ' '
		sub	cs:word_16D96, 0A0h ; ' '
		sub	cs:word_16D9A, 2
		cmp	cs:word_16D9A, 0
		jz	short loc_1658E
		jmp	loc_1666B
; ---------------------------------------------------------------------------

loc_1658E:				; CODE XREF: seg000:6589j
		mov	cs:byte_16D9C, 0FFh
		jmp	loc_1666B
; ---------------------------------------------------------------------------

loc_16597:				; CODE XREF: seg000:64BAj
		mov	bx, cs:word_16D90
		mov	dx, cs:word_16D92
		mov	ds, cs:word_16CF8
		mov	si, bx
		mov	es, cs:word_16D00
		mov	di, dx
		mov	cx, ax
		rep movsw
		mov	ds, cs:word_16CFA
		mov	si, bx
		mov	es, cs:word_16D02
		mov	di, dx
		mov	cx, ax
		rep movsw
		mov	ds, cs:word_16CFC
		mov	si, bx
		mov	es, cs:word_16D04
		mov	di, dx
		mov	cx, ax
		rep movsw
		mov	ds, cs:word_16CFE
		mov	si, bx
		mov	es, cs:word_16D06
		mov	di, dx
		mov	cx, ax
		rep movsw
		mov	bx, cs:word_16D94
		mov	dx, cs:word_16D96
		mov	ds, cs:word_16CF8
		mov	si, bx
		mov	es, cs:word_16D00
		mov	di, dx
		mov	cx, ax
		rep movsw
		mov	ds, cs:word_16CFA
		mov	si, bx
		mov	es, cs:word_16D02
		mov	di, dx
		mov	cx, ax
		rep movsw
		mov	ds, cs:word_16CFC
		mov	si, bx
		mov	es, cs:word_16D04
		mov	di, dx
		mov	cx, ax
		rep movsw
		mov	ds, cs:word_16CFE
		mov	si, bx
		mov	es, cs:word_16D06
		mov	di, dx
		mov	cx, ax
		rep movsw
		add	cs:word_16D90, 0A0h ; ' '
		add	cs:word_16D92, 0A0h ; ' '
		sub	cs:word_16D94, 0A0h ; ' '
		sub	cs:word_16D96, 0A0h ; ' '
		sub	cs:word_16D9A, 2
		cmp	cs:word_16D9A, 0
		jnz	short loc_1666B
		mov	cs:byte_16D9C, 0FFh

loc_1666B:				; CODE XREF: seg000:64ACj seg000:658Bj ...
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		xor	ax, ax
		mov	es, ax
		mov	ah, es:52Ah
		and	ah, 1
		mov	al, es:52Dh
		and	al, 10h
		or	ah, al
		mov	al, es:530h
		and	al, 10h
		or	ah, al
		or	byte_1758A, ah
		mov	ah, es:52Ah
		and	ah, 4
		mov	al, es:52Dh
		and	al, 3
		or	ah, al
		mov	byte_1758B, ah
		mov	ah, 9
		int	68h		;  - APPC/PC
		and	al, 3
		or	byte_1758A, al
		cmp	MusicMode, 1
		jz	short loc_166BE
		cmp	MusicMode, 2
		jz	short loc_166F5
		jmp	short loc_1670C
; ---------------------------------------------------------------------------

loc_166BE:				; CODE XREF: seg000:66B3j
		mov	ah, 16h
		int	60h		; call PMD driver
		not	al
		and	al, 30h
		or	byte_1758A, al
		push	ds
		mov	ah, 10h
		int	60h
		mov	ax, ds
		mov	es, ax
		assume es:seg001
		sub	dx, 2
		mov	bx, dx
		mov	bx, es:[bx]
		mov	ax, es:[bx+6Fh]
		mov	cl, es:[bx+2Bh]
		xor	ch, ch
		imul	cx
		mov	cl, es:[bx+2Ch]
		xor	ch, ch
		add	ax, cx
		pop	ds
		assume ds:nothing
		mov	ds:444h, ax
		jmp	short loc_1670C
; ---------------------------------------------------------------------------

loc_166F5:				; CODE XREF: seg000:66BAj
		mov	ah, 16h
		int	60h		; call PMD driver
		not	al
		and	al, 30h
		or	ds:0BAh, al
		mov	ah, 5
		xor	dx, dx
		int	61h		; reserved for user interrupt
		shr	ax, 1
		mov	ds:446h, ax

loc_1670C:				; CODE XREF: seg000:6145j seg000:66BCj ...
		inc	word ptr ds:43Eh
		inc	word ptr ds:440h

loc_16714:				; CODE XREF: seg000:6167j
		mov	byte ptr ds:43Dh, 0
		sti
		out	64h, al		; 8042 keyboard	controller command register.
		mov	al, 20h	; ' '
		out	0, al
		pop	es
		assume es:nothing
		pop	ds
		popa
		popf
		iret

; =============== S U B	R O U T	I N E =======================================


WaitForVSync	proc near		; CODE XREF: start:loc_1010Ep
					; start+111p ...
		push	ax

loc_16726:				; CODE XREF: WaitForVSync+5j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_16726

loc_1672C:				; CODE XREF: WaitForVSync+Bj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_1672C
		pop	ax
		retn
WaitForVSync	endp


; =============== S U B	R O U T	I N E =======================================


PlayBGM		proc near		; CODE XREF: start+3FFp start+C4Bp
		push	ax
		push	bx
		push	cx
		push	dx
		push	ds
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		cmp	MusicMode, 1
		jz	short loc_1674E	; FM mode - jump
		cmp	MusicMode, 2
		jz	short loc_16778	; MIDI mode - jump
		jmp	short loc_167A0
; ---------------------------------------------------------------------------

loc_1674E:				; CODE XREF: PlayBGM+Fj
		mov	ah, 1
		int	60h		; call PMD driver
		or	bl, bl
		jnz	short loc_1675B
		mov	dx, offset aBMusOp_1_m ; "B:MUS\\OP_1.M"
		jmp	short loc_1675E
; ---------------------------------------------------------------------------

loc_1675B:				; CODE XREF: PlayBGM+20j
		mov	dx, offset aBMusOp_2_m ; "B:MUS\\OP_2.M"

loc_1675E:				; CODE XREF: PlayBGM+25j
		call	fopen1_r
		jb	short loc_167A7
		mov	ah, 6
		int	60h		; call PMD driver
		mov	cx, 0FFFFh
		call	fread1
		jb	short loc_167A7
		call	fclose1
		mov	ah, 0
		int	60h		; call PMD driver
		jmp	short loc_167A0
; ---------------------------------------------------------------------------

loc_16778:				; CODE XREF: PlayBGM+16j
		mov	ah, 1
		int	61h		; call MMD driver
		or	bl, bl
		jnz	short loc_16785
		mov	dx, offset aBMusOp_1_n ; "B:MUS\\OP_1.N"
		jmp	short loc_16788
; ---------------------------------------------------------------------------

loc_16785:				; CODE XREF: PlayBGM+4Aj
		mov	dx, offset aBMusOp_2_n ; "B:MUS\\OP_2.N"

loc_16788:				; CODE XREF: PlayBGM+4Fj
		call	fopen1_r
		jb	short loc_167A7
		mov	ah, 6
		int	61h		; call MMD driver
		mov	cx, 0FFFFh
		call	fread1
		jb	short loc_167A7
		call	fclose1
		mov	ah, 0
		int	61h		; call MMD driver

loc_167A0:				; CODE XREF: PlayBGM+18j PlayBGM+42j
		pop	ds
		assume ds:nothing
		pop	dx
		pop	cx
		pop	bx
		pop	ax
		clc
		retn
; ---------------------------------------------------------------------------

loc_167A7:				; CODE XREF: PlayBGM+2Dj PlayBGM+39j ...
		pop	ds
		pop	dx
		pop	cx
		pop	bx
		pop	ax
		stc
		retn
PlayBGM		endp


; =============== S U B	R O U T	I N E =======================================


FadeMusic	proc near		; CODE XREF: start+5FA6p seg000:6C74p	...
		push	ax
		push	ds
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		cmp	MusicMode, 1
		jz	short loc_167C5	; FM mode - jump
		cmp	MusicMode, 2
		jz	short loc_167CD	; MIDI mode - jump
		jmp	short loc_167D3
; ---------------------------------------------------------------------------

loc_167C5:				; CODE XREF: FadeMusic+Cj
		mov	al, 20
		mov	ah, 2
		int	60h		; call PMD driver
		jmp	short loc_167D3
; ---------------------------------------------------------------------------

loc_167CD:				; CODE XREF: FadeMusic+13j
		mov	al, 5
		mov	ah, 2
		int	61h		; call MMD driver

loc_167D3:				; CODE XREF: FadeMusic+15j
					; FadeMusic+1Dj
		pop	ds
		assume ds:nothing
		pop	ax
		clc
		retn
FadeMusic	endp


; =============== S U B	R O U T	I N E =======================================


sub_167D7	proc near		; CODE XREF: start+8Ep	start+5FBDp ...
		push	ax
		mov	al, 0
		out	70h, al		; CMOS Memory:
					; used by real-time clock
		mov	al, 0Fh
		out	72h, al
		mov	al, 10h
		out	74h, al
		mov	al, 0
		out	78h, al
		mov	al, 18h
		out	7Ah, al
		pop	ax
		retn
sub_167D7	endp


; =============== S U B	R O U T	I N E =======================================


SetupInts	proc near		; CODE XREF: start+10Bp
		cli
		pushf
		pusha
		push	es
		xor	ax, ax
		mov	es, ax
		assume es:nothing, ds:seg001
		mov	dx, es:28h
		mov	cx, es:2Ah
		mov	word_17909, dx
		mov	word_1790B, cx
		mov	ax, offset FrameInterrupt
		mov	es:28h,	ax
		mov	word ptr es:2Ah, cs
		in	al, 2		; DMA controller, 8237A-5.
					; channel 1 current address
		and	al, 0FBh
		out	2, al		; DMA controller, 8237A-5.
					; channel 1 base address
					; (also	sets current address)
		out	64h, al		; 8042 keyboard	controller command register.
		mov	byte_1757F, 1
		pop	es
		assume es:nothing
		popa
		popf
		sti
		retn
SetupInts	endp


; =============== S U B	R O U T	I N E =======================================


RestoreInts	proc near		; CODE XREF: start+5FACp seg000:6C77p	...
		cli
		pushf
		pusha
		push	es
		cmp	byte_1757F, 1
		jnz	short loc_16855
		in	al, 2		; DMA controller, 8237A-5.
					; channel 1 current address
		or	al, 4
		out	2, al		; DMA controller, 8237A-5.
					; channel 1 base address
					; (also	sets current address)
		mov	dx, word_17909
		mov	cx, word_1790B
		xor	ax, ax
		mov	es, ax
		assume es:nothing
		mov	es:28h,	dx
		mov	es:2Ah,	cx
		in	al, 2		; DMA controller, 8237A-5.
					; channel 1 current address
		and	al, 0FBh
		out	2, al		; DMA controller, 8237A-5.
					; channel 1 base address
					; (also	sets current address)
		out	64h, al		; 8042 keyboard	controller command register.

loc_16855:				; CODE XREF: RestoreInts+9j
		pop	es
		assume es:nothing
		popa
		popf
		sti
		retn
RestoreInts	endp


; =============== S U B	R O U T	I N E =======================================


DoSomeMalloc	proc near		; CODE XREF: start+C3p	start+D1p ...
		push	ax
		push	bx
		push	cx
		push	si
		push	ds
		shl	si, 3
		add	si, offset byte_16D08
		shr	cx, 4
		inc	cx
		mov	bx, cx
		mov	ah, 48h
		int	21h		; DOS -	2+ - ALLOCATE MEMORY
					; BX = number of 16-byte paragraphs desired
		mov	cs:[si], ax
		jb	short loc_1689C
		mov	bx, cx
		mov	ah, 48h
		int	21h		; DOS -	2+ - ALLOCATE MEMORY
					; BX = number of 16-byte paragraphs desired
		mov	cs:[si+2], ax
		jb	short loc_1689C
		mov	bx, cx
		mov	ah, 48h
		int	21h		; DOS -	2+ - ALLOCATE MEMORY
					; BX = number of 16-byte paragraphs desired
		mov	cs:[si+4], ax
		jb	short loc_1689C
		mov	bx, cx
		mov	ah, 48h
		int	21h		; DOS -	2+ - ALLOCATE MEMORY
					; BX = number of 16-byte paragraphs desired
		mov	cs:[si+6], ax
		jb	short loc_1689C
		clc
		jmp	short loc_1689D
; ---------------------------------------------------------------------------

loc_1689C:				; CODE XREF: start+F0j
					; DoSomeMalloc+19j ...
		stc

loc_1689D:				; CODE XREF: DoSomeMalloc+40j
		pop	ds
		assume ds:nothing
		pop	si
		pop	cx
		pop	bx
		pop	ax
		retn
DoSomeMalloc	endp


; =============== S U B	R O U T	I N E =======================================


sub_168A3	proc near		; CODE XREF: start+176p start+28Ep ...
		pusha
		push	ds
		push	es
		mov	ax, cs
		mov	ds, ax
		assume ds:seg000
		mov	ax, seg	seg001
		mov	es, ax
		assume es:seg001
		cmp	dx, 0FFFFh
		jz	short loc_168BF
		shl	dx, 3
		add	dx, offset byte_16D08
		mov	si, dx
		jmp	short loc_168C2
; ---------------------------------------------------------------------------

loc_168BF:				; CODE XREF: sub_168A3+Fj
		mov	si, offset word_16CF0

loc_168C2:				; CODE XREF: sub_168A3+1Aj
		mov	di, 0B0h
		mov	cx, 4
		rep movsw
		pop	es
		assume es:nothing
		pop	ds
		assume ds:nothing
		popa
		retn
sub_168A3	endp


; =============== S U B	R O U T	I N E =======================================


sub_168CE	proc near		; CODE XREF: start+63Fp start+69Fp ...
		pusha
		push	ds
		push	es
		mov	ax, cs
		mov	ds, ax
		assume ds:seg000
		mov	es, ax
		assume es:seg000
		shl	dx, 3
		add	dx, offset byte_16D08
		mov	di, offset word_16CF8
		test	bx, 2
		jz	short loc_168EB
		mov	si, dx
		jmp	short loc_168EE
; ---------------------------------------------------------------------------

loc_168EB:				; CODE XREF: sub_168CE+17j
		mov	si, offset word_16CF0

loc_168EE:				; CODE XREF: sub_168CE+1Bj
		mov	cx, 4
		rep movsw
		test	bx, 1
		jz	short loc_168FD
		mov	si, dx
		jmp	short loc_16900
; ---------------------------------------------------------------------------

loc_168FD:				; CODE XREF: sub_168CE+29j
		mov	si, offset word_16CF0

loc_16900:				; CODE XREF: sub_168CE+2Dj
		mov	cx, 4
		rep movsw
		pop	es
		assume es:nothing
		pop	ds
		assume ds:nothing
		popa
		retn
sub_168CE	endp


; =============== S U B	R O U T	I N E =======================================


sub_16909	proc near		; CODE XREF: start+A89p start+D0Cp ...
		pusha
		push	ds
		push	es
		test	ax, 1
		jz	short loc_16965

loc_16911:				; CODE XREF: sub_16909+58j
		push	cx
		mov	ds, cs:word_16CF8
		assume ds:nothing
		mov	si, bx
		mov	es, cs:word_16D00
		assume es:nothing
		mov	di, dx
		mov	cx, ax
		rep movsb
		mov	ds, cs:word_16CFA
		mov	si, bx
		mov	es, cs:word_16D02
		mov	di, dx
		mov	cx, ax
		rep movsb
		mov	ds, cs:word_16CFC
		mov	si, bx
		mov	es, cs:word_16D04
		mov	di, dx
		mov	cx, ax
		rep movsb
		mov	ds, cs:word_16CFE
		mov	si, bx
		mov	es, cs:word_16D06
		mov	di, dx
		mov	cx, ax
		rep movsb
		add	bx, 50h	; 'P'
		add	dx, 50h	; 'P'
		pop	cx
		loop	loc_16911
		jmp	short loc_169B9
; ---------------------------------------------------------------------------

loc_16965:				; CODE XREF: sub_16909+6j
		shr	ax, 1

loc_16967:				; CODE XREF: sub_16909+AEj
		push	cx
		mov	ds, cs:word_16CF8
		mov	si, bx
		mov	es, cs:word_16D00
		mov	di, dx
		mov	cx, ax
		rep movsw
		mov	ds, cs:word_16CFA
		mov	si, bx
		mov	es, cs:word_16D02
		mov	di, dx
		mov	cx, ax
		rep movsw
		mov	ds, cs:word_16CFC
		mov	si, bx
		mov	es, cs:word_16D04
		mov	di, dx
		mov	cx, ax
		rep movsw
		mov	ds, cs:word_16CFE
		mov	si, bx
		mov	es, cs:word_16D06
		mov	di, dx
		mov	cx, ax
		rep movsw
		add	bx, 50h	; 'P'
		add	dx, 50h	; 'P'
		pop	cx
		loop	loc_16967

loc_169B9:				; CODE XREF: sub_16909+5Aj
		pop	es
		assume es:nothing
		pop	ds
		assume ds:nothing
		popa
		retn
sub_16909	endp


; =============== S U B	R O U T	I N E =======================================


sub_169BD	proc near		; CODE XREF: start+942p start+981p ...
		pusha
		push	ds
		push	es
		mov	si, bx
		mov	di, dx
		mov	dx, ax
		xor	dh, dh
		test	dx, 1
		jnz	short loc_169D1
		jmp	loc_16A58
; ---------------------------------------------------------------------------

loc_169D1:				; CODE XREF: sub_169BD+Fj
					; sub_169BD+95j
		push	cx
		push	si
		push	di
		mov	cl, dl

loc_169D6:				; CODE XREF: sub_169BD+87j
		mov	ds, cs:word_16CF8
		assume ds:nothing
		mov	ah, [si]
		mov	ds, cs:word_16CFA
		mov	bl, [si]
		mov	ds, cs:word_16CFC
		mov	bh, [si]
		mov	ds, cs:word_16CFE
		mov	dh, [si]
		mov	al, ah
		or	al, bl
		or	al, bh
		or	al, dh
		and	ah, al
		and	bl, al
		and	bh, al
		and	dh, al
		not	al
		mov	es, cs:word_16D00
		assume es:nothing
		mov	ch, es:[di]
		and	ch, al
		or	ch, ah
		mov	es:[di], ch
		mov	es, cs:word_16D02
		mov	ch, es:[di]
		and	ch, al
		or	ch, bl
		mov	es:[di], ch
		mov	es, cs:word_16D04
		mov	ch, es:[di]
		and	ch, al
		or	ch, bh
		mov	es:[di], ch
		mov	es, cs:word_16D06
		mov	ch, es:[di]
		and	ch, al
		or	ch, dh
		mov	es:[di], ch
		inc	si
		inc	di
		xor	ch, ch
		loop	loc_169D6
		pop	di
		pop	si
		pop	cx
		add	si, 50h	; 'P'
		add	di, 50h	; 'P'
		dec	cx
		jz	short loc_16A55
		jmp	loc_169D1
; ---------------------------------------------------------------------------

loc_16A55:				; CODE XREF: sub_169BD+93j
		jmp	loc_16B0C
; ---------------------------------------------------------------------------

loc_16A58:				; CODE XREF: sub_169BD+11j
		shr	dx, 1

loc_16A5A:				; CODE XREF: sub_169BD+14Cj
		push	cx
		push	si
		push	di
		mov	cx, dx

loc_16A5F:				; CODE XREF: sub_169BD+13Dj
		mov	ds, cs:word_16CF8
		mov	ax, [si]
		mov	bx, ax
		mov	cs:word_16D88, ax
		mov	ds, cs:word_16CFA
		mov	ax, [si]
		or	bx, ax
		mov	cs:word_16D8A, ax
		mov	ds, cs:word_16CFC
		mov	ax, [si]
		or	bx, ax
		mov	cs:word_16D8C, ax
		mov	ds, cs:word_16CFE
		mov	ax, [si]
		or	bx, ax
		mov	cs:word_16D8E, ax
		and	cs:word_16D88, bx
		and	cs:word_16D8A, bx
		and	cs:word_16D8C, bx
		and	cs:word_16D8E, bx
		not	bx
		mov	es, cs:word_16D00
		mov	ax, es:[di]
		and	ax, bx
		or	ax, cs:word_16D88
		mov	es:[di], ax
		mov	es, cs:word_16D02
		mov	ax, es:[di]
		and	ax, bx
		or	ax, cs:word_16D8A
		mov	es:[di], ax
		mov	es, cs:word_16D04
		mov	ax, es:[di]
		and	ax, bx
		or	ax, cs:word_16D8C
		mov	es:[di], ax
		mov	es, cs:word_16D06
		mov	ax, es:[di]
		and	ax, bx
		or	ax, cs:word_16D8E
		mov	es:[di], ax
		add	si, 2
		add	di, 2
		dec	cx
		jz	short loc_16AFD
		jmp	loc_16A5F
; ---------------------------------------------------------------------------

loc_16AFD:				; CODE XREF: sub_169BD+13Bj
		pop	di
		pop	si
		add	si, 50h	; 'P'
		add	di, 50h	; 'P'
		pop	cx
		dec	cx
		jz	short loc_16B0C
		jmp	loc_16A5A
; ---------------------------------------------------------------------------

loc_16B0C:				; CODE XREF: sub_169BD:loc_16A55j
					; sub_169BD+14Aj
		pop	es
		assume es:nothing
		pop	ds
		assume ds:nothing
		popa
		retn
sub_169BD	endp

		assume ds:seg001

; =============== S U B	R O U T	I N E =======================================


sub_16B10	proc near		; CODE XREF: start+8Bp
		push	ax
		push	cx
		push	di
		push	es
		mov	ah, 41h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		mov	ah, 0Bh
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		mov	byte_17921, al
		mov	ah, 42h
		mov	ch, 0C0h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		mov	al, 2
		out	68h, al
		mov	al, 1
		out	6Ah, al
		mov	al, 41h
		out	6Ah, al
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		call	ClearPlane
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		call	ClearPlane
		mov	ax, 0A000h
		mov	es, ax
		assume es:nothing
		xor	di, di
		mov	cx, 7D0h
		xor	ah, ah
		mov	al, 0
		rep stosw
		mov	ah, 40h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		pop	es
		assume es:nothing
		pop	di
		pop	cx
		pop	ax
		retn
sub_16B10	endp


; =============== S U B	R O U T	I N E =======================================


sub_16B58	proc near		; CODE XREF: start+5FC4p seg000:6C8Fp	...
		push	ax
		mov	al, byte_17921
		mov	ah, 0Ah
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		pop	ax
		retn
sub_16B58	endp


; =============== S U B	R O U T	I N E =======================================


ClearPlane	proc near		; CODE XREF: start+159p start+160p ...
		push	ax
		push	cx
		push	dx
		push	es
		mov	al, 80h	; '€'
		out	7Ch, al
		xor	al, al
		mov	dx, 7Eh	; '~'
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
		pop	es
		assume es:nothing
		pop	dx
		pop	cx
		pop	ax
		retn
ClearPlane	endp


; =============== S U B	R O U T	I N E =======================================


LoadGTA		proc near		; CODE XREF: start+18Bp start+2A3p ...
		cmp	cs:byte_16CEE, 1
		jnz	short loc_16B90
		add	si, 2

loc_16B90:				; CODE XREF: LoadGTA+6j
		cmp	al, 0FFh
		jz	short loc_16B9B
		mov	ah, al
		mov	al, 40h	; '@'
		push	ax
		jmp	short loc_16B9D
; ---------------------------------------------------------------------------

loc_16B9B:				; CODE XREF: LoadGTA+Dj
		push	0

loc_16B9D:				; CODE XREF: LoadGTA+14j
		push	0
		push	word_1793C
		push	word_1793A
		push	6000h
		push	word_17938
		push	0
		push	ds
		push	si
		call	sub_16DA2
		add	sp, 12h
		or	ax, ax
		jnz	short loc_16BC0
		clc
		retn
; ---------------------------------------------------------------------------

loc_16BC0:				; CODE XREF: LoadGTA+37j
		stc
		retn
LoadGTA		endp


; =============== S U B	R O U T	I N E =======================================


CopyPalette	proc near		; CODE XREF: start+198p start+2B0p ...
		push	ax
		push	cx
		push	si
		push	di
		push	ds
		push	es
		mov	ax, seg	seg001
		mov	ds, ax
		mov	es, ax
		assume es:seg001
		xor	ax, ax
		mov	al, PaletteID
		mov	si, offset Palette1
		imul	di, ax,	30h
		add	di, offset Palette2
		mov	cx, 18h
		rep movsw
		pop	es
		assume es:nothing
		pop	ds
		assume ds:nothing
		pop	di
		pop	si
		pop	cx
		pop	ax
		retn
CopyPalette	endp

; ---------------------------------------------------------------------------
		push	ax
		push	bx
		push	cx
		push	es
		push	ax
		mov	ax, 0A000h
		mov	es, ax
		assume es:nothing
		pop	ax
		xor	bx, bx
		mov	cx, 4

loc_16BFA:				; CODE XREF: seg000:6C0Fj
		rol	ax, 4
		mov	bl, al
		and	bx, 0Fh
		mov	bl, byte ptr cs:a0123456789abcd[bx] ; "0123456789ABCDEF"
		mov	es:[di], bl
		inc	di
		mov	es:[di], bh
		inc	di
		loop	loc_16BFA
		pop	es
		assume es:nothing
		pop	cx
		pop	bx
		pop	ax
		retn
; ---------------------------------------------------------------------------
a0123456789abcd	db '0123456789ABCDEF'   ; DATA XREF: seg000:6C02r

; =============== S U B	R O U T	I N E =======================================


fopen1_r	proc near		; CODE XREF: start+41p
					; PlayBGM:loc_1675Ep ...
		push	dx
		push	ds
		push	es
		cmp	cs:byte_16CEE, 1
		jnz	short loc_16C34
		add	dx, 2

loc_16C34:				; CODE XREF: fopen1_r+9j
		mov	ax, 3D00h
		int	21h		; DOS -	2+ - OPEN DISK FILE WITH HANDLE
					; DS:DX	-> ASCIZ filename
					; AL = access mode
					; 0 - read
		push	ax
		mov	ax, seg	seg001
		mov	es, ax
		assume es:seg001
		pop	ax
		mov	ds:hFile, ax
		pop	es
		assume es:nothing
		pop	ds
		pop	dx
		retn
fopen1_r	endp


; =============== S U B	R O U T	I N E =======================================


fread1		proc near		; CODE XREF: start+4Fp	PlayBGM+36p ...
		push	bx
		push	cx
		push	es
		mov	ax, seg	seg001
		mov	es, ax
		assume es:seg001
		mov	bx, es:hFile
		mov	ah, 3Fh
		int	21h		; DOS -	2+ - READ FROM FILE WITH HANDLE
					; BX = file handle, CX = number	of bytes to read
					; DS:DX	-> buffer
		pop	es
		assume es:nothing
		pop	cx
		pop	bx
		retn
fread1		endp


; =============== S U B	R O U T	I N E =======================================


fclose1		proc near		; CODE XREF: start:loc_10057p
					; PlayBGM+3Bp ...
		push	ax
		push	bx
		mov	ax, seg	seg001
		mov	es, ax
		assume es:seg001
		mov	bx, es:hFile
		mov	ah, 3Eh
		int	21h		; DOS -	2+ - CLOSE A FILE WITH HANDLE
					; BX = file handle
		pop	bx
		pop	ax
		retn
fclose1		endp

; ---------------------------------------------------------------------------

ErrExit_fopen:				; CODE XREF: start+46j	start+54j ...
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		call	FadeMusic
		call	RestoreInts
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		call	ClearPlane
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		call	ClearPlane
		call	sub_167D7
		mov	al, 0
		out	76h, al
		call	sub_16B58
		mov	dx, offset aStudioTwinKleB ; "Studio Twin'kle u•‘–²v Opening Progra"...
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		mov	dx, offset aFileNotFound ; "ƒtƒ@ƒCƒ‹‚ªŒ©‚Â‚©‚è‚Ü‚¹‚ñ.\r\n$"
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		mov	ax, 0C00h
		int	21h		; DOS -	CLEAR KEYBOARD BUFFER
					; AL must be 01h, 06h, 07h, 08h, or 0Ah.
		mov	ah, 7
		int	21h		; DOS -	DIRECT STDIN INPUT, NO ECHO
		mov	ax, 4C01h
		int	21h		; DOS -	2+ - QUIT WITH EXIT CODE (EXIT)
					; AL = exit code
; ---------------------------------------------------------------------------

ErrExit_malloc:				; CODE XREF: start+B7j	start+C8j ...
		mov	ax, seg	seg001
		mov	ds, ax
		call	FadeMusic
		call	RestoreInts
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		call	ClearPlane
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		call	ClearPlane
		call	sub_167D7
		mov	al, 0
		out	76h, al
		call	sub_16B58
		mov	dx, offset aStudioTwinKleB ; "Studio Twin'kle u•‘–²v Opening Progra"...
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		mov	dx, offset aMallocError	; "ƒƒ‚ƒŠ‚ªŠm•Ûo—ˆ‚Ü‚¹‚ñ.\r\n$"
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		mov	ax, 0C00h
		int	21h		; DOS -	CLEAR KEYBOARD BUFFER
					; AL must be 01h, 06h, 07h, 08h, or 0Ah.
		mov	ah, 7
		int	21h		; DOS -	DIRECT STDIN INPUT, NO ECHO
		mov	ax, 4C01h
		int	21h		; DOS -	2+ - QUIT WITH EXIT CODE (EXIT)
					; AL = exit code
; ---------------------------------------------------------------------------
		align 2
byte_16CEE	db 0			; DATA XREF: start+1w start:loc_1002Bw ...
		db 90h
word_16CF0	dw 0A800h		; DATA XREF: sub_168A3:loc_168BFo
					; sub_168CE:loc_168EBo	...
		dw 0B000h
		dw 0B800h
		dw 0E000h
word_16CF8	dw 0			; DATA XREF: seg000:64C7r seg000:6519r ...
word_16CFA	dw 0			; DATA XREF: seg000:64D9r seg000:652Br ...
word_16CFC	dw 0			; DATA XREF: seg000:64EBr seg000:653Dr ...
word_16CFE	dw 0			; DATA XREF: seg000:64FDr seg000:654Fr ...
word_16D00	dw 0			; DATA XREF: seg000:64CEr seg000:6520r ...
word_16D02	dw 0			; DATA XREF: seg000:64E0r seg000:6532r ...
word_16D04	dw 0			; DATA XREF: seg000:64F2r seg000:6544r ...
word_16D06	dw 0			; DATA XREF: seg000:6504r seg000:6556r ...
byte_16D08	db 80h dup(0)		; DATA XREF: DoSomeMalloc+8o
					; sub_168A3+14o ...
word_16D88	dw 0			; DATA XREF: sub_169BD+ABw
					; sub_169BD+D6w ...
word_16D8A	dw 0			; DATA XREF: sub_169BD+B8w
					; sub_169BD+DBw ...
word_16D8C	dw 0			; DATA XREF: sub_169BD+C5w
					; sub_169BD+E0w ...
word_16D8E	dw 0			; DATA XREF: sub_169BD+D2w
					; sub_169BD+E5w ...
word_16D90	dw 0			; DATA XREF: start+64Bw start+6ABw ...
word_16D92	dw 0			; DATA XREF: start+650w start+6B0w ...
word_16D94	dw 0			; DATA XREF: start+669w start+6C9w ...
word_16D96	dw 0			; DATA XREF: start+66Ew start+6CEw ...
word_16D98	dw 0			; DATA XREF: start+655w start+6B5w ...
word_16D9A	dw 0			; DATA XREF: start+65Cw start+6BCw ...
byte_16D9C	db 0			; DATA XREF: start+673w
					; start:loc_10679r ...
		align 2
word_16D9E	dw 0			; DATA XREF: seg000:6DDAw fread2+1Dr ...
word_16DA0	dw 0			; DATA XREF: seg000:6DDFw seg000:6E65r

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_16DA2	proc far		; CODE XREF: LoadGTA+2DP

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
		assume es:nothing
		mov	ax, [bp+arg_4]
		add	ax, 0Fh
		shr	ax, 4
		add	ax, [bp+arg_6]
		mov	ds, ax
		assume ds:nothing
		mov	si, [bp+arg_8]
		mov	ax, [bp+arg_4]
		and	ax, 0Fh
		sub	si, ax
		mov	bx, [bp+arg_A]
		mov	cx, [bp+arg_C]
		mov	di, [bp+arg_E]
		mov	ax, [bp+arg_10]
		call	loc_16DD9
		pop	ds
		pop	di
		pop	si
		pop	bp
		retf
sub_16DA2	endp

; ---------------------------------------------------------------------------

locret_16DD8:				; CODE XREF: seg000:6DFBj
		retn
; ---------------------------------------------------------------------------

loc_16DD9:				; CODE XREF: sub_16DA2+2Ep
		cld
		mov	cs:word_16D9E, sp
		mov	cs:word_16DA0, ds
		mov	ds:130h, bx
		mov	ds:132h, cx
		mov	ds:139h, ax
		mov	ax, di
		mov	ds:138h, al
		mov	ax, 0FFF8h
		cmp	si, 10A2h
		jb	short locret_16DD8
		mov	ax, si
		sub	ax, 1060h
		mov	ds:146h, ax
		add	ax, 1060h
		mov	word ptr cs:loc_170B0+2, ax
		mov	word ptr cs:loc_170C0+2, ax
		mov	word ptr cs:loc_170D0+2, ax
		mov	word ptr cs:loc_170E0+2, ax
		mov	word ptr cs:loc_170F0+2, ax
		mov	word ptr cs:loc_1715A+2, ax
		mov	word ptr cs:loc_16F4E+2, ax
		mov	word ptr cs:loc_16F5E+2, ax
		mov	word ptr cs:loc_16F8E+2, ax
		mov	word ptr cs:loc_16F9E+2, ax
		mov	word ptr cs:loc_16FAE+2, ax
		mov	word ptr cs:loc_16FBE+2, ax
		mov	word ptr cs:loc_17030+2, ax
		mov	word ptr cs:loc_17090+2, ax
		mov	word ptr cs:loc_170A0+2, ax
		mov	word ptr cs:loc_1722D+2, ax
		mov	word ptr cs:loc_1716A+2, ax
		mov	word ptr cs:loc_171DD+2, ax
		mov	word ptr cs:loc_171ED+2, ax
		mov	word ptr cs:loc_171FD+2, ax
		mov	word ptr cs:loc_1720D+2, ax
		mov	word ptr cs:loc_1721D+2, ax
		push	es
		pop	ds
		call	fopen2_r
		mov	bx, cs:word_16DA0
		mov	ds, bx
		mov	es, bx
		jb	short locret_16E7D
		mov	ds:140h, ax
		call	fread2
		mov	si, bx
		add	si, 0Ah
		jmp	short loc_16E7E
; ---------------------------------------------------------------------------

locret_16E7D:				; CODE XREF: seg000:6E6Ej
		retn
; ---------------------------------------------------------------------------

loc_16E7E:				; CODE XREF: seg000:6E7Bj
		mov	cx, 0
		mov	cx, ds:130h
		mov	ax, ds:132h
		shr	cx, 3
		shl	ax, 4
		add	cx, ax
		shl	ax, 2
		add	cx, ax
		mov	ds:13Eh, cx
		lodsw
		mov	ds:134h, ax
		mov	cx, ax
		neg	ax
		mov	word ptr cs:loc_16FE1+1, ax
		inc	ax
		mov	word ptr cs:loc_16F7D+1, ax
		dec	ax
		add	ax, ax
		mov	word ptr cs:loc_16F6F+1, ax
		add	cx, cx
		mov	ax, cx
		add	ax, 160h
		mov	ds:142h, ax
		add	cx, cx
		mov	ds:13Ch, cx
		add	ax, cx
		mov	ds:144h, ax
		mov	word ptr cs:loc_1701C+1, ax
		mov	word ptr cs:loc_1704F+2, ax
		mov	word ptr cs:loc_16FCA+2, ax
		mov	ax, ds:130h
		and	ax, 7
		add	ax, ds:134h
		mov	ds:14Ch, ax
		mov	cx, ax
		lodsw
		mov	ds:136h, ax
		mov	ds:14Ah, ax
		lodsw
		xchg	al, ah
		xor	ah, ah
		test	byte ptr ds:139h, 40h
		jz	short loc_16F09
		cmp	byte ptr ds:13Ah, 0FFh
		jnz	short loc_16F09
		cmp	al, 0FFh
		jz	short loc_16F04
		mov	ds:13Ah, al
		jmp	short loc_16F09
; ---------------------------------------------------------------------------

loc_16F04:				; CODE XREF: seg000:6EFDj
		and	byte ptr ds:139h, 0BFh

loc_16F09:				; CODE XREF: seg000:6EF2j seg000:6EF9j ...
		push	es
		mov	ax, seg	seg001
		mov	es, ax
		assume es:seg001
		mov	di, offset Palette1
		mov	cx, 18h

loc_16F15:				; CODE XREF: seg000:6F2Cj
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
		loop	loc_16F15
		pop	es
		assume es:nothing
		mov	bx, si
		call	sub_17238
		mov	dh, 1
		mov	di, 160h
		xor	al, al
		call	loc_17110
		mov	cx, ds:134h
		rep stosw
		xor	bp, bp
		jmp	loc_16FD3
; ---------------------------------------------------------------------------

loc_16F49:				; CODE XREF: seg000:6F6Bj
		mov	dl, [bx]
		inc	bx
		mov	dh, 8

loc_16F4E:				; DATA XREF: seg000:6E20w
		cmp	bx, 0
		jnz	short loc_16F6D
		call	fread2
		jmp	short loc_16F6D
; ---------------------------------------------------------------------------

loc_16F59:				; CODE XREF: seg000:6F79j
		mov	dl, [bx]
		inc	bx
		mov	dh, 8

loc_16F5E:				; DATA XREF: seg000:6E24w
		cmp	bx, 0
		jnz	short loc_16F7B
		call	fread2
		jmp	short loc_16F7B
; ---------------------------------------------------------------------------

loc_16F69:				; CODE XREF: seg000:6FD9j
		dec	dh
		jz	short loc_16F49

loc_16F6D:				; CODE XREF: seg000:6F52j seg000:6F57j
		add	dl, dl

loc_16F6F:				; DATA XREF: seg000:6EADw
		mov	si, 0
		jnb	short loc_16FF0
		nop
		nop
		nop
		dec	dh
		jz	short loc_16F59

loc_16F7B:				; CODE XREF: seg000:6F62j seg000:6F67j
		add	dl, dl

loc_16F7D:				; DATA XREF: seg000:6EA6w
		mov	si, 0
		jnb	short loc_16FF0
		nop
		nop
		nop
		dec	si
		dec	si
		jmp	short loc_16FF0
; ---------------------------------------------------------------------------

loc_16F89:				; CODE XREF: seg000:6FD5j
		mov	dl, [bx]
		inc	bx
		mov	dh, 8

loc_16F8E:				; DATA XREF: seg000:6E28w
		cmp	bx, 0
		jnz	short loc_16FD7
		call	fread2
		jmp	short loc_16FD7
; ---------------------------------------------------------------------------

loc_16F99:				; CODE XREF: seg000:6FDDj
		mov	dl, [bx]
		inc	bx
		mov	dh, 8

loc_16F9E:				; DATA XREF: seg000:6E2Cw
		cmp	bx, 0
		jnz	short loc_16FDF
		call	fread2
		jmp	short loc_16FDF
; ---------------------------------------------------------------------------

loc_16FA9:				; CODE XREF: seg000:6FFAj
		mov	dl, [bx]
		inc	bx
		mov	dh, 8

loc_16FAE:				; DATA XREF: seg000:6E30w
		cmp	bx, 0
		jnz	short loc_16FFC
		call	fread2
		jmp	short loc_16FFC
; ---------------------------------------------------------------------------

loc_16FB9:				; CODE XREF: seg000:7008j
		mov	dl, [bx]
		inc	bx
		mov	dh, 8

loc_16FBE:				; DATA XREF: seg000:6E34w
		cmp	bx, 0
		jnz	short loc_1700A
		call	fread2
		jmp	short loc_1700A
; ---------------------------------------------------------------------------

loc_16FC9:				; CODE XREF: seg000:6FFEj
		movsw

loc_16FCA:				; DATA XREF: seg000:6ECEw
		cmp	di, 0
		jnz	short loc_16FD3
		call	sub_1727E

loc_16FD3:				; CODE XREF: seg000:6F46j seg000:6FCEj ...
		dec	dh
		jz	short loc_16F89

loc_16FD7:				; CODE XREF: seg000:6F92j seg000:6F97j
		add	dl, dl
		jb	short loc_16F69
		dec	dh
		jz	short loc_16F99

loc_16FDF:				; CODE XREF: seg000:6FA2j seg000:6FA7j
		add	dl, dl

loc_16FE1:				; DATA XREF: seg000:6EA1w
		mov	si, 0
		jb	short loc_16FF0
		mov	si, 0FFFCh
		mov	ax, [di-2]
		cmp	ah, al
		jz	short loc_1703B

loc_16FF0:				; CODE XREF: seg000:6F72j seg000:6F80j ...
		cmp	si, bp
		mov	bp, si
		jz	short loc_17046
		add	si, di

loc_16FF8:				; CODE XREF: seg000:7044j
		dec	dh
		jz	short loc_16FA9

loc_16FFC:				; CODE XREF: seg000:6FB2j seg000:6FB7j
		add	dl, dl
		jnb	short loc_16FC9
		mov	ax, 1
		xor	cx, cx

loc_17005:				; CODE XREF: seg000:700Cj
		inc	cx
		dec	dh
		jz	short loc_16FB9

loc_1700A:				; CODE XREF: seg000:6FC2j seg000:6FC7j
		add	dl, dl
		jb	short loc_17005

loc_1700E:				; CODE XREF: seg000:7016j
		dec	dh
		jz	short loc_1702B

loc_17012:				; CODE XREF: seg000:7034j seg000:7039j
		add	dl, dl
		adc	ax, ax
		loop	loc_1700E
		jb	short loc_17075

loc_1701A:				; CODE XREF: seg000:7073j seg000:707Ej ...
		mov	cx, ax

loc_1701C:				; DATA XREF: seg000:6EC6w
		mov	ax, 0
		sub	ax, di
		shr	ax, 1
		cmp	cx, ax
		jnb	short loc_17067
		rep movsw
		jmp	short loc_16FD3
; ---------------------------------------------------------------------------

loc_1702B:				; CODE XREF: seg000:7010j
		mov	dl, [bx]
		inc	bx
		mov	dh, 8

loc_17030:				; DATA XREF: seg000:6E38w
		cmp	bx, 0
		jnz	short loc_17012
		call	fread2
		jmp	short loc_17012
; ---------------------------------------------------------------------------

loc_1703B:				; CODE XREF: seg000:6FEEj
		cmp	si, bp
		mov	bp, si
		jz	short loc_17046
		lea	si, [di-2]
		jmp	short loc_16FF8
; ---------------------------------------------------------------------------

loc_17046:				; CODE XREF: seg000:6FF4j seg000:703Fj
		mov	al, [di-1]

loc_17049:				; CODE XREF: seg000:705Bj
		call	loc_17110
		stosw
		mov	al, ah

loc_1704F:				; DATA XREF: seg000:6ECAw
		cmp	di, 0
		jz	short loc_17062

loc_17055:				; CODE XREF: seg000:7065j
		dec	dh
		jz	short loc_1708B

loc_17059:				; CODE XREF: seg000:7094j seg000:7099j
		add	dl, dl
		jb	short loc_17049
		xor	bp, bp
		jmp	loc_16FD3
; ---------------------------------------------------------------------------

loc_17062:				; CODE XREF: seg000:7053j
		call	sub_1727E
		jmp	short loc_17055
; ---------------------------------------------------------------------------

loc_17067:				; CODE XREF: seg000:7025j
		sub	cx, ax
		xchg	ax, cx
		rep movsw
		call	sub_1727E
		sub	si, ds:13Ch
		jmp	short loc_1701A
; ---------------------------------------------------------------------------

loc_17075:				; CODE XREF: seg000:7018j
		xor	cx, cx

loc_17077:				; CODE XREF: seg000:707Cj seg000:7089j
		movsw
		cmp	di, ds:144h
		loopne	loc_17077
		jnz	short loc_1701A
		call	sub_1727E
		sub	si, ds:13Ch
		jcxz	short loc_1701A
		jmp	short loc_17077
; ---------------------------------------------------------------------------

loc_1708B:				; CODE XREF: seg000:7057j
		mov	dl, [bx]
		inc	bx
		mov	dh, 8

loc_17090:				; DATA XREF: seg000:6E3Cw
		cmp	bx, 0
		jnz	short loc_17059
		call	fread2
		jmp	short loc_17059
; ---------------------------------------------------------------------------

loc_1709B:				; CODE XREF: seg000:70FDj
		mov	dl, [bx]
		inc	bx
		mov	dh, 8

loc_170A0:				; DATA XREF: seg000:6E40w
		cmp	bx, 0
		jnz	short loc_170FF
		call	fread2
		jmp	short loc_170FF
; ---------------------------------------------------------------------------

loc_170AB:				; CODE XREF: seg000:7118j
		mov	dl, [bx]
		inc	bx
		mov	dh, 8

loc_170B0:				; DATA XREF: seg000:6E08w
		cmp	bx, 0
		jnz	short loc_1711A
		call	fread2
		jmp	short loc_1711A
; ---------------------------------------------------------------------------

loc_170BB:				; CODE XREF: seg000:7120j
		mov	dl, [bx]
		inc	bx
		mov	dh, 8

loc_170C0:				; DATA XREF: seg000:6E0Cw
		cmp	bx, 0
		jnz	short loc_17122
		call	fread2
		jmp	short loc_17122
; ---------------------------------------------------------------------------

loc_170CB:				; CODE XREF: seg000:712Bj
		mov	dl, [bx]
		inc	bx
		mov	dh, 8

loc_170D0:				; DATA XREF: seg000:6E10w
		cmp	bx, 0
		jnz	short loc_1712D
		call	fread2
		jmp	short loc_1712D
; ---------------------------------------------------------------------------

loc_170DB:				; CODE XREF: seg000:7133j
		mov	dl, [bx]
		inc	bx
		mov	dh, 8

loc_170E0:				; DATA XREF: seg000:6E14w
		cmp	bx, 0
		jnz	short loc_17135
		call	fread2
		jmp	short loc_17135
; ---------------------------------------------------------------------------

loc_170EB:				; CODE XREF: seg000:713Bj
		mov	dl, [bx]
		inc	bx
		mov	dh, 8

loc_170F0:				; DATA XREF: seg000:6E18w
		cmp	bx, 0
		jnz	short loc_1713D
		call	fread2
		jmp	short loc_1713D
; ---------------------------------------------------------------------------

loc_170FB:				; CODE XREF: seg000:711Cj
		dec	dh
		jz	short loc_1709B

loc_170FF:				; CODE XREF: seg000:70A4j seg000:70A9j
		add	dl, dl
		jb	short loc_17106
		lodsb
		jmp	short loc_17175
; ---------------------------------------------------------------------------

loc_17106:				; CODE XREF: seg000:7101j
		mov	ax, [si]
		xchg	ah, al
		mov	[si], ax
		xor	ah, ah
		jmp	short loc_17175
; ---------------------------------------------------------------------------

loc_17110:				; CODE XREF: seg000:6F3Bp
					; seg000:loc_17049p
		mov	bp, di
		xor	ah, ah
		mov	si, ax
		dec	dh
		jz	short loc_170AB

loc_1711A:				; CODE XREF: seg000:70B4j seg000:70B9j
		add	dl, dl
		jb	short loc_170FB
		dec	dh
		jz	short loc_170BB

loc_17122:				; CODE XREF: seg000:70C4j seg000:70C9j
		add	dl, dl
		mov	cx, 1
		jnb	short loc_17141
		dec	dh
		jz	short loc_170CB

loc_1712D:				; CODE XREF: seg000:70D4j seg000:70D9j
		add	dl, dl
		jnb	short loc_17139
		dec	dh
		jz	short loc_170DB

loc_17135:				; CODE XREF: seg000:70E4j seg000:70E9j
		add	dl, dl
		adc	cx, cx

loc_17139:				; CODE XREF: seg000:712Fj
		dec	dh
		jz	short loc_170EB

loc_1713D:				; CODE XREF: seg000:70F4j seg000:70F9j
		add	dl, dl
		adc	cx, cx

loc_17141:				; CODE XREF: seg000:7127j
		dec	dh
		jz	short loc_17155

loc_17145:				; CODE XREF: seg000:715Ej seg000:7163j
		add	dl, dl
		adc	cx, cx
		add	si, cx
		std
		lodsb
		lea	di, [si+1]
		rep movsb
		stosb
		jmp	short loc_17175
; ---------------------------------------------------------------------------

loc_17155:				; CODE XREF: seg000:7143j
		mov	dl, [bx]
		inc	bx
		mov	dh, 8

loc_1715A:				; DATA XREF: seg000:6E1Cw
		cmp	bx, 0
		jnz	short loc_17145
		call	fread2
		jmp	short loc_17145
; ---------------------------------------------------------------------------

loc_17165:				; CODE XREF: seg000:717Bj
		mov	dl, [bx]
		inc	bx
		mov	dh, 8

loc_1716A:				; DATA XREF: seg000:6E48w
		cmp	bx, 0
		jnz	short loc_1717D
		call	fread2
		jmp	short loc_1717D
; ---------------------------------------------------------------------------

loc_17175:				; CODE XREF: seg000:7104j seg000:710Ej ...
		xor	ah, ah
		mov	si, ax
		dec	dh
		jz	short loc_17165

loc_1717D:				; CODE XREF: seg000:716Ej seg000:7173j
		add	dl, dl
		jb	short loc_171BE
		dec	dh
		jz	short loc_171D8

loc_17185:				; CODE XREF: seg000:71E1j seg000:71E6j
		add	dl, dl
		mov	cx, 1
		jnb	short loc_171A4
		dec	dh
		jz	short loc_171E8

loc_17190:				; CODE XREF: seg000:71F1j seg000:71F6j
		add	dl, dl
		jnb	short loc_1719C
		dec	dh
		jz	short loc_171F8

loc_17198:				; CODE XREF: seg000:7201j seg000:7206j
		add	dl, dl
		adc	cx, cx

loc_1719C:				; CODE XREF: seg000:7192j
		dec	dh
		jz	short loc_17208

loc_171A0:				; CODE XREF: seg000:7211j seg000:7216j
		add	dl, dl
		adc	cx, cx

loc_171A4:				; CODE XREF: seg000:718Aj
		dec	dh
		jz	short loc_17218

loc_171A8:				; CODE XREF: seg000:7221j seg000:7226j
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

loc_171BE:				; CODE XREF: seg000:717Fj
		dec	dh
		jz	short loc_17228

loc_171C2:				; CODE XREF: seg000:7231j seg000:7236j
		add	dl, dl
		jb	short loc_171CC
		mov	ah, [si]
		mov	di, bp
		cld
		retn
; ---------------------------------------------------------------------------

loc_171CC:				; CODE XREF: seg000:71C4j
		mov	cx, [si]
		xchg	ch, cl
		mov	[si], cx
		mov	ah, cl
		mov	di, bp
		cld
		retn
; ---------------------------------------------------------------------------

loc_171D8:				; CODE XREF: seg000:7183j
		mov	dl, [bx]
		inc	bx
		mov	dh, 8

loc_171DD:				; DATA XREF: seg000:6E4Cw
		cmp	bx, 0
		jnz	short loc_17185
		call	fread2
		jmp	short loc_17185
; ---------------------------------------------------------------------------

loc_171E8:				; CODE XREF: seg000:718Ej
		mov	dl, [bx]
		inc	bx
		mov	dh, 8

loc_171ED:				; DATA XREF: seg000:6E50w
		cmp	bx, 0
		jnz	short loc_17190
		call	fread2
		jmp	short loc_17190
; ---------------------------------------------------------------------------

loc_171F8:				; CODE XREF: seg000:7196j
		mov	dl, [bx]
		inc	bx
		mov	dh, 8

loc_171FD:				; DATA XREF: seg000:6E54w
		cmp	bx, 0
		jnz	short loc_17198
		call	fread2
		jmp	short loc_17198
; ---------------------------------------------------------------------------

loc_17208:				; CODE XREF: seg000:719Ej
		mov	dl, [bx]
		inc	bx
		mov	dh, 8

loc_1720D:				; DATA XREF: seg000:6E58w
		cmp	bx, 0
		jnz	short loc_171A0
		call	fread2
		jmp	short loc_171A0
; ---------------------------------------------------------------------------

loc_17218:				; CODE XREF: seg000:71A6j
		mov	dl, [bx]
		inc	bx
		mov	dh, 8

loc_1721D:				; DATA XREF: seg000:6E5Cw
		cmp	bx, 0
		jnz	short loc_171A8
		call	fread2
		jmp	short loc_171A8
; ---------------------------------------------------------------------------

loc_17228:				; CODE XREF: seg000:71C0j
		mov	dl, [bx]
		inc	bx
		mov	dh, 8

loc_1722D:				; DATA XREF: seg000:6E44w
		cmp	bx, 0
		jnz	short loc_171C2
		call	fread2
		jmp	short loc_171C2

; =============== S U B	R O U T	I N E =======================================


sub_17238	proc near		; CODE XREF: seg000:6F31p
		xor	di, di
		mov	ax, 1000h

loc_1723D:				; CODE XREF: sub_17238+11j
		mov	cx, 10h

loc_17240:				; CODE XREF: sub_17238+Bj
		stosb
		sub	al, 10h
		loop	loc_17240
		add	al, 10h
		dec	ah
		jnz	short loc_1723D
		retn
sub_17238	endp


; =============== S U B	R O U T	I N E =======================================


fopen2_r	proc near		; CODE XREF: seg000:6E62p
		mov	ax, 3D00h
		int	21h		; DOS -	2+ - OPEN DISK FILE WITH HANDLE
					; DS:DX	-> ASCIZ filename
					; AL = access mode
					; 0 - read
		retn
fopen2_r	endp


; =============== S U B	R O U T	I N E =======================================


fread2		proc near		; CODE XREF: seg000:6E73p seg000:6F54p ...
		push	ax
		push	cx
		push	dx
		mov	bx, ds:140h
		mov	dx, 1060h
		push	dx
		mov	cx, ds:146h
		mov	ah, 3Fh
		int	21h		; DOS -	2+ - READ FROM FILE WITH HANDLE
					; BX = file handle, CX = number	of bytes to read
					; DS:DX	-> buffer
		jb	short loc_1726C
		pop	bx
		pop	dx
		pop	cx
		pop	ax
		retn
; ---------------------------------------------------------------------------

loc_1726C:				; CODE XREF: fread2+13j
		call	fclose2
		mov	sp, cs:word_16D9E
		retn
fread2		endp


; =============== S U B	R O U T	I N E =======================================


fclose2		proc near		; CODE XREF: fread2:loc_1726Cp
					; sub_1727E:loc_173DBp
		mov	bx, ds:140h
		mov	ah, 3Eh
		int	21h		; DOS -	2+ - CLOSE A FILE WITH HANDLE
					; BX = file handle
		retn
fclose2		endp


; =============== S U B	R O U T	I N E =======================================


sub_1727E	proc near		; CODE XREF: seg000:6FD0p
					; seg000:loc_17062p ...
		pusha
		push	es
		mov	si, ds:144h
		mov	di, 160h
		mov	cx, ds:134h
		sub	si, cx
		sub	si, cx
		rep movsw
		mov	si, di
		mov	cx, 4

loc_17296:				; CODE XREF: sub_1727E+153j
		push	cx
		mov	di, ds:13Eh
		mov	ax, ds:130h
		and	ax, 7
		jz	short loc_172E1
		mov	cx, 8
		sub	cx, ax
		push	cx
		mov	ah, 0FFh
		shl	ah, cl
		not	al
		xor	bx, bx
		mov	dx, bx

loc_172B3:				; CODE XREF: sub_1727E+46j
		lodsb
		add	al, al
		adc	bl, bl
		add	al, al
		adc	bh, bh
		add	al, al
		adc	dl, dl
		add	al, al
		adc	dh, dh
		loop	loc_172B3
		test	byte ptr ds:139h, 40h
		jz	short loc_172D2
		call	sub_17428
		jmp	short loc_172D5
; ---------------------------------------------------------------------------

loc_172D2:				; CODE XREF: sub_1727E+4Dj
		call	sub_173E6

loc_172D5:				; CODE XREF: sub_1727E+52j
		pop	ax
		mov	cx, ds:134h
		sub	cx, ax
		shr	cx, 3
		jmp	short loc_172E8
; ---------------------------------------------------------------------------

loc_172E1:				; CODE XREF: sub_1727E+23j
		mov	cx, ds:134h
		shr	cx, 3

loc_172E8:				; CODE XREF: sub_1727E+61j
					; sub_1727E+FBj ...
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
		test	byte ptr ds:139h, 40h
		jnz	short loc_1737C
		call	sub_173E6
		dec	cx
		jz	short loc_17385
		jmp	loc_172E8
; ---------------------------------------------------------------------------

loc_1737C:				; CODE XREF: sub_1727E+F3j
		call	sub_17428
		dec	cx
		jz	short loc_17385
		jmp	loc_172E8
; ---------------------------------------------------------------------------

loc_17385:				; CODE XREF: sub_1727E+F9j
					; sub_1727E+102j
		mov	cx, ds:14Ch
		and	cx, 7
		jz	short loc_173C2
		mov	ah, 8
		sub	ah, cl
		xor	bx, bx
		mov	dx, bx

loc_17396:				; CODE XREF: sub_1727E+129j
		lodsb
		add	al, al
		adc	bl, bl
		add	al, al
		adc	bh, bh
		add	al, al
		adc	dl, dl
		add	al, al
		adc	dh, dh
		loop	loc_17396
		mov	cl, ah
		mov	ch, 0FFh
		shl	ch, cl
		shl	bx, cl
		shl	dx, cl
		test	byte ptr ds:139h, 40h
		jz	short loc_173BF
		call	sub_17428
		jmp	short loc_173C2
; ---------------------------------------------------------------------------

loc_173BF:				; CODE XREF: sub_1727E+13Aj
		call	sub_173E6

loc_173C2:				; CODE XREF: sub_1727E+10Ej
					; sub_1727E+13Fj
		pop	cx
		add	word ptr ds:13Eh, 50h ;	'P'
		dec	word ptr ds:14Ah
		jz	short loc_173DB
		dec	cx
		jz	short loc_173D4
		jmp	loc_17296
; ---------------------------------------------------------------------------

loc_173D4:				; CODE XREF: sub_1727E+151j
		pop	es
		popa
		mov	di, ds:142h
		retn
; ---------------------------------------------------------------------------

loc_173DB:				; CODE XREF: sub_1727E+14Ej
		call	fclose2
		mov	sp, cs:word_16D9E
		xor	ax, ax
		retn
sub_1727E	endp


; =============== S U B	R O U T	I N E =======================================


sub_173E6	proc near		; CODE XREF: sub_1727E:loc_172D2p
					; sub_1727E+F5p ...
		mov	ax, seg	seg001
		mov	es, ax
		assume es:seg001
		mov	ax, es:word_17580
		mov	es, ax
		assume es:nothing
		mov	al, dh
		mov	es:[di], al
		mov	ax, seg	seg001
		mov	es, ax
		assume es:seg001
		mov	ax, es:word_17582
		mov	es, ax
		assume es:nothing
		mov	al, dl
		mov	es:[di], al
		mov	ax, seg	seg001
		mov	es, ax
		assume es:seg001
		mov	ax, es:word_17584
		mov	es, ax
		assume es:nothing
		mov	al, bh
		mov	es:[di], al
		mov	ax, seg	seg001
		mov	es, ax
		assume es:seg001
		mov	ax, es:word_17586
		mov	es, ax
		assume es:nothing
		mov	al, bl
		mov	es:[di], al
		inc	di
		retn
sub_173E6	endp


; =============== S U B	R O U T	I N E =======================================


sub_17428	proc near		; CODE XREF: sub_1727E+4Fp
					; sub_1727E:loc_1737Cp	...
		pusha
		mov	cl, ds:13Ah
		mov	ch, 0FFh
		test	cl, 1
		jz	short loc_17436
		and	ch, dh

loc_17436:				; CODE XREF: sub_17428+Aj
		test	cl, 2
		jz	short loc_1743D
		and	ch, dl

loc_1743D:				; CODE XREF: sub_17428+11j
		test	cl, 4
		jz	short loc_17444
		and	ch, bh

loc_17444:				; CODE XREF: sub_17428+18j
		test	cl, 8
		jz	short loc_1744B
		and	ch, bl

loc_1744B:				; CODE XREF: sub_17428+1Fj
		test	cl, 1
		jnz	short loc_17456
		mov	al, dh
		not	al
		and	ch, al

loc_17456:				; CODE XREF: sub_17428+26j
		test	cl, 2
		jnz	short loc_17461
		mov	al, dl
		not	al
		and	ch, al

loc_17461:				; CODE XREF: sub_17428+31j
		test	cl, 4
		jnz	short loc_1746C
		mov	al, bh
		not	al
		and	ch, al

loc_1746C:				; CODE XREF: sub_17428+3Cj
		test	cl, 8
		jnz	short loc_17477
		mov	al, bl
		not	al
		and	ch, al

loc_17477:				; CODE XREF: sub_17428+47j
		not	ch
		and	dh, ch
		and	dl, ch
		and	bh, ch
		and	bl, ch
		not	ch
		mov	ax, seg	seg001
		mov	es, ax
		assume es:seg001
		mov	ax, es:word_17580
		mov	es, ax
		assume es:nothing
		mov	al, es:[di]
		and	al, ch
		or	al, dh
		mov	es:[di], al
		mov	ax, seg	seg001
		mov	es, ax
		assume es:seg001
		mov	ax, es:word_17582
		mov	es, ax
		assume es:nothing
		mov	al, es:[di]
		and	al, ch
		or	al, dl
		mov	es:[di], al
		mov	ax, seg	seg001
		mov	es, ax
		assume es:seg001
		mov	ax, es:word_17584
		mov	es, ax
		assume es:nothing
		mov	al, es:[di]
		and	al, ch
		or	al, bh
		mov	es:[di], al
		mov	ax, seg	seg001
		mov	es, ax
		assume es:seg001
		mov	ax, es:word_17586
		mov	es, ax
		assume es:nothing
		mov	al, es:[di]
		and	al, ch
		or	al, bl
		mov	es:[di], al
		popa
		inc	di
		retn
sub_17428	endp

seg000		ends

; ===========================================================================

; Segment type:	Regular
seg001		segment	byte public 'UNK' use16
		assume cs:seg001
		;org 0Ah
		assume es:nothing, ss:nothing, ds:nothing, fs:nothing, gs:nothing
aStudioTwinKleB	db 'Studio Twin',27h,'kle u•‘–²v Opening Program  ver.0.3',0Dh,0Ah
					; DATA XREF: seg000:6C92o seg000:6CD1o
		db 'Programmed by TAKAHIRO NOGI.(NOGICHAN) 1995/07/24',0Dh,0Ah
		db 0Dh,0Ah,'$'
aFileNotFound	db 'ƒtƒ@ƒCƒ‹‚ªŒ©‚Â‚©‚è‚Ü‚¹‚ñ.',0Dh,0Ah,'$' ; DATA XREF: seg000:6C99o
					; File not found.
aMallocError	db 'ƒƒ‚ƒŠ‚ªŠm•Ûo—ˆ‚Ü‚¹‚ñ.',0Dh,0Ah,'$' ; DATA XREF: seg000:6CD8o
					; Unable to allocate memory.
		db  90h	; 
word_1757A	dw 0			; DATA XREF: start+99w	start+9Dr
word_1757C	dw 0			; DATA XREF: start:loc_100F3w
byte_1757E	db 0			; DATA XREF: start+6Dw
					; start:loc_10074w ...
byte_1757F	db 0			; DATA XREF: SetupInts+2Ew
					; RestoreInts+4r
word_17580	dw 0			; DATA XREF: sub_173E6+5r
					; sub_17428+60r
word_17582	dw 0			; DATA XREF: sub_173E6+15r
					; sub_17428+75r
word_17584	dw 0			; DATA XREF: sub_173E6+25r
					; sub_17428+8Ar
word_17586	dw 0			; DATA XREF: sub_173E6+35r
					; sub_17428+9Fr
hFile		dw 0			; DATA XREF: fopen1_r+1Aw fread1+8r ...
byte_1758A	db 0			; DATA XREF: start+13Ew start+23Aw ...
byte_1758B	db 0			; DATA XREF: start+143w start+23Fw ...
aAStssp_env	db 'A:STSSP.ENV',0      ; DATA XREF: start+3Eo
aBOp_01a_gta	db 'B:OP_01A.GTA',0     ; DATA XREF: start+17Co
aBOp_01b_gta	db 'B:OP_01B.GTA',0     ; DATA XREF: start+388o
aBOp_01c_gta	db 'B:OP_01C.GTA',0     ; DATA XREF: start+3B4o
aBOp_01d_gta	db 'B:OP_01D.GTA',0     ; DATA XREF: start+294o
aBOp_01e_gta	db 'B:OP_01E.GTA',0     ; DATA XREF: start+2BCo
aBOp_01f_gta	db 'B:OP_01F.GTA',0     ; DATA XREF: start+2E4o
aBOp_01g_gta	db 'B:OP_01G.GTA',0     ; DATA XREF: start+30Co
aBOp_01h_gta	db 'B:OP_01H.GTA',0     ; DATA XREF: start+334o
aBOp_01i_gta	db 'B:OP_01I.GTA',0     ; DATA XREF: start+35Co
aBOp_h00_gta	db 'B:OP_H00.GTA',0     ; DATA XREF: start+1009o
aBOp_h01_gta	db 'B:OP_H01.GTA',0     ; DATA XREF: start+BDAo
aBOp_h02_gta	db 'B:OP_H02.GTA',0     ; DATA XREF: start+C02o
aBOp_h03_gta	db 'B:OP_H03.GTA',0     ; DATA XREF: start+C2Ao
aBOp_h04_gta	db 'B:OP_H04.GTA',0     ; DATA XREF: start+130Bo
aBOp_h05_gta	db 'B:OP_H05.GTA',0     ; DATA XREF: start+11D8o
aBOp_h06_gta	db 'B:OP_H06.GTA',0     ; DATA XREF: start+1430o
aBOp_h07_gta	db 'B:OP_H07.GTA',0     ; DATA XREF: start+1618o
aBOp_h08_gta	db 'B:OP_H08.GTA',0     ; DATA XREF: start+1640o
aBOp_h09_gta	db 'B:OP_H09.GTA',0     ; DATA XREF: start+1668o
aBOp_h10_gta	db 'B:OP_H10.GTA',0
aBOp_h11_gta	db 'B:OP_H11.GTA',0     ; DATA XREF: start+10E7o start+1927o
aBOp_h12_gta	db 'B:OP_H12.GTA',0     ; DATA XREF: start+110Fo start+194Fo
aBOp_h13_gta	db 'B:OP_H13.GTA',0     ; DATA XREF: start+1137o start+1977o
aBOp_e00_gta	db 'B:OP_E00.GTA',0     ; DATA XREF: start+2280o
aBOp_e01_gta	db 'B:OP_E01.GTA',0     ; DATA XREF: start+1CC7o
aBOp_e02_gta	db 'B:OP_E02.GTA',0     ; DATA XREF: start+1CEFo
aBOp_e03_gta	db 'B:OP_E03.GTA',0     ; DATA XREF: start+1D17o
aBOp_e04_gta	db 'B:OP_E04.GTA',0     ; DATA XREF: start+2427o
aBOp_e05_gta	db 'B:OP_E05.GTA',0     ; DATA XREF: start+281Bo
aBOp_e06_gta	db 'B:OP_E06.GTA',0     ; DATA XREF: start+2670o
aBOp_e07_gta	db 'B:OP_E07.GTA',0     ; DATA XREF: start+2A95o
aBOp_e08_gta	db 'B:OP_E08.GTA',0     ; DATA XREF: start+2ABDo
aBOp_e09_gta	db 'B:OP_E09.GTA',0     ; DATA XREF: start+2AE5o
aBOp_e10_gta	db 'B:OP_E10.GTA',0     ; DATA XREF: start+235Eo start+2DCCo
aBOp_e11_gta	db 'B:OP_E11.GTA',0     ; DATA XREF: start+2386o start+2DF4o
aBOp_t00_gta	db 'B:OP_T00.GTA',0     ; DATA XREF: start+3407o
aBOp_t01_gta	db 'B:OP_T01.GTA',0     ; DATA XREF: start+302Co
aBOp_t02_gta	db 'B:OP_T02.GTA',0     ; DATA XREF: start+3054o
aBOp_t03_gta	db 'B:OP_T03.GTA',0     ; DATA XREF: start+39AAo
aBOp_t04_gta	db 'B:OP_T04.GTA',0
aBOp_t05_gta	db 'B:OP_T05.GTA',0     ; DATA XREF: start+35D6o
aBOp_t06_gta	db 'B:OP_T06.GTA',0     ; DATA XREF: start+35FEo
aBOp_t07_gta	db 'B:OP_T07.GTA',0     ; DATA XREF: start+3B92o
aBOp_t08_gta	db 'B:OP_T08.GTA',0     ; DATA XREF: start+3BBAo
aBOp_t09_gta	db 'B:OP_T09.GTA',0     ; DATA XREF: start+4062o
aBOp_t10_gta	db 'B:OP_T10.GTA',0     ; DATA XREF: start+408Ao
aBOp_t11_gta	db 'B:OP_T11.GTA',0     ; DATA XREF: start+40B2o
aBOp_t12_gta	db 'B:OP_T12.GTA',0     ; DATA XREF: start+34E5o start+43BAo
aBOp_t13_gta	db 'B:OP_T13.GTA',0     ; DATA XREF: start+350Do start+43E2o
aBOp_t14_gta	db 'B:OP_T14.GTA',0     ; DATA XREF: start+3535o start+440Ao
aBOp_t15_gta	db 'B:OP_T15.GTA',0     ; DATA XREF: start+47F2o
aBOp_i00_gta	db 'B:OP_I00.GTA',0     ; DATA XREF: start+4BD3o
aBOp_i01_gta	db 'B:OP_I01.GTA',0     ; DATA XREF: start+4869o
aBOp_i02_gta	db 'B:OP_I02.GTA',0     ; DATA XREF: start+4FC3o
aBOp_i03_gta	db 'B:OP_I03.GTA',0     ; DATA XREF: start+4D7Ao
aBOp_i04_gta	db 'B:OP_I04.GTA',0     ; DATA XREF: start+5598o
aBOp_i05_gta	db 'B:OP_I05.GTA',0     ; DATA XREF: start+55C0o
aBOp_i06_gta	db 'B:OP_I06.GTA',0     ; DATA XREF: start+55E8o
aBOp_i07_gta	db 'B:OP_I07.GTA',0     ; DATA XREF: start+4CB1o start+58CFo
aBOp_i08_gta	db 'B:OP_I08.GTA',0     ; DATA XREF: start+4CD9o start+58F7o
aBOp_02a_gta	db 'B:OP_02A.GTA',0     ; DATA XREF: start+5C0Eo
aBOp_02b_gta	db 'B:OP_02B.GTA',0     ; DATA XREF: start+5C66o
aBMusOp_1_m	db 'B:MUS\OP_1.M',0     ; DATA XREF: PlayBGM+22o
aBMusOp_2_m	db 'B:MUS\OP_2.M',0     ; DATA XREF: PlayBGM:loc_1675Bo
aBMusOp_1_n	db 'B:MUS\OP_1.N',0     ; DATA XREF: PlayBGM+4Co
aBMusOp_2_n	db 'B:MUS\OP_2.N',0     ; DATA XREF: PlayBGM:loc_16785o
byte_178F2	db 89h,	8Bh, 8Dh, 87h	; DATA XREF: seg000:623Ao
byte_178F6	db 88h,	89h, 8Ah, 8Bh	; DATA XREF: seg000:loc_16249o
		db 8Ch,	8Dh, 8Eh, 87h
unk_178FE	db    0			; DATA XREF: start:loc_10049o
		db    0
MusicMode	db 0			; DATA XREF: WaitForMusic1+6r
					; WaitForMusic1+Dr ...
byte_17901	db 0			; DATA XREF: start+261r start+591r ...
byte_17902	db 0			; DATA XREF: start+FE4r start+225Br ...
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
word_17909	dw 0			; DATA XREF: SetupInts+12w
					; RestoreInts+11r
word_1790B	dw 0			; DATA XREF: SetupInts+16w
					; RestoreInts+15r
byte_1790D	db 0			; DATA XREF: start+106w seg000:613Er ...
CurFrameID	dw 0			; DATA XREF: start+12Cw start+3F1w ...
FrameCounter	dw 0			; DATA XREF: start+132w start+1BFw ...
word_17912	dw 0			; DATA XREF: start+138w start+B74w ...
CurFMTick	dw 0			; DATA XREF: WaitForMusic1+3Er
					; WaitForMusic2+3Er
CurMIDITick	dw 0			; DATA XREF: WaitForMusic1+57r
					; WaitForMusic2+57r
DestFrmWaitTick	dw 0			; DATA XREF: start+41Fw start+468w ...
FramesToWait	dw 0			; DATA XREF: start+1C5w start+1FBw ...
DestFMWaitTick	dw 0			; DATA XREF: start+425w start+46Ew ...
DestMIDWaitTick	dw 0			; DATA XREF: start+42Bw start+474w ...
byte_17920	db 0			; DATA XREF: start+87w	seg000:614Dr
byte_17921	db 0			; DATA XREF: sub_16B10+Cw sub_16B58+1r
byte_17922	db 0			; DATA XREF: start+163w
					; start:loc_10168r ...
		db  90h	; 
byte_17924	db 0			; DATA XREF: start+FCw	start+148w ...
byte_17925	db 0			; DATA XREF: start:loc_10446w
					; start:loc_1048Fw ...
		align 4
word_17928	dw 0			; DATA XREF: start+45Dw start+4A6w ...
		align 4
word_1792C	dw 0			; DATA XREF: seg000:623Dw seg000:624Cw ...
word_1792E	dw 0			; DATA XREF: seg000:622Cr seg000:6241w ...
DispTextPtr	dw 0			; DATA XREF: start+5BBw seg000:61A1r ...
byte_17932	db 0			; DATA XREF: start+F7w	start+14Dw ...
byte_17933	db 0			; DATA XREF: seg000:loc_16187w
					; seg000:618Br	...
byte_17934	db 0			; DATA XREF: seg000:619Ar seg000:61E1w ...
byte_17935	db 0			; DATA XREF: seg000:61DCw
					; seg000:loc_161E6r ...
word_17936	dw 0			; DATA XREF: start+459w start+4A2w ...
word_17938	dw 0			; DATA XREF: start:loc_100BAw
					; LoadGTA+25r
word_1793A	dw 0			; DATA XREF: start+17Fw start+297w ...
word_1793C	dw 0			; DATA XREF: start+185w start+29Dw ...
byte_1793E	db 0			; DATA XREF: start+101w start+1ABw ...
byte_1793F	db 0			; DATA XREF: start+1A6w start+1EBw ...
PaletteID	db 0			; DATA XREF: start:loc_10193w
					; start+19Bw ...
		db  90h	; 
PalFadeStart	dw 0			; DATA XREF: start+1A0w start+1D3w ...
PalFadeEnd	dw 0			; DATA XREF: start+1D9w start+20Fw ...
PalFadeInc	dw 0			; DATA XREF: start+1DFw start+215w ...
PalFade_StepDelay dw 0			; DATA XREF: start+1E5w start+21Bw ...
PalFade_StepCntr dw 0			; DATA XREF: DoBlackPalette+2Dw
					; seg000:loc_1629Ew ...
word_1794C	dw 0			; DATA XREF: DoBlackPalette+33w
					; seg000:6494w	...
Palette1	db 30h dup(0)		; DATA XREF: DoPalFade:loc_162CBo
					; seg000:loc_16467o ...
Palette2	db 30h dup(0)		; DATA XREF: DoPalFade+Co seg000:6461o ...
		db 1B0h	dup(0)
word_17B5E	dw 0			; DATA XREF: sub_16308+Cw
					; sub_16308+25r
word_17B60	dw 0			; DATA XREF: sub_16308+17w
					; sub_16308+35r ...
word_17B62	dw 0			; DATA XREF: sub_16308+22w
OpeningText	db '//'                 ; DATA XREF: start+5B8o
		db '@@@@@@@@@@@@@@•—‚Æ‰_‚ª‘å’n‚ÉŠñ‚è“Y‚¢//'
		db '//'
		db '@@@@@@@@@@@…–Ê‚Æ—z‚ÌŒõ‚ª‚»‚ÌŽp‚ðŽÊ‚µo‚·dd//'
		db '//'
		db 81h,	40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h,	40h, 81h
		db 40h,	81h, 40h, 82h, 0BBh, 82h, 0EAh,	82h, 0E7h, 91h
		db 53h,	82h, 0C4h, 82h,	0F0h, 8Eh, 69h,	82h, 0E9h, 95h
		db 97h,	93h, 56h, 81h, 41h, 92h, 6Eh, 93h, 56h,	81h, 41h
		db 89h,	0CEh, 93h, 56h,	81h, 41h, 90h, 85h, 93h, 56h, 82h
		db 0CCh, 82h, 53h, 90h,	6Ch, 82h, 0CCh,	89h, 0A4h, 82h
		db 0CDh, 2Fh, 2Fh, 2Fh,	2Fh, 81h, 40h, 81h, 40h, 81h, 40h
		db 81h,	40h, 90h, 5Fh, 82h, 0A9h, 82h, 0E7h, 8Eh, 0F6h
		db 82h,	0AFh, 82h, 0E7h, 82h, 0EAh, 82h, 0BDh, 82h, 0BBh
		db 82h,	0CCh, 97h, 0CDh, 82h, 0F0h, 81h, 41h, 8Eh, 0A9h
		db 82h,	0E7h, 82h, 0CCh, 93h, 9Dh, 82h,	0D7h, 82h, 0E9h
		db 8Dh,	91h, 82h, 0D6h,	90h, 0C9h, 82h,	0B5h, 82h, 0DDh
		db 82h,	0C8h, 82h, 0ADh, 82h, 0BBh, 82h, 0BBh, 82h, 0ACh
		db 8Dh,	9Eh, 82h, 0DDh,	2Fh, 2Fh, 2Fh, 2Fh, 81h, 40h, 81h
		db 40h,	81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h,	81h, 40h
		db 89h,	0A4h, 8Dh, 91h,	82h, 0CDh, 94h,	0C9h, 89h, 68h
		db 82h,	0F0h, 8Bh, 0C9h, 82h, 0DFh, 81h, 41h, 90h, 6Ch
		db 81h,	58h, 82h, 0CDh,	94h, 92h, 8Bh, 0CAh, 98h, 4Fh
		db 82h,	0C6h, 82h, 0B3h, 82h, 0A6h, 82h, 0E0h, 8Ch, 0BEh
		db 82h,	0A6h, 82h, 0E9h, 95h, 0E9h, 82h, 0E7h, 82h, 0B5h
		db 82h,	0F0h, 2Fh, 2Fh,	2Fh, 2Fh, 81h, 40h, 81h, 40h, 81h
		db 40h,	81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h,	81h, 40h
		db 81h,	40h, 81h, 40h, 81h, 40h, 81h, 40h, 8Eh,	0E8h, 82h
		db 0C9h, 93h, 0FCh, 82h, 0EAh, 82h, 0BDh, 82h, 0A9h, 82h
		db 0CCh, 82h, 0E6h, 82h, 0A4h, 82h, 0C9h, 8Eh, 76h, 82h
		db 0A6h, 82h, 0BDh, 81h, 64h, 81h, 64h,	2Fh, 2Fh, 2Fh
		db 2Fh,	81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h,	81h, 40h
		db 81h,	40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h,	40h, 82h
		db 0B5h, 82h, 0A9h, 82h, 0B5h, 97h, 0F0h, 8Eh, 6Ah, 82h
		db 0C6h, 82h, 0A2h, 82h, 0A4h, 82h, 0E0h, 82h, 0CCh, 82h
		db 0CDh, 95h, 4Bh, 82h,	0B8h, 8Eh, 6Eh,	82h, 0DCh, 82h
		db 0E8h, 82h, 0AAh, 82h, 0A0h, 82h, 0E8h, 2Fh, 2Fh, 2Fh
		db 2Fh,	81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h,	81h, 40h
		db 81h,	40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h,	40h, 82h
		db 0BBh, 82h, 0B5h, 82h, 0C4h, 8Fh, 49h, 0E0h, 81h, 82h
		db 0D6h, 82h, 0C6h, 88h, 0DAh, 82h, 0E8h, 95h, 0CFh, 82h
		db 0EDh, 82h, 0EBh, 82h, 0A4h, 82h, 0C6h, 82h, 0B7h, 82h
		db 0E9h, 81h, 64h, 81h,	64h, 2Fh, 2Fh, 2Fh, 2Fh, 81h, 40h
		db 81h,	40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h,	40h, 81h
		db 40h,	81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h,	81h, 40h
		db 81h,	40h, 8Eh, 9Eh, 82h, 0CCh, 97h, 0ACh, 82h, 0EAh
		db 82h,	0CDh, 8Dh, 8Fh,	88h, 0EAh, 8Dh,	8Fh, 82h, 0C6h
		db 88h,	0DAh, 82h, 0E8h, 95h, 0CFh, 82h, 0EDh, 82h, 0E8h
		db 2Fh,	2Fh, 2Fh, 2Fh, 81h, 40h, 81h, 40h, 81h,	40h, 81h
		db 40h,	81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h,	81h, 40h
		db 81h,	40h, 93h, 0F1h,	93h, 78h, 82h, 0C6h, 93h, 0AFh
		db 82h,	0B6h, 8Fh, 75h,	8Ah, 0D4h, 82h,	0F0h, 8Eh, 77h
		db 82h,	0B5h, 8Eh, 0A6h, 82h, 0B7h, 82h, 0B1h, 82h, 0C6h
		db 82h,	0AAh, 82h, 0C8h, 82h, 0A2h, 82h, 0E6h, 82h, 0A4h
		db 82h,	0C9h, 2Fh, 2Fh,	2Fh, 2Fh, 81h, 40h, 81h, 40h, 81h
		db 40h,	81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h,	81h, 40h
		db 81h,	40h, 90h, 6Ch, 81h, 58h, 82h, 0CCh, 90h, 53h, 82h
		db 0E0h, 82h, 0DCh, 82h, 0BDh, 81h, 41h, 91h, 0BDh, 82h
		db 0ADh, 82h, 0CCh, 8Eh, 9Eh, 82h, 0F0h, 8Fh, 64h, 82h
		db 0CBh, 82h, 0C4h, 82h, 0E4h, 82h, 0ADh, 82h, 0A4h, 82h
		db 0BFh, 82h, 0C9h, 2Fh, 2Fh, 2Fh, 2Fh,	81h, 40h, 81h
		db 40h,	81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h,	81h, 40h
		db 82h,	53h, 90h, 6Ch, 82h, 0CCh, 89h, 0A4h, 82h, 0C6h
		db 81h,	41h, 82h, 0BBh,	82h, 0B5h, 82h,	0C4h, 96h, 4Ch
		db 8Fh,	0F5h, 82h, 0CCh, 8Fh, 97h, 90h,	5Fh, 82h, 0CCh
		db 8Fh,	6Ah, 95h, 9Fh, 82h, 0F0h, 8Eh, 0F3h, 82h, 0AFh
		db 82h,	0BDh, 91h, 0E5h, 92h, 6Eh, 82h,	0B3h, 82h, 0A6h
		db 82h,	0E0h, 2Fh, 2Fh,	2Fh, 2Fh, 81h, 40h, 81h, 40h, 81h
		db 40h,	81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h,	81h, 40h
		db 81h,	40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h,	40h, 81h
		db 40h,	97h, 0A0h, 90h,	0D8h, 82h, 0EBh, 82h, 0A4h, 82h
		db 0C6h, 82h, 0B5h, 82h, 0C4h, 82h, 0A2h, 82h, 0BDh, 81h
		db 64h,	81h, 64h, 2Fh, 2Fh, 2Fh, 2Fh, 2Fh, 2Fh,	2Fh, 2Fh
		db 2Fh,	2Fh, 2Fh, 2Fh, 2Fh, 2Fh, 2Fh, 2Fh, 2Fh,	2Fh, 2Fh
		db 2Fh,	2Fh, 2Fh, 2Fh, 2Fh, 2Fh, 2Fh, 2Fh, 2Fh,	2Fh, 2Fh
		db 2Fh,	2Fh, 2Fh, 2Fh, 2Fh, 2Fh, 2Fh, 2Fh, 2Fh,	2Fh, 2Fh
		db 2Fh,	2Fh, 2Fh, 2Fh, 2Fh, 2Fh, 2Fh, 2Fh, 2Fh,	2Fh, 2Fh
		db 81h,	40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h,	40h, 81h
		db 40h,	81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h,	81h, 40h
		db 81h,	40h, 81h, 40h, 81h, 40h, 82h, 0E2h, 82h, 0AAh
		db 82h,	0C4h, 96h, 4Bh,	82h, 0EAh, 82h,	0E9h, 8Fh, 49h
		db 0E0h, 81h, 82h, 0CCh, 8Eh, 9Eh, 81h,	64h, 81h, 64h
		db 2Fh,	2Fh, 2Fh, 2Fh, 81h, 40h, 81h, 40h, 81h,	40h, 81h
		db 40h,	81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h,	81h, 40h
		db 81h,	40h, 81h, 40h, 8Eh, 0A9h, 82h, 0E7h, 8Eh, 0A1h
		db 82h,	0DFh, 82h, 0E9h, 89h, 0A4h, 8Dh, 91h, 82h, 0CCh
		db 97h,	0A0h, 90h, 0D8h, 82h, 0E8h, 82h, 0CCh, 96h, 0AFh
		db 82h,	0CCh, 8Eh, 0E8h, 82h, 0C9h, 82h, 0E6h, 82h, 0E8h
		db 2Fh,	2Fh, 2Fh, 2Fh, 81h, 40h, 81h, 40h, 81h,	40h, 81h
		db 40h,	81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h,	81h, 40h
		db 81h,	40h, 81h, 40h, 82h, 53h, 90h, 6Ch, 82h,	0CCh, 89h
		db 0A4h, 82h, 0CDh, 8Eh, 9Fh, 81h, 58h,	82h, 0C6h, 8Eh
		db 63h,	8Bh, 73h, 82h, 0C8h, 8Eh, 80h, 82h, 0F0h, 90h
		db 8Bh,	82h, 0B0h, 82h,	0BDh, 81h, 64h,	81h, 64h, 2Fh
		db 2Fh,	2Fh, 2Fh, 81h, 40h, 81h, 40h, 81h, 40h,	81h, 40h
		db 81h,	40h, 81h, 40h, 81h, 40h, 81h, 40h, 8Eh,	0E5h, 82h
		db 0F0h, 96h, 53h, 82h,	0ADh, 82h, 0B5h, 82h, 0BDh, 94h
		db 0DFh, 82h, 0B5h, 82h, 0DDh, 82h, 0A9h, 81h, 64h, 81h
		db 64h,	97h, 0A0h, 90h,	0D8h, 82h, 0E8h, 82h, 0CCh, 96h
		db 0AFh, 82h, 0D6h, 82h, 0CCh, 95h, 0F1h, 95h, 9Ch, 82h
		db 0A9h, 81h, 64h, 81h,	64h, 2Fh, 2Fh, 2Fh, 2Fh, 81h, 40h
		db 81h,	40h, 81h, 40h, 81h, 40h, 91h, 0E5h, 92h, 6Eh, 82h
		db 0CDh, 97h, 0F4h, 82h, 0AFh, 81h, 41h, 89h, 8Ah, 82h
		db 0CDh, 93h, 56h, 82h,	0F0h, 8Fh, 0C5h, 82h, 0AAh, 82h
		db 0B5h, 95h, 97h, 82h,	0CDh, 82h, 0A4h, 82h, 0CBh, 82h
		db 0E8h, 81h, 41h, 8Ah,	43h, 82h, 0CDh,	91h, 53h, 82h
		db 0C4h, 82h, 0F0h, 93h, 0DBh, 82h, 0DDh, 8Dh, 9Eh, 82h
		db 0F1h, 82h, 0BEh, 81h, 64h, 81h, 64h,	2Fh, 2Fh, 2Fh
		db 2Fh,	2Fh, 2Fh, 2Fh, 2Fh, 2Fh, 2Fh, 2Fh, 2Fh,	2Fh, 2Fh
		db 2Fh,	2Fh, 2Fh, 2Fh, 2Fh, 2Fh, 2Fh, 2Fh, 2Fh,	2Fh, 2Fh
		db 2Fh,	2Fh, 2Fh, 2Fh, 2Fh, 2Fh, 2Fh, 2Fh, 2Fh,	2Fh, 2Fh
		db 81h,	40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h,	40h, 81h
		db 40h,	81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h,	81h, 40h
		db 81h,	40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h,	40h, 82h
		db 0BBh, 82h, 0B5h, 82h, 0C4h, 90h, 0C3h, 8Eh, 0E2h, 86h
		db 0A2h, 86h, 0A2h, 86h, 0A2h, 2Fh, 2Fh, 2Fh, 2Fh, 81h
		db 40h,	81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h,	81h, 40h
		db 81h,	40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h,	40h, 81h
		db 40h,	81h, 40h, 8Eh, 0E5h, 82h, 0F0h,	8Eh, 0B8h, 82h
		db 0C1h, 82h, 0BDh, 97h, 7Ah, 82h, 0CDh, 97h, 44h, 82h
		db 0B5h, 82h, 0B3h, 82h, 0F0h, 96h, 59h, 82h, 0EAh, 2Fh
		db 2Fh,	2Fh, 2Fh, 81h, 40h, 81h, 40h, 81h, 40h,	81h, 40h
		db 81h,	40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h,	40h, 81h
		db 40h,	81h, 40h, 90h, 85h, 82h, 0CDh, 93h, 62h, 82h, 0DDh
		db 81h,	41h, 8Ah, 89h, 82h, 0A2h, 82h, 0BDh, 8Dh, 0BBh
		db 82h,	0F0h, 95h, 91h,	82h, 0A2h, 8Fh,	0E3h, 82h, 0B0h
		db 82h,	0E9h, 81h, 64h,	81h, 64h, 2Fh, 2Fh, 2Fh, 2Fh, 81h
		db 40h,	81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h,	81h, 40h
		db 81h,	40h, 81h, 40h, 81h, 40h, 89h, 0D8h, 82h, 0E2h
		db 82h,	0A9h, 82h, 0E8h, 82h, 0B5h, 8Eh, 9Eh, 82h, 0C9h
		db 90h,	92h, 82h, 0DFh,	82h, 0E7h, 82h,	0EAh, 82h, 0C4h
		db 82h,	0A2h, 82h, 0BDh, 92h, 6Eh, 93h,	56h, 82h, 0CCh
		db 8Fh,	97h, 90h, 5Fh, 91h, 9Ch, 81h, 64h, 81h,	64h, 2Fh
		db 2Fh,	2Fh, 2Fh, 81h, 40h, 81h, 40h, 81h, 40h,	81h, 40h
		db 81h,	40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h,	40h, 82h
		db 0BBh, 82h, 0CCh, 93h, 0B5h, 82h, 0A9h, 82h, 0E7h, 82h
		db 0CDh, 81h, 41h, 8Ch,	8Ch, 82h, 0CCh,	97h, 0DCh, 82h
		db 0AAh, 8Ah, 89h, 82h,	0A2h, 82h, 0BDh, 91h, 0E5h, 92h
		db 6Eh,	82h, 0D6h, 82h,	0C6h, 97h, 0ACh, 82h, 0EAh, 81h
		db 64h,	81h, 64h, 2Fh, 2Fh, 2Fh, 2Fh, 81h, 40h,	81h, 40h
		db 81h,	40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h,	40h, 81h
		db 40h,	81h, 40h, 81h, 40h, 81h, 40h, 91h, 0E5h, 92h, 6Eh
		db 82h,	0CCh, 90h, 46h,	82h, 0CDh, 8Dh,	67h, 82h, 0ADh
		db 90h,	0F5h, 82h, 0DFh, 82h, 0E7h, 82h, 0EAh, 82h, 0BDh
		db 82h,	0C6h, 82h, 0A2h, 82h, 0A4h, 86h, 0A2h, 86h, 0A2h
		db 86h,	0A2h, 2Fh, 2Fh,	2Fh, 2Fh, 2Fh, 2Fh, 2Fh, 2Fh, 81h
		db 40h,	81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h,	81h, 40h
		db 81h,	40h, 81h, 40h, 81h, 40h, 82h, 0B1h, 82h, 0CCh
		db 95h,	0A8h, 8Ch, 0EAh, 82h, 0CDh, 81h, 41h, 82h, 0BBh
		db 82h,	0EAh, 82h, 0A9h, 82h, 0E7h, 88h, 0EAh, 96h, 9Ch
		db 93h,	0F1h, 90h, 0E7h, 94h, 4Eh, 82h,	0D9h, 82h, 0C7h
		db 8Ch,	0E3h, 82h, 0CCh, 81h, 64h, 81h,	64h, 2Fh, 2Fh
		db 2Fh,	2Fh, 81h, 40h, 81h, 40h, 81h, 40h, 81h,	40h, 81h
		db 40h,	81h, 40h, 81h, 40h, 96h, 0B2h, 82h, 0C6h, 8Ch
		db 0BBh, 82h, 0CCh, 8Bh, 0B7h, 8Ah, 0D4h, 82h, 0C9h, 90h
		db 0B6h, 82h, 0DCh, 82h, 0EAh, 95h, 0CFh, 82h, 0EDh, 82h
		db 0C1h, 82h, 0BDh, 82h, 53h, 90h, 6Ch,	82h, 0CCh, 89h
		db 0A4h, 82h, 0CCh, 95h, 0A8h, 8Ch, 0EAh, 82h, 0C5h, 82h
		db 0A0h, 82h, 0E9h, 81h, 64h, 81h, 64h,	2Fh, 2Fh, 2Fh
		db 2Fh,	2Fh, 2Fh, 2Fh, 2Fh, 2Fh, 2Fh, 2Fh, 2Fh,	2Fh, 2Fh
		db 2Fh,	2Fh, 2Fh, 2Fh, 2Fh, 2Fh, 2Fh, 2Fh, 2Fh,	2Fh, 2Fh
		db 2Fh,	2Fh, 2Fh, 2Fh, 2Fh, 2Fh, 2Fh, 2Fh, 2Fh,	2Fh, 2Fh
		db 2Fh,	2Fh, 2Fh, 2Fh, 2Fh, 2Fh, 2Fh, 2Fh, 2Fh,	2Fh, 2Fh
		db 2Fh,	2Fh, 2Fh, 2Fh, 2Fh, 2Fh, 2Fh, 0, 0
seg001		ends

; ===========================================================================

; Segment type:	Uninitialized
seg002		segment	byte stack 'STACK' use16
		assume cs:seg002
		assume es:nothing, ss:nothing, ds:nothing, fs:nothing, gs:nothing
byte_18250	db 1800h dup(?)
seg002		ends


		end start
