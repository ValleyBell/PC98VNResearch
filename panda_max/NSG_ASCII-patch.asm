; Night Slave patch for supporting half-width characters
; made by Valley Bell, 2023-11-19, update on 2023-11-25
;
; Assembling using NASM:
;	nasm -f bin -o "NSG_ASC.EXE" -l "NSG_ASC-patch.lst" "NSG_ASCII-patch.asm"
;	This requires a decrypted + decompressed NSG.EXE called "NSG.DEC2.EXE" (130 012 bytes) to be in the same folder.

	use16
PE_HEADER_SIZE EQU 130h

	org -PE_HEADER_SIZE
	incbin "NSG.DEC2.EXE", 0, PE_HEADER_SIZE+0A53Bh

; --- Part 1: ingame text (standard height) ---

SpriteDraw1B		EQU 0A1C9h
GetFontChar_H1		EQU 0A4E0h
Font_MakeBold_H1	EQU 0A636h
SomeYPosOffset		EQU 0AC1Ah


	;org	0A53Bh
PrintSJISText_H1:
		push	es
		add	dx, [cs:SomeYPosOffset]
		;mov	[cs:ptx1RemBytes], al
		;mov	[cs:ptx1PrintColor], ah
		mov	[cs:ptx1RemBytes], ax	; write ptx1RemBytes and ptx1PrintColor
		mov	byte [cs:ptx_ChrWritten], 0
		push	bx
		push	cs
		pop	es
		mov	si, bx
		mov	di, ptx1GlyphBuffer
		mov	bx, di
		mov	al, 0Bh
		out	68h, al

ptx1_next:
		lodsb
		or	al, al
		jz	near ptx1_end	; 00h - end
		cmp	al, 0Dh
		jz	short ptx1_newline ; 0Dh - new line
		cmp	al, 20h
		jb	short ptx1_next	; 01h .. 1Fh -> just read next byte
		jz	short ptx1_space ; 20h -> draw space
		cmp	al, 80h
		jb	short ptx1_ascii ; 21h .. 7Fh -> ASCII character
		
		mov	ah, al
		lodsb
		cmp	ah, 0A0h
		jb	short ptx1_sjis	; 80h .. 9Fh -> draw Shift-JIS character
		cmp	ah, 0E0h
		jb	short ptx1_space ; 0A0h .. 0DFh -> draw space
		jmp	short ptx1_sjis	; 0E0h .. 0FFh -> draw Shift-JIS character
; ---------------------------------------------------------------------------

ptx1_newline:
		mov	cx, 592		; set X position to maximum to enforce a line break
		; then fall through to space handler
ptx1_space:
		mov	ax, 1
		jmp	short ptx1_pos_advance

ptx1_ascii:
		; just convert ASCII codes to the code of the JIS mirror page
		mov	ah, 85h
		add	al, 1Fh		; 21h..5Fh ASCII -> 8540h..857Eh (mirror of ASCII characters)
		cmp	al, 7Fh
		jb	short ptx1_ascii_end
		inc	al		; 60h..7Fh ASCII -> 8580h..859Fh
ptx1_ascii_end:
		
ptx1_sjis:
		push	si
		push	di
		push	ds
		push	cx
		push	dx
		push	es
		pop	ds
		
ptx1_GetCharWidth:
		mov	cx, 2
		cmp	ax, 8540h
		jb	short ptx1_gcw_end
		cmp	ax, 869Eh
		ja	short ptx1_gcw_end
		dec	cx
ptx1_gcw_end:
		mov	[cs:ptx_ChrWidth], cx

		call	GetFontChar_H1		; get single-height font character
		call	Font_MakeBold_H1	; requires BX to be set
		pop	dx
		pop	cx
		mov	si, ptx1SpriteHdr
		;mov	di, 16		; note: discarded by SpriteDraw1A (called inside SpriteDraw1B)
		mov	ah, [cs:ptx1PrintColor]
		push	es
		;push	ds
		;pusha
		push	cx
		push	dx
		;mov	[cs:ptx1TxtXPos], cx
		;mov	[cs:ptx1TxtYPos], dx
		call	SpriteDraw1B
		pop	dx
		pop	cx
		;popa
		;pop	ds
		pop	es
		
		pop	ds
		pop	di
		pop	si
		
		mov	ax, [cs:ptx_ChrWidth]
ptx1_pos_advance:
		add	[cs:ptx_ChrWritten], al
		sub	[cs:ptx1RemBytes], al
		jbe	short ptx1_end
		
		shl	ax, 3		; 8 pixels / 16 pixels
		add	cx, ax		; advance X pointer
		cmp	cx, 592
		jb	short loc_1A5C1
		mov	cx, 48		; reset X pointer
		add	dx, byte 16	; advance Y pointer
loc_1A5C1:
		jmp	near ptx1_next
