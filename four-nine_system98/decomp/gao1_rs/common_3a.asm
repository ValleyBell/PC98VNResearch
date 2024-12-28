cloc_103E:	; entry point
	MOVR	i500, i353
	MOVR	i501, i354
cloc_104A:
	TBOPEN	9, 1, 19, 9, 6, 1
	BLIT1I	2, 12, 385, 12, 14, 0, 5, 305
	CHRDLY	i1000
	PRINT	9, cstr_1861
	CHRDLY	i352
cloc_1078:
	CMD3F	i321, i333
	CMD6A	32, 320, 143, 383
	MENUSEL	i112, i113, csel_189D, cloc_109C
cloc_1092:
	CMD43	i321, i333
	JP	cloc_1092

cloc_109C:
	JTBL	i113
	DW	cloc_1408	; 0
	DW	cloc_10A8	; 1
	DW	cloc_1408	; 2
	DW	cloc_10A8	; 3

cloc_10A8:
	TBCLOSE	9
	TBCLOSE	12
	WAITKEY	i0
	TBOPEN	12, 12, 19, 23, 6, 4
	MOVR	i112, i354
	MOVI	i0, 0
	SUBI	i112, 19
	JTBL	i112
	DW	mainloc_01CE	; 0
	DW	mainloc_05B4	; 1
	DW	mainloc_078C	; 2
	DW	mainloc_096C	; 3
	DW	cloc_1378	; 4
	DW	cloc_1378	; 5

cloc_10E4:	; entry point
	TBCLOSE	12
	PALFADE	1, 3
	BLIT1I	2, 72, 96, 8, 32, 0, 0, 0
	BLIT1I	2, 72, 128, 8, 32, 0, 8, 0
	BLIT1I	2, 72, 160, 8, 32, 0, 16, 0
	BLIT1I	2, 72, 192, 8, 32, 0, 0, 32
	BLIT1I	2, 72, 224, 8, 32, 0, 8, 32
	BLIT1I	2, 72, 256, 8, 32, 0, 16, 32
	BLIT1I	2, 72, 0, 8, 32, 0, 0, 64
	BLIT1I	2, 72, 32, 8, 32, 0, 8, 64
	BLIT1I	2, 72, 64, 8, 32, 0, 16, 64
	BLIT1I	0, 0, 0, 24, 96, 0, 24, 0
	BLIT1I	0, 0, 0, 24, 96, 0, 48, 0
	BLIT1I	0, 0, 0, 8, 96, 0, 72, 0
	BLIT1I	0, 12, 0, 60, 96, 0, 0, 96
	BLIT1I	0, 0, 0, 20, 96, 0, 60, 96
	BLIT1I	0, 0, 0, 80, 192, 0, 0, 192
	BLIT1I	0, 0, 0, 80, 16, 0, 0, 384
	MOVI	i112, 72
	MOVI	i113, 304
	MOVI	i114, 4
	MOVI	i115, 16
	MOVI	i116, 2
	MOVI	i117, 336
	BLIT2I	2, 72, 288, 4, 32, 0, 2, 304
cloc_1244:
	BLIT2R	i1002, i112, i113, i114, i115, i1000, i116, i117
	ADDI	i117, 16
	CMPI	i117, 384
	JLT	cloc_1244
	MOVI	i112, 74
	MOVI	i113, 288
	MOVI	i114, 2
	MOVI	i115, 16
	MOVI	i116, 6
	MOVI	i117, 304
cloc_128A:
	CALL	cloc_0FF6
	MOVI	i113, 288
	ADDI	i116, 1
	CMPI	i116, 75
	JLT	cloc_128A
	BLIT2I	2, 72, 320, 2, 16, 0, 2, 384
	MOVI	i112, 74
	MOVI	i113, 320
	MOVI	i114, 2
	MOVI	i115, 16
	MOVI	i116, 4
	MOVI	i117, 384
cloc_12DA:
	BLIT2R	i1002, i112, i113, i114, i115, i1000, i116, i117
	ADDI	i116, 2
	CMPI	i116, 75
	JLT	cloc_12DA
	BLIT2I	2, 76, 288, 2, 16, 0, 76, 304
	MOVI	i112, 76
	MOVI	i113, 304
	MOVI	i116, 76
	MOVI	i117, 320
