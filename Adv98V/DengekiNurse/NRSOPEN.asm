; Input MD5   : 8CB0FAAB451FDEF0F81D7580C1981AB3
; Input CRC32 : F1E8E786
; File Name   : R:\NRSOPEN.TCM

	use16
	cpu	186

	org	0
	SECTION .text

%define	tramAddr(x,y)	(y*80 + x*1) * 2
%define	COLCHG_END	-1

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
		dw drawtx3_00	; 24h
		dw loc_143A	; 25h
		dw loc_1441	; 26h
		dw loc_1448	; 27h
		dw loc_144F	; 28h
		dw loc_1456	; 29h
		dw loc_145D	; 2Ah
		dw loc_1464	; 2Bh
		dw loc_146B	; 2Ch
		dw loc_1472	; 2Dh
		dw loc_1479	; 2Eh
		dw loc_1480	; 2Fh
		dw drawtx3_12	; 30h
		dw drawtx4_00	; 31h
		dw drawtx4_01	; 32h
		dw drawtx1_00	; 33h
		dw loc_13BC	; 34h
		dw loc_13C3	; 35h
		dw loc_13CA	; 36h
		dw loc_13D1	; 37h
		dw loc_13D8	; 38h
		dw loc_13DF	; 39h
		dw loc_13E6	; 3Ah
		dw loc_13ED	; 3Bh
		dw loc_13F4	; 3Ch
		dw loc_13FB	; 3Dh
		dw loc_1402	; 3Eh
		dw loc_1409	; 3Fh
		dw loc_1410	; 40h
		dw drawtx1_14	; 41h
		dw karaoke_0_0	; 42h
		dw loc_980	; 43h
		dw loc_98E	; 44h
		dw loc_99C	; 45h
		dw loc_9AA	; 46h
		dw loc_9B8	; 47h
		dw loc_9C6	; 48h
		dw loc_9D4	; 49h
		dw loc_9E2	; 4Ah
		dw loc_9F0	; 4Bh
		dw loc_9FE	; 4Ch
		dw loc_A0C	; 4Dh
		dw loc_A1A	; 4Eh
		dw loc_A28	; 4Fh
		dw loc_A36	; 50h
		dw loc_A44	; 51h
		dw loc_A52	; 52h
		dw loc_A60	; 53h
		dw loc_A6E	; 54h
		dw loc_A7C	; 55h
		dw loc_A8A	; 56h
		dw loc_A98	; 57h
		dw karaoke_0_22 ; 58h
		dw karaoke_1_0	; 59h
		dw loc_AC1	; 5Ah
		dw loc_ACF	; 5Bh
		dw loc_ADD	; 5Ch
		dw loc_AEB	; 5Dh
		dw loc_AF9	; 5Eh
		dw loc_B07	; 5Fh
		dw loc_B15	; 60h
		dw loc_B23	; 61h
		dw loc_B31	; 62h
		dw loc_B3F	; 63h
		dw loc_B4D	; 64h
		dw loc_B5B	; 65h
		dw loc_B69	; 66h
		dw loc_B77	; 67h
		dw loc_B85	; 68h
		dw loc_B93	; 69h
		dw loc_BA1	; 6Ah
		dw loc_BAF	; 6Bh
		dw loc_BBD	; 6Ch
		dw loc_BCA	; 6Dh
		dw loc_BD8	; 6Eh
		dw loc_BE6	; 6Fh
		dw loc_BF4	; 70h
		dw loc_C02	; 71h
		dw loc_C10	; 72h
		dw loc_C1E	; 73h
		dw loc_C2C	; 74h
		dw loc_C3A	; 75h
		dw loc_C48	; 76h
		dw loc_C56	; 77h
		dw loc_C64	; 78h
		dw loc_C72	; 79h
		dw loc_C80	; 7Ah
		dw loc_C8E	; 7Bh
		dw loc_C9C	; 7Ch
		dw loc_CAA	; 7Dh
		dw loc_CB8	; 7Eh
		dw loc_CC6	; 7Fh
		dw loc_CD3	; 80h
		dw loc_CE1	; 81h
		dw loc_CEF	; 82h
		dw loc_CFD	; 83h
		dw loc_D0B	; 84h
		dw loc_D19	; 85h
		dw loc_D27	; 86h
		dw loc_D35	; 87h
		dw loc_D43	; 88h
		dw loc_D51	; 89h
		dw loc_D5F	; 8Ah
		dw loc_D6D	; 8Bh
		dw loc_D7B	; 8Ch
		dw loc_D89	; 8Dh
		dw loc_D97	; 8Eh
		dw loc_DA5	; 8Fh
		dw loc_DB2	; 90h
		dw loc_DC0	; 91h
		dw loc_DCE	; 92h
		dw loc_DDC	; 93h
		dw loc_DEA	; 94h
		dw loc_DF8	; 95h
		dw loc_E06	; 96h
		dw loc_E14	; 97h
		dw loc_E22	; 98h
		dw loc_E30	; 99h
		dw loc_E3E	; 9Ah
		dw loc_E4C	; 9Bh
		dw loc_E5A	; 9Ch
		dw loc_E68	; 9Dh
		dw loc_E76	; 9Eh
		dw loc_E84	; 9Fh
		dw loc_E92	; 0A0h
		dw loc_EA0	; 0A1h
		dw loc_EAD	; 0A2h
		dw loc_EBB	; 0A3h
		dw loc_EC9	; 0A4h
		dw loc_ED7	; 0A5h
		dw loc_EE5	; 0A6h
		dw loc_EF3	; 0A7h
		dw loc_F01	; 0A8h
		dw loc_F0F	; 0A9h
		dw loc_F1D	; 0AAh
		dw loc_F2B	; 0ABh
		dw loc_F39	; 0ACh
		dw loc_F47	; 0ADh
		dw loc_F55	; 0AEh
		dw loc_F62	; 0AFh
		dw loc_F70	; 0B0h
		dw loc_F7E	; 0B1h
		dw loc_F8C	; 0B2h
		dw loc_F9A	; 0B3h
		dw loc_FA8	; 0B4h
		dw loc_FB6	; 0B5h
		dw loc_FC4	; 0B6h
		dw loc_FD2	; 0B7h
		dw loc_FE0	; 0B8h
		dw loc_FEE	; 0B9h
		dw loc_FFC	; 0BAh
		dw loc_100A	; 0BBh
		dw loc_1018	; 0BCh
		dw loc_1026	; 0BDh
		dw loc_1034	; 0BEh
		dw loc_1042	; 0BFh
		dw loc_1050	; 0C0h
		dw loc_105E	; 0C1h
		dw loc_106C	; 0C2h
		dw loc_107A	; 0C3h
		dw loc_1088	; 0C4h
		dw loc_1096	; 0C5h
		dw loc_10A3	; 0C6h
		dw loc_10B1	; 0C7h
		dw loc_10BF	; 0C8h
		dw loc_10CD	; 0C9h
		dw loc_10DB	; 0CAh
		dw loc_10E9	; 0CBh
		dw loc_10F7	; 0CCh
		dw loc_1105	; 0CDh
		dw loc_1113	; 0CEh
		dw loc_1121	; 0CFh
		dw loc_112F	; 0D0h
		dw loc_113D	; 0D1h
		dw loc_114B	; 0D2h
		dw loc_1159	; 0D3h
		dw loc_1167	; 0D4h
		dw loc_1175	; 0D5h
		dw loc_1183	; 0D6h
		dw loc_1190	; 0D7h
		dw loc_119E	; 0D8h
		dw loc_11AC	; 0D9h
		dw loc_11BA	; 0DAh
		dw loc_11C8	; 0DBh
		dw loc_11D6	; 0DCh
		dw loc_11E4	; 0DDh
		dw loc_11F2	; 0DEh
		dw loc_1200	; 0DFh
		dw loc_120E	; 0E0h
		dw loc_121C	; 0E1h
		dw loc_122A	; 0E2h
		dw loc_1238	; 0E3h
		dw loc_1246	; 0E4h
		dw loc_1254	; 0E5h
		dw loc_1262	; 0E6h
		dw loc_1270	; 0E7h
		dw loc_127E	; 0E8h
		dw loc_128C	; 0E9h
		dw loc_1299	; 0EAh
		dw loc_12A7	; 0EBh
		dw loc_12B5	; 0ECh
		dw loc_12C3	; 0EDh
		dw loc_12D1	; 0EEh
		dw loc_12DF	; 0EFh
		dw loc_12ED	; 0F0h
		dw loc_12FB	; 0F1h
		dw loc_1309	; 0F2h
		dw loc_1317	; 0F3h
		dw loc_1325	; 0F4h
		dw loc_1333	; 0F5h
		dw loc_1341	; 0F6h
		dw loc_134F	; 0F7h
		dw loc_135D	; 0F8h
		dw loc_136B	; 0F9h
		dw loc_1379	; 0FAh
		dw karaoke_10_18	; 0FBh
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

