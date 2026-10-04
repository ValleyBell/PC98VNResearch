; Dengeki Nurse Opening (NRSOPEN.TCM) - English Translation
; Patch to support additional English subtitles by Valley Bell, developed on 2026-02-28
; Translation by trentsignia
;
; Assembling using NASM:
;	nasm -f bin -o "NRSOPEN-EN.TCM" -l "NRSOPEN-EN.lst" "NRSOPEN-EN.asm"
;	This requires NRSOPEN.TCM (9 737 bytes) to be in the same folder.

	use16
	cpu	186

	org	0
	SECTION .text

%macro	COLCHG	3
	DB	%3, %1, %2	; x, y, width
%endmacro
%macro	COLCHG_END	0
	DB	0	; width 0 -> end
%endmacro

start:
		pop	ax
		push	cs
		push	ax
		call	$+3
		pop	ax
		sub	ax, 6
		test	al, 0Fh
		jnz	short loc_2B
		shr	ax, 1
		shr	ax, 1
		shr	ax, 1
		shr	ax, 1
		mov	bp, cs
		add	ax, bp
		mov	di, ax
		push	ax
		mov	ax, loc_22
		push	ax
		retf
; ---------------------------------------------------------------------------

loc_22:					; DATA XREF: seg000:001Do
		call	sub_2E
		call	sub_38
		call	sub_3F

loc_2B:					; CODE XREF: seg000:000Cj
		mov	ch, 0FFh
		retf

sub_2E:					; CODE XREF: seg000:loc_22p
		call	SetupSegRegs
		call	SetupInts2
		call	sub_5A
		retn

sub_38:					; CODE XREF: seg000:0025p
		call	SaveArgParam
		call	sub_B7
		retn

sub_3F:					; CODE XREF: seg000:0028p
		call	sub_AA
		call	RestoreInts
		retn

SetupSegRegs:				; CODE XREF: sub_2Ep
		mov	ax, cs
		mov	ds, ax
		mov	es, ax
		mov	word [word_260C], bp
		mov	word [word_260A], si
		mov	byte [byte_260E], 0
		retn

sub_5A:					; CODE XREF: sub_2E+6p
		push	ax
		mov	ax, 1B00h
		int	18h
		pop	ax
		retn

SetQuit:					; CODE XREF: sub_125:loc_139p
					; LoadWSB_OpN:loc_20Dp ...
		push	ax
		push	ds
		mov	ax, cs
		mov	ds, ax
		mov	byte [byte_260E], 1
		pop	ds
		pop	ax
		retn

CheckQuit:					; CODE XREF: LoadWSB_OpN+3p sub_23C+4p ...
		push	ax
		push	ds
		mov	ax, cs
		mov	ds, ax
		cmp	byte [byte_260E], 0
		pop	ds
		pop	ax
		retn

SetQuitFromKey:				; CODE XREF: mainexec_00:loc_2D9p
					; sub_2EA:loc_2FBp ...
		mov	cl, 1
		mov	ax, 5
		int	33h		; DATA XREF: free+5r malloc_segs+9r ...
					; - MS MOUSE - RETURN BUTTON PRESS DATA
					; BX = button
					; Return: AX = button states
					; BX = number of times specified button has been pressed
					; CX = column at time specified button was last pressed
					; DX = row at time specified button was last pressed
		or	ax, ax
		jnz	short loc_A1
		mov	ah, 1
		int	18h
		or	bh, bh
		jz	short loc_9F
		xor	ah, ah
		int	18h
		cmp	ah, 1Ch
		jz	short loc_A1
		cmp	ah, 34h
		jz	short loc_A1

loc_9F:					; CODE XREF: SetQuitFromKey+11j
		xor	cl, cl

loc_A1:					; CODE XREF: SetQuitFromKey+9j
					; SetQuitFromKey+1Aj ...
		mov	byte [byte_260E], cl
		xor	ch, ch
		sub	ch, cl
		retn

sub_AA:					; CODE XREF: sub_3Fp
		push	ax
		mov	ax, 1B01h
		int	18h
		pop	ax
		retn

SaveArgParam:				; CODE XREF: sub_38p
		mov	byte [byte_260F], bl
		retn

sub_B7:					; CODE XREF: sub_38+3p
		call	DoMode0_Setup
		call	DoMode1_RunOP
		retn

DoMode0_Setup:				; CODE XREF: sub_B7p
		cmp	byte [byte_260F], 0
		jnz	short locret_D1
		call	sub_125
		call	LoadWSB_OpN
		call	sub_23C		; DATA XREF: SetQuitFromKey+5r
		call	sub_279

locret_D1:				; CODE XREF: DoMode0_Setup+5j
		retn

DoMode1_RunOP:				; CODE XREF: sub_B7+3p
		cmp	byte [byte_260F], 1
		jnz	short locret_124
		call	sub_2A1
		call	sub_2AC
		call	sub_2B3
		call	mainexec_00
		call	sub_2EA
		call	sub_30C
		call	sub_32E
		call	sub_350
		call	sub_372
		call	sub_394
		call	sub_3B6
		call	sub_3D8
		call	sub_3FA
		call	sub_41C
		call	sub_43E
		call	sub_460
		call	sub_482
		call	sub_4A4
		call	mainexec_15
		call	free_all
		call	sub_741
		call	sub_72C
		call	ClearTRAM
		call	GDCPlane_RW0
		call	GDCPlane_Disp0

locret_124:				; CODE XREF: DoMode1_RunOP+5j
		retn

sub_125:					; CODE XREF: DoMode0_Setup+7p
		call	LoadWSB_OpRA
		jb	short loc_139
		call	LoadWSB_OpRB
		jb	short loc_139
		call	LoadWSB_OpRC
		jb	short loc_139
		call	LoadWSB_OpRD
		jnb	short locret_13C

loc_139:				; CODE XREF: sub_125+3j sub_125+8j ...
		call	SetQuit

locret_13C:				; CODE XREF: sub_125+12j
		retn

LoadWSB_OpRA:				; CODE XREF: sub_125p
		push	si
		push	di
		mov	si, aBOpenNsopra_ws ; "B:\\OPEN\\nsopra.wsb"
		mov	di, off_2610
		call	LoadWSB
		pop	di
		pop	si
		retn

LoadWSB_OpRB:				; CODE XREF: sub_125+5p
		push	si
		push	di
		mov	si, aBOpenNsoprb_ws ; "B:\\OPEN\\nsoprb.wsb"
		mov	di, off_2614
		call	LoadWSB
		pop	di
		pop	si
		retn

LoadWSB_OpRC:				; CODE XREF: sub_125+Ap
		pusha
		push	ds
		push	es
		mov	si, aBOpenNsoprc_ws ; "B:\\OPEN\\nsoprc.wsb"
		call	sub_1659
		jb	short loc_185
		xor	al, al
		call	sub_17C0
		jb	short loc_185
		mov	word [off_2618+2], es
		mov	word [off_2618], bx
		mov	si, cx
		mov	di, dx
		mov	dx, byte_2648
		call	GetFileData
		jb	short loc_185
		mov	di, bx
		call	sub_16C4
		clc

loc_185:				; CODE XREF: LoadWSB_OpRC+9j
					; LoadWSB_OpRC+10j ...
		pop	es
		pop	ds
		popa
		retn

LoadWSB_OpRD:				; CODE XREF: sub_125+Fp
		push	si
		push	di
		mov	si, aBOpenNsoprd_ws ; "B:\\OPEN\\nsoprd.wsb"
		mov	di, off_261C
		call	LoadWSB
		pop	di
		pop	si
		retn

LoadWSB_OpN:				; CODE XREF: DoMode0_Setup+Ap
		push	bx
		push	si
		push	di
		call	CheckQuit
		jnz	short loc_210
		mov	si, aBOpenNsop1_wsb ; "B:\\OPEN\\nsop1.wsb"
		mov	di, off_2620
		call	LoadWSB
		jb	short loc_20D
		mov	si, aBOpenNsop1a_ws ; "B:\\OPEN\\nsop1a.wsb"
		mov	di, off_2624
		call	LoadWSB
		jb	short loc_20D
		mov	si, aBOpenNsop2_wsb ; "B:\\OPEN\\nsop2.wsb"
		mov	di, off_2628
		call	LoadWSB
		jb	short loc_20D
		mov	si, aBOpenNsop2a_ws ; "B:\\OPEN\\nsop2a.wsb"
		mov	di, off_262C
		call	LoadWSB
		jb	short loc_20D
		mov	si, aBOpenNsop3_wsb ; "B:\\OPEN\\nsop3.wsb"
		mov	di, off_2630
		call	LoadWSB
		jb	short loc_20D
		mov	si, aBOpenNsop3a_ws ; "B:\\OPEN\\nsop3a.wsb"
		mov	di, off_2634
		call	LoadWSB
		jb	short loc_20D
		mov	si, aBOpenNsop4_wsb ; "B:\\OPEN\\nsop4.wsb"
		mov	di, off_2638
		call	LoadWSB
		jb	short loc_20D
		mov	si, aBOpenNsop4a_ws ; "B:\\OPEN\\nsop4a.wsb"
		mov	di, off_263C
		call	LoadWSB
		jb	short loc_20D
		mov	si, aBOpenNsop5_wsb ; "B:\\OPEN\\nsop5.wsb"
		mov	di, off_2640
		call	LoadWSB
		jb	short loc_20D
		mov	si, aBOpenNsop5a_ws ; "B:\\OPEN\\nsop5a.wsb"
		mov	di, off_2644
		call	LoadWSB
		jnb	short loc_210

loc_20D:				; CODE XREF: LoadWSB_OpN+11j
					; LoadWSB_OpN+1Cj ...
		call	SetQuit

loc_210:				; CODE XREF: LoadWSB_OpN+6j
					; LoadWSB_OpN+74j
		pop	di
		pop	si
		pop	bx
		retn

LoadWSB:					; CODE XREF: LoadWSB_OpRA+8p
					; LoadWSB_OpRB+8p ...
		pusha
		push	ds
		push	es
		call	sub_1659
		jb	short loc_238
		call	malloc
		jb	short loc_238
		mov	word [di+2], es
		mov	[di], bx
		mov	si, cx
		mov	di, dx
		mov	dx, byte_2648
		call	GetFileData
		jb	short loc_238
		mov	di, bx
		call	sub_16C4
		clc

loc_238:				; CODE XREF: LoadWSB+6j LoadWSB+Bj ...
		pop	es
		pop	ds
		popa
		retn

sub_23C:					; CODE XREF: DoMode0_Setup+Dp
		push	ax
		push	cx
		push	di
		push	es
		call	CheckQuit
		jnz	short loc_274
		xor	cx, cx
		mov	ax, 0A800h
		mov	es, ax
		mov	di, 7FFFh
		mov	ax, word [word_25FF]

loc_252:				; CODE XREF: sub_23C+1Aj
		cmp	ax, word [word_25FF]
		jz	short loc_252
		mov	ax, word [word_25FF]

loc_25B:				; CODE XREF: sub_23C+27j
		mov	[es:di], al
		inc	cx
		cmp	ax, word [word_25FF]
		jz	short loc_25B
		mov	byte [byte_1958], 0
		cmp	ch, 10h
		jb	short loc_274
		mov	byte [byte_1958], 1

loc_274:				; CODE XREF: sub_23C+7j sub_23C+31j
		pop	es
		pop	di
		pop	cx
		pop	ax
		retn

sub_279:					; CODE XREF: DoMode0_Setup+10p
		pusha
		push	ds
		push	es
		call	CheckQuit
		jnz	short loc_29D
		mov	bx, cs
		mov	es, bx
		mov	bx, word_268C
		mov	dx, aBOpenNrsopdtb_ ; "B:\\OPEN\\nrsopdtb.dat"
		cmp	byte [byte_1958], 0
		jz	short loc_295
		mov	dx, aBOpenNrsopdta_ ; "B:\\OPEN\\nrsopdta.dat"

loc_295:				; CODE XREF: sub_279+17j
		call	LoadDAT
		jnb	short loc_29D
		call	SetQuit

loc_29D:				; CODE XREF: sub_279+6j sub_279+1Fj
		pop	es
		pop	ds
		popa
		retn

sub_2A1:					; CODE XREF: DoMode1_RunOP+7p
		cmp	byte [byte_1958], 0FFh
		jnz	short locret_2AB
		call	SetQuit

locret_2AB:				; CODE XREF: sub_2A1+5j
		retn

sub_2AC:					; CODE XREF: DoMode1_RunOP+Ap
		push	ax
		mov	ah, 0Bh
		int	0F1h		; reserved for user interrupt
		pop	ax
		retn

sub_2B3:					; CODE XREF: DoMode1_RunOP+Dp
		call	CheckQuit
		jnz	short locret_2C7
		call	sub_190F
		cli
		mov	word [word_25FF], 0
		sti
		mov	ah, 1
		int	0F4h

locret_2C7:				; CODE XREF: sub_2B3+3j
		retn

mainexec_00:				; CODE XREF: DoMode1_RunOP+10p
		call	CheckQuit
		jnz	short locret_2E9
		mov	si, word [word_268C]
		add	si, word_268C
		mov	di, mainJumpTbl
		cld

loc_2D9:				; CODE XREF: mainexec_00+1Fj
		call	SetQuitFromKey
		jb	short locret_2E9
		lodsw
		cmp	ax, 0FFFFh
		jz	short locret_2E9
		call	DoJumpTable
		jmp	short loc_2D9
; ---------------------------------------------------------------------------

locret_2E9:				; CODE XREF: mainexec_00+3j
					; mainexec_00+14j ...
		retn

sub_2EA:					; CODE XREF: DoMode1_RunOP+13p
		call	CheckQuit
		jnz	short locret_30B
		mov	si, word [word_268E]
		add	si, word_268C
		mov	di, mainJumpTbl
		cld

loc_2FB:				; CODE XREF: sub_2EA+1Fj
		call	SetQuitFromKey
		jb	short locret_30B
		lodsw
		cmp	ax, 0FFFFh
		jz	short locret_30B
		call	DoJumpTable
		jmp	short loc_2FB
; ---------------------------------------------------------------------------

locret_30B:				; CODE XREF: sub_2EA+3j sub_2EA+14j ...
		retn

sub_30C:					; CODE XREF: DoMode1_RunOP+16p
		call	CheckQuit
		jnz	short locret_32D
		mov	si, word [word_2690]
		add	si, word_268C
		mov	di, mainJumpTbl
		cld

loc_31D:				; CODE XREF: sub_30C+1Fj
		call	SetQuitFromKey
		jb	short locret_32D
		lodsw
		cmp	ax, 0FFFFh
		jz	short locret_32D
		call	DoJumpTable
		jmp	short loc_31D
; ---------------------------------------------------------------------------

locret_32D:				; CODE XREF: sub_30C+3j sub_30C+14j ...
		retn

sub_32E:					; CODE XREF: DoMode1_RunOP+19p
		call	CheckQuit
		jnz	short locret_34F
		mov	si, word [word_2692]
		add	si, word_268C
		mov	di, mainJumpTbl
		cld

loc_33F:				; CODE XREF: sub_32E+1Fj
		call	SetQuitFromKey
		jb	short locret_34F
		lodsw
		cmp	ax, 0FFFFh
		jz	short locret_34F
		call	DoJumpTable
		jmp	short loc_33F
; ---------------------------------------------------------------------------

locret_34F:				; CODE XREF: sub_32E+3j sub_32E+14j ...
		retn

sub_350:					; CODE XREF: DoMode1_RunOP+1Cp
		call	CheckQuit
		jnz	short locret_371
		mov	si, word [word_2694]
		add	si, word_268C
		mov	di, mainJumpTbl
		cld

loc_361:				; CODE XREF: sub_350+1Fj
		call	SetQuitFromKey
		jb	short locret_371
		lodsw
		cmp	ax, 0FFFFh
		jz	short locret_371
		call	DoJumpTable
		jmp	short loc_361
; ---------------------------------------------------------------------------

locret_371:				; CODE XREF: sub_350+3j sub_350+14j ...
		retn

sub_372:					; CODE XREF: DoMode1_RunOP+1Fp
		call	CheckQuit
		jnz	short locret_393
		mov	si, word [word_2696]
		add	si, word_268C
		mov	di, mainJumpTbl
		cld

