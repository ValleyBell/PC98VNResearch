; System-98 v3.00 patch for supporting ASCII characters
; made by Valley Bell, 2024-12-22
;
; Assembling using NASM:
;	nasm -f bin -o SYS98A30.EXE -l SYS98A30.LST "Sys98_v300_ASC.asm"
;	This requires SYS98FM.DEC.EXE/SYS98MID.DEC.EXE (91 280 bytes) to be in the same folder.
;	It also works with SYS98.EXE (91 301 bytes) if you enable the respective %define line.
;
; Note: NASM uses slightly different opcodes compared to the original PC-98 assembler for certain instructions.
;       Example "mov ah, al": "8A E0" (existing SYS98 machine code) / "88 C4" (NASM)

	use16
%define EXE_FILE "SYS98FM.DEC.EXE"
;%define EXE_FILE "SYS98MID.DEC.EXE"
;%define EXE_FILE "SYS98.EXE"
SEG_BASE_OFS EQU 120h

	org	-SEG_BASE_OFS

	; patch relocation table entry for dummied-out function
	incbin EXE_FILE, $, 0052h-($-$$)
	dw	RelocDummy, 000h	; originally: PUSH seg dseg

	incbin EXE_FILE, $, 0E23h-($-$$-SEG_BASE_OFS)
; This overwrites a function that appears to be unused.
RelocDummy:
	dw	0	; dummy value that the relocation code can change without destroying anything

getchr_read:
	lodsb
	cmp	al, 81h
	jb	short gcr_1byte		; 00..80 - half-width ASCII
	cmp	al, 0A0h
	jb	short gcr_2byte		; 81xx .. 9Fxx -> Shift-JIS
	cmp	al, 0E0h
	jb	short gcr_1byte		; A0..DF - half-width Katakana
	cmp	al, 0FDh
	jb	short gcr_2byte		; E0xx .. FCxx -> Shift-JIS
					; FD..FF - special symbols
gcr_1byte:
	xor	ah, ah
	retn

gcr_2byte:
	mov	ah, al
	lodsb
	
	; now convert Shift-JIS (reg AH/AL) to JIS code
	add	ah, ah		; AH = 00..3E / C0..FE
	sub	al, 1Fh
	js	short loc_11046
	cmp	al, 61h
	adc	al, -22h	; original_AL < 80h: subtract 21h, else subtract 22h
loc_11046:
	add	ax, 1FA1h	; AH = 1F..5D/DF..1D
	and	ax, 7F7Fh	; AH/AL now contains the JIS code for the character ROM
	retn

getchr_ank:
	mov	al, 0Bh
	out	68h, al		; Kanji Access Control: Bitmap Mode
	
	mov	al, 00h
	out	0A1h, al	; character code, 2nd byte: 00h = ANK font
	mov	al, dl
	out	0A3h, al	; character code, 1st byte: ANK character code
	
	push	di
	mov	ah, 20h		; line = 0, L/R bit = "right"
	mov	cx, 10h
ank_chr_loop:
	mov	al, ah
	out	0A5h, al	; write Name Line Counter, font pattern "right"
	in	al, 0A9h	; read Name Character Pattern Data
	stosb
	xor	al, al		; second byte: empty (characters are half-width)
	stosb
	inc	ah
	loop	ank_chr_loop	; read 10h words (20h bytes)
	pop	di
	
	mov	al, 0Ah
	out	68h, al		; Kanji Access Control: Code Access Mode
	
	xor	al, al		; AL = 0 -> half-width character
	jmp	near getchr_bold

gc_custom_qm:
	mov	cx, 8h	;10h
	mov	ax, cs
	mov	ds, ax
	mov	si, CustomQuotMarks
gc_cqm_loop:
	lodsw
	or	ax, ax
	jz	short gc_cqm_end
	cmp	ax, dx
	jz	short gc_cqm_found
	add	si, cx
	jmp	short gc_cqm_loop
	
gc_cqm_end:
	clc
	retn

gc_cqm_found:
	push	di
	mov	ax, cs
	mov	ds, ax
	
	xor	ah, ah	; keep right 8 pixels transparent
	; CX is already set properly here
gc_cqm_copyloop:
	lodsb	; read low byte (left 8 pixels)
	stosw	; write 2 bytes (16 pixels)
	loop	gc_cqm_copyloop
	
	xor	ax, ax
	mov	cx, 8h
	rep stosw	; clear remaining 8 words
	
	pop	di
	stc
	retn