karaoke_0_0:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_204A
		xor	ax, ax
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_980:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_204A
		mov	ax, 1
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_98E:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_204A
		mov	ax, 2
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_99C:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_204A
		mov	ax, 3
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_9AA:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_204A
		mov	ax, 4
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_9B8:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_204A
		mov	ax, 5
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_9C6:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_204A
		mov	ax, 6
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_9D4:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_204A
		mov	ax, 7
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_9E2:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_204A
		mov	ax, 8
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_9F0:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_204A
		mov	ax, 9
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_9FE:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_204A
		mov	ax, 0Ah
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_A0C:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_204A
		mov	ax, 0Bh
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_A1A:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_204A
		mov	ax, 0Ch
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_A28:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_204A
		mov	ax, 0Dh
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_A36:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_204A
		mov	ax, 0Eh
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_A44:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_204A
		mov	ax, 0Fh
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_A52:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_204A
		mov	ax, 10h
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_A60:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_204A
		mov	ax, 11h
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_A6E:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_204A
		mov	ax, 12h
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_A7C:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_204A
		mov	ax, 13h
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_A8A:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_204A
		mov	ax, 14h
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_A98:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_204A
		mov	ax, 15h
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

karaoke_0_22:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_204A
		mov	ax, 16h
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

karaoke_1_0:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_20E6
		xor	ax, ax
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_AC1:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_20E6
		mov	ax, 1
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_ACF:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_20E6
		mov	ax, 2
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_ADD:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_20E6
		mov	ax, 3
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_AEB:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_20E6
		mov	ax, 4
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_AF9:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_20E6
		mov	ax, 5
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_B07:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_20E6
		mov	ax, 6
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_B15:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_20E6
		mov	ax, 7
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_B23:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_20E6
		mov	ax, 8
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_B31:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_20E6
		mov	ax, 9
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_B3F:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_20E6
		mov	ax, 0Ah
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_B4D:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_20E6
		mov	ax, 0Bh
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_B5B:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_20E6
		mov	ax, 0Ch
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_B69:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_20E6
		mov	ax, 0Dh
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_B77:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_20E6
		mov	ax, 0Eh
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_B85:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_20E6
		mov	ax, 0Fh
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_B93:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_20E6
		mov	ax, 10h
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_BA1:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_20E6
		mov	ax, 11h
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_BAF:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_20E6
		mov	ax, 12h
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_BBD:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_2176
		xor	ax, ax
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_BCA:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_2176
		mov	ax, 1
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_BD8:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_2176
		mov	ax, 2
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_BE6:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_2176
		mov	ax, 3
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_BF4:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_2176
		mov	ax, 4
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_C02:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_2176
		mov	ax, 5
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_C10:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_2176
		mov	ax, 6
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_C1E:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_2176
		mov	ax, 7
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_C2C:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_2176
		mov	ax, 8
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_C3A:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_2176
		mov	ax, 9
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_C48:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_2176
		mov	ax, 0Ah
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_C56:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_2176
		mov	ax, 0Bh
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_C64:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_2176
		mov	ax, 0Ch
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_C72:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_2176
		mov	ax, 0Dh
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_C80:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_2176
		mov	ax, 0Eh
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_C8E:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_2176
		mov	ax, 0Fh
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_C9C:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_2176
		mov	ax, 10h
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_CAA:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_2176
		mov	ax, 11h
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_CB8:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_2176
		mov	ax, 12h
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_CC6:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_220E
		xor	ax, ax
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_CD3:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_220E
		mov	ax, 1
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_CE1:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_220E
		mov	ax, 2
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_CEF:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_220E
		mov	ax, 3
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_CFD:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_220E
		mov	ax, 4
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_D0B:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_220E
		mov	ax, 5
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_D19:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_220E
		mov	ax, 6
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_D27:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_220E
		mov	ax, 7
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_D35:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_220E
		mov	ax, 8
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_D43:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_220E
		mov	ax, 9
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_D51:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_220E
		mov	ax, 0Ah
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_D5F:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_220E
		mov	ax, 0Bh
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_D6D:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_220E
		mov	ax, 0Ch
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_D7B:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_220E
		mov	ax, 0Dh
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_D89:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_220E
		mov	ax, 0Eh
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_D97:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_220E
		mov	ax, 0Fh
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_DA5:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_2296
		xor	ax, ax
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_DB2:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_2296
		mov	ax, 1
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_DC0:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_2296
		mov	ax, 2
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_DCE:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_2296
		mov	ax, 3
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_DDC:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_2296
		mov	ax, 4
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_DEA:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_2296
		mov	ax, 5
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_DF8:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_2296
		mov	ax, 6
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_E06:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_2296
		mov	ax, 7
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_E14:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_2296
		mov	ax, 8
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_E22:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_2296
		mov	ax, 9
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_E30:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_2296
		mov	ax, 0Ah
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_E3E:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_2296
		mov	ax, 0Bh
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_E4C:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_2296
		mov	ax, 0Ch
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_E5A:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_2296
		mov	ax, 0Dh
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_E68:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_2296
		mov	ax, 0Eh
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_E76:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_2296
		mov	ax, 0Fh
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_E84:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_2296
		mov	ax, 10h
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_E92:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_2296
		mov	ax, 11h
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_EA0:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_231A
		xor	ax, ax
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_EAD:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_231A
		mov	ax, 1
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_EBB:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_231A
		mov	ax, 2
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_EC9:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_231A
		mov	ax, 3
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_ED7:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_231A
		mov	ax, 4
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_EE5:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_231A
		mov	ax, 5
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_EF3:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_231A
		mov	ax, 6
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_F01:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_231A
		mov	ax, 7
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_F0F:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_231A
		mov	ax, 8
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_F1D:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_231A
		mov	ax, 9
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_F2B:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_231A
		mov	ax, 0Ah
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_F39:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_231A
		mov	ax, 0Bh
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_F47:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_231A
		mov	ax, 0Ch
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_F55:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_2386
		xor	ax, ax
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_F62:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_2386
		mov	ax, 1
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_F70:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_2386
		mov	ax, 2
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_F7E:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_2386
		mov	ax, 3
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_F8C:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_2386
		mov	ax, 4
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_F9A:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_2386
		mov	ax, 5
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_FA8:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_2386
		mov	ax, 6
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_FB6:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_2386
		mov	ax, 7
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_FC4:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_2386
		mov	ax, 8
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_FD2:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_2386
		mov	ax, 9
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_FE0:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_2386
		mov	ax, 0Ah
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_FEE:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_2386
		mov	ax, 0Bh
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_FFC:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_2386
		mov	ax, 0Ch
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_100A:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_2386
		mov	ax, 0Dh
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_1018:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_2386
		mov	ax, 0Eh
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_1026:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_2386
		mov	ax, 0Fh
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_1034:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_2386
		mov	ax, 10h
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_1042:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_2386
		mov	ax, 11h
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_1050:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_2386
		mov	ax, 12h
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_105E:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_2386
		mov	ax, 13h
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_106C:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_2386
		mov	ax, 14h
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_107A:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_2386
		mov	ax, 15h
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_1088:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_2386
		mov	ax, 16h
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_1096:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_242E
		xor	ax, ax
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_10A3:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_242E
		mov	ax, 1
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_10B1:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_242E
		mov	ax, 2
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_10BF:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_242E
		mov	ax, 3
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_10CD:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_242E
		mov	ax, 4
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_10DB:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_242E
		mov	ax, 5
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_10E9:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_242E
		mov	ax, 6
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_10F7:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_242E
		mov	ax, 7
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_1105:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_242E
		mov	ax, 8
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_1113:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_242E
		mov	ax, 9
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_1121:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_242E
		mov	ax, 0Ah
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_112F:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_242E
		mov	ax, 0Bh
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_113D:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_242E
		mov	ax, 0Ch
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_114B:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_242E
		mov	ax, 0Dh
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_1159:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_242E
		mov	ax, 0Eh
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_1167:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_242E
		mov	ax, 0Fh
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_1175:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_242E
		mov	ax, 10h
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_1183:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_24B2
		xor	ax, ax
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_1190:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_24B2
		mov	ax, 1
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_119E:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_24B2
		mov	ax, 2
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_11AC:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_24B2
		mov	ax, 3
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_11BA:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_24B2
		mov	ax, 4
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_11C8:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_24B2
		mov	ax, 5
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_11D6:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_24B2
		mov	ax, 6
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_11E4:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_24B2
		mov	ax, 7
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_11F2:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_24B2
		mov	ax, 8
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_1200:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_24B2
		mov	ax, 9
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_120E:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_24B2
		mov	ax, 0Ah
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_121C:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_24B2
		mov	ax, 0Bh
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_122A:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_24B2
		mov	ax, 0Ch
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_1238:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_24B2
		mov	ax, 0Dh
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_1246:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_24B2
		mov	ax, 0Eh
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_1254:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_24B2
		mov	ax, 0Fh
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_1262:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_24B2
		mov	ax, 10h
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_1270:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_24B2
		mov	ax, 11h
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_127E:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_24B2
		mov	ax, 12h
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_128C:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_254A
		xor	ax, ax
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_1299:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_254A
		mov	ax, 1
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_12A7:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_254A
		mov	ax, 2
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_12B5:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_254A
		mov	ax, 3
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_12C3:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_254A
		mov	ax, 4
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_12D1:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_254A
		mov	ax, 5
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_12DF:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_254A
		mov	ax, 6
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_12ED:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_254A
		mov	ax, 7
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_12FB:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_254A
		mov	ax, 8
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_1309:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_254A
		mov	ax, 9
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_1317:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_254A
		mov	ax, 0Ah
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_1325:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_254A
		mov	ax, 0Bh
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_1333:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_254A
		mov	ax, 0Ch
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_1341:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_254A
		mov	ax, 0Dh
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_134F:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_254A
		mov	ax, 0Eh
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_135D:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_254A
		mov	ax, 0Fh
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_136B:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_254A
		mov	ax, 10h
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

loc_1379:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_254A
		mov	ax, 11h
		call	ChangeCharColor
		mov	si, bx
		retn
; ---------------------------------------------------------------------------

karaoke_10_18:				; DATA XREF: seg000:mainJumpTblo
		mov	bx, si
		mov	si, karPtrs_254A
		mov	ax, 12h
		call	ChangeCharColor
		mov	si, bx
		retn

ChangeCharColor:				; CODE XREF: seg000:097Ap seg000:0988p ...
		push	di
		push	es
		shl	ax, 1
		add	si, ax
		mov	si, [si]
		mov	ax, 0A200h
		mov	es, ax
		mov	al, 0C1h

loc_13A4:				; CODE XREF: ChangeCharColor+1Cj
		mov	di, [si]
		db	83h, 0FFh, 0FFh ; cmp	di, 0FFFFh ; NASM assembles this to 81h 0FFh 0FFh 0FFh
		jz	short loc_13B3
		mov	[es:di], al
		add	si, byte 2
		jmp	short loc_13A4
; ---------------------------------------------------------------------------

loc_13B3:				; CODE XREF: ChangeCharColor+14j
		pop	es
		pop	di
		retn

; ---------------------------------------------------------------------------

drawtx1_00:				; DATA XREF: seg000:mainJumpTblo
		xor	ax, ax
		call	Draw1TextByID
		retn
; ---------------------------------------------------------------------------

loc_13BC:				; DATA XREF: seg000:mainJumpTblo
		mov	ax, 1
		call	Draw1TextByID
		retn
; ---------------------------------------------------------------------------

loc_13C3:				; DATA XREF: seg000:mainJumpTblo
		mov	ax, 2
		call	Draw1TextByID
		retn
; ---------------------------------------------------------------------------

loc_13CA:				; DATA XREF: seg000:mainJumpTblo
		mov	ax, 3
		call	Draw1TextByID
		retn
; ---------------------------------------------------------------------------

loc_13D1:				; DATA XREF: seg000:mainJumpTblo
		mov	ax, 4
		call	Draw1TextByID
		retn
; ---------------------------------------------------------------------------

loc_13D8:				; DATA XREF: seg000:mainJumpTblo
		mov	ax, 5
		call	Draw1TextByID
		retn
; ---------------------------------------------------------------------------

loc_13DF:				; DATA XREF: seg000:mainJumpTblo
		mov	ax, 6
		call	Draw1TextByID
		retn
; ---------------------------------------------------------------------------

loc_13E6:				; DATA XREF: seg000:mainJumpTblo
		mov	ax, 7
		call	Draw1TextByID
		retn
; ---------------------------------------------------------------------------

loc_13ED:				; DATA XREF: seg000:mainJumpTblo
		mov	ax, 8
		call	Draw1TextByID
		retn
; ---------------------------------------------------------------------------

loc_13F4:				; DATA XREF: seg000:mainJumpTblo
		mov	ax, 9
		call	Draw1TextByID
		retn
; ---------------------------------------------------------------------------

loc_13FB:				; DATA XREF: seg000:mainJumpTblo
		mov	ax, 0Ah
		call	Draw1TextByID
		retn
; ---------------------------------------------------------------------------

loc_1402:				; DATA XREF: seg000:mainJumpTblo
		mov	ax, 0Bh
		call	Draw1TextByID
		retn
; ---------------------------------------------------------------------------

loc_1409:				; DATA XREF: seg000:mainJumpTblo
		mov	ax, 0Ch
		call	Draw1TextByID
		retn
; ---------------------------------------------------------------------------

loc_1410:				; DATA XREF: seg000:mainJumpTblo
		mov	ax, 0Dh
		call	Draw1TextByID
		retn
; ---------------------------------------------------------------------------

drawtx1_14:				; DATA XREF: seg000:mainJumpTblo
		mov	ax, 0Eh
		call	Draw1TextByID
		retn

Draw1TextByID:				; CODE XREF: seg000:13B8p seg000:13BFp ...
		push	si
		mov	bx, Text1Ptrs
		shl	ax, 1
		add	bx, ax
		mov	cl, 7
		mov	si, [bx]
		mov	dx, [si]
		add	si, byte 2
		call	DrawTextStr
		pop	si
		retn

; ---------------------------------------------------------------------------

drawtx3_00:				; DATA XREF: seg000:mainJumpTblo
		xor	ax, ax
		call	Draw3TextByID
		retn
; ---------------------------------------------------------------------------

loc_143A:				; DATA XREF: seg000:mainJumpTblo
		mov	ax, 1
		call	Draw3TextByID
		retn
; ---------------------------------------------------------------------------

loc_1441:				; DATA XREF: seg000:mainJumpTblo
		mov	ax, 2
		call	Draw3TextByID
		retn
; ---------------------------------------------------------------------------

loc_1448:				; DATA XREF: seg000:mainJumpTblo
		mov	ax, 3
		call	Draw3TextByID
		retn
; ---------------------------------------------------------------------------

loc_144F:				; DATA XREF: seg000:mainJumpTblo
		mov	ax, 4
		call	Draw3TextByID
		retn
; ---------------------------------------------------------------------------

loc_1456:				; DATA XREF: seg000:mainJumpTblo
		mov	ax, 5
		call	Draw3TextByID
		retn
; ---------------------------------------------------------------------------

loc_145D:				; DATA XREF: seg000:mainJumpTblo
		mov	ax, 6
		call	Draw3TextByID
		retn
; ---------------------------------------------------------------------------

loc_1464:				; DATA XREF: seg000:mainJumpTblo
		mov	ax, 7
		call	Draw3TextByID
		retn
; ---------------------------------------------------------------------------

loc_146B:				; DATA XREF: seg000:mainJumpTblo
		mov	ax, 8
		call	Draw3TextByID
		retn
; ---------------------------------------------------------------------------

loc_1472:				; DATA XREF: seg000:mainJumpTblo
		mov	ax, 9
		call	Draw3TextByID
		retn
; ---------------------------------------------------------------------------

loc_1479:				; DATA XREF: seg000:mainJumpTblo
		mov	ax, 0Ah
		call	Draw3TextByID
		retn
; ---------------------------------------------------------------------------

loc_1480:				; DATA XREF: seg000:mainJumpTblo
		mov	ax, 0Bh
		call	Draw3TextByID
		retn
; ---------------------------------------------------------------------------

drawtx3_12:				; DATA XREF: seg000:mainJumpTblo
		mov	ax, 0Ch
		call	Draw3TextByID
		retn

