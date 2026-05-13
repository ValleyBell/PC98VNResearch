; "Dragoon Armor For Adult" Message TSR (MESPUT.COM) - half-width patch
; Developed on 2026-04-30 by Valley Bell
; This patch allows the game to support display half-width characters properly.
;
; All variants should be supported:
; - real ASCII (20..7F)
; - single-byte katakana (A0..DF)
; - Shift-JIS (8540..869E)
;
; Note that the following bytes are reserved for control codes and thus can not be used to display characters:
; - 01..09 - set text colour
; - 0A - text end
; - 0D - wait for key press
; - 10 - set transparent text draw mode
; - 11 - set opaque text draw mode
; - 12 - line break
; - 13 - clear text box on screen
; - 1A - copy text buffer to screen
; - 1C - advance API#4 text position by 16 pixels
; - "$" - text end + draw to screen
; - "0" - reset API#4 text box coordinates
; - "X", "Y" - set X/Y position
; - "+N" - increase X position by N characters
;
; Assembling using NASM:
;	nasm -f bin -o "MESPUT-ASC.COM" -l "MESPUT-ASC.LST" "MESPUT-ASC.asm"
;	This requires MESPUT.COM (5 365 bytes) to be in the same folder.

	use16
	cpu	186
BASE_OFS EQU 100h	; COM load offset

	org	BASE_OFS

chrDataRecvHdr EQU 15ACh	; +0 = character height, 1 = character width (1 = 8px, 2 = 16px)
chrDataRecvBuf EQU 15AEh
waitTime EQU 15F1h

	incbin "MESPUT.COM", $, 0136h - ($-$$+BASE_OFS)
	mov	dx, end-$$	; set correct size for TSR loading

	incbin "MESPUT.COM", $, 0148h - ($-$$+BASE_OFS)
	;db	"　　ＭＥＳＰＵＴ．ＣＯＭが常駐しました　　", 0Dh, 0Ah
	db	"    MESPUT.COM is now resident.", 0Dh, 0Ah
	;db	"　　割り込みベクトルはＦ０Ｈです　　　　　", 0Dh, 0Ah, "$"
	db	"    The interrupt vector is F0H.", 0Dh, 0Ah, "$"
	times 01A1h-($-$$+BASE_OFS) db 00h

	incbin "MESPUT.COM", $, 023Fh - ($-$$+BASE_OFS)
loc_1023F:

	incbin "MESPUT.COM", $, 02ADh - ($-$$+BASE_OFS)
dtxt_textchar:
	cmp	al, 81h
	jb	short dtxt_draw_1byte
	cmp	al, 0A0h
	jb	short dtxt_draw_shiftjis
	cmp	al, 0E0h
	jb	short dtxt_draw_1byte
	; fall through
dtxt_draw_shiftjis:
	xchg	ah, al
dtxt_draw_common:
	mov	dx, ax
	call	GetCharData
	push	si
	call	DrawTextChar
	cmp	byte [waitTime], byte 0
	jz	short loc_102EE
	call	WaitABit
loc_102EE:
	pop	si
	jmp	near loc_1023F

dtxt_draw_1byte:
	dec	si
	xor	ah, ah
	jmp	short dtxt_draw_common

	times 02E1h-($-$$+BASE_OFS) db 90h

;	incbin "MESPUT.COM", $, 033Dh - ($-$$+BASE_OFS)
;	; dummy the INC instruction out so that command 1C advances by 8 pixels only
;	times 0341h-($-$$+BASE_OFS) db 90h

	incbin "MESPUT.COM", $, 0400h - ($-$$+BASE_OFS)
WaitABit:

	incbin "MESPUT.COM", $, 0475h - ($-$$+BASE_OFS)
DrawTextChar:

	incbin "MESPUT.COM", $, 048Ch - ($-$$+BASE_OFS)
loc_1048C:

	; CalcTOfsAndWrap (04EBh)
	incbin "MESPUT.COM", $, 050Ch - ($-$$+BASE_OFS)
	call	TextOfsAdvance
	times 050Fh-($-$$+BASE_OFS) db 90h

	; api7_drawInt3 (0539h)
	incbin "MESPUT.COM", $, 0543h - ($-$$+BASE_OFS)
	; dummy the CALL out that would add an implicit space before every number
	times 0546h-($-$$+BASE_OFS) db 90h

	incbin "MESPUT.COM", $, 055Eh - ($-$$+BASE_OFS)
	jmp	short drawint_lastdig