; Note: I'm storing only the upper 8 lines (of 16 lines) here to save space.
CustomQuotMarks:
	dw	2B72h	; JIS 2B72: Left Single Quotation Mark (U+2018)
	db		0x00, 0x00, 0x00, 0x04, 0x08, 0x08, 0x08, 0x00
	;db		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	dw	2B73h	; JIS 2B73: Left Double Quotation Mark (U+201C)
	db		0x00, 0x00, 0x00, 0x24, 0x48, 0x48, 0x48, 0x00
	;db		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	dw	2B70h	; JIS 2B70: Right Single Quotation Mark (U+2019)
	db		0x00, 0x00, 0x00, 0x20, 0x20, 0x20, 0x40, 0x00
	;db		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	dw	2B22h	; JIS 2B22: Right Double Quotation Mark (U+201D)
	db		0x00, 0x00, 0x00, 0x24, 0x24, 0x24, 0x48, 0x00
	;db		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	dw	0

	times 0ED4h-($-$$-SEG_BASE_OFS) db 90h	; dummy out the rest of the function that we overwrote


	incbin EXE_FILE, $, 1022h-($-$$-SEG_BASE_OFS)

; Input:
;   SI - text address
;   DI - graphic destination address
; Output:
;   AL - character width (0 = half-width, 1 = full-width)
GetChrFromROM:	; seg000:1022
	push	cx
	push	dx
	push	di
	push	ds
	
	call	getchr_read
	push	si
	cmp	ax, 0020h
	jz	short getchr_space
	cmp	ax, 2121h
	jz	short getchr_space
	
	mov	dx, ax
	call	gc_custom_qm
	jc	short getchr_bold
	
	or	dh, dh
	jz	getchr_ank
	;jnz	getchr_jis
	
getchr_jis:
	mov	al, 0Bh
	out	68h, al		; Kanji Access Control: Bitmap Mode
	
	mov	al, dl
	out	0A1h, al	; character code, low byte
	mov	al, dh
	sub	al, 20h
	out	0A3h, al	; character code, high byte
	
	push	di
	xor	ah, ah
	mov	cx, 10h
loc_1105A:
	mov	al, ah
	or	al, 20h		; L/R bit = "right"
	out	0A5h, al	; write Name Line Counter, font pattern "right"
	in	al, 0A9h	; read Name Character Pattern Data
	stosb
	mov	al, ah		; L/R bit = "left"
	out	0A5h, al	; write Name Line Counter, font pattern "left"
	in	al, 0A9h	; read Name Character Pattern Data
	stosb
	inc	ah
	loop	loc_1105A	; read 10h words (20h bytes)
	pop	di
	
	mov	al, 0Ah
	out	68h, al		; Kanji Access Control: Code Access Mode
	
	mov	al, 1		; AL = 1 -> full-width
	cmp	dx, 2921h
	jb	short loc_11083
	cmp	dx, 2B7Eh
	ja	short loc_11083
	dec	al		; CX = [2921h..2B7E] -> AL = 0 -> half-width
loc_11083:
	
	cmp	dx, 777Eh
	ja	short getchr_bold	; CX = [777Fh..7F7Fh] -> make font bold
	cmp	dx, 7621h
	jb	short getchr_bold	; CX = [0..7620h] -> make font bold
	jmp	short loc_110B7	; CX = [7621h..777Eh] - custom font - keep as is

getchr_bold:
	push	ax
	
	mov	ax, es
	mov	ds, ax
	mov	si, di
	mov	cx, 10h
loc_110A8:
	lodsw
	mov	dx, ax
	add	dh, dh
	adc	dl, dl
	or	ax, dx
	stosw
	loop	loc_110A8
	
	pop	ax
loc_110B7:
	pop	si
	pop	ds
	pop	di
	pop	dx
	pop	cx
	retn

getchr_space:
	xor	dl, dl
	cmp	dl, ah
	adc	dl, 0		; DL = 0 -> half-width (AH == 0), DL = 1 -> full-width (AH > 0)
	
	xor	ax, ax
	mov	cx, 20h/2
	rep stosw		; clear character memory
	
	mov	al, dl
	jmp	short loc_110B7

	times 10BCh-($-$$-SEG_BASE_OFS) db 90h	; dummy out the rest of the function that we overwrote

	incbin EXE_FILE, $