Draw3TextByID:				; CODE XREF: seg000:1436p seg000:143Dp ...
		push	si
		mov	bx, Text3Ptrs
		shl	ax, 1
		add	bx, ax
		shl	ax, 1
		add	bx, ax
		mov	cl, 7
		mov	si, [bx]
		mov	dx, [si]
		add	si, byte 2
		call	DrawTextStr
		mov	si, [bx+2]
		mov	dx, [si]
		add	si, byte 2
		call	DrawTextStr
		mov	si, [bx+4]
		mov	dx, [si]
		add	si, byte 2
		call	DrawTextStr
		pop	si
		retn

; ---------------------------------------------------------------------------

drawtx4_00:				; DATA XREF: seg000:mainJumpTblo
		xor	ax, ax
		call	Draw4TextByID
		retn
; ---------------------------------------------------------------------------

drawtx4_01:				; DATA XREF: seg000:mainJumpTblo
		mov	ax, 1
		call	Draw4TextByID
		retn

Draw4TextByID:				; CODE XREF: seg000:14C0p seg000:14C7p
		push	si
		mov	bx, Text4Ptrs
		shl	ax, 3
		add	bx, ax
		mov	cl, 7
		mov	si, [bx]
		mov	dx, [si]
		add	si, byte 2
		call	DrawTextStr
		mov	si, [bx+2]
		mov	dx, [si]
		add	si, byte 2
		call	DrawTextStr
		mov	si, [bx+4]
		mov	dx, [si]
		add	si, byte 2
		call	DrawTextStr
		mov	si, [bx+6]
		mov	dx, [si]
		add	si, byte 2
		call	DrawTextStr
		pop	si
		retn

DrawTextStr:				; CODE XREF: seg000:073Cp
					; Draw1TextByID+11p ...
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
		int	0F1h		; reserved for user interrupt
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

; ---------------------------------------------------------------------------
		pusha
		cld
		mov	ax, 80
		sub	ax, dx
		sub	bp, dx

loc_16FA:				; CODE XREF: seg000:1711j
		mov	cx, dx
		test	si, 1
		jz	short loc_1704
		movsb
		dec	cx

loc_1704:				; CODE XREF: seg000:1700j
		shr	cx, 1
		rep movsw
		rcl	cx, 1
		rep movsb
		add	si, ax
		add	di, bp
		dec	bx
		jnz	short loc_16FA
		popa
		retn
; ---------------------------------------------------------------------------
		pusha
		cld
		mov	ax, 50h
		sub	ax, dx
		sub	bp, dx

loc_171E:				; CODE XREF: seg000:1735j
		mov	cx, dx
		test	di, 1
		jz	short loc_1728
		movsb
		dec	cx

loc_1728:				; CODE XREF: seg000:1724j
		shr	cx, 1
		rep movsw
		rcl	cx, 1
		rep movsb
		add	si, bp
		add	di, ax
		dec	bx
		jnz	short loc_171E
		popa
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

; ---------------------------------------------------------------------------
		push	cx
		push	ds
		mov	cx, cs
		mov	ds, cx
		xor	cx, cx
		mov	cl, [byte_25FE]
		or	cl, cl
		jz	short loc_1936

loc_1931:				; CODE XREF: seg000:1934j
		call	sub_190F
		loop	loc_1931

loc_1936:				; CODE XREF: seg000:192Fj
		pop	ds
		pop	cx
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
		db    0
byte_1958	db 0FFh			; DATA XREF: sub_23C+29w sub_23C+33w ...
		dw 0A800h
		dw 0B000h
		dw 0B800h
		dw 0E000h
		dw 0FFFFh
		dw 0FFFFh
		db    0
		db    0
		db    0
		db    0
aBOpenNsopra_ws	db 'B:\OPEN\nsopra.wsb',0 ; DATA XREF: LoadWSB_OpRA+2o
aBOpenNsoprb_ws	db 'B:\OPEN\nsoprb.wsb',0 ; DATA XREF: LoadWSB_OpRB+2o
aBOpenNsoprc_ws	db 'B:\OPEN\nsoprc.wsb',0 ; DATA XREF: LoadWSB_OpRC+3o
aBOpenNsoprd_ws	db 'B:\OPEN\nsoprd.wsb',0 ; DATA XREF: LoadWSB_OpRD+2o
aBOpenNsop1_wsb	db 'B:\OPEN\nsop1.wsb',0 ; DATA XREF: LoadWSB_OpN+8o
aBOpenNsop1a_ws	db 'B:\OPEN\nsop1a.wsb',0 ; DATA XREF: LoadWSB_OpN+13o
aBOpenNsop2_wsb	db 'B:\OPEN\nsop2.wsb',0 ; DATA XREF: LoadWSB_OpN+1Eo
aBOpenNsop2a_ws	db 'B:\OPEN\nsop2a.wsb',0 ; DATA XREF: LoadWSB_OpN+29o
aBOpenNsop3_wsb	db 'B:\OPEN\nsop3.wsb',0 ; DATA XREF: LoadWSB_OpN+34o
aBOpenNsop3a_ws	db 'B:\OPEN\nsop3a.wsb',0 ; DATA XREF: LoadWSB_OpN+3Fo
aBOpenNsop4_wsb	db 'B:\OPEN\nsop4.wsb',0 ; DATA XREF: LoadWSB_OpN+4Ao
aBOpenNsop4a_ws	db 'B:\OPEN\nsop4a.wsb',0 ; DATA XREF: LoadWSB_OpN+55o
aBOpenNsop5_wsb	db 'B:\OPEN\nsop5.wsb',0 ; DATA XREF: LoadWSB_OpN+60o
aBOpenNsop5a_ws	db 'B:\OPEN\nsop5a.wsb',0 ; DATA XREF: LoadWSB_OpN+6Bo
aBOpenNrsopdta_	db 'B:\OPEN\nrsopdta.dat',0 ; DATA XREF: sub_279+19o
aBOpenNrsopdtb_	db 'B:\OPEN\nrsopdtb.dat',0 ; DATA XREF: sub_279+Fo
Text3Ptrs:	; 1A98h
	DW	txt_1AE6, txt_1AF3, txt_1CA0	; 0 .. 2
	DW	txt_1B06, txt_1B11, txt_1B22	; 3 .. 5
	DW	txt_1B31, txt_1B3C, txt_1B53	; 6 .. 8
	DW	txt_1B62, txt_1B71, txt_1CA0	; 9 .. 11
	DW	txt_1B7E, txt_1B93, txt_1CA0	; 12 .. 14
	DW	txt_1BA0, txt_1BB0, txt_1CA0	; 15 .. 17
	DW	txt_1BBC, txt_1BCB, txt_1CA0	; 18 .. 20
	DW	txt_1BD8, txt_1BE7, txt_1CA0	; 21 .. 23
	DW	txt_1BF4, txt_1BFB, txt_1CA0	; 24 .. 26
	DW	txt_1C08, txt_1C13, txt_1CA0	; 27 .. 29
	DW	txt_1C24, txt_1C35, txt_1CA0	; 30 .. 32
	DW	txt_1C42, txt_1C53, txt_1C64	; 33 .. 35
	DW	txt_1C71, txt_1C7E, txt_1C8F	; 36 .. 38
txt_1AE6:	; "企画・監修"
	DB	8, 7	; x, y
	DB	8Ah, 0E9h, 89h, 0E6h, 81h, 45h, 8Ah, 0C4h, 8Fh, 43h, 0
txt_1AF3:	; "電撃プロジェクト"
	DB	6, 9	; x, y
	DB	93h, 64h, 8Ch, 82h, 83h, 76h, 83h, 8Dh, 83h, 57h, 83h, 46h, 83h, 4Eh, 83h, 67h, 0
txt_1B06:	; "シナリオ"
	DB	60, 7	; x, y
	DB	83h, 56h, 83h, 69h, 83h, 8Ah, 83h, 49h, 0
txt_1B11:	; "ゲームデザイン"
	DB	58, 8	; x, y
	DB	83h, 51h, 81h, 5Bh, 83h, 80h, 83h, 66h, 83h, 55h, 83h, 43h, 83h, 93h, 0
txt_1B22:	; "葛西　みなみ"
	DB	60, 10	; x, y
	DB	8Ah, 8Bh, 90h, 0BCh, 81h, 40h, 82h, 0DDh, 82h, 0C8h, 82h, 0DDh, 0
txt_1B31:	; "作画監督"
	DB	62, 7	; x, y
	DB	8Dh, 0ECh, 89h, 0E6h, 8Ah, 0C4h, 93h, 0C2h, 0
txt_1B3C:	; "キャラクターデザイン"
	DB	56, 8	; x, y
	DB	83h, 4Ch, 83h, 83h, 83h, 89h, 83h, 4Eh, 83h, 5Eh, 81h, 5Bh, 83h, 66h, 83h, 55h, 83h, 43h, 83h, 93h, 0
txt_1B53:	; "亜久都　まお"
	DB	60, 10	; x, y
	DB	88h, 9Fh, 8Bh, 76h, 93h, 73h, 81h, 40h, 82h, 0DCh, 82h, 0A8h, 0
txt_1B62:	; "システム監修"
	DB	6, 7	; x, y
	DB	83h, 56h, 83h, 58h, 83h, 65h, 83h, 80h, 8Ah, 0C4h, 8Fh, 43h, 0
txt_1B71:	; "岡地　常義"
	DB	8, 9	; x, y
	DB	89h, 0AAh, 92h, 6Eh, 81h, 40h, 8Fh, 0EDh, 8Bh, 60h, 0
txt_1B7E:	; "シナリオプログラム"
	DB	58, 7	; x, y
	DB	83h, 56h, 83h, 69h, 83h, 8Ah, 83h, 49h, 83h, 76h, 83h, 8Dh, 83h, 4Fh, 83h, 89h, 83h, 80h, 0
txt_1B93:	; "中谷　由司"
	DB	60, 9	; x, y
	DB	92h, 86h, 92h, 4Ah, 81h, 40h, 97h, 52h, 8Eh, 69h, 0
txt_1BA0:	; " プログラム　"
	DB	60, 7	; x, y
	DB	" ", 83h, 76h, 83h, 8Dh, 83h, 4Fh, 83h, 89h, 83h, 80h, 81h, 40h, 0
txt_1BB0:	; " 佳　邦　"
	DB	62, 9	; x, y
	DB	" ", 89h, 0C0h, 81h, 40h, 96h, 4Dh, 81h, 40h, 0
txt_1BBC:	; "ＣＧデザイン"
	DB	6, 7	; x, y
	DB	82h, 62h, 82h, 66h, 83h, 66h, 83h, 55h, 83h, 43h, 83h, 93h, 0
txt_1BCB:	; "末武　潤二"
	DB	8, 9	; x, y
	DB	96h, 96h, 95h, 90h, 81h, 40h, 8Fh, 81h, 93h, 0F1h, 0
txt_1BD8:	; "ＣＧデザイン"
	DB	6, 7	; x, y
	DB	82h, 62h, 82h, 66h, 83h, 66h, 83h, 55h, 83h, 43h, 83h, 93h, 0
txt_1BE7:	; "松本　規之"
	DB	8, 9	; x, y
	DB	8Fh, 0BCh, 96h, 7Bh, 81h, 40h, 8Bh, 4Bh, 94h, 56h, 0
txt_1BF4:	; "音楽"
	DB	6, 7	; x, y
	DB	89h, 0B9h, 8Ah, 79h, 0
txt_1BFB:	; "金森　直幹"
	DB	8, 9	; x, y
	DB	8Bh, 0E0h, 90h, 58h, 81h, 40h, 92h, 0BCh, 8Ah, 0B2h, 0
txt_1C08:	; "音楽制作"
	DB	58, 7	; x, y
	DB	89h, 0B9h, 8Ah, 79h, 90h, 0A7h, 8Dh, 0ECh, 0
txt_1C13:	; "（有）ＭＵＳＥ"
	DB	58, 9	; x, y
	DB	81h, 69h, 97h, 4Ch, 81h, 6Ah, 82h, 6Ch, 82h, 74h, 82h, 72h, 82h, 64h, 0
txt_1C24:	; "プロデューサー"
	DB	6, 7	; x, y
	DB	83h, 76h, 83h, 8Dh, 83h, 66h, 83h, 85h, 81h, 5Bh, 83h, 54h, 81h, 5Bh, 0
txt_1C35:	; "田所　広成"
	DB	8, 9	; x, y
	DB	93h, 63h, 8Fh, 8Ah, 81h, 40h, 8Dh, 4Ch, 90h, 0ACh, 0
txt_1C42:	; "エグゼクティブ"
	DB	4, 7	; x, y
	DB	83h, 47h, 83h, 4Fh, 83h, 5Bh, 83h, 4Eh, 83h, 65h, 83h, 42h, 83h, 75h, 0
txt_1C53:	; "プロデューサー"
	DB	6, 8	; x, y
	DB	83h, 76h, 83h, 8Dh, 83h, 66h, 83h, 85h, 81h, 5Bh, 83h, 54h, 81h, 5Bh, 0
txt_1C64:	; "井手　健介"
	DB	8, 10	; x, y
	DB	88h, 0E4h, 8Eh, 0E8h, 81h, 40h, 8Ch, 92h, 89h, 0EEh, 0
txt_1C71:	; "制作・著作"
	DB	8, 7	; x, y
	DB	90h, 0A7h, 8Dh, 0ECh, 81h, 45h, 92h, 98h, 8Dh, 0ECh, 0
txt_1C7E:	; "カクテルソフト"
	DB	6, 9	; x, y
	DB	83h, 4Ah, 83h, 4Eh, 83h, 65h, 83h, 8Bh, 83h, 5Ch, 83h, 74h, 83h, 67h, 0
txt_1C8F:	; "（有）アイデス"
	DB	6, 10	; x, y
	DB	81h, 69h, 97h, 4Ch, 81h, 6Ah, 83h, 41h, 83h, 43h, 83h, 66h, 83h, 58h, 0
txt_1CA0:	; ""
	DB	0, 0	; x, y
	DB	0
Text4Ptrs:	; 1CA3h
	DW	txt_1CB3, txt_1CCA, txt_1CE1, txt_1CF8	; 0 .. 3
	DW	txt_1D0F, txt_1D26, txt_1D3D, txt_1D54	; 4 .. 7
txt_1CB3:	; "　　　　　　　　　　"
	DB	4, 7	; x, y
	DB	81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 0
txt_1CCA:	; "　　　　　　　　　　"
	DB	4, 8	; x, y
	DB	81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 0
txt_1CE1:	; "　　　　　　　　　　"
	DB	4, 9	; x, y
	DB	81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 0
txt_1CF8:	; "　　　　　　　　　　"
	DB	4, 10	; x, y
	DB	81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 0
txt_1D0F:	; "　　　　　　　　　　"
	DB	56, 7	; x, y
	DB	81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 0
txt_1D26:	; "　　　　　　　　　　"
	DB	56, 8	; x, y
	DB	81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 0
txt_1D3D:	; "　　　　　　　　　　"
	DB	56, 9	; x, y
	DB	81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 0
txt_1D54:	; "　　　　　　　　　　"
	DB	56, 10	; x, y
	DB	81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 0
Text1Ptrs:	; 1D6Bh
	DW	txt_1D89	; 0
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
	DB	18, 23	; x, y
	DB	81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 0
txt_1DB8:	; "　稲妻　とどろく夜に　甘い夢　恋が始まる　　"
	DB	18, 23	; x, y
	DB	81h, 40h, 88h, 0EEh, 8Dh, 0C8h, 81h, 40h, 82h, 0C6h, 82h, 0C7h, 82h, 0EBh, 82h, 0ADh, 96h, 0E9h, 82h, 0C9h, 81h, 40h, 8Ah, 0C3h, 82h, 0A2h, 96h, 0B2h, 81h, 40h, 97h, 0F6h, 82h, 0AAh, 8Eh, 6Eh, 82h, 0DCh, 82h, 0E9h, 81h, 40h, 81h, 40h, 0
txt_1DE7:	; "　あなたの　腕に抱かれて　熱が出たみたい　　"
	DB	18, 23	; x, y
	DB	81h, 40h, 82h, 0A0h, 82h, 0C8h, 82h, 0BDh, 82h, 0CCh, 81h, 40h, 98h, 72h, 82h, 0C9h, 95h, 0F8h, 82h, 0A9h, 82h, 0EAh, 82h, 0C4h, 81h, 40h, 94h, 4Dh, 82h, 0AAh, 8Fh, 6Fh, 82h, 0BDh, 82h, 0DDh, 82h, 0BDh, 82h, 0A2h, 81h, 40h, 81h, 40h, 0
txt_1E16:	; "風邪薬も　効かないのよ　どうすればいいの？　"
	DB	18, 23	; x, y
	DB	95h, 97h, 8Eh, 0D7h, 96h, 0F2h, 82h, 0E0h, 81h, 40h, 8Ch, 0F8h, 82h, 0A9h, 82h, 0C8h, 82h, 0A2h, 82h, 0CCh, 82h, 0E6h, 81h, 40h, 82h, 0C7h, 82h, 0A4h, 82h, 0B7h, 82h, 0EAh, 82h, 0CEh, 82h, 0A2h, 82h, 0A2h, 82h, 0CCh, 81h, 48h, 81h, 40h, 0
