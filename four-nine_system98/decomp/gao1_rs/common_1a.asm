cloc_03C4:	; entry point
	MOVR	i500, i353
	MOVR	i501, i354
cloc_03D0:
	TBOPEN	9, 31, 9, 9, 6, 1
	CMD2F	2, 12, 385, 12, 14, 0, 65, 145
	CHRDLY	i1000
	PRINT	9, cstr_0A14
	CHRDLY	i352
cloc_03FE:
	CMD3F	i321, i333
	CMD6A	512, 160, 623, 223
	MENUSEL	i112, i113, csel_0A50, cloc_0426
cloc_0418:
	CMD42	1
	CMD43	i321, i333
	JP	cloc_0418

cloc_0426:
	JTBL	i113
	DW	cloc_043A	; 0
	DW	cloc_0432	; 1
	DW	cloc_043A	; 2
	DW	cloc_0432	; 3

cloc_0432:
	TBCLOSE	9
	JP	mainloc_0182

cloc_043A:
	SUBI	i112, 1
	JTBL	i112
	DW	cloc_044C	; 0
	DW	cloc_04FE	; 1
	DW	cloc_06E0	; 2
	DW	cloc_076A	; 3

cloc_044C:
	CMD3F	i323, i334
	CMD6A	496, 192, 607, 239
	TBOPEN	10, 30, 11, 9, 5, 1
	CHRDLY	i1000
	PRINT	10, cstr_0A7A
	CHRDLY	i352
	MENUSEL	i112, i113, csel_0AA7, cloc_0490
cloc_0482:
	CMD42	1
	CMD43	i323, i334
	JP	cloc_0482

cloc_0490:
	JTBL	i113
	DW	cloc_04A4	; 0
	DW	cloc_049C	; 1
	DW	cloc_04A4	; 2
	DW	cloc_049C	; 3

cloc_049C:
	TBCLOSE	10
	JP	cloc_03FE

cloc_04A4:
	TBCLOSE	10
	TBCLOSE	9
	SUBI	i112, 1
	JTBL	i112
	DW	cloc_04BC	; 0
	DW	cloc_04D2	; 1
	DW	cloc_04E8	; 2

cloc_04BC:
	REGFSAV	0, cfile_0AE7	; SAVE_F1.LSP
	PRINT	0, cstr_0B0E
	PRINT	0, cstr_0B35
	JP	cloc_03D0

cloc_04D2:
	REGFSAV	0, cfile_0AF4	; SAVE_F2.LSP
	PRINT	0, cstr_0B1B
	PRINT	0, cstr_0B35
	JP	cloc_03D0

cloc_04E8:
	REGFSAV	0, cfile_0B01	; SAVE_F3.LSP
	PRINT	0, cstr_0B28
	PRINT	0, cstr_0B35
	JP	cloc_03D0

cloc_04FE:
	FILETM	i113, s3, cfile_0AE7	; SAVE_F1.LSP
	FILETM	i114, s4, cfile_0AF4	; SAVE_F2.LSP
	FILETM	i115, s5, cfile_0B01	; SAVE_F3.LSP
	MOVR	i112, i113
	ADDR	i112, i114
	ADDR	i112, i115
	JTBL	i112
	DW	cloc_03FE	; 0
	DW	cloc_0534	; 1
	DW	cloc_0550	; 2
	DW	cloc_056C	; 3

cloc_0534:
	TBOPEN	10, 20, 12, 19, 3, 1
	CMD6A	496, 208, 607, 223
	JP	cloc_0584

cloc_0550:
	TBOPEN	10, 20, 12, 19, 4, 1
	CMD6A	496, 208, 607, 239
	JP	cloc_0584

cloc_056C:
	TBOPEN	10, 20, 12, 19, 5, 1
	CMD6A	496, 208, 607, 255
cloc_0584:
	CMD3F	i325, i335
	STRCLR	s6
	STRCLR	s7
	STRCLR	s8
	CMPI	i113, 0
	JEQ	cloc_05B2
	STRCPYI	s6, cstr_0B4E
	STRCAT	s6, s3
	STRCPYI	s6, cstr_0B78
cloc_05B2:
	CMPI	i114, 0
	JEQ	cloc_05CE
	STRCPYI	s7, cstr_0B5C
	STRCAT	s7, s4
	STRCPYI	s7, cstr_0B78
cloc_05CE:
	CMPI	i115, 0
	JEQ	cloc_05EA
	STRCPYI	s8, cstr_0B6A
	STRCAT	s8, s5
	STRCPYI	s8, cstr_0B78
cloc_05EA:
	CHRDLY	i1000
	PRINT	10, cstr_0B47
	CHRDLY	i352
	JTBL	i112
	DW	cloc_0644	; 0
	DW	cloc_0604	; 1
	DW	cloc_0612	; 2
	DW	cloc_0620	; 3

cloc_0604:
	MENUSEL	i118, i117, csel_0ADB, cloc_0638
	JP	cloc_062A

