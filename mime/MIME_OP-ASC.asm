; Assembling using NASM:
;	nasm -f bin -o MIME_OP-ASC.EXE -l MIME_OP-ASC.LST "MIME_OP-ASC.asm"
;	This requires MIME_OP.EXE (33 520 bytes) to be in the same folder.
;
;	A detailed description of how EXE files work can be found at: https://wiki.osdev.org/MZ

	use16
SEG_BASE_OFS EQU 00A0h	; We assume "seg000", whose code begins at offset 00A0h in the EXE file.

	org	-SEG_BASE_OFS

seg001_Ofs EQU 74D0h


; include EXE header
	incbin "MIME_OP.EXE", 0, 000Eh
	dw	(end + 0Fh - $$ - SEG_BASE_OFS) / 10h	; write number of data paragraphs

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
	jb	ptl_fullwidth		; 81xx .. 9Fxx -> Shift-JIS
	cmp	al, 0E0h
	jb	short ptl_halfwidth	; A0..DF -> half-width Katakana
	cmp	al, 0FDh
	jb	ptl_fullwidth		; E0xx .. FCxx -> Shift-JIS

ptl_halfwidth:
	dec	si	; SI was advanced by 2 bytes, but we want only 1 byte
	xor	ah, ah
	stosw
	jmp	short parse_text_loop

	times 61D8h-($-$$-SEG_BASE_OFS) db 90h
loc_161D8:
loc_161F6 EQU 61F6h + (loc_161D8-61D8h)

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

	incbin "MIME_OP.EXE", $, seg001_Ofs+0694h - ($-$$-SEG_BASE_OFS)
OpeningText:
	incbin "MIME_OP-Text.bin"
	db	00h
	align	10h, db 00h
end:
