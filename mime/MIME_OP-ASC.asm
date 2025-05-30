; Assembling using NASM:
;	nasm -f bin -o MIME_OP-ASC.EXE -l MIME_OP-ASC.LST "MIME_OP-ASC.asm"
;	This requires MIME_OP.EXE (33 520 bytes) to be in the same folder.
;
;	A detailed description of how EXE files work can be found at: https://wiki.osdev.org/MZ

	use16
	cpu	186
SEG_BASE_OFS EQU 00A0h	; We assume "seg000", whose code begins at offset 00A0h in the EXE file.

	org	-SEG_BASE_OFS

seg001_Ofs EQU 74D0h
Op1_DrawSpeed EQU 0455h
Op1_FadeWidth EQU 0458h
Op1_DrawPtr EQU 045Ch
Op1_SpeedTimeout EQU 045Eh
Op1_FadeStart EQU 0466h


; include EXE header
	incbin "MIME_OP.EXE", 0, 0002h
	dw	(end-$$) & 1FFh		; number of bytes in last page
	dw	((end-$$) + 1FFh) / 200h	; total number of pages (full + partial)
	incbin "MIME_OP.EXE", $, 000Eh - ($-$$)
	dw	(end + 0Fh - $$ - SEG_BASE_OFS) / 10h	; place stack segment right after the data

; [optional patch] reduce time of Studio Twin'kle logo
	incbin "MIME_OP.EXE", $, 01FBh - ($-$$-SEG_BASE_OFS)
	; Note: The fade-in takes 100 frames (1.77s) and is part of the wait time below.
	mov	[044Ah], word 200	; show it for 100 frames (~1.8s) before fading out (originally 250-100=150 frames or ~2.7s)

; modify draw positions for intro graphic text
	incbin "MIME_OP.EXE", $, 0446h - ($-$$-SEG_BASE_OFS)
	; draw 1st line
	mov	[Op1_DrawSpeed], byte 0 ; draw quickly
	mov	ax, 80/8	; start X (originally 96/8)
	shl	ax, 1
	mov	bx, 64/16	; start Y (originally 64/16)
	imul	di, bx, 0A0h
	db	03h, 0F8h	; add	di, ax (NASM encoded this as: 01h 0C7h)
	mov	[Op1_FadeStart], di
	mov	[Op1_FadeWidth], word 496/8	; draw width (originally 480/8)

	incbin "MIME_OP.EXE", $, 048Fh - ($-$$-SEG_BASE_OFS)
	; draw 2nd line
	mov	[Op1_DrawSpeed], byte 0 ; draw quickly
	mov	ax, 80/8	; start X (originally 80/8)
	shl	ax, 1
	mov	bx, 144/16	; start Y (originally 144/16)
	imul	di, bx, 0A0h
	db	03h, 0F8h	; add	di, ax
	mov	[Op1_FadeStart], di
	mov	[Op1_FadeWidth], word 496/8	; draw width (originally 520/8)

	incbin "MIME_OP.EXE", $, 04D8h - ($-$$-SEG_BASE_OFS)
	; draw 3rd line
	mov	[Op1_DrawSpeed], byte 1 ; draw slowly
	mov	ax, 80/8	; start X (originally 160/8)
	shl	ax, 1
	mov	bx, 208/16	; start Y (originally 208/16)
	imul	di, bx, 0A0h
	db	03h, 0F8h	; add	di, ax
	mov	[Op1_FadeStart], di
	mov	[Op1_FadeWidth], word 496/8	; draw width (originally 360/8)

; add ASCII text drawing
	incbin "MIME_OP.EXE", $, 61B2h - ($-$$-SEG_BASE_OFS)
parse_text_loop:
	lodsw
	or	al, al
	jz	short loc_161F6	; 00 terminator - end
	cmp	ax, '//'
	jz	short loc_161D8	; character 2F2Fh (//) -> line end

	cmp	al, 81h
	jb	short ptl_halfwidth	; 00..80 -> ASCII
	cmp	al, 0A0h
	jb	short j_ptl_fullwidth	; 81xx .. 9Fxx -> Shift-JIS
	cmp	al, 0E0h
	jb	short ptl_halfwidth	; A0..DF -> half-width Katakana
	cmp	al, 0FDh
	jb	short j_ptl_fullwidth	; E0xx .. FCxx -> Shift-JIS

ptl_halfwidth:
	dec	si	; SI was advanced by 2 bytes, but we want only 1 byte
	xor	ah, ah
	stosw
	jmp	short parse_text_loop

j_ptl_fullwidth:
	jmp	near ptl_fullwidth

	times 61D8h-($-$$-SEG_BASE_OFS) db 90h
loc_161D8:
loc_161F6 EQU 61F6h + (loc_161D8-61D8h)

	; --- opening fade-in draw effect patch, part 2 ---
	incbin "MIME_OP.EXE", $, 6250h - ($-$$-SEG_BASE_OFS)
	mov	[Op1_SpeedTimeout], word 6	; frame timeout for slow drawing (originally: 8)
	; --- end ---

	incbin "MIME_OP.EXE", $, 6BEAh - ($-$$-SEG_BASE_OFS)
ptl_fullwidth:
	; do Shift-JIS -> ROM access code conversion
	xchg	ah, al
	add	ah, ah
	sub	al, 1Fh
	js	short loc_161C8
	cmp	al, 61h
	adc	al, -22h
loc_161C8:
	add	ax, 1FA1h
	and	ax, 7F7Fh
	xchg	ah, al
	sub	al, 20h
	; write code to text RAM
	stosw
	or	al, 80h
	stosw
	jmp	near parse_text_loop

	align	8
	db	"ASCII patch by Valley Bell.", 0

	times 6C26h-($-$$-SEG_BASE_OFS) db 90h

; translate messages
	incbin "MIME_OP.EXE", $, 6CD8h - ($-$$-SEG_BASE_OFS)
	mov	dx, aMallocError-seg001_Ofs

	incbin "MIME_OP.EXE", $, seg001_Ofs+001Ch - ($-$$-SEG_BASE_OFS)
	db	"MIME"	; patch about text
	incbin "MIME_OP.EXE", $, seg001_Ofs+0073h - ($-$$-SEG_BASE_OFS)
aFileNotFound:
	db	"File not found.\r\n$"
aMallocError:
	db	"Unable to allocate memory.\r\n$"
	times seg001_Ofs+00A9h-($-$$-SEG_BASE_OFS) db 00h

	; --- opening fade-in draw effect patch, part 2 ---
	incbin "MIME_OP.EXE", $, seg001_Ofs+0426h - ($-$$-SEG_BASE_OFS)
	; patch LUT used for fade-in animation to support 6-step drawing speed
	db	88h, 89h, 8Ah, 8Bh, 8Ch, 87h, 00h, 00h
	; --- end ---

	incbin "MIME_OP.EXE", $, seg001_Ofs+0694h - ($-$$-SEG_BASE_OFS)
OpeningText:
	incbin "MIME_OP-Text.bin"
	db	00h
	align	10h, db 00h
end:
