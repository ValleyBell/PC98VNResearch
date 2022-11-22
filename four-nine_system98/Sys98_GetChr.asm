; Input:
;   SI - text address
;   DI - graphic destination address
; Output:
;   AL - character width (0 = half-width, 1 = full-width)

GetChrFromROM:	; seg000:1022
		push	cx
		push	dx
		push	di
		push	di
		xor	ax, ax
		lodsb
		cmp	al, 80h
		jb	short getchr_space
		cmp	al, 0A0h
		jb	short getchr_jis
		cmp	al, 0E0h
		jb	short getchr_space

getchr_jis:	; seg000:1035
		mov	ah, al		; AH = 80..9F / E0..FF
		mov	al, 0Bh
		out	68h, al		; Kanji Access Control: Bitmap Mode

		lodsb			; AL = Shift-JIS secondary byte
		; now convert Shift-JIS (reg AH/AL) to JIS code
		add	ah, ah		; AH = 00..3E / C0..FE
		sub	al, 1Fh
		js	short loc_11046
		cmp	al, 61h
		adc	al, 0DEh	; original_AL < 80h: subtract -21h, else subtract 22h
loc_11046:
		add	ax, 1FA1h	; AH = 1F..5D/DF..1D
		and	ax, 7F7Fh	; AH/AL now contains the JIS code for the character ROM

		push	ax
		out	0A1h, al	; character code, low byte
					;   00h = ANK font
					;   01..7Fh = Kanji font (JIS 2nd byte)
		mov	al, ah
		sub	al, 20h
		out	0A3h, al	; character code, high byte
					;   ANK font: ANK character code
					;   Kanji font: (JIS 1st byte)-20h
					;     01h..08h, 0Ch..0DFh = full-width
					;     09h..0Bh = half-width

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
		mov	al, 0Ah
		out	68h, al		; Kanji Access Control: Code Access Mode
		pop	cx

		mov	al, 1		; AL = 1 -> full-width
		cmp	cx, 2921h
		jb	short loc_11083
		cmp	cx, 2B7Eh
		ja	short loc_11083
		dec	al		; CX = [2921h..2B7E] -> AL = 0 -> half-width
loc_11083:
		pop	di
		cmp	cx, 777Eh
		ja	short loc_1109C	; CX = [777Fh..7F7Fh] -> jump
		cmp	cx, 7621h
		jb	short loc_1109C	; CX = [0..7620h] -> jump
		jmp	short loc_110B7	; CX = [7621h..777Eh] - return
; ---------------------------------------------------------------------------

getchr_space:	; seg000:1092
		xor	al, al		; AL = 0 -> half-width
		mov	cx, 20h
		rep stosb		; clear character memory
		pop	di
		jmp	short loc_110B7
; ---------------------------------------------------------------------------

loc_1109C:
		push	ax
		push	si
		push	ds
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

		pop	ds
		pop	si
		pop	ax
loc_110B7:
		pop	di
		pop	dx
		pop	cx
		retn
