; Input	MD5   :	3B1F6019C7AC4B166E0DE67680588053
; Input	CRC32 :	04293435

; File Name   :	R:\OYA.EXE
; Format      :	MS-DOS executable (EXE)
; Base Address:	1000h Range: 10000h-11C00h Loaded length: 13FDh
; Entry	Point :	1000:70
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

arg_2		= word ptr  6

		push	bp
		mov	bp, sp
		xor	ax, ax
		call	__chkstk
		sub	ax, ax
		push	ax		; char *
		mov	ax, offset aCut112x_pbd	; "cut112x.pbd"
		push	ax
		mov	ax, offset aCut112x_pbd_1 ; "cut112x.pbd"
		push	ax		; char *
		sub	ax, ax
		push	ax		; int
		call	_spawnlp
		add	sp, 8
		sub	ax, ax
		push	ax		; char *
		mov	ax, offset aMusdrvt_com	; "musdrvt.com"
		push	ax
		mov	ax, offset aMusdrvt_com_0 ; "musdrvt.com"
		push	ax		; char *
		sub	ax, ax
		push	ax		; int
		call	_spawnlp
		add	sp, 8
		call	CallIntA4
		sub	ax, ax
		push	ax
		mov	bx, [bp+arg_2]
		push	word ptr [bx+2]	; char *
		mov	ax, offset aNosmain_exe	; "nosmain.exe"
		push	ax
		mov	ax, offset aNosmain_exe_0 ; "nosmain.exe"
		push	ax		; char *
		sub	ax, ax
		push	ax		; int
		call	_spawnlp
		add	sp, 0Ah
		pop	bp
		retn
_main		endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

CallIntA4	proc near		; CODE XREF: _main+30p
		push	bp
		mov	bp, sp
		push	ds
		push	es
		push	di
		push	si
		int	0A4h		; used by BASIC	while in interpreter
		pop	si
		pop	di
		pop	es
		pop	ds
		pop	bp
		retn
CallIntA4	endp

; ---------------------------------------------------------------------------
		align 2
		assume ss:seg002, ds:nothing
; [000000B2 BYTES: COLLAPSED FUNCTION start. PRESS KEYPAD "+" TO EXPAND]
; [000000C4 BYTES: COLLAPSED FUNCTION __cinit. PRESS KEYPAD "+"	TO EXPAND]
; [00000017 BYTES: COLLAPSED FUNCTION _exit. PRESS KEYPAD "+" TO EXPAND]
; [00000045 BYTES: COLLAPSED FUNCTION __exit. PRESS KEYPAD "+" TO EXPAND]
; [0000002D BYTES: COLLAPSED FUNCTION __ctermsub. PRESS	KEYPAD "+" TO EXPAND]

; =============== S U B	R O U T	I N E =======================================

; Attributes: library function

sub_1026F	proc near		; CODE XREF: __cinit+C0p _exit+9p ...
		cmp	si, di
		jnb	short locret_1027D
		dec	di
		dec	di
		mov	cx, [di]
		jcxz	short sub_1026F
		call	cx
		jmp	short sub_1026F
; ---------------------------------------------------------------------------

locret_1027D:				; CODE XREF: sub_1026F+2j
		retn
sub_1026F	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: library function

sub_1027E	proc near		; CODE XREF: __cinit+B7p __exit+12p ...
		cmp	si, di
		jnb	short locret_10290
		sub	di, 4
		mov	ax, [di]
		or	ax, [di+2]
		jz	short sub_1027E
		call	dword ptr [di]
		jmp	short sub_1027E
; ---------------------------------------------------------------------------

locret_10290:				; CODE XREF: sub_1027E+2j
		retn
sub_1027E	endp

; ---------------------------------------------------------------------------
		align 2