txt_1E45:	; "　チャージＯＮ！　プラズマフラーッシュ！　　"
	DB	18, 23	; x, y
	DB	81h, 40h, 83h, 60h, 83h, 83h, 81h, 5Bh, 83h, 57h, 82h, 6Eh, 82h, 6Dh, 81h, 49h, 81h, 40h, 83h, 76h, 83h, 89h, 83h, 59h, 83h, 7Dh, 83h, 74h, 83h, 89h, 81h, 5Bh, 83h, 62h, 83h, 56h, 83h, 85h, 81h, 49h, 81h, 40h, 81h, 40h, 0
txt_1E74:	; "　　　聴診器で聞いて　この胸のドキドキ　　　"
	DB	18, 23	; x, y
	DB	81h, 40h, 81h, 40h, 81h, 40h, 92h, 0AEh, 90h, 66h, 8Ah, 0EDh, 82h, 0C5h, 95h, 0B7h, 82h, 0A2h, 82h, 0C4h, 81h, 40h, 82h, 0B1h, 82h, 0CCh, 8Bh, 0B9h, 82h, 0CCh, 83h, 68h, 83h, 4Ch, 83h, 68h, 83h, 4Ch, 81h, 40h, 81h, 40h, 81h, 40h, 0
txt_1EA3:	; "　　　ナース！　ナース！　電撃ナース！　　　"
	DB	18, 23	; x, y
	DB	81h, 40h, 81h, 40h, 81h, 40h, 83h, 69h, 81h, 5Bh, 83h, 58h, 81h, 49h, 81h, 40h, 83h, 69h, 81h, 5Bh, 83h, 58h, 81h, 49h, 81h, 40h, 93h, 64h, 8Ch, 82h, 83h, 69h, 81h, 5Bh, 83h, 58h, 81h, 49h, 81h, 40h, 81h, 40h, 81h, 40h, 0
txt_1ED2:	; "　　　ナース！　ナース！　電撃ナース！　　　"
	DB	18, 23	; x, y
	DB	81h, 40h, 81h, 40h, 81h, 40h, 83h, 69h, 81h, 5Bh, 83h, 58h, 81h, 49h, 81h, 40h, 83h, 69h, 81h, 5Bh, 83h, 58h, 81h, 49h, 81h, 40h, 93h, 64h, 8Ch, 82h, 83h, 69h, 81h, 5Bh, 83h, 58h, 81h, 49h, 81h, 40h, 81h, 40h, 81h, 40h, 0
txt_1F01:	; "稲妻　どしゃ降り雨の　交差点　ひとり待ってた"
	DB	18, 23	; x, y
	DB	88h, 0EEh, 8Dh, 0C8h, 81h, 40h, 82h, 0C7h, 82h, 0B5h, 82h, 0E1h, 8Dh, 7Eh, 82h, 0E8h, 89h, 4Ah, 82h, 0CCh, 81h, 40h, 8Ch, 0F0h, 8Dh, 0B7h, 93h, 5Fh, 81h, 40h, 82h, 0D0h, 82h, 0C6h, 82h, 0E8h, 91h, 0D2h, 82h, 0C1h, 82h, 0C4h, 82h, 0BDh, 0
txt_1F30:	; "　　あなたの　姿さがして　私びしょ濡れよ　　"
	DB	18, 23	; x, y
	DB	81h, 40h, 81h, 40h, 82h, 0A0h, 82h, 0C8h, 82h, 0BDh, 82h, 0CCh, 81h, 40h, 8Eh, 70h, 82h, 0B3h, 82h, 0AAh, 82h, 0B5h, 82h, 0C4h, 81h, 40h, 8Eh, 84h, 82h, 0D1h, 82h, 0B5h, 82h, 0E5h, 94h, 47h, 82h, 0EAh, 82h, 0E6h, 81h, 40h, 81h, 40h, 0
txt_1F5F:	; "風邪薬じゃ　治らないわ　すぐにここに来て！　"
	DB	18, 23	; x, y
	DB	95h, 97h, 8Eh, 0D7h, 96h, 0F2h, 82h, 0B6h, 82h, 0E1h, 81h, 40h, 8Eh, 0A1h, 82h, 0E7h, 82h, 0C8h, 82h, 0A2h, 82h, 0EDh, 81h, 40h, 82h, 0B7h, 82h, 0AEh, 82h, 0C9h, 82h, 0B1h, 82h, 0B1h, 82h, 0C9h, 97h, 88h, 82h, 0C4h, 81h, 49h, 81h, 40h, 0
txt_1F8E:	; "　チャージＯＮ！　プラズマフラーッシュ！　　"
	DB	18, 23	; x, y
	DB	81h, 40h, 83h, 60h, 83h, 83h, 81h, 5Bh, 83h, 57h, 82h, 6Eh, 82h, 6Dh, 81h, 49h, 81h, 40h, 83h, 76h, 83h, 89h, 83h, 59h, 83h, 7Dh, 83h, 74h, 83h, 89h, 81h, 5Bh, 83h, 62h, 83h, 56h, 83h, 85h, 81h, 49h, 81h, 40h, 81h, 40h, 0
txt_1FBD:	; "　バンドエイド貼ってよ　この胸のチクチク　　"
	DB	18, 23	; x, y
	DB	81h, 40h, 83h, 6Fh, 83h, 93h, 83h, 68h, 83h, 47h, 83h, 43h, 83h, 68h, 93h, 5Ch, 82h, 0C1h, 82h, 0C4h, 82h, 0E6h, 81h, 40h, 82h, 0B1h, 82h, 0CCh, 8Bh, 0B9h, 82h, 0CCh, 83h, 60h, 83h, 4Eh, 83h, 60h, 83h, 4Eh, 81h, 40h, 81h, 40h, 0
txt_1FEC:	; "　　　ナース！　ナース！　電撃ナース！　　　"
	DB	18, 23	; x, y
	DB	81h, 40h, 81h, 40h, 81h, 40h, 83h, 69h, 81h, 5Bh, 83h, 58h, 81h, 49h, 81h, 40h, 83h, 69h, 81h, 5Bh, 83h, 58h, 81h, 49h, 81h, 40h, 93h, 64h, 8Ch, 82h, 83h, 69h, 81h, 5Bh, 83h, 58h, 81h, 49h, 81h, 40h, 81h, 40h, 81h, 40h, 0
