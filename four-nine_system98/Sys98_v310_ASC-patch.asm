; System-98 v3.10 patch for supporting ASCII characters
; made by Valley Bell, 2022-11-19
;
; Assembling using NASM:
;	nasm -f bin -o SYS98A31.EXE -l SYS98A31.LST "Sys98_v310_ASC-patch.asm"
;	This requires SYS98.EXE (91 301 bytes) to be in the same folder.
;
; Note: NASM uses slightly different opcodes compared to the original PC-98 assembler for certain instructions.
;       Example "mov ah, al": "8A E0" (existing SYS98 machine code) / "88 C4" (NASM)

	use16
PE_HEADER_SIZE EQU 120h

	incbin "SYS98.EXE", 0, PE_HEADER_SIZE+0E23h
	;org	PE_HEADER_SIZE+0E23h	; insert data at seg000:0E23
	
	hlt
	jmp	short $-1	; The function we are overwriting *SHOULD* be unused, but let's freeze here just in case.
	times 0Dh db 00h	; The function we want to use starts at 0E23h, but one value gets relocated,
				; so we insert some dummy some data to get a safe location.

; --- code to get ASCII characters (ANK font) from font ROM ---
; This overwrites a function that appears to be unused.
getchr_ank:
	mov	ah, al		; AH = 00..7F
	mov	al, 0Bh
	out	68h, al		; Kanji Access Control: Bitmap Mode
	
	mov	al, 00h
	out	0A1h, al	; character code, 2nd byte: 00h = ANK font
	mov	al, ah
	out	0A3h, al	; character code, 1st byte: ANK character code
	
	xor	ah, ah
	mov	cx, 10h
ank_chr_loop:
	mov	al, ah
	or	al, 20h		; L/R bit = "right"
	out	0A5h, al	; write Name Line Counter, font pattern "right"
	in	al, 0A9h	; read Name Character Pattern Data
	stosb
	xor	al, al		; second byte: empty (characters are half-width)
	stosb
	inc	ah
	loop	ank_chr_loop	; read 10h words (20h bytes)
	
	mov	al, 0Ah
	out	68h, al		; Kanji Access Control: Code Access Mode
	xor	al, al		; AL = 0 -> half-width character
	pop	di
	
	;jmp	loc_110B7
	; It's only 3 instructions, so let's inline them here.
	pop	di
	pop	dx
	pop	cx
	ret

	times 0FF4h-($-$$) db 00h	; dummy out the rest of the function that we overwrote

	incbin "SYS98.EXE", $-$$, PE_HEADER_SIZE+1026h-($-$$)
	;org	PE_HEADER_SIZE+1026h	; insert at seg000:1026

; --- code injection for ASCII support ---
; This patches the "GetChrFromROM" function.
	; Note: We overwrite the "xor ax, ax" instruction in order to make space for the 16-bit jump.
	; In theory, this can cause AH be garbage.
	; However in this case, no unwanted side effects are caused.
	;   1. The code path reading Shift-JIS (getchr_jis) sets AH to 0 before returning.
	;   2. The code path that returns a space (getchr_space) does NOT set AH,
	;      but all callers (GetChrData and loc_125D6) only access AL.
	lodsb
	cmp	al, 80h
	jb	near getchr_ank

	incbin "SYS98.EXE", $
	;org	PE_HEADER_SIZE+1026h	; insert at seg000:1026
