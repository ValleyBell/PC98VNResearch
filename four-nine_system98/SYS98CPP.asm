; Input	MD5   :	EAF5E33F312479086428ED9D2877BC59
; Input	CRC32 :	150185B4

; File Name   :	D:\SYS98CPP.COM
; Format      :	MS-DOS COM-file
; Base Address:	1000h Range: 10100h-1A54Ah Loaded length: A44Ah

		.686p
		.mmx
		.model tiny

; ===========================================================================

; Segment type:	Pure code
seg000		segment	byte public 'CODE' use16
		assume cs:seg000
		org 100h
		assume es:nothing, ss:nothing, ds:seg000, fs:nothing, gs:nothing

; =============== S U B	R O U T	I N E =======================================


		public start
start		proc near
		call	sub_10137
		call	ParseArguments
		call	PreallocMemory
		call	ReadSceneFile
		call	SetupInt0A_24
		call	SetupInt15
		mov	ds, cs:SceneDataSeg
		mov	si, 100h	; script data starts at	offset 100h

ScriptMainLoop:				; CODE XREF: seg000:0B52j seg000:0B89j ...
		cmp	cs:byte_1A049, 0
		jz	short loc_10125
		call	sub_103F9

loc_10125:				; CODE XREF: start+20j
		lodsw
		cmp	ax, 100h
		jb	short loc_1012D
		xor	ax, ax		; command word >= 100h -> set to 00h (sExitDOS)

loc_1012D:				; CODE XREF: start+29j
		add	ax, ax

loc_1012F:				; DATA XREF: sub_11D10+1FBr
					; sub_11D10+3DCr ...
		add	ax, offset scriptFuncList
		mov	bx, ax

loc_10134:				; DATA XREF: DoPalThing+10r
					; sub_11D10+94r ...
		jmp	word ptr cs:[bx]
start		endp


; =============== S U B	R O U T	I N E =======================================


sub_10137	proc near		; CODE XREF: startp
					; DATA XREF: sub_11D10:loc_11E6Ar ...
		mov	ah, 41h
		int	18h		; DATA XREF: sub_11D10+1BBw
					; sub_11D10+39Cw ...
					; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		mov	ch, 0C0h
		mov	ah, 42h		; DATA XREF: sub_11D10+1B6w
					; sub_11D10+1F7r ...
		int	18h		; DATA XREF: sub_11D10:loc_11EDEr
					; sub_11D10:loc_120BFr	...
					; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		mov	al, 1		; DATA XREF: sub_11D10+1C9r
					; sub_11D10+3AAr ...
		out	6Ah, al		; DATA XREF: sub_11D10+1E0r
					; sub_11D10+3C1r ...
		mov	al, 41h
		out	6Ah, al
		mov	ah, 40h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		push	cs
		pop	ds
		mov	dx, offset a03l1h5h ; "\x1B)0\x1B[>3l\x1B[>1h\x1B[>5h\x1B*$"
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		retn
sub_10137	endp

; ---------------------------------------------------------------------------
a03l1h5h	db 1Bh,')0',1Bh,'[>3l',1Bh,'[>1h',1Bh,'[>5h',1Bh,'*$'
					; DATA XREF: sub_10137+18o

; =============== S U B	R O U T	I N E =======================================


ParseArguments	proc near		; CODE XREF: start+3p

; FUNCTION CHUNK AT 01CF SIZE 0000000C BYTES

		push	cs
		pop	ds
		mov	si, 81h
		push	cs
		pop	es
		assume es:seg000
		mov	di, offset scenePathPtr
		push	di
		mov	bx, 8
		mov	cx, 4

loc_1017D:				; CODE XREF: ParseArguments+3Bj
		call	SkipSpaces
		cmp	al, 0Dh
		jz	short loc_101AA
		mov	ax, di
		add	ax, bx
		stosw
		dec	bx
		dec	bx

loc_1018B:				; CODE XREF: ParseArguments+34j
		mov	ax, cs:[si]
		cmp	al, 0Dh
		jz	short loc_101AA
		cmp	al, 20h
		jz	short loc_101A2
		cmp	ax, 8140h
		jz	short loc_101A2
		mov	cs:[bx+di], al
		inc	bx
		inc	si
		jmp	short loc_1018B
; ---------------------------------------------------------------------------

loc_101A2:				; CODE XREF: ParseArguments+28j
					; ParseArguments+2Dj
		mov	byte ptr cs:[bx+di], 0
		inc	bx
		loop	loc_1017D
		dec	bx

loc_101AA:				; CODE XREF: ParseArguments+16j
					; ParseArguments+24j
		mov	byte ptr cs:[bx+di], 0
		mov	ax, di
		pop	di
		sub	ax, di
		shr	ax, 1
		mov	cs:byte_19E47, al
		cmp	al, 2
		jb	short loc_101CF
		retn
ParseArguments	endp


; =============== S U B	R O U T	I N E =======================================


SkipSpaces	proc near		; CODE XREF: ParseArguments:loc_1017Dp
					; SkipSpaces+Fj
		mov	ax, cs:[si]
		cmp	al, 20h
		jz	short loc_101CC
		cmp	ax, 8140h
		jz	short loc_101CB
		retn
; ---------------------------------------------------------------------------

loc_101CB:				; CODE XREF: SkipSpaces+Aj
		inc	si

loc_101CC:				; CODE XREF: SkipSpaces+5j
		inc	si
		jmp	short SkipSpaces
SkipSpaces	endp

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR ParseArguments

loc_101CF:				; CODE XREF: ParseArguments+4Fj
		mov	dx, offset aSystem98Ver	; "SYSTEM-98 TYPE-C++ Assembler	Version	1."...
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		mov	ax, 4C00h
		int	21h		; DOS -	2+ - QUIT WITH EXIT CODE (EXIT)
; END OF FUNCTION CHUNK	FOR ParseArguments ; AL	= exit code

; =============== S U B	R O U T	I N E =======================================


PreallocMemory	proc near		; CODE XREF: start+6p
		push	cs
		pop	es
		mov	bx, 1000h
		mov	ah, 4Ah
		int	21h		; DOS -	2+ - ADJUST MEMORY BLOCK SIZE (SETBLOCK)
					; ES = segment address of block	to change
					; BX = new size	in paragraphs
		jb	short loc_10228
		mov	bx, 1000h
		mov	ah, 48h
		int	21h		; DOS -	2+ - ALLOCATE MEMORY
					; BX = number of 16-byte paragraphs desired
		jb	short loc_10228
		mov	cs:SceneDataSeg, ax
		mov	bx, 1000h
		mov	ah, 48h
		int	21h		; DOS -	2+ - ALLOCATE MEMORY
					; BX = number of 16-byte paragraphs desired
		jb	short loc_10228
		mov	cs:word_19FCE, ax
		mov	bx, 1000h
		mov	ah, 48h
		int	21h		; DOS -	2+ - ALLOCATE MEMORY
					; BX = number of 16-byte paragraphs desired
		jb	short loc_10228
		mov	cs:word_19FD2, ax
		mov	bx, 1000h
		mov	ah, 48h
		int	21h		; DOS -	2+ - ALLOCATE MEMORY
					; BX = number of 16-byte paragraphs desired
		jb	short loc_10228
		mov	cs:word_19FD4, ax
		mov	bx, 1000h
		mov	ah, 48h
		int	21h		; DOS -	2+ - ALLOCATE MEMORY
					; BX = number of 16-byte paragraphs desired
		jb	short loc_10228
		mov	cs:word_19FD6, ax
		retn
; ---------------------------------------------------------------------------

loc_10228:				; CODE XREF: PreallocMemory+9j
					; PreallocMemory+12j ...
		push	cs
		pop	ds
		mov	dx, offset aNotEnoughMem ; "åªç›ÇÃÉÅÉÇÉäèÛãµÇ≈ÇÕÉVÉXÉeÉÄÇé¿çsÇ≈Ç´Ç"...
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		mov	ax, 4C00h
		int	21h		; DOS -	2+ - QUIT WITH EXIT CODE (EXIT)
PreallocMemory	endp			; AL = exit code


; =============== S U B	R O U T	I N E =======================================


ReadSceneFile	proc near		; CODE XREF: start+9p
		push	cs
		pop	ds
		mov	dx, cs:scenePathPtr
		mov	ax, 3D00h
		int	21h		; DOS -	2+ - OPEN DISK FILE WITH HANDLE
					; DS:DX	-> ASCIZ filename
					; AL = access mode
					; 0 - read
		jb	short loc_10266
		mov	ds, cs:SceneDataSeg
		xor	dx, dx
		mov	cx, 0FFFFh
		mov	bx, ax
		mov	ah, 3Fh
		int	21h		; DOS -	2+ - READ FROM FILE WITH HANDLE
					; BX = file handle, CX = number	of bytes to read
					; DS:DX	-> buffer
		pushf
		mov	ah, 3Eh
		int	21h		; DOS -	2+ - CLOSE A FILE WITH HANDLE
					; BX = file handle
		mov	si, 100h

loc_1025C:				; CODE XREF: ReadSceneFile+2Aj
		xor	byte ptr [si], 1
		inc	si
		jnz	short loc_1025C
		popf
		jb	short loc_10266
		retn
; ---------------------------------------------------------------------------

loc_10266:				; CODE XREF: ReadSceneFile+Cj
					; ReadSceneFile+2Dj
		push	cs
		pop	ds
		mov	dx, offset aFileLoadErr	; "ÉtÉ@ÉCÉãÇÃì«Ç›çûÇ›Ç…é∏îsÇµÇ‹ÇµÇΩ\r\nÉfÉBÉ"...
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		mov	ax, 4C00h
		int	21h		; DOS -	2+ - QUIT WITH EXIT CODE (EXIT)
ReadSceneFile	endp			; AL = exit code


; =============== S U B	R O U T	I N E =======================================


SetupInt0A_24	proc near		; CODE XREF: start+Cp
		push	0
		pop	ds
		assume ds:nothing
		or	byte ptr ds:500h, 20h
		xor	ax, ax
		mov	cs:word_19ED4, ax
		mov	cs:word_19FD0, ax
		mov	bx, cs:word_19E4A
		mov	al, cs:[bx]
		sub	al, 30h
		mov	cs:byte_1A00E, al
		mov	ax, 350Ah
		int	21h		; DOS -	2+ - GET INTERRUPT VECTOR
					; AL = interrupt number
					; Return: ES:BX	= value	of interrupt vector
		mov	word ptr cs:OldIntVec0A, bx
		mov	word ptr cs:OldIntVec0A+2, es
		push	cs
		pop	ds
		assume ds:seg000
		mov	dx, offset loc_10A1E
		mov	ax, 250Ah
		int	21h		; DOS -	SET INTERRUPT VECTOR
					; AL = interrupt number
					; DS:DX	= new vector to	be used	for specified interrupt
		in	al, 2		; DMA controller, 8237A-5.
					; channel 1 current address
		and	al, 0FBh
		out	2, al		; DMA controller, 8237A-5.
					; channel 1 base address
					; (also	sets current address)
		out	64h, al		; 8042 keyboard	controller command register.
		mov	ax, 3524h
		int	21h		; DOS -	2+ - GET INTERRUPT VECTOR
					; AL = interrupt number
					; Return: ES:BX	= value	of interrupt vector
		mov	word ptr cs:OldIntVec24, bx
		mov	word ptr cs:OldIntVec24+2, es
		mov	dx, offset loc_10994
		mov	ax, 2524h
		int	21h		; DOS -	SET INTERRUPT VECTOR
					; AL = interrupt number
					; DS:DX	= new vector to	be used	for specified interrupt
		mov	ds, cs:word_19FD2
		xor	dx, dx
		mov	cl, 13h
		int	0DCh		; used by BASIC	while in interpreter
		mov	ah, 19h
		int	21h		; DOS -	GET DEFAULT DISK NUMBER
		cbw
		mov	bx, ax
		add	bx, bx
		add	al, 41h
		mov	cs:DiskLetter, al
		mov	ax, [bx+1Ah]
		and	ah, 0F0h
		sub	ah, 90h
		mov	cs:byte_19F75, ah
		retn
SetupInt0A_24	endp


; =============== S U B	R O U T	I N E =======================================


RestoreInts	proc near		; CODE XREF: seg000:loc_1092Ap
					; seg000:sUndefinedp ...
		mov	es, cs:word_19FD6
		assume es:nothing
		mov	ah, 49h
		int	21h		; DOS -	2+ - FREE MEMORY
					; ES = segment address of area to be freed
		mov	es, cs:word_19FD4
		mov	ah, 49h
		int	21h		; DOS -	2+ - FREE MEMORY
					; ES = segment address of area to be freed
		mov	es, cs:word_19FD2
		mov	ah, 49h
		int	21h		; DOS -	2+ - FREE MEMORY
					; ES = segment address of area to be freed
		mov	es, cs:word_19FCE
		mov	ah, 49h
		int	21h		; DOS -	2+ - FREE MEMORY
					; ES = segment address of area to be freed
		mov	es, cs:SceneDataSeg
		mov	ah, 49h
		int	21h		; DOS -	2+ - FREE MEMORY
					; ES = segment address of area to be freed
		cli
		in	al, 0Ah		; DMA controller, 8237A-5.
					; single mask bit register
					; 0-1: select channel (00=0; 01=1; 10=2; 11=3)
					; 2: 1=set mask	for channel; 0=clear mask (enable)
		or	al, 24h
		out	0Ah, al		; DMA controller, 8237A-5.
					; single mask bit register
					; 0-1: select channel (00=0; 01=1; 10=2; 11=3)
					; 2: 1=set mask	for channel; 0=clear mask (enable)
		mov	dx, 7FDFh
		mov	al, 9
		out	dx, al
		sti
		lds	dx, cs:OldIntVec0A
		mov	ax, 250Ah
		int	21h		; DOS -	SET INTERRUPT VECTOR
					; AL = interrupt number
					; DS:DX	= new vector to	be used	for specified interrupt
		lds	dx, cs:dword_1A039
		mov	ax, 2515h
		int	21h		; DOS -	SET INTERRUPT VECTOR
					; AL = interrupt number
					; DS:DX	= new vector to	be used	for specified interrupt
		lds	dx, cs:OldIntVec24
		mov	ax, 2524h
		int	21h		; DOS -	SET INTERRUPT VECTOR
					; AL = interrupt number
					; DS:DX	= new vector to	be used	for specified interrupt
		mov	ah, 41h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		xor	al, al
		out	0A8h, al	; Interrupt Controller #2, 8259A
		out	0AAh, al	; Interrupt Controller #2, 8259A
		out	0ACh, al	; Interrupt Controller #2, 8259A
		out	0AEh, al	; Interrupt Controller #2, 8259A
		push	cs
		pop	ds
		mov	dx, offset a5l	; "\x1B*\x1B[>5l$"
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		mov	ax, 0C00h
		int	21h		; DOS -	CLEAR KEYBOARD BUFFER
					; AL must be 01h, 06h, 07h, 08h, or 0Ah.
		push	0
		pop	ds
		assume ds:nothing
		and	byte ptr ds:500h, 0DFh
		retn
RestoreInts	endp

; ---------------------------------------------------------------------------
a5l		db 1Bh,'*',1Bh,'[>5l$'  ; DATA XREF: RestoreInts+69o

; =============== S U B	R O U T	I N E =======================================


SetupInt15	proc near		; CODE XREF: start+Fp
		cli
		mov	ax, 3515h
		int	21h		; DOS -	2+ - GET INTERRUPT VECTOR
					; AL = interrupt number
					; Return: ES:BX	= value	of interrupt vector
		mov	word ptr cs:dword_1A039, bx
		mov	word ptr cs:dword_1A039+2, es
		push	cs
		pop	ds
		assume ds:seg000
		mov	dx, offset loc_10452
		mov	ax, 2515h
		int	21h		; DOS -	SET INTERRUPT VECTOR
					; AL = interrupt number
					; DS:DX	= new vector to	be used	for specified interrupt
		xor	ax, ax
		mov	cs:byte_1A04A, al
		mov	cs:byte_1A04B, al
		mov	cs:byte_1A04D, al
		mov	cs:KeyPressMask, al
		mov	cs:word_1A053, ax
		mov	cs:word_1A055, ax
		mov	cs:word_1A057, 140h
		mov	cs:word_1A059, 200
		mov	cs:word_1A05B, ax
		mov	cs:word_1A05D, ax
		mov	cs:word_1A05F, 271h
		mov	cs:word_1A061, 181h
		call	sub_1067A
		call	sub_106C0
		mov	dx, 0BFDBh
		xor	al, al
		out	dx, al
		mov	dx, 7FDFh
		mov	al, 93h
		out	dx, al
		mov	al, 8
		out	dx, al
		mov	al, 0Fh
		out	dx, al
		mov	dx, 7FDDh
		mov	al, 80h
		out	dx, al
		in	al, 0Ah		; DMA controller, 8237A-5.
					; single mask bit register
					; 0-1: select channel (00=0; 01=1; 10=2; 11=3)
					; 2: 1=set mask	for channel; 0=clear mask (enable)
		and	al, 0DFh
		out	0Ah, al		; DMA controller, 8237A-5.
					; single mask bit register
					; 0-1: select channel (00=0; 01=1; 10=2; 11=3)
					; 2: 1=set mask	for channel; 0=clear mask (enable)
		sti
		retn
SetupInt15	endp


; =============== S U B	R O U T	I N E =======================================


sub_103F9	proc near		; CODE XREF: start+22p
		cli
		mov	cs:byte_1A04A, 0
		cmp	cs:byte_1A04B, 41h
		jz	short loc_10417
		mov	bx, cs:ptrMenu1Entry
		mov	al, cs:byte_1A04C
		cbw
		mov	cs:[bx], ax
		jmp	short loc_1042F
; ---------------------------------------------------------------------------

loc_10417:				; CODE XREF: sub_103F9+Dj
		mov	bx, cs:word_1A041
		mov	ax, cs:word_1A057
		mov	cs:[bx], ax
		mov	bx, cs:word_1A043
		mov	ax, cs:word_1A059
		mov	cs:[bx], ax

loc_1042F:				; CODE XREF: sub_103F9+1Cj
		mov	bx, cs:ptrUserAction
		mov	al, cs:KeyPressMask
		cbw
		mov	cs:[bx], ax
		mov	cs:byte_1A049, ah
		sti
		mov	ah, al

loc_10444:				; CODE XREF: sub_103F9+51j
		mov	al, cs:KeyPressMask
		cmp	al, ah
		jz	short loc_10444
		mov	si, cs:scrMenuJumpPtr
		retn
sub_103F9	endp

; ---------------------------------------------------------------------------

loc_10452:				; DATA XREF: SetupInt15+12o
		pusha
		push	ds
		push	es
		in	al, 0Ah		; DMA controller, 8237A-5.
					; single mask bit register
					; 0-1: select channel (00=0; 01=1; 10=2; 11=3)
					; 2: 1=set mask	for channel; 0=clear mask (enable)
		or	al, 20h
		out	0Ah, al		; DMA controller, 8237A-5.
					; single mask bit register
					; 0-1: select channel (00=0; 01=1; 10=2; 11=3)
					; 2: 1=set mask	for channel; 0=clear mask (enable)
		mov	al, 20h
		out	8, al		; DMA 8237A-5. cmd reg bits:
					; 0: enable mem-to-mem DMA
					; 1: enable Ch0	address	hold
					; 2: disable controller
					; 3: compressed	timing mode
					; 4: enable rotating priority
					; 5: extended write mode; 0=late write
					; 6: DRQ sensing - active high
					; 7: DACK sensing - active high
		mov	al, 0Bh
		out	8, al		; DMA 8237A-5. cmd reg bits:
					; 0: enable mem-to-mem DMA
					; 1: enable Ch0	address	hold
					; 2: disable controller
					; 3: compressed	timing mode
					; 4: enable rotating priority
					; 5: extended write mode; 0=late write
					; 6: DRQ sensing - active high
					; 7: DACK sensing - active high
		out	5Fh, al
		in	al, 8		; DMA 8237A-5. status register bits:
					; 0-3: channel 0-3 has reached terminal	count
					; 4-7: channel 0-3 has a request pending
		or	al, al
		jnz	short loc_1046F
		mov	al, 20h
		out	0, al

loc_1046F:				; CODE XREF: seg000:0469j
		sti
		mov	al, 20h
		mov	dx, 7FDDh
		out	dx, al
		mov	dx, 7FD9h
		in	al, dx
		shl	al, 4
		mov	ah, al
		mov	al, 0
		mov	dx, 7FDDh
		out	dx, al
		mov	dx, 7FD9h
		in	al, dx
		and	al, 0Fh
		or	al, ah
		cbw
		mov	cs:word_1A053, ax
		mov	al, 60h
		mov	dx, 7FDDh
		out	dx, al
		mov	dx, 7FD9h
		in	al, dx
		shl	al, 4
		mov	ah, al
		mov	al, 40h
		mov	dx, 7FDDh
		out	dx, al
		mov	dx, 7FD9h
		in	al, dx
		and	al, 0Fh
		or	al, ah
		cbw
		mov	cs:word_1A055, ax
		xor	ax, ax
		mov	es, ax
		assume es:nothing
		mov	al, es:531h
		mov	ah, al
		and	al, 4
		mov	cs:byte_1A04F, al
		mov	al, ah
		and	al, 8
		mov	cs:byte_1A051, al
		mov	al, ah
		and	al, 10h
		mov	cs:byte_1A052, al
		mov	al, ah
		and	al, 20h
		mov	cs:byte_1A050, al
		mov	al, es:532h
		mov	ah, al
		and	al, 8
		or	cs:byte_1A04F, al
		and	ah, 40h
		or	cs:byte_1A051, ah
		mov	al, es:533h
		mov	ah, al
		and	al, 1
		or	cs:byte_1A052, al
		and	ah, 8
		or	cs:byte_1A050, ah
		mov	ax, cs:word_1A053
		add	ax, cs:word_1A057
		cmp	cs:byte_1A051, 0
		jz	short loc_1051F
		sub	ax, 2
		and	ax, 0FFFEh
		jmp	short loc_1052D
; ---------------------------------------------------------------------------

loc_1051F:				; CODE XREF: seg000:0515j
		cmp	cs:byte_1A052, 0
		jz	short loc_1052D
		add	ax, 2
		and	ax, 0FFFEh

loc_1052D:				; CODE XREF: seg000:051Dj seg000:0525j
		cmp	ax, cs:word_1A05B
		jns	short loc_10538
		mov	ax, cs:word_1A05B

loc_10538:				; CODE XREF: seg000:0532j
		cmp	ax, cs:word_1A05F
		jb	short loc_10543
		mov	ax, cs:word_1A05F

loc_10543:				; CODE XREF: seg000:053Dj
		mov	cs:word_1A057, ax
		mov	ax, cs:word_1A055
		add	ax, cs:word_1A059
		cmp	cs:byte_1A04F, 0
		jz	short loc_10560
		sub	ax, 2
		and	ax, 0FFFEh
		jmp	short loc_1056E
; ---------------------------------------------------------------------------

loc_10560:				; CODE XREF: seg000:0556j
		cmp	cs:byte_1A050, 0
		jz	short loc_1056E
		add	ax, 2
		and	ax, 0FFFEh

loc_1056E:				; CODE XREF: seg000:055Ej seg000:0566j
		cmp	ax, cs:word_1A05D
		jns	short loc_10579
		mov	ax, cs:word_1A05D

loc_10579:				; CODE XREF: seg000:0573j
		cmp	ax, cs:word_1A061
		jb	short loc_10584
		mov	ax, cs:word_1A061

loc_10584:				; CODE XREF: seg000:057Ej
		mov	cs:word_1A059, ax
		mov	al, 0
		mov	dx, 7FDDh
		out	dx, al
		mov	dx, 7FD9h
		in	al, dx
		not	al
		mov	ah, al
		shr	ah, 6
		and	ah, 2
		shr	al, 5
		and	al, 1
		or	ah, al
		mov	al, es:52Ah
		and	al, 1
		or	ah, al
		mov	al, es:52Dh
		shr	al, 3
		and	al, 2
		or	ah, al
		mov	al, es:52Fh
		shr	al, 1
		and	al, 3
		or	ah, al
		mov	al, es:530h
		shr	al, 3
		and	al, 2
		or	ah, al
		mov	al, es:532h
		shr	al, 1
		and	al, 1
		or	ah, al
		mov	al, es:533h
		shr	al, 6
		and	al, 1
		or	al, ah
		mov	cs:KeyPressMask, al
		mov	cs:byte_1A049, 0
		cmp	cs:byte_1A04A, 0
		jz	short loc_10601
		mov	cs:byte_1A049, al
		cmp	cs:byte_1A04B, 40h
		jnz	short loc_10601
		call	sub_10716

loc_10601:				; CODE XREF: seg000:05F0j seg000:05FCj
		mov	ax, cs:word_1A053
		or	ax, cs:word_1A055
		or	al, cs:byte_1A04F
		or	al, cs:byte_1A050
		or	al, cs:byte_1A051
		or	al, cs:byte_1A052
		jz	short loc_10629
		call	sub_10644
		call	sub_1067A
		call	sub_106C0

loc_10629:				; CODE XREF: seg000:061Ej
		mov	dx, 7FDDh
		mov	al, 80h
		out	dx, al
		mov	al, 0A0h
		out	dx, al
		mov	al, 0C0h
		out	dx, al
		mov	al, 0E0h
		out	dx, al
		cli
		in	al, 0Ah		; DMA controller, 8237A-5.
					; single mask bit register
					; 0-1: select channel (00=0; 01=1; 10=2; 11=3)
					; 2: 1=set mask	for channel; 0=clear mask (enable)
		and	al, 0DFh
		out	0Ah, al		; DMA controller, 8237A-5.
					; single mask bit register
					; 0-1: select channel (00=0; 01=1; 10=2; 11=3)
					; 2: 1=set mask	for channel; 0=clear mask (enable)
		pop	es
		assume es:nothing
		pop	ds
		popa
		sti
		iret

; =============== S U B	R O U T	I N E =======================================


sub_10644	proc near		; CODE XREF: seg000:0620p seg000:351Ap ...
		cmp	cs:byte_1A04D, 0
		jnz	short loc_1064D
		retn
; ---------------------------------------------------------------------------

loc_1064D:				; CODE XREF: sub_10644+6j
		cld
		push	cs
		pop	ds
		mov	si, offset byte_1A065
		mov	ax, 0A800h
		call	sub_10668
		mov	ax, 0B000h
		call	sub_10668
		mov	ax, 0B800h
		call	sub_10668
		mov	ax, 0E000h
sub_10644	endp ; sp-analysis failed


; =============== S U B	R O U T	I N E =======================================


sub_10668	proc near		; CODE XREF: sub_10644+12p
					; sub_10644+18p ...
		mov	es, ax
		assume es:nothing
		mov	di, cs:word_1A063
		mov	cx, 10h

loc_10672:				; CODE XREF: sub_10668+Fj
		movsw
		movsb
		add	di, 4Dh
		loop	loc_10672
		retn
sub_10668	endp


; =============== S U B	R O U T	I N E =======================================


sub_1067A	proc near		; CODE XREF: SetupInt15+58p
					; seg000:0623p	...
		mov	dx, cs:word_1A057
		shr	dx, 3
		mov	si, cs:word_1A059
		shl	si, 4
		add	dx, si
		shl	si, 2
		add	si, dx
		mov	cs:word_1A063, si
		push	cs
		pop	es
		assume es:seg000
		mov	di, 0A065h
		mov	ax, 0A800h
		call	sub_106B0
		mov	ax, 0B000h
		call	sub_106B0
		mov	ax, 0B800h
		call	sub_106B0
		mov	ax, 0E000h
sub_1067A	endp ; sp-analysis failed


; =============== S U B	R O U T	I N E =======================================


sub_106B0	proc near		; CODE XREF: sub_1067A+24p
					; sub_1067A+2Ap ...
		cld
		mov	ds, ax
		assume ds:nothing
		push	si
		mov	cx, 10h

loc_106B7:				; CODE XREF: sub_106B0+Cj
		movsw
		movsb
		add	si, 4Dh
		loop	loc_106B7
		pop	si
		retn
sub_106B0	endp


; =============== S U B	R O U T	I N E =======================================


sub_106C0	proc near		; CODE XREF: SetupInt15+5Bp
					; seg000:0626p	...
		cmp	cs:byte_1A04D, 0
		jnz	short loc_106C9
		retn
; ---------------------------------------------------------------------------

loc_106C9:				; CODE XREF: sub_106C0+6j
		push	cs
		pop	ds
		assume ds:seg000
		mov	ax, cs:word_1A057
		and	ax, 7
		shl	ax, 5
		mov	si, ax
		shl	ax, 1
		add	si, ax
		add	si, 0A125h
		push	0A800h
		pop	es
		assume es:nothing
		mov	al, 0C0h
		out	7Ch, al
		xor	al, al
		out	7Eh, al
		out	7Eh, al
		out	7Eh, al
		out	7Eh, al
		call	sub_10706
		dec	al
		out	7Eh, al
		out	7Eh, al
		out	7Eh, al
		out	7Eh, al
		call	sub_10706
		inc	al
		out	7Ch, al
		retn
sub_106C0	endp


; =============== S U B	R O U T	I N E =======================================


sub_10706	proc near		; CODE XREF: sub_106C0+31p
					; sub_106C0+3Ep
		mov	di, cs:word_1A063
		mov	cx, 10h

loc_1070E:				; CODE XREF: sub_10706+Dj
		movsw
		movsb
		add	di, 4Dh
		loop	loc_1070E
		retn
sub_10706	endp


; =============== S U B	R O U T	I N E =======================================


sub_10716	proc near		; CODE XREF: seg000:05FEp
		mov	cs:byte_1A04C, 0
		mov	ds, cs:SceneDataSeg
		mov	si, cs:menuDataPtr

loc_10726:				; CODE XREF: sub_10716+1Bj
					; sub_10716+21j
		lodsw
		or	al, al
		jnz	short loc_1072C
		retn
; ---------------------------------------------------------------------------

loc_1072C:				; CODE XREF: sub_10716+13j
		push	ax
		call	sub_10739
		pop	ax
		jnb	short loc_10726
		mov	cs:byte_1A04C, al
		jmp	short loc_10726
sub_10716	endp


; =============== S U B	R O U T	I N E =======================================


sub_10739	proc near		; CODE XREF: sub_10716+17p
		push	si
		lodsw
		cmp	cs:word_1A057, ax
		jb	short loc_10776
		lodsw
		cmp	cs:word_1A059, ax
		jb	short loc_10776
		lodsw
		dec	ax
		cmp	ax, cs:word_1A057
		jb	short loc_10776
		lodsw
		dec	ax
		cmp	ax, cs:word_1A059
		jb	short loc_10776
		pop	si
		call	sub_10790

loc_10760:				; CODE XREF: sub_10739+39j
		push	di
		mov	ch, dl

loc_10763:				; CODE XREF: sub_10739+32j
		or	byte ptr es:[di], 4
		inc	di
		inc	di
		dec	ch
		jnz	short loc_10763
		pop	di
		add	di, 0A0h
		loop	loc_10760
		stc
		retn
; ---------------------------------------------------------------------------

loc_10776:				; CODE XREF: sub_10739+7j sub_10739+Fj ...
		pop	si
		call	sub_10790

loc_1077A:				; CODE XREF: sub_10739+53j
		push	di
		mov	ch, dl

loc_1077D:				; CODE XREF: sub_10739+4Cj
		and	byte ptr es:[di], 0E1h
		inc	di
		inc	di
		dec	ch
		jnz	short loc_1077D
		pop	di
		add	di, 0A0h
		loop	loc_1077A
		clc
		retn
sub_10739	endp


; =============== S U B	R O U T	I N E =======================================


sub_10790	proc near		; CODE XREF: sub_10739+24p
					; sub_10739+3Ep
		push	0A200h
		pop	es
		assume es:nothing
		lodsw
		mov	dx, ax
		shr	ax, 2
		mov	di, ax
		lodsw
		mov	cx, ax
		shl	ax, 1
		add	di, ax
		shl	ax, 2
		add	di, ax
		lodsw
		sub	ax, dx
		shr	ax, 3
		mov	dl, al
		lodsw
		sub	ax, cx
		shr	ax, 4
		mov	cl, al
		retn
sub_10790	endp


; =============== S U B	R O U T	I N E =======================================


sub_107B9	proc near		; CODE XREF: seg000:34A2p seg000:34C6p
		mov	ax, cs:word_1A05B
		cmp	ax, 271h
		jb	short loc_107C5
		mov	ax, 270h

loc_107C5:				; CODE XREF: sub_107B9+7j
		mov	dx, cs:word_1A05F
		cmp	dx, 271h
		jb	short loc_107D3
		mov	dx, 270h

loc_107D3:				; CODE XREF: sub_107B9+15j
		cmp	ax, dx
		jb	short loc_107D8
		xchg	ax, dx

loc_107D8:				; CODE XREF: sub_107B9+1Cj
		mov	cs:word_1A05B, ax
		mov	cs:word_1A05F, dx
		mov	ax, cs:word_1A05D
		cmp	ax, 181h
		jb	short loc_107ED
		mov	ax, 180h

loc_107ED:				; CODE XREF: sub_107B9+2Fj
		mov	dx, cs:word_1A061
		cmp	dx, 181h
		jb	short loc_107FB
		mov	dx, 180h

