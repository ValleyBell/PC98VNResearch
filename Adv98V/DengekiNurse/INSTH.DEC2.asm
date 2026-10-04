; ---------------------------------------------------------------------------

FILE		struc ;	(sizeof=0xC, standard type)
_ptr		dd ?			; offset
_cnt		dw ?
_base		dd ?			; offset
_flag		db ?
_file		db ?
FILE		ends


; Input	MD5   :	B4BED43038A0B1872428E2DCA9E6A1D6
; Input	CRC32 :	E4A48F1F

; File Name   :	R:\INSTH.DEC2.EXE
; Format      :	MS-DOS executable (EXE)
; Base Address:	1000h Range: 10000h-24500h Loaded length: 125B0h
; Entry	Point :	1000:1BE
; OS type	  :  MS	DOS
; Application type:  Executable	16bit

		.686p
		.mmx
		.model large

; ===========================================================================

; Segment type:	Pure code
seg000		segment	byte public 'CODE' use16
		assume cs:seg000
		assume es:nothing, ss:nothing, ds:dseg,	fs:nothing, gs:nothing
		db 10h dup(0)

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

; int __cdecl main(int argc, const char	**argv,	const char **envp)
_main		proc near		; CODE XREF: start+8Dp

var_2		= word ptr -2
argc		= word ptr  4
argv		= dword	ptr  6
envp		= dword	ptr  0Ah

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	di
		push	si
		call	ShowInstruct
		cmp	[bp+argc], 3
		jz	short loc_10024
		call	ShowSyntax
; ---------------------------------------------------------------------------

loc_10024:				; CODE XREF: _main+Fj
		mov	bx, word ptr [bp+argv]
		push	word ptr [bx+4]
		push	word ptr [bx+2]
		call	sub_10166
		add	sp, 4
		mov	al, byte_225A6
		sub	ah, ah
		push	ax
		mov	al, byte_225A7
		push	ax
		mov	ax, offset aInstallNote	; ">>> ÉhÉâÉCÉu	%c: Ç©ÇÁ %c: Ç÷	ÉCÉìÉXÉgÅ["...
		push	ax		; char *
		call	_printf
		add	sp, 6
		mov	ax, offset aPressAnyKey	; ">>> ÇÊÇÎÇµÇØÇÍÇŒâΩÇ©ÉLÅ[ÇâüÇµÇƒÇ≠ÇæÇ≥Ç"...
		push	ax		; char *
		call	_printf
		add	sp, 2
		mov	ax, 8
		push	ax		; unsigned int
		sub	ax, ax
		push	ax		; unsigned int
		mov	ax, 0Ch
		push	ax		; int
		call	_bdos
		add	sp, 6
		mov	al, byte_225A7
		sub	ah, ah
		push	ax		; char *
		mov	ax, offset aC	; "%c:\\"
		push	ax
		mov	ax, offset byte_225A8
		push	ax		; char *
		call	_sprintf
		add	sp, 6
		mov	ax, offset aStartFileTitle ; "NURSE"
		push	ax
		mov	al, byte_225A6
		sub	ah, ah
		push	ax		; char *
		mov	ax, offset aCS	; "%c:\\%s"
		push	ax
		mov	ax, offset byte_225C8
		push	ax		; char *
		call	_sprintf
		add	sp, 8
		mov	ax, offset off_21F30
		push	ax
		mov	ax, offset byte_225C8
		push	ax		; char *
		call	CreateFolder
		add	sp, 4
		push	si
		mov	di, offset asc_21EF9 ; "\\"
		mov	si, offset byte_225C8
		mov	ax, ds
		mov	es, ax
		assume es:dseg
		mov	cx, 0FFFFh
		xor	ax, ax
		repne scasb
		not	cx
		sub	di, cx
		mov	bx, cx
		xchg	di, si
		mov	cx, 0FFFFh
		repne scasb
		dec	di
		mov	cx, bx
		shr	cx, 1
		repne movsw
		adc	cx, cx
		repne movsb
		pop	si
		sub	si, si
		jmp	short loc_100F5
; ---------------------------------------------------------------------------
		align 2

loc_100CC:				; CODE XREF: _main+E9j
		mov	ax, offset aDNurse98 ; "ìdåÇ≈∞Ω_.98"
		push	ax		; char *
		mov	ax, si
		add	ax, 'A'
		push	ax		; char
		mov	al, byte_225A7
		sub	ah, ah
		push	ax		; char
		call	sub_11BB0
		add	sp, 6
		mov	ax, offset off_21F30
		push	ax		; int
		mov	ax, offset byte_225C8
		push	ax
		mov	ax, offset byte_225A8
		push	ax		; char *
		call	CopyFile
		add	sp, 6
		inc	si

loc_100F5:				; CODE XREF: _main+B9j
		cmp	si, filesToCopy
		jl	short loc_100CC
		mov	[bp+var_2], si
		mov	ax, offset aStartFileTitle ; "NURSE"
		push	ax
		mov	al, byte_225A6
		sub	ah, ah
		push	ax
		call	CreateStartFile
		add	sp, 4
		mov	ax, offset aExitProgram	; "\n>>> èIóπÇµÇ‹ÇµÇΩÅB\n"
		push	ax		; char *
		call	_printf
		add	sp, 2
		sub	ax, ax
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retn
_main		endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: noreturn bp-based	frame

; int __cdecl error_exit(char *)
error_exit	proc near		; CODE XREF: sub_10166+4Fp
					; CopyFile+37p	...

arg_0		= dword	ptr  4

		push	bp
		mov	bp, sp
		push	word ptr [bp+arg_0] ; char *
		mov	ax, offset aErrorNum ; "\nÉGÉâÅ[: %s."
		push	ax
		mov	ax, offset byte_2204A
		push	ax		; FILE *
		call	_fprintf
		add	sp, 6
		cmp	word ptr [bp+arg_0+2], 0
		jz	short loc_1014B
		push	word ptr [bp+arg_0+2] ;	char *
		mov	ax, offset aS	; "(%s)"
		push	ax
		mov	ax, offset byte_2204A
		push	ax		; FILE *
		call	_fprintf
		add	sp, 6

loc_1014B:				; CODE XREF: error_exit+18j
		mov	ax, offset byte_2204A
		push	ax		; FILE *
		mov	ax, 0Ah
		push	ax		; int
		call	_fputc
		add	sp, 4
		mov	ax, 1
		push	ax		; int
		call	_exit
error_exit	endp

; ---------------------------------------------------------------------------
		add	sp, 2
		pop	bp
		retn
; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_10166	proc near		; CODE XREF: _main+1Dp

arg_0		= word ptr  4
arg_2		= word ptr  6

		push	bp
		mov	bp, sp
		mov	bx, [bp+arg_0]
		mov	bl, [bx]
		sub	bh, bh
		test	byte ptr [bx+36Fh], 2
		jz	short loc_10180
		mov	bx, [bp+arg_0]
		mov	al, [bx]
		add	al, 0E0h ; '‡'
		jmp	short loc_10185
; ---------------------------------------------------------------------------

loc_10180:				; CODE XREF: sub_10166+Fj
		mov	bx, [bp+arg_0]
		mov	al, [bx]

loc_10185:				; CODE XREF: sub_10166+18j
		mov	byte_225A7, al
		mov	bx, [bp+arg_2]
		mov	bl, [bx]
		sub	bh, bh
		test	byte ptr [bx+36Fh], 2
		jz	short loc_101A0
		mov	bx, [bp+arg_2]
		mov	al, [bx]
		add	al, 0E0h ; '‡'
		jmp	short loc_101A5
; ---------------------------------------------------------------------------
		align 2

loc_101A0:				; CODE XREF: sub_10166+2Ej
		mov	bx, [bp+arg_2]
		mov	al, [bx]

loc_101A5:				; CODE XREF: sub_10166+37j
		mov	byte_225A6, al
		cmp	byte_225A7, al
		jnz	short loc_101BB
		sub	ax, ax
		push	ax
		mov	ax, offset aBadDrive ; "ÉhÉâÉCÉuÇÃéwíËÇ™à·Ç¢Ç‹Ç∑ÅB"
		push	ax		; char *
		call	error_exit
; ---------------------------------------------------------------------------
		add	sp, 4

loc_101BB:				; CODE XREF: sub_10166+46j
		pop	bp
		retn
sub_10166	endp

; ---------------------------------------------------------------------------
		align 2
		assume ss:seg003, ds:nothing
; [000000B2 BYTES: COLLAPSED FUNCTION start. PRESS KEYPAD "+" TO EXPAND]
; [000000C4 BYTES: COLLAPSED FUNCTION __cinit. PRESS KEYPAD "+"	TO EXPAND]
; [00000017 BYTES: COLLAPSED FUNCTION _exit. PRESS KEYPAD "+" TO EXPAND]
; [00000045 BYTES: COLLAPSED FUNCTION __exit. PRESS KEYPAD "+" TO EXPAND]
; [0000002D BYTES: COLLAPSED FUNCTION __ctermsub. PRESS	KEYPAD "+" TO EXPAND]
; [0000000F BYTES: COLLAPSED FUNCTION sub_103BD. PRESS KEYPAD "+" TO EXPAND]
; [00000013 BYTES: COLLAPSED FUNCTION sub_103CC. PRESS KEYPAD "+" TO EXPAND]
		align 2
; [00000020 BYTES: COLLAPSED FUNCTION __FF_MSGBANNER. PRESS KEYPAD "+" TO EXPAND]
; [00000006 BYTES: COLLAPSED FUNCTION __fptrap.	PRESS KEYPAD "+" TO EXPAND]
; [00000016 BYTES: COLLAPSED FUNCTION __chkstk.	PRESS KEYPAD "+" TO EXPAND]
; [00000022 BYTES: COLLAPSED FUNCTION __nullcheck. PRESS KEYPAD	"+" TO EXPAND]
; [0000018E BYTES: COLLAPSED FUNCTION __setargv. PRESS KEYPAD "+" TO EXPAND]
; [0000006E BYTES: COLLAPSED FUNCTION __setenvp. PRESS KEYPAD "+" TO EXPAND]
; [0000002B BYTES: COLLAPSED FUNCTION __NMSG_TEXT. PRESS KEYPAD	"+" TO EXPAND]
; [00000029 BYTES: COLLAPSED FUNCTION __NMSG_WRITE. PRESS KEYPAD "+" TO	EXPAND]
; [00000042 BYTES: COLLAPSED FUNCTION __myalloc. PRESS KEYPAD "+" TO EXPAND]
; ---------------------------------------------------------------------------
; [00000008 BYTES: COLLAPSED CHUNK OF FUNCTION _mkdir. PRESS KEYPAD "+"	TO EXPAND]
; ---------------------------------------------------------------------------

__dosreturn:
		jnb	short loc_106D2
		push	ax
		call	sub_106F6
		pop	ax
		mov	sp, bp
		pop	bp
		retn
; ---------------------------------------------------------------------------
; [0000000D BYTES: COLLAPSED CHUNK OF FUNCTION _open. PRESS KEYPAD "+" TO EXPAND]
; ---------------------------------------------------------------------------

__maperror:
		xor	ah, ah
		call	sub_106F6
		retn

; =============== S U B	R O U T	I N E =======================================


sub_106F6	proc near		; CODE XREF: seg000:06DBp
					; _open:loc_106E5p ...
		mov	byte_21FF2, al
		or	ah, ah
		jnz	short loc_10720
		cmp	byte ptr word_21FEF, 3
		jb	short loc_10711
		cmp	al, 22h	; '"'
		jnb	short loc_10715
		cmp	al, 20h	; ' '
		jb	short loc_10711
		mov	al, 5
		jmp	short loc_10717
; ---------------------------------------------------------------------------
		db 90h
; ---------------------------------------------------------------------------

loc_10711:				; CODE XREF: sub_106F6+Cj
					; sub_106F6+14j
		cmp	al, 13h
		jbe	short loc_10717

loc_10715:				; CODE XREF: sub_106F6+10j
		mov	al, 13h

loc_10717:				; CODE XREF: sub_106F6+18j
					; sub_106F6+1Dj
		mov	bx, 204h
		xlat

loc_1071B:				; CODE XREF: sub_106F6+2Cj
		cbw
		mov	word_21FE7, ax
		retn
; ---------------------------------------------------------------------------

loc_10720:				; CODE XREF: sub_106F6+5j
		mov	al, ah
		jmp	short loc_1071B
sub_106F6	endp

; [00000032 BYTES: COLLAPSED FUNCTION _flushall. PRESS KEYPAD "+" TO EXPAND]
; [0000003D BYTES: COLLAPSED FUNCTION _fprintf.	PRESS KEYPAD "+" TO EXPAND]
		align 2
; [0000003C BYTES: COLLAPSED FUNCTION _printf. PRESS KEYPAD "+"	TO EXPAND]
; [00000155 BYTES: COLLAPSED FUNCTION __flsbuf.	PRESS KEYPAD "+" TO EXPAND]
		align 2
; [0000006C BYTES: COLLAPSED FUNCTION __getbuf.	PRESS KEYPAD "+" TO EXPAND]
; [00000084 BYTES: COLLAPSED FUNCTION __stbuf. PRESS KEYPAD "+"	TO EXPAND]
; [00000096 BYTES: COLLAPSED FUNCTION __ftbuf. PRESS KEYPAD "+"	TO EXPAND]
; [0000006E BYTES: COLLAPSED FUNCTION _fflush. PRESS KEYPAD "+"	TO EXPAND]

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_10B1A	proc near		; CODE XREF: _fprintf+23p _printf+22p	...

var_164		= word ptr -164h
var_162		= byte ptr -162h
var_4		= word ptr -4
arg_0		= word ptr  4
arg_2		= word ptr  6
arg_4		= word ptr  8

		push	bp
		mov	bp, sp
		mov	ax, 164h
		call	__chkstk
		push	di
		push	si
		mov	si, [bp+arg_2]
		lea	ax, [bp+var_162]
		mov	word_22606, ax
		mov	ax, [bp+arg_4]
		mov	word_225F6, ax
		mov	ax, [bp+arg_0]
		mov	word_225EA, ax
		mov	word_22600, 0
		mov	word_225FE, 0
		jmp	loc_10E46
; ---------------------------------------------------------------------------

loc_10B4A:				; CODE XREF: sub_10B1A+331j
		cmp	byte ptr [si], 25h ; '%'
		jz	short loc_10B52
		jmp	loc_10DF8
; ---------------------------------------------------------------------------

loc_10B52:				; CODE XREF: sub_10B1A+33j
		mov	word_22602, 1
		sub	ax, ax
		mov	word_225F2, ax
		mov	word_225EE, ax
		mov	word_225FC, ax
		mov	word_225F0, ax
		mov	word_225FA, ax
		mov	word_225F8, ax
		mov	word_225EC, ax
		mov	word_225E8, ax
		mov	word_225F4, ax
		mov	word_2260C, 20h	; ' '
		cmp	byte ptr [si+1], 30h ; '0'
		jnz	short loc_10BBD
		inc	si
		mov	word_2260C, 30h	; '0'
		jmp	short loc_10BBD
; ---------------------------------------------------------------------------

loc_10B8A:				; CODE XREF: sub_10B1A+9Dj
		cmp	byte ptr [si], 2Bh ; '+'
		jnz	short loc_10B9C
		inc	word_225F2
		mov	word_225F8, 0
		jmp	short loc_10BBD
; ---------------------------------------------------------------------------
		align 2

loc_10B9C:				; CODE XREF: sub_10B1A+73j
		cmp	byte ptr [si], 20h ; ' '
		jnz	short loc_10BAE
		cmp	word_225F2, 0
		jnz	short loc_10BBD
		inc	word_225F8
		jmp	short loc_10BBD
; ---------------------------------------------------------------------------

loc_10BAE:				; CODE XREF: sub_10B1A+85j
		inc	word_225E8
		jmp	short loc_10BBD
; ---------------------------------------------------------------------------

loc_10BB4:				; CODE XREF: sub_10B1A+B0j
		cmp	byte ptr [si], 2Dh ; '-'
		jnz	short loc_10B8A
		inc	word_225F4

loc_10BBD:				; CODE XREF: sub_10B1A+65j
					; sub_10B1A+6Ej ...
		inc	si
		mov	al, [si]
		cbw
		push	ax
		call	sub_113EE
		add	sp, 2
		or	ax, ax
		jnz	short loc_10BB4
		push	si
		mov	ax, 7E8h
		push	ax
		call	sub_1136E
		add	sp, 4
		mov	si, ax
		cmp	word_22608, 0
		jge	short loc_10BEC
		inc	word_225F4
		mov	ax, word_22608
		neg	ax
		mov	word_22608, ax

loc_10BEC:				; CODE XREF: sub_10B1A+C4j
		cmp	byte ptr [si], 2Eh ; '.'
		jnz	short loc_10C14
		inc	word_225FA
		inc	si
		push	si
		mov	ax, 7E2h
		push	ax
		call	sub_1136E
		add	sp, 4
		mov	si, ax
		cmp	word_22602, 0
		jge	short loc_10C14
		mov	word_22602, 1
		dec	word_225FA

loc_10C14:				; CODE XREF: sub_10B1A+D5j
					; sub_10B1A+EEj
		mov	al, [si]
		cbw
		cmp	ax, 46h	; 'F'
		jz	short loc_10C4E
		cmp	ax, 4Eh	; 'N'
		jz	short loc_10C56
		cmp	ax, 68h	; 'h'
		jz	short loc_10C46
		cmp	ax, 6Ch	; 'l'
		jnz	short loc_10C31
		mov	word_225F0, 2

loc_10C31:				; CODE XREF: sub_10B1A+10Fj
					; sub_10B1A+132j ...
		cmp	word_225F0, 0
		jnz	short loc_10C3D
		cmp	byte ptr [si], 4Ch ; 'L'
		jnz	short loc_10C3E

loc_10C3D:				; CODE XREF: sub_10B1A+11Cj
		inc	si

loc_10C3E:				; CODE XREF: sub_10B1A+121j
		cmp	byte ptr [si], 0
		jnz	short loc_10C5E
		jmp	loc_10E4E
; ---------------------------------------------------------------------------

loc_10C46:				; CODE XREF: sub_10B1A+10Aj
		mov	word_225F0, 1
		jmp	short loc_10C31
; ---------------------------------------------------------------------------

loc_10C4E:				; CODE XREF: sub_10B1A+100j
		mov	word_225F0, 10h
		jmp	short loc_10C31
; ---------------------------------------------------------------------------

loc_10C56:				; CODE XREF: sub_10B1A+105j
		mov	word_225F0, 8
		jmp	short loc_10C31
; ---------------------------------------------------------------------------

loc_10C5E:				; CODE XREF: sub_10B1A+127j
		mov	al, [si]
		cbw
		mov	[bp+var_164], ax
		cmp	ax, 45h	; 'E'
		jz	short loc_10C74
		cmp	ax, 47h	; 'G'
		jz	short loc_10C74
		cmp	ax, 58h	; 'X'
		jnz	short loc_10C7D

loc_10C74:				; CODE XREF: sub_10B1A+14Ej
					; sub_10B1A+153j
		inc	word_225EE
		add	[bp+var_164], 20h ; ' '

loc_10C7D:				; CODE XREF: sub_10B1A+158j
		mov	ax, [bp+var_164]
		cmp	ax, 69h	; 'i'
		jz	short loc_10CE0
		jle	short loc_10C8B
		jmp	loc_10DFC
; ---------------------------------------------------------------------------

loc_10C8B:				; CODE XREF: sub_10B1A+16Cj
		cmp	ax, 63h	; 'c'
		jnz	short loc_10C93
		jmp	loc_10DC2
; ---------------------------------------------------------------------------

loc_10C93:				; CODE XREF: sub_10B1A+174j
		jle	short loc_10C98
		jmp	loc_10DDC
; ---------------------------------------------------------------------------

loc_10C98:				; CODE XREF: sub_10B1A:loc_10C93j
		cmp	ax, 25h	; '%'
		jnz	short loc_10CA0
		jmp	loc_10DD2
; ---------------------------------------------------------------------------

loc_10CA0:				; CODE XREF: sub_10B1A+181j
		jmp	loc_10DEE
; ---------------------------------------------------------------------------
		align 2

loc_10CA4:				; CODE XREF: sub_10B1A+2E7j
		mov	bx, word_225F6
		mov	bx, [bx]
		mov	ax, word_225FE
		mov	[bx], ax

loc_10CAF:				; CODE XREF: sub_10B1A+295j
		add	word_225F6, 2

loc_10CB4:				; CODE XREF: sub_10B1A+1D6j
		cmp	word_22600, 0
		jnz	short loc_10CBE
		jmp	loc_10E28
; ---------------------------------------------------------------------------

loc_10CBE:				; CODE XREF: sub_10B1A+19Fj
		cmp	word_225FE, 0
		jz	short loc_10CC8
		jmp	loc_10E62
; ---------------------------------------------------------------------------

loc_10CC8:				; CODE XREF: sub_10B1A+1A9j
		mov	bx, word_225EA
		test	byte ptr [bx+6], 20h
		jnz	short loc_10CD5
		jmp	loc_10E62
; ---------------------------------------------------------------------------

loc_10CD5:				; CODE XREF: sub_10B1A+1B6j
					; sub_10B1A+345j
		mov	ax, 0FFFFh
		jmp	loc_10E65
; ---------------------------------------------------------------------------
		align 2

loc_10CDC:				; CODE XREF: sub_10B1A+304j
		inc	word_225FC

loc_10CE0:				; CODE XREF: sub_10B1A+16Aj
					; sub_10B1A+2C7j
		mov	word_225E8, 0
		mov	ax, 0Ah

loc_10CE9:				; CODE XREF: sub_10B1A+1DBj
					; sub_10B1A+29Bj
		push	ax
		call	sub_10E6C

loc_10CED:				; CODE XREF: sub_10B1A+2A4j
					; sub_10B1A+2B5j ...
		add	sp, 2
		jmp	short loc_10CB4
; ---------------------------------------------------------------------------

loc_10CF2:				; CODE XREF: sub_10B1A+2EFj
		mov	ax, 8
		jmp	short loc_10CE9
; ---------------------------------------------------------------------------
		align 2

loc_10CF8:				; CODE XREF: sub_10B1A+2F7j
		inc	word_225EC
		inc	word_225EE
		cmp	word_225FA, 0
		jnz	short loc_10D10
		mov	word_22604, 1
		jmp	short loc_10D16
; ---------------------------------------------------------------------------
		align 2

loc_10D10:				; CODE XREF: sub_10B1A+1EBj
		mov	word_22604, 0

loc_10D16:				; CODE XREF: sub_10B1A+1F3j
		inc	word_225FA
		mov	word_22602, 4
		cmp	word_225F0, 8
		jnz	short loc_10D2A
		jmp	loc_10DB2
; ---------------------------------------------------------------------------

loc_10D2A:				; CODE XREF: sub_10B1A+20Bj
		sub	ax, ax
		mov	word_225F0, ax
		mov	[bp+var_4], ax
		cmp	word_22608, ax
		jz	short loc_10D5F
		mov	ax, word_22608
		mov	[bp+var_4], ax
		cmp	word_225F4, 0
		jz	short loc_10D4E
		mov	word_22608, 0
		jmp	short loc_10D5F
; ---------------------------------------------------------------------------
		align 2

loc_10D4E:				; CODE XREF: sub_10B1A+229j
		sub	word_22608, 5
		mov	ax, word_22608
		or	ax, ax
		jge	short loc_10D5C
		sub	ax, ax

loc_10D5C:				; CODE XREF: sub_10B1A+23Ej
		mov	word_22608, ax

loc_10D5F:				; CODE XREF: sub_10B1A+21Cj
					; sub_10B1A+231j
		add	word_225F6, 2
		mov	ax, 10h
		push	ax
		call	sub_10E6C
		add	sp, 2
		mov	ax, 3Ah	; ':'
		push	ax
		call	sub_11146
		add	sp, 2
		cmp	[bp+var_4], 0
		jz	short loc_10DA0
		cmp	word_225F4, 0
		jz	short loc_10D9A
		mov	ax, [bp+var_4]
		sub	ax, 5
		mov	word_22608, ax
		or	ax, ax
		jge	short loc_10D94
		sub	ax, ax

loc_10D94:				; CODE XREF: sub_10B1A+276j
		mov	word_22608, ax
		jmp	short loc_10DA0
; ---------------------------------------------------------------------------
		align 2

loc_10D9A:				; CODE XREF: sub_10B1A+269j
		mov	word_22608, 0

loc_10DA0:				; CODE XREF: sub_10B1A+262j
					; sub_10B1A+27Dj
		sub	word_225F6, 4
		mov	ax, 10h
		push	ax
		call	sub_10E6C
		add	sp, 2
		jmp	loc_10CAF
; ---------------------------------------------------------------------------

loc_10DB2:				; CODE XREF: sub_10B1A+20Dj
					; sub_10B1A+30Aj
		mov	ax, 10h
		jmp	loc_10CE9
; ---------------------------------------------------------------------------

loc_10DB8:				; CODE XREF: sub_10B1A+2FDj
		sub	ax, ax

loc_10DBA:				; CODE XREF: sub_10B1A+2ABj
		push	ax
		call	sub_10FA2
		jmp	loc_10CED
; ---------------------------------------------------------------------------
		align 2

loc_10DC2:				; CODE XREF: sub_10B1A+176j
		mov	ax, 1
		jmp	short loc_10DBA
; ---------------------------------------------------------------------------
		align 2

loc_10DC8:				; CODE XREF: sub_10B1A+2D2j
		push	[bp+var_164]
		call	sub_1108A
; ---------------------------------------------------------------------------
		jmp	loc_10CED
; ---------------------------------------------------------------------------

loc_10DD2:				; CODE XREF: sub_10B1A+183j
		mov	ax, 25h	; '%'
		push	ax
		call	sub_11146
		jmp	loc_10CED
; ---------------------------------------------------------------------------

loc_10DDC:				; CODE XREF: sub_10B1A+17Bj
		cmp	ax, 64h	; 'd'
		jnz	short loc_10DE4
		jmp	loc_10CE0
; ---------------------------------------------------------------------------

loc_10DE4:				; CODE XREF: sub_10B1A+2C5j
		cmp	ax, 65h	; 'e'
		jl	short loc_10DEE
		cmp	ax, 67h	; 'g'
		jle	short loc_10DC8

loc_10DEE:				; CODE XREF: sub_10B1A:loc_10CA0j
					; sub_10B1A+2CDj ...
		cmp	word_225F0, 0
		jz	short loc_10DF8
		mov	ax, si
		dec	si

loc_10DF8:				; CODE XREF: sub_10B1A+35j
					; sub_10B1A+2D9j
		mov	di, si
		jmp	short loc_10E2C
; ---------------------------------------------------------------------------

loc_10DFC:				; CODE XREF: sub_10B1A+16Ej
		cmp	ax, 6Eh	; 'n'
		jnz	short loc_10E04
		jmp	loc_10CA4
; ---------------------------------------------------------------------------

loc_10E04:				; CODE XREF: sub_10B1A+2E5j
		cmp	ax, 6Fh	; 'o'
		jnz	short loc_10E0C
		jmp	loc_10CF2
; ---------------------------------------------------------------------------

loc_10E0C:				; CODE XREF: sub_10B1A+2EDj
		cmp	ax, 70h	; 'p'
		jnz	short loc_10E14
		jmp	loc_10CF8
; ---------------------------------------------------------------------------

loc_10E14:				; CODE XREF: sub_10B1A+2F5j
		cmp	ax, 73h	; 's'
		jz	short loc_10DB8
		cmp	ax, 75h	; 'u'
		jnz	short loc_10E21
		jmp	loc_10CDC
; ---------------------------------------------------------------------------

loc_10E21:				; CODE XREF: sub_10B1A+302j
		cmp	ax, 78h	; 'x'
		jz	short loc_10DB2
		jmp	short loc_10DEE
; ---------------------------------------------------------------------------

loc_10E28:				; CODE XREF: sub_10B1A+1A1j
		inc	si
		jmp	short loc_10E46
; ---------------------------------------------------------------------------
		align 2

loc_10E2C:				; CODE XREF: sub_10B1A+2E0j
					; sub_10B1A+31Bj
		inc	di
		cmp	byte ptr [di], 0
		jz	short loc_10E37
		cmp	byte ptr [di], 25h ; '%'
		jnz	short loc_10E2C

loc_10E37:				; CODE XREF: sub_10B1A+316j
		mov	ax, di
		sub	ax, si
		push	ax
		push	ds
		push	si
		call	sub_111E2
		add	sp, 6
		mov	si, di

loc_10E46:				; CODE XREF: sub_10B1A+2Dj
					; sub_10B1A+30Fj
		cmp	byte ptr [si], 0
		jz	short loc_10E4E
		jmp	loc_10B4A
; ---------------------------------------------------------------------------

loc_10E4E:				; CODE XREF: sub_10B1A+129j
					; sub_10B1A+32Fj
		cmp	word_225FE, 0
		jnz	short loc_10E62
		mov	bx, word_225EA
		test	byte ptr [bx+6], 20h
		jz	short loc_10E62
		jmp	loc_10CD5
; ---------------------------------------------------------------------------

loc_10E62:				; CODE XREF: sub_10B1A+1ABj
					; sub_10B1A+1B8j ...
		mov	ax, word_225FE

loc_10E65:				; CODE XREF: sub_10B1A+1BEj
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retn
sub_10B1A	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_10E6C	proc near		; CODE XREF: sub_10B1A+1D0p
					; sub_10B1A+24Ep ...

var_18		= byte ptr -18h
var_C		= word ptr -0Ch
var_8		= word ptr -8
var_4		= dword	ptr -4
arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		sub	sp, 18h
		push	di
		push	si
		cmp	[bp+arg_0], 0Ah
		jz	short loc_10E7E
		inc	word_225FC

loc_10E7E:				; CODE XREF: sub_10E6C+Cj
		cmp	word_225F0, 2
		jz	short loc_10E8C
		cmp	word_225F0, 10h
		jnz	short loc_10EA2

loc_10E8C:				; CODE XREF: sub_10E6C+17j
		mov	bx, word_225F6
		mov	ax, [bx]
		mov	dx, [bx+2]
		mov	word ptr [bp+var_4], ax
		mov	word ptr [bp+var_4+2], dx
		add	word_225F6, 4
		jmp	short loc_10ECC
; ---------------------------------------------------------------------------

loc_10EA2:				; CODE XREF: sub_10E6C+1Ej
		cmp	word_225FC, 0
		jz	short loc_10EBA
		mov	bx, word_225F6
		mov	ax, [bx]
		mov	word ptr [bp+var_4], ax
		mov	word ptr [bp+var_4+2], 0
		jmp	short loc_10EC7
; ---------------------------------------------------------------------------
		align 2

loc_10EBA:				; CODE XREF: sub_10E6C+3Bj
		mov	bx, word_225F6
		mov	ax, [bx]
		cwd
		mov	word ptr [bp+var_4], ax
		mov	word ptr [bp+var_4+2], dx

loc_10EC7:				; CODE XREF: sub_10E6C+4Bj
		add	word_225F6, 2

loc_10ECC:				; CODE XREF: sub_10E6C+34j
		cmp	word_225E8, 0
		jz	short loc_10EE0
		mov	ax, word ptr [bp+var_4]
		or	ax, word ptr [bp+var_4+2]
		jz	short loc_10EE0
		mov	ax, [bp+arg_0]
		jmp	short loc_10EE2
; ---------------------------------------------------------------------------

loc_10EE0:				; CODE XREF: sub_10E6C+65j
					; sub_10E6C+6Dj
		sub	ax, ax

loc_10EE2:				; CODE XREF: sub_10E6C+72j
		mov	word_2260A, ax
		mov	si, word_22606
		cmp	word_225FC, 0
		jnz	short loc_10F1A
		cmp	word ptr [bp+var_4+2], 0
		jge	short loc_10F1A
		cmp	[bp+arg_0], 0Ah
		jnz	short loc_10F13
		mov	byte ptr [si], 2Dh ; '-'
		inc	si
		mov	ax, word ptr [bp+var_4]
		mov	dx, word ptr [bp+var_4+2]
		neg	ax
		adc	dx, 0
		neg	dx
		mov	word ptr [bp+var_4], ax
		mov	word ptr [bp+var_4+2], dx

loc_10F13:				; CODE XREF: sub_10E6C+8Ej
		mov	[bp+var_8], 1
		jmp	short loc_10F1F
; ---------------------------------------------------------------------------

loc_10F1A:				; CODE XREF: sub_10E6C+82j
					; sub_10E6C+88j
		mov	[bp+var_8], 0

loc_10F1F:				; CODE XREF: sub_10E6C+ACj
		lea	ax, [bp+var_18]
		mov	di, ax
		push	[bp+arg_0]
		push	di		; char *
		push	word ptr [bp+var_4+2]
		push	word ptr [bp+var_4] ; unsigned __int32
		call	_ultoa
		add	sp, 8
		cmp	word_225FA, 0
		jz	short loc_10F5C
		push	di		; char *
		call	_strlen
		add	sp, 2
		mov	cx, word_22602
		sub	cx, ax
		mov	[bp+var_C], cx
		jmp	short loc_10F52
; ---------------------------------------------------------------------------
		align 2

loc_10F4E:				; CODE XREF: sub_10E6C+EBj
		mov	byte ptr [si], 30h ; '0'
		inc	si

loc_10F52:				; CODE XREF: sub_10E6C+DFj
		mov	ax, cx
		dec	cx
		or	ax, ax
		jg	short loc_10F4E
		mov	[bp+var_C], cx

loc_10F5C:				; CODE XREF: sub_10E6C+CDj
		mov	cx, word_225EE

loc_10F60:				; CODE XREF: sub_10E6C+109j
		mov	al, [di]
		mov	[si], al
		or	cx, cx
		jz	short loc_10F6F
		cmp	al, 61h	; 'a'
		jl	short loc_10F6F
		sub	byte ptr [si], 20h ; ' '

loc_10F6F:				; CODE XREF: sub_10E6C+FAj
					; sub_10E6C+FEj
		inc	si
		inc	di
		cmp	byte ptr [di-1], 0
		jnz	short loc_10F60
		cmp	word_225FC, 0
		jnz	short loc_10F92
		mov	ax, word_225F2
		or	ax, word_225F8
		jz	short loc_10F92
		cmp	[bp+var_8], 0
		jnz	short loc_10F92
		mov	ax, 1
		jmp	short loc_10F94
; ---------------------------------------------------------------------------

loc_10F92:				; CODE XREF: sub_10E6C+110j
					; sub_10E6C+119j ...
		sub	ax, ax

loc_10F94:				; CODE XREF: sub_10E6C+124j
		push	ax
		call	sub_1124A
		add	sp, 2
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retn
sub_10E6C	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_10FA2	proc near		; CODE XREF: sub_10B1A+2A1p

var_E		= dword	ptr -0Eh
var_8		= word ptr -8
var_6		= word ptr -6
var_4		= word ptr -4
arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		sub	sp, 10h
		push	di
		push	si
		cmp	[bp+arg_0], 0
		jz	short loc_10FC4
		mov	si, 1
		mov	ax, word_225F6
		mov	[bp+var_8], ax
		mov	[bp+var_6], ds
		add	word_225F6, 2
		jmp	loc_11055
; ---------------------------------------------------------------------------

loc_10FC4:				; CODE XREF: sub_10FA2+Cj
		cmp	word_225F0, 10h
		jnz	short loc_10FE2
		mov	bx, word_225F6
		mov	ax, [bx]
		mov	dx, [bx+2]
		mov	[bp+var_8], ax
		mov	[bp+var_6], dx
		add	word_225F6, 4
		jmp	short loc_10FF6
; ---------------------------------------------------------------------------
		align 2

loc_10FE2:				; CODE XREF: sub_10FA2+27j
		mov	bx, word_225F6
		mov	ax, [bx]
		mov	[bp+var_4], ax
		mov	[bp+var_8], ax
		mov	[bp+var_6], ds
		add	word_225F6, 2

loc_10FF6:				; CODE XREF: sub_10FA2+3Dj
		cmp	word_225F0, 10h
		jnz	short loc_1100A
		mov	ax, [bp+var_8]
		or	ax, [bp+var_6]
		jnz	short loc_11019
		mov	ax, 334h
		jmp	short loc_11013
; ---------------------------------------------------------------------------

loc_1100A:				; CODE XREF: sub_10FA2+59j
		cmp	[bp+var_4], 0
		jnz	short loc_11019
		mov	ax, 33Bh

loc_11013:				; CODE XREF: sub_10FA2+66j
		mov	[bp+var_8], ax
		mov	[bp+var_6], ds

loc_11019:				; CODE XREF: sub_10FA2+61j
					; sub_10FA2+6Cj
		mov	ax, [bp+var_8]
		mov	dx, [bp+var_6]
		mov	word ptr [bp+var_E], ax
		mov	word ptr [bp+var_E+2], dx
		sub	si, si
		cmp	word_225FA, si
		jz	short loc_11049
		mov	cx, word_22602
		jmp	short loc_11041
; ---------------------------------------------------------------------------
		align 2

loc_11034:				; CODE XREF: sub_10FA2+A3j
		les	bx, [bp+var_E]
		inc	word ptr [bp+var_E]
		cmp	byte ptr es:[bx], 0
		jz	short loc_11055
		inc	si

loc_11041:				; CODE XREF: sub_10FA2+8Fj
		cmp	cx, si
		jle	short loc_11055
		jmp	short loc_11034
; ---------------------------------------------------------------------------
		align 2

loc_11048:				; CODE XREF: sub_10FA2+B1j
		inc	si

loc_11049:				; CODE XREF: sub_10FA2+89j
		les	bx, [bp+var_E]
		inc	word ptr [bp+var_E]
		cmp	byte ptr es:[bx], 0
		jnz	short loc_11048

loc_11055:				; CODE XREF: sub_10FA2+1Fj
					; sub_10FA2+9Cj ...
		mov	di, word_22608
		sub	di, si
		cmp	word_225F4, 0
		jnz	short loc_11069
		push	di
		call	sub_11184
		add	sp, 2

loc_11069:				; CODE XREF: sub_10FA2+BEj
		push	si
		push	[bp+var_6]
		push	[bp+var_8]
		call	sub_111E2
		add	sp, 6
		cmp	word_225F4, 0
		jz	short loc_11084
		push	di
		call	sub_11184
		add	sp, 2

loc_11084:				; CODE XREF: sub_10FA2+D9j
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retn
sub_10FA2	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: noreturn bp-based	frame

sub_1108A	proc near		; CODE XREF: sub_10B1A+2B2p