loc_383:				; CODE XREF: sub_372+1Fj
		call	SetQuitFromKey
		jb	short locret_393
		lodsw
		cmp	ax, 0FFFFh
		jz	short locret_393
		call	DoJumpTable
		jmp	short loc_383
; ---------------------------------------------------------------------------

locret_393:				; CODE XREF: sub_372+3j sub_372+14j ...
		retn

sub_394:					; CODE XREF: DoMode1_RunOP+22p
		call	CheckQuit
		jnz	short locret_3B5
		mov	si, word [word_2698]
		add	si, word_268C
		mov	di, mainJumpTbl
		cld

loc_3A5:				; CODE XREF: sub_394+1Fj
		call	SetQuitFromKey
		jb	short locret_3B5
		lodsw
		cmp	ax, 0FFFFh
		jz	short locret_3B5
		call	DoJumpTable
		jmp	short loc_3A5
; ---------------------------------------------------------------------------

locret_3B5:				; CODE XREF: sub_394+3j sub_394+14j ...
		retn

sub_3B6:					; CODE XREF: DoMode1_RunOP+25p
		call	CheckQuit
		jnz	short locret_3D7
		mov	si, word [word_269A]
		add	si, word_268C
		mov	di, mainJumpTbl ; DATA XREF: sub_2AC+3r
					; DrawTextStr+2Cr ...
		cld

loc_3C7:				; CODE XREF: sub_3B6+1Fj
					; DATA XREF: sub_1660+8r ...
		call	SetQuitFromKey
		jb	short locret_3D7

loc_3CC:				; DATA XREF: seg000:17BCr sub_17C0+9r ...
		lodsw
		cmp	ax, 0FFFFh

loc_3D0:				; DATA XREF: sub_2B3+12r seg000:0701r ...
		jz	short locret_3D7
		call	DoJumpTable
		jmp	short loc_3C7
; ---------------------------------------------------------------------------

locret_3D7:				; CODE XREF: sub_3B6+3j sub_3B6+14j ...
		retn

sub_3D8:					; CODE XREF: DoMode1_RunOP+28p
		call	CheckQuit
		jnz	short locret_3F9
		mov	si, word [word_269C]
		add	si, word_268C
		mov	di, mainJumpTbl
		cld

loc_3E9:				; CODE XREF: sub_3D8+1Fj
		call	SetQuitFromKey
		jb	short locret_3F9
		lodsw
		cmp	ax, 0FFFFh
		jz	short locret_3F9
		call	DoJumpTable
		jmp	short loc_3E9
; ---------------------------------------------------------------------------

locret_3F9:				; CODE XREF: sub_3D8+3j sub_3D8+14j ...
		retn

sub_3FA:					; CODE XREF: DoMode1_RunOP+2Bp
		call	CheckQuit
		jnz	short locret_41B
		mov	si, word [word_269E]
		add	si, word_268C
		mov	di, mainJumpTbl
		cld

loc_40B:				; CODE XREF: sub_3FA+1Fj
		call	SetQuitFromKey
		jb	short locret_41B
		lodsw
		cmp	ax, 0FFFFh
		jz	short locret_41B
		call	DoJumpTable
		jmp	short loc_40B
; ---------------------------------------------------------------------------

locret_41B:				; CODE XREF: sub_3FA+3j sub_3FA+14j ...
		retn

sub_41C:					; CODE XREF: DoMode1_RunOP+2Ep
		call	CheckQuit
		jnz	short locret_43D
		mov	si, word [word_26A0]
		add	si, word_268C
		mov	di, mainJumpTbl
		cld

loc_42D:				; CODE XREF: sub_41C+1Fj
		call	SetQuitFromKey
		jb	short locret_43D
		lodsw
		cmp	ax, 0FFFFh
		jz	short locret_43D
		call	DoJumpTable
		jmp	short loc_42D
; ---------------------------------------------------------------------------

locret_43D:				; CODE XREF: sub_41C+3j sub_41C+14j ...
		retn

sub_43E:					; CODE XREF: DoMode1_RunOP+31p
		call	CheckQuit
		jnz	short locret_45F
		mov	si, word [word_26A2]
		add	si, word_268C
		mov	di, mainJumpTbl
		cld

loc_44F:				; CODE XREF: sub_43E+1Fj
		call	SetQuitFromKey
		jb	short locret_45F
		lodsw
		cmp	ax, 0FFFFh
		jz	short locret_45F
		call	DoJumpTable
		jmp	short loc_44F
; ---------------------------------------------------------------------------

locret_45F:				; CODE XREF: sub_43E+3j sub_43E+14j ...
		retn

sub_460:					; CODE XREF: DoMode1_RunOP+34p
		call	CheckQuit
		jnz	short locret_481
		mov	si, word [word_26A4]
		add	si, word_268C
		mov	di, mainJumpTbl
		cld

loc_471:				; CODE XREF: sub_460+1Fj
		call	SetQuitFromKey
		jb	short locret_481
		lodsw
		cmp	ax, 0FFFFh
		jz	short locret_481
		call	DoJumpTable
		jmp	short loc_471
; ---------------------------------------------------------------------------

locret_481:				; CODE XREF: sub_460+3j sub_460+14j ...
		retn

sub_482:					; CODE XREF: DoMode1_RunOP+37p
		call	CheckQuit
		jnz	short locret_4A3
		mov	si, word [word_26A6]
		add	si, word_268C
		mov	di, mainJumpTbl
		cld

loc_493:				; CODE XREF: sub_482+1Fj
		call	SetQuitFromKey
		jb	short locret_4A3
		lodsw
		cmp	ax, 0FFFFh
		jz	short locret_4A3
		call	DoJumpTable
		jmp	short loc_493
; ---------------------------------------------------------------------------

locret_4A3:				; CODE XREF: sub_482+3j sub_482+14j ...
		retn

sub_4A4:					; CODE XREF: DoMode1_RunOP+3Ap
		call	CheckQuit
		jnz	short locret_4C5
		mov	si, word [word_26A8]
		add	si, word_268C
		mov	di, mainJumpTbl
		cld

loc_4B5:				; CODE XREF: sub_4A4+1Fj
		call	SetQuitFromKey
		jb	short locret_4C5
		lodsw
		cmp	ax, 0FFFFh
		jz	short locret_4C5
		call	DoJumpTable
		jmp	short loc_4B5
; ---------------------------------------------------------------------------

locret_4C5:				; CODE XREF: sub_4A4+3j sub_4A4+14j ...
		retn

mainexec_15:				; CODE XREF: DoMode1_RunOP+3Dp
		call	CheckQuit
		jnz	short locret_4E7
		mov	si, word [word_26AA]
		add	si, word_268C
		mov	di, mainJumpTbl
		cld

loc_4D7:				; CODE XREF: mainexec_15+1Fj
		call	SetQuitFromKey
		jb	short locret_4E7
		lodsw
		cmp	ax, 0FFFFh
		jz	short locret_4E7
		call	DoJumpTable
		jmp	short loc_4D7
; ---------------------------------------------------------------------------

locret_4E7:				; CODE XREF: mainexec_15+3j
					; mainexec_15+14j ...
		retn

; ---------------------------------------------------------------------------
		retn
; ---------------------------------------------------------------------------
mainJumpTbl	dw loc_6F3	; 0 ; DATA XREF: mainexec_00+Do
					; sub_2EA+Do ...
		dw GDCPlane_RW0 ; 1
		dw GDCPlane_RW1 ; 2
		dw GDCPlane_Disp0; 3
		dw GDCPlane_Disp1; 4
		dw vramfill_1	; 5
		dw vramfill_2	; 6
		dw vramfill_3	; 7
		dw vramfill_4	; 8
		dw vramfill_5	; 9
		dw loc_758	; 0Ah
		dw loc_766	; 0Bh
		dw loc_774	; 0Ch
		dw loc_782	; 0Dh
		dw loc_791	; 0Eh
		dw loc_7A0	; 0Fh
		dw loc_7AF	; 10h
		dw loc_7BE	; 11h
		dw loc_7CD	; 12h
		dw loc_7DB	; 13h
		dw loc_7EA	; 14h
		dw loc_7F9	; 15h
		dw loc_808	; 16h
		dw loc_817	; 17h
		dw loc_825	; 18h
		dw loc_833	; 19h
		dw loc_841	; 1Ah
		dw loc_84F	; 1Bh
		dw loc_85D	; 1Ch
		dw loc_86B	; 1Dh
		dw loc_879	; 1Eh
		dw loc_887	; 1Fh
		dw loc_895	; 20h
		dw loc_8A3	; 21h
		dw loc_8BB	; 22h
		dw loc_90E	; 23h
		dw draw_staff	; 24h
		dw draw_staff	; 25h
		dw draw_staff	; 26h
		dw draw_staff	; 27h
		dw draw_staff	; 28h
		dw draw_staff	; 29h
		dw draw_staff	; 2Ah
		dw draw_staff	; 2Bh
		dw draw_staff	; 2Ch
		dw draw_staff	; 2Dh
		dw draw_staff	; 2Eh
		dw draw_staff	; 2Fh
		dw draw_staff	; 30h
		dw draw_stclear	; 31h
		dw draw_stclear	; 32h
		dw draw_lyrics	; 33h
		dw draw_lyrics	; 34h
		dw draw_lyrics	; 35h
		dw draw_lyrics	; 36h
		dw draw_lyrics	; 37h
		dw draw_lyrics	; 38h
		dw draw_lyrics	; 39h
		dw draw_lyrics	; 3Ah
		dw draw_lyrics	; 3Bh
		dw draw_lyrics	; 3Ch
		dw draw_lyrics	; 3Dh
		dw draw_lyrics	; 3Eh
		dw draw_lyrics	; 3Fh
		dw draw_lyrics	; 40h
		dw draw_lyrics	; 41h
		dw karaoke_00	; 42h
		dw karaoke_00	; 43h
		dw karaoke_00	; 44h
		dw karaoke_00	; 45h
		dw karaoke_00	; 46h
		dw karaoke_00	; 47h
		dw karaoke_00	; 48h
		dw karaoke_00	; 49h
		dw karaoke_00	; 4Ah
		dw karaoke_00	; 4Bh
		dw karaoke_00	; 4Ch
		dw karaoke_00	; 4Dh
		dw karaoke_00	; 4Eh
		dw karaoke_00	; 4Fh
		dw karaoke_00	; 50h
		dw karaoke_00	; 51h
		dw karaoke_00	; 52h
		dw karaoke_00	; 53h
		dw karaoke_00	; 54h
		dw karaoke_00	; 55h
		dw karaoke_00	; 56h
		dw karaoke_00	; 57h
		dw karaoke_00	; 58h
		dw karaoke_01	; 59h
		dw karaoke_01	; 5Ah
		dw karaoke_01	; 5Bh
		dw karaoke_01	; 5Ch
		dw karaoke_01	; 5Dh
		dw karaoke_01	; 5Eh
		dw karaoke_01	; 5Fh
		dw karaoke_01	; 60h
		dw karaoke_01	; 61h
		dw karaoke_01	; 62h
		dw karaoke_01	; 63h
		dw karaoke_01	; 64h
		dw karaoke_01	; 65h
		dw karaoke_01	; 66h
		dw karaoke_01	; 67h
		dw karaoke_01	; 68h
		dw karaoke_01	; 69h
		dw karaoke_01	; 6Ah
		dw karaoke_01	; 6Bh
		dw karaoke_02	; 6Ch
		dw karaoke_02	; 6Dh
		dw karaoke_02	; 6Eh
		dw karaoke_02	; 6Fh
		dw karaoke_02	; 70h
		dw karaoke_02	; 71h
		dw karaoke_02	; 72h
		dw karaoke_02	; 73h
		dw karaoke_02	; 74h
		dw karaoke_02	; 75h
		dw karaoke_02	; 76h
		dw karaoke_02	; 77h
		dw karaoke_02	; 78h
		dw karaoke_02	; 79h
		dw karaoke_02	; 7Ah
		dw karaoke_02	; 7Bh
		dw karaoke_02	; 7Ch
		dw karaoke_02	; 7Dh
		dw karaoke_02	; 7Eh
		dw karaoke_03	; 7Fh
		dw karaoke_03	; 80h
		dw karaoke_03	; 81h
		dw karaoke_03	; 82h
		dw karaoke_03	; 83h
		dw karaoke_03	; 84h
		dw karaoke_03	; 85h
		dw karaoke_03	; 86h
		dw karaoke_03	; 87h
		dw karaoke_03	; 88h
		dw karaoke_03	; 89h
		dw karaoke_03	; 8Ah
		dw karaoke_03	; 8Bh
		dw karaoke_03	; 8Ch
		dw karaoke_03	; 8Dh
		dw karaoke_03	; 8Eh
		dw karaoke_04	; 8Fh
		dw karaoke_04	; 90h
		dw karaoke_04	; 91h
		dw karaoke_04	; 92h
		dw karaoke_04	; 93h
		dw karaoke_04	; 94h
		dw karaoke_04	; 95h
		dw karaoke_04	; 96h
		dw karaoke_04	; 97h
		dw karaoke_04	; 98h
		dw karaoke_04	; 99h
		dw karaoke_04	; 9Ah
		dw karaoke_04	; 9Bh
		dw karaoke_04	; 9Ch
		dw karaoke_04	; 9Dh
		dw karaoke_04	; 9Eh
		dw karaoke_04	; 9Fh
		dw karaoke_04	; 0A0h
		dw karaoke_05	; 0A1h
		dw karaoke_05	; 0A2h
		dw karaoke_05	; 0A3h
		dw karaoke_05	; 0A4h
		dw karaoke_05	; 0A5h
		dw karaoke_05	; 0A6h
		dw karaoke_05	; 0A7h
		dw karaoke_05	; 0A8h
		dw karaoke_05	; 0A9h
		dw karaoke_05	; 0AAh
		dw karaoke_05	; 0ABh
		dw karaoke_05	; 0ACh
		dw karaoke_05	; 0ADh
		dw karaoke_06	; 0AEh
		dw karaoke_06	; 0AFh
		dw karaoke_06	; 0B0h
		dw karaoke_06	; 0B1h
		dw karaoke_06	; 0B2h
		dw karaoke_06	; 0B3h
		dw karaoke_06	; 0B4h
		dw karaoke_06	; 0B5h
		dw karaoke_06	; 0B6h
		dw karaoke_06	; 0B7h
		dw karaoke_06	; 0B8h
		dw karaoke_06	; 0B9h
		dw karaoke_06	; 0BAh
		dw karaoke_06	; 0BBh
		dw karaoke_06	; 0BCh
		dw karaoke_06	; 0BDh
		dw karaoke_06	; 0BEh
		dw karaoke_06	; 0BFh
		dw karaoke_06	; 0C0h
		dw karaoke_06	; 0C1h
		dw karaoke_06	; 0C2h
		dw karaoke_06	; 0C3h
		dw karaoke_06	; 0C4h
		dw karaoke_07	; 0C5h
		dw karaoke_07	; 0C6h
		dw karaoke_07	; 0C7h
		dw karaoke_07	; 0C8h
		dw karaoke_07	; 0C9h
		dw karaoke_07	; 0CAh
		dw karaoke_07	; 0CBh
		dw karaoke_07	; 0CCh
		dw karaoke_07	; 0CDh
		dw karaoke_07	; 0CEh
		dw karaoke_07	; 0CFh
		dw karaoke_07	; 0D0h
		dw karaoke_07	; 0D1h
		dw karaoke_07	; 0D2h
		dw karaoke_07	; 0D3h
		dw karaoke_07	; 0D4h
		dw karaoke_07	; 0D5h
		dw karaoke_08	; 0D6h
		dw karaoke_08	; 0D7h
		dw karaoke_08	; 0D8h
		dw karaoke_08	; 0D9h
		dw karaoke_08	; 0DAh
		dw karaoke_08	; 0DBh
		dw karaoke_08	; 0DCh
		dw karaoke_08	; 0DDh
		dw karaoke_08	; 0DEh
		dw karaoke_08	; 0DFh
		dw karaoke_08	; 0E0h
		dw karaoke_08	; 0E1h
		dw karaoke_08	; 0E2h
		dw karaoke_08	; 0E3h
		dw karaoke_08	; 0E4h
		dw karaoke_08	; 0E5h
		dw karaoke_08	; 0E6h
		dw karaoke_08	; 0E7h
		dw karaoke_08	; 0E8h
		dw karaoke_09	; 0E9h
		dw karaoke_09	; 0EAh
		dw karaoke_09	; 0EBh
		dw karaoke_09	; 0ECh
		dw karaoke_09	; 0EDh
		dw karaoke_09	; 0EEh
		dw karaoke_09	; 0EFh
		dw karaoke_09	; 0F0h
		dw karaoke_09	; 0F1h
		dw karaoke_09	; 0F2h
		dw karaoke_09	; 0F3h
		dw karaoke_09	; 0F4h
		dw karaoke_09	; 0F5h
		dw karaoke_09	; 0F6h
		dw karaoke_09	; 0F7h
		dw karaoke_09	; 0F8h
		dw karaoke_09	; 0F9h
		dw karaoke_09	; 0FAh
		dw karaoke_09	; 0FBh
		dw loc_6FC	; 0FCh
		dw loc_704	; 0FDh
		dw sub_72C	; 0FEh
		dw loc_731	; 0FFh