loc_107FB:				; CODE XREF: sub_107B9+3Dj
		cmp	ax, dx
		jb	short loc_10800
		xchg	ax, dx

loc_10800:				; CODE XREF: sub_107B9+44j
		mov	cs:word_1A05D, ax
		mov	cs:word_1A061, dx
		retn
sub_107B9	endp


; =============== S U B	R O U T	I N E =======================================


LoadFile	proc near		; CODE XREF: seg000:25B1p seg000:2825p ...
		mov	word ptr cs:loc_1092F+1, offset	aFileLoadErr ; "ÉtÉ@ÉCÉãÇÃì«Ç›çûÇ›Ç…é∏îsÇµÇ‹ÇµÇΩ\r\nÉfÉBÉ"...
		call	sub_10949
		mov	al, cs:DiskLetter
		mov	ah, 3Ah
		mov	cs:FileDiskDrive, ax
		cmp	cs:byte_19F75, 0
		jnz	short loc_1086C
		xor	ah, ah
		mov	al, [bx]
		cmp	al, 2
		cmc
		adc	byte ptr cs:FileDiskDrive, ah
		add	ax, 825Fh
		mov	byte ptr cs:a_ghgigcguvqvVG+12h, ah
		mov	byte ptr cs:a_ghgigcguvqvVG+13h, al
		call	strdup_fn
		push	ds

loc_10842:				; CODE XREF: LoadFile+60j
		push	cs
		pop	ds
		mov	dx, offset FileDiskDrive
		mov	ax, 3D00h
		int	21h		; DOS -	2+ - OPEN DISK FILE WITH HANDLE
					; DS:DX	-> ASCIZ filename
					; AL = access mode
					; 0 - read
		jnb	short loc_1087F
		mov	al, 0Ch
		call	sub_109EB
		mov	dx, offset a_ghgigcguvqvVG ; "\x1B*\x1B=+.ÉhÉâÉCÉuÇQÇ…Ç`ÉfÉBÉXÉNÇÉZÉbÉgÇµÇ"...
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"

loc_1085A:				; CODE XREF: LoadFile+56j
		mov	al, cs:KeyPressMask
		or	al, al
		jz	short loc_1085A
		mov	al, 0Dh
		call	sub_109EB
		call	sub_1096C
		jmp	short loc_10842
; ---------------------------------------------------------------------------

loc_1086C:				; CODE XREF: LoadFile+1Aj
		call	strdup_fn
		push	ds
		push	cs
		pop	ds
		mov	dx, offset FileDiskDrive
		mov	ax, 3D00h
		int	21h		; DOS -	2+ - OPEN DISK FILE WITH HANDLE
					; DS:DX	-> ASCIZ filename
					; AL = access mode
					; 0 - read
		jnb	short loc_1087F
		pop	ds
		stc
		retn
; ---------------------------------------------------------------------------

loc_1087F:				; CODE XREF: LoadFile+42j LoadFile+70j
		lds	dx, dword ptr cs:FileLoadDstPtr+2
		mov	cx, word ptr cs:FileLoadDstPtr
		mov	bx, ax
		mov	ah, 3Fh
		int	21h		; DOS -	2+ - READ FROM FILE WITH HANDLE
					; BX = file handle, CX = number	of bytes to read
					; DS:DX	-> buffer
		pushf
		mov	ah, 3Eh
		int	21h		; DOS -	2+ - CLOSE A FILE WITH HANDLE
					; BX = file handle
		popf
		pop	ds
		call	sub_1096C
		retn
LoadFile	endp

; ---------------------------------------------------------------------------
a_ghgigcguvqvVG	db 1Bh,'*',1Bh,'=+.ÉhÉâÉCÉuÇQÇ…Ç`ÉfÉBÉXÉNÇÉZÉbÉgÇµÇƒÉNÉäÉbÉNÇµÇƒâ∫Ç≥Ç¢$'
					; DATA XREF: LoadFile+49o

; =============== S U B	R O U T	I N E =======================================


WriteFile	proc near		; CODE XREF: seg000:2804p seg000:2859p ...
		mov	word ptr cs:loc_1092F+1, offset	aFileWriteErr ;	"ÉtÉ@ÉCÉãÇÃèëÇ´çûÇ›Ç…é∏îsÇµÇ‹ÇµÇΩ\r\nÇeÇcÇ"...
		call	sub_10949
		mov	al, cs:DiskLetter
		mov	ah, 3Ah
		mov	cs:FileDiskDrive, ax
		cmp	cs:byte_19F75, 0
		jnz	short loc_108FB
		cmp	byte ptr [bx], 2
		cmc
		adc	byte ptr cs:FileDiskDrive, 0

loc_108FB:				; CODE XREF: WriteFile+1Aj
		call	strdup_fn
		push	ds
		push	cs
		pop	ds
		mov	dx, offset FileDiskDrive
		xor	cx, cx
		mov	ah, 3Ch
		int	21h		; DOS -	2+ - CREATE A FILE WITH	HANDLE (CREAT)
					; CX = attributes for file
					; DS:DX	-> ASCIZ filename (may include drive and path)
		jnb	short loc_1090F
		pop	ds
		stc
		retn
; ---------------------------------------------------------------------------

loc_1090F:				; CODE XREF: WriteFile+35j
		lds	dx, dword ptr cs:FileLoadDstPtr+2
		mov	cx, word ptr cs:FileLoadDstPtr
		mov	bx, ax
		mov	ah, 40h
		int	21h		; DOS -	2+ - WRITE TO FILE WITH	HANDLE
					; BX = file handle, CX = number	of bytes to write, DS:DX -> buffer
		pushf
		mov	ah, 3Eh
		int	21h		; DOS -	2+ - CLOSE A FILE WITH HANDLE
					; BX = file handle
		popf
		pop	ds
		call	sub_1096C
		retn
WriteFile	endp

; ---------------------------------------------------------------------------

loc_1092A:				; CODE XREF: seg000:25B6j seg000:2809j ...
		call	RestoreInts
		push	cs
		pop	ds

loc_1092F:				; DATA XREF: LoadFilew	WriteFilew
		mov	dx, 0
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		mov	ax, 4C00h
		int	21h		; DOS -	2+ - QUIT WITH EXIT CODE (EXIT)
					; AL = exit code

; =============== S U B	R O U T	I N E =======================================


strdup_fn	proc near		; CODE XREF: LoadFile+34p
					; LoadFile:loc_1086Cp ...
		push	cs
		pop	es
		assume es:seg000
		mov	di, offset byte_19F7E

loc_10940:				; CODE XREF: strdup_fn+Bj
		inc	bx
		mov	al, [bx]
		stosb
		or	al, al
		jnz	short loc_10940
		retn
strdup_fn	endp


; =============== S U B	R O U T	I N E =======================================


sub_10949	proc near		; CODE XREF: LoadFile+7p WriteFile+7p	...
		pusha
		push	ds
		push	es
		cld
		push	cs
		pop	es
		mov	di, 3E3Fh
		push	0A000h
		pop	ds
		assume ds:nothing
		xor	si, si
		mov	cx, 800h
		rep movsw
		push	0A200h
		pop	ds
		assume ds:nothing
		xor	si, si
		mov	cx, 800h
		rep movsw
		pop	es
		assume es:nothing
		pop	ds
		assume ds:seg000
		popa
		retn
sub_10949	endp


; =============== S U B	R O U T	I N E =======================================


sub_1096C	proc near		; CODE XREF: LoadFile+5Dp LoadFile+8Cp ...
		pusha
		push	ds
		push	es
		cld
		push	cs
		pop	ds
		mov	si, 3E3Fh
		push	0A000h
		pop	es
		assume es:nothing
		xor	di, di
		mov	cx, 800h
		rep movsw
		push	0A200h
		pop	es
		assume es:nothing
		xor	di, di
		mov	cx, 800h
		rep movsw
		mov	al, 0Dh
		call	sub_109EB
		pop	es
		assume es:nothing
		pop	ds
		popa
		retn
sub_1096C	endp

; ---------------------------------------------------------------------------

loc_10994:				; DATA XREF: SetupInt0A_24+50o
		pushf
		pusha
		push	ds
		push	es
		push	ax
		mov	al, 0Ch
		call	sub_109EB
		push	0A200h
		pop	es
		assume es:nothing
		xor	di, di
		mov	ax, 0E1h
		mov	cx, 800h
		rep stosw
		push	0A000h
		pop	es
		assume es:nothing
		xor	di, di
		mov	ax, 20h
		mov	cx, 800h
		rep stosw
		push	cs
		pop	ds
		mov	si, 9D5h
		mov	di, 65Eh
		pop	ax
		add	al, 41h
		cbw
		stosw
		mov	cx, 16h

loc_109CA:				; CODE XREF: seg000:09CCj
		movsb
		inc	di
		loop	loc_109CA
		pop	es
		assume es:nothing
		pop	ds
		popa
		popf
		mov	al, 1
		iret
; ---------------------------------------------------------------------------
aDriveIsNotMoun	db ' drive is not mounted.'

; =============== S U B	R O U T	I N E =======================================


sub_109EB	proc near		; CODE XREF: LoadFile+46p LoadFile+5Ap ...
		xchg	ah, al

loc_109ED:				; CODE XREF: sub_109EB+6j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		and	al, 2
		jnz	short loc_109ED
		xchg	ah, al
		out	0A2h, al	; Interrupt Controller #2, 8259A
		retn
sub_109EB	endp


; =============== S U B	R O U T	I N E =======================================


sub_109F8	proc near		; CODE XREF: seg000:2ED3p seg000:2ED8p ...
		xchg	ah, al

loc_109FA:				; CODE XREF: sub_109F8+6j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		and	al, 2
		jnz	short loc_109FA
		xchg	ah, al
		out	0A0h, al	; PIC 2	 same as 0020 for PIC 1
		retn
sub_109F8	endp


; =============== S U B	R O U T	I N E =======================================


WaitFrames	proc near		; CODE XREF: seg000:25CCp seg000:3144p ...
		jcxz	short locret_10A0E
		push	cx

loc_10A08:				; CODE XREF: WaitFrames+6j
		call	WaitForVSync
		loop	loc_10A08
		pop	cx

locret_10A0E:				; CODE XREF: WaitFramesj
		retn
WaitFrames	endp


; =============== S U B	R O U T	I N E =======================================


WaitForVSync	proc near		; CODE XREF: WaitFrames:loc_10A08p
					; DoPrintChrDelay:loc_11576p ...
		push	ax

loc_10A10:				; CODE XREF: WaitForVSync+5j
		in	al, 60h		; 8042 keyboard	controller data	register
		and	al, 20h
		jnz	short loc_10A10

loc_10A16:				; CODE XREF: WaitForVSync+Bj
		in	al, 60h		; 8042 keyboard	controller data	register
		and	al, 20h
		jz	short loc_10A16
		pop	ax
		retn
WaitForVSync	endp

; ---------------------------------------------------------------------------

loc_10A1E:				; DATA XREF: SetupInt0A_24+31o
		pusha
		push	ds
		push	es
		cmp	cs:idleAniActive, 0
		jz	short loc_10A7D
		mov	ax, 0A000h
		mov	es, ax
		assume es:nothing
		mov	di, cs:idleAniChar
		xor	bh, bh
		mov	bl, cs:byte_19FE3
		shl	bx, 2
		add	bx, offset word_19FEC
		mov	ax, cs:[bx]
		xchg	ah, al
		sub	al, 20h
		stosw
		or	al, 80h
		stosw
		dec	cs:word_19FE4
		jnz	short loc_10A7D
		inc	cs:byte_19FE3
		and	cs:byte_19FE3, 7
		jnz	short loc_10A63
		mov	bx, 9FE8h

loc_10A63:				; CODE XREF: seg000:0A5Ej
		add	bx, 4
		cmp	word ptr cs:[bx], 0
		jnz	short loc_10A75
		mov	cs:byte_19FE3, 0
		mov	bx, offset word_19FEC

loc_10A75:				; CODE XREF: seg000:0A6Aj
		mov	ax, cs:[bx+2]
		mov	cs:word_19FE4, ax

loc_10A7D:				; CODE XREF: seg000:0A27j seg000:0A51j
		inc	cs:scrLoopCounter
		mov	al, 20h
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
		pop	es
		assume es:nothing
		pop	ds
		popa
		iret

; =============== S U B	R O U T	I N E =======================================


GetVarPtr	proc near		; CODE XREF: GetVariable+1p
					; seg000:25DDp	...
		push	ax
		lodsw
		mov	bx, offset ScrVariables1
		add	ax, ax
		add	bx, ax
		pop	ax
		retn
GetVarPtr	endp


; =============== S U B	R O U T	I N E =======================================


GetVariable	proc near		; CODE XREF: sub_10F19p sub_10F19+7p ...
		push	bx
		call	GetVarPtr
		mov	ax, cs:[bx]
		pop	bx
		retn
GetVariable	endp


; =============== S U B	R O U T	I N E =======================================


GetLVarPtr	proc near		; CODE XREF: GetLVariable+1p
					; seg000:loc_12734p ...
		push	ax
		lodsw
		mov	bx, offset ScrVariablesL
		sub	ax, 400h
		shl	ax, 2
		add	bx, ax
		pop	ax
		retn
GetLVarPtr	endp


; =============== S U B	R O U T	I N E =======================================


GetLVariable	proc near		; CODE XREF: seg000:2758p seg000:28DDp ...
		push	bx
		call	GetLVarPtr
		mov	ax, cs:[bx]
		mov	dx, cs:[bx+2]
		pop	bx
		retn
GetLVariable	endp


; =============== S U B	R O U T	I N E =======================================


GetStringPtr	proc near		; CODE XREF: seg000:sStr_SetDatep
					; seg000:2664p	...
		push	ax
		lodsw
		mov	bx, offset ScrStringBuf
		shl	ax, 4
		add	bx, ax
		shl	ax, 2
		add	bx, ax
		pop	ax
		retn
GetStringPtr	endp


; =============== S U B	R O U T	I N E =======================================


GetTextBoxPtr	proc near		; CODE XREF: seg000:loc_10B3Fp
					; seg000:loc_10E4Fp ...
		push	ax
		push	cx
		lodsw
		mov	cl, 12h
		mul	cl
		add	ax, offset textBoxMem
		mov	bx, ax
		pop	cx
		pop	ax
		retn
GetTextBoxPtr	endp


; =============== S U B	R O U T	I N E =======================================


Int2Str_Short	proc near		; CODE XREF: PrintText+1ECp
					; seg000:33E3p
		pusha
		mov	cs:i2sTextBuf, 0
		mov	cx, 10

loc_10AE6:				; CODE XREF: Int2Str_Short+19j
		call	Int2Str_ShiftBuf
		xor	dx, dx
		div	cx
		add	dl, '0'
		mov	cs:[bx], dl
		or	ax, ax
		jnz	short loc_10AE6
		popa
		retn
Int2Str_Short	endp


; =============== S U B	R O U T	I N E =======================================


Int2Str_Long	proc near		; CODE XREF: PrintText+203p
					; seg000:33EBp
		pusha
		mov	cs:i2sTextBuf, 0

loc_10B00:				; CODE XREF: Int2Str_Long+17j
		call	Int2Str_ShiftBuf
		call	DWord_Div10
		add	cl, 30h
		mov	cs:[bx], cl
		mov	cx, ax
		or	cx, dx
		jnz	short loc_10B00
		popa
		retn
Int2Str_Long	endp


; =============== S U B	R O U T	I N E =======================================


Int2Str_ShiftBuf proc near		; CODE XREF: Int2Str_Short:loc_10AE6p
					; Int2Str_Long:loc_10B00p
		push	ax
		mov	bx, (offset i2sTextBuf+0Fh)

loc_10B18:				; CODE XREF: Int2Str_ShiftBuf+10j
		mov	al, cs:[bx-1]
		mov	cs:[bx], al
		dec	bx
		cmp	bx, offset i2sTextBuf
		jnz	short loc_10B18
		pop	ax
		retn
Int2Str_ShiftBuf endp


; =============== S U B	R O U T	I N E =======================================


DWord_Div10	proc near		; CODE XREF: Int2Str_Long+Ap
		push	ax
		mov	ax, dx
		xor	dx, dx
		mov	cx, 10
		div	cx
		mov	cx, ax
		pop	ax
		push	cx
		mov	cx, 10
		div	cx
		mov	cx, dx
		pop	dx
		retn
DWord_Div10	endp

; ---------------------------------------------------------------------------

loc_10B3F:				; CODE XREF: seg000:2C56j
		call	GetTextBoxPtr
		cmp	byte ptr cs:[bx], 8
		jz	short loc_10B55
		or	byte ptr cs:[bx+1], 0
		jz	short loc_10B55
		add	si, 0Ah
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

loc_10B55:				; CODE XREF: seg000:0B46j seg000:0B4Dj
		lodsw
		mov	cs:[bx+2], ax
		lodsw
		mov	cs:[bx+4], ax
		lodsw
		mov	cs:[bx+6], ax
		lodsw
		mov	cs:[bx+8], ax
		lodsw
		mov	cs:[bx+0Ah], ax
		mov	byte ptr cs:[bx+1], 1
		cmp	byte ptr cs:[bx], 8
		jz	short loc_10B7C
		call	sub_10B8C

loc_10B7C:				; CODE XREF: seg000:0B77j
		or	word ptr cs:[bx+0Ah], 0
		jz	short loc_10B86
		call	sub_10D03

loc_10B86:				; CODE XREF: seg000:0B81j
		call	sub_10DF4
		jmp	ScriptMainLoop

; =============== S U B	R O U T	I N E =======================================


sub_10B8C	proc near		; CODE XREF: seg000:0B79p seg000:2C93p
		push	si
		push	ds
		xor	al, al
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	es, cs:word_19FCE
		mov	di, cs:word_19FD0
		mov	cs:[bx+10h], di
		mov	ax, 0A800h
		call	sub_10BFC
		mov	ax, 0B000h
		call	sub_10BFC
		mov	ax, 0B800h
		call	sub_10BFC
		mov	ax, 0E000h
		call	sub_10BFC
		mov	dx, cs:[bx+2]
		add	dx, dx
		mov	ax, cs:[bx+4]
		shl	ax, 4
		add	dx, ax
		shl	ax, 2
		add	ax, dx
		add	ax, ax
		push	0A000h
		pop	ds
		assume ds:nothing
		mov	si, ax
		mov	cl, cs:[bx+8]

loc_10BD8:				; CODE XREF: sub_10B8C+66j
		mov	ch, cs:[bx+6]
		add	ch, ch
		push	si

loc_10BDF:				; CODE XREF: sub_10B8C+5Fj
		mov	ax, [si]
		stosw
		mov	ax, [si+2000h]
		stosw
		inc	si
		inc	si
		dec	ch
		jnz	short loc_10BDF
		pop	si
		add	si, 0A0h
		loop	loc_10BD8
		mov	cs:word_19FD0, di
		pop	ds
		assume ds:seg000
		pop	si
		retn
sub_10B8C	endp


; =============== S U B	R O U T	I N E =======================================


sub_10BFC	proc near		; CODE XREF: sub_10B8C+17p
					; sub_10B8C+1Dp ...
		cld
		mov	dx, cs:[bx+2]
		add	dx, dx
		mov	si, cs:[bx+4]
		shl	si, 4
		mov	ds, ax
		shl	si, 4
		add	dx, si
		shl	si, 2
		add	si, dx
		mov	ax, cs:[bx+8]
		shl	ax, 4

loc_10C1D:				; CODE XREF: sub_10BFC+2Dj
		mov	cx, cs:[bx+6]
		push	si
		rep movsw
		pop	si
		add	si, 50h
		dec	ax
		jnz	short loc_10C1D
		retn
sub_10BFC	endp


; =============== S U B	R O U T	I N E =======================================


sub_10C2C	proc near		; CODE XREF: seg000:2C9Dp seg000:2CC2p
		push	si
		push	ds
		push	cs
		pop	ds
		mov	si, 5E3Fh
		cmp	word ptr cs:[bx+0Ah], 1
		jz	short loc_10C51
		mov	si, 62BFh
		cmp	word ptr cs:[bx+0Ah], 2
		jz	short loc_10C51
		mov	si, 673Fh
		cmp	word ptr cs:[bx+0Ah], 3
		jz	short loc_10C51
		mov	si, 6BBFh

loc_10C51:				; CODE XREF: sub_10C2C+Cj
					; sub_10C2C+16j ...
		xor	al, al
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	ax, cs:[bx+2]
		add	ax, ax
		mov	di, cs:[bx+4]
		shl	di, 4
		shl	di, 4
		add	ax, di
		shl	di, 2
		add	di, ax
		push	di
		mov	ax, 0
		call	sub_10CD3
		mov	cx, cs:[bx+6]
		dec	cx
		dec	cx

loc_10C79:				; CODE XREF: sub_10C2C+53j
		mov	ax, 80h
		call	sub_10CD3
		loop	loc_10C79
		mov	ax, 100h
		call	sub_10CD3
		pop	di
		add	di, 500h
		mov	cx, cs:[bx+8]
		dec	cx
		dec	cx

loc_10C92:				; CODE XREF: sub_10C2C+88j
		push	cx
		push	di
		mov	ax, 180h
		call	sub_10CD3
		mov	cx, cs:[bx+6]
		dec	cx
		dec	cx

loc_10CA0:				; CODE XREF: sub_10C2C+7Aj
		mov	ax, 200h
		call	sub_10CD3
		loop	loc_10CA0
		mov	ax, 280h
		call	sub_10CD3
		pop	di
		add	di, 500h
		pop	cx
		loop	loc_10C92
		mov	ax, 300h
		call	sub_10CD3
		mov	cx, cs:[bx+6]
		dec	cx
		dec	cx

loc_10CC2:				; CODE XREF: sub_10C2C+9Cj
		mov	ax, 380h
		call	sub_10CD3
		loop	loc_10CC2
		mov	ax, 400h
		call	sub_10CD3
		pop	ds
		pop	si
		retn
sub_10C2C	endp


; =============== S U B	R O U T	I N E =======================================


sub_10CD3	proc near		; CODE XREF: sub_10C2C+44p
					; sub_10C2C+50p ...
		push	cx
		push	si
		add	si, ax
		mov	ax, 0A800h
		call	sub_10CF4
		mov	ax, 0B000h
		call	sub_10CF4
		mov	ax, 0B800h
		call	sub_10CF4
		mov	ax, 0E000h
		call	sub_10CF4
		inc	di
		inc	di
		pop	si
		pop	cx
		retn
sub_10CD3	endp


; =============== S U B	R O U T	I N E =======================================


sub_10CF4	proc near		; CODE XREF: sub_10CD3+7p sub_10CD3+Dp ...
		push	di
		mov	es, ax
		mov	cx, 10h

loc_10CFA:				; CODE XREF: sub_10CF4+Bj
		lodsw
		stosw
		add	di, 4Eh
		loop	loc_10CFA
		pop	di
		retn
sub_10CF4	endp


; =============== S U B	R O U T	I N E =======================================


sub_10D03	proc near		; CODE XREF: seg000:0B83p seg000:0E63p
		push	si
		push	ds
		push	cs
		pop	ds
		mov	si, 703Fh
		cmp	word ptr cs:[bx+0Ah], 1
		jz	short loc_10D28
		mov	si, 74BFh
		cmp	word ptr cs:[bx+0Ah], 2
		jz	short loc_10D28
		mov	si, 793Fh
		cmp	word ptr cs:[bx+0Ah], 3
		jz	short loc_10D28
		mov	si, 7DBFh

loc_10D28:				; CODE XREF: sub_10D03+Cj
					; sub_10D03+16j ...
		xor	al, al
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	ax, cs:[bx+2]
		add	ax, ax
		mov	di, cs:[bx+4]
		shl	di, 4
		shl	di, 4
		add	ax, di
		shl	di, 2
		add	di, ax
		push	di
		mov	ax, 0
		call	sub_10DAA
		mov	cx, cs:[bx+6]
		dec	cx
		dec	cx

loc_10D50:				; CODE XREF: sub_10D03+53j
		mov	ax, 80h
		call	sub_10DAA
		loop	loc_10D50
		mov	ax, 100h
		call	sub_10DAA
		pop	di
		add	di, 500h
		mov	cx, cs:[bx+8]
		dec	cx
		dec	cx

loc_10D69:				; CODE XREF: sub_10D03+88j
		push	cx
		push	di
		mov	ax, 180h
		call	sub_10DAA
		mov	cx, cs:[bx+6]
		dec	cx
		dec	cx

loc_10D77:				; CODE XREF: sub_10D03+7Aj
		mov	ax, 200h
		call	sub_10DAA
		loop	loc_10D77
		mov	ax, 280h
		call	sub_10DAA
		pop	di
		add	di, 500h
		pop	cx
		loop	loc_10D69
		mov	ax, 300h
		call	sub_10DAA
		mov	cx, cs:[bx+6]
		dec	cx
		dec	cx

loc_10D99:				; CODE XREF: sub_10D03+9Cj
		mov	ax, 380h
		call	sub_10DAA
		loop	loc_10D99
		mov	ax, 400h
		call	sub_10DAA
		pop	ds
		pop	si
		retn
sub_10D03	endp


; =============== S U B	R O U T	I N E =======================================


sub_10DAA	proc near		; CODE XREF: sub_10D03+44p
					; sub_10D03+50p ...
		push	bx
		push	cx
		push	si
		add	si, ax
		mov	bx, si
		mov	ax, 0A800h
		call	sub_10DCF
		mov	ax, 0B000h
		call	sub_10DCF
		mov	ax, 0B800h
		call	sub_10DCF
		mov	ax, 0E000h
		call	sub_10DCF
		inc	di
		inc	di
		pop	si
		pop	cx
		pop	bx
		retn
sub_10DAA	endp


; =============== S U B	R O U T	I N E =======================================


sub_10DCF	proc near		; CODE XREF: sub_10DAA+Ap
					; sub_10DAA+10p ...
		push	bx
		push	di
		mov	es, ax
		mov	cx, 10h

loc_10DD6:				; CODE XREF: sub_10DCF+20j
		mov	ax, [bx]
		or	ax, [bx+20h]
		or	ax, [bx+40h]
		or	ax, [bx+60h]
		not	ax
		and	es:[di], ax
		inc	bx
		inc	bx
		lodsw
		or	es:[di], ax
		add	di, 50h
		loop	loc_10DD6
		pop	di
		pop	bx
		retn
sub_10DCF	endp


; =============== S U B	R O U T	I N E =======================================


sub_10DF4	proc near		; CODE XREF: seg000:loc_10B86p
					; seg000:loc_10E66p ...
		push	di
		push	es
		mov	dx, cs:[bx+2]
		add	dx, dx
		mov	ax, cs:[bx+4]
		shl	ax, 4
		add	dx, ax
		shl	ax, 2
		add	ax, dx
		add	ax, ax
		push	0A000h
		pop	es
		assume es:nothing
		mov	di, ax
		mov	dx, 20h
		mov	ax, 0FFE1h
		mov	cl, cs:[bx+8]

loc_10E1C:				; CODE XREF: sub_10DF4+42j
		mov	ch, cs:[bx+6]
		add	ch, ch
		push	di

loc_10E23:				; CODE XREF: sub_10DF4+3Bj
		mov	es:[di], dx
		mov	es:[di+2000h], ax
		inc	di
		inc	di
		dec	ch
		jnz	short loc_10E23
		pop	di
		add	di, 0A0h
		loop	loc_10E1C
		mov	ax, cs:[bx+2]
		inc	ax
		add	ax, ax
		mov	cs:[bx+0Ch], ax
		mov	ax, cs:[bx+4]
		inc	ax
		mov	cs:[bx+0Eh], ax
		pop	es
		assume es:nothing
		pop	di
		retn
sub_10DF4	endp

; ---------------------------------------------------------------------------

loc_10E4F:				; CODE XREF: seg000:2CABj
		call	GetTextBoxPtr
		or	byte ptr cs:[bx+1], 0
		jnz	short loc_10E5C
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

loc_10E5C:				; CODE XREF: seg000:0E57j
		or	word ptr cs:[bx+0Ah], 0
		jz	short loc_10E66
		call	sub_10D03

loc_10E66:				; CODE XREF: seg000:0E61j
		call	sub_10DF4
		jmp	ScriptMainLoop

; =============== S U B	R O U T	I N E =======================================


sub_10E6C	proc near		; CODE XREF: seg000:2CDFp
		mov	ds, cs:word_19FCE
		mov	si, cs:[bx+10h]
		mov	cs:word_19FD0, si
		xor	al, al
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	ax, 0A800h
		call	sub_10E93
		mov	ax, 0B000h
		call	sub_10E93
		mov	ax, 0B800h
		call	sub_10E93
		mov	ax, 0E000h
sub_10E6C	endp ; sp-analysis failed


; =============== S U B	R O U T	I N E =======================================


sub_10E93	proc near		; CODE XREF: sub_10E6C+15p
					; sub_10E6C+1Bp ...
		mov	dx, cs:[bx+2]
		add	dx, dx
		mov	di, cs:[bx+4]
		shl	di, 4
		mov	es, ax
		assume es:nothing
		shl	di, 4
		add	dx, di
		shl	di, 2
		add	di, dx
		mov	ax, cs:[bx+8]
		shl	ax, 4

loc_10EB3:				; CODE XREF: sub_10E93+2Cj
		mov	cx, cs:[bx+6]
		push	di
		rep movsw
		pop	di
		add	di, 50h
		dec	ax
		jnz	short loc_10EB3
		retn
sub_10E93	endp


; =============== S U B	R O U T	I N E =======================================


sub_10EC2	proc near		; CODE XREF: seg000:2CE2p
		mov	ax, cs:[bx+2]
		add	ax, ax
		mov	di, cs:[bx+4]
		shl	di, 4
		add	ax, di
		shl	di, 2
		add	di, ax
		add	di, di
		push	0A000h
		pop	es
		assume es:nothing
		mov	cl, cs:[bx+8]

loc_10EE0:				; CODE XREF: sub_10EC2+3Aj
		mov	ch, cs:[bx+6]
		add	ch, ch
		push	di

loc_10EE7:				; CODE XREF: sub_10EC2+33j
		lodsw
		mov	es:[di], ax
		lodsw
		mov	es:[di+2000h], ax
		inc	di
		inc	di
		dec	ch
		jnz	short loc_10EE7
		pop	di
		add	di, 0A0h
		loop	loc_10EE0
		retn
sub_10EC2	endp


; =============== S U B	R O U T	I N E =======================================


sub_10EFF	proc near		; CODE XREF: seg000:loc_12DD7p
					; seg000:loc_12E31p ...
		lodsw
		mov	byte ptr cs:unk_19F58, al
		lodsw
		mov	cs:word_19F59, ax
		lodsw
		mov	cs:word_19F5B, ax
		lodsw
		mov	cs:word_19F5F, ax
		lodsw
		mov	cs:word_19F61, ax
		retn
sub_10EFF	endp


; =============== S U B	R O U T	I N E =======================================


sub_10F19	proc near		; CODE XREF: seg000:loc_12DE9p
					; seg000:loc_12E3Dp ...
		call	GetVariable
		mov	byte ptr cs:unk_19F58, al
		call	GetVariable
		mov	cs:word_19F59, ax
		call	GetVariable
		mov	cs:word_19F5B, ax
		call	GetVariable
		mov	cs:word_19F5F, ax
		call	GetVariable
		mov	cs:word_19F61, ax
		retn
sub_10F19	endp


; =============== S U B	R O U T	I N E =======================================


sub_10F3D	proc near		; CODE XREF: seg000:2E4Cp seg000:2E76p
		lodsw
		mov	cs:byte_19F64, al
		lodsw
		mov	cs:word_19F65, ax
		lodsw
		mov	cs:word_19F67, ax
		retn
sub_10F3D	endp


; =============== S U B	R O U T	I N E =======================================


sub_10F4D	proc near		; CODE XREF: seg000:2E61p seg000:2E8Bp
		call	GetVariable
		mov	cs:byte_19F64, al
		call	GetVariable
		mov	cs:word_19F65, ax
		call	GetVariable
		mov	cs:word_19F67, ax
		retn
sub_10F4D	endp


; =============== S U B	R O U T	I N E =======================================


sub_10F63	proc near		; CODE XREF: seg000:2DDAp seg000:2E34p ...
		lodsw
		mov	cs:byte_19F6B, al
		lodsw
		mov	cs:word_19F6C, ax
		lodsw
		mov	cs:word_19F6E, ax
		retn
sub_10F63	endp


; =============== S U B	R O U T	I N E =======================================


sub_10F73	proc near		; CODE XREF: seg000:2DECp seg000:2E22p ...
		call	GetVariable
		mov	cs:byte_19F6B, al
		call	GetVariable
		mov	cs:word_19F6C, ax
		call	GetVariable
		mov	cs:word_19F6E, ax
		retn
sub_10F73	endp


; =============== S U B	R O U T	I N E =======================================