; [00000020 BYTES: COLLAPSED FUNCTION __FF_MSGBANNER. PRESS KEYPAD "+" TO EXPAND]
; ---------------------------------------------------------------------------
; [00000006 BYTES: COLLAPSED CHUNK OF FUNCTION __cinit.	PRESS KEYPAD "+" TO EXPAND]
; [00000016 BYTES: COLLAPSED FUNCTION __chkstk.	PRESS KEYPAD "+" TO EXPAND]
; [00000022 BYTES: COLLAPSED FUNCTION __nullcheck. PRESS KEYPAD	"+" TO EXPAND]
; [0000018E BYTES: COLLAPSED FUNCTION __setargv. PRESS KEYPAD "+" TO EXPAND]
; [0000006E BYTES: COLLAPSED FUNCTION __setenvp. PRESS KEYPAD "+" TO EXPAND]
; [0000002B BYTES: COLLAPSED FUNCTION __NMSG_TEXT. PRESS KEYPAD	"+" TO EXPAND]
; [00000029 BYTES: COLLAPSED FUNCTION __NMSG_WRITE. PRESS KEYPAD "+" TO	EXPAND]
; [00000042 BYTES: COLLAPSED FUNCTION __myalloc. PRESS KEYPAD "+" TO EXPAND]
; ---------------------------------------------------------------------------

__dosret0:
		jb	short loc_10597

loc_10584:				; CODE XREF: seg000:__dosreturnj
		xor	ax, ax
		mov	sp, bp
		pop	bp
		retn
; ---------------------------------------------------------------------------

__dosreturn:
		jnb	short loc_10584
		push	ax
		call	sub_105A8
		pop	ax
		mov	sp, bp
		pop	bp
		retn
; ---------------------------------------------------------------------------
; [0000000D BYTES: COLLAPSED CHUNK OF FUNCTION __dospawn. PRESS	KEYPAD "+" TO EXPAND]
; ---------------------------------------------------------------------------

__maperror:
		xor	ah, ah
		call	sub_105A8
		retn

; =============== S U B	R O U T	I N E =======================================


sub_105A8	proc near		; CODE XREF: seg000:058Dp
					; __dospawn:loc_10597p	...
		mov	byte ptr unk_11166, al
		or	ah, ah
		jnz	short loc_105D2
		cmp	byte_11163, 3
		jb	short loc_105C3
		cmp	al, '"'
		jnb	short loc_105C7
		cmp	al, ' '
		jb	short loc_105C3
		mov	al, 5
		jmp	short loc_105C9
; ---------------------------------------------------------------------------
		nop

loc_105C3:				; CODE XREF: sub_105A8+Cj
					; sub_105A8+14j
		cmp	al, 13h
		jbe	short loc_105C9

loc_105C7:				; CODE XREF: sub_105A8+10j
		mov	al, 13h

loc_105C9:				; CODE XREF: sub_105A8+18j
					; sub_105A8+1Dj
		mov	bx, offset byte_11198
		xlat

loc_105CD:				; CODE XREF: sub_105A8+2Cj
		cbw
		mov	word_1115B, ax
		retn
; ---------------------------------------------------------------------------

loc_105D2:				; CODE XREF: sub_105A8+5j
		mov	al, ah
		jmp	short loc_105CD
sub_105A8	endp

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
; [00000056 BYTES: COLLAPSED FUNCTION sub_107FE. PRESS KEYPAD "+" TO EXPAND]
; [0000003F BYTES: COLLAPSED FUNCTION _strcat. PRESS KEYPAD "+"	TO EXPAND]
		align 2
; [00000032 BYTES: COLLAPSED FUNCTION _strcpy. PRESS KEYPAD "+"	TO EXPAND]
; [0000001B BYTES: COLLAPSED FUNCTION _strlen. PRESS KEYPAD "+"	TO EXPAND]
		align 2
; [00000028 BYTES: COLLAPSED FUNCTION _strncpy.	PRESS KEYPAD "+" TO EXPAND]
; [0000003A BYTES: COLLAPSED FUNCTION _strncmp.	PRESS KEYPAD "+" TO EXPAND]
; [0000005E BYTES: COLLAPSED FUNCTION _getenv. PRESS KEYPAD "+"	TO EXPAND]
; [0000002A BYTES: COLLAPSED FUNCTION _strchr. PRESS KEYPAD "+"	TO EXPAND]
; [0000002B BYTES: COLLAPSED FUNCTION _strrchr.	PRESS KEYPAD "+" TO EXPAND]
		align 2
; [00000225 BYTES: COLLAPSED FUNCTION __cenvarg. PRESS KEYPAD "+" TO EXPAND]
		align 4
word_10C20	dw 0			; DATA XREF: __dospawn+5Cw
					; __dospawn+AFr
word_10C22	dw 0			; DATA XREF: __dospawn+57w
					; __dospawn+AAr
word_10C24	dw 0			; DATA XREF: __dospawn+66w
					; __dospawn+C4r