DoJumpTable:				; CODE XREF: mainexec_00+1Cp
					; sub_2EA+1Cp ...
		push	bx
		mov	bx, ax
		shl	bx, 1
		call	word [es:bx+di]
		pop	bx
		retn

; ---------------------------------------------------------------------------

loc_6F3:				; DATA XREF: seg000:mainJumpTblo
		cld
		lodsw

loc_6F5:				; CODE XREF: seg000:06F9j
		cmp	ax, word [word_25FF]
		ja	short loc_6F5
		retn
; ---------------------------------------------------------------------------

loc_6FC:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, 18h
		mov	ah, 11h
		int	0F4h
		retn
; ---------------------------------------------------------------------------

loc_704:				; DATA XREF: seg000:mainJumpTblo
		mov	ah, 3
		int	0F4h
		retn

free_all:					; CODE XREF: DoMode1_RunOP+40p
		push	cx
		push	si
		push	es
		mov	si, off_2610
		mov	cx, 0Eh

loc_712:				; CODE XREF: free_all+12j
		mov	es, word [si+2]
		call	free
		add	si, byte 4
		loop	loc_712
		pop	es
		pop	si
		pop	cx
		retn

free:					; CODE XREF: free_all+Cp
		pusha
		push	ds
		push	es
		mov	ah, 49h
		int	21h		; DOS - 2+ - FREE MEMORY
					; ES = segment address of area to be freed
		pop	es
		pop	ds
		popa
		retn

sub_72C:					; CODE XREF: DoMode1_RunOP+46p
					; DATA XREF: seg000:mainJumpTblo
		mov	ah, 2
		int	0F4h
		retn

; ---------------------------------------------------------------------------

loc_731:				; DATA XREF: seg000:mainJumpTblo
		pusha
		mov	si, txt_25DE
		mov	dx, [si]
		add	si, byte 2
		mov	cl, 7
		call	DrawTextStr
		popa
		retn

sub_741:					; CODE XREF: DoMode1_RunOP+43p
		call	CheckQuit
		jnz	short locret_749
		call	sub_186E

locret_749:				; CODE XREF: sub_741+3j
		retn

ClearTRAM:					; CODE XREF: DoMode1_RunOP+49p
		push	di
		xor	di, di
		mov	bx, 25
		mov	dx, 80
		call	FillTRAM
		pop	di
		retn

; ---------------------------------------------------------------------------

loc_758:				; DATA XREF: seg000:mainJumpTblo
		push	di
		push	es
		les	di, [off_2610]
		xor	bx, bx
		call	sub_8D3
		pop	es
		pop	di
		retn
; ---------------------------------------------------------------------------

loc_766:				; DATA XREF: seg000:mainJumpTblo
		push	di
		push	es
		les	di, [off_2614]
		xor	bx, bx
		call	sub_8D3
		pop	es
		pop	di
		retn
; ---------------------------------------------------------------------------

loc_774:				; DATA XREF: seg000:mainJumpTblo
		push	di
		push	es
		les	di, [off_2618]
		xor	bx, bx
		call	sub_8D3
		pop	es
		pop	di
		retn
; ---------------------------------------------------------------------------

loc_782:				; DATA XREF: seg000:mainJumpTblo
		push	di
		push	es
		les	di, [off_2618]
		mov	bx, 1
		call	sub_8D3
		pop	es
		pop	di
		retn
; ---------------------------------------------------------------------------

loc_791:				; DATA XREF: seg000:mainJumpTblo
		push	di
		push	es
		les	di, [off_2618]
		mov	bx, 2
		call	sub_8D3
		pop	es
		pop	di
		retn
; ---------------------------------------------------------------------------

loc_7A0:				; DATA XREF: seg000:mainJumpTblo
		push	di
		push	es
		les	di, [off_2618]
		mov	bx, 3
		call	sub_8D3
		pop	es
		pop	di
		retn
; ---------------------------------------------------------------------------

loc_7AF:				; DATA XREF: seg000:mainJumpTblo
		push	di
		push	es
		les	di, [off_2618]
		mov	bx, 4
		call	sub_8D3
		pop	es
		pop	di
		retn
; ---------------------------------------------------------------------------

loc_7BE:				; DATA XREF: seg000:mainJumpTblo
		push	di
		push	es
		les	di, [off_2618]
		mov	bx, 5
		call	sub_8D3
		pop	es
		pop	di
		retn
; ---------------------------------------------------------------------------

loc_7CD:				; DATA XREF: seg000:mainJumpTblo
		push	di
		push	es
		les	di, [off_261C]
		xor	bx, bx
		call	sub_8D3
		pop	es
		pop	di
		retn
; ---------------------------------------------------------------------------

loc_7DB:				; DATA XREF: seg000:mainJumpTblo
		push	di
		push	es
		les	di, [off_261C]
		mov	bx, 1
		call	sub_8D3
		pop	es
		pop	di
		retn
; ---------------------------------------------------------------------------

loc_7EA:				; DATA XREF: seg000:mainJumpTblo
		push	di
		push	es
		les	di, [off_261C]
		mov	bx, 2
		call	sub_8D3
		pop	es
		pop	di
		retn
; ---------------------------------------------------------------------------

loc_7F9:				; DATA XREF: seg000:mainJumpTblo
		push	di
		push	es
		les	di, [off_261C]
		mov	bx, 3
		call	sub_8D3
		pop	es
		pop	di
		retn
; ---------------------------------------------------------------------------

loc_808:				; DATA XREF: seg000:mainJumpTblo
		push	di
		push	es
		les	di, [off_261C]
		mov	bx, 4
		call	sub_8D3
		pop	es
		pop	di
		retn
; ---------------------------------------------------------------------------

loc_817:				; DATA XREF: seg000:mainJumpTblo
		push	di
		push	es
		les	di, [off_2620]
		xor	bx, bx
		call	sub_8D3
		pop	es
		pop	di
		retn
; ---------------------------------------------------------------------------

loc_825:				; DATA XREF: seg000:mainJumpTblo
		push	di
		push	es
		les	di, [off_2624]
		xor	bx, bx
		call	sub_8D3
		pop	es
		pop	di
		retn
; ---------------------------------------------------------------------------

loc_833:				; DATA XREF: seg000:mainJumpTblo
		push	di
		push	es
		les	di, [off_2628]
		xor	bx, bx
		call	sub_8D3
		pop	es
		pop	di
		retn
; ---------------------------------------------------------------------------

loc_841:				; DATA XREF: seg000:mainJumpTblo
		push	di
		push	es
		les	di, [off_262C]
		xor	bx, bx
		call	sub_8D3
		pop	es
		pop	di
		retn
; ---------------------------------------------------------------------------

loc_84F:				; DATA XREF: seg000:mainJumpTblo
		push	di
		push	es
		les	di, [off_2630]
		xor	bx, bx
		call	sub_8D3
		pop	es
		pop	di
		retn
; ---------------------------------------------------------------------------

loc_85D:				; DATA XREF: seg000:mainJumpTblo
		push	di
		push	es
		les	di, [off_2634]
		xor	bx, bx
		call	sub_8D3
		pop	es
		pop	di
		retn
; ---------------------------------------------------------------------------

loc_86B:				; DATA XREF: seg000:mainJumpTblo
		push	di
		push	es
		les	di, [off_2638]
		xor	bx, bx
		call	sub_8D3
		pop	es
		pop	di
		retn
; ---------------------------------------------------------------------------

loc_879:				; DATA XREF: seg000:mainJumpTblo
		push	di
		push	es
		les	di, [off_263C]
		xor	bx, bx
		call	sub_8D3
		pop	es
		pop	di
		retn
; ---------------------------------------------------------------------------

loc_887:				; DATA XREF: seg000:mainJumpTblo
		push	di
		push	es
		les	di, [off_2640]
		xor	bx, bx
		call	sub_8D3
		pop	es
		pop	di
		retn
; ---------------------------------------------------------------------------

loc_895:				; DATA XREF: seg000:mainJumpTblo
		push	di
		push	es
		les	di, [off_2644]
		xor	bx, bx
		call	sub_8D3
		pop	es
		pop	di
		retn
; ---------------------------------------------------------------------------

loc_8A3:				; DATA XREF: seg000:mainJumpTblo
		push	si
		push	di
		push	ds
		push	es
		les	di, [off_2640]
		xor	bx, bx
		call	sub_8EC
		jb	short loc_8B6
		mov	word [si], 2

loc_8B6:				; CODE XREF: seg000:08B0j
		pop	es
		pop	ds
		pop	di
		pop	si
		retn
; ---------------------------------------------------------------------------

loc_8BB:				; DATA XREF: seg000:mainJumpTblo
		push	si
		push	di
		push	ds
		push	es
		les	di, [off_2644]
		xor	bx, bx
		call	sub_8EC
		jb	short loc_8CE
		mov	word [si], 7

loc_8CE:				; CODE XREF: seg000:08C8j
		pop	es
		pop	ds
		pop	di
		pop	si
		retn

sub_8D3:					; CODE XREF: seg000:0760p seg000:076Ep ...
		push	si
		call	sub_8EC
		jb	short loc_8EA
		call	sub_905
		mov	bx, ds
		mov	ax, cs
		mov	ds, ax
		mov	word [off_2688+2], bx
		mov	word [off_2688], si

loc_8EA:				; CODE XREF: sub_8D3+4j
		pop	si
		retn

sub_8EC:					; CODE XREF: seg000:08ADp seg000:08C5p ...
		push	bx
		cmp	bx, [es:di]
		jnb	short loc_902
		shl	bx, 1
		mov	si, [es:bx+di+2]
		mov	bx, es
		add	bx, si
		mov	ds, bx
		mov	si, di
		jmp	short loc_903
; ---------------------------------------------------------------------------

loc_902:				; CODE XREF: sub_8EC+4j
		stc

loc_903:				; CODE XREF: sub_8EC+14j
		pop	bx
		retn

sub_905:					; CODE XREF: sub_8D3+6p
		push	di
		call	CalcVRAMOfs
		call	sub_159A
		pop	di
		retn

; ---------------------------------------------------------------------------

loc_90E:				; DATA XREF: seg000:mainJumpTblo
		push	si
		push	ds
		lds	si, [off_2688]
		mov	al, 0Fh
		add	si, byte 8
		call	sub_17D3
		pop	ds
		pop	si
		retn
; ---------------------------------------------------------------------------

vramfill_1:				; DATA XREF: seg000:mainJumpTblo
		push	di
		xor	di, di		; start offset
		mov	bx, 400		; lines
		mov	dx, 50h		; columns
		xor	cl, cl
		call	DoVRAMFill
		pop	di
		retn
; ---------------------------------------------------------------------------

vramfill_2:				; DATA XREF: seg000:mainJumpTblo
		push	di
		mov	di, 507h
		mov	bx, 296
		mov	dx, 13
		xor	cl, cl
		call	DoVRAMFill
		pop	di
		retn
; ---------------------------------------------------------------------------

vramfill_3:				; DATA XREF: seg000:mainJumpTblo
		push	di
		mov	di, 502h
		mov	bx, 296
		mov	dx, 23
		xor	cl, cl
		call	DoVRAMFill
		pop	di
		retn
; ---------------------------------------------------------------------------

vramfill_4:				; DATA XREF: seg000:mainJumpTblo
		push	di
		mov	di, 53Dh
		mov	bx, 296
		mov	dx, 13
		xor	cl, cl
		call	DoVRAMFill
		pop	di
		retn
; ---------------------------------------------------------------------------

vramfill_5:				; DATA XREF: seg000:mainJumpTblo
		push	di
		mov	di, 538h
		mov	bx, 296
		mov	dx, 23
		xor	cl, cl
		call	DoVRAMFill
		pop	di
		retn
; ---------------------------------------------------------------------------

karaoke_00:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_204A
		sub	ax, 42h
		call	ChangeCharColor
		mov	si, bx
		retn

karaoke_01:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_20E6
		sub	ax, 59h
		call	ChangeCharColor
		mov	si, bx
		retn

karaoke_02:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_2176
		sub	ax, 6Ch
		call	ChangeCharColor
		mov	si, bx
		retn

karaoke_03:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_220E
		sub	ax, 7Fh
		call	ChangeCharColor
		mov	si, bx
		retn

karaoke_04:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_2296
		sub	ax, 8Fh
		call	ChangeCharColor
		mov	si, bx
		retn

karaoke_05:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_231A
		sub	ax, 0A1h
		call	ChangeCharColor
		mov	si, bx
		retn

karaoke_06:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_2386
		sub	ax, 0AEh
		call	ChangeCharColor
		mov	si, bx
		retn

karaoke_07:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_242E
		sub	ax, 0C5h
		call	ChangeCharColor
		mov	si, bx
		retn

karaoke_08:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_24B2
		sub	ax, 0D6h
		call	ChangeCharColor
		mov	si, bx
		retn

karaoke_09:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_254A
		sub	ax, 0E9h
		call	ChangeCharColor
		mov	si, bx
		retn

ChangeCharColor:				; CODE XREF: seg000:097Ap seg000:0988p ...
		pusha
		push	es
		shl	ax, 1
		add	si, ax
		mov	si, [si]
		mov	ax, 0A200h
		mov	es, ax
		mov	bl, 0C1h	; set text attributes (color 6)
		
chgchrcol_locloop:
		mov	cl, [si]	; read number of characters to change
		or	cl, cl
		jz	short loc_13B3	; no characters - terminate loop
		add	si, byte 1
		
		mov	dx, [si]	; read coordinate
		add	si, byte 2
		call	CalcTRAMOfs
		
chgchrcol_chrloop:
		mov	[es:di], bl
		add	di, byte 2
		dec	cl
		jnz	chgchrcol_chrloop
		jmp	short chgchrcol_locloop
		
loc_13B3:
		pop	es
		popa
		retn

; ---------------------------------------------------------------------------

draw_staff:
		mov	bx, StaffTextPtrs
		sub	ax, 24h
		mov	cl, 7	; colour
		jmp	short DrawTextsByID

draw_stclear:
		mov	bx, StaffClearPtrs
		sub	ax, 31h
		mov	cl, 7	; colour
		jmp	short DrawTextsByID

draw_lyrics:
		mov	bx, LyricsPtrs
		sub	ax, 33h
		mov	cl, 7	; colour
		;jmp	short DrawTextsByID
		; fall through

DrawTextsByID:
		push	si
		shl	ax, 1
		add	bx, ax
		mov	bx, [bx]
lyric_itemloop:
		mov	si, [bx]
		or	si, si
		jz	lyric_finish
		add	bx, byte 2
		mov	dx, [si]
		add	si, byte 2
		call	DrawTextStr
		jmp	short lyric_itemloop
lyric_finish:
		pop	si
		retn

DrawTextStr:				; CODE XREF: seg000:073Cp
					; DrawLyricsByID+11p ...
		pusha
		push	es
		call	CalcTRAMOfs
		and	cl, 7
		shl	cl, 5
		or	cl, 1
		mov	ax, 0A000h
		mov	es, ax

loc_1516:				; CODE XREF: DrawTextStr+49j
		mov	dx, [si]
		or	dl, dl
		jz	short loc_154E
		cmp	dl, 80h
		jbe	short loc_153E
		cmp	dl, 0A0h
		jb	short loc_152B
		cmp	dl, 0E0h
		jb	short loc_153E

loc_152B:				; CODE XREF: DrawTextStr+21j
		xchg	dh, dl
		mov	ah, 2
		int	0F1h		; Shift-JIS to ROM code?
		xchg	dh, dl
		sub	dl, 20h
		call	DrawChar2B
		mov	bp, 2
		jmp	short loc_1546
; ---------------------------------------------------------------------------

loc_153E:				; CODE XREF: DrawTextStr+1Cj
					; DrawTextStr+26j
		xor	dh, dh
		call	DrawChar1B
		mov	bp, 1

loc_1546:				; CODE XREF: DrawTextStr+39j
		add	si, bp
		shl	bp, 1
		add	di, bp
		jmp	short loc_1516
; ---------------------------------------------------------------------------

loc_154E:				; CODE XREF: DrawTextStr+17j
		pop	es
		popa
		retn

DrawChar2B:					; CODE XREF: DrawTextStr+33p
		mov	[es:di], dx
		mov	[es:di+2000h], cl
		mov	[es:di+2002h], cl
		retn

DrawChar1B:					; CODE XREF: DrawTextStr+3Dp
		mov	[es:di], dx
		mov	[es:di+2000h], cl
		retn

CalcTRAMOfs:				; CODE XREF: DrawTextStr+2p
		xor	ax, ax
		mov	al, dh
		shl	ax, 5
		mov	di, ax		; DI = DH*32
		shl	ax, 2
		add	di, ax		; DI = DH*160
		xor	ax, ax
		mov	al, dl
		shl	ax, 1
		add	di, ax		; DI = DH*160 + DL*2
		retn

CalcVRAMOfs:				; CODE XREF: sub_905+1p
		push	ax
		push	bx
		push	cx
		mov	bx, [si]
		mov	ax, [si+2]
		mov	cx, 80
		call	sub_1593	; AX = AX * 80 + BX
		mov	di, ax
		pop	cx
		pop	bx
		pop	ax
		retn

sub_1593:					; CODE XREF: CalcVRAMOfs+Bp
		push	dx
		mul	cx
		add	ax, bx
		pop	dx
		retn

sub_159A:					; CODE XREF: sub_905+4p
		pusha
		push	ds
		push	es
		mov	cx, [si+4]
		add	si, byte 28h
		xchg	si, di
		mov	dx, ds
		mov	es, dx
		mov	dx, 0A800h

loc_15AC:				; CODE XREF: sub_159A+1Dj sub_159A+22j
		mov	ds, dx
		call	sub_15C2
		add	dh, 8
		cmp	dh, 0B8h
		jbe	short loc_15AC
		add	dh, 20h
		jnb	short loc_15AC
		pop	es
		pop	ds
		popa
		retn

sub_15C2:					; CODE XREF: sub_159A+14p
		push	cx
		push	dx
		push	si

loc_15C5:				; CODE XREF: sub_15C2+7j
		call	sub_15CF
		inc	si
		loop	loc_15C5
		pop	si
		pop	dx
		pop	cx
		retn

sub_15CF:					; CODE XREF: sub_15C2:loc_15C5p
		push	cx
		push	si
		mov	cx, [es:di]
		add	di, byte 2
		or	cx, cx
		jnz	short loc_15E7
		jmp	short loc_15F5
; ---------------------------------------------------------------------------

loc_15DD:				; CODE XREF: sub_15CF+85j
		mov	cx, [es:di]
		add	di, byte 2
		or	cx, cx
		jz	short loc_1656

loc_15E7:				; CODE XREF: sub_15CF+Aj
		xchg	ax, cx
		shl	ax, 4
		mov	dx, ax
		shl	ax, 2
		add	ax, dx
		xchg	ax, cx
		add	si, cx

loc_15F5:				; CODE XREF: sub_15CF+Cj
		mov	cx, [es:di]
		add	di, byte 2
		or	cx, cx
		jz	short loc_1656

loc_15FF:				; CODE XREF: sub_15CF+83j
		mov	al, [es:di]
		test	al, 80h
		jnz	short loc_1626
		or	al, al
		jnz	short loc_160C
		mov	al, 80h

loc_160C:				; CODE XREF: sub_15CF+39j
		mov	ah, [es:di+1]
		mov	bx, ax
		mov	dx, si

loc_1614:				; CODE XREF: sub_15CF+4Cj
		mov	[si], ah
		add	si, byte 50h
		dec	al
		jnz	short loc_1614
		mov	si, dx
		mov	ax, bx
		add	di, byte 2
		jmp	short loc_1644
; ---------------------------------------------------------------------------

loc_1626:				; CODE XREF: sub_15CF+35j
		inc	di
		and	al, 7Fh
		or	al, al
		jnz	short loc_162F
		mov	al, 80h

loc_162F:				; CODE XREF: sub_15CF+5Cj
		mov	bx, ax
		mov	dx, si

loc_1633:				; CODE XREF: sub_15CF+6Fj
		mov	ah, [es:di]
		mov	[si], ah
		inc	di
		add	si, byte 50h
		dec	al
		jnz	short loc_1633
		mov	si, dx
		mov	ax, bx

loc_1644:				; CODE XREF: sub_15CF+55j
		xor	ah, ah
		shl	ax, 4
		mov	dx, ax
		shl	ax, 2
		add	ax, dx
		add	si, ax
		loop	loc_15FF
		jmp	short loc_15DD
; ---------------------------------------------------------------------------

loc_1656:				; CODE XREF: sub_15CF+16j sub_15CF+2Ej
		pop	si
		pop	cx
		retn

sub_1659:					; CODE XREF: LoadWSB_OpRC+6p
					; LoadWSB+3p
		call	sub_1660
		call	sub_166C
		retn

sub_1660:					; CODE XREF: sub_1659p
		pusha
		mov	dx, si
		mov	bx, byte_2648
		mov	ah, 6
		int	0F2h
		popa
		retn

sub_166C:					; CODE XREF: sub_1659+3p
		push	ax
		push	bx
		mov	dx, byte_2648
		xor	al, al
		call	fopen
		jb	short loc_168D
		mov	bx, ax
		mov	al, 2
		xor	cx, cx
		xor	dx, dx
		call	fseek
		jb	short loc_168A
		mov	cx, dx
		mov	dx, ax
		clc

loc_168A:				; CODE XREF: sub_166C+17j
		call	fclose

loc_168D:				; CODE XREF: sub_166C+Aj
		pop	bx
		pop	ax
		retn

malloc:					; CODE XREF: LoadWSB+8p
		push	ax
		push	cx
		push	dx
		add	dx, byte 0Fh
		adc	cx, byte 0
		shr	dx, 4
		shl	cx, 0Ch
		or	cx, dx
		mov	bx, cx
		call	malloc_segs
		jb	short loc_16AD
		mov	es, ax
		xor	bx, bx
		clc

loc_16AD:				; CODE XREF: malloc+16j
		pop	dx
		pop	cx
		pop	ax
		retn

malloc_segs:				; CODE XREF: malloc+13p
		push	cx
		push	dx
		push	si
		push	di
		push	bp
		push	ds
		push	es
		mov	ah, 48h
		int	21h		; DOS - 2+ - ALLOCATE MEMORY
					; BX = number of 16-byte paragraphs desired
		pop	es
		pop	ds
		pop	bp
		pop	di
		pop	si
		pop	dx
		pop	cx
		retn

sub_16C4:					; CODE XREF: LoadWSB_OpRC+28p
					; LoadWSB+20p
		pusha
		push	ds
		push	es
		mov	cx, [es:di]
		xor	bx, bx

loc_16CC:				; CODE XREF: sub_16C4+11j
		call	sub_8EC
		jb	short loc_16D7
		call	sub_16DB
		inc	bx
		loop	loc_16CC

loc_16D7:				; CODE XREF: sub_16C4+Bj
		pop	es
		pop	ds
		popa
		retn

sub_16DB:					; CODE XREF: sub_16C4+Dp
		push	cx
		push	si
		add	si, byte 8
		mov	cx, 10h

loc_16E3:				; CODE XREF: sub_16DB+11j
		mov	ax, [si]
		xchg	ah, al
		mov	[si], ax
		add	si, byte 2
		loop	loc_16E3
		pop	si
		pop	cx
		retn

DoVRAMFill:					; CODE XREF: seg000:092Ap seg000:093Bp ...
		pusha
		push	es
		mov	ax, 0A800h
		mov	es, ax
		mov	al, 80h
		out	7Ch, al
		shr	cl, 1
		sbb	al, al
		out	7Eh, al
		shr	cl, 1
		sbb	al, al
		out	7Eh, al
		shr	cl, 1
		sbb	al, al
		out	7Eh, al
		shr	cl, 1
		sbb	al, al
		out	7Eh, al
		mov	ax, 80
		sub	ax, dx
		cld

loc_1762:				; CODE XREF: DoVRAMFill+36j
		mov	cx, dx
		shr	cx, 1
		rep stosw
		rcl	cx, 1
		rep stosb
		add	di, ax
		dec	bx
		jnz	short loc_1762
		xor	ax, ax
		out	7Ch, al
		pop	es
		popa
		retn

FillTRAM:					; CODE XREF: ClearTRAM+9p
		push	ax
		push	bx
		push	cx
		push	di
		push	bp
		push	es
		mov	bp, 0A0h
		sub	bp, dx
		sub	bp, dx
		mov	ax, 0A000h
		mov	es, ax
		xor	ax, ax
		cld

loc_178D:				; CODE XREF: FillTRAM+1Cj
		mov	cx, dx
		rep stosw
		add	di, bp
		dec	bx
		jnz	short loc_178D
		pop	es
		pop	bp
		pop	di
		pop	cx
		pop	bx
		pop	ax
		retn

GDCPlane_RW0:				; CODE XREF: DoMode1_RunOP+4Cp
					; DATA XREF: seg000:mainJumpTblo
		push	ax
		xor	al, al
		out	0A6h, al	; Interrupt Controller #2, 8259A
		pop	ax
		retn

; ---------------------------------------------------------------------------

GDCPlane_RW1:				; DATA XREF: seg000:mainJumpTblo
		push	ax
		mov	al, 1
		out	0A6h, al	; Interrupt Controller #2, 8259A
		pop	ax
		retn

GDCPlane_Disp0:				; CODE XREF: DoMode1_RunOP+4Fp
					; DATA XREF: seg000:mainJumpTblo
		push	ax
		xor	al, al
		out	0A4h, al	; Interrupt Controller #2, 8259A
		pop	ax
		retn

; ---------------------------------------------------------------------------

GDCPlane_Disp1:				; DATA XREF: seg000:mainJumpTblo
		push	ax
		mov	al, 1
		out	0A4h, al	; Interrupt Controller #2, 8259A
		pop	ax
		retn
; ---------------------------------------------------------------------------
		push	ax
		xor	ah, ah
		int	0F3h
		pop	ax
		retn

sub_17C0:					; CODE XREF: LoadWSB_OpRC+Dp
		push	ax
		push	cx
		push	dx
		push	si
		push	di
		push	bp
		push	ds
		mov	ah, 8
		int	0F3h
		pop	ds
		pop	bp
		pop	di
		pop	si
		pop	dx
		pop	cx
		pop	ax
		retn

sub_17D3:					; CODE XREF: seg000:0919p
		push	ax
		mov	ah, 13h
		int	0F3h
		pop	ax
		retn

GetFileData:				; CODE XREF: LoadWSB_OpRC+21p
					; LoadWSB+19p
		pusha
		push	ds
		push	es
		mov	al, 0
		call	fopen
		jb	short loc_17F2
		mov	dx, es
		mov	ds, dx
		mov	dx, bx
		mov	bx, ax
		call	freadall
		call	fclose

loc_17F2:				; CODE XREF: GetFileData+8j
		pop	es
		pop	ds
		popa
		retn

LoadDAT:					; CODE XREF: sub_279:loc_295p
		pusha
		push	ds
		push	es
		xor	ah, ah
		int	0F2h
		pop	es
		pop	ds
		popa
		retn

freadall:					; CODE XREF: GetFileData+12p
		pusha
		push	ds
		push	es
		call	sub_1835

loc_1807:				; CODE XREF: freadall+2Bj
		mov	cx, 0FFF0h
		cmp	di, cx
		jnb	short loc_1814
		or	si, si
		jnz	short loc_1814
		mov	cx, di

loc_1814:				; CODE XREF: freadall+Bj freadall+Fj
		call	fread
		jb	short loc_1831
		sub	di, ax
		sbb	si, byte 0
		cmp	ax, cx
		jnz	short loc_1830
		call	sub_1848
		call	sub_1835
		mov	ax, si
		or	ax, di
		jnz	short loc_1807
		jmp	short loc_1831
; ---------------------------------------------------------------------------

loc_1830:				; CODE XREF: freadall+1Fj
		stc

loc_1831:				; CODE XREF: freadall+16j freadall+2Dj
		pop	es
		pop	ds
		popa
		retn

sub_1835:					; CODE XREF: freadall+3p freadall+24p
		push	ax
		push	bx
		mov	ax, dx
		shr	ax, 4
		mov	bx, ds
		add	ax, bx
		mov	ds, ax
		and	dx, byte 0Fh
		pop	bx
		pop	ax
		retn

sub_1848:					; CODE XREF: freadall+21p
		push	ax
		add	dx, cx
		jnb	short loc_1854
		mov	ax, ds
		add	ah, 10h
		mov	ds, ax

loc_1854:				; CODE XREF: sub_1848+3j
		pop	ax
		retn

fopen:					; CODE XREF: sub_166C+7p
					; GetFileData+5p
		mov	ah, 3Dh
		int	21h		; DOS - 2+ - OPEN DISK FILE WITH HANDLE
					; DS:DX -> ASCIZ filename
					; AL = access mode
					; 0 - read, 1 - write, 2 - read & write
		retn

fclose:					; CODE XREF: sub_166C:loc_168Ap
					; GetFileData+15p
		pushf
		push	ax
		mov	ah, 3Eh
		int	21h		; DOS - 2+ - CLOSE A FILE WITH HANDLE
					; BX = file handle
		pop	ax
		popf
		retn

fread:					; CODE XREF: freadall:loc_1814p
		mov	ah, 3Fh
		int	21h		; DOS - 2+ - READ FROM FILE WITH HANDLE
					; BX = file handle, CX = number of bytes to read
					; DS:DX -> buffer
		retn

fseek:					; CODE XREF: sub_166C+14p
		mov	ah, 42h
		int	21h		; DOS - 2+ - MOVE FILE READ/WRITE POINTER (LSEEK)
					; AL = method:
					; 0-from beginnig,1-from current,2-from end
		retn

sub_186E:					; CODE XREF: sub_741+5p
		push	ax
		mov	ah, 7
		int	0F1h		; reserved for user interrupt
		pop	ax
		retn

; ---------------------------------------------------------------------------
		db    0
; ---------------------------------------------------------------------------

IntVec0A:				; DATA XREF: SetupInts2+1o
		push	ax
		push	ds
		mov	ax, cs
		mov	ds, ax
		inc	word [word_25FF]
		mov	al, 20h
		out	0, al
		out	64h, al
		pop	ds
		pop	ax
		iret
; ---------------------------------------------------------------------------

IntVec18:				; DATA XREF: SetupInts+2Do
		push	si
		push	ds
		cli
		mov	si, cs
		mov	ds, si
		pushf
		dw	1EFFh, OldInt18 ;call	[ds:OldInt18]	; NASM assembles this to 3E FF 16 xx yy
		sti
		out	64h, al		; 8042 keyboard controller command register.
		pop	ds
		pop	si
		iret

