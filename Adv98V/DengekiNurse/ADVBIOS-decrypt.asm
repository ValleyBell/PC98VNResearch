seg001		segment	byte public 'CODE' use16
		assume cs:seg001
		assume es:nothing, ss:seg002, ds:nothing, fs:nothing, gs:nothing

start:
		call	sub_14ED4
; ---------------------------------------------------------------------------

		db 'TC0'
		dw 1			; key initialization
		dw 4EC0h		; number of bytes to decrypt
		dw 100h			; decryption start offset
		dw 0			; code start pointer [MZ file offset 0x14]
		dw 4E7h			; code start segment [MZ file offset 0x16]
		dw 80h			; stack pointer [MZ file offset 0x10]
		dw 30A0h		; stack segment [MZ file offset 0x0E]

; =============== S U B R O U T I N E =======================================

sub_14ED4	proc near
		pop	bx
		add	bx, 3		; skip "TC0" signature
		push	cs
		pop	ds
		;assume ds:seg001
		mov	ax, es
		add	ax, 10h
		add	[bx+8],	ax
		add	[bx+0Ch], ax
		
		mov	ax, [bx]	; key initialization
		mov	cx, [bx+2]	; number of bytes to decrypt
		mov	di, [bx+4]	; decryption start offset
		mov	si, 2711h
loc_14EF0:
		mul	si
		add	ax, 3619h
		mov	dx, ax
		rol	dx, 1
		rol	dx, 1
		xor	es:[di], dh
		inc	di
		loop	loc_14EF0
		
		cli
		mov	ss, word ptr [bx+0Ch]
		mov	sp, [bx+0Ah]
		sti
		push	es
		pop	ds
		jmp	dword ptr cs:[bx+6]
sub_14ED4	endp