var_4		= byte ptr -4
var_2		= word ptr -2
arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		sub	sp, 4
		mov	ax, word_225F6
		mov	[bp+var_2], ax
		cmp	[bp+arg_0], 67h	; 'g'
		jz	short loc_110A2
		cmp	[bp+arg_0], 47h	; 'G'
		jnz	short loc_110A6

loc_110A2:				; CODE XREF: sub_1108A+10j
		mov	al, 1
		jmp	short loc_110A8
; ---------------------------------------------------------------------------

loc_110A6:				; CODE XREF: sub_1108A+16j
		sub	al, al

loc_110A8:				; CODE XREF: sub_1108A+1Aj
		mov	[bp+var_4], al
		cmp	word_225FA, 0
		jnz	short loc_110B8
		mov	word_22602, 6

loc_110B8:				; CODE XREF: sub_1108A+26j
		cmp	[bp+var_4], 0
		jz	short loc_110CB
		cmp	word_22602, 0
		jnz	short loc_110CB
		mov	word_22602, 1

loc_110CB:				; CODE XREF: sub_1108A+32j
					; sub_1108A+39j
		push	word_225EE
		push	word_22602
		push	[bp+arg_0]
		push	word_22606
		push	[bp+var_2]
		call	off_2217E
sub_1108A	endp ; sp-analysis failed

		add	sp, 0Ah
		cmp	byte ptr [bp-4], 0
		jz	short loc_110FC
		cmp	word_225E8, 0
		jnz	short loc_110FC
		push	word_22606
		call	off_22180
		add	sp, 2

loc_110FC:				; CODE XREF: seg000:10E8j seg000:10EFj
		cmp	word_225E8, 0
		jz	short loc_11115
		cmp	word_22602, 0
		jnz	short loc_11115
		push	word_22606
		call	off_22184
		add	sp, 2

loc_11115:				; CODE XREF: seg000:1101j seg000:1108j
		add	word_225F6, 8
		mov	word_2260A, 0
		mov	ax, word_225F2
		or	ax, word_225F8
		jz	short loc_1113C
		push	word ptr [bp-2]
		call	off_22186
		add	sp, 2
		or	ax, ax
		jz	short loc_1113C
		mov	ax, 1
		jmp	short loc_1113E
; ---------------------------------------------------------------------------

loc_1113C:				; CODE XREF: seg000:1127j seg000:1135j
		sub	ax, ax

loc_1113E:				; CODE XREF: seg000:113Aj
		push	ax
		call	sub_1124A
		mov	sp, bp
		pop	bp
		retn

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_11146	proc near		; CODE XREF: sub_10B1A+258p
					; sub_10B1A+2BCp ...

arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		push	si
		cmp	word_22600, 0
		jnz	short loc_11180
		mov	bx, word_225EA
		dec	word ptr [bx+2]
		js	short loc_11168
		mov	al, byte ptr [bp+arg_0]
		mov	si, [bx]
		inc	word ptr [bx]
		mov	[si], al
		sub	ah, ah
		jmp	short loc_11172
; ---------------------------------------------------------------------------
		align 2

loc_11168:				; CODE XREF: sub_11146+12j
		push	bx		; FILE *
		push	[bp+arg_0]	; int
		call	__flsbuf
		add	sp, 4

loc_11172:				; CODE XREF: sub_11146+1Fj
		inc	ax
		jnz	short loc_1117C
		inc	word_22600
		jmp	short loc_11180
; ---------------------------------------------------------------------------
		align 2

loc_1117C:				; CODE XREF: sub_11146+2Dj
		inc	word_225FE

loc_11180:				; CODE XREF: sub_11146+9j
					; sub_11146+33j
		pop	si
		pop	bp
		retn
sub_11146	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_11184	proc near		; CODE XREF: sub_10FA2+C1p
					; sub_10FA2+DCp ...

arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	di
		push	si
		cmp	word_22600, 0
		jnz	short loc_111DC
		mov	si, [bp+arg_0]
		or	si, si
		jle	short loc_111DC
		jmp	short loc_111B1
; ---------------------------------------------------------------------------

loc_1119C:				; CODE XREF: sub_11184+3Bj
		push	word_225EA	; FILE *
		push	word_2260C	; int
		call	__flsbuf
		add	sp, 4

loc_111AA:				; CODE XREF: sub_11184+48j
		inc	ax
		jnz	short loc_111B1
		inc	word_22600

loc_111B1:				; CODE XREF: sub_11184+16j
					; sub_11184+27j
		mov	ax, si
		dec	si
		or	ax, ax
		jle	short loc_111CE
		mov	bx, word_225EA
		dec	word ptr [bx+2]
		js	short loc_1119C
		mov	al, byte ptr word_2260C
		mov	di, [bx]
		inc	word ptr [bx]
		mov	[di], al
		sub	ah, ah
		jmp	short loc_111AA
; ---------------------------------------------------------------------------

loc_111CE:				; CODE XREF: sub_11184+32j
		cmp	word_22600, 0
		jnz	short loc_111DC
		mov	ax, [bp+arg_0]
		add	word_225FE, ax

loc_111DC:				; CODE XREF: sub_11184+Dj
					; sub_11184+14j ...
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retn
sub_11184	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_111E2	proc near		; CODE XREF: sub_10B1A+324p
					; sub_10FA2+CEp ...

arg_0		= dword	ptr  4
arg_4		= word ptr  8

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	di
		push	si
		mov	si, [bp+arg_4]
		cmp	word_22600, 0
		jnz	short loc_11244
		jmp	short loc_11212
; ---------------------------------------------------------------------------

loc_111F6:				; CODE XREF: sub_111E2+3Ej
		push	word_225EA	; FILE *
		les	bx, [bp+arg_0]
		mov	al, es:[bx]
		cbw
		push	ax		; int
		call	__flsbuf
		add	sp, 4

loc_11208:				; CODE XREF: sub_111E2+52j
		inc	ax
		jnz	short loc_1120F
		inc	word_22600

loc_1120F:				; CODE XREF: sub_111E2+27j
		inc	word ptr [bp+arg_0]

loc_11212:				; CODE XREF: sub_111E2+12j
		mov	ax, si
		dec	si
		or	ax, ax
		jz	short loc_11236
		mov	bx, word_225EA
		dec	word ptr [bx+2]
		js	short loc_111F6
		les	bx, [bp+arg_0]
		mov	al, es:[bx]
		mov	bx, word_225EA
		mov	di, [bx]
		inc	word ptr [bx]
		mov	[di], al
		sub	ah, ah
		jmp	short loc_11208
; ---------------------------------------------------------------------------

loc_11236:				; CODE XREF: sub_111E2+35j
		cmp	word_22600, 0
		jnz	short loc_11244
		mov	ax, [bp+arg_4]
		add	word_225FE, ax

loc_11244:				; CODE XREF: sub_111E2+10j
					; sub_111E2+59j
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retn
sub_111E2	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1124A	proc near		; CODE XREF: sub_10E6C+129p
					; seg000:113Fp

var_8		= word ptr -8
var_6		= word ptr -6
var_4		= word ptr -4
arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		sub	sp, 0Ah
		push	di
		push	si
		mov	si, word_22606
		sub	ax, ax
		mov	[bp+var_4], ax
		mov	[bp+var_6], ax
		cmp	word_2260C, 30h	; '0'
		jnz	short loc_1127D
		cmp	word_225FA, ax
		jz	short loc_1127D
		cmp	word_225EC, ax
		jz	short loc_11277
		cmp	word_22604, ax
		jnz	short loc_1127D

loc_11277:				; CODE XREF: sub_1124A+25j
		mov	word_2260C, 20h	; ' '

loc_1127D:				; CODE XREF: sub_1124A+19j
					; sub_1124A+1Fj ...
		mov	di, word_22608
		push	si		; char *
		call	_strlen
		add	sp, 2
		mov	[bp+var_8], ax
		sub	di, ax
		sub	di, [bp+arg_0]
		cmp	word_225F4, 0
		jnz	short loc_112AF
		cmp	byte ptr [si], 2Dh ; '-'
		jnz	short loc_112AF
		cmp	word_2260C, 30h	; '0'
		jnz	short loc_112AF
		lodsb
		cbw
		push	ax
		call	sub_11146
		add	sp, 2
		dec	[bp+var_8]

loc_112AF:				; CODE XREF: sub_1124A+4Bj
					; sub_1124A+50j ...
		cmp	word_2260C, 30h	; '0'
		jz	short loc_112C1
		or	di, di
		jle	short loc_112C1
		cmp	word_225F4, 0
		jz	short loc_112DA

loc_112C1:				; CODE XREF: sub_1124A+6Aj
					; sub_1124A+6Ej
		cmp	[bp+arg_0], 0
		jz	short loc_112CD
		inc	[bp+var_6]
		call	sub_1132C

loc_112CD:				; CODE XREF: sub_1124A+7Bj
		cmp	word_2260A, 0
		jz	short loc_112DA
		inc	[bp+var_4]
		call	sub_11344

loc_112DA:				; CODE XREF: sub_1124A+75j
					; sub_1124A+88j
		cmp	word_225F4, 0
		jnz	short loc_11307
		push	di
		call	sub_11184
		add	sp, 2
		cmp	[bp+arg_0], 0
		jz	short loc_112F7
		cmp	[bp+var_6], 0
		jnz	short loc_112F7
		call	sub_1132C

loc_112F7:				; CODE XREF: sub_1124A+A2j
					; sub_1124A+A8j
		cmp	word_2260A, 0
		jz	short loc_11307
		cmp	[bp+var_4], 0
		jnz	short loc_11307
		call	sub_11344

loc_11307:				; CODE XREF: sub_1124A+95j
					; sub_1124A+B2j ...
		push	[bp+var_8]
		push	ds
		push	si
		call	sub_111E2
		add	sp, 6
		cmp	word_225F4, 0
		jz	short loc_11326
		mov	word_2260C, 20h	; ' '
		push	di
		call	sub_11184
		add	sp, 2

loc_11326:				; CODE XREF: sub_1124A+CDj
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retn
sub_1124A	endp


; =============== S U B	R O U T	I N E =======================================


sub_1132C	proc near		; CODE XREF: sub_1124A+80p
					; sub_1124A+AAp
		cmp	word_225F2, 0
		jz	short loc_11338
		mov	ax, 2Bh	; '+'
		jmp	short loc_1133B
; ---------------------------------------------------------------------------

loc_11338:				; CODE XREF: sub_1132C+5j
		mov	ax, 20h	; ' '

loc_1133B:				; CODE XREF: sub_1132C+Aj
		push	ax
		call	sub_11146
		add	sp, 2
		retn
sub_1132C	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_11344	proc near		; CODE XREF: sub_1124A+8Dp
					; sub_1124A+BAp
		mov	ax, 30h	; '0'
		push	ax
		call	sub_11146
		add	sp, 2
		cmp	word_2260A, 10h
		jnz	short locret_1136C
		cmp	word_225EE, 0
		jz	short loc_11362
		mov	ax, 58h	; 'X'
		jmp	short loc_11365
; ---------------------------------------------------------------------------
		align 2

loc_11362:				; CODE XREF: sub_11344+16j
		mov	ax, 78h	; 'x'

loc_11365:				; CODE XREF: sub_11344+1Bj
		push	ax
		call	sub_11146
		add	sp, 2

locret_1136C:				; CODE XREF: sub_11344+Fj
		retn
sub_11344	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1136E	proc near		; CODE XREF: sub_10B1A+B7p
					; sub_10B1A+E1p

var_2		= word ptr -2
arg_0		= word ptr  4
arg_2		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 4
		push	di
		push	si
		mov	si, [bp+arg_2]
		mov	[bp+var_2], 1
		cmp	byte ptr [si], 2Ah ; '*'
		jnz	short loc_11392
		mov	bx, word_225F6
		mov	di, [bx]
		add	word_225F6, 2
		inc	si
		jmp	short loc_113D9
; ---------------------------------------------------------------------------
		align 2

loc_11392:				; CODE XREF: sub_1136E+13j
		cmp	byte ptr [si], 2Dh ; '-'
		jnz	short loc_1139D
		mov	[bp+var_2], 0FFFFh
		inc	si

loc_1139D:				; CODE XREF: sub_1136E+27j
		sub	di, di
		cmp	byte ptr [si], 30h ; '0'
		jl	short loc_113D9
		cmp	byte ptr [si], 39h ; '9'
		jg	short loc_113D9
		cmp	word_225FA, di
		jnz	short loc_113BA
		cmp	byte ptr [si], 30h ; '0'
		jnz	short loc_113BA
		mov	word_2260C, 30h	; '0'

loc_113BA:				; CODE XREF: sub_1136E+3Fj
					; sub_1136E+44j ...
		mov	al, [si]
		cbw
		mov	cx, di
		shl	cx, 1
		shl	cx, 1
		add	cx, di
		shl	cx, 1
		add	cx, ax
		sub	cx, 30h	; '0'
		mov	di, cx
		inc	si
		cmp	byte ptr [si], 30h ; '0'
		jl	short loc_113D9
		cmp	byte ptr [si], 39h ; '9'
		jle	short loc_113BA

loc_113D9:				; CODE XREF: sub_1136E+21j
					; sub_1136E+34j ...
		mov	ax, [bp+var_2]
		imul	di
		mov	di, ax
		mov	bx, [bp+arg_0]
		mov	[bx], di
		mov	ax, si
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retn
sub_1136E	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_113EE	proc near		; CODE XREF: sub_10B1A+A8p

arg_0		= byte ptr  4

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	si
		mov	si, 342h
		mov	cl, [bp+arg_0]
		jmp	short loc_113FF
; ---------------------------------------------------------------------------
		align 2

loc_113FE:				; CODE XREF: sub_113EE+18j
		inc	si

loc_113FF:				; CODE XREF: sub_113EE+Dj
		cmp	byte ptr [si], 0
		jz	short loc_1140E
		cmp	cl, [si]
		jnz	short loc_113FE
		mov	ax, 1
		jmp	short loc_11410
; ---------------------------------------------------------------------------
		align 2

loc_1140E:				; CODE XREF: sub_113EE+14j
		sub	ax, ax

loc_11410:				; CODE XREF: sub_113EE+1Dj
		pop	si
		mov	sp, bp
		pop	bp
		retn
sub_113EE	endp

; ---------------------------------------------------------------------------
		align 2
; [00000028 BYTES: COLLAPSED FUNCTION _fputc. PRESS KEYPAD "+" TO EXPAND]
; [0000007A BYTES: COLLAPSED FUNCTION _lseek. PRESS KEYPAD "+" TO EXPAND]
; [000000A6 BYTES: COLLAPSED FUNCTION _write. PRESS KEYPAD "+" TO EXPAND]
; [0000004E BYTES: COLLAPSED FUNCTION sub_1155E. PRESS KEYPAD "+" TO EXPAND]
; ---------------------------------------------------------------------------
; [00000034 BYTES: COLLAPSED CHUNK OF FUNCTION _write. PRESS KEYPAD "+"	TO EXPAND]
; [00000012 BYTES: COLLAPSED FUNCTION _stackavail. PRESS KEYPAD	"+" TO EXPAND]
; [00000012 BYTES: COLLAPSED FUNCTION unknown_libname_1. PRESS KEYPAD "+" TO EXPAND]
; [00000046 BYTES: COLLAPSED FUNCTION unknown_libname_2. PRESS KEYPAD "+" TO EXPAND]
; ---------------------------------------------------------------------------
; [00000003 BYTES: COLLAPSED CHUNK OF FUNCTION __amalloc. PRESS	KEYPAD "+" TO EXPAND]
; [000000E3 BYTES: COLLAPSED FUNCTION __amalloc. PRESS KEYPAD "+" TO EXPAND]
; [0000003A BYTES: COLLAPSED FUNCTION __amexpand. PRESS	KEYPAD "+" TO EXPAND]
; [00000022 BYTES: COLLAPSED FUNCTION __amlink.	PRESS KEYPAD "+" TO EXPAND]
; [0000001F BYTES: COLLAPSED FUNCTION __amallocbrk. PRESS KEYPAD "+" TO	EXPAND]
		align 2
; [0000006E BYTES: COLLAPSED FUNCTION _brkctl. PRESS KEYPAD "+"	TO EXPAND]
; [00000056 BYTES: COLLAPSED FUNCTION sub_1181A. PRESS KEYPAD "+" TO EXPAND]
; [0000001B BYTES: COLLAPSED FUNCTION _strlen. PRESS KEYPAD "+"	TO EXPAND]
		align 2
; [0000000A BYTES: COLLAPSED FUNCTION _ultoa. PRESS KEYPAD "+" TO EXPAND]
; [00000023 BYTES: COLLAPSED FUNCTION _isatty. PRESS KEYPAD "+"	TO EXPAND]
		align 2
; [00000056 BYTES: COLLAPSED FUNCTION _sprintf.	PRESS KEYPAD "+" TO EXPAND]
; [00000012 BYTES: COLLAPSED FUNCTION _bdos. PRESS KEYPAD "+" TO EXPAND]
; ---------------------------------------------------------------------------
; [0000005F BYTES: COLLAPSED CHUNK OF FUNCTION _ultoa. PRESS KEYPAD "+"	TO EXPAND]
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

ShowInstruct	proc near		; CODE XREF: _main+8p

var_4		= word ptr -4
var_2		= word ptr -2

		push	bp
		mov	bp, sp
		sub	sp, 4
		push	di
		push	si
		sub	di, di
		mov	si, [bp+var_2]
		jmp	short loc_119A1
; ---------------------------------------------------------------------------
		align 2

loc_11992:				; CODE XREF: ShowInstruct+2Aj
		mov	ax, offset aGameTitle ;	" ìdåÇÉiÅ[ÉX "
		push	ax		; char *
		push	si
		mov	ax, offset byte_2204A
		push	ax		; FILE *
		call	_fprintf
		add	sp, 6

loc_119A1:				; CODE XREF: ShowInstruct+Dj
		mov	bx, di
		inc	di
		shl	bx, 1
		mov	si, instructStrList[bx]
		or	si, si
		jnz	short loc_11992
		mov	[bp+var_4], di
		mov	[bp+var_2], si
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retn
ShowInstruct	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: noreturn bp-based	frame

ShowSyntax	proc near		; CODE XREF: _main+11p

var_4		= word ptr -4
var_2		= word ptr -2

		push	bp
		mov	bp, sp
		sub	sp, 4
		push	di
		push	si
		sub	di, di
		mov	si, [bp+var_4]
		jmp	short loc_119D5
; ---------------------------------------------------------------------------
		align 2

loc_119CA:				; CODE XREF: ShowSyntax+26j
		mov	ax, offset byte_2204A
		push	ax
		push	si		; char *
		call	_fputs
		add	sp, 4

loc_119D5:				; CODE XREF: ShowSyntax+Dj
		mov	bx, di
		inc	di
		shl	bx, 1
		mov	si, syntaxStrList[bx]
		or	si, si
		jnz	short loc_119CA
		mov	[bp+var_2], di
		mov	[bp+var_4], si
		mov	ax, 2
		push	ax		; int
		call	_exit
ShowSyntax	endp

; ---------------------------------------------------------------------------
		add	sp, 2
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retn

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_119F8	proc near		; CODE XREF: CopyFile+26p

var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  4
arg_2		= word ptr  6
arg_4		= word ptr  8

		push	bp
		mov	bp, sp
		sub	sp, 4
		push	di
		push	si
		push	ds
		mov	ax, 0FFFFh
		mov	[bp+var_2], ax
		mov	[bp+var_4], ax
		mov	di, seg	seg001
		push	[bp+arg_4]
		push	[bp+arg_0]
		push	di
		mov	ax, 0
		push	ax
		call	sub_11AEE
		add	sp, 8
		push	[bp+arg_4]
		push	[bp+arg_2]
		push	di
		mov	ax, offset byte_125D4
		push	ax
		call	sub_11AEE
		add	sp, 8
		mov	ds, di
		assume ds:seg001
		mov	dx, 0
		mov	ax, 3D00h
		int	21h		; DOS -	2+ - OPEN DISK FILE WITH HANDLE
					; DS:DX	-> ASCIZ filename
					; AL = access mode
					; 0 - read
		jnb	short loc_11A41
		mov	si, 1
		jmp	short loc_11A96
; ---------------------------------------------------------------------------
		nop

loc_11A41:				; CODE XREF: sub_119F8+41j
		mov	[bp+var_2], ax
		mov	bx, ax
		mov	ax, 5700h
		int	21h		; DOS -	2+ - GET FILE'S DATE/TIME
					; BX = file handle
		mov	word_125D0, dx
		mov	word_125D2, cx
		mov	dx, offset byte_125D4
		mov	ah, 3Ch
		mov	cx, 20h
		int	21h		; DOS -	2+ - CREATE A FILE WITH	HANDLE (CREAT)
					; CX = attributes for file
					; DS:DX	-> ASCIZ filename (may include drive and path)
		jnb	short loc_11A64
		mov	si, 3
		jmp	short loc_11A96
; ---------------------------------------------------------------------------

loc_11A64:				; CODE XREF: sub_119F8+65j
		mov	[bp+var_4], ax
		jmp	short loc_11A7E
; ---------------------------------------------------------------------------

loc_11A69:				; CODE XREF: sub_119F8+9Aj
		mov	cx, ax
		mov	dx, offset byte_12614
		mov	bx, [bp+var_4]
		mov	ah, 40h
		int	21h		; DOS -	2+ - WRITE TO FILE WITH	HANDLE
					; BX = file handle, CX = number	of bytes to write, DS:DX -> buffer
		mov	si, 4
		jb	short loc_11A96
		cmp	ax, cx
		jnz	short loc_11A96

loc_11A7E:				; CODE XREF: sub_119F8+6Fj
		mov	cx, 0F800h
		mov	dx, offset byte_12614
		mov	bx, [bp+var_2]
		mov	ah, 3Fh
		int	21h		; DOS -	2+ - READ FROM FILE WITH HANDLE
					; BX = file handle, CX = number	of bytes to read
					; DS:DX	-> buffer
		mov	si, 2
		jb	short loc_11A96
		test	ax, ax
		jnz	short loc_11A69
		sub	si, si

loc_11A96:				; CODE XREF: sub_119F8+46j
					; sub_119F8+6Aj ...
		mov	ax, [bp+var_2]
		mov	bx, ax
		inc	ax
		jz	short loc_11AA2
		mov	ah, 3Eh
		int	21h		; DOS -	2+ - CLOSE A FILE WITH HANDLE
					; BX = file handle

loc_11AA2:				; CODE XREF: sub_119F8+A4j
		mov	ax, [bp+var_4]
		mov	bx, ax
		inc	ax
		jz	short loc_11AAE
		mov	ah, 3Eh
		int	21h		; DOS -	2+ - CLOSE A FILE WITH HANDLE
					; BX = file handle

loc_11AAE:				; CODE XREF: sub_119F8+B0j
		test	si, si
		jz	short loc_11AC2

loc_11AB2:				; CODE XREF: sub_119F8+D7j
		mov	dx, offset byte_125D4
		mov	ah, 41h
		int	21h		; DOS -	2+ - DELETE A FILE (UNLINK)
					; DS:DX	-> ASCIZ pathname of file to delete (no	wildcards allowed)
		mov	ax, si
		pop	ds
		assume ds:dseg
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retn
; ---------------------------------------------------------------------------
		assume ds:seg001

loc_11AC2:				; CODE XREF: sub_119F8+B8j
		mov	dx, offset byte_125D4
		mov	ax, 3D00h
		int	21h		; DOS -	2+ - OPEN DISK FILE WITH HANDLE
					; DS:DX	-> ASCIZ filename
					; AL = access mode
					; 0 - read
		jnb	short loc_11AD1
		mov	si, 5
		jmp	short loc_11AB2
; ---------------------------------------------------------------------------

loc_11AD1:				; CODE XREF: sub_119F8+D2j
		mov	bx, ax
		mov	dx, word_125D0
		mov	cx, word_125D2
		mov	ax, 5701h
		int	21h		; DOS -	2+ - SET FILE'S DATE/TIME
					; BX = file handle, CX = time to be set
					; DX = date to be set
		mov	ah, 3Eh
		int	21h		; DOS -	2+ - CLOSE A FILE WITH HANDLE
					; BX = file handle
		sub	ax, ax
		pop	ds
		assume ds:dseg
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retn
sub_119F8	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_11AEE	proc near		; CODE XREF: sub_119F8+20p
					; sub_119F8+31p

arg_0		= dword	ptr  4
arg_4		= word ptr  8
arg_6		= word ptr  0Ah

		push	bp
		mov	bp, sp
		push	di
		push	si
		cld
		les	di, [bp+arg_0]
		assume es:nothing
		mov	si, [bp+arg_4]

loc_11AFA:				; CODE XREF: sub_11AEE+10j
		lodsb
		stosb
		test	al, al
		jnz	short loc_11AFA
		dec	di
		mov	si, [bp+arg_6]

loc_11B04:				; CODE XREF: sub_11AEE+1Aj
		lodsb
		stosb
		test	al, al
		jnz	short loc_11B04
		pop	si
		pop	di
		pop	bp
		retn
sub_11AEE	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_11B0E	proc near		; CODE XREF: CopyFile+D9p

arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		push	di
		push	si
		mov	di, 81Ah
		mov	si, 7EEh
		mov	ax, 0FFh
		push	ax
		push	[bp+arg_0]
		push	si
		call	sub_12552
		jmp	short loc_11B48
; ---------------------------------------------------------------------------

loc_11B26:				; CODE XREF: sub_11B0E+3Fj
		mov	al, [si+15h]
		and	al, 0DDh
		jnz	short loc_11B3D
		lea	bx, [si+1Eh]
		xchg	si, bx
		push	ds
		pop	es
		assume es:dseg
		cld

