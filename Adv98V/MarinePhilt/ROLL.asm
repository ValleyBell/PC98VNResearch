; Input	MD5   :	E24CD2CDED5C641994F79E8FF984003C
; Input	CRC32 :	7664ACE0

; ---------------------------------------------------------------------------
; File Name   :	R:\MARINE\TCM\ROLL.TCM
; Format      :	Binary file
; Base Address:	0000h Range: 0000h - 0373h Loaded length: 0373h

		.686p
		.mmx
		.model flat

; ===========================================================================

; Segment type:	Pure code
seg000		segment	byte public 'CODE' use16
		assume cs:seg000
		assume es:nothing, ss:nothing, ds:nothing, fs:nothing, gs:nothing

start:
		pop	ax
		push	cs
		push	ax
		call	$+3
		pop	ax
		sub	ax, 6
		test	al, 0Fh
		jnz	short loc_1F
		mov	cl, 4
		shr	ax, cl
		mov	bp, cs
		add	ax, bp
		push	ax
		mov	ax, offset main
		push	ax
		retf
; ---------------------------------------------------------------------------

main:					; DATA XREF: seg000:0017o
		call	sub_22

loc_1F:					; CODE XREF: seg000:000Cj
		mov	ch, 0FFh
		retf
; This gets loaded with:
;   AX = 001Ch
;   BX = 0000h
;   CX = 0004h
;   DX = 2090h
;   BP = 4410h (original load segment)
;   SI =0DD0Dh
;   DI =0DC8Dh
;   CS = 45D8h
;   DS = 4410h
;   ES = 4410h

; =============== S U B	R O U T	I N E =======================================


sub_22		proc near		; CODE XREF: seg000:mainp
		mov	ax, cs
		mov	es, ax

loc_26:					; DATA XREF: sub_1D2+17w
		mov	ax, 1B00h

loc_29:					; DATA XREF: sub_1D2+1Aw
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		lodsw
		lodsw
		or	ax, ax
		jnz	short loc_9F
		lodsw
		mov	cs:37Ch, ax
		mov	word ptr cs:37Eh, ds
		lodsw
		mov	cs:byte_342, al
		lodsw
		shl	ax, 1
		mov	cs:word_33E, ax
		mov	bx, 1918h
		mov	dx, offset unk_354
		lodsw
		or	al, al
		jnz	short loc_55
		add	dx, 4

loc_55:					; CODE XREF: sub_22+2Ej
		mov	cs:384h, dx
		mov	cs:byte_357, al
		sub	bh, al

loc_60:					; DATA XREF: sub_22:loc_29r sub_22+8Br ...
		lodsw
		sub	bl, al
		mov	cs:byte_35F, bl
		sub	bh, bl
		mov	cs:byte_35B, bh
		xor	ax, ax
		mov	al, bh
		mov	cx, ax
		shl	ax, 2
		add	ax, cx
		shl	ax, 4
		mov	cs:382h, ax
		xor	cx, cx
		call	ClearTRAM
		mov	cx, 1
		call	ClearTRAM
		call	sub_16E

loc_8F:					; DATA XREF: sub_1D2+23w
		in	al, 2		; DMA controller, 8237A-5.
					; channel 1 current address

loc_91:					; DATA XREF: sub_1D2+26w
		and	al, 0FBh
		jmp	short $+2
		out	2, al		; DMA controller, 8237A-5.
					; channel 1 base address
					; (also	sets current address)
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
		sti
		retn
; ---------------------------------------------------------------------------

loc_9F:					; CODE XREF: sub_22+Dj
		in	al, 2		; DMA controller, 8237A-5.
					; channel 1 current address
		or	al, 4
		jmp	short $+2
		out	2, al		; DMA controller, 8237A-5.
					; channel 1 base address
					; (also	sets current address)
		call	sub_1D2
		mov	ax, 1B01h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		mov	ax, 1001h
		mov	bx, cs:380h
		int	0F1h		; reserved for user interrupt
		retn
sub_22		endp

; ---------------------------------------------------------------------------

Int0Ah:					; DATA XREF: sub_16E+2Co
		pushf
		pusha
		cld
		cmp	cs:word_33C, 0
		jnz	short loc_103
		mov	ax, cs:word_340
		mov	cl, cs:byte_342
		add	ax, 2
		mov	cs:word_340, ax
		shr	ax, cl
		cmp	ax, 10h
		jnz	short loc_101
		xor	ax, ax
		out	76h, al
		mov	cs:word_340, ax
		call	ProcessText
		or	al, al
		jz	short loc_101
		in	al, 2		; DMA controller, 8237A-5.
					; channel 1 current address
		or	al, 4
		jmp	short $+2
		out	2, al		; DMA controller, 8237A-5.
					; channel 1 base address
					; (also	sets current address)
		call	sub_1D2
		mov	al, 20h	; ' '
		out	0, al
		popa
		popf
		jmp	dword ptr cs:374h
; ---------------------------------------------------------------------------

loc_101:				; CODE XREF: seg000:00DAj seg000:00E9j
		out	76h, al

loc_103:				; CODE XREF: seg000:00C3j
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
		popa
		popf
		jmp	dword ptr cs:374h
; ---------------------------------------------------------------------------

Int24h:					; DATA XREF: sub_16E+39o
		pushf
		inc	cs:word_33C
		pusha
		push	es
		mov	si, offset unk_344
		call	ScrollText
		xor	cx, cx
		call	MoveTRAMData
		xor	cx, cx
		call	ClearTRAM
		xor	ax, ax
		out	76h, al
		pop	es
		popa
		call	dword ptr cs:378h
		pusha
		push	es
		mov	ax, cs:word_340
		out	76h, al
		mov	cx, 1
		call	MoveTRAMData
		mov	cx, 1
		call	ClearTRAM
		mov	si, cs:384h
		call	ScrollText
		mov	ax, 1B00h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		pop	es
		popa
		dec	cs:word_33C
		iret
; ---------------------------------------------------------------------------

loc_15C:				; DATA XREF: sub_16E+41o
		in	al, 2		; DMA controller, 8237A-5.
					; channel 1 current address
		or	al, 4
		jmp	short $+2
		out	2, al		; DMA controller, 8237A-5.
					; channel 1 base address
					; (also	sets current address)
		call	sub_1D2
		mov	ax, 1B01h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		iret
; ---------------------------------------------------------------------------
		nop

; =============== S U B	R O U T	I N E =======================================


sub_16E		proc near		; CODE XREF: sub_22+6Ap
		mov	si, cs:384h
		call	ScrollText
		mov	al, cs:byte_357
		neg	al
		out	78h, al
		mov	al, cs:byte_35B
		dec	al
		out	7Ah, al
		pushf
		cli
		inc	cs:word_33C
		xor	ax, ax
		mov	ds, ax
		mov	bx, 28h		; set INT 0Ah
		mov	bp, 374h
		call	sub_1C4
		mov	word ptr [bx], offset Int0Ah
		mov	bx, 90h		; set INT 24h
		mov	bp, 378h
		call	sub_1C4
		mov	word ptr [bx], offset Int24h
		mov	ax, cs
		mov	es, ax
		mov	dx, offset loc_15C
		mov	ax, 1000h
		int	0F1h		; reserved for user interrupt
		mov	cs:380h, bx
		dec	cs:word_33C
		popf
		retn
sub_16E		endp

; ---------------------------------------------------------------------------
		nop

; =============== S U B	R O U T	I N E =======================================


sub_1C4		proc near		; CODE XREF: sub_16E+29p sub_16E+36p
		les	ax, [bx]
		mov	cs:[bp+0], ax
		mov	word ptr cs:[bp+2], es
		mov	word ptr [bx+2], cs
		retn
sub_1C4		endp


; =============== S U B	R O U T	I N E =======================================


