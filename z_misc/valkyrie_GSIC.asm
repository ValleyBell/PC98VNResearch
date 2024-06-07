; Input	MD5   :	B7972DDE98E928FC6F394592BD29DFE3
; Input	CRC32 :	00ABDB32

; File Name   :	R:\GSIC.EXE
; Format      :	MS-DOS executable (EXE)
; Base Address:	1000h Range: 10000h-16020h Loaded length: 5820h
; Entry	Point :	1000:54B8

		.686p
		.mmx
		.model large

; ===========================================================================

; Segment type:	Pure code
seg000		segment	byte public 'CODE' use16
		assume cs:seg000
		assume es:nothing, ss:nothing, ds:nothing, fs:nothing, gs:nothing

; =============== S U B	R O U T	I N E =======================================


sub_10000	proc near		; CODE XREF: start+84p
					; DATA XREF: seg000:off_134CDo
		cmp	al, 1
		ja	short loc_1000F
		jz	short loc_10013
		mov	cs:byte_13862, 0FFh
		xor	ax, ax
		retn
; ---------------------------------------------------------------------------

loc_1000F:				; CODE XREF: sub_10000+2j
		mov	ax, 0FFFFh
		retn
; ---------------------------------------------------------------------------

loc_10013:				; CODE XREF: sub_10000+4j
		mov	cs:byte_13862, 0
		push	si
		push	di

loc_1001B:
		push	es
		push	cs
		pop	es
		assume es:seg000
		mov	di, offset byte_14A2C
		mov	ax, 7

loc_10024:				; CODE XREF: sub_10000+2Bj
		cmp	[si], ah
		jz	short loc_1002D
		movsb
		dec	al
		jnz	short loc_10024

loc_1002D:				; CODE XREF: sub_10000+26j
		xor	ax, ax
		stosb
		pop	es
		assume es:nothing
		pop	di
		pop	si
		retn
sub_10000	endp


; =============== S U B	R O U T	I N E =======================================


sub_10034	proc near		; CODE XREF: sub_12530+B87p
					; DATA XREF: seg000:off_134CDo
		push	bx
		mov	ax, bx
		cmp	ah, 2
		jnb	short loc_1004D
		cmp	al, 40h	; '@'
		jnb	short loc_1004D
		mov	bl, ah
		xor	bh, bh
		mov	cs:byte_13868[bx], al
		xor	ax, ax
		pop	bx
		retn
; ---------------------------------------------------------------------------

loc_1004D:				; CODE XREF: sub_10034+6j sub_10034+Aj
		mov	ax, 0FFFFh
		pop	bx
		retn
sub_10034	endp


; =============== S U B	R O U T	I N E =======================================


CheckDiskID	proc near		; CODE XREF: sub_12530+B77p
					; DATA XREF: seg000:off_134CDo
		push	bx

loc_10053:
		push	cx
		push	dx
		push	si
		push	di
		push	ds
		push	es
		push	cs
		pop	ds
		assume ds:seg000
		push	cs
		pop	es
		assume es:seg000
		mov	bl, al
		or	bl, bl
		mov	ax, 7Fh	; ''
		js	short loc_1006D
		test	byte_13860, 0FFh
		jnz	short loc_100DA

loc_1006D:				; CODE XREF: CheckDiskID+12j
		and	bx, ax
		cmp	bl, 2
		jnb	short loc_100E9
		mov	al, DiskDriveIDs[bx]
		or	al, al
		js	short loc_100E9
		mov	ch, bh
		mov	cl, al
		add	al, 'A'

loc_10082:
		mov	dx, offset fullFilePath
		mov	word ptr FilePathPtr, dx
		mov	word ptr FilePathPtr+2,	cs
		mov	di, dx
		stosb
		mov	si, offset aDisk_id_sys	; ":\\DISK_ID.SYS"

loc_10093:				; CODE XREF: CheckDiskID+45j
		movsb
		cmp	[si-1],	ch
		jnz	short loc_10093
		mov	ax, cx
		call	SearchDiskDrive
		or	ax, ax
		js	short loc_100F3
		mov	ax, 3D00h
		int	21h		; DOS -	2+ - OPEN DISK FILE WITH HANDLE
					; DS:DX	-> ASCIZ filename
					; AL = access mode
					; 0 - read
		jb	short loc_100E2
		mov	bx, ax
		mov	cx, 100h
		mov	dx, offset byte_14B38
		mov	ah, 3Fh
		int	21h		; DOS -	2+ - READ FROM FILE WITH HANDLE
					; BX = file handle, CX = number	of bytes to read
					; DS:DX	-> buffer
		jb	short loc_100E9
		mov	ah, 3Eh
		int	21h		; DOS -	2+ - CLOSE A FILE WITH HANDLE
					; BX = file handle
		mov	di, dx
		mov	bx, dx
		mov	si, offset byte_14A08
		test	byte ptr [si], 0FFh
		jz	short loc_100D5
		mov	cx, ' '

loc_100CA:				; CODE XREF: CheckDiskID+81j
		mov	al, [si]
		cmpsb
		jnz	short loc_100EE
		or	al, al
		jz	short loc_100D5
		loop	loc_100CA

loc_100D5:				; CODE XREF: CheckDiskID+73j
					; CheckDiskID+7Fj
		xor	ah, ah
		mov	al, [bx+20h]

loc_100DA:				; CODE XREF: CheckDiskID+19j
					; CheckDiskID+95j ...
		pop	es
		assume es:nothing
		pop	ds
		assume ds:nothing
		pop	di
		pop	si
		pop	dx
		pop	cx
		pop	bx
		retn
; ---------------------------------------------------------------------------

loc_100E2:				; CODE XREF: CheckDiskID+55j
		neg	ax
		cmp	ax, 0FFFEh
		jz	short loc_100DA

loc_100E9:				; CODE XREF: CheckDiskID+20j
					; CheckDiskID+28j ...
		mov	ax, 0FFFCh
		jmp	short loc_100DA
; ---------------------------------------------------------------------------

loc_100EE:				; CODE XREF: CheckDiskID+7Bj
		mov	ax, 0FFFDh
		jmp	short loc_100DA
; ---------------------------------------------------------------------------

loc_100F3:				; CODE XREF: CheckDiskID+4Ej
		mov	ax, 0FFFFh
		jmp	short loc_100DA
CheckDiskID	endp


; =============== S U B	R O U T	I N E =======================================


BuildAbsolutePath proc near		; CODE XREF: LoadFile1+Cp
					; LoadGSCFile+21p ...
		push	bx
		push	cx
		push	si
		push	di
		mov	di, dx
		xor	ah, ah
		cmp	byte ptr [si+1], ':'
		jnz	short loc_10149
		mov	ah, [si]
		and	ah, 0DFh
		cmp	ah, 'S'
		jnz	short loc_10127
		test	cs:byte_1386D, 0FFh
		jns	short loc_1011B
		jmp	loc_10216
; ---------------------------------------------------------------------------

loc_1011B:				; CODE XREF: BuildAbsolutePath+1Ej
		xor	bl, bl
		mov	cs:byte_13863, bl
		push	ds
		push	si
		jmp	loc_10214
; ---------------------------------------------------------------------------

loc_10127:				; CODE XREF: BuildAbsolutePath+16j
		cmp	ah, 'Z'
		jbe	short loc_1012F
		jmp	loc_10216
; ---------------------------------------------------------------------------

loc_1012F:				; CODE XREF: BuildAbsolutePath+32j
		jz	short loc_10149
		mov	cs:byte_13863, ah
		cmp	ah, 'X'
		jb	short loc_1013E
		jmp	loc_101E3
; ---------------------------------------------------------------------------

loc_1013E:				; CODE XREF: BuildAbsolutePath+41j
		sub	ah, 'A'
		cmp	ah, 2
		jb	short loc_10149
		jmp	loc_10216
; ---------------------------------------------------------------------------

loc_10149:				; CODE XREF: BuildAbsolutePath+Cj
					; BuildAbsolutePath:loc_1012Fj	...
		mov	cs:byte_13863, ah
		mov	bl, al
		test	cs:byte_13860, 0FFh
		jnz	short loc_1015B
		jmp	loc_101E3
; ---------------------------------------------------------------------------

loc_1015B:				; CODE XREF: BuildAbsolutePath+5Ej
		push	ds
		push	si
		mov	si, cs:word_13854
		push	cs
		pop	ds
		assume ds:seg000
		mov	cx, 80h

loc_10167:				; CODE XREF: BuildAbsolutePath+74j
		cmp	[si], ch
		jz	short loc_10171
		movsb
		loop	loc_10167
		jmp	loc_10214
; ---------------------------------------------------------------------------

loc_10171:				; CODE XREF: BuildAbsolutePath+71j
		test	byte_13862, 0FFh
		jnz	short loc_101C1
		mov	si, offset byte_14A2C
		mov	bh, ch
		mov	bl, byte_13863

loc_10181:				; CODE XREF: BuildAbsolutePath+B9j
		lodsb
		or	al, al
		jz	short loc_101B5
		cmp	al, '*'
		jnz	short loc_101A6
		mov	al, byte_13868[bx]
		cmp	al, 0Ah
		jb	short loc_101A2
		xor	ah, ah
		mov	bh, 0Ah
		div	bh
		add	al, '0'
		stosb
		mov	al, ah
		dec	cx
		jns	short loc_101A2
		jmp	short loc_10214
; ---------------------------------------------------------------------------

loc_101A2:				; CODE XREF: BuildAbsolutePath+98j
					; BuildAbsolutePath+A6j
		add	al, '0'
		jmp	short loc_101B0
; ---------------------------------------------------------------------------

loc_101A6:				; CODE XREF: BuildAbsolutePath+90j
		cmp	al, '?'
		jnz	short loc_101B0
		mov	al, byte_13868[bx]
		add	al, 'A'

loc_101B0:				; CODE XREF: BuildAbsolutePath+ACj
					; BuildAbsolutePath+B0j
		stosb
		loop	loc_10181
		jmp	short loc_10214
; ---------------------------------------------------------------------------

loc_101B5:				; CODE XREF: BuildAbsolutePath+8Cj
		mov	al, '\'
		cmp	es:[di-1], al
		jz	short loc_101C1
		stosb
		dec	cx
		js	short loc_10214

loc_101C1:				; CODE XREF: BuildAbsolutePath+7Ej
					; BuildAbsolutePath+C3j
		pop	si
		pop	ds
		assume ds:nothing
		cmp	byte ptr [si+1], ':'
		jnz	short loc_101CC
		add	si, 2

loc_101CC:				; CODE XREF: BuildAbsolutePath+CFj
		cmp	byte ptr [si], '\'
		jnz	short loc_101D2
		inc	si

loc_101D2:				; CODE XREF: BuildAbsolutePath+D7j
					; BuildAbsolutePath+116j ...
		xor	ax, ax

loc_101D4:				; CODE XREF: BuildAbsolutePath+E2j
		movsb
		cmp	[si-1],	al
		jz	short loc_101DE
		loop	loc_101D4
		jmp	short loc_10216
; ---------------------------------------------------------------------------

loc_101DE:				; CODE XREF: BuildAbsolutePath+E0j
		pop	di
		pop	si
		pop	cx
		pop	bx
		retn
; ---------------------------------------------------------------------------

loc_101E3:				; CODE XREF: BuildAbsolutePath+43j
					; BuildAbsolutePath+60j
		xor	ax, ax
		cmp	byte ptr [si+1], ':'
		jnz	short loc_101EE
		add	si, 2

loc_101EE:				; CODE XREF: BuildAbsolutePath+F1j
		mov	al, cs:byte_13863
		cmp	al, 'X'
		jb	short loc_101F8
		sub	al, 'X'

loc_101F8:				; CODE XREF: BuildAbsolutePath+FCj
		cmp	al, 2
		ja	short loc_10216
		mov	bx, ax
		mov	ax, ':A'
		add	al, cs:DiskDriveIDs[bx]
		stosw
		mov	cx, '~'
		mov	al, '\'
		cmp	[si], al
		jz	short loc_101D2
		stosb
		dec	cx
		jmp	short loc_101D2
; ---------------------------------------------------------------------------

loc_10214:				; CODE XREF: BuildAbsolutePath+2Cj
					; BuildAbsolutePath+76j ...
		pop	si
		pop	ds

loc_10216:				; CODE XREF: BuildAbsolutePath+20j
					; BuildAbsolutePath+34j ...
		pop	di
		pop	si
		pop	cx
		pop	bx
		mov	ax, 0FFFFh
		retn
BuildAbsolutePath endp


; =============== S U B	R O U T	I N E =======================================


sub_1021E	proc near		; CODE XREF: SearchDiskDrive+17j
					; seg000:0D10p
					; DATA XREF: ...
		push	ax
		cmp	al, 4
		jnb	short loc_1023A
		mov	cs:byte_13864, al
		or	al, 90h
		mov	ah, 84h
		int	1Bh		; CTRL-BREAK KEY
		jb	short loc_1023A
		and	ah, 0F0h
		cmp	ah, 10h
		jz	short loc_10240
		pop	ax
		clc
		retn
; ---------------------------------------------------------------------------

loc_1023A:				; CODE XREF: sub_1021E+3j sub_1021E+Fj
		pop	ax
		mov	ax, 0FFFFh
		stc
		retn
; ---------------------------------------------------------------------------

loc_10240:				; CODE XREF: sub_1021E+17j
		pop	ax
		mov	ah, 10h
		clc
		retn
sub_1021E	endp


; =============== S U B	R O U T	I N E =======================================


SearchDiskDrive	proc near		; CODE XREF: CheckDiskID+49p
					; sub_102E9+11p ...
		push	bx
		mov	bx, 1

loc_10249:				; CODE XREF: SearchDiskDrive+Dj
		cmp	al, cs:DiskDriveIDs[bx]
		jz	short loc_10259
		dec	bl
		jns	short loc_10249
		pop	bx
		xor	ax, ax
		clc
		retn
; ---------------------------------------------------------------------------

loc_10259:				; CODE XREF: SearchDiskDrive+9j
		mov	ax, bx
		pop	bx
		jmp	short sub_1021E
SearchDiskDrive	endp


; =============== S U B	R O U T	I N E =======================================


ResolveString	proc near		; CODE XREF: sub_12530+B53p
					; DATA XREF: seg000:off_134CDo
		cmp	al, 2
		jb	short loc_10264
		stc
		retn
; ---------------------------------------------------------------------------

loc_10264:				; CODE XREF: ResolveString+2j
		push	bx
		push	cx
		push	di
		push	es
		xor	ah, ah
		mov	bx, ax
		mov	di, offset byte_1131D
		or	al, al
		jz	short loc_10276
		mov	di, offset byte_1135D

loc_10276:				; CODE XREF: ResolveString+13j
		push	cs
		pop	es
		assume es:seg000
		mov	cx, 3Fh	; '?'

loc_1027B:				; CODE XREF: ResolveString+48j
		lodsb
		or	al, al
		jns	short loc_10291
		cmp	al, 0A0h ; '†'
		jb	short loc_10288
		cmp	al, 0E0h ; '‡'
		jb	short loc_10291

loc_10288:				; CODE XREF: ResolveString+24j
		sub	cx, 2
		jb	short loc_102A8
		stosb
		movsb
		jmp	short loc_102A4
; ---------------------------------------------------------------------------

loc_10291:				; CODE XREF: ResolveString+20j
					; ResolveString+28j
		cmp	al, 25h	; '%'
		jnz	short loc_102A2
		mov	al, 82h	; 'Ç'
		stosb
		mov	al, 50h	; 'P'
		add	al, bl
		stosb
		sub	cx, 2
		jmp	short loc_102A4
; ---------------------------------------------------------------------------

loc_102A2:				; CODE XREF: ResolveString+35j
		stosb
		dec	cx

loc_102A4:				; CODE XREF: ResolveString+31j
					; ResolveString+42j
		or	cx, cx
		jg	short loc_1027B

loc_102A8:				; CODE XREF: ResolveString+2Dj
		xor	al, al
		stosb
		mov	cs:byte_13865[bx], 0FFh
		clc
		pop	es
		assume es:nothing
		pop	di
		pop	dx
		pop	cx
		retn
ResolveString	endp


; =============== S U B	R O U T	I N E =======================================


OpenFileRead1	proc near		; CODE XREF: LoadFile1+17p LoadMDL+15p
					; DATA XREF: ...
		mov	word ptr cs:FilePathPtr, dx
		mov	word ptr cs:FilePathPtr+2, ds
		push	bx

loc_102C2:				; CODE XREF: OpenFileRead1+30j
		push	ax
		call	sub_102E9
		jb	short loc_102E2
		mov	ah, 3Dh
		int	21h		; DOS -	2+ - OPEN DISK FILE WITH HANDLE
					; DS:DX	-> ASCIZ filename
					; AL = access mode
					; 0 - read, 1 -	write, 2 - read	& write
		jb	short loc_102D1
		pop	bx
		pop	bx
		retn
; ---------------------------------------------------------------------------

loc_102D1:				; CODE XREF: OpenFileRead1+15j
		cmp	al, 2
		jz	short loc_102E2
		cmp	al, 3
		jz	short loc_102E2
		mov	bh, 3Dh	; '='
		mov	bl, al
		mov	ax, 10Fh
		int	0BEh		; used by BASIC	while in interpreter

loc_102E2:				; CODE XREF: OpenFileRead1+Fj
					; OpenFileRead1+1Cj ...
		mov	al, 40h	; '@'
		int	0BEh		; used by BASIC	while in interpreter
		pop	ax
		jmp	short loc_102C2
OpenFileRead1	endp


; =============== S U B	R O U T	I N E =======================================


sub_102E9	proc near		; CODE XREF: OpenFileRead1+Cp
					; OpenFileRead2+Cp
		mov	bx, dx
		cmp	byte ptr [bx+1], 3Ah ; ':'
		jnz	short loc_10302
		push	ax
		xor	ax, ax
		mov	al, [bx]
		and	al, 0DFh
		sub	al, 41h	; 'A'
		call	SearchDiskDrive
		or	ax, ax
		pop	ax
		js	short loc_10304

loc_10302:				; CODE XREF: sub_102E9+6j
		clc
		retn
; ---------------------------------------------------------------------------

loc_10304:				; CODE XREF: sub_102E9+17j
		stc
		retn
sub_102E9	endp


; =============== S U B	R O U T	I N E =======================================


OpenFileRead2	proc near		; CODE XREF: sub_12530+323p
					; OpenSave_Read+11j
					; DATA XREF: ...
		mov	word ptr cs:FilePathPtr, dx
		mov	word ptr cs:FilePathPtr+2, ds
		push	bx

loc_10311:				; CODE XREF: OpenFileRead2+30j
		push	ax
		call	sub_102E9
		jb	short loc_10331
		mov	ah, 3Dh
		int	21h		; DOS -	2+ - OPEN DISK FILE WITH HANDLE
					; DS:DX	-> ASCIZ filename
					; AL = access mode
					; 0 - read, 1 -	write, 2 - read	& write
		jb	short loc_10320
		pop	bx
		pop	bx
		retn
; ---------------------------------------------------------------------------

loc_10320:				; CODE XREF: OpenFileRead2+15j
		cmp	al, 2
		jz	short loc_10338
		cmp	al, 3
		jz	short loc_10331
		mov	bh, 3Dh	; '='
		mov	bl, al
		mov	ax, 10Fh
		int	0BEh		; used by BASIC	while in interpreter

loc_10331:				; CODE XREF: OpenFileRead2+Fj
					; OpenFileRead2+20j
		mov	al, 40h	; '@'
		int	0BEh		; used by BASIC	while in interpreter
		pop	ax
		jmp	short loc_10311
; ---------------------------------------------------------------------------

loc_10338:				; CODE XREF: OpenFileRead2+1Cj
		mov	ax, 0FFFFh
		stc
		pop	bx
		pop	bx
		retn
OpenFileRead2	endp

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR OpenSave_Write

OpenFileWrite:				; CODE XREF: OpenSave_Write+11j
					; DATA XREF: seg000:off_134CDo
		mov	word ptr cs:FilePathPtr, dx
		mov	word ptr cs:FilePathPtr+2, ds
		push	bx
		push	cx
		xor	ch, ch
		mov	cl, al
		mov	bx, dx
		cmp	byte ptr [bx+1], ':'
		jnz	short loc_1036D

loc_10357:				; CODE XREF: OpenSave_Write-25EEj
					; OpenSave_Write-25DFj
		mov	al, [bx]
		sub	al, 'A'
		call	SearchDiskDrive
		or	ax, ax
		js	short loc_10376
		cmp	ah, 10h
		jnz	short loc_1036D
		mov	al, 'B'
		int	0BEh		; used by BASIC	while in interpreter
		jmp	short loc_10357
; ---------------------------------------------------------------------------

loc_1036D:				; CODE XREF: OpenSave_Write-2604j
					; OpenSave_Write-25F4j
		mov	ah, 3Ch
		int	21h		; DOS -	2+ - CREATE A FILE WITH	HANDLE (CREAT)
					; CX = attributes for file
					; DS:DX	-> ASCIZ filename (may include drive and path)
		jb	short loc_1037C
		pop	cx
		pop	bx
		retn
; ---------------------------------------------------------------------------

loc_10376:				; CODE XREF: OpenSave_Write-25F9j
		mov	al, 'A'
		int	0BEh		; used by BASIC	while in interpreter
		jmp	short loc_10357
; ---------------------------------------------------------------------------

loc_1037C:				; CODE XREF: OpenSave_Write-25E8j
		cmp	al, 3
		jz	short loc_10389
		mov	bh, 3Ch
		mov	bl, al
		mov	ax, 10Fh
		int	0BEh		; used by BASIC	while in interpreter

loc_10389:				; CODE XREF: OpenSave_Write-25DBj
		mov	al, 14h
		int	0BEh		; used by BASIC	while in interpreter
; END OF FUNCTION CHUNK	FOR OpenSave_Write

; =============== S U B	R O U T	I N E =======================================


LoadFile1	proc near		; CODE XREF: start-1D58p start-1D48p ...
		push	dx
		push	si
		push	di
		push	ds
		push	es
		mov	si, dx
		push	cs
		pop	es
		assume es:seg000
		mov	dx, offset fullFilePath
		call	BuildAbsolutePath
		or	ax, ax
		js	short loc_10413
		push	es
		pop	ds
		assume ds:seg000
		xor	al, al
		call	OpenFileRead1
		mov	dx, ax
		mov	bx, dx
		call	GetFileSize
		jb	short loc_103D4	; uncompressed - jump
		add	ax, 0Fh
		adc	bx, 0
		shr	ax, 4
		shl	bl, 4
		or	ah, bl
		mov	bx, ax
		xor	ax, ax
		call	AllocFileMem
		mov	bx, dx
		jb	short loc_1041F
		mov	ds, ax
		assume ds:nothing
		xor	dx, dx
		call	DecompressFile
		jnb	short loc_1040A
		jmp	short loc_1040D
; ---------------------------------------------------------------------------

loc_103D4:				; CODE XREF: LoadFile1+21j
		mov	bx, dx
		or	ax, ax
		jnz	short loc_1041B
		call	sub_10658
		jb	short loc_1041B
		add	ax, 0Fh
		adc	bx, 0
		shr	ax, 4
		shl	bl, 4
		or	ah, bl
		mov	cx, ax
		add	ax, 10h
		mov	bx, ax
		xor	ax, ax
		call	AllocFileMem
		mov	bx, dx
		jb	short loc_1041F
		mov	ds, ax
		xor	dx, dx
		call	ReadRawFile
		jb	short loc_1041B
		mov	ah, 3Eh
		int	21h		; DOS -	2+ - CLOSE A FILE WITH HANDLE
					; BX = file handle

loc_1040A:				; CODE XREF: LoadFile1+43j
		mov	ax, ds
		clc

loc_1040D:				; CODE XREF: LoadFile1+45j
		pop	es
		assume es:nothing
		pop	ds
		pop	di
		pop	si
		pop	dx
		retn
; ---------------------------------------------------------------------------

loc_10413:				; CODE XREF: LoadFile1+11j
		mov	al, 14h
		int	0BEh		; used by BASIC	while in interpreter
		mov	al, 28h
		int	0BEh		; used by BASIC	while in interpreter

loc_1041B:				; CODE XREF: LoadFile1+4Bj
					; LoadFile1+50j ...
		mov	al, 29h
		int	0BEh		; used by BASIC	while in interpreter

loc_1041F:				; CODE XREF: LoadFile1+3Aj
					; LoadFile1+6Ej
		mov	al, 20h
		int	0BEh		; used by BASIC	while in interpreter
LoadFile1	endp ; sp-analysis failed


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

GetFileSize	proc near		; CODE XREF: LoadFile1+1Ep
					; LoadGSCFile+71p
					; DATA XREF: ...
		push	bp
		push	cx
		push	dx
		push	ds
		mov	bp, sp
		mov	cx, 10h
		sub	sp, cx
		push	ss
		pop	ds
		mov	dx, sp
		mov	ah, 3Fh
		int	21h		; DOS -	2+ - READ FROM FILE WITH HANDLE
					; BX = file handle, CX = number	of bytes to read
					; DS:DX	-> buffer
		jb	short loc_10468
		mov	cx, bx
		mov	bx, dx
		mov	ax, [bx]
		cmp	ax, 'PD'        ; check for "DPX0" header
		jnz	short loc_10459
		mov	ax, [bx+2]
		cmp	ax, '0X'
		jnz	short loc_10459
		mov	ax, [bx+8]	; get low word
		mov	bx, [bx+0Ah]	; get high word
		clc			; set "compressed" flag

loc_10452:				; CODE XREF: GetFileSize+46j
		mov	sp, bp
		pop	ds
		pop	dx
		pop	cx
		pop	bp
		retn
; ---------------------------------------------------------------------------

loc_10459:				; CODE XREF: GetFileSize+1Ej
					; GetFileSize+26j
		mov	bx, cx
		xor	cx, cx
		mov	dx, cx
		mov	ax, 4200h
		int	21h		; DOS -	2+ - MOVE FILE READ/WRITE POINTER (LSEEK)
					; AL = method: offset from beginning of	file
		jb	short loc_10468
		xor	ax, ax

loc_10468:				; CODE XREF: GetFileSize+13j
					; GetFileSize+41j
		stc			; set "uncompressed" flag
		jmp	short loc_10452
GetFileSize	endp


; =============== S U B	R O U T	I N E =======================================


DecompressFile	proc near		; CODE XREF: LoadFile1+40p
					; LoadGSCFile+A1p ...
		push	bp
		push	cx
		push	dx
		push	si
		push	di
		push	ds
		push	es
		cld
		push	ds
		pop	es		; destination segment
		mov	di, dx		; destination offset
		sub	sp, 0Ah
		mov	bp, sp
		xor	ax, ax
		mov	[bp+0],	ax
		mov	[bp+2],	sp
		mov	[bp+4],	ax
		mov	[bp+6],	bx	; file handle
		mov	ax, sp
		and	al, 0F0h
		sub	ax, 2000h
		jb	short loc_104A5
		mov	sp, ax
		mov	[bp+8],	ax
		mov	dx, ss
		shr	ax, 4
		add	ax, dx
		mov	ds, ax
		call	DecompressData
		clc

loc_104A5:				; CODE XREF: DecompressFile+26j
					; ReadFileBlock+18j
		sbb	dx, dx
		mov	bx, [bp+6]
		mov	ah, 3Eh
		int	21h		; DOS -	2+ - CLOSE A FILE WITH HANDLE
					; BX = file handle
		mov	ax, [bp+0]
		mov	sp, [bp+2]
		add	sp, 0Ah
		add	dx, dx
		pop	es
		pop	ds
		pop	di
		pop	si
		pop	dx
		pop	cx
		pop	bp
		retn
DecompressFile	endp


; =============== S U B	R O U T	I N E =======================================


DecompressData	proc near		; CODE XREF: DecompressFile+36p
		call	ReadFileBlock
		lodsb
		mov	dl, al
		mov	dh, 8

loc_104C9:				; CODE XREF: DecompressData+23j
					; DecompressData+65j
		or	di, di
		jns	short loc_104D9
		mov	cx, es
		add	cx, 800h
		mov	es, cx
		assume es:nothing
		and	di, 7FFFh

loc_104D9:				; CODE XREF: DecompressData+Aj
		call	GetFileByte2
		add	dl, dl
		jb	short loc_104E6
		call	GetFileByte
		stosb
		jmp	short loc_104C9
; ---------------------------------------------------------------------------

loc_104E6:				; CODE XREF: DecompressData+1Dj
		call	GetFileByte2
		add	dl, dl
		jb	short loc_10528
		xor	cx, cx
		call	GetFileByte2
		add	dl, dl
		adc	cl, cl
		call	GetFileByte2
		add	dl, dl
		adc	cl, cl
		add	cx, 2
		call	GetFileByte
		xor	ah, ah

loc_10505:				; CODE XREF: DecompressData+7Ej
					; DecompressData+8Cj
		inc	ax
		push	si
		push	ds
		mov	bx, es
		mov	si, di
		sub	si, ax
		jnb	short loc_10514
		sub	bx, 1000h

loc_10514:				; CODE XREF: DecompressData+4Dj
		or	si, si
		jns	short loc_10520
		add	bx, 800h
		and	si, 7FFFh

loc_10520:				; CODE XREF: DecompressData+55j
		mov	ds, bx
		rep movsb
		pop	ds
		pop	si
		jmp	short loc_104C9
; ---------------------------------------------------------------------------

loc_10528:				; CODE XREF: DecompressData+2Aj
		call	GetFileByte
		mov	cl, al
		call	GetFileByte
		mov	ch, al
		mov	ax, cx
		shr	ax, 3
		and	cx, 7
		jz	short loc_10541
		add	cx, 2
		jmp	short loc_10505
; ---------------------------------------------------------------------------

loc_10541:				; CODE XREF: DecompressData+79j
		xchg	ax, cx
		call	GetFileByte
		xor	ah, ah
		xchg	ax, cx
		jcxz	short locret_1054F
		add	cx, 9
		jmp	short loc_10505
; ---------------------------------------------------------------------------

locret_1054F:				; CODE XREF: DecompressData+87j
		retn
DecompressData	endp


; =============== S U B	R O U T	I N E =======================================


GetFileByte2	proc near		; CODE XREF: DecompressData:loc_104D9p
					; DecompressData:loc_104E6p ...
		dec	dh
		jns	short locret_1055B
		call	GetFileByte
		mov	dl, al
		mov	dh, 7

locret_1055B:				; CODE XREF: GetFileByte2+2j
		retn
GetFileByte2	endp


; =============== S U B	R O U T	I N E =======================================


GetFileByte	proc near		; CODE XREF: DecompressData+1Fp
					; DecompressData+3Fp ...
		cmp	si, 2000h
		jb	short loc_10565
		call	ReadFileBlock

loc_10565:				; CODE XREF: GetFileByte+4j
		lodsb
		retn
GetFileByte	endp


; =============== S U B	R O U T	I N E =======================================


ReadFileBlock	proc near		; CODE XREF: DecompressDatap
					; GetFileByte+6p
		push	cx
		mov	si, dx
		xor	dx, dx
		mov	bx, [bp+6]
		mov	cx, 2000h
		mov	ah, 3Fh
		int	21h		; DOS -	2+ - READ FROM FILE WITH HANDLE
					; BX = file handle, CX = number	of bytes to read
					; DS:DX	-> buffer
		pop	cx
		jb	short loc_1057C
		xchg	dx, si
		retn
; ---------------------------------------------------------------------------

loc_1057C:				; CODE XREF: ReadFileBlock+10j
		mov	[bp+0],	ax
		jmp	loc_104A5
ReadFileBlock	endp

; ---------------------------------------------------------------------------

loc_10582:				; DATA XREF: seg000:off_134CDo
		push	bx
		push	cx
		push	dx
		cld
		lodsb
		mov	dl, al
		mov	dh, 8

loc_1058B:				; CODE XREF: seg000:05A1j seg000:05ABj ...
		call	sub_10643
		shl	dl, 1
		jb	short loc_105AD
		movsb
		or	si, si
		jnz	short loc_1059F
		mov	cx, ds
		add	cx, 1000h
		mov	ds, cx
		assume ds:nothing

loc_1059F:				; CODE XREF: seg000:0595j
		or	di, di
		jnz	short loc_1058B
		mov	cx, es
		add	cx, 1000h
		mov	es, cx
		assume es:nothing
		jmp	short loc_1058B
; ---------------------------------------------------------------------------

loc_105AD:				; CODE XREF: seg000:0590j
		call	sub_10643
		shl	dl, 1
		jb	short loc_10604
		xor	cx, cx
		call	sub_10643
		shl	dl, 1
		rcl	cl, 1
		call	sub_10643
		shl	dl, 1
		rcl	cl, 1
		add	cx, 2
		xor	ax, ax
		lodsb
		or	si, si
		jnz	short loc_105D6
		mov	bx, ds
		add	bx, 1000h
		mov	ds, bx
		assume ds:nothing

loc_105D6:				; CODE XREF: seg000:05CCj seg000:0629j ...
		inc	ax
		push	si
		push	ds
		mov	bx, es
		mov	si, di
		sub	si, ax
		jnb	short loc_105E5
		sub	bx, 1000h

loc_105E5:				; CODE XREF: seg000:05DFj
		mov	ds, bx
		assume ds:nothing

loc_105E7:				; CODE XREF: seg000:loc_105FEj
		movsb
		or	si, si
		jnz	short loc_105F3
		mov	ax, ds
		add	ax, 1000h
		mov	ds, ax
		assume ds:nothing

loc_105F3:				; CODE XREF: seg000:05EAj
		or	di, di
		jnz	short loc_105FE
		mov	ax, es
		add	ax, 1000h
		mov	es, ax
		assume es:nothing

loc_105FE:				; CODE XREF: seg000:05F5j
		loop	loc_105E7
		pop	ds
		assume ds:nothing
		pop	si
		jmp	short loc_1058B
; ---------------------------------------------------------------------------

loc_10604:				; CODE XREF: seg000:05B2j
		mov	bx, ds
		lodsb
		or	si, si
		jnz	short loc_10611
		add	bx, 1000h
		mov	ds, bx
		assume ds:nothing

loc_10611:				; CODE XREF: seg000:0609j
		mov	ah, [si]
		inc	si
		jnz	short loc_1061C
		add	bx, 1000h
		mov	ds, bx
		assume ds:nothing

loc_1061C:				; CODE XREF: seg000:0614j
		mov	cx, ax
		shr	ax, 3
		and	cx, 7
		jz	short loc_1062B
		add	cx, 2
		jmp	short loc_105D6
; ---------------------------------------------------------------------------

loc_1062B:				; CODE XREF: seg000:0624j
		mov	cl, [si]
		inc	si
		jnz	short loc_10636
		add	bx, 1000h
		mov	ds, bx
		assume ds:nothing

loc_10636:				; CODE XREF: seg000:062Ej
		or	cl, cl
		jz	short loc_1063F
		add	cx, 9
		jmp	short loc_105D6
; ---------------------------------------------------------------------------

loc_1063F:				; CODE XREF: seg000:0638j
		pop	dx
		pop	cx
		pop	bx
		retn

; =============== S U B	R O U T	I N E =======================================


sub_10643	proc near		; CODE XREF: seg000:loc_1058Bp
					; seg000:loc_105ADp ...
		dec	dh
		jns	short locret_10657
		lodsb
		mov	dl, al
		mov	dh, 7
		or	si, si
		jnz	short locret_10657
		mov	ax, ds
		add	ax, 1000h
		mov	ds, ax
		assume ds:nothing

locret_10657:				; CODE XREF: sub_10643+2j sub_10643+Bj
		retn
sub_10643	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_10658	proc near		; CODE XREF: LoadFile1+4Dp
					; LoadGSCFile+AFp ...