loc_11B35:				; CODE XREF: sub_11B0E+2Bj
		lodsb
		stosb
		test	al, al
		jnz	short loc_11B35
		mov	si, bx

loc_11B3D:				; CODE XREF: sub_11B0E+1Dj
		mov	ax, 0FFh
		push	ax
		push	[bp+arg_0]
		push	si
		call	sub_12556

loc_11B48:				; CODE XREF: sub_11B0E+16j
		add	sp, 6
		test	ax, ax
		jz	short loc_11B26
		sub	ax, ax
		mov	[di], ax
		pop	si
		pop	di
		pop	bp
		retn
sub_11B0E	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_11B58	proc near		; CODE XREF: CopyFile+3Ep

arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		push	si
		mov	si, [bp+arg_0]
		cld

loc_11B60:				; CODE XREF: sub_11B58+Bj
		lodsb
		test	al, al
		jnz	short loc_11B60
		mov	ax, si
		pop	si
		pop	bp
		retn
sub_11B58	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_11B6A	proc near		; CODE XREF: sub_11BB0+6Cp

arg_0		= byte ptr  4
arg_2		= word ptr  6

		push	bp
		mov	bp, sp
		push	di
		push	si
		push	ds
		mov	al, [bp+arg_0]
		mov	byte_223D4, al
		mov	si, 181Ah
		mov	di, [bp+arg_2]
		mov	ah, 2Fh
		int	21h		; DOS -	GET DISK TRANSFER AREA ADDRESS
					; Return: ES:BX	-> DTA
		push	es
		push	bx
		lea	dx, [si+1Eh]
		xchg	dx, si
		mov	ah, 1Ah
		int	21h		; DOS -	SET DISK TRANSFER AREA ADDRESS
					; DS:DX	-> disk	transfer buffer
		mov	dx, 5B4h
		mov	cx, 8
		mov	ah, 4Eh
		int	21h		; DOS -	2+ - FIND FIRST	ASCIZ (FINDFIRST)
					; CX = search attributes
					; DS:DX	-> ASCIZ filespec
					; (drive, path,	and wildcards allowed)
		mov	bx, 0FFFFh
		jb	short loc_11BA3
		mov	cx, 0Ch
		push	ds
		pop	es
		cld
		rep movsb
		inc	bx

loc_11BA3:				; CODE XREF: sub_11B6A+2Ej
		pop	dx
		pop	ds
		push	bx
		mov	ah, 1Ah
		int	21h		; DOS -	SET DISK TRANSFER AREA ADDRESS
					; DS:DX	-> disk	transfer buffer
		pop	ax
		pop	ds
		pop	si
		pop	di
		pop	bp
		retn
sub_11B6A	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

; int __cdecl sub_11BB0(char, char, char *)
sub_11BB0	proc near		; CODE XREF: _main+CCp

var_12		= word ptr -12h
var_E		= byte ptr -0Eh
var_3		= byte ptr -3
arg_0		= byte ptr  4
arg_2		= byte ptr  6
arg_4		= dword	ptr  8

		push	bp
		mov	bp, sp
		sub	sp, 12h
		push	di
		push	si
		dec	word_22044
		js	short loc_11BCC
		mov	al, 0Ah
		mov	bx, word_22042
		inc	word_22042
		mov	[bx], al
		jmp	short loc_11BDA
; ---------------------------------------------------------------------------

loc_11BCC:				; CODE XREF: sub_11BB0+Cj
		mov	ax, offset word_22042
		push	ax		; FILE *
		mov	ax, 0Ah
		push	ax		; int
		call	__flsbuf
		add	sp, 4

loc_11BDA:				; CODE XREF: sub_11BB0+1Aj
		mov	al, [bp+arg_0]
		sub	ah, ah
		mov	si, ax
		mov	al, [bp+arg_2]
		mov	[bp+var_12], ax
		mov	di, word ptr [bp+arg_4]

loc_11BEA:				; CODE XREF: sub_11BB0+74j
					; sub_11BB0+87j ...
		push	[bp+var_12]
		push	si
		mov	ax, offset aInsertDisk ; ">>> ÉhÉâÉCÉu %c: Ç… ÉfÉBÉXÉN #%c ÇÉZÉb"...
		push	ax		; char *
		call	_printf
		add	sp, 6
		mov	ax, 8
		push	ax		; unsigned int
		sub	ax, ax
		push	ax		; unsigned int
		mov	ax, 0Ch
		push	ax		; int
		call	_bdos
		add	sp, 6
		sub	ax, ax
		push	ax		; unsigned int
		push	ax		; unsigned int
		mov	ax, 0Dh
		push	ax		; int
		call	_bdos
		add	sp, 6
		lea	ax, [bp+var_E]
		push	ax
		push	si
		call	sub_11B6A
		add	sp, 4
		or	ax, ax
		jnz	short loc_11BEA
		mov	ax, 0Bh
		push	ax		; char *
		lea	ax, [bp+var_E]
		push	ax
		push	di		; char *
		call	_strncmp
		add	sp, 6
		or	ax, ax
		jnz	short loc_11BEA
		mov	al, [bp+arg_2]
		cmp	[bp+var_3], al
		jnz	short loc_11BEA
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retn
sub_11BB0	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

; int __cdecl CopyFile(char *, int)
CopyFile	proc near		; CODE XREF: _main+DEp

var_8		= word ptr -8
var_6		= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= dword	ptr  4
arg_4		= word ptr  8

		push	bp
		mov	bp, sp
		sub	sp, 8
		push	di
		push	si
		mov	[bp+var_6], 0
		mov	si, [bp+var_2]
		jmp	short loc_11C96
; ---------------------------------------------------------------------------

loc_11C5A:				; CODE XREF: CopyFile+49j
		push	si
		mov	ax, offset aCopying20s ; " Copying: %-20s\r"
		push	ax		; char *
		call	_printf
		add	sp, 4
		push	si
		mov	ax, offset byte_236BA
		push	ax
		mov	ax, offset byte_236DA
		push	ax
		call	sub_119F8
		add	sp, 6
		mov	di, ax
		or	di, di
		jz	short loc_11C85
		push	si
		mov	ax, offset aCouldNotCopy ; "ÉtÉ@ÉCÉãÇ™ÉRÉsÅ[Ç≈Ç´Ç‹ÇπÇÒ"
		push	ax		; char *
		call	error_exit
; ---------------------------------------------------------------------------
		add	sp, 4

loc_11C85:				; CODE XREF: CopyFile+30j
		push	si
		call	sub_11B58
		add	sp, 2
		mov	si, ax

loc_11C8E:				; CODE XREF: CopyFile+169j
		cmp	byte ptr [si], 0
		jnz	short loc_11C5A
		mov	[bp+var_4], di

loc_11C96:				; CODE XREF: CopyFile+10j
		mov	bx, [bp+var_6]
		inc	[bp+var_6]
		shl	bx, 1
		mov	di, [bp+arg_4]
		mov	ax, [bx+di]
		mov	[bp+var_8], ax
		or	ax, ax
		jnz	short loc_11CAD
		jmp	loc_11DB4
; ---------------------------------------------------------------------------

loc_11CAD:				; CODE XREF: CopyFile+60j
		push	ax
		push	word ptr [bp+arg_0] ; char *
		mov	ax, offset aSS_0 ; "%s%s"
		push	ax
		mov	ax, offset byte_236DA
		push	ax		; char *
		call	_sprintf
		add	sp, 8
		mov	bx, [bp+var_8]
		cmp	byte ptr [bx], 0
		jz	short loc_11CF2
		push	si
		mov	di, offset asc_2241B ; "\\"
		mov	si, offset byte_236DA
		mov	ax, ds
		mov	es, ax
		mov	cx, 0FFFFh
		xor	ax, ax
		repne scasb
		not	cx
		sub	di, cx
		mov	bx, cx
		xchg	di, si
		mov	cx, 0FFFFh
		repne scasb
		dec	di
		mov	cx, bx
		shr	cx, 1
		repne movsw
		adc	cx, cx
		repne movsb
		pop	si

loc_11CF2:				; CODE XREF: CopyFile+7Dj
		push	si
		mov	di, offset a__0	; "*.*"
		mov	si, offset byte_236DA
		mov	ax, ds
		mov	es, ax
		mov	cx, 0FFFFh
		xor	ax, ax
		repne scasb
		not	cx
		sub	di, cx
		mov	bx, cx
		xchg	di, si
		mov	cx, 0FFFFh
		repne scasb
		dec	di
		mov	cx, bx
		shr	cx, 1
		repne movsw
		adc	cx, cx
		repne movsb
		pop	si
		mov	ax, offset byte_236DA
		push	ax
		call	sub_11B0E
		add	sp, 2
		mov	si, offset byte_2263A
		push	[bp+var_8]
		push	word ptr [bp+arg_0] ; char *
		mov	ax, offset aSS_1 ; "%s%s"
		push	ax
		mov	ax, offset byte_236DA
		push	ax		; char *
		call	_sprintf
		add	sp, 8
		push	[bp+var_8]
		push	word ptr [bp+arg_0+2] ;	char *
		mov	ax, offset aSS_2 ; "%s%s"
		push	ax
		mov	ax, offset byte_236BA
		push	ax		; char *
		call	_sprintf
		add	sp, 8
		mov	bx, [bp+var_8]
		cmp	byte ptr [bx], 0
		jz	short loc_11DAE
		push	si
		mov	di, offset asc_2242B ; "\\"
		mov	si, offset byte_236DA
		mov	ax, ds
		mov	es, ax
		mov	cx, 0FFFFh
		xor	ax, ax
		repne scasb
		not	cx
		sub	di, cx
		mov	bx, cx
		xchg	di, si
		mov	cx, 0FFFFh
		repne scasb
		dec	di
		mov	cx, bx
		shr	cx, 1
		repne movsw
		adc	cx, cx
		repne movsb
		pop	si
		push	si
		mov	di, offset asc_2242D ; "\\"
		mov	si, offset byte_236BA
		mov	ax, ds
		mov	cx, 0FFFFh
		xor	ax, ax
		repne scasb
		not	cx
		sub	di, cx
		mov	bx, cx
		xchg	di, si
		mov	cx, 0FFFFh
		repne scasb
		dec	di
		mov	cx, bx
		shr	cx, 1
		repne movsw
		adc	cx, cx
		repne movsb
		pop	si

loc_11DAE:				; CODE XREF: CopyFile+110j
		mov	di, [bp+var_4]
		jmp	loc_11C8E
; ---------------------------------------------------------------------------

loc_11DB4:				; CODE XREF: CopyFile+62j
		mov	[bp+var_2], si
		mov	ax, offset aOk_	; "Ok."
		push	ax
		mov	ax, offset a30s	; ">>> %-30s\n"
		push	ax		; char *
		call	_printf
		add	sp, 4
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retn
CopyFile	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

; int __cdecl CreateFolder(char	*)
CreateFolder	proc near		; CODE XREF: _main+86p

var_44		= byte ptr -44h
var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= dword	ptr  4

		push	bp
		mov	bp, sp
		sub	sp, 44h
		push	di
		push	si
		mov	[bp+var_4], 0
		push	word ptr [bp+arg_0] ; char *
		call	_mkdir
		add	sp, 2
		mov	di, word ptr [bp+arg_0+2]
		mov	si, [bp+var_2]
		jmp	short loc_11E06
; ---------------------------------------------------------------------------

loc_11DEA:				; CODE XREF: CreateFolder+46j
		push	si
		push	word ptr [bp+arg_0] ; char *
		mov	ax, offset aSS	; "%s\\%s"
		push	ax
		lea	ax, [bp+var_44]
		push	ax		; char *
		call	_sprintf
		add	sp, 8
		lea	ax, [bp+var_44]
		push	ax		; char *
		call	_mkdir
		add	sp, 2

loc_11E06:				; CODE XREF: CreateFolder+1Cj
		mov	bx, [bp+var_4]
		inc	[bp+var_4]
		shl	bx, 1
		mov	si, [bx+di]
		or	si, si
		jnz	short loc_11DEA
		mov	[bp+var_2], si
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retn
CreateFolder	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

CreateStartFile	proc near		; CODE XREF: _main+F8p

var_42		= byte ptr -42h
var_2		= dword	ptr -2
arg_0		= byte ptr  4
arg_2		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 42h
		push	[bp+arg_2]
		mov	al, [bp+arg_0]
		sub	ah, ah
		push	ax		; char *
		mov	ax, offset aCS_bat ; "%c:\\%s.bat"
		push	ax
		lea	ax, [bp+var_42]
		push	ax		; char *
		call	_sprintf
		add	sp, 8
		mov	ax, offset aWt	; "wt"
		push	ax
		lea	ax, [bp+var_42]
		push	ax		; char *
		call	_fopen
		add	sp, 4
		mov	word ptr [bp+var_2], ax
		or	ax, ax
		jnz	short loc_11E5E
		lea	ax, [bp+var_42]
		push	ax
		mov	ax, offset aNoStartFile	; "ÉXÉ^Å[ÉgópÉtÉ@ÉCÉãÇ™çÏê¨Ç≈Ç´Ç‹ÇπÇÒ"
		push	ax		; char *
		call	error_exit