sub_10F89	proc near		; CODE XREF: seg000:2DE3p seg000:2DF5p ...
		pusha
		push	ds
		mov	dx, cs:word_19F59
		mov	ax, cs:word_19F5B
		shl	ax, 4
		add	dx, ax
		shl	ax, 2
		add	ax, dx
		mov	cs:word_19F5D, ax
		mov	dx, cs:word_19F65
		mov	ax, cs:word_19F67
		shl	ax, 4
		add	dx, ax
		shl	ax, 2
		add	ax, dx
		mov	cs:word_19F69, ax
		mov	dx, cs:word_19F6C
		mov	ax, cs:word_19F6E
		shl	ax, 4
		add	dx, ax
		shl	ax, 2
		add	ax, dx
		mov	cs:word_19F70, ax
		mov	ax, 0A800h
		mov	bx, cs:word_19FD4
		call	sub_11001
		mov	ax, 0B000h
		add	bx, 800h
		call	sub_11001
		mov	ax, 0B800h
		mov	bx, cs:word_19FD6
		call	sub_11001
		mov	ax, 0E000h
		add	bx, 800h
		call	sub_11001
		xor	al, al
		out	0A6h, al	; Interrupt Controller #2, 8259A
		pop	ds
		popa
		retn
sub_10F89	endp


; =============== S U B	R O U T	I N E =======================================


sub_11001	proc near		; CODE XREF: sub_10F89+4Fp
					; sub_10F89+59p ...
		push	ax
		mov	ds, ax
		mov	si, cs:word_19F5D
		mov	es, cs:word_19FD2
		assume es:nothing
		xor	di, di
		cmp	byte ptr cs:unk_19F58, 2
		jb	short loc_1101C
		mov	ds, bx
		jmp	short loc_11022
; ---------------------------------------------------------------------------

loc_1101C:				; CODE XREF: sub_11001+15j
		mov	al, byte ptr cs:unk_19F58
		out	0A6h, al	; Interrupt Controller #2, 8259A

loc_11022:				; CODE XREF: sub_11001+19j
		mov	cx, cs:word_19F61

loc_11027:				; CODE XREF: sub_11001+34j
		push	cx
		mov	cx, cs:word_19F5F
		push	si
		rep movsb
		pop	si
		add	si, 50h
		pop	cx
		loop	loc_11027
		cmp	cs:byte_19F63, 2
		jnz	short loc_11077
		mov	es, cs:word_19FD2
		xor	di, di
		mov	si, cs:word_19F69
		cmp	cs:byte_19F64, 2
		jb	short loc_11057
		mov	ds, bx
		jmp	short loc_1105D
; ---------------------------------------------------------------------------

loc_11057:				; CODE XREF: sub_11001+50j
		mov	al, cs:byte_19F64
		out	0A6h, al	; Interrupt Controller #2, 8259A

loc_1105D:				; CODE XREF: sub_11001+54j
		mov	cx, cs:word_19F61

loc_11062:				; CODE XREF: sub_11001+74j
		push	cx
		mov	cx, cs:word_19F5F
		push	si

loc_11069:				; CODE XREF: sub_11001+6Dj
		lodsb
		or	es:[di], al
		inc	di
		loop	loc_11069
		pop	si
		add	si, 50h
		pop	cx
		loop	loc_11062

loc_11077:				; CODE XREF: sub_11001+3Cj
		cmp	cs:byte_19F63, 1
		jnz	short loc_110B7
		mov	es, cs:word_19FD2
		xor	di, di
		mov	si, cs:word_19F69
		cmp	cs:byte_19F64, 2
		jb	short loc_11097
		mov	ds, bx
		jmp	short loc_1109D
; ---------------------------------------------------------------------------

loc_11097:				; CODE XREF: sub_11001+90j
		mov	al, cs:byte_19F64
		out	0A6h, al	; Interrupt Controller #2, 8259A

loc_1109D:				; CODE XREF: sub_11001+94j
		mov	cx, cs:word_19F61

loc_110A2:				; CODE XREF: sub_11001+B4j
		push	cx
		mov	cx, cs:word_19F5F
		push	si

loc_110A9:				; CODE XREF: sub_11001+ADj
		lodsb
		and	es:[di], al
		inc	di
		loop	loc_110A9
		pop	si
		add	si, 50h
		pop	cx
		loop	loc_110A2

loc_110B7:				; CODE XREF: sub_11001+7Cj
		pop	es
		mov	di, cs:word_19F70
		mov	ds, cs:word_19FD2
		xor	si, si
		cmp	cs:byte_19F6B, 2
		jb	short loc_110D0
		mov	es, bx
		jmp	short loc_110D6
; ---------------------------------------------------------------------------

loc_110D0:				; CODE XREF: sub_11001+C9j
		mov	al, cs:byte_19F6B
		out	0A6h, al	; Interrupt Controller #2, 8259A

loc_110D6:				; CODE XREF: sub_11001+CDj
		mov	cx, cs:word_19F61

loc_110DB:				; CODE XREF: sub_11001+E8j
		push	cx
		mov	cx, cs:word_19F5F
		push	di
		rep movsb
		pop	di
		add	di, 50h
		pop	cx
		loop	loc_110DB
		retn
sub_11001	endp


; =============== S U B	R O U T	I N E =======================================


sub_110EC	proc near		; CODE XREF: seg000:2E37p seg000:2E43p
		pusha
		push	ds
		mov	dx, cs:word_19F59
		mov	ax, cs:word_19F5B
		shl	ax, 4
		add	dx, ax
		shl	ax, 2
		add	ax, dx
		mov	cs:word_19F5D, ax
		mov	dx, cs:word_19F6C
		mov	ax, cs:word_19F6E
		shl	ax, 4
		add	dx, ax
		shl	ax, 2
		add	ax, dx
		mov	cs:word_19F70, ax
		mov	al, byte ptr cs:unk_19F58
		mov	ah, cs:byte_19F6B
		or	ax, 101h
		cmp	ax, 101h
		jnz	short loc_11132
		call	sub_11155
		jmp	short loc_1114E
; ---------------------------------------------------------------------------

loc_11132:				; CODE XREF: sub_110EC+3Fj
		cmp	ax, 301h
		jnz	short loc_1113C
		call	sub_111CC
		jmp	short loc_1114E
; ---------------------------------------------------------------------------

loc_1113C:				; CODE XREF: sub_110EC+49j
		cmp	ax, 103h
		jnz	short loc_11146
		call	sub_1124F
		jmp	short loc_1114E
; ---------------------------------------------------------------------------

loc_11146:				; CODE XREF: sub_110EC+53j
		cmp	ax, 303h
		jnz	short loc_1114E
		call	sub_112D6

loc_1114E:				; CODE XREF: sub_110EC+44j
					; sub_110EC+4Ej ...
		xor	al, al
		out	0A6h, al	; Interrupt Controller #2, 8259A
		pop	ds
		popa
		retn
sub_110EC	endp


; =============== S U B	R O U T	I N E =======================================


sub_11155	proc near		; CODE XREF: sub_110EC+41p
		call	sub_1134B
		mov	ax, 0A800h
		call	sub_1116D
		mov	ax, 0B000h
		call	sub_1116D
		mov	ax, 0B800h
		call	sub_1116D
		mov	ax, 0E000h
sub_11155	endp ; sp-analysis failed


; =============== S U B	R O U T	I N E =======================================


sub_1116D	proc near		; CODE XREF: sub_11155+6p sub_11155+Cp ...
		mov	ds, ax
		assume ds:nothing
		mov	si, cs:word_19F5D
		mov	es, cs:word_19FD2
		mov	di, 8000h
		mov	al, byte ptr cs:unk_19F58
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	cx, cs:word_19F61

loc_11187:				; CODE XREF: sub_1116D+28j
		push	cx
		push	si
		mov	cx, cs:word_19F5F
		rep movsb
		pop	si
		pop	cx
		add	si, 50h
		loop	loc_11187
		push	ds
		pop	es
		assume es:nothing
		mov	di, cs:word_19F70
		mov	ds, cs:word_19FD2
		assume ds:seg000
		xor	si, si
		mov	bx, 8000h
		mov	al, cs:byte_19F6B
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	cx, cs:word_19F61

loc_111B3:				; CODE XREF: sub_1116D+5Cj
		push	cx
		push	di
		mov	cx, cs:word_19F5F

loc_111BA:				; CODE XREF: sub_1116D+55j
		lodsb
		and	al, es:[di]
		or	al, [bx]
		stosb
		inc	bx
		loop	loc_111BA
		pop	di
		pop	cx
		add	di, 50h
		loop	loc_111B3
		retn
sub_1116D	endp


; =============== S U B	R O U T	I N E =======================================


sub_111CC	proc near		; CODE XREF: sub_110EC+4Bp
		call	sub_1134B
		mov	ax, 0A800h
		mov	dx, cs:word_19FD4
		call	sub_111F6
		mov	ax, 0B000h
		add	dx, 800h
		call	sub_111F6
		mov	ax, 0B800h
		mov	dx, cs:word_19FD6
		call	sub_111F6
		mov	ax, 0E000h
		add	dx, 800h
sub_111CC	endp ; sp-analysis failed


; =============== S U B	R O U T	I N E =======================================


sub_111F6	proc near		; CODE XREF: sub_111CC+Bp
					; sub_111CC+15p ...
		mov	ds, ax
		assume ds:nothing
		mov	si, cs:word_19F5D
		mov	es, cs:word_19FD2
		assume es:nothing
		mov	di, 8000h
		mov	al, byte ptr cs:unk_19F58
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	cx, cs:word_19F61

loc_11210:				; CODE XREF: sub_111F6+28j
		push	cx
		push	si
		mov	cx, cs:word_19F5F
		rep movsb
		pop	si
		pop	cx
		add	si, 50h
		loop	loc_11210
		mov	es, dx
		mov	di, cs:word_19F70
		mov	ds, cs:word_19FD2
		assume ds:seg000
		xor	si, si
		mov	bx, 8000h
		mov	cx, cs:word_19F61

loc_11236:				; CODE XREF: sub_111F6+56j
		push	cx
		push	di
		mov	cx, cs:word_19F5F

loc_1123D:				; CODE XREF: sub_111F6+4Fj
		lodsb
		and	al, es:[di]
		or	al, [bx]
		stosb
		inc	bx
		loop	loc_1123D
		pop	di
		pop	cx
		add	di, 50h
		loop	loc_11236
		retn
sub_111F6	endp


; =============== S U B	R O U T	I N E =======================================


sub_1124F	proc near		; CODE XREF: sub_110EC+55p
		call	sub_11393
		mov	ax, cs:word_19FD4
		mov	dx, 0A800h
		call	sub_1127D
		mov	ax, cs:word_19FD4
		add	ax, 800h
		mov	dx, 0B000h
		call	sub_1127D
		mov	ax, cs:word_19FD6
		mov	dx, 0B800h
		call	sub_1127D
		mov	ax, cs:word_19FD6
		add	ax, 800h
		mov	dx, 0E000h
sub_1124F	endp ; sp-analysis failed


; =============== S U B	R O U T	I N E =======================================


sub_1127D	proc near		; CODE XREF: sub_1124F+Ap
					; sub_1124F+17p ...
		mov	ds, ax
		mov	si, cs:word_19F5D
		mov	es, cs:word_19FD2
		mov	di, 8000h
		mov	cx, cs:word_19F61

loc_11291:				; CODE XREF: sub_1127D+22j
		push	cx
		push	si
		mov	cx, cs:word_19F5F
		rep movsb
		pop	si
		pop	cx
		add	si, 50h
		loop	loc_11291
		mov	es, dx
		assume es:nothing
		mov	di, cs:word_19F70
		mov	ds, cs:word_19FD2
		xor	si, si
		mov	bx, 8000h
		mov	al, cs:byte_19F6B
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	cx, cs:word_19F61

loc_112BD:				; CODE XREF: sub_1127D+56j
		push	cx
		push	di
		mov	cx, cs:word_19F5F

loc_112C4:				; CODE XREF: sub_1127D+4Fj
		lodsb
		and	al, es:[di]
		or	al, [bx]
		stosb
		inc	bx
		loop	loc_112C4
		pop	di
		pop	cx
		add	di, 50h
		loop	loc_112BD
		retn
sub_1127D	endp


; =============== S U B	R O U T	I N E =======================================


sub_112D6	proc near		; CODE XREF: sub_110EC+5Fp
		call	sub_11393
		mov	ax, cs:word_19FD4
		call	sub_112F8
		mov	ax, cs:word_19FD4
		add	ax, 800h
		call	sub_112F8
		mov	ax, cs:word_19FD6
		call	sub_112F8
		mov	ax, cs:word_19FD6
		add	ax, 800h
sub_112D6	endp ; sp-analysis failed


; =============== S U B	R O U T	I N E =======================================


sub_112F8	proc near		; CODE XREF: sub_112D6+7p
					; sub_112D6+11p ...
		mov	ds, ax
		mov	si, cs:word_19F5D
		mov	es, cs:word_19FD2
		assume es:nothing
		mov	di, 8000h
		mov	cx, cs:word_19F61

loc_1130C:				; CODE XREF: sub_112F8+22j
		push	cx
		push	si
		mov	cx, cs:word_19F5F
		rep movsb
		pop	si
		pop	cx
		add	si, 50h
		loop	loc_1130C
		push	ds
		pop	es
		assume es:seg000
		mov	di, cs:word_19F70
		mov	ds, cs:word_19FD2
		xor	si, si
		mov	bx, 8000h
		mov	cx, cs:word_19F61

loc_11332:				; CODE XREF: sub_112F8+50j
		push	cx
		push	di
		mov	cx, cs:word_19F5F

loc_11339:				; CODE XREF: sub_112F8+49j
		lodsb
		and	al, es:[di]
		or	al, [bx]
		stosb
		inc	bx
		loop	loc_11339
		pop	di
		pop	cx
		add	di, 50h
		loop	loc_11332
		retn
sub_112F8	endp


; =============== S U B	R O U T	I N E =======================================


sub_1134B	proc near		; CODE XREF: sub_11155p sub_111CCp
		mov	al, byte ptr cs:unk_19F58
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	es, cs:word_19FD2
		assume es:nothing
		xor	di, di
		mov	si, cs:word_19F5D
		mov	cx, cs:word_19F61

loc_11362:				; CODE XREF: sub_1134B+45j
		push	cx
		push	si
		mov	cx, cs:word_19F5F

loc_11369:				; CODE XREF: sub_1134B+3Ej
		mov	dx, 0A800h
		mov	ds, dx
		assume ds:nothing
		mov	al, [si]
		mov	dx, 0B000h
		mov	ds, dx
		assume ds:nothing
		or	al, [si]
		mov	dx, 0B800h
		mov	ds, dx
		assume ds:nothing
		or	al, [si]
		mov	dx, 0E000h
		mov	ds, dx
		assume ds:nothing
		or	al, [si]
		not	al
		stosb
		inc	si
		loop	loc_11369
		pop	si
		pop	cx
		add	si, 50h
		loop	loc_11362
		retn
sub_1134B	endp


; =============== S U B	R O U T	I N E =======================================


sub_11393	proc near		; CODE XREF: sub_1124Fp sub_112D6p
		mov	al, byte ptr cs:unk_19F58
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	es, cs:word_19FD2
		xor	di, di
		mov	si, cs:word_19F5D
		mov	cx, cs:word_19F61

loc_113AA:				; CODE XREF: sub_11393+3Fj
		push	cx
		push	si
		mov	cx, cs:word_19F5F

loc_113B1:				; CODE XREF: sub_11393+38j
		mov	ds, cs:word_19FD4
		assume ds:seg000
		mov	al, [si]
		or	al, [si-8000h]
		mov	ds, cs:word_19FD6
		or	al, [si]
		or	al, [si-8000h]
		not	al
		stosb
		inc	si
		loop	loc_113B1
		pop	si
		pop	cx
		add	si, 50h
		loop	loc_113AA
		retn
sub_11393	endp


; =============== S U B	R O U T	I N E =======================================


UploadPalette	proc near		; CODE XREF: seg000:2D70p seg000:2DC8p ...
		push	ax
		push	bx
		mov	bx, offset PalTarget
		xor	ah, ah

loc_113DC:				; CODE XREF: UploadPalette+22j
		mov	al, ah
		out	0A8h, al	; Interrupt Controller #2, 8259A
		inc	ah
		mov	al, cs:[bx]
		out	0AAh, al	; Interrupt Controller #2, 8259A
		inc	bx
		mov	al, cs:[bx]
		out	0ACh, al	; Interrupt Controller #2, 8259A
		inc	bx
		mov	al, cs:[bx]
		out	0AEh, al	; Interrupt Controller #2, 8259A
		inc	bx
		cmp	ah, 10h
		jb	short loc_113DC
		pop	bx
		pop	ax
		retn
UploadPalette	endp


; =============== S U B	R O U T	I N E =======================================


sub_113FC	proc near		; CODE XREF: seg000:sPalFadeBW1p
		xor	al, al
		jmp	short loc_11402
sub_113FC	endp


; =============== S U B	R O U T	I N E =======================================


sub_11400	proc near		; CODE XREF: seg000:3102p
		mov	al, 0Fh

loc_11402:				; CODE XREF: sub_113FC+2j
		mov	bx, 9F06h
		mov	dx, cs:word_19ED4
		mov	ah, 10h

loc_1140C:				; CODE XREF: sub_11400+20j
		ror	dx, 1
		jb	short loc_1141B
		mov	cs:[bx], al
		mov	cs:[bx+1], al
		mov	cs:[bx+2], al

loc_1141B:				; CODE XREF: sub_11400+Ej
		inc	bx
		inc	bx
		inc	bx
		dec	ah
		jnz	short loc_1140C
		retn
sub_11400	endp

; ---------------------------------------------------------------------------

loc_11423:				; CODE XREF: seg000:3299p seg000:32A6p
		lodsw
		mov	dx, ax
		lodsw
		shl	ax, 4
		add	dx, ax
		shl	ax, 2
		add	ax, dx
		add	ax, ax
		push	0A000h
		pop	es
		assume es:nothing
		mov	di, ax
		mov	ax, 20E1h
		cmp	byte ptr [si+4], 0
		jz	short loc_11445

loc_11442:				; DATA XREF: seg000:3295w seg000:32A2w
		mov	ax, 0

loc_11445:				; CODE XREF: seg000:1440j
		mov	cx, [si+2]

loc_11448:				; CODE XREF: seg000:1463j
		push	cx
		mov	cx, [si]
		push	di

loc_1144C:				; CODE XREF: seg000:145Bj
		mov	es:[di], ah
		mov	byte ptr es:[di+1], 0
		mov	es:[di+2000h], al
		inc	di
		inc	di
		loop	loc_1144C
		pop	di
		add	di, 0A0h
		pop	cx
		loop	loc_11448
		lodsw
		lodsw
		lodsw
		jmp	ScriptMainLoop

; =============== S U B	R O U T	I N E =======================================


PrintText	proc near		; CODE XREF: PrintText+Bj
					; PrintText+4Dj ...

; FUNCTION CHUNK AT 1584 SIZE 00000018 BYTES
; FUNCTION CHUNK AT 161F SIZE 000001E2 BYTES
; FUNCTION CHUNK AT 185C SIZE 00000036 BYTES

		cmp	byte ptr [si], 10h
		jb	short loc_11478
		call	PrintChar
		call	DoPrintChrDelay
		jmp	short PrintText
; ---------------------------------------------------------------------------

loc_11478:				; CODE XREF: PrintText+3j
		lodsb
		cmp	al, 0
		jnz	short loc_1147E
		retn
; ---------------------------------------------------------------------------

loc_1147E:				; CODE XREF: PrintText+10j
		cmp	al, 1
		jnz	short loc_11485
		jmp	ptx01_wait_clear
; ---------------------------------------------------------------------------

loc_11485:				; CODE XREF: PrintText+15j
		cmp	al, 2
		jnz	short loc_1148C
		jmp	ptx02_wait_cont
; ---------------------------------------------------------------------------

loc_1148C:				; CODE XREF: PrintText+1Cj
		cmp	al, 3
		jnz	short loc_11493
		jmp	ptx03_set_color
; ---------------------------------------------------------------------------

loc_11493:				; CODE XREF: PrintText+23j
		cmp	al, 4
		jnz	short loc_1149A
		jmp	ptx04_show_str
; ---------------------------------------------------------------------------

loc_1149A:				; CODE XREF: PrintText+2Aj
		cmp	al, 5
		jnz	short loc_114A1
		jmp	ptx05_show_reg
; ---------------------------------------------------------------------------

loc_114A1:				; CODE XREF: PrintText+31j
		cmp	al, 9
		jnz	short loc_114A8
		jmp	ptx09_tab
; ---------------------------------------------------------------------------

loc_114A8:				; CODE XREF: PrintText+38j
		cmp	al, 0Ah
		jnz	short loc_114AF
		jmp	ptx0A_scroll	; scroll text 1	line up
; ---------------------------------------------------------------------------

loc_114AF:				; CODE XREF: PrintText+3Fj
		cmp	al, 0Bh
		jnz	short loc_114B6
		jmp	ptx0B_portrait	; show character portrait
; ---------------------------------------------------------------------------

loc_114B6:				; CODE XREF: PrintText+46j
		cmp	al, 0Dh
		jnz	short PrintText
		jmp	ptx0D_line_break
PrintText	endp


; =============== S U B	R O U T	I N E =======================================


PrintChar	proc near		; CODE XREF: PrintText+5p
		cmp	cs:textBoxID, 10h
		jb	short loc_114D8
		mov	dl, cs:ptxPosX
		mov	dh, cs:ptxPosY
		call	PutChar2TRAM
		mov	cs:ptxPosX, dl
		retn
; ---------------------------------------------------------------------------

loc_114D8:				; CODE XREF: PrintChar+6j
		mov	bx, offset textBoxMem
		mov	cl, 12h
		mov	al, cs:textBoxID
		xor	ah, ah
		mul	cl
		add	bx, ax
		mov	dl, cs:[bx+0Ch]
		mov	dh, cs:[bx+0Eh]
		call	PutChar2TRAM
		mov	cs:[bx+0Ch], dl
		retn
PrintChar	endp


; =============== S U B	R O U T	I N E =======================================


PutChar2TRAM	proc near		; CODE XREF: PrintChar+12p
					; PrintChar+32p
		mov	cl, dl
		xor	ch, ch
		mov	al, dh
		xor	ah, ah
		shl	ax, 4
		add	cx, ax
		shl	ax, 2
		add	ax, cx
		add	ax, ax
		mov	di, ax
		mov	ax, 0A000h
		mov	es, ax
		lodsb
		cmp	al, 0FDh
		jnb	short putchr_ascii
		cmp	al, 0E0h
		jnb	short putchr_sjis
		cmp	al, 0A0h
		jnb	short putchr_ascii
		cmp	al, 81h
		jnb	short putchr_sjis

putchr_ascii:				; CODE XREF: PutChar2TRAM+1Ej
					; PutChar2TRAM+26j
		xor	ah, ah		; used for half-width characters - ASCII (20h..7Eh) and	Katakana (0A0h..0DFh)
		stosw
		mov	al, cs:byte_19FE0
		mov	es:[di+1FFEh], ax
		inc	dl
		retn
; ---------------------------------------------------------------------------

putchr_sjis:				; CODE XREF: PutChar2TRAM+22j
					; PutChar2TRAM+2Aj
		mov	ah, al
		lodsb
		add	ah, ah
		sub	al, 1Fh
		js	short loc_1153F
		cmp	al, 61h
		adc	al, 0DEh

loc_1153F:				; CODE XREF: PutChar2TRAM+42j
		add	ax, 1FA1h
		and	ax, 7F7Fh
		xchg	ah, al
		sub	al, 20h
		stosw
		or	al, 80h
		stosw
		mov	al, cs:byte_19FE0
		mov	es:[di+1FFCh], ax
		mov	es:[di+1FFEh], ax
		inc	dl
		inc	dl
		retn
PutChar2TRAM	endp


; =============== S U B	R O U T	I N E =======================================


DoPrintChrDelay	proc near		; CODE XREF: PrintText+8p
					; PrintText+280p ...
		mov	cx, cs:printChrDelay
		jcxz	short locret_11583
		push	es
		xor	ax, ax
		mov	es, ax
		assume es:nothing
		mov	al, es:538h
		pop	es
		assume es:nothing
		shr	al, 2
		jb	short locret_11583 ; when Caps Lock is active -	skip

loc_11576:				; CODE XREF: DoPrintChrDelay+21j
		call	WaitForVSync
		mov	al, cs:KeyPressMask
		and	al, 1
		jnz	short locret_11583
		loop	loc_11576

locret_11583:				; CODE XREF: DoPrintChrDelay+5j
					; DoPrintChrDelay+14j ...
		retn
DoPrintChrDelay	endp

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR PrintText

ptx01_wait_clear:			; CODE XREF: PrintText+17j
		call	WaitForUser
		cmp	cs:textBoxID, 10h
		jnb	short loc_11592
		call	sub_10DF4

loc_11592:				; CODE XREF: PrintText+122j
		inc	di
		jmp	PrintText
; ---------------------------------------------------------------------------

ptx02_wait_cont:			; CODE XREF: PrintText+1Ej
		call	WaitForUser
		jmp	PrintText
; END OF FUNCTION CHUNK	FOR PrintText

; =============== S U B	R O U T	I N E =======================================


WaitForUser	proc near		; CODE XREF: PrintText:ptx01_wait_clearp
					; PrintText:ptx02_wait_contp
		mov	cs:idleAniChar,	0E50h
		cmp	cs:textBoxID, 10h
		jnb	short loc_115EA
		mov	bx, offset textBoxMem
		mov	cl, 12h
		mov	al, cs:textBoxID
		xor	ah, ah
		mul	cl
		add	bx, ax
		mov	ax, cs:[bx+2]
		add	ax, cs:[bx+6]
		dec	ax
		dec	ax
		add	ax, ax
		sub	ax, cs:idleAniPosX
		mov	dx, cs:[bx+4]
		add	dx, cs:[bx+8]
		dec	dx
		dec	dx
		sub	dx, cs:idleAniPosY
		shl	dx, 4
		add	ax, dx
		shl	dx, 2
		add	ax, dx
		add	ax, ax
		mov	cs:idleAniChar,	ax

loc_115EA:				; CODE XREF: WaitForUser+Dj
		mov	cs:idleAniActive, 0FFh

loc_115F0:				; CODE XREF: WaitForUser+5Aj
		mov	al, cs:KeyPressMask
		and	al, 2
		jz	short loc_115F0	; wait until X / Space is NOT pressed down
		mov	cs:idleAniActive, 0

loc_115FE:				; CODE XREF: WaitForUser+68j
		mov	al, cs:KeyPressMask
		and	al, 2
		jnz	short loc_115FE	; wait until X / Space is pressed down
		push	di
		push	es
		push	0A000h
		pop	es
		assume es:nothing
		mov	di, cs:idleAniChar
		mov	word ptr es:[di+2], 0
		mov	word ptr es:[di], 0
		pop	es
		assume es:nothing
		pop	di
		retn
WaitForUser	endp

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR PrintText

ptx03_set_color:			; CODE XREF: PrintText+25j
		lodsb
		shl	al, 5
		or	al, 1
		mov	cs:byte_19FE0, al
		jmp	PrintText
; ---------------------------------------------------------------------------

ptx04_show_str:				; CODE XREF: PrintText+2Cj
		lodsb
		cbw
		push	si
		push	ds
		push	cs
		pop	ds
		mov	si, offset ScrStringBuf
		shl	ax, 4
		add	si, ax
		shl	ax, 2
		add	si, ax
		call	PrintText
		pop	ds
		pop	si
		jmp	PrintText
; ---------------------------------------------------------------------------

ptx05_show_reg:				; CODE XREF: PrintText+33j
		lodsw
		cmp	ax, 400h
		jnb	short loc_1165C
		mov	bx, offset ScrVariables1
		add	bx, ax
		add	bx, ax
		mov	ax, cs:[bx]
		call	Int2Str_Short
		jnb	short loc_11671

loc_1165C:				; CODE XREF: PrintText+1E0j
		mov	bx, offset ScrVariablesL
		sub	ax, 400h
		shl	ax, 2
		add	bx, ax
		mov	ax, cs:[bx]
		mov	dx, cs:[bx+2]
		call	Int2Str_Long

loc_11671:				; CODE XREF: PrintText+1EFj
		push	si
		push	ds
		push	cs
		pop	ds
		mov	si, offset i2sTextBuf
		call	PrintText
		pop	ds
		pop	si
		jmp	PrintText
; ---------------------------------------------------------------------------

ptx09_tab:				; CODE XREF: PrintText+3Aj
		cmp	cs:textBoxID, 10h
		jb	short loc_11691
		add	cs:ptxPosX, 8
		jmp	PrintText
; ---------------------------------------------------------------------------

loc_11691:				; CODE XREF: PrintText+21Bj
		mov	bx, offset textBoxMem
		mov	cl, 12h
		mov	al, cs:textBoxID
		cbw
		mul	cl
		add	bx, ax
		add	word ptr cs:[bx+0Ch], 8
		jmp	PrintText
; ---------------------------------------------------------------------------

ptx0A_scroll:				; CODE XREF: PrintText+41j
		push	si
		push	ds
		cmp	cs:textBoxID, 10h
		jb	short loc_116F1
		mov	ax, 0A000h
		mov	ds, ax
		assume ds:nothing
		mov	si, 0A0h
		mov	es, ax
		assume es:nothing
		xor	di, di
		mov	cx, 780h
		rep movsw
		mov	si, 20A0h
		mov	di, 2000h
		mov	cx, 780h
		rep movsw
		mov	di, 0F00h
		mov	ax, 20h
		mov	cx, 50h
		rep stosw
		mov	di, 0F00h
		mov	ax, 0E1h
		mov	cx, 50h
		rep stosw
		mov	cs:ptxPosX, 0
		pop	ds
		assume ds:seg000
		pop	si
		call	DoPrintChrDelay
		jmp	PrintText
; ---------------------------------------------------------------------------

loc_116F1:				; CODE XREF: PrintText+244j
		mov	ax, 0A000h
		mov	ds, ax
		assume ds:nothing
		mov	es, ax
		mov	bx, offset textBoxMem
		mov	cl, 12h
		mov	al, cs:textBoxID
		cbw
		mul	cl
		add	bx, ax
		mov	di, cs:[bx+2]
		shl	di, 1
		mov	ax, cs:[bx+4]
		inc	ax
		shl	ax, 4
		add	di, ax
		shl	ax, 2
		add	di, ax
		shl	di, 1
		mov	si, di
		add	si, 0A0h
		push	si
		push	di
		mov	ax, cs:[bx+8]
		sub	ax, 2

loc_1172C:				; CODE XREF: PrintText+2D6j
		mov	cx, cs:[bx+6]
		shl	cx, 1
		push	si
		push	di
		rep movsw
		pop	di
		pop	si
		add	si, 0A0h
		add	di, 0A0h
		dec	ax
		jnz	short loc_1172C
		pop	di
		pop	si
		add	si, 2000h
		add	di, 2000h
		mov	ax, cs:[bx+8]
		sub	ax, 2

loc_11754:				; CODE XREF: PrintText+2FEj
		mov	cx, cs:[bx+6]
		shl	cx, 1
		push	si
		push	di
		rep movsw
		pop	di
		pop	si
		add	si, 0A0h
		add	di, 0A0h
		dec	ax
		jnz	short loc_11754
		mov	ax, cs:[bx+2]
		inc	ax
		shl	ax, 1
		mov	cs:[bx+0Ch], ax
		pop	ds
		assume ds:seg000
		pop	si
		call	DoPrintChrDelay
		jmp	PrintText
; ---------------------------------------------------------------------------

ptx0B_portrait:				; CODE XREF: PrintText+48j
		lodsb
		push	si
		push	ds
		and	ax, 3Fh
		mov	bx, offset PortraitInfo
		add	bx, ax
		add	bx, ax
		add	bx, ax
		add	bx, ax
		add	bx, ax
		add	bx, ax
		mov	al, 0Dh
		out	0A8h, al	; GDC: set palette = 0Dh
		mov	al, cs:[bx+3]
		mov	ah, al
		shr	al, 4
		out	0AAh, al	; GDC: set colour Green
		mov	al, ah
		and	al, 0Fh
		out	0ACh, al	; GDC: set colour Red
		mov	al, cs:[bx+4]
		mov	ah, al
		shr	al, 4
		out	0AEh, al	; GDC: set colour Blue
		mov	al, 0Eh
		out	0A8h, al	; GDC: set palette = 0Eh
		mov	al, ah
		and	al, 0Fh
		out	0AAh, al	; GDC: set colour Green
		mov	al, cs:[bx+5]
		mov	ah, al
		shr	al, 4
		out	0ACh, al	; GDC: set colour Red
		mov	al, ah
		and	al, 0Fh
		out	0AEh, al	; GDC: set colour Blue

DrawPortrait:
		mov	ax, 0A800h
		mov	dx, cs:word_19FD4
		call	sub_11801
		mov	ax, 0B000h
		add	dx, 800h
		call	sub_11801
		mov	ax, 0B800h
		mov	dx, cs:word_19FD6
		call	sub_11801
		mov	ax, 0E000h
		add	dx, 800h
		call	sub_11801
		xor	al, al
		out	0A6h, al	; Interrupt Controller #2, 8259A
		pop	ds
		pop	si
		jmp	PrintText
; END OF FUNCTION CHUNK	FOR PrintText

; =============== S U B	R O U T	I N E =======================================


