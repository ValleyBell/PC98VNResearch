; ---------------------------------------------------------------------------

FILE		struc ;	(sizeof=0xC, standard type)
_ptr		dd ?			; offset
_cnt		dw ?
_base		dd ?			; offset
_flag		db ?
_file		db ?
FILE		ends

; ---------------------------------------------------------------------------

TextBoxDef	struc ;	(sizeof=0x12)
baseX		dw ?			; text box origin X, in	pixels
baseY		dw ?			; text box origin Y, in	pixels
sizeX		dw ?			; size X, in glyphs
sizeY		dw ?			; size Y, in glyphs
txSzX		dw ?			; text glyph size X? (always 18)
txSzY		dw ?			; text glyph size Y? (always 18)
txPosX		dw ?			; ?? (usually 0)
txPosY		dw ?			; ?? (usually 0)
field_10	dw ?			; base 10
TextBoxDef	ends


;
; Input	MD5   :	707EF7657151C90D532CCB1576055856
; Input	CRC32 :	217308FF

; File Name   :	R:\NOSMAIN.EXE
; Format      :	MS-DOS executable (EXE)
; Base Address:	1000h Range: 10000h-1D8B0h Loaded length: B570h
; Entry	Point :	1000:86AE
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
byte_10000	db 10h dup(0)

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

SetGDCPlane_Wrt	proc near		; CODE XREF: sub_106F6+90p
					; sub_106F6+D1p ...

arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		xor	ax, ax
		call	__chkstk
		mov	ax, [bp+arg_0]
		xor	ax, GDCPlaneWrt
		push	ax

loc_10020:
		mov	ax, 0A6h
		push	ax
		call	WritePort
		add	sp, 4
		mov	sp, bp
		pop	bp
		retn
SetGDCPlane_Wrt	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

SwapGDCPlanes	proc near		; CODE XREF: sub_10F59:loc_11033p
					; sub_11804+AAp ...
		push	bp
		mov	bp, sp
		xor	ax, ax
		call	__chkstk
		inc	GDCPlaneWrt
		and	GDCPlaneWrt, 1
		mov	ax, GDCPlaneWrt
		mov	GDCPlaneDisp, ax
		mov	word_1ADDA, 1

loc_1004B:				; CODE XREF: SwapGDCPlanes+24j
		cmp	word_1ADDA, 0
		jz	short loc_10054
		jmp	short loc_1004B
; ---------------------------------------------------------------------------

loc_10054:				; CODE XREF: SwapGDCPlanes+22j
		mov	sp, bp
		pop	bp
		retn
SwapGDCPlanes	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

LoadClearPBD	proc near		; CODE XREF: _main:loc_149B0p
		push	bp
		mov	bp, sp
		xor	ax, ax
		call	__chkstk
		push	word_1B594
		push	word_1B592
		mov	ax, offset aDClear_pbd ; "d:clear.pbd"
		push	ax
		call	LoadFile
		add	sp, 6
		mov	sp, bp
		pop	bp
		retn
LoadClearPBD	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_10076	proc near		; CODE XREF: sub_1013C+84p

var_2		= word ptr -2
arg_0		= word ptr  4
arg_2		= word ptr  6
arg_4		= word ptr  8

		push	bp
		mov	bp, sp
		mov	ax, 2
		call	__chkstk
		mov	[bp+var_2], 0
		and	[bp+arg_2], 0Fh
		and	[bp+arg_0], 7Fh
		and	[bp+arg_4], 7Fh
		mov	ax, [bp+arg_2]
		jmp	short loc_10110
; ---------------------------------------------------------------------------

loc_10095:				; CODE XREF: sub_10076+9Fj
		mov	ax, [bp+arg_4]
		cmp	[bp+arg_0], ax
		jnz	short loc_100A2
		mov	ax, 1
		jmp	short loc_100A4
; ---------------------------------------------------------------------------

loc_100A2:				; CODE XREF: sub_10076+25j
		sub	ax, ax

loc_100A4:				; CODE XREF: sub_10076+2Aj
		mov	[bp+var_2], ax
		jmp	loc_10133
; ---------------------------------------------------------------------------

loc_100AA:				; CODE XREF: sub_10076+A5j
		mov	ax, [bp+arg_4]
		cmp	[bp+arg_0], ax
		jle	short loc_100B7
		mov	ax, 1
		jmp	short loc_100B9
; ---------------------------------------------------------------------------

loc_100B7:				; CODE XREF: sub_10076+3Aj
		sub	ax, ax

loc_100B9:				; CODE XREF: sub_10076+3Fj
		mov	[bp+var_2], ax
		jmp	short loc_10133
; ---------------------------------------------------------------------------

loc_100BE:				; CODE XREF: sub_10076+AAj
		mov	ax, [bp+arg_4]
		cmp	[bp+arg_0], ax
		jge	short loc_100CB
		mov	ax, 1
		jmp	short loc_100CD
; ---------------------------------------------------------------------------

loc_100CB:				; CODE XREF: sub_10076+4Ej
		sub	ax, ax

loc_100CD:				; CODE XREF: sub_10076+53j
		mov	[bp+var_2], ax
		jmp	short loc_10133
; ---------------------------------------------------------------------------

loc_100D2:				; CODE XREF: sub_10076+AFj
		mov	ax, [bp+arg_4]
		cmp	[bp+arg_0], ax
		jl	short loc_100DF
		mov	ax, 1
		jmp	short loc_100E1
; ---------------------------------------------------------------------------

loc_100DF:				; CODE XREF: sub_10076+62j
		sub	ax, ax

loc_100E1:				; CODE XREF: sub_10076+67j
		mov	[bp+var_2], ax
		jmp	short loc_10133
; ---------------------------------------------------------------------------

loc_100E6:				; CODE XREF: sub_10076+B4j
		mov	ax, [bp+arg_4]
		cmp	[bp+arg_0], ax
		jg	short loc_100F3
		mov	ax, 1
		jmp	short loc_100F5
; ---------------------------------------------------------------------------

loc_100F3:				; CODE XREF: sub_10076+76j
		sub	ax, ax

loc_100F5:				; CODE XREF: sub_10076+7Bj
		mov	[bp+var_2], ax
		jmp	short loc_10133
; ---------------------------------------------------------------------------

loc_100FA:				; CODE XREF: sub_10076+B9j
		mov	ax, [bp+arg_4]
		cmp	[bp+arg_0], ax
		jz	short loc_10107
		mov	ax, 1
		jmp	short loc_10109
; ---------------------------------------------------------------------------

loc_10107:				; CODE XREF: sub_10076+8Aj
		sub	ax, ax

loc_10109:				; CODE XREF: sub_10076+8Fj
		mov	[bp+var_2], ax
		jmp	short loc_10133
; ---------------------------------------------------------------------------
		jmp	short loc_10133
; ---------------------------------------------------------------------------

loc_10110:				; CODE XREF: sub_10076+1Dj
		cmp	ax, 2
		jnz	short loc_10118
		jmp	loc_10095
; ---------------------------------------------------------------------------

loc_10118:				; CODE XREF: sub_10076+9Dj
		cmp	ax, 3
		jz	short loc_100AA
		cmp	ax, 4
		jz	short loc_100BE
		cmp	ax, 5
		jz	short loc_100D2
		cmp	ax, 6
		jz	short loc_100E6
		cmp	ax, 7
		jz	short loc_100FA
		jmp	short $+2

loc_10133:				; CODE XREF: sub_10076+31j
					; sub_10076+46j ...
		mov	ax, [bp+var_2]
		jmp	short $+2
		mov	sp, bp
		pop	bp
		retn
sub_10076	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1013C	proc near		; CODE XREF: ExecuteScript:scr0B_VarComparep

var_10		= word ptr -10h
var_E		= word ptr -0Eh
var_C		= word ptr -0Ch
var_A		= word ptr -0Ah
var_6		= word ptr -6
var_2		= word ptr -2

		push	bp
		mov	bp, sp
		mov	ax, 10h
		call	__chkstk
		push	si
		mov	[bp+var_A], 0
		mov	[bp+var_C], 0
		mov	[bp+var_E], 0
		mov	[bp+var_2], 0
		mov	[bp+var_6], 0

loc_1015F:				; CODE XREF: sub_1013C+3Cj
		call	ScrData_GetByte
		mov	[bp+var_10], ax
		test	al, 80h
		jz	short loc_1017A
		mov	bx, [bp+var_A]
		inc	[bp+var_A]
		mov	al, byte ptr [bp+var_10]
		and	al, 7Fh
		mov	[bx+1690h], al
		jmp	short loc_1015F
; ---------------------------------------------------------------------------

loc_1017A:				; CODE XREF: sub_1013C+2Bj
		dec	word ptr scrDataPtr
		mov	ax, [bp+var_A]
		mov	[bp+var_2], ax
		mov	[bp+var_A], 0
		jmp	short loc_1018E
; ---------------------------------------------------------------------------

loc_1018B:				; CODE XREF: sub_1013C+E1j
		inc	[bp+var_A]

loc_1018E:				; CODE XREF: sub_1013C+4Dj
		mov	ax, [bp+var_2]
		cmp	[bp+var_A], ax
		jb	short loc_10199
		jmp	loc_10220
; ---------------------------------------------------------------------------

loc_10199:				; CODE XREF: sub_1013C+58j
		test	byte ptr [bp+var_A], 1
		jz	short loc_101F9
		mov	bx, [bp+var_A]
		test	byte ptr [bx+1690h], 10h
		jz	short loc_101D5
		mov	al, [bx+1691h]
		sub	ah, ah
		push	ax
		mov	al, [bx+1690h]
		push	ax
		mov	bl, [bx+168Fh]
		sub	bh, bh
		mov	al, [bx+1C42h]
		push	ax
		call	sub_10076
		add	sp, 6
		mov	bx, [bp+var_6]
		mov	[bx+16DFh], al
		inc	[bp+var_A]
		dec	[bp+var_6]
		jmp	short loc_101F7
; ---------------------------------------------------------------------------

loc_101D5:				; CODE XREF: sub_1013C+6Bj
		mov	bx, [bp+var_A]
		test	byte ptr [bx+1690h], 8
		jz	short loc_101E7
		mov	bx, [bp+var_6]
		xor	byte ptr [bx+16DFh], 1

loc_101E7:				; CODE XREF: sub_1013C+A1j
		mov	bx, [bp+var_6]
		mov	si, [bp+var_A]
		mov	al, [si+1690h]
		and	al, 7
		mov	[bx+16E0h], al

loc_101F7:				; CODE XREF: sub_1013C+97j
		jmp	short loc_1021A
; ---------------------------------------------------------------------------

loc_101F9:				; CODE XREF: sub_1013C+61j
		mov	bx, [bp+var_A]
		mov	bl, [bx+1690h]
		sub	bh, bh
		cmp	[bx+1C42h], bh
		jz	short loc_10212
		mov	bx, [bp+var_6]
		mov	byte ptr [bx+16E0h], 1
		jmp	short loc_1021A
; ---------------------------------------------------------------------------

loc_10212:				; CODE XREF: sub_1013C+CAj
		mov	bx, [bp+var_6]
		mov	byte ptr [bx+16E0h], 0

loc_1021A:				; CODE XREF: sub_1013C:loc_101F7j
					; sub_1013C+D4j
		inc	[bp+var_6]
		jmp	loc_1018B
; ---------------------------------------------------------------------------

loc_10220:				; CODE XREF: sub_1013C+5Aj
		mov	al, byte_1BD30
		sub	ah, ah
		mov	[bp+var_C], ax
		mov	[bp+var_A], 1
		jmp	short loc_10233
; ---------------------------------------------------------------------------

loc_1022F:				; CODE XREF: sub_1013C:loc_10276j
		add	[bp+var_A], 2

loc_10233:				; CODE XREF: sub_1013C+F1j
		mov	ax, [bp+var_6]
		cmp	[bp+var_A], ax
		jnb	short loc_10278
		mov	bx, [bp+var_A]
		mov	al, [bx+16E0h]
		sub	ah, ah
		jmp	short loc_10266
; ---------------------------------------------------------------------------

loc_10246:				; CODE XREF: sub_1013C+12Cj
		mov	bx, [bp+var_A]
		mov	al, [bx+16E1h]
		sub	ah, ah
		and	[bp+var_C], ax
		jmp	short loc_10276
; ---------------------------------------------------------------------------

loc_10254:				; CODE XREF: sub_1013C+131j
		mov	bx, [bp+var_A]
		mov	al, [bx+16E1h]
		sub	ah, ah
		or	[bp+var_C], ax
		jmp	short loc_10276
; ---------------------------------------------------------------------------

loc_10262:				; CODE XREF: sub_1013C+136j
		jmp	short loc_10276
; ---------------------------------------------------------------------------
		jmp	short loc_10276
; ---------------------------------------------------------------------------

loc_10266:				; CODE XREF: sub_1013C+108j
		or	ax, ax
		jz	short loc_10246
		cmp	ax, 1
		jz	short loc_10254
		cmp	ax, 2
		jz	short loc_10262
		jmp	short $+2

loc_10276:				; CODE XREF: sub_1013C+116j
					; sub_1013C+124j ...
		jmp	short loc_1022F
; ---------------------------------------------------------------------------

loc_10278:				; CODE XREF: sub_1013C+FDj
		mov	ax, [bp+var_C]
		jmp	short $+2
		pop	si
		mov	sp, bp
		pop	bp
		retn
sub_1013C	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

ScrData_Str2Buf	proc near		; CODE XREF: sub_11258+23p
					; sub_11296+61p ...

var_2		= byte ptr -2
arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		mov	ax, 2
		call	__chkstk
		cmp	debugMode, 0
		jz	short loc_1029C
		mov	ax, offset aStr	; " str	"
		push	ax		; char *
		call	_printf
		add	sp, 2

loc_1029C:				; CODE XREF: ScrData_Str2Buf+Ej
					; ScrData_Str2Buf+34j
		les	bx, scrDataPtr
		mov	al, es:[bx]
		mov	[bp+var_2], al
		or	al, al
		jz	short loc_102B8
		mov	bx, [bp+arg_0]
		mov	[bx], al
		inc	[bp+arg_0]
		inc	word ptr scrDataPtr
		jmp	short loc_1029C
; ---------------------------------------------------------------------------

loc_102B8:				; CODE XREF: ScrData_Str2Buf+26j
		inc	word ptr scrDataPtr
		mov	bx, [bp+arg_0]
		mov	byte ptr [bx], 0
		mov	sp, bp
		pop	bp
		retn
ScrData_Str2Buf	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

ScrData_GetStr	proc near		; CODE XREF: ExecuteScript+DBp
					; ExecuteScript+112p ...

var_4		= word ptr -4
var_2		= word ptr -2

		push	bp
		mov	bp, sp
		mov	ax, 4
		call	__chkstk
		mov	ax, word ptr scrDataPtr
		mov	dx, word ptr scrDataPtr+2
		mov	[bp+var_4], ax
		mov	[bp+var_2], dx
		cmp	debugMode, 0
		jz	short loc_102ED
		mov	ax, offset aStr_0 ; " str "
		push	ax		; char *
		call	_printf
		add	sp, 2

loc_102ED:				; CODE XREF: ScrData_GetStr+1Bj
					; ScrData_GetStr+35j
		les	bx, scrDataPtr
		cmp	byte ptr es:[bx], 0
		jz	short loc_102FD
		inc	word ptr scrDataPtr
		jmp	short loc_102ED
; ---------------------------------------------------------------------------

loc_102FD:				; CODE XREF: ScrData_GetStr+2Fj
		inc	word ptr scrDataPtr
		mov	ax, [bp+var_4]
		mov	dx, [bp+var_2]
		jmp	short $+2
		mov	sp, bp
		pop	bp
		retn
ScrData_GetStr	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

ScrData_GetByte	proc near		; CODE XREF: sub_1013C:loc_1015Fp
					; sub_10A07+Ap	...

var_2		= word ptr -2

		push	bp
		mov	bp, sp
		mov	ax, 2
		call	__chkstk
		les	bx, scrDataPtr
		mov	al, es:[bx]
		sub	ah, ah
		mov	[bp+var_2], ax
		inc	word ptr scrDataPtr
		cmp	debugMode, 0
		jz	short loc_10338
		push	ax
		mov	ax, offset aND	; " n%d	"
		push	ax		; char *
		call	_printf
		add	sp, 4

loc_10338:				; CODE XREF: ScrData_GetByte+1Ej
		mov	ax, [bp+var_2]
		jmp	short $+2
		mov	sp, bp
		pop	bp
		retn
ScrData_GetByte	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

IsSlowTextEnabled proc near		; CODE XREF: DrawText_Dialog+160p

var_2		= word ptr -2

		push	bp
		mov	bp, sp
		mov	ax, 2
		call	__chkstk
		les	bx, scrDataPtr
		mov	al, es:[bx]
		sub	ah, ah
		mov	[bp+var_2], ax
		cmp	ax, 1
		jnz	short loc_10362
		mov	ax, 1
		jmp	short loc_10366
; ---------------------------------------------------------------------------
		jmp	short loc_10366
; ---------------------------------------------------------------------------

loc_10362:				; CODE XREF: IsSlowTextEnabled+18j
		sub	ax, ax
		jmp	short $+2

loc_10366:				; CODE XREF: IsSlowTextEnabled+1Dj
					; IsSlowTextEnabled+1Fj
		mov	sp, bp
		pop	bp
		retn
IsSlowTextEnabled endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

ScrData_GetInt	proc near		; CODE XREF: sub_10A07+11p
					; sub_10A07+1Dp ...

var_2		= word ptr -2

		push	bp
		mov	bp, sp
		mov	ax, 2
		call	__chkstk
		les	bx, scrDataPtr
		mov	al, es:[bx]
		sub	ah, ah
		mov	[bp+var_2], ax
		inc	word ptr scrDataPtr
		mov	bx, word ptr scrDataPtr
		mov	ah, es:[bx]
		sub	al, al
		add	[bp+var_2], ax
		inc	word ptr scrDataPtr
		cmp	debugMode, 0
		jz	short loc_103A7
		push	[bp+var_2]
		mov	ax, offset aND_0 ; " n%d "
		push	ax		; char *
		call	_printf
		add	sp, 4

loc_103A7:				; CODE XREF: ScrData_GetInt+2Ej
		mov	ax, [bp+var_2]
		jmp	short $+2
		mov	sp, bp
		pop	bp
		retn
ScrData_GetInt	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

; int __cdecl sub_103B0(char *)
sub_103B0	proc near		; CODE XREF: ExecuteScript+506p
					; _main+15Bp

var_50		= byte ptr -50h
arg_0		= dword	ptr  4

		push	bp
		mov	bp, sp
		mov	ax, 50h	; 'P'
		call	__chkstk
		mov	ax, word ptr scrDataBasePtr
		mov	dx, word ptr scrDataBasePtr+2
		mov	word ptr scrDataPtr, ax
		mov	word ptr scrDataPtr+2, dx
		mov	scrStackIdx, 0
		cmp	debugMode, 0
		jz	short loc_103E7
		push	word ptr [bp+arg_0] ; char *
		mov	ax, offset aS_sd ; "%s.sd"
		push	ax
		lea	ax, [bp+var_50]
		push	ax		; char *
		call	_sprintf
		add	sp, 6
		jmp	short loc_103F8
; ---------------------------------------------------------------------------

loc_103E7:				; CODE XREF: sub_103B0+22j
		push	word ptr [bp+arg_0] ; char *
		mov	ax, offset aCS_sd ; "c:%s.sd"
		push	ax
		lea	ax, [bp+var_50]
		push	ax		; char *
		call	_sprintf
		add	sp, 6

loc_103F8:				; CODE XREF: sub_103B0+35j
		push	word ptr scrDataPtr+2
		push	word ptr scrDataPtr
		lea	ax, [bp+var_50]
		push	ax
		call	LoadFile
		add	sp, 6
		jmp	short $+2
		mov	sp, bp
		pop	bp
		retn
sub_103B0	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

ReadSaveGame	proc near		; CODE XREF: ExecuteScript+921p

var_54		= word ptr -54h
var_52		= dword	ptr -52h

		push	bp
		mov	bp, sp
		mov	ax, 54h
		call	__chkstk
		cmp	debugMode, 0
		jz	short loc_10430
		mov	ax, offset aCut_pbd_0 ;	"cut.pbd"
		push	ax
		lea	ax, [bp+var_52+2]
		push	ax		; char *
		call	_sprintf
		add	sp, 4
		jmp	short loc_1043E
; ---------------------------------------------------------------------------

loc_10430:				; CODE XREF: ReadSaveGame+Ej
		mov	ax, offset aACut_pbd_0 ; "a:cut.pbd"
		push	ax
		lea	ax, [bp+var_52+2]
		push	ax		; char *
		call	_sprintf
		add	sp, 4

loc_1043E:				; CODE XREF: ReadSaveGame+1Ej
		mov	ax, offset aRb_1 ; "rb"
		push	ax
		lea	ax, [bp+var_52+2]
		push	ax		; char *
		call	_fopen
		add	sp, 4
		mov	word ptr [bp+var_52], ax
		or	ax, ax
		jz	short loc_10481
		mov	[bp+var_54], 0
		jmp	short loc_1045D
; ---------------------------------------------------------------------------

loc_1045A:				; CODE XREF: ReadSaveGame+64j
		inc	[bp+var_54]

loc_1045D:				; CODE XREF: ReadSaveGame+48j
		cmp	[bp+var_54], 80h
		jge	short loc_10476
		push	word ptr [bp+var_52] ; FILE *
		call	_fgetc
		add	sp, 2
		mov	bx, [bp+var_54]
		mov	scriptRAM[bx], al
		jmp	short loc_1045A
; ---------------------------------------------------------------------------

loc_10476:				; CODE XREF: ReadSaveGame+52j
		push	word ptr [bp+var_52] ; FILE *
		call	_fclose
		add	sp, 2
		jmp	short loc_10487
; ---------------------------------------------------------------------------

loc_10481:				; CODE XREF: ReadSaveGame+41j
		mov	fileLoadErr, 1

loc_10487:				; CODE XREF: ReadSaveGame+6Fj
		mov	sp, bp
		pop	bp
		retn
ReadSaveGame	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

WriteSaveGame	proc near		; CODE XREF: ExecuteScript+929p

var_54		= word ptr -54h
var_52		= dword	ptr -52h
arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		mov	ax, 54h
		call	__chkstk
		cmp	[bp+arg_0], 2
		jnz	short loc_104B5
		mov	[bp+var_54], 0
		jmp	short loc_104A4
; ---------------------------------------------------------------------------

loc_104A1:				; CODE XREF: WriteSaveGame+28j
		inc	[bp+var_54]

loc_104A4:				; CODE XREF: WriteSaveGame+14j
		cmp	[bp+var_54], 80h
		jge	short loc_104B5
		mov	bx, [bp+var_54]
		mov	scriptRAM[bx], 0
		jmp	short loc_104A1
; ---------------------------------------------------------------------------

loc_104B5:				; CODE XREF: WriteSaveGame+Dj
					; WriteSaveGame+1Ej
		cmp	debugMode, 0
		jz	short loc_104CC
		mov	ax, offset aCut_pbd ; "cut.pbd"
		push	ax
		lea	ax, [bp+var_52+2]
		push	ax		; char *
		call	_sprintf
		add	sp, 4
		jmp	short loc_104DA
; ---------------------------------------------------------------------------

loc_104CC:				; CODE XREF: WriteSaveGame+2Fj
		mov	ax, offset aACut_pbd ; "a:cut.pbd"
		push	ax
		lea	ax, [bp+var_52+2]
		push	ax		; char *
		call	_sprintf
		add	sp, 4

loc_104DA:				; CODE XREF: WriteSaveGame+3Fj
		mov	ax, offset aWb	; "wb"
		push	ax
		lea	ax, [bp+var_52+2]
		push	ax		; char *
		call	_fopen
		add	sp, 4
		mov	word ptr [bp+var_52], ax
		or	ax, ax
		jz	short loc_1051E
		mov	[bp+var_54], 0
		jmp	short loc_104F9
; ---------------------------------------------------------------------------

loc_104F6:				; CODE XREF: WriteSaveGame+88j
		inc	[bp+var_54]

loc_104F9:				; CODE XREF: WriteSaveGame+69j
		cmp	[bp+var_54], 80h
		jge	short loc_10515
		push	word ptr [bp+var_52] ; FILE *
		mov	bx, [bp+var_54]
		mov	al, scriptRAM[bx]
		sub	ah, ah
		push	ax		; int
		call	_fputc
		add	sp, 4
		jmp	short loc_104F6
; ---------------------------------------------------------------------------

loc_10515:				; CODE XREF: WriteSaveGame+73j
		push	word ptr [bp+var_52] ; FILE *
		call	_fclose
		add	sp, 2

loc_1051E:				; CODE XREF: WriteSaveGame+62j
		mov	sp, bp
		pop	bp
		retn
WriteSaveGame	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_10522	proc near		; CODE XREF: ExecuteScript+2A9p
					; sub_143EC+2Fp

arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		xor	ax, ax
		call	__chkstk
		mov	ax, 0BFh ; '¿'
		mul	word_1ABF0
		add	ax, 7
		mov	word_1ABF0, ax
		sub	dx, dx
		div	[bp+arg_0]
		mov	ax, dx
		jmp	short $+2
		mov	sp, bp
		pop	bp
		retn
sub_10522	endp

; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		xor	ax, ax
		call	__chkstk
		mov	ax, word ptr scrDataPtr
		mov	dx, word ptr scrDataPtr+2
		mov	word_1BD80, ax
		mov	word_1BD82, dx
		mov	sp, bp
		pop	bp
		retn
; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		xor	ax, ax
		call	__chkstk
		mov	ax, word_1BD80
		mov	dx, word_1BD82
		mov	word ptr scrDataPtr, ax
		mov	word ptr scrDataPtr+2, dx
		mov	sp, bp
		pop	bp
		retn

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

scrCall		proc near		; CODE XREF: ExecuteScript+3EDp

arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		xor	ax, ax
		call	__chkstk
		mov	bx, scrStackIdx
		inc	scrStackIdx
		shl	bx, 1
		shl	bx, 1
		mov	ax, word ptr scrDataPtr
		mov	dx, word ptr scrDataPtr+2
		mov	word ptr scrStackPtrs[bx], ax
		mov	word ptr (scrStackPtrs+2)[bx], dx
		cmp	[bp+arg_0], 0FFFFh
		jz	short loc_105B3
		mov	ax, [bp+arg_0]
		add	ax, word ptr scrDataBasePtr
		mov	dx, word ptr scrDataBasePtr+2
		mov	word ptr scrDataPtr, ax
		mov	word ptr scrDataPtr+2, dx

loc_105B3:				; CODE XREF: scrCall+27j
		mov	byte ptr scrStackIdx+1,	0
		mov	sp, bp
		pop	bp
		retn
scrCall		endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

scrReturn	proc near		; CODE XREF: ExecuteScript:scr32_Retp
		push	bp
		mov	bp, sp
		xor	ax, ax
		call	__chkstk
		cmp	scrStackIdx, 0
		jz	short loc_105E6
		dec	scrStackIdx
		mov	bx, scrStackIdx
		shl	bx, 1
		shl	bx, 1
		mov	ax, word ptr scrStackPtrs[bx]
		mov	dx, word ptr (scrStackPtrs+2)[bx]
		mov	word ptr scrDataPtr, ax
		mov	word ptr scrDataPtr+2, dx

loc_105E6:				; CODE XREF: scrReturn+Dj
		mov	sp, bp
		pop	bp
		retn
scrReturn	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_105EA	proc near		; CODE XREF: sub_11DF6+C6p
					; sub_11F4B+C6p ...

var_C		= word ptr -0Ch
var_A		= word ptr -0Ah
var_8		= word ptr -8
var_6		= word ptr -6
var_4		= dword	ptr -4
arg_0		= word ptr  4
arg_2		= word ptr  6

		push	bp
		mov	bp, sp
		mov	ax, 0Ch
		call	__chkstk
		push	si
		mov	[bp+var_A], 0
		mov	[bp+var_C], 0
		jmp	short loc_10603
; ---------------------------------------------------------------------------

loc_10600:				; CODE XREF: sub_105EA:loc_10669j
		inc	[bp+var_C]

loc_10603:				; CODE XREF: sub_105EA+14j
		cmp	[bp+var_C], 4
		jnb	short loc_1066B
		mov	bx, [bp+var_C]
		shl	bx, 1
		shl	bx, 1
		mov	ax, [bx+646h]
		mov	dx, [bx+648h]
		mov	word ptr [bp+var_4], ax
		mov	word ptr [bp+var_4+2], dx
		mov	[bp+var_8], 0
		jmp	short loc_10628
; ---------------------------------------------------------------------------

loc_10625:				; CODE XREF: sub_105EA:loc_10667j
		inc	[bp+var_8]

loc_10628:				; CODE XREF: sub_105EA+39j
		cmp	[bp+var_8], 0C8h ; 'È'
		jnb	short loc_10669
		mov	[bp+var_6], 0
		jmp	short loc_10639
; ---------------------------------------------------------------------------

loc_10636:				; CODE XREF: sub_105EA+7Bj
		inc	[bp+var_6]

loc_10639:				; CODE XREF: sub_105EA+4Aj
		cmp	[bp+var_6], 36h	; '6'
		jnb	short loc_10667
		mov	ax, [bp+arg_2]
		add	ax, [bp+var_8]
		mov	cx, 50h	; 'P'
		mul	cx
		mov	bx, ax
		add	bx, [bp+arg_0]
		add	bx, [bp+var_6]
		les	si, [bp+var_4]
		mov	al, es:[bx+si]
		mov	bx, [bp+var_A]
		inc	[bp+var_A]
		les	si, dword_1BCDC
		mov	es:[bx+si], al
		jmp	short loc_10636
; ---------------------------------------------------------------------------

loc_10667:				; CODE XREF: sub_105EA+53j
		jmp	short loc_10625
; ---------------------------------------------------------------------------

loc_10669:				; CODE XREF: sub_105EA+43j
		jmp	short loc_10600
; ---------------------------------------------------------------------------

loc_1066B:				; CODE XREF: sub_105EA+1Dj
		pop	si
		mov	sp, bp
		pop	bp
		retn
sub_105EA	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_10670	proc near		; CODE XREF: ExecuteScript+FE1p

var_C		= word ptr -0Ch
var_A		= word ptr -0Ah
var_8		= word ptr -8
var_6		= word ptr -6
var_4		= dword	ptr -4
arg_0		= word ptr  4
arg_2		= word ptr  6

		push	bp
		mov	bp, sp
		mov	ax, 0Ch
		call	__chkstk
		push	si
		mov	[bp+var_A], 0
		mov	[bp+var_C], 0
		jmp	short loc_10689
; ---------------------------------------------------------------------------

loc_10686:				; CODE XREF: sub_10670:loc_106EFj
		inc	[bp+var_C]

loc_10689:				; CODE XREF: sub_10670+14j
		cmp	[bp+var_C], 4
		jnb	short loc_106F1
		mov	bx, [bp+var_C]
		shl	bx, 1
		shl	bx, 1
		mov	ax, [bx+646h]
		mov	dx, [bx+648h]
		mov	word ptr [bp+var_4], ax
		mov	word ptr [bp+var_4+2], dx
		mov	[bp+var_8], 0
		jmp	short loc_106AE
; ---------------------------------------------------------------------------

loc_106AB:				; CODE XREF: sub_10670:loc_106EDj
		inc	[bp+var_8]

loc_106AE:				; CODE XREF: sub_10670+39j
		cmp	[bp+var_8], 0C8h ; 'È'
		jnb	short loc_106EF
		mov	[bp+var_6], 0
		jmp	short loc_106BF
; ---------------------------------------------------------------------------

loc_106BC:				; CODE XREF: sub_10670+7Bj
		inc	[bp+var_6]

loc_106BF:				; CODE XREF: sub_10670+4Aj
		cmp	[bp+var_6], 36h	; '6'
		jnb	short loc_106ED
		mov	ax, [bp+arg_2]
		add	ax, [bp+var_8]
		mov	cx, 50h	; 'P'
		mul	cx
		mov	bx, ax
		add	bx, [bp+arg_0]
		add	bx, [bp+var_6]
		les	si, [bp+var_4]
		mov	al, es:[bx+si]
		mov	bx, [bp+var_A]
		inc	[bp+var_A]
		les	si, dword_1C1A8
		mov	es:[bx+si], al
		jmp	short loc_106BC
; ---------------------------------------------------------------------------

loc_106ED:				; CODE XREF: sub_10670+53j
		jmp	short loc_106AB
; ---------------------------------------------------------------------------

loc_106EF:				; CODE XREF: sub_10670+43j
		jmp	short loc_10686
; ---------------------------------------------------------------------------

loc_106F1:				; CODE XREF: sub_10670+1Dj
		pop	si
		mov	sp, bp
		pop	bp
		retn
sub_10670	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_106F6	proc near		; CODE XREF: sub_10A4B+74p

var_6		= word ptr -6
var_4		= word ptr -4
var_2		= byte ptr -2

		push	bp
		mov	bp, sp
		mov	ax, 6
		call	__chkstk
		push	si
		mov	bx, word_1AC94
		mov	al, byte_1AC44[bx]
		mov	[bp+var_2], al
		mov	ax, bx
		cwd
		mov	cx, 5
		idiv	cx
		mov	ax, bx
		mov	cx, dx
		cwd
		mov	bx, 5
		idiv	bx
		sub	ax, 4
		neg	ax
		mov	dx, ax
		shl	ax, 1
		shl	ax, 1
		shl	ax, 1
		add	ax, dx
		sub	ax, cx
		add	ax, 4
		mov	[bp+var_6], ax
		mov	[bp+var_4], 0
		jmp	short loc_1073E
; ---------------------------------------------------------------------------

loc_1073B:				; CODE XREF: sub_106F6+6Aj
		inc	[bp+var_4]

loc_1073E:				; CODE XREF: sub_106F6+43j
		cmp	[bp+var_4], 5
		jge	short loc_10762
		mov	bx, [bp+var_4]
		shl	bx, 1
		mov	ax, [bp+var_4]
		mov	cx, ax
		shl	ax, 1
		shl	ax, 1
		shl	ax, 1
		add	ax, cx
		add	ax, [bp+var_6]
		add	ax, offset byte_1ABF2
		mov	word_1B596[bx],	ax
		jmp	short loc_1073B
; ---------------------------------------------------------------------------

loc_10762:				; CODE XREF: sub_106F6+4Cj
		mov	[bp+var_4], 0
		jmp	short loc_1076C
; ---------------------------------------------------------------------------

loc_10769:				; CODE XREF: sub_106F6:loc_10805j
		inc	[bp+var_4]

loc_1076C:				; CODE XREF: sub_106F6+71j
		cmp	[bp+var_4], 19h
		jl	short loc_10775
		jmp	loc_10808
; ---------------------------------------------------------------------------

loc_10775:				; CODE XREF: sub_106F6+7Aj
		mov	bx, [bp+var_4]
		cmp	byte_1AC44[bx],	0Dh
		jb	short loc_10782
		jmp	loc_10805
; ---------------------------------------------------------------------------

loc_10782:				; CODE XREF: sub_106F6+87j
		mov	ax, 1
		push	ax
		call	SetGDCPlane_Wrt
		add	sp, 2
		mov	ax, 0FEFFh
		push	ax
		mov	ax, 0Ah
		push	ax
		mov	ax, [bp+var_4]
		cwd
		mov	cx, 5
		idiv	cx
		mov	bx, ax
		shl	bx, 1
		mov	bx, word_1B596[bx]
		mov	ax, [bp+var_4]
		cwd
		idiv	cx
		mov	si, dx
		mov	al, [bx+si]
		sub	ah, ah
		add	ax, 8
		push	ax
		mov	bx, [bp+var_4]
		shl	bx, 1
		push	word_1C1B0[bx]
		call	sub_14CC2
		add	sp, 8
		sub	ax, ax
		push	ax
		call	SetGDCPlane_Wrt
		add	sp, 2
		mov	ax, 0FEFFh
		push	ax
		mov	ax, 0Ah
		push	ax
		mov	ax, [bp+var_4]
		cwd
		mov	cx, 5
		idiv	cx
		mov	bx, ax
		shl	bx, 1
		mov	bx, word_1B596[bx]
		mov	ax, [bp+var_4]
		cwd
		idiv	cx
		mov	si, dx
		mov	al, [bx+si]
		sub	ah, ah
		add	ax, 8
		push	ax
		mov	bx, [bp+var_4]
		shl	bx, 1
		push	word_1C1B0[bx]
		call	sub_14CC2
		add	sp, 8

loc_10805:				; CODE XREF: sub_106F6+89j
		jmp	loc_10769
; ---------------------------------------------------------------------------

loc_10808:				; CODE XREF: sub_106F6+7Cj
		mov	al, [bp+var_2]
		sub	ah, ah
		push	ax
		call	sub_13A63
		add	sp, 2
		pop	si
		mov	sp, bp
		pop	bp
		retn
sub_106F6	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_10819	proc near		; CODE XREF: sub_10A4B+205p

var_A		= word ptr -0Ah
var_6		= word ptr -6
var_4		= word ptr -4
var_2		= byte ptr -2
arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		mov	ax, 0Ah
		call	__chkstk
		mov	[bp+var_4], 8
		mov	bx, word_1AC94
		mov	al, byte_1AC44[bx]
		mov	[bp+var_2], al
		mov	ax, bx
		cwd
		mov	cx, 5
		idiv	cx
		mov	ax, bx
		mov	cx, dx
		cwd
		mov	bx, 5
		idiv	bx
		sub	ax, 4
		neg	ax
		mov	dx, ax
		shl	ax, 1
		shl	ax, 1
		shl	ax, 1
		add	ax, dx
		sub	ax, cx
		add	ax, 4
		mov	[bp+var_A], ax
		mov	[bp+var_6], 0
		jmp	short loc_10865
; ---------------------------------------------------------------------------

loc_10862:				; CODE XREF: sub_10819+6Ej
		inc	[bp+var_6]

loc_10865:				; CODE XREF: sub_10819+47j
		cmp	[bp+var_6], 5
		jge	short loc_10889
		mov	bx, [bp+var_6]
		shl	bx, 1
		mov	ax, [bp+var_6]
		mov	cx, ax
		shl	ax, 1
		shl	ax, 1
		shl	ax, 1
		add	ax, cx
		add	ax, [bp+var_A]
		add	ax, offset byte_1ABF2
		mov	word_1B596[bx],	ax
		jmp	short loc_10862
; ---------------------------------------------------------------------------

loc_10889:				; CODE XREF: sub_10819+50j
		mov	word_1AB44, 2
		cmp	[bp+arg_0], 0
		jz	short loc_108FC
		mov	[bp+var_6], 0
		jmp	short loc_1089F
; ---------------------------------------------------------------------------

loc_1089C:				; CODE XREF: sub_10819:loc_108F8j
		inc	[bp+var_6]

loc_1089F:				; CODE XREF: sub_10819+81j
		cmp	[bp+var_6], 19h
		jge	short loc_108FA
		mov	bx, [bp+var_6]
		cmp	byte_1AC44[bx],	0Dh
		jnb	short loc_108F8
		mov	ax, 1
		push	ax
		call	SetGDCPlane_Wrt
		add	sp, 2
		mov	ax, 0FFFFh
		push	ax
		mov	ax, 0Bh
		push	ax
		mov	ax, 8
		push	ax
		mov	bx, [bp+var_6]
		shl	bx, 1
		push	word_1C1B0[bx]
		call	sub_14CC2
		add	sp, 8
		sub	ax, ax
		push	ax
		call	SetGDCPlane_Wrt
		add	sp, 2
		mov	ax, 0FFFFh
		push	ax
		mov	ax, 0Bh
		push	ax
		mov	ax, 8
		push	ax
		mov	bx, [bp+var_6]
		shl	bx, 1
		push	word_1C1B0[bx]
		call	sub_14CC2
		add	sp, 8

loc_108F8:				; CODE XREF: sub_10819+94j
		jmp	short loc_1089C
; ---------------------------------------------------------------------------

loc_108FA:				; CODE XREF: sub_10819+8Aj
		jmp	short loc_10901
; ---------------------------------------------------------------------------

loc_108FC:				; CODE XREF: sub_10819+7Aj
		mov	[bp+var_4], 4

loc_10901:				; CODE XREF: sub_10819:loc_108FAj
					; sub_10819+EFj
		cmp	word_1AB44, 0
		jz	short loc_1090A
		jmp	short loc_10901
; ---------------------------------------------------------------------------

loc_1090A:				; CODE XREF: sub_10819+EDj
		mov	[bp+var_A], 0
		jmp	short loc_10914
; ---------------------------------------------------------------------------

loc_10911:				; CODE XREF: sub_10819:loc_10986j
		inc	[bp+var_A]

loc_10914:				; CODE XREF: sub_10819+F6j
		mov	ax, [bp+var_4]
		cmp	[bp+var_A], ax
		jg	short loc_10988
		mov	word_1AB44, 2
		mov	[bp+var_6], 0
		jmp	short loc_1092C
; ---------------------------------------------------------------------------

loc_10929:				; CODE XREF: sub_10819:loc_1097Bj
		inc	[bp+var_6]

loc_1092C:				; CODE XREF: sub_10819+10Ej
		cmp	[bp+var_6], 19h
		jge	short loc_1097D
		mov	bx, [bp+var_6]
		cmp	byte_1AC44[bx],	0Dh
		jnb	short loc_1097B
		mov	ax, 1
		push	ax
		call	SetGDCPlane_Wrt
		add	sp, 2
		mov	ax, 0Bh
		push	ax
		push	[bp+var_A]
		mov	bx, [bp+var_6]
		shl	bx, 1
		push	word_1C1B0[bx]
		call	sub_14D04
		add	sp, 6
		sub	ax, ax
		push	ax
		call	SetGDCPlane_Wrt
		add	sp, 2
		mov	ax, 0Bh
		push	ax
		push	[bp+var_A]
		mov	bx, [bp+var_6]
		shl	bx, 1
		push	word_1C1B0[bx]
		call	sub_14D04
		add	sp, 6

loc_1097B:				; CODE XREF: sub_10819+121j
		jmp	short loc_10929
; ---------------------------------------------------------------------------

loc_1097D:				; CODE XREF: sub_10819+117j
					; sub_10819+16Bj
		cmp	word_1AB44, 0
		jz	short loc_10986
		jmp	short loc_1097D
; ---------------------------------------------------------------------------

loc_10986:				; CODE XREF: sub_10819+169j
		jmp	short loc_10911
; ---------------------------------------------------------------------------

loc_10988:				; CODE XREF: sub_10819+101j
		mov	sp, bp
		pop	bp
		retn
sub_10819	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1098C	proc near		; CODE XREF: ExecuteScript+447p

var_6		= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2

		push	bp
		mov	bp, sp
		mov	ax, 6
		call	__chkstk
		push	si
		mov	[bp+var_6], 0
		jmp	short loc_109A0
; ---------------------------------------------------------------------------

loc_1099D:				; CODE XREF: sub_1098C+2Bj
		inc	[bp+var_6]

loc_109A0:				; CODE XREF: sub_1098C+Fj
		cmp	[bp+var_6], 0Dh
		jge	short loc_109B9
		mov	si, [bp+var_6]
		shl	si, 1
		mov	word_1CA74[si],	0
		mov	word_1BCC0[si],	0
		jmp	short loc_1099D
; ---------------------------------------------------------------------------

loc_109B9:				; CODE XREF: sub_1098C+18j
		mov	[bp+var_6], 0
		jmp	short loc_109C3
; ---------------------------------------------------------------------------

loc_109C0:				; CODE XREF: sub_1098C+74j
		inc	[bp+var_6]

loc_109C3:				; CODE XREF: sub_1098C+32j
		cmp	[bp+var_6], 19h
		jge	short loc_10A02
		mov	ax, [bp+var_6]
		cwd
		mov	cx, 5
		idiv	cx
		mov	[bp+var_2], dx
		mov	ax, [bp+var_6]
		cwd
		idiv	cx
		mov	[bp+var_4], ax
		mov	ax, 880
		imul	[bp+var_4]
		mov	cx, [bp+var_2]
		shl	cx, 1
		add	ax, cx
		add	ax, word_1ACA6
		mov	bx, [bp+var_6]
		shl	bx, 1
		mov	word_1C1B0[bx],	ax
		mov	bx, [bp+var_6]
		mov	byte_1AC44[bx],	99
		jmp	short loc_109C0
; ---------------------------------------------------------------------------

loc_10A02:				; CODE XREF: sub_1098C+3Bj
		pop	si
		mov	sp, bp
		pop	bp
		retn
sub_1098C	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_10A07	proc near		; CODE XREF: ExecuteScript:loc_12509p

var_2		= word ptr -2

		push	bp
		mov	bp, sp
		mov	ax, 2
		call	__chkstk
		push	si
		call	ScrData_GetByte
		dec	ax
		mov	[bp+var_2], ax
		call	ScrData_GetInt
		mov	bx, [bp+var_2]
		shl	bx, 1
		mov	word_1CA74[bx],	ax
		call	ScrData_GetInt
		mov	bx, [bp+var_2]
		shl	bx, 1
		mov	word_1BCC0[bx],	ax
		mov	bx, [bp+var_2]
		mov	al, byte_1AC5E[bx]
		sub	ah, ah
		mov	si, ax
		mov	al, byte ptr [bp+var_2]
		mov	byte_1AC44[si],	al
		mov	word_1ACA8, si
		pop	si
		mov	sp, bp
		pop	bp
		retn
sub_10A07	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_10A4B	proc near		; CODE XREF: ExecuteScript:loc_12517p

var_10		= word ptr -10h
var_E		= word ptr -0Eh
var_C		= word ptr -0Ch
var_A		= word ptr -0Ah
var_8		= word ptr -8
var_6		= byte ptr -6
var_4		= word ptr -4
var_2		= word ptr -2

		push	bp
		mov	bp, sp
		mov	ax, 14h
		call	__chkstk
		push	si
		mov	[bp+var_A], 0
		mov	[bp+var_2], 0FFFFh
		mov	bx, word_1AC94
		cmp	byte_1AC44[bx],	99
		jnz	short loc_10A8E
		mov	[bp+var_E], 0
		jmp	short loc_10A74
; ---------------------------------------------------------------------------

loc_10A71:				; CODE XREF: sub_10A4B:loc_10A86j
		inc	[bp+var_E]

loc_10A74:				; CODE XREF: sub_10A4B+24j
		cmp	[bp+var_E], 19h
		jge	short loc_10A88
		mov	bx, [bp+var_E]
		cmp	byte_1AC44[bx],	99
		jz	short loc_10A86
		jmp	short loc_10A88
; ---------------------------------------------------------------------------

loc_10A86:				; CODE XREF: sub_10A4B+37j
		jmp	short loc_10A71
; ---------------------------------------------------------------------------

loc_10A88:				; CODE XREF: sub_10A4B+2Dj
					; sub_10A4B+39j
		mov	ax, [bp+var_E]
		mov	word_1AC94, ax

loc_10A8E:				; CODE XREF: sub_10A4B+1Dj
		mov	ax, word_1AC94
		cwd
		mov	cx, 5
		idiv	cx
		mov	[bp+var_C], dx
		mov	ax, word_1AC94
		cwd
		idiv	cx
		mov	[bp+var_10], ax

loc_10AA3:				; CODE XREF: sub_10A4B+2C7j
		mov	ax, word_1AC94
		cmp	[bp+var_2], ax
		jz	short loc_10AF9
		mov	bx, ax
		mov	al, byte_1AC44[bx]
		sub	ah, ah
		mov	word_1C348, ax
		mov	word_1AB42, 1
		call	sub_14270
		call	sub_106F6
		mov	bx, word_1AC94
		mov	bl, byte_1AC44[bx]
		sub	bh, bh
		shl	bx, 1
		mov	ax, word_1BCC0[bx]
		mov	[bp+var_8], ax
		mov	ax, word_1AC94
		mov	[bp+var_2], ax
		cmp	[bp+var_8], 0
		jz	short loc_10AF9
		mov	ax, [bp+var_8]
		add	ax, word ptr scrDataBasePtr
		mov	dx, word ptr scrDataBasePtr+2
		mov	word ptr scrDataPtr, ax
		mov	word ptr scrDataPtr+2, dx
		call	ExecuteScript
		mov	[bp+var_4], ax

loc_10AF9:				; CODE XREF: sub_10A4B+5Ej
					; sub_10A4B+94j
		call	sub_17D1E
		mov	[bp+var_6], al
		sub	ah, ah
		jmp	loc_10CAD
; ---------------------------------------------------------------------------

loc_10B04:				; CODE XREF: sub_10A4B+28Bj
		cmp	[bp+var_C], 0
		jle	short loc_10B18
		mov	bx, word_1AC94

loc_10B0E:
		cmp	byte_1AC43[bx],	99

loc_10B13:
		jz	short loc_10B18
		dec	[bp+var_C]

loc_10B18:				; CODE XREF: sub_10A4B+BDj
					; sub_10A4B:loc_10B13j
		jmp	loc_10CFB
; ---------------------------------------------------------------------------

loc_10B1B:				; CODE XREF: sub_10A4B+293j
		cmp	[bp+var_C], 4

loc_10B1F:
		jge	short loc_10B2F
		mov	bx, word_1AC94
		cmp	byte_1AC45[bx],	99
		jz	short loc_10B2F
		inc	[bp+var_C]

loc_10B2F:				; CODE XREF: sub_10A4B:loc_10B1Fj
					; sub_10A4B+DFj
		jmp	loc_10CFB
; ---------------------------------------------------------------------------

loc_10B32:				; CODE XREF: sub_10A4B+2A3j
		cmp	[bp+var_10], 0
		jle	short loc_10B46
		mov	bx, word_1AC94
		cmp	byte_1AC3F[bx],	99
		jz	short loc_10B46
		dec	[bp+var_10]

loc_10B46:				; CODE XREF: sub_10A4B+EBj
					; sub_10A4B+F6j
		jmp	loc_10CFB
; ---------------------------------------------------------------------------

loc_10B49:				; CODE XREF: sub_10A4B+281j
		cmp	[bp+var_10], 4
		jge	short loc_10B5D
		mov	bx, word_1AC94
		cmp	byte_1AC49[bx],	99
		jz	short loc_10B5D
		inc	[bp+var_10]

loc_10B5D:				; CODE XREF: sub_10A4B+102j
					; sub_10A4B+10Dj
		jmp	loc_10CFB
; ---------------------------------------------------------------------------

loc_10B60:				; CODE XREF: sub_10A4B+29Bj
		cmp	[bp+var_C], 0
		jle	short loc_10B7F
		cmp	[bp+var_10], 0
		jle	short loc_10B7F
		mov	bx, word_1AC94
		cmp	byte_1AC3E[bx],	99
		jz	short loc_10B7F
		dec	[bp+var_C]
		dec	[bp+var_10]
		jmp	short loc_10B93
; ---------------------------------------------------------------------------

loc_10B7F:				; CODE XREF: sub_10A4B+119j
					; sub_10A4B+11Fj ...
		cmp	[bp+var_C], 0
		jle	short loc_10B93
		mov	bx, word_1AC94
		cmp	byte_1AC43[bx],	99
		jz	short loc_10B93
		dec	[bp+var_C]

loc_10B93:				; CODE XREF: sub_10A4B+132j
					; sub_10A4B+138j ...
		jmp	loc_10CFB
; ---------------------------------------------------------------------------

loc_10B96:				; CODE XREF: sub_10A4B+279j
		cmp	[bp+var_C], 0
		jle	short loc_10BB5
		cmp	[bp+var_10], 4
		jge	short loc_10BB5
		mov	bx, word_1AC94
		cmp	byte_1AC48[bx],	99
		jz	short loc_10BB5
		dec	[bp+var_C]
		inc	[bp+var_10]
		jmp	short loc_10BC9
; ---------------------------------------------------------------------------

loc_10BB5:				; CODE XREF: sub_10A4B+14Fj
					; sub_10A4B+155j ...
		cmp	[bp+var_C], 0
		jle	short loc_10BC9
		mov	bx, word_1AC94
		cmp	byte_1AC43[bx],	99
		jz	short loc_10BC9
		dec	[bp+var_C]

loc_10BC9:				; CODE XREF: sub_10A4B+168j
					; sub_10A4B+16Ej ...
		jmp	loc_10CFB
; ---------------------------------------------------------------------------

loc_10BCC:				; CODE XREF: sub_10A4B+2ABj
		cmp	[bp+var_C], 4
		jge	short loc_10BEB
		cmp	[bp+var_10], 0
		jle	short loc_10BEB
		mov	bx, word_1AC94
		cmp	byte_1AC40[bx],	99
		jz	short loc_10BEB
		inc	[bp+var_C]
		dec	[bp+var_10]
		jmp	short loc_10BFF
; ---------------------------------------------------------------------------

loc_10BEB:				; CODE XREF: sub_10A4B+185j
					; sub_10A4B+18Bj ...
		cmp	[bp+var_C], 4
		jge	short loc_10BFF
		mov	bx, word_1AC94
		cmp	byte_1AC45[bx],	99
		jz	short loc_10BFF
		inc	[bp+var_C]

loc_10BFF:				; CODE XREF: sub_10A4B+19Ej
					; sub_10A4B+1A4j ...
		jmp	loc_10CFB
; ---------------------------------------------------------------------------

loc_10C02:				; CODE XREF: sub_10A4B+267j
		cmp	[bp+var_C], 4
		jge	short loc_10C21
		cmp	[bp+var_10], 4
		jge	short loc_10C21
		mov	bx, word_1AC94
		cmp	byte_1AC4A[bx],	99
		jz	short loc_10C21
		inc	[bp+var_C]
		inc	[bp+var_10]
		jmp	short loc_10C35
; ---------------------------------------------------------------------------

loc_10C21:				; CODE XREF: sub_10A4B+1BBj
					; sub_10A4B+1C1j ...
		cmp	[bp+var_C], 4
		jge	short loc_10C35
		mov	bx, word_1AC94
		cmp	byte_1AC45[bx],	99
		jz	short loc_10C35
		inc	[bp+var_C]

loc_10C35:				; CODE XREF: sub_10A4B+1D4j
					; sub_10A4B+1DAj ...
		jmp	loc_10CFB
; ---------------------------------------------------------------------------

loc_10C38:				; CODE XREF: sub_10A4B+271j
		cmp	word_1ACAA, 0
		jnz	short loc_10C48
		mov	ax, word_1AC94
		cmp	word_1ACA8, ax
		jnz	short loc_10C4D

loc_10C48:				; CODE XREF: sub_10A4B+1F2j
		mov	ax, 1
		jmp	short loc_10C4F
; ---------------------------------------------------------------------------

loc_10C4D:				; CODE XREF: sub_10A4B+1FBj
		sub	ax, ax

loc_10C4F:				; CODE XREF: sub_10A4B+200j
		push	ax
		call	sub_10819
		add	sp, 2
		mov	ax, 1
		push	ax
		call	ScrollTextOutUp
		add	sp, 2
		mov	bx, word_1AC94
		mov	al, byte_1AC44[bx]
		sub	ah, ah
		mov	si, ax
		mov	bx, si
		shl	bx, 1
		mov	ax, word_1CA74[bx]
		add	ax, word ptr scrDataBasePtr
		mov	dx, word ptr scrDataBasePtr+2
		mov	word ptr scrDataPtr, ax
		mov	word ptr scrDataPtr+2, dx
		push	si
		sub	ax, ax
		push	ax
		call	sub_184FD
		add	sp, 4
		call	ExecuteScript
		mov	[bp+var_4], ax
		cmp	ax, 1Ch
		jz	short loc_10C9F
		cmp	word_1B0E0, 0
		jz	short loc_10CA4

loc_10C9F:				; CODE XREF: sub_10A4B+24Bj
		mov	[bp+var_A], 1

loc_10CA4:				; CODE XREF: sub_10A4B+252j
		mov	[bp+var_2], 0FFFFh
		jmp	short loc_10CFB
; ---------------------------------------------------------------------------
		jmp	short loc_10CFB
; ---------------------------------------------------------------------------

loc_10CAD:				; CODE XREF: sub_10A4B+B6j
		cmp	ax, 33h	; '3'
		jnz	short loc_10CB5
		jmp	loc_10C02
; ---------------------------------------------------------------------------

loc_10CB5:				; CODE XREF: sub_10A4B+265j
		ja	short loc_10CD1
		cmp	ax, 0Dh
		jnz	short loc_10CBF
		jmp	loc_10C38
; ---------------------------------------------------------------------------

loc_10CBF:				; CODE XREF: sub_10A4B+26Fj
		cmp	ax, 31h	; '1'
		jnz	short loc_10CC7
		jmp	loc_10B96
; ---------------------------------------------------------------------------

loc_10CC7:				; CODE XREF: sub_10A4B+277j
		cmp	ax, 32h	; '2'
		jnz	short loc_10CCF
		jmp	loc_10B49
; ---------------------------------------------------------------------------

loc_10CCF:				; CODE XREF: sub_10A4B+27Fj
		jmp	short loc_10CFB
; ---------------------------------------------------------------------------

loc_10CD1:				; CODE XREF: sub_10A4B:loc_10CB5j
		cmp	ax, 34h	; '4'
		jnz	short loc_10CD9
		jmp	loc_10B04
; ---------------------------------------------------------------------------

loc_10CD9:				; CODE XREF: sub_10A4B+289j
		cmp	ax, 36h	; '6'
		jnz	short loc_10CE1
		jmp	loc_10B1B
; ---------------------------------------------------------------------------

loc_10CE1:				; CODE XREF: sub_10A4B+291j
		cmp	ax, 37h	; '7'
		jnz	short loc_10CE9
		jmp	loc_10B60
; ---------------------------------------------------------------------------

loc_10CE9:				; CODE XREF: sub_10A4B+299j
		cmp	ax, 38h	; '8'
		jnz	short loc_10CF1
		jmp	loc_10B32
; ---------------------------------------------------------------------------

loc_10CF1:				; CODE XREF: sub_10A4B+2A1j
		cmp	ax, 39h	; '9'
		jnz	short loc_10CF9
		jmp	loc_10BCC
; ---------------------------------------------------------------------------

loc_10CF9:				; CODE XREF: sub_10A4B+2A9j
		jmp	short $+2

loc_10CFB:				; CODE XREF: sub_10A4B:loc_10B18j
					; sub_10A4B:loc_10B2Fj	...
		mov	ax, [bp+var_10]
		mov	cx, ax
		shl	ax, 1
		shl	ax, 1
		add	ax, cx
		add	ax, [bp+var_C]
		mov	word_1AC94, ax
		cmp	[bp+var_A], 0
		jnz	short loc_10D15
		jmp	loc_10AA3
; ---------------------------------------------------------------------------

loc_10D15:				; CODE XREF: sub_10A4B+2C5j
		pop	si
		mov	sp, bp
		pop	bp
		retn
sub_10A4B	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_10D1A	proc near		; CODE XREF: ExecuteScript:loc_1283Bp

var_4		= word ptr -4
var_2		= word ptr -2

		push	bp
		mov	bp, sp
		mov	ax, 4
		call	__chkstk
		push	si
		mov	[bp+var_2], 0
		jmp	short loc_10D2E
; ---------------------------------------------------------------------------

loc_10D2B:				; CODE XREF: sub_10D1A:loc_10D65j
		inc	[bp+var_2]

loc_10D2E:				; CODE XREF: sub_10D1A+Fj
		cmp	[bp+var_2], 3
		jge	short loc_10D67
		mov	bx, [bp+var_2]
		shl	bx, 1
		mov	word_1BF8E[bx],	0
		mov	[bp+var_4], 0
		jmp	short loc_10D49
; ---------------------------------------------------------------------------

loc_10D46:				; CODE XREF: sub_10D1A+49j
		inc	[bp+var_4]

loc_10D49:				; CODE XREF: sub_10D1A+2Aj
		cmp	[bp+var_4], 4
		jge	short loc_10D65
		mov	si, [bp+var_2]
		mov	cl, 5
		shl	si, cl
		mov	bx, [bp+var_4]
		mov	cl, 3
		shl	bx, cl
		mov	word_1CA14[bx+si], 0FFFFh
		jmp	short loc_10D46
; ---------------------------------------------------------------------------

loc_10D65:				; CODE XREF: sub_10D1A+33j
		jmp	short loc_10D2B
; ---------------------------------------------------------------------------

loc_10D67:				; CODE XREF: sub_10D1A+18j
		pop	si
		mov	sp, bp
		pop	bp
		retn
sub_10D1A	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_10D6C	proc near		; CODE XREF: ExecuteScript+79Bp

var_1A		= word ptr -1Ah
var_16		= word ptr -16h
var_E		= word ptr -0Eh
var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		mov	ax, 1Ah
		call	__chkstk
		push	di
		push	si
		mov	[bp+var_2], 18h
		mov	[bp+var_4], 26h	; '&'
		mov	[bp+var_16], 0
		mov	[bp+var_1A], 0
		cmp	[bp+arg_0], 2
		jnz	short loc_10D9B
		mov	[bp+var_2], 21h	; '!'
		mov	[bp+var_4], 2Fh	; '/'

loc_10D9B:				; CODE XREF: sub_10D6C+23j
		call	ScrData_GetInt
		sub	ax, [bp+var_16]
		mov	[bp+var_E], ax
		mov	ax, 384
		cwd
		push	dx
		push	ax
		mov	ax, 432
		cwd
		push	dx
		push	ax
		mov	ax, [bp+var_E]
		cwd
		push	dx
		push	ax
		call	__aNlmul
		push	dx
		push	ax
		call	__aNldiv
		mov	[bp+var_E], ax
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	di, word_1BF8E[bx]
		mov	cl, 3
		shl	di, cl
		mov	bx, [bp+arg_0]
		mov	cl, 5
		shl	bx, cl
		add	ax, [bp+var_2]
		mov	word_1CA14[bx+di], ax
		call	ScrData_GetInt
		sub	ax, [bp+var_1A]
		mov	[bp+var_E], ax
		mov	ax, 256
		cwd
		push	dx
		push	ax
		mov	ax, 200
		cwd
		push	dx
		push	ax
		mov	ax, [bp+var_E]
		cwd
		push	dx
		push	ax
		call	__aNlmul
		push	dx
		push	ax
		call	__aNldiv
		mov	[bp+var_E], ax
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	di, word_1BF8E[bx]
		mov	cl, 3
		shl	di, cl
		mov	bx, [bp+arg_0]
		mov	cl, 5
		shl	bx, cl
		add	ax, [bp+var_4]
		mov	word_1CA16[bx+di], ax
		call	ScrData_GetInt
		sub	ax, [bp+var_16]
		mov	[bp+var_E], ax
		mov	ax, 384
		cwd
		push	dx
		push	ax
		mov	ax, 432
		cwd
		push	dx
		push	ax
		mov	ax, [bp+var_E]
		cwd
		push	dx
		push	ax
		call	__aNlmul
		push	dx
		push	ax
		call	__aNldiv
		mov	[bp+var_E], ax
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	si, word_1BF8E[bx]
		mov	cl, 3
		shl	si, cl
		mov	ax, [bp+arg_0]
		mov	cl, 5
		shl	ax, cl
		add	si, ax
		mov	ax, [bp+var_E]
		add	ax, [bp+var_2]
		mov	word_1CA18[si],	ax
		cmp	[bp+arg_0], 0
		jnz	short loc_10E72
		call	ScrData_GetInt
		mov	word_1CA1A[si],	ax
		jmp	short loc_10EB3
; ---------------------------------------------------------------------------

loc_10E72:				; CODE XREF: sub_10D6C+FBj
		call	ScrData_GetInt
		sub	ax, [bp+var_1A]
		mov	[bp+var_E], ax
		mov	ax, 256
		cwd
		push	dx
		push	ax
		mov	ax, 200
		cwd
		push	dx
		push	ax
		mov	ax, [bp+var_E]
		cwd
		push	dx
		push	ax
		call	__aNlmul
		push	dx
		push	ax
		call	__aNldiv
		mov	[bp+var_E], ax
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	si, word_1BF8E[bx]
		mov	cl, 3
		shl	si, cl
		mov	bx, [bp+arg_0]
		mov	cl, 5
		shl	bx, cl
		add	ax, [bp+var_4]
		mov	word_1CA1A[bx+si], ax

loc_10EB3:				; CODE XREF: sub_10D6C+104j
		cmp	debugMode, 0
		jz	short loc_10EEA
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	si, word_1BF8E[bx]
		mov	cl, 3
		shl	si, cl
		mov	ax, [bp+arg_0]
		mov	cl, 5
		shl	ax, cl
		add	si, ax
		push	word_1CA1A[si]
		push	word_1CA18[si]
		push	word_1CA16[si]
		push	word_1CA14[si]
		mov	ax, offset a3d3d3d3d ; "\n(%3d,%3d)-(%3d,%3d)\n"
		push	ax		; char *
		call	_printf
		add	sp, 0Ah

loc_10EEA:				; CODE XREF: sub_10D6C+14Cj
		mov	bx, [bp+arg_0]
		shl	bx, 1
		inc	word_1BF8E[bx]
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retn
sub_10D6C	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_10EF9	proc near		; CODE XREF: sub_10F59+67p
					; sub_10F59+92p

arg_0		= word ptr  4
arg_2		= word ptr  6
arg_8		= word ptr  0Ch

		push	bp
		mov	bp, sp
		xor	ax, ax
		call	__chkstk
		cmp	[bp+arg_8], 0
		jz	short loc_10F55
		mov	ax, 2
		push	ax
		mov	ax, 10h
		push	ax
		mov	ax, 8
		push	ax
		call	SetTextOpts
		add	sp, 6
		mov	ax, 0C0h ; 'À'
		push	ax
		call	MaybeSetTxtFlags
		add	sp, 2
		push	[bp+arg_2]
		push	[bp+arg_0]
		call	SetTextDrawPos
		add	sp, 4
		mov	ax, offset byte_1ACC2
		push	ax
		call	j_DrawString
		add	sp, 2
		mov	ax, 2
		push	ax
		mov	ax, 10h
		push	ax
		mov	ax, 8
		push	ax
		call	SetTextOpts
		add	sp, 6
		mov	ax, 0C7h ; 'Ç'
		push	ax
		call	MaybeSetTxtFlags
		add	sp, 2

loc_10F55:				; CODE XREF: sub_10EF9+Cj
		mov	sp, bp
		pop	bp
		retn
sub_10EF9	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_10F59	proc near		; CODE XREF: sub_110EF+79p

var_2		= word ptr -2
arg_0		= word ptr  4
arg_2		= word ptr  6
arg_4		= word ptr  8

		push	bp
		mov	bp, sp
		mov	ax, 2
		call	__chkstk
		push	si
		mov	[bp+var_2], offset asc_1B4B4 ; "3\r\n- integer divide by 0\r\n"
		mov	ax, 1
		push	ax
		call	SetGDCPlane_Wrt
		add	sp, 2
		mov	ax, 4
		push	ax
		mov	ax, 54
		push	ax
		mov	ax, offset byte_1D080
		push	ax
		push	[bp+var_2]
		mov	ax, 200
		push	ax
		mov	ax, 54
		push	ax
		push	word ptr dword_1BCDC+2
		push	word ptr dword_1BCDC
		call	sub_14F8F
		add	sp, 10h
		mov	ax, [bp+arg_0]
		jmp	loc_11020
; ---------------------------------------------------------------------------

loc_10F9D:				; CODE XREF: sub_10F59+CBj
		mov	si, [bp+arg_0]
		mov	cl, 5
		shl	si, cl
		mov	ax, [bp+arg_2]
		mov	cl, 3
		shl	ax, cl
		add	si, ax
		push	[bp+arg_4]
		push	word_1CA1A[si]
		push	word_1CA18[si]
		push	word_1CA16[si]
		push	word_1CA14[si]
		call	sub_10EF9
		add	sp, 0Ah
		jmp	short loc_11033
; ---------------------------------------------------------------------------

loc_10FC8:				; CODE XREF: sub_10F59+D1j
		mov	si, [bp+arg_0]
		mov	cl, 5
		shl	si, cl
		mov	ax, [bp+arg_2]
		mov	cl, 3
		shl	ax, cl
		add	si, ax
		push	[bp+arg_4]
		push	word_1CA1A[si]
		push	word_1CA18[si]
		push	word_1CA16[si]
		push	word_1CA14[si]
		call	sub_10EF9
		add	sp, 0Ah
		jmp	short loc_11033
; ---------------------------------------------------------------------------

loc_10FF3:				; CODE XREF: sub_10F59+D6j
		mov	si, [bp+arg_0]
		mov	cl, 5
		shl	si, cl
		mov	ax, [bp+arg_2]
		mov	cl, 3
		shl	ax, cl
		add	si, ax
		push	[bp+arg_4]
		push	word_1CA1A[si]
		push	word_1CA18[si]
		push	word_1CA16[si]
		push	word_1CA14[si]
		call	sub_1103B
		add	sp, 0Ah
		jmp	short loc_11033
; ---------------------------------------------------------------------------
		jmp	short loc_11033
; ---------------------------------------------------------------------------

loc_11020:				; CODE XREF: sub_10F59+41j
		or	ax, ax
		jnz	short loc_11027
		jmp	loc_10F9D
; ---------------------------------------------------------------------------

loc_11027:				; CODE XREF: sub_10F59+C9j
		cmp	ax, 1
		jz	short loc_10FC8
		cmp	ax, 2
		jz	short loc_10FF3
		jmp	short $+2

loc_11033:				; CODE XREF: sub_10F59+6Dj
					; sub_10F59+98j ...
		call	SwapGDCPlanes
		pop	si
		mov	sp, bp
		pop	bp
		retn
sub_10F59	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1103B	proc near		; CODE XREF: sub_10F59+BDp

var_A		= word ptr -0Ah
var_8		= word ptr -8
var_6		= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  4
arg_2		= word ptr  6
arg_4		= word ptr  8
arg_6		= word ptr  0Ah
arg_8		= word ptr  0Ch

		push	bp
		mov	bp, sp
		mov	ax, 0Ah
		call	__chkstk
		cmp	[bp+arg_8], 0
		jz	short loc_11051
		mov	[bp+var_2], 0Fh
		jmp	short loc_11056
; ---------------------------------------------------------------------------

loc_11051:				; CODE XREF: sub_1103B+Dj
		mov	[bp+var_2], 0

loc_11056:				; CODE XREF: sub_1103B+14j
		mov	ax, [bp+arg_4]
		sub	ax, [bp+arg_0]
		mov	[bp+var_4], ax
		mov	ax, [bp+arg_6]
		sub	ax, [bp+arg_2]
		mov	[bp+var_6], ax
		cmp	[bp+var_4], ax
		jle	short loc_110AD
		mov	[bp+var_8], 0
		jmp	short loc_11077
; ---------------------------------------------------------------------------

loc_11074:				; CODE XREF: sub_1103B+6Ej
		inc	[bp+var_8]

loc_11077:				; CODE XREF: sub_1103B+37j
		mov	ax, [bp+var_4]
		cmp	[bp+var_8], ax
		jge	short loc_110AB
		mov	ax, [bp+var_8]
		imul	[bp+var_6]
		cwd
		mov	cx, [bp+var_4]
		idiv	cx
		mov	[bp+var_A], ax
		mov	ax, 7
		push	ax
		push	[bp+var_2]
		mov	ax, [bp+var_A]
		add	ax, [bp+arg_2]
		push	ax
		mov	ax, [bp+var_8]
		add	ax, [bp+arg_0]
		push	ax
		call	sub_151CD
		add	sp, 8
		jmp	short loc_11074
; ---------------------------------------------------------------------------

loc_110AB:				; CODE XREF: sub_1103B+42j
		jmp	short loc_110EB
; ---------------------------------------------------------------------------

loc_110AD:				; CODE XREF: sub_1103B+30j
		mov	[bp+var_A], 0
		jmp	short loc_110B7
; ---------------------------------------------------------------------------

loc_110B4:				; CODE XREF: sub_1103B+AEj
		inc	[bp+var_A]

loc_110B7:				; CODE XREF: sub_1103B+77j
		mov	ax, [bp+var_6]
		cmp	[bp+var_A], ax
		jge	short loc_110EB
		mov	ax, [bp+var_A]
		imul	[bp+var_4]
		cwd
		mov	cx, [bp+var_6]
		idiv	cx
		mov	[bp+var_8], ax
		mov	ax, 7
		push	ax
		push	[bp+var_2]
		mov	ax, [bp+var_A]
		add	ax, [bp+arg_2]
		push	ax
		mov	ax, [bp+var_8]
		add	ax, [bp+arg_0]
		push	ax
		call	sub_151CD
		add	sp, 8
		jmp	short loc_110B4
; ---------------------------------------------------------------------------

loc_110EB:				; CODE XREF: sub_1103B:loc_110ABj
					; sub_1103B+82j
		mov	sp, bp
		pop	bp
		retn
sub_1103B	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_110EF	proc near		; CODE XREF: ExecuteScript+7B4p

var_12		= word ptr -12h
var_A		= word ptr -0Ah
var_8		= word ptr -8
var_6		= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		mov	ax, 12h
		call	__chkstk
		push	si
		mov	[bp+var_A], 0
		mov	[bp+var_4], 0
		jmp	short loc_11108
; ---------------------------------------------------------------------------

loc_11105:				; CODE XREF: sub_110EF:loc_11135j
		inc	[bp+var_4]

loc_11108:				; CODE XREF: sub_110EF+14j
		mov	bx, [bp+arg_0]
		shl	bx, 1
		mov	ax, [bp+var_4]
		cmp	word_1BF8E[bx],	ax
		jle	short loc_11137
		mov	si, [bp+arg_0]
		mov	cl, 5
		shl	si, cl
		mov	bx, ax
		mov	cl, 3
		shl	bx, cl
		cmp	word_1CA14[bx+si], 0FFFFh
		jz	short loc_11135
		mov	si, [bp+var_A]
		shl	si, 1
		mov	[bp+si+var_12],	ax
		inc	[bp+var_A]

loc_11135:				; CODE XREF: sub_110EF+39j
		jmp	short loc_11105
; ---------------------------------------------------------------------------

loc_11137:				; CODE XREF: sub_110EF+25j
		cmp	[bp+var_A], 0
		jnz	short loc_11142
		sub	ax, ax
		jmp	loc_111CA
; ---------------------------------------------------------------------------

loc_11142:				; CODE XREF: sub_110EF+4Cj
		mov	[bp+var_2], 0
		mov	[bp+var_8], 0
		mov	[bp+var_6], 0FFFFh

loc_11151:				; CODE XREF: sub_110EF+CEj
		mov	ax, [bp+var_6]
		cmp	[bp+var_8], ax
		jz	short loc_11174
		mov	ax, 1
		push	ax
		mov	si, [bp+var_8]
		shl	si, 1
		push	[bp+si+var_12]
		push	[bp+arg_0]
		call	sub_10F59
		add	sp, 6
		mov	ax, [bp+var_8]
		mov	[bp+var_6], ax

loc_11174:				; CODE XREF: sub_110EF+68j
		call	sub_17D1E
		mov	[bp+var_2], ax
		cmp	[bp+var_A], 1
		jz	short loc_111B9
		jmp	short loc_111AD
; ---------------------------------------------------------------------------

loc_11182:				; CODE XREF: sub_110EF+C1j
		cmp	[bp+var_8], 0
		jnz	short loc_11191
		mov	ax, [bp+var_A]
		dec	ax
		mov	[bp+var_8], ax
		jmp	short loc_11194
; ---------------------------------------------------------------------------

loc_11191:				; CODE XREF: sub_110EF+97j
		dec	[bp+var_8]

loc_11194:				; CODE XREF: sub_110EF+A0j
		jmp	short loc_111B9
; ---------------------------------------------------------------------------

loc_11196:				; CODE XREF: sub_110EF+C6j
		mov	ax, [bp+var_A]
		dec	ax
		cmp	ax, [bp+var_8]
		jnz	short loc_111A6
		mov	[bp+var_8], 0
		jmp	short loc_111A9
; ---------------------------------------------------------------------------

loc_111A6:				; CODE XREF: sub_110EF+AEj
		inc	[bp+var_8]

loc_111A9:				; CODE XREF: sub_110EF+B5j
		jmp	short loc_111B9
; ---------------------------------------------------------------------------
		jmp	short loc_111B9
; ---------------------------------------------------------------------------

loc_111AD:				; CODE XREF: sub_110EF+91j
		cmp	ax, 34h	; '4'
		jz	short loc_11182
		cmp	ax, 36h	; '6'
		jz	short loc_11196
		jmp	short $+2

loc_111B9:				; CODE XREF: sub_110EF+8Fj
					; sub_110EF:loc_11194j	...
		cmp	[bp+var_2], 0Dh
		jnz	short loc_11151
		mov	si, [bp+var_8]
		shl	si, 1
		mov	ax, [bp+si+var_12]
		inc	ax
		jmp	short $+2

loc_111CA:				; CODE XREF: sub_110EF+50j
		pop	si
		mov	sp, bp
		pop	bp
		retn
sub_110EF	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_111CF	proc near		; CODE XREF: ExecuteScript+7DCp

var_6		= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		mov	ax, 6
		call	__chkstk
		push	si
		call	ScrData_GetByte
		mov	[bp+var_6], ax
		mov	si, [bp+arg_0]
		mov	cl, 5
		shl	si, cl
		mov	cl, 3
		shl	ax, cl
		add	si, ax
		mov	word_1CA14[si],	0FFFFh
		mov	ax, word_1CA1A[si]
		mov	[bp+var_4], ax
		cmp	[bp+arg_0], 0
		jz	short loc_11201
		jmp	short loc_11241
; ---------------------------------------------------------------------------

loc_11201:				; CODE XREF: sub_111CF+2Ej
		push	[bp+var_4]
		call	sub_11DF6
		add	sp, 2
		mov	[bp+var_2], 1
		jmp	short loc_11214
; ---------------------------------------------------------------------------

loc_11211:				; CODE XREF: sub_111CF+63j
		inc	[bp+var_2]

loc_11214:				; CODE XREF: sub_111CF+40j
		cmp	[bp+var_2], 10h
		jge	short loc_11234
		mov	ax, [bp+var_2]
		cwd
		mov	cx, 4
		idiv	cx
		mov	[bp+var_6], dx
		mov	ax, dx
		add	ax, [bp+var_4]
		push	ax
		call	sub_11F4B
		add	sp, 2
		jmp	short loc_11211
; ---------------------------------------------------------------------------

loc_11234:				; CODE XREF: sub_111CF+49j
		mov	ax, [bp+var_4]
		add	ax, 4
		push	ax
		call	sub_11DF6
		add	sp, 2

loc_11241:				; CODE XREF: sub_111CF+30j
		pop	si
		mov	sp, bp
		pop	bp
		retn
sub_111CF	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_11246	proc near		; CODE XREF: ExecuteScript:scr07_ChoiceStartp
		push	bp
		mov	bp, sp
		xor	ax, ax
		call	__chkstk
		mov	curSelectID, 0
		mov	sp, bp
		pop	bp
		retn
sub_11246	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_11258	proc near		; CODE XREF: ExecuteScript:scr04_Choice_1Strp
		push	bp
		mov	bp, sp
		xor	ax, ax
		call	__chkstk
		mov	bx, curSelectID
		shl	bx, 1
		shl	bx, 1
		mov	ax, word ptr scrDataPtr
		mov	dx, word ptr scrDataPtr+2
		mov	word ptr choiceTextPtrs[bx], ax
		mov	word ptr (choiceTextPtrs+2)[bx], dx
		mov	ax, offset StringBuffer
		push	ax
		call	ScrData_Str2Buf
		add	sp, 2
		call	ScrData_GetInt
		mov	bx, curSelectID
		shl	bx, 1
		mov	choiceJumpDest[bx], ax
		inc	curSelectID
		mov	sp, bp
		pop	bp
		retn
sub_11258	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_11296	proc near		; CODE XREF: ExecuteScript:scr05_ChoiceExecp

var_8		= word ptr -8
var_6		= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2

		push	bp
		mov	bp, sp
		mov	ax, 8
		call	__chkstk
		push	si
		mov	[bp+var_8], 0
		mov	ax, 2
		push	ax
		mov	ax, 10h
		push	ax
		mov	ax, 8
		push	ax
		call	SetTextOpts
		add	sp, 6
		mov	ax, 1
		push	ax
		call	SetGDCPlane_Wrt
		add	sp, 2
		mov	ax, 1
		push	ax
		call	sub_17857
		add	sp, 2
		mov	[bp+var_4], 0
		jmp	short loc_112D5
; ---------------------------------------------------------------------------

loc_112D2:				; CODE XREF: sub_11296+8Ej
		inc	[bp+var_4]

loc_112D5:				; CODE XREF: sub_11296+3Aj
		mov	ax, curSelectID
		cmp	[bp+var_4], ax
		jge	short loc_11326
		mov	bx, [bp+var_4]
		shl	bx, 1
		shl	bx, 1
		mov	ax, word ptr choiceTextPtrs[bx]
		mov	dx, word ptr (choiceTextPtrs+2)[bx]
		mov	word ptr scrDataPtr, ax
		mov	word ptr scrDataPtr+2, dx
		mov	ax, offset StringBuffer
		push	ax
		call	ScrData_Str2Buf
		add	sp, 2
		mov	si, [bp+var_4]
		shl	si, 1
		mov	ax, 1
		push	ax
		mov	ax, offset StringBuffer
		push	ax
		mov	bx, curSelectID
		mov	ax, bx
		shl	bx, 1
		add	bx, ax
		shl	bx, 1
		push	word ptr (byte_1ACC2+10h)[bx+si]
		call	DrawTextS_Pos
		add	sp, 6
		mov	word_1BF82[si],	ax
		jmp	short loc_112D2
; ---------------------------------------------------------------------------

loc_11326:				; CODE XREF: sub_11296+45j
		mov	ax, 1
		push	ax
		call	TBoxBuf_Scr2Buf
		add	sp, 2
		sub	ax, ax
		push	ax
		call	SetGDCPlane_Wrt
		add	sp, 2
		mov	TextBoxes.field_10+12h,	12h
		mov	[bp+var_6], 0FFFFh
		mov	[bp+var_2], 0

loc_11349:				; CODE XREF: sub_11296+144j
		mov	ax, [bp+var_6]
		cmp	[bp+var_8], ax
		jz	short loc_113A5
		cmp	ax, 0FFFFh
		jz	short loc_1137B
		mov	si, ax
		shl	si, 1
		mov	ax, 1
		push	ax
		sub	ax, ax
		push	ax
		push	word_1BF82[si]
		mov	bx, curSelectID
		mov	ax, bx
		shl	bx, 1
		add	bx, ax
		shl	bx, 1
		push	word ptr (byte_1ACC2+10h)[bx+si]
		call	DrawTBoxBorder
		add	sp, 8

loc_1137B:				; CODE XREF: sub_11296+BEj
		mov	si, [bp+var_8]
		shl	si, 1
		mov	ax, 1
		push	ax
		push	ax
		push	word_1BF82[si]
		mov	bx, curSelectID
		mov	ax, bx
		shl	bx, 1
		add	bx, ax
		shl	bx, 1
		push	word ptr (byte_1ACC2+10h)[bx+si]
		call	DrawTBoxBorder
		add	sp, 8
		mov	ax, [bp+var_8]
		mov	[bp+var_6], ax

loc_113A5:				; CODE XREF: sub_11296+B9j
		call	sub_17D1E
		mov	[bp+var_2], ax
		jmp	short loc_113C8
; ---------------------------------------------------------------------------

loc_113AD:				; CODE XREF: sub_11296+13Aj
		cmp	[bp+var_8], 0
		jle	short loc_113B6
		dec	[bp+var_8]

loc_113B6:				; CODE XREF: sub_11296+11Bj
		jmp	short loc_113D4
; ---------------------------------------------------------------------------

loc_113B8:				; CODE XREF: sub_11296+135j
		mov	ax, curSelectID
		dec	ax
		cmp	[bp+var_8], ax
		jge	short loc_113C4
		inc	[bp+var_8]

loc_113C4:				; CODE XREF: sub_11296+129j
		jmp	short loc_113D4
; ---------------------------------------------------------------------------
		jmp	short loc_113D4
; ---------------------------------------------------------------------------

loc_113C8:				; CODE XREF: sub_11296+115j
		cmp	ax, '2'         ; key '2' - cursor up
		jz	short loc_113B8
		cmp	ax, '8'         ; key '8' - cursor down
		jz	short loc_113AD
		jmp	short $+2

loc_113D4:				; CODE XREF: sub_11296:loc_113B6j
					; sub_11296:loc_113C4j	...
		cmp	[bp+var_2], 0Dh	; Return key - confirm selection
		jz	short loc_113DD
		jmp	loc_11349
; ---------------------------------------------------------------------------

loc_113DD:				; CODE XREF: sub_11296+142j
		mov	[bp+var_4], 0
		jmp	short loc_113E7
; ---------------------------------------------------------------------------

loc_113E4:				; CODE XREF: sub_11296+17Fj
		inc	[bp+var_4]

loc_113E7:				; CODE XREF: sub_11296+14Cj
		mov	ax, curSelectID
		cmp	[bp+var_4], ax
		jge	short loc_11417
		mov	si, [bp+var_4]
		shl	si, 1
		mov	ax, 1
		push	ax
		sub	ax, ax
		push	ax
		push	word_1BF82[si]
		mov	bx, curSelectID
		mov	ax, bx
		shl	bx, 1
		add	bx, ax
		shl	bx, 1
		push	word ptr (byte_1ACC2+10h)[bx+si]
		call	DrawTBoxBorder
		add	sp, 8
		jmp	short loc_113E4
; ---------------------------------------------------------------------------

loc_11417:				; CODE XREF: sub_11296+157j
		mov	ax, 1
		push	ax
		call	ScrollTextOutUp
		add	sp, 2
		mov	bx, [bp+var_8]
		shl	bx, 1
		mov	ax, choiceJumpDest[bx]
		add	ax, word ptr scrDataBasePtr
		mov	dx, word ptr scrDataBasePtr+2
		mov	word ptr scrDataPtr, ax
		mov	word ptr scrDataPtr+2, dx
		pop	si
		mov	sp, bp
		pop	bp
		retn
sub_11296	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

ShowLocationName proc near		; CODE XREF: ExecuteScript+731p
					; ExecuteScript+744p ...

arg_0		= word ptr  4
arg_2		= word ptr  6

		push	bp
		mov	bp, sp
		mov	ax, 2
		call	__chkstk
		mov	ax, 1
		push	ax
		call	SetGDCPlane_Wrt
		add	sp, 2
		push	[bp+arg_0]
		call	sub_17857
		add	sp, 2
		mov	ax, offset StringBuffer
		push	ax
		call	ScrData_Str2Buf
		add	sp, 2
		push	[bp+arg_0]
		mov	ax, offset StringBuffer
		push	ax
		push	[bp+arg_2]
		call	DrawTextS_Pos	; draw location	name
		add	sp, 6
		push	[bp+arg_0]
		call	TBoxBuf_Scr2Buf
		add	sp, 2
		push	[bp+arg_0]
		call	sub_17857
		add	sp, 2
		mov	ax, 12h
		imul	[bp+arg_0]
		mov	bx, ax
		mov	TextBoxes.field_10[bx],	12h
		mov	sp, bp
		pop	bp
		retn
ShowLocationName endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_11498	proc near		; CODE XREF: ExecuteScript:scr06_Choice_MultiStrp

var_8		= word ptr -8
var_6		= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2

		push	bp
		mov	bp, sp
		mov	ax, 8
		call	__chkstk
		mov	[bp+var_8], 0
		mov	ax, 1
		push	ax
		call	SetGDCPlane_Wrt
		add	sp, 2
		mov	ax, 3
		push	ax
		call	sub_17857
		add	sp, 2
		mov	[bp+var_4], 0
		jmp	short loc_114C4
; ---------------------------------------------------------------------------

loc_114C1:				; CODE XREF: sub_11498+6Ej
		inc	[bp+var_4]

loc_114C4:				; CODE XREF: sub_11498+27j
		mov	ax, curSelectID
		cmp	[bp+var_4], ax
		jge	short loc_11508
		mov	bx, [bp+var_4]
		shl	bx, 1
		shl	bx, 1
		mov	ax, word ptr choiceTextPtrs[bx]
		mov	dx, word ptr (choiceTextPtrs+2)[bx]
		mov	word ptr scrDataPtr, ax
		mov	word ptr scrDataPtr+2, dx
		mov	ax, offset StringBuffer
		push	ax
		call	ScrData_Str2Buf
		add	sp, 2
		mov	ax, 3
		push	ax
		mov	ax, offset StringBuffer
		push	ax
		push	[bp+var_4]
		call	DrawTextS_Pos
		add	sp, 6
		mov	bx, [bp+var_4]
		shl	bx, 1
		mov	word_1BF82[bx],	ax
		jmp	short loc_114C1
; ---------------------------------------------------------------------------

loc_11508:				; CODE XREF: sub_11498+32j
		mov	ax, 3
		push	ax
		call	TBoxBuf_Scr2Buf
		add	sp, 2
		mov	ax, 3
		push	ax
		call	sub_17857
		add	sp, 2
		mov	TextBoxes.field_10+36h,	12h
		mov	[bp+var_6], 0FFFFh
		mov	[bp+var_2], 0

loc_1152C:				; CODE XREF: sub_11498+11Aj
		mov	ax, [bp+var_6]
		cmp	[bp+var_8], ax
		jz	short loc_1157D
		cmp	ax, 0FFFFh
		jz	short loc_11552
		mov	ax, 3
		push	ax
		sub	ax, ax
		push	ax
		mov	bx, [bp+var_6]
		shl	bx, 1
		push	word_1BF82[bx]
		push	[bp+var_6]
		call	DrawTBoxBorder
		add	sp, 8

loc_11552:				; CODE XREF: sub_11498+9Fj
		mov	ax, 3
		push	ax
		mov	ax, 1
		push	ax
		mov	bx, [bp+var_8]
		shl	bx, 1
		push	word_1BF82[bx]
		push	[bp+var_8]
		call	DrawTBoxBorder
		add	sp, 8
		mov	ax, [bp+var_8]
		inc	ax
		push	ax
		call	sub_11C4E
		add	sp, 2
		mov	ax, [bp+var_8]
		mov	[bp+var_6], ax

loc_1157D:				; CODE XREF: sub_11498+9Aj
		call	sub_17D1E
		mov	[bp+var_2], ax
		jmp	short loc_115A0
; ---------------------------------------------------------------------------

loc_11585:				; CODE XREF: sub_11498+110j
		cmp	[bp+var_8], 0
		jle	short loc_1158E
		dec	[bp+var_8]

loc_1158E:				; CODE XREF: sub_11498+F1j
		jmp	short loc_115AC
; ---------------------------------------------------------------------------

loc_11590:				; CODE XREF: sub_11498+10Bj
		mov	ax, curSelectID
		dec	ax
		cmp	[bp+var_8], ax
		jge	short loc_1159C
		inc	[bp+var_8]

loc_1159C:				; CODE XREF: sub_11498+FFj
		jmp	short loc_115AC
; ---------------------------------------------------------------------------
		jmp	short loc_115AC
; ---------------------------------------------------------------------------

loc_115A0:				; CODE XREF: sub_11498+EBj
		cmp	ax, 32h	; '2'
		jz	short loc_11590
		cmp	ax, 38h	; '8'
		jz	short loc_11585
		jmp	short $+2

loc_115AC:				; CODE XREF: sub_11498:loc_1158Ej
					; sub_11498:loc_1159Cj	...
		cmp	[bp+var_2], 0Dh
		jz	short loc_115B5
		jmp	loc_1152C
; ---------------------------------------------------------------------------

loc_115B5:				; CODE XREF: sub_11498+118j
		mov	[bp+var_4], 0
		jmp	short loc_115BF
; ---------------------------------------------------------------------------

loc_115BC:				; CODE XREF: sub_11498+148j
		inc	[bp+var_4]

loc_115BF:				; CODE XREF: sub_11498+122j
		mov	ax, curSelectID
		cmp	[bp+var_4], ax
		jge	short loc_115E2
		mov	ax, 3
		push	ax
		sub	ax, ax
		push	ax
		mov	bx, [bp+var_4]
		shl	bx, 1
		push	word_1BF82[bx]
		push	[bp+var_4]
		call	DrawTBoxBorder
		add	sp, 8
		jmp	short loc_115BC
; ---------------------------------------------------------------------------

loc_115E2:				; CODE XREF: sub_11498+12Dj
		mov	ax, 3
		push	ax
		call	ScrollTextOutUp
		add	sp, 2
		mov	TextBoxes.field_10+36h,	0
		mov	bx, [bp+var_8]
		shl	bx, 1
		mov	ax, choiceJumpDest[bx]
		add	ax, word ptr scrDataBasePtr
		mov	dx, word ptr scrDataBasePtr+2
		mov	word ptr scrDataPtr, ax
		mov	word ptr scrDataPtr+2, dx
		mov	sp, bp
		pop	bp
		retn
sub_11498	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1160E	proc near		; CODE XREF: sub_11CDB+5Bp
					; sub_11CDB+73p

var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  4
arg_2		= word ptr  6
arg_4		= word ptr  8
arg_6		= word ptr  0Ah

		push	bp
		mov	bp, sp
		mov	ax, 4
		call	__chkstk
		mov	[bp+var_2], 3Dh	; '='
		mov	[bp+var_4], 8Fh	; ''
		mov	ax, 1
		push	ax
		call	SetGDCPlane_Wrt
		add	sp, 2
		mov	ax, [bp+arg_2]
		sub	[bp+arg_0], ax
		sub	[bp+arg_6], ax
		cmp	debugMode, 0
		jz	short loc_1164F
		push	[bp+arg_6]
		push	[bp+arg_4]
		push	ax
		push	[bp+arg_0]
		mov	ax, offset aTipDDDD ; "tip %d,%d,%d,%d\n"
		push	ax		; char *
		call	_printf
		add	sp, 0Ah

loc_1164F:				; CODE XREF: sub_1160E+2Bj
		mov	ax, [bp+arg_0]
		mov	cl, 3
		shl	ax, cl
		add	ax, word_1C340
		mov	dx, word_1C342
		add	ax, 8
		mov	word ptr dword_1C344, ax
		mov	word ptr dword_1C344+2,	dx
		push	[bp+var_4]
		push	[bp+var_2]
		les	bx, dword_1C344
		mov	ax, es:[bx]
		add	ax, word_1C340
		push	dx
		push	ax
		call	sub_18031
		add	sp, 8
		mov	ax, [bp+arg_2]
		mov	cl, 3
		shl	ax, cl
		add	ax, word_1C340
		mov	dx, word_1C342
		add	ax, 8
		mov	word ptr dword_1C344, ax
		mov	word ptr dword_1C344+2,	dx
		push	[bp+var_4]
		mov	ax, [bp+var_2]
		add	ax, 4
		push	ax
		les	bx, dword_1C344
		mov	ax, es:[bx]
		add	ax, word_1C340
		push	dx
		push	ax
		call	sub_18031
		add	sp, 8
		mov	ax, [bp+arg_4]
		mov	cl, 3
		shl	ax, cl
		add	ax, word_1C340
		mov	dx, word_1C342
		add	ax, 8
		mov	word ptr dword_1C344, ax
		mov	word ptr dword_1C344+2,	dx
		push	[bp+var_4]
		mov	ax, [bp+var_2]
		add	ax, 8
		push	ax
		les	bx, dword_1C344
		mov	ax, es:[bx]
		add	ax, word_1C340
		push	dx
		push	ax
		call	sub_18031
		add	sp, 8
		mov	ax, [bp+arg_6]
		mov	cl, 3
		shl	ax, cl
		add	ax, word_1C340
		mov	dx, word_1C342
		add	ax, 8
		mov	word ptr dword_1C344, ax
		mov	word ptr dword_1C344+2,	dx
		push	[bp+var_4]
		mov	ax, [bp+var_2]
		add	ax, 0Ch
		push	ax
		les	bx, dword_1C344
		mov	ax, es:[bx]
		add	ax, word_1C340
		push	dx
		push	ax
		call	sub_18031
		add	sp, 8
		sub	ax, ax
		push	ax
		call	SetGDCPlane_Wrt
		add	sp, 2
		mov	ax, [bp+arg_0]
		mov	cl, 3
		shl	ax, cl
		add	ax, word_1C340
		mov	dx, word_1C342
		add	ax, 8
		mov	word ptr dword_1C344, ax
		mov	word ptr dword_1C344+2,	dx
		push	[bp+var_4]
		push	[bp+var_2]
		les	bx, dword_1C344
		mov	ax, es:[bx]
		add	ax, word_1C340
		push	dx
		push	ax
		call	sub_18031
		add	sp, 8
		mov	ax, [bp+arg_2]
		mov	cl, 3
		shl	ax, cl
		add	ax, word_1C340
		mov	dx, word_1C342
		add	ax, 8
		mov	word ptr dword_1C344, ax
		mov	word ptr dword_1C344+2,	dx
		push	[bp+var_4]
		mov	ax, [bp+var_2]
		add	ax, 4
		push	ax
		les	bx, dword_1C344
		mov	ax, es:[bx]
		add	ax, word_1C340
		push	dx
		push	ax
		call	sub_18031
		add	sp, 8
		mov	ax, [bp+arg_4]
		mov	cl, 3
		shl	ax, cl
		add	ax, word_1C340
		mov	dx, word_1C342
		add	ax, 8
		mov	word ptr dword_1C344, ax
		mov	word ptr dword_1C344+2,	dx
		push	[bp+var_4]
		mov	ax, [bp+var_2]
		add	ax, 8
		push	ax
		les	bx, dword_1C344
		mov	ax, es:[bx]
		add	ax, word_1C340
		push	dx
		push	ax
		call	sub_18031
		add	sp, 8
		mov	ax, [bp+arg_6]
		mov	cl, 3
		shl	ax, cl
		add	ax, word_1C340
		mov	dx, word_1C342
		add	ax, 8
		mov	word ptr dword_1C344, ax
		mov	word ptr dword_1C344+2,	dx
		push	[bp+var_4]
		mov	ax, [bp+var_2]
		add	ax, 0Ch
		push	ax
		les	bx, dword_1C344
		mov	ax, es:[bx]
		add	ax, word_1C340
		push	dx
		push	ax
		call	sub_18031
		add	sp, 8
		mov	sp, bp
		pop	bp
		retn
sub_1160E	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_11804	proc near		; CODE XREF: sub_11D81:loc_11DAEp

var_A		= word ptr -0Ah
var_8		= word ptr -8
var_6		= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2

		push	bp
		mov	bp, sp
		mov	ax, 0Ah
		call	__chkstk
		mov	[bp+var_2], 3Eh	; '>'
		mov	[bp+var_4], 21h	; '!'
		mov	[bp+var_A], 0A8Eh
		mov	[bp+var_8], 0
		mov	[bp+var_6], 0
		jmp	short loc_1182B
; ---------------------------------------------------------------------------

loc_11828:				; CODE XREF: sub_11804+79j
		inc	[bp+var_6]

loc_1182B:				; CODE XREF: sub_11804+22j
		cmp	[bp+var_6], 11h
		jge	short loc_1187F
		mov	ax, [bp+var_8]
		add	ax, [bp+var_6]
		mov	cl, 3
		shl	ax, cl
		add	ax, word_1C33A
		mov	dx, word_1C33C
		add	ax, 8
		mov	word ptr dword_1C344, ax
		mov	word ptr dword_1C344+2,	dx
		mov	ax, 80h	; '€'
		push	ax
		mov	ax, 11h
		push	ax
		mov	ax, [bp+var_6]
		add	ax, word_1BF94
		mov	dx, word_1BF96
		push	dx
		push	ax
		sub	ax, ax
		push	ax
		push	ax
		les	bx, dword_1C344
		mov	ax, es:[bx]
		add	ax, word_1C33A
		mov	dx, word_1C33C
		push	dx
		push	ax
		call	sub_18267
		add	sp, 10h
		jmp	short loc_11828
; ---------------------------------------------------------------------------

loc_1187F:				; CODE XREF: sub_11804+2Bj
		mov	ax, 1
		push	ax
		call	SetGDCPlane_Wrt
		add	sp, 2
		mov	ax, 3
		push	ax
		mov	ax, 11h
		push	ax
		mov	ax, 881h
		push	ax
		push	[bp+var_A]
		mov	ax, 80h	; '€'
		push	ax
		mov	ax, 10h
		push	ax
		push	word_1BF96
		push	word_1BF94
		call	sub_14F8F
		add	sp, 10h
		call	SwapGDCPlanes
		mov	ax, 3
		push	ax
		mov	ax, 11h
		push	ax
		mov	ax, 881h
		push	ax
		push	[bp+var_A]
		mov	ax, 80h	; '€'
		push	ax
		mov	ax, 10h
		push	ax
		push	word_1BF96
		push	word_1BF94
		call	sub_14F8F
		add	sp, 10h
		mov	sp, bp
		pop	bp
		retn
sub_11804	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_118DA	proc near		; CODE XREF: sub_17C81+44p

var_10		= word ptr -10h
var_C		= word ptr -0Ch
var_A		= word ptr -0Ah
var_8		= word ptr -8
var_6		= word ptr -6
var_4		= word ptr -4

		push	bp
		mov	bp, sp
		mov	ax, 10h
		call	__chkstk
		mov	[bp+var_4], 3Eh	; '>'
		mov	[bp+var_8], 21h	; '!'
		mov	[bp+var_10], 0A8Eh
		mov	[bp+var_6], 1
		cmp	word_1ACFC, 0
		jnz	short loc_11901
		jmp	loc_11C4A
; ---------------------------------------------------------------------------

loc_11901:				; CODE XREF: sub_118DA+22j
		mov	ax, word_1AD02
		mov	cl, 4
		shl	ax, cl
		mov	[bp+var_C], ax
		mov	ax, word_1ACFE
		mov	[bp+var_A], ax
		mov	ax, word_1AD00
		jmp	loc_11C07
; ---------------------------------------------------------------------------

loc_11917:				; CODE XREF: sub_118DA+331j
		mov	ax, [bp+var_C]
		add	ax, [bp+var_A]
		mov	cl, 3
		shl	ax, cl
		add	ax, word_1C33A
		mov	dx, word_1C33C
		add	ax, 8
		mov	word ptr dword_1C344, ax
		mov	word ptr dword_1C344+2,	dx
		mov	ax, 80h	; '€'
		push	ax
		mov	ax, 11h
		push	ax
		mov	ax, [bp+var_A]
		add	ax, word_1BF9C
		mov	dx, word_1BF9E
		add	ax, 10h
		push	dx
		push	ax
		sub	ax, ax
		push	ax
		push	ax
		les	bx, dword_1C344
		mov	ax, es:[bx]
		add	ax, word_1C33A
		mov	dx, word_1C33C
		push	dx
		push	ax
		call	sub_18267
		add	sp, 10h
		mov	ax, 3
		push	ax
		mov	ax, 881h
		push	ax
		mov	ax, 80h	; '€'
		push	ax
		mov	ax, 11h
		push	ax
		mov	ax, [bp+var_A]
		add	ax, word_1BF9C
		mov	dx, word_1BF9E
		add	ax, 0Fh
		push	dx
		push	ax
		call	sub_1510A
		add	sp, 0Ch

loc_1198C:				; CODE XREF: sub_118DA:loc_1199Aj
		cmp	word_1AB44, 0
		jnz	short loc_1199A
		cmp	word_1ADDA, 0
		jz	short loc_1199C

loc_1199A:				; CODE XREF: sub_118DA+B7j
		jmp	short loc_1198C
; ---------------------------------------------------------------------------

loc_1199C:				; CODE XREF: sub_118DA+BEj
		mov	ax, [bp+var_6]
		mov	word_1AB44, ax
		mov	ax, 1
		push	ax
		call	SetGDCPlane_Wrt
		add	sp, 2
		mov	ax, 3
		push	ax
		mov	ax, 11h
		push	ax
		mov	ax, 881h
		push	ax
		push	[bp+var_10]
		mov	ax, 80h	; '€'
		push	ax
		mov	ax, 10h
		push	ax
		mov	ax, [bp+var_A]
		add	ax, word_1BF9C
		mov	dx, word_1BF9E
		push	dx
		push	ax
		call	sub_14F8F
		add	sp, 10h
		call	SwapGDCPlanes
		jmp	loc_11C28
; ---------------------------------------------------------------------------

loc_119DC:				; CODE XREF: sub_118DA+339j
		mov	ax, [bp+var_C]
		add	ax, [bp+var_A]
		mov	cl, 3
		shl	ax, cl
		add	ax, word_1C33A
		mov	dx, word_1C33C
		add	ax, 8
		mov	word ptr dword_1C344, ax
		mov	word ptr dword_1C344+2,	dx
		mov	ax, 80h	; '€'
		push	ax
		mov	ax, 11h
		push	ax
		mov	ax, [bp+var_A]
		add	ax, word_1BF8A
		mov	dx, word_1BF8C
		add	ax, 10h
		push	dx
		push	ax
		sub	ax, ax
		push	ax
		push	ax
		les	bx, dword_1C344
		mov	ax, es:[bx]
		add	ax, word_1C33A
		mov	dx, word_1C33C
		push	dx
		push	ax
		call	sub_18267
		add	sp, 10h
		mov	ax, 3
		push	ax
		mov	ax, 881h
		push	ax
		mov	ax, 80h	; '€'
		push	ax
		mov	ax, 11h
		push	ax
		mov	ax, [bp+var_A]
		add	ax, word_1BF8A
		mov	dx, word_1BF8C
		add	ax, 0Fh
		push	dx
		push	ax
		call	sub_14ADB
		add	sp, 0Ch

loc_11A51:				; CODE XREF: sub_118DA:loc_11A5Fj
		cmp	word_1AB44, 0
		jnz	short loc_11A5F
		cmp	word_1ADDA, 0
		jz	short loc_11A61

loc_11A5F:				; CODE XREF: sub_118DA+17Cj
		jmp	short loc_11A51
; ---------------------------------------------------------------------------

loc_11A61:				; CODE XREF: sub_118DA+183j
		mov	ax, [bp+var_6]
		mov	word_1AB44, ax
		mov	ax, 1
		push	ax
		call	SetGDCPlane_Wrt
		add	sp, 2
		mov	ax, 3
		push	ax
		mov	ax, 11h
		push	ax
		mov	ax, 881h
		push	ax
		push	[bp+var_10]
		mov	ax, 80h	; '€'
		push	ax
		mov	ax, 10h
		push	ax
		mov	ax, [bp+var_A]
		add	ax, word_1BF8A
		mov	dx, word_1BF8C
		push	dx
		push	ax
		call	sub_14F8F
		add	sp, 10h
		call	SwapGDCPlanes
		jmp	loc_11C28
; ---------------------------------------------------------------------------

loc_11AA1:				; CODE XREF: sub_118DA+341j
		mov	ax, [bp+var_C]
		add	ax, [bp+var_A]
		mov	cl, 3
		shl	ax, cl
		add	ax, word_1C33A
		mov	dx, word_1C33C
		add	ax, 8
		mov	word ptr dword_1C344, ax
		mov	word ptr dword_1C344+2,	dx
		mov	ax, 80h	; '€'
		push	ax
		mov	ax, 11h
		push	ax
		mov	ax, [bp+var_A]
		add	ax, word_1BFA0
		mov	dx, word_1BFA2
		add	ax, 10h
		push	dx
		push	ax
		sub	ax, ax
		push	ax
		push	ax
		les	bx, dword_1C344
		mov	ax, es:[bx]
		add	ax, word_1C33A
		mov	dx, word_1C33C
		push	dx
		push	ax
		call	sub_18267
		add	sp, 10h
		mov	ax, 3
		push	ax
		mov	ax, 881h
		push	ax
		mov	ax, 80h	; '€'
		push	ax
		mov	ax, 11h
		push	ax
		mov	ax, [bp+var_A]
		add	ax, word_1BFA0
		mov	dx, word_1BFA2
		add	ax, 0Fh
		push	dx
		push	ax
		call	sub_15141
		add	sp, 0Ch

loc_11B16:				; CODE XREF: sub_118DA:loc_11B24j
		cmp	word_1AB44, 0
		jnz	short loc_11B24
		cmp	word_1ADDA, 0
		jz	short loc_11B26

loc_11B24:				; CODE XREF: sub_118DA+241j
		jmp	short loc_11B16
; ---------------------------------------------------------------------------

loc_11B26:				; CODE XREF: sub_118DA+248j
		mov	ax, [bp+var_6]
		mov	word_1AB44, ax
		mov	ax, 1
		push	ax
		call	SetGDCPlane_Wrt
		add	sp, 2
		mov	ax, 3
		push	ax
		mov	ax, 11h
		push	ax
		mov	ax, 881h
		push	ax
		push	[bp+var_10]
		mov	ax, 80h	; '€'
		push	ax
		mov	ax, 10h
		push	ax
		mov	ax, [bp+var_A]
		add	ax, word_1BFA0
		mov	dx, word_1BFA2
		push	dx
		push	ax
		call	sub_14F8F
		add	sp, 10h
		call	SwapGDCPlanes
		jmp	loc_11C28
; ---------------------------------------------------------------------------

loc_11B66:				; CODE XREF: sub_118DA+349j
		mov	ax, [bp+var_C]
		add	ax, [bp+var_A]
		mov	cl, 3
		shl	ax, cl
		add	ax, word_1C33A
		mov	dx, word_1C33C
		add	ax, 8
		mov	word ptr dword_1C344, ax
		mov	word ptr dword_1C344+2,	dx
		mov	ax, 80h	; '€'
		push	ax
		mov	ax, 11h
		push	ax
		mov	ax, [bp+var_A]
		add	ax, word_1BF94
		mov	dx, word_1BF96
		add	ax, 10h
		push	dx
		push	ax
		sub	ax, ax
		push	ax
		push	ax
		les	bx, dword_1C344
		mov	ax, es:[bx]
		add	ax, word_1C33A
		mov	dx, word_1C33C
		push	dx
		push	ax
		call	sub_18267
		add	sp, 10h

loc_11BB5:				; CODE XREF: sub_118DA:loc_11BC3j
		cmp	word_1AB44, 0
		jnz	short loc_11BC3
		cmp	word_1ADDA, 0
		jz	short loc_11BC5

loc_11BC3:				; CODE XREF: sub_118DA+2E0j
		jmp	short loc_11BB5
; ---------------------------------------------------------------------------

loc_11BC5:				; CODE XREF: sub_118DA+2E7j
		mov	ax, [bp+var_6]
		mov	word_1AB44, ax
		mov	ax, 1
		push	ax
		call	SetGDCPlane_Wrt
		add	sp, 2
		mov	ax, 3
		push	ax
		mov	ax, 11h
		push	ax
		mov	ax, 881h
		push	ax
		push	[bp+var_10]
		mov	ax, 80h	; '€'
		push	ax
		mov	ax, 10h
		push	ax
		mov	ax, [bp+var_A]
		add	ax, word_1BF94
		mov	dx, word_1BF96
		inc	ax
		push	dx
		push	ax
		call	sub_14F8F
		add	sp, 10h
		call	SwapGDCPlanes
		jmp	short loc_11C28
; ---------------------------------------------------------------------------
		jmp	short loc_11C28
; ---------------------------------------------------------------------------

loc_11C07:				; CODE XREF: sub_118DA+3Aj
		or	ax, ax
		jnz	short loc_11C0E
		jmp	loc_11917
; ---------------------------------------------------------------------------

loc_11C0E:				; CODE XREF: sub_118DA+32Fj
		cmp	ax, 1
		jnz	short loc_11C16
		jmp	loc_119DC
; ---------------------------------------------------------------------------

loc_11C16:				; CODE XREF: sub_118DA+337j
		cmp	ax, 2
		jnz	short loc_11C1E
		jmp	loc_11AA1
; ---------------------------------------------------------------------------

loc_11C1E:				; CODE XREF: sub_118DA+33Fj
		cmp	ax, 3
		jnz	short loc_11C26
		jmp	loc_11B66
; ---------------------------------------------------------------------------

loc_11C26:				; CODE XREF: sub_118DA+347j
		jmp	short $+2

loc_11C28:				; CODE XREF: sub_118DA+FFj
					; sub_118DA+1C4j ...
		inc	word_1AD00
		cmp	word_1AD00, 4
		jl	short loc_11C3D
		mov	word_1AD00, 0
		inc	word_1ACFE

loc_11C3D:				; CODE XREF: sub_118DA+357j
		dec	word_1ACFC

loc_11C41:				; CODE XREF: sub_118DA+36Ej
		cmp	word_1ADDA, 0
		jz	short loc_11C4A
		jmp	short loc_11C41
; ---------------------------------------------------------------------------

loc_11C4A:				; CODE XREF: sub_118DA+24j
					; sub_118DA+36Cj
		mov	sp, bp
		pop	bp
		retn
sub_118DA	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_11C4E	proc near		; CODE XREF: sub_11498+D9p
					; sub_11D81+19p ...

var_E		= word ptr -0Eh
var_8		= word ptr -8
var_6		= word ptr -6
var_4		= word ptr -4
arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		mov	ax, 0Eh
		call	__chkstk
		mov	[bp+var_4], 3Eh	; '>'
		mov	[bp+var_8], 21h	; '!'
		mov	[bp+var_E], 0A8Eh
		mov	[bp+var_6], 1
		mov	word_1ACFC, 40h	; '@'
		mov	word_1ACFE, 0
		sub	ax, ax
		push	ax
		mov	ax, 2260h
		push	ax
		push	word_1BF8C
		push	word_1BF8A
		call	sub_14F6D
		add	sp, 8
		sub	ax, ax
		push	ax
		mov	ax, 2260h
		push	ax
		push	word_1BF96
		push	word_1BF94
		call	sub_14F6D
		add	sp, 8
		sub	ax, ax
		push	ax
		mov	ax, 2260h
		push	ax
		push	word_1BF9E
		push	word_1BF9C
		call	sub_14F6D
		add	sp, 8
		sub	ax, ax
		push	ax
		mov	ax, 2260h
		push	ax
		push	word_1BFA2
		push	word_1BFA0
		call	sub_14F6D
		add	sp, 8
		mov	word_1AD00, 0
		mov	ax, [bp+arg_0]
		mov	word_1AD02, ax
		mov	sp, bp
		pop	bp
		retn
sub_11C4E	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_11CDB	proc near		; CODE XREF: ExecuteScript+801p

arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		xor	ax, ax
		call	__chkstk
		mov	ax, [bp+arg_0]
		jmp	short loc_11D5A
; ---------------------------------------------------------------------------

loc_11CE8:				; CODE XREF: sub_11CDB+87j
					; DATA XREF: sub_11CDB:off_11D67o
		mov	word_1C990, 0
		jmp	loc_11D7D
; ---------------------------------------------------------------------------

loc_11CF1:				; CODE XREF: sub_11CDB+87j
					; DATA XREF: sub_11CDB+8Eo
		mov	word_1C990, 1
		jmp	loc_11D7D
; ---------------------------------------------------------------------------

loc_11CFA:				; CODE XREF: sub_11CDB+87j
					; DATA XREF: sub_11CDB+90o
		mov	word_1C990, 2
		jmp	short loc_11D7D
; ---------------------------------------------------------------------------

loc_11D02:				; CODE XREF: sub_11CDB+87j
					; DATA XREF: sub_11CDB+92o
		mov	word_1C990, 3
		jmp	short loc_11D7D
; ---------------------------------------------------------------------------

loc_11D0A:				; CODE XREF: sub_11CDB+87j
					; DATA XREF: sub_11CDB+94o
		mov	ax, word_1C990
		add	word_1AD04, ax
		sub	word_1AD06, ax
		mov	word_1C990, 0
		jmp	short loc_11D7D
; ---------------------------------------------------------------------------

loc_11D1D:				; CODE XREF: sub_11CDB+87j
					; DATA XREF: sub_11CDB+96o
		mov	ax, word_1C990
		sub	word_1AD04, ax
		add	word_1AD06, ax
		mov	word_1C990, 0
		jmp	short loc_11D7D
; ---------------------------------------------------------------------------

loc_11D30:				; CODE XREF: sub_11CDB+87j
					; DATA XREF: sub_11CDB+9Co
		sub	ax, ax
		push	ax
		push	ax
		push	ax
		push	ax
		call	sub_1160E
		add	sp, 8
		jmp	short loc_11D7D
; ---------------------------------------------------------------------------

loc_11D3E:				; CODE XREF: sub_11CDB+87j
					; DATA XREF: sub_11CDB+9Eo
		push	word_1AD04
		push	word_1C990
		push	word_1C990
		push	word_1AD06
		call	sub_1160E
		add	sp, 8
		jmp	short loc_11D7D
; ---------------------------------------------------------------------------
		jmp	short loc_11D7D
; ---------------------------------------------------------------------------
		jmp	short loc_11D7D
; ---------------------------------------------------------------------------

loc_11D5A:				; CODE XREF: sub_11CDB+Bj
		cmp	ax, 0Ah
		ja	short loc_11D7D
		add	ax, ax
		xchg	ax, bx
		jmp	cs:off_11D67[bx]
; ---------------------------------------------------------------------------
off_11D67	dw offset loc_11CE8	; DATA XREF: sub_11CDB+87r
		dw offset loc_11CF1
		dw offset loc_11CFA
		dw offset loc_11D02
		dw offset loc_11D0A
		dw offset loc_11D1D
		dw offset loc_11D7D
		dw offset loc_11D7D
		dw offset loc_11D30
		dw offset loc_11D3E
		dw offset loc_11D7D
; ---------------------------------------------------------------------------

loc_11D7D:				; CODE XREF: sub_11CDB+13j
					; sub_11CDB+1Cj ...
		mov	sp, bp
		pop	bp
		retn
sub_11CDB	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_11D81	proc near		; CODE XREF: ExecuteScript+811p

arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		xor	ax, ax
		call	__chkstk
		mov	ax, [bp+arg_0]
		jmp	short loc_11DCF
; ---------------------------------------------------------------------------

loc_11D8E:				; CODE XREF: sub_11D81+5Cj
		mov	word_1AB42, 1
		call	sub_14270
		push	[bp+arg_0]
		call	sub_11C4E
		add	sp, 2
		mov	word_1ACFC, 38h	; '8'
		mov	word_1ACFE, 2
		jmp	short loc_11DF2
; ---------------------------------------------------------------------------

loc_11DAE:				; CODE XREF: sub_11D81+51j
		call	sub_11804
		jmp	short loc_11DF2
; ---------------------------------------------------------------------------

loc_11DB3:				; CODE XREF: sub_11D81+68j
		mov	ax, [bp+arg_0]
		sub	ax, 4
		push	ax
		call	sub_11C4E
		add	sp, 2
		jmp	short loc_11DF2
; ---------------------------------------------------------------------------

loc_11DC2:				; CODE XREF: sub_11D81+6Dj
		mov	word_1ACFC, 0
		call	sub_17166
		jmp	short loc_11DF2
; ---------------------------------------------------------------------------
		jmp	short loc_11DF2
; ---------------------------------------------------------------------------

loc_11DCF:				; CODE XREF: sub_11D81+Bj
		cmp	ax, 4
		jz	short loc_11DAE
		jg	short loc_11DE1
		or	ax, ax
		jl	short loc_11DF2
		cmp	ax, 3
		jle	short loc_11D8E
		jmp	short loc_11DF2
; ---------------------------------------------------------------------------

loc_11DE1:				; CODE XREF: sub_11D81+53j
		cmp	ax, 5
		jl	short loc_11DF2
		cmp	ax, 7
		jle	short loc_11DB3
		cmp	ax, 0FFh
		jz	short loc_11DC2
		jmp	short $+2

loc_11DF2:				; CODE XREF: sub_11D81+2Bj
					; sub_11D81+30j ...
		mov	sp, bp
		pop	bp
		retn
sub_11D81	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_11DF6	proc near		; CODE XREF: sub_111CF+35p
					; sub_111CF+6Cp ...

var_2		= word ptr -2
arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		mov	ax, 2
		call	__chkstk
		push	si
		mov	[bp+var_2], 0E64h
		mov	ax, 1
		push	ax
		call	SetGDCPlane_Wrt
		add	sp, 2
		mov	ax, [bp+arg_0]
		mov	cl, 3
		shl	ax, cl
		add	ax, word ptr dword_1C334
		mov	dx, word ptr dword_1C334+2
		add	ax, 8
		mov	word ptr dword_1C344, ax
		mov	word ptr dword_1C344+2,	dx
		les	bx, dword_1C344
		mov	bx, es:[bx]
		les	si, dword_1C334
		cmp	byte ptr es:[bx+si], 41h ; 'A'
		jz	short loc_11E3C
		jmp	loc_11EC4
; ---------------------------------------------------------------------------

loc_11E3C:				; CODE XREF: sub_11DF6+41j
		mov	ax, 4
		push	ax
		mov	ax, 36h	; '6'
		push	ax
		mov	ax, 2A30h
		push	ax
		push	[bp+var_2]
		mov	ax, 0C8h ; 'È'
		push	ax
		mov	ax, 36h	; '6'
		push	ax
		push	word ptr dword_1BCDC+2
		push	word ptr dword_1BCDC
		call	sub_14F8F
		add	sp, 10h
		push	word_1BCBC
		push	word_1BCBA
		sub	ax, ax
		push	ax
		push	ax
		les	bx, dword_1C344
		mov	ax, es:[bx]
		add	ax, word ptr dword_1C334
		mov	dx, word ptr dword_1C334+2
		push	dx
		push	ax
		call	sub_18093
		add	sp, 0Ch
		les	bx, dword_1C344
		mov	ax, 50h	; 'P'
		mul	word ptr es:[bx+4]
		mov	cl, es:[bx+2]
		sub	ch, ch
		add	ax, cx
		add	ax, [bp+var_2]
		push	ax
		push	word ptr es:[bx+6]
		mov	al, es:[bx+3]
		sub	ah, ah
		push	ax
		push	word_1BCBC
		push	word_1BCBA
		call	sub_15D82
		add	sp, 0Ah
		mov	ax, 2Eh	; '.'
		push	ax
		mov	ax, 4
		push	ax
		call	sub_105EA
		add	sp, 4
		jmp	short loc_11F14
; ---------------------------------------------------------------------------

loc_11EC4:				; CODE XREF: sub_11DF6+43j
		mov	ax, 0C8h ; 'È'
		push	ax
		mov	ax, 36h	; '6'
		push	ax
		push	word ptr dword_1BCDC+2
		push	word ptr dword_1BCDC
		sub	ax, ax
		push	ax
		push	ax
		les	bx, dword_1C344
		mov	ax, es:[bx]
		add	ax, word ptr dword_1C334
		mov	dx, word ptr dword_1C334+2
		push	dx
		push	ax
		call	sub_181EA
		add	sp, 10h
		mov	ax, 4
		push	ax
		mov	ax, 36h	; '6'
		push	ax
		mov	ax, 2A30h
		push	ax
		push	[bp+var_2]
		mov	ax, 0C8h ; 'È'
		push	ax
		mov	ax, 36h	; '6'
		push	ax
		push	word ptr dword_1BCDC+2
		push	word ptr dword_1BCDC
		call	sub_14F8F
		add	sp, 10h

loc_11F14:				; CODE XREF: sub_11DF6+CCj
		call	SwapGDCPlanes
		mov	ax, 1
		push	ax
		call	SetGDCPlane_Wrt
		add	sp, 2
		mov	ax, 4
		push	ax
		mov	ax, 36h	; '6'
		push	ax
		mov	ax, 2A30h
		push	ax
		push	[bp+var_2]
		mov	ax, 0C8h ; 'È'
		push	ax
		mov	ax, 36h	; '6'
		push	ax
		push	word ptr dword_1BCDC+2
		push	word ptr dword_1BCDC
		call	sub_14F8F
		add	sp, 10h
		pop	si
		mov	sp, bp
		pop	bp
		retn
sub_11DF6	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_11F4B	proc near		; CODE XREF: sub_111CF+5Dp

var_2		= word ptr -2
arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		mov	ax, 2
		call	__chkstk
		push	si
		mov	[bp+var_2], 0E64h
		mov	ax, 1
		push	ax
		call	SetGDCPlane_Wrt
		add	sp, 2
		mov	ax, [bp+arg_0]
		mov	cl, 3
		shl	ax, cl
		add	ax, word ptr dword_1C334
		mov	dx, word ptr dword_1C334+2
		add	ax, 8
		mov	word ptr dword_1C344, ax
		mov	word ptr dword_1C344+2,	dx
		les	bx, dword_1C344
		mov	bx, es:[bx]
		les	si, dword_1C334
		cmp	byte ptr es:[bx+si], 41h ; 'A'
		jz	short loc_11F91
		jmp	loc_12019
; ---------------------------------------------------------------------------

loc_11F91:				; CODE XREF: sub_11F4B+41j
		mov	ax, 4
		push	ax
		mov	ax, 36h	; '6'
		push	ax
		mov	ax, 2A30h
		push	ax
		push	[bp+var_2]
		mov	ax, 0C8h ; 'È'
		push	ax
		mov	ax, 36h	; '6'
		push	ax
		push	word ptr dword_1BCDC+2
		push	word ptr dword_1BCDC
		call	sub_14F8F
		add	sp, 10h
		push	word_1BCBC
		push	word_1BCBA
		sub	ax, ax
		push	ax
		push	ax
		les	bx, dword_1C344
		mov	ax, es:[bx]
		add	ax, word ptr dword_1C334
		mov	dx, word ptr dword_1C334+2
		push	dx
		push	ax
		call	sub_18093
		add	sp, 0Ch
		les	bx, dword_1C344
		mov	ax, 50h	; 'P'
		mul	word ptr es:[bx+4]
		mov	cl, es:[bx+2]
		sub	ch, ch
		add	ax, cx
		add	ax, [bp+var_2]
		push	ax
		push	word ptr es:[bx+6]
		mov	al, es:[bx+3]
		sub	ah, ah
		push	ax
		push	word_1BCBC
		push	word_1BCBA
		call	sub_15D82
		add	sp, 0Ah
		mov	ax, 2Eh	; '.'
		push	ax
		mov	ax, 4
		push	ax
		call	sub_105EA
		add	sp, 4
		jmp	short loc_12069
; ---------------------------------------------------------------------------

loc_12019:				; CODE XREF: sub_11F4B+43j
		mov	ax, 0C8h ; 'È'
		push	ax
		mov	ax, 36h	; '6'
		push	ax
		push	word ptr dword_1BCDC+2
		push	word ptr dword_1BCDC
		sub	ax, ax
		push	ax
		push	ax
		les	bx, dword_1C344
		mov	ax, es:[bx]
		add	ax, word ptr dword_1C334
		mov	dx, word ptr dword_1C334+2
		push	dx
		push	ax
		call	sub_181EA
		add	sp, 10h
		mov	ax, 4
		push	ax
		mov	ax, 36h	; '6'
		push	ax
		mov	ax, 2A30h
		push	ax
		push	[bp+var_2]
		mov	ax, 0C8h ; 'È'
		push	ax
		mov	ax, 36h	; '6'
		push	ax
		push	word ptr dword_1BCDC+2
		push	word ptr dword_1BCDC
		call	sub_14F8F
		add	sp, 10h

loc_12069:				; CODE XREF: sub_11F4B+CCj
		call	SwapGDCPlanes

loc_1206C:				; CODE XREF: sub_11F4B+128j
		cmp	word_1AB44, 0
		jz	short loc_12075
		jmp	short loc_1206C
; ---------------------------------------------------------------------------

loc_12075:				; CODE XREF: sub_11F4B+126j
		mov	word_1AB44, 4
		pop	si
		mov	sp, bp
		pop	bp
		retn
sub_11F4B	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_12080	proc near		; CODE XREF: ExecuteScript+939p

arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		xor	ax, ax
		call	__chkstk
		call	ScrData_GetInt
		mov	word_1BCDA, ax
		mov	ax, [bp+arg_0]
		jmp	short loc_1209F
; ---------------------------------------------------------------------------

loc_12093:				; CODE XREF: sub_12080+21j
		call	sub_178D9
		jmp	short loc_120AA
; ---------------------------------------------------------------------------

loc_12098:				; CODE XREF: sub_12080+26j
		call	sub_178F7
		jmp	short loc_120AA
; ---------------------------------------------------------------------------
		jmp	short loc_120AA
; ---------------------------------------------------------------------------

loc_1209F:				; CODE XREF: sub_12080+11j
		or	ax, ax
		jz	short loc_12093
		cmp	ax, 1
		jz	short loc_12098
		jmp	short $+2

loc_120AA:				; CODE XREF: sub_12080+16j
					; sub_12080+1Bj ...
		mov	sp, bp
		pop	bp
		retn
sub_12080	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

ExecuteScript	proc near		; CODE XREF: sub_10A4B+A8p
					; sub_10A4B+242p ...

var_54		= word ptr -54h
var_52		= word ptr -52h
var_50		= word ptr -50h
var_4E		= word ptr -4Eh
var_4C		= word ptr -4Ch
var_4A		= word ptr -4Ah
var_48		= word ptr -48h
var_46		= word ptr -46h
var_44		= word ptr -44h
var_42		= word ptr -42h
var_40		= word ptr -40h
var_3E		= word ptr -3Eh

		push	bp
		mov	bp, sp
		mov	ax, 54h
		call	__chkstk
		push	di
		push	si
		mov	[bp+var_42], 0

scriptMainLoop:				; CODE XREF: ExecuteScript:loc_132A1j
		cmp	stopDialogDraw,	0
		jz	short loc_120E3
		mov	stopDialogDraw,	0
		mov	ax, word_1BCDA
		add	ax, word ptr scrDataBasePtr
		mov	dx, word ptr scrDataBasePtr+2
		mov	word ptr scrDataPtr, ax
		mov	word ptr scrDataPtr+2, dx
		mov	scrStackIdx, 0

loc_120E3:				; CODE XREF: ExecuteScript+15j
		call	ScrData_GetByte
		mov	[bp+var_44], ax
		cmp	debugMode, 0
		jz	short loc_12104
		mov	ax, 14h
		imul	[bp+var_44]
		add	ax, offset byte_1A67E
		push	ax
		mov	ax, offset aS	; "%s "
		push	ax		; char *
		call	_printf
		add	sp, 4

loc_12104:				; CODE XREF: ExecuteScript+40j
		cmp	word_1B0E0, 0
		jz	short loc_12110
		mov	[bp+var_44], 3Ch ; '<'

loc_12110:				; CODE XREF: ExecuteScript+5Bj
		cmp	debugMode, 0
		jz	short loc_12128
		cmp	word_1B0E0, 0
		jz	short loc_12128
		mov	ax, offset aAllendflagOn ; "\nAllEndFlag ON\n"
		push	ax		; char *
		call	_printf
		add	sp, 2

loc_12128:				; CODE XREF: ExecuteScript+67j
					; ExecuteScript+6Ej
		cmp	debugMode, 0
		jz	short loc_12143
		call	sub_167A3
		or	ax, ax
		jz	short loc_12143
		call	sub_167AE
		cmp	ax, 1Bh
		jnz	short loc_12143
		mov	[bp+var_44], 3Ch ; '<'

loc_12143:				; CODE XREF: ExecuteScript+7Fj
					; ExecuteScript+86j ...
		cmp	fileLoadErr, 0
		jz	short loc_1214F
		mov	[bp+var_44], 3Ch ; '<'

loc_1214F:				; CODE XREF: ExecuteScript+9Aj
		cmp	debugMode, 0
		jz	short loc_12167
		cmp	fileLoadErr, 0
		jz	short loc_12167
		mov	ax, offset aReaderrFlagOn ; "\nReadErr Flag ON\n"
		push	ax		; char *
		call	_printf
		add	sp, 2

loc_12167:				; CODE XREF: ExecuteScript+A6j
					; ExecuteScript+ADj
		mov	ax, [bp+var_44]
		jmp	DoScriptCommand
; ---------------------------------------------------------------------------

scr26_NameDlg:				; CODE XREF: ExecuteScript+116Ej
					; DATA XREF: ExecuteScript:scrJumpTblo
		mov	ax, 2
		push	ax
		mov	ax, 10h
		push	ax
		mov	ax, 8
		push	ax
		call	SetTextOpts
		add	sp, 6
		mov	ax, offset StringBuffer
		push	ax
		call	ScrData_Str2Buf
		add	sp, 2
		call	ScrData_GetStr
		mov	word ptr scrDialogPtr, ax
		mov	word ptr scrDialogPtr+2, dx
		mov	ax, offset StringBuffer
		push	ax
		call	DrawText_Name
		add	sp, 2
		push	word ptr scrDialogPtr+2
		push	word ptr scrDialogPtr
		call	DrawText_Dialog
		add	sp, 4
		jmp	scr_next
; ---------------------------------------------------------------------------

scr27_Dialog:				; CODE XREF: ExecuteScript+116Ej
					; DATA XREF: ExecuteScript:scrJumpTblo
		mov	ax, 2
		push	ax
		mov	ax, 10h
		push	ax
		mov	ax, 8
		push	ax
		call	SetTextOpts
		add	sp, 6
		call	ScrData_GetStr
		mov	word ptr scrDialogPtr, ax
		mov	word ptr scrDialogPtr+2, dx
		push	dx
		push	ax
		call	DrawText_Dialog
		add	sp, 4
		jmp	scr_next
; ---------------------------------------------------------------------------

scr28_NameDlg:				; CODE XREF: ExecuteScript+116Ej
					; DATA XREF: ExecuteScript:scrJumpTblo
		call	ScrData_GetByte
		mov	[bp+var_54], ax
		mov	word_1C98A, ax
		mov	word_1AB42, 1
		call	sub_14270
		jmp	scr_next
; ---------------------------------------------------------------------------

scr29_NameDlg:				; CODE XREF: ExecuteScript+116Ej
					; DATA XREF: ExecuteScript:scrJumpTblo
		call	ScrData_GetByte
		mov	[bp+var_54], ax
		mov	word_1C98A, ax
		mov	word_1AB42, 1
		call	sub_14270
		push	[bp+var_54]
		mov	ax, 1
		push	ax
		call	sub_184FD
		add	sp, 4
		mov	ax, 2
		push	ax
		mov	ax, 10h
		push	ax
		mov	ax, 8
		push	ax
		call	SetTextOpts
		add	sp, 6
		mov	ax, offset StringBuffer
		push	ax
		call	ScrData_Str2Buf
		add	sp, 2
		call	ScrData_GetStr
		mov	word ptr scrDialogPtr, ax
		mov	word ptr scrDialogPtr+2, dx
		mov	ax, offset StringBuffer
		push	ax
		call	DrawText_Name
		add	sp, 2
		push	word ptr scrDialogPtr+2
		push	word ptr scrDialogPtr
		call	DrawText_Dialog
		add	sp, 4
		jmp	scr_next
; ---------------------------------------------------------------------------

loc_1224A:				; CODE XREF: ExecuteScript+116Ej
					; DATA XREF: ExecuteScript:scrJumpTblo
		call	ScrData_GetByte
		mov	[bp+var_54], ax
		dec	ax
		mov	word_1C348, ax
		mov	word_1AB42, 1
		call	sub_14270
		jmp	scr_next
; ---------------------------------------------------------------------------

loc_12260:				; CODE XREF: ExecuteScript+116Ej
					; DATA XREF: ExecuteScript:scrJumpTblo
		call	ScrData_GetByte
		mov	[bp+var_54], ax
		dec	ax
		mov	word_1C348, ax
		mov	word_1AB42, 1
		call	sub_14270
		push	[bp+var_54]
		sub	ax, ax
		push	ax
		call	sub_184FD
		add	sp, 4
		mov	ax, 2
		push	ax
		mov	ax, 10h
		push	ax
		mov	ax, 8
		push	ax
		call	SetTextOpts
		add	sp, 6
		mov	ax, offset StringBuffer
		push	ax
		call	ScrData_Str2Buf
		add	sp, 2
		call	ScrData_GetStr
		mov	word ptr scrDialogPtr, ax
		mov	word ptr scrDialogPtr+2, dx
		mov	ax, offset StringBuffer
		push	ax
		call	DrawText_Name
		add	sp, 2
		push	word ptr scrDialogPtr+2
		push	word ptr scrDialogPtr
		call	DrawText_Dialog
		add	sp, 4
		jmp	scr_next
; ---------------------------------------------------------------------------

scr01:					; CODE XREF: ExecuteScript+116Ej
					; DATA XREF: ExecuteScript:scrJumpTblo
		mov	ax, 2
		push	ax
		mov	ax, 10h
		push	ax
		mov	ax, 8
		push	ax
		call	SetTextOpts
		add	sp, 6
		mov	ax, offset StringBuffer
		push	ax
		call	ScrData_Str2Buf
		add	sp, 2
		mov	ax, offset StringBuffer
		push	ax
		call	DrawText_TB1a_Wait
		add	sp, 2
		jmp	scr_next
; ---------------------------------------------------------------------------

scr02:					; CODE XREF: ExecuteScript+116Ej
					; DATA XREF: ExecuteScript:scrJumpTblo
		mov	ax, 2
		push	ax
		mov	ax, 10h
		push	ax
		mov	ax, 8
		push	ax
		call	SetTextOpts
		add	sp, 6
		mov	ax, offset StringBuffer
		push	ax
		call	ScrData_Str2Buf
		add	sp, 2
		mov	ax, offset StringBuffer
		push	ax
		call	DrawText_Tb1b
		add	sp, 2
		jmp	scr_next
; ---------------------------------------------------------------------------

cmd3C_Quit:				; CODE XREF: ExecuteScript+116Ej
					; DATA XREF: ExecuteScript:scrJumpTblo
		mov	[bp+var_42], 1
		jmp	scr_next
; ---------------------------------------------------------------------------

scr09_Jump:				; CODE XREF: ExecuteScript+116Ej
					; DATA XREF: ExecuteScript:scrJumpTblo
		call	ScrData_GetInt
		mov	[bp+var_54], ax
		add	ax, word ptr scrDataBasePtr
		mov	dx, word ptr scrDataBasePtr+2
		mov	word ptr scrDataPtr, ax
		mov	word ptr scrDataPtr+2, dx
		jmp	scr_next
; ---------------------------------------------------------------------------

scr0B_VarCompare:			; CODE XREF: ExecuteScript+116Ej
					; DATA XREF: ExecuteScript:scrJumpTblo
		call	sub_1013C
		or	ax, ax
		jz	short loc_12345
		call	ScrData_GetByte	; skip 3 bytes (expects	a "jump" command)
		mov	[bp+var_54], ax
		call	ScrData_GetInt
		mov	[bp+var_54], ax

loc_12345:				; CODE XREF: ExecuteScript+289j
		jmp	scr_next
; ---------------------------------------------------------------------------

loc_12348:				; CODE XREF: ExecuteScript+116Ej
					; DATA XREF: ExecuteScript:scrJumpTblo
		call	ScrData_GetByte
		mov	[bp+var_54], ax
		call	ScrData_GetByte
		mov	[bp+var_52], ax
		push	[bp+var_54]
		call	sub_10522
		add	sp, 2
		mov	bx, [bp+var_52]
		mov	scriptRAM[bx], al
		jmp	scr_next
; ---------------------------------------------------------------------------

scr2D_VarSet:				; CODE XREF: ExecuteScript+116Ej
					; DATA XREF: ExecuteScript:scrJumpTblo
		call	ScrData_GetByte
		mov	[bp+var_52], ax	; destination register ID
		call	ScrData_GetByte
		mov	[bp+var_54], ax	; value
		test	byte ptr [bp+var_54], 80h
		jz	short loc_1238B
		mov	bx, [bp+var_52]	; value	80..FF -> register 00..7F
		mov	si, ax
		and	si, 7Fh
		mov	al, scriptRAM[si]
		mov	scriptRAM[bx], al ; scriptRAM[dstID] = scriptRAM[srcID]
		jmp	short loc_12395
; ---------------------------------------------------------------------------

loc_1238B:				; CODE XREF: ExecuteScript+2C9j
		mov	bx, [bp+var_52]	; value	00..7F -> raw value
		mov	al, byte ptr [bp+var_54]
		mov	scriptRAM[bx], al ; scriptRAM[dstID] -=	srcValue

loc_12395:				; CODE XREF: ExecuteScript+2DBj
		jmp	scr_next
; ---------------------------------------------------------------------------

scr30_JumpVar:				; CODE XREF: ExecuteScript+116Ej
					; DATA XREF: ExecuteScript:scrJumpTblo
		call	ScrData_GetByte
		mov	[bp+var_54], ax	; destination register ID
		call	ScrData_GetByte
		mov	[bp+var_52], ax
		cmp	debugMode, 0
		jz	short loc_123B6
		push	ax
		mov	ax, offset aM2d	; " m=%2d "
		push	ax		; char *
		call	_printf
		add	sp, 4

loc_123B6:				; CODE XREF: ExecuteScript+2FBj
		mov	[bp+var_4E], 0
		jmp	short loc_123C0
; ---------------------------------------------------------------------------

loc_123BD:				; CODE XREF: ExecuteScript:loc_123ECj
		inc	[bp+var_4E]

loc_123C0:				; CODE XREF: ExecuteScript+30Dj
		mov	ax, [bp+var_52]
		cmp	[bp+var_4E], ax
		jge	short loc_123EE
		call	ScrData_GetInt
		mov	si, [bp+var_4E]
		shl	si, 1
		mov	[bp+si+var_3E],	ax
		cmp	debugMode, 0
		jz	short loc_123EC
		mov	si, [bp+var_4E]
		shl	si, 1
		push	[bp+si+var_3E]
		mov	ax, offset a04x	; "<%04x>"
		push	ax		; char *
		call	_printf
		add	sp, 4

loc_123EC:				; CODE XREF: ExecuteScript+32Aj
		jmp	short loc_123BD
; ---------------------------------------------------------------------------

loc_123EE:				; CODE XREF: ExecuteScript+318j
		cmp	debugMode, 0
		jz	short loc_12409
		mov	bx, [bp+var_54]
		mov	al, scriptRAM[bx]
		sub	ah, ah
		push	ax
		mov	ax, offset aSw2d ; " sw[%2d] "
		push	ax		; char *
		call	_printf
		add	sp, 4

loc_12409:				; CODE XREF: ExecuteScript+345j
		mov	bx, [bp+var_54]
		cmp	scriptRAM[bx], 0
		jz	short loc_1242F
		mov	si, word ptr scriptRAM[bx]
		and	si, 0FFh
		shl	si, 1
		mov	ax, [bp+si+var_40]
		add	ax, word ptr scrDataBasePtr
		mov	dx, word ptr scrDataBasePtr+2
		mov	word ptr scrDataPtr, ax
		mov	word ptr scrDataPtr+2, dx

loc_1242F:				; CODE XREF: ExecuteScript+363j
		jmp	scr_next
; ---------------------------------------------------------------------------

scr2E_VarAdd:				; CODE XREF: ExecuteScript+116Ej
					; DATA XREF: ExecuteScript:scrJumpTblo
		call	ScrData_GetByte
		mov	[bp+var_52], ax	; destination register ID
		call	ScrData_GetByte
		mov	[bp+var_54], ax
		test	byte ptr [bp+var_54], 80h
		jz	short loc_12456
		mov	bx, [bp+var_52]	; value	80..FF -> register 00..7F
		mov	si, ax
		and	si, 7Fh
		mov	al, scriptRAM[si]
		add	scriptRAM[bx], al ; scriptRAM[dstID] +=	scriptRAM[srcID]
		jmp	short loc_12460
; ---------------------------------------------------------------------------

loc_12456:				; CODE XREF: ExecuteScript+394j
		mov	bx, [bp+var_52]
		mov	al, byte ptr [bp+var_54]
		add	scriptRAM[bx], al ; scriptRAM[dstID] +=	srcValue

loc_12460:				; CODE XREF: ExecuteScript+3A6j
		jmp	scr_next
; ---------------------------------------------------------------------------

scr2F_VarSub:				; CODE XREF: ExecuteScript+116Ej
					; DATA XREF: ExecuteScript:scrJumpTblo
		call	ScrData_GetByte
		mov	[bp+var_52], ax	; destination register ID
		call	ScrData_GetByte
		mov	[bp+var_54], ax	; value
		test	byte ptr [bp+var_54], 80h
		jz	short loc_12487
		mov	bx, [bp+var_52]	; value	80..FF -> register 00..7F
		mov	si, ax
		and	si, 7Fh
		mov	al, scriptRAM[si]
		sub	scriptRAM[bx], al ; scriptRAM[dstID] -=	scriptRAM[srcID]
		jmp	short loc_12491
; ---------------------------------------------------------------------------

loc_12487:				; CODE XREF: ExecuteScript+3C5j
		mov	bx, [bp+var_52]	; value	00..7F -> raw value
		mov	al, byte ptr [bp+var_54]
		sub	scriptRAM[bx], al ; scriptRAM[dstID] -=	srcValue

loc_12491:				; CODE XREF: ExecuteScript+3D7j
		jmp	scr_next
; ---------------------------------------------------------------------------

scr08_Call:				; CODE XREF: ExecuteScript+116Ej
					; DATA XREF: ExecuteScript:scrJumpTblo
		call	ScrData_GetInt
		mov	[bp+var_50], ax
		push	ax
		call	scrCall
		add	sp, 2
		jmp	scr_next
; ---------------------------------------------------------------------------

scr32_Ret:				; CODE XREF: ExecuteScript+116Ej
					; DATA XREF: ExecuteScript:scrJumpTblo
		call	scrReturn
		jmp	scr_next
; ---------------------------------------------------------------------------

scr07_ChoiceStart:			; CODE XREF: ExecuteScript+116Ej
					; DATA XREF: ExecuteScript:scrJumpTblo
		call	sub_11246
		jmp	scr_next
; ---------------------------------------------------------------------------

scr04_Choice_1Str:			; CODE XREF: ExecuteScript+116Ej
					; DATA XREF: ExecuteScript:scrJumpTblo
		call	sub_11258
		jmp	scr_next
; ---------------------------------------------------------------------------

scr05_ChoiceExec:			; CODE XREF: ExecuteScript+116Ej
					; DATA XREF: ExecuteScript:scrJumpTblo
		call	sub_11296
		jmp	scr_next
; ---------------------------------------------------------------------------

scr06_Choice_MultiStr:			; CODE XREF: ExecuteScript+116Ej
					; DATA XREF: ExecuteScript:scrJumpTblo
		call	sub_11498
		jmp	scr_next
; ---------------------------------------------------------------------------

loc_124C2:				; CODE XREF: ExecuteScript+116Ej
					; DATA XREF: ExecuteScript:scrJumpTblo
		cmp	word_1AB4C, 0
		jz	short loc_124EF
		mov	word_1B0E0, 1
		mov	[bp+var_42], 1
		cmp	debugMode, 0
		jz	short loc_124E5
		mov	ax, offset aNoQessoffBefor ; "\nno QessOff befor qesStart\n"
		push	ax		; char *
		call	_printf
		add	sp, 2

loc_124E5:				; CODE XREF: ExecuteScript+42Bj
		mov	[bp+var_44], 1Ch
		jmp	scr_next
; ---------------------------------------------------------------------------
		jmp	short cmd1C_Quit2
; ---------------------------------------------------------------------------

loc_124EF:				; CODE XREF: ExecuteScript+419j
		mov	word_1AB4C, 1
		call	sub_1098C
		jmp	scr_next
; ---------------------------------------------------------------------------

cmd1C_Quit2:				; CODE XREF: ExecuteScript+43Fj
					; ExecuteScript+116Ej
					; DATA XREF: ...
		mov	word_1AB4C, 0
		mov	[bp+var_42], 1
		jmp	scr_next
; ---------------------------------------------------------------------------

loc_12509:				; CODE XREF: ExecuteScript+116Ej
					; DATA XREF: ExecuteScript:scrJumpTblo
		call	sub_10A07
		jmp	scr_next
; ---------------------------------------------------------------------------

cmd1B_Quit:				; CODE XREF: ExecuteScript+116Ej
					; DATA XREF: ExecuteScript:scrJumpTblo
		mov	[bp+var_42], 1
		jmp	scr_next
; ---------------------------------------------------------------------------

loc_12517:				; CODE XREF: ExecuteScript+116Ej
					; DATA XREF: ExecuteScript:scrJumpTblo
		call	sub_10A4B
		jmp	scr_next
; ---------------------------------------------------------------------------

loc_1251D:				; CODE XREF: ExecuteScript+116Ej
					; DATA XREF: ExecuteScript:scrJumpTblo
		call	sub_184DF
		mov	word_1C338, 0FFFFh
		mov	word_1C33E, 0FFFFh
		mov	word_1C98A, 0FFFFh
		mov	word_1C348, 0FFFFh
		mov	ax, word ptr dword_1C334
		mov	dx, word ptr dword_1C334+2
		mov	word_1C34A, ax
		mov	word_1C34C, dx
		cmp	word_1AB4E, 0
		jnz	short loc_1255E
		push	dx
		push	ax
		mov	ax, offset aDKasuke_pbd	; "d:kasuke.pbd"
		push	ax
		call	LoadFile
		add	sp, 6
		mov	[bp+var_50], ax
		jmp	short loc_12563
; ---------------------------------------------------------------------------

loc_1255E:				; CODE XREF: ExecuteScript+49Dj
		mov	[bp+var_50], 0

loc_12563:				; CODE XREF: ExecuteScript+4AEj
		mov	ax, [bp+var_50]
		add	ax, word ptr dword_1C334
		mov	dx, word ptr dword_1C334+2
		mov	word_1C98C, ax
		mov	word_1C98E, dx
		mov	ax, offset StringBuffer
		push	ax
		call	ScrData_Str2Buf
		add	sp, 2
		push	word_1C98E
		push	word_1C98C
		mov	ax, offset StringBuffer
		push	ax
		call	LoadFile
		add	sp, 6
		mov	[bp+var_50], ax
		add	ax, word_1C98C
		mov	dx, word_1C98E
		mov	word_1C33A, ax
		mov	word_1C33C, dx
		jmp	scr_next
; ---------------------------------------------------------------------------

loc_125A6:				; CODE XREF: ExecuteScript+116Ej
					; DATA XREF: ExecuteScript:scrJumpTblo
		mov	ax, offset StringBuffer
		push	ax
		call	ScrData_Str2Buf
		add	sp, 2
		mov	ax, offset StringBuffer
		push	ax		; char *
		call	sub_103B0
		add	sp, 2
		jmp	scr_next
; ---------------------------------------------------------------------------

loc_125BD:				; CODE XREF: ExecuteScript+116Ej
					; DATA XREF: ExecuteScript:scrJumpTblo
		mov	ax, offset StringBuffer
		push	ax
		call	ScrData_Str2Buf
		add	sp, 2
		call	ScrData_GetByte
		mov	[bp+var_54], ax
		push	ax
		mov	ax, offset StringBuffer
		push	ax
		call	sub_1845F
		add	sp, 4
		jmp	scr_next
; ---------------------------------------------------------------------------

loc_125DB:				; CODE XREF: ExecuteScript+116Ej
					; DATA XREF: ExecuteScript:scrJumpTblo
		mov	ax, offset StringBuffer
		push	ax
		call	ScrData_Str2Buf
		add	sp, 2
		cmp	word_1C338, 0FFFFh
		jnz	short loc_12618
		push	word_1C33C
		push	word_1C33A
		mov	ax, offset StringBuffer
		push	ax
		call	LoadFile
		add	sp, 6
		mov	[bp+var_50], ax
		mov	word_1C338, 0
		add	ax, word_1C33A
		mov	dx, word_1C33C
		mov	word_1C340, ax
		mov	word_1C342, dx
		jmp	short loc_12633
; ---------------------------------------------------------------------------

loc_12618:				; CODE XREF: ExecuteScript+53Cj
		push	word_1C342
		push	word_1C340
		mov	ax, offset StringBuffer
		push	ax
		call	LoadFile
		add	sp, 6
		mov	[bp+var_50], ax
		mov	word_1C33E, 0

loc_12633:				; CODE XREF: ExecuteScript+568j
		jmp	scr_next
; ---------------------------------------------------------------------------

scr12_PlayBGM:				; CODE XREF: ExecuteScript+116Ej
					; DATA XREF: ExecuteScript:scrJumpTblo
		mov	ax, offset StringBuffer
		push	ax
		call	ScrData_Str2Buf
		add	sp, 2
		mov	ax, offset StringBuffer
		push	ax
		call	PlayBGM
		add	sp, 2
		jmp	scr_next
; ---------------------------------------------------------------------------

loc_1264D:				; CODE XREF: ExecuteScript+116Ej
					; DATA XREF: ExecuteScript:scrJumpTblo
		mov	ax, offset StringBuffer
		push	ax
		call	ScrData_Str2Buf
		add	sp, 2
		call	ScrData_GetInt
		mov	[bp+var_4A], ax
		call	ScrData_GetInt
		mov	[bp+var_4C], ax
		cmp	[bp+var_4A], 280h
		jg	short loc_126C5
		push	word ptr dword_1C31A+2
		push	word ptr dword_1C31A
		mov	ax, offset StringBuffer
		push	ax
		call	LoadFile
		add	sp, 6
		mov	[bp+var_50], ax
		mov	ax, word ptr dword_1C31A
		mov	dx, word ptr dword_1C31A+2
		add	ax, 8
		mov	word ptr dword_1C344, ax
		mov	word ptr dword_1C344+2,	dx
		mov	ax, 0C8h ; 'È'
		push	ax
		mov	ax, 36h	; '6'
		push	ax
		push	word ptr dword_1BCDC+2
		push	word ptr dword_1BCDC
		sub	ax, ax
		push	ax
		push	ax
		les	bx, dword_1C344
		mov	ax, es:[bx]
		add	ax, word ptr dword_1C31A
		push	dx
		push	ax
		call	sub_18171
		add	sp, 10h
		push	[bp+var_4C]
		push	[bp+var_4A]
		call	sub_13AFC
		add	sp, 4
		jmp	short loc_126E1
; ---------------------------------------------------------------------------

loc_126C5:				; CODE XREF: ExecuteScript+5BAj
		mov	bx, [bp+var_4C]
		shl	bx, 1
		shl	bx, 1
		push	word ptr (dword_1C31A+2)[bx]
		push	word ptr dword_1C31A[bx]
		mov	ax, offset StringBuffer
		push	ax
		call	LoadFile
		add	sp, 6
		mov	[bp+var_50], ax

loc_126E1:				; CODE XREF: ExecuteScript+615j
		jmp	scr_next
; ---------------------------------------------------------------------------

scr03:					; CODE XREF: ExecuteScript+116Ej
					; DATA XREF: ExecuteScript:scrJumpTblo
		call	ScrData_GetByte
		mov	[bp+var_54], ax
		call	ScrData_GetByte
		mov	[bp+var_52], ax
		call	ScrData_GetByte
		mov	[bp+var_46], ax
		cmp	ax, 0FFh
		jnz	short loc_1270A
		push	ax
		push	[bp+var_52]
		push	[bp+var_54]
		call	sub_14741
		add	sp, 6
		jmp	short loc_12719
; ---------------------------------------------------------------------------

loc_1270A:				; CODE XREF: ExecuteScript+64Bj
		push	[bp+var_46]
		push	[bp+var_52]
		push	[bp+var_54]
		call	sub_14635
		add	sp, 6

loc_12719:				; CODE XREF: ExecuteScript+65Aj
		jmp	scr_next
; ---------------------------------------------------------------------------

loc_1271C:				; CODE XREF: ExecuteScript+116Ej
					; DATA XREF: ExecuteScript:scrJumpTblo
		call	ScrData_GetByte
		mov	[bp+var_54], ax
		push	ax
		call	sub_137E8
		add	sp, 2
		mov	ax, 0FFFFh
		push	ax
		push	ax
		call	sub_13AFC
		add	sp, 4
		jmp	scr_next
; ---------------------------------------------------------------------------

scr2A_Wait:				; CODE XREF: ExecuteScript+116Ej
					; DATA XREF: ExecuteScript:scrJumpTblo
		call	ScrData_GetByte
		mov	[bp+var_54], ax
		push	ax
		call	WaitFrames	; wait N frames
		add	sp, 2
		jmp	scr_next
; ---------------------------------------------------------------------------

loc_12747:				; CODE XREF: ExecuteScript+116Ej
					; DATA XREF: ExecuteScript:scrJumpTblo
		call	ScrData_GetByte
		mov	[bp+var_54], ax
		cmp	ax, 100
		jnz	short loc_1275B
		push	ax
		call	sub_1776F
		add	sp, 2
		jmp	short loc_12764
; ---------------------------------------------------------------------------

loc_1275B:				; CODE XREF: ExecuteScript+6A2j
		push	[bp+var_54]
		call	sub_17673
		add	sp, 2

loc_12764:				; CODE XREF: ExecuteScript+6ABj
		jmp	scr_next
; ---------------------------------------------------------------------------

scr37_SetPalColor:			; CODE XREF: ExecuteScript+116Ej
					; DATA XREF: ExecuteScript:scrJumpTblo
		call	ScrData_GetByte
		mov	[bp+var_54], ax
		call	ScrData_GetByte
		mov	bx, [bp+var_54]
		mov	cx, bx
		shl	bx, 1
		add	bx, cx
		mov	PalTarget[bx], al
		call	ScrData_GetByte
		mov	bx, [bp+var_54]
		mov	cx, bx
		shl	bx, 1
		add	bx, cx
		mov	(PalTarget+1)[bx], al
		call	ScrData_GetByte
		mov	bx, [bp+var_54]
		mov	cx, bx
		shl	bx, 1
		add	bx, cx
		mov	(PalTarget+2)[bx], al
		jmp	scr_next
; ---------------------------------------------------------------------------

loc_127A0:				; CODE XREF: ExecuteScript+116Ej
					; DATA XREF: ExecuteScript:scrJumpTblo
		call	ScrData_GetByte
		mov	[bp+var_54], ax
		sub	ax, ax
		push	ax
		call	SetGDCPlane_Wrt
		add	sp, 2
		push	[bp+var_54]
		call	sub_17857
		add	sp, 2
		jmp	scr_next
; ---------------------------------------------------------------------------

scr38_PalFade:				; CODE XREF: ExecuteScript+116Ej
					; DATA XREF: ExecuteScript:scrJumpTblo
		call	ScrData_GetByte
		mov	[bp+var_54], ax	; fade speed (number of	frames per fade	step): 0 = fast, 255 = slow
		push	ax
		call	SetTargetPal
		add	sp, 2
		jmp	scr_next
; ---------------------------------------------------------------------------

scr20_Location0:			; CODE XREF: ExecuteScript+116Ej
					; DATA XREF: ExecuteScript:scrJumpTblo
		mov	bgmIsPlaying, 0
		mov	ax, 99
		push	ax
		call	CallMusicDriver	; MUSDRV call 99 - stop	music
		add	sp, 2
		sub	ax, ax
		push	ax
		push	ax
		call	ShowLocationName
		add	sp, 4
		jmp	scr_next
; ---------------------------------------------------------------------------

scr21_Location1:			; CODE XREF: ExecuteScript+116Ej
					; DATA XREF: ExecuteScript:scrJumpTblo
		mov	bgmIsPlaying, 1
		sub	ax, ax
		push	ax
		push	ax
		call	ShowLocationName
		add	sp, 4
		jmp	scr_next
; ---------------------------------------------------------------------------
		jmp	scr_next
; ---------------------------------------------------------------------------

scr_undefined:				; CODE XREF: ExecuteScript+1168j
					; ExecuteScript+116Ej
					; DATA XREF: ...
		cmp	debugMode, 0
		jz	short loc_12815
		push	[bp+var_44]
		push	[bp+var_44]
		mov	ax, offset aNotDefineFunct ; "\nNot Define Function code=%d:%x\n"
		push	ax		; char *
		call	_printf
		add	sp, 6

loc_12815:				; CODE XREF: ExecuteScript+755j
		mov	[bp+var_42], 1
		jmp	scr_next
; ---------------------------------------------------------------------------

scr34_MetaCmd:				; CODE XREF: ExecuteScript+116Ej
					; DATA XREF: ExecuteScript:scrJumpTblo
		call	ScrData_GetByte
		mov	[bp+var_54], ax
		cmp	debugMode, 0
		jz	short loc_12835
		push	ax
		mov	ax, offset a2d	; "+(%2d)"
		push	ax		; char *
		call	_printf
		add	sp, 4

loc_12835:				; CODE XREF: ExecuteScript+77Aj
		mov	ax, [bp+var_54]
		jmp	DoMetaCommand
; ---------------------------------------------------------------------------

loc_1283B:				; CODE XREF: ExecuteScript+109Fj
					; DATA XREF: ExecuteScript:metaJumpTblo
		call	sub_10D1A
		jmp	j_scr_next
; ---------------------------------------------------------------------------

loc_12841:				; CODE XREF: ExecuteScript+109Fj
					; DATA XREF: ExecuteScript:metaJumpTblo
		call	ScrData_GetByte
		dec	ax
		mov	[bp+var_52], ax
		push	ax
		call	sub_10D6C
		add	sp, 2
		jmp	j_scr_next
; ---------------------------------------------------------------------------

loc_12852:				; CODE XREF: ExecuteScript+109Fj
					; DATA XREF: ExecuteScript:metaJumpTblo
		call	ScrData_GetByte
		dec	ax
		mov	[bp+var_52], ax
		call	ScrData_GetByte
		mov	[bp+var_48], ax
		push	[bp+var_52]
		call	sub_110EF
		add	sp, 2
		mov	bx, [bp+var_48]
		mov	scriptRAM[bx], al
		jmp	j_scr_next
; ---------------------------------------------------------------------------

loc_12872:				; CODE XREF: ExecuteScript+109Fj
					; DATA XREF: ExecuteScript:metaJumpTblo
		sub	ax, ax
		push	ax
		mov	ax, 5
		push	ax
		call	ShowLocationName
		add	sp, 4
		jmp	j_scr_next
; ---------------------------------------------------------------------------

loc_12882:				; CODE XREF: ExecuteScript+109Fj
					; DATA XREF: ExecuteScript:metaJumpTblo
		call	ScrData_GetByte
		dec	ax
		mov	[bp+var_52], ax
		push	ax
		call	sub_111CF
		add	sp, 2
		jmp	j_scr_next
; ---------------------------------------------------------------------------

loc_12893:				; CODE XREF: ExecuteScript+109Fj
					; DATA XREF: ExecuteScript:metaJumpTblo
		call	ScrData_GetByte
		mov	word_1AB58, ax
		mov	word_1AB56, 0
		call	ScrData_GetByte
		mov	word_1AB5A, ax
		jmp	j_scr_next
; ---------------------------------------------------------------------------

loc_128A8:				; CODE XREF: ExecuteScript+109Fj
					; DATA XREF: ExecuteScript:metaJumpTblo
		call	ScrData_GetByte
		mov	[bp+var_52], ax
		push	ax
		call	sub_11CDB
		add	sp, 2
		jmp	j_scr_next
; ---------------------------------------------------------------------------

loc_128B8:				; CODE XREF: ExecuteScript+109Fj
					; DATA XREF: ExecuteScript:metaJumpTblo
		call	ScrData_GetByte
		mov	[bp+var_52], ax
		push	ax
		call	sub_11D81
		add	sp, 2
		jmp	j_scr_next
; ---------------------------------------------------------------------------

loc_128C8:				; CODE XREF: ExecuteScript+109Fj
					; DATA XREF: ExecuteScript:metaJumpTblo
		call	ScrData_GetByte
		mov	[bp+var_52], ax
		call	ScrData_GetInt
		mov	[bp+var_54], ax
		push	ax
		push	[bp+var_52]
		call	sub_185C1
		add	sp, 4
		jmp	j_scr_next
; ---------------------------------------------------------------------------

loc_128E1:				; CODE XREF: ExecuteScript+109Fj
					; DATA XREF: ExecuteScript:metaJumpTblo
		call	ScrData_GetByte
		mov	[bp+var_52], ax
		push	ax
		call	sub_11DF6
		add	sp, 2
		jmp	j_scr_next
; ---------------------------------------------------------------------------

loc_128F1:				; CODE XREF: ExecuteScript+109Fj
					; DATA XREF: ExecuteScript:metaJumpTblo
		mov	ax, offset StringBuffer
		push	ax
		call	ScrData_Str2Buf
		add	sp, 2
		mov	word_1C338, 0FFFFh
		mov	word_1C33E, 0FFFFh
		mov	word_1C98A, 0FFFFh
		mov	word_1C348, 0FFFFh
		push	word ptr dword_1C334+2
		push	word ptr dword_1C334
		mov	ax, offset StringBuffer
		push	ax
		call	LoadFile
		add	sp, 6
		mov	[bp+var_50], ax
		add	ax, word ptr dword_1C334
		mov	dx, word ptr dword_1C334+2
		mov	word_1C33A, ax
		mov	word_1C33C, dx
		jmp	j_scr_next
; ---------------------------------------------------------------------------

mscr12_PrintX:				; CODE XREF: ExecuteScript+109Fj
					; DATA XREF: ExecuteScript:metaJumpTblo
		call	ScrData_GetByte
		mov	[bp+var_52], ax
		mov	word_1B564, ax	; X coordinate
		mov	word_1B566, 21	; Y coordinate
		mov	ax, offset StringBuffer
		push	ax
		call	ScrData_Str2Buf
		add	sp, 2
		cmp	[bp+var_52], 0
		jz	short loc_1296B
		mov	ax, offset StringBuffer
		push	ax
		push	word_1B566
		push	word_1B564
		call	DrawTextF_Opts
		add	sp, 6

loc_1296B:				; CODE XREF: ExecuteScript+8A9j
		call	sub_17610
		jmp	j_scr_next
; ---------------------------------------------------------------------------

mscr14_PrintXY:				; CODE XREF: ExecuteScript+109Fj
					; DATA XREF: ExecuteScript:metaJumpTblo
		call	ScrData_GetByte
		mov	[bp+var_52], ax
		mov	word_1B564, ax	; X coordinate
		call	ScrData_GetByte
		mov	[bp+var_52], ax
		mov	word_1B566, ax	; Y coordinate
		mov	ax, offset StringBuffer
		push	ax
		call	ScrData_Str2Buf
		add	sp, 2
		mov	ax, offset StringBuffer
		push	ax
		push	word_1B566
		push	word_1B564
		call	DrawTextF_Opts
		add	sp, 6
		jmp	j_scr_next
; ---------------------------------------------------------------------------

loc_129A2:				; CODE XREF: ExecuteScript+109Fj
					; DATA XREF: ExecuteScript:metaJumpTblo
		call	ScrData_GetByte
		mov	[bp+var_52], ax
		mov	word_1AB4E, ax
		jmp	j_scr_next
; ---------------------------------------------------------------------------

mscr17_FileWait:			; CODE XREF: ExecuteScript+109Fj
					; DATA XREF: ExecuteScript:metaJumpTblo
		mov	ax, offset StringBuffer
		push	ax
		call	ScrData_Str2Buf
		add	sp, 2
		mov	ax, offset StringBuffer
		push	ax		; char *
		call	LoadFile2
		add	sp, 2
		jmp	j_scr_next
; ---------------------------------------------------------------------------

mscr18_SaveGame:			; CODE XREF: ExecuteScript+109Fj
					; DATA XREF: ExecuteScript:metaJumpTblo
		call	ScrData_GetByte
		mov	[bp+var_52], ax	; read/write mode
		or	ax, ax
		jnz	short loc_129D4
		call	ReadSaveGame	; 0 = read
		jmp	short loc_129DD
; ---------------------------------------------------------------------------

loc_129D4:				; CODE XREF: ExecuteScript+91Fj
		push	[bp+var_52]
		call	WriteSaveGame	; 1 = write, 2 = clear + write
		add	sp, 2

loc_129DD:				; CODE XREF: ExecuteScript+924j
		jmp	j_scr_next
; ---------------------------------------------------------------------------

loc_129E0:				; CODE XREF: ExecuteScript+109Fj
					; DATA XREF: ExecuteScript:metaJumpTblo
		call	ScrData_GetByte
		mov	[bp+var_52], ax
		push	ax
		call	sub_12080
		add	sp, 2
		jmp	j_scr_next
; ---------------------------------------------------------------------------

mscr1E_LoadImg:				; CODE XREF: ExecuteScript+109Fj
					; DATA XREF: ExecuteScript:metaJumpTblo
		mov	ax, offset StringBuffer
		push	ax
		call	ScrData_Str2Buf
		add	sp, 2
		call	ScrData_GetInt
		mov	[bp+var_4A], ax
		call	ScrData_GetInt
		mov	[bp+var_4C], ax
		push	ax
		push	[bp+var_4A]
		mov	ax, offset StringBuffer
		push	ax
		call	sub_182D9
		add	sp, 6
		jmp	j_scr_next
; ---------------------------------------------------------------------------

loc_12A17:				; CODE XREF: ExecuteScript+109Fj
					; DATA XREF: ExecuteScript:metaJumpTblo
		call	DoSomeGDCFill
		jmp	j_scr_next
; ---------------------------------------------------------------------------

loc_12A1D:				; CODE XREF: ExecuteScript+109Fj
					; DATA XREF: ExecuteScript:metaJumpTblo
		mov	word_1ACAA, 1
		jmp	j_scr_next
; ---------------------------------------------------------------------------

loc_12A26:				; CODE XREF: ExecuteScript+109Fj
					; DATA XREF: ExecuteScript:metaJumpTblo
		mov	word_1ACAA, 0
		jmp	j_scr_next
; ---------------------------------------------------------------------------

loc_12A2F:				; CODE XREF: ExecuteScript+109Fj
					; DATA XREF: ExecuteScript:metaJumpTblo
		call	ScrData_GetByte
		mov	[bp+var_4A], ax
		call	ScrData_GetByte
		mov	[bp+var_4C], ax
		mov	ax, word ptr dword_1C31A
		mov	dx, word ptr dword_1C31A+2
		add	ax, 8
		mov	word ptr dword_1C344, ax
		mov	word ptr dword_1C344+2,	dx
		mov	ax, 0C8h ; 'È'
		push	ax
		mov	ax, 36h	; '6'
		push	ax
		push	word ptr dword_1BCDC+2
		push	word ptr dword_1BCDC
		sub	ax, ax
		push	ax
		push	ax
		les	bx, dword_1C344
		mov	ax, es:[bx]
		add	ax, word ptr dword_1C31A
		push	dx
		push	ax
		call	sub_18171
		add	sp, 10h
		push	[bp+var_4C]
		mov	ax, [bp+var_4A]
		dec	ax
		push	ax
		call	sub_144C9
		add	sp, 4
		mov	ax, 2Eh	; '.'
		push	ax
		mov	ax, 4
		push	ax
		call	sub_105EA
		add	sp, 4
		mov	ax, 2Eh	; '.'
		push	ax
		mov	ax, 20h	; ' '
		push	ax
		call	sub_13AFC
		add	sp, 4
		mov	ax, word ptr dword_1C31A
		mov	dx, word ptr dword_1C31A+2
		add	ax, 8
		mov	word ptr dword_1C344, ax
		mov	word ptr dword_1C344+2,	dx
		mov	ax, 0C8h ; 'È'
		push	ax
		mov	ax, 36h	; '6'
		push	ax
		push	word ptr dword_1BCDC+2
		push	word ptr dword_1BCDC
		sub	ax, ax
		push	ax
		push	ax
		les	bx, dword_1C344
		mov	ax, es:[bx]
		add	ax, word ptr dword_1C31A
		push	dx
		push	ax
		call	sub_18171
		add	sp, 10h
		jmp	j_scr_next
; ---------------------------------------------------------------------------

mscr23_FileExist:			; CODE XREF: ExecuteScript+109Fj
					; DATA XREF: ExecuteScript:metaJumpTblo
		mov	ax, offset StringBuffer
		push	ax
		call	ScrData_Str2Buf
		add	sp, 2
		call	ScrData_GetByte
		mov	[bp+var_52], ax	; destination register ID
		mov	ax, offset StringBuffer
		push	ax		; char *
		call	CheckFileExist
		add	sp, 2
		mov	bx, [bp+var_52]
		and	bx, 7Fh
		mov	scriptRAM[bx], al
		jmp	j_scr_next
; ---------------------------------------------------------------------------

loc_12AFF:				; CODE XREF: ExecuteScript+109Fj
					; DATA XREF: ExecuteScript:metaJumpTblo
		call	ScrData_GetByte
		mov	[bp+var_52], ax
		call	ScrData_GetByte
		mov	[bp+var_4C], ax
		mov	ax, word ptr dword_1C31A
		mov	dx, word ptr dword_1C31A+2
		add	ax, 10h
		mov	word ptr dword_1C344, ax
		mov	word ptr dword_1C344+2,	dx
		mov	ax, 0C8h ; 'È'
		push	ax
		mov	ax, 36h	; '6'
		push	ax
		push	word_1C324
		push	word_1C322
		sub	ax, ax
		push	ax
		push	ax
		les	bx, dword_1C344
		mov	ax, es:[bx]
		add	ax, word ptr dword_1C31A
		push	dx
		push	ax
		call	sub_18171
		add	sp, 10h
		mov	ax, word ptr dword_1C31A
		mov	dx, word ptr dword_1C31A+2
		add	ax, 18h
		mov	word ptr dword_1C344, ax
		mov	word ptr dword_1C344+2,	dx
		mov	ax, 0C8h ; 'È'
		push	ax
		mov	ax, 36h	; '6'
		push	ax
		push	word_1C328
		push	word_1C326
		sub	ax, ax
		push	ax
		push	ax
		les	bx, dword_1C344
		mov	ax, es:[bx]
		add	ax, word ptr dword_1C31A
		push	dx
		push	ax
		call	sub_18171
		add	sp, 10h
		mov	ax, [bp+var_52]
		mov	word_1AB44, ax
		push	[bp+var_4C]
		sub	ax, ax
		push	ax
		call	sub_140FF
		add	sp, 4

loc_12B8D:				; CODE XREF: ExecuteScript+AE6j
		cmp	word_1AB44, 0
		jz	short loc_12B96
		jmp	short loc_12B8D
; ---------------------------------------------------------------------------

loc_12B96:				; CODE XREF: ExecuteScript+AE4j
					; ExecuteScript+B08j
		push	[bp+var_4C]
		mov	ax, 1
		push	ax
		call	sub_140FF
		add	sp, 4
		or	ax, ax
		jz	short loc_12BB8

loc_12BA7:				; CODE XREF: ExecuteScript+B00j
		cmp	word_1AB44, 0
		jz	short loc_12BB0
		jmp	short loc_12BA7
; ---------------------------------------------------------------------------

loc_12BB0:				; CODE XREF: ExecuteScript+AFEj
		mov	ax, [bp+var_52]
		mov	word_1AB44, ax
		jmp	short loc_12B96
; ---------------------------------------------------------------------------

loc_12BB8:				; CODE XREF: ExecuteScript+AF7j
		jmp	j_scr_next
; ---------------------------------------------------------------------------

loc_12BBB:				; CODE XREF: ExecuteScript+109Fj
					; DATA XREF: ExecuteScript:metaJumpTblo
		mov	ax, offset StringBuffer
		push	ax
		call	ScrData_Str2Buf
		add	sp, 2
		call	ScrData_GetByte
		mov	[bp+var_54], ax
		call	ScrData_GetInt
		mov	[bp+var_4A], ax
		call	ScrData_GetInt
		mov	[bp+var_4C], ax
		push	word ptr dword_1C31A+2
		push	word ptr dword_1C31A
		mov	ax, offset StringBuffer
		push	ax
		call	LoadFile
		add	sp, 6
		mov	[bp+var_50], ax
		mov	ax, 1
		push	ax
		call	SetGDCPlane_Wrt
		add	sp, 2
		mov	ax, [bp+var_54]
		mov	[bp+var_52], ax
		jmp	short loc_12C01
; ---------------------------------------------------------------------------

loc_12BFE:				; CODE XREF: ExecuteScript+BA9j
		inc	[bp+var_52]

loc_12C01:				; CODE XREF: ExecuteScript+B4Ej
		mov	ax, [bp+var_54]
		add	ax, 36h	; '6'
		cmp	ax, [bp+var_52]
		jle	short loc_12C59
		mov	ax, [bp+var_52]
		mov	cl, 3
		shl	ax, cl
		add	ax, word ptr dword_1C31A
		mov	dx, word ptr dword_1C31A+2
		add	ax, 8
		mov	word ptr dword_1C344, ax
		mov	word ptr dword_1C344+2,	dx
		push	[bp+var_4C]
		mov	ax, [bp+var_4A]
		cwd
		xor	ax, dx
		sub	ax, dx
		mov	cx, 3
		sar	ax, cl
		xor	ax, dx
		sub	ax, dx
		add	ax, [bp+var_52]
		sub	ax, [bp+var_54]
		push	ax
		les	bx, dword_1C344
		mov	ax, es:[bx]
		add	ax, word ptr dword_1C31A
		mov	dx, word ptr dword_1C31A+2
		push	dx
		push	ax
		call	sub_18031
		add	sp, 8
		jmp	short loc_12BFE
; ---------------------------------------------------------------------------

loc_12C59:				; CODE XREF: ExecuteScript+B5Cj
		cmp	[bp+var_4A], 20h ; ' '
		jnz	short loc_12C62
		call	sub_13F11

loc_12C62:				; CODE XREF: ExecuteScript+BAFj
		push	[bp+var_4C]
		mov	ax, [bp+var_4A]
		cwd
		xor	ax, dx
		sub	ax, dx
		mov	cx, 3
		sar	ax, cl
		xor	ax, dx
		sub	ax, dx
		push	ax
		call	sub_105EA
		add	sp, 4
		push	[bp+var_4C]
		push	[bp+var_4A]
		call	sub_13AFC
		add	sp, 4
		mov	ax, [bp+var_54]
		mov	word_1B6B8, ax
		jmp	j_scr_next
; ---------------------------------------------------------------------------

loc_12C92:				; CODE XREF: ExecuteScript+109Fj
					; DATA XREF: ExecuteScript:metaJumpTblo
		call	ScrData_GetByte
		mov	[bp+var_4A], ax
		call	ScrData_GetByte
		mov	[bp+var_52], ax
		mov	ax, word_1B6B8
		cmp	[bp+var_4A], ax
		jle	short loc_12CAD
		mov	[bp+var_54], 1
		jmp	short loc_12CB2
; ---------------------------------------------------------------------------

loc_12CAD:				; CODE XREF: ExecuteScript+BF6j
		mov	[bp+var_54], 0

loc_12CB2:				; CODE XREF: ExecuteScript+BFDj
		push	[bp+var_54]
		push	word_1B6B8
		call	sub_1332F
		add	sp, 4
		mov	ax, [bp+var_52]
		mov	word_1AB44, ax

loc_12CC5:				; CODE XREF: ExecuteScript+C1Ej
		cmp	word_1AB44, 0
		jz	short loc_12CCE
		jmp	short loc_12CC5
; ---------------------------------------------------------------------------

loc_12CCE:				; CODE XREF: ExecuteScript+C1Cj
					; ExecuteScript+C3Fj
		push	[bp+var_54]
		push	[bp+var_4A]
		call	sub_13505
		add	sp, 4
		or	ax, ax
		jz	short loc_12CEF

loc_12CDE:				; CODE XREF: ExecuteScript+C37j
		cmp	word_1AB44, 0
		jz	short loc_12CE7
		jmp	short loc_12CDE
; ---------------------------------------------------------------------------

loc_12CE7:				; CODE XREF: ExecuteScript+C35j
		mov	ax, [bp+var_52]
		mov	word_1AB44, ax
		jmp	short loc_12CCE
; ---------------------------------------------------------------------------

loc_12CEF:				; CODE XREF: ExecuteScript+C2Ej
		jmp	j_scr_next
; ---------------------------------------------------------------------------

loc_12CF2:				; CODE XREF: ExecuteScript+109Fj
					; DATA XREF: ExecuteScript:metaJumpTblo
		mov	ax, offset StringBuffer
		push	ax
		call	ScrData_Str2Buf
		add	sp, 2
		push	word ptr dword_1C31A+2
		push	word ptr dword_1C31A
		mov	ax, offset StringBuffer
		push	ax
		call	LoadFile
		add	sp, 6
		mov	ax, word ptr dword_1C31A
		mov	dx, word ptr dword_1C31A+2
		add	ax, 8
		mov	word ptr dword_1C344, ax
		mov	word ptr dword_1C344+2,	dx
		push	word_1BCBC
		push	word_1BCBA
		sub	ax, ax
		push	ax
		push	ax
		les	bx, dword_1C344
		mov	ax, es:[bx]
		add	ax, word ptr dword_1C31A
		push	dx
		push	ax
		call	sub_18093
		add	sp, 0Ch
		mov	es, seg_1B488
		assume es:seg001
		mov	ax, word ptr dword_1C344
		mov	dx, word ptr dword_1C344+2
		mov	di, 0
		mov	si, ax
		push	ds
		mov	ds, dx
		movsw
		movsw
		movsw
		movsw
		pop	ds
		jmp	j_scr_next
; ---------------------------------------------------------------------------

loc_12D59:				; CODE XREF: ExecuteScript+109Fj
					; DATA XREF: ExecuteScript:metaJumpTblo
		call	ScrData_GetByte
		mov	[bp+var_52], ax
		call	ScrData_GetByte
		mov	[bp+var_4C], ax
		mov	ax, word ptr dword_1C31A
		mov	dx, word ptr dword_1C31A+2
		add	ax, 8
		mov	word ptr dword_1C344, ax
		mov	word ptr dword_1C344+2,	dx
		mov	ax, 280h
		push	ax
		mov	ax, 11h
		push	ax
		push	word_1BF9A
		push	word_1BF98
		sub	ax, ax
		push	ax
		push	ax
		les	bx, dword_1C344
		assume es:nothing
		mov	ax, es:[bx]
		add	ax, word ptr dword_1C31A
		push	dx
		push	ax
		call	sub_18171
		add	sp, 10h
		mov	ax, word ptr dword_1C31A
		mov	dx, word ptr dword_1C31A+2
		add	ax, 10h
		mov	word ptr dword_1C344, ax
		mov	word ptr dword_1C344+2,	dx
		mov	ax, 280h
		push	ax
		mov	ax, 11h
		push	ax
		push	word_1BF9A
		push	word_1BF98
		mov	ax, 190h
		push	ax
		sub	ax, ax
		push	ax
		les	bx, dword_1C344
		mov	ax, es:[bx]
		add	ax, word ptr dword_1C31A
		push	dx
		push	ax
		call	sub_18171
		add	sp, 10h
		mov	es, seg_1B488
		assume es:seg001
		mov	ax, word ptr dword_1C344
		mov	dx, word ptr dword_1C344+2
		mov	di, 0
		mov	si, ax
		push	ds
		mov	ds, dx
		movsw
		movsw
		movsw
		movsw
		pop	ds
		mov	ax, [bp+var_52]
		mov	word_1AB44, ax
		push	[bp+var_4C]
		sub	ax, ax
		push	ax
		call	sub_141C7
		add	sp, 4

loc_12E02:				; CODE XREF: ExecuteScript+D5Bj
		cmp	word_1AB44, 0
		jz	short loc_12E0B
		jmp	short loc_12E02
; ---------------------------------------------------------------------------

loc_12E0B:				; CODE XREF: ExecuteScript+D59j
					; ExecuteScript+D7Dj
		push	[bp+var_4C]
		mov	ax, 1
		push	ax
		call	sub_141C7
		add	sp, 4
		or	ax, ax
		jz	short loc_12E2D

loc_12E1C:				; CODE XREF: ExecuteScript+D75j
		cmp	word_1AB44, 0
		jz	short loc_12E25
		jmp	short loc_12E1C
; ---------------------------------------------------------------------------

loc_12E25:				; CODE XREF: ExecuteScript+D73j
		mov	ax, [bp+var_52]
		mov	word_1AB44, ax
		jmp	short loc_12E0B
; ---------------------------------------------------------------------------

loc_12E2D:				; CODE XREF: ExecuteScript+D6Cj
		jmp	j_scr_next
; ---------------------------------------------------------------------------

loc_12E30:				; CODE XREF: ExecuteScript+109Fj
					; DATA XREF: ExecuteScript:metaJumpTblo
		call	ScrData_GetByte
		mov	[bp+var_52], ax
		call	ScrData_GetByte
		mov	[bp+var_4C], ax
		mov	ax, 1
		push	ax
		call	SetGDCPlane_Wrt
		add	sp, 2
		mov	ax, word ptr dword_1C31A
		mov	dx, word ptr dword_1C31A+2
		add	ax, 8
		mov	word ptr dword_1C344, ax
		mov	word ptr dword_1C344+2,	dx
		mov	ax, 0C8h ; 'È'
		push	ax
		mov	ax, 36h	; '6'
		push	ax
		push	word ptr dword_1BCDC+2
		push	word ptr dword_1BCDC
		sub	ax, ax
		push	ax
		push	ax
		les	bx, dword_1C344
		assume es:nothing
		mov	ax, es:[bx]
		add	ax, word ptr dword_1C31A
		push	dx
		push	ax
		call	sub_18171
		add	sp, 10h
		mov	ax, 3
		push	ax
		mov	ax, 36h	; '6'
		push	ax
		mov	ax, 2A30h
		push	ax
		mov	ax, 0E64h
		push	ax
		mov	ax, 0C8h ; 'È'
		push	ax
		mov	ax, 36h	; '6'
		push	ax
		push	word ptr dword_1BCDC+2
		push	word ptr dword_1BCDC
		call	sub_14F8F
		add	sp, 10h
		mov	ax, word ptr dword_1C31A
		mov	dx, word ptr dword_1C31A+2
		add	ax, 10h
		mov	word ptr dword_1C344, ax
		mov	word ptr dword_1C344+2,	dx
		push	word_1BF9A
		push	word_1BF98
		sub	ax, ax
		push	ax
		push	ax
		les	bx, dword_1C344
		mov	ax, es:[bx]
		add	ax, word ptr dword_1C31A
		push	dx
		push	ax
		call	sub_18093
		add	sp, 0Ch
		mov	[bp+var_4A], 1Eh
		les	bx, dword_1C344
		mov	al, es:[bx+2]
		sub	ah, ah
		add	ax, 17C4h
		push	ax
		push	word ptr es:[bx+6]
		mov	al, es:[bx+3]
		sub	ah, ah
		push	ax
		push	word_1BF9A
		push	word_1BF98
		call	sub_15D41
		add	sp, 0Ah
		mov	ax, 2Eh	; '.'
		push	ax
		mov	ax, 4
		push	ax
		call	sub_105EA
		add	sp, 4
		mov	ax, 2Eh	; '.'
		push	ax
		mov	ax, 20h	; ' '
		push	ax
		call	sub_13AFC
		add	sp, 4
		mov	ax, 1
		push	ax
		call	SetGDCPlane_Wrt
		add	sp, 2
		mov	ax, word ptr dword_1C31A
		mov	dx, word ptr dword_1C31A+2
		add	ax, 8
		mov	word ptr dword_1C344, ax
		mov	word ptr dword_1C344+2,	dx
		mov	ax, 0C8h ; 'È'
		push	ax
		mov	ax, 36h	; '6'
		push	ax
		push	word ptr dword_1BCDC+2
		push	word ptr dword_1BCDC
		sub	ax, ax
		push	ax
		push	ax
		les	bx, dword_1C344
		mov	ax, es:[bx]
		add	ax, word ptr dword_1C31A
		push	dx
		push	ax
		call	sub_18171
		add	sp, 10h
		mov	ax, word ptr dword_1C31A
		mov	dx, word ptr dword_1C31A+2
		add	ax, 10h
		mov	word ptr dword_1C344, ax
		mov	word ptr dword_1C344+2,	dx
		mov	[bp+var_4A], 1Eh
		jmp	short loc_12F7C
; ---------------------------------------------------------------------------

loc_12F76:				; CODE XREF: ExecuteScript+F45j
		mov	ax, [bp+var_4C]
		add	[bp+var_4A], ax

loc_12F7C:				; CODE XREF: ExecuteScript+EC6j
		cmp	[bp+var_4A], 78h ; 'x'
		jge	short loc_12FF5
		mov	ax, [bp+var_52]
		mov	word_1AB44, ax
		mov	ax, 1
		push	ax
		call	SetGDCPlane_Wrt
		add	sp, 2
		mov	ax, 3
		push	ax
		mov	ax, 36h	; '6'
		push	ax
		mov	ax, 2A30h
		push	ax
		mov	ax, 0E64h
		push	ax
		mov	ax, 0C8h ; 'È'
		push	ax
		mov	ax, 36h	; '6'
		push	ax
		push	word ptr dword_1BCDC+2
		push	word ptr dword_1BCDC
		call	sub_14F8F
		add	sp, 10h
		mov	ax, 50h	; 'P'
		imul	[bp+var_4A]
		les	bx, dword_1C344
		mov	cl, es:[bx+2]
		sub	ch, ch
		add	ax, cx
		add	ax, 0E64h
		push	ax
		push	word ptr es:[bx+6]
		mov	al, es:[bx+3]
		sub	ah, ah
		push	ax
		push	word_1BF9A
		push	word_1BF98
		call	sub_15D41
		add	sp, 0Ah

loc_12FE7:				; CODE XREF: ExecuteScript+F40j
		cmp	word_1AB44, 0
		jz	short loc_12FF0
		jmp	short loc_12FE7
; ---------------------------------------------------------------------------

loc_12FF0:				; CODE XREF: ExecuteScript+F3Ej
		call	SwapGDCPlanes
		jmp	short loc_12F76
; ---------------------------------------------------------------------------

loc_12FF5:				; CODE XREF: ExecuteScript+ED2j
		jmp	j_scr_next
; ---------------------------------------------------------------------------

loc_12FF8:				; CODE XREF: ExecuteScript+109Fj
					; DATA XREF: ExecuteScript:metaJumpTblo
		mov	word_1AB52, 1
		jmp	j_scr_next
; ---------------------------------------------------------------------------

loc_13001:				; CODE XREF: ExecuteScript+109Fj
					; DATA XREF: ExecuteScript:metaJumpTblo
		mov	word_1AB52, 0
		jmp	j_scr_next
; ---------------------------------------------------------------------------

loc_1300A:				; CODE XREF: ExecuteScript+109Fj
					; DATA XREF: ExecuteScript:metaJumpTblo
		call	sub_13F8C
		jmp	j_scr_next
; ---------------------------------------------------------------------------

loc_13010:				; CODE XREF: ExecuteScript+109Fj
					; DATA XREF: ExecuteScript:metaJumpTblo
		mov	ax, 80h	; '€'
		push	ax
		call	sub_1526A
		add	sp, 2
		mov	ax, 0C8h ; 'È'
		push	ax
		call	sub_132AF
		add	sp, 2
		mov	ax, 8
		push	ax
		mov	ax, 68h
		push	ax
		call	WritePort
		add	sp, 4
		jmp	j_scr_next
; ---------------------------------------------------------------------------

loc_13035:				; CODE XREF: ExecuteScript+109Fj
					; DATA XREF: ExecuteScript:metaJumpTblo
		mov	word_1AB44, 1
		mov	[bp+var_54], 0C7h ; 'Ç'
		jmp	short loc_13045
; ---------------------------------------------------------------------------

loc_13042:				; CODE XREF: ExecuteScript+FB5j
		dec	[bp+var_54]

loc_13045:				; CODE XREF: ExecuteScript+F92j
		cmp	[bp+var_54], 0
		jl	short loc_13065

loc_1304B:				; CODE XREF: ExecuteScript+FA4j
		cmp	word_1AB44, 0
		jz	short loc_13054
		jmp	short loc_1304B
; ---------------------------------------------------------------------------

loc_13054:				; CODE XREF: ExecuteScript+FA2j
		push	[bp+var_54]
		call	sub_132AF
		add	sp, 2
		mov	word_1AB44, 1
		jmp	short loc_13042
; ---------------------------------------------------------------------------

loc_13065:				; CODE XREF: ExecuteScript+F9Bj
		jmp	j_scr_next
; ---------------------------------------------------------------------------

loc_13068:				; CODE XREF: ExecuteScript+109Fj
					; DATA XREF: ExecuteScript:metaJumpTblo
		mov	ax, 0C0h ; 'À'
		push	ax
		call	sub_1526A
		add	sp, 2
		call	SwapGDCPlanes
		jmp	j_scr_next
; ---------------------------------------------------------------------------

loc_13078:				; CODE XREF: ExecuteScript+109Fj
					; DATA XREF: ExecuteScript:metaJumpTblo
		call	sub_185B5
		jmp	j_scr_next
; ---------------------------------------------------------------------------

loc_1307E:				; CODE XREF: ExecuteScript+109Fj
					; DATA XREF: ExecuteScript:metaJumpTblo
		sub	ax, ax
		push	ax
		call	SetGDCPlane_Wrt
		add	sp, 2
		mov	ax, 2Eh	; '.'
		push	ax
		mov	ax, 4
		push	ax
		call	sub_10670
		add	sp, 4
		jmp	j_scr_next
; ---------------------------------------------------------------------------

loc_13098:				; CODE XREF: ExecuteScript+109Fj
					; DATA XREF: ExecuteScript:metaJumpTblo
		mov	ax, 1
		push	ax
		call	SetGDCPlane_Wrt
		add	sp, 2
		mov	ax, 4
		push	ax
		mov	ax, 36h	; '6'
		push	ax
		mov	ax, 2A30h
		push	ax
		mov	ax, 0E64h
		push	ax
		mov	ax, 0C8h ; 'È'
		push	ax
		mov	ax, 36h	; '6'
		push	ax
		push	word ptr dword_1C1A8+2
		push	word ptr dword_1C1A8
		call	sub_14F8F
		add	sp, 10h
		mov	ax, 2Eh	; '.'
		push	ax
		mov	ax, 4
		push	ax
		call	sub_105EA
		add	sp, 4
		jmp	j_scr_next
; ---------------------------------------------------------------------------

loc_130D9:				; CODE XREF: ExecuteScript+109Fj
					; DATA XREF: ExecuteScript:metaJumpTblo
		mov	ax, 1
		push	ax
		call	SetGDCPlane_Wrt
		add	sp, 2
		mov	ax, 4
		push	ax
		mov	ax, 36h	; '6'
		push	ax
		mov	ax, 2A30h
		push	ax
		mov	ax, 0E64h
		push	ax
		mov	ax, 0C8h ; 'È'
		push	ax
		mov	ax, 36h	; '6'
		push	ax
		push	word ptr dword_1BCDC+2
		push	word ptr dword_1BCDC
		call	sub_14F8F
		add	sp, 10h
		call	SwapGDCPlanes
		mov	ax, 1
		push	ax
		call	SetGDCPlane_Wrt
		add	sp, 2
		mov	ax, 4
		push	ax
		mov	ax, 36h	; '6'
		push	ax
		mov	ax, 2A30h
		push	ax
		mov	ax, 0E64h
		push	ax
		mov	ax, 0C8h ; 'È'
		push	ax
		mov	ax, 36h	; '6'
		push	ax
		push	word ptr dword_1BCDC+2
		push	word ptr dword_1BCDC
		call	sub_14F8F
		add	sp, 10h
		jmp	j_scr_next
; ---------------------------------------------------------------------------
		jmp	j_scr_next
; ---------------------------------------------------------------------------

DoMetaCommand:				; CODE XREF: ExecuteScript+78Aj
		cmp	ax, 5Ah
		jbe	short loc_1314A
		jmp	j_scr_next
; ---------------------------------------------------------------------------

loc_1314A:				; CODE XREF: ExecuteScript+1097j
		add	ax, ax
		xchg	ax, bx
		jmp	word ptr cs:metaJumpTbl[bx]
; ---------------------------------------------------------------------------
metaJumpTbl:				; DATA XREF: ExecuteScript+109Fr
		dw offset loc_1283B	; 0
		dw offset loc_12841	; 1
		dw offset scr_next	; 2
		dw offset loc_12852	; 3
		dw offset loc_12872	; 4
		dw offset loc_12882	; 5
		dw offset scr_next	; 6
		dw offset loc_12893	; 7
		dw offset loc_128A8	; 8
		dw offset loc_128B8	; 9
		dw offset scr_next	; 0Ah
		dw offset scr_next	; 0Bh
		dw offset loc_128C8	; 0Ch
		dw offset loc_128E1	; 0Dh
		dw offset loc_128F1	; 0Eh
		dw offset scr_next	; 0Fh
		dw offset scr_next	; 10h
		dw offset scr_next	; 11h
		dw offset mscr12_PrintX	; 12h
		dw offset scr_next	; 13h
		dw offset mscr14_PrintXY; 14h
		dw offset scr_next	; 15h
		dw offset loc_129A2	; 16h
		dw offset mscr17_FileWait; 17h
		dw offset mscr18_SaveGame; 18h
		dw offset loc_129E0	; 19h
		dw offset scr_next	; 1Ah
		dw offset scr_next	; 1Bh
		dw offset scr_next	; 1Ch
		dw offset scr_next	; 1Dh
		dw offset mscr1E_LoadImg; 1Eh
		dw offset loc_12A17	; 1Fh
		dw offset loc_12A1D	; 20h
		dw offset loc_12A26	; 21h
		dw offset loc_12A2F	; 22h
		dw offset mscr23_FileExist; 23h
		dw offset loc_12AFF	; 24h
		dw offset loc_12BBB	; 25h
		dw offset loc_12C92	; 26h
		dw offset loc_12CF2	; 27h
		dw offset loc_12D59	; 28h
		dw offset loc_12E30	; 29h
		dw offset scr_next	; 2Ah
		dw offset scr_next	; 2Bh
		dw offset scr_next	; 2Ch
		dw offset scr_next	; 2Dh
		dw offset scr_next	; 2Eh
		dw offset scr_next	; 2Fh
		dw offset scr_next	; 30h
		dw offset scr_next	; 31h
		dw offset loc_12FF8	; 32h
		dw offset loc_13001	; 33h
		dw offset scr_next	; 34h
		dw offset scr_next	; 35h
		dw offset scr_next	; 36h
		dw offset scr_next	; 37h
		dw offset scr_next	; 38h
		dw offset scr_next	; 39h
		dw offset scr_next	; 3Ah
		dw offset scr_next	; 3Bh
		dw offset loc_1300A	; 3Ch
		dw offset loc_13010	; 3Dh
		dw offset loc_13035	; 3Eh
		dw offset loc_13068	; 3Fh
		dw offset scr_next	; 40h
		dw offset scr_next	; 41h
		dw offset scr_next	; 42h
		dw offset scr_next	; 43h
		dw offset scr_next	; 44h
		dw offset scr_next	; 45h
		dw offset loc_13078	; 46h
		dw offset scr_next	; 47h
		dw offset scr_next	; 48h
		dw offset scr_next	; 49h
		dw offset scr_next	; 4Ah
		dw offset scr_next	; 4Bh
		dw offset scr_next	; 4Ch
		dw offset scr_next	; 4Dh
		dw offset scr_next	; 4Eh
		dw offset scr_next	; 4Fh
		dw offset loc_1307E	; 50h
		dw offset loc_13098	; 51h
		dw offset scr_next	; 52h
		dw offset scr_next	; 53h
		dw offset scr_next	; 54h
		dw offset scr_next	; 55h
		dw offset scr_next	; 56h
		dw offset scr_next	; 57h
		dw offset scr_next	; 58h
		dw offset scr_next	; 59h
		dw offset loc_130D9	; 5Ah
; ---------------------------------------------------------------------------

j_scr_next:				; CODE XREF: ExecuteScript+790j
					; ExecuteScript+7A1j ...
		jmp	scr_next
; ---------------------------------------------------------------------------
		jmp	scr_next
; ---------------------------------------------------------------------------

DoScriptCommand:			; CODE XREF: ExecuteScript+BCj
		sub	ax, 1
		cmp	ax, 3Bh
		jbe	short loc_13219
		jmp	scr_undefined
; ---------------------------------------------------------------------------

loc_13219:				; CODE XREF: ExecuteScript+1166j
		add	ax, ax
		xchg	ax, bx
		jmp	word ptr cs:scrJumpTbl[bx]
; ---------------------------------------------------------------------------
scrJumpTbl:				; DATA XREF: ExecuteScript+116Er
		dw offset scr01		; 0
		dw offset scr02		; 1
		dw offset scr03		; 2
		dw offset scr04_Choice_1Str; 3
		dw offset scr05_ChoiceExec; 4
		dw offset scr06_Choice_MultiStr; 5
		dw offset scr07_ChoiceStart; 6
		dw offset scr08_Call	; 7
		dw offset scr09_Jump	; 8
		dw offset scr_undefined	; 9
		dw offset scr0B_VarCompare; 0Ah
		dw offset scr_undefined	; 0Bh
		dw offset scr_undefined	; 0Ch
		dw offset scr_undefined	; 0Dh
		dw offset loc_1224A	; 0Eh
		dw offset loc_12260	; 0Fh
		dw offset scr_undefined	; 10h
		dw offset scr12_PlayBGM	; 11h
		dw offset loc_1264D	; 12h
		dw offset loc_125DB	; 13h
		dw offset scr_undefined	; 14h
		dw offset loc_12509	; 15h
		dw offset loc_12517	; 16h
		dw offset scr_undefined	; 17h
		dw offset loc_1251D	; 18h
		dw offset loc_125BD	; 19h
		dw offset cmd1B_Quit	; 1Ah
		dw offset cmd1C_Quit2	; 1Bh
		dw offset loc_124C2	; 1Ch
		dw offset scr_undefined	; 1Dh
		dw offset loc_12348	; 1Eh
		dw offset scr20_Location0; 1Fh
		dw offset scr21_Location1; 20h
		dw offset scr_undefined	; 21h
		dw offset scr_undefined	; 22h
		dw offset scr_undefined	; 23h
		dw offset scr_undefined	; 24h
		dw offset scr26_NameDlg	; 25h
		dw offset scr27_Dialog	; 26h
		dw offset scr28_NameDlg	; 27h
		dw offset scr29_NameDlg	; 28h
		dw offset scr2A_Wait	; 29h
		dw offset loc_1271C	; 2Ah
		dw offset scr_next	; 2Bh
		dw offset scr2D_VarSet	; 2Ch
		dw offset scr2E_VarAdd	; 2Dh
		dw offset scr2F_VarSub	; 2Eh
		dw offset scr30_JumpVar	; 2Fh
		dw offset scr_next	; 30h
		dw offset scr32_Ret	; 31h
		dw offset scr_undefined	; 32h
		dw offset scr34_MetaCmd	; 33h
		dw offset scr09_Jump	; 34h
		dw offset scr_undefined	; 35h
		dw offset scr37_SetPalColor; 36h
		dw offset scr38_PalFade	; 37h
		dw offset loc_127A0	; 38h
		dw offset loc_12747	; 39h
		dw offset loc_125A6	; 3Ah
		dw offset cmd3C_Quit	; 3Bh
; ---------------------------------------------------------------------------

scr_next:				; CODE XREF: ExecuteScript+FDj
					; ExecuteScript+124j ...
		cmp	[bp+var_42], 0
		jz	short loc_132A1
		jmp	short loc_132A4
; ---------------------------------------------------------------------------

loc_132A1:				; CODE XREF: ExecuteScript+11EFj
		jmp	scriptMainLoop
; ---------------------------------------------------------------------------

loc_132A4:				; CODE XREF: ExecuteScript+11F1j
		mov	ax, [bp+var_44]
		jmp	short $+2
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retn
ExecuteScript	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_132AF	proc near		; CODE XREF: ExecuteScript+F70p
					; ExecuteScript+FA9p

arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		xor	ax, ax
		call	__chkstk

loc_132B7:				; CODE XREF: sub_132AF+16j
		mov	ax, 0A0h ; ' '
		push	ax
		call	sub_1676F
		add	sp, 2
		test	al, 2
		jz	short loc_132C7
		jmp	short loc_132B7
; ---------------------------------------------------------------------------

loc_132C7:				; CODE XREF: sub_132AF+14j
		mov	ax, 70h	; 'p'
		push	ax
		mov	ax, 0A2h ; '¢'
		push	ax
		call	WritePort
		add	sp, 4

loc_132D5:				; CODE XREF: sub_132AF+34j
		mov	ax, 0A0h ; ' '
		push	ax
		call	sub_1676F
		add	sp, 2
		test	al, 2
		jz	short loc_132E5
		jmp	short loc_132D5
; ---------------------------------------------------------------------------

loc_132E5:				; CODE XREF: sub_132AF+32j
		mov	ax, 28h	; '('
		imul	[bp+arg_0]
		cwd
		mov	cx, 100h
		idiv	cx
		push	dx
		mov	ax, 0A0h ; ' '
		push	ax
		call	WritePort
		add	sp, 4

loc_132FC:				; CODE XREF: sub_132AF+5Bj
		mov	ax, 0A0h ; ' '
		push	ax
		call	sub_1676F
		add	sp, 2
		test	al, 2
		jz	short loc_1330C
		jmp	short loc_132FC
; ---------------------------------------------------------------------------

loc_1330C:				; CODE XREF: sub_132AF+59j
		mov	ax, 28h	; '('
		imul	[bp+arg_0]
		cwd
		xor	ax, dx
		sub	ax, dx
		mov	cx, 8
		sar	ax, cl
		xor	ax, dx
		sub	ax, dx
		push	ax
		mov	ax, 0A0h ; ' '
		push	ax
		call	WritePort
		add	sp, 4
		mov	sp, bp
		pop	bp
		retn
sub_132AF	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1332F	proc near		; CODE XREF: ExecuteScript+C0Bp

var_2		= word ptr -2
arg_0		= word ptr  4
arg_2		= word ptr  6

		push	bp
		mov	bp, sp
		mov	ax, 2
		call	__chkstk
		push	si
		mov	word_1BD84, 0
		mov	ax, word ptr dword_1C31A
		mov	dx, word ptr dword_1C31A+2
		add	ax, 8
		mov	word ptr dword_1C344, ax
		mov	word ptr dword_1C344+2,	dx
		les	bx, dword_1C344
		mov	si, es:[bx]
		les	bx, dword_1C31A
		mov	al, es:[bx+si+1]
		sub	ah, ah
		mov	word_1BCBE, ax
		cmp	[bp+arg_2], 0
		jnz	short loc_1336D
		jmp	loc_1342F
; ---------------------------------------------------------------------------

loc_1336D:				; CODE XREF: sub_1332F+39j
		mov	ax, [bp+arg_0]
		mov	[bp+var_2], ax
		jmp	short loc_13378
; ---------------------------------------------------------------------------

loc_13375:				; CODE XREF: sub_1332F:loc_13429j
		inc	[bp+var_2]

loc_13378:				; CODE XREF: sub_1332F+44j
		mov	ax, [bp+arg_0]
		add	ax, 36h	; '6'
		cmp	ax, [bp+var_2]
		jg	short loc_13386
		jmp	loc_1342C
; ---------------------------------------------------------------------------

loc_13386:				; CODE XREF: sub_1332F+52j
		mov	ax, [bp+var_2]
		mov	cl, 3
		shl	ax, cl
		add	ax, word ptr dword_1C31A
		mov	dx, word ptr dword_1C31A+2
		add	ax, 8
		mov	word ptr dword_1C344, ax
		mov	word ptr dword_1C344+2,	dx
		mov	ax, 0C8h ; 'È'
		push	ax
		mov	ax, 37h	; '7'
		push	ax
		mov	ax, [bp+var_2]
		add	ax, word_1C322
		mov	dx, word_1C324
		push	dx
		push	ax
		sub	ax, ax
		push	ax
		push	ax
		les	bx, dword_1C344
		mov	ax, es:[bx]
		add	ax, word ptr dword_1C31A
		mov	dx, word ptr dword_1C31A+2
		push	dx
		push	ax
		call	sub_18267
		add	sp, 10h
		mov	ax, 0C8h ; 'È'
		push	ax
		mov	ax, 37h	; '7'
		push	ax
		mov	ax, [bp+var_2]
		add	ax, word_1C326
		mov	dx, word_1C328
		push	dx
		push	ax
		sub	ax, ax
		push	ax
		push	ax
		les	bx, dword_1C344
		mov	ax, es:[bx]
		add	ax, word ptr dword_1C31A
		mov	dx, word ptr dword_1C31A+2
		push	dx
		push	ax
		call	sub_18267
		add	sp, 10h
		cmp	[bp+var_2], 0
		jz	short loc_13429
		push	word_1BCBE
		mov	ax, 2AF9h
		push	ax
		mov	ax, 0C8h ; 'È'
		push	ax
		mov	ax, 37h	; '7'
		push	ax
		mov	ax, [bp+var_2]
		add	ax, word_1C326
		mov	dx, word_1C328
		dec	ax
		push	dx
		push	ax
		call	sub_14ADB
		add	sp, 0Ch

loc_13429:				; CODE XREF: sub_1332F+D4j
		jmp	loc_13375
; ---------------------------------------------------------------------------

loc_1342C:				; CODE XREF: sub_1332F+54j
		jmp	loc_13500
; ---------------------------------------------------------------------------

loc_1342F:				; CODE XREF: sub_1332F+3Bj
		mov	ax, [bp+arg_0]
		add	ax, 35h	; '5'
		mov	[bp+var_2], ax
		jmp	short loc_1343D
; ---------------------------------------------------------------------------

loc_1343A:				; CODE XREF: sub_1332F+1CEj
		dec	[bp+var_2]

loc_1343D:				; CODE XREF: sub_1332F+109j
		mov	ax, [bp+arg_0]
		cmp	[bp+var_2], ax
		jge	short loc_13448
		jmp	loc_13500
; ---------------------------------------------------------------------------

loc_13448:				; CODE XREF: sub_1332F+114j
		mov	ax, [bp+var_2]
		mov	cl, 3
		shl	ax, cl
		add	ax, word ptr dword_1C31A
		mov	dx, word ptr dword_1C31A+2
		add	ax, 8
		mov	word ptr dword_1C344, ax
		mov	word ptr dword_1C344+2,	dx
		mov	ax, 0C8h ; 'È'
		push	ax
		mov	ax, 37h	; '7'
		push	ax
		mov	ax, [bp+var_2]
		add	ax, word_1C322
		mov	dx, word_1C324
		push	dx
		push	ax
		sub	ax, ax
		push	ax
		push	ax
		les	bx, dword_1C344
		mov	ax, es:[bx]
		add	ax, word ptr dword_1C31A
		mov	dx, word ptr dword_1C31A+2
		push	dx
		push	ax
		call	sub_18267
		add	sp, 10h
		mov	ax, [bp+var_2]
		mov	cl, 3
		shl	ax, cl
		add	ax, word ptr dword_1C31A
		mov	dx, word ptr dword_1C31A+2
		add	ax, 8
		mov	word ptr dword_1C344, ax
		mov	word ptr dword_1C344+2,	dx
		mov	ax, 0C8h ; 'È'
		push	ax
		mov	ax, 37h	; '7'
		push	ax
		mov	ax, [bp+var_2]
		add	ax, word_1C326
		mov	dx, word_1C328
		push	dx
		push	ax
		sub	ax, ax
		push	ax
		push	ax
		les	bx, dword_1C344
		mov	ax, es:[bx]
		add	ax, word ptr dword_1C31A
		mov	dx, word ptr dword_1C31A+2
		push	dx
		push	ax
		call	sub_18267
		add	sp, 10h
		push	word_1BCBE
		mov	ax, 2AF9h
		push	ax
		mov	ax, 0C8h ; 'È'
		push	ax
		mov	ax, 37h	; '7'
		push	ax
		mov	ax, [bp+var_2]
		add	ax, word_1C326
		mov	dx, word_1C328
		push	dx
		push	ax
		call	sub_15213
		add	sp, 0Ch
		jmp	loc_1343A
; ---------------------------------------------------------------------------

loc_13500:				; CODE XREF: sub_1332F:loc_1342Cj
					; sub_1332F+116j
		pop	si
		mov	sp, bp
		pop	bp
		retn
sub_1332F	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_13505	proc near		; CODE XREF: ExecuteScript+C26p

var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  4
arg_2		= word ptr  6

		push	bp
		mov	bp, sp
		mov	ax, 4
		call	__chkstk
		mov	ax, 50h	; 'P'
		imul	word_1AB60
		add	ax, word_1AB5E
		mov	[bp+var_4], ax
		cmp	[bp+arg_2], 0
		jz	short loc_13531
		mov	ax, word_1B6B8
		cmp	[bp+arg_0], ax
		jnz	short loc_13531
		sub	ax, ax
		jmp	loc_137C4
; ---------------------------------------------------------------------------
		jmp	short loc_13540
; ---------------------------------------------------------------------------

loc_13531:				; CODE XREF: sub_13505+1Bj
					; sub_13505+23j
		mov	ax, [bp+arg_0]
		inc	ax
		cmp	ax, word_1B6B8
		jnz	short loc_13540
		sub	ax, ax
		jmp	loc_137C4
; ---------------------------------------------------------------------------

loc_13540:				; CODE XREF: sub_13505+2Aj
					; sub_13505+34j
		mov	ax, 1
		push	ax
		call	SetGDCPlane_Wrt
		add	sp, 2
		cmp	[bp+arg_2], 0
		jnz	short loc_13553
		jmp	loc_13670
; ---------------------------------------------------------------------------

loc_13553:				; CODE XREF: sub_13505+49j
		mov	ax, word_1B6B8
		add	ax, 36h	; '6'
		mov	[bp+var_2], ax
		cmp	word_1BD84, 0
		jnz	short loc_135D6
		mov	cl, 3
		shl	ax, cl
		add	ax, word ptr dword_1C31A
		mov	dx, word ptr dword_1C31A+2
		add	ax, 8
		mov	word ptr dword_1C344, ax
		mov	word ptr dword_1C344+2,	dx
		mov	ax, 0C8h ; 'È'
		push	ax
		mov	ax, 37h	; '7'
		push	ax
		mov	ax, [bp+var_2]
		add	ax, word_1C322
		mov	dx, word_1C324
		push	dx
		push	ax
		sub	ax, ax
		push	ax
		push	ax
		les	bx, dword_1C344
		mov	ax, es:[bx]
		add	ax, word ptr dword_1C31A
		mov	dx, word ptr dword_1C31A+2
		push	dx
		push	ax
		call	sub_18267
		add	sp, 10h
		push	word_1BCBE
		mov	ax, 37h	; '7'
		push	ax
		mov	ax, 2AF9h
		push	ax
		push	[bp+var_4]
		mov	ax, 0C8h ; 'È'
		push	ax
		mov	ax, 36h	; '6'
		push	ax
		mov	ax, word_1B6B8
		add	ax, word_1C322
		mov	dx, word_1C324
		push	dx
		push	ax
		call	sub_14F8F
		add	sp, 10h
		jmp	loc_1366D
; ---------------------------------------------------------------------------

loc_135D6:				; CODE XREF: sub_13505+5Cj
		mov	ax, [bp+var_2]
		mov	cl, 3
		shl	ax, cl
		add	ax, word ptr dword_1C31A
		mov	dx, word ptr dword_1C31A+2
		add	ax, 8
		mov	word ptr dword_1C344, ax
		mov	word ptr dword_1C344+2,	dx
		mov	ax, 0C8h ; 'È'
		push	ax
		mov	ax, 37h	; '7'
		push	ax
		mov	ax, [bp+var_2]
		add	ax, word_1C326
		mov	dx, word_1C328
		push	dx
		push	ax
		sub	ax, ax
		push	ax
		push	ax
		les	bx, dword_1C344
		mov	ax, es:[bx]
		add	ax, word ptr dword_1C31A
		mov	dx, word ptr dword_1C31A+2
		push	dx
		push	ax
		call	sub_18267
		add	sp, 10h
		push	word_1BCBE
		mov	ax, 2AF9h
		push	ax
		mov	ax, 0C8h ; 'È'
		push	ax
		mov	ax, 37h	; '7'
		push	ax
		mov	ax, [bp+var_2]
		add	ax, word_1C326
		mov	dx, word_1C328
		dec	ax
		push	dx
		push	ax
		call	sub_14ADB
		add	sp, 0Ch
		push	word_1BCBE
		mov	ax, 37h	; '7'
		push	ax
		mov	ax, 2AF9h
		push	ax
		push	[bp+var_4]
		mov	ax, 0C8h ; 'È'
		push	ax
		mov	ax, 36h	; '6'
		push	ax
		mov	ax, word_1B6B8
		add	ax, word_1C326
		mov	dx, word_1C328
		push	dx
		push	ax
		call	sub_14F8F
		add	sp, 10h

loc_1366D:				; CODE XREF: sub_13505+CEj
		jmp	loc_1378B
; ---------------------------------------------------------------------------

loc_13670:				; CODE XREF: sub_13505+4Bj
		cmp	word_1BD84, 0
		jz	short loc_136F1
		mov	ax, word_1B6B8
		dec	ax
		mov	[bp+var_2], ax
		mov	cl, 3
		shl	ax, cl
		add	ax, word ptr dword_1C31A
		mov	dx, word ptr dword_1C31A+2
		add	ax, 8
		mov	word ptr dword_1C344, ax
		mov	word ptr dword_1C344+2,	dx
		mov	ax, 0C8h ; 'È'
		push	ax
		mov	ax, 37h	; '7'
		push	ax
		mov	ax, [bp+var_2]
		add	ax, word_1C322
		mov	dx, word_1C324
		push	dx
		push	ax
		sub	ax, ax
		push	ax
		push	ax
		les	bx, dword_1C344
		mov	ax, es:[bx]
		add	ax, word ptr dword_1C31A
		mov	dx, word ptr dword_1C31A+2
		push	dx
		push	ax
		call	sub_18267
		add	sp, 10h
		push	word_1BCBE
		mov	ax, 37h	; '7'
		push	ax
		mov	ax, 2AF9h
		push	ax
		push	[bp+var_4]
		mov	ax, 0C8h ; 'È'
		push	ax
		mov	ax, 36h	; '6'
		push	ax
		mov	ax, [bp+var_2]
		add	ax, word_1C322
		mov	dx, word_1C324
		push	dx
		push	ax
		call	sub_14F8F
		add	sp, 10h
		jmp	loc_1378B
; ---------------------------------------------------------------------------

loc_136F1:				; CODE XREF: sub_13505+170j
		mov	ax, word_1B6B8
		dec	ax
		mov	[bp+var_2], ax
		mov	cl, 3
		shl	ax, cl
		add	ax, word ptr dword_1C31A
		mov	dx, word ptr dword_1C31A+2
		add	ax, 8
		mov	word ptr dword_1C344, ax
		mov	word ptr dword_1C344+2,	dx
		mov	ax, 0C8h ; 'È'
		push	ax
		mov	ax, 37h	; '7'
		push	ax
		mov	ax, [bp+var_2]
		add	ax, word_1C326
		mov	dx, word_1C328
		push	dx
		push	ax
		sub	ax, ax
		push	ax
		push	ax
		les	bx, dword_1C344
		mov	ax, es:[bx]
		add	ax, word ptr dword_1C31A
		mov	dx, word ptr dword_1C31A+2
		push	dx
		push	ax
		call	sub_18267
		add	sp, 10h
		push	word_1BCBE
		mov	ax, 2AF9h
		push	ax
		mov	ax, 0C8h ; 'È'
		push	ax
		mov	ax, 37h	; '7'
		push	ax
		mov	ax, [bp+var_2]
		add	ax, word_1C326
		mov	dx, word_1C328
		push	dx
		push	ax
		call	sub_15213
		add	sp, 0Ch
		push	word_1BCBE
		mov	ax, 37h	; '7'
		push	ax
		mov	ax, 2AF9h
		push	ax
		push	[bp+var_4]
		mov	ax, 0C8h ; 'È'
		push	ax
		mov	ax, 36h	; '6'
		push	ax
		mov	ax, word_1B6B8
		add	ax, word_1C326
		mov	dx, word_1C328
		push	dx
		push	ax
		call	sub_14F8F
		add	sp, 10h

loc_1378B:				; CODE XREF: sub_13505:loc_1366Dj
					; sub_13505+1E9j
		cmp	word_1AB5E, 4
		jnz	short loc_13795
		call	sub_13F11

loc_13795:				; CODE XREF: sub_13505+28Bj
		inc	word_1BD84
		and	word_1BD84, 1
		cmp	[bp+arg_2], 0
		jz	short loc_137B1
		cmp	word_1BD84, 0
		jnz	short loc_137AF
		inc	word_1B6B8

loc_137AF:				; CODE XREF: sub_13505+2A4j
		jmp	short loc_137BC
; ---------------------------------------------------------------------------

loc_137B1:				; CODE XREF: sub_13505+29Dj
		cmp	word_1BD84, 0
		jnz	short loc_137BC
		dec	word_1B6B8

loc_137BC:				; CODE XREF: sub_13505:loc_137AFj
					; sub_13505+2B1j
		call	SwapGDCPlanes
		mov	ax, 1
		jmp	short $+2

loc_137C4:				; CODE XREF: sub_13505+27j
					; sub_13505+38j
		mov	sp, bp
		pop	bp
		retn
sub_13505	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

SetTargetPal	proc near		; CODE XREF: ExecuteScript+714p

arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		xor	ax, ax
		call	__chkstk
		cmp	[bp+arg_0], 0
		jnz	short loc_137DB
		call	Palette_SetGDC
		jmp	short loc_137E4
; ---------------------------------------------------------------------------

loc_137DB:				; CODE XREF: SetTargetPal+Cj
		push	[bp+arg_0]
		call	Palette_Fade2Tgt
		add	sp, 2

loc_137E4:				; CODE XREF: SetTargetPal+11j
		mov	sp, bp
		pop	bp
		retn
SetTargetPal	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_137E8	proc near		; CODE XREF: ExecuteScript+675p
					; sub_17673+Dp

arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		xor	ax, ax
		call	__chkstk
		cmp	[bp+arg_0], 0
		jz	short loc_13830
		mov	ax, word_1B592
		mov	dx, word_1B594
		add	ax, 8
		mov	word ptr dword_1C344, ax
		mov	word ptr dword_1C344+2,	dx
		mov	ax, 0C8h ; 'È'
		push	ax
		mov	ax, 36h	; '6'
		push	ax
		push	word ptr dword_1BCDC+2
		push	word ptr dword_1BCDC
		sub	ax, ax
		push	ax
		push	ax
		les	bx, dword_1C344
		mov	ax, es:[bx]
		add	ax, word_1B592
		push	dx
		push	ax
		call	sub_18171
		add	sp, 10h
		jmp	short loc_13845
; ---------------------------------------------------------------------------

loc_13830:				; CODE XREF: sub_137E8+Cj
		sub	ax, ax
		push	ax
		mov	ax, 0A8C0h
		push	ax
		push	word ptr dword_1BCDC+2
		push	word ptr dword_1BCDC
		call	sub_14F6D
		add	sp, 8

loc_13845:				; CODE XREF: sub_137E8+46j
		mov	sp, bp
		pop	bp
		retn
sub_137E8	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

Palette_SetGDC	proc near		; CODE XREF: SetTargetPal+Ep

var_2		= word ptr -2

		push	bp
		mov	bp, sp
		mov	ax, 2
		call	__chkstk
		push	di
		push	si
		mov	[bp+var_2], 0
		jmp	short loc_1385E
; ---------------------------------------------------------------------------

loc_1385B:				; CODE XREF: Palette_SetGDC+8Fj
		inc	[bp+var_2]

loc_1385E:				; CODE XREF: Palette_SetGDC+10j
		cmp	[bp+var_2], 10h
		jge	short loc_138DA
		push	[bp+var_2]	; palette index
		mov	ax, 0A8h
		push	ax		; unsigned int
		call	_outp
		add	sp, 4
		mov	bx, [bp+var_2]
		mov	ax, bx
		shl	bx, 1
		add	bx, ax
		mov	al, (PalTarget+1)[bx] ;	green
		sub	ah, ah
		push	ax		; int
		mov	ax, 0AAh
		push	ax		; unsigned int
		call	_outp
		add	sp, 4
		mov	bx, [bp+var_2]
		mov	ax, bx
		shl	bx, 1
		add	bx, ax
		mov	al, PalTarget[bx] ; red
		sub	ah, ah
		push	ax		; int
		mov	ax, 0ACh
		push	ax		; unsigned int
		call	_outp
		add	sp, 4
		mov	bx, [bp+var_2]
		mov	ax, bx
		shl	bx, 1
		add	bx, ax
		mov	al, (PalTarget+2)[bx] ;	blue
		sub	ah, ah
		push	ax		; int
		mov	ax, 0AEh
		push	ax		; unsigned int
		call	_outp
		add	sp, 4
		mov	ax, [bp+var_2]
		mov	cx, ax
		shl	ax, 1
		add	ax, cx
		mov	si, ax
		push	si
		lea	di, PalCurrent[si]
		lea	si, PalTarget[si]
		push	ds
		pop	es
		assume es:dseg
		movsw
		movsb
		pop	si
		jmp	short loc_1385B
; ---------------------------------------------------------------------------

loc_138DA:				; CODE XREF: Palette_SetGDC+19j
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retn
Palette_SetGDC	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

PaletteCur2GDC	proc near		; CODE XREF: Palette_Fade2Tgt+F6p

var_2		= word ptr -2

		push	bp
		mov	bp, sp
		mov	ax, 2
		call	__chkstk
		mov	[bp+var_2], 0
		jmp	short loc_138F3
; ---------------------------------------------------------------------------

loc_138F0:				; CODE XREF: PaletteCur2GDC+74j
		inc	[bp+var_2]

loc_138F3:				; CODE XREF: PaletteCur2GDC+Ej
		cmp	[bp+var_2], 10h
		jge	short loc_13956
		push	[bp+var_2]	; int
		mov	ax, 0A8h
		push	ax		; unsigned int
		call	_outp
		add	sp, 4
		mov	bx, [bp+var_2]
		mov	ax, bx
		shl	bx, 1
		add	bx, ax
		mov	al, (PalCurrent+1)[bx]
		sub	ah, ah
		push	ax		; int
		mov	ax, 0AAh
		push	ax		; unsigned int
		call	_outp
		add	sp, 4
		mov	bx, [bp+var_2]
		mov	ax, bx
		shl	bx, 1
		add	bx, ax
		mov	al, PalCurrent[bx]
		sub	ah, ah
		push	ax		; int
		mov	ax, 0ACh
		push	ax		; unsigned int
		call	_outp
		add	sp, 4
		mov	bx, [bp+var_2]
		mov	ax, bx
		shl	bx, 1
		add	bx, ax
		mov	al, (PalCurrent+2)[bx]
		sub	ah, ah
		push	ax		; int
		mov	ax, 0AEh
		push	ax		; unsigned int
		call	_outp
		add	sp, 4
		jmp	short loc_138F0
; ---------------------------------------------------------------------------

loc_13956:				; CODE XREF: PaletteCur2GDC+17j
		mov	sp, bp
		pop	bp
		retn
PaletteCur2GDC	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

Palette_Fade2Tgt proc near		; CODE XREF: SetTargetPal+16p

var_6		= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		mov	ax, 6
		call	__chkstk
		push	si
		mov	[bp+var_4], 1

loc_13969:				; CODE XREF: Palette_Fade2Tgt:loc_13A5Bj
		cmp	[bp+var_4], 0
		jnz	short loc_13972
		jmp	loc_13A5E
; ---------------------------------------------------------------------------

loc_13972:				; CODE XREF: Palette_Fade2Tgt+13j
		mov	ax, [bp+arg_0]
		mov	palFadeSpeed, ax ; set wait time for this fade step
		mov	[bp+var_2], 1
		mov	[bp+var_6], 0
		jmp	short loc_13987
; ---------------------------------------------------------------------------

loc_13984:				; CODE XREF: Palette_Fade2Tgt:loc_13A4Aj
		inc	[bp+var_6]

loc_13987:				; CODE XREF: Palette_Fade2Tgt+28j
		cmp	[bp+var_6], 10h
		jl	short loc_13990
		jmp	loc_13A4D
; ---------------------------------------------------------------------------

loc_13990:				; CODE XREF: Palette_Fade2Tgt+31j
		mov	ax, [bp+var_6]	; process 1 of 16 colours
		mov	cx, ax
		shl	ax, 1
		add	ax, cx
		mov	si, ax
		mov	al, (PalTarget+1)[si]
		cmp	(PalCurrent+1)[si], al
		jbe	short loc_139B0
		dec	(PalCurrent+1)[si]
		mov	[bp+var_2], 0
		jmp	short loc_139CE
; ---------------------------------------------------------------------------

loc_139B0:				; CODE XREF: Palette_Fade2Tgt+49j
		mov	ax, [bp+var_6]
		mov	cx, ax
		shl	ax, 1
		add	ax, cx
		mov	si, ax
		mov	al, (PalTarget+1)[si]
		cmp	(PalCurrent+1)[si], al
		jnb	short loc_139CE
		inc	(PalCurrent+1)[si]
		mov	[bp+var_2], 0

loc_139CE:				; CODE XREF: Palette_Fade2Tgt+54j
					; Palette_Fade2Tgt+69j
		mov	ax, [bp+var_6]
		mov	cx, ax
		shl	ax, 1
		add	ax, cx
		mov	si, ax
		mov	al, PalTarget[si]
		cmp	PalCurrent[si],	al
		jbe	short loc_139EE
		dec	PalCurrent[si]
		mov	[bp+var_2], 0
		jmp	short loc_13A0C
; ---------------------------------------------------------------------------

loc_139EE:				; CODE XREF: Palette_Fade2Tgt+87j
		mov	ax, [bp+var_6]
		mov	cx, ax
		shl	ax, 1
		add	ax, cx
		mov	si, ax
		mov	al, PalTarget[si]
		cmp	PalCurrent[si],	al
		jnb	short loc_13A0C
		inc	PalCurrent[si]
		mov	[bp+var_2], 0

loc_13A0C:				; CODE XREF: Palette_Fade2Tgt+92j
					; Palette_Fade2Tgt+A7j
		mov	ax, [bp+var_6]
		mov	cx, ax
		shl	ax, 1
		add	ax, cx
		mov	si, ax
		mov	al, (PalTarget+2)[si]
		cmp	(PalCurrent+2)[si], al
		jbe	short loc_13A2C
		dec	(PalCurrent+2)[si]
		mov	[bp+var_2], 0
		jmp	short loc_13A4A
; ---------------------------------------------------------------------------

loc_13A2C:				; CODE XREF: Palette_Fade2Tgt+C5j
		mov	ax, [bp+var_6]
		mov	cx, ax
		shl	ax, 1
		add	ax, cx
		mov	si, ax
		mov	al, (PalTarget+2)[si]
		cmp	(PalCurrent+2)[si], al
		jnb	short loc_13A4A
		inc	(PalCurrent+2)[si]
		mov	[bp+var_2], 0

loc_13A4A:				; CODE XREF: Palette_Fade2Tgt+D0j
					; Palette_Fade2Tgt+E5j
		jmp	loc_13984
; ---------------------------------------------------------------------------

loc_13A4D:				; CODE XREF: Palette_Fade2Tgt+33j
		call	WaitForTxtOrPal
		call	PaletteCur2GDC
		cmp	[bp+var_2], 0
		jz	short loc_13A5B
		jmp	short loc_13A5E
; ---------------------------------------------------------------------------

loc_13A5B:				; CODE XREF: Palette_Fade2Tgt+FDj
		jmp	loc_13969
; ---------------------------------------------------------------------------

loc_13A5E:				; CODE XREF: Palette_Fade2Tgt+15j
					; Palette_Fade2Tgt+FFj
		pop	si
		mov	sp, bp
		pop	bp
		retn
Palette_Fade2Tgt endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_13A63	proc near		; CODE XREF: sub_106F6+118p

var_8		= word ptr -8
var_6		= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		mov	ax, 8
		call	__chkstk
		push	si
		mov	ax, [bp+arg_0]
		mov	cx, ax
		shl	ax, 1
		add	ax, cx
		mov	si, ax
		mov	al, [si+61Dh]
		sub	ah, ah
		mov	[bp+var_6], ax
		mov	al, [si+61Ch]
		mov	[bp+var_4], ax
		mov	al, [si+61Eh]
		mov	[bp+var_2], ax
		mov	[bp+var_8], 0
		jmp	short loc_13A99
; ---------------------------------------------------------------------------

loc_13A96:				; CODE XREF: sub_13A63:loc_13AF5j
		inc	[bp+var_8]

loc_13A99:				; CODE XREF: sub_13A63+31j
		cmp	[bp+var_8], 4
		jge	short loc_13AF7
		mov	ax, [bp+var_8]
		add	ax, 9
		push	ax		; int
		mov	ax, 0A8h ; '¨'
		push	ax		; unsigned int
		call	_outp
		add	sp, 4
		push	[bp+var_6]	; int
		mov	ax, 0AAh ; 'ª'
		push	ax		; unsigned int
		call	_outp
		add	sp, 4
		push	[bp+var_4]	; int
		mov	ax, 0ACh ; '¬'
		push	ax		; unsigned int
		call	_outp
		add	sp, 4
		push	[bp+var_2]	; int
		mov	ax, 0AEh ; '®'
		push	ax		; unsigned int
		call	_outp
		add	sp, 4
		cmp	[bp+var_6], 2
		jl	short loc_13AE1
		sub	[bp+var_6], 2

loc_13AE1:				; CODE XREF: sub_13A63+78j
		cmp	[bp+var_4], 2
		jl	short loc_13AEB
		sub	[bp+var_4], 2

loc_13AEB:				; CODE XREF: sub_13A63+82j
		cmp	[bp+var_2], 2
		jl	short loc_13AF5
		sub	[bp+var_2], 2

loc_13AF5:				; CODE XREF: sub_13A63+8Cj
		jmp	short loc_13A96
; ---------------------------------------------------------------------------

loc_13AF7:				; CODE XREF: sub_13A63+3Aj
		pop	si
		mov	sp, bp
		pop	bp
		retn
sub_13A63	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_13AFC	proc near		; CODE XREF: ExecuteScript+60Fp
					; ExecuteScript+680p ...

var_8		= word ptr -8
var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  4
arg_2		= word ptr  6

		push	bp
		mov	bp, sp
		mov	ax, 8
		call	__chkstk
		cmp	[bp+arg_0], 0FFFFh
		jz	short loc_13B1F
		mov	ax, [bp+arg_0]
		cwd
		xor	ax, dx
		sub	ax, dx
		mov	cx, 3
		sar	ax, cl
		xor	ax, dx
		sub	ax, dx
		mov	word_1AB5E, ax

loc_13B1F:				; CODE XREF: sub_13AFC+Dj
		cmp	[bp+arg_2], 0FFFFh
		jz	short loc_13B2B
		mov	ax, [bp+arg_2]
		mov	word_1AB60, ax

loc_13B2B:				; CODE XREF: sub_13AFC+27j
		mov	ax, 50h	; 'P'
		imul	word_1AB60
		add	ax, word_1AB5E
		mov	[bp+var_8], ax
		sub	ax, ax
		push	ax
		call	SetGDCPlane_Wrt
		add	sp, 2
		mov	[bp+var_4], 0
		jmp	short loc_13B4D
; ---------------------------------------------------------------------------

loc_13B49:				; CODE XREF: sub_13AFC:loc_13BD9j
		add	[bp+var_4], 3

loc_13B4D:				; CODE XREF: sub_13AFC+4Bj
		cmp	[bp+var_4], 64h	; 'd'
		jl	short loc_13B56
		jmp	loc_13BDC
; ---------------------------------------------------------------------------

loc_13B56:				; CODE XREF: sub_13AFC+55j
		mov	word_1AB44, 1
		mov	ax, [bp+var_4]
		mov	[bp+var_2], ax
		push	word_1C1A6
		mov	ax, 36h	; '6'
		push	ax
		mov	ax, 2A30h
		push	ax
		mov	ax, 50h	; 'P'
		imul	[bp+var_2]
		add	ax, [bp+var_8]
		push	ax
		mov	ax, 1
		push	ax
		mov	ax, 36h	; '6'
		push	ax
		imul	[bp+var_2]
		add	ax, word ptr dword_1BCDC
		mov	dx, word ptr dword_1BCDC+2
		push	dx
		push	ax
		call	sub_14F8F
		add	sp, 10h
		mov	ax, 0C7h ; 'Ç'
		sub	ax, [bp+var_4]
		mov	[bp+var_2], ax
		push	word_1C1A6
		mov	ax, 36h	; '6'
		push	ax
		mov	ax, 2A30h
		push	ax
		mov	ax, 50h	; 'P'
		imul	[bp+var_2]
		add	ax, [bp+var_8]
		push	ax
		mov	ax, 1
		push	ax
		mov	ax, 36h	; '6'
		push	ax
		imul	[bp+var_2]
		add	ax, word ptr dword_1BCDC
		mov	dx, word ptr dword_1BCDC+2
		push	dx
		push	ax
		call	sub_14F8F
		add	sp, 10h
		call	sub_17C81

loc_13BD0:				; CODE XREF: sub_13AFC+DBj
		cmp	word_1AB44, 0
		jz	short loc_13BD9
		jmp	short loc_13BD0
; ---------------------------------------------------------------------------

loc_13BD9:				; CODE XREF: sub_13AFC+D9j
		jmp	loc_13B49
; ---------------------------------------------------------------------------

loc_13BDC:				; CODE XREF: sub_13AFC+57j
		mov	[bp+var_4], 65h	; 'e'
		jmp	short loc_13BE7
; ---------------------------------------------------------------------------

loc_13BE3:				; CODE XREF: sub_13AFC:loc_13CE6j
		add	[bp+var_4], 3

loc_13BE7:				; CODE XREF: sub_13AFC+E5j
		cmp	[bp+var_4], 0C8h ; 'È'
		jl	short loc_13BF1
		jmp	loc_13CE9
; ---------------------------------------------------------------------------

loc_13BF1:				; CODE XREF: sub_13AFC+F0j
		mov	word_1AB44, 1
		mov	ax, [bp+var_4]
		mov	[bp+var_2], ax
		push	word_1C1A6
		mov	ax, 36h	; '6'
		push	ax
		mov	ax, 2A30h
		push	ax
		mov	ax, 50h	; 'P'
		imul	[bp+var_2]
		add	ax, [bp+var_8]
		push	ax
		mov	ax, 1
		push	ax
		mov	ax, 36h	; '6'
		push	ax
		imul	[bp+var_2]
		add	ax, word ptr dword_1BCDC
		mov	dx, word ptr dword_1BCDC+2
		push	dx
		push	ax
		call	sub_14F8F
		add	sp, 10h
		mov	ax, [bp+var_4]
		inc	ax
		mov	[bp+var_2], ax
		push	word_1C1A6
		mov	ax, 36h	; '6'
		push	ax
		mov	ax, 2A30h
		push	ax
		mov	ax, 50h	; 'P'
		imul	[bp+var_2]
		add	ax, [bp+var_8]
		push	ax
		mov	ax, 1
		push	ax
		mov	ax, 36h	; '6'
		push	ax
		imul	[bp+var_2]
		add	ax, word ptr dword_1BCDC
		mov	dx, word ptr dword_1BCDC+2
		push	dx
		push	ax
		call	sub_14F8F
		add	sp, 10h
		mov	ax, 0C7h ; 'Ç'
		sub	ax, [bp+var_4]
		mov	[bp+var_2], ax
		push	word_1C1A6
		mov	ax, 36h	; '6'
		push	ax
		mov	ax, 2A30h
		push	ax
		mov	ax, 50h	; 'P'
		imul	[bp+var_2]
		add	ax, [bp+var_8]
		push	ax
		mov	ax, 1
		push	ax
		mov	ax, 36h	; '6'
		push	ax
		imul	[bp+var_2]
		add	ax, word ptr dword_1BCDC
		mov	dx, word ptr dword_1BCDC+2
		push	dx
		push	ax
		call	sub_14F8F
		add	sp, 10h
		mov	ax, 0C6h ; 'Æ'
		sub	ax, [bp+var_4]
		mov	[bp+var_2], ax
		push	word_1C1A6
		mov	ax, 36h	; '6'
		push	ax
		mov	ax, 2A30h
		push	ax
		mov	ax, 50h	; 'P'
		imul	[bp+var_2]
		add	ax, [bp+var_8]
		push	ax
		mov	ax, 1
		push	ax
		mov	ax, 36h	; '6'
		push	ax
		imul	[bp+var_2]
		add	ax, word ptr dword_1BCDC
		mov	dx, word ptr dword_1BCDC+2
		push	dx
		push	ax
		call	sub_14F8F
		add	sp, 10h
		call	sub_17C81

loc_13CDD:				; CODE XREF: sub_13AFC+1E8j
		cmp	word_1AB44, 0
		jz	short loc_13CE6
		jmp	short loc_13CDD
; ---------------------------------------------------------------------------

loc_13CE6:				; CODE XREF: sub_13AFC+1E6j
		jmp	loc_13BE3
; ---------------------------------------------------------------------------

loc_13CE9:				; CODE XREF: sub_13AFC+F2j
		mov	ax, 1
		push	ax
		call	SetGDCPlane_Wrt
		add	sp, 2
		push	word_1C1A6
		mov	ax, 36h	; '6'
		push	ax
		mov	ax, 2A30h
		push	ax
		push	[bp+var_8]
		mov	ax, 0C8h ; 'È'
		push	ax
		mov	ax, 36h	; '6'
		push	ax
		push	word ptr dword_1BCDC+2
		push	word ptr dword_1BCDC
		call	sub_14F8F
		add	sp, 10h
		mov	sp, bp
		pop	bp
		retn
sub_13AFC	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_13D1C	proc near		; CODE XREF: sub_17673+2Ep
					; sub_17673+3Ep

var_6		= word ptr -6
var_2		= word ptr -2
arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		mov	ax, 6
		call	__chkstk
		cmp	[bp+arg_0], 0
		jnz	short loc_13D31
		mov	word_1AD98, 0

loc_13D31:				; CODE XREF: sub_13D1C+Dj
		mov	ax, 50h	; 'P'
		imul	word_1AB60
		add	ax, word_1AB5E
		mov	[bp+var_6], ax
		cmp	[bp+arg_0], 0FFFFh
		jnz	short loc_13D79
		mov	ax, 1
		push	ax
		call	SetGDCPlane_Wrt
		add	sp, 2
		push	word_1C1A6
		mov	ax, 36h	; '6'
		push	ax
		mov	ax, 2A30h
		push	ax
		push	[bp+var_6]
		mov	ax, 0C8h ; 'È'
		push	ax
		mov	ax, 36h	; '6'
		push	ax
		push	word ptr dword_1BCDC+2
		push	word ptr dword_1BCDC
		call	sub_14F8F
		add	sp, 10h
		sub	ax, ax
		jmp	loc_13F0D
; ---------------------------------------------------------------------------

loc_13D79:				; CODE XREF: sub_13D1C+27j
		sub	ax, ax
		push	ax
		call	SetGDCPlane_Wrt
		add	sp, 2
		cmp	word_1AD98, 64h	; 'd'
		jge	short loc_13E03
		mov	ax, word_1AD98
		mov	[bp+var_2], ax
		push	word_1C1A6
		mov	ax, 36h	; '6'
		push	ax
		mov	ax, 2A30h
		push	ax
		mov	ax, 50h	; 'P'
		imul	[bp+var_2]
		add	ax, [bp+var_6]
		push	ax
		mov	ax, 1
		push	ax
		mov	ax, 36h	; '6'
		push	ax
		imul	[bp+var_2]
		add	ax, word ptr dword_1BCDC
		mov	dx, word ptr dword_1BCDC+2
		push	dx
		push	ax
		call	sub_14F8F
		add	sp, 10h
		mov	ax, 0C7h ; 'Ç'
		sub	ax, word_1AD98
		mov	[bp+var_2], ax
		push	word_1C1A6
		mov	ax, 36h	; '6'
		push	ax
		mov	ax, 2A30h
		push	ax
		mov	ax, 50h	; 'P'
		imul	[bp+var_2]
		add	ax, [bp+var_6]
		push	ax
		mov	ax, 1
		push	ax
		mov	ax, 36h	; '6'
		push	ax
		imul	[bp+var_2]
		add	ax, word ptr dword_1BCDC
		mov	dx, word ptr dword_1BCDC+2
		push	dx
		push	ax
		call	sub_14F8F
		add	sp, 10h
		add	word_1AD98, 3
		jmp	loc_13EFA
; ---------------------------------------------------------------------------

loc_13E03:				; CODE XREF: sub_13D1C+6Bj
		cmp	word_1AD98, 66h	; 'f'
		jnz	short loc_13E10
		mov	word_1AD98, 65h	; 'e'

loc_13E10:				; CODE XREF: sub_13D1C+ECj
		mov	ax, word_1AD98
		mov	[bp+var_2], ax
		push	word_1C1A6
		mov	ax, 36h	; '6'
		push	ax
		mov	ax, 2A30h
		push	ax
		mov	ax, 50h	; 'P'
		imul	[bp+var_2]
		add	ax, [bp+var_6]
		push	ax
		mov	ax, 1
		push	ax
		mov	ax, 36h	; '6'
		push	ax
		imul	[bp+var_2]
		add	ax, word ptr dword_1BCDC
		mov	dx, word ptr dword_1BCDC+2
		push	dx
		push	ax
		call	sub_14F8F
		add	sp, 10h
		mov	ax, word_1AD98
		inc	ax
		mov	[bp+var_2], ax
		push	word_1C1A6
		mov	ax, 36h	; '6'
		push	ax
		mov	ax, 2A30h
		push	ax
		mov	ax, 50h	; 'P'
		imul	[bp+var_2]
		add	ax, [bp+var_6]
		push	ax
		mov	ax, 1
		push	ax
		mov	ax, 36h	; '6'
		push	ax
		imul	[bp+var_2]
		add	ax, word ptr dword_1BCDC
		mov	dx, word ptr dword_1BCDC+2
		push	dx
		push	ax
		call	sub_14F8F
		add	sp, 10h
		mov	ax, 0C7h ; 'Ç'
		sub	ax, word_1AD98
		mov	[bp+var_2], ax
		push	word_1C1A6
		mov	ax, 36h	; '6'
		push	ax
		mov	ax, 2A30h
		push	ax
		mov	ax, 50h	; 'P'
		imul	[bp+var_2]
		add	ax, [bp+var_6]
		push	ax
		mov	ax, 1
		push	ax
		mov	ax, 36h	; '6'
		push	ax
		imul	[bp+var_2]
		add	ax, word ptr dword_1BCDC
		mov	dx, word ptr dword_1BCDC+2
		push	dx
		push	ax
		call	sub_14F8F
		add	sp, 10h
		mov	ax, 0C6h ; 'Æ'
		sub	ax, word_1AD98
		mov	[bp+var_2], ax
		push	word_1C1A6
		mov	ax, 36h	; '6'
		push	ax
		mov	ax, 2A30h
		push	ax
		mov	ax, 50h	; 'P'
		imul	[bp+var_2]
		add	ax, [bp+var_6]
		push	ax
		mov	ax, 1
		push	ax
		mov	ax, 36h	; '6'
		push	ax
		imul	[bp+var_2]
		add	ax, word ptr dword_1BCDC
		mov	dx, word ptr dword_1BCDC+2
		push	dx
		push	ax
		call	sub_14F8F
		add	sp, 10h
		add	word_1AD98, 3

loc_13EFA:				; CODE XREF: sub_13D1C+E4j
		cmp	word_1AD98, 0C8h ; 'È'
		jl	short loc_13F08
		sub	ax, ax
		jmp	short loc_13F0D
; ---------------------------------------------------------------------------
		jmp	short loc_13F0D
; ---------------------------------------------------------------------------

loc_13F08:				; CODE XREF: sub_13D1C+1E4j
		mov	ax, 1
		jmp	short $+2

loc_13F0D:				; CODE XREF: sub_13D1C+5Aj
					; sub_13D1C+1E8j ...
		mov	sp, bp
		pop	bp
		retn
sub_13D1C	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_13F11	proc near		; CODE XREF: ExecuteScript+BB1p
					; sub_13505+28Dp ...

var_2		= word ptr -2

		push	bp
		mov	bp, sp
		mov	ax, 2
		call	__chkstk
		mov	ax, 50h	; 'P'
		imul	word_1AB60
		add	ax, word_1AB5E
		mov	[bp+var_2], ax
		mov	ax, word_1B592
		mov	dx, word_1B594
		add	ax, 10h
		mov	word ptr dword_1C344, ax
		mov	word ptr dword_1C344+2,	dx
		push	word_1BCBC
		push	word_1BCBA
		sub	ax, ax
		push	ax
		push	ax
		les	bx, dword_1C344
		assume es:nothing
		mov	ax, es:[bx]
		add	ax, word_1B592
		push	dx
		push	ax
		call	sub_18093
		add	sp, 0Ch
		les	bx, dword_1C344
		mov	ax, 50h	; 'P'
		mul	word ptr es:[bx+4]
		mov	cl, es:[bx+2]
		sub	ch, ch
		add	ax, cx
		add	ax, [bp+var_2]
		push	ax
		push	word ptr es:[bx+6]
		mov	al, es:[bx+3]
		sub	ah, ah
		push	ax
		push	word_1BCBC
		push	word_1BCBA
		call	sub_15D82
		add	sp, 0Ah
		mov	sp, bp
		pop	bp
		retn
sub_13F11	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_13F8C	proc near		; CODE XREF: ExecuteScript:loc_1300Ap
		push	bp
		mov	bp, sp
		xor	ax, ax
		call	__chkstk
		mov	word_1C318, 0
		mov	word_1ADA2, 0
		mov	word_1ADA6, 0
		mov	word_1ADA8, 1
		mov	sp, bp
		pop	bp
		retn
sub_13F8C	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_13FB0	proc near		; CODE XREF: sub_17610+5Ap

var_A		= word ptr -0Ah
var_8		= word ptr -8
var_6		= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2

		push	bp
		mov	bp, sp
		mov	ax, 0Ah
		call	__chkstk
		mov	ax, 50h	; 'P'
		imul	word_1AB60
		add	ax, word_1AB5E
		mov	[bp+var_6], ax
		cmp	word_1ADA8, 0
		jnz	short loc_13FD1
		jmp	loc_140FB
; ---------------------------------------------------------------------------

loc_13FD1:				; CODE XREF: sub_13FB0+1Cj
		cmp	word_1C318, 4
		jl	short loc_13FE2
		cmp	word_1ADA6, 0
		jnz	short loc_13FE2
		jmp	loc_140FB
; ---------------------------------------------------------------------------

loc_13FE2:				; CODE XREF: sub_13FB0+26j
					; sub_13FB0+2Dj
		cmp	word_1ADA6, 0
		jz	short loc_13FEC
		jmp	loc_1406E
; ---------------------------------------------------------------------------

loc_13FEC:				; CODE XREF: sub_13FB0+37j
		mov	bx, word_1C318
		shl	bx, 1
		mov	ax, [bx+74Ah]
		mov	[bp+var_4], ax
		mov	bx, ax
		shl	bx, 1
		shl	bx, 1
		mov	ax, [bx+1CCAh]
		mov	dx, [bx+1CCCh]
		mov	[bp+var_A], ax
		mov	[bp+var_8], dx
		mov	bx, word_1ADA2
		mov	cl, 3
		shl	bx, cl
		add	ax, bx
		add	ax, 8
		mov	word ptr dword_1C344, ax
		mov	word ptr dword_1C344+2,	dx
		les	bx, dword_1C344
		push	word ptr es:[bx+6]
		mov	al, es:[bx+3]
		sub	ah, ah
		push	ax
		push	word ptr dword_1BCDC+2
		push	word ptr dword_1BCDC
		sub	ax, ax
		push	ax
		push	ax
		mov	ax, [bp+var_A]
		add	ax, es:[bx]
		push	dx
		push	ax
		call	sub_18171
		add	sp, 10h
		mov	word_1ADA4, 0
		inc	word_1ADA2
		mov	word_1ADA6, 1
		cmp	word_1ADA2, 4
		jl	short loc_1406B
		mov	word_1ADA2, 0
		inc	word_1C318

loc_1406B:				; CODE XREF: sub_13FB0+AFj
		jmp	loc_140FB
; ---------------------------------------------------------------------------

loc_1406E:				; CODE XREF: sub_13FB0+39j
		cmp	word_1ADA4, 64h	; 'd'
		jge	short loc_140EA
		mov	ax, word_1ADA4
		add	ax, 64h	; 'd'
		mov	[bp+var_2], ax
		mov	ax, 3
		push	ax
		mov	ax, 24h	; '$'
		push	ax
		mov	ax, 1C20h
		push	ax
		mov	ax, 50h	; 'P'
		imul	[bp+var_2]
		add	ax, [bp+var_6]
		push	ax
		mov	ax, 1
		push	ax
		mov	ax, 24h	; '$'
		push	ax
		imul	[bp+var_2]
		add	ax, word ptr dword_1BCDC
		mov	dx, word ptr dword_1BCDC+2
		push	dx
		push	ax
		call	sub_14F8F
		add	sp, 10h
		mov	ax, 63h	; 'c'
		sub	ax, word_1ADA4
		mov	[bp+var_2], ax
		mov	ax, 3
		push	ax
		mov	ax, 24h	; '$'
		push	ax
		mov	ax, 1C20h
		push	ax
		mov	ax, 50h	; 'P'
		imul	[bp+var_2]
		add	ax, [bp+var_6]
		push	ax
		mov	ax, 1
		push	ax
		mov	ax, 24h	; '$'
		push	ax
		imul	[bp+var_2]
		add	ax, word ptr dword_1BCDC
		mov	dx, word ptr dword_1BCDC+2
		push	dx
		push	ax
		call	sub_14F8F
		add	sp, 10h

loc_140EA:				; CODE XREF: sub_13FB0+C3j
		inc	word_1ADA4
		cmp	word_1ADA4, 76h	; 'v'
		jl	short loc_140FB
		mov	word_1ADA6, 0

loc_140FB:				; CODE XREF: sub_13FB0+1Ej
					; sub_13FB0+2Fj ...
		mov	sp, bp
		pop	bp
		retn
sub_13FB0	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_140FF	proc near		; CODE XREF: ExecuteScript+AD9p
					; ExecuteScript+AEFp

var_6		= word ptr -6
var_2		= word ptr -2
arg_0		= word ptr  4
arg_2		= word ptr  6

		push	bp
		mov	bp, sp
		mov	ax, 6
		call	__chkstk
		cmp	[bp+arg_0], 0
		jnz	short loc_14114
		mov	word_1ADAA, 0

loc_14114:				; CODE XREF: sub_140FF+Dj
		mov	ax, 50h	; 'P'
		imul	word_1AB60
		add	ax, word_1AB5E
		mov	[bp+var_6], ax
		mov	ax, 1
		push	ax
		call	SetGDCPlane_Wrt
		add	sp, 2
		mov	ax, 0C8h ; 'È'
		sub	ax, word_1ADAA
		mov	[bp+var_2], ax
		or	ax, ax
		jz	short loc_14164
		push	word_1C1A6
		mov	ax, 36h	; '6'
		push	ax
		mov	ax, 2A30h
		push	ax
		push	[bp+var_6]
		push	[bp+var_2]
		mov	ax, 36h	; '6'
		push	ax
		imul	word_1ADAA
		add	ax, word_1C322
		mov	dx, word_1C324
		push	dx
		push	ax
		call	sub_14F8F
		add	sp, 10h

loc_14164:				; CODE XREF: sub_140FF+39j
		mov	ax, [bp+var_2]
		add	ax, word_1AB60
		mov	cx, 50h	; 'P'
		imul	cx
		add	ax, word_1AB5E
		mov	[bp+var_6], ax
		cmp	word_1ADAA, 0
		jz	short loc_141A3
		push	word_1C1A6
		mov	ax, 36h	; '6'
		push	ax
		mov	ax, 2A30h
		push	ax
		push	[bp+var_6]
		push	word_1ADAA
		mov	ax, 36h	; '6'
		push	ax
		push	word_1C328
		push	word_1C326
		call	sub_14F8F
		add	sp, 10h

loc_141A3:				; CODE XREF: sub_140FF+7Dj
		call	sub_13F11
		mov	ax, [bp+arg_2]
		add	word_1ADAA, ax
		call	SwapGDCPlanes
		cmp	word_1ADAA, 0C8h ; 'È'
		jle	short loc_141BE
		sub	ax, ax
		jmp	short loc_141C3
; ---------------------------------------------------------------------------
		jmp	short loc_141C3
; ---------------------------------------------------------------------------

loc_141BE:				; CODE XREF: sub_140FF+B7j
		mov	ax, 1
		jmp	short $+2

loc_141C3:				; CODE XREF: sub_140FF+BBj
					; sub_140FF+BDj
		mov	sp, bp
		pop	bp
		retn
sub_140FF	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_141C7	proc near		; CODE XREF: ExecuteScript+D4Ep
					; ExecuteScript+D64p

var_6		= word ptr -6
var_2		= word ptr -2
arg_0		= word ptr  4
arg_2		= word ptr  6

		push	bp
		mov	bp, sp
		mov	ax, 6
		call	__chkstk
		cmp	[bp+arg_0], 0
		jnz	short loc_141DC
		mov	word_1ADAC, 208h

loc_141DC:				; CODE XREF: sub_141C7+Dj
		mov	[bp+var_6], 0A3Eh
		mov	ax, 1
		push	ax
		call	SetGDCPlane_Wrt
		add	sp, 2
		push	word_1C1A6
		mov	ax, 11h
		push	ax
		mov	ax, 2A80h
		push	ax
		push	[bp+var_6]
		mov	ax, 78h	; 'x'
		push	ax
		mov	ax, 11h
		push	ax
		imul	word_1ADAC
		add	ax, word_1BF98
		mov	dx, word_1BF9A
		push	dx
		push	ax
		call	sub_14F8F
		add	sp, 10h
		mov	ax, word_1ADAC
		mov	[bp+var_2], ax
		mov	ax, [bp+arg_2]
		sub	word_1ADAC, ax
		call	SwapGDCPlanes
		cmp	word_1ADAC, 0
		jge	short loc_14267
		mov	ax, 1
		push	ax
		call	SetGDCPlane_Wrt
		add	sp, 2
		push	word_1C1A6
		mov	ax, 11h
		push	ax
		mov	ax, 2A80h
		push	ax
		push	[bp+var_6]
		mov	ax, 78h	; 'x'
		push	ax
		mov	ax, 11h
		push	ax
		imul	[bp+var_2]
		add	ax, word_1BF98
		mov	dx, word_1BF9A
		push	dx
		push	ax
		call	sub_14F8F
		add	sp, 10h
		sub	ax, ax
		jmp	short loc_1426C
; ---------------------------------------------------------------------------
		jmp	short loc_1426C
; ---------------------------------------------------------------------------

loc_14267:				; CODE XREF: sub_141C7+64j
		mov	ax, 1
		jmp	short $+2

loc_1426C:				; CODE XREF: sub_141C7+9Cj
					; sub_141C7+9Ej
		mov	sp, bp
		pop	bp
		retn
sub_141C7	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_14270	proc near		; CODE XREF: sub_10A4B+71p
					; sub_11D81+13p ...

var_2		= word ptr -2

		push	bp
		mov	bp, sp
		mov	ax, 2
		call	__chkstk
		cmp	word_1AB42, 0
		jnz	short loc_14283
		jmp	loc_143E8
; ---------------------------------------------------------------------------

loc_14283:				; CODE XREF: sub_14270+Ej
		mov	ax, 50h	; 'P'
		imul	word_1AB60
		add	ax, word_1AB5E
		mov	[bp+var_2], ax
		mov	ax, 1
		push	ax
		call	SetGDCPlane_Wrt
		add	sp, 2
		mov	ax, 3
		push	ax
		mov	ax, 36h	; '6'
		push	ax
		mov	ax, 2A30h
		push	ax
		push	[bp+var_2]
		mov	ax, 0C8h ; 'È'
		push	ax
		mov	ax, 36h	; '6'
		push	ax
		push	word ptr dword_1BCDC+2
		push	word ptr dword_1BCDC
		call	sub_14F8F
		add	sp, 10h
		cmp	word_1AB4E, 0
		jnz	short loc_14336
		cmp	word_1C348, 0FFFFh
		jz	short loc_14336
		mov	ax, word_1C348
		mov	cl, 3
		shl	ax, cl
		add	ax, word_1C34A
		mov	dx, word_1C34C
		add	ax, 8
		mov	word ptr dword_1C344, ax
		mov	word ptr dword_1C344+2,	dx
		push	word_1BF9A
		push	word_1BF98
		sub	ax, ax
		push	ax
		push	ax
		les	bx, dword_1C344
		mov	ax, es:[bx]
		add	ax, word_1C34A
		push	dx
		push	ax
		call	sub_18093
		add	sp, 0Ch
		les	bx, dword_1C344
		mov	ax, 50h	; 'P'
		mul	word ptr es:[bx+4]
		mov	cl, es:[bx+2]
		sub	ch, ch
		add	ax, cx
		add	ax, [bp+var_2]
		push	ax
		push	word ptr es:[bx+6]
		mov	al, es:[bx+3]
		sub	ah, ah
		push	ax
		push	word_1BF9A
		push	word_1BF98
		call	sub_15D41
		add	sp, 0Ah

loc_14336:				; CODE XREF: sub_14270+55j
					; sub_14270+5Cj
		cmp	word_1C98A, 0FFFFh
		jz	short loc_143A5
		mov	ax, word_1C98A
		mov	cl, 3
		shl	ax, cl
		add	ax, word_1C98C
		mov	dx, word_1C98E
		add	ax, 8
		mov	word ptr dword_1C344, ax
		mov	word ptr dword_1C344+2,	dx
		push	word_1BF9A
		push	word_1BF98
		sub	ax, ax
		push	ax
		push	ax
		les	bx, dword_1C344
		mov	ax, es:[bx]
		add	ax, word_1C98C
		push	dx
		push	ax
		call	sub_18093
		add	sp, 0Ch
		les	bx, dword_1C344
		mov	ax, 50h	; 'P'
		mul	word ptr es:[bx+4]
		mov	cl, es:[bx+2]
		sub	ch, ch
		add	ax, cx
		add	ax, [bp+var_2]
		push	ax
		push	word ptr es:[bx+6]
		mov	al, es:[bx+3]
		sub	ah, ah
		push	ax
		push	word_1BF9A
		push	word_1BF98
		call	sub_15D41
		add	sp, 0Ah

loc_143A5:				; CODE XREF: sub_14270+CBj
		cmp	word_1AB4E, 0
		jnz	short loc_143DF
		mov	es, seg_1B488
		assume es:seg001
		mov	ax, 50h	; 'P'
		mul	es:word_1A644
		mov	cl, es:byte_1A642
		sub	ch, ch
		add	ax, cx
		add	ax, [bp+var_2]
		push	ax
		push	es:word_1A646
		mov	al, es:byte_1A643
		sub	ah, ah
		push	ax
		push	word_1BCBC
		push	word_1BCBA
		call	sub_15D41
		add	sp, 0Ah

loc_143DF:				; CODE XREF: sub_14270+13Aj
		call	SwapGDCPlanes
		mov	word_1AB42, 0

loc_143E8:				; CODE XREF: sub_14270+10j
		mov	sp, bp
		pop	bp
		retn
sub_14270	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_143EC	proc near		; CODE XREF: sub_17C81+41p

var_4		= word ptr -4
var_2		= word ptr -2

		push	bp
		mov	bp, sp
		mov	ax, 4
		call	__chkstk
		mov	ax, 50h	; 'P'
		imul	word_1AB60
		add	ax, word_1AB5E
		mov	[bp+var_4], ax
		cmp	word_1AB5A, 0
		jnz	short loc_1440D
		jmp	loc_144C5
; ---------------------------------------------------------------------------

loc_1440D:				; CODE XREF: sub_143EC+1Cj
		cmp	word_1AB46, 0
		jz	short loc_14417
		jmp	loc_144C5
; ---------------------------------------------------------------------------

loc_14417:				; CODE XREF: sub_143EC+26j
		mov	ax, 8
		push	ax
		call	sub_10522
		add	sp, 2
		add	ax, 8
		mov	word_1AB46, ax
		inc	word_1AB56
		mov	cx, 8
		mov	ax, word_1AB56
		cwd
		idiv	cx
		mov	word_1AB56, dx
		mov	bx, dx
		shl	bx, 1
		mov	ax, [bx+75Eh]
		mov	[bp+var_2], ax
		sub	ax, ax
		push	ax
		call	SetGDCPlane_Wrt
		add	sp, 2
		mov	ax, [bp+var_2]
		add	ax, word_1AB58
		mov	cl, 3
		shl	ax, cl
		add	ax, word ptr dword_1C334
		mov	dx, word ptr dword_1C334+2
		add	ax, 8
		mov	word ptr dword_1C344, ax
		mov	word ptr dword_1C344+2,	dx
		les	bx, dword_1C344
		assume es:nothing
		mov	ax, es:[bx+4]
		add	ax, word_1AB60
		push	ax
		mov	al, es:[bx+2]
		sub	ah, ah
		add	ax, word_1AB5E
		push	ax
		mov	ax, es:[bx]
		add	ax, word ptr dword_1C334
		push	dx
		push	ax
		call	sub_18031
		add	sp, 8
		mov	ax, 1
		push	ax
		call	SetGDCPlane_Wrt
		add	sp, 2
		les	bx, dword_1C344
		mov	ax, es:[bx+4]
		add	ax, word_1AB60
		push	ax
		mov	al, es:[bx+2]
		sub	ah, ah
		add	ax, word_1AB5E
		push	ax
		mov	ax, es:[bx]
		add	ax, word ptr dword_1C334
		mov	dx, word ptr dword_1C334+2
		push	dx
		push	ax
		call	sub_18031
		add	sp, 8

loc_144C5:				; CODE XREF: sub_143EC+1Ej
					; sub_143EC+28j
		mov	sp, bp
		pop	bp
		retn
sub_143EC	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_144C9	proc near		; CODE XREF: ExecuteScript+9CDp

var_2		= word ptr -2
arg_0		= word ptr  4
arg_2		= word ptr  6

		push	bp
		mov	bp, sp
		mov	ax, 2
		call	__chkstk
		mov	[bp+var_2], 0E64h
		mov	ax, 50h	; 'P'
		imul	word_1AB60
		add	ax, word_1AB5E
		mov	[bp+var_2], ax
		mov	ax, 1
		push	ax
		call	SetGDCPlane_Wrt
		add	sp, 2
		mov	ax, [bp+arg_0]
		mov	word_1C348, ax
		mov	ax, [bp+arg_2]
		mov	word_1C98A, ax
		mov	ax, 3
		push	ax
		mov	ax, 36h	; '6'
		push	ax
		mov	ax, 2A30h
		push	ax
		push	[bp+var_2]
		mov	ax, 0C8h ; 'È'
		push	ax
		mov	ax, 36h	; '6'
		push	ax
		push	word ptr dword_1BCDC+2
		push	word ptr dword_1BCDC
		call	sub_14F8F
		add	sp, 10h
		cmp	word_1AB4E, 0
		jnz	short loc_1458F
		mov	ax, word_1C348
		mov	cl, 3
		shl	ax, cl
		add	ax, word_1C34A
		mov	dx, word_1C34C
		add	ax, 8
		mov	word ptr dword_1C344, ax
		mov	word ptr dword_1C344+2,	dx
		push	word_1BF9A
		push	word_1BF98
		sub	ax, ax
		push	ax
		push	ax
		les	bx, dword_1C344
		mov	ax, es:[bx]
		add	ax, word_1C34A
		push	dx
		push	ax
		call	sub_18093
		add	sp, 0Ch
		les	bx, dword_1C344
		mov	ax, 50h	; 'P'
		mul	word ptr es:[bx+4]
		mov	cl, es:[bx+2]
		sub	ch, ch
		add	ax, cx
		add	ax, [bp+var_2]
		push	ax
		push	word ptr es:[bx+6]
		mov	al, es:[bx+3]
		sub	ah, ah
		push	ax
		push	word_1BF9A
		push	word_1BF98
		call	sub_15D41
		add	sp, 0Ah

loc_1458F:				; CODE XREF: sub_144C9+5Cj
		mov	ax, word_1C98A
		mov	cl, 3
		shl	ax, cl
		add	ax, word_1C98C
		mov	dx, word_1C98E
		add	ax, 8
		mov	word ptr dword_1C344, ax
		mov	word ptr dword_1C344+2,	dx
		push	word_1BF9A
		push	word_1BF98
		sub	ax, ax
		push	ax
		push	ax
		les	bx, dword_1C344
		mov	ax, es:[bx]
		add	ax, word_1C98C
		push	dx
		push	ax
		call	sub_18093
		add	sp, 0Ch
		les	bx, dword_1C344
		mov	ax, 50h	; 'P'
		mul	word ptr es:[bx+4]
		mov	cl, es:[bx+2]
		sub	ch, ch
		add	ax, cx
		add	ax, [bp+var_2]
		push	ax
		push	word ptr es:[bx+6]
		mov	al, es:[bx+3]
		sub	ah, ah
		push	ax
		push	word_1BF9A
		push	word_1BF98
		call	sub_15D41
		add	sp, 0Ah
		cmp	word_1AB4E, 0
		jnz	short loc_14631
		mov	es, seg_1B488
		assume es:seg001
		mov	ax, 50h	; 'P'
		mul	es:word_1A644
		mov	cl, es:byte_1A642
		sub	ch, ch
		add	ax, cx
		add	ax, [bp+var_2]
		push	ax
		push	es:word_1A646
		mov	al, es:byte_1A643
		sub	ah, ah
		push	ax
		push	word_1BCBC
		push	word_1BCBA
		call	sub_15D41
		add	sp, 0Ah

loc_14631:				; CODE XREF: sub_144C9+133j
		mov	sp, bp
		pop	bp
		retn
sub_144C9	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_14635	proc near		; CODE XREF: ExecuteScript+665p

var_A		= word ptr -0Ah
var_8		= word ptr -8
var_6		= word ptr -6
var_4		= dword	ptr -4
arg_0		= word ptr  4
arg_2		= word ptr  6
arg_4		= word ptr  8

		push	bp
		mov	bp, sp
		mov	ax, 0Ah
		call	__chkstk
		mov	ax, [bp+arg_4]
		mov	word_1AB44, ax
		mov	ax, 50h	; 'P'
		imul	word_1AB60
		add	ax, word_1AB5E
		mov	[bp+var_6], ax
		mov	ax, 1
		push	ax
		call	SetGDCPlane_Wrt
		add	sp, 2
		mov	bx, [bp+arg_0]
		shl	bx, 1
		shl	bx, 1
		mov	ax, word ptr dword_1C31A[bx]
		mov	dx, word ptr (dword_1C31A+2)[bx]
		mov	[bp+var_A], ax
		mov	[bp+var_8], dx
		mov	ax, [bp+arg_2]
		mov	cl, 3
		shl	ax, cl
		add	ax, [bp+var_A]
		add	ax, 8
		mov	word ptr dword_1C344, ax
		mov	word ptr dword_1C344+2,	dx
		mov	ax, [bp+var_A]
		les	bx, dword_1C344
		assume es:nothing
		add	ax, es:[bx]
		mov	word ptr [bp+var_4], ax
		mov	word ptr [bp+var_4+2], dx
		les	bx, [bp+var_4]
		cmp	byte ptr es:[bx], 41h ;	'A'
		jnz	short loc_1470D
		mov	ax, 3
		push	ax
		mov	ax, 36h	; '6'
		push	ax
		mov	ax, 2A30h
		push	ax
		push	[bp+var_6]
		mov	ax, 0C8h ; 'È'
		push	ax
		mov	ax, 36h	; '6'
		push	ax
		push	word ptr dword_1BCDC+2
		push	word ptr dword_1BCDC
		call	sub_14F8F
		add	sp, 10h
		push	word_1BF9A
		push	word_1BF98
		sub	ax, ax
		push	ax
		push	ax
		push	word ptr [bp+var_4+2]
		push	word ptr [bp+var_4]
		call	sub_18093
		add	sp, 0Ch
		les	bx, dword_1C344
		mov	ax, 50h	; 'P'
		mul	word ptr es:[bx+4]
		mov	cl, es:[bx+2]
		sub	ch, ch
		add	ax, cx
		add	ax, [bp+var_6]
		push	ax
		push	word ptr es:[bx+6]
		mov	al, es:[bx+3]
		sub	ah, ah
		push	ax
		push	word_1BF9A
		push	word_1BF98
		call	sub_15D41
		add	sp, 0Ah
		jmp	short loc_14731
; ---------------------------------------------------------------------------

loc_1470D:				; CODE XREF: sub_14635+67j
		les	bx, dword_1C344
		mov	ax, es:[bx+4]
		add	ax, word_1AB60
		push	ax
		mov	al, es:[bx+2]
		sub	ah, ah
		add	ax, word_1AB5E
		push	ax
		push	word ptr [bp+var_4+2]
		push	word ptr [bp+var_4]
		call	sub_18031
		add	sp, 8

loc_14731:				; CODE XREF: sub_14635+D6j
					; sub_14635+103j
		cmp	word_1AB44, 0
		jz	short loc_1473A
		jmp	short loc_14731
; ---------------------------------------------------------------------------

loc_1473A:				; CODE XREF: sub_14635+101j
		call	SwapGDCPlanes
		mov	sp, bp
		pop	bp
		retn
sub_14635	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_14741	proc near		; CODE XREF: ExecuteScript+654p

var_A		= word ptr -0Ah
var_8		= word ptr -8
var_6		= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  4
arg_2		= word ptr  6

		push	bp
		mov	bp, sp
		mov	ax, 0Ah
		call	__chkstk
		mov	ax, 50h	; 'P'
		imul	word_1AB60
		add	ax, word_1AB5E
		mov	[bp+var_6], ax
		sub	ax, ax
		push	ax
		call	SetGDCPlane_Wrt
		add	sp, 2
		mov	bx, [bp+arg_0]
		shl	bx, 1
		shl	bx, 1
		mov	ax, word ptr dword_1C31A[bx]
		mov	dx, word ptr (dword_1C31A+2)[bx]
		mov	[bp+var_A], ax
		mov	[bp+var_8], dx
		mov	ax, [bp+arg_2]
		mov	cl, 3
		shl	ax, cl
		add	ax, [bp+var_A]
		add	ax, 8
		mov	word ptr dword_1C344, ax
		mov	word ptr dword_1C344+2,	dx
		mov	ax, [bp+var_A]
		les	bx, dword_1C344
		add	ax, es:[bx]
		mov	[bp+var_4], ax
		mov	[bp+var_2], dx
		mov	ax, es:[bx+4]
		add	ax, word_1AB60
		push	ax
		mov	al, es:[bx+2]
		sub	ah, ah
		add	ax, word_1AB5E
		push	ax
		push	dx
		push	[bp+var_4]
		call	sub_18031
		add	sp, 8
		mov	sp, bp
		pop	bp
		retn
sub_14741	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

; int __cdecl malloc(int, size_t)
malloc		proc near		; CODE XREF: _main+2Ep	_main+3Fp ...

var_8		= word ptr -8
var_6		= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  4
arg_2		= word ptr  6

		push	bp
		mov	bp, sp
		mov	ax, 0Ch
		call	__chkstk
		mov	[bp+var_4], 0
		mov	[bp+var_2], 0A000h
		push	[bp+arg_2]	; size_t
		call	__fmalloc
		add	sp, 2
		mov	bx, [bp+arg_0]
		mov	[bx], ax
		mov	[bx+2],	dx
		or	dx, ax
		jnz	short loc_14803
		cmp	debugMode, 0
		jz	short loc_147F9
		push	word_1ADD6
		mov	ax, offset aMemoryErrNo_D ; "\nmemory Err NO.%d\n"
		push	ax		; char *
		call	_printf
		add	sp, 4

loc_147F9:				; CODE XREF: malloc+2Dj
		mov	ax, 1
		push	ax		; int
		call	_exit
; ---------------------------------------------------------------------------
		add	sp, 2

loc_14803:				; CODE XREF: malloc+26j
		mov	ax, [bp+var_4]
		mov	bx, [bp+arg_0]
		sub	ax, [bx]
		cwd
		mov	[bp+var_8], ax
		mov	[bp+var_6], dx
		inc	word_1ADD6
		mov	sp, bp
		pop	bp
		retn
malloc		endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

DoSomeGDCFill	proc near		; CODE XREF: ExecuteScript:loc_12A17p
					; _main+12Ap
		push	bp
		mov	bp, sp
		xor	ax, ax
		call	__chkstk
		sub	ax, ax
		push	ax
		mov	ax, 0A6h
		push	ax
		call	WritePort
		add	sp, 4
		mov	ax, 400
		push	ax
		mov	ax, 80
		push	ax
		sub	ax, ax
		push	ax
		push	ax
		push	ax
		call	sub_15720
		add	sp, 0Ah
		mov	ax, 1
		push	ax
		mov	ax, 0A6h
		push	ax
		call	WritePort
		add	sp, 4
		mov	ax, 400
		push	ax
		mov	ax, 80
		push	ax
		sub	ax, ax
		push	ax
		push	ax
		push	ax
		call	sub_15720
		add	sp, 0Ah
		mov	sp, bp
		pop	bp
		retn
DoSomeGDCFill	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

; int __cdecl main(int argc, const char	**argv,	const char **envp)
_main		proc near		; CODE XREF: start+8Dp

var_6		= word ptr -6
var_4		= word ptr -4
arg_0		= word ptr  4
arg_2		= word ptr  6

		push	bp
		mov	bp, sp
		mov	ax, 6
		call	__chkstk
		mov	[bp+var_4], 1
		cmp	[bp+arg_0], 2
		jle	short loc_14881
		mov	debugMode, 1

loc_14881:				; CODE XREF: _main+12j
		call	j_SetupIntA6
		call	GetHourSecs
		mov	word_1ABF0, ax
		mov	ax, 0FA00h
		sub	dx, dx
		push	dx
		push	ax		; size_t
		mov	ax, offset scrDataPtr
		push	ax		; int
		call	malloc
		add	sp, 6
		mov	ax, 0FA00h
		sub	dx, dx
		push	dx
		push	ax		; size_t
		mov	ax, offset dword_1C31A
		push	ax		; int
		call	malloc
		add	sp, 6
		mov	ax, 0FA00h
		sub	dx, dx
		push	dx
		push	ax		; size_t
		mov	ax, offset word_1C31E
		push	ax		; int
		call	malloc
		add	sp, 6
		mov	ax, 0FA00h
		sub	dx, dx
		push	dx
		push	ax		; size_t
		mov	ax, offset word_1C322
		push	ax		; int
		call	malloc
		add	sp, 6
		mov	ax, 0FA00h
		sub	dx, dx
		push	dx
		push	ax		; size_t
		mov	ax, offset word_1C326
		push	ax		; int
		call	malloc
		add	sp, 6
		mov	ax, 0FA00h
		sub	dx, dx
		push	dx
		push	ax		; size_t
		mov	ax, offset tBoxBufferPtr
		push	ax		; int
		call	malloc
		add	sp, 6
		mov	ax, 0A8C0h
		sub	dx, dx
		push	dx
		push	ax		; size_t
		mov	ax, offset dword_1C1A8
		push	ax		; int
		call	malloc
		add	sp, 6
		mov	ax, 7D0h
		push	ax		; size_t
		mov	ax, offset word_1B592
		push	ax		; int
		call	malloc
		add	sp, 4
		mov	ax, word_1C31E
		mov	dx, word_1C320
		mov	word ptr dword_1BCDC, ax
		mov	word ptr dword_1BCDC+2,	dx
		add	ax, 0A8C0h
		mov	word_1BCBA, ax
		mov	word_1BCBC, dx
		mov	ax, word_1C326
		mov	dx, word_1C328
		mov	word_1BF98, ax
		mov	word_1BF9A, dx
		mov	word_1BF8A, ax
		mov	word_1BF8C, dx
		add	ax, 2260h
		mov	word_1BF94, ax
		mov	word_1BF96, dx
		add	ax, 2260h
		mov	word_1BF9C, ax
		mov	word_1BF9E, dx
		add	ax, 2260h
		mov	word_1BFA0, ax
		mov	word_1BFA2, dx
		mov	ax, word_1C322
		mov	dx, word_1C324
		mov	word ptr dword_1C334, ax
		mov	word ptr dword_1C334+2,	dx
		mov	ax, word ptr scrDataPtr
		mov	dx, word ptr scrDataPtr+2
		mov	word ptr scrDataBasePtr, ax
		mov	word ptr scrDataBasePtr+2, dx
		call	sub_1525B
		mov	ax, 0C0h ; 'À'
		push	ax
		call	sub_1526A
		add	sp, 2
		mov	ax, 1
		push	ax
		mov	ax, 6Ah
		push	ax
		call	WritePort
		add	sp, 4
		call	DoSomeGDCFill
		call	SetupInt0C
		call	SwapGDCPlanes
		call	sub_1524C
		call	sub_16748
		cmp	debugMode, 0
		jnz	short loc_149B0
		sub	ax, ax
		push	ax
		call	sub_16889
		add	sp, 2

loc_149B0:				; CODE XREF: _main+13Ej
		call	LoadClearPBD
		call	CalcTBoxThing
		cmp	[bp+arg_0], 1
		jle	short loc_149C8
		mov	bx, [bp+arg_2]
		push	word ptr [bx+2]	; char *
		call	sub_103B0
		add	sp, 2

loc_149C8:				; CODE XREF: _main+153j
		call	ExecuteScript
		mov	[bp+var_6], ax
		call	RestoreInt0C
		mov	sp, bp
		pop	bp
		retn
_main		endp

; ---------------------------------------------------------------------------
		align 2
		push	bp		; [unused] ??
		mov	bp, sp
		push	di
		push	si
		push	ds
		push	es
		cld
		mov	ax, [bp+6]
		mov	ds, ax
		mov	si, [bp+4]
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		mov	di, [bp+0Ch]
		mov	dx, di
		mov	bx, [bp+0Ah]

loc_149F3:				; CODE XREF: seg000:49FEj
		mov	di, dx
		mov	cx, [bp+8]
		rep movsw
		add	dx, 50h
		dec	bx
		jnz	short loc_149F3
		mov	ax, 0B000h
		mov	es, ax
		assume es:nothing
		mov	di, [bp+0Ch]
		mov	dx, di
		mov	bx, [bp+0Ah]

loc_14A0D:				; CODE XREF: seg000:4A18j
		mov	di, dx
		mov	cx, [bp+8]
		rep movsw
		add	dx, 50h
		dec	bx
		jnz	short loc_14A0D
		mov	ax, 0B800h
		mov	es, ax
		assume es:nothing
		mov	di, [bp+0Ch]
		mov	dx, di
		mov	bx, [bp+0Ah]

loc_14A27:				; CODE XREF: seg000:4A32j
		mov	di, dx
		mov	cx, [bp+8]
		rep movsw
		add	dx, 50h
		dec	bx
		jnz	short loc_14A27
		pop	es
		assume es:nothing
		pop	ds
		pop	si
		pop	di
		pop	bp
		retn
; ---------------------------------------------------------------------------
		push	bp		; [unused] ??
		mov	bp, sp
		push	di
		push	si
		push	ds
		push	es
		cld
		mov	ax, [bp+6]
		mov	ds, ax
		mov	si, [bp+4]
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		mov	di, [bp+0Ch]
		mov	dx, di
		mov	ax, [bp+0Ah]
		mov	bx, 50h

loc_14A5A:				; CODE XREF: seg000:4A64j
		mov	di, dx
		mov	cx, [bp+8]
		rep movsw
		add	dx, bx
		dec	ax
		jnz	short loc_14A5A
		mov	si, [bp+4]
		add	si, [bp+0Eh]
		mov	ax, 0B000h
		mov	es, ax
		assume es:nothing
		mov	di, [bp+0Ch]
		mov	dx, di
		mov	ax, [bp+0Ah]
		mov	bx, 50h

loc_14A7C:				; CODE XREF: seg000:4A86j
		mov	di, dx
		mov	cx, [bp+8]
		rep movsw
		add	dx, bx
		dec	ax
		jnz	short loc_14A7C
		mov	si, [bp+4]
		add	si, [bp+0Eh]
		add	si, [bp+0Eh]
		mov	ax, 0B800h
		mov	es, ax
		assume es:nothing
		mov	di, [bp+0Ch]
		mov	dx, di
		mov	ax, [bp+0Ah]
		mov	bx, 50h

loc_14AA1:				; CODE XREF: seg000:4AABj
		mov	di, dx
		mov	cx, [bp+8]
		rep movsw
		add	dx, bx
		dec	ax
		jnz	short loc_14AA1
		mov	si, [bp+4]
		add	si, [bp+0Eh]
		add	si, [bp+0Eh]
		add	si, [bp+0Eh]
		mov	ax, 0E000h
		mov	es, ax
		assume es:nothing
		mov	di, [bp+0Ch]
		mov	dx, di
		mov	ax, [bp+0Ah]
		mov	bx, 50h

loc_14AC9:				; CODE XREF: seg000:4AD3j
		mov	di, dx
		mov	cx, [bp+8]
		rep movsw
		add	dx, bx
		dec	ax
		jnz	short loc_14AC9
		pop	es
		assume es:nothing
		pop	ds
		pop	si
		pop	di
		pop	bp
		retn

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_14ADB	proc near		; CODE XREF: sub_118DA+171p
					; sub_1332F+F4p ...

arg_0		= word ptr  4
arg_2		= word ptr  6
arg_4		= word ptr  8
arg_6		= word ptr  0Ah
arg_8		= word ptr  0Ch
arg_A		= word ptr  0Eh

		push	bp
		mov	bp, sp
		push	di
		push	si
		push	ds
		push	es
		cld
		mov	ax, [bp+arg_2]
		mov	ds, ax
		mov	es, ax
		mov	si, [bp+arg_0]
		mov	bx, [bp+arg_4]
		mov	dx, [bp+arg_A]

loc_14AF3:				; CODE XREF: sub_14ADB+2Fj
		push	si
		mov	cx, [bp+arg_6]

loc_14AF7:				; CODE XREF: sub_14ADB+28j
		mov	ah, [si]
		mov	al, [si+1]
		shl	ax, 4
		mov	[si], ah
		add	si, bx
		loop	loc_14AF7
		pop	si
		add	si, [bp+arg_8]
		dec	dx
		jnz	short loc_14AF3
		pop	es
		pop	ds
		pop	si
		pop	di
		pop	bp
		retn
sub_14ADB	endp

; ---------------------------------------------------------------------------
byte_14B12	db 0FFh, 7Fh, 3Fh, 1Fh,	0Fh,   7,   3,	 1 ; DATA XREF:	DrawBox+B4o
					; DrawBox+E1o
byte_14B1A	db  80h, 40h, 20h, 10h,	  8,   4,   2,	 1 ; DATA XREF:	DrawBox+70o
					; DrawBox+92o
word_14B22	dw 0			; DATA XREF: DrawBox+5Cw DrawBox+78r ...
word_14B24	dw 0			; DATA XREF: DrawBox+33w DrawBox+9Ar ...
word_14B26	dw 0			; DATA XREF: DrawBox+4Fw DrawBox+73r ...
word_14B28	dw 0			; DATA XREF: DrawBox+41w DrawBox+B7r ...

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

DrawBox		proc near		; CODE XREF: DrawTBoxBorder+73p
					; DrawTBoxBorder+BDp

arg_0		= word ptr  4
arg_2		= word ptr  6
arg_4		= word ptr  8
arg_6		= word ptr  0Ah
arg_8		= word ptr  0Ch
arg_A		= word ptr  0Eh

		push	bp
		mov	bp, sp
		push	di
		push	si
		push	ds
		push	es
		cld
		push	cs
		pop	ds
		assume ds:seg000
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		mov	si, [bp+arg_8]
		shl	si, 2
		add	si, offset byte_14C46
		mov	ax, [bp+arg_A]
		or	ax, 0C0h
		out	7Ch, al
		mov	dx, 7Eh
		outsb
		outsb
		outsb
		outsb
		mov	ax, [bp+arg_0]
		mov	bx, [bp+arg_4]
		mov	dx, bx
		and	dx, 7
		mov	cs:word_14B24, dx
		shr	bx, 3
		shr	ax, 3
		sub	bx, ax
		inc	bx
		mov	cs:word_14B28, bx
		mov	ax, [bp+arg_2]
		mov	bx, [bp+arg_6]
		sub	bx, ax
		inc	bx
		mov	cs:word_14B26, bx
		mov	ax, [bp+arg_0]
		mov	dx, ax
		and	dx, 7
		mov	cs:word_14B22, dx
		shr	ax, 3
		mov	di, ax
		mov	ax, [bp+arg_2]
		mov	bx, 50h	; 'P'
		mul	bx
		add	di, ax
		mov	bx, offset byte_14B1A
		mov	cx, cs:word_14B26
		mov	ax, cs:word_14B22
		xlat
		call	DrawVertBar
		mov	ax, [bp+arg_4]
		shr	ax, 3
		mov	di, ax
		mov	ax, [bp+arg_2]
		mov	bx, 50h	; 'P'
		mul	bx
		add	di, ax
		mov	bx, offset byte_14B1A
		mov	cx, cs:word_14B26
		mov	ax, cs:word_14B24
		xlat
		call	DrawVertBar
		mov	ax, [bp+arg_0]
		shr	ax, 3
		mov	di, ax
		mov	ax, [bp+arg_2]
		mov	bx, 50h	; 'P'
		mul	bx
		add	di, ax
		mov	bx, offset byte_14B12
		mov	cx, cs:word_14B28
		mov	ax, cs:word_14B22
		xlat
		mov	dl, al
		mov	ax, cs:word_14B24
		xlat
		xor	al, 0FFh
		mov	dh, al
		call	DrawHorzBar
		mov	ax, [bp+arg_0]
		shr	ax, 3
		mov	di, ax
		mov	ax, [bp+arg_6]
		mov	bx, 50h	; 'P'
		mul	bx
		add	di, ax
		mov	bx, offset byte_14B12
		mov	cx, cs:word_14B28
		mov	ax, cs:word_14B22
		xlat
		mov	dl, al
		mov	ax, cs:word_14B24
		xlat
		xor	al, 0FFh
		mov	dh, al
		call	DrawHorzBar
		xor	al, al
		out	7Ch, al
		pop	es
		assume es:nothing
		pop	ds
		assume ds:dseg
		pop	si
		pop	di
		pop	bp
		retn
DrawBox		endp


; =============== S U B	R O U T	I N E =======================================


DrawVertBar	proc near		; CODE XREF: DrawBox+7Dp DrawBox+9Fp ...
		mov	es:[di], al
		add	di, 50h
		loop	DrawVertBar
		retn
DrawVertBar	endp


; =============== S U B	R O U T	I N E =======================================


DrawHorzBar	proc near		; CODE XREF: DrawBox+CCp DrawBox+F9p
		mov	al, dl
		stosb
		dec	cx
		dec	cx
		mov	al, 0FFh
		rep stosb
		mov	al, dh
		stosb
		retn
DrawHorzBar	endp

; ---------------------------------------------------------------------------
byte_14C46	db    0,   0,	0,   0	; DATA XREF: DrawBox+15o sub_14CC2+18o ...
		db 0FFh,   0,	0,   0
		db    0,0FFh,	0,   0
		db 0FFh,0FFh,	0,   0
		db    0,   0,0FFh,   0
		db 0FFh,   0,0FFh,   0
		db    0,0FFh,0FFh,   0
		db 0FFh,0FFh,0FFh,   0
		db    0,   0,	0,0FFh
		db 0FFh,   0,	0,0FFh
		db    0,0FFh,	0,0FFh
		db 0FFh,0FFh,	0,0FFh
		db    0,   0,0FFh,0FFh
		db 0FFh,   0,0FFh,0FFh
		db    0,0FFh,0FFh,0FFh
		db 0FFh,0FFh,0FFh,0FFh

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

CopyTextBuffer	proc near		; CODE XREF: CopyTextBuffer2+3Fp

arg_destPtr	= word ptr  4
arg_destSeg	= word ptr  6
arg_sourcePtr	= word ptr  8
arg_sourceSeg	= word ptr  0Ah
arg_lineSize	= byte ptr  0Ch
arg_numLines	= byte ptr  0Eh
arg_C		= word ptr  10h

		push	bp
		mov	bp, sp
		push	di
		push	si
		push	ds
		push	es
		cld
		mov	ax, [bp+arg_destSeg]
		mov	es, ax
		mov	dx, [bp+arg_destPtr]
		mov	ax, [bp+arg_sourceSeg]
		mov	ds, ax
		mov	si, [bp+arg_sourcePtr]
		mov	ah, [bp+arg_numLines]
		mov	al, [bp+arg_lineSize]
		xor	cx, cx

loc_14CA6:				; CODE XREF: CopyTextBuffer+34j
		mov	bl, 18		; text glyph height

loc_14CA8:				; CODE XREF: CopyTextBuffer+2Dj
		mov	di, dx
		mov	cl, al
		rep movsb
		add	dx, 50h
		dec	bl
		jnz	short loc_14CA8
		add	si, [bp+arg_C]
		dec	ah
		jnz	short loc_14CA6
		pop	es
		pop	ds
		pop	si
		pop	di
		pop	bp
		retn
CopyTextBuffer	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_14CC2	proc near		; CODE XREF: sub_106F6+C8p
					; sub_106F6+109p ...

arg_0		= word ptr  4
arg_2		= word ptr  6
arg_4		= word ptr  8
arg_6		= word ptr  0Ah

		push	bp
		mov	bp, sp
		push	di
		push	si
		push	ds
		push	es
		cld
		push	cs
		pop	ds
		assume ds:seg000
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		mov	di, [bp+arg_0]
		mov	si, [bp+arg_2]
		shl	si, 2
		add	si, offset byte_14C46
		mov	ax, 0C0h
		out	7Ch, al
		mov	dx, 7Eh
		outsb
		outsb
		outsb
		outsb
		mov	cx, [bp+arg_4]
		mov	ax, [bp+arg_6]
		mov	bx, 50h

loc_14CF3:				; CODE XREF: sub_14CC2+36j
		mov	es:[di], ax
		add	di, bx
		loop	loc_14CF3
		xor	ax, ax
		out	7Ch, al
		pop	es
		assume es:nothing
		pop	ds
		assume ds:dseg
		pop	si
		pop	di
		pop	bp
		retn
sub_14CC2	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_14D04	proc near		; CODE XREF: sub_10819+13Dp
					; sub_10819+15Cp

arg_0		= word ptr  4
arg_2		= word ptr  6
arg_4		= word ptr  8

		push	bp
		mov	bp, sp
		push	di
		push	si
		push	ds
		push	es
		cld
		push	cs
		pop	ds
		assume ds:seg000
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		mov	di, [bp+arg_0]
		mov	si, offset byte_14C46
		mov	ax, 0C0h
		out	7Ch, al
		mov	dx, 7Eh
		outsb
		outsb
		outsb
		outsb
		mov	cx, [bp+arg_4]
		mov	ax, [bp+arg_2]
		mov	bx, 16h
		mul	bx
		mov	si, offset word_14D47
		add	si, ax
		mov	bx, 4Eh

loc_14D38:				; CODE XREF: sub_14D04+37j
		movsw
		add	di, bx
		loop	loc_14D38
		xor	ax, ax
		out	7Ch, al
		pop	es
		assume es:nothing
		pop	ds
		assume ds:dseg
		pop	si
		pop	di
		pop	bp
		retn
sub_14D04	endp

; ---------------------------------------------------------------------------
word_14D47	dw   180h,  180h,  180h,  180h,	 180h,	180h,  180h,  180h,  180h,  180h,    -1
					; DATA XREF: sub_14D04+2Co
		dw     -1,  3C0h,  3C0h,  3C0h,	 3C0h,	3C0h,  3C0h,  3C0h,  3C0h,  3C0h,    -1
		dw     -1,  7E0h,  7E0h,  7E0h,	 7E0h,	7E0h,  7E0h,  7E0h,  7E0h,    -1,    -1
		dw     -1,  7E0h,  7E0h,  7E0h,	 7E0h,	7E0h,  7E0h,  7E0h,  7E0h,    -1,    -1
		dw     -1,    -1, 0FF0h, 0FF0h,	0FF0h, 0FF0h, 0FF0h, 0FF0h, 0FF0h,    -1,    -1
		dw     -1,    -1, 1FF8h, 1FF8h,	1FF8h, 1FF8h, 1FF8h, 1FF8h,    -1,    -1,    -1
		dw     -1,    -1,    -1, 3FFCh,	3FFCh, 3FFCh, 3FFCh,	-1,    -1,    -1,    -1
		dw     -1,    -1,    -1,    -1,	7FFEh, 7FFEh,	 -1,	-1,    -1,    -1,    -1
		dw     -1,    -1,    -1,    -1,	   -1,	  -1,	 -1,	-1,    -1,    -1,    -1
		db    0
		db    0
		db    0
		db    0
word_14E11	dw 0			; DATA XREF: sub_14E21+12w
					; sub_14E66+21r
word_14E13	dw 0			; DATA XREF: sub_14E21+19w
					; sub_14E66:loc_14EA7r
word_14E15	dw 0			; DATA XREF: sub_14E66+7w
					; sub_14E66:loc_14E77w	...
		db 2 dup(0)
word_14E19	dw 0			; DATA XREF: sub_14E21+23w
					; sub_14E66+28r
word_14E1B	dw 0			; DATA XREF: sub_14E66w sub_14E66+16w	...
word_14E1D	dw 0			; DATA XREF: sub_14E21+Bw
					; sub_14E66+51r
		db 2 dup(0)

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_14E21	proc near		; CODE XREF: seg000:8167p

arg_0		= word ptr  4
arg_2		= word ptr  6
arg_4		= word ptr  8
arg_6		= word ptr  0Ah
arg_8		= word ptr  0Ch
arg_A		= word ptr  0Eh
arg_C		= word ptr  10h
arg_E		= word ptr  12h
arg_10		= word ptr  14h

		push	bp
		mov	bp, sp
		push	di
		push	si
		push	ds
		push	es
		cld
		mov	ax, [bp+arg_10]
		mov	cs:word_14E1D, ax
		mov	ax, [bp+arg_0]
		mov	cs:word_14E11, ax
		mov	ax, [bp+arg_2]
		mov	cs:word_14E13, ax
		mov	ax, [bp+arg_4]
		add	ax, [bp+arg_C]
		mov	cs:word_14E19, ax
		mov	ax, [bp+arg_A]
		cmp	ax, 0FFFFh
		jz	short loc_14E52
		mov	ds, ax

loc_14E52:				; CODE XREF: sub_14E21+2Dj
		mov	si, [bp+arg_8]
		mov	ax, [bp+arg_E]
		mov	es, ax
		mov	dx, [bp+arg_6]
		call	sub_14E66
		pop	es
		pop	ds
		pop	si
		pop	di
		pop	bp
		retn
sub_14E21	endp


; =============== S U B	R O U T	I N E =======================================


sub_14E66	proc near		; CODE XREF: sub_14E21+3Cp
		mov	cs:word_14E1B, 0
		mov	cs:word_14E15, 0
		jmp	short loc_14E83
; ---------------------------------------------------------------------------
		db 90h
; ---------------------------------------------------------------------------

loc_14E77:				; CODE XREF: sub_14E66+56j
		inc	cs:word_14E15
		mov	cs:word_14E1B, 0

loc_14E83:				; CODE XREF: sub_14E66+Ej
					; sub_14E66+58j
		mov	ax, cs:word_14E15
		cmp	ax, cs:word_14E11
		jz	short locret_14ED9
		add	ax, cs:word_14E19
		mov	di, ax
		mov	bp, dx
		mov	cx, cs:word_14E1B
		mov	ax, 2A30h
		mul	cx
		add	di, ax
		mov	dx, bp
		xor	bp, bp

loc_14EA7:				; CODE XREF: sub_14E66:loc_14EDAj
					; seg000:4EE3j	...
		cmp	bp, cs:word_14E13
		jl	short loc_14EC0
		inc	cs:word_14E1B
		mov	ax, cs:word_14E1B
		cmp	ax, cs:word_14E1D
		jz	short loc_14E77
		jmp	short loc_14E83
; ---------------------------------------------------------------------------

loc_14EC0:				; CODE XREF: sub_14E66+46j
		lodsb
		mov	cx, ax
		and	cx, 1Fh
		or	cx, cx
		jz	short loc_14EDA
		and	ax, 0E0h
		shr	ax, 4
		mov	bx, ax
		add	bx, offset off_14F5D
		jmp	word ptr cs:[bx]
; ---------------------------------------------------------------------------

locret_14ED9:				; CODE XREF: sub_14E66+26j
		retn
; ---------------------------------------------------------------------------

loc_14EDA:				; CODE XREF: sub_14E66+62j
		jmp	short loc_14EA7
sub_14E66	endp

; ---------------------------------------------------------------------------

loc_14EDC:				; DATA XREF: seg000:off_14F5Do
		add	bp, cx

loc_14EDE:				; CODE XREF: seg000:4EE1j
		movsb
		add	di, dx
		loop	loc_14EDE
		jmp	short loc_14EA7
; ---------------------------------------------------------------------------

loc_14EE5:				; DATA XREF: seg000:off_14F5Do
		add	bp, cx
		lodsb

loc_14EE8:				; CODE XREF: seg000:4EEBj
		stosb
		add	di, dx
		loop	loc_14EE8
		jmp	short loc_14EA7
; ---------------------------------------------------------------------------

loc_14EEF:				; DATA XREF: seg000:off_14F5Do
		lodsw
		mov	bx, cx
		shl	bx, 1
		add	bp, bx

loc_14EF6:				; CODE XREF: seg000:4F00j
		stosb
		add	di, dx
		xchg	al, ah
		stosb
		add	di, dx
		xchg	al, ah
		loop	loc_14EF6
		jmp	short loc_14EA7
; ---------------------------------------------------------------------------

loc_14F04:				; DATA XREF: seg000:off_14F5Do
		mov	bx, cx
		shl	bx, 2
		add	bp, bx

loc_14F0B:				; CODE XREF: seg000:4F1Aj
		movsb
		add	di, dx
		movsb
		add	di, dx
		movsb
		add	di, dx
		movsb
		add	di, dx
		sub	si, 4
		loop	loc_14F0B
		add	si, 4
		jmp	short loc_14EA7
; ---------------------------------------------------------------------------

loc_14F21:				; DATA XREF: seg000:off_14F5Do
		add	bp, cx
		mov	bx, 2A30h
		neg	bx

loc_14F28:				; CODE XREF: seg000:4F2Ej
		mov	al, es:[bx+di]
		stosb
		add	di, dx
		loop	loc_14F28
		jmp	loc_14EA7
; ---------------------------------------------------------------------------

loc_14F33:				; DATA XREF: seg000:off_14F5Do
		add	bp, cx
		mov	bx, 5460h
		neg	bx

loc_14F3A:				; CODE XREF: seg000:4F40j
		mov	al, es:[bx+di]
		stosb
		add	di, dx
		loop	loc_14F3A
		jmp	loc_14EA7
; ---------------------------------------------------------------------------

loc_14F45:				; DATA XREF: seg000:off_14F5Do
		add	bp, cx
		mov	al, 0

loc_14F49:				; CODE XREF: seg000:4F4Cj
		stosb
		add	di, dx
		loop	loc_14F49
		jmp	loc_14EA7
; ---------------------------------------------------------------------------

loc_14F51:				; DATA XREF: seg000:off_14F5Do
		add	bp, cx
		mov	al, 0FFh

loc_14F55:				; CODE XREF: seg000:4F58j
		stosb
		add	di, dx
		loop	loc_14F55
		jmp	loc_14EA7
; ---------------------------------------------------------------------------
off_14F5D	dw offset loc_14EDC	; 0 ; DATA XREF: sub_14E66+6Co
		dw offset loc_14EE5	; 1
		dw offset loc_14EEF	; 2
		dw offset loc_14F04	; 3
		dw offset loc_14F21	; 4
		dw offset loc_14F33	; 5
		dw offset loc_14F45	; 6
		dw offset loc_14F51	; 7

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_14F6D	proc near		; CODE XREF: sub_11C4E+38p
					; sub_11C4E+4Dp ...

arg_0		= word ptr  4
arg_2		= word ptr  6
arg_4		= word ptr  8
arg_6		= word ptr  0Ah

		push	bp
		mov	bp, sp
		push	di
		push	si
		push	ds
		push	es
		cld
		mov	ax, [bp+arg_2]
		mov	es, ax
		mov	di, [bp+arg_0]
		mov	cx, [bp+arg_4]
		mov	ax, [bp+arg_6]
		rep stosb
		pop	es
		pop	ds
		pop	si
		pop	di
		pop	bp
		retn
sub_14F6D	endp

; ---------------------------------------------------------------------------
word_14F8B	dw 0			; DATA XREF: sub_14F8F+Ew
					; sub_14F8F+48r ...
word_14F8D	dw 0			; DATA XREF: sub_14F8F+2Dw
					; sub_14F8F+3Aw ...

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_14F8F	proc near		; CODE XREF: sub_10F59+38p
					; sub_11804+A4p ...

arg_0		= word ptr  4
arg_2		= word ptr  6
arg_4		= word ptr  8
arg_6		= word ptr  0Ah
arg_8		= word ptr  0Ch
arg_A		= word ptr  0Eh
arg_C		= word ptr  10h
arg_E		= word ptr  12h

		push	bp
		mov	bp, sp
		push	di
		push	si
		push	ds
		push	es
		cld
		mov	ax, [bp+arg_C]
		sub	ax, [bp+arg_4]
		mov	cs:word_14F8B, ax
		mov	ax, [bp+arg_2]
		mov	ds, ax
		mov	si, [bp+arg_0]
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		mov	di, [bp+arg_8]
		mov	dx, di
		mov	bx, 50h	; 'P'
		mov	ax, [bp+arg_6]
		mov	cx, [bp+arg_4]
		mov	cs:word_14F8D, cx
		test	cx, 1
		jnz	short loc_14FE4
		shr	cx, 1
		mov	cs:word_14F8D, cx

loc_14FCE:				; CODE XREF: sub_14F8F+50j
		mov	di, dx
		mov	cx, cs:word_14F8D
		rep movsw
		add	si, cs:word_14F8B
		add	dx, bx
		dec	ax
		jnz	short loc_14FCE
		jmp	short loc_14FF7
; ---------------------------------------------------------------------------
		align 2

loc_14FE4:				; CODE XREF: sub_14F8F+36j
					; sub_14F8F+66j
		mov	di, dx
		mov	cx, cs:word_14F8D
		rep movsb
		add	si, cs:word_14F8B
		add	dx, bx
		dec	ax
		jnz	short loc_14FE4

loc_14FF7:				; CODE XREF: sub_14F8F+52j
		mov	si, [bp+arg_0]
		add	si, [bp+arg_A]
		mov	ax, 0B000h
		mov	es, ax
		assume es:nothing
		mov	di, [bp+arg_8]
		mov	dx, di
		mov	bx, 50h	; 'P'
		mov	ax, [bp+arg_6]
		mov	cx, [bp+arg_4]
		mov	cs:word_14F8D, cx
		test	cx, 1
		jnz	short loc_15038
		shr	cx, 1
		mov	cs:word_14F8D, cx

loc_15022:				; CODE XREF: sub_14F8F+A4j
		mov	di, dx
		mov	cx, cs:word_14F8D
		rep movsw
		add	si, cs:word_14F8B
		add	dx, bx
		dec	ax
		jnz	short loc_15022
		jmp	short loc_1504B
; ---------------------------------------------------------------------------
		align 2

loc_15038:				; CODE XREF: sub_14F8F+8Aj
					; sub_14F8F+BAj
		mov	di, dx
		mov	cx, cs:word_14F8D
		rep movsb
		add	si, cs:word_14F8B
		add	dx, bx
		dec	ax
		jnz	short loc_15038

loc_1504B:				; CODE XREF: sub_14F8F+A6j
		mov	si, [bp+arg_0]
		add	si, [bp+arg_A]
		add	si, [bp+arg_A]
		mov	ax, 0B800h
		mov	es, ax
		assume es:nothing
		mov	di, [bp+arg_8]
		mov	dx, di
		mov	bx, 50h	; 'P'
		mov	ax, [bp+arg_6]
		mov	cx, [bp+arg_4]
		mov	cs:word_14F8D, cx
		test	cx, 1
		jnz	short loc_1508F
		shr	cx, 1
		mov	cs:word_14F8D, cx

loc_15079:				; CODE XREF: sub_14F8F+FBj
		mov	di, dx
		mov	cx, cs:word_14F8D
		rep movsw
		add	si, cs:word_14F8B
		add	dx, bx
		dec	ax
		jnz	short loc_15079
		jmp	short loc_150A2
; ---------------------------------------------------------------------------
		db 90h
; ---------------------------------------------------------------------------

loc_1508F:				; CODE XREF: sub_14F8F+E1j
					; sub_14F8F+111j
		mov	di, dx
		mov	cx, cs:word_14F8D
		rep movsb
		add	si, cs:word_14F8B
		add	dx, bx
		dec	ax
		jnz	short loc_1508F

loc_150A2:				; CODE XREF: sub_14F8F+FDj
		mov	ax, [bp+arg_E]
		cmp	ax, 4
		jnz	short loc_15104
		mov	si, [bp+arg_0]
		add	si, [bp+arg_A]
		add	si, [bp+arg_A]
		add	si, [bp+arg_A]
		mov	ax, 0E000h
		mov	es, ax
		assume es:nothing
		mov	di, [bp+arg_8]
		mov	dx, di
		mov	bx, 50h	; 'P'
		mov	ax, [bp+arg_6]
		mov	cx, [bp+arg_4]
		mov	cs:word_14F8D, cx
		test	cx, 1
		jnz	short loc_150F1
		shr	cx, 1
		mov	cs:word_14F8D, cx

loc_150DB:				; CODE XREF: sub_14F8F+15Dj
		mov	di, dx
		mov	cx, cs:word_14F8D
		rep movsw
		add	si, cs:word_14F8B
		add	dx, bx
		dec	ax
		jnz	short loc_150DB
		jmp	short loc_15104
; ---------------------------------------------------------------------------
		db 90h
; ---------------------------------------------------------------------------

loc_150F1:				; CODE XREF: sub_14F8F+143j
					; sub_14F8F+173j
		mov	di, dx
		mov	cx, cs:word_14F8D
		rep movsb
		add	si, cs:word_14F8B
		add	dx, bx
		dec	ax
		jnz	short loc_150F1

loc_15104:				; CODE XREF: sub_14F8F+119j
					; sub_14F8F+15Fj
		pop	es
		assume es:nothing
		pop	ds
		pop	si
		pop	di
		pop	bp
		retn
sub_14F8F	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1510A	proc near		; CODE XREF: sub_118DA+ACp

arg_0		= word ptr  4
arg_2		= word ptr  6
arg_4		= word ptr  8
arg_6		= word ptr  0Ah
arg_8		= word ptr  0Ch
arg_A		= word ptr  0Eh

		push	bp
		mov	bp, sp
		push	di
		push	si
		push	ds
		push	es
		cld
		mov	ax, [bp+arg_2]
		mov	ds, ax
		mov	es, ax
		mov	si, [bp+arg_0]
		mov	bx, [bp+arg_4]
		mov	dx, [bp+arg_A]

loc_15122:				; CODE XREF: sub_1510A+2Fj
		push	si
		mov	cx, [bp+arg_6]

loc_15126:				; CODE XREF: sub_1510A+28j
		mov	ah, [si]
		mov	al, [si+1]
		shl	ax, 2
		mov	[si], ah
		add	si, bx
		loop	loc_15126
		pop	si
		add	si, [bp+arg_8]
		dec	dx
		jnz	short loc_15122
		pop	es
		pop	ds
		pop	si
		pop	di
		pop	bp
		retn
sub_1510A	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_15141	proc near		; CODE XREF: sub_118DA+236p

arg_0		= word ptr  4
arg_2		= word ptr  6
arg_4		= word ptr  8
arg_6		= word ptr  0Ah
arg_8		= word ptr  0Ch
arg_A		= word ptr  0Eh

		push	bp
		mov	bp, sp
		push	di
		push	si
		push	ds
		push	es
		cld
		mov	ax, [bp+arg_2]
		mov	ds, ax
		mov	es, ax
		mov	si, [bp+arg_0]
		mov	bx, [bp+arg_4]
		mov	dx, [bp+arg_A]

loc_15159:				; CODE XREF: sub_15141+2Fj
		push	si
		mov	cx, [bp+arg_6]

loc_1515D:				; CODE XREF: sub_15141+28j
		mov	ah, [si]
		mov	al, [si+1]
		shl	ax, 6
		mov	[si], ah
		add	si, bx
		loop	loc_1515D
		pop	si
		add	si, [bp+arg_8]
		dec	dx
		jnz	short loc_15159
		pop	es
		pop	ds
		pop	si
		pop	di
		pop	bp
		retn
sub_15141	endp


; =============== S U B	R O U T	I N E =======================================


GetHourSecs	proc near		; CODE XREF: _main+1Dp	sub_178D9+8p ...
		push	bp
		push	di
		push	si
		push	ds
		push	es
		mov	ah, 2Ch
		int	21h		; DOS -	GET CURRENT TIME
					; Return: CH = hours, CL = minutes, DH = seconds
					; DL = hundredths of seconds
		mov	al, 60
		mul	cl
		xor	cx, cx
		mov	cl, dh
		add	ax, cx
		pop	es
		pop	ds
		pop	si
		pop	di
		pop	bp
		retn
GetHourSecs	endp


; =============== S U B	R O U T	I N E =======================================


GetHour		proc near		; CODE XREF: sub_178D9+14p
					; sub_17A0B:loc_17A5Bp
		push	bp
		push	di
		push	si
		push	ds
		push	es
		mov	ah, 2Ch
		int	21h		; DOS -	GET CURRENT TIME
					; Return: CH = hours, CL = minutes, DH = seconds
					; DL = hundredths of seconds
		xor	ah, ah
		mov	al, ch
		pop	es
		pop	ds
		pop	si
		pop	di
		pop	bp
		retn
GetHour		endp

; ---------------------------------------------------------------------------
byte_151A4	db 80h,	40h, 20h, 10h, 8, 4, 2,	1 ; DATA XREF: sub_151B4+11o
word_151AC	dw 0A800h		; 0 ; DATA XREF: sub_151CD+30r
		dw 0B000h		; 1
		dw 0B800h		; 2
		dw 0E000h		; 3

; =============== S U B	R O U T	I N E =======================================


sub_151B4	proc near		; CODE XREF: sub_151CD+2Dp
		mov	cx, 50h
		mul	cx
		mov	si, ax
		mov	cx, bx
		and	bx, 7
		shr	cx, 3
		add	si, cx
		add	bx, offset byte_151A4
		mov	al, cs:[bx]
		retn
sub_151B4	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_151CD	proc near		; CODE XREF: sub_1103B+68p
					; sub_1103B+A8p

arg_0		= word ptr  4
arg_2		= word ptr  6
arg_4		= word ptr  8
arg_6		= word ptr  0Ah

		push	bp
		mov	bp, sp
		push	di
		push	si
		push	ds
		push	es
		push	cs
		pop	ds
		assume ds:seg000
		mov	ax, [bp+arg_4]
		and	ax, 0Fh
		shl	ax, 2
		mov	si, 4C46h
		add	si, ax
		cli
		cld
		mov	dx, 7Eh	; '~'
		mov	al, 0C0h ; 'À'
		or	ax, [bp+arg_6]
		out	7Ch, al
		outsb
		outsb
		outsb
		outsb
		mov	ax, [bp+arg_2]
		mov	bx, [bp+arg_0]
		call	sub_151B4
		mov	es, cs:word_151AC
		assume es:nothing
		mov	es:[si], al
		mov	al, 0
		out	7Ch, al
		sti
		pop	es
		assume es:nothing
		pop	ds
		assume ds:dseg
		pop	si
		pop	di
		pop	bp
		retn
sub_151CD	endp

; ---------------------------------------------------------------------------
		mov	ax, ds
		retn

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_15213	proc near		; CODE XREF: sub_1332F+1C8p
					; sub_13505+256p

arg_0		= word ptr  4
arg_2		= word ptr  6
arg_4		= word ptr  8
arg_6		= word ptr  0Ah
arg_8		= word ptr  0Ch
arg_A		= word ptr  0Eh

		push	bp
		mov	bp, sp
		push	di
		push	si
		push	ds
		push	es
		cld
		mov	ax, [bp+arg_2]
		mov	ds, ax
		mov	es, ax
		mov	si, [bp+arg_0]
		mov	bx, [bp+arg_4]
		mov	dx, [bp+arg_A]

loc_1522B:				; CODE XREF: sub_15213+30j
		push	si
		mov	cx, [bp+arg_6]

loc_1522F:				; CODE XREF: sub_15213+29j
		mov	ah, [si]
		mov	al, [si+1]
		shr	ax, 4
		mov	[si+1],	al
		add	si, bx
		loop	loc_1522F
		pop	si
		add	si, [bp+arg_8]
		dec	dx
		jnz	short loc_1522B
		pop	es
		pop	ds
		pop	si
		pop	di
		pop	bp
		retn
sub_15213	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_1524C	proc near		; CODE XREF: _main+133p
		push	bp
		push	di
		push	si
		push	ds
		push	es
		mov	ah, 40h	; '@'
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		pop	es
		pop	ds
		pop	si
		pop	di
		pop	bp
		retn
sub_1524C	endp


; =============== S U B	R O U T	I N E =======================================


sub_1525B	proc near		; CODE XREF: _main+10Fp
		push	bp
		push	di
		push	si
		push	ds
		push	es
		mov	ah, 41h	; 'A'
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		pop	es
		pop	ds
		pop	si
		pop	di
		pop	bp
		retn
sub_1525B	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1526A	proc near		; CODE XREF: ExecuteScript+F66p
					; ExecuteScript+FBEp ...

arg_0		= byte ptr  4

		push	bp
		mov	bp, sp
		push	di
		push	si
		push	ds
		push	es
		mov	ch, [bp+arg_0]
		and	ch, 0F0h
		mov	ah, 42h	; 'B'
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		pop	es
		pop	ds
		pop	si
		pop	di
		pop	bp
		retn
sub_1526A	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

WritePort	proc near		; CODE XREF: SetGDCPlane_Wrt+14p
					; ExecuteScript+F7Ep ...

arg_0		= word ptr  4
arg_2		= word ptr  6

		push	bp
		mov	bp, sp
		push	di
		push	si
		push	ds
		push	es
		mov	dx, [bp+arg_0]
		mov	ax, [bp+arg_2]
		out	dx, al
		pop	es
		pop	ds
		pop	si
		pop	di
		pop	bp
		retn
WritePort	endp

; ---------------------------------------------------------------------------
		db 4 dup(0)
word_15299	dw 0			; DATA XREF: sub_152AB+12w
					; sub_152E8+21r
word_1529B	dw 0			; DATA XREF: sub_152AB+19w
					; sub_152E8:loc_1532Br
word_1529D	dw 0			; DATA XREF: sub_152E8+7w
					; sub_152E8:loc_152F9w	...
		db 2 dup(0)
word_152A1	dw 0			; DATA XREF: sub_152AB+20w
					; sub_152E8+28r
word_152A3	dw 0			; DATA XREF: sub_152E8w sub_152E8+16w	...
word_152A5	dw 0			; DATA XREF: sub_152AB+Bw
					; sub_152E8+53r
byte_152A7	db 0A8h, 0B0h, 0B8h, 0E0h ; DATA XREF: sub_152E8+33o

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_152AB	proc near		; CODE XREF: sub_18031+58p

arg_0		= word ptr  4
arg_2		= word ptr  6
arg_4		= word ptr  8
arg_6		= word ptr  0Ah
arg_8		= word ptr  0Ch
arg_A		= word ptr  0Eh

		push	bp
		mov	bp, sp
		push	di
		push	si
		push	ds
		push	es
		cld
		mov	ax, [bp+arg_A]
		mov	cs:word_152A5, ax
		mov	ax, [bp+arg_0]
		mov	cs:word_15299, ax
		mov	ax, [bp+arg_2]
		mov	cs:word_1529B, ax
		mov	ax, [bp+arg_4]
		mov	cs:word_152A1, ax
		mov	ax, [bp+arg_8]
		cmp	ax, 0FFFFh
		jz	short loc_152D9
		mov	ds, ax

loc_152D9:				; CODE XREF: sub_152AB+2Aj
		mov	si, [bp+arg_6]
		mov	dx, 4Fh	; 'O'
		call	sub_152E8
		pop	es
		pop	ds
		pop	si
		pop	di
		pop	bp
		retn
sub_152AB	endp


; =============== S U B	R O U T	I N E =======================================


sub_152E8	proc near		; CODE XREF: sub_152AB+34p
		mov	cs:word_152A3, 0
		mov	cs:word_1529D, 0
		jmp	short loc_15305
; ---------------------------------------------------------------------------
		db 90h
; ---------------------------------------------------------------------------

loc_152F9:				; CODE XREF: sub_152E8+58j
		inc	cs:word_1529D
		mov	cs:word_152A3, 0

loc_15305:				; CODE XREF: sub_152E8+Ej
					; sub_152E8+5Aj
		mov	ax, cs:word_1529D
		cmp	ax, cs:word_15299
		jz	short locret_1535D
		add	ax, cs:word_152A1
		mov	di, ax
		mov	ax, cs:word_152A3
		mov	bx, offset byte_152A7
		add	bx, ax
		mov	al, cs:[bx]
		xchg	al, ah
		xor	al, al
		mov	es, ax
		xor	bp, bp

loc_1532B:				; CODE XREF: sub_152E8:loc_1535Ej
					; seg000:5367j	...
		cmp	bp, cs:word_1529B
		jl	short loc_15344
		inc	cs:word_152A3
		mov	ax, cs:word_152A3
		cmp	ax, cs:word_152A5
		jz	short loc_152F9
		jmp	short loc_15305
; ---------------------------------------------------------------------------

loc_15344:				; CODE XREF: sub_152E8+48j
		lodsb
		mov	cx, ax
		and	cx, 1Fh
		or	cx, cx
		jz	short loc_1535E
		and	ax, 0E0h
		shr	ax, 4
		mov	bx, ax
		add	bx, offset off_153E3
		jmp	word ptr cs:[bx]
; ---------------------------------------------------------------------------

locret_1535D:				; CODE XREF: sub_152E8+26j
		retn
; ---------------------------------------------------------------------------

loc_1535E:				; CODE XREF: sub_152E8+64j
		jmp	short loc_1532B
sub_152E8	endp

; ---------------------------------------------------------------------------

loc_15360:				; DATA XREF: seg000:off_153E3o
		add	bp, cx

loc_15362:				; CODE XREF: seg000:5365j
		movsb
		add	di, dx
		loop	loc_15362
		jmp	short loc_1532B
; ---------------------------------------------------------------------------

loc_15369:				; DATA XREF: seg000:off_153E3o
		add	bp, cx
		lodsb

loc_1536C:				; CODE XREF: seg000:536Fj
		stosb
		add	di, dx
		loop	loc_1536C
		jmp	short loc_1532B
; ---------------------------------------------------------------------------

loc_15373:				; DATA XREF: seg000:off_153E3o
		lodsw
		mov	bx, cx
		shl	bx, 1
		add	bp, bx

loc_1537A:				; CODE XREF: seg000:5384j
		stosb
		add	di, dx
		xchg	al, ah
		stosb
		add	di, dx
		xchg	al, ah
		loop	loc_1537A
		jmp	short loc_1532B
; ---------------------------------------------------------------------------

loc_15388:				; DATA XREF: seg000:off_153E3o
		mov	bx, cx
		shl	bx, 2
		add	bp, bx

loc_1538F:				; CODE XREF: seg000:539Ej
		movsb
		add	di, dx
		movsb
		add	di, dx
		movsb
		add	di, dx
		movsb
		add	di, dx
		sub	si, 4
		loop	loc_1538F
		add	si, 4
		jmp	short loc_1532B
; ---------------------------------------------------------------------------

loc_153A5:				; DATA XREF: seg000:off_153E3o
		add	bp, cx
		push	ds
		mov	ax, 0A800h
		mov	ds, ax
		assume ds:nothing

loc_153AD:				; CODE XREF: seg000:53B2j
		mov	al, [di]
		stosb
		add	di, dx
		loop	loc_153AD
		pop	ds
		assume ds:dseg
		jmp	loc_1532B
; ---------------------------------------------------------------------------

loc_153B8:				; DATA XREF: seg000:off_153E3o
		add	bp, cx
		push	ds
		mov	ax, 0B000h
		mov	ds, ax
		assume ds:nothing

loc_153C0:				; CODE XREF: seg000:53C5j
		mov	al, [di]
		stosb
		add	di, dx
		loop	loc_153C0
		pop	ds
		assume ds:dseg
		jmp	loc_1532B
; ---------------------------------------------------------------------------

loc_153CB:				; DATA XREF: seg000:off_153E3o
		add	bp, cx
		mov	al, 0

loc_153CF:				; CODE XREF: seg000:53D2j
		stosb
		add	di, dx
		loop	loc_153CF
		jmp	loc_1532B
; ---------------------------------------------------------------------------

loc_153D7:				; DATA XREF: seg000:off_153E3o
		add	bp, cx
		mov	al, 0FFh

loc_153DB:				; CODE XREF: seg000:53DEj
		stosb
		add	di, dx
		loop	loc_153DB
		jmp	loc_1532B
; ---------------------------------------------------------------------------
off_153E3	dw offset loc_15360	; 0 ; DATA XREF: sub_152E8+6Eo
		dw offset loc_15369	; 1
		dw offset loc_15373	; 2
		dw offset loc_15388	; 3
		dw offset loc_153A5	; 4
		dw offset loc_153B8	; 5
		dw offset loc_153CB	; 6
		dw offset loc_153D7	; 7
word_153F3	dw 0A800h		; 0 ; DATA XREF: seg000:542Fr
		dw 0B000h		; 1
		dw 0B800h		; 2
		dw 0E000h		; 3
word_153FB	dw 0			; DATA XREF: seg000:540Cw seg000:5434r
word_153FD	dw 0			; DATA XREF: seg000:5413w
					; seg000:loc_15442r
word_153FF	dw 0			; DATA XREF: seg000:5425w seg000:5450r
; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		push	di
		push	si
		push	ds
		push	es
		cld
		mov	ax, [bp+0Ah]
		mov	cs:word_153FB, ax
		mov	ax, [bp+8]
		mov	cs:word_153FD, ax
		mov	ax, [bp+10h]
		mov	ds, ax
		mov	si, [bp+0Eh]
		add	si, [bp+4]
		mov	bx, [bp+0Ch]
		mov	cs:word_153FF, bx
		mov	bx, [bp+6]
		mov	bp, bx
		mov	es, cs:word_153F3
		assume es:nothing
		mov	bx, cs:word_153FB
		mov	dx, 7Eh	; '~'
		mov	al, 0C0h ; 'À'
		out	7Ch, al
		mov	al, 0FFh

loc_15442:				; CODE XREF: seg000:5459j
		mov	cx, cs:word_153FD
		mov	di, bp

loc_15449:				; CODE XREF: seg000:544Ej
		outsb
		outsb
		outsb
		outsb
		stosb
		loop	loc_15449
		add	si, cs:word_153FF
		add	bp, 50h	; 'P'
		dec	bx
		jnz	short loc_15442
		mov	al, 0
		out	7Ch, al
		pop	es
		assume es:nothing
		pop	ds
		pop	si
		pop	di
		pop	bp
		retn
; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		push	di
		push	si
		push	ds
		push	es
		cld
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		mov	di, [bp+0Ch]
		mov	ax, [bp+4]
		mov	cx, [bp+6]
		mov	bx, [bp+8]
		mov	dx, [bp+0Ah]
		call	sub_15697
		mov	di, 9
		mov	ax, [bp+4]
		add	ax, [bp+8]
		mov	cx, [bp+6]
		mov	bx, 1
		mov	dx, [bp+0Ah]
		call	sub_15697
		mov	ax, [bp+4]
		mov	cx, [bp+6]
		add	cx, [bp+0Ah]
		mov	bx, [bp+8]
		add	bx, 1
		mov	dx, 8
		call	sub_15697
		mov	di, 2
		mov	ax, [bp+4]
		mov	cx, [bp+6]
		sub	cx, 5
		mov	bx, [bp+8]
		mov	dx, 1
		call	sub_15697
		mov	ax, [bp+4]
		mov	cx, [bp+6]
		sub	cx, 1
		mov	bx, [bp+8]
		mov	dx, 1
		call	sub_15697
		mov	ax, [bp+4]
		mov	cx, [bp+6]
		add	cx, [bp+0Ah]
		mov	bx, [bp+8]
		mov	dx, 1
		call	sub_15697
		mov	ax, [bp+4]
		mov	cx, [bp+6]
		add	cx, [bp+0Ah]
		add	cx, 4
		mov	bx, [bp+8]
		mov	dx, 1
		call	sub_15697
		mov	di, 1
		mov	ax, [bp+4]
		mov	cx, [bp+6]
		sub	cx, 4
		mov	bx, [bp+8]
		mov	dx, 3
		call	sub_15697
		mov	ax, [bp+4]
		mov	cx, [bp+6]
		add	cx, [bp+0Ah]
		add	cx, 1
		mov	bx, [bp+8]
		mov	dx, 3
		call	sub_15697
		mov	di, 3
		mov	ax, [bp+4]
		add	ax, [bp+8]
		mov	cx, [bp+6]
		mov	bx, 1
		mov	dx, [bp+0Ah]
		call	sub_15697
		mov	di, 4
		mov	ax, [bp+4]
		sub	ax, 1
		mov	cx, [bp+6]
		mov	bx, 1
		mov	dx, [bp+0Ah]
		call	sub_15697
		mov	di, 5
		mov	ax, [bp+4]
		add	ax, [bp+8]
		mov	cx, [bp+6]
		sub	cx, 4
		mov	bx, 1
		mov	dx, 4
		call	sub_15697
		mov	ax, [bp+4]
		add	ax, [bp+8]
		mov	cx, [bp+6]
		add	cx, [bp+0Ah]
		mov	bx, 1
		mov	dx, 4
		call	sub_15697
		mov	di, 6
		mov	ax, [bp+4]
		sub	ax, 1
		mov	cx, [bp+6]
		sub	cx, 4
		mov	bx, 1
		mov	dx, 4
		call	sub_15697
		mov	ax, [bp+4]
		sub	ax, 1
		mov	cx, [bp+6]
		add	cx, [bp+0Ah]
		mov	bx, 1
		mov	dx, 4
		call	sub_15697
		mov	di, 7
		mov	ax, [bp+4]
		add	ax, [bp+8]
		mov	cx, [bp+6]
		sub	cx, 5
		mov	bx, 1
		mov	dx, 1
		call	sub_15697
		mov	ax, [bp+4]
		add	ax, [bp+8]
		mov	cx, [bp+6]
		add	cx, [bp+0Ah]
		add	cx, 4
		mov	bx, 1
		mov	dx, 1
		call	sub_15697
		mov	di, 8
		mov	ax, [bp+4]
		sub	ax, 1
		mov	cx, [bp+6]
		sub	cx, 5
		mov	bx, 1
		mov	dx, 1
		call	sub_15697
		mov	ax, [bp+4]
		sub	ax, 1
		mov	cx, [bp+6]
		add	cx, [bp+0Ah]
		add	cx, 4
		mov	bx, 1
		mov	dx, 1
		call	sub_15697
		pop	es
		assume es:nothing
		pop	ds
		pop	si
		pop	di
		pop	bp
		retn
; ---------------------------------------------------------------------------
byte_15610	db 0FFh,   0,	0,0FFh,0FFh; 0 ; DATA XREF: sub_15697+14o
		db 0FFh,0FFh,0FFh,0FFh,0FFh; 5
		db    0,   0,	0,   0,0FFh; 10
		db  70h, 70h, 70h, 70h,0F8h; 15
		db  0Eh, 0Eh, 0Eh, 0Eh,	1Fh; 20
		db 0F0h,0F0h,0F0h,0F0h,0F8h; 25
		db  0Fh, 0Fh, 0Fh, 0Fh,	1Fh; 30
		db    0,   0,	0,   0,0F8h; 35
		db    0,   0,	0,   0,	1Fh; 40
		db 0FFh,   0,0FFh,   0,0FFh; 45
		db    0,   0,	0,   0,0FFh; 50
		db 0FFh,   0,	0,   0,0FFh; 55
		db    0,0FFh,	0,   0,0FFh; 60
		db 0FFh,0FFh,	0,   0,0FFh; 65
		db    0,   0,0FFh,   0,0FFh; 70
		db 0FFh,   0,0FFh,   0,0FFh; 75
		db    0,0FFh,0FFh,   0,0FFh; 80
		db 0FFh,0FFh,0FFh,   0,0FFh; 85
		db    0,   0,	0,0FFh,0FFh; 90
		db 0FFh,   0,	0,0FFh,0FFh; 95
		db    0,0FFh,	0,0FFh,0FFh; 100
		db 0FFh,0FFh,	0,0FFh,0FFh; 105
		db    0,   0,0FFh,0FFh,0FFh; 110
		db 0FFh,   0,0FFh,0FFh,0FFh; 115
		db    0,0FFh,0FFh,0FFh,0FFh; 120
		db 0FFh,0FFh,0FFh,0FFh,0FFh; 125
		db 0FFh,0FFh,0FFh,0FFh,	  0; 130

; =============== S U B	R O U T	I N E =======================================


sub_15697	proc near		; CODE XREF: seg000:5481p seg000:5496p ...
		push	bp
		push	di
		mov	bp, dx
		mov	si, ax
		mov	ax, 50h
		mul	cx
		add	si, ax
		mov	ax, di
		shl	di, 2
		add	di, ax
		add	di, offset byte_15610
		mov	dx, 7Eh
		mov	al, 0C0h
		out	7Ch, al
		mov	al, cs:[di]
		out	dx, al
		inc	di
		mov	al, cs:[di]
		out	dx, al
		inc	di
		mov	al, cs:[di]
		out	dx, al
		inc	di
		mov	al, cs:[di]
		out	dx, al
		inc	di
		mov	al, cs:[di]

loc_156CD:				; CODE XREF: sub_15697+40j
		mov	cx, bx
		mov	di, si
		rep stosb
		add	si, 50h
		dec	bp
		jnz	short loc_156CD
		mov	al, 0
		out	7Ch, al
		pop	di
		pop	bp
		retn
sub_15697	endp

; ---------------------------------------------------------------------------
byte_156E0	db    0,   0,	0,   0	; 0 ; DATA XREF: sub_15720+25o
		db 0FFh,   0,	0,   0	; 4
		db    0,0FFh,	0,   0	; 8
		db 0FFh,0FFh,	0,   0	; 12
		db    0,   0,0FFh,   0	; 16
		db 0FFh,   0,0FFh,   0	; 20
		db    0,0FFh,0FFh,   0	; 24
		db 0FFh,0FFh,0FFh,   0	; 28
		db    0,   0,	0,0FFh	; 32
		db 0FFh,   0,	0,0FFh	; 36
		db    0,0FFh,	0,0FFh	; 40
		db 0FFh,0FFh,	0,0FFh	; 44
		db    0,   0,0FFh,0FFh	; 48
		db 0FFh,   0,0FFh,0FFh	; 52
		db    0,0FFh,0FFh,0FFh	; 56
		db 0FFh,0FFh,0FFh,0FFh	; 60

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_15720	proc near		; CODE XREF: DoSomeGDCFill+22p
					; DoSomeGDCFill+43p

arg_0		= word ptr  4
arg_2		= word ptr  6
arg_4		= word ptr  8
arg_6		= word ptr  0Ah
arg_8		= word ptr  0Ch

		push	bp
		mov	bp, sp
		push	di
		push	si
		push	ds
		push	es
		cld
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		push	cs
		pop	ds
		assume ds:seg000
		mov	ax, [bp+arg_4]
		mov	cx, 50h
		mul	cx
		add	ax, [bp+arg_2]
		mov	bx, ax
		mov	ax, [bp+arg_0]
		and	ax, 0Fh
		shl	ax, 2
		mov	si, offset byte_156E0
		add	si, ax
		mov	dx, 7Eh
		mov	al, 0C0h
		out	7Ch, al
		outsb
		outsb
		outsb
		outsb
		mov	dx, bx
		mov	bx, [bp+arg_8]
		mov	al, 0FFh

loc_1575C:				; CODE XREF: sub_15720+47j
		mov	cx, [bp+arg_6]
		mov	di, dx
		rep stosb
		add	dx, 50h
		dec	bx
		jnz	short loc_1575C
		mov	al, 0
		out	7Ch, al
		pop	es
		assume es:nothing
		pop	ds
		assume ds:dseg
		pop	si
		pop	di
		pop	bp
		retn
sub_15720	endp

; ---------------------------------------------------------------------------
		align 8
word_15778	dw 0			; DATA XREF: sub_15788+12w
					; sub_157CD+21r
word_1577A	dw 0			; DATA XREF: sub_15788+19w
					; sub_157CD:loc_15808r
word_1577C	dw 0			; DATA XREF: sub_157CD+7w
					; sub_157CD:loc_157DEw	...
		align 4
word_15780	dw 0			; DATA XREF: sub_15788+23w
					; sub_157CD+32r
word_15782	dw 0			; DATA XREF: sub_157CDw sub_157CD+16w	...
word_15784	dw 0			; DATA XREF: sub_15788+Bw
					; sub_157CD+28r ...
word_15786	dw 0			; DATA XREF: seg000:5A6Aw seg000:5A95r

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_15788	proc near		; CODE XREF: sub_18093+68p

arg_0		= word ptr  4
arg_2		= word ptr  6
arg_4		= word ptr  8
arg_6		= word ptr  0Ah
arg_8		= word ptr  0Ch
arg_A		= word ptr  0Eh
arg_C		= word ptr  10h
arg_E		= word ptr  12h
arg_10		= word ptr  14h

		push	bp
		mov	bp, sp
		push	di
		push	si
		push	ds
		push	es
		cld
		mov	ax, [bp+arg_10]
		mov	cs:word_15784, ax
		mov	ax, [bp+arg_0]
		mov	cs:word_15778, ax
		mov	ax, [bp+arg_2]
		mov	cs:word_1577A, ax
		mov	ax, [bp+arg_4]
		add	ax, [bp+arg_C]
		mov	cs:word_15780, ax
		mov	ax, [bp+arg_A]
		cmp	ax, 0FFFFh
		jz	short loc_157B9
		mov	ds, ax

loc_157B9:				; CODE XREF: sub_15788+2Dj
		mov	si, [bp+arg_8]
		mov	ax, [bp+arg_E]
		mov	es, ax
		mov	dx, [bp+arg_6]
		call	sub_157CD
		pop	es
		pop	ds
		pop	si
		pop	di
		pop	bp
		retn
sub_15788	endp


; =============== S U B	R O U T	I N E =======================================


sub_157CD	proc near		; CODE XREF: sub_15788+3Cp
		mov	cs:word_15782, 0
		mov	cs:word_1577C, 0
		jmp	short loc_157EA
; ---------------------------------------------------------------------------
		align 2

loc_157DE:				; CODE XREF: sub_157CD+50j
		inc	cs:word_1577C
		mov	cs:word_15782, 0

loc_157EA:				; CODE XREF: sub_157CD+Ej
					; sub_157CD+52j
		mov	ax, cs:word_1577C
		cmp	ax, cs:word_15778
		jz	short locret_1583A
		mul	byte ptr cs:word_15784
		add	ax, cs:word_15782
		add	ax, cs:word_15780
		mov	di, ax
		xor	bp, bp

loc_15808:				; CODE XREF: sub_157CD:loc_1583Bj
					; seg000:5844j	...
		cmp	bp, cs:word_1577A
		jl	short loc_15821
		inc	cs:word_15782
		mov	ax, cs:word_15782
		cmp	ax, cs:word_15784
		jz	short loc_157DE
		jmp	short loc_157EA
; ---------------------------------------------------------------------------

loc_15821:				; CODE XREF: sub_157CD+40j
		lodsb
		mov	cx, ax
		and	cx, 1Fh
		or	cx, cx
		jz	short loc_1583B
		and	ax, 0E0h
		shr	ax, 4
		mov	bx, ax
		add	bx, offset off_158C5
		jmp	word ptr cs:[bx]
; ---------------------------------------------------------------------------

locret_1583A:				; CODE XREF: sub_157CD+26j
		retn
; ---------------------------------------------------------------------------

loc_1583B:				; CODE XREF: sub_157CD+5Cj
		jmp	short loc_15808
sub_157CD	endp

; ---------------------------------------------------------------------------

loc_1583D:				; DATA XREF: seg000:off_158C5o
		add	bp, cx

loc_1583F:				; CODE XREF: seg000:5842j
		movsb
		add	di, dx
		loop	loc_1583F
		jmp	short loc_15808
; ---------------------------------------------------------------------------

loc_15846:				; DATA XREF: seg000:off_158C5o
		add	bp, cx
		lodsb

loc_15849:				; CODE XREF: seg000:584Cj
		stosb
		add	di, dx
		loop	loc_15849
		jmp	short loc_15808
; ---------------------------------------------------------------------------

loc_15850:				; DATA XREF: seg000:off_158C5o
		lodsw
		mov	bx, cx
		shl	bx, 1
		add	bp, bx

loc_15857:				; CODE XREF: seg000:5861j
		stosb
		add	di, dx
		xchg	al, ah
		stosb
		add	di, dx
		xchg	al, ah
		loop	loc_15857
		jmp	short loc_15808
; ---------------------------------------------------------------------------

loc_15865:				; DATA XREF: seg000:off_158C5o
		mov	bx, cx
		shl	bx, 2
		add	bp, bx

loc_1586C:				; CODE XREF: seg000:587Bj
		movsb
		add	di, dx
		movsb
		add	di, dx
		movsb
		add	di, dx
		movsb
		add	di, dx
		sub	si, 4
		loop	loc_1586C
		add	si, 4
		jmp	short loc_15808
; ---------------------------------------------------------------------------

loc_15882:				; DATA XREF: seg000:off_158C5o
		add	bp, cx
		mov	bx, cs:word_15782
		neg	bx

loc_1588B:				; CODE XREF: seg000:5891j
		mov	al, es:[bx+di]
		stosb
		add	di, dx
		loop	loc_1588B
		jmp	loc_15808
; ---------------------------------------------------------------------------

loc_15896:				; DATA XREF: seg000:off_158C5o
		add	bp, cx
		mov	bx, cs:word_15782
		sub	bx, 1
		neg	bx

loc_158A2:				; CODE XREF: seg000:58A8j
		mov	al, es:[bx+di]
		stosb
		add	di, dx
		loop	loc_158A2
		jmp	loc_15808
; ---------------------------------------------------------------------------

loc_158AD:				; DATA XREF: seg000:off_158C5o
		add	bp, cx
		mov	al, 0

loc_158B1:				; CODE XREF: seg000:58B4j
		stosb
		add	di, dx
		loop	loc_158B1
		jmp	loc_15808
; ---------------------------------------------------------------------------

loc_158B9:				; DATA XREF: seg000:off_158C5o
		add	bp, cx
		mov	al, 0FFh

loc_158BD:				; CODE XREF: seg000:58C0j
		stosb
		add	di, dx
		loop	loc_158BD
		jmp	loc_15808
; ---------------------------------------------------------------------------
off_158C5	dw offset loc_1583D	; 0 ; DATA XREF: sub_157CD+66o
		dw offset loc_15846	; 1
		dw offset loc_15850	; 2
		dw offset loc_15865	; 3
		dw offset loc_15882	; 4
		dw offset loc_15896	; 5
		dw offset loc_158AD	; 6
		dw offset loc_158B9	; 7
word_158D5	dw 0A800h		; DATA XREF: seg000:5919r seg000:59A3r ...
word_158D7	dw 0B000h		; DATA XREF: seg000:59AFr seg000:5A0Dr ...
word_158D9	dw 0B800h		; DATA XREF: seg000:59BBr seg000:5A1Fr ...
word_158DB	dw 0E000h		; DATA XREF: seg000:59C7r seg000:5A31r ...
word_158DD	dw 0			; DATA XREF: seg000:58F6w seg000:591Er ...
word_158DF	dw 0			; DATA XREF: seg000:58FDw
					; seg000:loc_1592Er ...
word_158E1	dw 0			; DATA XREF: seg000:590Fw seg000:593Cr
byte_158E3	db 0			; DATA XREF: seg000:58EFw seg000:592Ar
; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		push	di
		push	si
		push	ds
		push	es
		cld
		mov	ax, [bp+12h]
		mov	cs:byte_158E3, al
		mov	ax, [bp+0Ah]
		mov	cs:word_158DD, ax
		mov	ax, [bp+8]
		mov	cs:word_158DF, ax
		mov	ax, [bp+10h]
		mov	ds, ax
		mov	si, [bp+0Eh]
		add	si, [bp+4]
		mov	bx, [bp+0Ch]
		mov	cs:word_158E1, bx
		mov	bx, [bp+6]
		mov	bp, bx
		mov	es, cs:word_158D5
		assume es:nothing
		mov	bx, cs:word_158DD
		mov	dx, 7Eh	; '~'
		mov	al, 0C0h ; 'À'
		out	7Ch, al
		mov	al, cs:byte_158E3

loc_1592E:				; CODE XREF: seg000:5948j
		mov	cx, cs:word_158DF
		mov	di, bp

loc_15935:				; CODE XREF: seg000:593Aj
		outsb
		outsb
		outsb
		outsb
		stosb
		loop	loc_15935
		add	si, cs:word_158E1
		add	bp, 50h	; 'P'
		rol	al, 5
		dec	bx
		jnz	short loc_1592E
		mov	al, 0
		out	7Ch, al
		pop	es
		assume es:nothing
		pop	ds
		pop	si
		pop	di
		pop	bp
		retn
; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		push	di
		push	si
		push	ds
		push	es
		cld
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	ax, [bp+6]
		mov	ds, ax
		mov	si, [bp+4]
		mov	cx, [bp+8]
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		mov	di, [bp+0Ah]
		mov	dx, 7Eh	; '~'
		mov	al, 0C0h ; 'À'
		out	7Ch, al

loc_1597A:				; CODE XREF: seg000:597Fj
		outsb
		outsb
		outsb
		outsb
		movsb
		loop	loc_1597A
		mov	al, 0
		out	7Ch, al
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		pop	es
		assume es:nothing
		pop	ds
		pop	si
		pop	di
		pop	bp
		retn
; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		push	di
		push	si
		push	ds
		push	es
		cld
		mov	ax, [bp+6]
		mov	ds, ax
		mov	si, [bp+4]
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	es, cs:word_158D5
		assume es:nothing
		xor	di, di
		mov	cx, [bp+8]
		rep movsb
		mov	es, cs:word_158D7
		assume es:nothing
		xor	di, di
		mov	cx, [bp+8]
		rep movsb
		mov	es, cs:word_158D9
		assume es:nothing
		xor	di, di
		mov	cx, [bp+8]
		rep movsb
		mov	es, cs:word_158DB
		assume es:nothing
		xor	di, di
		mov	cx, [bp+8]
		rep movsb
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		pop	es
		assume es:nothing
		pop	ds
		pop	si
		pop	di
		pop	bp
		retn
; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		push	di
		push	si
		push	ds
		push	es
		cld
		mov	ax, [bp+6]
		mov	es, ax
		mov	dx, [bp+4]
		mov	bx, 3
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	di, dx
		xor	si, si
		mov	cx, [bp+8]
		mov	ds, cs:word_158D5
		assume ds:nothing

loc_15A00:				; CODE XREF: seg000:5A03j
		movsb
		add	di, bx
		loop	loc_15A00
		inc	dx
		mov	di, dx
		xor	si, si
		mov	cx, [bp+8]
		mov	ds, cs:word_158D7
		assume ds:nothing

loc_15A12:				; CODE XREF: seg000:5A15j
		movsb
		add	di, bx
		loop	loc_15A12
		inc	dx
		mov	di, dx
		xor	si, si
		mov	cx, [bp+8]
		mov	ds, cs:word_158D9
		assume ds:nothing

loc_15A24:				; CODE XREF: seg000:5A27j
		movsb
		add	di, bx
		loop	loc_15A24
		inc	dx
		mov	di, dx
		xor	si, si
		mov	cx, [bp+8]
		mov	ds, cs:word_158DB
		assume ds:nothing

loc_15A36:				; CODE XREF: seg000:5A39j
		movsb
		add	di, bx
		loop	loc_15A36
		inc	dx
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		pop	es
		pop	ds
		assume ds:dseg
		pop	si
		pop	di
		pop	bp
		retn
; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		push	di
		push	si
		push	ds
		push	es
		cld
		mov	ax, [bp+0Ah]
		mov	cs:word_158DD, ax
		mov	ax, [bp+8]
		mov	cs:word_158DF, ax
		mov	ax, [bp+10h]
		mov	ds, ax
		mov	si, [bp+0Eh]
		add	si, [bp+4]
		mov	bx, [bp+0Ch]
		mov	cs:word_15786, bx
		mov	bx, [bp+6]
		mov	bp, bx
		mov	es, cs:word_158D5
		assume es:nothing
		mov	bx, cs:word_158DD
		mov	dx, 7Eh	; '~'
		mov	al, 0C0h ; 'À'
		out	7Ch, al
		mov	ah, 0FFh

loc_15A87:				; CODE XREF: seg000:5A9Ej
		mov	cx, cs:word_158DF
		mov	di, bp

loc_15A8E:				; CODE XREF: seg000:5A93j
		outsb
		outsb
		outsb
		outsb
		movsb
		loop	loc_15A8E
		add	si, cs:word_15786
		add	bp, 50h	; 'P'
		dec	bx
		jnz	short loc_15A87
		mov	al, 0
		out	7Ch, al
		pop	es
		assume es:nothing
		pop	ds
		pop	si
		pop	di
		pop	bp
		retn
; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		push	di
		push	si
		push	ds
		push	es
		cld
		mov	ax, [bp+0Ch]
		mov	es, ax
		mov	di, [bp+0Ah]
		mov	dx, [bp+8]
		mov	bx, [bp+4]
		mov	ds, cs:word_158D5
		assume ds:nothing

loc_15AC5:				; CODE XREF: seg000:5AD0j
		mov	si, bx
		mov	cx, [bp+6]
		rep movsb
		add	bx, 50h	; 'P'
		dec	dx
		jnz	short loc_15AC5
		mov	dx, [bp+8]
		mov	bx, [bp+4]
		mov	ds, cs:word_158D7
		assume ds:nothing

loc_15ADD:				; CODE XREF: seg000:5AE8j
		mov	si, bx
		mov	cx, [bp+6]
		rep movsb
		add	bx, 50h	; 'P'
		dec	dx
		jnz	short loc_15ADD
		mov	dx, [bp+8]
		mov	bx, [bp+4]
		mov	ds, cs:word_158D9
		assume ds:nothing

loc_15AF5:				; CODE XREF: seg000:5B00j
		mov	si, bx
		mov	cx, [bp+6]
		rep movsb
		add	bx, 50h	; 'P'
		dec	dx
		jnz	short loc_15AF5
		mov	dx, [bp+8]
		mov	bx, [bp+4]
		mov	ds, cs:word_158DB
		assume ds:nothing

loc_15B0D:				; CODE XREF: seg000:5B18j
		mov	si, bx
		mov	cx, [bp+6]
		rep movsb
		add	bx, 50h	; 'P'
		dec	dx
		jnz	short loc_15B0D
		pop	es
		pop	ds
		assume ds:dseg
		pop	si
		pop	di
		pop	bp
		retn
; ---------------------------------------------------------------------------
byte_15B20	db 50h dup(0)		; DATA XREF: seg000:5B8Ao seg000:5B9Fo ...
; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		push	di
		push	si
		push	ds
		push	es
		cld
		mov	ax, cs
		mov	es, ax
		assume es:seg000
		mov	bx, [bp+0Ah]

loc_15B7F:				; CODE XREF: seg000:5C48j
		push	ax
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		pop	ax
		mov	ds, cs:word_158D5
		assume ds:nothing
		mov	di, offset byte_15B20
		mov	si, [bp+4]
		mov	cx, [bp+8]
		rep movsb
		push	ax
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		pop	ax
		push	ds
		push	es
		pop	ds
		assume ds:seg000
		pop	es
		assume es:nothing
		mov	si, offset byte_15B20
		mov	di, [bp+6]
		mov	cx, [bp+8]
		rep movsb
		push	ds
		push	es
		pop	ds
		assume ds:dseg
		pop	es
		push	ax
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		pop	ax
		mov	ds, cs:word_158D7
		assume ds:nothing
		mov	di, offset byte_15B20
		mov	si, [bp+4]
		mov	cx, [bp+8]
		rep movsb
		push	ax
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		pop	ax
		push	ds
		push	es
		pop	ds
		assume ds:dseg
		pop	es
		mov	si, offset byte_15B20
		mov	di, [bp+6]
		mov	cx, [bp+8]
		rep movsb
		push	ds
		push	es
		pop	ds
		pop	es
		push	ax
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		pop	ax
		mov	ds, cs:word_158D9
		assume ds:nothing
		mov	di, offset byte_15B20
		mov	si, [bp+4]
		mov	cx, [bp+8]
		rep movsb
		push	ax
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		pop	ax
		push	ds
		push	es
		pop	ds
		assume ds:dseg
		pop	es
		mov	si, offset byte_15B20
		mov	di, [bp+6]
		mov	cx, [bp+8]
		rep movsb
		push	ds
		push	es
		pop	ds
		pop	es
		push	ax
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		pop	ax
		mov	ds, cs:word_158DB
		assume ds:nothing
		mov	di, offset byte_15B20
		mov	si, [bp+4]
		mov	cx, [bp+8]
		rep movsb
		push	ax
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		pop	ax
		push	ds
		push	es
		pop	ds
		assume ds:dseg
		pop	es
		mov	si, offset byte_15B20
		mov	di, [bp+6]
		mov	cx, [bp+8]
		rep movsb
		push	ds
		push	es
		pop	ds
		pop	es
		add	word ptr [bp+4], 50h
		mov	ax, [bp+8]
		add	[bp+6],	ax
		dec	bx
		jz	short loc_15C4B
		jmp	loc_15B7F
; ---------------------------------------------------------------------------

loc_15C4B:				; CODE XREF: seg000:5C46j
		push	ax
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		pop	ax
		mov	ax, [bp+6]
		pop	es
		pop	ds
		pop	si
		pop	di
		pop	bp
		retn
; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		push	di
		push	si
		push	ds
		push	es
		cld
		mov	ax, cs
		mov	es, ax
		assume es:seg000
		mov	bx, [bp+0Ah]

loc_15C69:				; CODE XREF: seg000:5D32j
		push	ax
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		pop	ax
		mov	ds, cs:word_158D5
		assume ds:nothing
		mov	di, offset byte_15B20
		mov	si, [bp+4]
		mov	cx, [bp+8]
		rep movsb
		push	ax
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		pop	ax
		push	ds
		push	es
		pop	ds
		assume ds:seg000
		pop	es
		assume es:nothing
		mov	si, offset byte_15B20
		mov	di, [bp+6]
		mov	cx, [bp+8]
		rep movsb
		push	ds
		push	es
		pop	ds
		assume ds:dseg
		pop	es
		push	ax
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		pop	ax
		mov	ds, cs:word_158D7
		assume ds:nothing
		mov	di, offset byte_15B20
		mov	si, [bp+4]
		mov	cx, [bp+8]
		rep movsb
		push	ax
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		pop	ax
		push	ds
		push	es
		pop	ds
		assume ds:dseg
		pop	es
		mov	si, offset byte_15B20
		mov	di, [bp+6]
		mov	cx, [bp+8]
		rep movsb
		push	ds
		push	es
		pop	ds
		pop	es
		push	ax
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		pop	ax
		mov	ds, cs:word_158D9
		assume ds:nothing
		mov	di, offset byte_15B20
		mov	si, [bp+4]
		mov	cx, [bp+8]
		rep movsb
		push	ax
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		pop	ax
		push	ds
		push	es
		pop	ds
		assume ds:dseg
		pop	es
		mov	si, offset byte_15B20
		mov	di, [bp+6]
		mov	cx, [bp+8]
		rep movsb
		push	ds
		push	es
		pop	ds
		pop	es
		push	ax
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		pop	ax
		mov	ds, cs:word_158DB
		assume ds:nothing
		mov	di, offset byte_15B20
		mov	si, [bp+4]
		mov	cx, [bp+8]
		rep movsb
		push	ax
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		pop	ax
		push	ds
		push	es
		pop	ds
		assume ds:dseg
		pop	es
		mov	si, offset byte_15B20
		mov	di, [bp+6]
		mov	cx, [bp+8]
		rep movsb
		push	ds
		push	es
		pop	ds
		pop	es
		add	word ptr [bp+6], 50h
		mov	ax, [bp+8]
		add	[bp+4],	ax
		dec	bx
		jz	short loc_15D35
		jmp	loc_15C69
; ---------------------------------------------------------------------------

loc_15D35:				; CODE XREF: seg000:5D30j
		push	ax
		mov	al, 0
		out	0A6h, al	; Interrupt Controller #2, 8259A
		pop	ax
		pop	es
		pop	ds
		pop	si
		pop	di
		pop	bp
		retn

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_15D41	proc near		; CODE XREF: ExecuteScript+E4Cp
					; ExecuteScript+F33p ...

arg_0		= word ptr  4
arg_2		= word ptr  6
arg_4		= word ptr  8
arg_6		= word ptr  0Ah
arg_8		= word ptr  0Ch

		push	bp
		mov	bp, sp
		push	di
		push	si
		push	ds
		push	es
		cld
		mov	ax, [bp+arg_2]
		mov	ds, ax
		mov	si, [bp+arg_0]
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		mov	di, [bp+arg_8]
		mov	dx, 7Eh
		mov	al, 0C8h
		out	7Ch, al
		mov	bx, [bp+arg_6]
		mov	ax, di

loc_15D65:				; CODE XREF: sub_15D41+35j
		mov	di, ax
		mov	cx, [bp+arg_4]

loc_15D6A:				; CODE XREF: sub_15D41+2Fj
		outsb
		outsb
		outsb
		outsb
		dec	si
		movsb
		loop	loc_15D6A
		add	ax, 50h
		dec	bx
		jnz	short loc_15D65
		mov	al, 0
		out	7Ch, al
		pop	es
		assume es:nothing
		pop	ds
		pop	si
		pop	di
		pop	bp
		retn
sub_15D41	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_15D82	proc near		; CODE XREF: sub_11DF6+B8p
					; sub_11F4B+B8p ...

arg_0		= word ptr  4
arg_2		= word ptr  6
arg_4		= word ptr  8
arg_6		= word ptr  0Ah
arg_8		= word ptr  0Ch

		push	bp
		mov	bp, sp
		push	di
		push	si
		push	ds
		push	es
		cld
		mov	ax, [bp+arg_2]
		mov	ds, ax
		mov	si, [bp+arg_0]
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		mov	di, [bp+arg_8]
		mov	dx, 7Eh
		mov	al, 0C0h
		out	7Ch, al
		mov	bx, [bp+arg_6]
		mov	ax, di

loc_15DA6:				; CODE XREF: sub_15D82+34j
		mov	di, ax
		mov	cx, [bp+arg_4]

loc_15DAB:				; CODE XREF: sub_15D82+2Ej
		outsb
		outsb
		outsb
		outsb
		movsb
		loop	loc_15DAB
		add	ax, 50h
		dec	bx
		jnz	short loc_15DA6
		mov	al, 0
		out	7Ch, al
		pop	es
		assume es:nothing
		pop	ds
		pop	si
		pop	di
		pop	bp
		retn
sub_15D82	endp

; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		push	di
		push	si
		push	ds
		push	es
		cld
		mov	ax, [bp+6]
		mov	ds, ax
		mov	si, [bp+4]
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		mov	di, [bp+0Ch]
		mov	dx, 7Eh
		mov	al, 0C0h
		out	7Ch, al
		mov	bx, [bp+0Ah]
		mov	ax, di

loc_15DE6:				; CODE XREF: seg000:5DF9j
		mov	di, ax
		mov	cx, [bp+8]

loc_15DEB:				; CODE XREF: seg000:5DF0j
		outsb
		outsb
		outsb
		outsb
		movsb
		loop	loc_15DEB
		add	ax, 50h
		add	si, [bp+0Eh]
		dec	bx
		jnz	short loc_15DE6
		mov	al, 0
		out	7Ch, al
		pop	es
		assume es:nothing
		pop	ds
		pop	si
		pop	di
		pop	bp
		retn
; ---------------------------------------------------------------------------
		db 5 dup(0)
word_15E0A	dw 0			; DATA XREF: sub_15E24+19w
					; sub_15E70+2Fr
word_15E0C	dw 0			; DATA XREF: sub_15E24+20w
					; sub_15E70:loc_15EB8r
word_15E0E	dw 0			; DATA XREF: sub_15E70+Ew
					; sub_15E70:loc_15E88w	...
		db 2 dup(0)
word_15E12	dw 0			; DATA XREF: sub_15E24+2Aw
					; sub_15E70+3Fr
		align 8
word_15E18	dw 0			; DATA XREF: sub_15E70w sub_15E70+24w	...
word_15E1A	dw 0			; DATA XREF: sub_15E70+7w
					; sub_15E70+1Dw ...
word_15E1C	dw 0			; DATA XREF: sub_15E24+12w
					; sub_15E70+61r
word_15E1E	dw 0			; DATA XREF: sub_15E24+Bw
					; sub_15E70+4Fr ...
		db 4 dup(0)

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_15E24	proc near		; CODE XREF: sub_18171+6Fp
					; sub_181EA+73p ...

arg_0		= word ptr  4
arg_2		= word ptr  6
arg_4		= word ptr  8
arg_6		= word ptr  0Ah
arg_8		= word ptr  0Ch
arg_A		= word ptr  0Eh
arg_C		= word ptr  10h
arg_E		= word ptr  12h
arg_10		= word ptr  14h
arg_12		= word ptr  16h

		push	bp
		mov	bp, sp
		push	di
		push	si
		push	ds
		push	es
		cld
		mov	ax, [bp+arg_12]
		mov	cs:word_15E1E, ax
		mov	ax, [bp+arg_10]
		mov	cs:word_15E1C, ax
		mov	ax, [bp+arg_0]
		mov	cs:word_15E0A, ax
		mov	ax, [bp+arg_2]
		mov	cs:word_15E0C, ax
		mov	ax, [bp+arg_4]
		add	ax, [bp+arg_C]
		mov	cs:word_15E12, ax
		mov	ax, [bp+arg_A]
		cmp	ax, 0FFFFh
		jz	short loc_15E5C
		mov	ds, ax

loc_15E5C:				; CODE XREF: sub_15E24+34j
		mov	si, [bp+arg_8]
		mov	ax, [bp+arg_E]
		mov	es, ax
		mov	dx, [bp+arg_6]
		call	sub_15E70
		pop	es
		pop	ds
		pop	si
		pop	di
		pop	bp
		retn
sub_15E24	endp


; =============== S U B	R O U T	I N E =======================================


sub_15E70	proc near		; CODE XREF: sub_15E24+43p
		mov	cs:word_15E18, 0
		mov	cs:word_15E1A, 0
		mov	cs:word_15E0E, 0
		jmp	short loc_15E9B
; ---------------------------------------------------------------------------
		align 2

loc_15E88:				; CODE XREF: sub_15E70+66j
		inc	cs:word_15E0E
		mov	cs:word_15E1A, 0
		mov	cs:word_15E18, 0

loc_15E9B:				; CODE XREF: sub_15E70+15j
					; sub_15E70+68j
		mov	ax, cs:word_15E0E
		cmp	ax, cs:word_15E0A
		jz	short locret_15EF3
		mov	ax, cs:word_15E0E
		add	ax, cs:word_15E18
		add	ax, cs:word_15E12
		mov	di, ax
		xor	bp, bp

loc_15EB8:				; CODE XREF: sub_15E70:loc_15EF4j
					; seg000:5EFDj	...
		cmp	bp, cs:word_15E0C
		jl	short loc_15EDA
		mov	ax, cs:word_15E1E
		add	cs:word_15E18, ax
		inc	cs:word_15E1A
		mov	ax, cs:word_15E1A
		cmp	ax, cs:word_15E1C
		jz	short loc_15E88
		jmp	short loc_15E9B
; ---------------------------------------------------------------------------

loc_15EDA:				; CODE XREF: sub_15E70+4Dj
		lodsb
		mov	cx, ax
		and	cx, 1Fh
		or	cx, cx
		jz	short loc_15EF4
		and	ax, 0E0h
		shr	ax, 4
		mov	bx, ax
		add	bx, offset off_15F81
		jmp	word ptr cs:[bx]
; ---------------------------------------------------------------------------

locret_15EF3:				; CODE XREF: sub_15E70+34j
		retn
; ---------------------------------------------------------------------------

loc_15EF4:				; CODE XREF: sub_15E70+72j
		jmp	short loc_15EB8
sub_15E70	endp

; ---------------------------------------------------------------------------

loc_15EF6:				; DATA XREF: seg000:off_15F81o
		add	bp, cx

loc_15EF8:				; CODE XREF: seg000:5EFBj
		movsb
		add	di, dx
		loop	loc_15EF8
		jmp	short loc_15EB8
; ---------------------------------------------------------------------------

loc_15EFF:				; DATA XREF: seg000:off_15F81o
		add	bp, cx
		lodsb

loc_15F02:				; CODE XREF: seg000:5F05j
		stosb
		add	di, dx
		loop	loc_15F02
		jmp	short loc_15EB8
; ---------------------------------------------------------------------------

loc_15F09:				; DATA XREF: seg000:off_15F81o
		lodsw
		mov	bx, cx
		shl	bx, 1
		add	bp, bx

loc_15F10:				; CODE XREF: seg000:5F1Aj
		stosb
		add	di, dx
		xchg	al, ah
		stosb
		add	di, dx
		xchg	al, ah
		loop	loc_15F10
		jmp	short loc_15EB8
; ---------------------------------------------------------------------------

loc_15F1E:				; DATA XREF: seg000:off_15F81o
		mov	bx, cx
		shl	bx, 2
		add	bp, bx

loc_15F25:				; CODE XREF: seg000:5F34j
		movsb
		add	di, dx
		movsb
		add	di, dx
		movsb
		add	di, dx
		movsb
		add	di, dx
		sub	si, 4
		loop	loc_15F25
		add	si, 4
		jmp	loc_15EB8
; ---------------------------------------------------------------------------

loc_15F3C:				; DATA XREF: seg000:off_15F81o
		add	bp, cx
		mov	bx, cs:word_15E18
		neg	bx

loc_15F45:				; CODE XREF: seg000:5F4Bj
		mov	al, es:[bx+di]
		stosb
		add	di, dx
		loop	loc_15F45
		jmp	loc_15EB8
; ---------------------------------------------------------------------------

loc_15F50:				; DATA XREF: seg000:off_15F81o
		add	bp, cx
		mov	bx, cs:word_15E18
		sub	bx, cs:word_15E1E
		neg	bx

loc_15F5E:				; CODE XREF: seg000:5F64j
		mov	al, es:[bx+di]
		stosb
		add	di, dx
		loop	loc_15F5E
		jmp	loc_15EB8
; ---------------------------------------------------------------------------

loc_15F69:				; DATA XREF: seg000:off_15F81o
		add	bp, cx
		mov	al, 0

loc_15F6D:				; CODE XREF: seg000:5F70j
		stosb
		add	di, dx
		loop	loc_15F6D
		jmp	loc_15EB8
; ---------------------------------------------------------------------------

loc_15F75:				; DATA XREF: seg000:off_15F81o
		add	bp, cx
		mov	al, 0FFh

loc_15F79:				; CODE XREF: seg000:5F7Cj
		stosb
		add	di, dx
		loop	loc_15F79
		jmp	loc_15EB8
; ---------------------------------------------------------------------------
off_15F81	dw offset loc_15EF6	; 0 ; DATA XREF: sub_15E70+7Co
		dw offset loc_15EFF	; 1
		dw offset loc_15F09	; 2
		dw offset loc_15F1E	; 3
		dw offset loc_15F3C	; 4
		dw offset loc_15F50	; 5
		dw offset loc_15F69	; 6
		dw offset loc_15F75	; 7
		db    0
word_15F92	dw 0			; DATA XREF: ReadFileData+18w
					; ReadFileData+2Cr ...
		align 8
word_15F98	dw 0			; DATA XREF: ReadFileData+7w
					; ReadFileData+35w ...

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

ReadFileData	proc near		; CODE XREF: LoadFile+57p

arg_0		= word ptr  4
arg_2		= word ptr  6
arg_4		= word ptr  8

		push	bp
		mov	bp, sp
		push	di
		push	si
		push	ds
		push	es
		mov	cs:word_15F98, 0
		mov	dx, [bp+arg_0]
		mov	ax, 3D00h
		int	21h		; DOS -	2+ - OPEN DISK FILE WITH HANDLE
					; DS:DX	-> ASCIZ filename
					; AL = access mode
					; 0 - read
		jb	short loc_15FEA
		mov	cs:word_15F92, ax
		mov	ax, [bp+arg_4]
		cmp	ax, 0FFFFh
		jz	short loc_15FC0
		mov	ds, ax

loc_15FC0:				; CODE XREF: ReadFileData+22j
		mov	dx, [bp+arg_2]
		mov	cx, 0FFFFh
		mov	bx, cs:word_15F92
		mov	ah, 3Fh
		int	21h		; DOS -	2+ - READ FROM FILE WITH HANDLE
					; BX = file handle, CX = number	of bytes to read
					; DS:DX	-> buffer
		add	cs:word_15F98, ax
		mov	bx, cs:word_15F92
		mov	ax, 3E00h
		int	21h		; DOS -	2+ - CLOSE A FILE WITH HANDLE
					; BX = file handle
		jb	short loc_15FEA
		mov	ax, cs:word_15F98
		pop	es
		pop	ds
		pop	si
		pop	di
		pop	bp
		retn
; ---------------------------------------------------------------------------

loc_15FEA:				; CODE XREF: ReadFileData+16j
					; ReadFileData+44j
		mov	ax, 0
		pop	es
		pop	ds
		pop	si
		pop	di
		pop	bp
		retn
ReadFileData	endp

; ---------------------------------------------------------------------------
		align 2
word_15FF4	dw 0			; DATA XREF: SetupInt0C+1Cw
					; RestoreInt0C+14r
word_15FF6	dw 0			; DATA XREF: SetupInt0C+10w
					; RestoreInt0C+Br
word_15FF8	dw 0			; DATA XREF: SetupInt0C+22w
					; seg000:6065r

; =============== S U B	R O U T	I N E =======================================


SetupInt0C	proc near		; CODE XREF: _main+12Dp
		push	di
		push	si
		push	ds
		push	es
		xor	ax, ax
		mov	es, ax
		assume es:nothing
		mov	ax, cs
		cli
		xchg	ax, es:2Ah
		mov	cs:word_15FF6, ax
		mov	ax, offset Int0C
		xchg	ax, es:28h
		mov	cs:word_15FF4, ax
		mov	ax, ds
		mov	cs:word_15FF8, ax
		in	al, 2		; DMA controller, 8237A-5.
					; channel 1 current address
		and	al, 0FBh
		out	2, al		; DMA controller, 8237A-5.
					; channel 1 base address
					; (also	sets current address)
		out	64h, al		; 8042 keyboard	controller command register.
		sti
		pop	es
		assume es:nothing
		pop	ds
		pop	si
		pop	di
		retn
SetupInt0C	endp


; =============== S U B	R O U T	I N E =======================================


RestoreInt0C	proc near		; CODE XREF: _main+167p
		push	di
		push	si
		push	ds
		push	es
		xor	ax, ax
		mov	es, ax
		assume es:nothing
		mov	ax, cs
		cli
		mov	ax, cs:word_15FF6
		xchg	ax, es:2Ah
		mov	ax, cs:word_15FF4
		xchg	ax, es:28h
		in	al, 2		; DMA controller, 8237A-5.
					; channel 1 current address
		or	al, 4
		out	2, al		; DMA controller, 8237A-5.
					; channel 1 base address
					; (also	sets current address)
		sti
		xor	al, al
		out	7Ch, al
		pop	es
		assume es:nothing
		pop	ds
		pop	si
		pop	di
		retn
RestoreInt0C	endp

; ---------------------------------------------------------------------------

Int0C:					; DATA XREF: SetupInt0C+14o
		cli
		push	ax
		push	bx
		push	cx
		push	dx
		push	si
		push	di
		push	ds
		push	es
		push	bp
		mov	ds, cs:word_15FF8
		cmp	word_1AB44, 0
		jz	short loc_16075
		dec	word_1AB44

loc_16075:				; CODE XREF: seg000:606Fj
		cmp	palFadeSpeed, 0
		jz	short loc_16080
		dec	palFadeSpeed

loc_16080:				; CODE XREF: seg000:607Aj
		cmp	word_1AB46, 0
		jz	short loc_1608B
		dec	word_1AB46

loc_1608B:				; CODE XREF: seg000:6085j
		cmp	word_1B0E2, 0
		jz	short loc_16096
		dec	word_1B0E2

loc_16096:				; CODE XREF: seg000:6090j
		cmp	word_1C32E, 0
		jz	short loc_160A1
		dec	word_1C32E

loc_160A1:				; CODE XREF: seg000:609Bj
		mov	ax, word_1ADDA
		and	ax, ax
		jz	short loc_160B3
		mov	ax, GDCPlaneDisp
		out	0A4h, al	; Interrupt Controller #2, 8259A
		mov	word_1ADDA, 0

loc_160B3:				; CODE XREF: seg000:60A6j
		mov	al, 20h	; ' '
		out	0, al
		out	64h, al		; 8042 keyboard	controller command register.
					; Read command byte:
					; 7:	      (reserved)
					; 6:  XLAT    convert Set 2 scancodes to Set 1 (IBM PC compatibility mode)
					; 5:  XT      1=translate codes	like XT	keyboard, 0=like AT
					; 4:  _EN     1=disable	keyboard
					; 3:  OVR     1=override inhibit keyswitch
					; 2:  SYS     System Flag (0=cold reboot, 1=warm reboot)
					; 1:	      (reserved)
					; 0:  INT     enables IRQ 1 interrupt on keyboard IBF
					;
		pop	bp
		pop	es
		pop	ds
		pop	di
		pop	si
		pop	dx
		pop	cx
		pop	bx
		pop	ax
		sti
		iret
; ---------------------------------------------------------------------------
dword_160C4	dd 0			; DATA XREF: seg000:60D2w seg000:60E0r ...
; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		push	di
		push	si
		push	ds
		push	es
		mov	ax, [bp+4]
		mov	word ptr cs:dword_160C4, ax
		mov	ax, [bp+6]
		mov	word ptr cs:dword_160C4+2, ax
		mov	ax, 1111h
		call	cs:dword_160C4
		pop	es
		pop	ds
		pop	si
		pop	di
		pop	bp
		retn
; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

DoIntA0		proc near		; CODE XREF: CallMusicDriver+14p

arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		push	ds
		push	es
		push	di
		push	si
		mov	ax, [bp+arg_0]
		int	0A0h		; used by BASIC	while in interpreter
		pop	si
		pop	di
		pop	es
		pop	ds
		pop	bp
		retn
DoIntA0		endp

; ---------------------------------------------------------------------------

DoIntA2:				; [unused] ??
		push	bp
		mov	bp, sp
		push	ds
		push	es
		push	di
		push	si
		mov	ax, [bp+4]
		int	0A2h		; used by BASIC	while in interpreter
		pop	si
		pop	di
		pop	es
		pop	ds
		pop	bp
		retn
; ---------------------------------------------------------------------------
byte_16110	db    0,   0,	0,   0,0FFh,   0,   0,	 0,   0,0FFh,	0,   0,0FFh,0FFh,   0,	 0
					; DATA XREF: DrawCharThing+5o
		db    0,   0,0FFh,   0,0FFh,   0,0FFh,	 0,   0,0FFh,0FFh,   0,0FFh,0FFh,0FFh,	 0
		db    0,   0,	0,0FFh,0FFh,   0,   0,0FFh,   0,0FFh,	0,0FFh,0FFh,0FFh,   0,0FFh
		db    0,   0,0FFh,0FFh,0FFh,   0,0FFh,0FFh,   0,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
textChrBuf	db 40h dup(0)		; DATA XREF: DrawCharBlock+12o
					; DrawCharBlock+24o ...
byte_16190	db 40h dup(0)		; DATA XREF: DrawCharBlock+27o
					; DrawCharBlock+2Fo ...
		db 40h dup(0)
txtSpacing	dw 0			; DATA XREF: SetTextOpts+18w
					; DrawChar_JIS+53r ...
txtFlags	dw 0			; DATA XREF: SetTextOpts+11w
					; DrawCharBlock+1Cr ...
txtPixPosX	dw 0			; DATA XREF: SetTextDrawPos+Aw
					; j_DrawString+Dr ...
txtPixPosY	dw 0			; DATA XREF: SetTextDrawPos+11w
					; j_DrawString+15r ...
word_16218	dw 0			; DATA XREF: SetTextOpts+Aw
					; DrawCharBlock+7Fr
txtChrPosX	dw 0			; DATA XREF: sub_1623B+Aw
					; j_DrawString+11w ...
txtChrPosY	dw 0			; DATA XREF: sub_1623B+11w
					; j_DrawString+19w ...
word_1621E	dw 0C7h			; DATA XREF: MaybeSetTxtFlags+Aw
					; DrawCharThing+Fr

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

SetTextDrawPos	proc near		; CODE XREF: sub_10EF9+30p
					; DrawString_Wait+39p ...

arg_0		= word ptr  4
arg_2		= word ptr  6

		push	bp
		mov	bp, sp
		push	di
		push	si
		push	ds
		push	es
		mov	ax, [bp+arg_0]
		mov	cs:txtPixPosX, ax
		mov	ax, [bp+arg_2]
		mov	cs:txtPixPosY, ax
		pop	es
		pop	ds
		pop	si
		pop	di
		pop	bp
		retn
SetTextDrawPos	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1623B	proc near		; CODE XREF: LoadFile2+61p

arg_0		= word ptr  4
arg_2		= word ptr  6

		push	bp
		mov	bp, sp
		push	di
		push	si
		push	ds
		push	es
		mov	ax, [bp+arg_0]
		mov	cs:txtChrPosX, ax
		mov	ax, [bp+arg_2]
		mov	cs:txtChrPosY, ax
		pop	es
		pop	ds
		pop	si
		pop	di
		pop	bp
		retn
sub_1623B	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

MaybeSetTxtFlags proc near		; CODE XREF: sub_10EF9+24p
					; sub_10EF9+56p

arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		push	di
		push	si
		push	ds
		push	es
		mov	ax, [bp+arg_0]
		mov	cs:word_1621E, ax
		pop	es
		pop	ds
		pop	si
		pop	di
		pop	bp
		retn
MaybeSetTxtFlags endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

SetTextOpts	proc near		; CODE XREF: sub_10EF9+1Ap
					; sub_10EF9+4Cp ...

arg_0		= word ptr  4
arg_2		= word ptr  6
arg_4		= word ptr  8

		push	bp
		mov	bp, sp
		push	di
		push	si
		push	ds
		push	es
		mov	ax, [bp+arg_0]
		mov	cs:word_16218, ax
		mov	ax, [bp+arg_2]
		mov	cs:txtFlags, ax
		mov	ax, [bp+arg_4]
		mov	cs:txtSpacing, ax
		pop	es
		pop	ds
		pop	si
		pop	di
		pop	bp
		retn
SetTextOpts	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

j_DrawString	proc near		; CODE XREF: sub_10EF9+3Ap
					; DrawString_Wait+24p ...

arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		push	di
		push	si
		push	ds
		push	es
		mov	si, [bp+arg_0]
		call	DrawString
		mov	ax, cs:txtPixPosX
		mov	cs:txtChrPosX, ax
		mov	ax, cs:txtPixPosY
		mov	cs:txtChrPosY, ax
		pop	es
		pop	ds
		pop	si
		pop	di
		pop	bp
		retn
j_DrawString	endp


; =============== S U B	R O U T	I N E =======================================


DrawString	proc near		; CODE XREF: j_DrawString+Ap
		push	ax
		push	bx
		push	cx
		push	dx
		push	si
		push	di
		push	ds
		push	es
		push	bp
		cld
		mov	ch, cl
		call	TextPos2VRAM
		mov	di, bx
		cli
		mov	al, 0Bh
		out	68h, al
		sti

loc_162C6:				; CODE XREF: DrawString+23j
					; DrawString+45j ...
		lodsb
		cmp	al, 80h
		jnb	short loc_162E8	; AL = 80..FF -> draw Shift-JIS	character
		cmp	al, 20h
		jnb	short loc_162F6	; AL = 20..7F -> draw ASCII character
		inc	di
		test	al, al
		jnz	short loc_162C6	; AL = 01..1F -> ignore
		cli			; AL = 00 -> end
		mov	al, 0Ah
		out	68h, al
		xor	al, al
		out	7Ch, al
		sti
		pop	bp
		pop	es
		pop	ds
		pop	di
		pop	si
		pop	dx
		pop	cx
		pop	bx
		pop	ax
		retn
; ---------------------------------------------------------------------------

loc_162E8:				; CODE XREF: DrawString+1Aj
		mov	ah, al
		lodsb
		call	ShiftJIS2JIS
		call	DrawChar_JIS
		add	di, 2
		jmp	short loc_162C6
; ---------------------------------------------------------------------------

loc_162F6:				; CODE XREF: DrawString+1Ej
		mov	ah, 9
		call	DrawChar_ASCII
		jmp	short loc_162C6
DrawString	endp


; =============== S U B	R O U T	I N E =======================================


ShiftJIS2JIS	proc near		; CODE XREF: DrawString+3Cp
		push	bx
		sub	ah, 70h
		cmp	ah, 30h
		jb	short loc_16309
		sub	ah, 40h

loc_16309:				; CODE XREF: ShiftJIS2JIS+7j
		shl	ah, 1
		dec	ah
		mov	bl, 1Fh
		and	al, al
		jns	short loc_1631D
		dec	al
		cmp	al, 9Eh
		jb	short loc_1631D
		mov	bl, 7Dh
		inc	ah

loc_1631D:				; CODE XREF: ShiftJIS2JIS+14j
					; ShiftJIS2JIS+1Aj
		sub	al, bl
		pop	bx
		retn
ShiftJIS2JIS	endp


; =============== S U B	R O U T	I N E =======================================


MaybeMakeTxtBold proc near		; CODE XREF: DrawCharBlock+17p
					; DrawCharBlock+34p ...
		and	cl, cl
		jnz	short loc_16326
		retn
; ---------------------------------------------------------------------------

loc_16326:				; CODE XREF: MaybeMakeTxtBold+2j
		mov	bx, cx
		mov	dx, 10h

loc_1632B:				; CODE XREF: MaybeMakeTxtBold+33j
		mov	ax, [si+2]
		xchg	ah, al
		mov	cl, bl
		shr	ax, cl
		mov	[si+3],	al
		mov	ax, [si+1]
		xchg	ah, al
		mov	cl, bl
		shr	ax, cl
		mov	[si+2],	al
		mov	ax, [si]
		xchg	ah, al
		mov	cl, bl
		shr	ax, cl
		mov	[si+1],	al
		mov	[si], ah
		add	si, 4
		dec	dx
		jnz	short loc_1632B
		retn
MaybeMakeTxtBold endp


; =============== S U B	R O U T	I N E =======================================


DrawCharThing	proc near		; CODE XREF: DrawCharBlock+7Cp
					; DrawCharBlock+89p
		xor	ah, ah
		shl	ax, 2
		mov	si, offset byte_16110
		add	si, ax
		mov	dx, 7Eh
		mov	al, 0C7h
		mov	ax, cs:word_1621E
		out	7Ch, al
		outsb
		outsb
		outsb
		outsb
		mov	si, di
		mov	ax, cs:txtPixPosY
		mov	cx, 50h
		mul	cx
		mov	di, ax
		mov	ax, cs:txtPixPosX
		shr	ax, 3
		add	di, ax
		add	di, bx
		mov	dx, di
		mov	cx, 10h
		mov	ax, 0E000h
		mov	es, ax
		assume es:nothing

loc_16392:				; CODE XREF: DrawCharThing+40j
		movsw
		movsw
		add	di, 4Ch
		loop	loc_16392
		xor	al, al
		out	7Ch, al
		retn
DrawCharThing	endp


; =============== S U B	R O U T	I N E =======================================


DrawCharBlock	proc near		; CODE XREF: DrawChar_JIS+50p
					; DrawChar_JIS+90p ...
		push	ax
		push	bx
		push	cx
		push	dx
		push	si
		push	di
		push	ds
		push	es
		push	bp
		cld
		mov	cl, byte ptr cs:txtPixPosX
		and	cl, 7
		mov	si, offset textChrBuf
		mov	cl, cl
		call	MaybeMakeTxtBold
		rep stosb
		test	byte ptr cs:txtFlags, 10h
		jz	short loc_163E7
		mov	si, offset textChrBuf
		mov	di, offset byte_16190
		mov	cx, 40h
		rep movsb
		mov	si, offset byte_16190
		mov	cl, 1
		call	MaybeMakeTxtBold
		rep stosb
		mov	si, offset byte_16190
		mov	di, offset textChrBuf
		mov	cx, 40h

loc_163E0:				; CODE XREF: DrawCharBlock+47j
		lodsb
		or	es:[di], al
		inc	di
		loop	loc_163E0

loc_163E7:				; CODE XREF: DrawCharBlock+22j
		mov	di, offset byte_16190
		mov	al, 0
		mov	cx, 40h
		rep stosb
		test	byte ptr cs:txtFlags, 20h
		jz	short loc_1640E
		mov	si, offset textChrBuf
		mov	di, offset byte_16190
		mov	cx, 40h
		rep movsb
		mov	si, offset byte_16190
		mov	cl, 1
		call	MaybeMakeTxtBold
		rep stosb

loc_1640E:				; CODE XREF: DrawCharBlock+59j
		mov	al, byte ptr cs:txtFlags
		and	al, 0Fh
		mov	di, offset byte_16190
		mov	bx, 50h
		call	DrawCharThing
		mov	al, byte ptr cs:word_16218
		mov	di, offset textChrBuf
		mov	bx, 0
		call	DrawCharThing
		pop	bp
		pop	es
		assume es:nothing
		pop	ds
		pop	di
		pop	si
		pop	dx
		pop	cx
		pop	bx
		pop	ax
		retn
DrawCharBlock	endp


; =============== S U B	R O U T	I N E =======================================


DrawChar_JIS	proc near		; CODE XREF: DrawString+3Fp
		push	ax
		push	bx
		push	cx
		push	dx
		push	si
		push	di
		push	ds
		push	es
		push	bp
		push	di
		push	si
		push	bx
		push	dx
		cld
		mov	dx, di
		mov	bx, 800h
		sub	ax, 2000h	; make it a "true" ROM code
		cmp	ax, 203h
		jz	short loc_164A1	; JIS code 2223	(U+25A0) - draw	opaque filled rectangle
		out	0A1h, al	; Interrupt Controller #2, 8259A
		mov	al, ah
		out	0A3h, al	; Interrupt Controller #2, 8259A
		mov	ax, cs
		mov	ds, ax
		assume ds:seg000
		mov	es, ax
		assume es:seg000
		mov	di, offset textChrBuf
		mov	al, 0
		mov	cx, 40h
		rep stosb
		mov	cl, 0
		mov	di, offset textChrBuf

loc_1646A:				; CODE XREF: DrawChar_JIS+4Ej
		mov	al, cl
		or	al, 20h
		out	0A5h, al	; Interrupt Controller #2, 8259A
		in	al, 0A9h	; Interrupt Controller #2, 8259A
		stosb
		mov	al, cl
		out	0A5h, al	; Interrupt Controller #2, 8259A
		in	al, 0A9h	; Interrupt Controller #2, 8259A
		stosb
		add	di, 2
		inc	cl
		cmp	cl, 10h
		jnz	short loc_1646A
		call	DrawCharBlock
		mov	ax, cs:txtSpacing
		add	ax, 10h
		add	cs:txtPixPosX, ax
		pop	dx
		pop	bx
		pop	si
		pop	di
		pop	bp
		pop	es
		assume es:nothing
		pop	ds
		assume ds:dseg
		pop	di
		pop	si
		pop	dx
		pop	cx
		pop	bx
		pop	ax
		retn
; ---------------------------------------------------------------------------

loc_164A1:				; CODE XREF: DrawChar_JIS+19j
		mov	ax, cs
		mov	ds, ax
		assume ds:seg000
		mov	es, ax
		assume es:seg000
		mov	di, offset textChrBuf
		mov	al, 0
		mov	cx, 40h
		rep stosb
		mov	cl, 0
		mov	di, offset textChrBuf
		mov	al, 0FFh

loc_164B8:				; CODE XREF: DrawChar_JIS+8Ej
		stosb
		stosb
		add	di, 2
		inc	cl
		cmp	cl, 10h
		jnz	short loc_164B8
		call	DrawCharBlock
		mov	ax, cs:txtSpacing
		add	ax, 10h
		add	cs:txtPixPosX, ax
		pop	dx
		pop	bx
		pop	si
		pop	di
		pop	bp
		pop	es
		assume es:nothing
		pop	ds
		assume ds:dseg
		pop	di
		pop	si
		pop	dx
		pop	cx
		pop	bx
		pop	ax
		retn
DrawChar_JIS	endp


; =============== S U B	R O U T	I N E =======================================


DrawChar_ASCII	proc near		; CODE XREF: DrawString+49p
		push	ax
		push	bx
		push	cx
		push	dx
		push	si
		push	di
		push	ds
		push	es
		push	bp
		push	di
		push	dx
		out	0A1h, al	; Interrupt Controller #2, 8259A
		mov	al, ah
		out	0A3h, al	; Interrupt Controller #2, 8259A
		mov	ax, cs
		mov	ds, ax
		assume ds:seg000
		mov	es, ax
		assume es:seg000
		mov	di, offset textChrBuf
		mov	al, 0
		mov	cx, 40h
		rep stosb
		mov	di, offset textChrBuf
		mov	al, 0
		mov	cx, 40h
		rep stosb
		mov	cl, 0
		mov	di, offset textChrBuf

loc_16511:				; CODE XREF: DrawChar_ASCII+46j
		mov	al, cl
		or	al, 20h
		out	0A5h, al	; Interrupt Controller #2, 8259A
		in	al, 0A9h	; Interrupt Controller #2, 8259A
		stosb
		add	di, 3
		inc	cl
		not	cs:word_16546
		cmp	cl, 10h
		jnz	short loc_16511
		call	DrawCharBlock
		mov	ax, cs:txtSpacing
		shr	ax, 1
		add	ax, 8
		add	cs:txtPixPosX, ax
		pop	dx
		pop	di
		pop	bp
		pop	es
		assume es:nothing
		pop	ds
		assume ds:dseg
		pop	di
		pop	si
		pop	dx
		pop	cx
		pop	bx
		pop	ax
		retn
DrawChar_ASCII	endp

; ---------------------------------------------------------------------------
word_16546	dw 0AAAAh		; DATA XREF: DrawChar_ASCII+3Ew

; =============== S U B	R O U T	I N E =======================================


TextPos2VRAM	proc near		; CODE XREF: DrawString+Cp
		push	ax
		push	dx
		xor	ax, ax
		mov	al, bh
		mov	dx, 50h
		mul	dx
		xor	bh, bh
		add	bx, ax
		pop	dx
		pop	ax
		retn
TextPos2VRAM	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

GetTextChrPos	proc near		; CODE XREF: LoadFile2+41p
					; WaitForInput+1Cp

arg_0		= word ptr  4
arg_2		= word ptr  6

		push	bp
		mov	bp, sp
		push	di
		push	si
		push	ds
		push	es
		mov	ax, cs:txtChrPosX
		mov	bx, [bp+arg_0]
		mov	[bx], ax
		mov	ax, cs:txtChrPosY
		mov	bx, [bp+arg_2]
		mov	[bx], ax
		pop	es
		pop	ds
		pop	si
		pop	di
		pop	bp
		retn
GetTextChrPos	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

GetTextPixPos	proc near		; CODE XREF: DrawString_Wait+1Bp
					; sub_17C81+11p

arg_0		= word ptr  4
arg_2		= word ptr  6

		push	bp
		mov	bp, sp
		push	di
		push	si
		push	ds
		push	es
		mov	ax, cs:txtPixPosX
		mov	bx, [bp+arg_0]
		mov	[bx], ax
		mov	ax, cs:txtPixPosY
		mov	bx, [bp+arg_2]
		mov	[bx], ax
		pop	es
		pop	ds
		pop	si
		pop	di
		pop	bp
		retn
GetTextPixPos	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

CopyRect_Plane3	proc near		; CODE XREF: ClearTextBox+7Cp
					; ClearTextBox+B6p

arg_0		= word ptr  4
arg_2		= word ptr  6
arg_4		= word ptr  8
arg_6		= word ptr  0Ah

		push	bp
		mov	bp, sp
		push	di
		push	si
		push	ds
		push	es
		mov	di, [bp+arg_0]
		mov	si, [bp+arg_2]
		mov	ax, [bp+arg_4]
		mov	bx, 50h
		sub	bx, ax
		mov	ax, 0E000h
		mov	es, ax
		assume es:nothing
		mov	ds, ax
		assume ds:nothing
		cld
		mov	dx, [bp+arg_6]

loc_165B8:				; CODE XREF: CopyRect_Plane3+2Aj
		mov	cx, [bp+arg_4]
		rep movsb
		add	si, bx
		add	di, bx
		dec	dx
		jnz	short loc_165B8
		pop	es
		assume es:nothing
		pop	ds
		assume ds:dseg
		pop	si
		pop	di
		pop	bp
		retn
CopyRect_Plane3	endp

; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		push	di
		push	si
		push	ds
		push	es
		mov	di, [bp+4]
		mov	dx, [bp+6]
		mov	bx, [bp+8]
		mov	ax, 0E000h
		mov	es, ax
		assume es:nothing
		mov	ds, ax
		assume ds:nothing
		cld
		xor	ax, ax

loc_165E4:				; CODE XREF: seg000:65ECj
		mov	cx, 28h
		rep stosw
		add	di, dx
		dec	bx
		jnz	short loc_165E4
		pop	es
		assume es:nothing
		pop	ds
		assume ds:dseg
		pop	si
		pop	di
		pop	bp
		retn

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

ClearRect_Plane3 proc near		; CODE XREF: ClearTextBox+9Bp
					; ClearTextBox+D5p

arg_0		= word ptr  4
arg_2		= word ptr  6
arg_4		= word ptr  8

		push	bp
		mov	bp, sp
		push	di
		push	si
		push	ds
		push	es
		mov	di, [bp+arg_0]
		mov	ax, [bp+arg_2]
		mov	bx, 50h
		sub	bx, ax
		mov	ax, 0E000h
		mov	es, ax
		assume es:nothing
		mov	ds, ax
		assume ds:nothing
		cld
		mov	dx, [bp+arg_4]
		xor	ax, ax

loc_16613:				; CODE XREF: ClearRect_Plane3+27j
		mov	cx, [bp+arg_2]
		rep stosb
		add	di, bx
		dec	dx
		jnz	short loc_16613
		pop	es
		assume es:nothing
		pop	ds
		assume ds:dseg
		pop	si
		pop	di
		pop	bp
		retn
ClearRect_Plane3 endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_16623	proc near		; CODE XREF: DrawText_Tb1b+52p
					; DrawText_Tb1b+7Cp ...

arg_0		= word ptr  4
arg_2		= word ptr  6
arg_4		= word ptr  8
arg_6		= word ptr  0Ah

		push	bp
		mov	bp, sp
		push	di
		push	si
		push	ds
		push	es
		mov	di, [bp+arg_0]
		mov	ax, [bp+arg_2]
		mov	bx, 50h	; 'P'
		sub	bx, ax
		add	bx, [bp+arg_6]
		mov	ax, 0E000h
		mov	es, ax
		assume es:nothing
		mov	ds, ax
		assume ds:nothing
		cld
		mov	dx, [bp+arg_4]
		xor	ax, ax

loc_16645:				; CODE XREF: sub_16623+2Aj
		mov	cx, [bp+arg_2]
		rep stosb
		add	di, bx
		dec	dx
		jnz	short loc_16645
		pop	es
		assume es:nothing
		pop	ds
		assume ds:dseg
		pop	si
		pop	di
		pop	bp
		retn
sub_16623	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_16655	proc near		; CODE XREF: ScrollTextOutUp+9Ap
					; ScrollTextOutUp+CCp ...

arg_0		= word ptr  4
arg_2		= word ptr  6
arg_4		= word ptr  8
arg_6		= word ptr  0Ah

		push	bp
		mov	bp, sp
		push	di
		push	si
		push	ds
		push	es
		mov	di, [bp+arg_0]
		mov	si, [bp+arg_2]
		mov	ax, [bp+arg_4]
		mov	bx, 50h	; 'P'
		sub	bx, ax
		mov	ax, 0E000h
		mov	es, ax
		assume es:nothing
		mov	ds, ax
		assume ds:nothing
		cld
		mov	dx, [bp+arg_6]

loc_16675:				; CODE XREF: sub_16655+2Aj
		mov	cx, [bp+arg_4]
		rep movsb
		add	si, bx
		add	di, bx
		dec	dx
		jnz	short loc_16675
		pop	es
		assume es:nothing
		pop	ds
		assume ds:dseg
		pop	si
		pop	di
		pop	bp
		retn
sub_16655	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_16687	proc near		; CODE XREF: sub_17610+54p

arg_0		= word ptr  4
arg_2		= word ptr  6
arg_4		= word ptr  8

		push	bp
		mov	bp, sp
		push	di
		push	si
		push	ds
		push	es
		mov	di, [bp+arg_0]
		mov	si, [bp+arg_2]
		mov	cx, [bp+arg_4]
		mov	ax, 0E000h
		mov	es, ax
		assume es:nothing
		mov	ds, ax
		assume ds:nothing
		cld
		rep movsw
		pop	es
		assume es:nothing
		pop	ds
		assume ds:dseg
		pop	si
		pop	di
		pop	bp
		retn
sub_16687	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_166A7	proc near		; CODE XREF: sub_17166+46p
					; sub_17166+62p

arg_0		= word ptr  4
arg_2		= word ptr  6
arg_4		= word ptr  8
arg_6		= word ptr  0Ah

		push	bp
		mov	bp, sp
		push	di
		push	si
		push	ds
		push	es
		mov	di, [bp+arg_0]
		mov	ax, [bp+arg_2]
		mov	bx, 50h	; 'P'
		sub	bx, ax
		add	bx, [bp+arg_6]
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		cld
		mov	dx, [bp+arg_4]
		mov	di, [bp+arg_0]
		xor	ax, ax

loc_166CA:				; CODE XREF: sub_166A7+2Bj
		mov	cx, [bp+arg_2]
		rep stosb
		add	di, bx
		dec	dx
		jnz	short loc_166CA
		mov	ax, 0B000h
		mov	es, ax
		assume es:nothing
		cld
		mov	di, [bp+arg_0]
		mov	dx, [bp+arg_4]
		xor	ax, ax

loc_166E2:				; CODE XREF: sub_166A7+43j
		mov	cx, [bp+arg_2]
		rep stosb
		add	di, bx
		dec	dx
		jnz	short loc_166E2
		mov	ax, 0B800h
		mov	es, ax
		assume es:nothing
		cld
		mov	di, [bp+arg_0]
		mov	dx, [bp+arg_4]
		xor	ax, ax

loc_166FA:				; CODE XREF: sub_166A7+5Bj
		mov	cx, [bp+arg_2]
		rep stosb
		add	di, bx
		dec	dx
		jnz	short loc_166FA
		pop	es
		assume es:nothing
		pop	ds
		pop	si
		pop	di
		pop	bp
		retn
sub_166A7	endp

; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		push	di
		push	si
		push	ds
		push	es
		mov	al, [bp+4]
		mov	ah, 4
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		xchg	al, ah
		xor	ah, ah
		pop	es
		pop	ds
		pop	si
		pop	di
		pop	bp
		retn
; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		push	di
		push	si
		push	ds
		push	es
		in	al, 2		; DMA controller, 8237A-5.
					; channel 1 current address
		or	al, 2
		out	2, al		; DMA controller, 8237A-5.
					; channel 1 base address
					; (also	sets current address)
		pop	es
		pop	ds
		pop	si
		pop	di
		pop	bp
		retn
; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		push	di
		push	si
		push	ds
		push	es
		in	al, 2		; DMA controller, 8237A-5.
					; channel 1 current address
		and	al, 0FDh
		out	2, al		; DMA controller, 8237A-5.
					; channel 1 base address
					; (also	sets current address)
		pop	es
		pop	ds
		pop	si
		pop	di
		pop	bp
		retn

; =============== S U B	R O U T	I N E =======================================


sub_16748	proc near		; CODE XREF: _main+136p
		push	bp
		push	es
		xor	ax, ax
		mov	es, ax
		assume es:nothing
		mov	bl, es:500h
		or	bl, 20h
		mov	es:500h, bl
		pop	es
		assume es:nothing
		pop	bp
		retn
sub_16748	endp

; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		push	di
		push	si
		push	ds
		push	es
		mov	ah, 3
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		pop	es
		pop	ds
		pop	si
		pop	di
		pop	bp
		retn

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1676F	proc near		; CODE XREF: sub_132AF+Cp
					; sub_132AF+2Ap ...

arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		push	di
		push	si
		push	ds
		push	es
		mov	dx, [bp+arg_0]
		in	al, dx
		xor	ah, ah
		pop	es
		pop	ds
		pop	si
		pop	di
		pop	bp
		retn
sub_1676F	endp

; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		push	di
		push	si
		push	ds
		push	es
		mov	dl, 0FFh
		mov	ah, 6
		int	21h		; DOS -	DIRECT CONSOLE I/O CHARACTER OUTPUT
					; DL = character <> FFh
					;  Return: ZF set = no character
					;   ZF clear = character recieved, AL =	character
		jz	short loc_16799
		xor	ah, ah
		pop	es
		pop	ds
		pop	si
		pop	di
		pop	bp
		retn
; ---------------------------------------------------------------------------

loc_16799:				; CODE XREF: seg000:678Fj
		mov	al, 0FFh
		xor	ah, ah
		pop	es
		pop	ds
		pop	si
		pop	di
		pop	bp
		retn

; =============== S U B	R O U T	I N E =======================================


sub_167A3	proc near		; CODE XREF: ExecuteScript+81p
					; sub_17D1E:loc_17D38p	...
		push	bp
		mov	ah, 1
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		xor	ah, ah
		mov	al, bh
		pop	bp
		retn
sub_167A3	endp


; =============== S U B	R O U T	I N E =======================================


sub_167AE	proc near		; CODE XREF: ExecuteScript+88p
					; sub_17D1E+21p ...
		push	bp
		mov	ah, 0
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		xor	ah, ah
		pop	bp
		retn
sub_167AE	endp

; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		push	di
		push	si
		push	ds
		push	es
		mov	bx, 0A0h ; ' '
		mov	ax, 1
		mul	bl
		mov	di, ax
		mov	si, ax
		add	si, 0A0h ; ' '
		mov	cx, 14h

loc_167D1:				; CODE XREF: seg000:67D6j
		push	cx
		call	sub_167F4
		pop	cx
		loop	loc_167D1
		push	di
		add	di, 2000h
		mov	ax, 0FF81h
		mov	cx, 50h	; 'P'
		rep stosw
		pop	di
		mov	ax, 20h	; ' '
		mov	cx, 50h	; 'P'
		rep stosw
		pop	es
		pop	ds
		pop	si
		pop	di
		pop	bp
		retn

; =============== S U B	R O U T	I N E =======================================


sub_167F4	proc near		; CODE XREF: seg000:67D2p
		cld
		mov	ax, 0A000h
		mov	es, ax
		assume es:nothing
		mov	ds, ax
		assume ds:nothing
		push	si
		push	di
		add	si, 2000h
		add	di, 2000h
		mov	cx, 50h	; 'P'
		rep movsw
		pop	di
		pop	si
		mov	cx, 50h	; 'P'
		rep movsw
		retn
sub_167F4	endp

; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		push	di
		push	si
		push	ds
		push	es
		mov	cl, 0Dh
		mov	dx, 90Eh
		mov	ax, 0
		int	0DCh		; used by BASIC	while in interpreter
		pop	es
		assume es:nothing
		pop	ds
		assume ds:dseg
		pop	si
		pop	di
		pop	bp
		retn
; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		push	di
		push	si
		push	ds
		push	es
		mov	cl, 0Ch
		mov	dx, 78Ch
		mov	ax, 0
		int	0DCh		; used by BASIC	while in interpreter
		pop	es
		pop	ds
		pop	si
		pop	di
		pop	bp
		retn
; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		push	di
		push	si
		push	ds
		push	es
		mov	cl, 0Dh
		mov	dx, 78Ch
		mov	ax, 0
		int	0DCh		; used by BASIC	while in interpreter
		pop	es
		pop	ds
		pop	si
		pop	di
		pop	bp
		retn

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_16858	proc near		; CODE XREF: DrawString_Wait+4Fp
		push	bp
		mov	bp, sp
		push	di
		push	si
		push	ds
		push	es
		mov	ah, 2
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		xor	ah, ah
		pop	es
		pop	ds
		pop	si
		pop	di
		pop	bp
		retn
sub_16858	endp

; ---------------------------------------------------------------------------
		push	bp		; [unused] ??
		mov	bp, sp
		push	di
		push	si
		push	ds
		push	es
		mov	si, [bp+4]
		cld

loc_16876:				; CODE XREF: seg000:6881j
		lodsb
		or	al, al
		jz	short loc_16883
		mov	ah, 6
		mov	dl, al
		int	21h		; DOS -	DIRECT CONSOLE I/O CHARACTER OUTPUT
					; DL = character <> FFh
					;  Return: ZF set = no character
					;   ZF clear = character recieved, AL =	character
		jmp	short loc_16876
; ---------------------------------------------------------------------------

loc_16883:				; CODE XREF: seg000:6879j
		pop	es
		pop	ds
		pop	si
		pop	di
		pop	bp
		retn

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_16889	proc near		; CODE XREF: _main+143p

arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		push	ds
		push	es
		push	si
		push	di
		mov	ax, [bp+arg_0]
		or	ax, ax
		jnz	short loc_1689C
		mov	ah, 0Dh
		jmp	short loc_1689E
; ---------------------------------------------------------------------------
		align 2

loc_1689C:				; CODE XREF: sub_16889+Cj
		mov	ah, 0Ch

loc_1689E:				; CODE XREF: sub_16889+10j
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		pop	di
		pop	si
		pop	es
		pop	ds
		mov	sp, bp
		pop	bp
		retn
sub_16889	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

ClearTextBox	proc near		; CODE XREF: DrawText_Name+72p
					; DrawText_Dialog+103p	...

var_8		= word ptr -8
var_6		= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2
arg_tBoxID	= word ptr  4

		push	bp
		mov	bp, sp
		mov	ax, 8
		call	__chkstk
		push	si
		mov	ax, 12h
		imul	[bp+arg_tBoxID]
		mov	si, ax
		mov	ax, 50h
		imul	TextBoxes.baseY[si]
		mov	cx, ax
		mov	ax, word ptr TextBoxes.baseX[si]
		mov	bx, cx
		cwd
		xor	ax, dx
		sub	ax, dx
		mov	cx, 3
		sar	ax, cl
		xor	ax, dx
		sub	ax, dx
		add	ax, bx
		mov	[bp+var_6], ax
		mov	ax, 50h
		imul	TextBoxes.txSzY[si]
		add	ax, [bp+var_6]
		mov	[bp+var_2], ax
		mov	ax, TextBoxes.txSzX[si]
		imul	TextBoxes.sizeX[si]
		cwd
		xor	ax, dx
		sub	ax, dx
		sar	ax, cl
		xor	ax, dx
		sub	ax, dx
		add	ax, 2
		mov	[bp+var_4], ax
		mov	ax, TextBoxes.sizeY[si]
		dec	ax
		imul	TextBoxes.txSzY[si]
		mov	[bp+var_8], ax
		mov	ax, 1
		push	ax
		call	SetGDCPlane_Wrt
		add	sp, 2
		push	[bp+var_8]
		push	[bp+var_4]
		push	[bp+var_2]
		push	[bp+var_6]
		call	CopyRect_Plane3
		add	sp, 8
		mov	ax, 12h
		imul	[bp+arg_tBoxID]
		mov	bx, ax
		push	TextBoxes.txSzY[bx]
		push	[bp+var_4]
		mov	ax, 50h
		mul	[bp+var_8]
		add	ax, [bp+var_6]
		push	ax
		call	ClearRect_Plane3
		add	sp, 6
		sub	ax, ax
		push	ax
		call	SetGDCPlane_Wrt
		add	sp, 2
		push	[bp+var_8]
		push	[bp+var_4]
		push	[bp+var_2]
		push	[bp+var_6]
		call	CopyRect_Plane3
		add	sp, 8
		mov	ax, 12h
		imul	[bp+arg_tBoxID]
		mov	bx, ax
		push	TextBoxes.txSzY[bx]
		push	[bp+var_4]
		mov	ax, 50h
		mul	[bp+var_8]
		add	ax, [bp+var_6]
		push	ax
		call	ClearRect_Plane3
		add	sp, 6
		pop	si
		mov	sp, bp
		pop	bp
		retn
ClearTextBox	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

DrawString_Wait	proc near		; CODE XREF: DrawText_Name+D3p
					; DrawText_Name+FFp ...

var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		mov	ax, 4
		call	__chkstk
		mov	ax, 1
		push	ax
		call	SetGDCPlane_Wrt
		add	sp, 2
		lea	ax, [bp+var_4]
		push	ax
		lea	ax, [bp+var_2]
		push	ax
		call	GetTextPixPos
		add	sp, 4
		push	[bp+arg_0]
		call	j_DrawString
		add	sp, 2
		sub	ax, ax
		push	ax
		call	SetGDCPlane_Wrt
		add	sp, 2
		push	[bp+var_4]
		push	[bp+var_2]
		call	SetTextDrawPos
		add	sp, 4
		push	[bp+arg_0]
		call	j_DrawString
		add	sp, 2
		cmp	word_1AB52, 0
		jz	short loc_169EA
		call	sub_16858
		test	al, 1
		jz	short loc_169EA
		mov	ax, 1
		push	ax
		call	WaitFrames	; wait 1 frame
		add	sp, 2
		jmp	short loc_169F4
; ---------------------------------------------------------------------------

loc_169EA:				; CODE XREF: DrawString_Wait+4Dj
					; DrawString_Wait+54j
		mov	ax, 4
		push	ax
		call	WaitFrames	; wait 4 frames
		add	sp, 2

loc_169F4:				; CODE XREF: DrawString_Wait+60j
		mov	sp, bp
		pop	bp
		retn
DrawString_Wait	endp


; =============== S U B	R O U T	I N E =======================================

; Used to draw names inside the	dialog box  character-by-character.
; Up to	7 full-width characters	can be used for	the name.
; Always uses text box 2.
; Attributes: bp-based frame

DrawText_Name	proc near		; CODE XREF: ExecuteScript+E9p
					; ExecuteScript+185p ...

dataOfs		= word ptr -10h
remWidth	= word ptr -0Eh
buffer		= byte ptr -0Ch
bufLen		= word ptr -2
arg_textData	= word ptr  4

		push	bp
		mov	bp, sp
		mov	ax, 10h
		call	__chkstk
		push	si
		mov	[bp+dataOfs], 0
		mov	[bp+bufLen], 0
		mov	[bp+remWidth], 7 ; remaining width of the name:	7x full-width
		mov	ax, TextBoxes.baseX+24h
		mov	tbox2BasePosX, ax
		mov	ax, TextBoxes.txSzY+24h
		imul	TextBoxes.txPosY+24h
		add	ax, TextBoxes.baseY+24h
		mov	tbox2BasePosY, ax
		push	ax
		push	tbox2BasePosX
		call	SetTextDrawPos
		add	sp, 4
		cmp	TextBoxes.txPosY+24h, 0
		jnz	short loc_16A3E
		cmp	TextBoxes.txPosX+24h, 0
		jz	short loc_16A84

loc_16A3E:				; CODE XREF: DrawText_Name+3Dj
		mov	ax, TextBoxes.sizeY+24h
		dec	ax
		cmp	ax, TextBoxes.txPosY+24h
		jz	short loc_16A66
		inc	TextBoxes.txPosY+24h
		mov	ax, word_1B1E0
		add	ax, 10h
		add	tbox2BasePosY, ax
		push	tbox2BasePosY
		push	tbox2BasePosX
		call	SetTextDrawPos
		add	sp, 4
		jmp	short loc_16A84
; ---------------------------------------------------------------------------

loc_16A66:				; CODE XREF: DrawText_Name+4Ej
		mov	ax, 2
		push	ax
		call	ClearTextBox
		add	sp, 2
		mov	TextBoxes.txPosX+24h, 0
		push	tbox2BasePosY
		push	tbox2BasePosX
		call	SetTextDrawPos
		add	sp, 4

loc_16A84:				; CODE XREF: DrawText_Name+44j
					; DrawText_Name+6Cj ...
		mov	ax, [bp+bufLen]
		add	[bp+dataOfs], ax
		mov	bx, [bp+dataOfs]
		mov	si, [bp+arg_textData]
		cmp	byte ptr [bx+si], 0
		jnz	short loc_16A97
		jmp	short loc_16AD6
; ---------------------------------------------------------------------------

loc_16A97:				; CODE XREF: DrawText_Name+9Bj
		mov	si, bx
		add	si, [bp+arg_textData]
		mov	al, [si]
		mov	[bp+buffer], al
		mov	al, [si+1]
		mov	[bp+buffer+1], al
		cmp	[bp+buffer], 80h
		jb	short loc_16ABE	; 00..7F -> single-byte	character
		cmp	[bp+buffer], 0EBh
		jnb	short loc_16ABE	; EB..FF -> single-byte	character
		mov	[bp+buffer+2], 0 ; 80..EA -> double-byte character
		mov	[bp+bufLen], 2
		jmp	short loc_16AC7
; ---------------------------------------------------------------------------

loc_16ABE:				; CODE XREF: DrawText_Name+B3j
					; DrawText_Name+B9j
		mov	[bp+buffer+1], 0
		mov	[bp+bufLen], 1

loc_16AC7:				; CODE XREF: DrawText_Name+C4j
		lea	ax, [bp+buffer]
		push	ax
		call	DrawString_Wait
		add	sp, 2
		dec	[bp+remWidth]
		jmp	short loc_16A84
; ---------------------------------------------------------------------------

loc_16AD6:				; CODE XREF: DrawText_Name+9Dj
		mov	[bp+buffer], 81h ; past	end of the name: draw dummy spaces
		mov	[bp+buffer+1], 40h
		mov	[bp+buffer+2], 0
		mov	ax, [bp+remWidth]
		mov	[bp+dataOfs], ax ; Note	that this will draw N full-width spaces,
		jmp	short loc_16AED	; with a delay between each space.
; ---------------------------------------------------------------------------

loc_16AEA:				; CODE XREF: DrawText_Name+105j
		dec	[bp+dataOfs]

loc_16AED:				; CODE XREF: DrawText_Name+F0j
		cmp	[bp+dataOfs], 0
		jle	short loc_16AFF
		lea	ax, [bp+buffer]
		push	ax
		call	DrawString_Wait
		add	sp, 2
		jmp	short loc_16AEA
; ---------------------------------------------------------------------------

loc_16AFF:				; CODE XREF: DrawText_Name+F9j
		mov	TextBoxes.txPosX+24h, 7	; force	X start	position to 7
		mov	dialogHasIndent, 1
		pop	si
		mov	sp, bp
		pop	bp
		retn
DrawText_Name	endp


; =============== S U B	R O U T	I N E =======================================

; Used to draw dialog text character-by-character.
; Always uses text box 2.
; Includes handling for	control	codes 'W', 'w' and ';'.
; Attributes: bp-based frame

DrawText_Dialog	proc near		; CODE XREF: ExecuteScript+F7p
					; ExecuteScript+11Ep ...

dataOfs		= word ptr -0Eh
buffer		= byte ptr -0Ch
bufLen		= word ptr -2
arg_textData	= dword	ptr  4

		push	bp
		mov	bp, sp
		mov	ax, 12h
		call	__chkstk
		push	si
		mov	[bp+dataOfs], 0
		mov	[bp+bufLen], 0
		mov	ax, TextBoxes.txSzX+24h
		imul	TextBoxes.txPosX+24h
		add	ax, TextBoxes.baseX+24h
		mov	tbox2BasePosX, ax
		mov	ax, TextBoxes.txSzY+24h
		imul	TextBoxes.txPosY+24h
		add	ax, TextBoxes.baseY+24h
		mov	tbox2BasePosY, ax
		cmp	dialogHasIndent, 0
		jnz	short loc_16B4D
		mov	dlgTextYPos, 0

loc_16B4D:				; CODE XREF: DrawText_Dialog+35j
		mov	dialogHasIndent, 0

loc_16B53:				; CODE XREF: DrawText_Dialog:loc_16C5Aj
		cmp	stopDialogDraw,	0
		jz	short loc_16B5D
		jmp	dtxt_dlg_fin
; ---------------------------------------------------------------------------

loc_16B5D:				; CODE XREF: DrawText_Dialog+48j
		mov	ax, [bp+bufLen]
		add	[bp+dataOfs], ax
		mov	bx, [bp+dataOfs]
		les	si, [bp+arg_textData]
		cmp	byte ptr es:[bx+si], 0
		jnz	short loc_16B72
		jmp	dtxt_dlg_fin
; ---------------------------------------------------------------------------

loc_16B72:				; CODE XREF: DrawText_Dialog+5Dj
		mov	si, word ptr [bp+arg_textData]
		mov	al, es:[bx+si]
		mov	[bp+buffer], al
		mov	si, bx
		mov	bx, word ptr [bp+arg_textData]
		mov	al, es:[bx+si+1]
		mov	[bp+buffer+1], al
		cmp	[bp+buffer], 80h
		jb	short loc_16B9E	; 00..7F -> single-byte	character
		cmp	[bp+buffer], 0EBh
		jnb	short loc_16B9E	; EB..FF -> single-byte	character
		mov	[bp+buffer+2], 0 ; 80..EA -> double-byte character
		mov	[bp+bufLen], 2
		jmp	short loc_16BA7
; ---------------------------------------------------------------------------

loc_16B9E:				; CODE XREF: DrawText_Dialog+7Bj
					; DrawText_Dialog+81j
		mov	[bp+buffer+1], 0
		mov	[bp+bufLen], 1

loc_16BA7:				; CODE XREF: DrawText_Dialog+8Cj
		cmp	[bp+buffer+1], 0
		jnz	short loc_16BB0
		jmp	loc_16C38
; ---------------------------------------------------------------------------

loc_16BB0:				; CODE XREF: DrawText_Dialog+9Bj
		mov	ax, TextBoxes.sizeX+24h
		cmp	TextBoxes.txPosX+24h, ax
		jl	short loc_16C38
		inc	dlgTextYPos	; handle automatic line	break
		mov	ax, dlgTextYPos
		cmp	TextBoxes.sizeY+24h, ax
		jnz	short loc_16BD6
		mov	ax, 2
		push	ax
		call	WaitForInput
		add	sp, 2
		mov	dlgTextYPos, 0

loc_16BD6:				; CODE XREF: DrawText_Dialog+B4j
		mov	ax, TextBoxes.sizeY+24h
		dec	ax
		cmp	ax, TextBoxes.txPosY+24h
		jle	short loc_16C0F
		mov	TextBoxes.txPosX+24h, 8
		inc	TextBoxes.txPosY+24h
		mov	ax, word_1B1E0
		add	ax, 10h
		add	tbox2BasePosY, ax
		mov	ax, TextBoxes.txSzX+24h
		mov	cl, 3
		shl	ax, cl
		add	ax, TextBoxes.baseX+24h
		mov	tbox2BasePosX, ax
		push	tbox2BasePosY
		push	ax
		call	SetTextDrawPos
		add	sp, 4
		jmp	short loc_16C38
; ---------------------------------------------------------------------------

loc_16C0F:				; CODE XREF: DrawText_Dialog+CEj
		mov	ax, 2
		push	ax
		call	ClearTextBox
		add	sp, 2
		mov	TextBoxes.txPosX+24h, 8
		mov	ax, TextBoxes.txSzX+24h
		mov	cl, 3
		shl	ax, cl
		add	ax, TextBoxes.baseX+24h
		mov	tbox2BasePosX, ax
		push	tbox2BasePosY
		push	ax
		call	SetTextDrawPos
		add	sp, 4

loc_16C38:				; CODE XREF: DrawText_Dialog+9Dj
					; DrawText_Dialog+A7j ...
		cmp	[bp+buffer+1], 0
		jz	short loc_16C4E
		lea	ax, [bp+buffer]
		push	ax
		call	DrawString_Wait
		add	sp, 2
		inc	TextBoxes.txPosX+24h
		jmp	short loc_16C5A
; ---------------------------------------------------------------------------

loc_16C4E:				; CODE XREF: DrawText_Dialog+12Cj
		cmp	[bp+buffer], ';'
		jnz	short loc_16C5A
		mov	dialogHasIndent, 1 ; set "dialogue continuation" flag

loc_16C5A:				; CODE XREF: DrawText_Dialog+13Cj
					; DrawText_Dialog+142j
		jmp	loc_16B53
; ---------------------------------------------------------------------------

dtxt_dlg_fin:				; CODE XREF: DrawText_Dialog+4Aj
					; DrawText_Dialog+5Fj
		cmp	dialogHasIndent, 0
		jnz	short loc_16C87	; "dialogue continuation" set -> don't wait
		cmp	[bp+buffer], 'w' ; The last parsed letter was a 'w' -> don't wait for user input
		jz	short loc_16C81
		cmp	[bp+buffer], 'W'
		jz	short loc_16C81
		call	IsSlowTextEnabled
		or	ax, ax
		jnz	short loc_16C81
		mov	ax, 2		; text box ID
		push	ax
		call	WaitForInput
		add	sp, 2

loc_16C81:				; CODE XREF: DrawText_Dialog+158j
					; DrawText_Dialog+15Ej	...
		mov	dlgTextYPos, 0

loc_16C87:				; CODE XREF: DrawText_Dialog+152j
		pop	si
		mov	sp, bp
		pop	bp
		retn
DrawText_Dialog	endp


; =============== S U B	R O U T	I N E =======================================

; Always uses text box 1.
; Attributes: bp-based frame

DrawText_Tb1a	proc near		; CODE XREF: DrawText_TB1a_Wait+11p

var_1A		= word ptr -1Ah
lineIdx		= word ptr -18h
dataOfs		= word ptr -16h
relPosX		= word ptr -14h
relPosY		= word ptr -12h
basePosY	= word ptr -10h
basePosX	= word ptr -0Eh
buffer		= byte ptr -0Ch
bufLen		= word ptr -2
arg_textData	= word ptr  4

		push	bp
		mov	bp, sp
		mov	ax, 1Ah
		call	__chkstk
		push	si
		mov	[bp+dataOfs], 0
		mov	[bp+bufLen], 0
		mov	[bp+relPosX], 0
		mov	[bp+relPosY], 1
		mov	[bp+lineIdx], 1
		mov	[bp+var_1A], 0
		mov	ax, TextBoxes.baseX+12h
		mov	[bp+basePosX], ax
		mov	ax, TextBoxes.txSzY+12h
		imul	TextBoxes.txPosY+12h
		add	ax, TextBoxes.baseY+12h
		mov	[bp+basePosY], ax
		push	ax
		push	[bp+basePosX]
		call	SetTextDrawPos
		add	sp, 4

loc_16CD2:				; CODE XREF: DrawText_Tb1a:loc_16D97j
		mov	ax, [bp+bufLen]
		add	[bp+dataOfs], ax
		mov	bx, [bp+dataOfs]
		mov	si, [bp+arg_textData]
		cmp	byte ptr [bx+si], 0
		jnz	short loc_16CE6
		jmp	loc_16D9A
; ---------------------------------------------------------------------------

loc_16CE6:				; CODE XREF: DrawText_Tb1a+55j
		mov	si, bx
		add	si, [bp+arg_textData]
		mov	al, [si]
		mov	[bp+buffer], al
		mov	al, [si+1]
		mov	[bp+buffer+1], al
		cmp	[bp+buffer], 80h
		jb	short loc_16D0D	; 00..7F -> single-byte	character
		cmp	[bp+buffer], 0EBh
		jnb	short loc_16D0D	; EB..FF -> single-byte	character
		mov	[bp+buffer+2], 0 ; 80..EA -> double-byte character
		mov	[bp+bufLen], 2
		jmp	short loc_16D16
; ---------------------------------------------------------------------------

loc_16D0D:				; CODE XREF: DrawText_Tb1a+6Ej
					; DrawText_Tb1a+74j
		mov	[bp+buffer+1], 0
		mov	[bp+bufLen], 1

loc_16D16:				; CODE XREF: DrawText_Tb1a+7Fj
		cmp	[bp+relPosX], 7
		jnz	short loc_16D7D
		cmp	[bp+lineIdx], 7
		jnz	short loc_16D31
		mov	ax, 1
		push	ax
		call	WaitForInput
		add	sp, 2
		mov	[bp+lineIdx], 1

loc_16D31:				; CODE XREF: DrawText_Tb1a+94j
		mov	[bp+relPosX], 0
		mov	ax, TextBoxes.sizeY+12h
		dec	ax
		cmp	ax, TextBoxes.txPosY+12h
		jz	short loc_16D61
		inc	[bp+relPosY]
		inc	[bp+lineIdx]
		inc	TextBoxes.txPosY+12h
		mov	ax, word_1B1E0
		add	ax, 10h
		add	[bp+basePosY], ax
		push	[bp+basePosY]
		push	[bp+basePosX]
		call	SetTextDrawPos
		add	sp, 4
		jmp	short loc_16D7D
; ---------------------------------------------------------------------------

loc_16D61:				; CODE XREF: DrawText_Tb1a+B2j
		mov	ax, 1
		push	ax
		call	ClearTextBox
		add	sp, 2
		mov	TextBoxes.txPosX+12h, 0
		push	[bp+basePosY]
		push	[bp+basePosX]
		call	SetTextDrawPos
		add	sp, 4

loc_16D7D:				; CODE XREF: DrawText_Tb1a+8Ej
					; DrawText_Tb1a+D3j
		cmp	[bp+buffer+1], 0
		jz	short loc_16D97
		lea	ax, [bp+buffer]
		push	ax
		call	DrawString_Wait
		add	sp, 2
		inc	[bp+relPosX]
		inc	TextBoxes.txPosX+12h
		inc	[bp+var_1A]

loc_16D97:				; CODE XREF: DrawText_Tb1a+F5j
		jmp	loc_16CD2
; ---------------------------------------------------------------------------

loc_16D9A:				; CODE XREF: DrawText_Tb1a+57j
		mov	TextBoxes.txPosX+12h, 0
		mov	ax, [bp+var_1A]
		add	ax, 6
		cwd
		mov	cx, 7
		idiv	cx
		mov	[bp+relPosY], ax ; number of lines = (number of	characters + 6)	/ 7
		jmp	short $+2
		pop	si		; return number	of lines in register AX
		mov	sp, bp
		pop	bp
		retn
DrawText_Tb1a	endp


; =============== S U B	R O U T	I N E =======================================

; used to draw the text	box border around selections
; Attributes: bp-based frame

DrawTBoxBorder	proc near		; CODE XREF: sub_11296+DFp
					; sub_11296+103p ...

var_6		= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2
arg_numLines	= word ptr  4
arg_2		= word ptr  6
arg_4		= word ptr  8
arg_tBoxID	= word ptr  0Ah

		push	bp
		mov	bp, sp
		mov	ax, 6
		call	__chkstk
		push	di
		push	si
		mov	[bp+var_6], 2
		cmp	[bp+arg_4], 0
		jz	short loc_16DD3
		mov	[bp+var_2], 6
		jmp	short loc_16DD8
; ---------------------------------------------------------------------------

loc_16DD3:				; CODE XREF: DrawTBoxBorder+14j
		mov	[bp+var_2], 0

loc_16DD8:				; CODE XREF: DrawTBoxBorder+1Bj
		mov	ax, 18
		imul	[bp+arg_2]
		sub	ax, 18
		mov	[bp+var_4], ax
		mov	ax, 1
		push	ax
		call	SetGDCPlane_Wrt
		add	sp, 2
		mov	ax, 12h
		imul	[bp+arg_tBoxID]
		mov	si, ax
		mov	ax, 18
		imul	[bp+arg_numLines]
		mov	di, ax
		add	di, TextBoxes.baseY[si]
		sub	ax, ax
		push	ax
		push	[bp+var_2]
		mov	ax, [bp+var_4]
		add	ax, di
		add	ax, 17
		push	ax
		mov	ax, 18
		imul	TextBoxes.sizeX[si]
		add	ax, word ptr TextBoxes.baseX[si]
		push	ax
		lea	ax, [di-1]
		push	ax
		mov	ax, word ptr TextBoxes.baseX[si]
		sub	ax, [bp+var_6]
		push	ax
		call	DrawBox
		add	sp, 0Ch
		sub	ax, ax
		push	ax
		call	SetGDCPlane_Wrt
		add	sp, 2
		mov	ax, 12h
		imul	[bp+arg_tBoxID]
		mov	si, ax
		mov	ax, 18
		imul	[bp+arg_numLines]
		mov	di, ax
		add	di, TextBoxes.baseY[si]
		sub	ax, ax
		push	ax
		push	[bp+var_2]
		mov	ax, [bp+var_4]
		add	ax, di
		add	ax, 17
		push	ax
		mov	ax, 18
		imul	TextBoxes.sizeX[si]
		add	ax, word ptr TextBoxes.baseX[si]
		push	ax
		lea	ax, [di-1]
		push	ax
		mov	ax, word ptr TextBoxes.baseX[si]
		sub	ax, [bp+var_6]
		push	ax
		call	DrawBox
		add	sp, 0Ch
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retn
DrawTBoxBorder	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

CopyVRAMBox	proc near		; CODE XREF: TBoxBuf_Scr2Buf+70p
					; sub_178F7+8Bp ...

var_8		= word ptr -8
var_6		= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2
destPtrSeg	= dword	ptr  4
sourcePtrSeg	= dword	ptr  8
arg_8		= word ptr  0Ch
arg_A		= word ptr  0Eh

		push	bp
		mov	bp, sp
		mov	ax, 8
		call	__chkstk
		push	si
		mov	[bp+var_6], 0
		mov	[bp+var_4], 0
		jmp	short loc_16E98
; ---------------------------------------------------------------------------

loc_16E95:				; CODE XREF: CopyVRAMBox:loc_16F02j
		inc	[bp+var_4]

loc_16E98:				; CODE XREF: CopyVRAMBox+14j
		mov	ax, [bp+arg_A]
		cmp	[bp+var_4], ax
		jge	short loc_16F04
		mov	ax, [bp+var_4]
		cwd
		mov	cx, 12h
		idiv	cx
		or	dx, dx
		jnz	short loc_16ED1
		mov	[bp+var_8], 0
		jmp	short loc_16EB7
; ---------------------------------------------------------------------------

loc_16EB4:				; CODE XREF: CopyVRAMBox+50j
		inc	[bp+var_8]

loc_16EB7:				; CODE XREF: CopyVRAMBox+33j
		mov	ax, 12h
		imul	[bp+arg_8]
		cmp	ax, [bp+var_8]
		jle	short loc_16ED1
		mov	bx, [bp+var_6]
		inc	[bp+var_6]
		les	si, [bp+destPtrSeg]
		mov	byte ptr es:[bx+si], 0
		jmp	short loc_16EB4
; ---------------------------------------------------------------------------

loc_16ED1:				; CODE XREF: CopyVRAMBox+2Cj
					; CopyVRAMBox+41j
		mov	[bp+var_2], 0
		jmp	short loc_16EDB
; ---------------------------------------------------------------------------

loc_16ED8:				; CODE XREF: CopyVRAMBox+81j
		inc	[bp+var_2]

loc_16EDB:				; CODE XREF: CopyVRAMBox+57j
		mov	ax, [bp+arg_8]
		cmp	[bp+var_2], ax
		jge	short loc_16F02
		mov	ax, 50h
		imul	[bp+var_4]
		mov	bx, ax
		add	bx, [bp+var_2]
		les	si, [bp+sourcePtrSeg]
		mov	al, es:[bx+si]
		mov	bx, [bp+var_6]
		inc	[bp+var_6]
		les	si, [bp+destPtrSeg]
		mov	es:[bx+si], al
		jmp	short loc_16ED8
; ---------------------------------------------------------------------------

loc_16F02:				; CODE XREF: CopyVRAMBox+62j
		jmp	short loc_16E95
; ---------------------------------------------------------------------------

loc_16F04:				; CODE XREF: CopyVRAMBox+1Fj
		pop	si
		mov	sp, bp
		pop	bp
		retn
CopyVRAMBox	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

CopyTextBuffer2	proc near		; CODE XREF: TBoxBuf_Buf2Scr+93p
					; TBoxBuf_Buf2Scr+CAp ...

var_6		= word ptr -6
arg_destPtr	= word ptr  4
arg_destSeg	= word ptr  6
arg_4		= word ptr  8
arg_sourceSeg	= word ptr  0Ah
arg_lineSize	= word ptr  0Ch
arg_bufSize	= word ptr  0Eh
arg_C		= word ptr  10h

		push	bp
		mov	bp, sp
		mov	ax, 8
		call	__chkstk
		mov	[bp+var_6], 0
		mov	ax, 18
		sub	ax, [bp+arg_C]
		imul	[bp+arg_lineSize]
		mov	[bp+var_6], ax
		mov	ax, 18
		imul	[bp+arg_lineSize]
		push	ax
		mov	ax, [bp+arg_bufSize]
		cwd
		mov	cx, 18
		idiv	cx
		push	ax		; number of lines
		push	[bp+arg_lineSize]
		mov	ax, [bp+var_6]
		add	ax, [bp+arg_4]
		mov	dx, [bp+arg_sourceSeg]
		push	dx		; sourceSeg
		push	ax		; sourcePtr
		push	[bp+arg_destSeg]
		push	[bp+arg_destPtr]
		call	CopyTextBuffer
		add	sp, 0Eh
		mov	sp, bp
		pop	bp
		retn
CopyTextBuffer2	endp


; =============== S U B	R O U T	I N E =======================================

; text box copy: VRAM -> local buffer
; Attributes: bp-based frame

TBoxBuf_Scr2Buf	proc near		; CODE XREF: sub_11296+94p
					; ShowLocationName+39p	...

var_6		= word ptr -6
var_4		= word ptr -4
vramOfs		= word ptr -2
arg_tBoxID	= word ptr  4

		push	bp
		mov	bp, sp
		mov	ax, 8
		call	__chkstk
		push	si
		mov	ax, 12h
		imul	[bp+arg_tBoxID]
		mov	si, ax
		mov	ax, 50h
		imul	TextBoxes.baseY[si]
		mov	cx, ax
		mov	ax, word ptr TextBoxes.baseX[si]
		mov	bx, cx
		cwd
		xor	ax, dx
		sub	ax, dx
		mov	cx, 3
		sar	ax, cl
		xor	ax, dx
		sub	ax, dx
		add	ax, bx
		mov	[bp+vramOfs], ax
		mov	ax, 18
		imul	TextBoxes.sizeX[si]
		cwd
		xor	ax, dx
		sub	ax, dx
		sar	ax, cl
		xor	ax, dx
		sub	ax, dx
		add	ax, 2
		mov	[bp+var_4], ax
		mov	ax, 18
		imul	TextBoxes.sizeY[si]
		mov	[bp+var_6], ax
		push	ax		; push number of lines
		push	[bp+var_4]	; push number of bytes per line
		mov	ax, 0E000h
		push	ax		; VRAM segment
		push	[bp+vramOfs]	; VRAM pointer (source)
		mov	bx, [bp+arg_tBoxID]
		shl	bx, 1
		shl	bx, 1
		push	word ptr (tBoxBufferPtrs+2)[bx]	; destination segment
		push	word ptr tBoxBufferPtrs[bx] ; destination pointer
		call	CopyVRAMBox
		add	sp, 0Ch
		pop	si
		mov	sp, bp
		pop	bp
		retn
TBoxBuf_Scr2Buf	endp


; =============== S U B	R O U T	I N E =======================================

; text box copy: local buffer -> VRAM
; Attributes: bp-based frame

TBoxBuf_Buf2Scr	proc near		; CODE XREF: sub_17C81+1Bp
					; sub_17C81+24p ...

var_6		= word ptr -6
var_4		= word ptr -4
vramOfs		= word ptr -2
arg_tBoxID	= word ptr  4

		push	bp
		mov	bp, sp
		mov	ax, 8
		call	__chkstk
		push	si
		mov	ax, 12h
		imul	[bp+arg_tBoxID]
		mov	si, ax
		mov	ax, 50h
		imul	TextBoxes.baseY[si]
		mov	cx, ax
		mov	ax, word ptr TextBoxes.baseX[si]
		mov	bx, cx
		cwd
		xor	ax, dx
		sub	ax, dx
		mov	cx, 3
		sar	ax, cl
		xor	ax, dx
		sub	ax, dx
		add	ax, bx
		mov	[bp+vramOfs], ax
		mov	ax, 18
		imul	TextBoxes.sizeX[si]
		cwd
		xor	ax, dx
		sub	ax, dx
		sar	ax, cl
		xor	ax, dx
		sub	ax, dx
		add	ax, 2
		mov	[bp+var_4], ax
		mov	ax, 18
		imul	TextBoxes.sizeY[si]
		mov	[bp+var_6], ax
		cmp	TextBoxes.field_10[si],	0
		jz	short loc_1709D
		dec	TextBoxes.field_10[si]
		mov	ax, 1
		push	ax
		call	SetGDCPlane_Wrt
		add	sp, 2
		mov	ax, 12h
		imul	[bp+arg_tBoxID]
		mov	bx, ax
		push	TextBoxes.field_10[bx]
		push	[bp+var_6]
		push	[bp+var_4]
		mov	bx, [bp+arg_tBoxID]
		shl	bx, 1
		shl	bx, 1
		push	word ptr (tBoxBufferPtrs+2)[bx]
		push	word ptr tBoxBufferPtrs[bx]
		mov	ax, 0E000h
		push	ax
		push	[bp+vramOfs]
		call	CopyTextBuffer2
		add	sp, 0Eh
		sub	ax, ax
		push	ax
		call	SetGDCPlane_Wrt
		add	sp, 2
		mov	ax, 12h
		imul	[bp+arg_tBoxID]
		mov	bx, ax
		push	TextBoxes.field_10[bx]
		push	[bp+var_6]
		push	[bp+var_4]
		mov	bx, [bp+arg_tBoxID]
		shl	bx, 1
		shl	bx, 1
		push	word ptr (tBoxBufferPtrs+2)[bx]	; source segment
		push	word ptr tBoxBufferPtrs[bx] ; source pointer
		mov	ax, 0E000h
		push	ax		; VRAM segment
		push	[bp+vramOfs]	; VRAM pointer (destination)
		call	CopyTextBuffer2
		add	sp, 0Eh

loc_1709D:				; CODE XREF: TBoxBuf_Buf2Scr+5Bj
		pop	si
		mov	sp, bp
		pop	bp
		retn
TBoxBuf_Buf2Scr	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

DrawText_TB1a_Wait proc	near		; CODE XREF: ExecuteScript+232p

arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		xor	ax, ax
		call	__chkstk
		mov	TextBoxes.txPosY+12h, 0
		push	[bp+arg_0]
		call	DrawText_Tb1a
		add	sp, 2
		mov	ax, 1
		push	ax
		call	WaitForInput
		add	sp, 2
		mov	ax, 1
		push	ax
		call	ScrollTextOutUp
		add	sp, 2
		mov	sp, bp
		pop	bp
		retn
DrawText_TB1a_Wait endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

DrawText_Tb1b	proc near		; CODE XREF: ExecuteScript+25Bp

var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		mov	ax, 4
		call	__chkstk
		mov	[bp+var_2], 12h
		mov	ax, 50h
		imul	TextBoxes.baseY+12h
		mov	cx, ax
		mov	ax, TextBoxes.baseX+12h
		mov	bx, cx
		cwd
		xor	ax, dx
		sub	ax, dx
		mov	cx, 3
		sar	ax, cl
		xor	ax, dx
		sub	ax, dx
		add	ax, bx
		mov	[bp+var_4], ax
		mov	TextBoxes.txPosY+12h, 0
		mov	TextBoxes.txPosX+12h, 0
		mov	ax, 1
		push	ax
		call	SetGDCPlane_Wrt
		add	sp, 2
		sub	ax, ax
		push	ax
		mov	ax, 7Eh
		push	ax
		push	[bp+var_2]
		push	[bp+var_4]
		call	sub_16623
		add	sp, 8
		mov	ax, 1
		push	ax
		push	[bp+arg_0]
		call	DrawText_TbNa
		add	sp, 4
		mov	ax, 1
		push	ax
		call	TBoxBuf_Scr2Buf
		add	sp, 2
		sub	ax, ax
		push	ax
		mov	ax, 7Eh
		push	ax
		push	[bp+var_2]
		push	[bp+var_4]
		call	sub_16623
		add	sp, 8
		sub	ax, ax
		push	ax
		call	SetGDCPlane_Wrt
		add	sp, 2
		mov	TextBoxes.field_10+12h,	12h
		mov	sp, bp
		pop	bp
		retn
DrawText_Tb1b	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_17166	proc near		; CODE XREF: sub_11D81+47p

var_4		= word ptr -4
var_2		= word ptr -2

		push	bp
		mov	bp, sp
		mov	ax, 4
		call	__chkstk
		mov	[bp+var_2], 12h
		mov	ax, 50h	; 'P'
		imul	TextBoxes.baseY+12h
		mov	cx, ax
		mov	ax, TextBoxes.baseX+12h
		mov	bx, cx
		cwd
		xor	ax, dx
		sub	ax, dx
		mov	cx, 3
		sar	ax, cl
		xor	ax, dx
		sub	ax, dx
		add	ax, bx
		mov	[bp+var_4], ax
		mov	ax, 1
		push	ax
		call	SetGDCPlane_Wrt
		add	sp, 2
		sub	ax, ax
		push	ax
		mov	ax, 80h	; '€'
		push	ax
		push	[bp+var_2]
		push	[bp+var_4]
		call	sub_166A7
		add	sp, 8
		sub	ax, ax
		push	ax
		call	SetGDCPlane_Wrt
		add	sp, 2
		sub	ax, ax
		push	ax
		mov	ax, 80h	; '€'
		push	ax
		push	[bp+var_2]
		push	[bp+var_4]
		call	sub_166A7
		add	sp, 8
		mov	TextBoxes.field_10+12h,	0
		mov	sp, bp
		pop	bp
		retn
sub_17166	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

DrawTextS_Pos	proc near		; CODE XREF: sub_11296+84p
					; ShowLocationName+30p	...

arg_0		= word ptr  4
arg_2		= word ptr  6
arg_4		= word ptr  8

		push	bp
		mov	bp, sp
		xor	ax, ax
		call	__chkstk
		push	si
		mov	ax, 12h
		imul	[bp+arg_4]
		mov	si, ax
		mov	ax, [bp+arg_0]
		mov	TextBoxes.txPosY[si], ax
		mov	TextBoxes.txPosX[si], 0
		push	[bp+arg_4]
		push	[bp+arg_2]
		call	DrawText_TbNa
		add	sp, 4
		jmp	short $+2
		pop	si
		mov	sp, bp
		pop	bp
		retn
DrawTextS_Pos	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

DrawTextF_Opts	proc near		; CODE XREF: ExecuteScript+8B7p
					; ExecuteScript+8EBp

arg_0		= word ptr  4
arg_2		= word ptr  6
arg_4		= word ptr  8

		push	bp
		mov	bp, sp
		xor	ax, ax
		call	__chkstk
		cmp	debugMode, 0
		jz	short loc_1722B
		push	[bp+arg_4]
		push	[bp+arg_2]
		push	[bp+arg_0]
		mov	ax, offset aAm2d2dS ; "Am(%2d,%2d,%s)"
		push	ax		; char *
		call	_printf
		add	sp, 8

loc_1722B:				; CODE XREF: DrawTextF_Opts+Dj
		mov	ax, 2
		push	ax
		mov	ax, 10h
		push	ax
		mov	ax, 8
		push	ax
		call	SetTextOpts
		add	sp, 6
		sub	ax, ax
		push	ax
		call	SetGDCPlane_Wrt
		add	sp, 2
		mov	ax, [bp+arg_0]
		mov	TextBoxes.txPosX+6Ch, ax ; set TextBoxInfo[6][0Ch]
		mov	ax, [bp+arg_2]
		mov	TextBoxes.txPosY+6Ch, ax ; set TextBoxInfo[6][0Eh]
		mov	ax, 6
		push	ax
		push	[bp+arg_4]
		call	DrawText_TbNb
		add	sp, 4
		mov	sp, bp
		pop	bp
		retn
DrawTextF_Opts	endp


; =============== S U B	R O U T	I N E =======================================

; Used to draw:
; - the	location title
; - menu selections
; Attributes: bp-based frame

DrawText_TbNa	proc near		; CODE XREF: DrawText_Tb1b+5Fp
					; DrawTextS_Pos+24p ...

var_18		= word ptr -18h
dataOfs		= word ptr -16h
relPosX		= word ptr -14h
relPosY		= word ptr -12h
basePosY	= word ptr -10h
basePosX	= word ptr -0Eh
buffer		= byte ptr -0Ch
bufLen		= word ptr -2
arg_textData	= word ptr  4
arg_tBoxID	= word ptr  6

		push	bp
		mov	bp, sp
		mov	ax, 18h
		call	__chkstk
		push	si
		mov	[bp+dataOfs], 0
		mov	[bp+bufLen], 0
		mov	[bp+relPosX], 0
		mov	[bp+relPosY], 1
		mov	[bp+var_18], 0
		mov	ax, 12h
		imul	[bp+arg_tBoxID]
		mov	si, ax
		mov	ax, TextBoxes.txSzX[si]
		imul	TextBoxes.txPosX[si]
		add	ax, word ptr TextBoxes.baseX[si]
		mov	[bp+basePosX], ax
		mov	ax, TextBoxes.txSzY[si]
		imul	TextBoxes.txPosY[si]
		add	ax, TextBoxes.baseY[si]
		mov	[bp+basePosY], ax
		push	ax
		push	[bp+basePosX]
		call	SetTextDrawPos
		add	sp, 4

loc_172B6:				; CODE XREF: DrawText_TbNa:loc_1737Ej
		mov	ax, [bp+bufLen]
		add	[bp+dataOfs], ax
		mov	bx, [bp+dataOfs]
		mov	si, [bp+arg_textData]
		cmp	byte ptr [bx+si], 0
		jnz	short loc_172CA
		jmp	loc_17381
; ---------------------------------------------------------------------------

loc_172CA:				; CODE XREF: DrawText_TbNa+62j
		mov	si, bx
		add	si, [bp+arg_textData]
		mov	al, [si]
		mov	[bp+buffer], al
		mov	al, [si+1]
		mov	[bp+buffer+1], al
		cmp	[bp+buffer], 80h
		jb	short loc_172F1	; 00..7F -> single-byte	character
		cmp	[bp+buffer], 0EBh
		jnb	short loc_172F1	; EB..FF -> single-byte	character
		mov	[bp+buffer+2], 0 ; 80..EA -> double-byte character
		mov	[bp+bufLen], 2
		jmp	short loc_172FA
; ---------------------------------------------------------------------------

loc_172F1:				; CODE XREF: DrawText_TbNa+7Bj
					; DrawText_TbNa+81j
		mov	[bp+buffer+1], 0
		mov	[bp+bufLen], 1

loc_172FA:				; CODE XREF: DrawText_TbNa+8Cj
		cmp	[bp+buffer+1], 0
		jz	short loc_1731C
		lea	ax, [bp+buffer]
		push	ax
		call	j_DrawString
		add	sp, 2
		inc	[bp+relPosX]
		mov	ax, 12h
		imul	[bp+arg_tBoxID]
		mov	bx, ax
		inc	TextBoxes.txPosX[bx]
		inc	[bp+var_18]

loc_1731C:				; CODE XREF: DrawText_TbNa+9Bj
		mov	ax, 12h
		imul	[bp+arg_tBoxID]
		mov	si, ax		; si = text box	pointer
		mov	ax, [bp+relPosX]
		cmp	TextBoxes.sizeX[si], ax	; relPosX == text box size X?
		jnz	short loc_1737E	; no - skip
		mov	[bp+relPosX], 0	; do line break	- reset	X position
		mov	ax, TextBoxes.sizeY[si]
		dec	ax
		cmp	ax, TextBoxes.txPosY[si] ; relPosY == text box size Y?
		jz	short loc_1735B	; yes -	jump to	handle box end
		inc	[bp+relPosY]	; else go to next line
		inc	TextBoxes.txPosY[si]
		mov	ax, word_1B1E0
		add	ax, 10h
		add	[bp+basePosY], ax
		push	[bp+basePosY]
		push	[bp+basePosX]
		call	SetTextDrawPos
		add	sp, 4
		jmp	short loc_1737E
; ---------------------------------------------------------------------------

loc_1735B:				; CODE XREF: DrawText_TbNa+D8j
		push	[bp+arg_tBoxID]
		call	ClearTextBox
		add	sp, 2
		mov	ax, 12h
		imul	[bp+arg_tBoxID]
		mov	bx, ax
		mov	TextBoxes.txPosX[bx], 0
		push	[bp+basePosY]
		push	[bp+basePosX]
		call	SetTextDrawPos
		add	sp, 4

loc_1737E:				; CODE XREF: DrawText_TbNa+C8j
					; DrawText_TbNa+F6j
		jmp	loc_172B6
; ---------------------------------------------------------------------------

loc_17381:				; CODE XREF: DrawText_TbNa+64j
		mov	ax, 12h
		imul	[bp+arg_tBoxID]
		mov	bx, ax
		cmp	TextBoxes.txPosX[bx], 0
		jnz	short loc_17393
		dec	[bp+relPosY]

loc_17393:				; CODE XREF: DrawText_TbNa+12Bj
		mov	ax, 12h
		imul	[bp+arg_tBoxID]
		mov	si, ax
		mov	ax, TextBoxes.sizeY[si]
		dec	ax
		cmp	ax, TextBoxes.txPosY[si]
		jz	short loc_173C1
		inc	TextBoxes.txPosY[si]
		mov	ax, word_1B1E0
		add	ax, 10h
		add	[bp+basePosY], ax
		push	[bp+basePosY]
		push	[bp+basePosX]
		call	SetTextDrawPos
		add	sp, 4
		jmp	short loc_173E4
; ---------------------------------------------------------------------------

loc_173C1:				; CODE XREF: DrawText_TbNa+141j
		push	[bp+arg_tBoxID]
		call	ClearTextBox
		add	sp, 2
		mov	ax, 12h
		imul	[bp+arg_tBoxID]
		mov	bx, ax
		mov	TextBoxes.txPosX[bx], 0
		push	[bp+basePosY]
		push	[bp+basePosX]
		call	SetTextDrawPos
		add	sp, 4

loc_173E4:				; CODE XREF: DrawText_TbNa+15Cj
		mov	ax, 12h
		imul	[bp+arg_tBoxID]
		mov	bx, ax
		mov	TextBoxes.txPosX[bx], 0
		mov	ax, [bp+var_18]
		add	ax, 6
		cwd
		mov	cx, 7
		idiv	cx
		mov	[bp+relPosY], ax ; number of lines = (number of	characters + 6)	/ 7
		jmp	short $+2
		pop	si		; return number	of lines in register AX
		mov	sp, bp		; (important for drawing menu selection	rectangles)
		pop	bp
		retn
DrawText_TbNa	endp ; sp-analysis failed


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

DrawText_TbNb	proc near		; CODE XREF: DrawTextF_Opts+50p
					; sub_17A0B+138p ...

var_18		= word ptr -18h
dataOfs		= word ptr -16h
relPosX		= word ptr -14h
relPosY		= word ptr -12h
basePosY	= word ptr -10h
basePosX	= word ptr -0Eh
var_C		= byte ptr -0Ch
bufLen		= word ptr -2
arg_0		= word ptr  4
arg_tBoxID	= word ptr  6

		push	bp
		mov	bp, sp
		mov	ax, 18h
		call	__chkstk
		push	si
		mov	[bp+dataOfs], 0
		mov	[bp+bufLen], 0
		mov	[bp+relPosX], 0
		mov	[bp+relPosY], 1
		mov	[bp+var_18], 0
		mov	ax, 12h
		imul	[bp+arg_tBoxID]
		mov	si, ax
		mov	ax, TextBoxes.txSzX[si]
		imul	TextBoxes.txPosX[si]
		add	ax, word ptr TextBoxes.baseX[si]
		mov	[bp+basePosX], ax
		mov	ax, TextBoxes.txSzY[si]
		imul	TextBoxes.txPosY[si]
		add	ax, TextBoxes.baseY[si]
		mov	[bp+basePosY], ax
		push	ax
		push	[bp+basePosX]
		call	SetTextDrawPos
		add	sp, 4
		cmp	[bp+var_C], 0
		jz	short loc_1746A
		push	[bp+arg_0]	; text data pointer
		call	j_DrawString
		add	sp, 2

loc_1746A:				; CODE XREF: DrawText_TbNb+57j
		pop	si
		mov	sp, bp
		pop	bp
		retn
DrawText_TbNb	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

ScrollTextOutUp	proc near		; CODE XREF: sub_10A4B+20Fp
					; sub_11296+185p ...

var_A		= word ptr -0Ah
var_8		= word ptr -8
var_6		= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		mov	ax, 0Ah
		call	__chkstk
		push	si
		mov	ax, 12h
		imul	[bp+arg_0]
		mov	si, ax
		mov	ax, 50h
		imul	TextBoxes.baseY[si]
		mov	cx, ax
		mov	ax, word ptr TextBoxes.baseX[si]
		mov	bx, cx
		cwd
		xor	ax, dx
		sub	ax, dx
		mov	cx, 3
		sar	ax, cl
		xor	ax, dx
		sub	ax, dx
		add	ax, bx
		mov	[bp+var_4], ax
		mov	ax, 12h
		imul	TextBoxes.sizeX[si]
		cwd
		xor	ax, dx
		sub	ax, dx
		sar	ax, cl
		xor	ax, dx
		sub	ax, dx
		add	ax, 2
		mov	[bp+var_6], ax
		mov	ax, 12h
		imul	TextBoxes.sizeY[si]
		mov	[bp+var_8], ax
		mov	ax, TextBoxes.sizeX[si]
		mov	[bp+var_2], ax
		mov	[bp+var_A], 0
		jmp	short loc_174D6
; ---------------------------------------------------------------------------

loc_174D3:				; CODE XREF: ScrollTextOutUp+D2j
		inc	[bp+var_A]	; increment line counter

loc_174D6:				; CODE XREF: ScrollTextOutUp+62j
		cmp	[bp+var_A], 12h	; up to	18 lines
		jge	short loc_17543
		mov	ax, 1		; Scroll text up by 1 pixel row, but remove the	uppermost row.
		push	ax		; Repeat this for every	text line.
		call	SetGDCPlane_Wrt	; This results in a neat "scroll lines out" effect.
		add	sp, 2
		mov	ax, 550h
		push	ax
		push	[bp+var_2]
		push	[bp+var_6]
		push	[bp+var_4]
		call	sub_16623
		add	sp, 8
		push	[bp+var_8]
		push	[bp+var_6]
		mov	ax, [bp+var_4]
		add	ax, 50h
		push	ax
		push	[bp+var_4]
		call	sub_16655
		add	sp, 8
		sub	ax, ax
		push	ax
		call	SetGDCPlane_Wrt
		add	sp, 2
		mov	ax, 550h
		push	ax
		push	[bp+var_2]
		push	[bp+var_6]
		push	[bp+var_4]
		call	sub_16623
		add	sp, 8
		push	[bp+var_8]
		push	[bp+var_6]
		mov	ax, [bp+var_4]
		add	ax, 50h
		push	ax
		push	[bp+var_4]
		call	sub_16655
		add	sp, 8
		jmp	short loc_174D3
; ---------------------------------------------------------------------------

loc_17543:				; CODE XREF: ScrollTextOutUp+6Bj
		mov	ax, 12h
		imul	[bp+arg_0]
		mov	bx, ax
		mov	TextBoxes.field_10[bx],	0
		pop	si
		mov	sp, bp
		pop	bp
		retn
ScrollTextOutUp	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_17556	proc near		; CODE XREF: sub_17673+51p
					; sub_17673+5Dp ...

var_8		= word ptr -8
var_6		= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		mov	ax, 0Ah
		call	__chkstk
		push	si
		mov	bx, [bp+arg_0]
		shl	bx, 1
		cmp	word_1C542[bx],	0
		jnz	short loc_1756F
		jmp	loc_1760B
; ---------------------------------------------------------------------------

loc_1756F:				; CODE XREF: sub_17556+14j
		mov	ax, 12h
		imul	[bp+arg_0]
		mov	si, ax
		mov	ax, 50h
		imul	TextBoxes.baseY[si]
		mov	cx, ax
		mov	ax, word ptr TextBoxes.baseX[si]
		mov	bx, cx
		cwd
		xor	ax, dx
		sub	ax, dx
		mov	cx, 3
		sar	ax, cl
		xor	ax, dx
		sub	ax, dx
		add	ax, bx
		mov	[bp+var_4], ax
		mov	ax, 12h
		imul	TextBoxes.sizeX[si]
		cwd
		xor	ax, dx
		sub	ax, dx
		sar	ax, cl
		xor	ax, dx
		sub	ax, dx
		add	ax, 2
		mov	[bp+var_6], ax
		mov	ax, 12h
		imul	TextBoxes.sizeY[si]
		mov	[bp+var_8], ax
		mov	ax, TextBoxes.sizeX[si]
		mov	[bp+var_2], ax
		sub	ax, ax
		push	ax
		call	SetGDCPlane_Wrt
		add	sp, 2
		mov	ax, 550h
		push	ax
		push	[bp+var_2]
		push	[bp+var_6]
		push	[bp+var_4]
		call	sub_16623
		add	sp, 8
		push	[bp+var_8]
		push	[bp+var_6]
		mov	ax, [bp+var_4]
		add	ax, 50h
		push	ax
		push	[bp+var_4]
		call	sub_16655
		add	sp, 8
		mov	ax, 12h
		imul	[bp+arg_0]
		mov	bx, ax
		mov	TextBoxes.field_10[bx],	0
		mov	bx, [bp+arg_0]
		shl	bx, 1
		dec	word_1C542[bx]

loc_1760B:				; CODE XREF: sub_17556+16j
		pop	si
		mov	sp, bp
		pop	bp
		retn
sub_17556	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_17610	proc near		; CODE XREF: ExecuteScript:loc_1296Bp

var_C		= word ptr -0Ch
var_A		= word ptr -0Ah
var_4		= word ptr -4

		push	bp
		mov	bp, sp
		mov	ax, 0Ch
		call	__chkstk
		mov	[bp+var_C], 1
		sub	ax, ax
		push	ax
		call	SetGDCPlane_Wrt
		add	sp, 2
		mov	[bp+var_A], 0
		jmp	short loc_17631
; ---------------------------------------------------------------------------

loc_1762E:				; CODE XREF: sub_17610+5Dj
		inc	[bp+var_A]

loc_17631:				; CODE XREF: sub_17610+1Cj
		mov	ax, 12h
		cwd
		mov	cx, [bp+var_C]
		idiv	cx
		cmp	ax, [bp+var_A]
		jle	short loc_1766F
		mov	[bp+var_4], 0

loc_17644:				; CODE XREF: sub_17610+3Bj
		cmp	word_1B0E2, 0
		jz	short loc_1764D
		jmp	short loc_17644
; ---------------------------------------------------------------------------

loc_1764D:				; CODE XREF: sub_17610+39j
		mov	word_1B0E2, 1
		mov	ax, 3E80h
		push	ax
		mov	ax, 50h
		imul	[bp+var_C]
		add	ax, [bp+var_4]
		push	ax
		push	[bp+var_4]
		call	sub_16687
		add	sp, 6
		call	sub_13FB0
		jmp	short loc_1762E
; ---------------------------------------------------------------------------

loc_1766F:				; CODE XREF: sub_17610+2Dj
		mov	sp, bp
		pop	bp
		retn
sub_17610	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_17673	proc near		; CODE XREF: ExecuteScript+6B0p

var_2		= word ptr -2
arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		mov	ax, 2
		call	__chkstk
		push	si
		push	[bp+arg_0]
		call	sub_137E8
		add	sp, 2
		mov	word_1C544, 12h
		mov	word_1C54C, 12h
		mov	word_1C542, 12h
		mov	word_1C546, 12h
		sub	ax, ax
		push	ax
		call	sub_13D1C
		add	sp, 2
		mov	word_1AB44, 1

loc_176AD:				; CODE XREF: sub_17673+B1j
		mov	ax, 1
		push	ax
		call	sub_13D1C
		add	sp, 2
		or	ax, ax
		jz	short loc_17726
		mov	ax, [bp+var_2]
		jmp	short loc_176F1
; ---------------------------------------------------------------------------

loc_176C0:				; CODE XREF: sub_17673+80j
		mov	ax, 1
		push	ax
		call	sub_17556
		add	sp, 2
		jmp	short loc_17706
; ---------------------------------------------------------------------------

loc_176CC:				; CODE XREF: sub_17673+85j
		mov	ax, 5
		push	ax
		call	sub_17556
		add	sp, 2
		jmp	short loc_17706
; ---------------------------------------------------------------------------

loc_176D8:				; CODE XREF: sub_17673+8Aj
		mov	ax, 2
		push	ax
		call	sub_17556
		add	sp, 2
		jmp	short loc_17706
; ---------------------------------------------------------------------------

loc_176E4:				; CODE XREF: sub_17673+8Fj
		sub	ax, ax
		push	ax
		call	sub_17556
		add	sp, 2
		jmp	short loc_17706
; ---------------------------------------------------------------------------
		jmp	short loc_17706
; ---------------------------------------------------------------------------

loc_176F1:				; CODE XREF: sub_17673+4Bj
		or	ax, ax
		jz	short loc_176C0
		cmp	ax, 1
		jz	short loc_176CC
		cmp	ax, 2
		jz	short loc_176D8
		cmp	ax, 3
		jz	short loc_176E4
		jmp	short $+2

loc_17706:				; CODE XREF: sub_17673+57j
					; sub_17673+63j ...
		inc	[bp+var_2]
		mov	cx, 4
		mov	ax, [bp+var_2]
		cwd
		idiv	cx
		mov	[bp+var_2], dx

loc_17715:				; CODE XREF: sub_17673+A9j
		cmp	word_1AB44, 0
		jz	short loc_1771E
		jmp	short loc_17715
; ---------------------------------------------------------------------------

loc_1771E:				; CODE XREF: sub_17673+A7j
		mov	word_1AB44, 1
		jmp	short loc_176AD
; ---------------------------------------------------------------------------

loc_17726:				; CODE XREF: sub_17673+46j
		mov	ax, 1
		push	ax
		call	SetGDCPlane_Wrt
		add	sp, 2
		mov	[bp+var_2], 0
		jmp	short loc_1773A
; ---------------------------------------------------------------------------

loc_17737:				; CODE XREF: sub_17673+F5j
		inc	[bp+var_2]

loc_1773A:				; CODE XREF: sub_17673+C2j
		cmp	[bp+var_2], 7
		jge	short loc_1776A
		push	[bp+var_2]
		call	sub_17857
		add	sp, 2
		mov	bx, [bp+var_2]
		shl	bx, 1
		mov	word ptr (tBoxBufferPtrs+1Ch)[bx], 0
		mov	ax, 12h
		imul	[bp+var_2]
		mov	si, ax
		mov	TextBoxes.txPosY[si], 0
		mov	TextBoxes.txPosX[si], 0
		jmp	short loc_17737
; ---------------------------------------------------------------------------

loc_1776A:				; CODE XREF: sub_17673+CBj
		pop	si
		mov	sp, bp
		pop	bp
		retn
sub_17673	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1776F	proc near		; CODE XREF: ExecuteScript+6A5p

var_4		= word ptr -4

		push	bp
		mov	bp, sp
		mov	ax, 4
		call	__chkstk
		push	si
		mov	word_1C544, 12h
		mov	word_1C54C, 12h
		mov	word_1C542, 12h
		mov	word_1C546, 12h
		mov	word_1AB44, 1
		mov	[bp+var_4], 0

loc_1779C:				; CODE XREF: sub_1776F+9Dj
		cmp	word_1C542, 0
		jz	short loc_1780E
		mov	ax, [bp+var_4]
		jmp	short loc_177D9
; ---------------------------------------------------------------------------

loc_177A8:				; CODE XREF: sub_1776F+6Cj
		mov	ax, 1
		push	ax
		call	sub_17556
		add	sp, 2
		jmp	short loc_177EE
; ---------------------------------------------------------------------------

loc_177B4:				; CODE XREF: sub_1776F+71j
		mov	ax, 5
		push	ax
		call	sub_17556
		add	sp, 2
		jmp	short loc_177EE
; ---------------------------------------------------------------------------

loc_177C0:				; CODE XREF: sub_1776F+76j
		mov	ax, 2
		push	ax
		call	sub_17556
		add	sp, 2
		jmp	short loc_177EE
; ---------------------------------------------------------------------------

loc_177CC:				; CODE XREF: sub_1776F+7Bj
		sub	ax, ax
		push	ax
		call	sub_17556
		add	sp, 2
		jmp	short loc_177EE
; ---------------------------------------------------------------------------
		jmp	short loc_177EE
; ---------------------------------------------------------------------------

loc_177D9:				; CODE XREF: sub_1776F+37j
		or	ax, ax
		jz	short loc_177A8
		cmp	ax, 1
		jz	short loc_177B4
		cmp	ax, 2
		jz	short loc_177C0
		cmp	ax, 3
		jz	short loc_177CC
		jmp	short $+2

loc_177EE:				; CODE XREF: sub_1776F+43j
					; sub_1776F+4Fj ...
		inc	[bp+var_4]
		mov	cx, 4
		mov	ax, [bp+var_4]
		cwd
		idiv	cx
		mov	[bp+var_4], dx

loc_177FD:				; CODE XREF: sub_1776F+95j
		cmp	word_1AB44, 0
		jz	short loc_17806
		jmp	short loc_177FD
; ---------------------------------------------------------------------------

loc_17806:				; CODE XREF: sub_1776F+93j
		mov	word_1AB44, 1
		jmp	short loc_1779C
; ---------------------------------------------------------------------------

loc_1780E:				; CODE XREF: sub_1776F+32j
		mov	ax, 1
		push	ax
		call	SetGDCPlane_Wrt
		add	sp, 2
		mov	[bp+var_4], 0
		jmp	short loc_17822
; ---------------------------------------------------------------------------

loc_1781F:				; CODE XREF: sub_1776F+E1j
		inc	[bp+var_4]

loc_17822:				; CODE XREF: sub_1776F+AEj
		cmp	[bp+var_4], 7
		jge	short loc_17852
		push	[bp+var_4]
		call	sub_17857
		add	sp, 2
		mov	bx, [bp+var_4]
		shl	bx, 1
		mov	word ptr (tBoxBufferPtrs+1Ch)[bx], 0
		mov	ax, 12h
		imul	[bp+var_4]
		mov	si, ax
		mov	TextBoxes.txPosY[si], 0
		mov	TextBoxes.txPosX[si], 0
		jmp	short loc_1781F
; ---------------------------------------------------------------------------

loc_17852:				; CODE XREF: sub_1776F+B7j
		pop	si
		mov	sp, bp
		pop	bp
		retn
sub_1776F	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_17857	proc near		; CODE XREF: sub_11296+2Fp
					; ShowLocationName+16p	...

var_8		= word ptr -8
var_6		= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		mov	ax, 0Ah
		call	__chkstk
		push	si
		mov	ax, 12h
		imul	[bp+arg_0]
		mov	si, ax
		mov	ax, 50h
		imul	TextBoxes.baseY[si]
		mov	cx, ax
		mov	ax, word ptr TextBoxes.baseX[si]
		mov	bx, cx
		cwd
		xor	ax, dx
		sub	ax, dx
		mov	cx, 3
		sar	ax, cl
		xor	ax, dx
		sub	ax, dx
		add	ax, bx
		mov	[bp+var_4], ax
		mov	ax, 12h
		imul	TextBoxes.sizeX[si]
		cwd
		xor	ax, dx
		sub	ax, dx
		sar	ax, cl
		xor	ax, dx
		sub	ax, dx
		add	ax, 2
		mov	[bp+var_6], ax
		mov	ax, 12h
		imul	TextBoxes.sizeY[si]
		mov	[bp+var_8], ax
		mov	ax, TextBoxes.sizeX[si]
		mov	[bp+var_2], ax
		sub	ax, ax
		push	ax
		push	[bp+var_8]
		push	[bp+var_6]
		push	[bp+var_4]
		call	sub_16623
		add	sp, 8
		mov	ax, 12h
		imul	[bp+arg_0]
		mov	bx, ax
		mov	TextBoxes.field_10[bx],	0
		pop	si
		mov	sp, bp
		pop	bp
		retn
sub_17857	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_178D9	proc near		; CODE XREF: sub_12080:loc_12093p
		push	bp
		mov	bp, sp
		xor	ax, ax
		call	__chkstk
		call	GetHourSecs
		mov	word_1B590, ax
		mov	word_1B0E6, 1
		call	GetHour
		mov	word_1CC8E, ax
		mov	sp, bp
		pop	bp
		retn
sub_178D9	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_178F7	proc near		; CODE XREF: sub_12080:loc_12098p
					; sub_17A0B+67p

var_E		= word ptr -0Eh
var_C		= word ptr -0Ch
var_2		= word ptr -2

		push	bp
		mov	bp, sp
		mov	ax, 10h
		call	__chkstk
		mov	ax, word ptr tBoxBufferPtrs+10h
		mov	dx, word ptr tBoxBufferPtrs+12h
		mov	[bp+var_E], ax
		mov	[bp+var_C], dx
		cmp	word_1B0E6, 0
		jnz	short loc_17917
		jmp	loc_179DD
; ---------------------------------------------------------------------------

loc_17917:				; CODE XREF: sub_178F7+1Bj
		mov	ax, 1
		push	ax
		call	SetGDCPlane_Wrt
		add	sp, 2
		mov	ax, 2
		push	ax
		mov	ax, 10h
		push	ax
		sub	ax, ax
		push	ax
		call	SetTextOpts
		add	sp, 6
		mov	TextBoxes.txPosY+48h, 0
		mov	TextBoxes.txPosX+48h, 0
		mov	ax, 4
		push	ax
		mov	ax, offset byte_1B14C
		push	ax
		call	DrawText_TbNa
		add	sp, 4
		mov	ax, 50h
		imul	TextBoxes.baseY+48h
		mov	cx, ax
		mov	ax, TextBoxes.baseX+48h
		mov	bx, cx
		cwd
		xor	ax, dx
		sub	ax, dx
		mov	cx, 3
		sar	ax, cl
		xor	ax, dx
		sub	ax, dx
		add	ax, bx
		mov	[bp+var_2], ax
		mov	ax, 12h
		push	ax
		mov	ax, 14h
		push	ax
		mov	ax, 0E000h
		push	ax
		push	[bp+var_2]
		push	[bp+var_C]
		push	[bp+var_E]
		call	CopyVRAMBox
		add	sp, 0Ch
		mov	ax, 1
		push	ax
		call	SetGDCPlane_Wrt
		add	sp, 2
		sub	ax, ax
		push	ax
		mov	ax, 13h
		push	ax
		mov	ax, 14h
		push	ax
		push	[bp+var_C]
		push	[bp+var_E]
		mov	ax, 0E000h
		push	ax
		push	[bp+var_2]
		call	CopyTextBuffer2
		add	sp, 0Eh
		sub	ax, ax
		push	ax
		call	SetGDCPlane_Wrt
		add	sp, 2
		sub	ax, ax
		push	ax
		mov	ax, 13h
		push	ax
		mov	ax, 14h
		push	ax
		push	[bp+var_C]
		push	[bp+var_E]
		mov	ax, 0E000h
		push	ax
		push	[bp+var_2]
		call	CopyTextBuffer2
		add	sp, 0Eh
		mov	word_1B0E6, 0

loc_179DD:				; CODE XREF: sub_178F7+1Dj
		mov	sp, bp
		pop	bp
		retn
sub_178F7	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_179E1	proc near		; CODE XREF: sub_17A0B+94p
					; sub_17A0B+A2p ...

arg_0		= word ptr  4
arg_2		= word ptr  6

		push	bp
		mov	bp, sp
		xor	ax, ax
		call	__chkstk
		push	di
		push	si
		mov	si, [bp+arg_2]
		shl	si, 1
		mov	di, [bp+arg_0]
		shl	di, 1
		mov	al, byte_1B0E8[si]
		mov	byte_1B110[di],	al
		mov	al, (byte_1B0E8+1)[si]
		mov	(byte_1B110+1)[di], al
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retn
sub_179E1	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_17A0B	proc near		; CODE XREF: sub_17C81+3Ep

var_12		= word ptr -12h
var_10		= word ptr -10h
var_E		= word ptr -0Eh
var_C		= word ptr -0Ch
var_A		= word ptr -0Ah
var_8		= word ptr -8
var_6		= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2

		push	bp
		mov	bp, sp
		mov	ax, 12h
		call	__chkstk
		mov	ax, word ptr tBoxBufferPtrs+10h
		mov	dx, word ptr tBoxBufferPtrs+12h
		mov	[bp+var_E], ax
		mov	[bp+var_C], dx
		cmp	word_1B0E6, 0
		jnz	short loc_17A2B
		jmp	loc_17C00
; ---------------------------------------------------------------------------

loc_17A2B:				; CODE XREF: sub_17A0B+1Bj
		call	GetHourSecs
		mov	word_1B5D0, ax
		mov	ax, word_1B590
		cmp	word_1B5D0, ax
		jb	short loc_17A46
		sub	ax, word_1B5D0
		add	ax, 3600
		mov	[bp+var_6], ax
		jmp	short loc_17A50
; ---------------------------------------------------------------------------

loc_17A46:				; CODE XREF: sub_17A0B+2Dj
		mov	ax, word_1B590
		sub	ax, word_1B5D0
		mov	[bp+var_6], ax

loc_17A50:				; CODE XREF: sub_17A0B+39j
		mov	ax, word_1B1F2
		cmp	[bp+var_6], ax
		jnz	short loc_17A5B
		jmp	loc_17C00
; ---------------------------------------------------------------------------

loc_17A5B:				; CODE XREF: sub_17A0B+4Bj
		call	GetHour
		mov	[bp+var_10], ax
		mov	ax, word_1CC8E
		cmp	[bp+var_10], ax
		jz	short loc_17A7E
		mov	ax, word_1B590
		cmp	word_1B5D0, ax
		jb	short loc_17A7E
		call	sub_178F7
		mov	stopDialogDraw,	1
		jmp	loc_17C00
; ---------------------------------------------------------------------------

loc_17A7E:				; CODE XREF: sub_17A0B+5Cj
					; sub_17A0B+65j
		mov	ax, [bp+var_6]
		mov	word_1B1F2, ax
		sub	dx, dx
		mov	cx, 60
		div	cx
		sub	dx, dx
		mov	cx, 0Ah
		div	cx
		mov	[bp+var_4], ax
		or	ax, ax
		jnz	short loc_17AA7
		mov	ax, cx
		push	ax
		sub	ax, ax
		push	ax
		call	sub_179E1
		add	sp, 4
		jmp	short loc_17AB3
; ---------------------------------------------------------------------------

loc_17AA7:				; CODE XREF: sub_17A0B+8Cj
		push	[bp+var_4]
		sub	ax, ax
		push	ax
		call	sub_179E1
		add	sp, 4

loc_17AB3:				; CODE XREF: sub_17A0B+9Aj
		mov	ax, [bp+var_6]
		sub	dx, dx
		mov	cx, 60
		div	cx
		sub	dx, dx
		mov	cx, 0Ah
		div	cx
		mov	[bp+var_8], dx
		push	dx
		mov	ax, 1
		push	ax
		call	sub_179E1
		add	sp, 4
		mov	ax, [bp+var_6]
		sub	dx, dx
		mov	cx, 60
		div	cx
		mov	ax, dx
		sub	dx, dx
		mov	cx, 0Ah
		div	cx
		mov	[bp+var_A], ax
		push	ax
		mov	ax, 3
		push	ax
		call	sub_179E1
		add	sp, 4
		mov	ax, [bp+var_6]
		sub	dx, dx
		mov	cx, 60
		div	cx
		mov	ax, dx
		sub	dx, dx
		mov	cx, 0Ah
		div	cx
		mov	[bp+var_12], dx
		push	dx
		mov	ax, 4
		push	ax
		call	sub_179E1
		add	sp, 4
		mov	ax, 1
		push	ax
		call	SetGDCPlane_Wrt
		add	sp, 2
		mov	ax, 2
		push	ax
		mov	ax, 10h
		push	ax
		sub	ax, ax
		push	ax
		call	SetTextOpts
		add	sp, 6
		mov	TextBoxes.txPosY+48h, 0
		mov	TextBoxes.txPosX+48h, 0
		mov	ax, 4
		push	ax
		mov	ax, offset byte_1B14C
		push	ax
		call	DrawText_TbNb
		add	sp, 4
		mov	ax, 2
		push	ax
		mov	ax, 10h
		push	ax
		mov	ax, 8
		push	ax
		call	SetTextOpts
		add	sp, 6
		mov	TextBoxes.txPosY+48h, 0
		mov	TextBoxes.txPosX+48h, 0
		mov	ax, 4
		push	ax
		mov	ax, offset byte_1B110
		push	ax
		call	DrawText_TbNb
		add	sp, 4
		mov	ax, 50h
		imul	TextBoxes.baseY+48h
		mov	cx, ax
		mov	ax, TextBoxes.baseX+48h
		mov	bx, cx
		cwd
		xor	ax, dx
		sub	ax, dx
		mov	cx, 3
		sar	ax, cl
		xor	ax, dx
		sub	ax, dx
		add	ax, bx
		mov	[bp+var_2], ax
		mov	ax, 12h
		push	ax
		mov	ax, 14h
		push	ax
		mov	ax, 0E000h
		push	ax
		push	[bp+var_2]
		push	[bp+var_C]
		push	[bp+var_E]
		call	CopyVRAMBox
		add	sp, 0Ch
		mov	ax, 1
		push	ax
		call	SetGDCPlane_Wrt
		add	sp, 2
		sub	ax, ax
		push	ax
		mov	ax, 13h
		push	ax
		mov	ax, 14h
		push	ax
		push	[bp+var_C]
		push	[bp+var_E]
		mov	ax, 0E000h
		push	ax
		push	[bp+var_2]
		call	CopyTextBuffer2
		add	sp, 0Eh
		sub	ax, ax
		push	ax
		call	SetGDCPlane_Wrt
		add	sp, 2
		sub	ax, ax
		push	ax
		mov	ax, 13h
		push	ax
		mov	ax, 14h
		push	ax
		push	[bp+var_C]
		push	[bp+var_E]
		mov	ax, 0E000h
		push	ax
		push	[bp+var_2]
		call	CopyTextBuffer2
		add	sp, 0Eh

loc_17C00:				; CODE XREF: sub_17A0B+1Dj
					; sub_17A0B+4Dj ...
		mov	sp, bp
		pop	bp
		retn
sub_17A0B	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

CalcTBoxThing	proc near		; CODE XREF: _main+14Cp

var_4		= word ptr -4
tBoxID		= word ptr -2

		push	bp
		mov	bp, sp
		mov	ax, 4
		call	__chkstk
		push	si
		mov	[bp+var_4], 0
		mov	[bp+tBoxID], 0
		jmp	short loc_17C1D
; ---------------------------------------------------------------------------

loc_17C1A:				; CODE XREF: CalcTBoxThing+62j
		inc	[bp+tBoxID]

loc_17C1D:				; CODE XREF: CalcTBoxThing+14j
		cmp	[bp+tBoxID], 7
		jnb	short loc_17C68
		mov	bx, [bp+tBoxID]
		shl	bx, 1
		shl	bx, 1
		mov	ax, [bp+var_4]
		add	ax, word ptr tBoxBufferPtr
		mov	dx, word ptr tBoxBufferPtr+2
		mov	word ptr tBoxBufferPtrs[bx], ax
		mov	word ptr (tBoxBufferPtrs+2)[bx], dx
		mov	ax, 12h
		mul	[bp+tBoxID]
		mov	si, ax
		mov	ax, TextBoxes.sizeX[si]
		imul	TextBoxes.sizeY[si]
		mov	cx, 108		; 108 =	18 * 6
		imul	cx
		add	[bp+var_4], ax
		mov	si, [bp+tBoxID]
		shl	si, 1
		mov	word ptr (tBoxBufferPtrs+1Ch)[si], 0
		mov	word_1C542[si],	0
		jmp	short loc_17C1A
; ---------------------------------------------------------------------------

loc_17C68:				; CODE XREF: CalcTBoxThing+1Dj
		cmp	debugMode, 0
		jz	short loc_17C7C
		push	[bp+var_4]
		mov	ax, offset aTextWorkLength ; "\ntext work length=%d\n"
		push	ax		; char *
		call	_printf
		add	sp, 4

loc_17C7C:				; CODE XREF: CalcTBoxThing+69j
		pop	si
		mov	sp, bp
		pop	bp
		retn
CalcTBoxThing	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_17C81	proc near		; CODE XREF: sub_13AFC+D1p
					; sub_13AFC+1DEp ...

var_4		= word ptr -4
var_2		= word ptr -2

		push	bp
		mov	bp, sp
		mov	ax, 4
		call	__chkstk
		lea	ax, [bp+var_4]
		push	ax
		lea	ax, [bp+var_2]
		push	ax
		call	GetTextPixPos
		add	sp, 4
		mov	ax, 5
		push	ax
		call	TBoxBuf_Buf2Scr
		add	sp, 2
		sub	ax, ax
		push	ax
		call	TBoxBuf_Buf2Scr
		add	sp, 2
		mov	ax, 1
		push	ax
		call	TBoxBuf_Buf2Scr
		add	sp, 2
		mov	ax, 3
		push	ax
		call	TBoxBuf_Buf2Scr
		add	sp, 2
		call	sub_17A0B
		call	sub_143EC
		call	sub_118DA
		push	[bp+var_4]
		push	[bp+var_2]
		call	SetTextDrawPos
		add	sp, 4
		mov	sp, bp
		pop	bp
		retn
sub_17C81	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

WaitFrames	proc near		; CODE XREF: ExecuteScript+690p
					; DrawString_Wait+5Ap ...

arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		mov	ax, 4
		call	__chkstk
		mov	ax, [bp+arg_0]
		mov	palFadeSpeed, ax

loc_17CE7:				; CODE XREF: WaitFrames+20j
		call	sub_17C81
		cmp	stopDialogDraw,	0
		jz	short loc_17CF3
		jmp	short loc_17CFA
; ---------------------------------------------------------------------------

loc_17CF3:				; CODE XREF: WaitFrames+17j
		cmp	palFadeSpeed, 0
		jnz	short loc_17CE7

loc_17CFA:				; CODE XREF: WaitFrames+19j
		mov	sp, bp
		pop	bp
		retn
WaitFrames	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

WaitForTxtOrPal	proc near		; CODE XREF: Palette_Fade2Tgt:loc_13A4Dp
		push	bp
		mov	bp, sp
		mov	ax, 4
		call	__chkstk

loc_17D07:				; CODE XREF: WaitForTxtOrPal+1Aj
		call	sub_17C81
		cmp	stopDialogDraw,	0
		jz	short loc_17D13
		jmp	short loc_17D1A
; ---------------------------------------------------------------------------

loc_17D13:				; CODE XREF: WaitForTxtOrPal+11j
		cmp	palFadeSpeed, 0
		jnz	short loc_17D07

loc_17D1A:				; CODE XREF: WaitForTxtOrPal+13j
		mov	sp, bp
		pop	bp
		retn
WaitForTxtOrPal	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_17D1E	proc near		; CODE XREF: sub_10A4B:loc_10AF9p
					; sub_110EF:loc_11174p	...
		push	bp
		mov	bp, sp
		xor	ax, ax
		call	__chkstk
		call	sub_17D4A

loc_17D29:				; CODE XREF: sub_17D1E:loc_17D44j
		call	sub_17C81
		cmp	stopDialogDraw,	0
		jz	short loc_17D38
		mov	ax, 0Dh
		jmp	short loc_17D46
; ---------------------------------------------------------------------------

loc_17D38:				; CODE XREF: sub_17D1E+13j
		call	sub_167A3
		or	ax, ax
		jz	short loc_17D44
		call	sub_167AE
		jmp	short loc_17D46
; ---------------------------------------------------------------------------

loc_17D44:				; CODE XREF: sub_17D1E+1Fj
		jmp	short loc_17D29
; ---------------------------------------------------------------------------

loc_17D46:				; CODE XREF: sub_17D1E+18j
					; sub_17D1E+24j
		mov	sp, bp
		pop	bp
		retn
sub_17D1E	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_17D4A	proc near		; CODE XREF: sub_17D1E+8p
					; LoadFile2:loc_17D98p	...
		push	bp
		mov	bp, sp
		xor	ax, ax
		call	__chkstk

loc_17D52:				; CODE XREF: sub_17D4A+12j
		call	sub_167A3
		or	ax, ax
		jz	short loc_17D5E
		call	sub_167AE
		jmp	short loc_17D52
; ---------------------------------------------------------------------------

loc_17D5E:				; CODE XREF: sub_17D4A+Dj
		mov	sp, bp
		pop	bp
		retn
sub_17D4A	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

; int __cdecl LoadFile2(char *)
LoadFile2	proc near		; CODE XREF: ExecuteScript+90Ep

var_8		= byte ptr -8
var_6		= word ptr -6
var_4		= word ptr -4
var_2		= dword	ptr -2
arg_0		= dword	ptr  4

		push	bp
		mov	bp, sp
		mov	ax, 8
		call	__chkstk
		cmp	debugMode, 0
		jnz	short loc_17D98
		mov	bx, word ptr [bp+arg_0]
		mov	al, [bx]
		mov	[bp+var_8], al
		cmp	al, 'c'
		jz	short loc_17D82
		cmp	al, 'C'
		jnz	short loc_17D85

loc_17D82:				; CODE XREF: LoadFile2+1Aj
		mov	byte ptr [bx], 'a'

loc_17D85:				; CODE XREF: LoadFile2+1Ej
		mov	bx, word ptr [bp+arg_0]
		mov	al, [bx]
		mov	[bp+var_8], al
		cmp	al, 'd'
		jz	short loc_17D95
		cmp	al, 'D'
		jnz	short loc_17D98

loc_17D95:				; CODE XREF: LoadFile2+2Dj
		mov	byte ptr [bx], 'b'

loc_17D98:				; CODE XREF: LoadFile2+Ej
					; LoadFile2+31j
		call	sub_17D4A
		lea	ax, [bp+var_6]
		push	ax
		lea	ax, [bp+var_4]
		push	ax
		call	GetTextChrPos
		add	sp, 4

loc_17DA9:				; CODE XREF: LoadFile2:loc_17DE0j
		mov	ax, offset aRb	; "rb"
		push	ax
		push	word ptr [bp+arg_0] ; char *
		call	_fopen
		add	sp, 4
		mov	word ptr [bp+var_2], ax
		or	ax, ax
		jnz	short loc_17DD5
		push	[bp+var_6]
		push	[bp+var_4]
		call	sub_1623B
		add	sp, 4
		mov	ax, 2
		push	ax
		call	WaitForInput
		add	sp, 2
		jmp	short loc_17DE0
; ---------------------------------------------------------------------------

loc_17DD5:				; CODE XREF: LoadFile2+59j
		push	word ptr [bp+var_2] ; FILE *
		call	_fclose
		add	sp, 2
		jmp	short loc_17DE2
; ---------------------------------------------------------------------------

loc_17DE0:				; CODE XREF: LoadFile2+71j
		jmp	short loc_17DA9
; ---------------------------------------------------------------------------

loc_17DE2:				; CODE XREF: LoadFile2+7Cj
		mov	sp, bp
		pop	bp
		retn
LoadFile2	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

; int __cdecl CheckFileExist(char *)
CheckFileExist	proc near		; CODE XREF: ExecuteScript+A3Ep

var_8		= byte ptr -8
var_2		= dword	ptr -2
arg_0		= dword	ptr  4

		push	bp
		mov	bp, sp
		mov	ax, 8
		call	__chkstk
		cmp	debugMode, 0
		jnz	short loc_17E1C
		mov	bx, word ptr [bp+arg_0]
		mov	al, [bx]
		mov	[bp+var_8], al
		cmp	al, 'c'
		jz	short loc_17E06
		cmp	al, 'C'
		jnz	short loc_17E09

loc_17E06:				; CODE XREF: CheckFileExist+1Aj
		mov	byte ptr [bx], 'a'

loc_17E09:				; CODE XREF: CheckFileExist+1Ej
		mov	bx, word ptr [bp+arg_0]
		mov	al, [bx]
		mov	[bp+var_8], al
		cmp	al, 'd'
		jz	short loc_17E19
		cmp	al, 'D'
		jnz	short loc_17E1C

loc_17E19:				; CODE XREF: CheckFileExist+2Dj
		mov	byte ptr [bx], 'b'

loc_17E1C:				; CODE XREF: CheckFileExist+Ej
					; CheckFileExist+31j
		mov	ax, offset aRb_0 ; "rb"
		push	ax
		push	word ptr [bp+arg_0] ; char *
		call	_fopen
		add	sp, 4
		mov	word ptr [bp+var_2], ax
		or	ax, ax
		jnz	short loc_17E36
		sub	ax, ax
		jmp	short loc_17E44
; ---------------------------------------------------------------------------
		jmp	short loc_17E44
; ---------------------------------------------------------------------------

loc_17E36:				; CODE XREF: CheckFileExist+48j
		push	word ptr [bp+var_2] ; FILE *
		call	_fclose
		add	sp, 2
		mov	ax, 1
		jmp	short $+2

loc_17E44:				; CODE XREF: CheckFileExist+4Cj
					; CheckFileExist+4Ej
		mov	sp, bp
		pop	bp
		retn
CheckFileExist	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

WaitForInput	proc near		; CODE XREF: DrawText_Dialog+BAp
					; DrawText_Dialog+16Bp	...

var_8		= word ptr -8
var_6		= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2
arg_tBoxID	= word ptr  4

		push	bp
		mov	bp, sp
		mov	ax, 8
		call	__chkstk
		push	si
		mov	[bp+var_2], 0
		mov	[bp+var_8], 0
		lea	ax, [bp+var_6]
		push	ax
		lea	ax, [bp+var_4]
		push	ax
		call	GetTextChrPos
		add	sp, 4
		mov	ax, 12h
		imul	[bp+arg_tBoxID]
		mov	si, ax
		mov	ax, TextBoxes.sizeX[si]
		cwd
		sub	ax, dx
		sar	ax, 1
		imul	TextBoxes.txSzX[si]
		add	ax, word ptr TextBoxes.baseX[si]
		mov	[bp+var_4], ax
		mov	ax, TextBoxes.txPosY[si]
		inc	ax
		imul	TextBoxes.txSzY[si]
		add	ax, TextBoxes.baseY[si]
		mov	[bp+var_6], ax
		call	sub_17D4A

loc_17E99:				; CODE XREF: WaitForInput:loc_17F40j
		cmp	[bp+var_2], 0Dh
		jnz	short loc_17EA2
		jmp	loc_17F43
; ---------------------------------------------------------------------------

loc_17EA2:				; CODE XREF: WaitForInput+55j
		mov	word_1B0E2, 9
		cmp	[bp+var_8], 0
		jz	short loc_17EC2
		mov	ax, 2
		push	ax
		mov	ax, 10h
		push	ax
		mov	ax, 8
		push	ax
		call	SetTextOpts
		add	sp, 6
		jmp	short loc_17ED3
; ---------------------------------------------------------------------------

loc_17EC2:				; CODE XREF: WaitForInput+64j
		mov	ax, 2
		push	ax
		mov	ax, 10h
		push	ax
		sub	ax, ax
		push	ax
		call	SetTextOpts
		add	sp, 6

loc_17ED3:				; CODE XREF: WaitForInput+78j
		sub	ax, ax
		push	ax
		call	SetGDCPlane_Wrt
		add	sp, 2
		push	[bp+var_6]
		push	[bp+var_4]
		call	SetTextDrawPos
		add	sp, 4
		mov	ax, offset txtWaitCursor
		push	ax
		call	j_DrawString
		add	sp, 2
		inc	[bp+var_8]
		and	[bp+var_8], 1

loc_17EF9:				; CODE XREF: WaitForInput:loc_17F35j
		cmp	word_1B0E2, 0
		jz	short loc_17F37
		call	sub_167A3
		or	ax, ax
		jz	short loc_17F29
		call	sub_167AE
		mov	[bp+var_2], ax
		cmp	ax, 0Dh
		jnz	short loc_17F14
		jmp	short loc_17F37
; ---------------------------------------------------------------------------

loc_17F14:				; CODE XREF: WaitForInput+C8j
		cmp	debugMode, 0
		jz	short loc_17F29
		cmp	[bp+var_2], 1Bh
		jnz	short loc_17F29
		mov	word_1B0E0, 1
		jmp	short loc_17F37
; ---------------------------------------------------------------------------

loc_17F29:				; CODE XREF: WaitForInput+BDj
					; WaitForInput+D1j ...
		call	sub_17C81
		cmp	stopDialogDraw,	0
		jz	short loc_17F35
		jmp	short loc_17F37
; ---------------------------------------------------------------------------

loc_17F35:				; CODE XREF: WaitForInput+E9j
		jmp	short loc_17EF9
; ---------------------------------------------------------------------------

loc_17F37:				; CODE XREF: WaitForInput+B6j
					; WaitForInput+CAj ...
		cmp	stopDialogDraw,	0
		jz	short loc_17F40
		jmp	short loc_17F43
; ---------------------------------------------------------------------------

loc_17F40:				; CODE XREF: WaitForInput+F4j
		jmp	loc_17E99
; ---------------------------------------------------------------------------

loc_17F43:				; CODE XREF: WaitForInput+57j
					; WaitForInput+F6j
		mov	ax, 2
		push	ax
		mov	ax, 10h
		push	ax
		sub	ax, ax
		push	ax
		call	SetTextOpts
		add	sp, 6
		push	[bp+var_6]
		push	[bp+var_4]
		call	SetTextDrawPos
		add	sp, 4
		sub	ax, ax
		push	ax
		call	SetGDCPlane_Wrt
		add	sp, 2
		mov	ax, offset txtWaitCursor
		push	ax
		call	j_DrawString
		add	sp, 2
		mov	ax, 2
		push	ax
		mov	ax, 10h
		push	ax
		mov	ax, 8
		push	ax
		call	SetTextOpts
		add	sp, 6
		push	[bp+var_6]
		push	[bp+var_4]
		call	SetTextDrawPos
		add	sp, 4
		pop	si
		mov	sp, bp
		pop	bp
		retn
WaitForInput	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

LoadFile	proc near		; CODE XREF: LoadClearPBD+14p
					; sub_103B0+54p ...

var_4		= byte ptr -4
var_2		= word ptr -2
arg_0		= word ptr  4
arg_2		= word ptr  6
arg_4		= word ptr  8

		push	bp
		mov	bp, sp
		mov	ax, 4
		call	__chkstk
		cmp	debugMode, 0
		jz	short loc_17FB3
		push	[bp+arg_0]
		mov	ax, offset aFileReadingS ; "File reading [%s] "
		push	ax		; char *
		call	_printf
		add	sp, 4

loc_17FB3:				; CODE XREF: LoadFile+Ej
		cmp	debugMode, 0
		jnz	short loc_17FE0
		mov	bx, [bp+arg_0]
		mov	al, [bx]
		mov	[bp+var_4], al
		cmp	al, 'c'
		jz	short loc_17FCA
		cmp	al, 'C'
		jnz	short loc_17FCD

loc_17FCA:				; CODE XREF: LoadFile+2Ej
		mov	byte ptr [bx], 'a'

loc_17FCD:				; CODE XREF: LoadFile+32j
		mov	bx, [bp+arg_0]
		mov	al, [bx]
		mov	[bp+var_4], al
		cmp	al, 'd'
		jz	short loc_17FDD
		cmp	al, 'D'
		jnz	short loc_17FE0

loc_17FDD:				; CODE XREF: LoadFile+41j
		mov	byte ptr [bx], 'b'

loc_17FE0:				; CODE XREF: LoadFile+22j LoadFile+45j
		mov	ax, 0FFFFh
		push	ax
		push	[bp+arg_4]
		push	[bp+arg_2]
		push	[bp+arg_0]
		call	ReadFileData
		add	sp, 8
		mov	[bp+var_2], ax
		cmp	debugMode, 0
		jz	short loc_18008
		push	ax
		mov	ax, offset aReadLengthD	; "   read length=%d\n"
		push	ax		; char *
		call	_printf
		add	sp, 4

loc_18008:				; CODE XREF: LoadFile+65j
		cmp	[bp+var_2], 0
		jnz	short loc_18028
		cmp	debugMode, 0
		jz	short loc_18022
		push	[bp+arg_0]
		mov	ax, offset aFileNotFindS ; "File not find [%s]\n"
		push	ax		; char *
		call	_printf
		add	sp, 4

loc_18022:				; CODE XREF: LoadFile+7Dj
		mov	fileLoadErr, 1

loc_18028:				; CODE XREF: LoadFile+76j
		mov	ax, [bp+var_2]
		jmp	short $+2
		mov	sp, bp
		pop	bp
		retn
LoadFile	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_18031	proc near		; CODE XREF: sub_1160E+6Dp
					; sub_1160E+A3p ...

var_E		= word ptr -0Eh
var_C		= word ptr -0Ch
var_6		= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= dword	ptr  4
arg_4		= word ptr  8
arg_6		= word ptr  0Ah

		push	bp
		mov	bp, sp
		mov	ax, 10h
		call	__chkstk
		mov	ax, word ptr [bp+arg_0]
		mov	dx, word ptr [bp+arg_0+2]
		add	ax, 6
		mov	[bp+var_E], ax
		mov	[bp+var_C], dx
		les	bx, dword_1C344
		mov	al, es:[bx+3]
		sub	ah, ah
		mov	[bp+var_2], ax
		mov	ax, es:[bx+6]
		mov	[bp+var_4], ax
		mov	ax, 50h
		imul	[bp+arg_6]
		add	ax, [bp+arg_4]
		mov	[bp+var_6], ax
		les	bx, [bp+arg_0]
		mov	al, es:[bx+1]
		cbw
		mov	word_1C1A6, ax
		mov	al, es:[bx+1]
		cbw
		push	ax
		push	[bp+var_C]
		push	[bp+var_E]
		push	[bp+var_6]
		push	[bp+var_4]
		push	[bp+var_2]
		call	sub_152AB
		add	sp, 0Ch
		mov	sp, bp
		pop	bp
		retn
sub_18031	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_18093	proc near		; CODE XREF: sub_11DF6+88p
					; sub_11F4B+88p ...

var_C		= word ptr -0Ch
var_A		= word ptr -0Ah
var_8		= word ptr -8
var_6		= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= dword	ptr  4
arg_8		= word ptr  0Ch
arg_A		= word ptr  0Eh

		push	bp
		mov	bp, sp
		mov	ax, 0Ch
		call	__chkstk
		mov	ax, word ptr [bp+arg_0]
		mov	dx, word ptr [bp+arg_0+2]
		add	ax, 6
		mov	[bp+var_C], ax
		mov	[bp+var_A], dx
		les	bx, dword_1C344
		mov	al, es:[bx+3]
		sub	ah, ah
		mov	[bp+var_2], ax
		mov	ax, es:[bx+6]
		mov	[bp+var_4], ax
		mov	[bp+var_8], 0
		mov	al, es:[bx+3]
		sub	ah, ah
		mov	cx, ax
		les	bx, [bp+arg_0]
		mov	al, es:[bx+1]
		cbw
		inc	ax
		mul	cx
		mov	[bp+var_6], ax
		mov	al, es:[bx+1]
		cbw
		inc	ax
		push	ax
		push	[bp+arg_A]
		push	[bp+arg_8]
		push	[bp+var_A]
		push	[bp+var_C]
		mov	ax, [bp+var_6]
		dec	ax
		push	ax
		sub	ax, ax
		push	ax
		push	[bp+var_4]
		push	[bp+var_2]
		call	sub_15788
		add	sp, 12h
		mov	sp, bp
		pop	bp
		retn
sub_18093	endp

; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		mov	ax, 0Eh
		call	__chkstk
		mov	ax, [bp+4]
		mov	dx, [bp+6]
		add	ax, 6
		mov	[bp-0Ch], ax
		mov	[bp-0Ah], dx
		les	bx, dword_1C344
		mov	al, es:[bx+3]
		sub	ah, ah
		mov	[bp-2],	ax
		mov	ax, es:[bx+6]
		mov	[bp-4],	ax
		mov	al, es:[bx+3]
		sub	ah, ah
		mul	word ptr [bp+0Ah]
		add	ax, [bp+8]
		mov	[bp-8],	ax
		mov	al, es:[bx+3]
		sub	ah, ah
		mov	[bp-6],	ax
		mov	ax, 3
		push	ax
		push	word ptr [bp+0Eh]
		push	word ptr [bp+0Ch]
		push	word ptr [bp-0Ah]
		push	word ptr [bp-0Ch]
		mov	ax, [bp-6]
		dec	ax
		push	ax
		push	word ptr [bp-8]
		push	word ptr [bp-4]
		push	word ptr [bp-2]
		call	sub_14E21
		add	sp, 12h
		mov	sp, bp
		pop	bp
		retn

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_18171	proc near		; CODE XREF: ExecuteScript+603p
					; ExecuteScript+9BFp ...

var_C		= word ptr -0Ch
var_A		= word ptr -0Ah
var_8		= word ptr -8
var_6		= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= dword	ptr  4
arg_4		= word ptr  8
arg_6		= word ptr  0Ah
arg_8		= word ptr  0Ch
arg_A		= word ptr  0Eh
arg_C		= word ptr  10h
arg_E		= word ptr  12h

		push	bp
		mov	bp, sp
		mov	ax, 0Eh
		call	__chkstk
		mov	ax, word ptr [bp+arg_0]
		mov	dx, word ptr [bp+arg_0+2]
		add	ax, 6
		mov	[bp+var_C], ax
		mov	[bp+var_A], dx
		les	bx, dword_1C344
		mov	al, es:[bx+3]
		sub	ah, ah
		mov	[bp+var_2], ax
		mov	ax, es:[bx+6]
		mov	[bp+var_4], ax
		mov	ax, [bp+arg_6]
		imul	[bp+arg_C]
		add	ax, [bp+arg_4]
		mov	[bp+var_8], ax
		mov	ax, [bp+arg_C]
		dec	ax
		mov	[bp+var_6], ax
		les	bx, [bp+arg_0]
		mov	al, es:[bx+1]
		cbw
		mov	word_1C1A6, ax
		mov	ax, [bp+arg_C]
		imul	[bp+arg_E]
		push	ax
		mov	al, es:[bx+1]
		cbw
		push	ax
		push	[bp+arg_A]
		push	[bp+arg_8]
		push	[bp+var_A]
		push	[bp+var_C]
		push	[bp+var_6]
		push	[bp+var_8]
		push	[bp+var_4]
		push	[bp+var_2]
		call	sub_15E24
		add	sp, 14h
		mov	sp, bp
		pop	bp
		retn
sub_18171	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_181EA	proc near		; CODE XREF: sub_11DF6+F3p
					; sub_11F4B+F3p

var_C		= word ptr -0Ch
var_A		= word ptr -0Ah
var_8		= word ptr -8
var_6		= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= dword	ptr  4
arg_4		= word ptr  8
arg_6		= word ptr  0Ah
arg_8		= word ptr  0Ch
arg_A		= word ptr  0Eh
arg_C		= word ptr  10h
arg_E		= word ptr  12h

		push	bp
		mov	bp, sp
		mov	ax, 0Eh
		call	__chkstk
		mov	ax, word ptr [bp+arg_0]
		mov	dx, word ptr [bp+arg_0+2]
		add	ax, 6
		mov	[bp+var_C], ax
		mov	[bp+var_A], dx
		les	bx, dword_1C344
		mov	al, es:[bx+3]
		sub	ah, ah
		mov	[bp+var_2], ax
		mov	ax, es:[bx+6]
		mov	[bp+var_4], ax
		mov	ax, [bp+arg_6]
		add	ax, es:[bx+4]
		mul	[bp+arg_C]
		mov	cl, es:[bx+2]
		sub	ch, ch
		add	ax, cx
		add	ax, [bp+arg_4]
		mov	[bp+var_8], ax
		mov	ax, [bp+arg_C]
		dec	ax
		mov	[bp+var_6], ax
		mov	ax, [bp+arg_C]
		imul	[bp+arg_E]
		push	ax
		les	bx, [bp+arg_0]
		mov	al, es:[bx+1]
		cbw
		push	ax
		push	[bp+arg_A]
		push	[bp+arg_8]
		push	[bp+var_A]
		push	[bp+var_C]
		push	[bp+var_6]
		push	[bp+var_8]
		push	[bp+var_4]
		push	[bp+var_2]
		call	sub_15E24
		add	sp, 14h
		mov	sp, bp
		pop	bp
		retn
sub_181EA	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_18267	proc near		; CODE XREF: sub_11804+73p
					; sub_118DA+86p ...

var_C		= word ptr -0Ch
var_A		= word ptr -0Ah
var_8		= word ptr -8
var_6		= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= dword	ptr  4
arg_4		= word ptr  8
arg_6		= word ptr  0Ah
arg_8		= word ptr  0Ch
arg_A		= word ptr  0Eh
arg_C		= word ptr  10h
arg_E		= word ptr  12h

		push	bp
		mov	bp, sp
		mov	ax, 0Eh
		call	__chkstk
		mov	ax, word ptr [bp+arg_0]
		mov	dx, word ptr [bp+arg_0+2]
		add	ax, 6
		mov	[bp+var_C], ax
		mov	[bp+var_A], dx
		les	bx, dword_1C344
		mov	al, es:[bx+3]
		sub	ah, ah
		mov	[bp+var_2], ax
		mov	ax, es:[bx+6]
		mov	[bp+var_4], ax
		mov	ax, [bp+arg_6]
		imul	[bp+arg_C]
		add	ax, [bp+arg_4]
		mov	[bp+var_8], ax
		mov	ax, [bp+arg_C]
		dec	ax
		mov	[bp+var_6], ax
		mov	ax, [bp+arg_C]
		imul	[bp+arg_E]
		inc	ax
		push	ax
		les	bx, [bp+arg_0]
		mov	al, es:[bx+1]
		cbw
		push	ax
		push	[bp+arg_A]
		push	[bp+arg_8]
		push	[bp+var_A]
		push	[bp+var_C]
		push	[bp+var_6]
		push	[bp+var_8]
		push	[bp+var_4]
		push	[bp+var_2]
		call	sub_15E24
		add	sp, 14h
		mov	sp, bp
		pop	bp
		retn
sub_18267	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_182D9	proc near		; CODE XREF: ExecuteScript+960p

arg_0		= word ptr  4
arg_2		= word ptr  6
arg_4		= word ptr  8

		push	bp
		mov	bp, sp
		xor	ax, ax
		call	__chkstk
		push	word ptr dword_1C31A+2
		push	word ptr dword_1C31A
		push	[bp+arg_0]
		call	LoadFile
		add	sp, 6
		mov	ax, word ptr dword_1C31A
		mov	dx, word ptr dword_1C31A+2
		add	ax, 8
		mov	word ptr dword_1C344, ax
		mov	word ptr dword_1C344+2,	dx
		mov	ax, 1
		push	ax
		call	SetGDCPlane_Wrt
		add	sp, 2
		push	[bp+arg_4]
		mov	ax, [bp+arg_2]
		cwd
		xor	ax, dx
		sub	ax, dx
		mov	cx, 3
		sar	ax, cl
		xor	ax, dx
		sub	ax, dx
		push	ax
		les	bx, dword_1C344
		mov	ax, es:[bx]
		add	ax, word ptr dword_1C31A
		mov	dx, word ptr dword_1C31A+2
		push	dx
		push	ax
		call	sub_18031
		add	sp, 8
		call	SwapGDCPlanes
		mov	ax, 1
		push	ax
		call	SetGDCPlane_Wrt
		add	sp, 2
		push	[bp+arg_4]
		mov	ax, [bp+arg_2]
		cwd
		xor	ax, dx
		sub	ax, dx
		mov	cx, 3
		sar	ax, cl
		xor	ax, dx
		sub	ax, dx
		push	ax
		les	bx, dword_1C344
		mov	ax, es:[bx]
		add	ax, word ptr dword_1C31A
		mov	dx, word ptr dword_1C31A+2
		push	dx
		push	ax
		call	sub_18031
		add	sp, 8
		mov	sp, bp
		pop	bp
		retn
sub_182D9	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

CallMusicDriver	proc near		; CODE XREF: ExecuteScript+727p
					; PlayBGM+34p ...

arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		xor	ax, ax
		call	__chkstk
		cmp	musdrvIsLoaded,	0
		jnz	short loc_18387
		jmp	short loc_18390
; ---------------------------------------------------------------------------

loc_18387:				; CODE XREF: CallMusicDriver+Dj
		push	[bp+arg_0]
		call	DoIntA0
		add	sp, 2

loc_18390:				; CODE XREF: CallMusicDriver+Fj
		mov	sp, bp
		pop	bp
		retn
CallMusicDriver	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

PlayBGM		proc near		; CODE XREF: ExecuteScript+596p

var_8		= word ptr -8
var_6		= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		mov	ax, 8
		call	__chkstk
		mov	[bp+var_8], (offset byte_1A692+25Ah)
		mov	[bp+var_6], 0
		sub	bx, bx
		mov	es, bx
		assume es:nothing
		mov	bx, (offset byte_1A692+25Ah)
		mov	ax, es:[bx]
		mov	dx, es:[bx+2]
		mov	[bp+var_4], ax
		mov	[bp+var_2], dx
		cmp	musdrvIsLoaded,	0
		jnz	short loc_183C4
		jmp	short loc_183EE
; ---------------------------------------------------------------------------

loc_183C4:				; CODE XREF: PlayBGM+2Cj
		mov	ax, 99
		push	ax
		call	CallMusicDriver	; MUSDRV call 99 - stop	music
		add	sp, 2
		mov	bx, [bp+arg_0]
		cmp	byte ptr [bx], '2' ; file name "2" - stop music
		jnz	short loc_183D8
		jmp	short loc_183EE
; ---------------------------------------------------------------------------

loc_183D8:				; CODE XREF: PlayBGM+40j
		push	[bp+var_2]
		push	[bp+var_4]
		push	bx
		call	LoadFile
		add	sp, 6
		sub	ax, ax
		push	ax
		call	CallMusicDriver	; MUSDRV call 0	- play music
		add	sp, 2

loc_183EE:				; CODE XREF: PlayBGM+2Ej PlayBGM+42j
		mov	sp, bp
		pop	bp
		retn
PlayBGM		endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

SetupIntA6	proc near		; CODE XREF: j_SetupIntA6+8p

var_C		= word ptr -0Ch
var_A		= word ptr -0Ah
var_8		= word ptr -8
var_6		= word ptr -6
var_4		= dword	ptr -4

		push	bp
		mov	bp, sp
		mov	ax, 0Ch
		call	__chkstk
		push	si
		mov	[bp+var_C], (offset byte_1A692+256h)
		mov	[bp+var_A], 0
		sub	bx, bx
		mov	es, bx
		mov	bx, (offset byte_1A692+256h)
		mov	ax, es:[bx]
		mov	dx, es:[bx+2]
		mov	word ptr [bp+var_4], ax
		mov	word ptr [bp+var_4+2], dx
		mov	[bp+var_8], 1
		mov	[bp+var_6], es
		jmp	short loc_18427
; ---------------------------------------------------------------------------

loc_18424:				; CODE XREF: SetupIntA6:loc_18443j
		inc	[bp+var_6]

loc_18427:				; CODE XREF: SetupIntA6+30j
		cmp	[bp+var_6], 6
		jge	short loc_18445
		mov	bx, [bp+var_6]
		mov	al, byte ptr aMusdrv[bx] ; "MUSDRV"
		les	si, [bp+var_4]
		assume es:nothing
		cmp	es:[bx+si], al
		jz	short loc_18443
		mov	[bp+var_8], 0
		jmp	short loc_18445
; ---------------------------------------------------------------------------

loc_18443:				; CODE XREF: SetupIntA6+48j
		jmp	short loc_18424
; ---------------------------------------------------------------------------

loc_18445:				; CODE XREF: SetupIntA6+39j
					; SetupIntA6+4Fj
		mov	ax, [bp+var_8]
		mov	musdrvIsLoaded,	ax
		pop	si
		mov	sp, bp
		pop	bp
		retn
SetupIntA6	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

j_SetupIntA6	proc near		; CODE XREF: _main:loc_14881p
		push	bp
		mov	bp, sp
		xor	ax, ax
		call	__chkstk
		call	SetupIntA6
		mov	sp, bp
		pop	bp
		retn
j_SetupIntA6	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1845F	proc near		; CODE XREF: ExecuteScript+524p

var_6		= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  4
arg_2		= word ptr  6

		push	bp
		mov	bp, sp
		mov	ax, 6
		call	__chkstk
		push	di
		push	si
		mov	ax, word_1B24A
		add	ax, word ptr dword_1C31A
		mov	dx, word ptr dword_1C31A+2
		mov	[bp+var_4], ax
		mov	[bp+var_2], dx
		and	[bp+arg_2], 1
		mov	bx, [bp+arg_2]
		shl	bx, 1
		mov	di, word_1B5D2[bx]
		shl	di, 1
		shl	di, 1
		mov	ax, 50h
		imul	[bp+arg_2]
		mov	bx, ax
		mov	ax, [bp+var_4]
		mov	dx, [bp+var_2]
		mov	word ptr dword_1C1F2[bx+di], ax
		mov	word ptr (dword_1C1F2+2)[bx+di], dx
		push	[bp+var_2]
		push	[bp+var_4]
		push	[bp+arg_0]
		call	LoadFile
		add	sp, 6
		mov	[bp+var_6], ax
		mov	si, [bp+arg_2]
		shl	si, 1
		add	si, offset word_1B5D2
		mov	ax, 28h
		imul	[bp+arg_2]
		mov	di, ax
		mov	bx, [si]
		shl	bx, 1
		mov	ax, [bp+var_6]
		mov	word_1B664[bx+di], ax
		inc	word ptr [si]
		mov	ax, [bp+var_6]
		add	word_1B24A, ax
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retn
sub_1845F	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_184DF	proc near		; CODE XREF: ExecuteScript:loc_1251Dp
		push	bp
		mov	bp, sp
		xor	ax, ax
		call	__chkstk
		mov	word_1B24A, 7D00h
		mov	word_1B5D2, 0
		mov	word_1B5D4, 0
		mov	sp, bp
		pop	bp
		retn
sub_184DF	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_184FD	proc near		; CODE XREF: sub_10A4B+23Cp
					; ExecuteScript+155p ...

var_8		= word ptr -8
var_6		= word ptr -6
var_4		= word ptr -4
var_2		= word ptr -2
arg_0		= word ptr  4
arg_2		= word ptr  6

		push	bp
		mov	bp, sp
		mov	ax, 8
		call	__chkstk
		push	si
		mov	[bp+var_8], (offset byte_1A692+25Ah)
		mov	[bp+var_6], 0
		sub	bx, bx
		mov	es, bx
		assume es:nothing
		mov	bx, (offset byte_1A692+25Ah)
		mov	ax, es:[bx]
		mov	dx, es:[bx+2]
		mov	[bp+var_4], ax
		mov	[bp+var_2], dx
		cmp	bgmIsPlaying, 0
		jz	short loc_1852E
		jmp	short loc_1857E
; ---------------------------------------------------------------------------

loc_1852E:				; CODE XREF: sub_184FD+2Dj
		cmp	musdrvIsLoaded,	0
		jnz	short loc_18537
		jmp	short loc_1857E
; ---------------------------------------------------------------------------

loc_18537:				; CODE XREF: sub_184FD+36j
		mov	ax, 99
		push	ax
		call	CallMusicDriver	; MUSDRV call 99 - stop	music
		add	sp, 2
		mov	ax, 28h
		imul	[bp+arg_0]
		mov	si, ax
		mov	bx, [bp+arg_2]
		shl	bx, 1
		push	word_1B664[bx+si]
		mov	ax, 50h
		imul	[bp+arg_0]
		mov	si, ax
		mov	bx, [bp+arg_2]
		shl	bx, 1
		shl	bx, 1
		push	word ptr (dword_1C1F2+2)[bx+si]
		push	word ptr dword_1C1F2[bx+si]
		push	[bp+var_2]
		push	[bp+var_4]
		call	sub_18583
		add	sp, 0Ah
		sub	ax, ax
		push	ax
		call	CallMusicDriver	; MUSDRV call 0	- play music
		add	sp, 2

loc_1857E:				; CODE XREF: sub_184FD+2Fj
					; sub_184FD+38j
		pop	si
		mov	sp, bp
		pop	bp
		retn
sub_184FD	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_18583	proc near		; CODE XREF: sub_184FD+72p

var_2		= word ptr -2
arg_0		= dword	ptr  4
arg_4		= dword	ptr  8
arg_8		= word ptr  0Ch

		push	bp
		mov	bp, sp
		mov	ax, 2
		call	__chkstk
		push	si
		mov	[bp+var_2], 0
		jmp	short loc_18597
; ---------------------------------------------------------------------------

loc_18594:				; CODE XREF: sub_18583+2Bj
		inc	[bp+var_2]

loc_18597:				; CODE XREF: sub_18583+Fj
		mov	ax, [bp+arg_8]
		cmp	[bp+var_2], ax
		jnb	short loc_185B0
		mov	bx, [bp+var_2]
		les	si, [bp+arg_4]
		assume es:nothing
		mov	al, es:[bx+si]
		les	si, [bp+arg_0]
		mov	es:[bx+si], al
		jmp	short loc_18594
; ---------------------------------------------------------------------------

loc_185B0:				; CODE XREF: sub_18583+1Aj
		pop	si
		mov	sp, bp
		pop	bp
		retn
sub_18583	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_185B5	proc near		; CODE XREF: ExecuteScript:loc_13078p
		push	bp
		mov	bp, sp
		xor	ax, ax
		call	__chkstk
		mov	sp, bp
		pop	bp
		retn
sub_185B5	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_185C1	proc near		; CODE XREF: ExecuteScript+82Ap

arg_0		= word ptr  4
arg_2		= word ptr  6

		push	bp
		mov	bp, sp
		xor	ax, ax
		call	__chkstk
		mov	ax, [bp+arg_0]
		jmp	short loc_18633
; ---------------------------------------------------------------------------

loc_185CE:				; CODE XREF: sub_185C1+74j
		mov	ax, [bp+arg_2]
		add	ax, word ptr scrDataBasePtr
		mov	dx, word ptr scrDataBasePtr+2
		mov	word_1C1AC, ax
		mov	word_1C1AE, dx

loc_185E0:				; CODE XREF: sub_185C1+79j
		mov	word_1C32E, 0FA0h
		mov	ax, word_1C1AC
		mov	dx, word_1C1AE
		mov	word ptr scrDataPtr, ax
		mov	word ptr scrDataPtr+2, dx

loc_185F4:				; CODE XREF: sub_185C1+7Ej
		cmp	word_1C32E, 0
		jnz	short loc_18623
		mov	ax, word ptr scrDataPtr
		mov	dx, word ptr scrDataPtr+2
		mov	word_1C1AC, ax
		mov	word_1C1AE, dx
		mov	ax, [bp+arg_2]
		add	ax, word ptr scrDataBasePtr
		mov	dx, word ptr scrDataBasePtr+2
		mov	word ptr scrDataPtr, ax
		mov	word ptr scrDataPtr+2, dx
		mov	word_1AB5A, 0
		jmp	short loc_18631
; ---------------------------------------------------------------------------

loc_18623:				; CODE XREF: sub_185C1+38j
		mov	ax, word ptr scrDataPtr
		mov	dx, word ptr scrDataPtr+2
		mov	word_1C1AC, ax
		mov	word_1C1AE, dx

loc_18631:				; CODE XREF: sub_185C1+60j
		jmp	short loc_18643
; ---------------------------------------------------------------------------

loc_18633:				; CODE XREF: sub_185C1+Bj
		or	ax, ax
		jz	short loc_185CE
		cmp	ax, 1
		jz	short loc_185E0
		cmp	ax, 2
		jz	short loc_185F4
		jmp	short $+2

loc_18643:				; CODE XREF: sub_185C1:loc_18631j
		mov	sp, bp
		pop	bp
		retn
sub_185C1	endp

; ---------------------------------------------------------------------------
		push	bp
		mov	bp, sp
		mov	ax, 4
		call	__chkstk
		mov	al, [bp+5]
		sub	ah, ah
		mov	[bp-2],	ax
		cmp	ax, 9Fh	; 'Ÿ'
		ja	short loc_18662
		mov	ax, 81h	; ''
		jmp	short loc_18665
; ---------------------------------------------------------------------------

loc_18662:				; CODE XREF: seg000:865Bj
		mov	ax, 0C1h ; 'Á'

loc_18665:				; CODE XREF: seg000:8660j
		sub	[bp-2],	ax
		mov	al, [bp+4]
		sub	ah, ah
		mov	[bp-4],	ax
		cmp	ax, 7Eh	; '~'
		ja	short loc_1867A
		mov	ax, 40h	; '@'
		jmp	short loc_1867D
; ---------------------------------------------------------------------------

loc_1867A:				; CODE XREF: seg000:8673j
		mov	ax, 41h	; 'A'

loc_1867D:				; CODE XREF: seg000:8678j
		sub	[bp-4],	ax
		mov	ax, [bp-4]
		sub	dx, dx
		mov	cx, 5Eh	; '^'
		div	cx
		mov	ax, [bp-4]
		mov	cx, dx
		sub	dx, dx
		mov	bx, 5Eh	; '^'
		div	bx
		mov	dx, [bp-2]
		shl	dx, 1
		add	ax, dx
		mov	dx, ax
		mov	ah, dl
		sub	al, al
		add	ax, cx
		add	ax, 2121h
		jmp	short $+2
		mov	sp, bp
		pop	bp
		retn
		assume ss:seg003, ds:nothing
; [000000B2 BYTES: COLLAPSED FUNCTION start. PRESS KEYPAD "+" TO EXPAND]
; [000000C4 BYTES: COLLAPSED FUNCTION __cinit. PRESS KEYPAD "+"	TO EXPAND]
; [00000017 BYTES: COLLAPSED FUNCTION _exit. PRESS KEYPAD "+" TO EXPAND]
; [00000045 BYTES: COLLAPSED FUNCTION __exit. PRESS KEYPAD "+" TO EXPAND]
; [0000002D BYTES: COLLAPSED FUNCTION __ctermsub. PRESS	KEYPAD "+" TO EXPAND]
; [0000000F BYTES: COLLAPSED FUNCTION sub_188AD. PRESS KEYPAD "+" TO EXPAND]
; [00000013 BYTES: COLLAPSED FUNCTION sub_188BC. PRESS KEYPAD "+" TO EXPAND]
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
; [00000008 BYTES: COLLAPSED CHUNK OF FUNCTION _close. PRESS KEYPAD "+"	TO EXPAND]
; ---------------------------------------------------------------------------

__dosreturn:
		jnb	short loc_18BC2
		push	ax
		call	sub_18BE6
		pop	ax
		mov	sp, bp
		pop	bp
		retn
; ---------------------------------------------------------------------------
; [00000002 BYTES: COLLAPSED CHUNK OF FUNCTION _open. PRESS KEYPAD "+" TO EXPAND]
; [0000000B BYTES: COLLAPSED CHUNK OF FUNCTION _close. PRESS KEYPAD "+"	TO EXPAND]
; ---------------------------------------------------------------------------

__maperror:
		xor	ah, ah
		call	sub_18BE6
		retn

; =============== S U B	R O U T	I N E =======================================


sub_18BE6	proc near		; CODE XREF: seg000:8BCBp
					; _close:loc_18BD5p ...
		mov	byte_1B2D6, al
		or	ah, ah
		jnz	short loc_18C10
		cmp	byte ptr word_1B2D3, 3
		jb	short loc_18C01
		cmp	al, 22h	; '"'
		jnb	short loc_18C05
		cmp	al, 20h	; ' '
		jb	short loc_18C01
		mov	al, 5
		jmp	short loc_18C07
; ---------------------------------------------------------------------------
		db 90h
; ---------------------------------------------------------------------------

loc_18C01:				; CODE XREF: sub_18BE6+Cj
					; sub_18BE6+14j
		cmp	al, 13h
		jbe	short loc_18C07

loc_18C05:				; CODE XREF: sub_18BE6+10j
		mov	al, 13h

loc_18C07:				; CODE XREF: sub_18BE6+18j
					; sub_18BE6+1Dj
		mov	bx, 0CB8h
		xlat

loc_18C0B:				; CODE XREF: sub_18BE6+2Cj
		cbw
		mov	word_1B2CB, ax
		retn
; ---------------------------------------------------------------------------

loc_18C10:				; CODE XREF: sub_18BE6+5j
		mov	al, ah
		jmp	short loc_18C0B
sub_18BE6	endp

; [000000BA BYTES: COLLAPSED FUNCTION _fclose. PRESS KEYPAD "+"	TO EXPAND]
; [00000032 BYTES: COLLAPSED FUNCTION _flushall. PRESS KEYPAD "+" TO EXPAND]
; [00000027 BYTES: COLLAPSED FUNCTION _fopen. PRESS KEYPAD "+" TO EXPAND]
		align 2
; [0000003C BYTES: COLLAPSED FUNCTION _printf. PRESS KEYPAD "+"	TO EXPAND]
; [000000C0 BYTES: COLLAPSED FUNCTION __filbuf.	PRESS KEYPAD "+" TO EXPAND]
; [00000155 BYTES: COLLAPSED FUNCTION __flsbuf.	PRESS KEYPAD "+" TO EXPAND]
		align 2
; [0000002D BYTES: COLLAPSED FUNCTION __freebuf. PRESS KEYPAD "+" TO EXPAND]
		align 2
; [0000006C BYTES: COLLAPSED FUNCTION __getbuf.	PRESS KEYPAD "+" TO EXPAND]
; [000000F8 BYTES: COLLAPSED FUNCTION __openfile. PRESS	KEYPAD "+" TO EXPAND]
; [00000084 BYTES: COLLAPSED FUNCTION __stbuf. PRESS KEYPAD "+"	TO EXPAND]
; [00000096 BYTES: COLLAPSED FUNCTION __ftbuf. PRESS KEYPAD "+"	TO EXPAND]
; [0000006E BYTES: COLLAPSED FUNCTION _fflush. PRESS KEYPAD "+"	TO EXPAND]

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_19294	proc near		; CODE XREF: _printf+22p _sprintf+2Cp

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
		mov	word_1B588, ax
		mov	ax, [bp+arg_4]
		mov	word_1B578, ax
		mov	ax, [bp+arg_0]
		mov	word_1B56C, ax
		mov	word_1B582, 0
		mov	word_1B580, 0
		jmp	loc_195C0
; ---------------------------------------------------------------------------

loc_192C4:				; CODE XREF: sub_19294+331j
		cmp	byte ptr [si], 25h ; '%'
		jz	short loc_192CC
		jmp	loc_19572
; ---------------------------------------------------------------------------

loc_192CC:				; CODE XREF: sub_19294+33j
		mov	word_1B584, 1
		sub	ax, ax
		mov	word_1B574, ax
		mov	word_1B570, ax
		mov	word_1B57E, ax
		mov	word_1B572, ax
		mov	word_1B57C, ax
		mov	word_1B57A, ax
		mov	word_1B56E, ax
		mov	word_1B56A, ax
		mov	word_1B576, ax
		mov	word_1B58E, 20h	; ' '
		cmp	byte ptr [si+1], 30h ; '0'
		jnz	short loc_19337
		inc	si
		mov	word_1B58E, 30h	; '0'
		jmp	short loc_19337
; ---------------------------------------------------------------------------

loc_19304:				; CODE XREF: sub_19294+9Dj
		cmp	byte ptr [si], 2Bh ; '+'
		jnz	short loc_19316
		inc	word_1B574
		mov	word_1B57A, 0
		jmp	short loc_19337
; ---------------------------------------------------------------------------
		align 2

loc_19316:				; CODE XREF: sub_19294+73j
		cmp	byte ptr [si], 20h ; ' '
		jnz	short loc_19328
		cmp	word_1B574, 0
		jnz	short loc_19337
		inc	word_1B57A
		jmp	short loc_19337
; ---------------------------------------------------------------------------

loc_19328:				; CODE XREF: sub_19294+85j
		inc	word_1B56A
		jmp	short loc_19337
; ---------------------------------------------------------------------------

loc_1932E:				; CODE XREF: sub_19294+B0j
		cmp	byte ptr [si], 2Dh ; '-'
		jnz	short loc_19304
		inc	word_1B576

loc_19337:				; CODE XREF: sub_19294+65j
					; sub_19294+6Ej ...
		inc	si
		mov	al, [si]
		cbw
		push	ax
		call	sub_19B68
		add	sp, 2
		or	ax, ax
		jnz	short loc_1932E
		push	si
		mov	ax, 0F3Ah
		push	ax
		call	sub_19AE8
		add	sp, 4
		mov	si, ax
		cmp	word_1B58A, 0
		jge	short loc_19366
		inc	word_1B576
		mov	ax, word_1B58A
		neg	ax
		mov	word_1B58A, ax

loc_19366:				; CODE XREF: sub_19294+C4j
		cmp	byte ptr [si], 2Eh ; '.'
		jnz	short loc_1938E
		inc	word_1B57C
		inc	si
		push	si
		mov	ax, 0F34h
		push	ax
		call	sub_19AE8
		add	sp, 4
		mov	si, ax
		cmp	word_1B584, 0
		jge	short loc_1938E
		mov	word_1B584, 1
		dec	word_1B57C

loc_1938E:				; CODE XREF: sub_19294+D5j
					; sub_19294+EEj
		mov	al, [si]
		cbw
		cmp	ax, 46h	; 'F'
		jz	short loc_193C8
		cmp	ax, 4Eh	; 'N'
		jz	short loc_193D0
		cmp	ax, 68h	; 'h'
		jz	short loc_193C0
		cmp	ax, 6Ch	; 'l'
		jnz	short loc_193AB
		mov	word_1B572, 2

loc_193AB:				; CODE XREF: sub_19294+10Fj
					; sub_19294+132j ...
		cmp	word_1B572, 0
		jnz	short loc_193B7
		cmp	byte ptr [si], 4Ch ; 'L'
		jnz	short loc_193B8

loc_193B7:				; CODE XREF: sub_19294+11Cj
		inc	si

loc_193B8:				; CODE XREF: sub_19294+121j
		cmp	byte ptr [si], 0
		jnz	short loc_193D8
		jmp	loc_195C8
; ---------------------------------------------------------------------------

loc_193C0:				; CODE XREF: sub_19294+10Aj
		mov	word_1B572, 1
		jmp	short loc_193AB
; ---------------------------------------------------------------------------

loc_193C8:				; CODE XREF: sub_19294+100j
		mov	word_1B572, 10h
		jmp	short loc_193AB
; ---------------------------------------------------------------------------

loc_193D0:				; CODE XREF: sub_19294+105j
		mov	word_1B572, 8
		jmp	short loc_193AB
; ---------------------------------------------------------------------------

loc_193D8:				; CODE XREF: sub_19294+127j
		mov	al, [si]
		cbw
		mov	[bp+var_164], ax
		cmp	ax, 45h	; 'E'
		jz	short loc_193EE
		cmp	ax, 47h	; 'G'
		jz	short loc_193EE
		cmp	ax, 58h	; 'X'
		jnz	short loc_193F7

loc_193EE:				; CODE XREF: sub_19294+14Ej
					; sub_19294+153j
		inc	word_1B570
		add	[bp+var_164], 20h ; ' '

loc_193F7:				; CODE XREF: sub_19294+158j
		mov	ax, [bp+var_164]
		cmp	ax, 69h	; 'i'
		jz	short loc_1945A
		jle	short loc_19405
		jmp	loc_19576
; ---------------------------------------------------------------------------

loc_19405:				; CODE XREF: sub_19294+16Cj
		cmp	ax, 63h	; 'c'
		jnz	short loc_1940D
		jmp	loc_1953C
; ---------------------------------------------------------------------------

loc_1940D:				; CODE XREF: sub_19294+174j
		jle	short loc_19412
		jmp	loc_19556
; ---------------------------------------------------------------------------

loc_19412:				; CODE XREF: sub_19294:loc_1940Dj
		cmp	ax, 25h	; '%'
		jnz	short loc_1941A
		jmp	loc_1954C
; ---------------------------------------------------------------------------

loc_1941A:				; CODE XREF: sub_19294+181j
		jmp	loc_19568
; ---------------------------------------------------------------------------
		align 2

loc_1941E:				; CODE XREF: sub_19294+2E7j
		mov	bx, word_1B578
		mov	bx, [bx]
		mov	ax, word_1B580
		mov	[bx], ax

loc_19429:				; CODE XREF: sub_19294+295j
		add	word_1B578, 2

loc_1942E:				; CODE XREF: sub_19294+1D6j
		cmp	word_1B582, 0
		jnz	short loc_19438
		jmp	loc_195A2
; ---------------------------------------------------------------------------

loc_19438:				; CODE XREF: sub_19294+19Fj
		cmp	word_1B580, 0
		jz	short loc_19442
		jmp	loc_195DC
; ---------------------------------------------------------------------------

loc_19442:				; CODE XREF: sub_19294+1A9j
		mov	bx, word_1B56C
		test	byte ptr [bx+6], 20h
		jnz	short loc_1944F
		jmp	loc_195DC
; ---------------------------------------------------------------------------

loc_1944F:				; CODE XREF: sub_19294+1B6j
					; sub_19294+345j
		mov	ax, 0FFFFh
		jmp	loc_195DF
; ---------------------------------------------------------------------------
		align 2

loc_19456:				; CODE XREF: sub_19294+304j
		inc	word_1B57E

loc_1945A:				; CODE XREF: sub_19294+16Aj
					; sub_19294+2C7j
		mov	word_1B56A, 0
		mov	ax, 0Ah

loc_19463:				; CODE XREF: sub_19294+1DBj
					; sub_19294+29Bj
		push	ax
		call	sub_195E6

loc_19467:				; CODE XREF: sub_19294+2A4j
					; sub_19294+2B5j ...
		add	sp, 2
		jmp	short loc_1942E
; ---------------------------------------------------------------------------

loc_1946C:				; CODE XREF: sub_19294+2EFj
		mov	ax, 8
		jmp	short loc_19463
; ---------------------------------------------------------------------------
		align 2

loc_19472:				; CODE XREF: sub_19294+2F7j
		inc	word_1B56E
		inc	word_1B570
		cmp	word_1B57C, 0
		jnz	short loc_1948A
		mov	word_1B586, 1
		jmp	short loc_19490
; ---------------------------------------------------------------------------
		align 2

loc_1948A:				; CODE XREF: sub_19294+1EBj
		mov	word_1B586, 0

loc_19490:				; CODE XREF: sub_19294+1F3j
		inc	word_1B57C
		mov	word_1B584, 4
		cmp	word_1B572, 8
		jnz	short loc_194A4
		jmp	loc_1952C
; ---------------------------------------------------------------------------

loc_194A4:				; CODE XREF: sub_19294+20Bj
		sub	ax, ax
		mov	word_1B572, ax
		mov	[bp+var_4], ax
		cmp	word_1B58A, ax
		jz	short loc_194D9
		mov	ax, word_1B58A
		mov	[bp+var_4], ax
		cmp	word_1B576, 0
		jz	short loc_194C8
		mov	word_1B58A, 0
		jmp	short loc_194D9
; ---------------------------------------------------------------------------
		align 2

loc_194C8:				; CODE XREF: sub_19294+229j
		sub	word_1B58A, 5
		mov	ax, word_1B58A
		or	ax, ax
		jge	short loc_194D6
		sub	ax, ax

loc_194D6:				; CODE XREF: sub_19294+23Ej
		mov	word_1B58A, ax

loc_194D9:				; CODE XREF: sub_19294+21Cj
					; sub_19294+231j
		add	word_1B578, 2
		mov	ax, 10h
		push	ax
		call	sub_195E6
		add	sp, 2
		mov	ax, 3Ah	; ':'
		push	ax
		call	sub_198C0
		add	sp, 2
		cmp	[bp+var_4], 0
		jz	short loc_1951A
		cmp	word_1B576, 0
		jz	short loc_19514
		mov	ax, [bp+var_4]
		sub	ax, 5
		mov	word_1B58A, ax
		or	ax, ax
		jge	short loc_1950E
		sub	ax, ax

loc_1950E:				; CODE XREF: sub_19294+276j
		mov	word_1B58A, ax
		jmp	short loc_1951A
; ---------------------------------------------------------------------------
		align 2

loc_19514:				; CODE XREF: sub_19294+269j
		mov	word_1B58A, 0

loc_1951A:				; CODE XREF: sub_19294+262j
					; sub_19294+27Dj
		sub	word_1B578, 4
		mov	ax, 10h
		push	ax
		call	sub_195E6
		add	sp, 2
		jmp	loc_19429
; ---------------------------------------------------------------------------

loc_1952C:				; CODE XREF: sub_19294+20Dj
					; sub_19294+30Aj
		mov	ax, 10h
		jmp	loc_19463
; ---------------------------------------------------------------------------

loc_19532:				; CODE XREF: sub_19294+2FDj
		sub	ax, ax

loc_19534:				; CODE XREF: sub_19294+2ABj
		push	ax
		call	sub_1971C
		jmp	loc_19467
; ---------------------------------------------------------------------------
		align 2

loc_1953C:				; CODE XREF: sub_19294+176j
		mov	ax, 1
		jmp	short loc_19534
; ---------------------------------------------------------------------------
		align 2

loc_19542:				; CODE XREF: sub_19294+2D2j
		push	[bp+var_164]
		call	sub_19804
; ---------------------------------------------------------------------------
		jmp	loc_19467
; ---------------------------------------------------------------------------

loc_1954C:				; CODE XREF: sub_19294+183j
		mov	ax, 25h	; '%'
		push	ax
		call	sub_198C0
		jmp	loc_19467
; ---------------------------------------------------------------------------

loc_19556:				; CODE XREF: sub_19294+17Bj
		cmp	ax, 64h	; 'd'
		jnz	short loc_1955E
		jmp	loc_1945A
; ---------------------------------------------------------------------------

loc_1955E:				; CODE XREF: sub_19294+2C5j
		cmp	ax, 65h	; 'e'
		jl	short loc_19568
		cmp	ax, 67h	; 'g'
		jle	short loc_19542

loc_19568:				; CODE XREF: sub_19294:loc_1941Aj
					; sub_19294+2CDj ...
		cmp	word_1B572, 0
		jz	short loc_19572
		mov	ax, si
		dec	si

loc_19572:				; CODE XREF: sub_19294+35j
					; sub_19294+2D9j
		mov	di, si
		jmp	short loc_195A6
; ---------------------------------------------------------------------------

loc_19576:				; CODE XREF: sub_19294+16Ej
		cmp	ax, 6Eh	; 'n'
		jnz	short loc_1957E
		jmp	loc_1941E
; ---------------------------------------------------------------------------

loc_1957E:				; CODE XREF: sub_19294+2E5j
		cmp	ax, 6Fh	; 'o'
		jnz	short loc_19586
		jmp	loc_1946C
; ---------------------------------------------------------------------------

loc_19586:				; CODE XREF: sub_19294+2EDj
		cmp	ax, 70h	; 'p'
		jnz	short loc_1958E
		jmp	loc_19472
; ---------------------------------------------------------------------------

loc_1958E:				; CODE XREF: sub_19294+2F5j
		cmp	ax, 73h	; 's'
		jz	short loc_19532
		cmp	ax, 75h	; 'u'
		jnz	short loc_1959B
		jmp	loc_19456
; ---------------------------------------------------------------------------

loc_1959B:				; CODE XREF: sub_19294+302j
		cmp	ax, 78h	; 'x'
		jz	short loc_1952C
		jmp	short loc_19568
; ---------------------------------------------------------------------------

loc_195A2:				; CODE XREF: sub_19294+1A1j
		inc	si
		jmp	short loc_195C0
; ---------------------------------------------------------------------------
		align 2

loc_195A6:				; CODE XREF: sub_19294+2E0j
					; sub_19294+31Bj
		inc	di
		cmp	byte ptr [di], 0
		jz	short loc_195B1
		cmp	byte ptr [di], 25h ; '%'
		jnz	short loc_195A6

loc_195B1:				; CODE XREF: sub_19294+316j
		mov	ax, di
		sub	ax, si
		push	ax
		push	ds
		push	si
		call	sub_1995C
		add	sp, 6
		mov	si, di

loc_195C0:				; CODE XREF: sub_19294+2Dj
					; sub_19294+30Fj
		cmp	byte ptr [si], 0
		jz	short loc_195C8
		jmp	loc_192C4
; ---------------------------------------------------------------------------

loc_195C8:				; CODE XREF: sub_19294+129j
					; sub_19294+32Fj
		cmp	word_1B580, 0
		jnz	short loc_195DC
		mov	bx, word_1B56C
		test	byte ptr [bx+6], 20h
		jz	short loc_195DC
		jmp	loc_1944F
; ---------------------------------------------------------------------------

loc_195DC:				; CODE XREF: sub_19294+1ABj
					; sub_19294+1B8j ...
		mov	ax, word_1B580

loc_195DF:				; CODE XREF: sub_19294+1BEj
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retn
sub_19294	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_195E6	proc near		; CODE XREF: sub_19294+1D0p
					; sub_19294+24Ep ...

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
		jz	short loc_195F8
		inc	word_1B57E

loc_195F8:				; CODE XREF: sub_195E6+Cj
		cmp	word_1B572, 2
		jz	short loc_19606
		cmp	word_1B572, 10h
		jnz	short loc_1961C

loc_19606:				; CODE XREF: sub_195E6+17j
		mov	bx, word_1B578
		mov	ax, [bx]
		mov	dx, [bx+2]
		mov	word ptr [bp+var_4], ax
		mov	word ptr [bp+var_4+2], dx
		add	word_1B578, 4
		jmp	short loc_19646
; ---------------------------------------------------------------------------

loc_1961C:				; CODE XREF: sub_195E6+1Ej
		cmp	word_1B57E, 0
		jz	short loc_19634
		mov	bx, word_1B578
		mov	ax, [bx]
		mov	word ptr [bp+var_4], ax
		mov	word ptr [bp+var_4+2], 0
		jmp	short loc_19641
; ---------------------------------------------------------------------------
		align 2

loc_19634:				; CODE XREF: sub_195E6+3Bj
		mov	bx, word_1B578
		mov	ax, [bx]
		cwd
		mov	word ptr [bp+var_4], ax
		mov	word ptr [bp+var_4+2], dx

loc_19641:				; CODE XREF: sub_195E6+4Bj
		add	word_1B578, 2

loc_19646:				; CODE XREF: sub_195E6+34j
		cmp	word_1B56A, 0
		jz	short loc_1965A
		mov	ax, word ptr [bp+var_4]
		or	ax, word ptr [bp+var_4+2]
		jz	short loc_1965A
		mov	ax, [bp+arg_0]
		jmp	short loc_1965C
; ---------------------------------------------------------------------------

loc_1965A:				; CODE XREF: sub_195E6+65j
					; sub_195E6+6Dj
		sub	ax, ax

loc_1965C:				; CODE XREF: sub_195E6+72j
		mov	word_1B58C, ax
		mov	si, word_1B588
		cmp	word_1B57E, 0
		jnz	short loc_19694
		cmp	word ptr [bp+var_4+2], 0
		jge	short loc_19694
		cmp	[bp+arg_0], 0Ah
		jnz	short loc_1968D
		mov	byte ptr [si], 2Dh ; '-'
		inc	si
		mov	ax, word ptr [bp+var_4]
		mov	dx, word ptr [bp+var_4+2]
		neg	ax
		adc	dx, 0
		neg	dx
		mov	word ptr [bp+var_4], ax
		mov	word ptr [bp+var_4+2], dx

loc_1968D:				; CODE XREF: sub_195E6+8Ej
		mov	[bp+var_8], 1
		jmp	short loc_19699
; ---------------------------------------------------------------------------

loc_19694:				; CODE XREF: sub_195E6+82j
					; sub_195E6+88j
		mov	[bp+var_8], 0

loc_19699:				; CODE XREF: sub_195E6+ACj
		lea	ax, [bp+var_18]
		mov	di, ax
		push	[bp+arg_0]
		push	di		; char *
		push	word ptr [bp+var_4+2]
		push	word ptr [bp+var_4] ; unsigned __int32
		call	_ultoa
		add	sp, 8
		cmp	word_1B57C, 0
		jz	short loc_196D6
		push	di		; char *
		call	_strlen
		add	sp, 2
		mov	cx, word_1B584
		sub	cx, ax
		mov	[bp+var_C], cx
		jmp	short loc_196CC
; ---------------------------------------------------------------------------
		align 2

loc_196C8:				; CODE XREF: sub_195E6+EBj
		mov	byte ptr [si], 30h ; '0'
		inc	si

loc_196CC:				; CODE XREF: sub_195E6+DFj
		mov	ax, cx
		dec	cx
		or	ax, ax
		jg	short loc_196C8
		mov	[bp+var_C], cx

loc_196D6:				; CODE XREF: sub_195E6+CDj
		mov	cx, word_1B570

loc_196DA:				; CODE XREF: sub_195E6+109j
		mov	al, [di]
		mov	[si], al
		or	cx, cx
		jz	short loc_196E9
		cmp	al, 61h	; 'a'
		jl	short loc_196E9
		sub	byte ptr [si], 20h ; ' '

loc_196E9:				; CODE XREF: sub_195E6+FAj
					; sub_195E6+FEj
		inc	si
		inc	di
		cmp	byte ptr [di-1], 0
		jnz	short loc_196DA
		cmp	word_1B57E, 0
		jnz	short loc_1970C
		mov	ax, word_1B574
		or	ax, word_1B57A
		jz	short loc_1970C
		cmp	[bp+var_8], 0
		jnz	short loc_1970C
		mov	ax, 1
		jmp	short loc_1970E
; ---------------------------------------------------------------------------

loc_1970C:				; CODE XREF: sub_195E6+110j
					; sub_195E6+119j ...
		sub	ax, ax

loc_1970E:				; CODE XREF: sub_195E6+124j
		push	ax
		call	sub_199C4
		add	sp, 2
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retn
sub_195E6	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1971C	proc near		; CODE XREF: sub_19294+2A1p

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
		jz	short loc_1973E
		mov	si, 1
		mov	ax, word_1B578
		mov	[bp+var_8], ax
		mov	[bp+var_6], ds
		add	word_1B578, 2
		jmp	loc_197CF
; ---------------------------------------------------------------------------

loc_1973E:				; CODE XREF: sub_1971C+Cj
		cmp	word_1B572, 10h
		jnz	short loc_1975C
		mov	bx, word_1B578
		mov	ax, [bx]
		mov	dx, [bx+2]
		mov	[bp+var_8], ax
		mov	[bp+var_6], dx
		add	word_1B578, 4
		jmp	short loc_19770
; ---------------------------------------------------------------------------
		align 2

loc_1975C:				; CODE XREF: sub_1971C+27j
		mov	bx, word_1B578
		mov	ax, [bx]
		mov	[bp+var_4], ax
		mov	[bp+var_8], ax
		mov	[bp+var_6], ds
		add	word_1B578, 2

loc_19770:				; CODE XREF: sub_1971C+3Dj
		cmp	word_1B572, 10h
		jnz	short loc_19784
		mov	ax, [bp+var_8]
		or	ax, [bp+var_6]
		jnz	short loc_19793
		mov	ax, 0DECh
		jmp	short loc_1978D
; ---------------------------------------------------------------------------

loc_19784:				; CODE XREF: sub_1971C+59j
		cmp	[bp+var_4], 0
		jnz	short loc_19793
		mov	ax, 0DF3h

loc_1978D:				; CODE XREF: sub_1971C+66j
		mov	[bp+var_8], ax
		mov	[bp+var_6], ds

loc_19793:				; CODE XREF: sub_1971C+61j
					; sub_1971C+6Cj
		mov	ax, [bp+var_8]
		mov	dx, [bp+var_6]
		mov	word ptr [bp+var_E], ax
		mov	word ptr [bp+var_E+2], dx
		sub	si, si
		cmp	word_1B57C, si
		jz	short loc_197C3
		mov	cx, word_1B584
		jmp	short loc_197BB
; ---------------------------------------------------------------------------
		align 2

loc_197AE:				; CODE XREF: sub_1971C+A3j
		les	bx, [bp+var_E]
		inc	word ptr [bp+var_E]
		cmp	byte ptr es:[bx], 0
		jz	short loc_197CF
		inc	si

loc_197BB:				; CODE XREF: sub_1971C+8Fj
		cmp	cx, si
		jle	short loc_197CF
		jmp	short loc_197AE
; ---------------------------------------------------------------------------
		align 2

loc_197C2:				; CODE XREF: sub_1971C+B1j
		inc	si

loc_197C3:				; CODE XREF: sub_1971C+89j
		les	bx, [bp+var_E]
		inc	word ptr [bp+var_E]
		cmp	byte ptr es:[bx], 0
		jnz	short loc_197C2

loc_197CF:				; CODE XREF: sub_1971C+1Fj
					; sub_1971C+9Cj ...
		mov	di, word_1B58A
		sub	di, si
		cmp	word_1B576, 0
		jnz	short loc_197E3
		push	di
		call	sub_198FE
		add	sp, 2

loc_197E3:				; CODE XREF: sub_1971C+BEj
		push	si
		push	[bp+var_6]
		push	[bp+var_8]
		call	sub_1995C
		add	sp, 6
		cmp	word_1B576, 0
		jz	short loc_197FE
		push	di
		call	sub_198FE
		add	sp, 2

loc_197FE:				; CODE XREF: sub_1971C+D9j
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retn
sub_1971C	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: noreturn bp-based	frame

sub_19804	proc near		; CODE XREF: sub_19294+2B2p

var_4		= byte ptr -4
var_2		= word ptr -2
arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		sub	sp, 4
		mov	ax, word_1B578
		mov	[bp+var_2], ax
		cmp	[bp+arg_0], 67h	; 'g'
		jz	short loc_1981C
		cmp	[bp+arg_0], 47h	; 'G'
		jnz	short loc_19820

loc_1981C:				; CODE XREF: sub_19804+10j
		mov	al, 1
		jmp	short loc_19822
; ---------------------------------------------------------------------------

loc_19820:				; CODE XREF: sub_19804+16j
		sub	al, al

loc_19822:				; CODE XREF: sub_19804+1Aj
		mov	[bp+var_4], al
		cmp	word_1B57C, 0
		jnz	short loc_19832
		mov	word_1B584, 6

loc_19832:				; CODE XREF: sub_19804+26j
		cmp	[bp+var_4], 0
		jz	short loc_19845
		cmp	word_1B584, 0
		jnz	short loc_19845
		mov	word_1B584, 1

loc_19845:				; CODE XREF: sub_19804+32j
					; sub_19804+39j
		push	word_1B570
		push	word_1B584
		push	[bp+arg_0]
		push	word_1B588
		push	[bp+var_2]
		call	off_1B468
sub_19804	endp ; sp-analysis failed

		add	sp, 0Ah
		cmp	byte ptr [bp-4], 0
		jz	short loc_19876
		cmp	word_1B56A, 0
		jnz	short loc_19876
		push	word_1B588
		call	off_1B46A
		add	sp, 2

loc_19876:				; CODE XREF: seg000:9862j seg000:9869j
		cmp	word_1B56A, 0
		jz	short loc_1988F
		cmp	word_1B584, 0
		jnz	short loc_1988F
		push	word_1B588
		call	off_1B46E
		add	sp, 2

loc_1988F:				; CODE XREF: seg000:987Bj seg000:9882j
		add	word_1B578, 8
		mov	word_1B58C, 0
		mov	ax, word_1B574
		or	ax, word_1B57A
		jz	short loc_198B6
		push	word ptr [bp-2]
		call	off_1B470
		add	sp, 2
		or	ax, ax
		jz	short loc_198B6
		mov	ax, 1
		jmp	short loc_198B8
; ---------------------------------------------------------------------------

loc_198B6:				; CODE XREF: seg000:98A1j seg000:98AFj
		sub	ax, ax

loc_198B8:				; CODE XREF: seg000:98B4j
		push	ax
		call	sub_199C4
		mov	sp, bp
		pop	bp
		retn

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_198C0	proc near		; CODE XREF: sub_19294+258p
					; sub_19294+2BCp ...

arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		push	si
		cmp	word_1B582, 0
		jnz	short loc_198FA
		mov	bx, word_1B56C
		dec	word ptr [bx+2]
		js	short loc_198E2
		mov	al, byte ptr [bp+arg_0]
		mov	si, [bx]
		inc	word ptr [bx]
		mov	[si], al
		sub	ah, ah
		jmp	short loc_198EC
; ---------------------------------------------------------------------------
		align 2

loc_198E2:				; CODE XREF: sub_198C0+12j
		push	bx		; FILE *
		push	[bp+arg_0]	; int
		call	__flsbuf
		add	sp, 4

loc_198EC:				; CODE XREF: sub_198C0+1Fj
		inc	ax
		jnz	short loc_198F6
		inc	word_1B582
		jmp	short loc_198FA
; ---------------------------------------------------------------------------
		align 2

loc_198F6:				; CODE XREF: sub_198C0+2Dj
		inc	word_1B580

loc_198FA:				; CODE XREF: sub_198C0+9j
					; sub_198C0+33j
		pop	si
		pop	bp
		retn
sub_198C0	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_198FE	proc near		; CODE XREF: sub_1971C+C1p
					; sub_1971C+DCp ...

arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	di
		push	si
		cmp	word_1B582, 0
		jnz	short loc_19956
		mov	si, [bp+arg_0]
		or	si, si
		jle	short loc_19956
		jmp	short loc_1992B
; ---------------------------------------------------------------------------

loc_19916:				; CODE XREF: sub_198FE+3Bj
		push	word_1B56C	; FILE *
		push	word_1B58E	; int
		call	__flsbuf
		add	sp, 4

loc_19924:				; CODE XREF: sub_198FE+48j
		inc	ax
		jnz	short loc_1992B
		inc	word_1B582

loc_1992B:				; CODE XREF: sub_198FE+16j
					; sub_198FE+27j
		mov	ax, si
		dec	si
		or	ax, ax
		jle	short loc_19948
		mov	bx, word_1B56C
		dec	word ptr [bx+2]
		js	short loc_19916
		mov	al, byte ptr word_1B58E
		mov	di, [bx]
		inc	word ptr [bx]
		mov	[di], al
		sub	ah, ah
		jmp	short loc_19924
; ---------------------------------------------------------------------------

loc_19948:				; CODE XREF: sub_198FE+32j
		cmp	word_1B582, 0
		jnz	short loc_19956
		mov	ax, [bp+arg_0]
		add	word_1B580, ax

loc_19956:				; CODE XREF: sub_198FE+Dj
					; sub_198FE+14j ...
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retn
sub_198FE	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_1995C	proc near		; CODE XREF: sub_19294+324p
					; sub_1971C+CEp ...

arg_0		= dword	ptr  4
arg_4		= word ptr  8

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	di
		push	si
		mov	si, [bp+arg_4]
		cmp	word_1B582, 0
		jnz	short loc_199BE
		jmp	short loc_1998C
; ---------------------------------------------------------------------------

loc_19970:				; CODE XREF: sub_1995C+3Ej
		push	word_1B56C	; FILE *
		les	bx, [bp+arg_0]
		mov	al, es:[bx]
		cbw
		push	ax		; int
		call	__flsbuf
		add	sp, 4

loc_19982:				; CODE XREF: sub_1995C+52j
		inc	ax
		jnz	short loc_19989
		inc	word_1B582

loc_19989:				; CODE XREF: sub_1995C+27j
		inc	word ptr [bp+arg_0]

loc_1998C:				; CODE XREF: sub_1995C+12j
		mov	ax, si
		dec	si
		or	ax, ax
		jz	short loc_199B0
		mov	bx, word_1B56C
		dec	word ptr [bx+2]
		js	short loc_19970
		les	bx, [bp+arg_0]
		mov	al, es:[bx]
		mov	bx, word_1B56C
		mov	di, [bx]
		inc	word ptr [bx]
		mov	[di], al
		sub	ah, ah
		jmp	short loc_19982
; ---------------------------------------------------------------------------

loc_199B0:				; CODE XREF: sub_1995C+35j
		cmp	word_1B582, 0
		jnz	short loc_199BE
		mov	ax, [bp+arg_4]
		add	word_1B580, ax

loc_199BE:				; CODE XREF: sub_1995C+10j
					; sub_1995C+59j
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retn
sub_1995C	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_199C4	proc near		; CODE XREF: sub_195E6+129p
					; seg000:98B9p

var_8		= word ptr -8
var_6		= word ptr -6
var_4		= word ptr -4
arg_0		= word ptr  4

		push	bp
		mov	bp, sp
		sub	sp, 0Ah
		push	di
		push	si
		mov	si, word_1B588
		sub	ax, ax
		mov	[bp+var_4], ax
		mov	[bp+var_6], ax
		cmp	word_1B58E, 30h	; '0'
		jnz	short loc_199F7
		cmp	word_1B57C, ax
		jz	short loc_199F7
		cmp	word_1B56E, ax
		jz	short loc_199F1
		cmp	word_1B586, ax
		jnz	short loc_199F7

loc_199F1:				; CODE XREF: sub_199C4+25j
		mov	word_1B58E, 20h	; ' '

loc_199F7:				; CODE XREF: sub_199C4+19j
					; sub_199C4+1Fj ...
		mov	di, word_1B58A
		push	si		; char *
		call	_strlen
		add	sp, 2
		mov	[bp+var_8], ax
		sub	di, ax
		sub	di, [bp+arg_0]
		cmp	word_1B576, 0
		jnz	short loc_19A29
		cmp	byte ptr [si], 2Dh ; '-'
		jnz	short loc_19A29
		cmp	word_1B58E, 30h	; '0'
		jnz	short loc_19A29
		lodsb
		cbw
		push	ax
		call	sub_198C0
		add	sp, 2
		dec	[bp+var_8]

loc_19A29:				; CODE XREF: sub_199C4+4Bj
					; sub_199C4+50j ...
		cmp	word_1B58E, 30h	; '0'
		jz	short loc_19A3B
		or	di, di
		jle	short loc_19A3B
		cmp	word_1B576, 0
		jz	short loc_19A54

loc_19A3B:				; CODE XREF: sub_199C4+6Aj
					; sub_199C4+6Ej
		cmp	[bp+arg_0], 0
		jz	short loc_19A47
		inc	[bp+var_6]
		call	sub_19AA6

loc_19A47:				; CODE XREF: sub_199C4+7Bj
		cmp	word_1B58C, 0
		jz	short loc_19A54
		inc	[bp+var_4]
		call	sub_19ABE

loc_19A54:				; CODE XREF: sub_199C4+75j
					; sub_199C4+88j
		cmp	word_1B576, 0
		jnz	short loc_19A81
		push	di
		call	sub_198FE
		add	sp, 2
		cmp	[bp+arg_0], 0
		jz	short loc_19A71
		cmp	[bp+var_6], 0
		jnz	short loc_19A71
		call	sub_19AA6

loc_19A71:				; CODE XREF: sub_199C4+A2j
					; sub_199C4+A8j
		cmp	word_1B58C, 0
		jz	short loc_19A81
		cmp	[bp+var_4], 0
		jnz	short loc_19A81
		call	sub_19ABE

loc_19A81:				; CODE XREF: sub_199C4+95j
					; sub_199C4+B2j ...
		push	[bp+var_8]
		push	ds
		push	si
		call	sub_1995C
		add	sp, 6
		cmp	word_1B576, 0
		jz	short loc_19AA0
		mov	word_1B58E, 20h	; ' '
		push	di
		call	sub_198FE
		add	sp, 2

loc_19AA0:				; CODE XREF: sub_199C4+CDj
		pop	si
		pop	di
		mov	sp, bp
		pop	bp
		retn
sub_199C4	endp


; =============== S U B	R O U T	I N E =======================================


sub_19AA6	proc near		; CODE XREF: sub_199C4+80p
					; sub_199C4+AAp
		cmp	word_1B574, 0
		jz	short loc_19AB2
		mov	ax, 2Bh	; '+'
		jmp	short loc_19AB5
; ---------------------------------------------------------------------------

loc_19AB2:				; CODE XREF: sub_19AA6+5j
		mov	ax, 20h	; ' '

loc_19AB5:				; CODE XREF: sub_19AA6+Aj
		push	ax
		call	sub_198C0
		add	sp, 2
		retn
sub_19AA6	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_19ABE	proc near		; CODE XREF: sub_199C4+8Dp
					; sub_199C4+BAp
		mov	ax, 30h	; '0'
		push	ax
		call	sub_198C0
		add	sp, 2
		cmp	word_1B58C, 10h
		jnz	short locret_19AE6
		cmp	word_1B570, 0
		jz	short loc_19ADC
		mov	ax, 58h	; 'X'
		jmp	short loc_19ADF
; ---------------------------------------------------------------------------
		align 2

loc_19ADC:				; CODE XREF: sub_19ABE+16j
		mov	ax, 78h	; 'x'

loc_19ADF:				; CODE XREF: sub_19ABE+1Bj
		push	ax
		call	sub_198C0
		add	sp, 2

locret_19AE6:				; CODE XREF: sub_19ABE+Fj
		retn
sub_19ABE	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_19AE8	proc near		; CODE XREF: sub_19294+B7p
					; sub_19294+E1p

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
		jnz	short loc_19B0C
		mov	bx, word_1B578
		mov	di, [bx]
		add	word_1B578, 2
		inc	si
		jmp	short loc_19B53
; ---------------------------------------------------------------------------
		align 2

loc_19B0C:				; CODE XREF: sub_19AE8+13j
		cmp	byte ptr [si], 2Dh ; '-'
		jnz	short loc_19B17
		mov	[bp+var_2], 0FFFFh
		inc	si

loc_19B17:				; CODE XREF: sub_19AE8+27j
		sub	di, di
		cmp	byte ptr [si], 30h ; '0'
		jl	short loc_19B53
		cmp	byte ptr [si], 39h ; '9'
		jg	short loc_19B53
		cmp	word_1B57C, di
		jnz	short loc_19B34
		cmp	byte ptr [si], 30h ; '0'
		jnz	short loc_19B34
		mov	word_1B58E, 30h	; '0'

loc_19B34:				; CODE XREF: sub_19AE8+3Fj
					; sub_19AE8+44j ...
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
		jl	short loc_19B53
		cmp	byte ptr [si], 39h ; '9'
		jle	short loc_19B34

loc_19B53:				; CODE XREF: sub_19AE8+21j
					; sub_19AE8+34j ...
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
sub_19AE8	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_19B68	proc near		; CODE XREF: sub_19294+A8p

arg_0		= byte ptr  4

		push	bp
		mov	bp, sp
		sub	sp, 2
		push	si
		mov	si, 0DFAh
		mov	cl, [bp+arg_0]
		jmp	short loc_19B79
; ---------------------------------------------------------------------------
		align 2

loc_19B78:				; CODE XREF: sub_19B68+18j
		inc	si

loc_19B79:				; CODE XREF: sub_19B68+Dj
		cmp	byte ptr [si], 0
		jz	short loc_19B88
		cmp	cl, [si]
		jnz	short loc_19B78
		mov	ax, 1
		jmp	short loc_19B8A
; ---------------------------------------------------------------------------
		align 2

loc_19B88:				; CODE XREF: sub_19B68+14j
		sub	ax, ax

loc_19B8A:				; CODE XREF: sub_19B68+1Dj
		pop	si
		mov	sp, bp
		pop	bp
		retn
sub_19B68	endp

; ---------------------------------------------------------------------------
		align 2
; [0000003A BYTES: COLLAPSED FUNCTION __getstream. PRESS KEYPAD	"+" TO EXPAND]
; [00000028 BYTES: COLLAPSED FUNCTION _fputc. PRESS KEYPAD "+" TO EXPAND]
; [00000020 BYTES: COLLAPSED FUNCTION _fgetc. PRESS KEYPAD "+" TO EXPAND]
; [00000020 BYTES: COLLAPSED FUNCTION _close. PRESS KEYPAD "+" TO EXPAND]
; [0000007A BYTES: COLLAPSED FUNCTION _lseek. PRESS KEYPAD "+" TO EXPAND]
; [00000193 BYTES: COLLAPSED FUNCTION _open. PRESS KEYPAD "+" TO EXPAND]
; [00000011 BYTES: COLLAPSED FUNCTION __cXENIXtoDOSmode. PRESS KEYPAD "+" TO EXPAND]
; [000000DD BYTES: COLLAPSED FUNCTION _read. PRESS KEYPAD "+" TO EXPAND]
		align 2
; [000000A6 BYTES: COLLAPSED FUNCTION _write. PRESS KEYPAD "+" TO EXPAND]
; [0000004E BYTES: COLLAPSED FUNCTION sub_19FD4. PRESS KEYPAD "+" TO EXPAND]
; ---------------------------------------------------------------------------
; [00000034 BYTES: COLLAPSED CHUNK OF FUNCTION _write. PRESS KEYPAD "+"	TO EXPAND]
; [00000012 BYTES: COLLAPSED FUNCTION _stackavail. PRESS KEYPAD	"+" TO EXPAND]
; [00000012 BYTES: COLLAPSED FUNCTION unknown_libname_1. PRESS KEYPAD "+" TO EXPAND]
; [00000046 BYTES: COLLAPSED FUNCTION unknown_libname_2. PRESS KEYPAD "+" TO EXPAND]
; [00000015 BYTES: COLLAPSED FUNCTION __ffree. PRESS KEYPAD "+"	TO EXPAND]
; [0000003D BYTES: COLLAPSED FUNCTION __fmalloc. PRESS KEYPAD "+" TO EXPAND]
; [0000006C BYTES: COLLAPSED FUNCTION sub_1A112. PRESS KEYPAD "+" TO EXPAND]
; [00000017 BYTES: COLLAPSED FUNCTION sub_1A17E. PRESS KEYPAD "+" TO EXPAND]
		align 2
; [00000003 BYTES: COLLAPSED CHUNK OF FUNCTION __amalloc. PRESS	KEYPAD "+" TO EXPAND]
; [000000E3 BYTES: COLLAPSED FUNCTION __amalloc. PRESS KEYPAD "+" TO EXPAND]
; [0000003A BYTES: COLLAPSED FUNCTION __amexpand. PRESS	KEYPAD "+" TO EXPAND]
; [00000022 BYTES: COLLAPSED FUNCTION __amlink.	PRESS KEYPAD "+" TO EXPAND]
; [0000001F BYTES: COLLAPSED FUNCTION __amallocbrk. PRESS KEYPAD "+" TO	EXPAND]
		align 2
; [0000006E BYTES: COLLAPSED FUNCTION _brkctl. PRESS KEYPAD "+"	TO EXPAND]
; [00000056 BYTES: COLLAPSED FUNCTION sub_1A366. PRESS KEYPAD "+" TO EXPAND]
; [0000003F BYTES: COLLAPSED FUNCTION _strcat. PRESS KEYPAD "+"	TO EXPAND]
		align 2
; [00000032 BYTES: COLLAPSED FUNCTION _strcpy. PRESS KEYPAD "+"	TO EXPAND]
; [0000001B BYTES: COLLAPSED FUNCTION _strlen. PRESS KEYPAD "+"	TO EXPAND]
		align 2
; [0000001B BYTES: COLLAPSED FUNCTION _itoa. PRESS KEYPAD "+" TO EXPAND]
		align 2
; [0000000A BYTES: COLLAPSED FUNCTION _ultoa. PRESS KEYPAD "+" TO EXPAND]
; [00000023 BYTES: COLLAPSED FUNCTION _isatty. PRESS KEYPAD "+"	TO EXPAND]
		align 2
; [00000056 BYTES: COLLAPSED FUNCTION _sprintf.	PRESS KEYPAD "+" TO EXPAND]
; [0000000E BYTES: COLLAPSED FUNCTION _outp. PRESS KEYPAD "+" TO EXPAND]
; ---------------------------------------------------------------------------
; [0000000C BYTES: COLLAPSED CHUNK OF FUNCTION _ultoa. PRESS KEYPAD "+"	TO EXPAND]
; [00000053 BYTES: COLLAPSED CHUNK OF FUNCTION _itoa. PRESS KEYPAD "+" TO EXPAND]
		align 2
; [0000000D BYTES: COLLAPSED FUNCTION _remove. PRESS KEYPAD "+"	TO EXPAND]
		align 2
; [0000009C BYTES: COLLAPSED FUNCTION __aNldiv.	PRESS KEYPAD "+" TO EXPAND]
; [00000034 BYTES: COLLAPSED FUNCTION __aNlmul.	PRESS KEYPAD "+" TO EXPAND]
		align 10h
seg000		ends

; ===========================================================================

; Segment type:	Regular
seg001		segment	byte public 'UNK' use16
		assume cs:seg001
		assume es:nothing, ss:nothing, ds:dseg,	fs:nothing, gs:nothing
		db 0
		db 0
byte_1A642	db 0			; DATA XREF: sub_14270+148r
					; sub_144C9+141r
byte_1A643	db 0			; DATA XREF: sub_14270+15Ar
					; sub_144C9+153r
word_1A644	dw 0			; DATA XREF: sub_14270+143r
					; sub_144C9+13Cr
word_1A646	dw 0			; DATA XREF: sub_14270+155r
					; sub_144C9+14Er
		align 10h
seg001		ends

; ===========================================================================

; Segment type:	Pure data
dseg		segment	para public 'DATA' use16
		assume cs:dseg
word_1A650	dw 0			; DATA XREF: sub_1A112+56w
word_1A652	dw 0			; DATA XREF: start+50w	sub_1A112+59w
		db 0
		db 0
word_1A656	dw 0			; DATA XREF: sub_1A112+65w
word_1A658	dw 534Dh		; DATA XREF: sub_1A112+41w
					; sub_1A112+4Bw
word_1A65A	dw 5220h		; DATA XREF: sub_1A112+5Fw
		db 75h,	6Eh, 2Dh, 54h, 69h, 6Dh, 65h, 20h, 4Ch,	69h, 62h
		db 72h,	61h, 72h, 79h, 20h, 2Dh, 20h, 43h, 6Fh,	70h, 79h
		db 72h,	69h, 67h, 68h, 74h, 20h, 28h, 63h, 29h,	20h
word_1A67C	dw 3931h		; DATA XREF: __setenvp+11r
byte_1A67E	db 38h,	38h, 2Ch, 20h, 4Dh, 69h, 63h, 72h, 6Fh,	73h, 6Fh
					; DATA XREF: ExecuteScript+48o
		db 66h,	74h, 20h, 43h, 6Fh, 72h, 70h, 11h, 0
byte_1A692	db '#','A','i','c','a',  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0; 0
		db '#','A','i','c','a','2',  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0; 20
		db '#','A','n','i','m','e',  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0; 40
		db '#','C','o','m',  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0; 60
		db '#','C','o','m','E','n','d',  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0; 80
		db '#','C','o','m','T','o','o','l',  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0; 100
		db '#','C','o','m','S','t','a','r','t',  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0; 120
		db '#','G','o','s','u','b',  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0; 140
		db '#','G','o','t','o',  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0; 160
		db '#','G','r','d','L','o','a','d',  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0; 180
		db '#','I','f',  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0; 200
		db '#','E','l','s','e','I','f',  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0; 220
		db '#','E','n','d','I','f',  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0; 240
		db '#','I','n','t','L','o','a','d',  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0; 260
		db '#','K','a','n','i','m',  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0; 280
		db '#','K','a','n','i','m','2',  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0; 300
		db '#','L','a','b','e','l',  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0; 320
		db '#','M','u','s','i','c',  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0; 340
		db '#','P','r','g','r',  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0; 360
		db '#','P','c','g','L','o','a','d',  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0; 380
		db '#','P','r','i','n','t',  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0; 400
		db '#','Q','e','s',  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0; 420
		db '#','Q','e','s','E','n','d',  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0; 440
		db '#','Q','e','s','E','x','i','t',  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0; 460
		db '#','Q','e','s','L','o','a','d',  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0; 480
		db '#','Q','e','s','M','u','s',  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0; 500
		db '#','Q','e','s','R','e','t',  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0; 520
		db '#','Q','e','s','O','f','f',  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0; 540
		db '#','Q','e','s','S','t','a','r','t',  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0; 560
		db '#','R','e','t','u','r','n',  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0; 580
		db '#','R','n','d',  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0; 600
		db '#','S','c','e','n','e',  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0; 620
		db '#','S','c','e','n','e','M',  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0; 640
		db '#','S','c','r','C','o','p','y',  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0; 660
		db '#','S','c','r','E','r','a',  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0; 680
		db '#','S','c','r','o','l','l',  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0; 700
		db '#','S','c','r','S','w','t',  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0; 720
		db '#','S','e','r','i',  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0; 740
		db '#','S','e','r','i','2',  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0; 760
		db '#','T','a','n','i','m',  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0; 780
		db '#','T','a','n','i','m','2',  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0; 800
		db '#','W','a','i','t',  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0; 820
		db '#','W','i','p','e',  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0; 840
		db '#','S','w','D','e','f',  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0; 860
		db '#','S','w','V','a','r',  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0; 880
		db '#','S','w','A','d','d',  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0; 900
		db '#','S','w','D','e','c',  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0; 920
		db '#','S','w','G','o','t','o',  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0; 940
		db '#','S','u','b',  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0; 960
		db '#','S','u','b','E','n','d',  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0; 980
		db '#','L','b','F','l','a','s','h',  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0; 1000
		db '#','A','n','o','t','h','e','r',  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0; 1020
		db '#','J','u','m','p',  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0; 1040
		db '#','L','l','a','b','e','l',  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0; 1060
		db '#','P','a','l',  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0; 1080
		db '#','P','a','l','S','e','t',  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0; 1100
		db '#','C','l','e','a','r','F','r','a','m','e',  0,  0,  0,  0,  0,  0,  0,  0,  0; 1120
		db '#','P','K','s','c','r','o','l','l',  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0; 1140
		db '#','S','c','e','L','o','a','d',  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0; 1160
		db '#','E','n','d',  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0; 1180
word_1AB42	dw 0			; DATA XREF: sub_10A4B+6Bw
					; sub_11D81:loc_11D8Ew	...
word_1AB44	dw 0			; DATA XREF: sub_10819:loc_10889w
					; sub_10819:loc_10901r	...
word_1AB46	dw 0			; DATA XREF: sub_143EC:loc_1440Dr
					; sub_143EC+38w ...
debugMode	dw 0			; DATA XREF: ScrData_Str2Buf+9r
					; ScrData_GetStr+16r ...
GDCPlaneWrt	dw 0			; DATA XREF: SetGDCPlane_Wrt+Br
					; SwapGDCPlanes+8w ...
word_1AB4C	dw 0			; DATA XREF: ExecuteScript:loc_124C2r
					; ExecuteScript:loc_124EFw ...
word_1AB4E	dw 0			; DATA XREF: ExecuteScript+498r
					; ExecuteScript+8FAw ...
scrStackIdx	dw 0			; DATA XREF: sub_103B0+17w scrCall+8r	...
word_1AB52	dw 1			; DATA XREF: ExecuteScript:loc_12FF8w
					; ExecuteScript:loc_13001w ...
bgmIsPlaying	dw 0			; DATA XREF: ExecuteScript:scr20_Location0w
					; ExecuteScript:scr21_Location1w ...
					; 0 = not playing, needs restart, 1 = no restart needed
word_1AB56	dw 0			; DATA XREF: ExecuteScript+7EBw
					; sub_143EC+3Bw ...
word_1AB58	dw 0			; DATA XREF: ExecuteScript+7E8w
					; sub_143EC+63r
word_1AB5A	dw 0			; DATA XREF: ExecuteScript+7F4w
					; sub_143EC+17r ...
stopDialogDraw	dw 0			; DATA XREF: ExecuteScript:scriptMainLoopr
					; ExecuteScript+17w ...
word_1AB5E	dw 4			; DATA XREF: sub_13505+10r
					; sub_13505:loc_1378Br	...
word_1AB60	dw 2Eh			; DATA XREF: sub_13505+Cr
					; sub_13AFC+2Cw ...
PalCurrent	db    0,   0,	0	; DATA XREF: Palette_SetGDC+82o
					; PaletteCur2GDC+49r ...
		db    5,   2,	0
		db    8,   4,	0
		db  0Ah,   6,	2
		db  0Ch,   8,	3
		db  0Eh, 0Ah,	6
		db  0Fh, 0Dh, 0Ah
		db  0Fh, 0Fh, 0Fh
		db  0Fh, 0Fh, 0Fh
		db  0Fh, 0Fh, 0Fh
		db  0Fh,   0,	0
		db    0,   0, 0Fh
		db  0Fh, 0Fh, 0Fh
		db  0Fh, 0Fh, 0Fh
		db  0Fh,   0,	0
		db    0,   0, 0Fh
aDClear_pbd	db 'd:clear.pbd',0      ; DATA XREF: LoadClearPBD+10o
		db    0
		db    0
aStr		db ' str ',0            ; DATA XREF: ScrData_Str2Buf+10o
aStr_0		db ' str ',0            ; DATA XREF: ScrData_GetStr+1Do
aND		db ' n%d ',0            ; DATA XREF: ScrData_GetByte+21o
aND_0		db ' n%d ',0            ; DATA XREF: ScrData_GetInt+33o
aS_sd		db '%s.sd',0            ; DATA XREF: sub_103B0+27o
aCS_sd		db 'c:%s.sd',0          ; DATA XREF: sub_103B0+3Ao
aCut_pbd_0	db 'cut.pbd',0          ; DATA XREF: ReadSaveGame+10o
aACut_pbd_0	db 'a:cut.pbd',0        ; DATA XREF: ReadSaveGame:loc_10430o
aRb_1		db 'rb',0               ; DATA XREF: ReadSaveGame:loc_1043Eo
aCut_pbd	db 'cut.pbd',0          ; DATA XREF: WriteSaveGame+31o
aACut_pbd	db 'a:cut.pbd',0        ; DATA XREF: WriteSaveGame:loc_104CCo
aWb		db 'wb',0               ; DATA XREF: WriteSaveGame:loc_104DAo
word_1ABF0	dw 1111			; DATA XREF: sub_10522+Br
					; sub_10522+12w ...
byte_1ABF2	db 0, 0, 0, 0, 4, 0, 0,	0, 0 ; DATA XREF: sub_106F6+63o
					; sub_10819+67o
		db 0, 0, 0, 4, 3, 4, 0,	0, 0
		db 0, 0, 4, 3, 2, 3, 4,	0, 0
		db 0, 4, 3, 2, 1, 2, 3,	4, 0
		db 4, 3, 2, 1, 0, 1, 2,	3, 4
		db 0, 4, 3, 2, 1, 2, 3,	4, 0
		db 0, 0, 4, 3, 2, 3, 4,	0, 0
		db 0, 0, 0, 4, 3, 4, 0,	0, 0
		db 0, 0, 0, 0
byte_1AC3E	db 4			; DATA XREF: sub_10A4B+125r
byte_1AC3F	db 0			; DATA XREF: sub_10A4B+F1r
byte_1AC40	db 0			; DATA XREF: sub_10A4B+191r
		db 0
		db 0
byte_1AC43	db 0			; DATA XREF: sub_10A4B:loc_10B0Er
					; sub_10A4B+13Er ...
byte_1AC44	db 0			; DATA XREF: sub_106F6+Er
					; sub_106F6+82r ...
byte_1AC45	db 0			; DATA XREF: sub_10A4B+DAr
					; sub_10A4B+1AAr ...
		db 0
		db 0
byte_1AC48	db 0			; DATA XREF: sub_10A4B+15Br
byte_1AC49	db 0			; DATA XREF: sub_10A4B+108r
byte_1AC4A	db 0			; DATA XREF: sub_10A4B+1C7r
		db 13h dup(0)
byte_1AC5E	db 10, 6, 11, 16, 2, 7,	8, 13, 12, 17, 22, 18, 14, 0, 15
					; DATA XREF: sub_10A07+2Cr
		db 0, 0, 15, 13, 0, 14,	9, 4, 13, 0, 7,	0, 12, 1, 8, 13
		db 8, 0, 12, 10, 8, 8, 15, 8, 8, 8, 13,	8, 13, 13, 0, 13
		db 8, 0, 13, 0,	0, 15, 0
word_1AC94	dw 0			; DATA XREF: sub_106F6+Ar sub_10819+Er ...
		dw 0, 0A800h
		dw 0, 0B000h
		dw 0, 0B800h
		dw 0, 0E000h
word_1ACA6	dw 3920h		; DATA XREF: sub_1098C+5Fr
word_1ACA8	dw 0			; DATA XREF: sub_10A07+3Bw
					; sub_10A4B+1F7r
word_1ACAA	dw 0			; DATA XREF: sub_10A4B:loc_10C38r
					; ExecuteScript:loc_12A1Dw ...
a3d3d3d3d	db 0Ah			; DATA XREF: sub_10D6C+174o
		db '(%3d,%3d)-(%3d,%3d)',0Ah,0
byte_1ACC2	db 81h,	9Bh, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0
					; DATA XREF: sub_10EF9+36o
		db 0, 0, 0, 0
curSelectID	dw 0			; DATA XREF: sub_11246+8w sub_11258+8r ...
		db 0, 0, 0, 0, 0, 0, 0,	0
		dw 3, 0, 0, 2, 4
aTipDDDD	db 'tip %d,%d,%d,%d',0Ah,0 ; DATA XREF: sub_1160E+37o
		db 0
word_1ACFC	dw 0			; DATA XREF: sub_118DA+1Dr
					; sub_118DA:loc_11C3Dw	...
word_1ACFE	dw 0			; DATA XREF: sub_118DA+31r
					; sub_118DA+35Fw ...
word_1AD00	dw 0			; DATA XREF: sub_118DA+37r
					; sub_118DA:loc_11C28w	...
word_1AD02	dw 0			; DATA XREF: sub_118DA:loc_11901r
					; sub_11C4E+86w
word_1AD04	dw 3			; DATA XREF: sub_11CDB+32w
					; sub_11CDB+45w ...
word_1AD06	dw 3			; DATA XREF: sub_11CDB+36w
					; sub_11CDB+49w ...
aS		db '%s ',0              ; DATA XREF: ExecuteScript+4Co
aAllendflagOn	db 0Ah			; DATA XREF: ExecuteScript+70o
		db 'AllEndFlag ON',0Ah,0
aReaderrFlagOn	db 0Ah			; DATA XREF: ExecuteScript+AFo
		db 'ReadErr Flag ON',0Ah,0
aM2d		db ' m=%2d ',0          ; DATA XREF: ExecuteScript+2FEo
a04x		db '<%04x>',0           ; DATA XREF: ExecuteScript+334o
aSw2d		db ' sw[%2d] ',0        ; DATA XREF: ExecuteScript+351o
aNoQessoffBefor	db 0Ah			; DATA XREF: ExecuteScript+42Do
		db 'no QessOff befor qesStart',0Ah,0
aDKasuke_pbd	db 'd:kasuke.pbd',0     ; DATA XREF: ExecuteScript+4A1o
aNotDefineFunct	db 0Ah			; DATA XREF: ExecuteScript+75Do
		db 'Not Define Function code=%d:%x',0Ah,0
a2d		db '+(%2d)',0           ; DATA XREF: ExecuteScript+77Do
word_1AD98	dw 0			; DATA XREF: sub_13D1C+Fw
					; sub_13D1C+66r ...
		dw 0, 2, 3, 4
word_1ADA2	dw 0			; DATA XREF: sub_13F8C+Ew
					; sub_13FB0+5Dr ...
word_1ADA4	dw 0			; DATA XREF: sub_13FB0+9Aw
					; sub_13FB0:loc_1406Er	...
word_1ADA6	dw 0			; DATA XREF: sub_13F8C+14w
					; sub_13FB0+28r ...
word_1ADA8	dw 0			; DATA XREF: sub_13F8C+1Aw
					; sub_13FB0+17r
word_1ADAA	dw 0			; DATA XREF: sub_140FF+Fw
					; sub_140FF+30r ...
word_1ADAC	dw 0			; DATA XREF: sub_141C7+Fw
					; sub_141C7+3Br ...
		align 4
		dw 1, 2, 1, 0, 3, 4, 3,	0, 0
aMemoryErrNo_D	db 0Ah			; DATA XREF: malloc+33o
		db 'memory Err NO.%d',0Ah,0
		db    0
word_1ADD6	dw 0			; DATA XREF: malloc+2Fr malloc+56w
GDCPlaneDisp	dw 0			; DATA XREF: SwapGDCPlanes+14w
					; seg000:60A8r
word_1ADDA	dw 0			; DATA XREF: SwapGDCPlanes+17w
					; SwapGDCPlanes:loc_1004Br ...
		db 182h	dup(0)
		dw 0B1h, 0, 0, 0, 0, 0,	0, 0
		dw 0B2h, 0, 0, 0, 0, 0,	0, 0
		dw 0B3h, 0, 0, 0, 0, 0,	0, 0
		dw 0B4h, 0, 0, 0, 0, 0,	0, 0
		dw 0B5h, 0, 0, 0, 0, 0,	0, 0
		dw 0B6h, 0, 0, 0, 0, 0,	0, 0
		dw 0B7h, 0, 0, 0, 0, 0,	0, 0
		dw 0B8h, 0, 0, 0, 0, 0,	0, 0
		dw 0B9h, 0, 0, 0, 0, 0,	0, 0
		dw 0BAh, 0, 0, 0, 0, 0,	0, 0
		dw 0B1h, 0, 0, 0, 0, 0,	0, 0
		dw 0B2h, 0, 0, 0, 0, 0,	0, 0
		dw 0B3h, 0, 0, 0, 0, 0,	0, 0
		dw 0B4h, 0, 0, 0, 0, 0,	0, 0
		dw 0B5h, 0, 0, 0, 0, 0,	0, 0
		dw 0B6h, 0, 0, 0, 0, 0,	0, 0
		dw 0B7h, 0, 0, 0, 0, 0,	0, 0
		dw 0B8h, 0, 0, 0, 0, 0,	0, 0
		dw 0B9h, 0, 0, 0, 0, 0,	0, 0
		dw 0BAh, 0, 0, 0, 0, 0,	0, 0
		dw 0BBh, 0, 0
		dw 0BCh, 0, 0
		dw 501Bh, 0, 0
		dw 441Bh, 0, 0
		dw 0Bh,	0, 0
		dw 8, 0, 0
		dw 0Ch,	0, 0
		dw 0Ah,	0, 0
		dw 1Ah,	0, 0
		dw 0BDh, 0, 0
		dw 1Eh,	0, 0
word_1B0E0	dw 0			; DATA XREF: sub_10A4B+24Dr
					; ExecuteScript:loc_12104r ...
word_1B0E2	dw 0			; DATA XREF: seg000:loc_1608Br
					; seg000:6092w	...
palFadeSpeed	dw 0			; DATA XREF: Palette_Fade2Tgt+1Bw
					; seg000:loc_16075r ...
word_1B0E6	dw 0			; DATA XREF: sub_178D9+Ew
					; sub_178F7+16r ...
byte_1B0E8	db 82h,	4Fh, 82h, 50h, 82h, 51h, 82h, 52h, 82h,	53h, 82h
					; DATA XREF: sub_179E1+14r
					; sub_179E1+1Cr
		db 54h,	82h, 55h, 82h, 56h, 82h, 57h, 82h, 58h
		db 81h,	40h, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0
		db 0, 0, 0, 0
byte_1B110	db 82h,	4Fh, 82h, 4Fh, 81h, 46h, 82h, 4Fh, 82h,	4Fh, 0
					; DATA XREF: sub_179E1+18w
					; sub_17A0B+160o ...
		db 0, 0, 0, 0, 0, 0, 0,	0, 0
		db 81h,	0A1h, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0
		db 0, 0, 0, 0
txtWaitCursor	db 81h,	0A5h, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0
					; DATA XREF: WaitForInput+A0o
					; WaitForInput+121o
		db 0, 0, 0, 0
byte_1B14C	db 81h,	0A1h, 81h, 0A1h, 81h, 0A1h, 81h, 0A1h, 81h, 0A1h
					; DATA XREF: sub_178F7+4Bo
					; sub_17A0B+134o
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0
dialogHasIndent	dw 0			; DATA XREF: DrawText_Name+10Dw
					; DrawText_Dialog+30r ...
TextBoxes	TextBoxDef <  33,   12,	  20,	 2,   18,   18,	   0,	 0,    0>; 0
					; DATA XREF: ClearTextBox+1Br
					; DrawTBoxBorder+62r ...
		TextBoxDef < 498,   25,	   7,	 7,   18,   18,	   0,	 0,    0>; 1
		TextBoxDef <  80,  262,	  28,	 6,   18,   18,	   0,	 0,    0>; 2
		TextBoxDef < 536,  180,	   5,	 4,   18,   18,	   0,	 0,    0>; 3
		TextBoxDef < 536,  156,	   6,	 2,   18,   18,	   0,	 0,    0>; 4
		TextBoxDef < 502,  184,	   7,	 3,   18,   18,	   0,	 0,    0>; 5
		TextBoxDef <   0,    0,	  35,	22,   18,   18,	   0,	 0,    0>; 6
word_1B1E0	dw 2			; DATA XREF: DrawText_Name+54r
					; DrawText_Dialog+DAr ...
aAm2d2dS	db 'Am(%2d,%2d,%s)',0   ; DATA XREF: DrawTextF_Opts+18o
		align 2
word_1B1F2	dw 0			; DATA XREF: sub_17A0B:loc_17A50r
					; sub_17A0B+76w
aTextWorkLength	db 0Ah			; DATA XREF: CalcTBoxThing+6Eo
		db 'text work length=%d',0Ah,0
aRb		db 'rb',0               ; DATA XREF: LoadFile2:loc_17DA9o
aRb_0		db 'rb',0               ; DATA XREF: CheckFileExist:loc_17E1Co
aFileReadingS	db 'File reading [%s] ',0 ; DATA XREF: LoadFile+13o
aReadLengthD	db '   read length=%d',0Ah,0 ; DATA XREF: LoadFile+68o
aFileNotFindS	db 'File not find [%s]',0Ah,0 ; DATA XREF: LoadFile+82o
word_1B24A	dw 0			; DATA XREF: sub_1845F+Br
					; sub_1845F+76w ...
fileLoadErr	dw 0			; DATA XREF: ReadSaveGame:loc_10481w
					; ExecuteScript:loc_12143r ...
musdrvIsLoaded	dw 0			; DATA XREF: CallMusicDriver+8r
					; PlayBGM+27r ...
aMusdrv		db 'MUSDRV',0           ; DATA XREF: SetupIntA6+3Er
		db 0, 0, 0
word_1B25A	dw 0			; DATA XREF: start+4Aw	__myalloc+8r ...
word_1B25C	dw 0			; DATA XREF: start+3Ew
off_1B25E	dw offset __exit	; DATA XREF: start+9Cw	start+AEr
word_1B260	dw 0			; DATA XREF: start+39w	__myalloc+2r ...
		dw seg dseg
		db 4Ch dup(0)
word_1B2B0	dw 0C10h		; DATA XREF: _brkctl:loc_1A317r
					; _brkctl+61w
aC_file_info	db ';C_FILE_INFO',0
dword_1B2BF	dd 0			; DATA XREF: __cinit+Cw __ctermsub+Er	...
		db 8 dup(0)
word_1B2CB	dw 0			; DATA XREF: sub_18BE6+26w
word_1B2CD	dw 0			; DATA XREF: __cXENIXtoDOSmoder
		dw 0
word_1B2D1	dw 0			; DATA XREF: start+5Ew	__cinit+26r ...
word_1B2D3	dw 0			; DATA XREF: __cinit+4w __setargv+7r ...
		align 2
byte_1B2D6	db 0			; DATA XREF: sub_18BE6w
		align 2
word_1B2D8	dw 14h			; DATA XREF: _close+6r	_lseek+9r ...
		db 81h,	81h, 81h, 1, 1,	0, 0, 0, 0, 0
		db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0
; int argc
argc		dw 0			; DATA XREF: start+89r	__setargv+BEw
; char **argv
argv		dw 0			; DATA XREF: start+85r	__setargv+D0w
word_1B2F2	dw 0			; DATA XREF: start+81r	__setenvp+44w
off_1B2F4	dd byte_1B2F8		; DATA XREF: __setargv+29w
					; __setargv+DEr ...
byte_1B2F8	db 43h,	0, 0, 0		; DATA XREF: dseg:off_1B2F4o
byte_1B2FC	db 0			; DATA XREF: __ctermsub+18r
byte_1B2FD	db 0			; DATA XREF: __ctermsub+20r
dword_1B2FE	dd 0			; DATA XREF: __ctermsub+23r
word_1B302	dw 0			; DATA XREF: __FF_MSGBANNER+Ar
					; __FF_MSGBANNER+11r
StackMemoryPtr	dw 2B60h		; DATA XREF: __chkstk+7r
					; _stackavail+1r
word_1B306	dw 0			; DATA XREF: __setargvw __setargv+18Ar
		db 0, 16h, 2, 2, 18h, 0Dh, 9, 0Ch, 0Ch,	0Ch, 7,	8, 16h
		db 16h,	0FFh, 12h, 0Dh,	12h, 2,	0FFh, 5Ch, 0, 5Ch, 0
word_1B320	dw 0			; DATA XREF: __flsbuf+90w
					; __openfile+B8w ...
		dw offset word_1BFA4
		dw 0
		dw offset word_1BFA4
		dw 1
		db 0, 0, 0, 0, 0, 0, 2,	1
		db 0, 0, 0, 0, 0, 0, 2,	2
		db 0, 0, 0, 0, 0, 0, 84h, 3
		db 0, 0, 0, 0, 0, 0, 2,	4
		db 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0, 0, 0, 0,	0
byte_1B3BA	db 0, 0, 0, 0, 0, 0, 0,	0 ; DATA XREF: dseg:off_1B43Ao
		db 1, 0, 0, 2, 0, 0, 0,	0
		db 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0, 0, 0, 0,	0
off_1B43A	dw offset byte_1B3BA	; DATA XREF: _flushall:loc_18CF2r
					; __getstream+Ar
aNull		db '(null)',0
aNull_0		db '(null)',0
		db '+- #',0
		db 0
		db 0
byte_1B451	db 0			; DATA XREF: _open+1Er
word_1B452	dw 0			; DATA XREF: unknown_libname_2+1Fw
word_1B454	dw 0			; DATA XREF: unknown_libname_2+22w
		align 4
word_1B458	dw 0			; DATA XREF: unknown_libname_2+32w
		align 4
word_1B45C	dw 0			; DATA XREF: __fmalloc+10r
					; __fmalloc+1Cw ...
word_1B45E	dw 0			; DATA XREF: sub_1A112+2Bw
word_1B460	dw 0			; DATA XREF: sub_1A112+2Fw
					; sub_1A17E+9r	...
word_1B462	dw 2000h		; DATA XREF: __amexpand:loc_1A28Cr
word_1B464	dw 0			; DATA XREF: sub_1A112+32r
					; sub_1A112+38w
byte_1B466	db 0			; DATA XREF: __amalloc:loc_1A1F1w
					; __amalloc:loc_1A22Cw
		db 0
off_1B468	dw offset __fptrap	; DATA XREF: sub_19804+53r
off_1B46A	dw offset __fptrap	; DATA XREF: seg000:986Fr
		dw 88F0h
off_1B46E	dw offset __fptrap	; DATA XREF: seg000:9888r
off_1B470	dw offset __fptrap	; DATA XREF: seg000:98A6r
		db 8 dup(0)
dword_1B47A	dd 0			; DATA XREF: __cinit+37r __cinit+4Dr ...
dword_1B47E	dd 0			; DATA XREF: __cinit+2Fr
dword_1B482	dd 0			; DATA XREF: __cinit:loc_187A3r
		dw 8CCEh
seg_1B488	dw seg seg001		; DATA XREF: ExecuteScript+C90r
					; ExecuteScript+D2Ar ...
		db '<<NMSG>>',0
		db 0
		db 'R6000',0Dh,0Ah
		db '- stack overflow',0Dh,0Ah,0
		db 3, 0
		db 'R600'
asc_1B4B4	db '3',0Dh,0Ah          ; DATA XREF: sub_10F59+Ao
		db '- integer divide by 0',0Dh,0Ah,0
		db 9, 0
		db 'R6009',0Dh,0Ah
		db '- not enough space for environment',0Dh,0Ah,0
		db 0FCh, 0
		db 0Dh,0Ah,0
		db 0FFh, 0
		db 'run-time error ',0
		db 2, 0
		db 'R6002',0Dh,0Ah
		db '- floating point not loaded',0Dh,0Ah,0
		db 1, 0
		db 'R6001',0Dh,0Ah
		db '- null pointer assignment',0Dh,0Ah,0
		db 0FFh, 0FFh, 0FFh, 0
word_1B564	dw 0			; DATA XREF: ExecuteScript+892w
					; ExecuteScript+8B3r ...
word_1B566	dw 0			; DATA XREF: ExecuteScript+895w
					; ExecuteScript+8AFr ...
dlgTextYPos	dw 0			; DATA XREF: DrawText_Dialog+37w
					; DrawText_Dialog+A9w ...
word_1B56A	dw 0			; DATA XREF: sub_19294+55w
					; sub_19294:loc_19328w	...
; FILE *word_1B56C
word_1B56C	dw 0			; DATA XREF: sub_19294+1Ew
					; sub_19294:loc_19442r	...
word_1B56E	dw 0			; DATA XREF: sub_19294+52w
					; sub_19294:loc_19472w	...
word_1B570	dw ?			; DATA XREF: sub_19294+43w
					; sub_19294:loc_193EEw	...
word_1B572	dw ?			; DATA XREF: sub_19294+49w
					; sub_19294+111w ...
word_1B574	dw ?			; DATA XREF: sub_19294+40w
					; sub_19294+75w ...
word_1B576	dw ?			; DATA XREF: sub_19294+58w
					; sub_19294+9Fw ...
word_1B578	dw ?			; DATA XREF: sub_19294+18w
					; sub_19294:loc_1941Er	...
word_1B57A	dw ?			; DATA XREF: sub_19294+4Fw
					; sub_19294+79w ...
word_1B57C	dw ?			; DATA XREF: sub_19294+4Cw
					; sub_19294+D7w ...
word_1B57E	dw ?			; DATA XREF: sub_19294+46w
					; sub_19294:loc_19456w	...
word_1B580	dw ?			; DATA XREF: sub_19294+27w
					; sub_19294+190r ...
word_1B582	dw ?			; DATA XREF: sub_19294+21w
					; sub_19294:loc_1942Er	...
word_1B584	dw ?			; DATA XREF: sub_19294:loc_192CCw
					; sub_19294+E9r ...
word_1B586	dw ?			; DATA XREF: sub_19294+1EDw
					; sub_19294:loc_1948Aw	...
; char *word_1B588
word_1B588	dw ?			; DATA XREF: sub_19294+12w
					; sub_195E6+79r ...
word_1B58A	dw ?			; DATA XREF: sub_19294+BFr
					; sub_19294+CAr ...
word_1B58C	dw ?			; DATA XREF: sub_195E6:loc_1965Cw
					; seg000:9894w	...
; int word_1B58E
word_1B58E	dw ?			; DATA XREF: sub_19294+5Bw
					; sub_19294+68w ...
word_1B590	dw ?			; DATA XREF: sub_178D9+Bw
					; sub_17A0B+26r ...
word_1B592	dw ?			; DATA XREF: LoadClearPBD+Cr
					; sub_137E8+Er	...
word_1B594	dw ?			; DATA XREF: LoadClearPBD+8r
					; sub_137E8+11r ...
word_1B596	dw ?			; DATA XREF: sub_106F6+66w
					; sub_106F6+ABr ...
		dw ?
		dw ?
		dw ?
		dw ?
PalTarget	db 30h dup(?)		; DATA XREF: ExecuteScript+6CBw
					; Palette_SetGDC+4Br ...
word_1B5D0	dw ?			; DATA XREF: sub_17A0B+23w
					; sub_17A0B+29r ...
word_1B5D2	dw ?			; DATA XREF: sub_1845F+25r
					; sub_1845F+5Ao ...
word_1B5D4	dw ?			; DATA XREF: sub_184DF+14w
		db 86h dup(?)
scrDataBasePtr	dd ?			; DATA XREF: sub_103B0+9r scrCall+2Cr	...
		dd ?
word_1B664	dw ?			; DATA XREF: sub_1845F+6Dw
					; sub_184FD+51r
		db 52h dup(?)
word_1B6B8	dw ?			; DATA XREF: ExecuteScript+BDEw
					; ExecuteScript+BF0r ...
scrStackPtrs	dd 180h	dup(?)		; DATA XREF: scrCall+1Bw scrReturn+1Br ...
word_1BCBA	dw ?			; DATA XREF: sub_11DF6+6Fr
					; sub_11DF6+B4r ...
word_1BCBC	dw ?			; DATA XREF: sub_11DF6+6Br
					; sub_11DF6+B0r ...
word_1BCBE	dw ?			; DATA XREF: sub_1332F+32w
					; sub_1332F+D6r ...
word_1BCC0	dw ?			; DATA XREF: sub_1098C+25w
					; sub_10A07+25w ...
		db 18h dup(?)
word_1BCDA	dw ?			; DATA XREF: sub_12080+Bw
					; ExecuteScript+1Dr
dword_1BCDC	dd ?			; DATA XREF: sub_105EA+74r
					; sub_10F59+34r ...
		db 50h dup(?)
byte_1BD30	db 50h dup(?)		; DATA XREF: sub_1013C:loc_10220r
word_1BD80	dw ?			; DATA XREF: seg000:0553w seg000:0566r
word_1BD82	dw ?			; DATA XREF: seg000:0556w seg000:0569r
word_1BD84	dw ?			; DATA XREF: sub_1332F+Aw
					; sub_13505+57r ...
		dw ?
		dw ?
StringBuffer	db 500 dup(?)		; DATA XREF: sub_11258+1Fo
					; sub_11296+5Do ...
					; generic string storage buffer
scrDataPtr	dd ?			; DATA XREF: sub_1013C:loc_1017Aw
					; ScrData_Str2Buf:loc_1029Cr ...
word_1BF82	dw ?			; DATA XREF: sub_11296+8Aw
					; sub_11296+CBr ...
		dw ?
		dw ?
		dw ?
word_1BF8A	dw ?			; DATA XREF: sub_118DA+129r
					; sub_118DA+164r ...
word_1BF8C	dw ?			; DATA XREF: sub_118DA+12Dr
					; sub_118DA+168r ...
word_1BF8E	dw ?			; DATA XREF: sub_10D1A+1Fw
					; sub_10D6C+5Ar ...
		dw ?
		dw ?
word_1BF94	dw ?			; DATA XREF: sub_11804+54r
					; sub_11804+A0r ...
word_1BF96	dw ?			; DATA XREF: sub_11804+58r
					; sub_11804+9Cr ...
word_1BF98	dw ?			; DATA XREF: ExecuteScript+CD4r
					; ExecuteScript+D0Cr ...
word_1BF9A	dw ?			; DATA XREF: ExecuteScript+CD0r
					; ExecuteScript+D08r ...
word_1BF9C	dw ?			; DATA XREF: sub_118DA+64r
					; sub_118DA+9Fr ...
word_1BF9E	dw ?			; DATA XREF: sub_118DA+68r
					; sub_118DA+A3r ...
word_1BFA0	dw ?			; DATA XREF: sub_118DA+1EEr
					; sub_118DA+229r ...
word_1BFA2	dw ?			; DATA XREF: sub_118DA+1F2r
					; sub_118DA+22Dr ...
word_1BFA4	dw ?			; DATA XREF: dseg:0CD2o dseg:0CD6o
		db 200h	dup(?)
word_1C1A6	dw ?			; DATA XREF: sub_13AFC+66r
					; sub_13AFC+A0r ...
dword_1C1A8	dd ?			; DATA XREF: sub_10670+74r
					; ExecuteScript+1010r ...
word_1C1AC	dw ?			; DATA XREF: sub_185C1+18w
					; sub_185C1+25r ...
word_1C1AE	dw ?			; DATA XREF: sub_185C1+1Bw
					; sub_185C1+28r ...
word_1C1B0	dw ?			; DATA XREF: sub_106F6+C4r
					; sub_106F6+105r ...
		db 30h dup(?)
choiceTextPtrs	dd ?, ?, ?, ?		; DATA XREF: sub_11258+17w
					; sub_11296+4Er ...
dword_1C1F2	dd 28h dup(?)		; DATA XREF: sub_1845F+3Bw
					; sub_184FD+68r ...
scriptRAM	db 80h dup(?)		; 0 ; DATA XREF: ReadSaveGame+60w
					; WriteSaveGame+23w ...
		db 6 dup(?)
word_1C318	dw ?			; DATA XREF: sub_13F8C+8w
					; sub_13FB0:loc_13FD1r	...
dword_1C31A	dd ?			; DATA XREF: ExecuteScript+5C0r
					; ExecuteScript+5D1r ...
word_1C31E	dw ?			; DATA XREF: _main+4Co	_main+A8r
word_1C320	dw ?			; DATA XREF: _main+ABr
word_1C322	dw ?			; DATA XREF: ExecuteScript+A7Ar
					; sub_1332F+7Br ...
word_1C324	dw ?			; DATA XREF: ExecuteScript+A76r
					; sub_1332F+7Fr ...
word_1C326	dw ?			; DATA XREF: ExecuteScript+AB2r
					; sub_1332F+ABr ...
word_1C328	dw ?			; DATA XREF: ExecuteScript+AAEr
					; sub_1332F+AFr ...
tBoxBufferPtr	dd ?			; DATA XREF: _main+7Fo
					; CalcTBoxThing+29r ...
word_1C32E	dw ?			; DATA XREF: seg000:loc_16096r
					; seg000:609Dw	...
tbox2BasePosX	dw ?			; DATA XREF: DrawText_Name+1Cw
					; DrawText_Name+2Er ...
tbox2BasePosY	dw ?			; DATA XREF: DrawText_Name+2Aw
					; DrawText_Name+5Aw ...
dword_1C334	dd ?			; DATA XREF: sub_11DF6+20r
					; sub_11DF6+39r ...
word_1C338	dw ?			; DATA XREF: ExecuteScript+472w
					; ExecuteScript+537r ...
word_1C33A	dw ?			; DATA XREF: sub_11804+37r
					; sub_11804+69r ...
word_1C33C	dw ?			; DATA XREF: sub_11804+3Br
					; sub_11804+6Dr ...
word_1C33E	dw ?			; DATA XREF: ExecuteScript+478w
					; ExecuteScript+57Fw ...
word_1C340	dw ?			; DATA XREF: sub_1160E+48r
					; sub_1160E+67r ...
word_1C342	dw ?			; DATA XREF: sub_1160E+4Cr
					; sub_1160E+7Er ...
dword_1C344	dd ?			; DATA XREF: sub_1160E+53w
					; sub_1160E+60r ...
word_1C348	dw ?			; DATA XREF: sub_10A4B+68w
					; ExecuteScript+1A3w ...
word_1C34A	dw ?			; DATA XREF: ExecuteScript+491w
					; sub_14270+65r ...
word_1C34C	dw ?			; DATA XREF: ExecuteScript+494w
					; sub_14270+69r ...
		db 1F4h	dup(?)
word_1C542	dw ?			; DATA XREF: sub_17556+Fr
					; sub_17556+B1w ...
word_1C544	dw ?			; DATA XREF: sub_17673+13w
					; sub_1776F+Aw
word_1C546	dw ?			; DATA XREF: sub_17673+25w
					; sub_1776F+1Cw
		dw ?
		dw ?
word_1C54C	dw ?			; DATA XREF: sub_17673+19w
					; sub_1776F+10w
		db 412h	dup(?)
tBoxBufferPtrs	dd 8 dup(?)		; DATA XREF: TBoxBuf_Scr2Buf+6Cr
					; TBoxBuf_Buf2Scr+88r ...
		db 0Ah dup(?)
word_1C98A	dw ?			; DATA XREF: ExecuteScript+12Dw
					; ExecuteScript+142w ...
word_1C98C	dw ?			; DATA XREF: ExecuteScript+4C0w
					; ExecuteScript+4D5r ...
word_1C98E	dw ?			; DATA XREF: ExecuteScript+4C3w
					; ExecuteScript+4D1r ...
word_1C990	dw ?			; DATA XREF: sub_11CDB:loc_11CE8w
					; sub_11CDB:loc_11CF1w	...
		dw ?
		db 80h dup(?)
word_1CA14	dw ?			; DATA XREF: sub_10D1A+43w
					; sub_10D6C+6Cw ...
word_1CA16	dw ?			; DATA XREF: sub_10D6C+ADw
					; sub_10D6C+16Cr ...
word_1CA18	dw ?			; DATA XREF: sub_10D6C+F3w
					; sub_10D6C+168r ...
word_1CA1A	dw ?			; DATA XREF: sub_10D6C+100w
					; sub_10D6C+143w ...
		db 58h dup(?)
word_1CA74	dw ?			; DATA XREF: sub_1098C+1Fw
					; sub_10A07+19w ...
		db 218h	dup(?)
word_1CC8E	dw ?			; DATA XREF: sub_178D9+17w
					; sub_17A0B+56r
choiceJumpDest	dw 1F8h	dup(?)		; DATA XREF: sub_11258+32w
					; sub_11296+190r ...
byte_1D080	db 28h dup(?)		; DATA XREF: sub_10F59+21o
scrDialogPtr	dd ?			; DATA XREF: ExecuteScript+DEw
					; ExecuteScript+F3r ...
		align 8
dseg		ends

; ===========================================================================

; Segment type:	Uninitialized
seg003		segment	byte stack 'STACK' use16
		assume cs:seg003
		assume es:nothing, ss:nothing, ds:dseg,	fs:nothing, gs:nothing
byte_1D0B0	db 800h	dup(?)
seg003		ends


		end start