; ---------------------------------------------------------------------------
		add	sp, 4

loc_11E5E:				; CODE XREF: CreateStartFile+30j
		push	[bp+arg_2]
		push	[bp+arg_2]
		mov	al, [bp+arg_0]
		sub	ah, ah
		push	ax		; char *
		mov	ax, offset aCCdSSCd__ ;	"%c:\ncd \\%s\n%s\ncd ..\n"
		push	ax
		push	word ptr [bp+var_2] ; FILE *
		call	_fprintf
		add	sp, 0Ah
		push	word ptr [bp+var_2] ; FILE *
		call	_fclose
		mov	sp, bp
		pop	bp
		retn
CreateStartFile	endp

; ---------------------------------------------------------------------------
		align 2
; [000000BA BYTES: COLLAPSED FUNCTION _fclose. PRESS KEYPAD "+"	TO EXPAND]
; [00000027 BYTES: COLLAPSED FUNCTION _fopen. PRESS KEYPAD "+" TO EXPAND]
		align 2
; [0000003A BYTES: COLLAPSED FUNCTION _strncmp.	PRESS KEYPAD "+" TO EXPAND]
; [0000004F BYTES: COLLAPSED FUNCTION _fputs. PRESS KEYPAD "+" TO EXPAND]
		align 2
; [00000014 BYTES: COLLAPSED FUNCTION _mkdir. PRESS KEYPAD "+" TO EXPAND]
; [00000028 BYTES: COLLAPSED FUNCTION _rmdir. PRESS KEYPAD "+" TO EXPAND]
; [0000013C BYTES: COLLAPSED FUNCTION _fwrite. PRESS KEYPAD "+"	TO EXPAND]
; [0000002D BYTES: COLLAPSED FUNCTION __freebuf. PRESS KEYPAD "+" TO EXPAND]
		align 2
; [000000F8 BYTES: COLLAPSED FUNCTION __openfile. PRESS	KEYPAD "+" TO EXPAND]
; [0000003A BYTES: COLLAPSED FUNCTION __getstream. PRESS KEYPAD	"+" TO EXPAND]
; [00000020 BYTES: COLLAPSED FUNCTION _close. PRESS KEYPAD "+" TO EXPAND]
; [0000003F BYTES: COLLAPSED FUNCTION _strcat. PRESS KEYPAD "+"	TO EXPAND]
		align 2
; [00000032 BYTES: COLLAPSED FUNCTION _strcpy. PRESS KEYPAD "+"	TO EXPAND]
; [0000001B BYTES: COLLAPSED FUNCTION _itoa. PRESS KEYPAD "+" TO EXPAND]
		align 2
; [0000000D BYTES: COLLAPSED FUNCTION _remove. PRESS KEYPAD "+"	TO EXPAND]
		align 2
; [00000193 BYTES: COLLAPSED FUNCTION _open. PRESS KEYPAD "+" TO EXPAND]
; [00000011 BYTES: COLLAPSED FUNCTION __cXENIXtoDOSmode. PRESS KEYPAD "+" TO EXPAND]
; [0000002C BYTES: COLLAPSED FUNCTION _memcpy. PRESS KEYPAD "+"	TO EXPAND]

; =============== S U B	R O U T	I N E =======================================


sub_12552	proc near		; CODE XREF: sub_11B0E+13p
		mov	ah, 4Eh	; 'N'
		jmp	short loc_12558
sub_12552	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_12556	proc near		; CODE XREF: sub_11B0E+37p

arg_0		= word ptr  4
arg_2		= word ptr  6
arg_4		= word ptr  8

		mov	ah, 4Fh	; 'O'

loc_12558:				; CODE XREF: sub_12552+2j
		push	bp
		mov	bp, sp
		push	di
		push	si
		push	ds
		mov	dx, [bp+arg_2]
		mov	cx, [bp+arg_4]
		int	21h		; DOS -	2+ - FIND NEXT ASCIZ (FINDNEXT)
					; [DTA]	= data block from
					; last AH = 4Eh/4Fh call
		jb	short loc_1257D
		mov	ah, 2Fh
		int	21h		; DOS -	GET DISK TRANSFER AREA ADDRESS
					; Return: ES:BX	-> DTA
		push	es
		mov	si, bx
		push	ds
		pop	es
		mov	di, [bp+arg_0]
		pop	ds
		mov	cx, 2Bh	; '+'
		cld
		rep movsb
		sub	ax, ax

loc_1257D:				; CODE XREF: sub_12556+10j
		pop	ds
		pop	si
		pop	di
		pop	bp
		retn
sub_12556	endp

; ---------------------------------------------------------------------------
		align 10h
seg000		ends

; ===========================================================================

; Segment type:	Regular
seg001		segment	byte public 'UNK' use16
		assume cs:seg001
		assume es:nothing, ss:nothing, ds:dseg,	fs:nothing, gs:nothing
		db 40h dup(0)
word_125D0	dw 0			; DATA XREF: sub_119F8+53w
					; sub_119F8+DBr
word_125D2	dw 0			; DATA XREF: sub_119F8+57w
					; sub_119F8+DFr
byte_125D4	db 40h dup(0)		; DATA XREF: sub_119F8+2Do
					; sub_119F8+5Bo ...
byte_12614	db 0F80Ch dup(0)	; DATA XREF: sub_119F8+73o
					; sub_119F8+89o
seg001		ends

; ===========================================================================

; Segment type:	Pure data
dseg		segment	para public 'DATA' use16
		assume cs:dseg
byte_21E20	db 0			; DATA XREF: dseg:instructStrListo
					; dseg:syntaxStrListo
		db    0
word_21E22	dw 0			; DATA XREF: start+50w
		align 8
		db 4Dh,	53h, 20h, 52h, 75h, 6Eh, 2Dh, 54h, 69h,	6Dh, 65h
		db 20h,	4Ch, 69h, 62h, 72h, 61h, 72h, 79h, 20h,	2Dh, 20h
		db 43h,	6Fh, 70h, 79h, 72h, 69h, 67h, 68h, 74h,	20h, 28h
		db 63h,	29h, 20h
word_21E4C	dw 3931h		; DATA XREF: __setenvp+11r
		db 38h,	38h, 2Ch, 20h, 4Dh, 69h, 63h, 72h, 6Fh,	73h, 6Fh
		db 66h,	74h, 20h, 43h, 6Fh, 72h, 70h
		dw 11h
aChang		db 'CHANG',0            ; DATA XREF: dseg:off_21F30o
aOpen		db 'OPEN',0             ; DATA XREF: dseg:off_21F30o
aAct_gpc	db 'ACT_GPC',0          ; DATA XREF: dseg:off_21F30o
aGpc		db 'GPC',0              ; DATA XREF: dseg:off_21F30o
aGpa		db 'GPA',0              ; DATA XREF: dseg:off_21F30o
aMes		db 'MES',0              ; DATA XREF: dseg:off_21F30o
aUso		db 'USO',0              ; DATA XREF: dseg:off_21F30o
aDat		db 'DAT',0              ; DATA XREF: dseg:off_21F30o
aCmd		db 'CMD',0              ; DATA XREF: dseg:off_21F30o
byte_21E8D	db 0			; DATA XREF: dseg:off_21F30o
aInstallNote	db '>>> ÉhÉâÉCÉu %c: Ç©ÇÁ %c: Ç÷ ÉCÉìÉXÉgÅ[ÉãÇµÇ‹Ç∑ÅB',0Ah,0
					; DATA XREF: _main+2Do
					; Contents of drive %c:	will be	installed to drive %c:.
aPressAnyKey	db '>>> ÇÊÇÎÇµÇØÇÍÇŒâΩÇ©ÉLÅ[ÇâüÇµÇƒÇ≠ÇæÇ≥Ç¢ÅB',0Ah,0 ; DATA XREF: _main+37o
					; Press	any key	to continue.
aC		db '%c:\',0             ; DATA XREF: _main+58o
aCS		db '%c:\%s',0           ; DATA XREF: _main+70o
asc_21EF9	db '\',0                ; DATA XREF: _main+8Do
aExitProgram	db 0Ah			; DATA XREF: _main+FEo
		db '>>> èIóπÇµÇ‹ÇµÇΩÅB',0Ah,0 ; Exiting program...
aGameTitle	db ' ìdåÇÉiÅ[ÉX ',0     ; DATA XREF: ShowInstruct:loc_11992o
					; Dengeki Nurse
		db    0
aDNurse98	db 'ìdåÇ≈∞Ω_.98',0      ; DATA XREF: _main:loc_100CCo
					; DNURSE_.98
aStartFileTitle	db 'NURSE',0            ; DATA XREF: _main+66o _main+EEo
off_21F30	dw offset aChang	; 0 ; DATA XREF: _main+7Eo _main+D2o
		dw offset aOpen		; 1 ; "CHANG"
		dw offset aAct_gpc	; 2
		dw offset aGpc		; 3
		dw offset aGpa		; 4
		dw offset aMes		; 5
		dw offset aUso		; 6
		dw offset aDat		; 7
		dw offset aCmd		; 8
		dw offset byte_21E8D	; 9
		dw 0
filesToCopy	dw 5			; DATA XREF: _main:loc_100F5r
aErrorNum	db 0Ah			; DATA XREF: error_exit+6o
		db 'ÉGÉâÅ[: %s.',0      ; Error: %s.
aS		db '(%s)',0             ; DATA XREF: error_exit+1Do
aBadDrive	db 'ÉhÉâÉCÉuÇÃéwíËÇ™à·Ç¢Ç‹Ç∑ÅB',0 ; DATA XREF: sub_10166+4Bo
					; The drive specified is incorrect.
		align 2
word_21F76	dw 0			; DATA XREF: start+4Aw	__myalloc+8r ...
word_21F78	dw 0			; DATA XREF: start+3Ew
off_21F7A	dw offset __exit	; DATA XREF: start+9Cw	start+AEr
word_21F7C	dw 0			; DATA XREF: start+39w	__myalloc+2r ...
		dw seg dseg
		db 4Ch dup(0)
off_21FCC	dw offset word_21F7C	; DATA XREF: _brkctl:loc_117CBr
					; _brkctl+61w
aC_file_info	db ';C_FILE_INFO',0
dword_21FDB	dd 0			; DATA XREF: __cinit+Cw __ctermsub+Er	...
		db 8 dup(0)
word_21FE7	dw 0			; DATA XREF: sub_106F6+26w
word_21FE9	dw 0			; DATA XREF: __cXENIXtoDOSmoder
		db    0
		db    0
word_21FED	dw 0			; DATA XREF: start+5Ew	__cinit+26r ...
word_21FEF	dw 0			; DATA XREF: __cinit+4w __setargv+7r ...
		align 2
byte_21FF2	db 0			; DATA XREF: sub_106F6w
		align 2
word_21FF4	dw 14h			; DATA XREF: _lseek+9r	_write+9r ...
		db 81h,	81h, 81h, 1, 1
		db 0Fh dup(0)
; int argc
argc		dw 0			; DATA XREF: start+89r	__setargv+BEw
; char **argv
argv		dw 0			; DATA XREF: start+85r	__setargv+D0w
word_2200E	dw 0			; DATA XREF: start+81r	__setenvp+44w
off_22010	dw offset aC_0		; DATA XREF: __setargv+29w
					; __setargv+DEr
					; "C"
seg_22012	dw seg dseg		; DATA XREF: __setargv+16w
aC_0		db 'C',0                ; DATA XREF: dseg:off_22010o
		db    0
		db    0
byte_22018	db 0			; DATA XREF: __ctermsub+18r
byte_22019	db 0			; DATA XREF: __ctermsub+20r
dword_2201A	dd 0			; DATA XREF: __ctermsub+23r
word_2201E	dw 0			; DATA XREF: __FF_MSGBANNER+Ar
					; __FF_MSGBANNER+11r
word_22020	dw 1FE0h		; DATA XREF: __chkstk+7r
					; _stackavail+1r
word_22022	dw 0			; DATA XREF: __setargvw __setargv+18Ar
		db 0, 16h, 2, 2, 18h, 0Dh, 9, 0Ch, 0Ch,	0Ch, 7,	8, 16h
		db 16h,	0FFh, 12h, 0Dh,	12h, 2,	0FFh
word_22038	dw 0			; DATA XREF: __flsbuf+90w __stbuf+Aw ...
		dw 1AE0h, 0
		dw 1AE0h, 1
word_22042	dw 0			; DATA XREF: sub_11BB0+10r
					; sub_11BB0+14w ...
word_22044	dw 0			; DATA XREF: sub_11BB0+8w
		align 4
		db 2
		db 1
byte_2204A	db 0			; DATA XREF: error_exit+Ao
					; error_exit+21o ...
		db 5 dup(0)
		db 2 dup(2)
		db 6 dup(0)
		db 84h
		db 3
		db 6 dup(0)
		db 2
		db 4
		db 78h dup(0)
		db 1
		db 2 dup(0)
		db 2
		db 74h dup(0)