var_4		= word ptr -4
var_2		= word ptr -2

		push	cx
		push	dx
		push	bp
		mov	bp, sp
		sub	sp, 4
		xor	cx, cx
		xor	dx, dx
		mov	al, 1
		mov	ah, 42h
		int	21h		; DOS -	2+ - MOVE FILE READ/WRITE POINTER (LSEEK)
					; AL = method: offset from present location
		jb	short loc_1069B
		mov	[bp+var_4], ax
		mov	[bp+var_2], dx
		xor	dx, dx
		mov	al, 2
		mov	ah, 42h
		int	21h		; DOS -	2+ - MOVE FILE READ/WRITE POINTER (LSEEK)
					; AL = method: offset from end of file
		jb	short loc_1069B
		sub	ax, [bp+var_4]
		sbb	dx, [bp+var_2]
		push	dx
		push	ax
		mov	dx, [bp+var_4]
		mov	cx, [bp+var_2]
		xor	al, al
		mov	ah, 42h
		int	21h		; DOS -	2+ - MOVE FILE READ/WRITE POINTER (LSEEK)
					; AL = method: offset from beginning of	file
		jb	short loc_1069B
		pop	ax
		pop	bx
		mov	sp, bp
		pop	bp
		pop	dx
		pop	cx
		clc
		retn
; ---------------------------------------------------------------------------

loc_1069B:				; CODE XREF: sub_10658+12j
					; sub_10658+22j ...
		mov	sp, bp
		pop	bp
		pop	dx
		pop	cx
		stc
		retn
sub_10658	endp

; Input	parameters:
;   BX - file handle
;   CX - number	of segments to read
;   DS:DX - destination	buffer

; =============== S U B	R O U T	I N E =======================================


ReadRawFile	proc near		; CODE XREF: LoadFile1+74p
					; LoadGSCFile+DFp ...
		push	bx
		push	cx
		push	dx
		push	ds

loc_106A6:				; CODE XREF: ReadRawFile+20j
		cmp	cx, 0FF0h
		jb	short loc_106C4
		push	cx
		mov	cx, 0FF00h
		mov	ah, 3Fh
		int	21h		; DOS -	2+ - READ FROM FILE WITH HANDLE
					; BX = file handle, CX = number	of bytes to read
					; DS:DX	-> buffer
		pop	cx
		jb	short loc_106CF
		mov	ax, ds
		add	ax, 0FF0h
		mov	ds, ax
		assume ds:nothing
		sub	cx, 0FF0h
		jmp	short loc_106A6
; ---------------------------------------------------------------------------

loc_106C4:				; CODE XREF: ReadRawFile+8j
		shl	cx, 4
		mov	ah, 3Fh
		int	21h		; DOS -	2+ - READ FROM FILE WITH HANDLE
					; BX = file handle, CX = number	of bytes to read
					; DS:DX	-> buffer
		jb	short loc_106CF
		xor	ax, ax

loc_106CF:				; CODE XREF: ReadRawFile+13j
					; ReadRawFile+29j
		pop	ds
		assume ds:nothing
		pop	dx
		pop	cx
		pop	bx
		retn
ReadRawFile	endp

; ---------------------------------------------------------------------------
aDisk_id_sys	db ':\DISK_ID.SYS',0    ; DATA XREF: CheckDiskID+3Eo

; =============== S U B	R O U T	I N E =======================================


PrintInt_5DigDec proc near		; CODE XREF: sub_1180D:loc_11A33p
		push	ax
		push	bx
		push	cx
		push	dx
		push	bp
		sub	sp, 8
		mov	bp, sp
		or	ah, ah
		jns	short loc_106F7
		mov	byte ptr [bp+0], '-'
		inc	bp
		neg	ax

loc_106F7:				; CODE XREF: PrintInt_5DigDec+Cj
		push	10
		push	100
		push	1000
		push	10000
		mov	ch, 4
		xor	cl, cl

loc_10705:				; CODE XREF: PrintInt_5DigDec+3Cj
		xor	dx, dx
		pop	bx
		div	bx
		or	ax, ax
		jnz	short loc_10712
		or	cl, cl
		jz	short loc_1071A

loc_10712:				; CODE XREF: PrintInt_5DigDec+2Aj
		add	al, '0'
		mov	[bp+0],	al
		inc	bp
		mov	cl, 0FFh

loc_1071A:				; CODE XREF: PrintInt_5DigDec+2Ej
		mov	ax, dx
		dec	ch
		jnz	short loc_10705
		add	al, '0'
		mov	[bp+0],	al
		inc	bp
		mov	byte ptr [bp+0], 0
		mov	ax, sp
		mov	bx, ss
		call	DoSomePrint
		add	sp, 8
		pop	bp
		pop	dx
		pop	cx
		pop	bx
		pop	ax
		retn
PrintInt_5DigDec endp ;	sp-analysis failed


; =============== S U B	R O U T	I N E =======================================


PrintInt_Dec	proc near		; CODE XREF: sub_10A1D+30p
					; sub_10A1D+69p
		push	ax
		push	bx
		push	cx
		push	dx
		push	bp
		sub	sp, 8
		mov	bp, sp
		cmp	bx, 5
		jbe	short loc_1074C
		mov	bx, 5

loc_1074C:				; CODE XREF: PrintInt_Dec+Dj
		or	ah, ah
		jns	short loc_10757
		mov	byte ptr [bp+0], '-'
		inc	bp
		neg	ax

loc_10757:				; CODE XREF: PrintInt_Dec+14j
		mov	cx, bx
		dec	cl
		jz	short loc_10785
		push	10
		dec	cl
		jz	short loc_10773
		push	100
		dec	cl
		jz	short loc_10773
		push	1000
		dec	cl
		jz	short loc_10773
		push	10000

loc_10773:				; CODE XREF: PrintInt_Dec+27j
					; PrintInt_Dec+2Dj ...
		mov	cx, bx
		dec	cx

loc_10776:				; CODE XREF: PrintInt_Dec+49j
		xor	dx, dx
		pop	bx
		div	bx
		add	al, '0'
		mov	[bp+0],	al
		inc	bp
		mov	ax, dx
		loop	loc_10776

loc_10785:				; CODE XREF: PrintInt_Dec+21j
		add	al, '0'
		mov	[bp+0],	al
		inc	bp
		mov	byte ptr [bp+0], 0
		mov	ax, sp
		mov	bx, ss
		call	DoSomePrint
		add	sp, 8
		pop	bp
		pop	dx
		pop	cx
		pop	bx
		pop	ax
		retn
PrintInt_Dec	endp ; sp-analysis failed


; =============== S U B	R O U T	I N E =======================================


PrintInt_Hex	proc near		; CODE XREF: sub_10A1D+52p
					; seg000:IntB8p
		push	ax
		push	bx
		push	cx
		push	dx
		push	bp
		sub	sp, 8
		mov	bp, sp
		mov	cx, 4

loc_107AC:				; CODE XREF: PrintInt_Hex+24j
		rol	ax, 4
		mov	bl, al
		and	bl, 0Fh
		cmp	bl, 0Ah
		jb	short loc_107BC
		add	bl, 7

loc_107BC:				; CODE XREF: PrintInt_Hex+18j
		add	bl, '0'
		mov	[bp+0],	bl
		inc	bp
		loop	loc_107AC
		mov	byte ptr [bp+0], 0
		mov	ax, sp
		mov	bx, ss
		call	DoSomePrint
		add	sp, 8
		pop	bp
		pop	dx
		pop	cx
		pop	bx
		pop	ax
		retn
PrintInt_Hex	endp

; ---------------------------------------------------------------------------
		mov	byte ptr cs:PrintPos+1,	al
		mov	byte ptr cs:PrintPos, ah
		retn

; =============== S U B	R O U T	I N E =======================================


DoSomePrint	proc near		; CODE XREF: PrintInt_5DigDec+4Cp
					; PrintInt_Dec+59p ...
		pushf
		cld
		push	bx
		push	cx
		push	dx
		push	si
		push	di
		push	ds
		push	es
		mov	ds, bx
		mov	si, ax
		xor	ah, ah
		mov	al, byte ptr cs:PrintPos+1
		mov	cl, al
		add	ax, cs:word_1388A
		mov	bx, ax
		add	ax, ax
		add	ax, ax
		add	ax, bx
		shl	ax, 4
		mov	dx, ax
		add	dx, dx
		mov	cs:word_1388C, dx
		xor	bh, bh
		mov	bl, byte ptr cs:PrintPos
		mov	ch, bl
		add	ax, bx
		add	ax, ax
		mov	di, ax
		add	di, cs:word_1388A
		mov	ax, cs:word_13888
		add	ax, 0A000h
		mov	bx, ax
		add	ax, 200h
		mov	es, ax
		assume es:nothing

loc_10833:				; CODE XREF: DoSomePrint+81j
					; DoSomePrint+9Fj ...
		lodsb
		cmp	al, 20h
		jb	short loc_10889
		cmp	al, 80h
		jb	short loc_1084A
		cmp	al, 0A0h
		jnb	short loc_10843
		jmp	loc_1092E
; ---------------------------------------------------------------------------

loc_10843:				; CODE XREF: DoSomePrint+5Bj
		cmp	al, 0E0h
		jb	short loc_1084A
		jmp	loc_1092E
; ---------------------------------------------------------------------------

loc_1084A:				; CODE XREF: DoSomePrint+57j
					; DoSomePrint+62j
		xor	dh, dh
		mov	dl, cs:PrintColor
		mov	es:[di], dx
		mov	dx, es
		mov	es, bx
		assume es:nothing
		xor	ah, ah
		stosw
		mov	es, dx
		assume es:nothing
		inc	ch
		cmp	ch, cs:byte_13894
		jbe	short loc_10833
		mov	di, cs:word_1388C
		mov	ch, cs:byte_13892
		cmp	cl, cs:byte_13895
		jnb	short loc_10884
		inc	cl
		add	di, 0A0h
		mov	cs:word_1388C, di
		jmp	short loc_10833
; ---------------------------------------------------------------------------

loc_10884:				; CODE XREF: DoSomePrint+92j
		call	sub_109B3
		jmp	short loc_10833
; ---------------------------------------------------------------------------

loc_10889:				; CODE XREF: DoSomePrint+53j
		cmp	al, 0Dh
		jz	short loc_10898
		cmp	al, 0Ah
		jz	short loc_108AA
		cmp	al, 1Ah
		jz	short loc_108C7
		jmp	loc_1091B
; ---------------------------------------------------------------------------

loc_10898:				; CODE XREF: DoSomePrint+A8j
		mov	di, cs:word_1388C
		mov	ch, cs:byte_13892
		cmp	byte ptr [si], 0Ah
		jz	short loc_108A9
		jmp	short loc_10833
; ---------------------------------------------------------------------------

loc_108A9:				; CODE XREF: DoSomePrint+C2j
		inc	si

loc_108AA:				; CODE XREF: DoSomePrint+ACj
		cmp	cl, cs:byte_13895
		jnb	short loc_108C1
		inc	cl
		add	di, 0A0h
		add	cs:word_1388C, 0A0h
		jmp	loc_10833
; ---------------------------------------------------------------------------

loc_108C1:				; CODE XREF: DoSomePrint+CCj
		call	sub_109B3
		jmp	loc_10833
; ---------------------------------------------------------------------------

loc_108C7:				; CODE XREF: DoSomePrint+B0j
		push	bx
		push	cx
		push	dx
		push	di
		mov	dh, cs:byte_13894
		sub	dh, cs:byte_13892
		inc	dh
		mov	dl, cs:byte_13895
		sub	dl, cs:byte_13893
		inc	dl
		mov	di, cs:word_1388A
		mov	bx, 50h	; 'P'
		sub	bl, dh
		shl	bx, 1
		mov	ax, 20h	; ' '
		mov	ch, ah
		push	dx
		push	di

loc_108F6:				; CODE XREF: DoSomePrint+11Bj
		mov	cl, dh
		rep stosw
		add	di, bx
		dec	dl
		jnz	short loc_108F6
		pop	di
		pop	dx
		add	di, 2000h
		mov	al, cs:PrintColor

loc_1090A:				; CODE XREF: DoSomePrint+12Fj
		mov	cl, dh
		rep stosw
		add	di, bx
		dec	dl
		jnz	short loc_1090A
		pop	di
		pop	dx
		pop	cx
		pop	bx
		jmp	loc_10833
; ---------------------------------------------------------------------------

loc_1091B:				; CODE XREF: DoSomePrint+B2j
					; DoSomePrint+150j
		mov	byte ptr cs:PrintPos, ch
		mov	byte ptr cs:PrintPos+1,	cl
		pop	es
		assume es:nothing
		pop	ds
		pop	di
		pop	si
		pop	dx
		pop	cx
		pop	bx
		popf
		retn
; ---------------------------------------------------------------------------

loc_1092E:				; CODE XREF: DoSomePrint+5Dj
					; DoSomePrint+64j
		mov	dh, al
		lodsb
		cmp	al, 20h	; ' '
		jb	short loc_1091B
		mov	dl, al
		call	sub_13197
		mov	ax, dx
		sub	ah, 20h	; ' '
		xchg	ah, al
		cmp	ch, cs:byte_13894
		jb	short loc_10969
		mov	di, cs:word_1388C
		mov	ch, cs:byte_13892
		cmp	cl, cs:byte_13895
		jnb	short loc_10966
		inc	cl
		add	di, 0A0h ; '†'
		mov	cs:word_1388C, di
		jmp	short loc_10969
; ---------------------------------------------------------------------------

loc_10966:				; CODE XREF: DoSomePrint+174j
		call	sub_109B3

loc_10969:				; CODE XREF: DoSomePrint+163j
					; DoSomePrint+181j
		xor	dh, dh
		mov	dl, cs:PrintColor
		mov	es:[di], dx
		mov	es:[di+2], dx
		mov	dx, es
		mov	es, bx
		stosw
		or	al, 80h
		stosw
		mov	es, dx
		add	ch, 2
		cmp	ch, cs:byte_13894
		ja	short loc_1098E
		jmp	loc_10833
; ---------------------------------------------------------------------------

loc_1098E:				; CODE XREF: DoSomePrint+1A6j
		mov	di, cs:word_1388C
		mov	ch, cs:byte_13892
		cmp	cl, cs:byte_13895
		jnb	short loc_109AD
		inc	cl
		add	di, 0A0h ; '†'
		mov	cs:word_1388C, di
		jmp	loc_10833
; ---------------------------------------------------------------------------

loc_109AD:				; CODE XREF: DoSomePrint+1BAj
		call	sub_109B3
		jmp	loc_10833
DoSomePrint	endp


; =============== S U B	R O U T	I N E =======================================


sub_109B3	proc near		; CODE XREF: DoSomePrint:loc_10884p
					; DoSomePrint:loc_108C1p ...
		push	ds
		push	es
		pusha
		mov	ax, cs:word_13888
		add	ax, 0A000h
		mov	es, ax
		assume es:nothing
		mov	ds, ax
		assume ds:nothing
		mov	dh, cs:byte_13894
		sub	dh, cs:byte_13892
		inc	dh
		mov	dl, cs:byte_13895
		sub	dl, cs:byte_13893
		mov	di, cs:word_1388A
		push	dx
		xor	ch, ch

loc_109DF:				; CODE XREF: sub_109B3+3Cj
		mov	cl, dh
		mov	si, di
		add	si, 0A0h ; '†'
		mov	ax, si
		rep movsw
		mov	di, ax
		dec	dl
		jnz	short loc_109DF
		mov	cl, dh
		mov	ax, 20h	; ' '
		rep stosw
		mov	ax, es
		add	ax, 200h
		mov	es, ax
		assume es:nothing
		mov	ds, ax
		assume ds:nothing
		mov	di, cs:word_1388A
		pop	dx

loc_10A07:				; CODE XREF: sub_109B3+64j
		mov	cl, dh
		mov	si, di
		add	si, 0A0h ; '†'
		mov	ax, si
		rep movsw
		mov	di, ax
		dec	dl
		jnz	short loc_10A07
		popa
		pop	es
		assume es:nothing
		pop	ds
		assume ds:nothing
		retn
sub_109B3	endp


; =============== S U B	R O U T	I N E =======================================


sub_10A1D	proc near		; CODE XREF: seg000:35CCp
		sti
		mov	al, ds:536h
		test	al, 4
		jz	short loc_10A28
		jmp	loc_10AE9
; ---------------------------------------------------------------------------

loc_10A28:				; CODE XREF: sub_10A1D+6j
		test	al, 8
		jnz	short loc_10A2D
		retn
; ---------------------------------------------------------------------------

loc_10A2D:				; CODE XREF: sub_10A1D+Dj
		cli
		push	bx
		push	cx
		push	dx
		push	si
		call	sub_10B26
		xor	si, si

loc_10A37:				; CODE XREF: sub_10A1D+B8j
		push	si
		mov	cx, 64h	; 'd'
		xor	dx, dx

loc_10A3D:				; CODE XREF: sub_10A1D+7Bj
					; sub_10A1D+82j
		mov	cs:PrintColor, 41h ; 'A'
		mov	cs:PrintPos, dx
		mov	ax, si
		mov	bx, 4
		call	PrintInt_Dec
		mov	cs:PrintColor, 0E1h ; '·'
		mov	al, 3Ah	; ':'
		call	sub_10BA6
		mov	cs:PrintColor, 0A1h ; '°'
		mov	ax, si
		shl	ax, 1
		mov	bx, word ptr cs:scrRegMemPtr
		add	bx, ax
		mov	ax, cs:[bx]
		call	PrintInt_Hex
		mov	cs:PrintColor, 0E1h ; '·'
		or	ax, ax
		js	short loc_10A83
		push	ax
		mov	al, 20h	; ' '
		call	sub_10BA6
		pop	ax

loc_10A83:				; CODE XREF: sub_10A1D+5Dj
		mov	bx, 5
		call	PrintInt_Dec
		inc	si
		cmp	si, 400h
		jnb	short loc_10AA1
		dec	cx
		jz	short loc_10AA1
		inc	dh
		cmp	dh, 19h
		jb	short loc_10A3D
		xor	dh, dh
		add	dl, 13h
		jmp	short loc_10A3D
; ---------------------------------------------------------------------------

loc_10AA1:				; CODE XREF: sub_10A1D+71j
					; sub_10A1D+74j
		pop	si
		sti

loc_10AA3:				; CODE XREF: sub_10A1D+8Bj
		mov	al, ds:530h
		test	al, 0C0h
		jnz	short loc_10AA3

loc_10AAA:				; CODE XREF: sub_10A1D+9Fj
					; sub_10A1D+A3j ...
		mov	al, ds:530h
		or	al, al
		js	short loc_10ABE
		test	al, 40h
		jnz	short loc_10AC7
		mov	al, ds:52Ah
		test	al, 1
		jnz	short loc_10AD8
		jmp	short loc_10AAA
; ---------------------------------------------------------------------------

loc_10ABE:				; CODE XREF: sub_10A1D+92j
		or	si, si
		jz	short loc_10AAA
		sub	si, 100
		jmp	short loc_10AD0
; ---------------------------------------------------------------------------

loc_10AC7:				; CODE XREF: sub_10A1D+96j
		cmp	si, 1000
		jnb	short loc_10AAA
		add	si, 100

loc_10AD0:				; CODE XREF: sub_10A1D+A8j
		mov	al, 1Ah
		call	sub_10BA6
		jmp	loc_10A37
; ---------------------------------------------------------------------------

loc_10AD8:				; CODE XREF: sub_10A1D+9Dj
					; sub_10A1D+105j
		cli
		call	sub_10B6C
		sti

loc_10ADD:				; CODE XREF: sub_10A1D+C5j
		mov	al, ds:52Ah
		test	al, 1
		jnz	short loc_10ADD
		pop	si
		pop	dx
		pop	cx
		pop	bx
		retn
; ---------------------------------------------------------------------------

loc_10AE9:				; CODE XREF: sub_10A1D+8j
		cli
		push	bx
		push	cx
		push	dx
		push	si
		call	sub_10B26
		mov	cs:PrintColor, 0C1h ; '¡'
		mov	cs:PrintPos, 0
		mov	ax, word ptr cs:FilePathPtr
		mov	bx, word ptr cs:FilePathPtr+2
		call	DoSomePrint
		mov	cs:PrintPos, 100h
		mov	bx, word ptr cs:gscFilePtr+2
		mov	ax, 20h
		call	DoSomePrint
		sti

loc_10B1D:				; CODE XREF: sub_10A1D+107j
		mov	al, ds:52Ah
		test	al, 1
		jnz	short loc_10AD8
		jmp	short loc_10B1D
sub_10A1D	endp


; =============== S U B	R O U T	I N E =======================================


sub_10B26	proc near		; CODE XREF: sub_10A1D+15p
					; sub_10A1D+D1p
		mov	ax, cs:word_13888
		mov	cs:word_1139E, ax
		mov	ax, cs:PrintPos
		mov	cs:word_113A0, ax
		mov	al, cs:PrintColor
		mov	cs:byte_113A2, al
		mov	al, ds:54Ch
		mov	cs:byte_138D8, al
		mov	ah, 41h	; 'A'
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		mov	ax, 600Dh
		call	sub_10E8D
		mov	ax, 6070h
		call	sub_10E8D
		mov	al, 0
		call	sub_10EA5
		mov	al, 8
		call	sub_10EA5
		mov	cs:word_13888, 100h
		mov	al, 1Ah
		call	sub_10BA6
		retn
sub_10B26	endp


; =============== S U B	R O U T	I N E =======================================


sub_10B6C	proc near		; CODE XREF: sub_10A1D+BCp
		mov	al, 1Ah
		call	sub_10BA6
		mov	ah, 40h	; '@'
		test	cs:byte_138D8, 80h
		jnz	short loc_10B7D
		inc	al

loc_10B7D:				; CODE XREF: sub_10B6C+Dj
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		mov	ax, 6070h
		call	sub_10E8D
		xor	al, al
		call	sub_10EA5
		call	sub_10EA5
		mov	ax, cs:word_1139E
		mov	cs:word_13888, ax
		mov	ax, cs:word_113A0
		mov	cs:PrintPos, ax
		mov	al, cs:byte_113A2
		mov	cs:PrintColor, al
		retn
sub_10B6C	endp


; =============== S U B	R O U T	I N E =======================================


sub_10BA6	proc near		; CODE XREF: sub_10A1D+3Bp
					; sub_10A1D+62p ...
		push	ax
		push	bx
		xor	ah, ah
		push	ax
		mov	ax, sp
		mov	bx, ss
		call	DoSomePrint
		pop	ax
		pop	bx
		pop	ax
		retn
sub_10BA6	endp


; =============== S U B	R O U T	I N E =======================================


sub_10BB6	proc near		; CODE XREF: seg000:loc_10CA8p
					; seg000:loc_10CB2p ...
		push	bx
		push	ds
		lds	bx, cs:FilePathPtr
		cmp	byte ptr [bx+1], 3Ah ; ':'
		jz	short loc_10BC9
		mov	ah, 19h
		int	21h		; DOS -	GET DEFAULT DISK NUMBER
		jmp	short loc_10BCF
; ---------------------------------------------------------------------------

loc_10BC9:				; CODE XREF: sub_10BB6+Bj
		mov	al, [bx]
		and	al, 0DFh
		sub	al, 41h	; 'A'

loc_10BCF:				; CODE XREF: sub_10BB6+11j
		xor	ah, ah
		mov	bx, 1

loc_10BD4:				; CODE XREF: sub_10BB6+27j
		cmp	al, cs:DiskDriveIDs[bx]
		jz	short loc_10BE5
		dec	bl
		jns	short loc_10BD4
		mov	ax, 0FFFFh
		pop	ds
		pop	bx
		retn
; ---------------------------------------------------------------------------

loc_10BE5:				; CODE XREF: sub_10BB6+23j
		mov	al, bl
		pop	ds
		pop	bx
		retn
sub_10BB6	endp

; ---------------------------------------------------------------------------

IntBE_ShowErr:				; DATA XREF: SetupInts+2Eo
		pusha
		push	ds
		push	es
		push	cs
		pop	ds
		assume ds:seg000
		mov	ErrorID, ax
		mov	word_1384E, bx
		mov	ax, word_13888
		mov	word_113A4, ax
		mov	ax, PrintPos
		mov	word_113A6, ax
		mov	al, PrintColor
		mov	byte_113A3, al
		mov	word_13888, 0
		call	GenerateErrMsg
		xor	ax, ax
		mov	es, ax
		assume es:nothing
		mov	al, es:54Ch
		mov	cs:byte_138D8, al
		mov	ah, 41h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		mov	ax, 600Dh
		call	sub_10E8D
		sti
		mov	al, byte ptr ErrorID
		cmp	al, 0FFh
		jnz	short loc_10C32
		jmp	loc_10DAD
; ---------------------------------------------------------------------------

loc_10C32:				; CODE XREF: seg000:0C2Dj
		cmp	al, 1Ah
		jbe	short loc_10C51
		cmp	al, 20h	; ' '
		jnb	short loc_10C3D
		jmp	loc_10D5E
; ---------------------------------------------------------------------------

loc_10C3D:				; CODE XREF: seg000:0C38j
		cmp	al, 2Bh	; '+'
		jb	short loc_10C72
		cmp	al, 40h	; '@'
		jnb	short loc_10C48
		jmp	loc_10D5E
; ---------------------------------------------------------------------------

loc_10C48:				; CODE XREF: seg000:0C43j
		cmp	al, 45h	; 'E'
		jb	short loc_10C4F
		jmp	loc_10D5E
; ---------------------------------------------------------------------------

loc_10C4F:				; CODE XREF: seg000:0C4Aj
		jmp	short loc_10C8C
; ---------------------------------------------------------------------------

loc_10C51:				; CODE XREF: seg000:0C34j
		test	byte_138D5, 0FFh
		jnz	short loc_10C5B
		jmp	loc_10D5E
; ---------------------------------------------------------------------------

loc_10C5B:				; CODE XREF: seg000:0C56j
		mov	bx, offset aUndefinedCode ; "Undefined Code"
		mov	ah, byte ptr ErrorID

loc_10C62:				; CODE XREF: seg000:0C70j
		dec	ah
		jns	short loc_10C69
		jmp	loc_10D61
; ---------------------------------------------------------------------------

loc_10C69:				; CODE XREF: seg000:0C64j seg000:0C6Ej
		mov	al, [bx]
		inc	bx
		or	al, al
		jnz	short loc_10C69
		jmp	short loc_10C62
; ---------------------------------------------------------------------------

loc_10C72:				; CODE XREF: seg000:0C3Fj
		mov	bx, offset aOutOfMemory	; "ÉÅÉÇÉäÇ™ïsë´ÇµÇƒÇ¢Ç‹Ç∑"
		mov	ah, byte ptr ErrorID
		sub	ah, 20h

loc_10C7C:				; CODE XREF: seg000:0C8Aj
		dec	ah
		jns	short loc_10C83
		jmp	loc_10D61
; ---------------------------------------------------------------------------

loc_10C83:				; CODE XREF: seg000:0C7Ej seg000:0C88j
		mov	al, [bx]
		inc	bx
		or	al, al
		jnz	short loc_10C83
		jmp	short loc_10C7C
; ---------------------------------------------------------------------------

loc_10C8C:				; CODE XREF: seg000:loc_10C4Fj
		sub	al, 40h
		mov	bl, al
		xor	bh, bh
		shl	bx, 1
		add	bx, offset off_10C9E
		mov	ax, cs:[bx]
		jmp	ax
; ---------------------------------------------------------------------------
		db    0
off_10C9E	dw offset loc_10CB2	; 0 ; DATA XREF: seg000:0C94o
		dw offset loc_10CE5	; 1
		dw offset loc_10D46	; 2
		dw offset loc_10D59	; 3
		dw offset loc_10CA8	; 4
; ---------------------------------------------------------------------------

loc_10CA8:				; DATA XREF: seg000:off_10C9Eo
		call	sub_10BB6
		cmp	ax, 2
		jb	short loc_10CBD
		jmp	short loc_10D1F
; ---------------------------------------------------------------------------

loc_10CB2:				; DATA XREF: seg000:off_10C9Eo
		call	sub_10BB6
		cmp	ax, 2
		jb	short loc_10CBD
		jmp	loc_10D59
; ---------------------------------------------------------------------------

loc_10CBD:				; CODE XREF: seg000:0CAEj seg000:0CB8j
		mov	cx, ax
		mov	bx, ax
		mov	al, cs:byte_13865[bx]
		or	al, al
		jz	short loc_10CD6
		mov	bx, offset byte_1131D
		or	cl, cl
		jz	short loc_10CD4
		mov	bx, offset byte_1135D

loc_10CD4:				; CODE XREF: seg000:0CCFj
		jmp	short loc_10CFA
; ---------------------------------------------------------------------------

loc_10CD6:				; CODE XREF: seg000:0CC8j
		mov	al, byte_13864
		add	al, 50h	; 'P'
		mov	bx, (offset aInsertDisk2+9)
		mov	[bx], al
		mov	bx, offset aInsertDisk2	; "ÉhÉâÉCÉuÇOÇ…ê≥ÇµÇ¢ÉfÉBÉXÉNÇÉZÉbÉgÇµÇƒâ"...
		jmp	short loc_10CFA
; ---------------------------------------------------------------------------

loc_10CE5:				; DATA XREF: seg000:off_10C9Eo
		call	sub_10BB6
		cmp	ax, 2
		jnb	short loc_10D59
		mov	al, byte_13864
		add	al, 50h	; 'P'
		mov	bx, (offset aInsertDisk+9)
		mov	[bx], al
		mov	bx, offset aInsertDisk ; "ÉhÉâÉCÉuÇOÇ…ÉfÉBÉXÉNÇÉZÉbÉgÇµÇƒâ∫Ç≥Ç¢"

loc_10CFA:				; CODE XREF: seg000:loc_10CD4j
					; seg000:0CE3j	...
		call	sub_10DFB
		call	sub_10DCE

loc_10D00:				; CODE XREF: seg000:0D15j
		call	sub_131D7

loc_10D03:				; CODE XREF: seg000:0D08j
		call	sub_131EC
		test	al, 30h
		jz	short loc_10D03
		xor	ax, ax
		mov	al, cs:byte_13864
		call	sub_1021E
		or	ax, ax
		js	short loc_10D00
		mov	cx, 0FFFFh

loc_10D1A:				; CODE XREF: seg000:loc_10D1Aj
		loop	loc_10D1A
		call	sub_10E1B

loc_10D1F:				; CODE XREF: seg000:0CB0j
		cli
		mov	ah, 40h	; '@'
		test	cs:byte_138D8, 80h
		jnz	short loc_10D2C
		inc	al

loc_10D2C:				; CODE XREF: seg000:0D28j
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		push	cs
		pop	ds
		mov	ax, word_113A4
		mov	word_13888, ax
		mov	ax, word_113A6
		mov	PrintPos, ax
		mov	al, byte_113A3
		mov	PrintColor, al
		pop	es
		assume es:nothing
		pop	ds
		assume ds:nothing
		popa
		iret
; ---------------------------------------------------------------------------

loc_10D46:				; DATA XREF: seg000:off_10C9Eo
		call	sub_10BB6
		cmp	ax, 2
		jnb	short loc_10D59
		add	al, 60h	; '`'
		mov	byte ptr cs:aRemoveProtect+9, al
		mov	bx, offset aRemoveProtect ; "ÉhÉâÉCÉuÇOÇÃÉvÉçÉeÉNÉgÉVÅ[ÉãÇîrèúÇµÇƒâ"...
		jmp	short loc_10CFA
; ---------------------------------------------------------------------------

loc_10D59:				; CODE XREF: seg000:0CBAj seg000:0CEBj ...
		mov	bx, offset aBadInstall ; "ÉCÉìÉXÉgÅ[ÉãÇ™ê≥ÇµÇ≠çsÇÌÇÍÇƒÇ¢Ç‹ÇπÇÒ"
		jmp	short loc_10D61
; ---------------------------------------------------------------------------

loc_10D5E:				; CODE XREF: seg000:0C3Aj seg000:0C45j ...
		mov	bx, offset aErrorOccour	; "ÉGÉâÅ[Ç™î≠ê∂ÇµÇ‹ÇµÇΩ"

loc_10D61:				; CODE XREF: seg000:0C66j seg000:0C80j ...
		push	bx
		mov	ds:PrintColor, 45h
		mov	cx, 0A15h

loc_10D6A:				; CODE XREF: seg000:0D7Bj
		mov	bx, cs
		mov	ax, offset asc_10EF2 ; "				      "

loc_10D6F:
		mov	ds:PrintPos, cx
		call	DoSomePrint
		inc	ch
		cmp	ch, 0Dh
		jbe	short loc_10D6A
		mov	byte ptr ds:388Fh, 0Bh
		pop	di
		mov	dx, di
		push	cs
		pop	es
		assume es:seg000
		mov	cx, 0FFFFh
		xor	al, al
		repne scasb
		sar	cx, 1
		add	cx, 29h
		mov	byte ptr ds:PrintPos, cl
		mov	ax, dx
		call	DoSomePrint
		mov	ds:PrintPos, 0C17h
		mov	ax, offset aErrCode0000000 ; "ERR CODE:	00-0000-0000/00-00(0000)"
		mov	bx, cs
		call	DoSomePrint
		sti

loc_10DAB:				; CODE XREF: seg000:loc_10DABj
					; seg000:0DCCj
		jmp	short loc_10DAB
; ---------------------------------------------------------------------------

loc_10DAD:				; CODE XREF: seg000:0C2Fj
		push	cs
		pop	ds
		assume ds:seg000
		mov	PrintColor, 0A1h ; '°'
		mov	PrintPos, 0A21h
		mov	ax, offset aThankYou ; "Ç®îÊÇÍólÇ≈ÇµÇΩ"
		call	DoSomePrint
		mov	PrintPos, 0C15h
		mov	ax, offset aRemoveDiskTurnOff ;	"ÉfÉBÉXÉNÇéÊÇËèoÇµÇƒìdåπÇêÿÇ¡Çƒâ∫Ç≥Ç¢"
		call	DoSomePrint
		jmp	short loc_10DAB

; =============== S U B	R O U T	I N E =======================================


sub_10DCE	proc near		; CODE XREF: seg000:0CFDp
		mov	dx, bx
		mov	di, bx
		push	cs
		pop	es
		push	cs
		pop	ds
		cld
		mov	cx, 0FFFFh
		xor	ax, ax
		repne scasb
		sar	cx, 1
		add	cx, 29h	; ')'
		and	cl, 0FEh
		mov	byte ptr PrintPos, cl
		mov	byte ptr PrintPos+1, 0Ch
		mov	PrintColor, 0C1h ; '¡'
		mov	bx, cs
		mov	ax, dx
		jmp	DoSomePrint
sub_10DCE	endp


; =============== S U B	R O U T	I N E =======================================


sub_10DFB	proc near		; CODE XREF: seg000:loc_10CFAp
		mov	ax, 0A000h
		mov	ds, ax
		assume ds:nothing
		mov	si, 780h
		push	cs
		pop	es
		mov	di, 13A8h
		mov	cx, 50h
		rep movsw
		mov	ax, 0A200h
		mov	ds, ax
		assume ds:nothing
		mov	si, 780h
		mov	cx, 50h	; 'P'
		rep movsw
		retn
sub_10DFB	endp


; =============== S U B	R O U T	I N E =======================================


sub_10E1B	proc near		; CODE XREF: seg000:0D1Cp
		push	cs
		pop	ds
		assume ds:seg000
		mov	si, 13A8h
		mov	ax, 0A000h
		mov	es, ax
		assume es:nothing
		mov	di, 780h
		mov	cx, 50h
		rep movsw
		mov	ax, 0A200h
		mov	es, ax
		assume es:nothing
		mov	di, 780h
		mov	cx, 50h
		rep movsw
		retn
sub_10E1B	endp


; =============== S U B	R O U T	I N E =======================================


GenerateErrMsg	proc near		; CODE XREF: seg000:0C0Ep
		push	cs
		pop	es
		assume es:seg000
		mov	di, (offset aErrCode0000000+0Ah)
		mov	al, gsc10
		call	PutHex_2Dig	; put ??
		inc	di
		mov	ax, scrPos
		call	PutHex_4Dig
		inc	di
		mov	ax, scrCmdID
		call	PutHex_4Dig
		inc	di
		mov	al, byte ptr ErrorID
		call	PutHex_2Dig
		inc	di
		mov	al, byte ptr ErrorID+1
		call	PutHex_2Dig
		inc	di
		mov	ax, word_1384E
		call	PutHex_4Dig
		retn
GenerateErrMsg	endp


; =============== S U B	R O U T	I N E =======================================


PutHex_4Dig	proc near		; CODE XREF: GenerateErrMsg+Fp
					; GenerateErrMsg+16p ...
		xchg	ah, al
		call	PutHex_2Dig
		xchg	ah, al
PutHex_4Dig	endp ; sp-analysis failed


; =============== S U B	R O U T	I N E =======================================


PutHex_2Dig	proc near		; CODE XREF: GenerateErrMsg+8p
					; GenerateErrMsg+1Dp ...
		mov	bl, al
		shr	al, 4
		cmp	al, 0Ah
		jb	short loc_10E7C
		add	al, 7

loc_10E7C:				; CODE XREF: PutHex_2Dig+7j
		add	al, 30h	; '0'
		stosb
		mov	al, bl
		and	al, 0Fh
		cmp	al, 0Ah
		jb	short loc_10E89
		add	al, 7

loc_10E89:				; CODE XREF: PutHex_2Dig+14j
		add	al, 30h	; '0'
		stosb
		retn
PutHex_2Dig	endp


; =============== S U B	R O U T	I N E =======================================


sub_10E8D	proc near		; CODE XREF: sub_10B26+26p
					; sub_10B26+2Cp ...
		push	dx
		xor	dh, dh
		mov	dl, ah
		push	ax

loc_10E93:				; CODE XREF: sub_10E8D+Dj
		jmp	short $+2
		in	al, dx
		jmp	short $+2
		test	al, 2
		jnz	short loc_10E93
		jmp	short $+2
		pop	ax
		add	dl, 2
		out	dx, al
		pop	dx
		retn
sub_10E8D	endp


; =============== S U B	R O U T	I N E =======================================


sub_10EA5	proc near		; CODE XREF: sub_10B26+31p
					; sub_10B26+36p ...
		push	dx
		xor	dh, dh
		mov	dl, ah
		push	ax

loc_10EAB:				; CODE XREF: sub_10EA5+Dj
		jmp	short $+2
		in	al, dx
		jmp	short $+2
		test	al, 2
		jnz	short loc_10EAB
		jmp	short $+2
		pop	ax
		out	dx, al
		pop	dx
		retn
sub_10EA5	endp

; ---------------------------------------------------------------------------
aErrorOccour	db 'ÉGÉâÅ[Ç™î≠ê∂ÇµÇ‹ÇµÇΩ',0 ; DATA XREF: seg000:loc_10D5Eo
					; An error has occurred
aErrCode0000000	db 'ERR CODE: 00-0000-0000/00-00(0000)',0 ; DATA XREF: seg000:0DA2o
					; GenerateErrMsg+2o
asc_10EF2	db '                                      ',0 ; DATA XREF: seg000:0D6Co
aUndefinedCode	db 'Undefined Code',0   ; DATA XREF: seg000:loc_10C5Bo
aIllegalCode	db 'Illegal Code',0
aReservedFeatur	db 'Reserved Feature',0
aMissingOperand	db 'Missing Operand',0
aDataTypeError	db 'Data Type error',0
aDataRangeError	db 'Data Range error',0
aIllegalArrayPo	db 'Illegal Array Pointer',0
aUndefinedArray	db 'Undefined Array',0
aArrayAlreadyDe	db 'Array Already Defined',0
aSbStackOver	db 'SB Stack over',0
aSbStackEmpty	db 'SB Stack empty',0
aExpressionErro	db 'Expression error',0
aGraphicBufferE	db 'Graphic Buffer error',0
aZeroDevided	db 'Zero Devided',0
aDivisionRangeE	db 'Division Range error',0
aSystemError	db 'System error',0
aIllegalJumpPoi	db 'Illegal Jump Pointer',0
aSystemStackErr	db 'System Stack error',0
aChildProcessEr	db 'Child Process error',0
aUndefinedSyste	db 'Undefined System Function',0
aIllegalFileNam	db 'Illegal File Name',0
aIllegalDataSiz	db 'Illegal Data Size',0
aCelAnmBufferEr	db 'CEL/ANM Buffer error',0
aWindowTrouble	db 'WINDOW Trouble',0
aModuleNotRegis	db 'MODULE not Registed',0
aModuleNotLoadE	db 'MODULE not Load error',0
aModuleAlreadyR	db 'MODULE already Registed',0
aOutOfMemory	db 'ÉÅÉÇÉäÇ™ïsë´ÇµÇƒÇ¢Ç‹Ç∑',0 ; DATA XREF: seg000:loc_10C72o
					; Not enough memory
aBadModel	db 'Ç±ÇÃã@éÌÇ≈ÇÕìÆçÏÇ≈Ç´Ç‹ÇπÇÒ',0 ; This model does not work
aBadDOSVer	db 'Ç±ÇÃÇcÇnÇrè„Ç≈ÇÕìÆçÏÇ≈Ç´Ç‹ÇπÇÒ',0 ; This DOS cannot be used.
aCommError	db 'ÉRÉ~ÉÖÉjÉPÅ[ÉVÉáÉìÉGÉâÅ[Ç≈Ç∑',0 ; Communication error
aMemoryError	db 'ÉÅÉÇÉäÉGÉâÅ[Ç™î≠ê∂ÇµÇ‹ÇµÇΩ',0 ; A memory error has occurred
aBadInterrupt	db 'ïsê≥äÑÇËçûÇ›Ç™î≠ê∂ÇµÇ‹ÇµÇΩ',0 ; An illegal interrupt occurred.
aSysCanNotBoot	db 'ÉVÉXÉeÉÄÇ™ãNìÆÇ≈Ç´Ç‹ÇπÇÒ',0 ; System cannot boot
aSysException	db 'ÉVÉXÉeÉÄó·äOÇ≈Ç∑',0 ; System Exception
aBadDiskMnArea	db 'ÉfÉBÉXÉNä«óùóÃàÊÇ™ïsê≥Ç≈Ç∑',0 ; The disk management area is invalid.
aFileCorrupt	db 'ÉtÉ@ÉCÉãÇ™âÛÇÍÇƒÇ¢Ç‹Ç∑',0 ; The file is corrupted
aDataWriteError	db 'ÉfÅ[É^èëÇ´çûÇ›ÉGÉâÅ[Ç≈Ç∑',0 ; Data write error
aInsertDisk	db 'ÉhÉâÉCÉuÇOÇ…ÉfÉBÉXÉNÇÉZÉbÉgÇµÇƒâ∫Ç≥Ç¢',0 ; DATA XREF: seg000:0CF7o
					; seg000:0CF2o
					; Please insert	a disk into drive 0
aInsertDisk2	db 'ÉhÉâÉCÉuÇOÇ…ê≥ÇµÇ¢ÉfÉBÉXÉNÇÉZÉbÉgÇµÇƒâ∫Ç≥Ç¢',0
					; DATA XREF: seg000:0CE0o seg000:0CDBo
					; Please insert	the correct disk into drive 0.
aRemoveProtect	db 'ÉhÉâÉCÉuÇOÇÃÉvÉçÉeÉNÉgÉVÅ[ÉãÇîrèúÇµÇƒâ∫Ç≥Ç¢',0
					; DATA XREF: seg000:0D54o seg000:0D50w
					; Remove the protection	seal from drive	0
aOutOfDiskSpace	db 'ÉfÉBÉXÉNÇÃãÛÇ´óeó Ç™ïsë´ÇµÇƒÇ¢Ç‹Ç∑',0 ; Not enough free disk space
aBadInstall	db 'ÉCÉìÉXÉgÅ[ÉãÇ™ê≥ÇµÇ≠çsÇÌÇÍÇƒÇ¢Ç‹ÇπÇÒ',0 ; DATA XREF: seg000:loc_10D59o
					; The installation is not done correctly
aThankYou	db 'Ç®îÊÇÍólÇ≈ÇµÇΩ',0   ; DATA XREF: seg000:0DBAo
					; Thank	you for	your hard work
aRemoveDiskTurnOff db 'ÉfÉBÉXÉNÇéÊÇËèoÇµÇƒìdåπÇêÿÇ¡Çƒâ∫Ç≥Ç¢',0 ; DATA XREF: seg000:0DC6o
					; Remove the disk and turn off the power.
byte_1131D	db 40h dup(0)		; DATA XREF: ResolveString+Eo
					; seg000:0CCAo
byte_1135D	db 40h dup(0)		; DATA XREF: ResolveString+15o
					; seg000:0CD1o
		db  90h	; ê
word_1139E	dw 0			; DATA XREF: sub_10B26+4w
					; sub_10B6C+21r
word_113A0	dw 0			; DATA XREF: sub_10B26+Cw
					; sub_10B6C+29r
byte_113A2	db 0			; DATA XREF: sub_10B26+14w
					; sub_10B6C+31r
byte_113A3	db 0			; DATA XREF: seg000:0C05w seg000:0D3Cr
word_113A4	dw 0			; DATA XREF: seg000:0BF9w seg000:0D30r
word_113A6	dw 0			; DATA XREF: seg000:0BFFw seg000:0D36r
		db 148h	dup(0)
; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR start

LoadGSC:				; CODE XREF: start-1D39j
		mov	ax, 1
		xor	bx, bx
		push	cs
		pop	ds
		mov	dx, offset InitialFileName
		call	LoadGSCFile
		mov	es, ax
		assume es:nothing
		call	sub_133B4
; END OF FUNCTION CHUNK	FOR start
; START	OF FUNCTION CHUNK FOR sub_1180D

loadGscHeader:				; CODE XREF: sub_1180D-1D6j
					; sub_1180D+EFj ...
		push	ds
		push	cs
		pop	ds
		mov	ax, es:4
		mov	word ptr gscDataPtr, ax	; script data pointer
		mov	ax, es:6
		mov	word ptr gscDataPtr+2, ax ; script data	segment
		mov	ax, es:8
		mov	word ptr gscStrPtr, ax ; string	data pointer
		mov	ax, es:0Ah
		mov	word ptr gscStrPtr+2, ax ; string data segment
		mov	word ptr gscFilePtr, 0
		mov	word ptr gscFilePtr+2, es
		mov	ax, es:10h
		mov	gsc10, al
		mov	ax, es:12h
		mov	scrStackIdx, ax
		mov	word ptr somePtr+2, cs
		pop	ds
		assume ds:nothing
		sti

gscMainLoop:				; CODE XREF: sub_1180D-205j
					; sub_1180D-11Dj ...
		mov	word ptr cs:somePtr, offset byte_150B8
		mov	cx, 4
		push	si
		mov	bx, offset byte_138F4

loc_1154D:				; CODE XREF: sub_1180D-270j
		mov	al, cs:[bx]
		and	al, cs:[bx]
		mov	ah, al
		and	ah, 0E0h
		cmp	ah, 60h
		jz	short loc_1157D
		or	al, al
		jns	short loc_1159A
		test	al, 20h
		jnz	short loc_1157D
		push	bx
		push	cx
		mov	si, cs:[bx+2]
		call	scrEvalExpr
		pop	cx
		pop	bx
		mov	cs:[bx+4], ax
		or	ax, ax
		mov	al, cs:[bx]
		jz	short loc_11597
		or	al, 20h

loc_1157D:				; CODE XREF: sub_1180D-2B2j
					; sub_1180D-2AAj
		test	al, 40h
		jz	short loc_11597
		and	al, 1Fh
		mov	cs:[bx], al
		mov	si, ax
		mov	ax, cs:[bx+6]
		dec	si
		and	si, 3
		add	si, si
		jmp	word ptr cs:scrJumpTable[si]
; ---------------------------------------------------------------------------

loc_11597:				; CODE XREF: sub_1180D-294j
					; sub_1180D-28Ej
		mov	cs:[bx], al

loc_1159A:				; CODE XREF: sub_1180D-2AEj
		add	bx, 8
		loop	loc_1154D
		pop	si

loc_115A0:				; CODE XREF: sub_1180D:loc_1180Aj
		mov	word ptr cs:somePtr, offset byte_150B8

loc_115A7:				; CODE XREF: sub_1180D-254j
		mov	cs:scrPos, si
		xor	ah, ah
		lodsb			; get script command
		mov	cs:scrCmdID, ax
		or	al, al
		jz	short loc_1160B
		cmp	al, 3
		jz	short loc_115A7
		cmp	al, 0A0h
		jnb	short loc_115F0
		sub	al, 80h
		cmp	al, 20h
		jnb	short loc_115CE
		shl	al, 1
		mov	bx, ax
		jmp	cs:scrJumpTable80[bx] ;	jump table for commands	80h..9Fh
; ---------------------------------------------------------------------------

loc_115CE:				; CODE XREF: sub_1180D-24Aj
					; scrEvalExpr+7Fj ...
		mov	al, 1
		int	0BEh		; used by BASIC	while in interpreter

loc_115D2:				; CODE XREF: sub_11FF9:loc_12042j
		mov	al, 0
		int	0BEh		; used by BASIC	while in interpreter
; ---------------------------------------------------------------------------
scrJumpTable:				; DATA XREF: sub_1180D-27Br
		dw offset loc_115DE	; 0
		dw offset loc_115E7	; 1
		dw offset loc_11709	; 2
		dw offset loc_11709	; 3
; ---------------------------------------------------------------------------

loc_115DE:				; DATA XREF: sub_1180D:scrJumpTableo
		pop	si
		mov	cs:scrPos, si
		jmp	loc_116EA
; END OF FUNCTION CHUNK	FOR sub_1180D
; ---------------------------------------------------------------------------

loc_115E7:				; DATA XREF: sub_1180D:scrJumpTableo
		pop	si
		mov	cs:scrPos, si
		jmp	loc_1170E
; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_1180D

loc_115F0:				; CODE XREF: sub_1180D-250j
		cmp	al, 0D0h
		jb	short loc_11601
		cmp	al, 0F0h
		jnb	short loc_115FE
		mov	ah, 0F0h
		sub	al, 0D0h
		jmp	short loc_11601
; ---------------------------------------------------------------------------

loc_115FE:				; CODE XREF: sub_1180D-217j
		mov	ah, al
		lodsb

loc_11601:				; CODE XREF: sub_1180D-21Bj
					; sub_1180D-211j
		mov	cs:scrCmdID, ax
		call	scrA0
		jmp	gscMainLoop
; ---------------------------------------------------------------------------

loc_1160B:				; CODE XREF: sub_1180D-258j
					; sub_1180D:loc_1193Bj
		mov	cs:word_13844, 0
		les	di, cs:gscFilePtr
		mov	dx, es:[di+2]
		or	dx, dx
		jz	short loc_1163A
		mov	ah, 49h
		int	21h		; DOS -	2+ - FREE MEMORY
					; ES = segment address of area to be freed
		call	sub_11ADF
		mov	es, dx
		lds	si, es:[di+0Ch]
		push	si
		push	ds
		push	es
		mov	ah, 2
		call	sub_11DD7
		pop	es
		pop	ds
		pop	si
		jmp	loadGscHeader
; ---------------------------------------------------------------------------

loc_1163A:				; CODE XREF: sub_1180D-1F0j
					; sub_1180D+13Ej ...
		mov	ah, 3
		call	sub_11DD7
		mov	dl, cs:byte_13867
		and	dl, 2
		call	sub_12FCA
		jmp	ExitDOS
; END OF FUNCTION CHUNK	FOR sub_1180D

; =============== S U B	R O U T	I N E =======================================


sub_1164D	proc near		; CODE XREF: seg000:34AAp
					; DATA XREF: seg000:off_134CDo
		push	bx
		push	si
		mov	cx, 4
		mov	ds, word ptr cs:gscDataPtr+2
		mov	bx, offset byte_138F4
		xor	dx, dx

loc_1165C:				; CODE XREF: sub_1164D+45j
		mov	al, cs:[bx]
		and	al, cs:[bx]
		mov	ah, al
		and	ah, 0C0h
		cmp	ah, 40h	; '@'
		jnz	short loc_1168F
		or	dl, al
		test	al, 20h
		jnz	short loc_1168F
		push	bx
		push	cx
		mov	si, cs:[bx+2]
		call	scrEvalExpr
		pop	cx
		pop	bx
		mov	cs:[bx+4], ax
		or	ax, ax
		mov	al, cs:[bx]
		jz	short loc_1168C
		or	al, 20h
		or	dl, al

loc_1168C:				; CODE XREF: sub_1164D+39j
		mov	cs:[bx], al

loc_1168F:				; CODE XREF: sub_1164D+1Dj
					; sub_1164D+23j
		add	bx, 8
		loop	loc_1165C
		and	dl, 20h
		add	dl, 0FFh
		pop	si
		pop	bx
		retn
sub_1164D	endp

; ---------------------------------------------------------------------------
scrJumpTable80	dw offset scr80_Jump	; 0 ; DATA XREF: sub_1180D-244r
		dw offset scr81_CondJump; 1
		dw offset scr_Invalid	; 2
		dw offset src83_Call	; 3
		dw offset scr84_RetJump	; 4
		dw offset scr85_Return	; 5
		dw offset scr86		; 6
		dw offset scr87_CallGSC	; 7
		dw offset loc_1193B	; 8
		dw offset loc_1193E	; 9
		dw offset scr8A		; 0Ah
		dw offset loc_119D2	; 0Bh
		dw offset scr_Invalid	; 0Ch
		dw offset scr_Invalid	; 0Dh
		dw offset loc_11A07	; 0Eh
		dw offset loc_11A48	; 0Fh
		dw offset loc_11754	; 10h
		dw offset loc_11763	; 11h
		dw offset scr92_LoadMDL	; 12h
		dw offset scr93_LoadGSC	; 13h
		dw offset loc_118B5	; 14h
		dw offset loc_118C3	; 15h
		dw offset scr_Invalid	; 16h
		dw offset scr_Invalid	; 17h
		dw offset scr_Invalid	; 18h
		dw offset scr_Invalid	; 19h
		dw offset scr_Invalid	; 1Ah
		dw offset scr_Invalid	; 1Bh
		dw offset scr_Invalid	; 1Ch
		dw offset loc_117EC	; 1Dh
		dw offset loc_117B5	; 1Eh
		dw offset scr_Invalid	; 1Fh
; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_1180D

scr_Invalid:				; CODE XREF: sub_1180D-244j
					; DATA XREF: seg000:scrJumpTable80o
		mov	ax, 0FF00h
		int	0BEh		; used by BASIC	while in interpreter

scr84_RetJump:				; CODE XREF: sub_1180D-244j
					; DATA XREF: seg000:scrJumpTable80o
		dec	cs:scrStackIdx
		js	short loc_11735

scr80_Jump:				; CODE XREF: sub_1180D-244j
					; DATA XREF: seg000:scrJumpTable80o
		lodsw

loc_116EA:				; CODE XREF: sub_1180D-229j
		or	ax, ax
		jz	short loc_11709
		mov	si, ax
		jmp	gscMainLoop
; ---------------------------------------------------------------------------

scr81_CondJump:				; CODE XREF: sub_1180D-244j
					; DATA XREF: seg000:scrJumpTable80o
		lodsw			; read jump destination
		mov	dx, ax
		or	ax, ax
		jz	short loc_11709
		call	scrEvalExpr
		or	ax, ax
		jz	short loc_11704	; result is 0 -> jump
		jmp	gscMainLoop	; else ignore
; ---------------------------------------------------------------------------

loc_11704:				; CODE XREF: sub_1180D-10Ej
		mov	si, dx
		jmp	gscMainLoop
; ---------------------------------------------------------------------------

loc_11709:				; CODE XREF: sub_1180D-121j
					; sub_1180D-115j ...
		mov	al, 10h
		int	0BEh		; used by BASIC	while in interpreter

src83_Call:				; CODE XREF: sub_1180D-244j
					; DATA XREF: seg000:scrJumpTable80o
		lodsw

loc_1170E:				; CODE XREF: seg000:15EDj
		mov	bx, cs:scrStackIdx
		cmp	bx, 10h
		jnb	short loc_11731
		inc	cs:scrStackIdx
		mov	es, word ptr cs:gscFilePtr+2
		or	ax, ax
		jz	short loc_11709
		shl	bx, 1
		mov	es:[bx+40h], si
		mov	si, ax
		jmp	gscMainLoop
; ---------------------------------------------------------------------------

loc_11731:				; CODE XREF: sub_1180D-F7j
		mov	al, 9
		int	0BEh		; used by BASIC	while in interpreter

loc_11735:				; CODE XREF: sub_1180D-126j
					; sub_1180D-CEj
		mov	al, 0Ah
		int	0BEh		; used by BASIC	while in interpreter

scr85_Return:				; CODE XREF: sub_1180D-244j
					; DATA XREF: seg000:scrJumpTable80o
		mov	bx, cs:scrStackIdx
		dec	bx
		js	short loc_11735
		mov	cs:scrStackIdx,	bx
		mov	es, word ptr cs:gscFilePtr+2
		shl	bx, 1
		mov	si, es:[bx+40h]
		jmp	gscMainLoop
; ---------------------------------------------------------------------------

loc_11754:				; CODE XREF: sub_1180D-244j
					; DATA XREF: seg000:scrJumpTable80o
		lodsw
		mov	dx, ax
		call	scrEvalExpr
		mov	cs:word_13832, ax
		mov	si, dx
		jmp	gscMainLoop
; ---------------------------------------------------------------------------

loc_11763:				; CODE XREF: sub_1180D-244j
					; DATA XREF: seg000:scrJumpTable80o
		xor	ax, ax
		lodsb
		cmp	al, 6
		jnb	short loc_1177E
		push	ax
		lodsw
		mov	dx, ax
		call	scrEvalExpr
		pop	bx
		mov	cx, cs:word_13832
		shl	bx, 1
		jmp	word ptr cs:loc_11782[bx]
; ---------------------------------------------------------------------------

loc_1177E:				; CODE XREF: sub_1180D-A5j
		mov	al, 1
		int	0BEh		; used by BASIC	while in interpreter

loc_11782:				; DATA XREF: sub_1180D-94r
		mov	ss, word ptr [bx]
		xchg	ax, di
		pop	ss
		mov	ds:0AF17h, ax
		pop	ss
		popf
		pop	ss
		test	ax, 3B17h	; CODE XREF: sub_1180D-94j

loc_1178F:				; CODE XREF: sub_1180D-74j
					; sub_1180D-6Ej ...
		sal	word ptr [di+2], 8Bh

loc_11793:				; CODE XREF: sub_1180D-72j
					; sub_1180D-6Cj ...
		repne jmp gscMainLoop
; ---------------------------------------------------------------------------

loc_11797:				; CODE XREF: sub_1180D-94j
		cmp	ax, cx
		jnz	short near ptr loc_1178F+3
		jmp	short near ptr loc_11793+1
; ---------------------------------------------------------------------------

loc_1179D:				; CODE XREF: sub_1180D-94j
		cmp	cx, ax
		jl	short near ptr loc_1178F+3
		jmp	short near ptr loc_11793+1
; ---------------------------------------------------------------------------

loc_117A3:				; CODE XREF: sub_1180D-94j
		cmp	cx, ax
		jg	short near ptr loc_1178F+3
		jmp	short near ptr loc_11793+1
; ---------------------------------------------------------------------------

loc_117A9:				; CODE XREF: sub_1180D-94j
		cmp	cx, ax
		jle	short near ptr loc_1178F+3
		jmp	short near ptr loc_11793+1
; END OF FUNCTION CHUNK	FOR sub_1180D
; ---------------------------------------------------------------------------
		cmp	cx, ax
		jge	short near ptr loc_1178F+3
		jmp	short near ptr loc_11793+1
; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_1180D

loc_117B5:				; CODE XREF: sub_1180D-244j
					; DATA XREF: seg000:scrJumpTable80o
		inc	si
		call	sub_1180D
		inc	si
		mov	cs:[bx+2], si
		push	bx
		call	scrEvalExpr
		pop	bx
		lodsb
		mov	ah, 1
		cmp	al, 80h	; 'Ä'
		jz	short loc_117D0
		inc	ah
		cmp	al, 83h	; 'É'
		jnz	short loc_117E8

loc_117D0:				; CODE XREF: sub_1180D-45j
		mov	cs:[bx], ah
		mov	word ptr cs:[bx+4], 0
		lodsw
		or	ax, ax
		jnz	short loc_117E1
		jmp	loc_11709
; ---------------------------------------------------------------------------

loc_117E1:				; CODE XREF: sub_1180D-31j
		mov	cs:[bx+6], ax
		jmp	gscMainLoop
; ---------------------------------------------------------------------------

loc_117E8:				; CODE XREF: sub_1180D-3Fj
		mov	al, 1
		int	0BEh		; used by BASIC	while in interpreter

loc_117EC:				; CODE XREF: sub_1180D-244j
					; DATA XREF: seg000:scrJumpTable80o
		call	sub_1180D
		mov	ah, cs:[bx]
		lodsb
		ror	al, 2
		and	al, 0C0h
		jnz	short loc_117FD
		and	ah, 0DFh

loc_117FD:				; CODE XREF: sub_1180D-15j
		test	ah, 0Fh
		jz	short loc_1180A
		and	ah, 3Fh
		or	al, ah
		mov	cs:[bx], al

loc_1180A:				; CODE XREF: sub_1180D-Dj
		jmp	loc_115A0
; END OF FUNCTION CHUNK	FOR sub_1180D

; =============== S U B	R O U T	I N E =======================================


sub_1180D	proc near		; CODE XREF: sub_1180D-57p
					; sub_1180D:loc_117ECp

; FUNCTION CHUNK AT 1502 SIZE 000000E5 BYTES
; FUNCTION CHUNK AT 15F0 SIZE 0000005D BYTES
; FUNCTION CHUNK AT 16DD SIZE 000000D2 BYTES
; FUNCTION CHUNK AT 17B5 SIZE 00000058 BYTES
; FUNCTION CHUNK AT 3110 SIZE 00000026 BYTES

		call	scrEvalExpr
		cmp	ax, 3
		ja	short loc_1181E
		shl	ax, 3
		mov	bx, offset byte_138F4
		add	bx, ax
		retn
; ---------------------------------------------------------------------------

loc_1181E:				; CODE XREF: sub_1180D+6j
		mov	al, 5
		int	0BEh		; used by BASIC	while in interpreter

scr86:					; CODE XREF: sub_1180D-244j
					; DATA XREF: seg000:scrJumpTable80o
		call	scrEvalExpr
		mov	es, bx
		mov	di, ax
		inc	si
		mov	dl, cl
		cmp	dl, 0Bh
		jz	short loc_11839
		sub	dl, 4
		cmp	dl, 3
		jnb	short loc_118B1

loc_11839:				; CODE XREF: sub_1180D+22j
		call	scrEvalExpr
		or	cl, cl
		js	short loc_118B1
		cmp	dl, 1
		ja	short loc_11894
		jz	short loc_11860
		cmp	cl, 5
		jz	short loc_11850
		stosw
		jmp	gscMainLoop
; ---------------------------------------------------------------------------

loc_11850:				; CODE XREF: sub_1180D+3Dj
		mov	cx, ds
		mov	ds, bx
		mov	bx, ax
		xor	ah, ah
		mov	al, [bx]
		stosw
		mov	ds, cx
		jmp	gscMainLoop
; ---------------------------------------------------------------------------

loc_11860:				; CODE XREF: sub_1180D+38j
		cmp	cl, 4
		jb	short loc_1186C
		cmp	cl, 5
		jbe	short loc_11870
		jmp	short loc_1187E
; ---------------------------------------------------------------------------

loc_1186C:				; CODE XREF: sub_1180D+56j
		stosb
		jmp	gscMainLoop
; ---------------------------------------------------------------------------

loc_11870:				; CODE XREF: sub_1180D+5Bj
		mov	cx, ds
		mov	ds, bx
		mov	bx, ax
		mov	al, [bx]
		stosb
		mov	ds, cx
		jmp	gscMainLoop
; ---------------------------------------------------------------------------

loc_1187E:				; CODE XREF: sub_1180D+5Dj
		mov	cx, ds
		mov	ds, bx
		mov	bx, si
		mov	si, ax
		cld

loc_11887:				; CODE XREF: sub_1180D+7Ej
		lodsb
		stosb
		or	al, al
		jnz	short loc_11887
		mov	si, bx
		mov	ds, cx
		jmp	gscMainLoop
; ---------------------------------------------------------------------------

loc_11894:				; CODE XREF: sub_1180D+36j
		mov	cx, ds
		mov	ds, bx
		mov	bx, si
		mov	si, ax
		mov	ax, 0FF00h
		cld

loc_118A0:				; CODE XREF: sub_1180D+9Aj
		cmp	[si], al
		jz	short loc_118A9
		movsb
		dec	ah
		jnz	short loc_118A0

loc_118A9:				; CODE XREF: sub_1180D+95j
		stosb
		mov	si, bx
		mov	ds, cx
		jmp	gscMainLoop
; ---------------------------------------------------------------------------

loc_118B1:				; CODE XREF: sub_1180D+2Aj
					; sub_1180D+31j
		mov	al, 4
		int	0BEh		; used by BASIC	while in interpreter

loc_118B5:				; CODE XREF: sub_1180D-244j
					; DATA XREF: seg000:scrJumpTable80o
		call	scrEvalExpr
		mov	es, bx
		mov	di, ax
		inc	si
		lodsw
		inc	ax
		stosw
		jmp	gscMainLoop
; ---------------------------------------------------------------------------

loc_118C3:				; CODE XREF: sub_1180D-244j
					; sub_1180D+BEj
					; DATA XREF: ...
		call	scrEvalExpr
		or	cl, cl
		js	short loc_118CD
		inc	si
		jmp	short loc_118C3
; ---------------------------------------------------------------------------

loc_118CD:				; CODE XREF: sub_1180D+BBj
		jmp	gscMainLoop
; ---------------------------------------------------------------------------

scr87_CallGSC:				; CODE XREF: sub_1180D-244j
					; DATA XREF: seg000:scrJumpTable80o
		call	scrEvalExpr
		mov	dx, ax
		mov	es, word ptr cs:gscFilePtr+2
		mov	es:0Ch,	si
		mov	word ptr es:0Eh, ds
		mov	ax, cs:scrStackIdx
		mov	es:12h,	ax
		inc	cs:gsc10
		mov	ds, bx
		mov	bx, es
		xor	ax, ax
		call	LoadGSCFile
		mov	es, ax
		jmp	loadGscHeader
; ---------------------------------------------------------------------------

scr93_LoadGSC:				; CODE XREF: sub_1180D-244j
					; DATA XREF: seg000:scrJumpTable80o
		call	scrEvalExpr
		push	ax
		push	bx
		les	di, cs:gscFilePtr
		mov	dx, es:[di+2]
		mov	ah, 49h
		int	21h		; DOS -	2+ - FREE MEMORY
					; ES = segment address of area to be freed
		call	sub_11ADF
		push	dx
		mov	ah, 2
		call	sub_11DD7
		pop	bx
		pop	ds
		pop	dx
		xor	ax, ax
		call	LoadGSCFile
		mov	es, ax
		jmp	loadGscHeader
; ---------------------------------------------------------------------------

scr92_LoadMDL:				; CODE XREF: sub_1180D-244j
					; DATA XREF: seg000:scrJumpTable80o
		call	scrEvalExpr	; get string offset into AX
		push	si
		push	ds
		mov	dx, ax
		mov	ds, bx
		mov	ax, 1
		call	LoadMDL
		pop	ds
		pop	si
		jmp	gscMainLoop
; ---------------------------------------------------------------------------

loc_1193B:				; CODE XREF: sub_1180D-244j
					; DATA XREF: seg000:scrJumpTable80o
		jmp	loc_1160B
; ---------------------------------------------------------------------------

loc_1193E:				; CODE XREF: sub_1180D-244j
					; DATA XREF: seg000:scrJumpTable80o
		call	scrEvalExpr
		or	cl, cl
		jns	short loc_11947
		xor	ax, ax

loc_11947:				; CODE XREF: sub_1180D+136j
		mov	cs:word_13844, ax
		jmp	loc_1163A
; ---------------------------------------------------------------------------

scr8A:					; CODE XREF: sub_1180D-244j
					; DATA XREF: seg000:scrJumpTable80o
		call	scrEvalExpr
		xor	dh, dh
		or	ax, ax
		jz	short loc_11959
		mov	dh, 2

loc_11959:				; CODE XREF: sub_1180D+148j
		lodsb
		cmp	al, 1
		jz	short loc_11962
		mov	al, 1
		int	0BEh		; used by BASIC	while in interpreter

loc_11962:				; CODE XREF: sub_1180D+14Fj
					; sub_1180D+1B8j
		lodsb
		cmp	al, 0Fh
		jnz	short loc_119CE
		lodsb
		mov	dl, al
		call	scrEvalExpr	; get number of	bytes to allocate
		mov	cx, 1000h
		or	ax, ax
		jz	short loc_1197E
		add	ax, 0Fh		; round	up to 0x10 bytes
		jb	short loc_1197E
		shr	ax, 4		; convert to segments
		mov	cx, ax

loc_1197E:				; CODE XREF: sub_1180D+165j
					; sub_1180D+16Aj
		mov	bx, cs:word_13806
		xor	ah, ah
		mov	al, dl
		add	ax, ax
		add	bx, ax
		test	word ptr cs:[bx], 0FFFFh
		jz	short loc_11996
		mov	al, 8
		int	0BEh		; used by BASIC	while in interpreter

loc_11996:				; CODE XREF: sub_1180D+183j
		push	bx
		mov	bx, cx
		inc	bx
		mov	al, dh
		call	AllocFileMem
		jnb	short loc_119A4
		jmp	loc_11B25
; ---------------------------------------------------------------------------

loc_119A4:				; CODE XREF: sub_1180D+192j
		pop	bx
		mov	cs:[bx], ax
		push	ds
		mov	ds, ax
		xor	bx, bx
		mov	[bx], cx
		mov	[bx+2],	bl
		mov	[bx+3],	dh
		mov	[bx+4],	bx
		mov	[bx+6],	bx
		mov	[bx+8],	bx
		mov	[bx+0Ah], bx
		pop	ds
		lodsb
		cmp	al, 1
		jz	short loc_11962
		cmp	al, 3
		jnz	short loc_119CE
		jmp	gscMainLoop
; ---------------------------------------------------------------------------

loc_119CE:				; CODE XREF: sub_1180D+158j
					; sub_1180D+1BCj
		mov	al, 1
		int	0BEh		; used by BASIC	while in interpreter

loc_119D2:				; CODE XREF: sub_1180D-244j
					; sub_1180D+1EDj
					; DATA XREF: ...
		lodsb
		cmp	al, 0Fh
		jnz	short loc_11A03
		xor	ax, ax
		lodsb
		shl	ax, 1
		mov	bx, cs:word_13806
		add	bx, ax
		mov	ax, cs:[bx]
		mov	word ptr cs:[bx], 0
		or	ax, ax
		jz	short loc_119F7
		push	es
		mov	es, ax
		mov	ah, 49h
		int	21h		; DOS -	2+ - FREE MEMORY
					; ES = segment address of area to be freed
		pop	es

loc_119F7:				; CODE XREF: sub_1180D+1E0j
		lodsb
		cmp	al, 1
		jz	short loc_119D2
		cmp	al, 3
		jnz	short loc_11A03
		jmp	gscMainLoop
; ---------------------------------------------------------------------------

loc_11A03:				; CODE XREF: sub_1180D+1C8j
					; sub_1180D+1F1j
		mov	al, 1
		int	0BEh		; used by BASIC	while in interpreter