word_10C26	dw 0			; DATA XREF: __dospawn+6Ew
					; __dospawn+BCr
word_10C28	dw 0			; DATA XREF: __dospawn+73w
					; __dospawn+B7r
; [000000E1 BYTES: COLLAPSED FUNCTION __dospawn. PRESS KEYPAD "+" TO EXPAND]
		align 2
; [00000014 BYTES: COLLAPSED FUNCTION _spawnlp.	PRESS KEYPAD "+" TO EXPAND]
; [00000143 BYTES: COLLAPSED FUNCTION _spawnve.	PRESS KEYPAD "+" TO EXPAND]
		align 2
; [0000001C BYTES: COLLAPSED FUNCTION _spawnvp.	PRESS KEYPAD "+" TO EXPAND]

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

; int __cdecl sub_10E80(int, char *, char **)
sub_10E80	proc near		; CODE XREF: _spawnvp+15p

var_D8		= byte ptr -0D8h
var_86		= word ptr -86h
var_84		= word ptr -84h
var_80		= byte ptr -80h
var_1		= byte ptr -1
arg_0		= word ptr  4
arg_2		= dword	ptr  6
arg_6		= dword	ptr  0Ah

		push	bp
		mov	bp, sp
		mov	ax, 0D8h ; 'ÿ'
		call	__chkstk
		push	di
		push	si
		lea	ax, [bp+var_D8]
		mov	di, ax
		push	word ptr [bp+arg_6] ; char **
		push	word ptr [bp+arg_2+2]
		push	word ptr [bp+arg_2] ; char *
		push	[bp+arg_0]	; int
		call	_spawnve
		add	sp, 8
		mov	[bp+var_84], ax
		inc	ax
		jnz	short loc_10EE7
		cmp	word_1115B, 2
		jnz	short loc_10EE7
		mov	bx, word ptr [bp+arg_2]
		cmp	byte ptr [bx], 2Fh ; '/'
		jz	short loc_10EE7
		mov	ax, 5Ch	; '\'
		push	ax
		push	bx
		call	sub_10FB6
		add	sp, 4
		cmp	ax, word ptr [bp+arg_2]
		jz	short loc_10EE7
		mov	bx, word ptr [bp+arg_2]
		cmp	byte ptr [bx], 0
		jz	short loc_10ED7
		cmp	byte ptr [bx+1], 3Ah ; ':'
		jz	short loc_10EE7

loc_10ED7:				; CODE XREF: sub_10E80+4Fj
		mov	ax, offset aPath ; "PATH"
		push	ax		; char *
		call	_getenv
		add	sp, 2
		mov	si, ax
		or	si, si
		jnz	short loc_10EEE

loc_10EE7:				; CODE XREF: sub_10E80+28j
					; sub_10E80+2Fj ...
		mov	ax, [bp+var_84]
		jmp	loc_10F9C
; ---------------------------------------------------------------------------

loc_10EEE:				; CODE XREF: sub_10E80+65j
		mov	ax, 7Fh
		push	ax		; char *
		push	si
		lea	ax, [bp+var_80]
		push	ax		; char *
		call	_strncpy
		add	sp, 6
		mov	si, ax
		mov	[bp+var_1], 0
		jmp	short loc_10F11
; ---------------------------------------------------------------------------
		align 2

loc_10F06:				; CODE XREF: sub_10E80+94j
		cmp	byte ptr [si], 3Bh ; ';'
		jz	short loc_10F16
		mov	al, [si]
		mov	[di], al
		inc	si
		inc	di

loc_10F11:				; CODE XREF: sub_10E80+83j
					; sub_10E80+115j
		cmp	byte ptr [si], 0
		jnz	short loc_10F06

loc_10F16:				; CODE XREF: sub_10E80+89j
		mov	byte ptr [di], 0
		dec	di
		mov	[bp+var_86], di
		lea	ax, [bp+var_D8]
		mov	di, ax
		mov	bx, [bp+var_86]
		cmp	byte ptr [bx], 5Ch ; '\'
		jnz	short loc_10F44
		mov	ax, 5Ch	; '\'
		push	ax
		push	di
		call	sub_11008
		add	sp, 4
		cmp	ax, [bp+var_86]
		jz	short loc_10F58
		mov	ax, offset asc_1120D ; "\\"
		jmp	short loc_10F50
; ---------------------------------------------------------------------------
		align 2