SetupInts:					; CODE XREF: SetupInts2+4p
		pusha
		push	ds
		push	es
		mov	dx, ax
		mov	ax, cs
		mov	ds, ax
		cli
		mov	al, 0Ah
		call	GetIntVector
		mov	word [OldInt0A], bx
		mov	word [OldInt0A+2], es
		mov	al, 18h
		call	GetIntVector
		mov	word [OldInt18], bx
		mov	word [OldInt18+2], es
		mov	ax, cs
		mov	ds, ax
		mov	al, 0Ah
		call	SetIntVector
		mov	dx, IntVec18
		mov	al, 18h
		call	SetIntVector
		in	al, 2		; DMA controller, 8237A-5.
					; channel 1 current address
		and	al, 0FBh
		out	2, al		; DMA controller, 8237A-5.
					; channel 1 base address
					; (also sets current address)
		out	64h, al		; 8042 keyboard controller command register.
		sti
		pop	es
		pop	ds
		popa
		retn

RestoreInts:				; CODE XREF: sub_3F+3p
		pusha
		push	ds
		push	es
		cli
		mov	dx, cs
		mov	ds, dx
		lds	dx, [OldInt0A]
		mov	al, 0Ah
		call	SetIntVector
		mov	dx, cs
		mov	ds, dx
		lds	dx, [OldInt18]
		mov	al, 18h
		call	SetIntVector
		in	al, 2		; DMA controller, 8237A-5.
					; channel 1 current address
		or	al, 4
		out	2, al		; DMA controller, 8237A-5.
					; channel 1 base address
					; (also sets current address)
		sti
		pop	es
		pop	ds
		popa
		retn

SetupInts2:					; CODE XREF: sub_2E+3p
		push	ax
		mov	ax, IntVec0A
		call	SetupInts
		pop	ax
		retn

sub_190F:					; CODE XREF: sub_2B3+5p
					; seg000:loc_1931p
		push	ax
		push	ds
		mov	ax, cs
		mov	ds, ax
		mov	ax, [word_25FF]

loc_1918:				; CODE XREF: sub_190F+Dj
		cmp	ax, [word_25FF]
		jz	short loc_1918
		pop	ds
		pop	ax
		retn

GetIntVector:				; CODE XREF: SetupInts+Cp
					; SetupInts+19p
		push	ax
		push	cx
		push	dx
		push	si
		push	di
		push	bp
		push	ds
		mov	ah, 35h
		int	21h		; DOS - 2+ - GET INTERRUPT VECTOR
					; AL = interrupt number
					; Return: ES:BX = value of interrupt vector
		pop	ds
		pop	bp
		pop	di
		pop	si
		pop	dx
		pop	cx
		pop	ax
		retn

SetIntVector:				; CODE XREF: SetupInts+2Ap
					; SetupInts+32p ...
		pusha
		push	ds
		push	es
		mov	ah, 25h
		int	21h		; DOS - SET INTERRUPT VECTOR
					; AL = interrupt number
					; DS:DX = new vector to be used for specified interrupt
		pop	es
		pop	ds
		popa
		retn

; ---------------------------------------------------------------------------
byte_1958	db 0FFh			; DATA XREF: sub_23C+29w sub_23C+33w ...
aBOpenNsopra_ws	db 'B:\OPEN\nsopra.wsb',0
aBOpenNsoprb_ws	db 'B:\OPEN\nsoprb.wsb',0
aBOpenNsoprc_ws	db 'B:\OPEN\nsoprc.wsb',0
aBOpenNsoprd_ws	db 'B:\OPEN\nsoprd.wsb',0
aBOpenNsop1_wsb	db 'B:\OPEN\nsop1.wsb',0
aBOpenNsop1a_ws	db 'B:\OPEN\nsop1a.wsb',0
aBOpenNsop2_wsb	db 'B:\OPEN\nsop2.wsb',0
aBOpenNsop2a_ws	db 'B:\OPEN\nsop2a.wsb',0
aBOpenNsop3_wsb	db 'B:\OPEN\nsop3.wsb',0
aBOpenNsop3a_ws	db 'B:\OPEN\nsop3a.wsb',0
aBOpenNsop4_wsb	db 'B:\OPEN\nsop4.wsb',0
aBOpenNsop4a_ws	db 'B:\OPEN\nsop4a.wsb',0
aBOpenNsop5_wsb	db 'B:\OPEN\nsop5.wsb',0
aBOpenNsop5a_ws	db 'B:\OPEN\nsop5a.wsb',0
aBOpenNrsopdta_	db 'B:\OPEN\nrsopdta.dat',0
aBOpenNrsopdtb_	db 'B:\OPEN\nrsopdtb.dat',0

	align 2

StaffTextPtrs:	; 1A98h
	DW	staffptrs_00
	DW	staffptrs_01
	DW	staffptrs_02
	DW	staffptrs_03
	DW	staffptrs_04
	DW	staffptrs_05
	DW	staffptrs_06
	DW	staffptrs_07
	DW	staffptrs_08
	DW	staffptrs_09
	DW	staffptrs_10
	DW	staffptrs_11
	DW	staffptrs_12

staffptrs_00:
	DW	role00_jp, role00_en, name00_jp, name00_en, 0

role00_jp:	; "企画・監修"
	DB	8, 6	; x, y
	DB	8Ah, 0E9h, 89h, 0E6h, 81h, 45h, 8Ah, 0C4h, 8Fh, 43h, 0
role00_en:
	DB	9, 7
	DB	"Planning", 0
name00_jp:	; "電撃プロジェクト"
	DB	6, 9
	DB	93h, 64h, 8Ch, 82h, 83h, 76h, 83h, 8Dh, 83h, 57h, 83h, 46h, 83h, 4Eh, 83h, 67h, 0
name00_en:
	DB	6, 10
	DB	"Dengeki Project", 0

staffptrs_01:
	DW	role01_jp1, role01_jp2, role01_en1, role01_en2, name01_jp, name01_en, 0
role01_jp1:	; "シナリオ"
	DB	62, 6
	DB	83h, 56h, 83h, 69h, 83h, 8Ah, 83h, 49h, 0
role01_jp2:	; "ゲームデザイン"
	DB	59, 7
	DB	83h, 51h, 81h, 5Bh, 83h, 80h, 83h, 66h, 83h, 55h, 83h, 43h, 83h, 93h, 0
role01_en1:
	DB	61, 8
	DB	"Scenario &", 0
role01_en2:
	DB	60, 9
	DB	"Game Design", 0
name01_jp:	; "葛西　みなみ"
	DB	60, 11
	DB	8Ah, 8Bh, 90h, 0BCh, 81h, 40h, 82h, 0DDh, 82h, 0C8h, 82h, 0DDh, 0
name01_en:
	DB	60, 12
	DB	"Minami Kasai", 0

staffptrs_02:
	DW	role02_jp1, role02_jp2, role02_en1, role02_en2, name02_jp, name02_en, 0
role02_jp1:	; "作画監督"
	DB	62, 6
	DB	8Dh, 0ECh, 89h, 0E6h, 8Ah, 0C4h, 93h, 0C2h, 0
role02_jp2:	; "キャラクターデザイン"
	DB	56, 7
	DB	83h, 4Ch, 83h, 83h, 83h, 89h, 83h, 4Eh, 83h, 5Eh, 81h, 5Bh, 83h, 66h, 83h, 55h, 83h, 43h, 83h, 93h, 0
role02_en1:
	DB	62, 8
	DB	"Picture &", 0
role02_en2:
	DB	58, 9
	DB	"Character Design", 0
name02_jp:	; "亜久都　まお"
	DB	60, 11
	DB	88h, 9Fh, 8Bh, 76h, 93h, 73h, 81h, 40h, 82h, 0DCh, 82h, 0A8h, 0
name02_en:
	DB	62, 12
	DB	"Mao Act", 0

staffptrs_03:
	DW	role03_jp, role03_en, name03_jp, name03_en, 0
role03_jp:	; "システム監修"
	DB	6, 6
	DB	83h, 56h, 83h, 58h, 83h, 65h, 83h, 80h, 8Ah, 0C4h, 8Fh, 43h, 0
role03_en:
	DB	4, 7
	DB	"System Direction", 0
name03_jp:	; "岡地　常義"
	DB	7, 9
	DB	89h, 0AAh, 92h, 6Eh, 81h, 40h, 8Fh, 0EDh, 8Bh, 60h, 0
name03_en:
	DB	4, 10
	DB	"Tsuneyoshi Okachi", 0

staffptrs_04:
	DW	role04_jp, role04_en, name04_jp, name04_en, 0
role04_jp:	; "シナリオプログラム"
	DB	58, 6
	DB	83h, 56h, 83h, 69h, 83h, 8Ah, 83h, 49h, 83h, 76h, 83h, 8Dh, 83h, 4Fh, 83h, 89h, 83h, 80h, 0
role04_en:
	DB	59, 7
	DB	"Scenario Program", 0
name04_jp:	; "中谷　由司"
	DB	62, 9
	DB	92h, 86h, 92h, 4Ah, 81h, 40h, 97h, 52h, 8Eh, 69h, 0
name04_en:
	DB	61, 10
	DB	"Yuji Nakatani", 0

staffptrs_05:
	DW	role05_jp, role05_en, name05_jp, name05_en, 0
role05_jp:	; " プログラム　"
	DB	60, 6
	DB	" ", 83h, 76h, 83h, 8Dh, 83h, 4Fh, 83h, 89h, 83h, 80h, 81h, 40h, 0
role05_en:
	DB	63, 7
	DB	"Program", 0
name05_jp:	; " 佳　邦　"
	DB	62, 9
	DB	" ", 89h, 0C0h, 81h, 40h, 96h, 4Dh, 81h, 40h, 0
name05_en:
	DB	62, 10
	DB	"Yoshikuni", 0

staffptrs_06:
	DW	role06_jp, role06_en, name06_jp, name06_en, 0
role06_jp:	; "ＣＧデザイン"
	DB	7, 6
	DB	82h, 62h, 82h, 66h, 83h, 66h, 83h, 55h, 83h, 43h, 83h, 93h, 0
role06_en:
	DB	8, 7
	DB	"CG Design", 0
name06_jp:	; "末武　潤二"
	DB	8, 9
	DB	96h, 96h, 95h, 90h, 81h, 40h, 8Fh, 81h, 93h, 0F1h, 0
name06_en:
	DB	7, 10
	DB	"Junji Suetake", 0

staffptrs_07:
	DW	role07_jp, role07_en, name07_jp, name07_en, 0
role07_jp:	; "ＣＧデザイン"
	DB	7, 6
	DB	82h, 62h, 82h, 66h, 83h, 66h, 83h, 55h, 83h, 43h, 83h, 93h, 0
role07_en:
	DB	8, 7
	DB	"CG Design", 0
name07_jp:	; "松本　規之"
	DB	8, 9
	DB	8Fh, 0BCh, 96h, 7Bh, 81h, 40h, 8Bh, 4Bh, 94h, 56h, 0
name07_en:
	DB	4, 10
	DB	"Noriyuki Matsumoto", 0

staffptrs_08:
	DW	role08_jp, role08_en, name08_jp, name08_en, 0
role08_jp:	; "音楽"
	DB	11, 6
	DB	89h, 0B9h, 8Ah, 79h, 0
role08_en:
	DB	11, 7
	DB	"Music", 0
name08_jp:	; "金森　直幹"
	DB	8, 9
	DB	8Bh, 0E0h, 90h, 58h, 81h, 40h, 92h, 0BCh, 8Ah, 0B2h, 0
name08_en:
	DB	6, 10
	DB	"Naoki Kanamori", 0

staffptrs_09:
	DW	role09_jp, role09_en, name09_jp, name09_en, 0
role09_jp:	; "音楽制作"
	DB	61, 6
	DB	89h, 0B9h, 8Ah, 79h, 90h, 0A7h, 8Dh, 0ECh, 0
role09_en:
	DB	59, 7
	DB	"Music Produce", 0
name09_jp:	; "（有）ＭＵＳＥ"
	DB	58, 9
	DB	81h, 69h, 97h, 4Ch, 81h, 6Ah, 82h, 6Ch, 82h, 74h, 82h, 72h, 82h, 64h, 0
name09_en:
	DB	59, 10
	DB	"MUSE Co.,Ltd.", 0

staffptrs_10:
	DW	role10_jp, role10_en, name10_jp, name10_en, 0
role10_jp:	; "プロデューサー"
	DB	6, 6
	DB	83h, 76h, 83h, 8Dh, 83h, 66h, 83h, 85h, 81h, 5Bh, 83h, 54h, 81h, 5Bh, 0
role10_en:
	DB	9, 7
	DB	"Producer", 0
name10_jp:	; "田所　広成"
	DB	8, 9
	DB	93h, 63h, 8Fh, 8Ah, 81h, 40h, 8Dh, 4Ch, 90h, 0ACh, 0
name10_en:
	DB	5, 10
	DB	"Hironari Tadokoro", 0

staffptrs_11:
	DW	role11_jp1, role11_jp2, role11_en, name11_jp, name11_en, 0
role11_jp1:	; "エグゼクティブ"
	DB	6, 6
	DB	83h, 47h, 83h, 4Fh, 83h, 5Bh, 83h, 4Eh, 83h, 65h, 83h, 42h, 83h, 75h, 0
role11_jp2:	; "プロデューサー"
	DB	8, 7
	DB	83h, 76h, 83h, 8Dh, 83h, 66h, 83h, 85h, 81h, 5Bh, 83h, 54h, 81h, 5Bh, 0
role11_en:
	DB	5, 8
	DB	"Executive Producer", 0
name11_jp:	; "井手　健介"
	DB	8, 10
	DB	88h, 0E4h, 8Eh, 0E8h, 81h, 40h, 8Ch, 92h, 89h, 0EEh, 0
name11_en:
	DB	8, 11
	DB	"Kensuke Ide", 0

staffptrs_12:
	DW	role12_jp, name12_jp1, name12_jp2, role12_en, name12_en1, name12_en2, 0
role12_jp:	; "制作・著作"
	DB	8, 7
	DB	90h, 0A7h, 8Dh, 0ECh, 81h, 45h, 92h, 98h, 8Dh, 0ECh, 0
name12_jp1:	; "カクテルソフト"
	DB	6, 9
	DB	83h, 4Ah, 83h, 4Eh, 83h, 65h, 83h, 8Bh, 83h, 5Ch, 83h, 74h, 83h, 67h, 0
name12_jp2:	; "（有）アイデス"
	DB	6, 10
	DB	81h, 69h, 97h, 4Ch, 81h, 6Ah, 83h, 41h, 83h, 43h, 83h, 66h, 83h, 58h, 0
role12_en:	; "制作・著作"
	DB	62, 17
	DB	"Work Produce", 0
name12_en1:	; "カクテルソフト"
	DB	62, 19
	DB	"COCKTAIL SOFT", 0
name12_en2:	; "（有）アイデス"
	DB	62, 20
	DB	"IDES' CO,LTD.", 0


StaffClearPtrs:	; 1CA3h
	DW	stclear_left, stclear_right

stclear_left:
	DW	leftrow_6, leftrow_7, leftrow_8, leftrow_9, leftrow_10, leftrow_11, leftrow_12, 0
stclear_right:
	DW	rightrow_6, rightrow_7, rightrow_8, rightrow_9, rightrow_10, rightrow_11, rightrow_12, 0

	; clear staff text on the left side of the screen
leftrow_6:	; "　　　　　　　　　　"
	DB	4, 6	; x, y
	;DB	81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 0
	DB	"                    ", 0
leftrow_7:
	DB	4, 7
	DB	"                    ", 0
leftrow_8:
	DB	4, 8
	DB	"                    ", 0
leftrow_9:
	DB	4, 9
	DB	"                    ", 0
leftrow_10:
	DB	4, 10
	DB	"                    ", 0
leftrow_11:
	DB	4, 11
	DB	"                    ", 0
leftrow_12:
	DB	4, 12
	DB	"                    ", 0

	; clear staff text on the right side of the screen
rightrow_6:	; "　　　　　　　　　　"
	DB	56, 6
	;DB	81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 0
	DB	"                    ", 0
rightrow_7:
	DB	56, 7
	DB	"                    ", 0
rightrow_8:
	DB	56, 8
	DB	"                    ", 0
rightrow_9:
	DB	56, 9
	DB	"                    ", 0
rightrow_10:
	DB	56, 10
	DB	"                    ", 0
rightrow_11:
	DB	56, 11
	DB	"                    ", 0