loc_11A07:				; CODE XREF: sub_1180D-244j
					; sub_1180D+231j
					; DATA XREF: ...
		call	scrEvalExpr
		cmp	cl, 4
		jb	short loc_11A33
		cmp	cl, 5
		jz	short loc_11A2A
		cmp	cl, 6
		jz	short loc_11A38
		cmp	cl, 7
		jz	short loc_11A38
		or	cl, cl
		js	short loc_11A26
		mov	al, 4
		int	0BEh		; used by BASIC	while in interpreter

loc_11A26:				; CODE XREF: sub_1180D+213j
		mov	al, 3
		int	0BEh		; used by BASIC	while in interpreter

loc_11A2A:				; CODE XREF: sub_1180D+205j
		mov	es, bx
		mov	bx, ax
		xor	ah, ah
		mov	al, es:[bx]

loc_11A33:				; CODE XREF: sub_1180D+200j
		call	PrintInt_5DigDec
		jmp	short loc_11A3B
; ---------------------------------------------------------------------------

loc_11A38:				; CODE XREF: sub_1180D+20Aj
					; sub_1180D+20Fj
		call	DoSomePrint

loc_11A3B:				; CODE XREF: sub_1180D+229j
		lodsb
		cmp	al, 1
		jz	short loc_11A07
		cmp	al, 3
		jz	short loc_11A45
		dec	si

loc_11A45:				; CODE XREF: sub_1180D+235j
		jmp	gscMainLoop
; ---------------------------------------------------------------------------

loc_11A48:				; CODE XREF: sub_1180D-244j
					; DATA XREF: seg000:scrJumpTable80o
		lodsb
		cmp	al, 1
		jbe	short loc_11AB3
		cmp	al, 3
		jb	short loc_11A57
		jz	short loc_11A83

loc_11A53:				; CODE XREF: sub_1180D+254j
					; sub_1180D+26Dj
		mov	al, 5
		int	0BEh		; used by BASIC	while in interpreter

loc_11A57:				; CODE XREF: sub_1180D+242j
		call	scrEvalExpr
		or	cl, cl
		js	short loc_11A67
		cmp	ax, 50h	; 'P'
		jnb	short loc_11A53
		mov	byte ptr cs:PrintPos, al

loc_11A67:				; CODE XREF: sub_1180D+24Fj
		lodsb
		cmp	al, 1
		jz	short loc_11A74
		cmp	al, 3
		jz	short loc_11A80
		mov	al, 1
		int	0BEh		; used by BASIC	while in interpreter

loc_11A74:				; CODE XREF: sub_1180D+25Dj
		call	sub_11AD7
		cmp	ax, 19h
		jnb	short loc_11A53
		mov	byte ptr cs:PrintPos+1,	al

loc_11A80:				; CODE XREF: sub_1180D+261j
		jmp	gscMainLoop
; ---------------------------------------------------------------------------

loc_11A83:				; CODE XREF: sub_1180D+244j
		call	sub_11AD7
		and	al, 7
		ror	al, 3
		mov	dh, cs:PrintColor
		and	dh, 1Fh
		or	dh, al
		lodsb
		cmp	al, 1
		jz	short loc_11AA2
		cmp	al, 3
		jz	short loc_11AAB
		mov	al, 1
		int	0BEh		; used by BASIC	while in interpreter

loc_11AA2:				; CODE XREF: sub_1180D+28Bj
		call	sub_11AD7
		and	al, 1Eh
		inc	al
		or	dh, al

loc_11AAB:				; CODE XREF: sub_1180D+28Fj
		mov	cs:PrintColor, dh
		jmp	gscMainLoop
; ---------------------------------------------------------------------------

loc_11AB3:				; CODE XREF: sub_1180D+23Ej
		mov	ax, offset asc_11AC3 ; "\x1A"
		jb	short loc_11ABB
		mov	ax, offset asc_11AC5 ; "\r\n"

loc_11ABB:				; CODE XREF: sub_1180D+2A9j
		mov	bx, cs
		call	DoSomePrint
		jmp	gscMainLoop
sub_1180D	endp ; sp-analysis failed

; ---------------------------------------------------------------------------
asc_11AC3	db 1Ah,0		; DATA XREF: sub_1180D:loc_11AB3o
asc_11AC5	db 0Dh,0Ah,0		; DATA XREF: sub_1180D+2ABo
; ---------------------------------------------------------------------------
		lodsb
		cmp	al, 1
		jnz	short loc_11ACE
		retn
; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_11AD7

loc_11ACE:				; CODE XREF: seg000:1ACBj sub_11AD7-2j ...
		mov	al, 3
		int	0BEh		; used by BASIC	while in interpreter
		lodsb
		cmp	al, 1
		jnz	short loc_11ACE
; END OF FUNCTION CHUNK	FOR sub_11AD7

; =============== S U B	R O U T	I N E =======================================


sub_11AD7	proc near		; CODE XREF: sub_1180D:loc_11A74p
					; sub_1180D:loc_11A83p	...

; FUNCTION CHUNK AT 1ACE SIZE 00000009 BYTES

		call	scrEvalExpr
		or	cl, cl
		js	short loc_11ACE
		retn
sub_11AD7	endp


; =============== S U B	R O U T	I N E =======================================


sub_11ADF	proc near		; CODE XREF: sub_1180D-1EAp
					; sub_1180D+104p
		push	dx
		push	di
		push	es
		mov	dx, es
		mov	bx, 1
		mov	al, 2
		call	AllocFileMem
		jb	short loc_11B21
		mov	di, ax
		mov	es, ax
		mov	ah, 49h
		int	21h		; DOS -	2+ - FREE MEMORY
					; ES = segment address of area to be freed
		mov	bx, cs:word_13806
		mov	cx, 20h	; ' '

loc_11AFE:				; CODE XREF: sub_11ADF+3Cj
		mov	ax, cs:[bx]
		or	ax, ax
		jz	short loc_11B18
		cmp	ax, dx
		jbe	short loc_11B18
		cmp	ax, di
		jnb	short loc_11B18
		mov	es, ax
		mov	ah, 49h
		int	21h		; DOS -	2+ - FREE MEMORY
					; ES = segment address of area to be freed
		mov	word ptr cs:[bx], 0

loc_11B18:				; CODE XREF: sub_11ADF+24j
					; sub_11ADF+28j ...
		add	bx, 2
		loop	loc_11AFE
		pop	es
		pop	di
		pop	dx
		retn
; ---------------------------------------------------------------------------

loc_11B21:				; CODE XREF: sub_11ADF+Dj
		mov	al, 24h
		int	0BEh		; used by BASIC	while in interpreter

loc_11B25:				; CODE XREF: sub_1180D+194j
					; LoadGSCFile+90j ...
		mov	al, 20h
		int	0BEh		; used by BASIC	while in interpreter

loc_11B29:				; CODE XREF: LoadGSCFile+AAj
					; LoadGSCFile+B4j ...
		mov	ax, 30Fh
		int	0BEh		; used by BASIC	while in interpreter
sub_11ADF	endp ; sp-analysis failed


; =============== S U B	R O U T	I N E =======================================


LoadGSCFile	proc near		; CODE XREF: start-3FBEp sub_1180D+EAp ...
		mov	si, offset byte_138F4
		mov	cx, 4

loc_11B34:				; CODE XREF: LoadGSCFile+Dj
		mov	byte ptr cs:[si], 0
		add	si, 8
		loop	loc_11B34
		mov	word ptr cs:lf3_FileNamePtr, dx
		mov	word ptr cs:lf3_FileNamePtr+2, ds
		push	bx
		mov	si, dx
		push	cs
		pop	es
		assume es:seg000
		mov	dx, offset fullFilePath
		call	BuildAbsolutePath
		or	ax, ax
		jns	short loc_11B59
		jmp	loc_11C5E
; ---------------------------------------------------------------------------

loc_11B59:				; CODE XREF: LoadGSCFile+26j
		push	es
		pop	ds
		assume ds:seg000

loc_11B5B:				; CODE XREF: LoadGSCFile+3Ej
		mov	si, dx
		mov	al, [si]
		sub	al, 'A'
		call	SearchDiskDrive
		or	ax, ax
		jns	short loc_11B6E
		mov	al, 41h
		int	0BEh		; used by BASIC	while in interpreter
		jmp	short loc_11B5B
; ---------------------------------------------------------------------------

loc_11B6E:				; CODE XREF: LoadGSCFile+38j
					; LoadGSCFile+5Bj
		mov	word ptr cs:FilePathPtr, dx
		mov	word ptr cs:FilePathPtr+2, ds
		xor	ax, ax
		mov	ax, 3D00h
		int	21h		; DOS -	2+ - OPEN DISK FILE WITH HANDLE
					; DS:DX	-> ASCIZ filename
					; AL = access mode
					; 0 - read
		jnb	short loc_11B94
		cmp	al, 2
		jnz	short loc_11B8B
		mov	al, 40h
		int	0BEh		; used by BASIC	while in interpreter
		jmp	short loc_11B6E
; ---------------------------------------------------------------------------

loc_11B8B:				; CODE XREF: LoadGSCFile+55j
		xor	bh, bh
		mov	bl, al
		mov	ax, 326h
		int	0BEh		; used by BASIC	while in interpreter

loc_11B94:				; CODE XREF: LoadGSCFile+51j
		mov	cs:fileDataSeg,	0
		mov	dx, ax
		mov	bx, dx
		call	GetFileSize
		jb	short loc_11BD4
		add	ax, 0Fh
		adc	bx, 0
		shr	ax, 4
		shl	bl, 4
		or	ah, bl
		mov	bx, ax
		add	bx, 10h		; add 100h bytes extra
		xor	al, al
		call	AllocFileMem
		jnb	short loc_11BC1
		jmp	loc_11B25	; error	- exit
; ---------------------------------------------------------------------------

loc_11BC1:				; CODE XREF: LoadGSCFile+8Ej
		mov	ds, ax
		assume ds:nothing
		mov	cs:fileDataSeg,	ax
		call	lf3SaveFileName
		mov	bx, dx
		mov	dx, 100h	; destination offset in	new segment
		call	DecompressFile
		jmp	short loc_11C19
; ---------------------------------------------------------------------------

loc_11BD4:				; CODE XREF: LoadGSCFile+74j
		or	ax, ax
		jz	short loc_11BDB
		jmp	loc_11B29
; ---------------------------------------------------------------------------

loc_11BDB:				; CODE XREF: LoadGSCFile+A8j
		mov	bx, dx
		call	sub_10658
		jnb	short loc_11BE5
		jmp	loc_11B29
; ---------------------------------------------------------------------------

loc_11BE5:				; CODE XREF: LoadGSCFile+B2j
		add	ax, 0Fh
		adc	bl, bh
		shr	ax, 4
		shl	bl, 4
		or	ah, bl
		mov	cx, ax
		mov	bx, ax
		add	bx, 10h
		xor	ax, ax
		call	AllocFileMem
		jnb	short loc_11C03
		jmp	loc_11B25
; ---------------------------------------------------------------------------

loc_11C03:				; CODE XREF: LoadGSCFile+D0j
		mov	ds, ax
		call	lf3SaveFileName
		mov	bx, dx
		mov	dx, 100h
		call	ReadRawFile
		jnb	short loc_11C15
		jmp	loc_11B29
; ---------------------------------------------------------------------------

loc_11C15:				; CODE XREF: LoadGSCFile+E2j
		mov	ah, 3Eh
		int	21h		; DOS -	2+ - CLOSE A FILE WITH HANDLE
					; BX = file handle

loc_11C19:				; CODE XREF: LoadGSCFile+A4j
		xor	bx, bx
		pop	ax
		mov	word ptr [bx], 0
		mov	[bx+2],	ax
		mov	si, ds
		add	si, 10h
		mov	word ptr [bx+4], 0 ; save data payload pointer
		mov	[bx+6],	si	; save data payload segment
		mov	ax, [bx+108h]	; get pointer of string	data
		shr	ax, 4
		add	ax, si
		mov	word ptr [bx+8], 0 ; save string data pointer
		mov	[bx+0Ah], ax	; save string data segment
		xor	ax, ax
		mov	[bx+12h], ax
		mov	[bx+14h], ax
		mov	al, cs:gsc10
		mov	[bx+10h], ax	; save previous	value
		mov	ax, ds
		mov	ds, si
		assume ds:nothing
		mov	si, 10h
		mov	[bx+0Ch], si	; overwrite GSC	header,	offset 0Ch: start offset
		mov	word ptr [bx+0Eh], ds ;	overwrite GSC header, offset 0Eh: data segment
		retn
; ---------------------------------------------------------------------------

loc_11C5E:				; CODE XREF: LoadGSCFile+28j
		mov	al, 14h
		int	0BEh		; used by BASIC	while in interpreter
LoadGSCFile	endp ; sp-analysis failed


; =============== S U B	R O U T	I N E =======================================


lf3SaveFileName	proc near		; CODE XREF: LoadGSCFile+99p
					; LoadGSCFile+D7p
		push	di
		push	ds
		push	es
		mov	es, ax
		assume es:nothing
		mov	di, 20h		; copy file name to offset 0020h in file data segment
		lds	si, cs:lf3_FileNamePtr
		assume ds:nothing

loc_11C6F:				; CODE XREF: lf3SaveFileName+11j
		lodsb
		stosb
		or	al, al
		jnz	short loc_11C6F
		pop	es
		pop	ds
		pop	di
		retn
lf3SaveFileName	endp


; =============== S U B	R O U T	I N E =======================================


LoadMDL		proc near		; CODE XREF: sub_1180D+126p

; FUNCTION CHUNK AT 1DCF SIZE 00000008 BYTES

		mov	si, dx
		push	cs
		pop	es
		assume es:seg000
		mov	dx, offset fullFilePath
		call	BuildAbsolutePath
		or	ax, ax
		jns	short loc_11C8A
		jmp	loc_11DCF
; ---------------------------------------------------------------------------

loc_11C8A:				; CODE XREF: LoadMDL+Cj
		push	es
		pop	ds
		assume ds:seg000
		xor	ax, ax
		call	OpenFileRead1
		mov	cs:fileDataSeg,	ax
		mov	bx, ax
		mov	cx, 20h
		sub	sp, cx
		mov	bp, sp
		push	ss
		pop	ds
		assume ds:nothing
		mov	dx, bp
		mov	ah, 3Fh
		int	21h		; DOS -	2+ - READ FROM FILE WITH HANDLE
					; BX = file handle, CX = number	of bytes to read
					; DS:DX	-> buffer
		jnb	short loc_11CAB
		jmp	loc_11DD3
; ---------------------------------------------------------------------------

loc_11CAB:				; CODE XREF: LoadMDL+2Dj
		cmp	word ptr [bp+0], 'MG' ; check for "GMDL"
		jnz	short loc_11CE4
		cmp	word ptr [bp+2], 'LD'
		jnz	short loc_11CE4
		xor	bx, bx
		mov	bl, [bp+8]
		sub	bl, 0F0h
		cmp	bl, 8
		jnb	short loc_11CE4
		mov	cs:word_13836, bx
		add	bl, bl
		add	bl, bl
		add	bx, offset word_138B4
		test	word ptr cs:[bx+2], 0FFFFh
		jz	short loc_11CE8
		mov	bx, [bp+8]
		xchg	bh, bl
		mov	al, 1Ah
		int	0BEh		; used by BASIC	while in interpreter

loc_11CE4:				; CODE XREF: LoadMDL+37j LoadMDL+3Ej ...
		mov	al, 19h
		int	0BEh		; used by BASIC	while in interpreter

loc_11CE8:				; CODE XREF: LoadMDL+60j
		mov	cs:word_1383A, 0
		mov	bx, [bp+0Ch]
		mov	ax, [bp+0Ah]
		cmp	bx, ax
		jnb	short loc_11CFF
		xchg	ax, bx
		dec	cs:word_1383A

loc_11CFF:				; CODE XREF: LoadMDL+7Ej
		mov	ah, 48h
		int	21h		; DOS -	2+ - ALLOCATE MEMORY
					; BX = number of 16-byte paragraphs desired
		jnb	short loc_11D08
		jmp	loc_11B25
; ---------------------------------------------------------------------------

loc_11D08:				; CODE XREF: LoadMDL+8Aj
		mov	cs:word_1383C, ax
		mov	ds, ax
		xor	dx, dx
		mov	bx, cs:fileDataSeg
		test	byte ptr [bp+6], 0FFh
		jz	short loc_11D2E
		call	DecompressFile
		jnb	short loc_11D3D
		mov	bx, ax
		or	ax, ax
		jnz	short loc_11D29
		jmp	loc_11B25
; ---------------------------------------------------------------------------

loc_11D29:				; CODE XREF: LoadMDL+ABj
		mov	ax, 10Fh
		int	0BEh		; used by BASIC	while in interpreter

loc_11D2E:				; CODE XREF: LoadMDL+A0j
		mov	cx, [bp+0Ah]
		call	ReadRawFile
		jnb	short loc_11D39
		jmp	loc_11DD3
; ---------------------------------------------------------------------------

loc_11D39:				; CODE XREF: LoadMDL+BBj
		mov	ah, 3Eh
		int	21h		; DOS -	2+ - CLOSE A FILE WITH HANDLE
					; BX = file handle

loc_11D3D:				; CODE XREF: LoadMDL+A5j
		mov	cx, [bp+0Eh]
		jcxz	short loc_11D5E
		mov	si, [bp+10h]
		mov	ax, [bp+12h]
		mov	dx, cs:word_1383C
		add	ax, dx
		mov	ds, ax

loc_11D51:				; CODE XREF: LoadMDL+E3j
		lodsw
		mov	bx, ax
		lodsw
		add	ax, dx
		mov	es, ax
		assume es:nothing
		add	es:[bx], dx
		loop	loc_11D51

loc_11D5E:				; CODE XREF: LoadMDL+C7j
		test	cs:word_1383A, 0FFFFh
		jz	short loc_11D78
		mov	bx, [bp+0Ch]
		mov	es, cs:word_1383C
		mov	ah, 4Ah
		int	21h		; DOS -	2+ - ADJUST MEMORY BLOCK SIZE (SETBLOCK)
					; ES = segment address of block	to change
					; BX = new size	in paragraphs
		jnb	short loc_11D78
		jmp	loc_11B25
; ---------------------------------------------------------------------------

loc_11D78:				; CODE XREF: LoadMDL+ECj LoadMDL+FAj
		push	cs
		pop	ds
		assume ds:seg000
		mov	si, word_13836
		shl	si, 1
		shl	si, 1
		mov	bx, si
		add	si, offset word_138B4
		add	bx, offset byte_1380E
		mov	al, [bp+9]
		mov	[si], al
		mov	al, gsc10
		mov	[si+1],	al
		mov	ax, word_1383C
		mov	[si+2],	ax
		mov	es, ax
		mov	ax, es:0Ch
		mov	[bx], ax
		mov	ax, es:0Eh
		mov	[bx+2],	ax
		mov	cx, es:4
		mov	dx, es:6
		mov	ax, cx
		or	ax, dx
		jz	short loc_11DC2
		push	bp
		push	ds
		call	near ptr sub_11DCC
		pop	bp

loc_11DC2:				; CODE XREF: LoadMDL+141j
		xor	ax, ax
		mov	al, [bp+8]
		add	sp, 20h
		clc
		retn
LoadMDL		endp ; sp-analysis failed


; =============== S U B	R O U T	I N E =======================================


sub_11DCC	proc far		; CODE XREF: LoadMDL+145p
		push	dx
		push	cx
		retf
sub_11DCC	endp ; sp-analysis failed

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR LoadMDL

loc_11DCF:				; CODE XREF: LoadMDL+Ej
		mov	al, 14h
		int	0BEh		; used by BASIC	while in interpreter

loc_11DD3:				; CODE XREF: LoadMDL+2Fj LoadMDL+BDj
		mov	al, 29h
		int	0BEh		; used by BASIC	while in interpreter
; END OF FUNCTION CHUNK	FOR LoadMDL

; =============== S U B	R O U T	I N E =======================================


sub_11DD7	proc near		; CODE XREF: sub_1180D-1DCp
					; sub_1180D-1D1p ...
		mov	cs:fileDataSeg,	ax
		cmp	ah, 2
		jb	short sub_11DF7
		mov	cx, 8
		xor	dx, dx

loc_11DE5:				; CODE XREF: sub_11DD7:loc_11DF2j
		push	cx
		push	dx
		mov	ax, cx
		dec	ax
		call	sub_11DF7
		pop	dx
		pop	cx
		jb	short loc_11DF2
		inc	dx

loc_11DF2:				; CODE XREF: sub_11DD7+18j
		loop	loc_11DE5
		mov	ax, dx
		retn
sub_11DD7	endp


; =============== S U B	R O U T	I N E =======================================


sub_11DF7	proc near		; CODE XREF: sub_11DD7+7j
					; sub_11DD7+13p
		push	cs
		pop	ds
		xor	ah, ah
		mov	bx, ax
		shl	bx, 2
		mov	word_1383A, bx
		add	bx, offset word_138B4
		test	word ptr [bx+2], 0FFFFh
		jz	short loc_11E26
		mov	ah, [bx+1]
		mov	al, gsc10
		cmp	gsc10, ah
		jbe	short loc_11E2B
		test	byte ptr fileDataSeg+1,	1
		jnz	short loc_11E2B
		xor	ax, ax
		stc
		retn
; ---------------------------------------------------------------------------

loc_11E26:				; CODE XREF: sub_11DF7+16j
		mov	ax, 0FFFFh
		stc
		retn
; ---------------------------------------------------------------------------

loc_11E2B:				; CODE XREF: sub_11DF7+22j
					; sub_11DF7+29j
		mov	si, word_1383A
		add	si, offset byte_1380E
		mov	ax, offset loc_11E63
		mov	[si], ax
		mov	word ptr [si+2], ds
		mov	word_1383A, bx
		mov	es, word ptr [bx+2]
		xor	ax, ax
		mov	[bx+2],	ax
		mov	cx, es:8
		mov	dx, es:0Ah
		mov	ax, cx
		or	ax, dx
		jz	short loc_11E5B
		push	cs
		call	near ptr sub_11E60

loc_11E5B:				; CODE XREF: sub_11DF7+5Ej
		mov	ax, 1
		clc
		retn
sub_11DF7	endp


; =============== S U B	R O U T	I N E =======================================


sub_11E60	proc far		; CODE XREF: sub_11DF7+61p
		push	dx
		push	cx
		retf
sub_11E60	endp ; sp-analysis failed

; ---------------------------------------------------------------------------

loc_11E63:				; DATA XREF: sub_11DF7+3Co
		mov	bx, ax
		mov	ah, 1
		mov	al, 18h
		int	0BEh		; used by BASIC	while in interpreter

; =============== S U B	R O U T	I N E =======================================


scrEvalExpr	proc near		; CODE XREF: sub_1180D-2A2p
					; sub_1164D+2Bp ...
		cld
		push	dx
		push	bp
		xor	dx, dx

sxEvalLoop:				; CODE XREF: scrEvalExpr+Aj
					; scrEvalExpr+3Dj ...
		xor	ax, ax
		lodsb
		cmp	al, 95h
		jz	short sxEvalLoop
		cmp	al, 80h
		jb	short loc_11E7E
		jmp	loc_11FC5
; ---------------------------------------------------------------------------

loc_11E7E:				; CODE XREF: scrEvalExpr+Ej
		cmp	al, 60h
		jb	short loc_11E85
		jmp	scr60Handler
; ---------------------------------------------------------------------------

loc_11E85:				; CODE XREF: scrEvalExpr+15j
		cmp	al, 10h
		jb	short loc_11EDF
		cmp	al, 20h
		jnb	short sx20
		cmp	al, 18h
		jnb	short sx18_RegPtr

sx10_RegInt16:
		and	al, 7
		mov	ah, al		; byte 10h..17h	-> register ID 0xxh..7xxh
		lodsb			; set low nibble of ID
		shl	ax, 1
		mov	bx, word ptr cs:scrRegMemPtr
		add	bx, ax
		mov	ax, cs:[bx]
		mov	cx, 2
		push	ax		; push value
		push	cx		; push type (16-bit integer)
		inc	dx
		jmp	short sxEvalLoop
; ---------------------------------------------------------------------------

sx18_RegPtr:				; CODE XREF: scrEvalExpr+24j
		and	al, 7
		mov	ah, al
		lodsb
		shl	ax, 1
		add	ax, word ptr cs:scrRegMemPtr
		mov	bx, cs
		mov	cx, 4
		push	bx		; push segment
		push	ax		; push offset
		push	cx		; push type (pointer)
		inc	dx
		jmp	short sxEvalLoop
; ---------------------------------------------------------------------------

sx20:					; CODE XREF: scrEvalExpr+20j
		mov	cl, al
		and	ax, 1Fh
		shl	ax, 1
		add	ax, cs:word_13806
		mov	bx, ax
		mov	bx, cs:[bx]
		push	bx
		call	scrEvalExpr
		pop	bx
		or	cl, cl
		jns	short loc_11F4B
		xor	ax, ax
		jmp	short loc_11F4B
; ---------------------------------------------------------------------------

loc_11EDF:				; CODE XREF: scrEvalExpr+1Cj
		sub	al, 6
		jnb	short loc_11EE6
		jmp	sx00
; ---------------------------------------------------------------------------

loc_11EE6:				; CODE XREF: scrEvalExpr+76j
		shl	ax, 1
		mov	bx, ax
		jmp	word ptr cs:sx06_JumpTbl[bx]
; ---------------------------------------------------------------------------
sx06_JumpTbl:				; DATA XREF: scrEvalExpr+7Fr
		dw offset sx06		; 0
		dw offset sx07		; 1
		dw offset sx08_Val_M1	; 2
		dw offset sx09_Val_0	; 3
		dw offset sx0A_Val_P1	; 4
		dw offset sx0B_ByteVal	; 5
		dw offset sx0C_WordVal	; 6
		dw offset sx0D		; 7
		dw offset sx0E_StrOfs	; 8
		dw offset sx0F		; 9
		dw offset loc_115CE	; 0Ah
; ---------------------------------------------------------------------------

sx06:					; CODE XREF: scrEvalExpr+7Fj
					; DATA XREF: scrEvalExpr:sx06_JumpTblo
		lodsw
		mov	cx, 0Bh
		mov	bx, cs
		jmp	short loc_11F72
; ---------------------------------------------------------------------------

sx07:					; CODE XREF: scrEvalExpr+7Fj
					; DATA XREF: scrEvalExpr:sx06_JumpTblo
		xor	ah, ah
		lodsb
		mov	cx, 9
		push	ax
		push	cx
		inc	dx
		jmp	sxEvalLoop
; ---------------------------------------------------------------------------

sx08_Val_M1:				; CODE XREF: scrEvalExpr+7Fj
					; DATA XREF: scrEvalExpr:sx06_JumpTblo
		mov	ax, -1
		jmp	short loc_11F2B
; ---------------------------------------------------------------------------

sx09_Val_0:				; CODE XREF: scrEvalExpr+7Fj
					; DATA XREF: scrEvalExpr:sx06_JumpTblo
		xor	ax, ax
		jmp	short loc_11F2B
; ---------------------------------------------------------------------------

sx0A_Val_P1:				; CODE XREF: scrEvalExpr+7Fj
					; DATA XREF: scrEvalExpr:sx06_JumpTblo
		mov	ax, 1
		jmp	short loc_11F2B
; ---------------------------------------------------------------------------

sx0B_ByteVal:				; CODE XREF: scrEvalExpr+7Fj
					; DATA XREF: scrEvalExpr:sx06_JumpTblo
		lodsb
		jmp	short loc_11F2B
; ---------------------------------------------------------------------------

sx0C_WordVal:				; CODE XREF: scrEvalExpr+7Fj
					; DATA XREF: scrEvalExpr:sx06_JumpTblo
		lodsw

loc_11F2B:				; CODE XREF: scrEvalExpr+B1j
					; scrEvalExpr+B5j ...
		mov	cx, 2
		push	ax		; push value
		push	cx		; push type (16-bit integer)
		inc	dx
		jmp	sxEvalLoop
; ---------------------------------------------------------------------------

sx0F:					; CODE XREF: scrEvalExpr+7Fj
					; DATA XREF: scrEvalExpr:sx06_JumpTblo
		lodsb
		cmp	ax, 20h
		jb	short loc_11F3D
		jmp	loc_115CE
; ---------------------------------------------------------------------------

loc_11F3D:				; CODE XREF: scrEvalExpr+CDj
		shl	ax, 1
		add	ax, cs:word_13806
		mov	bx, ax
		mov	bx, cs:[bx]
		xor	ax, ax

loc_11F4B:				; CODE XREF: scrEvalExpr+6Ej
					; scrEvalExpr+72j
		or	bx, bx
		jnz	short loc_11F53
		mov	al, 7
		int	0BEh		; used by BASIC	while in interpreter

loc_11F53:				; CODE XREF: scrEvalExpr+E2j
		push	ax
		push	es
		mov	es, bx
		add	ax, 0Fh
		jnb	short loc_11F61
		mov	ax, 1000h
		jmp	short loc_11F65
; ---------------------------------------------------------------------------

loc_11F61:				; CODE XREF: scrEvalExpr+EFj
		mov	cl, 4
		shr	ax, cl

loc_11F65:				; CODE XREF: scrEvalExpr+F4j
		cmp	es:0, ax
		pop	es
		pop	ax
		jb	short loc_11F79
		inc	bx
		mov	cx, 5

loc_11F72:				; CODE XREF: scrEvalExpr+A0j
		push	bx
		push	ax
		push	cx
		inc	dx
		jmp	sxEvalLoop
; ---------------------------------------------------------------------------

loc_11F79:				; CODE XREF: scrEvalExpr+101j
		mov	al, 6
		int	0BEh		; used by BASIC	while in interpreter

sx0D:					; CODE XREF: scrEvalExpr+7Fj
					; DATA XREF: scrEvalExpr:sx06_JumpTblo
		lodsb
		cmp	al, 8
		jb	short loc_11F85
		jmp	loc_115CE
; ---------------------------------------------------------------------------

loc_11F85:				; CODE XREF: scrEvalExpr+115j
		xchg	ah, al
		add	ax, word ptr cs:dword_1380A
		mov	bx, cs
		mov	cx, 6
		push	bx
		push	ax
		push	cx
		inc	dx
		jmp	sxEvalLoop
; ---------------------------------------------------------------------------

sx0E_StrOfs:				; CODE XREF: scrEvalExpr+7Fj
					; DATA XREF: scrEvalExpr:sx06_JumpTblo
		lodsw			; read string offset
		mov	bx, word ptr cs:gscStrPtr+2
		mov	cx, 7
		push	bx		; push segment
		push	ax		; push offset
		push	cx		; push type (string)
		inc	dx
		jmp	sxEvalLoop
; ---------------------------------------------------------------------------

sx00:					; CODE XREF: scrEvalExpr+78j
					; scrEvalExpr+15Cj
		mov	cx, 0FFFFh
		dec	si
		dec	dx
		js	short loc_11FBE
		jnz	short loc_11FC1
		pop	cx
		pop	ax
		cmp	cl, 4
		jb	short loc_11FBE
		cmp	cl, 9
		jz	short loc_11FBE
		pop	bx

loc_11FBE:				; CODE XREF: scrEvalExpr+142j
					; scrEvalExpr+14Bj ...
		pop	bp
		pop	dx
		retn
; ---------------------------------------------------------------------------

loc_11FC1:				; CODE XREF: scrEvalExpr+144j
					; scrEvalExpr+174j
		mov	al, 0Bh
		int	0BEh		; used by BASIC	while in interpreter

loc_11FC5:				; CODE XREF: scrEvalExpr+10j
		cmp	al, 0A0h
		jb	short sx00
		cmp	al, 0D0h
		jb	short loc_11FDA
		cmp	al, 0F0h
		jnb	short loc_11FD7
		mov	ah, 0F0h
		sub	al, 0D0h
		jmp	short loc_11FDA
; ---------------------------------------------------------------------------

loc_11FD7:				; CODE XREF: scrEvalExpr+164j
		mov	ah, al
		lodsb

loc_11FDA:				; CODE XREF: scrEvalExpr+160j
					; scrEvalExpr+16Aj
		call	scrA0
		or	cl, cl
		js	short loc_11FC1
		cmp	cl, 4
		jb	short loc_11FE7
		push	bx

loc_11FE7:				; CODE XREF: scrEvalExpr+179j
		push	ax
		push	cx
		inc	dx
		jmp	sxEvalLoop
; ---------------------------------------------------------------------------

scr60Handler:				; CODE XREF: scrEvalExpr+17j
		sub	al, 60h
		mov	bp, sp
		call	sub_11FF9
		mov	sp, bp
		jmp	sxEvalLoop
scrEvalExpr	endp ; sp-analysis failed


; =============== S U B	R O U T	I N E =======================================


sub_11FF9	proc near		; CODE XREF: scrEvalExpr+186p
		mov	bx, ax
		shl	bx, 1
		jmp	word ptr cs:sx60_JumpTbl[bx]
; ---------------------------------------------------------------------------
sx60_JumpTbl:				; DATA XREF: sub_11FF9+4r
		dw offset loc_12045	; 0
		dw offset loc_12052	; 1
		dw offset loc_1206B	; 2
		dw offset loc_12091	; 3
		dw offset loc_120AF	; 4
		dw offset loc_12117	; 5
		dw offset loc_1212A	; 6
		dw offset loc_1214A	; 7
		dw offset loc_1216A	; 8
		dw offset loc_12189	; 9
		dw offset loc_121A8	; 0Ah
		dw offset loc_121C8	; 0Bh
		dw offset loc_121E8	; 0Ch
		dw offset loc_12208	; 0Dh
		dw offset loc_1222C	; 0Eh
		dw offset loc_12244	; 0Fh
		dw offset loc_1225C	; 10h
		dw offset loc_12274	; 11h
		dw offset loc_122FE	; 12h
		dw offset loc_12355	; 13h
		dw offset loc_123B0	; 14h
		dw offset loc_12411	; 15h
		dw offset loc_1244E	; 16h
		dw offset loc_124A7	; 17h
		dw offset loc_1228C	; 18h
		dw offset loc_12299	; 19h
		dw offset loc_122A9	; 1Ah
		dw offset loc_122B9	; 1Bh
		dw offset loc_122CD	; 1Ch
		dw offset loc_122EB	; 1Dh
		dw offset loc_12042	; 1Eh
		dw offset loc_12042	; 1Fh
; ---------------------------------------------------------------------------

loc_12042:				; CODE XREF: sub_11FF9+4j
					; DATA XREF: sub_11FF9:sx60_JumpTblo
		jmp	loc_115D2
; ---------------------------------------------------------------------------

loc_12045:				; CODE XREF: sub_11FF9+4j
					; DATA XREF: sub_11FF9:sx60_JumpTblo
		or	dx, dx
		jz	short loc_1208D
		mov	ax, [bp+2]
		neg	ax
		mov	[bp+2],	ax
		retn
; ---------------------------------------------------------------------------

loc_12052:				; CODE XREF: sub_11FF9+4j
					; DATA XREF: sub_11FF9:sx60_JumpTblo
		cmp	dx, 2
		jb	short loc_1208D
		dec	dx
		mov	cx, dx
		mov	dx, [bp+2]
		add	bp, 4
		mov	ax, [bp+2]
		imul	dx
		mov	[bp+2],	ax
		mov	dx, cx
		retn
; ---------------------------------------------------------------------------

loc_1206B:				; CODE XREF: sub_11FF9+4j
					; DATA XREF: sub_11FF9:sx60_JumpTblo
		cmp	dx, 2
		jb	short loc_1208D
		dec	dx
		mov	cx, dx
		mov	bx, [bp+2]
		or	bx, bx
		jz	short loc_12089
		add	bp, 4
		mov	ax, [bp+2]
		cwd
		idiv	bx
		mov	[bp+2],	ax
		mov	dx, cx
		retn
