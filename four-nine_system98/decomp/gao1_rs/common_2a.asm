cloc_03BA:	; entry point
	MOVR	i500, i353
	MOVR	i501, i354
cloc_03C6:
	TBOPEN	9, 31, 9, 9, 6, 1
	BLIT1I	2, 12, 385, 12, 14, 0, 65, 145
	CHRDLY	i1000
	PRINT	9, cstr_0961
	CHRDLY	i352
cloc_03F4:
	CMD3F	i321, i333
	CMD6A	512, 160, 623, 223
	MENUSEL	i112, i113, csel_099D, cloc_0418
cloc_040E:
	CMD43	i321, i333
	JP	cloc_040E

cloc_0418:
	JTBL	i113
	DW	cloc_04FA	; 0
	DW	cloc_0424	; 1
	DW	cloc_04FA	; 2
	DW	cloc_0424	; 3

cloc_0424:
	TBCLOSE	9
	CMPR	i500, i353
	JNE	cloc_0440
	CMPR	i501, i354
	JNE	cloc_0440
	JP	mainloc_01AC

cloc_0440:
	GFX84
cloc_0442:	; used by RSH001
	JTBL	i353
	DW	cloc_045A	; 0
	DW	cloc_045E	; 1
	DW	cloc_0462	; 2
	DW	cloc_0466	; 3
	DW	cloc_046A	; 4
	DW	cloc_046E	; 5
	DW	cloc_0472	; 6
	DW	cloc_0476	; 7
	DW	cloc_047A	; 8
	DW	cloc_047E	; 9

cloc_045A:
	LDSCENE	cfile_0482	; snr\s0.lsp

cloc_045E:
	LDSCENE	cfile_048E	; snr\s1.lsp

cloc_0462:
	LDSCENE	cfile_049A	; snr\s2.lsp

cloc_0466:
	LDSCENE	cfile_04A6	; snr\s3.lsp

cloc_046A:
	LDSCENE	cfile_04B2	; snr\s4.lsp

cloc_046E:
	LDSCENE	cfile_04BE	; snr\s5.lsp

cloc_0472:
	LDSCENE	cfile_04CA	; snr\s6.lsp

cloc_0476:
	LDSCENE	cfile_04D6	; snr\s7.lsp

cloc_047A:
	LDSCENE	cfile_04E2	; snr\s8.lsp

cloc_047E:
	LDSCENE	cfile_04EE	; snr\s9.lsp

cfile_0482:
	DB	1, "snr\\s0.lsp", 0
cfile_048E:
	DB	1, "snr\\s1.lsp", 0
cfile_049A:
	DB	1, "snr\\s2.lsp", 0
cfile_04A6:
	DB	1, "snr\\s3.lsp", 0
cfile_04B2:
	DB	1, "snr\\s4.lsp", 0
cfile_04BE:
	DB	1, "snr\\s5.lsp", 0
cfile_04CA:
	DB	1, "snr\\s6.lsp", 0
cfile_04D6:
	DB	1, "snr\\s7.lsp", 0
cfile_04E2:
	DB	1, "snr\\s8.lsp", 0
cfile_04EE:
	DB	1, "snr\\s9.lsp", 0

cloc_04FA:
	SUBI	i112, 1
	JTBL	i112
	DW	cloc_050C	; 0
	DW	cloc_05F3	; 1
	DW	cloc_079F	; 2
	DW	cloc_089C	; 3

cloc_050C:
	CMD3F	i323, i334
	CMD6A	496, 192, 607, 239
	TBOPEN	10, 30, 11, 9, 5, 1
	CHRDLY	i1000
	PRINT	10, cstr_0A07
	CHRDLY	i352
	MENUSEL	i112, i113, csel_09C7, cloc_054C
cloc_0542:
	CMD43	i323, i334
	JP	cloc_0542

cloc_054C:
	JTBL	i113
	DW	cloc_0560	; 0
	DW	cloc_0558	; 1
	DW	cloc_0560	; 2
	DW	cloc_0558	; 3

cloc_0558:
	TBCLOSE	10
	JP	cloc_03F4

cloc_0560:
	SUBI	i112, 1
	TBCLOSE	10
	TBCLOSE	9
	JTBL	i112
	DW	cloc_05B1	; 0
	DW	cloc_05C7	; 1
	DW	cloc_05DD	; 2
cstr_0578:
	DS	"セーブしました。", 1, 0
cstr_058A:
	DS	"ファイル１に", 0