cloc_0612:
	MENUSEL	i118, i117, csel_0AD1, cloc_0638
	JP	cloc_062A

cloc_0620:
	MENUSEL	i118, i117, csel_0AC7, cloc_0638
cloc_062A:
	CMD42	1
	CMD43	i325, i335
	JP	cloc_062A

cloc_0638:
	JTBL	i117
	DW	cloc_064C	; 0
	DW	cloc_0644	; 1
	DW	cloc_064C	; 2
	DW	cloc_0644	; 3

cloc_0644:
	TBCLOSE	10
	JP	cloc_03FE

cloc_064C:
	TBCLOSE	10
	TBCLOSE	9
	SUBI	i118, 1
	JTBL	i118
	DW	cloc_0664	; 0
	DW	cloc_0678	; 1
	DW	cloc_068C	; 2

cloc_0664:
	CMPI	i113, 0
	JEQ	mainloc_0182
	REGFLD	0, cfile_0AE7	; SAVE_F1.LSP
	JP	cloc_06A0

cloc_0678:
	CMPI	i114, 0
	JEQ	mainloc_0182
	REGFLD	0, cfile_0AF4	; SAVE_F2.LSP
	JP	cloc_06A0

cloc_068C:
	CMPI	i115, 0
	JEQ	mainloc_0182
	REGFLD	0, cfile_0B01	; SAVE_F3.LSP
	JP	cloc_06A0

cloc_06A0:
	JTBL	i353
	DW	cloc_06B8	; 0
	DW	cloc_06BC	; 1
	DW	cloc_06C0	; 2
	DW	cloc_06C4	; 3
	DW	cloc_06C8	; 4
	DW	cloc_06CC	; 5
	DW	cloc_06D0	; 6
	DW	cloc_06D4	; 7
	DW	cloc_06D8	; 8
	DW	cloc_06DC	; 9

cloc_06B8:
	LDSCENE	cfile_099C	; SNR\S0.LSP

cloc_06BC:
	LDSCENE	cfile_09A8	; SNR\S1.LSP

cloc_06C0:
	LDSCENE	cfile_09B4	; SNR\S2.LSP

cloc_06C4:
	LDSCENE	cfile_09C0	; SNR\S3.LSP

cloc_06C8:
	LDSCENE	cfile_09CC	; SNR\S4.LSP

cloc_06CC:
	LDSCENE	cfile_09D8	; SNR\S5.LSP

cloc_06D0:
	LDSCENE	cfile_09E4	; SNR\S6.LSP

cloc_06D4:
	LDSCENE	cfile_09F0	; SNR\S7.LSP

cloc_06D8:
	LDSCENE	cfile_09FC	; SNR\S8.LSP

cloc_06DC:
	LDSCENE	cfile_0A08	; SNR\S9.LSP

cloc_06E0:
	CMD3F	i336, i0
	TBOPEN	10, 31, 13, 8, 3, 1
	CHRDLY	i1000
	PRINT	10, cstr_0B7A
	CHRDLY	i352
	CMD6A	544, 224, 575, 239
	MENUSEL	i112, i113, csel_0B87, cloc_0724
cloc_0716:
	CMD42	1
	CMD43	i336, i0
	JP	cloc_0716

cloc_0724:
	TBCLOSE	10
	JTBL	i113
	DW	cloc_0734	; 0
	DW	cloc_03FE	; 1
	DW	cloc_0734	; 2
	DW	cloc_03FE	; 3

cloc_0734:
	SUBI	i112, 1
	JTBL	i112
	DW	cloc_0742	; 0
	DW	cloc_0756	; 1

cloc_0742:
	MOVI	i352, 1
	CHRDLY	i352
	PRINT	0, cstr_0B9D
	JP	cloc_03FE

cloc_0756:
	MOVI	i352, 5
	CHRDLY	i352
	PRINT	0, cstr_0BC5
	JP	cloc_03FE

cloc_076A:
	CMD3F	i337, i0
	PRINT	0, cstr_0BED
	TBOPEN	10, 31, 14, 8, 3, 1
	CHRDLY	i1000
	PRINT	10, cstr_0C11
	CHRDLY	i352
	CMD6A	544, 240, 575, 255
	MENUSEL	i112, i113, csel_0C1E, cloc_07B4
cloc_07A6:
	CMD42	1
	CMD43	i337, i0
	JP	cloc_07A6

cloc_07B4:
	TBCLOSE	10
	JTBL	i113
	DW	cloc_07CC	; 0
	DW	cloc_07C4	; 1
	DW	cloc_07CC	; 2
	DW	cloc_07C4	; 3

cloc_07C4:
	TBCLEAR	0
	JP	cloc_03FE

cloc_07CC:
	SUBI	i112, 1
	JTBL	i112
	DW	cloc_07DA	; 0
	DW	cloc_07C4	; 1

cloc_07DA:
	TBCLOSE	9
	PALFADE	0, 0
	BGMFADE
	GV02
	DOSEXIT