; ---------------------------------------------------------------------------

ptx1_end:				; CODE XREF: PrintSJISText_H1+1Dj
					; PrintSJISText_H1+8Aj ...
		mov	al, 0Ah
		out	68h, al
		pop	bx
		pop	es
		;mov	cx, [cs:ptx1TxtXPos]	; in the original code, but not necessary anymore
		;mov	dx, [cs:ptx1TxtYPos]
		mov	ax, si
		sub	ax, bx		; return number of processed bytes
		retn
;PrintSJISText_H1 endp

; ---------------------------------------------------------------------------
	times (0A60Ah-3)-($-$$-PE_HEADER_SIZE) db 90h

ptx_ChrWritten:	db 0
ptx_ChrWidth:	dw 0
ptx2RemBytes:
ptx1RemBytes:	db 0
ptx2PrintColor:
ptx1PrintColor:	db 0
ptx1SpriteHdr:	dw 0FFFFh, 2, 10h	; sprite header, immediately followed by sprite data
ptx1GlyphBuffer: times 20h db 0
ptx1TxtXPos:	dw 0
ptx1TxtYPos:	dw 0

	times 0A636h-($-$$-PE_HEADER_SIZE) db 0FFh


	incbin "NSG.DEC2.EXE", $, 0C2A8h - ($-$$-PE_HEADER_SIZE)

; --- Part 2: cutscene text (double height) ---

GetFontChar_H2		EQU 0C26Ch
Font_MakeBold_H2	EQU 0C3B4h
ptx2DrawChar		EQU 0CA58h

	;org	0C2A8h
PrintSJISText_H2:
		;pusha
		push	es
		;mov	[cs:ptx2RemBytes], al
		;mov	[cs:ptx2PrintColor], ah
		mov	[cs:ptx2RemBytes], ax	; write ptx2RemBytes and ptx2PrintColor
		mov	byte [cs:ptx_ChrWritten], 0
		push	bx
		push	cs
		pop	es
		mov	si, bx
		mov	di, ptx2GlyphBuffer
		mov	bx, di
		mov	al, 0Bh
		out	68h, al

ptx2_next:
		lodsb
		or	al, al
		jz	near ptx2_end	; 00h - end
		cmp	al, 0Dh
		jz	short ptx2_newline ; 0Dh - new line
		cmp	al, 20h
		jb	short ptx2_next	; 01h .. 1Fh -> just read next byte
		jz	short ptx2_space ; 20h -> draw space
		cmp	al, 80h
		jb	short ptx2_ascii ; 21h .. 7Fh -> ASCII character
		
		mov	ah, al
		lodsb
		cmp	ah, 0A0h
		jb	short ptx2_sjis	; 80h .. 9Fh -> draw Shift-JIS character
		cmp	ah, 0E0h
		jb	short ptx2_space ; 0A0h .. 0DFh -> draw space
		jmp	short ptx2_sjis	; 0E0h .. 0FFh -> draw Shift-JIS character
; ---------------------------------------------------------------------------

ptx2_newline:
		mov	cx, 592		; set X position to maximum to enforce a line break
		; then fall through to space handler
ptx2_space:
		mov	ax, 1
		jmp	short ptx2_pos_advance

ptx2_ascii:
		; just convert ASCII codes to the code of the JIS mirror page
		mov	ah, 85h
		add	al, 1Fh		; 21h..5Fh ASCII -> 8540h..857Eh (mirror of ASCII characters)
		cmp	al, 7Fh
		jb	short ptx2_ascii_end
		inc	al		; 60h..7Fh ASCII -> 8580h..859Fh
ptx2_ascii_end:
		
ptx2_sjis:
		push	si
		push	di
		push	ds
		push	cx
		push	dx
		push	es
		pop	ds
		
ptx2_GetCharWidth:
		mov	cx, 2
		cmp	ax, 8540h
		jb	short ptx2_gcw_end
		cmp	ax, 869Eh
		ja	short ptx2_gcw_end
		dec	cx
ptx2_gcw_end:
		mov	[cs:ptx_ChrWidth], cx

		call	GetFontChar_H2		; get double-height font character
		call	Font_MakeBold_H2	; requires BX to be set
		pop	dx
		pop	cx
		mov	si, ptx2SpriteHdr
		;mov	di, 16		; note: discarded by ptx2DrawChar
		mov	ah, [cs:ptx2PrintColor]
		push	es
		;push	ds
		;pusha
		push	cx
		push	dx
		mov	[cs:ptx2TxtXPos], cx	; used later by mdrWaitUserInp
		mov	[cs:ptx2TxtYPos], dx
		call	ptx2DrawChar
		;popa
		;pop	ds
		pop	dx
		pop	cx
		pop	es
		
		pop	ds
		pop	di
		pop	si
		
		mov	ax, [cs:ptx_ChrWidth]