cstr_0597:
	DS	"ファイル２に", 0
cstr_05A4:
	DS	"ファイル３に", 0

cloc_05B1:
	REGFSAV	0, cfile_0A67	; SAVE_F1.lsp
	PRINT	0, cstr_058A
	PRINT	0, cstr_0578
	JP	cloc_03C6

cloc_05C7:
	REGFSAV	0, cfile_0A74	; SAVE_F2.lsp
	PRINT	0, cstr_0597
	PRINT	0, cstr_0578
	JP	cloc_03C6

cloc_05DD:
	REGFSAV	0, cfile_0A81	; SAVE_F3.lsp
	PRINT	0, cstr_05A4
	PRINT	0, cstr_0578
	JP	cloc_03C6

cloc_05F3:
	FILETM	i113, s3, cfile_0A67	; SAVE_F1.lsp
	FILETM	i114, s4, cfile_0A74	; SAVE_F2.lsp
	FILETM	i115, s5, cfile_0A81	; SAVE_F3.lsp
	MOVR	i112, i113
	ADDR	i112, i114
	ADDR	i112, i115
	CMD3F	i325, i335
	JTBL	i112
	DW	cloc_03F4	; 0
	DW	cloc_062F	; 1
	DW	cloc_064B	; 2
	DW	cloc_0667	; 3

cloc_062F:
	TBOPEN	10, 20, 12, 19, 3, 1
	CMD6A	496, 208, 607, 223
	JP	cloc_067F

cloc_064B:
	TBOPEN	10, 20, 12, 19, 4, 1
	CMD6A	496, 208, 607, 239
	JP	cloc_067F

cloc_0667:
	TBOPEN	10, 20, 12, 19, 5, 1
	CMD6A	496, 208, 607, 255
cloc_067F:
	STRCLR	s6
	STRCLR	s7
	STRCLR	s8
	CHRDLY	i1000
	CMPI	i113, 0
	JEQ	cloc_06AB
	STRCPYI	s6, cstr_0A34
	STRCAT	s6, s3
	STRCPYI	s6, cstr_0A5E
cloc_06AB:
	CMPI	i114, 0
	JEQ	cloc_06C7
	STRCPYI	s7, cstr_0A42
	STRCAT	s7, s4
	STRCPYI	s7, cstr_0A5E
cloc_06C7:
	CMPI	i115, 0
	JEQ	cloc_06E3
	STRCPYI	s8, cstr_0A50
	STRCAT	s8, s5
	STRCPYI	s8, cstr_0A5E
cloc_06E3:
	PRINT	10, cstr_0A60
	CHRDLY	i352
	JTBL	i112
	DW	cloc_0735	; 0
	DW	cloc_06F9	; 1
	DW	cloc_0707	; 2
	DW	cloc_0715	; 3

cloc_06F9:
	MENUSEL	i118, i117, csel_09FB, cloc_0729
	JP	cloc_071F

cloc_0707:
	MENUSEL	i118, i117, csel_09F1, cloc_0729
	JP	cloc_071F

cloc_0715:
	MENUSEL	i118, i117, csel_09E7, cloc_0729
cloc_071F:
	CMD43	i325, i335
	JP	cloc_071F

cloc_0729:
	JTBL	i117
	DW	cloc_073D	; 0
	DW	cloc_0735	; 1
	DW	cloc_073D	; 2
	DW	cloc_0735	; 3

cloc_0735:
	TBCLOSE	10
	JP	cloc_03F4

cloc_073D:
	TBCLOSE	10
	TBCLOSE	9
	SUBI	i118, 1
	MOVI	i0, 0
	JTBL	i113
	DW	cloc_0769	; 0
	DW	cloc_0759	; 1

cloc_0759:
	SUBI	i118, 1
	CMPI	i0, 0
	JNE	cloc_078B
cloc_0769:
	JTBL	i114
	DW	cloc_0781	; 0
	DW	cloc_0771	; 1

cloc_0771:
	SUBI	i118, 1
	CMPI	i0, 0
	JNE	cloc_0795
cloc_0781:
	REGFLD	0, cfile_0A81	; SAVE_F3.lsp
	JP	cloc_0440

cloc_078B:
	REGFLD	0, cfile_0A67	; SAVE_F1.lsp
	JP	cloc_0440

cloc_0795:
	REGFLD	0, cfile_0A74	; SAVE_F2.lsp
	JP	cloc_0440

