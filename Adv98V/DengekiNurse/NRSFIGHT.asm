; Input	MD5   :	DD295C7A3F02721536FDE276AC8FBD16
; Input	CRC32 :	1E0ECD83

; File Name   :	R:\NRSFIGHT.CMD
; Format      :	MS-DOS executable (EXE)
; Base Address:	1000h Range: 10000h-191F1h Loaded length: 8510h
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
start		proc near
		call	sub_1000D

loc_10003:
		call	sub_1001A

loc_10006:
		call	sub_1001E

loc_10009:
		mov	ah, 4Ch
		int	21h		; DOS -	2+ - QUIT WITH EXIT CODE (EXIT)
start		endp			; AL = exit code


; =============== S U B	R O U T	I N E =======================================


sub_1000D	proc near		; CODE XREF: startp
		call	SaveRegES

loc_10010:
		call	SetDataSegs
		call	SetupInts2
		call	DoSomeRealloc
		retn
sub_1000D	endp


; =============== S U B	R O U T	I N E =======================================


sub_1001A	proc near		; CODE XREF: start:loc_10003p
		call	sub_10071
		retn
sub_1001A	endp


; =============== S U B	R O U T	I N E =======================================


sub_1001E	proc near		; CODE XREF: start:loc_10006p
		call	RestoreInts
		retn
sub_1001E	endp


; =============== S U B	R O U T	I N E =======================================


SaveRegES	proc near		; CODE XREF: sub_1000Dp
		push	ax
		push	ds
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		mov	word_18510, es
		pop	ds
		assume ds:nothing
		pop	ax
		retn
SaveRegES	endp


; =============== S U B	R O U T	I N E =======================================


SetDataSegs	proc near		; CODE XREF: sub_1000D:loc_10010p
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		mov	es, ax
		assume es:seg001
		retn
SetDataSegs	endp


; =============== S U B	R O U T	I N E =======================================


DoSomeRealloc	proc near		; CODE XREF: sub_1000D+9p
		pusha
		push	ds
		push	es
		mov	ax, word_18510
		mov	es, ax
		assume es:nothing
		mov	bx, seg	seg003
		sub	bx, ax
		inc	bx
		mov	ah, 4Ah
		int	21h		; DOS -	2+ - ADJUST MEMORY BLOCK SIZE (SETBLOCK)
					; ES = segment address of block	to change
					; BX = new size	in paragraphs
		jnb	short loc_1004F
		call	sub_10053

loc_1004F:				; CODE XREF: DoSomeRealloc+12j
		pop	es
		pop	ds
		assume ds:nothing
		popa
		retn
DoSomeRealloc	endp


; =============== S U B	R O U T	I N E =======================================


sub_10053	proc near		; CODE XREF: DoSomeRealloc+14p
					; sub_100BA:loc_100F0p
		push	ax
		push	ds
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		mov	byte_14CD0, 1
		pop	ds
		assume ds:nothing
		pop	ax
		retn
sub_10053	endp


; =============== S U B	R O U T	I N E =======================================


sub_10062	proc near		; CODE XREF: sub_10071+Ep
		push	ax
		push	ds
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		cmp	byte_14CD0, 0
		pop	ds
		pop	ax
		retn
sub_10062	endp


; =============== S U B	R O U T	I N E =======================================


sub_10071	proc near		; CODE XREF: sub_1001Ap
		push	bx
		push	cx
		push	dx
		push	si
		push	di
		push	bp
		push	ds
		push	es
		call	sub_100A3
		call	sub_100BA
		call	sub_10062

loc_10082:
		jnz	short loc_1009A
		call	sub_100F7
		mov	bx, word_18558
		mov	bp, word_18556
		les	di, dword_18552

loc_10093:
		lds	si, dword_1854E
		assume ds:nothing
		call	sub_101A6

loc_1009A:				; CODE XREF: sub_10071:loc_10082j
		pop	es
		pop	ds
		pop	bp
		pop	di
		pop	si
		pop	dx
		pop	cx
		pop	bx
		retn
sub_10071	endp


; =============== S U B	R O U T	I N E =======================================


sub_100A3	proc near		; CODE XREF: sub_10071+8p
		push	ax
		push	cx
		push	di
		mov	di, seg	seg001
		mov	es, di
		assume es:seg001
		mov	di, offset unk_18512
		xor	ax, ax
		mov	cx, 1Eh
		cld
		rep stosw
		pop	di
		pop	cx
		pop	ax
		retn
sub_100A3	endp


; =============== S U B	R O U T	I N E =======================================


sub_100BA	proc near		; CODE XREF: sub_10071+Bp
		pusha
		push	ds
		push	es
		mov	ax, seg	seg001
		mov	es, ax
		mov	ax, es:word_18510
		mov	ds, ax
		mov	si, 80h	; 'Ä'
		xor	ax, ax
		mov	al, [si]
		or	al, al
		jz	short loc_100F0
		xor	cx, cx
		mov	cl, al

loc_100D7:
		mov	bp, 1
		inc	si

loc_100DB:				; CODE XREF: sub_100BA+34j
		mov	di, es:[bp+0]
		cmp	di, 0FFFFh
		jz	short loc_100F3
		cmp	ch, cl
		jnb	short loc_100F0
		call	ParseArgs1
		add	bp, 2
		jmp	short loc_100DB
; ---------------------------------------------------------------------------

loc_100F0:				; CODE XREF: sub_100BA+17j
					; sub_100BA+2Cj
		call	sub_10053

loc_100F3:				; CODE XREF: sub_100BA+28j
		pop	es
		assume es:nothing
		pop	ds
		popa
		retn
sub_100BA	endp


; =============== S U B	R O U T	I N E =======================================


sub_100F7	proc near		; CODE XREF: sub_10071+13p
		push	ax
		push	si
		mov	si, offset unk_1851B
		call	ParseArgs2

loc_100FF:
		mov	word ptr ds:dword_1854E+2, ax
		mov	si, offset unk_18525
		call	ParseArgs2
		mov	word ptr ds:dword_1854E, ax
		mov	si, offset unk_1852F
		call	ParseArgs2
		mov	word ptr ds:dword_18552+2, ax
		mov	si, offset unk_18539
		call	ParseArgs2
		mov	word ptr ds:dword_18552, ax
		mov	si, offset unk_18543
		call	ParseArgs2
		mov	ds:word_18558, ax
		mov	si, offset unk_1854D
		call	ParseArgs2
		mov	ds:word_18556, ax
		pop	si
		pop	ax
		retn
sub_100F7	endp


; =============== S U B	R O U T	I N E =======================================


ParseArgs1	proc near		; CODE XREF: sub_100BA+2Ep
		push	ax
		push	di
		push	es
		cld

loc_10136:				; CODE XREF: ParseArgs1+9j
					; ParseArgs1+Dj
		lodsb
		inc	ch
		cmp	al, ' '
		jz	short loc_10136
		cmp	al, 9
		jz	short loc_10136

loc_10141:				; CODE XREF: ParseArgs1+21j
		stosb
		cmp	ch, cl
		jnb	short loc_10155
		lodsb
		inc	ch
		cmp	al, ','
		jz	short loc_10155
		cmp	al, 9
		jz	short loc_10155
		cmp	al, ' '
		jnz	short loc_10141

loc_10155:				; CODE XREF: ParseArgs1+12j
					; ParseArgs1+19j ...
		mov	al, 0
		stosb
		pop	es
		pop	di
		pop	ax
		retn
ParseArgs1	endp


; =============== S U B	R O U T	I N E =======================================


ParseArgs2	proc near		; CODE XREF: sub_100F7+5p sub_100F7+Ep ...
		push	bx
		push	cx
		push	dx
		push	si
		push	bp
		xor	ax, ax
		xor	bx, bx
		mov	dx, 11
		std

loc_10169:				; CODE XREF: ParseArgs2+12j
		lodsb
		inc	dh
		or	al, al
		jz	short loc_10169
		mov	cx, 1

loc_10173:				; CODE XREF: ParseArgs2+3Bj
		cmp	al, '+'
		jz	short loc_1019D
		cmp	al, '-'
		jz	short loc_1019B
		cmp	al, '9'
		jbe	short loc_10183
		or	al, 20h
		sub	al, 27h

loc_10183:				; CODE XREF: ParseArgs2+21j
		sub	al, '0'
		xor	ah, ah
		mov	bp, dx
		mul	cx
		mov	dx, bp
		add	bx, ax
		shl	cx, 4
		lodsb
		inc	dh
		cmp	dh, dl
		jbe	short loc_10173
		jmp	short loc_1019D
; ---------------------------------------------------------------------------

loc_1019B:				; CODE XREF: ParseArgs2+1Dj
		neg	bx

loc_1019D:				; CODE XREF: ParseArgs2+19j
					; ParseArgs2+3Dj
		cld
		mov	ax, bx
		pop	bp
		pop	si
		pop	dx
		pop	cx
		pop	bx
		retn
ParseArgs2	endp


; =============== S U B	R O U T	I N E =======================================


sub_101A6	proc near		; CODE XREF: sub_10071+26p
		push	bx
		push	cx
		push	dx
		push	si
		push	di
		push	bp
		push	ds
		push	es
		call	DoInit
		call	DoMainLoop
		call	DoCleanup
		pop	es
		pop	ds
		pop	bp
		pop	di
		pop	si
		pop	dx
		pop	cx
		pop	bx
		retn
sub_101A6	endp


; =============== S U B	R O U T	I N E =======================================


DoInit		proc near		; CODE XREF: sub_101A6+8p
		call	sub_1028A
		pusha
		push	ds
		push	es
		mov	cx, 1
		call	sub_14759
		pop	es
		pop	ds
		popa
		call	Mouse_Hide
		call	sub_102B3
		call	sub_102C1
		call	InitFightMemory
		call	GfxMemory_Alloc
		call	LoadPlrEnmData
		call	LoadElectrData
		call	CheckInitialTurn
		call	LoadEnemyGfx2
		call	LoadSFlameGPA2
		call	sub_10528
		call	sub_1026D
		call	ObtainMousePos
		call	sub_10549
		retn
DoInit		endp


; =============== S U B	R O U T	I N E =======================================


DoMainLoop	proc near		; CODE XREF: sub_101A6+Bp
		call	CheckError
		jnz	short locret_1020D
		call	InitStatDisp
		call	DecideFirstTurn

loc_10205:				; CODE XREF: DoMainLoop+11j
		call	DoFightTurn
		call	CheckFightEnd
		jz	short loc_10205

locret_1020D:				; CODE XREF: DoMainLoop+3j
		retn
DoMainLoop	endp


; =============== S U B	R O U T	I N E =======================================


DoCleanup	proc near		; CODE XREF: sub_101A6+Ep
		call	sub_10221
		call	sub_10235
		call	sub_10259
		call	sub_102C1
		call	sub_1026D
		call	GfxMemory_Free
		retn
DoCleanup	endp


; =============== S U B	R O U T	I N E =======================================


sub_10221	proc near		; CODE XREF: DoCleanupp
		push	ds
		call	CheckError
		jnz	short loc_10231
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		mov	al, fightEnd
		jmp	short loc_10233
; ---------------------------------------------------------------------------

loc_10231:				; CODE XREF: sub_10221+4j
		mov	al, 3

loc_10233:				; CODE XREF: sub_10221+Ej
		pop	ds
		assume ds:nothing
		retn
sub_10221	endp


; =============== S U B	R O U T	I N E =======================================


sub_10235	proc near		; CODE XREF: DoCleanup+3p
		push	cx
		push	dx
		push	si
		mov	cx, 0
		mov	dx, 27Fh
		call	Mouse_SetRegion
		mov	cx, 0
		mov	dx, 18Fh
		call	sub_14769
		mov	si, 99h	; 'ô'
		mov	cx, [si]
		mov	dx, [si+2]
		call	Mouse_SetPos
		pop	si
		pop	dx
		pop	cx
		retn
sub_10235	endp


; =============== S U B	R O U T	I N E =======================================


sub_10259	proc near		; CODE XREF: DoCleanup+6p
		pusha
		push	ds
		push	es
		call	CheckError
		jnz	short loc_10269
		mov	al, 0
		mov	cx, 0
		call	sub_146A5

loc_10269:				; CODE XREF: sub_10259+6j
		pop	es
		pop	ds
		popa
		retn
sub_10259	endp


; =============== S U B	R O U T	I N E =======================================


sub_1026D	proc near		; CODE XREF: DoInit+30p DoCleanup+Cp
		pusha
		push	ds
		push	es
		call	CheckError
		jnz	short loc_1027D
		mov	al, 0
		mov	cx, 3
		call	sub_146BC

loc_1027D:				; CODE XREF: sub_1026D+6j
		pop	es
		pop	ds
		popa
		retn
sub_1026D	endp


; =============== S U B	R O U T	I N E =======================================


GfxMemory_Free	proc near		; CODE XREF: DoCleanup+Fp
		call	DoMemoryFree
		jnb	short locret_10289
		call	SetError

locret_10289:				; CODE XREF: GfxMemory_Free+3j
		retn
GfxMemory_Free	endp


; =============== S U B	R O U T	I N E =======================================


sub_1028A	proc near		; CODE XREF: DoInitp
		push	ax
		push	cx
		push	dx
		push	ds
		mov	ax, ds
		mov	dx, es
		mov	cx, seg	seg001
		mov	ds, cx
		assume ds:seg001
		mov	word ptr dword_1855C+2,	ax
		mov	word ptr dword_1855C, si
		mov	word ptr dword_18560+2,	dx
		mov	word ptr dword_18560, di
		mov	word ptr dword_18564+2,	bx
		mov	word ptr dword_18564, bp
		pop	ds
		assume ds:nothing
		pop	dx
		pop	cx
		pop	ax
		retn
sub_1028A	endp


; =============== S U B	R O U T	I N E =======================================


sub_102B3	proc near		; CODE XREF: DoInit+12p
		pusha
		push	ds
		push	es
		mov	al, 0
		xor	cx, cx
		call	sub_146BC
		pop	es
		pop	ds
		popa
		retn
sub_102B3	endp


; =============== S U B	R O U T	I N E =======================================


sub_102C1	proc near		; CODE XREF: DoInit+15p DoCleanup+9p
		pusha
		push	ds
		push	es
		mov	al, 1
		call	sub_118CA
		pop	es
		pop	ds
		popa
		retn
sub_102C1	endp


; =============== S U B	R O U T	I N E =======================================


InitFightMemory	proc near		; CODE XREF: DoInit+18p
		push	ax
		push	cx
		push	di
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		mov	es, ax
		assume es:seg001
		mov	fightEnd, 0
		mov	di, offset PlayerMem
		xor	ax, ax
		mov	cx, 58h
		cld
		rep stosb
		mov	di, offset EnemyMem
		mov	cx, 58h
		rep stosb
		mov	di, offset Electrode2Mem
		mov	cx, 58h
		rep stosb
		pop	di
		pop	cx
		pop	ax
		retn
InitFightMemory	endp

; ---------------------------------------------------------------------------
		pusha
		push	ds
		push	es
		mov	ax, word_1855A
		mov	es, ax
		assume es:nothing
		mov	bx, seg	seg003
		sub	bx, ax
		inc	bx
		mov	ah, 4Ah
		int	21h		; DOS -	2+ - ADJUST MEMORY BLOCK SIZE (SETBLOCK)
					; ES = segment address of block	to change
					; BX = new size	in paragraphs
		jnb	short loc_10312
		call	SetError

loc_10312:				; CODE XREF: seg000:030Dj
		pop	es
		pop	ds
		assume ds:nothing
		popa
		retn

; =============== S U B	R O U T	I N E =======================================


GfxMemory_Alloc	proc near		; CODE XREF: DoInit+1Bp
		call	CheckError
		jnz	short locret_10323
		call	DoMemoryAlloc
		jnb	short locret_10323
		call	SetError

locret_10323:				; CODE XREF: GfxMemory_Alloc+3j
					; GfxMemory_Alloc+8j
		retn
GfxMemory_Alloc	endp


; =============== S U B	R O U T	I N E =======================================


LoadPlrEnmData	proc near		; CODE XREF: DoInit+1Ep
		push	ax
		push	si
		push	di
		push	ds
		push	es
		call	CheckError
		jnz	short loc_1034E
		mov	si, seg	seg001
		mov	ds, si
		assume ds:seg001
		mov	es, si
		assume es:seg001
		lds	si, dword_1855C
		assume ds:nothing
		mov	di, offset PlayerMem
		call	LoadCharData
		mov	si, seg	seg001
		mov	ds, si
		assume ds:seg001
		lds	si, dword_18560
		assume ds:nothing
		mov	di, offset EnemyMem
		call	LoadCharData

loc_1034E:				; CODE XREF: LoadPlrEnmData+8j
		pop	es
		assume es:nothing
		pop	ds
		pop	di
		pop	si
		pop	ax
		retn
LoadPlrEnmData	endp


; =============== S U B	R O U T	I N E =======================================


LoadCharData	proc near		; CODE XREF: LoadPlrEnmData+18p
					; LoadPlrEnmData+27p
		push	ax
		test	byte ptr [si+19h], 1
		jz	short loc_10360
		call	LoadPlayerData
		jmp	short loc_10363
; ---------------------------------------------------------------------------

loc_10360:				; CODE XREF: LoadCharData+5j
		call	LoadEnemyData

loc_10363:				; CODE XREF: LoadCharData+Aj
		pop	ax
		retn
LoadCharData	endp


; =============== S U B	R O U T	I N E =======================================


LoadPlayerData	proc near		; CODE XREF: LoadCharData+7p
		pusha
		mov	bx, si
		mov	dx, di
		mov	cx, 0Ch
		cld
		rep movsw		; copy name
		xor	al, al
		stosb			; append 0 terminator
		mov	si, bx
		mov	di, dx
		mov	al, [si+18h]
		mov	es:[di+19h], al	; character ID
		mov	al, [si+19h]
		mov	es:[di+1Ah], al	; character flags
		mov	ax, [si+1Ah]
		mov	es:[di+1Bh], ax	; initial HP
		mov	ax, [si+1Ch]
		mov	es:[di+1Dh], ax	; maximum HP
		mov	ax, [si+1Eh]	; copy ATK
		mov	es:[di+21h], ax	; current ATK
		mov	es:[di+23h], ax	; initial ATK
		mov	ax, [si+20h]	; copy DEF
		mov	es:[di+27h], ax	; current DEF
		mov	es:[di+29h], ax	; initial DEF
		mov	ax, [si+22h]
		mov	es:[di+2Dh], ax	; immunity flags
		mov	al, [si+27h]
		mov	es:[di+36h], al
		mov	al, [si+28h]
		mov	es:[di+37h], al
		mov	al, [si+29h]
		mov	es:[di+38h], al
		mov	al, [si+2Ah]
		mov	es:[di+39h], al
		mov	al, [si+2Bh]
		mov	es:[di+3Ah], al
		mov	al, [si+2Ch]
		mov	es:[di+3Bh], al
		mov	al, [si+2Dh]
		mov	es:[di+3Ch], al
		mov	al, [si+24h]
		mov	es:[di+3Eh], al
		mov	al, [si+25h]
		mov	es:[di+3Fh], al
		mov	al, [si+26h]
		mov	es:[di+40h], al
		mov	al, [si+2Eh]
		mov	es:[di+41h], al
		mov	al, [si+2Fh]
		mov	es:[di+42h], al
		popa
		retn
LoadPlayerData	endp


; =============== S U B	R O U T	I N E =======================================


LoadEnemyData	proc near		; CODE XREF: LoadCharData:loc_10360p
					; LoadElectrData+14p
		pusha
		mov	bx, si
		mov	dx, di
		mov	cx, 0Ch
		cld
		rep movsw		; copy name
		xor	al, al
		stosb			; append 0 terminator
		mov	si, bx
		mov	di, dx
		mov	al, [si+18h]
		mov	es:[di+19h], al	; character ID
		mov	al, [si+19h]
		mov	es:[di+1Ah], al	; character flags
		mov	ax, [si+1Ah]	; copy initial/maximum HP
		mov	es:[di+1Bh], ax	; current HP
		mov	es:[di+1Dh], ax	; maximum HP
		mov	ax, [si+1Ch]	; copy ATK
		mov	es:[di+21h], ax	; current ATK
		mov	es:[di+23h], ax	; initial ATK
		mov	ax, [si+1Eh]	; copy DEF
		mov	es:[di+27h], ax	; current DEF
		mov	es:[di+29h], ax	; initial DEF
		mov	ax, [si+20h]
		mov	es:[di+2Dh], ax	; immunity flags
		mov	al, [si+22h]
		mov	es:[di+2Fh], al	; unused value
		mov	al, [si+23h]
		mov	es:[di+30h], al
		mov	al, [si+24h]
		mov	es:[di+31h], al
		mov	al, [si+25h]
		mov	es:[di+32h], al	; critical hit chance
		mov	al, [si+26h]
		mov	es:[di+33h], al	; action 00 probability
		mov	al, [si+27h]
		mov	es:[di+34h], al
		mov	al, [si+28h]
		mov	es:[di+35h], al	; action 02 (character-specific) probability
		mov	al, [si+29h]
		mov	es:[di+36h], al
		mov	al, [si+2Ah]
		mov	es:[di+37h], al
		mov	al, [si+2Bh]
		mov	es:[di+38h], al
		mov	al, [si+2Ch]
		mov	es:[di+39h], al
		mov	al, [si+2Dh]
		mov	es:[di+3Ah], al
		mov	al, [si+2Eh]
		mov	es:[di+3Bh], al
		mov	al, [si+2Fh]
		mov	es:[di+3Ch], al
		mov	al, [si+30h]
		mov	es:[di+3Dh], al	; action 0A (special) probability
		popa
		retn
LoadEnemyData	endp


; =============== S U B	R O U T	I N E =======================================


LoadElectrData	proc near		; CODE XREF: DoInit+21p
		pusha
		push	ds
		push	es
		call	CheckError
		jnz	short loc_104D0
		mov	di, seg	seg001
		mov	es, di
		assume es:seg001
		mov	di, offset Electrode2Mem
		lds	si, ds:dword_18564
		call	LoadEnemyData

loc_104D0:				; CODE XREF: LoadElectrData+6j
		pop	es
		assume es:nothing
		pop	ds
		popa
		retn
LoadElectrData	endp


; =============== S U B	R O U T	I N E =======================================


CheckInitialTurn proc near		; CODE XREF: DoInit+24p
		push	si
		push	ds
		call	CheckError
		jnz	short loc_104F5
		mov	si, seg	seg001
		mov	ds, si
		assume ds:seg001
		mov	si, offset PlayerMem
		test	byte ptr [si+1Ah], 1
		jnz	short loc_104F5
		mov	si, offset EnemyMem
		test	byte ptr [si+1Ah], 1
		jnz	short loc_104F5
		call	SetError

loc_104F5:				; CODE XREF: CheckInitialTurn+5j
					; CheckInitialTurn+13j	...
		pop	ds
		pop	si
		retn
CheckInitialTurn endp


; =============== S U B	R O U T	I N E =======================================


LoadEnemyGfx2	proc near		; CODE XREF: DoInit+27p
		push	ax
		call	CheckError
		jnz	short loc_10518
		mov	si, offset PlayerMem
		mov	al, [si+19h]
		mov	si, offset EnemyMem
		mov	ah, [si+19h]
		cmp	al, 0
		jnz	short loc_10510
		mov	al, ah

loc_10510:				; CODE XREF: LoadEnemyGfx2+14j
		call	LoadEnemyGfx
		jnb	short loc_10518
		call	SetError

loc_10518:				; CODE XREF: LoadEnemyGfx2+4j
					; LoadEnemyGfx2+1Bj
		pop	ax
		retn
LoadEnemyGfx2	endp


; =============== S U B	R O U T	I N E =======================================


LoadSFlameGPA2	proc near		; CODE XREF: DoInit+2Ap
		call	CheckError
		jnz	short locret_10527
		call	LoadSFlameGPA
		jnb	short locret_10527
		call	SetError

locret_10527:				; CODE XREF: LoadSFlameGPA2+3j
					; LoadSFlameGPA2+8j
		retn
LoadSFlameGPA2	endp


; =============== S U B	R O U T	I N E =======================================


sub_10528	proc near		; CODE XREF: DoInit+2Dp
		push	ax
		call	CheckError
		jnz	short loc_10539
		xor	al, al

loc_10530:				; CODE XREF: sub_10528+Fj
		call	sub_1316C
		inc	al
		cmp	al, 2
		jbe	short loc_10530

loc_10539:				; CODE XREF: sub_10528+4j
		pop	ax
		retn
sub_10528	endp


; =============== S U B	R O U T	I N E =======================================


ObtainMousePos	proc near		; CODE XREF: DoInit+33p
		pusha
		mov	si, offset mouseX
		call	Mouse_GetPos
		mov	[si], cx
		mov	[si+2],	dx
		popa
		retn
ObtainMousePos	endp


; =============== S U B	R O U T	I N E =======================================


sub_10549	proc near		; CODE XREF: DoInit+36p
		push	cx
		push	dx
		mov	cx, word_14D5D
		mov	dx, word_14D5F
		call	Mouse_SetRegion
		mov	cx, word_14D61
		mov	dx, word_14D63
		call	sub_14769
		mov	cx, word_14D65
		mov	dx, word_14D67
		call	Mouse_SetPos
		pop	dx
		pop	cx
		retn
sub_10549	endp


; =============== S U B	R O U T	I N E =======================================


SetError	proc near		; CODE XREF: GfxMemory_Free+5p
					; seg000:030Fp	...
		push	ax
		push	ds
		mov	ax, seg	seg001
		mov	ds, ax
		mov	errorFlag, 1
		pop	ds
		assume ds:nothing
		pop	ax
		retn
SetError	endp


; =============== S U B	R O U T	I N E =======================================


CheckError	proc near		; CODE XREF: DoMainLoopp sub_10221+1p	...
		push	ax
		push	ds
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		cmp	errorFlag, 0
		pop	ds
		assume ds:nothing
		pop	ax
		retn
CheckError	endp


; =============== S U B	R O U T	I N E =======================================


InitStatDisp	proc near		; CODE XREF: DoMainLoop+5p
		push	bx
		push	si
		push	di
		push	ds
		mov	si, seg	seg001
		mov	ds, si
		assume ds:seg001
		mov	si, offset PlayerMem
		mov	di, offset EnemyMem
		mov	bx, offset Electrode2Mem
		mov	word ptr [si+1Fh], 0 ; player: reset "last displayed" health points
		mov	word ptr [si+25h], 0 ; player: reset "last displayed" attack points
		mov	word ptr [si+2Bh], 0 ; player: reset "last displayed" defense points
		mov	word ptr [di+1Fh], 0 ; same for	enemy
		mov	word ptr [di+25h], 0
		mov	word ptr [di+2Bh], 0
		mov	word ptr [bx+1Fh], 0 ; same for	Electrode #2
		mov	word ptr [bx+25h], 0
		mov	word ptr [bx+2Bh], 0
		call	RefreshStats
		pop	ds
		assume ds:nothing
		pop	di
		pop	si
		pop	bx
		retn
InitStatDisp	endp


; =============== S U B	R O U T	I N E =======================================


DecideFirstTurn	proc near		; CODE XREF: DoMainLoop+8p
		push	si
		push	di
		push	ds
		mov	si, seg	seg001
		mov	ds, si
		assume ds:seg001
		mov	si, offset PlayerMem
		mov	di, offset EnemyMem
		test	byte ptr [si+1Ah], 1
		jnz	short loc_105EA
		xchg	si, di

loc_105EA:				; CODE XREF: DecideFirstTurn+12j
		mov	figher1MemPtr, si
		mov	figher2MemPtr, di
		pop	ds
		assume ds:nothing
		pop	di
		pop	si
		retn
DecideFirstTurn	endp


; =============== S U B	R O U T	I N E =======================================


DoFightTurn	proc near		; CODE XREF: DoMainLoop:loc_10205p
		push	si
		push	di
		push	ds
		mov	si, seg	seg001
		mov	ds, si
		assume ds:seg001
		call	RestoreElectrHP
		mov	si, figher1MemPtr
		mov	di, figher2MemPtr
		call	ElctTakeAttack
		call	SetSavedTxtPtrs
		call	ParalysisTimer
		jb	short loc_10627
		call	NoActTimer_Drug
		call	NoActTimer_Charge
		call	NoActTimer_Flash
		call	DoAction
		cmp	fightEnd, 0
		jnz	short loc_1064D

loc_10627:				; CODE XREF: DoFightTurn+1Cj
		mov	si, figher2MemPtr
		mov	di, figher1MemPtr
		call	ElctTakeAttack
		call	SetSavedTxtPtrs
		call	ParalysisTimer
		jb	short loc_10650
		call	NoActTimer_Drug
		call	NoActTimer_Charge
		call	NoActTimer_Flash
		call	DoAction
		cmp	fightEnd, 0
		jz	short loc_10650

loc_1064D:				; CODE XREF: DoFightTurn+2Fj
		call	DoFightEnd

loc_10650:				; CODE XREF: DoFightTurn+42j
					; DoFightTurn+55j
		pop	ds
		pop	di
		pop	si
		retn
DoFightTurn	endp


; =============== S U B	R O U T	I N E =======================================


RestoreElectrHP	proc near		; CODE XREF: DoFightTurn+8p
		pusha
		push	ds
		push	es
		mov	si, offset PlayerMem
		test	byte ptr [si+1Ah], 1
		jz	short loc_10667
		test	word ptr [si+45h], 200h
		jz	short loc_10677

loc_10667:				; CODE XREF: RestoreElectrHP+Aj
		mov	si, offset EnemyMem
		test	byte ptr [si+1Ah], 1
		jz	short loc_10690
		test	word ptr [si+45h], 200h
		jnz	short loc_10690

loc_10677:				; CODE XREF: RestoreElectrHP+11j
		mov	si, seg	seg001
		mov	ds, si
		mov	si, offset Electrode2Mem
		mov	ax, [si+1Bh]
		add	ax, 10		; restore 10 HP
		cmp	ax, [si+1Dh]
		jbe	short loc_1068D
		mov	ax, [si+1Dh]

loc_1068D:				; CODE XREF: RestoreElectrHP+34j
		mov	[si+1Bh], ax

loc_10690:				; CODE XREF: RestoreElectrHP+1Aj
					; RestoreElectrHP+21j
		pop	es
		pop	ds
		popa
		retn
RestoreElectrHP	endp


; =============== S U B	R O U T	I N E =======================================


ParalysisTimer	proc near		; CODE XREF: DoFightTurn+19p
					; DoFightTurn+3Fp
		push	ax
		test	word ptr [si+45h], 400h
		jz	short loc_106B9
		cmp	byte ptr [si+47h], 0
		jz	short loc_106A8
		dec	byte ptr [si+47h]
		stc
		jmp	short loc_106BA
; ---------------------------------------------------------------------------

loc_106A8:				; CODE XREF: ParalysisTimer+Cj
		and	word ptr [si+45h], not 400h ; remove "paralysis" flag
		call	ClearMessageBox
		mov	ax, 2
		call	ShowMessageText	; [Dengeki Nurse] is no	longer paralyzed!
		call	sub_12EEB

loc_106B9:				; CODE XREF: ParalysisTimer+6j
		clc

loc_106BA:				; CODE XREF: ParalysisTimer+12j
		pop	ax
		retn
ParalysisTimer	endp


; =============== S U B	R O U T	I N E =======================================


NoActTimer_Drug	proc near		; CODE XREF: DoFightTurn+1Ep
					; DoFightTurn+44p
		push	ax
		test	word ptr [si+45h], 800h
		jz	short loc_106E0
		cmp	byte ptr [si+48h], 0
		jz	short loc_106CF
		dec	byte ptr [si+48h]
		jmp	short loc_106E0
; ---------------------------------------------------------------------------

loc_106CF:				; CODE XREF: NoActTimer_Drug+Cj
		and	word ptr [si+45h], not 800h ; remove "sticky drugs" flag
		call	ClearMessageBox
		mov	ax, 3
		call	ShowMessageText	; The drug's residue has finally dried!
		call	sub_12EEB

loc_106E0:				; CODE XREF: NoActTimer_Drug+6j
					; NoActTimer_Drug+11j
		pop	ax
		retn
NoActTimer_Drug	endp


; =============== S U B	R O U T	I N E =======================================


NoActTimer_Charge proc near		; CODE XREF: DoFightTurn+21p
					; DoFightTurn+47p
		push	ax
		test	word ptr [si+45h], 1000h
		jz	short loc_10706
		cmp	byte ptr [si+48h], 0
		jz	short loc_106F5
		dec	byte ptr [si+48h]
		jmp	short loc_10706
; ---------------------------------------------------------------------------

loc_106F5:				; CODE XREF: NoActTimer_Charge+Cj
		and	word ptr [si+45h], not 1000h ; remove "no concentration" flag
		call	ClearMessageBox
		mov	ax, 4
		call	ShowMessageText	; [Dengeki Nurse] has regained her composure!
		call	sub_12EEB

loc_10706:				; CODE XREF: NoActTimer_Charge+6j
					; NoActTimer_Charge+11j
		pop	ax
		retn
NoActTimer_Charge endp


; =============== S U B	R O U T	I N E =======================================


NoActTimer_Flash proc near		; CODE XREF: DoFightTurn+24p
					; DoFightTurn+4Ap
		push	ax
		test	word ptr [si+45h], 2000h
		jz	short loc_1072C
		cmp	byte ptr [si+48h], 0
		jz	short loc_1071B
		dec	byte ptr [si+48h]
		jmp	short loc_1072C
; ---------------------------------------------------------------------------

loc_1071B:				; CODE XREF: NoActTimer_Flash+Cj
		and	word ptr [si+45h], 0DFFFh
		call	ClearMessageBox
		mov	ax, 22h
		call	ShowMessageText	; We can give the Plasma Flash a shot again!
		call	sub_12EEB

loc_1072C:				; CODE XREF: NoActTimer_Flash+6j
					; NoActTimer_Flash+11j
		pop	ax
		retn
NoActTimer_Flash endp


; =============== S U B	R O U T	I N E =======================================


ElctTakeAttack	proc near		; CODE XREF: DoFightTurn+13p
					; DoFightTurn+39p
		test	word ptr [di+45h], 200h
		jz	short locret_10738
		mov	di, offset Electrode2Mem ; redirect damage to Electrode	2

locret_10738:				; CODE XREF: ElctTakeAttack+5j
		retn
ElctTakeAttack	endp


; =============== S U B	R O U T	I N E =======================================


DoAction	proc near		; CODE XREF: DoFightTurn+27p
					; DoFightTurn+4Dp
		call	SetTurnBaseValues
		call	sub_107F2
		call	ChooseAction
		cmp	skipActions, 0
		jnz	short locret_10791
		call	ShowActionImage
		call	ShowAct02Img
		call	ShowActIntroMsg_a
		call	ShowSpcAtkImgs
		call	ExecAction_a	; This calculates all of the damage values.
		call	ApplyDamage_All
		call	ShowSomeActImg
		call	ShowMaxPlsFlashImg
		call	ShowSomeActImg2
		call	sub_10B53
		call	ShowChargedFX
		call	ShowPlasmaCharge
		call	RefreshStats
		call	ShowCritMessage
		call	DoDgkShuriken
		call	CheckZeroHP
		call	ShowActMessage_a
		call	DoAtkFlag_Shuriken
		call	sub_10D2C
		call	DoElectrBreak
		call	ShowFightEndImg
		call	ShowActResult_A
		call	CheckElctBreak
		call	sub_10DAB

locret_10791:				; CODE XREF: DoAction+Ej
		retn
DoAction	endp


; =============== S U B	R O U T	I N E =======================================


SetTurnBaseValues proc near		; CODE XREF: DoActionp
		push	ax
		mov	ax, [si+1Bh]	; current health points
		mov	[si+1Fh], ax
		mov	ax, [si+21h]	; current attack points
		mov	[si+25h], ax
		mov	ax, [si+27h]	; current defense points
		mov	[si+2Bh], ax
		mov	al, [si+43h]	; current Plasma Charge	level
		mov	[si+44h], al
		mov	ax, [di+1Bh]
		mov	[di+1Fh], ax
		mov	ax, [di+21h]
		mov	[di+25h], ax
		mov	ax, [di+27h]
		mov	[di+2Bh], ax
		mov	al, [di+43h]
		mov	[di+44h], al
		mov	ax, 8000h
		mov	[si+49h], ax
		mov	[si+4Bh], ax
		mov	[si+4Dh], ax
		mov	[si+4Fh], al
		mov	[si+52h], ax
		mov	[si+54h], ax
		mov	[si+56h], al
		mov	[di+49h], ax
		mov	[di+4Bh], ax
		mov	[di+4Dh], ax
		mov	[di+4Fh], al
		mov	[di+52h], ax
		mov	[di+54h], ax
		mov	[di+56h], al
		pop	ax
		retn
SetTurnBaseValues endp


; =============== S U B	R O U T	I N E =======================================


sub_107F2	proc near		; CODE XREF: DoAction+3p
		push	ax
		xor	al, al
		test	word ptr [si+45h], 200h	; check	"Electrode #2 in use" flag
		jz	short loc_107FE
		mov	al, 8

loc_107FE:				; CODE XREF: sub_107F2+8j
		call	DrawActionImage
		pop	ax
		retn
sub_107F2	endp


; =============== S U B	R O U T	I N E =======================================


ChooseAction	proc near		; CODE XREF: DoAction+6p
		push	ax
		test	byte ptr [si+1Ah], 2
		jz	short loc_10815
		test	byte ptr [si+1Ah], 1
		jz	short loc_10815
		call	j_PlayerActSel
		jmp	short loc_1081E
; ---------------------------------------------------------------------------

loc_10815:				; CODE XREF: ChooseAction+5j
					; ChooseAction+Bj
		call	ChooseEnemyAct
		call	EnemySpcAct_Choose
		call	EnemySpecialAct

loc_1081E:				; CODE XREF: ChooseAction+10j
		mov	PlrActionID, ax
		mov	PlrActionType, bx
		pop	ax
		retn
ChooseAction	endp


; =============== S U B	R O U T	I N E =======================================


ShowActionImage	proc near		; CODE XREF: DoAction+10p
		push	ax
		push	bx
		mov	bx, offset PlrActImageIDs ; player mode
		test	byte ptr [si+1Ah], 1
		jnz	short loc_10835
		mov	bx, offset EnmActImageIDs ; enemy mode

loc_10835:				; CODE XREF: ShowActionImage+9j
		mov	ax, PlrActionID
		cmp	ax, 0Dh		; Plasma Flash?
		jnz	short loc_10849
		mov	al, 0Ah		; Charge <= 80%	-> attack image	0A
		cmp	byte ptr [si+43h], 80
		jbe	short loc_10851
		mov	al, 0Bh		; Charge >= 81%	-> attack image	0B
		jmp	short loc_10851
; ---------------------------------------------------------------------------

loc_10849:				; CODE XREF: ShowActionImage+14j
		add	bx, ax
		mov	al, [bx]
		cmp	al, 0FFh
		jz	short loc_10854

loc_10851:				; CODE XREF: ShowActionImage+1Cj
					; ShowActionImage+20j
		call	DrawActionImage

loc_10854:				; CODE XREF: ShowActionImage+28j
		pop	bx
		pop	ax
		retn
ShowActionImage	endp


; =============== S U B	R O U T	I N E =======================================


ShowAct02Img	proc near		; CODE XREF: DoAction+13p
		push	ax
		cmp	PlrActionID, 2
		jnz	short loc_1086E
		test	byte ptr [di+1Ah], 8
		jnz	short loc_10869
		mov	al, 0Fh
		jmp	short loc_1086B
; ---------------------------------------------------------------------------

loc_10869:				; CODE XREF: ShowAct02Img+Cj
		mov	al, 8

loc_1086B:				; CODE XREF: ShowAct02Img+10j
		call	DrawActionImage

loc_1086E:				; CODE XREF: ShowAct02Img+6j
		pop	ax
		retn
ShowAct02Img	endp


; =============== S U B	R O U T	I N E =======================================


ShowActIntroMsg_a proc near		; CODE XREF: DoAction+16p
		push	ax
		call	ClearMessageBox
		mov	ax, PlrActionID
		call	ShowActIntroMsg
		pop	ax
		retn
ShowActIntroMsg_a endp


; =============== S U B	R O U T	I N E =======================================


ShowSomeActImg2	proc near		; CODE XREF: DoAction+28p
					; DoDgkShuriken+30p ...
		push	ax
		push	bx
		mov	ax, PlrActionID
		cmp	ax, 0
		jz	short loc_108A1
		cmp	ax, 10h
		jz	short loc_108A1
		cmp	ax, 12h
		jz	short loc_108AD
		cmp	ax, 0Dh
		jnz	short loc_108B9
		mov	bl, 2
		cmp	byte ptr [si+44h], 80
		jbe	short loc_108C0
		mov	bl, 1
		jmp	short loc_108C0
; ---------------------------------------------------------------------------

loc_108A1:				; CODE XREF: ShowSomeActImg2+8j
					; ShowSomeActImg2+Dj
		mov	bl, 4
		cmp	byte ptr [di+56h], 1
		jz	short loc_108C0
		mov	bl, 3
		jmp	short loc_108C0
; ---------------------------------------------------------------------------

loc_108AD:				; CODE XREF: ShowSomeActImg2+12j
		mov	bl, 6
		cmp	byte ptr [di+56h], 1
		jz	short loc_108C0
		mov	bl, 5
		jmp	short loc_108C0
; ---------------------------------------------------------------------------

loc_108B9:				; CODE XREF: ShowSomeActImg2+17j
		mov	bx, offset byte_14D48
		add	bx, ax
		mov	bl, [bx]

loc_108C0:				; CODE XREF: ShowSomeActImg2+1Fj
					; ShowSomeActImg2+23j ...
		cmp	byte ptr [si+4Fh], 2
		jz	short loc_108CC
		cmp	byte ptr [di+4Fh], 2
		jnz	short loc_108CE

loc_108CC:				; CODE XREF: ShowSomeActImg2+48j
		mov	bl, 10h

loc_108CE:				; CODE XREF: ShowSomeActImg2+4Ej
		cmp	bl, 0FFh
		jz	short loc_108D6
		call	APICall_ShowImg

loc_108D6:				; CODE XREF: ShowSomeActImg2+55j
		pop	bx
		pop	ax
		retn
ShowSomeActImg2	endp


; =============== S U B	R O U T	I N E =======================================


ShowSpcAtkImgs	proc near		; CODE XREF: DoAction+19p
		push	ax
		mov	ax, PlrActionID
		cmp	ax, 0Dh		; Plasma Flash?
		jnz	short loc_1090B
		call	sub_13310
		cmp	byte ptr [si+43h], 60
		jbe	short loc_10935
		call	sub_13310
		cmp	byte ptr [si+43h], 70
		jbe	short loc_10935
		call	sub_13310
		cmp	byte ptr [si+43h], 80
		jbe	short loc_10935
		call	sub_13310
		cmp	byte ptr [si+43h], 90
		jbe	short loc_10935
		call	sub_13310
		jmp	short loc_10935
; ---------------------------------------------------------------------------

loc_1090B:				; CODE XREF: ShowSpcAtkImgs+7j
		cmp	ax, 0Fh		; Plasma Charge?
		jnz	short loc_1091B
		call	sub_13357
		call	sub_13357
		call	sub_13357
		jmp	short loc_10935
; ---------------------------------------------------------------------------

loc_1091B:				; CODE XREF: ShowSpcAtkImgs+35j
		cmp	ax, 13h		; Dengeki Laser	Scalpel?
		jnz	short loc_10925
		call	sub_13357
		jmp	short loc_10935
; ---------------------------------------------------------------------------

loc_10925:				; CODE XREF: ShowSpcAtkImgs+45j
		cmp	ax, 14h		; Dengeki Bazooka?
		jnz	short loc_1092D
		call	sub_133EC

loc_1092D:				; CODE XREF: ShowSpcAtkImgs+4Fj
		cmp	ax, 0Ah		; enemy	special	attack?
		jnz	short loc_10935
		call	sub_1340D

loc_10935:				; CODE XREF: ShowSpcAtkImgs+10j
					; ShowSpcAtkImgs+19j ...
		pop	ax
		retn
ShowSpcAtkImgs	endp


; =============== S U B	R O U T	I N E =======================================


ExecAction_a	proc near		; CODE XREF: DoAction+1Cp
		push	ax
		mov	ax, PlrActionID
		call	ExecAction
		pop	ax
		retn
ExecAction_a	endp


; =============== S U B	R O U T	I N E =======================================


ShowCritMessage	proc near		; CODE XREF: DoAction+37p
		push	ax
		cmp	byte ptr [di+56h], 0
		jz	short loc_10959
		mov	ax, 42h		; A beautiful strike (Dengeki Nurse hits)
		test	byte ptr [si+1Ah], 1
		jnz	short loc_10953
		mov	ax, 43h		; A heartbreaking strike (enemy	hits)

loc_10953:				; CODE XREF: ShowCritMessage+Ej
		call	ClearMessageBox
		call	ShowMessageText	; A critical strike!

loc_10959:				; CODE XREF: ShowCritMessage+5j
		pop	ax
		retn
ShowCritMessage	endp


; =============== S U B	R O U T	I N E =======================================


DoDgkShuriken	proc near		; CODE XREF: DoAction+3Ap
		push	ax
		push	bx
		cmp	PlrActionID, 11h
		jnz	short loc_109C4
		cmp	byte ptr [di+4Fh], 1
		jnz	short loc_109C4
		mov	bx, [di+49h]
		call	sub_12EEB
		call	ShowActResult_A
		test	word ptr [di+45h], 100h
		jnz	short loc_109C4
		cmp	byte ptr [di+51h], 1
		jbe	short loc_109C1
		mov	ax, [di+52h]
		mov	[di+49h], ax
		add	bx, ax
		call	ApplyDamage_All
		call	ShowSomeActImg2
		call	sub_10B53
		call	RefreshStats
		call	sub_12EEB
		call	ShowActResult_A
		test	word ptr [di+45h], 100h
		jnz	short loc_109C4
		cmp	byte ptr [di+51h], 2
		jbe	short loc_109C1
		mov	ax, [di+54h]
		mov	[di+49h], ax
		add	bx, ax
		call	ApplyDamage_All
		call	ShowSomeActImg2
		call	sub_10B53
		call	RefreshStats
		call	sub_12EEB
		call	ShowActResult_A

loc_109C1:				; CODE XREF: DoDgkShuriken+23j
					; DoDgkShuriken+4Aj
		mov	[di+49h], bx

loc_109C4:				; CODE XREF: DoDgkShuriken+7j
					; DoDgkShuriken+Dj ...
		pop	bx
		pop	ax
		retn
DoDgkShuriken	endp


; =============== S U B	R O U T	I N E =======================================


DoAtkFlag_Shuriken proc	near		; CODE XREF: DoAction+43p
		cmp	PlrActionID, 11h
		jnz	short locret_109D8
		cmp	byte ptr [di+4Fh], 1
		jnz	short locret_109D8
		mov	byte ptr [di+4Fh], 8

locret_109D8:				; CODE XREF: DoAtkFlag_Shuriken+5j
					; DoAtkFlag_Shuriken+Bj
		retn
DoAtkFlag_Shuriken endp


; =============== S U B	R O U T	I N E =======================================


ApplyDamage_All	proc near		; CODE XREF: DoAction+1Fp
					; DoDgkShuriken+2Dp ...
		call	ApplyDamage_One
		xchg	si, di
		call	ApplyDamage_One
		xchg	si, di
		retn
ApplyDamage_All	endp


; =============== S U B	R O U T	I N E =======================================


ApplyDamage_One	proc near		; CODE XREF: ApplyDamage_Allp
					; ApplyDamage_All+5p
		push	ax
		push	bx
		push	dx
		mov	ax, [si+1Bh]	; apply	health decreaase/increase
		cmp	ax, [si+1Dh]
		jbe	short loc_10A09
		mov	bx, [si+49h]
		cmp	bx, 8000h
		jz	short loc_10A09
		ja	short loc_10A2D
		mov	dx, ax
		sub	ax, bx
		jnb	short loc_10A07
		test	ax, 8000h
		jz	short loc_10A07
		xor	ax, ax

loc_10A07:				; CODE XREF: ApplyDamage_One+1Aj
					; ApplyDamage_One+1Fj
		jmp	short loc_10A2D
; ---------------------------------------------------------------------------

loc_10A09:				; CODE XREF: ApplyDamage_One+9j
					; ApplyDamage_One+12j
		mov	bx, [si+49h]
		cmp	bx, 8000h
		jz	short loc_10A30
		jb	short loc_10A15
		inc	bx

loc_10A15:				; CODE XREF: ApplyDamage_One+2Ej
		mov	ax, [si+1Bh]
		mov	dx, ax
		sub	ax, bx
		jnb	short loc_10A25
		test	ax, 8000h
		jz	short loc_10A25
		xor	ax, ax

loc_10A25:				; CODE XREF: ApplyDamage_One+38j
					; ApplyDamage_One+3Dj
		cmp	ax, [si+1Dh]
		jbe	short loc_10A2D
		mov	ax, [si+1Dh]

loc_10A2D:				; CODE XREF: ApplyDamage_One+14j
					; ApplyDamage_One:loc_10A07j ...
		mov	[si+1Bh], ax

loc_10A30:				; CODE XREF: ApplyDamage_One+2Cj
		mov	bx, [si+4Bh]	; apply	attack decreaase/increase
		cmp	bx, 8000h
		jz	short loc_10A65
		jb	short loc_10A3C
		inc	bx

loc_10A3C:				; CODE XREF: ApplyDamage_One+55j
		mov	ax, [si+21h]
		sub	ax, bx
		jnb	short loc_10A50
		test	ax, 8000h
		jz	short loc_10A50
		xor	ax, ax
		mov	bx, [si+21h]
		mov	[si+4Bh], bx

loc_10A50:				; CODE XREF: ApplyDamage_One+5Dj
					; ApplyDamage_One+62j
		cmp	ax, 100
		jbe	short loc_10A62
		mov	ax, 100
		mov	bx, ax
		sub	bx, [si+21h]
		not	bx
		mov	[si+4Bh], bx

loc_10A62:				; CODE XREF: ApplyDamage_One+6Fj
		mov	[si+21h], ax

loc_10A65:				; CODE XREF: ApplyDamage_One+53j
		mov	bx, [si+4Dh]	; apply	defense	decreaase/increase
		cmp	bx, 8000h
		jz	short loc_10A9A
		jb	short loc_10A71
		inc	bx

loc_10A71:				; CODE XREF: ApplyDamage_One+8Aj
		mov	ax, [si+27h]
		sub	ax, bx
		jnb	short loc_10A85
		test	ax, 8000h
		jz	short loc_10A85
		xor	ax, ax
		mov	bx, [si+27h]
		mov	[si+4Dh], bx

loc_10A85:				; CODE XREF: ApplyDamage_One+92j
					; ApplyDamage_One+97j
		cmp	ax, 100
		jbe	short loc_10A97
		mov	ax, 100
		mov	bx, ax
		sub	bx, [si+27h]
		not	bx
		mov	[si+4Dh], bx

loc_10A97:				; CODE XREF: ApplyDamage_One+A4j
		mov	[si+27h], ax

loc_10A9A:				; CODE XREF: ApplyDamage_One+88j
		and	word ptr [si+45h], not 103h ; disable/enable certain enemy actions depending on	conditions
		mov	ax, [si+1Bh]	; current HP
		mov	bx, [si+1Dh]	; initial HP
		or	ax, ax
		jnz	short loc_10AAE
		or	word ptr [si+45h], 100h	; current == initial HP	-> ??

loc_10AAE:				; CODE XREF: ApplyDamage_One+C3j
		cmp	ax, bx
		jb	short loc_10AB6
		or	word ptr [si+45h], 2 ; current >= initial HP ->	disable	actions	6,7 (healing)

loc_10AB6:				; CODE XREF: ApplyDamage_One+CCj
		mov	dx, 100
		mul	dx
		div	bx
		cmp	ax, 20
		jnb	short loc_10AC6
		or	word ptr [si+45h], 1 ; current < (initial HP * 20%) -> disable actions 3,4,8,9 (ATK/DEF	modifications)

loc_10AC6:				; CODE XREF: ApplyDamage_One+DCj
		and	word ptr [si+45h], not 0Ch
		mov	ax, [si+21h]
		or	ax, ax
		jnz	short loc_10AD5
		or	word ptr [si+45h], 4 ; attack == 0 -> disable action 3 (lower attack)

loc_10AD5:				; CODE XREF: ApplyDamage_One+EBj
		cmp	ax, 100
		jb	short loc_10ADE
		or	word ptr [si+45h], 8 ; attack >= 100 ->	disable	action 8 (increase attack)

loc_10ADE:				; CODE XREF: ApplyDamage_One+F4j
		and	word ptr [si+45h], not 30h
		mov	ax, [si+27h]
		or	ax, ax
		jnz	short loc_10AED
		or	word ptr [si+45h], 10h ; defense == 0 -> disable action	4 (lower defense)

loc_10AED:				; CODE XREF: ApplyDamage_One+103j
		cmp	ax, 100
		jb	short loc_10AF6
		or	word ptr [si+45h], 20h ; defense >= 100	-> disable action 9 (increase defense)

loc_10AF6:				; CODE XREF: ApplyDamage_One+10Cj
		pop	dx
		pop	bx
		pop	ax
		retn
ApplyDamage_One	endp


; =============== S U B	R O U T	I N E =======================================


ShowSomeActImg	proc near		; CODE XREF: DoAction+22p
		push	ax
		push	bx
		test	byte ptr [di+1Ah], 8
		jnz	short loc_10B27
		test	byte ptr [di+4Fh], 1
		jz	short loc_10B27
		cmp	word ptr [di+49h], 0
		jz	short loc_10B27
		mov	bx, offset byte_14D1E
		test	byte ptr [di+1Ah], 1
		jnz	short loc_10B1A
		mov	bx, offset byte_14D33

loc_10B1A:				; CODE XREF: ShowSomeActImg+1Bj
		add	bx, PlrActionID
		mov	al, [bx]
		cmp	al, 0FFh
		jz	short loc_10B27
		call	DrawActionImage

loc_10B27:				; CODE XREF: ShowSomeActImg+6j
					; ShowSomeActImg+Cj ...
		pop	bx
		pop	ax
		retn
ShowSomeActImg	endp


; =============== S U B	R O U T	I N E =======================================


ShowMaxPlsFlashImg proc	near		; CODE XREF: DoAction+25p
		push	ax
		cmp	PlrActionID, 0Dh
		jnz	short loc_10B51
		test	byte ptr [di+1Ah], 8
		jnz	short loc_10B51
		test	byte ptr [di+4Fh], 1
		jz	short loc_10B51
		cmp	word ptr [di+49h], 0
		jz	short loc_10B51
		test	word ptr [di+45h], 100h
		jz	short loc_10B51
		mov	ax, 10h		; image	ID for "maximum	charged	Plasma Flash"
		call	DrawActionImage

loc_10B51:				; CODE XREF: ShowMaxPlsFlashImg+6j
					; ShowMaxPlsFlashImg+Cj ...
		pop	ax
		retn
ShowMaxPlsFlashImg endp


; =============== S U B	R O U T	I N E =======================================


sub_10B53	proc near		; CODE XREF: DoAction+2Bp
					; DoDgkShuriken+33p ...
		push	ax
		push	bx
		test	byte ptr [di+1Ah], 8
		jnz	short loc_10B7C
		test	byte ptr [di+4Fh], 1
		jz	short loc_10B7C
		cmp	word ptr [di+49h], 8000h
		jz	short loc_10B7C
		cmp	word ptr [di+49h], 0
		jz	short loc_10B7C
		test	byte ptr [di+1Ah], 1
		jz	short loc_10B79
		call	sub_1323E
		jmp	short loc_10B7C
; ---------------------------------------------------------------------------

loc_10B79:				; CODE XREF: sub_10B53+1Fj
		call	sub_132A7

loc_10B7C:				; CODE XREF: sub_10B53+6j sub_10B53+Cj ...
		pop	bx
		pop	ax
		retn
sub_10B53	endp


; =============== S U B	R O U T	I N E =======================================


ShowActMessage_a proc near		; CODE XREF: DoAction+40p
		push	ax
		cmp	fightEnd, 0
		jnz	short loc_10B93
		call	sub_12EEB
		call	ClearMessageBox
		mov	ax, PlrActionID
		call	ShowActMessage

loc_10B93:				; CODE XREF: ShowActMessage_a+6j
		pop	ax
		retn
ShowActMessage_a endp


; =============== S U B	R O U T	I N E =======================================


RefreshStats	proc near		; CODE XREF: InitStatDisp+3Fp
					; DoAction+34p	...
		call	RefreshHPDisp
		call	RefreshAtkDisp
		call	RefreshDefDisp
		retn
RefreshStats	endp


; =============== S U B	R O U T	I N E =======================================


RefreshHPDisp	proc near		; CODE XREF: RefreshStatsp
		push	ax
		push	bx
		test	byte ptr [si+1Ah], 8
		jnz	short loc_10BBE
		mov	ax, [si+1Bh]
		cmp	ax, [si+1Fh]
		jz	short loc_10BBE
		mov	bl, [si+1Ah]
		and	bl, 4
		shr	bl, 2
		call	ClearStat_HP
		call	ShowStat_HP

loc_10BBE:				; CODE XREF: RefreshHPDisp+6j
					; RefreshHPDisp+Ej
		test	byte ptr [di+1Ah], 8
		jnz	short loc_10BDB
		mov	ax, [di+1Bh]
		cmp	ax, [di+1Fh]
		jz	short loc_10BDB
		mov	bl, [di+1Ah]
		and	bl, 4
		shr	bl, 2
		call	ClearStat_HP
		call	ShowStat_HP

loc_10BDB:				; CODE XREF: RefreshHPDisp+23j
					; RefreshHPDisp+2Bj
		pop	bx
		pop	ax
		retn
RefreshHPDisp	endp


; =============== S U B	R O U T	I N E =======================================


RefreshAtkDisp	proc near		; CODE XREF: RefreshStats+3p
		push	ax
		push	bx
		test	byte ptr [si+1Ah], 8
		jnz	short loc_10BFD
		mov	ax, [si+21h]
		cmp	ax, [si+25h]
		jz	short loc_10BFD
		mov	bl, [si+1Ah]
		and	bl, 4
		shr	bl, 2
		call	ClearStat_Atk
		call	ShowStat_Atk

loc_10BFD:				; CODE XREF: RefreshAtkDisp+6j
					; RefreshAtkDisp+Ej
		test	byte ptr [di+1Ah], 8
		jnz	short loc_10C1A
		mov	ax, [di+21h]
		cmp	ax, [di+25h]
		jz	short loc_10C1A
		mov	bl, [di+1Ah]
		and	bl, 4
		shr	bl, 2
		call	ClearStat_Atk
		call	ShowStat_Atk

loc_10C1A:				; CODE XREF: RefreshAtkDisp+23j
					; RefreshAtkDisp+2Bj
		pop	bx
		pop	ax
		retn
RefreshAtkDisp	endp


; =============== S U B	R O U T	I N E =======================================


RefreshDefDisp	proc near		; CODE XREF: RefreshStats+6p
		push	ax
		push	bx
		test	byte ptr [si+1Ah], 8
		jnz	short loc_10C3C
		mov	ax, [si+27h]
		cmp	ax, [si+2Bh]
		jz	short loc_10C3C
		mov	bl, [si+1Ah]
		and	bl, 4
		shr	bl, 2
		call	ClearStat_Def
		call	ShowStat_Def

loc_10C3C:				; CODE XREF: RefreshDefDisp+6j
					; RefreshDefDisp+Ej
		test	byte ptr [di+1Ah], 8
		jnz	short loc_10C59
		mov	ax, [di+27h]
		cmp	ax, [di+2Bh]
		jz	short loc_10C59
		mov	bl, [di+1Ah]
		and	bl, 4
		shr	bl, 2
		call	ClearStat_Def
		call	ShowStat_Def

loc_10C59:				; CODE XREF: RefreshDefDisp+23j
					; RefreshDefDisp+2Bj
		pop	bx
		pop	ax
		retn
RefreshDefDisp	endp


; =============== S U B	R O U T	I N E =======================================


ShowPlasmaCharge proc near		; CODE XREF: DoAction+31p
		pusha
		test	byte ptr [si+1Ah], 1
		jnz	short loc_10C65
		mov	si, di

loc_10C65:				; CODE XREF: ShowPlasmaCharge+5j
		xor	ch, ch
		mov	cl, [si+44h]
		mov	bx, cx
		mov	di, cx
		add	di, 2
		shr	di, 2
		add	di, 731Bh
		sub	cl, 2
		and	cl, 3
		shl	cl, 1
		mov	ch, cl
		xor	ah, ah
		mov	al, [si+43h]
		sub	ax, bx
		jz	short loc_10C97
		jb	short loc_10C92
		call	sub_10C99
		jmp	short loc_10C97
; ---------------------------------------------------------------------------

loc_10C92:				; CODE XREF: ShowPlasmaCharge+2Fj
		neg	ax
		call	sub_10CB9

loc_10C97:				; CODE XREF: ShowPlasmaCharge+2Dj
					; ShowPlasmaCharge+34j
		popa
		retn
ShowPlasmaCharge endp


; =============== S U B	R O U T	I N E =======================================


sub_10C99	proc near		; CODE XREF: ShowPlasmaCharge+31p
		pusha
		mov	bx, 10h
		mov	dx, 2
		mov	cl, 4

loc_10CA2:				; CODE XREF: sub_10C99+1Cj
		call	WaitForVInt
		call	sub_14947
		add	ch, 2
		cmp	ch, 8
		jb	short loc_10CB4
		and	ch, 7
		inc	di

loc_10CB4:				; CODE XREF: sub_10C99+15j
		dec	ax
		jnz	short loc_10CA2
		popa
		retn
sub_10C99	endp


; =============== S U B	R O U T	I N E =======================================


sub_10CB9	proc near		; CODE XREF: ShowPlasmaCharge+38p
		pusha
		mov	bx, 10h
		mov	dx, 4
		mov	cl, 8
		mov	bp, ax
		and	bp, 1
		shr	ax, 1
		jz	short loc_10CDD

loc_10CCB:				; CODE XREF: sub_10CB9+22j
		sub	ch, 4
		jnb	short loc_10CD4
		and	ch, 7
		dec	di

loc_10CD4:				; CODE XREF: sub_10CB9+15j
		call	WaitForVInt
		call	sub_14947
		dec	ax
		jnz	short loc_10CCB

loc_10CDD:				; CODE XREF: sub_10CB9+10j
		or	bp, bp
		jz	short loc_10CF3
		mov	dx, 2
		sub	ch, 2
		jnb	short loc_10CED
		and	ch, 7
		dec	di

loc_10CED:				; CODE XREF: sub_10CB9+2Ej
		call	WaitForVInt
		call	sub_14947

loc_10CF3:				; CODE XREF: sub_10CB9+26j
		popa
		retn
sub_10CB9	endp


; =============== S U B	R O U T	I N E =======================================


ShowChargedFX	proc near		; CODE XREF: DoAction+2Ep
		push	ax
		push	bx
		push	si
		mov	si, offset PlayerMem
		test	byte ptr [si+1Ah], 1
		jnz	short loc_10D0A
		mov	si, offset EnemyMem
		test	byte ptr [si+1Ah], 1
		jz	short loc_10D28

loc_10D0A:				; CODE XREF: ShowChargedFX+Aj
		cmp	byte ptr [si+43h], 50
		jb	short loc_10D1A
		cmp	byte ptr [si+44h], 50
		jnb	short loc_10D28
		xor	al, al
		jmp	short loc_10D22
; ---------------------------------------------------------------------------

loc_10D1A:				; CODE XREF: ShowChargedFX+19j
		cmp	byte ptr [si+44h], 50
		jb	short loc_10D28
		mov	al, 1

loc_10D22:				; CODE XREF: ShowChargedFX+23j
		call	sub_118CA
		call	sub_118E6

loc_10D28:				; CODE XREF: ShowChargedFX+13j
					; ShowChargedFX+1Fj ...
		pop	si
		pop	bx
		pop	ax
		retn
ShowChargedFX	endp


; =============== S U B	R O U T	I N E =======================================


sub_10D2C	proc near		; CODE XREF: DoAction+46p
		push	ax
		mov	ax, PlrActionType
		cmp	ax, 0FFFFh
		jz	short loc_10D38
		call	sub_131A1

loc_10D38:				; CODE XREF: sub_10D2C+7j
		pop	ax
		retn
sub_10D2C	endp


; =============== S U B	R O U T	I N E =======================================


DoElectrBreak	proc near		; CODE XREF: DoAction+49p
		push	si
		test	byte ptr [si+1Ah], 8
		jz	short loc_10D47
		cmp	word ptr [si+1Bh], 0
		jz	short loc_10D53

loc_10D47:				; CODE XREF: DoElectrBreak+5j
		test	byte ptr [di+1Ah], 8
		jz	short loc_10D71
		cmp	word ptr [di+1Bh], 0
		jnz	short loc_10D71

loc_10D53:				; CODE XREF: DoElectrBreak+Bj
		mov	si, offset PlayerMem
		test	word ptr [si+45h], 200h
		jnz	short loc_10D67
		mov	si, offset EnemyMem
		test	word ptr [si+45h], 200h
		jz	short loc_10D71

loc_10D67:				; CODE XREF: DoElectrBreak+21j
		and	word ptr [si+45h], not 200h ; remove "Electrode	#2 in use" flag
		or	word ptr [si+45h], 4000h ; set "Electrode #2 unuseable"	flag

loc_10D71:				; CODE XREF: DoElectrBreak+11j
					; DoElectrBreak+17j ...
		pop	si
		retn
DoElectrBreak	endp


; =============== S U B	R O U T	I N E =======================================


ShowActResult_A	proc near		; CODE XREF: DoAction+4Fp
					; DoDgkShuriken+15p ...
		push	ax
		call	ClearMessageBox
		mov	ax, PlrActionID
		call	ShowActResult
		pop	ax
		retn
ShowActResult_A	endp


; =============== S U B	R O U T	I N E =======================================


CheckElctBreak	proc near		; CODE XREF: DoAction+52p
		push	ax
		test	byte ptr [si+1Ah], 8
		jz	short loc_10D8C
		cmp	word ptr [si+1Bh], 0
		jz	short loc_10D98

loc_10D8C:				; CODE XREF: CheckElctBreak+5j
		test	byte ptr [di+1Ah], 8
		jz	short loc_10DA9
		cmp	word ptr [di+1Bh], 0
		jnz	short loc_10DA9

loc_10D98:				; CODE XREF: CheckElctBreak+Bj
		call	ClearMessageBox
		mov	ax, 25h
		call	ShowMessageText	; Electrode 2 makes a sad, deflating sound.
		xor	al, al
		call	DrawActionImage
		call	sub_12EEB

loc_10DA9:				; CODE XREF: CheckElctBreak+11j
					; CheckElctBreak+17j
		pop	ax
		retn
CheckElctBreak	endp


; =============== S U B	R O U T	I N E =======================================


sub_10DAB	proc near		; CODE XREF: DoAction+55p
		push	ax
		push	bx
		test	word ptr [di+45h], 100h
		jz	short loc_10DD9
		test	byte ptr [di+1Ah], 8
		jnz	short loc_10DD9
		call	ClearMessageBox
		test	byte ptr [di+1Ah], 1
		jz	short loc_10DCB
		mov	ax, 0Fh
		call	ShowChat1Text
		jmp	short loc_10DD6
; ---------------------------------------------------------------------------

loc_10DCB:				; CODE XREF: sub_10DAB+16j
		mov	ax, 6
		xor	bh, bh
		mov	bl, [di+19h]
		call	ShowChat2Text

loc_10DD6:				; CODE XREF: sub_10DAB+1Ej
		call	sub_12EEB

loc_10DD9:				; CODE XREF: sub_10DAB+7j sub_10DAB+Dj
		pop	bx
		pop	ax
		retn
sub_10DAB	endp


; =============== S U B	R O U T	I N E =======================================


CheckZeroHP	proc near		; CODE XREF: DoAction+3Dp
		push	ax
		push	si
		push	di
		mov	si, offset PlayerMem
		mov	di, offset EnemyMem
		mov	al, 2		; enemy	wins
		cmp	word ptr [si+1Bh], 0
		jz	short loc_10DF7	; player defeated - jump
		mov	al, 1		; Dengeki Nurse	(player) wins
		cmp	word ptr [di+1Bh], 0
		jz	short loc_10DF7	; enemy	defeated - jump
		xor	al, al		; nobody has won yet

loc_10DF7:				; CODE XREF: CheckZeroHP+Fj
					; CheckZeroHP+17j
		mov	fightEnd, al
		pop	di
		pop	si
		pop	ax
		retn
CheckZeroHP	endp


; =============== S U B	R O U T	I N E =======================================


ShowFightEndImg	proc near		; CODE XREF: DoAction+4Cp
		cmp	fightEnd, 0
		jz	short locret_10E08
		call	sub_12EEB

locret_10E08:				; CODE XREF: ShowFightEndImg+5j
		retn
ShowFightEndImg	endp


; =============== S U B	R O U T	I N E =======================================


DoFightEnd	proc near		; CODE XREF: DoFightTurn:loc_1064Dp
		push	ax
		push	bx
		push	si
		push	di
		mov	si, offset PlayerMem
		mov	di, offset EnemyMem
		cmp	fightEnd, 1
		jz	short loc_10E1C
		xchg	si, di

loc_10E1C:				; CODE XREF: DoFightEnd+Fj
		call	SetSavedTxtPtrs
		test	byte ptr [si+1Ah], 1
		jz	short loc_10E3D
		mov	al, 0Eh
		call	DrawActionImage
		call	ClearMessageBox
		mov	bl, 11h
		call	APICall_ShowImg
		mov	ax, 0Ah
		call	ShowMessageText	; Dengeki Nurse	defeated [enemy]!
		call	sub_12EEB
		jmp	short loc_10E51
; ---------------------------------------------------------------------------

loc_10E3D:				; CODE XREF: DoFightEnd+1Aj
		call	ClearMessageBox
		mov	bl, 12h
		call	APICall_ShowImg
		call	sub_1339B
		mov	ax, 0Bh
		call	ShowMessageText	; Dengeki Nurse	has been defeated.
		call	sub_12EEB

loc_10E51:				; CODE XREF: DoFightEnd+32j
		pop	di
		pop	si
		pop	bx
		pop	ax
		retn
DoFightEnd	endp


; =============== S U B	R O U T	I N E =======================================


CheckFightEnd	proc near		; CODE XREF: DoMainLoop+Ep
		cmp	fightEnd, 0
		retn
CheckFightEnd	endp


; =============== S U B	R O U T	I N E =======================================


j_PlayerActSel	proc near		; CODE XREF: ChooseAction+Dp
		call	DoPlayerActionSel
		retn
j_PlayerActSel	endp


; =============== S U B	R O U T	I N E =======================================


DoPlayerActionSel proc near		; CODE XREF: j_PlayerActSelp
		call	GenPlayerMoves	; generate player move set

loc_10E63:				; CODE XREF: DoPlayerActionSel+59j
		call	ClearMessageBox
		call	ShowSelectMsg
		call	ScrSelect_Action ; select action type [Attack, Drug, Power]
		mov	bx, ax
		cmp	skipActions, 0
		jnz	short loc_10EBB
		or	ax, ax
		jnz	short loc_10E8B
		call	PlrAct_EltdRecall ; action type	0 - attack
		jb	short loc_10EB4
		call	ClearMessageBox
		call	ShowAttackList	; return AX = action to	use
		call	PlrAct_PlasmaFlash
		jb	short loc_10EB4
		jmp	short loc_10EAF
; ---------------------------------------------------------------------------

loc_10E8B:				; CODE XREF: DoPlayerActionSel+17j
		cmp	ax, 1
		jnz	short loc_10EA2
		call	CanUseDrugs	; action type 1	- drug
		jb	short loc_10EB4
		call	ClearMessageBox
		call	ShowDrugList	; return AX = action to	use
		call	PlrAct_Electrd
		jb	short loc_10EB4
		jmp	short loc_10EAF
; ---------------------------------------------------------------------------

loc_10EA2:				; CODE XREF: DoPlayerActionSel+2Ej
		mov	ax, 0Fh		; action type 2	- power	(Plasma	Charge)
		call	CanUseCharge
		jb	short loc_10EB4
		call	CheckChargeMax
		jb	short loc_10EB4

loc_10EAF:				; CODE XREF: DoPlayerActionSel+29j
					; DoPlayerActionSel+40j
		cmp	ax, 0FFFFh
		jnz	short loc_10EBB

loc_10EB4:				; CODE XREF: DoPlayerActionSel+1Cj
					; DoPlayerActionSel+27j ...
		mov	ax, bx
		call	sub_131A1
		jmp	short loc_10E63
; ---------------------------------------------------------------------------

loc_10EBB:				; CODE XREF: DoPlayerActionSel+13j
					; DoPlayerActionSel+52j
		call	ClearMessageBox
		retn
DoPlayerActionSel endp


; =============== S U B	R O U T	I N E =======================================


GenPlayerMoves	proc near		; CODE XREF: DoPlayerActionSelp
		push	ax
		push	bx
		push	cx
		push	si
		push	ds
		mov	si, seg	seg001
		mov	ds, si
		mov	si, offset AttackProb_Weak
		mov	cx, 2
		call	GetRandomSelect
		add	ax, 10h
		mov	PlrAtkID_Weak, ax ; one	of [Dengeki Punch (70%), Scalpel Shuriken (30%)]
		mov	si, offset AttackProb_Strong
		mov	cx, 3
		call	GetRandomSelect
		add	ax, 12h
		mov	PlrAtkID_Strong, ax ; one of [Dengeki Kick (50%), Dengeki Laser	Scalpel	(30%), Dengeki Bazooka (20%)]
		mov	PlrAtkID_PFlash, 0Dh ; always Plasma Flash
		mov	si, offset DrugProb
		mov	cx, 7
		call	GetRandomSelect
		cmp	ax, 7
		jnz	short loc_10EFE
		mov	ax, 0Bh		; Electrode #2 (remaining 5%)

loc_10EFE:				; CODE XREF: GenPlayerMoves+3Aj
		add	ax, 3
		mov	PlrAtkID_Drug1,	ax

loc_10F04:				; CODE XREF: GenPlayerMoves+5Dj
					; GenPlayerMoves+8Aj
		mov	si, offset DrugProb
		mov	cx, 7
		call	GetRandomSelect
		cmp	ax, 7
		jnz	short loc_10F15
		mov	ax, 0Bh		; Electrode #2 (remaining 5%)

loc_10F15:				; CODE XREF: GenPlayerMoves+51j
		add	ax, 3
		cmp	ax, PlrAtkID_Drug1
		jz	short loc_10F04
		mov	PlrAtkID_Drug2,	ax
		mov	PlrAtkID_Drug3,	0Eh ; Electrode	#2
		mov	ax, PlrAtkID_Drug1
		mov	bx, PlrAtkID_Drug2
		cmp	ax, 7
		jz	short loc_10F38
		cmp	bx, 7
		jnz	short loc_10F4B

loc_10F38:				; CODE XREF: GenPlayerMoves+72j
		cmp	ax, 6
		jnz	short loc_10F41
		mov	ax, bx
		jmp	short loc_10F46
; ---------------------------------------------------------------------------

loc_10F41:				; CODE XREF: GenPlayerMoves+7Cj
		cmp	bx, 6
		jnz	short loc_10F4B

loc_10F46:				; CODE XREF: GenPlayerMoves+80j
		mov	PlrAtkID_Drug1,	ax
		jmp	short loc_10F04
; ---------------------------------------------------------------------------

loc_10F4B:				; CODE XREF: GenPlayerMoves+77j
					; GenPlayerMoves+85j
		mov	ax, PlrAtkID_Drug1
		mov	bx, PlrAtkID_Drug2
		mov	cx, PlrAtkID_Drug3

loc_10F56:				; CODE XREF: GenPlayerMoves+A2j
		cmp	ax, bx
		jb	short loc_10F5B
		xchg	ax, bx

loc_10F5B:				; CODE XREF: GenPlayerMoves+99j
		cmp	bx, cx
		jb	short loc_10F63
		xchg	bx, cx
		jmp	short loc_10F56
; ---------------------------------------------------------------------------

loc_10F63:				; CODE XREF: GenPlayerMoves+9Ej
		mov	PlrAtkID_Drug1,	ax
		mov	PlrAtkID_Drug2,	bx
		mov	PlrAtkID_Drug3,	cx
		pop	ds
		assume ds:nothing
		pop	si
		pop	cx
		pop	bx
		pop	ax
		retn
GenPlayerMoves	endp


; =============== S U B	R O U T	I N E =======================================


ScrSelect_Action proc near		; CODE XREF: DoPlayerActionSel+9p
		push	si
		push	ds
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		mov	si, offset unk_18697
		mov	byte ptr [si], 0
		mov	word ptr [si+1], offset	ScrRect_ActType
		mov	[si+3],	ax
		call	WaitForClick
		mov	byte ptr [si], 1
		mov	word ptr [si+1], 0
		mov	word ptr [si+3], 0

loc_10F99:				; CODE XREF: ScrSelect_Action+3Dj
		call	WaitForClick
		mov	word ptr [si+1], 1
		mov	ax, [si+5]
		cmp	ax, 0FFFFh
		jnz	short loc_10FB3
		call	CheckCheatCode
		cmp	skipActions, 0
		jz	short loc_10F99

loc_10FB3:				; CODE XREF: ScrSelect_Action+33j
		pop	ds
		assume ds:nothing
		pop	si
		retn
ScrSelect_Action endp


; =============== S U B	R O U T	I N E =======================================


CheckCheatCode	proc near		; CODE XREF: ScrSelect_Action+35p
		pusha
		push	ds
		push	es
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		call	Mouse_GetPos
		or	bx, bx
		jz	short loc_11022	; no button pressed - return
		mov	si, cheatCodeCntr
		shl	si, 1
		add	si, offset cheatRgnOrder
		mov	si, [si]
		shl	si, 3
		add	si, offset cheatRegions
		cmp	cx, [si]	; check	X limit	(left)
		jb	short loc_11002
		cmp	cx, [si+2]	; check	X limit	(right)
		ja	short loc_11002
		cmp	dx, [si+4]	; check	Y limit	(top)
		jb	short loc_11002
		cmp	dx, [si+6]	; check	Y limit	(bottom)
		ja	short loc_11002
		inc	cheatCodeCntr
		cmp	cheatCodeCntr, 8
		jbe	short loc_11022
		mov	skipActions, 1
		mov	fightEnd, 1
		jmp	short loc_11022
; ---------------------------------------------------------------------------

loc_11002:				; CODE XREF: CheckCheatCode+24j
					; CheckCheatCode+29j ...
		mov	cheatCodeCntr, 0
		mov	si, offset cheatRegions
		cmp	cx, [si]
		jb	short loc_11022
		cmp	cx, [si+2]
		ja	short loc_11022
		cmp	dx, [si+4]
		jb	short loc_11022
		cmp	dx, [si+6]
		ja	short loc_11022
		inc	cheatCodeCntr

loc_11022:				; CODE XREF: CheckCheatCode+Dj
					; CheckCheatCode+3Ej ...
		pop	es
		pop	ds
		assume ds:nothing
		popa
		retn
CheckCheatCode	endp


; =============== S U B	R O U T	I N E =======================================


ShowAttackList	proc near		; CODE XREF: DoPlayerActionSel+21p
		push	bx
		push	si
		push	ds
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		xor	bx, bx
		mov	ax, PlrAtkID_Weak
		call	ShowActionText
		inc	bx
		mov	ax, PlrAtkID_Strong
		call	ShowActionText
		inc	bx
		mov	ax, PlrAtkID_PFlash
		call	ShowActionText
		mov	ax, seg	seg001
		mov	si, offset unk_18697
		mov	byte ptr [si], 0
		mov	word ptr [si+1], offset	ScrRect_AtkDrug
		mov	[si+3],	ax
		call	WaitForClick
		mov	byte ptr [si], 1
		mov	word ptr [si+1], 0
		mov	word ptr [si+3], 0
		call	WaitForClick
		mov	ax, [si+5]
		cmp	ax, 0FFFFh
		jz	short loc_1107A
		mov	si, ax
		shl	si, 1
		add	si, offset PlrAtkID_Weak
		mov	ax, [si]

loc_1107A:				; CODE XREF: ShowAttackList+48j
		pop	ds
		assume ds:nothing
		pop	si
		pop	bx
		retn
ShowAttackList	endp


; =============== S U B	R O U T	I N E =======================================


ShowDrugList	proc near		; CODE XREF: DoPlayerActionSel+38p
		push	bx
		push	si
		push	ds
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		xor	bx, bx
		mov	ax, PlrAtkID_Drug1
		call	ShowActionText
		inc	bx
		mov	ax, PlrAtkID_Drug2
		call	ShowActionText
		inc	bx
		mov	ax, PlrAtkID_Drug3
		call	ShowActionText
		mov	ax, seg	seg001
		mov	si, offset unk_18697
		mov	byte ptr [si], 0
		mov	word ptr [si+1], offset	ScrRect_AtkDrug
		mov	[si+3],	ax
		call	WaitForClick
		mov	byte ptr [si], 1
		mov	word ptr [si+1], 0
		mov	word ptr [si+3], 0
		call	WaitForClick
		mov	ax, [si+5]
		cmp	ax, 0FFFFh
		jz	short loc_110D2
		mov	si, ax
		shl	si, 1
		add	si, offset PlrAtkID_Drug1
		mov	ax, [si]

loc_110D2:				; CODE XREF: ShowDrugList+48j
		pop	ds
		assume ds:nothing
		pop	si
		pop	bx
		retn
ShowDrugList	endp


; =============== S U B	R O U T	I N E =======================================


PlrAct_Electrd	proc near		; CODE XREF: DoPlayerActionSel+3Bp
		push	ax
		cmp	ax, 0Eh
		jnz	short loc_110F2	; not using Electrode #2 - return
		test	word ptr [si+45h], 4000h
		jz	short loc_110F2
		call	ClearMessageBox
		mov	ax, 33h
		call	ShowMessageText	; Electrode 2: I'm sorry, Kirara, I can't fight no more...
		call	sub_12EEB
		stc
		jmp	short loc_110F3
; ---------------------------------------------------------------------------

loc_110F2:				; CODE XREF: PlrAct_Electrd+4j
					; PlrAct_Electrd+Bj
		clc

loc_110F3:				; CODE XREF: PlrAct_Electrd+1Aj
		pop	ax
		retn
PlrAct_Electrd	endp


; =============== S U B	R O U T	I N E =======================================


PlrAct_EltdRecall proc near		; CODE XREF: DoPlayerActionSel+19p
		push	ax
		push	bx
		push	si
		push	bp
		push	ds
		mov	bp, si
		test	word ptr [si+45h], 200h
		jz	short loc_11156
		call	ClearMessageBox
		mov	ax, 8
		call	ShowMessageText	; Electrode #2 is in use. Do you want it recalled?
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		mov	si, offset unk_18697
		mov	byte ptr [si], 0
		mov	word ptr [si+1], offset	ScrRect_YesNo
		mov	[si+3],	ax
		call	WaitForClick
		mov	byte ptr [si], 1
		mov	word ptr [si+1], 0
		mov	word ptr [si+3], 0
		call	WaitForClick
		mov	ax, [si+5]
		cmp	ax, 0
		jnz	short loc_11155
		mov	si, bp
		and	word ptr [si+45h], not 200h
		call	ClearMessageBox
		mov	ax, 9
		call	ShowMessageText	; Dengeki Nurse	has recalled Electrode 2.
		call	sub_12EEB
		xor	al, al
		call	DrawActionImage
		clc
		jmp	short loc_11156
; ---------------------------------------------------------------------------

loc_11155:				; CODE XREF: PlrAct_EltdRecall+43j
		stc

loc_11156:				; CODE XREF: PlrAct_EltdRecall+Cj
					; PlrAct_EltdRecall+5Ej
		pop	ds
		assume ds:nothing
		pop	bp
		pop	si
		pop	bx
		pop	ax
		retn
PlrAct_EltdRecall endp


; =============== S U B	R O U T	I N E =======================================


CanUseDrugs	proc near		; CODE XREF: DoPlayerActionSel+30p
		push	ax
		push	bx
		push	si
		push	bp
		push	ds
		mov	bp, si
		test	word ptr [si+45h], 800h
		jz	short loc_11178
		call	ClearMessageBox
		mov	ax, 6
		call	ShowMessageText	; The drug has become a	sticky mess!
		call	sub_12EEB
		jmp	short loc_111D1
; ---------------------------------------------------------------------------

loc_11178:				; CODE XREF: CanUseDrugs+Cj
		test	word ptr [si+45h], 200h
		jz	short loc_111D2
		call	ClearMessageBox
		mov	ax, 8
		call	ShowMessageText	; Electrode #2 is in use. Do you want it recalled?
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		mov	si, offset unk_18697
		mov	byte ptr [si], 0
		mov	word ptr [si+1], offset	ScrRect_YesNo
		mov	[si+3],	ax
		call	WaitForClick
		mov	byte ptr [si], 1
		mov	word ptr [si+1], 0
		mov	word ptr [si+3], 0
		call	WaitForClick
		mov	ax, [si+5]
		cmp	ax, 0
		jnz	short loc_111D1
		mov	si, bp
		and	word ptr [si+45h], not 200h
		call	ClearMessageBox
		mov	ax, 9
		call	ShowMessageText	; Dengeki Nurse	has recalled Electrode 2.
		call	sub_12EEB
		xor	al, al
		call	DrawActionImage
		clc
		jmp	short loc_111D2
; ---------------------------------------------------------------------------

loc_111D1:				; CODE XREF: CanUseDrugs+1Aj
					; CanUseDrugs+58j
		stc

loc_111D2:				; CODE XREF: CanUseDrugs+21j
					; CanUseDrugs+73j
		pop	ds
		pop	bp
		pop	si
		pop	bx
		pop	ax
		retn
CanUseDrugs	endp


; =============== S U B	R O U T	I N E =======================================


CanUseCharge	proc near		; CODE XREF: DoPlayerActionSel+45p
		push	ax
		test	word ptr [si+45h], 1000h
		jz	short loc_111ED
		call	ClearMessageBox
		mov	ax, 7
		call	ShowMessageText	; [Dengeki Nurse] can't concentrate!
		call	sub_12EEB
		stc

loc_111ED:				; CODE XREF: CanUseCharge+6j
		pop	ax
		retn
CanUseCharge	endp


; =============== S U B	R O U T	I N E =======================================


CheckChargeMax	proc near		; CODE XREF: DoPlayerActionSel+4Ap
		push	ax
		cmp	byte ptr [si+43h], 100
		jb	short loc_11205
		call	ClearMessageBox
		mov	ax, 32h
		call	ShowMessageText	; Your Plasma Power is at max!
		call	sub_12EEB
		stc
		jmp	short loc_11206
; ---------------------------------------------------------------------------

loc_11205:				; CODE XREF: CheckChargeMax+5j
		clc

loc_11206:				; CODE XREF: CheckChargeMax+14j
		pop	ax
		retn
CheckChargeMax	endp


; =============== S U B	R O U T	I N E =======================================


PlrAct_PlasmaFlash proc	near		; CODE XREF: DoPlayerActionSel+24p
		push	ax
		cmp	ax, 0Dh
		jnz	short loc_1122A	; not using Plasma Flash - return
		cmp	byte ptr [si+43h], 50
		jb	short loc_1121B
		test	word ptr [si+45h], 2000h
		jz	short loc_1122A

loc_1121B:				; CODE XREF: PlrAct_PlasmaFlash+Aj
		call	ClearMessageBox
		mov	ax, 31h
		call	ShowMessageText	; You need at least 50%	power to use Plasma Flash!
		call	sub_12EEB
		stc
		jmp	short loc_1122B
; ---------------------------------------------------------------------------

loc_1122A:				; CODE XREF: PlrAct_PlasmaFlash+4j
					; PlrAct_PlasmaFlash+11j
		clc

loc_1122B:				; CODE XREF: PlrAct_PlasmaFlash+20j
		pop	ax
		retn
PlrAct_PlasmaFlash endp


; =============== S U B	R O U T	I N E =======================================


ChooseEnemyAct	proc near		; CODE XREF: ChooseAction:loc_10815p
		push	cx
		push	si
		push	di
		push	ds
		push	es
		mov	ax, si
		mov	bx, di
		mov	di, offset EnemyActProbs
		add	si, 33h		; attack probablility list: enemey RAM+33h
		mov	cx, 10h
		cld
		rep movsb		; copy 16 attack ID slots to temporary storage
		mov	di, bx
		mov	si, ax
		call	FilterEnemyActProbs
		mov	si, seg	seg001
		mov	ds, si
		mov	si, offset EnemyActProbs
		mov	cx, 10h
		call	GetRandomSelect
		call	SelectEnemyAct
		mov	bx, 0FFFFh
		pop	es
		pop	ds
		pop	di
		pop	si
		pop	cx
		retn
ChooseEnemyAct	endp


; =============== S U B	R O U T	I N E =======================================


FilterEnemyActProbs proc near		; CODE XREF: ChooseEnemyAct+19p
		push	ax
		push	bx
		xor	al, al
		mov	bx, offset EnemyActProbs
		test	word ptr [si+45h], 2
		jz	short loc_11277
		mov	[bx+6],	al	; status flags bit 1 set - disable actions 6, 7
		mov	[bx+7],	al	; by setting their probability to 0

loc_11277:				; CODE XREF: FilterEnemyActProbs+Cj
		test	word ptr [si+45h], 1
		jz	short loc_1128A
		mov	[bx+8],	al
		mov	[bx+9],	al
		mov	[bx+3],	al
		mov	[bx+4],	al

loc_1128A:				; CODE XREF: FilterEnemyActProbs+19j
		test	word ptr [si+45h], 8
		jz	short loc_11294
		mov	[bx+8],	al

loc_11294:				; CODE XREF: FilterEnemyActProbs+2Cj
		test	word ptr [si+45h], 20h
		jz	short loc_1129E
		mov	[bx+9],	al

loc_1129E:				; CODE XREF: FilterEnemyActProbs+36j
		test	word ptr [di+45h], 4
		jz	short loc_112A8
		mov	[bx+3],	al

loc_112A8:				; CODE XREF: FilterEnemyActProbs+40j
		test	word ptr [di+45h], 10h
		jz	short loc_112B2
		mov	[bx+4],	al

loc_112B2:				; CODE XREF: FilterEnemyActProbs+4Aj
		test	word ptr [di+45h], 400h
		jz	short loc_112BC
		mov	[bx+5],	al

loc_112BC:				; CODE XREF: FilterEnemyActProbs+54j
		pop	bx
		pop	ax
		retn
FilterEnemyActProbs endp

; Parameters:
;  SI -	pointer	to probabilities (of 100)
;  CX -	number of probabilities
; Returns:
;  AX -	random index out of (0..CX-1) with probabilities from SI

; =============== S U B	R O U T	I N E =======================================


GetRandomSelect	proc near		; CODE XREF: GenPlayerMoves+10p
					; GenPlayerMoves+1Fp ...
		push	bx
		push	dx

loc_112C1:				; CODE XREF: GetRandomSelect+17j
		mov	dx, 100
		call	Random_InRange
		xor	ah, ah
		xor	bx, bx

loc_112CB:				; CODE XREF: GetRandomSelect+15j
		add	ah, [bx+si]
		cmp	al, ah
		jb	short loc_112D8
		inc	bx
		cmp	bx, cx
		jb	short loc_112CB
		jmp	short loc_112C1
; ---------------------------------------------------------------------------

loc_112D8:				; CODE XREF: GetRandomSelect+10j
		mov	ax, bx
		pop	dx
		pop	bx
		retn
GetRandomSelect	endp


; =============== S U B	R O U T	I N E =======================================


SelectEnemyAct	proc near		; CODE XREF: ChooseEnemyAct+2Ap
		push	cx
		push	si
		push	ds
		cmp	ax, 0Bh
		jnz	short loc_112F6
		mov	si, seg	seg001	; Enemy	Action 0B - weak attack
		mov	ds, si
		mov	si, offset AttackProb_Weak
		mov	cx, 2
		call	GetRandomSelect
		add	ax, 10h

loc_112F6:				; CODE XREF: SelectEnemyAct+6j
		cmp	ax, 0Ch
		jnz	short loc_1130C
		mov	si, seg	seg001	; Enemy	Action 0B - strong attack
		mov	ds, si
		mov	si, offset AttackProb_Strong
		mov	cx, 3
		call	GetRandomSelect
		add	ax, 12h

loc_1130C:				; CODE XREF: SelectEnemyAct+1Cj
		pop	ds
		assume ds:nothing
		pop	si
		pop	cx
		retn
SelectEnemyAct	endp


; =============== S U B	R O U T	I N E =======================================


EnemySpcAct_Choose proc	near		; CODE XREF: ChooseAction+15p
		pusha
		cmp	ax, 0Ah
		jnz	short loc_1132F
		mov	bx, si		; Enemy	Action 0A - special attack
		mov	dx, ds
		mov	si, seg	seg001
		mov	ds, si
		assume ds:seg001
		mov	si, offset EnmSpcAtkProb
		mov	cx, 6
		call	GetRandomSelect
		mov	ds, dx
		assume ds:nothing
		mov	si, bx
		mov	[si+50h], al

loc_1132F:				; CODE XREF: EnemySpcAct_Choose+4j
		popa
		retn
EnemySpcAct_Choose endp


; =============== S U B	R O U T	I N E =======================================


EnemySpecialAct	proc near		; CODE XREF: ChooseAction+18p
		pusha
		cmp	ax, 0Ah		; Enemy	Action 0A - special attack
		jnz	short loc_1138D
		mov	al, [si+50h]	; check	sub-type
		cmp	al, 0
		jz	short loc_1138D	; sub-type 0 - works always
		cmp	al, 1
		jnz	short loc_11348	; sub-type 1 - "plot twist"
		test	byte ptr [di+1Ah], 8
		jnz	short loc_11389	; Electrode #2 active -	don't act

loc_11348:				; CODE XREF: EnemySpecialAct+Fj
		cmp	al, 2
		jnz	short loc_11353	; sub-type 2 - Vitamin N Super
		test	word ptr [si+45h], 2
		jnz	short loc_11389	; disable heal when the	enemy can't heal in general

loc_11353:				; CODE XREF: EnemySpecialAct+19j
		cmp	al, 3
		jnz	short loc_1136E	; sub-type 3 - Bacillus	50
		test	byte ptr [di+1Ah], 8
		jnz	short loc_11389	; Electrode #2 active -	don't act
		cmp	word ptr [di+1Bh], 30
		jbe	short loc_11389	; Dengeki Nurse	HP <= 30 -> don't allow transfer
		mov	bx, [si+1Dh]
		add	bx, 50
		cmp	[si+1Bh], bx
		jnb	short loc_11389	; don't act when (current HP) >= (max HP + 50) [yes, we can overshoot here]

loc_1136E:				; CODE XREF: EnemySpecialAct+24j
		cmp	al, 4
		jnz	short loc_1137F	; sub-type 4 - Mahiro Horumu
		test	byte ptr [di+1Ah], 8
		jnz	short loc_11389	; Electrode #2 active -	don't act
		test	word ptr [di+45h], 400h
		jnz	short loc_11389	; Dengeki Nurse	is always paralysed - don't add it on top

loc_1137F:				; CODE XREF: EnemySpecialAct+3Fj
		cmp	al, 5
		jnz	short loc_1138D	; sub-type 5 - powerful	EM wave
		cmp	byte ptr [di+43h], 30
		jnb	short loc_1138D	; don't do this when Dengeki Nurse's change level is < 30%

loc_11389:				; CODE XREF: EnemySpecialAct+15j
					; EnemySpecialAct+20j ...
		mov	byte ptr [si+50h], 6 ; set sub-type to "do nothing"

loc_1138D:				; CODE XREF: EnemySpecialAct+4j
					; EnemySpecialAct+Bj ...
		popa
		retn
EnemySpecialAct	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


CallJumpTbl	proc near		; CODE XREF: ExecAction+Ap
					; seg000:1589p	...
		push	ax
		push	bp
		xor	ah, ah
		shl	ax, 1
		add	bp, ax
		call	word ptr es:[bp+0]
		pop	bp
		pop	ax
		retn
CallJumpTbl	endp

; ---------------------------------------------------------------------------
		push	di
		mov	di, seg	seg001
		assume ds:seg001
		mov	ds, di
		mov	di, offset dword_14DAA
		lds	si, [di]
		pop	di
		retn
; ---------------------------------------------------------------------------
		push	di
		mov	di, seg	seg001
		mov	ds, di
		mov	di, offset dword_14DAE
		lds	si, [di]
		pop	di
		retn
; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


ExecAction	proc near		; CODE XREF: ExecAction_a+4p
		push	ax
		push	bp
		push	es
		mov	bp, cs
		mov	es, bp
		assume es:seg000
		mov	bp, offset jmpTblActExec
		call	CallJumpTbl
		pop	es
		assume es:nothing
		pop	bp
		pop	ax
		retn
ExecAction	endp

; ---------------------------------------------------------------------------
jmpTblActExec	dw offset actExec00_EnmNormal; 0 ; DATA	XREF: ExecAction+7o
		dw offset actExec01_EnmWeird; 1
		dw offset actExec02_EnmSpecific; 2
		dw offset actExec03_AtkReduce; 3
		dw offset actExec04_DefReduce; 4
		dw offset actExec05_Paralyze; 5
		dw offset actExec06_Heal; 6
		dw offset actExec07_FullHeal; 7
		dw offset actExec08_AtkIncrease; 8
		dw offset actExec09_DefIncrease; 9
		dw offset actExec0A_EnmSpecial;	0Ah
		dw offset actExec0D_PlasmaFlash; 0Bh
		dw offset actExec0D_PlasmaFlash; 0Ch
		dw offset actExec0D_PlasmaFlash; 0Dh
		dw offset actExec0E_Electrode; 0Eh
		dw offset actExec0F_PlasmaCharge; 0Fh
		dw offset actExec10_DgkPunch; 10h
		dw offset actExec11_DgkShuriken; 11h
		dw offset actExec12_DgkKick; 12h
		dw offset actExec13_DgkScalpel;	13h
		dw offset actExec14_DgkBazooka;	14h
; ---------------------------------------------------------------------------

actExec00_EnmNormal:			; DATA XREF: seg000:jmpTblActExeco
		push	ax
		push	dx
		test	byte ptr [di+1Ah], 8
		jnz	short loc_1140C
		test	word ptr [di+45h], 400h
		jnz	short loc_11413	; target is paralyzed -	attack always succeeds
		mov	ax, 70
		call	Random_InThreshold
		jnb	short loc_11446	; 70% success, 30% dodge

loc_1140C:				; CODE XREF: seg000:13FBj
		test	word ptr [di+2Dh], 200h
		jnz	short loc_11442

loc_11413:				; CODE XREF: seg000:1402j
		mov	dx, 6
		call	Random_InRange
		add	ax, 10
		mov	dx, ax		; DX = 10 + random[0..5]
		xor	ah, ah
		mov	al, [si+32h]
		call	Random_InThreshold2
		mov	ax, dx
		jnb	short loc_11431
		add	ax, 10		; (?) critical hit (?)
		mov	byte ptr [di+56h], 1

loc_11431:				; CODE XREF: seg000:1428j
		add	ax, [si+21h]	; add attack points
		sub	ax, [di+27h]	; subtract defense points of target
		jnb	short loc_1143B
		xor	ax, ax		; clamp	to 0

loc_1143B:				; CODE XREF: seg000:1437j
		mov	[di+49h], ax	; set points of	reduction for health
		mov	al, 1		; take attack
		jmp	short loc_11448
; ---------------------------------------------------------------------------

loc_11442:				; CODE XREF: seg000:1411j
		mov	al, 4		; attack has no	effect
		jmp	short loc_11448
; ---------------------------------------------------------------------------

loc_11446:				; CODE XREF: seg000:140Aj
		mov	al, 2		; dodge	attack

loc_11448:				; CODE XREF: seg000:1440j seg000:1444j
		mov	[di+4Fh], al
		pop	dx
		pop	ax
		retn
; ---------------------------------------------------------------------------
		retn
; ---------------------------------------------------------------------------

actExec01_EnmWeird:			; DATA XREF: seg000:jmpTblActExeco
		push	ax
		push	dx
		test	word ptr [di+45h], 400h
		jnz	short loc_1145F	; target is paralyzed -	attack always succeeds
		test	word ptr [di+2Dh], 400h
		jnz	short loc_11479

loc_1145F:				; CODE XREF: seg000:1456j
		mov	dx, 3
		call	Random_InRange
		add	ax, 8
		add	ax, [si+21h]
		sub	ax, [di+27h]
		jnb	short loc_11472
		xor	ax, ax

loc_11472:				; CODE XREF: seg000:146Ej
		mov	[di+49h], ax
		mov	al, 1
		jmp	short loc_1147B
; ---------------------------------------------------------------------------

loc_11479:				; CODE XREF: seg000:145Dj
		mov	al, 4		; attack has no	effect

loc_1147B:				; CODE XREF: seg000:1477j
		mov	[di+4Fh], al
		pop	dx
		pop	ax
		retn
; ---------------------------------------------------------------------------

actExec02_EnmSpecific:			; DATA XREF: seg000:jmpTblActExeco
		push	ax
		mov	al, [si+19h]	; get (enemy) character-specific attack
		call	DoAttack02_CharSpec
		pop	ax
		retn
; ---------------------------------------------------------------------------

actExec03_AtkReduce:			; DATA XREF: seg000:jmpTblActExeco
		push	ax
		push	dx
		test	word ptr [di+45h], 400h
		jnz	short loc_114A2
		mov	ax, 80
		call	Random_InThreshold
		jnb	short loc_114B4
		test	word ptr [di+2Dh], 80h
		jnz	short loc_114B0

loc_114A2:				; CODE XREF: seg000:1491j
		mov	dx, 5
		call	Random_InRange
		inc	ax
		mov	[di+4Bh], ax
		mov	al, 1
		jmp	short loc_114B6
; ---------------------------------------------------------------------------

loc_114B0:				; CODE XREF: seg000:14A0j
		mov	al, 4
		jmp	short loc_114B6
; ---------------------------------------------------------------------------

loc_114B4:				; CODE XREF: seg000:1499j
		mov	al, 2

loc_114B6:				; CODE XREF: seg000:14AEj seg000:14B2j
		mov	[di+4Fh], al
		pop	dx
		pop	ax
		retn
; ---------------------------------------------------------------------------

actExec04_DefReduce:			; DATA XREF: seg000:jmpTblActExeco
		push	ax
		push	dx
		test	word ptr [di+45h], 400h
		jnz	short loc_114D4
		mov	ax, 80
		call	Random_InThreshold
		jnb	short loc_114E6
		test	word ptr [di+2Dh], 100h
		jnz	short loc_114E2

loc_114D4:				; CODE XREF: seg000:14C3j
		mov	dx, 5
		call	Random_InRange
		inc	ax
		mov	[di+4Dh], ax
		mov	al, 1
		jmp	short loc_114E8
; ---------------------------------------------------------------------------

loc_114E2:				; CODE XREF: seg000:14D2j
		mov	al, 4
		jmp	short loc_114E8
; ---------------------------------------------------------------------------

loc_114E6:				; CODE XREF: seg000:14CBj
		mov	al, 2

loc_114E8:				; CODE XREF: seg000:14E0j seg000:14E4j
		mov	[di+4Fh], al
		pop	dx
		pop	ax
		retn
; ---------------------------------------------------------------------------

actExec05_Paralyze:			; DATA XREF: seg000:jmpTblActExeco
		push	ax
		push	dx
		test	word ptr [di+45h], 400h
		jnz	short loc_11506
		mov	ax, 60
		call	Random_InThreshold
		jnb	short loc_1151E
		test	word ptr [di+2Dh], 40h
		jnz	short loc_1151A

loc_11506:				; CODE XREF: seg000:14F5j
		or	word ptr [di+45h], 400h
		mov	dx, 2
		call	Random_InRange
		add	al, 2
		mov	[di+47h], al
		mov	al, 1
		jmp	short loc_11520
; ---------------------------------------------------------------------------

loc_1151A:				; CODE XREF: seg000:1504j
		mov	al, 4
		jmp	short loc_11520
; ---------------------------------------------------------------------------

loc_1151E:				; CODE XREF: seg000:14FDj
		mov	al, 2

loc_11520:				; CODE XREF: seg000:1518j seg000:151Cj
		mov	[di+4Fh], al
		pop	dx
		pop	ax
		retn
; ---------------------------------------------------------------------------

actExec06_Heal:				; DATA XREF: seg000:jmpTblActExeco
		push	ax
		push	dx
		mov	dx, 11
		call	Random_InRange
		add	ax, 10
		not	ax
		mov	[si+49h], ax
		mov	al, 1
		mov	[si+4Fh], al
		pop	dx
		pop	ax
		retn
; ---------------------------------------------------------------------------

actExec07_FullHeal:			; DATA XREF: seg000:jmpTblActExeco
		push	ax
		push	dx
		mov	ax, [si+1Dh]
		not	ax
		mov	[si+49h], ax
		mov	al, 1
		mov	[si+4Fh], al
		pop	dx
		pop	ax
		retn
; ---------------------------------------------------------------------------

actExec08_AtkIncrease:			; DATA XREF: seg000:jmpTblActExeco
		push	ax
		push	dx
		mov	dx, 5
		call	Random_InRange
		inc	ax
		not	ax
		mov	[si+4Bh], ax
		mov	al, 1
		mov	[si+4Fh], al
		pop	dx
		pop	ax
		retn
; ---------------------------------------------------------------------------

actExec09_DefIncrease:			; DATA XREF: seg000:jmpTblActExeco
		push	ax
		push	dx
		mov	dx, 5
		call	Random_InRange
		inc	ax
		not	ax
		mov	[si+4Dh], ax
		mov	al, 1
		mov	[si+4Fh], al
		pop	dx
		pop	ax
		retn
; ---------------------------------------------------------------------------

actExec0A_EnmSpecial:			; DATA XREF: seg000:jmpTblActExeco
		push	ax
		push	bp
		push	es
		mov	al, [si+50h]
		mov	bp, cs
		mov	es, bp
		assume es:seg000, ss:nothing
		mov	bp, offset off_11590
		call	CallJumpTbl
		pop	es
		assume es:nothing
		pop	bp
		pop	ax
		retn
; ---------------------------------------------------------------------------
off_11590	dw offset actSpc00_StrongAtk; 0	; DATA XREF: seg000:1586o
		dw offset actSpc01_SwapAtkDef; 1
		dw offset actSpc02_FullHeal; 2
		dw offset actSpc03_TransferHP; 3
		dw offset actSpc04	; 4
		dw offset actSpc05	; 5
		dw offset locret_116A0	; 6
; ---------------------------------------------------------------------------

actSpc00_StrongAtk:			; DATA XREF: seg000:off_11590o
		push	ax
		push	bx
		push	cx
		push	dx
		mov	dx, 6
		call	Random_InRange
		add	ax, 10
		mov	[di+49h], ax
		mov	al, 1
		jmp	short loc_115B4
; ---------------------------------------------------------------------------
		mov	al, 4

loc_115B4:				; CODE XREF: seg000:15B0j
		mov	[si+4Fh], al
		mov	[di+4Fh], al
		pop	dx
		pop	cx
		pop	bx
		pop	ax
		retn
; ---------------------------------------------------------------------------

actSpc01_SwapAtkDef:			; DATA XREF: seg000:off_11590o
		push	ax
		push	bx
		push	cx
		push	dx
		test	word ptr [di+45h], 400h
		jnz	short loc_115D1
		test	word ptr [di+2Dh], 4000h
		jnz	short loc_115FB

loc_115D1:				; CODE XREF: seg000:15C8j
		mov	ax, [si+21h]	; source current attack	points
		mov	bx, [si+27h]	; source current defense points
		mov	cx, [di+21h]	; target current attack	points
		mov	dx, [di+27h]	; target current defense points
		sub	ax, cx		; AX = source ATK - target ATK
		jnb	short loc_115E2
		dec	ax		; when >= 0 -> AX = AX - 1

loc_115E2:				; CODE XREF: seg000:15DFj
		sub	bx, dx		; BX = source DEF - target DEF
		jnb	short loc_115E7
		dec	bx

loc_115E7:				; CODE XREF: seg000:15E4j
		mov	[si+4Bh], ax	; source: increase attack
		mov	[si+4Dh], bx	; source: increase defense
		not	ax
		not	bx
		mov	[di+4Bh], ax	; target: decrease attack
		mov	[di+4Dh], bx	; target: decrease defense
		mov	al, 1
		jmp	short loc_115FD
; ---------------------------------------------------------------------------

loc_115FB:				; CODE XREF: seg000:15CFj
		mov	al, 4

loc_115FD:				; CODE XREF: seg000:15F9j
		mov	[si+4Fh], al
		mov	[di+4Fh], al
		pop	dx
		pop	cx
		pop	bx
		pop	ax
		retn
; ---------------------------------------------------------------------------

actSpc02_FullHeal:			; DATA XREF: seg000:off_11590o
		push	ax
		push	dx
		mov	ax, [si+1Dh]
		not	ax
		mov	[si+49h], ax
		mov	al, 1
		mov	[si+4Fh], al
		pop	dx
		pop	ax
		retn
; ---------------------------------------------------------------------------

actSpc03_TransferHP:			; DATA XREF: seg000:off_11590o
		push	ax
		push	bx
		push	cx
		test	word ptr [di+45h], 400h
		jnz	short loc_1162B
		test	word ptr [di+2Dh], 4000h
		jnz	short loc_1164B

loc_1162B:				; CODE XREF: seg000:1622j
		mov	ax, [si+1Bh]	; source: current health points
		mov	bx, [si+1Dh]	; source: maximum health points
		mov	cx, [di+1Bh]	; target: current health points
		shr	cx, 1
		add	ax, cx		; AX = source HP + (target HP /	2)
		add	bx, 50		; BX = source max. HP +	50
		cmp	ax, bx
		jbe	short loc_11641
		mov	ax, bx		; clamp	AX to (source max. HP +	50)

loc_11641:				; CODE XREF: seg000:163Dj
		mov	[si+1Bh], ax
		mov	[di+49h], cx	; target damage	= (target HP / 2)
		mov	al, 1
		jmp	short loc_1164D
; ---------------------------------------------------------------------------

loc_1164B:				; CODE XREF: seg000:1629j
		mov	al, 4

loc_1164D:				; CODE XREF: seg000:1649j
		mov	[si+4Fh], al
		mov	[di+4Fh], al
		pop	cx
		pop	bx
		pop	ax
		retn
; ---------------------------------------------------------------------------

actSpc04:				; DATA XREF: seg000:off_11590o
		push	ax
		push	dx
		test	word ptr [di+45h], 400h
		jnz	short loc_1166E
		test	word ptr [di+2Dh], 4000h
		jnz	short loc_11682
		test	word ptr [di+2Dh], 40h
		jnz	short loc_11682

loc_1166E:				; CODE XREF: seg000:165Ej
		or	word ptr [di+45h], 400h
		mov	dx, 2
		call	Random_InRange
		add	al, 2
		mov	[di+47h], al
		mov	al, 1
		jmp	short loc_11684
; ---------------------------------------------------------------------------

loc_11682:				; CODE XREF: seg000:1665j seg000:166Cj
		mov	al, 4

loc_11684:				; CODE XREF: seg000:1680j
		mov	[di+4Fh], al
		pop	dx
		pop	ax
		retn
; ---------------------------------------------------------------------------

actSpc05:				; DATA XREF: seg000:off_11590o
		push	ax
		push	dx
		mov	al, [di+43h]
		shr	al, 1
		mov	[di+43h], al
		mov	al, 1
		jmp	short loc_1169A
; ---------------------------------------------------------------------------
		mov	al, 4

loc_1169A:				; CODE XREF: seg000:1696j
		mov	[di+4Fh], al
		pop	dx
		pop	ax
		retn
; ---------------------------------------------------------------------------

locret_116A0:				; DATA XREF: seg000:off_11590o
		retn
; ---------------------------------------------------------------------------

actExec0D_PlasmaFlash:			; DATA XREF: seg000:jmpTblActExeco
		push	ax
		push	bx
		push	dx
		test	word ptr [di+45h], 400h
		jnz	short loc_116B2
		test	word ptr [di+2Dh], 20h
		jnz	short loc_116E1

loc_116B2:				; CODE XREF: seg000:16A9j
		mov	al, [si+43h]	; get Plasma Charge level
		inc	al
		cmp	al, 50
		jnz	short loc_116BD
		inc	al		; Change Level == 49 ->	treat as 50

loc_116BD:				; CODE XREF: seg000:16B9j
		sub	al, 51
		mov	dl, 10
		xor	ah, ah
		div	dl
		mov	dl, 5
		mul	dl
		add	ax, 15
		mov	bx, ax		; BX = (Charge Level - 50) / 10	* 5 + 15
		mov	dx, 6
		call	Random_InRange
		add	ax, bx
		mov	[di+49h], ax
		mov	byte ptr [si+43h], 0
		mov	al, 1
		jmp	short loc_116E7
; ---------------------------------------------------------------------------

loc_116E1:				; CODE XREF: seg000:16B0j
		mov	byte ptr [si+43h], 0
		mov	al, 4

loc_116E7:				; CODE XREF: seg000:16DFj
		mov	[di+4Fh], al
		pop	dx
		pop	bx
		pop	ax
		retn
; ---------------------------------------------------------------------------

actExec0E_Electrode:			; DATA XREF: seg000:jmpTblActExeco
		push	ax
		push	dx
		mov	word ptr [si+45h], 200h
		mov	al, 1
		mov	[si+4Fh], al
		pop	dx
		pop	ax
		retn
; ---------------------------------------------------------------------------

actExec0F_PlasmaCharge:			; DATA XREF: seg000:jmpTblActExeco
		push	ax
		push	dx
		mov	dx, 11
		call	Random_InRange
		add	al, 15
		add	al, [si+43h]
		cmp	al, 100
		jbe	short loc_11710
		mov	al, 100

loc_11710:				; CODE XREF: seg000:170Cj
		mov	[si+43h], al
		mov	al, 1
		mov	[si+4Fh], al
		pop	dx
		pop	ax
		retn
; ---------------------------------------------------------------------------

actExec10_DgkPunch:			; DATA XREF: seg000:jmpTblActExeco
		push	ax
		push	dx
		test	word ptr [di+45h], 400h
		jnz	short loc_1172B
		test	word ptr [di+2Dh], 1
		jnz	short loc_1175F

loc_1172B:				; CODE XREF: seg000:1722j
		mov	dx, 5
		call	Random_InRange
		inc	ax		; base attack =	random(1..5)
		cmp	byte ptr [si+43h], 50
		jb	short loc_1173B
		add	ax, 5		; charge level >= 50% -> +5 attack

loc_1173B:				; CODE XREF: seg000:1736j
		mov	dx, ax
		mov	ax, 5		; critical hit change: 5%
		call	Random_InThreshold2
		mov	ax, dx
		jnb	short loc_1174E
		add	ax, 10		; critical hit -> +10 attack
		mov	byte ptr [di+56h], 1

loc_1174E:				; CODE XREF: seg000:1745j
		add	ax, [si+21h]
		sub	ax, [di+27h]
		jnb	short loc_11758
		xor	ax, ax

loc_11758:				; CODE XREF: seg000:1754j
		mov	[di+49h], ax
		mov	al, 1
		jmp	short loc_11761
; ---------------------------------------------------------------------------

loc_1175F:				; CODE XREF: seg000:1729j
		mov	al, 4

loc_11761:				; CODE XREF: seg000:175Dj
		mov	[di+4Fh], al
		pop	dx
		pop	ax
		retn
; ---------------------------------------------------------------------------

actExec11_DgkShuriken:			; DATA XREF: seg000:jmpTblActExeco
		push	ax
		push	dx
		test	word ptr [di+45h], 400h
		jnz	short loc_11777
		test	word ptr [di+2Dh], 2
		jnz	short loc_117B1

loc_11777:				; CODE XREF: seg000:176Ej
		mov	dx, 3
		call	Random_InRange
		inc	ax
		mov	[di+51h], al
		mov	cx, ax
		mov	dx, 3
		call	Random_InRange
		add	ax, 3
		mov	[di+49h], ax
		dec	cx
		jz	short loc_117AD
		mov	dx, 3
		call	Random_InRange
		add	ax, 3
		mov	[di+52h], ax
		dec	cx
		jz	short loc_117AD
		mov	dx, 3
		call	Random_InRange
		add	ax, 3
		mov	[di+54h], ax

loc_117AD:				; CODE XREF: seg000:1790j seg000:179Fj
		mov	al, 1
		jmp	short loc_117B3
; ---------------------------------------------------------------------------

loc_117B1:				; CODE XREF: seg000:1775j
		mov	al, 4

loc_117B3:				; CODE XREF: seg000:17AFj
		mov	[di+4Fh], al
		pop	dx
		pop	ax
		retn
; ---------------------------------------------------------------------------

actExec12_DgkKick:			; DATA XREF: seg000:jmpTblActExeco
		push	ax
		push	dx
		test	word ptr [di+45h], 400h
		jnz	short loc_117D1
		mov	ax, 75
		call	Random_InThreshold
		jnb	short loc_1180B
		test	word ptr [di+2Dh], 4
		jnz	short loc_11807

loc_117D1:				; CODE XREF: seg000:17C0j
		mov	dx, 5
		call	Random_InRange
		add	ax, 5
		cmp	byte ptr [si+43h], 50
		jb	short loc_117E3
		add	ax, 5		; charged -> +5	attack

loc_117E3:				; CODE XREF: seg000:17DEj
		mov	dx, ax
		mov	ax, 20
		call	Random_InThreshold2
		mov	ax, dx
		jnb	short loc_117F6
		add	ax, 10		; critical hit -> +10 attack
		mov	byte ptr [di+56h], 1

loc_117F6:				; CODE XREF: seg000:17EDj
		add	ax, [si+21h]
		sub	ax, [di+27h]
		jnb	short loc_11800
		xor	ax, ax

loc_11800:				; CODE XREF: seg000:17FCj
		mov	[di+49h], ax
		mov	al, 1
		jmp	short loc_1180D
; ---------------------------------------------------------------------------

loc_11807:				; CODE XREF: seg000:17CFj
		mov	al, 4
		jmp	short loc_1180D
; ---------------------------------------------------------------------------

loc_1180B:				; CODE XREF: seg000:17C8j
		mov	al, 2

loc_1180D:				; CODE XREF: seg000:1805j seg000:1809j
		mov	[di+4Fh], al
		pop	dx
		pop	ax
		retn
; ---------------------------------------------------------------------------

actExec13_DgkScalpel:			; DATA XREF: seg000:jmpTblActExeco
		push	ax
		push	dx
		test	word ptr [di+45h], 400h
		jnz	short loc_1182B
		mov	ax, 70
		call	Random_InThreshold
		jnb	short loc_11857
		test	word ptr [di+2Dh], 8
		jnz	short loc_11853

loc_1182B:				; CODE XREF: seg000:181Aj
		mov	dx, 3
		call	Random_InRange
		add	ax, 4
		mov	[di+49h], ax
		mov	dx, 2
		call	Random_InRange
		add	ax, 2
		mov	[di+4Bh], ax
		mov	dx, 2
		call	Random_InRange
		add	ax, 2
		mov	[di+4Dh], ax
		mov	al, 1
		jmp	short loc_11859
; ---------------------------------------------------------------------------

loc_11853:				; CODE XREF: seg000:1829j
		mov	al, 4
		jmp	short loc_11859
; ---------------------------------------------------------------------------

loc_11857:				; CODE XREF: seg000:1822j
		mov	al, 2

loc_11859:				; CODE XREF: seg000:1851j seg000:1855j
		mov	[di+4Fh], al
		pop	dx
		pop	ax
		retn
; ---------------------------------------------------------------------------

actExec14_DgkBazooka:			; DATA XREF: seg000:jmpTblActExeco
		push	ax
		push	dx
		test	word ptr [di+45h], 400h
		jnz	short loc_11877
		mov	ax, 70
		call	Random_InThreshold
		jnb	short loc_1188B
		test	word ptr [di+2Dh], 10h
		jnz	short loc_11887

loc_11877:				; CODE XREF: seg000:1866j
		mov	dx, 9
		call	Random_InRange
		add	ax, 22
		mov	[di+49h], ax
		mov	al, 1
		jmp	short loc_1188D
; ---------------------------------------------------------------------------

loc_11887:				; CODE XREF: seg000:1875j
		mov	al, 4
		jmp	short loc_1188D
; ---------------------------------------------------------------------------

loc_1188B:				; CODE XREF: seg000:186Ej
		mov	al, 2

loc_1188D:				; CODE XREF: seg000:1885j seg000:1889j
		mov	[di+4Fh], al
		pop	dx
		pop	ax
		retn

; =============== S U B	R O U T	I N E =======================================


Random_InThreshold proc	near		; CODE XREF: seg000:1407p seg000:1496p ...
		push	ax
		push	bx
		push	dx
		mov	bx, ax
		mov	dx, 100
		call	Random_InRange
		cmp	ax, bx
		pop	dx
		pop	bx
		pop	ax
		retn
Random_InThreshold endp


; =============== S U B	R O U T	I N E =======================================


Random_InThreshold2 proc near		; CODE XREF: seg000:1423p seg000:1740p ...
		push	ax
		push	bx
		push	dx
		mov	bx, ax
		mov	dx, 100
		call	Random_InRange
		cmp	ax, bx
		pop	dx
		pop	bx
		pop	ax
		retn
Random_InThreshold2 endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


LoadSFlameGPA	proc near		; CODE XREF: LoadSFlameGPA2+5p
		push	ax
		push	dx
		push	ds
		mov	dx, seg	seg001
		mov	ds, dx
		mov	dx, offset aAAct_gpcSflame ; "A:\\ACT_GPC\\SFLAME.GPA"
		xor	ax, ax
		call	LoadGPA
		pop	ds
		assume ds:nothing
		pop	dx
		pop	ax
		retn
LoadSFlameGPA	endp


; =============== S U B	R O U T	I N E =======================================


sub_118CA	proc near		; CODE XREF: sub_102C1+5p
					; ShowChargedFX:loc_10D22p
		push	ax
		push	si
		push	ds
		mov	si, seg	seg001
		mov	ds, si
		assume ds:seg001
		mov	si, offset off_14DC8
		xor	ah, ah
		shl	ax, 1
		add	si, ax
		mov	si, [si]
		xor	al, al
		call	sub_1469E
		pop	ds
		assume ds:nothing
		pop	si
		pop	ax
		retn
sub_118CA	endp


; =============== S U B	R O U T	I N E =======================================


sub_118E6	proc near		; CODE XREF: ShowChargedFX+30p
		push	ax
		push	cx
		mov	cx, 0FFFFh
		xor	al, al
		call	sub_146A5
		call	sub_146B5
		pop	cx
		pop	ax
		retn
sub_118E6	endp


; =============== S U B	R O U T	I N E =======================================


LoadEnemyGfx	proc near		; CODE XREF: LoadEnemyGfx2:loc_10510p
		push	ax
		push	di
		call	GDCPlane_RW1
		mov	di, 0
		call	LoadD1CVC6
		jb	short loc_1195E
		call	sub_11BD6
		mov	di, 16h
		call	LoadD1ENMF
		jb	short loc_1195E
		call	GDCPlane_RW1
		call	sub_11A1E
		mov	al, 4
		mov	di, 1Ch
		call	LoadD1CVC
		jb	short loc_1195E
		mov	al, 3
		mov	di, 0
		call	LoadD1CVC
		jb	short loc_1195E
		call	sub_11A4C
		mov	al, 2
		mov	di, 0
		call	LoadD1CVC
		jb	short loc_1195E
		call	sub_11A98
		mov	al, 1
		mov	di, 1Ch
		call	LoadD1CVC
		jb	short loc_1195E
		mov	al, 0
		mov	di, 0
		call	LoadD1CVC
		jb	short loc_1195E
		call	sub_11B0A
		call	sub_11B4E
		call	sub_11B92
		call	sub_11ACF
		call	GDCPlane_RW0
		clc
		jmp	short loc_11962
; ---------------------------------------------------------------------------

loc_1195E:				; CODE XREF: LoadEnemyGfx+Bj
					; LoadEnemyGfx+16j ...
		call	GDCPlane_RW0
		stc

loc_11962:				; CODE XREF: LoadEnemyGfx+66j
		pop	di
		pop	ax
		retn
LoadEnemyGfx	endp


; =============== S U B	R O U T	I N E =======================================


LoadD1CVC	proc near		; CODE XREF: LoadEnemyGfx+23p
					; LoadEnemyGfx+2Dp ...
		push	ax
		push	dx
		push	si
		push	ds
		mov	si, seg	seg001
		mov	ds, si
		assume ds:seg001
		xor	ah, ah
		shl	ax, 1
		mov	si, offset fnListD1CVC
		add	si, ax
		mov	dx, [si]
		xor	ax, ax
		call	LoadGPC
		pop	ds
		assume ds:nothing
		pop	si
		pop	dx
		pop	ax
		retn
LoadD1CVC	endp


; =============== S U B	R O U T	I N E =======================================


LoadD1ENMF	proc near		; CODE XREF: LoadEnemyGfx+13p
		push	ax
		push	dx
		push	si
		push	ds
		mov	si, seg	seg001
		mov	ds, si
		assume ds:seg001
		xor	ah, ah
		shl	ax, 1
		mov	si, offset fnListD1Enm
		add	si, ax
		mov	dx, [si]
		mov	ax, 0FFh
		call	LoadGPC
		pop	ds
		assume ds:nothing
		pop	si
		pop	dx
		pop	ax
		retn
LoadD1ENMF	endp


; =============== S U B	R O U T	I N E =======================================


LoadD1CVC6	proc near		; CODE XREF: LoadEnemyGfx+8p
		push	ax
		push	dx
		push	ds
		mov	dx, seg	seg001
		mov	ds, dx
		assume ds:seg001
		mov	dx, offset fnD1CVC6 ; "A:\\ACT_GPC\\D1CVC6.GPC"
		mov	ax, 0FFh
		call	LoadGPC
		pop	ds
		assume ds:nothing
		pop	dx
		pop	ax
		retn
LoadD1CVC6	endp


; =============== S U B	R O U T	I N E =======================================


DoMemoryAlloc	proc near		; CODE XREF: GfxMemory_Alloc+5p
		pusha
		push	ds
		push	es
		mov	bx, seg	seg001
		mov	ds, bx
		assume ds:seg001
		mov	bx, 2000h
		call	malloc
		jb	short loc_119D5
		mov	Mem8KSeg, ax
		mov	bx, 380h
		call	malloc
		jb	short loc_119D5
		mov	Mem800BSeg, ax

loc_119D5:				; CODE XREF: DoMemoryAlloc+Ej
					; DoMemoryAlloc+19j
		pop	es
		pop	ds
		assume ds:nothing
		popa
		retn
DoMemoryAlloc	endp


; =============== S U B	R O U T	I N E =======================================


DoMemoryFree	proc near		; CODE XREF: GfxMemory_Freep
		pusha
		push	ds
		push	es
		mov	bx, seg	seg001
		mov	ds, bx
		assume ds:seg001
		mov	es, Mem8KSeg
		call	free
		jb	short loc_119F1
		mov	es, Mem800BSeg
		call	free

loc_119F1:				; CODE XREF: DoMemoryFree+Fj
		pop	es
		pop	ds
		assume ds:nothing
		popa
		retn
DoMemoryFree	endp

; ---------------------------------------------------------------------------
		pusha
		push	ds
		push	es
		mov	si, 0
		mov	di, 502h
		mov	bx, 100h
		mov	dx, 16h
		mov	al, 0
		call	sub_130C3
		mov	si, 5280h
		mov	di, 5782h
		mov	bx, 1Fh
		mov	dx, 16h
		mov	al, 0
		call	sub_130C3
		pop	es
		pop	ds
		popa
		retn

; =============== S U B	R O U T	I N E =======================================


sub_11A1E	proc near		; CODE XREF: LoadEnemyGfx+1Bp
		pusha
		push	ds
		push	es
		mov	si, seg	seg001
		mov	ds, si
		assume ds:seg001
		mov	es, Mem8KSeg
		mov	si, 16h
		mov	di, 6200h
		mov	bx, 100h
		mov	dx, 16h
		call	sub_12F68
		mov	si, 2Ch	; ','
		mov	di, 5400h
		mov	bx, 80h	; 'Ä'
		mov	dx, 1Ch
		call	sub_12F68
		pop	es
		pop	ds
		assume ds:nothing
		popa
		retn
sub_11A1E	endp


; =============== S U B	R O U T	I N E =======================================


sub_11A4C	proc near		; CODE XREF: LoadEnemyGfx+32p
		pusha
		push	ds
		push	es
		mov	si, seg	seg001
		mov	ds, si
		assume ds:seg001
		mov	es, Mem8KSeg
		mov	bx, 80h	; 'Ä'
		mov	dx, 1Ch
		mov	si, 501Ch
		mov	di, 4600h
		call	sub_12F68
		mov	si, 281Ch
		mov	di, 3800h
		call	sub_12F68
		mov	si, 1Ch
		mov	di, 2A00h
		call	sub_12F68
		mov	si, 5000h
		mov	di, 1C00h
		call	sub_12F68
		mov	si, 2800h
		mov	di, 0E00h
		call	sub_12F68
		mov	si, 0
		mov	di, 0
		call	sub_12F68
		pop	es
		pop	ds
		assume ds:nothing
		popa
		retn
sub_11A4C	endp


; =============== S U B	R O U T	I N E =======================================


sub_11A98	proc near		; CODE XREF: LoadEnemyGfx+3Fp
		pusha
		push	ds
		push	es
		xor	al, al
		call	sub_146C3
		mov	bp, bx
		mov	bx, 80h	; 'Ä'
		mov	dx, 1Ch
		mov	si, 0
		mov	di, bp
		add	di, 0
		call	sub_12F8D
		mov	si, 2800h
		mov	di, bp
		add	di, 3800h
		call	sub_12F8D
		mov	si, 5000h
		mov	di, bp
		add	di, 7000h
		call	sub_12F8D
		pop	es
		pop	ds
		popa
		retn
sub_11A98	endp


; =============== S U B	R O U T	I N E =======================================


sub_11ACF	proc near		; CODE XREF: LoadEnemyGfx+5Fp
		pusha
		push	ds
		push	es
		xor	al, al
		call	sub_146C3
		mov	bp, es
		mov	ds, bp
		mov	bp, bx
		mov	bx, 80h	; 'Ä'
		mov	dx, 1Ch
		mov	si, bp
		add	si, 0
		mov	di, 5400h
		call	sub_12FB7
		mov	si, bp
		add	si, 3800h
		mov	di, 6200h
		call	sub_12FB7
		mov	si, bp
		add	si, 7000h
		mov	di, 7000h
		call	sub_12FB7
		pop	es
		pop	ds
		popa
		retn
sub_11ACF	endp


; =============== S U B	R O U T	I N E =======================================


sub_11B0A	proc near		; CODE XREF: LoadEnemyGfx+56p
		pusha
		push	ds
		push	es
		call	sub_14684
		mov	bp, bx
		mov	bx, 80h	; 'Ä'
		mov	dx, 1Ch
		mov	si, 0
		mov	di, bp
		add	di, 0
		call	sub_12F8D
		mov	si, 1Ch
		mov	di, bp
		add	di, 3800h
		call	sub_12F8D
		mov	si, es
		mov	ds, si
		mov	si, bp
		add	si, 0
		mov	di, 0
		call	sub_12FB7
		mov	si, bp
		add	si, 3800h
		mov	di, 0E00h
		call	sub_12FB7
		pop	es
		pop	ds
		popa
		retn
sub_11B0A	endp


; =============== S U B	R O U T	I N E =======================================


sub_11B4E	proc near		; CODE XREF: LoadEnemyGfx+59p
		pusha
		push	ds
		push	es
		call	sub_14684
		mov	bp, bx
		mov	bx, 80h	; 'Ä'
		mov	dx, 1Ch
		mov	si, 2800h
		mov	di, bp
		add	di, 0
		call	sub_12F8D
		mov	si, 281Ch
		mov	di, bp
		add	di, 3800h
		call	sub_12F8D
		mov	si, es
		mov	ds, si
		mov	si, bp
		add	si, 0
		mov	di, 1C00h
		call	sub_12FB7
		mov	si, bp
		add	si, 3800h
		mov	di, 2A00h
		call	sub_12FB7
		pop	es
		pop	ds
		popa
		retn
sub_11B4E	endp


; =============== S U B	R O U T	I N E =======================================


sub_11B92	proc near		; CODE XREF: LoadEnemyGfx+5Cp
		pusha
		push	ds
		push	es
		call	sub_14684
		mov	bp, bx
		mov	bx, 80h	; 'Ä'
		mov	dx, 1Ch
		mov	si, 5000h
		mov	di, bp
		add	di, 0
		call	sub_12F8D
		mov	si, 501Ch
		mov	di, bp
		add	di, 3800h
		call	sub_12F8D
		mov	si, es
		mov	ds, si
		mov	si, bp
		add	si, 0
		mov	di, 3800h
		call	sub_12FB7
		mov	si, bp
		add	si, 3800h
		mov	di, 4600h
		call	sub_12FB7
		pop	es
		pop	ds
		popa
		retn
sub_11B92	endp


; =============== S U B	R O U T	I N E =======================================


sub_11BD6	proc near		; CODE XREF: LoadEnemyGfx+Dp
		pusha
		push	ds
		push	es
		mov	si, seg	seg001
		mov	ds, si
		assume ds:seg001
		mov	es, Mem800BSeg
		mov	si, 0
		mov	di, 0
		mov	bx, 80h
		mov	dx, 1Ch
		call	sub_12FE5
		pop	es
		pop	ds
		assume ds:nothing
		popa
		retn
sub_11BD6	endp


; =============== S U B	R O U T	I N E =======================================


DrawActionImage	proc near		; CODE XREF: sub_107F2:loc_107FEp
					; ShowActionImage:loc_10851p ...
		pusha
		push	ds
		push	es
		mov	bx, seg	seg001
		mov	ds, bx
		assume ds:seg001
		xor	bh, bh
		mov	bl, al
		shl	bx, 1
		add	bx, offset word_1500A
		mov	si, [bx]
		mov	di, 141Ah
		mov	bx, 80h
		mov	dx, 1Ch
		mov	ds, Mem8KSeg
		assume ds:nothing
		cmp	al, 11h
		jnz	short loc_11C28
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		mov	ds, Mem800BSeg
		assume ds:nothing
		call	sub_13088
		jmp	short loc_11C5F
; ---------------------------------------------------------------------------

loc_11C28:				; CODE XREF: DrawActionImage+23j
		cmp	al, 10h
		jnz	short loc_11C37
		mov	di, 502h
		mov	bx, 100h
		mov	dx, 16h
		jmp	short loc_11C3B
; ---------------------------------------------------------------------------

loc_11C37:				; CODE XREF: DrawActionImage+35j
		cmp	al, 8
		jbe	short loc_11C40

loc_11C3B:				; CODE XREF: DrawActionImage+40j
		call	sub_1300B
		jmp	short loc_11C5F
; ---------------------------------------------------------------------------

loc_11C40:				; CODE XREF: DrawActionImage+44j
		call	GDCPlane_RW1
		mov	al, 1
		call	sub_146C3
		mov	di, bx
		mov	bx, 80h
		call	sub_13030
		call	GDCPlane_RW0
		mov	si, es
		mov	ds, si
		mov	si, di
		mov	di, 141Ah
		call	sub_1305E

loc_11C5F:				; CODE XREF: DrawActionImage+31j
					; DrawActionImage+49j
		pop	es
		pop	ds
		popa
		retn
DrawActionImage	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


ShowSelectMsg	proc near		; CODE XREF: DoPlayerActionSel+6p
		push	ax
		push	dx
		push	ds
		mov	dx, seg	seg001
		mov	ds, dx
		assume ds:seg001
		mov	dl, FrameDelay
		mov	FrameDelay, 0	; set to 0 to show message instantly
		mov	ax, 0
		call	ShowMessageText	; Select a command!
		mov	FrameDelay, dl
		pop	ds
		assume ds:nothing
		pop	dx
		pop	ax
		retn
ShowSelectMsg	endp


; =============== S U B	R O U T	I N E =======================================


ShowActionText	proc near		; CODE XREF: ShowAttackList+Dp
					; ShowAttackList+14p ...
		pusha
		push	ds
		push	es
		mov	si, seg	seg001
		mov	ds, si
		assume ds:seg001
		mov	dl, FrameDelay
		mov	FrameDelay, 0
		mov	si, offset tCoord_Actions
		shl	bx, 1
		add	si, bx
		mov	si, [si]
		call	DrawText
		mov	si, offset tListActions
		shl	ax, 1
		add	si, ax
		mov	si, [si]
		call	DrawText
		mov	FrameDelay, dl
		pop	es
		pop	ds
		assume ds:nothing
		popa
		retn
ShowActionText	endp


; =============== S U B	R O U T	I N E =======================================


ClearMessageBox	proc near		; CODE XREF: ParalysisTimer+19p
					; NoActTimer_Drug+18p ...
		pusha
		mov	di, 529Bh
		mov	bx, 64
		mov	dx, 26
		mov	cl, 0Fh
		call	DoVRAMFill
		popa
		retn
ClearMessageBox	endp


; =============== S U B	R O U T	I N E =======================================


ShowStat_HP	proc near		; CODE XREF: RefreshHPDisp+1Cp
					; RefreshHPDisp+39p
		pusha
		push	ds
		push	es
		call	DrawInt_Pad_B1
		mov	si, seg	seg001
		mov	ds, si
		assume ds:seg001
		mov	dl, FrameDelay
		mov	FrameDelay, 0
		mov	si, offset tCoord_HP
		xor	bh, bh
		shl	bx, 1
		add	si, bx
		mov	si, [si]
		call	DrawText
		mov	si, offset aHealth ; "ëÃóÕÅ@"
		call	DrawText
		mov	si, offset aNumBuffer1 ; "ÇOÇOÇO"
		call	DrawText
		mov	FrameDelay, dl
		pop	es
		pop	ds
		assume ds:nothing
		popa
		retn
ShowStat_HP	endp


; =============== S U B	R O U T	I N E =======================================


ShowStat_Atk	proc near		; CODE XREF: RefreshAtkDisp+1Cp
					; RefreshAtkDisp+39p
		pusha
		push	ds
		push	es
		call	DrawInt_Pad_B1
		mov	si, seg	seg001
		mov	ds, si
		assume ds:seg001
		mov	dl, FrameDelay
		mov	FrameDelay, 0
		mov	si, offset tCoord_Atk
		xor	bh, bh
		shl	bx, 1
		add	si, bx
		mov	si, [si]
		call	DrawText
		mov	si, offset aAttack ; "çUåÇóÕ"
		call	DrawText
		mov	si, offset aNumBuffer1 ; "ÇOÇOÇO"
		call	DrawText
		mov	FrameDelay, dl
		pop	es
		pop	ds
		assume ds:nothing
		popa
		retn
ShowStat_Atk	endp


; =============== S U B	R O U T	I N E =======================================


ShowStat_Def	proc near		; CODE XREF: RefreshDefDisp+1Cp
					; RefreshDefDisp+39p
		pusha
		push	ds
		push	es
		call	DrawInt_Pad_B1
		mov	si, seg	seg001
		mov	ds, si
		assume ds:seg001
		mov	dl, FrameDelay
		mov	FrameDelay, 0
		mov	si, offset tCoord_Def
		xor	bh, bh
		shl	bx, 1
		add	si, bx
		mov	si, [si]
		call	DrawText
		mov	si, offset aDefense ; "éÁîıóÕ"
		call	DrawText
		mov	si, offset aNumBuffer1 ; "ÇOÇOÇO"
		call	DrawText
		mov	FrameDelay, dl
		pop	es
		pop	ds
		assume ds:nothing
		popa
		retn
ShowStat_Def	endp


; =============== S U B	R O U T	I N E =======================================


ClearStat_HP	proc near		; CODE XREF: RefreshHPDisp+19p
					; RefreshHPDisp+36p
		pusha
		mov	di, 668Dh
		or	bl, bl
		jz	short loc_11D72
		mov	di, 66C3h

loc_11D72:				; CODE XREF: ClearStat_HP+6j
		mov	bx, 10h
		mov	dx, 6
		mov	cl, 0Fh
		call	DoVRAMFill
		popa
		retn
ClearStat_HP	endp


; =============== S U B	R O U T	I N E =======================================


ClearStat_Atk	proc near		; CODE XREF: RefreshAtkDisp+19p
					; RefreshAtkDisp+36p
		pusha
		mov	di, 6B8Dh
		or	bl, bl
		jz	short loc_11D8A
		mov	di, 6BC3h

loc_11D8A:				; CODE XREF: ClearStat_Atk+6j
		mov	bx, 10h
		mov	dx, 6
		mov	cl, 0Fh
		call	DoVRAMFill
		popa
		retn
ClearStat_Atk	endp


; =============== S U B	R O U T	I N E =======================================


ClearStat_Def	proc near		; CODE XREF: RefreshDefDisp+19p
					; RefreshDefDisp+36p
		pusha
		mov	di, 708Dh
		or	bl, bl
		jz	short loc_11DA2
		mov	di, 70C3h

loc_11DA2:				; CODE XREF: ClearStat_Def+6j
		mov	bx, 10h
		mov	dx, 6
		mov	cl, 0Fh
		call	DoVRAMFill
		popa
		retn
ClearStat_Def	endp


; =============== S U B	R O U T	I N E =======================================


ShowMessageText	proc near		; CODE XREF: ParalysisTimer+1Fp
					; NoActTimer_Drug+1Ep ...
		pusha
		push	ds
		push	es
		call	SetFrameDelay1
		mov	si, seg	seg001
		mov	ds, si
		assume ds:seg001
		mov	si, offset tCoord_Msg ;	"@X27@Y264@C0@F1"
		call	DrawText
		mov	si, offset tListMessages
		shl	ax, 1
		add	si, ax
		mov	si, [si]
		call	DrawText
		pop	es
		pop	ds
		assume ds:nothing
		popa
		retn
ShowMessageText	endp


; =============== S U B	R O U T	I N E =======================================


ShowChat1Text	proc near		; CODE XREF: sub_10DAB+1Bp
					; seg000:1E8Bp	...
		pusha
		push	ds
		push	es
		call	SetFrameDelay1
		mov	si, seg	seg001
		mov	ds, si
		assume ds:seg001
		mov	si, offset tCoord_PlrChat ; "@X27@Y264@C4@F1"
		call	DrawText
		mov	si, offset tListPlayer
		shl	ax, 1
		add	si, ax
		mov	si, [si]
		call	DrawText
		pop	es
		pop	ds
		assume ds:nothing
		popa
		retn
ShowChat1Text	endp


; =============== S U B	R O U T	I N E =======================================


ShowChat2Text	proc near		; CODE XREF: sub_10DAB+28p
					; seg000:1E5Bp	...
		pusha
		push	ds
		push	es
		call	SetFrameDelay1
		mov	si, seg	seg001
		mov	ds, si
		assume ds:seg001
		mov	si, offset tCoord_EnmChat ; "@X27@Y264@C7@F1"
		call	DrawText
		mov	si, offset tListEnemy
		shl	bx, 1
		mov	si, [bx+si]
		shl	ax, 1
		add	si, ax
		mov	si, [si]
		call	DrawText
		pop	es
		pop	ds
		assume ds:nothing
		popa
		retn
ShowChat2Text	endp


; =============== S U B	R O U T	I N E =======================================


ShowActIntroMsg	proc near		; CODE XREF: ShowActIntroMsg_a+7p
		push	ax
		push	bp
		push	es
		mov	bp, cs
		mov	es, bp
		assume es:seg000
		mov	bp, offset jmpTblActIMsg
		call	CallJumpTbl
		pop	es
		assume es:nothing
		pop	bp
		pop	ax
		retn
ShowActIntroMsg	endp

; ---------------------------------------------------------------------------
jmpTblActIMsg	dw offset aiMsg00	; 0 ; DATA XREF: ShowActIntroMsg+7o
		dw offset aiMsg01	; 1
		dw offset aiMsg02	; 2
		dw offset aiMsg03	; 3
		dw offset aiMsg04	; 4
		dw offset aiMsg05	; 5
		dw offset aiMsg06	; 6
		dw offset aiMsg07	; 7
		dw offset aiMsg08	; 8
		dw offset aiMsg09	; 9
		dw offset aiMsg0A	; 0Ah
		dw offset aiMsg0B	; 0Bh
		dw offset aiMsg0C	; 0Ch
		dw offset aiMsg0D	; 0Dh
		dw offset aiMsg0E	; 0Eh
		dw offset aiMsg0F	; 0Fh
		dw offset aiMsg10	; 10h
		dw offset aiMsg11	; 11h
		dw offset aiMsg12	; 12h
		dw offset aiMsg13	; 13h
		dw offset aiMsg14	; 14h
; ---------------------------------------------------------------------------

aiMsg00:				; DATA XREF: seg000:jmpTblActIMsgo
		push	ax
		push	bx
		mov	ax, 0
		xor	bh, bh
		mov	bl, [si+19h]
		call	ShowChat2Text
		pop	bx
		pop	ax
		retn
; ---------------------------------------------------------------------------

aiMsg01:				; DATA XREF: seg000:jmpTblActIMsgo
		push	ax
		push	bx
		mov	ax, 1
		xor	bh, bh
		mov	bl, [si+19h]
		call	ShowChat2Text
		pop	bx
		pop	ax
		retn
; ---------------------------------------------------------------------------

aiMsg02:				; DATA XREF: seg000:jmpTblActIMsgo
		push	ax
		push	bx
		mov	ax, 2
		xor	bh, bh
		mov	bl, [si+19h]
		call	ShowChat2Text
		pop	bx
		pop	ax
		retn
; ---------------------------------------------------------------------------

aiMsg03:				; DATA XREF: seg000:jmpTblActIMsgo
		push	ax
		test	byte ptr [si+1Ah], 1
		jz	short loc_11E90
		mov	ax, 6
		call	ShowChat1Text
		jmp	short loc_11E96
; ---------------------------------------------------------------------------

loc_11E90:				; CODE XREF: seg000:1E86j
		mov	ax, 26h
		call	ShowMessageText	; [character] uses Mescaline D!

loc_11E96:				; CODE XREF: seg000:1E8Ej
		pop	ax
		retn
; ---------------------------------------------------------------------------

aiMsg04:				; DATA XREF: seg000:jmpTblActIMsgo
		push	ax
		test	byte ptr [si+1Ah], 1
		jz	short loc_11EA7
		mov	ax, 7
		call	ShowChat1Text
		jmp	short loc_11EAD
; ---------------------------------------------------------------------------

loc_11EA7:				; CODE XREF: seg000:1E9Dj
		mov	ax, 27h
		call	ShowMessageText	; [character] uses Barium Z!

loc_11EAD:				; CODE XREF: seg000:1EA5j
		pop	ax
		retn
; ---------------------------------------------------------------------------

aiMsg05:				; DATA XREF: seg000:jmpTblActIMsgo
		push	ax
		test	byte ptr [si+1Ah], 1
		jz	short loc_11EBE
		mov	ax, 8
		call	ShowChat1Text
		jmp	short loc_11EC4
; ---------------------------------------------------------------------------

loc_11EBE:				; CODE XREF: seg000:1EB4j
		mov	ax, 28h
		call	ShowMessageText	; [character] uses Mahiro Horumu Powder!

loc_11EC4:				; CODE XREF: seg000:1EBCj
		pop	ax
		retn
; ---------------------------------------------------------------------------

aiMsg06:				; DATA XREF: seg000:jmpTblActIMsgo
		push	ax
		test	byte ptr [si+1Ah], 1
		jz	short loc_11ED5
		mov	ax, 9
		call	ShowChat1Text
		jmp	short loc_11EDB
; ---------------------------------------------------------------------------

loc_11ED5:				; CODE XREF: seg000:1ECBj
		mov	ax, 2Bh
		call	ShowMessageText	; [character] uses Vitamin N!

loc_11EDB:				; CODE XREF: seg000:1ED3j
		pop	ax
		retn
; ---------------------------------------------------------------------------

aiMsg07:				; DATA XREF: seg000:jmpTblActIMsgo
		push	ax
		test	byte ptr [si+1Ah], 1
		jz	short loc_11EEC
		mov	ax, 0Ah
		call	ShowChat1Text
		jmp	short loc_11EF2
; ---------------------------------------------------------------------------

loc_11EEC:				; CODE XREF: seg000:1EE2j
		mov	ax, 2Ch
		call	ShowMessageText	; [character] uses Vitamin N Super!

loc_11EF2:				; CODE XREF: seg000:1EEAj
		pop	ax
		retn
; ---------------------------------------------------------------------------

aiMsg08:				; DATA XREF: seg000:jmpTblActIMsgo
		push	ax
		test	byte ptr [si+1Ah], 1
		jz	short loc_11F03
		mov	ax, 0Dh
		call	ShowChat1Text
		jmp	short loc_11F09
; ---------------------------------------------------------------------------

loc_11F03:				; CODE XREF: seg000:1EF9j
		mov	ax, 29h
		call	ShowMessageText	; [character] uses Protein V!

loc_11F09:				; CODE XREF: seg000:1F01j
		pop	ax
		retn
; ---------------------------------------------------------------------------

aiMsg09:				; DATA XREF: seg000:jmpTblActIMsgo
		push	ax
		test	byte ptr [si+1Ah], 1
		jz	short loc_11F1A
		mov	ax, 0Eh
		call	ShowChat1Text
		jmp	short loc_11F20
; ---------------------------------------------------------------------------

loc_11F1A:				; CODE XREF: seg000:1F10j
		mov	ax, 2Ah
		call	ShowMessageText	; [character] uses Kirara Kotei	Solution!

loc_11F20:				; CODE XREF: seg000:1F18j
		pop	ax
		retn
; ---------------------------------------------------------------------------

aiMsg0A:				; DATA XREF: seg000:jmpTblActIMsgo
		push	ax
		mov	ax, 34h
		call	ShowMessageText	; [enemy] sends	an emergency beacon to the sky!
		call	sub_12EEB
		call	ClearMessageBox
		call	SetDirectionText ; set a random	direction text
		mov	ax, 35h
		call	ShowMessageText	; The Black Cross Syringe Kamikaze Unit	appears	on the horizon,	flying in from the [dir]!
		pop	ax
		retn
; ---------------------------------------------------------------------------

aiMsg0B:				; DATA XREF: seg000:jmpTblActIMsgo
		retn
; ---------------------------------------------------------------------------

aiMsg0C:				; DATA XREF: seg000:jmpTblActIMsgo
		retn
; ---------------------------------------------------------------------------

aiMsg0D:				; DATA XREF: seg000:jmpTblActIMsgo
		push	ax
		mov	ax, 5
		call	ShowChat1Text
		pop	ax
		retn
; ---------------------------------------------------------------------------

aiMsg0E:				; DATA XREF: seg000:jmpTblActIMsgo
		push	ax
		mov	ax, 0Bh
		call	ShowChat1Text
		pop	ax
		retn
; ---------------------------------------------------------------------------

aiMsg0F:				; DATA XREF: seg000:jmpTblActIMsgo
		push	ax
		mov	ax, 0Ch
		call	ShowChat1Text
		pop	ax
		retn
; ---------------------------------------------------------------------------

aiMsg10:				; DATA XREF: seg000:jmpTblActIMsgo
		push	ax
		mov	ax, 0
		call	ShowChat1Text
		pop	ax
		retn
; ---------------------------------------------------------------------------

aiMsg11:				; DATA XREF: seg000:jmpTblActIMsgo
		push	ax
		mov	ax, 2
		call	ShowChat1Text
		pop	ax
		retn
; ---------------------------------------------------------------------------

aiMsg12:				; DATA XREF: seg000:jmpTblActIMsgo
		push	ax
		mov	ax, 1
		call	ShowChat1Text
		pop	ax
		retn
; ---------------------------------------------------------------------------

aiMsg13:				; DATA XREF: seg000:jmpTblActIMsgo
		push	ax
		mov	ax, 3
		call	ShowChat1Text
		pop	ax
		retn
; ---------------------------------------------------------------------------

aiMsg14:				; DATA XREF: seg000:jmpTblActIMsgo
		push	ax
		mov	ax, 4
		call	ShowChat1Text
		pop	ax
		retn

; =============== S U B	R O U T	I N E =======================================


ShowActMessage	proc near		; CODE XREF: ShowActMessage_a+11p
		push	ax
		push	bp
		push	es
		mov	bp, cs
		mov	es, bp
		assume es:seg000
		mov	bp, offset off_11F95
		call	CallJumpTbl
		pop	es
		assume es:nothing
		pop	bp
		pop	ax
		retn
ShowActMessage	endp

; ---------------------------------------------------------------------------
off_11F95	dw offset loc_11FBF	; 0 ; DATA XREF: ShowActMessage+7o
		dw offset loc_11FEE	; 1
		dw offset loc_1201D	; 2
		dw offset loc_12155	; 3
		dw offset loc_121A4	; 4
		dw offset loc_121F3	; 5
		dw offset locret_12242	; 6
		dw offset locret_12243	; 7
		dw offset locret_12244	; 8
		dw offset locret_12245	; 9
		dw offset DoSpecialAct	; 0Ah
		dw offset locret_122F3	; 0Bh
		dw offset locret_122F4	; 0Ch
		dw offset loc_122F5	; 0Dh
		dw offset locret_12335	; 0Eh
		dw offset locret_12336	; 0Fh
		dw offset loc_122F5	; 10h
		dw offset loc_122F5	; 11h
		dw offset loc_122F5	; 12h
		dw offset loc_122F5	; 13h
		dw offset loc_122F5	; 14h
; ---------------------------------------------------------------------------

loc_11FBF:				; DATA XREF: seg000:off_11F95o
		push	ax
		mov	ax, [di+49h]
		test	byte ptr [di+1Ah], 8
		jnz	short loc_11FEC
		test	byte ptr [di+4Fh], 1
		jz	short loc_11FDD
		or	ax, ax
		jz	short loc_11FD8
		mov	ax, 10h
		jmp	short loc_11FE6
; ---------------------------------------------------------------------------

loc_11FD8:				; CODE XREF: seg000:1FD1j
		mov	ax, 13h
		jmp	short loc_11FE6
; ---------------------------------------------------------------------------

loc_11FDD:				; CODE XREF: seg000:1FCDj
		test	byte ptr [di+4Fh], 2
		jz	short loc_11FEC
		mov	ax, 12h

loc_11FE6:				; CODE XREF: seg000:1FD6j seg000:1FDBj
		call	ShowChat1Text
		call	sub_12EEB

loc_11FEC:				; CODE XREF: seg000:1FC7j seg000:1FE1j
		pop	ax
		retn
; ---------------------------------------------------------------------------

loc_11FEE:				; DATA XREF: seg000:off_11F95o
		push	ax
		mov	ax, [di+49h]
		test	byte ptr [di+1Ah], 8
		jnz	short loc_1201B
		test	byte ptr [di+4Fh], 1
		jz	short loc_1200C
		or	ax, ax
		jz	short loc_12007
		mov	ax, 11h
		jmp	short loc_12015
; ---------------------------------------------------------------------------

loc_12007:				; CODE XREF: seg000:2000j
		mov	ax, 14h
		jmp	short loc_12015
; ---------------------------------------------------------------------------

loc_1200C:				; CODE XREF: seg000:1FFCj
		test	byte ptr [di+4Fh], 2
		jz	short loc_1201B
		mov	ax, 12h

loc_12015:				; CODE XREF: seg000:2005j seg000:200Aj
		call	ShowChat1Text
		call	sub_12EEB

loc_1201B:				; CODE XREF: seg000:1FF6j seg000:2010j
		pop	ax
		retn
; ---------------------------------------------------------------------------

loc_1201D:				; DATA XREF: seg000:off_11F95o
		push	ax
		push	bp
		push	es
		mov	al, [si+19h]
		mov	bp, cs
		mov	es, bp
		assume es:seg000
		mov	bp, offset off_12031
		call	CallJumpTbl
		pop	es
		assume es:nothing
		pop	bp
		pop	ax
		retn
; ---------------------------------------------------------------------------
off_12031	dw offset loc_12051	; 0 ; DATA XREF: seg000:2027o
		dw offset loc_12051	; 1
		dw offset loc_120A3	; 2
		dw offset loc_12051	; 3
		dw offset loc_12051	; 4
		dw offset loc_12051	; 5
		dw offset loc_120E9	; 6
		dw offset loc_12051	; 7
		dw offset loc_12080	; 8
		dw offset loc_120A3	; 9
		dw offset loc_1210C	; 0Ah
		dw offset loc_120C6	; 0Bh
		dw offset loc_12051	; 0Ch
		dw offset loc_1212F	; 0Dh
		dw offset loc_12051	; 0Eh
		dw offset loc_12051	; 0Fh
; ---------------------------------------------------------------------------

loc_12051:				; DATA XREF: seg000:off_12031o
		push	ax
		mov	ax, [di+49h]
		test	byte ptr [di+1Ah], 8
		jnz	short loc_1207E
		test	byte ptr [di+4Fh], 1
		jz	short loc_1206F
		or	ax, ax
		jz	short loc_1206A
		mov	ax, 10h
		jmp	short loc_12078
; ---------------------------------------------------------------------------

loc_1206A:				; CODE XREF: seg000:2063j
		mov	ax, 13h
		jmp	short loc_12078
; ---------------------------------------------------------------------------

loc_1206F:				; CODE XREF: seg000:205Fj
		test	byte ptr [di+4Fh], 2
		jz	short loc_1207E
		mov	ax, 12h

loc_12078:				; CODE XREF: seg000:2068j seg000:206Dj
		call	ShowChat1Text
		call	sub_12EEB

loc_1207E:				; CODE XREF: seg000:2059j seg000:2073j
		pop	ax
		retn
; ---------------------------------------------------------------------------

loc_12080:				; DATA XREF: seg000:off_12031o
		push	ax
		test	byte ptr [di+1Ah], 8
		jnz	short loc_120A1
		test	byte ptr [di+4Fh], 1
		jz	short loc_12092
		mov	ax, 15h
		jmp	short loc_1209B
; ---------------------------------------------------------------------------

loc_12092:				; CODE XREF: seg000:208Bj
		test	byte ptr [di+4Fh], 2
		jz	short loc_120A1
		mov	ax, 12h

loc_1209B:				; CODE XREF: seg000:2090j
		call	ShowChat1Text
		call	sub_12EEB

loc_120A1:				; CODE XREF: seg000:2085j seg000:2096j
		pop	ax
		retn
; ---------------------------------------------------------------------------

loc_120A3:				; DATA XREF: seg000:off_12031o
		push	ax
		test	byte ptr [di+1Ah], 8
		jnz	short loc_120C4
		test	byte ptr [di+4Fh], 1
		jz	short loc_120B5
		mov	ax, 16h
		jmp	short loc_120BE
; ---------------------------------------------------------------------------

loc_120B5:				; CODE XREF: seg000:20AEj
		test	byte ptr [di+4Fh], 2
		jz	short loc_120C4
		mov	ax, 12h

loc_120BE:				; CODE XREF: seg000:20B3j
		call	ShowChat1Text
		call	sub_12EEB

loc_120C4:				; CODE XREF: seg000:20A8j seg000:20B9j
		pop	ax
		retn
; ---------------------------------------------------------------------------

loc_120C6:				; DATA XREF: seg000:off_12031o
		push	ax
		test	byte ptr [di+1Ah], 8
		jnz	short loc_120E7
		test	byte ptr [di+4Fh], 1
		jz	short loc_120D8
		mov	ax, 17h
		jmp	short loc_120E1
; ---------------------------------------------------------------------------

loc_120D8:				; CODE XREF: seg000:20D1j
		test	byte ptr [di+4Fh], 2
		jz	short loc_120E7
		mov	ax, 12h

loc_120E1:				; CODE XREF: seg000:20D6j
		call	ShowChat1Text
		call	sub_12EEB

loc_120E7:				; CODE XREF: seg000:20CBj seg000:20DCj
		pop	ax
		retn
; ---------------------------------------------------------------------------

loc_120E9:				; DATA XREF: seg000:off_12031o
		push	ax
		test	byte ptr [di+1Ah], 8
		jnz	short loc_1210A
		test	byte ptr [di+4Fh], 1
		jz	short loc_120FB
		mov	ax, 18h
		jmp	short loc_12104
; ---------------------------------------------------------------------------

loc_120FB:				; CODE XREF: seg000:20F4j
		test	byte ptr [di+4Fh], 2
		jz	short loc_1210A
		mov	ax, 12h

loc_12104:				; CODE XREF: seg000:20F9j
		call	ShowChat1Text
		call	sub_12EEB

loc_1210A:				; CODE XREF: seg000:20EEj seg000:20FFj
		pop	ax
		retn
; ---------------------------------------------------------------------------

loc_1210C:				; DATA XREF: seg000:off_12031o
		push	ax
		test	byte ptr [di+1Ah], 8
		jnz	short loc_1212D
		test	byte ptr [di+4Fh], 1
		jz	short loc_1211E
		mov	ax, 20h	; ' '
		jmp	short loc_12127
; ---------------------------------------------------------------------------

loc_1211E:				; CODE XREF: seg000:2117j
		test	byte ptr [di+4Fh], 2
		jz	short loc_1212D
		mov	ax, 12h

loc_12127:				; CODE XREF: seg000:211Cj
		call	ShowChat1Text
		call	sub_12EEB

loc_1212D:				; CODE XREF: seg000:2111j seg000:2122j
		pop	ax
		retn
; ---------------------------------------------------------------------------

loc_1212F:				; DATA XREF: seg000:off_12031o
		push	ax
		test	byte ptr [di+1Ah], 8
		jnz	short loc_12153
		test	byte ptr [di+4Fh], 1
		jz	short loc_12144
		cmp	byte ptr [di+44h], 1Eh
		jb	short loc_12153
		jmp	short loc_12153
; ---------------------------------------------------------------------------

loc_12144:				; CODE XREF: seg000:213Aj
		test	byte ptr [di+4Fh], 2
		jz	short loc_12153
		mov	ax, 12h
		call	ShowChat1Text
		call	sub_12EEB

loc_12153:				; CODE XREF: seg000:2134j seg000:2140j ...
		pop	ax
		retn
; ---------------------------------------------------------------------------

loc_12155:				; DATA XREF: seg000:off_11F95o
		push	ax
		push	bx
		mov	bl, [di+1Ah]
		test	byte ptr [di+1Ah], 8
		jnz	short loc_121A1
		test	byte ptr [di+4Fh], 1
		jz	short loc_12170
		test	bl, 1
		jz	short loc_121A1
		mov	ax, 15h
		jmp	short loc_1219B
; ---------------------------------------------------------------------------

loc_12170:				; CODE XREF: seg000:2164j
		test	byte ptr [di+4Fh], 2
		jz	short loc_12180
		test	bl, 1
		jz	short loc_121A1
		mov	ax, 12h
		jmp	short loc_1219B
; ---------------------------------------------------------------------------

loc_12180:				; CODE XREF: seg000:2174j
		test	byte ptr [di+4Fh], 4
		jz	short loc_121A1
		test	bl, 1
		jnz	short loc_121A1
		mov	ax, 7
		xor	bh, bh
		mov	bl, [di+19h]
		call	ShowChat2Text
		call	sub_12EEB
		jmp	short loc_121A1
; ---------------------------------------------------------------------------

loc_1219B:				; CODE XREF: seg000:216Ej seg000:217Ej
		call	ShowChat1Text
		call	sub_12EEB

loc_121A1:				; CODE XREF: seg000:215Ej seg000:2169j ...
		pop	bx
		pop	ax
		retn
; ---------------------------------------------------------------------------

loc_121A4:				; DATA XREF: seg000:off_11F95o
		push	ax
		push	bx
		mov	bl, [di+1Ah]
		test	byte ptr [di+1Ah], 8
		jnz	short loc_121F0
		test	byte ptr [di+4Fh], 1
		jz	short loc_121BF
		test	bl, 1
		jz	short loc_121F0
		mov	ax, 16h
		jmp	short loc_121EA
; ---------------------------------------------------------------------------

loc_121BF:				; CODE XREF: seg000:21B3j
		test	byte ptr [di+4Fh], 2
		jz	short loc_121CF
		test	bl, 1
		jz	short loc_121F0
		mov	ax, 12h
		jmp	short loc_121EA
; ---------------------------------------------------------------------------

loc_121CF:				; CODE XREF: seg000:21C3j
		test	byte ptr [di+4Fh], 4
		jz	short loc_121F0
		test	bl, 1
		jnz	short loc_121F0
		mov	ax, 7
		xor	bh, bh
		mov	bl, [di+19h]
		call	ShowChat2Text
		call	sub_12EEB
		jmp	short loc_121F0
; ---------------------------------------------------------------------------

loc_121EA:				; CODE XREF: seg000:21BDj seg000:21CDj
		call	ShowChat1Text
		call	sub_12EEB

loc_121F0:				; CODE XREF: seg000:21ADj seg000:21B8j ...
		pop	bx
		pop	ax
		retn
; ---------------------------------------------------------------------------

loc_121F3:				; DATA XREF: seg000:off_11F95o
		push	ax
		push	bx
		mov	bl, [di+1Ah]
		test	byte ptr [di+1Ah], 8
		jnz	short loc_1223F
		test	byte ptr [di+4Fh], 1
		jz	short loc_1220E
		test	bl, 1
		jz	short loc_1223F
		mov	ax, 17h
		jmp	short loc_12239
; ---------------------------------------------------------------------------

loc_1220E:				; CODE XREF: seg000:2202j
		test	byte ptr [di+4Fh], 2
		jz	short loc_1221E
		test	bl, 1
		jz	short loc_1223F
		mov	ax, 12h
		jmp	short loc_12239
; ---------------------------------------------------------------------------

loc_1221E:				; CODE XREF: seg000:2212j
		test	byte ptr [di+4Fh], 4
		jz	short loc_1223F
		test	bl, 1
		jnz	short loc_1223F
		mov	ax, 7
		xor	bh, bh
		mov	bl, [di+19h]
		call	ShowChat2Text
		call	sub_12EEB
		jmp	short loc_1223F
; ---------------------------------------------------------------------------

loc_12239:				; CODE XREF: seg000:220Cj seg000:221Cj
		call	ShowChat1Text
		call	sub_12EEB

loc_1223F:				; CODE XREF: seg000:21FCj seg000:2207j ...
		pop	bx
		pop	ax
		retn
; ---------------------------------------------------------------------------

locret_12242:				; DATA XREF: seg000:off_11F95o
		retn
; ---------------------------------------------------------------------------

locret_12243:				; DATA XREF: seg000:off_11F95o
		retn
; ---------------------------------------------------------------------------

locret_12244:				; DATA XREF: seg000:off_11F95o
		retn
; ---------------------------------------------------------------------------

locret_12245:				; DATA XREF: seg000:off_11F95o
		retn
; ---------------------------------------------------------------------------

DoSpecialAct:				; DATA XREF: seg000:off_11F95o
		push	ax
		push	bp
		push	es
		mov	al, [si+50h]
		mov	bp, cs
		mov	es, bp
		assume es:seg000
		mov	bp, offset off_1225A
		call	CallJumpTbl
		pop	es
		assume es:nothing
		pop	bp
		pop	ax
		retn
; ---------------------------------------------------------------------------
off_1225A	dw offset spcAct00	; 0 ; DATA XREF: seg000:2250o
		dw offset spcAct01	; 1
		dw offset spcAct02	; 2
		dw offset spcAct03	; 3
		dw offset spcAct04	; 4
		dw offset spcAct05	; 5
		dw offset spcAct06	; 6
; ---------------------------------------------------------------------------

spcAct00:				; DATA XREF: seg000:off_1225Ao
		push	ax
		test	byte ptr [di+4Fh], 1
		jz	short loc_12278
		mov	ax, 3Dh
		call	ShowMessageText	; The Kamikaze Squad plows into	their target!
		call	sub_12EEB

loc_12278:				; CODE XREF: seg000:226Dj
		pop	ax
		retn
; ---------------------------------------------------------------------------

spcAct01:				; DATA XREF: seg000:off_1225Ao
		push	ax
		test	byte ptr [di+4Fh], 1
		jz	short loc_12296
		mov	ax, 36h
		call	ShowMessageText	; It's the plot twist of the century!
		call	sub_12EEB
		call	ClearMessageBox
		mov	ax, 37h
		call	ShowMessageText	; Dengeki Nurse's attack and defense have swapped with [enemy]'s!
		call	sub_12EEB

loc_12296:				; CODE XREF: seg000:227Fj
		pop	ax
		retn
; ---------------------------------------------------------------------------

spcAct02:				; DATA XREF: seg000:off_1225Ao
		push	ax
		test	byte ptr [si+4Fh], 1
		jz	short loc_122A8
		mov	ax, 38h
		call	ShowMessageText	; [character] got stabbed in the butt with Vitamin N Super!
		call	sub_12EEB

loc_122A8:				; CODE XREF: seg000:229Dj
		pop	ax
		retn
; ---------------------------------------------------------------------------

spcAct03:				; DATA XREF: seg000:off_1225Ao
		push	ax
		test	byte ptr [di+4Fh], 1
		jz	short loc_122BA
		mov	ax, 3Bh
		call	ShowMessageText	; Dengeki Nurse	was hit	by Bacillus 50!
		call	sub_12EEB

loc_122BA:				; CODE XREF: seg000:22AFj
		pop	ax
		retn
; ---------------------------------------------------------------------------

spcAct04:				; DATA XREF: seg000:off_1225Ao
		push	ax
		test	byte ptr [di+4Fh], 1
		jz	short loc_122CC
		mov	ax, 39h
		call	ShowMessageText	; Mahiro Horumu	comes flying at	[character]'s cute little butt!
		call	sub_12EEB

loc_122CC:				; CODE XREF: seg000:22C1j
		pop	ax
		retn
; ---------------------------------------------------------------------------

spcAct05:				; DATA XREF: seg000:off_1225Ao
		push	ax
		test	byte ptr [di+4Fh], 1
		jz	short loc_122F0
		mov	ax, 3Ah
		call	ShowMessageText	; A powerful EM	wave is	deployed! Dengeki Nurse	uses 50% of her	Plasma Power!
		call	sub_12EEB
		cmp	byte ptr [di+44h], 30
		jb	short loc_122F0
		call	ClearMessageBox
		mov	ax, 1Fh
		call	ShowChat1Text
		call	sub_12EEB

loc_122F0:				; CODE XREF: seg000:22D3j seg000:22E2j
		pop	ax
		retn
; ---------------------------------------------------------------------------

spcAct06:				; DATA XREF: seg000:off_1225Ao
		retn
; ---------------------------------------------------------------------------

locret_122F3:				; DATA XREF: seg000:off_11F95o
		retn
; ---------------------------------------------------------------------------

locret_122F4:				; DATA XREF: seg000:off_11F95o
		retn
; ---------------------------------------------------------------------------

loc_122F5:				; DATA XREF: seg000:off_11F95o
		push	ax
		push	bx
		mov	ax, [di+49h]
		test	byte ptr [di+4Fh], 1
		jz	short loc_1230E
		or	ax, ax
		jz	short loc_12309
		mov	ax, 3
		jmp	short loc_12327
; ---------------------------------------------------------------------------

loc_12309:				; CODE XREF: seg000:2302j
		mov	ax, 5
		jmp	short loc_12327
; ---------------------------------------------------------------------------

loc_1230E:				; CODE XREF: seg000:22FEj
		test	byte ptr [di+4Fh], 2
		jz	short loc_12319
		mov	ax, 4
		jmp	short loc_12327
; ---------------------------------------------------------------------------

loc_12319:				; CODE XREF: seg000:2312j
		test	byte ptr [di+4Fh], 4
		jz	short loc_12332
		test	bl, 1
		jnz	short loc_12332
		mov	ax, 7

loc_12327:				; CODE XREF: seg000:2307j seg000:230Cj ...
		xor	bh, bh
		mov	bl, [di+19h]
		call	ShowChat2Text
		call	sub_12EEB

loc_12332:				; CODE XREF: seg000:231Dj seg000:2322j
		pop	bx
		pop	ax
		retn
; ---------------------------------------------------------------------------

locret_12335:				; DATA XREF: seg000:off_11F95o
		retn
; ---------------------------------------------------------------------------

locret_12336:				; DATA XREF: seg000:off_11F95o
		retn

; =============== S U B	R O U T	I N E =======================================


ShowActResult	proc near		; CODE XREF: ShowActResult_A+7p
		push	ax
		push	bp
		push	es
		mov	bp, cs
		mov	es, bp
		assume es:seg000
		mov	bp, offset jmpTblActMsg
		call	CallJumpTbl
		pop	es
		assume es:nothing
		pop	bp
		pop	ax
		retn
ShowActResult	endp

; ---------------------------------------------------------------------------
jmpTblActMsg	dw offset saMsg00_EnemyAtk; 0 ;	DATA XREF: ShowActResult+7o
		dw offset saMsg01_EnemyAtk; 1
		dw offset saMsg02_EnmSpecific; 2
		dw offset saMsg03_AtkReduce; 3
		dw offset saMsg04_DefReduce; 4
		dw offset saMsg05_Paralyze; 5
		dw offset saMsg06_Heal	; 6
		dw offset saMsg07_FullHeal; 7
		dw offset saMsg08_AtkInc; 8
		dw offset saMsg09_DefInc; 9
		dw offset saMsg0A_EnmSpecial; 0Ah
		dw offset locret_12843	; 0Bh
		dw offset locret_12844	; 0Ch
		dw offset saMsg0D_PlasmaFlash; 0Dh
		dw offset saMsg0E_Electrode; 0Eh
		dw offset saMsg0F_PlasmaCharge;	0Fh
		dw offset saMsg10_PlayerAtk; 10h
		dw offset saMsg11_DgkShuriken; 11h
		dw offset saMsg10_PlayerAtk; 12h
		dw offset saMsg13_DgkScalpel; 13h
		dw offset saMsg10_PlayerAtk; 14h
; ---------------------------------------------------------------------------

saMsg00_EnemyAtk:			; DATA XREF: seg000:jmpTblActMsgo
		push	ax
		mov	ax, [di+49h]
		test	byte ptr [di+1Ah], 8
		jz	short loc_12384
		call	DrawInt_Buf1
		mov	ax, 23h		; [enemy] takes	[N1] points of damage!
		jmp	short loc_123A4
; ---------------------------------------------------------------------------

loc_12384:				; CODE XREF: seg000:237Aj
		test	byte ptr [di+4Fh], 1
		jz	short loc_1239B
		or	ax, ax
		jz	short loc_12396
		call	DrawInt_Buf1
		mov	ax, 19h		; [Dengeki Nurse] takes	[N1] points of damage...
		jmp	short loc_123A4
; ---------------------------------------------------------------------------

loc_12396:				; CODE XREF: seg000:238Cj
		mov	ax, 1Ah		; [Dengeki Nurse] didn't take any damage!
		jmp	short loc_123A4
; ---------------------------------------------------------------------------

loc_1239B:				; CODE XREF: seg000:2388j
		test	byte ptr [di+4Fh], 2
		jz	short loc_123AA
		mov	ax, 1Bh		; [Dengeki Nurse] dodged the attack!

loc_123A4:				; CODE XREF: seg000:2382j seg000:2394j ...
		call	ShowMessageText	; show attack reception	message
		call	sub_12EEB

loc_123AA:				; CODE XREF: seg000:239Fj
		pop	ax
		retn
; ---------------------------------------------------------------------------

saMsg01_EnemyAtk:			; DATA XREF: seg000:jmpTblActMsgo
		push	ax
		mov	ax, [di+49h]
		test	byte ptr [di+1Ah], 8
		jz	short loc_123BE
		call	DrawInt_Buf1
		mov	ax, 23h		; [enemy] takes	[N1] points of damage!
		jmp	short loc_123DE
; ---------------------------------------------------------------------------

loc_123BE:				; CODE XREF: seg000:23B4j
		test	byte ptr [di+4Fh], 1
		jz	short loc_123D5
		or	ax, ax
		jz	short loc_123D0
		call	DrawInt_Buf1
		mov	ax, 19h		; [Dengeki Nurse] takes	[N1] points of damage...
		jmp	short loc_123DE
; ---------------------------------------------------------------------------

loc_123D0:				; CODE XREF: seg000:23C6j
		mov	ax, 1Ah		; [Dengeki Nurse] didn't take any damage!
		jmp	short loc_123DE
; ---------------------------------------------------------------------------

loc_123D5:				; CODE XREF: seg000:23C2j
		test	byte ptr [di+4Fh], 2
		jz	short loc_123E4
		mov	ax, 1Bh		; [Dengeki Nurse] dodged the attack!

loc_123DE:				; CODE XREF: seg000:23BCj seg000:23CEj ...
		call	ShowMessageText	; show attack reception	message
		call	sub_12EEB

loc_123E4:				; CODE XREF: seg000:23D9j
		pop	ax
		retn
; ---------------------------------------------------------------------------

saMsg02_EnmSpecific:			; DATA XREF: seg000:jmpTblActMsgo
		push	ax
		push	bp
		push	es
		mov	al, [si+19h]
		mov	bp, cs
		mov	es, bp
		assume es:seg000
		mov	bp, offset off_123FA
		call	CallJumpTbl
		pop	es
		assume es:nothing
		pop	bp
		pop	ax
		retn
; ---------------------------------------------------------------------------
off_123FA	dw offset loc_1241A	; 0 ; DATA XREF: seg000:23F0o
		dw offset loc_1241A	; 1
		dw offset loc_12482	; 2
		dw offset loc_1241A	; 3
		dw offset loc_1241A	; 4
		dw offset loc_1241A	; 5
		dw offset loc_124D8	; 6
		dw offset loc_1241A	; 7
		dw offset loc_12454	; 8
		dw offset loc_12482	; 9
		dw offset loc_12500	; 0Ah
		dw offset loc_124B0	; 0Bh
		dw offset loc_1241A	; 0Ch
		dw offset loc_12528	; 0Dh
		dw offset loc_1241A	; 0Eh
		dw offset loc_1241A	; 0Fh
; ---------------------------------------------------------------------------

loc_1241A:				; DATA XREF: seg000:off_123FAo
		push	ax
		mov	ax, [di+49h]
		test	byte ptr [di+1Ah], 8
		jz	short loc_1242C
		call	DrawInt_Buf1
		mov	ax, 23h		; [enemy] takes	[N1] points of damage!
		jmp	short loc_1244C
; ---------------------------------------------------------------------------

loc_1242C:				; CODE XREF: seg000:2422j
		test	byte ptr [di+4Fh], 1
		jz	short loc_12443
		or	ax, ax
		jz	short loc_1243E
		call	DrawInt_Buf1
		mov	ax, 19h		; [Dengeki Nurse] takes	[N1] points of damage...
		jmp	short loc_1244C
; ---------------------------------------------------------------------------

loc_1243E:				; CODE XREF: seg000:2434j
		mov	ax, 1Ah		; [Dengeki Nurse] didn't take any damage!
		jmp	short loc_1244C
; ---------------------------------------------------------------------------

loc_12443:				; CODE XREF: seg000:2430j
		test	byte ptr [di+4Fh], 2
		jz	short loc_12452
		mov	ax, 1Bh		; [Dengeki Nurse] dodged the attack!

loc_1244C:				; CODE XREF: seg000:242Aj seg000:243Cj ...
		call	ShowMessageText	; show attack reception	message
		call	sub_12EEB

loc_12452:				; CODE XREF: seg000:2447j
		pop	ax
		retn
; ---------------------------------------------------------------------------

loc_12454:				; DATA XREF: seg000:off_123FAo
		push	ax
		mov	ax, [di+4Bh]
		test	byte ptr [di+1Ah], 8
		jz	short loc_12463
		mov	ax, 24h		; The attack had no effect on [Electrode 2]!
		jmp	short loc_1247A
; ---------------------------------------------------------------------------

loc_12463:				; CODE XREF: seg000:245Cj
		test	byte ptr [di+4Fh], 1
		jz	short loc_12471
		call	DrawInt_Buf1
		mov	ax, 1Ch		; [Dengeki Nurse] attack reduced by [N1] points!
		jmp	short loc_1247A
; ---------------------------------------------------------------------------

loc_12471:				; CODE XREF: seg000:2467j
		test	byte ptr [di+4Fh], 2
		jz	short loc_12480
		mov	ax, 1Bh		; [Dengeki Nurse] dodged the attack!

loc_1247A:				; CODE XREF: seg000:2461j seg000:246Fj
		call	ShowMessageText	; show attack reduction	message
		call	sub_12EEB

loc_12480:				; CODE XREF: seg000:2475j
		pop	ax
		retn
; ---------------------------------------------------------------------------

loc_12482:				; DATA XREF: seg000:off_123FAo
		push	ax
		mov	ax, [di+4Dh]
		test	byte ptr [di+1Ah], 8
		jz	short loc_12491
		mov	ax, 24h		; The attack had no effect on [Electrode 2]!
		jmp	short loc_124A8
; ---------------------------------------------------------------------------

loc_12491:				; CODE XREF: seg000:248Aj
		test	byte ptr [di+4Fh], 1
		jz	short loc_1249F
		call	DrawInt_Buf1
		mov	ax, 1Dh		; [Dengeki Nurse] defense reduced by [N1] points!
		jmp	short loc_124A8
; ---------------------------------------------------------------------------

loc_1249F:				; CODE XREF: seg000:2495j
		test	byte ptr [di+4Fh], 2
		jz	short loc_124AE
		mov	ax, 1Bh		; [Dengeki Nurse] dodged the attack!

loc_124A8:				; CODE XREF: seg000:248Fj seg000:249Dj
		call	ShowMessageText	; show defense reduction message
		call	sub_12EEB

loc_124AE:				; CODE XREF: seg000:24A3j
		pop	ax
		retn
; ---------------------------------------------------------------------------

loc_124B0:				; DATA XREF: seg000:off_123FAo
		push	ax
		test	byte ptr [di+1Ah], 8
		jz	short loc_124BC
		mov	ax, 24h		; The attack had no effect on [Electrode 2]!
		jmp	short loc_124D0
; ---------------------------------------------------------------------------

loc_124BC:				; CODE XREF: seg000:24B5j
		test	byte ptr [di+4Fh], 1
		jz	short loc_124C7
		mov	ax, 1Eh		; [Dengeki Nurse] is paralyzed!
		jmp	short loc_124D0
; ---------------------------------------------------------------------------

loc_124C7:				; CODE XREF: seg000:24C0j
		test	byte ptr [di+4Fh], 2
		jz	short loc_124D6
		mov	ax, 1Bh		; [Dengeki Nurse] dodged the attack!

loc_124D0:				; CODE XREF: seg000:24BAj seg000:24C5j
		call	ShowMessageText	; show paralyze	message
		call	sub_12EEB

loc_124D6:				; CODE XREF: seg000:24CBj
		pop	ax
		retn
; ---------------------------------------------------------------------------

loc_124D8:				; DATA XREF: seg000:off_123FAo
		push	ax
		test	byte ptr [di+1Ah], 8
		jz	short loc_124E4
		mov	ax, 24h		; The attack had no effect on [Electrode 2]!
		jmp	short loc_124F8
; ---------------------------------------------------------------------------

loc_124E4:				; CODE XREF: seg000:24DDj
		test	byte ptr [di+4Fh], 1
		jz	short loc_124EF
		mov	ax, 6		; The drug has become a	sticky mess!
		jmp	short loc_124F8
; ---------------------------------------------------------------------------

loc_124EF:				; CODE XREF: seg000:24E8j
		test	byte ptr [di+4Fh], 2
		jz	short loc_124FE
		mov	ax, 1Bh		; [Dengeki Nurse] dodged the attack!

loc_124F8:				; CODE XREF: seg000:24E2j seg000:24EDj
		call	ShowMessageText	; show attack reception	message
		call	sub_12EEB

loc_124FE:				; CODE XREF: seg000:24F3j
		pop	ax
		retn
; ---------------------------------------------------------------------------

loc_12500:				; DATA XREF: seg000:off_123FAo
		push	ax
		test	byte ptr [di+1Ah], 8
		jz	short loc_1250C
		mov	ax, 24h		; The attack had no effect on [Electrode 2]!
		jmp	short loc_12520
; ---------------------------------------------------------------------------

loc_1250C:				; CODE XREF: seg000:2505j
		test	byte ptr [di+4Fh], 1
		jz	short loc_12517
		mov	ax, 1Fh		; [Dengeki Nurse] can't concentrate! She is unable to Plasma Charge!
		jmp	short loc_12520
; ---------------------------------------------------------------------------

loc_12517:				; CODE XREF: seg000:2510j
		test	byte ptr [di+4Fh], 2
		jz	short loc_12526
		mov	ax, 1Bh		; [Dengeki Nurse] dodged the attack!

loc_12520:				; CODE XREF: seg000:250Aj seg000:2515j
		call	ShowMessageText	; show concentration loss message
		call	sub_12EEB

loc_12526:				; CODE XREF: seg000:251Bj
		pop	ax
		retn
; ---------------------------------------------------------------------------

loc_12528:				; DATA XREF: seg000:off_123FAo
		push	ax
		test	byte ptr [di+1Ah], 8
		jz	short loc_12534
		mov	ax, 24h		; The attack had no effect on [Electrode 2]!
		jmp	short loc_12567
; ---------------------------------------------------------------------------

loc_12534:				; CODE XREF: seg000:252Dj
		test	byte ptr [di+4Fh], 1
		jz	short loc_12559
		cmp	byte ptr [di+44h], 30
		jb	short loc_12554
		mov	ax, 3Fh
		call	ShowMessageText	; Powerful EM waves erupt! Dengeki Nurse's Plasma Power was pilfered!
		call	sub_12EEB
		call	ClearMessageBox
		mov	ax, 1Fh
		call	ShowChat1Text
		jmp	short loc_1256A
; ---------------------------------------------------------------------------

loc_12554:				; CODE XREF: seg000:253Ej
		mov	ax, 40h		; The plasma waves won't collect!"
		jmp	short loc_12567
; ---------------------------------------------------------------------------

loc_12559:				; CODE XREF: seg000:2538j
		test	byte ptr [di+4Fh], 2
		jz	short loc_1256D
		mov	ax, 12h
		call	ShowChat1Text
		jmp	short loc_1256A
; ---------------------------------------------------------------------------

loc_12567:				; CODE XREF: seg000:2532j seg000:2557j
		call	ShowMessageText	; show EM wave attack message

loc_1256A:				; CODE XREF: seg000:2552j seg000:2565j
		call	sub_12EEB

loc_1256D:				; CODE XREF: seg000:255Dj
		pop	ax
		retn
; ---------------------------------------------------------------------------

saMsg03_AtkReduce:			; DATA XREF: seg000:jmpTblActMsgo
		push	ax
		push	bx
		mov	ax, [di+4Bh]
		mov	bl, [di+1Ah]
		test	byte ptr [di+1Ah], 8
		jz	short loc_12582
		mov	ax, 24h		; The attack had no effect on [Electrode 2]!
		jmp	short loc_125BC
; ---------------------------------------------------------------------------

loc_12582:				; CODE XREF: seg000:257Bj
		test	byte ptr [di+4Fh], 1
		jz	short loc_12598
		call	DrawInt_Buf1
		mov	ax, 0Fh		; [Dengeki Nurse] lowered [enemy]'s attack by [N1] points!
		test	bl, 1
		jz	short loc_12596
		mov	ax, 1Ch		; [Dengeki Nurse] attack reduced by [N1] points!

loc_12596:				; CODE XREF: seg000:2591j
		jmp	short loc_125BC
; ---------------------------------------------------------------------------

loc_12598:				; CODE XREF: seg000:2586j
		test	byte ptr [di+4Fh], 2
		jz	short loc_125AB
		mov	ax, 0Eh		; [Dengeki Nurse]'s attack was dodged!
		test	bl, 1
		jz	short loc_125A9
		mov	ax, 1Bh		; [Dengeki Nurse] dodged the attack!

loc_125A9:				; CODE XREF: seg000:25A4j
		jmp	short loc_125BC
; ---------------------------------------------------------------------------

loc_125AB:				; CODE XREF: seg000:259Cj
		test	byte ptr [di+4Fh], 4
		jz	short loc_125C2
		mov	ax, 1Bh		; [Dengeki Nurse] dodged the attack!
		test	bl, 1
		jnz	short loc_125BC
		mov	ax, 12h		; [Dengeki Nurse]'s drug has no effect!

loc_125BC:				; CODE XREF: seg000:2580j
					; seg000:loc_12596j ...
		call	ShowMessageText	; show attack reduction	message
		call	sub_12EEB

loc_125C2:				; CODE XREF: seg000:25AFj
		pop	bx
		pop	ax
		retn
; ---------------------------------------------------------------------------

saMsg04_DefReduce:			; DATA XREF: seg000:jmpTblActMsgo
		push	ax
		push	bx
		mov	ax, [di+4Dh]
		mov	bl, [di+1Ah]
		test	byte ptr [di+1Ah], 8
		jz	short loc_125D8
		mov	ax, 24h		; The attack had no effect on [Electrode 2]!
		jmp	short loc_12612
; ---------------------------------------------------------------------------

loc_125D8:				; CODE XREF: seg000:25D1j
		test	byte ptr [di+4Fh], 1
		jz	short loc_125EE
		call	DrawInt_Buf1
		mov	ax, 10h		; [Dengeki Nurse] lowered [enemy]'s defense by [N1] points!
		test	bl, 1
		jz	short loc_125EC
		mov	ax, 1Dh		; [Dengeki Nurse] defense reduced by [N1] points!

loc_125EC:				; CODE XREF: seg000:25E7j
		jmp	short loc_12612
; ---------------------------------------------------------------------------

loc_125EE:				; CODE XREF: seg000:25DCj
		test	byte ptr [di+4Fh], 2
		jz	short loc_12601
		mov	ax, 0Eh		; [Dengeki Nurse]'s attack was dodged!
		test	bl, 1
		jz	short loc_125FF
		mov	ax, 1Bh		; [Dengeki Nurse] dodged the attack!

loc_125FF:				; CODE XREF: seg000:25FAj
		jmp	short loc_12612
; ---------------------------------------------------------------------------

loc_12601:				; CODE XREF: seg000:25F2j
		test	byte ptr [di+4Fh], 4
		jz	short loc_12618
		mov	ax, 1Bh		; [Dengeki Nurse] dodged the attack!
		test	bl, 1
		jnz	short loc_12612
		mov	ax, 12h		; [Dengeki Nurse]'s drug has no effect!

loc_12612:				; CODE XREF: seg000:25D6j
					; seg000:loc_125ECj ...
		call	ShowMessageText	; show defense reduction message
		call	sub_12EEB

loc_12618:				; CODE XREF: seg000:2605j
		pop	bx
		pop	ax
		retn
; ---------------------------------------------------------------------------

saMsg05_Paralyze:			; DATA XREF: seg000:jmpTblActMsgo
		push	ax
		push	bx
		mov	bl, [di+1Ah]
		test	byte ptr [di+1Ah], 8
		jz	short loc_1262B
		mov	ax, 24h		; The attack had no effect on [Electrode 2]!
		jmp	short loc_12662
; ---------------------------------------------------------------------------

loc_1262B:				; CODE XREF: seg000:2624j
		test	byte ptr [di+4Fh], 1
		jz	short loc_1263E
		mov	ax, 11h		; [Dengeki Nurse] has [enemy] paralyzed!
		test	bl, 1
		jz	short loc_1263C
		mov	ax, 1Eh		; [Dengeki Nurse] is paralyzed!

loc_1263C:				; CODE XREF: seg000:2637j
		jmp	short loc_12662
; ---------------------------------------------------------------------------

loc_1263E:				; CODE XREF: seg000:262Fj
		test	byte ptr [di+4Fh], 2
		jz	short loc_12651
		mov	ax, 0Eh		; [Dengeki Nurse]'s attack was dodged!
		test	bl, 1
		jz	short loc_1264F
		mov	ax, 1Bh		; [Dengeki Nurse] dodged the attack!

loc_1264F:				; CODE XREF: seg000:264Aj
		jmp	short loc_12662
; ---------------------------------------------------------------------------

loc_12651:				; CODE XREF: seg000:2642j
		test	byte ptr [di+4Fh], 4
		jz	short loc_12668
		mov	ax, 1Bh		; [Dengeki Nurse] dodged the attack!
		test	bl, 1
		jnz	short loc_12662
		mov	ax, 12h		; [Dengeki Nurse]'s drug has no effect!

loc_12662:				; CODE XREF: seg000:2629j
					; seg000:loc_1263Cj ...
		call	ShowMessageText	; show paralyze	message
		call	sub_12EEB

loc_12668:				; CODE XREF: seg000:2655j
		pop	bx
		pop	ax
		retn
; ---------------------------------------------------------------------------

saMsg06_Heal:				; DATA XREF: seg000:jmpTblActMsgo
		push	ax
		push	bx
		mov	ax, [si+49h]
		not	ax
		mov	bl, [si+1Ah]
		test	byte ptr [si+4Fh], 1
		jz	short loc_126A4
		call	DrawInt_Buf1
		mov	ax, [si+1Bh]
		cmp	ax, [si+1Dh]
		jz	short loc_12693
		mov	ax, 30h		; [enemy] recovers [N1]	points of health!
		test	bl, 1
		jz	short loc_12691
		mov	ax, 13h		; [Dengeki Nurse] recovers [N1]	points of health...

loc_12691:				; CODE XREF: seg000:268Cj
		jmp	short loc_1269E
; ---------------------------------------------------------------------------

loc_12693:				; CODE XREF: seg000:2684j
		mov	ax, 2Dh		; [enemy]'s health is fully restored!
		test	bl, 1
		jz	short loc_1269E
		mov	ax, 14h		; [Dengeki Nurse]'s health is fully restored...

loc_1269E:				; CODE XREF: seg000:loc_12691j
					; seg000:2699j
		call	ShowMessageText	; show health restore message
		call	sub_12EEB

loc_126A4:				; CODE XREF: seg000:2679j
		pop	bx
		pop	ax
		retn
; ---------------------------------------------------------------------------

saMsg07_FullHeal:			; DATA XREF: seg000:jmpTblActMsgo
		push	ax
		push	bx
		mov	bl, [si+1Ah]
		test	byte ptr [si+4Fh], 1
		jz	short loc_126C3
		mov	ax, 2Dh		; [enemy]'s health is fully restored!
		test	bl, 1
		jz	short loc_126BD
		mov	ax, 14h		; [Dengeki Nurse]'s health is fully restored...

loc_126BD:				; CODE XREF: seg000:26B8j
		call	ShowMessageText	; show health restore message
		call	sub_12EEB

loc_126C3:				; CODE XREF: seg000:26B0j
		pop	bx
		pop	ax
		retn
; ---------------------------------------------------------------------------

saMsg08_AtkInc:				; DATA XREF: seg000:jmpTblActMsgo
		push	ax
		push	bx
		mov	ax, [si+4Bh]
		not	ax
		mov	bl, [si+1Ah]
		test	byte ptr [si+4Fh], 1
		jz	short loc_126EA
		call	DrawInt_Buf1
		mov	ax, 2Eh		; [enemy]'s attack increased by [N1]!
		test	bl, 1
		jz	short loc_126E4
		mov	ax, 15h		; [Dengeki Nurse]'s attack increased by [N1]...

loc_126E4:				; CODE XREF: seg000:26DFj
		call	ShowMessageText	; show attack increase message
		call	sub_12EEB

loc_126EA:				; CODE XREF: seg000:26D4j
		pop	bx
		pop	ax
		retn
; ---------------------------------------------------------------------------

saMsg09_DefInc:				; DATA XREF: seg000:jmpTblActMsgo
		push	ax
		push	bx
		mov	ax, [si+4Dh]
		not	ax
		mov	bl, [si+1Ah]
		test	byte ptr [si+4Fh], 1
		jz	short loc_12711
		call	DrawInt_Buf1
		mov	ax, 2Fh		; [enemy]'s defense increased by [N1]!
		test	bl, 1
		jz	short loc_1270B
		mov	ax, 16h		; [Dengeki Nurse]'s defense increased by [N1]...

loc_1270B:				; CODE XREF: seg000:2706j
		call	ShowMessageText	; show defense increase	message
		call	sub_12EEB

loc_12711:				; CODE XREF: seg000:26FBj
		pop	bx
		pop	ax
		retn
; ---------------------------------------------------------------------------

saMsg0A_EnmSpecial:			; DATA XREF: seg000:jmpTblActMsgo
		push	ax
		push	bp
		push	es
		mov	al, [si+50h]
		mov	bp, cs
		mov	es, bp
		assume es:seg000
		mov	bp, offset off_12728
		call	CallJumpTbl
		pop	es
		assume es:nothing
		pop	bp
		pop	ax
		retn
; ---------------------------------------------------------------------------
off_12728	dw offset loc_12736	; 0 ; DATA XREF: seg000:271Eo
		dw offset loc_12770	; 1
		dw offset loc_127B9	; 2
		dw offset loc_127D0	; 3
		dw offset loc_12803	; 4
		dw offset locret_12836	; 5
		dw offset loc_12837	; 6
; ---------------------------------------------------------------------------

loc_12736:				; DATA XREF: seg000:off_12728o
		push	ax
		mov	ax, [di+49h]
		test	byte ptr [di+1Ah], 8
		jz	short loc_12748
		call	DrawInt_Buf1
		mov	ax, 23h		; [enemy] takes	[N1] points of damage!
		jmp	short loc_12768
; ---------------------------------------------------------------------------

loc_12748:				; CODE XREF: seg000:273Ej
		test	byte ptr [di+4Fh], 1
		jz	short loc_1275F
		or	ax, ax
		jz	short loc_1275A
		call	DrawInt_Buf1
		mov	ax, 19h		; [Dengeki Nurse] takes	[N1] points of damage...
		jmp	short loc_12768
; ---------------------------------------------------------------------------

loc_1275A:				; CODE XREF: seg000:2750j
		mov	ax, 1Ah		; [Dengeki Nurse] didn't take any damage!
		jmp	short loc_12768
; ---------------------------------------------------------------------------

loc_1275F:				; CODE XREF: seg000:274Cj
		test	byte ptr [di+4Fh], 2
		jz	short loc_1276E
		mov	ax, 1Bh		; [Dengeki Nurse] dodged the attack!

loc_12768:				; CODE XREF: seg000:2746j seg000:2758j ...
		call	ShowMessageText	; show attack reception	message
		call	sub_12EEB

loc_1276E:				; CODE XREF: seg000:2763j
		pop	ax
		retn
; ---------------------------------------------------------------------------

loc_12770:				; DATA XREF: seg000:off_12728o
		push	ax
		push	bx
		test	byte ptr [di+1Ah], 8
		jz	short loc_1277D
		mov	ax, 24h		; The attack had no effect on [Electrode 2]!
		jmp	short loc_127B0
; ---------------------------------------------------------------------------

loc_1277D:				; CODE XREF: seg000:2776j
		test	byte ptr [di+4Fh], 1
		jz	short loc_127A7
		mov	ax, [si+21h]
		add	ax, [si+27h]
		mov	bx, [di+21h]
		add	bx, [di+27h]
		cmp	ax, bx
		ja	short loc_1279A
		jb	short loc_1279F
		mov	ax, 1Dh		; [Dengeki Nurse] defense reduced by [N1] points!
		jmp	short loc_127A2
; ---------------------------------------------------------------------------

loc_1279A:				; CODE XREF: seg000:2791j
		mov	ax, 1Bh		; [Dengeki Nurse] dodged the attack!
		jmp	short loc_127A2
; ---------------------------------------------------------------------------

loc_1279F:				; CODE XREF: seg000:2793j
		mov	ax, 1Ch		; [Dengeki Nurse] attack reduced by [N1] points!

loc_127A2:				; CODE XREF: seg000:2798j seg000:279Dj
		call	ShowChat1Text
		jmp	short loc_127B3
; ---------------------------------------------------------------------------

loc_127A7:				; CODE XREF: seg000:2781j
		test	byte ptr [di+4Fh], 2
		jz	short loc_127B6
		mov	ax, 1Bh		; [Dengeki Nurse] dodged the attack!

loc_127B0:				; CODE XREF: seg000:277Bj
		call	ShowMessageText	; show attack reduction	message

loc_127B3:				; CODE XREF: seg000:27A5j
		call	sub_12EEB

loc_127B6:				; CODE XREF: seg000:27ABj
		pop	bx
		pop	ax
		retn
; ---------------------------------------------------------------------------

loc_127B9:				; DATA XREF: seg000:off_12728o
		push	ax
		push	bx
		mov	bl, [si+1Ah]
		test	byte ptr [si+4Fh], 1
		jz	short loc_127CD
		mov	ax, 2Dh
		call	ShowMessageText	; [enemy]'s health is fully restored!
		call	sub_12EEB

loc_127CD:				; CODE XREF: seg000:27C2j
		pop	bx
		pop	ax
		retn
; ---------------------------------------------------------------------------

loc_127D0:				; DATA XREF: seg000:off_12728o
		push	ax
		test	byte ptr [di+1Ah], 8
		jz	short loc_127DC
		mov	ax, 24h		; The attack had no effect on [Electrode 2]!
		jmp	short loc_127FB
; ---------------------------------------------------------------------------

loc_127DC:				; CODE XREF: seg000:27D5j
		test	byte ptr [di+4Fh], 1
		jz	short loc_127E7
		mov	ax, 3Ch		; 50% of [Dengeki Nurse]'s health was transferred to [enemy]!
		jmp	short loc_127FB
; ---------------------------------------------------------------------------

loc_127E7:				; CODE XREF: seg000:27E0j
		test	byte ptr [di+4Fh], 2
		jz	short loc_127F2
		mov	ax, 1Bh		; [Dengeki Nurse] dodged the attack!
		jmp	short loc_127FB
; ---------------------------------------------------------------------------

loc_127F2:				; CODE XREF: seg000:27EBj
		test	byte ptr [di+4Fh], 4
		jz	short loc_12801
		mov	ax, 1Bh		; [Dengeki Nurse] dodged the attack!

loc_127FB:				; CODE XREF: seg000:27DAj seg000:27E5j ...
		call	ShowMessageText	; show health transfer message
		call	sub_12EEB

loc_12801:				; CODE XREF: seg000:27F6j
		pop	ax
		retn
; ---------------------------------------------------------------------------

loc_12803:				; DATA XREF: seg000:off_12728o
		push	ax
		test	byte ptr [di+1Ah], 8
		jz	short loc_1280F
		mov	ax, 24h		; The attack had no effect on [Electrode 2]!
		jmp	short loc_1282E
; ---------------------------------------------------------------------------

loc_1280F:				; CODE XREF: seg000:2808j
		test	byte ptr [di+4Fh], 1
		jz	short loc_1281A
		mov	ax, 1Eh		; [Dengeki Nurse] is paralyzed!
		jmp	short loc_1282E
; ---------------------------------------------------------------------------

loc_1281A:				; CODE XREF: seg000:2813j
		test	byte ptr [di+4Fh], 2
		jz	short loc_12825
		mov	ax, 1Bh		; [Dengeki Nurse] dodged the attack!
		jmp	short loc_1282E
; ---------------------------------------------------------------------------

loc_12825:				; CODE XREF: seg000:281Ej
		test	byte ptr [di+4Fh], 4
		jz	short loc_12834
		mov	ax, 1Bh		; [Dengeki Nurse] dodged the attack!

loc_1282E:				; CODE XREF: seg000:280Dj seg000:2818j ...
		call	ShowMessageText	; show paralyze	message
		call	sub_12EEB

loc_12834:				; CODE XREF: seg000:2829j
		pop	ax
		retn
; ---------------------------------------------------------------------------

locret_12836:				; DATA XREF: seg000:off_12728o
		retn
; ---------------------------------------------------------------------------

loc_12837:				; DATA XREF: seg000:off_12728o
		push	ax
		mov	ax, 3Eh
		call	ShowMessageText	; But... They leave without doing anything!
		call	sub_12EEB
		pop	ax
		retn
; ---------------------------------------------------------------------------

locret_12843:				; DATA XREF: seg000:jmpTblActMsgo
		retn
; ---------------------------------------------------------------------------

locret_12844:				; DATA XREF: seg000:jmpTblActMsgo
		retn
; ---------------------------------------------------------------------------

saMsg0D_PlasmaFlash:			; DATA XREF: seg000:jmpTblActMsgo
		push	ax
		mov	ax, [di+49h]
		test	byte ptr [di+4Fh], 1
		jz	short loc_12860
		or	ax, ax
		jz	short loc_1285B
		call	DrawInt_Buf1
		mov	ax, 0Ch		; [Dengeki Nurse] hits [enemy] for [N1]	points of damage!
		jmp	short loc_12869
; ---------------------------------------------------------------------------

loc_1285B:				; CODE XREF: seg000:2851j
		mov	ax, 0Dh		; You didn't deal any actual damage!
		jmp	short loc_12869
; ---------------------------------------------------------------------------

loc_12860:				; CODE XREF: seg000:284Dj
		test	byte ptr [di+4Fh], 2
		jz	short loc_1286F
		mov	ax, 0Eh		; [Dengeki Nurse]'s attack was dodged!

loc_12869:				; CODE XREF: seg000:2859j seg000:285Ej
		call	ShowMessageText	; show attack reception	message
		call	sub_12EEB

loc_1286F:				; CODE XREF: seg000:2864j
		pop	ax
		retn
; ---------------------------------------------------------------------------

saMsg0E_Electrode:			; DATA XREF: seg000:jmpTblActMsgo
		push	ax
		test	byte ptr [si+4Fh], 1
		jz	short loc_12881
		mov	ax, 17h
		call	ShowMessageText	; [Dengeki Nurse] secretly deploys Electrode #2!
		call	sub_12EEB

loc_12881:				; CODE XREF: seg000:2876j
		pop	ax
		retn
; ---------------------------------------------------------------------------

saMsg0F_PlasmaCharge:			; DATA XREF: seg000:jmpTblActMsgo
		push	ax
		push	bx
		xor	ah, ah
		mov	al, [si+43h]
		test	byte ptr [si+4Fh], 1
		jz	short loc_128B2
		mov	bx, ax
		call	DrawInt_Buf1
		sub	ax, 50
		neg	ax
		jns	short loc_1289E
		xor	ax, ax

loc_1289E:				; CODE XREF: seg000:289Aj
		call	DrawInt_Buf2
		mov	ax, 44h		; Plasma charge	is now at [N1]%... Plasma Charge is now	online!
		cmp	bx, 50
		jnb	short loc_128AC
		mov	ax, 18h		; Plasma Charge	is now at [N1]%! You need [N2]%	more before you	can Plasma Flash!

loc_128AC:				; CODE XREF: seg000:28A7j
		call	ShowMessageText	; show plasma charge message
		call	sub_12EEB

loc_128B2:				; CODE XREF: seg000:288Ej
		pop	bx
		pop	ax
		retn
; ---------------------------------------------------------------------------

saMsg10_PlayerAtk:			; DATA XREF: seg000:jmpTblActMsgo
		push	ax
		mov	ax, [di+49h]
		test	byte ptr [di+4Fh], 1
		jz	short loc_128D0
		or	ax, ax
		jz	short loc_128CB
		call	DrawInt_Buf1
		mov	ax, 0Ch		; [Dengeki Nurse] hits [enemy] for [N1]	points of damage!
		jmp	short loc_128E4
; ---------------------------------------------------------------------------

loc_128CB:				; CODE XREF: seg000:28C1j
		mov	ax, 0Dh		; "Aw man! You didn't deal any actual damage!
		jmp	short loc_128E4
; ---------------------------------------------------------------------------

loc_128D0:				; CODE XREF: seg000:28BDj
		test	byte ptr [di+4Fh], 2
		jz	short loc_128DB
		mov	ax, 0Eh		; [Dengeki Nurse]'s attack was dodged!
		jmp	short loc_128E4
; ---------------------------------------------------------------------------

loc_128DB:				; CODE XREF: seg000:28D4j
		test	byte ptr [di+4Fh], 4
		jz	short loc_128EA
		mov	ax, 0Dh		; "Aw man! You didn't deal any actual damage!

loc_128E4:				; CODE XREF: seg000:28C9j seg000:28CEj ...
		call	ShowMessageText	; show attack reception	message
		call	sub_12EEB

loc_128EA:				; CODE XREF: seg000:28DFj
		pop	ax
		retn
; ---------------------------------------------------------------------------

saMsg11_DgkShuriken:			; DATA XREF: seg000:jmpTblActMsgo
		push	ax
		mov	ax, [di+49h]
		test	byte ptr [di+4Fh], 1
		jz	short loc_12907
		or	ax, ax
		jz	short loc_12902
		call	DrawInt_Buf1
		mov	ax, 0Ch		; [Dengeki Nurse] hits [enemy] for [N1]	points of damage!
		jmp	short loc_1292F
; ---------------------------------------------------------------------------

loc_12902:				; CODE XREF: seg000:28F8j
		mov	ax, 0Dh		; "Aw man! You didn't deal any actual damage!
		jmp	short loc_1292F
; ---------------------------------------------------------------------------

loc_12907:				; CODE XREF: seg000:28F4j
		test	byte ptr [di+4Fh], 2
		jz	short loc_12912
		mov	ax, 0Eh		; [Dengeki Nurse]'s attack was dodged!
		jmp	short loc_1292F
; ---------------------------------------------------------------------------

loc_12912:				; CODE XREF: seg000:290Bj
		test	byte ptr [di+4Fh], 4
		jz	short loc_12932
		mov	ax, 41h
		call	ShowMessageText	; EM interference makes	the Dengeki Shuriken fly off elsewhere!
		call	sub_12EEB
		call	ClearMessageBox
		mov	ax, 1Eh
		call	ShowChat1Text
		call	sub_12EEB
		jmp	short loc_12932
; ---------------------------------------------------------------------------

loc_1292F:				; CODE XREF: seg000:2900j seg000:2905j ...
		call	ShowMessageText	; show attack reception	message

loc_12932:				; CODE XREF: seg000:2916j seg000:292Dj
		pop	ax
		retn
; ---------------------------------------------------------------------------

saMsg13_DgkScalpel:			; DATA XREF: seg000:jmpTblActMsgo
		push	ax
		mov	ax, [di+49h]
		test	byte ptr [di+4Fh], 1
		jz	short loc_12973
		or	ax, ax
		jz	short loc_1296E
		call	DrawInt_Buf1
		mov	ax, 0Ch
		call	ShowMessageText	; [Dengeki Nurse] hits [enemy] for [N1]	points of damage!
		call	sub_12EEB
		call	ClearMessageBox
		mov	ax, [di+4Bh]
		call	DrawInt_Buf1
		mov	ax, 0Fh
		call	ShowMessageText	; [Dengeki Nurse] lowered [enemy]'s attack by [N1] points!
		call	sub_12EEB
		call	ClearMessageBox
		mov	ax, [di+4Dh]
		call	DrawInt_Buf1
		mov	ax, 10h		; [Dengeki Nurse] lowered [enemy]'s defense by [N1] points!
		jmp	short loc_12987
; ---------------------------------------------------------------------------

loc_1296E:				; CODE XREF: seg000:2940j
		mov	ax, 0Dh		; "Aw man! You didn't deal any actual damage!
		jmp	short loc_12987
; ---------------------------------------------------------------------------

loc_12973:				; CODE XREF: seg000:293Cj
		test	byte ptr [di+4Fh], 2
		jz	short loc_1297E
		mov	ax, 0Eh		; [Dengeki Nurse]'s attack was dodged!
		jmp	short loc_12987
; ---------------------------------------------------------------------------

loc_1297E:				; CODE XREF: seg000:2977j
		test	byte ptr [di+4Fh], 4
		jz	short loc_1298D
		mov	ax, 0Dh		; "Aw man! You didn't deal any actual damage!

loc_12987:				; CODE XREF: seg000:296Cj seg000:2971j ...
		call	ShowMessageText	; show attack reception	message
		call	sub_12EEB

loc_1298D:				; CODE XREF: seg000:2982j
		pop	ax
		retn

; =============== S U B	R O U T	I N E =======================================


SetDirectionText proc near		; CODE XREF: seg000:1F2Fp
		pusha
		mov	dx, 4
		call	Random_InRange	; randomly choose one of 4 directions
		shl	ax, 1
		mov	si, seg	seg001
		assume ds:seg001
		mov	ds, si
		mov	si, offset txtDirections ; "ìå"
		add	si, ax
		mov	ax, [si]
		mov	si, offset aDirBuffer ;	"ÅH"
		mov	[si], ax
		popa
		retn
SetDirectionText endp


; =============== S U B	R O U T	I N E =======================================


DrawInt_Pad_B1	proc near		; CODE XREF: ShowStat_HP+3p
					; ShowStat_Atk+3p ...
		push	si
		push	ds
		mov	si, seg	seg001
		mov	ds, si
		mov	si, offset aNumBuffer1 ; "ÇOÇOÇO"
		call	DrawInt_3DigSpc
		pop	ds
		assume ds:nothing
		pop	si
		retn
DrawInt_Pad_B1	endp

; ---------------------------------------------------------------------------

DrawInt_Pad_B2:				; unused
		push	si
		push	ds
		mov	si, seg	seg001
		mov	ds, si
		assume ds:seg001
		mov	si, offset aNumBuffer2 ; "ÇOÇOÇO"
		call	DrawInt_3DigSpc
		pop	ds
		assume ds:nothing
		pop	si
		retn

; =============== S U B	R O U T	I N E =======================================


DrawInt_Buf1	proc near		; CODE XREF: seg000:237Cp seg000:238Ep ...
		push	si
		push	ds
		mov	si, seg	seg001
		mov	ds, si
		assume ds:seg001
		mov	si, offset aNumBuffer1 ; "ÇOÇOÇO"
		call	DrawInt_NoPad
		pop	ds
		assume ds:nothing
		pop	si
		retn
DrawInt_Buf1	endp


; =============== S U B	R O U T	I N E =======================================


DrawInt_Buf2	proc near		; CODE XREF: seg000:loc_1289Ep
		push	si
		push	ds
		mov	si, seg	seg001
		mov	ds, si
		assume ds:seg001
		mov	si, offset aNumBuffer2 ; "ÇOÇOÇO"
		call	DrawInt_NoPad
		pop	ds
		assume ds:nothing
		pop	si
		retn
DrawInt_Buf2	endp


; =============== S U B	R O U T	I N E =======================================


DrawInt_3DigSpc	proc near		; CODE XREF: DrawInt_Pad_B1+Ap
					; seg000:29C5p
		pusha
		mov	bp, si
		mov	bx, 8140h	; pad with full-width spaces
		xchg	bh, bl
		mov	cx, 3		; pad to 3 digits

loc_129F6:				; CODE XREF: DrawInt_3DigSpc+10j
		mov	[si], bx
		add	si, 2
		loop	loc_129F6
		mov	[si], cl
		mov	si, bp
		add	si, 4
		mov	bx, 8140h
		cmp	ax, 100
		jb	short loc_12A12
		call	DrawDigit_FW	; draw last digit
		sub	si, 2

loc_12A12:				; CODE XREF: DrawInt_3DigSpc+1Fj
		cmp	ax, 10
		jb	short loc_12A1D
		call	DrawDigit_FW	; draw 2nd-to-last digit
		sub	si, 2

loc_12A1D:				; CODE XREF: DrawInt_3DigSpc+2Aj
		call	DrawDigit_FW	; draw first digit
		popa
		retn
DrawInt_3DigSpc	endp


; =============== S U B	R O U T	I N E =======================================


DrawInt_NoPad	proc near		; CODE XREF: DrawInt_Buf1+Ap
					; DrawInt_Buf2+Ap
		pusha
		mov	bp, si
		mov	cx, 7		; 3x full-width	= 6 bytes + 1 byte terminator

loc_12A28:				; CODE XREF: DrawInt_NoPad+9j
		mov	[si], ch	; make text string empty
		inc	si
		loop	loc_12A28
		mov	si, bp
		add	si, 4
		mov	bx, 824Fh
		cmp	ax, 100
		jb	short loc_12A3D
		call	DrawDigit_FW	; draw last digit

loc_12A3D:				; CODE XREF: DrawInt_NoPad+16j
		sub	si, 2
		cmp	ax, 10
		jb	short loc_12A48
		call	DrawDigit_FW	; draw 2nd-to-last digit

loc_12A48:				; CODE XREF: DrawInt_NoPad+21j
		sub	si, 2
		call	DrawDigit_FW	; draw first digit
		popa
		retn
DrawInt_NoPad	endp


; =============== S U B	R O U T	I N E =======================================


DrawDigit_FW	proc near		; CODE XREF: DrawInt_3DigSpc+21p
					; DrawInt_3DigSpc+2Cp ...
		push	cx
		push	dx
		call	Div10
		mov	bx, 824Fh
		add	bx, dx
		xchg	bh, bl
		mov	[si], bx
		xchg	bh, bl
		mov	ax, cx
		pop	dx
		pop	cx
		retn
DrawDigit_FW	endp

; ---------------------------------------------------------------------------

Mult10:					; unused
		push	bx
		mov	bx, ax
		shl	ax, 3
		shl	bx, 1
		add	ax, bx
		pop	bx
		retn

; =============== S U B	R O U T	I N E =======================================


Div10		proc near		; CODE XREF: DrawDigit_FW+2p
		push	ax
		mov	cl, 10
		div	cl
		xor	cx, cx
		mov	cl, al
		xor	dx, dx
		mov	dl, ah
		pop	ax
		retn
Div10		endp


; =============== S U B	R O U T	I N E =======================================


SetSavedTxtPtrs	proc near		; CODE XREF: DoFightTurn+16p
					; DoFightTurn+3Cp ...
		push	ax
		push	si
		push	ds
		mov	al, 0
		call	SetSavedTxtPtr	; ptr[0] = character name 1 (parameter SI)
		mov	si, di
		mov	al, 1
		call	SetSavedTxtPtr	; ptr[1] = character name 2 (parameter DI)
		mov	si, seg	seg001
		mov	ds, si
		assume ds:seg001
		mov	si, offset aDirBuffer ;	Note that this buffer by be written to later on.
		mov	al, 2
		call	SetSavedTxtPtr	; ptr[2] = direction buffer
		mov	si, offset aNumBuffer2 ; "ÇOÇOÇO"
		mov	al, 3
		call	SetSavedTxtPtr	; ptr[3] = number buffer 2
		mov	si, offset aNumBuffer1 ; "ÇOÇOÇO"
		mov	al, 4
		call	SetSavedTxtPtr	; ptr[4] = number buffer 1
		pop	ds
		assume ds:nothing
		pop	si
		pop	ax
		retn
SetSavedTxtPtrs	endp


; =============== S U B	R O U T	I N E =======================================


DoAttack02_CharSpec proc near		; CODE XREF: seg000:1485p
		push	ax
		push	bp
		push	es
		mov	bp, cs
		mov	es, bp
		assume es:seg000
		mov	bp, offset off_12AC1
		call	CallJumpTbl
		pop	es
		assume es:nothing
		pop	bp
		pop	ax
		retn
DoAttack02_CharSpec endp

; ---------------------------------------------------------------------------
off_12AC1	dw offset locret_12AE1	; 0 ; DATA XREF: DoAttack02_CharSpec+7o
		dw offset actChr01	; 1
		dw offset actChr02	; 2
		dw offset actChr03	; 3
		dw offset actChr04	; 4
		dw offset actChr05	; 5
		dw offset actChr06	; 6
		dw offset actChr07	; 7
		dw offset actChr08	; 8
		dw offset actChr09	; 9
		dw offset actChr0A	; 0Ah
		dw offset actChr0B	; 0Bh
		dw offset actChr0C	; 0Ch
		dw offset actChr0D	; 0Dh
		dw offset actChr0E	; 0Eh
		dw offset actChr0F	; 0Fh
; ---------------------------------------------------------------------------

locret_12AE1:				; DATA XREF: seg000:off_12AC1o
		retn
; ---------------------------------------------------------------------------

actChr01:				; DATA XREF: seg000:off_12AC1o
		push	ax
		push	dx
		test	word ptr [di+2Dh], 800h
		jnz	short loc_12B05
		mov	dx, 4
		call	Random_InRange
		add	ax, 15
		add	ax, [si+21h]
		sub	ax, [di+27h]
		jnb	short loc_12AFE
		xor	ax, ax

loc_12AFE:				; CODE XREF: seg000:2AFAj
		mov	[di+49h], ax
		mov	al, 1
		jmp	short loc_12B07
; ---------------------------------------------------------------------------

loc_12B05:				; CODE XREF: seg000:2AE9j
		mov	al, 4

loc_12B07:				; CODE XREF: seg000:2B03j
		mov	[di+4Fh], al
		pop	dx
		pop	ax
		retn
; ---------------------------------------------------------------------------

actChr02:				; DATA XREF: seg000:off_12AC1o
		push	ax
		push	dx
		test	word ptr [di+2Dh], 1000h
		jnz	short loc_12B26
		mov	dx, 3
		call	Random_InRange
		add	ax, 3
		mov	[di+4Dh], ax
		mov	al, 1
		jmp	short loc_12B28
; ---------------------------------------------------------------------------

loc_12B26:				; CODE XREF: seg000:2B14j
		mov	al, 4

loc_12B28:				; CODE XREF: seg000:2B24j
		mov	[di+4Fh], al
		pop	dx
		pop	ax
		retn
; ---------------------------------------------------------------------------

actChr03:				; DATA XREF: seg000:off_12AC1o
		push	ax
		push	dx
		test	word ptr [di+2Dh], 800h
		jnz	short loc_12B51
		mov	dx, 5
		call	Random_InRange
		add	ax, 18
		add	ax, [si+21h]
		sub	ax, [di+27h]
		jnb	short loc_12B4A
		xor	ax, ax

loc_12B4A:				; CODE XREF: seg000:2B46j
		mov	[di+49h], ax
		mov	al, 1
		jmp	short loc_12B53
; ---------------------------------------------------------------------------

loc_12B51:				; CODE XREF: seg000:2B35j
		mov	al, 4

loc_12B53:				; CODE XREF: seg000:2B4Fj
		mov	[di+4Fh], al
		pop	dx
		pop	ax
		retn
; ---------------------------------------------------------------------------

actChr04:				; DATA XREF: seg000:off_12AC1o
		push	ax
		push	dx
		test	word ptr [di+2Dh], 800h
		jnz	short loc_12B7C
		mov	dx, 4
		call	Random_InRange
		add	ax, 15
		add	ax, [si+21h]
		sub	ax, [di+27h]
		jnb	short loc_12B75
		xor	ax, ax

loc_12B75:				; CODE XREF: seg000:2B71j
		mov	[di+49h], ax
		mov	al, 1
		jmp	short loc_12B7E
; ---------------------------------------------------------------------------

loc_12B7C:				; CODE XREF: seg000:2B60j
		mov	al, 4

loc_12B7E:				; CODE XREF: seg000:2B7Aj
		mov	[di+4Fh], al
		pop	dx
		pop	ax
		retn
; ---------------------------------------------------------------------------

actChr05:				; DATA XREF: seg000:off_12AC1o
		push	ax
		push	dx
		test	word ptr [di+2Dh], 800h
		jnz	short loc_12BA7
		mov	dx, 5
		call	Random_InRange
		add	ax, 18
		add	ax, [si+21h]
		sub	ax, [di+27h]
		jnb	short loc_12BA0
		xor	ax, ax

loc_12BA0:				; CODE XREF: seg000:2B9Cj
		mov	[di+49h], ax
		mov	al, 1
		jmp	short loc_12BA9
; ---------------------------------------------------------------------------

loc_12BA7:				; CODE XREF: seg000:2B8Bj
		mov	al, 4

loc_12BA9:				; CODE XREF: seg000:2BA5j
		mov	[di+4Fh], al
		pop	dx
		pop	ax
		retn
; ---------------------------------------------------------------------------

actChr06:				; DATA XREF: seg000:off_12AC1o
		push	ax
		push	dx
		test	word ptr [di+2Dh], 2000h
		jnz	short loc_12BCC
		or	word ptr [di+45h], 800h
		mov	dx, 2
		call	Random_InRange
		add	al, 2
		mov	[di+48h], al
		mov	al, 1
		jmp	short loc_12BCE
; ---------------------------------------------------------------------------

loc_12BCC:				; CODE XREF: seg000:2BB6j
		mov	al, 4

loc_12BCE:				; CODE XREF: seg000:2BCAj
		mov	[di+4Fh], al
		pop	dx
		pop	ax
		retn
; ---------------------------------------------------------------------------

actChr07:				; DATA XREF: seg000:off_12AC1o
		push	ax
		push	dx
		test	word ptr [di+2Dh], 800h
		jnz	short loc_12BF7
		mov	dx, 4
		call	Random_InRange
		add	ax, 15
		add	ax, [si+21h]
		sub	ax, [di+27h]
		jnb	short loc_12BF0
		xor	ax, ax

loc_12BF0:				; CODE XREF: seg000:2BECj
		mov	[di+49h], ax
		mov	al, 1
		jmp	short loc_12BF9
; ---------------------------------------------------------------------------

loc_12BF7:				; CODE XREF: seg000:2BDBj
		mov	al, 4

loc_12BF9:				; CODE XREF: seg000:2BF5j
		mov	[di+4Fh], al
		pop	dx
		pop	ax
		retn
; ---------------------------------------------------------------------------

actChr08:				; DATA XREF: seg000:off_12AC1o
		push	ax
		push	dx
		test	word ptr [di+2Dh], 1000h
		jnz	short loc_12C18
		mov	dx, 4
		call	Random_InRange
		add	ax, 7
		mov	[di+4Bh], ax
		mov	al, 1
		jmp	short loc_12C1A
; ---------------------------------------------------------------------------

loc_12C18:				; CODE XREF: seg000:2C06j
		mov	al, 4

loc_12C1A:				; CODE XREF: seg000:2C16j
		mov	[di+4Fh], al
		pop	dx
		pop	ax
		retn
; ---------------------------------------------------------------------------

actChr09:				; DATA XREF: seg000:off_12AC1o
		push	ax
		push	dx
		test	word ptr [di+2Dh], 1000h
		jnz	short loc_12C39
		mov	dx, 4
		call	Random_InRange
		add	ax, 7
		mov	[di+4Dh], ax
		mov	al, 1
		jmp	short loc_12C3B
; ---------------------------------------------------------------------------

loc_12C39:				; CODE XREF: seg000:2C27j
		mov	al, 4

loc_12C3B:				; CODE XREF: seg000:2C37j
		mov	[di+4Fh], al
		pop	dx
		pop	ax
		retn
; ---------------------------------------------------------------------------

actChr0A:				; DATA XREF: seg000:off_12AC1o
		push	ax
		push	dx
		test	word ptr [di+2Dh], 2000h
		jnz	short loc_12C5E
		or	word ptr [di+45h], 1000h
		mov	dx, 3
		call	Random_InRange
		inc	al
		mov	[di+48h], al
		mov	al, 1
		jmp	short loc_12C60
; ---------------------------------------------------------------------------

loc_12C5E:				; CODE XREF: seg000:2C48j
		mov	al, 4

loc_12C60:				; CODE XREF: seg000:2C5Cj
		mov	[di+4Fh], al
		pop	dx
		pop	ax
		retn
; ---------------------------------------------------------------------------

actChr0B:				; DATA XREF: seg000:off_12AC1o
		push	ax
		push	dx
		test	word ptr [di+2Dh], 1000h
		jnz	short loc_12C83
		or	word ptr [di+45h], 400h
		mov	dx, 4
		call	Random_InRange
		add	al, 2
		mov	[di+47h], al
		mov	al, 1
		jmp	short loc_12C85
; ---------------------------------------------------------------------------

loc_12C83:				; CODE XREF: seg000:2C6Dj
		mov	al, 4

loc_12C85:				; CODE XREF: seg000:2C81j
		mov	[di+4Fh], al
		pop	dx
		pop	ax
		retn
; ---------------------------------------------------------------------------

actChr0C:				; DATA XREF: seg000:off_12AC1o
		push	ax
		push	dx
		test	word ptr [di+2Dh], 800h
		jnz	short loc_12CAE
		mov	dx, 5
		call	Random_InRange
		add	ax, 18
		add	ax, [si+21h]
		sub	ax, [di+27h]
		jnb	short loc_12CA7
		xor	ax, ax

loc_12CA7:				; CODE XREF: seg000:2CA3j
		mov	[di+49h], ax
		mov	al, 1
		jmp	short loc_12CB0
; ---------------------------------------------------------------------------

loc_12CAE:				; CODE XREF: seg000:2C92j
		mov	al, 4

loc_12CB0:				; CODE XREF: seg000:2CACj
		mov	[di+4Fh], al
		pop	dx
		pop	ax
		retn
; ---------------------------------------------------------------------------

actChr0D:				; DATA XREF: seg000:off_12AC1o
		push	ax
		push	dx
		test	word ptr [di+2Dh], 1000h
		jnz	short loc_12CC8
		xor	al, al
		mov	[di+43h], al
		mov	al, 1
		jmp	short loc_12CCA
; ---------------------------------------------------------------------------

loc_12CC8:				; CODE XREF: seg000:2CBDj
		mov	al, 4

loc_12CCA:				; CODE XREF: seg000:2CC6j
		mov	[di+4Fh], al
		pop	dx
		pop	ax
		retn
; ---------------------------------------------------------------------------

actChr0E:				; DATA XREF: seg000:off_12AC1o
		push	ax
		push	dx
		test	word ptr [di+2Dh], 800h
		jnz	short loc_12CF3
		mov	dx, 5
		call	Random_InRange
		add	ax, 18
		add	ax, [si+21h]
		sub	ax, [di+27h]
		jnb	short loc_12CEC
		xor	ax, ax

loc_12CEC:				; CODE XREF: seg000:2CE8j
		mov	[di+49h], ax
		mov	al, 1
		jmp	short loc_12CF5
; ---------------------------------------------------------------------------

loc_12CF3:				; CODE XREF: seg000:2CD7j
		mov	al, 4

loc_12CF5:				; CODE XREF: seg000:2CF1j
		mov	[di+4Fh], al
		pop	dx
		pop	ax
		retn
; ---------------------------------------------------------------------------

actChr0F:				; DATA XREF: seg000:off_12AC1o
		push	ax
		push	dx
		test	word ptr [di+2Dh], 800h
		jnz	short loc_12D1E
		mov	dx, 4
		call	Random_InRange
		add	ax, 22
		add	ax, [si+21h]
		sub	ax, [di+27h]
		jnb	short loc_12D17
		xor	ax, ax

loc_12D17:				; CODE XREF: seg000:2D13j
		mov	[di+49h], ax
		mov	al, 1
		jmp	short loc_12D20
; ---------------------------------------------------------------------------

loc_12D1E:				; CODE XREF: seg000:2D02j
		mov	al, 4

loc_12D20:				; CODE XREF: seg000:2D1Cj
		mov	[di+4Fh], al
		pop	dx
		pop	ax
		retn

; =============== S U B	R O U T	I N E =======================================


DrawText	proc near		; CODE XREF: ShowActionText+1Ap
					; ShowActionText+26p ...
		pusha
		push	ds
		push	es
		mov	ax, seg	seg001
		mov	es, ax
		assume es:seg001
		mov	ax, es:dtxtPosY
		mov	bx, es:dtxtPosX
		mov	cx, 80
		call	CalcTextOfs	; AX = AX (y) *	CX (width) + BX	(x)
		mov	bp, ax
		mov	di, es:dtxtAddr
		mov	cl, es:dtxtColor
		mov	ch, es:dtxtFlags

loc_12D4E:				; CODE XREF: DrawText+5Fj DrawText+64j ...
		mov	dx, [si]
		or	dl, dl
		jnz	short loc_12D57
		jmp	dtxt00_end	; 00 - end
; ---------------------------------------------------------------------------

loc_12D57:				; CODE XREF: DrawText+2Cj
		cmp	dl, 0Dh
		jnz	short loc_12D5F
		jmp	dtxt0D_linebrk	; 0D - line break
; ---------------------------------------------------------------------------

loc_12D5F:				; CODE XREF: DrawText+34j
		cmp	dl, 10h
		jnb	short loc_12D67
		jmp	dtxt_drawchar	; 01..0F - draw	character
; ---------------------------------------------------------------------------

loc_12D67:				; CODE XREF: DrawText+3Cj
		cmp	dl, 14h
		jbe	short dtxt10_saved ; 10..14 - draw saved text
		cmp	dl, 40h
		jz	short loc_12D74	; 40 '@' - jump
		jmp	dtxt_drawchar
; ---------------------------------------------------------------------------

loc_12D74:				; CODE XREF: DrawText+49j
		cmp	dh, 80h
		jbe	short loc_12D7C	; 40 00..80 - handle special codes
		jmp	dtxt_drawchar	; 40 81..FF - just draw
; ---------------------------------------------------------------------------

loc_12D7C:				; CODE XREF: DrawText+51j
		inc	si
		mov	dl, [si]
		or	dl, 20h		; enforce lower	case
		cmp	dl, 'a'
		jb	short loc_12D4E
		cmp	dl, 'z'
		ja	short loc_12D4E
		inc	si
		call	ParseASCIINum
		cmp	dl, 'a'
		jnz	short loc_12D9E

dtxt_a:
		mov	di, bp
		mov	es:dtxtAddr, di
		jmp	short loc_12D4E
; ---------------------------------------------------------------------------

loc_12D9E:				; CODE XREF: DrawText+6Dj
		cmp	dl, 'c'
		jnz	short loc_12DAC

dtxt_c:
		mov	cl, al
		mov	es:dtxtColor, cl
		jmp	short loc_12D4E
; ---------------------------------------------------------------------------

loc_12DAC:				; CODE XREF: DrawText+7Bj
		cmp	dl, 'f'
		jnz	short loc_12DBA

dtxt_f:
		mov	ch, al
		mov	es:dtxtFlags, ch
		jmp	short loc_12D4E
; ---------------------------------------------------------------------------

loc_12DBA:				; CODE XREF: DrawText+89j
		cmp	dl, 'x'
		jnz	short loc_12DC3
		mov	es:dtxtPosX, ax

loc_12DC3:				; CODE XREF: DrawText+97j
		cmp	dl, 'y'
		jnz	short loc_12DCC
		mov	es:dtxtPosY, ax

loc_12DCC:				; CODE XREF: DrawText+A0j
		mov	ax, es:dtxtPosY
		mov	bx, es:dtxtPosX
		mov	cx, 80
		call	CalcTextOfs	; AX = AX (y) *	CX (width) + BX	(x)
		mov	bp, ax
		mov	di, bp
		mov	es:dtxtAddr, di
		jmp	loc_12D4E
; ---------------------------------------------------------------------------

dtxt10_saved:				; CODE XREF: DrawText+44j
		call	DrawSavedText
		inc	si
		mov	ax, es:dtxtPosY
		mov	bx, es:dtxtPosX
		mov	cx, 80
		call	CalcTextOfs	; AX = AX (y) *	CX (width) + BX	(x)
		mov	bp, ax
		mov	di, es:dtxtAddr
		mov	cl, es:dtxtColor
		mov	ch, es:dtxtFlags
		jmp	loc_12D4E
; ---------------------------------------------------------------------------

dtxt0D_linebrk:				; CODE XREF: DrawText+36j
		inc	si
		add	bp, 500h
		add	es:dtxtPosY, 16
		mov	di, bp
		mov	es:dtxtAddr, di
		jmp	loc_12D4E
; ---------------------------------------------------------------------------

dtxt_drawchar:				; CODE XREF: DrawText+3Ej DrawText+4Bj ...
		xchg	dh, dl
		call	WaitFrames
		call	DoKeyboardThing
		call	DrawTextChar
		add	si, 2
		add	di, 2
		mov	es:dtxtAddr, di
		jmp	loc_12D4E
; ---------------------------------------------------------------------------

dtxt00_end:				; CODE XREF: DrawText+2Ej
		pop	es
		assume es:nothing
		pop	ds
		popa
		retn
DrawText	endp


; =============== S U B	R O U T	I N E =======================================


ParseASCIINum	proc near		; CODE XREF: DrawText+67p
		push	bx
		xor	ax, ax
		xor	bx, bx

loc_12E45:				; CODE XREF: ParseASCIINum+1Aj
		mov	bl, [si]
		cmp	bl, '0'
		jb	short loc_12E5C
		cmp	bl, '9'
		ja	short loc_12E5C
		sub	bl, '0'
		call	MultAX10	; AX = AX * 10
		add	ax, bx
		inc	si
		jmp	short loc_12E45
; ---------------------------------------------------------------------------

loc_12E5C:				; CODE XREF: ParseASCIINum+Aj
					; ParseASCIINum+Fj
		pop	bx
		retn
ParseASCIINum	endp


; =============== S U B	R O U T	I N E =======================================

; AX = AX * 10

MultAX10	proc near		; CODE XREF: ParseASCIINum+14p
		push	bx
		shl	ax, 1
		mov	bx, ax
		shl	ax, 2
		add	ax, bx
		pop	bx
		retn
MultAX10	endp


; =============== S U B	R O U T	I N E =======================================

; AX = AX (y) *	CX (width) + BX	(x)

CalcTextOfs	proc near		; CODE XREF: DrawText+14p DrawText+B2p ...
		push	dx
		mul	cx
		add	ax, bx
		pop	dx
		retn
CalcTextOfs	endp


; =============== S U B	R O U T	I N E =======================================


DrawSavedText	proc near		; CODE XREF: DrawText:dtxt10_savedp
		push	dx
		push	si
		push	ds
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		mov	si, offset SavedTextPtrs
		xor	dh, dh
		sub	dl, 10h
		shl	dx, 2
		add	si, dx
		lds	si, [si]
		call	DrawText
		pop	ds
		assume ds:nothing
		pop	si
		pop	dx
		retn
DrawSavedText	endp


; =============== S U B	R O U T	I N E =======================================


DrawTextChar	proc near		; CODE XREF: DrawText+105p
		push	si
		push	ds
		mov	si, seg	seg001
		mov	ds, si
		assume ds:seg001
		mov	si, offset TextChrBuf
		call	GetChrData
		call	MakeBold_16x16
		call	Draw16x16
		pop	ds
		pop	si
		retn
DrawTextChar	endp


; =============== S U B	R O U T	I N E =======================================


SetSavedTxtPtr	proc near		; CODE XREF: SetSavedTxtPtrs+5p
					; SetSavedTxtPtrs+Cp ...
		push	ax
		push	di
		push	es
		mov	di, seg	seg001
		mov	es, di
		assume es:seg001
		xor	ah, ah
		shl	ax, 2
		mov	di, offset SavedTextPtrs
		add	di, ax
		mov	es:[di], si
		mov	word ptr es:[di+2], ds
		pop	es
		assume es:nothing
		pop	di
		pop	ax
		retn
SetSavedTxtPtr	endp


; =============== S U B	R O U T	I N E =======================================


DoKeyboardThing	proc near		; CODE XREF: DrawText+102p
		push	ax
		push	cx
		mov	cx, 0FFFFh
		xor	al, al
		call	sub_146A5
		call	sub_146B5
		pop	cx
		pop	ax
		retn
DoKeyboardThing	endp


; =============== S U B	R O U T	I N E =======================================


SetFrameDelay1	proc near		; CODE XREF: ShowMessageText+3p
					; ShowChat1Text+3p ...
		push	ax
		push	ds
		mov	ax, seg	seg001
		mov	ds, ax
		call	sub_14A46
		mov	ah, 1
		test	al, 2
		jz	short loc_12EE4
		xor	ah, ah

loc_12EE4:				; CODE XREF: SetFrameDelay1+Ej
		mov	FrameDelay, ah
		pop	ds
		pop	ax
		retn
SetFrameDelay1	endp


; =============== S U B	R O U T	I N E =======================================


sub_12EEB	proc near		; CODE XREF: ParalysisTimer+22p
					; NoActTimer_Drug+21p ...
		push	si
		push	ds
		mov	si, seg	seg001
		mov	ds, si
		mov	si, offset word_184E0
		call	sub_13426
		pop	ds
		pop	si
		retn
sub_12EEB	endp


; =============== S U B	R O U T	I N E =======================================


LoadGPC		proc near		; CODE XREF: LoadD1CVC+16p
					; LoadD1ENMF+17p ...
		push	bx
		push	ds
		push	es
		call	sub_14684
		call	sub_14658
		jb	short loc_12F0A
		call	sub_12F0E
		clc

loc_12F0A:				; CODE XREF: LoadGPC+9j
		pop	es
		pop	ds
		assume ds:nothing
		pop	bx
		retn
LoadGPC		endp


; =============== S U B	R O U T	I N E =======================================


sub_12F0E	proc near		; CODE XREF: LoadGPC+Bp
		push	bx
		push	cx
		push	dx
		push	si
		push	ds
		call	sub_12F3F
		mov	si, seg	seg001
		mov	ds, si
		assume ds:seg001
		mov	si, offset word_184B8
		mov	bl, ah
		mov	bh, ah
		mov	ah, al
		mov	cx, [si+0Eh]
		mov	dx, [si+0Ch]
		mov	[si+0Eh], ax
		mov	[si+0Ch], bx
		call	sub_14679
		mov	[si+0Eh], cx
		mov	[si+0Ch], dx
		pop	ds
		assume ds:nothing
		pop	si
		pop	dx
		pop	cx
		pop	bx
		retn
sub_12F0E	endp


; =============== S U B	R O U T	I N E =======================================


sub_12F3F	proc near		; CODE XREF: sub_12F0E+5p
		push	cx
		push	dx
		push	si
		push	ds
		call	sub_12F58
		mov	si, seg	seg001
		mov	ds, si
		assume ds:seg001
		mov	word_184C0, cx
		mov	word_184C2, dx
		pop	ds
		assume ds:nothing
		pop	si
		pop	dx
		pop	cx
		retn
sub_12F3F	endp


; =============== S U B	R O U T	I N E =======================================


sub_12F58	proc near		; CODE XREF: sub_12F3F+4p
		push	ax
		xor	dx, dx
		mov	ax, di
		mov	cx, 80
		div	cx
		mov	cx, dx
		mov	dx, ax
		pop	ax
		retn
sub_12F58	endp


; =============== S U B	R O U T	I N E =======================================


sub_12F68	proc near		; CODE XREF: sub_11A1E+18p
					; sub_11A1E+27p ...
		pusha
		push	ds
		push	es
		mov	ax, 0A800h
		mov	cx, es
		mov	bp, dx

loc_12F72:				; CODE XREF: sub_12F68+1Aj
					; sub_12F68+1Fj
		mov	ds, ax
		assume ds:nothing
		mov	es, cx
		call	sub_14884
		add	ch, 8
		add	ah, 8
		cmp	ah, 184
		jbe	short loc_12F72
		add	ah, 32
		jnb	short loc_12F72
		pop	es
		pop	ds
		assume ds:nothing
		popa
		retn
sub_12F68	endp


; =============== S U B	R O U T	I N E =======================================


sub_12F8D	proc near		; CODE XREF: sub_11A98+18p
					; sub_11A98+24p ...
		pusha
		push	ds
		push	es
		mov	cx, dx
		mov	ax, dx
		mul	bx
		mov	dx, cx
		mov	cx, ax
		mov	bp, dx
		mov	ax, 0A800h

loc_12F9F:				; CODE XREF: sub_12F8D+1Fj
					; sub_12F8D+24j
		mov	ds, ax
		assume ds:nothing
		call	sub_14884
		add	di, cx
		add	ah, 8
		cmp	ah, 184
		jbe	short loc_12F9F
		add	ah, 32
		jnb	short loc_12F9F
		pop	es
		pop	ds
		assume ds:nothing
		popa
		retn
sub_12F8D	endp


; =============== S U B	R O U T	I N E =======================================


sub_12FB7	proc near		; CODE XREF: sub_11ACF+1Cp
					; sub_11ACF+28p ...
		pusha
		push	ds
		push	es
		mov	ax, dx
		mul	bx
		mov	bx, ax
		mov	bp, di
		mov	ax, 0A800h
		cld

loc_12FC6:				; CODE XREF: sub_12FB7+23j
					; sub_12FB7+28j
		mov	es, ax
		assume es:nothing
		mov	di, bp
		mov	cx, bx
		shr	cx, 1
		rep movsw
		rcl	cx, 1
		rep movsb
		add	ah, 8
		cmp	ah, 184
		jbe	short loc_12FC6
		add	ah, 32
		jnb	short loc_12FC6
		pop	es
		assume es:nothing
		pop	ds
		popa
		retn
sub_12FB7	endp


; =============== S U B	R O U T	I N E =======================================


sub_12FE5	proc near		; CODE XREF: sub_11BD6+18p
		pusha
		push	ds
		push	es
		mov	ax, 0A800h
		mov	cx, es
		mov	bp, dx

loc_12FEF:				; CODE XREF: sub_12FE5+1Bj
					; sub_12FE5+20j
		mov	ds, ax
		assume ds:nothing
		mov	es, cx
		call	sub_14884
		add	cx, 224
		add	ah, 8
		cmp	ah, 184
		jbe	short loc_12FEF
		add	ah, 32
		jnb	short loc_12FEF
		pop	es
		pop	ds
		assume ds:nothing
		popa
		retn
sub_12FE5	endp


; =============== S U B	R O U T	I N E =======================================


sub_1300B	proc near		; CODE XREF: DrawActionImage:loc_11C3Bp
		pusha
		push	ds
		push	es
		mov	ax, 0A800h
		mov	cx, ds
		mov	bp, dx

loc_13015:				; CODE XREF: sub_1300B+1Aj
					; sub_1300B+1Fj
		mov	es, ax
		assume es:nothing
		mov	ds, cx
		call	sub_148A8
		add	ch, 8
		add	ah, 8
		cmp	ah, 184
		jbe	short loc_13015
		add	ah, 32
		jnb	short loc_13015
		pop	es
		assume es:nothing
		pop	ds
		popa
		retn
sub_1300B	endp


; =============== S U B	R O U T	I N E =======================================


sub_13030	proc near		; CODE XREF: DrawActionImage+58p
		pusha
		push	ds
		push	es
		mov	ax, dx
		mul	bx
		mov	bx, ax
		mov	bp, si
		mov	ax, 0A800h
		cld

loc_1303F:				; CODE XREF: sub_13030+23j
					; sub_13030+28j
		mov	ds, ax
		assume ds:nothing
		mov	si, bp
		mov	cx, bx
		shr	cx, 1
		rep movsw
		rcl	cx, 1
		rep movsb
		add	ah, 8
		cmp	ah, 184
		jbe	short loc_1303F
		add	ah, 32
		jnb	short loc_1303F
		pop	es
		pop	ds
		assume ds:nothing
		popa
		retn
sub_13030	endp


; =============== S U B	R O U T	I N E =======================================


sub_1305E	proc near		; CODE XREF: DrawActionImage+67p
		pusha
		push	ds
		push	es
		mov	cx, dx
		mov	ax, dx
		mul	bx
		mov	dx, cx
		mov	cx, ax
		mov	bp, dx
		mov	ax, 0A800h

loc_13070:				; CODE XREF: sub_1305E+1Fj
					; sub_1305E+24j
		mov	es, ax
		assume es:nothing
		call	sub_148A8
		add	si, cx
		add	ah, 8
		cmp	ah, 184
		jbe	short loc_13070
		add	ah, 32
		jnb	short loc_13070
		pop	es
		assume es:nothing
		pop	ds
		popa
		retn
sub_1305E	endp


; =============== S U B	R O U T	I N E =======================================


sub_13088	proc near		; CODE XREF: DrawActionImage+2Ep
		pusha
		push	ds
		push	es
		mov	ax, 0A800h
		mov	cx, ds
		mov	bp, dx

loc_13092:				; CODE XREF: sub_13088+1Bj
					; sub_13088+20j
		mov	es, ax
		assume es:nothing
		mov	ds, cx
		call	sub_148A8
		add	cx, 224
		add	ah, 8
		cmp	ah, 184
		jbe	short loc_13092
		add	ah, 32
		jnb	short loc_13092
		pop	es
		assume es:nothing
		pop	ds
		popa
		retn
sub_13088	endp


; =============== S U B	R O U T	I N E =======================================


malloc		proc near		; CODE XREF: DoMemoryAlloc+Bp
					; DoMemoryAlloc+16p
		mov	ah, 48h
		int	21h		; DOS -	2+ - ALLOCATE MEMORY
					; BX = number of 16-byte paragraphs desired
		retn
malloc		endp


; =============== S U B	R O U T	I N E =======================================


free		proc near		; CODE XREF: DoMemoryFree+Cp
					; DoMemoryFree+15p
		mov	ah, 49h
		int	21h		; DOS -	2+ - FREE MEMORY
					; ES = segment address of area to be freed
		retn
free		endp


; =============== S U B	R O U T	I N E =======================================


LoadGPA		proc near		; CODE XREF: LoadSFlameGPA+Dp
		push	bx
		push	es
		call	sub_146C3
		call	sub_14658
		pop	es
		pop	bx
		retn
LoadGPA		endp


; =============== S U B	R O U T	I N E =======================================


sub_130C3	proc near		; CODE XREF: seg000:1A06p seg000:1A17p
		pusha
		push	ds
		push	es
		mov	cx, seg	seg001
		mov	ds, cx
		assume ds:seg001
		mov	word_186DE, si
		mov	word_186E0, di
		mov	word_186E4, bx
		mov	word_186E2, dx
		mov	byte_186E6, al
		mov	cx, seg	seg001
		mov	di, offset unk_186E7
		mov	dx, word_186E2
		mov	bp, dx

loc_130EA:				; CODE XREF: sub_130C3+82j
		mov	ax, 0A800h
		mov	bx, word_186E4
		cmp	bx, 4
		jbe	short loc_130F9
		mov	bx, 4

loc_130F9:				; CODE XREF: sub_130C3+31j
					; sub_130C3+66j ...
		call	sub_1314E
		mov	si, seg	seg001
		mov	ds, si
		mov	si, word_186DE
		mov	ds, ax
		assume ds:nothing
		mov	es, cx
		call	sub_14884
		mov	si, di
		call	sub_1314E
		mov	di, seg	seg001
		mov	ds, di
		assume ds:seg001
		mov	di, word_186E0
		mov	ds, cx
		assume ds:nothing
		mov	es, ax
		call	sub_148A8
		mov	di, si
		add	ah, 8
		cmp	ah, 184
		jbe	short loc_130F9
		add	ah, 32
		jnb	short loc_130F9
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		add	word_186DE, 140h
		add	word_186E0, 140h
		sub	word_186E4, bx
		ja	short loc_130EA
		call	GDCPlane_RW0
		pop	es
		pop	ds
		assume ds:nothing
		popa
		retn
sub_130C3	endp


; =============== S U B	R O U T	I N E =======================================


sub_1314E	proc near		; CODE XREF: sub_130C3:loc_130F9p
					; sub_130C3+4Bp
		push	ax
		push	ds
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		cmp	byte_186E6, 0
		jz	short loc_13161
		call	GDCPlane_RW0
		jmp	short loc_13164
; ---------------------------------------------------------------------------

loc_13161:				; CODE XREF: sub_1314E+Cj
		call	GDCPlane_RW1

loc_13164:				; CODE XREF: sub_1314E+11j
		xor	byte_186E6, 1
		pop	ds
		assume ds:nothing
		pop	ax
		retn
sub_1314E	endp


; =============== S U B	R O U T	I N E =======================================


sub_1316C	proc near		; CODE XREF: sub_10528:loc_10530p
		pusha
		push	ds
		push	es
		call	sub_14684
		mov	cx, es
		mov	di, bx
		shr	bx, 4
		add	cx, bx
		and	di, 0Fh
		mov	si, seg	seg001
		mov	ds, si
		assume ds:seg001
		mov	si, offset word_184C8
		xor	ah, ah
		shl	ax, 3
		add	si, ax
		mov	dx, [si]
		mov	bx, [si+2]
		mov	ax, [si+4]
		add	di, [si+6]
		mov	si, ax
		call	sub_131DA
		pop	es
		pop	ds
		assume ds:nothing
		popa
		retn
sub_1316C	endp


; =============== S U B	R O U T	I N E =======================================


sub_131A1	proc near		; CODE XREF: sub_10D2C+9p
					; DoPlayerActionSel+56p
		pusha
		push	ds
		push	es
		call	sub_14684
		mov	cx, es
		mov	si, bx
		shr	bx, 4
		add	cx, bx
		and	si, 0Fh
		push	si
		mov	si, seg	seg001
		mov	ds, si
		assume ds:seg001
		mov	si, offset word_184C8
		xor	ah, ah
		shl	ax, 3
		add	si, ax
		mov	dx, [si]
		mov	bp, dx
		mov	bx, [si+2]
		mov	di, [si+4]
		mov	ax, [si+6]
		pop	si
		add	si, ax
		call	sub_13203
		pop	es
		pop	ds
		assume ds:nothing
		popa
		retn
sub_131A1	endp


; =============== S U B	R O U T	I N E =======================================


sub_131DA	proc near		; CODE XREF: sub_1316C+2Ep
		pusha
		push	ds
		push	es
		call	sub_13237
		mov	bp, ax
		mov	ax, 0A800h

loc_131E5:				; CODE XREF: sub_131DA+1Ej
					; sub_131DA+23j
		push	bp
		mov	ds, ax
		assume ds:nothing
		mov	es, cx
		mov	bp, dx
		call	sub_14884
		pop	bp
		add	di, bp
		add	ah, 8
		cmp	ah, 184
		jbe	short loc_131E5
		add	ah, 32
		jnb	short loc_131E5
		pop	es
		pop	ds
		assume ds:nothing
		popa
		retn
sub_131DA	endp


; =============== S U B	R O U T	I N E =======================================


sub_13203	proc near		; CODE XREF: sub_131A1+32p
		pusha
		push	ds
		push	es
		call	sub_13237
		mov	bp, ax

loc_1320B:				; CODE XREF: sub_13203+2Ej
		push	bx
		push	si
		mov	ax, 0A800h

loc_13210:				; CODE XREF: sub_13203+1Fj
					; sub_13203+24j
		mov	bx, 1
		mov	es, ax
		assume es:nothing
		mov	ds, cx
		call	sub_148A8
		add	si, bp
		add	ah, 8
		cmp	ah, 184
		jbe	short loc_13210
		add	ah, 32
		jnb	short loc_13210
		pop	si
		pop	bx
		add	si, dx
		add	di, 50h	; 'P'
		dec	bx
		jnz	short loc_1320B
		pop	es
		assume es:nothing
		pop	ds
		popa
		retn
sub_13203	endp


; =============== S U B	R O U T	I N E =======================================


sub_13237	proc near		; CODE XREF: sub_131DA+3p sub_13203+3p
		push	dx
		mov	ax, dx
		mul	bx
		pop	dx
		retn
sub_13237	endp


; =============== S U B	R O U T	I N E =======================================


sub_1323E	proc near		; CODE XREF: sub_10B53+21p
		pusha
		push	ds
		push	es
		call	sub_133D2
		mov	di, seg	seg001
		mov	es, di
		assume es:seg001, ds:seg001
		mov	di, offset unk_18847
		call	APICall_PaletteThing
		mov	si, seg	seg001
		mov	ds, si
		mov	si, offset unk_184F2
		mov	byte ptr [si+1], 1
		mov	bx, offset unk_18827
		mov	[si+2],	bx
		mov	byte ptr [si], 1
		mov	word ptr [bx+1Ch], 999h
		call	sub_143F6
		mov	byte ptr [si], 3
		mov	word ptr [bx+1Ch], 0
		call	sub_143F6
		mov	byte ptr [si], 1
		mov	word ptr [bx+1Ch], 0CCCh
		call	sub_143F6
		mov	byte ptr [si], 3
		mov	word ptr [bx+1Ch], 0
		call	sub_143F6
		mov	byte ptr [si], 1
		mov	word ptr [bx+1Ch], 0FFFh
		call	sub_143F6
		mov	byte ptr [si], 3
		mov	word ptr [bx+1Ch], 0
		call	sub_143F6
		pop	es
		assume es:nothing
		pop	ds
		assume ds:nothing
		popa
		retn
sub_1323E	endp


; =============== S U B	R O U T	I N E =======================================


sub_132A7	proc near		; CODE XREF: sub_10B53:loc_10B79p
		pusha
		push	ds
		push	es
		call	sub_133D2
		mov	di, seg	seg001
		mov	es, di
		assume es:seg001
		mov	di, offset unk_18847
		call	APICall_PaletteThing
		mov	si, seg	seg001
		mov	ds, si
		assume ds:seg001
		mov	si, offset unk_184F2
		mov	byte ptr [si+1], 1
		mov	bx, offset unk_18827
		mov	[si+2],	bx
		mov	byte ptr [si], 1
		mov	word ptr [bx+1Ah], 999h
		call	sub_143F6
		mov	byte ptr [si], 3
		mov	word ptr [bx+1Ah], 0
		call	sub_143F6
		mov	byte ptr [si], 1
		mov	word ptr [bx+1Ah], 0CCCh
		call	sub_143F6
		mov	byte ptr [si], 3
		mov	word ptr [bx+1Ah], 0
		call	sub_143F6
		mov	byte ptr [si], 1
		mov	word ptr [bx+1Ah], 0FFFh
		call	sub_143F6
		mov	byte ptr [si], 3
		mov	word ptr [bx+1Ah], 0
		call	sub_143F6
		pop	es
		assume es:nothing
		pop	ds
		assume ds:nothing
		popa
		retn
sub_132A7	endp


; =============== S U B	R O U T	I N E =======================================


sub_13310	proc near		; CODE XREF: ShowSpcAtkImgs+9p
					; ShowSpcAtkImgs+12p ...
		pusha
		push	ds
		push	es
		call	sub_133D2
		mov	di, seg	seg001
		mov	es, di
		assume es:seg001
		mov	di, offset unk_18847
		call	APICall_PaletteThing
		mov	di, seg	seg001
		mov	ds, di
		assume ds:seg001
		mov	es, di
		mov	di, offset unk_18827
		xor	ax, ax
		mov	cx, 10h
		cld

loc_13331:				; CODE XREF: sub_13310+25j
		stosw
		add	ax, 111h
		loop	loc_13331
		mov	si, offset unk_184F2
		mov	byte ptr [si], 1
		mov	byte ptr [si+1], 2
		mov	bx, offset unk_18827
		mov	[si+2],	bx
		call	sub_143F6
		mov	bx, offset unk_18847
		mov	[si+2],	bx
		call	sub_143F6
		pop	es
		assume es:nothing
		pop	ds
		assume ds:nothing
		popa
		retn
sub_13310	endp


; =============== S U B	R O U T	I N E =======================================


sub_13357	proc near		; CODE XREF: ShowSpcAtkImgs+37p
					; ShowSpcAtkImgs+3Ap ...
		pusha
		push	ds
		push	es
		call	sub_133D2
		mov	di, seg	seg001
		mov	es, di
		assume es:seg001
		mov	di, offset unk_18847
		call	APICall_PaletteThing
		mov	di, seg	seg001
		mov	ds, di
		assume ds:seg001
		mov	es, di
		mov	di, offset unk_18827
		mov	ax, 0FFFh
		mov	cx, 10h
		cld
		rep stosw
		mov	si, offset unk_184F2
		mov	byte ptr [si], 1
		mov	byte ptr [si+1], 2
		mov	bx, offset unk_18827
		mov	[si+2],	bx
		call	sub_143F6
		mov	bx, offset unk_18847
		mov	[si+2],	bx
		call	sub_143F6
		pop	es
		assume es:nothing
		pop	ds
		assume ds:nothing
		popa
		retn
sub_13357	endp


; =============== S U B	R O U T	I N E =======================================


sub_1339B	proc near		; CODE XREF: DoFightEnd+3Cp
		pusha
		push	ds
		push	es
		call	sub_133D2
		mov	di, seg	seg001
		mov	es, di
		assume es:seg001
		mov	di, offset unk_18847
		call	APICall_PaletteThing
		mov	si, seg	seg001
		mov	ds, si
		assume ds:seg001
		mov	si, offset unk_184F2
		mov	byte ptr [si], 1
		mov	byte ptr [si+1], 0Ch
		mov	bx, offset unk_18827
		mov	[si+2],	bx
		mov	word ptr [bx+0Ch], 3F0h
		mov	word ptr [bx+0Eh], 5F2h
		call	sub_143F6
		pop	es
		assume es:nothing
		pop	ds
		assume ds:nothing
		popa
		retn
sub_1339B	endp


; =============== S U B	R O U T	I N E =======================================


sub_133D2	proc near		; CODE XREF: sub_1323E+3p sub_132A7+3p ...
		push	ax
		push	cx
		push	di
		push	es
		mov	di, seg	seg001
		mov	es, di
		assume es:seg001
		mov	di, offset unk_18827
		mov	ax, 0FFFFh
		mov	cx, 10h
		cld
		rep stosw
		pop	es
		assume es:nothing
		pop	di
		pop	cx
		pop	ax
		retn
sub_133D2	endp


; =============== S U B	R O U T	I N E =======================================


sub_133EC	proc near		; CODE XREF: ShowSpcAtkImgs+51p
		push	bx
		push	dx
		push	si
		push	di
		push	ds
		xor	di, di
		mov	bx, 19h
		mov	dx, 50h
		call	FillTRAM
		mov	si, seg	seg001
		mov	ds, si
		assume ds:seg001
		mov	si, offset word_184E4
		call	sub_1402E
		pop	ds
		assume ds:nothing
		pop	di
		pop	si
		pop	dx
		pop	bx
		retn
sub_133EC	endp


; =============== S U B	R O U T	I N E =======================================


sub_1340D	proc near		; CODE XREF: ShowSpcAtkImgs+59p
		push	ax
		push	cx
		mov	cx, 0Ch

loc_13412:				; CODE XREF: sub_1340D+13j
		call	WaitForVInt
		mov	ah, 41h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		call	WaitForVInt
		mov	ah, 40h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		loop	loc_13412
		pop	cx
		pop	ax
		retn
sub_1340D	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_13426	proc near		; CODE XREF: sub_12EEB+Ap
		pusha
		push	ds
		push	es
		call	sub_13436
		call	sub_1343A
		call	nullsub_1
		pop	es
		pop	ds
		popa
		retn
sub_13426	endp


; =============== S U B	R O U T	I N E =======================================


sub_13436	proc near		; CODE XREF: sub_13426+3p
		call	sub_13442
		retn
sub_13436	endp


; =============== S U B	R O U T	I N E =======================================


sub_1343A	proc near		; CODE XREF: sub_13426+6p
		call	sub_13459
		call	sub_13474
		retn
sub_1343A	endp


; =============== S U B	R O U T	I N E =======================================


nullsub_1	proc near		; CODE XREF: sub_13426+9p
		retn
nullsub_1	endp


; =============== S U B	R O U T	I N E =======================================


sub_13442	proc near		; CODE XREF: sub_13436p
		mov	bp, ds
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		mov	es, ax
		assume es:seg001
		mov	word ptr dword_18868+2,	bp
		mov	word ptr dword_18868, si
		mov	byte_1886C, 0
		retn
sub_13442	endp


; =============== S U B	R O U T	I N E =======================================


sub_13459	proc near		; CODE XREF: sub_1343Ap
		pusha
		push	ds
		push	es
		mov	si, seg	seg001
		mov	ds, si
		mov	es, si
		lds	si, dword_18868
		mov	di, offset word_1886D
		cld
		movsw
		mov	di, offset word_1886F
		movsw
		pop	es
		assume es:nothing
		pop	ds
		assume ds:nothing
		popa
		retn
sub_13459	endp


; =============== S U B	R O U T	I N E =======================================


sub_13474	proc near		; CODE XREF: sub_1343A+3p
		pusha
		push	ds
		push	es
		call	sub_13494
		mov	cx, seg	seg001
		mov	ds, cx
		assume ds:seg001
		mov	cx, word_1886D

loc_13483:				; CODE XREF: sub_13474+18j
					; sub_13474+1Aj
		call	sub_134A7
		or	ax, ax
		jnz	short loc_13490
		or	cx, cx
		jz	short loc_13483
		loop	loc_13483

loc_13490:				; CODE XREF: sub_13474+14j
		pop	es
		pop	ds
		popa
		retn
sub_13474	endp


; =============== S U B	R O U T	I N E =======================================


sub_13494	proc near		; CODE XREF: sub_13474+3p
		push	ax
		push	bx

loc_13496:				; CODE XREF: sub_13494+7j sub_13494+Ej
		call	Mouse_SetHRange2
		test	al, al
		jnz	short loc_13496
		call	sub_13503
		test	bh, bh
		jnz	short loc_13496
		pop	bx
		pop	ax
		retn
sub_13494	endp


; =============== S U B	R O U T	I N E =======================================


sub_134A7	proc near		; CODE XREF: sub_13474:loc_13483p
		push	bx
		push	cx
		push	ds
		call	WaitForVInt
		mov	bl, frameCounter

loc_134B1:				; CODE XREF: sub_134A7+22j
		call	sub_13524
		call	sub_134D1
		call	sub_134D6
		or	ax, ax
		jnz	short loc_134CD
		call	sub_134EE
		or	ax, ax
		jnz	short loc_134CD
		cmp	bl, frameCounter
		jz	short loc_134B1
		xor	ax, ax

loc_134CD:				; CODE XREF: sub_134A7+15j
					; sub_134A7+1Cj
		pop	ds
		pop	cx
		pop	bx
		retn
sub_134A7	endp


; =============== S U B	R O U T	I N E =======================================


sub_134D1	proc near		; CODE XREF: sub_134A7+Dp
		mov	ah, 1
		int	0F1h		; reserved for user interrupt
		retn
sub_134D1	endp


; =============== S U B	R O U T	I N E =======================================


sub_134D6	proc near		; CODE XREF: sub_134A7+10p
		cmp	word_1886F, 0
		jz	short loc_134EB
		call	sub_13512
		test	al, 1
		jnz	short locret_134ED
		call	Mouse_SetHRange2
		or	ah, ah
		jnz	short locret_134ED

loc_134EB:				; CODE XREF: sub_134D6+5j
		xor	ax, ax

locret_134ED:				; CODE XREF: sub_134D6+Cj
					; sub_134D6+13j
		retn
sub_134D6	endp


; =============== S U B	R O U T	I N E =======================================


sub_134EE	proc near		; CODE XREF: sub_134A7+17p
		call	Mouse_SetHRange2
		test	al, al
		jnz	short locret_13502
		call	sub_13503
		cmp	al, 0Dh
		jz	short locret_13502
		cmp	al, 20h
		jz	short locret_13502
		xor	ax, ax

locret_13502:				; CODE XREF: sub_134EE+5j sub_134EE+Cj ...
		retn
sub_134EE	endp


; =============== S U B	R O U T	I N E =======================================


sub_13503	proc near		; CODE XREF: sub_13494+9p sub_134EE+7p
		mov	ah, 1
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		xor	al, al
		or	bh, bh
		jz	short locret_13511
		xor	ah, ah
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all

locret_13511:				; CODE XREF: sub_13503+8j
		retn
sub_13503	endp


; =============== S U B	R O U T	I N E =======================================


sub_13512	proc near		; CODE XREF: sub_134D6+7p
		mov	ah, 2
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		retn
sub_13512	endp

; ---------------------------------------------------------------------------
		push	ax
		mov	ah, 0Bh
		int	0F1h		; reserved for user interrupt
		pop	ax
		retn

; =============== S U B	R O U T	I N E =======================================


Mouse_SetHRange2 proc near		; CODE XREF: sub_13494:loc_13496p
					; sub_134D6+Ep	...
		mov	ax, 7
		int	33h		; - MS MOUSE - DEFINE HORIZONTAL CURSOR	RANGE
					; CX = minimum column, DX = maximum column
		retn
Mouse_SetHRange2 endp


; =============== S U B	R O U T	I N E =======================================


sub_13524	proc near		; CODE XREF: sub_134A7:loc_134B1p
		push	ax
		mov	ah, 0Fh
		int	0F3h
		pop	ax
		retn
sub_13524	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


WaitForClick	proc near		; CODE XREF: ScrSelect_Action+15p
					; ScrSelect_Action:loc_10F99p ...
		pusha
		push	ds
		push	es
		call	sub_1353C
		call	sub_13540
		call	nullsub_2
		pop	es
		pop	ds
		assume ds:nothing
		popa
		retn
WaitForClick	endp


; =============== S U B	R O U T	I N E =======================================


sub_1353C	proc near		; CODE XREF: WaitForClick+3p
		call	sub_1354E
		retn
sub_1353C	endp


; =============== S U B	R O U T	I N E =======================================


sub_13540	proc near		; CODE XREF: WaitForClick+6p
		call	sub_13565
		call	sub_135AC
		call	sub_13615
		call	sub_1362E
		retn
sub_13540	endp


; =============== S U B	R O U T	I N E =======================================


nullsub_2	proc near		; CODE XREF: WaitForClick+9p
		retn
nullsub_2	endp


; =============== S U B	R O U T	I N E =======================================


sub_1354E	proc near		; CODE XREF: sub_1353Cp
		mov	bp, ds
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		mov	es, ax
		assume es:seg001
		mov	word ptr dword_18872+2,	bp
		mov	word ptr dword_18872, si
		mov	byte_18876, 0
		retn
sub_1354E	endp


; =============== S U B	R O U T	I N E =======================================


sub_13565	proc near		; CODE XREF: sub_13540p
		pusha
		push	ds
		push	es
		mov	si, seg	seg001
		mov	ds, si
		mov	es, si
		lds	si, dword_18872
		cld
		lodsb
		cmp	al, 3
		ja	short loc_13587
		mov	es:byte_18879, al
		mov	di, offset word_1887A
		mov	cx, 2
		rep movsw
		jmp	short loc_1358A
; ---------------------------------------------------------------------------

loc_13587:				; CODE XREF: sub_13565+12j
		call	sub_1358E

loc_1358A:				; CODE XREF: sub_13565+20j
		pop	es
		assume es:nothing
		pop	ds
		assume ds:nothing
		popa
		retn
sub_13565	endp


; =============== S U B	R O U T	I N E =======================================


sub_1358E	proc near		; CODE XREF: sub_13565:loc_13587p
					; sub_135C7+13p ...
		push	ax
		push	ds
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		mov	byte_18876, 1
		pop	ds
		assume ds:nothing
		pop	ax
		retn
sub_1358E	endp


; =============== S U B	R O U T	I N E =======================================


sub_1359D	proc near		; CODE XREF: sub_135AC+2p sub_13615+2p ...
		push	ax
		push	ds
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		cmp	byte_18876, 0
		pop	ds
		assume ds:nothing
		pop	ax
		retn
sub_1359D	endp


; =============== S U B	R O U T	I N E =======================================


sub_135AC	proc near		; CODE XREF: sub_13540+3p
		push	ax
		push	ds
		call	sub_1359D
		jnz	short loc_135C4
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		mov	al, byte_18879
		call	sub_135C7
		call	sub_135DF
		call	sub_135FF

loc_135C4:				; CODE XREF: sub_135AC+5j
		pop	ds
		pop	ax
		retn
sub_135AC	endp


; =============== S U B	R O U T	I N E =======================================


sub_135C7	proc near		; CODE XREF: sub_135AC+Fp
		push	ax
		or	al, al
		jnz	short loc_135DD
		mov	ax, word_1887A
		mov	word ptr dword_18502, ax
		mov	ax, word_1887C
		mov	word ptr dword_18502+2,	ax
		jmp	short loc_135DD
; ---------------------------------------------------------------------------
		call	sub_1358E

loc_135DD:				; CODE XREF: sub_135C7+3j
					; sub_135C7+11j
		pop	ax
		retn
sub_135C7	endp


; =============== S U B	R O U T	I N E =======================================


sub_135DF	proc near		; CODE XREF: sub_135AC+12p
		push	ax
		cmp	al, 1
		jnz	short loc_135FD
		mov	ax, word_1887A
		cmp	al, 1
		ja	short loc_135FA
		mov	byte_1887E, al
		mov	ax, word_1887C
		cmp	al, 1
		ja	short loc_135FA
		mov	byte_1887F, al
		jmp	short loc_135FD
; ---------------------------------------------------------------------------

loc_135FA:				; CODE XREF: sub_135DF+Aj
					; sub_135DF+14j
		call	sub_1358E

loc_135FD:				; CODE XREF: sub_135DF+3j
					; sub_135DF+19j
		pop	ax
		retn
sub_135DF	endp


; =============== S U B	R O U T	I N E =======================================


sub_135FF	proc near		; CODE XREF: sub_135AC+15p
		push	ax
		cmp	al, 2
		jnz	short loc_13613
		mov	ax, word_1887A
		cmp	al, 2
		ja	short loc_13610
		mov	byte_18880, al
		jmp	short loc_13613
; ---------------------------------------------------------------------------

loc_13610:				; CODE XREF: sub_135FF+Aj
		call	sub_1358E

loc_13613:				; CODE XREF: sub_135FF+3j sub_135FF+Fj
		pop	ax
		retn
sub_135FF	endp


; =============== S U B	R O U T	I N E =======================================


sub_13615	proc near		; CODE XREF: sub_13540+6p
		push	ax
		push	ds
		call	sub_1359D
		jnz	short loc_1362B
		mov	ax, seg	seg001
		mov	ds, ax
		cmp	word ptr dword_18502, 0FFFFh
		jnz	short loc_1362B
		call	sub_1358E

loc_1362B:				; CODE XREF: sub_13615+5j
					; sub_13615+11j
		pop	ds
		assume ds:nothing
		pop	ax
		retn
sub_13615	endp


; =============== S U B	R O U T	I N E =======================================


sub_1362E	proc near		; CODE XREF: sub_13540+9p
		push	ax
		push	ds
		call	sub_1359D
		jnz	short loc_13646
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		mov	al, byte_18879
		call	sub_13697
		call	sub_13649
		call	sub_13679

loc_13646:				; CODE XREF: sub_1362E+5j
		pop	ds
		pop	ax
		retn
sub_1362E	endp


; =============== S U B	R O U T	I N E =======================================


sub_13649	proc near		; CODE XREF: sub_1362E+12p
		pusha
		push	ds
		push	es
		cmp	al, 2
		jnz	short loc_13675
		call	sub_136E1
		call	sub_136FE
		call	sub_13717
		call	sub_1373A
		mov	al, byte_18880
		mov	byte_184FC, al
		call	sub_13968
		lds	si, dword_18502
		mov	bl, 18h
		mul	bl
		add	si, ax
		call	sub_138C8
		call	sub_13FE6

loc_13675:				; CODE XREF: sub_13649+5j
		pop	es
		pop	ds
		popa
		retn
sub_13649	endp


; =============== S U B	R O U T	I N E =======================================


sub_13679	proc near		; CODE XREF: sub_1362E+15p
		pusha
		push	ds
		push	es
		cmp	al, 3
		jnz	short loc_13693
		mov	byte_1887E, 1
		call	sub_136E1
		call	sub_136FE
		call	sub_13FE6
		mov	byte_184FC, 0FFh

loc_13693:				; CODE XREF: sub_13679+5j
		pop	es
		pop	ds
		popa
		retn
sub_13679	endp


; =============== S U B	R O U T	I N E =======================================


sub_13697	proc near		; CODE XREF: sub_1362E+Fp
		cmp	al, 1
		jnz	short locret_136CF
		call	sub_136D0
		call	sub_136E1
		call	sub_136FE
		call	sub_13717
		call	sub_1373A
		call	sub_13FDA

loc_136AD:				; CODE XREF: sub_13697+2Dj
		call	sub_1359D
		jnz	short loc_136CC
		call	sub_1401D
		call	sub_13749
		call	sub_1376B
		call	sub_137B3
		call	sub_137EC
		call	sub_13808
		jz	short loc_136AD
		call	sub_1381E
		call	sub_1385F

loc_136CC:				; CODE XREF: sub_13697+19j
		call	sub_13FE6

locret_136CF:				; CODE XREF: sub_13697+2j
		retn
sub_13697	endp


; =============== S U B	R O U T	I N E =======================================


sub_136D0	proc near		; CODE XREF: sub_13697+4p
		pusha

loc_136D1:				; CODE XREF: sub_136D0+9j sub_136D0+Dj
		call	sub_1401D
		call	sub_13FF2
		or	ax, ax
		jnz	short loc_136D1
		or	bx, bx
		jnz	short loc_136D1
		popa
		retn
sub_136D0	endp


; =============== S U B	R O U T	I N E =======================================


sub_136E1	proc near		; CODE XREF: sub_13649+7p sub_13679+Cp ...
		pusha
		push	ds
		push	es
		mov	si, seg	seg001
		mov	ds, si
		cmp	byte_1887E, 1
		jnz	short loc_136FA
		mov	al, byte_184FC
		cmp	al, 0FFh
		jz	short loc_136FA
		call	sub_1399D

loc_136FA:				; CODE XREF: sub_136E1+Dj
					; sub_136E1+14j
		pop	es
		pop	ds
		assume ds:nothing
		popa
		retn
sub_136E1	endp


; =============== S U B	R O U T	I N E =======================================


sub_136FE	proc near		; CODE XREF: sub_13649+Ap sub_13679+Fp ...
		push	ax
		push	ds
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		cmp	word ptr dword_184FE+2,	0FFFFh
		jz	short loc_13714
		call	sub_13A34
		jnb	short loc_13714
		call	sub_1358E

loc_13714:				; CODE XREF: sub_136FE+Cj
					; sub_136FE+11j
		pop	ds
		assume ds:nothing
		pop	ax
		retn
sub_136FE	endp


; =============== S U B	R O U T	I N E =======================================


sub_13717	proc near		; CODE XREF: sub_13649+Dp sub_13697+Dp
		push	cx
		push	dx
		push	ds
		mov	cx, seg	seg001
		mov	ds, cx
		assume ds:seg001
		cmp	byte_1887F, 0
		jz	short loc_13736
		mov	cx, word_184F8
		cmp	cx, 0FFFFh
		jz	short loc_13736
		mov	dx, word_184FA
		call	sub_14002

loc_13736:				; CODE XREF: sub_13717+Dj
					; sub_13717+16j
		pop	ds
		assume ds:nothing
		pop	dx
		pop	cx
		retn
sub_13717	endp


; =============== S U B	R O U T	I N E =======================================


sub_1373A	proc near		; CODE XREF: sub_13649+10p
					; sub_13697+10p
		push	ax
		push	ds
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		mov	byte_184FD, 0FFh
		pop	ds
		assume ds:nothing
		pop	ax
		retn
sub_1373A	endp


; =============== S U B	R O U T	I N E =======================================


sub_13749	proc near		; CODE XREF: sub_13697+1Ep
		push	ax
		push	bx
		push	cx
		push	dx
		push	ds
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		call	sub_13FF2
		mov	word_18898, ax
		mov	word_1889A, bx
		mov	word_1889C, cx
		mov	word_1889E, dx
		pop	ds
		assume ds:nothing
		pop	dx
		pop	cx
		pop	bx
		pop	ax
		retn
sub_13749	endp


; =============== S U B	R O U T	I N E =======================================


sub_1376B	proc near		; CODE XREF: sub_13697+21p
		pusha
		push	ds
		push	es
		mov	si, seg	seg001
		mov	ds, si
		assume ds:seg001
		mov	es, si
		assume es:seg001
		mov	cx, word_1889C
		mov	dx, word_1889E
		lds	si, dword_18502
		assume ds:nothing
		call	sub_1378C
		mov	es:byte_184FC, al
		pop	es
		assume es:nothing
		pop	ds
		popa
		retn
sub_1376B	endp


; =============== S U B	R O U T	I N E =======================================


sub_1378C	proc near		; CODE XREF: sub_1376B+16p
		push	bx
		push	si
		xor	ax, ax
		mov	bx, 3

loc_13793:				; CODE XREF: sub_1378C+1Fj
		cmp	[si], cx
		ja	short loc_137A6
		cmp	[si+2],	dx
		ja	short loc_137A6
		cmp	[si+4],	cx
		jb	short loc_137A6
		cmp	[si+6],	dx
		jnb	short loc_137B0

loc_137A6:				; CODE XREF: sub_1378C+9j sub_1378C+Ej ...
		inc	ax
		add	si, 18h
		dec	bx
		jnz	short loc_13793
		mov	ax, 0FFFFh

loc_137B0:				; CODE XREF: sub_1378C+18j
		pop	si
		pop	bx
		retn
sub_1378C	endp


; =============== S U B	R O U T	I N E =======================================


sub_137B3	proc near		; CODE XREF: sub_13697+24p
		pusha
		push	ds
		push	es
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		mov	al, byte_184FD
		cmp	byte_184FC, al
		jz	short loc_137E8
		cmp	al, 0FFh
		jz	short loc_137CE
		call	sub_1400E
		call	sub_1399D

loc_137CE:				; CODE XREF: sub_137B3+13j
		mov	al, byte_184FC
		cmp	al, 0FFh
		jz	short loc_137E8
		call	sub_13968
		lds	si, dword_18502
		assume ds:nothing
		mov	bl, 18h
		mul	bl
		add	si, ax
		call	sub_1400E
		call	sub_1389A

loc_137E8:				; CODE XREF: sub_137B3+Fj
					; sub_137B3+20j
		pop	es
		pop	ds
		popa
		retn
sub_137B3	endp


; =============== S U B	R O U T	I N E =======================================


sub_137EC	proc near		; CODE XREF: sub_13697+27p
		push	ax
		push	ds
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		mov	ax, word_1889C
		mov	word_184F8, ax
		mov	ax, word_1889E
		mov	word_184FA, ax
		mov	al, byte_184FC
		mov	byte_184FD, al
		pop	ds
		assume ds:nothing
		pop	ax
		retn
sub_137EC	endp


; =============== S U B	R O U T	I N E =======================================


sub_13808	proc near		; CODE XREF: sub_13697+2Ap
		push	ax
		push	ds
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		cmp	word_18898, 0
		jnz	short loc_1381B
		cmp	word_1889A, 0

loc_1381B:				; CODE XREF: sub_13808+Cj
		pop	ds
		assume ds:nothing
		pop	ax
		retn
sub_13808	endp


; =============== S U B	R O U T	I N E =======================================


sub_1381E	proc near		; CODE XREF: sub_13697+2Fp
		pusha
		push	ds
		push	es
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		cmp	word_18898, 0
		jnz	short loc_13834
		cmp	word_1889A, 0
		jz	short loc_1385B

loc_13834:				; CODE XREF: sub_1381E+Dj
		mov	al, byte_184FC
		cmp	al, 0FFh
		jz	short loc_1385B
		call	sub_1400E
		call	sub_1399D
		cmp	word_1889A, 0
		jnz	short loc_1385B
		call	sub_13968
		lds	si, dword_18502
		assume ds:nothing
		mov	bl, 18h
		mul	bl
		add	si, ax
		call	sub_1400E
		call	sub_138C8

loc_1385B:				; CODE XREF: sub_1381E+14j
					; sub_1381E+1Bj ...
		pop	es
		pop	ds
		popa
		retn
sub_1381E	endp


; =============== S U B	R O U T	I N E =======================================


sub_1385F	proc near		; CODE XREF: sub_13697+32p
		pusha
		push	ds
		push	es
		mov	si, seg	seg001
		mov	ds, si
		assume ds:seg001
		cmp	word_1889A, 0
		jz	short loc_13873
		mov	byte_184FC, 0FFh

loc_13873:				; CODE XREF: sub_1385F+Dj
		mov	al, byte_184FC
		cmp	al, 0FFh
		jnz	short loc_1387C
		mov	al, 3

loc_1387C:				; CODE XREF: sub_1385F+19j
		lds	si, dword_18502
		assume ds:nothing
		mov	bl, 18h
		mul	bl
		add	si, ax
		mov	al, [si+15h]
		cbw
		mov	si, seg	seg001
		mov	ds, si
		assume ds:seg001
		lds	si, dword_18872
		assume ds:nothing
		mov	[si+5],	ax
		pop	es
		pop	ds
		popa
		retn
sub_1385F	endp


; =============== S U B	R O U T	I N E =======================================


sub_1389A	proc near		; CODE XREF: sub_137B3+32p
		push	ax
		mov	al, [si+10h]
		cmp	al, 1
		jnz	short loc_138AA
		mov	al, [si+11h]
		call	sub_138F6
		jmp	short loc_138C6
; ---------------------------------------------------------------------------

loc_138AA:				; CODE XREF: sub_1389A+6j
		cmp	al, 2
		jnz	short loc_138B3
		call	sub_13908
		jmp	short loc_138C6
; ---------------------------------------------------------------------------

loc_138B3:				; CODE XREF: sub_1389A+12j
		cmp	al, 3
		jnz	short loc_138BC
		call	sub_13911
		jmp	short loc_138C6
; ---------------------------------------------------------------------------

loc_138BC:				; CODE XREF: sub_1389A+1Bj
		cmp	al, 4
		jnz	short loc_138C6
		mov	al, [si+11h]
		call	sub_138FF

loc_138C6:				; CODE XREF: sub_1389A+Ej
					; sub_1389A+17j ...
		pop	ax
		retn
sub_1389A	endp


; =============== S U B	R O U T	I N E =======================================


sub_138C8	proc near		; CODE XREF: sub_13649+26p
					; sub_1381E+3Ap
		push	ax
		mov	al, [si+12h]
		cmp	al, 1
		jnz	short loc_138D8
		mov	al, [si+13h]
		call	sub_138F6
		jmp	short loc_138F4
; ---------------------------------------------------------------------------

loc_138D8:				; CODE XREF: sub_138C8+6j
		cmp	al, 2
		jnz	short loc_138E1
		call	sub_13908
		jmp	short loc_138F4
; ---------------------------------------------------------------------------

loc_138E1:				; CODE XREF: sub_138C8+12j
		cmp	al, 3
		jnz	short loc_138EA
		call	sub_13911
		jmp	short loc_138F4
; ---------------------------------------------------------------------------

loc_138EA:				; CODE XREF: sub_138C8+1Bj
		cmp	al, 4
		jnz	short loc_138F4
		mov	al, [si+13h]
		call	sub_138FF

loc_138F4:				; CODE XREF: sub_138C8+Ej
					; sub_138C8+17j ...
		pop	ax
		retn
sub_138C8	endp


; =============== S U B	R O U T	I N E =======================================


sub_138F6	proc near		; CODE XREF: sub_1389A+Bp sub_138C8+Bp
		push	si
		add	si, 8
		call	sub_13B0A
		pop	si
		retn
sub_138F6	endp


; =============== S U B	R O U T	I N E =======================================


sub_138FF	proc near		; CODE XREF: sub_1389A+29p
					; sub_138C8+29p
		push	si
		add	si, 8
		call	sub_13BE0
		pop	si
		retn
sub_138FF	endp


; =============== S U B	R O U T	I N E =======================================


sub_13908	proc near		; CODE XREF: sub_1389A+14p
					; sub_138C8+14p
		push	si
		add	si, 8
		call	sub_13DF0
		pop	si
		retn
sub_13908	endp


; =============== S U B	R O U T	I N E =======================================


sub_13911	proc near		; CODE XREF: sub_1389A+1Dp
					; sub_138C8+1Dp
		push	si
		add	si, 8
		call	sub_13E09
		pop	si
		retn
sub_13911	endp


; =============== S U B	R O U T	I N E =======================================


sub_1391A	proc near		; CODE XREF: sub_13B0A+6p sub_13BE0+9p ...
		push	ax
		push	bx
		push	ds
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		mov	ax, word_18885
		mov	bx, word_18881
		call	sub_1395C
		mov	word_18889, ax
		mov	ax, word_18883
		sub	ax, word_18881
		inc	ax
		mov	word_1888B, ax
		mov	ax, word_18887
		sub	ax, word_18885
		inc	ax
		mov	word_1888D, ax
		cmp	word_1888B, 1
		jnz	short loc_13958
		mov	al, byte_18890
		and	byte_1888F, al
		mov	byte_18890, 0

loc_13958:				; CODE XREF: sub_1391A+30j
		pop	ds
		assume ds:nothing
		pop	bx
		pop	ax
		retn
sub_1391A	endp


; =============== S U B	R O U T	I N E =======================================


sub_1395C	proc near		; CODE XREF: sub_1391A+Fp
					; sub_139D2+19p
		push	cx
		push	dx
		mov	cx, 50h	; 'P'
		mul	cx
		add	ax, bx
		pop	dx
		pop	cx
		retn
sub_1395C	endp


; =============== S U B	R O U T	I N E =======================================


sub_13968	proc near		; CODE XREF: sub_13649+19p
					; sub_137B3+22p ...
		pusha
		push	ds
		push	es
		mov	si, seg	seg001
		mov	ds, si
		assume ds:seg001
		lds	si, dword_18502
		assume ds:nothing
		mov	bl, 18h
		mul	bl
		add	si, ax
		call	sub_139D2
		call	sub_139FC
		jb	short loc_13996
		mov	bp, seg	seg001
		mov	ds, bp
		assume ds:seg001
		les	di, dword_184FE
		call	sub_13FE6
		call	sub_13A5B
		call	sub_13FDA
		jmp	short loc_13999
; ---------------------------------------------------------------------------

loc_13996:				; CODE XREF: sub_13968+18j
		call	sub_1358E

loc_13999:				; CODE XREF: sub_13968+2Cj
		pop	es
		pop	ds
		assume ds:nothing
		popa
		retn
sub_13968	endp


; =============== S U B	R O U T	I N E =======================================


sub_1399D	proc near		; CODE XREF: sub_136E1+16p
					; sub_137B3+18p ...
		pusha
		push	ds
		push	es
		mov	si, seg	seg001
		mov	ds, si
		assume ds:seg001
		lds	si, dword_18502
		assume ds:nothing
		mov	bl, 18h
		mul	bl
		add	si, ax
		call	sub_139D2
		mov	di, si
		mov	bp, seg	seg001
		mov	ds, bp
		assume ds:seg001
		lds	si, dword_184FE
		assume ds:nothing
		call	sub_13FE6
		call	sub_13A83
		call	sub_13FDA
		call	sub_13A34
		jnb	short loc_139CE
		call	sub_1358E

loc_139CE:				; CODE XREF: sub_1399D+2Cj
		pop	es
		pop	ds
		popa
		retn
sub_1399D	endp


; =============== S U B	R O U T	I N E =======================================


sub_139D2	proc near		; CODE XREF: sub_13968+12p
					; sub_1399D+12p
		push	ax
		mov	bx, [si+8]
		shr	bx, 3
		mov	cx, [si+0Ch]
		shr	cx, 3
		sub	cx, bx
		inc	cx
		mov	ax, [si+0Ah]
		mov	dx, [si+0Eh]
		sub	dx, ax
		inc	dx
		call	sub_1395C
		mov	si, ax
		mov	bx, dx
		mov	ax, dx
		mul	cx
		mov	dx, bx
		mov	bx, ax
		pop	ax
		retn
sub_139D2	endp


; =============== S U B	R O U T	I N E =======================================


sub_139FC	proc near		; CODE XREF: sub_13968+15p
		pusha
		push	ds
		push	es
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		cmp	word ptr dword_184FE+2,	0FFFFh
		jz	short loc_13A0E
		stc
		jmp	short loc_13A1D
; ---------------------------------------------------------------------------

loc_13A0E:				; CODE XREF: sub_139FC+Dj
		call	sub_13A21
		jb	short loc_13A1D
		mov	word ptr dword_184FE+2,	ax
		mov	word ptr dword_184FE, 0
		clc

loc_13A1D:				; CODE XREF: sub_139FC+10j
					; sub_139FC+15j
		pop	es
		pop	ds
		assume ds:nothing
		popa
		retn
sub_139FC	endp


; =============== S U B	R O U T	I N E =======================================


sub_13A21	proc near		; CODE XREF: sub_139FC:loc_13A0Ep
		push	cx
		push	dx
		push	si
		push	di
		push	bp
		push	ds
		push	es
		mov	ah, 48h
		int	21h		; DOS -	2+ - ALLOCATE MEMORY
					; BX = number of 16-byte paragraphs desired
		pop	es
		pop	ds
		pop	bp
		pop	di
		pop	si
		pop	dx
		pop	cx
		retn
sub_13A21	endp


; =============== S U B	R O U T	I N E =======================================


sub_13A34	proc near		; CODE XREF: sub_136FE+Ep
					; sub_1399D+29p
		pusha
		push	ds
		push	es
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		mov	es, word ptr dword_184FE+2
		call	free2
		jb	short loc_13A4C
		mov	word ptr dword_184FE+2,	0FFFFh
		clc

loc_13A4C:				; CODE XREF: sub_13A34+Fj
		pop	es
		pop	ds
		assume ds:nothing
		popa
		retn
sub_13A34	endp


; =============== S U B	R O U T	I N E =======================================


free2		proc near		; CODE XREF: sub_13A34+Cp
		pusha
		push	ds
		push	es
		mov	ah, 49h
		int	21h		; DOS -	2+ - FREE MEMORY
					; ES = segment address of area to be freed
		pop	es
		pop	ds
		popa
		retn
free2		endp


; =============== S U B	R O U T	I N E =======================================


sub_13A5B	proc near		; CODE XREF: sub_13968+26p
		pusha
		push	ds
		push	es
		mov	ax, bx
		mov	bx, dx
		mov	dx, cx
		mov	bp, dx
		mov	cx, ax
		mov	ax, 0A800h

loc_13A6B:				; CODE XREF: sub_13A5B+1Dj
					; sub_13A5B+22j
		mov	ds, ax
		assume ds:nothing
		call	sub_13AC2
		add	di, cx
		add	ah, 8
		cmp	ah, 0B8h ; '∏'
		jbe	short loc_13A6B
		add	ah, 20h	; ' '
		jnb	short loc_13A6B
		pop	es
		pop	ds
		assume ds:nothing
		popa
		retn
sub_13A5B	endp


; =============== S U B	R O U T	I N E =======================================


sub_13A83	proc near		; CODE XREF: sub_1399D+23p
		pusha
		push	ds
		push	es
		mov	ax, bx
		mov	bx, dx
		mov	dx, cx
		mov	bp, dx
		mov	cx, ax

loc_13A90:				; CODE XREF: sub_13A83+16j
		call	sub_13A9F
		add	si, bp
		add	di, 50h	; 'P'
		dec	bx
		jnz	short loc_13A90
		pop	es
		pop	ds
		popa
		retn
sub_13A83	endp


; =============== S U B	R O U T	I N E =======================================


sub_13A9F	proc near		; CODE XREF: sub_13A83:loc_13A90p
		push	ax
		push	bx
		push	si
		push	es
		mov	bx, 1
		mov	ax, 0A800h

loc_13AA9:				; CODE XREF: sub_13A9F+17j
					; sub_13A9F+1Cj
		mov	es, ax
		assume es:nothing
		call	sub_13AE6
		add	si, cx
		add	ah, 8
		cmp	ah, 0B8h ; '∏'
		jbe	short loc_13AA9
		add	ah, 20h	; ' '
		jnb	short loc_13AA9
		pop	es
		assume es:nothing
		pop	si
		pop	bx
		pop	ax
		retn
sub_13A9F	endp


; =============== S U B	R O U T	I N E =======================================


sub_13AC2	proc near		; CODE XREF: sub_13A5B+12p
		pusha
		cld
		mov	ax, 50h	; 'P'
		sub	ax, dx
		sub	bp, dx

loc_13ACB:				; CODE XREF: sub_13AC2+20j
		mov	cx, dx
		test	si, 1
		jz	short loc_13AD5
		movsb
		dec	cx

loc_13AD5:				; CODE XREF: sub_13AC2+Fj
		shr	cx, 1
		rep movsw
		rcl	cx, 1
		rep movsb
		add	si, ax
		add	di, bp
		dec	bx
		jnz	short loc_13ACB
		popa
		retn
sub_13AC2	endp


; =============== S U B	R O U T	I N E =======================================


sub_13AE6	proc near		; CODE XREF: sub_13A9F+Cp
		pusha
		cld
		mov	ax, 50h	; 'P'
		sub	ax, dx
		sub	bp, dx

loc_13AEF:				; CODE XREF: sub_13AE6+20j
		mov	cx, dx
		test	di, 1
		jz	short loc_13AF9
		movsb
		dec	cx

loc_13AF9:				; CODE XREF: sub_13AE6+Fj
		shr	cx, 1
		rep movsw
		rcl	cx, 1
		rep movsb
		add	si, bp
		add	di, ax
		dec	bx
		jnz	short loc_13AEF
		popa
		retn
sub_13AE6	endp


; =============== S U B	R O U T	I N E =======================================


sub_13B0A	proc near		; CODE XREF: sub_138F6+4p
		pusha
		push	ds
		push	es
		call	sub_13B23
		call	sub_1391A
		call	sub_13B74
		call	sub_13FE6
		call	sub_13B93
		call	sub_13FDA
		pop	es
		pop	ds
		popa
		retn
sub_13B0A	endp


; =============== S U B	R O U T	I N E =======================================


sub_13B23	proc near		; CODE XREF: sub_13B0A+3p sub_13BE0+3p ...
		pusha
		push	ds
		push	es
		mov	bx, seg	seg001
		mov	es, bx
		assume es:seg001
		mov	es:byte_18891, al
		mov	cx, [si]
		mov	ax, cx
		shr	ax, 3
		mov	es:word_18881, ax
		mov	al, 0FFh
		and	cl, 7
		shr	al, cl
		mov	es:byte_1888F, al
		mov	cx, [si+4]
		mov	ax, cx
		shr	ax, 3
		mov	es:word_18883, ax
		mov	al, 0FFh
		and	cl, 7
		mov	ch, 7
		sub	ch, cl
		mov	cl, ch
		shl	al, cl
		mov	es:byte_18890, al
		mov	ax, [si+2]
		mov	es:word_18885, ax
		mov	ax, [si+6]
		mov	es:word_18887, ax
		pop	es
		assume es:nothing
		pop	ds
		popa
		retn
sub_13B23	endp


; =============== S U B	R O U T	I N E =======================================


sub_13B74	proc near		; CODE XREF: sub_13B0A+9p sub_13DF0+9p ...
		push	ds
		mov	si, seg	seg001
		mov	ds, si
		assume ds:seg001
		mov	si, word_18889
		mov	al, byte_1888F
		mov	ah, byte_18890
		mov	cx, word_1888B
		mov	dx, word_1888D
		mov	bl, byte_18891
		pop	ds
		assume ds:nothing
		retn
sub_13B74	endp


; =============== S U B	R O U T	I N E =======================================


sub_13B93	proc near		; CODE XREF: sub_13B0A+Fp
		push	bx
		push	bp
		push	ds
		mov	bp, 0A800h

loc_13B99:				; CODE XREF: sub_13B93+17j
					; sub_13B93+1Dj
		shr	bl, 1
		jnb	short loc_13BA2
		mov	ds, bp
		assume ds:nothing
		call	sub_13BB6

loc_13BA2:				; CODE XREF: sub_13B93+8j
		add	bp, 800h
		cmp	bp, 0B800h
		jbe	short loc_13B99
		add	bp, 2000h
		jnb	short loc_13B99
		pop	ds
		assume ds:nothing
		pop	bp
		pop	bx
		retn
sub_13B93	endp


; =============== S U B	R O U T	I N E =======================================


sub_13BB6	proc near		; CODE XREF: sub_13B93+Cp
		push	dx
		push	si

loc_13BB8:				; CODE XREF: sub_13BB6+9j
		call	sub_13BC4
		add	si, 50h	; 'P'
		dec	dx
		jnz	short loc_13BB8
		pop	si
		pop	dx
		retn
sub_13BB6	endp


; =============== S U B	R O U T	I N E =======================================


sub_13BC4	proc near		; CODE XREF: sub_13BB6:loc_13BB8p
		push	bx
		push	cx
		push	si
		xor	[si], al
		inc	si
		dec	cx
		cmp	cx, 1
		jz	short loc_13BDA
		jb	short loc_13BDC
		dec	cx
		mov	bl, 0FFh

loc_13BD5:				; CODE XREF: sub_13BC4+14j
		xor	[si], bl
		inc	si
		loop	loc_13BD5

loc_13BDA:				; CODE XREF: sub_13BC4+Aj
		xor	[si], ah

loc_13BDC:				; CODE XREF: sub_13BC4+Cj
		pop	si
		pop	cx
		pop	bx
		retn
sub_13BC4	endp


; =============== S U B	R O U T	I N E =======================================


sub_13BE0	proc near		; CODE XREF: sub_138FF+4p
		pusha
		push	ds
		push	es
		call	sub_13B23
		call	sub_13BFC
		call	sub_1391A
		call	sub_13C3D
		call	sub_13FE6
		call	sub_13C58
		call	sub_13FDA
		pop	es
		pop	ds
		popa
		retn
sub_13BE0	endp


; =============== S U B	R O U T	I N E =======================================


sub_13BFC	proc near		; CODE XREF: sub_13BE0+6p
		pusha
		push	ds
		push	es
		mov	bx, seg	seg001
		mov	es, bx
		assume es:seg001
		mov	ax, 0FFFFh
		mov	cl, 1
		shr	ax, cl
		mov	cx, [si]
		and	cl, 7
		ror	ax, cl
		mov	es:byte_18892, ah
		mov	es:byte_18893, al
		mov	ax, 0FFFFh
		mov	cl, 1
		shl	ax, cl
		mov	cx, [si+4]
		and	cl, 7
		mov	ch, 7
		sub	ch, cl
		mov	cl, ch
		rol	ax, cl
		mov	es:byte_18894, al
		mov	es:byte_18895, ah
		pop	es
		assume es:nothing
		pop	ds
		popa
		retn
sub_13BFC	endp


; =============== S U B	R O U T	I N E =======================================


sub_13C3D	proc near		; CODE XREF: sub_13BE0+Cp
		mov	si, seg	seg001
		mov	ds, si
		assume ds:seg001
		mov	di, word_18889
		mov	ax, word_1888D
		mov	cx, word_1888B
		mul	cx
		mov	dx, word_1888D
		lds	si, dword_184FE
		assume ds:nothing
		retn
sub_13C3D	endp


; =============== S U B	R O U T	I N E =======================================


sub_13C58	proc near		; CODE XREF: sub_13BE0+12p
		pusha
		mov	bp, dx
		xor	dl, dl
		mov	bx, 1

loc_13C60:				; CODE XREF: sub_13C58+11j
		call	sub_13C8F
		add	si, cx
		add	di, 50h	; 'P'
		dec	bx
		jnz	short loc_13C60
		mov	dl, 0FFh
		mov	bx, bp
		sub	bx, 2

loc_13C72:				; CODE XREF: sub_13C58+23j
		call	sub_13C8F
		add	si, cx
		add	di, 50h	; 'P'
		dec	bx
		jnz	short loc_13C72
		xor	dl, dl
		mov	bx, 1

loc_13C82:				; CODE XREF: sub_13C58+33j
		call	sub_13C8F
		add	si, cx
		add	di, 50h	; 'P'
		dec	bx
		jnz	short loc_13C82
		popa
		retn
sub_13C58	endp


; =============== S U B	R O U T	I N E =======================================


sub_13C8F	proc near		; CODE XREF: sub_13C58:loc_13C60p
					; sub_13C58:loc_13C72p	...
		push	bx
		push	dx
		push	si
		push	es
		mov	bx, seg	seg001
		mov	es, bx
		assume es:seg001
		mov	dh, es:byte_18891
		mov	bx, 0A800h

loc_13CA0:				; CODE XREF: sub_13C8F+27j
					; sub_13C8F+2Cj
		mov	es, bx
		assume es:nothing
		shr	dh, 1
		jb	short loc_13CAB
		call	sub_13CC2
		jmp	short loc_13CAE
; ---------------------------------------------------------------------------

loc_13CAB:				; CODE XREF: sub_13C8F+15j
		call	sub_13D63

loc_13CAE:				; CODE XREF: sub_13C8F+1Aj
		add	si, ax
		add	bh, 8
		cmp	bh, 0B8h ; '∏'
		jbe	short loc_13CA0
		add	bh, 20h	; ' '
		jnb	short loc_13CA0
		pop	es
		assume es:nothing
		pop	si
		pop	dx
		pop	bx
		retn
sub_13C8F	endp


; =============== S U B	R O U T	I N E =======================================


sub_13CC2	proc near		; CODE XREF: sub_13C8F+17p
		pusha
		call	sub_13CED
		call	sub_13CFC
		inc	si
		inc	di
		call	sub_13D0C
		call	sub_13D17
		inc	si
		inc	di
		sub	cx, 4

loc_13CD6:				; CODE XREF: sub_13CC2+19j
		call	sub_13D23
		inc	si
		inc	di
		loop	loc_13CD6
		call	sub_13D2D
		call	sub_13D38
		inc	si
		inc	di
		call	sub_13D44
		call	sub_13D53
		popa
		retn
sub_13CC2	endp


; =============== S U B	R O U T	I N E =======================================


sub_13CED	proc near		; CODE XREF: sub_13CC2+1p sub_13D63+1p
		push	ds
		mov	bx, seg	seg001
		mov	ds, bx
		assume ds:seg001
		mov	al, byte_18892
		mov	bl, byte_1888F
		pop	ds
		assume ds:nothing
		retn
sub_13CED	endp


; =============== S U B	R O U T	I N E =======================================


sub_13CFC	proc near		; CODE XREF: sub_13CC2+4p
		push	bx
		mov	bh, [si]
		and	bh, al
		not	bl
		or	bl, dl
		and	bh, bl
		mov	es:[di], bh
		pop	bx
		retn
sub_13CFC	endp


; =============== S U B	R O U T	I N E =======================================


sub_13D0C	proc near		; CODE XREF: sub_13CC2+9p sub_13D63+9p
		push	ds
		mov	bx, seg	seg001
		mov	ds, bx
		assume ds:seg001
		mov	al, byte_18893
		pop	ds
		assume ds:nothing
		retn
sub_13D0C	endp


; =============== S U B	R O U T	I N E =======================================


sub_13D17	proc near		; CODE XREF: sub_13CC2+Cp
		push	bx
		mov	bh, [si]
		and	bh, al
		and	bh, dl
		mov	es:[di], bh
		pop	bx
		retn
sub_13D17	endp


; =============== S U B	R O U T	I N E =======================================


sub_13D23	proc near		; CODE XREF: sub_13CC2:loc_13CD6p
		push	bx
		mov	bh, [si]
		and	bh, dl
		mov	es:[di], bh
		pop	bx
		retn
sub_13D23	endp


; =============== S U B	R O U T	I N E =======================================


sub_13D2D	proc near		; CODE XREF: sub_13CC2+1Bp
					; sub_13D63+1Bp
		push	ds
		mov	bx, seg	seg001
		mov	ds, bx
		assume ds:seg001
		mov	al, byte_18895
		pop	ds
		assume ds:nothing
		retn
sub_13D2D	endp


; =============== S U B	R O U T	I N E =======================================


sub_13D38	proc near		; CODE XREF: sub_13CC2+1Ep
		push	bx
		mov	bh, [si]
		and	bh, al
		and	bh, dl
		mov	es:[di], bh
		pop	bx
		retn
sub_13D38	endp


; =============== S U B	R O U T	I N E =======================================


sub_13D44	proc near		; CODE XREF: sub_13CC2+23p
					; sub_13D63+23p
		push	ds
		mov	bx, seg	seg001
		mov	ds, bx
		assume ds:seg001
		mov	al, byte_18894
		mov	bl, byte_18890
		pop	ds
		assume ds:nothing
		retn
sub_13D44	endp


; =============== S U B	R O U T	I N E =======================================


sub_13D53	proc near		; CODE XREF: sub_13CC2+26p
		push	bx
		mov	bh, [si]
		and	bh, al
		not	bl
		or	bl, dl
		and	bh, bl
		mov	es:[di], bh
		pop	bx
		retn
sub_13D53	endp


; =============== S U B	R O U T	I N E =======================================


sub_13D63	proc near		; CODE XREF: sub_13C8F:loc_13CABp
		pusha
		call	sub_13CED
		call	sub_13D8E
		inc	si
		inc	di
		call	sub_13D0C
		call	sub_13DA4
		inc	si
		inc	di
		sub	cx, 4

loc_13D77:				; CODE XREF: sub_13D63+19j
		call	sub_13DB8
		inc	si
		inc	di
		loop	loc_13D77
		call	sub_13D2D
		call	sub_13DC6
		inc	si
		inc	di
		call	sub_13D44
		call	sub_13DDA
		popa
		retn
sub_13D63	endp


; =============== S U B	R O U T	I N E =======================================


sub_13D8E	proc near		; CODE XREF: sub_13D63+4p
		push	bx
		mov	bh, [si]
		not	al
		or	bh, al
		not	al
		not	bl
		or	bl, dl
		not	bl
		or	bh, bl
		mov	es:[di], bh
		pop	bx
		retn
sub_13D8E	endp


; =============== S U B	R O U T	I N E =======================================


sub_13DA4	proc near		; CODE XREF: sub_13D63+Cp
		push	bx
		mov	bh, [si]
		not	al
		or	bh, al
		not	al
		not	dl
		or	bh, dl
		not	dl
		mov	es:[di], bh
		pop	bx
		retn
sub_13DA4	endp


; =============== S U B	R O U T	I N E =======================================


sub_13DB8	proc near		; CODE XREF: sub_13D63:loc_13D77p
		push	bx
		mov	bh, [si]
		not	dl
		or	bh, dl
		not	dl
		mov	es:[di], bh
		pop	bx
		retn
sub_13DB8	endp


; =============== S U B	R O U T	I N E =======================================


sub_13DC6	proc near		; CODE XREF: sub_13D63+1Ep
		push	bx
		mov	bh, [si]
		not	al
		or	bh, al
		not	al
		not	dl
		or	bh, dl
		not	dl
		mov	es:[di], bh
		pop	bx
		retn
sub_13DC6	endp


; =============== S U B	R O U T	I N E =======================================


sub_13DDA	proc near		; CODE XREF: sub_13D63+26p
		push	bx
		mov	bh, [si]
		not	al
		or	bh, al
		not	al
		not	bl
		or	bl, dl
		not	bl
		or	bh, bl
		mov	es:[di], bh
		pop	bx
		retn
sub_13DDA	endp


; =============== S U B	R O U T	I N E =======================================


sub_13DF0	proc near		; CODE XREF: sub_13908+4p
		pusha
		push	ds
		push	es
		call	sub_13B23
		call	sub_1391A
		call	sub_13B74
		call	sub_13FE6
		call	sub_13E22
		call	sub_13FDA
		pop	es
		pop	ds
		popa
		retn
sub_13DF0	endp


; =============== S U B	R O U T	I N E =======================================


sub_13E09	proc near		; CODE XREF: sub_13911+4p
		pusha
		push	ds
		push	es
		call	sub_13B23
		call	sub_1391A
		call	sub_13B74
		call	sub_13FE6
		call	sub_13F10
		call	sub_13FDA
		pop	es
		pop	ds
		popa
		retn
sub_13E09	endp


; =============== S U B	R O U T	I N E =======================================


sub_13E22	proc near		; CODE XREF: sub_13DF0+Fp
		push	si
		push	di
		push	bp
		push	ds
		push	es
		mov	di, si
		mov	si, seg	seg001
		mov	ds, si
		assume ds:seg001
		lds	si, dword_184FE
		assume ds:nothing
		mov	bx, ax
		mov	bp, dx
		mov	ax, dx
		mul	cx
		mov	dx, bp
		xchg	ax, bx
		mov	bp, 0A800h

loc_13E40:				; CODE XREF: sub_13E22+2Dj
					; sub_13E22+33j
		mov	es, bp
		assume es:nothing
		call	sub_13E5D
		add	si, bx
		add	bp, 800h
		cmp	bp, 0B800h
		jbe	short loc_13E40
		add	bp, 2000h
		jnb	short loc_13E40
		pop	es
		assume es:nothing
		pop	ds
		pop	bp
		pop	di
		pop	si
		retn
sub_13E22	endp


; =============== S U B	R O U T	I N E =======================================


sub_13E5D	proc near		; CODE XREF: sub_13E22+20p
		push	bx
		push	dx
		push	si
		push	di
		xor	bx, bx
		mov	bl, 1
		or	bl, bl
		jz	short loc_13E76
		sub	dx, bx
		jb	short loc_13E81

loc_13E6D:				; CODE XREF: sub_13E5D+17j
		call	sub_13E86
		add	di, 50h	; 'P'
		dec	bx
		jnz	short loc_13E6D

loc_13E76:				; CODE XREF: sub_13E5D+Aj
					; sub_13E5D+22j
		call	sub_13EB0
		add	di, 50h	; 'P'
		add	si, cx
		dec	dx
		jnz	short loc_13E76

loc_13E81:				; CODE XREF: sub_13E5D+Ej
		pop	di
		pop	si
		pop	dx
		pop	bx
		retn
sub_13E5D	endp


; =============== S U B	R O U T	I N E =======================================


sub_13E86	proc near		; CODE XREF: sub_13E5D:loc_13E6Dp
					; sub_13F4B:loc_13F5Bp
		push	ax
		push	bx
		push	cx
		push	di
		not	al
		and	es:[di], al
		inc	di
		dec	cx
		cmp	cx, 1
		jz	short loc_13EA6
		jb	short loc_13EAB
		dec	cx
		mov	bl, ah
		xor	ax, ax
		shr	cx, 1
		cld
		rep stosw
		rcl	cx, 1
		rep stosb

loc_13EA6:				; CODE XREF: sub_13E86+Ej
		not	bl
		and	es:[di], bl

loc_13EAB:				; CODE XREF: sub_13E86+10j
		pop	di
		pop	cx
		pop	bx
		pop	ax
		retn
sub_13E86	endp


; =============== S U B	R O U T	I N E =======================================


sub_13EB0	proc near		; CODE XREF: sub_13E5D:loc_13E76p
		pusha
		mov	bp, cx
		mov	cl, 1
		mov	bl, 0FFh
		shr	bl, cl
		not	bl
		mov	dl, [si]
		mov	dh, dl
		and	dl, al
		ror	dl, cl
		mov	bh, dl
		and	bh, bl
		not	bl
		and	dl, bl
		not	bl
		not	al
		and	dh, al
		or	dl, dh
		mov	es:[di], dl
		inc	si
		inc	di
		dec	bp
		cmp	bp, 1
		jz	short loc_13EFB
		jb	short loc_13F0E
		dec	bp

loc_13EE1:				; CODE XREF: sub_13EB0+49j
		mov	dl, [si]
		ror	dl, cl
		mov	dh, dl
		and	dh, bl
		not	bl
		and	dl, bl
		not	bl
		or	dl, bh
		mov	es:[di], dl
		mov	bh, dh
		inc	si
		inc	di
		dec	bp
		jnz	short loc_13EE1

loc_13EFB:				; CODE XREF: sub_13EB0+2Cj
		mov	dl, [si]
		mov	dh, dl
		shr	dl, cl
		or	dl, bh
		and	dl, ah
		not	ah
		and	dh, ah
		or	dl, dh
		mov	es:[di], dl

loc_13F0E:				; CODE XREF: sub_13EB0+2Ej
		popa
		retn
sub_13EB0	endp


; =============== S U B	R O U T	I N E =======================================


sub_13F10	proc near		; CODE XREF: sub_13E09+Fp
		push	si
		push	di
		push	bp
		push	ds
		push	es
		mov	di, si
		mov	si, seg	seg001
		mov	ds, si
		assume ds:seg001
		lds	si, dword_184FE
		assume ds:nothing
		mov	bx, ax
		mov	bp, dx
		mov	ax, dx
		mul	cx
		mov	dx, bp
		xchg	ax, bx
		mov	bp, 0A800h

loc_13F2E:				; CODE XREF: sub_13F10+2Dj
					; sub_13F10+33j
		mov	es, bp
		assume es:nothing
		call	sub_13F4B
		add	si, bx
		add	bp, 800h
		cmp	bp, 0B800h
		jbe	short loc_13F2E
		add	bp, 2000h
		jnb	short loc_13F2E
		pop	es
		assume es:nothing
		pop	ds
		pop	bp
		pop	di
		pop	si
		retn
sub_13F10	endp


; =============== S U B	R O U T	I N E =======================================


sub_13F4B	proc near		; CODE XREF: sub_13F10+20p
		push	bx
		push	dx
		push	si
		push	di
		xor	bx, bx
		mov	bl, 1
		or	bl, bl
		jz	short loc_13F64
		sub	dx, bx
		jb	short loc_13F6F

loc_13F5B:				; CODE XREF: sub_13F4B+17j
		call	sub_13E86
		add	di, 50h	; 'P'
		dec	bx
		jnz	short loc_13F5B

loc_13F64:				; CODE XREF: sub_13F4B+Aj
					; sub_13F4B+22j
		call	sub_13F74
		add	di, 50h	; 'P'
		add	si, cx
		dec	dx
		jnz	short loc_13F64

loc_13F6F:				; CODE XREF: sub_13F4B+Ej
		pop	di
		pop	si
		pop	dx
		pop	bx
		retn
sub_13F4B	endp


; =============== S U B	R O U T	I N E =======================================


sub_13F74	proc near		; CODE XREF: sub_13F4B:loc_13F64p
		pusha
		add	si, cx
		dec	si
		add	di, cx
		dec	di
		mov	bp, cx
		mov	cl, 1
		mov	bl, 0FFh
		shl	bl, cl
		not	bl
		mov	dl, [si]
		mov	dh, dl
		and	dl, ah
		rol	dl, cl
		mov	bh, dl
		and	bh, bl
		not	bl
		and	dl, bl
		not	bl
		not	ah
		and	dh, ah
		or	dl, dh
		mov	es:[di], dl
		dec	si
		dec	di
		dec	bp
		cmp	bp, 1
		jz	short loc_13FC5
		jb	short loc_13FD8
		dec	bp

loc_13FAB:				; CODE XREF: sub_13F74+4Fj
		mov	dl, [si]
		rol	dl, cl
		mov	dh, dl
		and	dh, bl
		not	bl
		and	dl, bl
		not	bl
		or	dl, bh
		mov	es:[di], dl
		mov	bh, dh
		dec	si
		dec	di
		dec	bp
		jnz	short loc_13FAB

loc_13FC5:				; CODE XREF: sub_13F74+32j
		mov	dl, [si]
		mov	dh, dl
		shl	dl, cl
		or	dl, bh
		and	dl, al
		not	al
		and	dh, al
		or	dl, dh
		mov	es:[di], dl

loc_13FD8:				; CODE XREF: sub_13F74+34j
		popa
		retn
sub_13F74	endp


; =============== S U B	R O U T	I N E =======================================


sub_13FDA	proc near		; CODE XREF: sub_13697+13p
					; sub_13968+29p ...
		pusha
		push	ds
		push	es
		mov	ax, 1
		int	33h		; - MS MOUSE - SHOW MOUSE CURSOR
					; SeeAlso: AX=0002h, INT 16/AX=FFFEh
		pop	es
		pop	ds
		popa
		retn
sub_13FDA	endp


; =============== S U B	R O U T	I N E =======================================


sub_13FE6	proc near		; CODE XREF: sub_13649+29p
					; sub_13679+12p ...
		pusha
		push	ds
		push	es
		mov	ax, 2
		int	33h		; - MS MOUSE - HIDE MOUSE CURSOR
					; SeeAlso: AX=0001h, INT 16/AX=FFFFh
		pop	es
		pop	ds
		popa
		retn
sub_13FE6	endp


; =============== S U B	R O U T	I N E =======================================


sub_13FF2	proc near		; CODE XREF: sub_136D0+4p sub_13749+Ap
		push	si
		push	di
		push	bp
		push	ds
		push	es
		mov	ax, 3
		int	33h		; - MS MOUSE - RETURN POSITION AND BUTTON STATUS
					; Return: BX = button status, CX = column, DX =	row
		pop	es
		pop	ds
		pop	bp
		pop	di
		pop	si
		retn
sub_13FF2	endp


; =============== S U B	R O U T	I N E =======================================


sub_14002	proc near		; CODE XREF: sub_13717+1Cp
		pusha
		push	ds
		push	es
		mov	ax, 4
		int	33h		; - MS MOUSE - POSITION	MOUSE CURSOR
					; CX = column, DX = row
		pop	es
		pop	ds
		popa
		retn
sub_14002	endp


; =============== S U B	R O U T	I N E =======================================


sub_1400E	proc near		; CODE XREF: sub_137B3+15p
					; sub_137B3+2Fp ...
		push	ax

loc_1400F:				; CODE XREF: sub_1400E+5j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jnz	short loc_1400F

loc_14015:				; CODE XREF: sub_1400E+Bj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 20h
		jz	short loc_14015
		pop	ax
		retn
sub_1400E	endp


; =============== S U B	R O U T	I N E =======================================


sub_1401D	proc near		; CODE XREF: sub_13697+1Bp
					; sub_136D0:loc_136D1p
		push	ax
		push	cx
		mov	cx, 0FFFFh
		mov	ax, 0C00h
		int	0F3h
		mov	ah, 0Fh
		int	0F3h
		pop	cx
		pop	ax
		retn
sub_1401D	endp


; =============== S U B	R O U T	I N E =======================================


sub_1402E	proc near		; CODE XREF: sub_133EC+18p
		pusha
		push	ds
		push	es
		call	sub_1403E
		call	sub_14042
		call	nullsub_3
		pop	es
		pop	ds
		popa
		retn
sub_1402E	endp


; =============== S U B	R O U T	I N E =======================================


sub_1403E	proc near		; CODE XREF: sub_1402E+3p
		call	sub_1404A
		retn
sub_1403E	endp


; =============== S U B	R O U T	I N E =======================================


sub_14042	proc near		; CODE XREF: sub_1402E+6p
		call	sub_14061
		call	sub_140A7
		retn
sub_14042	endp


; =============== S U B	R O U T	I N E =======================================


nullsub_3	proc near		; CODE XREF: sub_1402E+9p
		retn
nullsub_3	endp


; =============== S U B	R O U T	I N E =======================================


sub_1404A	proc near		; CODE XREF: sub_1403Ep
		mov	bp, ds
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		mov	es, ax
		assume es:seg001
		mov	word ptr dword_188A0+2,	bp
		mov	word ptr dword_188A0, si
		mov	byte_188A4, 0
		retn
sub_1404A	endp


; =============== S U B	R O U T	I N E =======================================


sub_14061	proc near		; CODE XREF: sub_14042p
		pusha
		push	ds
		push	es
		lds	si, dword_188A0
		mov	di, seg	seg001
		mov	es, di
		mov	di, offset word_188A5
		mov	bl, 1
		cld
		lodsw
		cmp	ax, 40
		jbe	short loc_1407E
		cmp	ax, -40
		jb	short loc_1409A

loc_1407E:				; CODE XREF: sub_14061+16j
		stosw
		lodsw
		cmp	ax, 100
		jbe	short loc_1408A
		cmp	ax, -100
		jb	short loc_1409A

loc_1408A:				; CODE XREF: sub_14061+22j
		stosw
		lodsb
		mov	es:FrameDelay, al
		movsb
		lodsb
		cmp	ax, 3
		ja	short loc_1409A
		stosb
		xor	bl, bl

loc_1409A:				; CODE XREF: sub_14061+1Bj
					; sub_14061+27j ...
		mov	ax, seg	seg001
		mov	ds, ax
		mov	byte_188A4, bl
		pop	es
		assume es:nothing
		pop	ds
		assume ds:nothing
		popa
		retn
sub_14061	endp


; =============== S U B	R O U T	I N E =======================================


sub_140A7	proc near		; CODE XREF: sub_14042+3p
		cmp	byte ptr ds:3BD4h, 0
		jnz	short locret_140BC
		call	sub_14160

loc_140B1:				; CODE XREF: sub_140A7+13j
		call	sub_140BD
		call	sub_140E4
		call	sub_14229
		loop	loc_140B1

locret_140BC:				; CODE XREF: sub_140A7+5j
		retn
sub_140A7	endp


; =============== S U B	R O U T	I N E =======================================


sub_140BD	proc near		; CODE XREF: sub_140A7:loc_140B1p
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		mov	ax, word_188A5
		mov	bx, word_188A7
		call	sub_14154
		mov	dx, di
		mov	bx, di
		neg	bx
		mov	al, 3
		test	bh, 80h
		jnz	short loc_140DB
		xor	al, al

loc_140DB:				; CODE XREF: sub_140BD+1Aj
		mov	ah, al
		xor	ch, ch
		mov	cl, byte_188A9
		retn
sub_140BD	endp


; =============== S U B	R O U T	I N E =======================================


sub_140E4	proc near		; CODE XREF: sub_140A7+Dp
		or	cl, cl
		jz	short locret_14148
		xor	bp, bp

loc_140EA:				; CODE XREF: sub_140E4+62j
		call	WaitFrames
		call	sub_14840
		mov	ax, word_188A5
		call	sub_14293
		mov	ax, word_188A7
		call	sub_1430D
		call	WaitFrames
		xchg	bx, bp
		call	sub_14840
		xchg	bx, bp
		mov	ax, word_188A5
		call	sub_142D7
		mov	ax, word_188A7
		call	sub_1438B
		call	WaitFrames
		xchg	bx, dx
		call	sub_14840
		mov	ax, word_188A5
		neg	ax
		call	sub_14293
		mov	ax, word_188A7
		neg	ax
		call	sub_1430D
		call	WaitFrames
		xchg	bx, bp
		call	sub_14840
		xchg	bx, bp
		mov	ax, word_188A5
		neg	ax
		call	sub_142D7
		mov	ax, word_188A7
		neg	ax
		call	sub_1438B
		xchg	bx, dx
		loop	loc_140EA

locret_14148:				; CODE XREF: sub_140E4+2j
		retn
sub_140E4	endp

; ---------------------------------------------------------------------------
		mov	ax, dx
		shl	ax, 2
		add	ax, dx
		shl	ax, 5
		retn

; =============== S U B	R O U T	I N E =======================================


sub_14154	proc near		; CODE XREF: sub_140BD+Cp
		mov	di, ax
		mov	ax, bx
		mov	bx, 0A0h ; '†'
		mul	bx
		add	di, ax
		retn
sub_14154	endp


; =============== S U B	R O U T	I N E =======================================


sub_14160	proc near		; CODE XREF: sub_140A7+7p

; FUNCTION CHUNK AT 4220 SIZE 00000009 BYTES

		or	byte_188AA, 0
		jz	short locret_14191
		mov	ax, word_188A5
		mov	word_188AB, ax
		mov	bx, word_188A7
		mov	word_188AD, bx
		cmp	byte_188AA, 3
		jb	short loc_1417F
		jmp	loc_14220
; ---------------------------------------------------------------------------

loc_1417F:				; CODE XREF: sub_14160+1Aj
		cmp	byte_188AA, 2
		jb	short loc_14188
		jmp	short sub_141DF
; ---------------------------------------------------------------------------

loc_14188:				; CODE XREF: sub_14160+24j
		cmp	byte_188AA, 1
		jb	short locret_14191
		jmp	short sub_14192
; ---------------------------------------------------------------------------

locret_14191:				; CODE XREF: sub_14160+5j
					; sub_14160+2Dj
		retn
sub_14160	endp


; =============== S U B	R O U T	I N E =======================================


sub_14192	proc near		; CODE XREF: sub_14160+2Fj
					; sub_14160:loc_14220p
		push	ax
		push	bx
		push	cx
		push	dx
		mov	cx, 1
		mov	dx, 1
		test	ah, 80h
		jz	short loc_141A5
		neg	ax
		neg	cx

loc_141A5:				; CODE XREF: sub_14192+Dj
		or	ax, ax
		jnz	short loc_141AB
		xor	cx, cx

loc_141AB:				; CODE XREF: sub_14192+15j
		test	bh, 80h
		jz	short loc_141B4
		neg	bx
		neg	dx

loc_141B4:				; CODE XREF: sub_14192+1Cj
		or	bx, bx
		jnz	short loc_141BA
		xor	dx, dx

loc_141BA:				; CODE XREF: sub_14192+24j
		mov	byte_188AF, al
		mov	byte_188B0, bl
		mov	word_188A5, 0
		mov	word_188A7, 0
		mov	word_188B1, cx
		mov	word_188B3, dx
		mov	byte_188B5, 0
		pop	dx
		pop	cx
		pop	bx
		pop	ax
		retn
sub_14192	endp


; =============== S U B	R O U T	I N E =======================================


sub_141DF	proc near		; CODE XREF: sub_14160+26j
					; sub_1427E+Ep
		push	ax
		push	bx
		push	cx
		push	dx
		mov	cx, 0FFFFh
		mov	dx, 0FFFFh
		test	ah, 80h
		jz	short loc_141F2
		neg	ax
		neg	cx

loc_141F2:				; CODE XREF: sub_141DF+Dj
		or	ax, ax
		jnz	short loc_141F8
		xor	cx, cx

loc_141F8:				; CODE XREF: sub_141DF+15j
		test	bh, 80h
		jz	short loc_14201
		neg	bx
		neg	dx

loc_14201:				; CODE XREF: sub_141DF+1Cj
		or	bx, bx
		jnz	short loc_14207
		xor	dx, dx

loc_14207:				; CODE XREF: sub_141DF+24j
		mov	byte_188AF, al
		mov	byte_188B0, bl
		mov	word_188B1, cx
		mov	word_188B3, dx
		mov	byte_188B5, 0
		pop	dx
		pop	cx
		pop	bx
		pop	ax
		retn
sub_141DF	endp

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_14160

loc_14220:				; CODE XREF: sub_14160+1Cj
		call	sub_14192
		mov	byte_188B5, 1
		retn
; END OF FUNCTION CHUNK	FOR sub_14160

; =============== S U B	R O U T	I N E =======================================


sub_14229	proc near		; CODE XREF: sub_140A7+10p
		mov	cx, 1
		cmp	byte_188AA, 0
		jz	short locret_1427D
		mov	al, byte_188AF
		mov	bl, byte_188B0
		mov	cl, al
		or	cl, bl
		jnz	short loc_14248
		mov	cx, 1
		call	sub_1427E
		jmp	short locret_1427D
; ---------------------------------------------------------------------------

loc_14248:				; CODE XREF: sub_14229+15j
		or	al, al
		jnz	short loc_14254
		mov	word_188B1, 0
		inc	al

loc_14254:				; CODE XREF: sub_14229+21j
		dec	al
		mov	byte_188AF, al
		or	bl, bl
		jnz	short loc_14265
		mov	word_188B3, 0
		inc	bl

loc_14265:				; CODE XREF: sub_14229+32j
		dec	bl
		mov	byte_188B0, bl
		mov	ax, word_188B1
		add	word_188A5, ax
		mov	bx, word_188B3
		add	word_188A7, bx
		mov	cx, 2

locret_1427D:				; CODE XREF: sub_14229+8j
					; sub_14229+1Dj
		retn
sub_14229	endp


; =============== S U B	R O U T	I N E =======================================


sub_1427E	proc near		; CODE XREF: sub_14229+1Ap
		cmp	byte_188B5, 0
		jz	short locret_14292
		mov	ax, word_188A5
		mov	bx, word_188A7
		call	sub_141DF
		mov	cx, 2

locret_14292:				; CODE XREF: sub_1427E+5j
		retn
sub_1427E	endp


; =============== S U B	R O U T	I N E =======================================


sub_14293	proc near		; CODE XREF: sub_140E4+Fp
					; sub_140E4+3Bp
		pusha
		push	es
		mov	bx, ax
		or	bx, bx
		jz	short loc_142D4
		cld
		mov	si, 0A0h ; '†'
		xor	di, di
		test	bh, 80h
		jz	short loc_142AC
		std
		neg	bx
		mov	di, 9Eh	; 'û'

loc_142AC:				; CODE XREF: sub_14293+11j
		shl	bx, 1
		mov	ax, 0A000h
		mov	es, ax
		assume es:nothing
		mov	dx, 19h

loc_142B6:				; CODE XREF: sub_14293+3Ej
		mov	ax, 0FFh
		mov	bp, di
		mov	cx, bx
		rep stosw
		mov	di, bp
		add	di, 2000h
		mov	ax, 11h
		mov	cx, bx
		rep stosw
		mov	di, bp
		add	di, si
		dec	dx
		jnz	short loc_142B6
		cld

loc_142D4:				; CODE XREF: sub_14293+6j
		pop	es
		assume es:nothing
		popa
		retn
sub_14293	endp


; =============== S U B	R O U T	I N E =======================================


sub_142D7	proc near		; CODE XREF: sub_140E4+25p
					; sub_140E4+55p
		pusha
		push	es
		mov	bx, ax
		or	bx, bx
		jz	short loc_1430A
		cld
		mov	si, 0A0h ; '†'
		xor	di, di
		test	bh, 80h
		jz	short loc_142F0
		std
		neg	bx
		mov	di, 9Eh	; 'û'

loc_142F0:				; CODE XREF: sub_142D7+11j
		shl	bx, 1
		mov	ax, 0A000h
		mov	es, ax
		assume es:nothing
		xor	ax, ax
		mov	dx, 19h

loc_142FC:				; CODE XREF: sub_142D7+30j
		mov	bp, di
		mov	cx, bx
		rep stosw
		mov	di, bp
		add	di, si
		dec	dx
		jnz	short loc_142FC
		cld

loc_1430A:				; CODE XREF: sub_142D7+6j
		pop	es
		assume es:nothing
		popa
		retn
sub_142D7	endp


; =============== S U B	R O U T	I N E =======================================


sub_1430D	proc near		; CODE XREF: sub_140E4+15p
					; sub_140E4+43p
		pusha
		push	ds
		push	es
		mov	bx, ax
		or	bx, bx
		jz	short loc_14387
		test	bh, 80h
		jz	short loc_14332
		neg	bx
		mov	cl, bl
		and	cl, 3
		mov	ax, 0F0h ; ''
		shr	ax, cl
		and	ax, 0Fh
		mov	si, 0FF60h
		mov	di, 0F00h
		jmp	short loc_14346
; ---------------------------------------------------------------------------

loc_14332:				; CODE XREF: sub_1430D+Cj
		mov	ch, bl
		and	ch, 3
		mov	cl, 4
		sub	cl, ch
		mov	ax, 0Fh
		shr	ax, cl
		mov	si, 0A0h ; '†'
		mov	di, 0

loc_14346:				; CODE XREF: sub_1430D+23j
		imul	ax, 11h
		mov	dx, ax
		shr	bx, 2
		mov	cx, 0A000h
		mov	ds, cx
		assume ds:nothing
		mov	es, cx
		assume es:nothing
		or	bx, bx
		jz	short loc_14378

loc_14359:				; CODE XREF: sub_1430D+69j
		mov	ax, 0FFh
		mov	bp, di
		mov	cx, 50h	; 'P'
		rep stosw
		mov	di, bp
		add	di, 2000h
		mov	ax, 11h
		mov	cx, 50h	; 'P'
		rep stosw
		mov	di, bp
		add	di, si
		dec	bx
		jnz	short loc_14359

loc_14378:				; CODE XREF: sub_1430D+4Aj
		mov	al, 11h
		mov	cx, 50h	; 'P'

loc_1437D:				; CODE XREF: sub_1430D+78j
		or	[di], dl
		mov	[di+2000h], al
		inc	di
		inc	di
		loop	loc_1437D

loc_14387:				; CODE XREF: sub_1430D+7j
		pop	es
		assume es:nothing
		pop	ds
		assume ds:nothing
		popa
		retn
sub_1430D	endp


; =============== S U B	R O U T	I N E =======================================


sub_1438B	proc near		; CODE XREF: sub_140E4+2Bp
					; sub_140E4+5Dp
		pusha
		push	ds
		push	es
		mov	bx, ax
		or	bx, bx
		jz	short loc_143F2
		test	bh, 80h
		jz	short loc_143B0
		neg	bx
		mov	cl, bl
		and	cl, 3
		mov	ax, 0F0h ; ''
		shr	ax, cl
		and	ax, 0Fh
		mov	si, 0FF60h
		mov	di, 0F00h
		jmp	short loc_143C4
; ---------------------------------------------------------------------------

loc_143B0:				; CODE XREF: sub_1438B+Cj
		mov	ch, bl
		and	ch, 3
		mov	cl, 4
		sub	cl, ch
		mov	ax, 0Fh
		shr	ax, cl
		mov	si, 0A0h ; '†'
		mov	di, 0

loc_143C4:				; CODE XREF: sub_1438B+23j
		imul	ax, 11h
		mov	dx, ax
		shr	bx, 2
		mov	cx, 0A000h
		mov	ds, cx
		assume ds:nothing
		mov	es, cx
		assume es:nothing
		or	bx, bx
		jz	short loc_143E7
		xor	ax, ax

loc_143D9:				; CODE XREF: sub_1438B+5Aj
		mov	bp, di
		mov	cx, 50h	; 'P'
		rep stosw
		mov	di, bp
		add	di, si
		dec	bx
		jnz	short loc_143D9

loc_143E7:				; CODE XREF: sub_1438B+4Aj
		mov	cx, 50h	; 'P'
		not	dl

loc_143EC:				; CODE XREF: sub_1438B+65j
		and	[di], dl
		inc	di
		inc	di
		loop	loc_143EC

loc_143F2:				; CODE XREF: sub_1438B+7j
		pop	es
		assume es:nothing
		pop	ds
		assume ds:nothing
		popa
		retn
sub_1438B	endp


; =============== S U B	R O U T	I N E =======================================


sub_143F6	proc near		; CODE XREF: sub_1323E+2Bp
					; sub_1323E+36p ...
		pusha
		push	ds
		push	es
		call	sub_14406
		call	sub_1440D
		call	sub_14420
		pop	es
		pop	ds
		popa
		retn
sub_143F6	endp


; =============== S U B	R O U T	I N E =======================================


sub_14406	proc near		; CODE XREF: sub_143F6+3p
		call	sub_14424
		call	SaveFrameDelay
		retn
sub_14406	endp


; =============== S U B	R O U T	I N E =======================================


sub_1440D	proc near		; CODE XREF: sub_143F6+6p
		call	sub_14466
		call	sub_144A6
		call	sub_144CA
		call	sub_14547
		call	sub_145BB
		call	sub_145DD
		retn
sub_1440D	endp


; =============== S U B	R O U T	I N E =======================================


sub_14420	proc near		; CODE XREF: sub_143F6+9p
		call	RestoreFrameDly
		retn
sub_14420	endp


; =============== S U B	R O U T	I N E =======================================


sub_14424	proc near		; CODE XREF: sub_14406p
		mov	bp, ds
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		mov	es, ax
		assume es:seg001
		mov	word ptr dword_188B6+2,	bp
		mov	word ptr dword_188B6, si
		mov	byte_188BA, 0
		mov	di, offset unk_18903
		xor	ax, ax
		mov	cx, 60h
		cld
		rep stosw
		retn
sub_14424	endp


; =============== S U B	R O U T	I N E =======================================


SaveFrameDelay	proc near		; CODE XREF: sub_14406+3p
		push	ax
		push	ds
		mov	ax, seg	seg001
		mov	ds, ax
		mov	al, FrameDelay
		mov	byte_188BC, al
		pop	ds
		assume ds:nothing
		pop	ax
		retn
SaveFrameDelay	endp


; =============== S U B	R O U T	I N E =======================================


RestoreFrameDly	proc near		; CODE XREF: sub_14420p
		push	ax
		push	ds
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		mov	al, byte_188BC
		mov	FrameDelay, al
		pop	ds
		assume ds:nothing
		pop	ax
		retn
RestoreFrameDly	endp


; =============== S U B	R O U T	I N E =======================================


sub_14466	proc near		; CODE XREF: sub_1440Dp
		pusha
		push	ds
		push	es
		lds	si, ds:dword_188B6
		mov	di, seg	seg001
		mov	es, di
		mov	di, offset byte_188BD
		cld
		movsb
		lodsb
		or	al, al
		jz	short loc_14481
		stosb
		movsw
		movsw
		jmp	short loc_14484
; ---------------------------------------------------------------------------

loc_14481:				; CODE XREF: sub_14466+14j
		call	sub_14488

loc_14484:				; CODE XREF: sub_14466+19j
		pop	es
		assume es:nothing
		pop	ds
		popa
		retn
sub_14466	endp


; =============== S U B	R O U T	I N E =======================================


sub_14488	proc near		; CODE XREF: sub_14466:loc_14481p
		push	ax
		push	ds
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		mov	byte_188BA, 1
		pop	ds
		assume ds:nothing
		pop	ax
		retn
sub_14488	endp


; =============== S U B	R O U T	I N E =======================================


sub_14497	proc near		; CODE XREF: sub_144A6+4p sub_144CA+3p ...
		push	ax
		push	ds
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		cmp	byte_188BA, 0
		pop	ds
		assume ds:nothing
		pop	ax
		retn
sub_14497	endp


; =============== S U B	R O U T	I N E =======================================


sub_144A6	proc near		; CODE XREF: sub_1440D+3p
		push	si
		push	di
		push	ds
		push	es
		call	sub_14497
		jnz	short loc_144C5
		mov	di, seg	seg001
		mov	ds, di
		assume ds:seg001
		mov	es, di
		assume es:seg001
		mov	di, offset unk_188C3
		call	APICall_PaletteThing
		mov	si, offset unk_188C3
		mov	di, offset unk_18903
		call	DoPaletteThing

loc_144C5:				; CODE XREF: sub_144A6+7j
		pop	es
		assume es:nothing
		pop	ds
		assume ds:nothing
		pop	di
		pop	si
		retn
sub_144A6	endp


; =============== S U B	R O U T	I N E =======================================


sub_144CA	proc near		; CODE XREF: sub_1440D+6p
		pusha
		push	ds
		push	es
		call	sub_14497
		jnz	short loc_14503
		mov	si, seg	seg001
		mov	ds, si
		assume ds:seg001
		mov	es, si
		assume es:seg001
		lds	si, dword_188BF
		assume ds:nothing
		mov	di, offset unk_188E3
		mov	bx, offset unk_188C3
		mov	cx, 10h
		cld

loc_144E7:				; CODE XREF: sub_144CA+29j
		lodsw
		cmp	ax, 0FFFFh
		jnz	short loc_144EF
		mov	ax, [bx]

loc_144EF:				; CODE XREF: sub_144CA+21j
		stosw
		add	bx, 2
		loop	loc_144E7
		mov	si, seg	seg001
		mov	ds, si
		assume ds:seg001
		mov	si, offset unk_188E3
		mov	di, offset unk_18963
		call	DoPaletteThing

loc_14503:				; CODE XREF: sub_144CA+6j
		pop	es
		assume es:nothing
		pop	ds
		assume ds:nothing
		popa
		retn
sub_144CA	endp


; =============== S U B	R O U T	I N E =======================================


DoPaletteThing	proc near		; CODE XREF: sub_144A6+1Cp
					; sub_144CA+36p
		pusha
		cld
		mov	cx, 10h

loc_1450C:				; CODE XREF: DoPaletteThing+1Ej
		lodsw
		mov	bx, ax
		and	al, 0Fh
		inc	di
		stosb
		shr	bx, 4
		mov	al, bl
		and	al, 0Fh
		inc	di
		stosb
		shr	bx, 4
		mov	al, bl
		and	al, 0Fh
		inc	di
		stosb
		loop	loc_1450C
		popa
		retn
DoPaletteThing	endp


; =============== S U B	R O U T	I N E =======================================


sub_14529	proc near		; CODE XREF: sub_1462A+10p
		pusha
		cld
		mov	cx, 10h

loc_1452E:				; CODE XREF: sub_14529+1Aj
		inc	si
		lodsb
		mov	bh, al
		shr	bx, 4
		inc	si
		lodsb
		mov	bh, al
		shr	bx, 4
		inc	si
		lodsb
		mov	bh, al
		mov	ax, bx
		stosw
		loop	loc_1452E
		popa
		retn
sub_14529	endp


; =============== S U B	R O U T	I N E =======================================


sub_14547	proc near		; CODE XREF: sub_1440D+9p
		pusha
		push	ds
		push	es
		call	sub_14497
		jnz	short loc_145AE
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		mov	si, offset unk_18963
		mov	di, offset unk_18903
		xor	cx, cx
		mov	cl, byte_188BE
		mov	bp, cx
		mov	cx, 30h	; '0'

loc_14565:				; CODE XREF: sub_14547+65j
		xor	ax, ax
		mov	byte_188BB, al
		mov	al, [si+1]
		mov	bl, [di+1]
		sub	al, bl
		jnb	short loc_1457B
		mov	byte_188BB, 1
		neg	al

loc_1457B:				; CODE XREF: sub_14547+2Bj
		call	sub_145B2
		cmp	byte_188BB, 0
		jz	short loc_14587
		neg	bl

loc_14587:				; CODE XREF: sub_14547+3Cj
		mov	[si+1],	bl
		mov	ax, dx
		shl	ax, 8
		call	sub_145B2
		cmp	byte_188BB, 0
		jz	short loc_1459B
		neg	bx

loc_1459B:				; CODE XREF: sub_14547+50j
		or	dx, dx
		jz	short loc_145A0
		inc	bx

loc_145A0:				; CODE XREF: sub_14547+56j
		mov	ax, [si]
		add	ax, bx
		mov	[si], ax
		add	si, 2
		add	di, 2
		loop	loc_14565

loc_145AE:				; CODE XREF: sub_14547+6j
		pop	es
		pop	ds
		assume ds:nothing
		popa
		retn
sub_14547	endp


; =============== S U B	R O U T	I N E =======================================


sub_145B2	proc near		; CODE XREF: sub_14547:loc_1457Bp
					; sub_14547+48p
		push	ax
		xor	dx, dx
		div	bp
		mov	bx, ax
		pop	ax
		retn
sub_145B2	endp


; =============== S U B	R O U T	I N E =======================================


sub_145BB	proc near		; CODE XREF: sub_1440D+Cp
		push	ax
		push	cx
		push	si
		push	ds
		call	sub_14497
		jnz	short loc_145D8
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		mov	si, offset unk_18903
		xor	ax, ax
		mov	cx, 30h	; '0'

loc_145D1:				; CODE XREF: sub_145BB+1Bj
		mov	[si], al
		add	si, 2
		loop	loc_145D1

loc_145D8:				; CODE XREF: sub_145BB+7j
		pop	ds
		assume ds:nothing
		pop	si
		pop	cx
		pop	ax
		retn
sub_145BB	endp


; =============== S U B	R O U T	I N E =======================================


sub_145DD	proc near		; CODE XREF: sub_1440D+Fp
		pusha
		push	ds
		push	es
		call	sub_14497
		jnz	short loc_14603
		mov	cx, seg	seg001
		mov	ds, cx
		assume ds:seg001
		mov	cl, byte_188BD
		mov	FrameDelay, cl
		xor	cx, cx
		mov	cl, byte_188BE

loc_145F8:				; CODE XREF: sub_145DD+24j
		call	sub_14607
		call	sub_1462A
		call	sub_14641
		loop	loc_145F8

loc_14603:				; CODE XREF: sub_145DD+6j
		pop	es
		pop	ds
		assume ds:nothing
		popa
		retn
sub_145DD	endp


; =============== S U B	R O U T	I N E =======================================


sub_14607	proc near		; CODE XREF: sub_145DD:loc_145F8p
		pusha
		push	ds
		push	es
		mov	si, seg	seg001
		mov	ds, si
		assume ds:seg001
		mov	si, offset unk_18903
		mov	di, offset unk_18963
		mov	cx, 30h	; '0'

loc_14618:				; CODE XREF: sub_14607+1Dj
		mov	ax, [si]
		add	ax, [di]
		mov	[si], ax
		add	si, 2
		add	di, 2
		loop	loc_14618
		pop	es
		pop	ds
		assume ds:nothing
		popa
		retn
sub_14607	endp


; =============== S U B	R O U T	I N E =======================================


sub_1462A	proc near		; CODE XREF: sub_145DD+1Ep
		pusha
		push	ds
		push	es
		mov	si, seg	seg001
		mov	ds, si
		assume ds:seg001
		mov	es, si
		assume es:seg001
		mov	si, offset unk_18903
		mov	di, offset unk_188C3
		call	sub_14529
		pop	es
		assume es:nothing
		pop	ds
		assume ds:nothing
		popa
		retn
sub_1462A	endp


; =============== S U B	R O U T	I N E =======================================


sub_14641	proc near		; CODE XREF: sub_145DD+21p
		push	ax
		push	si
		push	ds
		mov	si, seg	seg001
		mov	ds, si
		assume ds:seg001
		mov	si, offset unk_188C3
		mov	al, 0Fh
		call	WaitFrames
		call	sub_147B0
		pop	ds
		assume ds:nothing
		pop	si
		pop	ax
		retn
sub_14641	endp


; =============== S U B	R O U T	I N E =======================================


sub_14658	proc near		; CODE XREF: LoadGPC+6p LoadGPA+5p
		pusha
		push	ds
		push	es
		xor	ah, ah
		int	0F2h
		pop	es
		pop	ds
		popa
		retn
sub_14658	endp

; ---------------------------------------------------------------------------
		pusha
		push	ds
		push	es
		mov	ah, 5
		int	0F2h
		pop	es
		pop	ds
		popa
		retn
; ---------------------------------------------------------------------------
		pusha
		push	ds
		push	es
		mov	ah, 1
		int	0F2h
		pop	es
		pop	ds
		popa
		retn

; =============== S U B	R O U T	I N E =======================================


sub_14679	proc near		; CODE XREF: sub_12F0E+22p
		pusha
		push	ds
		push	es
		mov	ah, 1
		int	0F3h
		pop	es
		pop	ds
		popa
		retn
sub_14679	endp


; =============== S U B	R O U T	I N E =======================================


sub_14684	proc near		; CODE XREF: sub_11B0A+3p sub_11B4E+3p ...
		push	ax
		push	cx
		push	dx
		push	si
		push	di
		push	bp
		push	ds
		xor	ah, ah
		int	0F3h
		pop	ds
		pop	bp
		pop	di
		pop	si
		pop	dx
		pop	cx
		pop	ax
		retn
sub_14684	endp

; ---------------------------------------------------------------------------
		push	ax
		mov	ah, 9
		int	0F3h
		pop	ax
		retn

; =============== S U B	R O U T	I N E =======================================


sub_1469E	proc near		; CODE XREF: sub_118CA+15p
		push	ax
		mov	ah, 0Bh
		int	0F3h
		pop	ax
		retn
sub_1469E	endp


; =============== S U B	R O U T	I N E =======================================


sub_146A5	proc near		; CODE XREF: sub_10259+Dp sub_118E6+7p ...
		push	ax
		mov	ah, 0Ch
		int	0F3h
		pop	ax
		retn
sub_146A5	endp

; ---------------------------------------------------------------------------
		push	ax
		or	al, 80h
		mov	ah, 0Ch
		int	0F3h
		pop	ax
		retn

; =============== S U B	R O U T	I N E =======================================


sub_146B5	proc near		; CODE XREF: sub_118E6+Ap
					; DoKeyboardThing+Ap
		push	ax
		mov	ah, 0Fh
		int	0F3h
		pop	ax
		retn
sub_146B5	endp


; =============== S U B	R O U T	I N E =======================================


sub_146BC	proc near		; CODE XREF: sub_1026D+Dp sub_102B3+7p
		push	ax
		mov	ah, 6
		int	0F3h
		pop	ax
		retn
sub_146BC	endp


; =============== S U B	R O U T	I N E =======================================


sub_146C3	proc near		; CODE XREF: sub_11A98+5p sub_11ACF+5p ...
		push	ax
		push	cx
		push	dx
		push	si
		push	di
		push	bp
		push	ds
		mov	ah, 8
		int	0F3h
		pop	ds
		pop	bp
		pop	di
		pop	si
		pop	dx
		pop	cx
		pop	ax
		retn
sub_146C3	endp

; ---------------------------------------------------------------------------
		push	ax
		push	cx
		push	dx
		mov	ah, 1
		int	0F6h
		mov	cx, [si]
		mov	dx, [si+2]
		call	sub_14702
		pop	dx
		pop	cx
		pop	ax
		retn
; ---------------------------------------------------------------------------
		pusha
		push	ds
		push	es
		mov	ah, 2
		int	0F6h
		pop	es
		pop	ds
		popa
		retn
; ---------------------------------------------------------------------------
		push	ax
		mov	ah, 3
		int	0F6h
		pop	ax
		retn
; ---------------------------------------------------------------------------
		push	ax
		mov	ah, 4
		int	0F6h
		pop	ax
		retn

; =============== S U B	R O U T	I N E =======================================


sub_14702	proc near		; CODE XREF: seg000:46E2p
		push	ax
		mov	ah, 5
		int	0F6h
		pop	ax
		retn
sub_14702	endp

; ---------------------------------------------------------------------------
		push	ax
		mov	ah, 0Ah
		int	0F6h
		pop	ax
		retn
; ---------------------------------------------------------------------------
		push	ax
		mov	ax, 0B00h
		int	0F6h
		pop	ax
		retn
; ---------------------------------------------------------------------------
		push	ax
		mov	ah, 0Bh
		int	0F6h
		pop	ax
		retn
; ---------------------------------------------------------------------------

Mouse_Show:
		pusha
		push	ds
		push	es
		mov	ax, 1
		int	33h		; - MS MOUSE - SHOW MOUSE CURSOR
					; SeeAlso: AX=0002h, INT 16/AX=FFFEh
		pop	es
		pop	ds
		popa
		retn

; =============== S U B	R O U T	I N E =======================================


Mouse_Hide	proc near		; CODE XREF: DoInit+Fp
		pusha
		push	ds
		push	es
		mov	ax, 2
		int	33h		; - MS MOUSE - HIDE MOUSE CURSOR
					; SeeAlso: AX=0001h, INT 16/AX=FFFFh
		pop	es
		pop	ds
		popa
		retn
Mouse_Hide	endp


; =============== S U B	R O U T	I N E =======================================


Mouse_GetPos	proc near		; CODE XREF: ObtainMousePos+4p
					; CheckCheatCode+8p ...
		push	si
		push	di
		push	bp
		push	ds
		push	es
		mov	ax, 3
		int	33h		; - MS MOUSE - RETURN POSITION AND BUTTON STATUS
					; Return: BX = button status, CX = column, DX =	row
		pop	es
		pop	ds
		pop	bp
		pop	di
		pop	si
		retn
Mouse_GetPos	endp


; =============== S U B	R O U T	I N E =======================================


Mouse_SetPos	proc near		; CODE XREF: sub_10235+1Dp
					; sub_10549+20p
		pusha
		push	ds
		push	es
		mov	ax, 4
		int	33h		; - MS MOUSE - POSITION	MOUSE CURSOR
					; CX = column, DX = row
		pop	es
		pop	ds
		popa
		retn
Mouse_SetPos	endp


; =============== S U B	R O U T	I N E =======================================


Mouse_SetHRange	proc near		; CODE XREF: seg000:4A42p
		mov	ax, 7
		int	33h		; - MS MOUSE - DEFINE HORIZONTAL CURSOR	RANGE
					; CX = minimum column, DX = maximum column
		retn
Mouse_SetHRange	endp


; =============== S U B	R O U T	I N E =======================================


sub_14759	proc near		; CODE XREF: DoInit+9p
		push	ax
		mov	ax, 0Dh
		int	33h		; - MS MOUSE - LIGHT PEN EMULATION ON
					; SeeAlso: AX=000Eh
		pop	ax
		retn
sub_14759	endp


; =============== S U B	R O U T	I N E =======================================


Mouse_SetRegion	proc near		; CODE XREF: sub_10235+9p sub_10549+Ap
		push	ax
		mov	ax, 10h
		int	33h		; - MS MOUSE - DEFINE SCREEN REGION FOR	UPDATING
					; CX,DX	= X,Y coordinates of upper left	corner
					; SI,DI	= X,Y coordinates of lower right corner
		pop	ax
		retn
Mouse_SetRegion	endp


; =============== S U B	R O U T	I N E =======================================


sub_14769	proc near		; CODE XREF: sub_10235+12p
					; sub_10549+15p
		push	ax
		mov	ax, 11h
		int	33h		; - MS MOUSE -
		pop	ax
		retn
sub_14769	endp

; ---------------------------------------------------------------------------
		pusha
		push	ds
		push	es
		mov	ax, 8FFh
		int	0F1h		; reserved for user interrupt
		pop	es
		pop	ds
		popa
		retn
; ---------------------------------------------------------------------------
		pusha
		push	ds
		push	es
		mov	ah, 0Ah
		int	0F1h		; reserved for user interrupt
		pop	es
		pop	ds
		popa
		retn
; ---------------------------------------------------------------------------
		pusha
		push	ds
		push	es
		mov	ah, 0Bh
		int	0F1h		; reserved for user interrupt
		pop	es
		pop	ds
		popa
		retn

; =============== S U B	R O U T	I N E =======================================


advShiftJIS2JIS	proc near		; CODE XREF: GetChrData+1p
		push	ax		; input: ShiftJIS code in DX
		mov	ah, 2		; output: JIS code in DX
		int	0F1h		; call ADV API:	ShiftJIS -> JIS	code
		pop	ax
		retn
advShiftJIS2JIS	endp

; ---------------------------------------------------------------------------
		pusha
		push	ds
		push	es
		mov	ah, 2
		int	0F4h
		pop	es
		pop	ds
		popa
		retn

; =============== S U B	R O U T	I N E =======================================


APICall_ShowImg	proc near		; CODE XREF: ShowSomeActImg2+57p
					; DoFightEnd+26p ...
		push	ax
		push	bx
		xor	bh, bh
		mov	ah, 11h
		int	0F4h
		pop	bx
		pop	ax
		retn
APICall_ShowImg	endp


; =============== S U B	R O U T	I N E =======================================


sub_147B0	proc near		; CODE XREF: sub_14641+10p
		push	ax
		mov	ah, 13h
		int	0F3h
		pop	ax
		retn
sub_147B0	endp


; =============== S U B	R O U T	I N E =======================================


APICall_PaletteThing proc near		; CODE XREF: sub_1323E+Ep sub_132A7+Ep ...
		mov	ah, 14h
		int	0F3h
		retn
APICall_PaletteThing endp


; =============== S U B	R O U T	I N E =======================================


GetChrData	proc near		; CODE XREF: DrawTextChar+Ap
		push	dx
		call	advShiftJIS2JIS
		call	biosGetCharData
		call	GetBlock16
		pop	dx
		retn
GetChrData	endp


; =============== S U B	R O U T	I N E =======================================


biosGetCharData	proc near		; CODE XREF: GetChrData+4p
		push	ax
		push	di
		push	es
		mov	al, 1
		call	sub_147DF
		mov	di, seg	seg001
		mov	es, di
		assume es:seg001
		mov	di, offset TextChrBIOSHdr
		call	biosGetCharBits
		pop	es
		assume es:nothing
		pop	di
		pop	ax
		retn
biosGetCharData	endp


; =============== S U B	R O U T	I N E =======================================


sub_147DF	proc near		; CODE XREF: biosGetCharData+5p
		push	ax
		mov	ah, 1Bh
		int	18h		; do some BIOS call related to graphics
		pop	ax
		retn
sub_147DF	endp


; =============== S U B	R O U T	I N E =======================================


biosGetCharBits	proc near		; CODE XREF: biosGetCharData+10p
		push	ax
		push	bx
		push	cx
		push	dx
		mov	bx, es
		mov	cx, di
		mov	ah, 14h
		int	18h
		pop	dx
		pop	cx
		pop	bx
		pop	ax
		retn
biosGetCharBits	endp


; =============== S U B	R O U T	I N E =======================================


GetBlock16	proc near		; CODE XREF: GetChrData+7p
		pusha
		push	ds
		push	es
		mov	di, ds
		mov	es, di
		mov	di, si
		mov	si, seg	seg001
		mov	ds, si
		assume ds:seg001
		mov	si, offset TextChrBIOSBuf
		mov	cx, 10h
		cld
		rep movsw
		pop	es
		pop	ds
		assume ds:nothing
		popa
		retn
GetBlock16	endp


; =============== S U B	R O U T	I N E =======================================


MakeBold_16x16	proc near		; CODE XREF: DrawTextChar+Dp
		pusha
		push	es
		or	ch, ch
		jz	short loc_1483D
		mov	di, ds
		mov	es, di
		mov	di, si
		mov	bh, ch
		mov	cx, 10h
		cld

loc_14824:				; CODE XREF: MakeBold_16x16+29j
		lodsw
		mov	bl, bh
		xchg	ah, al

loc_14829:				; CODE XREF: MakeBold_16x16+24j
		mov	dx, ax
		shr	dx, 1
		jnb	short loc_14832
		or	dl, 2

loc_14832:				; CODE XREF: MakeBold_16x16+1Bj
		or	ax, dx
		dec	bl
		jnz	short loc_14829
		xchg	ah, al
		stosw
		loop	loc_14824

loc_1483D:				; CODE XREF: MakeBold_16x16+4j
		pop	es
		popa
		retn
MakeBold_16x16	endp


; =============== S U B	R O U T	I N E =======================================


sub_14840	proc near		; CODE XREF: sub_140E4+9p
					; sub_140E4+1Dp ...
		push	ax
		mov	al, 70h
		call	sub_1485D
		mov	al, bl
		call	sub_14865
		mov	al, bh
		call	sub_14865
		shr	al, 6
		call	sub_14865
		mov	al, 19h
		call	sub_14865
		pop	ax
		retn
sub_14840	endp


; =============== S U B	R O U T	I N E =======================================


sub_1485D	proc near		; CODE XREF: sub_14840+3p
		push	ax
		call	sub_1486D
		out	0A2h, al	; Interrupt Controller #2, 8259A
		pop	ax
		retn
sub_1485D	endp


; =============== S U B	R O U T	I N E =======================================


sub_14865	proc near		; CODE XREF: sub_14840+8p sub_14840+Dp ...
		push	ax
		call	sub_1486D
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1
		pop	ax
		retn
sub_14865	endp


; =============== S U B	R O U T	I N E =======================================


sub_1486D	proc near		; CODE XREF: sub_1485D+1p sub_14865+1p
		push	ax

loc_1486E:				; CODE XREF: sub_1486D+5j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		test	al, 2
		jnz	short loc_1486E
		pop	ax
		retn
sub_1486D	endp

; ---------------------------------------------------------------------------
		push	ax
		mov	ah, 0Ch
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		pop	ax
		retn
; ---------------------------------------------------------------------------
		push	ax
		mov	ah, 0Dh
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		pop	ax
		retn

; =============== S U B	R O U T	I N E =======================================


sub_14884	proc near		; CODE XREF: sub_12F68+Ep
					; sub_12F8D+14p ...
		pusha
		cld
		mov	ax, 80
		sub	ax, dx
		sub	bp, dx

loc_1488D:				; CODE XREF: sub_14884+20j
		mov	cx, dx
		test	si, 1
		jz	short loc_14897
		movsb
		dec	cx

loc_14897:				; CODE XREF: sub_14884+Fj
		shr	cx, 1
		rep movsw
		rcl	cx, 1
		rep movsb
		add	si, ax
		add	di, bp
		dec	bx
		jnz	short loc_1488D
		popa
		retn
sub_14884	endp


; =============== S U B	R O U T	I N E =======================================


sub_148A8	proc near		; CODE XREF: sub_1300B+Ep
					; sub_1305E+14p ...
		pusha
		cld
		mov	ax, 80
		sub	ax, dx
		sub	bp, dx

loc_148B1:				; CODE XREF: sub_148A8+20j
		mov	cx, dx
		test	di, 1
		jz	short loc_148BB
		movsb
		dec	cx

loc_148BB:				; CODE XREF: sub_148A8+Fj
		shr	cx, 1
		rep movsw
		rcl	cx, 1
		rep movsb
		add	si, bp
		add	di, ax
		dec	bx
		jnz	short loc_148B1
		popa
		retn
sub_148A8	endp


; =============== S U B	R O U T	I N E =======================================


Draw16x16	proc near		; CODE XREF: DrawTextChar+10p
		push	ax
		push	cx
		push	si
		push	di
		push	es
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		mov	al, 0C0h
		out	7Ch, al
		shr	cl, 1
		sbb	al, al
		out	7Eh, al
		shr	cl, 1
		sbb	al, al
		out	7Eh, al
		shr	cl, 1
		sbb	al, al
		out	7Eh, al
		shr	cl, 1
		sbb	al, al
		out	7Eh, al
		cld
		mov	ax, 4Eh
		mov	cx, 10h

loc_148F9:				; CODE XREF: Draw16x16+30j
		movsw
		add	di, ax
		loop	loc_148F9
		mov	al, 0
		out	7Ch, al
		pop	es
		assume es:nothing
		pop	di
		pop	si
		pop	cx
		pop	ax
		retn
Draw16x16	endp


; =============== S U B	R O U T	I N E =======================================


DoVRAMFill	proc near		; CODE XREF: ClearMessageBox+Cp
					; ClearStat_HP+13p ...
		pusha
		push	es
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		mov	al, 80h
		out	7Ch, al
		shr	cl, 1
		sbb	al, al
		out	7Eh, al
		shr	cl, 1
		sbb	al, al
		out	7Eh, al
		shr	cl, 1
		sbb	al, al
		out	7Eh, al
		shr	cl, 1
		sbb	al, al
		out	7Eh, al
		mov	ax, 50h
		sub	ax, dx
		cld

loc_14931:				; CODE XREF: DoVRAMFill+36j
		mov	cx, dx
		shr	cx, 1
		rep stosw
		rcl	cx, 1
		rep stosb
		add	di, ax
		dec	bx
		jnz	short loc_14931
		xor	ax, ax
		out	7Ch, al
		pop	es
		assume es:nothing
		popa
		retn
DoVRAMFill	endp


; =============== S U B	R O U T	I N E =======================================


sub_14947	proc near		; CODE XREF: sub_10C99+Cp
					; sub_10CB9+1Ep ...
		pusha
		push	es
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		mov	al, 0C0h
		out	7Ch, al
		shr	cl, 1
		sbb	al, al
		out	7Eh, al
		shr	cl, 1
		sbb	al, al
		out	7Eh, al
		shr	cl, 1
		sbb	al, al
		out	7Eh, al
		shr	cl, 1
		sbb	al, al
		out	7Eh, al
		mov	ah, 0FFh
		mov	cl, ch
		xor	ch, ch
		shr	ah, cl
		neg	cx
		add	cx, 8
		sub	dx, cx
		ja	short loc_14989
		neg	dx
		mov	cl, dl
		shr	ah, cl
		shl	ah, cl
		xor	bp, bp
		xor	al, al
		jmp	short loc_1499A
; ---------------------------------------------------------------------------

loc_14989:				; CODE XREF: sub_14947+32j
		mov	bp, dx
		shr	bp, 3
		not	dx
		and	dx, 7
		inc	dx
		mov	al, 0FFh
		mov	cl, dl
		shl	al, cl

loc_1499A:				; CODE XREF: sub_14947+40j
		mov	dl, 0FFh

loc_1499C:				; CODE XREF: sub_14947+68j
		push	di
		mov	es:[di], ah
		inc	di
		mov	cx, bp
		xchg	al, dl
		rep stosb
		xchg	al, dl
		stosb
		pop	di
		add	di, 50h
		dec	bx
		jnz	short loc_1499C
		xor	ax, ax
		out	7Ch, al
		pop	es
		assume es:nothing
		popa
		retn
sub_14947	endp


; =============== S U B	R O U T	I N E =======================================


FillTRAM	proc near		; CODE XREF: sub_133EC+Dp
		push	ax
		push	bx
		push	cx
		push	di
		push	bp
		push	es
		mov	bp, 0A0h
		sub	bp, dx
		sub	bp, dx
		mov	ax, 0A000h
		mov	es, ax
		assume es:nothing
		xor	ax, ax
		cld

loc_149CD:				; CODE XREF: FillTRAM+1Cj
		mov	cx, dx
		rep stosw
		add	di, bp
		dec	bx
		jnz	short loc_149CD
		pop	es
		assume es:nothing
		pop	bp
		pop	di
		pop	cx
		pop	bx
		pop	ax
		retn
FillTRAM	endp


; =============== S U B	R O U T	I N E =======================================


GDCPlane_RW0	proc near		; CODE XREF: LoadEnemyGfx+62p
					; LoadEnemyGfx:loc_1195Ep ...
		push	ax
		xor	al, al
		out	0A6h, al	; Interrupt Controller #2, 8259A
		pop	ax
		retn
GDCPlane_RW0	endp


; =============== S U B	R O U T	I N E =======================================


GDCPlane_RW1	proc near		; CODE XREF: LoadEnemyGfx+2p
					; LoadEnemyGfx+18p ...
		push	ax
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		pop	ax
		retn
GDCPlane_RW1	endp

; ---------------------------------------------------------------------------

GDCPlane_Disp0:
		push	ax
		xor	al, al
		out	0A4h, al	; Interrupt Controller #2, 8259A
		pop	ax
		retn
; ---------------------------------------------------------------------------

GDCPlane_Disp1:
		push	ax
		mov	al, 1
		out	0A4h, al	; Interrupt Controller #2, 8259A
		pop	ax
		retn
; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


GetRandomNum	proc near		; CODE XREF: Random_InRange+1p
		mov	ah, 1
		int	0F1h		; reserved for user interrupt
		retn
GetRandomNum	endp


; =============== S U B	R O U T	I N E =======================================


Random_InRange	proc near		; CODE XREF: GetRandomSelect+5p
					; seg000:1416p	...
		push	dx
		call	GetRandomNum
		shl	ax, 1
		inc	ax
		mul	dx
		mov	ax, dx
		pop	dx
		retn
Random_InRange	endp

; ---------------------------------------------------------------------------
		push	bx
		push	cx
		push	dx
		push	si
		call	Mouse_GetPos
		xor	bx, bx

loc_14A15:				; CODE XREF: seg000:4A39j
		mov	ax, [si]
		cmp	ax, 0FFFFh
		jz	short loc_14A3D
		cmp	cx, ax
		jb	short loc_14A35
		mov	ax, [si+2]
		cmp	dx, ax
		jb	short loc_14A35
		mov	ax, [si+4]
		cmp	cx, ax
		ja	short loc_14A35
		mov	ax, [si+6]
		cmp	dx, ax
		jbe	short loc_14A3B

loc_14A35:				; CODE XREF: seg000:4A1Ej seg000:4A25j ...
		inc	bx
		add	si, 8
		jmp	short loc_14A15
; ---------------------------------------------------------------------------

loc_14A3B:				; CODE XREF: seg000:4A33j
		mov	ax, bx

loc_14A3D:				; CODE XREF: seg000:4A1Aj
		pop	si
		pop	dx
		pop	cx
		pop	bx
		retn
; ---------------------------------------------------------------------------
		call	Mouse_SetHRange
		retn

; =============== S U B	R O U T	I N E =======================================


sub_14A46	proc near		; CODE XREF: SetFrameDelay1+7p
		mov	ah, 2
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		retn
sub_14A46	endp

; ---------------------------------------------------------------------------
		align 2

IntVec0A_VInt:				; DATA XREF: SetupInts2+1o
		push	ax
		push	ds
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		inc	frameCounter
		mov	al, 20h
		out	0, al
		out	64h, al
		pop	ds
		assume ds:nothing
		pop	ax
		iret
; ---------------------------------------------------------------------------

IntVec18:				; DATA XREF: SetupInts+2Eo
		push	si
		push	ds
		cli
		mov	si, seg	seg001
		mov	ds, si
		assume ds:seg001
		pushf
		call	OldInt18
		sti
		out	64h, al
		pop	ds
		assume ds:nothing
		pop	si
		iret

; =============== S U B	R O U T	I N E =======================================


SetupInts	proc near		; CODE XREF: SetupInts2+4p
		pusha
		push	ds
		push	es
		mov	dx, ax
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		cli
		mov	al, 0Ah
		call	GetIntVector
		mov	word ptr OldInt0A, bx
		mov	word ptr OldInt0A+2, es
		mov	al, 18h
		call	GetIntVector
		mov	word ptr OldInt18, bx
		mov	word ptr OldInt18+2, es
		mov	ax, cs
		mov	ds, ax
		assume ds:seg000
		mov	al, 0Ah
		call	SetIntVector
		mov	dx, offset IntVec18
		mov	al, 18h
		call	SetIntVector
		in	al, 2		; DMA controller, 8237A-5.
					; channel 1 current address
		and	al, 0FBh
		out	2, al		; DMA controller, 8237A-5.
					; channel 1 base address
					; (also	sets current address)
		out	64h, al		; 8042 keyboard	controller command register.
		sti
		pop	es
		pop	ds
		assume ds:nothing
		popa
		retn
SetupInts	endp


; =============== S U B	R O U T	I N E =======================================


RestoreInts	proc near		; CODE XREF: sub_1001Ep
		pusha
		push	ds
		push	es
		cli
		mov	dx, seg	seg001
		mov	ds, dx
		assume ds:seg001
		lds	dx, OldInt0A
		assume ds:nothing
		mov	al, 0Ah
		call	SetIntVector
		mov	dx, seg	seg001
		mov	ds, dx
		assume ds:seg001
		lds	dx, OldInt18
		assume ds:nothing
		mov	al, 18h
		call	SetIntVector
		in	al, 2		; DMA controller, 8237A-5.
					; channel 1 current address
		or	al, 4
		out	2, al		; DMA controller, 8237A-5.
					; channel 1 base address
					; (also	sets current address)
		sti
		pop	es
		pop	ds
		popa
		retn
RestoreInts	endp


; =============== S U B	R O U T	I N E =======================================


SetupInts2	proc near		; CODE XREF: sub_1000D+6p
		push	ax
		mov	ax, offset IntVec0A_VInt
		call	SetupInts
		pop	ax
		retn
SetupInts2	endp


; =============== S U B	R O U T	I N E =======================================


WaitForVInt	proc near		; CODE XREF: sub_10C99:loc_10CA2p
					; sub_10CB9:loc_10CD4p	...
		push	ax
		push	ds
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		mov	al, frameCounter

loc_14AF4:				; CODE XREF: WaitForVInt+10j
		mov	ah, frameCounter
		xor	ah, al
		jz	short loc_14AF4
		pop	ds
		assume ds:nothing
		pop	ax
		retn
WaitForVInt	endp


; =============== S U B	R O U T	I N E =======================================


WaitFrames	proc near		; CODE XREF: DrawText+FFp
					; sub_140E4:loc_140EAp	...
		push	cx
		push	ds
		mov	cx, seg	seg001
		mov	ds, cx
		assume ds:seg001
		xor	cx, cx
		mov	cl, FrameDelay
		or	cl, cl
		jz	short loc_14B15

loc_14B10:				; CODE XREF: WaitFrames+14j
		call	WaitForVInt
		loop	loc_14B10

loc_14B15:				; CODE XREF: WaitFrames+Fj
		pop	ds
		assume ds:nothing
		pop	cx
		retn
WaitFrames	endp


; =============== S U B	R O U T	I N E =======================================


GetIntVector	proc near		; CODE XREF: SetupInts+Dp
					; SetupInts+1Ap
		push	ax
		push	cx
		push	dx
		push	si
		push	di
		push	bp
		push	ds
		mov	ah, 35h
		int	21h		; DOS -	2+ - GET INTERRUPT VECTOR
					; AL = interrupt number
					; Return: ES:BX	= value	of interrupt vector
		pop	ds
		pop	bp
		pop	di
		pop	si
		pop	dx
		pop	cx
		pop	ax
		retn
GetIntVector	endp


; =============== S U B	R O U T	I N E =======================================


SetIntVector	proc near		; CODE XREF: SetupInts+2Bp
					; SetupInts+33p ...
		pusha
		push	ds
		push	es
		mov	ah, 25h
		int	21h		; DOS -	SET INTERRUPT VECTOR
					; AL = interrupt number
					; DS:DX	= new vector to	be used	for specified interrupt
		pop	es
		pop	ds
		popa
		retn
SetIntVector	endp

; ---------------------------------------------------------------------------
		pusha			; unused
		push	ds
		push	es
		mov	ax, 0A000h
		mov	es, ax
		assume es:nothing
		call	CalcTRAMOfs
		mov	cs:word_14CCB, ax

loc_14B45:				; CODE XREF: seg000:4B58j
		call	ShiftJIS2JIS
		cmp	dx, 6705h
		jz	short loc_14B5A
		xchg	dh, dl
		sub	dl, 20h
		call	DrawChar2B
		inc	si
		inc	si
		jmp	short loc_14B45
; ---------------------------------------------------------------------------

loc_14B5A:				; CODE XREF: seg000:4B4Cj
		pop	es
		assume es:nothing
		pop	ds
		popa
		retn

; =============== S U B	R O U T	I N E =======================================


DrawChar2B	proc near		; CODE XREF: seg000:4B53p
		mov	di, cs:word_14CCB ; unused
		add	cs:word_14CCB, 4
		mov	es:[di], dx	; write	character code to 0A000h:ofs
		add	di, 2000h
		mov	al, bl
		stosb			; write	text flags to 0A200h:ofs
		inc	di
		stosb
		retn
DrawChar2B	endp


; =============== S U B	R O U T	I N E =======================================


CalcTRAMOfs	proc near		; CODE XREF: seg000:4B3Ep
					; DrawBCD_4Dig+Ep ...
		push	dx		; Input: DL = Pixel X, DH = Pixel Y
		xor	ax, ax
		mov	al, dh
		xor	dh, dh
		shl	dx, 2
		imul	ax, 160
		add	ax, dx		; AX = DH * 160	+ DL / 2
		pop	dx
		retn
CalcTRAMOfs	endp


; =============== S U B	R O U T	I N E =======================================


ShiftJIS2JIS	proc near		; CODE XREF: seg000:loc_14B45p
		mov	dx, [si]	; unused
		xchg	dh, dl
		cmp	dh, 80h
		jz	short locret_14BB9
		cmp	dh, 0A0h
		jb	short loc_14B9E
		cmp	dh, 0F0h
		jnb	short locret_14BB9
		sub	dh, 40h

loc_14B9E:				; CODE XREF: ShiftJIS2JIS+Cj
		sub	dh, 70h
		cmp	dl, 80h
		jb	short loc_14BA8
		dec	dl

loc_14BA8:				; CODE XREF: ShiftJIS2JIS+1Cj
		shl	dh, 1
		cmp	dl, 9Eh
		jb	short loc_14BB4
		sub	dl, 5Eh
		inc	dh

loc_14BB4:				; CODE XREF: ShiftJIS2JIS+25j
		dec	dh
		sub	dl, 1Fh

locret_14BB9:				; CODE XREF: ShiftJIS2JIS+7j
					; ShiftJIS2JIS+11j
		retn
ShiftJIS2JIS	endp


; =============== S U B	R O U T	I N E =======================================


DrawBCD_4Dig	proc near		; CODE XREF: seg000:4C9Bp seg000:4CA3p ...
		pusha			; unused
		push	ds
		push	es
		mov	cx, ax
		mov	ax, cs
		mov	ds, ax
		assume ds:seg000
		mov	ax, 0A000h
		mov	es, ax
		assume es:nothing
		call	CalcTRAMOfs
		mov	cs:word_14CC9, ax
		mov	ax, cx
		shr	ah, 1
		shr	ah, 1
		shr	ah, 1
		shr	ah, 1
		add	ah, '0'
		xor	dx, dx
		mov	dl, ah
		call	DrawChar1B_2
		mov	ax, cx
		and	ah, 0Fh
		add	ah, '0'
		xor	dx, dx
		mov	dl, ah
		call	DrawChar1B_2
		mov	ax, cx
		shr	al, 1
		shr	al, 1
		shr	al, 1
		shr	al, 1
		add	al, '0'
		xor	dx, dx
		mov	dl, al
		call	DrawChar1B_2
		mov	ax, cx
		and	al, 0Fh
		add	al, '0'
		xor	dx, dx
		mov	dl, al
		call	DrawChar1B_2
		pop	es
		assume es:nothing
		pop	ds
		assume ds:nothing
		popa
		retn
DrawBCD_4Dig	endp


; =============== S U B	R O U T	I N E =======================================


DrawChar1B_2	proc near		; CODE XREF: DrawBCD_4Dig+26p
					; DrawBCD_4Dig+35p ...
		mov	di, cs:word_14CC9 ; unused
		add	cs:word_14CC9, 2
		cmp	dx, 58
		jb	short loc_14C29
		add	dx, 7

loc_14C29:				; CODE XREF: DrawChar1B_2+Ej
		mov	es:[di], dx	; write	character code to 0A000h:ofs
		add	di, 2000h
		mov	bh, 0E1h
		mov	es:[di], bh	; write	text flags to 0A200h:ofs
		retn
DrawChar1B_2	endp

; ---------------------------------------------------------------------------
		pusha			; unused
		push	ds
		push	es
		mov	bx, cs
		mov	ds, bx
		assume ds:seg000
		mov	bx, 0A000h
		mov	es, bx
		assume es:nothing
		mov	bx, ax
		call	CalcTRAMOfs
		mov	cs:word_14CCD, ax
		mov	ax, bx
		xor	dx, dx

loc_14C4F:				; CODE XREF: seg000:4C52j
		sub	ax, 10000
		jnb	short loc_14C4F
		add	ax, 10000
		mov	bx, 1000
		mov	cl, 4

loc_14C5C:				; CODE XREF: seg000:4C76j
		mov	ch, -1

loc_14C5E:				; CODE XREF: seg000:4C62j
		inc	ch
		sub	ax, bx
		jnb	short loc_14C5E
		add	ax, bx
		mov	dl, ch
		add	dl, '0'
		call	DrawChar1B
		xchg	ax, bx
		mov	ch, 0Ah
		div	ch
		xchg	ax, bx
		xor	ch, ch
		loop	loc_14C5C
		pop	es
		assume es:nothing
		pop	ds
		assume ds:nothing
		popa
		retn

; =============== S U B	R O U T	I N E =======================================


DrawChar1B	proc near		; CODE XREF: seg000:4C6Bp
		mov	di, cs:word_14CCD ; unused
		add	cs:word_14CCD, 2
		mov	es:[di], dx
		add	di, 2000h
		mov	dl, 0E1h
		mov	es:[di], dl
		retn
DrawChar1B	endp

; ---------------------------------------------------------------------------
		pusha			; unused
		push	ds
		push	es
		push	dx
		mov	dx, 0
		call	DrawBCD_4Dig
		mov	dx, 3
		mov	ax, bx
		call	DrawBCD_4Dig
		mov	dx, 6
		mov	ax, cx
		call	DrawBCD_4Dig
		mov	dx, 9
		pop	ax
		call	DrawBCD_4Dig
		mov	dx, 12
		mov	ax, si
		call	DrawBCD_4Dig
		mov	dx, 15
		mov	ax, di
		call	DrawBCD_4Dig
		pop	es
		pop	ds
		popa
		retn
; ---------------------------------------------------------------------------
word_14CC9	dw 0			; DATA XREF: DrawBCD_4Dig+11w
					; DrawChar1B_2r ...
word_14CCB	dw 0			; DATA XREF: seg000:4B41w DrawChar2Br	...
word_14CCD	dw 0			; DATA XREF: seg000:4C47w DrawChar1Br	...
		align 2
seg000		ends

; ===========================================================================

; Segment type:	Regular
seg001		segment	byte public 'UNK' use16
		assume cs:seg001
		assume es:nothing, ss:nothing, ds:nothing, fs:nothing, gs:nothing
byte_14CD0	db 0			; DATA XREF: sub_10053+7w sub_10062+7r
off_14CD1	dw offset unk_18512	; 0
		dw offset unk_1851C	; 1
		dw offset unk_18526	; 2
		dw offset unk_18530	; 3
		dw offset unk_1853A	; 4
		dw offset unk_18544	; 5
		dw 0FFFFh
		db    0
errorFlag	db 0			; DATA XREF: SetError+7w CheckError+7r
skipActions	db 0			; DATA XREF: DoAction+9r
					; DoPlayerActionSel+Er	...
AttackProb_Weak	db 70, 30		; DATA XREF: GenPlayerMoves+Ao
					; SelectEnemyAct+Do
					; probabilities	for Dengeki Nurse's weak attack:
					; Dengeki Punch	(70%)
					; Dengeki Scalpel Shuriken (30%)
AttackProb_Strong db 50, 30, 20		; DATA XREF: GenPlayerMoves+19o
					; SelectEnemyAct+23o
					; probabilities	for Dengeki Nurse's strong attack
					; Dengeki Kick (50%)
					; Dengeki Laser	Scalpel	(30%)
					; Dengeki Bazooka (20%)
DrugProb	db 10, 20, 10, 20, 5, 10, 20 ; DATA XREF: GenPlayerMoves+2Eo
					; GenPlayerMoves:loc_10F04o
					; probabilities	for Dengeki Nurse's drugs
					; Mescaline D (10%)
					; Barium Z (20%)
					; Mahiro Horumu	Powder (10%)
					; Vitamin N (20%)
					; Vitamin N Super (5%)
					; Protein V (10%)
					; Kirara Kotei Solution	(20%)
EnmSpcAtkProb	db 30, 10, 20, 10, 20, 10 ; DATA XREF: EnemySpcAct_Choose+Fo
					; probabilities	for enemy special attack
					; plow into the	target [strong attack] (30%)
					; plot twist [attack/defense swap] (10%)
					; Vitamin N Super [full	heal] (20%)
					; Bacillus 50 [transfer	HP] (10%)
					; Mahiro Horumu	[paralysis] (20%)
					; powerful EM wave [reduce Plasma Charge] (10%)
PlrActImageIDs	db 0FFh, 0FFh, 0FFh, 3,	3, 3, 7, 7; 0 ;	DATA XREF: ShowActionImage+2o
		db 7, 7, 0FFh, 0FFh, 0FFh, 0FFh, 8, 9; 8
		db 1, 5, 2, 4, 6	; 10h
EnmActImageIDs	db 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh; 0
					; DATA XREF: ShowActionImage+Bo
		db 0FFh, 0FFh, 11h, 0FFh, 0FFh,	0FFh, 0FFh, 0FFh; 8
		db 0FFh, 0FFh, 0FFh, 0FFh, 0FFh; 10h
byte_14D1E	db 0Ch,	0Dh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh; 0
					; DATA XREF: ShowSomeActImg+14o
		db 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh; 8
		db 0FFh, 0FFh, 0FFh, 0FFh, 0FFh; 10h
byte_14D33	db 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh; 0
					; DATA XREF: ShowSomeActImg+1Do
		db 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh; 8
		db 0FFh, 0FFh, 0FFh, 0FFh, 0FFh; 10h
byte_14D48	db 0FFh, 0Dh, 0Eh, 9, 9, 9, 0Ah, 0Ah; 0
					; DATA XREF: ShowSomeActImg2:loc_108B9o
		db 0Ah,	0Ah, 0Fh, 0FFh,	0FFh, 0FFh, 0Bh, 0Ch; 8
		db 0FFh, 7, 0FFh, 8, 0	; 10h
word_14D5D	dw 208			; DATA XREF: sub_10549+2r
word_14D5F	dw 431			; DATA XREF: sub_10549+6r
word_14D61	dw 208			; DATA XREF: sub_10549+Dr
word_14D63	dw 335			; DATA XREF: sub_10549+11r
word_14D65	dw 208			; DATA XREF: sub_10549+18r
word_14D67	dw 208			; DATA XREF: sub_10549+1Cr
mouseX		dw 0			; DATA XREF: ObtainMousePos+1o
mouseY		dw 0
cheatRegions	dw 288,	351, 256, 271	; DATA XREF: CheckCheatCode+1Eo
					; CheckCheatCode+52o
		dw 288,	351, 320, 335
		dw 208,	223, 272, 319
		dw 416,	431, 272, 319
		dw 360,	423, 208, 239
cheatRgnOrder	dw 0, 0, 1, 1, 2, 3, 2,	3, 4 ; DATA XREF: CheckCheatCode+15o
cheatCodeCntr	dw 0			; DATA XREF: CheckCheatCode+Fr
					; CheckCheatCode+35w ...
		db    0
dword_14DAA	dd 0			; DATA XREF: seg000:13A5o
dword_14DAE	dd 0			; DATA XREF: seg000:13B2o
aAAct_gpcSflame	db 'A:\ACT_GPC\SFLAME.GPA',0 ; DATA XREF: LoadSFlameGPA+8o
off_14DC8	dw offset byte_14DCC	; DATA XREF: sub_118CA+8o
		dw offset byte_14DF0
byte_14DCC	db 2Eh,	0B1h, 2Eh, 2Eh,	2Eh, 2Eh, 2Eh ;	DATA XREF: seg001:off_14DC8o
		db 2Eh,	0B2h, 2Eh, 2Eh,	2Eh, 2Eh, 2Eh
		db 2Eh,	0B3h, 2Eh, 2Eh,	2Eh, 2Eh, 2Eh
		db 2Eh,	0B4h, 2Eh, 2Eh,	2Eh, 2Eh, 2Eh
		db 2Eh,	0B5h, 2Eh, 2Eh,	2Eh, 2Eh, 2Eh
		db 22h
byte_14DF0	db 2Eh,	0B1h, 22h	; DATA XREF: seg001:off_14DC8o
		db    0
fnListD1CVC	dw offset aAAct_gpcD1cvc1; 0 ; DATA XREF: LoadD1CVC+Do
		dw offset aAAct_gpcD1cvc2; 1 ; "A:\\ACT_GPC\\D1CVC1.GPC"
		dw offset aAAct_gpcD1cvc3; 2
		dw offset aAAct_gpcD1cvc4; 3
		dw offset aAAct_gpcD1cvc5; 4
aAAct_gpcD1cvc1	db 'A:\ACT_GPC\D1CVC1.GPC',0 ; DATA XREF: seg001:fnListD1CVCo
aAAct_gpcD1cvc2	db 'A:\ACT_GPC\D1CVC2.GPC',0 ; DATA XREF: seg001:fnListD1CVCo
aAAct_gpcD1cvc3	db 'A:\ACT_GPC\D1CVC3.GPC',0 ; DATA XREF: seg001:fnListD1CVCo
aAAct_gpcD1cvc4	db 'A:\ACT_GPC\D1CVC4.GPC',0 ; DATA XREF: seg001:fnListD1CVCo
aAAct_gpcD1cvc5	db 'A:\ACT_GPC\D1CVC5.GPC',0 ; DATA XREF: seg001:fnListD1CVCo
fnListD1Enm	dw offset aAAct_gpcD1enmf; 0 ; DATA XREF: LoadD1ENMF+Do
		dw offset aAAct_gpcD1enmf; 1 ; "A:\\ACT_GPC\\D1ENMF0B.GPC"
		dw offset aAAct_gpcD1en_0; 2
		dw offset aAAct_gpcD1en_1; 3
		dw offset aBAct_gpcD1enmf; 4
		dw offset aBAct_gpcD1en_0; 5
		dw offset aBAct_gpcD1en_1; 6
		dw offset aBAct_gpcD1en_2; 7
		dw offset aBAct_gpcD1en_3; 8
		dw offset aBAct_gpcD1en_4; 9
		dw offset aBAct_gpcD1en_5; 10
		dw offset aBAct_gpcD1en_6; 11
		dw offset aBAct_gpcD1en_7; 12
		dw offset aBAct_gpcD1en_8; 13
		dw offset aBAct_gpcD1en_9; 14
		dw offset aBAct_gpcD1e_10; 15
aAAct_gpcD1enmf	db 'A:\ACT_GPC\D1ENMF0B.GPC',0 ; DATA XREF: seg001:fnListD1Enmo
aAAct_gpcD1en_0	db 'A:\ACT_GPC\D1ENMF1B.GPC',0 ; DATA XREF: seg001:fnListD1Enmo
aAAct_gpcD1en_1	db 'A:\ACT_GPC\D1ENMF2B.GPC',0 ; DATA XREF: seg001:fnListD1Enmo
aBAct_gpcD1enmf	db 'B:\ACT_GPC\D1ENMF3B.GPC',0 ; DATA XREF: seg001:fnListD1Enmo
aBAct_gpcD1en_0	db 'B:\ACT_GPC\D1ENMF4B.GPC',0 ; DATA XREF: seg001:fnListD1Enmo
aBAct_gpcD1en_1	db 'B:\ACT_GPC\D1ENMF5B.GPC',0 ; DATA XREF: seg001:fnListD1Enmo
aBAct_gpcD1en_2	db 'B:\ACT_GPC\D1ENMF6B.GPC',0 ; DATA XREF: seg001:fnListD1Enmo
aBAct_gpcD1en_3	db 'B:\ACT_GPC\D1ENMF7B.GPC',0 ; DATA XREF: seg001:fnListD1Enmo
aBAct_gpcD1en_4	db 'B:\ACT_GPC\D1ENMF8B.GPC',0 ; DATA XREF: seg001:fnListD1Enmo
aBAct_gpcD1en_5	db 'B:\ACT_GPC\D1ENMF9B.GPC',0 ; DATA XREF: seg001:fnListD1Enmo
aBAct_gpcD1en_6	db 'B:\ACT_GPC\D1ENMFAB.GPC',0 ; DATA XREF: seg001:fnListD1Enmo
aBAct_gpcD1en_7	db 'B:\ACT_GPC\D1ENMFBB.GPC',0 ; DATA XREF: seg001:fnListD1Enmo
aBAct_gpcD1en_8	db 'B:\ACT_GPC\D1ENMFCB.GPC',0 ; DATA XREF: seg001:fnListD1Enmo
aBAct_gpcD1en_9	db 'B:\ACT_GPC\D1ENMFDB.GPC',0 ; DATA XREF: seg001:fnListD1Enmo
aBAct_gpcD1e_10	db 'B:\ACT_GPC\D1ENMFEB.GPC',0 ; DATA XREF: seg001:fnListD1Enmo
fnD1CVC6	db 'A:\ACT_GPC\D1CVC6.GPC',0 ; DATA XREF: LoadD1CVC6+8o
word_1500A	dw 0, 0E00h, 1C00h, 2A00h, 3800h, 4600h, 5400h,	6200h, 7000h
					; DATA XREF: DrawActionImage+Eo
		dw 0, 0E00h, 1C00h, 2A00h, 3800h, 4600h, 5400h,	6200h, 0
tCoord_Actions	dw offset a@x27@y264@c0@f; 0 ; DATA XREF: ShowActionText+11o
		dw offset a@x27@y280@c0@f; 1 ; "@X27@Y264@C0@F1"
		dw offset a@x27@y296@c0@f; 2
a@x27@y264@c0@f	db '@X27@Y264@C0@F1',0  ; DATA XREF: seg001:tCoord_Actionso
a@x27@y280@c0@f	db '@X27@Y280@C0@F1',0  ; DATA XREF: seg001:tCoord_Actionso
a@x27@y296@c0@f	db '@X27@Y296@C0@F1',0  ; DATA XREF: seg001:tCoord_Actionso
tListActions	dw offset aDrug_MescalineD; 0 ;	DATA XREF: ShowActionText+1Do
		dw offset aDrug_MescalineD; 1 ;	names of actions (attacks, drugs)
		dw offset aDrug_MescalineD; 2
		dw offset aDrug_MescalineD; 3
		dw offset aDrug_BariumZ	; 4
		dw offset aDrug_Mahiroholm; 5
		dw offset aDrug_VitaminN; 6
		dw offset aDrug_VitNSuper; 7
		dw offset aDrug_ProteinV; 8
		dw offset aDrug_KiraraKotei; 9
		dw offset aAtk_PlasmaFlash; 0Ah
		dw offset aAtk_PlasmaFlash; 0Bh
		dw offset aAtk_PlasmaFlash; 0Ch
		dw offset aAtk_PlasmaFlash; 0Dh
		dw offset aDrug_Electrode2; 0Eh
		dw offset aAtk_DengekiPunch; 0Fh
		dw offset aAtk_DengekiPunch; 10h
		dw offset aAtk_DgScalpelShuriken; 11h
		dw offset aAtk_DengekiKick; 12h
		dw offset aAtk_DgLaserScalpel; 13h
		dw offset aAtk_DengekiBazooka; 14h
aDrug_MescalineD db 'ÉÅÉXÉJÉäÉìÇc',0    ; DATA XREF: seg001:tListActionso
aDrug_BariumZ	db 'ÉoÉäÉEÉÄÇy',0       ; DATA XREF: seg001:tListActionso
aDrug_Mahiroholm db 'É}ÉqÉçÉzÉãÉÄ',0    ; DATA XREF: seg001:tListActionso
aDrug_VitaminN	db 'ÉrÉ^É~ÉìÇm',0       ; DATA XREF: seg001:tListActionso
aDrug_VitNSuper	db 'ÉrÉ^É~ÉìÇmÅ@ÇìÇïÇêÇÖÇí',0 ; DATA XREF: seg001:tListActionso
aDrug_ProteinV	db 'ÉvÉçÉeÉCÉìÇu',0     ; DATA XREF: seg001:tListActionso
aDrug_KiraraKotei db 'ÉLÉâÉââ©íÈât',0   ; DATA XREF: seg001:tListActionso
aAtk_PlasmaFlash db 'ÉvÉâÉYÉ}ÉtÉâÉbÉVÉÖ',0 ; DATA XREF: seg001:tListActionso
aDrug_Electrode2 db 'ìdã…ÇQçÜ',0        ; DATA XREF: seg001:tListActionso
aAtk_DengekiPunch db 'ìdåÇÉpÉìÉ`',0     ; DATA XREF: seg001:tListActionso
aAtk_DgScalpelShuriken db 'ìdåÇÉÅÉXéËó†åï',0 ; DATA XREF: seg001:tListActionso
aAtk_DengekiKick db 'ìdåÇÉLÉbÉN',0      ; DATA XREF: seg001:tListActionso
aAtk_DgLaserScalpel db 'ìdåÇÉåÅ[ÉUÅ[ÉÅÉX',0 ; DATA XREF: seg001:tListActionso
aAtk_DengekiBazooka db 'ìdåÇÉoÉYÅ[ÉJ',0 ; DATA XREF: seg001:tListActionso
tCoord_HP	dw offset a@x7@y328@c0@f1; 0 ; DATA XREF: ShowStat_HP+14o
		dw offset a@x61@y328@c0@f; 1 ; "@X7@Y328@C0@F1"
a@x7@y328@c0@f1	db '@X7@Y328@C0@F1',0   ; DATA XREF: seg001:tCoord_HPo
a@x61@y328@c0@f	db '@X61@Y328@C0@F1',0  ; DATA XREF: seg001:tCoord_HPo
tCoord_Atk	dw offset a@x7@y344@c0@f1; 0 ; DATA XREF: ShowStat_Atk+14o
		dw offset a@x61@y344@c0@f; 1 ; "@X7@Y344@C0@F1"
a@x7@y344@c0@f1	db '@X7@Y344@C0@F1',0   ; DATA XREF: seg001:tCoord_Atko
a@x61@y344@c0@f	db '@X61@Y344@C0@F1',0  ; DATA XREF: seg001:tCoord_Atko
tCoord_Def	dw offset a@x7@y360@c0@f1; 0 ; DATA XREF: ShowStat_Def+14o
		dw offset a@x61@y360@c0@f; 1 ; "@X7@Y360@C0@F1"
a@x7@y360@c0@f1	db '@X7@Y360@C0@F1',0   ; DATA XREF: seg001:tCoord_Defo
a@x61@y360@c0@f	db '@X61@Y360@C0@F1',0  ; DATA XREF: seg001:tCoord_Defo
aHealth		db 'ëÃóÕÅ@',0           ; DATA XREF: ShowStat_HP+22o
aAttack		db 'çUåÇóÕ',0           ; DATA XREF: ShowStat_Atk+22o
aDefense	db 'éÁîıóÕ',0           ; DATA XREF: ShowStat_Def+22o
txtDirections	db 'ìå'                 ; DATA XREF: SetDirectionText+Eo
					; East
		db 'êº'                 ; West
		db 'ìÏ'                 ; North
		db 'ñk'                 ; South
tCoord_Msg	db '@X27@Y264@C0@F1',0  ; DATA XREF: ShowMessageText+Bo
tListMessages	dw offset aMsg01	; 0 ; DATA XREF: ShowMessageText+11o
		dw offset aMsg01	; 1 ; general messages that describe attacks etc.
		dw offset aMsg02	; 2
		dw offset aMsg03	; 3
		dw offset aMsg04	; 4
		dw offset aMsg05	; 5
		dw offset aMsg06	; 6
		dw offset aMsg07	; 7
		dw offset aMsg08	; 8
		dw offset aMsg09	; 9
		dw offset aUdmvgibGxvVB@b; 0Ah
		dw offset aUdmvgibGxvCRsv; 0Bh
		dw offset aVVGGcguggvG_gb; 0Ch
		dw offset aOcfovVVBBiG_gb; 0Dh
		dw offset aVNumvvVivavVVV; 0Eh
		dw offset aVVNumvcVGGcgug; 0Fh
		dw offset aVVOcfCVGGcgugg; 10h
		dw offset aVVTjrxr_movGGq; 11h
		dw offset aVGhgigbgovMIVk; 12h
		dw offset aVSCVkGGcguggiX; 13h
		dw offset aVSCVKossvIXVV; 14h
		dw offset aVNumvcVGGcgugg; 15h
		dw offset aVOcfCVGGcguggp; 16h
		dw offset aVUdlVqnjvVVVPo; 17h
		dw offset aGvgigygGGgbGwc; 18h
		dw offset aVGGcguggvG_gbb; 19h
		dw offset aVG_gbbGwvOVpvV; 1Ah
		dw offset aVNumvvVivavV@c; 1Bh
		dw offset aVNumvcVGGcgu_0; 1Ch
		dw offset aVOcfCVGGcguggi; 1Dh
		dw offset aVTjrxr_movkg_0; 1Eh
		dw offset aVRR_pwtjvkvV_0; 1Fh
		dw offset aVGvgigygGtgigb; 20h
		dw offset aLncVUdoefgvVVG; 21h
		dw offset aUdoefgvFcvVVlv; 22h
		dw offset aVGGcguggvG_g_0; 23h
		dw offset aVVVVNumvvTCpvV; 24h
		dw offset aVVVuvVuvVuvVub; 25h
		dw offset aVGbgxgjgkguvcv; 26h
		dw offset aVGogkgegavyvOg; 27h
		dw offset aVGGqgngzglgavO; 28h
		dw offset aVGvgngegcguvuv; 29h
		dw offset aVGlgigiiitsitv; 2Ah
		dw offset aVGrgGGuvmvOgvV; 2Bh
		dw offset aVGrgGGuvmb@vuv; 2Ch
		dw offset aVSCVKossvIXVVB; 2Dh
		dw offset aVNumvcVGGcgu_1; 2Eh
		dw offset aVOcfCVGGcgug_0; 2Fh
		dw offset aVSCVGGcguggiXV; 30h
		dw offset aGvgigygGpgpbVk; 31h
		dw offset aGvgigygGpgpbVC; 32h
		dw offset aVlvcvcvVBdvVVV; 33h
		dw offset aVLVMVivVGxgngi; 34h
		dw offset aVLVivcNxpOTctn; 35h
		dw offset aVVsvVsvVsbVBiR; 36h
		dw offset aUdmvgibGxvOcfC; 37h
		dw offset aVVirkvGrgGGuvm; 38h
		dw offset aVGjgpgcgcvirkv; 39h
		dw offset aLncVUdoefgvkfn; 3Ah
		dw offset aVVVuvVVuvVVubV; 3Bh
		dw offset aVSCVtvobuvkVTd; 3Ch
		dw offset aVVBBBVVBibiUNu; 3Dh
		dw offset aVVivBdbdIVrvVV; 3Eh
		dw offset aLncVUdoefgbibi; 3Fh
		dw offset a@c7vavcbaviviv; 40h
		dw offset aLncVUdoefgvCwk; 41h
		dw offset aB@b@vimiocvIMv; 42h
		dw offset aB@b@lgvpvVnvsi; 43h
		dw offset aGvgigygGGgbG_0; 44h
aMsg01		db 0Dh,'Å@ÉRÉ}ÉìÉhÇëIÇÒÇ≈ÇÀÇ¡ÅI',0 ; DATA XREF: seg001:tListMessageso
aMsg02		db 10h,'ÇÃ',0Dh,'íÜêïê_åoÇÕê≥èÌÇ…ñﬂÇ¡ÇΩÅI',0
					; DATA XREF: seg001:tListMessageso
aMsg03		db 'ÉhÉâÉbÉOÇÃÇ◊ÇøÇ·Ç◊ÇøÇ·ÇÕ',0Dh,'Ç«Ç§Ç…Ç©ÅAä£Ç¢ÇƒÇ´ÇΩÅI',0Dh,0Dh,'@C4Å@ÇÊÅ`Ç'
					; DATA XREF: seg001:tListMessageso
		db 'µÅAÇ±ÇÍÇ»ÇÁëÂè‰ïvÅI',0
aMsg04		db 10h,'ÇÕ',0Dh,'óéÇøíÖÇ´ÇéÊÇËñﬂÇµÇΩÅI',0Dh,0Dh,'Å@Ç†Å`ÅAÇÊÇ©Ç¡ÇΩÇÊÇ©Ç¡ÇΩÅc',0
					; DATA XREF: seg001:tListMessageso
aMsg05		db 10h,'ÇÕ',0Dh,'íÜêïê_åoÇ™É}ÉqÇµÇƒÇ¢ÇÈÅI',0
					; DATA XREF: seg001:tListMessageso
aMsg06		db 'ÉhÉâÉbÉOÇÕ',0Dh,'Ç◊ÇøÇ·Ç◊ÇøÇ·Ç…Ç»Ç¡ÇƒÇ¢ÇÈ',0Dh,'@C4Å@Ç¢Ç‚Å`ÇÒÅI',0Dh,'Å@ãC'
					; DATA XREF: seg001:tListMessageso
		db 'éùÇøà´Ç≠ÇƒégÇ¶Ç»Ç¢Ç¡ÅI',0
aMsg07		db 10h,'ÇÕ',0Dh,'ê∏ê_èWíÜÇ™Ç≈Ç´Ç»Ç¢ÅI',0 ; DATA XREF: seg001:tListMessageso
aMsg08		db 'ìdã…ÇQçÜÇégÇ¡ÇƒÇ¢Ç‹Ç∑',0Dh,'ìdã…ÇQçÜÇÇ–Ç¡Ç±ÇﬂÇ‹Ç∑Ç©ÅH',0Dh,0Dh,'Å@Å@Å@ÇÕ'
					; DATA XREF: seg001:tListMessageso
		db 'Ç¢Å@Å@Ç¢Ç¢Ç¶',0
aMsg09		db '@C4ìdã…ÇQçÜÇ†ÇËÇ™Ç∆Ç§ÅB',0Dh,'Ç†Ç∆ÇÕéÑÇ™êÌÇ§ÇÌÅB',0Dh,'@C0Å@Å@ìdåÇÉiÅ[É'
					; DATA XREF: seg001:tListMessageso
		db 'XÇÕ',0Dh,'Å@Å@Å@ìdã…ÇQçÜÇÇ–Ç¡Ç±ÇﬂÇΩ',0
aUdmvgibGxvVB@b	db 'ìdåÇÉiÅ[ÉXÇÕ',0Dh,11h,'Ç',0Dh,'Å@Å@Å@Å@Ç‚Ç¡Ç¬ÇØÇΩÅI',0Dh,'ã≠Ç¢ÇºñlÇÁÇÃìdåÇÉi'
					; DATA XREF: seg001:tListMessageso
		db 'Å[ÉXÅIÅI',0
aUdmvgibGxvCRsv	db 'ìdåÇÉiÅ[ÉXÇÕóÕêsÇ´ì|ÇÍÇΩÅc',0Dh,0Dh,'Å@âìÇ≠ÇÃãÛÇ≈',0Dh,'Å@Å@Å@Å@àÓç»Ç™ãÉÇ¢'
					; DATA XREF: seg001:tListMessageso
		db 'ÇƒÇ¢ÇÈÅc',0
aVVGGcguggvG_gb	db 10h,'ÇÕ',0Dh,11h,'Ç…',0Dh,14h,'É|ÉCÉìÉgÇÃ',0Dh,'É_ÉÅÅ[ÉWÇó^Ç¶ÇΩÅI',0
					; DATA XREF: seg001:tListMessageso
aOcfovVVBBiG_gb	db 'écîOÇ≈ÇµÇΩÅ`ÅI',0Dh,'É_ÉÅÅ[ÉWÇó^Ç¶ÇÁÇÍÇ‹ÇπÇÒÅI',0Dh,0Dh,'@C4Å@âΩÇ≈Ç•Ç¡ÅIÇ'
					; DATA XREF: seg001:tListMessageso
		db '«Ç§ÇµÇƒÇ•ÅH',0
aVNumvvVivavVVV	db 10h,'ÇÃ',0Dh,'çUåÇÇÕÇ©ÇÌÇ≥ÇÍÇƒÇµÇ‹Ç¡ÇΩÅI',0Dh,0Dh,'@C4Å@Ç∏Ç¡ÇÈÅ`Ç¢ÅIÇ‚ÇﬂÇƒÇÊÇ¡'
					; DATA XREF: seg001:tListMessageso
		db 'ÅI',0
aVVNumvcVGGcgug	db 10h,'ÇÕ',0Dh,11h,'ÇÃ',0Dh,'çUåÇóÕÇ',0Dh,14h,'É|ÉCÉìÉgâ∫Ç∞ÇΩÅI',0
					; DATA XREF: seg001:tListMessageso
aVVOcfCVGGcgugg	db 10h,'ÇÕ',0Dh,11h,'ÇÃ',0Dh,'éÁîıóÕÇ',0Dh,14h,'É|ÉCÉìÉgâ∫Ç∞ÇΩÅI',0
					; DATA XREF: seg001:tListMessageso
aVVTjrxr_movGGq	db 10h,'ÇÕ',0Dh,11h,'ÇÃ',0Dh,'íÜêïê_åoÇÉ}ÉqÇ≥ÇπÇΩÅI',0
					; DATA XREF: seg001:tListMessageso
aVGhgigbgovMIVk	db 10h,'ÇÃÉhÉâÉbÉOÇÕ',0Dh,'å¯â Ç™Ç»Ç©Ç¡ÇΩÅcÅc',0Dh,0Dh,'@C4Å@Ç®Ç¡Ç©ÇµÇ¢Ç»Ç†ÅcÅc',0
					; DATA XREF: seg001:tListMessageso
aVSCVkGGcguggiX	db 10h,'ÇÕ',0Dh,'ëÃóÕÇ™',14h,'É|ÉCÉìÉgâÒïúÇµÇΩ',0
					; DATA XREF: seg001:tListMessageso
aVSCVKossvIXVV	db 10h,'ÇÃ',0Dh,'ëÃóÕÇÕäÆëSÇ…âÒïúÇµÇΩ',0 ; DATA XREF: seg001:tListMessageso
aVNumvcVGGcgugg	db 10h,'ÇÃ',0Dh,'çUåÇóÕÇÕ',0Dh,14h,'É|ÉCÉìÉgè„Ç™Ç¡ÇΩ',0
					; DATA XREF: seg001:tListMessageso
aVOcfCVGGcguggp	db 10h,'ÇÃ',0Dh,'éÁîıóÕÇÕ',0Dh,14h,'É|ÉCÉìÉgè„Ç™Ç¡ÇΩ',0
					; DATA XREF: seg001:tListMessageso
aVUdlVqnjvVVVPo	db 10h,'ÇÕ',0Dh,'ìdã…ÇQçÜÇÇªÇ¡Ç∆èoÇµÇΩ',0Dh,11h,'ÇÕ',0Dh,'Ç‹Ç¡ÇΩÇ≠ãCÇ√Ç¢ÇƒÇ¢Ç»Ç¢ÅI',0
					; DATA XREF: seg001:tListMessageso
aGvgigygGGgbGwc	db 'ÉvÉâÉYÉ}É`ÉÉÅ[ÉWó ',14h,'Åì',0Dh,'Ç†Ç∆',13h,'ÅìÇ≈',0Dh,'ÉvÉâÉYÉ}ÉtÉâÉbÉVÉÖégó'
					; DATA XREF: seg001:tListMessageso
		db 'pâ¬î\',0
aVGGcguggvG_gbb	db 11h,'ÇÕ',0Dh,14h,'É|ÉCÉìÉgÇÃ',0Dh,'É_ÉÅÅ[ÉWÇéÛÇØÇΩ',0
					; DATA XREF: seg001:tListMessageso
aVG_gbbGwvOVpvV	db 11h,'ÇÕ',0Dh,'É_ÉÅÅ[ÉWÇéÛÇØÇ»Ç©Ç¡ÇΩ',0Dh,0Dh,'@C4Å@Ç÷Ç÷Ç÷ÅIÇ‹Ç¢Ç¡ÇΩÇ©ÅIÅH',0
					; DATA XREF: seg001:tListMessageso
aVNumvvVivavV@c	db 11h,'ÇÕ',0Dh,'çUåÇÇÇ©ÇÌÇµÇΩ',0Dh,0Dh,'@C4Å@Å@Ç©ÇÈÇ¢ÅAÇ©ÇÈÅ`Ç¢ÅI',0
					; DATA XREF: seg001:tListMessageso
aVNumvcVGGcgu_0	db 11h,'ÇÃ',0Dh,'çUåÇóÕÇÕ',0Dh,14h,'É|ÉCÉìÉgâ∫Ç™Ç¡ÇΩ',0
					; DATA XREF: seg001:tListMessageso
aVOcfCVGGcguggi	db 11h,'ÇÃ',0Dh,'éÁîıóÕÇÕ',0Dh,14h,'É|ÉCÉìÉgâ∫Ç™Ç¡ÇΩ',0
					; DATA XREF: seg001:tListMessageso
aVTjrxr_movkg_0	db 11h,'ÇÕ',0Dh,'íÜêïê_åoÇ™É}ÉqÇµÇΩÅI',0Dh,'ÉsÅ[ÉìÉ`ÅIÅI',0Dh,'Ç±ÇÍÇ≈ÇÕçUåÇÇ≈Ç´Ç»'
					; DATA XREF: seg001:tListMessageso
		db 'Ç¢Ç¡ÅIÅI',0
aVRR_pwtjvkvV_0	db 11h,'ÇÕ',0Dh,'ê∏ê_èWíÜÇ™Ç≈Ç´Ç»Ç≠Ç»Ç¡ÇΩÅI',0Dh,'ÉvÉâÉYÉ}É`ÉÉÅ[ÉWïsî\ÇæÅIÅI',0
					; DATA XREF: seg001:tListMessageso
aVGvgigygGtgigb	db 11h,'ÇÕ',0Dh,'ÉvÉâÉYÉ}ÉtÉâÉbÉVÉÖÇ™',0Dh,'åÇÇƒÇ»Ç≠Ç»Ç¡ÇΩÇµÇ‹Ç¡ÇΩÅIÅI',0Dh,'Å@Å@'
					; DATA XREF: seg001:tListMessageso
		db 'Ç«ÅAÇ«Ç§ÇµÇÊÇ§Åc',0
aLncVUdoefgvVVG	db 'ã≠óÕÇ»ìdé•îgÇÃÇΩÇﬂ',0Dh,'ÉvÉâÉYÉ}ÉtÉâÉbÉVÉÖÇÕ',0Dh,'égÇ§Ç±Ç∆Ç™Ç≈Ç´Ç»Ç¢Å'
					; DATA XREF: seg001:tListMessageso
		db 'IÅI',0Dh,'Å@Å@ÅcÅcÅcÅcÅcÅcÅc',0
aUdoefgvFcvVVlv	db 'ìdé•îgÇÕîñÇÍÇƒÇ´ÇΩ',0Dh,'ÉvÉâÉYÉ}ÉtÉâÉbÉVÉÖÇ™',0Dh,'åÇÇƒÇÈÇÒÇ∂Ç·Ç»Ç¢Ç©Ç'
					; DATA XREF: seg001:tListMessageso
		db '»ÅIÅI',0Dh,'Å@Å@Å@ÇÊÅ[ÇµÇ¡ÅIÅI',0
aVGGcguggvG_g_0	db 11h,'ÇÕ',0Dh,14h,'É|ÉCÉìÉgÇÃ',0Dh,'É_ÉÅÅ[ÉWÇéÛÇØÇΩÅI',0
					; DATA XREF: seg001:tListMessageso
aVVVVNumvvTCpvV	db 11h,'Ç…',0Dh,'ÇªÇÒÇ»çUåÇÇÕí ópÇµÇ»Ç¢ÅI',0Dh,'ê¶Ç¢ÇºÅIìdã…ÇQçÜÅIÅI',0
					; DATA XREF: seg001:tListMessageso
aVVVuvVuvVuvVub	db 'Ç’ÇµÇ„ÇµÇ„ÇµÇ„ÇµÇ„Åc',0Dh,'ìdã…ÇQçÜÇÕîﬂÇµÇ¢âπÇ∆',0Dh,'ã§Ç…ÇµÇ⁄ÇÒÇ≈ÇµÇ‹Ç'
					; DATA XREF: seg001:tListMessageso
		db '¡ÇΩÅcÅcÅc',0
aVGbgxgjgkguvcv	db 10h,'ÇÕ',0Dh,'ÉÅÉXÉJÉäÉìÇcÇégÇ¡ÇΩÅI',0
					; DATA XREF: seg001:tListMessageso
aVGogkgegavyvOg	db 10h,'ÇÕ',0Dh,'ÉoÉäÉEÉÄÇyÇégÇ¡ÇΩÅI',0 ; DATA XREF: seg001:tListMessageso
aVGGqgngzglgavO	db 10h,'ÇÕ',0Dh,'É}ÉqÉçÉzÉãÉÄÇégÇ¡ÇΩÅI',0
					; DATA XREF: seg001:tListMessageso
aVGvgngegcguvuv	db 10h,'ÇÕ',0Dh,'ÉvÉçÉeÉCÉìÇuÇégÇ¡ÇΩÅI',0
					; DATA XREF: seg001:tListMessageso
aVGlgigiiitsitv	db 10h,'ÇÕ',0Dh,'ÉLÉâÉââ©íÈâtÇégÇ¡ÇΩÅI',0
					; DATA XREF: seg001:tListMessageso
aVGrgGGuvmvOgvV	db 10h,'ÇÕ',0Dh,'ÉrÉ^É~ÉìÇmÇégÇ¡ÇΩÅI',0 ; DATA XREF: seg001:tListMessageso
aVGrgGGuvmb@vuv	db 10h,'ÇÕ',0Dh,'ÉrÉ^É~ÉìÇmÅ@ÇìÇïÇêÇÖÇí',0Dh,'ÇégÇ¡ÇΩÅI',0
					; DATA XREF: seg001:tListMessageso
aVSCVKossvIXVVB	db 10h,'ÇÃ',0Dh,'ëÃóÕÇÕäÆëSÇ…âÒïúÇµÇΩÅI',0
					; DATA XREF: seg001:tListMessageso
aVNumvcVGGcgu_1	db 10h,'ÇÃ',0Dh,'çUåÇóÕÇÕ',0Dh,14h,'É|ÉCÉìÉgè„Ç™Ç¡ÇΩÅI',0
					; DATA XREF: seg001:tListMessageso
aVOcfCVGGcgug_0	db 10h,'ÇÃ',0Dh,'éÁîıóÕÇÕ',0Dh,14h,'É|ÉCÉìÉgè„Ç™Ç¡ÇΩÅI',0
					; DATA XREF: seg001:tListMessageso
aVSCVGGcguggiXV	db 10h,'ÇÃ',0Dh,'ëÃóÕÇÕ',14h,'É|ÉCÉìÉgâÒïúÇµÇΩ',0
					; DATA XREF: seg001:tListMessageso
aGvgigygGpgpbVk	db 'ÉvÉâÉYÉ}ÉpÉèÅ[Ç™ë´ÇËÇ»Ç¢ÅI',0Dh,'ÉvÉâÉYÉ}ÉtÉâÉbÉVÉÖÇÕ',0Dh,'ÉpÉèÅ[Ç™ÇTÇ'
					; DATA XREF: seg001:tListMessageso
		db 'OÅìà»è„Ç»Ç´Ç·',0Dh,'Å@î≠éÀÇ≈Ç´Ç‹ÇπÅ`ÇÒÅIÅI',0
aGvgigygGpgpbVC	db 'ÉvÉâÉYÉ}ÉpÉèÅ[ÇÕñûÉ^ÉìÇÊÅI',0Dh,'Å@Å@ìdãCÇÕëÂêÿÇ…ÉlÅI',0
					; DATA XREF: seg001:tListMessageso
aVlvcvcvVBdvVVV	db 'Ç´ÇÁÇÁÇÕÇÒÅdÇ∑ÇÒÇ‹Ç÷ÇÒÅdÅd',0Dh,'ÉèÉeÇÕÇ‡Ç§êÌÇ¶Ç‹Ç÷ÇÒÅdÅd',0Dh,'Ç®ñÇ…Ç'
					; DATA XREF: seg001:tListMessageso
		db 'ΩÇƒÇ‹Ç÷ÇÒÇ≈',0Dh,'Ç¶ÇÁÇ¢ê\ÇµñÛÇ®Ç‹Ç÷ÇÒÅdÅd',0
aVLVMVivVGxgngi	db 10h,'ÇÕ',0Dh,'ãÛÇ…å¸Ç©Ç¡Çƒ',0Dh,'ÉXÉNÉâÉìÉuÉãî≠êMÇÇµÇΩÅI',0
					; DATA XREF: seg001:tListMessageso
aVLVivcNxpOTctn	db 12h,'ÇÃãÛÇ©ÇÁ',0Dh,'çïè\éöícíçéÀäÌì¡çUë‡',0Dh,'Ç™åªÇÍÇΩÅIÅI',0
					; DATA XREF: seg001:tListMessageso
aVVsvVsvVsbVBiR	db 0Dh,'Ç∂Ç·Ç∂Ç·Ç∂Ç·Å`ÇÒÅI',0Dh,'ê¢ãIÇÃëÂÇ«Å`ÇÒÇ≈Å`ÇÒï‘ÇµÅI',0
					; DATA XREF: seg001:tListMessageso
aUdmvgibGxvOcfC	db 'ìdåÇÉiÅ[ÉXÇÃéÁîıóÕÅEçUåÇóÕ',0Dh,'Ç∆',10h,0Dh,'ÇÃéÁîıóÕÅEçUåÇóÕÇ',0Dh,'Å@ì¸ÇÍ'
					; DATA XREF: seg001:tListMessageso
		db 'ë÷Ç¶Ç‹Å`Ç∑ÅIÅI',0
aVVirkvGrgGGuvm	db 10h,'ÇÃ',0Dh,'Ç®êKÇ…',0Dh,'ÉrÉ^É~ÉìÇmÅ@ÇìÇïÇêÇÖÇí',0Dh,'Ç™ìÀÇ´éhÇ≥Ç¡ÇΩÅIÅI',0
					; DATA XREF: seg001:tListMessageso
aVGjgpgcgcvirkv	db 11h,'ÇÃÉJÉèÉCÉCÇ®êKÇ',0Dh,'ÇﬂÇ™ÇØÇƒÉ}ÉqÉçÉzÉãÉÄÇ™',0Dh,'Ç–Ç„Ç§ÇÒÇ∆îÚÇÒÇ≈Ç´'
					; DATA XREF: seg001:tListMessageso
		db 'ÇΩÅIÅI',0
aLncVUdoefgvkfn	db 'ã≠óÕÇ»ìdé•îgÇ™î≠ê∂ÇµÇΩÅI',0Dh,'ìdåÇÉiÅ[ÉXÇÕ',0Dh,'ÉvÉâÉYÉ}ÉpÉèÅ[Ç',0Dh,'Ç'
					; DATA XREF: seg001:tListMessageso
		db 'TÇOÅìï˙ìdÇµÇƒÇµÇ‹Ç¡ÇΩÅIÅI',0
aVVVuvVVuvVVubV	db 'ÇœÇµÇ„ÇœÇµÇ„ÇœÇµÇ„Å`ÇÒÅI',0Dh,'ìdåÇÉiÅ[ÉXÇÕÅA',0Dh,'ÉoÉ`ÉâÉXÇTÇOÇè∆éÀÇ'
					; DATA XREF: seg001:tListMessageso
		db '≥ÇÍÇΩÅI',0
aVSCVtvobuvkVTd	db 11h,'ÇÃëÃóÕÇTÇOÅìÇ™',0Dh,10h,'Ç…',0Dh,'íDÇÌÇÍÇƒÇµÇ‹Ç¡ÇΩÅIÅI',0Dh,'@C4Å@ÇµÅAêMÇ∂ÇÁ'
					; DATA XREF: seg001:tListMessageso
		db 'ÇÒÇ»Å`Ç¢Ç¡ÅI',0
aVVBBBVVBibiUNu	db 0Dh,'ÇŒÇ≤Å`Å`Å`ÇÒÇ¡ÅIÅI',0Dh,'ì¡çUë‡ÇÕëÃìñÇËÇÇ©Ç‹ÇµÇΩÅI',0
					; DATA XREF: seg001:tListMessageso
aVVivBdbdIVrvVV	db 'ÇµÇ©ÇµÅdÅd',0Dh,'âΩÇ‡ÇµÇ»Ç¢Ç≈ãéÇ¡ÇƒÇ¢Ç¡ÇΩÅd',0
					; DATA XREF: seg001:tListMessageso
aLncVUdoefgbibi	db 'ã≠óÕÇ»ìdé•îgÅIÅI',0Dh,'ìdåÇÉiÅ[ÉXÇÕ',0Dh,'ÉvÉâÉYÉ}ÉpÉèÅ[ÇíDÇÌÇÍÇΩÅI',0
					; DATA XREF: seg001:tListMessageso
a@c7vavcbaviviv	db '@C7Ç†ÇÁÅAÇ®Ç©ÇµÇ¢ÇÌÇÀÅH',0Dh,'åÃè·Ç©ÇµÇÁÅH',0Dh,'ÉvÉâÉYÉ}îgÇÃèWÇ‹ÇËÇ™à´'
					; DATA XREF: seg001:tListMessageso
		db 'Ç¢ÇÌ',0
aLncVUdoefgvCwk	db 'ã≠óÕÇ»ìdé•îgÇÃñWäQÇ≈',0Dh,'ìdåÇÉÅÉXéËó†åïÇÕÇ†Ç≥Ç¡ÇƒÇÃ',0Dh,'ï˚äpÇ…îÚÇÒÇ'
					; DATA XREF: seg001:tListMessageso
		db '≈Ç¢Ç¡ÇΩÅdÅd',0
aB@b@vimiocvIMv	db 0Dh,'Å@Å@Ç®å©éñÇ»àÍåÇÇ¡ÅIÅI',0 ; DATA XREF: seg001:tListMessageso
aB@b@lgvpvVnvsi	db 0Dh,'Å@Å@ãÉÇØÇƒÇ≠ÇÈàÍåÇÅdÅd',0 ; DATA XREF: seg001:tListMessageso
aGvgigygGGgbG_0	db 'ÉvÉâÉYÉ}É`ÉÉÅ[ÉWó ',14h,'Åì',0Dh,'ÉvÉâÉYÉ}ÉtÉâÉbÉVÉÖégópâ¬î\',0
					; DATA XREF: seg001:tListMessageso
tCoord_PlrChat	db '@X27@Y264@C4@F1',0  ; DATA XREF: ShowChat1Text+Bo
tListPlayer	dw offset aChatPlr_00	; 0 ; DATA XREF: ShowChat1Text+11o
		dw offset aChatPlr_01	; 1 ; player speech
		dw offset aVVVBiB@b@udmvg; 2
		dw offset aVVVVrvnvcvvvVV; 3
		dw offset aB@komxvVvvvvav; 4
		dw offset aB@b@gvbegibegy; 5
		dw offset aNumvcVkvavsvVm; 6
		dw offset aOcfCVknvvvvBaU; 7
		dw offset aUnvliVmvSVVcvn; 8
		dw offset aVVxvVSVVVVVuvs; 9
		dw offset aVVxbavVxvVGGug; 0Ah
		dw offset aUdlVqnjbaVVxvV; 0Bh
		dw offset aB@b@b@gvgigygG; 0Ch
		dw offset aVVnvVnvVVnvVav; 0Dh
		dw offset aVVnvVnvVabVabc; 0Eh
		dw offset aVrvdvVBcbcVVIP; 0Fh
		dw offset aB@b@vvvVBVvbiB; 10h
		dw offset aVtvVVebivtvVav; 11h
		dw offset aVVVBiVVVNumvuc; 12h
		dw offset aVVBVBiVVVVSssr; 13h
		dw offset aVVVXVNumvvkTCp; 14h
		dw offset aVvvtbVBiSVivcc; 15h
		dw offset aVtvVavBiLUVkvV; 16h
		dw offset aVavavavVBiSVko; 17h
		dw offset aVtvVVcvBiIsvvv; 18h
		dw offset aVavabcvVVBcbcV; 19h
		dw offset aVBavVdvVVBhOwr; 1Ah
		dw offset aVjvjvjvBibiVVV; 1Bh
		dw offset aGigbglbBibiIVV; 1Ch
		dw offset aVdbVBdbdUVVVVi; 1Dh
		dw offset aVjbVBiVVVVFSev; 1Eh
		dw offset aVVVvvcbBiVVViv; 1Fh
		dw offset aVnbavnbavnbapl; 20h
aChatPlr_00	db 0Dh,'Å@Ç¢Ç≠ÇÌÇÊÇ¡ÅI',0Dh,'Å@Å@Å@Å@ìdåÇÉpÅ`ÉìÉ`ÅIÅI',0
					; DATA XREF: seg001:tListPlayero
aChatPlr_01	db 0Dh,'Å@Ç¶Å[Ç¢Ç¡ÅI',0Dh,'Å@Å@Å@Å@ìdåÇÉLÅ`ÉbÉNÅIÅI',0
					; DATA XREF: seg001:tListPlayero
aVVVBiB@b@udmvg	db 0Dh,'ÇªÇÍÇ¡ÅI',0Dh,'Å@Å@ìdåÇÉÅÉXéËó†åïÇ¡ÅIÅI',0
					; DATA XREF: seg001:tListPlayero
aVVVVrvnvcvvvVV	db 0Dh,'Ç±ÇÍÇ≈Ç‡Ç≠ÇÁÇ¢Ç»Ç≥Ç¢Ç¡ÅI',0Dh,'Å@Å@ìdåÇÉåÅ[ÉUÅ[ÉÅÉXÅIÅI',0
					; DATA XREF: seg001:tListPlayero
aB@komxvVvvvvav	db 0Dh,'Å@äoåÂÇÕÇ¢Ç¢ÇÌÇÀÇ¡ÅI',0Dh,'Å@Å@Å@ìdåÇÉoÉYÅ[ÉJÇ¡ÅIÅI',0
					; DATA XREF: seg001:tListPlayero
aB@b@gvbegibegy	db 0Dh,'Å@Å@ÉvÅEÉâÅEÉYÅEÉ}',0Dh,'Å@ÉtÉâÅ`Å`Å`Å`ÉbÉVÉÖÅIÅI',0
					; DATA XREF: seg001:tListPlayero
aNumvcVkvavsvVm	db 'çUåÇóÕÇ™Ç†ÇËÇ∑Ç¨ÇÈÇ∆',0Dh,'çÇååà≥Ç…Ç»Ç¡Çƒ',0Dh,'í∑ê∂Ç´Ç≈Ç´Ç»Ç¢ÇÌÇÊÇ¡ÅIÅ'
					; DATA XREF: seg001:tListPlayero
		db 'I',0
aOcfCVknvvvvBaU	db 0Dh,'éÁîıóÕÇ™çÇÇ¢Ç∆ÅA',0Dh,'ìúîAïaÇ…Ç»ÇËÇ‚Ç∑Ç¢ÇÃÇÊÇ¡ÅI',0
					; DATA XREF: seg001:tListPlayero
aUnvliVmvSVVcvn	db 'ì≠Ç´âﬂÇ¨ÇÕ',0Dh,'ëÃÇ…ÇÊÇ≠Ç»Ç¢ÇÌÅI',0Dh,'è≠ÇµÅAãxÇ›Ç»Ç≥Ç¢Ç¡ÅIÅI',0
					; DATA XREF: seg001:tListPlayero
aVVxvVSVVVVVuvs	db 'ÇøÇÂÇ¡Ç∆ë“Ç¡ÇƒÇÀ',0Dh,'ÇøÇ„ÇÈÇøÇ„ÇÈÇøÇ„ÇÈÇøÇ„ÇÈÅc',0Dh,'Ç§Å`ÇÒå≥ãCÇ™Ç≈Ç'
					; DATA XREF: seg001:tListPlayero
		db 'ƒÇ´ÇΩÇÌÅIÅI',0
aVVxbavVxvVGGug	db 'ÇøÇÂÅAÇøÇÂÇ¡Ç∆É^ÉìÉ}ÅI',0Dh,'ÇøÇ„ÇøÇ„ÇøÇ„ÇøÇ„ÇøÇ„ÇøÇ„Åc',0Dh,'ÇÊÅ`ÇµÅAÇ'
					; DATA XREF: seg001:tListPlayero
		db '±ÇÍÇ≈ÉoÉbÉ`ÉOÅ[ÅI',0
aUdlVqnjbaVVxvV	db 0Dh,'ìdã…ÇQçÜÅA',0Dh,'ÇøÇÂÇ¡Ç∆ÇÃä‘ÅAÇ®äËÇ¢ÇÀÉbÅI',0
					; DATA XREF: seg001:tListPlayero
aB@b@b@gvgigygG	db 0Dh,'Å@Å@Å@ÉvÉâÉYÉ}ÉpÉèÅ`',0Dh,'Å@Å@Å@É`ÉÉÅ`ÉWÇnÇmÅIÅI',0
					; DATA XREF: seg001:tListPlayero
aVVnvVnvVVnvVav	db 'Ç≤Ç≠Ç≤Ç≠Ç≤Ç¡Ç≠ÇÒ',0Dh,'Ç†Ç†Ç†ÇÒÅc',0Dh,'ëÃÇ™îMÇ≠ÇŸÇƒÇ¡ÇƒÇ´ÇøÇ·Ç§Åc',0
					; DATA XREF: seg001:tListPlayero
aVVnvVnvVabVabc	db 'Ç≤Ç≠Ç≤Ç≠Ç¡',0Dh,'Ç†Å`Ç†Åc',0Dh,'Ç‹ÇΩãÿì˜Ç™ëùã≠ÇµÇøÇ·Ç¡ÇΩÅc',0
					; DATA XREF: seg001:tListPlayero
aVrvdvVBcbcVVIP	db 0Dh,'Ç‡Ç§ÇæÇﬂÅcÅc',0Dh,'Ç±ÇÍà»è„ÅcêÌÇ¶Ç»Ç¢Ç¡ÅcÅcÅc',0
					; DATA XREF: seg001:tListPlayero
aB@b@vvvVBVvbiB	db 0Dh,'Å@Å@Ç¢Ç¡ÇΩÅ`Ç¢ÅI',0Dh,'Å@Å@âΩÇ∑ÇÈÇÃÇÊÇßÅIÅI',0
					; DATA XREF: seg001:tListPlayero
aVtvVVebivtvVav	db 'Ç‚ÇﬂÇƒÇ•ÅIÇ‚ÇæÇ†Ç¡ÅI',0Dh,'Ç«Ç§ÇµÇƒÅAÇªÇÒÇ»',0Dh,'ïœÇ»çUåÇÇ™Ç≈Ç´ÇÈÇÃÇÊÇ'
					; DATA XREF: seg001:tListPlayero
		db '¡ÅI',0
aVVVBiVVVNumvuc	db 0Dh,'Ç”ÇÒÇ¡ÅI',0Dh,'ÇªÇÒÇ»çUåÇìñÇΩÇÁÇ»Ç¢ÇÌÇÊÅI',0
					; DATA XREF: seg001:tListPlayero
aVVBVBiVVVVSssr	db 0Dh,'Ç÷Ç÷Å`ÇÒÅI',0Dh,'ÇªÇÒÇ»ÇÃëSëRÅAí…Ç≠Ç»Ç¢ÇÌÅI',0
					; DATA XREF: seg001:tListPlayero
aVVVXVNumvvkTCp	db 0Dh,'ÇªÇÒÇ»ïœÇ»çUåÇÇ™',0Dh,'í ópÇ∑ÇÈÇÌÇØÇ»Ç¢Ç≈ÇµÇÂÅI',0
					; DATA XREF: seg001:tListPlayero
aVvvtbVBiSVivcc	db 0Dh,'Ç¢Ç‚Å`ÇÒÅI',0Dh,'ëÃÇ©ÇÁóÕÇ™î≤ÇØÇøÇ·Ç§Ç¡ÅIÅI',0
					; DATA XREF: seg001:tListPlayero
aVtvVavBiLUVkvV	db 'Ç‚ÇæÇ†Ç¡ÅI',0Dh,'ãÿì˜Ç™Ç’Ç…ÇÂÇ’Ç…ÇÂÇ…',0Dh,'Ç»Ç¡ÇøÇ·Ç§Ç§Ç¡ÅIÅI',0
					; DATA XREF: seg001:tListPlayero
aVavavavVBiSVko	db 0Dh,'Ç†Ç†Ç†ÇÒÇ¡ÅI',0Dh,'ëÃÇ™é©óRÇ…ìÆÇ©Ç»Ç¢Ç¡ÅIÅI',0
					; DATA XREF: seg001:tListPlayero
aVtvVVcvBiIsvvv	db 0Dh,'Ç‚ÇﬂÇƒÇÊÇ¡ÅI',0Dh,'âòÇ¢Ç∂Ç·Ç»Ç¢ÇÃÇÊÇ¡ÅIÅI',0
					; DATA XREF: seg001:tListPlayero
aVavabcvVVBcbcV	db 'Ç†Ç†ÅcÇªÇÒÇ»ÅcÅc',0Dh,'Ç‚ÅAÇ‚ÇæÇ¡ÅcÇ‚ÇﬂÇƒÅcÅc',0
					; DATA XREF: seg001:tListPlayero
aVBavVdvVVBhOwr	db 'Ç«ÅAÇ«Ç§ÇµÇΩÇÃÅH',0Dh,'éwêÊÇ©ÇÁÉvÉâÉYÉ}îgÇ™',0Dh,'è¡Ç¶ÇƒÇ‰Ç≠ÅcÅcÅc',0
					; DATA XREF: seg001:tListPlayero
aVjvjvjvBibiVVV	db 'Ç¶Ç¶Ç¶Ç¡ÅIÅI',0Dh,'ÇªÇÒÇ»ÇÃÇ†ÇËÉBÅ`ÉbÅIÅH',0
					; DATA XREF: seg001:tListPlayero
aGigbglbBibiIVV	db 'ÉâÉbÉLÅ[ÅIÅI',0Dh,'âΩÇæÇ©ìæÇµÇøÇ·Ç¡ÇΩÉ@ÅIÅI',0
					; DATA XREF: seg001:tListPlayero
aVdbVBdbdUVVVVi	db 'Ç§Å`ÇÒÅdÅd',0Dh,'ìæÇµÇΩÇÃÇ©Ç»ÅdÅd',0Dh,'ëπÇµÇΩÇÃÇ©Ç»ÅdÅd',0Dh,'Ç‹Ç¡ÅAÇ«Ç§Ç'
					; DATA XREF: seg001:tListPlayero
		db '≈Ç‡Ç¢Ç¢Ç‚ÅI',0
aVjbVBiVVVVFSev	db 0Dh,'Ç¶Å`Ç¡ÅI',0Dh,'ÇªÇÒÇ»ÇÃîΩë•ÇæÇÊÉHÅIÅI',0
					; DATA XREF: seg001:tListPlayero
aVVVvvcbBiVVViv	db 0Dh,'Ç–Ç«Ç¢ÇÊÅ`ÅI',0Dh,'ÇπÇ¡Ç©Ç≠ãÍòJÇµÇƒó≠ÇﬂÇΩÇÃÇ…',0
					; DATA XREF: seg001:tListPlayero
aVnbavnbavnbapl	db 0Dh,'Ç≠ÅAÇ≠ÅAÇ≠ÅAèLÇ¡Ç≥Å`Ç¢ÅIÅI',0 ; DATA XREF: seg001:tListPlayero
tCoord_EnmChat	db '@X27@Y264@C7@F1',0  ; DATA XREF: ShowChat2Text+Bo
tListEnemy	dw offset ChTxt_Enemy01	; 0 ; DATA XREF: ShowChat2Text+11o
		dw offset ChTxt_Enemy01	; 1 ; enemy speeches (each enemy has 7 different lines)
		dw offset ChTxt_Enemy02	; 2
		dw offset ChTxt_Enemy03	; 3
		dw offset off_16BA6	; 4
		dw offset off_16DA2	; 5
		dw offset off_16F57	; 6
		dw offset off_1718C	; 7
		dw offset off_1738E	; 8
		dw offset off_175BF	; 9
		dw offset off_1777B	; 10
		dw offset off_179CF	; 11
		dw offset off_17BF9	; 12
		dw offset off_17DE5	; 13
		dw offset off_17FD8	; 14
		dw offset ChTxt_Enemy0F	; 15
ChTxt_Enemy01	dw offset aChatEnm_01_0	; 0 ; DATA XREF: seg001:tListEnemyo
		dw offset aChatEnm_01_1	; 1 ; "Ç¶Å`Ç¢Ç¡ÅI\rÇ∆Ç‡ÇÊÉ`ÉáÉbÉvÇæÇüÅI\r@C0ÇÿÇµ"...
		dw offset aChatEnm_01_2	; 2
		dw offset aChatEnm_01_3	; 3
		dw offset aChatEnm_01_4	; 4
		dw offset aChatEnm_01_5	; 5
		dw offset aChatEnm_01_6	; 6
		dw offset aChatEnm_01_7	; 7
aChatEnm_01_0	db 'Ç¶Å`Ç¢Ç¡ÅI',0Dh,'Ç∆Ç‡ÇÊÉ`ÉáÉbÉvÇæÇüÅI',0Dh,'@C0ÇÿÇµÇÿÇµÇÿÇµÇÿÇµÅIÅI',0
					; DATA XREF: seg001:ChTxt_Enemy01o
aChatEnm_01_1	db 'Ç¢Ç≠ÇÌÇÊÇßÅI',0Dh,'ï@ååÇ™êÅÇ´èoÇÈ',0Dh,'Å@Å@íEéâñ»â‘êÅê·Ç¡ÅI',0
					; DATA XREF: seg001:ChTxt_Enemy01o
aChatEnm_01_2	db 0Dh,'ÇæÇ†Ç†ÇüÇüÇüÇüÇ¡ÅIÅI',0Dh,'ÉuÉåÅ`ÉìÉoÉXÉ^ÉAÉ@Å`ÅIÅI',0
					; DATA XREF: seg001:ChTxt_Enemy01o
aChatEnm_01_3	db 'Ç†Ç–Ç·Å`ÇÒÇ¡ÅI',0Dh,'ÇªÇÒÇ»Ç±Ç∆ÇµÇΩÇÁÅA',0Dh,'í…Ç¢Ç∂Ç·Ç»Ç¢ÇÃÇÊÇßÇ¡ÅIÅI',0
					; DATA XREF: seg001:ChTxt_Enemy01o
aChatEnm_01_4	db 'Ç”ÇÒÇ”ÇÒÇ”ÇÒÇ¡ÅI',0Dh,'ÇÕÇ∏ÇÍÇæÇÊÇßÇÒÅIÅI',0Dh,'Ç¥Ç‹Ç†ÉJÉìÉJÉìÇ©Ç¡ÇœÇÃÉ'
					; DATA XREF: seg001:ChTxt_Enemy01o
		db 'wÅ`',0
aChatEnm_01_5	db 'Ç†ÇÁÇüÇÒÅdÅdÉnÉGÇ™é~Ç‹Ç¡ÇΩ',0Dh,'Ç©Ç∆évÇ¡ÇøÇ·ÇΩÇÌÇÒÅI',0Dh,'íbÇ¶íºÇµÇΩÇ'
					; DATA XREF: seg001:ChTxt_Enemy01o
		db 'ÁÇ¢Ç©Ç™Ç≈Ç∑Ç£ÅH',0
aChatEnm_01_6	db 'Ç«Ç¡Ç–Ç·ÇüÇüÅ`ÅIÅI',0Dh,'Ç¢Ç‚ÇüÇÒÅIÇŒÇ©ÇüÇÒÅI',0Dh,'Ç‡Ç§É_ÉÅÇ≈Ç¶Ç•Ç•Ç•Ç'
					; DATA XREF: seg001:ChTxt_Enemy01o
		db '•Ç∑ÅIÅI',0
ChTxt_Enemy02	dw offset aChatEnm_02_0	; 0 ; DATA XREF: seg001:tListEnemyo
		dw offset a@c0VVVirkvTorf; 1 ; "\rïKéEÇ†Ç‚Ç“ÇÂÇÒÉoÉXÉ^Å`ÅI\rÅ@Å@Å@Å@Å@Å@Å"...
		dw offset a@c0VXsovlcvCxv; 2
		dw offset aVlvuvabVBiVtvV; 3
		dw offset aVavcvavBiVrvVi; 4
		dw offset aVlvsvVVBiSssrt; 5
		dw offset aVavavavavavava; 6
		dw offset aChatEnm_01_7	; 7
aChatEnm_02_0	db 0Dh,'ïKéEÇ†Ç‚Ç“ÇÂÇÒÉoÉXÉ^Å`ÅI',0Dh,'Å@Å@Å@Å@Å@Å@Å@Ç≈Ç∑ÇÌÅ`Å`ÅI',0
					; DATA XREF: seg001:ChTxt_Enemy02o
a@c0VVVirkvTorf	db '@C0',10h,'ÇÕ',0Dh,11h,'ÇÃÇ®êKÇ…',0Dh,'íÆêfäÌÇÇ†ÇƒÇΩÅI',0Dh,'@C7Å@Å@Å@êfé@ÇµÇ‹Ç∑'
					; DATA XREF: seg001:ChTxt_Enemy02o
		db 'ÇÌÅ`ÅI',0
a@c0VXsovlcvCxv	db '@C0',10h,'ÇÕ',0Dh,'ïsévãcÇ»óxÇËÇóxÇ¡ÇΩÅI',0Dh,'@C7Å@Ç“Å`Ç–Ç·ÇÁÇ“Å`Ç–Ç·ÇÁ',0Dh
					; DATA XREF: seg001:ChTxt_Enemy02o
		db 'Å@ÇΩÇËÇÁÇËÇÁÅ`ÇÒÇ≈Ç∑ÇÌÇ¡ÅI',0
aVlvuvabVBiVtvV	db 'Ç´Ç„ÇÌÅ`ÇÒÅI',0Dh,'Ç‚ÇﬂÇƒâ∫Ç≥Ç¢Ç‹ÇπÇ‹ÇπÇ•Å`ÅI',0
					; DATA XREF: seg001:ChTxt_Enemy02o
aVavcvavBiVrvVi	db 'Ç†ÇÁÇ†ÇÒÅI',0Dh,'Ç‡ÇµÇ©ÇµÇΩÇÁ',0Dh,'ìñÇΩÇÁÇ»Ç©Ç¡ÇΩÇÃÇ≈Ç∑ÇÀÅ`ÅI',0Dh,'écîOÇ'
					; DATA XREF: seg001:ChTxt_Enemy02o
		db '≈ÇµÇΩÇÌÇÀÅ`ÅI',0
aVlvsvVVBiSssrt	db 'Ç´Ç·Ç“Ç“Ç“ÅI',0Dh,'ëSëRí…Ç≠Ç»Ç¢Ç≈Ç∑ÇÌÅ`ÅI',0Dh,'ÇÈÇÒÇÈÇÒÅAÇÊÇ©Ç¡ÇΩÇ≈Ç∑Ç'
					; DATA XREF: seg001:ChTxt_Enemy02o
		db 'ÌÅ`',0
aVavavavavavava	db 'Ç†Ç†Ç†Ç†Ç†Ç†Ç†Ç†ÇÒÅI',0Dh,'ÇÌÅAéÑÅAê¿Ç¡ÇøÇ·Ç¢Ç‹Å`Ç∑ÅI',0Dh,'Ç≥ÇÊÅ[Ç»ÇÁÇ'
					; DATA XREF: seg001:ChTxt_Enemy02o
		db '›Ç»Ç≥Ç‹ÅA',0Dh,'Ç‹ÇΩàßÇ§ì˙Ç‹Ç≈Å`Å`Å`Å`ÅIÅI',0
ChTxt_Enemy03	dw offset aGzgzgzgzgbbiIC; 0 ; DATA XREF: seg001:tListEnemyo
		dw offset a@c0gsgvgegsgvg; 1 ; "ÉzÉzÉzÉzÉbÅI\râÿóÌÇ»ÉÅÉXÇ≥ÇŒÇ´Ç\rÅ@Å@Å@Å"...
		dw offset aURGmgngGuvLXVV; 2
		dw offset aVnvBibiPmcVVnv; 3
		dw offset aVVVBiGag_vNumv; 4
		dw offset aVVVKVvnumvvVVG; 5
		dw offset aVavavavVBibiVB; 6
		dw offset aChatEnm_01_7	; 7
aGzgzgzgzgbbiIC	db 'ÉzÉzÉzÉzÉbÅI',0Dh,'âÿóÌÇ»ÉÅÉXÇ≥ÇŒÇ´Ç',0Dh,'Å@Å@Å@Å@å©ÇπÇƒÇ†Ç∞ÇÈÇÌÅI',0
					; DATA XREF: seg001:ChTxt_Enemy03o
a@c0gsgvgegsgvg	db '@C0ÉsÉVÉÖÉsÉVÉÖÉsÉVÉÖÅI',0Dh,'ÉMÉçÉ`ÉìÉiÅ[ÉXÇÕ',0Dh,'Çwê¸ÉrÅ[ÉÄÇï˙éÀÇµ'
					; DATA XREF: seg001:ChTxt_Enemy03o
		db 'ÇΩÅI',0Dh,'@C7ÉzÉzÉzÅAè¨Ç≥Ç¢ãπÇÀÇ¶ÅIÅI',0
aURGmgngGuvLXVV	db 'ì¡êªÉMÉçÉ`ÉìÇÃã∞ï|Ç',0Dh,'ÇΩÇ¡Ç’ÇËÇ∆ñ°ÇÌÇ¢Ç»Ç≥Ç¢Ç¡ÅI',0Dh,'Å@Å@@C0ÇŒÇ±'
					; DATA XREF: seg001:ChTxt_Enemy03o
		db 'ÇŒÇ±ÇŒÇ±ÇŒÇ±ÅI',0Dh,'Å@Å@Ç⁄Ç±Ç⁄Ç±Ç⁄Ç±Ç⁄Ç±Ç¡ÅIÅI',0
aVnvBibiPmcVVnv	db 'Ç≠Ç¡ÅIÅI',0Dh,'è¨ñ∫ÇÃÇ≠ÇπÇ…',0Dh,'Ç»Ç©Ç»Ç©Ç‚ÇÈÇÌÇÀÇ¡ÅdÅd',0
					; DATA XREF: seg001:ChTxt_Enemy03o
aVVVBiGag_vNumv	db 'Ç”ÇÒÇ¡ÅI',0Dh,'ÉÄÉ_Ç»çUåÇÇÕÇ‚ÇﬂÇƒ',0Dh,'Ç≥Ç¡Ç≥Ç∆Ç†Ç‚Ç‹ÇËÇ»Ç≥Ç¢Ç¡ÅI',0
					; DATA XREF: seg001:ChTxt_Enemy03o
aVVVKVvnumvvVVG	db 'ÇªÇÒÇ»ä√Ç¢çUåÇÇ≈',0Dh,'Ç±ÇÃÉMÉçÉ`ÉìÉiÅ[ÉXólÇ…',0Dh,'É_ÉÅÅ[ÉWÇó^Ç¶ÇÁÇÍÇ'
					; DATA XREF: seg001:ChTxt_Enemy03o
		db 'ÈÇ∆',0Dh,'évÇ¡ÇΩÇÁëÂÉ}É`ÉKÉCÇÊÇ¡ÅIÅI',0
aVavavavVBibiVB	db 'Ç†Ç†Ç†ÇÒÇ¡ÅIÅI',0Dh,'Ç»ÅAÇ»ÇÒÇƒÇ±Ç∆Ç»ÇÃÅdÅd',0Dh,'Ç±ÇÃéÑÇ™ÅdÅd',0Dh,'Ç±ÇÒÇ'
					; DATA XREF: seg001:ChTxt_Enemy03o
		db '»è¨ñ∫Ç…ïâÇØÇÈÇ»ÇÒÇƒÅd',0
off_16BA6	dw offset aVlvsvVVGbGvgvg; 0 ; DATA XREF: seg001:tListEnemyo
		dw offset aPcvGrvVViiVcvV; 1 ; "Ç´Ç·ÇÕÇÕÇÕÉb\rÉÇÉÇÉRÇœÅ`ÇÒÇøÅIÅI\r@C0Ç€Ç©"...
		dw offset aXkoebavVVVavBV; 2
		dw offset aVlvsvvbVBiTVvv; 3
		dw offset aVlvsvvbVBiVavB; 4
		dw offset aVlvsvvbVBiVa_0; 5
		dw offset aVlvsvvvlvsvvbV; 6
		dw offset aChatEnm_01_7	; 7
aVlvsvVVGbGvgvg	db 'Ç´Ç·ÇÕÇÕÇÕÉb',0Dh,'ÉÇÉÇÉRÇœÅ`ÇÒÇøÅIÅI',0Dh,'@C0Ç€Ç©Ç€Ç©Ç€Ç©Ç€Ç©Ç€Ç©ÅIÅI'
					; DATA XREF: seg001:off_16BA6o
		db 0
aPcvGrvVViiVcvV	db 'èóÇÃÉRÇ…ÇµÇ©âÇÁÇ»Ç¢í…Ç›ÅI',0Dh,'îÈãZÅAíEñ—ÉeÅ[ÉvÉbÅIÅI',0Dh,'Å@@C0ÉoÉä'
					; DATA XREF: seg001:off_16BA6o
		db 'ÉoÉäÉyÉäÉyÉäÉbÅIÅI',0
aXkoebavVVVavBV	db 'ïKéEÅAÇ–Ç¡Ç’Ç†ÇΩÅ`Ç¡Ç≠ÅIÅI',0Dh,'Å@@C0Ç⁄ÇÊÅ`ÇÒÅI',0Dh,'Å@Å@Ç⁄ÇÊÇÊÅ`ÇÒÅI'
					; DATA XREF: seg001:off_16BA6o
		db 0Dh,'Å@Å@Å@Ç⁄ÇÒÇÊÇÊÇÊÅ`Å`ÇÒÅIÅI',0
aVlvsvvbVBiTVvv	db 'Ç´Ç·Ç¢Å`ÇÒÅI',0Dh,'í…Ç¢Ç∂Ç·Ç»Ç¢ÉbÅI',0Dh,'Ç‚ÇﬂÇƒÇ≠ÇæÇ≥Å`Ç¢ÉbÅIÅI',0
					; DATA XREF: seg001:off_16BA6o
aVlvsvvbVBiVavB	db 'Ç´Ç·Ç¢Å`ÇÒÅI',0Dh,'Ç†ÇÍÅHÅ@í…Ç≠Ç»Ç¢ÇºÅH',0Dh,'Ç‡ÇµÇ©ÇµÇƒ',0Dh,'ìñÇΩÇÒÇ»Ç©Ç'
					; DATA XREF: seg001:off_16BA6o
		db '¡ÇΩÇÃÇ©Ç»É@ÅH',0
aVlvsvvbVBiVa_0	db 'Ç´Ç·Ç¢Å`ÇÒÅI',0Dh,'Ç†ÇÍÅHÅ@í…Ç≠Ç»Ç¢ÇºÅH',0Dh,'ämÇ©Ç…',0Dh,'ìñÇΩÇ¡ÇΩÇÕÇ∏Ç»Ç'
					; DATA XREF: seg001:off_16BA6o
		db 'ÒÇæÇØÇ«ÉiÅd',0
aVlvsvvvlvsvvbV	db 'Ç´Ç·Ç¢Ç´Ç·Ç¢Å`ÇÒÉbÅIÅI',0Dh,'Ç¶Å`ÇÒÅAÇ¶Å`ÇÒÅdÅd',0Dh,'ÇæÇ©ÇÁÅA',0Dh,'Ç‚ÇæÇ'
					; DATA XREF: seg001:off_16BA6o
		db '¡ÇƒåæÇ¡ÇΩÇÃÇ…ÉBÅdÅd',0
off_16DA2	dw offset aVVavavavavBiGa; 0 ; DATA XREF: seg001:tListEnemyo
		dw offset a@c0vVuvVVVBi@c; 1 ; "ÇΩÇ†Ç†Ç†Ç†Ç¡ÅI\rÉAÉXÉJÉXÉyÉVÉÉÉã\rååä«éaÇ"...
		dw offset aCUyvVVtvVCbvav; 2
		dw offset aGGbbiVVVVVVVVn; 3
		dw offset aVVVBdbdGigbggv; 4
		dw offset aVVVVBdbdVVVNum; 5
		dw offset aVnvnvnvBdbdVBa; 6
		dw offset aChatEnm_01_7	; 7
aVVavavavavBiGa	db 'ÇΩÇ†Ç†Ç†Ç†Ç¡ÅI',0Dh,'ÉAÉXÉJÉXÉyÉVÉÉÉã',0Dh,'ååä«éaÇËóÙÇ≠îjìÆñ¨åùÅIÅI',0
					; DATA XREF: seg001:off_16DA2o
a@c0vVuvVVVBi@c	db '@C0ÇµÇ„ÇœÇœÇœÇœÅI',0Dh,'@C7ååÇÃãCÇ‡ìÄÇÈ',0Dh,'ïXÇÃÇ§óêÇÍë≈ÇøÇ¡ÅIÅI',0
					; DATA XREF: seg001:off_16DA2o
aCUyvVVtvVCbvav	db 'ñªìyÇÃÇ›Ç‚Ç∞Ç…ñ°ÇÌÇ¢Ç»Ç¡ÅI',0Dh,'ÉAÉXÉJÉXÅ[ÉpÅ[ÉXÉyÉVÉÉÉã',0Dh,'Å@ÉàÅ[É'
					; DATA XREF: seg001:off_16DA2o
		db 'àÅ[ínçñé‘Ç¡ÅIÅI',0
aGGbbiVVVVVVVVn	db 'É`ÉbÅI',0Dh,'Ç»ÇﬂÇΩÇ‹ÇÀ',0Dh,'ÇµÇƒÇ≠ÇÍÇÈÇ∂Ç·ÇÀÇ¶Ç©ÅIÅI',0
					; DATA XREF: seg001:off_16DA2o
aVVVBdbdGigbggv	db 'Ç”Ç”Ç¡ÅdÅd',0Dh,'ÉIÉÅÉGÇÃçUåÇÇ»ÇÒÇ¥Ç†',0Dh,'Ç∑Ç¡Ç©ÇËÇ®å©í ÇµÇæÇ∫Ç¡ÅI',0
					; DATA XREF: seg001:off_16DA2o
aVVVVBdbdVVVNum	db 'Ç÷Ç÷Ç÷Ç¡ÅdÅd',0Dh,'ÇªÇÒÇ»çUåÇ',0Dh,'â·Ç…éhÇ≥ÇÍÇΩíˆÇ‡',0Dh,'Å@Å@Å@Å@ä¥Ç∂ÇÀÇ'
					; DATA XREF: seg001:off_16DA2o
		db '¶Ç∫ÅIÅI',0
aVnvnvnvBdbdVBa	db 'Ç≠Ç≠Ç≠Ç¡ÅdÅd',0Dh,'Ç‹ÅAïâÇØÇΩÇ∫ÅdÅd',0Dh,'ìdåÇÉiÅ[ÉXÅdÅd',0Dh,'ÉIÉÅÉGÇÃñºÇ'
					; DATA XREF: seg001:off_16DA2o
		db 'ÕñYÇÍÇÀÇ¶ÅdÅd',0
off_16F57	dw offset aPcvIgvsvVOqcbv; 0 ; DATA XREF: seg001:tListEnemyo
		dw offset aVioovVsvVVivVi; 1 ; "èóÇâ£ÇÈÇÃÇÕéÔñ°Ç∂Ç·ÇÀÇ¶Ç™\rÇ±ÇÍÇ‡ÉrÉWÉl"...
		dw offset aVVxvdvkvVjvVab; 2
		dw offset aTVebib@tVBib@t; 3
		dw offset aVVBdbdVtvVVlvB; 4
		dw offset aIIdvvkMXwvVVVV; 5
		dw offset aVBavVVVBVVsvBh; 6
		dw offset aIlvvvBdbdIVGGq; 7
aPcvIgvsvVOqcbv	db 'èóÇâ£ÇÈÇÃÇÕéÔñ°Ç∂Ç·ÇÀÇ¶Ç™',0Dh,'Ç±ÇÍÇ‡ÉrÉWÉlÉXÇæ',0Dh,'Å@ä®ïŸÇµÇÎÇÊ',0Dh,'Å'
					; DATA XREF: seg001:off_16F57o
		db '@Å@@C0Ç⁄Ç©Ç⁄Ç©Ç⁄Ç©Ç⁄Ç©ÅIÅI',0
aVioovVsvVVivVi	db 'Ç®éoÇøÇ·ÇÒ',0Dh,'Ç»Ç©Ç»Ç©ÅAÇ¢Ç¢ÉPÉcÇµÇƒÇÈÇ»',0Dh,'Å@@C0Ç≥ÇÌÇ≥ÇÌÇ≥ÇÌÇ≥ÇÌ'
					; DATA XREF: seg001:off_16F57o
		db 'ÅIÅI',0
aVVxvdvkvVjvVab	db 'ÇµÇÂÇ§Ç™ÇÀÇ¶Ç»Ç†ÅdÅd',0Dh,'Å@Ç±ÇÍÇ≈Ç‡ãÚÇÁÇ¢Ç»',0Dh,'Å@Å@Å@ïSóÙÉAÉCÉXÅIÅ'
					; DATA XREF: seg001:off_16F57o
		db 'I',0
aTVebib@tVBib@t	db 'í…Ç•ÅIÅ@í…Ç¡ÅIÅ@í…Ç°Ç¡ÅIÅI',0Dh,'ÉeÉÅÉGÅA',0Dh,'Ç†ÇÒÇ‹ÇËâ¥Çì{ÇÁÇ∑Ç»ÇÊÅ'
					; DATA XREF: seg001:off_16F57o
		db 'IÅI',0
aVVBdbdVtvVVlvB	db 'Ç”Ç¡ÅdÅd',0Dh,'Ç‚ÇﬂÇ∆Ç´Ç»ÅdÅd',0Dh,'èóÇ…ÇÕåïÇÊÇËÇ‡',0Dh,'ÉoÉâÇÃâ‘Ç™éóçáÇ§Ç'
					; DATA XREF: seg001:off_16F57o
		db '¡ÇƒÇ‡ÇÒÇ≥',0
aIIdvvkMXwvVVVV	db 'â¬à§Ç¢ä≈åÏïwÇ≥ÇÒ',0Dh,'ÇªÇÒÇ»çUåÇÇ∂Ç·íéÇØÇÁÇÃàÍïC',0Dh,'ÇæÇ¡ÇƒéEÇπÇ‚ÇµÇ'
					; DATA XREF: seg001:off_16F57o
		db 'ÀÇ¶Ç∫ÅI',0
aVBavVVVBVVsvBh	db 'Ç»ÅAÇ»ÇÒÇ≈Ç±Å`Ç»ÇÈÇÃÅHÅI',0Dh,'Ç®ÇÎÇÎÇÒÅdÅdÇ®ÇÎÇÎÇÒÅdÅd',0Dh,'Å@ÉoÉCÉoÉ'
					; DATA XREF: seg001:off_16F57o
		db 'CÉLÅ`ÉìÅIÅI',0
aIlvvvBdbdIVGGq	db 'à´Ç¢Ç»ÅdÅd',0Dh,'â¥ÇÕÉ}ÉqÉçÉzÉãÉÄíÜì≈Çæ',0Dh,'ÇøÇÂÇ¡Ç∆Ç‚ÇªÇ¡Ç∆Ç∂Ç·',0Dh,'å'
					; DATA XREF: seg001:off_16F57o
		db '¯Ç´ÇﬂÇÕÇÀÇ¶Ç∫ÅB',0
off_1718C	dw offset aGwggglgbggnsvl; 0 ; DATA XREF: seg001:tListEnemyo
		dw offset aVVVVVdvivVcbhN; 1 ; "ÉWÉÉÉlÉbÉgçsÇ´Ç‹Å`Ç∑ÅI\rà…âÍîEñ@Å@\rÅ@ÉAÉ"...
		dw offset aGngcgegnlzppvM; 2
		dw offset aVavVqbVBiVBavV; 3
		dw offset aVVxvvvVxvvvBiV; 4
		dw offset aVavcvqbhVBVVVX; 5
		dw offset aVavVavavVVBibi; 6
		dw offset aChatEnm_01_7	; 7
aGwggglgbggnsvl	db 'ÉWÉÉÉlÉbÉgçsÇ´Ç‹Å`Ç∑ÅI',0Dh,'à…âÍîEñ@Å@',0Dh,'Å@ÉAÉXÉgÉçó¨êØÉ{ÉìÉoÅ[ÅI',0Dh
					; DATA XREF: seg001:off_1718Co
		db 'Ç†Ç∑Ç∆ÇÎÅ`Å`Å`Å`Å`ÇÒÇ¡ÅIÅI',0
aVVVVVdvivVcbhN	db 'Ç±ÇÍÇÕÇ«Ç§Ç©ÇµÇÁÅH',0Dh,'çbâÍîEñ@',0Dh,'Å@èóéEèŒínçñÇÃèpÅI',0Dh,'Ç±ÇøÇÂÇ±Ç'
					; DATA XREF: seg001:off_1718Co
		db 'øÇÂÇ±ÇøÇÂÇ±ÇøÇÂÅI',0
aGngcgegnlzppvM	db 'ÉnÉCÉeÉNãZèpÇÃåãèª',0Dh,'ÇmÇ`ÇrÇ`Ç™äJî≠ÇµÇΩ',0Dh,'Ç`ÇhêŒìäÇ∞É}ÉVÅ[ÉìÇ',0Dh
					; DATA XREF: seg001:off_1718Co
		db 'ééÇ≥ÇπÇƒÇ‡ÇÁÇ§ÇÌÇÀÇ¡ÅIÅI',0
aVavVqbVBiVBavV	db 'Ç†ÇÕÇüÅ`ÇÒÅI',0Dh,'Ç±ÅAÇ±ÇÃí…Ç›Ç™éÑÇ',0Dh,'ÉCÉPÉiÉCê¢äEÇ…',0Dh,'Å@Å@Å@óUÇ'
					; DATA XREF: seg001:off_1718Co
		db '¡ÇƒÇµÇ‹Ç§ÇÃÇÀÅdÅd',0
aVVxvvvVxvvvBiV	db 'Ç–ÇÂÇ¢Ç–ÇÂÇ¢Ç¡ÅI',0Dh,'Ç‚Ç¡ÇΩÇüÅ`ÅIÅI',0Dh,'éÑÇ¡ÇƒÇŒëfëÅÅ`Ç¢ÅIÅI',0
					; DATA XREF: seg001:off_1718Co
aVavcvqbhVBVVVX	db 'Ç†ÇÁÇüÅH',0Dh,'Ç∫Å`ÇÒÇ∫ÇÒïΩãCÇ¡ÅI',0Dh,'éÑÇ¡ÇƒÇŒã≠ÇßÅ`Ç¢ÅIÅI',0
					; DATA XREF: seg001:off_1718Co
aVavVavavVVBibi	db 'Ç†ÇÒÇ†Ç†ÇÒÇÒÇ¡ÅIÅI',0Dh,'Ç‡Ç§Ç‚ÇæÇ¡ÅI',0Dh,'éÑÉAÉÅÉäÉJÇ…ãAÇÈÇ¡ÅIÅI',0Dh,'Ç'
					; DATA XREF: seg001:off_1718Co
		db '§Ç¶Å`ÇÒÅAÇ§Ç¶Å`ÇÒÅdÅd',0
off_1738E	dw offset aSGngmlromgmmmg; 0 ; DATA XREF: seg001:tListEnemyo
		dw offset a@c0gogrbGubiGo; 1 ; "ëΩÉNÉmãRémÉmååÉíãzÉbÉ^\réÙÉèÉåÉ^ñÇåïÉí\ré"...
		dw offset a@c0glgkglgkglg; 2
		dw offset aGogbbdbdGigjgi; 3
		dw offset aUcgGigigjgbgGi; 4
		dw offset aVnvgbigtgxgksx; 5
		dw offset aGogtgegbbdbdGe; 6
		dw offset aChatEnm_01_7	; 7
aSGngmlromgmmmg	db 'ëΩÉNÉmãRémÉmååÉíãzÉbÉ^',0Dh,'éÙÉèÉåÉ^ñÇåïÉí',0Dh,'éÛÉPÉeÉ~ÉiÉTÅ[ÉCÅIÅI',0
					; DATA XREF: seg001:off_1738Eo
a@c0gogrbGubiGo	db '@C0ÉoÉRÅ[ÉìÅI',0Dh,'ÉOÉäÉOÉäÉOÉäÉOÉäÅI',0Dh,'@C7éÑÉjÉnÉÄÉJÉEÅ@ÉIÉçÉJÉiè'
					; DATA XREF: seg001:off_1738Eo
		db 'ó',0Dh,'èóâ§ólÉmåCÉíÉIÉiÉÅÉbÅIÅI',0
a@c0glgkglgkglg	db '@C0ÉLÉäÉLÉäÉLÉäÉLÉäÅdÅd',0Dh,'@C7éOñ°ê¸ÉXÉgÉäÉìÉOÉn',0Dh,'ëÂïœÉàÉNí˜ÉäÉ'
					; DATA XREF: seg001:off_1738Eo
		db '}Å`ÉXÅI',0Dh,'ÉAÉiÉ^ååçsà´ÉNÉiÉäÉ}Å`ÉXÅI',0
aGogbbdbdGigjgi	db 'ÉOÉbÅdÅd',0Dh,'ÉiÉJÉiÉJÉÑÉãÉWÉÉÉiÉCÅdÅd',0Dh,'É\ÉEÉfÉiÉNÉbÉ`ÉÉ',0Dh,'ÉCÉWÉ'
					; DATA XREF: seg001:off_1738Eo
		db 'ÅÉKÉCÉKÉiÉCÉèÅdÅd',0
aUcgGigigjgbgGi	db 'ìñÉ^ÉâÉiÉJÉbÉ^ÉàÉEÉl',0Dh,'ÉfÉÇÅAÉAÉiÉ^ÉnÉ}É_é·ÉCÉè',0Dh,'É\ÉìÉiÉRÉgÉf',0Dh
					; DATA XREF: seg001:off_1738Eo
		db 'ÉNÉWÉPÉ`ÉÉÉCÉPÉiÉCÉèÅIÅI',0
aVnvgbigtgxgksx	db 'ÇnÇgÅIÉTÉXÉKëÂòaïèéq',0Dh,'ÉcÉcÉVÉ~ê[ÉCÉfÅ[ÉXÅI',0Dh,'ÉfÉÇÅA',0Dh,'êÌÉCÉjè'
					; DATA XREF: seg001:off_1738Eo
		db 'ÓÉPÉnã÷ï®ÉfÅ`ÉXÅI',0
aGogtgegbbdbdGe	db 'ÉOÉtÉEÉbÅdÅd',0Dh,'ÉeÅAìGÉiÉKÉâìVê∞É_ÉèÅdÅd',0Dh,'ÉfÅAÉfÉÇÅdÅd',0Dh,'ãRémì'
					; DATA XREF: seg001:off_1738Eo
		db 'πê∏ê_ÉnâiâìÉàÅdÅd',0
off_175BF	dw offset aNsvVnvavcghbiR; 0 ; DATA XREF: seg001:tListEnemyo
		dw offset aVavVBVGdguglbC; 1 ; "çsÇ¡Ç≠ÇÌÇÊÉHÅI\rê¬Ç¢ïóÇ…óUÇÌÇÍÇƒ\rÉJÉäÉtÉ"...
		dw offset a@c0grgvgegvgeg; 2
		dw offset aGpghgdbiTVjvVs; 3
		dw offset aVVcvsvBibiVVdb; 4
		dw offset aVavVivVBBiTVnv; 5
		dw offset aVlvsvavavavava; 6
		dw offset aChatEnm_01_7	; 7
aNsvVnvavcghbiR	db 'çsÇ¡Ç≠ÇÌÇÊÉHÅI',0Dh,'ê¬Ç¢ïóÇ…óUÇÌÇÍÇƒ',0Dh,'ÉJÉäÉtÉHÉãÉjÉAÉNÉâÅ`ÉVÉÖÅI',0
					; DATA XREF: seg001:off_175BFo
aVavVBVGdguglbC	db 'Ç†Ç¡ÇÕÅ`ÇÒ',0Dh,'ÉÑÉìÉLÅ[ñ∫ÇÃÉhç™ê´ÅI',0Dh,'Å@ëÂãêì˚íÇëßñ„ê‚å≈ÇﬂÅIÅI',0
					; DATA XREF: seg001:off_175BFo
a@c0grgvgegvgeg	db '@C0ÉrÉVÉÖÉVÉÖÉVÉÖÉbÅIÅI',0Dh,'@C7ÉKÉâÉKÉâé÷ÇÃì≈ÇìhÇËÇ±ÇÒÇæ',0Dh,'ÉJÉìÉ'
					; DATA XREF: seg001:off_175BFo
		db 'UÉVÇÃéaÇÍñ°ÇÕÇ¢Ç©Ç™ÅH',0
aGpghgdbiTVjvVs	db 'ÉèÉHÉDÅI',0Dh,'í…Ç¶Ç∂Ç·ÇÀÅ`Ç©ÉbÅI',0Dh,'Ç‡Å`Ç§ì{Ç¡ÇΩÇºÉHÅIÅI',0
					; DATA XREF: seg001:off_175BFo
aVVcvsvBibiVVdb	db 'Ç–ÇÁÇËÇÒÅIÅI',0Dh,'Ç«Ç§ÅH',0Dh,'Ç»Ç©Ç»Ç©ëfëÅÇ¢Ç≈ÇµÇÂÅH',0
					; DATA XREF: seg001:off_175BFo
aVavVivVBBiTVnv	db 'Ç†Ç¡Ç©ÇÒÇ◊Å`ÅI',0Dh,'í…Ç≠Ç‡Ç©Ç‰Ç≠Ç‡',0Dh,'âΩÇ∆Ç‡Ç»Ç¢ÇÊÅ`ÇæÉbÅIÅI',0
					; DATA XREF: seg001:off_175BFo
aVlvsvavavavava	db 'Ç´Ç·Ç†Ç†Ç†Ç†Ç†Ç†ÅIÅI',0Dh,'Ç±ÇÒÇ»ÇÕÇ∏Ç∂Ç·',0Dh,'Å@Å@Å@Ç»Ç©Ç¡ÇΩÇÃÇ…ÉBÅIÅ'
					; DATA XREF: seg001:off_175BFo
		db 'I',0Dh,'ÇµÇ≠ÇµÇ≠ÇµÇ≠ÇµÇ≠ÇµÇ≠ÅdÅd',0
off_1777B	dw offset aVVVBdbdcdubsRV; 0 ; DATA XREF: seg001:tListEnemyo
		dw offset aVVdvsvsvVVVBiU; 1 ; "Ç”Ç”Ç”ÅdÅdódìÅë∫ê≥Ç™\rç°è™Ç‡ååÇãzÇ¢ÇΩÇ™"...
		dw offset aCSkosvVVLzvMfc; 2
		dw offset aVovavavqvBiVVx; 3
		dw offset a@c0vVavavavavB; 4
		dw offset aVVavVVVVVBiVVV; 5
		dw offset aVovjvevBiVmvsv; 6
		dw offset aVnvOVBiIVVVMVX; 7
aVVVBdbdcdubsRV	db 'Ç”Ç”Ç”ÅdÅdódìÅë∫ê≥Ç™',0Dh,'ç°è™Ç‡ååÇãzÇ¢ÇΩÇ™Ç¡ÇƒÇ®ÇÈ',0Dh,'Å@â‘ñˆó†êÁâ'
					; DATA XREF: seg001:off_1777Bo
		db '∆ïKéEåïÅI',0Dh,'Å@Å@îÈåïÇ†Ç–ÇÈÇÃïëÅIÅI',0
aVVdvsvsvVVVBiU	db 'ÇŸÇ§ÇËÇ·ÇŸÇÍÇŸÇÍÅI',0Dh,'ì˙ñ{ÇÃçëãZÇÕëÂëäñoÅI',0Dh,'Ç™Ç‘ÇËäÒÇËÇ≈Ç≤Ç¥Å`Ç'
					; DATA XREF: seg001:off_1777Bo
		db 'ÈÅIÅI',0
aCSkosvVVLzvMfc	db 'ñ∫ëäéËÇ…',0Dh,'Ç±ÇÃãZÇÕå‰ñ@ìxÇ∂Ç·Ç™ÅdÅd',0Dh,'Ç‚ÇÈÇ≈Ç≤Ç¥ÇÈÇÊÅI',0Dh,'Å@ódè'
					; DATA XREF: seg001:off_1777Bo
		db 'pÉâÉxÉìÉ_Å[ÇÃçÅÇËÅIÅI',0
aVovavavqvBiVVx	db 'ÇÆÇÌÇÌÇüÇ¡ÅI',0Dh,'ÇøÇÂÇ±Ç¥Ç¢Ç»è¨ñ∫ÇﬂÅdÅd',0Dh,'Ç»Ç©Ç»Ç©Ç‚ÇÈÇ≈Ç≤Ç¥ÇÈÇ»Å'
					; DATA XREF: seg001:off_1777Bo
		db 'dÅd',0
a@c0vVavavavavB	db 0Dh,'@C0Ç⁄ÇÌÇÌÇÌÇÌÇÒÅI',0Dh,'@C7Ç”Ç”Ç”ÅdÅd',0Dh,'Å@ódèpïßídï‘ÇµÅI',0
					; DATA XREF: seg001:off_1777Bo
aVVavVVVVVBiVVV	db 'Ç«ÇÌÇ¡ÇÕÇ¡ÇÕÇ¡ÇÕÅI',0Dh,'ÇªÇÒÇ»çUåÇÇ≈êŸé“Çì|ÇªÇ§',0Dh,'Ç∆ÇÕÅAÇ©ÇΩÇÕÇÁí'
					; DATA XREF: seg001:off_1777Bo
		db '…Ç¢ÇÌÅIÅI',0Dh,'Ç©Å`Ç¡Ç©Ç¡Ç©Ç¡Ç©ÅIÅI',0
aVovjvevBiVmvsv	db 'ÇÆÇ¶Ç•Ç¡ÅI',0Dh,'Ç¨Ç·Ç–Ç¢Ç°Ç°ÇÒÅIÅI',0Dh,'Ç«ÇÌÇÌÇÌÇÌÇüÇüÇüÅdÅd',0Dh,'ÇﬁÅAñ'
					; DATA XREF: seg001:off_1777Bo
		db '≥îOÇ∂Ç·ÅdÅd',0
aVnvOVBiIVVVMVX	db 'Ç≠Çπé“ÇﬂÅI',0Dh,'âˆÇµÇ∞Ç»åıÇï˙ÇøÇ®Ç¡ÇƒÅI',0Dh,'ódìÅë∫ê≥Ç≈',0Dh,'ÇÕÇ∂Ç´îÚÇ'
					; DATA XREF: seg001:off_1777Bo
		db 'ŒÇµÇƒÇ≠ÇÍÇÈÇÌÅIÅI',0
off_179CF	dw offset a@c0gugpgegegdg; 0 ; DATA XREF: seg001:tListEnemyo
		dw offset unk_17A39	; 1 ; "@C0ÉuÉèÉEÉEÉDÉDÉDÉìÅI\r@C7ÉpÉèÅ[ÇÃà·Ç¢Ç"...
		dw offset aGlgegcgcgcgcgc; 2
		dw offset unk_17AB8	; 3
		dw offset aGogjvVjbiISmkM; 4
		dw offset aMgvVvgmbGxvTbv; 5
		dw offset unk_17BA1	; 6
		dw offset aChatEnm_01_7	; 7
a@c0gugpgegegdg	db '@C0ÉuÉèÉEÉEÉDÉDÉDÉìÅI',0Dh,'@C7ÉpÉèÅ[ÇÃà·Ç¢Ç',0Dh,'Å@évÇ¢ímÇÁÇπÇƒÇ†Ç∞Ç'
					; DATA XREF: seg001:off_179CFo
		db 'ÈÇÌÅI',0Dh,'Å@Å@ÇuÇPÇQÉpÉèÅ[É{ÉÄÅIÅI',0
unk_17A39	db  40h	; @		; DATA XREF: seg001:off_179CFo
		db  43h	; C
		db  30h	; 0
		db  10h
		db  82h	; Ç
		db 0CDh	; Õ
		db  0Dh
		db  11h
		db  82h	; Ç
		db 0CCh	; Ã
		db  0Dh
		db  95h	; ï
		db  40h	; @
		db  82h	; Ç
		db 0C9h	; …
		db  82h	; Ç
		db 0A8h	; ®
		db  90h	; ê
		db  4Bh	; K
		db  82h	; Ç
		db 0F0h	; 
		db  82h	; Ç
		db 0D4h	; ‘
		db  82h	; Ç
		db 0C2h	; ¬
		db  82h	; Ç
		db 0AFh	; Ø
		db  82h	; Ç
		db 0BDh	; Ω
		db  81h	; Å
		db  49h	; I
		db  0Dh
		db  40h	; @
		db  43h	; C
		db  37h	; 7
		db  83h	; É
		db  65h	; e
		db  81h	; Å
		db  5Bh	; [
		db  83h	; É
		db  8Bh	; ã
		db  83h	; É
		db  67h	; g
		db  83h	; É
		db  44h	; D
		db  83h	; É
		db  6Dh	; m
		db  81h	; Å
		db  5Bh	; [
		db  83h	; É
		db  59h	; Y
		db  83h	; É
		db  41h	; A
		db  83h	; É
		db  5Eh	; ^
		db  83h	; É
		db  62h	; b
		db  83h	; É
		db  4Eh	; N
		db  81h	; Å
		db  49h	; I
		db    0
aGlgegcgcgcgcgc	db 'ÉLÉÖÉCÉCÉCÉCÉCÉCÉìÅIÅI',0Dh,'ÉAÉNÉZÉãëSäJÅI',0Dh,'âπë¨ëÃä¥ÉGÉLÉ]ÉXÉgÉqÅ'
					; DATA XREF: seg001:off_179CFo
		db '[ÉgÅI',0
unk_17AB8	db  82h	; Ç		; DATA XREF: seg001:off_179CFo
		db 0D3h	; ”
		db  82h	; Ç
		db 0F1h	; Ò
		db  82h	; Ç
		db 0C1h	; ¡
		db  81h	; Å
		db  49h	; I
		db  0Dh
		db  82h	; Ç
		db 0DCh	; ‹
		db  82h	; Ç
		db 0AEh	; Æ
		db  82h	; Ç
		db 0EAh	; Í
		db  93h	; ì
		db  96h	; ñ
		db  82h	; Ç
		db 0E8h	; Ë
		db  82h	; Ç
		db 0C5h	; ≈
		db  83h	; É
		db  77h	; w
		db  83h	; É
		db  89h	; â
		db  83h	; É
		db  77h	; w
		db  83h	; É
		db  89h	; â
		db  0Dh
		db  8Ah	; ä
		db 0ECh	; Ï
		db  82h	; Ç
		db 0F1h	; Ò
		db  82h	; Ç
		db 0C5h	; ≈
		db  82h	; Ç
		db 0E9h	; È
		db  82h	; Ç
		db 0F1h	; Ò
		db  82h	; Ç
		db 0B6h	; ∂
		db  82h	; Ç
		db 0E1h	; ·
		db  82h	; Ç
		db 0C8h	; »
		db  82h	; Ç
		db 0A2h	; ¢
		db  82h	; Ç
		db 0EDh	; Ì
		db  82h	; Ç
		db 0E6h	; Ê
		db  81h	; Å
		db  64h	; d
		db  81h	; Å
		db  64h	; d
		db    0
aGogjvVjbiISmkM	db 'ÉoÉJÇÀÇ¶ÅI',0Dh,'âπë¨ä≈åÏïwÇÃéÑÇ…Ç†Ç»ÇΩÇÃ',0Dh,'ÉmÉçÉ}Ç»çUåÇÇ™',0Dh,'ìñÇΩÇ'
					; DATA XREF: seg001:off_179CFo
		db 'ÈÇÌÇØÇ»Ç¢Ç≈ÇµÇÂÅI',0
aMgvVvgmbGxvTbv	db 'åÉÇµÇ¢ÉåÅ[ÉXÇ≈íbÇ¶ÇΩéÑÇ…',0Dh,'Ç†Ç»ÇΩÇÃÉwÉiÉ`ÉáÉRçUåÇÇ™',0Dh,'í ópÇ∑ÇÈÇ'
					; DATA XREF: seg001:off_179CFo
		db 'ÌÇØÇ»Ç¢Ç≈ÇµÇÂÅI',0Dh,'Ç†Ç´ÇÁÇﬂÇƒìcé…Ç…ãAÇËÇ»Ç≥Ç¢',0
unk_17BA1	db  82h	; Ç		; DATA XREF: seg001:off_179CFo
		db 0A0h	; †
		db  82h	; Ç
		db 0A0h	; †
		db  82h	; Ç
		db 0A0h	; †
		db  82h	; Ç
		db 0F1h	; Ò
		db  82h	; Ç
		db 0F1h	; Ò
		db  82h	; Ç
		db 0F1h	; Ò
		db  82h	; Ç
		db 0C1h	; ¡
		db  81h	; Å
		db  64h	; d
		db  81h	; Å
		db  64h	; d
		db  0Dh
		db  8Eh	; é
		db  84h	; Ñ
		db  82h	; Ç
		db 0CCh	; Ã
		db  82h	; Ç
		db 0B9h	; π
		db  82h	; Ç
		db 0A2h	; ¢
		db  82h	; Ç
		db 0B6h	; ∂
		db  82h	; Ç
		db 0E1h	; ·
		db  82h	; Ç
		db 0C8h	; »
		db  82h	; Ç
		db 0A2h	; ¢
		db  81h	; Å
		db  64h	; d
		db  81h	; Å
		db  64h	; d
		db  0Dh
		db  83h	; É
		db  81h	; Å
		db  83h	; É
		db  4Ah	; J
		db  83h	; É
		db  6Ah	; j
		db  83h	; É
		db  62h	; b
		db  83h	; É
		db  4Eh	; N
		db  82h	; Ç
		db 0CCh	; Ã
		db  83h	; É
		db  7Eh	; ~
		db  83h	; É
		db  58h	; X
		db  82h	; Ç
		db 0E6h	; Ê
		db  81h	; Å
		db  64h	; d
		db  81h	; Å
		db  64h	; d
		db  0Dh
		db  8Eh	; é
		db  84h	; Ñ
		db  82h	; Ç
		db 0AAh	; ™
		db  95h	; ï
		db  89h	; â
		db  82h	; Ç
		db 0AFh	; Ø
		db  82h	; Ç
		db 0E9h	; È
		db  82h	; Ç
		db 0EDh	; Ì
		db  82h	; Ç
		db 0AFh	; Ø
		db  82h	; Ç
		db 0AAh	; ™
		db  82h	; Ç
		db 0C8h	; »
		db  82h	; Ç
		db 0A2h	; ¢
		db  81h	; Å
		db  64h	; d
		db  81h	; Å
		db  64h	; d
		db    0
off_17BF9	dw offset a@c0gugbgugbgug; 0 ; DATA XREF: seg001:tListEnemyo
		dw offset unk_17C4E	; 1 ; "@C0ÉuÉBÉuÉBÉuÉBÉCÉCÉìÅI\r@C7ÉnÉCÉeÉNÇÃóí"...
		dw offset aVjvjvvgbbiSCPq; 2
		dw offset unk_17CC0	; 3
		dw offset aVlvsvavVVVVBiU; 4
		dw offset unk_17D5F	; 5
		dw offset unk_17DA0	; 6
		dw offset aChatEnm_01_7	; 7
a@c0gugbgugbgug	db '@C0ÉuÉBÉuÉBÉuÉBÉCÉCÉìÅI',0Dh,'@C7ÉnÉCÉeÉNÇÃóíÅI',0Dh,'ÉAÉNÉeÉBÉuÉTÉXÉoÉ'
					; DATA XREF: seg001:off_17BF9o
		db 'XÉ^Å[ÅIÅI',0
unk_17C4E	db  92h	; í		; DATA XREF: seg001:off_17BF9o
		db  4Eh	; N
		db  82h	; Ç
		db 0E0h	; ‡
		db  82h	; Ç
		db 0BBh	; ª
		db  82h	; Ç
		db 0CCh	; Ã
		db  8Eh	; é
		db 0C0h	; ¿
		db  91h	; ë
		db 0CCh	; Ã
		db  82h	; Ç
		db 0AAh	; ™
		db  89h	; â
		db 0F0h	; 
		db  82h	; Ç
		db 0E7h	; Á
		db  82h	; Ç
		db 0C8h	; »
		db  82h	; Ç
		db 0A2h	; ¢
		db  81h	; Å
		db  64h	; d
		db  81h	; Å
		db  64h	; d
		db  0Dh
		db  8Ch	; å
		db 0B6h	; ∂
		db  82h	; Ç
		db 0CCh	; Ã
		db  94h	; î
		db 0E9h	; È
		db  8Bh	; ã
		db  5Ah	; Z
		db  81h	; Å
		db  49h	; I
		db  0Dh
		db  81h	; Å
		db  40h	; @
		db  81h	; Å
		db  40h	; @
		db  8Fh	; è
		db  63h	; c
		db  97h	; ó
		db 0F1h	; Ò
		db  92h	; í
		db  8Dh	; ç
		db  8Eh	; é
		db 0CBh	; À
		db  81h	; Å
		db  49h	; I
		db  81h	; Å
		db  49h	; I
		db    0
aVjvjvvgbbiSCPq	db 'Ç¶Ç¶Ç¢ÉbÅI',0Dh,'ëÃóÕèüïâÇÕïâÇØÇ»Ç¢ÇÌÇÊÉb',0Dh,'Å@ÇpÉ^ÉCÉÑÇPÇOÇOòAî≠ÅI',0
					; DATA XREF: seg001:off_17BF9o
unk_17CC0	db  82h	; Ç		; DATA XREF: seg001:off_17BF9o
		db 0D3h	; ”
		db  82h	; Ç
		db 0F1h	; Ò
		db  82h	; Ç
		db 0ACh	; ¨
		db  82h	; Ç
		db 0E1h	; ·
		db  81h	; Å
		db  60h	; `
		db  81h	; Å
		db  49h	; I
		db  81h	; Å
		db  49h	; I
		db  0Dh
		db  82h	; Ç
		db 0AEh	; Æ
		db  82h	; Ç
		db 0C1h	; ¡
		db  82h	; Ç
		db 0B7h	; ∑
		db  82h	; Ç
		db 0F1h	; Ò
		db  81h	; Å
		db  64h	; d
		db  8Bh	; ã
		db  83h	; É
		db  82h	; Ç
		db 0A9h	; ©
		db  82h	; Ç
		db 0C8h	; »
		db  82h	; Ç
		db 0A2h	; ¢
		db  82h	; Ç
		db 0EDh	; Ì
		db  83h	; É
		db  88h	; à
		db  81h	; Å
		db  64h	; d
		db  81h	; Å
		db  64h	; d
		db  0Dh
		db  94h	; î
		db 0DFh	; ﬂ
		db  82h	; Ç
		db 0B5h	; µ
		db  82h	; Ç
		db 0ADh	; ≠
		db  82h	; Ç
		db 0BDh	; Ω
		db  82h	; Ç
		db 0C1h	; ¡
		db  82h	; Ç
		db 0C4h	; ƒ
		db  81h	; Å
		db  41h	; A
		db  8Bh	; ã
		db 0EAh	; Í
		db  82h	; Ç
		db 0B5h	; µ
		db  82h	; Ç
		db 0ADh	; ≠
		db  82h	; Ç
		db 0BDh	; Ω
		db  82h	; Ç
		db 0C1h	; ¡
		db  82h	; Ç
		db 0C4h	; ƒ
		db  0Dh
		db  83h	; É
		db  54h	; T
		db  81h	; Å
		db  5Bh	; [
		db  83h	; É
		db  4Ch	; L
		db  83h	; É
		db  62h	; b
		db  83h	; É
		db  67h	; g
		db  82h	; Ç
		db 0C5h	; ≈
		db  82h	; Ç
		db 0CDh	; Õ
		db  95h	; ï
		db 0BDh	; Ω
		db  8Bh	; ã
		db  43h	; C
		db  82h	; Ç
		db 0C8h	; »
		db  82h	; Ç
		db 0CCh	; Ã
		db  81h	; Å
		db  49h	; I
		db    0
aVlvsvavVVVVBiU	db 'Ç´Ç·Ç†ÇÕÇ¡ÇÕÇ¡ÇÕÅI',0Dh,'ìñÇΩÇÁÇ»Ç¢ÇÊÉHÅ`ÇæÅI',0Dh,'Ç®êKÉyÉìÉyÉìÉUÉ}Å[É'
					; DATA XREF: seg001:off_17BF9o
		db '~ÉçÅI',0
unk_17D5F	db  92h	; í		; DATA XREF: seg001:off_17BF9o
		db 0C9h	; …
		db  82h	; Ç
		db 0A2h	; ¢
		db  82h	; Ç
		db 0CCh	; Ã
		db  92h	; í
		db 0C9h	; …
		db  82h	; Ç
		db 0A2h	; ¢
		db  82h	; Ç
		db 0CCh	; Ã
		db  94h	; î
		db 0F2h	; Ú
		db  82h	; Ç
		db 0F1h	; Ò
		db  82h	; Ç
		db 0C5h	; ≈
		db  82h	; Ç
		db 0A2h	; ¢
		db  82h	; Ç
		db 0AFh	; Ø
		db  81h	; Å
		db  60h	; `
		db  81h	; Å
		db  49h	; I
		db  0Dh
		db  82h	; Ç
		db 0A6h	; ¶
		db  82h	; Ç
		db 0C1h	; ¡
		db  82h	; Ç
		db 0D6h	; ÷
		db  82h	; Ç
		db 0C1h	; ¡
		db  82h	; Ç
		db 0D6h	; ÷
		db  81h	; Å
		db  64h	; d
		db  81h	; Å
		db  64h	; d
		db  0Dh
		db  92h	; í
		db 0C9h	; …
		db  82h	; Ç
		db 0ADh	; ≠
		db  82h	; Ç
		db 0C8h	; »
		db  82h	; Ç
		db 0ADh	; ≠
		db  82h	; Ç
		db 0C8h	; »
		db  82h	; Ç
		db 0C1h	; ¡
		db  82h	; Ç
		db 0BFh	; ø
		db  82h	; Ç
		db 0E1h	; ·
		db  82h	; Ç
		db 0C1h	; ¡
		db  82h	; Ç
		db 0BDh	; Ω
		db  81h	; Å
		db  42h	; B
		db    0
unk_17DA0	db  82h	; Ç		; DATA XREF: seg001:off_17BF9o
		db 0A0h	; †
		db  82h	; Ç
		db 0A0h	; †
		db  82h	; Ç
		db 0A0h	; †
		db  82h	; Ç
		db 0A0h	; †
		db  82h	; Ç
		db 0A0h	; †
		db  82h	; Ç
		db 0A0h	; †
		db  82h	; Ç
		db 0A0h	; †
		db  82h	; Ç
		db 0F1h	; Ò
		db  81h	; Å
		db  64h	; d
		db  81h	; Å
		db  64h	; d
		db  81h	; Å
		db  49h	; I
		db  0Dh
		db  82h	; Ç
		db 0B2h	; ≤
		db  82h	; Ç
		db 0DFh	; ﬂ
		db  82h	; Ç
		db 0F1h	; Ò
		db  82h	; Ç
		db 0C8h	; »
		db  82h	; Ç
		db 0B3h	; ≥
		db  81h	; Å
		db  60h	; `
		db  82h	; Ç
		db 0A2h	; ¢
		db  81h	; Å
		db  64h	; d
		db  81h	; Å
		db  64h	; d
		db  0Dh
		db  83h	; É
		db  7Ah	; z
		db  83h	; É
		db  8Fh	; è
		db  83h	; É
		db  43h	; C
		db  83h	; É
		db  67h	; g
		db  83h	; É
		db  74h	; t
		db  83h	; É
		db  89h	; â
		db  83h	; É
		db  62h	; b
		db  83h	; É
		db  4Fh	; O
		db  82h	; Ç
		db 0C5h	; ≈
		db  81h	; Å
		db  60h	; `
		db  82h	; Ç
		db 0B7h	; ∑
		db  81h	; Å
		db  64h	; d
		db  81h	; Å
		db  64h	; d
		db    0
off_17DE5	dw offset unk_17DF5	; 0 ; DATA XREF: seg001:tListEnemyo
		dw offset aUSrvVVkbaVbvsg; 1 ; "ìÀëRÇ≈Ç∑Ç™ÅA\rÇbÇsÉXÉLÉÉÉìÇÃéûä‘Ç≈Ç∑\rÉsÅ"...
		dw offset unk_17E75	; 2
		dw offset aVnbdbdbiPnvVOx; 3
		dw offset unk_17EF0	; 4
		dw offset unk_17F1B	; 5
		dw offset unk_17F67	; 6
		dw offset aCivVavBiTUduGt; 7
unk_17DF5	db  40h	; @		; DATA XREF: seg001:off_17DE5o
		db  43h	; C
		db  30h	; 0
		db  83h	; É
		db  73h	; s
		db  81h	; Å
		db  64h	; d
		db  81h	; Å
		db  64h	; d
		db  83h	; É
		db  73h	; s
		db  83h	; É
		db  73h	; s
		db  83h	; É
		db  73h	; s
		db  83h	; É
		db  73h	; s
		db  81h	; Å
		db  64h	; d
		db  0Dh
		db  40h	; @
		db  43h	; C
		db  37h	; 7
		db  82h	; Ç
		db 0A4h	; §
		db  82h	; Ç
		db 0C8h	; »
		db  82h	; Ç
		db 0EAh	; Í
		db  81h	; Å
		db  49h	; I
		db  81h	; Å
		db  40h	; @
		db  94h	; î
		db 0F2h	; Ú
		db  82h	; Ç
		db 0D7h	; ◊
		db  81h	; Å
		db  49h	; I
		db  0Dh
		db  81h	; Å
		db  40h	; @
		db  92h	; í
		db 0B4h	; ¥
		db  93h	; ì
		db  64h	; d
		db  93h	; ì
		db 0B1h	; ±
		db  83h	; É
		db  58h	; X
		db  83h	; É
		db  73h	; s
		db  83h	; É
		db  93h	; ì
		db  83h	; É
		db  7Bh	; {
		db  81h	; Å
		db  5Bh	; [
		db  83h	; É
		db  8Bh	; ã
		db  81h	; Å
		db  49h	; I
		db  81h	; Å
		db  49h	; I
		db    0
aUSrvVVkbaVbvsg	db 'ìÀëRÇ≈Ç∑Ç™ÅA',0Dh,'ÇbÇsÉXÉLÉÉÉìÇÃéûä‘Ç≈Ç∑',0Dh,'ÉsÅ[ÉRÉìÅdÅdÉsÅ[ÉRÉìÅdÅ'
					; DATA XREF: seg001:off_17DE5o
		db 'dÅd',0
unk_17E75	db  40h	; @		; DATA XREF: seg001:off_17DE5o
		db  43h	; C
		db  30h	; 0
		db  10h
		db  82h	; Ç
		db 0CDh	; Õ
		db  0Dh
		db  83h	; É
		db  6Ah	; j
		db  83h	; É
		db  85h	; Ö
		db  81h	; Å
		db  5Bh	; [
		db  83h	; É
		db  8Dh	; ç
		db  83h	; É
		db  74h	; t
		db  83h	; É
		db  40h	; @
		db  83h	; É
		db  57h	; W
		db  81h	; Å
		db  5Bh	; [
		db  0Dh
		db  81h	; Å
		db  40h	; @
		db  83h	; É
		db  76h	; v
		db  83h	; É
		db  89h	; â
		db  83h	; É
		db  59h	; Y
		db  83h	; É
		db  7Dh	; }
		db  83h	; É
		db  52h	; R
		db  83h	; É
		db  93h	; ì
		db  83h	; É
		db  67h	; g
		db  83h	; É
		db  8Dh	; ç
		db  81h	; Å
		db  5Bh	; [
		db  83h	; É
		db  89h	; â
		db  81h	; Å
		db  5Bh	; [
		db  0Dh
		db  81h	; Å
		db  40h	; @
		db  81h	; Å
		db  40h	; @
		db  81h	; Å
		db  40h	; @
		db  81h	; Å
		db  40h	; @
		db  81h	; Å
		db  40h	; @
		db  81h	; Å
		db  40h	; @
		db  81h	; Å
		db  40h	; @
		db  82h	; Ç
		db 0F0h	; 
		db  91h	; ë
		db  80h	; Ä
		db  8Dh	; ç
		db 0ECh	; Ï
		db  82h	; Ç
		db 0B5h	; µ
		db  82h	; Ç
		db 0BDh	; Ω
		db  81h	; Å
		db  49h	; I
		db    0
aVnbdbdbiPnvVOx	db 'Ç≠ÅdÅdÅI',0Dh,'è≠ÇµÇÕéïÇ≤ÇΩÇ¶Ç™ÅdÅd',0Dh,'Ç†ÇÈÇ›ÇΩÇ¢ÇÀÅdÅd',0
					; DATA XREF: seg001:off_17DE5o
unk_17EF0	db  82h	; Ç		; DATA XREF: seg001:off_17DE5o
		db 0ADh	; ≠
		db  82h	; Ç
		db 0B7h	; ∑
		db  82h	; Ç
		db 0C1h	; ¡
		db  81h	; Å
		db  49h	; I
		db  0Dh
		db  82h	; Ç
		db 0A2h	; ¢
		db  82h	; Ç
		db 0A2h	; ¢
		db  82h	; Ç
		db 0A9h	; ©
		db  82h	; Ç
		db 0B0h	; ∞
		db  82h	; Ç
		db 0F1h	; Ò
		db  0Dh
		db  96h	; ñ
		db 0B3h	; ≥
		db  91h	; ë
		db 0CAh	;  
		db  82h	; Ç
		db 0C8h	; »
		db  8Dh	; ç
		db  55h	; U
		db  8Ch	; å
		db  82h	; Ç
		db  82h	; Ç
		db 0CDh	; Õ
		db  82h	; Ç
		db 0E2h	; ‚
		db  82h	; Ç
		db 0DFh	; ﬂ
		db  82h	; Ç
		db 0BDh	; Ω
		db  82h	; Ç
		db 0E7h	; Á
		db  81h	; Å
		db  48h	; H
		db    0
unk_17F1B	db  82h	; Ç		; DATA XREF: seg001:off_17DE5o
		db 0ADh	; ≠
		db  82h	; Ç
		db 0B7h	; ∑
		db  82h	; Ç
		db 0ADh	; ≠
		db  82h	; Ç
		db 0B7h	; ∑
		db  82h	; Ç
		db 0C1h	; ¡
		db  81h	; Å
		db  49h	; I
		db  0Dh
		db  82h	; Ç
		db 0BBh	; ª
		db  82h	; Ç
		db 0F1h	; Ò
		db  82h	; Ç
		db 0C8h	; »
		db  83h	; É
		db  84h	; Ñ
		db  83h	; É
		db  8Fh	; è
		db  82h	; Ç
		db 0C8h	; »
		db  8Dh	; ç
		db  55h	; U
		db  8Ch	; å
		db  82h	; Ç
		db  82h	; Ç
		db 0C5h	; ≈
		db  0Dh
		db  8Eh	; é
		db  84h	; Ñ
		db  82h	; Ç
		db 0F0h	; 
		db  93h	; ì
		db  7Ch	; |
		db  82h	; Ç
		db 0BBh	; ª
		db  82h	; Ç
		db 0A4h	; §
		db  82h	; Ç
		db 0C8h	; »
		db  82h	; Ç
		db 0F1h	; Ò
		db  82h	; Ç
		db 0C4h	; ƒ
		db  0Dh
		db  8Eh	; é
		db  76h	; v
		db  82h	; Ç
		db 0A2h	; ¢
		db  8Fh	; è
		db 0E3h	; „
		db  82h	; Ç
		db 0AAh	; ™
		db  82h	; Ç
		db 0E8h	; Ë
		db  82h	; Ç
		db 0E0h	; ‡
		db  82h	; Ç
		db 0CDh	; Õ
		db  82h	; Ç
		db 0C8h	; »
		db  82h	; Ç
		db 0CDh	; Õ
		db  82h	; Ç
		db 0BEh	; æ
		db  82h	; Ç
		db 0B5h	; µ
		db  82h	; Ç
		db 0A2h	; ¢
		db  82h	; Ç
		db 0EDh	; Ì
		db    0
unk_17F67	db  82h	; Ç		; DATA XREF: seg001:off_17DE5o
		db 0B5h	; µ
		db  82h	; Ç
		db 0DCh	; ‹
		db  82h	; Ç
		db 0C1h	; ¡
		db  82h	; Ç
		db 0BDh	; Ω
		db  82h	; Ç
		db 0C1h	; ¡
		db  81h	; Å
		db  49h	; I
		db  0Dh
		db  82h	; Ç
		db 0EDh	; Ì
		db  81h	; Å
		db  41h	; A
		db  8Eh	; é
		db  84h	; Ñ
		db  82h	; Ç
		db 0C6h	; ∆
		db  82h	; Ç
		db 0B5h	; µ
		db  82h	; Ç
		db 0BDh	; Ω
		db  82h	; Ç
		db 0B1h	; ±
		db  82h	; Ç
		db 0C6h	; ∆
		db  82h	; Ç
		db 0AAh	; ™
		db  81h	; Å
		db  64h	; d
		db  81h	; Å
		db  64h	; d
		db  0Dh
		db  82h	; Ç
		db 0C2h	; ¬
		db  82h	; Ç
		db 0A2h	; ¢
		db  96h	; ñ
		db 0FBh	; ˚
		db  92h	; í
		db  66h	; f
		db  82h	; Ç
		db 0F0h	; 
		db  81h	; Å
		db  64h	; d
		db  81h	; Å
		db  64h	; d
		db  0Dh
		db  82h	; Ç
		db 0A0h	; †
		db  82h	; Ç
		db 0A0h	; †
		db  81h	; Å
		db  64h	; d
		db  8Eh	; é
		db 0A5h	; •
		db  97h	; ó
		db 0CDh	; Õ
		db  82h	; Ç
		db 0AAh	; ™
		db  8Fh	; è
		db 0C1h	; ¡
		db  82h	; Ç
		db 0A6h	; ¶
		db  82h	; Ç
		db 0C4h	; ƒ
		db  82h	; Ç
		db 0E4h	; ‰
		db  82h	; Ç
		db 0ADh	; ≠
		db  81h	; Å
		db  64h	; d
		db  81h	; Å
		db  64h	; d
		db    0
aCivVavBiTUduGt	db 0Dh,'óàÇΩÇÌÇÀÅI',0Dh,'í¥ìdì±ÉTÉCÉRÉoÉäÉÑÅ[ÅI',0
					; DATA XREF: seg001:off_17DE5o
off_17FD8	dw offset aGpgibBiGpgigpg; 0 ; DATA XREF: seg001:tListEnemyo
		dw offset unk_18005	; 1 ; "\rÉpÉIÅ`ÅI\rÉpÉIÉpÉIÉpÉIÅ`ÅIÅI"
		dw offset unk_18052	; 2
		dw offset unk_18091	; 3
		dw offset unk_180A9	; 4
		dw offset aGpgdgbgngbgngb; 5
		dw offset unk_180D9	; 6
		dw offset aChatEnm_0F_7	; 7
aGpgibBiGpgigpg	db 0Dh,'ÉpÉIÅ`ÅI',0Dh,'ÉpÉIÉpÉIÉpÉIÅ`ÅIÅI',0 ; DATA XREF: seg001:off_17FD8o
unk_18005	db  82h	; Ç		; DATA XREF: seg001:off_17FD8o
		db 0D5h	; ’
		db  82h	; Ç
		db 0A4h	; §
		db  82h	; Ç
		db 0A3h	; £
		db  82h	; Ç
		db 0A4h	; §
		db  82h	; Ç
		db 0A3h	; £
		db  82h	; Ç
		db 0A3h	; £
		db  82h	; Ç
		db 0A4h	; §
		db  81h	; Å
		db  60h	; `
		db  81h	; Å
		db  60h	; `
		db  81h	; Å
		db  49h	; I
		db  81h	; Å
		db  49h	; I
		db  0Dh
		db  82h	; Ç
		db 0CFh	; œ
		db  82h	; Ç
		db 0A8h	; ®
		db  82h	; Ç
		db 0CFh	; œ
		db  82h	; Ç
		db 0A8h	; ®
		db  82h	; Ç
		db 0CFh	; œ
		db  82h	; Ç
		db 0A8h	; ®
		db  82h	; Ç
		db 0CFh	; œ
		db  82h	; Ç
		db 0A8h	; ®
		db  82h	; Ç
		db 0A3h	; £
		db  81h	; Å
		db  64h	; d
		db  81h	; Å
		db  64h	; d
		db  0Dh
		db  0Dh
		db  40h	; @
		db  43h	; C
		db  30h	; 0
		db  83h	; É
		db  79h	; y
		db  83h	; É
		db  79h	; y
		db  82h	; Ç
		db 0CDh	; Õ
		db  92h	; í
		db 0B4h	; ¥
		db  8Fh	; è
		db  4Ch	; L
		db  82h	; Ç
		db 0A2h	; ¢
		db  83h	; É
		db  4Bh	; K
		db  83h	; É
		db  58h	; X
		db  82h	; Ç
		db 0F0h	; 
		db  8Fh	; è
		db  6Fh	; o
		db  82h	; Ç
		db 0B5h	; µ
		db  82h	; Ç
		db 0BDh	; Ω
		db  81h	; Å
		db  49h	; I
		db    0
unk_18052	db  83h	; É		; DATA XREF: seg001:off_17FD8o
		db  70h	; p
		db  83h	; É
		db  49h	; I
		db  83h	; É
		db  49h	; I
		db  83h	; É
		db  49h	; I
		db  83h	; É
		db  49h	; I
		db  83h	; É
		db  49h	; I
		db  83h	; É
		db  49h	; I
		db  83h	; É
		db  49h	; I
		db  83h	; É
		db  49h	; I
		db  81h	; Å
		db  49h	; I
		db  81h	; Å
		db  49h	; I
		db  0Dh
		db  0Dh
		db  40h	; @
		db  43h	; C
		db  30h	; 0
		db  82h	; Ç
		db 0A8h	; ®
		db  81h	; Å
		db  60h	; `
		db  82h	; Ç
		db 0C1h	; ¡
		db  82h	; Ç
		db 0C6h	; ∆
		db  8Bh	; ã
		db 0ADh	; ≠
		db  97h	; ó
		db 0F3h	; Û
		db  82h	; Ç
		db 0C8h	; »
		db  0Dh
		db  81h	; Å
		db  40h	; @
		db  83h	; É
		db  79h	; y
		db  83h	; É
		db  79h	; y
		db  83h	; É
		db  89h	; â
		db  83h	; É
		db  8Ah	; ä
		db  83h	; É
		db  41h	; A
		db  81h	; Å
		db  60h	; `
		db  83h	; É
		db  67h	; g
		db  81h	; Å
		db  49h	; I
		db  81h	; Å
		db  49h	; I
		db    0
unk_18091	db  0Dh			; DATA XREF: seg001:off_17FD8o
		db  82h	; Ç
		db 0CFh	; œ
		db  82h	; Ç
		db 0D0h	; –
		db  82h	; Ç
		db 0E5h	; Â
		db  82h	; Ç
		db 0A3h	; £
		db  82h	; Ç
		db 0A8h	; ®
		db  81h	; Å
		db  60h	; `
		db  82h	; Ç
		db 0F1h	; Ò
		db  81h	; Å
		db  64h	; d
		db  81h	; Å
		db  64h	; d
		db  81h	; Å
		db  49h	; I
		db  81h	; Å
		db  49h	; I
		db    0
unk_180A9	db  0Dh			; DATA XREF: seg001:off_17FD8o
		db  82h	; Ç
		db 0CFh	; œ
		db  82h	; Ç
		db 0D0h	; –
		db  82h	; Ç
		db 0E5h	; Â
		db  82h	; Ç
		db 0D0h	; –
		db  82h	; Ç
		db 0E5h	; Â
		db  82h	; Ç
		db 0D0h	; –
		db  82h	; Ç
		db 0E5h	; Â
		db  82h	; Ç
		db 0A8h	; ®
		db  82h	; Ç
		db 0F1h	; Ò
		db  81h	; Å
		db  49h	; I
		db  81h	; Å
		db  49h	; I
		db    0
aGpgdgbgngbgngb	db 0Dh,'ÉpÉDÉbÉnÉbÉnÉbÉnÉbÅIÅI',0 ; DATA XREF: seg001:off_17FD8o
unk_180D9	db  0Dh			; DATA XREF: seg001:off_17FD8o
		db  82h	; Ç
		db 0CFh	; œ
		db  82h	; Ç
		db 0A8h	; ®
		db  81h	; Å
		db  64h	; d
		db  81h	; Å
		db  64h	; d
		db  0Dh
		db  82h	; Ç
		db 0CFh	; œ
		db  82h	; Ç
		db 0A8h	; ®
		db  82h	; Ç
		db 0CFh	; œ
		db  82h	; Ç
		db 0A8h	; ®
		db  81h	; Å
		db  64h	; d
		db  81h	; Å
		db  64h	; d
		db  82h	; Ç
		db 0CFh	; œ
		db  82h	; Ç
		db 0A7h	; ß
		db  82h	; Ç
		db 0F1h	; Ò
		db  81h	; Å
		db  64h	; d
		db  81h	; Å
		db  64h	; d
		db  81h	; Å
		db  64h	; d
		db  81h	; Å
		db  64h	; d
		db    0
ChTxt_Enemy0F	dw offset aCarOVBiSgrdvVV; 0 ; DATA XREF: seg001:tListEnemyo
		dw offset aGagugVFVVvsVPx; 1 ; "ó†êÿé“ÇﬂÅI\rëgêDÇ…ÇΩÇƒÇ¬Ç¢ÇΩÇ±Ç∆ÇÃ\rÇ®ÇÎÇ"...
		dw offset a@c0glbGuglbGug; 2
		dw offset aVnvgbdbdPnvVRm; 3
		dw offset aGegtgtgtbdbdVV; 4
		dw offset aGtgtgtbdbdVVVN; 5
		dw offset aVavkvkvkvkvkvq; 6
		dw offset aChatEnm_0F_7	; 7
aCarOVBiSgrdvVV	db 'ó†êÿé“ÇﬂÅI',0Dh,'ëgêDÇ…ÇΩÇƒÇ¬Ç¢ÇΩÇ±Ç∆ÇÃ',0Dh,'Ç®ÇÎÇ©Ç≥ÇévÇ¢ímÇËÇ»Ç≥Ç¢Å'
					; DATA XREF: seg001:ChTxt_Enemy0Fo
		db 'I',0Dh,'Å@ÉuÉâÉbÉNÉuÉâÉXÉ^Å[ÅIÅI',0
aGagugVFVVvsVPx	db 'ÉAÉìÉ^ÇÃî¸ÇµÇ¢ëÃÇ',0Dh,'èXÇ≠ÉYÉ^ÉYÉ^Ç…ÇµÇƒÇ‚ÇÈÇÌÅI',0Dh,'Å@ÉuÉâÉbÉNÉjÉ'
					; DATA XREF: seg001:ChTxt_Enemy0Fo
		db 'vÉãÅIÅI',0
a@c0glbGuglbGug	db '@C0ÉLÅ[ÉìÉLÅ[ÉìÉLÉìÉLÉìÉLÉìÅI',0Dh,'@C7Ç®Ç∆Ç»ÇµÇ≠ÉCÉCéqÇ…Ç∑ÇÈÇÃÇÊ',0Dh,'Å'
					; DATA XREF: seg001:ChTxt_Enemy0Fo
		db '@ÉuÉâÉbÉNÉ^Å[ÉrÉìÅIÅI',0
aVnvgbdbdPnvVRm	db 'Ç≠Ç£ÅdÅd',0Dh,'è≠ÇµÇÕê¨í∑ÇµÇΩÇÊÇ§ÇÀÅdÅd',0Dh,'ÇæÇØÇ«ÅAÉAÉìÉ^Ç≤Ç∆Ç´Ç…',0Dh,'Ç'
					; DATA XREF: seg001:ChTxt_Enemy0Fo
		db '‚ÇÁÇÍÇΩÇËÇµÇ»Ç¢ÇÌÇÊÅIÅI',0
aGegtgtgtbdbdVV	db 'ÉEÉtÉtÉtÅdÅd',0Dh,'ÇµÇÂÇπÇÒéÑÇÃìGÇ∂Ç·Ç»Ç¢ÇÌÇÀ',0Dh,'çUåÇÇ™Ç‹ÇÈå©Ç¶ÇÊÅIÅ'
					; DATA XREF: seg001:ChTxt_Enemy0Fo
		db 'I',0
aGtgtgtbdbdVVVN	db 'ÉtÉtÉtÅdÅd',0Dh,'ÇªÇÒÇ»çUåÇÇë±ÇØÇƒÇ‡ÉÄÉ_ÇÊ',0Dh,'ó†êÿé“ÇÁÇµÇ≠',0Dh,'Ç®Ç∆Ç'
					; DATA XREF: seg001:ChTxt_Enemy0Fo
		db '»ÇµÇ≠èàíuÇ≥ÇÍÇ»Ç≥Ç¢ÅI',0
aVavkvkvkvkvkvq	db 'Ç†Ç™Ç™Ç™Ç™Ç™ÇüÇüÇüÇüÅIÅI',0Dh,'îné≠Ç»ÅdÅdÇªÇÒÇ»îné≠Ç»ÅdÅd',0Dh,'Ç±ÇÃéÑÇ'
					; DATA XREF: seg001:ChTxt_Enemy0Fo
		db '™ïâÇØÇÈÇ»Ç«ÅdÅd',0Dh,'Ç≠ÅAçïè\éöícÇÊâiâìÇ…ÅIÅI',0
aChatEnm_0F_7	db 'Ç®îné≠Ç≥ÇÒÇÀÇ•',0Dh,'ÇªÇÒÇ»ñÚÇ™í ópÇ∑ÇÈÇ∆Ç≈Ç‡',0Dh,'évÇ¡ÇƒÇ¢ÇÈÇÃÅIÅI',0
					; DATA XREF: seg001:off_17FD8o
					; seg001:ChTxt_Enemy0Fo
aChatEnm_01_7	db 'ÉÅÉbÉZÅ[ÉWñ¢çÏê¨',0 ; DATA XREF: seg001:ChTxt_Enemy01o
					; seg001:ChTxt_Enemy02o ...
		db    0
aNumBuffer1	db 'ÇOÇOÇO',0           ; DATA XREF: ShowStat_HP+28o
					; ShowStat_Atk+28o ...
aNumBuffer2	db 'ÇOÇOÇO',0           ; DATA XREF: seg000:29C2o
					; DrawInt_Buf2+7o ...
aDirBuffer	db 'ÅH',0               ; DATA XREF: SetDirectionText+15o
					; SetSavedTxtPtrs+14o
		db    0
ScrRect_ActType	dw 216,	216, 279, 239	; DATA XREF: ScrSelect_Action+Do
		dw 216,	216, 279, 239	; screen rectangles for	[Attack, Drug, Power]
		db 0, 15, 2, 15, 90, 0,	0, 0
		dw 288,	216, 351, 239
		dw 288,	216, 351, 239
		db 0, 15, 2, 15, 90, 1,	0, 0
		dw 360,	216, 423, 239
		dw 360,	216, 423, 239
		db 0, 15, 2, 15, 90, 2,	0, 0
		dw 0FFFFh
		db    0
		db    0
		db    1
		db    0
		db    1
		db    0
		db    0
		db    0
		db    0
		db    0
		db    1
		db    0
		db    1
		db    0
		db    0
		db  0Fh
		db    0
		db  0Fh
		db  5Ah	; Z
		db 0FFh
		db    0
		db    0
ScrRect_AtkDrug	dw 216,	264, 423, 279	; DATA XREF: ShowAttackList+27o
					; ShowDrugList+27o
		dw 216,	264, 423, 279
		db 1, 15, 0, 15, 90, 0,	0, 0
		dw 216,	280, 423, 295
		dw 216,	280, 423, 295
		db 1, 15, 0, 15, 90, 1,	0, 0
		dw 216,	296, 423, 311
		dw 216,	296, 423, 311
		db 1, 15, 0, 15, 90, 2,	0, 0
		dw 0FFFFh
		db    0
		db    0
		db    1
		db    0
		db    1
		db    0
		db    0
		db    0
		db    0
		db    0
		db    1
		db    0
		db    1
		db    0
		db    0
		db  0Fh
		db    0
		db  0Fh
		db  5Ah	; Z
		db 0FFh
		db    0
		db    0
ScrRect_YesNo	dw 256,	312, 303, 327	; DATA XREF: PlrAct_EltdRecall+22o
					; CanUseDrugs+37o
		dw 256,	312, 303, 327	; screen rectangles for	[Yes, No]
		db 1, 15, 0, 15, 90, 0,	0, 0
		dw 328,	312, 375, 327
		dw 328,	312, 375, 327
		db 1, 15, 0, 15, 90, 1,	0, 0
		dw 0FFFFh
		db    0
		db    0
		db    1
		db    0
		db    1
		db    0
		db    0
		db    0
		db    0
		db    0
		db    1
		db    0
		db    1
		db    0
		db    0
		db  0Fh
		db    0
		db  0Fh
		db  5Ah	; Z
		db    2
		db    0
		db    0
		db 0FFh
		db 0FFh
		db    0
		db    0
		db    1
		db    0
		db    1
		db    0
		db    0
		db    0
		db    0
		db    0
		db    1
		db    0
		db    1
		db    0
		db    0
		db  0Fh
		db    0
		db  0Fh
		db  5Ah	; Z
		db 0FFh
		db    0
		db    0
word_184B8	dw 0A800h		; DATA XREF: sub_12F0E+Do
		dw 0B000h
		dw 0B800h
		dw 0E000h
word_184C0	dw 0FFFFh		; DATA XREF: sub_12F3F+Cw
word_184C2	dw 0FFFFh		; DATA XREF: sub_12F3F+10w
		align 8
word_184C8	dw 8, 18h, 439Bh, 0	; DATA XREF: sub_1316C+17o
					; sub_131A1+18o
		dw 8, 18h, 43A4h, 300h
		dw 8, 18h, 43ADh, 600h
word_184E0	dw 0, 1			; DATA XREF: sub_12EEB+7o
word_184E4	dw 0, 4			; DATA XREF: sub_133EC+15o
		db 1, 3
		db    0
		db  28h	; (
		db    0
		db    0
		db    0
		db    1
		db    6
		db    0
unk_184F2	db    1			; DATA XREF: sub_1323E+16o
					; sub_132A7+16o ...
		db    1
		dd unk_18827
word_184F8	dw 0FFFFh		; DATA XREF: sub_13717+Fr sub_137EC+Aw
word_184FA	dw 0FFFFh		; DATA XREF: sub_13717+18r
					; sub_137EC+10w
byte_184FC	db 0FFh			; DATA XREF: sub_13649+16w
					; sub_13679+15w ...
byte_184FD	db 0FFh			; DATA XREF: sub_1373A+7w sub_137B3+8r ...
dword_184FE	dd 0FFFFFFFFh		; DATA XREF: sub_13968+1Fr
					; sub_1399D+1Cr ...
dword_18502	dd 0FFFFFFFFh		; DATA XREF: sub_135C7+8w sub_13615+Cr ...
FrameDelay	db 1			; DATA XREF: ShowSelectMsg+8r
					; ShowSelectMsg+Cw ...
frameCounter	db 0			; DATA XREF: sub_134A7+6r
					; sub_134A7+1Er ...
OldInt0A	dd 0			; DATA XREF: SetupInts+10w
					; RestoreInts+9r ...
OldInt18	dd 0			; DATA XREF: seg000:4A69r
					; SetupInts+1Dw ...
word_18510	dw ?			; DATA XREF: SaveRegES+7w
					; DoSomeRealloc+3r ...
unk_18512	db    ?	;		; DATA XREF: sub_100A3+8o
					; seg001:off_14CD1o
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
unk_1851B	db    ?	;		; DATA XREF: sub_100F7+2o
unk_1851C	db    ?	;		; DATA XREF: seg001:off_14CD1o
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
unk_18525	db    ?	;		; DATA XREF: sub_100F7+Bo
unk_18526	db    ?	;		; DATA XREF: seg001:off_14CD1o
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
unk_1852F	db    ?	;		; DATA XREF: sub_100F7+14o
unk_18530	db    ?	;		; DATA XREF: seg001:off_14CD1o
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
unk_18539	db    ?	;		; DATA XREF: sub_100F7+1Do
unk_1853A	db    ?	;		; DATA XREF: seg001:off_14CD1o
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
unk_18543	db    ?	;		; DATA XREF: sub_100F7+26o
unk_18544	db    ?	;		; DATA XREF: seg001:off_14CD1o
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
unk_1854D	db    ?	;		; DATA XREF: sub_100F7+2Fo
dword_1854E	dd ?			; DATA XREF: sub_10071:loc_10093r
					; sub_100F7+11w ...
dword_18552	dd ?			; DATA XREF: sub_10071+1Er
					; sub_100F7+23w ...
word_18556	dw ?			; DATA XREF: sub_10071+1Ar
					; sub_100F7+35w
word_18558	dw ?			; DATA XREF: sub_10071+16r
					; sub_100F7+2Cw
word_1855A	dw ?			; DATA XREF: seg000:02FEr
dword_1855C	dd ?			; DATA XREF: sub_1028A+10w
					; LoadPlrEnmData+11r ...
dword_18560	dd ?			; DATA XREF: sub_1028A+18w
					; LoadPlrEnmData+20r ...
dword_18564	dd ?			; DATA XREF: sub_1028A+20w
					; LoadElectrData+10r ...
		db    ?	;
		db    ?	;
fightEnd	db ?			; DATA XREF: sub_10221+Br
					; InitFightMemory+Aw ...
figher1MemPtr	dw ?			; DATA XREF: DecideFirstTurn:loc_105EAw
					; DoFightTurn+Br ...
figher2MemPtr	dw ?			; DATA XREF: DecideFirstTurn+1Aw
					; DoFightTurn+Fr ...
EnemyActProbs	db 10h dup(?)		; DATA XREF: ChooseEnemyAct+9o
					; ChooseEnemyAct+21o ...
PlrAtkID_Weak	dw ?			; DATA XREF: GenPlayerMoves+16w
					; ShowAttackList+Ar ...
PlrAtkID_Strong	dw ?			; DATA XREF: GenPlayerMoves+25w
					; ShowAttackList+11r
PlrAtkID_PFlash	dw ?			; DATA XREF: GenPlayerMoves+28w
					; ShowAttackList+18r
PlrAtkID_Drug1	dw ?			; DATA XREF: GenPlayerMoves+42w
					; GenPlayerMoves+59r ...
PlrAtkID_Drug2	dw ?			; DATA XREF: GenPlayerMoves+5Fw
					; GenPlayerMoves+6Br ...
PlrAtkID_Drug3	dw ?			; DATA XREF: GenPlayerMoves+62w
					; GenPlayerMoves+93r ...
PlrActionType	dw ?			; DATA XREF: ChooseAction+1Ew
					; sub_10D2C+1r
PlrActionID	dw ?			; DATA XREF: ChooseAction:loc_1081Ew
					; ShowActionImage:loc_10835r ...
PlayerMem	db 58h dup(?)		; DATA XREF: InitFightMemory+Fo
					; LoadPlrEnmData+15o ...
EnemyMem	db 58h dup(?)		; DATA XREF: InitFightMemory+1Ao
					; LoadPlrEnmData+24o ...
Electrode2Mem	db 58h dup(?)		; DATA XREF: InitFightMemory+22o
					; LoadElectrData+Do ...
unk_18697	db    ?	;		; DATA XREF: ScrSelect_Action+7o
					; ShowAttackList+21o ...
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
Mem8KSeg	dw ?			; DATA XREF: DoMemoryAlloc+10w
					; DoMemoryFree+8r ...
Mem800BSeg	dw ?			; DATA XREF: DoMemoryAlloc+1Bw
					; DoMemoryFree+11r ...
TextChrBuf	db 20h dup(?)		; DATA XREF: DrawTextChar+7o
dtxtAddr	dw ?			; DATA XREF: DrawText+19r DrawText+71w ...
dtxtPosX	dw ?			; DATA XREF: DrawText+Cr DrawText+99w	...
dtxtPosY	dw ?			; DATA XREF: DrawText+8r DrawText+A2w	...
dtxtColor	db ?			; DATA XREF: DrawText+1Er DrawText+7Fw ...
dtxtFlags	db ?			; DATA XREF: DrawText+23r DrawText+8Dw ...
SavedTextPtrs	dd 5 dup(?)		; DATA XREF: DrawSavedText+8o
					; SetSavedTxtPtr+Do
word_186DE	dw ?			; DATA XREF: sub_130C3+8w
					; sub_130C3+3Er ...
word_186E0	dw ?			; DATA XREF: sub_130C3+Cw
					; sub_130C3+53r ...
word_186E2	dw ?			; DATA XREF: sub_130C3+14w
					; sub_130C3+21r
word_186E4	dw ?			; DATA XREF: sub_130C3+10w
					; sub_130C3+2Ar ...
byte_186E6	db ?			; DATA XREF: sub_130C3+18w
					; sub_1314E+7r	...
unk_186E7	db    ?	;		; DATA XREF: sub_130C3+1Eo
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
unk_18827	db    ?	;		; DATA XREF: sub_1323E+1Do
					; sub_132A7+1Do ...
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
unk_18847	db    ?	;		; DATA XREF: sub_1323E+Bo sub_132A7+Bo ...
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
dword_18868	dd ?			; DATA XREF: sub_13442+Dw sub_13459+Ar ...
byte_1886C	db ?			; DATA XREF: sub_13442+11w
word_1886D	dw ?			; DATA XREF: sub_13459+Eo sub_13474+Br
word_1886F	dw ?			; DATA XREF: sub_13459+13o sub_134D6r
		db    ?	;
dword_18872	dd ?			; DATA XREF: sub_1354E+Dw sub_13565+Ar ...
byte_18876	db ?			; DATA XREF: sub_1354E+11w
					; sub_1358E+7w	...
		db    ?	;
		db    ?	;
byte_18879	db ?			; DATA XREF: sub_13565+14w
					; sub_135AC+Cr	...
word_1887A	dw ?			; DATA XREF: sub_13565+18o
					; sub_135C7+5r	...
word_1887C	dw ?			; DATA XREF: sub_135C7+Br sub_135DF+Fr
byte_1887E	db ?			; DATA XREF: sub_135DF+Cw sub_13679+7w ...
byte_1887F	db ?			; DATA XREF: sub_135DF+16w
					; sub_13717+8r
byte_18880	db ?			; DATA XREF: sub_135FF+Cw
					; sub_13649+13r
word_18881	dw ?			; DATA XREF: sub_1391A+Br
					; sub_1391A+18r ...
word_18883	dw ?			; DATA XREF: sub_1391A+15r
					; sub_13B23+2Aw
word_18885	dw ?			; DATA XREF: sub_1391A+8r
					; sub_1391A+23r ...
word_18887	dw ?			; DATA XREF: sub_1391A+20r
					; sub_13B23+49w
word_18889	dw ?			; DATA XREF: sub_1391A+12w
					; sub_13B74+6r	...
word_1888B	dw ?			; DATA XREF: sub_1391A+1Dw
					; sub_1391A+2Br ...
word_1888D	dw ?			; DATA XREF: sub_1391A+28w
					; sub_13B74+15r ...
byte_1888F	db ?			; DATA XREF: sub_1391A+35w
					; sub_13B23+1Ew ...
byte_18890	db ?			; DATA XREF: sub_1391A+32r
					; sub_1391A+39w ...
byte_18891	db ?			; DATA XREF: sub_13B23+8w
					; sub_13B74+19r ...
byte_18892	db ?			; DATA XREF: sub_13BFC+16w
					; sub_13CED+6r
byte_18893	db ?			; DATA XREF: sub_13BFC+1Bw
					; sub_13D0C+6r
byte_18894	db ?			; DATA XREF: sub_13BFC+34w
					; sub_13D44+6r
byte_18895	db ?			; DATA XREF: sub_13BFC+38w
					; sub_13D2D+6r
		align 4
word_18898	dw ?			; DATA XREF: sub_13749+Dw sub_13808+7r ...
word_1889A	dw ?			; DATA XREF: sub_13749+10w
					; sub_13808+Er	...
word_1889C	dw ?			; DATA XREF: sub_13749+14w
					; sub_1376B+Ar	...
word_1889E	dw ?			; DATA XREF: sub_13749+18w
					; sub_1376B+Er	...
dword_188A0	dd ?			; DATA XREF: sub_1404A+Dw sub_14061+3r ...
byte_188A4	db ?			; DATA XREF: sub_1404A+11w
					; sub_14061+3Ew
word_188A5	dw ?			; DATA XREF: sub_14061+Co sub_140BD+5r ...
word_188A7	dw ?			; DATA XREF: sub_140BD+8r
					; sub_140E4+12r ...
byte_188A9	db ?			; DATA XREF: sub_140BD+22r
byte_188AA	db ?			; DATA XREF: sub_14160w sub_14160+15r	...
word_188AB	dw ?			; DATA XREF: sub_14160+Aw
word_188AD	dw ?			; DATA XREF: sub_14160+11w
byte_188AF	db ?			; DATA XREF: sub_14192:loc_141BAw
					; sub_141DF:loc_14207w	...
byte_188B0	db ?			; DATA XREF: sub_14192+2Bw
					; sub_141DF+2Bw ...
word_188B1	dw ?			; DATA XREF: sub_14192+3Bw
					; sub_141DF+2Fw ...
word_188B3	dw ?			; DATA XREF: sub_14192+3Fw
					; sub_141DF+33w ...
byte_188B5	db ?			; DATA XREF: sub_14192+43w
					; sub_141DF+37w ...
dword_188B6	dd ?			; DATA XREF: sub_14424+Dw sub_14466+3r ...
byte_188BA	db ?			; DATA XREF: sub_14424+11w
					; sub_14488+7w	...
byte_188BB	db ?			; DATA XREF: sub_14547+20w
					; sub_14547+2Dw ...
byte_188BC	db ?			; DATA XREF: SaveFrameDelay+Aw
					; RestoreFrameDly+7r
byte_188BD	db ?			; DATA XREF: sub_14466+Co sub_145DD+Dr
byte_188BE	db ?			; DATA XREF: sub_14547+15r
					; sub_145DD+17r
dword_188BF	dd ?			; DATA XREF: sub_144CA+Fr
unk_188C3	db    ?	;		; DATA XREF: sub_144A6+10o
					; sub_144A6+16o ...
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
unk_188E3	db    ?	;		; DATA XREF: sub_144CA+13o
					; sub_144CA+30o
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
unk_18903	db    ?	;		; DATA XREF: sub_14424+16o
					; sub_144A6+19o ...
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
unk_18963	db    ?	;		; DATA XREF: sub_144CA+33o
					; sub_14547+Do	...
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
TextChrBIOSHdr	db ?			; DATA XREF: biosGetCharData+Do
					; character byte count (1 for ASCII, 2 for JIS)
		db ?			; character width (1 for half-width, 2 for full-width)
TextChrBIOSBuf	db 20h dup(?)		; DATA XREF: GetBlock16+Eo
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
seg001		ends

; ===========================================================================

; Segment type:	Uninitialized
seg002		segment	byte stack 'STACK' use16
		assume cs:seg002
		assume es:nothing, ss:nothing, ds:nothing, fs:nothing, gs:nothing
byte_189F0	db 800h	dup(?)
seg002		ends

; ===========================================================================

; Segment type:	Zero-length
seg003		segment	byte public '' use16
seg003		ends


		end start