cloc_1326:
	BLIT2R	i1002, i112, i113, i114, i115, i1000, i116, i117
	ADDI	i117, 16
	CMPI	i117, 384
	JLT	cloc_1326
	BLIT2I	2, 76, 320, 2, 16, 0, 76, 384
	PALBW	1, 3
	JTBL	i353
	DW	cloc_1378	; 0
	DW	cloc_1378	; 1
	DW	cloc_137C	; 2
	DW	cloc_1380	; 3
	DW	cloc_1384	; 4
	DW	cloc_1388	; 5
	DW	cloc_138C	; 6
	DW	cloc_1390	; 7
	DW	cloc_1394	; 8
	DW	cloc_1398	; 9

cloc_1378:
	LDSCENE	cfile_139C	; snr\s1.lsp

cloc_137C:
	LDSCENE	cfile_13A8	; snr\s2.lsp

cloc_1380:
	LDSCENE	cfile_13B4	; snr\s3.lsp

cloc_1384:
	LDSCENE	cfile_13C0	; snr\s4.lsp

cloc_1388:
	LDSCENE	cfile_13CC	; snr\s5.lsp

cloc_138C:
	LDSCENE	cfile_13D8	; snr\s6.lsp

cloc_1390:
	LDSCENE	cfile_13E4	; snr\s7.lsp

cloc_1394:
	LDSCENE	cfile_13F0	; snr\s8.lsp

cloc_1398:
	LDSCENE	cfile_13FC	; snr\s9.lsp

cfile_139C:
	DB	1, "snr\\s1.lsp", 0
cfile_13A8:
	DB	1, "snr\\s2.lsp", 0
cfile_13B4:
	DB	1, "snr\\s3.lsp", 0
cfile_13C0:
	DB	1, "snr\\s4.lsp", 0
cfile_13CC:
	DB	1, "snr\\s5.lsp", 0
cfile_13D8:
	DB	1, "snr\\s6.lsp", 0
cfile_13E4:
	DB	1, "snr\\s7.lsp", 0
cfile_13F0:
	DB	1, "snr\\s8.lsp", 0
cfile_13FC:
	DB	1, "snr\\s9.lsp", 0

cloc_1408:
	SUBI	i112, 1
	JTBL	i112
	DW	cloc_141A	; 0
	DW	cloc_1501	; 1
	DW	cloc_16AD	; 2
	DW	cloc_1798	; 3

cloc_141A:
	CMD3F	i323, i334
	CMD6A	16, 336, 127, 383
	TBOPEN	10, 0, 20, 9, 5, 1
	CHRDLY	i1000
	PRINT	10, cstr_1929
	CHRDLY	i352
	MENUSEL	i112, i113, csel_18C7, cloc_145A
cloc_1450:
	CMD43	i323, i334
	JP	cloc_1450

cloc_145A:
	JTBL	i113
	DW	cloc_146E	; 0
	DW	cloc_1466	; 1
	DW	cloc_146E	; 2
	DW	cloc_1466	; 3

cloc_1466:
	TBCLOSE	10
	JP	cloc_1078

cloc_146E:
	SUBI	i112, 1
	TBCLOSE	10
	TBCLOSE	9
	JTBL	i112
	DW	cloc_14BF	; 0
	DW	cloc_14D5	; 1
	DW	cloc_14EB	; 2
cstr_1486:
	DS	"セーブしました。", 1, 0
cstr_1498:
	DS	"ファイル１に", 0
cstr_14A5:
	DS	"ファイル２に", 0
cstr_14B2:
	DS	"ファイル３に", 0

cloc_14BF:
	REGFSAV	0, cfile_1989	; save_f1.lsp
	PRINT	12, cstr_1498
	PRINT	12, cstr_1486
	JP	cloc_104A

cloc_14D5:
	REGFSAV	0, cfile_1996	; save_f2.lsp
	PRINT	12, cstr_14A5
	PRINT	12, cstr_1486
	JP	cloc_104A