loc_10F44:				; CODE XREF: sub_10E80+ABj
		mov	bx, [bp+var_86]
		cmp	byte ptr [bx], 2Fh ; '/'
		jz	short loc_10F58
		mov	ax, offset asc_1120F ; "\\"

loc_10F50:				; CODE XREF: sub_10E80+C1j
		push	ax
		push	di		; char *
		call	_strcat
		add	sp, 4

loc_10F58:				; CODE XREF: sub_10E80+BCj
					; sub_10E80+CBj
		push	word ptr [bp+arg_2]
		push	di		; char *
		call	_strcat
		add	sp, 4
		push	word ptr [bp+arg_6] ; char **
		push	word ptr [bp+arg_2+2]
		push	di		; char *
		push	[bp+arg_0]	; int
		call	_spawnve
		add	sp, 8
		mov	[bp+var_84], ax
		inc	ax
		jz	short loc_10F7C
		jmp	loc_10EE7
; ---------------------------------------------------------------------------

loc_10F7C:				; CODE XREF: sub_10E80+F7j
		cmp	word_1115B, 2
		jz	short loc_10F86
		jmp	loc_10EE7
; ---------------------------------------------------------------------------

loc_10F86:				; CODE XREF: sub_10E80+101j
		cmp	byte ptr [si], 0
		jnz	short loc_10F8E
		jmp	loc_10EE7
; ---------------------------------------------------------------------------

loc_10F8E:				; CODE XREF: sub_10E80+109j
		mov	ax, si
		inc	si
		or	ax, ax
		jz	short loc_10F98
		jmp	loc_10F11
; ---------------------------------------------------------------------------

loc_10F98:				; CODE XREF: sub_10E80+113j
		jmp	loc_10EE7
; ---------------------------------------------------------------------------
		align 2

loc_10F9C:				; CODE XREF: sub_10E80+6Bj
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retn
sub_10E80	endp

; [00000014 BYTES: COLLAPSED FUNCTION __execload. PRESS	KEYPAD "+" TO EXPAND]

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_10FB6	proc near		; CODE XREF: sub_10E80+3Ep

arg_0		= word ptr  4
arg_2		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	di
		push	si
		mov	si, [bp+arg_0]
		mov	dx, [bp+arg_2]
		jmp	short loc_10FE5
; ---------------------------------------------------------------------------

loc_10FC6:				; CODE XREF: sub_10FB6+47j
		mov	al, [si]
		sub	ah, ah
		mov	bx, di
		mov	cl, 8
		shl	bx, cl
		or	ax, bx
		cmp	ax, dx
		jnz	short loc_10FE4
		lea	ax, [si-1]
		jmp	short loc_11001
; ---------------------------------------------------------------------------
		align 2

loc_10FDC:				; CODE XREF: sub_10FB6+42j
		cmp	dx, di
		jnz	short loc_10FE4
		mov	ax, si
		jmp	short loc_11001
; ---------------------------------------------------------------------------

loc_10FE4:				; CODE XREF: sub_10FB6+1Ej
					; sub_10FB6+28j
		inc	si

loc_10FE5:				; CODE XREF: sub_10FB6+Ej
		mov	al, [si]
		sub	ah, ah
		mov	di, ax
		or	di, di
		jz	short loc_10FFF
		mov	bx, di
		sub	bh, bh
		test	byte_11213[bx],	4
		jz	short loc_10FDC
		inc	si
		cmp	[si], ah
		jnz	short loc_10FC6

loc_10FFF:				; CODE XREF: sub_10FB6+37j
		sub	ax, ax

loc_11001:				; CODE XREF: sub_10FB6+23j
					; sub_10FB6+2Cj
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retn
sub_10FB6	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_11008	proc near		; CODE XREF: _spawnve+4Fp
					; sub_10E80+B2p

var_2		= word ptr -2
arg_0		= word ptr  4
arg_2		= word ptr  6

		push	bp
		mov	bp, sp
		sub	sp, 4
		push	di
		push	si
		mov	si, [bp+arg_0]
		sub	dx, dx

loc_11015:				; CODE XREF: sub_11008+40j
		mov	al, [si]
		sub	ah, ah
		mov	di, ax
		mov	bx, di
		sub	bh, bh
		test	byte_11213[bx],	4
		jz	short loc_1103C
		inc	si
		mov	al, [si]
		mov	bx, di
		mov	cl, 8
		shl	bx, cl
		or	ax, bx
		cmp	ax, [bp+arg_2]
		jnz	short loc_11043
		mov	dx, si
		dec	dx
		jmp	short loc_11043