sub_11801	proc near		; CODE XREF: PrintText+36Bp
					; PrintText+375p ...
		push	ax
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	ds, dx
		mov	si, cs:[bx+1]
		cmp	byte ptr cs:[bx], 2
		jnb	short loc_11817
		mov	ds, ax
		mov	al, cs:[bx]
		out	0A6h, al	; Interrupt Controller #2, 8259A

loc_11817:				; CODE XREF: sub_11801+Dj
		mov	es, cs:word_19FD2
		assume es:nothing
		xor	di, di
		mov	al, 60h

loc_11820:				; CODE XREF: sub_11801+29j
		mov	cx, 6
		rep movsw
		add	si, 44h
		dec	al
		jnz	short loc_11820
		mov	es, dx
		mov	di, cs:word_1A546
		pop	ax
		out	0A6h, al	; Interrupt Controller #2, 8259A
		cmp	cs:byte_1A545, 2
		jnb	short loc_11846
		mov	es, ax
		mov	al, cs:byte_1A545
		out	0A6h, al	; Interrupt Controller #2, 8259A

loc_11846:				; CODE XREF: sub_11801+3Bj
		mov	ds, cs:word_19FD2
		xor	si, si
		mov	al, 60h

loc_1184F:				; CODE XREF: sub_11801+58j
		mov	cx, 6
		rep movsw
		add	di, 44h
		dec	al
		jnz	short loc_1184F
		retn
sub_11801	endp

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR PrintText

ptx0D_line_break:			; CODE XREF: PrintText+4Fj
		cmp	cs:textBoxID, 10h
		jb	short loc_11872
		mov	cs:ptxPosX, 0
		inc	cs:ptxPosY
		jmp	PrintText
; ---------------------------------------------------------------------------

loc_11872:				; CODE XREF: PrintText+3F7j
		mov	bx, 9D27h
		mov	cl, 12h
		mov	al, cs:textBoxID
		cbw
		mul	cl
		add	bx, ax
		mov	ax, cs:[bx+2]
		inc	ax
		add	ax, ax
		mov	cs:[bx+0Ch], ax
		inc	word ptr cs:[bx+0Eh]
		jmp	PrintText
; END OF FUNCTION CHUNK	FOR PrintText

; =============== S U B	R O U T	I N E =======================================


PrintInt_2Digs	proc near		; CODE XREF: seg000:2610p seg000:261Ap ...
		push	ax
		push	cx
		xor	ah, ah
		mov	cl, 10
		div	cl
		xchg	al, ah
		add	al, '0'
		call	str_Prepend2B
		xchg	al, ah
		add	al, '0'
		call	str_Prepend2B
		pop	cx
		pop	ax
		retn
PrintInt_2Digs	endp


; =============== S U B	R O U T	I N E =======================================


str_Prepend2B	proc near		; CODE XREF: PrintInt_2Digs+Cp
					; PrintInt_2Digs+13p ...
		pusha
		add	bx, 4Eh
		mov	cx, 4Fh

loc_118B2:				; CODE XREF: str_Prepend2B+Fj
		mov	al, cs:[bx]
		mov	cs:[bx+1], al
		dec	bx
		loop	loc_118B2
		popa
		mov	cs:[bx], al
		retn
str_Prepend2B	endp


; =============== S U B	R O U T	I N E =======================================


DoPalThing	proc near		; CODE XREF: seg000:2D65p seg000:2DBDp
		pusha
		push	ds
		push	es
		mov	ds, cs:word_19FD2
		assume ds:nothing
		mov	si, 100h
		push	cs
		pop	es
		assume es:seg000
		mov	di, offset PalCurrent
		mov	ax, ds:134h
		shr	ax, 3
		mov	cs:word_19F5F, ax
		mov	ax, ds:136h
		mov	cs:word_19F61, ax
		cld
		push	di
		push	es
		mov	cx, 10h

loc_118E8:				; CODE XREF: DoPalThing+2Cj
		lodsw
		xchg	ah, al
		stosw
		movsb
		loop	loc_118E8
		pop	ds
		pop	si
		mov	cx, 18h
		rep movsw
		pop	es
		assume es:nothing
		pop	ds
		assume ds:seg000
		popa
		retn
DoPalThing	endp


; =============== S U B	R O U T	I N E =======================================


LoadPIImage1	proc near		; CODE XREF: seg000:2D62p seg000:2DBAp
		pusha
		push	ds
		push	es
		mov	ax, cs
		mov	es, ax
		assume es:seg000
		mov	ds, cs:word_19FD2
		assume ds:nothing
		mov	dx, 9F7Ch
		mov	ax, cs:word_19F59
		shl	ax, 3
		mov	ds:130h, ax
		mov	ax, cs:word_19F5B
		mov	ds:132h, ax
		mov	word ptr ds:146h, 0EBB6h
		call	loc_11927
		pop	es
		assume es:nothing
		pop	ds
		assume ds:seg000
		popa
		retn
LoadPIImage1	endp

; ---------------------------------------------------------------------------

loc_11927:				; CODE XREF: LoadPIImage1+26p
		cld
		mov	cs:word_19FDA, sp
		mov	cs:word_19FD8, ds
		mov	ax, es
		mov	ds, ax
		mov	ax, 3D00h
		int	21h		; DOS -	2+ - OPEN DISK FILE WITH HANDLE
					; DS:DX	-> ASCIZ filename
					; AL = access mode
					; 0 - read
		jnb	short loc_11943
		mov	sp, cs:word_19FDA
		retn
; ---------------------------------------------------------------------------

loc_11943:				; CODE XREF: seg000:193Bj
		mov	bx, cs:word_19FD8
		mov	ds, bx
		mov	es, bx
		assume ds:nothing
		mov	ds:140h, ax
		mov	bx, ds:130h
		mov	ax, ds:132h
		shr	bx, 3
		shl	ax, 4
		add	bx, ax
		shl	ax, 2
		add	ax, bx
		mov	ds:13Eh, ax
		call	sub_11CCC
		mov	si, bx
		lodsw
		xchg	ah, al
		mov	ds:134h, ax
		mov	cx, ax
		neg	ax
		mov	word ptr cs:loc_11A75+1, ax
		inc	ax
		mov	word ptr cs:loc_11A14+1, ax
		dec	ax
		add	ax, ax
		mov	word ptr cs:loc_11A09+1, ax
		add	cx, cx
		mov	ax, cx
		add	ax, 14Ah
		mov	ds:142h, ax
		add	cx, cx
		mov	ds:13Ch, cx
		add	ax, cx
		mov	ds:144h, ax
		mov	word ptr cs:loc_11A5E+2, ax
		mov	word ptr cs:loc_11AB0+1, ax
		mov	word ptr cs:loc_11AE3+2, ax
		mov	ax, ds:130h
		and	ax, 7
		add	ax, ds:134h
		mov	ds:138h, ax
		lodsw
		xchg	ah, al
		mov	ds:136h, ax
		mov	ds:13Ah, ax
		mov	cx, 30h
		mov	di, 100h

loc_119C2:				; CODE XREF: seg000:19C7j
		lodsb
		shr	al, 4
		stosb
		loop	loc_119C2
		mov	bx, si
		call	sub_11CFC
		mov	dh, 1
		mov	di, 14Ah
		xor	al, al
		call	sub_11BA4
		mov	cx, ds:134h
		rep stosw
		xor	bp, bp
		jmp	loc_11A67
; ---------------------------------------------------------------------------

loc_119E3:				; CODE XREF: seg000:1A05j
		mov	dl, [bx]
		mov	dh, 8
		inc	bx
		cmp	bx, 0FC00h
		jnz	short loc_11A07
		call	sub_11CCC
		jmp	short loc_11A07
; ---------------------------------------------------------------------------

loc_119F3:				; CODE XREF: seg000:1A10j
		mov	dl, [bx]
		mov	dh, 8
		inc	bx
		cmp	bx, 0FC00h
		jnz	short loc_11A12
		call	sub_11CCC
		jmp	short loc_11A12
; ---------------------------------------------------------------------------

loc_11A03:				; CODE XREF: seg000:1A6Dj
		dec	dh
		jz	short loc_119E3

loc_11A07:				; CODE XREF: seg000:19ECj seg000:19F1j
		add	dl, dl

loc_11A09:				; DATA XREF: seg000:1981w
		mov	si, 0
		jnb	short loc_11A84
		dec	dh
		jz	short loc_119F3

loc_11A12:				; CODE XREF: seg000:19FCj seg000:1A01j
		add	dl, dl

loc_11A14:				; DATA XREF: seg000:197Aw
		mov	si, 0
		jnb	short loc_11A84
		dec	si
		dec	si
		jmp	short loc_11A84
; ---------------------------------------------------------------------------

loc_11A1D:				; CODE XREF: seg000:1A69j
		mov	dl, [bx]
		mov	dh, 8
		inc	bx
		cmp	bx, 0FC00h
		jnz	short loc_11A6B
		call	sub_11CCC
		jmp	short loc_11A6B
; ---------------------------------------------------------------------------

loc_11A2D:				; CODE XREF: seg000:1A71j
		mov	dl, [bx]
		mov	dh, 8
		inc	bx
		cmp	bx, 0FC00h
		jnz	short loc_11A73
		call	sub_11CCC
		jmp	short loc_11A73
; ---------------------------------------------------------------------------

loc_11A3D:				; CODE XREF: seg000:1A8Ej
		mov	dl, [bx]
		mov	dh, 8
		inc	bx
		cmp	bx, 0FC00h
		jnz	short loc_11A90
		call	sub_11CCC
		jmp	short loc_11A90
; ---------------------------------------------------------------------------

loc_11A4D:				; CODE XREF: seg000:1A9Cj
		mov	dl, [bx]
		mov	dh, 8
		inc	bx
		cmp	bx, 0FC00h
		jnz	short loc_11A9E
		call	sub_11CCC
		jmp	short loc_11A9E
; ---------------------------------------------------------------------------

loc_11A5D:				; CODE XREF: seg000:1A92j
		movsw

loc_11A5E:				; DATA XREF: seg000:199Aw
		cmp	di, 0
		jnz	short loc_11A67
		call	sub_11D10

loc_11A67:				; CODE XREF: seg000:19E0j seg000:1A62j ...
		dec	dh
		jz	short loc_11A1D

loc_11A6B:				; CODE XREF: seg000:1A26j seg000:1A2Bj
		add	dl, dl
		jb	short loc_11A03
		dec	dh
		jz	short loc_11A2D

loc_11A73:				; CODE XREF: seg000:1A36j seg000:1A3Bj
		add	dl, dl

loc_11A75:				; DATA XREF: seg000:1975w
		mov	si, 0
		jb	short loc_11A84
		mov	si, 0FFFCh
		mov	ax, [di-2]
		cmp	ah, al
		jz	short loc_11ACF

loc_11A84:				; CODE XREF: seg000:1A0Cj seg000:1A17j ...
		cmp	si, bp
		mov	bp, si
		jz	short loc_11ADA
		add	si, di

loc_11A8C:				; CODE XREF: seg000:1AD8j
		dec	dh
		jz	short loc_11A3D

loc_11A90:				; CODE XREF: seg000:1A46j seg000:1A4Bj
		add	dl, dl
		jnb	short loc_11A5D
		mov	ax, 1
		xor	cx, cx

loc_11A99:				; CODE XREF: seg000:1AA0j
		inc	cx
		dec	dh
		jz	short loc_11A4D

loc_11A9E:				; CODE XREF: seg000:1A56j seg000:1A5Bj
		add	dl, dl
		jb	short loc_11A99

loc_11AA2:				; CODE XREF: seg000:1AAAj
		dec	dh
		jz	short loc_11ABF

loc_11AA6:				; CODE XREF: seg000:1AC8j seg000:1ACDj
		add	dl, dl
		adc	ax, ax
		loop	loc_11AA2
		jb	short loc_11B09

loc_11AAE:				; CODE XREF: seg000:1B07j seg000:1B12j ...
		mov	cx, ax

loc_11AB0:				; DATA XREF: seg000:199Ew
		mov	ax, 0
		sub	ax, di
		shr	ax, 1
		cmp	cx, ax
		jnb	short loc_11AFB
		rep movsw
		jmp	short loc_11A67
; ---------------------------------------------------------------------------

loc_11ABF:				; CODE XREF: seg000:1AA4j
		mov	dl, [bx]
		mov	dh, 8
		inc	bx
		cmp	bx, 0FC00h
		jnz	short loc_11AA6
		call	sub_11CCC
		jmp	short loc_11AA6
; ---------------------------------------------------------------------------

loc_11ACF:				; CODE XREF: seg000:1A82j
		cmp	si, bp
		mov	bp, si
		jz	short loc_11ADA
		lea	si, [di-2]
		jmp	short loc_11A8C
; ---------------------------------------------------------------------------

loc_11ADA:				; CODE XREF: seg000:1A88j seg000:1AD3j
		mov	al, [di-1]

loc_11ADD:				; CODE XREF: seg000:1AEFj
		call	sub_11BA4
		stosw
		mov	al, ah

loc_11AE3:				; DATA XREF: seg000:19A2w
		cmp	di, 0
		jz	short loc_11AF6

loc_11AE9:				; CODE XREF: seg000:1AF9j
		dec	dh
		jz	short loc_11B1F

loc_11AED:				; CODE XREF: seg000:1B28j seg000:1B2Dj
		add	dl, dl
		jb	short loc_11ADD
		xor	bp, bp
		jmp	loc_11A67
; ---------------------------------------------------------------------------

loc_11AF6:				; CODE XREF: seg000:1AE7j
		call	sub_11D10
		jmp	short loc_11AE9
; ---------------------------------------------------------------------------

loc_11AFB:				; CODE XREF: seg000:1AB9j
		sub	cx, ax
		xchg	ax, cx
		rep movsw
		call	sub_11D10
		sub	si, ds:13Ch
		jmp	short loc_11AAE
; ---------------------------------------------------------------------------

loc_11B09:				; CODE XREF: seg000:1AACj
		xor	cx, cx

loc_11B0B:				; CODE XREF: seg000:1B10j seg000:1B1Dj
		movsw
		cmp	di, ds:144h
		loopne	loc_11B0B
		jnz	short loc_11AAE
		call	sub_11D10
		sub	si, ds:13Ch
		jcxz	short loc_11AAE
		jmp	short loc_11B0B
; ---------------------------------------------------------------------------

loc_11B1F:				; CODE XREF: seg000:1AEBj
		mov	dl, [bx]
		mov	dh, 8
		inc	bx
		cmp	bx, 0FC00h
		jnz	short loc_11AED
		call	sub_11CCC
		jmp	short loc_11AED
; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_11BA4

loc_11B2F:				; CODE XREF: sub_11BA4-13j
		mov	dl, [bx]
		mov	dh, 8
		inc	bx
		cmp	bx, 0FC00h
		jnz	short loc_11B93
		call	sub_11CCC
		jmp	short loc_11B93
; ---------------------------------------------------------------------------

loc_11B3F:				; CODE XREF: sub_11BA4+8j
		mov	dl, [bx]
		mov	dh, 8
		inc	bx
		cmp	bx, 0FC00h
		jnz	short loc_11BAE
		call	sub_11CCC
		jmp	short loc_11BAE
; ---------------------------------------------------------------------------

loc_11B4F:				; CODE XREF: sub_11BA4+10j
		mov	dl, [bx]
		mov	dh, 8
		inc	bx
		cmp	bx, 0FC00h
		jnz	short loc_11BB6
		call	sub_11CCC
		jmp	short loc_11BB6
; ---------------------------------------------------------------------------

loc_11B5F:				; CODE XREF: sub_11BA4+1Bj
		mov	dl, [bx]
		mov	dh, 8
		inc	bx
		cmp	bx, 0FC00h
		jnz	short loc_11BC1
		call	sub_11CCC
		jmp	short loc_11BC1
; ---------------------------------------------------------------------------

loc_11B6F:				; CODE XREF: sub_11BA4+23j
		mov	dl, [bx]
		mov	dh, 8
		inc	bx
		cmp	bx, 0FC00h
		jnz	short loc_11BC9
		call	sub_11CCC
		jmp	short loc_11BC9
; ---------------------------------------------------------------------------

loc_11B7F:				; CODE XREF: sub_11BA4+2Bj
		mov	dl, [bx]
		mov	dh, 8
		inc	bx
		cmp	bx, 0FC00h
		jnz	short loc_11BD1
		call	sub_11CCC
		jmp	short loc_11BD1
; ---------------------------------------------------------------------------

loc_11B8F:				; CODE XREF: sub_11BA4+Cj
		dec	dh
		jz	short loc_11B2F

loc_11B93:				; CODE XREF: sub_11BA4-6Cj
					; sub_11BA4-67j
		add	dl, dl
		jb	short loc_11B9A
		lodsb
		jmp	short loc_11C09
; ---------------------------------------------------------------------------

loc_11B9A:				; CODE XREF: sub_11BA4-Fj
		mov	ax, [si]
		xchg	ah, al
		mov	[si], ax
		xor	ah, ah
		jmp	short loc_11C09
; END OF FUNCTION CHUNK	FOR sub_11BA4

; =============== S U B	R O U T	I N E =======================================


sub_11BA4	proc near		; CODE XREF: seg000:19D5p
					; seg000:loc_11ADDp

; FUNCTION CHUNK AT 1B2F SIZE 00000075 BYTES

		mov	bp, di
		xor	ah, ah
		mov	si, ax
		dec	dh
		jz	short loc_11B3F

loc_11BAE:				; CODE XREF: sub_11BA4-5Cj
					; sub_11BA4-57j
		add	dl, dl
		jb	short loc_11B8F
		dec	dh
		jz	short loc_11B4F

loc_11BB6:				; CODE XREF: sub_11BA4-4Cj
					; sub_11BA4-47j
		add	dl, dl
		mov	cx, 1
		jnb	short loc_11BD5
		dec	dh
		jz	short loc_11B5F

loc_11BC1:				; CODE XREF: sub_11BA4-3Cj
					; sub_11BA4-37j
		add	dl, dl
		jnb	short loc_11BCD
		dec	dh
		jz	short loc_11B6F

loc_11BC9:				; CODE XREF: sub_11BA4-2Cj
					; sub_11BA4-27j
		add	dl, dl
		adc	cx, cx

loc_11BCD:				; CODE XREF: sub_11BA4+1Fj
		dec	dh
		jz	short loc_11B7F

loc_11BD1:				; CODE XREF: sub_11BA4-1Cj
					; sub_11BA4-17j
		add	dl, dl
		adc	cx, cx

loc_11BD5:				; CODE XREF: sub_11BA4+17j
		dec	dh
		jz	short loc_11BE9

loc_11BD9:				; CODE XREF: sub_11BA4+4Ej
					; sub_11BA4+53j
		add	dl, dl
		adc	cx, cx
		add	si, cx
		std
		lodsb
		lea	di, [si+1]
		rep movsb
		stosb
		jmp	short loc_11C09
; ---------------------------------------------------------------------------

loc_11BE9:				; CODE XREF: sub_11BA4+33j
		mov	dl, [bx]
		mov	dh, 8
		inc	bx
		cmp	bx, 0FC00h
		jnz	short loc_11BD9
		call	sub_11CCC
		jmp	short loc_11BD9
; ---------------------------------------------------------------------------

loc_11BF9:				; CODE XREF: sub_11BA4+6Bj
		mov	dl, [bx]
		mov	dh, 8
		inc	bx
		cmp	bx, 0FC00h
		jnz	short loc_11C11
		call	sub_11CCC
		jmp	short loc_11C11
; ---------------------------------------------------------------------------

loc_11C09:				; CODE XREF: sub_11BA4-Cj sub_11BA4-2j ...
		xor	ah, ah
		mov	si, ax
		dec	dh
		jz	short loc_11BF9

loc_11C11:				; CODE XREF: sub_11BA4+5Ej
					; sub_11BA4+63j
		add	dl, dl
		jb	short loc_11C52
		dec	dh
		jz	short loc_11C6C

loc_11C19:				; CODE XREF: sub_11BA4+D1j
					; sub_11BA4+D6j
		add	dl, dl
		mov	cx, 1
		jnb	short loc_11C38
		dec	dh
		jz	short loc_11C7C

loc_11C24:				; CODE XREF: sub_11BA4+E1j
					; sub_11BA4+E6j
		add	dl, dl
		jnb	short loc_11C30
		dec	dh
		jz	short loc_11C8C

loc_11C2C:				; CODE XREF: sub_11BA4+F1j
					; sub_11BA4+F6j
		add	dl, dl
		adc	cx, cx

loc_11C30:				; CODE XREF: sub_11BA4+82j
		dec	dh
		jz	short loc_11C9C

loc_11C34:				; CODE XREF: sub_11BA4+101j
					; sub_11BA4+106j
		add	dl, dl
		adc	cx, cx

loc_11C38:				; CODE XREF: sub_11BA4+7Aj
		dec	dh
		jz	short loc_11CAC

loc_11C3C:				; CODE XREF: sub_11BA4+111j
					; sub_11BA4+116j
		add	dl, dl
		adc	cx, cx
		add	si, cx
		std
		mov	ah, al
		lodsb
		lea	di, [si+1]
		rep movsb
		stosb
		xchg	ah, al
		mov	di, bp
		cld
		retn
; ---------------------------------------------------------------------------

loc_11C52:				; CODE XREF: sub_11BA4+6Fj
		dec	dh
		jz	short loc_11CBC

loc_11C56:				; CODE XREF: sub_11BA4+121j
					; sub_11BA4+126j
		add	dl, dl
		jb	short loc_11C60
		mov	ah, [si]
		mov	di, bp
		cld
		retn
; ---------------------------------------------------------------------------

loc_11C60:				; CODE XREF: sub_11BA4+B4j
		mov	cx, [si]
		xchg	ch, cl
		mov	[si], cx
		mov	ah, cl
		mov	di, bp
		cld
		retn
; ---------------------------------------------------------------------------

loc_11C6C:				; CODE XREF: sub_11BA4+73j
		mov	dl, [bx]
		mov	dh, 8
		inc	bx
		cmp	bx, 0FC00h
		jnz	short loc_11C19
		call	sub_11CCC
		jmp	short loc_11C19
; ---------------------------------------------------------------------------

loc_11C7C:				; CODE XREF: sub_11BA4+7Ej
		mov	dl, [bx]
		mov	dh, 8
		inc	bx
		cmp	bx, 0FC00h
		jnz	short loc_11C24
		call	sub_11CCC
		jmp	short loc_11C24
; ---------------------------------------------------------------------------

loc_11C8C:				; CODE XREF: sub_11BA4+86j
		mov	dl, [bx]
		mov	dh, 8
		inc	bx
		cmp	bx, 0FC00h
		jnz	short loc_11C2C
		call	sub_11CCC
		jmp	short loc_11C2C
; ---------------------------------------------------------------------------

loc_11C9C:				; CODE XREF: sub_11BA4+8Ej
		mov	dl, [bx]
		mov	dh, 8
		inc	bx
		cmp	bx, 0FC00h
		jnz	short loc_11C34
		call	sub_11CCC
		jmp	short loc_11C34
; ---------------------------------------------------------------------------

loc_11CAC:				; CODE XREF: sub_11BA4+96j
		mov	dl, [bx]
		mov	dh, 8
		inc	bx
		cmp	bx, 0FC00h
		jnz	short loc_11C3C
		call	sub_11CCC
		jmp	short loc_11C3C
; ---------------------------------------------------------------------------

loc_11CBC:				; CODE XREF: sub_11BA4+B0j
		mov	dl, [bx]
		mov	dh, 8
		inc	bx
		cmp	bx, 0FC00h
		jnz	short loc_11C56
		call	sub_11CCC
		jmp	short loc_11C56
sub_11BA4	endp


; =============== S U B	R O U T	I N E =======================================


sub_11CCC	proc near		; CODE XREF: seg000:1966p seg000:19EEp ...
		push	ax
		push	cx
		push	dx
		mov	bx, ds:140h
		mov	dx, 104Ah
		push	dx
		call	sub_10949
		mov	cx, ds:146h
		mov	ah, 3Fh
		int	21h		; DOS -	2+ - READ FROM FILE WITH HANDLE
					; BX = file handle, CX = number	of bytes to read
					; DS:DX	-> buffer
		pushf
		call	sub_1096C
		popf
		jnb	short loc_11CF7
		mov	bx, ds:140h
		mov	ah, 3Eh
		int	21h		; DOS -	2+ - CLOSE A FILE WITH HANDLE
					; BX = file handle
		mov	sp, cs:word_19FDA
		retn
; ---------------------------------------------------------------------------

loc_11CF7:				; CODE XREF: sub_11CCC+1Bj
		pop	bx
		pop	dx
		pop	cx
		pop	ax
		retn
sub_11CCC	endp


; =============== S U B	R O U T	I N E =======================================


sub_11CFC	proc near		; CODE XREF: seg000:19CBp
		xor	di, di
		mov	ax, 1000h

loc_11D01:				; CODE XREF: sub_11CFC+11j
		mov	cx, 10h

loc_11D04:				; CODE XREF: sub_11CFC+Bj
		stosb
		sub	al, 10h
		loop	loc_11D04
		add	al, 10h
		dec	ah
		jnz	short loc_11D01
		retn
sub_11CFC	endp


; =============== S U B	R O U T	I N E =======================================


sub_11D10	proc near		; CODE XREF: seg000:1A64p
					; seg000:loc_11AF6p ...
		cmp	cs:byte_19F72, 2
		jnb	short loc_11D23
		cmp	cs:byte_19F73, 0
		jz	short loc_11D31
		jmp	loc_11EEE
; ---------------------------------------------------------------------------

loc_11D23:				; CODE XREF: sub_11D10+6j
		cmp	cs:byte_19F73, 0
		jnz	short loc_11D2E
		jmp	loc_120CF
; ---------------------------------------------------------------------------

loc_11D2E:				; CODE XREF: sub_11D10+19j
		jmp	loc_12283
; ---------------------------------------------------------------------------

loc_11D31:				; CODE XREF: sub_11D10+Ej
		pusha
		push	es
		mov	si, ds:144h
		mov	di, 14Ah
		mov	cx, ds:134h
		sub	si, cx
		sub	si, cx
		rep movsw
		mov	si, di
		mov	cx, 4

loc_11D49:				; CODE XREF: sub_11D10+1C4j
		push	cx
		mov	di, ds:13Eh
		mov	ax, ds:130h
		and	ax, 7
		jz	short loc_11DAF
		mov	cx, 8
		sub	cx, ax
		push	cx
		mov	ah, 0FFh
		shl	ah, cl
		xor	bx, bx
		mov	dx, bx

loc_11D64:				; CODE XREF: sub_11D10+65j
		lodsb
		add	al, al
		adc	bl, bl
		add	al, al
		adc	bh, bh
		add	al, al
		adc	dl, dl
		add	al, al
		adc	dh, dh
		loop	loc_11D64
		mov	cl, dh
		or	cl, dl
		or	cl, bh
		or	cl, bl
		or	cl, ah
		not	cl
		or	ah, cl
		mov	cx, 0A800h
		mov	es, cx
		assume es:nothing
		mov	es:[di], dh
		mov	ch, 0B0h
		mov	es, cx
		assume es:nothing
		mov	es:[di], dl
		mov	ch, 0B8h
		mov	es, cx
		assume es:nothing
		mov	es:[di], bh
		mov	ch, 0E0h
		mov	es, cx
		assume es:nothing
		mov	es:[di], bl
		inc	di
		pop	ax
		mov	cx, ds:134h
		sub	cx, ax
		shr	cx, 3
		jmp	short loc_11DB6
; ---------------------------------------------------------------------------

loc_11DAF:				; CODE XREF: sub_11D10+44j
		mov	cx, ds:134h
		shr	cx, 3

loc_11DB6:				; CODE XREF: sub_11D10+9Dj
					; sub_11D10+157j
		lodsw
		add	al, al
		adc	bl, bl
		add	ah, ah
		adc	bl, bl
		add	al, al
		adc	bh, bh
		add	ah, ah
		adc	bh, bh
		add	al, al
		adc	dl, dl
		add	ah, ah
		adc	dl, dl
		add	al, al
		adc	dh, dh
		add	ah, ah
		adc	dh, dh
		lodsw
		add	al, al
		adc	bl, bl
		add	ah, ah
		adc	bl, bl
		add	al, al
		adc	bh, bh
		add	ah, ah
		adc	bh, bh
		add	al, al
		adc	dl, dl
		add	ah, ah
		adc	dl, dl
		add	al, al
		adc	dh, dh
		add	ah, ah
		adc	dh, dh
		lodsw
		add	al, al
		adc	bl, bl
		add	ah, ah
		adc	bl, bl
		add	al, al
		adc	bh, bh
		add	ah, ah
		adc	bh, bh
		add	al, al
		adc	dl, dl
		add	ah, ah
		adc	dl, dl
		add	al, al
		adc	dh, dh
		add	ah, ah
		adc	dh, dh
		lodsw
		add	al, al
		adc	bl, bl
		add	ah, ah
		adc	bl, bl
		add	al, al
		adc	bh, bh
		add	ah, ah
		adc	bh, bh
		add	al, al
		adc	dl, dl
		add	ah, ah
		adc	dl, dl
		add	al, al
		adc	dh, dh
		add	ah, ah
		adc	dh, dh
		push	cx
		mov	cl, dh
		or	cl, dl
		or	cl, bh
		or	cl, bl
		not	cl
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		mov	es:[di], dh
		mov	ah, 0B0h
		mov	es, ax
		assume es:nothing
		mov	es:[di], dl
		mov	ah, 0B8h
		mov	es, ax
		assume es:nothing
		mov	es:[di], bh
		mov	ah, 0E0h
		mov	es, ax
		assume es:nothing
		mov	es:[di], bl
		inc	di
		pop	cx
		dec	cx
		jz	short loc_11E6A
		jmp	loc_11DB6
; ---------------------------------------------------------------------------

loc_11E6A:				; CODE XREF: sub_11D10+155j
		mov	cx, ds:138h
		and	cx, 7
		jz	short loc_11EC5
		mov	ah, 8
		sub	ah, cl
		xor	bx, bx
		mov	dx, bx

loc_11E7B:				; CODE XREF: sub_11D10+17Cj
		lodsb
		add	al, al
		adc	bl, bl
		add	al, al
		adc	bh, bh
		add	al, al
		adc	dl, dl
		add	al, al
		adc	dh, dh
		loop	loc_11E7B
		mov	cl, ah
		mov	ch, 0FFh
		shl	ch, cl
		not	ch
		shl	bx, cl
		shl	dx, cl
		mov	al, dh
		or	al, dl
		or	al, bh
		or	al, bl
		or	al, ch
		not	al
		or	ch, al
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		mov	es:[di], dh
		mov	ah, 0B0h
		mov	es, ax
		assume es:nothing
		mov	es:[di], dl
		mov	ah, 0B8h
		mov	es, ax
		assume es:nothing
		mov	es:[di], bh
		mov	ah, 0E0h
		mov	es, ax
		assume es:nothing
		mov	es:[di], bl

loc_11EC5:				; CODE XREF: sub_11D10+161j
		pop	cx
		add	word ptr ds:13Eh, 50h
		dec	word ptr ds:13Ah
		jz	short loc_11EDE
		dec	cx
		jz	short loc_11ED7
		jmp	loc_11D49
; ---------------------------------------------------------------------------

loc_11ED7:				; CODE XREF: sub_11D10+1C2j
		pop	es
		assume es:nothing
		popa
		mov	di, ds:142h
		retn
; ---------------------------------------------------------------------------

loc_11EDE:				; CODE XREF: sub_11D10+1BFj
		mov	bx, ds:140h
		mov	ah, 3Eh
		int	21h		; DOS -	2+ - CLOSE A FILE WITH HANDLE
					; BX = file handle
		mov	sp, cs:word_19FDA
		xor	ax, ax
		retn
; ---------------------------------------------------------------------------

loc_11EEE:				; CODE XREF: sub_11D10+10j
		pusha
		push	es
		mov	si, ds:144h
		mov	di, 14Ah
		mov	cx, ds:134h
		sub	si, cx
		sub	si, cx
		rep movsw
		mov	si, di
		mov	cx, 4

loc_11F06:				; CODE XREF: sub_11D10+3A5j
		push	cx
		mov	di, ds:13Eh
		mov	ax, ds:130h
		and	ax, 7
		jz	short loc_11F78
		mov	cx, 8
		sub	cx, ax
		push	cx
		mov	ah, 0FFh
		shl	ah, cl
		xor	bx, bx
		mov	dx, bx

loc_11F21:				; CODE XREF: sub_11D10+222j
		lodsb
		add	al, al
		adc	bl, bl
		add	al, al
		adc	bh, bh
		add	al, al
		adc	dl, dl
		add	al, al
		adc	dh, dh
		loop	loc_11F21
		mov	cl, dh
		or	cl, dl
		or	cl, bh
		or	cl, bl
		or	cl, ah
		not	cl
		or	ah, cl
		mov	cx, 0A800h
		mov	es, cx
		assume es:nothing
		and	es:[di], ah
		or	es:[di], dh
		mov	ch, 0B0h
		mov	es, cx
		assume es:nothing
		and	es:[di], ah
		or	es:[di], dl
		mov	ch, 0B8h
		mov	es, cx
		assume es:nothing
		and	es:[di], ah
		or	es:[di], bh
		mov	ch, 0E0h
		mov	es, cx
		assume es:nothing
		and	es:[di], ah
		or	es:[di], bl
		inc	di
		pop	ax
		mov	cx, ds:134h
		sub	cx, ax
		shr	cx, 3
		jmp	short loc_11F7F