TextOfsAdvance:
	add	al, byte [chrDataRecvHdr+1]
	retn
	times 056Ch-($-$$+BASE_OFS) db 90h

	; PrintDigit (0576h)
	incbin "MESPUT.COM", $, 0581h - ($-$$+BASE_OFS)
	add	ax, 0030h	; draw ASCII digit instead of full-width digit
	times 0584h-($-$$+BASE_OFS) db 90h

	; api8_drawInt5 (0596h)
	incbin "MESPUT.COM", $, 05A0h - ($-$$+BASE_OFS)
	; dummy the CALL out that would add an implicit space before every number
	times 05A3h-($-$$+BASE_OFS) db 90h
	
	incbin "MESPUT.COM", $, 05CBh - ($-$$+BASE_OFS)
drawint_lastdig:

	incbin "MESPUT.COM", $, 05CDh - ($-$$+BASE_OFS)
	add	ax, 0030h	; draw ASCII digit instead of full-width digit
	times 05D0h-($-$$+BASE_OFS) db 90h

	; PrintChar (05D9h)
	incbin "MESPUT.COM", $, 05D9h - ($-$$+BASE_OFS)
PrintChar:
	pusha
	mov	dx, ax
	
	call	GetCharData
	
	call	loc_1048C
	popa
	retn

disize_check:
	jae	disize_16	; character size == 2 -> jump
	; else fall through to disize_8
disize_8:
	mov	bx, 4Eh-1
didraw_8:
	lodsw		; always read a word (due to width-16 alignment)
	not	al	; but invert only the first 8 pixels
	stosb
	add	di, bx
	loop	didraw_8
	retn

disize_16:
	mov	bx, 4Eh-2
didraw_16:
	lodsw
	not	ax
	stosw
	add	di, bx
	loop	didraw_16
	retn

	times 0610h-($-$$+BASE_OFS) db 90h

	; api4_clear_draw (063Ch), special text draw code
	incbin "MESPUT.COM", $, 0670h - ($-$$+BASE_OFS)
dtc_inverted:
	mov	di, word [0978h]	; api4TextPosY
	mov	bx, word [0976h]	; api4TextPosX
	add	di, bx
	mov	al, [chrDataRecvHdr+1]	; get character width
	add	bl, al
	mov	word [0976h], bx
	
	add	di, 097Bh		; textDrawBuffer
	mov	si, chrDataRecvBuf
	mov	cx, 10h
	
	cmp	al, 2
	jmp	disize_check
	times 0696h-($-$$+BASE_OFS) db 90h

	;incbin "MESPUT.COM", $, 0904h - ($-$$+BASE_OFS)
	; There is a bit of unused text here that we could overwrite as well.

	incbin "MESPUT.COM", $

GetCharData:
	or	dh, dh
	js	short gchrdat_sjis
	
	; convert single-byte code to JIS mirror page
	; Note: AH=0 results in 8x8 characters and we don't want that.
	add	al, al		; bit 7 -> carry
	adc	ah, 29h		; ASCII (20..7F) -> page 09h, half-width Katakana (A0..DF) -> page 0Ah
	shr	al, 1		; revert additon
	jmp	short gchrdat_jis

gchrdat_sjis:
	mov	al, dh
	sub	al, 70h
	cmp	al, 30h
	jb	short loc_105E6
	sub	al, 40h
loc_105E6:
	add	al, al
	mov	dh, al
	mov	al, dl
	cmp	al, 80h
	jb	short loc_105F2
	dec	al
loc_105F2:
	cmp	al, 9Eh
	jb	short loc_105FA
	sub	al, 5Eh
	inc	dh
loc_105FA:
	dec	dh
	sub	al, 1Fh
	mov	ah, dh
gchrdat_jis:
	mov	dx, ax
	mov	cx, chrDataRecvHdr
	mov	bx, cs
	mov	ah, 14h
	int	18h
	
	mov	al, [chrDataRecvHdr+1]	; get character width
	cmp	al, 2
	jae	gblk_16	; character size == 2 -> jump
gblk_8:
	; character size == 1 -> convert from 8x16 to 16x16
	push	si
	push	di
	pushf
	mov	si, chrDataRecvBuf+(16-1)*1	; SI = last line (8x16 layout)
	mov	di, chrDataRecvBuf+(16-1)*2	; DI = last line (16x16 layout)
	std	; decrement on LOD/STO
	mov	cl, 16
	xor	ah, ah
gblk_8_loop:
	lodsb	; AL = [SI]
	stosw	; [DI] = AX (i.e. 00AL)
	dec	cl
	jnz	gblk_8_loop
	popf
	pop	di
	pop	si
gblk_16:
	retn

end:
