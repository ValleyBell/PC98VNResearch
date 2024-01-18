; Input	MD5   :	83F710F83324A36CEB87858F997DE0C9
; Input	CRC32 :	76A2E744

; File Name   :	D:\TW.EXE
; Format      :	MS-DOS executable (EXE)
; Base Address:	1000h Range: 10000h-230F1h Loaded length: 6AF4h
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
		cld
		mov	ax, ss
		or	ax, ax
		jnz	short loc_10012
		mov	cs:byte_112B9, 80h ; 'Ä'
		call	sub_10DA2
		jmp	short loc_1001B
; ---------------------------------------------------------------------------

loc_10012:				; CODE XREF: start+5j
		mov	cs:byte_112B9, 0
		call	sub_10DE9

loc_1001B:				; CODE XREF: start+10j
		call	LoadIndexFiles
		call	sub_1105E
		call	sub_10ECA
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		mov	es, ax
		assume es:seg001
		mov	byte ptr ds:1D19h, 0
		mov	byte ptr ds:1D1Ah, 0
		mov	byte ptr ds:1D1Bh, 0FFh

loc_1003A:				; CODE XREF: start+6Fj
		mov	bl, ds:1D1Ah
		cmp	bl, ds:1D1Bh
		jz	short loc_10057
		mov	ds:1D1Bh, bl
		push	ds
		push	es
		pusha
		xor	bh, bh
		shl	bx, 1
		call	cs:off_10089[bx]
		popa
		pop	es
		assume es:nothing
		pop	ds
		assume ds:nothing

loc_10057:				; CODE XREF: start+42j
		push	ds
		push	es
		pusha
		mov	bl, ds:1D1Ah
		xor	bh, bh
		shl	bx, 1
		call	cs:off_1008D[bx]
		popa
		pop	es
		pop	ds
		test	byte ptr ds:1D19h, 80h
		jz	short loc_1003A
		call	SoundCall9
		call	sub_1119A
		cmp	cs:byte_112B9, 0

loc_1007D:				; CODE XREF: start:loc_1007Dj
		jnz	short loc_1007D
		mov	ax, 0C00h

loc_10082:				; DOS -	CLEAR KEYBOARD BUFFER
		int	21h		; AL must be 01h, 06h, 07h, 08h, or 0Ah.
		mov	ax, 4C00h
		int	21h		; DOS -	2+ - QUIT WITH EXIT CODE (EXIT)
start		endp			; AL = exit code

; ---------------------------------------------------------------------------
off_10089	dw offset LoadSaveGames	; 0 ; DATA XREF: start+4Fr
		dw offset nullsub_6	; 1
off_1008D	dw offset sub_11363	; 0 ; DATA XREF: start+62r
		dw offset DoScript	; 1

; =============== S U B	R O U T	I N E =======================================


LoadPlayBGM	proc near		; CODE XREF: sub_11363+2BFp
					; sub_11363+2F0p ...
		push	bx
		mov	bl, cs:MusicMode
		xor	bh, bh
		shl	bx, 1
		call	cs:off_100A2[bx]
		pop	bx
		retn
LoadPlayBGM	endp

; ---------------------------------------------------------------------------
off_100A2	dw offset nullsub_1	; 0 ; DATA XREF: LoadPlayBGM+Ar
		dw offset LoadPlayBGM_FM; 1
		dw offset LoadPlayBGM_MIDI; 2

; =============== S U B	R O U T	I N E =======================================


nullsub_1	proc near		; CODE XREF: LoadPlayBGM+Ap
					; DATA XREF: seg000:off_100A2o
		retn
nullsub_1	endp


; =============== S U B	R O U T	I N E =======================================


LoadPlayBGM_FM	proc near		; CODE XREF: LoadPlayBGM+Ap
					; DATA XREF: seg000:off_100A2o
		push	ds
		push	seg seg001
		pop	ds
		assume ds:seg001
		cmp	al, ds:99F5h
		jz	short loc_100DF
		push	ax
		and	al, 7Fh
		mov	ds:99F5h, al
		cmp	al, ds:99F4h
		jz	short loc_100DA
		mov	ds:99F4h, al
		push	bx
		push	dx
		push	bp
		push	ax
		mov	ah, 1
		int	41h		; call FM driver
		mov	ah, 19h
		int	41h		; call FM driver
		pop	ax
		add	al, 20h		; AX = 120h+n -> FM song
		mov	ah, 1
		call	ReadArcFile_Cmp
		pop	bp
		pop	dx
		pop	bx

loc_100DA:				; CODE XREF: LoadPlayBGM_FM+15j
		mov	ah, 0
		int	41h		; call FM driver
		pop	ax

loc_100DF:				; CODE XREF: LoadPlayBGM_FM+9j
		pop	ds
		assume ds:nothing
		retn
LoadPlayBGM_FM	endp


; =============== S U B	R O U T	I N E =======================================


LoadPlayBGM_MIDI proc near		; CODE XREF: LoadPlayBGM+Ap
					; DATA XREF: seg000:off_100A2o
		cmp	cs:byte_112BD, 0
		jnz	short loc_100F4
		mov	ah, al
		and	ah, 7Fh
		cmp	ah, 7
		jb	short loc_100F4
		retn
; ---------------------------------------------------------------------------

loc_100F4:				; CODE XREF: LoadPlayBGM_MIDI+6j
					; LoadPlayBGM_MIDI+10j
		push	ds
		push	seg seg001
		pop	ds
		assume ds:seg001
		cmp	al, ds:99F5h
		jz	short loc_10136
		push	ax
		and	al, 7Fh
		mov	ds:99F5h, al
		cmp	al, ds:99F4h
		jz	short loc_10131
		mov	ds:99F4h, al
		push	bx
		push	dx
		push	bp
		push	ax
		mov	ah, 1
		int	42h		; call MIDI driver
		mov	ah, 19h
		int	42h		; call MIDI driver
		pop	ax
		cmp	cs:byte_112BD, 0
		jnz	short loc_10127
		add	al, 40h		; AX = 140h+n -> MIDI song, MT-32
		jmp	short loc_10129
; ---------------------------------------------------------------------------

loc_10127:				; CODE XREF: LoadPlayBGM_MIDI+40j
		add	al, 60h		; AX = 160h+n -> MIDI song, GS

loc_10129:				; CODE XREF: LoadPlayBGM_MIDI+44j
		mov	ah, 1
		call	ReadArcFile_Cmp
		pop	bp
		pop	dx
		pop	bx

loc_10131:				; CODE XREF: LoadPlayBGM_MIDI+28j
		xor	ax, ax
		int	42h		; call MIDI driver
		pop	ax

loc_10136:				; CODE XREF: LoadPlayBGM_MIDI+1Cj
		pop	ds
		assume ds:nothing
		retn
LoadPlayBGM_MIDI endp


; =============== S U B	R O U T	I N E =======================================


StopBGM		proc near		; CODE XREF: sub_11363+8p
					; seg000:loc_12440p
		push	bx
		mov	bl, cs:MusicMode
		xor	bh, bh
		shl	bx, 1
		call	cs:off_10149[bx]
		pop	bx
		retn
StopBGM		endp

; ---------------------------------------------------------------------------
off_10149	dw offset nullsub_2	; 0 ; DATA XREF: StopBGM+Ar
		dw offset StopBGM_FM	; 1
		dw offset StopBGM_MIDI	; 2

; =============== S U B	R O U T	I N E =======================================


nullsub_2	proc near		; CODE XREF: StopBGM+Ap
					; DATA XREF: seg000:off_10149o
		retn
nullsub_2	endp


; =============== S U B	R O U T	I N E =======================================


StopBGM_FM	proc near		; CODE XREF: StopBGM+Ap
					; DATA XREF: seg000:off_10149o
		push	ds
		push	ax
		mov	ah, 1
		int	41h		; call FM driver
		push	seg seg001
		pop	ds
		assume ds:seg001
		mov	byte ptr ds:99F5h, 0FFh
		pop	ax
		pop	ds
		assume ds:nothing
		retn
StopBGM_FM	endp


; =============== S U B	R O U T	I N E =======================================


StopBGM_MIDI	proc near		; CODE XREF: StopBGM+Ap
					; DATA XREF: seg000:off_10149o
		push	ds
		push	ax
		mov	ah, 1
		int	42h		; call MIDI driver
		push	seg seg001
		pop	ds
		assume ds:seg001
		mov	byte ptr ds:99F5h, 0FFh
		pop	ax
		pop	ds
		assume ds:nothing
		retn
StopBGM_MIDI	endp


; =============== S U B	R O U T	I N E =======================================


SoundCall2	proc near		; CODE XREF: sub_11363+2C7p
					; sub_11363+2F8p ...
		push	bx
		mov	bl, cs:MusicMode
		xor	bh, bh
		shl	bx, 1
		call	cs:off_10185[bx]
		pop	bx
		retn
SoundCall2	endp

; ---------------------------------------------------------------------------
off_10185	dw offset nullsub_3	; 0 ; DATA XREF: SoundCall2+Ar
		dw offset sub_1018C	; 1
		dw offset sub_101A0	; 2

; =============== S U B	R O U T	I N E =======================================


nullsub_3	proc near		; CODE XREF: SoundCall2+Ap
					; DATA XREF: seg000:off_10185o
		retn
nullsub_3	endp


; =============== S U B	R O U T	I N E =======================================


sub_1018C	proc near		; CODE XREF: SoundCall2+Ap
					; DATA XREF: seg000:off_10185o
		push	ds
		push	ax
		mov	bx, ax
		mov	ah, 12h
		int	41h		; call FM driver
		push	seg seg001
		pop	ds
		assume ds:seg001
		mov	byte ptr ds:99F5h, 0FFh
		pop	ax
		pop	ds
		assume ds:nothing
		retn
sub_1018C	endp


; =============== S U B	R O U T	I N E =======================================


sub_101A0	proc near		; CODE XREF: SoundCall2+Ap
					; DATA XREF: seg000:off_10185o
		push	ds
		push	ax
		mov	bx, ax
		mov	ah, 12h
		int	42h		; call MIDI driver
		push	seg seg001
		pop	ds
		assume ds:seg001
		mov	byte ptr ds:99F5h, 0FFh
		pop	ax
		pop	ds
		assume ds:nothing
		retn
sub_101A0	endp


; =============== S U B	R O U T	I N E =======================================


SoundCall3	proc near		; CODE XREF: sub_1249Cp sub_124A4p
		push	bx
		mov	bl, cs:MusicMode
		xor	bh, bh
		shl	bx, 1
		call	cs:off_101C5[bx]
		pop	bx
		retn
SoundCall3	endp

; ---------------------------------------------------------------------------
off_101C5	dw offset sub_101CB	; 0 ; DATA XREF: SoundCall3+Ar
		dw offset sub_101CF	; 1
		dw offset sub_101D4	; 2

; =============== S U B	R O U T	I N E =======================================


sub_101CB	proc near		; CODE XREF: SoundCall3+Ap
					; DATA XREF: seg000:off_101C5o
		mov	ax, 0FFFFh
		retn
sub_101CB	endp


; =============== S U B	R O U T	I N E =======================================


sub_101CF	proc near		; CODE XREF: SoundCall3+Ap
					; DATA XREF: seg000:off_101C5o
		mov	ah, 11h
		int	41h		; call FM driver
		retn
sub_101CF	endp


; =============== S U B	R O U T	I N E =======================================


sub_101D4	proc near		; CODE XREF: SoundCall3+Ap
					; DATA XREF: seg000:off_101C5o
		mov	ah, 11h
		int	42h		; call MIDI driver
		retn
sub_101D4	endp


; =============== S U B	R O U T	I N E =======================================


SoundCall4	proc near		; CODE XREF: seg000:2452p
		push	bx
		mov	bl, cs:MusicMode
		xor	bh, bh
		shl	bx, 1
		call	cs:off_101EA[bx]
		pop	bx
		retn
SoundCall4	endp

; ---------------------------------------------------------------------------
off_101EA	dw offset nullsub_8	; 0 ; DATA XREF: SoundCall4+Ar
		dw offset sub_101F1	; 1
		dw offset sub_101F8	; 2

; =============== S U B	R O U T	I N E =======================================


nullsub_8	proc near		; CODE XREF: SoundCall4+Ap
					; DATA XREF: seg000:off_101EAo
		retn
nullsub_8	endp


; =============== S U B	R O U T	I N E =======================================


sub_101F1	proc near		; CODE XREF: SoundCall4+Ap
					; DATA XREF: seg000:off_101EAo
		push	ax
		mov	ah, 2
		int	41h		; call FM driver
		pop	ax
		retn
sub_101F1	endp


; =============== S U B	R O U T	I N E =======================================


sub_101F8	proc near		; CODE XREF: SoundCall4+Ap
					; DATA XREF: seg000:off_101EAo
		push	ax
		mov	ah, 2
		int	42h		; call MIDI driver
		pop	ax
		retn
sub_101F8	endp


; =============== S U B	R O U T	I N E =======================================


SoundCall5	proc near
		push	bx		; unused
		mov	bl, cs:MusicMode
		xor	bh, bh
		shl	bx, 1
		call	cs:off_10210[bx]
		pop	bx
		retn
SoundCall5	endp

; ---------------------------------------------------------------------------
off_10210	dw offset nullsub_9	; 0 ; DATA XREF: SoundCall5+Ar
		dw offset sub_10217	; 1
		dw offset sub_1021E	; 2

; =============== S U B	R O U T	I N E =======================================


nullsub_9	proc near		; CODE XREF: SoundCall5+Ap
					; DATA XREF: seg000:off_10210o
		retn
nullsub_9	endp


; =============== S U B	R O U T	I N E =======================================


sub_10217	proc near		; DATA XREF: seg000:off_10210o
		push	ax
		mov	ah, 3
		int	41h		; call FM driver
		pop	ax
		retn
sub_10217	endp


; =============== S U B	R O U T	I N E =======================================


sub_1021E	proc near		; DATA XREF: seg000:off_10210o
		push	ax
		mov	ah, 3
		int	42h		; call MIDI driver
		pop	ax
		retn
sub_1021E	endp


; =============== S U B	R O U T	I N E =======================================


SoundCall6	proc near
		push	bx		; unused
		mov	bl, cs:MusicMode
		xor	bh, bh
		shl	bx, 1
		call	cs:off_10236[bx]
		pop	bx
		retn
SoundCall6	endp

; ---------------------------------------------------------------------------
off_10236	dw offset nullsub_10	; 0 ; DATA XREF: SoundCall6+Ar
		dw offset sub_1023D	; 1
		dw offset sub_1024A	; 2

; =============== S U B	R O U T	I N E =======================================


nullsub_10	proc near		; CODE XREF: SoundCall6+Ap
					; DATA XREF: seg000:off_10236o
		retn
nullsub_10	endp


; =============== S U B	R O U T	I N E =======================================


sub_1023D	proc near		; DATA XREF: seg000:off_10236o
		push	ax
		mov	ah, 0Ah
		int	41h		; call FM driver
		mov	cs:byte_112BB, 0
		pop	ax
		retn
sub_1023D	endp


; =============== S U B	R O U T	I N E =======================================


sub_1024A	proc near		; DATA XREF: seg000:off_10236o
		push	ax
		mov	ah, 0Ah
		int	42h		; call MIDI driver
		mov	cs:byte_112BB, 0
		pop	ax
		retn
sub_1024A	endp


; =============== S U B	R O U T	I N E =======================================


SoundCall7	proc near
		push	bx		; unused
		mov	bl, cs:MusicMode
		xor	bh, bh
		shl	bx, 1
		call	cs:off_10268[bx]
		pop	bx
		retn
SoundCall7	endp

; ---------------------------------------------------------------------------
off_10268	dw offset nullsub_11	; 0 ; DATA XREF: SoundCall7+Ar
		dw offset sub_1026F	; 1
		dw offset sub_1027C	; 2

; =============== S U B	R O U T	I N E =======================================


nullsub_11	proc near		; CODE XREF: SoundCall7+Ap
					; DATA XREF: seg000:off_10268o
		retn
nullsub_11	endp


; =============== S U B	R O U T	I N E =======================================


sub_1026F	proc near		; DATA XREF: seg000:off_10268o
		push	ax
		mov	ah, 0Bh
		int	41h		; call FM driver
		mov	cs:byte_112BB, 0FFh
		pop	ax
		retn
sub_1026F	endp


; =============== S U B	R O U T	I N E =======================================


sub_1027C	proc near		; DATA XREF: seg000:off_10268o
		push	ax
		mov	ah, 0Bh
		int	42h		; call MIDI driver
		mov	cs:byte_112BB, 0FFh
		pop	ax
		retn
sub_1027C	endp


; =============== S U B	R O U T	I N E =======================================


LoadSoundDriver	proc near		; CODE XREF: sub_11363+177p
		push	ds
		push	es
		pusha
		push	seg seg001
		pop	ds
		assume ds:seg001
		mov	cs:MusicMode, al
		mov	bl, al
		xor	bh, bh
		shl	bx, 1
		call	cs:off_102A3[bx]
		popa
		pop	es
		pop	ds
		assume ds:nothing
		retn
LoadSoundDriver	endp

; ---------------------------------------------------------------------------
off_102A3	dw offset nullsub_4	; 0 ; DATA XREF: LoadSoundDriver+11r
		dw offset LoadSndDrv_FM	; 1
		dw offset LoadSndDrv_MIDI; 2

; =============== S U B	R O U T	I N E =======================================


nullsub_4	proc near		; CODE XREF: LoadSoundDriver+11p
					; DATA XREF: seg000:off_102A3o
		retn
nullsub_4	endp


; =============== S U B	R O U T	I N E =======================================


LoadSndDrv_FM	proc far		; CODE XREF: LoadSoundDriver+11p
					; DATA XREF: seg000:off_102A3o
		push	dx
		mov	al, cs:MusicMode
		push	ax
		mov	cs:MusicMode, 0
		mov	bx, cs:word_112C4
		xor	bp, bp
		mov	ax, 100h	; archive 01h (TWMUSIC), file 00h - FM sound driver
		call	ReadArcFile_Cmp
		push	cs
		push	offset LoadSndData_FM
		push	bx
		push	bp
		mov	al, 41h		; FM driver interrupt: 41h
		retf
LoadSndDrv_FM	endp ; sp-analysis failed

; ---------------------------------------------------------------------------

LoadSndData_FM:				; DATA XREF: LoadSndDrv_FM+1Ao
		pop	ax
		mov	cs:MusicMode, al
		add	bp, ds:24DBh
		mov	ax, 101h
		call	ReadArcFile_Cmp
		mov	ah, 1Ah
		int	41h
		add	bp, ds:24DBh
		mov	ax, 102h
		call	ReadArcFile_Cmp
		mov	ah, 1Ch
		int	41h
		add	bp, ds:24DBh
		mov	ax, 103h	; file 03 - FM instrument data
		call	ReadArcFile_Cmp
		mov	ah, 1Eh
		int	41h
		add	bp, ds:24DBh
		mov	ax, 104h	; file 04 - SSG	instrument data
		call	ReadArcFile_Cmp
		mov	ah, 20h
		int	41h
		add	bp, ds:24DBh
		mov	ax, 105h
		call	ReadArcFile_Cmp
		mov	ah, 22h
		int	41h
		add	bp, ds:24DBh
		mov	ah, 18h
		int	41h
		pop	bx
		mov	ah, 8
		int	41h
		xor	al, al
		mov	ah, 14h
		int	41h
		mov	byte ptr ds:99F4h, 0FFh
		mov	byte ptr ds:99F5h, 0FFh
		mov	cs:byte_112BB, 0
		retn

; =============== S U B	R O U T	I N E =======================================


LoadSndDrv_MIDI	proc far		; CODE XREF: LoadSoundDriver+11p
					; DATA XREF: seg000:off_102A3o
		mov	al, cs:MusicMode
		push	ax
		mov	cs:MusicMode, 0
		push	dx
		mov	bx, cs:word_112C4
		xor	bp, bp
		mov	ax, 108h	; archive 01h (TWMUSIC), file 08h - MIDI sound driver
		call	ReadArcFile_Cmp
		pop	dx
		push	cs
		push	offset LoadSndData_MIDI
		push	bx
		push	bp
		mov	ah, dl
		mov	al, 42h		; MIDI driver interrupt: 41h
		retf
LoadSndDrv_MIDI	endp ; sp-analysis failed

; ---------------------------------------------------------------------------

LoadSndData_MIDI:			; DATA XREF: LoadSndDrv_MIDI+1Bo
		pop	ax
		mov	cs:MusicMode, al
		add	bp, ds:24DBh
		mov	ax, 101h
		call	ReadArcFile_Cmp
		mov	ah, 1Ah
		int	42h
		add	bp, ds:24DBh
		mov	ax, 102h
		call	ReadArcFile_Cmp
		mov	ah, 1Ch
		int	42h
		add	bp, ds:24DBh
		mov	ax, 104h	; file 04 - SSG	instrument data
		call	ReadArcFile_Cmp
		mov	ah, 20h
		int	42h
		add	bp, ds:24DBh
		mov	ah, 18h
		int	42h
		mov	byte ptr ds:99F4h, 0FFh
		mov	byte ptr ds:99F5h, 0FFh
		mov	cs:byte_112BB, 0
		mov	cs:byte_112BE, 0
		retn

; =============== S U B	R O U T	I N E =======================================


SoundCall9	proc near		; CODE XREF: start+71p
		push	bx
		mov	bl, cs:MusicMode
		xor	bh, bh
		shl	bx, 1
		call	cs:off_103BF[bx]
		pop	bx
		retn
SoundCall9	endp

; ---------------------------------------------------------------------------
off_103BF	dw offset nullsub_5	; 0 ; DATA XREF: SoundCall9+Ar
		dw offset sub_103C6	; 1
		dw offset sub_103CD	; 2

; =============== S U B	R O U T	I N E =======================================


nullsub_5	proc near		; CODE XREF: SoundCall9+Ap
					; DATA XREF: seg000:off_103BFo
		retn
nullsub_5	endp


; =============== S U B	R O U T	I N E =======================================


sub_103C6	proc near		; CODE XREF: SoundCall9+Ap
					; DATA XREF: seg000:off_103BFo
		push	ax
		mov	ah, 10h
		int	41h		; call FM driver
		pop	ax
		retn
sub_103C6	endp


; =============== S U B	R O U T	I N E =======================================


sub_103CD	proc near		; CODE XREF: SoundCall9+Ap
					; DATA XREF: seg000:off_103BFo
		push	ax
		mov	cs:byte_112BE, 0FFh
		mov	ah, 10h
		int	42h		; call MIDI driver
		pop	ax
		retn
sub_103CD	endp


; =============== S U B	R O U T	I N E =======================================

; read file from archive (raw data)

ReadArcFile_Raw	proc near		; CODE XREF: LoadSaveGames+43p
		push	ds
		push	es
		pusha
		push	seg seg001
		pop	ds
		assume ds:seg001
		push	cs:word_112CA
		pop	es
		mov	ds:24D7h, bp	; buffer pointer
		mov	ds:24D9h, bx	; buffer segment
		mov	bp, ax
		and	bp, 0FFh
		shl	bp, 3		; 8 bytes per entry
		mov	bl, ah
		xor	bh, bh
		shl	bx, 1		; BX = archive ID * 2
		add	bp, es:[bx]	; get TOC data pointer for the respective archive
		push	word ptr es:[bp+0] ; copy the 4-byte file offset to "seek position"
		pop	word ptr ds:24DDh
		push	word ptr es:[bp+2]
		pop	word ptr ds:24DFh
		mov	dx, es:[bp+4]
		or	dx, dx
		jz	short loc_10432	; file size == 0 -> exit
		mov	ds:24DBh, dx	; store	"bytes to read"
		mov	di, 1F55h	; TWDIR	data
		mov	cl, 4
		mov	al, ah
		mul	cl
		add	di, ax		; DI = offset of file name

loc_10428:				; CODE XREF: ReadArcFile_Raw+56j
		call	ReadFile
		jnb	short loc_10432
		call	HandleFileError
		jmp	short loc_10428
; ---------------------------------------------------------------------------

loc_10432:				; CODE XREF: ReadArcFile_Raw+3Dj
					; ReadArcFile_Raw+51j
		popa
		pop	es
		pop	ds
		assume ds:nothing
		retn
ReadArcFile_Raw	endp


; =============== S U B	R O U T	I N E =======================================

; read file from archive (compressed data)

ReadArcFile_Cmp	proc near		; CODE XREF: LoadPlayBGM_FM+2Bp
					; LoadPlayBGM_MIDI+4Ap	...

; FUNCTION CHUNK AT 079D SIZE 00000016 BYTES

		push	ds
		push	es
		push	bx
		push	cx
		push	si
		push	di
		push	bp
		push	seg seg001
		pop	ds
		assume ds:seg001
		push	cs:word_112CA
		pop	es
		mov	ds:256Bh, bp
		mov	ds:256Dh, bx
		mov	bp, ax
		and	bp, 0FFh
		shl	bp, 3		; 8 bytes per entry
		mov	bl, ah
		xor	bh, bh
		shl	bx, 1		; BX = archive ID * 2
		add	bp, es:[bx]	; get TOC data pointer for the respective archive
		push	word ptr es:[bp+0] ; copy the 4-byte file offset to "seek position"
		pop	word ptr ds:24DDh
		push	word ptr es:[bp+2]
		pop	word ptr ds:24DFh
		mov	dx, es:[bp+4]
		or	dx, dx
		jnz	short loc_1047C
		jmp	loc_107AD	; file size == 0 -> exit
; ---------------------------------------------------------------------------

loc_1047C:				; CODE XREF: ReadArcFile_Cmp+41j
		mov	ds:24DBh, dx
		mov	di, 1F55h	; TWDIR	data
		mov	cl, 4
		mov	al, ah
		mul	cl
		add	di, ax		; DI = offset of file name
		mov	ds:256Fh, di
		push	seg seg001
		pop	es
		assume es:seg001
		mov	word ptr ds:24D7h, 2571h ; buffer pointer: compression header
		mov	word ptr ds:24D9h, seg seg001 ;	buffer segment
		mov	word ptr ds:24DBh, 8 ; read 8 bytes

loc_104A5:				; CODE XREF: ReadArcFile_Cmp+77j
		call	ReadFile
		jnb	short loc_104AF
		call	HandleFileError	; also handles disk swapping
		jmp	short loc_104A5
; ---------------------------------------------------------------------------

loc_104AF:				; CODE XREF: ReadArcFile_Cmp+72j
		mov	ax, ds:24DBh
		add	ds:24DDh, ax	; advance file pointer by 8
		adc	word ptr ds:24DFh, 0
		push	word ptr ds:2575h ; decompressed size (low)
		push	word ptr ds:2577h ; decompressed size (high)
		mov	word ptr ds:6579h, 0 ; input buffer pointer = 0
		call	Decomp_ReadFile
		xor	ax, ax
		mov	ds:657Bh, ax
		mov	ds:99E7h, ax
		mov	ds:99E9h, al
		mov	ds:99EAh, al
		mov	al, 10h
		call	Decomp_GetBits
		xor	di, di		; initialize output buffer offset = 0
		sub	word ptr ds:2575h, 1
		sbb	word ptr ds:2577h, 0
		jnb	short loc_104F0
		jmp	rfa_cmp_end
; ---------------------------------------------------------------------------

loc_104F0:				; CODE XREF: ReadArcFile_Cmp+B5j
					; ReadArcFile_Cmp:loc_10516j ...
		call	Decomp_GetCtrl
		or	ah, ah
		jnz	short loc_10518
		mov	[di+2579h], al
		inc	di
		sub	word ptr ds:2575h, 1
		sbb	word ptr ds:2577h, 0
		jnb	short loc_1050B
		jmp	rfa_cmp_end
; ---------------------------------------------------------------------------

loc_1050B:				; CODE XREF: ReadArcFile_Cmp+D0j
		test	di, 4000h
		jz	short loc_10516
		call	Decomp_FlushBuf
		xor	di, di

loc_10516:				; CODE XREF: ReadArcFile_Cmp+D9j
		jmp	short loc_104F0
; ---------------------------------------------------------------------------

loc_10518:				; CODE XREF: ReadArcFile_Cmp+BFj
		mov	cx, ax
		sub	cx, 0FDh
		call	Decomp_GetCopyOfs
		mov	si, di
		stc
		sbb	si, ax

loc_10526:				; CODE XREF: ReadArcFile_Cmp:loc_1054Ej
		and	si, 3FFFh
		mov	al, [si+2579h]
		inc	si
		mov	[di+2579h], al
		inc	di
		sub	word ptr ds:2575h, 1
		sbb	word ptr ds:2577h, 0
		jnb	short loc_10543
		jmp	rfa_cmp_end
; ---------------------------------------------------------------------------

loc_10543:				; CODE XREF: ReadArcFile_Cmp+108j
		test	di, 4000h
		jz	short loc_1054E
		call	Decomp_FlushBuf
		xor	di, di

loc_1054E:				; CODE XREF: ReadArcFile_Cmp+111j
		loop	loc_10526
		jmp	short loc_104F0
ReadArcFile_Cmp	endp


; =============== S U B	R O U T	I N E =======================================


Decomp_GetCtrl	proc near		; CODE XREF: ReadArcFile_Cmp:loc_104F0p
		sub	word ptr ds:657Bh, 1
		jnb	short loc_1057D
		push	di
		mov	al, 10h
		call	sub_107B3
		dec	ax
		mov	ds:657Bh, ax
		mov	si, 13h
		mov	dl, 5
		mov	cx, 3
		call	sub_105F0
		call	sub_10666
		mov	si, 0Eh
		mov	dl, 4
		mov	cx, 0FFFFh
		call	sub_105F0
		pop	di

loc_1057D:				; CODE XREF: Decomp_GetCtrl+5j
		mov	bx, ds:99E7h
		mov	cl, 4
		shr	bx, cl
		shl	bx, 1
		mov	bx, [bx+7569h]
		cmp	bx, 1FEh
		jb	short loc_10594
		call	sub_1059E

loc_10594:				; CODE XREF: Decomp_GetCtrl+3Dj
		push	bx
		mov	al, [bx+9769h]
		call	Decomp_GetBits
		pop	ax
		retn
Decomp_GetCtrl	endp


; =============== S U B	R O U T	I N E =======================================


sub_1059E	proc near		; CODE XREF: Decomp_GetCtrl+3Fp
		mov	ax, ds:99E7h
		shl	al, cl
		mov	cx, 1FEh
sub_1059E	endp ; sp-analysis failed


; =============== S U B	R O U T	I N E =======================================


sub_105A6	proc near		; CODE XREF: sub_105B4+2j
					; Decomp_GetCopyOfs+18p
		shl	al, 1
		jnb	short loc_105B0
		mov	bx, [bx+6D73h]
		jmp	short sub_105B4
; ---------------------------------------------------------------------------

loc_105B0:				; CODE XREF: sub_105A6+2j
		mov	bx, [bx+657Dh]
sub_105A6	endp ; sp-analysis failed


; =============== S U B	R O U T	I N E =======================================


sub_105B4	proc near		; CODE XREF: sub_105A6+8j
					; sub_10666+3Fp
		cmp	bx, cx
		jnb	short sub_105A6
		retn
sub_105B4	endp


; =============== S U B	R O U T	I N E =======================================


Decomp_GetCopyOfs proc near		; CODE XREF: ReadArcFile_Cmp+E8p
		push	cx
		xor	bh, bh
		mov	bl, ds:99E8h
		shl	bx, 1
		mov	bx, [bx+9569h]
		cmp	bx, 0Eh
		jb	short loc_105D4
		mov	al, ds:99E7h
		mov	cx, 0Eh
		call	sub_105A6

loc_105D4:				; CODE XREF: Decomp_GetCopyOfs+10j
		push	bx
		mov	al, [bx+9967h]
		call	Decomp_GetBits
		pop	ax
		cmp	al, 1
		jbe	short loc_105EE
		dec	ax
		mov	cx, ax
		call	sub_107B3
		mov	bx, 1
		shl	bx, cl
		or	ax, bx

loc_105EE:				; CODE XREF: Decomp_GetCopyOfs+26j
		pop	cx
		retn
Decomp_GetCopyOfs endp


; =============== S U B	R O U T	I N E =======================================


sub_105F0	proc near		; CODE XREF: Decomp_GetCtrl+19p
					; Decomp_GetCtrl+27p
		push	si
		mov	al, dl
		call	sub_107B3
		cmp	ax, si
		jbe	short loc_10600
		mov	ax, -1
		jmp	ShowError
; ---------------------------------------------------------------------------

loc_10600:				; CODE XREF: sub_105F0+8j
		mov	di, 9967h
		or	ax, ax
		jnz	short loc_10618
		pop	cx
		rep stosb
		mov	al, dl
		call	sub_107B3
		mov	cx, 100h
		mov	di, 9569h
		rep stosw
		retn
; ---------------------------------------------------------------------------

loc_10618:				; CODE XREF: sub_105F0+15j
		mov	dx, cx
		add	dx, di
		mov	si, di
		add	si, ax

loc_10620:				; CODE XREF: sub_105F0+5Dj
		mov	al, 3
		call	sub_107B3
		cmp	al, 7
		jnz	short loc_1063B
		mov	bx, ds:99E7h

loc_1062D:				; CODE XREF: sub_105F0+42j
		shl	bx, 1
		jnb	short loc_10634
		inc	ax
		jmp	short loc_1062D
; ---------------------------------------------------------------------------

loc_10634:				; CODE XREF: sub_105F0+3Fj
		push	ax
		sub	al, 6
		call	Decomp_GetBits
		pop	ax

loc_1063B:				; CODE XREF: sub_105F0+37j
		stosb
		cmp	di, dx
		jnz	short loc_1064B
		mov	al, 2
		call	sub_107B3
		mov	cx, ax
		xor	al, al
		rep stosb

loc_1064B:				; CODE XREF: sub_105F0+4Ej
		cmp	di, si
		jb	short loc_10620
		pop	si
		mov	bp, 9967h
		lea	cx, [bp+si]
		sub	cx, di
		xor	al, al
		rep stosb
		mov	ax, si
		mov	cx, 8
		mov	di, 9569h
		jmp	sub_106F6
sub_105F0	endp


; =============== S U B	R O U T	I N E =======================================


sub_10666	proc near		; CODE XREF: Decomp_GetCtrl+1Cp
		mov	al, 9
		call	sub_107B3
		cmp	ax, 1FEh
		jbe	short loc_10676
		mov	ax, -1
		jmp	ShowError
; ---------------------------------------------------------------------------

loc_10676:				; CODE XREF: sub_10666+8j
		mov	di, 9769h
		or	ax, ax
		jnz	short loc_10690
		mov	cx, 1FEh
		rep stosb
		mov	al, 9
		call	sub_107B3
		mov	cx, 1000h
		mov	di, 7569h
		rep stosw
		retn
; ---------------------------------------------------------------------------

loc_10690:				; CODE XREF: sub_10666+15j
		mov	dx, di
		add	dx, ax
		push	di

loc_10695:				; CODE XREF: sub_10666+79j
		mov	ax, ds:99E7h
		mov	bl, ah
		xor	bh, bh
		shl	bx, 1
		mov	bx, [bx+9569h]
		mov	cx, 13h
		call	sub_105B4
		push	bx
		mov	al, [bx+9967h]
		call	Decomp_GetBits
		pop	ax
		sub	ax, 2
		ja	short loc_106DC
		jnz	short loc_106C4
		mov	al, 9
		call	sub_107B3
		add	ax, 14h
		mov	cx, ax
		jmp	short loc_106D6
; ---------------------------------------------------------------------------

loc_106C4:				; CODE XREF: sub_10666+50j
		inc	ax
		jnz	short loc_106D3
		mov	al, 4
		call	sub_107B3
		add	ax, 3
		mov	cx, ax
		jmp	short loc_106D6
; ---------------------------------------------------------------------------

loc_106D3:				; CODE XREF: sub_10666+5Fj
		mov	cx, 1

loc_106D6:				; CODE XREF: sub_10666+5Cj
					; sub_10666+6Bj
		xor	al, al
		rep stosb
		jmp	short loc_106DD
; ---------------------------------------------------------------------------

loc_106DC:				; CODE XREF: sub_10666+4Ej
		stosb

loc_106DD:				; CODE XREF: sub_10666+74j
		cmp	di, dx
		jb	short loc_10695
		mov	cx, 9967h
		sub	cx, di
		xor	al, al
		rep stosb
		mov	ax, 1FEh
		pop	bp
		mov	cx, 0Ch
		mov	di, 7569h
		jmp	short sub_106F6
sub_10666	endp ; sp-analysis failed


; =============== S U B	R O U T	I N E =======================================


sub_106F6	proc near		; CODE XREF: sub_105F0+73j
					; DATA XREF: sub_10666+8Et
		mov	ds:99EDh, ax
		shl	ax, 1
		mov	ds:99EBh, ax
		mov	ds:99EFh, cx
		mov	ds:99F1h, di
		mov	al, 10h
		sub	al, cl
		mov	ds:99F3h, al
		mov	ax, 1
		shl	ax, cl
		mov	cx, ax
		xor	ax, ax
		rep stosw
		xor	si, si
		mov	bx, 8000h
		mov	dx, 1

loc_10720:				; CODE XREF: sub_106F6+A4j
		mov	di, bp
		mov	cx, ds:99EDh

loc_10726:				; CODE XREF: sub_106F6+9Fj
		mov	al, dl
		repne scasb
		jnz	short loc_10797
		mov	ax, di
		sub	ax, bp
		dec	ax
		push	cx
		push	di
		mov	cl, ds:99F3h
		mov	di, si
		shr	di, cl
		shl	di, 1
		add	di, ds:99F1h
		push	bx
		cmp	dx, ds:99EFh
		ja	short loc_10750
		shr	bx, cl
		mov	cx, bx
		rep stosw
		jmp	short loc_1078C
; ---------------------------------------------------------------------------

loc_10750:				; CODE XREF: sub_106F6+50j
		push	si
		mov	cx, ds:99EFh
		shl	si, cl
		neg	cx
		add	cx, dx

loc_1075B:				; CODE XREF: sub_106F6:loc_10787j
		cmp	word ptr [di], 0
		jnz	short loc_10777
		mov	bx, ds:99EBh
		mov	word ptr [bx+6D73h], 0
		mov	word ptr [bx+657Dh], 0
		mov	[di], bx
		add	word ptr ds:99EBh, 2

loc_10777:				; CODE XREF: sub_106F6+68j
		mov	di, [di]
		shl	si, 1
		jnb	short loc_10783
		add	di, 6D73h
		jmp	short loc_10787
; ---------------------------------------------------------------------------

loc_10783:				; CODE XREF: sub_106F6+85j
		add	di, 657Dh

loc_10787:				; CODE XREF: sub_106F6+8Bj
		loop	loc_1075B
		mov	[di], ax
		pop	si

loc_1078C:				; CODE XREF: sub_106F6+58j
		pop	bx
		pop	di
		pop	cx
		add	si, bx
		jb	short locret_1079C
		or	cx, cx
		jnz	short loc_10726

loc_10797:				; CODE XREF: sub_106F6+34j
		inc	dx
		shr	bx, 1
		jnb	short loc_10720

locret_1079C:				; CODE XREF: sub_106F6+9Bj
		retn
sub_106F6	endp

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR ReadArcFile_Cmp

rfa_cmp_end:				; CODE XREF: ReadArcFile_Cmp+B7j
					; ReadArcFile_Cmp+D2j ...
		call	Decomp_FlushBuf
		pop	dx
		pop	ax

loc_107A2:				; CODE XREF: ReadArcFile_Cmp+37Bj
		mov	ds:24DBh, ax
		pop	bp
		pop	di
		pop	si
		pop	cx
		pop	bx
		pop	es
		assume es:nothing
		pop	ds
		assume ds:nothing
		retn
; ---------------------------------------------------------------------------

loc_107AD:				; CODE XREF: ReadArcFile_Cmp+43j
		xor	dx, dx
		xor	ax, ax
		jmp	short loc_107A2
; END OF FUNCTION CHUNK	FOR ReadArcFile_Cmp

; =============== S U B	R O U T	I N E =======================================


sub_107B3	proc near		; CODE XREF: Decomp_GetCtrl+Ap
					; Decomp_GetCopyOfs+2Bp ...
		push	cx
		mov	cl, 10h
		sub	cl, al
		push	word ptr ds:99E7h
		call	Decomp_GetBits
		pop	ax
		shr	ax, cl
		pop	cx
		retn
sub_107B3	endp


; =============== S U B	R O U T	I N E =======================================


Decomp_GetBits	proc near		; CODE XREF: ReadArcFile_Cmp+A6p
					; Decomp_GetCtrl+47p ...
		push	cx
		push	dx
		mov	ch, al
		mov	cl, ds:99EAh
		mov	dx, ds:99E7h
		mov	al, ds:99E9h
		cmp	ch, cl
		jbe	short loc_1080A
		sub	ch, cl
		shl	dx, cl
		rol	al, cl
		add	dl, al
		mov	cl, 8

loc_107E1:				; CODE XREF: Decomp_GetBits+44j
		mov	bx, ds:6579h
		push	ds
		mov	ds, cs:word_112C8
		mov	al, [bx]
		pop	ds
		inc	bx
		cmp	bx, 2000h
		jnz	short loc_107FA
		call	Decomp_ReadFile
		xor	bx, bx

loc_107FA:				; CODE XREF: Decomp_GetBits+2Fj
		mov	ds:6579h, bx
		cmp	ch, cl
		jbe	short loc_1080A
		sub	ch, cl
		mov	dh, dl
		mov	dl, al
		jmp	short loc_107E1
; ---------------------------------------------------------------------------

loc_1080A:				; CODE XREF: Decomp_GetBits+11j
					; Decomp_GetBits+3Cj
		sub	cl, ch
		mov	ds:99EAh, cl
		mov	cl, ch
		xor	ah, ah
		shl	dx, cl
		shl	ax, cl
		add	dl, ah
		mov	ds:99E7h, dx
		mov	ds:99E9h, al
		pop	dx
		pop	cx
		retn
Decomp_GetBits	endp


; =============== S U B	R O U T	I N E =======================================


Decomp_ReadFile	proc near		; CODE XREF: ReadArcFile_Cmp+93p
					; Decomp_GetBits+31p
		push	ax
		push	di
		mov	word ptr ds:24D7h, 0 ; buffer pointer
		mov	ax, cs:word_112C8
		mov	ds:24D9h, ax	; buffer segment
		mov	word ptr ds:24DBh, 2000h ; bytes to read
		mov	di, ds:256Fh	; DI = offset of file name

loc_1083D:				; CODE XREF: Decomp_ReadFile+21j
		call	ReadFile
		jnb	short loc_10847
		call	HandleFileError
		jmp	short loc_1083D
; ---------------------------------------------------------------------------

loc_10847:				; CODE XREF: Decomp_ReadFile+1Cj
		mov	ax, ds:24DBh
		add	ds:24DDh, ax	; add number of	read bytes to seek offset
		adc	word ptr ds:24DFh, 0
		pop	di
		pop	ax
		retn
Decomp_ReadFile	endp


; =============== S U B	R O U T	I N E =======================================


Decomp_FlushBuf	proc near		; CODE XREF: ReadArcFile_Cmp+DBp
					; ReadArcFile_Cmp+113p	...
		or	di, di
		jz	short locret_10883
		push	es
		push	cx
		push	si
		push	di
		mov	si, 2579h	; 16 KiB buffer	for temporary output / memory
		mov	cx, di
		mov	di, ds:256Bh	; get actual destination buffer
		mov	es, word ptr ds:256Dh
		push	cx
		push	cx
		rep movsb		; copy from temp output	buffer to real destination
		pop	cx
		and	cx, 0Fh		; recalculate destination pointer + segment for	next flush
		add	ds:256Bh, cx
		pop	cx
		shr	cx, 4
		add	ds:256Dh, cx
		pop	di
		pop	si
		pop	cx
		pop	es

locret_10883:				; CODE XREF: Decomp_FlushBuf+2j
		retn
Decomp_FlushBuf	endp


; =============== S U B	R O U T	I N E =======================================


ReadFile	proc near		; CODE XREF: ReadArcFile_Raw:loc_10428p
					; ReadArcFile_Cmp:loc_104A5p ...
		push	ds
		push	es
		pusha
		call	SoundCallA
		push	seg seg001
		pop	ds
		assume ds:seg001
		cmp	cs:byte_112B9, 0
		jnz	short loc_108E1
		call	GetFileName
		mov	dx, 2455h
		mov	ax, 3D00h
		int	21h		; DOS -	2+ - OPEN DISK FILE WITH HANDLE
					; DS:DX	-> ASCIZ filename
					; AL = access mode
					; 0 - read
		jnb	short loc_108A6
		jmp	loc_10929
; ---------------------------------------------------------------------------

loc_108A6:				; CODE XREF: ReadFile+1Dj
		mov	ds:24D5h, ax	; file handle
		mov	dx, ds:24DDh
		mov	cx, ds:24DFh
		mov	bx, ds:24D5h
		mov	ax, 4200h
		int	21h		; DOS -	2+ - MOVE FILE READ/WRITE POINTER (LSEEK)
					; AL = method: offset from beginning of	file
		jb	short loc_10929
		mov	dx, ds:24D7h
		mov	cx, ds:24DBh
		mov	bx, ds:24D5h
		push	ds
		push	word ptr ds:24D9h
		pop	ds
		assume ds:nothing
		mov	ah, 3Fh
		int	21h		; DOS -	2+ - READ FROM FILE WITH HANDLE
					; BX = file handle, CX = number	of bytes to read
					; DS:DX	-> buffer
		pop	ds
		jb	short loc_10929
		mov	bx, ds:24D5h
		mov	ah, 3Eh
		int	21h		; DOS -	2+ - CLOSE A FILE WITH HANDLE
					; BX = file handle
		jb	short loc_10929
		jmp	short loc_10921
; ---------------------------------------------------------------------------

loc_108E1:				; CODE XREF: ReadFile+10j
		mov	si, 24E1h
		mov	ax, [di+2]
		mov	[si], ax
		mov	word ptr [si+2], ds
		mov	ax, ds:24D7h
		mov	[si+4],	ax
		mov	ax, ds:24D9h
		mov	[si+6],	ax
		mov	ax, ds:24DDh
		mov	[si+8],	ax
		mov	ax, ds:24DFh
		mov	[si+0Ah], ax
		mov	ax, ds:24DBh
		mov	[si+0Ch], ax
		mov	al, [di]
		mov	[si+0Eh], al
		mov	al, [di+1]
		mov	[si+0Fh], al
		push	ds
		pop	es
		mov	di, si
		mov	ah, 8
		int	40h		; Hard disk - Relocated	Floppy Handler (original INT 13h)
		or	ax, ax
		jnz	short loc_10929

loc_10921:				; CODE XREF: ReadFile+5Bj
		call	SoundCallB
		popa
		pop	es
		pop	ds
		clc
		retn
; ---------------------------------------------------------------------------

loc_10929:				; CODE XREF: ReadFile+1Fj ReadFile+36j ...
		call	SoundCallB
		popa
		pop	es
		pop	ds
		stc
		retn
ReadFile	endp


; =============== S U B	R O U T	I N E =======================================


SoundCallA	proc near		; CODE XREF: ReadFile+3p
		mov	bl, cs:MusicMode
		xor	bh, bh
		shl	bx, 1
		jmp	cs:off_1093F[bx]
; ---------------------------------------------------------------------------
off_1093F	dw offset locret_10945	; 0 ; DATA XREF: SoundCallA+9r
		dw offset loc_10946	; 1
		dw offset locret_10953	; 2
; ---------------------------------------------------------------------------

locret_10945:				; CODE XREF: SoundCallA+9j
					; DATA XREF: SoundCallA:off_1093Fo
		retn
; ---------------------------------------------------------------------------

loc_10946:				; CODE XREF: SoundCallA+9j
					; DATA XREF: SoundCallA:off_1093Fo
		cmp	cs:byte_112BB, 0
		jnz	short locret_10952
		mov	ah, 0Bh
		int	41h		; call FM driver

locret_10952:				; CODE XREF: SoundCallA+1Bj
		retn
; ---------------------------------------------------------------------------

locret_10953:				; CODE XREF: SoundCallA+9j
					; DATA XREF: SoundCallA:off_1093Fo
		retn
SoundCallA	endp


; =============== S U B	R O U T	I N E =======================================


SoundCallB	proc near		; CODE XREF: ReadFile:loc_10921p
					; ReadFile:loc_10929p
		mov	bl, cs:MusicMode
		xor	bh, bh
		shl	bx, 1
		jmp	cs:off_10962[bx]
; ---------------------------------------------------------------------------
off_10962	dw offset locret_10968	; 0 ; DATA XREF: SoundCallB+9r
		dw offset loc_10969	; 1
		dw offset locret_10976	; 2
; ---------------------------------------------------------------------------

locret_10968:				; CODE XREF: SoundCallB+9j
					; DATA XREF: SoundCallB:off_10962o
		retn
; ---------------------------------------------------------------------------

loc_10969:				; CODE XREF: SoundCallB+9j
					; DATA XREF: SoundCallB:off_10962o
		cmp	cs:byte_112BB, 0
		jnz	short locret_10975
		mov	ah, 0Ah
		int	41h		; call FM driver

locret_10975:				; CODE XREF: SoundCallB+1Bj
		retn
; ---------------------------------------------------------------------------

locret_10976:				; CODE XREF: SoundCallB+9j
					; DATA XREF: SoundCallB:off_10962o
		retn
SoundCallB	endp


; =============== S U B	R O U T	I N E =======================================


WriteFileA	proc near		; CODE XREF: sub_11363+27Cp
					; seg000:2650p
		push	ds		; AH = file archive ID
		push	es
		pusha
		push	seg seg001
		pop	ds
		assume ds:seg001
		push	cs:word_112CA
		pop	es
		mov	ds:24F1h, bp
		mov	ds:24F3h, bx
		mov	bp, ax
		and	bp, 0FFh
		shl	bp, 3
		mov	bl, ah
		xor	bh, bh
		shl	bx, 1
		add	bp, es:[bx]
		push	word ptr es:[bp+0]
		pop	word ptr ds:24F7h
		push	word ptr es:[bp+2]
		pop	word ptr ds:24F9h
		mov	dx, es:[bp+4]
		or	dx, dx
		jz	short loc_109CF
		mov	ds:24F5h, dx
		mov	di, 1F55h
		mov	cl, 4
		mov	al, ah
		mul	cl
		add	di, ax

loc_109C5:				; CODE XREF: WriteFileA+56j
		call	WriteFile
		jnb	short loc_109CF
		call	HandleFileError
		jmp	short loc_109C5
; ---------------------------------------------------------------------------

loc_109CF:				; CODE XREF: WriteFileA+3Dj
					; WriteFileA+51j
		popa
		pop	es
		pop	ds
		assume ds:nothing
		retn
WriteFileA	endp


; =============== S U B	R O U T	I N E =======================================


WriteFile	proc near		; CODE XREF: WriteFileA:loc_109C5p
		push	ds
		push	es
		pusha
		call	SoundCallC
		push	seg seg001
		pop	ds
		assume ds:seg001
		cmp	cs:byte_112B9, 0
		jnz	short loc_10A1B
		call	GetFileName
		mov	dx, 2455h
		xor	cx, cx
		mov	ah, 3Ch
		int	21h		; DOS -	2+ - CREATE A FILE WITH	HANDLE (CREAT)
					; CX = attributes for file
					; DS:DX	-> ASCIZ filename (may include drive and path)
		jb	short loc_10A63
		mov	ds:24D5h, ax
		mov	dx, ds:24F1h
		mov	cx, ds:24F5h
		mov	bx, ds:24D5h
		push	ds
		push	word ptr ds:24F3h
		pop	ds
		assume ds:nothing
		mov	ah, 40h
		int	21h		; DOS -	2+ - WRITE TO FILE WITH	HANDLE
					; BX = file handle, CX = number	of bytes to write, DS:DX -> buffer
		pop	ds
		jb	short loc_10A63
		mov	bx, ds:24D5h
		mov	ah, 3Eh
		int	21h		; DOS -	2+ - CLOSE A FILE WITH HANDLE
					; BX = file handle
		jb	short loc_10A63
		jmp	short loc_10A5B
; ---------------------------------------------------------------------------

loc_10A1B:				; CODE XREF: WriteFile+10j
		mov	si, 24FBh
		mov	ax, [di+2]
		mov	[si], ax
		mov	word ptr [si+2], ds
		mov	ax, ds:24F1h
		mov	[si+4],	ax
		mov	ax, ds:24F3h
		mov	[si+6],	ax
		mov	ax, ds:24F7h
		mov	[si+8],	ax
		mov	ax, ds:24F9h
		mov	[si+0Ah], ax
		mov	ax, ds:24F5h
		mov	[si+0Ch], ax
		mov	al, [di]
		mov	[si+0Eh], al
		mov	al, [di+1]
		mov	[si+10h], al
		push	ds
		pop	es
		mov	di, si
		mov	ah, 9
		int	40h		; Hard disk - Relocated	Floppy Handler (original INT 13h)
		or	ax, ax
		jnz	short loc_10A63

loc_10A5B:				; CODE XREF: WriteFile+46j
		call	SoundCallD
		popa
		pop	es
		pop	ds
		clc
		retn
; ---------------------------------------------------------------------------

loc_10A63:				; CODE XREF: WriteFile+1Ej
					; WriteFile+3Aj ...
		call	SoundCallD
		popa
		pop	es
		pop	ds
		stc
		retn
WriteFile	endp


; =============== S U B	R O U T	I N E =======================================


SoundCallC	proc near		; CODE XREF: WriteFile+3p
		mov	bl, cs:MusicMode
		xor	bh, bh
		shl	bx, 1
		jmp	cs:off_10A79[bx]
; ---------------------------------------------------------------------------
off_10A79	dw offset locret_10A7F	; 0 ; DATA XREF: SoundCallC+9r
		dw offset loc_10A80	; 1
		dw offset locret_10A8D	; 2
; ---------------------------------------------------------------------------

locret_10A7F:				; CODE XREF: SoundCallC+9j
					; DATA XREF: SoundCallC:off_10A79o
		retn
; ---------------------------------------------------------------------------

loc_10A80:				; CODE XREF: SoundCallC+9j
					; DATA XREF: SoundCallC:off_10A79o
		cmp	cs:byte_112BB, 0
		jnz	short locret_10A8C
		mov	ah, 0Bh
		int	41h		; call FM driver

locret_10A8C:				; CODE XREF: SoundCallC+1Bj
		retn
; ---------------------------------------------------------------------------

locret_10A8D:				; CODE XREF: SoundCallC+9j
					; DATA XREF: SoundCallC:off_10A79o
		retn
SoundCallC	endp


; =============== S U B	R O U T	I N E =======================================


SoundCallD	proc near		; CODE XREF: WriteFile:loc_10A5Bp
					; WriteFile:loc_10A63p
		mov	bl, cs:MusicMode
		xor	bh, bh
		shl	bx, 1
		jmp	cs:off_10A9C[bx]
; ---------------------------------------------------------------------------
off_10A9C	dw offset locret_10AA2	; 0 ; DATA XREF: SoundCallD+9r
		dw offset loc_10AA3	; 1
		dw offset locret_10AB0	; 2
; ---------------------------------------------------------------------------

locret_10AA2:				; CODE XREF: SoundCallD+9j
					; DATA XREF: SoundCallD:off_10A9Co
		retn
; ---------------------------------------------------------------------------

loc_10AA3:				; CODE XREF: SoundCallD+9j
					; DATA XREF: SoundCallD:off_10A9Co
		cmp	cs:byte_112BB, 0
		jnz	short locret_10AAF
		mov	ah, 0Ah
		int	41h		; call FM driver

locret_10AAF:				; CODE XREF: SoundCallD+1Bj
		retn
; ---------------------------------------------------------------------------

locret_10AB0:				; CODE XREF: SoundCallD+9j
					; DATA XREF: SoundCallD:off_10A9Co
		retn
SoundCallD	endp


; =============== S U B	R O U T	I N E =======================================


GetFileName	proc near		; CODE XREF: ReadFile+12p
					; WriteFile+12p
		push	ds
		push	es
		push	ax
		push	si
		push	di
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		mov	es, ax
		assume es:seg001
		push	word ptr [di+2]
		mov	di, 2455h
		mov	si, 23D5h

loc_10AC6:				; CODE XREF: GetFileName+1Bj
		lodsb
		or	al, al
		jz	short loc_10ACE
		stosb
		jmp	short loc_10AC6
; ---------------------------------------------------------------------------

loc_10ACE:				; CODE XREF: GetFileName+18j
		pop	si

loc_10ACF:				; CODE XREF: GetFileName+22j
		lodsb
		stosb
		or	al, al
		jnz	short loc_10ACF
		pop	di
		pop	si
		pop	ax
		pop	es
		assume es:nothing
		pop	ds
		assume ds:nothing
		retn
GetFileName	endp


; =============== S U B	R O U T	I N E =======================================


HandleFileError	proc near		; CODE XREF: ReadArcFile_Raw+53p
					; ReadArcFile_Cmp+74p ...
		push	ds
		push	es
		pusha
		push	seg seg001
		pop	ds
		assume ds:seg001
		push	seg seg001
		pop	es
		assume es:seg001
		mov	dl, [di+1]	; disk drive ID
		mov	dh, [di]	; disk ID
		mov	di, 250Bh
		mov	ax, 0F00h
		stosw
		mov	si, offset aDrive ; "ÉhÉâÉCÉu"
		mov	cx, 8
		rep movsb
		xor	al, al
		mov	ah, dl
		add	ax, 5082h	; Shift-JIS character: full-width '1'
		stosw
		mov	si, offset aToDisk ; "Ç…ÉfÉBÉXÉN"
		mov	cx, 10
		rep movsb
		xor	al, al
		mov	ah, dh
		add	ax, 6082h	; Shift-JIS character: full-width 'A'
		stosw
		mov	si, offset aPleaseInsert ; "Çì¸ÇÍÇƒâ∫Ç≥Ç¢ÅB"
		mov	cx, 16
		rep movsb
		mov	ax, 0FF00h
		stosw
		mov	al, ds:0D988h
		push	ax
		cmp	al, 0FFh
		jnz	short loc_10B29
		call	sub_14BE0

loc_10B29:				; CODE XREF: HandleFileError+49j
		mov	al, ds:1D24h
		push	ax
		mov	al, ds:1D23h
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	si, 250Bh
		call	sub_143B3
		mov	dh, 40h	; '@'
		mov	dl, 28h	; '('
		mov	ch, 0FFh
		mov	cl, 0FFh
		mov	bl, 14h
		mov	al, 2
		call	sub_14407

loc_10B47:				; CODE XREF: HandleFileError+71j
					; HandleFileError+79j
		call	sub_14C11
		test	al, 2
		jnz	short loc_10B47
		call	sub_10C85
		test	ax, 10h
		jnz	short loc_10B47

loc_10B56:				; CODE XREF: HandleFileError+8Aj
		call	sub_14C11
		test	al, 2
		jnz	short loc_10B67
		call	sub_10C85
		test	ax, 10h
		jnz	short loc_10B67
		jmp	short loc_10B56
; ---------------------------------------------------------------------------

loc_10B67:				; CODE XREF: HandleFileError+80j
					; HandleFileError+88j
		call	sub_148B0
		pop	ax
		mov	ds:1D24h, al
		out	0A6h, al	; Interrupt Controller #2, 8259A
		pop	ax
		cmp	al, 0FFh
		jnz	short loc_10B78
		call	sub_14BCA

loc_10B78:				; CODE XREF: HandleFileError+98j
		popa
		pop	es
		assume es:nothing
		pop	ds
		assume ds:nothing
		retn
HandleFileError	endp

; ---------------------------------------------------------------------------

loc_10B7C:				; DATA XREF: sub_1105E+8Ao
		sti
		cld
		push	ds
		push	es
		pusha
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		mov	es, ax
		assume es:seg001
		test	byte ptr ds:1D17h, 80h
		jnz	short loc_10BFA
		or	byte ptr ds:1D17h, 80h
		test	byte ptr ds:1D18h, 1
		jz	short loc_10BA0
		mov	al, ds:1D23h
		out	0A4h, al	; Interrupt Controller #2, 8259A

loc_10BA0:				; CODE XREF: seg000:0B99j
		test	byte ptr ds:1D18h, 10h
		jz	short loc_10BC8
		mov	si, 1D25h
		xor	ah, ah

loc_10BAC:				; CODE XREF: seg000:0BC6j
		mov	al, ah
		out	0A8h, al	; Interrupt Controller #2, 8259A
		out	5Fh, al
		lodsb
		out	0AEh, al	; Interrupt Controller #2, 8259A
		out	5Fh, al
		lodsb
		out	0ACh, al	; Interrupt Controller #2, 8259A
		out	5Fh, al
		lodsb
		out	0AAh, al	; Interrupt Controller #2, 8259A
		out	5Fh, al
		inc	ah
		cmp	ah, 10h
		jnz	short loc_10BAC

loc_10BC8:				; CODE XREF: seg000:0BA5j
		test	byte ptr ds:1D18h, 40h
		jz	short loc_10BD2
		call	sub_10D74

loc_10BD2:				; CODE XREF: seg000:0BCDj
		test	byte ptr ds:1D18h, 80h
		jz	short loc_10BDC
		call	sub_10D84

loc_10BDC:				; CODE XREF: seg000:0BD7j
		cmp	byte ptr ds:1D22h, 0FFh
		jz	short loc_10BF0
		xor	al, al
		sub	byte ptr ds:1D22h, 1
		adc	al, 6
		out	37h, al
		out	5Fh, al

loc_10BF0:				; CODE XREF: seg000:0BE1j
		mov	byte ptr ds:1D18h, 0
		and	byte ptr ds:1D17h, 7Fh

loc_10BFA:				; CODE XREF: seg000:0B8Dj
		cmp	cs:byte_112BE, 0
		jnz	short loc_10C06
		mov	ah, 0Fh
		int	42h		; call MIDI driver

loc_10C06:				; CODE XREF: seg000:0C00j
		add	word ptr ds:1D04h, 1
		adc	word ptr ds:1D06h, 0
		inc	word ptr ds:1D08h
		cli
		out	64h, al		; 8042 keyboard	controller command register.
		mov	al, 20h	; ' '
		out	0, al
		popa
		pop	es
		assume es:nothing
		pop	ds
		assume ds:nothing
		iret
; ---------------------------------------------------------------------------
		push	cx

loc_10C20:				; CODE XREF: seg000:0C23j
		call	sub_10C27
		loop	loc_10C20
		pop	cx
		retn

; =============== S U B	R O U T	I N E =======================================


sub_10C27	proc near		; CODE XREF: seg000:loc_10C20p
					; sub_11363+7Cp ...
		push	ax
		push	ds
		push	seg seg001
		pop	ds
		assume ds:seg001
		mov	ax, ds:1D04h

loc_10C30:				; CODE XREF: sub_10C27+Dj
		cmp	ax, ds:1D04h
		jz	short loc_10C30
		pop	ds
		assume ds:nothing
		pop	ax
		retn
sub_10C27	endp


; =============== S U B	R O U T	I N E =======================================


sub_10C39	proc near		; CODE XREF: LoadSaveGames+14p
					; sub_11363+35p ...
		push	ds
		push	seg seg001
		pop	ds
		assume ds:seg001
		and	byte ptr ds:1D17h, 7Fh

loc_10C43:				; CODE XREF: sub_10C39+Fj
		cmp	byte ptr ds:1D18h, 0
		jnz	short loc_10C43
		or	byte ptr ds:1D17h, 80h
		pop	ds
		assume ds:nothing
		retn
sub_10C39	endp

; ---------------------------------------------------------------------------

locret_10C51:				; DATA XREF: sub_1105E+E9o
		iret
; ---------------------------------------------------------------------------

locret_10C52:				; DATA XREF: sub_1105E+103o
		iret
; ---------------------------------------------------------------------------

loc_10C53:				; DATA XREF: sub_1105E+125o
		sti
		cld
		push	ds
		push	es
		push	bx
		push	cx
		push	dx
		push	si
		push	di
		push	bp
		pop	bp
		pop	di
		pop	si
		pop	dx
		pop	cx
		pop	bx
		pop	es
		pop	ds
		xor	ax, ax
		iret

; =============== S U B	R O U T	I N E =======================================


sub_10C68	proc near		; CODE XREF: sub_12C3A+256p
					; sub_14698+38p ...
		push	ax
		push	cx
		push	dx

loc_10C6B:				; CODE XREF: sub_10C68+8j
		call	sub_14C11
		test	al, 3
		jnz	short loc_10C6B
		pop	dx
		pop	cx
		pop	ax
		retn
sub_10C68	endp

; ---------------------------------------------------------------------------

loc_10C76:				; CODE XREF: seg000:0C7Bj
		call	sub_14C11
		test	al, 3
		jnz	short loc_10C76

loc_10C7D:				; CODE XREF: seg000:0C82j
		call	sub_14C11
		test	al, 3
		jz	short loc_10C7D
		retn

; =============== S U B	R O U T	I N E =======================================


sub_10C85	proc near		; CODE XREF: HandleFileError+73p
					; HandleFileError+82p ...
		push	ds
		push	es
		push	bx
		push	si
		push	seg seg001
		pop	ds
		assume ds:seg001
		xor	dx, dx
		mov	es, dx
		assume es:nothing
		mov	si, 128h

loc_10C94:				; CODE XREF: sub_10C85+2Fj
		lodsb
		cmp	al, 0FFh
		jz	short loc_10CB6
		mov	bl, al
		xor	bh, bh
		push	bx
		shr	bx, 4
		mov	al, es:[bx+52Ah]
		pop	bx
		and	bx, 7
		test	[bx+100h], al
		jz	short loc_10CB2
		or	dx, [si]

loc_10CB2:				; CODE XREF: sub_10C85+29j
		inc	si
		inc	si
		jmp	short loc_10C94
; ---------------------------------------------------------------------------

loc_10CB6:				; CODE XREF: sub_10C85+12j
		mov	bl, cs:MusicMode
		xor	bh, bh
		shl	bx, 1
		call	cs:off_10CED[bx]
		mov	ax, ds:1D1Eh
		mov	ds:1D1Ch, ax
		mov	ds:1D1Eh, dx
		xor	dx, ds:1D1Ch
		and	dx, ds:1D1Eh
		mov	ds:1D20h, dx
		mov	ax, ds:1D1Eh
		cmp	cs:byte_112B9, 0
		jz	short loc_10CE8
		and	ax, 3FFFh

loc_10CE8:				; CODE XREF: sub_10C85+5Ej
		pop	si
		pop	bx
		pop	es
		assume es:nothing
		pop	ds
		assume ds:nothing
		retn
sub_10C85	endp

; ---------------------------------------------------------------------------
off_10CED	dw offset sub_10CF3	; 0 ; DATA XREF: sub_10C85+3Ar
		dw offset sub_10D24	; 1
		dw offset sub_10D2D	; 2

; =============== S U B	R O U T	I N E =======================================


sub_10CF3	proc near		; CODE XREF: sub_10C85+3Ap
					; DATA XREF: seg000:off_10CEDo
		cmp	cs:byte_112C1, 0
		jz	short locret_10D23
		push	dx
		mov	ax, 7B8h
		call	WriteFM
		mov	ax, 0F8Fh
		call	WriteFM
		mov	ah, 0Eh
		call	ReadFM
		mov	bl, al
		mov	ax, 0FCFh
		call	WriteFM
		mov	ah, 0Eh
		call	ReadFM
		mov	bh, al
		pop	dx
		not	bx
		or	dl, bl
		or	dl, bh

locret_10D23:				; CODE XREF: sub_10CF3+6j
		retn
sub_10CF3	endp


; =============== S U B	R O U T	I N E =======================================


sub_10D24	proc near		; CODE XREF: sub_10C85+3Ap
					; DATA XREF: seg000:off_10CEDo
		mov	ah, 13h
		int	41h		; call FM driver
		or	dl, al
		or	dl, ah
		retn
sub_10D24	endp


; =============== S U B	R O U T	I N E =======================================


sub_10D2D	proc near		; CODE XREF: sub_10C85+3Ap
					; DATA XREF: seg000:off_10CEDo
		mov	ah, 13h
		int	42h		; call MIDI driver
		or	dl, al
		or	dl, ah
		retn
sub_10D2D	endp


; =============== S U B	R O U T	I N E =======================================


sub_10D36	proc near		; CODE XREF: sub_10D54+1p seg000:0D65p
		push	ax

loc_10D37:				; CODE XREF: sub_10D36+Bj
		in	al, 60h		; 8042 keyboard	controller data	register
		out	5Fh, al
		out	5Fh, al
		out	5Fh, al
		test	al, 4
		jz	short loc_10D37
		pop	ax
		retn
sub_10D36	endp


; =============== S U B	R O U T	I N E =======================================


sub_10D45	proc near		; CODE XREF: sub_10D74+1p sub_10D84+1p ...
		push	ax

loc_10D46:				; CODE XREF: sub_10D45+Bj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		out	5Fh, al
		out	5Fh, al
		out	5Fh, al
		test	al, 4
		jz	short loc_10D46
		pop	ax
		retn
sub_10D45	endp


; =============== S U B	R O U T	I N E =======================================


sub_10D54	proc near		; CODE XREF: sub_1105E+57p
					; sub_1119A+2Dp
		push	ax
		call	sub_10D36
		mov	al, 0Fh
		out	62h, al		; PC/XT	PPI port C. Bits:
					; 0-3: values of DIP switches
					; 5: 1=Timer 2 channel out
					; 6: 1=I/O channel check
					; 7: 1=RAM parity check	error occurred.
		out	5Fh, al
		out	5Fh, al
		out	5Fh, al
		pop	ax
		retn
sub_10D54	endp

; ---------------------------------------------------------------------------
		push	ax
		call	sub_10D36
		mov	al, 0Eh
		out	62h, al		; PC/XT	PPI port C. Bits:
					; 0-3: values of DIP switches
					; 5: 1=Timer 2 channel out
					; 6: 1=I/O channel check
					; 7: 1=RAM parity check	error occurred.
		out	5Fh, al
		out	5Fh, al
		out	5Fh, al
		pop	ax
		retn

; =============== S U B	R O U T	I N E =======================================


sub_10D74	proc near		; CODE XREF: seg000:0BCFp
					; sub_1105E+C2p ...
		push	ax
		call	sub_10D45
		mov	al, 0Fh
		out	0A2h, al	; Interrupt Controller #2, 8259A
		out	5Fh, al
		out	5Fh, al
		out	5Fh, al
		pop	ax
		retn
sub_10D74	endp


; =============== S U B	R O U T	I N E =======================================


sub_10D84	proc near		; CODE XREF: seg000:0BD9p
					; sub_1105E+5Ap
		push	ax
		call	sub_10D45
		mov	al, 0Eh
		out	0A2h, al	; Interrupt Controller #2, 8259A
		out	5Fh, al
		out	5Fh, al
		out	5Fh, al
		pop	ax
		retn
sub_10D84	endp


; =============== S U B	R O U T	I N E =======================================


sub_10D94	proc near		; CODE XREF: sub_1119A+30p
		push	ax
		mov	ah, 11h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		pop	ax
		retn
sub_10D94	endp


; =============== S U B	R O U T	I N E =======================================


sub_10D9B	proc near		; CODE XREF: sub_1105E:loc_11079p
		push	ax
		mov	ah, 12h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		pop	ax
		retn
sub_10D9B	endp


; =============== S U B	R O U T	I N E =======================================


sub_10DA2	proc near		; CODE XREF: start+Dp
		mov	cs:word_112C4, 3C00h
		mov	cs:word_112C6, 4800h
		mov	cs:word_112C8, 4A00h
		mov	cs:word_112CA, 4C00h
		mov	cs:word_112CC, 5000h
		mov	cs:word_112CE, 6000h
		mov	cs:word_112D0, 8000h
		mov	cs:word_112D2, 8800h
		mov	cs:word_112D4, 9000h
		mov	cs:word_112D6, 9800h
		retn
sub_10DA2	endp


; =============== S U B	R O U T	I N E =======================================


sub_10DE9	proc near		; CODE XREF: start+18p

; FUNCTION CHUNK AT 120A SIZE 00000025 BYTES

		mov	ah, 30h
		int	21h		; DOS -	GET DOS	VERSION
					; Return: AL = major version number (00h for DOS 1.x)
		xchg	al, ah
		cmp	ax, 20Ah
		jnb	short loc_10DFA
		mov	ax, 0
		jmp	ShowError
; ---------------------------------------------------------------------------

loc_10DFA:				; CODE XREF: sub_10DE9+9j
		mov	ah, 62h
		int	21h		; DOS -	3+ - GET PSP ADDRESS
		mov	es, bx
		mov	bx, 0FFFFh
		mov	ah, 4Ah
		int	21h		; DOS -	2+ - ADJUST MEMORY BLOCK SIZE (SETBLOCK)
					; ES = segment address of block	to change
					; BX = new size	in paragraphs
		jnb	short loc_10E0E
		cmp	ax, 8
		jz	short loc_10E14

loc_10E0E:				; CODE XREF: sub_10DE9+1Ej
		mov	ax, 2
		jmp	ShowError
; ---------------------------------------------------------------------------

loc_10E14:				; CODE XREF: sub_10DE9+23j
		mov	ax, cs
		mov	bx, seg	seg003
		sub	bx, ax
		add	bx, 10h
		mov	ah, 4Ah
		int	21h		; DOS -	2+ - ADJUST MEMORY BLOCK SIZE (SETBLOCK)
					; ES = segment address of block	to change
					; BX = new size	in paragraphs
		jnb	short loc_10E2A
		mov	ax, 2
		jmp	ShowError
; ---------------------------------------------------------------------------

loc_10E2A:				; CODE XREF: sub_10DE9+39j
		mov	cx, 0C00h
		call	malloc
		mov	cs:word_112C4, ax
		mov	cx, 200h
		call	malloc
		mov	cs:word_112C6, ax
		mov	cx, 200h
		call	malloc
		mov	cs:word_112C8, ax
		mov	cx, 400h
		call	malloc
		mov	cs:word_112CA, ax
		mov	cx, 1000h
		call	malloc
		mov	cs:word_112CC, ax
		mov	cx, 2000h
		call	malloc
		mov	cs:word_112CE, ax
		mov	cx, 800h
		call	malloc
		mov	cs:word_112D0, ax
		mov	cx, 800h
		call	malloc
		mov	cs:word_112D2, ax
		mov	cx, 800h
		call	malloc
		mov	cs:word_112D4, ax
		mov	cx, 800h
		call	malloc
		mov	cs:word_112D6, ax
		mov	ah, 62h
		int	21h		; DOS -	3+ - GET PSP ADDRESS
		mov	ds, bx
		mov	si, 80h
		push	seg seg001
		pop	es
		assume es:seg001
		mov	di, 23D5h
		lodsb
		mov	cl, al

loc_10EA1:				; CODE XREF: sub_10DE9+BFj
					; sub_10DE9+C2j
		dec	cl
		js	short loc_10EAD
		lodsb
		cmp	al, 20h
		jz	short loc_10EA1
		stosb
		jmp	short loc_10EA1
; ---------------------------------------------------------------------------

loc_10EAD:				; CODE XREF: sub_10DE9+BAj
		xor	al, al
		stosb
		retn
sub_10DE9	endp


; =============== S U B	R O U T	I N E =======================================


malloc		proc near		; CODE XREF: sub_10DE9+44p
					; sub_10DE9+4Ep ...

; FUNCTION CHUNK AT 122F SIZE 00000032 BYTES

		mov	bx, cx
		mov	ah, 48h
		int	21h		; DOS -	2+ - ALLOCATE MEMORY
					; BX = number of 16-byte paragraphs desired
		jnb	short loc_10EBC
		jmp	loc_1122F
; ---------------------------------------------------------------------------

loc_10EBC:				; CODE XREF: malloc+6j
		shl	cx, 3
		mov	es, ax
		assume es:nothing
		xor	di, di
		xor	ax, ax
		rep stosw
		mov	ax, es
		retn
malloc		endp


; =============== S U B	R O U T	I N E =======================================


sub_10ECA	proc near		; CODE XREF: start+21p
		push	seg seg001
		pop	ds
		assume ds:seg001
		mov	bx, cs:word_112C6
		xor	bp, bp
		mov	ax, 200h
		call	ReadArcFile_Cmp
		call	LoadPalettes
		call	CheckFMChip
		call	ReadMIDIPort
		call	sub_10C85
		retn
sub_10ECA	endp


; =============== S U B	R O U T	I N E =======================================


CheckFMChip	proc near		; CODE XREF: sub_10ECA+14p
		push	ax
		push	dx
		mov	dx, 288h
		call	CheckFMPort
		jnb	short loc_10F02
		mov	dx, 88h
		call	CheckFMPort
		jnb	short loc_10F02
		mov	dx, 188h
		call	CheckFMPort
		jb	short loc_10F2D

loc_10F02:				; CODE XREF: CheckFMChip+8j
					; CheckFMChip+10j
		mov	ah, 0FFh
		call	ReadFM
		cmp	al, 1
		jnz	short loc_10F29
		push	es
		mov	ax, 0FD80h
		mov	es, ax
		assume es:nothing
		mov	ax, es:2
		mov	dl, es:4
		pop	es
		assume es:nothing
		cmp	ax, 2A27h
		jnz	short loc_10F25
		cmp	dl, 5
		jbe	short loc_10F29

loc_10F25:				; CODE XREF: CheckFMChip+36j
		mov	al, 81h
		jmp	short loc_10F2F
; ---------------------------------------------------------------------------

loc_10F29:				; CODE XREF: CheckFMChip+21j
					; CheckFMChip+3Bj
		mov	al, 80h
		jmp	short loc_10F2F
; ---------------------------------------------------------------------------

loc_10F2D:				; CODE XREF: CheckFMChip+18j
		xor	al, al

loc_10F2F:				; CODE XREF: CheckFMChip+3Fj
					; CheckFMChip+43j
		mov	cs:byte_112C1, al
		pop	dx
		pop	ax
		retn
CheckFMChip	endp


; =============== S U B	R O U T	I N E =======================================


CheckFMPort	proc near		; CODE XREF: CheckFMChip+5p
					; CheckFMChip+Dp ...
		in	al, dx
		cmp	al, 0FFh
		jz	short loc_10F42
		mov	cs:FMPort, dx
		clc
		retn
; ---------------------------------------------------------------------------

loc_10F42:				; CODE XREF: CheckFMPort+3j
		stc
		retn
CheckFMPort	endp


; =============== S U B	R O U T	I N E =======================================


ReadFM		proc near		; CODE XREF: sub_10CF3+17p
					; sub_10CF3+24p ...
		mov	dx, cs:FMPort
		mov	al, ah
		out	dx, al
		out	5Fh, al
		out	5Fh, al
		out	5Fh, al
		out	5Fh, al
		out	5Fh, al
		out	5Fh, al
		inc	dx
		inc	dx
		in	al, dx
		retn
ReadFM		endp


; =============== S U B	R O U T	I N E =======================================


WriteFM		proc near		; CODE XREF: sub_10CF3+Cp
					; sub_10CF3+12p ...
		mov	dx, cs:FMPort
		xchg	al, ah
		out	dx, al
		out	5Fh, al
		out	5Fh, al
		out	5Fh, al
		out	5Fh, al
		out	5Fh, al
		out	5Fh, al
		xchg	al, ah
		inc	dx
		inc	dx
		out	dx, al
		retn
WriteFM		endp


; =============== S U B	R O U T	I N E =======================================


ReadMIDIPort	proc near		; CODE XREF: sub_10ECA+17p
		push	ax
		push	dx
		mov	dx, 0E0D0h
		in	al, dx
		mov	ah, al
		mov	dx, 0E0D2h
		in	al, dx
		cmp	ax, 0FFFFh
		jz	short loc_10F90
		mov	cs:MIDIEnable, 80h
		pop	dx
		pop	ax
		retn
; ---------------------------------------------------------------------------

loc_10F90:				; CODE XREF: ReadMIDIPort+Fj
		mov	cs:MIDIEnable, 0
		pop	dx
		pop	ax
		retn
ReadMIDIPort	endp


; =============== S U B	R O U T	I N E =======================================


LoadIndexFiles	proc near		; CODE XREF: start:loc_1001Bp
		mov	ax, seg	seg001
		mov	ds, ax
		mov	es, ax
		assume es:seg001
		mov	word ptr ds:24D7h, 1F55h ; buffer pointer
		mov	word ptr ds:24D9h, seg seg001 ;	buffer segment
		mov	word ptr ds:24DBh, 480h	; bytes	to read
		mov	word ptr ds:24DDh, 0 ; read offset (low)
		mov	word ptr ds:24DFh, 0 ; read offset (high)
		mov	di, offset filePath_TWDIR
		call	ReadFile	; load TWDIR.DIR
		jnb	short loc_10FCC
		mov	ax, 1
		jmp	ShowError
; ---------------------------------------------------------------------------

loc_10FCC:				; CODE XREF: LoadIndexFiles+2Bj
		mov	di, 1F55h
		mov	cx, 20h

loc_10FD2:				; CODE XREF: LoadIndexFiles+41j
		add	word ptr [di+2], 1F55h ; convert file offsets to RAM pointers
		add	di, 4
		loop	loc_10FD2
		mov	word ptr ds:24D7h, 0 ; buffer pointer
		mov	ax, cs:word_112CA
		mov	ds:24D9h, ax	; buffer segment
		mov	word ptr ds:24DBh, 4000h ; bytes to read
		mov	word ptr ds:24DDh, 0 ; read offset (low)
		mov	word ptr ds:24DFh, 0 ; read offset (high)
		mov	di, offset filePath_HEADER
		call	ReadFile	; load HEADER.DAT
		jnb	short locret_11009
		mov	ax, 1
		jmp	ShowError
; ---------------------------------------------------------------------------

locret_11009:				; CODE XREF: LoadIndexFiles+68j
		retn
LoadIndexFiles	endp


; =============== S U B	R O U T	I N E =======================================


sub_1100A	proc near		; CODE XREF: sub_1105E+BCp
					; sub_1119A+24p
		push	es
		push	ax
		push	cx
		push	di
		mov	ax, 0A000h
		mov	es, ax
		assume es:nothing
		xor	di, di
		xor	ax, ax
		mov	cx, 1000h

loc_1101A:				; CODE XREF: sub_1100A+17j
		mov	byte ptr es:[di+2000h],	0E1h ; '·'
		stosw
		loop	loc_1101A
		pop	di
		pop	cx
		pop	ax
		pop	es
		assume es:nothing
		retn
sub_1100A	endp


; =============== S U B	R O U T	I N E =======================================


sub_11028	proc near		; CODE XREF: sub_1105E+BFp
					; sub_1119A+27p
		push	es
		push	ax
		push	cx
		push	di
		mov	al, 80h	; 'Ä'
		out	7Ch, al
		xor	al, al
		out	7Eh, al
		out	7Eh, al
		out	7Eh, al
		out	7Eh, al
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		xor	di, di
		mov	cx, 4000h
		rep stosw
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		xor	di, di
		mov	cx, 4000h
		rep stosw
		mov	al, 0
		out	7Ch, al
		pop	di
		pop	cx
		pop	ax
		pop	es
		assume es:nothing
		retn
sub_11028	endp


; =============== S U B	R O U T	I N E =======================================


sub_1105E	proc near		; CODE XREF: start+1Ep
		pushf
		cli
		push	ds
		push	es
		pusha
		mov	ax, seg	seg001
		mov	ds, ax
		mov	es, ax
		assume es:seg001
		cmp	cs:byte_112B9, 0
		jnz	short loc_11079
		mov	dx, offset a1h	; "\x1B[>1h$"
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"

loc_11079:				; CODE XREF: sub_1105E+12j
		call	sub_10D9B
		mov	al, 1
		out	68h, al
		out	5Fh, al
		mov	al, 2
		out	68h, al
		out	5Fh, al
		mov	al, 4
		out	68h, al
		out	5Fh, al
		mov	al, 7
		out	68h, al
		out	5Fh, al
		mov	al, 8
		out	68h, al
		out	5Fh, al
		mov	al, 0Ah
		out	68h, al
		out	5Fh, al
		call	sub_10D45
		mov	al, 4Bh	; 'K'
		out	0A2h, al	; Interrupt Controller #2, 8259A
		out	5Fh, al
		mov	al, 0
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1
		out	5Fh, al
		mov	al, 1
		out	6Ah, al
		out	5Fh, al
		call	sub_10D54
		call	sub_10D84
		xor	al, al
		mov	ds:1D23h, al
		out	0A4h, al	; Interrupt Controller #2, 8259A
		mov	ds:1D24h, al
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	si, offset byte_152D0
		mov	di, 1D25h
		mov	cx, 30h	; '0'
		rep movsb
		push	seg seg001
		pop	ds
		xor	ax, ax
		mov	es, ax
		assume es:nothing
		mov	ax, es:28h
		mov	ds:1D00h, ax
		mov	ax, es:2Ah
		mov	ds:1D02h, ax
		mov	word ptr es:28h, offset	loc_10B7C
		mov	word ptr es:2Ah, cs
		mov	byte ptr ds:1D17h, 0
		mov	byte ptr ds:1D18h, 11h
		mov	word ptr ds:1D04h, 0
		mov	word ptr ds:1D06h, 0
		mov	byte ptr ds:1D22h, 0FFh
		in	al, 2		; DMA controller, 8237A-5.
					; channel 1 current address
		mov	ds:1D16h, al
		and	al, 0FBh
		out	2, al		; DMA controller, 8237A-5.
					; channel 1 base address
					; (also	sets current address)
		out	64h, al		; 8042 keyboard	controller command register.
		call	sub_1100A
		call	sub_11028
		call	sub_10D74
		mov	ax, 208h
		xor	cx, cx
		mov	dx, 1Eh
		call	LoadGD1_0708
		call	sub_14AAE
		push	seg seg001
		pop	ds
		xor	ax, ax
		mov	es, ax
		mov	ax, es:14h
		mov	ds:1D0Ah, ax
		mov	ax, es:16h
		mov	ds:1D0Ch, ax
		mov	word ptr es:14h, offset	locret_10C51
		mov	word ptr es:16h, cs
		mov	ax, es:18h
		mov	ds:1D0Eh, ax
		mov	ax, es:1Ah
		mov	ds:1D10h, ax
		mov	word ptr es:18h, offset	locret_10C52
		mov	word ptr es:1Ah, cs
		cmp	cs:byte_112B9, 0
		jnz	short loc_1118F
		mov	ax, es:90h
		mov	ds:1D12h, ax
		mov	ax, es:92h
		mov	ds:1D14h, ax
		mov	word ptr es:90h, offset	loc_10C53
		mov	word ptr es:92h, cs

loc_1118F:				; CODE XREF: sub_1105E+115j
		or	byte ptr es:500h, 20h
		popa
		pop	es
		assume es:nothing
		pop	ds
		assume ds:nothing
		popf
		retn
sub_1105E	endp


; =============== S U B	R O U T	I N E =======================================


sub_1119A	proc near		; CODE XREF: start+74p
		pushf
		cli
		push	ds
		push	es
		pusha
		cld
		push	seg seg001
		pop	ds
		assume ds:seg001
		xor	ax, ax
		mov	es, ax
		assume es:nothing
		call	sub_14B84
		mov	ax, ds:1D00h
		mov	es:28h,	ax
		mov	ax, ds:1D02h
		mov	es:2Ah,	ax
		mov	al, ds:1D16h
		out	2, al		; DMA controller, 8237A-5.
					; channel 1 base address
					; (also	sets current address)
		call	sub_1100A
		call	sub_11028
		call	sub_10D74
		call	sub_10D54
		call	sub_10D94
		mov	ax, ds:1D0Ah
		mov	es:14h,	ax
		mov	ax, ds:1D0Ch
		mov	es:16h,	ax
		mov	ax, ds:1D0Eh
		mov	es:18h,	ax
		mov	ax, ds:1D10h
		mov	es:1Ah,	ax
		cmp	cs:byte_112B9, 0
		jnz	short loc_111FF
		mov	ax, ds:1D12h
		mov	es:90h,	ax
		mov	ax, ds:1D14h
		mov	es:92h,	ax

loc_111FF:				; CODE XREF: sub_1119A+55j
		and	byte ptr es:500h, 0DFh
		popa
		pop	es
		assume es:nothing
		pop	ds
		assume ds:nothing
		popf
		retn
sub_1119A	endp

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_10DE9

ShowError:				; CODE XREF: sub_105F0+Dj sub_10666+Dj ...
		or	ax, ax

loc_1120C:				; CODE XREF: sub_10DE9:loc_1120Cj
		js	short loc_1120C	; freeze on negative error codes?
		push	ax
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		mov	es, ax
		assume es:seg001
		pop	cx		; get number of	error string to	print
		mov	di, offset aNeedsMSDOSv21 ; "ÇlÇrÅ|ÇcÇnÇrÅ@ÇuÇÖÇíÇQÅDÇPà»è„ÇégópÇµÇ"...
		mov	al, '$'

loc_1121C:				; CODE XREF: sub_10DE9+439j
		dec	cx
		js	short loc_11224

loc_1121F:				; CODE XREF: sub_10DE9+437j
		scasb			; skip string
		jnz	short loc_1121F
		jmp	short loc_1121C
; ---------------------------------------------------------------------------

loc_11224:				; CODE XREF: sub_10DE9+434j
		mov	dx, di
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		mov	ax, 4C01h
		int	21h		; DOS -	2+ - QUIT WITH EXIT CODE (EXIT)
; END OF FUNCTION CHUNK	FOR sub_10DE9	; AL = exit code
; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR malloc

loc_1122F:				; CODE XREF: malloc+8j
		mov	ax, seg	seg001
		mov	ds, ax
		mov	es, ax
		mov	dx, offset aNotEnoughMem ; "ÉÅÉÇÉäÅ[Ç™ïsë´ÇµÇƒÇ¢Ç‹Ç∑ÅBé¿çsÇ∑ÇÈÇ…ÇÕÅ"...
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		mov	ax, seg	seg003
		mov	dx, cs
		sub	ax, dx
		add	ax, 63FBh
		add	ax, 3Fh
		shr	ax, 6
		xor	dx, dx
		mov	cx, 3
		call	ShowNumber
		mov	dx, offset aNeedsKBofMem ; "ÇãÇÇÇÃÉÅÉÇÉäÅ[Ç™ïKóvÇ≈Ç∑ÅB$"
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		mov	ax, 4C01h
		int	21h		; DOS -	2+ - QUIT WITH EXIT CODE (EXIT)
; END OF FUNCTION CHUNK	FOR malloc	; AL = exit code
; ---------------------------------------------------------------------------
		retn

; =============== S U B	R O U T	I N E =======================================


ShowNumber	proc near		; CODE XREF: malloc+3A1p
		pusha
		push	cx
		mov	di, offset byte_11293

loc_11267:				; CODE XREF: ShowNumber+1Fj
		push	cx
		push	ax
		push	dx
		mov	cx, 10
		call	DivMod
		pop	bp
		pop	bx
		push	dx
		push	ax
		mul	cx
		sub	bx, ax
		sbb	bp, dx
		mov	cs:[di], bl
		inc	di
		pop	ax
		pop	dx
		pop	cx
		loop	loc_11267
		pop	cx

loc_11284:				; CODE XREF: ShowNumber+2Dj
		dec	di
		mov	dl, cs:[di]
		add	dl, '0'
		mov	ah, 2
		int	21h		; DOS -	DISPLAY	OUTPUT
					; DL = character to send to standard output
		loop	loc_11284
		popa
		retn
ShowNumber	endp

; ---------------------------------------------------------------------------
byte_11293	db 10h dup(0)		; DATA XREF: ShowNumber+2o

; =============== S U B	R O U T	I N E =======================================


DivMod		proc near		; CODE XREF: ShowNumber+Bp
		push	bx
		push	ax
		push	dx
		mov	ax, dx
		cwd
		idiv	cx
		imul	cx
		mov	bx, ax
		pop	dx
		pop	ax
		sub	dx, bx
		idiv	cx
		mov	dx, bx
		pop	bx
		retn
DivMod		endp

; ---------------------------------------------------------------------------
byte_112B9	db 0			; DATA XREF: start+7w start:loc_10012w ...
byte_112BA	db 0			; DATA XREF: sub_11363r
					; sub_11363:loc_11384w
byte_112BB	db 0FFh			; DATA XREF: sub_1023D+5w sub_1024A+5w ...
MusicMode	db 0			; DATA XREF: LoadPlayBGM+1r StopBGM+1r ...
byte_112BD	db 0			; DATA XREF: LoadPlayBGM_MIDIr
					; LoadPlayBGM_MIDI+3Ar	...
byte_112BE	db 0FFh			; DATA XREF: seg000:03A7w sub_103CD+1w ...
FMPort		dw 0			; DATA XREF: CheckFMPort+5w ReadFMr ...
byte_112C1	db 0			; DATA XREF: sub_10CF3r
					; CheckFMChip:loc_10F2Fw ...
MIDIEnable	db 0			; DATA XREF: ReadMIDIPort+11w
					; ReadMIDIPort:loc_10F90w ...
byte_112C3	db 0			; DATA XREF: sub_128E0+92w
					; sub_128E0+A6w ...
word_112C4	dw 0			; DATA XREF: LoadSndDrv_FM+Cr
					; LoadSndDrv_MIDI+Cr ...
word_112C6	dw 0			; DATA XREF: sub_10DA2+7w
					; sub_10DE9+51w ...
word_112C8	dw 0			; DATA XREF: Decomp_GetBits+22r
					; Decomp_ReadFile+8r ...
word_112CA	dw 0			; DATA XREF: ReadArcFile_Raw+7r
					; ReadArcFile_Cmp+Br ...
word_112CC	dw 0			; DATA XREF: sub_10DA2+1Cw
					; sub_10DE9+6Fw ...
word_112CE	dw 0			; DATA XREF: sub_10DA2+23w
					; sub_10DE9+79w ...
word_112D0	dw 0			; DATA XREF: sub_10DA2+2Aw
					; sub_10DE9+83w ...
word_112D2	dw 0			; DATA XREF: sub_10DA2+31w
					; sub_10DE9+8Dw ...
word_112D4	dw 0			; DATA XREF: sub_10DA2+38w
					; sub_10DE9+97w ...
word_112D6	dw 0			; DATA XREF: sub_10DA2+3Fw
					; sub_10DE9+A1w ...

; =============== S U B	R O U T	I N E =======================================


LoadSaveGames	proc near		; CODE XREF: start+4Fp
					; DATA XREF: seg000:off_10089o
		mov	ax, seg	seg001
		mov	ds, ax
		xor	al, al
		mov	ds:1D23h, al
		mov	ds:1D24h, al
		out	0A6h, al	; Interrupt Controller #2, 8259A
		or	byte ptr ds:1D18h, 1
		call	sub_10C39
		mov	ax, seg	seg001
		mov	ds, ax
		push	cs:word_112CC
		pop	es
		assume es:nothing
		mov	di, 4200h
		mov	cx, 40h	; '@'
		xor	ax, ax
		rep stosw
		mov	bx, es
		xor	bp, bp
		mov	byte ptr ds:0A4F6h, 0
		mov	word ptr ds:0A4F7h, 0
		mov	ax, 1000h	; save games are stored	in archived 10h..15h (TWSAVE0..5)
		mov	cx, 6

loc_11319:				; CODE XREF: LoadSaveGames+83j
		push	ax
		push	cx
		call	ReadArcFile_Raw
		test	byte ptr es:[bp+7Fh], 80h
		jz	short loc_1132A
		mov	byte ptr ds:0A4F6h, 0FFh

loc_1132A:				; CODE XREF: LoadSaveGames+4Bj
		lea	si, [bp+80h]
		mov	di, 4200h
		mov	cx, 40h	; '@'

loc_11334:				; CODE XREF: LoadSaveGames+63j
		lods	word ptr es:[si]
		or	es:[di], ax
		inc	di
		inc	di
		loop	loc_11334
		xor	ah, ah
		mov	cx, 0B00h

loc_11342:				; CODE XREF: LoadSaveGames+71j
		mov	al, es:[bp+0]
		inc	bp
		or	ah, al
		loop	loc_11342
		or	ah, ah
		jnz	short loc_11352
		clc
		jmp	short loc_11353
; ---------------------------------------------------------------------------

loc_11352:				; CODE XREF: LoadSaveGames+75j
		stc

loc_11353:				; CODE XREF: LoadSaveGames+78j
		rcr	word ptr ds:0A4F7h, 1
		pop	cx
		pop	ax
		inc	ah
		loop	loc_11319
		shr	word ptr ds:0A4F7h, 0Ah
		retn
LoadSaveGames	endp


; =============== S U B	R O U T	I N E =======================================


sub_11363	proc near		; CODE XREF: start+4Fp	start+62p
					; DATA XREF: ...
		cmp	cs:byte_112BA, 0
		jz	short loc_11384
		call	StopBGM
		xor	di, di
		mov	dx, 190h
		mov	cx, 50h	; 'P'
		mov	bx, 2
		mov	al, 3
		call	sub_130DE
		call	sub_1174B
		jmp	loc_114DD
; ---------------------------------------------------------------------------

loc_11384:				; CODE XREF: sub_11363+6j
		mov	cs:byte_112BA, 0FFh
		mov	ax, 6
		mov	bp, 0FFFFh
		call	sub_14237
		or	byte ptr ds:1D18h, 10h
		call	sub_10C39
		cmp	word ptr ds:0A4F7h, 0
		jz	short loc_11404
		xor	di, di
		xor	dh, dh
		mov	dl, 0
		mov	ax, 204h
		call	LoadGraphicsFile
		mov	bp, 0

loc_113B1:				; CODE XREF: sub_11363+72j
		call	sub_1172F
		jb	short loc_113E5
		push	bp
		mov	ax, bp
		mov	bx, 6
		mov	dx, 4
		mov	bp, 0FFFFh
		call	sub_142CB
		or	byte ptr ds:1D18h, 10h
		call	sub_10C39
		pop	bp
		add	bp, 4
		cmp	bp, 100h
		jbe	short loc_113B1
		mov	bp, 78h	; 'x'

loc_113DA:				; CODE XREF: sub_11363+80j
		call	sub_1172F
		jb	short loc_113E5
		call	sub_10C27
		dec	bp
		jnz	short loc_113DA

loc_113E5:				; CODE XREF: sub_11363+51j
					; sub_11363+7Aj
		mov	di, 1D25h
		xor	ax, ax
		stosw
		stosb
		or	byte ptr ds:1D18h, 10h
		call	sub_10C39
		xor	di, di
		mov	dx, 190h
		mov	cx, 50h	; 'P'
		mov	bx, 4
		mov	al, 3
		call	sub_130DE

loc_11404:				; CODE XREF: sub_11363+3Dj
		call	sub_1174B
		mov	si, 19Eh
		call	sub_143B3
		mov	dh, 30h	; '0'
		mov	dl, 28h	; '('
		mov	ch, 0FFh
		mov	cl, 0FFh
		mov	bl, 14h
		mov	al, 2
		call	sub_14407

loc_1141C:				; CODE XREF: sub_11363+BEj
					; sub_11363+F8j ...
		call	sub_14698
		cmp	al, 0FFh
		jz	short loc_1141C
		or	al, al
		jnz	short loc_11472
		cmp	cs:byte_112C1, 80h ; 'Ä'
		jz	short loc_11464
		cmp	cs:byte_112C1, 81h ; 'Å'
		jz	short loc_1143C
		xor	al, al
		jmp	loc_114D7
; ---------------------------------------------------------------------------

loc_1143C:				; CODE XREF: sub_11363+D2j
		mov	si, 1CDh
		call	sub_143B3
		mov	dh, 46h	; 'F'
		mov	dl, 30h	; '0'
		mov	ch, 0FFh
		mov	cl, 0FFh
		mov	bl, 14h
		mov	al, 2
		call	sub_14407
		call	sub_14698
		cmp	al, 0FFh
		jnz	short loc_1145D
		call	sub_148B0
		jmp	short loc_1141C
; ---------------------------------------------------------------------------

loc_1145D:				; CODE XREF: sub_11363+F3j
		call	sub_148B0
		or	al, al
		jnz	short loc_1146B

loc_11464:				; CODE XREF: sub_11363+CAj
		mov	dx, 0FFFFh
		mov	al, 1
		jmp	short loc_114D7
; ---------------------------------------------------------------------------

loc_1146B:				; CODE XREF: sub_11363+FFj
		mov	dx, 3E3Fh
		mov	al, 1
		jmp	short loc_114D7
; ---------------------------------------------------------------------------

loc_11472:				; CODE XREF: sub_11363+C2j
		mov	si, 1F4h
		call	sub_143B3
		mov	dh, 46h	; 'F'
		mov	dl, 30h	; '0'
		mov	ch, 0FFh
		mov	cl, 0FFh
		mov	bl, 14h
		mov	al, 2
		call	sub_14407

loc_11487:				; CODE XREF: sub_11363+15Bj
		call	sub_14698
		cmp	al, 0FFh
		jnz	short loc_11493
		call	sub_148B0
		jmp	short loc_1141C
; ---------------------------------------------------------------------------

loc_11493:				; CODE XREF: sub_11363+129j
		mov	cs:byte_112BD, al
		cmp	cs:MIDIEnable, 0
		jz	short loc_114D0
		mov	si, 21Fh
		call	sub_143B3
		mov	dh, 60h	; '`'
		mov	dl, 2Ah	; '*'
		mov	ch, 0FFh
		mov	cl, 0FFh
		mov	bl, 14h
		mov	al, 2
		call	sub_14407
		call	sub_14698
		cmp	al, 0FFh
		jnz	short loc_114C0
		call	sub_148B0
		jmp	short loc_11487
; ---------------------------------------------------------------------------

loc_114C0:				; CODE XREF: sub_11363+156j
		call	sub_148B0
		or	al, al
		jnz	short loc_114D0
		call	sub_148B0
		xor	dl, dl
		mov	al, 2
		jmp	short loc_114D7
; ---------------------------------------------------------------------------

loc_114D0:				; CODE XREF: sub_11363+13Aj
					; sub_11363+162j
		call	sub_148B0
		mov	dl, 1
		mov	al, 2

loc_114D7:				; CODE XREF: sub_11363+D6j
					; sub_11363+106j ...
		call	sub_148B0
		call	LoadSoundDriver

loc_114DD:				; CODE XREF: sub_11363+1Ej
		cmp	word ptr ds:0A4F7h, 0
		jz	short loc_1153B

loc_114E4:				; CODE XREF: sub_11363+282j
					; sub_11363+29Ej
		mov	si, 256h
		call	sub_143B3
		cmp	byte ptr ds:0A4F6h, 0FFh
		jnz	short loc_114F7
		mov	si, 28Ah
		call	sub_143B3

loc_114F7:				; CODE XREF: sub_11363+18Cj
		cmp	cs:byte_112B9, 0
		jnz	short loc_11505
		mov	si, 2CFh
		call	sub_143B3

loc_11505:				; CODE XREF: sub_11363+19Aj
		mov	dh, 20h	; ' '
		mov	dl, 28h	; '('
		mov	ch, 0FFh
		mov	cl, 0FFh
		mov	bl, 14h
		mov	al, 2
		call	sub_14407

loc_11514:				; CODE XREF: sub_11363+1B6j
					; sub_11363+206j ...
		call	sub_14698
		cmp	al, 0FFh
		jz	short loc_11514
		mov	bl, al
		xor	bh, bh
		shl	bx, 1
		jmp	cs:off_11526[bx]
; ---------------------------------------------------------------------------
off_11526	dw offset loc_11538	; 0 ; DATA XREF: sub_11363+1BEr
		dw offset loc_11566	; 1
		dw offset loc_1159A	; 2
		dw offset loc_115E8	; 3
		dw offset loc_11604	; 4
		dw offset loc_11633	; 5
		dw offset loc_11664	; 6
		dw offset loc_11667	; 7
		dw offset loc_116ED	; 8
; ---------------------------------------------------------------------------

loc_11538:				; CODE XREF: sub_11363+1BEj
					; DATA XREF: sub_11363:off_11526o
		call	sub_148B0

loc_1153B:				; CODE XREF: sub_11363+17Fj
		mov	di, 99F6h
		mov	cx, 0B00h
		xor	al, al
		rep stosb
		xor	di, di
		mov	dx, 190h
		mov	cx, 50h	; 'P'
		mov	bx, 2
		mov	al, 3
		call	sub_130DE
		mov	si, 0A2F6h
		call	sub_12C3A
		mov	byte ptr ds:0A2F5h, 0Eh
		mov	byte ptr ds:1D1Ah, 1
		retn
; ---------------------------------------------------------------------------

loc_11566:				; CODE XREF: sub_11363+1BEj
					; DATA XREF: sub_11363:off_11526o
		call	sub_116F6
		jb	short loc_11514
		xor	ah, ah
		mov	cx, 0B00h
		mul	cx
		push	ds
		push	cs:word_112CC
		pop	ds
		assume ds:nothing
		mov	si, ax
		mov	di, 99F6h
		rep movsb
		pop	ds
		call	sub_148B0
		xor	di, di
		mov	dx, 190h
		mov	cx, 50h	; 'P'
		mov	bx, 2
		mov	al, 3
		call	sub_130DE
		mov	byte ptr ds:1D1Ah, 1
		retn
; ---------------------------------------------------------------------------

loc_1159A:				; CODE XREF: sub_11363+1BEj
					; DATA XREF: sub_11363:off_11526o
		call	sub_116F6
		jnb	short loc_115A2
		jmp	loc_11514
; ---------------------------------------------------------------------------

loc_115A2:				; CODE XREF: sub_11363+23Aj
		call	sub_148B0
		push	ax
		xor	di, di
		mov	dx, 190h
		mov	cx, 50h	; 'P'
		mov	bx, 2
		mov	al, 3
		call	sub_130DE
		pop	ax
		push	ax
		xor	ah, ah
		mov	cx, 0B00h
		mul	cx
		push	ds
		push	ax
		push	cs:word_112CC
		pop	ds
		mov	si, ax
		add	si, 900h
		call	sub_12C3A
		pop	bp
		pop	ds
		pop	ax
		mov	ah, al
		xor	al, al
		add	ax, 1000h	; AH +=	10h -> save file names begin at	ID 10h
		mov	bx, cs:word_112CC
		call	WriteFileA
		call	sub_1174B
		jmp	loc_114E4
; ---------------------------------------------------------------------------

loc_115E8:				; CODE XREF: sub_11363+1BEj
					; DATA XREF: sub_11363:off_11526o
		call	sub_148B0
		xor	di, di
		mov	dx, 190h
		mov	cx, 50h	; 'P'
		mov	bx, 2
		mov	al, 3
		call	sub_130DE
		call	sub_1177B
		call	sub_1174B
		jmp	loc_114E4
; ---------------------------------------------------------------------------

loc_11604:				; CODE XREF: sub_11363+1BEj
					; DATA XREF: sub_11363:off_11526o
		mov	si, 2E1h
		call	sub_143B3
		mov	dh, 3Eh	; '>'
		mov	dl, 18h
		mov	ch, 0FFh
		mov	cl, 0FFh
		mov	bl, 14h
		mov	al, 2
		call	sub_14407

loc_11619:				; CODE XREF: sub_11363+2C2j
		call	sub_14698
		cmp	al, 0FFh
		jz	short loc_11627
		or	al, 80h
		call	LoadPlayBGM
		jmp	short loc_11619
; ---------------------------------------------------------------------------

loc_11627:				; CODE XREF: sub_11363+2BBj
		mov	ax, 200h
		call	SoundCall2
		call	sub_148B0
		jmp	loc_11514
; ---------------------------------------------------------------------------

loc_11633:				; CODE XREF: sub_11363+1BEj
					; DATA XREF: sub_11363:off_11526o
		mov	si, 391h
		call	sub_143B3
		mov	dh, 48h	; 'H'
		mov	dl, 18h
		mov	ch, 0FFh
		mov	cl, 0FFh
		mov	bl, 14h
		mov	al, 2
		call	sub_14407

loc_11648:				; CODE XREF: sub_11363+2F3j
		call	sub_14698
		cmp	al, 0FFh
		jz	short loc_11658
		add	al, 7
		or	al, 80h
		call	LoadPlayBGM
		jmp	short loc_11648
; ---------------------------------------------------------------------------

loc_11658:				; CODE XREF: sub_11363+2EAj
		mov	ax, 200h
		call	SoundCall2
		call	sub_148B0
		jmp	loc_11514
; ---------------------------------------------------------------------------

loc_11664:				; CODE XREF: sub_11363+1BEj
					; DATA XREF: sub_11363:off_11526o
		jmp	loc_11514
; ---------------------------------------------------------------------------

loc_11667:				; CODE XREF: sub_11363+1BEj
					; DATA XREF: sub_11363:off_11526o
		mov	si, 473h
		call	sub_143B3
		mov	dh, 60h	; '`'
		mov	dl, 18h
		mov	ch, 0FFh
		mov	cl, 0FFh
		mov	bl, 14h
		mov	al, 2
		call	sub_14407

loc_1167C:				; CODE XREF: sub_11363:loc_116E5j
		call	sub_14698
		cmp	al, 0FFh
		jz	short loc_116E7
		mov	bl, al
		xor	bh, bh
		shl	bx, 1
		mov	si, [bx+4CEh]

loc_1168D:				; CODE XREF: sub_11363+37Cj
		lodsw
		or	ax, ax
		jz	short loc_116E5
		push	si
		mov	si, ax
		lodsb
		mov	dh, al
		lodsb
		mov	dl, al
		push	dx
		call	sub_143B3
		pop	dx
		mov	ch, 0FFh
		mov	cl, 0FFh
		mov	bl, 14h
		mov	al, 2
		call	sub_14407

loc_116AB:				; CODE XREF: sub_11363+355j
		call	sub_10C85
		test	ax, 0D000h
		jnz	short loc_116DB
		call	sub_14C11
		test	al, 3
		jnz	short loc_116AB

loc_116BA:				; CODE XREF: sub_11363+376j
		call	sub_10C85
		test	ax, 0D000h
		jnz	short loc_116DB
		test	dx, 10h
		jnz	short loc_116DB
		test	dx, 20h
		jnz	short loc_116E1
		call	sub_14C11
		test	al, 2
		jnz	short loc_116DB
		test	al, 1
		jnz	short loc_116E1
		jmp	short loc_116BA
; ---------------------------------------------------------------------------

loc_116DB:				; CODE XREF: sub_11363+34Ej
					; sub_11363+35Dj ...
		call	sub_148B0
		pop	si
		jmp	short loc_1168D
; ---------------------------------------------------------------------------

loc_116E1:				; CODE XREF: sub_11363+369j
					; sub_11363+374j
		call	sub_148B0
		pop	si

loc_116E5:				; CODE XREF: sub_11363+32Dj
		jmp	short loc_1167C
; ---------------------------------------------------------------------------

loc_116E7:				; CODE XREF: sub_11363+31Ej
		call	sub_148B0
		jmp	loc_11514
; ---------------------------------------------------------------------------

loc_116ED:				; CODE XREF: sub_11363+1BEj
					; DATA XREF: sub_11363:off_11526o
		call	sub_148B0
		or	byte ptr ds:1D19h, 80h
		retn
sub_11363	endp


; =============== S U B	R O U T	I N E =======================================


sub_116F6	proc near		; CODE XREF: sub_11363:loc_11566p
					; sub_11363:loc_1159Ap
		xor	bp, bp
		mov	dx, ds:0A4F7h

loc_116FC:				; CODE XREF: sub_116F6+17j
		shr	dx, 1
		jnb	short loc_11708
		mov	si, ds:[bp+42Bh]
		call	sub_143B3

loc_11708:				; CODE XREF: sub_116F6+8j
		inc	bp
		inc	bp
		cmp	bp, 0Ch
		jnz	short loc_116FC
		mov	dh, 20h	; ' '
		mov	dl, 36h	; '6'
		mov	ch, 0FFh
		mov	cl, 0FFh
		mov	bl, 14h
		mov	al, 2
		call	sub_14407
		call	sub_14698
		cmp	al, 0FFh
		jz	short loc_1172A
		call	sub_148B0
		clc
		retn
; ---------------------------------------------------------------------------

loc_1172A:				; CODE XREF: sub_116F6+2Dj
		call	sub_148B0
		stc
		retn
sub_116F6	endp


; =============== S U B	R O U T	I N E =======================================


sub_1172F	proc near		; CODE XREF: sub_11363:loc_113B1p
					; sub_11363:loc_113DAp
		push	ax
		push	cx
		push	dx
		call	sub_14C11
		test	al, 3
		jnz	short loc_11746
		call	sub_10C85
		test	ax, 30h
		jnz	short loc_11746
		pop	dx
		pop	cx
		pop	ax
		clc
		retn
; ---------------------------------------------------------------------------

loc_11746:				; CODE XREF: sub_1172F+8j
					; sub_1172F+10j
		pop	dx
		pop	cx
		pop	ax
		stc
		retn
sub_1172F	endp


; =============== S U B	R O U T	I N E =======================================


sub_1174B	proc near		; CODE XREF: sub_11363+1Bp
					; sub_11363:loc_11404p	...
		mov	ax, 5
		mov	bp, 0FFFFh
		call	sub_14237
		or	byte ptr ds:1D18h, 50h
		call	sub_10C39
		xor	di, di
		xor	dh, dh
		mov	dl, 1
		mov	ax, 205h
		call	LoadGraphicsFile
		xor	di, di
		xor	si, si
		mov	dx, 190h
		mov	cx, 50h	; 'P'
		mov	bx, 2
		mov	al, 5
		call	sub_130DE
		retn
sub_1174B	endp


; =============== S U B	R O U T	I N E =======================================


sub_1177B	proc near		; CODE XREF: sub_11363+298p
		push	ds
		push	es
		pusha
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		mov	ax, cs:word_112CC
		mov	es, ax
		mov	word ptr ds:0A4F9h, 0

loc_1178F:				; CODE XREF: sub_1177B+ACj
		mov	si, ds:0A4F9h
		shr	si, 3
		mov	al, es:[si+4200h]
		mov	bx, ds:0A4F9h
		and	bx, 7
		test	cs:[bx+5300h], al
		jz	short loc_1181B
		mov	ax, ds:0A4F9h
		mov	bp, 0FFFFh
		call	sub_14237
		or	byte ptr ds:1D18h, 50h
		call	sub_10C39
		xor	di, di
		xor	dh, dh
		mov	dl, 1
		mov	ax, ds:0A4F9h
		add	ah, 2
		call	LoadGraphicsFile
		xor	di, di
		xor	si, si
		mov	dx, 190h
		mov	cx, 50h	; 'P'
		mov	bx, 2
		mov	al, 5
		call	sub_130DE

loc_117DB:				; CODE XREF: sub_1177B+6Dj
		call	sub_10C85
		test	ax, 0D000h
		jnz	short loc_1180B
		call	sub_14C11
		test	al, 3
		jnz	short loc_117DB

loc_117EA:				; CODE XREF: sub_1177B+8Ej
		call	sub_10C85
		test	ax, 0D000h
		jnz	short loc_1180B
		test	dx, 10h
		jnz	short loc_1180B
		test	dx, 20h
		jnz	short loc_1182E
		call	sub_14C11
		test	al, 2
		jnz	short loc_1180B
		test	al, 1
		jnz	short loc_1182E
		jmp	short loc_117EA
; ---------------------------------------------------------------------------

loc_1180B:				; CODE XREF: sub_1177B+66j
					; sub_1177B+75j ...
		xor	di, di
		mov	dx, 190h
		mov	cx, 50h	; 'P'
		mov	bx, 2
		mov	al, 3
		call	sub_130DE

loc_1181B:				; CODE XREF: sub_1177B+2Cj
		inc	word ptr ds:0A4F9h
		cmp	word ptr ds:0A4F9h, 400h
		jz	short loc_1182A
		jmp	loc_1178F
; ---------------------------------------------------------------------------

loc_1182A:				; CODE XREF: sub_1177B+AAj
		popa
		pop	es
		pop	ds
		assume ds:nothing
		retn
; ---------------------------------------------------------------------------

loc_1182E:				; CODE XREF: sub_1177B+81j
					; sub_1177B+8Cj
		xor	di, di
		mov	dx, 190h
		mov	cx, 50h	; 'P'
		mov	bx, 2
		mov	al, 3
		call	sub_130DE
		popa
		pop	es
		pop	ds
		retn
sub_1177B	endp

; ---------------------------------------------------------------------------
		retn
; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


nullsub_6	proc near		; CODE XREF: start+4Fp
					; DATA XREF: seg000:off_10089o
		retn
nullsub_6	endp


; =============== S U B	R O U T	I N E =======================================


DoScript	proc near		; CODE XREF: start+4Fp	start+62p
					; DATA XREF: ...

; FUNCTION CHUNK AT 195D SIZE 000000AA BYTES
; FUNCTION CHUNK AT 2655 SIZE 00000007 BYTES
; FUNCTION CHUNK AT 265F SIZE 00000006 BYTES
; FUNCTION CHUNK AT 266B SIZE 00000040 BYTES

		xor	al, al
		call	sub_12B7D

j_LoadScript:				; CODE XREF: seg000:loc_1265Cj
		call	LoadScript

ScriptMainLoop:				; CODE XREF: DoScript+E14j
		cmp	cs:byte_112B9, 0
		jnz	short loc_118BC
		call	sub_10C85
		test	ax, 0C000h
		jz	short loc_118BC
		call	sub_14C51
		call	sub_14BE0
		mov	si, 111Ch
		call	sub_143B3
		mov	al, ds:1D24h
		push	ax
		mov	al, ds:1D23h
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	dh, 28h	; '('
		mov	dl, 28h	; '('
		mov	ch, 0FFh
		mov	cl, 0FFh
		mov	bl, 10h
		mov	al, 3
		call	sub_14407
		mov	si, 1134h
		call	sub_143B3
		mov	dh, 3Ah	; ':'
		mov	dl, 28h	; '('
		mov	ch, 0FFh
		mov	cl, 0FFh
		mov	bl, 10h
		mov	al, 3
		call	sub_14407

loc_11896:				; CODE XREF: DoScript+56j
		call	sub_14698
		cmp	al, 0FFh
		jz	short loc_11896
		mov	dl, al
		call	sub_148B0
		call	sub_148B0
		pop	ax
		mov	ds:1D24h, al
		out	0A6h, al	; Interrupt Controller #2, 8259A
		call	sub_14C6B
		or	dl, dl
		jz	short loc_118B5
		jmp	loc_1265F
; ---------------------------------------------------------------------------

loc_118B5:				; CODE XREF: DoScript+6Bj DoScript+75j
		call	sub_14C11
		test	al, 3
		jnz	short loc_118B5

loc_118BC:				; CODE XREF: DoScript+Ej DoScript+16j
		mov	al, ds:1D04h
		mov	ds:0A536h, al
		mov	si, ds:0A4FEh
		call	scr_GetByte
		jnb	short loc_118D1
		mov	ax, 0FFFFh
		jmp	loc_1266B
; ---------------------------------------------------------------------------

loc_118D1:				; CODE XREF: DoScript+84j
		or	al, al
		jz	short loc_1190E
		cmp	al, 20h	; ' '
		jnb	short loc_118DC
		jmp	loc_119ED
; ---------------------------------------------------------------------------

loc_118DC:				; CODE XREF: DoScript+92j
		cmp	al, 0FFh
		jnz	short loc_118EB
		mov	bp, 1A77h
		call	scr_GetByte
		not	al
		jmp	loc_119FC
; ---------------------------------------------------------------------------

loc_118EB:				; CODE XREF: DoScript+99j
		or	al, al
		jns	short loc_118F2
		jmp	loc_119AE
; ---------------------------------------------------------------------------

loc_118F2:				; CODE XREF: DoScript+A8j
		cmp	al, 23h	; '#'
		jz	short loc_1191F
		cmp	al, 24h	; '$'
		jz	short loc_11940
		cmp	al, 5Fh	; '_'
		jz	short loc_1195D
		cmp	al, 5Dh	; ']'
		jz	short loc_1196B
		cmp	al, 7Ch	; '|'
		jnz	short loc_11909
		jmp	loc_119A3
; ---------------------------------------------------------------------------

loc_11909:				; CODE XREF: DoScript+BFj
		xor	ah, ah
		jmp	loc_119B3
; ---------------------------------------------------------------------------

loc_1190E:				; CODE XREF: DoScript+8Ej
		mov	bx, ds:0A500h
		dec	bx
		dec	bx
		mov	si, [bx+0A502h]
		mov	ds:0A500h, bx
		jmp	scr_return
; ---------------------------------------------------------------------------

loc_1191F:				; CODE XREF: DoScript+AFj
		call	scr_GetByte
		mov	bx, ds:0A500h
		mov	[bx+0A502h], si
		inc	bx
		inc	bx
		mov	ds:0A500h, bx
		sub	al, 41h	; 'A'
		and	ax, 0Fh
		shl	ax, 5
		mov	si, 0A2F6h
		add	si, ax
		jmp	scr_return
; ---------------------------------------------------------------------------

loc_11940:				; CODE XREF: DoScript+B3j
		call	sub_1194F
		mov	ds:0A52Bh, al
		call	sub_1194F
		mov	ds:0A52Ch, al
		jmp	scr_return
DoScript	endp


; =============== S U B	R O U T	I N E =======================================


sub_1194F	proc near		; CODE XREF: DoScript:loc_11940p
					; DoScript+101p
		call	scr_GetByte
		sub	al, 30h	; '0'
		cmp	al, 0Ah
		jb	short loc_1195A
		sub	al, 7

loc_1195A:				; CODE XREF: sub_1194F+7j
		and	al, 0Fh
		retn
sub_1194F	endp

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR DoScript

loc_1195D:				; CODE XREF: DoScript+B7j
		mov	al, ds:0A2F4h
		mov	ds:0A527h, al
		mov	byte ptr ds:0A52Dh, 0FFh
		jmp	scr_return
; ---------------------------------------------------------------------------

loc_1196B:				; CODE XREF: DoScript+BBj
		cmp	byte ptr ds:0A52Dh, 0
		jnz	short loc_11976
		xor	al, al
		jmp	short loc_1197B
; ---------------------------------------------------------------------------

loc_11976:				; CODE XREF: DoScript+12Bj
		mov	al, ds:0A2F4h
		add	al, 2

loc_1197B:				; CODE XREF: DoScript+12Fj
		mov	ds:0A527h, al
		inc	byte ptr ds:0A528h
		mov	al, ds:0A528h
		cmp	al, ds:0A52Ah
		jb	short loc_119A0
		mov	byte ptr ds:0A527h, 0
		mov	byte ptr ds:0A528h, 0
		mov	byte ptr ds:0A52Dh, 0
		call	sub_126ED
		call	sub_12810

loc_119A0:				; CODE XREF: DoScript+144j
		jmp	scr_return
; ---------------------------------------------------------------------------

loc_119A3:				; CODE XREF: DoScript+C1j
		call	scr_GetByte
		sub	al, 41h	; 'A'
		and	al, 0Fh
		mov	ah, 1
		jmp	short loc_119B3
; ---------------------------------------------------------------------------

loc_119AE:				; CODE XREF: DoScript+AAj
		xchg	al, ah
		call	scr_GetByte

loc_119B3:				; CODE XREF: DoScript+C6j
					; DoScript+167j
		call	sub_12A94
		or	al, al
		jz	short loc_119C0
		call	sub_126ED
		call	sub_12810

loc_119C0:				; CODE XREF: DoScript+173j
					; DoScript:loc_119E8j
		mov	al, ds:1D04h
		sub	al, ds:0A536h
		cmp	al, ds:0A522h
		jnb	short loc_119EA
		call	sub_10C85
		test	ax, 0C000h
		jnz	short loc_119EA
		cmp	byte ptr ds:0A2F3h, 0
		jnz	short loc_119E8
		test	ax, 1120h
		jnz	short loc_119EA
		call	sub_14C11
		test	al, 3
		jnz	short loc_119EA

loc_119E8:				; CODE XREF: DoScript+195j
		jmp	short loc_119C0
; ---------------------------------------------------------------------------

loc_119EA:				; CODE XREF: DoScript+186j
					; DoScript+18Ej ...
		jmp	scr_return
; ---------------------------------------------------------------------------

loc_119ED:				; CODE XREF: DoScript+94j
		mov	bl, al
		and	bx, 1Fh
		shl	bx, 1
		mov	bp, cs:scrJumpTable[bx]
		call	scr_GetByte

loc_119FC:				; CODE XREF: DoScript+A3j
		mov	bl, al
		xor	bh, bh
		shl	bx, 1
		add	bx, bp
		jmp	word ptr cs:[bx]
; END OF FUNCTION CHUNK	FOR DoScript
; ---------------------------------------------------------------------------
scrJumpTable	dw offset off_11A47	; 0 ; DATA XREF: DoScript+1AFr
		dw offset off_11A47	; 1
		dw offset off_11A63	; 2
		dw offset off_11A6B	; 3
		dw offset off_11A91	; 4
		dw offset off_11AA3	; 5
		dw offset off_11AAB	; 6
		dw offset off_11AC5	; 7
		dw offset off_11A47	; 8
		dw offset off_11A47	; 9
		dw offset off_11A47	; 0Ah
		dw offset off_11A47	; 0Bh
		dw offset off_11A47	; 0Ch
		dw offset off_11A47	; 0Dh
		dw offset off_11A47	; 0Eh
		dw offset off_11A47	; 0Fh
		dw offset off_11A47	; 10h
		dw offset off_11A47	; 11h
		dw offset off_11A47	; 12h
		dw offset off_11A47	; 13h
		dw offset off_11A47	; 14h
		dw offset off_11A47	; 15h
		dw offset off_11A47	; 16h
		dw offset off_11A47	; 17h
		dw offset off_11A47	; 18h
		dw offset off_11A47	; 19h
		dw offset off_11A47	; 1Ah
		dw offset off_11A47	; 1Bh
		dw offset off_11A47	; 1Ch
		dw offset off_11A47	; 1Dh
		dw offset off_11A47	; 1Eh
		dw offset off_11AD1	; 1Fh
off_11A47	dw offset loc_11ADB	; 0 ; DATA XREF: seg000:scrJumpTableo
		dw offset loc_11AEA	; 1
		dw offset loc_11AFF	; 2
		dw offset loc_11B17	; 3
		dw offset loc_11B32	; 4
		dw offset loc_11B4A	; 5
		dw offset loc_11B65	; 6
		dw offset loc_11B79	; 7
		dw offset loc_11B93	; 8
		dw offset loc_11BA7	; 9
		dw offset loc_11BC1	; 0Ah
		dw offset loc_11BD5	; 0Bh
		dw offset loc_11BEF	; 0Ch
		dw offset loc_11C00	; 0Dh
off_11A63	dw offset loc_11C11	; 0 ; DATA XREF: seg000:scrJumpTableo
		dw offset loc_11C1A	; 1
		dw offset loc_11C23	; 2
		dw offset loc_11C41	; 3
off_11A6B	dw offset loc_11C9A	; 0 ; DATA XREF: seg000:scrJumpTableo
		dw offset loc_11C9D	; 1
		dw offset loc_11CA0	; 2
		dw offset loc_11CA8	; 3
		dw offset loc_11CC3	; 4
		dw offset loc_11CE4	; 5
		dw offset loc_11CFD	; 6
		dw offset loc_11D19	; 7
		dw offset loc_11D35	; 8
		dw offset loc_11D55	; 9
		dw offset loc_11D6F	; 0Ah
		dw offset loc_11D7E	; 0Bh
		dw offset loc_11DAA	; 0Ch
		dw offset loc_11E11	; 0Dh
		dw offset loc_11E45	; 0Eh
		dw offset loc_11E54	; 0Fh
		dw offset loc_11EA5	; 10h
		dw offset loc_11EC0	; 11h
		dw offset loc_11EE0	; 12h
off_11A91	dw offset loc_11FE0	; 0 ; DATA XREF: seg000:scrJumpTableo
		dw offset loc_11FF5	; 1
		dw offset loc_1200A	; 2
		dw offset loc_12010	; 3
		dw offset loc_12016	; 4
		dw offset loc_1201F	; 5
		dw offset loc_12047	; 6
		dw offset loc_1206A	; 7
		dw offset loc_120A8	; 8
off_11AA3	dw offset loc_120B1	; 0 ; DATA XREF: seg000:scrJumpTableo
		dw offset loc_120BA	; 1
		dw offset loc_120D7	; 2
		dw offset loc_12131	; 3
off_11AAB	dw offset loc_1217E	; 0 ; DATA XREF: seg000:scrJumpTableo
		dw offset loc_121B1	; 1
		dw offset loc_1224E	; 2
		dw offset loc_12265	; 3
		dw offset loc_1227C	; 4
		dw offset loc_12293	; 5
		dw offset loc_122F9	; 6
		dw offset loc_12309	; 7
		dw offset loc_12316	; 8
		dw offset loc_1232C	; 9
		dw offset loc_12389	; 0Ah
		dw offset loc_123D6	; 0Bh
		dw offset loc_12417	; 0Ch
off_11AC5	dw offset loc_12437	; 0 ; DATA XREF: seg000:scrJumpTableo
		dw offset loc_12440	; 1
		dw offset loc_12446	; 2
		dw offset loc_1244F	; 3
		dw offset loc_12458	; 4
		dw offset loc_12461	; 5
off_11AD1	dw offset loc_124AC	; 0 ; DATA XREF: seg000:scrJumpTableo
		dw offset loc_124B2	; 1
		dw offset loc_124D6	; 2
		dw offset loc_1262F	; 3
		dw offset loc_12637	; 4
; ---------------------------------------------------------------------------

loc_11ADB:				; DATA XREF: seg000:off_11A47o
		call	scr_GetVal_11Bit
		mov	bx, ax
		call	scr_GetVal_7Bit
		mov	[bx-650Ah], al
		jmp	scr_return
; ---------------------------------------------------------------------------

loc_11AEA:				; DATA XREF: seg000:off_11A47o
		call	scr_GetVal_11Bit
		mov	bx, ax
		call	scr_GetVal_11Bit
		mov	di, ax
		mov	al, [di-650Ah]
		mov	[bx-650Ah], al
		jmp	scr_return
; ---------------------------------------------------------------------------

loc_11AFF:				; DATA XREF: seg000:off_11A47o
		call	scr_GetVal_11Bit
		mov	bx, ax
		call	scr_GetVal_7Bit
		mov	ah, [bx-650Ah]
		add	ah, al
		and	ah, 7Fh
		mov	[bx-650Ah], ah
		jmp	scr_return
; ---------------------------------------------------------------------------

loc_11B17:				; DATA XREF: seg000:off_11A47o
		call	scr_GetVal_11Bit
		mov	bx, ax
		call	scr_GetVal_11Bit
		mov	di, ax
		mov	al, [bx-650Ah]
		add	al, [di-650Ah]
		and	al, 7Fh
		mov	[bx-650Ah], al
		jmp	scr_return
; ---------------------------------------------------------------------------

loc_11B32:				; DATA XREF: seg000:off_11A47o
		call	scr_GetVal_11Bit
		mov	bx, ax
		call	scr_GetVal_7Bit
		mov	ah, [bx-650Ah]
		sub	ah, al
		and	ah, 7Fh
		mov	[bx-650Ah], ah
		jmp	scr_return
; ---------------------------------------------------------------------------

loc_11B4A:				; DATA XREF: seg000:off_11A47o
		call	scr_GetVal_11Bit
		mov	bx, ax
		call	scr_GetVal_11Bit
		mov	di, ax
		mov	al, [bx-650Ah]
		sub	al, [di-650Ah]
		and	al, 7Fh
		mov	[bx-650Ah], al
		jmp	scr_return
; ---------------------------------------------------------------------------

loc_11B65:				; DATA XREF: seg000:off_11A47o
		call	scr_GetVal_11Bit
		mov	bx, ax
		call	scr_GetVal_7Bit
		and	[bx-650Ah], al
		and	byte ptr [bx-650Ah], 7Fh
		jmp	scr_return
; ---------------------------------------------------------------------------

loc_11B79:				; DATA XREF: seg000:off_11A47o
		call	scr_GetVal_11Bit
		mov	bx, ax
		call	scr_GetVal_11Bit
		mov	di, ax
		mov	al, [di-650Ah]
		and	[bx-650Ah], al
		and	byte ptr [bx-650Ah], 7Fh
		jmp	scr_return
; ---------------------------------------------------------------------------

loc_11B93:				; DATA XREF: seg000:off_11A47o
		call	scr_GetVal_11Bit
		mov	bx, ax
		call	scr_GetVal_7Bit
		or	[bx-650Ah], al
		and	byte ptr [bx-650Ah], 7Fh
		jmp	scr_return
; ---------------------------------------------------------------------------

loc_11BA7:				; DATA XREF: seg000:off_11A47o
		call	scr_GetVal_11Bit
		mov	bx, ax
		call	scr_GetVal_11Bit
		mov	di, ax
		mov	al, [di-650Ah]
		or	[bx-650Ah], al
		and	byte ptr [bx-650Ah], 7Fh
		jmp	scr_return
; ---------------------------------------------------------------------------

loc_11BC1:				; DATA XREF: seg000:off_11A47o
		call	scr_GetVal_11Bit
		mov	bx, ax
		call	scr_GetVal_7Bit
		xor	[bx-650Ah], al
		and	byte ptr [bx-650Ah], 7Fh
		jmp	scr_return
; ---------------------------------------------------------------------------

loc_11BD5:				; DATA XREF: seg000:off_11A47o
		call	scr_GetVal_11Bit
		mov	bx, ax
		call	scr_GetVal_11Bit
		mov	di, ax
		mov	al, [di-650Ah]
		xor	[bx-650Ah], al
		and	byte ptr [bx-650Ah], 7Fh
		jmp	scr_return
; ---------------------------------------------------------------------------

loc_11BEF:				; DATA XREF: seg000:off_11A47o
		call	scr_GetVal_11Bit
		mov	bx, ax
		inc	byte ptr [bx-650Ah]
		and	byte ptr [bx-650Ah], 7Fh
		jmp	scr_return
; ---------------------------------------------------------------------------

loc_11C00:				; DATA XREF: seg000:off_11A47o
		call	scr_GetVal_11Bit
		mov	bx, ax
		dec	byte ptr [bx-650Ah]
		and	byte ptr [bx-650Ah], 7Fh
		jmp	scr_return
; ---------------------------------------------------------------------------

loc_11C11:				; DATA XREF: seg000:off_11A63o
		call	scr_GetVal_11Bit
		call	sub_11C5F
		jmp	scr_return
; ---------------------------------------------------------------------------

loc_11C1A:				; DATA XREF: seg000:off_11A63o
		call	scr_GetVal_11Bit
		call	sub_11C74
		jmp	scr_return
; ---------------------------------------------------------------------------

loc_11C23:				; DATA XREF: seg000:off_11A63o
		call	scr_GetVal_11Bit
		mov	dx, ax
		call	scr_GetVal_11Bit
		cmp	dx, ax
		jbe	short loc_11C30
		xchg	ax, dx

loc_11C30:				; CODE XREF: seg000:1C2Dj
		mov	bp, ax

loc_11C32:				; CODE XREF: seg000:1C3Cj
		mov	ax, dx
		call	sub_11C5F
		cmp	dx, bp
		jz	short loc_11C3E
		inc	dx
		jmp	short loc_11C32
; ---------------------------------------------------------------------------

loc_11C3E:				; CODE XREF: seg000:1C39j
		jmp	scr_return
; ---------------------------------------------------------------------------

loc_11C41:				; DATA XREF: seg000:off_11A63o
		call	scr_GetVal_11Bit
		mov	dx, ax
		call	scr_GetVal_11Bit
		cmp	dx, ax
		jbe	short loc_11C4E
		xchg	ax, dx

loc_11C4E:				; CODE XREF: seg000:1C4Bj
		mov	bp, ax

loc_11C50:				; CODE XREF: seg000:1C5Aj
		mov	ax, dx
		call	sub_11C74
		cmp	dx, bp
		jz	short loc_11C5C
		inc	dx
		jmp	short loc_11C50
; ---------------------------------------------------------------------------

loc_11C5C:				; CODE XREF: seg000:1C57j
		jmp	scr_return

; =============== S U B	R O U T	I N E =======================================


sub_11C5F	proc near		; CODE XREF: seg000:1C14p seg000:1C34p
		mov	bx, ax
		and	bx, 7
		mov	di, ax
		shr	di, 3
		mov	al, [bx+100h]
		not	al
		and	[di-660Ah], al
		retn
sub_11C5F	endp


; =============== S U B	R O U T	I N E =======================================


sub_11C74	proc near		; CODE XREF: seg000:1C1Dp seg000:1C52p
		mov	bx, ax
		and	bx, 7
		mov	di, ax
		shr	di, 3
		mov	al, [bx+100h]
		or	[di-660Ah], al
		retn
sub_11C74	endp


; =============== S U B	R O U T	I N E =======================================


sub_11C87	proc near		; CODE XREF: seg000:1D00p seg000:1D1Cp
		mov	bx, ax
		and	bx, 7
		mov	di, ax
		shr	di, 3
		mov	al, [bx+100h]
		test	[di-660Ah], al
		retn
sub_11C87	endp

; ---------------------------------------------------------------------------

loc_11C9A:				; DATA XREF: seg000:off_11A6Bo
		jmp	loc_12665
; ---------------------------------------------------------------------------

loc_11C9D:				; DATA XREF: seg000:off_11A6Bo
		jmp	loc_1265C
; ---------------------------------------------------------------------------

loc_11CA0:				; DATA XREF: seg000:off_11A6Bo
		call	scr_GetVal_16Bit
		add	si, ax
		jmp	scr_return
; ---------------------------------------------------------------------------

loc_11CA8:				; DATA XREF: seg000:off_11A6Bo
		call	scr_GetVal_11Bit
		push	si
		mov	bx, ax
		mov	al, [bx-650Ah]
		xor	ah, ah
		add	si, ax
		shl	ax, 1
		add	si, ax
		call	scr_GetVal_16Bit
		pop	si
		add	si, ax
		jmp	scr_return
; ---------------------------------------------------------------------------

loc_11CC3:				; DATA XREF: seg000:off_11A6Bo
		call	scr_GetVal_16Bit
		mov	bx, ds:0CD3Fh
		cmp	bx, 40h	; '@'
		jb	short loc_11CD5
		mov	ax, 0
		jmp	loc_1266B
; ---------------------------------------------------------------------------

loc_11CD5:				; CODE XREF: seg000:1CCDj
		mov	[bx+0CD41h], si
		inc	bx
		inc	bx
		mov	ds:0CD3Fh, bx
		add	si, ax
		jmp	scr_return
; ---------------------------------------------------------------------------

loc_11CE4:				; DATA XREF: seg000:off_11A6Bo
		mov	bx, ds:0CD3Fh
		dec	bx
		dec	bx
		jns	short loc_11CF2
		mov	ax, 1
		jmp	loc_1266B
; ---------------------------------------------------------------------------

loc_11CF2:				; CODE XREF: seg000:1CEAj
		mov	si, [bx+0CD41h]
		mov	ds:0CD3Fh, bx
		jmp	scr_return
; ---------------------------------------------------------------------------

loc_11CFD:				; DATA XREF: seg000:off_11A6Bo
		call	scr_GetVal_11Bit
		call	sub_11C87
		jz	short loc_11D0B
		inc	byte ptr ds:0CD81h
		jmp	short loc_11D16
; ---------------------------------------------------------------------------

loc_11D0B:				; CODE XREF: seg000:1D03j
		call	sub_11F10
		jnb	short loc_11D16
		mov	ax, 100h
		jmp	loc_1266B
; ---------------------------------------------------------------------------

loc_11D16:				; CODE XREF: seg000:1D09j seg000:1D0Ej
		jmp	scr_return
; ---------------------------------------------------------------------------

loc_11D19:				; DATA XREF: seg000:off_11A6Bo
		call	scr_GetVal_11Bit
		call	sub_11C87
		jnz	short loc_11D27
		inc	byte ptr ds:0CD81h
		jmp	short loc_11D32
; ---------------------------------------------------------------------------

loc_11D27:				; CODE XREF: seg000:1D1Fj
		call	sub_11F10
		jnb	short loc_11D32
		mov	ax, 101h
		jmp	loc_1266B
; ---------------------------------------------------------------------------

loc_11D32:				; CODE XREF: seg000:1D25j seg000:1D2Aj
		jmp	scr_return
; ---------------------------------------------------------------------------

loc_11D35:				; DATA XREF: seg000:off_11A6Bo
		call	scr_GetByte
		mov	cl, al
		call	sub_11F8C
		or	ch, ch
		jz	short loc_11D47
		inc	byte ptr ds:0CD81h
		jmp	short loc_11D52
; ---------------------------------------------------------------------------

loc_11D47:				; CODE XREF: seg000:1D3Fj
		call	sub_11F10
		jnb	short loc_11D52
		mov	ax, 102h
		jmp	loc_1266B
; ---------------------------------------------------------------------------

loc_11D52:				; CODE XREF: seg000:1D45j seg000:1D4Aj
		jmp	scr_return
; ---------------------------------------------------------------------------

loc_11D55:				; DATA XREF: seg000:off_11A6Bo
		call	sub_11F35
		jnb	short loc_11D60
		mov	ax, 103h
		jmp	loc_1266B
; ---------------------------------------------------------------------------

loc_11D60:				; CODE XREF: seg000:1D58j
		dec	byte ptr ds:0CD81h
		jns	short loc_11D6C
		mov	ax, 104h
		jmp	loc_1266B
; ---------------------------------------------------------------------------

loc_11D6C:				; CODE XREF: seg000:1D64j
		jmp	scr_return
; ---------------------------------------------------------------------------

loc_11D6F:				; DATA XREF: seg000:off_11A6Bo
		dec	byte ptr ds:0CD81h
		jns	short loc_11D7B
		mov	ax, 105h
		jmp	loc_1266B
; ---------------------------------------------------------------------------

loc_11D7B:				; CODE XREF: seg000:1D73j
		jmp	scr_return
; ---------------------------------------------------------------------------

loc_11D7E:				; DATA XREF: seg000:off_11A6Bo
		call	scr_GetVal_11Bit
		mov	bx, ax
		mov	al, [bx-650Ah]
		mov	bl, ds:0CD82h
		xor	bh, bh
		mov	[bx-327Dh], al
		mov	byte ptr [bx-325Dh], 0
		inc	byte ptr ds:0CD82h
		cmp	byte ptr ds:0CD82h, 20h	; ' '
		jb	short loc_11DA7
		mov	ax, 200h
		jmp	loc_1266B
; ---------------------------------------------------------------------------

loc_11DA7:				; CODE XREF: seg000:1D9Fj
		jmp	scr_return
; ---------------------------------------------------------------------------

loc_11DAA:				; CODE XREF: seg000:1DF4j
					; DATA XREF: seg000:off_11A6Bo
		call	scr_GetVal_7Bit
		mov	bl, ds:0CD82h
		xor	bh, bh
		dec	bx
		jns	short loc_11DBC
		mov	ax, 201h
		jmp	loc_1266B
; ---------------------------------------------------------------------------

loc_11DBC:				; CODE XREF: seg000:1DB4j
		cmp	byte ptr [bx-325Dh], 0
		jnz	short loc_11E2B
		cmp	al, [bx-327Dh]
		jz	short loc_11E02
		xor	cl, cl

loc_11DCB:				; CODE XREF: seg000:1DEAj seg000:1DEEj ...
		call	sub_11F6F
		jnb	short loc_11DD6
		mov	ax, 202h
		jmp	loc_1266B
; ---------------------------------------------------------------------------

loc_11DD6:				; CODE XREF: seg000:1DCEj
		cmp	ax, 0FFFAh
		jz	short loc_11DEC
		cmp	ax, 0FFF9h
		jz	short loc_11DF0
		cmp	ax, 0FFF8h
		jz	short loc_11DF6
		cmp	ax, 0FFF7h
		jz	short loc_11DFC
		jmp	short loc_11DCB
; ---------------------------------------------------------------------------

loc_11DEC:				; CODE XREF: seg000:1DD9j
		inc	cl
		jmp	short loc_11DCB
; ---------------------------------------------------------------------------

loc_11DF0:				; CODE XREF: seg000:1DDEj
		or	cl, cl
		jnz	short loc_11DCB
		jmp	short loc_11DAA
; ---------------------------------------------------------------------------

loc_11DF6:				; CODE XREF: seg000:1DE3j
		or	cl, cl
		jnz	short loc_11DCB
		jmp	short loc_11E02
; ---------------------------------------------------------------------------

loc_11DFC:				; CODE XREF: seg000:1DE8j
		dec	cl
		jns	short loc_11DCB
		jmp	short loc_11E45
; ---------------------------------------------------------------------------

loc_11E02:				; CODE XREF: seg000:1DC7j seg000:1DFAj
		mov	bl, ds:0CD82h
		xor	bh, bh
		dec	bx
		mov	byte ptr [bx-325Dh], 0FFh
		jmp	scr_return
; ---------------------------------------------------------------------------

loc_11E11:				; DATA XREF: seg000:off_11A6Bo
		call	sub_11F52
		jnb	short loc_11E1C

loc_11E16:
		mov	ax, 205h
		jmp	loc_1266B
; ---------------------------------------------------------------------------

loc_11E1C:				; CODE XREF: seg000:1E14j
		dec	byte ptr ds:0CD82h
		jns	short loc_11E28
		mov	ax, 206h
		jmp	loc_1266B
; ---------------------------------------------------------------------------

loc_11E28:				; CODE XREF: seg000:1E20j
		jmp	scr_return
; ---------------------------------------------------------------------------

loc_11E2B:				; CODE XREF: seg000:1DC1j
		call	sub_11F52
		jnb	short loc_11E36
		mov	ax, 203h
		jmp	loc_1266B
; ---------------------------------------------------------------------------

loc_11E36:				; CODE XREF: seg000:1E2Ej
		dec	byte ptr ds:0CD82h
		jns	short loc_11E42
		mov	ax, 204h
		jmp	loc_1266B
; ---------------------------------------------------------------------------

loc_11E42:				; CODE XREF: seg000:1E3Aj
		jmp	scr_return
; ---------------------------------------------------------------------------

loc_11E45:				; CODE XREF: seg000:1E00j
					; DATA XREF: seg000:off_11A6Bo
		dec	byte ptr ds:0CD82h
		jns	short loc_11E51
		mov	ax, 207h
		jmp	loc_1266B
; ---------------------------------------------------------------------------

loc_11E51:				; CODE XREF: seg000:1E49j
		jmp	scr_return
; ---------------------------------------------------------------------------

loc_11E54:				; DATA XREF: seg000:off_11A6Bo
		mov	cl, 1
		call	sub_11F8C
		or	ch, ch
		jnz	short loc_11E80
		xor	cl, cl

loc_11E5F:				; CODE XREF: seg000:1E74j seg000:1E78j ...
		call	sub_11F6F
		jnb	short loc_11E6A
		mov	ax, 300h
		jmp	loc_1266B
; ---------------------------------------------------------------------------

loc_11E6A:				; CODE XREF: seg000:1E62j
		cmp	ax, 0FFF6h
		jz	short loc_11E76
		cmp	ax, 0FFF5h
		jz	short loc_11E7A
		jmp	short loc_11E5F
; ---------------------------------------------------------------------------

loc_11E76:				; CODE XREF: seg000:1E6Dj
		inc	cl
		jmp	short loc_11E5F
; ---------------------------------------------------------------------------

loc_11E7A:				; CODE XREF: seg000:1E72j
		dec	cl
		jns	short loc_11E5F
		jmp	short loc_11EA2
; ---------------------------------------------------------------------------

loc_11E80:				; CODE XREF: seg000:1E5Bj
		mov	ax, si
		sub	ax, 6
		mov	bl, ds:0CDC3h
		xor	bh, bh
		shl	bx, 1
		mov	[bx-323Ch], ax
		inc	byte ptr ds:0CDC3h
		cmp	byte ptr ds:0CDC3h, 20h	; ' '
		jb	short loc_11EA2
		mov	ax, 301h
		jmp	loc_1266B
; ---------------------------------------------------------------------------

loc_11EA2:				; CODE XREF: seg000:1E7Ej seg000:1E9Aj
		jmp	scr_return
; ---------------------------------------------------------------------------

loc_11EA5:				; DATA XREF: seg000:off_11A6Bo
		dec	byte ptr ds:0CDC3h
		jns	short loc_11EB1
		mov	ax, 302h
		jmp	loc_1266B
; ---------------------------------------------------------------------------

loc_11EB1:				; CODE XREF: seg000:1EA9j
		mov	bl, ds:0CDC3h
		xor	bh, bh
		shl	bx, 1
		mov	si, [bx-323Ch]
		jmp	scr_return
; ---------------------------------------------------------------------------

loc_11EC0:				; DATA XREF: seg000:off_11A6Bo
		mov	bl, ds:0CE04h
		xor	bh, bh
		shl	bx, 1
		mov	[bx-31FBh], si
		inc	byte ptr ds:0CE04h
		cmp	byte ptr ds:0CE04h, 20h	; ' '
		jb	short loc_11EDD
		mov	ax, 400h
		jmp	loc_1266B
; ---------------------------------------------------------------------------

loc_11EDD:				; CODE XREF: seg000:1ED5j
		jmp	scr_return
; ---------------------------------------------------------------------------

loc_11EE0:				; DATA XREF: seg000:off_11A6Bo
		mov	cl, 1
		call	sub_11F8C
		or	ch, ch
		jz	short loc_11F01
		mov	bl, ds:0CE04h
		dec	bl
		jns	short loc_11EF7
		mov	ax, 401h
		jmp	loc_1266B
; ---------------------------------------------------------------------------

loc_11EF7:				; CODE XREF: seg000:1EEFj
		xor	bh, bh
		shl	bx, 1
		mov	si, [bx-31FBh]
		jmp	short loc_11F0D
; ---------------------------------------------------------------------------

loc_11F01:				; CODE XREF: seg000:1EE7j
		dec	byte ptr ds:0CE04h
		jns	short loc_11F0D
		mov	ax, 402h
		jmp	loc_1266B
; ---------------------------------------------------------------------------

loc_11F0D:				; CODE XREF: seg000:1EFFj seg000:1F05j
		jmp	scr_return

; =============== S U B	R O U T	I N E =======================================


sub_11F10	proc near		; CODE XREF: seg000:loc_11D0Bp
					; seg000:loc_11D27p ...
		xor	cl, cl

loc_11F12:				; CODE XREF: sub_11F10+13j
					; sub_11F10+17j ...
		call	sub_11F6F
		jb	short locret_11F34
		cmp	ax, 0FFFBh
		jz	short loc_11F2F
		cmp	ax, 0FFFCh
		jz	short loc_11F25

loc_11F21:				; CODE XREF: sub_11F35+Aj
		inc	cl
		jmp	short loc_11F12
; ---------------------------------------------------------------------------

loc_11F25:				; CODE XREF: sub_11F10+Fj
		or	cl, cl
		jnz	short loc_11F12
		inc	byte ptr ds:0CD81h
		clc
		retn
; ---------------------------------------------------------------------------

loc_11F2F:				; CODE XREF: sub_11F10+Aj sub_11F35+Fj
		dec	cl
		jns	short loc_11F12
		clc

locret_11F34:				; CODE XREF: sub_11F10+5j
		retn
sub_11F10	endp


; =============== S U B	R O U T	I N E =======================================


sub_11F35	proc near		; CODE XREF: seg000:loc_11D55p
		xor	cl, cl

loc_11F37:				; CODE XREF: sub_11F35+15j
					; sub_11F35+19j
		call	sub_11F6F
		jb	short locret_11F51
		cmp	ax, 0FFFDh
		jnb	short loc_11F21
		cmp	ax, 0FFFBh
		jz	short loc_11F2F
		jmp	short loc_11F12
; ---------------------------------------------------------------------------
		inc	cl
		jmp	short loc_11F37
; ---------------------------------------------------------------------------
		dec	cl
		jns	short loc_11F37
		clc

locret_11F51:				; CODE XREF: sub_11F35+5j
		retn
sub_11F35	endp


; =============== S U B	R O U T	I N E =======================================


sub_11F52	proc near		; CODE XREF: seg000:loc_11E11p
					; seg000:loc_11E2Bp
		xor	cl, cl

loc_11F54:				; CODE XREF: sub_11F52+11j
					; sub_11F52+15j ...
		call	sub_11F6F
		jb	short locret_11F6E
		cmp	ax, 0FFFAh
		jz	short loc_11F65
		cmp	ax, 0FFF7h
		jz	short loc_11F69
		jmp	short loc_11F54
; ---------------------------------------------------------------------------

loc_11F65:				; CODE XREF: sub_11F52+Aj
		inc	cl
		jmp	short loc_11F54
; ---------------------------------------------------------------------------

loc_11F69:				; CODE XREF: sub_11F52+Fj
		dec	cl
		jns	short loc_11F54
		clc

locret_11F6E:				; CODE XREF: sub_11F52+5j
		retn
sub_11F52	endp


; =============== S U B	R O U T	I N E =======================================


sub_11F6F	proc near		; CODE XREF: seg000:loc_11DCBp
					; seg000:loc_11E5Fp ...
		call	scr_GetByte
		jb	short locret_11F8B
		cmp	al, 0FFh
		jz	short loc_11F81
		or	al, al
		jns	short loc_11F7F
		call	scr_GetByte

loc_11F7F:				; CODE XREF: sub_11F6F+Bj
		jmp	short sub_11F6F
; ---------------------------------------------------------------------------

loc_11F81:				; CODE XREF: sub_11F6F+7j
		xchg	al, ah
		call	scr_GetByte
		or	al, al
		jns	short sub_11F6F
		clc

locret_11F8B:				; CODE XREF: sub_11F6F+3j
		retn
sub_11F6F	endp


; =============== S U B	R O U T	I N E =======================================


sub_11F8C	proc near		; CODE XREF: seg000:1D3Ap seg000:1E56p ...
		xor	ch, ch

loc_11F8E:				; CODE XREF: sub_11F8C+32j
					; sub_11F8C+36j ...
		dec	cl
		js	short loc_11FDC
		call	scr_GetVal_11Bit
		mov	bx, ax
		mov	ah, [bx-650Ah]
		call	scr_GetByte
		jb	short loc_11FDE
		mov	dl, al
		call	scr_GetByte
		jb	short loc_11FDE
		or	dl, dl
		jz	short loc_11FBC
		cmp	dl, 1
		jz	short loc_11FC4
		cmp	dl, 2
		jz	short loc_11FCC
		cmp	dl, 3
		jz	short loc_11FD4
		jmp	short loc_11FDE
; ---------------------------------------------------------------------------

loc_11FBC:				; CODE XREF: sub_11F8C+1Dj
		cmp	ah, al
		jnz	short loc_11F8E
		mov	ch, 0FFh
		jmp	short loc_11F8E
; ---------------------------------------------------------------------------

loc_11FC4:				; CODE XREF: sub_11F8C+22j
		cmp	ah, al
		jbe	short loc_11F8E
		mov	ch, 0FFh
		jmp	short loc_11F8E
; ---------------------------------------------------------------------------

loc_11FCC:				; CODE XREF: sub_11F8C+27j
		cmp	ah, al
		jnb	short loc_11F8E
		mov	ch, 0FFh
		jmp	short loc_11F8E
; ---------------------------------------------------------------------------

loc_11FD4:				; CODE XREF: sub_11F8C+2Cj
		cmp	ah, al
		jz	short loc_11F8E
		mov	ch, 0FFh
		jmp	short loc_11F8E
; ---------------------------------------------------------------------------

loc_11FDC:				; CODE XREF: sub_11F8C+4j
		clc
		retn
; ---------------------------------------------------------------------------

loc_11FDE:				; CODE XREF: sub_11F8C+12j
					; sub_11F8C+19j ...
		stc
		retn
sub_11F8C	endp

; ---------------------------------------------------------------------------

loc_11FE0:				; DATA XREF: seg000:off_11A91o
		mov	byte ptr ds:0A527h, 0
		mov	byte ptr ds:0A528h, 0
		mov	byte ptr ds:0A52Dh, 0
		call	sub_1271C
		jmp	scr_return
; ---------------------------------------------------------------------------

loc_11FF5:				; DATA XREF: seg000:off_11A91o
		mov	byte ptr ds:0A527h, 0
		mov	byte ptr ds:0A528h, 0
		mov	byte ptr ds:0A52Dh, 0
		call	sub_12810
		jmp	scr_return
; ---------------------------------------------------------------------------

loc_1200A:				; DATA XREF: seg000:off_11A91o
		call	sub_129F4
		jmp	scr_return
; ---------------------------------------------------------------------------

loc_12010:				; DATA XREF: seg000:off_11A91o
		call	sub_126ED
		jmp	scr_return
; ---------------------------------------------------------------------------

loc_12016:				; DATA XREF: seg000:off_11A91o
		call	scr_GetVal_7Bit
		mov	ds:0A522h, al
		jmp	scr_return
; ---------------------------------------------------------------------------

loc_1201F:				; DATA XREF: seg000:off_11A91o
		mov	di, 0A2F6h
		call	scr_GetVal_7Bit
		and	ax, 0Fh
		shl	ax, 5
		add	di, ax
		mov	cx, 1Fh

loc_12030:				; CODE XREF: seg000:2038j
		call	scr_GetByte
		or	al, al
		jz	short loc_12041
		stosb
		loop	loc_12030

loc_1203A:				; CODE XREF: seg000:203Fj
		call	scr_GetByte
		or	al, al
		jnz	short loc_1203A

loc_12041:				; CODE XREF: seg000:2035j
		xor	al, al
		stosb
		jmp	scr_return
; ---------------------------------------------------------------------------

loc_12047:				; DATA XREF: seg000:off_11A91o
		call	scr_GetVal_14Bit
		mov	cx, ax
		jcxz	short loc_12067

loc_1204E:				; CODE XREF: seg000:2065j
		call	sub_10C85
		test	ax, 0C000h
		jnz	short loc_12067
		cmp	byte ptr ds:0A2F3h, 0
		jnz	short loc_12062
		test	ax, 1120h
		jnz	short loc_12067

loc_12062:				; CODE XREF: seg000:205Bj
		call	sub_10C27
		loop	loc_1204E

loc_12067:				; CODE XREF: seg000:204Cj seg000:2054j ...
		jmp	scr_return
; ---------------------------------------------------------------------------

loc_1206A:				; DATA XREF: seg000:off_11A91o
		call	scr_GetVal_7Bit
		xor	ah, ah
		push	ax
		call	scr_GetVal_14Bit
		shl	ax, 4
		mov	di, ax
		shl	ax, 2
		add	di, ax
		pop	ax
		add	di, ax
		call	scr_GetVal_7Bit
		and	al, 0Fh
		mov	bl, al
		call	scr_GetVal_7Bit
		and	al, 0Fh
		mov	bh, al

loc_1208E:				; CODE XREF: seg000:20A3j
		call	scr_GetByte
		or	al, al
		jz	short loc_120A5
		js	short loc_1209B
		xor	ah, ah
		jmp	short loc_120A0
; ---------------------------------------------------------------------------

loc_1209B:				; CODE XREF: seg000:2095j
		xchg	al, ah
		call	scr_GetByte

loc_120A0:				; CODE XREF: seg000:2099j
		call	sub_14980
		jmp	short loc_1208E
; ---------------------------------------------------------------------------

loc_120A5:				; CODE XREF: seg000:2093j
		jmp	scr_return
; ---------------------------------------------------------------------------

loc_120A8:				; DATA XREF: seg000:off_11A91o
		call	scr_GetVal_7Bit
		call	sub_12B7D
		jmp	scr_return
; ---------------------------------------------------------------------------

loc_120B1:				; DATA XREF: seg000:off_11AA3o
		mov	word ptr ds:0A537h, 0A539h
		jmp	scr_return
; ---------------------------------------------------------------------------

loc_120BA:				; DATA XREF: seg000:off_11AA3o
		mov	di, ds:0A537h
		call	scr_GetVal_7Bit
		stosb
		mov	al, 2Fh	; '/'
		stosb

loc_120C5:				; CODE XREF: seg000:20CDj
		call	scr_GetByte
		or	al, al
		jz	short loc_120CF
		stosb
		jmp	short loc_120C5
; ---------------------------------------------------------------------------

loc_120CF:				; CODE XREF: seg000:20CAj
		stosb
		mov	ds:0A537h, di
		jmp	scr_return
; ---------------------------------------------------------------------------

loc_120D7:				; DATA XREF: seg000:off_11AA3o
		call	scr_GetVal_11Bit
		push	ax
		push	si
		mov	di, ds:0A537h
		mov	al, 0FFh
		stosb
		mov	si, 0A539h
		call	sub_143B3
		mov	dh, ds:0A526h
		mov	dl, 28h	; '('
		mov	ch, 0FFh
		mov	cl, ds:0A529h
		mov	bl, 14h
		mov	al, 0
		call	sub_14407

loc_120FC:				; CODE XREF: seg000:2101j
		call	sub_14698
		cmp	al, 0FFh
		jz	short loc_120FC
		call	sub_148B0
		push	ax

loc_12107:				; CODE XREF: seg000:210Cj seg000:2114j ...
		call	sub_14C11
		test	al, 3
		jnz	short loc_12107
		call	sub_10C85
		test	ax, 30h
		jnz	short loc_12107
		pop	ax
		pop	si
		pop	bx
		and	al, 7Fh
		mov	[bx-650Ah], al
		mov	byte ptr ds:0A527h, 0
		mov	byte ptr ds:0A528h, 0
		mov	byte ptr ds:0A52Dh, 0
		jmp	scr_return
; ---------------------------------------------------------------------------

loc_12131:				; DATA XREF: seg000:off_11AA3o
		call	scr_GetVal_11Bit
		push	ax
		call	scr_GetVal_7Bit
		mov	dl, al
		call	scr_GetVal_7Bit
		mov	dh, al
		push	si
		mov	di, ds:0A537h
		mov	al, 0FFh
		stosb
		mov	si, 0A539h
		call	sub_143B3
		mov	ch, 0FFh
		mov	cl, 0FFh
		mov	bl, 14h
		mov	al, 3
		call	sub_14407

loc_12158:				; CODE XREF: seg000:215Dj
		call	sub_14698
		cmp	al, 0FFh
		jz	short loc_12158
		call	sub_148B0
		push	ax
		call	sub_14C11
		test	al, 3
		jnz	short loc_12107
		call	sub_10C85
		test	ax, 30h
		jnz	short loc_12107
		pop	ax
		pop	si
		pop	bx
		and	al, 7Fh
		mov	[bx-650Ah], al
		jmp	scr_return
; ---------------------------------------------------------------------------

loc_1217E:				; DATA XREF: seg000:off_11AABo
		call	sub_121FD
		xor	di, di
		xor	dh, dh
		mov	dl, 1
		mov	ax, cs:word_12249
		call	LoadGraphicsFile
		mov	bp, 0FFFFh
		mov	ax, cs:word_1224B
		call	sub_14237
		push	si
		xor	di, di
		xor	si, si
		mov	dx, 190h
		mov	cx, 50h	; 'P'
		mov	bx, 1
		mov	al, cs:byte_1224D
		call	sub_1221B
		pop	si
		jmp	scr_return
; ---------------------------------------------------------------------------

loc_121B1:				; DATA XREF: seg000:off_11AABo
		call	sub_121FD
		call	scr_GetVal_7Bit
		xor	ah, ah
		mov	di, ax
		call	scr_GetVal_14Bit
		mov	cx, 50h	; 'P'
		mul	cx
		add	di, ax
		mov	dh, 0FFh
		mov	dl, 1
		mov	ax, cs:word_12249
		call	LoadGraphicsFile
		mov	bp, 0FFFFh
		mov	ax, cs:word_1224B
		call	sub_14237
		push	si
		mov	si, di
		push	ds
		push	cs:word_112CE
		pop	ds
		mov	dx, ds:3
		mov	cl, ds:2
		xor	ch, ch
		pop	ds
		mov	bx, 1
		mov	al, cs:byte_1224D
		call	sub_1221B
		pop	si
		jmp	scr_return

; =============== S U B	R O U T	I N E =======================================


sub_121FD	proc near		; CODE XREF: seg000:loc_1217Ep
					; seg000:loc_121B1p
		call	scr_GetVal_14Bit
		add	ah, 2
		mov	cs:word_12249, ax
		call	scr_GetVal_14Bit
		and	ax, 7FFh
		mov	cs:word_1224B, ax
		call	scr_GetVal_7Bit
		and	al, 0Fh
		mov	cs:byte_1224D, al
		retn
sub_121FD	endp


; =============== S U B	R O U T	I N E =======================================


sub_1221B	proc near		; CODE XREF: seg000:21AAp seg000:21F6p
		or	al, al
		jz	short loc_12234
		push	ax
		add	al, 4
		or	byte ptr ds:1D18h, 10h
		call	sub_10C39
		mov	ah, ds:0A2EEh
		call	sub_130DE
		pop	ax
		jmp	short loc_12245
; ---------------------------------------------------------------------------

loc_12234:				; CODE XREF: sub_1221B+2j
		or	byte ptr ds:1D18h, 10h
		call	sub_10C39
		xor	al, al
		mov	ah, ds:0A2EEh
		call	sub_130DE

loc_12245:				; CODE XREF: sub_1221B+17j
		call	sub_12334
		retn
sub_1221B	endp

; ---------------------------------------------------------------------------
word_12249	dw 0			; DATA XREF: seg000:2187r seg000:21C9r ...
word_1224B	dw 0			; DATA XREF: seg000:2191r seg000:21D3r ...
byte_1224D	db 0			; DATA XREF: seg000:21A6r seg000:21F2r ...
; ---------------------------------------------------------------------------

loc_1224E:				; DATA XREF: seg000:off_11AABo
		call	scr_GetVal_7Bit
		xor	ah, ah
		xor	di, di
		mov	dx, 190h
		mov	cx, 50h	; 'P'
		mov	bx, ax
		mov	al, 3
		call	sub_130DE
		jmp	scr_return
; ---------------------------------------------------------------------------

loc_12265:				; DATA XREF: seg000:off_11AABo
		call	scr_GetVal_7Bit
		xor	ah, ah
		xor	di, di
		mov	dx, 190h
		mov	cx, 50h	; 'P'
		mov	bx, ax
		mov	al, 4
		call	sub_130DE
		jmp	scr_return
; ---------------------------------------------------------------------------

loc_1227C:				; DATA XREF: seg000:off_11AABo
		call	scr_GetVal_14Bit
		and	ax, 7FFh
		mov	bp, 0FFFFh
		call	sub_14237
		or	byte ptr ds:1D18h, 10h
		call	sub_10C39
		jmp	scr_return
; ---------------------------------------------------------------------------

loc_12293:				; DATA XREF: seg000:off_11AABo
		call	scr_GetVal_14Bit
		and	ax, 7FFh
		mov	ds:0A52Eh, ax
		call	scr_GetVal_14Bit
		and	ax, 7FFh
		mov	ds:0A530h, ax
		call	scr_GetVal_14Bit
		inc	ax
		mov	ds:0A534h, ax
		mov	word ptr ds:0A532h, 0

loc_122B2:				; CODE XREF: seg000:22E3j
		xor	dh, dh
		mov	dl, ds:0A533h
		mov	ah, ds:0A532h
		xor	al, al
		div	word ptr ds:0A534h
		mov	bp, 0FFFFh
		mov	dx, ds:0A530h
		mov	bx, ds:0A52Eh
		call	sub_142CB
		or	byte ptr ds:1D18h, 10h
		call	sub_10C39
		inc	word ptr ds:0A532h
		mov	ax, ds:0A532h
		cmp	ax, ds:0A534h
		jb	short loc_122B2
		mov	bp, 0FFFFh
		mov	ax, ds:0A530h
		call	sub_14237
		or	byte ptr ds:1D18h, 10h
		call	sub_10C39
		jmp	scr_return
; ---------------------------------------------------------------------------

loc_122F9:				; DATA XREF: seg000:off_11AABo
		xor	byte ptr ds:1D23h, 1
		or	byte ptr ds:1D18h, 1
		call	sub_10C39
		jmp	scr_return
; ---------------------------------------------------------------------------

loc_12309:				; DATA XREF: seg000:off_11AABo
		xor	byte ptr ds:1D24h, 1
		mov	al, ds:1D24h
		out	0A6h, al	; Interrupt Controller #2, 8259A
		jmp	scr_return
; ---------------------------------------------------------------------------

loc_12316:				; DATA XREF: seg000:off_11AABo
		push	si
		xor	di, di
		xor	si, si
		mov	dx, 190h
		mov	cx, 50h	; 'P'
		xor	bx, bx
		xor	al, al
		call	sub_130DE
		pop	si
		jmp	scr_return
; ---------------------------------------------------------------------------

loc_1232C:				; DATA XREF: seg000:off_11AABo
		push	si
		call	sub_12334
		pop	si
		jmp	scr_return

; =============== S U B	R O U T	I N E =======================================


sub_12334	proc near		; CODE XREF: sub_1221B:loc_12245p
					; seg000:232Dp
		push	ds
		push	es
		mov	ax, 0A800h
		mov	ds, ax
		assume ds:nothing
		mov	ax, cs:word_112D0
		mov	es, ax
		xor	si, si
		xor	di, di
		mov	cx, 4000h
		rep movsw
		mov	ax, 0B000h
		mov	ds, ax
		assume ds:nothing
		mov	ax, cs:word_112D2
		mov	es, ax
		xor	si, si
		xor	di, di
		mov	cx, 4000h
		rep movsw
		mov	ax, 0B800h
		mov	ds, ax
		assume ds:nothing
		mov	ax, cs:word_112D4
		mov	es, ax
		xor	si, si
		xor	di, di
		mov	cx, 4000h
		rep movsw
		mov	ax, 0E000h
		mov	ds, ax
		assume ds:nothing
		mov	ax, cs:word_112D6
		mov	es, ax
		xor	si, si
		xor	di, di
		mov	cx, 4000h
		rep movsw
		pop	es
		pop	ds
		assume ds:nothing
		retn
sub_12334	endp

; ---------------------------------------------------------------------------

loc_12389:				; DATA XREF: seg000:off_11AABo
		call	scr_GetVal_14Bit
		and	ax, 7FFh
		mov	bp, 0FFFFh
		call	sub_14237
		or	byte ptr ds:1D18h, 10h
		call	sub_10C39
		call	scr_GetVal_7Bit
		or	al, al
		jz	short loc_123A6
		add	al, 4

loc_123A6:				; CODE XREF: seg000:23A2j
		push	ax
		call	scr_GetVal_7Bit
		xor	ah, ah
		mov	di, ax
		call	scr_GetVal_14Bit
		mov	cx, 50h	; 'P'
		mul	cx
		add	di, ax
		call	scr_GetVal_7Bit
		mov	cl, al
		xor	ch, ch
		call	scr_GetVal_14Bit
		mov	dx, ax
		pop	ax
		push	si
		mov	si, di
		mov	bx, 1
		mov	ah, ds:0A2EEh
		call	sub_130DE
		pop	si
		jmp	scr_return
; ---------------------------------------------------------------------------

loc_123D6:				; DATA XREF: seg000:off_11AABo
		push	es
		mov	ax, cs:word_112D0
		mov	es, ax
		xor	di, di
		mov	cx, 4000h
		xor	ax, ax
		rep stosw
		mov	ax, cs:word_112D2
		mov	es, ax
		xor	di, di
		mov	cx, 4000h
		xor	ax, ax
		rep stosw
		mov	ax, cs:word_112D4
		mov	es, ax
		xor	di, di
		mov	cx, 4000h
		xor	ax, ax
		rep stosw
		mov	ax, cs:word_112D6
		mov	es, ax
		xor	di, di
		mov	cx, 4000h
		xor	ax, ax
		rep stosw
		pop	es
		jmp	scr_return
; ---------------------------------------------------------------------------

loc_12417:				; DATA XREF: seg000:off_11AABo
		call	scr_GetVal_7Bit
		mov	bl, al
		xor	bh, bh
		shl	bx, 2
		mov	ax, [bx+1177h]
		mov	cl, [bx+1179h]
		xor	ch, ch
		mov	dl, [bx+117Ah]
		xor	dh, dh
		call	LoadGD1_0708
		jmp	scr_return
; ---------------------------------------------------------------------------

loc_12437:				; DATA XREF: seg000:off_11AC5o
		call	scr_GetVal_7Bit
		call	LoadPlayBGM
		jmp	scr_return
; ---------------------------------------------------------------------------

loc_12440:				; DATA XREF: seg000:off_11AC5o
		call	StopBGM
		jmp	scr_return
; ---------------------------------------------------------------------------

loc_12446:				; DATA XREF: seg000:off_11AC5o
		call	scr_GetVal_14Bit
		call	SoundCall2
		jmp	scr_return
; ---------------------------------------------------------------------------

loc_1244F:				; DATA XREF: seg000:off_11AC5o
		call	scr_GetVal_7Bit
		call	SoundCall4
		jmp	scr_return
; ---------------------------------------------------------------------------

loc_12458:				; DATA XREF: seg000:off_11AC5o
		mov	word ptr ds:1D08h, 0
		jmp	scr_return
; ---------------------------------------------------------------------------

loc_12461:				; DATA XREF: seg000:off_11AC5o
		call	scr_GetVal_14Bit
		mov	ds:0CD39h, ax
		call	scr_GetVal_14Bit
		mov	ds:0CD3Bh, ax
		call	scr_GetVal_14Bit
		mov	ds:0CD3Dh, ax

loc_12473:				; CODE XREF: seg000:2489j
		call	sub_10C85
		test	ax, 0C000h
		jnz	short loc_1248B
		mov	bl, cs:MusicMode
		xor	bh, bh
		shl	bx, 1
		call	cs:off_1248E[bx]
		jb	short loc_12473

loc_1248B:				; CODE XREF: seg000:2479j
		jmp	scr_return
; ---------------------------------------------------------------------------
off_1248E	dw offset sub_12494	; 0 ; DATA XREF: seg000:2484r
		dw offset sub_1249C	; 1
		dw offset sub_124A4	; 2

; =============== S U B	R O U T	I N E =======================================


sub_12494	proc near		; CODE XREF: seg000:2484p
					; DATA XREF: seg000:off_1248Eo
		mov	ax, ds:1D08h
		cmp	ax, ds:0CD39h
		retn
sub_12494	endp


; =============== S U B	R O U T	I N E =======================================


sub_1249C	proc near		; CODE XREF: seg000:2484p
					; DATA XREF: seg000:off_1248Eo
		call	SoundCall3
		cmp	ax, ds:0CD3Bh
		retn
sub_1249C	endp


; =============== S U B	R O U T	I N E =======================================


sub_124A4	proc near		; CODE XREF: seg000:2484p
					; DATA XREF: seg000:off_1248Eo
		call	SoundCall3
		cmp	ax, ds:0CD3Dh
		retn
sub_124A4	endp

; ---------------------------------------------------------------------------

loc_124AC:				; DATA XREF: seg000:off_11AD1o
		call	scr_GetVal_11Bit
		jmp	scr_return
; ---------------------------------------------------------------------------

loc_124B2:				; DATA XREF: seg000:off_11AD1o
		call	scr_GetVal_11Bit
		mov	byte ptr ds:0CE46h, 0FFh
		mov	byte ptr ds:0CE45h, 0
		mov	bx, 115Fh
		mov	cx, [bx]
		add	cx, 34h	; '4'
		mov	dx, [bx+2]
		add	dx, 34h	; '4'
		call	sub_14BF6
		call	sub_14BCA
		jmp	scr_return
; ---------------------------------------------------------------------------

loc_124D6:				; DATA XREF: seg000:off_11AD1o
		call	scr_GetVal_11Bit
		add	ax, 9AF6h
		mov	di, ax
		mov	byte ptr [di], 0

loc_124E1:				; CODE XREF: seg000:25F8j
		call	sub_14C11
		and	al, 3
		push	ax
		call	sub_125FD
		pop	ax
		cmp	bh, ds:0CE46h
		jz	short loc_12506
		mov	ds:0CE46h, bh
		cmp	bh, 0FFh
		jz	short loc_12506
		mov	[di], bh
		mov	byte ptr [di+1], 0
		mov	ds:0CE45h, bh
		or	al, 80h

loc_12506:				; CODE XREF: seg000:24EFj seg000:24F8j
		test	al, 2
		jz	short loc_12516
		mov	bh, ds:0CE45h
		mov	[di], bh
		mov	byte ptr [di+1], 1
		or	al, 80h

loc_12516:				; CODE XREF: seg000:2508j
		test	al, 1
		jz	short loc_12526
		mov	bh, ds:0CE45h
		mov	[di], bh
		mov	byte ptr [di+1], 2
		or	al, 80h

loc_12526:				; CODE XREF: seg000:2518j
		or	al, al
		jns	short loc_1252D
		jmp	loc_125FB
; ---------------------------------------------------------------------------

loc_1252D:				; CODE XREF: seg000:2528j
		call	sub_10C85
		xor	bl, bl
		mov	bh, ds:0CE45h
		test	dx, 1
		jz	short loc_12544
		sub	bh, 3
		jns	short loc_12544
		add	bh, 6

loc_12544:				; CODE XREF: seg000:253Aj seg000:253Fj
		test	dx, 2
		jz	short loc_12555
		add	bh, 3
		cmp	bh, 6
		jb	short loc_12555
		sub	bh, 6

loc_12555:				; CODE XREF: seg000:2548j seg000:2550j
		test	dx, 4
		jz	short loc_1256A
		dec	bh
		jns	short loc_12563
		mov	bh, 2
		jmp	short loc_1256A
; ---------------------------------------------------------------------------

loc_12563:				; CODE XREF: seg000:255Dj
		cmp	bh, 2
		jnz	short loc_1256A
		mov	bh, 5

loc_1256A:				; CODE XREF: seg000:2559j seg000:2561j ...
		test	dx, 8
		jz	short loc_12582
		inc	bh
		cmp	bh, 3
		jnz	short loc_1257B
		xor	bh, bh
		jmp	short loc_12582
; ---------------------------------------------------------------------------

loc_1257B:				; CODE XREF: seg000:2575j
		cmp	bh, 6
		jnz	short loc_12582
		mov	bh, 3

loc_12582:				; CODE XREF: seg000:256Ej seg000:2579j ...
		test	dx, 0Fh
		jz	short loc_125BC
		cmp	byte ptr ds:0CE46h, 0FFh
		jnz	short loc_12591
		xor	bh, bh

loc_12591:				; CODE XREF: seg000:258Dj
		mov	ds:0CE46h, bh
		push	bx
		push	dx
		mov	bl, bh
		and	bx, 0FFh
		shl	bx, 2
		mov	cx, [bx+115Fh]
		add	cx, 34h	; '4'
		mov	dx, [bx+1161h]
		add	dx, 34h	; '4'
		call	sub_14BF6
		pop	dx
		pop	bx
		mov	[di], bh
		mov	byte ptr [di+1], 0
		or	bl, 80h

loc_125BC:				; CODE XREF: seg000:2586j
		test	dx, 10h
		jz	short loc_125CB
		mov	[di], bh
		mov	byte ptr [di+1], 1
		or	bl, 80h

loc_125CB:				; CODE XREF: seg000:25C0j
		test	dx, 20h
		jz	short loc_125DA
		mov	[di], bh
		mov	byte ptr [di+1], 2
		or	bl, 80h

loc_125DA:				; CODE XREF: seg000:25CFj
		test	ax, 0C000h
		jz	short loc_125F0
		mov	byte ptr ds:0CE46h, 0FFh
		xor	bh, bh
		mov	byte ptr [di], 0
		mov	byte ptr [di+1], 0
		or	bl, 80h

loc_125F0:				; CODE XREF: seg000:25DDj
		mov	ds:0CE45h, bh
		or	bl, bl
		js	short loc_125FB
		jmp	loc_124E1
; ---------------------------------------------------------------------------

loc_125FB:				; CODE XREF: seg000:252Aj seg000:25F6j
		jmp	short scr_return

; =============== S U B	R O U T	I N E =======================================


sub_125FD	proc near		; CODE XREF: seg000:24E7p
		mov	bp, 115Fh
		xor	bh, bh

loc_12602:				; CODE XREF: sub_125FD+2Dj
		mov	ax, ds:[bp+0]
		neg	ax
		add	ax, cx
		js	short loc_12622
		cmp	ax, 68h	; 'h'
		jnb	short loc_12622
		mov	ax, ds:[bp+2]
		neg	ax
		add	ax, dx
		js	short loc_12622
		cmp	ax, 68h	; 'h'
		jnb	short loc_12622
		jmp	short locret_1262E
; ---------------------------------------------------------------------------

loc_12622:				; CODE XREF: sub_125FD+Dj
					; sub_125FD+12j ...
		add	bp, 4
		inc	bh
		cmp	bh, 6
		jnz	short loc_12602
		mov	bh, 0FFh

locret_1262E:				; CODE XREF: sub_125FD+23j
		retn
sub_125FD	endp

; ---------------------------------------------------------------------------

loc_1262F:				; DATA XREF: seg000:off_11AD1o
		call	scr_GetVal_11Bit
		call	sub_14BE0
		jmp	short scr_return
; ---------------------------------------------------------------------------

loc_12637:				; DATA XREF: seg000:off_11AD1o
		call	scr_GetVal_11Bit
		mov	bx, ax
		mov	ah, [bx+9AF6h]
		cmp	ah, 6
		jnb	short loc_12653
		xor	al, al
		add	ax, 1000h
		mov	bx, seg	seg001
		mov	bp, 99F6h
		call	WriteFileA

loc_12653:				; CODE XREF: seg000:2643j
		jmp	short $+2
; START	OF FUNCTION CHUNK FOR DoScript

scr_return:				; CODE XREF: DoScript+D7j DoScript+F8j ...
		mov	ds:0A4FEh, si
		jmp	ScriptMainLoop
; END OF FUNCTION CHUNK	FOR DoScript
; ---------------------------------------------------------------------------

loc_1265C:				; CODE XREF: seg000:loc_11C9Dj
		jmp	j_LoadScript
; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR DoScript

loc_1265F:				; CODE XREF: DoScript+6Dj
					; DoScript+E64j
		or	byte ptr ds:1D19h, 80h
		retn
; END OF FUNCTION CHUNK	FOR DoScript
; ---------------------------------------------------------------------------

loc_12665:				; CODE XREF: seg000:loc_11C9Aj
		mov	byte ptr ds:1D1Ah, 0
		retn
; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR DoScript

loc_1266B:				; CODE XREF: DoScript+89j seg000:1CD2j ...
		push	seg seg001
		pop	es
		assume es:seg001
		mov	di, 1149h
		mov	dx, ax
		mov	cx, 4

loc_12677:				; CODE XREF: DoScript+E40j
		rol	dx, 4
		mov	bx, dx
		and	bx, 0Fh
		mov	al, cs:[bx+26ABh]
		stosb
		loop	loc_12677
		call	sub_14BE0
		mov	si, 1147h
		call	sub_143B3
		mov	dh, 28h	; '('
		mov	dl, 28h	; '('
		mov	ch, 0FFh
		mov	cl, 0FFh
		mov	bl, 10h
		mov	al, 2
		call	sub_14407

loc_1269F:				; CODE XREF: DoScript+E5Fj
		call	sub_14698
		cmp	al, 0FFh
		jz	short loc_1269F
		call	sub_148B0
		jmp	short loc_1265F
; END OF FUNCTION CHUNK	FOR DoScript
; ---------------------------------------------------------------------------
		xor	[bx+di], dh
		xor	dh, [bp+di]
		xor	al, 35h
		db	36h
		aaa
		cmp	[bx+di], bh
		inc	cx
		inc	dx
		inc	bx
		inc	sp
		inc	bp
		inc	si

; =============== S U B	R O U T	I N E =======================================


scr_GetVal_7Bit	proc near		; CODE XREF: seg000:1AE0p seg000:1B04p ...
		call	scr_GetByte
		and	al, 7Fh
		retn
scr_GetVal_7Bit	endp


; =============== S U B	R O U T	I N E =======================================


scr_GetVal_14Bit proc near		; CODE XREF: seg000:loc_12047p
					; seg000:2070p	...
		call	scr_GetWord
		shl	al, 1
		shr	ax, 1
		and	ax, 3FFFh
		retn
scr_GetVal_14Bit endp


; =============== S U B	R O U T	I N E =======================================


scr_GetVal_11Bit proc near		; CODE XREF: seg000:loc_11ADBp
					; seg000:loc_11AEAp ...
		call	scr_GetWord
		shl	al, 1
		shr	ax, 1
		and	ax, 7FFh
		retn
scr_GetVal_11Bit endp


; =============== S U B	R O U T	I N E =======================================


scr_GetVal_16Bit proc near		; CODE XREF: seg000:loc_11CA0p
					; seg000:1CBAp	...
		push	dx
		call	scr_GetWord
		shl	al, 1
		shr	ax, 1
		mov	dx, ax
		call	scr_GetByte
		shl	al, 6
		or	dh, al
		mov	ax, dx
		pop	dx
		retn
scr_GetVal_16Bit endp


; =============== S U B	R O U T	I N E =======================================


sub_126ED	proc near		; CODE XREF: DoScript+155p
					; DoScript+175p ...
		push	ax
		push	cx
		push	dx

loc_126F0:				; CODE XREF: sub_126ED+15j
		call	sub_14C11
		test	al, 3
		jnz	short loc_12704
		call	sub_10C85
		test	ax, 0D000h
		jnz	short loc_12718
		test	ax, 30h
		jz	short loc_126F0

loc_12704:				; CODE XREF: sub_126ED+8j
					; sub_126ED+1Cj ...
		call	sub_14C11
		test	al, 3
		jnz	short loc_12704
		call	sub_10C85
		test	ax, 0D000h
		jnz	short loc_12718
		test	ax, 30h
		jnz	short loc_12704

loc_12718:				; CODE XREF: sub_126ED+10j
					; sub_126ED+24j
		pop	dx
		pop	cx
		pop	ax
		retn
sub_126ED	endp


; =============== S U B	R O U T	I N E =======================================


sub_1271C	proc near		; CODE XREF: seg000:1FEFp
		push	ds
		push	es
		push	si
		push	seg seg001
		pop	ds
		assume ds:seg001
		mov	di, 5DC0h
		mov	si, 0AA39h
		call	sub_10C27
		mov	cx, 190h
		call	sub_12783
		mov	cx, 28h	; '('

loc_12735:				; CODE XREF: sub_1271C+5Bj
		push	cx
		mov	cx, 2
		call	sub_12783
		push	ds
		push	si
		mov	bx, 24h	; '$'
		mov	cs:word_129F2, di
		call	sub_12848
		mov	cs:word_129F2, di
		pop	si
		pop	ds
		assume ds:nothing
		mov	cx, 2
		call	sub_12783
		mov	cx, 2
		call	sub_12783
		push	ds
		push	si
		mov	bx, 24h	; '$'
		mov	cs:word_129F2, di
		call	sub_128E0
		mov	cs:word_129F2, di
		pop	si
		pop	ds
		mov	cx, 2
		call	sub_12783
		pop	cx
		loop	loc_12735
		mov	cx, 190h
		call	sub_12783
		pop	si
		pop	es
		assume es:nothing
		pop	ds
		retn
sub_1271C	endp


; =============== S U B	R O U T	I N E =======================================


sub_12783	proc near		; CODE XREF: sub_1271C+13p
					; sub_1271C+1Dp ...
		mov	dx, [si]
		mov	ax, [si+2]
		not	ax
		or	dx, ax
		mov	ax, [si+4]
		not	ax
		or	dx, ax
		or	dx, [si+6]
		mov	bp, dx
		not	bp
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		mov	ax, cs:word_112D0
		mov	ds, ax
		mov	bx, [di]
		and	bx, bp
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		lodsw
		and	ax, dx
		or	ax, bx
		mov	es:[di], ax
		mov	ax, 0B000h
		mov	es, ax
		assume es:nothing
		mov	ax, cs:word_112D2
		mov	ds, ax
		assume ds:nothing
		mov	bx, [di]
		and	bx, bp
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		lodsw
		and	ax, dx
		or	ax, bx
		mov	es:[di], ax
		mov	ax, 0B800h
		mov	es, ax
		assume es:nothing
		mov	ax, cs:word_112D4
		mov	ds, ax
		assume ds:nothing
		mov	bx, [di]
		and	bx, bp
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		lodsw
		and	ax, dx
		or	ax, bx
		mov	es:[di], ax
		mov	ax, 0E000h
		mov	es, ax
		assume es:nothing
		mov	ax, cs:word_112D6
		mov	ds, ax
		assume ds:nothing
		mov	bx, [di]
		and	bx, bp
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		lodsw
		and	ax, dx
		or	ax, bx
		stosw
		loop	loc_1280C
		jmp	short locret_1280F
; ---------------------------------------------------------------------------

loc_1280C:				; CODE XREF: sub_12783+85j
		jmp	sub_12783
; ---------------------------------------------------------------------------

locret_1280F:				; CODE XREF: sub_12783+87j
		retn
sub_12783	endp


; =============== S U B	R O U T	I N E =======================================


sub_12810	proc near		; CODE XREF: DoScript+158p
					; DoScript+178p ...
		push	ds
		push	es
		push	si
		mov	ax, ds:0A523h
		mov	cs:word_129F2, ax
		mov	bl, ds:0A529h
		xor	bh, bh
		shr	bx, 1
		mov	al, 0Ah
		mul	byte ptr ds:0A52Ah
		mov	dx, ax
		call	sub_10C27

loc_1282D:				; CODE XREF: sub_12810+32j
		push	dx
		call	sub_12848
		add	cs:word_129F2, 50h ; 'P'
		call	sub_128E0
		add	cs:word_129F2, 50h ; 'P'
		pop	dx
		dec	dx
		jnz	short loc_1282D
		pop	si
		pop	es
		assume es:nothing
		pop	ds
		assume ds:nothing
		retn
sub_12810	endp


; =============== S U B	R O U T	I N E =======================================


sub_12848	proc near		; CODE XREF: sub_1271C+2Ap
					; sub_12810+1Ep
		cmp	cs:byte_12BF9, 2
		jb	short loc_12853
		jmp	loc_1298D
; ---------------------------------------------------------------------------

loc_12853:				; CODE XREF: sub_12848+6j
		mov	ax, cs:word_112D0
		mov	ds, ax
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		mov	si, cs:word_129F2
		mov	di, cs:word_129F2
		mov	cx, bx
		cmp	cs:byte_12BF9, 0
		jnz	short loc_1287E

loc_12872:				; CODE XREF: sub_12848+32j
		lodsw
		and	ax, 0AAAAh
		or	ax, 5555h
		stosw
		loop	loc_12872
		jmp	short loc_12885
; ---------------------------------------------------------------------------

loc_1287E:				; CODE XREF: sub_12848+28j
					; sub_12848+3Bj
		lodsw
		and	ax, 0AAAAh
		stosw
		loop	loc_1287E

loc_12885:				; CODE XREF: sub_12848+34j
		mov	ax, cs:word_112D2
		mov	ds, ax
		mov	ax, 0B000h
		mov	es, ax
		assume es:nothing
		mov	si, cs:word_129F2
		mov	di, cs:word_129F2
		mov	cx, bx

loc_1289C:				; CODE XREF: sub_12848+59j
		lodsw
		and	ax, 0AAAAh
		stosw
		loop	loc_1289C
		mov	ax, cs:word_112D4
		mov	ds, ax
		mov	ax, 0B800h
		mov	es, ax
		assume es:nothing
		mov	si, cs:word_129F2
		mov	di, cs:word_129F2
		mov	cx, bx

loc_128BA:				; CODE XREF: sub_12848+77j
		lodsw
		and	ax, 0AAAAh
		stosw
		loop	loc_128BA
		mov	ax, cs:word_112D6
		mov	ds, ax
		mov	ax, 0E000h
		mov	es, ax
		assume es:nothing
		mov	si, cs:word_129F2
		mov	di, cs:word_129F2
		mov	cx, bx

loc_128D8:				; CODE XREF: sub_12848+95j
		lodsw
		and	ax, 0AAAAh
		stosw
		loop	loc_128D8
		retn
sub_12848	endp


; =============== S U B	R O U T	I N E =======================================


sub_128E0	proc near		; CODE XREF: sub_1271C+4Ap
					; sub_12810+27p
		cmp	cs:byte_12BF9, 2
		jb	short loc_128EB
		jmp	loc_1298D
; ---------------------------------------------------------------------------

loc_128EB:				; CODE XREF: sub_128E0+6j
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		mov	di, cs:word_129F2
		mov	cx, bx
		cmp	cs:byte_12BF9, 0
		jnz	short loc_12970
		mov	ax, cs:word_112D0
		mov	ds, ax
		mov	si, cs:word_129F2

loc_1290A:				; CODE XREF: sub_128E0+32j
		lodsw
		and	ax, 5555h
		or	ax, 0AAAAh
		stosw
		loop	loc_1290A
		mov	ax, cs:word_112D2
		mov	ds, ax
		mov	ax, 0B000h
		mov	es, ax
		assume es:nothing
		mov	si, cs:word_129F2
		mov	di, cs:word_129F2
		mov	cx, bx

loc_1292B:				; CODE XREF: sub_128E0+50j
		lodsw
		and	ax, 5555h
		stosw
		loop	loc_1292B
		mov	ax, cs:word_112D4
		mov	ds, ax
		mov	ax, 0B800h
		mov	es, ax
		assume es:nothing
		mov	si, cs:word_129F2
		mov	di, cs:word_129F2
		mov	cx, bx

loc_12949:				; CODE XREF: sub_128E0+6Ej
		lodsw
		and	ax, 5555h
		stosw
		loop	loc_12949
		mov	ax, cs:word_112D6
		mov	ds, ax
		mov	ax, 0E000h
		mov	es, ax
		assume es:nothing
		mov	si, cs:word_129F2
		mov	di, cs:word_129F2
		mov	cx, bx

loc_12967:				; CODE XREF: sub_128E0+8Cj
		lodsw
		and	ax, 5555h
		stosw
		loop	loc_12967
		jmp	short locret_1298C
; ---------------------------------------------------------------------------

loc_12970:				; CODE XREF: sub_128E0+1Dj
		mov	al, 80h	; 'Ä'
		mov	cs:byte_112C3, al
		out	7Ch, al
		xor	al, al
		out	7Eh, al
		out	7Eh, al
		out	7Eh, al
		out	7Eh, al
		rep stosw
		xor	al, al
		mov	cs:byte_112C3, al
		out	7Ch, al

locret_1298C:				; CODE XREF: sub_128E0+8Ej
		retn
; ---------------------------------------------------------------------------

loc_1298D:				; CODE XREF: sub_12848+8j sub_128E0+8j
		mov	ax, cs:word_112D0
		mov	ds, ax
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		mov	si, cs:word_129F2
		mov	di, cs:word_129F2
		mov	cx, bx
		rep movsw
		mov	ax, cs:word_112D2
		mov	ds, ax
		mov	ax, 0B000h
		mov	es, ax
		assume es:nothing
		mov	si, cs:word_129F2
		mov	di, cs:word_129F2
		mov	cx, bx
		rep movsw
		mov	ax, cs:word_112D4
		mov	ds, ax
		mov	ax, 0B800h
		mov	es, ax
		assume es:nothing
		mov	si, cs:word_129F2
		mov	di, cs:word_129F2
		mov	cx, bx
		rep movsw
		mov	ax, cs:word_112D6
		mov	ds, ax
		mov	ax, 0E000h
		mov	es, ax
		assume es:nothing
		mov	si, cs:word_129F2
		mov	di, cs:word_129F2
		mov	cx, bx
		rep movsw
		retn
sub_128E0	endp

; ---------------------------------------------------------------------------
word_129F2	dw 0			; DATA XREF: sub_1271C+25w
					; sub_1271C+2Dw ...

; =============== S U B	R O U T	I N E =======================================


sub_129F4	proc near		; CODE XREF: seg000:loc_1200Ap
		push	ds
		push	es
		push	si
		mov	bp, 5DC0h
		mov	dx, 64h	; 'd'
		call	sub_10C27

loc_12A00:				; CODE XREF: sub_129F4+60j
		mov	ax, cs:word_112D0
		mov	ds, ax
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		mov	si, bp
		mov	di, bp
		mov	cx, 28h	; '('
		rep movsw
		mov	ax, cs:word_112D2
		mov	ds, ax
		mov	ax, 0B000h
		mov	es, ax
		assume es:nothing
		mov	si, bp
		mov	di, bp
		mov	cx, 28h	; '('
		rep movsw
		mov	ax, cs:word_112D4
		mov	ds, ax
		mov	ax, 0B800h
		mov	es, ax
		assume es:nothing
		mov	si, bp
		mov	di, bp
		mov	cx, 28h	; '('
		rep movsw
		mov	ax, cs:word_112D6
		mov	ds, ax
		mov	ax, 0E000h
		mov	es, ax
		assume es:nothing
		mov	si, bp
		mov	di, bp
		mov	cx, 28h	; '('
		rep movsw
		add	bp, 50h	; 'P'
		dec	dx
		jnz	short loc_12A00
		pop	si
		pop	es
		assume es:nothing
		pop	ds
		retn
sub_129F4	endp


; =============== S U B	R O U T	I N E =======================================


scr_GetByte	proc near		; CODE XREF: DoScript+81p DoScript+9Ep ...
		cmp	word ptr ds:0A500h, 0
		jnz	short loc_12A72
		push	ds
		push	cs:word_112CC
		pop	ds
		lodsb
		pop	ds
		cmp	si, ds:0A4FCh
		jnb	short loc_12A75
		jmp	short loc_12A73
; ---------------------------------------------------------------------------

loc_12A72:				; CODE XREF: scr_GetByte+5j
		lodsb

loc_12A73:				; CODE XREF: scr_GetByte+16j
		clc
		retn
; ---------------------------------------------------------------------------

loc_12A75:				; CODE XREF: scr_GetByte+14j
		stc
		retn
scr_GetByte	endp


; =============== S U B	R O U T	I N E =======================================


scr_GetWord	proc near		; CODE XREF: scr_GetVal_14Bitp
					; scr_GetVal_11Bitp ...
		cmp	word ptr ds:0A500h, 0
		jnz	short loc_12A8F
		push	ds
		push	cs:word_112CC
		pop	ds
		lodsw
		pop	ds
		cmp	si, ds:0A4FCh
		jnb	short loc_12A92
		jmp	short loc_12A90
; ---------------------------------------------------------------------------

loc_12A8F:				; CODE XREF: scr_GetWord+5j
		lodsw

loc_12A90:				; CODE XREF: scr_GetWord+16j
		clc
		retn
; ---------------------------------------------------------------------------

loc_12A92:				; CODE XREF: scr_GetWord+14j
		stc
		retn
scr_GetWord	endp


; =============== S U B	R O U T	I N E =======================================


sub_12A94	proc near		; CODE XREF: DoScript:loc_119B3p
		push	si
		push	ax
		mov	di, ds:0A523h
		mov	al, ds:0A528h
		xor	ah, ah
		mov	cx, 640h
		mul	cx
		add	di, ax
		mov	dl, ds:0A527h
		xor	dh, dh
		add	di, dx
		mov	bx, ds:0A52Bh
		pop	ax
		call	sub_14980
		mov	dl, ds:0A527h
		mov	dh, ds:0A528h
		xor	al, al
		or	ah, ah
		jz	short loc_12AC6
		inc	dl

loc_12AC6:				; CODE XREF: sub_12A94+2Ej
		inc	dl
		cmp	dl, ds:0A529h
		jb	short loc_12AEC
		cmp	byte ptr ds:0A52Dh, 0
		jnz	short loc_12AD9
		xor	dl, dl
		jmp	short loc_12AE0
; ---------------------------------------------------------------------------

loc_12AD9:				; CODE XREF: sub_12A94+3Fj
		mov	dl, ds:0A2F4h
		add	dl, 2

loc_12AE0:				; CODE XREF: sub_12A94+43j
		inc	dh
		cmp	dh, ds:0A52Ah
		jb	short loc_12AEC
		xor	dh, dh
		mov	al, 0FFh

loc_12AEC:				; CODE XREF: sub_12A94+38j
					; sub_12A94+52j
		mov	ds:0A527h, dl
		mov	ds:0A528h, dh
		pop	si
		retn
sub_12A94	endp


; =============== S U B	R O U T	I N E =======================================


LoadScript	proc near		; CODE XREF: DoScript:j_LoadScriptp
		push	ds
		push	es
		pusha
		push	seg seg001
		pop	ds
		assume ds:seg001
		mov	bx, cs:word_112CC
		xor	bp, bp
		mov	al, ds:0A2F5h
		and	ax, 7Fh
		call	ReadArcFile_Cmp
		mov	ds:0A4FCh, ax
		mov	word ptr ds:0A4FEh, 0
		mov	word ptr ds:0A500h, 0
		mov	byte ptr ds:0A522h, 0
		mov	byte ptr ds:0A525h, 4
		mov	byte ptr ds:0A526h, 9Bh	; 'õ'
		mov	al, ds:0A526h
		xor	ah, ah
		mov	cx, 0A0h ; '†'
		mul	cx
		mov	dl, ds:0A525h
		xor	dh, dh
		add	ax, dx
		mov	ds:0A523h, ax
		mov	byte ptr ds:0A529h, 48h	; 'H'
		mov	byte ptr ds:0A52Ah, 4
		mov	byte ptr ds:0A527h, 0
		mov	byte ptr ds:0A528h, 0
		mov	word ptr ds:0A52Bh, 20Fh
		mov	byte ptr ds:0A52Dh, 0
		mov	word ptr ds:0CD3Fh, 0
		mov	byte ptr ds:0CD81h, 0
		mov	byte ptr ds:0CD82h, 0
		mov	byte ptr ds:0CDC3h, 0
		mov	byte ptr ds:0CE04h, 0
		popa
		pop	es
		pop	ds
		assume ds:nothing
		retn
LoadScript	endp


; =============== S U B	R O U T	I N E =======================================


sub_12B7D	proc near		; CODE XREF: DoScript+2p seg000:20ABp
		push	ds
		push	es
		pusha
		mov	cs:byte_12BF9, al
		cmp	al, 2
		jnb	short loc_12BC6	; AX >=	2 -> use previously loaded image
		or	al, al
		jnz	short loc_12B91
		mov	ax, 203h	; AX ==	0 -> archive 02h (TWGD1), file 03h
		jmp	short loc_12B94
; ---------------------------------------------------------------------------

loc_12B91:				; CODE XREF: sub_12B7D+Dj
		mov	ax, 209h	; AX ==	1 -> archive 02h (TWGD1), file 09h

loc_12B94:				; CODE XREF: sub_12B7D+12j
		xor	di, di
		mov	dh, 0FFh
		mov	dl, 1
		call	LoadGraphicsFile
		push	seg seg001
		pop	es
		assume es:seg001
		mov	di, 0AA39h
		xor	si, si
		call	sub_12BCD
		mov	si, 320h
		mov	cx, 50h

loc_12BAF:				; CODE XREF: sub_12B7D+41j
		call	sub_12BD6
		call	sub_12BD6
		add	si, 48h
		call	sub_12BD6
		call	sub_12BD6
		loop	loc_12BAF
		mov	si, 1C20h
		call	sub_12BCD

loc_12BC6:				; CODE XREF: sub_12B7D+9j
		call	sub_12BFA
		popa
		pop	es
		assume es:nothing
		pop	ds
		retn
sub_12B7D	endp


; =============== S U B	R O U T	I N E =======================================


sub_12BCD	proc near		; CODE XREF: sub_12B7D+29p
					; sub_12B7D+46p
		mov	cx, 190h

loc_12BD0:				; CODE XREF: sub_12BCD+6j
		call	sub_12BD6
		loop	loc_12BD0
		retn
sub_12BCD	endp


; =============== S U B	R O U T	I N E =======================================


sub_12BD6	proc near		; CODE XREF: sub_12B7D:loc_12BAFp
					; sub_12B7D+35p ...
		mov	ax, cs:word_112D0
		mov	ds, ax
		mov	ax, [si]
		stosw
		mov	ax, cs:word_112D2
		mov	ds, ax
		mov	ax, [si]
		stosw
		mov	ax, cs:word_112D4
		mov	ds, ax
		mov	ax, [si]
		stosw
		mov	ax, cs:word_112D6
		mov	ds, ax
		movsw
		retn
sub_12BD6	endp

; ---------------------------------------------------------------------------
byte_12BF9	db 0			; DATA XREF: sub_12848r sub_12848+22r	...

; =============== S U B	R O U T	I N E =======================================


sub_12BFA	proc near		; CODE XREF: sub_12B7D:loc_12BC6p
		push	es
		push	ax
		push	cx
		push	di
		mov	ax, cs:word_112D0
		mov	es, ax
		mov	cx, 4000h
		call	sub_12C33
		mov	ax, cs:word_112D2
		mov	es, ax
		mov	cx, 4000h
		call	sub_12C33
		mov	ax, cs:word_112D4
		mov	es, ax
		mov	cx, 4000h
		call	sub_12C33
		mov	ax, cs:word_112D6
		mov	es, ax
		mov	cx, 4000h
		call	sub_12C33
		pop	di
		pop	cx
		pop	ax
		pop	es
		retn
sub_12BFA	endp


; =============== S U B	R O U T	I N E =======================================


sub_12C33	proc near		; CODE XREF: sub_12BFA+Dp
					; sub_12BFA+19p ...
		xor	di, di
		xor	ax, ax
		rep stosw
		retn
sub_12C33	endp


; =============== S U B	R O U T	I N E =======================================


sub_12C3A	proc near		; CODE XREF: sub_11363+1F5p
					; sub_11363+26Ap

; FUNCTION CHUNK AT 2E6C SIZE 0000005A BYTES

		push	ds
		push	es
		pusha
		push	ds
		push	si
		mov	ax, seg	seg001
		mov	es, ax
		assume es:seg001
		mov	di, 0CE49h
		mov	cx, 20h	; ' '
		rep movsb
		mov	ds, ax
		assume ds:seg001
		mov	ax, 207h
		xor	cx, cx
		mov	dx, 1Eh
		call	LoadGD1_0708
		mov	ax, 3
		mov	bp, 0FFFFh
		call	sub_14237
		or	byte ptr ds:1D18h, 50h
		call	sub_10C39
		xor	di, di
		xor	dh, dh
		mov	dl, 1
		mov	ax, 20Ah
		call	LoadGraphicsFile
		xor	di, di
		xor	si, si
		mov	dx, 190h
		mov	cx, 50h	; 'P'
		mov	bx, 2
		mov	al, 5
		call	sub_130DE
		push	ds
		mov	si, 605Ch
		mov	di, 0CE74h
		mov	cx, 11h

loc_12C92:				; CODE XREF: sub_12C3A+92j
		mov	ax, cs:word_112D0
		mov	ds, ax
		assume ds:nothing
		mov	ax, [si]
		mov	es:[di+4], ah
		stosb
		mov	ax, cs:word_112D2
		mov	ds, ax
		mov	ax, [si]
		mov	es:[di+4], ah
		stosb
		mov	ax, cs:word_112D4
		mov	ds, ax
		mov	ax, [si]
		mov	es:[di+4], ah
		stosb
		mov	ax, cs:word_112D6
		mov	ds, ax
		mov	ax, [si]
		mov	es:[di+4], ah
		stosb
		add	di, 4
		add	si, 50h	; 'P'
		loop	loc_12C92
		pop	ds
		assume ds:seg001
		call	sub_12EC6
		mov	si, 0CE49h
		xor	dl, dl
		mov	cx, 10h

loc_12CDA:				; CODE XREF: sub_12C3A+A7j
		lodsw
		or	ax, ax
		jz	short loc_12CE3
		inc	dl
		loop	loc_12CDA

loc_12CE3:				; CODE XREF: sub_12C3A+A3j
		mov	ds:0CE48h, dl
		mov	cx, 18h
		mov	dx, 30h	; '0'
		call	sub_14BF6
		mov	byte ptr ds:0CE6Ch, 0FFh
		mov	byte ptr ds:0CE6Dh, 0FFh
		mov	byte ptr ds:0CE6Fh, 3
		mov	byte ptr ds:0CE70h, 0
		call	sub_14BCA

loc_12D07:				; CODE XREF: sub_12C3A:loc_12E93j
		call	sub_14C11
		mov	ds:0CE69h, al
		mov	bx, offset byte_1682B
		mov	bp, offset byte_16384

loc_12D13:				; CODE XREF: sub_12C3A+12Fj
		mov	al, ds:[bp+0]
		cmp	al, 0FFh
		jz	short loc_12D6B
		xor	ah, ah
		shl	ax, 3
		cmp	ax, cx
		ja	short loc_12D66
		mov	al, ds:[bp+0]
		add	al, ds:[bp+2]
		xor	ah, ah
		shl	ax, 3
		cmp	ax, cx
		jbe	short loc_12D66
		mov	al, ds:[bp+1]
		xlat
		xor	ah, ah
		dec	ax
		cmp	ax, dx
		ja	short loc_12D66
		add	ax, 12h
		cmp	ax, dx
		jbe	short loc_12D66
		mov	al, ds:[bp+0]
		mov	ds:0CE6Fh, al
		mov	al, ds:[bp+1]
		mov	ds:0CE70h, al
		mov	al, ds:[bp+2]
		mov	ds:0CE71h, al
		mov	ax, ds:[bp+3]
		mov	ds:0CE72h, ax
		jmp	short loc_12D6B
; ---------------------------------------------------------------------------

loc_12D66:				; CODE XREF: sub_12C3A+E8j
					; sub_12C3A+F9j ...
		add	bp, 5
		jmp	short loc_12D13
; ---------------------------------------------------------------------------

loc_12D6B:				; CODE XREF: sub_12C3A+DFj
					; sub_12C3A+12Aj
		call	sub_10C85
		mov	ds:0CE6Ah, dx
		test	word ptr ds:0CE6Ah, 1
		jz	short loc_12D87
		dec	byte ptr ds:0CE70h
		jns	short loc_12D85
		mov	byte ptr ds:0CE70h, 8

loc_12D85:				; CODE XREF: sub_12C3A+144j
		xor	dl, dl

loc_12D87:				; CODE XREF: sub_12C3A+13Ej
		test	word ptr ds:0CE6Ah, 2
		jz	short loc_12DA1
		inc	byte ptr ds:0CE70h
		cmp	byte ptr ds:0CE70h, 8
		jbe	short loc_12D9F
		mov	byte ptr ds:0CE70h, 0

loc_12D9F:				; CODE XREF: sub_12C3A+15Ej
		xor	dl, dl

loc_12DA1:				; CODE XREF: sub_12C3A+153j
		test	word ptr ds:0CE6Ah, 4
		jz	short loc_12DAB
		mov	dl, 0FFh

loc_12DAB:				; CODE XREF: sub_12C3A+16Dj
		test	word ptr ds:0CE6Ah, 8
		jz	short loc_12DB5
		mov	dl, 1

loc_12DB5:				; CODE XREF: sub_12C3A+177j
		test	word ptr ds:0CE6Ah, 0Fh
		jz	short loc_12DD8
		call	sub_12FB6
		mov	cl, ds:0CE6Fh
		xor	ch, ch
		shl	cx, 3
		mov	bl, ds:0CE70h
		xor	bh, bh
		mov	dl, byte_1682B[bx]
		xor	dh, dh
		call	sub_14BF6

loc_12DD8:				; CODE XREF: sub_12C3A+181j
		mov	al, ds:0CE6Fh
		mov	ah, ds:0CE70h
		cmp	al, ds:0CE6Ch
		jnz	short loc_12DEB
		cmp	ah, ds:0CE6Dh
		jz	short loc_12E2B

loc_12DEB:				; CODE XREF: sub_12C3A+1A9j
		call	sub_14BE0
		call	sub_10C27
		mov	al, ds:0CE6Ch
		mov	ah, ds:0CE6Dh
		mov	cl, ds:0CE6Eh
		cmp	ax, 0FFFFh
		jz	short loc_12E07
		mov	dx, 504Fh
		call	sub_1302C

loc_12E07:				; CODE XREF: sub_12C3A+1C5j
		mov	al, ds:0CE6Fh
		mov	ds:0CE6Ch, al
		mov	ah, ds:0CE70h
		mov	ds:0CE6Dh, ah
		mov	cl, ds:0CE71h
		mov	ds:0CE6Eh, cl
		cmp	ax, 0FFFFh
		jz	short loc_12E28
		mov	dx, 5F4h
		call	sub_1302C

loc_12E28:				; CODE XREF: sub_12C3A+1E6j
		call	sub_14BCA

loc_12E2B:				; CODE XREF: sub_12C3A+1AFj
		test	byte ptr ds:0CE69h, 2
		jnz	short loc_12E3A
		test	word ptr ds:0CE6Ah, 10h
		jz	short loc_12E93

loc_12E3A:				; CODE XREF: sub_12C3A+1F6j
		mov	ax, ds:0CE72h
		xchg	al, ah
		cmp	ax, 8740h
		jnz	short loc_12E4D
		cmp	byte ptr ds:0CE48h, 0
		jnz	short loc_12E96
		jmp	short loc_12E93
; ---------------------------------------------------------------------------

loc_12E4D:				; CODE XREF: sub_12C3A+208j
		cmp	ax, 8741h
		jnz	short loc_12E6C
		mov	bl, ds:0CE48h	; CODE XREF: start+4Fp	start+62p
sub_12C3A	endp ; sp-analysis failed

		or	bl, bl
		jz	short loc_12E6A
		dec	bl
		mov	ds:0CE48h, bl
		xor	bh, bh
		shl	bx, 1
		mov	word ptr [bx+0CE49h], 0

loc_12E6A:				; CODE XREF: seg000:2E58j
		jmp	short loc_12E8D
; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_12C3A

loc_12E6C:				; CODE XREF: sub_12C3A+216j
		mov	ax, ds:0CE72h
		mov	bl, ds:0CE48h
		cmp	bl, 6
		jnz	short loc_12E7A
		dec	bl

loc_12E7A:				; CODE XREF: sub_12C3A+23Cj
		xor	bh, bh
		shl	bx, 1
		mov	[bx-31B7h], ax
		mov	al, ds:0CE48h
		cmp	al, 6
		jz	short loc_12E8D
		inc	byte ptr ds:0CE48h

loc_12E8D:				; CODE XREF: seg000:loc_12E6Aj
					; sub_12C3A+24Dj
		call	sub_12EC6
		call	sub_10C68

loc_12E93:				; CODE XREF: sub_12C3A+1FEj
					; sub_12C3A+211j
		jmp	loc_12D07
; ---------------------------------------------------------------------------

loc_12E96:				; CODE XREF: sub_12C3A+20Fj
		call	sub_14BE0
		xor	di, di
		mov	dx, 190h
		mov	cx, 50h	; 'P'
		mov	bx, 2
		mov	al, 3
		call	sub_130DE
		mov	ax, 208h
		xor	cx, cx
		mov	dx, 1Eh
		call	LoadGD1_0708
		push	seg seg001
		pop	ds
		mov	si, 0CE49h
		pop	di
		pop	es
		assume es:nothing
		mov	cx, 20h	; ' '
		rep movsb
		popa
		pop	es
		pop	ds
		assume ds:nothing
		retn
; END OF FUNCTION CHUNK	FOR sub_12C3A

; =============== S U B	R O U T	I N E =======================================


sub_12EC6	proc near		; CODE XREF: sub_12C3A+95p
					; sub_12C3A:loc_12E8Dp
		call	sub_10C27
		call	sub_14BE0
		push	es
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		mov	si, 0CE49h
		mov	di, 605Ch
		mov	bx, 504h
		mov	cx, 6

loc_12EDE:				; CODE XREF: sub_12EC6:loc_12EF2j
		lodsw
		or	ax, ax
		jz	short loc_12EEF
		push	ax
		call	sub_12EF9
		pop	ax
		xchg	al, ah
		call	sub_14980
		jmp	short loc_12EF2
; ---------------------------------------------------------------------------

loc_12EEF:				; CODE XREF: sub_12EC6+1Bj
		call	sub_12F78

loc_12EF2:				; CODE XREF: sub_12EC6+27j
		loop	loc_12EDE
		pop	es
		assume es:nothing
		call	sub_14BCA
		retn
sub_12EC6	endp


; =============== S U B	R O U T	I N E =======================================


sub_12EF9	proc near		; CODE XREF: sub_12EC6+1Ep
		mov	al, 80h	; 'Ä'
		mov	cs:byte_112C3, al
		out	7Ch, al
		mov	al, 55h	; 'U'
		out	7Eh, al
		mov	al, 0AAh ; '™'
		out	7Eh, al
		xor	al, al
		out	7Eh, al
		out	7Eh, al
		mov	es:[di], ax
		mov	es:[di+0A0h], ax
		mov	es:[di+140h], ax
		mov	es:[di+1E0h], ax
		mov	es:[di+280h], ax
		mov	es:[di+320h], ax
		mov	es:[di+3C0h], ax
		mov	es:[di+460h], ax
		mov	es:[di+500h], ax
		mov	al, 0AAh ; '™'
		out	7Eh, al
		mov	al, 55h	; 'U'
		out	7Eh, al
		xor	al, al
		out	7Eh, al
		out	7Eh, al
		mov	es:[di+50h], ax
		mov	es:[di+0F0h], ax
		mov	es:[di+190h], ax
		mov	es:[di+230h], ax
		mov	es:[di+2D0h], ax
		mov	es:[di+370h], ax
		mov	es:[di+410h], ax
		mov	es:[di+4B0h], ax
		xor	al, al
		mov	cs:byte_112C3, al
		out	7Ch, al
		retn
sub_12EF9	endp


; =============== S U B	R O U T	I N E =======================================


sub_12F78	proc near		; CODE XREF: sub_12EC6:loc_12EEFp
		push	cx
		push	si
		push	di
		mov	al, 80h	; 'Ä'
		mov	cs:byte_112C3, al
		out	7Ch, al
		mov	si, 0CE74h
		mov	cx, 11h

loc_12F89:				; CODE XREF: sub_12F78+2Ej
		lodsb
		out	7Eh, al
		lodsb
		out	7Eh, al
		lodsb
		out	7Eh, al
		lodsb
		out	7Eh, al
		stosb
		lodsb
		out	7Eh, al
		lodsb
		out	7Eh, al
		lodsb
		out	7Eh, al
		lodsb
		out	7Eh, al
		stosb
		add	di, 4Eh	; 'N'
		loop	loc_12F89
		xor	al, al
		mov	cs:byte_112C3, al
		out	7Ch, al
		pop	di
		pop	si
		pop	cx
		inc	di
		inc	di
		retn
sub_12F78	endp

		assume ds:seg001

; =============== S U B	R O U T	I N E =======================================


sub_12FB6	proc near		; CODE XREF: sub_12C3A+183p
		mov	bl, ds:0CE70h
		xor	bh, bh
		mov	cl, byte_16834[bx]
		shl	bx, 1
		mov	si, off_1683D[bx]
		mov	bp, si
		xor	ch, ch

loc_12FCA:				; CODE XREF: sub_12FB6+22j
		lodsw
		shr	ax, 3
		cmp	al, ds:0CE6Fh
		jnb	short loc_12FDE
		inc	ch
		cmp	cl, ch
		jnz	short loc_12FCA
		mov	ch, cl
		dec	ch

loc_12FDE:				; CODE XREF: sub_12FB6+1Cj
		mov	bl, ch
		add	bl, dl
		jns	short loc_12FE8
		mov	bl, cl
		dec	bl

loc_12FE8:				; CODE XREF: sub_12FB6+2Cj
		cmp	bl, cl
		jb	short loc_12FEE
		xor	bl, bl

loc_12FEE:				; CODE XREF: sub_12FB6+34j
		xor	bh, bh
		shl	bx, 1
		add	bx, bp
		mov	ax, [bx]
		shr	ax, 3
		mov	ds:0CE6Fh, al
		mov	bp, offset byte_16384

loc_12FFF:				; CODE XREF: sub_12FB6+64j
		mov	al, ds:[bp+0]
		cmp	al, 0FFh
		jz	short locret_1302B
		cmp	al, ds:0CE6Fh
		jnz	short loc_13017
		mov	al, ds:[bp+1]
		cmp	al, ds:0CE70h
		jz	short loc_1301C

loc_13017:				; CODE XREF: sub_12FB6+55j
		add	bp, 5
		jmp	short loc_12FFF
; ---------------------------------------------------------------------------

loc_1301C:				; CODE XREF: sub_12FB6+5Fj
		mov	al, ds:[bp+2]
		mov	ds:0CE71h, al
		mov	ax, ds:[bp+3]
		mov	ds:0CE72h, ax
		retn
; ---------------------------------------------------------------------------

locret_1302B:				; CODE XREF: sub_12FB6+4Fj
		retn
sub_12FB6	endp


; =============== S U B	R O U T	I N E =======================================


sub_1302C	proc near		; CODE XREF: sub_12C3A+1CAp
					; sub_12C3A+1EBp
		mov	bl, ah
		xor	bh, bh
		mov	bl, byte_1682B[bx]
		dec	bx
		shl	bx, 4
		mov	si, bx
		shl	bx, 2
		add	si, bx
		xor	ah, ah
		add	si, ax
		push	ds
		mov	ax, 0A800h
		mov	ds, ax
		assume ds:nothing
		mov	bx, dx
		mov	ch, 12h

loc_1304D:				; CODE XREF: sub_1302C+67j
		push	cx
		push	si
		xor	ch, ch

loc_13051:				; CODE XREF: sub_1302C+5Ej
		mov	dx, bx
		mov	al, 80h	; 'Ä'
		mov	cs:byte_112C3, al
		out	7Ch, al
		call	sub_1309F
		mov	ah, [si]
		mov	al, 0C0h ; '¿'
		mov	cs:byte_112C3, al
		out	7Ch, al
		call	sub_1309F
		mov	[si], ah
		mov	al, 80h	; 'Ä'
		mov	cs:byte_112C3, al
		out	7Ch, al
		call	sub_1309F
		mov	ah, [si]
		mov	al, 0C0h ; '¿'
		mov	cs:byte_112C3, al
		out	7Ch, al
		call	sub_1309F
		mov	[si], ah
		inc	si
		dec	cl
		jnz	short loc_13051
		pop	si
		pop	cx
		add	si, 50h
		dec	ch
		jnz	short loc_1304D
		xor	al, al
		mov	cs:byte_112C3, al
		out	7Ch, al
		pop	ds
		assume ds:nothing
		retn
sub_1302C	endp


; =============== S U B	R O U T	I N E =======================================


sub_1309F	proc near		; CODE XREF: sub_1302C+2Fp
					; sub_1302C+3Cp ...
		xor	al, al
		shr	dx, 1
		sbb	al, 0
		out	7Eh, al
		xor	al, al
		shr	dx, 1
		sbb	al, 0
		out	7Eh, al
		xor	al, al
		shr	dx, 1
		sbb	al, 0
		out	7Eh, al
		xor	al, al
		shr	dx, 1
		sbb	al, 0
		out	7Eh, al
		retn
sub_1309F	endp


; =============== S U B	R O U T	I N E =======================================


LoadGraphicsFile proc near		; CODE XREF: sub_11363+48p
					; sub_1174B+1Ap ...
		push	ds
		push	es
		pusha
		push	seg seg001
		pop	ds
		assume ds:seg001
		mov	bx, cs:word_112CE
		xor	bp, bp
		push	dx
		call	ReadArcFile_Cmp
		pop	ax
		mov	ds, bx
		assume ds:nothing
		mov	si, bp
		call	sub_13F04
		popa
		pop	es
		pop	ds
		retn
LoadGraphicsFile endp


; =============== S U B	R O U T	I N E =======================================


sub_130DE	proc near		; CODE XREF: sub_11363+18p
					; sub_11363+9Ep ...
		push	ds
		push	es
		pusha
		push	seg seg001
		pop	ds
		assume ds:seg001
		mov	ds:0CEFCh, bx
		mov	cs:word_1422F, cx
		mov	cs:word_14231, dx
		mov	bl, ah
		xor	bh, bh
		shl	bx, 1
		mov	cs:word_13123, bx
		mov	bl, al
		and	bx, 0FFh
		shl	bx, 1
		call	cs:off_1310F[bx]
		popa
		pop	es
		pop	ds
		assume ds:nothing
		retn
sub_130DE	endp

; ---------------------------------------------------------------------------
off_1310F	dw offset sub_13125	; 0 ; DATA XREF: sub_130DE+28r
		dw offset sub_13177	; 1
		dw offset sub_131CD	; 2
		dw offset sub_1323C	; 3
		dw offset sub_13241	; 4
		dw offset sub_13246	; 5
		dw offset sub_1324B	; 6
		dw offset sub_13250	; 7
		dw offset nullsub_7	; 8
		dw offset sub_13675	; 9
word_13123	dw 0			; DATA XREF: sub_130DE+1Bw
					; sub_13250+3Cr ...

; =============== S U B	R O U T	I N E =======================================


sub_13125	proc near		; CODE XREF: sub_130DE+28p
					; DATA XREF: seg000:off_1310Fo
		mov	bx, 50h	; 'P'
		sub	bx, cx
		mov	bp, cx
		mov	ax, cs:word_112D0
		mov	ds, ax
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		call	sub_13165
		mov	ax, cs:word_112D2
		mov	ds, ax
		mov	ax, 0B000h
		mov	es, ax
		assume es:nothing
		call	sub_13165
		mov	ax, cs:word_112D4
		mov	ds, ax
		mov	ax, 0B800h
		mov	es, ax
		assume es:nothing
		call	sub_13165
		mov	ax, cs:word_112D6
		mov	ds, ax
		mov	ax, 0E000h
		mov	es, ax
		assume es:nothing
		call	sub_13165
		retn
sub_13125	endp


; =============== S U B	R O U T	I N E =======================================


sub_13165	proc near		; CODE XREF: sub_13125+12p
					; sub_13125+20p ...
		push	dx
		push	si
		push	di

loc_13168:				; CODE XREF: sub_13165+Cj
		mov	cx, bp
		rep movsb
		add	si, bx
		add	di, bx
		dec	dx
		jnz	short loc_13168
		pop	di
		pop	si
		pop	dx
		retn
sub_13165	endp


; =============== S U B	R O U T	I N E =======================================


sub_13177	proc near		; CODE XREF: sub_130DE+28p
					; sub_13177+53j
					; DATA XREF: ...
		mov	ax, cs:word_112D0
		mov	ds, ax
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		push	cx
		push	si
		push	di
		rep movsb
		pop	di
		pop	si
		pop	cx
		mov	ax, cs:word_112D2
		mov	ds, ax
		mov	ax, 0B000h
		mov	es, ax
		assume es:nothing
		push	cx
		push	si
		push	di
		rep movsb
		pop	di
		pop	si
		pop	cx
		mov	ax, cs:word_112D4
		mov	ds, ax
		mov	ax, 0B800h
		mov	es, ax
		assume es:nothing
		push	cx
		push	si
		push	di
		rep movsb
		pop	di
		pop	si
		pop	cx
		mov	ax, cs:word_112D6
		mov	ds, ax
		mov	ax, 0E000h
		mov	es, ax
		assume es:nothing
		push	cx
		push	si
		push	di
		rep movsb
		pop	di
		pop	si
		pop	cx
		add	si, 50h	; 'P'
		add	di, 50h	; 'P'
		dec	dx
		jnz	short sub_13177
		retn
sub_13177	endp


; =============== S U B	R O U T	I N E =======================================


sub_131CD	proc near		; CODE XREF: sub_130DE+28p
					; sub_131CD+6Cj
					; DATA XREF: ...
		push	cx
		mov	ax, cs:word_112D0
		mov	ds, ax
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		push	si
		push	di
		mov	cx, dx

loc_131DD:				; CODE XREF: sub_131CD+17j
		movsb
		add	si, 4Fh	; 'O'
		add	di, 4Fh	; 'O'
		loop	loc_131DD
		pop	di
		pop	si
		mov	ax, cs:word_112D2
		mov	ds, ax
		mov	ax, 0B000h
		mov	es, ax
		assume es:nothing
		push	si
		push	di
		mov	cx, dx

loc_131F7:				; CODE XREF: sub_131CD+31j
		movsb
		add	si, 4Fh	; 'O'
		add	di, 4Fh	; 'O'
		loop	loc_131F7
		pop	di
		pop	si
		mov	ax, cs:word_112D4
		mov	ds, ax
		mov	ax, 0B800h
		mov	es, ax
		assume es:nothing
		push	si
		push	di
		mov	cx, dx

loc_13211:				; CODE XREF: sub_131CD+4Bj
		movsb
		add	si, 4Fh	; 'O'
		add	di, 4Fh	; 'O'
		loop	loc_13211
		pop	di
		pop	si
		mov	ax, cs:word_112D6
		mov	ds, ax
		mov	ax, 0E000h
		mov	es, ax
		assume es:nothing
		push	si
		push	di
		mov	cx, dx

loc_1322B:				; CODE XREF: sub_131CD+65j
		movsb
		add	si, 4Fh	; 'O'
		add	di, 4Fh	; 'O'
		loop	loc_1322B
		pop	di
		pop	si
		inc	si
		inc	di
		pop	cx
		loop	sub_131CD
		retn
sub_131CD	endp


; =============== S U B	R O U T	I N E =======================================


sub_1323C	proc near		; CODE XREF: sub_130DE+28p
					; DATA XREF: seg000:off_1310Fo

; FUNCTION CHUNK AT 3A40 SIZE 00000020 BYTES
; FUNCTION CHUNK AT 3A70 SIZE 00000377 BYTES
; FUNCTION CHUNK AT 3DE9 SIZE 00000119 BYTES

		mov	al, 0
		jmp	loc_13A40
sub_1323C	endp


; =============== S U B	R O U T	I N E =======================================


sub_13241	proc near		; CODE XREF: sub_130DE+28p
					; DATA XREF: seg000:off_1310Fo
		mov	al, 1
		jmp	loc_13A40
sub_13241	endp


; =============== S U B	R O U T	I N E =======================================


sub_13246	proc near		; CODE XREF: sub_130DE+28p
					; DATA XREF: seg000:off_1310Fo
		mov	al, 2
		jmp	loc_13A40
sub_13246	endp


; =============== S U B	R O U T	I N E =======================================


sub_1324B	proc near		; CODE XREF: sub_130DE+28p
					; DATA XREF: seg000:off_1310Fo
		mov	al, 3
		jmp	loc_13A40
sub_1324B	endp


; =============== S U B	R O U T	I N E =======================================


sub_13250	proc near		; CODE XREF: sub_130DE+28p
					; DATA XREF: seg000:off_1310Fo
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		mov	al, 0C0h ; '¿'
		mov	cs:byte_112C3, al
		out	7Ch, al
		mov	bp, 140h
		sub	bp, cs:word_1422F
		xor	bx, bx

loc_13267:				; CODE XREF: sub_13250+67j
		mov	word ptr ds:1D08h, 0
		push	ds
		push	bx
		push	si
		push	di
		mov	al, cs:byte_1421F[bx]
		xor	ah, ah
		add	si, ax
		add	di, ax
		mov	dl, cs:byte_1420F[bx]
		mov	ax, cs:word_14231
		shr	ax, 2
		mov	cs:word_13672, ax
		mov	bx, cs:word_13123

loc_13291:				; CODE XREF: sub_13250+54j
		mov	cx, cs:word_1422F
		call	cs:off_132C2[bx]
		add	si, bp
		add	di, bp
		dec	cs:word_13672
		jnz	short loc_13291
		pop	di
		pop	si
		pop	bx
		pop	ds
		mov	ax, ds:0CEFCh

loc_132AD:				; CODE XREF: sub_13250+61j
		cmp	ax, ds:1D08h
		ja	short loc_132AD
		inc	bx
		cmp	bx, 10h
		jnz	short loc_13267
		xor	al, al
		mov	cs:byte_112C3, al
		out	7Ch, al
		retn
sub_13250	endp

; ---------------------------------------------------------------------------
off_132C2	dw offset sub_132E2	; 0 ; DATA XREF: sub_13250+46r
		dw offset sub_13317	; 1
		dw offset sub_1334E	; 2
		dw offset sub_13385	; 3
		dw offset sub_133BE	; 4
		dw offset sub_133F5	; 5
		dw offset sub_1342E	; 6
		dw offset sub_13467	; 7
		dw offset sub_134A2	; 8
		dw offset sub_134D9	; 9
		dw offset sub_13512	; 0Ah
		dw offset sub_1354B	; 0Bh
		dw offset sub_13586	; 0Ch
		dw offset sub_135BF	; 0Dh
		dw offset sub_135FA	; 0Eh
		dw offset sub_13635	; 0Fh

; =============== S U B	R O U T	I N E =======================================


sub_132E2	proc near		; CODE XREF: sub_13250+46p
					; sub_132E2+32j
					; DATA XREF: ...
		mov	ax, cs:word_112D0
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		mov	dh, al
		mov	ax, cs:word_112D2
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		or	dh, al
		mov	ax, cs:word_112D4
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		or	dh, al
		mov	ax, cs:word_112D6
		mov	ds, ax
		lodsb
		out	7Eh, al
		or	al, dh
		and	al, dl
		stosb
		loop	sub_132E2
		retn
sub_132E2	endp


; =============== S U B	R O U T	I N E =======================================


sub_13317	proc near		; CODE XREF: sub_13250+46p
					; sub_13317+34j
					; DATA XREF: ...
		mov	ax, cs:word_112D0
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		not	al
		mov	dh, al
		mov	ax, cs:word_112D2
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		or	dh, al
		mov	ax, cs:word_112D4
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		or	dh, al
		mov	ax, cs:word_112D6
		mov	ds, ax
		lodsb
		out	7Eh, al
		or	al, dh
		and	al, dl
		stosb
		loop	sub_13317
		retn
sub_13317	endp


; =============== S U B	R O U T	I N E =======================================


sub_1334E	proc near		; CODE XREF: sub_13250+46p
					; sub_1334E+34j
					; DATA XREF: ...
		mov	ax, cs:word_112D0
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		mov	dh, al
		mov	ax, cs:word_112D2
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		not	al
		or	dh, al
		mov	ax, cs:word_112D4
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		or	dh, al
		mov	ax, cs:word_112D6
		mov	ds, ax
		lodsb
		out	7Eh, al
		or	al, dh
		and	al, dl
		stosb
		loop	sub_1334E
		retn
sub_1334E	endp


; =============== S U B	R O U T	I N E =======================================


sub_13385	proc near		; CODE XREF: sub_13250+46p
					; sub_13385+36j
					; DATA XREF: ...
		mov	ax, cs:word_112D0
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		not	al
		mov	dh, al
		mov	ax, cs:word_112D2
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		not	al
		or	dh, al
		mov	ax, cs:word_112D4
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		or	dh, al
		mov	ax, cs:word_112D6
		mov	ds, ax
		lodsb
		out	7Eh, al
		or	al, dh
		and	al, dl
		stosb
		loop	sub_13385
		retn
sub_13385	endp


; =============== S U B	R O U T	I N E =======================================


sub_133BE	proc near		; CODE XREF: sub_13250+46p
					; sub_133BE+34j
					; DATA XREF: ...
		mov	ax, cs:word_112D0
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		mov	dh, al
		mov	ax, cs:word_112D2
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		or	dh, al
		mov	ax, cs:word_112D4
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		not	al
		or	dh, al
		mov	ax, cs:word_112D6
		mov	ds, ax
		lodsb
		out	7Eh, al
		or	al, dh
		and	al, dl
		stosb
		loop	sub_133BE
		retn
sub_133BE	endp


; =============== S U B	R O U T	I N E =======================================


sub_133F5	proc near		; CODE XREF: sub_13250+46p
					; sub_133F5+36j
					; DATA XREF: ...
		mov	ax, cs:word_112D0
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		not	al
		mov	dh, al
		mov	ax, cs:word_112D2
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		or	dh, al
		mov	ax, cs:word_112D4
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		not	al
		or	dh, al
		mov	ax, cs:word_112D6
		mov	ds, ax
		lodsb
		out	7Eh, al
		or	al, dh
		and	al, dl
		stosb
		loop	sub_133F5
		retn
sub_133F5	endp


; =============== S U B	R O U T	I N E =======================================


sub_1342E	proc near		; CODE XREF: sub_13250+46p
					; sub_1342E+36j
					; DATA XREF: ...
		mov	ax, cs:word_112D0
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		mov	dh, al
		mov	ax, cs:word_112D2
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		not	al
		or	dh, al
		mov	ax, cs:word_112D4
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		not	al
		or	dh, al
		mov	ax, cs:word_112D6
		mov	ds, ax
		lodsb
		out	7Eh, al
		or	al, dh
		and	al, dl
		stosb
		loop	sub_1342E
		retn
sub_1342E	endp


; =============== S U B	R O U T	I N E =======================================


sub_13467	proc near		; CODE XREF: sub_13250+46p
					; sub_13467+38j
					; DATA XREF: ...
		mov	ax, cs:word_112D0
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		not	al
		mov	dh, al
		mov	ax, cs:word_112D2
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		not	al
		or	dh, al
		mov	ax, cs:word_112D4
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		not	al
		or	dh, al
		mov	ax, cs:word_112D6
		mov	ds, ax
		lodsb
		out	7Eh, al
		or	al, dh
		and	al, dl
		stosb
		loop	sub_13467
		retn
sub_13467	endp


; =============== S U B	R O U T	I N E =======================================


sub_134A2	proc near		; CODE XREF: sub_13250+46p
					; sub_134A2+34j
					; DATA XREF: ...
		mov	ax, cs:word_112D0
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		mov	dh, al
		mov	ax, cs:word_112D2
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		or	dh, al
		mov	ax, cs:word_112D4
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		or	dh, al
		mov	ax, cs:word_112D6
		mov	ds, ax
		lodsb
		out	7Eh, al
		not	al
		or	al, dh
		and	al, dl
		stosb
		loop	sub_134A2
		retn
sub_134A2	endp


; =============== S U B	R O U T	I N E =======================================


sub_134D9	proc near		; CODE XREF: sub_13250+46p
					; sub_134D9+36j
					; DATA XREF: ...
		mov	ax, cs:word_112D0
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		not	al
		mov	dh, al
		mov	ax, cs:word_112D2
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		or	dh, al
		mov	ax, cs:word_112D4
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		or	dh, al
		mov	ax, cs:word_112D6
		mov	ds, ax
		lodsb
		out	7Eh, al
		not	al
		or	al, dh
		and	al, dl
		stosb
		loop	sub_134D9
		retn
sub_134D9	endp


; =============== S U B	R O U T	I N E =======================================


sub_13512	proc near		; CODE XREF: sub_13250+46p
					; sub_13512+36j
					; DATA XREF: ...
		mov	ax, cs:word_112D0
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		mov	dh, al
		mov	ax, cs:word_112D2
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		not	al
		or	dh, al
		mov	ax, cs:word_112D4
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		or	dh, al
		mov	ax, cs:word_112D6
		mov	ds, ax
		lodsb
		out	7Eh, al
		not	al
		or	al, dh
		and	al, dl
		stosb
		loop	sub_13512
		retn
sub_13512	endp


; =============== S U B	R O U T	I N E =======================================


sub_1354B	proc near		; CODE XREF: sub_13250+46p
					; sub_1354B+38j
					; DATA XREF: ...
		mov	ax, cs:word_112D0
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		not	al
		mov	dh, al
		mov	ax, cs:word_112D2
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		not	al
		or	dh, al
		mov	ax, cs:word_112D4
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		or	dh, al
		mov	ax, cs:word_112D6
		mov	ds, ax
		lodsb
		out	7Eh, al
		not	al
		or	al, dh
		and	al, dl
		stosb
		loop	sub_1354B
		retn
sub_1354B	endp


; =============== S U B	R O U T	I N E =======================================


sub_13586	proc near		; CODE XREF: sub_13250+46p
					; sub_13586+36j
					; DATA XREF: ...
		mov	ax, cs:word_112D0
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		mov	dh, al
		mov	ax, cs:word_112D2
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		or	dh, al
		mov	ax, cs:word_112D4
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		not	al
		or	dh, al
		mov	ax, cs:word_112D6
		mov	ds, ax
		lodsb
		out	7Eh, al
		not	al
		or	al, dh
		and	al, dl
		stosb
		loop	sub_13586
		retn
sub_13586	endp


; =============== S U B	R O U T	I N E =======================================


sub_135BF	proc near		; CODE XREF: sub_13250+46p
					; sub_135BF+38j
					; DATA XREF: ...
		mov	ax, cs:word_112D0
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		not	al
		mov	dh, al
		mov	ax, cs:word_112D2
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		or	dh, al
		mov	ax, cs:word_112D4
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		not	al
		or	dh, al
		mov	ax, cs:word_112D6
		mov	ds, ax
		lodsb
		out	7Eh, al
		not	al
		or	al, dh
		and	al, dl
		stosb
		loop	sub_135BF
		retn
sub_135BF	endp


; =============== S U B	R O U T	I N E =======================================


sub_135FA	proc near		; CODE XREF: sub_13250+46p
					; sub_135FA+38j
					; DATA XREF: ...
		mov	ax, cs:word_112D0
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		mov	dh, al
		mov	ax, cs:word_112D2
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		not	al
		or	dh, al
		mov	ax, cs:word_112D4
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		not	al
		or	dh, al
		mov	ax, cs:word_112D6
		mov	ds, ax
		lodsb
		out	7Eh, al
		not	al
		or	al, dh
		and	al, dl
		stosb
		loop	sub_135FA
		retn
sub_135FA	endp


; =============== S U B	R O U T	I N E =======================================


sub_13635	proc near		; CODE XREF: sub_13250+46p
					; sub_13635+3Aj
					; DATA XREF: ...
		mov	ax, cs:word_112D0
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		not	al
		mov	dh, al
		mov	ax, cs:word_112D2
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		not	al
		or	dh, al
		mov	ax, cs:word_112D4
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		not	al
		or	dh, al
		mov	ax, cs:word_112D6
		mov	ds, ax
		lodsb
		out	7Eh, al
		not	al
		or	al, dh
		and	al, dl
		stosb
		loop	sub_13635
		retn
sub_13635	endp

; ---------------------------------------------------------------------------
word_13672	dw 0			; DATA XREF: sub_13250+38w
					; sub_13250+4Fw

; =============== S U B	R O U T	I N E =======================================


nullsub_7	proc near		; CODE XREF: sub_130DE+28p
					; DATA XREF: seg000:off_1310Fo
		retn
nullsub_7	endp


; =============== S U B	R O U T	I N E =======================================


sub_13675	proc near		; CODE XREF: sub_130DE+28p
					; DATA XREF: seg000:off_1310Fo
		mov	ax, 0A800h
		mov	es, ax
		mov	al, 0C0h ; '¿'
		mov	cs:byte_112C3, al
		out	7Ch, al
		mov	bp, 50h	; 'P'
		sub	bp, cs:word_1422F
		mov	bx, cs:word_14231

loc_1368F:				; CODE XREF: sub_13675+30j
		mov	cx, cs:word_1422F
		push	bx
		mov	bx, cs:word_13123
		call	cs:off_136B0[bx]
		pop	bx
		add	si, bp
		add	di, bp
		dec	bx
		jnz	short loc_1368F
		xor	al, al
		mov	cs:byte_112C3, al
		out	7Ch, al
		retn
sub_13675	endp

; ---------------------------------------------------------------------------
off_136B0	dw offset sub_136D0	; 0 ; DATA XREF: sub_13675+25r
		dw offset sub_13703	; 1
		dw offset sub_13738	; 2
		dw offset sub_1376D	; 3
		dw offset sub_137A4	; 4
		dw offset sub_137D9	; 5
		dw offset sub_13810	; 6
		dw offset sub_13847	; 7
		dw offset sub_13880	; 8
		dw offset sub_138B5	; 9
		dw offset sub_138EC	; 0Ah
		dw offset sub_13923	; 0Bh
		dw offset sub_1395C	; 0Ch
		dw offset sub_13993	; 0Dh
		dw offset sub_139CC	; 0Eh
		dw offset sub_13A05	; 0Fh

; =============== S U B	R O U T	I N E =======================================


sub_136D0	proc near		; CODE XREF: sub_13675+25p
					; sub_136D0+30j
					; DATA XREF: ...
		mov	ax, cs:word_112D0
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		mov	dh, al
		mov	ax, cs:word_112D2
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		or	dh, al
		mov	ax, cs:word_112D4
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		or	dh, al
		mov	ax, cs:word_112D6
		mov	ds, ax
		lodsb
		out	7Eh, al
		or	al, dh
		stosb
		loop	sub_136D0
		retn
sub_136D0	endp


; =============== S U B	R O U T	I N E =======================================


sub_13703	proc near		; CODE XREF: sub_13675+25p
					; sub_13703+32j
					; DATA XREF: ...
		mov	ax, cs:word_112D0
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		not	al
		mov	dh, al
		mov	ax, cs:word_112D2
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		or	dh, al
		mov	ax, cs:word_112D4
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		or	dh, al
		mov	ax, cs:word_112D6
		mov	ds, ax
		lodsb
		out	7Eh, al
		or	al, dh
		stosb
		loop	sub_13703
		retn
sub_13703	endp


; =============== S U B	R O U T	I N E =======================================


sub_13738	proc near		; CODE XREF: sub_13675+25p
					; sub_13738+32j
					; DATA XREF: ...
		mov	ax, cs:word_112D0
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		mov	dh, al
		mov	ax, cs:word_112D2
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		not	al
		or	dh, al
		mov	ax, cs:word_112D4
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		or	dh, al
		mov	ax, cs:word_112D6
		mov	ds, ax
		lodsb
		out	7Eh, al
		or	al, dh
		stosb
		loop	sub_13738
		retn
sub_13738	endp


; =============== S U B	R O U T	I N E =======================================


sub_1376D	proc near		; CODE XREF: sub_13675+25p
					; sub_1376D+34j
					; DATA XREF: ...
		mov	ax, cs:word_112D0
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		not	al
		mov	dh, al
		mov	ax, cs:word_112D2
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		not	al
		or	dh, al
		mov	ax, cs:word_112D4
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		or	dh, al
		mov	ax, cs:word_112D6
		mov	ds, ax
		lodsb
		out	7Eh, al
		or	al, dh
		stosb
		loop	sub_1376D
		retn
sub_1376D	endp


; =============== S U B	R O U T	I N E =======================================


sub_137A4	proc near		; CODE XREF: sub_13675+25p
					; sub_137A4+32j
					; DATA XREF: ...
		mov	ax, cs:word_112D0
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		mov	dh, al
		mov	ax, cs:word_112D2
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		or	dh, al
		mov	ax, cs:word_112D4
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		not	al
		or	dh, al
		mov	ax, cs:word_112D6
		mov	ds, ax
		lodsb
		out	7Eh, al
		or	al, dh
		stosb
		loop	sub_137A4
		retn
sub_137A4	endp


; =============== S U B	R O U T	I N E =======================================


sub_137D9	proc near		; CODE XREF: sub_13675+25p
					; sub_137D9+34j
					; DATA XREF: ...
		mov	ax, cs:word_112D0
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		not	al
		mov	dh, al
		mov	ax, cs:word_112D2
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		or	dh, al
		mov	ax, cs:word_112D4
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		not	al
		or	dh, al
		mov	ax, cs:word_112D6
		mov	ds, ax
		lodsb
		out	7Eh, al
		or	al, dh
		stosb
		loop	sub_137D9
		retn
sub_137D9	endp


; =============== S U B	R O U T	I N E =======================================


sub_13810	proc near		; CODE XREF: sub_13675+25p
					; sub_13810+34j
					; DATA XREF: ...
		mov	ax, cs:word_112D0
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		mov	dh, al
		mov	ax, cs:word_112D2
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		not	al
		or	dh, al
		mov	ax, cs:word_112D4
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		not	al
		or	dh, al
		mov	ax, cs:word_112D6
		mov	ds, ax
		lodsb
		out	7Eh, al
		or	al, dh
		stosb
		loop	sub_13810
		retn
sub_13810	endp


; =============== S U B	R O U T	I N E =======================================


sub_13847	proc near		; CODE XREF: sub_13675+25p
					; sub_13847+36j
					; DATA XREF: ...
		mov	ax, cs:word_112D0
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		not	al
		mov	dh, al
		mov	ax, cs:word_112D2
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		not	al
		or	dh, al
		mov	ax, cs:word_112D4
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		not	al
		or	dh, al
		mov	ax, cs:word_112D6
		mov	ds, ax
		lodsb
		out	7Eh, al
		or	al, dh
		stosb
		loop	sub_13847
		retn
sub_13847	endp


; =============== S U B	R O U T	I N E =======================================


sub_13880	proc near		; CODE XREF: sub_13675+25p
					; sub_13880+32j
					; DATA XREF: ...
		mov	ax, cs:word_112D0
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		mov	dh, al
		mov	ax, cs:word_112D2
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		or	dh, al
		mov	ax, cs:word_112D4
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		or	dh, al
		mov	ax, cs:word_112D6
		mov	ds, ax
		lodsb
		out	7Eh, al
		not	al
		or	al, dh
		stosb
		loop	sub_13880
		retn
sub_13880	endp


; =============== S U B	R O U T	I N E =======================================


sub_138B5	proc near		; CODE XREF: sub_13675+25p
					; sub_138B5+34j
					; DATA XREF: ...
		mov	ax, cs:word_112D0
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		not	al
		mov	dh, al
		mov	ax, cs:word_112D2
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		or	dh, al
		mov	ax, cs:word_112D4
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		or	dh, al
		mov	ax, cs:word_112D6
		mov	ds, ax
		lodsb
		out	7Eh, al
		not	al
		or	al, dh
		stosb
		loop	sub_138B5
		retn
sub_138B5	endp


; =============== S U B	R O U T	I N E =======================================


sub_138EC	proc near		; CODE XREF: sub_13675+25p
					; sub_138EC+34j
					; DATA XREF: ...
		mov	ax, cs:word_112D0
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		mov	dh, al
		mov	ax, cs:word_112D2
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		not	al
		or	dh, al
		mov	ax, cs:word_112D4
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		or	dh, al
		mov	ax, cs:word_112D6
		mov	ds, ax
		lodsb
		out	7Eh, al
		not	al
		or	al, dh
		stosb
		loop	sub_138EC
		retn
sub_138EC	endp


; =============== S U B	R O U T	I N E =======================================


sub_13923	proc near		; CODE XREF: sub_13675+25p
					; sub_13923+36j
					; DATA XREF: ...
		mov	ax, cs:word_112D0
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		not	al
		mov	dh, al
		mov	ax, cs:word_112D2
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		not	al
		or	dh, al
		mov	ax, cs:word_112D4
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		or	dh, al
		mov	ax, cs:word_112D6
		mov	ds, ax
		lodsb
		out	7Eh, al
		not	al
		or	al, dh
		stosb
		loop	sub_13923
		retn
sub_13923	endp


; =============== S U B	R O U T	I N E =======================================


sub_1395C	proc near		; CODE XREF: sub_13675+25p
					; sub_1395C+34j
					; DATA XREF: ...
		mov	ax, cs:word_112D0
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		mov	dh, al
		mov	ax, cs:word_112D2
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		or	dh, al
		mov	ax, cs:word_112D4
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		not	al
		or	dh, al
		mov	ax, cs:word_112D6
		mov	ds, ax
		lodsb
		out	7Eh, al
		not	al
		or	al, dh
		stosb
		loop	sub_1395C
		retn
sub_1395C	endp


; =============== S U B	R O U T	I N E =======================================


sub_13993	proc near		; CODE XREF: sub_13675+25p
					; sub_13993+36j
					; DATA XREF: ...
		mov	ax, cs:word_112D0
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		not	al
		mov	dh, al
		mov	ax, cs:word_112D2
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		or	dh, al
		mov	ax, cs:word_112D4
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		not	al
		or	dh, al
		mov	ax, cs:word_112D6
		mov	ds, ax
		lodsb
		out	7Eh, al
		not	al
		or	al, dh
		stosb
		loop	sub_13993
		retn
sub_13993	endp


; =============== S U B	R O U T	I N E =======================================


sub_139CC	proc near		; CODE XREF: sub_13675+25p
					; sub_139CC+36j
					; DATA XREF: ...
		mov	ax, cs:word_112D0
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		mov	dh, al
		mov	ax, cs:word_112D2
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		not	al
		or	dh, al
		mov	ax, cs:word_112D4
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		not	al
		or	dh, al
		mov	ax, cs:word_112D6
		mov	ds, ax
		lodsb
		out	7Eh, al
		not	al
		or	al, dh
		stosb
		loop	sub_139CC
		retn
sub_139CC	endp


; =============== S U B	R O U T	I N E =======================================


sub_13A05	proc near		; CODE XREF: sub_13675+25p
					; sub_13A05+38j
					; DATA XREF: ...
		mov	ax, cs:word_112D0
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		not	al
		mov	dh, al
		mov	ax, cs:word_112D2
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		not	al
		or	dh, al
		mov	ax, cs:word_112D4
		mov	ds, ax
		mov	al, [si]
		out	7Eh, al
		not	al
		or	dh, al
		mov	ax, cs:word_112D6
		mov	ds, ax
		lodsb
		out	7Eh, al
		not	al
		or	al, dh
		stosb
		loop	sub_13A05
		retn
sub_13A05	endp

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_1323C

loc_13A40:				; CODE XREF: sub_1323C+2j sub_13241+2j ...
		push	seg seg001
		pop	ds
		assume ds:seg001
		mov	bx, 140h
		sub	bx, cs:word_1422F
		mov	bp, ax
		and	bp, 0FFh
		shr	cs:word_1422F, 1
		rcl	bp, 1
		shl	bp, 1
		jmp	cs:off_13A60[bp]
; END OF FUNCTION CHUNK	FOR sub_1323C
; ---------------------------------------------------------------------------
off_13A60	dw offset loc_13A70	; 0 ; DATA XREF: sub_1323C+81Fr
		dw offset loc_13A74	; 1
		dw offset loc_13A78	; 2
		dw offset loc_13A7C	; 3
		dw offset loc_13B55	; 4
		dw offset loc_13C1C	; 5
		dw offset loc_13CF3	; 6
		dw offset loc_13DE9	; 7
; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_1323C

loc_13A70:				; CODE XREF: sub_1323C+81Fj
					; DATA XREF: seg000:off_13A60o
		xor	ah, ah
		jmp	short loc_13A80
; ---------------------------------------------------------------------------

loc_13A74:				; CODE XREF: sub_1323C+81Fj
					; DATA XREF: seg000:off_13A60o
		xor	ah, ah
		jmp	short loc_13AEA
; ---------------------------------------------------------------------------

loc_13A78:				; CODE XREF: sub_1323C+81Fj
					; DATA XREF: seg000:off_13A60o
		mov	ah, 0FFh
		jmp	short loc_13A80
; ---------------------------------------------------------------------------

loc_13A7C:				; CODE XREF: sub_1323C+81Fj
					; DATA XREF: seg000:off_13A60o
		mov	ah, 0FFh
		jmp	short loc_13AEA
; ---------------------------------------------------------------------------

loc_13A80:				; CODE XREF: sub_1323C+836j
					; sub_1323C+83Ej
		mov	al, 0C0h ; '¿'
		mov	cs:byte_112C3, al
		out	7Ch, al
		mov	al, ah
		cli
		out	7Eh, al
		out	7Eh, al
		out	7Eh, al
		out	7Eh, al
		sti
		mov	ax, 0A800h
		mov	es, ax
		xor	bp, bp

loc_13A9B:				; CODE XREF: sub_1323C+8A3j
		mov	word ptr ds:1D08h, 0
		push	si
		push	di
		push	bp
		mov	al, cs:byte_1421F[bp]
		xor	ah, ah
		add	si, ax
		add	di, ax
		mov	al, cs:byte_1420F[bp]
		mov	ah, al
		mov	bp, cs:word_14231
		shr	bp, 2

loc_13ABE:				; CODE XREF: sub_1323C+891j
		mov	cs:word_14235, di
		mov	cx, cs:word_1422F
		rep stosw
		add	di, bx
		dec	bp
		jnz	short loc_13ABE
		pop	bp
		pop	di
		pop	si
		mov	ax, ds:0CEFCh

loc_13AD5:				; CODE XREF: sub_1323C+89Dj
		cmp	ax, ds:1D08h
		ja	short loc_13AD5
		inc	bp
		cmp	bp, 10h
		jnz	short loc_13A9B
		xor	al, al
		mov	cs:byte_112C3, al
		out	7Ch, al
		retn
; ---------------------------------------------------------------------------

loc_13AEA:				; CODE XREF: sub_1323C+83Aj
					; sub_1323C+842j
		mov	al, 0C0h ; '¿'
		mov	cs:byte_112C3, al
		out	7Ch, al
		mov	al, ah
		cli
		out	7Eh, al
		out	7Eh, al
		out	7Eh, al
		out	7Eh, al
		sti
		mov	ax, 0A800h
		mov	es, ax
		xor	bp, bp

loc_13B05:				; CODE XREF: sub_1323C+90Ej
		mov	word ptr ds:1D08h, 0
		push	si
		push	di
		push	bp
		mov	al, cs:byte_1421F[bp]
		xor	ah, ah
		add	si, ax
		add	di, ax
		mov	al, cs:byte_1420F[bp]
		mov	ah, al
		mov	bp, cs:word_14231
		shr	bp, 2

loc_13B28:				; CODE XREF: sub_1323C+8FCj
		mov	cs:word_14235, di
		mov	cx, cs:word_1422F
		rep stosw
		stosb
		add	di, bx
		dec	bp
		jnz	short loc_13B28
		pop	bp
		pop	di
		pop	si
		mov	ax, ds:0CEFCh

loc_13B40:				; CODE XREF: sub_1323C+908j
		cmp	ax, ds:1D08h
		ja	short loc_13B40
		inc	bp
		cmp	bp, 10h
		jnz	short loc_13B05
		xor	al, al
		mov	cs:byte_112C3, al
		out	7Ch, al
		retn
; ---------------------------------------------------------------------------

loc_13B55:				; CODE XREF: sub_1323C+81Fj
					; DATA XREF: seg000:off_13A60o
		xor	bp, bp

loc_13B57:				; CODE XREF: sub_1323C+9DCj
		mov	word ptr ds:1D08h, 0
		push	ds
		push	si
		push	di
		push	bp
		mov	al, cs:byte_1421F[bp]
		xor	ah, ah
		add	si, ax
		add	di, ax
		mov	dl, cs:byte_1420F[bp]
		mov	dh, dl
		mov	bp, cs:word_14231
		shr	bp, 2

loc_13B7B:				; CODE XREF: sub_1323C+9C6j
		mov	ax, cs:word_112D0
		mov	ds, ax
		assume ds:nothing
		mov	ax, 0A800h
		mov	es, ax
		mov	cs:word_14233, si
		mov	cs:word_14235, di
		mov	cx, cs:word_1422F

loc_13B95:				; CODE XREF: sub_1323C+95Dj
		lodsw
		and	ax, dx
		stosw
		loop	loc_13B95
		mov	ax, cs:word_112D2
		mov	ds, ax
		mov	ax, 0B000h
		mov	es, ax
		assume es:nothing
		mov	si, cs:word_14233
		mov	di, cs:word_14235
		mov	cx, cs:word_1422F

loc_13BB5:				; CODE XREF: sub_1323C+97Dj
		lodsw
		and	ax, dx
		stosw
		loop	loc_13BB5
		mov	ax, cs:word_112D4
		mov	ds, ax
		mov	ax, 0B800h
		mov	es, ax
		assume es:nothing
		mov	si, cs:word_14233
		mov	di, cs:word_14235
		mov	cx, cs:word_1422F

loc_13BD5:				; CODE XREF: sub_1323C+99Dj
		lodsw
		and	ax, dx
		stosw
		loop	loc_13BD5
		mov	ax, cs:word_112D6
		mov	ds, ax
		mov	ax, 0E000h
		mov	es, ax
		assume es:nothing
		mov	si, cs:word_14233
		mov	di, cs:word_14235
		mov	cx, cs:word_1422F

loc_13BF5:				; CODE XREF: sub_1323C+9BDj
		lodsw
		and	ax, dx
		stosw
		loop	loc_13BF5
		add	si, bx
		add	di, bx
		dec	bp
		jz	short loc_13C05
		jmp	loc_13B7B
; ---------------------------------------------------------------------------

loc_13C05:				; CODE XREF: sub_1323C+9C4j
		pop	bp
		pop	di
		pop	si
		pop	ds
		mov	ax, ds:0CEFCh

loc_13C0C:				; CODE XREF: sub_1323C+9D4j
		cmp	ax, ds:1D08h
		ja	short loc_13C0C
		inc	bp
		cmp	bp, 10h
		jz	short locret_13C1B
		jmp	loc_13B57
; ---------------------------------------------------------------------------

locret_13C1B:				; CODE XREF: sub_1323C+9DAj
		retn
; ---------------------------------------------------------------------------

loc_13C1C:				; CODE XREF: sub_1323C+81Fj
					; DATA XREF: seg000:off_13A60o
		xor	bp, bp

loc_13C1E:				; CODE XREF: sub_1323C+AB3j
		mov	word ptr ds:1D08h, 0
		push	ds
		push	si
		push	di
		push	bp
		mov	al, cs:byte_1421F[bp]
		xor	ah, ah
		add	si, ax
		add	di, ax
		mov	dl, cs:byte_1420F[bp]
		mov	dh, dl
		mov	bp, cs:word_14231
		shr	bp, 2

loc_13C42:				; CODE XREF: sub_1323C+A9Dj
		mov	ax, cs:word_112D0
		mov	ds, ax
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		mov	cs:word_14233, si
		mov	cs:word_14235, di
		mov	cx, cs:word_1422F

loc_13C5C:				; CODE XREF: sub_1323C+A24j
		lodsw
		and	ax, dx
		stosw
		loop	loc_13C5C
		lodsb
		and	al, dl
		stosb
		mov	ax, cs:word_112D2
		mov	ds, ax
		mov	ax, 0B000h
		mov	es, ax
		assume es:nothing
		mov	si, cs:word_14233
		mov	di, cs:word_14235
		mov	cx, cs:word_1422F

loc_13C80:				; CODE XREF: sub_1323C+A48j
		lodsw
		and	ax, dx
		stosw
		loop	loc_13C80
		lodsb
		and	al, dl
		stosb
		mov	ax, cs:word_112D4
		mov	ds, ax
		mov	ax, 0B800h
		mov	es, ax
		assume es:nothing
		mov	si, cs:word_14233
		mov	di, cs:word_14235
		mov	cx, cs:word_1422F

loc_13CA4:				; CODE XREF: sub_1323C+A6Cj
		lodsw
		and	ax, dx
		stosw
		loop	loc_13CA4
		lodsb
		and	al, dl
		stosb
		mov	ax, cs:word_112D6
		mov	ds, ax
		mov	ax, 0E000h
		mov	es, ax
		assume es:nothing
		mov	si, cs:word_14233
		mov	di, cs:word_14235
		mov	cx, cs:word_1422F

loc_13CC8:				; CODE XREF: sub_1323C+A90j
		lodsw
		and	ax, dx
		stosw
		loop	loc_13CC8
		lodsb
		and	al, dl
		stosb
		add	si, bx
		add	di, bx
		dec	bp
		jz	short loc_13CDC
		jmp	loc_13C42
; ---------------------------------------------------------------------------

loc_13CDC:				; CODE XREF: sub_1323C+A9Bj
		pop	bp
		pop	di
		pop	si
		pop	ds
		mov	ax, ds:0CEFCh

loc_13CE3:				; CODE XREF: sub_1323C+AABj
		cmp	ax, ds:1D08h
		ja	short loc_13CE3
		inc	bp
		cmp	bp, 10h
		jz	short locret_13CF2
		jmp	loc_13C1E
; ---------------------------------------------------------------------------

locret_13CF2:				; CODE XREF: sub_1323C+AB1j
		retn
; ---------------------------------------------------------------------------

loc_13CF3:				; CODE XREF: sub_1323C+81Fj
					; DATA XREF: seg000:off_13A60o
		xchg	bp, bx
		xor	bx, bx

loc_13CF7:				; CODE XREF: sub_1323C+BA7j
		mov	word ptr ds:1D08h, 0
		push	ds
		push	bx
		push	si
		push	di
		mov	al, cs:byte_1421F[bx]
		xor	ah, ah
		add	si, ax
		add	di, ax
		mov	dl, cs:byte_1420F[bx]
		mov	dh, dl
		mov	bx, dx
		not	bx
		mov	ax, cs:word_14231
		shr	ax, 2
		mov	cs:word_13DE7, ax

loc_13D22:				; CODE XREF: sub_1323C+B91j
		mov	ax, cs:word_112D0
		mov	ds, ax
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		mov	cs:word_14233, si
		mov	cs:word_14235, di
		mov	cx, cs:word_1422F

loc_13D3C:				; CODE XREF: sub_1323C+B0Cj
		lodsw
		and	ax, dx
		and	es:[di], bx
		or	es:[di], ax
		add	di, 2
		loop	loc_13D3C
		mov	ax, cs:word_112D2
		mov	ds, ax
		mov	ax, 0B000h
		mov	es, ax
		assume es:nothing
		mov	si, cs:word_14233
		mov	di, cs:word_14235
		mov	cx, cs:word_1422F

loc_13D64:				; CODE XREF: sub_1323C+B34j
		lodsw
		and	ax, dx
		and	es:[di], bx
		or	es:[di], ax
		add	di, 2
		loop	loc_13D64
		mov	ax, cs:word_112D4
		mov	ds, ax
		mov	ax, 0B800h
		mov	es, ax
		assume es:nothing
		mov	si, cs:word_14233
		mov	di, cs:word_14235
		mov	cx, cs:word_1422F

loc_13D8C:				; CODE XREF: sub_1323C+B5Cj
		lodsw
		and	ax, dx
		and	es:[di], bx
		or	es:[di], ax
		add	di, 2
		loop	loc_13D8C
		mov	ax, cs:word_112D6
		mov	ds, ax
		mov	ax, 0E000h
		mov	es, ax
		assume es:nothing
		mov	si, cs:word_14233
		mov	di, cs:word_14235
		mov	cx, cs:word_1422F

loc_13DB4:				; CODE XREF: sub_1323C+B84j
		lodsw
		and	ax, dx
		and	es:[di], bx
		or	es:[di], ax
		add	di, 2
		loop	loc_13DB4
		add	si, bp
		add	di, bp
		dec	cs:word_13DE7
		jz	short loc_13DD0
		jmp	loc_13D22
; ---------------------------------------------------------------------------

loc_13DD0:				; CODE XREF: sub_1323C+B8Fj
		pop	di
		pop	si
		pop	bx
		pop	ds
		mov	ax, ds:0CEFCh

loc_13DD7:				; CODE XREF: sub_1323C+B9Fj
		cmp	ax, ds:1D08h
		ja	short loc_13DD7
		inc	bx
		cmp	bx, 10h
		jz	short locret_13DE6
		jmp	loc_13CF7
; ---------------------------------------------------------------------------

locret_13DE6:				; CODE XREF: sub_1323C+BA5j
		retn
; END OF FUNCTION CHUNK	FOR sub_1323C
; ---------------------------------------------------------------------------
word_13DE7	dw 0			; DATA XREF: sub_1323C+AE2w
					; sub_1323C+B8Aw
; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_1323C

loc_13DE9:				; CODE XREF: sub_1323C+81Fj
					; DATA XREF: seg000:off_13A60o
		xchg	bp, bx
		xor	bx, bx

loc_13DED:				; CODE XREF: sub_1323C+CC2j
		mov	word ptr ds:1D08h, 0
		push	ds
		push	bx
		push	si
		push	di
		mov	al, cs:byte_1421F[bx]
		xor	ah, ah
		add	si, ax
		add	di, ax
		mov	dl, cs:byte_1420F[bx]
		mov	dh, dl
		mov	bx, dx
		not	bx
		mov	ax, cs:word_14231
		shr	ax, 2
		mov	cs:word_13F02, ax

loc_13E18:				; CODE XREF: sub_1323C+CACj
		mov	ax, cs:word_112D0
		mov	ds, ax
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		mov	cs:word_14233, si
		mov	cs:word_14235, di
		mov	cx, cs:word_1422F

loc_13E32:				; CODE XREF: sub_1323C+C02j
		lodsw
		and	ax, dx
		and	es:[di], bx
		or	es:[di], ax
		add	di, 2
		loop	loc_13E32
		lodsb
		and	al, dl
		and	es:[di], bl
		or	es:[di], al
		mov	ax, cs:word_112D2
		mov	ds, ax
		mov	ax, 0B000h
		mov	es, ax
		assume es:nothing
		mov	si, cs:word_14233
		mov	di, cs:word_14235
		mov	cx, cs:word_1422F

loc_13E63:				; CODE XREF: sub_1323C+C33j
		lodsw
		and	ax, dx
		and	es:[di], bx
		or	es:[di], ax
		add	di, 2
		loop	loc_13E63
		lodsb
		and	al, dl
		and	es:[di], bl
		or	es:[di], al
		mov	ax, cs:word_112D4
		mov	ds, ax
		mov	ax, 0B800h
		mov	es, ax
		assume es:nothing
		mov	si, cs:word_14233
		mov	di, cs:word_14235
		mov	cx, cs:word_1422F

loc_13E94:				; CODE XREF: sub_1323C+C64j
		lodsw
		and	ax, dx
		and	es:[di], bx
		or	es:[di], ax
		add	di, 2
		loop	loc_13E94
		lodsb
		and	al, dl
		and	es:[di], bl
		or	es:[di], al
		mov	ax, cs:word_112D6
		mov	ds, ax
		mov	ax, 0E000h
		mov	es, ax
		assume es:nothing
		mov	si, cs:word_14233
		mov	di, cs:word_14235
		mov	cx, cs:word_1422F

loc_13EC5:				; CODE XREF: sub_1323C+C95j
		lodsw
		and	ax, dx
		and	es:[di], bx
		or	es:[di], ax
		add	di, 2
		loop	loc_13EC5
		lodsb
		and	al, dl
		and	es:[di], bl
		or	es:[di], al
		inc	di
		add	si, bp
		add	di, bp
		dec	cs:word_13F02
		jz	short loc_13EEB
		jmp	loc_13E18
; ---------------------------------------------------------------------------

loc_13EEB:				; CODE XREF: sub_1323C+CAAj
		pop	di
		pop	si
		pop	bx
		pop	ds
		mov	ax, ds:0CEFCh

loc_13EF2:				; CODE XREF: sub_1323C+CBAj
		cmp	ax, ds:1D08h
		ja	short loc_13EF2
		inc	bx
		cmp	bx, 10h
		jz	short locret_13F01
		jmp	loc_13DED
; ---------------------------------------------------------------------------

locret_13F01:				; CODE XREF: sub_1323C+CC0j
		retn
; END OF FUNCTION CHUNK	FOR sub_1323C
; ---------------------------------------------------------------------------
word_13F02	dw 0			; DATA XREF: sub_1323C+BD8w
					; sub_1323C+CA5w

; =============== S U B	R O U T	I N E =======================================


sub_13F04	proc near		; CODE XREF: LoadGraphicsFile+17p
		push	ds
		push	es
		pusha
		push	ax
		or	ah, ah
		jnz	short loc_13F14
		lodsw
		sub	ax, 0C000h
		add	di, ax
		jmp	short loc_13F16
; ---------------------------------------------------------------------------

loc_13F14:				; CODE XREF: sub_13F04+6j
		inc	si
		inc	si

loc_13F16:				; CODE XREF: sub_13F04+Ej
		lodsb
		mov	cl, al
		xor	ch, ch
		lodsw
		mov	dx, ax
		lodsb
		xor	ah, ah
		mov	bp, ax
		pop	ax
		or	al, al
		jz	short loc_13F2B
		jmp	loc_1409A
; ---------------------------------------------------------------------------

loc_13F2B:				; CODE XREF: sub_13F04+22j
		mov	bx, 4Fh	; 'O'

loc_13F2E:				; CODE XREF: sub_13F04:loc_14094j
		push	cx
		push	bp
		shr	bp, 1
		jnb	short loc_13F83
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		push	di
		mov	cx, dx

loc_13F3C:				; CODE XREF: sub_13F04:loc_13F4Dj
		lodsb
		cmp	al, 5
		ja	short loc_13F4A
		jz	short loc_13F66
		cmp	al, 3
		jb	short loc_13F4A
		jz	short loc_13F52
		lodsb

loc_13F4A:				; CODE XREF: sub_13F04+3Bj
					; sub_13F04+41j
		stosb
		add	di, bx

loc_13F4D:				; CODE XREF: sub_13F04+60j
					; sub_13F04+7Dj
		loop	loc_13F3C
		pop	di
		jmp	short loc_13F83
; ---------------------------------------------------------------------------

loc_13F52:				; CODE XREF: sub_13F04+43j
		xor	ax, ax
		lodsb
		dec	al
		inc	ax
		sub	cx, ax
		push	cx
		xchg	ax, cx
		lodsb

loc_13F5D:				; CODE XREF: sub_13F04+5Cj
		stosb
		add	di, bx
		loop	loc_13F5D
		pop	cx
		inc	cx
		jmp	short loc_13F4D
; ---------------------------------------------------------------------------

loc_13F66:				; CODE XREF: sub_13F04+3Dj
		xor	ax, ax
		lodsb
		dec	al
		inc	ax
		sub	cx, ax
		sub	cx, ax
		push	cx
		xchg	ax, cx
		lodsw

loc_13F73:				; CODE XREF: sub_13F04+79j
		stosb
		add	di, bx
		xchg	ah, al
		stosb
		add	di, bx
		xchg	ah, al
		loop	loc_13F73
		pop	cx
		inc	cx
		jmp	short loc_13F4D
; ---------------------------------------------------------------------------

loc_13F83:				; CODE XREF: sub_13F04+2Ej
					; sub_13F04+4Cj
		shr	bp, 1
		jnb	short loc_13FD6
		mov	ax, 0B000h
		mov	es, ax
		assume es:nothing
		push	di
		mov	cx, dx

loc_13F8F:				; CODE XREF: sub_13F04:loc_13FA0j
		lodsb
		cmp	al, 5
		ja	short loc_13F9D
		jz	short loc_13FB9
		cmp	al, 3
		jb	short loc_13F9D
		jz	short loc_13FA5
		lodsb

loc_13F9D:				; CODE XREF: sub_13F04+8Ej
					; sub_13F04+94j
		stosb
		add	di, bx

loc_13FA0:				; CODE XREF: sub_13F04+B3j
					; sub_13F04+D0j
		loop	loc_13F8F
		pop	di
		jmp	short loc_13FD6
; ---------------------------------------------------------------------------

loc_13FA5:				; CODE XREF: sub_13F04+96j
		xor	ax, ax
		lodsb
		dec	al
		inc	ax
		sub	cx, ax
		push	cx
		xchg	ax, cx
		lodsb

loc_13FB0:				; CODE XREF: sub_13F04+AFj
		stosb
		add	di, bx
		loop	loc_13FB0
		pop	cx
		inc	cx
		jmp	short loc_13FA0
; ---------------------------------------------------------------------------

loc_13FB9:				; CODE XREF: sub_13F04+90j
		xor	ax, ax
		lodsb
		dec	al
		inc	ax
		sub	cx, ax
		sub	cx, ax
		push	cx
		xchg	ax, cx
		lodsw

loc_13FC6:				; CODE XREF: sub_13F04+CCj
		stosb
		add	di, bx
		xchg	ah, al
		stosb
		add	di, bx
		xchg	ah, al
		loop	loc_13FC6
		pop	cx
		inc	cx
		jmp	short loc_13FA0
; ---------------------------------------------------------------------------

loc_13FD6:				; CODE XREF: sub_13F04+81j
					; sub_13F04+9Fj
		shr	bp, 1
		jnb	short loc_14029
		mov	ax, 0B800h
		mov	es, ax
		assume es:nothing
		push	di
		mov	cx, dx

loc_13FE2:				; CODE XREF: sub_13F04:loc_13FF3j
		lodsb
		cmp	al, 5
		ja	short loc_13FF0
		jz	short loc_1400C
		cmp	al, 3
		jb	short loc_13FF0
		jz	short loc_13FF8
		lodsb

loc_13FF0:				; CODE XREF: sub_13F04+E1j
					; sub_13F04+E7j
		stosb
		add	di, bx

loc_13FF3:				; CODE XREF: sub_13F04+106j
					; sub_13F04+123j
		loop	loc_13FE2
		pop	di
		jmp	short loc_14029
; ---------------------------------------------------------------------------

loc_13FF8:				; CODE XREF: sub_13F04+E9j
		xor	ax, ax
		lodsb
		dec	al
		inc	ax
		sub	cx, ax
		push	cx
		xchg	ax, cx
		lodsb

loc_14003:				; CODE XREF: sub_13F04+102j
		stosb
		add	di, bx
		loop	loc_14003
		pop	cx
		inc	cx
		jmp	short loc_13FF3
; ---------------------------------------------------------------------------

loc_1400C:				; CODE XREF: sub_13F04+E3j
		xor	ax, ax
		lodsb
		dec	al
		inc	ax
		sub	cx, ax
		sub	cx, ax
		push	cx
		xchg	ax, cx
		lodsw

loc_14019:				; CODE XREF: sub_13F04+11Fj
		stosb
		add	di, bx
		xchg	ah, al
		stosb
		add	di, bx
		xchg	ah, al
		loop	loc_14019
		pop	cx
		inc	cx
		jmp	short loc_13FF3
; ---------------------------------------------------------------------------

loc_14029:				; CODE XREF: sub_13F04+D4j
					; sub_13F04+F2j
		shr	bp, 1
		jnb	short loc_1407C
		mov	ax, 0E000h
		mov	es, ax
		assume es:nothing
		push	di
		mov	cx, dx

loc_14035:				; CODE XREF: sub_13F04:loc_14046j
		lodsb
		cmp	al, 5
		ja	short loc_14043
		jz	short loc_1405F
		cmp	al, 3
		jb	short loc_14043
		jz	short loc_1404B
		lodsb

loc_14043:				; CODE XREF: sub_13F04+134j
					; sub_13F04+13Aj
		stosb
		add	di, bx

loc_14046:				; CODE XREF: sub_13F04+159j
					; sub_13F04+176j
		loop	loc_14035
		pop	di
		jmp	short loc_1407C
; ---------------------------------------------------------------------------

loc_1404B:				; CODE XREF: sub_13F04+13Cj
		xor	ax, ax
		lodsb
		dec	al
		inc	ax
		sub	cx, ax
		push	cx
		xchg	ax, cx
		lodsb

loc_14056:				; CODE XREF: sub_13F04+155j
		stosb
		add	di, bx
		loop	loc_14056
		pop	cx
		inc	cx
		jmp	short loc_14046
; ---------------------------------------------------------------------------

loc_1405F:				; CODE XREF: sub_13F04+136j
		xor	ax, ax
		lodsb
		dec	al
		inc	ax
		sub	cx, ax
		sub	cx, ax
		push	cx
		xchg	ax, cx
		lodsw

loc_1406C:				; CODE XREF: sub_13F04+172j
		stosb
		add	di, bx
		xchg	ah, al
		stosb
		add	di, bx
		xchg	ah, al
		loop	loc_1406C
		pop	cx
		inc	cx
		jmp	short loc_14046
; ---------------------------------------------------------------------------

loc_1407C:				; CODE XREF: sub_13F04+127j
					; sub_13F04+145j
		mov	ax, ds
		mov	cx, si
		and	cx, 0FFF0h
		shr	cx, 4
		add	ax, cx
		mov	ds, ax
		and	si, 0Fh
		inc	di
		pop	bp
		pop	cx
		loop	loc_14094
		jmp	short loc_14097
; ---------------------------------------------------------------------------

loc_14094:				; CODE XREF: sub_13F04+18Cj
		jmp	loc_13F2E
; ---------------------------------------------------------------------------

loc_14097:				; CODE XREF: sub_13F04+18Ej
		jmp	loc_1420A
; ---------------------------------------------------------------------------

loc_1409A:				; CODE XREF: sub_13F04+24j
		mov	bx, 4Fh	; 'O'

loc_1409D:				; CODE XREF: sub_13F04:loc_14207j
		push	cx
		push	bp
		shr	bp, 1
		jnb	short loc_140F3
		mov	ax, cs:word_112D0
		mov	es, ax
		assume es:nothing
		push	di
		mov	cx, dx

loc_140AC:				; CODE XREF: sub_13F04:loc_140BDj
		lodsb
		cmp	al, 5
		ja	short loc_140BA
		jz	short loc_140D6
		cmp	al, 3
		jb	short loc_140BA
		jz	short loc_140C2
		lodsb

loc_140BA:				; CODE XREF: sub_13F04+1ABj
					; sub_13F04+1B1j
		stosb
		add	di, bx

loc_140BD:				; CODE XREF: sub_13F04+1D0j
					; sub_13F04+1EDj
		loop	loc_140AC
		pop	di
		jmp	short loc_140F3
; ---------------------------------------------------------------------------

loc_140C2:				; CODE XREF: sub_13F04+1B3j
		xor	ax, ax
		lodsb
		dec	al
		inc	ax
		sub	cx, ax
		push	cx
		xchg	ax, cx
		lodsb

loc_140CD:				; CODE XREF: sub_13F04+1CCj
		stosb
		add	di, bx
		loop	loc_140CD
		pop	cx
		inc	cx
		jmp	short loc_140BD
; ---------------------------------------------------------------------------

loc_140D6:				; CODE XREF: sub_13F04+1ADj
		xor	ax, ax
		lodsb
		dec	al
		inc	ax
		sub	cx, ax
		sub	cx, ax
		push	cx
		xchg	ax, cx
		lodsw

loc_140E3:				; CODE XREF: sub_13F04+1E9j
		stosb
		add	di, bx
		xchg	ah, al
		stosb
		add	di, bx
		xchg	ah, al
		loop	loc_140E3
		pop	cx
		inc	cx
		jmp	short loc_140BD
; ---------------------------------------------------------------------------

loc_140F3:				; CODE XREF: sub_13F04+19Dj
					; sub_13F04+1BCj
		shr	bp, 1
		jnb	short loc_14147
		mov	ax, cs:word_112D2
		mov	es, ax
		push	di
		mov	cx, dx

loc_14100:				; CODE XREF: sub_13F04:loc_14111j
		lodsb
		cmp	al, 5
		ja	short loc_1410E
		jz	short loc_1412A
		cmp	al, 3
		jb	short loc_1410E
		jz	short loc_14116
		lodsb

loc_1410E:				; CODE XREF: sub_13F04+1FFj
					; sub_13F04+205j
		stosb
		add	di, bx

loc_14111:				; CODE XREF: sub_13F04+224j
					; sub_13F04+241j
		loop	loc_14100
		pop	di
		jmp	short loc_14147
; ---------------------------------------------------------------------------

loc_14116:				; CODE XREF: sub_13F04+207j
		xor	ax, ax
		lodsb
		dec	al
		inc	ax
		sub	cx, ax
		push	cx
		xchg	ax, cx
		lodsb

loc_14121:				; CODE XREF: sub_13F04+220j
		stosb
		add	di, bx
		loop	loc_14121
		pop	cx
		inc	cx
		jmp	short loc_14111
; ---------------------------------------------------------------------------

loc_1412A:				; CODE XREF: sub_13F04+201j
		xor	ax, ax
		lodsb
		dec	al
		inc	ax
		sub	cx, ax
		sub	cx, ax
		push	cx
		xchg	ax, cx
		lodsw

loc_14137:				; CODE XREF: sub_13F04+23Dj
		stosb
		add	di, bx
		xchg	ah, al
		stosb
		add	di, bx
		xchg	ah, al
		loop	loc_14137
		pop	cx
		inc	cx
		jmp	short loc_14111
; ---------------------------------------------------------------------------

loc_14147:				; CODE XREF: sub_13F04+1F1j
					; sub_13F04+210j
		shr	bp, 1
		jnb	short loc_1419B
		mov	ax, cs:word_112D4
		mov	es, ax
		push	di
		mov	cx, dx

loc_14154:				; CODE XREF: sub_13F04:loc_14165j
		lodsb
		cmp	al, 5
		ja	short loc_14162
		jz	short loc_1417E
		cmp	al, 3
		jb	short loc_14162
		jz	short loc_1416A
		lodsb

loc_14162:				; CODE XREF: sub_13F04+253j
					; sub_13F04+259j
		stosb
		add	di, bx

loc_14165:				; CODE XREF: sub_13F04+278j
					; sub_13F04+295j
		loop	loc_14154
		pop	di
		jmp	short loc_1419B
; ---------------------------------------------------------------------------

loc_1416A:				; CODE XREF: sub_13F04+25Bj
		xor	ax, ax
		lodsb
		dec	al
		inc	ax
		sub	cx, ax
		push	cx
		xchg	ax, cx
		lodsb

loc_14175:				; CODE XREF: sub_13F04+274j
		stosb
		add	di, bx
		loop	loc_14175
		pop	cx
		inc	cx
		jmp	short loc_14165
; ---------------------------------------------------------------------------

loc_1417E:				; CODE XREF: sub_13F04+255j
		xor	ax, ax
		lodsb
		dec	al
		inc	ax
		sub	cx, ax
		sub	cx, ax
		push	cx
		xchg	ax, cx
		lodsw

loc_1418B:				; CODE XREF: sub_13F04+291j
		stosb
		add	di, bx
		xchg	ah, al
		stosb
		add	di, bx
		xchg	ah, al
		loop	loc_1418B
		pop	cx
		inc	cx
		jmp	short loc_14165
; ---------------------------------------------------------------------------

loc_1419B:				; CODE XREF: sub_13F04+245j
					; sub_13F04+264j
		shr	bp, 1
		jnb	short loc_141EF
		mov	ax, cs:word_112D6
		mov	es, ax
		push	di
		mov	cx, dx

loc_141A8:				; CODE XREF: sub_13F04:loc_141B9j
		lodsb
		cmp	al, 5
		ja	short loc_141B6
		jz	short loc_141D2
		cmp	al, 3
		jb	short loc_141B6
		jz	short loc_141BE
		lodsb

loc_141B6:				; CODE XREF: sub_13F04+2A7j
					; sub_13F04+2ADj
		stosb
		add	di, bx

loc_141B9:				; CODE XREF: sub_13F04+2CCj
					; sub_13F04+2E9j
		loop	loc_141A8
		pop	di
		jmp	short loc_141EF
; ---------------------------------------------------------------------------

loc_141BE:				; CODE XREF: sub_13F04+2AFj
		xor	ax, ax
		lodsb
		dec	al
		inc	ax
		sub	cx, ax
		push	cx
		xchg	ax, cx
		lodsb

loc_141C9:				; CODE XREF: sub_13F04+2C8j
		stosb
		add	di, bx
		loop	loc_141C9
		pop	cx
		inc	cx
		jmp	short loc_141B9
; ---------------------------------------------------------------------------

loc_141D2:				; CODE XREF: sub_13F04+2A9j
		xor	ax, ax
		lodsb
		dec	al
		inc	ax
		sub	cx, ax
		sub	cx, ax
		push	cx
		xchg	ax, cx
		lodsw

loc_141DF:				; CODE XREF: sub_13F04+2E5j
		stosb
		add	di, bx
		xchg	ah, al
		stosb
		add	di, bx
		xchg	ah, al
		loop	loc_141DF
		pop	cx
		inc	cx
		jmp	short loc_141B9
; ---------------------------------------------------------------------------

loc_141EF:				; CODE XREF: sub_13F04+299j
					; sub_13F04+2B8j
		mov	ax, ds
		mov	cx, si
		and	cx, 0FFF0h
		shr	cx, 4
		add	ax, cx
		mov	ds, ax
		and	si, 0Fh
		inc	di
		pop	bp
		pop	cx
		loop	loc_14207
		jmp	short loc_1420A
; ---------------------------------------------------------------------------

loc_14207:				; CODE XREF: sub_13F04+2FFj
		jmp	loc_1409D
; ---------------------------------------------------------------------------

loc_1420A:				; CODE XREF: sub_13F04:loc_14097j
					; sub_13F04+301j
		popa
		pop	es
		pop	ds
		clc
		retn
sub_13F04	endp

; ---------------------------------------------------------------------------
byte_1420F	db  11h, 44h, 55h, 55h,	22h, 88h,0AAh,0AAh ; DATA XREF:	sub_13250+2Cr
					; sub_1323C+873r ...
		db  77h,0DDh,0FFh,0FFh,0BBh,0EEh,0FFh,0FFh
byte_1421F	db  00h,0A0h, 00h,0A0h,	50h,0F0h, 50h,0F0h ; DATA XREF:	sub_13250+21r
					; sub_1323C+868r ...
		db  00h,0A0h, 00h,0A0h,	50h,0F0h, 50h,0F0h
word_1422F	dw 0			; DATA XREF: sub_130DE+Bw
					; sub_13250+10r ...
word_14231	dw 0			; DATA XREF: sub_130DE+10w
					; sub_13250+31r ...
word_14233	dw 0			; DATA XREF: sub_1323C+94Aw
					; sub_1323C+96Ar ...
word_14235	dw 0			; DATA XREF: sub_1323C:loc_13ABEw
					; sub_1323C:loc_13B28w	...

; =============== S U B	R O U T	I N E =======================================


sub_14237	proc near		; CODE XREF: sub_11363+2Dp
					; sub_1174B+6p	...
		push	es
		push	di
		push	seg seg001
		pop	es
		assume es:seg001
		mov	di, 1D25h
		mov	cs:word_14AAB, ax
		call	sub_1424D
		call	sub_1429C
		pop	di
		pop	es
		assume es:nothing
		retn
sub_14237	endp


; =============== S U B	R O U T	I N E =======================================


sub_1424D	proc near		; CODE XREF: sub_14237+Dp
		push	ds
		push	ax
		push	cx
		push	si
		push	di
		push	bp
		mov	si, ax
		shl	si, 1
		mov	ax, cs:word_112C6
		mov	ds, ax
		mov	si, [si]
		mov	cx, 8

loc_14262:				; CODE XREF: sub_1424D:loc_14293j
		shr	bp, 1
		jnb	short loc_14276
		lodsb
		mov	ah, al
		and	al, 0Fh
		shr	ah, 4
		stosw
		mov	al, [si]
		and	al, 0Fh
		stosb
		jmp	short loc_1427A
; ---------------------------------------------------------------------------

loc_14276:				; CODE XREF: sub_1424D+17j
		inc	si
		add	di, 3

loc_1427A:				; CODE XREF: sub_1424D+27j
		shr	bp, 1
		jnb	short loc_1428D
		lodsw
		shr	al, 4
		stosb
		mov	al, ah
		and	al, 0Fh
		shr	ah, 4
		stosw
		jmp	short loc_14293
; ---------------------------------------------------------------------------

loc_1428D:				; CODE XREF: sub_1424D+2Fj
		add	si, 2
		add	di, 3

loc_14293:				; CODE XREF: sub_1424D+3Ej
		loop	loc_14262
		pop	bp
		pop	di
		pop	si
		pop	cx
		pop	ax
		pop	ds
		retn
sub_1424D	endp


; =============== S U B	R O U T	I N E =======================================


sub_1429C	proc near		; CODE XREF: sub_14237+10p
		push	ds
		push	es
		push	ax
		push	cx
		push	si
		push	di
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		mov	si, 1D25h
		mov	ax, cs:word_112C6
		mov	es, ax
		mov	di, es:2
		mov	cx, 30h	; '0'

loc_142B8:				; CODE XREF: sub_1429C+26j
		lodsw
		and	ax, 0F0Fh
		shl	ah, 4
		or	al, ah
		stosb
		loop	loc_142B8
		pop	di
		pop	si
		pop	cx
		pop	ax
		pop	es
		pop	ds
		assume ds:nothing
		retn
sub_1429C	endp


; =============== S U B	R O U T	I N E =======================================


sub_142CB	proc near		; CODE XREF: sub_11363+5Fp
					; seg000:22CDp
		push	ds
		push	es
		pusha
		push	cs:word_112C6
		pop	ds
		push	seg seg001
		pop	es
		assume es:seg001
		mov	cx, ax
		mov	si, dx
		shl	si, 1
		mov	si, [si]
		shl	bx, 1
		mov	bx, [bx]
		mov	di, 1D25h
		mov	dh, 8

loc_142E9:				; CODE XREF: sub_142CB+85j
		shr	bp, 1
		jnb	short loc_14314
		mov	al, [si]
		and	al, 0Fh
		mov	dl, [bx]
		and	dl, 0Fh
		call	sub_14356
		lodsb
		shr	al, 4
		mov	dl, [bx]
		inc	bx
		shr	dl, 4
		call	sub_14356
		mov	al, [si]
		and	al, 0Fh
		mov	dl, [bx]
		and	dl, 0Fh
		call	sub_14356
		jmp	short loc_14319
; ---------------------------------------------------------------------------

loc_14314:				; CODE XREF: sub_142CB+20j
		inc	si
		inc	bx
		add	di, 3

loc_14319:				; CODE XREF: sub_142CB+47j
		shr	bp, 1
		jnb	short loc_14345
		lodsb
		shr	al, 4
		mov	dl, [bx]
		inc	bx
		shr	dl, 4
		call	sub_14356
		mov	al, [si]
		and	al, 0Fh
		mov	dl, [bx]
		and	dl, 0Fh
		call	sub_14356
		lodsb
		shr	al, 4
		mov	dl, [bx]
		inc	bx
		shr	dl, 4
		call	sub_14356
		jmp	short loc_1434E
; ---------------------------------------------------------------------------

loc_14345:				; CODE XREF: sub_142CB+50j
		add	si, 2
		add	bx, 2
		add	di, 3

loc_1434E:				; CODE XREF: sub_142CB+78j
		dec	dh
		jnz	short loc_142E9
		popa
		pop	es
		assume es:nothing
		pop	ds
		retn
sub_142CB	endp


; =============== S U B	R O U T	I N E =======================================


sub_14356	proc near		; CODE XREF: sub_142CB+2Bp
					; sub_142CB+38p ...
		sub	al, dl
		cbw
		push	dx
		imul	cx
		pop	dx
		mov	al, ah
		add	al, dl
		stosb
		retn
sub_14356	endp


; =============== S U B	R O U T	I N E =======================================


LoadPalettes	proc near		; CODE XREF: sub_10ECA+11p
		push	ds
		pusha
		push	seg seg001
		pop	ds
		assume ds:seg001
		mov	bx, ds
		mov	bp, 0D627h
		mov	ax, 201h	; archive 02h (TWGD1), file 01h
		call	ReadArcFile_Cmp
		add	bp, 120h	; 96 colours * 3 bytes = 120h
		mov	ax, 202h	; archive 02h (TWGD1), file 02h
		call	ReadArcFile_Cmp
		add	bp, 120h
		mov	ax, 206h	; archive 02h (TWGD1), file 06h
		call	ReadArcFile_Cmp
		mov	byte ptr ds:0CF1Eh, 0
		mov	ax, cs:word_112CE
		mov	ds:0CF1Fh, ax
		call	sub_1439A
		popa
		pop	ds
		assume ds:nothing
		retn
LoadPalettes	endp


; =============== S U B	R O U T	I N E =======================================


sub_1439A	proc near		; CODE XREF: LoadPalettes+31p
					; sub_14407+13Fp
		push	ds
		push	di
		push	seg seg001
		pop	ds
		assume ds:seg001
		mov	byte ptr ds:0CF23h, 0
		mov	byte ptr ds:0CF24h, 0
		mov	word ptr ds:0CF21h, 0
		pop	di
		pop	ds
		assume ds:nothing
		retn
sub_1439A	endp


; =============== S U B	R O U T	I N E =======================================


sub_143B3	proc near		; CODE XREF: HandleFileError+5Ap
					; sub_11363+A7p ...
		push	ds
		push	es
		pusha
		push	seg seg001
		pop	es
		assume es:seg001

loc_143BA:				; CODE XREF: sub_143B3+4Ej
		lodsb
		cmp	al, 0FFh
		jz	short loc_14403
		push	ax
		mov	di, 0CF25h
		mov	cl, 52h	; 'R'
		mul	cl
		add	di, ax
		pop	bx
		and	bx, 0Fh
		shl	bx, 1
		mov	ax, es:[bx+108h]
		or	ds:0CF21h, ax
		movsb
		xor	dl, dl

loc_143DB:				; CODE XREF: sub_143B3+33j
		lodsb
		or	al, al
		jz	short loc_143ED
		stosb
		inc	dl
		cmp	dl, 50h	; 'P'
		jnz	short loc_143DB

loc_143E8:				; CODE XREF: sub_143B3+38j
		lodsb
		or	al, al
		jnz	short loc_143E8

loc_143ED:				; CODE XREF: sub_143B3+2Bj
		xor	al, al
		stosb
		cmp	dl, es:0CF23h
		jbe	short loc_143FC
		mov	es:0CF23h, dl

loc_143FC:				; CODE XREF: sub_143B3+42j
		inc	byte ptr es:0CF24h
		jmp	short loc_143BA
; ---------------------------------------------------------------------------

loc_14403:				; CODE XREF: sub_143B3+Aj
		popa
		pop	es
		assume es:nothing
		pop	ds
		retn
sub_143B3	endp


; =============== S U B	R O U T	I N E =======================================


sub_14407	proc near		; CODE XREF: HandleFileError+69p
					; sub_11363+B6p ...
		push	ds
		push	es
		pusha
		push	seg seg001
		pop	ds
		assume ds:seg001
		cmp	cl, 0FFh
		jnz	short loc_14417
		mov	cl, ds:0CF23h

loc_14417:				; CODE XREF: sub_14407+Aj
		cmp	ch, 0FFh
		jnz	short loc_1442C
		push	ax
		mov	al, bl
		mul	byte ptr ds:0CF24h
		add	ax, 7
		shr	ax, 3
		mov	ch, al
		pop	ax

loc_1442C:				; CODE XREF: sub_14407+13j
		push	ax
		push	cx
		mov	bp, 0D445h
		mov	al, ds:0CF1Eh
		mov	cl, 1Eh
		mul	cl
		add	bp, ax
		pop	cx
		pop	ax
		mov	ds:[bp+0], al
		mov	ds:[bp+1], bl
		mov	ds:[bp+2], dl
		mov	ds:[bp+3], dh
		mov	ds:[bp+4], cl
		mov	ds:[bp+5], ch
		mov	ax, ds:0CF1Fh
		mov	ds:[bp+6], ax
		mov	al, ds:[bp+3]
		mov	cl, 0A0h ; '†'
		mul	cl
		mov	dl, ds:[bp+2]
		mov	dh, ds:0CF23h
		shr	dh, 1
		sub	dl, dh
		mov	ds:[bp+0Ah], dl
		xor	dh, dh
		add	ax, dx
		mov	ds:[bp+8], ax
		mov	al, ds:0CF23h
		mov	ds:[bp+0Bh], al
		mov	al, ds:0CF24h
		mov	ds:[bp+0Ch], al
		mov	al, ds:[bp+1]
		mov	cl, 50h	; 'P'
		mul	cl
		mov	ds:[bp+0Dh], ax
		mov	ax, ds:0CF21h
		mov	ds:[bp+0Fh], ax
		call	sub_14C11
		mov	ds:[bp+11h], cx
		mov	ds:[bp+13h], dx
		call	sub_14C3A
		mov	ds:[bp+15h], cx
		mov	ds:[bp+17h], dx
		mov	ds:[bp+19h], si
		mov	ds:[bp+1Bh], di
		mov	cl, ds:[bp+0Ah]
		xor	ch, ch
		shl	cx, 3
		mov	dl, ds:[bp+3]
		xor	dh, dh
		shl	dx, 1
		mov	al, ds:[bp+1]
		sub	al, 10h
		shr	al, 1
		xor	ah, ah
		add	dx, ax
		mov	si, ds:0CF23h
		and	si, 0FFh
		shl	si, 3
		add	si, cx
		dec	si
		mov	di, dx
		mov	al, ds:[bp+1]
		mul	byte ptr ds:0CF24h
		add	di, ax
		mov	al, ds:[bp+1]
		sub	al, 10h
		inc	al
		shr	al, 1
		xor	ah, ah
		sub	di, ax
		dec	di
		call	sub_14C23
		mov	ax, ds:[bp+11h]
		cmp	ax, cx
		jnb	short loc_1450F
		mov	ax, cx
		jmp	short loc_14515
; ---------------------------------------------------------------------------

loc_1450F:				; CODE XREF: sub_14407+102j
		cmp	ax, si
		jbe	short loc_14515
		mov	ax, si

loc_14515:				; CODE XREF: sub_14407+106j
					; sub_14407+10Aj
		mov	cx, ax
		mov	ax, ds:[bp+13h]
		cmp	ax, dx
		jnb	short loc_14523
		mov	ax, dx
		jmp	short loc_14529
; ---------------------------------------------------------------------------

loc_14523:				; CODE XREF: sub_14407+116j
		cmp	ax, di
		jbe	short loc_14529
		mov	ax, di

loc_14529:				; CODE XREF: sub_14407+11Aj
					; sub_14407+11Ej
		mov	dx, ax
		call	sub_14BF6
		mov	byte ptr ds:[bp+1Dh], 0FFh
		call	sub_1454D
		call	sub_10C27
		call	sub_145AD
		call	sub_10C27
		call	sub_14640
		inc	byte ptr ds:0CF1Eh
		call	sub_1439A
		popa
		pop	es
		pop	ds
		assume ds:nothing
		retn
sub_14407	endp


; =============== S U B	R O U T	I N E =======================================


sub_1454D	proc near		; CODE XREF: sub_14407+12Cp
		push	ds
		push	es
		mov	bx, ds:[bp+8]
		add	bx, 0FD7Fh
		mov	dl, ds:[bp+4]
		xor	dh, dh
		inc	dx
		inc	dx
		mov	cl, ds:[bp+5]
		xor	ch, ch
		inc	cx
		inc	cx
		shl	cx, 3
		mov	es, word ptr ds:[bp+6]
		xor	di, di

loc_14570:				; CODE XREF: sub_1454D+54j
		push	cx
		mov	ax, 0A800h
		mov	ds, ax
		assume ds:nothing
		mov	si, bx
		mov	cx, dx
		rep movsb
		mov	ax, 0B000h
		mov	ds, ax
		assume ds:nothing
		mov	si, bx
		mov	cx, dx
		rep movsb
		mov	ax, 0B800h
		mov	ds, ax
		assume ds:nothing
		mov	si, bx
		mov	cx, dx
		rep movsb
		mov	ax, 0E000h
		mov	ds, ax
		assume ds:nothing
		mov	si, bx
		mov	cx, dx
		rep movsb
		add	bx, 50h	; 'P'
		pop	cx
		loop	loc_14570
		pop	es
		pop	ds
		assume ds:nothing
		shr	di, 4
		add	ds:0CF1Fh, di
		retn
sub_1454D	endp


; =============== S U B	R O U T	I N E =======================================


sub_145AD	proc near		; CODE XREF: sub_14407+132p
		mov	al, ds:[bp+0]
		dec	al
		js	short locret_14619
		mov	si, 0D627h
		xor	ah, ah
		mov	cx, 120h
		mul	cx
		add	si, ax
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		mov	al, 0C0h ; '¿'
		mov	cs:byte_112C3, al
		out	7Ch, al
		mov	di, ds:[bp+8]
		add	di, 0FD7Fh
		push	si
		call	sub_145FC
		pop	si
		add	si, 60h	; '`'
		mov	cl, ds:[bp+5]
		xor	ch, ch

loc_145E4:				; CODE XREF: sub_145AD+3Ej
		push	cx
		push	si
		call	sub_145FC
		pop	si
		pop	cx
		loop	loc_145E4
		add	si, 60h	; '`'
		call	sub_145FC
		xor	al, al
		mov	cs:byte_112C3, al
		out	7Ch, al
		retn
sub_145AD	endp


; =============== S U B	R O U T	I N E =======================================


sub_145FC	proc near		; CODE XREF: sub_145AD+2Ap
					; sub_145AD+39p ...
		push	di
		call	sub_1461A
		mov	bx, si
		mov	cl, ds:[bp+4]
		xor	ch, ch

loc_14608:				; CODE XREF: sub_145FC+13j
		push	cx
		mov	si, bx
		call	sub_1461A
		pop	cx
		loop	loc_14608
		call	sub_1461A
		pop	di
		add	di, 280h

locret_14619:				; CODE XREF: sub_145AD+6j
		retn
sub_145FC	endp


; =============== S U B	R O U T	I N E =======================================


sub_1461A	proc near		; CODE XREF: sub_145FC+1p sub_145FC+Fp ...
		mov	cx, 8

loc_1461D:				; CODE XREF: sub_1461A+1Fj
		lodsb
		out	7Eh, al
		mov	ah, al
		lodsb
		out	7Eh, al
		not	al
		or	ah, al
		lodsb
		out	7Eh, al
		not	al
		or	ah, al
		lodsb
		out	7Eh, al
		or	al, ah
		stosb
		add	di, 4Fh	; 'O'
		loop	loc_1461D
		add	di, 0FD81h
		retn
sub_1461A	endp


; =============== S U B	R O U T	I N E =======================================


sub_14640	proc near		; CODE XREF: sub_14407+138p
		mov	si, 0CF25h
		mov	di, ds:[bp+8]
		mov	al, ds:[bp+1]
		sub	al, 10h
		shr	al, 1
		mov	cl, 50h	; 'P'
		mul	cl
		add	di, ax
		mov	bx, ds:[bp+0Fh]
		mov	cl, ds:[bp+0Ch]
		xor	ch, ch

loc_1465F:				; CODE XREF: sub_14640+26j
					; sub_14640+55j
		shr	bx, 1
		jb	short loc_14668
		add	si, 52h	; 'R'
		jmp	short loc_1465F
; ---------------------------------------------------------------------------

loc_14668:				; CODE XREF: sub_14640+21j
		push	bx
		push	cx
		push	si
		push	di
		lodsb
		mov	bl, al
		and	bl, 0Fh
		mov	bh, al
		shr	bh, 4

loc_14677:				; CODE XREF: sub_14640+48j
		lodsb
		or	al, al
		jz	short loc_1468A
		js	short loc_14682
		xor	ah, ah
		jmp	short loc_14685
; ---------------------------------------------------------------------------

loc_14682:				; CODE XREF: sub_14640+3Cj
		xchg	al, ah
		lodsb

loc_14685:				; CODE XREF: sub_14640+40j
		call	sub_14980
		jmp	short loc_14677
; ---------------------------------------------------------------------------

loc_1468A:				; CODE XREF: sub_14640+3Aj
		pop	di
		pop	si
		pop	cx
		pop	bx
		add	di, ds:[bp+0Dh]
		add	si, 52h	; 'R'
		loop	loc_1465F
		retn
sub_14640	endp


; =============== S U B	R O U T	I N E =======================================


sub_14698	proc near		; CODE XREF: sub_11363:loc_1141Cp
					; sub_11363+EEp ...
		push	ds
		push	es
		push	bx
		push	cx
		push	dx
		push	si
		push	di
		push	bp
		push	seg seg001
		pop	ds
		assume ds:seg001
		mov	bp, 0D445h
		mov	al, ds:0CF1Eh
		dec	al
		mov	cl, 1Eh
		mul	cl
		add	bp, ax
		mov	al, ds:[bp+1Dh]
		mov	ds:0D625h, al
		cmp	al, 0FFh
		jnz	short loc_146BF
		xor	al, al

loc_146BF:				; CODE XREF: sub_14698+23j
		mov	ds:0D626h, al
		mov	cs:byte_148AF, 0
		call	sub_14790
		mov	cs:byte_148AE, dl
		call	sub_10C68
		call	sub_14BCA

loc_146D6:				; CODE XREF: sub_14698+BEj
		call	sub_14790
		mov	cs:byte_148A9, al
		cmp	dl, cs:byte_148AE
		jz	short loc_146ED
		mov	cs:byte_148AE, dl
		mov	ds:0D626h, dl

loc_146ED:				; CODE XREF: sub_14698+4Aj
		call	sub_10C85
		mov	cs:word_148A7, dx
		test	cs:word_148A7, 1
		jz	short loc_1470E
		mov	al, ds:0D626h
		dec	al
		jns	short loc_1470B
		mov	al, ds:[bp+0Ch]
		dec	al

loc_1470B:				; CODE XREF: sub_14698+6Bj
		mov	ds:0D626h, al

loc_1470E:				; CODE XREF: sub_14698+64j
		test	cs:word_148A7, 2
		jz	short loc_14727
		mov	al, ds:0D626h
		inc	al
		cmp	al, ds:[bp+0Ch]
		jnz	short loc_14724
		xor	al, al

loc_14724:				; CODE XREF: sub_14698+88j
		mov	ds:0D626h, al

loc_14727:				; CODE XREF: sub_14698+7Dj
		mov	al, ds:0D626h
		mov	ds:[bp+1Dh], al
		call	sub_14800
		call	sub_147C1
		test	cs:word_148A7, 20h
		jnz	short loc_1477D
		test	cs:byte_148A9, 1
		jnz	short loc_1477D
		test	cs:word_148A7, 10h
		jnz	short loc_14759
		test	cs:byte_148A9, 2
		jnz	short loc_14759
		jmp	loc_146D6
; ---------------------------------------------------------------------------

loc_14759:				; CODE XREF: sub_14698+B4j
					; sub_14698+BCj
		call	sub_14BE0
		mov	bx, ds:[bp+0Fh]
		mov	dl, ds:[bp+1Dh]
		xor	ax, ax
		mov	cx, 10h

loc_14769:				; CODE XREF: sub_14698+DAj
		shr	bx, 1
		jnb	short loc_14771
		dec	dl
		js	short loc_14774

loc_14771:				; CODE XREF: sub_14698+D3j
		inc	ax
		loop	loc_14769

loc_14774:				; CODE XREF: sub_14698+D7j
		pop	bp
		pop	di
		pop	si
		pop	dx
		pop	cx
		pop	bx
		pop	es
		assume es:nothing
		pop	ds
		assume ds:nothing
		retn
; ---------------------------------------------------------------------------

loc_1477D:				; CODE XREF: sub_14698+A3j
					; sub_14698+ABj
		call	sub_10C68
		call	sub_14BE0
		xor	ah, ah
		mov	al, 0FFh
		pop	bp
		pop	di
		pop	si
		pop	dx
		pop	cx
		pop	bx
		pop	es
		pop	ds
		retn
sub_14698	endp


; =============== S U B	R O U T	I N E =======================================


sub_14790	proc near		; CODE XREF: sub_14698+30p
					; sub_14698:loc_146D6p
		call	sub_14C11
		mov	cs:word_148AA, cx
		mov	cs:word_148AC, dx
		push	ax
		mov	al, ds:[bp+1]
		sub	al, 10h
		shr	al, 1
		xor	ah, ah
		sub	dx, ax
		mov	al, ds:[bp+3]
		shl	ax, 1
		sub	dx, ax
		xor	ax, ax
		xchg	ax, dx
		mov	cl, ds:[bp+1]
		xor	ch, ch
		div	cx
		mov	dx, ax
		pop	ax
		retn
sub_14790	endp


; =============== S U B	R O U T	I N E =======================================


sub_147C1	proc near		; CODE XREF: sub_14698+99p
		mov	al, ds:[bp+1Dh]
		mul	byte ptr ds:[bp+1]
		mov	dl, ds:[bp+1]
		sub	dl, 10h
		shr	dl, 1
		xor	dh, dh
		add	ax, dx
		mov	dl, ds:[bp+3]
		shl	dx, 1
		add	ax, dx
		cmp	ax, cs:word_148AC
		ja	short loc_147F5
		mov	bl, ds:[bp+1]
		xor	bh, bh
		add	bx, ax
		dec	bx
		cmp	bx, cs:word_148AC
		jnb	short locret_147FF

loc_147F5:				; CODE XREF: sub_147C1+22j
		mov	cx, cs:word_148AA
		mov	dx, ax
		call	sub_14BF6

locret_147FF:				; CODE XREF: sub_147C1+32j
		retn
sub_147C1	endp


; =============== S U B	R O U T	I N E =======================================


sub_14800	proc near		; CODE XREF: sub_14698+96p
		mov	al, ds:[bp+1Dh]
		cmp	al, ds:0D625h
		jz	short locret_1482B
		call	sub_14BE0
		call	sub_10C27
		mov	al, ds:0D625h
		cmp	al, 0FFh
		jz	short loc_1481A
		call	sub_1482C

loc_1481A:				; CODE XREF: sub_14800+15j
		mov	al, ds:[bp+1Dh]
		mov	ds:0D625h, al
		cmp	al, 0FFh
		jz	short loc_14828
		call	sub_14888

loc_14828:				; CODE XREF: sub_14800+23j
		call	sub_14BCA

locret_1482B:				; CODE XREF: sub_14800+8j
		retn
sub_14800	endp


; =============== S U B	R O U T	I N E =======================================


sub_1482C	proc near		; CODE XREF: sub_14800+17p sub_14888j
		call	sub_1488A
		mov	bx, di
		mov	dl, ds:[bp+0Bh]
		xor	dh, dh
		shr	dx, 1
		mov	cx, 11h

loc_1483C:				; CODE XREF: sub_1482C+59j
		push	cx
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		mov	di, bx
		mov	cx, dx

loc_14846:				; CODE XREF: sub_1482C+20j
		not	word ptr es:[di]
		add	di, 2
		loop	loc_14846
		mov	ax, 0B000h
		mov	es, ax
		assume es:nothing
		mov	di, bx
		mov	cx, dx

loc_14857:				; CODE XREF: sub_1482C+31j
		not	word ptr es:[di]
		add	di, 2
		loop	loc_14857
		mov	ax, 0B800h
		mov	es, ax
		assume es:nothing
		mov	di, bx
		mov	cx, dx

loc_14868:				; CODE XREF: sub_1482C+42j
		not	word ptr es:[di]
		add	di, 2
		loop	loc_14868
		mov	ax, 0E000h
		mov	es, ax
		assume es:nothing
		mov	di, bx
		mov	cx, dx

loc_14879:				; CODE XREF: sub_1482C+53j
		not	word ptr es:[di]
		add	di, 2
		loop	loc_14879
		add	bx, 50h	; 'P'
		pop	cx
		loop	loc_1483C
		retn
sub_1482C	endp


; =============== S U B	R O U T	I N E =======================================


sub_14888	proc near		; CODE XREF: sub_14800+25p
		jmp	short sub_1482C
sub_14888	endp


; =============== S U B	R O U T	I N E =======================================


sub_1488A	proc near		; CODE XREF: sub_1482Cp
		mov	di, ds:[bp+8]
		mul	byte ptr ds:[bp+1]
		mov	dl, ds:[bp+1]
		sub	dl, 10h
		shr	dl, 1
		xor	dh, dh
		add	ax, dx
		mov	cx, 50h	; 'P'
		mul	cx
		add	di, ax
		retn
sub_1488A	endp

; ---------------------------------------------------------------------------
word_148A7	dw 0			; DATA XREF: sub_14698+58w
					; sub_14698+5Dr ...
byte_148A9	db 0			; DATA XREF: sub_14698+41w
					; sub_14698+A5r ...
word_148AA	dw 0			; DATA XREF: sub_14790+3w
					; sub_147C1:loc_147F5r
word_148AC	dw 0			; DATA XREF: sub_14790+8w
					; sub_147C1+1Dr ...
byte_148AE	db 0			; DATA XREF: sub_14698+33w
					; sub_14698+45r ...
byte_148AF	db 0			; DATA XREF: sub_14698+2Aw

; =============== S U B	R O U T	I N E =======================================


sub_148B0	proc near		; CODE XREF: HandleFileError:loc_10B67p
					; sub_11363+F5p ...
		push	ds
		push	es
		pusha
		push	seg seg001
		pop	ds
		assume ds:seg001
		dec	byte ptr ds:0CF1Eh
		mov	bp, 0D445h
		mov	al, ds:0CF1Eh
		mov	cl, 1Eh
		mul	cl
		add	bp, ax
		mov	ax, ds:[bp+6]
		mov	ds:0CF1Fh, ax
		mov	cx, ds:[bp+11h]
		mov	dx, ds:[bp+13h]
		call	sub_14BF6
		mov	cx, ds:[bp+15h]
		mov	dx, ds:[bp+17h]
		mov	si, ds:[bp+19h]
		mov	di, ds:[bp+1Bh]
		call	sub_14C23
		call	sub_10C27
		mov	bx, ds:[bp+8]
		add	bx, 0FD7Fh
		mov	dl, ds:[bp+4]
		xor	dh, dh
		inc	dx
		inc	dx
		mov	cl, ds:[bp+5]
		xor	ch, ch
		inc	cx
		inc	cx
		shl	cx, 3
		mov	ds, word ptr ds:0CF1Fh
		assume ds:nothing
		xor	si, si

loc_14910:				; CODE XREF: sub_148B0+91j
		push	cx
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		mov	di, bx
		mov	cx, dx
		rep movsb
		mov	ax, 0B000h
		mov	es, ax
		assume es:nothing
		mov	di, bx
		mov	cx, dx
		rep movsb
		mov	ax, 0B800h
		mov	es, ax
		assume es:nothing
		mov	di, bx
		mov	cx, dx
		rep movsb
		mov	ax, 0E000h
		mov	es, ax
		assume es:nothing
		mov	di, bx
		mov	cx, dx
		rep movsb
		add	bx, 50h	; 'P'
		pop	cx
		loop	loc_14910
		popa
		pop	es
		assume es:nothing
		pop	ds
		retn
sub_148B0	endp

; ---------------------------------------------------------------------------
		push	bx
		push	cx
		push	si
		push	di

loc_1494B:				; CODE XREF: seg000:loc_14979j
		lodsb
		or	al, al
		jz	short loc_1497B
		mov	bl, al
		and	bl, 0Fh
		mov	bh, al
		shr	bh, 4
		lodsb
		xor	ah, ah
		mov	di, ax
		lodsb
		mov	cl, 5Fh	; '_'
		mul	cl
		add	di, ax

loc_14966:				; CODE XREF: seg000:4977j
		lodsb
		or	al, al
		jz	short loc_14979
		js	short loc_14971
		xor	ah, ah
		jmp	short loc_14974
; ---------------------------------------------------------------------------

loc_14971:				; CODE XREF: seg000:496Bj
		xchg	al, ah
		lodsb

loc_14974:				; CODE XREF: seg000:496Fj
		call	sub_14980
		jmp	short loc_14966
; ---------------------------------------------------------------------------

loc_14979:				; CODE XREF: seg000:4969j
		jmp	short loc_1494B
; ---------------------------------------------------------------------------

loc_1497B:				; CODE XREF: seg000:494Ej
		pop	di
		pop	si
		pop	cx
		pop	bx
		retn

; =============== S U B	R O U T	I N E =======================================


sub_14980	proc near		; CODE XREF: seg000:loc_120A0p
					; sub_12A94+1Fp ...
		push	ds
		push	es
		push	ax
		push	bx
		push	cx
		push	dx
		push	si
		push	bp
		mov	dx, ax
		mov	ax, seg	seg001
		mov	ds, ax
		assume ds:seg001
		mov	es, ax
		assume es:seg001
		cmp	dh, 1
		jnz	short loc_149A5
		mov	si, dx
		and	si, 0FFh
		shl	si, 5
		add	si, 1D55h
		jmp	short loc_14A03
; ---------------------------------------------------------------------------

loc_149A5:				; CODE XREF: sub_14980+14j
		push	dx
		or	dh, dh
		jnz	short loc_149AE
		mov	dh, 9
		jmp	short loc_149C2
; ---------------------------------------------------------------------------

loc_149AE:				; CODE XREF: sub_14980+28j
		shl	dh, 1
		sub	dl, 1Fh
		js	short loc_149BB
		cmp	dl, 61h	; 'a'
		adc	dl, 0DEh ; 'ﬁ'

loc_149BB:				; CODE XREF: sub_14980+33j
		add	dx, 0FFA1h
		and	dx, 7F7Fh

loc_149C2:				; CODE XREF: sub_14980+2Cj
		push	di
		mov	di, 0CEFEh
		mov	si, di
		xor	ah, ah
		mov	cx, 10h
		mov	al, 0Bh
		out	68h, al
		out	5Fh, al
		mov	al, dl
		out	0A1h, al	; Interrupt Controller #2, 8259A
		out	5Fh, al
		mov	al, dh
		out	0A3h, al	; Interrupt Controller #2, 8259A
		out	5Fh, al

loc_149DF:				; CODE XREF: sub_14980+79j
		mov	al, ah
		out	0A5h, al	; Interrupt Controller #2, 8259A
		out	5Fh, al
		in	al, 0A9h	; Interrupt Controller #2, 8259A
		out	5Fh, al
		stosb
		mov	al, ah
		or	al, 20h
		out	0A5h, al	; Interrupt Controller #2, 8259A
		out	5Fh, al
		in	al, 0A9h	; Interrupt Controller #2, 8259A
		out	5Fh, al
		stosb
		inc	ah
		loop	loc_149DF
		mov	al, 0Ah
		out	68h, al
		out	5Fh, al
		pop	di
		pop	dx

loc_14A03:				; CODE XREF: sub_14980+23j
		push	0A800h
		pop	es
		assume es:nothing
		mov	al, 0C0h ; '¿'
		mov	cs:byte_112C3, al
		out	7Ch, al
		or	dh, dh
		jnz	short loc_14A4D
		push	si
		push	di
		add	di, 50h	; 'P'
		mov	dl, bh
		call	sub_14A97
		mov	cx, 10h

loc_14A20:				; CODE XREF: sub_14980+ADj
		lodsw
		mov	dx, ax
		shr	ax, 1
		or	ax, dx
		xchg	al, ah
		stosb
		add	di, 4Fh	; 'O'
		loop	loc_14A20
		pop	di
		pop	si
		push	di
		mov	dl, bl
		call	sub_14A97
		mov	cx, 10h

loc_14A3A:				; CODE XREF: sub_14980+C7j
		lodsw
		mov	dx, ax
		shl	ax, 1
		or	ax, dx
		xchg	al, ah
		stosb
		add	di, 4Fh	; 'O'
		loop	loc_14A3A
		pop	di
		inc	di
		jmp	short loc_14A86
; ---------------------------------------------------------------------------

loc_14A4D:				; CODE XREF: sub_14980+91j
		push	si
		push	di
		add	di, 50h	; 'P'
		mov	dl, bh
		call	sub_14A97
		mov	cx, 10h

loc_14A5A:				; CODE XREF: sub_14980+E7j
		lodsw
		mov	dx, ax
		shr	ax, 1
		or	ax, dx
		xchg	al, ah
		stosw
		add	di, 4Eh	; 'N'
		loop	loc_14A5A
		pop	di
		pop	si
		push	di
		mov	dl, bl
		call	sub_14A97
		mov	cx, 10h

loc_14A74:				; CODE XREF: sub_14980+101j
		lodsw
		mov	dx, ax
		shl	ax, 1
		or	ax, dx
		xchg	al, ah
		stosw
		add	di, 4Eh	; 'N'
		loop	loc_14A74
		pop	di
		inc	di
		inc	di

loc_14A86:				; CODE XREF: sub_14980+CBj
		xor	al, al
		mov	cs:byte_112C3, al
		out	7Ch, al
		pop	bp
		pop	si
		pop	dx
		pop	cx
		pop	bx
		pop	ax
		pop	es
		assume es:nothing
		pop	ds
		assume ds:nothing
		retn
sub_14980	endp


; =============== S U B	R O U T	I N E =======================================


sub_14A97	proc near		; CODE XREF: sub_14980+9Ap
					; sub_14980+B4p ...
		cli
		mov	cx, 4

loc_14A9B:				; CODE XREF: sub_14A97+10j
		shr	dl, 1
		jb	short loc_14AA3
		xor	al, al
		jmp	short loc_14AA5
; ---------------------------------------------------------------------------

loc_14AA3:				; CODE XREF: sub_14A97+6j
		mov	al, 0FFh

loc_14AA5:				; CODE XREF: sub_14A97+Aj
		out	7Eh, al
		loop	loc_14A9B
		sti
		retn
sub_14A97	endp

; ---------------------------------------------------------------------------
word_14AAB	dw 0			; DATA XREF: sub_14237+9w
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_14AAE	proc near		; CODE XREF: sub_1105E+D0p
		pushf
		push	ds
		push	es
		pusha
		cli
		cld
		push	seg seg001
		pop	ds
		assume ds:seg001
		xor	ax, ax
		mov	es, ax
		assume es:nothing
		mov	ax, es:54h
		mov	ds:0D99Ah, ax
		mov	ax, es:56h
		mov	ds:0D99Ch, ax
		mov	word ptr es:54h, offset	loc_1510F
		mov	word ptr es:56h, cs
		mov	dx, 7FDFh
		mov	al, 93h	; 'ì'
		out	dx, al
		out	5Fh, al
		out	5Fh, al
		mov	dx, 7FDDh
		mov	al, 57h	; 'W'
		out	dx, al
		out	5Fh, al
		out	5Fh, al
		mov	dx, 0BFDBh
		mov	al, 0
		out	dx, al
		out	5Fh, al
		out	5Fh, al
		mov	dx, 7FDFh
		mov	al, 90h	; 'ê'
		out	dx, al
		out	5Fh, al
		out	5Fh, al
		in	al, 0Ah		; DMA controller, 8237A-5.
					; single mask bit register
					; 0-1: select channel (00=0; 01=1; 10=2; 11=3)
					; 2: 1=set mask	for channel; 0=clear mask (enable)
		out	5Fh, al
		out	5Fh, al
		and	al, 0DFh
		out	0Ah, al		; DMA controller, 8237A-5.
					; single mask bit register
					; 0-1: select channel (00=0; 01=1; 10=2; 11=3)
					; 2: 1=set mask	for channel; 0=clear mask (enable)
		out	5Fh, al
		out	5Fh, al
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
		out	5Fh, al
		out	5Fh, al
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
		out	5Fh, al
		in	al, 8		; DMA 8237A-5. status register bits:
					; 0-3: channel 0-3 has reached terminal	count
					; 4-7: channel 0-3 has a request pending
		out	5Fh, al
		out	5Fh, al
		test	al, 80h
		jnz	short loc_14B2E
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
		out	5Fh, al
		out	5Fh, al

loc_14B2E:				; CODE XREF: sub_14AAE+76j
		mov	dx, 7FDFh
		mov	al, 8
		out	dx, al
		out	5Fh, al
		out	5Fh, al
		mov	byte ptr ds:0D988h, 0
		mov	byte ptr ds:0D989h, 0
		mov	word ptr ds:0D98Ah, 0
		mov	word ptr ds:0D98Ch, 0
		mov	word ptr ds:0D98Eh, 0
		mov	word ptr ds:0D990h, 0
		mov	word ptr ds:0D992h, 27Fh
		mov	word ptr ds:0D994h, 18Fh
		mov	word ptr ds:0D996h, 8000h
		mov	word ptr ds:0D998h, 8000h
		mov	word ptr ds:0D99Eh, 0
		popa
		pop	es
		assume es:nothing
		pop	ds
		assume ds:nothing
		popf
		clc
		retn
sub_14AAE	endp

; ---------------------------------------------------------------------------
		popa
		pop	es
		pop	ds
		popf
		stc
		retn

; =============== S U B	R O U T	I N E =======================================


sub_14B84	proc near		; CODE XREF: sub_1119A+Ep
		pushf
		push	ds
		push	es
		pusha
		cli
		cld
		call	sub_14BE0
		push	seg seg001
		pop	ds
		assume ds:seg001
		xor	ax, ax
		mov	es, ax
		assume es:nothing
		mov	ax, ds:0D99Ah
		mov	es:54h,	ax
		mov	ax, ds:0D99Ch
		mov	es:56h,	ax
		mov	dx, 0BFDBh
		mov	al, 0
		out	dx, al
		out	5Fh, al
		out	5Fh, al
		in	al, 0Ah		; DMA controller, 8237A-5.
					; single mask bit register
					; 0-1: select channel (00=0; 01=1; 10=2; 11=3)
					; 2: 1=set mask	for channel; 0=clear mask (enable)
		out	5Fh, al
		out	5Fh, al
		or	al, 20h
		out	0Ah, al		; DMA controller, 8237A-5.
					; single mask bit register
					; 0-1: select channel (00=0; 01=1; 10=2; 11=3)
					; 2: 1=set mask	for channel; 0=clear mask (enable)
		out	5Fh, al
		out	5Fh, al
		popa
		pop	es
		assume es:nothing
		pop	ds
		assume ds:nothing
		popf
		retn
sub_14B84	endp

; ---------------------------------------------------------------------------
		push	ds
		push	seg seg001
		pop	ds
		mov	al, ds:0D988h
		pop	ds
		retn

; =============== S U B	R O U T	I N E =======================================


sub_14BCA	proc near		; CODE XREF: HandleFileError+9Ap
					; seg000:24D0p	...
		push	ds
		push	seg seg001
		pop	ds
		assume ds:seg001
		cmp	byte ptr ds:0D988h, 0FFh
		jz	short loc_14BDE
		call	sub_14D3B
		mov	byte ptr ds:0D988h, 0FFh

loc_14BDE:				; CODE XREF: sub_14BCA+Aj
		pop	ds
		assume ds:nothing
		retn
sub_14BCA	endp


; =============== S U B	R O U T	I N E =======================================


sub_14BE0	proc near		; CODE XREF: HandleFileError+4Bp
					; DoScript+1Bp	...
		push	ds
		push	seg seg001
		pop	ds
		assume ds:seg001
		cmp	byte ptr ds:0D988h, 0
		jz	short loc_14BF4
		mov	byte ptr ds:0D988h, 0
		call	sub_150CB

loc_14BF4:				; CODE XREF: sub_14BE0+Aj
		pop	ds
		assume ds:nothing
		retn
sub_14BE0	endp


; =============== S U B	R O U T	I N E =======================================


sub_14BF6	proc near		; CODE XREF: seg000:24CDp seg000:25AEp ...
		push	ds
		push	seg seg001
		pop	ds
		assume ds:seg001
		mov	ds:0D98Ah, cx
		mov	ds:0D98Ch, dx
		mov	word ptr ds:0D996h, 8000h
		mov	word ptr ds:0D998h, 8000h
		pop	ds
		assume ds:nothing
		retn
sub_14BF6	endp


; =============== S U B	R O U T	I N E =======================================


sub_14C11	proc near		; CODE XREF: HandleFileError:loc_10B47p
					; HandleFileError:loc_10B56p ...
		push	ds
		push	seg seg001
		pop	ds
		assume ds:seg001
		mov	al, ds:0D989h
		mov	cx, ds:0D98Ah
		mov	dx, ds:0D98Ch
		pop	ds
		assume ds:nothing
		retn
sub_14C11	endp


; =============== S U B	R O U T	I N E =======================================


sub_14C23	proc near		; CODE XREF: sub_14407+F9p
					; sub_148B0+39p
		push	ds
		push	seg seg001
		pop	ds
		assume ds:seg001
		mov	ds:0D98Eh, cx
		mov	ds:0D990h, dx
		mov	ds:0D992h, si
		mov	ds:0D994h, di
		pop	ds
		assume ds:nothing
		retn
sub_14C23	endp


; =============== S U B	R O U T	I N E =======================================


sub_14C3A	proc near		; CODE XREF: sub_14407+A0p
		push	ds
		push	seg seg001
		pop	ds
		assume ds:seg001
		mov	cx, ds:0D98Eh
		mov	dx, ds:0D990h
		mov	si, ds:0D992h
		mov	di, ds:0D994h
		pop	ds
		assume ds:nothing
		retn
sub_14C3A	endp


; =============== S U B	R O U T	I N E =======================================


sub_14C51	proc near		; CODE XREF: DoScript+18p
		push	ds
		push	ax
		push	bx
		push	seg seg001
		pop	ds
		assume ds:seg001
		mov	bx, ds:0D99Eh
		mov	al, ds:0D988h
		mov	[bx-2660h], al
		inc	word ptr ds:0D99Eh
		pop	bx
		pop	ax
		pop	ds
		assume ds:nothing
		retn
sub_14C51	endp


; =============== S U B	R O U T	I N E =======================================


sub_14C6B	proc near		; CODE XREF: DoScript+66p
		push	ds
		push	ax
		push	bx
		push	seg seg001
		pop	ds
		assume ds:seg001
		dec	word ptr ds:0D99Eh
		mov	bx, ds:0D99Eh
		mov	al, [bx-2660h]
		cmp	al, ds:0D988h
		jz	short loc_14C9A
		or	al, al
		jz	short loc_14C92
		call	sub_14D3B
		mov	byte ptr ds:0D988h, 0FFh
		jmp	short loc_14C9A
; ---------------------------------------------------------------------------

loc_14C92:				; CODE XREF: sub_14C6B+1Bj
		mov	byte ptr ds:0D988h, 0
		call	sub_150CB

loc_14C9A:				; CODE XREF: sub_14C6B+17j
					; sub_14C6B+25j
		pop	bx
		pop	ax
		pop	ds
		assume ds:nothing
		retn
sub_14C6B	endp


; =============== S U B	R O U T	I N E =======================================


LoadGD1_0708	proc near		; CODE XREF: sub_1105E+CDp
					; seg000:2431p	...
		push	ds		; called with AX=207h or 208h (archive TWGD1)
		push	es
		pusha
		push	seg seg001
		pop	ds
		assume ds:seg001
		mov	ds:0D9C0h, cx
		mov	ds:0D9C2h, dx
		mov	bx, cs:word_112CE
		xor	bp, bp
		call	ReadArcFile_Cmp
		mov	ds, bx
		assume ds:nothing
		push	seg seg001
		pop	es
		assume es:seg001
		mov	di, 0D9C4h
		mov	bp, 0DBC4h
		xor	si, si
		mov	dh, 4

loc_14CC7:				; CODE XREF: LoadGD1_0708+97j
		push	si
		mov	dl, 8

loc_14CCA:				; CODE XREF: LoadGD1_0708+8Ej
		push	si
		push	si
		mov	cx, 4

loc_14CCF:				; CODE XREF: LoadGD1_0708+50j
		mov	ah, [si]
		not	ah
		mov	al, [si+8]
		not	al
		or	ah, al
		mov	al, [si+10h]
		not	al
		or	ah, al
		or	ah, [si+18h]
		not	ah
		mov	es:[bp+0], ah
		inc	bp
		add	si, 20h	; ' '
		loop	loc_14CCF
		pop	si
		mov	cx, 4

loc_14CF4:				; CODE XREF: LoadGD1_0708+88j
		mov	ah, es:[bp-4]
		not	ah
		mov	al, [si]
		and	al, ah
		stosb
		mov	ah, es:[bp-3]
		not	ah
		mov	al, [si+20h]
		and	al, ah
		stosb
		mov	ah, es:[bp-2]
		not	ah
		mov	al, [si+40h]
		and	al, ah
		stosb
		mov	ah, es:[bp-1]
		not	ah
		mov	al, [si+60h]
		and	al, ah
		stosb
		add	si, 8
		loop	loc_14CF4
		pop	si
		inc	si
		dec	dl
		jnz	short loc_14CCA
		pop	si
		add	si, 80h	; 'Ä'
		dec	dh
		jnz	short loc_14CC7
		popa
		pop	es
		assume es:nothing
		pop	ds
		retn
LoadGD1_0708	endp


; =============== S U B	R O U T	I N E =======================================


sub_14D3B	proc near		; CODE XREF: sub_14BCA+Cp
					; sub_14C6B+1Dp ...
		push	ds
		push	es
		pusha
		push	seg seg001
		pop	ds
		assume ds:seg001
		push	seg seg001
		pop	es
		assume es:seg001
		mov	cx, ds:0D98Ah
		sub	cx, ds:0D9C0h
		jns	short loc_14D58
		mov	ax, cx
		neg	ax
		xor	cx, cx
		jmp	short loc_14D5A
; ---------------------------------------------------------------------------

loc_14D58:				; CODE XREF: sub_14D3B+13j
		xor	ax, ax

loc_14D5A:				; CODE XREF: sub_14D3B+1Bj
		mov	ds:0DC48h, ax
		mov	ds:0DC44h, cx
		mov	ax, cx
		sub	ax, 258h
		jns	short loc_14D6A
		xor	ax, ax

loc_14D6A:				; CODE XREF: sub_14D3B+2Bj
		mov	bx, ax
		shl	ax, 2
		add	bx, ax
		mov	ax, [bx+182Ch]
		mov	ds:0DC56h, ax
		not	ax
		mov	ds:0DC5Bh, ax
		mov	ax, [bx+182Eh]
		mov	ds:0DC58h, ax
		not	ax
		mov	ds:0DC5Dh, ax
		mov	al, [bx+1830h]
		mov	ds:0DC5Ah, al
		not	al
		mov	ds:0DC5Fh, al
		cmp	cx, 260h
		jbe	short loc_14DA2
		mov	ax, 280h
		sub	ax, cx
		jmp	short loc_14DA5
; ---------------------------------------------------------------------------

loc_14DA2:				; CODE XREF: sub_14D3B+5Ej
		mov	ax, 20h	; ' '

loc_14DA5:				; CODE XREF: sub_14D3B+65j
		sub	ax, ds:0DC48h
		mov	ds:0DC4Ch, ax
		mov	al, cl
		and	al, 7
		mov	ds:0DC50h, al
		mov	dx, ds:0D98Ch
		sub	dx, ds:0D9C2h
		jns	short loc_14DC5
		mov	ax, dx
		neg	ax
		xor	dx, dx
		jmp	short loc_14DC7
; ---------------------------------------------------------------------------

loc_14DC5:				; CODE XREF: sub_14D3B+80j
		xor	ax, ax

loc_14DC7:				; CODE XREF: sub_14D3B+88j
		mov	ds:0DC4Ah, ax
		mov	ds:0DC46h, dx
		cmp	dx, 170h
		jbe	short loc_14DDB
		mov	ax, 190h
		sub	ax, dx
		jmp	short loc_14DDE
; ---------------------------------------------------------------------------

loc_14DDB:				; CODE XREF: sub_14D3B+97j
		mov	ax, 20h	; ' '

loc_14DDE:				; CODE XREF: sub_14D3B+9Ej
		sub	ax, ds:0DC4Ah
		mov	ds:0DC4Eh, ax
		shl	dx, 4
		mov	si, dx
		shl	dx, 2
		add	si, dx
		shr	cx, 3
		add	si, cx
		mov	ds:0DC60h, si
		mov	bp, ds:0DC4Ah
		shl	bp, 2
		add	bp, 0DBC4h
		mov	bx, ds:0DC4Ah
		shl	bx, 4
		add	bx, 0D9C4h
		mov	di, 0DC62h
		push	ds
		mov	cx, ds:0DC4Eh

loc_14E16:				; CODE XREF: sub_14D3B:loc_150C3j
		push	cx
		mov	cl, es:0DC50h
		mov	ah, 0FFh
		mov	al, es:[bp+0]
		shr	ax, cl
		or	al, es:0DC5Bh
		mov	es:0DC51h, al
		mov	ah, es:[bp+0]
		mov	al, es:[bp+1]
		shr	ax, cl
		or	al, es:0DC5Ch
		mov	es:0DC52h, al
		mov	ah, es:[bp+1]
		mov	al, es:[bp+2]
		shr	ax, cl
		or	al, es:0DC5Dh
		mov	es:0DC53h, al
		mov	ah, es:[bp+2]
		mov	al, es:[bp+3]
		shr	ax, cl
		or	al, es:0DC5Eh
		mov	es:0DC54h, al
		mov	ah, es:[bp+3]
		mov	al, 0FFh
		shr	ax, cl
		or	al, es:0DC5Fh
		mov	es:0DC55h, al
		mov	ax, 0A800h
		mov	ds, ax
		assume ds:nothing
		mov	al, [si]
		stosb
		xor	dh, dh
		mov	dl, es:[bx]
		shr	dx, cl
		and	dl, es:0DC56h
		and	al, es:0DC51h
		or	al, dl
		mov	[si], al
		mov	al, [si+1]
		stosb
		mov	dh, es:[bx]
		mov	dl, es:[bx+1]
		shr	dx, cl
		and	dl, es:0DC57h
		and	al, es:0DC52h
		or	al, dl
		mov	[si+1],	al
		mov	al, [si+2]
		stosb
		mov	dh, es:[bx+1]
		mov	dl, es:[bx+2]
		shr	dx, cl
		and	dl, es:0DC58h
		and	al, es:0DC53h
		or	al, dl
		mov	[si+2],	al
		mov	al, [si+3]
		stosb
		mov	dh, es:[bx+2]
		mov	dl, es:[bx+3]
		shr	dx, cl
		and	dl, es:0DC59h
		and	al, es:0DC54h
		or	al, dl
		mov	[si+3],	al
		mov	al, [si+4]
		stosb
		mov	dh, es:[bx+3]
		xor	dl, dl
		shr	dx, cl
		and	dl, es:0DC5Ah
		and	al, es:0DC55h
		or	al, dl
		mov	[si+4],	al
		mov	ax, 0B000h
		mov	ds, ax
		assume ds:nothing
		mov	al, [si]
		stosb
		xor	dh, dh
		mov	dl, es:[bx+4]
		shr	dx, cl
		and	dl, es:0DC56h
		and	al, es:0DC51h
		or	al, dl
		mov	[si], al
		mov	al, [si+1]
		stosb
		mov	dh, es:[bx+4]
		mov	dl, es:[bx+5]
		shr	dx, cl
		and	dl, es:0DC57h
		and	al, es:0DC52h
		or	al, dl
		mov	[si+1],	al
		mov	al, [si+2]
		stosb
		mov	dh, es:[bx+5]
		mov	dl, es:[bx+6]
		shr	dx, cl
		and	dl, es:0DC58h
		and	al, es:0DC53h
		or	al, dl
		mov	[si+2],	al
		mov	al, [si+3]
		stosb
		mov	dh, es:[bx+6]
		mov	dl, es:[bx+7]
		shr	dx, cl
		and	dl, es:0DC59h
		and	al, es:0DC54h
		or	al, dl
		mov	[si+3],	al
		mov	al, [si+4]
		stosb
		mov	dh, es:[bx+7]
		xor	dl, dl
		shr	dx, cl
		and	dl, es:0DC5Ah
		and	al, es:0DC55h
		or	al, dl
		mov	[si+4],	al
		mov	ax, 0B800h
		mov	ds, ax
		assume ds:nothing
		mov	al, [si]
		stosb
		xor	dh, dh
		mov	dl, es:[bx+8]
		shr	dx, cl
		and	dl, es:0DC56h
		and	al, es:0DC51h
		or	al, dl
		mov	[si], al
		mov	al, [si+1]
		stosb
		mov	dh, es:[bx+8]
		mov	dl, es:[bx+9]
		shr	dx, cl
		and	dl, es:0DC57h
		and	al, es:0DC52h
		or	al, dl
		mov	[si+1],	al
		mov	al, [si+2]
		stosb
		mov	dh, es:[bx+9]
		mov	dl, es:[bx+0Ah]
		shr	dx, cl
		and	dl, es:0DC58h
		and	al, es:0DC53h
		or	al, dl
		mov	[si+2],	al
		mov	al, [si+3]
		stosb
		mov	dh, es:[bx+0Ah]
		mov	dl, es:[bx+0Bh]
		shr	dx, cl
		and	dl, es:0DC59h
		and	al, es:0DC54h
		or	al, dl
		mov	[si+3],	al
		mov	al, [si+4]
		stosb
		mov	dh, es:[bx+0Bh]
		xor	dl, dl
		shr	dx, cl
		and	dl, es:0DC5Ah
		and	al, es:0DC55h
		or	al, dl
		mov	[si+4],	al
		mov	ax, 0E000h
		mov	ds, ax
		assume ds:nothing
		mov	al, [si]
		stosb
		xor	dh, dh
		mov	dl, es:[bx+0Ch]
		shr	dx, cl
		and	dl, es:0DC56h
		and	al, es:0DC51h
		or	al, dl
		mov	[si], al
		mov	al, [si+1]
		stosb
		mov	dh, es:[bx+0Ch]
		mov	dl, es:[bx+0Dh]
		shr	dx, cl
		and	dl, es:0DC57h
		and	al, es:0DC52h
		or	al, dl
		mov	[si+1],	al
		mov	al, [si+2]
		stosb
		mov	dh, es:[bx+0Dh]
		mov	dl, es:[bx+0Eh]
		shr	dx, cl
		and	dl, es:0DC58h
		and	al, es:0DC53h
		or	al, dl
		mov	[si+2],	al
		mov	al, [si+3]
		stosb
		mov	dh, es:[bx+0Eh]
		mov	dl, es:[bx+0Fh]
		shr	dx, cl
		and	dl, es:0DC59h
		and	al, es:0DC54h
		or	al, dl
		mov	[si+3],	al
		mov	al, [si+4]
		stosb
		mov	dh, es:[bx+0Fh]
		xor	dl, dl
		shr	dx, cl
		and	dl, es:0DC5Ah
		and	al, es:0DC55h
		or	al, dl
		mov	[si+4],	al
		add	bp, 4
		add	bx, 10h
		add	si, 50h	; 'P'
		pop	cx
		loop	loc_150C3
		jmp	short loc_150C6
; ---------------------------------------------------------------------------

loc_150C3:				; CODE XREF: sub_14D3B+384j
		jmp	loc_14E16
; ---------------------------------------------------------------------------

loc_150C6:				; CODE XREF: sub_14D3B+386j
		pop	ds
		assume ds:nothing
		popa
		pop	es
		assume es:nothing
		pop	ds
		retn
sub_14D3B	endp


; =============== S U B	R O U T	I N E =======================================


sub_150CB	proc near		; CODE XREF: sub_14BE0+11p
					; sub_14C6B+2Cp ...
		push	ds
		push	es
		pusha
		push	seg seg001
		pop	ds
		assume ds:seg001
		mov	si, 0DC62h
		mov	di, ds:0DC60h
		mov	cx, ds:0DC4Eh

loc_150DD:				; CODE XREF: sub_150CB+3Ej
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		movsw
		movsw
		movsb
		sub	di, 5
		mov	ax, 0B000h
		mov	es, ax
		assume es:nothing
		movsw
		movsw
		movsb
		sub	di, 5
		mov	ax, 0B800h
		mov	es, ax
		assume es:nothing
		movsw
		movsw
		movsb
		sub	di, 5
		mov	ax, 0E000h
		mov	es, ax
		assume es:nothing
		movsw
		movsw
		movsb
		add	di, 4Bh	; 'K'
		loop	loc_150DD
		popa
		pop	es
		assume es:nothing
		pop	ds
		assume ds:nothing
		retn
sub_150CB	endp

; ---------------------------------------------------------------------------

loc_1510F:				; DATA XREF: sub_14AAE+1Co
		cld
		push	ds
		push	es
		pusha
		push	seg seg001
		pop	ds
		assume ds:seg001
		mov	dx, 7FDDh
		mov	al, 90h	; 'ê'
		out	dx, al
		out	5Fh, al
		out	5Fh, al
		mov	dx, 7FD9h
		in	al, dx
		out	5Fh, al
		out	5Fh, al
		and	al, 0Fh
		mov	ah, al
		mov	dx, 7FDDh
		mov	al, 0B0h ; '∞'
		out	dx, al
		out	5Fh, al
		out	5Fh, al
		mov	dx, 7FD9h
		in	al, dx
		out	5Fh, al
		out	5Fh, al
		shl	al, 4
		or	al, ah
		cbw
		add	ax, ds:0D98Ah
		js	short loc_15151
		cmp	ax, ds:0D98Eh
		ja	short loc_15154

loc_15151:				; CODE XREF: seg000:5149j
		mov	ax, ds:0D98Eh

loc_15154:				; CODE XREF: seg000:514Fj
		cmp	ax, ds:0D992h
		jb	short loc_1515D
		mov	ax, ds:0D992h

loc_1515D:				; CODE XREF: seg000:5158j
		mov	ds:0D98Ah, ax
		mov	dx, 7FDDh
		mov	al, 0D0h ; '–'
		out	dx, al
		out	5Fh, al
		out	5Fh, al
		mov	dx, 7FD9h
		in	al, dx
		out	5Fh, al
		out	5Fh, al
		and	al, 0Fh
		mov	ah, al
		mov	dx, 7FDDh
		mov	al, 0F0h ; ''
		out	dx, al
		out	5Fh, al
		out	5Fh, al
		mov	dx, 7FD9h
		in	al, dx
		out	5Fh, al
		out	5Fh, al
		shl	al, 4
		or	al, ah
		cbw
		add	ax, ds:0D98Ch
		js	short loc_1519A
		cmp	ax, ds:0D990h
		ja	short loc_1519D

loc_1519A:				; CODE XREF: seg000:5192j
		mov	ax, ds:0D990h

loc_1519D:				; CODE XREF: seg000:5198j
		cmp	ax, ds:0D994h
		jb	short loc_151A6
		mov	ax, ds:0D994h

loc_151A6:				; CODE XREF: seg000:51A1j
		mov	ds:0D98Ch, ax
		sti
		in	al, dx
		out	5Fh, al
		out	5Fh, al
		not	al
		xor	ah, ah
		shl	ax, 1
		shl	al, 1
		shl	ax, 1
		mov	ds:0D989h, ah
		mov	cx, ds:0D98Ah
		cmp	cx, ds:0D996h
		jnz	short loc_151D1
		mov	dx, ds:0D98Ch
		cmp	dx, ds:0D998h
		jz	short loc_151F0

loc_151D1:				; CODE XREF: seg000:51C5j
		mov	ds:0D996h, cx
		mov	ds:0D998h, dx
		cmp	byte ptr ds:0D988h, 0FFh
		jnz	short loc_151F0
		mov	al, 0
		out	7Ch, al
		call	sub_150CB
		call	sub_14D3B
		mov	al, cs:byte_112C3
		out	7Ch, al

loc_151F0:				; CODE XREF: seg000:51CFj seg000:51DEj
		cli
		mov	dx, 7FDDh
		mov	al, 0
		out	dx, al
		out	5Fh, al
		out	5Fh, al
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

loc_151FF:				; DATA XREF: GetFileName+Fo
					; GetFileName+12o
		out	5Fh, al
		out	5Fh, al
		popa
		pop	es
		pop	ds
		assume ds:nothing
		iret
seg000		ends

; ===========================================================================

; Segment type:	Regular
seg001		segment	byte public 'UNK' use16
		assume cs:seg001
		;org 7
		assume es:nothing, ss:nothing, ds:nothing, fs:nothing, gs:nothing
		align 2
aNeedsMSDOSv21	db 'ÇlÇrÅ|ÇcÇnÇrÅ@ÇuÇÖÇíÇQÅDÇPà»è„ÇégópÇµÇƒâ∫Ç≥Ç¢ÅB$'
					; DATA XREF: sub_10DE9+42Eo
aInstallFailed	db 'ÉCÉìÉXÉgÉDÅ[ÉãÇ™ê≥èÌÇ…çsÇÌÇÍÇƒÇ¢Ç‹ÇπÇÒÅB$'
aMemoryBlockErr	db 'ÉÅÉÇÉäÅ[ÉuÉçÉbÉNÇ…àŸèÌÇ™Ç†ÇËÇ‹Ç∑ÅB$'
		db '$'
aNotEnoughMem	db 'ÉÅÉÇÉäÅ[Ç™ïsë´ÇµÇƒÇ¢Ç‹Ç∑ÅBé¿çsÇ∑ÇÈÇ…ÇÕÅA$' ; DATA XREF: malloc+385o
aNeedsKBofMem	db 'ÇãÇÇÇÃÉÅÉÇÉäÅ[Ç™ïKóvÇ≈Ç∑ÅB$' ; DATA XREF: malloc+3A4o
a1h		db 1Bh,'[>1h$'          ; DATA XREF: sub_1105E+14o
byte_152D0	db  00h, 00h, 00h	; DATA XREF: sub_1105E+69o
		db  0Ch, 00h, 00h
		db  00h, 0Ch, 00h
		db  0Ch, 0Ch, 00h
		db  00h, 00h, 0Ch
		db  0Ch, 00h, 0Ch
		db  00h, 0Ch, 0Ch
		db  07h, 07h, 07h
		db  0Ch, 0Ch, 0Ch
		db  0Fh, 00h, 00h
		db  00h, 0Fh, 00h
		db  0Fh, 0Fh, 00h
		db  00h, 00h, 0Fh
		db  0Fh, 00h, 0Fh
		db  00h, 0Fh, 0Fh
		db  0Fh, 0Fh, 0Fh
		db 1, 2, 4, 8, 10h, 20h, 40h, 80h
		dw     1,    2,	   4,	 8,  10h,  20h,	 40h,  80h
		dw  100h, 200h,	400h, 800h,1000h,2000h,4000h,8000h
		dw 172h
		db    0
		dw 183h
		db    0
		dw 275h
		db    0
		dw 293h
		db    0
		dw 473h
		db    0
		dw 486h
		db    0
		dw 874h
		db    0
		dw 890h
		db    0
		dw 1064h
		db    0
		dw 1034h
		db    0
		dw 2000h
		db    0
		db 0E0h, 0, 1
		db 0E1h, 0, 2
		db 0E2h, 0, 4
		db 0E3h, 0, 8
		db 0E4h, 0, 10h
		db 0C0h, 0, 40h
		db 0C1h, 0, 80h
		db 0FFh
aDrive		db 'ÉhÉâÉCÉu'           ; DATA XREF: HandleFileError+17o
					; final	text: Please insert the	disc A into the	drive 1.
aToDisk		db 'Ç…ÉfÉBÉXÉN'         ; DATA XREF: HandleFileError+27o
aPleaseInsert	db 'Çì¸ÇÍÇƒâ∫Ç≥Ç¢ÅB'   ; DATA XREF: HandleFileError+37o
filePath_TWDIR	db    0			; DATA XREF: LoadIndexFiles+25o
		db    0
		dw offset aTwdir_dir	; "TWDIR.DIR"
filePath_HEADER	db    0			; DATA XREF: LoadIndexFiles+62o
		db    0
		dw offset aHeader_dat	; "HEADER.DAT"
aTwdir_dir	db 'TWDIR.DIR',0        ; DATA XREF: seg001:0183o
aHeader_dat	db 'HEADER.DAT',0       ; DATA XREF: seg001:0187o
		db    0
		db  0Fh
aFMorNoSound	db 'ÇeÇlâπåπÇèÇíâπåπÇ»Çµ',0
		db    1
		db  0Fh
aMIDISound	db 'Å@Å@ÇlÇhÇcÇhâπåπÅ@Å@',0
		db 0FFh
		db    0
		db  0Fh
aStereoFMSound	db 'ÉXÉeÉåÉIÇeÇlâπåπ',0
		db    1
		db  0Fh
aNormalFMSound	db 'ÉmÅ[É}ÉãÇeÇlâπåπ',0
		db 0FFh
		db    0
		db  0Fh
aMT32_CM64	db 'ÇlÇsÇRÇQÅ^ÇbÇlÇUÇS',0
		db    1
		db  0Fh
aSC55		db 'Å@Å@ÇrÇbÇTÇTÅ@Å@Å@',0
		db 0FFh
		db    0
		db  0Fh
aMPU_PC98	db 'ÇlÇoÇtÅ|ÇoÇbÇXÇWÅ^ÇXÇWáU',0
		db    1
		db  0Fh
aRS232		db 'Å@Å@Å@ÇqÇrÇQÇRÇQÇbÅ@Å@Å@',0
		db 0FFh
		db    0
		db  0Fh
aStartFromBegin	db 'ç≈èâÇ©ÇÁénÇﬂÇÈ',0
		db    1
		db  0Fh
aStartFromMiddle db 'ìríÜÇ©ÇÁénÇﬂÇÈ',0
		db    2
		db  0Fh
aRename		db 'ñºëOÇïœçXÇ∑ÇÈ',0
		db 0FFh
		db    3
		db  0Fh
aReminiscenceMode db 'Å@âÒëzÉÇÅ[ÉhÅ@',0
		db    4
		db  0Fh
aMusicMode	db 'Å@âπäyÉÇÅ[ÉhÅ@',0
		db    5
		db  0Fh
aSoundFXMode	db ' å¯â âπÉÇÅ[Éh ',0
		db    7
		db  0Fh
aTwinkle	db ' ÉgÉDÉCÉìÉNÉã ',0
		db 0FFh
		db    8
		db  0Fh
aReturnToDOS	db ' ÇcÇnÇrÇ÷ñﬂÇÈ ',0
		db 0FFh
		db    0
		db  0Fh
aBisericaNeagra	db '   Biserica Neagra    ',0
		db    1
		db  0Fh
aDupaMasa	db '      Dupa masa       ',0
		db    2
		db  0Fh
aAsVrea		db '       As vrea        ',0
		db    3
		db  0Fh
aDimineata	db '      Dimineata       ',0
		db    4
		db  0Fh
aSeara		db '        Seara         ',0
		db    5
		db  0Fh
aParculTrandafi	db ' Parcul trandafirilor ',0
		db    6
		db  0Fh
aAsVreaSaMergLa	db '  As vrea sa merg la  ',0
		db 0FFh
		db    0
		db  0Fh
aSoundEffect01	db 'Å@å¯â âπÇOÇPÅ@',0
		db    1
		db  0Fh
aSoundEffect02	db 'Å@å¯â âπÇOÇQÅ@',0
		db    2
		db  0Fh
aSoundEffect03	db 'Å@å¯â âπÇOÇRÅ@',0
		db    3
		db  0Fh
aSoundEffect04	db 'Å@å¯â âπÇOÇSÅ@',0
		db    4
		db  0Fh
aSoundEffect05	db 'Å@å¯â âπÇOÇTÅ@',0
		db    5
		db  0Fh
aSoundEffect06	db 'Å@å¯â âπÇOÇUÅ@',0
		db    6
		db  0Fh
aSoundEffect07	db 'Å@å¯â âπÇOÇVÅ@',0
		db    7
		db  0Fh
aSoundEffect08	db 'Å@å¯â âπÇOÇWÅ@',0
		db    8
		db  0Fh
aSoundEffect09	db 'Å@å¯â âπÇOÇXÅ@',0
		db 0FFh
		dw offset unk_15637	; 0
		dw offset unk_15643	; 1
		dw offset unk_1564B	; 2
		dw offset unk_15653	; 3
		dw offset unk_1565F	; 4
		dw offset unk_1566B	; 5
unk_15637	db    0			; DATA XREF: seg001:042Bo
		db  0Fh
aGggmgmga	db 'ÉGÉåÉmÉA',0
		db 0FFh
unk_15643	db    1			; DATA XREF: seg001:042Bo
		db  0Fh
aGkgu		db 'ÉäÉì',0
		db 0FFh
unk_1564B	db    2			; DATA XREF: seg001:042Bo
		db  0Fh
aGtgi		db 'ÉTÉâ',0
		db 0FFh
unk_15653	db    3			; DATA XREF: seg001:042Bo
		db  0Fh
aGgglgvga	db 'ÉGÉãÉVÉA',0
		db 0FFh
unk_1565F	db    4			; DATA XREF: seg001:042Bo
		db  0Fh
aGtbGvgg	db 'ÉTÅ[ÉVÉÉ',0
		db 0FFh
unk_1566B	db    5			; DATA XREF: seg001:042Bo
		db  0Fh
aGjgj		db 'ÉÜÉj',0
		db 0FFh
		db    0
		db  0Fh
aB@b@fCB@b@	db 'Å@Å@î¸ó¥Å@Å@',0
		db    1
		db  0Fh
aB@cIOumB@	db 'Å@ó—â∆éuå∑Å@',0
		db    2
		db  0Fh
aB@phvVVlb@	db 'Å@èHÇ‹Ç≥Ç´Å@',0
		db    3
		db  0Fh
aB@ilb@tNB@	db 'Å@â´Å@íºç∆Å@',0
		db    4
		db  0Fh
aB@vavVvb@	db ' Å@Ç†Ç≥Ç¢Å@ ',0
		db    6
		db  0Fh
aB@sxidclb@	db ' Å@ëÂâ§ólÅ@ ',0
		db 0FFh
		dw offset off_156DC	; 0
		dw offset off_1596F	; 1
		dw offset off_15C01	; 2
		dw offset off_15C8E	; 3
		dw offset off_15F6D	; 4
		dw offset word_16250	; 5
		dw offset off_16252	; 6
off_156DC	dw offset unk_156E6	; 0 ; DATA XREF: seg001:04CEo
		dw offset unk_15721	; 1
		dw offset unk_15825	; 2
		dw offset unk_1594C	; 3
		dw 0
unk_156E6	db  40h	; @		; DATA XREF: seg001:off_156DCo
		db  28h	; (
		db    0
		db  0Fh
aVVrbafCVVBb	db 'Ç«Ç‡ÅAî¸ó¥Ç≈Ç∑ÅB',0
		db    1
		db  0Fh
aNbiVVVxvVRCCVB	db 'ç°âÒÇÕÇøÇÂÇ¡Ç∆ê^ñ ñ⁄Ç…ÅEÅEÅEÅièŒÅj',0
		db 0FFh
unk_15721	db  40h	; @		; DATA XREF: seg001:off_156DCo
		db  28h	; (
		db    0
		db  0Fh
aGggpgcgigcggvi	db 'ÉgÉèÉCÉâÉCÉgÇ®îÉÇ¢è„Ç∞í∏Ç´ÅAóLÇËìÔÇ§å‰ç¿Ç¢Ç‹Ç∑ÅB',0
		db    1
		db  0Fh
aVvvivvvivavsvV	db 'Ç¢ÇÎÇ¢ÇÎÇ†ÇËÇ‹ÇµÇΩÇ™ÅAÇ‚Ç¡Ç∆ÉgÉèÉCÉâÉCÉgî≠îÑÇ∆Ç»ÇËÇ‹ÇµÇΩÅB',0
		db    2
		db  0Fh
aGggdgcgugnglvV	db 'ÉgÉDÉCÉìÉNÉãÇ≈ÇÕÅAÇRñ{ñ⁄ÇÃçÏïiÇ≈Ç∑ÅB',0
		db    3
		db  0Fh
aNbvVVNXivVIsvd	db 'ç°Ç‹Ç≈ÇÃçÏïiÇ∆ÇÕà·Ç§ÉJÉâÅ[ÇÃÉÇÉmÇ…èâíßêÌÇµÇΩñÛÇ≈Ç∑Ç™',0
		db    4
		db  0Fh
aF@iVVVxvdvibhb	db 'î@âΩÇ≈ÇµÇÂÇ§Ç©ÅHÅ@å‰à”å©ÅAå‰ä¥ëzÇ®ë“ÇøÇµÇƒÇ‹Ç∑ÅB',0
		db 0FFh
unk_15825	db  40h	; @		; DATA XREF: seg001:off_156DCo
		db  28h	; (
		db    0
		db  0Fh
aVVBagegVBugggd	db 'Ç≥ÇƒÅAÉEÉ`ÇÃÅuÉgÉDÉCÉìÉNÉãÇmÇdÇsÅvÇ‡Ç»Ç©Ç»Ç©Ç…ìˆÇÌÇ¡ÇƒÅEÅE',0
		db    1
		db  0Fh
aVVVrbakfbxclvV	db 'Ç±ÇÍÇ‡ÅAäFÅXólÇÃÇ®Ç©Ç∞Ç≈Ç∑ÇÀÅAóLÇËìÔÇ§å‰ç¿Ç¢Ç‹Ç∑ÅB',0
		db    2
		db  0Fh
aOqvBuxscBvvVVU	db 'éüÇÕÅuïëñ≤ÅvÇªÇÍÇ∆ìØéûêiçsÇ≈Ç‡Ç§àÍñ{ÅIÅiÇ±ÇÍÇÕÇ‹ÇæîÈñßÅj',0
		db    3
		db  0Fh
aVVVBugggdgcgug	db 'ÇªÇµÇƒÅuÉgÉDÉCÉìÉNÉãÉXÉ^Å[Ç`ÇbÇsÇQÅv',0
		db    4
		db  0Fh
aNbfntjvFnfdpoc	db 'ç°îNíÜÇ…î≠îÑèoóàÇÈólÅAÉXÉ^ÉbÉtàÍìØäÊí£ÇËÇ‹Ç∑ÇÃÇ≈',0
		db    5
		db  0Fh
aISLxvVnviksvvt	db 'âΩë≤ãXÇµÇ≠Ç®äËÇ¢ívÇµÇ‹Ç∑ÅB',0
		db 0FFh
unk_1594C	db  40h	; @		; DATA XREF: seg001:off_156DCo
		db  28h	; (
		db    0
		db  0Fh
aVBh		db 'ÇÀÅH',0
		db    1
		db  0Fh
aRCCVVVVVVxP	db 'ê^ñ ñ⁄ÇæÇ¡ÇΩÇ≈ÇµÇÂ(èŒ)',0
		db 0FFh
off_1596F	dw offset unk_15979	; 0 ; DATA XREF: seg001:04CEo
		dw offset unk_15A02	; 1
		dw offset unk_15A98	; 2
		dw offset unk_15B9C	; 3
		dw 0
unk_15979	db  40h	; @		; DATA XREF: seg001:off_1596Fo
		db  28h	; (
		db    0
		db  0Fh
aBicIOumBj	db 'Åió—â∆éuå∑Åj',0
		db    1
		db  0Fh
aNbi		db ' ç°âÒÇ‡Ç¬Ç¬Ç™Ç»Ç≠édéñäÆóπÇ¡Çƒä¥Ç∂Ç≈Ç«Ç§Ç‡Ç®ãvÇµÇ‘ÇËÇ≈Ç∑äFólÅB',0
		db    2
		db  0Fh
aVVVkvVnvMVdvVV	db 'Ç¬Ç¬Ç™Ç»Ç≠Ç∆åæÇ§ÇÃÇÕÇ«Ç§Ç‡âRÉNÉTÉCÇ≈Ç∑Ç™ÅBÉnÉnÅ[ÉìÅB',0
		db 0FFh
unk_15A02	db  40h	; @		; DATA XREF: seg001:off_1596Fo
		db  28h	; (
		db    0
		db  0Fh
aVMVdvavpvNbi	db 'Ç∆åæÇ§ÇÌÇØÇ≈ç°âÒÇÃéÑÇÕÇ–Ç∆ñ°à·Ç¢Ç‹Ç∑ÇÀÅBÇ«ÇÃÇ≠ÇÁÇ¢à·Ç§Ç©Ç∆åæÇ§Ç∆Å'
		db 'B',0
		db    1
		db  0Fh
aGyguglbGavkxVa	db 9,9,'ÉyÉìÉlÅ[ÉÄÇ™ïœÇÌÇ¡ÇΩÅB',0
		db    2
		db  0Fh
aCmrVVVBbvtvVVn	db 'ó¨êŒÇ≈Ç∑ÇÀÅBÇ‚Ç¡ÇƒÇ≠ÇÍÇ‹Ç∑ÅBéÑÇ¡ÇƒìzÇÕÅBÇ≠Å[ÉbÅB',0
		db 0FFh
unk_15A98	db  40h	; @		; DATA XREF: seg001:off_1596Fo
		db  28h	; (
		db    0
		db  0Fh
aVvvVrfnonvVViv	db 'Ç¢Ç¬Ç‡îné≠ÇŒÇ¡Ç©ÇËÇ≈ÉîÉ@Å@É`ÉFÉãÉNÉXÅ[É[ÅiÇ≤ÇﬂÇÒÇ»Ç≥Ç¢ÅjÅB',0
		db    1
		db  0Fh
aGB@gkgbgxgnbio	db 'É}Å@ÉkÉÅÉXÉNÅiéÑÇÃñºëOÇÕÅjÅ@ó—â∆éuå∑ÅB',0
		db    2
		db  0Fh
aVrviiVkiVVigkb	db 'Ç‡Ç®âΩÇ™âΩÇæÇ©ÉkÅ[Å@ÉîÉ@Å@ÉEÉìÉcÉFÉåÅ[ÉOÅiÇÌÇ©ÇÁÇ»Ç¢ÅjÅB',0
		db    3
		db  0Fh
aLCVkiVPovVGGxv	db 'ã≥ó{Ç™àÏÇÍèoÇµÇƒÉ}ÉXÇÀÅBÅiîÁì˜ÇPÇOÇOÅìÅj',0
		db    4
		db  0Fh
aOcvsnzvjvGggpg	db 'éÊÇËçáÇ¶Ç∏ÉgÉèÉCÉâÉCÉgÇtÇoÇ…ÅAÉmÉçÉbÉNÅiä£îtÅjÅIÅI',0
		db 0FFh
unk_15B9C	db  40h	; @		; DATA XREF: seg001:off_1596Fo
		db  28h	; (
		db    0
		db  0Fh
aIPubabuglbGGjg	db 'à»è„ÅAÅuÉãÅ[É}ÉjÉAó∑ÇÃÇ±Ç∆ÇŒÅvÇÊÇËà¯ópÅB',0
		db    1
		db  0Fh
aVVVVVVVVBagigm	db 'ÇªÇÍÇ≈ÇÕÇ›Ç»Ç≥ÇÒÅAÉâÉåÉîÉFÉfÅ[ÉåÅiÇ≥ÇÊÇ§Ç»ÇÁÅjÅIÅIÅI',0
		db 0FFh
off_15C01	dw offset unk_15C05	; 0 ; DATA XREF: seg001:04CEo
		dw 0
unk_15C05	db  40h	; @		; DATA XREF: seg001:off_15C01o
		db  28h	; (
		db    0
		db  0Fh
aGggmgmgabdbdgk	db 'ÉGÉåÉmÉAÅdÅdÉäÉìÅdÅdÉTÉâÅdÅdÉGÉãÉVÉAÅdÅdÉTÅ[ÉVÉÉÅdÅdÉÜÉjÅdÅdÉJÉåÉ'
		db 'ìÅdÅd',0
		db    1
		db  0Fh
aFcvVVcvzbb	db 'îÊÇÍÇΩÇÊÇßÅB',0
		db    2
		db  0Fh
aMiajvVVnvBBb	db 'å®ùÜÇÒÇ≈Ç≠ÇÍÅ[ÅB',0
		db    3
		db  0Fh
aVVVibBbvtvVVVB	db 'ÇæÇﬂÇ©Å[ÅBÇ‚Ç¡ÇœÇµÇ»Å[ÅB',0
		db 0FFh
off_15C8E	dw offset unk_15C98	; 0 ; DATA XREF: seg001:04CEo
		dw offset unk_15D2A	; 1
		dw offset unk_15DED	; 2
		dw offset unk_15ECC	; 3
		dw 0
unk_15C98	db  40h	; @		; DATA XREF: seg001:off_15C8Eo
		db  28h	; (
		db    0
		db  0Fh
aIlb@tNVVBbnbiV	db 'â´Å@íºç∆Ç≈Ç∑ÅBç°âÒÇÃçÏïiÇ©ÇÁÇoÅDÇmÇÅuÇnÇjÇhÅvÇ©ÇÁÅuâ´Å@íºç∆Åv',0
		db    1
		db  0Fh
aVXVjvVVBb	db 'Ç…ïœÇ¶Ç‹ÇµÇΩÅB',0
		db    2
		db  0Fh
aVVVL@vRsl@iUBa	db 'Ç±ÇÍÇã@Ç…êSã@àÍì]ÅAçXÇ…äÊí£ÇËÇ‹Ç∑ÇÃÇ≈ãXÇµÇ≠Ç®äËÇ¢ÇµÇ‹Ç∑ÅB',0
		db 0FFh
unk_15D2A	db  40h	; @		; DATA XREF: seg001:off_15C8Eo
		db  28h	; (
		db    0
		db  0Fh
aVVBugggpgcgigc	db 'Ç±ÇÃÅuÉgÉèÉCÉâÉCÉgÅvÇÕç°Ç‹Ç≈ÇÃÇrÇsÅDÇsÇvÇhÇmÅfÇjÇkÇdÇÃ',0
		db    1
		db  0Fh
aGGtggvVXILcvki	db 'É\ÉtÉgÇ∆ÇÕïµàÕãCÇ™à·Ç§Ç∆évÇ§ÇÃÇ≈ÅAÉvÉåÉCÇµÇƒÇ≠ÇÍÇΩäFólÇÃ',0
		db    2
		db  0Fh
aFIuvklcvVVsoqs	db 'îΩâûÇ™ãCÇ…Ç»ÇÈéüëÊÇ≈Ç∑ÅB',0
		db    3
		db  0Fh
aGjbGubCtpsbasV	db 'ÉÜÅ[ÉUÅ[ótèëÅAë“Ç¡ÇƒÇ‹Ç∑ÇÃÇ≈èoÇµÇƒÇ≠ÇæÇ≥Ç¢ÇÀÅB',0
		db 0FFh
unk_15DED	db  40h	; @		; DATA XREF: seg001:off_15C8Eo
		db  28h	; (
		db    0
		db  0Fh
aKgvXVNlvjxVtxV	db 'äGÇÃï˚ÇÕçlÇ¶ï˚Ç‚ï`Ç´ï˚Ç™ïœÇÌÇ¡ÇΩÇÁÅAÇ‚Ç¡Ç∆êlÇ…ï∑Ç≠éñÇ‚òbÇ∑',0
		db    1
		db  0Fh
aOcvkpnvVVPociv	db 'éñÇ™è≠ÇµÇ√Ç¬èoóàÇÈÇÊÇ§Ç…Ç»Ç¡ÇƒÇ´Ç‹ÇµÇΩÅB',0
		db    2
		db  0Fh
aNXivPivjvsuxvI	db 'çÏïiÇèIÇ¶ÇÈìxÇ…âΩÇ©ÇíÕÇ›ÅAâΩÇ©Çñ≥Ç≠Ç∑éñÇÕÇ†ÇËÇ‹Ç∑Ç™ÅA',0
		db    3
		db  0Fh
aVvvVrnbvOixkvR	db 'Ç¢Ç¬Ç‡ç°ÇÃé©ï™ÇÃê∏àÍîtÇÃóÕÇèoÇµë±ÇØÇΩÇ¢Ç∆çlÇ¶ÇƒÇ‹Ç∑ÅB',0
		db 0FFh
unk_15ECC	db  40h	; @		; DATA XREF: seg001:off_15C8Eo
		db  28h	; (
		db    0
		db  0Fh
aVVOqiNVVVViizv	db 'Ç≈ÇÕéüâÒçÏÇ≈Ç‹ÇΩÇ®àßÇ¢ÇµÇ‹ÇµÇÂÇ§ÅB',0
unk_15EF3	db    1
		db  0Fh
aVVUVVVVVVVVcvd	db 'ÇªÇÃì˙Ç‹Ç≈Ç–Ç∆Ç‹Ç∏Ç≥ÇÊÇ§Ç»ÇÁÅEÅEÅEÅB',0
		db    2
		db  0Fh
		db ' ',0
		db    3
		db  0Fh
aVobdvrb@gtbGvg	db 'ÇoÅDÇrÅ@ÉTÅ[ÉVÉÉÇÕÇøÇÂÇ¡Ç∆çDÇ›ÇèoÇµÇ∑Ç¨ÇΩÇ©Ç»Ç¡Çƒ',0
		db    4
		db  0Fh
aFPVVVVBanbPBb	db 'îΩè»ÇµÇƒÇ‹Ç∑ÅAç°(èŒ)ÅB',0
		db 0FFh
off_15F6D	dw offset unk_15F77	; 0 ; DATA XREF: seg001:04CEo
		dw offset unk_16077	; 1
		dw offset unk_1613A	; 2
		dw offset unk_161D8	; 3
		dw 0
unk_15F77	db  40h	; @		; DATA XREF: seg001:off_15F6Do
		db  28h	; (
		db    0
		db  0Fh
aVVVVVVBbvavVvv	db 'ÇÕÇ∂ÇﬂÇ‹ÇµÇƒÅBÇ†Ç≥Ç¢Ç∆Ç‡Ç–ÇÎÇ≈Ç∑ÅB',0
		db    1
		db  0Fh
aNbiVBugggpgcgi	db 'ç°âÒÇÕÅuÉgÉèÉCÉâÉCÉgÅvå‰îÉÇ¢è„Ç∞óLÇËìÔÇ§Ç≤Ç¥Ç¢Ç‹ÇµÇΩÅB',0
		db    2
		db  0Fh
aBdbdbdbdnVVGGt	db 'ÅDÅDÅDÅDçÏÇ¡ÇΩÉ\ÉtÉgÇ…Ç±Ç§Ç¢Ç§ÉRÉÅÉìÉgç⁄ÇπÇÈÇÃÇ¡Çƒç°âÒ',0
		db    3
		db  0Fh
aVkpivVVVVBaiVP	db 'Ç™èâÇﬂÇƒÇ»ÇÃÇ≈ÅAâΩÇèëÇØÇŒÇ¢Ç¢ÇÃÇ©Ç‹ÇæíÕÇﬂÇ‹ÇπÇÒÅB',0
		db    4
		db  0Fh
aOcvskVjvLyvMVV	db 'éÊÇËä∏Ç¶Ç∏ãYÇÍåæÇæÇ∆évÇ¡ÇƒïtÇ´çáÇ¡Çƒâ∫Ç≥Ç¢ÇÀÅB',0
		db 0FFh
unk_16077	db  40h	; @		; DATA XREF: seg001:off_15F6Do
		db  28h	; (
		db    0
		db  0Fh
aB@sbvvvrvVBagq	db 'Å@ëÅÇ¢Ç‡ÇÃÇ≈ÅAÉQÅ[ÉÄêßçÏÇ…ä÷Ç¡Çƒç°îNÇ≈ÇUîNñ⁄Ç…ìÀì¸ÇµÇ‹',0
		db    1
		db  0Fh
aVVBbvVKBarfvVO	db 'ÇµÇΩÅBÇªÇÃä‘ÅAêFÇÒÇ»éñÇ™Ç†ÇËÇ‹ÇµÇΩÇ™ÅAç°Ç∆Ç»Ç¡ÇƒÇÕó«Ç¢',0
		db    2
		db  0Fh
aOvvvpobbmIacuv	db 'évÇ¢èoÅBåıâAñÓÇÃî@ÇµÅBãéÇÈé“ÇÕí«ÇÌÇ∏ÅBîLÇ‹Ç¡ÇµÇÆÇÁÇ¡Çƒ',0
		db    3
		db  0Fh
aKVVVVibbbiufbj	db 'ä¥Ç∂Ç≈Ç∑Ç©ÅBÅiì‰Åj',0
		db 0FFh
unk_1613A	db  40h	; @		; DATA XREF: seg001:off_15F6Do
		db  28h	; (
		db    0
		db  0Fh
aVVab@vVVivcvrk	db 'Ç‹Ç†Å@Ç±ÇÍÇ©ÇÁÇ‡äÊí£Ç¡Çƒó«Ç¢ï®ÇçÏÇ¡ÇƒçsÇ´ÇΩÇ¢Ç»Ç†ÅAÇ∆',0
		db    1
		db  0Fh
aViiVVipqosvOcv	db 'Ç©âΩÇ∆Ç©èüéËÇ»éñÇŸÇ¥Ç´Ç‹Ç≠Ç¡ÇƒÇ‹Ç∑Ç™ÅAévòfí ÇËÇ…çsÇ©Ç»',0
		db    2
aVvvVkrlrVVVBbb	db 0Fh,'Ç¢ÇÃÇ™êlê∂Ç≈Ç∑ÇÀÅBÅiâΩÇ™åæÇ¢ÇΩÇ¢ÇÒÇæÅj',0
		db 0FFh
unk_161D8	db  40h	; @		; DATA XREF: seg001:off_15F6Do
		db  28h	; (
		db    0
		db  0Fh
aNLXkcLccbvVBbv	db 'ç≈ãﬂï™óÙãCñ°Ç≈Ç∑ÅBÇ†Ç†Åió‹Åj',0
		db    1
		db  0Fh
aVVGogbgogcbivV	db 'Ç≈ÇÕÉOÉbÉoÉCÅiÇ≥ÇÊÇ§Ç»ÇÁÅj',0
		db    2
		db  0Fh
aB@b@vpvxvxvsbd	db 'Å@Å@ÇPÇXÇXÇSÅDÇSÅDÇPÅDÇ†Ç≥Ç¢Ç∆Ç‡Ç–ÇÎÅ@êEã∆ÅFï™óÙéÁåÏê_',0
		db 0FFh
word_16250	dw 0			; DATA XREF: seg001:04CEo
off_16252	dw offset unk_16256	; 0 ; DATA XREF: seg001:04CEo
		dw 0
unk_16256	db  40h	; @		; DATA XREF: seg001:off_16252o
		db  28h	; (
		db    0
		db  0Fh
aB@b@b@gvgngogi	db 'Å@Å@Å@ÉvÉçÉOÉâÉÄâÆÇÃëÂâ§ólÇ≈Ç∑ÅBÅ@Å@',0
		db    1
		db  0Fh
aB@gxgGwgigggdg	db 'Å@ÉXÉ^ÉWÉIÉgÉDÉCÉìÉNÉãÇÃëÊéOçÏñ⁄ÇÕÅ@',0
		db    2
		db  0Fh
aB@b@b@b@odvkts	db ' Å@Å@Å@Å@éÑÇ™íSìñÇµÇ‹ÇµÇΩÅBÅ@Å@Å@Å@ ',0
		db    3
		db  0Fh
aB@b@pivVKSzvVV	db 'Å@Å@èIÇ¡ÇΩä¥ëzÇÕÇ«Ç§Ç≈ÇµÇÂÇ§Ç©ÅHÅ@Å@',0
		db    4
		db  0Fh
aGagugpbGgctpsv	db 'ÉAÉìÉPÅ[ÉgótèëÇäyÇµÇ›Ç…ÇµÇƒÇ¢Ç‹Ç∑ÅB',0
		db 0FFh
		db    0
		db  0Fh
aVcvnvrvCVsvVVi	db 'ÇcÇnÇrÇ…ñﬂÇËÇ‹Ç∑Ç©ÅH',0
		db 0FFh
		db    0
		db  0Fh
aVmvn		db ' ÇmÇn ',0
		db    1
		db  0Fh
aVxvdvr		db 'ÇxÇdÇr',0
		db 0FFh
		db    0
		db  0Fh
a0000b@gfbGGggi	db '0000Å@ÉfÅ[É^ÉGÉâÅ[ÅI',0
		db 0FFh
		dw 88h,	38h
		dw 0F0h, 38h
		dw 158h, 38h
		dw 88h,	0A0h
		dw 0F0h, 0A0h
		dw 158h, 0A0h
		db 7, 2, 0, 1Eh
		db 8, 2, 0, 1Eh
		db 0Bh,	2, 0, 1Eh
		db 0
byte_16384	db    3,   0,	2, 82h,0A0h ; DATA XREF: sub_12C3A+D6o
					; sub_12FB6+46o
		db    5,   0,	2, 82h,0A2h
		db    7,   0,	2, 82h,0A4h
		db    9,   0,	2, 82h,0A6h
		db  0Bh,   0,	2, 82h,0A8h
		db  0Fh,   0,	2, 82h,0A9h
		db  11h,   0,	2, 82h,0ABh
		db  13h,   0,	2, 82h,0ADh
		db  15h,   0,	2, 82h,0AFh
		db  17h,   0,	2, 82h,0B1h
		db  1Bh,   0,	2, 82h,0B3h
		db  1Dh,   0,	2, 82h,0B5h
		db  1Fh,   0,	2, 82h,0B7h
		db  21h,   0,	2, 82h,0B9h
		db  23h,   0,	2, 82h,0BBh
		db    3,   1,	2, 82h,0BDh
		db    5,   1,	2, 82h,0BFh
		db    7,   1,	2, 82h,0C2h
		db    9,   1,	2, 82h,0C4h
		db  0Bh,   1,	2, 82h,0C6h
		db  0Fh,   1,	2, 82h,0C8h
		db  11h,   1,	2, 82h,0C9h
		db  13h,   1,	2, 82h,0CAh
		db  15h,   1,	2, 82h,0CBh
		db  17h,   1,	2, 82h,0CCh
		db  1Bh,   1,	2, 82h,0CDh
		db  1Dh,   1,	2, 82h,0D0h
		db  1Fh,   1,	2, 82h,0D3h
		db  21h,   1,	2, 82h,0D6h
		db  23h,   1,	2, 82h,0D9h
		db    3,   2,	2, 82h,0DCh
		db    5,   2,	2, 82h,0DDh
		db    7,   2,	2, 82h,0DEh
		db    9,   2,	2, 82h,0DFh
		db  0Bh,   2,	2, 82h,0E0h
		db  0Fh,   2,	2, 82h,0E2h
		db  13h,   2,	2, 82h,0E4h
		db  17h,   2,	2, 82h,0E6h
		db  1Bh,   2,	2, 82h,0E7h
		db  1Dh,   2,	2, 82h,0E8h
		db  1Fh,   2,	2, 82h,0E9h
		db  21h,   2,	2, 82h,0EAh
		db  23h,   2,	2, 82h,0EBh
		db    3,   3,	2, 82h,0EDh
		db    7,   3,	2, 82h,0F0h
		db  0Bh,   3,	2, 82h,0F1h
		db  0Fh,   3,	2, 82h,0AAh
		db  11h,   3,	2, 82h,0ACh
		db  13h,   3,	2, 82h,0AEh
		db  15h,   3,	2, 82h,0B0h
		db  17h,   3,	2, 82h,0B2h
		db  1Bh,   3,	2, 82h,0B4h
		db  1Dh,   3,	2, 82h,0B6h
		db  1Fh,   3,	2, 82h,0B8h
		db  21h,   3,	2, 82h,0BAh
		db  23h,   3,	2, 82h,0BCh
		db    3,   4,	2, 82h,0BEh
		db    5,   4,	2, 82h,0C0h
		db    7,   4,	2, 82h,0C3h
		db    9,   4,	2, 82h,0C5h
		db  0Bh,   4,	2, 82h,0C7h
		db  0Fh,   4,	2, 82h,0CEh
		db  11h,   4,	2, 82h,0D1h
		db  13h,   4,	2, 82h,0D4h
		db  15h,   4,	2, 82h,0D7h
		db  17h,   4,	2, 82h,0DAh
		db  1Bh,   4,	2, 82h,0CFh
		db  1Dh,   4,	2, 82h,0D2h
		db  1Fh,   4,	2, 82h,0D5h
		db  21h,   4,	2, 82h,0D8h
		db  23h,   4,	2, 82h,0DBh
		db    3,   5,	2, 82h,	9Fh
		db    5,   5,	2, 82h,0A1h
		db    7,   5,	2, 82h,0A3h
		db    9,   5,	2, 82h,0A5h
		db  0Bh,   5,	2, 82h,0A7h
		db  0Fh,   5,	2, 82h,0E1h
		db  13h,   5,	2, 82h,0E3h
		db  17h,   5,	2, 82h,0E5h
		db  1Bh,   5,	2, 82h,0ECh
		db  1Fh,   5,	2, 82h,0C1h
		db  23h,   5,	2, 81h,	5Bh
		db  27h,   0,	2, 83h,	41h
		db  29h,   0,	2, 83h,	43h
		db  2Bh,   0,	2, 83h,	45h
		db  2Dh,   0,	2, 83h,	47h
		db  2Fh,   0,	2, 83h,	49h
		db  33h,   0,	2, 83h,	4Ah
		db  35h,   0,	2, 83h,	4Ch
		db  37h,   0,	2, 83h,	4Eh
		db  39h,   0,	2, 83h,	50h
		db  3Bh,   0,	2, 83h,	52h
		db  3Fh,   0,	2, 83h,	54h
		db  41h,   0,	2, 83h,	56h
		db  43h,   0,	2, 83h,	58h
		db  45h,   0,	2, 83h,	5Ah
		db  47h,   0,	2, 83h,	5Ch
		db  27h,   1,	2, 83h,	5Eh
		db  29h,   1,	2, 83h,	60h
		db  2Bh,   1,	2, 83h,	63h
		db  2Dh,   1,	2, 83h,	65h
		db  2Fh,   1,	2, 83h,	67h
		db  33h,   1,	2, 83h,	69h
		db  35h,   1,	2, 83h,	6Ah
		db  37h,   1,	2, 83h,	6Bh
		db  39h,   1,	2, 83h,	6Ch
		db  3Bh,   1,	2, 83h,	6Dh
		db  3Fh,   1,	2, 83h,	6Eh
		db  41h,   1,	2, 83h,	71h
		db  43h,   1,	2, 83h,	74h
		db  45h,   1,	2, 83h,	77h
		db  47h,   1,	2, 83h,	7Ah
		db  27h,   2,	2, 83h,	7Dh
		db  29h,   2,	2, 83h,	7Eh
		db  2Bh,   2,	2, 83h,	80h
		db  2Dh,   2,	2, 83h,	81h
		db  2Fh,   2,	2, 83h,	82h
		db  33h,   2,	2, 83h,	84h
		db  37h,   2,	2, 83h,	86h
		db  3Bh,   2,	2, 83h,	88h
		db  3Fh,   2,	2, 83h,	89h
		db  41h,   2,	2, 83h,	8Ah
		db  43h,   2,	2, 83h,	8Bh
		db  45h,   2,	2, 83h,	8Ch
		db  47h,   2,	2, 83h,	8Dh
		db  27h,   3,	2, 83h,	8Fh
		db  2Bh,   3,	2, 83h,	92h
		db  2Fh,   3,	2, 83h,	93h
		db  33h,   3,	2, 83h,	4Bh
		db  35h,   3,	2, 83h,	4Dh
		db  37h,   3,	2, 83h,	4Fh
		db  39h,   3,	2, 83h,	51h
		db  3Bh,   3,	2, 83h,	53h
		db  3Fh,   3,	2, 83h,	55h
		db  41h,   3,	2, 83h,	57h
		db  43h,   3,	2, 83h,	59h
		db  45h,   3,	2, 83h,	5Bh
		db  47h,   3,	2, 83h,	5Dh
		db  27h,   4,	2, 83h,	5Fh
		db  29h,   4,	2, 83h,	61h
		db  2Bh,   4,	2, 83h,	64h
		db  2Dh,   4,	2, 83h,	66h
		db  2Fh,   4,	2, 83h,	68h
		db  33h,   4,	2, 83h,	6Fh
		db  35h,   4,	2, 83h,	72h
		db  37h,   4,	2, 83h,	75h
		db  39h,   4,	2, 83h,	78h
		db  3Bh,   4,	2, 83h,	7Bh
		db  3Fh,   4,	2, 83h,	70h
		db  41h,   4,	2, 83h,	73h
		db  43h,   4,	2, 83h,	76h
		db  45h,   4,	2, 83h,	79h
		db  47h,   4,	2, 83h,	7Ch
		db  27h,   5,	2, 83h,	40h
		db  29h,   5,	2, 83h,	42h
		db  2Bh,   5,	2, 83h,	44h
		db  2Dh,   5,	2, 83h,	46h
		db  2Fh,   5,	2, 83h,	48h
		db  33h,   5,	2, 83h,	83h
		db  37h,   5,	2, 83h,	85h
		db  3Bh,   5,	2, 83h,	87h
		db  3Fh,   5,	2, 83h,	8Eh
		db  43h,   5,	2, 83h,	62h
		db  47h,   5,	2, 81h,	5Bh
		db    7,   6,	2, 82h,	60h
		db    9,   6,	2, 82h,	61h
		db  0Bh,   6,	2, 82h,	62h
		db  0Dh,   6,	2, 82h,	63h
		db  0Fh,   6,	2, 82h,	64h
		db  11h,   6,	2, 82h,	65h
		db  13h,   6,	2, 82h,	66h
		db  15h,   6,	2, 82h,	67h
		db  17h,   6,	2, 82h,	68h
		db  19h,   6,	2, 82h,	69h
		db  1Bh,   6,	2, 82h,	6Ah
		db  1Dh,   6,	2, 82h,	6Bh
		db  1Fh,   6,	2, 82h,	6Ch
		db  21h,   6,	2, 82h,	6Dh
		db  23h,   6,	2, 82h,	6Eh
		db  25h,   6,	2, 82h,	6Fh
		db  27h,   6,	2, 82h,	70h
		db  29h,   6,	2, 82h,	71h
		db  2Bh,   6,	2, 82h,	72h
		db  2Dh,   6,	2, 82h,	73h
		db  2Fh,   6,	2, 82h,	74h
		db  31h,   6,	2, 82h,	75h
		db  33h,   6,	2, 82h,	76h
		db  35h,   6,	2, 82h,	77h
		db  37h,   6,	2, 82h,	78h
		db  39h,   6,	2, 82h,	79h
		db    7,   7,	2, 82h,	81h
		db    9,   7,	2, 82h,	82h
		db  0Bh,   7,	2, 82h,	83h
		db  0Dh,   7,	2, 82h,	84h
		db  0Fh,   7,	2, 82h,	85h
		db  11h,   7,	2, 82h,	86h
		db  13h,   7,	2, 82h,	87h
		db  15h,   7,	2, 82h,	88h
		db  17h,   7,	2, 82h,	89h
		db  19h,   7,	2, 82h,	8Ah
		db  1Bh,   7,	2, 82h,	8Bh
		db  1Dh,   7,	2, 82h,	8Ch
		db  1Fh,   7,	2, 82h,	8Dh
		db  21h,   7,	2, 82h,	8Eh
		db  23h,   7,	2, 82h,	8Fh
		db  25h,   7,	2, 82h,	90h
		db  27h,   7,	2, 82h,	91h
		db  29h,   7,	2, 82h,	92h
		db  2Bh,   7,	2, 82h,	93h
		db  2Dh,   7,	2, 82h,	94h
		db  2Fh,   7,	2, 82h,	95h
		db  31h,   7,	2, 82h,	96h
		db  33h,   7,	2, 82h,	97h
		db  35h,   7,	2, 82h,	98h
		db  37h,   7,	2, 82h,	99h
		db  39h,   7,	2, 82h,	9Ah
		db    7,   8,	2, 82h,	4Fh
		db    9,   8,	2, 82h,	50h
		db  0Bh,   8,	2, 82h,	51h
		db  0Dh,   8,	2, 82h,	52h
		db  0Fh,   8,	2, 82h,	53h
		db  11h,   8,	2, 82h,	54h
		db  13h,   8,	2, 82h,	55h
		db  15h,   8,	2, 82h,	56h
		db  17h,   8,	2, 82h,	57h
		db  19h,   8,	2, 82h,	58h
		db  1Bh,   8,	2, 81h,	41h
		db  1Dh,   8,	2, 81h,	42h
		db  1Fh,   8,	2, 81h,	43h
		db  21h,   8,	2, 81h,	44h
		db  23h,   8,	2, 81h,	45h
		db  25h,   8,	2, 81h,	48h
		db  27h,   8,	2, 81h,	49h
		db  29h,   8,	2, 81h,	7Ch
		db  2Bh,   8,	2, 81h,	60h
		db  2Dh,   8,	2, 81h,	40h
		db  40h,   6,	6, 87h,	40h
		db  40h,   7,	6, 87h,	41h
		db 0FFh
byte_1682B	db 30h,	44h, 58h, 6Ch, 80h, 94h, 0C8h, 0DCh, 0F0h ; DATA XREF: sub_12C3A+D3o
					; sub_12C3A+195r ...
byte_16834	db 30, 30, 26, 26, 30, 22, 27, 27, 20 ;	DATA XREF: sub_12FB6+6r
off_1683D	dw offset word_1684F, offset word_1688B, offset	word_168C7
					; DATA XREF: sub_12FB6+Cr
		dw offset word_168FB, offset word_1692F, offset	word_1696B
		dw offset word_16997, offset word_169CD, offset	word_16A03
word_1684F	dw   18h,  28h,	 38h,  48h,  58h,  78h,	 88h,  98h, 0A8h
					; DATA XREF: seg001:off_1683Do
		dw  0B8h, 0D8h,	0E8h, 0F8h, 108h, 118h,	138h, 148h, 158h
		dw  168h, 178h,	198h, 1A8h, 1B8h, 1C8h,	1D8h, 1F8h, 208h
		dw  218h, 228h,	238h
word_1688B	dw   18h,  28h,	 38h,  48h,  58h,  78h,	 88h,  98h, 0A8h
					; DATA XREF: seg001:off_1683Do
		dw  0B8h, 0D8h,	0E8h, 0F8h, 108h, 118h,	138h, 148h, 158h
		dw  168h, 178h,	198h, 1A8h, 1B8h, 1C8h,	1D8h, 1F8h, 208h
		dw  218h, 228h,	238h
word_168C7	dw   18h,  28h,	 38h,  48h,  58h,  78h,	 98h, 0B8h, 0D8h
					; DATA XREF: seg001:off_1683Do
		dw  0E8h, 0F8h,	108h, 118h, 138h, 148h,	158h, 168h, 178h
		dw  198h, 1B8h,	1D8h, 1F8h, 208h, 218h,	228h, 238h
word_168FB	dw   18h,  38h,	 58h,  78h,  88h,  98h,	0A8h, 0B8h, 0D8h
					; DATA XREF: seg001:off_1683Do
		dw  0E8h, 0F8h,	108h, 118h, 138h, 158h,	178h, 198h, 1A8h
		dw  1B8h, 1C8h,	1D8h, 1F8h, 208h, 218h,	228h, 238h
word_1692F	dw   18h,  28h,	 38h,  48h,  58h,  78h,	 88h,  98h, 0A8h
					; DATA XREF: seg001:off_1683Do
		dw  0B8h, 0D8h,	0E8h, 0F8h, 108h, 118h,	138h, 148h, 158h
		dw  168h, 178h,	198h, 1A8h, 1B8h, 1C8h,	1D8h, 1F8h, 208h
		dw  218h, 228h,	238h
word_1696B	dw   18h,  28h,	 38h,  48h,  58h,  78h,	 98h, 0B8h, 0D8h
					; DATA XREF: seg001:off_1683Do
		dw  0F8h, 118h,	138h, 148h, 158h, 168h,	178h, 198h, 1B8h
		dw  1D8h, 1F8h,	218h, 238h
word_16997	dw   38h,  48h,	 58h,  68h,  78h,  88h,	 98h, 0A8h, 0B8h
					; DATA XREF: seg001:off_1683Do
		dw  0C8h, 0D8h,	0E8h, 0F8h, 108h, 118h,	128h, 138h, 148h
		dw  158h, 168h,	178h, 188h, 198h, 1A8h,	1B8h, 1C8h, 200h
word_169CD	dw   38h,  48h,	 58h,  68h,  78h,  88h,	 98h, 0A8h, 0B8h
					; DATA XREF: seg001:off_1683Do
		dw  0C8h, 0D8h,	0E8h, 0F8h, 108h, 118h,	128h, 138h, 148h
		dw  158h, 168h,	178h, 188h, 198h, 1A8h,	1B8h, 1C8h, 200h
word_16A03	dw   38h,  48h,	 58h,  68h,  78h,  88h,	 98h, 0A8h, 0B8h
					; DATA XREF: seg001:off_1683Do
		dw  0C8h, 0D8h,	0E8h, 0F8h, 108h, 118h,	128h, 138h, 148h
		dw  158h, 168h
		db    0
		db 0FFh,0FFh,0FFh,0FFh,0FFh
		db 0FFh,0FFh,0FFh,0FFh,0FFh
		db 0FFh,0FFh,0FFh,0FFh,0FFh
		db 0FFh,0FFh,0FFh,0FFh,0FFh
		db 0FFh,0FFh,0FFh,0FFh,0FFh
		db 0FFh,0FFh,0FFh,0FFh,0FFh
		db 0FFh,0FFh,0FFh,0FFh,0FFh
		db 0FFh,0FFh,0FFh,0FFh,0FFh
		db 0FFh,0FFh,0FFh,0FFh,	  0
		db 0FFh,0FFh,0FFh,0FFh,	  0
		db 0FFh,0FFh,0FFh,0FFh,	  0
		db 0FFh,0FFh,0FFh,0FFh,	  0
		db 0FFh,0FFh,0FFh,0FFh,	  0
		db 0FFh,0FFh,0FFh,0FFh,	  0
		db 0FFh,0FFh,0FFh,0FFh,	  0
		db 0FFh,0FFh,0FFh,0FFh,	  0
		db 0FFh,0FFh,0FFh,   0,	  0
		db 0FFh,0FFh,0FFh,   0,	  0
		db 0FFh,0FFh,0FFh,   0,	  0
		db 0FFh,0FFh,0FFh,   0,	  0
		db 0FFh,0FFh,0FFh,   0,	  0
		db 0FFh,0FFh,0FFh,   0,	  0
		db 0FFh,0FFh,0FFh,   0,	  0
		db 0FFh,0FFh,0FFh,   0,	  0
		db 0FFh,0FFh,	0,   0,	  0
		db 0FFh,0FFh,	0,   0,	  0
		db 0FFh,0FFh,	0,   0,	  0
		db 0FFh,0FFh,	0,   0,	  0
		db 0FFh,0FFh,	0,   0,	  0
		db 0FFh,0FFh,	0,   0,	  0
		db 0FFh,0FFh,	0,   0,	  0
		db 0FFh,0FFh,	0,   0,	  0
		db 0FFh,   0,	0,   0,	  0
		db  7Fh,   0,	0,   0,	  0
		db  3Fh,   0,	0,   0,	  0
		db  1Fh,   0,	0,   0,	  0
		db  0Fh,   0,	0,   0,	  0
		db    7,   0,	0,   0,	  0
		db    3,   0,	0,   0,	  0
		db    1,   0,	0,   0,	  0
		align 10h
seg001		ends

; ===========================================================================

; Segment type:	Uninitialized
seg002		segment	byte stack 'STACK' use16
		assume cs:seg002
		assume es:nothing, ss:nothing, ds:nothing, fs:nothing, gs:nothing
byte_16B00	db 400h	dup(?)
seg002		ends

; ===========================================================================

; Segment type:	Zero-length
seg003		segment	byte public '' use16
unk_230F0	label byte
seg003		ends


		end start