; ---------------------------------------------------------------------------

loc_11F78:				; CODE XREF: sub_11D10+201j
		mov	cx, ds:134h
		shr	cx, 3

loc_11F7F:				; CODE XREF: sub_11D10+266j
					; sub_11D10+32Cj
		lodsw
		add	al, al
		adc	bl, bl
		add	ah, ah
		adc	bl, bl
		add	al, al
		adc	bh, bh
		add	ah, ah
		adc	bh, bh
		add	al, al
		adc	dl, dl
		add	ah, ah
		adc	dl, dl
		add	al, al
		adc	dh, dh
		add	ah, ah
		adc	dh, dh
		lodsw
		add	al, al
		adc	bl, bl
		add	ah, ah
		adc	bl, bl
		add	al, al
		adc	bh, bh
		add	ah, ah
		adc	bh, bh
		add	al, al
		adc	dl, dl
		add	ah, ah
		adc	dl, dl
		add	al, al
		adc	dh, dh
		add	ah, ah
		adc	dh, dh
		lodsw
		add	al, al
		adc	bl, bl
		add	ah, ah
		adc	bl, bl
		add	al, al
		adc	bh, bh
		add	ah, ah
		adc	bh, bh
		add	al, al
		adc	dl, dl
		add	ah, ah
		adc	dl, dl
		add	al, al
		adc	dh, dh
		add	ah, ah
		adc	dh, dh
		lodsw
		add	al, al
		adc	bl, bl
		add	ah, ah
		adc	bl, bl
		add	al, al
		adc	bh, bh
		add	ah, ah
		adc	bh, bh
		add	al, al
		adc	dl, dl
		add	ah, ah
		adc	dl, dl
		add	al, al
		adc	dh, dh
		add	ah, ah
		adc	dh, dh
		push	cx
		mov	cl, dh
		or	cl, dl
		or	cl, bh
		or	cl, bl
		not	cl
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		and	es:[di], cl
		or	es:[di], dh
		mov	ah, 0B0h
		mov	es, ax
		assume es:nothing
		and	es:[di], cl
		or	es:[di], dl
		mov	ah, 0B8h
		mov	es, ax
		assume es:nothing
		and	es:[di], cl
		or	es:[di], bh
		mov	ah, 0E0h
		mov	es, ax
		assume es:nothing
		and	es:[di], cl
		or	es:[di], bl
		inc	di
		pop	cx
		dec	cx
		jz	short loc_1203F
		jmp	loc_11F7F
; ---------------------------------------------------------------------------

loc_1203F:				; CODE XREF: sub_11D10+32Aj
		mov	cx, ds:138h
		and	cx, 7
		jz	short loc_120A6
		mov	ah, 8
		sub	ah, cl
		xor	bx, bx
		mov	dx, bx

loc_12050:				; CODE XREF: sub_11D10+351j
		lodsb
		add	al, al
		adc	bl, bl
		add	al, al
		adc	bh, bh
		add	al, al
		adc	dl, dl
		add	al, al
		adc	dh, dh
		loop	loc_12050
		mov	cl, ah
		mov	ch, 0FFh
		shl	ch, cl
		not	ch
		shl	bx, cl
		shl	dx, cl
		mov	al, dh
		or	al, dl
		or	al, bh
		or	al, bl
		or	al, ch
		not	al
		or	ch, al
		mov	ax, 0A800h
		mov	es, ax
		assume es:nothing
		and	es:[di], ch
		or	es:[di], dh
		mov	ah, 0B0h
		mov	es, ax
		assume es:nothing
		and	es:[di], ch
		or	es:[di], dl
		mov	ah, 0B8h
		mov	es, ax
		assume es:nothing
		and	es:[di], ch
		or	es:[di], bh
		mov	ah, 0E0h
		mov	es, ax
		assume es:nothing
		and	es:[di], ch
		or	es:[di], bl

loc_120A6:				; CODE XREF: sub_11D10+336j
		pop	cx
		add	word ptr ds:13Eh, 50h
		dec	word ptr ds:13Ah
		jz	short loc_120BF
		dec	cx
		jz	short loc_120B8
		jmp	loc_11F06
; ---------------------------------------------------------------------------

loc_120B8:				; CODE XREF: sub_11D10+3A3j
		pop	es
		assume es:nothing
		popa
		mov	di, ds:142h
		retn
; ---------------------------------------------------------------------------

loc_120BF:				; CODE XREF: sub_11D10+3A0j
		mov	bx, ds:140h
		mov	ah, 3Eh
		int	21h		; DOS -	2+ - CLOSE A FILE WITH HANDLE
					; BX = file handle
		mov	sp, cs:word_19FDA
		xor	ax, ax
		retn
; ---------------------------------------------------------------------------

loc_120CF:				; CODE XREF: sub_11D10+1Bj
		pusha
		push	es
		mov	si, ds:144h
		mov	di, 14Ah
		mov	cx, ds:134h
		sub	si, cx
		sub	si, cx
		rep movsw
		mov	si, di
		mov	cx, 4

loc_120E7:				; CODE XREF: sub_11D10+559j
		push	cx
		mov	di, ds:13Eh
		mov	ax, ds:130h
		and	ax, 7
		jz	short loc_1214A
		mov	cx, 8
		sub	cx, ax
		push	cx
		mov	ah, 0FFh
		shl	ah, cl
		xor	bx, bx
		mov	dx, bx

loc_12102:				; CODE XREF: sub_11D10+403j
		lodsb
		add	al, al
		adc	bl, bl
		add	al, al
		adc	bh, bh
		add	al, al
		adc	dl, dl
		add	al, al
		adc	dh, dh
		loop	loc_12102
		mov	cl, dh
		or	cl, dl
		or	cl, bh
		or	cl, bl
		or	cl, ah
		not	cl
		or	ah, cl
		mov	es, cs:word_19FD4
		mov	es:[di], dh
		mov	es:[di+8000h], dl
		mov	es, cs:word_19FD6
		mov	es:[di], bh
		mov	es:[di+8000h], bl
		inc	di
		pop	ax
		mov	cx, ds:134h
		sub	cx, ax
		shr	cx, 3
		jmp	short loc_12151
; ---------------------------------------------------------------------------

loc_1214A:				; CODE XREF: sub_11D10+3E2j
		mov	cx, ds:134h
		shr	cx, 3

loc_12151:				; CODE XREF: sub_11D10+438j
					; sub_11D10+4EFj
		lodsw
		add	al, al
		adc	bl, bl
		add	ah, ah
		adc	bl, bl
		add	al, al
		adc	bh, bh
		add	ah, ah
		adc	bh, bh
		add	al, al
		adc	dl, dl
		add	ah, ah
		adc	dl, dl
		add	al, al
		adc	dh, dh
		add	ah, ah
		adc	dh, dh
		lodsw
		add	al, al
		adc	bl, bl
		add	ah, ah
		adc	bl, bl
		add	al, al
		adc	bh, bh
		add	ah, ah
		adc	bh, bh
		add	al, al
		adc	dl, dl
		add	ah, ah
		adc	dl, dl
		add	al, al
		adc	dh, dh
		add	ah, ah
		adc	dh, dh
		lodsw
		add	al, al
		adc	bl, bl
		add	ah, ah
		adc	bl, bl
		add	al, al
		adc	bh, bh
		add	ah, ah
		adc	bh, bh
		add	al, al
		adc	dl, dl
		add	ah, ah
		adc	dl, dl
		add	al, al
		adc	dh, dh
		add	ah, ah
		adc	dh, dh
		lodsw
		add	al, al
		adc	bl, bl
		add	ah, ah
		adc	bl, bl
		add	al, al
		adc	bh, bh
		add	ah, ah
		adc	bh, bh
		add	al, al
		adc	dl, dl
		add	ah, ah
		adc	dl, dl
		add	al, al
		adc	dh, dh
		add	ah, ah
		adc	dh, dh
		push	cx
		mov	cl, dh
		or	cl, dl
		or	cl, bh
		or	cl, bl
		not	cl
		mov	es, cs:word_19FD4
		mov	es:[di], dh
		mov	es:[di+8000h], dl
		mov	es, cs:word_19FD6
		mov	es:[di], bh
		mov	es:[di+8000h], bl
		inc	di
		pop	cx
		dec	cx
		jz	short loc_12202
		jmp	loc_12151
; ---------------------------------------------------------------------------

loc_12202:				; CODE XREF: sub_11D10+4EDj
		mov	cx, ds:138h
		and	cx, 7
		jz	short loc_1225A
		mov	ah, 8
		sub	ah, cl
		xor	bx, bx
		mov	dx, bx

loc_12213:				; CODE XREF: sub_11D10+514j
		lodsb
		add	al, al
		adc	bl, bl
		add	al, al
		adc	bh, bh
		add	al, al
		adc	dl, dl
		add	al, al
		adc	dh, dh
		loop	loc_12213
		mov	cl, ah
		mov	ch, 0FFh
		shl	ch, cl
		not	ch
		shl	bx, cl
		shl	dx, cl
		mov	al, dh
		or	al, dl
		or	al, bh
		or	al, bl
		or	al, ch
		not	al
		or	ch, al
		mov	es, cs:word_19FD4
		mov	es:[di], dh
		mov	es:[di+8000h], dl
		mov	es, cs:word_19FD6
		mov	es:[di], bh
		mov	es:[di+8000h], bl

loc_1225A:				; CODE XREF: sub_11D10+4F9j
		pop	cx
		add	word ptr ds:13Eh, 50h
		dec	word ptr ds:13Ah
		jz	short loc_12273
		dec	cx
		jz	short loc_1226C
		jmp	loc_120E7
; ---------------------------------------------------------------------------

loc_1226C:				; CODE XREF: sub_11D10+557j
		pop	es
		popa
		mov	di, ds:142h
		retn
; ---------------------------------------------------------------------------

loc_12273:				; CODE XREF: sub_11D10+554j
		mov	bx, ds:140h
		mov	ah, 3Eh
		int	21h		; DOS -	2+ - CLOSE A FILE WITH HANDLE
					; BX = file handle
		mov	sp, cs:word_19FDA
		xor	ax, ax
		retn
; ---------------------------------------------------------------------------

loc_12283:				; CODE XREF: sub_11D10:loc_11D2Ej
		pusha
		push	es
		mov	si, ds:144h
		mov	di, 14Ah
		mov	cx, ds:134h
		sub	si, cx
		sub	si, cx
		rep movsw
		mov	si, di
		mov	cx, 4

loc_1229B:				; CODE XREF: sub_11D10+73Dj
		push	cx
		mov	di, ds:13Eh
		mov	ax, ds:130h
		and	ax, 7
		jz	short loc_1230E
		mov	cx, 8
		sub	cx, ax
		push	cx
		mov	ah, 0FFh
		shl	ah, cl
		xor	bx, bx
		mov	dx, bx

loc_122B6:				; CODE XREF: sub_11D10+5B7j
		lodsb
		add	al, al
		adc	bl, bl
		add	al, al
		adc	bh, bh
		add	al, al
		adc	dl, dl
		add	al, al
		adc	dh, dh
		loop	loc_122B6
		mov	cl, dh
		or	cl, dl
		or	cl, bh
		or	cl, bl
		or	cl, ah
		not	cl
		or	ah, cl
		mov	es, cs:word_19FD4
		and	es:[di], ah
		or	es:[di], dh
		and	es:[di+8000h], ah
		or	es:[di+8000h], dl
		mov	es, cs:word_19FD6
		and	es:[di], ah
		or	es:[di], bh
		and	es:[di+8000h], ah
		or	es:[di+8000h], bl
		inc	di
		pop	ax
		mov	cx, ds:134h
		sub	cx, ax
		shr	cx, 3
		jmp	short loc_12315
; ---------------------------------------------------------------------------

loc_1230E:				; CODE XREF: sub_11D10+596j
		mov	cx, ds:134h
		shr	cx, 3

loc_12315:				; CODE XREF: sub_11D10+5FCj
					; sub_11D10+6C3j
		lodsw
		add	al, al
		adc	bl, bl
		add	ah, ah
		adc	bl, bl
		add	al, al
		adc	bh, bh
		add	ah, ah
		adc	bh, bh
		add	al, al
		adc	dl, dl
		add	ah, ah
		adc	dl, dl
		add	al, al
		adc	dh, dh
		add	ah, ah
		adc	dh, dh
		lodsw
		add	al, al
		adc	bl, bl
		add	ah, ah
		adc	bl, bl
		add	al, al
		adc	bh, bh
		add	ah, ah
		adc	bh, bh
		add	al, al
		adc	dl, dl
		add	ah, ah
		adc	dl, dl
		add	al, al
		adc	dh, dh
		add	ah, ah
		adc	dh, dh
		lodsw
		add	al, al
		adc	bl, bl
		add	ah, ah
		adc	bl, bl
		add	al, al
		adc	bh, bh
		add	ah, ah
		adc	bh, bh
		add	al, al
		adc	dl, dl
		add	ah, ah
		adc	dl, dl
		add	al, al
		adc	dh, dh
		add	ah, ah
		adc	dh, dh
		lodsw
		add	al, al
		adc	bl, bl
		add	ah, ah
		adc	bl, bl
		add	al, al
		adc	bh, bh
		add	ah, ah
		adc	bh, bh
		add	al, al
		adc	dl, dl
		add	ah, ah
		adc	dl, dl
		add	al, al
		adc	dh, dh
		add	ah, ah
		adc	dh, dh
		push	cx
		mov	cl, dh
		or	cl, dl
		or	cl, bh
		or	cl, bl
		not	cl
		mov	es, cs:word_19FD4
		and	es:[di], cl
		or	es:[di], dh
		and	es:[di+8000h], cl
		or	es:[di+8000h], dl
		mov	es, cs:word_19FD6
		and	es:[di], cl
		or	es:[di], bh
		and	es:[di+8000h], cl
		or	es:[di+8000h], bl
		inc	di
		pop	cx
		dec	cx
		jz	short loc_123D6
		jmp	loc_12315
; ---------------------------------------------------------------------------

loc_123D6:				; CODE XREF: sub_11D10+6C1j
		mov	cx, ds:138h
		and	cx, 7
		jz	short loc_1243E
		mov	ah, 8
		sub	ah, cl
		xor	bx, bx
		mov	dx, bx

loc_123E7:				; CODE XREF: sub_11D10+6E8j
		lodsb
		add	al, al
		adc	bl, bl
		add	al, al
		adc	bh, bh
		add	al, al
		adc	dl, dl
		add	al, al
		adc	dh, dh
		loop	loc_123E7
		mov	cl, ah
		mov	ch, 0FFh
		shl	ch, cl
		not	ch
		shl	bx, cl
		shl	dx, cl
		mov	al, dh
		or	al, dl
		or	al, bh
		or	al, bl
		or	al, ch
		not	al
		or	ch, al
		mov	es, cs:word_19FD4
		and	es:[di], ch
		or	es:[di], dh
		and	es:[di+8000h], ch
		or	es:[di+8000h], dl
		mov	es, cs:word_19FD6
		and	es:[di], ch
		or	es:[di], bh
		and	es:[di+8000h], ch
		or	es:[di+8000h], bl

loc_1243E:				; CODE XREF: sub_11D10+6CDj
		pop	cx
		add	word ptr ds:13Eh, 50h
		dec	word ptr ds:13Ah
		jz	short loc_12457
		dec	cx
		jz	short loc_12450
		jmp	loc_1229B
; ---------------------------------------------------------------------------

loc_12450:				; CODE XREF: sub_11D10+73Bj
		pop	es
		popa
		mov	di, ds:142h
		retn
; ---------------------------------------------------------------------------

loc_12457:				; CODE XREF: sub_11D10+738j
		mov	bx, ds:140h
		mov	ah, 3Eh
		int	21h		; DOS -	2+ - CLOSE A FILE WITH HANDLE
					; BX = file handle
		mov	sp, cs:word_19FDA
		xor	ax, ax
		retn
sub_11D10	endp

; ---------------------------------------------------------------------------
scriptFuncList	dw offset sExitDOS	; 0 ; DATA XREF: start:loc_1012Fo
		dw offset sTextBoxImage	; 1
		dw offset sLoadImage	; 2
		dw offset sOpenTextBox	; 3
		dw offset sCloseTextBox	; 4
		dw offset sClearTextBox	; 5
		dw offset sPalApply	; 6
		dw offset sPalFadeBW1	; 7
		dw offset sPalFadeBW2	; 8
		dw offset sPalMaskToggle; 9
		dw offset sJump		; 0Ah
		dw offset sCompareVars	; 0Bh
		dw offset sCompareValVal; 0Ch
		dw offset sCondJmp_EQ	; 0Dh
		dw offset sCondJmp_LT	; 0Eh
		dw offset sCondJmp_GT	; 0Fh
		dw offset sCondJmp_GE	; 10h
		dw offset sCondJmp_LE	; 11h
		dw offset sCondJmp_NE	; 12h
		dw offset sTblJump	; 13h
		dw offset sSetPalColour	; 14h
		dw offset sShowText_TBox; 15h
		dw offset sShowText_XY	; 16h
		dw offset sUndefined	; 17h
		dw offset sLoadVar_Val	; 18h
		dw offset sLoadVar_Var	; 19h
		dw offset sBGMPlay	; 1Ah
		dw offset sBGMFadeOut	; 1Bh
		dw offset sBGMStop	; 1Ch
		dw offset sGetMusMode	; 1Dh
		dw offset sWaitKey	; 1Eh
		dw offset sLoadScene	; 1Fh
		dw offset sFillGVRAM	; 20h
		dw offset sDelay	; 21h
		dw offset sSetChrDelay	; 22h
		dw offset sUndefined	; 23h
		dw offset sAddVar_Val	; 24h
		dw offset sSubVar_Val	; 25h
		dw offset sTextClear_E1	; 26h
		dw offset sAddVar_Cast	; 27h
		dw offset sSubVar_Cast	; 28h
		dw offset sGetVarXY	; 29h
		dw offset sSetVarXY	; 2Ah
		dw offset sSaveVarBufAll; 2Bh
		dw offset sLoadVarBufAll; 2Ch
		dw offset sClearVars	; 2Dh
		dw offset loc_1277E	; 2Eh
		dw offset loc_12DD7	; 2Fh
		dw offset loc_12E49	; 30h
		dw offset loc_12E73	; 31h
		dw offset sPrintVar_TBox; 32h
		dw offset sWritePortA4	; 33h
		dw offset sReadPortA4	; 34h
		dw offset sTextFill	; 35h
		dw offset loc_12BAB	; 36h
		dw offset sLoadXYBuf	; 37h
		dw offset sAndVar_Var	; 38h
		dw offset sOrVar_Var	; 39h
		dw offset loc_12DE9	; 3Ah
		dw offset loc_12DFB	; 3Bh
		dw offset sTextClear_01	; 3Ch
		dw offset sMulVar_Var	; 3Dh
		dw offset sDivVar_Var	; 3Eh
		dw offset loc_13544	; 3Fh
		dw offset sDoMenuSel1	; 40h
		dw offset sDoMenuSel2	; 41h
		dw offset loc_1347D	; 42h
		dw offset loc_134CD	; 43h
		dw offset sDummy	; 44h
		dw offset loc_134E8	; 45h
		dw offset sStrCompare	; 46h
		dw offset sStrCompare	; 47h
		dw offset sStrCompare	; 48h
		dw offset sStrCompare	; 49h
		dw offset sSaveVarBuf	; 4Ah
		dw offset sLoadVarBuf	; 4Bh
		dw offset loc_13528	; 4Ch
		dw offset sBGMGetMeas	; 4Dh
		dw offset sSFXPlaySSG	; 4Eh
		dw offset sSFXPlayFM	; 4Fh
		dw offset sBGMGetState	; 50h
		dw offset sAndVar_Val	; 51h
		dw offset sOrVar_Val	; 52h
		dw offset sStrCat_Var	; 53h
		dw offset sCall		; 54h
		dw offset sReturn	; 55h
		dw offset sStrCompare	; 56h
		dw offset sStrNCpy	; 57h
		dw offset sStrChrCat	; 58h
		dw offset sStrCat_Val	; 59h
		dw offset sStrClear	; 5Ah
		dw offset sStrCopy	; 5Bh
		dw offset loc_12E88	; 5Ch
		dw offset loc_12E5E	; 5Dh
		dw offset sSomethingClear; 5Eh
		dw offset sStr_SetDate	; 5Fh
		dw offset sGetFileDate	; 60h
		dw offset sSaveXYBuf	; 61h
		dw offset loc_12E9D	; 62h
		dw offset loc_12E31	; 63h
		dw offset loc_12E3D	; 64h
		dw offset loc_13564	; 65h
		dw offset sStrsFromFile	; 66h
		dw offset loc_12F76	; 67h
		dw offset loc_12EFA	; 68h
		dw offset sUndefined	; 69h
		dw offset loc_1348D	; 6Ah
		dw offset loc_134A9	; 6Bh
		dw offset sUndefined	; 6Ch
		dw offset sUndefined	; 6Dh
		dw offset sStrLen	; 6Eh
		dw offset sLoadVar_LongTo2Short; 6Fh
		dw offset sLoadVar_2ShortToLong; 70h
		dw offset sCompareLVars	; 71h
		dw offset sLoopInit	; 72h
		dw offset sLoopGet	; 73h
		dw offset sLoopCondJump	; 74h
		dw offset sLoadFontChr	; 75h
		dw offset sSetIdleChars	; 76h
		dw offset sSetIdleDelay	; 77h
		dw offset sSetIdlePos	; 78h
		dw offset sUndefined	; 79h
		dw offset sUndefined	; 7Ah
		dw offset sUndefined	; 7Bh
		dw offset sUndefined	; 7Ch
		dw offset sUndefined	; 7Dh
		dw offset sUndefined	; 7Eh
		dw offset sExitDOSVar	; 7Fh
		dw offset sStrsFromFile	; 80h
		dw offset sStrsToFile	; 81h
		dw offset loc_137D2	; 82h
		dw offset loc_13828	; 83h
		dw offset loc_13911	; 84h
		dw offset loc_13A6B	; 85h
		dw offset sPortraitDataAll; 86h
		dw offset sPortraitDataOne; 87h
		dw offset loc_13C66	; 88h
; ---------------------------------------------------------------------------

sUndefined:				; DATA XREF: seg000:scriptFuncListo
		call	RestoreInts
		push	cs
		pop	ds
		assume ds:seg000
		mov	dx, offset aExecUndefined ; "ñ¢íËã`ÇÃÉVÉXÉeÉÄó\\ñÒñΩóﬂÇé¿çsÇµÇ‹ÇµÇΩ\r"...
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		mov	ax, 4C00h
		int	21h		; DOS -	2+ - QUIT WITH EXIT CODE (EXIT)
					; AL = exit code
; ---------------------------------------------------------------------------

sExitDOS:				; DATA XREF: seg000:scriptFuncListo
		call	RestoreInts
		mov	ax, 4C00h
		int	21h		; DOS -	2+ - QUIT WITH EXIT CODE (EXIT)
					; AL = exit code
; ---------------------------------------------------------------------------

sExitDOSVar:				; DATA XREF: seg000:scriptFuncListo
		call	GetVariable
		push	ax
		call	RestoreInts
		pop	ax
		mov	ah, 4Ch
		int	21h		; DOS -	2+ - QUIT WITH EXIT CODE (EXIT)
					; AL = exit code
; ---------------------------------------------------------------------------

sLoadScene:				; DATA XREF: seg000:scriptFuncListo
		mov	word ptr cs:FileLoadDstPtr+4, ds
		xor	ax, ax
		mov	word ptr cs:FileLoadDstPtr+2, ax
		dec	ax
		mov	word ptr cs:FileLoadDstPtr, ax
		lodsw
		mov	bx, ax
		call	LoadFile
		jnb	short loc_125B9
		jmp	loc_1092A
; ---------------------------------------------------------------------------

loc_125B9:				; CODE XREF: seg000:25B4j
		xor	si, si

loc_125BB:				; CODE XREF: seg000:25BFj
		xor	byte ptr [si], 1
		inc	si
		jnz	short loc_125BB
		mov	si, 100h
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sDelay:					; DATA XREF: seg000:scriptFuncListo
		call	GetVariable
		mov	cx, ax
		call	WaitFrames
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sLoopInit:				; DATA XREF: seg000:scriptFuncListo
		cli
		lodsw
		mov	cs:scrLoopCounter, ax
		sti
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sLoopGet:				; DATA XREF: seg000:scriptFuncListo
		cli
		call	GetVarPtr
		mov	ax, cs:scrLoopCounter
		mov	cs:[bx], ax
		sti
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sLoopCondJump:				; DATA XREF: seg000:scriptFuncListo
		lodsw
		cmp	ax, cs:scrLoopCounter
		lodsw
		jb	short loc_125F6
		mov	si, ax

loc_125F6:				; CODE XREF: seg000:25F2j
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sSetChrDelay:				; DATA XREF: seg000:scriptFuncListo
		call	GetVariable
		mov	cs:printChrDelay, ax
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sStr_SetDate:				; DATA XREF: seg000:scriptFuncListo
		call	GetStringPtr
		mov	byte ptr cs:[bx], 0
		mov	ah, 2Ch
		int	21h		; DOS -	GET CURRENT TIME
					; Return: CH = hours, CL = minutes, DH = seconds
					; DL = hundredths of seconds
		mov	al, dh
		call	PrintInt_2Digs
		mov	al, ':'
		call	str_Prepend2B
		mov	al, cl
		call	PrintInt_2Digs
		mov	al, ':'
		call	str_Prepend2B
		mov	al, ch
		call	PrintInt_2Digs
		mov	al, ' '
		call	str_Prepend2B
		mov	ah, 2Ah
		int	21h		; DOS -	GET CURRENT DATE
					; Return: DL = day, DH = month,	CX = year
					; AL = day of the week (0=Sunday, 1=Monday, etc.)
		mov	al, dl
		call	PrintInt_2Digs
		mov	al, '-'
		call	str_Prepend2B
		mov	al, dh
		call	PrintInt_2Digs
		mov	al, '-'
		call	str_Prepend2B
		mov	ax, cx
		mov	cl, 100
		div	cl
		xchg	al, ah
		call	PrintInt_2Digs
		xchg	al, ah
		call	PrintInt_2Digs
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sGetFileDate:				; DATA XREF: seg000:scriptFuncListo
		call	sub_10949
		xor	ax, ax
		call	GetVarPtr
		mov	cs:[bx], ax
		mov	dx, bx
		call	GetStringPtr
		mov	cs:[bx], al
		mov	cx, bx
		lodsw
		mov	bx, ax
		push	si
		push	ds
		push	dx
		push	cx
		mov	al, cs:DiskLetter
		mov	ah, ':'
		mov	cs:FileDiskDrive, ax
		cmp	cs:byte_19F75, 0
		jnz	short loc_12690
		mov	al, [bx]
		cmp	al, 2
		cmc
		adc	byte ptr cs:FileDiskDrive, 0

loc_12690:				; CODE XREF: seg000:2683j
		call	strdup_fn
		push	cs
		pop	ds
		mov	dx, offset FileDiskDrive
		mov	ax, 3D00h
		int	21h		; DOS -	2+ - OPEN DISK FILE WITH HANDLE
					; DS:DX	-> ASCIZ filename
					; AL = access mode
					; 0 - read
		jb	short loc_1271A
		mov	bx, ax
		mov	ax, 5700h
		int	21h		; DOS -	2+ - GET FILE'S DATE/TIME
					; BX = file handle
		mov	ah, 3Eh
		int	21h		; DOS -	2+ - CLOSE A FILE WITH HANDLE
					; BX = file handle
		pop	bx
		mov	al, cl
		and	al, 1Fh
		add	al, al
		call	PrintInt_2Digs
		mov	al, ':'
		call	str_Prepend2B
		shr	cx, 5
		mov	al, cl
		and	al, 3Fh
		call	PrintInt_2Digs
		mov	al, ':'
		call	str_Prepend2B
		shr	cx, 6
		mov	al, cl
		and	al, 1Fh
		call	PrintInt_2Digs
		mov	al, ' '
		call	str_Prepend2B
		mov	al, dl
		and	al, 1Fh
		call	PrintInt_2Digs
		mov	al, '-'
		call	str_Prepend2B
		shr	dx, 5
		mov	al, dl
		and	al, 0Fh
		call	PrintInt_2Digs
		mov	al, '-'
		call	str_Prepend2B
		shr	dx, 4
		and	dl, 7Fh
		add	dx, 1980
		mov	ax, dx
		mov	cl, 100
		div	cl
		xchg	al, ah
		call	PrintInt_2Digs
		xchg	al, ah
		call	PrintInt_2Digs
		pop	bx
		mov	word ptr cs:[bx], 1
		pop	ds
		pop	si
		call	sub_1096C
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

loc_1271A:				; CODE XREF: seg000:269Dj
		pop	bx
		pop	bx
		pop	ds
		pop	si
		call	sub_1096C
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sLoadVar_Val:				; DATA XREF: seg000:scriptFuncListo
		cmp	word ptr [si], 400h
		jnb	short loc_12734
		call	GetVarPtr
		lodsw
		mov	cs:[bx], ax
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

loc_12734:				; CODE XREF: seg000:2728j
		call	GetLVarPtr
		lodsw
		mov	cs:[bx], ax
		lodsw
		mov	cs:[bx+2], ax
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sLoadVar_Var:				; DATA XREF: seg000:scriptFuncListo
		cmp	word ptr [si], 400h
		jnb	short loc_12755
		call	GetVarPtr
		call	GetVariable
		mov	cs:[bx], ax
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

loc_12755:				; CODE XREF: seg000:2747j
		call	GetLVarPtr
		call	GetLVariable
		mov	cs:[bx], ax
		mov	cs:[bx+2], dx
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sClearVars:				; DATA XREF: seg000:scriptFuncListo
		call	GetVarPtr
		mov	cx, bx
		call	GetVarPtr
		xchg	cx, bx
		sub	cx, bx
		inc	cx
		inc	cx
		push	cs
		pop	es
		assume es:seg000
		mov	di, bx
		xor	al, al
		rep stosb
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

loc_1277E:				; DATA XREF: seg000:scriptFuncListo
		push	0F000h		; NOTE:	Removed	in SYS98 v3.00
		pop	es
		assume es:nothing
		mov	di, cs:word_1A00C
		mov	dx, es:[di]
		mov	cs:word_1A00C, dx
		call	GetVarPtr
		lodsw
		inc	al
		mov	cl, al
		mov	ax, 1
		rol	ax, cl
		dec	ax
		and	ax, dx
		mov	cs:[bx], ax
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sGetVarXY:				; DATA XREF: seg000:scriptFuncListo
		call	GetVarPtr
		push	bx
		call	GetVariable
		mov	bx, ax
		call	GetVariable
		shl	ax, 2
		add	bx, ax
		shl	ax, 2
		add	bx, ax
		add	bx, bx
		add	bx, offset ScrBufferXY
		mov	ax, cs:[bx]
		pop	bx
		mov	cs:[bx], ax
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sSetVarXY:				; DATA XREF: seg000:scriptFuncListo
		call	GetVariable
		push	ax
		call	GetVariable
		mov	bx, ax
		call	GetVariable
		shl	ax, 2
		add	bx, ax
		shl	ax, 2
		add	bx, ax
		add	bx, bx
		add	bx, offset ScrBufferXY
		pop	ax
		mov	cs:[bx], ax
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sSaveVarBufAll:				; DATA XREF: seg000:scriptFuncListo
		mov	word ptr cs:FileLoadDstPtr+4, cs ; NOTE: Removed in SYS98 v3.00
		mov	word ptr cs:FileLoadDstPtr+2, offset ScrVariables1
		mov	word ptr cs:FileLoadDstPtr, 800h
		lodsw
		mov	bx, ax
		call	WriteFile
		jnb	short loc_1280C
		jmp	loc_1092A
; ---------------------------------------------------------------------------

loc_1280C:				; CODE XREF: seg000:2807j
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sLoadVarBufAll:				; DATA XREF: seg000:scriptFuncListo
		mov	word ptr cs:FileLoadDstPtr+4, cs ; NOTE: Removed in SYS98 v3.00
		mov	word ptr cs:FileLoadDstPtr+2, offset ScrVariables1
		mov	word ptr cs:FileLoadDstPtr, 800h
		lodsw
		mov	bx, ax
		call	LoadFile
		jnb	short loc_1282D
		jmp	loc_1092A
; ---------------------------------------------------------------------------

loc_1282D:				; CODE XREF: seg000:2828j
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sSaveVarBuf:				; DATA XREF: seg000:scriptFuncListo
		mov	word ptr cs:FileLoadDstPtr+4, cs
		mov	word ptr cs:FileLoadDstPtr+2, offset ScrVariables1
		mov	word ptr cs:FileLoadDstPtr, 3E8h
		lodsw
		or	ax, ax
		jz	short loc_12856
		mov	word ptr cs:FileLoadDstPtr+2, (offset ScrVariables1+3E8h)
		mov	word ptr cs:FileLoadDstPtr, 418h