ptx2_pos_advance:
		add	[cs:ptx_ChrWritten], al
		sub	[cs:ptx2RemBytes], al
		jbe	short ptx2_end
		
		shl	ax, 3		; 8 pixels / 16 pixels
		add	cx, ax		; advance X pointer
		cmp	cx, 592
		jb	short loc_1C329
		mov	cx, 48		; reset X pointer
		add	dx, byte 32	; advance Y pointer
loc_1C329:
		jmp	near ptx2_next
; ---------------------------------------------------------------------------

ptx2_end:				; CODE XREF: PrintSJISText_H2+1Dj
					; PrintSJISText_H2+8Aj ...
		mov	al, 0Ah
		out	68h, al
		pop	bx
		pop	es
		;popa
		mov	ax, si
		sub	ax, bx		; return number of processed bytes
		retn
;PrintSJISText_H2 endp

; ---------------------------------------------------------------------------
	times (0C368h+2)-($-$$-PE_HEADER_SIZE) db 90h

;ptx2RemBytes:	db 0		; moved to ptx1RemBytes
;ptx2PrintColor:	db 0	; move to ptx1PrintColor
ptx2SpriteHdr:	dw 0FFFFh, 2, 20h	; sprite header, immediately followed by sprite data
ptx2GlyphBuffer: times 40h db 0
ptx2TxtXPos:	dw 0	; also used by mdrWaitUserInp, so its original offset must be kept
ptx2TxtYPos:	dw 0


	incbin "NSG.DEC2.EXE", $, 0C946h - ($-$$-PE_HEADER_SIZE)

mdrDoTxtDraw		EQU 0CA4Dh	; word
mdrTextPtr		EQU 0CA4Fh	; word
mdrTextSeg		EQU 0CA51h	; word
mdrTextColor		EQU 0CA53h	; byte
mdrTxtDrawPos		EQU 0CA54h	; byte
mdrTextLen		EQU 0CA55h	; byte

	;org	0C946h
mdrTextPrint_H2:			; CODE XREF: mdr03_Text+60p
		cmp	word [cs:mdrDoTxtDraw], byte 0
		jz	loc_1C9D8
		;jmp	short loc_1C951

loc_1C951:				; CODE XREF: mdrTextPrint_H2+6j
		mov	ds, [cs:mdrTextSeg]
		mov	di, [cs:mdrTextPtr]
		
		cmp	byte [di], 0Dh
		jnz	short mtph2_normal_chr
		; force new line
		mov	byte [cs:mdrTxtDrawPos], 2+68
mtph2_normal_chr:
		
		mov	cx, 32		; text box X start
		mov	dx, 288		; text box Y start
		;mov	si, 607		; text box X end (unused)
		;mov	di, 191		; text box Y end (unused)
		add	cx, 16		; text X start offset (16 pixels border)
		add	dx, 16		; text Y start offset (16 pixels border)
		
		sub	bx, bx
		mov	bl, [cs:mdrTxtDrawPos]
		sub	bx, 2		; subtract border
		cmp	bx, byte 68
		jb	short loc_1C978
		sub	bx, byte 68	; wrap to next line
		add	dx, byte 32
loc_1C978:				; CODE XREF: mdrTextPrint_H2+2Aj
		shl	bx, 3		; pixel X = text X * 8
		add	cx, bx
		
		;mov	ds, [cs:mdrTextSeg]
		mov	bx, [cs:mdrTextPtr]
		mov	ah, [cs:mdrTextColor]
		mov	al, 1
		
		;push	cx	; X position
		;push	dx	; Y position
		;push	bx	; text pointer
		push	ds	; text segment
		;push	ax	; colour / number of characters
		pusha		; combined push of AX/CX/DX/BX (and others)
		inc	dx
		mov	ah, 00h		; force colour 00h (black)
		call	PrintSJISText_H2 ; draw text shadow
		popa
		;pop	ax
		pop	ds
		;pop	bx
		;pop	dx
		;pop	cx
		
		call	PrintSJISText_H2 ; draw text
		; AX = return number of processed bytes
		
		add	word [cs:mdrTextPtr], ax
		sub	byte [cs:mdrTextLen], al
		jbe	short loc_1C9D0	; reached end of the text? - stop writing
		
		mov	al, [cs:ptx_ChrWritten]
		add	[cs:mdrTxtDrawPos], al
		jmp	short loc_1C9D8
; ---------------------------------------------------------------------------

loc_1C9D0:				; CODE XREF: mdrTextPrint_H2+82j
		mov	word [cs:mdrDoTxtDraw], 0
		retn
; ---------------------------------------------------------------------------

loc_1C9D8:
	times 0C9D8h-($-$$-PE_HEADER_SIZE) db 90h


	incbin "NSG.DEC2.EXE", $