; ---------------------------------------------------------------------------

loc_12089:				; CODE XREF: sub_11FF9+7Fj
					; sub_11FF9+A5j
		mov	al, 0Dh
		int	0BEh		; used by BASIC	while in interpreter

loc_1208D:				; CODE XREF: sub_11FF9+4Ej
					; sub_11FF9+5Cj ...
		mov	al, 0Bh
		int	0BEh		; used by BASIC	while in interpreter

loc_12091:				; CODE XREF: sub_11FF9+4j
					; DATA XREF: sub_11FF9:sx60_JumpTblo
		cmp	dx, 2
		jb	short loc_1208D
		dec	dx
		mov	cx, dx
		mov	bx, [bp+2]
		or	bx, bx
		jz	short loc_12089
		add	bp, 4
		mov	ax, [bp+2]
		cwd
		idiv	bx
		mov	[bp+2],	dx
		mov	dx, cx
		retn
; ---------------------------------------------------------------------------

loc_120AF:				; CODE XREF: sub_11FF9+4j
					; DATA XREF: sub_11FF9:sx60_JumpTblo
		cmp	dx, 2
		jb	short loc_1208D
		dec	dx
		cmp	word ptr [bp+0], 3
		ja	short loc_120CF
		mov	ax, [bp+2]
		add	bp, 4
		cmp	word ptr [bp+0], 3
		ja	short loc_120CB
		add	[bp+2],	ax
		retn
; ---------------------------------------------------------------------------

loc_120CB:				; CODE XREF: sub_11FF9+CCj
					; sub_11FF9+E1j ...
		mov	al, 4
		int	0BEh		; used by BASIC	while in interpreter

loc_120CF:				; CODE XREF: sub_11FF9+C0j
		push	si
		push	di
		push	ds
		push	es
		add	bp, 6
		cmp	word ptr [bp+0], 3
		jbe	short loc_120CB
		lds	si, [bp+2]
		assume ds:nothing
		les	di, cs:somePtr
		mov	[bp+2],	di
		mov	word ptr [bp+4], es
		mov	cx, 0FFh
		pushf
		cld

loc_120EF:				; CODE XREF: sub_11FF9+FCj
		lodsb
		or	al, al
		jz	short loc_120F9
		stosb
		loop	loc_120EF
		jmp	short loc_12107
; ---------------------------------------------------------------------------

loc_120F9:				; CODE XREF: sub_11FF9+F9j
		lds	si, [bp-4]

loc_120FC:				; CODE XREF: sub_11FF9+109j
		lodsb
		stosb
		or	al, al
		jz	short loc_12107
		loop	loc_120FC
		xor	al, al
		stosb

loc_12107:				; CODE XREF: sub_11FF9+FEj
					; sub_11FF9+107j
		mov	word ptr cs:somePtr, di
		mov	word ptr [bp+0], 7
		popf
		pop	es
		pop	ds
		pop	di
		pop	si
		retn
; ---------------------------------------------------------------------------

loc_12117:				; CODE XREF: sub_11FF9+4j
					; DATA XREF: sub_11FF9:sx60_JumpTblo
		cmp	dx, 2
		jnb	short loc_1211F
		jmp	loc_1208D
; ---------------------------------------------------------------------------

loc_1211F:				; CODE XREF: sub_11FF9+121j
		dec	dx
		mov	ax, [bp+2]
		add	bp, 4
		sub	[bp+2],	ax
		retn
; ---------------------------------------------------------------------------

loc_1212A:				; CODE XREF: sub_11FF9+4j
					; DATA XREF: sub_11FF9:sx60_JumpTblo
		cmp	dx, 2
		jnb	short loc_12132
		jmp	loc_12228
; ---------------------------------------------------------------------------

loc_12132:				; CODE XREF: sub_11FF9+134j
		dec	dx
		mov	cx, [bp+2]
		add	bp, 4
		mov	ax, [bp+2]
		cmp	cx, 10h
		jb	short loc_12144
		mov	cx, 10h

loc_12144:				; CODE XREF: sub_11FF9+146j
		shl	ax, cl
		mov	[bp+2],	ax
		retn
; ---------------------------------------------------------------------------

loc_1214A:				; CODE XREF: sub_11FF9+4j
					; DATA XREF: sub_11FF9:sx60_JumpTblo
		cmp	dx, 2
		jnb	short loc_12152
		jmp	loc_12228
; ---------------------------------------------------------------------------

loc_12152:				; CODE XREF: sub_11FF9+154j
		dec	dx
		mov	cx, [bp+2]
		add	bp, 4
		mov	ax, [bp+2]
		cmp	cx, 10h
		jb	short loc_12164
		mov	cx, 10h

loc_12164:				; CODE XREF: sub_11FF9+166j
		sar	ax, cl
		mov	[bp+2],	ax
		retn
; ---------------------------------------------------------------------------

loc_1216A:				; CODE XREF: sub_11FF9+4j
					; DATA XREF: sub_11FF9:sx60_JumpTblo
		cmp	dx, 2
		jnb	short loc_12172
		jmp	loc_12228
; ---------------------------------------------------------------------------

loc_12172:				; CODE XREF: sub_11FF9+174j
		dec	dx
		mov	cx, [bp+2]
		add	bp, 4
		mov	ax, [bp+2]
		cmp	cx, 8
		jb	short loc_12183
		mov	cl, 8

loc_12183:				; CODE XREF: sub_11FF9+186j
		shl	al, cl
		mov	[bp+2],	ax
		retn
; ---------------------------------------------------------------------------

loc_12189:				; CODE XREF: sub_11FF9+4j
					; DATA XREF: sub_11FF9:sx60_JumpTblo
		cmp	dx, 2
		jnb	short loc_12191
		jmp	loc_12228
; ---------------------------------------------------------------------------

loc_12191:				; CODE XREF: sub_11FF9+193j
		dec	dx
		mov	cx, [bp+2]
		add	bp, 4
		mov	ax, [bp+2]
		cmp	cx, 8
		jb	short loc_121A2
		mov	cl, 8

loc_121A2:				; CODE XREF: sub_11FF9+1A5j
		sar	al, cl
		mov	[bp+2],	ax
		retn
; ---------------------------------------------------------------------------

loc_121A8:				; CODE XREF: sub_11FF9+4j
					; DATA XREF: sub_11FF9:sx60_JumpTblo
		cmp	dx, 2
		jb	short loc_12228
		dec	dx
		mov	cx, [bp+2]
		add	bp, 4
		mov	ax, [bp+2]
		cmp	cx, 10h
		jnb	short loc_121C2
		shl	ax, cl
		mov	[bp+2],	ax
		retn
; ---------------------------------------------------------------------------

loc_121C2:				; CODE XREF: sub_11FF9+1C1j
		xor	ax, ax
		mov	[bp+2],	ax
		retn
; ---------------------------------------------------------------------------

loc_121C8:				; CODE XREF: sub_11FF9+4j
					; DATA XREF: sub_11FF9:sx60_JumpTblo
		cmp	dx, 2
		jb	short loc_12228
		dec	dx
		mov	cx, [bp+2]
		add	bp, 4
		mov	ax, [bp+2]
		cmp	cx, 10h
		jnb	short loc_121E2
		shr	ax, cl
		mov	[bp+2],	ax
		retn
; ---------------------------------------------------------------------------

loc_121E2:				; CODE XREF: sub_11FF9+1E1j
		xor	ax, ax
		mov	[bp+2],	ax
		retn
; ---------------------------------------------------------------------------

loc_121E8:				; CODE XREF: sub_11FF9+4j
					; DATA XREF: sub_11FF9:sx60_JumpTblo
		cmp	dx, 2
		jb	short loc_12228
		dec	dx
		mov	cx, [bp+2]
		add	bp, 4
		mov	ax, [bp+2]
		cmp	cx, 8
		jnb	short loc_12202
		shl	al, cl
		mov	[bp+2],	ax
		retn
; ---------------------------------------------------------------------------

loc_12202:				; CODE XREF: sub_11FF9+201j
		xor	al, al
		mov	[bp+2],	ax
		retn
; ---------------------------------------------------------------------------

loc_12208:				; CODE XREF: sub_11FF9+4j
					; DATA XREF: sub_11FF9:sx60_JumpTblo
		cmp	dx, 2
		jb	short loc_12228
		dec	dx
		mov	cx, [bp+2]
		add	bp, 4
		mov	ax, [bp+2]
		cmp	cx, 8
		jnb	short loc_12222
		shr	al, cl
		mov	[bp+2],	ax
		retn
; ---------------------------------------------------------------------------

loc_12222:				; CODE XREF: sub_11FF9+221j
		xor	al, al
		mov	[bp+2],	ax
		retn
; ---------------------------------------------------------------------------

loc_12228:				; CODE XREF: sub_11FF9+136j
					; sub_11FF9+156j ...
		mov	al, 0Bh
		int	0BEh		; used by BASIC	while in interpreter

loc_1222C:				; CODE XREF: sub_11FF9+4j
					; DATA XREF: sub_11FF9:sx60_JumpTblo
		cmp	dx, 2
		jb	short loc_12228
		dec	dx
		mov	cx, [bp+2]
		add	bp, 4
		and	cl, 0Fh
		mov	ax, [bp+2]
		rol	ax, cl
		mov	[bp+2],	ax
		retn
; ---------------------------------------------------------------------------

loc_12244:				; CODE XREF: sub_11FF9+4j
					; DATA XREF: sub_11FF9:sx60_JumpTblo
		cmp	dx, 2
		jb	short loc_12228
		dec	dx
		mov	cx, [bp+2]
		add	bp, 4
		and	cl, 0Fh
		mov	ax, [bp+2]
		ror	ax, cl
		mov	[bp+2],	ax
		retn
; ---------------------------------------------------------------------------

loc_1225C:				; CODE XREF: sub_11FF9+4j
					; DATA XREF: sub_11FF9:sx60_JumpTblo
		cmp	dx, 2
		jb	short loc_12228
		dec	dx
		mov	cx, [bp+2]
		add	bp, 4
		and	cl, 7
		mov	ax, [bp+2]
		rol	al, cl
		mov	[bp+2],	ax
		retn
; ---------------------------------------------------------------------------

loc_12274:				; CODE XREF: sub_11FF9+4j
					; DATA XREF: sub_11FF9:sx60_JumpTblo
		cmp	dx, 2
		jb	short loc_12228
		dec	dx
		mov	cx, [bp+2]
		add	bp, 4
		and	cl, 7
		mov	ax, [bp+2]
		ror	al, cl
		mov	[bp+2],	ax
		retn
; ---------------------------------------------------------------------------

loc_1228C:				; CODE XREF: sub_11FF9+4j
					; DATA XREF: sub_11FF9:sx60_JumpTblo
		or	dx, dx
		jz	short loc_122C9
		mov	ax, [bp+2]
		not	ax
		mov	[bp+2],	ax
		retn
; ---------------------------------------------------------------------------

loc_12299:				; CODE XREF: sub_11FF9+4j
					; DATA XREF: sub_11FF9:sx60_JumpTblo
		cmp	dx, 2
		jb	short loc_122C9
		dec	dx
		mov	ax, [bp+2]
		add	bp, 4
		and	[bp+2],	ax
		retn
; ---------------------------------------------------------------------------

loc_122A9:				; CODE XREF: sub_11FF9+4j
					; DATA XREF: sub_11FF9:sx60_JumpTblo
		cmp	dx, 2
		jb	short loc_122C9
		dec	dx
		mov	ax, [bp+2]
		add	bp, 4
		or	[bp+2],	ax
		retn
; ---------------------------------------------------------------------------

loc_122B9:				; CODE XREF: sub_11FF9+4j
					; DATA XREF: sub_11FF9:sx60_JumpTblo
		cmp	dx, 2
		jb	short loc_122C9
		dec	dx
		mov	ax, [bp+2]
		add	bp, 4
		xor	[bp+2],	ax
		retn
; ---------------------------------------------------------------------------

loc_122C9:				; CODE XREF: sub_11FF9+295j
					; sub_11FF9+2A3j ...
		mov	al, 0Bh
		int	0BEh		; used by BASIC	while in interpreter

loc_122CD:				; CODE XREF: sub_11FF9+4j
					; DATA XREF: sub_11FF9:sx60_JumpTblo
		cmp	dx, 2
		jb	short loc_122C9
		dec	dx
		mov	ax, [bp+2]
		add	bp, 4
		or	ax, ax
		jz	short loc_122E7
		mov	ax, [bp+2]
		or	ax, ax
		jz	short loc_122E7

loc_122E4:				; CODE XREF: sub_11FF9+303j
		mov	ax, 0FFFFh

loc_122E7:				; CODE XREF: sub_11FF9+2E2j
					; sub_11FF9+2E9j ...
		mov	[bp+2],	ax
		retn
; ---------------------------------------------------------------------------

loc_122EB:				; CODE XREF: sub_11FF9+4j
					; DATA XREF: sub_11FF9:sx60_JumpTblo
		cmp	dx, 2
		jb	short loc_122C9
		dec	dx
		mov	ax, [bp+2]
		add	bp, 4
		or	ax, [bp+2]
		jz	short loc_122E7
		jmp	short loc_122E4
; ---------------------------------------------------------------------------

loc_122FE:				; CODE XREF: sub_11FF9+4j
					; DATA XREF: sub_11FF9:sx60_JumpTblo
		cmp	dx, 2
		jb	short loc_122C9
		dec	dx
		cmp	word ptr [bp+0], 3
		ja	short loc_12322
		mov	ax, [bp+2]
		add	bp, 4
		cmp	[bp+2],	ax
		jnz	short loc_1231C
		mov	ax, 0FFFFh
		mov	[bp+2],	ax
		retn
; ---------------------------------------------------------------------------

loc_1231C:				; CODE XREF: sub_11FF9+31Aj
		xor	ax, ax
		mov	[bp+2],	ax
		retn
; ---------------------------------------------------------------------------

loc_12322:				; CODE XREF: sub_11FF9+30Fj
		push	si
		push	ds
		push	es
		mov	bx, di
		les	di, [bp+2]
		add	bp, 6
		cmp	word ptr [bp+0], 3
		ja	short loc_12336
		jmp	loc_120CB
; ---------------------------------------------------------------------------

loc_12336:				; CODE XREF: sub_11FF9+338j
		lds	si, [bp+2]
		add	bp, 2
		mov	word ptr [bp+0], 2
		xor	cx, cx

loc_12343:				; CODE XREF: sub_11FF9+350j
		lodsb
		scasb
		jnz	short loc_1234C
		or	al, al
		jnz	short loc_12343
		dec	cx

loc_1234C:				; CODE XREF: sub_11FF9+34Cj
		mov	[bp+2],	cx
		mov	di, bx
		pop	es
		pop	ds
		pop	si
		retn
; ---------------------------------------------------------------------------

loc_12355:				; CODE XREF: sub_11FF9+4j
					; DATA XREF: sub_11FF9:sx60_JumpTblo
		cmp	dx, 2
		jnb	short loc_1235D
		jmp	loc_122C9
; ---------------------------------------------------------------------------

loc_1235D:				; CODE XREF: sub_11FF9+35Fj
		dec	dx
		cmp	word ptr [bp+0], 3
		ja	short loc_1237C
		mov	ax, [bp+2]
		add	bp, 4
		cmp	[bp+2],	ax
		jz	short loc_12376
		mov	ax, 0FFFFh
		mov	[bp+2],	ax
		retn
; ---------------------------------------------------------------------------

loc_12376:				; CODE XREF: sub_11FF9+374j
		xor	ax, ax
		mov	[bp+2],	ax
		retn
; ---------------------------------------------------------------------------

loc_1237C:				; CODE XREF: sub_11FF9+369j
		push	si
		push	ds
		push	es
		mov	bx, di
		les	di, [bp+2]
		add	bp, 6
		cmp	word ptr [bp+0], 3
		ja	short loc_12390
		jmp	loc_120CB
; ---------------------------------------------------------------------------

loc_12390:				; CODE XREF: sub_11FF9+392j
		lds	si, [bp+2]
		add	bp, 2
		mov	word ptr [bp+0], 2
		mov	cx, 0FFFFh

loc_1239E:				; CODE XREF: sub_11FF9+3ABj
		lodsb
		scasb
		jnz	short loc_123A7
		or	al, al
		jnz	short loc_1239E
		inc	cx

loc_123A7:				; CODE XREF: sub_11FF9+3A7j
		mov	[bp+2],	cx
		mov	di, bx
		pop	es
		pop	ds
		pop	si
		retn
; ---------------------------------------------------------------------------

loc_123B0:				; CODE XREF: sub_11FF9+4j
					; DATA XREF: sub_11FF9:sx60_JumpTblo
		cmp	dx, 2
		jb	short loc_1240D
		dec	dx
		cmp	word ptr [bp+0], 3
		ja	short loc_123D4
		mov	ax, [bp+2]
		add	bp, 4
		cmp	[bp+2],	ax
		jge	short loc_123CE
		mov	ax, 0FFFFh
		mov	[bp+2],	ax
		retn
; ---------------------------------------------------------------------------

loc_123CE:				; CODE XREF: sub_11FF9+3CCj
		xor	ax, ax
		mov	[bp+2],	ax
		retn
; ---------------------------------------------------------------------------

loc_123D4:				; CODE XREF: sub_11FF9+3C1j
		push	si
		push	ds
		push	es
		mov	bx, di
		les	di, [bp+2]
		add	bp, 6
		cmp	word ptr [bp+0], 3
		ja	short loc_123E8
		jmp	loc_120CB
; ---------------------------------------------------------------------------

loc_123E8:				; CODE XREF: sub_11FF9+3EAj
		lds	si, [bp+2]

loc_123EB:				; CODE XREF: sub_11FF9+453j
		add	bp, 2
		mov	word ptr [bp+0], 2
		xor	ax, ax

loc_123F5:				; CODE XREF: sub_11FF9+401j
		cmp	[si], al
		jz	short loc_12408
		cmpsb
		jz	short loc_123F5
		jnb	short loc_123FF

loc_123FE:				; CODE XREF: sub_11FF9+412j
		dec	ax

loc_123FF:				; CODE XREF: sub_11FF9+403j
					; sub_11FF9+410j
		mov	[bp+2],	ax
		mov	di, bx
		pop	es
		pop	ds
		pop	si
		retn
; ---------------------------------------------------------------------------

loc_12408:				; CODE XREF: sub_11FF9+3FEj
		scasb
		jz	short loc_123FF
		jmp	short loc_123FE
; ---------------------------------------------------------------------------

loc_1240D:				; CODE XREF: sub_11FF9+3BAj
					; sub_11FF9+41Bj ...
		mov	al, 0Bh
		int	0BEh		; used by BASIC	while in interpreter

loc_12411:				; CODE XREF: sub_11FF9+4j
					; DATA XREF: sub_11FF9:sx60_JumpTblo
		cmp	dx, 2
		jb	short loc_1240D
		dec	dx
		cmp	word ptr [bp+0], 3
		ja	short loc_12435
		mov	ax, [bp+2]
		add	bp, 4
		cmp	[bp+2],	ax
		jle	short loc_1242F
		mov	ax, 0FFFFh
		mov	[bp+2],	ax
		retn
; ---------------------------------------------------------------------------

loc_1242F:				; CODE XREF: sub_11FF9+42Dj
		xor	ax, ax
		mov	[bp+2],	ax
		retn
; ---------------------------------------------------------------------------

loc_12435:				; CODE XREF: sub_11FF9+422j
		push	si
		push	ds
		push	es
		mov	bx, di
		lds	si, [bp+2]
		add	bp, 6
		cmp	word ptr [bp+0], 3
		ja	short loc_12449
		jmp	loc_120CB
; ---------------------------------------------------------------------------

loc_12449:				; CODE XREF: sub_11FF9+44Bj
		les	di, [bp+2]
		jmp	short loc_123EB
; ---------------------------------------------------------------------------

loc_1244E:				; CODE XREF: sub_11FF9+4j
					; DATA XREF: sub_11FF9:sx60_JumpTblo
		cmp	dx, 2
		jb	short loc_1240D
		dec	dx
		cmp	word ptr [bp+0], 3
		ja	short loc_12472
		mov	ax, [bp+2]
		add	bp, 4
		cmp	[bp+2],	ax
		jg	short loc_1246C
		mov	ax, 0FFFFh
		mov	[bp+2],	ax
		retn
; ---------------------------------------------------------------------------

loc_1246C:				; CODE XREF: sub_11FF9+46Aj
		xor	ax, ax
		mov	[bp+2],	ax
		retn
; ---------------------------------------------------------------------------

loc_12472:				; CODE XREF: sub_11FF9+45Fj
		push	si
		push	ds
		push	es
		mov	bx, di
		les	di, [bp+2]
		add	bp, 6
		cmp	word ptr [bp+0], 3
		ja	short loc_12486
		jmp	loc_120CB
; ---------------------------------------------------------------------------

loc_12486:				; CODE XREF: sub_11FF9+488j
		lds	si, [bp+2]

loc_12489:				; CODE XREF: sub_11FF9+4ECj
		add	bp, 2
		mov	word ptr [bp+0], 2
		xor	cx, cx

loc_12493:				; CODE XREF: sub_11FF9+4A2j
		lodsb
		scasb
		jb	short loc_1249E
		ja	short loc_1249D
		or	al, al
		jnz	short loc_12493

loc_1249D:				; CODE XREF: sub_11FF9+49Ej
		dec	cx

loc_1249E:				; CODE XREF: sub_11FF9+49Cj
		mov	[bp+2],	cx
		mov	di, bx
		pop	es
		pop	ds
		pop	si
		retn
; ---------------------------------------------------------------------------

loc_124A7:				; CODE XREF: sub_11FF9+4j
					; DATA XREF: sub_11FF9:sx60_JumpTblo
		cmp	dx, 2
		jnb	short loc_124AF
		jmp	loc_1240D
; ---------------------------------------------------------------------------

loc_124AF:				; CODE XREF: sub_11FF9+4B1j
		dec	dx
		cmp	word ptr [bp+0], 3
		ja	short loc_124CE
		mov	ax, [bp+2]
		add	bp, 4
		cmp	[bp+2],	ax
		jl	short loc_124C8
		mov	ax, 0FFFFh
		mov	[bp+2],	ax
		retn
; ---------------------------------------------------------------------------

loc_124C8:				; CODE XREF: sub_11FF9+4C6j
		xor	ax, ax
		mov	[bp+2],	ax
		retn
; ---------------------------------------------------------------------------

loc_124CE:				; CODE XREF: sub_11FF9+4BBj
		push	si
		push	ds
		push	es
		mov	bx, di
		lds	si, [bp+2]
		add	bp, 6
		cmp	word ptr [bp+0], 3
		ja	short loc_124E2
		jmp	loc_120CB
; ---------------------------------------------------------------------------

loc_124E2:				; CODE XREF: sub_11FF9+4E4j
		les	di, [bp+2]
		jmp	short loc_12489
sub_11FF9	endp ; sp-analysis failed


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

scrA0		proc near		; CODE XREF: sub_1180D-208p
					; scrEvalExpr:loc_11FDAp

var_0		= word ptr  0
var_s2		= word ptr  2

		push	dx
		push	bp
		mov	bp, sp
		mov	cx, ax
		xor	ax, ax
		lodsb
		mov	dx, ax
		shl	ax, 1
		add	ax, dx
		shl	ax, 1
		sub	sp, ax
		mov	ax, sp
		push	bp
		push	cx
		push	ax
		mov	bp, ax
		or	dx, dx
		jz	short loc_12525

loc_12505:				; CODE XREF: scrA0+34j
		call	scrEvalExpr
		mov	[bp+var_0], cx
		mov	[bp+var_s2], ax
		mov	[bp+4],	bx
		add	bp, 6
		lodsb
		cmp	al, 1
		jz	short loc_1251A
		dec	si

loc_1251A:				; CODE XREF: scrA0+30j
		dec	dx
		jnz	short loc_12505
		lodsb
		cmp	al, 2
		jz	short loc_12525
		jmp	loc_115CE
; ---------------------------------------------------------------------------

loc_12525:				; CODE XREF: scrA0+1Cj	scrA0+39j
		pop	bp
		pop	ax
		call	sub_12530
		pop	bp
		mov	sp, bp
		pop	bp
		pop	dx
		retn
scrA0		endp


; =============== S U B	R O U T	I N E =======================================


sub_12530	proc near		; CODE XREF: scrA0+40p

; FUNCTION CHUNK AT 296D SIZE 000000E4 BYTES
; FUNCTION CHUNK AT 2AA3 SIZE 000000BF BYTES
; FUNCTION CHUNK AT 2B91 SIZE 0000005D BYTES
; FUNCTION CHUNK AT 2C02 SIZE 00000027 BYTES
; FUNCTION CHUNK AT 2C2B SIZE 00000252 BYTES
; FUNCTION CHUNK AT 2EA7 SIZE 0000004A BYTES
; FUNCTION CHUNK AT 2F12 SIZE 00000052 BYTES
; FUNCTION CHUNK AT 2F68 SIZE 00000062 BYTES
; FUNCTION CHUNK AT 303D SIZE 000000CA BYTES

		or	ah, ah
		jnz	short loc_1254B
		sub	al, 0A0h
		cmp	al, 30h
		jnb	short loc_12547
		shl	ax, 1
		mov	bx, ax
		jmp	cs:off_12565[bx]
; ---------------------------------------------------------------------------

loc_12543:				; CODE XREF: sub_12530+32j
		mov	al, 1
		int	0BEh		; used by BASIC	while in interpreter

loc_12547:				; CODE XREF: sub_12530+8j sub_12530+Ej ...
		mov	al, 0
		int	0BEh		; used by BASIC	while in interpreter

loc_1254B:				; CODE XREF: sub_12530+2j
		and	ah, 0Fh
		cmp	ah, 8
		jnb	short loc_12547
		xor	bx, bx
		xchg	ah, bl
		shl	bx, 1
		shl	bx, 1
		add	bx, offset byte_1380E
		call	dword ptr cs:[bx]
		jb	short loc_12543
		retn
; ---------------------------------------------------------------------------
off_12565	dw offset loc_125C5	; 0 ; DATA XREF: sub_12530+Er
		dw offset loc_125FE	; 1
		dw offset loc_12619	; 2
		dw offset loc_12631	; 3
		dw offset loc_1265E	; 4
		dw offset loc_12694	; 5
		dw offset loc_126DB	; 6
		dw offset loc_12736	; 7
		dw offset loc_12547	; 8
		dw offset loc_12547	; 9
		dw offset loc_12547	; 0Ah
		dw offset loc_12547	; 0Bh
		dw offset scr_ReadSysSave; 0Ch
		dw offset scr_WriteSysSave; 0Dh
		dw offset loc_1283C	; 0Eh
		dw offset loc_128DD	; 0Fh
		dw offset loc_12B91	; 10h
		dw offset loc_12B9E	; 11h
		dw offset loc_12BB2	; 12h
		dw offset loc_12BDB	; 13h
		dw offset loc_12C02	; 14h
		dw offset loc_12C20	; 15h
		dw offset loc_12C2B	; 16h
		dw offset loc_12C55	; 17h
		dw offset loc_12CF8	; 18h
		dw offset loc_12D14	; 19h
		dw offset loc_12D62	; 1Ah
		dw offset loc_12DDE	; 1Bh
		dw offset loc_12E07	; 1Ch
		dw offset loc_12E5F	; 1Dh
		dw offset loc_12547	; 1Eh
		dw offset loc_12547	; 1Fh
		dw offset loc_12EA7	; 20h
		dw offset loc_12ECE	; 21h
		dw offset loc_12F12	; 22h
		dw offset loc_12F26	; 23h
		dw offset loc_12F68	; 24h
		dw offset loc_12547	; 25h
		dw offset loc_1303D	; 26h
		dw offset loc_13071	; 27h
		dw offset loc_13092	; 28h
		dw offset loc_130EA	; 29h
		dw offset scr_ReadStorySave; 2Ah
		dw offset scr_WriteStorySave; 2Bh
		dw offset loc_12AA3	; 2Ch
		dw offset loc_12ADA	; 2Dh
		dw offset loc_12B44	; 2Eh
		dw offset loc_12B1E	; 2Fh
; ---------------------------------------------------------------------------

loc_125C5:				; CODE XREF: sub_12530+Ej
					; DATA XREF: sub_12530:off_12565o
		mov	ax, [bp+2]
		mov	cx, [bp+8]
		cmp	cx, 400h
		jnb	short loc_125FA
		sub	cx, ax
		jb	short loc_125FA
		inc	cx
		mov	dx, es
		mov	bx, di
		shl	ax, 1
		les	di, cs:scrRegMemPtr
		add	di, ax
		xor	ax, ax
		test	word ptr [bp+0Ch], 0FFFFh
		js	short loc_125EF
		mov	ax, [bp+0Eh]

loc_125EF:				; CODE XREF: sub_12530+BAj
		cld
		rep stosw
		mov	es, dx
		mov	di, bx
		mov	cx, 0FFFFh
		retn
; ---------------------------------------------------------------------------

loc_125FA:				; CODE XREF: sub_12530+9Fj
					; sub_12530+A3j ...
		mov	al, 5
		int	0BEh		; used by BASIC	while in interpreter

loc_125FE:				; CODE XREF: sub_12530+Ej
					; DATA XREF: sub_12530:off_12565o
		mov	ax, [bp+2]
		cmp	ax, 400h
		jnb	short loc_125FA
		shl	ax, 1
		mov	bx, word ptr cs:scrRegMemPtr
		add	bx, ax
		mov	ax, [bp+8]
		mov	cs:[bx], ax
		mov	cx, 2
		retn
; ---------------------------------------------------------------------------

loc_12619:				; CODE XREF: sub_12530+Ej
					; DATA XREF: sub_12530:off_12565o
		mov	ax, [bp+2]
		cmp	ax, 400h
		jnb	short loc_125FA
		shl	ax, 1
		mov	bx, word ptr cs:scrRegMemPtr
		add	bx, ax
		mov	ax, cs:[bx]
		mov	cx, 2
		retn
; ---------------------------------------------------------------------------

loc_12631:				; CODE XREF: sub_12530+Ej
					; DATA XREF: sub_12530:off_12565o
		push	si
		push	di
		push	ds
		mov	dx, es
		mov	ax, [bp+2]
		cmp	ax, 8
		jnb	short loc_1265A
		xchg	ah, al
		les	di, cs:dword_1380A
		add	di, ax
		lds	si, [bp+8]
		cld

loc_1264B:				; CODE XREF: sub_12530+11Fj
		lodsb
		stosb
		or	al, al
		jnz	short loc_1264B
		mov	es, dx
		pop	ds
		pop	di
		pop	si
		mov	cx, 0FFFFh
		retn
; ---------------------------------------------------------------------------

loc_1265A:				; CODE XREF: sub_12530+10Cj
					; sub_12530+139j
		mov	al, 5
		int	0BEh		; used by BASIC	while in interpreter

loc_1265E:				; CODE XREF: sub_12530+Ej
					; DATA XREF: sub_12530:off_12565o
		push	si
		push	di
		push	ds
		mov	dx, es
		mov	ax, [bp+2]
		cmp	ax, 8
		jnb	short loc_1265A
		xchg	ah, al
		lds	si, cs:dword_1380A
		add	si, ax
		les	di, cs:somePtr
		mov	bx, di
		cld

loc_1267C:				; CODE XREF: sub_12530+150j
		lodsb
		stosb
		or	al, al
		jnz	short loc_1267C
		mov	word ptr cs:somePtr, di
		mov	ax, bx
		mov	bx, es
		mov	es, dx
		pop	ds
		pop	di
		pop	si
		mov	cx, 7
		retn
; ---------------------------------------------------------------------------

loc_12694:				; CODE XREF: sub_12530+Ej
					; DATA XREF: sub_12530:off_12565o
		push	di
		push	es
		mov	ax, [bp+2]
		shl	al, 1
		mov	di, cs:word_13806
		add	di, ax
		mov	ax, cs:[di]
		or	ax, ax
		jz	short loc_126D3
		mov	es, ax
		xor	di, di
		mov	cx, es:[di]
		mov	word ptr es:4, 0
		inc	ax
		mov	es, ax
		mov	ax, di
		test	word ptr [bp+6], 0FFFFh
		js	short loc_126C8
		mov	ax, [bp+8]
		mov	ah, al

loc_126C8:				; CODE XREF: sub_12530+191j
		shl	cx, 3
		rep stosw
		pop	es
		pop	di
		mov	cx, 0FFFFh
		retn
; ---------------------------------------------------------------------------

loc_126D3:				; CODE XREF: sub_12530+177j
					; sub_12530+1C1j
		mov	al, 7
		int	0BEh		; used by BASIC	while in interpreter
		mov	al, 6
		int	0BEh		; used by BASIC	while in interpreter

loc_126DB:				; CODE XREF: sub_12530+Ej
					; DATA XREF: sub_12530:off_12565o
		push	si
		push	di
		push	ds
		push	es
		cld
		mov	ax, [bp+2]
		shl	ax, 1
		mov	di, cs:word_13806
		add	di, ax
		mov	ax, cs:[di]
		or	ax, ax
		jz	short loc_126D3
		mov	es, ax
		xor	di, di
		mov	cx, es:[di]
		mov	dx, es:4
		inc	ax
		mov	es, ax
		test	word ptr [bp+0Ch], 0FFFFh
		js	short loc_12717
		mov	dx, [bp+0Eh]
		or	dx, dx
		jnz	short loc_12717
		xor	ax, ax
		shl	cx, 3
		rep stosw

loc_12717:				; CODE XREF: sub_12530+1D7j
					; sub_12530+1DEj
		mov	di, dx
		lds	si, [bp+8]

loc_1271C:				; CODE XREF: sub_12530+1F0j
		lodsb
		stosb
		or	al, al
		jnz	short loc_1271C
		stosb
		mov	ax, es
		dec	ax
		mov	ds, ax
		assume ds:nothing
		mov	ds:4, di
		mov	ax, dx
		mov	cx, 2
		pop	es
		pop	ds
		assume ds:nothing
		pop	di
		pop	si
		retn
; ---------------------------------------------------------------------------

loc_12736:				; CODE XREF: sub_12530+Ej
					; DATA XREF: sub_12530:off_12565o
		push	di
		push	es
		mov	ax, [bp+2]
		shl	al, 1
		mov	di, cs:word_13806
		add	di, ax
		mov	ax, cs:[di]
		or	ax, ax
		jz	short loc_12777
		inc	ax
		mov	es, ax
		xor	di, di
		mov	ax, di
		mov	bx, [bp+8]
		or	bx, bx
		jz	short loc_12766

loc_12759:				; CODE XREF: sub_12530+234j
		cmp	es:[di], al
		jz	short loc_12770
		mov	cx, 0FFFFh
		repne scasb
		dec	bx
		jnz	short loc_12759

loc_12766:				; CODE XREF: sub_12530+227j
		mov	bx, es
		mov	ax, di

loc_1276A:				; CODE XREF: sub_12530+245j
		mov	cx, 7
		pop	es
		pop	di
		retn
; ---------------------------------------------------------------------------

loc_12770:				; CODE XREF: sub_12530+22Cj
		mov	bx, cs
		mov	ax, offset word_12C29
		jmp	short loc_1276A
; ---------------------------------------------------------------------------

loc_12777:				; CODE XREF: sub_12530+219j
		mov	al, 7
		int	0BEh		; used by BASIC	while in interpreter
		mov	al, 5
		int	0BEh		; used by BASIC	while in interpreter

scr_ReadSysSave:			; CODE XREF: sub_12530+Ej
					; DATA XREF: sub_12530:off_12565o
		push	si
		push	ds
		push	es
		lds	si, [bp+2]
		call	OpenSave_Read
		or	ax, ax
		js	short loc_127D4
		mov	dx, ax
		xor	ax, ax
		test	word ptr [bp+6], 0FFFFh
		js	short loc_1279A
		mov	ax, [bp+8]

loc_1279A:				; CODE XREF: sub_12530+265j
		mov	cx, 3FFh
		test	word ptr [bp+0Ch], 0FFFFh
		js	short loc_127AD
		mov	cx, [bp+0Eh]
		cmp	cx, 400h
		jnb	short loc_127D9

loc_127AD:				; CODE XREF: sub_12530+272j
		sub	cx, ax
		jb	short loc_127D9
		inc	cx
		shl	cx, 1
		shl	ax, 1
		add	ax, word ptr cs:scrRegMemPtr
		mov	bx, dx
		mov	dx, ax
		push	cs
		pop	ds
		assume ds:seg000
		mov	ah, 3Fh
		int	21h		; DOS -	2+ - READ FROM FILE WITH HANDLE
					; BX = file handle, CX = number	of bytes to read
					; DS:DX	-> buffer
		jb	short loc_127DD
		mov	ah, 3Eh
		int	21h		; DOS -	2+ - CLOSE A FILE WITH HANDLE
					; BX = file handle
		xor	ax, ax

loc_127CD:				; CODE XREF: sub_12530+2A7j
		pop	es
		pop	ds
		assume ds:nothing
		pop	si
		mov	cx, 2
		retn
; ---------------------------------------------------------------------------

loc_127D4:				; CODE XREF: sub_12530+25Aj
		mov	ax, 0FFFFh
		jmp	short loc_127CD
; ---------------------------------------------------------------------------

loc_127D9:				; CODE XREF: sub_12530+27Bj
					; sub_12530+27Fj
		mov	al, 5
		int	0BEh		; used by BASIC	while in interpreter

loc_127DD:				; CODE XREF: sub_12530+295j
		mov	al, 29h
		int	0BEh		; used by BASIC	while in interpreter

scr_WriteSysSave:			; CODE XREF: sub_12530+Ej
					; DATA XREF: sub_12530:off_12565o
		push	si
		push	ds
		push	es
		xor	ax, ax
		test	word ptr [bp+6], 0FFFFh
		js	short loc_127F0
		mov	ax, [bp+8]

loc_127F0:				; CODE XREF: sub_12530+2BBj
		mov	cx, 3FFh
		test	word ptr [bp+0Ch], 0FFFFh
		js	short loc_12803
		mov	cx, [bp+0Eh]
		cmp	cx, 400h
		jnb	short loc_12834

loc_12803:				; CODE XREF: sub_12530+2C8j
		sub	cx, ax
		jb	short loc_12834
		inc	cx
		shl	cx, 1
		shl	ax, 1
		add	ax, word ptr cs:scrRegMemPtr
		mov	dx, ax
		push	cx
		push	dx
		lds	si, [bp+2]
		call	OpenSave_Write
		mov	bx, ax
		pop	dx
		pop	cx
		push	cs
		pop	ds
		assume ds:seg000
		mov	ah, 40h
		int	21h		; DOS -	2+ - WRITE TO FILE WITH	HANDLE
					; BX = file handle, CX = number	of bytes to write, DS:DX -> buffer
		jb	short loc_12838
		mov	ah, 3Eh
		int	21h		; DOS -	2+ - CLOSE A FILE WITH HANDLE
					; BX = file handle
		xor	ax, ax
		pop	es
		pop	ds
		assume ds:nothing
		pop	si
		mov	cx, 2
		retn
; ---------------------------------------------------------------------------

loc_12834:				; CODE XREF: sub_12530+2D1j
					; sub_12530+2D5j
		mov	al, 5
		int	0BEh		; used by BASIC	while in interpreter

loc_12838:				; CODE XREF: sub_12530+2F5j
		mov	al, 2Ah
		int	0BEh		; used by BASIC	while in interpreter

loc_1283C:				; CODE XREF: sub_12530+Ej
					; DATA XREF: sub_12530:off_12565o
		push	si
		push	ds
		push	es
		lds	si, [bp+2]
		push	cs
		pop	es
		assume es:seg000
		mov	dx, offset fullFilePath
		xor	al, al
		call	BuildAbsolutePath
		push	cs
		pop	ds
		assume ds:seg000
		mov	dx, offset fullFilePath

loc_12851:				; CODE XREF: sub_12530+3A2j
		xor	ax, ax
		call	OpenFileRead2
		jb	short loc_128CE
		mov	dx, ax
		mov	ax, [bp+8]
		shl	al, 1
		mov	bx, cs:word_13806
		add	bx, ax
		mov	ax, cs:[bx]
		or	ax, ax
		jz	short loc_12877
		mov	ds, ax
		assume ds:nothing
		xor	bx, bx
		mov	cx, [bx]
		mov	ds, ax
		jmp	short loc_128B5
; ---------------------------------------------------------------------------

loc_12877:				; CODE XREF: sub_12530+33Bj
		mov	si, bx
		mov	bx, dx
		call	sub_10658
		add	ax, 0Fh
		shr	ax, 4
		shl	bl, 4
		or	ah, bl
		cmp	ax, 1000h
		ja	short loc_128D5
		mov	bx, ax
		mov	cx, ax
		inc	bx
		xor	ax, ax
		call	AllocFileMem
		jnb	short loc_1289D
		jmp	loc_11B25
; ---------------------------------------------------------------------------

loc_1289D:				; CODE XREF: sub_12530+368j
		mov	cs:[si], ax
		mov	ds, ax
		xor	bx, bx
		mov	[bx], cx
		mov	[bx+2],	bx
		mov	[bx+4],	bx
		mov	[bx+6],	bx
		mov	[bx+8],	bx
		mov	[bx+0Ah], bx

loc_128B5:				; CODE XREF: sub_12530+345j
		mov	ax, ds
		inc	ax
		mov	ds, ax
		assume ds:nothing
		mov	bx, dx
		xor	dx, dx
		call	ReadRawFile
		mov	ah, 3Eh
		int	21h		; DOS -	2+ - CLOSE A FILE WITH HANDLE
					; BX = file handle
		xor	ax, ax
		pop	es
		assume es:nothing
		pop	ds
		assume ds:nothing
		pop	si
		mov	cx, 2
		retn
; ---------------------------------------------------------------------------

loc_128CE:				; CODE XREF: sub_12530+326j
		mov	al, 40h	; '@'
		int	0BEh		; used by BASIC	while in interpreter
		jmp	loc_12851
; ---------------------------------------------------------------------------

loc_128D5:				; CODE XREF: sub_12530+35Cj
		mov	al, 15h
		int	0BEh		; used by BASIC	while in interpreter
		mov	al, 20h	; ' '
		int	0BEh		; used by BASIC	while in interpreter

loc_128DD:				; CODE XREF: sub_12530+Ej
					; DATA XREF: sub_12530:off_12565o
		push	si
		push	ds
		push	es
		mov	ax, [bp+8]
		add	ax, ax
		mov	bx, cs:word_13806
		add	bx, ax
		test	word ptr cs:[bx], 0FFFFh
		jz	short loc_12941
		lds	si, [bp+2]
		call	OpenSave_Write
		mov	dx, ax
		mov	ax, cs:[bx]
		mov	ds, ax
		xor	bx, bx
		mov	cx, [bx]
		inc	ax
		mov	ds, ax
		mov	bx, dx
		xor	dx, dx
		cmp	cx, 800h
		jbe	short loc_12929
		push	cx
		mov	cx, 8000h
		mov	ah, 40h
		int	21h		; DOS -	2+ - WRITE TO FILE WITH	HANDLE
					; BX = file handle, CX = number	of bytes to write, DS:DX -> buffer
		jb	short loc_1293D
		pop	cx
		sub	cx, 800h
		mov	ax, ds
		add	ax, 800h
		mov	ds, ax
		assume ds:nothing
		xor	dx, dx

loc_12929:				; CODE XREF: sub_12530+3DFj
		shl	cx, 4
		mov	ah, 40h
		int	21h		; DOS -	2+ - WRITE TO FILE WITH	HANDLE
					; BX = file handle, CX = number	of bytes to write, DS:DX -> buffer
		jb	short loc_1293D
		mov	ah, 3Eh
		int	21h		; DOS -	2+ - CLOSE A FILE WITH HANDLE
					; BX = file handle
		pop	es
		pop	ds
		assume ds:nothing
		pop	si
		mov	cx, 0FFFFh
		retn
; ---------------------------------------------------------------------------

loc_1293D:				; CODE XREF: sub_12530+3E9j
					; sub_12530+400j
		mov	al, 2Ah	; '*'
		int	0BEh		; used by BASIC	while in interpreter

loc_12941:				; CODE XREF: sub_12530+3C1j
		mov	al, 7
		int	0BEh		; used by BASIC	while in interpreter
sub_12530	endp ; sp-analysis failed


; =============== S U B	R O U T	I N E =======================================


OpenSave_Read	proc near		; CODE XREF: sub_12530+255p
					; sub_12530+443p ...
		push	cs
		pop	es
		assume es:seg000
		mov	dx, offset fullFilePath
		xor	al, al
		call	BuildAbsolutePath
		push	cs
		pop	ds
		assume ds:seg000
		mov	dx, offset fullFilePath
		xor	ax, ax
		jmp	OpenFileRead2
OpenSave_Read	endp


; =============== S U B	R O U T	I N E =======================================


OpenSave_Write	proc near		; CODE XREF: sub_12530+2E8p
					; sub_12530+3C6p ...

; FUNCTION CHUNK AT 033F SIZE 0000004E BYTES

		push	cs
		pop	es
		mov	dx, offset fullFilePath
		xor	al, al
		call	BuildAbsolutePath
		push	cs
		pop	ds
		mov	dx, offset fullFilePath
		mov	al, 20h
		jmp	OpenFileWrite
OpenSave_Write	endp ; sp-analysis failed

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_12530

scr_ReadStorySave:			; CODE XREF: sub_12530+Ej
					; DATA XREF: sub_12530:off_12565o
		push	si
		push	ds
		push	es
		lds	si, [bp+2]
		assume ds:nothing
		call	OpenSave_Read
		or	ax, ax
		js	short loc_129BA
		mov	bx, ax
		sub	sp, 40h
		mov	dx, sp
		mov	si, dx
		push	ss
		pop	ds
		mov	cx, 40h
		mov	ah, 3Fh
		int	21h		; DOS -	2+ - READ FROM FILE WITH HANDLE
					; BX = file handle, CX = number	of bytes to read
					; DS:DX	-> buffer
		jb	short loc_129BA
		mov	dx, [si+8]
		xor	cx, cx
		mov	ax, 4201h
		int	21h		; DOS -	2+ - MOVE FILE READ/WRITE POINTER (LSEEK)
					; AL = method: offset from present location
		push	cs
		pop	ds
		assume ds:seg000
		mov	dx, word ptr scrRegMemPtr
		mov	cx, 800h
		mov	ah, 3Fh
		int	21h		; DOS -	2+ - READ FROM FILE WITH HANDLE
					; BX = file handle, CX = number	of bytes to read
					; DS:DX	-> buffer
		jb	short loc_129BA
		call	DecryptSaveData
		mov	ah, 3Eh
		int	21h		; DOS -	2+ - CLOSE A FILE WITH HANDLE
					; BX = file handle
		xor	ax, ax
		add	sp, 40h
		pop	es
		assume es:nothing
		pop	ds
		assume ds:nothing
		pop	si
		mov	cx, 2
		retn
; ---------------------------------------------------------------------------

loc_129BA:				; CODE XREF: sub_12530+448j
					; sub_12530+45Cj ...
		mov	al, 29h
		int	0BEh		; used by BASIC	while in interpreter

scr_WriteStorySave:			; CODE XREF: sub_12530+Ej
					; DATA XREF: sub_12530:off_12565o
		push	si
		push	di
		push	ds
		push	es
		lds	si, [bp+2]
		call	OpenSave_Write
		mov	dx, ax
		sub	sp, 40h
		mov	si, sp
		push	ss
		pop	es
		mov	di, si
		xor	ax, ax
		mov	cx, 20h
		rep stosw
		les	di, [bp+8]
		mov	cx, 0FFFFh
		repne scasb
		not	cx
		mov	ss:[si+8], cx
		push	ss
		pop	es
		lea	bx, [si+0Ah]
		xor	ah, ah
		int	1Ch		; CLOCK	TICK
		push	si
		lea	di, [si+20h]
		lds	si, cs:gscFilePtr
		add	si, 20h

loc_129FD:				; CODE XREF: sub_12530+4D1j
		lodsb
		stosb
		or	al, al
		jnz	short loc_129FD
		pop	si
		push	ss
		pop	ds
		mov	ax, word ptr cs:DiskDriveIDs
		mov	[si+6],	ax
		mov	bx, dx
		mov	dx, si
		mov	cx, 40h
		mov	ah, 40h
		int	21h		; DOS -	2+ - WRITE TO FILE WITH	HANDLE
					; BX = file handle, CX = number	of bytes to write, DS:DX -> buffer
		jb	short loc_12A4D
		lds	dx, [bp+8]
		mov	cx, ss:[si+8]
		mov	ah, 40h
		int	21h		; DOS -	2+ - WRITE TO FILE WITH	HANDLE
					; BX = file handle, CX = number	of bytes to write, DS:DX -> buffer
		jb	short loc_12A4D
		push	cs
		pop	ds
		assume ds:seg000
		mov	dx, word ptr scrRegMemPtr
		call	EncryptSaveData
		mov	cx, 800h
		mov	ah, 40h
		int	21h		; DOS -	2+ - WRITE TO FILE WITH	HANDLE
					; BX = file handle, CX = number	of bytes to write, DS:DX -> buffer
		jb	short loc_12A4D
		call	DecryptSaveData
		mov	ah, 3Eh
		int	21h		; DOS -	2+ - CLOSE A FILE WITH HANDLE
					; BX = file handle
		xor	ax, ax
		add	sp, 40h
		pop	es
		pop	ds
		assume ds:nothing
		pop	di
		pop	si
		mov	cx, 2
		retn
; ---------------------------------------------------------------------------

loc_12A4D:				; CODE XREF: sub_12530+4E8j
					; sub_12530+4F5j ...
		mov	al, 2Ah
		int	0BEh		; used by BASIC	while in interpreter
; END OF FUNCTION CHUNK	FOR sub_12530

; =============== S U B	R O U T	I N E =======================================


EncryptSaveData	proc near		; CODE XREF: sub_12530+4FDp
		push	bx
		push	si
		mov	si, dx
		mov	cx, 400h
		xor	bx, bx

loc_12A5A:				; CODE XREF: EncryptSaveData+1Bj
		lodsw
		rol	ah, 2
		ror	al, 2
		xor	ax, bx
		not	ah
		neg	al
		mov	[si-2],	ax
		mov	bx, ax
		loop	loc_12A5A
		pop	si
		pop	bx
		retn
EncryptSaveData	endp


; =============== S U B	R O U T	I N E =======================================


DecryptSaveData	proc near		; CODE XREF: sub_12530+477p
					; sub_12530+509p
		push	bx
		push	si
		mov	si, dx
		add	si, 7FEh
		mov	cx, 3FFh

loc_12A7C:				; CODE XREF: DecryptSaveData+1Fj
		mov	ax, [si]
		not	ah
		neg	al
		xor	ax, [si-2]
		ror	ah, 2
		rol	al, 2
		mov	[si], ax
		sub	si, 2
		loop	loc_12A7C
		mov	ax, [si]
		not	ah
		neg	al
		ror	ah, 2
		rol	al, 2
		mov	[si], ax
		pop	si
		pop	bx
		retn
DecryptSaveData	endp

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_12530

loc_12AA3:				; CODE XREF: sub_12530+Ej
					; DATA XREF: sub_12530:off_12565o
		push	si
		push	di
		push	ds
		push	es
		sub	sp, 40h
		mov	di, sp
		call	sub_12B62
		mov	cx, [di+8]
		lds	dx, cs:somePtr
		mov	ah, 3Fh
		int	21h		; DOS -	2+ - READ FROM FILE WITH HANDLE
					; BX = file handle, CX = number	of bytes to read
					; DS:DX	-> buffer
		jnb	short loc_12AC0
		jmp	loc_12B7C
; ---------------------------------------------------------------------------

loc_12AC0:				; CODE XREF: sub_12530+58Bj
					; sub_12530+5ECj ...
		mov	ah, 3Eh
		int	21h		; DOS -	2+ - CLOSE A FILE WITH HANDLE
					; BX = file handle
		mov	ax, dx
		add	dx, cx
		mov	word ptr cs:somePtr, dx
		mov	bx, ds
		mov	cx, 7

loc_12AD2:				; CODE XREF: sub_12530+62Fj
		add	sp, 40h
		pop	es
		pop	ds
		pop	di
		pop	si
		retn
; ---------------------------------------------------------------------------

loc_12ADA:				; CODE XREF: sub_12530+Ej
					; DATA XREF: sub_12530:off_12565o
		push	si
		push	di
		push	ds
		push	es
		sub	sp, 40h
		mov	di, sp
		call	sub_12B62
		push	ss
		pop	ds
		lea	si, [di+0Ah]
		les	di, cs:somePtr
		mov	dx, di
		mov	cl, 2Fh	; '/'
		call	sub_12B80
		lodsb
		shr	al, 4
		mov	ah, 30h	; '0'
		add	al, ah
		xchg	al, ah
		stosw
		mov	al, cl
		stosb
		mov	cl, 20h	; ' '
		call	sub_12B80
		mov	cl, 3Ah	; ':'
		call	sub_12B80
		call	sub_12B80
		xor	cl, cl
		call	sub_12B80
		mov	cx, 12h
		push	es
		pop	ds
		jmp	short loc_12AC0
; ---------------------------------------------------------------------------

loc_12B1E:				; CODE XREF: sub_12530+Ej
					; DATA XREF: sub_12530:off_12565o
		push	si
		push	di
		push	ds
		push	es
		sub	sp, 40h
		mov	di, sp
		call	sub_12B62
		push	ss
		pop	ds
		lea	si, [di+20h]
		les	di, cs:somePtr
		mov	dx, di
		xor	cx, cx

loc_12B38:				; CODE XREF: sub_12530+60Dj
		inc	cx
		lodsb
		stosb
		or	al, al
		jnz	short loc_12B38
		push	es
		pop	ds
		jmp	loc_12AC0
; ---------------------------------------------------------------------------

loc_12B44:				; CODE XREF: sub_12530+Ej
					; DATA XREF: sub_12530:off_12565o
		push	si
		push	di
		push	ds
		push	es
		sub	sp, 40h
		mov	di, sp
		call	sub_12B62
		mov	ah, 3Eh
		int	21h		; DOS -	2+ - CLOSE A FILE WITH HANDLE
					; BX = file handle
		mov	ax, ss:[di+6]
		xchg	al, ah
		xor	bx, bx
		mov	cx, 2
		jmp	loc_12AD2
; END OF FUNCTION CHUNK	FOR sub_12530

; =============== S U B	R O U T	I N E =======================================


sub_12B62	proc near		; CODE XREF: sub_12530+57Cp
					; sub_12530+5B3p ...
		lds	si, [bp+2]
		call	OpenSave_Read
		or	ax, ax
		js	short loc_12B7C
		mov	bx, ax
		mov	dx, di
		push	ss
		pop	ds
		mov	cx, 40h
		mov	ah, 3Fh
		int	21h		; DOS -	2+ - READ FROM FILE WITH HANDLE
					; BX = file handle, CX = number	of bytes to read
					; DS:DX	-> buffer
		jb	short loc_12B7C
		retn
; ---------------------------------------------------------------------------

loc_12B7C:				; CODE XREF: sub_12530+58Dj
					; sub_12B62+8j	...
		mov	al, 29h
		int	0BEh		; used by BASIC	while in interpreter
sub_12B62	endp ; sp-analysis failed


; =============== S U B	R O U T	I N E =======================================


sub_12B80	proc near		; CODE XREF: sub_12530+5C4p
					; sub_12530+5D7p ...
		lodsb
		mov	ah, al
		shr	al, 4
		and	ah, 0Fh
		add	ax, 3030h
		stosw
		mov	al, cl
		stosb
		retn
sub_12B80	endp

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_12530

loc_12B91:				; CODE XREF: sub_12530+Ej
					; DATA XREF: sub_12530:off_12565o
		mov	ax, [bp+2]
		or	ax, ax
		jns	short loc_12B9A
		neg	ax

loc_12B9A:				; CODE XREF: sub_12530+666j
		mov	cx, 2
		retn
; ---------------------------------------------------------------------------

loc_12B9E:				; CODE XREF: sub_12530+Ej
					; DATA XREF: sub_12530:off_12565o
		mov	cx, 2
		mov	ax, [bp+2]
		or	ax, ax
		jns	short loc_12BAC
		mov	ax, 0FFFFh
		retn
; ---------------------------------------------------------------------------

loc_12BAC:				; CODE XREF: sub_12530+676j
		jz	short locret_12BB1
		mov	ax, 1

locret_12BB1:				; CODE XREF: sub_12530:loc_12BACj
		retn
; ---------------------------------------------------------------------------

loc_12BB2:				; CODE XREF: sub_12530+Ej
					; DATA XREF: sub_12530:off_12565o
		mov	ax, [bp+2]
		test	byte ptr [bp+0], 0FFh
		jns	short loc_12BD6
		push	es
		push	ss
		pop	es
		sub	sp, 6
		mov	bx, sp
		xor	ah, ah
		int	1Ch		; CLOCK	TICK
		mov	ax, es:[bx]
		add	ax, es:[bx+2]
		xor	ax, es:[bx+4]
		add	sp, 6
		pop	es

loc_12BD6:				; CODE XREF: sub_12530+689j
		mov	cs:word_12C00, ax
		retn
; ---------------------------------------------------------------------------

loc_12BDB:				; CODE XREF: sub_12530+Ej
					; DATA XREF: sub_12530:off_12565o
		call	sub_12BEE
		mov	bx, dx
		mul	word ptr [bp+2]
		mov	ax, dx
		and	ah, 7Fh
		mov	cx, 2
		mov	dx, bx
		retn
; END OF FUNCTION CHUNK	FOR sub_12530

; =============== S U B	R O U T	I N E =======================================


sub_12BEE	proc near		; CODE XREF: sub_12530:loc_12BDBp
		mov	ax, cs:word_12C00
		push	dx
		push	ax
		mov	dx, 899
		mul	dx
		mov	cs:word_12C00, ax
		pop	ax
		pop	dx
		retn
sub_12BEE	endp

; ---------------------------------------------------------------------------
word_12C00	dw 7FF9h		; DATA XREF: sub_12530:loc_12BD6w
					; sub_12BEEr ...
; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_12530

loc_12C02:				; CODE XREF: sub_12530+Ej
					; DATA XREF: sub_12530:off_12565o
		mov	dx, es
		les	bx, [bp+2]
		mov	cx, 2
		mov	ax, es:[bx]
		or	al, al
		jz	short loc_12C1A
		or	ah, ah
		jz	short loc_12C17
		xchg	ah, al

loc_12C17:				; CODE XREF: sub_12530+6E3j
		mov	es, dx
		retn
; ---------------------------------------------------------------------------

loc_12C1A:				; CODE XREF: sub_12530+6DFj
		mov	ax, 0FFFFh
		mov	es, dx
		retn
; ---------------------------------------------------------------------------

loc_12C20:				; CODE XREF: sub_12530+Ej
					; DATA XREF: sub_12530:off_12565o
		mov	bx, cs
		mov	ax, offset word_12C29
		mov	cx, 7
		retn
; END OF FUNCTION CHUNK	FOR sub_12530
; ---------------------------------------------------------------------------
word_12C29	dw 0			; DATA XREF: sub_12530+242o
					; sub_12530+6F2o
; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_12530

loc_12C2B:				; CODE XREF: sub_12530+Ej
					; DATA XREF: sub_12530:off_12565o
		push	es
		mov	bx, di
		mov	ax, [bp+2]
		les	di, cs:somePtr
		mov	cx, di
		or	ah, ah
		jz	short loc_12C41
		xchg	ah, al
		stosb
		xchg	ah, al

loc_12C41:				; CODE XREF: sub_12530+70Aj
		stosb
		xor	al, al
		stosb
		mov	word ptr cs:somePtr, di
		mov	di, bx
		mov	bx, es
		mov	ax, cx
		mov	cx, 7
		pop	es
		retn
; ---------------------------------------------------------------------------

loc_12C55:				; CODE XREF: sub_12530+Ej
					; DATA XREF: sub_12530:off_12565o
		push	es
		push	di
		mov	ax, [bp+2]
		mov	bx, [bp+8]
		les	di, cs:somePtr
		push	di
		cmp	ax, 2
		jz	short loc_12C76
		cmp	ax, 0Ah
		jz	short loc_12C95
		cmp	ax, 10h
		jz	short loc_12CC1
		mov	al, 5
		int	0BEh		; used by BASIC	while in interpreter

loc_12C76:				; CODE XREF: sub_12530+736j
		mov	cx, 0Fh
		mov	ah, ch

loc_12C7B:				; CODE XREF: sub_12530:loc_12C8Aj
		mov	al, 31h	; '1'
		shl	bx, 1
		jb	short loc_12C87
		or	ah, ah
		jz	short loc_12C8A
		dec	al

loc_12C87:				; CODE XREF: sub_12530+74Fj
		dec	ah
		stosb

loc_12C8A:				; CODE XREF: sub_12530+753j
		loop	loc_12C7B
		mov	al, 30h	; '0'
		shl	bx, 1
		adc	al, bl
		stosb
		jmp	short loc_12CE7
; ---------------------------------------------------------------------------

loc_12C95:				; CODE XREF: sub_12530+73Bj
		push	0Ah
		push	64h ; 'd'
		push	3E8h
		push	2710h
		mov	cx, 4
		mov	ax, bx

loc_12CA4:				; CODE XREF: sub_12530+78Aj
		xor	dx, dx
		pop	bx
		div	bx
		or	ax, ax
		jnz	short loc_12CB1
		or	ch, ch
		jz	short loc_12CB6

loc_12CB1:				; CODE XREF: sub_12530+77Bj
		dec	ch
		add	al, 30h	; '0'
		stosb

loc_12CB6:				; CODE XREF: sub_12530+77Fj
		mov	ax, dx
		dec	cl
		jnz	short loc_12CA4
		add	al, 30h	; '0'
		stosb
		jmp	short loc_12CE7
; ---------------------------------------------------------------------------

loc_12CC1:				; CODE XREF: sub_12530+740j
		mov	cx, 4
		mov	ah, ch

loc_12CC6:				; CODE XREF: sub_12530:loc_12CE5j
		cmp	cl, 1
		jnz	short loc_12CCD
		dec	ah

loc_12CCD:				; CODE XREF: sub_12530+799j
		rol	bx, 4
		mov	al, bl
		and	al, 0Fh
		jnz	short loc_12CDA
		or	ah, ah
		jz	short loc_12CE5

loc_12CDA:				; CODE XREF: sub_12530+7A4j
		dec	ah
		cmp	al, 9
		jbe	short loc_12CE2
		add	al, 7

loc_12CE2:				; CODE XREF: sub_12530+7AEj
		add	al, 30h	; '0'
		stosb

loc_12CE5:				; CODE XREF: sub_12530+7A8j
		loop	loc_12CC6

loc_12CE7:				; CODE XREF: sub_12530+763j
					; sub_12530+78Fj
		xor	al, al
		stosb
		mov	word ptr cs:somePtr, di
		pop	ax
		mov	bx, es
		mov	cx, 7
		pop	di
		pop	es
		retn
; ---------------------------------------------------------------------------

loc_12CF8:				; CODE XREF: sub_12530+Ej
					; DATA XREF: sub_12530:off_12565o
		mov	dx, es
		mov	bx, di
		les	di, [bp+2]
		mov	cx, 100h
		mov	al, cl
		cld
		repne scasb
		mov	ax, 0FFh
		sub	ax, cx
		mov	di, bx
		mov	es, dx
		mov	cx, 2
		retn
; ---------------------------------------------------------------------------

loc_12D14:				; CODE XREF: sub_12530+Ej
					; DATA XREF: sub_12530:off_12565o
		push	si
		push	di
		push	ds
		push	es
		cld
		les	di, [bp+2]
		xor	dx, dx
		test	word ptr [bp+0Ch], 0FFFFh
		js	short loc_12D34
		mov	dx, [bp+0Eh]
		dec	dx
		js	short loc_12D56
		mov	cx, dx
		xor	ax, ax
		repne scasb
		dec	cx
		jns	short loc_12D56

loc_12D34:				; CODE XREF: sub_12530+7F3j
		push	es
		pop	ds
		mov	si, di
		les	bx, [bp+8]
		mov	cx, dx

loc_12D3D:				; CODE XREF: sub_12530+816j
					; sub_12530+824j
		mov	di, bx
		lodsb
		or	al, al
		jz	short loc_12D56
		inc	cx
		scasb
		jnz	short loc_12D3D
		mov	dx, si

loc_12D4A:				; CODE XREF: sub_12530+820j
		cmp	es:[di], ah
		jz	short loc_12D58
		cmpsb
		jz	short loc_12D4A
		mov	si, dx
		jmp	short loc_12D3D
; ---------------------------------------------------------------------------

loc_12D56:				; CODE XREF: sub_12530+7F9j
					; sub_12530+802j ...
		xor	cx, cx

loc_12D58:				; CODE XREF: sub_12530+81Dj
		mov	ax, cx
		mov	cx, 2
		pop	es
		pop	ds
		pop	di
		pop	si
		retn
; ---------------------------------------------------------------------------

loc_12D62:				; CODE XREF: sub_12530+Ej
					; DATA XREF: sub_12530:off_12565o
		push	si
		push	di
		push	ds
		push	es
		cld
		les	di, [bp+2]
		xor	ax, ax
		mov	cx, [bp+8]
		jcxz	short loc_12DB2
		dec	cx
		repne scasb
		dec	cx
		jns	short loc_12DAB
		push	es
		pop	ds
		mov	si, di
		les	di, cs:somePtr
		mov	dx, di
		mov	cx, 0FFFFh
		test	word ptr [bp+0Ch], 0FFFFh
		js	short loc_12D8F
		mov	cx, [bp+0Eh]

loc_12D8F:				; CODE XREF: sub_12530+85Aj
					; sub_12530+865j
		lodsb
		or	al, al
		jz	short loc_12D97
		stosb
		loop	loc_12D8F

loc_12D97:				; CODE XREF: sub_12530+862j
		xor	ax, ax
		stosb

loc_12D9A:				; CODE XREF: sub_12530+8ACj
		mov	word ptr cs:somePtr, di
		mov	bx, es
		mov	ax, dx

loc_12DA3:				; CODE XREF: sub_12530+880j
		mov	cx, 7
		pop	es
		pop	ds
		pop	di
		pop	si
		retn
; ---------------------------------------------------------------------------

loc_12DAB:				; CODE XREF: sub_12530+845j
					; sub_12530+88Aj
		mov	bx, cs
		mov	ax, 2C29h
		jmp	short loc_12DA3
; ---------------------------------------------------------------------------

loc_12DB2:				; CODE XREF: sub_12530+83Fj
		mov	cx, 0FFFFh
		repne scasb
		not	cx
		dec	cx
		jz	short loc_12DAB
		test	word ptr [bp+0Ch], 0FFFFh
		js	short loc_12DCC
		mov	ax, [bp+0Eh]
		cmp	cx, ax
		jb	short loc_12DCC
		mov	cx, ax

loc_12DCC:				; CODE XREF: sub_12530+891j
					; sub_12530+898j
		inc	cx
		sub	di, cx
		push	es
		pop	ds
		mov	si, di
		les	di, cs:somePtr
		mov	dx, di
		rep movsb
		jmp	short loc_12D9A
; ---------------------------------------------------------------------------

loc_12DDE:				; CODE XREF: sub_12530+Ej
					; DATA XREF: sub_12530:off_12565o
		mov	ax, ds
		push	si
		push	ds
		lds	si, [bp+2]
		mov	si, [si]
		mov	ds, word ptr cs:gscDataPtr+2
		call	scrEvalExpr
		mov	dl, [si]
		inc	si
		cmp	dl, 1
		jz	short loc_12DFD
		cmp	dl, 3
		jz	short loc_12DFD
		dec	si

loc_12DFD:				; CODE XREF: sub_12530+8C5j
					; sub_12530+8CAj
		mov	dx, si
		lds	si, [bp+2]
		mov	[si], dx
		pop	ds
		pop	si
		retn
; ---------------------------------------------------------------------------

loc_12E07:				; CODE XREF: sub_12530+Ej
					; DATA XREF: sub_12530:off_12565o
		mov	ax, ds
		push	si
		push	di
		push	ds
		lds	si, [bp+2]
		mov	si, [si]
		mov	ds, word ptr cs:gscDataPtr+2
		xor	di, di
		test	word ptr [bp+6], 0FFFFh
		js	short loc_12E22
		mov	di, [bp+8]

loc_12E22:				; CODE XREF: sub_12530+8EDj
		xor	ax, ax
		test	word ptr [bp+0Ch], 0FFFFh
		js	short loc_12E3C
		mov	ax, [bp+0Eh]
		test	word ptr [bp+12h], 0FFFFh
		js	short loc_12E3A
		mov	bx, [bp+14h]
		mul	bx

loc_12E3A:				; CODE XREF: sub_12530+903j
		add	di, ax

loc_12E3C:				; CODE XREF: sub_12530+8F9j
		or	di, di
		jz	short loc_12E54

loc_12E40:				; CODE XREF: sub_12530+922j
		call	scrEvalExpr
		mov	dl, [si]
		inc	si
		cmp	dl, 1
		jz	short loc_12E51
		cmp	dl, 3
		jz	short loc_12E51
		dec	si

loc_12E51:				; CODE XREF: sub_12530+919j
					; sub_12530+91Ej
		dec	di
		jnz	short loc_12E40

loc_12E54:				; CODE XREF: sub_12530+90Ej
		mov	ax, si
		xor	bx, bx
		mov	cx, 2
		pop	ds
		pop	di
		pop	si
		retn
; ---------------------------------------------------------------------------

loc_12E5F:				; CODE XREF: sub_12530+Ej
					; DATA XREF: sub_12530:off_12565o
		push	ds
		push	cs
		pop	ds
		assume ds:seg000
		mov	bx, [bp+2]
		mov	cx, [bp+8]
		mov	dx, [bp+6]
		xor	ax, ax
		cmp	bx, 4
		jnb	short loc_12E78
		add	bx, bx
		call	off_12E7D[bx]

loc_12E78:				; CODE XREF: sub_12530+940j
		pop	ds
		assume ds:nothing
		mov	cx, 2
		retn
; END OF FUNCTION CHUNK	FOR sub_12530
; ---------------------------------------------------------------------------
off_12E7D	dw offset sub_12E85	; DATA XREF: sub_12530+944r
		dw offset sub_12E91
		dw offset sub_12E9D
		dw offset sub_12EA1

; =============== S U B	R O U T	I N E =======================================


sub_12E85	proc near		; CODE XREF: sub_12530+944p
					; DATA XREF: seg000:off_12E7Do
		mov	ax, ds:38E6h
		or	dl, dl
		js	short locret_12E90
		mov	ds:38E6h, cx

locret_12E90:				; CODE XREF: sub_12E85+5j
		retn
sub_12E85	endp


; =============== S U B	R O U T	I N E =======================================


sub_12E91	proc near		; CODE XREF: sub_12530+944p
					; DATA XREF: seg000:2E7Fo
		mov	ax, ds:38E8h
		or	dl, dl
		js	short locret_12E9C
		mov	ds:38E8h, cx

locret_12E9C:				; CODE XREF: sub_12E91+5j
		retn
sub_12E91	endp


; =============== S U B	R O U T	I N E =======================================


sub_12E9D	proc near		; CODE XREF: sub_12530+944p
					; DATA XREF: seg000:2E81o
		mov	ax, ds:38F2h
		retn