loc_12856:				; CODE XREF: seg000:2846j
		lodsw
		mov	bx, ax
		call	WriteFile
		jnb	short loc_12861
		jmp	loc_1092A
; ---------------------------------------------------------------------------

loc_12861:				; CODE XREF: seg000:285Cj
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sLoadVarBuf:				; DATA XREF: seg000:scriptFuncListo
		mov	word ptr cs:FileLoadDstPtr+4, cs
		mov	word ptr cs:FileLoadDstPtr+2, offset ScrVariables1
		mov	word ptr cs:FileLoadDstPtr, 3E8h
		lodsw
		or	ax, ax
		jz	short loc_1288A
		mov	word ptr cs:FileLoadDstPtr+2, (offset ScrVariables1+3E8h)
		mov	word ptr cs:FileLoadDstPtr, 418h

loc_1288A:				; CODE XREF: seg000:287Aj
		lodsw
		mov	bx, ax
		call	LoadFile
		jnb	short loc_12895
		jmp	loc_1092A
; ---------------------------------------------------------------------------

loc_12895:				; CODE XREF: seg000:2890j
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sSaveXYBuf:				; DATA XREF: seg000:scriptFuncListo
		mov	word ptr cs:FileLoadDstPtr+4, cs
		mov	word ptr cs:FileLoadDstPtr+2, offset ScrBufferXY
		mov	word ptr cs:FileLoadDstPtr, 800
		lodsw
		mov	bx, ax
		call	WriteFile
		jnb	short loc_128B6
		jmp	loc_1092A
; ---------------------------------------------------------------------------

loc_128B6:				; CODE XREF: seg000:28B1j
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sLoadXYBuf:				; DATA XREF: seg000:scriptFuncListo
		mov	word ptr cs:FileLoadDstPtr+4, cs
		mov	word ptr cs:FileLoadDstPtr+2, offset ScrBufferXY
		mov	word ptr cs:FileLoadDstPtr, 800
		lodsw
		mov	bx, ax
		call	LoadFile
		jnb	short loc_128D7
		jmp	loc_1092A
; ---------------------------------------------------------------------------

loc_128D7:				; CODE XREF: seg000:28D2j
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sLoadVar_LongTo2Short:			; DATA XREF: seg000:scriptFuncListo
		call	GetVarPtr	; NOTE:	Removed	in SYS98 v3.00
		call	GetLVariable	; get AX (low) / DX (high)
		mov	cs:[bx], dx	; write	to BX+0	(high) / BX+2 (low)
		mov	cs:[bx+2], ax
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sLoadVar_2ShortToLong:			; DATA XREF: seg000:scriptFuncListo
		call	GetLVarPtr	; NOTE:	Removed	in SYS98 v3.00
		push	bx
		call	GetVarPtr
		mov	dx, cs:[bx]	; get DX (low)
		mov	ax, cs:[bx+2]	; get AX (high)
		pop	bx
		mov	cs:[bx], ax	; write	as 4-byte word (AX low,	DX high)
		mov	cs:[bx+2], dx
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sAddVar_Cast:				; DATA XREF: seg000:scriptFuncListo
		cmp	word ptr [si], 400h
		jnb	short loc_12915
		call	GetVarPtr
		call	GetVariable
		add	cs:[bx], ax
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

loc_12915:				; CODE XREF: seg000:2907j
		call	GetLVarPtr
		cmp	word ptr [si], 400h
		jnb	short loc_12925
		call	GetVariable
		xor	dx, dx
		jmp	short loc_12928
; ---------------------------------------------------------------------------

loc_12925:				; CODE XREF: seg000:291Cj
		call	GetLVariable

loc_12928:				; CODE XREF: seg000:2923j
		add	cs:[bx], ax
		adc	cs:[bx+2], dx
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sAddVar_Val:				; DATA XREF: seg000:scriptFuncListo
		cmp	word ptr [si], 400h
		jnb	short loc_12942
		call	GetVarPtr
		lodsw
		add	cs:[bx], ax
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

loc_12942:				; CODE XREF: seg000:2936j
		call	GetLVarPtr
		lodsw
		mov	dx, ax
		lodsw
		add	cs:[bx], dx
		adc	cs:[bx+2], ax
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sSubVar_Cast:				; DATA XREF: seg000:scriptFuncListo
		cmp	word ptr [si], 400h
		jnb	short loc_12971
		call	GetVarPtr
		call	GetVariable
		sub	cs:[bx], ax
		jnb	short loc_1296E
		mov	cs:ScrVariables1, 1
		neg	word ptr cs:[bx]

loc_1296E:				; CODE XREF: seg000:2962j
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

loc_12971:				; CODE XREF: seg000:2957j
		call	GetLVarPtr
		cmp	word ptr [si], 400h
		jnb	short loc_12981
		call	GetVariable
		xor	dx, dx
		jmp	short loc_12984
; ---------------------------------------------------------------------------

loc_12981:				; CODE XREF: seg000:2978j
		call	GetLVariable

loc_12984:				; CODE XREF: seg000:297Fj
		sub	cs:[bx], ax
		sbb	cs:[bx+2], dx
		jnb	short loc_1299B
		mov	cs:ScrVariables1, 1
		neg	word ptr cs:[bx]
		neg	word ptr cs:[bx+2]

loc_1299B:				; CODE XREF: seg000:298Bj
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sSubVar_Val:				; DATA XREF: seg000:scriptFuncListo
		cmp	word ptr [si], 400h
		jnb	short loc_129BA
		call	GetVarPtr
		lodsw
		sub	cs:[bx], ax
		jnb	short loc_129B7
		mov	cs:ScrVariables1, 1
		neg	word ptr cs:[bx]

loc_129B7:				; CODE XREF: seg000:29ABj
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

loc_129BA:				; CODE XREF: seg000:29A2j
		call	GetLVarPtr
		lodsw
		mov	dx, ax
		lodsw
		sub	cs:[bx], dx
		sbb	cs:[bx+2], ax
		jnb	short loc_129D8
		mov	cs:ScrVariables1, 1
		neg	word ptr cs:[bx]
		neg	word ptr cs:[bx+2]

loc_129D8:				; CODE XREF: seg000:29C8j
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sMulVar_Var:				; DATA XREF: seg000:scriptFuncListo
		cmp	word ptr [si], 400h
		jnb	short loc_129F6
		call	GetVarPtr
		call	GetVariable
		mov	cx, ax
		xor	dx, dx
		mov	ax, cs:[bx]
		mul	cx
		mov	cs:[bx], ax

loc_129F3:				; CODE XREF: seg000:2A0Dj
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

loc_129F6:				; CODE XREF: seg000:29DFj
		call	GetLVarPtr
		mov	di, bx
		xor	bx, bx
		xor	cx, cx
		xchg	bx, cs:[di]
		xchg	cx, cs:[di+2]
		call	GetLVariable

loc_12A09:				; CODE XREF: seg000:2A1Cj
		push	ax
		or	ax, dx
		pop	ax
		jz	short loc_129F3
		add	cs:[di], bx
		adc	cs:[di+2], cx
		sub	ax, 1
		sbb	dx, 0
		jmp	short loc_12A09
; ---------------------------------------------------------------------------

sDivVar_Var:				; DATA XREF: seg000:scriptFuncListo
		cmp	word ptr [si], 400h
		jnb	short loc_12A43
		call	GetVarPtr
		mov	di, bx
		mov	ax, cs:[di]
		xor	dx, dx
		call	GetVarPtr
		mov	cx, cs:[bx]
		or	cx, cx
		jz	short loc_12A40
		div	cx
		mov	cs:[di], ax
		mov	cs:[bx], dx

loc_12A40:				; CODE XREF: seg000:2A36j seg000:2A56j
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

loc_12A43:				; CODE XREF: seg000:2A22j
		call	GetLVarPtr
		mov	di, bx
		call	GetLVarPtr
		mov	ax, cs:[bx]
		mov	dx, cs:[bx+2]
		push	ax
		or	ax, dx
		pop	ax
		jz	short loc_12A40
		push	bx
		xor	bx, bx
		xor	cx, cx
		xchg	bx, cs:[di]
		xchg	cx, cs:[di+2]

loc_12A64:				; CODE XREF: seg000:2A73j
		sub	bx, ax
		sbb	cx, dx
		jb	short loc_12A75
		add	word ptr cs:[di], 1
		adc	word ptr cs:[di+2], 0
		jmp	short loc_12A64
; ---------------------------------------------------------------------------

loc_12A75:				; CODE XREF: seg000:2A68j
		add	ax, bx
		adc	dx, cx
		pop	bx
		mov	cs:[bx], ax
		mov	cs:[bx+2], dx
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sAndVar_Var:				; DATA XREF: seg000:scriptFuncListo
		call	GetVarPtr
		call	GetVariable
		and	cs:[bx], ax
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sAndVar_Val:				; DATA XREF: seg000:scriptFuncListo
		call	GetVarPtr
		lodsw
		and	cs:[bx], ax
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sOrVar_Var:				; DATA XREF: seg000:scriptFuncListo
		call	GetVarPtr
		call	GetVariable
		or	cs:[bx], ax
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sOrVar_Val:				; DATA XREF: seg000:scriptFuncListo
		call	GetVarPtr
		lodsw
		or	cs:[bx], ax
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sCompareVars:				; DATA XREF: seg000:scriptFuncListo
		mov	cs:scrCmpResult, 0 ; reset comparision result first
		call	GetVariable	; get variable var1
		mov	dx, ax
		call	GetVariable	; get variable var2
		cmp	dx, ax
		jz	short loc_12ACE	; var1 == var2 -> keep 0
		jb	short loc_12AC9	; var1 < var2 -> set to	1
		inc	cs:scrCmpResult	; var1 > var2 -> set to	2

loc_12AC9:				; CODE XREF: seg000:2AC2j
		inc	cs:scrCmpResult

loc_12ACE:				; CODE XREF: seg000:2AC0j
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sCompareValVal:				; DATA XREF: seg000:scriptFuncListo
		mov	cs:scrCmpResult, 0
		call	GetVariable
		mov	dx, ax
		lodsw
		cmp	dx, ax
		jz	short loc_12AED	; var == value -> keep 0
		jb	short loc_12AE8	; var <	value -> set to	1
		inc	cs:scrCmpResult	; var >	value -> set to	2

loc_12AE8:				; CODE XREF: seg000:2AE1j
		inc	cs:scrCmpResult

loc_12AED:				; CODE XREF: seg000:2ADFj
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sCompareLVars:				; DATA XREF: seg000:scriptFuncListo
		mov	cs:scrCmpResult, 0 ; NOTE: Removed in SYS98 v3.00
		call	GetLVariable
		mov	bx, ax
		mov	cx, dx
		call	GetLVariable
		sub	bx, ax
		sbb	cx, dx
		jz	short loc_12B12	; var1 == var2 -> keep 0
		jb	short loc_12B0D	; var1 < var2 -> set to	1
		inc	cs:scrCmpResult	; var1 > var2 -> set to	2

loc_12B0D:				; CODE XREF: seg000:2B06j
		inc	cs:scrCmpResult

loc_12B12:				; CODE XREF: seg000:2B04j
		mov	al, cs:scrCmpResult
		cbw			; difference to	sCompareVars:
		mov	cs:ScrVariables1, ax ; The result is also saved	to variable 0.
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sJump:					; DATA XREF: seg000:scriptFuncListo
		lodsw
		mov	si, ax
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sCondJmp_EQ:				; DATA XREF: seg000:scriptFuncListo
		lodsw
		cmp	cs:scrCmpResult, 0
		jnz	short loc_12B2F
		mov	si, ax

loc_12B2F:				; CODE XREF: seg000:2B2Bj
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sCondJmp_LT:				; DATA XREF: seg000:scriptFuncListo
		lodsw
		cmp	cs:scrCmpResult, 1
		jnz	short loc_12B3D
		mov	si, ax

loc_12B3D:				; CODE XREF: seg000:2B39j
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sCondJmp_GT:				; DATA XREF: seg000:scriptFuncListo
		lodsw
		cmp	cs:scrCmpResult, 2
		jnz	short loc_12B4B
		mov	si, ax

loc_12B4B:				; CODE XREF: seg000:2B47j
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sCondJmp_GE:				; DATA XREF: seg000:scriptFuncListo
		lodsw
		cmp	cs:scrCmpResult, 1
		jz	short loc_12B59
		mov	si, ax

loc_12B59:				; CODE XREF: seg000:2B55j
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sCondJmp_LE:				; DATA XREF: seg000:scriptFuncListo
		lodsw
		cmp	cs:scrCmpResult, 2
		jz	short loc_12B67
		mov	si, ax

loc_12B67:				; CODE XREF: seg000:2B63j
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sCondJmp_NE:				; DATA XREF: seg000:scriptFuncListo
		lodsw
		cmp	cs:scrCmpResult, 0
		jz	short loc_12B75
		mov	si, ax

loc_12B75:				; CODE XREF: seg000:2B71j
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sTblJump:				; DATA XREF: seg000:scriptFuncListo
		call	GetVariable
		add	ax, ax
		mov	bx, ax
		mov	si, [bx+si]
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sCall:					; DATA XREF: seg000:scriptFuncListo
		lodsw
		mov	bx, cs:scrStackPtr
		mov	cs:[bx], si
		inc	bx
		inc	bx
		mov	cs:scrStackPtr,	bx
		mov	si, ax
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sReturn:				; DATA XREF: seg000:scriptFuncListo
		mov	bx, cs:scrStackPtr
		dec	bx
		dec	bx
		mov	si, cs:[bx]
		mov	cs:scrStackPtr,	bx
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

loc_12BAB:				; DATA XREF: seg000:scriptFuncListo
		push	si
		push	ds
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		push	cs
		pop	es
		assume es:seg000
		mov	di, 5E3Fh
		xor	si, si
		call	sub_12C03
		mov	di, 62BFh
		mov	si, 6
		call	sub_12C03
		mov	di, 673Fh
		mov	si, 0Ch
		call	sub_12C03
		mov	di, 6BBFh
		mov	si, 12h
		call	sub_12C03
		mov	di, 703Fh
		mov	si, 18h
		call	sub_12C03
		mov	di, 74BFh
		mov	si, 1Eh
		call	sub_12C03
		mov	di, 793Fh
		mov	si, 24h
		call	sub_12C03
		mov	di, 7DBFh
		mov	si, 2Ah
		call	sub_12C03
		xor	al, al
		out	0A6h, al	; Interrupt Controller #2, 8259A
		pop	ds
		pop	si
		jmp	ScriptMainLoop

; =============== S U B	R O U T	I N E =======================================


sub_12C03	proc near		; CODE XREF: seg000:2BB8p seg000:2BC1p ...
		mov	cl, 3

loc_12C05:				; CODE XREF: sub_12C03+39j
		mov	ch, 3

loc_12C07:				; CODE XREF: sub_12C03+37j
		mov	ax, 3
		sub	al, ch
		add	ax, ax
		mov	bx, 3
		sub	bl, cl
		shl	bx, 4
		shl	bx, 4
		add	ax, bx
		shl	bx, 2
		add	bx, ax
		mov	ax, 0A800h
		call	sub_12C3F
		mov	ax, 0B000h
		call	sub_12C3F
		mov	ax, 0B800h
		call	sub_12C3F
		mov	ax, 0E000h
		call	sub_12C3F
		dec	ch
		jnz	short loc_12C07
		loop	loc_12C05
		retn
sub_12C03	endp


; =============== S U B	R O U T	I N E =======================================


sub_12C3F	proc near		; CODE XREF: sub_12C03+20p
					; sub_12C03+26p ...
		push	bx
		push	cx
		mov	ds, ax
		mov	cx, 10h

loc_12C46:				; CODE XREF: sub_12C3F+Dj
		mov	ax, [bx+si]
		stosw
		add	bx, 50h
		loop	loc_12C46
		pop	cx
		pop	bx
		retn
sub_12C3F	endp

; ---------------------------------------------------------------------------

sOpenTextBox:				; DATA XREF: seg000:scriptFuncListo
		cmp	byte ptr [si], 8
		jb	short loc_12C59
		jmp	loc_10B3F
; ---------------------------------------------------------------------------

loc_12C59:				; CODE XREF: seg000:2C54j
		call	GetTextBoxPtr
		or	byte ptr cs:[bx], 0
		jz	short loc_12C6F
		or	byte ptr cs:[bx+1], 0
		jz	short loc_12C6F
		add	si, 0Ah
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

loc_12C6F:				; CODE XREF: seg000:2C60j seg000:2C67j
		lodsw
		mov	cs:[bx+2], ax
		lodsw
		mov	cs:[bx+4], ax
		lodsw
		mov	cs:[bx+6], ax
		lodsw
		mov	cs:[bx+8], ax
		lodsw
		mov	cs:[bx+0Ah], ax
		mov	byte ptr cs:[bx+1], 1
		or	byte ptr cs:[bx], 0
		jz	short loc_12C96
		call	sub_10B8C

loc_12C96:				; CODE XREF: seg000:2C91j
		or	word ptr cs:[bx+0Ah], 0
		jz	short loc_12CA0
		call	sub_10C2C

loc_12CA0:				; CODE XREF: seg000:2C9Bj
		call	sub_10DF4
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sClearTextBox:				; DATA XREF: seg000:scriptFuncListo
		cmp	byte ptr [si], 8
		jb	short loc_12CAE
		jmp	loc_10E4F
; ---------------------------------------------------------------------------

loc_12CAE:				; CODE XREF: seg000:2CA9j
		call	GetTextBoxPtr
		or	byte ptr cs:[bx+1], 0
		jnz	short loc_12CBB
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

loc_12CBB:				; CODE XREF: seg000:2CB6j
		or	word ptr cs:[bx+0Ah], 0
		jz	short loc_12CC5
		call	sub_10C2C

loc_12CC5:				; CODE XREF: seg000:2CC0j
		call	sub_10DF4
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sCloseTextBox:				; DATA XREF: seg000:scriptFuncListo
		call	GetTextBoxPtr
		or	byte ptr cs:[bx+1], 0
		jnz	short loc_12CD8
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

loc_12CD8:				; CODE XREF: seg000:2CD3j
		mov	byte ptr cs:[bx+1], 0
		push	si
		push	ds
		call	sub_10E6C
		call	sub_10EC2
		pop	ds
		pop	si
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sWritePortA4:				; DATA XREF: seg000:scriptFuncListo
		call	GetVariable
		and	al, 1
		out	0A4h, al	; Interrupt Controller #2, 8259A
		mov	cs:portA4State,	al
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sReadPortA4:				; DATA XREF: seg000:scriptFuncListo
		call	GetVarPtr
		mov	al, cs:portA4State
		cbw
		mov	cs:[bx], ax
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sTextBoxImage:				; DATA XREF: seg000:scriptFuncListo
		call	GetTextBoxPtr	; NOTE:	Removed	in SYS98 v3.00
		or	byte ptr cs:[bx+1], 0
		jnz	short loc_12D13
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

loc_12D13:				; CODE XREF: seg000:2D0Ej
		mov	ax, cs:[bx+2]
		inc	ax
		add	ax, ax
		mov	cs:word_19F59, ax
		mov	cs:word_19F6C, ax
		mov	ax, cs:[bx+4]
		inc	ax
		shl	ax, 4
		mov	cs:word_19F5B, ax
		mov	cs:word_19F6E, ax
		lodsw
		push	ax
		xor	al, al
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	ax, cs:word_19FD2
		mov	word ptr cs:FileLoadDstPtr+4, ax
		xor	ax, ax
		mov	word ptr cs:FileLoadDstPtr+2, ax
		dec	ax
		mov	word ptr cs:FileLoadDstPtr, ax
		lodsw
		mov	bx, ax
		lodsw
		mov	cs:byte_19F73, al
		xor	al, al
		out	0A4h, al	; Interrupt Controller #2, 8259A
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	cs:byte_19F72, al
		call	LoadFile
		jb	short loc_12D76
		call	LoadPIImage1
		call	DoPalThing
		pop	ax
		or	al, al
		jz	short loc_12D73
		call	WaitForVSync
		call	UploadPalette

loc_12D73:				; CODE XREF: seg000:2D6Bj
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

loc_12D76:				; CODE XREF: seg000:2D60j
		pop	ax
		pop	ax
		jmp	loc_1092A
; ---------------------------------------------------------------------------

sLoadImage:				; DATA XREF: seg000:scriptFuncListo
		lodsw
		mov	cs:word_19F59, ax
		mov	cs:word_19F6C, ax
		lodsw
		mov	cs:word_19F5B, ax
		mov	cs:word_19F6E, ax
		lodsw
		push	ax
		lodsw
		mov	cs:byte_19F72, al
		cmp	al, 2
		jnb	short loc_12D9A
		out	0A6h, al

loc_12D9A:				; CODE XREF: seg000:2D96j
		mov	ax, cs:word_19FD2
		mov	word ptr cs:FileLoadDstPtr+4, ax
		xor	ax, ax
		mov	word ptr cs:FileLoadDstPtr+2, ax
		dec	ax
		mov	word ptr cs:FileLoadDstPtr, ax
		lodsw
		mov	bx, ax
		lodsw
		mov	cs:byte_19F73, al
		call	LoadFile
		jb	short loc_12DD2
		call	LoadPIImage1
		call	DoPalThing
		pop	ax
		or	al, al
		jz	short loc_12DCB
		call	WaitForVSync
		call	UploadPalette

loc_12DCB:				; CODE XREF: seg000:2DC3j
		xor	al, al
		out	0A6h, al	; Interrupt Controller #2, 8259A
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

loc_12DD2:				; CODE XREF: seg000:2DB8j
		pop	ax
		pop	ax
		jmp	loc_1092A
; ---------------------------------------------------------------------------

loc_12DD7:				; DATA XREF: seg000:scriptFuncListo
		call	sub_10EFF
		call	sub_10F63
		mov	cs:byte_19F63, 0
		call	sub_10F89
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

loc_12DE9:				; DATA XREF: seg000:scriptFuncListo
		call	sub_10F19
		call	sub_10F73
		mov	cs:byte_19F63, 0
		call	sub_10F89
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

loc_12DFB:				; DATA XREF: seg000:scriptFuncListo
		call	GetVariable
		mov	byte ptr cs:unk_19F58, al
		call	GetVariable
		mov	cs:word_19F59, ax
		call	GetVariable
		mov	cs:word_19F5B, ax
		call	GetVariable
		add	ax, ax
		add	ax, ax
		mov	cs:word_19F5F, ax
		call	GetVariable
		mov	cs:word_19F61, ax
		call	sub_10F73
		mov	cs:byte_19F63, 0
		call	sub_10F89
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

loc_12E31:				; DATA XREF: seg000:scriptFuncListo
		call	sub_10EFF
		call	sub_10F63
		call	sub_110EC
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

loc_12E3D:				; DATA XREF: seg000:scriptFuncListo
		call	sub_10F19
		call	sub_10F73
		call	sub_110EC
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

loc_12E49:				; DATA XREF: seg000:scriptFuncListo
		call	sub_10EFF	; NOTE:	Removed	in SYS98 v3.00
		call	sub_10F3D
		call	sub_10F63
		mov	cs:byte_19F63, 1
		call	sub_10F89
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

loc_12E5E:				; DATA XREF: seg000:scriptFuncListo
		call	sub_10F19	; NOTE:	Removed	in SYS98 v3.00
		call	sub_10F4D
		call	sub_10F73
		mov	cs:byte_19F63, 1
		call	sub_10F89
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

loc_12E73:				; DATA XREF: seg000:scriptFuncListo
		call	sub_10EFF	; NOTE:	Removed	in SYS98 v3.00
		call	sub_10F3D
		call	sub_10F63
		mov	cs:byte_19F63, 2
		call	sub_10F89
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

loc_12E88:				; DATA XREF: seg000:scriptFuncListo
		call	sub_10F19	; NOTE:	Removed	in SYS98 v3.00
		call	sub_10F4D
		call	sub_10F73
		mov	cs:byte_19F63, 2
		call	sub_10F89
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

loc_12E9D:				; DATA XREF: seg000:scriptFuncListo
		call	GetVariable
		mov	bx, ax
		call	GetVariable
		mov	cx, 190h
		sub	cx, ax
		mov	dx, ax
		shl	ax, 3
		add	bx, ax
		shl	ax, 2
		add	bx, ax
		add	bx, 4000h
		in	al, 31h
		not	al
		and	al, 80h
		shr	al, 1
		shl	cx, 4
		shl	dx, 4
		or	ch, al
		or	dh, al
		mov	al, 70h
		call	sub_109EB
		mov	al, bl
		call	sub_109F8
		mov	al, bh
		call	sub_109F8
		mov	al, cl
		call	sub_109F8
		mov	al, ch
		call	sub_109F8
		xor	al, al
		call	sub_109F8
		call	sub_109F8
		mov	al, dl
		call	sub_109F8
		mov	al, dh
		call	sub_109F8
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

loc_12EFA:				; DATA XREF: seg000:scriptFuncListo
		call	GetVariable
		push	ax
		call	GetVariable
		mov	cx, ax
		pop	ax
		push	si
		push	ds
		shl	ax, 4
		mov	si, ax
		shl	ax, 2
		add	si, ax
		shl	cx, 3
		mov	ax, cx
		shl	cx, 2
		add	cx, ax
		mov	ax, 0A800h
		call	sub_12F37
		mov	ax, 0B000h
		call	sub_12F37
		mov	ax, 0B800h
		call	sub_12F37
		mov	ax, 0E000h
		call	sub_12F37
		pop	ds
		pop	si
		jmp	ScriptMainLoop

; =============== S U B	R O U T	I N E =======================================


sub_12F37	proc near		; CODE XREF: seg000:2F1Dp seg000:2F23p ...
		mov	ds, ax
		mov	es, cs:word_19FD2
		assume es:nothing
		xor	di, di
		xor	al, al
		out	0A6h, al	; Interrupt Controller #2, 8259A
		push	cx
		push	si
		rep movsw
		pop	si
		pop	cx
		inc	al
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	di, 8000h
		push	cx
		push	si
		rep movsw
		pop	di
		pop	cx
		mov	ax, ds
		mov	es, ax
		assume es:seg000
		mov	ds, cs:word_19FD2
		xor	si, si
		push	cx
		push	di
		rep movsw
		pop	di
		pop	cx
		xor	al, al
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	si, 8000h
		push	cx
		push	di
		rep movsw
		pop	si
		pop	cx
		retn
sub_12F37	endp

; ---------------------------------------------------------------------------

loc_12F76:				; DATA XREF: seg000:scriptFuncListo
		cli
		in	al, 0Ah		; DMA controller, 8237A-5.
					; single mask bit register
					; 0-1: select channel (00=0; 01=1; 10=2; 11=3)
					; 2: 1=set mask	for channel; 0=clear mask (enable)
		push	ax
		or	al, 20h
		out	0Ah, al		; DMA controller, 8237A-5.
					; single mask bit register
					; 0-1: select channel (00=0; 01=1; 10=2; 11=3)
					; 2: 1=set mask	for channel; 0=clear mask (enable)
		sti
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		lodsw
		mov	dl, al
		lodsw
		mov	dh, al
		lodsw
		mov	cl, al
		lodsw
		mov	ch, al
		mov	ah, dh

loc_12F91:				; CODE XREF: seg000:2FB9j
		mov	al, dl

loc_12F93:				; CODE XREF: seg000:2FB3j
		push	0A800h
		pop	es
		assume es:nothing
		call	sub_12FC7
		push	0B000h
		pop	es
		assume es:nothing
		call	sub_12FC7
		push	0B800h
		pop	es
		assume es:nothing
		call	sub_12FC7
		push	0E000h
		pop	es
		assume es:nothing
		call	sub_12FC7
		inc	al
		cmp	cl, al
		jnb	short loc_12F93
		inc	ah
		cmp	ch, ah
		jnb	short loc_12F91
		xor	al, al
		out	0A6h, al	; Interrupt Controller #2, 8259A
		cli
		pop	ax
		out	0Ah, al		; DMA controller, 8237A-5.
					; single mask bit register
					; 0-1: select channel (00=0; 01=1; 10=2; 11=3)
					; 2: 1=set mask	for channel; 0=clear mask (enable)
		sti
		jmp	ScriptMainLoop

; =============== S U B	R O U T	I N E =======================================


sub_12FC7	proc near		; CODE XREF: seg000:2F97p seg000:2F9Ep ...
		pusha
		mov	dh, ah
		xor	dl, dl
		shr	dx, 2
		shr	al, 1
		pushf
		add	ax, dx
		mov	di, ax
		mov	al, es:[di]
		popf
		jb	short loc_12FE6
		shl	al, 1
		mov	al, 0F0h
		jb	short loc_13001
		not	al
		jmp	short loc_12FEE
; ---------------------------------------------------------------------------

loc_12FE6:				; CODE XREF: sub_12FC7+13j
		and	al, 8
		mov	al, 0Fh
		jnz	short loc_13001
		not	al

loc_12FEE:				; CODE XREF: sub_12FC7+1Dj
		and	es:[di], al
		and	es:[di+50h], al
		and	es:[di+0A0h], al
		and	es:[di+0F0h], al
		popa
		retn
; ---------------------------------------------------------------------------

loc_13001:				; CODE XREF: sub_12FC7+19j
					; sub_12FC7+23j
		or	es:[di], al
		or	es:[di+50h], al
		or	es:[di+0A0h], al
		or	es:[di+0F0h], al
		popa
		retn
sub_12FC7	endp

; ---------------------------------------------------------------------------

sFillGVRAM:				; DATA XREF: seg000:scriptFuncListo
		mov	dl, 1Bh
		mov	ah, 2
		int	21h		; DOS -	DISPLAY	OUTPUT
					; DL = character to send to standard output
		mov	dl, 2Ah
		int	21h		; DOS -	DISPLAY	OUTPUT
					; DL = character to send to standard output
		xor	al, al
		out	0A6h, al	; Interrupt Controller #2, 8259A
		cld
		mov	ax, 0A800h
		call	sub_1303E
		mov	ax, 0B000h
		call	sub_1303E
		mov	ax, 0B800h
		call	sub_1303E
		mov	ax, 0E000h
		call	sub_1303E
		jmp	ScriptMainLoop

; =============== S U B	R O U T	I N E =======================================


sub_1303E	proc near		; CODE XREF: seg000:3026p seg000:302Cp ...
		mov	es, ax
		assume es:nothing
		xor	di, di
		xor	ax, ax
		mov	cx, 4000h
		rep stosw
		retn
sub_1303E	endp

; ---------------------------------------------------------------------------

sSomethingClear:			; DATA XREF: seg000:scriptFuncListo
		lodsw
		out	0A6h, al	; Interrupt Controller #2, 8259A
		lodsw
		mov	dx, ax
		lodsw
		shl	ax, 4
		add	dx, ax
		shl	ax, 2
		add	ax, dx
		mov	bx, ax
		cld
		mov	ax, 0A800h
		call	sub_1307B
		mov	ax, 0B000h
		call	sub_1307B
		mov	ax, 0B800h
		call	sub_1307B
		mov	ax, 0E000h
		call	sub_1307B
		lodsw
		lodsw
		jmp	ScriptMainLoop

; =============== S U B	R O U T	I N E =======================================


sub_1307B	proc near		; CODE XREF: seg000:3061p seg000:3067p ...
		push	bx
		mov	es, ax
		mov	cx, [si+2]

loc_13081:				; CODE XREF: sub_1307B+13j
		push	cx
		mov	di, bx
		add	bx, 50h
		xor	al, al
		mov	cx, [si]
		rep stosb
		pop	cx
		loop	loc_13081
		pop	bx
		retn
sub_1307B	endp

; ---------------------------------------------------------------------------

sSetPalColour:				; DATA XREF: seg000:scriptFuncListo
		call	GetVariable
		and	ax, 0Fh
		mov	bx, ax
		add	bx, ax
		add	bx, ax
		out	0A8h, al	; Interrupt Controller #2, 8259A
		call	GetVariable
		and	al, 0Fh
		mov	byte ptr cs:unk_19ED7[bx], al
		mov	byte ptr cs:unk_19F07[bx], al
		out	0ACh, al	; Interrupt Controller #2, 8259A
		call	GetVariable
		and	al, 0Fh
		mov	byte ptr cs:PalCurrent[bx], al
		mov	byte ptr cs:PalTarget[bx], al
		out	0AAh, al	; Interrupt Controller #2, 8259A
		call	GetVariable
		and	al, 0Fh
		mov	cs:byte_19ED8[bx], al
		mov	cs:byte_19F08[bx], al
		out	0AEh, al	; Interrupt Controller #2, 8259A
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sPalApply:				; DATA XREF: seg000:scriptFuncListo
		push	si
		push	ds
		push	cs
		pop	ds
		mov	si, offset PalCurrent
		push	cs
		pop	es
		assume es:seg000
		mov	di, offset PalTarget
		cld
		mov	cx, 18h
		rep movsw
		pop	ds
		pop	si
		call	WaitForVSync
		call	UploadPalette
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sPalFadeBW1:				; DATA XREF: seg000:scriptFuncListo
		call	sub_113FC
		lodsw
		push	ax
		lodsw
		mov	cx, ax
		pop	ax
		push	si
		push	di
		or	ax, ax
		jz	short loc_13154
		call	sub_11400