rightrow_12:
	DB	56, 12
	DB	"                    ", 0


LyricsPtrs:	; 1D6Bh
	DW	txt_1D89	; 0 - This text is used to temporarily clear the lyrics line.
	DW	txt_1DB8	; 1
	DW	txt_1DE7	; 2
	DW	txt_1E16	; 3
	DW	txt_1E45	; 4
	DW	txt_1E74	; 5
	DW	txt_1EA3	; 6
	DW	txt_1ED2	; 7
	DW	txt_1F01	; 8
	DW	txt_1F30	; 9
	DW	txt_1F5F	; 10
	DW	txt_1F8E	; 11
	DW	txt_1FBD	; 12
	DW	txt_1FEC	; 13
	DW	txt_201B	; 14

txt_1D89:	; "　　　　　　　　　　　　　　　　　　　　　　"
	DW	lyrics00_jp, lyrics00_en1, lyrics00_en2, 0
lyrics00_jp:
	DB	18, 23	; x, y
	DB	81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 0
lyrics00_en1:
	DB	10, 20	; x, y
	DB	"                                                          ", 0
lyrics00_en2:
	DB	10, 21	; x, y
	DB	"                                                          ", 0

txt_1DB8:	; "　稲妻　とどろく夜に　甘い夢　恋が始まる　　"
	DW	lyrics01_jp, lyrics01_en1, lyrics01_en2, 0
lyrics01_jp:
	DB	18, 23	; x, y
	DB	81h, 40h, 88h, 0EEh, 8Dh, 0C8h, 81h, 40h, 82h, 0C6h, 82h, 0C7h, 82h, 0EBh, 82h, 0ADh, 96h, 0E9h, 82h, 0C9h, 81h, 40h, 8Ah, 0C3h, 82h, 0A2h, 96h, 0B2h, 81h, 40h, 97h, 0F6h, 82h, 0AAh, 8Eh, 6Eh, 82h, 0DCh, 82h, 0E9h, 81h, 40h, 81h, 40h, 0
lyrics01_en1:
	DB	14, 20	; x, y
	DB	"A lightning strike crackles through the lonely night,", 0
lyrics01_en2:
	DB	17, 21	; x, y
	DB	"as my sweet dreams kick off the blossom of love", 0

txt_1DE7:	; "　あなたの　腕に抱かれて　熱が出たみたい　　"
	DW	lyrics02_jp, lyrics02_en1, lyrics02_en2, 0
lyrics02_jp:
	DB	18, 23	; x, y
	DB	81h, 40h, 82h, 0A0h, 82h, 0C8h, 82h, 0BDh, 82h, 0CCh, 81h, 40h, 98h, 72h, 82h, 0C9h, 95h, 0F8h, 82h, 0A9h, 82h, 0EAh, 82h, 0C4h, 81h, 40h, 94h, 4Dh, 82h, 0AAh, 8Fh, 6Fh, 82h, 0BDh, 82h, 0DDh, 82h, 0BDh, 82h, 0A2h, 81h, 40h, 81h, 40h, 0
lyrics02_en1:
	DB	18, 20	; x, y
	DB	"And as you're swept up into my loving arms,", 0
lyrics02_en2:
	DB	25, 21	; x, y
	DB	"I can feel the heat bother me", 0

txt_1E16:	; "風邪薬も　効かないのよ　どうすればいいの？　"
	DW	lyrics03_jp, lyrics03_en1, lyrics03_en2, 0
lyrics03_jp:
	DB	18, 23	; x, y
	DB	95h, 97h, 8Eh, 0D7h, 96h, 0F2h, 82h, 0E0h, 81h, 40h, 8Ch, 0F8h, 82h, 0A9h, 82h, 0C8h, 82h, 0A2h, 82h, 0CCh, 82h, 0E6h, 81h, 40h, 82h, 0C7h, 82h, 0A4h, 82h, 0B7h, 82h, 0EAh, 82h, 0CEh, 82h, 0A2h, 82h, 0A2h, 82h, 0CCh, 81h, 48h, 81h, 40h, 0
lyrics03_en1:
	DB	10, 20	; x, y
	DB	"The pills I take for colds, why aren't they taking hold,", 0
lyrics03_en2:
	DB	24, 21	; x, y
	DB	"is there a doctor I should know?", 0

txt_1E45:	; "　チャージＯＮ！　プラズマフラーッシュ！　　"
	DW	lyrics04_jp, lyrics04_en, 0
lyrics04_jp:
	DB	18, 23	; x, y
	DB	81h, 40h, 83h, 60h, 83h, 83h, 81h, 5Bh, 83h, 57h, 82h, 6Eh, 82h, 6Dh, 81h, 49h, 81h, 40h, 83h, 76h, 83h, 89h, 83h, 59h, 83h, 7Dh, 83h, 74h, 83h, 89h, 81h, 5Bh, 83h, 62h, 83h, 56h, 83h, 85h, 81h, 49h, 81h, 40h, 81h, 40h, 0
lyrics04_en:
	DB	27, 21	; x, y
	DB	"Charge ON! Plasma Flash!", 0

txt_1E74:	; "　　　聴診器で聞いて　この胸のドキドキ　　　"
	DW	lyrics05_jp, lyrics05_en1, lyrics05_en2, 0
lyrics05_jp:
	DB	18, 23	; x, y
	DB	81h, 40h, 81h, 40h, 81h, 40h, 92h, 0AEh, 90h, 66h, 8Ah, 0EDh, 82h, 0C5h, 95h, 0B7h, 82h, 0A2h, 82h, 0C4h, 81h, 40h, 82h, 0B1h, 82h, 0CCh, 8Bh, 0B9h, 82h, 0CCh, 83h, 68h, 83h, 4Ch, 83h, 68h, 83h, 4Ch, 81h, 40h, 81h, 40h, 81h, 40h, 0
lyrics05_en1:
	DB	21, 20	; x, y
	DB	"You'll put your stethoscope up to me,", 0
lyrics05_en2:
	DB	19, 21	; x, y
	DB	"and what you'll find is my quick heartbeat", 0

txt_1EA3:	; "　　　ナース！　ナース！　電撃ナース！　　　"
	DW	lyrics06_jp, lyrics06_en, 0
lyrics06_jp:
	DB	18, 23	; x, y
	DB	81h, 40h, 81h, 40h, 81h, 40h, 83h, 69h, 81h, 5Bh, 83h, 58h, 81h, 49h, 81h, 40h, 83h, 69h, 81h, 5Bh, 83h, 58h, 81h, 49h, 81h, 40h, 93h, 64h, 8Ch, 82h, 83h, 69h, 81h, 5Bh, 83h, 58h, 81h, 49h, 81h, 40h, 81h, 40h, 81h, 40h, 0
lyrics06_en:
	DB	26, 21	; x, y
	DB	"Nurse! Nurse! Dengeki Nurse!", 0

txt_1ED2:	; "　　　ナース！　ナース！　電撃ナース！　　　"
	DW	lyrics07_jp, lyrics07_en, 0
lyrics07_jp:
	DB	18, 23	; x, y
	DB	81h, 40h, 81h, 40h, 81h, 40h, 83h, 69h, 81h, 5Bh, 83h, 58h, 81h, 49h, 81h, 40h, 83h, 69h, 81h, 5Bh, 83h, 58h, 81h, 49h, 81h, 40h, 93h, 64h, 8Ch, 82h, 83h, 69h, 81h, 5Bh, 83h, 58h, 81h, 49h, 81h, 40h, 81h, 40h, 81h, 40h, 0
lyrics07_en:
	DB	26, 21	; x, y
	DB	"Nurse! Nurse! Dengeki Nurse!", 0

txt_1F01:	; "稲妻　どしゃ降り雨の　交差点　ひとり待ってた"
	DW	lyrics08_jp, lyrics08_en1, lyrics08_en2, 0
lyrics08_jp:
	DB	18, 23	; x, y
	DB	88h, 0EEh, 8Dh, 0C8h, 81h, 40h, 82h, 0C7h, 82h, 0B5h, 82h, 0E1h, 8Dh, 7Eh, 82h, 0E8h, 89h, 4Ah, 82h, 0CCh, 81h, 40h, 8Ch, 0F0h, 8Dh, 0B7h, 93h, 5Fh, 81h, 40h, 82h, 0D0h, 82h, 0C6h, 82h, 0E8h, 91h, 0D2h, 82h, 0C1h, 82h, 0C4h, 82h, 0BDh, 0
lyrics08_en1:
	DB	16, 20	; x, y
	DB	"A lightning strike races past the pouring rain,", 0
lyrics08_en2:
	DB	17, 21	; x, y
	DB	"as I wait for you out at the crossroads alone", 0

txt_1F30:	; "　　あなたの　姿さがして　私びしょ濡れよ　　"
	DW	lyrics09_jp, lyrics09_en1, lyrics09_en2, 0
lyrics09_jp:
	DB	18, 23	; x, y
	DB	81h, 40h, 81h, 40h, 82h, 0A0h, 82h, 0C8h, 82h, 0BDh, 82h, 0CCh, 81h, 40h, 8Eh, 70h, 82h, 0B3h, 82h, 0AAh, 82h, 0B5h, 82h, 0C4h, 81h, 40h, 8Eh, 84h, 82h, 0D1h, 82h, 0B5h, 82h, 0E5h, 94h, 47h, 82h, 0EAh, 82h, 0E6h, 81h, 40h, 81h, 40h, 0
lyrics09_en1:
	DB	16, 20	; x, y
	DB	"And as I look for you through the showering pain,", 0
lyrics09_en2:
	DB	22, 21	; x, y
	DB	"I can feel my clothes getting soaked", 0

txt_1F5F:	; "風邪薬じゃ　治らないわ　すぐにここに来て！　"
	DW	lyrics10_jp, lyrics10_en1, lyrics10_en2, 0
lyrics10_jp:
	DB	18, 23	; x, y
	DB	95h, 97h, 8Eh, 0D7h, 96h, 0F2h, 82h, 0B6h, 82h, 0E1h, 81h, 40h, 8Eh, 0A1h, 82h, 0E7h, 82h, 0C8h, 82h, 0A2h, 82h, 0EDh, 81h, 40h, 82h, 0B7h, 82h, 0AEh, 82h, 0C9h, 82h, 0B1h, 82h, 0B1h, 82h, 0C9h, 97h, 88h, 82h, 0C4h, 81h, 49h, 81h, 40h, 0
lyrics10_en1:
	DB	14, 20	; x, y
	DB	"The pills I take ran out, those I took didn't help,", 0
lyrics10_en2:
	DB	20, 21	; x, y
	DB	"that's why I need you here right now!", 0

txt_1F8E:	; "　チャージＯＮ！　プラズマフラーッシュ！　　"
	DW	lyrics11_jp, lyrics11_en, 0
lyrics11_jp:
	DB	18, 23	; x, y
	DB	81h, 40h, 83h, 60h, 83h, 83h, 81h, 5Bh, 83h, 57h, 82h, 6Eh, 82h, 6Dh, 81h, 49h, 81h, 40h, 83h, 76h, 83h, 89h, 83h, 59h, 83h, 7Dh, 83h, 74h, 83h, 89h, 81h, 5Bh, 83h, 62h, 83h, 56h, 83h, 85h, 81h, 49h, 81h, 40h, 81h, 40h, 0
lyrics11_en:
	DB	27, 21	; x, y
	DB	"Charge ON! Plasma Flash!", 0

txt_1FBD:	; "　バンドエイド貼ってよ　この胸のチクチク　　"
	DW	lyrics12_jp, lyrics12_en1, lyrics12_en2, 0
lyrics12_jp:
	DB	18, 23	; x, y
	DB	81h, 40h, 83h, 6Fh, 83h, 93h, 83h, 68h, 83h, 47h, 83h, 43h, 83h, 68h, 93h, 5Ch, 82h, 0C1h, 82h, 0C4h, 82h, 0E6h, 81h, 40h, 82h, 0B1h, 82h, 0CCh, 8Bh, 0B9h, 82h, 0CCh, 83h, 60h, 83h, 4Eh, 83h, 60h, 83h, 4Eh, 81h, 40h, 81h, 40h, 0
lyrics12_en1:
	DB	23, 20	; x, y
	DB	"Why don't you open a plaster up", 0
lyrics12_en2:
	DB	20, 21	; x, y
	DB	"and slap it right on my tingling heart", 0 ; thanks mei

txt_1FEC:	; "　　　ナース！　ナース！　電撃ナース！　　　"
	DW	lyrics13_jp, lyrics13_en, 0
lyrics13_jp:
	DB	18, 23	; x, y
	DB	81h, 40h, 81h, 40h, 81h, 40h, 83h, 69h, 81h, 5Bh, 83h, 58h, 81h, 49h, 81h, 40h, 83h, 69h, 81h, 5Bh, 83h, 58h, 81h, 49h, 81h, 40h, 93h, 64h, 8Ch, 82h, 83h, 69h, 81h, 5Bh, 83h, 58h, 81h, 49h, 81h, 40h, 81h, 40h, 81h, 40h, 0
lyrics13_en:
	DB	26, 21	; x, y
	DB	"Nurse! Nurse! Dengeki Nurse!", 0

txt_201B:	; "　　　ナース！　ナース！　電撃ナース！　　　"
	DW	lyrics14_jp, lyrics14_en, 0
lyrics14_jp:
	DB	18, 23	; x, y
	DB	81h, 40h, 81h, 40h, 81h, 40h, 83h, 69h, 81h, 5Bh, 83h, 58h, 81h, 49h, 81h, 40h, 83h, 69h, 81h, 5Bh, 83h, 58h, 81h, 49h, 81h, 40h, 93h, 64h, 8Ch, 82h, 83h, 69h, 81h, 5Bh, 83h, 58h, 81h, 49h, 81h, 40h, 81h, 40h, 81h, 40h, 0
lyrics14_en:
	DB	26, 21	; x, y
	DB	"Nurse! Nurse! Dengeki Nurse!", 0

karPtrs_204A:
	DW	kar_2078	; 0
	DW	kar_207C	; 1
	DW	kar_2080	; 2
	DW	kar_2084	; 3
	DW	kar_2088	; 4
	DW	kar_208E	; 5
	DW	kar_2094	; 6
	DW	kar_209A	; 7
	DW	kar_20A0	; 8
	DW	kar_20A4	; 9
	DW	kar_20A8	; 10
	DW	kar_20AE	; 11
	DW	kar_20B2	; 12
	DW	kar_20B6	; 13
	DW	kar_20BC	; 14
	DW	kar_20C0	; 15
	DW	kar_20C4	; 16
	DW	kar_20C8	; 17
	DW	kar_20CC	; 18
	DW	kar_20D2	; 19
	DW	kar_20D6	; 20
	DW	kar_20DA	; 21
	DW	kar_20E0	; 22
kar_2078:
	COLCHG	20, 23, 1	; い - x, y, width
	COLCHG	14, 20, 1	; A_
	COLCHG_END
kar_207C:
	COLCHG	21, 23, 1	; な
	COLCHG	16, 20, 5	; light
	COLCHG_END
kar_2080:
	COLCHG	22, 23, 1	; ず
	COLCHG	21, 20, 4	; ning_
	COLCHG_END
kar_2084:
	COLCHG	23, 23, 1	; ま
	COLCHG	26, 20, 6	; strike_
	COLCHG_END
kar_2088:
	COLCHG	26, 23, 2	; と
	COLCHG	33, 20, 3	; cra
	COLCHG_END
kar_208E:
	COLCHG	28, 23, 2	; ど
	COLCHG	36, 20, 5	; ckles_
	COLCHG_END
kar_2094:
	COLCHG	30, 23, 2	; ろ
	COLCHG	42, 20, 7	; through_
	COLCHG_END
kar_209A:
	COLCHG	32, 23, 2	; く
	COLCHG	50, 20, 3	; the_
	COLCHG_END
kar_20A0:
	COLCHG	34, 23, 1	; よ
	COLCHG	54, 20, 4	; lone
	COLCHG_END
kar_20A4:
	COLCHG	35, 23, 1	; る
	COLCHG	58, 20, 2	; ly_
	COLCHG_END
kar_20A8:
	COLCHG	36, 23, 2	; に
	COLCHG	61, 20, 6	; night,
	COLCHG_END