cloc_14EB:
	REGFSAV	0, cfile_19A3	; save_f3.lsp
	PRINT	12, cstr_14B2
	PRINT	12, cstr_1486
	JP	cloc_104A

cloc_1501:
	FILETM	i113, s3, cfile_1989	; save_f1.lsp
	FILETM	i114, s4, cfile_1996	; save_f2.lsp
	FILETM	i115, s5, cfile_19A3	; save_f3.lsp
	MOVR	i112, i113
	ADDR	i112, i114
	ADDR	i112, i115
	CMD3F	i325, i335
	JTBL	i112
	DW	cloc_1078	; 0
	DW	cloc_153D	; 1
	DW	cloc_1559	; 2
	DW	cloc_1575	; 3

cloc_153D:
	TBOPEN	10, 0, 22, 19, 3, 1
	CMD6A	16, 368, 127, 383
	JP	cloc_158D

cloc_1559:
	TBOPEN	10, 0, 21, 19, 4, 1
	CMD6A	16, 352, 127, 383
	JP	cloc_158D

cloc_1575:
	TBOPEN	10, 0, 20, 19, 5, 1
	CMD6A	16, 336, 127, 383
cloc_158D:
	STRCLR	s6
	STRCLR	s7
	STRCLR	s8
	CHRDLY	i1000
	CMPI	i113, 0
	JEQ	cloc_15B9
	STRCPYI	s6, cstr_1956
	STRCAT	s6, s3
	STRCPYI	s6, cstr_1980
cloc_15B9:
	CMPI	i114, 0
	JEQ	cloc_15D5
	STRCPYI	s7, cstr_1964
	STRCAT	s7, s4
	STRCPYI	s7, cstr_1980
cloc_15D5:
	CMPI	i115, 0
	JEQ	cloc_15F1
	STRCPYI	s8, cstr_1972
	STRCAT	s8, s5
	STRCPYI	s8, cstr_1980
cloc_15F1:
	PRINT	10, cstr_1982
	CHRDLY	i352
	JTBL	i112
	DW	cloc_1643	; 0
	DW	cloc_1607	; 1
	DW	cloc_1615	; 2
	DW	cloc_1623	; 3

cloc_1607:
	MENUSEL	i118, i117, csel_191D, cloc_1637
	JP	cloc_162D

cloc_1615:
	MENUSEL	i118, i117, csel_1907, cloc_1637
	JP	cloc_162D

cloc_1623:
	MENUSEL	i118, i117, csel_18E7, cloc_1637
cloc_162D:
	CMD43	i325, i335
	JP	cloc_162D

cloc_1637:
	JTBL	i117
	DW	cloc_164B	; 0
	DW	cloc_1643	; 1
	DW	cloc_164B	; 2
	DW	cloc_1643	; 3

cloc_1643:
	TBCLOSE	10
	JP	cloc_1078

cloc_164B:
	TBCLOSE	10
	TBCLOSE	9
	SUBI	i118, 1
	MOVI	i0, 0
	JTBL	i113
	DW	cloc_1677	; 0
	DW	cloc_1667	; 1

cloc_1667:
	SUBI	i118, 1
	CMPI	i0, 0
	JNE	cloc_1699
cloc_1677:
	JTBL	i114
	DW	cloc_168F	; 0
	DW	cloc_167F	; 1

cloc_167F:
	SUBI	i118, 1
	CMPI	i0, 0
	JNE	cloc_16A3
cloc_168F:
	REGFLD	0, cfile_19A3	; save_f3.lsp
	JP	cloc_10E4

cloc_1699:
	REGFLD	0, cfile_1989	; save_f1.lsp
	JP	cloc_10E4

cloc_16A3:
	REGFLD	0, cfile_1996	; save_f2.lsp
	JP	cloc_10E4

cloc_16AD:
	CMD3F	i336, i0
	TBOPEN	10, 1, 22, 10, 3, 1
	CHRDLY	i1000
	PRINT	10, cstr_16ED
	CHRDLY	i352
	CMD6A	80, 368, 111, 383
	MENUSEL	i112, i113, csel_17EF, cloc_16FE
cloc_16E3:
	CMD43	i336, i0
	JP	cloc_16E3

cstr_16ED:
	DS	" 　小　  　大 　", 0

cloc_16FE:
	TBCLOSE	10
	JTBL	i113
	DW	cloc_1712	; 0
	DW	cloc_170E	; 1
	DW	cloc_1712	; 2
	DW	cloc_170E	; 3

cloc_170E:
	JP	cloc_1078

cloc_1712:
	SUBI	i112, 1
	JTBL	i112
	DW	cloc_1720	; 0
	DW	cloc_1734	; 1

cloc_1720:
	MOVI	i352, 1
	CHRDLY	i352
	PRINT	12, cstr_1748
	JP	cloc_1078

cloc_1734:
	MOVI	i352, 5
	CHRDLY	i352
	PRINT	12, cstr_1770
	JP	cloc_1078

cstr_1748:
	DS	"メッセージウェイトを＜小＞にしました。", 1, 0
cstr_1770:
	DS	"メッセージウェイトを＜大＞にしました。", 1, 0

cloc_1798:
	CMD3F	i337, i0
	PRINT	12, cstr_183D
	TBOPEN	10, 1, 22, 10, 3, 1
	CHRDLY	i1000
	PRINT	10, cstr_17DE
	CHRDLY	i352
	CMD6A	80, 368, 111, 383
	MENUSEL	i112, i113, csel_17EF, cloc_1805
cloc_17D4:
	CMD43	i337, i0
	JP	cloc_17D4

cstr_17DE:
	DS	"  はい   いいえ ", 0
csel_17EF:
	DW	1, 32, 368, 96, 384
	DW	2, 96, 368, 160, 384
	DW	0

cloc_1805:
	TBCLOSE	10
	JTBL	i113
	DW	cloc_181D	; 0
	DW	cloc_1815	; 1
	DW	cloc_181D	; 2
	DW	cloc_1815	; 3

cloc_1815:
	TBCLEAR	12
	JP	cloc_1078

cloc_181D:
	SUBI	i112, 1
	JTBL	i112
	DW	cloc_182B	; 0
	DW	cloc_1815	; 1

cloc_182B:
	TBCLOSE	9
	PALFADE	0, 0
	GV02
	BGMFADE
	GV02

cunk_183B:	; unused
	DB	0xFF, 0xFF
cstr_183D:
	DS	"ＤＯＳに戻ります。", 0x0D
	DS	"よろしいですか？", 0
cstr_1861:
	DS	"　 Ｓａｖｅ 　", 0x0D
	DS	"　 Ｌｏａｄ 　", 0x0D
	DS	"　 Ｗａｉｔ 　", 0x0D
	DS	"　 Ｅｘｉｔ 　", 0
csel_189D:
	DW	1, 32, 320, 144, 336
	DW	2, 32, 336, 144, 352
	DW	3, 32, 352, 144, 368
	DW	4, 32, 368, 144, 384
	DW	0
csel_18C7:
	DW	1, 16, 336, 128, 352
	DW	2, 16, 352, 128, 368
	DW	3, 16, 368, 128, 384
	DW	0
csel_18E7:
	DW	1, 16, 336, 288, 352
	DW	2, 16, 352, 288, 368
	DW	3, 16, 368, 288, 384
	DW	0
csel_1907:
	DW	1, 16, 352, 288, 368
	DW	2, 16, 368, 288, 384
	DW	0
csel_191D:
	DW	1, 16, 368, 288, 384
	DW	0
cstr_1929:
	DS	"　ファイル１　", 0x0D
	DS	"　ファイル２　", 0x0D
	DS	"　ファイル３　", 0
cstr_1956:
	DS	"　ファイル１ ", 0
cstr_1964:
	DS	"　ファイル２ ", 0
cstr_1972:
	DS	"　ファイル３ ", 0
cstr_1980:
	DS	0x0D, 0
cstr_1982:
	DS	4, 6, 4, 7, 4, 8, 0
cfile_1989:
	DB	1, "save_f1.lsp", 0
cfile_1996:
	DB	1, "save_f2.lsp", 0
cfile_19A3:
	DB	1, "save_f3.lsp", 0