loc_13105:				; CODE XREF: seg000:314Dj
		mov	si, offset PalCurrent
		mov	di, offset PalTarget
		mov	bx, cs:word_19ED4
		mov	ah, 10h

loc_13112:				; CODE XREF: seg000:3142j
		ror	bx, 1
		jb	short loc_1313A
		mov	al, cs:[si]
		cmp	al, cs:[di]
		sbb	byte ptr cs:[di], 0
		mov	al, cs:[si+1]
		cmp	al, cs:[di+1]
		sbb	byte ptr cs:[di+1], 0
		mov	al, cs:[si+2]
		cmp	al, cs:[di+2]
		sbb	byte ptr cs:[di+2], 0

loc_1313A:				; CODE XREF: seg000:3114j
		inc	si
		inc	si
		inc	si
		inc	di
		inc	di
		inc	di
		dec	ah
		jnz	short loc_13112
		call	WaitFrames
		call	UploadPalette
		call	sub_131A3
		jnz	short loc_13105
		pop	di
		pop	si
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

loc_13154:				; CODE XREF: seg000:3100j seg000:319Cj
		mov	si, offset PalCurrent
		mov	di, offset PalTarget
		mov	bx, cs:word_19ED4
		mov	ah, 10h

loc_13161:				; CODE XREF: seg000:3191j
		ror	bx, 1
		jb	short loc_13189
		mov	al, cs:[si]
		cmp	cs:[di], al
		adc	byte ptr cs:[di], 0
		mov	al, cs:[si+1]
		cmp	cs:[di+1], al
		adc	byte ptr cs:[di+1], 0
		mov	al, cs:[si+2]
		cmp	cs:[di+2], al
		adc	byte ptr cs:[di+2], 0

loc_13189:				; CODE XREF: seg000:3163j
		inc	si
		inc	si
		inc	si
		inc	di
		inc	di
		inc	di
		dec	ah
		jnz	short loc_13161
		call	WaitFrames
		call	UploadPalette
		call	sub_131A3
		jnz	short loc_13154
		pop	di
		pop	si
		jmp	ScriptMainLoop

; =============== S U B	R O U T	I N E =======================================


sub_131A3	proc near		; CODE XREF: seg000:314Ap seg000:3199p
		mov	si, offset PalCurrent
		mov	di, offset PalTarget
		mov	bx, cs:word_19ED4
		mov	dx, 1000h

loc_131B1:				; CODE XREF: sub_131A3+3Cj
		ror	bx, 1
		jb	short loc_131D7
		mov	al, cs:[si]
		mov	ah, cs:[di]
		xor	al, ah
		or	dl, al
		mov	al, cs:[si+1]
		mov	ah, cs:[di+1]
		xor	al, ah
		or	dl, al
		mov	al, cs:[si+2]
		mov	ah, cs:[di+2]
		xor	al, ah
		or	dl, al

loc_131D7:				; CODE XREF: sub_131A3+10j
		inc	si
		inc	si
		inc	si
		inc	di
		inc	di
		inc	di
		dec	dh
		jnz	short loc_131B1
		or	dl, dl
		retn
sub_131A3	endp

; ---------------------------------------------------------------------------

sPalFadeBW2:				; DATA XREF: seg000:scriptFuncListo
		lodsw
		or	ax, ax
		jz	short loc_13236
		lodsw
		mov	cx, ax

loc_131EC:				; CODE XREF: seg000:3231j
		mov	ax, cs:word_19ED4
		mov	bx, offset PalTarget
		mov	dx, 100Fh

loc_131F6:				; CODE XREF: seg000:3226j
		ror	ax, 1
		jb	short loc_13221
		cmp	byte ptr cs:[bx], 0Fh
		adc	byte ptr cs:[bx], 0
		and	dl, cs:[bx]
		cmp	byte ptr cs:[bx+1], 0Fh
		adc	byte ptr cs:[bx+1], 0
		and	dl, cs:[bx+1]
		cmp	byte ptr cs:[bx+2], 0Fh
		adc	byte ptr cs:[bx+2], 0
		and	dl, cs:[bx+2]

loc_13221:				; CODE XREF: seg000:31F8j
		inc	bx
		inc	bx
		inc	bx
		dec	dh
		jnz	short loc_131F6
		call	WaitFrames
		call	UploadPalette
		cmp	dl, 0Fh
		jnz	short loc_131EC
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

loc_13236:				; CODE XREF: seg000:31E7j
		lodsw
		mov	cx, ax

loc_13239:				; CODE XREF: seg000:327Dj
		mov	ax, cs:word_19ED4
		mov	bx, offset PalTarget
		mov	dx, 1000h

loc_13243:				; CODE XREF: seg000:3273j
		ror	ax, 1
		jb	short loc_1326E
		sub	byte ptr cs:[bx], 1
		adc	byte ptr cs:[bx], 0
		or	dl, cs:[bx]
		sub	byte ptr cs:[bx+1], 1
		adc	byte ptr cs:[bx+1], 0
		or	dl, cs:[bx+1]
		sub	byte ptr cs:[bx+2], 1
		adc	byte ptr cs:[bx+2], 0
		or	dl, cs:[bx+2]

loc_1326E:				; CODE XREF: seg000:3245j
		inc	bx
		inc	bx
		inc	bx
		dec	dh
		jnz	short loc_13243
		call	WaitFrames
		call	UploadPalette
		or	dl, dl
		jnz	short loc_13239
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sPalMaskToggle:				; DATA XREF: seg000:scriptFuncListo
		lodsw
		mov	cl, al
		mov	ax, 1
		rol	ax, cl
		xor	cs:word_19ED4, ax
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sTextClear_E1:				; DATA XREF: seg000:scriptFuncListo
		mov	ax, offset byte_187E1
		mov	word ptr cs:loc_11442+1, ax
		call	loc_11423
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sTextClear_01:				; DATA XREF: seg000:scriptFuncListo
		mov	ax, offset byte_18701
		mov	word ptr cs:loc_11442+1, ax
		call	loc_11423
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sTextFill:				; DATA XREF: seg000:scriptFuncListo
		lodsw
		mov	di, ax
		lodsw
		shl	di, 2
		shl	ax, 5
		add	di, ax
		shl	ax, 2
		add	di, ax
		mov	ax, 0A000h
		mov	es, ax
		assume es:nothing
		lodsw
		mov	cx, ax
		lodsw
		mov	bx, ax
		lodsw
		mov	dx, ax
		and	al, 7
		shl	al, 5
		and	dl, 8
		shr	dl, 1
		or	dl, al
		or	dl, 1
		lodsw
		add	ah, ah
		sub	al, 1Fh
		js	short loc_132E5
		cmp	al, 61h
		adc	al, 0DEh

loc_132E5:				; CODE XREF: seg000:32DFj
		add	ax, 1FA1h
		and	ax, 7F7Fh
		xchg	ah, al
		sub	al, 20h

loc_132EF:				; CODE XREF: seg000:330Aj
		push	cx
		push	di

loc_132F1:				; CODE XREF: seg000:3301j
		and	al, 7Fh
		stosw
		or	al, 80h
		stosw
		mov	es:[di+1FFCh], dx
		mov	es:[di+1FFEh], dx
		loop	loc_132F1
		pop	di
		pop	cx
		add	di, 0A0h
		dec	bx
		jnz	short loc_132EF
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sLoadFontChr:				; DATA XREF: seg000:scriptFuncListo
		mov	al, 0Bh
		out	68h, al
		lodsw
		out	0A1h, al	; Interrupt Controller #2, 8259A
		mov	al, ah
		sub	al, 20h
		out	0A3h, al	; Interrupt Controller #2, 8259A
		lodsw
		mov	bx, ax
		mov	cx, 10h

loc_13322:				; CODE XREF: seg000:333Aj
		mov	al, 10h
		sub	al, cl
		mov	ah, al
		or	al, 20h
		out	0A5h, al	; Interrupt Controller #2, 8259A
		mov	al, [bx]
		inc	bx
		out	0A9h, al	; Interrupt Controller #2, 8259A
		mov	al, ah
		out	0A5h, al	; Interrupt Controller #2, 8259A
		mov	al, [bx]
		inc	bx
		out	0A9h, al	; Interrupt Controller #2, 8259A
		loop	loc_13322
		mov	al, 0Ah
		out	68h, al
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sSetIdleChars:				; DATA XREF: seg000:scriptFuncListo
		lodsw
		mov	cs:word_19FEC, ax
		lodsw
		mov	cs:word_19FF0, ax
		lodsw
		mov	cs:word_19FF4, ax
		lodsw
		mov	cs:word_19FF8, ax
		lodsw
		mov	cs:word_19FFC, ax
		lodsw
		mov	cs:word_1A000, ax
		lodsw
		mov	cs:word_1A004, ax
		lodsw
		mov	cs:word_1A008, ax
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sSetIdleDelay:				; DATA XREF: seg000:scriptFuncListo
		lodsw
		mov	cs:word_19FEE, ax
		lodsw
		mov	cs:word_19FF2, ax
		lodsw
		mov	cs:word_19FF6, ax
		lodsw
		mov	cs:word_19FFA, ax
		lodsw
		mov	cs:word_19FFE, ax
		lodsw
		mov	cs:word_1A002, ax
		lodsw
		mov	cs:word_1A006, ax
		lodsw
		mov	cs:word_1A00A, ax
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sSetIdlePos:				; DATA XREF: seg000:scriptFuncListo
		lodsw
		mov	cs:idleAniPosX,	ax
		lodsw
		mov	cs:idleAniPosY,	ax
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sShowText_XY:				; DATA XREF: seg000:scriptFuncListo
		mov	cs:textBoxID, 0FFh
		lodsw
		mov	cs:ptxPosX, al
		lodsw
		mov	cs:ptxPosY, al
		lodsw
		push	si
		mov	si, ax
		call	PrintText
		pop	si
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sShowText_TBox:				; DATA XREF: seg000:scriptFuncListo
		lodsw
		and	al, 0Fh
		mov	cs:textBoxID, al
		lodsw
		push	si
		mov	si, ax
		call	PrintText
		pop	si
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sPrintVar_TBox:				; DATA XREF: seg000:scriptFuncListo
		lodsw
		and	al, 0Fh
		mov	cs:textBoxID, al
		cmp	word ptr [si], 400h
		jnb	short loc_133E8
		call	GetVariable
		call	Int2Str_Short
		jmp	short loc_133EE
; ---------------------------------------------------------------------------

loc_133E8:				; CODE XREF: seg000:33DEj
		call	GetLVariable
		call	Int2Str_Long

loc_133EE:				; CODE XREF: seg000:33E6j
		push	si
		push	ds
		push	cs
		pop	ds
		mov	si, offset i2sTextBuf
		call	PrintText
		pop	ds
		pop	si
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sWaitKey:				; CODE XREF: seg000:3403j
					; DATA XREF: seg000:scriptFuncListo
		mov	al, cs:KeyPressMask
		or	al, al
		jz	short sWaitKey
		mov	ah, al

loc_13407:				; CODE XREF: seg000:340Fj
		mov	al, cs:KeyPressMask
		and	al, ah
		cmp	al, ah
		jz	short loc_13407
		call	GetVarPtr
		xchg	ah, al
		mov	cs:[bx], ax
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sDoMenuSel1:				; DATA XREF: seg000:scriptFuncListo
		call	GetVarPtr
		mov	cs:ptrMenu1Entry, bx
		call	GetVarPtr
		mov	cs:ptrUserAction, bx
		lodsw
		mov	cs:menuDataPtr,	ax
		lodsw
		mov	cs:scrMenuJumpPtr, ax
		mov	cs:KeyPressMask, 0
		mov	cs:byte_1A04B, 40h
		mov	cs:byte_1A04A, 0FFh
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sDoMenuSel2:				; DATA XREF: seg000:scriptFuncListo
		call	GetVarPtr
		mov	cs:word_1A041, bx
		call	GetVarPtr
		mov	cs:word_1A043, bx
		call	GetVarPtr
		mov	cs:ptrUserAction, bx
		lodsw
		mov	cs:scrMenuJumpPtr, ax
		mov	cs:KeyPressMask, 0
		mov	cs:byte_1A04B, 41h
		mov	cs:byte_1A04A, 0FFh
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

loc_1347D:				; DATA XREF: seg000:scriptFuncListo
		lodsw
		cmp	cs:byte_1A04B, 0
		jz	short loc_1348A
		mov	cs:byte_1A04A, al

loc_1348A:				; CODE XREF: seg000:3484j
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

loc_1348D:				; DATA XREF: seg000:scriptFuncListo
		cli
		lodsw
		mov	cs:word_1A05B, ax
		lodsw
		mov	cs:word_1A05D, ax
		lodsw
		mov	cs:word_1A05F, ax
		lodsw
		mov	cs:word_1A061, ax
		call	sub_107B9
		sti
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

loc_134A9:				; DATA XREF: seg000:scriptFuncListo
		cli
		call	GetVariable
		mov	cs:word_1A05B, ax
		call	GetVariable
		mov	cs:word_1A05D, ax
		call	GetVariable
		mov	cs:word_1A05F, ax
		call	GetVariable
		mov	cs:word_1A061, ax
		call	sub_107B9
		sti
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

loc_134CD:				; DATA XREF: seg000:scriptFuncListo
		mov	ax, cs:word_1A057
		mov	dx, cs:word_1A059
		call	GetVarPtr
		mov	cs:[bx], ax
		call	GetVarPtr
		mov	cs:[bx], dx
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sDummy:					; DATA XREF: seg000:scriptFuncListo
		jmp	ScriptMainLoop	; NOTE:	Invalid	in SYS98 v3.00
; ---------------------------------------------------------------------------

loc_134E8:				; DATA XREF: seg000:scriptFuncListo
		lodsw			; NOTE:	Removed	in SYS98 v3.00
		or	ax, ax
		jz	short loc_1350C
		cmp	cs:byte_1A04D, 0
		jz	short loc_134F8
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

loc_134F8:				; CODE XREF: seg000:34F3j
		cli
		push	si
		push	ds
		dec	cs:byte_1A04D
		call	sub_1067A
		call	sub_106C0
		pop	ds
		pop	si
		sti
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

loc_1350C:				; CODE XREF: seg000:34EBj
		cmp	cs:byte_1A04D, 0
		jnz	short loc_13517
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

loc_13517:				; CODE XREF: seg000:3512j
		cli
		push	si
		push	ds
		call	sub_10644
		inc	cs:byte_1A04D
		pop	ds
		pop	si
		sti
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

loc_13528:				; DATA XREF: seg000:scriptFuncListo
		cli
		lodsw
		mov	cs:word_1A057, ax
		lodsw
		mov	cs:word_1A059, ax
		push	si
		push	ds
		call	sub_10644
		call	sub_1067A
		call	sub_106C0
		pop	ds
		pop	si
		sti
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

loc_13544:				; DATA XREF: seg000:scriptFuncListo
		cli
		call	GetVariable
		mov	cs:word_1A057, ax
		call	GetVariable
		mov	cs:word_1A059, ax
		push	si
		push	ds
		call	sub_10644
		call	sub_1067A
		call	sub_106C0
		pop	ds
		pop	si
		sti
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

loc_13564:				; DATA XREF: seg000:scriptFuncListo
		mov	ax, cs:word_1A053 ; NOTE: Removed in SYS98 v3.00
		mov	dx, cs:word_1A055
		call	GetVarPtr
		mov	cs:[bx], ax
		call	GetVarPtr
		mov	cs:[bx], dx
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sBGMPlay:				; DATA XREF: seg000:scriptFuncListo
		lodsw
		cmp	cs:byte_1A00E, 0
		jnz	short loc_13588
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

loc_13588:				; CODE XREF: seg000:3583j
		mov	bx, ax
		mov	ah, 1
		int	60h		; call PMD driver
		push	ds
		mov	ah, 6
		int	60h		; call PMD driver
		mov	word ptr cs:FileLoadDstPtr+4, ds
		mov	word ptr cs:FileLoadDstPtr+2, dx
		mov	word ptr cs:FileLoadDstPtr, 6000h
		pop	ds
		call	LoadFile
		jnb	short loc_135AD
		jmp	loc_1092A
; ---------------------------------------------------------------------------

loc_135AD:				; CODE XREF: seg000:35A8j
		xor	ah, ah
		int	60h		; call PMD driver
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sBGMFadeOut:				; DATA XREF: seg000:scriptFuncListo
		cmp	cs:byte_1A00E, 0
		jnz	short loc_135BF
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

loc_135BF:				; CODE XREF: seg000:35BAj
		mov	ax, 205h
		int	60h		; call PMD driver
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sBGMStop:				; DATA XREF: seg000:scriptFuncListo
		cmp	cs:byte_1A00E, 0
		jnz	short loc_135D2
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

loc_135D2:				; CODE XREF: seg000:35CDj
		mov	ah, 1
		int	60h		;  - FTP Packet	Driver - BASIC FUNC -
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sGetMusMode:				; DATA XREF: seg000:scriptFuncListo
		call	GetVarPtr
		mov	al, cs:byte_1A00E
		cbw
		mov	cs:[bx], ax
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sBGMGetMeas:				; DATA XREF: seg000:scriptFuncListo
		call	GetVarPtr
		cmp	cs:byte_1A00E, 0
		jnz	short loc_135F5
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

loc_135F5:				; CODE XREF: seg000:35F0j
		mov	ah, 5
		int	60h		; call PMD driver
		cbw
		mov	cs:[bx], ax
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sBGMGetState:				; DATA XREF: seg000:scriptFuncListo
		call	GetVarPtr
		cmp	cs:byte_1A00E, 0
		jnz	short loc_1360E
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

loc_1360E:				; CODE XREF: seg000:3609j
		mov	ah, 0Ah
		int	60h		; call PMD driver
		mov	cs:[bx], ax
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sSFXPlaySSG:				; DATA XREF: seg000:scriptFuncListo
		lodsw
		cmp	cs:byte_1A00E, 0
		jnz	short loc_13624
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

loc_13624:				; CODE XREF: seg000:361Fj
		mov	dx, 24E7h
		mov	cx, 3FFh
		mov	ah, 0Fh
		int	60h		; call PMD driver
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sSFXPlayFM:				; DATA XREF: seg000:scriptFuncListo
		lodsw
		cmp	cs:byte_1A00E, 0
		jnz	short loc_1363D
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

loc_1363D:				; CODE XREF: seg000:3638j
		mov	ah, 0Ch
		int	60h		; call PMD driver
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sStrCompare:				; DATA XREF: seg000:scriptFuncListo
		call	GetStringPtr
		mov	di, bx
		call	GetStringPtr
		mov	cs:scrCmpResult, 3

loc_13652:				; CODE XREF: seg000:365Ej
		mov	al, cs:[bx]
		cmp	cs:[di], al
		jnz	short loc_13664
		inc	bx
		inc	di
		or	al, al
		jnz	short loc_13652
		mov	cs:scrCmpResult, al

loc_13664:				; CODE XREF: seg000:3658j
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sStrNCpy:				; DATA XREF: seg000:scriptFuncListo
		call	GetStringPtr
		mov	di, bx
		call	GetStringPtr
		lodsw
		mov	cx, ax

loc_13672:				; CODE XREF: seg000:367Aj
		mov	al, cs:[bx]
		mov	cs:[di], al
		inc	bx
		inc	di
		loop	loc_13672
		mov	byte ptr cs:[di], 0
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sStrCat_Var:				; DATA XREF: seg000:scriptFuncListo
		call	GetStringPtr

loc_13686:				; CODE XREF: seg000:368Dj
		cmp	byte ptr cs:[bx], 0
		jz	short loc_1368F
		inc	bx
		jmp	short loc_13686
; ---------------------------------------------------------------------------

loc_1368F:				; CODE XREF: seg000:368Aj
		mov	di, bx
		call	GetStringPtr

loc_13694:				; CODE XREF: seg000:369Ej
		mov	al, cs:[bx]
		mov	cs:[di], al
		inc	bx
		inc	di
		or	al, al
		jnz	short loc_13694
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sStrChrCat:				; DATA XREF: seg000:scriptFuncListo
		call	GetStringPtr

loc_136A6:				; CODE XREF: seg000:36ADj
		cmp	byte ptr cs:[bx], 0
		jz	short loc_136AF
		inc	bx
		jmp	short loc_136A6
; ---------------------------------------------------------------------------

loc_136AF:				; CODE XREF: seg000:36AAj
		mov	di, bx
		call	GetStringPtr
		lodsw
		add	bx, ax
		mov	al, cs:[bx]
		mov	cs:[di], al
		mov	byte ptr cs:[di+1], 0
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sStrCat_Val:				; DATA XREF: seg000:scriptFuncListo
		call	GetStringPtr

loc_136C8:				; CODE XREF: seg000:36CFj
		cmp	byte ptr cs:[bx], 0
		jz	short loc_136D1
		inc	bx
		jmp	short loc_136C8
; ---------------------------------------------------------------------------

loc_136D1:				; CODE XREF: seg000:36CCj
		lodsw
		mov	di, ax

loc_136D4:				; CODE XREF: seg000:36DDj
		mov	al, [di]
		mov	cs:[bx], al
		inc	di
		inc	bx
		or	al, al
		jnz	short loc_136D4
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sStrClear:				; DATA XREF: seg000:scriptFuncListo
		call	GetStringPtr
		push	cs
		pop	es
		assume es:seg000
		mov	di, bx
		xor	ax, ax
		mov	cx, 28h
		rep stosw
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sStrCopy:				; DATA XREF: seg000:scriptFuncListo
		call	GetStringPtr
		mov	di, bx
		call	GetStringPtr

loc_136FB:				; CODE XREF: seg000:3705j
		mov	al, cs:[bx]
		mov	cs:[di], al
		inc	bx
		inc	di
		or	al, al
		jnz	short loc_136FB
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sStrLen:				; DATA XREF: seg000:scriptFuncListo
		call	GetVarPtr
		push	bx
		call	GetStringPtr
		xor	ax, ax

loc_13713:				; CODE XREF: seg000:371Bj
		cmp	cs:[bx], ah
		jz	short loc_1371D
		inc	bx
		inc	al
		jmp	short loc_13713
; ---------------------------------------------------------------------------

loc_1371D:				; CODE XREF: seg000:3716j
		pop	bx
		cbw
		mov	cs:[bx], ax
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sStrsFromFile:				; DATA XREF: seg000:scriptFuncListo
		lodsw
		mov	bx, offset ScrStringBuf
		shl	ax, 4
		add	bx, ax
		shl	ax, 2
		add	bx, ax
		push	bx
		mov	ax, cs:word_19FD2
		mov	word ptr cs:FileLoadDstPtr+4, ax
		mov	word ptr cs:FileLoadDstPtr+2, 0
		mov	word ptr cs:FileLoadDstPtr, 0FFFFh
		lodsw
		mov	bx, ax
		call	LoadFile
		pop	bx
		jnb	short loc_13756
		jmp	loc_1092A
; ---------------------------------------------------------------------------

loc_13756:				; CODE XREF: seg000:3751j
		mov	es, cs:word_19FD2
		assume es:nothing
		xor	di, di
		push	bx
		call	sub_1376B
		pop	bx
		add	bx, 50h
		call	sub_1376B
		jmp	ScriptMainLoop

; =============== S U B	R O U T	I N E =======================================


sub_1376B	proc near		; CODE XREF: seg000:375Ep seg000:3765p ...
		mov	ax, es:[di]
		inc	di
		cmp	ax, 0A0Dh
		jz	short loc_1377A
		mov	cs:[bx], al
		inc	bx
		jmp	short sub_1376B
; ---------------------------------------------------------------------------

loc_1377A:				; CODE XREF: sub_1376B+7j
		inc	di
		mov	byte ptr cs:[bx], 0
		retn
sub_1376B	endp

; ---------------------------------------------------------------------------

sStrsToFile:				; DATA XREF: seg000:scriptFuncListo
		mov	es, cs:word_19FD2
		xor	di, di
		mov	word ptr cs:FileLoadDstPtr+4, es
		mov	word ptr cs:FileLoadDstPtr+2, di
		lodsw
		mov	bx, offset ScrStringBuf
		shl	ax, 4
		add	bx, ax
		shl	ax, 2
		add	bx, ax
		push	bx
		call	sub_137C2
		pop	bx
		add	bx, 50h
		call	sub_137C2
		mov	byte ptr es:[di], 1Ah
		inc	di
		mov	word ptr cs:FileLoadDstPtr, di
		lodsw
		mov	bx, ax
		call	WriteFile
		jnb	short loc_137BF
		jmp	loc_1092A
; ---------------------------------------------------------------------------

loc_137BF:				; CODE XREF: seg000:37BAj
		jmp	ScriptMainLoop

; =============== S U B	R O U T	I N E =======================================


sub_137C2	proc near		; CODE XREF: seg000:37A0p seg000:37A7p ...
		mov	al, cs:[bx]
		inc	bx
		or	al, al
		jz	short loc_137CD
		stosb
		jmp	short sub_137C2
; ---------------------------------------------------------------------------

loc_137CD:				; CODE XREF: sub_137C2+6j
		mov	ax, 0A0Dh
		stosw
		retn
sub_137C2	endp

; ---------------------------------------------------------------------------

loc_137D2:				; DATA XREF: seg000:scriptFuncListo
		push	si
		push	ds
		mov	es, cs:word_19FD2
		xor	di, di
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	ax, 0A800h
		call	sub_13808
		mov	ax, 0B000h
		call	sub_13808
		mov	ax, 0B800h
		call	sub_13808
		mov	ax, 0E000h
		call	sub_13808
		mov	al, 1
		mov	cs:portA4State,	al
		out	0A4h, al	; Interrupt Controller #2, 8259A
		dec	al
		out	0A6h, al	; Interrupt Controller #2, 8259A
		pop	ds
		pop	si
		jmp	ScriptMainLoop

; =============== S U B	R O U T	I N E =======================================


sub_13808	proc near		; CODE XREF: seg000:37E2p seg000:37E8p ...
		mov	ds, ax
		xor	si, si
		mov	cx, 4000h
		rep movsb
		xor	si, si
		mov	cx, 4000h

loc_13816:				; CODE XREF: sub_13808+1Dj
		xor	al, al
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	dx, [si]
		inc	al
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	[si], dx
		add	si, 2
		loop	loc_13816
		retn
sub_13808	endp

; ---------------------------------------------------------------------------

loc_13828:				; DATA XREF: seg000:scriptFuncListo
		call	GetVariable
		cmp	ax, 1E1h
		jb	short loc_13833
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

loc_13833:				; CODE XREF: seg000:382Ej
		push	si
		push	ds
		mov	bx, ax
		mov	al, cs:portA4State
		out	0A4h, al	; Interrupt Controller #2, 8259A
		xor	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	word ptr cs:0A54Ah, 0A800h
		mov	ax, cs:word_19FD4
		mov	cs:0A54Ch, ax
		mov	ax, cs:word_19FD2
		mov	cs:0A54Eh, ax
		call	sub_138CE
		mov	word ptr cs:0A54Ah, 0B000h
		mov	ax, cs:word_19FD4
		add	ax, 800h
		mov	cs:0A54Ch, ax
		mov	ax, cs:word_19FD2
		add	ax, 400h
		mov	cs:0A54Eh, ax
		call	sub_138CE
		mov	word ptr cs:0A54Ah, 0B800h
		mov	ax, cs:word_19FD6
		mov	cs:0A54Ch, ax
		mov	ax, cs:word_19FD2
		add	ax, 800h
		mov	cs:0A54Eh, ax
		call	sub_138CE
		mov	word ptr cs:0A54Ah, 0E000h
		mov	ax, cs:word_19FD6
		add	ax, 800h
		mov	cs:0A54Ch, ax
		mov	ax, cs:word_19FD2
		add	ax, 0C00h
		mov	cs:0A54Eh, ax
		call	sub_138CE
		call	WaitForVSync
		mov	al, cs:portA4State
		out	0A6h, al	; Interrupt Controller #2, 8259A
		xor	al, 1
		out	0A4h, al	; Interrupt Controller #2, 8259A
		mov	cs:portA4State,	al
		pop	ds
		pop	si
		jmp	ScriptMainLoop

; =============== S U B	R O U T	I N E =======================================


sub_138CE	proc near		; CODE XREF: seg000:3858p seg000:3878p ...
		push	bx
		les	di, dword ptr cs:word_1A548
		mov	cx, 120h

loc_138D7:				; CODE XREF: sub_138CE+3Fj
		push	cx
		mov	ds, word ptr cs:0A54Ch
		mov	ax, bx
		shl	ax, 2
		mov	si, bx
		shl	si, 6
		sub	si, ax
		cmp	bx, 215h
		jb	short loc_13903
		mov	ds, word ptr cs:0A54Eh
		mov	ax, bx
		sub	ax, 215h
		mov	si, ax
		shl	ax, 2
		shl	si, 6
		sub	si, ax

loc_13903:				; CODE XREF: sub_138CE+1Fj
		mov	cx, 1Eh
		rep movsw
		add	di, 14h
		inc	bx
		pop	cx
		loop	loc_138D7
		pop	bx
		retn
sub_138CE	endp

; ---------------------------------------------------------------------------

loc_13911:				; DATA XREF: seg000:scriptFuncListo
		pusha
		push	ds
		push	es
		cli
		in	al, 0Ah		; DMA controller, 8237A-5.
					; single mask bit register
					; 0-1: select channel (00=0; 01=1; 10=2; 11=3)
					; 2: 1=set mask	for channel; 0=clear mask (enable)
		or	al, 20h
		out	0Ah, al		; DMA controller, 8237A-5.
					; single mask bit register
					; 0-1: select channel (00=0; 01=1; 10=2; 11=3)
					; 2: 1=set mask	for channel; 0=clear mask (enable)
		sti
		call	sub_13930
		call	sub_139E9
		cli
		in	al, 0Ah		; DMA controller, 8237A-5.
					; single mask bit register
					; 0-1: select channel (00=0; 01=1; 10=2; 11=3)
					; 2: 1=set mask	for channel; 0=clear mask (enable)
		and	al, 0DFh
		out	0Ah, al		; DMA controller, 8237A-5.
					; single mask bit register
					; 0-1: select channel (00=0; 01=1; 10=2; 11=3)
					; 2: 1=set mask	for channel; 0=clear mask (enable)
		sti
		pop	es
		pop	ds
		popa
		jmp	ScriptMainLoop

; =============== S U B	R O U T	I N E =======================================


sub_13930	proc near		; CODE XREF: seg000:391Cp
		mov	es, cs:word_19FD2
		mov	di, 8000h
		mov	ax, 0A800h
		call	sub_1395A
		mov	di, 801Ch
		mov	ax, 0B000h
		call	sub_1395A
		mov	di, 8038h
		mov	ax, 0B800h
		call	sub_1395A
		mov	di, 8054h
		mov	ax, 0E000h
		call	sub_1395A
		retn
sub_13930	endp


; =============== S U B	R O U T	I N E =======================================


sub_1395A	proc near		; CODE XREF: sub_13930+Bp
					; sub_13930+14p ...
		mov	ds, ax
		push	di
		mov	si, 2340h
		mov	di, 0Eh
		mov	bx, 0C0h
		mov	cx, 5
		call	sub_139D7
		mov	si, 2340h
		mov	di, 120Eh
		mov	bx, 64h
		mov	cx, 5
		call	sub_139D7
		mov	si, 542h
		mov	di, 4
		mov	bx, 124h
		mov	cx, 5
		call	sub_139D7
		mov	si, 540h
		mov	di, 2
		mov	bx, 124h
		mov	cx, 1
		call	sub_139D7
		mov	si, 234Ah
		xor	di, di
		mov	bx, 0C0h
		mov	cx, 1
		call	sub_139D7
		mov	si, 234Ah
		mov	di, 1200h
		mov	bx, 64h
		mov	cx, 1
		call	sub_139D7
		pop	di
		mov	ds, cs:word_19FD2
		xor	si, si
		mov	bx, 124h

loc_139C1:				; CODE XREF: sub_1395A+7Aj
		lodsw
		stosw
		mov	dx, ax
		lodsw
		stosw
		mov	cx, 0Ah
		rep movsw
		xchg	ax, dx
		stosw
		xchg	ax, dx
		stosw
		add	di, 54h
		dec	bx
		jnz	short loc_139C1
		retn
sub_1395A	endp


; =============== S U B	R O U T	I N E =======================================


sub_139D7	proc near		; CODE XREF: sub_1395A+Fp
					; sub_1395A+1Ep ...
		push	si
		push	di
		push	cx
		rep movsw
		pop	cx
		pop	di
		pop	si
		add	si, 50h
		add	di, 18h
		dec	bx
		jnz	short sub_139D7
		retn
sub_139D7	endp


; =============== S U B	R O U T	I N E =======================================


sub_139E9	proc near		; CODE XREF: seg000:391Fp
		mov	ds, cs:word_19FD2
		mov	di, 53Ah
		mov	bx, 0A01Bh
		mov	cx, 0Fh

loc_139F7:				; CODE XREF: sub_139E9+45j
		push	cx
		push	di
		call	WaitForVSync
		mov	si, cs:[bx]
		mov	cx, 124h