; ---------------------------------------------------------------------------
		align 2

loc_1103C:				; CODE XREF: sub_11008+1Cj
		cmp	[bp+arg_2], di
		jnz	short loc_11043
		mov	dx, si

loc_11043:				; CODE XREF: sub_11008+2Cj
					; sub_11008+31j ...
		inc	si
		cmp	byte ptr [si-1], 0
		jnz	short loc_11015
		mov	[bp+var_2], dx
		mov	ax, dx
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retn
sub_11008	endp

; ---------------------------------------------------------------------------
		align 10h
seg000		ends

; ===========================================================================

; Segment type:	Pure data
dseg		segment	para public 'DATA' use16
		assume cs:dseg
word_11060	dw 0			; DATA XREF: _main+Bo _main+Fo ...
word_11062	dw 0			; DATA XREF: start+50w
		align 8
aMsRunTimeLibra	db 'MS Run-Time Library - Copyright (c) '
word_1108C	dw 3931h		; DATA XREF: __setenvp+11r
a88MicrosoftCor	db '88, Microsoft Corp',11h,0
aCut112x_pbd	db 'cut112x.pbd',0      ; DATA XREF: _main+Bo
aCut112x_pbd_1	db 'cut112x.pbd',0      ; DATA XREF: _main+Fo
aMusdrvt_com	db 'musdrvt.com',0      ; DATA XREF: _main+1Fo
aMusdrvt_com_0	db 'musdrvt.com',0      ; DATA XREF: _main+23o
aNosmain_exe	db 'nosmain.exe',0      ; DATA XREF: _main+3Co
aNosmain_exe_0	db 'nosmain.exe',0      ; DATA XREF: _main+40o
unk_110EA	db    0			; DATA XREF: start+4Aw	__myalloc+8r ...
		db    0
unk_110EC	db    0			; DATA XREF: start+3Ew
		db    0
unk_110EE	db 0FDh	; ˝		; DATA XREF: start+9Cw	start+AEr
		db    1
off_110F0	dd word_11060		; DATA XREF: start+39w	__myalloc+2r ...
		db 4Ch dup(0)
unk_11140	db  90h	; ê		; DATA XREF: _brkctl:loc_107AFr
					; _brkctl+61w
		db    0
aC_file_info	db ';C_FILE_INFO',0
word_1114F	dw 0			; DATA XREF: __cinit+Cw __ctermsub+Er
		dw 0			; DATA XREF: __cinit+10w
		db 8 dup(0)
word_1115B	dw 0			; DATA XREF: sub_105A8+26w
					; __cenvarg+89w ...
		db 4 dup(0)
word_11161	dw 0			; DATA XREF: start+5Ew	__cinit+26r ...
byte_11163	db 0			; DATA XREF: __cinit+4w __setargv+7r ...
		db 2 dup(0)
unk_11166	db    0			; DATA XREF: sub_105A8w __cenvarg+8Fw	...
		db    0
unk_11168	db  14h			; DATA XREF: __cenvarg:loc_10A3Cr
		db    0
		db  81h	; Å
		db  81h	; Å
		db  81h	; Å
		db    1
		db    1
		db 0Fh dup(0)
unk_1117E	db    0			; DATA XREF: start+89r	__setargv+BEw
		db    0
unk_11180	db    0			; DATA XREF: start+85r	__setargv+D0w
		db    0
unk_11182	db    0			; DATA XREF: start+81r	__setenvp+44w ...
		db    0
off_11184	dd unk_11188		; DATA XREF: __setargv+29w
					; __setargv+DEr ...
unk_11188	db  43h	; C		; DATA XREF: dseg:off_11184o
		db    0
unk_1118A	db    0			; DATA XREF: __dospawn+90w
					; __dospawn+CEw
		db    0
unk_1118C	db    0			; DATA XREF: __ctermsub+18r
unk_1118D	db    0			; DATA XREF: __ctermsub+20r
unk_1118E	db    0			; DATA XREF: __ctermsub+23r
		db    0
		db    0
		db    0
unk_11192	db    0			; DATA XREF: __FF_MSGBANNER+Ar
					; __FF_MSGBANNER+11r
		db    0