sub_12E9D	endp


; =============== S U B	R O U T	I N E =======================================


sub_12EA1	proc near		; CODE XREF: sub_12530+944p
					; DATA XREF: seg000:2E83o
		mov	ax, ds:3860h
		xchg	al, ah
		retn
sub_12EA1	endp

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_12530

loc_12EA7:				; CODE XREF: sub_12530+Ej
					; DATA XREF: sub_12530:off_12565o
		mov	cx, 2
		mov	ax, 100h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		or	bh, bh
		jz	short loc_12ECA
		xor	ax, ax
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		test	word ptr [bp+2], 0FFFFh
		jz	short loc_12EC3
		mov	al, ah
		xor	ah, ah
		retn
; ---------------------------------------------------------------------------

loc_12EC3:				; CODE XREF: sub_12530+98Cj
		or	al, al
		jz	short loc_12ECA
		xor	ah, ah
		retn
; ---------------------------------------------------------------------------

loc_12ECA:				; CODE XREF: sub_12530+981j
					; sub_12530+995j
		mov	ax, 0FFFFh
		retn
; ---------------------------------------------------------------------------

loc_12ECE:				; CODE XREF: sub_12530+Ej
					; DATA XREF: sub_12530:off_12565o
		mov	bx, 5
		test	word ptr [bp+0], 0FFFFh
		js	short loc_12EE4
		mov	ax, [bp+2]
		mov	bx, ax
		xor	ax, ax
		cmp	bx, 5
		jnb	short loc_12EEB

loc_12EE4:				; CODE XREF: sub_12530+9A6j
		add	bx, bx
		call	cs:off_12EF1[bx]

loc_12EEB:				; CODE XREF: sub_12530+9B2j
		xor	ah, ah
		mov	cx, 2
		retn
; END OF FUNCTION CHUNK	FOR sub_12530
; ---------------------------------------------------------------------------
off_12EF1	dw offset sub_1328A	; DATA XREF: sub_12530+9B6r
		dw offset sub_1320B
		dw offset sub_13265
		dw offset sub_12EFD
		dw offset sub_12F02
		dw offset sub_131EC

; =============== S U B	R O U T	I N E =======================================


sub_12EFD	proc near		; CODE XREF: sub_12530+9B6p
					; DATA XREF: seg000:2EF7o
		mov	bx, 0FFh
		jmp	short loc_12F05
sub_12EFD	endp


; =============== S U B	R O U T	I N E =======================================


sub_12F02	proc near		; CODE XREF: sub_12530+9B6p
					; DATA XREF: seg000:2EF9o
		mov	bx, 1FFh

loc_12F05:				; CODE XREF: sub_12EFD+3j
		mov	ah, 16h
		int	50h		; through 57 - IRQ0-IRQ7 relocated by DESQview
		mov	ah, 17h
		int	50h		; through 57 - IRQ0-IRQ7 relocated by DESQview
		and	al, ah
		not	al
		retn
sub_12F02	endp

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_12530

loc_12F12:				; CODE XREF: sub_12530+Ej
					; DATA XREF: sub_12530:off_12565o
		mov	ax, [bp+2]
		mov	bx, [bp+8]
		dec	ax
		cmp	ax, 4
		jnb	short loc_12F22
		call	sub_1336A
		retn
; ---------------------------------------------------------------------------

loc_12F22:				; CODE XREF: sub_12530+9ECj
		mov	al, 5
		int	0BEh		; used by BASIC	while in interpreter

loc_12F26:				; CODE XREF: sub_12530+Ej
					; DATA XREF: sub_12530:off_12565o
		push	ds
		xor	ax, ax
		mov	ds, ax
		assume ds:nothing
		mov	ax, [bp+2]
		or	ax, ax
		jz	short loc_12F3A
		mov	al, ds:52Ah
		and	ax, 1
		jmp	short loc_12F5F
; ---------------------------------------------------------------------------

loc_12F3A:				; CODE XREF: sub_12530+A00j
		mov	ax, ds:536h
		shr	ax, 2
		and	ax, 3FFh
		mov	bx, ds:530h
		mov	ch, bh
		shr	bx, 4
		and	bl, 3Ch
		or	ah, bl
		and	ch, 80h
		or	ah, ch
		mov	cl, ds:52Bh
		and	cl, 40h
		or	ah, cl

loc_12F5F:				; CODE XREF: sub_12530+A08j
		mov	cx, 2
		pop	ds
		assume ds:nothing
		retn
; END OF FUNCTION CHUNK	FOR sub_12530
; ---------------------------------------------------------------------------
		db 0B0h, 5, 0CDh, 0BEh
; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_12530

loc_12F68:				; CODE XREF: sub_12530+Ej
					; DATA XREF: sub_12530:off_12565o
		mov	cx, 2
		mov	ax, [bp+2]
		cmp	al, 1
		jb	short loc_12F80
		jz	short loc_12FA8
		cmp	al, 2
		jz	short loc_12F8B
		cmp	al, 0FFh
		jz	short loc_12FA1
		mov	al, 5
		int	0BEh		; used by BASIC	while in interpreter

loc_12F80:				; CODE XREF: sub_12530+A40j
		xor	ah, ah
		mov	al, [bp+8]
		xchg	al, cs:byte_138DC
		retn
; ---------------------------------------------------------------------------

loc_12F8B:				; CODE XREF: sub_12530+A46j
		mov	al, [bp+8]
		and	al, 1
		shl	al, 3
		and	cs:byte_138DC, 0F7h
		or	cs:byte_138DC, al
		xor	ax, ax
		retn
; ---------------------------------------------------------------------------

loc_12FA1:				; CODE XREF: sub_12530+A4Aj
		xor	ax, ax
		mov	al, cs:byte_138DC
		retn
; ---------------------------------------------------------------------------

loc_12FA8:				; CODE XREF: sub_12530+A42j
		mov	ax, 802h
		int	0B0h		; used by BASIC	while in interpreter
		mov	ah, al
		and	al, 6
		mov	dl, al
		xor	dl, 2
		test	byte ptr [bp+6], 0FFh
		js	short loc_12FC8
		mov	al, [bp+8]
		and	al, 1
		shl	al, 1
		and	dl, 8
		or	dl, al

loc_12FC8:				; CODE XREF: sub_12530+A8Aj
		mov	al, dl
; END OF FUNCTION CHUNK	FOR sub_12530

; =============== S U B	R O U T	I N E =======================================


sub_12FCA	proc near		; CODE XREF: sub_1180D-1C6p
		push	ds
		xor	ax, ax
		mov	ds, ax
		assume ds:nothing
		mov	al, ah
		and	al, 0F3h
		or	al, dl
		mov	ds:53Ah, al
		mov	ds:538h, al
		pop	ds
		assume ds:nothing
		add	dl, dl
		pushf
		cli
		mov	al, 9Dh	; 'ù'
		call	sub_12FF5
		jb	short loc_12FEE
		mov	al, 70h	; 'p'
		or	al, dl
		call	sub_12FF5

loc_12FEE:				; CODE XREF: sub_12FCA+1Bj
		xor	ax, ax
		popf
		mov	cx, 2
		retn
sub_12FCA	endp


; =============== S U B	R O U T	I N E =======================================


sub_12FF5	proc near		; CODE XREF: sub_12FCA+18p
					; sub_12FCA+21p
		mov	cx, 4

loc_12FF8:				; CODE XREF: sub_12FF5+Ej
					; sub_12FF5+10j
		call	sub_13009
		jb	short loc_13007
		cmp	al, 0FAh ; '˙'
		jz	short locret_13008
		cmp	al, 0FCh ; '¸'
		jz	short loc_12FF8
		loop	loc_12FF8

loc_13007:				; CODE XREF: sub_12FF5+6j
		stc

locret_13008:				; CODE XREF: sub_12FF5+Aj
		retn
sub_12FF5	endp


; =============== S U B	R O U T	I N E =======================================


sub_13009	proc near		; CODE XREF: sub_12FF5:loc_12FF8p
		mov	ah, al
		call	sub_13034
		mov	al, 37h	; '7'
		out	43h, al		; Timer	8253-5 (AT: 8254.2).
		mov	al, ah
		out	41h, al		; Timer	8253-5 (AT: 8254.2).
		mov	al, 16h
		out	43h, al		; Timer	8253-5 (AT: 8254.2).
		call	sub_13034
		mov	bx, 0FFFFh

loc_13020:				; CODE XREF: sub_13009+20j
		out	5Fh, al
		in	al, 43h		; Timer	8253-5 (AT: 8254.2).
		test	al, 2
		jnz	short loc_1302D
		dec	bx
		jnz	short loc_13020
		stc
		retn
; ---------------------------------------------------------------------------

loc_1302D:				; CODE XREF: sub_13009+1Dj
		call	sub_13034
		in	al, 41h		; Timer	8253-5 (AT: 8254.2).
		clc
		retn
sub_13009	endp


; =============== S U B	R O U T	I N E =======================================


sub_13034	proc near		; CODE XREF: sub_13009+2p
					; sub_13009+11p ...
		mov	al, 10h

loc_13036:				; CODE XREF: sub_13034+6j
		out	5Fh, al
		dec	al
		jnz	short loc_13036
		retn
sub_13034	endp

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_12530

loc_1303D:				; CODE XREF: sub_12530+Ej
					; DATA XREF: sub_12530:off_12565o
		mov	ax, [bp+2]
		or	ax, ax
		jz	short loc_1306D
		dec	ax
		mov	cs:word_138E2, ax

loc_13049:				; CODE XREF: sub_12530+B39j
		test	cs:byte_138DC, 1
		jz	short loc_13062
		call	sub_1320B
		and	al, 30h
		push	ax
		call	sub_131FE
		pop	bx
		or	al, bl
		mov	ax, 0FFFFh
		jnz	short loc_1306D

loc_13062:				; CODE XREF: sub_12530+B1Fj
		test	cs:word_138E2, 0FFFFh
		jnz	short loc_13049
		xor	ax, ax

loc_1306D:				; CODE XREF: sub_12530+B12j
					; sub_12530+B30j
		mov	cx, 2
		retn
; ---------------------------------------------------------------------------

loc_13071:				; CODE XREF: sub_12530+Ej
					; DATA XREF: sub_12530:off_12565o
		push	si
		push	ds
		mov	ax, [bp+2]
		cmp	ax, 3
		jnb	short loc_1308E
		or	ax, ax
		jz	short loc_13080
		dec	ax

loc_13080:				; CODE XREF: sub_12530+B4Dj
		lds	si, [bp+8]
		call	ResolveString
		pop	ds
		pop	si
		jb	short loc_1308E
		mov	cx, 0FFFFh
		retn
; ---------------------------------------------------------------------------

loc_1308E:				; CODE XREF: sub_12530+B49j
					; sub_12530+B58j
		mov	al, 5
		int	0BEh		; used by BASIC	while in interpreter

loc_13092:				; CODE XREF: sub_12530+Ej
					; DATA XREF: sub_12530:off_12565o
		push	si
		push	di
		push	ds
		push	es
		mov	ax, [bp+2]
		cmp	ax, 3
		jnb	short loc_130E2
		or	ax, ax
		jz	short loc_130A3
		dec	ax

loc_130A3:				; CODE XREF: sub_12530+B70j
		mov	dx, ax

loc_130A5:				; CODE XREF: sub_12530+B9Dj
					; sub_12530+BA8j
		mov	ax, dx
		call	CheckDiskID
		test	word ptr [bp+6], 0FFFFh
		js	short loc_130DA
		push	ax
		mov	bh, dl
		mov	bl, [bp+8]
		call	sub_10034
		pop	ax
		or	ax, ax
		js	short loc_130CF
		cmp	ax, 7Fh	; ''
		jz	short loc_130DA
		cmp	[bp+8],	ax
		jz	short loc_130DA
		mov	al, 40h	; '@'
		int	0BEh		; used by BASIC	while in interpreter
		jmp	short loc_130A5
; ---------------------------------------------------------------------------

loc_130CF:				; CODE XREF: sub_12530+B8Dj
		cmp	ax, 0FFFCh
		jz	short loc_130E6
		mov	al, 40h	; '@'
		int	0BEh		; used by BASIC	while in interpreter
		jmp	short loc_130A5
; ---------------------------------------------------------------------------

loc_130DA:				; CODE XREF: sub_12530+B7Fj
					; sub_12530+B92j ...
		mov	cx, 2
		pop	es
		pop	ds
		pop	di
		pop	si
		retn
; ---------------------------------------------------------------------------

loc_130E2:				; CODE XREF: sub_12530+B6Cj
		mov	al, 5
		int	0BEh		; used by BASIC	while in interpreter

loc_130E6:				; CODE XREF: sub_12530+BA2j
		mov	al, 0Fh
		int	0BEh		; used by BASIC	while in interpreter

loc_130EA:				; CODE XREF: sub_12530+Ej
					; DATA XREF: sub_12530:off_12565o
		push	si
		push	di
		push	ds
		push	es
		lds	si, [bp+2]
		call	OpenSave_Read
		jb	short loc_130FE
		mov	bx, ax
		mov	ah, 3Eh
		int	21h		; DOS -	2+ - CLOSE A FILE WITH HANDLE
					; BX = file handle
		xor	ax, ax

loc_130FE:				; CODE XREF: sub_12530+BC4j
		inc	ax
		mov	cx, 2
		pop	es
		pop	ds
		pop	di
		pop	si
		retn
; END OF FUNCTION CHUNK	FOR sub_12530
; ---------------------------------------------------------------------------
		align 10h
; START	OF FUNCTION CHUNK FOR sub_1180D

ExitDOS:				; CODE XREF: sub_1180D-1C3j j_ExitDOSj
		call	RestoreInts
		push	cs
		pop	ds
		assume ds:seg000
		test	byte_13861, 0FFh
		jz	short loc_1312A
		mov	dx, offset a36mSystemTermi ; "\x1B[36m<SYSTEM TERMINATED>\x1B[m\r\n$"
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		mov	al, byte ptr word_13844
		mov	ah, 4Ch
		int	21h		; DOS -	2+ - QUIT WITH EXIT CODE (EXIT)
					; AL = exit code
; ---------------------------------------------------------------------------

loc_1312A:				; CODE XREF: sub_1180D+190Dj
		mov	al, 0FFh
		int	0BEh		; used by BASIC	while in interpreter

IntBF:					; DATA XREF: SetupInts+36o
		call	RestoreInts
		mov	ax, 4C00h
		int	21h		; DOS -	2+ - QUIT WITH EXIT CODE (EXIT)
; END OF FUNCTION CHUNK	FOR sub_1180D	; AL = exit code

; =============== S U B	R O U T	I N E =======================================


AllocFileMem	proc near		; CODE XREF: LoadFile1+35p
					; LoadFile1+69p ...
		push	cx
		mov	cl, al
		cmp	al, 2
		jbe	short loc_13162
		mov	cl, cs:byte_138D4
		inc	al
		jz	short loc_13162
		inc	al
		jz	short loc_13153
		inc	al
		jz	short loc_1315D

loc_1314E:				; CODE XREF: AllocFileMem+20j
		pop	cx
		mov	al, 9
		stc
		retn
; ---------------------------------------------------------------------------

loc_13153:				; CODE XREF: AllocFileMem+12j
		cmp	ah, 2
		ja	short loc_1314E
		mov	cs:byte_138D4, ah

loc_1315D:				; CODE XREF: AllocFileMem+16j
		mov	al, cl
		pop	cx
		clc
		retn
; ---------------------------------------------------------------------------

loc_13162:				; CODE XREF: AllocFileMem+5j
					; AllocFileMem+Ej
		push	dx
		mov	ax, 5800h
		int	21h		; DOS -	3+ - GET/SET MEMORY ALLOCATION STRATEGY
					; AL = function	code: get allocation strategy
		mov	ch, al
		cmp	ch, cl
		jz	short loc_1317B
		mov	dx, bx
		mov	ax, 5801h
		xor	bh, bh
		mov	bl, cl
		int	21h		; DOS -	3+ - GET/SET MEMORY ALLOCATION STRATEGY
					; AL = function	code: set allocation strategy
		mov	bx, dx

loc_1317B:				; CODE XREF: AllocFileMem+36j
		mov	ah, 48h
		int	21h		; DOS -	2+ - ALLOCATE MEMORY
					; BX = number of 16-byte paragraphs desired
		pushf
		cmp	ch, cl
		jz	short loc_13193
		mov	dx, bx
		xor	bh, bh
		mov	bl, ch
		push	ax
		mov	ax, 5801h
		int	21h		; DOS -	3+ - GET/SET MEMORY ALLOCATION STRATEGY
					; AL = function	code: set allocation strategy
		pop	ax
		mov	bx, dx

loc_13193:				; CODE XREF: AllocFileMem+4Cj
		popf
		pop	dx
		pop	cx
		retn
AllocFileMem	endp


; =============== S U B	R O U T	I N E =======================================


sub_13197	proc near		; CODE XREF: DoSomePrint+154p
		sub	dh, 81h	; 'Å'
		cmp	dh, 6Fh	; 'o'
		jnb	short loc_131D2
		cmp	dh, 1Fh
		jb	short loc_131AC
		cmp	dh, 3Fh	; '?'
		jb	short loc_131D2
		sub	dh, 40h	; '@'

loc_131AC:				; CODE XREF: sub_13197+Bj
		shl	dh, 1
		sub	dl, 40h	; '@'
		cmp	dl, 0BDh ; 'Ω'
		jnb	short loc_131D2
		cmp	dl, 3Fh	; '?'
		jz	short loc_131D2
		jnb	short loc_131BF
		inc	dl

loc_131BF:				; CODE XREF: sub_13197+24j
		cmp	dl, 5Fh	; '_'
		jnb	short loc_131CA
		add	dx, 2120h
		clc
		retn
; ---------------------------------------------------------------------------

loc_131CA:				; CODE XREF: sub_13197+2Bj
		add	dh, 22h	; '"'
		sub	dl, 3Eh	; '>'
		clc
		retn
; ---------------------------------------------------------------------------

loc_131D2:				; CODE XREF: sub_13197+6j
					; sub_13197+10j ...
		mov	dx, 2228h
		stc
		retn
sub_13197	endp


; =============== S U B	R O U T	I N E =======================================


sub_131D7	proc near		; CODE XREF: seg000:loc_10D00p
					; sub_131D7+8j	...
		call	sub_1371B
		call	sub_131EC
		or	al, al
		jnz	short sub_131D7
		call	sub_1371B
		call	sub_131EC
		or	al, al
		jnz	short sub_131D7
		retn
sub_131D7	endp


; =============== S U B	R O U T	I N E =======================================


sub_131EC	proc near		; CODE XREF: seg000:loc_10D03p
					; sub_12530+9B6p ...
		call	sub_1328A
		mov	bl, al
		call	sub_13265
		or	bl, al
		call	sub_1320B
		or	al, bl
		xor	ah, ah
		retn
sub_131EC	endp


; =============== S U B	R O U T	I N E =======================================


sub_131FE	proc near		; CODE XREF: sub_12530+B27p
					; sub_1356C:loc_13584j
		call	sub_1328A
		mov	bl, al
		call	sub_13265
		or	al, bl
		xor	ah, ah
		retn
sub_131FE	endp


; =============== S U B	R O U T	I N E =======================================


sub_1320B	proc near		; CODE XREF: sub_12530+9B6p
					; sub_12530+B21p ...
		xor	al, al
		test	cs:byte_13886, 0FFh
		jz	short loc_13217
		mov	al, 10h

loc_13217:				; CODE XREF: sub_1320B+8j
		test	cs:byte_13887, 0FFh
		jz	short loc_13221
		or	al, 20h

loc_13221:				; CODE XREF: sub_1320B+12j
		mov	ah, byte ptr cs:word_13882
		or	ah, ah
		js	short loc_13233
		cmp	ah, 10h
		jb	short loc_13240
		or	al, 8
		jmp	short loc_1323A
; ---------------------------------------------------------------------------

loc_13233:				; CODE XREF: sub_1320B+1Dj
		cmp	ah, 0F0h ; ''
		jge	short loc_13240
		or	al, 4

loc_1323A:				; CODE XREF: sub_1320B+26j
		mov	byte ptr cs:word_13882,	0

loc_13240:				; CODE XREF: sub_1320B+22j
					; sub_1320B+2Bj
		mov	ah, byte ptr cs:word_13882+1
		or	ah, ah
		js	short loc_13257
		cmp	ah, 0Ch
		jb	short locret_13264
		or	al, 2
		mov	byte ptr cs:word_13882+1, 0
		retn
; ---------------------------------------------------------------------------

loc_13257:				; CODE XREF: sub_1320B+3Cj
		cmp	ah, 0F4h ; 'Ù'
		jge	short locret_13264
		or	al, 1
		mov	byte ptr cs:word_13882+1, 0

locret_13264:				; CODE XREF: sub_1320B+41j
					; sub_1320B+4Fj
		retn
sub_1320B	endp


; =============== S U B	R O U T	I N E =======================================


sub_13265	proc near		; CODE XREF: sub_12530+9B6p
					; sub_131EC+5p	...
		test	cs:word_138BA, 0FFFFh
		jnz	short loc_13271
		xor	al, al
		retn
; ---------------------------------------------------------------------------

loc_13271:				; CODE XREF: sub_13265+7j
		push	bx
		mov	ah, 17h
		mov	bx, 0FFh
		int	50h		; through 57 - IRQ0-IRQ7 relocated by DESQview
		push	ax
		mov	ah, 17h
		mov	bx, 1FFh
		int	50h		; through 57 - IRQ0-IRQ7 relocated by DESQview
		pop	bx
		and	ax, bx
		pop	bx
		mov	al, ah
		not	al
		retn
sub_13265	endp


; =============== S U B	R O U T	I N E =======================================


sub_1328A	proc near		; CODE XREF: sub_12530+9B6p sub_131ECp ...
		push	bx
		push	cx
		push	dx
		push	si
		push	ds
		xor	bx, bx
		mov	ds, bx
		assume ds:nothing
		mov	dx, bx
		mov	ah, ds:531h
		test	ah, 10h
		jz	short loc_132A0
		mov	dl, 8

loc_132A0:				; CODE XREF: sub_1328A+12j
		test	ah, 8
		jz	short loc_132A8
		or	dl, 4

loc_132A8:				; CODE XREF: sub_1328A+19j
		test	ah, 20h
		jz	short loc_132B0
		or	dl, 2

loc_132B0:				; CODE XREF: sub_1328A+21j
		test	ah, 4
		jz	short loc_132B8
		or	dl, 1

loc_132B8:				; CODE XREF: sub_1328A+29j
		mov	ah, ds:532h
		test	ah, 4
		jz	short loc_132C4
		or	dl, 5

loc_132C4:				; CODE XREF: sub_1328A+35j
		test	ah, 8
		jz	short loc_132CC
		or	dl, 1

loc_132CC:				; CODE XREF: sub_1328A+3Dj
		test	ah, 10h
		jz	short loc_132D4
		or	dl, 9

loc_132D4:				; CODE XREF: sub_1328A+45j
		test	ah, 40h
		jz	short loc_132DC
		or	dl, 4

loc_132DC:				; CODE XREF: sub_1328A+4Dj
		mov	ah, ds:533h
		test	ah, 1
		jz	short loc_132E8
		or	dl, 8

loc_132E8:				; CODE XREF: sub_1328A+59j
		test	ah, 4
		jz	short loc_132F0
		or	dl, 6

loc_132F0:				; CODE XREF: sub_1328A+61j
		test	ah, 8
		jz	short loc_132F8
		or	dl, 2

loc_132F8:				; CODE XREF: sub_1328A+69j
		test	ah, 10h
		jz	short loc_13300
		or	dl, 0Ah

loc_13300:				; CODE XREF: sub_1328A+71j
		xor	bx, bx
		mov	si, 3342h
		mov	dh, 10h
		call	sub_1332A
		mov	si, 334Ch
		mov	dh, 20h	; ' '
		call	sub_1332A
		mov	si, 3356h
		mov	dh, 40h	; '@'
		call	sub_1332A
		mov	si, 3360h
		mov	dh, 80h	; 'Ä'
		call	sub_1332A
		mov	al, dl
		pop	ds
		assume ds:nothing
		pop	si
		pop	dx
		pop	cx
		pop	bx
		retn
sub_1328A	endp


; =============== S U B	R O U T	I N E =======================================


sub_1332A	proc near		; CODE XREF: sub_1328A+7Dp
					; sub_1328A+85p ...
		mov	cx, 5

loc_1332D:				; CODE XREF: sub_1332A+11j
		lods	word ptr cs:[si]
		or	al, al
		js	short locret_1333D
		mov	bl, al
		test	[bx+52Ah], ah
		jnz	short loc_1333E
		loop	loc_1332D

locret_1333D:				; CODE XREF: sub_1332A+7j
		retn
; ---------------------------------------------------------------------------

loc_1333E:				; CODE XREF: sub_1332A+Fj
		or	dl, dh
		retn
sub_1332A	endp

; ---------------------------------------------------------------------------
		align 2
		db 6, 10h, 3, 10h, 5, 2, 5, 8, 2 dup(0FFh), 0, 1, 0Ah
		db 2, 5, 4, 9, 40h, 16h	dup(0FFh)

; =============== S U B	R O U T	I N E =======================================


sub_1336A	proc near		; CODE XREF: sub_12530+9EEp
		push	cx
		push	dx
		mov	dx, bx
		xor	ah, ah
		mov	bx, ax
		shl	ax, 1
		shl	ax, 1
		add	ax, bx
		shl	ax, 1
		mov	bx, 3342h
		add	bx, ax
		mov	cx, 5
		or	dx, dx
		js	short loc_133A6

loc_13386:				; CODE XREF: sub_1336A+24j
		test	byte ptr cs:[bx], 0FFh
		js	short loc_13393
		inc	bx
		inc	bx
		loop	loc_13386
		stc
		jmp	short loc_133B1
; ---------------------------------------------------------------------------

loc_13393:				; CODE XREF: sub_1336A+20j
		mov	cl, dl
		and	cl, 7
		mov	ah, 1
		shl	ah, cl
		mov	al, dl
		shr	al, 3
		mov	cs:[bx], ax
		jmp	short loc_133B0
; ---------------------------------------------------------------------------

loc_133A6:				; CODE XREF: sub_1336A+1Aj
		mov	ax, 0FFFFh

loc_133A9:				; CODE XREF: sub_1336A+44j
		mov	cs:[bx], ax
		inc	bx
		inc	bx
		loop	loc_133A9

loc_133B0:				; CODE XREF: sub_1336A+3Aj
		clc

loc_133B1:				; CODE XREF: sub_1336A+27j
		pop	dx
		pop	cx
		retn
sub_1336A	endp


; =============== S U B	R O U T	I N E =======================================


sub_133B4	proc near		; CODE XREF: start-3FB9p
		sti
		mov	al, 0Ch
		out	68h, al
		xor	al, al
		out	7Ch, al
		mov	ax, 0A04h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		mov	ah, 12h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		xor	dx, dx
		mov	ah, 13h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		mov	dx, 0E120h
		mov	ah, 16h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		mov	ah, 4Ah
		mov	ch, 6
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		mov	ch, 0C0h
		mov	ah, 42h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		xor	al, al
		out	0A4h, al	; Interrupt Controller #2, 8259A
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	al, 2
		out	68h, al
		mov	al, 1
		out	6Ah, al
		mov	ah, 0Ch
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		mov	ah, 40h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		push	ds
		xor	ax, ax
		mov	ds, ax
		assume ds:nothing
		mov	ax, ds:500h
		mov	cs:word_138B2, ax
		or	ax, 20h
		mov	ds:500h, ax
		mov	al, ds:53Ah
		mov	cs:byte_13867, al
		pop	ds
		assume ds:nothing
		out	64h, al		; 8042 keyboard	controller command register.
		retn
sub_133B4	endp

; ---------------------------------------------------------------------------

IntB8:					; DATA XREF: SetupInts+1Eo
		call	PrintInt_Hex
		iret
; ---------------------------------------------------------------------------

IntB9:					; DATA XREF: SetupInts+26o
		call	DoSomePrint
		iret

; =============== S U B	R O U T	I N E =======================================


RestoreInts	proc near		; CODE XREF: sub_1180D:ExitDOSp
					; sub_1180D:IntBFp
		pushf
		cli
		lds	dx, cs:OldInt05
		mov	al, 5
		mov	ah, 25h
		int	21h		; DOS -	SET INTERRUPT VECTOR
					; AL = interrupt number
					; DS:DX	= new vector to	be used	for specified interrupt
		lds	dx, cs:OldInt06
		mov	al, 6
		mov	ah, 25h
		int	21h		; DOS -	SET INTERRUPT VECTOR
					; AL = interrupt number
					; DS:DX	= new vector to	be used	for specified interrupt
		in	al, 2		; DMA controller, 8237A-5.
					; channel 1 current address
		or	al, cs:byte_138DA
		or	al, 4
		out	2, al		; DMA controller, 8237A-5.
					; channel 1 base address
					; (also	sets current address)
		lds	dx, cs:OldInt0A
		mov	ax, 250Ah
		int	21h		; DOS -	SET INTERRUPT VECTOR
					; AL = interrupt number
					; DS:DX	= new vector to	be used	for specified interrupt
		in	al, 0Ah		; DMA controller, 8237A-5.
					; single mask bit register
					; 0-1: select channel (00=0; 01=1; 10=2; 11=3)
					; 2: 1=set mask	for channel; 0=clear mask (enable)
		jmp	short $+2
		jmp	short $+2
		or	al, 20h
		out	0Ah, al		; DMA controller, 8237A-5.
					; single mask bit register
					; 0-1: select channel (00=0; 01=1; 10=2; 11=3)
					; 2: 1=set mask	for channel; 0=clear mask (enable)
		lds	dx, cs:OldInt15
		mov	ax, 2515h
		int	21h		; DOS -	SET INTERRUPT VECTOR
					; AL = interrupt number
					; DS:DX	= new vector to	be used	for specified interrupt
		mov	dx, 0BFDBh
		xor	al, al
		out	dx, al
		popf
		mov	ax, 0A04h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		mov	ah, 13h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		mov	dx, 3FDBh
		mov	al, 0CDh
		out	dx, al
		mov	al, 4
		out	dx, al
		push	ds
		xor	ax, ax
		mov	ds, ax
		assume ds:nothing
		mov	ax, cs:word_138B2
		mov	ds:500h, ax
		pop	ds
		assume ds:nothing

loc_13481:				; CODE XREF: RestoreInts+73j
		mov	ah, 1
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		or	bh, bh
		jz	short locret_1348F
		xor	ax, ax
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		jmp	short loc_13481
; ---------------------------------------------------------------------------

locret_1348F:				; CODE XREF: RestoreInts+6Dj
		retn
RestoreInts	endp

; ---------------------------------------------------------------------------

IntB0:					; DATA XREF: SetupInts+Eo
		push	bp
		mov	bp, sp
		cmp	ah, 22h	; '"'
		jnb	short loc_134C1
		push	cx
		push	dx
		push	di
		push	ds
		xchg	al, ah
		mov	di, ax
		xchg	al, ah
		and	di, 0FFh
		add	di, di
		cld
		sti
		call	cs:off_134CD[di]
		jnb	short loc_134B7
		or	byte ptr [bp+6], 1
		jmp	short loc_134BB
; ---------------------------------------------------------------------------

loc_134B7:				; CODE XREF: seg000:34AFj
		and	byte ptr [bp+6], 0FEh

loc_134BB:				; CODE XREF: seg000:34B5j
		pop	ds
		pop	di
		pop	dx
		pop	cx
		pop	bp
		iret
; ---------------------------------------------------------------------------

loc_134C1:				; CODE XREF: seg000:3496j
		xor	ax, ax
		or	byte ptr [bp+6], 1
		pop	bp
		iret

; =============== S U B	R O U T	I N E =======================================


sub_134C9	proc near		; CODE XREF: seg000:34AAp
					; DATA XREF: seg000:off_134CDo
		xor	ax, ax
		stc
		retn
sub_134C9	endp

; ---------------------------------------------------------------------------
off_134CD	dw offset j_ExitDOS	; 0 ; DATA XREF: seg000:34AAr
		dw offset sub_13514	; 1
		dw offset sub_13537	; 2
		dw offset AllocFileMem	; 3
		dw offset sub_134C9	; 4
		dw offset sub_134C9	; 5
		dw offset sub_134C9	; 6
		dw offset sub_1354F	; 7
		dw offset sub_1356C	; 8
		dw offset sub_1164D	; 9
		dw offset sub_134C9	; 0Ah
		dw offset sub_134C9	; 0Bh
		dw offset sub_134C9	; 0Ch
		dw offset sub_134C9	; 0Dh
		dw offset sub_134C9	; 0Eh
		dw offset sub_134C9	; 0Fh
		dw offset sub_134C9	; 10h
		dw offset sub_10000	; 11h
		dw offset sub_10034	; 12h
		dw offset CheckDiskID	; 13h
		dw offset BuildAbsolutePath; 14h
		dw offset sub_1021E	; 15h
		dw offset SearchDiskDrive; 16h
		dw offset OpenFileRead1	; 17h
		dw offset OpenFileRead2	; 18h
		dw offset OpenFileWrite	; 19h
		dw offset LoadFile1	; 1Ah
		dw offset GetFileSize	; 1Bh
		dw offset DecompressFile; 1Ch
		dw offset loc_10582	; 1Dh
		dw offset sub_134C9	; 1Eh
		dw offset sub_10658	; 1Fh
		dw offset ReadRawFile	; 20h
		dw offset ResolveString	; 21h

; =============== S U B	R O U T	I N E =======================================

; Attributes: thunk

j_ExitDOS	proc near		; CODE XREF: seg000:34AAp
					; DATA XREF: seg000:off_134CDo
		jmp	ExitDOS
j_ExitDOS	endp


; =============== S U B	R O U T	I N E =======================================


sub_13514	proc near		; CODE XREF: seg000:34AAp
					; DATA XREF: seg000:off_134CDo
		push	cs
		pop	ds
		assume ds:seg000
		mov	di, offset byte_137D2
		xor	dx, dx
		mov	cx, 8

loc_1351E:				; CODE XREF: sub_13514+15j
		mov	ax, [di]
		or	ax, [di+2]
		jz	short loc_1352F
		add	di, 4
		inc	dx
		loop	loc_1351E

loc_1352B:				; CODE XREF: sub_13537+2j
		mov	ax, 0FFFFh
		retn
; ---------------------------------------------------------------------------

loc_1352F:				; CODE XREF: sub_13514+Fj
		mov	[di], bx
		mov	word ptr [di+2], es
		mov	ax, dx
		retn
sub_13514	endp


; =============== S U B	R O U T	I N E =======================================


sub_13537	proc near		; CODE XREF: seg000:34AAp
					; DATA XREF: seg000:off_134CDo
		cmp	al, 8
		jnb	short loc_1352B
		push	cs
		pop	ds
		mov	di, offset byte_137D2
		xor	ah, ah
		shl	ax, 2
		add	di, ax
		xor	ax, ax
		mov	[di], ax
		mov	[di+2],	ax
		retn
sub_13537	endp


; =============== S U B	R O U T	I N E =======================================


sub_1354F	proc near		; CODE XREF: seg000:34AAp
					; DATA XREF: seg000:off_134CDo
		mov	bx, cs
		cmp	al, 1
		jb	short loc_13562
		jz	short loc_13567
		mov	ax, word ptr cs:scrRegMemPtr
		mov	bx, word ptr cs:scrRegMemPtr+2
		clc
		retn
; ---------------------------------------------------------------------------

loc_13562:				; CODE XREF: sub_1354F+4j
		mov	ax, offset gscFilePtr
		clc
		retn
; ---------------------------------------------------------------------------

loc_13567:				; CODE XREF: sub_1354F+6j
		mov	ax, offset gscFilePtr
		clc
		retn
sub_1354F	endp


; =============== S U B	R O U T	I N E =======================================


sub_1356C	proc near		; CODE XREF: seg000:34AAp
					; DATA XREF: seg000:off_134CDo
		sub	al, 1
		jnb	short loc_13573
		jmp	sub_131EC
; ---------------------------------------------------------------------------

loc_13573:				; CODE XREF: sub_1356C+2j
		jnz	short loc_13578
		jmp	sub_131D7
; ---------------------------------------------------------------------------

loc_13578:				; CODE XREF: sub_1356C:loc_13573j
		sub	al, 2
		jnb	short loc_13584
		xor	ax, ax
		mov	ds, ax
		assume ds:nothing
		mov	al, ds:53Ah
		retn
; ---------------------------------------------------------------------------

loc_13584:				; CODE XREF: sub_1356C+Ej
		jmp	sub_131FE
sub_1356C	endp

; ---------------------------------------------------------------------------

IntB1:					; DATA XREF: SetupInts+16o
		iret
; ---------------------------------------------------------------------------
		retn
; ---------------------------------------------------------------------------

Int24:					; DATA XREF: SetupInts+3Eo
		add	sp, 8
		mov	bp, sp
		or	word ptr [bp+14h], 1
		mov	ax, di
		mov	ah, 0FFh
		pop	bx
		pop	cx
		pop	dx
		pop	si
		pop	di
		pop	bp
		pop	ds
		assume ds:nothing
		pop	es

Int23:					; DATA XREF: SetupInts+46o
		iret
; ---------------------------------------------------------------------------

Int05:					; DATA XREF: SetupInts+5Bo
		push	ax
		push	ds
		xor	ax, ax
		mov	ds, ax
		assume ds:nothing
		test	cs:byte_138D5, 0FFh
		jnz	short loc_135BE
		mov	al, ds:538h
		not	al
		test	al, 11h
		jnz	short loc_135D5
		mov	cs:byte_138D5, 0FFh
		jmp	short loc_135D5
; ---------------------------------------------------------------------------

loc_135BE:				; CODE XREF: seg000:35ABj
		test	cs:byte_138D6, 0FFh
		jnz	short loc_135D5
		mov	cs:byte_138D6, 0FFh
		call	sub_10A1D
		mov	cs:byte_138D6, 0

loc_135D5:				; CODE XREF: seg000:35B4j seg000:35BCj ...
		pop	ds
		assume ds:nothing
		pop	ax
		iret
; ---------------------------------------------------------------------------

Int06:					; DATA XREF: SetupInts+70o
		test	cs:byte_138D5, 0FFh
		jz	short locret_135EB
		test	cs:byte_138D6, 0FFh
		jnz	short locret_135EB
		jmp	loc_1163A
; ---------------------------------------------------------------------------

locret_135EB:				; CODE XREF: seg000:35DEj seg000:35E6j
		iret
; ---------------------------------------------------------------------------

Int0A:					; DATA XREF: SetupInts+85o
		cli
		mov	cs:word_1365C, ax
		push	ds
		push	es
		pusha
		mov	si, 37D2h
		mov	di, 8

loc_135FA:				; CODE XREF: seg000:3609j
		push	cs
		pop	ds
		assume ds:seg000
		mov	ax, [si]
		or	ax, [si+2]
		jz	short loc_13605
		call	dword ptr [si]

loc_13605:				; CODE XREF: seg000:3601j
		add	si, 4
		dec	di
		jnz	short loc_135FA
		push	cs
		pop	ds
		xor	bx, bx
		inc	word_138DE
		cmp	word_138DE, 3Ch	; '<'
		jb	short loc_13622
		mov	word_138DE, bx
		inc	word_138E0

loc_13622:				; CODE XREF: seg000:3618j
		cmp	word_138E2, bx
		jz	short loc_1362C
		dec	word_138E2

loc_1362C:				; CODE XREF: seg000:3626j
		mov	ax, word_138E4
		shr	ax, 1
		jnb	short loc_13637
		inc	word_138E6

loc_13637:				; CODE XREF: seg000:3631j
		shr	ax, 1
		jnb	short loc_13645
		cmp	word_138E8, bx
		jz	short loc_13645
		dec	word_138E8

loc_13645:				; CODE XREF: seg000:3639j seg000:363Fj
		cli
		mov	al, 20h	; ' '
		out	0, al
		popa
		pop	es
		pop	ds
		assume ds:nothing
		test	cs:byte_138DB, 0FFh
		jz	short loc_13657
		out	64h, al		; 8042 keyboard	controller command register.

loc_13657:				; CODE XREF: seg000:3653j
		mov	ax, cs:word_1365C
		iret
; ---------------------------------------------------------------------------
word_1365C	dw 0			; DATA XREF: seg000:35EDw
					; seg000:loc_13657r
; ---------------------------------------------------------------------------

Int15:					; DATA XREF: SetupInts+A4o
		cli
		push	ds
		pusha
		push	cs
		pop	ds
		assume ds:seg000
		mov	dx, 7FDDh
		mov	al, 10h
		out	dx, al
		mov	cx, 0DDD9h
		mov	dl, cl
		in	al, dx
		xor	ah, ah
		or	al, al
		js	short loc_13677
		dec	ah

loc_13677:				; CODE XREF: seg000:3673j
		mov	byte_13886, ah
		xor	ah, ah
		test	al, 20h
		jnz	short loc_13683
		dec	ah

loc_13683:				; CODE XREF: seg000:367Fj
		mov	byte_13887, ah
		mov	bl, al
		and	bl, 0Fh
		mov	dl, ch
		mov	al, 30h	; '0'
		out	dx, al
		jmp	short $+2
		jmp	short $+2
		mov	dl, cl
		in	al, dx
		shl	al, 4
		or	bl, al
		mov	dl, ch
		mov	al, 50h	; 'P'
		out	dx, al
		mov	dl, cl
		jmp	short $+2
		jmp	short $+2
		in	al, dx
		mov	bh, al
		and	bh, 0Fh
		mov	dl, 0DDh ; '›'
		mov	al, 70h	; 'p'
		out	dx, al
		mov	dl, cl
		jmp	short $+2
		jmp	short $+2
		in	al, dx
		shl	al, 4
		or	bh, al
		mov	word_13884, bx
		mov	dl, 0DDh ; '›'
		mov	al, 80h	; 'Ä'
		out	dx, al
		mov	ax, word_13882
		or	bl, bl
		js	short loc_136DB
		or	al, al
		js	short loc_136E7
		add	al, bl
		jnb	short loc_136E9
		mov	al, 7Fh	; ''
		jmp	short loc_136E9
; ---------------------------------------------------------------------------

loc_136DB:				; CODE XREF: seg000:36CDj
		or	al, al
		jns	short loc_136E7
		add	al, bl
		js	short loc_136E9
		mov	al, 80h	; 'Ä'
		jmp	short loc_136E9
; ---------------------------------------------------------------------------

loc_136E7:				; CODE XREF: seg000:36D1j seg000:36DDj
		add	al, bl

loc_136E9:				; CODE XREF: seg000:36D5j seg000:36D9j ...
		or	bh, bh
		js	short loc_136F9
		or	ah, ah
		js	short loc_13705
		add	ah, bh
		jnb	short loc_13707
		mov	ah, 7Fh	; ''
		jmp	short loc_13707
; ---------------------------------------------------------------------------

loc_136F9:				; CODE XREF: seg000:36EBj
		or	ah, ah
		jns	short loc_13705
		add	ah, bh
		js	short loc_13707
		mov	ah, 80h	; 'Ä'
		jmp	short loc_13707
; ---------------------------------------------------------------------------

loc_13705:				; CODE XREF: seg000:36EFj seg000:36FBj
		add	ah, bh

loc_13707:				; CODE XREF: seg000:36F3j seg000:36F7j ...
		mov	word_13882, ax
		in	al, 8		; DMA 8237A-5. status register bits:
					; 0-3: channel 0-3 has reached terminal	count
					; 4-7: channel 0-3 has a request pending
		or	al, al
		jnz	short loc_13714
		mov	al, 20h	; ' '
		out	0, al

loc_13714:				; CODE XREF: seg000:370Ej
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
		popa
		pop	ds
		assume ds:nothing
		iret

; =============== S U B	R O U T	I N E =======================================


sub_1371B	proc near		; CODE XREF: sub_131D7p sub_131D7+Ap ...
		in	al, 60h		; 8042 keyboard	controller data	register
		out	5Fh, al
		out	5Fh, al
		out	5Fh, al
		test	al, 20h
		jnz	short sub_1371B

loc_13727:				; CODE XREF: sub_1371B+16j
		in	al, 60h		; 8042 keyboard	controller data	register
		out	5Fh, al
		out	5Fh, al
		out	5Fh, al
		test	al, 20h
		jz	short loc_13727
		retn
sub_1371B	endp

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR start

loc_13734:				; CODE XREF: start+193j
		cli
		push	cs
		pop	ds
		assume ds:seg000
		mov	es, word_1389C
		mov	bx, offset start
		add	bx, 10Fh
		shr	bx, 4
		mov	ah, 4Ah
		int	21h		; DOS -	2+ - ADJUST MEMORY BLOCK SIZE (SETBLOCK)
					; ES = segment address of block	to change
					; BX = new size	in paragraphs
		jb	short loc_13782
		mov	bx, 500h
		mov	ah, 48h
		int	21h		; DOS -	2+ - ALLOCATE MEMORY
					; BX = number of 16-byte paragraphs desired
		jb	short loc_13782
		mov	word_138B0, ax
		mov	ss, ax
		mov	sp, 5000h
		sti
		mov	dx, offset aFont1_fna ;	"FONT1.FNA"
		call	LoadFile1
		mov	word_13898, ax
		test	byte_13852, 0FFh
		jz	short loc_13776
		mov	dx, offset aFont1_fnd ;	"FONT1.FND"
		call	LoadFile1
		mov	word_13896, ax

loc_13776:				; CODE XREF: start-1D4Dj
		mov	dx, offset aCursor_dat ; "CURSOR.DAT"
		call	LoadFile1
		mov	word_1389A, ax
		jmp	LoadGSC
; ---------------------------------------------------------------------------

loc_13782:				; CODE XREF: start-1D6Fj start-1D66j
		mov	al, 20h
		int	0BEh		; used by BASIC	while in interpreter
; END OF FUNCTION CHUNK	FOR start
; ---------------------------------------------------------------------------
aFont1_fna	db 'FONT1.FNA',0        ; DATA XREF: start-1D5Bo
aFont1_fnd	db 'FONT1.FND',0        ; DATA XREF: start-1D4Bo
aCursor_dat	db 'CURSOR.DAT',0       ; DATA XREF: start:loc_13776o
aNoAccess	db '- NO ACCESS -',0    ; DATA XREF: SetupInts+4o
a36mSystemTermi	db 1Bh,'[36m<SYSTEM TERMINATED>',1Bh,'[m',0Dh,0Ah
					; DATA XREF: sub_1180D+190Fo
		db '$',0
byte_137D2	db 20h dup(0)		; DATA XREF: sub_13514+2o sub_13537+6o
gscFilePtr	dd 0			; DATA XREF: sub_1180D-2ECw
					; sub_1180D-1FBr ...
gscDataPtr	dd 0			; DATA XREF: sub_1180D-304w
					; sub_1180D-2FDw ...
gscStrPtr	dd 0			; DATA XREF: sub_1180D-2F6w
					; sub_1180D-2EFw ...
somePtr		dd 0			; DATA XREF: sub_1180D:gscMainLoopw
					; sub_1180D:loc_115A0w	...
scrRegMemPtr	dd 0			; DATA XREF: sub_10A1D+48r
					; scrEvalExpr+2Dr ...
word_13806	dw 0			; DATA XREF: sub_1180D:loc_1197Er
					; sub_1180D+1CFr ...
word_13808	dw 0			; DATA XREF: start+5Dw
dword_1380A	dd 0			; DATA XREF: scrEvalExpr+11Cr
					; sub_12530+110r ...
byte_1380E	db 20h dup(0)		; DATA XREF: LoadMDL+10Fo
					; sub_11DF7+38o ...
scrStackIdx	dw 0			; DATA XREF: sub_1180D-2D7w
					; sub_1180D:scr84_RetJumpw ...
		db 2 dup(0)
word_13832	dw 0			; DATA XREF: sub_1180D-B3w
					; sub_1180D-9Br
		db 2 dup(0)
word_13836	dw 0			; DATA XREF: LoadMDL+4Dw LoadMDL+101r
fileDataSeg	dw 0			; DATA XREF: LoadGSCFile:loc_11B94w
					; LoadGSCFile+95w ...
word_1383A	dw 0			; DATA XREF: LoadMDL:loc_11CE8w
					; LoadMDL+81w ...
word_1383C	dw 0			; DATA XREF: LoadMDL:loc_11D08w
					; LoadMDL+CFr ...
		db 6 dup(0)
word_13844	dw 0			; DATA XREF: sub_1180D:loc_1160Bw
					; sub_1180D:loc_11947w	...
gsc10		db 0			; DATA XREF: GenerateErrMsg+5r
					; sub_1180D-2DEw ...
		align 2
scrPos		dw 0			; DATA XREF: GenerateErrMsg+Cr
					; sub_1180D:loc_115A7w	...
scrCmdID	dw 0			; DATA XREF: GenerateErrMsg+13r
					; sub_1180D-25Ew ...
ErrorID		dw 0			; DATA XREF: seg000:0BEFw seg000:0C28r ...
word_1384E	dw 0			; DATA XREF: seg000:0BF2w
					; GenerateErrMsg+28r
		dw 0
byte_13852	db 0			; DATA XREF: start-1D52r
					; ParseArguments:loc_15784w
		align 2
word_13854	dw 0			; DATA XREF: BuildAbsolutePath+65r
					; start+64w ...
word_13856	dw 0			; DATA XREF: start+68w
lf3_FileNamePtr	dd 0			; DATA XREF: LoadGSCFile+Fw
					; lf3SaveFileName+8r ...
FilePathPtr	dd 0			; DATA XREF: CheckDiskID+33w
					; OpenFileRead1w ...
byte_13860	db 0			; DATA XREF: CheckDiskID+14r
					; BuildAbsolutePath+58r ...
byte_13861	db 0			; DATA XREF: sub_1180D+1908r
					; start:loc_15609w
byte_13862	db 0FFh			; DATA XREF: sub_10000+6w
					; sub_10000:loc_10013w	...
byte_13863	db 0			; DATA XREF: BuildAbsolutePath+25w
					; BuildAbsolutePath+39w ...
byte_13864	db 0			; DATA XREF: sub_1021E+5w
					; seg000:loc_10CD6r ...
byte_13865	db 0			; DATA XREF: ResolveString+4Dw
					; seg000:0CC1r
byte_13866	db 0			; DATA XREF: start+18r	start+119r ...
byte_13867	db 0			; DATA XREF: sub_1180D-1CEr
					; sub_133B4+56w
byte_13868	db 2 dup(0)		; DATA XREF: sub_10034+10w
					; BuildAbsolutePath+92r ...
DiskDriveIDs	db 0FFh, 0FFh		; DATA XREF: CheckDiskID+22r
					; BuildAbsolutePath+109r ...
byte_1386C	db 0FFh			; DATA XREF: start:loc_15644w
byte_1386D	db 0FFh			; DATA XREF: BuildAbsolutePath+18r
					; start+EDw
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
		db  7Fh	; 
		db    2
		db  8Fh	; è
		db    1
		db    0
		db 0FFh
		db 0FFh
		db    0
word_13882	dw 0			; DATA XREF: sub_1320B:loc_13221r
					; sub_1320B:loc_1323Aw	...
word_13884	dw 0			; DATA XREF: seg000:36BFw
byte_13886	db 0			; DATA XREF: sub_1320B+2r
					; seg000:loc_13677w
byte_13887	db 0			; DATA XREF: sub_1320B:loc_13217r
					; seg000:loc_13683w
word_13888	dw 0			; DATA XREF: DoSomePrint+42r
					; sub_109B3+3r	...
word_1388A	dw 0			; DATA XREF: DoSomePrint+15r
					; DoSomePrint+3Dr ...
word_1388C	dw 0			; DATA XREF: DoSomePrint+29w
					; DoSomePrint+83r ...
PrintPos	dw 0			; DATA XREF: seg000:07DDw
					; DoSomePrint+30r ...
PrintColor	db 0E1h			; DATA XREF: DoSomePrint+69r
					; DoSomePrint+123r ...
		align 2
byte_13892	db 0			; DATA XREF: DoSomePrint+88r
					; DoSomePrint+BAr ...
byte_13893	db 0			; DATA XREF: DoSomePrint+F9r
					; sub_109B3+1Fr
byte_13894	db 4Fh			; DATA XREF: DoSomePrint+7Cr
					; DoSomePrint+E8r ...
byte_13895	db 18h			; DATA XREF: DoSomePrint+8Dr
					; DoSomePrint:loc_108AAr ...
word_13896	dw 0			; DATA XREF: start-1D45w
word_13898	dw 0			; DATA XREF: start-1D55w
word_1389A	dw 0			; DATA XREF: start-1D3Cw
word_1389C	dw 0			; DATA XREF: start-1D81r start+3w ...
word_1389E	dw 0			; DATA XREF: start+14w
OldInt05	dd 0			; DATA XREF: RestoreInts+2r
					; SetupInts+53w ...
OldInt06	dd 0			; DATA XREF: RestoreInts+Dr
					; SetupInts+68w ...
OldInt0A	dd 0			; DATA XREF: RestoreInts+23r
					; SetupInts+7Dw ...
OldInt15	dd 0			; DATA XREF: RestoreInts+37r
					; SetupInts+9Cw ...
word_138B0	dw 0			; DATA XREF: start-1D64w
word_138B2	dw 0			; DATA XREF: sub_133B4+49w
					; RestoreInts+5Fr
word_138B4	dw 0, 0, 0		; DATA XREF: LoadMDL+56o LoadMDL+10Bo	...
word_138BA	dw 0			; DATA XREF: sub_13265r
		db 18h dup(0)
byte_138D4	db 0			; DATA XREF: AllocFileMem+7r
					; AllocFileMem+22w
byte_138D5	db 0			; DATA XREF: seg000:loc_10C51r
					; seg000:35A5r	...
byte_138D6	db 0			; DATA XREF: seg000:loc_135BEr
					; seg000:35C6w	...
		align 2
byte_138D8	db 0			; DATA XREF: sub_10B26+1Bw
					; sub_10B6C+7r	...
		align 2
byte_138DA	db 0			; DATA XREF: RestoreInts+1Ar
					; SetupInts+8Fw
byte_138DB	db 0FFh			; DATA XREF: seg000:364Dr
byte_138DC	db 0Ah			; DATA XREF: sub_12530+A55w
					; sub_12530+A63w ...
		align 2
word_138DE	dw 0			; DATA XREF: seg000:360Fw seg000:3613r ...
word_138E0	dw 0			; DATA XREF: seg000:361Ew
word_138E2	dw 0			; DATA XREF: sub_12530+B15w
					; sub_12530:loc_13062r	...
word_138E4	dw 3			; DATA XREF: seg000:loc_1362Cr
word_138E6	dw 0			; DATA XREF: seg000:3633w
word_138E8	dw 0			; DATA XREF: seg000:363Br seg000:3641w
		db 8 dup(0)
word_138F2	dw 0			; DATA XREF: start+D5w
byte_138F4	db 20h dup(0)		; DATA XREF: sub_1180D-2C3o
					; sub_1164D+Ao	...
unk_13914	db    0			; DATA XREF: start+12Co
unk_13915	db  90h	; ê		; DATA XREF: start:loc_155ECo
					; start:loc_15630o
		db    0
		db  91h	; ë
		db 30h dup(0)
byte_13948	db 40h dup(0)		; DATA XREF: start+56o
scrRegisterMem	db 800h	dup(0)		; DATA XREF: start+40o
byte_14188	db 800h	dup(0)		; DATA XREF: start+4Bo
byte_14988	db 80h dup(0)		; DATA XREF: start+61o
byte_14A08	db 24h dup(0)		; DATA XREF: CheckDiskID+6Do start+6Eo
byte_14A2C	db 0Ch dup(0)		; DATA XREF: sub_10000+1Eo
					; BuildAbsolutePath+80o ...
fullFilePath	db 100h	dup(0)		; DATA XREF: CheckDiskID:loc_10082o
					; LoadFile1+9o	...
byte_14B38	db 100h	dup(0)		; DATA XREF: CheckDiskID+5Co
InitialFileName	db 400h	dup(0)		; DATA XREF: start-3FC1o start+120o ...
byte_15038	db 80h dup(0)		; DATA XREF: start+DCo
byte_150B8	db 400h	dup(0)		; DATA XREF: sub_1180D:gscMainLoopo
					; sub_1180D:loc_115A0o
		assume ss:seg001, ds:nothing

; =============== S U B	R O U T	I N E =======================================


		public start
start		proc near		; DATA XREF: start-1D7Do

; FUNCTION CHUNK AT 14F0 SIZE 00000012 BYTES
; FUNCTION CHUNK AT 3734 SIZE 00000052 BYTES

		cld
		push	cs
		pop	ds
		assume ds:seg000
		mov	word_1389C, es
		call	PrintAboutMsg
		call	SetupInts
		call	ParseArguments
		mov	ah, 30h
		int	21h		; DOS -	GET DOS	VERSION
					; Return: AL = major version number (00h for DOS 1.x)
		mov	cs:word_1389E, ax
		test	cs:byte_13866, 0FFh
		jnz	short loc_154DC
		cmp	al, 3
		jb	short loc_154DE

loc_154DC:				; CODE XREF: start+1Ej
		jmp	short loc_154F4
; ---------------------------------------------------------------------------

loc_154DE:				; CODE XREF: start+22j
		mov	al, 22h
		int	0BEh		; used by BASIC	while in interpreter
		mov	ax, 226h
		int	0BEh		; used by BASIC	while in interpreter
		mov	ax, 326h
		int	0BEh		; used by BASIC	while in interpreter

loc_154EC:				; DATA XREF: start+8Do
		mov	bx, ax
		xor	ah, ah
		mov	al, 18h
		int	0BEh		; used by BASIC	while in interpreter

loc_154F4:				; CODE XREF: start:loc_154DCj
		push	cs
		pop	ds
		push	cs
		pop	es
		assume es:seg000
		mov	bx, offset scrRegisterMem
		mov	word ptr scrRegMemPtr, bx
		mov	word ptr scrRegMemPtr+2, cs
		mov	bx, offset byte_14188
		mov	word ptr dword_1380A, bx
		mov	word ptr dword_1380A+2,	cs
		mov	bx, offset byte_13948
		mov	word_13806, bx
		mov	word_13808, cs
		mov	bx, offset byte_14988
		mov	word_13854, bx
		mov	word_13856, cs
		xor	ax, ax
		mov	bx, offset byte_14A08
		mov	[bx], al
		mov	bx, offset byte_14A2C
		mov	[bx], al
		test	byte_1581F, 0FFh
		jz	short loc_1553F
		mov	si, offset a_disk ; "?_DISK"
		mov	al, 1
		call	sub_10000

loc_1553F:				; CODE XREF: start+7Dj
		mov	cx, 8
		mov	bx, offset byte_1380E
		mov	ax, offset loc_154EC

loc_15548:				; CODE XREF: start+98j
		mov	[bx], ax
		mov	word ptr [bx+2], cs
		add	bx, 4
		loop	loc_15548
		xor	ax, ax
		mov	di, word ptr scrRegMemPtr
		mov	cx, 400h
		rep stosw
		mov	di, word ptr dword_1380A
		mov	cx, 200h
		rep stosw
		mov	di, word_13806
		mov	cx, 20h
		rep stosw
		xor	ax, ax
		mov	ds, ax
		assume ds:nothing
		mov	dx, ds:500h
		xor	bx, bx
		xor	si, si
		mov	ax, 0F800h
		mov	ds, ax
		assume ds:nothing
		xor	ax, ax
		mov	cx, 4000h

loc_15585:				; CODE XREF: start+D3j
		lodsw
		xor	ax, bx
		add	dx, ax
		inc	bx
		loop	loc_15585
		mov	cs:word_138F2, dx
		push	cs
		pop	ds
		assume ds:seg000
		mov	dx, offset byte_15038
		mov	ah, 1Ah
		int	21h		; DOS -	SET DISK TRANSFER AREA ADDRESS
					; DS:DX	-> disk	transfer buffer
		push	cs
		pop	ds
		push	cs
		pop	es
		mov	ah, 19h
		int	21h		; DOS -	GET DEFAULT DISK NUMBER
		mov	dl, al
		mov	byte_1386D, al
		mov	di, word_13854
		add	al, 'A'
		stosb
		mov	ax, '\:'
		stosw
		inc	dl
		mov	si, di
		mov	ah, 47h
		int	21h		; DOS -	2+ - GET CURRENT DIRECTORY
					; DL = drive (0=default, 1=A, etc.)
					; DS:SI	points to 64-byte buffer area
		mov	cx, 50h
		mov	al, ch
		repne scasb
		cmp	byte ptr [di-2], '\'
		jz	short loc_155CD
		mov	word ptr [di-1], '\'

loc_155CD:				; CODE XREF: start+10Ej
		push	cs
		pop	ds
		push	cs
		pop	es
		test	byte_13866, 0FFh
		jnz	short loc_155EC
		mov	dx, offset InitialFileName
		mov	cl, 13h
		int	0DCh		; used by BASIC	while in interpreter
		mov	si, dx
		add	si, 1Ah
		mov	di, offset unk_13914
		mov	cx, 1Ah
		rep movsw

loc_155EC:				; CODE XREF: start+11Ej
		mov	si, offset unk_13915
		mov	ax, 3305h
		int	21h		; DOS -	4+ Get Boot Drive (DL =	boot drive, 1 =	A:, ...)
		dec	dl
		xor	bh, bh
		mov	bl, dl
		add	bl, bl
		mov	al, [bx+si]
		shr	al, 4
		xor	ah, ah
		cmp	al, 9
		jz	short loc_15609
		inc	ah

loc_15609:				; CODE XREF: start+14Dj
		mov	byte_13861, ah
		mov	byte_13860, ah
		mov	dx, 90h
		mov	cx, 1Ah

loc_15617:				; CODE XREF: start+176j
		lodsw
		cmp	al, dl
		jnz	short loc_1562C
		mov	bl, dl
		and	bx, 0Fh
		mov	DiskDriveIDs[bx], dh
		inc	dl
		cmp	bl, 1
		jnb	short loc_15630

loc_1562C:				; CODE XREF: start+162j
		inc	dh
		loop	loc_15617

loc_15630:				; CODE XREF: start+172j
		mov	si, offset unk_13915
		mov	dx, 0E0h
		mov	cx, 1Ah

loc_15639:				; CODE XREF: start+188j
		lodsw
		cmp	al, dl
		jz	short loc_15644
		inc	dh
		loop	loc_15639
		mov	dh, 0FFh

loc_15644:				; CODE XREF: start+184j
		mov	byte_1386C[bx],	dh
		call	ParseArguments
		jmp	loc_13734
start		endp ; sp-analysis failed


; =============== S U B	R O U T	I N E =======================================


SetupInts	proc near		; CODE XREF: start+Ap
		pushf
		cli
		push	cs
		pop	ds
		mov	ax, offset aNoAccess ; "- NO ACCESS -"
		mov	word ptr FilePathPtr, ax
		mov	word ptr FilePathPtr+2,	ds
		mov	dx, offset IntB0
		mov	ax, 25B0h
		int	21h		; DOS -	SET INTERRUPT VECTOR
					; AL = interrupt number
					; DS:DX	= new vector to	be used	for specified interrupt
		mov	dx, offset IntB1
		mov	ax, 25B1h
		int	21h		; DOS -	SET INTERRUPT VECTOR
					; AL = interrupt number
					; DS:DX	= new vector to	be used	for specified interrupt
		mov	dx, offset IntB8
		mov	ax, 25B8h
		int	21h		; DOS -	SET INTERRUPT VECTOR
					; AL = interrupt number
					; DS:DX	= new vector to	be used	for specified interrupt
		mov	dx, offset IntB9
		mov	ax, 25B9h
		int	21h		; DOS -	SET INTERRUPT VECTOR
					; AL = interrupt number
					; DS:DX	= new vector to	be used	for specified interrupt
		mov	dx, offset IntBE_ShowErr
		mov	ax, 25BEh
		int	21h		; DOS -	SET INTERRUPT VECTOR
					; AL = interrupt number
					; DS:DX	= new vector to	be used	for specified interrupt
		mov	dx, offset IntBF
		mov	ax, 25BFh
		int	21h		; DOS -	SET INTERRUPT VECTOR
					; AL = interrupt number
					; DS:DX	= new vector to	be used	for specified interrupt
		mov	dx, offset Int24
		mov	ax, 2524h
		int	21h		; DOS -	SET INTERRUPT VECTOR
					; AL = interrupt number
					; DS:DX	= new vector to	be used	for specified interrupt
		mov	dx, offset Int23
		mov	ax, 2523h
		int	21h		; DOS -	SET INTERRUPT VECTOR
					; AL = interrupt number
					; DS:DX	= new vector to	be used	for specified interrupt
		mov	ax, 3505h
		int	21h		; DOS -	2+ - GET INTERRUPT VECTOR
					; AL = interrupt number
					; Return: ES:BX	= value	of interrupt vector
		mov	word ptr OldInt05, bx
		mov	word ptr OldInt05+2, es
		mov	dx, offset Int05
		mov	ax, 2505h
		int	21h		; DOS -	SET INTERRUPT VECTOR
					; AL = interrupt number
					; DS:DX	= new vector to	be used	for specified interrupt
		mov	ax, 3506h
		int	21h		; DOS -	2+ - GET INTERRUPT VECTOR
					; AL = interrupt number
					; Return: ES:BX	= value	of interrupt vector
		mov	word ptr OldInt06, bx
		mov	word ptr OldInt06+2, es
		mov	dx, offset Int06
		mov	ax, 2506h
		int	21h		; DOS -	SET INTERRUPT VECTOR
					; AL = interrupt number
					; DS:DX	= new vector to	be used	for specified interrupt
		mov	ax, 350Ah
		int	21h		; DOS -	2+ - GET INTERRUPT VECTOR
					; AL = interrupt number
					; Return: ES:BX	= value	of interrupt vector
		mov	word ptr OldInt0A, bx
		mov	word ptr OldInt0A+2, es
		mov	dx, offset Int0A
		mov	ax, 250Ah
		int	21h		; DOS -	SET INTERRUPT VECTOR
					; AL = interrupt number
					; DS:DX	= new vector to	be used	for specified interrupt
		in	al, 2		; DMA controller, 8237A-5.
					; channel 1 current address
		mov	cs:byte_138DA, al
		and	al, 0FBh
		out	2, al		; DMA controller, 8237A-5.
					; channel 1 base address
					; (also	sets current address)
		mov	ax, 3515h
		int	21h		; DOS -	2+ - GET INTERRUPT VECTOR
					; AL = interrupt number
					; Return: ES:BX	= value	of interrupt vector
		mov	word ptr OldInt15, bx
		mov	word ptr OldInt15+2, es
		mov	dx, offset Int15
		mov	ax, 2515h
		int	21h		; DOS -	SET INTERRUPT VECTOR
					; AL = interrupt number
					; DS:DX	= new vector to	be used	for specified interrupt
		in	al, 0Ah		; DMA controller, 8237A-5.
					; single mask bit register
					; 0-1: select channel (00=0; 01=1; 10=2; 11=3)
					; 2: 1=set mask	for channel; 0=clear mask (enable)
		and	al, 0DFh
		out	0Ah, al		; DMA controller, 8237A-5.
					; single mask bit register
					; 0-1: select channel (00=0; 01=1; 10=2; 11=3)
					; 2: 1=set mask	for channel; 0=clear mask (enable)
		mov	dx, 0BFDBh
		mov	al, 1
		out	dx, al
		mov	dx, 7FDDh
		mov	al, 80h
		out	dx, al
		out	64h, al		; 8042 keyboard	controller command register.
		popf
		retn
SetupInts	endp


; =============== S U B	R O U T	I N E =======================================


ParseArguments	proc near		; CODE XREF: start+Dp start+190p
		mov	ds, cs:word_1389C
		assume ds:nothing
		push	cs
		pop	es
		mov	si, 80h
		mov	bl, 0FFh
		lodsb
		or	al, al
		jz	short loc_15754

loc_15721:				; CODE XREF: ParseArguments+1Cj
					; ParseArguments+20j ...
		lodsb
		cmp	al, '-'
		jz	short loc_15759
		cmp	al, '/'
		jz	short loc_15759
		cmp	al, 9
		jz	short loc_15721
		cmp	al, ' '
		jz	short loc_15721
		jb	short loc_1574F
		or	bl, bl
		jz	short loc_15754
		mov	di, offset InitialFileName
		dec	si
		mov	cx, 'P'

loc_1573F:				; CODE XREF: ParseArguments+35j
		lodsb
		cmp	al, ' '
		jbe	short loc_15747
		stosb
		loop	loc_1573F

loc_15747:				; CODE XREF: ParseArguments+32j
		xor	al, al
		stosb
		xor	bl, bl
		dec	si
		jmp	short loc_15721
; ---------------------------------------------------------------------------

loc_1574F:				; CODE XREF: ParseArguments+22j
		or	bl, bl
		js	short loc_15754
		retn
; ---------------------------------------------------------------------------

loc_15754:				; CODE XREF: ParseArguments+Fj
					; ParseArguments+26j ...
		mov	ax, 26h
		int	0BEh		; used by BASIC	while in interpreter

loc_15759:				; CODE XREF: ParseArguments+14j
					; ParseArguments+18j
		lodsb
		and	al, 0DFh
		cmp	al, 'H'
		jz	short loc_15774
		cmp	al, 'K'
		jz	short loc_15784
		cmp	al, 'M'
		jz	short loc_1577C
		cmp	al, 'F'
		jnz	short loc_15754
		mov	cs:byte_13860, 0
		jmp	short loc_15721
; ---------------------------------------------------------------------------

loc_15774:				; CODE XREF: ParseArguments+4Ej
		mov	cs:byte_1581F, 0FFh
		jmp	short loc_15721
; ---------------------------------------------------------------------------

loc_1577C:				; CODE XREF: ParseArguments+56j
		mov	cs:byte_13866, 0FFh
		jmp	short loc_15721
; ---------------------------------------------------------------------------

loc_15784:				; CODE XREF: ParseArguments+52j
		mov	cs:byte_13852, 0FFh
		jmp	short loc_15721
ParseArguments	endp


; =============== S U B	R O U T	I N E =======================================


PrintAboutMsg	proc near		; CODE XREF: start+7p
		mov	ah, 12h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		mov	dx, offset a1h33mgbSystemG ; "\x1B[>1h\x1A\x1B[33mÉ°-System  GSIC Interpreter\x1B"...
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		retn
PrintAboutMsg	endp

; ---------------------------------------------------------------------------
a1h33mgbSystemG	db 1Bh,'[>1h',1Ah,1Bh,'[33mÉ°-System  GSIC Interpreter',1Bh,'[m for PC-9801 Devel'
					; DATA XREF: PrintAboutMsg+4o
		db 'op version D1.00',0Dh,0Ah
		db 'Copyright (C)1994 ',1Bh,'[36mExtream / Discovery',1Bh,'[m',0Dh,0Ah
		db 0Ah,'$'
		db 1Ah,'$'
a_disk		db '?_DISK',0           ; DATA XREF: start+7Fo
byte_1581F	db 0			; DATA XREF: start+78r
					; ParseArguments:loc_15774w
seg000		ends

; ===========================================================================

; Segment type:	Uninitialized
seg001		segment	byte stack 'STACK' use16
		assume cs:seg001
		assume es:nothing, ss:nothing, ds:nothing, fs:nothing, gs:nothing
byte_15820	db 800h	dup(?)
seg001		ends


		end start