loc_13A02:				; CODE XREF: sub_139E9+34j
		mov	ax, 0A800h
		call	sub_13A31
		mov	ax, 0B000h
		call	sub_13A31
		mov	ax, 0B800h
		call	sub_13A31
		mov	ax, 0E000h
		call	sub_13A31
		add	di, 50h
		loop	loc_13A02
		pop	di
		pop	cx
		cmp	cx, 1
		jz	short loc_13A29
		call	sub_13A3D

loc_13A29:				; CODE XREF: sub_139E9+3Bj
		sub	di, 4
		inc	bx
		inc	bx
		loop	loc_139F7
		retn
sub_139E9	endp


; =============== S U B	R O U T	I N E =======================================


sub_13A31	proc near		; CODE XREF: sub_139E9+1Cp
					; sub_139E9+22p ...
		mov	es, ax
		push	di
		movsw
		movsw
		movsw
		movsw
		pop	di
		add	si, 14h
		retn
sub_13A31	endp


; =============== S U B	R O U T	I N E =======================================


sub_13A3D	proc near		; CODE XREF: sub_139E9+3Dp
		push	cx
		push	di
		add	di, 140h
		mov	al, 0C0h
		out	7Ch, al
		mov	al, 0F0h
		out	7Eh, al
		xor	al, al
		out	7Eh, al
		out	7Eh, al
		out	7Eh, al
		mov	cx, 90h

loc_13A56:				; CODE XREF: sub_13A3D+27j
		mov	byte ptr es:[di], 0A0h
		add	di, 50h
		mov	byte ptr es:[di], 50h
		add	di, 50h
		loop	loc_13A56
		out	7Ch, al
		pop	di
		pop	cx
		retn
sub_13A3D	endp

; ---------------------------------------------------------------------------

loc_13A6B:				; DATA XREF: seg000:scriptFuncListo
		pusha
		push	ds
		push	es
		cli
		in	al, 0Ah		; DMA controller, 8237A-5.
					; single mask bit register
					; 0-1: select channel (00=0; 01=1; 10=2; 11=3)
					; 2: 1=set mask	for channel; 0=clear mask (enable)
		or	al, 20h
		out	0Ah, al		; DMA controller, 8237A-5.
					; single mask bit register
					; 0-1: select channel (00=0; 01=1; 10=2; 11=3)
					; 2: 1=set mask	for channel; 0=clear mask (enable)
		sti
		call	sub_13A87
		cli
		in	al, 0Ah		; DMA controller, 8237A-5.
					; single mask bit register
					; 0-1: select channel (00=0; 01=1; 10=2; 11=3)
					; 2: 1=set mask	for channel; 0=clear mask (enable)
		and	al, 0DFh
		out	0Ah, al		; DMA controller, 8237A-5.
					; single mask bit register
					; 0-1: select channel (00=0; 01=1; 10=2; 11=3)
					; 2: 1=set mask	for channel; 0=clear mask (enable)
		sti
		pop	es
		pop	ds
		popa
		jmp	ScriptMainLoop

; =============== S U B	R O U T	I N E =======================================


sub_13A87	proc near		; CODE XREF: seg000:3A76p
		mov	si, 38h
		mov	di, 53Ah
		call	sub_13A9C
		call	sub_13AFA
		mov	cx, 0Eh

loc_13A96:				; CODE XREF: sub_13A87+12j
		call	sub_13A9C
		loop	loc_13A96
		retn
sub_13A87	endp


; =============== S U B	R O U T	I N E =======================================


sub_13A9C	proc near		; CODE XREF: sub_13A87+6p
					; sub_13A87:loc_13A96p
		push	cx
		call	WaitForVSync
		mov	ax, 0A800h
		call	sub_13AC3
		mov	ax, 0B000h
		call	sub_13AC3
		mov	ax, 0B800h
		call	sub_13AC3
		mov	ax, 0E000h
		call	sub_13AC3
		call	sub_13B27
		sub	di, 4
		sub	si, 4
		pop	cx
		retn
sub_13A9C	endp


; =============== S U B	R O U T	I N E =======================================


sub_13AC3	proc near		; CODE XREF: sub_13A9C+7p sub_13A9C+Dp ...
		mov	ds, ax
		push	si
		push	di
		mov	es, cs:word_19FD2
		xor	di, di
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	cx, 120h

loc_13AD5:				; CODE XREF: sub_13AC3+17j
		movsw
		movsw
		add	si, 4Ch
		loop	loc_13AD5
		xor	al, al
		out	0A6h, al	; Interrupt Controller #2, 8259A
		mov	ax, ds
		mov	es, ax
		assume es:seg000
		pop	di
		push	di
		mov	ds, cs:word_19FD2
		xor	si, si
		mov	cx, 120h

loc_13AF0:				; CODE XREF: sub_13AC3+32j
		movsw
		movsw
		add	di, 4Ch
		loop	loc_13AF0
		pop	di
		pop	si
		retn
sub_13AC3	endp


; =============== S U B	R O U T	I N E =======================================


sub_13AFA	proc near		; CODE XREF: sub_13A87+9p
		push	cx
		push	di
		mov	di, 67Eh
		mov	al, 0C0h
		out	7Ch, al
		mov	al, 0F0h
		out	7Eh, al
		xor	al, al
		out	7Eh, al
		out	7Eh, al
		out	7Eh, al
		mov	cx, 90h

loc_13B12:				; CODE XREF: sub_13AFA+26j
		mov	byte ptr es:[di], 50h
		add	di, 50h
		mov	byte ptr es:[di], 0A0h
		add	di, 50h
		loop	loc_13B12
		out	7Ch, al
		pop	di
		pop	cx
		retn
sub_13AFA	endp


; =============== S U B	R O U T	I N E =======================================


sub_13B27	proc near		; CODE XREF: sub_13A9C+1Cp
		push	cx
		push	di
		add	di, 5A00h
		mov	al, 0C0h
		out	7Ch, al
		mov	al, 0FFh
		out	7Eh, al
		inc	al
		out	7Eh, al
		out	7Eh, al
		out	7Eh, al
		mov	byte ptr es:[di], 5
		mov	byte ptr es:[di+1], 55h
		mov	byte ptr es:[di+2], 55h
		mov	byte ptr es:[di+3], 55h
		mov	byte ptr es:[di+4], 50h
		mov	byte ptr es:[di+50h], 0Ah
		mov	byte ptr es:[di+51h], 0AAh
		mov	byte ptr es:[di+52h], 0AAh
		mov	byte ptr es:[di+53h], 0AAh
		mov	byte ptr es:[di+54h], 0A0h
		mov	byte ptr es:[di+0A0h], 5
		mov	byte ptr es:[di+0A1h], 55h
		mov	byte ptr es:[di+0A2h], 55h
		mov	byte ptr es:[di+0A3h], 55h
		mov	byte ptr es:[di+0A4h], 50h
		mov	byte ptr es:[di+0F0h], 0Ah
		mov	byte ptr es:[di+0F1h], 0AAh
		mov	byte ptr es:[di+0F2h], 0AAh
		mov	byte ptr es:[di+0F3h], 0AAh
		mov	byte ptr es:[di+0F4h], 0A0h
		out	7Ch, al
		pop	di
		pop	cx
		retn
sub_13B27	endp

; ---------------------------------------------------------------------------

sPortraitDataAll:			; DATA XREF: seg000:scriptFuncListo
		lodsw
		push	si
		mov	si, ax
		push	cs
		pop	es
		mov	di, offset PortraitInfo
		mov	cx, 30h

loc_13BBB:				; CODE XREF: seg000:3C02j
		lodsw
		and	al, 3
		stosb
		lodsw
		mov	dx, ax
		lodsw
		shl	ax, 4
		add	dx, ax
		shl	ax, 2
		add	ax, dx
		stosw
		lodsw
		and	al, 0Fh
		mov	es:[di], al
		lodsw
		and	al, 0Fh
		shl	al, 4
		or	es:[di], al
		lodsw
		and	al, 0Fh
		shl	al, 4
		mov	es:[di+1], al
		lodsw
		and	al, 0Fh
		shl	al, 4
		mov	es:[di+2], al
		lodsw
		and	al, 0Fh
		or	es:[di+1], al
		lodsw
		and	al, 0Fh
		or	es:[di+2], al
		add	di, 3
		loop	loc_13BBB
		pop	si
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

sPortraitDataOne:			; DATA XREF: seg000:scriptFuncListo
		lodsw
		mov	bx, offset PortraitInfo
		add	bx, ax
		add	bx, ax
		add	bx, ax
		add	bx, ax
		add	bx, ax
		add	bx, ax
		lodsw
		and	al, 3
		mov	cs:[bx], al
		lodsw
		mov	dx, ax
		lodsw
		shl	ax, 4
		add	dx, ax
		shl	ax, 2
		add	ax, dx
		mov	cs:[bx+1], ax
		lodsw
		and	al, 0Fh
		mov	cs:[bx+3], al
		lodsw
		and	al, 0Fh
		shl	al, 4
		or	cs:[bx+3], al
		lodsw
		and	al, 0Fh
		shl	al, 4
		mov	cs:[bx+4], al
		lodsw
		and	al, 0Fh
		shl	al, 4
		mov	cs:[bx+5], al
		lodsw
		and	al, 0Fh
		or	cs:[bx+4], al
		lodsw
		and	al, 0Fh
		or	cs:[bx+5], al
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------

loc_13C66:				; DATA XREF: seg000:scriptFuncListo
		lodsw
		and	al, 3
		mov	cs:byte_1A545, al
		lodsw
		mov	dx, ax
		lodsw
		shl	ax, 4
		add	dx, ax
		shl	ax, 2
		add	ax, dx
		mov	cs:word_1A546, ax
		jmp	ScriptMainLoop
; ---------------------------------------------------------------------------
aSystem98Ver	db 'SYSTEM-98 TYPE-C++ Assembler Version 1.0',0Dh,0Ah
					; DATA XREF: ParseArguments:loc_101CFo
		db 'äJî≠é“ ç≤ì°âÎàÍ Å`ÉtÉHÉAÅôÉiÉCÉìÅ` 1993.',0Dh,0Ah ; SYSTEM-98 TYPE-C++ Assembler Version 1.0
		db 'ìÆçÏÇ…ÇÕÇRÇWÇSÇjÇaÇÃãÛÇ´ÉÅÉÇÉäÇ™ïKóvÇ≈Ç∑',0Dh,0Ah,'$' ; Developer Masaichi Sato ~Four<^>Nine~ 1993.
					; 384KB	of free	memory is required for operation.
aNotEnoughMem	db 'åªç›ÇÃÉÅÉÇÉäèÛãµÇ≈ÇÕÉVÉXÉeÉÄÇé¿çsÇ≈Ç´Ç‹ÇπÇÒ',0Dh,0Ah
					; DATA XREF: PreallocMemory+4Fo
		db 'ÉÅÉÇÉäÉ`ÉFÅ[ÉìÇ™îjâÛÇ≥ÇÍÇƒÇ¢ÇÈã∞ÇÍÇ™Ç†ÇËÇ‹Ç∑',0Dh,0Ah ; The system cannot run with the current memory situation
		db 'îNÇÃà◊Ç…ÅAÉäÉZÉbÉgÇµÇΩÇŸÇ§Ç™ÇÊÇ¢Ç∆évÇÌÇÍÇ‹Ç∑',0Dh,0Ah,'$' ; Memory chain may be corrupted
					; It would be better to	reset the system for the next year
aFileLoadErr	db 'ÉtÉ@ÉCÉãÇÃì«Ç›çûÇ›Ç…é∏îsÇµÇ‹ÇµÇΩ',0Dh,0Ah ; DATA XREF: ReadSceneFile+32o
					; LoadFileo
		db 'ÉfÉBÉXÉNïsó«Ç≈Ç†ÇÈã∞ÇÍÇ™Ç†ÇËÇ‹Ç∑',0Dh,0Ah,'$' ; Failed to read file
					; The disk may be defective.
aFileWriteErr	db 'ÉtÉ@ÉCÉãÇÃèëÇ´çûÇ›Ç…é∏îsÇµÇ‹ÇµÇΩ',0Dh,0Ah ; DATA XREF: WriteFileo
		db 'ÇeÇcÇÕèëÇ´çûÇ›ãñâ¬Ç…ÇµÇƒÇ≠ÇæÇ≥Ç¢',0Dh,0Ah,'$' ; Failed to write file
					; Please enable	writing	on the FD
aExecUndefined	db 'ñ¢íËã`ÇÃÉVÉXÉeÉÄó\ñÒñΩóﬂÇé¿çsÇµÇ‹ÇµÇΩ',0Dh,0Ah,'$'
					; DATA XREF: seg000:257Eo
					; Undefined system reserved instruction	executed
		db 4400h dup(0)
ScrStringBuf	db 4C2h	dup(0)		; DATA XREF: GetStringPtr+2o
					; PrintText+1C7o ...
byte_18701	db 0E0h	dup(0)		; DATA XREF: seg000:sTextClear_01o
byte_187E1	db 9FEh	dup(0)		; DATA XREF: seg000:sTextClear_E1o
ScrBufferXY	db 320h	dup(0)		; DATA XREF: seg000:27BDo seg000:27E3o ...
ScrVariables1	dw 400h	dup(0)		; DATA XREF: GetVarPtr+2o
					; PrintText+1E2o ...
ScrVariablesL	dd 0Ah dup(0)		; DATA XREF: GetLVarPtr+2o
					; PrintText:loc_1165Co
textBoxMem	db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0
					; DATA XREF: GetTextBoxPtr+7o
					; PrintChar:loc_114D8o	...
		db 1, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0
		db 2, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0
		db 3, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0
		db 4, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0
		db 5, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0
		db 6, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0
		db 7, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0
		db 8, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0
		db 9, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0
		db 0Ah,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0
		db 0Bh,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0
		db 0Ch,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0
		db 0Dh,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0
		db 0Eh,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0
		db 0Fh,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0
byte_19E47	db 0			; DATA XREF: ParseArguments+49w
scenePathPtr	dw 0			; DATA XREF: ParseArguments+7o
					; ReadSceneFile+2r
word_19E4A	dw 0			; DATA XREF: SetupInt0A_24+12r
		db 88h dup(0)
word_19ED4	dw 0			; DATA XREF: SetupInt0A_24+Aw
					; sub_11400+5r	...
PalCurrent	db    0			; DATA XREF: DoPalThing+Do
					; seg000:30DAo	...
unk_19ED7	db    0
byte_19ED8	db 2Eh dup(0)
PalTarget	db    0			; DATA XREF: UploadPalette+2o
					; seg000:30DFo	...
unk_19F07	db    0
byte_19F08	db 2Eh dup(0)
scrStackPtr	dw offset byte_19F38	; DATA XREF: seg000:2B85r seg000:2B8Fw ...
byte_19F38	db 10h dup(0)		; DATA XREF: seg000:scrStackPtro
i2sTextBuf	db 10h dup(0)		; DATA XREF: Int2Str_Short+1w
					; Int2Str_Long+1w ...
unk_19F58	db    0			; DATA XREF: sub_10EFF+1w sub_10F19+3w ...
word_19F59	dw 0			; DATA XREF: sub_10EFF+6w sub_10F19+Aw ...
word_19F5B	dw 0			; DATA XREF: sub_10EFF+Bw
					; sub_10F19+11w ...
word_19F5D	dw 0			; DATA XREF: sub_10F89+15w
					; sub_11001+3r	...
word_19F5F	dw 0			; DATA XREF: sub_10EFF+10w
					; sub_10F19+18w ...
word_19F61	dw 0			; DATA XREF: sub_10EFF+15w
					; sub_10F19+1Fw ...
byte_19F63	db 0			; DATA XREF: sub_11001+36r
					; sub_11001:loc_11077r	...
byte_19F64	db 0			; DATA XREF: sub_10F3D+1w sub_10F4D+3w ...
word_19F65	dw 0			; DATA XREF: sub_10F3D+6w sub_10F4D+Aw ...
word_19F67	dw 0			; DATA XREF: sub_10F3D+Bw
					; sub_10F4D+11w ...
word_19F69	dw 0			; DATA XREF: sub_10F89+2Cw
					; sub_11001+45r ...
byte_19F6B	db 0			; DATA XREF: sub_10F63+1w sub_10F73+3w ...
word_19F6C	dw 0			; DATA XREF: sub_10F63+6w sub_10F73+Aw ...
word_19F6E	dw 0			; DATA XREF: sub_10F63+Bw
					; sub_10F73+11w ...
word_19F70	dw 0			; DATA XREF: sub_10F89+43w
					; sub_11001+B7r ...
byte_19F72	db 0			; DATA XREF: sub_11D10r seg000:2D59w ...
byte_19F73	db 0			; DATA XREF: sub_11D10+8r
					; sub_11D10:loc_11D23r	...
DiskLetter	db 0			; DATA XREF: SetupInt0A_24+6Ew
					; LoadFile+Ar ...
byte_19F75	db 0			; DATA XREF: SetupInt0A_24+7Bw
					; LoadFile+14r	...
FileLoadDstPtr	db 6 dup(0)		; DATA XREF: LoadFile+7Ar
					; WriteFile+3Fr ...
FileDiskDrive	dw 0			; DATA XREF: LoadFile+10w LoadFile+23w ...
byte_19F7E	db 4Eh dup(0)		; DATA XREF: strdup_fn+2o
SceneDataSeg	dw 0			; DATA XREF: start+12r
					; PreallocMemory+14w ...
word_19FCE	dw 0			; DATA XREF: PreallocMemory+21w
					; RestoreInts+1Br ...
word_19FD0	dw 0			; DATA XREF: SetupInt0A_24+Ew
					; sub_10B8C+Br	...
word_19FD2	dw 0			; DATA XREF: PreallocMemory+2Ew
					; SetupInt0A_24+58r ...
word_19FD4	dw 0			; DATA XREF: PreallocMemory+3Bw
					; RestoreInts+9r ...
word_19FD6	dw 0			; DATA XREF: PreallocMemory+48w
					; RestoreIntsr	...
word_19FD8	dw 0			; DATA XREF: seg000:192Dw
					; seg000:loc_11943r
word_19FDA	dw 0			; DATA XREF: seg000:1928w seg000:193Dr ...
printChrDelay	dw 0			; DATA XREF: DoPrintChrDelayr
					; seg000:25FCw
ptxPosX		db 0			; DATA XREF: PrintChar+8r
					; PrintChar+15w ...
ptxPosY		db 0			; DATA XREF: PrintChar+Dr
					; PrintText+3FFw ...
byte_19FE0	db 0E1h			; DATA XREF: PutChar2TRAM+2Fr
					; PutChar2TRAM+56r ...
textBoxID	db 0			; DATA XREF: PrintCharr PrintChar+20r	...
idleAniActive	db 0			; DATA XREF: seg000:0A21r
					; WaitForUser:loc_115EAw ...
byte_19FE3	db 0			; DATA XREF: seg000:0A35r seg000:0A53w ...
word_19FE4	dw 4			; DATA XREF: seg000:0A4Cw seg000:0A79w
idleAniPosX	dw 0			; DATA XREF: WaitForUser+2Ar
					; seg000:339Aw
idleAniPosY	dw 0			; DATA XREF: WaitForUser+39r
					; seg000:339Fw
idleAniChar	dw 0			; DATA XREF: seg000:0A2Er WaitForUserw ...
word_19FEC	dw 7721h		; DATA XREF: seg000:0A3Do seg000:0A72o ...
word_19FEE	dw 4			; DATA XREF: seg000:336Fw
word_19FF0	dw 7722h		; DATA XREF: seg000:3349w
word_19FF2	dw 4			; DATA XREF: seg000:3374w
word_19FF4	dw 7723h		; DATA XREF: seg000:334Ew
word_19FF6	dw 4			; DATA XREF: seg000:3379w
word_19FF8	dw 7724h		; DATA XREF: seg000:3353w
word_19FFA	dw 4			; DATA XREF: seg000:337Ew
word_19FFC	dw 7725h		; DATA XREF: seg000:3358w
word_19FFE	dw 4			; DATA XREF: seg000:3383w
word_1A000	dw 7726h		; DATA XREF: seg000:335Dw
word_1A002	dw 4			; DATA XREF: seg000:3388w
word_1A004	dw 7727h		; DATA XREF: seg000:3362w
word_1A006	dw 4			; DATA XREF: seg000:338Dw
word_1A008	dw 7728h		; DATA XREF: seg000:3367w
word_1A00A	dw 4			; DATA XREF: seg000:3392w
word_1A00C	dw 0			; DATA XREF: seg000:2782r seg000:278Aw
byte_1A00E	db 0			; DATA XREF: SetupInt0A_24+1Cw
					; seg000:357Dr	...
scrCmpResult	db 0			; DATA XREF: seg000:sCompareVarsw
					; seg000:2AC4w	...
portA4State	db 0			; DATA XREF: seg000:2CF1w seg000:2CFBr ...
OldIntVec24	dd 0			; DATA XREF: SetupInt0A_24+46w
					; RestoreInts+4Fr ...
OldIntVec0A	dd 0			; DATA XREF: SetupInt0A_24+25w
					; RestoreInts+3Br ...
scrLoopCounter	dw 0			; DATA XREF: seg000:loc_10A7Dw
					; seg000:25D4w	...
		db 14h,	80h, 10h, 80h, 0Ch, 80h, 8, 80h, 4, 80h, 0, 80h
		db 14h,	80h, 10h, 80h, 0Ch, 80h, 8, 80h, 4, 80h, 0, 80h
		db 14h,	80h, 10h, 80h, 0Ch, 80h
dword_1A039	dd 0			; DATA XREF: RestoreInts+45r
					; SetupInt15+6w ...
ptrMenu1Entry	dw 0			; DATA XREF: sub_103F9+Fr seg000:341Fw
ptrUserAction	dw 0			; DATA XREF: sub_103F9:loc_1042Fr
					; seg000:3427w	...
word_1A041	dw 0			; DATA XREF: sub_103F9:loc_10417r
					; seg000:344Ew
word_1A043	dw 0			; DATA XREF: sub_103F9+2Ar
					; seg000:3456w
menuDataPtr	dw 0			; DATA XREF: sub_10716+Br seg000:342Dw
scrMenuJumpPtr	dw 0			; DATA XREF: sub_103F9+53r
					; seg000:3432w	...
byte_1A049	db 0			; DATA XREF: start:ScriptMainLoopr
					; sub_103F9+43w ...
byte_1A04A	db 0			; DATA XREF: SetupInt15+1Cw
					; sub_103F9+1w	...
byte_1A04B	db 0			; DATA XREF: SetupInt15+20w
					; sub_103F9+7r	...
byte_1A04C	db 0			; DATA XREF: sub_103F9+14r sub_10716w	...
byte_1A04D	db 0			; DATA XREF: SetupInt15+24w sub_10644r ...
KeyPressMask	db 0			; DATA XREF: SetupInt15+28w
					; sub_103F9+3Br ...
byte_1A04F	db 0			; DATA XREF: seg000:04C0w seg000:04E4w ...
byte_1A050	db 0			; DATA XREF: seg000:04D8w seg000:0501w ...
byte_1A051	db 0			; DATA XREF: seg000:04C8w seg000:04ECw ...
byte_1A052	db 0			; DATA XREF: seg000:04D0w seg000:04F9w ...
word_1A053	dw 0			; DATA XREF: SetupInt15+2Cw
					; seg000:048Ew	...
word_1A055	dw 0			; DATA XREF: SetupInt15+30w
					; seg000:04B0w	...
word_1A057	dw 0			; DATA XREF: SetupInt15+34w
					; sub_103F9+23r ...
word_1A059	dw 0			; DATA XREF: SetupInt15+3Bw
					; sub_103F9+2Fr ...
word_1A05B	dw 0			; DATA XREF: SetupInt15+42w
					; seg000:loc_1052Dr ...
word_1A05D	dw 0			; DATA XREF: SetupInt15+46w
					; seg000:loc_1056Er ...
word_1A05F	dw 0			; DATA XREF: SetupInt15+4Aw
					; seg000:loc_10538r ...
word_1A061	dw 0			; DATA XREF: SetupInt15+51w
					; seg000:loc_10579r ...
word_1A063	dw 0			; DATA XREF: sub_10668+2r
					; sub_1067A+17w ...
byte_1A065	db 0C0h	dup(0)		; DATA XREF: sub_10644+Co
		db 0E0h,   0,	0
		db 0F8h,   0,	0
		db 0FEh,   0,	0
		db  7Fh, 80h,	0
		db  7Fh,0E0h,	0
		db  3Fh,0F8h,	0
		db  3Fh,0FEh,	0
		db  1Fh,0FFh,	0
		db  1Fh,0FEh,	0
		db  0Fh,0FCh,	0
		db  0Fh,0F8h,	0
		db    7,0FCh,	0
		db    7,0FEh,	0
		db    3,0DFh,	0
		db    3, 8Fh,	0
		db    1,   7,	0
		db    0,   0,	0
		db  60h,   0,	0
		db  78h,   0,	0
		db  3Eh,   0,	0
		db  3Fh, 80h,	0
		db  1Fh,0E0h,	0
		db  1Fh,0F8h,	0
		db  0Fh,0FEh,	0
		db  0Fh,0FCh,	0
		db    7,0F8h,	0
		db    7,0F0h,	0
		db    3,0F8h,	0
		db    3,0DCh,	0
		db    1, 8Eh,	0
		db    1,   6,	0
		db    0,   0,	0
		db  70h,   0,	0
		db  7Ch,   0,	0
		db  7Fh,   0,	0
		db  3Fh,0C0h,	0
		db  3Fh,0F0h,	0
		db  1Fh,0FCh,	0
		db  1Fh,0FFh,	0
		db  0Fh,0FFh, 80h
		db  0Fh,0FFh,	0
		db    7,0FEh,	0
		db    7,0FCh,	0
		db    3,0FEh,	0
		db    3,0FFh,	0
		db    1,0EFh, 80h
		db    1,0C7h, 80h
		db    0, 83h, 80h
		db    0,   0,	0
		db  30h,   0,	0
		db  3Ch,   0,	0
		db  1Fh,   0,	0
		db  1Fh,0C0h,	0
		db  0Fh,0F0h,	0
		db  0Fh,0FCh,	0
		db    7,0FFh,	0
		db    7,0FEh,	0
		db    3,0FCh,	0
		db    3,0F8h,	0
		db    1,0FCh,	0
		db    1,0EEh,	0
		db    0,0C7h,	0
		db    0, 83h,	0
		db    0,   0,	0
		db  38h,   0,	0
		db  3Eh,   0,	0
		db  3Fh, 80h,	0
		db  1Fh,0E0h,	0
		db  1Fh,0F8h,	0
		db  0Fh,0FEh,	0
		db  0Fh,0FFh, 80h
		db    7,0FFh,0C0h
		db    7,0FFh, 80h
		db    3,0FFh,	0
		db    3,0FEh,	0
		db    1,0FFh,	0
		db    1,0FFh, 80h
		db    0,0F7h,0C0h
		db    0,0E3h,0C0h
		db    0, 41h,0C0h
		db    0,   0,	0
		db  18h,   0,	0
		db  1Eh,   0,	0
		db  0Fh, 80h,	0
		db  0Fh,0E0h,	0
		db    7,0F8h,	0
		db    7,0FEh,	0
		db    3,0FFh, 80h
		db    3,0FFh,	0
		db    1,0FEh,	0
		db    1,0FCh,	0
		db    0,0FEh,	0
		db    0,0F7h,	0
		db    0, 63h, 80h
		db    0, 41h, 80h
		db    0,   0,	0
		db  1Ch,   0,	0
		db  1Fh,   0,	0
		db  1Fh,0C0h,	0
		db  0Fh,0F0h,	0
		db  0Fh,0FCh,	0
		db    7,0FFh,	0
		db    7,0FFh,0C0h
		db    3,0FFh,0E0h
		db    3,0FFh,0C0h
		db    1,0FFh, 80h
		db    1,0FFh,	0
		db    0,0FFh, 80h
		db    0,0FFh,0C0h
		db    0, 7Bh,0E0h
		db    0, 71h,0E0h
		db    0, 20h,0E0h
		db    0,   0,	0
		db  0Ch,   0,	0
		db  0Fh,   0,	0
		db    7,0C0h,	0
		db    7,0F0h,	0
		db    3,0FCh,	0
		db    3,0FFh,	0
		db    1,0FFh,0C0h
		db    1,0FFh, 80h
		db    0,0FFh,	0
		db    0,0FEh,	0
		db    0, 7Fh,	0
		db    0, 7Bh, 80h
		db    0, 31h,0C0h
		db    0, 20h,0C0h
		db    0,   0,	0
		db  0Eh,   0,	0
		db  0Fh, 80h,	0
		db  0Fh,0E0h,	0
		db    7,0F8h,	0
		db    7,0FEh,	0
		db    3,0FFh, 80h
		db    3,0FFh,0E0h
		db    1,0FFh,0F0h
		db    1,0FFh,0E0h
		db    0,0FFh,0C0h
		db    0,0FFh, 80h
		db    0, 7Fh,0C0h
		db    0, 7Fh,0E0h
		db    0, 3Dh,0F0h
		db    0, 38h,0F0h
		db    0, 10h, 70h
		db    0,   0,	0
		db    6,   0,	0
		db    7, 80h,	0
		db    3,0E0h,	0
		db    3,0F8h,	0
		db    1,0FEh,	0
		db    1,0FFh, 80h
		db    0,0FFh,0E0h
		db    0,0FFh,0C0h
		db    0, 7Fh, 80h
		db    0, 7Fh,	0
		db    0, 3Fh, 80h
		db    0, 3Dh,0C0h
		db    0, 18h,0E0h
		db    0, 10h, 60h
		db    0,   0,	0
		db    7,   0,	0
		db    7,0C0h,	0
		db    7,0F0h,	0
		db    3,0FCh,	0
		db    3,0FFh,	0
		db    1,0FFh,0C0h
		db    1,0FFh,0F0h
		db    0,0FFh,0F8h
		db    0,0FFh,0F0h
		db    0, 7Fh,0E0h
		db    0, 7Fh,0C0h
		db    0, 3Fh,0E0h
		db    0, 3Fh,0F0h
		db    0, 1Eh,0F8h
		db    0, 1Ch, 78h
		db    0,   8, 38h
		db    0,   0,	0
		db    3,   0,	0
		db    3,0C0h,	0
		db    1,0F0h,	0
		db    1,0FCh,	0
		db    0,0FFh,	0
		db    0,0FFh,0C0h
		db    0, 7Fh,0F0h
		db    0, 7Fh,0E0h
		db    0, 3Fh,0C0h
		db    0, 3Fh, 80h
		db    0, 1Fh,0C0h
		db    0, 1Eh,0E0h
		db    0, 0Ch, 70h
		db    0,   8, 30h
		db    0,   0,	0
		db    3, 80h,	0
		db    3,0E0h,	0
		db    3,0F8h,	0
		db    1,0FEh,	0
		db    1,0FFh, 80h
		db    0,0FFh,0E0h
		db    0,0FFh,0F8h
		db    0, 7Fh,0FCh
		db    0, 7Fh,0F8h
		db    0, 3Fh,0F0h
		db    0, 3Fh,0E0h
		db    0, 1Fh,0F0h
		db    0, 1Fh,0F8h
		db    0, 0Fh, 7Ch
		db    0, 0Eh, 3Ch
		db    0,   4, 1Ch
		db    0,   0,	0
		db    1, 80h,	0
		db    1,0E0h,	0
		db    0,0F8h,	0
		db    0,0FEh,	0
		db    0, 7Fh, 80h
		db    0, 7Fh,0E0h
		db    0, 3Fh,0F8h
		db    0, 3Fh,0F0h
		db    0, 1Fh,0E0h
		db    0, 1Fh,0C0h
		db    0, 0Fh,0E0h
		db    0, 0Fh, 70h
		db    0,   6, 38h
		db    0,   4, 18h
		db    0,   0,	0
		db    1,0C0h,	0
		db    1,0F0h,	0
		db    1,0FCh,	0
		db    0,0FFh,	0
		db    0,0FFh,0C0h
		db    0, 7Fh,0F0h
		db    0, 7Fh,0FCh
		db    0, 3Fh,0FEh
		db    0, 3Fh,0FCh
		db    0, 1Fh,0F8h
		db    0, 1Fh,0F0h
		db    0, 0Fh,0F8h
		db    0, 0Fh,0FCh
		db    0,   7,0BEh
		db    0,   7, 1Eh
		db    0,   2, 0Eh
		db    0,   0,	0
		db    0,0C0h,	0
		db    0,0F0h,	0
		db    0, 7Ch,	0
		db    0, 7Fh,	0
		db    0, 3Fh,0C0h
		db    0, 3Fh,0F0h
		db    0, 1Fh,0FCh
		db    0, 1Fh,0F8h
		db    0, 0Fh,0F0h
		db    0, 0Fh,0E0h
		db    0,   7,0F0h
		db    0,   7,0B8h
		db    0,   3, 1Ch
		db    0,   2, 0Ch
		db    0,   0,	0
PortraitInfo	db 120h	dup(0)		; DATA XREF: PrintText+319o
					; seg000:3BB5o	...
byte_1A545	db 0			; DATA XREF: sub_11801+35r
					; sub_11801+3Fr ...
word_1A546	dw 500Eh		; DATA XREF: sub_11801+2Dr
					; seg000:3C7Bw
word_1A548	dw 502h			; DATA XREF: sub_138CE+1r
seg000		ends


		end start