kar_20AE:
	COLCHG	40, 23, 1	; あ
	COLCHG	17, 21, 2	; as_
	COLCHG_END
kar_20B2:
	COLCHG	41, 23, 1	; ま
	COLCHG	20, 21, 2	; my_
	COLCHG_END
kar_20B6:
	COLCHG	42, 23, 2	; い
	COLCHG	23, 21, 3	; swe
	COLCHG_END
kar_20BC:
	COLCHG	44, 23, 1	; ゆ
	COLCHG	26, 21, 2	; et_
	COLCHG_END
kar_20C0:
	COLCHG	45, 23, 1	; め
	COLCHG	29, 21, 6	; dreams_
	COLCHG_END
kar_20C4:
	COLCHG	48, 23, 1	; こ
	COLCHG	36, 21, 4	; kick_
	COLCHG_END
kar_20C8:
	COLCHG	49, 23, 1	; い
	COLCHG	41, 21, 3	; off_
	COLCHG_END
kar_20CC:
	COLCHG	50, 23, 2	; が
	COLCHG	45, 21, 3	; the_
	COLCHG_END
kar_20D2:
	COLCHG	52, 23, 1	; は
	COLCHG	49, 21, 3	; blo
	COLCHG_END
kar_20D6:
	COLCHG	53, 23, 1	; じ
	COLCHG	52, 21, 4	; ssom_
	COLCHG_END
kar_20DA:
	COLCHG	54, 23, 2	; ま
	COLCHG	57, 21, 2	; of_
	COLCHG_END
kar_20E0:
	COLCHG	56, 23, 2	; る
	COLCHG	60, 21, 4	; love
	COLCHG_END
karPtrs_20E6:
	DW	kar_210C	; 0
	DW	kar_2112	; 1
	DW	kar_2118	; 2
	DW	kar_211E	; 3
	DW	kar_2124	; 4
	DW	kar_2128	; 5
	DW	kar_212C	; 6
	DW	kar_2132	; 7
	DW	kar_2138	; 8
	DW	kar_213E	; 9
	DW	kar_2144	; 10
	DW	kar_214A	; 11
	DW	kar_214E	; 12
	DW	kar_2152	; 13
	DW	kar_2158	; 14
	DW	kar_215E	; 15
	DW	kar_2164	; 16
	DW	kar_216A	; 17
	DW	kar_2170	; 18
kar_210C:
	COLCHG	20, 23, 2	; あ
	COLCHG	18, 20, 3	; And_
	COLCHG_END
kar_2112:
	COLCHG	22, 23, 2	; な
	COLCHG	22, 20, 2	; as_
	COLCHG_END
kar_2118:
	COLCHG	24, 23, 2	; た
	COLCHG	25, 20, 6	; you're_
	COLCHG_END
kar_211E:
	COLCHG	26, 23, 2	; の
	COLCHG	32, 20, 5	; swept_
	COLCHG_END
kar_2124:
	COLCHG	30, 23, 1	; う
	COLCHG	38, 20, 2	; up_
	COLCHG_END
kar_2128:
	COLCHG	31, 23, 1	; で
	COLCHG	41, 20, 2	; in
	COLCHG_END
kar_212C:
	COLCHG	32, 23, 2	; にい
	COLCHG	43, 20, 2	; to_
	COLCHG_END
kar_2132:
	COLCHG	34, 23, 2	; だ
	COLCHG	46, 20, 2	; my_
	COLCHG_END
kar_2138:
	COLCHG	36, 23, 2	; か
	COLCHG	49, 20, 2	; do
	COLCHG_END
kar_213E:
	COLCHG	38, 23, 2	; れ
	COLCHG	51, 20, 4	; ting_
	COLCHG_END
kar_2144:
	COLCHG	40, 23, 2	; て
	COLCHG	56, 20, 5	; arms,
	COLCHG_END
kar_214A:
	COLCHG	44, 23, 1	; ね
	COLCHG	25, 21, 1	; I_
	COLCHG_END
kar_214E:
	COLCHG	45, 23, 1	; つ
	COLCHG	27, 21, 3	; can_
	COLCHG_END
kar_2152:
	COLCHG	46, 23, 2	; が
	COLCHG	31, 21, 4	; feel_
	COLCHG_END
kar_2158:
	COLCHG	48, 23, 2	; で
	COLCHG	36, 21, 3	; the_
	COLCHG_END
kar_215E:
	COLCHG	50, 23, 2	; た
	COLCHG	40, 21, 4	; heat_
	COLCHG_END
kar_2164:
	COLCHG	52, 23, 2	; み
	COLCHG	45, 21, 2	; bo
	COLCHG_END
kar_216A:
	COLCHG	54, 23, 2	; た
	COLCHG	47, 21, 4	; ther_
	COLCHG_END
kar_2170:
	COLCHG	56, 23, 2	; い
	COLCHG	52, 21, 2	; me
	COLCHG_END
karPtrs_2176:
	DW	kar_219C	; 0
	DW	kar_21A2	; 1
	DW	kar_21A8	; 2
	DW	kar_21AC	; 3
	DW	kar_21B0	; 4
	DW	kar_21B6	; 5
	DW	kar_21BC	; 6
	DW	kar_21C2	; 7
	DW	kar_21C8	; 8
	DW	kar_21CE	; 9
	DW	kar_21D4	; 10
	DW	kar_21DA	; 11
	DW	kar_21E0	; 12
	DW	kar_21E6	; 13
	DW	kar_21EC	; 14
	DW	kar_21F2	; 15
	DW	kar_21F8	; 16
	DW	kar_21FE	; 17
	DW	kar_2204	; 18
kar_219C:
	COLCHG	18, 23, 2	; か
	COLCHG	10, 20, 3	; The_
	COLCHG_END
kar_21A2:
	COLCHG	20, 23, 2	; ぜ
	COLCHG	14, 20, 5	; pills_
	COLCHG_END
kar_21A8:
	COLCHG	22, 23, 1	; ぐ
	COLCHG	20, 20, 1	; I_
	COLCHG_END
kar_21AC:
	COLCHG	23, 23, 1	; す
	COLCHG	22, 20, 4	; take_
	COLCHG_END
kar_21B0:
	COLCHG	24, 23, 2	; りも
	COLCHG	27, 20, 10	; for colds,_
	COLCHG_END
kar_21B6:
	COLCHG	28, 23, 2	; き
	COLCHG	38, 20, 3	; why_
	COLCHG_END
kar_21BC:
	COLCHG	30, 23, 2	; か
	COLCHG	42, 20, 6	; aren't_
	COLCHG_END
kar_21C2:
	COLCHG	32, 23, 2	; な
	COLCHG	49, 20, 4	; they_
	COLCHG_END
kar_21C8:
	COLCHG	34, 23, 2	; い
	COLCHG	54, 20, 2	; ta
	COLCHG_END
kar_21CE:
	COLCHG	36, 23, 2	; の
	COLCHG	56, 20, 4	; king_
	COLCHG_END
kar_21D4:
	COLCHG	38, 23, 2	; よ
	COLCHG	61, 20, 5	; hold,
	COLCHG_END
kar_21DA:
	COLCHG	42, 23, 2	; ど
	COLCHG	24, 21, 2	; Is_
	COLCHG_END
kar_21E0:
	COLCHG	44, 23, 2	; う
	COLCHG	27, 21, 5	; there_
	COLCHG_END
kar_21E6:
	COLCHG	46, 23, 2	; す
	COLCHG	33, 21, 1	; a_
	COLCHG_END
kar_21EC:
	COLCHG	48, 23, 2	; れ
	COLCHG	35, 21, 3	; doc
	COLCHG_END
kar_21F2:
	COLCHG	50, 23, 2	; ば
	COLCHG	38, 21, 3	; tor_
	COLCHG_END
kar_21F8:
	COLCHG	52, 23, 2	; い
	COLCHG	42, 21, 1	; I_
	COLCHG_END
kar_21FE:
	COLCHG	54, 23, 2	; い
	COLCHG	44, 21, 6	; should_
	COLCHG_END
kar_2204:
	COLCHG	56, 23, 4	; の？
	COLCHG	51, 21, 5	; know?
	COLCHG_END
karPtrs_220E:
	DW	kar_222E	; 0
	DW	kar_2234	; 1
	DW	kar_223A	; 2
	DW	kar_2240	; 3
	DW	kar_2246	; 4
	DW	kar_224C	; 5
	DW	kar_2256	; 6
	DW	kar_225C	; 7
	DW	kar_2262	; 8
	DW	kar_2268	; 9
	DW	kar_226E	; 10
	DW	kar_2274	; 11
	DW	kar_227A	; 12
	DW	kar_2280	; 13
	DW	kar_2286	; 14
	DW	kar_228C	; 15
kar_222E:
	COLCHG	20, 23, 2	; チ
	COLCHG	27, 21, 2	; Ch
	COLCHG_END
kar_2234:
	COLCHG	22, 23, 2	; ャ
	COLCHG	29, 21, 1	; a
	COLCHG_END
kar_223A:
	COLCHG	24, 23, 2	; ー
	COLCHG	30, 21, 1	; r
	COLCHG_END
kar_2240:
	COLCHG	26, 23, 2	; ジ
	COLCHG	31, 21, 2	; ge_
	COLCHG_END
kar_2246:
	COLCHG	28, 23, 2	; Ｏ
	COLCHG	34, 21, 1	; O
	COLCHG_END
kar_224C:
	COLCHG	30, 23, 4	; Ｎ！
	COLCHG	35, 21, 2	; N!_
	COLCHG_END
kar_2256:
	COLCHG	36, 23, 2	; プ
	COLCHG	38, 21, 2	; Pl
	COLCHG_END
kar_225C:
	COLCHG	38, 23, 2	; ラ
	COLCHG	40, 21, 1	; a
	COLCHG_END
kar_2262:
	COLCHG	40, 23, 2	; ズ
	COLCHG	41, 21, 1	; s
	COLCHG_END
kar_2268:
	COLCHG	42, 23, 2	; マ
	COLCHG	42, 21, 2	; ma_
	COLCHG_END
kar_226E:
	COLCHG	44, 23, 2	; フ
	COLCHG	45, 21, 1	; F
	COLCHG_END
kar_2274:
	COLCHG	46, 23, 2	; ラ
	COLCHG	46, 21, 1	; l
	COLCHG_END
kar_227A:
	COLCHG	48, 23, 2	; ー
	COLCHG	47, 21, 1	; a
	COLCHG_END
kar_2280:
	COLCHG	50, 23, 2	; ッ
	COLCHG	48, 21, 1	; s
	COLCHG_END
kar_2286:
	COLCHG	52, 23, 2	; シ
	COLCHG	49, 21, 1	; h
	COLCHG_END
kar_228C:
	COLCHG	54, 23, 4	; ュ！
	COLCHG	50, 21, 1	; !
	COLCHG_END
karPtrs_2296:
	DW	kar_22BA	; 0
	DW	kar_22BE	; 1
	DW	kar_22C2	; 2
	DW	kar_22C6	; 3
	DW	kar_22CA	; 4
	DW	kar_22D0	; 5
	DW	kar_22D6	; 6
	DW	kar_22DC	; 7
	DW	kar_22E2	; 8
	DW	kar_22E8	; 9
	DW	kar_22EE	; 10
	DW	kar_22F4	; 11
	DW	kar_22F8	; 12
	DW	kar_22FC	; 13
	DW	kar_2302	; 14
	DW	kar_2308	; 15
	DW	kar_230E	; 16
	DW	kar_2314	; 17
kar_22BA:
	COLCHG	24, 23, 1	; ち
	COLCHG	21, 20, 6	; You'll_
	COLCHG_END
kar_22BE:
	COLCHG	25, 23, 1	; ょ
	COLCHG	28, 20, 3	; put_
	COLCHG_END
kar_22C2:
	COLCHG	26, 23, 1	; う
	COLCHG	32, 20, 4	; your_
	COLCHG_END
kar_22C6:
	COLCHG	27, 23, 1	; しん
	COLCHG	37, 20, 3	; ste
	COLCHG_END
kar_22CA:
	COLCHG	28, 23, 2	; き
	COLCHG	40, 20, 3	; tho
	COLCHG_END
kar_22D0:
	COLCHG	30, 23, 2	; で
	COLCHG	43, 20, 5	; scope_
	COLCHG_END
kar_22D6:
	COLCHG	32, 23, 2	; き
	COLCHG	49, 20, 2	; up_
	COLCHG_END
kar_22DC:
	COLCHG	34, 23, 2	; い
	COLCHG	52, 20, 2	; to_
	COLCHG_END
kar_22E2:
	COLCHG	36, 23, 2	; て
	COLCHG	55, 20, 3	; me,
	COLCHG_END
kar_22E8:
	COLCHG	40, 23, 2	; こ
	COLCHG	19, 21, 3	; And_
	COLCHG_END
kar_22EE:
	COLCHG	42, 23, 2	; の
	COLCHG	23, 21, 4	; what_
	COLCHG_END
kar_22F4:
	COLCHG	44, 23, 1	; む
	COLCHG	28, 21, 6	; you'll_
	COLCHG_END
kar_22F8:
	COLCHG	45, 23, 1	; ね
	COLCHG	35, 21, 4	; find_
	COLCHG_END
kar_22FC:
	COLCHG	46, 23, 2	; の
	COLCHG	40, 21, 2	; is_
	COLCHG_END
kar_2302:
	COLCHG	48, 23, 2	; ド
	COLCHG	43, 21, 2	; my_
	COLCHG_END
kar_2308:
	COLCHG	50, 23, 2	; キ
	COLCHG	46, 21, 5	; quick_
	COLCHG_END
kar_230E:
	COLCHG	52, 23, 2	; ド
	COLCHG	52, 21, 5	; heart
	COLCHG_END
kar_2314:
	COLCHG	54, 23, 2	; キ
	COLCHG	57, 21, 4	; beat
	COLCHG_END
karPtrs_231A:
	DW	kar_2334	; 0
	DW	kar_233A	; 1
	DW	kar_2340	; 2
	DW	kar_234A	; 3
	DW	kar_2350	; 4
	DW	kar_2356	; 5
	DW	kar_2360	; 6
	DW	kar_2364	; 7
	DW	kar_2368	; 8
	DW	kar_236C	; 9
	DW	kar_2370	; 10
	DW	kar_2376	; 11
	DW	kar_237C	; 12
kar_2334:
	COLCHG	24, 23, 2	; ナ
	COLCHG	26, 21, 2	; Nu
	COLCHG_END
kar_233A:
	COLCHG	26, 23, 2	; ー
	COLCHG	28, 21, 1	; r
	COLCHG_END
kar_2340:
	COLCHG	28, 23, 4	; ス！
	COLCHG	29, 21, 3	; se!_
	COLCHG_END
kar_234A:
	COLCHG	34, 23, 2	; ナ
	COLCHG	33, 21, 2	; Nu
	COLCHG_END
kar_2350:
	COLCHG	36, 23, 2	; ー
	COLCHG	35, 21, 1	; r
	COLCHG_END
kar_2356:
	COLCHG	38, 23, 4	; ス！
	COLCHG	36, 21, 3	; se!_
	COLCHG_END
kar_2360:
	COLCHG	44, 23, 1	; で
	COLCHG	40, 21, 2	; De
	COLCHG_END
kar_2364:
	COLCHG	45, 23, 1	; ん
	COLCHG	42, 21, 1	; n
	COLCHG_END
kar_2368:
	COLCHG	46, 23, 1	; げ
	COLCHG	43, 21, 2	; ge
	COLCHG_END
kar_236C:
	COLCHG	47, 23, 1	; き
	COLCHG	45, 21, 2	; ki_
	COLCHG_END
kar_2370:
	COLCHG	48, 23, 2	; ナ
	COLCHG	48, 21, 2	; Nu
	COLCHG_END
kar_2376:
	COLCHG	50, 23, 2	; ー
	COLCHG	50, 21, 1	; r
	COLCHG_END
kar_237C:
	COLCHG	52, 23, 4	; ス！
	COLCHG	51, 21, 3	; se!
	COLCHG_END