txt_201B:	; "　　　ナース！　ナース！　電撃ナース！　　　"
	DB	18, 23	; x, y
	DB	81h, 40h, 81h, 40h, 81h, 40h, 83h, 69h, 81h, 5Bh, 83h, 58h, 81h, 49h, 81h, 40h, 83h, 69h, 81h, 5Bh, 83h, 58h, 81h, 49h, 81h, 40h, 93h, 64h, 8Ch, 82h, 83h, 69h, 81h, 5Bh, 83h, 58h, 81h, 49h, 81h, 40h, 81h, 40h, 81h, 40h, 0
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
kar_2078:	DW	tramAddr(20, 23), COLCHG_END
kar_207C:	DW	tramAddr(21, 23), COLCHG_END
kar_2080:	DW	tramAddr(22, 23), COLCHG_END
kar_2084:	DW	tramAddr(23, 23), COLCHG_END
kar_2088:	DW	tramAddr(26, 23), tramAddr(27, 23), COLCHG_END
kar_208E:	DW	tramAddr(28, 23), tramAddr(29, 23), COLCHG_END
kar_2094:	DW	tramAddr(30, 23), tramAddr(31, 23), COLCHG_END
kar_209A:	DW	tramAddr(32, 23), tramAddr(33, 23), COLCHG_END
kar_20A0:	DW	tramAddr(34, 23), COLCHG_END
kar_20A4:	DW	tramAddr(35, 23), COLCHG_END
kar_20A8:	DW	tramAddr(36, 23), tramAddr(37, 23), COLCHG_END
kar_20AE:	DW	tramAddr(40, 23), COLCHG_END
kar_20B2:	DW	tramAddr(41, 23), COLCHG_END
kar_20B6:	DW	tramAddr(42, 23), tramAddr(43, 23), COLCHG_END
kar_20BC:	DW	tramAddr(44, 23), COLCHG_END
kar_20C0:	DW	tramAddr(45, 23), COLCHG_END
kar_20C4:	DW	tramAddr(48, 23), COLCHG_END
kar_20C8:	DW	tramAddr(49, 23), COLCHG_END
kar_20CC:	DW	tramAddr(50, 23), tramAddr(51, 23), COLCHG_END
kar_20D2:	DW	tramAddr(52, 23), COLCHG_END
kar_20D6:	DW	tramAddr(53, 23), COLCHG_END
kar_20DA:	DW	tramAddr(54, 23), tramAddr(55, 23), COLCHG_END
kar_20E0:	DW	tramAddr(56, 23), tramAddr(57, 23), COLCHG_END
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
kar_210C:	DW	tramAddr(20, 23), tramAddr(21, 23), COLCHG_END
kar_2112:	DW	tramAddr(22, 23), tramAddr(23, 23), COLCHG_END
kar_2118:	DW	tramAddr(24, 23), tramAddr(25, 23), COLCHG_END
kar_211E:	DW	tramAddr(26, 23), tramAddr(27, 23), COLCHG_END
kar_2124:	DW	tramAddr(30, 23), COLCHG_END
kar_2128:	DW	tramAddr(31, 23), COLCHG_END
kar_212C:	DW	tramAddr(32, 23), tramAddr(33, 23), COLCHG_END
kar_2132:	DW	tramAddr(34, 23), tramAddr(35, 23), COLCHG_END
kar_2138:	DW	tramAddr(36, 23), tramAddr(37, 23), COLCHG_END
kar_213E:	DW	tramAddr(38, 23), tramAddr(39, 23), COLCHG_END
kar_2144:	DW	tramAddr(40, 23), tramAddr(41, 23), COLCHG_END
kar_214A:	DW	tramAddr(44, 23), COLCHG_END
kar_214E:	DW	tramAddr(45, 23), COLCHG_END
kar_2152:	DW	tramAddr(46, 23), tramAddr(47, 23), COLCHG_END
kar_2158:	DW	tramAddr(48, 23), tramAddr(49, 23), COLCHG_END
kar_215E:	DW	tramAddr(50, 23), tramAddr(51, 23), COLCHG_END
kar_2164:	DW	tramAddr(52, 23), tramAddr(53, 23), COLCHG_END
kar_216A:	DW	tramAddr(54, 23), tramAddr(55, 23), COLCHG_END
kar_2170:	DW	tramAddr(56, 23), tramAddr(57, 23), COLCHG_END
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
kar_219C:	DW	tramAddr(18, 23), tramAddr(19, 23), COLCHG_END
kar_21A2:	DW	tramAddr(20, 23), tramAddr(21, 23), COLCHG_END
kar_21A8:	DW	tramAddr(22, 23), COLCHG_END
kar_21AC:	DW	tramAddr(23, 23), COLCHG_END
kar_21B0:	DW	tramAddr(24, 23), tramAddr(25, 23), COLCHG_END
kar_21B6:	DW	tramAddr(28, 23), tramAddr(29, 23), COLCHG_END
kar_21BC:	DW	tramAddr(30, 23), tramAddr(31, 23), COLCHG_END
kar_21C2:	DW	tramAddr(32, 23), tramAddr(33, 23), COLCHG_END
kar_21C8:	DW	tramAddr(34, 23), tramAddr(35, 23), COLCHG_END
kar_21CE:	DW	tramAddr(36, 23), tramAddr(37, 23), COLCHG_END
kar_21D4:	DW	tramAddr(38, 23), tramAddr(39, 23), COLCHG_END
kar_21DA:	DW	tramAddr(42, 23), tramAddr(43, 23), COLCHG_END
kar_21E0:	DW	tramAddr(44, 23), tramAddr(45, 23), COLCHG_END
kar_21E6:	DW	tramAddr(46, 23), tramAddr(47, 23), COLCHG_END
kar_21EC:	DW	tramAddr(48, 23), tramAddr(49, 23), COLCHG_END
kar_21F2:	DW	tramAddr(50, 23), tramAddr(51, 23), COLCHG_END
kar_21F8:	DW	tramAddr(52, 23), tramAddr(53, 23), COLCHG_END
kar_21FE:	DW	tramAddr(54, 23), tramAddr(55, 23), COLCHG_END
kar_2204:	DW	tramAddr(56, 23), tramAddr(57, 23), tramAddr(58, 23), tramAddr(59, 23), COLCHG_END
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
kar_222E:	DW	tramAddr(20, 23), tramAddr(21, 23), COLCHG_END
kar_2234:	DW	tramAddr(22, 23), tramAddr(23, 23), COLCHG_END
kar_223A:	DW	tramAddr(24, 23), tramAddr(25, 23), COLCHG_END
kar_2240:	DW	tramAddr(26, 23), tramAddr(27, 23), COLCHG_END
kar_2246:	DW	tramAddr(28, 23), tramAddr(29, 23), COLCHG_END
kar_224C:	DW	tramAddr(30, 23), tramAddr(31, 23), tramAddr(32, 23), tramAddr(33, 23), COLCHG_END
kar_2256:	DW	tramAddr(36, 23), tramAddr(37, 23), COLCHG_END
kar_225C:	DW	tramAddr(38, 23), tramAddr(39, 23), COLCHG_END
kar_2262:	DW	tramAddr(40, 23), tramAddr(41, 23), COLCHG_END
kar_2268:	DW	tramAddr(42, 23), tramAddr(43, 23), COLCHG_END
kar_226E:	DW	tramAddr(44, 23), tramAddr(45, 23), COLCHG_END
kar_2274:	DW	tramAddr(46, 23), tramAddr(47, 23), COLCHG_END
kar_227A:	DW	tramAddr(48, 23), tramAddr(49, 23), COLCHG_END
kar_2280:	DW	tramAddr(50, 23), tramAddr(51, 23), COLCHG_END
kar_2286:	DW	tramAddr(52, 23), tramAddr(53, 23), COLCHG_END
kar_228C:	DW	tramAddr(54, 23), tramAddr(55, 23), tramAddr(56, 23), tramAddr(57, 23), COLCHG_END
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
kar_22BA:	DW	tramAddr(24, 23), COLCHG_END
kar_22BE:	DW	tramAddr(25, 23), COLCHG_END
kar_22C2:	DW	tramAddr(26, 23), COLCHG_END
kar_22C6:	DW	tramAddr(27, 23), COLCHG_END
kar_22CA:	DW	tramAddr(28, 23), tramAddr(29, 23), COLCHG_END
kar_22D0:	DW	tramAddr(30, 23), tramAddr(31, 23), COLCHG_END
kar_22D6:	DW	tramAddr(32, 23), tramAddr(33, 23), COLCHG_END
kar_22DC:	DW	tramAddr(34, 23), tramAddr(35, 23), COLCHG_END
kar_22E2:	DW	tramAddr(36, 23), tramAddr(37, 23), COLCHG_END
kar_22E8:	DW	tramAddr(40, 23), tramAddr(41, 23), COLCHG_END
kar_22EE:	DW	tramAddr(42, 23), tramAddr(43, 23), COLCHG_END
kar_22F4:	DW	tramAddr(44, 23), COLCHG_END
kar_22F8:	DW	tramAddr(45, 23), COLCHG_END
kar_22FC:	DW	tramAddr(46, 23), tramAddr(47, 23), COLCHG_END
kar_2302:	DW	tramAddr(48, 23), tramAddr(49, 23), COLCHG_END
kar_2308:	DW	tramAddr(50, 23), tramAddr(51, 23), COLCHG_END
kar_230E:	DW	tramAddr(52, 23), tramAddr(53, 23), COLCHG_END
kar_2314:	DW	tramAddr(54, 23), tramAddr(55, 23), COLCHG_END
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
kar_2334:	DW	tramAddr(24, 23), tramAddr(25, 23), COLCHG_END
kar_233A:	DW	tramAddr(26, 23), tramAddr(27, 23), COLCHG_END
kar_2340:	DW	tramAddr(28, 23), tramAddr(29, 23), tramAddr(30, 23), tramAddr(31, 23), COLCHG_END
kar_234A:	DW	tramAddr(34, 23), tramAddr(35, 23), COLCHG_END
kar_2350:	DW	tramAddr(36, 23), tramAddr(37, 23), COLCHG_END
kar_2356:	DW	tramAddr(38, 23), tramAddr(39, 23), tramAddr(40, 23), tramAddr(41, 23), COLCHG_END
kar_2360:	DW	tramAddr(44, 23), COLCHG_END
kar_2364:	DW	tramAddr(45, 23), COLCHG_END
kar_2368:	DW	tramAddr(46, 23), COLCHG_END
kar_236C:	DW	tramAddr(47, 23), COLCHG_END
kar_2370:	DW	tramAddr(48, 23), tramAddr(49, 23), COLCHG_END
kar_2376:	DW	tramAddr(50, 23), tramAddr(51, 23), COLCHG_END
kar_237C:	DW	tramAddr(52, 23), tramAddr(53, 23), tramAddr(54, 23), tramAddr(55, 23), COLCHG_END
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
kar_23B4:	DW	tramAddr(18, 23), COLCHG_END
kar_23B8:	DW	tramAddr(19, 23), COLCHG_END
kar_23BC:	DW	tramAddr(20, 23), COLCHG_END
kar_23C0:	DW	tramAddr(21, 23), COLCHG_END
kar_23C4:	DW	tramAddr(24, 23), tramAddr(25, 23), COLCHG_END
kar_23CA:	DW	tramAddr(26, 23), tramAddr(27, 23), tramAddr(28, 23), tramAddr(29, 23), COLCHG_END
kar_23D4:	DW	tramAddr(30, 23), tramAddr(31, 23), COLCHG_END
kar_23DA:	DW	tramAddr(32, 23), tramAddr(33, 23), COLCHG_END
kar_23E0:	DW	tramAddr(34, 23), COLCHG_END
kar_23E4:	DW	tramAddr(35, 23), COLCHG_END
kar_23E8:	DW	tramAddr(36, 23), tramAddr(37, 23), COLCHG_END
kar_23EE:	DW	tramAddr(40, 23), COLCHG_END
kar_23F2:	DW	tramAddr(41, 23), COLCHG_END
kar_23F6:	DW	tramAddr(42, 23), tramAddr(43, 23), COLCHG_END
kar_23FC:	DW	tramAddr(44, 23), COLCHG_END
kar_2400:	DW	tramAddr(45, 23), COLCHG_END
kar_2404:	DW	tramAddr(48, 23), tramAddr(49, 23), COLCHG_END
kar_240A:	DW	tramAddr(50, 23), tramAddr(51, 23), COLCHG_END
kar_2410:	DW	tramAddr(52, 23), tramAddr(53, 23), COLCHG_END
kar_2416:	DW	tramAddr(54, 23), tramAddr(55, 23), COLCHG_END
kar_241C:	DW	tramAddr(56, 23), tramAddr(57, 23), COLCHG_END
kar_2422:	DW	tramAddr(58, 23), tramAddr(59, 23), COLCHG_END
kar_2428:	DW	tramAddr(60, 23), tramAddr(61, 23), COLCHG_END
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
kar_2450:	DW	tramAddr(22, 23), tramAddr(23, 23), COLCHG_END
kar_2456:	DW	tramAddr(24, 23), tramAddr(25, 23), COLCHG_END
kar_245C:	DW	tramAddr(26, 23), tramAddr(27, 23), COLCHG_END
kar_2462:	DW	tramAddr(28, 23), tramAddr(29, 23), COLCHG_END
kar_2468:	DW	tramAddr(32, 23), COLCHG_END
kar_246C:	DW	tramAddr(33, 23), COLCHG_END
kar_2470:	DW	tramAddr(34, 23), tramAddr(35, 23), COLCHG_END
kar_2476:	DW	tramAddr(36, 23), tramAddr(37, 23), COLCHG_END
kar_247C:	DW	tramAddr(38, 23), tramAddr(39, 23), COLCHG_END
kar_2482:	DW	tramAddr(40, 23), tramAddr(41, 23), COLCHG_END
kar_2488:	DW	tramAddr(44, 23), COLCHG_END
kar_248C:	DW	tramAddr(45, 23), COLCHG_END
kar_2490:	DW	tramAddr(46, 23), tramAddr(47, 23), COLCHG_END
kar_2496:	DW	tramAddr(48, 23), tramAddr(49, 23), tramAddr(50, 23), tramAddr(51, 23), COLCHG_END
kar_24A0:	DW	tramAddr(52, 23), tramAddr(53, 23), COLCHG_END
kar_24A6:	DW	tramAddr(54, 23), tramAddr(55, 23), COLCHG_END
kar_24AC:	DW	tramAddr(56, 23), tramAddr(57, 23), COLCHG_END
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
kar_24D8:	DW	tramAddr(18, 23), tramAddr(19, 23), COLCHG_END
kar_24DE:	DW	tramAddr(20, 23), tramAddr(21, 23), COLCHG_END
kar_24E4:	DW	tramAddr(22, 23), COLCHG_END
kar_24E8:	DW	tramAddr(23, 23), COLCHG_END
kar_24EC:	DW	tramAddr(24, 23), tramAddr(25, 23), tramAddr(26, 23), tramAddr(27, 23), COLCHG_END
kar_24F6:	DW	tramAddr(30, 23), COLCHG_END
kar_24FA:	DW	tramAddr(31, 23), COLCHG_END
kar_24FE:	DW	tramAddr(32, 23), tramAddr(33, 23), COLCHG_END
kar_2504:	DW	tramAddr(34, 23), tramAddr(35, 23), COLCHG_END
kar_250A:	DW	tramAddr(36, 23), tramAddr(37, 23), COLCHG_END
kar_2510:	DW	tramAddr(38, 23), tramAddr(39, 23), COLCHG_END
kar_2516:	DW	tramAddr(42, 23), tramAddr(43, 23), COLCHG_END
kar_251C:	DW	tramAddr(44, 23), tramAddr(45, 23), COLCHG_END
kar_2522:	DW	tramAddr(46, 23), tramAddr(47, 23), COLCHG_END
kar_2528:	DW	tramAddr(48, 23), tramAddr(49, 23), COLCHG_END
kar_252E:	DW	tramAddr(50, 23), tramAddr(51, 23), COLCHG_END
kar_2534:	DW	tramAddr(52, 23), tramAddr(53, 23), COLCHG_END
kar_253A:	DW	tramAddr(54, 23), tramAddr(55, 23), COLCHG_END
kar_2540:	DW	tramAddr(56, 23), tramAddr(57, 23), tramAddr(58, 23), tramAddr(59, 23), COLCHG_END
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
kar_2570:	DW	tramAddr(20, 23), tramAddr(21, 23), COLCHG_END
kar_2576:	DW	tramAddr(22, 23), tramAddr(23, 23), COLCHG_END
kar_257C:	DW	tramAddr(24, 23), tramAddr(25, 23), COLCHG_END
kar_2582:	DW	tramAddr(26, 23), tramAddr(27, 23), COLCHG_END
kar_2588:	DW	tramAddr(28, 23), tramAddr(29, 23), COLCHG_END
kar_258E:	DW	tramAddr(30, 23), tramAddr(31, 23), COLCHG_END
kar_2594:	DW	tramAddr(32, 23), tramAddr(33, 23), COLCHG_END
kar_259A:	DW	tramAddr(34, 23), tramAddr(35, 23), COLCHG_END
kar_25A0:	DW	tramAddr(36, 23), tramAddr(37, 23), COLCHG_END
kar_25A6:	DW	tramAddr(38, 23), tramAddr(39, 23), COLCHG_END
kar_25AC:	DW	tramAddr(42, 23), tramAddr(43, 23), COLCHG_END
kar_25B2:	DW	tramAddr(44, 23), tramAddr(45, 23), COLCHG_END
kar_25B8:	DW	tramAddr(46, 23), COLCHG_END
kar_25BC:	DW	tramAddr(47, 23), COLCHG_END
kar_25C0:	DW	tramAddr(48, 23), tramAddr(49, 23), COLCHG_END
kar_25C6:	DW	tramAddr(50, 23), tramAddr(51, 23), COLCHG_END
kar_25CC:	DW	tramAddr(52, 23), tramAddr(53, 23), COLCHG_END
kar_25D2:	DW	tramAddr(54, 23), tramAddr(55, 23), COLCHG_END
kar_25D8:	DW	tramAddr(56, 23), tramAddr(57, 23), COLCHG_END
txt_25DE:	; "Ｈｉｔ　Ｒｅｔｕｒｎ　Ｋｅｙ"
	DB	50, 22	; x, y
	DB	82h, 67h, 82h, 89h, 82h, 94h, 81h, 40h, 82h, 71h, 82h, 85h, 82h, 94h, 82h, 95h, 82h, 92h, 82h, 8Eh, 81h, 40h, 82h, 6Ah, 82h, 85h, 82h, 99h, 0
		db    0	; padding
byte_25FE	db 1			; DATA XREF: seg000:1929r
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