unk_11194	db 0A0h	; †		; DATA XREF: __chkstk+7r
		db    4
unk_11196	db    0			; DATA XREF: __setargvw __setargv+18Ar
		db    0
byte_11198	db 0, 16h, 2, 2, 18h, 0Dh, 9, 0Ch, 0Ch,	0Ch, 7,	8, 16h
					; DATA XREF: sub_105A8:loc_105C9o
		db 16h,	0FFh, 12h, 0Dh,	12h, 2,	0FFh
unk_111AC	db    0			; DATA XREF: unknown_libname_2+1Fw
		db    0
unk_111AE	db    0			; DATA XREF: unknown_libname_2+22w
		db    0
		db    0
		db    0
unk_111B2	db    0			; DATA XREF: unknown_libname_2+32w
		db    0
		db    0
		db    0
unk_111B6	db    0			; DATA XREF: __amalloc+A2r
		db    0
		db    0
		db    0
unk_111BA	db    0			; DATA XREF: __amalloc+4Fw
					; __amalloc+D6w
		db    0
unk_111BC	db    0			; DATA XREF: __amexpand:loc_10724r
					; __cenvarg:loc_10A94r	...
		db  20h
		db    0
		db    0
unk_111C0	db    0			; DATA XREF: __amalloc:loc_10689w
					; __amalloc:loc_106C4w
		db    0
aC_file_info_0	db ';C_FILE_INFO',0
		db    0
unk_111D0	db    0			; DATA XREF: __dospawn+29w
		db    0
unk_111D2	db    0			; DATA XREF: __dospawn+2Fw
					; __dospawn+38r
		db    0
unk_111D4	db    0			; DATA XREF: __dospawn+32w
		db    0
		dd 110A013Eh
		dd 110A014Eh
		db 20h dup(0)
a_com		db '.com',0
a_exe		db '.exe',0
aPath		db 'PATH',0             ; DATA XREF: sub_10E80:loc_10ED7o
asc_1120D	db '\',0                ; DATA XREF: sub_10E80+BEo
asc_1120F	db '\',0                ; DATA XREF: sub_10E80+CDo
		db    0
		db    0
byte_11213	db 40h dup(0), 3Fh dup(8), 0, 8, 1Fh dup(0Ch), 8, 5 dup(0Ah)
					; DATA XREF: sub_10FB6+3Dr
					; sub_11008+17r
		db 3Ah dup(9), 1Dh dup(0Ch), 6 dup(0)
unk_11316	db    0			; DATA XREF: __cinit+37r __cinit+4Dr ...
		db    0
unk_11318	db    0			; DATA XREF: __cinit+20r __ctermsubr
		db    0
unk_1131A	db    0			; DATA XREF: __cinit+2Fr
		db    0
		db    0
		db    0
unk_1131E	db    0			; DATA XREF: __cinit:loc_10165r
		db    0
		db    0
		db    0
unk_11322	db    0			; DATA XREF: __execloadr
		db    0
aNmsg		db '<<NMSG>>',0
		db    0
aR6000StackOver	db 'R6000',0Dh,0Ah
		db '- stack overflow',0Dh,0Ah,0
		db    3
		db    0
aR6003IntegerDi	db 'R6003',0Dh,0Ah
		db '- integer divide by 0',0Dh,0Ah,0
		db    9
		db    0
aR6009NotEnough	db 'R6009',0Dh,0Ah
		db '- not enough space for environment',0Dh,0Ah,0
		db 0FCh	; ¸
		db    0
		db  0Dh
		db  0Ah
		db    0
		db 0FFh
		db    0
aRunTimeError	db 'run-time error ',0
		db    2
		db    0
aR6002FloatingP	db 'R6002',0Dh,0Ah
		db '- floating point not loaded',0Dh,0Ah,0
		db    1
		db    0
aR6001NullPoint	db 'R6001',0Dh,0Ah
		db '- null pointer assignment',0Dh,0Ah,0
		db 0FFh
		db 0FFh
		db 0FFh
		align 4
dseg		ends

; ===========================================================================

; Segment type:	Uninitialized
seg002		segment	byte stack 'STACK' use16
		assume cs:seg002
		assume es:nothing, ss:nothing, ds:dseg,	fs:nothing, gs:nothing
		db 800h	dup(?)
seg002		ends


		end start