cloc_079F:
	CMD3F	i336, i0
	TBOPEN	10, 31, 13, 8, 3, 1
	CHRDLY	i1000
	PRINT	10, cstr_07DF
	CHRDLY	i352
	CMD6A	544, 224, 575, 239
	MENUSEL	i112, i113, csel_07EC, cloc_0802
cloc_07D5:
	CMD43	i336, i0
	JP	cloc_07D5

cstr_07DF:
	DS	"　小　　大　", 0
csel_07EC:
	DW	1, 512, 224, 560, 240
	DW	2, 560, 224, 608, 240
	DW	0

cloc_0802:
	TBCLOSE	10
	JTBL	i113
	DW	cloc_0816	; 0
	DW	cloc_0812	; 1
	DW	cloc_0816	; 2
	DW	cloc_0812	; 3

cloc_0812:
	JP	cloc_03F4

cloc_0816:
	SUBI	i112, 1
	JTBL	i112
	DW	cloc_0824	; 0
	DW	cloc_0838	; 1

cloc_0824:
	MOVI	i352, 1
	CHRDLY	i352
	PRINT	0, cstr_084C
	JP	cloc_03F4

cloc_0838:
	MOVI	i352, 5
	CHRDLY	i352
	PRINT	0, cstr_0874
	JP	cloc_03F4

cstr_084C:
	DS	"メッセージウェイトを＜小＞にしました。", 1, 0
cstr_0874:
	DS	"メッセージウェイトを＜大＞にしました。", 1, 0

cloc_089C:
	CMD3F	i337, i0
	PRINT	0, cstr_093D
	TBOPEN	10, 31, 14, 8, 3, 1
	CHRDLY	i1000
	PRINT	10, cstr_08E2
	CHRDLY	i352
	CMD6A	544, 240, 575, 255
	MENUSEL	i112, i113, csel_08EF, cloc_0905
cloc_08D8:
	CMD43	i337, i0
	JP	cloc_08D8

cstr_08E2:
	DS	" はい いいえ", 0
csel_08EF:
	DW	1, 512, 240, 560, 256
	DW	2, 560, 240, 608, 256
	DW	0

cloc_0905:
	TBCLOSE	10
	JTBL	i113
	DW	cloc_091D	; 0
	DW	cloc_0915	; 1
	DW	cloc_091D	; 2
	DW	cloc_0915	; 3

cloc_0915:
	TBCLEAR	0
	JP	cloc_03F4

cloc_091D:
	SUBI	i112, 1
	JTBL	i112
	DW	cloc_092B	; 0
	DW	cloc_0915	; 1

cloc_092B:
	TBCLOSE	9
	PALFADE	0, 0
	GV02
	BGMFADE
	GV02

cunk_093B:	; unused
	DB	0xFF, 0xFF
cstr_093D:
	DS	"ＤＯＳに戻ります。", 0x0D
	DS	"よろしいですか？", 0
cstr_0961:
	DS	"　 Ｓａｖｅ 　", 0x0D
	DS	"　 Ｌｏａｄ 　", 0x0D
	DS	"　 Ｗａｉｔ 　", 0x0D
	DS	"　 Ｅｘｉｔ 　", 0
csel_099D:
	DW	1, 512, 160, 624, 176
	DW	2, 512, 176, 624, 192
	DW	3, 512, 192, 624, 208
	DW	4, 512, 208, 624, 224
	DW	0
csel_09C7:
	DW	1, 496, 192, 608, 208
	DW	2, 496, 208, 608, 224
	DW	3, 496, 224, 608, 240
	DW	0
csel_09E7:
	DW	3, 336, 240, 608, 256
csel_09F1:
	DW	2, 336, 224, 608, 240
csel_09FB:
	DW	1, 336, 208, 608, 224
	DW	0
cstr_0A07:
	DS	"　ファイル１　", 0x0D
	DS	"　ファイル２　", 0x0D
	DS	"　ファイル３　", 0
cstr_0A34:
	DS	"　ファイル１ ", 0
cstr_0A42:
	DS	"　ファイル２ ", 0
cstr_0A50:
	DS	"　ファイル３ ", 0
cstr_0A5E:
	DS	0x0D, 0
cstr_0A60:
	DS	4, 6, 4, 7, 4, 8, 0
cfile_0A67:
	DB	1, "SAVE_F1.lsp", 0
cfile_0A74:
	DB	1, "SAVE_F2.lsp", 0
cfile_0A81:
	DB	1, "SAVE_F3.lsp", 0