word_22152	dw 2B2h			; DATA XREF: _flushall:loc_10748r
					; __getstream+Ar
aNull		db '(null)',0
aNull_0		db '(null)',0
		db '+- #',0
		align 2
word_22168	dw 0			; DATA XREF: unknown_libname_2+1Fw
word_2216A	dw 0			; DATA XREF: unknown_libname_2+22w
		db    0
		db    0
word_2216E	dw 0			; DATA XREF: unknown_libname_2+32w
		db    0
		db    0
word_22172	dw 0			; DATA XREF: __amalloc+A2r
		db    0
		db    0
word_22176	dw 0			; DATA XREF: __amalloc+4Fw
					; __amalloc+D6w
word_22178	dw 2000h		; DATA XREF: __amexpand:loc_11740r
		align 4
byte_2217C	db 0			; DATA XREF: __amalloc:loc_116A5w
					; __amalloc:loc_116E0w
		align 2
off_2217E	dw offset __fptrap	; DATA XREF: sub_1108A+53r
off_22180	dw offset __fptrap	; DATA XREF: seg000:10F5r
		db    0
		db    4
off_22184	dw offset __fptrap	; DATA XREF: seg000:110Er
off_22186	dw offset __fptrap	; DATA XREF: seg000:112Cr
		db 0, 0, 0, 0, 0, 0, 0,	20h, 20h, 20h, 20h, 20h, 20h, 20h
		db 20h,	20h, 28h, 28h, 28h, 28h, 28h, 20h, 20h,	20h, 20h
		db 20h,	20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h,	20h, 20h
		db 20h,	20h, 20h, 48h, 10h, 10h, 10h, 10h, 10h,	10h, 10h
		db 10h,	10h, 10h, 10h, 10h, 10h, 10h, 10h, 84h,	84h, 84h
		db 84h,	84h, 84h, 84h, 84h, 84h, 84h, 10h, 10h,	10h, 10h
		db 10h,	10h, 10h, 81h, 81h, 81h, 81h, 81h, 81h,	1, 1, 1
		db 1, 1, 1, 1, 1, 1, 1,	1, 1, 1, 1, 1, 1, 1, 1,	1, 1, 10h
		db 10h,	10h, 10h, 10h, 10h, 82h, 82h, 82h, 82h,	82h, 82h
		db 2, 2, 2, 2, 2, 2, 2,	2, 2, 2, 2, 2, 2, 2, 2,	2, 2, 2
		db 2, 2, 10h, 10h, 10h,	10h, 20h, 0, 0,	0, 0, 0, 0, 0
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0
aInsthAdv98V	db 'InstH: Adv98V ÉnÅ[ÉhÉfÉBÉXÉN ÉCÉìÉXÉgÅ[Éã ÉvÉçÉOÉâÉÄ  Version 1.0'
					; DATA XREF: dseg:instructStrListo
		db '1',0Ah,0            ; InstH: Adv98V Hard Disk Install Program, Version 1.01
aCopyrightTune	db 'Copyright(C) Tuneup. 1991,92.',0Dh,0 ; DATA XREF: dseg:instructStrListo
aCopyrightIdes	db 'Copyright(C) (óL)ÉAÉCÉfÉX 1991,92.',0Ah,0
					; DATA XREF: dseg:instructStrListo
asc_22317	db 0Ah,0		; DATA XREF: dseg:instructStrListo
aProgramName	db 'ÉvÉçÉOÉâÉÄñº: " %s "',0Ah,0 ; DATA XREF: dseg:instructStrListo
					; Program Name:	" %s "
asc_2232F	db 0Ah,0		; DATA XREF: dseg:instructStrListo
		db    0
instructStrList	dw offset aInsthAdv98V	; 0 ; DATA XREF: ShowInstruct+24r
		dw offset aCopyrightTune; 1 ; "InstH: Adv98V ÉnÅ[ÉhÉfÉBÉXÉN ÉCÉìÉXÉgÅ["...
		dw offset aCopyrightIdes; 2
		dw offset asc_22317	; 3
		dw offset aProgramName	; 4
		dw offset asc_2232F	; 5
		dw offset byte_21E20	; 6
aSyntax		db 'égópñ@: insth s: d:',0Ah,0 ; DATA XREF: dseg:syntaxStrListo
					; Syntax: insth	s: d:
aStxFloppyDrive	db 9,'s: = ÉtÉçÉbÉsÅ[ÉfÉBÉXÉNÇÃÉhÉâÉCÉuî‘çÜ',0Ah,0
					; DATA XREF: dseg:syntaxStrListo
					; s: = Floppy Disk Drive Letter
aStxHardDisk	db 9,'d: = ÉnÅ[ÉhÉfÉBÉXÉNÇÃÉhÉâÉCÉuî‘çÜ',0Ah,0
					; DATA XREF: dseg:syntaxStrListo
					; d: = Hard Disk Drive Letter
aExample	db '  ó·Åj',0Ah,0       ; DATA XREF: dseg:syntaxStrListo
					; Example:
aInsthBA	db 9,'insth b: a:',0Ah,0 ; DATA XREF: dseg:syntaxStrListo
aInsthDB	db 9,'insth d: b:',0Ah,0 ; DATA XREF: dseg:syntaxStrListo
		db    0
syntaxStrList	dw offset aSyntax	; 0 ; DATA XREF: ShowSyntax+20r
		dw offset aStxFloppyDrive; 1 ; "égópñ@:	insth s: d:\n"
		dw offset aStxHardDisk	; 2
		dw offset aExample	; 3
		dw offset aInsthBA	; 4
		dw offset aInsthDB	; 5
		dw offset byte_21E20	; 6
byte_223D4	db 'A'                  ; DATA XREF: sub_11B6A+9w
a_		db ':\*.*',0
		align 2
aInsertDisk	db '>>> ÉhÉâÉCÉu %c: Ç… ÉfÉBÉXÉN #%c ÇÉZÉbÉgÇµÇƒÇ≠ÇæÇ≥Ç¢ÅB',7,0Ah,0
					; DATA XREF: sub_11BB0+3Eo
					; >>> Into Drive %c:, please insert Disk #%c.
aSS_0		db '%s%s',0             ; DATA XREF: CopyFile+69o
asc_2241B	db '\',0                ; DATA XREF: CopyFile+80o
a__0		db '*.*',0              ; DATA XREF: CopyFile+ABo
aSS_1		db '%s%s',0             ; DATA XREF: CopyFile+E8o
aSS_2		db '%s%s',0             ; DATA XREF: CopyFile+FCo
asc_2242B	db '\',0                ; DATA XREF: CopyFile+113o
asc_2242D	db '\',0                ; DATA XREF: CopyFile+13Eo
aCopying20s	db ' Copying: %-20s',0Dh,0 ; DATA XREF: CopyFile+13o
aCouldNotCopy	db 'ÉtÉ@ÉCÉãÇ™ÉRÉsÅ[Ç≈Ç´Ç‹ÇπÇÒ',0 ; DATA XREF: CopyFile+33o
					; Files	could not be copied.
aOk_		db 'Ok.',0              ; DATA XREF: CopyFile+16Fo
a30s		db '>>> %-30s',0Ah,0    ; DATA XREF: CopyFile+173o
aSS		db '%s\%s',0            ; DATA XREF: CreateFolder+22o
aCS_bat		db '%c:\%s.bat',0       ; DATA XREF: CreateStartFile+Fo
aWt		db 'wt',0               ; DATA XREF: CreateStartFile+1Do
aNoStartFile	db 'ÉXÉ^Å[ÉgópÉtÉ@ÉCÉãÇ™çÏê¨Ç≈Ç´Ç‹ÇπÇÒ',0 ; DATA XREF: CreateStartFile+36o
					; Start	file could not be created.
aCCdSSCd__	db '%c:',0Ah            ; DATA XREF: CreateStartFile+4Co
		db 'cd \%s',0Ah
		db '%s',0Ah
		db 'cd ..',0Ah,0
		db '\',0
		db '\',0
		db    0
byte_224BB	db 0			; DATA XREF: _open+1Er
		db    0
		db    0
unk_224BE	db    0			; DATA XREF: __cinit+37r __cinit+4Dr ...
		db    0
word_224C0	dw 0			; DATA XREF: __cinit+20r __ctermsubr
dword_224C2	dd 0			; DATA XREF: __cinit+2Fr
dword_224C6	dd 0			; DATA XREF: __cinit:loc_102B3r
aNmsg		db '$',7,'<<NMSG>>',0   ; DATA XREF: _exit+Co _exit+Fo
		align 2
aR6000StackOver	db 'R6000',0Dh,0Ah
		db '- stack overflow',0Dh,0Ah,0
		db 3, 0
aR6003IntegerDi	db 'R6003',0Dh,0Ah
		db '- integer divide by 0',0Dh,0Ah,0
		db 9, 0
aR6009NotEnough	db 'R6009',0Dh,0Ah
		db '- not enough space for environment',0Dh,0Ah,0
		db 0FCh, 0, 0Dh, 0Ah, 0, 0FFh, 0
aRunTimeError	db 'run-time error ',0
		db 2, 0
aR6002FloatingP	db 'R6002',0Dh,0Ah
		db '- floating point not loaded',0Dh,0Ah,0
		db 1, 0
aR6001NullPoint	db 'R6001',0Dh,0Ah
		db '- null pointer assignment',0Dh,0Ah,0
		db 0FFh, 0FFh, 0FFh, 0
byte_225A6	db 0			; DATA XREF: _main+23r	_main+6Ar ...
byte_225A7	db 0			; DATA XREF: _main+29r	_main+52r ...
byte_225A8	db 0, 0, 0, 0, 0, 0, 0,	0 ; DATA XREF: _main+5Co _main+DAo
		db ?, ?, ?, ?, ?, ?, ?,	?, ?, ?, ?, ?, ?, ?, ?,	?, ?, ?
		db ?, ?, ?, ?, ?, ?
byte_225C8	db 20h dup(?)		; DATA XREF: _main+74o	_main+82o ...
word_225E8	dw ?			; DATA XREF: sub_10B1A+55w
					; sub_10B1A:loc_10BAEw	...
; FILE *word_225EA
word_225EA	dw ?			; DATA XREF: sub_10B1A+1Ew
					; sub_10B1A:loc_10CC8r	...
word_225EC	dw ?			; DATA XREF: sub_10B1A+52w
					; sub_10B1A:loc_10CF8w	...
word_225EE	dw ?			; DATA XREF: sub_10B1A+43w
					; sub_10B1A:loc_10C74w	...
word_225F0	dw ?			; DATA XREF: sub_10B1A+49w
					; sub_10B1A+111w ...
word_225F2	dw ?			; DATA XREF: sub_10B1A+40w
					; sub_10B1A+75w ...
word_225F4	dw ?			; DATA XREF: sub_10B1A+58w
					; sub_10B1A+9Fw ...
word_225F6	dw ?			; DATA XREF: sub_10B1A+18w
					; sub_10B1A:loc_10CA4r	...
word_225F8	dw ?			; DATA XREF: sub_10B1A+4Fw
					; sub_10B1A+79w ...
word_225FA	dw ?			; DATA XREF: sub_10B1A+4Cw
					; sub_10B1A+D7w ...
word_225FC	dw ?			; DATA XREF: sub_10B1A+46w
					; sub_10B1A:loc_10CDCw	...
word_225FE	dw ?			; DATA XREF: sub_10B1A+27w
					; sub_10B1A+190r ...
word_22600	dw ?			; DATA XREF: sub_10B1A+21w
					; sub_10B1A:loc_10CB4r	...
word_22602	dw ?			; DATA XREF: sub_10B1A:loc_10B52w
					; sub_10B1A+E9r ...
word_22604	dw ?			; DATA XREF: sub_10B1A+1EDw
					; sub_10B1A:loc_10D10w	...
; char *word_22606
word_22606	dw ?			; DATA XREF: sub_10B1A+12w
					; sub_10E6C+79r ...
word_22608	dw ?			; DATA XREF: sub_10B1A+BFr
					; sub_10B1A+CAr ...
word_2260A	dw ?			; DATA XREF: sub_10E6C:loc_10EE2w
					; seg000:111Aw	...
; int word_2260C
word_2260C	dw ?			; DATA XREF: sub_10B1A+5Bw
					; sub_10B1A+68w ...
		db 2Ch dup(?)
byte_2263A	db 1080h dup(?)		; DATA XREF: CopyFile+DFo
byte_236BA	db 20h dup(?)		; DATA XREF: CopyFile+1Eo
					; CopyFile+100o ...
byte_236DA	db 20h dup(?)		; DATA XREF: CopyFile+22o CopyFile+6Do ...
byte_236FA	db 606h	dup(?)		; DATA XREF: _exit+3o _exit+6o
dseg		ends

; ===========================================================================

; Segment type:	Uninitialized
seg003		segment	byte stack 'STACK' use16
		assume cs:seg003
		assume es:nothing, ss:nothing, ds:dseg,	fs:nothing, gs:nothing
		db 800h	dup(?)
seg003		ends


		end start