karPtrs_2386:
	DW	kar_23B4	; 0
	DW	kar_23B8	; 1
	DW	kar_23BC	; 2
	DW	kar_23C0	; 3
	DW	kar_23C4	; 4
	DW	kar_23CA	; 5
	DW	kar_23D4	; 6
	DW	kar_23DA	; 7
	DW	kar_23E0	; 8
	DW	kar_23E4	; 9
	DW	kar_23E8	; 10
	DW	kar_23EE	; 11
	DW	kar_23F2	; 12
	DW	kar_23F6	; 13
	DW	kar_23FC	; 14
	DW	kar_2400	; 15
	DW	kar_2404	; 16
	DW	kar_240A	; 17
	DW	kar_2410	; 18
	DW	kar_2416	; 19
	DW	kar_241C	; 20
	DW	kar_2422	; 21
	DW	kar_2428	; 22
kar_23B4:
	COLCHG	18, 23, 1	; い
	COLCHG	16, 20, 1	; A_
	COLCHG_END
kar_23B8:
	COLCHG	19, 23, 1	; な
	COLCHG	18, 20, 5	; light
	COLCHG_END
kar_23BC:
	COLCHG	20, 23, 1	; ず
	COLCHG	23, 20, 4	; ning_
	COLCHG_END
kar_23C0:
	COLCHG	21, 23, 1	; ま
	COLCHG	28, 20, 6	; strike_
	COLCHG_END
kar_23C4:
	COLCHG	24, 23, 2	; ど
	COLCHG	35, 20, 2	; ra
	COLCHG_END
kar_23CA:
	COLCHG	26, 23, 4	; しゃ
	COLCHG	37, 20, 3	; ces_
	COLCHG_END
kar_23D4:
	COLCHG	30, 23, 2	; ぶ
	COLCHG	41, 20, 4	; past_
	COLCHG_END
kar_23DA:
	COLCHG	32, 23, 2	; り
	COLCHG	46, 20, 3	; the_
	COLCHG_END
kar_23E0:
	COLCHG	34, 23, 1	; あ
	COLCHG	50, 20, 3	; pou
	COLCHG_END
kar_23E4:
	COLCHG	35, 23, 1	; め
	COLCHG	53, 20, 4	; ring_
	COLCHG_END
kar_23E8:
	COLCHG	36, 23, 2	; の
	COLCHG	58, 20, 5	; rain,
	COLCHG_END
kar_23EE:
	COLCHG	40, 23, 1	; こ
	COLCHG	17, 21, 2	; as_
	COLCHG_END
kar_23F2:
	COLCHG	41, 23, 1	; う
	COLCHG	20, 21, 1	; I_
	COLCHG_END
kar_23F6:
	COLCHG	42, 23, 2	; さ
	COLCHG	22, 21, 4	; wait_
	COLCHG_END
kar_23FC:
	COLCHG	44, 23, 1	; て
	COLCHG	27, 21, 3	; for_
	COLCHG_END
kar_2400:
	COLCHG	45, 23, 1	; ん
	COLCHG	31, 21, 3	; you_
	COLCHG_END
kar_2404:
	COLCHG	48, 23, 2	; ひ
	COLCHG	35, 21, 3	; out_
	COLCHG_END
kar_240A:
	COLCHG	50, 23, 2	; と
	COLCHG	39, 21, 2	; at_
	COLCHG_END
kar_2410:
	COLCHG	52, 23, 2	; り
	COLCHG	42, 21, 3	; the_
	COLCHG_END
kar_2416:
	COLCHG	54, 23, 2	; ま
	COLCHG	46, 21, 5	; cross
	COLCHG_END
kar_241C:
	COLCHG	56, 23, 2	; っ
	COLCHG	51, 21, 5	; roads_
	COLCHG_END
kar_2422:
	COLCHG	58, 23, 2	; て
	COLCHG	57, 21, 1	; a
	COLCHG_END
kar_2428:
	COLCHG	60, 23, 2	; た
	COLCHG	58, 21, 4	; lone
	COLCHG_END
karPtrs_242E:
	DW	kar_2450	; 0
	DW	kar_2456	; 1
	DW	kar_245C	; 2
	DW	kar_2462	; 3
	DW	kar_2468	; 4
	DW	kar_246C	; 5
	DW	kar_2470	; 6
	DW	kar_2476	; 7
	DW	kar_247C	; 8
	DW	kar_2482	; 9
	DW	kar_2488	; 10
	DW	kar_248C	; 11
	DW	kar_2490	; 12
	DW	kar_2496	; 13
	DW	kar_24A0	; 14
	DW	kar_24A6	; 15
	DW	kar_24AC	; 16
kar_2450:
	COLCHG	22, 23, 2	; あ
	COLCHG	16, 20, 3	; And_
	COLCHG_END
kar_2456:
	COLCHG	24, 23, 2	; な
	COLCHG	20, 20, 2	; as_
	COLCHG_END
kar_245C:
	COLCHG	26, 23, 2	; た
	COLCHG	23, 20, 1	; I_
	COLCHG_END
kar_2462:
	COLCHG	28, 23, 2	; の
	COLCHG	25, 20, 4	; look_
	COLCHG_END
kar_2468:
	COLCHG	32, 23, 1	; す
	COLCHG	30, 20, 3	; for_
	COLCHG_END
kar_246C:
	COLCHG	33, 23, 1	; がた
	COLCHG	34, 20, 11	; you through_
	COLCHG_END
kar_2470:
	COLCHG	34, 23, 2	; さ
	COLCHG	46, 20, 3	; the_
	COLCHG_END
kar_2476:
	COLCHG	36, 23, 2	; が
	COLCHG	50, 20, 4	; show
	COLCHG_END
kar_247C:
	COLCHG	38, 23, 2	; し
	COLCHG	54, 20, 5	; ering_
	COLCHG_END
kar_2482:
	COLCHG	40, 23, 2	; て
	COLCHG	60, 20, 5	; pain,
	COLCHG_END
kar_2488:
	COLCHG	44, 23, 1	; わ
	COLCHG	22, 21, 1	; I_
	COLCHG_END
kar_248C:
	COLCHG	45, 23, 1	; たし
	COLCHG	24, 21, 8	; can feel_
	COLCHG_END
kar_2490:
	COLCHG	46, 23, 2	; び
	COLCHG	33, 21, 2	; my_
	COLCHG_END
kar_2496:
	COLCHG	48, 23, 4	; しょ
	COLCHG	36, 21, 7	; clothes_
	COLCHG_END
kar_24A0:
	COLCHG	52, 23, 2	; ぬ
	COLCHG	44, 21, 3	; get
	COLCHG_END
kar_24A6:
	COLCHG	54, 23, 2	; れ
	COLCHG	47, 21, 4	; ting_
	COLCHG_END
kar_24AC:
	COLCHG	56, 23, 2	; よ
	COLCHG	52, 21, 6	; soaked
	COLCHG_END
karPtrs_24B2:
	DW	kar_24D8	; 0
	DW	kar_24DE	; 1
	DW	kar_24E4	; 2
	DW	kar_24E8	; 3
	DW	kar_24EC	; 4
	DW	kar_24F6	; 5
	DW	kar_24FA	; 6
	DW	kar_24FE	; 7
	DW	kar_2504	; 8
	DW	kar_250A	; 9
	DW	kar_2510	; 10
	DW	kar_2516	; 11
	DW	kar_251C	; 12
	DW	kar_2522	; 13
	DW	kar_2528	; 14
	DW	kar_252E	; 15
	DW	kar_2534	; 16
	DW	kar_253A	; 17
	DW	kar_2540	; 18
kar_24D8:
	COLCHG	18, 23, 2	; か
	COLCHG	14, 20, 3	; The_
	COLCHG_END
kar_24DE:
	COLCHG	20, 23, 2	; ぜ
	COLCHG	18, 20, 5	; pills_
	COLCHG_END
kar_24E4:
	COLCHG	22, 23, 1	; く
	COLCHG	24, 20, 1	; I_
	COLCHG_END
kar_24E8:
	COLCHG	23, 23, 1	; すり
	COLCHG	26, 20, 8	; take ran_
	COLCHG_END
kar_24EC:
	COLCHG	24, 23, 4	; じゃ
	COLCHG	35, 20, 4	; out,_
	COLCHG_END
kar_24F6:
	COLCHG	30, 23, 1	; な
	COLCHG	40, 20, 5	; those_
	COLCHG_END
kar_24FA:
	COLCHG	31, 23, 1	; お
	COLCHG	46, 20, 1	; I_
	COLCHG_END
kar_24FE:
	COLCHG	32, 23, 2	; ら
	COLCHG	48, 20, 4	; took_
	COLCHG_END
kar_2504:
	COLCHG	34, 23, 2	; な
	COLCHG	53, 20, 2	; di
	COLCHG_END
kar_250A:
	COLCHG	36, 23, 2	; い
	COLCHG	55, 20, 4	; dn't_
	COLCHG_END
kar_2510:
	COLCHG	38, 23, 2	; わ
	COLCHG	60, 20, 5	; help,_
	COLCHG_END
kar_2516:
	COLCHG	42, 23, 2	; す
	COLCHG	20, 21, 6	; that's_
	COLCHG_END
kar_251C:
	COLCHG	44, 23, 2	; ぐ
	COLCHG	27, 21, 3	; why_
	COLCHG_END
kar_2522:
	COLCHG	46, 23, 2	; に
	COLCHG	31, 21, 1	; I_
	COLCHG_END
kar_2528:
	COLCHG	48, 23, 2	; こ
	COLCHG	33, 21, 4	; need_
	COLCHG_END
kar_252E:
	COLCHG	50, 23, 2	; こ
	COLCHG	38, 21, 3	; you_
	COLCHG_END
kar_2534:
	COLCHG	52, 23, 2	; に
	COLCHG	42, 21, 4	; here_
	COLCHG_END
kar_253A:
	COLCHG	54, 23, 2	; き
	COLCHG	47, 21, 5	; right_
	COLCHG_END
kar_2540:
	COLCHG	56, 23, 4	; て！
	COLCHG	53, 21, 4	; now!
	COLCHG_END
karPtrs_254A:
	DW	kar_2570	; 0
	DW	kar_2576	; 1
	DW	kar_257C	; 2
	DW	kar_2582	; 3
	DW	kar_2588	; 4
	DW	kar_258E	; 5
	DW	kar_2594	; 6
	DW	kar_259A	; 7
	DW	kar_25A0	; 8
	DW	kar_25A6	; 9
	DW	kar_25AC	; 10
	DW	kar_25B2	; 11
	DW	kar_25B8	; 12
	DW	kar_25BC	; 13
	DW	kar_25C0	; 14
	DW	kar_25C6	; 15
	DW	kar_25CC	; 16
	DW	kar_25D2	; 17
	DW	kar_25D8	; 18
kar_2570:
	COLCHG	20, 23, 2	; バ
	COLCHG	23, 20, 3	; Why_
	COLCHG_END
kar_2576:
	COLCHG	22, 23, 2	; ン
	COLCHG	27, 20, 5	; don't_
	COLCHG_END
kar_257C:
	COLCHG	24, 23, 2	; ド
	COLCHG	33, 20, 3	; you_
	COLCHG_END
kar_2582:
	COLCHG	26, 23, 2	; エ
	COLCHG	37, 20, 1	; o
	COLCHG_END
kar_2588:
	COLCHG	28, 23, 2	; イ
	COLCHG_END
kar_258E:
	COLCHG	30, 23, 2	; ド
	COLCHG	38, 20, 3	; pen_
	COLCHG_END
kar_2594:
	COLCHG	32, 23, 2	; は
	COLCHG	42, 20, 1	; a_
	COLCHG_END
kar_259A:
	COLCHG	34, 23, 2	; っ
	COLCHG	44, 20, 3	; pla
	COLCHG_END
kar_25A0:
	COLCHG	36, 23, 2	; て
	COLCHG	47, 20, 4	; ster_
	COLCHG_END
kar_25A6:
	COLCHG	38, 23, 2	; よ
	COLCHG	52, 20, 3	; up,
	COLCHG_END
kar_25AC:
	COLCHG	42, 23, 2	; こ
	COLCHG	20, 21, 3	; and_
	COLCHG_END
kar_25B2:
	COLCHG	44, 23, 2	; の
	COLCHG	24, 21, 4	; slap_
	COLCHG_END
kar_25B8:
	COLCHG	46, 23, 1	; む
	COLCHG	29, 21, 2	; it_
	COLCHG_END
kar_25BC:
	COLCHG	47, 23, 1	; ね
	COLCHG	32, 21, 5	; right_
	COLCHG_END
kar_25C0:
	COLCHG	48, 23, 2	; の
	COLCHG	38, 21, 2	; on_
	COLCHG_END
kar_25C6:
	COLCHG	50, 23, 2	; チ
	COLCHG	41, 21, 2	; my_
	COLCHG_END
kar_25CC:
	COLCHG	52, 23, 2	; ク
	COLCHG	44, 21, 3	; tin
	COLCHG_END
kar_25D2:
	COLCHG	54, 23, 2	; チ
	COLCHG	47, 21, 5	; gling_
	COLCHG_END
kar_25D8:
	COLCHG	56, 23, 2	; ク
	COLCHG	53, 21, 5	; heart
	COLCHG_END

txt_25DE:	; "Ｈｉｔ　Ｒｅｔｕｒｎ　Ｋｅｙ"
	DB	50, 22	; x, y
	DB	82h, 67h, 82h, 89h, 82h, 94h, 81h, 40h, 82h, 71h, 82h, 85h, 82h, 94h, 82h, 95h, 82h, 92h, 82h, 8Eh, 81h, 40h, 82h, 6Ah, 82h, 85h, 82h, 99h, 0

	;align 2

word_25FF	dw 0			; DATA XREF: sub_23C+13r
					; sub_23C:loc_252r ...
OldInt0A	dd 0			; DATA XREF: SetupInts+Fw
					; RestoreInts+8r ...
OldInt18	dd 0			; DATA XREF: seg000:1891r
					; SetupInts+1Cw ...

absolute $	; make RES# work
		resb 1
word_260A:	resw 1
word_260C:	resw 1
byte_260E:	resb 1
byte_260F:	resb 1
off_2610:	resd 1			; DATA XREF: LoadWSB_OpRA+5o
					; free_all+3o
off_2614:	resd 1			; DATA XREF: LoadWSB_OpRB+5o
					; seg000:0768r
off_2618:	resd 1
off_261C:	resd 1			; DATA XREF: LoadWSB_OpRD+5o
					; seg000:07CFr
off_2620:	resd 1			; DATA XREF: LoadWSB_OpN+Bo
					; seg000:0819r
off_2624:	resd 1			; DATA XREF: LoadWSB_OpN+16o
					; seg000:0827r
off_2628:	resd 1			; DATA XREF: LoadWSB_OpN+21o
					; seg000:0835r
off_262C:	resd 1			; DATA XREF: LoadWSB_OpN+2Co
					; seg000:0843r
off_2630:	resd 1			; DATA XREF: LoadWSB_OpN+37o
					; seg000:0851r
off_2634:	resd 1			; DATA XREF: LoadWSB_OpN+42o
					; seg000:085Fr
off_2638:	resd 1			; DATA XREF: LoadWSB_OpN+4Do
					; seg000:086Dr
off_263C:	resd 1			; DATA XREF: LoadWSB_OpN+58o
					; seg000:087Br
off_2640:	resd 1			; DATA XREF: LoadWSB_OpN+63o
					; seg000:0889r
off_2644:	resd 1			; DATA XREF: LoadWSB_OpN+6Eo
					; seg000:0897r
byte_2648:	resb 40h		; DATA XREF: LoadWSB_OpRC+1Eo
					; LoadWSB+16o
off_2688:	resd 1
word_268C:	resw 1			; DATA XREF: sub_279+Co mainexec_00+5r
word_268E:	resw 1
word_2690:	resw 1
word_2692:	resw 1
word_2694:	resw 1
word_2696:	resw 1
word_2698:	resw 1
word_269A:	resw 1
word_269C:	resw 1
word_269E:	resw 1
word_26A0:	resw 1
word_26A2:	resw 1
word_26A4:	resw 1
word_26A6:	resw 1
word_26A8:	resw 1
word_26AA:	resw 1