sub_1D2		proc near		; CODE XREF: sub_22+85p seg000:00F3p ...
		pusha
		push	ds
		push	es
		pushf
		cli
		inc	cs:word_33C
		xor	ax, ax
		mov	cs:word_340, ax
		mov	ds, ax
		les	ax, cs:374h
		mov	word ptr ds:loc_26+2, ax
		mov	word ptr ds:loc_29+1, es
		les	ax, cs:378h
		mov	word ptr ds:loc_8F+1, ax
		mov	word ptr ds:loc_91+1, es
		dec	cs:word_33C
		popf
		xor	cx, cx
		call	ClearTRAM
		mov	si, offset unk_344
		call	ScrollText
		xor	ax, ax
		out	76h, al
		mov	cx, 0A000h
		mov	es, cx
		assume es:nothing
		mov	di, 2000h
		mov	cx, 0FA0h
		mov	ax, 1111h
		rep stosw
		pop	es
		assume es:nothing
		pop	ds
		popa
		retn
sub_1D2		endp

; ---------------------------------------------------------------------------
		db  90h	; ê

; =============== S U B	R O U T	I N E =======================================


ScrollText	proc near		; CODE XREF: seg000:011Bp seg000:014Cp ...
		mov	cx, 10h
		mov	ah, 70h

loc_22B:				; CODE XREF: ScrollText+9j
					; ScrollText+1Dj
		in	al, 60h		; 8042 keyboard	controller data	register
		test	al, 2
		jnz	short loc_22B
		mov	al, ah
		out	62h, al		; PC/XT	PPI port C. Bits:
					; 0-3: values of DIP switches
					; 5: 1=Timer 2 channel out
					; 6: 1=I/O channel check
					; 7: 1=RAM parity check	error occurred.
		jmp	short $+2
		inc	ah

loc_239:				; CODE XREF: ScrollText+17j
		in	al, 60h		; 8042 keyboard	controller data	register
		test	al, 2
		jnz	short loc_239
		lods	byte ptr cs:[si]
		out	60h, al		; 8042 keyboard	controller data	register.
		loop	loc_22B
		retn
ScrollText	endp


; =============== S U B	R O U T	I N E =======================================


ProcessText	proc near		; CODE XREF: seg000:00E4p
		mov	ax, cs:382h
		push	ds
		push	es
		mov	cx, 0A000h
		mov	es, cx
		assume es:nothing
		mov	cx, ax
		mov	si, 0A0h
		xor	di, di
		rep movs word ptr es:[di], word	ptr es:[si]
		mov	cx, 50h
		shl	ax, 1
		mov	di, ax
		push	di
		xor	ax, ax
		rep stosw
		lds	si, cs:37Ch
		pop	di
		add	di, cs:word_33E

loc_272:				; CODE XREF: ProcessText+54j
		lodsw
		cmp	ax, 0A0Dh
		jz	short loc_29C
		cmp	ax, 0D0Ah
		jz	short loc_29C
		cmp	al, 1Ah
		jz	short loc_29E
		xchg	al, ah
		cmp	al, 1Ah
		jz	short loc_29E
		call	ShiftJIS2JIS
		sub	ah, 2
		sub	ah, 20h
		and	ah, 7Fh
		xchg	al, ah
		stosw
		or	ah, 80h
		stosw
		jmp	short loc_272
; ---------------------------------------------------------------------------

loc_29C:				; CODE XREF: ProcessText+30j
					; ProcessText+35j
		xor	al, al

loc_29E:				; CODE XREF: ProcessText+39j
					; ProcessText+3Fj
		mov	cs:37Ch, si
		pop	es
		assume es:nothing
		pop	ds
		retn
ProcessText	endp


; =============== S U B	R O U T	I N E =======================================


ShiftJIS2JIS	proc near		; CODE XREF: ProcessText+41p
		or	al, al
		jz	short sj2j_ascii
		cmp	ah, 80h
		jb	short sj2j_ascii
		cmp	ah, 0A0h
		jb	short sj2j_shiftjis
		cmp	ah, 0E0h
		jnb	short sj2j_shiftjis

sj2j_ascii:				; CODE XREF: ShiftJIS2JIS+2j
					; ShiftJIS2JIS+7j
		mov	al, ah
		xor	ah, ah
		stc
		jmp	short locret_300
; ---------------------------------------------------------------------------

sj2j_shiftjis:				; CODE XREF: ShiftJIS2JIS+Cj
					; ShiftJIS2JIS+11j
		cmp	ah, 0F0h
		jnb	short loc_2DB
		cmp	ah, 0E0h
		jnb	short loc_2D1
		shl	ah, 1
		add	ah, 21h
		jmp	short loc_2E3
; ---------------------------------------------------------------------------

loc_2D1:				; CODE XREF: ShiftJIS2JIS+22j
		sub	ah, 0E0h
		shl	ah, 1
		add	ah, 5Fh
		jmp	short loc_2E3
; ---------------------------------------------------------------------------

loc_2DB:				; CODE XREF: ShiftJIS2JIS+1Dj
		sub	ah, 0F0h
		shl	ah, 1
		add	ah, 76h

loc_2E3:				; CODE XREF: ShiftJIS2JIS+29j
					; ShiftJIS2JIS+33j
		cmp	al, 9Fh
		jnb	short loc_2F3
		cmp	al, 80h
		jnb	short loc_2EF
		sub	al, 1Fh
		jmp	short loc_2F7
; ---------------------------------------------------------------------------

loc_2EF:				; CODE XREF: ShiftJIS2JIS+43j
		sub	al, 20h
		jmp	short loc_2F7
; ---------------------------------------------------------------------------

loc_2F3:				; CODE XREF: ShiftJIS2JIS+3Fj
		sub	al, 7Eh
		inc	ah

loc_2F7:				; CODE XREF: ShiftJIS2JIS+47j
					; ShiftJIS2JIS+4Bj
		cmp	ax, 2921h
		cmc
		jnb	short locret_300
		cmp	ax, 2B7Fh

locret_300:				; CODE XREF: ShiftJIS2JIS+18j
					; ShiftJIS2JIS+55j
		retn
ShiftJIS2JIS	endp

; ---------------------------------------------------------------------------
		nop

; =============== S U B	R O U T	I N E =======================================


MoveTRAMData	proc near		; CODE XREF: seg000:0120p seg000:013Ep
		cld
		xor	si, si
		mov	di, 1000h
		jcxz	short loc_30C
		xchg	si, di

loc_30C:				; CODE XREF: MoveTRAMData+6j
		push	es
		mov	cx, 0A000h
		mov	es, cx
		assume es:nothing
		mov	cx, 800h
		rep movs word ptr es:[di], word	ptr es:[si]
		pop	es
		assume es:nothing
		retn
MoveTRAMData	endp


; =============== S U B	R O U T	I N E =======================================


ClearTRAM	proc near		; CODE XREF: sub_22+61p sub_22+67p ...
		cld
		push	es
		xor	ax, ax
		xor	di, di
		jcxz	short loc_325
		mov	di, 1000h

loc_325:				; CODE XREF: ClearTRAM+6j
		mov	cx, 0A000h
		mov	es, cx		; ES = 0A000h =	Text VRAM
		assume es:nothing
		mov	cx, 800h
		rep stosw
		mov	di, 2000h
		mov	cx, 0FA0h
		mov	ax, 0E1E1h
		rep stosw
		pop	es
		assume es:nothing
		retn
ClearTRAM	endp

; ---------------------------------------------------------------------------
word_33C	dw 0			; DATA XREF: seg000:00BDr seg000:0111w ...
word_33E	dw 0			; DATA XREF: sub_22+21w
					; ProcessText+27r
word_340	dw 0			; DATA XREF: seg000:00C5r seg000:00D1w ...
byte_342	db 1			; DATA XREF: sub_22+1Aw seg000:00C9r
		db    0
unk_344		db    0			; DATA XREF: seg000:0118o sub_1D2+35o
		db    0
		db    0
		db  19h
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
unk_354		db    0			; DATA XREF: sub_22+28o
		db    8
		db    0
byte_357	db 3			; DATA XREF: sub_22+38w sub_16E+8r
		db    0
		db    0
		db    0
byte_35B	db 13h			; DATA XREF: sub_22+48w sub_16E+10r
		db    0
		db    8
		db    0
byte_35F	db 3			; DATA XREF: sub_22+41w
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
aRollRel1_8	db 'ROLL Rel1.8'
seg000		ends


		end
